#!/usr/bin/env bash
# run_bench_kunroll2.sh — 24-HOUR SGEMM K-UNROLL×2 BENCHMARK (LMUL=1)

set -euo pipefail

TARGET="./sgemm_kunroll2_bench"
KERNEL_NAME="sgemm_kernel_16x8_zvl256b_lmul1_kunroll2"

echo "====================================================="
echo "24-HOUR RISC-V SGEMM BENCHMARK (K-UNROLL ×2)"
echo "Kernel: ${KERNEL_NAME}"
echo "Start:  $(date)"
echo "Host:   $(hostname)"
echo "====================================================="

# ---------- background mode ----------
if [[ "${1:-}" == "bg" || "${1:-}" == "background" ]]; then
  LOGFILE="24h_benchmark_kunroll2_$(date +%Y%m%d_%H%M%S).log"
  echo "Running in BACKGROUND"
  echo "Log file: $LOGFILE"
  nohup "$0" 24h-foreground > "$LOGFILE" 2>&1 &
  echo "PID: $!"
  exit 0
fi

# ---------- build if needed ----------
if [[ ! -x "$TARGET" ]]; then
  echo "Building K-unroll×2 benchmark..."
  make sgemm_kunroll2_bench
  echo "✓ Build successful"
fi

# ---------- usage ----------
if [[ "${1:-}" != "24h-foreground" ]]; then
  echo ""
  echo "USAGE:"
  echo "  ./run_bench_kunroll2.sh 24h      # interactive"
  echo "  ./run_bench_kunroll2.sh bg       # background"
  exit 1
fi

# ---------- test cases ----------
ALL_TESTS=(
  # Square
  "1024³:1024:1024:1024"
  "2048³:2048:2048:2048"
  "4096³:4096:4096:4096"

  # Rectangular
  "4096×4096×1024:4096:4096:1024"
  "1024×4096×4096:1024:4096:4096"

  # K scaling
  "K=1024:4096:4096:1024"
  "K=4096:4096:4096:4096"

  # M scaling
  "M=4096:4096:4096:4096"

  # N scaling
  "N=4096:4096:4096:4096"
)

RESULTS_DIR="24h_results_kunroll2_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

echo "cycle,label,M,N,K,time,gflops,gbs,intensity,vec_eff,tail_overhead,bound" \
  > "$RESULTS_DIR/all_results.csv"

log() {
  echo "[$(date '+%m-%d %H:%M:%S')] $1" | tee -a "$RESULTS_DIR/benchmark.log"
}

run_case() {
  local M=$1 N=$2 K=$3 label=$4 cycle=$5
  local out

  out="$($TARGET "$M" "$N" "$K" 30 0 | tail -1)"

  echo "$cycle,$label,$out" >> "$RESULTS_DIR/all_results.csv"
  log "Cycle $cycle | $label: $(echo "$out" | awk '{print $5}') GFLOPS"
}

# ---------- main loop ----------
START_24H=$(date +%s)
CYCLE=1

log "24-hour benchmark started"
log "Kernel: $KERNEL_NAME"
log "Total tests per cycle: ${#ALL_TESTS[@]}"

while true; do
  log "=== STARTING CYCLE $CYCLE ==="
  CYCLE_START=$(date +%s)

  for t in "${ALL_TESTS[@]}"; do
    IFS=':' read -r label M N K <<< "$t"
    run_case "$M" "$N" "$K" "$label" "$CYCLE"
    sleep 2
  done

  CYCLE_END=$(date +%s)
  log "Cycle $CYCLE completed in $((CYCLE_END - CYCLE_START)) seconds"

  if (( $(date +%s) - START_24H >= 86400 )); then
    log "24 hours completed"
    break
  fi

  CYCLE=$((CYCLE + 1))
done

log "=== BENCHMARK COMPLETE ==="
echo "Results saved to: $RESULTS_DIR"
