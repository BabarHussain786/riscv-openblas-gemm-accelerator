| Aspect | FP32 Kernel (`sgemm_kernel_16x8_zvl256b`) | FP64 Kernel (`dgemm_kernel_8x8_zvl256b`) |
|--------|-------------------------------------------|------------------------------------------|
| **Precision** | Single-precision (32-bit float) | Double-precision (64-bit double) |
| **Main Tile Size** | 16×8 (16 rows, 8 columns) | 8×8 (8 rows, 8 columns) |
| **Vectors per Tile** | 2 vectors for 16 rows (8+8) | 2 vectors for 8 rows (4+4) |
| **Elements per Vector** | 8 floats (256/32 = 8) | 4 doubles (256/64 = 4) |
| **Vector Type** | `vfloat32m1_t` | `vfloat64m1_t` |
| **Intrinsics** | `__riscv_vle32_v_f32m1`, `__riscv_vfmacc_vf_f32m1` | `__riscv_vle64_v_f64m1`, `__riscv_vfmacc_vf_f64m1` |
| **vsetvl** | `__riscv_vsetvl_e32m1(8)` | `__riscv_vsetvl_e64m1(4)` |
| **Memory per Tile** | 16×8×4 = 512 bytes | 8×8×8 = 512 bytes |
