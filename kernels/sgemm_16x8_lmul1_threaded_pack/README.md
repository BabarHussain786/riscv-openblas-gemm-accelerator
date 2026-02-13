OMP_NUM_THREADS = 1

| Category          | Matrix / Case  | Avg GFLOPS | Avg Time (s) | GFLOPS norm (÷ max) | Time eff (min ÷ t) | Consolidated (%) |
| :---------------- | :------------- | ---------: | -----------: | ------------------: | -----------------: | ---------------: |
| Square            | 4096³          |      10.66 |        12.90 |               0.989 |              0.124 |            72.93 |
| FLOP-Equivalent   | 4096×4096×1024 |      10.25 |         3.35 |               0.951 |              0.475 |            80.77 |
| Rectangular       | 1024×4096×4096 |      10.69 |         3.32 |               0.992 |              0.480 |            83.85 |
| Tall-Skinny       | 16384×128×4096 |      10.51 |         1.65 |               0.976 |              0.967 |            97.32 |
| Short-Wide        | 128×16384×4096 |      10.94 |         1.60 |               1.000 |              1.000 |           100.00 |
| K-Scaling (Large) | K=4096         |      10.64 |        12.83 |               0.987 |              0.124 |            72.85 |
| M-Scaling (Large) | M=4096         |      10.64 |        12.80 |               0.987 |              0.125 |            72.90 |
| N-Scaling (Large) | N=4096         |      10.66 |        12.84 |               0.989 |              0.124 |            72.88 |

OMP_NUM_THREADS = 2

| Category          | Matrix / Case  | Avg GFLOPS | Avg Time (s) | GFLOPS norm (÷ max) | Time eff (min ÷ t) | Consolidated (%) |
| :---------------- | :------------- | ---------: | -----------: | ------------------: | -----------------: | ---------------: |
| Square            | 4096³          |      18.90 |         7.28 |               0.991 |              0.224 |            76.04 |
| FLOP-Equivalent   | 4096×4096×1024 |      18.30 |         1.87 |               0.959 |              0.872 |            98.32 |
| Rectangular       | 1024×4096×4096 |      18.56 |         1.86 |               0.972 |              0.878 |            97.01 |
| Tall-Skinny       | 16384×128×4096 |      18.20 |         0.94 |               0.953 |              1.000 |            96.70 |
| Short-Wide        | 128×16384×4096 |      19.07 |         0.99 |               1.000 |              0.949 |            98.47 |
| K-Scaling (Large) | K=4096         |      18.85 |         7.33 |               0.989 |              0.223 |            75.98 |
| M-Scaling (Large) | M=4096         |      18.84 |         7.35 |               0.988 |              0.222 |            75.93 |
| N-Scaling (Large) | N=4096         |      18.82 |         7.36 |               0.987 |              0.221 |            75.89 |

OMP_NUM_THREADS = 4

| Category          | Matrix / Case  | Avg GFLOPS | Avg Time (s) | GFLOPS norm (÷ max) | Time eff (min ÷ t) | Consolidated (%) |
| :---------------- | :------------- | ---------: | -----------: | ------------------: | -----------------: | ---------------: |
| Square            | 4096³          |      30.10 |         4.57 |               0.986 |              0.214 |            75.48 |
| FLOP-Equivalent   | 4096×4096×1024 |      29.35 |         1.17 |               0.961 |              0.837 |            98.83 |
| Rectangular       | 1024×4096×4096 |      29.55 |         1.17 |               0.968 |              0.840 |            99.16 |
| Tall-Skinny       | 16384×128×4096 |      29.15 |         0.60 |               0.955 |              1.000 |            96.82 |
| Short-Wide        | 128×16384×4096 |      30.53 |         0.64 |               1.000 |              0.938 |            98.15 |
| K-Scaling (Large) | K=4096         |      30.10 |         4.57 |               0.986 |              0.214 |            75.49 |
| M-Scaling (Large) | M=4096         |      30.10 |         4.57 |               0.986 |              0.214 |            75.49 |
| N-Scaling (Large) | N=4096         |      30.10 |         4.57 |               0.986 |              0.214 |            75.49 |

OMP_NUM_THREADS = 8
| Category          | Matrix / Case  | Avg GFLOPS | Avg Time (s) | GFLOPS norm (÷ max) | Time eff (min ÷ t) | Consolidated (%) |
| :---------------- | :------------- | ---------: | -----------: | ------------------: | -----------------: | ---------------: |
| Square            | 4096³          |      43.40 |         3.17 |               0.986 |              0.197 |            74.94 |
| FLOP-Equivalent   | 4096×4096×1024 |      42.70 |         0.80 |               0.970 |              0.777 |            98.22 |
| Rectangular       | 1024×4096×4096 |      42.90 |         0.80 |               0.975 |              0.777 |            98.56 |
| Tall-Skinny       | 16384×128×4096 |      42.10 |         0.40 |               0.957 |              1.000 |            97.05 |
| Short-Wide        | 128×16384×4096 |      44.00 |         0.42 |               1.000 |              0.952 |            98.56 |
| K-Scaling (Large) | K=4096         |      43.40 |         3.17 |               0.986 |              0.197 |            74.94 |
| M-Scaling (Large) | M=4096         |      43.40 |         3.17 |               0.986 |              0.197 |            74.94 |
| N-Scaling (Large) | N=4096         |      43.40 |         3.17 |               0.986 |              0.197 |            74.94 |


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
