OMP_NUM_THREADS = 1

| Category          | Requested Case | Closest Case   | Avg GFLOPS | Avg Time (s) | GFLOPS Norm | Time Eff | Consolidated (%) |
| ----------------- | -------------- | -------------- | ---------- | ------------ | ----------- | -------- | ---------------- |
| Square            | 4096³          | 4096³          | 10.77      | 12.76        | 0.986       | 0.121    | 11.97            |
| FLOP-Equivalent   | 4096×4096×1024 | 4096×4096×1024 | 10.27      | 3.35         | 0.940       | 0.463    | 43.52            |
| Rectangular       | 4096×1024×4096 | 1024×4096×4096 | 10.69      | 3.21         | 0.979       | 0.483    | 47.27            |
| Tall-Skinny       | 32768×64×4096  | 16384×128×4096 | 10.81      | 1.59         | 0.990       | 0.975    | 96.51            |
| Short-Wide        | 64×32768×4096  | 128×16384×4096 | 10.90      | 1.55         | 0.998       | 1.000    | 99.82            |
| K-Scaling (Large) | K=16384        | K=4096         | 10.76      | 12.77        | 0.985       | 0.121    | 11.96            |
| M-Scaling (Large) | M=16384        | M=4096         | 10.76      | 12.77        | 0.985       | 0.121    | 11.98            |
| N-Scaling (Large) | N=16384        | N=4096         | 10.76      | 12.77        | 0.985       | 0.121    | 11.97            |



OMP_NUM_THREADS = 2

| Category          | Requested Case | Closest Case   | Avg GFLOPS | Avg Time (s) | GFLOPS Norm | Time Eff | Consolidated (%) |
| ----------------- | -------------- | -------------- | ---------- | ------------ | ----------- | -------- | ---------------- |
| Square            | 4096³          | 4096³          | 13.95      | 9.88         | 0.710       | 0.052    | 3.66             |
| FLOP-Equivalent   | 4096×4096×1024 | 4096×4096×1024 | 17.07      | 2.02         | 0.869       | 0.253    | 21.98            |
| Rectangular       | 4096×1024×4096 | 1024×4096×4096 | 13.85      | 2.48         | 0.705       | 0.206    | 14.50            |
| Tall-Skinny       | 32768×64×4096  | 16384×128×4096 | 13.60      | 1.26         | 0.692       | 0.405    | 28.04            |
| Short-Wide        | 64×32768×4096  | 128×16384×4096 | 14.89      | 1.13         | 0.758       | 0.452    | 34.26            |
| K-Scaling (Large) | K=16384        | K=4096         | 13.89      | 9.93         | 0.707       | 0.051    | 3.64             |
| M-Scaling (Large) | M=16384        | M=4096         | 13.91      | 9.92         | 0.708       | 0.051    | 3.64             |
| N-Scaling (Large) | N=16384        | N=4096         | 13.91      | 9.93         | 0.708       | 0.051    | 3.64             |



OMP_NUM_THREADS = 4

| Category          | Requested Case | Closest Case   | Avg GFLOPS | Avg Time (s) | GFLOPS Norm | Time Eff | Consolidated (%) |
| ----------------- | -------------- | -------------- | ---------- | ------------ | ----------- | -------- | ---------------- |
| Square            | 4096³          | 4096³          | 14.57      | 9.43         | 0.581       | 0.036    | 2.10             |
| FLOP-Equivalent   | 4096×4096×1024 | 4096×4096×1024 | 17.52      | 1.96         | 0.699       | 0.174    | 12.15            |
| Rectangular       | 4096×1024×4096 | 1024×4096×4096 | 13.71      | 2.50         | 0.547       | 0.136    | 7.44             |
| Tall-Skinny       | 32768×64×4096  | 16384×128×4096 | 14.59      | 1.18         | 0.582       | 0.288    | 16.77            |
| Short-Wide        | 64×32768×4096  | 128×16384×4096 | 15.07      | 1.14         | 0.601       | 0.299    | 17.98            |
| K-Scaling (Large) | K=16384        | K=4096         | 14.57      | 9.42         | 0.581       | 0.036    | 2.10             |
| M-Scaling (Large) | M=16384        | M=4096         | 14.57      | 9.42         | 0.581       | 0.036    | 2.10             |
| N-Scaling (Large) | N=16384        | N=4096         | 14.56      | 9.43         | 0.581       | 0.036    | 2.10             |


OMP_NUM_THREADS = 8
| Category          | Requested Case | Closest Case   | Avg GFLOPS | Avg Time (s) | GFLOPS Norm | Time Eff | Consolidated (%) |
| ----------------- | -------------- | -------------- | ---------- | ------------ | ----------- | -------- | ---------------- |
| Square            | 4096³          | 4096³          | 20.05      | 6.86         | 0.777       | 0.048    | 3.74             |
| FLOP-Equivalent   | 4096×4096×1024 | 4096×4096×1024 | 24.47      | 1.40         | 0.948       | 0.236    | 22.36            |
| Rectangular       | 4096×1024×4096 | 1024×4096×4096 | 19.40      | 1.77         | 0.752       | 0.186    | 14.02            |
| Tall-Skinny       | 32768×64×4096  | 16384×128×4096 | 19.89      | 0.86         | 0.771       | 0.384    | 29.61            |
| Short-Wide        | 64×32768×4096  | 128×16384×4096 | 23.16      | 0.74         | 0.898       | 0.447    | 40.14            |
| K-Scaling (Large) | K=16384        | K=4096         | 20.06      | 6.85         | 0.777       | 0.048    | 3.74             |
| M-Scaling (Large) | M=16384        | M=4096         | 20.06      | 6.85         | 0.777       | 0.048    | 3.74             |
| N-Scaling (Large) | N=16384        | N=4096         | 20.04      | 6.86         | 0.777       | 0.048    | 3.74             |



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
