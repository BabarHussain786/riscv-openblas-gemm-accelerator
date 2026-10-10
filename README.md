# RISC-V OpenBLAS GEMM Kernel Studies

This repository contains RVV 1.0 GEMM micro-kernel studies for FP32, FP64, and INT8 data paths. The code is organized to make tile shape, vector register grouping, loop unrolling, and benchmark conditions explicit so that each measurement can be reproduced and compared fairly.

## Research scope

The kernel suites investigate:

- RVV 1.0 vectorization for dense matrix multiplication;
- tile shapes such as 16×8, 8×8, and 8×4;
- LMUL and loop-unroll choices;
- INT8 × INT8 → INT32 accumulation;
- the relationship between instruction-level parallelism, register pressure, cache behavior, and measured throughput.

The results are intended as kernel-level evidence. End-to-end application conclusions require the corresponding packing, scheduling, and output-formation costs to be measured separately.

## Kernel suite index

| Suite | Datatype | Tile | Main question |
|---|---|---:|---|
| `FP32_SGEMM_RVV_Vector_Kernel_16×8` | FP32 | 16×8 | LMUL and unroll behavior for SGEMM |
| `FP32_SGEMM_RVV_Vector_Kernel_8×8` | FP32 | 8×8 | Tile-shape sensitivity for SGEMM |
| `FP64_Double_dgemm_kernel_8x4` | FP64 | 8×4 | Register grouping and unroll behavior for DGEMM |
| `FP64_Double_dgemm_kernel_8x8` | FP64 | 8×8 | Wider output tile behavior for DGEMM |
| `igemm_rvv_8x4_i8i32` | INT8 → INT32 | 8×4 | Low-precision arithmetic and accumulation |

The directory names above are under `kernels riscv rvv 1.0/`.

## Optimization parameters

### LMUL

LMUL controls the number of vector registers assigned to a register group. The measured suites include conservative and wider groupings such as LMUL1, LMUL2, LMUL4, and LMUL8 where supported by the implementation. Larger groups can expose more parallel work but may also increase register pressure and code size.

### Loop unrolling

The benchmark variants include unroll factors such as `unroll1`, `unroll2`, `unroll4`, and `unroll8`. Unrolling can reduce loop overhead and expose instruction-level parallelism, but excessive unrolling can increase register pressure or instruction-cache demand. The best setting is therefore workload- and tile-dependent.

## Measurement protocol

For a defensible comparison, record the following with every result:

1. kernel family, datatype, tile, LMUL, and unroll factor;
2. matrix dimensions and data layout;
3. compiler, version, optimization flags, and source revision;
4. hardware target, VLEN, core affinity, and clock policy;
5. warm-up policy, repetition count, mean, and sample standard deviation;
6. whether input packing, kernel execution, and output formation are included.

Pinning a kernel to a fixed core (for example, `taskset -c 0`) is useful for isolated kernel measurements. It does not replace a matched end-to-end experiment when comparing complete RVV and IME paths.

## Typical build and run flow

Use the build instructions provided by the selected kernel directory. A typical standalone flow is:

```bash
make clean
make
taskset -c 0 ./bench 2048 2048 2048
```

If a directory provides an automation script, make it executable and run that directory's script after checking its documented arguments:

```bash
chmod +x ./*.sh
./run_all.sh
```

## Result provenance

Measured logs and summaries are kept with the relevant kernel or experiment directory, including the `kernels riscv rvv 1.0/` tree and its `summary_results/` outputs. Read each result together with its configuration metadata. This overview intentionally does not invent a single “best” number across different datatypes, tiles, and timing scopes.

## Reproducibility checklist

Before publishing a comparison, archive:

- the exact source revision;
- compiler and linker versions;
- build flags;
- matrix dimensions and alignment assumptions;
- core affinity and runtime environment;
- warm-up and repetition counts;
- raw timing/counter output and the script used to summarize it.

