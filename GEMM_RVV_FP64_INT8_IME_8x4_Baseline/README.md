# FP-INT-IME Optimizations 8x4 Baseline (RISC-V RVV 1.0)

This repository contains 8x4 GEMM micro-kernel families for heterogeneous RISC-V benchmarking on the SpacemiT K1 platform:

- FP64 RVV DGEMM kernels
- INT8 RVV kernels with INT32 accumulation
- IME INT8 kernels with matched RVV fallback and scalar backup

The active benchmark flow compares RVV execution and IME acceleration under the same INT8 x INT8 -> INT32 mathematical workload.

## Repository Layout

- `FP64_Double_dgemm_kernel_8x4/` : FP64 RVV DGEMM kernel variants and benchmark sources.
- `igemm_rvv_8x4_i8i32/` : INT8 RVV kernel variants across LMUL and unroll settings.
- `IME_KERNEL_8x4_WITH_RVV_AND_SCALAR_FALLBACK/` : active IME kernel variants. On IME-capable cores the VMADOT path is used; on non-IME cores the matched RVV fallback is used; scalar code is retained only as a safety backup.
- `benchmarking_options/` : optional campaign scripts for focused FP64, INT8, IME, and merged runs.
- `run_single_core_0_7_all_kernels_1024.sh` : main per-core benchmark launcher for cores 0--7.
- `extra/` : archived generated outputs, benchmark result folders, and legacy experimental variants not used by the main launcher.

## Build and Run

Requirements:

- RISC-V toolchain with RVV support
- `make`
- optional: `taskset` for CPU pinning

Main single-core benchmark sweep:

```bash
./run_single_core_0_7_all_kernels_1024.sh
```

Optional benchmark campaigns:

```bash
./benchmarking_options/run_all_fp_int_ime_1024.sh
./benchmarking_options/run_fp64_real_perf_1024.sh
./benchmarking_options/run_int8_real_perf_1024.sh
./benchmarking_options/run_ime_real_perf_1024.sh
./benchmarking_options/quick_check_fp_int_ime.sh
```

## Notes

- Cores 0--3 are treated as the RVV-IME execution domain.
- Cores 4--7 are treated as the RVV execution domain.
- The main IME folder preserves the same precision across paths: INT8 inputs with INT32 accumulation/output.
- Generated runtime artifacts and historical result folders are kept under `extra/` for local reference and are not required to run the benchmark suite.
## INT8 LMUL legality note

The RVV INT8 kernels use legal widening chains for INT8 x INT8 -> INT32 accumulation. The fully vector-widened legal chains are mf8 -> mf4 -> mf2, mf4 -> mf2 -> m1, mf2 -> m1 -> m2, m1 -> m2 -> m4, and m2 -> m4 -> m8. True vector-widened m4 or m8 input chains would require illegal INT32 accumulator LMULs beyond m8, so the lmul4 and lmul8 variants use true e8,m4 / e8,m8 input loads followed by scalar INT32 accumulation.
