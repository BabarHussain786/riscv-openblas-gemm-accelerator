#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# SpacemiT K1 GEMM benchmark runner (IME + RVV)
# - Forces 6 benchmark iterations in both drivers
# - Compiles both binaries
# - Runs 2048x2048x2048 on CPU0 (AI) and CPU4 (GP)
# - Saves logs and summary
# ============================================================

M=2048
N=2048
K=2048
AI_CPU=0
GP_CPU=4
CC=${CC:-gcc}
CFLAGS="-O3 -march=rv64gcv -mabi=lp64d"

TS=$(date +"%Y%m%d_%H%M%S")
OUTDIR="results_2048_it6/${TS}"
mkdir -p "$OUTDIR"

IME_SRC="bench_main.c"
RVV_SRC="bench_rvv.c"

IME_BIN="gemm_ime"
RVV_BIN="gemm_rvv"

SUMMARY="${OUTDIR}/summary.txt"
IME_AI_LOG="${OUTDIR}/ime_cpu${AI_CPU}.log"
IME_GP_LOG="${OUTDIR}/ime_cpu${GP_CPU}.log"
RVV_AI_LOG="${OUTDIR}/rvv_cpu${AI_CPU}.log"
RVV_GP_LOG="${OUTDIR}/rvv_cpu${GP_CPU}.log"

log() { echo "$*" | tee -a "$SUMMARY"; }

patch_to_6_iters_bench_main() {
  # bench_main.c:
  #   int iters = 3; -> int iters = 6;
  #   "3 iterations" -> "6 iterations"
  sed -i \
    -e 's/int iters = 3;/int iters = 6;/' \
    -e 's/Benchmarking (3 iterations, reporting best)/Benchmarking (6 iterations, reporting best)/' \
    "$IME_SRC"
}

patch_to_6_iters_bench_rvv() {
  # bench_rvv.c:
  #   for (it<3) -> for (it<6)
  #   total_sec/3 -> total_sec/6
  #   "3 iterations" -> "6 iterations"
  sed -i \
    -e 's/Benchmarking (3 iterations)/Benchmarking (6 iterations)/' \
    -e 's/for (int it = 0; it < 3; it++)/for (int it = 0; it < 6; it++)/' \
    -e 's/total_sec \/ 3/total_sec \/ 6/g' \
    "$RVV_SRC"
}

run_case() {
  local cpu="$1"
  local bin="$2"
  local log_file="$3"
  local label="$4"

  log ""
  log "[RUN] ${label} on CPU ${cpu} | size ${M}x${N}x${K}"
  taskset -c "$cpu" "./$bin" "$M" "$N" "$K" | tee "$log_file"
}

extract_summary_block() {
  local f="$1"
  local tag="$2"
  log ""
  log "----- ${tag} -----"
  grep -E "Core:|Size:|Best time:|Avg time:|Best GOPS:|Avg GOPS:|Correct:" "$f" | tee -a "$SUMMARY" || true
}

# ------------------- START -------------------
: > "$SUMMARY"
log "SpacemiT K1 GEMM unified run"
log "Timestamp: $(date)"
log "Output: $OUTDIR"
log "Compiler: $CC"
log "CFLAGS: $CFLAGS"
log "Target size: ${M}x${N}x${K}"
log "CPU mapping: AI=${AI_CPU}, GP=${GP_CPU}"

log ""
log "[STEP 1] Patching benchmark drivers to 6 iterations..."
patch_to_6_iters_bench_main
patch_to_6_iters_bench_rvv
log "Patched: $IME_SRC, $RVV_SRC"

log ""
log "[STEP 2] Compiling binaries..."
$CC $CFLAGS -o "$IME_BIN" bench_main.c ime_kernel.c
$CC $CFLAGS -o "$RVV_BIN" bench_rvv.c rvv_kernel.c
log "Built: $IME_BIN, $RVV_BIN"

log ""
log "[STEP 3] Running benchmarks..."
run_case "$AI_CPU" "$IME_BIN" "$IME_AI_LOG" "IME"
run_case "$GP_CPU" "$IME_BIN" "$IME_GP_LOG" "IME"
run_case "$AI_CPU" "$RVV_BIN" "$RVV_AI_LOG" "RVV"
run_case "$GP_CPU" "$RVV_BIN" "$RVV_GP_LOG" "RVV"

log ""
log "[STEP 4] Summary extract"
extract_summary_block "$IME_AI_LOG" "IME on CPU${AI_CPU}"
extract_summary_block "$IME_GP_LOG" "IME on CPU${GP_CPU}"
extract_summary_block "$RVV_AI_LOG" "RVV on CPU${AI_CPU}"
extract_summary_block "$RVV_GP_LOG" "RVV on CPU${GP_CPU}"

log ""
log "Done. Full logs in: $OUTDIR"