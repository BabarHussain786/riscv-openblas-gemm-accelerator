#!/usr/bin/env bash

LOGFILE="best_shapes_lmul2_unroll4_pragma_$(date +%Y%m%d_%H%M%S).log"

echo "=======================================" | tee "$LOGFILE"
echo "RVV SGEMM BENCHMARK (LMUL=2 + Unroll×4 PRAGMA)" | tee -a "$LOGFILE"
echo "Each shape runs 6 times" | tee -a "$LOGFILE"
echo "=======================================" | tee -a "$LOGFILE"

echo "" | tee -a "$LOGFILE"

echo "Compiling..." | tee -a "$LOGFILE"
make clean >> "$LOGFILE" 2>&1
make >> "$LOGFILE" 2>&1

if [ ! -f ./bench ]; then
    echo "Compilation failed." | tee -a "$LOGFILE"
    exit 1
fi

run_case() {

    NAME=$1
    M=$2
    N=$3
    K=$4

    echo "" | tee -a "$LOGFILE"
    echo "=======================================" | tee -a "$LOGFILE"
    echo "Shape: $NAME" | tee -a "$LOGFILE"
    echo "=======================================" | tee -a "$LOGFILE"

    for i in 1 2 3 4 5 6
    do
        echo "" | tee -a "$LOGFILE"
        echo "Run $i" | tee -a "$LOGFILE"

        ./bench $M $N $K | tee -a "$LOGFILE"
    done
}

run_case "Square"        4096 4096 4096
run_case "Rectangular"   4096 1024 4096
run_case "Tall-Skinny"   8192 256 4096
run_case "Wide"          64 32768 4096

echo "" | tee -a "$LOGFILE"
echo "Benchmark complete." | tee -a "$LOGFILE"
echo "Log file: $LOGFILE" | tee -a "$LOGFILE"
