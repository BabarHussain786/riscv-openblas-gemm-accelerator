<pre>
Vector Register Pressure Map (RVV SGEMM 16x8, LMUL=1)
===================================================

Each box = 1 vector register (vfloat32m1, VL=8 FP32 lanes)
Total registers available: 32

┌──────────────────────── A OPERANDS ────────────────────────┐
│  ┌──────────┐    ┌──────────┐                              │
│  │   A0     │    │   A1     │                              │
│  │ rows 0-7 │    │ rows 8-15│                              │
│  └──────────┘    └──────────┘                              │
│        2 vector registers                                  │
└────────────────────────────────────────────────────────────┘


┌──────────────────── ACCUMULATORS (MAIN PRESSURE) ───────────────────┐
│                                                                      │
│  Top half (rows 0-7):                                                │
│    ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│    │ r0_0 │ │ r1_0 │ │ r2_0 │ │ r3_0 │ │ r4_0 │ │ r5_0 │ │ r6_0 │ │ r7_0 │
│    └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘
│                                                                      │
│  Bottom half (rows 8-15):                                             │
│    ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│    │ r0_1 │ │ r1_1 │ │ r2_1 │ │ r3_1 │ │ r4_1 │ │ r5_1 │ │ r6_1 │ │ r7_1 │
│    └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘
│                                                                      │
│        16 vector registers (dominant pressure)                       │
└──────────────────────────────────────────────────────────────────────┘


┌──────────────────────── SCALAR OPERANDS ────────────────────────────┐
│  B0 ... B7 loaded as FP32 scalars                                   │
│  (no vector registers consumed)                                     │
└──────────────────────────────────────────────────────────────────────┘


SUMMARY
-------
  A operands        :  2 vector registers
  Accumulators      : 16 vector registers
  ------------------------------------
  TOTAL LIVE        : 18 / 32 registers

</pre>

<pre>
Dataflow Diagram: C[16x8] += A[16xK] x B[Kx8]
================================================

Vector length: 8 FP32 lanes (vfloat32m1)

For each K iteration:

            A matrix (vector loads)
            -----------------------
            A0 (rows 0..7)   A1 (rows 8..15)
                 │                 │
                 │                 │
                 ▼                 ▼
           ┌──────────┐     ┌──────────┐
           │ vA0      │     │ vA1      │
           │ (8 lanes)│     │ (8 lanes)│
           └──────────┘     └──────────┘
                 │                 │
                 │                 │
                 └──────┬──────────┘
                        │
                        │   scalar broadcast
                        ▼
B matrix (scalar loads) -------------------------
  B0  B1  B2  B3  B4  B5  B6  B7   (FP32 scalars)
   │   │   │   │   │   │   │   │
   ▼   ▼   ▼   ▼   ▼   ▼   ▼   ▼

Accumulator vectors (live across full K loop)
----------------------------------------------

 Top half (rows 0..7):
   r0_0 = r0_0 + A0 * B0    r1_0 = r1_0 + A0 * B1  ...  r7_0 = r7_0 + A0 * B7

 Bottom half (rows 8..15):
   r0_1 = r0_1 + A1 * B0    r1_1 = r1_1 + A1 * B1  ...  r7_1 = r7_1 + A1 * B7


After K loop completes:
-----------------------
  Accumulators are scaled by alpha and written back to C:

    C[rows 0..7 , col j]  += alpha * rj_0
    C[rows 8..15, col j]  += alpha * rj_1


Key properties:
---------------
- A loaded as vectors (2 vector loads per K)
- B loaded as scalars (8 scalar loads per K)
- 16 vector FMAs per K iteration
- Accumulators stay live for entire K loop
</pre>

<pre>
Combined Kernel View (Diagrams 2–5): RVV SGEMM 16x8, LMUL=1
================================================================

(2) LOOP-NEST STRUCTURE
----------------------
for j = 0 .. N/8-1        // N panels (8 columns each)
 └─ for i = 0 .. M/16-1   // M blocks (16 rows each)
     └─ for k = 0 .. K-1  // reduction (inner, compute-heavy)
         → vector FMAs


(4) MICRO-KERNEL BLOCKING VIEW
------------------------------
C block (16x8) updated per (i,j):

        Columns →
      +----+----+----+----+----+----+----+----+
Rows  | c0 | c1 | c2 | c3 | c4 | c5 | c6 | c7 |
↓     +----+----+----+----+----+----+----+----+
 0-7  | r0_0 r1_0 r2_0 r3_0 r4_0 r5_0 r6_0 r7_0 |
 8-15 | r0_1 r1_1 r2_1 r3_1 r4_1 r5_1 r6_1 r7_1 |

A block : A[16 x K]  → loaded as two vectors (A0, A1)
B block : B[K x 8]   → loaded as scalars (B0..B7)


(3) REGISTER LIFETIME (inside K loop)
-------------------------------------
Time →
k=0        k=1        k=2        ...        k=K-1

A0,A1 :  [ load ] [ load ] [ load ] ... [ load ]   (short-lived)
B*    :  [ load ] [ load ] [ load ] ... [ load ]   (scalar, short-lived)

r*_0,
r*_1 :  [ init ]===============================[ final ]  (long-lived)


(5) TAIL-HANDLING DECISION TREE
-------------------------------
M dimension:
  if M >= 16 → main vector kernel
  else if M & 8 → vector (VL=8)
  else if M & 4 → vector (VL=4)
  else if M & 2 → scalar
  else if M & 1 → scalar

N dimension:
  if N >= 8 → main kernel
  else if N & 4 → reduced vector kernel
  else if N & 2 → reduced vector kernel
  else if N & 1 → vector/scalar kernel


SUMMARY
-------
- Vectorization happens only in inner K loop
- Accumulators live across entire K loop
- Blocking fixed at 16x8 for peak reuse
- Tails handled explicitly for correctness
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







