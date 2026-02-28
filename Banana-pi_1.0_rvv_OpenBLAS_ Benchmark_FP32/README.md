# RVV 1.0 OpenBLAS SGEMM Benchmark (Banana Pi BPI-F3 / Zvl128b)

This repository contains **FP32 SGEMM (single-precision) micro-kernel benchmarks** for **RISC-V RVV 1.0** on **128-bit vector length (Zvl128b)** hardware (e.g., Banana Pi BPI-F3).  
It evaluates the OpenBLAS-style SGEMM kernel and its **fractional LMUL (mf2)** variants, including **pragma-based K-loop unrolling**.

Each variant is runnable standalone using the same structure:
- `sgemm_kernel_8x8_zvl128b.c` (kernel)
- `sgemm_bench.c` (driver)
- `Makefile`
- `run.sh` (runs 4 shapes × 6 times, logs output)

---

## Benchmark Variants (Folders)

Tested and stored these FP32 variants (Zvl128b):

- **OpenBLAS_Baseline_Kernel_FP32**  
  Baseline kernel (no fractional LMUL)

- **OpenBLAS_Baseline_Kernel_FP32_Fractional**  
  Fractional LMUL **mf2** (no pragma unroll)

- **OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll2**  
  Fractional LMUL **mf2** + `#pragma GCC unroll 2`

- **OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll4**  
  Fractional LMUL **mf2** + `#pragma GCC unroll 4`

- **OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll8**  
  Fractional LMUL **mf2** + `#pragma GCC unroll 8`

> Note: Your local `try/try2/try3/...` folders were just examples; the **actual files are the same layout** in each variant folder.

---

## Repository Layout (Per Variant)

Each benchmark folder contains:

- `sgemm_kernel_8x8_zvl128b.c` — SGEMM kernel implementation
- `sgemm_bench.c` — benchmark driver (runs one GEMM and prints time + GFLOPS)
- `Makefile` — builds `bench`
- `run.sh` — runs four shapes, **6 runs each**, saves log automatically
- `best_shapes_*.log` — generated results

---

## How to Clone

```bash
git clone https://github.com/BabarHussain786/riscv-openblas-gemm-accelerator.git
cd riscv-openblas-gemm-accelerator/"Banana-pi_1.0_rvv_OpenBLAS_ Benchmark_FP32"
