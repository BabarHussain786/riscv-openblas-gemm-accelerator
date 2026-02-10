| Category          | Matrix Size    | Avg GFLOPS | Avg Time (s) | Consolidated Score (%) | Performance Characterization                                    |
| ----------------- | -------------- | ---------: | -----------: | ---------------------: | --------------------------------------------------------------- |
| Square            | 4096³          |      11.83 |        11.62 |               **96.9** | Strong compute-bound behavior; LMUL=2 improves peak utilization |
| FLOP-Equivalent   | 4096×4096×1024 |      10.48 |         3.28 |               **83.5** | Lower B reuse; higher memory pressure reduces overall score     |
| Rectangular       | 4096×1024×4096 |      11.45 |         3.00 |               **96.3** | Excellent memory access pattern; near-ideal balance             |
| Tall-Skinny       | 32768×64×4096  |  **11.96** |     **1.44** |       **100.0 (Best)** | Best case overall; maximum vector reuse and cache efficiency    |
| Short-Wide        | 64×32768×4096  |      10.88 |         1.58 |               **88.4** | Bandwidth pressure on B panels limits performance               |
| K-Scaling (Large) | K = 16384      |      11.20 |        49.78 |               **82.6** | Reduction-heavy; long runtime penalizes consolidated score      |
| M-Scaling (Large) | M = 16384      |      11.31 |        48.60 |               **83.6** | Stable performance; good tile reuse                             |
| N-Scaling (Large) | N = 16384      |      11.34 |        48.48 |               **84.0** | Column-major layout favors kernel; best among scaling cases     |



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
