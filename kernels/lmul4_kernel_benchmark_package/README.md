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

Kernel-3 scales the baseline 16×8 design to LMUL=4 by doubling the row dimension and halving the column dimension to maximize vector utilization while remaining register-safe
