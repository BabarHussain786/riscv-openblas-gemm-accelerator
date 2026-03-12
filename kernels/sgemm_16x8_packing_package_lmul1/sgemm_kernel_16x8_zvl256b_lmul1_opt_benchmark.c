
// sgemm_kernel_16x8_zvl256b_lmul1_opt_benchmark.c
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

typedef long BLASLONG;
typedef float FLOAT;

// Kernel function (this package)
int sgemm_kernel_16x8_zvl256b_lmul1_opt(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc
);

static inline double now_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

static void fill_deterministic(float *x, size_t n, uint32_t seed) {
    // small deterministic LCG, stable across runs
    uint32_t s = seed ? seed : 1u;
    for (size_t i = 0; i < n; i++) {
        s = 1664525u * s + 1013904223u;
        // map to [-0.5, 0.5]
        x[i] = ((float)(s & 0xFFFFu) / 65535.0f) - 0.5f;
    }
}

static double max_abs_diff(const float *a, const float *b, size_t n) {
    double m = 0.0;
    for (size_t i = 0; i < n; i++) {
        double d = fabs((double)a[i] - (double)b[i]);
        if (d > m) m = d;
    }
    return m;
}

// Reference GEMM for correctness (same packed layout as kernel):
// A: K blocks of M (A[k*M + i])
// B: K blocks of N (B[k*N + j])
// C: column-major (ldc = M), consistent with kernel writeback C[j*ldc + i]
static void ref_gemm(BLASLONG M, BLASLONG N, BLASLONG K,
                     float alpha, const float *A, const float *B,
                     float *C, BLASLONG ldc)
{
    for (BLASLONG j = 0; j < N; j++) {
        for (BLASLONG i = 0; i < M; i++) {
            double acc = 0.0;
            for (BLASLONG k = 0; k < K; k++) {
                acc += (double)A[(size_t)k*(size_t)M + (size_t)i] *
                       (double)B[(size_t)k*(size_t)N + (size_t)j];
            }
            C[(size_t)j*(size_t)ldc + (size_t)i] += alpha * (float)acc;
        }
    }
}

static void run_case(BLASLONG M, BLASLONG N, BLASLONG K, int iters, int check)
{
    const float alpha = 1.0f;
    const BLASLONG ldc = M;

    size_t sizeA = (size_t)M * (size_t)K;
    size_t sizeB = (size_t)N * (size_t)K;
    size_t sizeC = (size_t)ldc * (size_t)N;

    // posix_memalign for alignment-friendly RVV loads/stores
    float *A = NULL, *B = NULL, *C = NULL, *Cref = NULL;
    if (posix_memalign((void**)&A, 64, sizeA * sizeof(float)) != 0) exit(1);
    if (posix_memalign((void**)&B, 64, sizeB * sizeof(float)) != 0) exit(1);
    if (posix_memalign((void**)&C, 64, sizeC * sizeof(float)) != 0) exit(1);
    if (check) {
        if (posix_memalign((void**)&Cref, 64, sizeC * sizeof(float)) != 0) exit(1);
    }

    fill_deterministic(A, sizeA, 123u);
    fill_deterministic(B, sizeB, 456u);
    fill_deterministic(C, sizeC, 789u);
    if (check) memcpy(Cref, C, sizeC * sizeof(float));

    // Warm-up
    sgemm_kernel_16x8_zvl256b_lmul1_opt(M, N, K, alpha, A, B, C, ldc);

    double t0 = now_sec();
    for (int r = 0; r < iters; r++) {
        sgemm_kernel_16x8_zvl256b_lmul1_opt(M, N, K, alpha, A, B, C, ldc);
    }
    double t1 = now_sec();

    double sec = (t1 - t0) / (double)iters;

    // GFLOPS for GEMM: 2*M*N*K
    double flops = 2.0 * (double)M * (double)N * (double)K;
    double gflops = (flops / sec) / 1e9;

    // Rough bytes moved (lower bound): read A+B, read+write C
    // This ignores cache reuse and is only a simple metric.
    double bytes = (double)(sizeA + sizeB) * 4.0 + (double)(sizeC) * 4.0 * 2.0;
    double gbs = (bytes / sec) / 1e9;

    printf("M=%ld N=%ld K=%ld | %.6f s | %.2f GFLOP/s | %.2f GB/s\n",
           (long)M, (long)N, (long)K, sec, gflops, gbs);

    if (check) {
        ref_gemm(M, N, K, alpha, A, B, Cref, ldc);
        double err = max_abs_diff(C, Cref, sizeC);
        printf("  check: max_abs_diff = %.3e\n", err);
    }

    free(A); free(B); free(C);
    if (Cref) free(Cref);
}

static void usage(const char *argv0) {
    printf("Usage:\n");
    printf("  %s M N K [iters=30] [check=0|1]\n", argv0);
    printf("Example:\n");
    printf("  %s 2048 2048 2048 10 0\n", argv0);
}

int main(int argc, char **argv)
{
    if (argc < 4) {
        usage(argv[0]);
        return 1;
    }

    BLASLONG M = atol(argv[1]);
    BLASLONG N = atol(argv[2]);
    BLASLONG K = atol(argv[3]);
    int iters = (argc >= 5) ? atoi(argv[4]) : 30;
    int check = (argc >= 6) ? atoi(argv[5]) : 0;

    if (M <= 0 || N <= 0 || K <= 0 || iters <= 0) {
        fprintf(stderr, "Invalid arguments.\n");
        return 1;
    }

    run_case(M, N, K, iters, check);
    return 0;
}
