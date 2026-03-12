#!/usr/bin/env bash
# run_bench_lmul2.sh — 24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK (LMUL=2)
set -euo pipefail

TARGET="./sgemm_bench_lmul2"
KERNEL_NAME="sgemm_kernel_16x8_zvl256b_lmul2"

echo "====================================================="
echo "24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK"
echo "Kernel: ${KERNEL_NAME}"
echo "Start:  $(date)"
echo "Host:   $(hostname)"
echo "====================================================="

# -------- background mode --------
if [[ "${1:-}" == "bg" || "${1:-}" == "background" ]]; then
  LOGFILE="24h_benchmark_lmul2_$(date +%Y%m%d_%H%M%S).log"
  echo "Running 24-hour benchmark in BACKGROUND..."
  echo "Logs:    $LOGFILE"
  echo "Monitor: tail -f $LOGFILE"
  echo "Status:  ps aux | grep sgemm_bench_lmul2"
  nohup "$0" 24h-foreground > "$LOGFILE" 2>&1 &
  echo "PID: $! | Stop: kill $!"
  exit 0
fi

# -------- build if needed --------
if [[ ! -x "$TARGET" ]]; then
  echo "Building benchmark..."
  gcc -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra \
      sgemm_kernel_16x8_zvl256b_lmul2.c \
      sgemm_kernel_16x8_zvl256b_lmul2_benchmark.c \
      -o sgemm_bench_lmul2 -lm
  echo "✓ Build successful!"
fi

# -------- menu --------
if [[ "${1:-}" != "24h-foreground" ]]; then
  echo ""
  echo "USAGE:"
  echo "  ./run_bench_lmul2.sh 24h      - 24-hour benchmark (interactive)"
  echo "  ./run_bench_lmul2.sh bg       - 24-hour benchmark (background)"
  echo ""
  echo "Quick test:"
  echo "  $TARGET 1024 1024 1024"
  exit 1
fi

# ===== 24-HOUR MAIN CODE =====
RESULTS_DIR="24h_results_lmul2_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

log() {
  echo "[$(date '+%m-%d %H:%M:%S')] $1" | tee -a "$RESULTS_DIR/benchmark.log"
}

run_bench() {
  local M=$1 N=$2 K=$3 label=$4 cycle=$5
  # driver prints one line: M N K time gflops gbs intensity vec_eff tail_overhead bound
  local out
  out="$($TARGET "$M" "$N" "$K" 1.0 3 30 2>&1 | tail -1)"

  echo "$cycle,$label,$out" >> "$RESULTS_DIR/all_results.csv"
  echo "$out" >> "$RESULTS_DIR/raw.csv"

  # parse
  local _M _N _K time gflops gbs intensity vec_eff tail_overhead bound
  read -r _M _N _K time gflops gbs intensity vec_eff tail_overhead bound <<< "$out"
  log "Cycle $cycle | $label: ${gflops} GFLOPS, ${time} sec, ${bound}"
}

ALL_TESTS=(
  # Square
  "1024³:1024:1024:1024"
  "1280³:1280:1280:1280"
  "1536³:1536:1536:1536"
  "1792³:1792:1792:1792"
  "2048³:2048:2048:2048"
  "2560³:2560:2560:2560"
  "3072³:3072:3072:3072"
  "3584³:3584:3584:3584"
  "4096³:4096:4096:4096"

  # Rectangular
  "4096×4096×1024:4096:4096:1024"
  "4096×1024×4096:4096:1024:4096"
  "1024×4096×4096:1024:4096:4096"

  # Tall & skinny
  "8192×256×4096:8192:256:4096"
  "16384×128×4096:16384:128:4096"
  "32768×64×4096:32768:64:4096"

  # Wide
  "256×8192×4096:256:8192:4096"
  "128×16384×4096:128:16384:4096"
  "64×32768×4096:64:32768:4096"

  # K scaling
  "K=256:4096:4096:256"
  "K=512:4096:4096:512"
  "K=1024:4096:4096:1024"
  "K=2048:4096:4096:2048"
  "K=4096:4096:4096:4096"
  "K=8192:4096:4096:8192"
  "K=16384:4096:4096:16384"

  # M scaling
  "M=512:512:4096:4096"
  "M=1024:1024:4096:4096"
  "M=2048:2048:4096:4096"
  "M=4096:4096:4096:4096"
  "M=8192:8192:4096:4096"
  "M=16384:16384:4096:4096"

  # N scaling
  "N=512:4096:512:4096"
  "N=1024:4096:1024:4096"
  "N=2048:4096:2048:4096"
  "N=4096:4096:4096:4096"
  "N=8192:4096:8192:4096"
  "N=16384:4096:16384:4096"
)

echo "cycle,label,M,N,K,time,gflops,gbs,intensity,vec_eff,tail_overhead,bound" > "$RESULTS_DIR/all_results.csv"

log "24-hour comprehensive benchmark started"
log "Kernel: $KERNEL_NAME"
log "Total test cases: ${#ALL_TESTS[@]}"
log "Will run for approximately 24 hours"

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

  CYCLE_END=$(date +%s)
  CYCLE_TIME=$((CYCLE_END - CYCLE_START))
  log "Cycle $CYCLE completed in ${CYCLE_TIME} seconds"

  NOW=$(date +%s)
  ELAPSED=$((NOW - START_24H))
  if (( ELAPSED >= 86400 )); then
    log "24 hours completed! Total cycles: $CYCLE"
    break
  fi

  CYCLE=$((CYCLE + 1))

  # If a cycle ends early, sleep a bit (optional; keeps thermals calmer)
  if (( CYCLE_TIME < 3600 )); then
    SLEEP_TIME=$((3600 - CYCLE_TIME))
    log "Sleeping for ${SLEEP_TIME} seconds before next cycle..."
    sleep "$SLEEP_TIME"
  fi
done

log "=== FINAL ANALYSIS ==="
awk -F, '
BEGIN { total=0; count=0; cycles=0; }
NR>1 {
  gflops=$7;
  cycle=$1;
  label=$2;

  total += gflops;
  count++;

  if(!(cycle in seen)) { seen[cycle]=1; cycles++; }

  test_count[label]++; test_sum[label] += gflops;
}
END {
  print "=== 24-HOUR BENCHMARK SUMMARY (LMUL=2) ===";
  if(count>0) {
    avg = total/count;
    printf "Total samples: %d\n", count;
    printf "Total cycles:  %d\n", cycles;
    printf "Average GFLOPS: %.2f\n\n", avg;

    print "=== PER-TEST AVERAGES ===";
    for(t in test_count) {
      printf "%-24s : %.2f GFLOPS (%d samples)\n", t, test_sum[t]/test_count[t], test_count[t];
    }
  }
}' "$RESULTS_DIR/all_results.csv" | tee -a "$RESULTS_DIR/summary.txt"

log "Benchmark COMPLETE!"
echo "====================================================="
echo "24-HOUR BENCHMARK FINISHED AT: $(date)"
echo "Results saved to: $RESULTS_DIR/"
echo "Total cycles completed: $CYCLE"
echo "====================================================="
