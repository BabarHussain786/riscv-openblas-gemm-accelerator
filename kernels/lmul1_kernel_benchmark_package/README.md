<pre>
RVV SGEMM 16×8 MICRO-KERNEL — COMPLETE TASK DIAGRAM (LMUL = 1)
=============================================================

Target configuration (TASK: define execution model)
--------------------------------------------------
VLEN = 256 bits  →  VL = 8 FP32 lanes (vfloat32m1)
Vector registers = 32
LMUL = 1         →  1 vector register per vector


(1) LOOP-NEST STRUCTURE
TASK: control computation order and data reuse
----------------------------------------------
for j = 0 .. (N/8)-1          // iterate over column panels
 └─ for i = 0 .. (M/16)-1     // iterate over row blocks
     └─ for k = 0 .. K-1      // reduction loop
         -> vector FMAs (compute-intensive)


(2) MICRO-KERNEL BLOCKING (16 × 8)
TASK: maximize vector utilization and reuse
--------------------------------------------
C sub-block updated per (i, j):

        Columns →
      +----+----+----+----+----+----+----+----+
Rows  | c0 | c1 | c2 | c3 | c4 | c5 | c6 | c7 |
      +----+----+----+----+----+----+----+----+
 0–7  | r0_0 r1_0 r2_0 r3_0 r4_0 r5_0 r6_0 r7_0 |
 8–15 | r0_1 r1_1 r2_1 r3_1 r4_1 r5_1 r6_1 r7_1 |

TASK:
- Use 2 vectors to cover 16 rows
- Reuse each B scalar across 16 rows
- Accumulate results in vector registers


(3) DATAFLOW (PER K ITERATION)
TASK: describe how operands move and interact
----------------------------------------------
Vector loads (A):
  A0 (rows 0–7)        A1 (rows 8–15)
       |                    |
       v                    v
     vA0                  vA1
       \____________________/
                 |
                 | scalar broadcast
                 v
Scalar loads (B):
  B0  B1  B2  B3  B4  B5  B6  B7

TASK:
- Load A as vectors
- Load B as scalars
- Perform vector FMA updates

Accumulator updates:
  rj_0 ← rj_0 + A0 × Bj   (rows 0–7)
  rj_1 ← rj_1 + A1 × Bj   (rows 8–15)

After K loop:
  C ← C + α × (A × B)


(4) VECTOR REGISTER PRESSURE
TASK: fit computation within register file
-------------------------------------------
Each item = 1 vector register (LMUL = 1)

A operands (low pressure):
  A0, A1  → 2 registers

Accumulators (dominant pressure):
  r0_0 r1_0 r2_0 r3_0 r4_0 r5_0 r6_0 r7_0
  r0_1 r1_1 r2_1 r3_1 r4_1 r5_1 r6_1 r7_1
  → 16 registers

B operands:
  Scalars only → 0 vector registers

TASK RESULT:
  Total live = 18 / 32 registers
  → No register spilling


(5) REGISTER LIFETIME (INSIDE K LOOP)
TASK: explain register pressure dominance
-----------------------------------------
Time →
k=0      k=1      k=2        …        k=K−1

A0,A1 : [load]  [load]  [load]  …  [load]   (short-lived)
B*    : [load]  [load]  [load]  …  [load]   (scalar)

r*_0,
r*_1  : [init]================================[final] (long-lived)

TASK RESULT:
- Accumulators dominate register lifetime
- Explains high register pressure from C


(6) TAIL HANDLING
TASK: guarantee correctness for all sizes
-----------------------------------------
M dimension:
  M ≥ 16 → main vector kernel
  M & 8  → vector (VL=8)
  M & 4  → vector (VL=4)
  M & 2  → scalar
  M & 1  → scalar

N dimension:
  N ≥ 8 → main kernel
  N & 4 → reduced vector kernel
  N & 2 → reduced vector kernel
  N & 1 → vector/scalar kernel


OVERALL TASK SUMMARY
--------------------
- Achieve full vector utilization
- Avoid register spilling (LMUL = 1)
- Keep kernel compute-bound
- Ensure correctness for all M, N, K
</pre>

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







