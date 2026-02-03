**Baseline Kernel — File Description**

| File                                                     | Description                                                                                                                                                                                                                                                |
| -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **sgemm_kernel_16x8_zvl256b.c**                          | The official OpenBLAS baseline SGEMM micro-kernel for RISC-V with RVV (vector length = 256 bits). It implements a **16×8** register-tiled single-precision GEMM compute kernel using RVV intrinsics, serving as the reference for optimized LMUL variants. |
| **sgemm_kernel_16x8_zvl256b_benchmark.c**  | Benchmark driver calls the baseline kernel to measure performance (GFLOPS, memory bandwidth, vector efficiency) for various M/N/K inputs.                                                                                                                  |
| **Makefile**                       | Build recipe for the baseline kernel + benchmark driver.                                                                                                                                                                                                   |
| **run_bench_baseline.sh**                 | Script that runs the baseline kernel in long tests (24h, background, monitoring).                                                                                                                                                                       


| Aspect               | **Baseline Kernel (LMUL=1)** | Reason / Meaning                       |
| -------------------- | ---------------------------- | -------------------------------------- |
| Kernel shape         | **16 × 8**                   | Computes 16 rows × 8 columns per block |
| LMUL                 | **1**                        | Uses minimum vector register grouping  |
| Vector type          | `vfloat32m1_t`               | Narrower vectors                       |
| Vector length (main) | VL = 8                       | Two vectors needed for 16 rows         |
| Accumulators         | 16 vector accumulators       | Split across two halves of M           |
| M handling           | 16 → 8 → 4 → 2 → 1           | Full tail support                      |
| N handling           | 8 → 4 → 2 → 1                | Full tail support                      |
| Arithmetic           | FMA (`vfmacc`)               | Compute-bound design                   |
| Memory pattern       | Reuse A vectors, scalar B    | Optimized for cache                    |
| Role                 | **Reference / baseline**     | Comparison point for LMUL scaling      |

The LMUL=1 kernel is the baseline 16×8 micro-kernel that uses smaller vectors and more instructions, serving as the reference for all LMUL optimizations.

| rank | label          | M     | N     | K    | samples | mean_gflops | mean_time | rel_to_mean |
| ---- | -------------- | ----- | ----- | ---- | ------- | ----------- | --------- | ----------- |
| 1    | M=4096         | 4096  | 4096  | 4096 | 8       | 11.194      | 12.278    | 1.065       |
| 2    | K=8192         | 4096  | 4096  | 8192 | 8       | 11.176      | 24.595    | 1.063       |
| 3    | N=4096         | 4096  | 4096  | 4096 | 8       | 11.164      | 12.313    | 1.062       |
| 4    | N=16384        | 4096  | 16384 | 4096 | 8       | 11.162      | 49.249    | 1.062       |
| 5    | N=8192         | 4096  | 8192  | 4096 | 8       | 11.135      | 24.682    | 1.059       |
| 6    | N=2048         | 4096  | 2048  | 4096 | 8       | 11.135      | 6.171     | 1.059       |
| 7    | K=4096         | 4096  | 4096  | 4096 | 8       | 11.129      | 12.348    | 1.059       |
| 8    | N=1024         | 4096  | 1024  | 4096 | 8       | 11.129      | 3.088     | 1.059       |
| 9    | M=16384        | 16384 | 4096  | 4096 | 8       | 11.126      | 49.412    | 1.058       |
| 10   | M=8192         | 8192  | 4096  | 4096 | 8       | 11.124      | 24.713    | 1.058       |
| 11   | N=512          | 4096  | 512   | 4096 | 8       | 11.121      | 1.545     | 1.058       |
| 12   | 4096×1024×4096 | 4096  | 1024  | 4096 | 8       | 11.115      | 3.091     | 1.057       |
| 13   | 8192×256×4096  | 8192  | 256   | 4096 | 8       | 11.11       | 1.547     | 1.057       |
| 14   | M=2048         | 2048  | 4096  | 4096 | 8       | 11.101      | 6.191     | 1.056       |
| 15   | 32768×64×4096  | 32768 | 64    | 4096 | 8       | 11.094      | 1.548     | 1.055       |
| 16   | 4096³          | 4096  | 4096  | 4096 | 8       | 11.081      | 12.413    | 1.054       |
| 17   | 16384×128×4096 | 16384 | 128   | 4096 | 8       | 11.074      | 1.724     | 1.053       |
| 18   | 4096×4096×1024 | 4096  | 4096  | 1024 | 8       | 10.913      | 3.476     | 1.038       |
| 19   | K=2048         | 4096  | 4096  | 2048 | 8       | 10.857      | 6.175     | 1.033       |
| 20   | 2048³          | 2048  | 2048  | 2048 | 8       | 10.806      | 1.632     | 1.028       |
| 21   | 256×8192×4096  | 256   | 8192  | 4096 | 8       | 9.985       | 1.721     | 0.95        |
| 22   | 128×16384×4096 | 128   | 16384 | 4096 | 8       | 10.1        | 1.702     | 0.961       |
| 23   | M=1024         | 1024  | 4096  | 4096 | 8       | 10.409      | 3.307     | 0.99        |
| 24   | 64×32768×4096  | 64    | 32768 | 4096 | 8       | 10.394      | 1.656     | 0.989       |
| 25   | M=512          | 512   | 4096  | 4096 | 8       | 10.283      | 1.673     | 0.978       |
| 26   | 1792³          | 1792  | 1792  | 1792 | 8       | 10.186      | 1.132     | 0.969       |
| 27   | 3584³          | 3584  | 3584  | 3584 | 8       | 10.118      | 9.114     | 0.962       |
| 28   | 3072³          | 3072  | 3072  | 3072 | 8       | 10.008      | 5.796     | 0.952       |
| 29   | 1024³          | 1024  | 1024  | 1024 | 8       | 10.004      | 0.215     | 0.951       |
| 30   | 1024×4096×4096 | 1024  | 4096  | 4096 | 8       | 10.47       | 3.286     | 0.996       |
| 31   | 2560³          | 2560  | 2560  | 2560 | 8       | 9.794       | 3.426     | 0.932       |
| 32   | 1536³          | 1536  | 1536  | 1536 | 8       | 9.95        | 0.729     | 0.946       |
| 33   | 1280³          | 1280  | 1280  | 1280 | 8       | 9.871       | 0.425     | 0.939       |
| 34   | 4096×4096×1024 | 4096  | 4096  | 1024 | 8       | 9.885       | 3.476     | 0.94        |
| 35   | K=512          | 4096  | 4096  | 512  | 8       | 8.989       | 1.911     | 0.855       |
| 36   | K=256          | 4096  | 4096  | 256  | 8       | 6.891       | 1.247     | 0.655       |



24-Hour Benchmark Summary — LMUL=1 SGEMM 16×8 (Baseline)

| Category                 | Test Range        | GFLOPS (Min) | GFLOPS (Avg) | GFLOPS (Max) | Stability     | Interpretation                            |
| ------------------------ | ----------------- | ------------ | ------------ | ------------ | ------------- | ----------------------------------------- |
| **Square GEMM**          | 1024³ → 4096³     | ~9.6         | **~10.6**    | **11.13**    | Very High     | Near-peak sustained FP32 throughput       |
| **Rectangular GEMM**     | Tall / Wide cases | ~9.8         | **~10.8**    | **11.29**    | Very High     | Kernel handles aspect ratios well         |
| **K-sweep**              | K=256 → 16384     | ~6.8         | **~10.5**    | **11.28**    | High          | Small-K underutilization, large-K optimal |
| **M-sweep**              | M=512 → 16384     | ~9.8         | **~10.9**    | **11.29**    | Very High     | Strong scalability in M dimension         |
| **N-sweep**              | N=512 → 16384     | ~11.0        | **~11.15**   | **11.30**    | Excellent     | Best-performing sweep (ideal blocking)    |
| **All Tests (37 cases)** | 8 cycles × 24h    | **~9.6**     | **~10.9**    | **11.30**    | **Excellent** | Compute-bound, cache-resident GEMM        |

The LMUL=1 16×8 baseline SGEMM kernel sustains ~11 GFLOPS consistently over 24 hours, proving it is compute-bound, stable, and an excellent reference for further RVV optimizations.

