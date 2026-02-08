// dgemm_kernel_8x8_zvl256b_benchmark.c
// Benchmark driver for FP64 DGEMM kernel (LMUL=1, VLEN=256)

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <stdint.h>
#include <riscv_vector.h>

typedef long  BLASLONG;
typedef double FLOAT; // FP64 - DOUBLE PRECISION

// ---- Kernel function (FP64) ----
int dgemm_kernel_8x8_zvl256b(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc
);

// ---- Timing ----
static inline double get_time_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

// ---- Advanced Metrics (FP64 version) ----
static void calculate_kernel_metrics(BLASLONG M, BLASLONG N, BLASLONG K, double time_sec,
                                     double *gflops, double *gbs, double *intensity,
                                     double *vec_eff, double *tail_overhead) {
    // FLOPs for GEMM: 2*M*N*K
    *gflops = (2.0 * (double)M * (double)N * (double)K) / (time_sec * 1e9);

    // Bytes moved: A + B + 2*C (read+write) - FP64 uses 8 bytes per element
    double bytes = ((double)M*(double)K + (double)K*(double)N + 2.0*(double)M*(double)N) * sizeof(FLOAT);
    *gbs = bytes / (time_sec * 1e9);

    *intensity = (bytes > 0.0) ? (2.0 * (double)M * (double)N * (double)K) / bytes : 0.0;

    // FP64: Perfect tile is 8x8 (not 16x8 like FP32) - each vector holds 4 doubles
    BLASLONG perfect_blocks = (M / 8) * (N / 8);
    BLASLONG perfect_elements = perfect_blocks * 64;  // 8*8 elements
    BLASLONG total_elements = M * N;

    *vec_eff = (total_elements > 0) ? ((double)perfect_elements / (double)total_elements) * 100.0 : 0.0;
    if (*vec_eff > 100.0) *vec_eff = 100.0;
    if (*vec_eff < 0.0) *vec_eff = 0.0;

    *tail_overhead = 100.0 - *vec_eff;
    if (*tail_overhead < 0.0) *tail_overhead = 0.0;
}

// ---- aligned alloc helper ----
static void* aligned_malloc_64(size_t size) {
#if defined(_ISOC11_SOURCE)
    // aligned_alloc requires size multiple of alignment
    size_t aligned_size = (size + 63u) & ~(size_t)63u;
    return aligned_alloc(64, aligned_size);
#else
    void *p = NULL;
    if (posix_memalign(&p, 64, size) != 0) return NULL;
    return p;
#endif
}

// ---- fill helpers (FP64) ----
static void fill_A(FLOAT *A, BLASLONG M, BLASLONG K) {
    // deterministic but non-trivial values - FP64
    for (BLASLONG i = 0; i < M*K; i++) {
        A[i] = (FLOAT)((i % 97) * 0.01 + 1.0); // Double precision
    }
}

static void fill_B(FLOAT *B, BLASLONG K, BLASLONG N) {
    for (BLASLONG i = 0; i < K*N; i++) {
        B[i] = (FLOAT)((i % 89) * 0.013 + 1.0); // Double precision
    }
}

// Optional: touch C to force mapping
static void fill_C_zero(FLOAT *C, BLASLONG M, BLASLONG N) {
    memset(C, 0, (size_t)M*(size_t)N*sizeof(FLOAT));
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        fprintf(stderr, "Usage: %s M N K [alpha] [warmup] [iterations]\n", argv[0]);
        fprintf(stderr, "Default: alpha=1.0, warmup=5, iterations=20\n");
        fprintf(stderr, "Output: M N K time gflops gbs intensity vec_eff tail_overhead bound\n");
        return 1;
    }

    BLASLONG M = atol(argv[1]);
    BLASLONG N = atol(argv[2]);
    BLASLONG K = atol(argv[3]);

    FLOAT alpha = (argc > 4) ? (FLOAT)atof(argv[4]) : 1.0; // FP64 constant
    int warmup = (argc > 5) ? atoi(argv[5]) : 5;
    int iterations = (argc > 6) ? atoi(argv[6]) : 20;

    if (M <= 0 || N <= 0 || K <= 0) {
        fprintf(stderr, "Error: M, N, K must be > 0\n");
        return 1;
    }

    // Kernel uses ci = n_top*ldc + m_top and then C[ci + col*ldc]
    BLASLONG ldc = M;

    size_t sizeA = (size_t)M * (size_t)K * sizeof(FLOAT);
    size_t sizeB = (size_t)K * (size_t)N * sizeof(FLOAT);
    size_t sizeC = (size_t)M * (size_t)N * sizeof(FLOAT);

    FLOAT *A = (FLOAT*)aligned_malloc_64(sizeA);
    FLOAT *B = (FLOAT*)aligned_malloc_64(sizeB);
    FLOAT *C = (FLOAT*)aligned_malloc_64(sizeC);

    if (!A || !B || !C) {
        perror("Allocation failed");
        free(A); free(B); free(C);
        return 1;
    }

    fill_A(A, M, K);
    fill_B(B, K, N);
    fill_C_zero(C, M, N);

    // ---- Warmup ----
    for (int i = 0; i < warmup; i++) {
        fill_C_zero(C, M, N);
        dgemm_kernel_8x8_zvl256b(M, N, K, alpha, A, B, C, ldc);
    }

    // ---- Timed runs ----
    double total_time = 0.0;
    double min_time = 1e100;
    double max_time = 0.0;

    for (int i = 0; i < iterations; i++) {
        fill_C_zero(C, M, N);
        double t0 = get_time_sec();
        dgemm_kernel_8x8_zvl256b(M, N, K, alpha, A, B, C, ldc);
        double t1 = get_time_sec();

        double dt = t1 - t0;
        total_time += dt;
        if (dt < min_time) min_time = dt;
        if (dt > max_time) max_time = dt;
    }

    double avg_time = total_time / (double)iterations;

    // ---- Advanced Metrics (FP64) ----
    double gflops, gbs, intensity, vec_eff, tail_overhead;
    calculate_kernel_metrics(M, N, K, avg_time, &gflops, &gbs, &intensity, &vec_eff, &tail_overhead);

    const char *bound =
        (intensity > 10.0) ? "COMPUTE" :
        (intensity < 2.0)  ? "MEMORY"  :
                             "BALANCED";

    // Same single-line format as your FP32 benchmark:
    // M N K time gflops gbs intensity vec_eff tail_overhead bound
    printf("%ld %ld %ld %.6f %.2f %.2f %.2f %.1f %.1f %s\n",
           M, N, K, avg_time, gflops, gbs, intensity, vec_eff, tail_overhead, bound);

    // Optional: Print min/max times for stability check
    fprintf(stderr, "Timing stats: min=%.6f, max=%.6f, avg=%.6f sec (iterations=%d)\n",
            min_time, max_time, avg_time, iterations);

    free(A);
    free(B);
    free(C);
    return 0;
}