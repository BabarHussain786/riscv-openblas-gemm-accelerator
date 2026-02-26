RVV 1.0 OpenBLAS GEMM Benchmark (Banana Pi BPI‑F3)
This repository contains optimized SGEMM micro-kernels using the RISC-V Vector Extension (RVV 1.0). Each benchmark folder contains a separate kernel implementation and its own benchmarking framework.

Supported Hardware
This project runs ONLY on RISC-V processors supporting:

RV64GCV
RVV 1.0
Zvl256b (VLEN = 256-bit)
Recommended boards:

Banana Pi BPI-F3 (SpacemiT K1)
StarFive VisionFive 2
Other RVV 1.0 compatible processors
It will NOT run on:

x86 (Intel / AMD)
ARM processors
Non-vector RISC-V CPUs
Benchmark Variants
Each folder contains a separate benchmark:

OpenBLAS_Baseline_Kernel_16x8_SGEMM → Baseline kernel
Unrolling_factor_2_Pragma → Unroll factor 2
Unrolling_factor_4_Pragma → Unroll factor 4
Unrolling_factor_8_Pragma → Unroll factor 8
Each variant must be compiled and run separately.

How to Run
Step 1: Navigate to a benchmark folder

cd Unrolling_factor_2_Pragma

Step 2: Compile

make clean make

Step 3: Run benchmark

chmod +x run.sh ./run.sh

Benchmark Shapes
The benchmark tests:

Square: 4096×4096×4096
Rectangular: 4096×1024×4096
Tall-Skinny: 8192×256×4096
Wide: 64×32768×4096
Each shape runs multiple times and logs GFLOPS performance.

Purpose
This project is designed for:

RVV 1.0 performance evaluation
GEMM kernel optimization
OpenBLAS micro-kernel research
High Performance Computing (HPC)
PhD research in RISC-V optimization
Author
Babar Hussain
PhD Researcher
University of Salerno

Research Area:

RISC-V Optimization
Edge AI
HPC
