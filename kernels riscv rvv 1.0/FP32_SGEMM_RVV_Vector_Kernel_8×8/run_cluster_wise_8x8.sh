#!/usr/bin/env bash

# Create directories for both cluster results
mkdir -p cluster0_results
mkdir -p cluster1_results

# Define the matrix dimensions
M=4096
N=4096
K=4096

echo "=========================================================="
echo " Running FP32 8x8 Benchmarks on BOTH Clusters"
echo " Dimensions: M=$M, N=$N, K=$K"
echo "=========================================================="
echo "Cluster-0: Cores 0-3 (AI Cluster with 2.0 TOPS & TCM)"
echo "Cluster-1: Cores 4-7 (General Purpose)"
echo "=========================================================="

# The complete list of all benchmark folders
DIRS=(
    "OpenBLAS_Baseline_Kernel_FP32"
    "OpenBLAS_Baseline_Kernel_FP32_Fractional"
    "OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll2"
    "OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll4"
    "OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll8"
    "sgemm_kernel_8x8_zvl128b_lmul1_unroll1"
    "sgemm_kernel_8x8_zvl128b_lmul1_unroll2"
    "sgemm_kernel_8x8_zvl128b_lmul1_unroll4"
    "sgemm_kernel_8x8_zvl128b_lmul1_unroll8"
    "sgemm_kernel_8x8_zvl128b_lmul2_unroll1"
    "sgemm_kernel_8x8_zvl128b_lmul2_unroll2"
    "sgemm_kernel_8x8_zvl128b_lmul2_unroll4"
    "sgemm_kernel_8x8_zvl128b_lmul2_unroll8"
    "sgemm_kernel_8x8_zvl128b_lmul4_unroll1"
    "sgemm_kernel_8x8_zvl128b_lmul4_unroll2"
    "sgemm_kernel_8x8_zvl128b_lmul4_unroll4"
    "sgemm_kernel_8x8_zvl128b_lmul4_unroll8"
    "sgemm_kernel_8x8_zvl128b_lmul8_unroll1"
    "sgemm_kernel_8x8_zvl128b_lmul8_unroll2"
    "sgemm_kernel_8x8_zvl128b_lmul8_unroll4"
    "sgemm_kernel_8x8_zvl128b_lmul8_unroll8"
)

for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "----------------------------------------------------------"
        echo ">>> Processing: $dir"

        cd "$dir" || continue

        make clean > /dev/null 2>&1
        make > /dev/null 2>&1

        if [ -f "./bench" ]; then
            
            # ----------------------------------------------------
            # Run on Cluster-0 (AI cluster) -> Cores 0-3
            # ----------------------------------------------------
            echo "    Running on CLUSTER-0 (cores 0-3)..."
            
            CLUSTER0_LOG="../cluster0_results/${dir}_cluster0.log"
            echo "=======================================" > "$CLUSTER0_LOG"
            echo "Kernel: $dir" >> "$CLUSTER0_LOG"
            echo "Cluster: 0 (Cores 0-3) AI Cluster with 2.0 TOPS" >> "$CLUSTER0_LOG"
            echo "Shape: Square ($M x $N x $K)" >> "$CLUSTER0_LOG"
            echo "=======================================" >> "$CLUSTER0_LOG"
            
            for i in {1..6}; do
                echo "    Run $i on Cluster-0..."
                echo "Run $i" >> "$CLUSTER0_LOG"
                taskset -c 0-3 ./bench $M $N $K >> "$CLUSTER0_LOG" 2>&1
            done
            
            sleep 5

            # ----------------------------------------------------
            # Run on Cluster-1 (General purpose) -> Cores 4-7
            # ----------------------------------------------------
            echo "    Running on CLUSTER-1 (cores 4-7)..."
            
            CLUSTER1_LOG="../cluster1_results/${dir}_cluster1.log"
            echo "=======================================" > "$CLUSTER1_LOG"
            echo "Kernel: $dir" >> "$CLUSTER1_LOG"
            echo "Cluster: 1 (Cores 4-7) General Purpose" >> "$CLUSTER1_LOG"
            echo "Shape: Square ($M x $N x $K)" >> "$CLUSTER1_LOG"
            echo "=======================================" >> "$CLUSTER1_LOG"
            
            for i in {1..6}; do
                echo "    Run $i on Cluster-1..."
                echo "Run $i" >> "$CLUSTER1_LOG"
                taskset -c 4-7 ./bench $M $N $K >> "$CLUSTER1_LOG" 2>&1
            done

            echo "    Done for $dir"
        else
            echo "    [ERROR] Compilation failed for $dir!"
        fi

        cd ..
        sleep 10
    else
        echo "[WARNING] Directory $dir not found. Skipping."
    fi
done

echo "----------------------------------------------------------"
echo "ALL FULL-CLUSTER 8x8 BENCHMARKS COMPLETE!"
echo "=========================================================="
