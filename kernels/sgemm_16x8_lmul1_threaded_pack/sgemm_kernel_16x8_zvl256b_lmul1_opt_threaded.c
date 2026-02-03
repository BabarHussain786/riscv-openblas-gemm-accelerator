// sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded.c
// ------------------------------------------------------------
// Threaded wrapper around the existing RVV micro-kernel.
// - Keeps the original micro-kernel unchanged.
// - Parallelizes over (N/8) x (M/16) tiles using OpenMP.
// - Assumes the SAME packed layout as the baseline benchmark:
//
//   A: blocks by M with stride K for each row-block start
//      (tile A pointer for row i0 is A + i0*K)
//   B: blocks by N with stride K for each col-block start
//      (tile B pointer for col j0 is B + j0*K)
//   C: column-major with ldc = M (C[j*ldc + i])
//
// Build with: -fopenmp
// ------------------------------------------------------------

#define _POSIX_C_SOURCE 200809L

#include <stdint.h>
#include <stddef.h>

typedef long  BLASLONG;
typedef float FLOAT;

// Base micro-kernel (compiled from sgemm_kernel_16x8_zvl256b_lmul1_opt.c)
int sgemm_kernel_16x8_zvl256b_lmul1_opt(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT* A, FLOAT* B, FLOAT* C, BLASLONG ldc
);

#ifndef CNAME
#define CNAME sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded
#endif

#ifdef _OPENMP
  #include <omp.h>
#endif

static inline BLASLONG min_bl(BLASLONG a, BLASLONG b) { return (a < b) ? a : b; }

int CNAME(BLASLONG M, BLASLONG N, BLASLONG K,
          FLOAT alpha, FLOAT* A, FLOAT* B, FLOAT* C, BLASLONG ldc)
{
    if (M <= 0 || N <= 0 || K <= 0) return 0;

    // Tile sizes match the micro-kernel main blocks
    const BLASLONG MB = 16;
    const BLASLONG NB = 8;

    // Parallelize across independent C tiles.
    // Each (i0,j0) writes a disjoint C submatrix -> no races.
    #ifdef _OPENMP
    #pragma omp parallel for collapse(2) schedule(static)
    #endif
    for (BLASLONG j0 = 0; j0 < N; j0 += NB) {
        for (BLASLONG i0 = 0; i0 < M; i0 += MB) {

            BLASLONG mblk = min_bl(MB, M - i0);
            BLASLONG nblk = min_bl(NB, N - j0);

            // IMPORTANT: packed pointers consistent with baseline kernel indexing
            FLOAT *Ablk = A + (size_t)i0 * (size_t)K;
            FLOAT *Bblk = B + (size_t)j0 * (size_t)K;
            FLOAT *Cblk = C + (size_t)j0 * (size_t)ldc + (size_t)i0;

            sgemm_kernel_16x8_zvl256b_lmul1_opt(mblk, nblk, K, alpha, Ablk, Bblk, Cblk, ldc);
        }
    }

    return 0;
}
