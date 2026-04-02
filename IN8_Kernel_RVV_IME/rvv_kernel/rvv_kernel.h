/* rvv_kernel.h — RVV Mirror of IME kernel. Same API. */
#ifndef RVV_KERNEL_H
#define RVV_KERNEL_H
#include <stdint.h>
typedef long BLASLONG;
#define IME_KR   8
#define MR       8
#define NR       4
int spacemit_rvv_gemm(BLASLONG M, BLASLONG N, BLASLONG K, int32_t alpha,
                      const int8_t *A, const int8_t *B, int32_t *C, BLASLONG ldc);
#endif
