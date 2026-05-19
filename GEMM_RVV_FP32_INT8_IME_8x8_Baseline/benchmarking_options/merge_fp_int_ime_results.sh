#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUT_DIR="${BASE_DIR}/summary_results_1024"

M="${M:-1024}"
RUNS="${RUNS:-6}"

mkdir -p "${OUT_DIR}"

OUT_FILE="${OUT_DIR}/all_fp_int_ime_square_${M}_runs${RUNS}_merged_only.log"

{
  echo "All FP/INT/IME merged results (merge-only)"
  echo "Generated: $(date)"
  echo
  for f in "${OUT_DIR}"/*_square_results.log; do
    [ -f "${f}" ] || continue
    bn="$(basename "${f}")"
    case "${bn}" in
      # Accept both legacy logs (..._square_results.log) and target-tagged logs
      # (..._AI_0_3_square_results.log / ..._GP_4_6_square_results.log).
      sgemm_kernel_8x8_*_lmul*_unroll*_square_results.log|\
      sgemm_kernel_8x8_*_lmul*_unroll*_*_square_results.log|\
      igemm_kernel_8x8_*_lmul*_unroll*_square_results.log|\
      igemm_kernel_8x8_*_lmul*_unroll*_*_square_results.log|\
      ime_kernel_8x8_zvl128b_lmul*_unroll*_square_results.log|\
      ime_kernel_8x8_zvl128b_lmul*_unroll*_*_square_results.log)
        ;;
      *)
        continue
        ;;
    esac
    grep -q '^Status: OK$' "${f}" || continue
    if ! grep -q '^GFLOPS:' "${f}" && ! grep -q '^GOPS:' "${f}"; then
      continue
    fi
    echo "=================================================="
    echo "FILE: ${bn}"
    echo "=================================================="
    cat "${f}"
    echo
  done
} > "${OUT_FILE}"

echo "Created: ${OUT_FILE}"
