| Aspect                       | **LMUL=1 BASELINE**          | **LMUL=2**                | **LMUL=4**          | **LMUL=8**       |
| ---------------------------- | ------------------- | ------------------------- | ------------------- | ------------------------- |
| Vector type                  | m1                  | m2                        | m4                  | m8                        |
| FP32 lanes (VLEN=256)        | 8                   | 16                        | 32                  | 64                        |
| Main block (M×N)             | 16×8                | 16×8                      | 32×4                | 64×2                      |
| Algorithm change vs baseline | Baseline            | **Same as LMUL=1**        | Changed blocking    | Strongly changed blocking |
| Accumulators kept live       | 8                   | 8                         | 4                   | 2                         |
| Register pressure            | Low                 | Medium                    | High                | Very high                 |
| N size reason                | Natural             | Natural                   | Reduced to fit regs | **Forced very small**     |
| A reuse across N             | High                | High                      | Medium              | Low                       |
| Tail handling                | Moderate            | Moderate                  | More complex        | Most complex              |
| Compiler freedom             | High                | High                      | Medium              | Low                       |
| Performance stability        | Stable              | **Very stable**           | Shape-dependent     | Unstable / niche          |
| Typical use                  | Reference           | **Best practical kernel** | Experimental tuning | Architecture stress test  |
| Why it exists                | Baseline comparison | Best LMUL upgrade         | Explore higher LMUL | Show LMUL limit effects   |


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
