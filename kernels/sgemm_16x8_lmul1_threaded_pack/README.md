# LMUL=1 Optimized RVV SGEMM Micro-Kernel (VLEN=256, N=8)

This folder contains a **self-contained** micro-kernel + benchmark package for:

- **Kernel:** `sgemm_kernel_16x8_zvl256b_lmul1_opt.c`  
- **Benchmark:** `sgemm_kernel_16x8_zvl256b_lmul1_opt_benchmark.c`  
- **Build:** `Makefile`  
- **Run:** `run_bench_lmul1.sh`

## Build
```bash
make
```

## Run
```bash
./run_bench_lmul1.sh
```

## Notes
- Packed layout expected by the kernel (same layout used in the benchmark):
  - `A` is stored as `K` blocks of `M` (so `A[k*M + i]`)
  - `B` is stored as `K` blocks of `N` (so `B[k*N + j]`)
  - `C` is stored column-major with `ldc = M` (so `C[j*ldc + i]`)
- For LMUL=1 on VLEN=256 and FP32 (`SEW=32`), **one vector holds up to 8 floats**.
  So the main **M=16** block is computed as **two vectors (8+8)**.
