/*
 * ============================================================================
 *  ime_kernel.h — SpacemiT K1 X60 IME GEMM Micro-Kernel (Header)
 * ============================================================================
 *
 *  This header defines the public API, constants, and types for the
 *  SpacemiT K1 IME-accelerated int8 GEMM micro-kernel.
 *
 *  Hardware target:
 *    SpacemiT K1 SoC with dual-cluster X60 cores
 *    Cluster0 (CPU 0-3): 4× X60·AI cores with IME (Integer Matrix Engine)
 *    Cluster1 (CPU 4-7): 4× X60 cores, standard RVV only
 *    VLEN=256 bits, RVV 1.0, LMUL=1 for IME
 *
 *  What the kernel computes:
 *    C[M×N] += alpha × A[M×K] × B[K×N]
 *
 *  Data types:
 *    A, B : int8_t   (8-bit signed integer inputs)
 *    C    : int32_t  (32-bit signed integer accumulator/output)
 *    alpha: int32_t  (scalar multiplier)
 *
 *  Matrix layouts:
 *    A : column-major — element A(row, k) stored at A[k * M + row]
 *    B : row-major    — element B(k, col) stored at B[k * N + col]
 *    C : column-major — element C(row, col) stored at C[col * ldc + row]
 *
 * ============================================================================
 */

#ifndef IME_KERNEL_H
#define IME_KERNEL_H

#include <stdint.h>

typedef long BLASLONG;

/* ── IME native tile dimensions ─────────────────────────────────────────── */
#define IME_MR   4       /* Rows per single IME 4×4 accumulator            */
#define IME_NR   4       /* Cols per single IME 4×4 accumulator            */
#define IME_KR   8       /* K elements consumed per vmadot (vl=32, e8/m1)  */

/* ── Micro-kernel tile (composed of 2 stacked IME 4×4 tiles) ───────────── */
#define MR       8       /* Rows of output tile (2 × IME_MR)               */
#define NR       4       /* Cols of output tile (1 × IME_NR)               */

/*
 * ── Public API ──────────────────────────────────────────────────────────
 *
 *  spacemit_ime_gemm()
 *    Auto-dispatching GEMM entry point.
 *    - On AI cores (0-3): uses IME vmadot for the main 8×4 tiles
 *    - On GP cores (4-7): uses scalar int32 fallback (same interface)
 *    - Returns 0 on success, -1 on invalid input
 *
 *  Parameters:
 *    M, N, K  — matrix dimensions (any positive value; tails handled)
 *    alpha    — int32 scalar multiplier
 *    A        — pointer to int8 input matrix A (column-major, M rows × K cols)
 *    B        — pointer to int8 input matrix B (row-major, K rows × N cols)
 *    C        — pointer to int32 output matrix C (column-major, M rows × N cols)
 *    ldc      — leading dimension of C (must be >= M)
 */
int spacemit_ime_gemm(
    BLASLONG M, BLASLONG N, BLASLONG K,
    int32_t alpha,
    const int8_t *A, const int8_t *B,
    int32_t *C, BLASLONG ldc);

#endif /* IME_KERNEL_H */
