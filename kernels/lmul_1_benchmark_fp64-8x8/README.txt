## 🚀 Optimized RISC-V GEMM Kernels

| Feature | FP32 (Single) Kernel | FP64 (Double) Kernel |
| :--- | :--- | :--- |
| **1. Basic Information** |
| **Filename** | `sgemm_kernel_16x8_zvl256b.c` | `dgemm_kernel_8x8_zvl256b.c` |
| **Precision** | 32-bit Single Precision | 64-bit Double Precision |
| **Main Tile Size** | 16 rows × 8 columns | 8 rows × 8 columns |
| **Elements per 256-bit Vector** | 8 floats | 4 doubles |
| **2. RVV Intrinsics** |
| **Vector Data Type** | `vfloat32m1_t` | `vfloat64m1_t` |
| **Core FMA Instruction** | `__riscv_vfmacc_vf_f32m1()` | `__riscv_vfmacc_vf_f64m1()` |
| **Vector Load** | `__riscv_vle32_v_f32m1()` | `__riscv_vle64_v_f64m1()` |
| **Vector Store** | `__riscv_vse32_v_f32m1()` | `__riscv_vse64_v_f64m1()` |
| **Vector Length Set** | `__riscv_vsetvl_e32m1(8)` | `__riscv_vsetvl_e64m1(4)` |
| **3. Configuration** |
| **LMUL Setting** | LMUL=1 | LMUL=1 |
| **Memory per Tile** | 512 bytes | 512 bytes |
| **4. Target & Usage** |
| **Target Hardware** | Banana Pi BPI-F3 (RV64GCVB, 256-bit Vector) |
| **Benchmark Script** | `run_bench_sgemm_24h.sh` | `run_bench_dgemm_24h.sh` |
| **Performance Expectation** | Higher GFLOPS (2-4× faster) | Baseline GFLOPS |

### 🎯 Key Performance Insight
Both kernels process the **same 512 bytes per tile** of data. However, the FP32 kernel processes **twice as many elements** (128 vs 64) in that same memory space, which is why it typically achieves **2-4× higher GFLOPS** on identical hardware.

### 🧪 Quick Test Commands
```bash
# Test FP32 Kernel
./sgemm_bench_16x8 1024 1024 1024

# Test FP64 Kernel  
./dgemm_bench_8x8 1024 1024 1024
