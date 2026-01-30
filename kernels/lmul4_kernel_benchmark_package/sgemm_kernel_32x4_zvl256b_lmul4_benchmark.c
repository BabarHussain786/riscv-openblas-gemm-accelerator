// sgemm_kernel_32x4_zvl256b_lmul4_benchmark.c
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

typedef long BLASLONG;
typedef float FLOAT;

// Kernel function
int sgemm_kernel_32x4_zvl256b_lmul4(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc
);

static inline double get_time_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

static void calculate_kernel_metrics(BLASLONG M, BLASLONG N, BLASLONG K, double time,
                                     double *gflops, double *gbs, double *intensity,
                                     double *vec_eff, double *tail_overhead) {
    *gflops = (2.0 * (double)M * (double)N * (double)K) / (time * 1e9);

    double bytes = ((double)M*(double)K + (double)K*(double)N + 2.0*(double)M*(double)N) * (double)sizeof(FLOAT);
    *gbs = bytes / (time * 1e9);
    *intensity = (2.0 * (double)M * (double)N * (double)K) / bytes;

    // Perfect blocks for this kernel: 32x4
    BLASLONG perfect_blocks = (M / 32) * (N / 4);
    BLASLONG perfect_elements = perfect_blocks * (32 * 4);
    BLASLONG total_elements = M * N;
    *vec_eff = (total_elements > 0) ? ((double)perfect_elements / (double)total_elements) * 100.0 : 0.0;
    *tail_overhead = 100.0 - *vec_eff;
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        fprintf(stderr, "Usage: %s M N K [alpha] [warmup] [iterations]\n", argv[0]);
        fprintf(stderr, "Default: alpha=1.0, warmup=5, iterations=20\n");
        return 1;
    }

    BLASLONG M = atol(argv[1]);
    BLASLONG N = atol(argv[2]);
    BLASLONG K = atol(argv[3]);
    FLOAT alpha = (argc > 4) ? (FLOAT)atof(argv[4]) : 1.0f;
    int warmup = (argc > 5) ? atoi(argv[5]) : 5;
    int iterations = (argc > 6) ? atoi(argv[6]) : 20;
    BLASLONG ldc = M;

    size_t sizeA = (size_t)M * (size_t)K * sizeof(FLOAT);
    size_t sizeB = (size_t)K * (size_t)N * sizeof(FLOAT);
    size_t sizeC = (size_t)M * (size_t)N * sizeof(FLOAT);

    // 64-byte alignment
    FLOAT *A = (FLOAT*)aligned_alloc(64, (sizeA + 63) & ~(size_t)63);
    FLOAT *B = (FLOAT*)aligned_alloc(64, (sizeB + 63) & ~(size_t)63);
    FLOAT *C = (FLOAT*)aligned_alloc(64, (sizeC + 63) & ~(size_t)63);

    if (!A || !B || !C) {
        perror("Allocation failed");
        return 1;
    }

    for (size_t i = 0; i < (size_t)M * (size_t)K; i++) A[i] = (FLOAT)((i % 100) / 10.0f + 1.0f);
    for (size_t i = 0; i < (size_t)K * (size_t)N; i++) B[i] = (FLOAT)((i % 100) / 7.0f + 1.0f);

    // Warmup
    for (int i = 0; i < warmup; i++) {
        memset(C, 0, sizeC);
        sgemm_kernel_32x4_zvl256b_lmul4(M, N, K, alpha, A, B, C, ldc);
    }

    double total_time = 0.0;
    double min_time = 1e9;
    double max_time = 0.0;

    for (int i = 0; i < iterations; i++) {
        memset(C, 0, sizeC);
        double start = get_time_sec();
        sgemm_kernel_32x4_zvl256b_lmul4(M, N, K, alpha, A, B, C, ldc);
        double end = get_time_sec();
        double elapsed = end - start;

        total_time += elapsed;
        if (elapsed < min_time) min_time = elapsed;
        if (elapsed > max_time) max_time = elapsed;
    }

    double avg_time = total_time / (double)iterations;

    double gflops, gbs, intensity, vec_eff, tail_overhead;
    calculate_kernel_metrics(M, N, K, avg_time, &gflops, &gbs, &intensity, &vec_eff, &tail_overhead);

    const char *bound = (intensity > 10.0) ? "COMPUTE" : (intensity < 2.0) ? "MEMORY" : "BALANCED";

    printf("%ld %ld %ld %.6f %.2f %.2f %.2f %.1f %.1f %s\n",
           M, N, K, avg_time, gflops, gbs, intensity, vec_eff, tail_overhead, bound);

    free(A); free(B); free(C);
    return 0;
}
