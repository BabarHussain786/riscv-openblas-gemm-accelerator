#!/usr/bin/env bash
set -euo pipefail

MASTER_LOG="ALL_RVV_ZVL128B_BENCHMARKS_$(date +%Y%m%d_%H%M%S).log"

echo "==============================================" | tee "$MASTER_LOG"
echo "RVV SGEMM COMPLETE BENCHMARK SUITE (ZVL128B)" | tee -a "$MASTER_LOG"
echo "Banana Pi BPI-F3 | RVV 1.0 | FP32 SGEMM 8x8" | tee -a "$MASTER_LOG"
echo "Start time: $(date)" | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"

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

DIRS=(
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
    "sgemm_kernel_8x8_zvl128b_lmulmf2_unroll1"
    "sgemm_kernel_8x8_zvl128b_lmulmf2_unroll2"
    "sgemm_kernel_8x8_zvl128b_lmulmf2_unroll4"
    "sgemm_kernel_8x8_zvl128b_lmulmf2_unroll8"
)

for d in "${DIRS[@]}"; do
    run_folder "$d"
done

echo "" | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"
echo "ALL BENCHMARKS COMPLETED SUCCESSFULLY" | tee -a "$MASTER_LOG"
echo "End time: $(date)" | tee -a "$MASTER_LOG"
echo "Master log saved in:" | tee -a "$MASTER_LOG"
echo "$MASTER_LOG" | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"