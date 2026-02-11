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

Kernel-3 scales the baseline 16×8 design to LMUL=4 by doubling the row dimension and halving the column dimension to maximize vector utilization while remaining register-safe
