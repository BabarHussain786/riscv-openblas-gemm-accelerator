/*
 * Packed SGEMM wrapper for baseline RVV kernel
 */

#include <stdlib.h>
#include <string.h>

typedef long  BLASLONG;
typedef float FLOAT;

/* Baseline micro-kernel */
int sgemm_kernel_16x8_zvl256b_lmul1_opt(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc);

/* Packing routine */
void pack_B_8xK(BLASLONG N, BLASLONG K,
                const FLOAT *B, BLASLONG ldb,
                FLOAT *Bp);

int sgemm_kernel_16x8_zvl256b_lmul1_opt_packed(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc)
{
    FLOAT *Bp = (FLOAT *)aligned_alloc(64, (size_t)N * (size_t)K * sizeof(FLOAT));
    if (!Bp) return -1;

    pack_B_8xK(N, K, B, K, Bp);

    int ret = sgemm_kernel_16x8_zvl256b_lmul1_opt(
        M, N, K, alpha, A, Bp, C, ldc);

    free(Bp);
    return ret;
}
