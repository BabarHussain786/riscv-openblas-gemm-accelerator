#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

typedef long BLASLONG;
typedef float FLOAT;

/* Kernel declaration: LMUL=1 + Unroll×2 PRAGMA */
int sgemm_kernel_16x8_zvl256b_lmul1_opt_unroll2(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc
);

static double now_sec(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

static void fill(float *x, size_t n)
{
    for (size_t i = 0; i < n; i++)
        x[i] = (float)((int)(i % 13) - 6) * 0.1f;
}

int main(int argc, char **argv)
{
    if (argc < 4) {
        printf("Usage: %s M N K\n", argv[0]);
        return 0;
    }

    BLASLONG M = atol(argv[1]);
    BLASLONG N = atol(argv[2]);
    BLASLONG K = atol(argv[3]);

    size_t sizeA = (size_t)M * (size_t)K;
    size_t sizeB = (size_t)N * (size_t)K;
    size_t sizeC = (size_t)M * (size_t)N;

    size_t bytesA = sizeA * sizeof(FLOAT);
    size_t bytesB = sizeB * sizeof(FLOAT);
    size_t bytesC = sizeC * sizeof(FLOAT);

    size_t padA = (bytesA + 63u) & ~((size_t)63u);
    size_t padB = (bytesB + 63u) & ~((size_t)63u);
    size_t padC = (bytesC + 63u) & ~((size_t)63u);

    FLOAT *A = (FLOAT*)aligned_alloc(64, padA);
    FLOAT *B = (FLOAT*)aligned_alloc(64, padB);
    FLOAT *C = (FLOAT*)aligned_alloc(64, padC);

    if (!A || !B || !C) {
        fprintf(stderr, "Allocation failed\n");
        return 1;
    }

    fill(A, sizeA);
    fill(B, sizeB);
    fill(C, sizeC);

    double t0 = now_sec();

    sgemm_kernel_16x8_zvl256b_lmul1_opt_unroll2(
        M, N, K,
        1.0f,
        A,
        B,
        C,
        M
    );

    double t1 = now_sec();

    double time = t1 - t0;

    double gflops =
        (2.0 * (double)M * (double)N * (double)K)
        / (time * 1e9);

    printf("M=%ld N=%ld K=%ld\n", M, N, K);
    printf("Time: %.6f sec\n", time);
    printf("GFLOPS: %.4f\n", gflops);

    free(A);
    free(B);
    free(C);

    return 0;
}
