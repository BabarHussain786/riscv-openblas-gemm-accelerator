#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
MASTER_LOG="$ROOT_DIR/benchmark_all_ime_$(date +%Y%m%d_%H%M%S).log"

echo "======================================================" | tee "$MASTER_LOG"
echo "RUN ALL IME 8x4 VARIANT BENCHMARKS" | tee -a "$MASTER_LOG"
echo "Root: $ROOT_DIR" | tee -a "$MASTER_LOG"
echo "======================================================" | tee -a "$MASTER_LOG"

fail_count=0
run_count=0

for d in "$ROOT_DIR"/ime_kernel_8x4_zvl128b_lmul*_unroll*; do
    [ -d "$d" ] || continue
    variant="$(basename "$d")"
    run_script="$d/run_ime_benchmarks.sh"

    echo "" | tee -a "$MASTER_LOG"
    echo "---- Variant: $variant ----" | tee -a "$MASTER_LOG"

    if [ ! -f "$run_script" ]; then
        echo "Missing script: $run_script" | tee -a "$MASTER_LOG"
        fail_count=$((fail_count + 1))
        continue
    fi

    run_count=$((run_count + 1))

    (
      cd "$d" && bash ./run_ime_benchmarks.sh
    ) >> "$MASTER_LOG" 2>&1

    rc=$?
    if [ $rc -ne 0 ]; then
        echo "FAILED: $variant (exit $rc)" | tee -a "$MASTER_LOG"
        fail_count=$((fail_count + 1))
    else
        echo "OK: $variant" | tee -a "$MASTER_LOG"
    fi
done

echo "" | tee -a "$MASTER_LOG"
echo "Completed variants: $run_count" | tee -a "$MASTER_LOG"
echo "Failures: $fail_count" | tee -a "$MASTER_LOG"
echo "Master log: $MASTER_LOG" | tee -a "$MASTER_LOG"

if [ $fail_count -ne 0 ]; then
    exit 1
fi

exit 0
