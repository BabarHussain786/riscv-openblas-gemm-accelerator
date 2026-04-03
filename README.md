# riscv-openblas-gemm-accelerator — Kernel Overview

This document provides a consolidated index of kernel suites in this repository and their tuning intent.

---

## Repository focus

`riscv-openblas-gemm-accelerator` explores GEMM micro-kernel optimization on **RISC-V RVV 1.0** by sweeping implementation parameters such as:

- **LMUL** (vector register grouping),
- **Unrolling factor**, and
- kernel tile shapes (e.g., 16×8, 8×8, 8×4).

The goal is empirical: identify the best-performing variant per datatype and kernel shape under identical benchmark conditions.

---

## Kernel suites

### 1) FP32 SGEMM RVV Vector Kernel 16×8
**Path:** `kernels riscv rvv 1.0/FP32_SGEMM_RVV_Vector_Kernel_16×8`

- Datatype: FP32
- Tile: 16×8
- Focus: LMUL × unrolling tuning for SGEMM
- Typical variants: baseline + `lmul{1,2,4,8}_unroll{1,2,4,8}`

---

### 2) FP32 SGEMM RVV Vector Kernel 8×8
**Path:** `kernels riscv rvv 1.0/FP32_SGEMM_RVV_Vector_Kernel_8×8`

- Datatype: FP32
- Tile: 8×8
- Focus: LMUL × unrolling tuning for SGEMM
- Typical variants: baseline + LMUL/unroll combinations

---

### 3) FP64 Double DGEMM Kernel 8x4
**Path:** `kernels riscv rvv 1.0/FP64_Double_dgemm_kernel_8x4`

- Datatype: FP64
- Tile: 8×4
- Focus: LMUL × unrolling tuning for DGEMM
- Output metric: runtime/GFLOPS across variants

---

### 4) FP64 Double DGEMM Kernel 8x8
**Path:** `kernels riscv rvv 1.0/FP64_Double_dgemm_kernel_8x8`

- Datatype: FP64
- Tile: 8×8
- Focus: LMUL × unrolling tuning for DGEMM
- Output metric: runtime/GFLOPS across variants

---

### 5) IGEMM RVV 8x4 i8i32
**Path:** `kernels riscv rvv 1.0/igemm_rvv_8x4_i8i32`

- Datatype: INT8 inputs with INT32 accumulation/output
- Tile: 8×4
- Focus: LMUL × unrolling tuning for low-precision GEMM
- Output metric: runtime/throughput (e.g., GOPS), stability

---

## Common tuning dimensions

### LMUL
- **LMUL1**: lower register pressure, conservative baseline
- **LMUL2**: moderate vector grouping
- **LMUL4**: higher parallelism with increased pressure
- **LMUL8**: aggressive grouping; may help or regress depending on pressure/cache effects

### Unrolling factor
- **unroll1 / unroll2 / unroll4 / unroll8**
- Higher unroll usually reduces loop overhead and can increase ILP
- Too much unrolling can degrade due to code-size, register pressure, or I-cache effects

---

## Benchmark philosophy

To compare variants fairly:

1. Use identical matrix sizes and iteration counts
2. Pin CPU/core policy consistently (e.g., `taskset -c 0`)
3. Keep compiler/toolchain flags constant
4. Report both **best** and **average** metrics
5. Track run-to-run variance

---

## Typical run flow

```bash
make clean && make
taskset -c 0 ./bench 2048 2048 2048
```

If orchestration exists:

```bash
chmod +x *.sh
./run_all.sh
```

---

## Suggested reporting table format

| Suite | Variant | Best Time | Avg Time | Best GFLOPS/GOPS | Avg GFLOPS/GOPS | Notes |
|------|---------|-----------|----------|------------------|-----------------|-------|
| FP32 16×8 | lmul2_unroll4 | ... | ... | ... | ... | ... |
| FP32 8×8  | lmul4_unroll2 | ... | ... | ... | ... | ... |
| FP64 8×4  | lmul2_unroll4 | ... | ... | ... | ... | ... |
| FP64 8×8  | lmul4_unroll1 | ... | ... | ... | ... | ... |
| i8i32 8×4 | lmul2_unroll8 | ... | ... | ... | ... | ... |

---

## Bottom line

This repository is an RVV micro-kernel tuning framework for SGEMM/DGEMM/IGEMM families, centered on selecting the best **LMUL + unrolling factor** combination per kernel shape and datatype through reproducible benchmarking.
