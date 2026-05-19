# FP32-INT-IME Optimization 8x8 Baseline

This repository contains 8x8 GEMM micro-kernel families for heterogeneous RISC-V benchmarking on the SpacemiT K1 platform:

- FP32 RVV SGEMM kernels
- INT8 RVV kernels with INT32 accumulation
- IME INT8 kernels with matched RVV fallback; scalar backup only if the RVV path fails

The benchmark suite evaluates FP32, INT8 RVV, and IME execution across RVV-IME and RVV execution domains using a common 1024 x 1024 x 1024 GEMM workload by default.

## Repository Layout

- `FP32_SGEMM_RVV_Vector_Kernel_8x8/` : FP32 RVV SGEMM kernel variants and benchmark sources.
- `INT8_iGEMM_8x8/` : INT8 RVV kernel variants across LMUL and unroll settings.
- `IME_KERNEL_8x8_WITH_RVV_FALLBACK/` : active IME INT8 variants. On IME-capable cores the VMADOT path is used; on non-IME cores the matched INT8 RVV fallback is used; scalar code is retained only as a safety backup.
- `benchmarking_options/` : focused benchmark scripts for FP32, INT8, IME, quick checks, and result merging.
- `run_single_core_0_7_all_kernels_1024.sh` : core-wise benchmark launcher for cores 0--7 with raw and summary CSV output.
- `extra/` : archived generated outputs, historical benchmark result folders, and legacy material not required for source builds.

## Build and Run

Requirements:

- RISC-V toolchain with RVV support
- `make`
- optional: `taskset` for CPU pinning

Main benchmark sweep:

```bash
RUN_ON=both AI_CPUSET=0-3 GP_CPUSET=4-7 RUNS=6 M=1024 N=1024 K=1024 ./benchmarking_options/run_all_fp_int_ime_1024.sh
```

Single-core benchmark sweep:

```bash
RUNS=6 M=1024 N=1024 K=1024 ./run_single_core_0_7_all_kernels_1024.sh
```

Quick build/run check:

```bash
M=256 N=256 K=256 ./benchmarking_options/quick_check_fp_int_ime.sh
```

Focused benchmark campaigns:

```bash
./benchmarking_options/run_fp32_real_perf_1024.sh
./benchmarking_options/run_int8_real_perf_1024.sh
./benchmarking_options/run_ime_real_perf_1024.sh
./benchmarking_options/run_ime_ai_vs_gp_1024.sh
./benchmarking_options/merge_fp_int_ime_results.sh
```

## Notes

- Cores 0--3 are treated as the RVV-IME execution domain.
- Cores 4--7 are treated as the RVV execution domain by default in these scripts.
- INT8 RVV and IME paths preserve the same precision model: INT8 inputs with INT32 accumulation/output.
- Cluster-level output is written to `summary_results_1024/`; single-core output is written to `single_core_results_1024/`.
- Generated runtime artifacts and historical result folders are kept out of the active root for GitHub cleanliness.
- `INT8_iGEMM_MF8` is skipped by default in cluster scripts; set `INCLUDE_MF8=1` to include it intentionally.



Note: Active IME variants include LMUL 1 and LMUL 1/2 labels, each with matched INT8 RVV fallback and real VMADOT unroll depths U1/U2/U4/U8.
