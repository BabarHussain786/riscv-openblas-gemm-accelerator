# Option 1 package — LMUL=1 K-unroll=2 (same structure)

This package contains an **unrolled-by-2 in the K loop** version of your `16x8` RVV SGEMM micro-kernel.

## What “K-unroll=2” means here
Inside every `for (k ...)` accumulation loop, we do **two K-steps per iteration**:

- step `k`  (load B, load A, FMACC)
- step `k+1` (load B, load A, FMACC)

Then a small cleanup loop handles the last odd K.

## Files
- `sgemm_kernel_16x8_zvl256b_lmul1_kunroll2.c` — the unrolled kernel (keeps the same outer structure: N blocks, M blocks, tails).
- `sgemm_kunroll2_bench.c` — small correctness + timing driver.
- `Makefile` — builds on RVV (`-march=rv64gcv_zvl256b`).
- `run.sh` — build + run examples.

## Build & run (on your BananaPi K1)
```bash
make
./sgemm_kunroll2_bench 256 256 256 20
```

Or:
```bash
./run.sh
```

## Notes
- The benchmark assumes:
  - A is laid out as `A[k*M + i]` (i.e., packed/contiguous by K panels for M rows),
  - B is laid out as `B[j*K + k]` (packed B panel per output column),
  - C is column-major with leading dimension `ldc = M`.
These match the access pattern used by the kernel you shared.
