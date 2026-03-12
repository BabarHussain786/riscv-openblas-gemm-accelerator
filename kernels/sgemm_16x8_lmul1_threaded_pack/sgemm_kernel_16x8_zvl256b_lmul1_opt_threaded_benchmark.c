// sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded_benchmark.c
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

#ifdef _OPENMP
  #include <omp.h>
#endif

typedef long BLASLONG;
typedef float FLOAT;

// Threaded kernel function (this package)
int sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc
);

static inline double now_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

static void fill_deterministic(float *x, size_t n, uint32_t seed) {
    uint32_t s = seed ? seed : 1u;
    for (size_t i = 0; i < n; i++) {
        s = 1664525u * s + 1013904223u;
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

// Reference GEMM for correctness.
// NOTE: This matches the BASELINE benchmark's conceptual layout and C layout.
// If you use a different packer, keep ref consistent.
static void ref_gemm(BLASLONG M, BLASLONG N, BLASLONG K,
                     float alpha, const float *A, const float *B,
                     float *C, BLASLONG ldc)
{
    for (BLASLONG j = 0; j < N; j++) {
        for (BLASLONG i = 0; i < M; i++) {
            double acc = 0.0;
            for (BLASLONG k = 0; k < K; k++) {
                // A and B are treated as packed-but-flat buffers here.
                // For strict kernel-layout validation, keep your baseline reference.
                acc += (double)A[(size_t)i*(size_t)K + (size_t)k] *
                       (double)B[(size_t)j*(size_t)K + (size_t)k];
            }
            C[(size_t)j*(size_t)ldc + (size_t)i] += alpha * (float)acc;
        }
    }
}

static void run_case(BLASLONG M, BLASLONG N, BLASLONG K,
                     int iters, int warmup, int check)
{
    BLASLONG ldc = M;
    size_t sizeA = (size_t)M * (size_t)K;
    size_t sizeB = (size_t)N * (size_t)K;
    size_t sizeC = (size_t)ldc * (size_t)N;

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
    if (check) {
        memcpy(Cref, C, sizeC * sizeof(float));
        ref_gemm(M, N, K, 1.0f, A, B, Cref, ldc);
    }

    // Warmup
    for (int w = 0; w < warmup; w++) {
        sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded(M, N, K, 1.0f, A, B, C, ldc);
    }

    double t0 = now_sec();
    for (int it = 0; it < iters; it++) {
        sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded(M, N, K, 1.0f, A, B, C, ldc);
    }
    double t1 = now_sec();

    double dt = (t1 - t0) / (double)iters;
    double flops = 2.0 * (double)M * (double)N * (double)K;
    double gflops = (flops / dt) / 1e9;

    int threads = 1;
    #ifdef _OPENMP
      #pragma omp parallel
      {
        #pragma omp master
        threads = omp_get_num_threads();
      }
    #endif

    printf("M=%ld N=%ld K=%ld | threads=%d | time=%.6f s | GFLOPS=%.2f\n",
           (long)M, (long)N, (long)K, threads, dt, gflops);

    if (check) {
        double err = max_abs_diff(C, Cref, sizeC);
        printf("  max_abs_diff(C, Cref) = %.6e\n", err);
    }

    free(A); free(B); free(C);
    if (Cref) free(Cref);
}

int main(int argc, char **argv)
{
    BLASLONG M = 2048, N = 2048, K = 2048;
    int iters = 10;
    int warmup = 3;
    int check = 0;

    if (argc >= 4) {
        M = atol(argv[1]);
        N = atol(argv[2]);
        K = atol(argv[3]);
    }
    if (argc >= 5) iters = atoi(argv[4]);
    if (argc >= 6) warmup = atoi(argv[5]);
    if (argc >= 7) check = atoi(argv[6]);

    printf("=== Threaded RVV SGEMM Benchmark (LMUL=1, ZVL256B) ===\n");
    printf("Kernel: sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded\n");
    #ifdef _OPENMP
      printf("OpenMP: enabled (set OMP_NUM_THREADS)\n");
    #else
      printf("OpenMP: NOT enabled (compile with -fopenmp)\n");
    #endif

    run_case(M, N, K, iters, warmup, check);
    return 0;
}
