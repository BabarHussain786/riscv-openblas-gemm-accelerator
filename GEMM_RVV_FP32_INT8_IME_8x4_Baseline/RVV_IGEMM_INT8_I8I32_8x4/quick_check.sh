#!/usr/bin/env bash
M=${M:-256}
N=${N:-256}
K=${K:-256}

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

FAILED=()
for d in "${DIRS[@]}"; do
  if [ ! -d "$d" ]; then
    printf "%-55s [NOT FOUND]\n" "$d"
    continue
  fi
  printf "%-55s " "$d"
  ( cd "$d" && make clean >/dev/null 2>&1 && make >/dev/null 2>&1 && ./bench "$M" "$N" "$K" >/dev/null 2>&1 )
  if [ $? -eq 0 ]; then
    echo "[OK]"
  else
    echo "[FAIL]"
    FAILED+=("$d")
  fi
done

if [ ${#FAILED[@]} -ne 0 ]; then
  echo "Failed kernels:"
  printf ' - %s\n' "${FAILED[@]}"
  exit 1
fi
