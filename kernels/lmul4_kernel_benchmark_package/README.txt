LMUL=4 SGEMM Micro-Kernel Benchmark Package (VLEN=256, float32)

Files:
- sgemm_kernel_32x4_zvl256b_lmul4.c
    LMUL=4 kernel, main block 32x4 (chosen to keep v-register usage safe)
- sgemm_kernel_32x4_zvl256b_lmul4_benchmark.c
    Single-run microbenchmark driver (prints one-line metrics)
- Makefile
    Builds sgemm_bench_lmul4 and provides helper targets (24h, monitor, etc.)
- run_bench_lmul4.sh
    24-hour loop runner (interactive/background)

Build:
  make

Quick test:
  ./sgemm_bench_lmul4 1024 1024 1024

24h:
  make 24h
Background:
  make 24h-bg
Monitor:
  make monitor
