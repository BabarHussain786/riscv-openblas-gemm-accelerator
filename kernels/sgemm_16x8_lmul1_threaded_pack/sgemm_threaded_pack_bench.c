#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <math.h>

#ifdef _OPENMP
#include <omp.h>
#endif

typedef long  BLASLONG;
typedef float FLOAT;

// -----------------------------------------------------------------------------
// Kernel entry points (compiled from kernel_opt.c / kernel_kunroll2.c)
int sgemm_kernel_16x8_zvl256b_lmul1_opt(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc);

int sgemm_kernel_16x8_zvl256b_lmul1_kunroll2(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc);

// -----------------------------------------------------------------------------
// Timing
static inline double now_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

// -----------------------------------------------------------------------------
// Deterministic init (helps reproducibility)
static inline float fhash(int i) {
    // Cheap pseudo-random in [-0.5,0.5]
    uint32_t x = (uint32_t)(i * 2654435761u);
    x ^= x >> 16;
    return ((x & 0xFFFFu) / 65536.0f) - 0.5f;
}

// Column-major matrices:
// A (M x K): A[m + k*lda]
// B (K x N): B[k + n*ldb]
// C (M x N): C[m + n*ldc]

static void fill_col_major_A(float *A, int M, int K, int lda) {
    for (int k = 0; k < K; k++) {
        for (int m = 0; m < M; m++) {
            A[m + k*lda] = fhash(m + 131*k);
        }
    }
}

static void fill_col_major_B(float *B, int K, int N, int ldb) {
    for (int n = 0; n < N; n++) {
        for (int k = 0; k < K; k++) {
            B[k + n*ldb] = fhash(k + 911*n);
        }
    }
}

static void zero_col_major_C(float *C, int M, int N, int ldc) {
    for (int n = 0; n < N; n++) {
        memset(&C[n*ldc], 0, (size_t)M * sizeof(float));
    }
}

// -----------------------------------------------------------------------------
// Packing that matches your micro-kernel layout
//
// A_pack is stored as blocks of 16 rows:
//   block_i = (m0 / 16)
//   A_pack[ block_i*(16*K) + k*16 + r ] = A_orig[(m0 + r) + k*lda]
//
// B_pack is stored as panels of 8 columns:
//   panel_j = (n0 / 8)
//   B_pack[ panel_j*(8*K) + k*8 + c ] = B_orig[k + (n0 + c)*ldb]
//
static void pack_A_16(float *A_pack, const float *A, int M, int K, int lda) {
    const int MB = 16;
    const int blocks = M / MB;
    for (int bi = 0; bi < blocks; bi++) {
        int m0 = bi * MB;
        float *dst_block = A_pack + (size_t)bi * (size_t)(MB * K);
        for (int k = 0; k < K; k++) {
            const float *src_col = A + (size_t)k * (size_t)lda + (size_t)m0;
            float *dst = dst_block + (size_t)k * MB;
            // 16 contiguous rows
            for (int r = 0; r < MB; r++) dst[r] = src_col[r];
        }
    }
}

static void pack_B_8(float *B_pack, const float *B, int K, int N, int ldb) {
    const int NB = 8;
    const int panels = N / NB;
    for (int pj = 0; pj < panels; pj++) {
        int n0 = pj * NB;
        float *dst_panel = B_pack + (size_t)pj * (size_t)(NB * K);
        for (int k = 0; k < K; k++) {
            float *dst = dst_panel + (size_t)k * NB;
            // gather 8 columns from column-major B
            for (int c = 0; c < NB; c++) {
                dst[c] = B[(size_t)k + (size_t)(n0 + c) * (size_t)ldb];
            }
        }
    }
}

// -----------------------------------------------------------------------------
// Threaded compute over (M/16) x (N/8) blocks.
// Each task updates a disjoint 16x8 tile of C, so threading is safe.

typedef int (*kernel_fn_t)(BLASLONG, BLASLONG, BLASLONG, FLOAT, FLOAT*, FLOAT*, FLOAT*, BLASLONG);

static double run_threaded(const char *name, kernel_fn_t kernel,
                           int M, int N, int K, float alpha,
                           const float *A_pack, const float *B_pack,
                           float *C, int ldc,
                           int iters) {
    const int MB = 16;
    const int NB = 8;
    const int mblocks = M / MB;
    const int npanels = N / NB;

    // Warmup
    for (int pj = 0; pj < npanels; pj++) {
        for (int bi = 0; bi < mblocks; bi++) {
            const float *Ap = A_pack + (size_t)bi * (size_t)(MB * K);
            const float *Bp = B_pack + (size_t)pj * (size_t)(NB * K);
            float *Cp = C + (size_t)(pj * NB) * (size_t)ldc + (size_t)(bi * MB);
            kernel(MB, NB, K, alpha, (float*)Ap, (float*)Bp, Cp, ldc);
        }
    }

    double t0 = now_sec();
    for (int it = 0; it < iters; it++) {
#ifdef _OPENMP
#pragma omp parallel for collapse(2) schedule(static)
#endif
        for (int pj = 0; pj < npanels; pj++) {
            for (int bi = 0; bi < mblocks; bi++) {
                const float *Ap = A_pack + (size_t)bi * (size_t)(MB * K);
                const float *Bp = B_pack + (size_t)pj * (size_t)(NB * K);
                float *Cp = C + (size_t)(pj * NB) * (size_t)ldc + (size_t)(bi * MB);
                kernel(MB, NB, K, alpha, (float*)Ap, (float*)Bp, Cp, ldc);
            }
        }
    }
    double t1 = now_sec();

    double time = (t1 - t0) / (double)iters;
    double gflops = (2.0 * (double)M * (double)N * (double)K) / time / 1e9;

#ifdef _OPENMP
    int threads = omp_get_max_threads();
#else
    int threads = 1;
#endif

    printf("%-12s | M=%d N=%d K=%d | threads=%d | %.6f s | %.2f GFLOP/s\n",
           name, M, N, K, threads, time, gflops);

    return gflops;
}

static void usage(const char *argv0) {
    printf("Usage: %s [opt|unroll] M N K [iters]\n", argv0);
    printf("  Note: M must be multiple of 16, N multiple of 8.\n");
#ifdef _OPENMP
    printf("  OpenMP enabled. Set threads via OMP_NUM_THREADS=...\n");
#else
    printf("  OpenMP NOT enabled (compile with -fopenmp for threading).\n");
#endif
}

int main(int argc, char **argv) {
    if (argc < 5) {
        usage(argv[0]);
        return 1;
    }

    const char *which = argv[1];
    int M = atoi(argv[2]);
    int N = atoi(argv[3]);
    int K = atoi(argv[4]);
    int iters = (argc >= 6) ? atoi(argv[5]) : 10;

    if (M <= 0 || N <= 0 || K <= 0 || iters <= 0) {
        fprintf(stderr, "Invalid sizes.\n");
        return 1;
    }
    if ((M % 16) != 0 || (N % 8) != 0) {
        fprintf(stderr, "This benchmark requires M%%16==0 and N%%8==0.\n");
        return 1;
    }

    kernel_fn_t kernel = NULL;
    const char *kname = NULL;
    if (strcmp(which, "opt") == 0) {
        kernel = sgemm_kernel_16x8_zvl256b_lmul1_opt;
        kname = "opt";
    } else if (strcmp(which, "unroll") == 0 || strcmp(which, "kunroll2") == 0) {
        kernel = sgemm_kernel_16x8_zvl256b_lmul1_kunroll2;
        kname = "unroll";
    } else {
        usage(argv[0]);
        return 1;
    }

    // Column-major originals
    int lda = M;
    int ldb = K;
    int ldc = M;

    float *A = (float*)aligned_alloc(64, (size_t)lda * (size_t)K * sizeof(float));
    float *B = (float*)aligned_alloc(64, (size_t)ldb * (size_t)N * sizeof(float));
    float *C = (float*)aligned_alloc(64, (size_t)ldc * (size_t)N * sizeof(float));

    // Packed buffers
    float *A_pack = (float*)aligned_alloc(64, (size_t)M * (size_t)K * sizeof(float));
    float *B_pack = (float*)aligned_alloc(64, (size_t)N * (size_t)K * sizeof(float));

    if (!A || !B || !C || !A_pack || !B_pack) {
        fprintf(stderr, "Allocation failed.\n");
        return 1;
    }

    fill_col_major_A(A, M, K, lda);
    fill_col_major_B(B, K, N, ldb);
    zero_col_major_C(C, M, N, ldc);

    // Pack once (like what OpenBLAS does outside the micro-kernel)
    pack_A_16(A_pack, A, M, K, lda);
    pack_B_8(B_pack, B, K, N, ldb);

    float alpha = 1.0f;

    printf("==============================================================\n");
    printf("Threaded SGEMM micro-kernel benchmark (packed A/B)\n");
    printf("Kernel: %s\n", kname);
    printf("Sizes : M=%d N=%d K=%d\n", M, N, K);
    printf("Iters : %d\n", iters);
#ifdef _OPENMP
    printf("OpenMP: yes\n");
#else
    printf("OpenMP: no\n");
#endif
    printf("==============================================================\n");

    run_threaded(kname, kernel, M, N, K, alpha, A_pack, B_pack, C, ldc, iters);

    // Cheap checksum so compiler can't dead-code eliminate everything
    double sum = 0.0;
    for (int n = 0; n < N; n += (N > 32 ? 17 : 1)) {
        for (int m = 0; m < M; m += (M > 32 ? 13 : 1)) {
            sum += C[m + (size_t)n * (size_t)ldc];
        }
    }
    printf("Checksum: %.6f\n", sum);

    free(A);
    free(B);
    free(C);
    free(A_pack);
    free(B_pack);

    return 0;
}
