# RVV 1.0 OpenBLAS GEMM Benchmark (Banana Pi BPI-F3)

This repository contains optimized SGEMM micro-kernels using the RISC-V Vector Extension (RVV 1.0) with multiple configurations including LMUL scaling and pragma-based loop unrolling. The benchmarks are designed for performance evaluation on RVV-enabled processors such as the Banana Pi BPI-F3.

Each kernel variant is provided with its own benchmark driver, Makefile, and run script, allowing independent testing and full benchmark suite execution.

---

## Benchmark Variants

The repository includes the following kernel implementations:

### LMUL=1 Kernels
- OpenBLAS_Baseline_Kernel_16x8_SGEMM → Baseline kernel (no unroll)
- Unrolling_factor_2_Pragma → Pragma unroll factor 2
- Unrolling_factor_4_Pragma → Pragma unroll factor 4
- Unrolling_factor_8_Pragma → Pragma unroll factor 8

### LMUL=2 Kernels
- OpenBLAS_Baseline_Kernel_16x8_SGEMM-LMUL2 → LMUL=2 baseline kernel
- Unrolling_factor_2_Pragma-LMUL2 → LMUL=2 with pragma unroll factor 2
- Unrolling_factor_4_Pragma-LMUL2 → LMUL=2 with pragma unroll factor 4
- Unrolling_factor_8_Pragma-LMUL2 → LMUL=2 with pragma unroll factor 8

Each folder contains:

- Optimized SGEMM kernel
- Benchmark driver
- Makefile
- run.sh script
- Automatic log file generation

---

## How to Download / Clone

Clone the repository:

```bash
git clone https://github.com/BabarHussain786/riscv-openblas-gemm-accelerator.git
```

Navigate to benchmark directory:

```bash
cd riscv-openblas-gemm-accelerator/"Banana-pi_1.0_rvv_OpenBLAS_ Benchmark"
```

---

## How to Run Individual Benchmark Variant

Example:

```bash
cd Unrolling_factor_2_Pragma
make clean
make
chmod +x run.sh
./run.sh
```

This will:

- Compile the kernel
- Run all benchmark shapes
- Execute each shape 6 times
- Save results automatically in a log file

Example output log:

```
best_shapes_lmul1_unroll2_pragma_6runs_TIMESTAMP.log
```

Repeat same steps for any other folder.

---

## How to Run Full Benchmark Suite Automatically

Run all kernel variants using the master script:

```bash
chmod +x run_all_benchmarks.sh
./run_all_benchmarks.sh
```

This will execute:

- All LMUL=1 kernels
- All LMUL=2 kernels
- All unroll configurations
- All benchmark shapes
- 6 runs per shape

Final results saved in:

```
ALL_RVV_BENCHMARKS_TIMESTAMP.log
```

---

## Benchmark Workloads

The benchmark evaluates four representative GEMM shapes:

- Square: 4096 × 4096 × 4096
- Rectangular: 4096 × 1024 × 4096
- Tall-Skinny: 8192 × 256 × 4096
- Wide: 64 × 32768 × 4096

Each shape is executed 6 times to ensure statistical reliability.

Measured metrics:

- Execution time (seconds)
- GFLOPS performance
- Stability across runs

---

## Hardware Requirement

This benchmark requires a RISC-V processor with RVV 1.0 support:

Supported hardware includes:

- Banana Pi BPI-F3 (SpacemiT K1, RV64GCV, Zvl256b)
- StarFive VisionFive 2
- Any RVV 1.0 compatible RISC-V processor

Not supported:

- x86 systems
- ARM systems
- Non-RVV RISC-V processors

---

## Purpose

This project provides a complete experimental framework for evaluating the impact of:

- Vector length scaling (LMUL)
- Loop unrolling optimization
- Register utilization efficiency
- Micro-kernel design strategies

This repository supports research in:

- RISC-V vector optimization
- OpenBLAS kernel development
- High Performance Computing (HPC)
- Computer architecture performance analysis
- RVV micro-kernel optimization research

---

## Output Logs

Each benchmark run generates log files automatically containing:

- Execution time
- GFLOPS performance
- All benchmark runs
- Kernel configuration details

Example:

```
ALL_RVV_BENCHMARKS_20260225_024428.log
```

---

## Author

Babar Hussain  
PhD Student
University of Salerno  


---

## License

This project is intended for research and academic purposes.
