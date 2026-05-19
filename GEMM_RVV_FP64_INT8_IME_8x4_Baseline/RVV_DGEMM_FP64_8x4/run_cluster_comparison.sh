#!/usr/bin/env bash

# Create directories for both cluster results
mkdir -p cluster0_results
mkdir -p cluster1_results

# Define the matrix dimensions
M=4096
N=4096
K=4096

echo "=========================================================="
echo " Running FP64 Benchmarks on BOTH Clusters"
echo " Dimensions: M=$M, N=$N, K=$K"
echo "=========================================================="
echo "Cluster-0: Cores 0-3 (AI Cluster with 2.0 TOPS & TCM)"
echo "Cluster-1: Cores 4-7 (General Purpose)"
echo "=========================================================="

# The complete list of all benchmark folders
DIRS=(
    "dgemm_kernel_8x4_zvl128b_lmul1_unroll1"
    "dgemm_kernel_8x4_zvl128b_lmul1_unroll2"
    "dgemm_kernel_8x4_zvl128b_lmul1_unroll4"
    "dgemm_kernel_8x4_zvl128b_lmul1_unroll8"
    "dgemm_kernel_8x4_zvl128b_lmul2_unroll1"
    "dgemm_kernel_8x4_zvl128b_lmul2_unroll2"
    "dgemm_kernel_8x4_zvl128b_lmul2_unroll4"
    "dgemm_kernel_8x4_zvl128b_lmul2_unroll8"
    "dgemm_kernel_8x4_zvl128b_lmul4_unroll1"
    "dgemm_kernel_8x4_zvl128b_lmul4_unroll2"
    "dgemm_kernel_8x4_zvl128b_lmul4_unroll4"
    "dgemm_kernel_8x4_zvl128b_lmul4_unroll8"
    "dgemm_kernel_8x4_zvl128b_lmul8_unroll1"
    "dgemm_kernel_8x4_zvl128b_lmul8_unroll2"
    "dgemm_kernel_8x4_zvl128b_lmul8_unroll4"
    "dgemm_kernel_8x4_zvl128b_lmul8_unroll8"
)

for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "----------------------------------------------------------"
        echo ">>> Processing: $dir"

        # Navigate into the specific kernel folder
        cd "$dir" || continue

        # Compile once (same binary for both tests)
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
            
            # Cool down before hitting the next cluster
            echo "    Cooling down for 5 seconds..."
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

            echo "    Done. Results saved to:"
            echo "      - cluster0_results/${dir}_cluster0.log"
            echo "      - cluster1_results/${dir}_cluster1.log"
        else
            echo "    [ERROR] Compilation failed for $dir!"
        fi

        # Return to root directory
        cd ..
        
        # Heavy thermal cooldown before the next kernel compilation
        echo ">>> Cooling down for 10 seconds to prevent thermal throttling..."
        sleep 10
    else
        echo "[WARNING] Directory $dir not found. Skipping."
    fi
done

echo "----------------------------------------------------------"
echo "ALL BENCHMARKS COMPLETE!"
echo "=========================================================="
echo "Results saved in:"
echo "  - cluster0_results/  (AI Cluster - cores 0-3)"
echo "  - cluster1_results/  (General Purpose - cores 4-7)"
echo "=========================================================="
