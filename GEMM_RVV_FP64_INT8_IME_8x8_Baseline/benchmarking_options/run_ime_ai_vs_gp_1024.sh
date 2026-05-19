#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUN_SCRIPT="${BASE_DIR}/benchmarking_options/run_ime_real_perf_1024.sh"
OUT_DIR="${BASE_DIR}/summary_results_1024"

M="${M:-1024}"
N="${N:-1024}"
K="${K:-1024}"
RUNS="${RUNS:-6}"
AI_CPUSET="${AI_CPUSET:-0-3}"
GP_CPUSET="${GP_CPUSET:-4-7}"
KEEP_OLD_LOGS="${KEEP_OLD_LOGS:-0}"

if [ ! -f "${RUN_SCRIPT}" ]; then
  echo "[ERROR] Missing runner: ${RUN_SCRIPT}" >&2
  exit 1
fi

if [ ! -x "${RUN_SCRIPT}" ]; then
  chmod +x "${RUN_SCRIPT}" 2>/dev/null || true
fi

echo "IME core comparison benchmark"
echo "Generated: $(date)"
echo "AI_CPUSET=${AI_CPUSET} (IME cores), GP_CPUSET=${GP_CPUSET} (non-IME fallback)"
echo "M=${M} N=${N} K=${K} RUNS=${RUNS}"
echo

RUN_ON=both \
AI_CPUSET="${AI_CPUSET}" \
GP_CPUSET="${GP_CPUSET}" \
RUNS="${RUNS}" M="${M}" N="${N}" K="${K}" \
KEEP_OLD_LOGS="${KEEP_OLD_LOGS}" \
"${RUN_SCRIPT}"

echo
echo "Per-kernel mean GOPS summary (AI vs GP):"
for f in "${OUT_DIR}"/ime_kernel_*_AI_*_square_results.log "${OUT_DIR}"/ime_kernel_*_GP_*_square_results.log; do
  [ -f "${f}" ] || continue
  mean="$(awk '/^GOPS:/ {s+=$2;n++} END{if(n>0) printf "%.4f", s/n; else printf "NA"}' "${f}")"
  printf "%-72s mean=%s\n" "$(basename "${f}" "_square_results.log")" "${mean}"
done | sort -V

echo
echo "Done. Compare *_AI_* logs against *_GP_* logs in: ${OUT_DIR}"
