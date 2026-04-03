# riscv-openblas-gemm-accelerator — Kernel Overview (FP32 / FP64 / INT8 / IME)

This document provides a consolidated index of kernel suites in this repository and their optimization purpose.

---

## Repository focus

`riscv-openblas-gemm-accelerator` explores GEMM micro-kernel optimization on **RISC-V RVV 1.0** across multiple datatypes and tile shapes by sweeping:

- **LMUL** (vector register grouping),
- **Unrolling factor**, and
- kernel tile configurations (e.g., 16×8, 8×8, 8×4).

Goal: empirically identify the best variant for each datatype/shape under consistent benchmark conditions.

---

## Kernel suite index

### FP32 SGEMM RVV Vector Kernel 16×8
**Path:** `kernels riscv rvv 1.0/FP32_SGEMM_RVV_Vector_Kernel_16×8`  
- Datatype: FP32  
- Tile: 16×8  
- Scope: LMUL × unroll tuning for SGEMM  

### FP32 SGEMM RVV Vector Kernel 8×8
**Path:** `kernels riscv rvv 1.0/FP32_SGEMM_RVV_Vector_Kernel_8×8`  
- Datatype: FP32  
- Tile: 8×8  
- Scope: LMUL × unroll tuning for SGEMM  

### FP64 Double DGEMM Kernel 8x4
**Path:** `kernels riscv rvv 1.0/FP64_Double_dgemm_kernel_8x4`  
- Datatype: FP64  
- Tile: 8×4  
- Scope: LMUL × unroll tuning for DGEMM  

### FP64 Double DGEMM Kernel 8x8
**Path:** `kernels riscv rvv 1.0/FP64_Double_dgemm_kernel_8x8`  
- Datatype: FP64  
- Tile: 8×8  
- Scope: LMUL × unroll tuning for DGEMM  

### IGEMM RVV 8x4 i8i32
**Path:** `kernels riscv rvv 1.0/igemm_rvv_8x4_i8i32`  
- Datatype: INT8 inputs with INT32 accumulation/output  
- Tile: 8×4  
- Scope: LMUL × unroll tuning for integer GEMM  

---

## IME + INT8 acceleration context

This repository also targets an **IME/INT8 acceleration workflow** through low-precision kernel benchmarking and tuning.

- Low-precision compute path: **INT8 × INT8 → INT32 accumulate**
- Optimization knobs: same **LMUL + unroll** exploration method as FP kernels
- Objective: maximize throughput (e.g., GOPS) while preserving stability and repeatability
- Practical use: identify the most efficient integer micro-kernel configuration per hardware target

---

## Common tuning dimensions

### LMUL
- **LMUL1**: conservative, lower register pressure
- **LMUL2**: moderate vector grouping
- **LMUL4**: higher parallelism, higher pressure
- **LMUL8**: aggressive grouping, may improve or regress depending on pressure/cache behavior

### Unrolling factor
- **unroll1 / unroll2 / unroll4 / unroll8**
- Higher unroll often reduces loop overhead and can improve ILP
- Too much unroll can hurt due to code size, register pressure, instruction-cache pressure

---

## Benchmarking methodology (recommended)

1. Keep matrix sizes and iteration count constant
2. Keep compiler/toolchain flags constant
3. Pin execution to fixed cores (e.g., `taskset -c 0`)
4. Collect both **best** and **average** results
5. Track run-to-run variance

---

## Typical run flow

```bash
make clean && make
taskset -c 0 ./bench 2048 2048 2048
```

If scripts exist:

```bash
chmod +x *.sh
./run_all.sh
```

---

## Suggested summary table

| Suite | Datatype | Tile | Best Time | Avg Time | Best Perf (GFLOPS/GOPS) | Avg Perf | Best Variant |
|------|----------|------|-----------|----------|---------------------------|----------|--------------|
| FP32 16×8 | FP32 | 16×8 | ... | ... | ... | ... | ... |
| FP32 8×8  | FP32 | 8×8  | ... | ... | ... | ... | ... |
| FP64 8x4  | FP64 | 8×4  | ... | ... | ... | ... | ... |
| FP64 8x8  | FP64 | 8×8  | ... | ... | ... | ... | ... |
| IGEMM 8x4 i8i32 | INT8→INT32 | 8×4 | ... | ... | ... | ... | ... |

---


