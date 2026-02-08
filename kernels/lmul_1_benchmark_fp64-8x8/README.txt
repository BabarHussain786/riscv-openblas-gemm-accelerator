<!DOCTYPE html>
<html>
<head>
    <style>
        .kernel-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-family: Arial, sans-serif;
        }
        .kernel-table th {
            background-color: #2c3e50;
            color: white;
            padding: 12px;
            text-align: left;
            border: 1px solid #34495e;
        }
        .kernel-table td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .kernel-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        .kernel-table tr:hover {
            background-color: #e8f4f8;
        }
        .precision-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .fp32-badge {
            background-color: #3498db;
            color: white;
        }
        .fp64-badge {
            background-color: #e74c3c;
            color: white;
        }
        .kernel-name {
            font-family: 'Courier New', monospace;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>RISC-V Vector GEMM Kernel Comparison</h2>
    
    <table class="kernel-table">
        <thead>
            <tr>
                <th>Feature</th>
                <th>FP32 Kernel (Single Precision)</th>
                <th>FP64 Kernel (Double Precision)</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Kernel File</strong></td>
                <td><span class="kernel-name">sgemm_kernel_16x8_zvl256b.c</span></td>
                <td><span class="kernel-name">dgemm_kernel_8x8_zvl256b.c</span></td>
            </tr>
            <tr>
                <td><strong>Precision</strong></td>
                <td><span class="precision-badge fp32-badge">FP32 (Single)</span></td>
                <td><span class="precision-badge fp64-badge">FP64 (Double)</span></td>
            </tr>
            <tr>
                <td><strong>Main Tile Size</strong></td>
                <td>16 rows × 8 columns</td>
                <td>8 rows × 8 columns</td>
            </tr>
            <tr>
                <td><strong>Vectors per Tile</strong></td>
                <td>2 vectors (8+8 rows)</td>
                <td>2 vectors (4+4 rows)</td>
            </tr>
            <tr>
                <td><strong>Elements per 256-bit Vector</strong></td>
                <td>8 floats (256/32 = 8)</td>
                <td>4 doubles (256/64 = 4)</td>
            </tr>
            <tr>
                <td><strong>Vector Data Type</strong></td>
                <td><code>vfloat32m1_t</code></td>
                <td><code>vfloat64m1_t</code></td>
            </tr>
            <tr>
                <td><strong>Core FMA Intrinsic</strong></td>
                <td><code>__riscv_vfmacc_vf_f32m1()</code></td>
                <td><code>__riscv_vfmacc_vf_f64m1()</code></td>
            </tr>
            <tr>
                <td><strong>Vector Load/Store</strong></td>
                <td><code>__riscv_vle32_v_f32m1()</code><br><code>__riscv_vse32_v_f32m1()</code></td>
                <td><code>__riscv_vle64_v_f64m1()</code><br><code>__riscv_vse64_v_f64m1()</code></td>
            </tr>
            <tr>
                <td><strong>vsetvl Setting</strong></td>
                <td><code>__riscv_vsetvl_e32m1(8)</code></td>
                <td><code>__riscv_vsetvl_e64m1(4)</code></td>
            </tr>
            <tr>
                <td><strong>LMUL Setting</strong></td>
                <td>LMUL=1</td>
                <td>LMUL=1</td>
            </tr>
            <tr>
                <td><strong>Memory per Tile</strong></td>
                <td>512 bytes (16×8×4)</td>
                <td>512 bytes (8×8×8)</td>
            </tr>
            <tr>
                <td><strong>Target Hardware</strong></td>
                <td colspan="2" style="text-align: center; background-color: #e8f5e8;">
                    Banana Pi BPI-F3 • SpacemiT K1 CPU • RV64GCVB • 256-bit Vector
                </td>
            </tr>
            <tr>
                <td><strong>Performance Expectation</strong></td>
                <td>Higher GFLOPS (2-4× faster)</td>
                <td>Baseline GFLOPS</td>
            </tr>
            <tr>
                <td><strong>Benchmark Script</strong></td>
                <td><code>run_bench_sgemm_24h.sh</code></td>
                <td><code>run_bench_dgemm_24h.sh</code></td>
            </tr>
        </tbody>
    </table>

    <div style="margin-top: 30px; padding: 15px; background-color: #f0f8ff; border-left: 4px solid #3498db;">
        <h3>📊 Key Insight</h3>
        <p>Both kernels process the <strong>same 512 bytes per tile</strong>, but the FP32 kernel processes <strong>2× more elements</strong> (128 vs 64). This is why FP32 typically achieves <strong>2-4× higher GFLOPS</strong> - it performs twice as many FMA operations with the same memory bandwidth.</p>
    </div>
</body>
</html>
