#!/usr/bin/env bash
set -euo pipefail

MASTER_LOG="ALL_RVV_BENCHMARKS_$(date +%Y%m%d_%H%M%S).log"

echo "==============================================" | tee "$MASTER_LOG"
echo "RVV SGEMM COMPLETE BENCHMARK SUITE"            | tee -a "$MASTER_LOG"
echo "Running all kernels (LMUL1 and LMUL2)"        | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"

run_folder() {
    local FOLDER="$1"

    echo "" | tee -a "$MASTER_LOG"
    echo "======================================" | tee -a "$MASTER_LOG"
    echo "Running: $FOLDER"                        | tee -a "$MASTER_LOG"
    echo "======================================" | tee -a "$MASTER_LOG"

    if [[ ! -d "$FOLDER" ]]; then
        echo "ERROR: folder not found: $FOLDER" | tee -a "$MASTER_LOG"
        return 1
    fi

    if [[ ! -f "$FOLDER/run.sh" ]]; then
        echo "ERROR: run.sh not found in: $FOLDER" | tee -a "$MASTER_LOG"
        return 1
    fi

    ( cd "$FOLDER" && chmod +x run.sh && ./run.sh ) >> "$MASTER_LOG" 2>&1
}

# ---- LMUL1 ----
run_folder "OpenBLAS_Baseline_Kernel_16x8_SGEMM"
run_folder "Unrolling_factor_2_Pragma"
run_folder "Unrolling_factor_4_Pragma"
run_folder "Unrolling_factor_8_Pragma"

# ---- LMUL2 ----
run_folder "OpenBLAS_Baseline_Kernel_16x8_SGEMM-LMUL2"
run_folder "Unrolling_factor_2_Pragma-LMUL2"
run_folder "Unrolling_factor_4_Pragma-LMUL2"
run_folder "Unrolling_factor_8_Pragma-LMUL2"

echo "" | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"
echo "ALL BENCHMARKS COMPLETED"                      | tee -a "$MASTER_LOG"
echo "Results saved in: $MASTER_LOG"                 | tee -a "$MASTER_LOG"
echo "==============================================" | tee -a "$MASTER_LOG"
