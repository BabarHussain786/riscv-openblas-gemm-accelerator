#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

typedef long  BLASLONG;
typedef float FLOAT;

int sgemm_kernel_16x8_zvl256b_lmul1_opt_packed(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc);

static inline double now_sec(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main(int argc, char **argv)
{
    BLASLONG M = 2048, N = 2048, K = 2048;
    BLASLONG ldc = M;

    size_t sizeA = (size_t)M * K;
    size_t sizeB = (size_t)N * K;
    size_t sizeC = (size_t)ldc * N;

    FLOAT *A = aligned_alloc(64, sizeA * sizeof(FLOAT));
    FLOAT *B = aligned_alloc(64, sizeB * sizeof(FLOAT));
    FLOAT *C = aligned_alloc(64, sizeC * sizeof(FLOAT));

    for (size_t i = 0; i < sizeA; i++) A[i] = 1.0f;
    for (size_t i = 0; i < sizeB; i++) B[i] = 1.0f;
    for (size_t i = 0; i < sizeC; i++) C[i] = 0.0f;

    double t0 = now_sec();
    sgemm_kernel_16x8_zvl256b_lmul1_opt_packed(
        M, N, K, 1.0f, A, B, C, ldc);
    double t1 = now_sec();

    double gflops = (2.0 * M * N * K) / (t1 - t0) / 1e9;
    printf("Packed SGEMM GFLOPS: %.2f\n", gflops);

    free(A); free(B); free(C);
    return 0;
}
