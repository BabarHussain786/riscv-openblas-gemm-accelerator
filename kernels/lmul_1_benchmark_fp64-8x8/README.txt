## 🚀 Optimized RISC-V GEMM Kernels

| Feature | FP32 Kernel | FP64 Kernel |
| :--- | :--- | :--- |
| **Filename** | `sgemm_kernel_16x8_zvl256b.c` | `dgemm_kernel_8x8_zvl256b.c` |
| **Precision** | Single (32-bit float) | Double (64-bit double) |
| **Main Tile Size** | 16 rows × 8 columns | 8 rows × 8 columns |
| **Elements per 256-bit Vector** | 8 floats | 4 doubles |
| **Vector Type** | `vfloat32m1_t` | `vfloat64m1_t` |
| **Core FMA Intrinsic** | `__riscv_vfmacc_vf_f32m1()` | `__riscv_vfmacc_vf_f64m1()` |
| **Vector Load** | `__riscv_vle32_v_f32m1()` | `__riscv_vle64_v_f64m1()` |
| **Vector Store** | `__riscv_vse32_v_f32m1()` | `__riscv_vse64_v_f64m1()` |
| **vsetvl** | `__riscv_vsetvl_e32m1(8)` | `__riscv_vsetvl_e64m1(4)` |
| **LMUL Setting** | LMUL=1 | LMUL=1 |
| **Memory per Tile** | 512 bytes | 512 bytes |
| **Target Hardware** | Banana Pi BPI-F3 (RV64GCVB, 256-bit Vector) | Same |
| **Benchmark Script** | `run_bench_sgemm_24h.sh` | `run_bench_dgemm_24h.sh` |

### 🎯 Key Insight
Both kernels process **512 bytes per tile**, but the FP32 kernel processes **twice as many elements** (128 vs 64). This is why FP32 typically achieves **2-4× higher GFLOPS** on the same hardware.

### 🧪 Quick Test
```bash
# FP32 Benchmark
./sgemm_bench_16x8 1024 1024 1024

# FP64 Benchmark
./dgemm_bench_8x8 1024 1024 1024
