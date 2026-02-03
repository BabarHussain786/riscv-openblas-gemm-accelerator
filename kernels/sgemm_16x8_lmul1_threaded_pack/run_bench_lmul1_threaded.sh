#!/usr/bin/env bash
set -euo pipefail

# Run threaded SGEMM benchmark
# Usage:
#   ./run_bench_lmul1_threaded.sh [M N K ITERS WARMUP CHECK]
#
# Example:
#   OMP_NUM_THREADS=8 ./run_bench_lmul1_threaded.sh 2048 2048 2048 10 3 0

M="${1:-2048}"
N="${2:-2048}"
K="${3:-2048}"
ITERS="${4:-10}"
WARMUP="${5:-3}"
CHECK="${6:-0}"

make clean >/dev/null 2>&1 || true
make sgemm_bench_lmul1_threaded

echo
echo "Running: M=$M N=$N K=$K iters=$ITERS warmup=$WARMUP check=$CHECK"
echo "Tip: set OMP_NUM_THREADS to control threads."
echo

./sgemm_bench_lmul1_threaded "$M" "$N" "$K" "$ITERS" "$WARMUP" "$CHECK"
