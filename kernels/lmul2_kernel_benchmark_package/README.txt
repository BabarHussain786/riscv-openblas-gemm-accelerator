| Aspect                    | LMUL=1                  | LMUL=2                  |
| ------------------------- | ----------------------- | ----------------------- |
| **Bytes loaded (M=16)**   | 64 bytes (2 × 32 bytes) | 64 bytes (1 × 64 bytes) |
| **Load instructions**     | 2 instructions          | 1 instruction           |
| **Vector width per load** | 256 bits (VLEN)         | 512 bits (2×VLEN)       |


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
