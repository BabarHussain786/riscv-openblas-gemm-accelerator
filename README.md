# GEMM RVV FP32/FP64 INT8 IME Baselines

This repository contains RISC-V GEMM micro-kernel baselines for FP32 SGEMM, FP64 DGEMM, INT8 iGEMM with int32 accumulation, and SpacemiT IME INT8 GEMM with RVV fallback.

The kernels are organized by tile shape, datatype, backend, vector LMUL setting, and unroll factor. The active folders use a consistent scientific naming scheme; generated outputs and benchmark logs are excluded from Git.

## Repository Layout

```text
.
|-- GEMM_RVV_FP32_INT8_IME_8x4_Baseline
|   |-- RVV_SGEMM_FP32_8x4
|   |-- RVV_IGEMM_INT8_I8I32_8x4
|   `-- IME_GEMM_INT8_I8I32_8x4_RVV_Fallback
|-- GEMM_RVV_FP32_INT8_IME_8x8_Baseline
|   |-- RVV_SGEMM_FP32_8x8
|   |-- RVV_IGEMM_INT8_I8I32_8x8
|   `-- IME_GEMM_INT8_I8I32_8x8_RVV_Fallback
|-- GEMM_RVV_FP64_INT8_IME_8x4_Baseline
|   |-- RVV_DGEMM_FP64_8x4
|   |-- RVV_IGEMM_INT8_I8I32_8x4
|   `-- IME_GEMM_INT8_I8I32_8x4_RVV_Fallback
|-- GEMM_RVV_FP64_INT8_IME_8x8_Baseline
|   |-- RVV_DGEMM_FP64_8x8
|   |-- RVV_IGEMM_INT8_I8I32_8x8
|   `-- IME_GEMM_INT8_I8I32_8x8_RVV_Fallback
`-- run_all_four_single_core_0_7_1024.sh
```

## Running Benchmarks

Run all four baseline groups at the default matrix size `M=N=K=1024`:

```bash
chmod +x run_all_four_single_core_0_7_1024.sh
bash run_all_four_single_core_0_7_1024.sh
```

Optional runtime parameters:

```bash
M=1024 N=1024 K=1024 RUNS=6 CORES="0 1 2 3 4 5 6 7" bash run_all_four_single_core_0_7_1024.sh
```

Each baseline folder also contains:

```text
run_single_core_0_7_all_kernels_1024.sh
```

Those scripts run the kernels in that specific baseline and write local benchmark outputs such as `single_core_results_1024/`.

## Requirements

- RISC-V Linux target with RVV support.
- SpacemiT IME-capable cores for IME kernels.
- Bash, Make, and a C compiler configured for the target system.
- `taskset` is optional; scripts run without it but use it when available.

## Git Hygiene

The root `.gitignore` excludes generated benchmark outputs, logs, compiled binaries, and archived `extra/` folders. Source files, scripts, documentation, and reproducibility helpers in the active baseline folders remain trackable.

## License

MIT License. See `LICENSE`.