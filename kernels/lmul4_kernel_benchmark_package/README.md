| Category             |     Matrix Size | Avg GFLOPS | Avg Time (s) | Notes                                                                  |
| -------------------- | --------------: | ---------: | -----------: | ---------------------------------------------------------------------- |
| Square               |           4096³ |   **8.90** |    **15.52** | Consistently ~8.7–9.2 GFLOPS; slower than LMUL=1/2 due to reg pressure |
| FLOP-Equivalent      |  4096×4096×1024 |   **8.25** |     **4.14** | Lower throughput; larger LMUL increases load/store pressure            |
| Rectangular (B tall) |  1024×4096×4096 |   **8.95** |     **3.86** | Best LMUL=4 shape; better B reuse but still below LMUL=1               |
| Tall-Skinny          | 16384×128×4096¹ |   **8.80** |    **≈1.90** | No benefit from LMUL=4; compute not the limiter here                   |
| Short-Wide           | 128×16384×4096¹ |   **8.90** |    **≈1.95** | Bandwidth-dominated; LMUL increase gives no gain                       |


| Aspect                    | **Baseline (LMUL=1)** | **Kernel-3 (LMUL=4)**                  |
| ------------------------- | --------------------- | -------------------------------------- |
| LMUL                      | 1                     | **4**                                  |
| Tile size                 | **16 × 8**            | **32 × 4**                             |
| Vector type               | `vfloat32m1_t`        | **`vfloat32m4_t`**                     |
| Rows per vector           | 8–16                  | **32**                                 |
| Columns per block         | 8                     | **4 (reduced)**                        |
| Accumulators              | 8 vectors             | **4 vectors**                          |
| Register pressure         | Low                   | **Controlled / safe**                  |
| Vector utilization        | Moderate              | **Higher**                             |
| Design change vs baseline | —                     | **Increase M, reduce N to fit LMUL=4** |

📊 24-Hour Benchmark Methodology (LMUL = 4)

This benchmark evaluates the LMUL=4 RVV SGEMM micro-kernel (32×4 FP32) under long, sustained execution to obtain stable and statistically reliable performance metrics.

🔹 What runs for 24 hours?

The benchmark repeatedly executes a fixed set of representative matrix sizes in a loop called a cycle.
Each cycle runs the same test cases once, then the next cycle starts immediately.

Total runtime target: ~24 hours - Total completed cycles

Each cycle includes:
Square matrix (4096³)
FLOP-equivalent matrix (4096×4096×1024)
Rectangular matrix (1024×4096×4096)
Scaling tests (K, N variants)
This repetition ensures results are not biased by transient system effects (warm-up, cache state, OS noise).

🔹 How performance is measured

For each test case in every cycle:
Execution time is measured using a monotonic high-resolution timer.
GFLOPS is computed as:
GFLOPS = (2 × M × N × K) / execution_time
Results are logged per cycle (GFLOPS + time).
After the 24-hour run:
All cycles are aggregated
Average GFLOPS and average execution time are computed across cycles
Variability is checked to confirm stability

🔹 Why 24 hours?
This is especially important for RISC-V RVV kernels, where vector length, LMUL, and memory pressure interact over time.

-

| Aspect                        | **Baseline (LMUL=1)** | **LMUL=2**               | **K-Unroll (×2)**          | **LMUL=4**                    |
| ----------------------------- | --------------------- | ------------------------ | -------------------------- | ----------------------------- |
| **Kernel shape**              | 16×8 micro-kernel     | 16×8 micro-kernel        | 16×8 micro-kernel          | **32×4 micro-kernel**         |
| **Vector type**               | `vfloat32m1_t`        | `vfloat32m2_t`           | `vfloat32m1_t`             | **`vfloat32m4_t`**            |
| **LMUL setting**              | 1                     | 2                        | 1                          | **4**                         |
| **VL usage**                  | VL = 8 FP32 lanes     | VL = 16 FP32 lanes       | VL = 8 FP32 lanes          | **VL = 32 FP32 lanes**        |
| **Register footprint**        | Low                   | Medium                   | Low                        | **Very high**                 |
| **Accumulator layout**        | 16 rows × 8 cols      | Same as baseline         | Same as baseline           | **32 rows × 4 cols**          |
| **K-loop structure**          | Single FMA per step   | Same loop, wider vectors | **Two FMAs per iteration** | Single FMA, very wide         |
| **Loop unrolling**            | None                  | None                     | **Unroll ×2 in K**         | None                          |
| **Memory access pattern**     | Scalar A, vector B    | Same                     | Same                       | **Wider vector loads**        |
| **Kernel structure changed?** | —                     | ❌ No                     | ❌ No                       | **✅ Yes**                     |
| **Reason for change**         | Baseline reference    | More parallelism         | Hide loop overhead         | **Register pressure control** |


