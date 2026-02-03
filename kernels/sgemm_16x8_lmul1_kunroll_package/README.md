#  LMUL=1 K-unroll=2 


- step `k`  (load B, load A, FMACC)
- step `k+1` (load B, load A, FMACC)

Then a small cleanup loop handles the last odd K.

## Files
- `sgemm_kernel_16x8_zvl256b_lmul1_kunroll2.c` — the unrolled kernel (keeps the same outer structure: N blocks, M blocks, tails).
- `sgemm_kunroll2_bench.c` — small correctness + timing driver.
- `Makefile` — builds on RVV (`-march=rv64gcv_zvl256b`).
- `run.sh` — build + run examples.



