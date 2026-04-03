#!/usr/bin/env bash

# Create directories correctly mapped to the hardware specs
mkdir -p core0_ai_results
mkdir -p core4_general_results

# Matrix size
M=4096
N=4096
K=4096

echo "=========================================================="
echo " Running FP32 8x8 Benchmarks (Single-Core Mode)"
echo " Dimensions: M=$M, N=$N, K=$K"
echo "=========================================================="
echo "Core 0 -> AI Cluster (Cluster 0: 2.0 TOPS, 512KB TCM)"
echo "Core 4 -> General Cluster (Cluster 1: Standard)"
echo "=========================================================="

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

            # -------------------------------
            # Core 0 -> AI Cluster
            # -------------------------------
            AI_LOG="../core0_ai_results/${dir}_core0_ai.log"

            echo "=======================================" > "$AI_LOG"
            echo "Kernel: $dir" >> "$AI_LOG"
            echo "Core: 0 (AI Cluster - 512KB TCM)" >> "$AI_LOG"
            echo "Shape: Square ($M x $N x $K)" >> "$AI_LOG"
            echo "=======================================" >> "$AI_LOG"

            for i in {1..6}; do
                echo "Run $i (Core 0 - AI Cluster)..."
                echo "Run $i" >> "$AI_LOG"
                taskset -c 0 ./bench $M $N $K >> "$AI_LOG" 2>&1
            done

            sleep 5

            # -------------------------------
            # Core 4 -> General Cluster
            # -------------------------------
            GENERAL_LOG="../core4_general_results/${dir}_core4_general.log"

            echo "=======================================" > "$GENERAL_LOG"
            echo "Kernel: $dir" >> "$GENERAL_LOG"
            echo "Core: 4 (General Cluster)" >> "$GENERAL_LOG"
            echo "Shape: Square ($M x $N x $K)" >> "$GENERAL_LOG"
            echo "=======================================" >> "$GENERAL_LOG"

            for i in {1..6}; do
                echo "Run $i (Core 4 - General Cluster)..."
                echo "Run $i" >> "$GENERAL_LOG"
                taskset -c 4 ./bench $M $N $K >> "$GENERAL_LOG" 2>&1
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
echo "ALL SINGLE-CORE 8x8 BENCHMARKS COMPLETE!"
echo "=========================================================="
