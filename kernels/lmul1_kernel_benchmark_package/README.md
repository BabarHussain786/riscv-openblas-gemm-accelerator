Microkernel Computational Block
The optimized RVV SGEMM microkernel employs a register-blocking strategy of $16 \times 8$ elements, implemented as follows:

for (BLASLONG j = 0; j < N/8; j += 1) {         // N-dimension in steps of 8
    for (BLASLONG i = 0; i < M/16; i += 1) {    // M-dimension in steps of 16
        // Load 16 rows of A as two vector registers
        vfloat32m1_t A0 = __riscv_vle32_v_f32m1(&A[0], 8);   // Rows 0-7
        vfloat32m1_t A1 = __riscv_vle32_v_f32m1(&A[8], 8);   // Rows 8-15
        
        // Load and broadcast 8 columns of B elements
        float B0 = B[0], B1 = B[1], B2 = B[2], B3 = B[3];
        float B4 = B[4], B5 = B[5], B6 = B[6], B7 = B[7];
        
        // Initialize 16 accumulator registers (8 columns × 2 vector groups)
        vfloat32m1_t r0_0 = __riscv_vfmul_vf_f32m1(A0, B0, 8);  // Column 0, rows 0-7
        vfloat32m1_t r0_1 = __riscv_vfmul_vf_f32m1(A1, B0, 8);  // Column 0, rows 8-15
        // ... (r1_0, r1_1, ..., r7_0, r7_1 for columns 1-7)
        
        // Depth-wise accumulation over K dimension
        for (BLASLONG k = 1; k < K; k++) {
            // Load next tile of B (8 scalars)
            B0 = B[8*k+0]; B1 = B[8*k+1]; ... B7 = B[8*k+7];
            
            // Load next tile of A (2 vectors)
            A0 = __riscv_vle32_v_f32m1(&A[16*k + 0], 8);
            A1 = __riscv_vle32_v_f32m1(&A[16*k + 8], 8);
            
            // Fused multiply-accumulate operations
            r0_0 = __riscv_vfmacc_vf_f32m1(r0_0, B0, A0, 8);
            r0_1 = __riscv_vfmacc_vf_f32m1(r0_1, B0, A1, 8);
            // ... (7 more columns)
        }
        // Store accumulated results to C matrix
    }}





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

