#!/usr/bin/env bash
# run_bench_lmul1.sh — 24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK (LMUL=1)
set -euo pipefail

TARGET="./sgemm_bench_lmul1"
KERNEL_NAME="sgemm_kernel_16x8_zvl256b_lmul1_opt"

echo "====================================================="
echo "24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK"
echo "Kernel: ${KERNEL_NAME}"
echo "Start:  $(date)"
echo "Host:   $(hostname)"
echo "====================================================="

# -------- background mode --------
if [[ "${1:-}" == "bg" || "${1:-}" == "background" ]]; then
  LOGFILE="24h_benchmark_lmul1_$(date +%Y%m%d_%H%M%S).log"
  echo "Running 24-hour benchmark in BACKGROUND..."
  echo "Logs:    $LOGFILE"
  echo "Monitor: tail -f $LOGFILE"
  echo "Status:  ps aux | grep sgemm_bench_lmul1"
  nohup "$0" 24h-foreground > "$LOGFILE" 2>&1 &
  echo "PID: $! | Stop: kill $!"
  exit 0
fi

# -------- build if needed --------
if [[ ! -x "$TARGET" ]]; then
  echo "Building benchmark..."
  gcc -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra \
      sgemm_kernel_16x8_zvl256b_lmul1_opt.c \
      sgemm_kernel_16x8_zvl256b_lmul1_opt_benchmark.c \
      -o sgemm_bench_lmul1 -lm
  echo "✓ Build successful!"
fi

# -------- menu --------
if [[ "${1:-}" != "24h-foreground" ]]; then
  echo ""
  echo "USAGE:"
  echo "  ./run_bench_lmul1.sh 24h      - 24-hour benchmark (interactive)"
  echo "  ./run_bench_lmul1.sh bg       - 24-hour benchmark (background)"
  echo ""
  echo "Quick test:"
  echo "  $TARGET 1024 1024 1024"
  exit 1
fi

# ===== 24-HOUR MAIN CODE =====
RESULTS_DIR="24h_results_lmul1_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

log() {
  echo "[$(date '+%m-%d %H:%M:%S')] $1" | tee -a "$RESULTS_DIR/benchmark.log"
}

run_bench() {
  local M=$1 N=$2 K=$3 label=$4 cycle=$5
  local out
  out="$($TARGET "$M" "$N" "$K" 1.0 3 30 2>&1 | tail -1)"

  echo "$cycle,$label,$out" >> "$RESULTS_DIR/all_results.csv"
  echo "$out" >> "$RESULTS_DIR/raw.csv"

  local _M _N _K time gflops gbs intensity vec_eff tail_overhead bound
  read -r _M _N _K time gflops gbs intensity vec_eff tail_overhead bound <<< "$out"
  log "Cycle $cycle | $label: ${gflops} GFLOPS, ${time} sec, ${bound}"
}

ALL_TESTS=(
  # Square
  "1024³:1024:1024:1024"
  "2048³:2048:2048:2048"
  "4096³:4096:4096:4096"

  # Rectangular
  "4096×4096×1024:4096:4096:1024"
  "1024×4096×4096:1024:4096:4096"

  # Tall & skinny
  "16384×128×4096:16384:128:4096"

  # Wide
  "128×16384×4096:128:16384:4096"

  # K scaling
  "K=256:4096:4096:256"
  "K=1024:4096:4096:1024"
  "K=4096:4096:4096:4096"

  # M scaling
  "M=1024:1024:4096:4096"
  "M=4096:4096:4096:4096"

  # N scaling
  "N=1024:4096:1024:4096"
  "N=4096:4096:4096:4096"
)

echo "cycle,label,M,N,K,time,gflops,gbs,intensity,vec_eff,tail_overhead,bound" \
  > "$RESULTS_DIR/all_results.csv"

log "24-hour comprehensive benchmark started"
log "Kernel: $KERNEL_NAME"
log "Total test cases: ${#ALL_TESTS[@]}"

CYCLE=1
START_24H=$(date +%s)

while true; do
  log "=== STARTING CYCLE $CYCLE ==="
  CYCLE_START=$(date +%s)

  for t in "${ALL_TESTS[@]}"; do
    IFS=':' read -r label M N K <<< "$t"
    run_bench "$M" "$N" "$K" "$label" "$CYCLE"
    sleep 2
  done

  NOW=$(date +%s)
  if (( NOW - START_24H >= 86400 )); then
    log "24 hours completed!"
    break
  fi

  CYCLE=$((CYCLE + 1))
done

log "Benchmark COMPLETE!"
echo "====================================================="
echo "24-HOUR BENCHMARK FINISHED AT: $(date)"
echo "Results saved to: $RESULTS_DIR/"
echo "====================================================="
