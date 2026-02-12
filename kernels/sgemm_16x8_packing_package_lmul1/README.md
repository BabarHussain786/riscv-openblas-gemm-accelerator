# Packing Package – LMUL=1 RVV SGEMM

This package adds **matrix B packing** to the baseline RVV SGEMM kernel:

`sgemm_kernel_16x8_zvl256b_lmul1_opt.c`

## Included Files
- Baseline kernel (unchanged)
- B packing implementation
- Packed SGEMM wrapper
- Standalone benchmark
- Makefile
- Run script

## Goal
Improve cache locality and reduce memory stalls by feeding the micro-kernel
with contiguous 8xK panels of matrix B.

## Build & Run
```bash
make
./run_bench_lmul1_packed.sh
```

## Research Note
This package isolates **packing only**, allowing clean comparison:
Baseline → Unrolled → Threaded → Packed
