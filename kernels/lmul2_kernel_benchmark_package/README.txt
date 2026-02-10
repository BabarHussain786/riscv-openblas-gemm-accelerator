| Category (large case)  | Matrix / Sweep point | GFLOPS (min → max) | Time (min → max) sec | Interpretation                              |
| ---------------------- | -------------------- | -----------------: | -------------------: | ------------------------------------------- |
| Square (largest)       | **4096³**            |  **11.15 → 11.98** |    **11.48 → 12.33** | Near-peak, compute-bound and stable         |
| FLOP-equivalent large  | **4096×4096×1024**   |  **10.45 → 11.22** |      **3.06 → 3.29** | High throughput, more sensitive than square |
| Rectangular fixed-4096 | **4096×1024×4096**   |  **11.17 → 11.97** |      **2.87 → 3.07** | Best rectangular shape; consistently strong |
| Tall-skinny (large)    | **16384×128×4096**   |  **11.18 → 11.97** |      **1.44 → 1.54** | Very strong; good reuse, low overhead       |
| Short-wide (large)     | **64×32768×4096**    |   **9.82 → 10.88** |      **1.58 → 1.75** | Weaker due to memory / reuse limits         |
| K-scaling (largest)    | **K=16384**          |  **11.01 → 11.82** |    **46.49 → 49.91** | Deep-K sustains high GFLOPS; long runtime   |
| M-scaling (largest)    | **M=16384**          |  **11.19 → 11.98** |    **45.88 → 49.13** | Large-M maintains near-peak performance     |
| N-scaling (largest)    | **N=16384**          |  **11.17 → 11.41** |    **48.19 → 49.21** | Very stable across cycles (good N behavior) |


| Aspect                    | LMUL=1                  | LMUL=2                  |
| ------------------------- | ----------------------- | ----------------------- |
| **Bytes loaded (M=16)**   | 64 bytes (2 × 32 bytes) | 64 bytes (1 × 64 bytes) |
| **Load instructions**     | 2 instructions          | 1 instruction           |
| **Vector width per load** | 256 bits (VLEN)         | 512 bits (2×VLEN)       |

| Aspect                        | LMUL=1 | LMUL=2 |
| ----------------------------- | ------ | ------ |
| **Total bytes loaded from A** | Same   | Same   |
| **Total bytes loaded from B** | Same   | Same   |
| **Total bytes loaded from C** | Same   | Same   |
| **Total bytes stored to C**   | Same   | Same   |


| Aspect               | LMUL=2 Kernel (16×8)            | Reason / Meaning                       |
| -------------------- | ------------------------------- | -------------------------------------- |
| Kernel shape         | **16 × 8**                      | Computes 16 rows × 8 columns per block |
| LMUL                 | **2**                           | Uses 2× vector registers per vector    |
| Vector type          | `vfloat32m2_t`                  | Wider vectors than LMUL=1              |
| Vector length (main) | VL = 16                         | One vector covers all 16 rows          |
| Accumulators         | 8 vector accumulators           | One per output column                  |
| M handling           | 16 → 8 → 4 → 2 → 1              | Full tail support                      |
| N handling           | 8 → 4 → 2 → 1                   | Full tail support                      |
| Arithmetic           | FMA (`vfmacc`)                  | High compute intensity                 |
| Memory pattern       | Reuse A vectors, scalar B       | Cache-friendly                         |
| Role                 | **Optimized variant of LMUL=1** | Tests benefit of larger LMUL           |

LMUL=2 keeps the same 16×8 computation shape as the baseline but uses wider vector registers to increase instruction-level parallelism
