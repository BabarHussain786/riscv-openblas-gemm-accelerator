// sgemm_kernel_64x2_zvl256b_lmul8_benchmark.c
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>

typedef long  BLASLONG;
typedef float FLOAT;

int sgemm_kernel_64x2_zvl256b_lmul8(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc
);

static inline double get_time_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

static void *aligned_malloc_64(size_t size) {
    void *ptr = NULL;
    int rc = posix_memalign(&ptr, 64, size);
    if (rc != 0) { errno = rc; return NULL; }
    return ptr;
}

static void calculate_metrics(BLASLONG M, BLASLONG N, BLASLONG K, double time,
                              double *gflops, double *gbs, double *intensity,
                              double *vec_eff, double *tail_overhead) {
    *gflops = (2.0 * (double)M * (double)N * (double)K) / (time * 1e9);

    double bytes = ((double)M*(double)K + (double)K*(double)N + 2.0*(double)M*(double)N) * (double)sizeof(FLOAT);
    *gbs = bytes / (time * 1e9);
    *intensity = (2.0 * (double)M * (double)N * (double)K) / bytes;

    BLASLONG vb_M = (M / 64) * 64;
    BLASLONG vb_N = (N / 2) * 2;
    BLASLONG vec_elements = vb_M * vb_N;
    BLASLONG total = M * N;

    *vec_eff = (total > 0) ? (double)vec_elements / (double)total * 100.0 : 0.0;
    *tail_overhead = 100.0 - *vec_eff;
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        fprintf(stderr, "Usage: %s M N K [alpha] [warmup] [iterations]\n", argv[0]);
        fprintf(stderr, "Default: alpha=1.0 warmup=5 iterations=20\n");
        return 1;
    }

    BLASLONG M = atol(argv[1]);
    BLASLONG N = atol(argv[2]);
    BLASLONG K = atol(argv[3]);
    FLOAT alpha = (argc > 4) ? (FLOAT)atof(argv[4]) : 1.0f;
    int warmup = (argc > 5) ? atoi(argv[5]) : 5;
    int iters  = (argc > 6) ? atoi(argv[6]) : 20;
    BLASLONG ldc = M;

    if (M <= 0 || N <= 0 || K <= 0) {
        fprintf(stderr, "Error: M,N,K must be >0\n");
        return 1;
    }

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

    for (size_t i = 0; i < (size_t)M * (size_t)K; i++) A[i] = (FLOAT)((i % 97) / 10.0f + 1.0f);
    for (size_t i = 0; i < (size_t)K * (size_t)N; i++) B[i] = (FLOAT)((i % 89) / 7.0f  + 1.0f);

    for (int i = 0; i < warmup; i++) {
        memset(C, 0, sizeC);
        sgemm_kernel_64x2_zvl256b_lmul8(M, N, K, alpha, A, B, C, ldc);
    }

    double total = 0.0, min_t = 1e9, max_t = 0.0;

    for (int i = 0; i < iters; i++) {
        memset(C, 0, sizeC);
        double t0 = get_time_sec();
        sgemm_kernel_64x2_zvl256b_lmul8(M, N, K, alpha, A, B, C, ldc);
        double t1 = get_time_sec();
        double dt = t1 - t0;

        total += dt;
        if (dt < min_t) min_t = dt;
        if (dt > max_t) max_t = dt;
    }

    double avg = total / (double)iters;

    double gflops, gbs, intensity, vec_eff, tail_overhead;
    calculate_metrics(M, N, K, avg, &gflops, &gbs, &intensity, &vec_eff, &tail_overhead);

    const char *bound = (intensity > 10.0) ? "COMPUTE" : (intensity < 2.0) ? "MEMORY" : "BALANCED";

    printf("%ld %ld %ld %.6f %.2f %.2f %.2f %.1f %.1f %s\n",
           M, N, K, avg, gflops, gbs, intensity, vec_eff, tail_overhead, bound);

    free(A); free(B); free(C);
    return 0;
}
