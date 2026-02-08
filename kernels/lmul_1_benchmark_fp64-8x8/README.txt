## 🚀 Optimized RISC-V GEMM Kernels

This repository contains high-performance GEMM (General Matrix Multiplication) kernels optimized for RISC-V 256-bit Vector (RVV) architecture, specifically targeting the **Banana Pi BPI-F3**.

| Kernel | Precision | Tile Size | RVV Intrinsics | Target Hardware | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`sgemm_kernel_16x8_zvl256b.c`** | FP32 (Single) | 16×8 | `vfloat32m1_t`<br>`__riscv_vfmacc_vf_f32m1` | RISC-V 256-bit Vector (LMUL=1) | ✅ Benchmark Ready |
| **`dgemm_kernel_8x8_zvl256b.c`** | FP64 (Double) | 8×8 | `vfloat64m1_t`<br>`__riscv_vfmacc_vf_f64m1` | RISC-V 256-bit Vector (LMUL=1) | ✅ Benchmark Ready |

### 📊 Key Technical Details

| Aspect | FP32 Kernel | FP64 Kernel |
| :--- | :--- | :--- |
| **Elements/Vector** | 8 floats (256b/32b) | 4 doubles (256b/64b) |
| **Memory/Tile** | 512 bytes | 512 bytes |
| **FMA Operations** | `r = __riscv_vfmacc_vf_f32m1(r, B, A, vl)` | `r = __riscv_vfmacc_vf_f64m1(r, B, A, vl)` |
| **Vector Load/Store** | `__riscv_vle32_v_f32m1` / `__riscv_vse32_v_f32m1` | `__riscv_vle64_v_f64m1` / `__riscv_vse64_v_f64m1` |
| **vsetvl** | `__riscv_vsetvl_e32m1(8)` | `__riscv_vsetvl_e64m1(4)` |

### 🧪 Performance Comparison (Expected)

Run both benchmarks to compare FMA performance on your hardware:

```bash
# FP32 Benchmark
./run_bench_sgemm_24h.sh 24h

# FP64 Benchmark  
./run_bench_dgemm_24h.sh 24h
