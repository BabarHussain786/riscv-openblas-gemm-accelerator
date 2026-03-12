/*
 * pack_b_16x8_fp32.c
 *
 * Packs B matrix into contiguous 8xK panels for RVV SGEMM.
 * Layout:
 *   Bp[(j*8 + jj)*K + k]
 *
 * This matches the access pattern of the 16x8 micro-kernel.
 */

#include <stddef.h>

typedef long  BLASLONG;
typedef float FLOAT;

void pack_B_8xK(BLASLONG N, BLASLONG K,
                const FLOAT *B, BLASLONG ldb,
                FLOAT *Bp)
{
    for (BLASLONG j = 0; j < N; j += 8) {
        BLASLONG jb = (j + 8 <= N) ? 8 : (N - j);
        for (BLASLONG jj = 0; jj < jb; jj++) {
            for (BLASLONG k = 0; k < K; k++) {
                Bp[(j * K) + (jj * K) + k] =
                    B[(j + jj) * ldb + k];
            }
        }
    }
}
