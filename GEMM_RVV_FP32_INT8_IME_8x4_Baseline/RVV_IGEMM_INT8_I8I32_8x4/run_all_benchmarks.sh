#!/usr/bin/env bash
mkdir -p summary_results
M=${M:-4096}
N=${N:-4096}
K=${K:-4096}
RUNS=${RUNS:-6}

DIRS=(
  igemm_kernel_8x4_zvl256b_lmulmf2_unroll1
  igemm_kernel_8x4_zvl256b_lmulmf2_unroll2
  igemm_kernel_8x4_zvl256b_lmulmf2_unroll4
  igemm_kernel_8x4_zvl256b_lmulmf2_unroll8
  igemm_kernel_8x4_zvl256b_lmulmf4_unroll1
  igemm_kernel_8x4_zvl256b_lmulmf4_unroll2
  igemm_kernel_8x4_zvl256b_lmulmf4_unroll4
  igemm_kernel_8x4_zvl256b_lmulmf4_unroll8
  igemm_kernel_8x4_zvl256b_lmulmf8_unroll1
  igemm_kernel_8x4_zvl256b_lmulmf8_unroll2
  igemm_kernel_8x4_zvl256b_lmulmf8_unroll4
  igemm_kernel_8x4_zvl256b_lmulmf8_unroll8
  igemm_kernel_8x4_zvl256b_lmul1_unroll1
  igemm_kernel_8x4_zvl256b_lmul1_unroll2
  igemm_kernel_8x4_zvl256b_lmul1_unroll4
  igemm_kernel_8x4_zvl256b_lmul1_unroll8
  igemm_kernel_8x4_zvl256b_lmul2_unroll1
  igemm_kernel_8x4_zvl256b_lmul2_unroll2
  igemm_kernel_8x4_zvl256b_lmul2_unroll4
  igemm_kernel_8x4_zvl256b_lmul2_unroll8
  igemm_kernel_8x4_zvl256b_lmul4_unroll1
  igemm_kernel_8x4_zvl256b_lmul4_unroll2
  igemm_kernel_8x4_zvl256b_lmul4_unroll4
  igemm_kernel_8x4_zvl256b_lmul4_unroll8
  igemm_kernel_8x4_zvl256b_lmul8_unroll1
  igemm_kernel_8x4_zvl256b_lmul8_unroll2
  igemm_kernel_8x4_zvl256b_lmul8_unroll4
  igemm_kernel_8x4_zvl256b_lmul8_unroll8
)

for d in "${DIRS[@]}"; do
  [ -d "$d" ] || continue
  log="summary_results/${d}_square_results.log"
  echo "Kernel: $d" > "$log"
  echo "Shape: ${M} x ${N} x ${K}" >> "$log"
  ( cd "$d" && make clean >/dev/null 2>&1 && make >/dev/null 2>&1 ) || { echo "build failed" >> "$log"; continue; }
  for r in $(seq 1 "$RUNS"); do
    echo "Run $r" >> "$log"
    ( cd "$d" && ./bench "$M" "$N" "$K" ) >> "$log" 2>&1
  done
done
