#!/usr/bin/env bash
set -euo pipefail

make clean && make

# Example sizes (multiples of 16/8 to avoid tail noise)
M=${1:-2048}
N=${2:-2048}
K=${3:-2048}
ITERS=${4:-10}

# Threads: export OMP_NUM_THREADS=... (default: runtime)
echo "\n--- Baseline kernel (opt) ---"
./sgemm_threaded_pack_bench opt  ${M} ${N} ${K} ${ITERS}

echo "\n--- Unrolled kernel (kunroll2) ---"
./sgemm_threaded_pack_bench kunroll2 ${M} ${N} ${K} ${ITERS}
