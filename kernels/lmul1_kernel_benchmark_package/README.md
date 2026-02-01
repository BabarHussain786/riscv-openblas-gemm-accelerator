Microkernel Computational Block
The optimized RVV SGEMM microkernel employs a register-blocking strategy of $16 \times 8$ elements, implemented as follows:

/**
 * RVV SGEMM Microkernel (LMUL=1, VLEN=256, N=8)
 * Main computational block performing C += α·A·B
 * 
 * Architecture: RISC-V RVV with VLEN=256, SEW=32, LMUL=1
 * Block size: M=16 × N=8 (16 rows, 8 columns)
 * Register usage: 2 A vectors + 8 B scalars + 16 accumulators
 */

/* -----------------------------------------------------------
 * N-dimension: Process in blocks of 8 columns
 * ----------------------------------------------------------- */
for (BLASLONG j = 0; j < N/8; j += 1) {
    
    /* -------------------------------------------------------
     * M-dimension: Process in blocks of 16 rows (2 vectors)
     * ------------------------------------------------------- */
    for (BLASLONG i = 0; i < M/16; i += 1) {
        
        // Pointer arithmetic for packed matrices
        BLASLONG ai = m_top * K;  // A offset: K blocks of M
        BLASLONG bi = n_top * K;  // B offset: K blocks of N
        
        // --- LOAD PHASE: First K iteration ---
        // Load 8 B elements (scalar broadcast to vectors)
        float B0 = B[bi+0], B1 = B[bi+1], B2 = B[bi+2], B3 = B[bi+3];
        float B4 = B[bi+4], B5 = B[bi+5], B6 = B[bi+6], B7 = B[bi+7];
        bi += 8;
        
        // Load 16 A rows as two vector registers (8 elements each)
        vfloat32m1_t A0 = __riscv_vle32_v_f32m1(&A[ai + 0], gvl8);  // Rows 0-7
        vfloat32m1_t A1 = __riscv_vle32_v_f32m1(&A[ai + 8], gvl8);  // Rows 8-15
        ai += 16;
        
        // --- INITIALIZE ACCUMULATORS ---
        // 8 columns × 2 vector groups = 16 accumulator registers
        vfloat32m1_t r0_0 = __riscv_vfmul_vf_f32m1(A0, B0, gvl8);  // Col 0, rows 0-7
        vfloat32m1_t r0_1 = __riscv_vfmul_vf_f32m1(A1, B0, gvl8);  // Col 0, rows 8-15
        
        vfloat32m1_t r1_0 = __riscv_vfmul_vf_f32m1(A0, B1, gvl8);  // Col 1, rows 0-7
        vfloat32m1_t r1_1 = __riscv_vfmul_vf_f32m1(A1, B1, gvl8);  // Col 1, rows 8-15
        
        // ... Columns 2-6 (r2_0/r2_1 through r6_0/r6_1) ...
        
        vfloat32m1_t r7_0 = __riscv_vfmul_vf_f32m1(A0, B7, gvl8);  // Col 7, rows 0-7
        vfloat32m1_t r7_1 = __riscv_vfmul_vf_f32m1(A1, B7, gvl8);  // Col 7, rows 8-15
        
        /* -------------------------------------------------------
         * K-DIMENSION: Depth-wise accumulation loop
         * ------------------------------------------------------- */
        for (BLASLONG k = 1; k < K; k++) {
            
            // Load next 8 B elements
            B0 = B[bi+0]; B1 = B[bi+1]; B2 = B[bi+2]; B3 = B[bi+3];
            B4 = B[bi+4]; B5 = B[bi+5]; B6 = B[bi+6]; B7 = B[bi+7];
            bi += 8;
            
            // Load next 16 A rows
            A0 = __riscv_vle32_v_f32m1(&A[ai + 0], gvl8);
            A1 = __riscv_vle32_v_f32m1(&A[ai + 8], gvl8);
            ai += 16;
            
            // --- FUSED MULTIPLY-ACCUMULATE (FMA) ---
            // Column 0
            r0_0 = __riscv_vfmacc_vf_f32m1(r0_0, B0, A0, gvl8);
            r0_1 = __riscv_vfmacc_vf_f32m1(r0_1, B0, A1, gvl8);
            
            // Column 1
            r1_0 = __riscv_vfmacc_vf_f32m1(r1_0, B1, A0, gvl8);
            r1_1 = __riscv_vfmacc_vf_f32m1(r1_1, B1, A1, gvl8);
            
            // ... Columns 2-6 ...
            
            // Column 7
            r7_0 = __riscv_vfmacc_vf_f32m1(r7_0, B7, A0, gvl8);
            r7_1 = __riscv_vfmacc_vf_f32m1(r7_1, B7, A1, gvl8);
        }
        
        // --- STORE PHASE: Write results to C matrix ---
        BLASLONG ci = n_top * ldc + m_top;
        
        // Column 0
        vfloat32m1_t c0_0 = __riscv_vle32_v_f32m1(&C[ci + 0*ldc + 0], gvl8);
        vfloat32m1_t c0_1 = __riscv_vle32_v_f32m1(&C[ci + 0*ldc + 8], gvl8);
        c0_0 = __riscv_vfmacc_vf_f32m1(c0_0, alpha, r0_0, gvl8);
        c0_1 = __riscv_vfmacc_vf_f32m1(c0_1, alpha, r0_1, gvl8);
        __riscv_vse32_v_f32m1(&C[ci + 0*ldc + 0], c0_0, gvl8);
        __riscv_vse32_v_f32m1(&C[ci + 0*ldc + 8], c0_1, gvl8);
        
        // ... Columns 1-7 ...
        
        // Update M position
        m_top += 16;
    }
    
    // Update N position
    n_top += 8;
}





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

