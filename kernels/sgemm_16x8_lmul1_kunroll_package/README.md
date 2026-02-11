24-Hour Benchmark Methodology (K-Unroll Kernel)

This benchmark evaluates the K-unrolled RVV SGEMM micro-kernel (16×8 FP32, K-unroll×2) under long, sustained execution to obtain stable and statistically reliable performance metrics.

🔹 What runs for 24 hours?
The benchmark repeatedly executes a fixed set of representative matrix sizes in a loop called a cycle.

Each cycle runs:

Square matrix: 4096³
FLOP-equivalent matrix: 4096×4096×1024
Rectangular matrix: 1024×4096×4096
Tall-skinny and short-wide shapes
Cycles repeat continuously until the ~24-hour target runtime is reached.
This ensures the effect of K-loop unrolling is measured under realistic sustained load, not just short bursts.

🔹 How performance is measured
For each test case in every cycle:
Execution time is measured using a monotonic high-resolution timer

GFLOPS is computed as:
GFLOPS = (2 × M × N × K) / execution_time
Results are logged per cycle

After completion:
All cycles are aggregated
Average GFLOPS and execution time are reported
Stability across cycles is verified

🔹 Why 24 hours?

K-unrolling primarily reduces loop overhead and increases instruction reuse.
A long benchmark is required to verify whether these benefits persist under sustained execution or diminish due to memory and pipeline effects.


| Category              | Matrix Size    | Avg GFLOPS | Avg Time (s) | Stability           | Key Observation                                            |
| --------------------- | -------------- | ---------: | -----------: | ------------------- | ---------------------------------------------------------- |
| **Square**            | 4096³          |  **10.07** |        13.65 | Very stable (±1.7%) | Fully compute-bound, consistent but lower peak than LMUL=2 |
| **FLOP-Equivalent**   | 4096×4096×1024 |   **9.76** |         3.52 | Very stable         | Memory pressure limits benefit of unrolling                |
| **Rectangular**       | 1024×4096×4096 |  **10.09** |         3.41 | Very stable         | Good balance, similar to LMUL-1                            |
| **Tall-Skinny**       | 16384×128×4096 |  **10.09** |         1.70 | Extremely stable    | Unrolling helps pipeline, but vector width limits gains    |
| **Short-Wide**        | 128×16384×4096 |  **10.15** |         1.69 | Very stable         | Best case for K-unroll among large shapes                  |
| **N-Scaling (Large)** | N = 16384      |   **9.94** |        55.36 | Stable (±2.5%)      | Long runtime reduces effective unroll benefit              |
| **M-Scaling (Large)** | M = 16384      |   **9.88** |        55.72 | Stable (±2.5%)      | Reduction dominates; unroll impact marginal                |


#  LMUL=1 K-unroll=2 
- step `k`  (load B, load A, FMACC)
- step `k+1` (load B, load A, FMACC)

Then a small cleanup loop handles the last odd K.

## Files
- `sgemm_kernel_16x8_zvl256b_lmul1_kunroll2.c` — the unrolled kernel (keeps the same outer structure: N blocks, M blocks, tails).
- `sgemm_kunroll2_bench.c` — small correctness + timing driver.
- `Makefile` — builds on RVV (`-march=rv64gcv_zvl256b`).
- `run.sh` — build + run examples.



