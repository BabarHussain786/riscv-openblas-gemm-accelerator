#!/usr/bin/env bash

LOGFILE="best_shapes_lmul1_baseline_$(date +%Y%m%d_%H%M%S).log"

echo "=======================================" | tee "$LOGFILE"
echo "RVV SGEMM BASELINE BENCHMARK (LMUL=1)" | tee -a "$LOGFILE"
echo "Each shape runs 6 times" | tee -a "$LOGFILE"
echo "=======================================" | tee -a "$LOGFILE"

make clean >> "$LOGFILE" 2>&1
make >> "$LOGFILE" 2>&1

run_case() {

NAME=$1
M=$2
N=$3
K=$4

echo "" | tee -a "$LOGFILE"
echo "Shape: $NAME" | tee -a "$LOGFILE"

for i in 1 2 3 4 5 6
do
echo "Run $i" | tee -a "$LOGFILE"
./bench $M $N $K | tee -a "$LOGFILE"
done
}

run_case Square 4096 4096 4096
run_case Rectangular 4096 1024 4096
run_case Tall 8192 256 4096
run_case Wide 64 32768 4096

echo "Done." | tee -a "$LOGFILE"
