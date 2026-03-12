# Threaded RVV SGEMM Package (LMUL=1, ZVL256B)

This package adds **threading** on top of your baseline micro-kernel:

- Baseline micro-kernel: `sgemm_kernel_16x8_zvl256b_lmul1_opt.c`
- Threaded wrapper: `sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded.c`
- Threaded benchmark: `sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded_benchmark.c`

## What threading does

- The micro-kernel is kept **unchanged**.
- OpenMP parallelizes over independent (16x8) tiles of `C`.
- This increases **total GFLOPS** by using multiple CPU cores.

## Build

```bash
make
```

If your toolchain needs a different march, edit `CFLAGS` in the Makefile.

## Run (threaded)

```bash
chmod +x run_bench_lmul1_threaded.sh
OMP_NUM_THREADS=8 ./run_bench_lmul1_threaded.sh 2048 2048 2048 10 3 0
```

Arguments: `M N K ITERS WARMUP CHECK`

## Run (baseline)

```bash
chmod +x run_bench_lmul1.sh
./run_bench_lmul1.sh 2048 2048 2048 10 3 0
```
