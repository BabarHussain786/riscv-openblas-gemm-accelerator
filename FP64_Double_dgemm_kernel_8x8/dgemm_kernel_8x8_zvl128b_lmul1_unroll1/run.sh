#!/usr/bin/env bash

LOGFILE="benchmark_dgemm_8x8_lmul1_unroll1_$(date +%Y%m%d_%H%M%S).log"

echo "======================================================" | tee "$LOGFILE"
echo "RVV DGEMM BENCHMARK (FP64 8x8 - LMUL 1 - No Unroll)" | tee -a "$LOGFILE"
echo "Each shape runs 6 times" | tee -a "$LOGFILE"
echo "======================================================" | tee -a "$LOGFILE"

make clean >> "$LOGFILE" 2>&1
make >> "$LOGFILE" 2>&1

if [ ! -f ./bench ]; then
    echo "Compilation failed! Please run 'make' manually to see the error." | tee -a "$LOGFILE"
    exit 1
fi

run_case() {
    NAME=$1
    M=$2
    N=$3
    K=$4

    echo "" | tee -a "$LOGFILE"
    echo "Shape: $NAME (${M}x${N}x${K})" | tee -a "$LOGFILE"

    for i in {1..6}
    do
        echo "Run $i" | tee -a "$LOGFILE"
        ./bench $M $N $K | tee -a "$LOGFILE"
    done
}

run_case Square 2048 2048 2048

echo "Done." | tee -a "$LOGFILE"
