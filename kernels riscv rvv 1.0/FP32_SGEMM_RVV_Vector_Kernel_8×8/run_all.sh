#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# RVV SGEMM COMPLETE BENCHMARK SUITE (ZVL128B)
# Runs all OpenBLAS FP32 variants automatically
# ============================================================

MASTER_LOG="ALL_RVV_ZVL128B_BENCHMARKS_$(date +%Y%m%d_%H%M%S).log"

echo "==============================================" | tee "$MASTER_LOG"
echo "RVV SGEMM COMPLETE BENCHMARK SUITE (ZVL128B)" | tee -a "$MASTER_LOG"
echo "Banana Pi BPI-F3 | RVV 1.0 | FP32 SGEMM"     | tee -a "$MASTER_LOG"
echo "Start time: $(date)"                        | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"


# ============================================================
# Function to run benchmark folder safely
# ============================================================

run_folder() {

    local FOLDER="$1"

    echo "" | tee -a "$MASTER_LOG"
    echo "======================================" | tee -a "$MASTER_LOG"
    echo "Running: $FOLDER" | tee -a "$MASTER_LOG"
    echo "======================================" | tee -a "$MASTER_LOG"

    if [[ ! -d "$FOLDER" ]]; then
        echo "ERROR: Folder not found: $FOLDER" | tee -a "$MASTER_LOG"
        return 1
    fi

    if [[ ! -f "$FOLDER/run.sh" ]]; then
        echo "ERROR: run.sh not found in: $FOLDER" | tee -a "$MASTER_LOG"
        return 1
    fi

    (
        cd "$FOLDER"
        chmod +x run.sh
        ./run.sh
    ) >> "$MASTER_LOG" 2>&1

    echo "Completed: $FOLDER" | tee -a "$MASTER_LOG"
}


# ============================================================
# Run all benchmark variants
# ============================================================

# ---- Baseline ----
run_folder "OpenBLAS_Baseline_Kernel_FP32"

# ---- Fractional LMUL mf2 ----
run_folder "OpenBLAS_Baseline_Kernel_FP32_Fractional"

# ---- Fractional + Unroll 2 ----
run_folder "OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll2"

# ---- Fractional + Unroll 4 ----
run_folder "OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll4"

# ---- Fractional + Unroll 8 ----
run_folder "OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll8"


# ============================================================
# Finish
# ============================================================

echo "" | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"
echo "ALL BENCHMARKS COMPLETED SUCCESSFULLY"       | tee -a "$MASTER_LOG"
echo "End time: $(date)"                           | tee -a "$MASTER_LOG"
echo "Master log saved in:"                       | tee -a "$MASTER_LOG"
echo "$MASTER_LOG"                               | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"
