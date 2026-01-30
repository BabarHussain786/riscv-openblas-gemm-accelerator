| Aspect                    | **Baseline (LMUL=1)** | **This Kernel (LMUL=8)**                 |
| ------------------------- | --------------------- | ---------------------------------------- |
| LMUL                      | 1                     | **8**                                    |
| Tile size (M×N)           | **16 × 8**            | **64 × 2**                               |
| Vector type               | `vfloat32m1_t`        | **`vfloat32m8_t`**                       |
| Rows per vector           | 8–16                  | **64 (max for VLEN=256)**                |
| Columns per block         | 8                     | **2 (reduced)**                          |
| Accumulators              | 8 vectors             | **2 vectors**                            |
| Register pressure         | Low                   | **Very high → tightly controlled**       |
| A loads                   | Vector                | **Wide vector (m8)**                     |
| B loads                   | Scalar                | **Scalar (2 values per k)**              |
| Tail handling             | Simple                | **Full M: 32/16/8/4/2/1, N: 1**          |
| Design change vs baseline | —                     | **Maximize M, minimize N to fit LMUL=8** |
This LMUL=8 kernel scales the baseline 16×8 design to a 64×2 micro-kernel, maximizing vector width while aggressively reducing the column dimension to stay within RVV register limits.
