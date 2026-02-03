# Threaded + Packed SGEMM benchmark (RVV ZVL256B)

This package benchmarks two RVV micro-kernel variants (**LMUL=1, M=16, N=8**) in a **threaded** outer loop.

## What kernels are inside?
- **Baseline**: `kernel_opt.c` → `sgemm_kernel_16x8_zvl256b_lmul1_opt`
- **K-unroll×2**: `kernel_kunroll2.c` → `sgemm_kernel_16x8_zvl256b_lmul1_kunroll2`

## What the benchmark does
1. Allocates A (MxK), B (KxN), C (MxN) in **column-major**.
2. Packs data into the layout the micro-kernel expects:
   - **A** packed as **(M/16 blocks) × K × 16** (for each k: 16 rows contiguous)
   - **B** packed as **(N/8 panels) × K × 8** (for each k: 8 cols contiguous)
3. Runs the macro-kernel with OpenMP:
   - `#pragma omp parallel for collapse(2)` over `(jpanel, iblock)`
   - Each thread writes a unique C block → no races.
4. Prints time + GFLOPS.

> Tip: Use sizes that are multiples of 16 (M) and 8 (N) to avoid tail overhead.

## Build
```bash
make
```

## Run
```bash
# Optional: set thread count
export OMP_NUM_THREADS=8

./run.sh 2048 2048 2048 10
```
Or run one kernel directly:
```bash
./sgemm_threaded_pack_bench opt 2048 2048 2048 10
./sgemm_threaded_pack_bench kunroll2 2048 2048 2048 10
```
