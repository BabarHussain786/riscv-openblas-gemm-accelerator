#!/usr/bin/env bash
# run_bench_lmul4.sh — 24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK (LMUL=4)

set -euo pipefail

TARGET="./sgemm_bench_lmul4"
KERNEL_NAME="sgemm_kernel_32x4_zvl256b_lmul4"

echo "====================================================="
echo "24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK"
echo "Kernel: ${KERNEL_NAME}"
echo "Start:  $(date)"
echo "Host:   $(hostname)"
echo "====================================================="

# Background mode
if [[ "${1:-}" == "bg" || "${1:-}" == "background" ]]; then
  LOGFILE="24h_benchmark_lmul4_$(date +%Y%m%d_%H%M%S).log"
  echo "Running 24-hour benchmark in BACKGROUND..."
  echo "Logs: $LOGFILE"
  echo "Monitor: tail -f $LOGFILE"
  nohup "$0" 24h-foreground > "$LOGFILE" 2>&1 &
  echo "PID: $! | To stop: kill $!"
  exit 0
fi

# Show help/menu
if [[ "${1:-}" != "24h-foreground" ]]; then
  echo ""
  echo "USAGE:"
  echo "  ./run_bench_lmul4.sh 24h       - 24-hour benchmark (interactive)"
  echo "  ./run_bench_lmul4.sh bg        - 24-hour benchmark (background)"
  echo ""
  echo "Quick test:"
  echo "  ${TARGET} 1024 1024 1024"
  exit 1
fi

# Results dir
RESULTS_DIR="24h_results_lmul4_$(date +%Y%m%d_%H%M%S)"
mkdir -p "${RESULTS_DIR}"

log() {
  echo "[$(date '+%m-%d %H:%M:%S')] $1" | tee -a "${RESULTS_DIR}/benchmark.log"
}

run_bench() {
  local M=$1 N=$2 K=$3 label=$4 cycle=$5
  local output result
  output=$(${TARGET} "${M}" "${N}" "${K}" 1.0 3 30 2>&1 || true)
  result=$(echo "$output" | tail -1)
  echo "${cycle},${label},${result}" >> "${RESULTS_DIR}/all_results.csv"

  # Parse fields: M N K time gflops gbs intensity vec_eff tail_overhead bound
  local _m _n _k time gflops gbs intensity vec_eff tail_overhead bound
  read -r _m _n _k time gflops gbs intensity vec_eff tail_overhead bound <<< "${result}"
  log "Cycle ${cycle} | ${label}: ${gflops} GFLOPS, ${time} sec, ${bound}"
}

ALL_TESTS=(
  "1024³:1024:1024:1024"
  "1536³:1536:1536:1536"
  "2048³:2048:2048:2048"
  "3072³:3072:3072:3072"
  "4096³:4096:4096:4096"
  "4096×4096×1024:4096:4096:1024"
  "1024×4096×4096:1024:4096:4096"
  "K=256:4096:4096:256"
  "K=4096:4096:4096:4096"
  "N=512:4096:512:4096"
)

echo "cycle,label,M,N,K,time,gflops,gbs,intensity,vec_eff,tail_overhead,bound" > "${RESULTS_DIR}/all_results.csv"
log "24-hour benchmark started"
log "Total test cases: ${#ALL_TESTS[@]}"

CYCLE=1
START_ALL=$(date +%s)

while true; do
  log "=== STARTING CYCLE ${CYCLE} ==="
  START_CYCLE=$(date +%s)

  for t in "${ALL_TESTS[@]}"; do
    IFS=':' read -r label M N K <<< "$t"
    run_bench "$M" "$N" "$K" "$label" "$CYCLE"
    sleep 2
  done

  END_CYCLE=$(date +%s)
  CYCLE_TIME=$((END_CYCLE - START_CYCLE))
  log "Cycle ${CYCLE} completed in ${CYCLE_TIME} seconds"

  NOW=$(date +%s)
  ELAPSED=$((NOW - START_ALL))
  if [[ ${ELAPSED} -ge 86400 ]]; then
    log "24 hours completed! Total cycles: ${CYCLE}"
    break
  fi

  CYCLE=$((CYCLE + 1))
done

log "Benchmark COMPLETE!"
echo "====================================================="
echo "24-HOUR BENCHMARK FINISHED AT: $(date)"
echo "Results saved to: ${RESULTS_DIR}/"
echo "Total cycles completed: ${CYCLE}"
echo "====================================================="
