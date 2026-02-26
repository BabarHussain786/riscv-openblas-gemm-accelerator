# RVV 1.0 OpenBLAS GEMM Benchmark (Banana Pi BPI-F3)

This repository contains optimized SGEMM micro-kernels using the RISC-V Vector Extension (RVV 1.0) with separate benchmarking implementations for different loop unrolling factors. The benchmarks are designed for performance evaluation on RVV-enabled processors such as the Banana Pi BPI-F3.

---

## Benchmark Variants

Each folder contains its own kernel, Makefile, and run script. Run each benchmark separately:

- OpenBLAS_Baseline_Kernel_16x8_SGEMM → Baseline kernel (no unroll)  
- Unrolling_factor_2_Pragma → Pragma unroll factor 2  
- Unrolling_factor_4_Pragma → Pragma unroll factor 4  
- Unrolling_factor_8_Pragma → Pragma unroll factor 8  

---

## How to Download / Clone

Clone the full project from GitHub:

```bash
git clone https://github.com/BabarHussain786/riscv-openblas-gemm-accelerator.git
```

Go to the benchmark directory:

```bash
cd riscv-openblas-gemm-accelerator/"Banana-pi_1.0_rvv_OpenBLAS_ Benchmark"
```

---

## How to Run (for each variant)

Go to the desired folder and execute:

```bash
cd Unrolling_factor_2_Pragma
make clean
make
chmod +x run.sh
./run.sh
```

Repeat the same steps for:

- OpenBLAS_Baseline_Kernel_16x8_SGEMM  
- Unrolling_factor_4_Pragma  
- Unrolling_factor_8_Pragma  

---

## Hardware Requirement

This benchmark runs only on RISC-V processors with RVV 1.0 support (RV64GCV + Zvl256b) such as:

- Banana Pi BPI-F3 (SpacemiT K1)  
- StarFive VisionFive 2  

It does NOT run on x86, ARM, or non-RVV systems.

---

## Benchmark Workloads

The benchmark evaluates the following matrix shapes:

- Square: 4096 × 4096 × 4096  
- Rectangular: 4096 × 1024 × 4096  
- Tall-Skinny: 8192 × 256 × 4096  
- Wide: 64 × 32768 × 4096  

Each shape runs multiple times and logs execution time and GFLOPS.

---

## Purpose

This project evaluates GEMM performance scaling with different pragma unroll factors using RVV 1.0 vector instructions. It supports research in:

- RISC-V vector optimization  
- OpenBLAS micro-kernel development  
- High Performance Computing (HPC)  
- Computer architecture and performance analysis  

---

## Author

Babar Hussain  
PhD Researcher  
University of Salerno  
Research Area: RISC-V Optimization, Edge AI, High Performance Computing
