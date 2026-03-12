#!/usr/bin/env bash
# run_bench_dgemm_24h.sh — 24-HOUR RISC-V DGEMM COMPREHENSIVE BENCHMARK (FP64)
set -euo pipefail

TARGET="./dgemm_bench_8x8"
KERNEL_NAME="dgemm_kernel_8x8_zvl256b"

echo "====================================================="
echo "24-HOUR RISC-V DGEMM COMPREHENSIVE BENCHMARK (FP64)"
echo "Kernel: ${KERNEL_NAME}"
echo "Start:  $(date)"
echo "Host:   $(hostname)"
echo "Arch:   $(uname -m)"
echo "====================================================="

# -------- background mode --------
if [[ "${1:-}" == "bg" || "${1:-}" == "background" ]]; then
  LOGFILE="24h_benchmark_dgemm_$(date +%Y%m%d_%H%M%S).log"
  echo "Running 24-hour benchmark in BACKGROUND..."
  echo "Logs:    $LOGFILE"
  echo "Monitor: tail -f $LOGFILE"
  echo "Status:  ps aux | grep dgemm_bench_8x8"
  nohup "$0" 24h-foreground > "$LOGFILE" 2>&1 &
  echo "PID: $! | Stop: kill $!"
  exit 0
fi

# -------- build if needed --------
if [[ ! -x "$TARGET" ]]; then
  echo "Building DGEMM benchmark..."
  make clean >/dev/null 2>&1 || true
  make
  if [[ ! -x "$TARGET" ]]; then
    echo "✗ Build failed!"
    exit 1
  fi
  echo "✓ Build successful!"
fi

# -------- menu --------
if [[ "${1:-}" != "24h-foreground" ]]; then
  echo ""
  echo "USAGE:"
  echo "  ./run_bench_dgemm_24h.sh 24h      - 24-hour benchmark (interactive)"
  echo "  ./run_bench_dgemm_24h.sh bg       - 24-hour benchmark (background)"
  echo "  ./run_bench_dgemm_24h.sh quick    - Quick benchmark suite"
  echo ""
  echo "Quick test:"
  echo "  $TARGET 1024 1024 1024"
  echo ""
  echo "Options:"
  echo "  export BENCH_ITER=50              - Set iterations per test"
  echo "  export BENCH_WARMUP=10            - Set warmup iterations"
  exit 1
fi

# ===== 24-HOUR MAIN CODE =====
RESULTS_DIR="24h_results_dgemm_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

# Configuration
ITERATIONS=${BENCH_ITER:-30}
WARMUP=${BENCH_WARMUP:-5}

log() {
  echo "[$(date '+%m-%d %H:%M:%S')] $1" | tee -a "$RESULTS_DIR/benchmark.log"
}

run_bench() {
  local M=$1 N=$2 K=$3 label=$4 cycle=$5
  # Benchmark outputs: M N K time gflops gbs intensity vec_eff tail_overhead bound
  local out
  out="$($TARGET "$M" "$N" "$K" 1.0 "$WARMUP" "$ITERATIONS" 2>&1 | grep -E '^[0-9]' | tail -1)"
  
  if [[ -z "$out" ]]; then
    log "ERROR: Benchmark failed for $label"
    echo "$cycle,$label,ERROR,0,0,0,0,0,0,0,ERROR" >> "$RESULTS_DIR/all_results.csv"
    return 1
  fi
  
  echo "$cycle,$label,$out" >> "$RESULTS_DIR/all_results.csv"
  echo "$out" >> "$RESULTS_DIR/raw.csv"
  
  # Parse output
  local _M _N _K time gflops gbs intensity vec_eff tail_overhead bound
  read -r _M _N _K time gflops gbs intensity vec_eff tail_overhead bound <<< "$out"
  log "Cycle $cycle | $label: ${gflops} GFLOPS, ${time} sec, ${bound}"
}

# DGEMM-specific test cases (optimized for 8x8 kernel)
ALL_TESTS=(
  # Square matrices (primary)
  "1024³:1024:1024:1024"
  "1536³:1536:1536:1536"
  "2048³:2048:2048:2048"
  "2560³:2560:2560:2560"
  "3072³:3072:3072:3072"
  "3584³:3584:3584:3584"
  "4096³:4096:4096:4096"
  "5120³:5120:5120:5120"
  
  # Rectangular (common shapes)
  "4096×4096×1024:4096:4096:1024"
  "4096×1024×4096:4096:1024:4096"
  "1024×4096×4096:1024:4096:4096"
  
  # Tall & skinny (memory-bound)
  "8192×256×4096:8192:256:4096"
  "16384×128×4096:16384:128:4096"
  "32768×64×4096:32768:64:4096"
  
  # Wide (N-dimension scaling)
  "256×8192×4096:256:8192:4096"
  "128×16384×4096:128:16384:4096"
  "64×32768×4096:64:32768:4096"
  
  # K-dimension scaling
  "K=256:4096:4096:256"
  "K=512:4096:4096:512"
  "K=1024:4096:4096:1024"
  "K=2048:4096:4096:2048"
  "K=4096:4096:4096:4096"
  "K=8192:4096:4096:8192"
  
  # M-dimension scaling
  "M=512:512:4096:4096"
  "M=1024:1024:4096:4096"
  "M=2048:2048:4096:4096"
  "M=4096:4096:4096:4096"
  "M=8192:8192:4096:4096"
  
  # N-dimension scaling
  "N=512:4096:512:4096"
  "N=1024:4096:1024:4096"
  "N=2048:4096:2048:4096"
  "N=4096:4096:4096:4096"
  "N=8192:4096:8192:4096"
  
  # Small sizes (regression)
  "128³:128:128:128"
  "256³:256:256:256"
  "512³:512:512:512"
)

echo "cycle,label,M,N,K,time,gflops,gbs,intensity,vec_eff,tail_overhead,bound" > "$RESULTS_DIR/all_results.csv"
echo "M N K time gflops gbs intensity vec_eff tail_overhead bound" > "$RESULTS_DIR/raw.csv"

log "24-hour DGEMM comprehensive benchmark started"
log "Kernel: $KERNEL_NAME"
log "Iterations per test: $ITERATIONS"
log "Warmup per test: $WARMUP"
log "Total test cases: ${#ALL_TESTS[@]}"
log "Will run for approximately 24 hours"

CYCLE=1
START_24H=$(date +%s)
TOTAL_TESTS=${#ALL_TESTS[@]}

while true; do
  log "=== STARTING CYCLE $CYCLE ==="
  CYCLE_START=$(date +%s)
  TESTS_COMPLETED=0
  
  for t in "${ALL_TESTS[@]}"; do
    IFS=':' read -r label M N K <<< "$t"
    run_bench "$M" "$N" "$K" "$label" "$CYCLE"
    TESTS_COMPLETED=$((TESTS_COMPLETED + 1))
    
    # Progress indicator
    if (( TESTS_COMPLETED % 5 == 0 )); then
      log "Progress: $TESTS_COMPLETED/$TOTAL_TESTS tests completed in cycle $CYCLE"
    fi
    
    # Small pause between tests
    sleep 1
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
  
  # Adaptive sleep based on cycle time
  if (( CYCLE_TIME < 1800 )); then
    SLEEP_TIME=$((1800 - CYCLE_TIME))
    log "Sleeping for ${SLEEP_TIME} seconds before next cycle..."
    sleep "$SLEEP_TIME"
  fi
done

log "=== FINAL ANALYSIS ==="
awk -F, '
BEGIN { 
  total_gflops=0; count=0; cycles=0;
  print "=== 24-HOUR DGEMM BENCHMARK SUMMARY (FP64) ===";
  print "Kernel: dgemm_kernel_8x8_zvl256b";
  print "==============================================";
}
NR>1 && $7 != "ERROR" {
  gflops=$7;
  cycle=$1;
  label=$2;
  bound=$12;
  
  total_gflops += gflops;
  count++;
  
  if(!(cycle in seen_cycle)) { seen_cycle[cycle]=1; cycles++; }
  
  # Per-test statistics
  test_count[label]++; 
  test_sum[label] += gflops;
  if(!(label in test_min) || gflops < test_min[label]) test_min[label] = gflops;
  if(!(label in test_max) || gflops > test_max[label]) test_max[label] = gflops;
  
  # Bound classification
  bound_count[bound]++;
}
END {
  if(count > 0) {
    avg_gflops = total_gflops/count;
    print "Total samples: " count;
    print "Total cycles:  " cycles;
    print "Average GFLOPS: " sprintf("%.2f", avg_gflops);
    print "";
    
    print "=== BOUND CLASSIFICATION ===";
    for(b in bound_count) {
      printf "  %-10s: %d samples (%.1f%%)\n", b, bound_count[b], (bound_count[b]/count)*100;
    }
    print "";
    
    print "=== TOP 10 BEST PERFORMING TESTS ===";
    # Sort by average GFLOPS
    i = 0;
    for(t in test_count) {
      arr[i] = sprintf("%.2f:%s:%d", test_sum[t]/test_count[t], t, test_count[t]);
      i++;
    }
    n = asort(arr);
    for(j = n; j > n-10 && j > 0; j--) {
      split(arr[j], parts, ":");
      printf "  %-20s: %6.2f GFLOPS (min=%6.2f, max=%6.2f, samples=%d)\n", 
        parts[2], parts[1], test_min[parts[2]], test_max[parts[2]], parts[3];
    }
  } else {
    print "ERROR: No valid benchmark results found!";
  }
}' "$RESULTS_DIR/all_results.csv" | tee -a "$RESULTS_DIR/summary.txt"

# Generate simple CSV summary
awk -F, 'NR>1 && $7 != "ERROR" {
  label=$2; gflops=$7;
  sum[label] += gflops; count[label]++;
}
END {
  print "test,average_gflops,samples";
  for(t in sum) {
    print t "," sum[t]/count[t] "," count[t];
  }
}' "$RESULTS_DIR/all_results.csv" > "$RESULTS_DIR/summary.csv"

log "Benchmark COMPLETE!"
echo "====================================================="
echo "24-HOUR DGEMM BENCHMARK FINISHED AT: $(date)"
echo "Results saved to: $RESULTS_DIR/"
echo "Files:"
echo "  all_results.csv  - Complete results with cycle info"
echo "  raw.csv          - Raw benchmark output"
echo "  summary.txt      - Analysis summary"
echo "  summary.csv      - CSV summary"
echo "  benchmark.log    - Execution log"
echo "Total cycles completed: $CYCLE"
echo "====================================================="