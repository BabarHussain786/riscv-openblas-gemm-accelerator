#!/usr/bin/env bash
# run_bench_lmul8.sh - 24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK (LMUL=8 64x2)
set -euo pipefail

KERNEL_NAME="sgemm_kernel_64x2_zvl256b_lmul8"
BIN="./sgemm_bench"

SIZES=(256 512 768 1024 1280 1536 1792 2048 2304 2560 3072 3584 4096)
RECTS=( "1024 2048 2048" "2048 1024 2048" "2048 2048 1024" "4096 2048 4096" "2048 4096 4096" )

ts() { date "+[%m-%d %H:%M:%S]"; }

usage() {
  cat <<EOF
Usage:
  $0 24h        Run ~24 hours (interactive)
  $0 bg         Run in background (nohup)
  $0 monitor    Show status + tail of newest log
  $0 status     Only print RUNNING/STOPPED + PID
  $0 kill       Stop running benchmark
EOF
}

status_only() {
  if pgrep -f "sgemm_bench" >/dev/null 2>&1; then
    echo "STATUS: RUNNING"
    pgrep -f "sgemm_bench" | head -1 | awk '{print "PID:",$1}'
  else
    echo "STATUS: STOPPED"
  fi
}

monitor() {
  status_only
  local latest
  latest="$(ls -t 24h_benchmark_lmul8_*.log 2>/dev/null | head -1 || true)"
  if [[ -n "${latest}" ]]; then
    echo ""
    echo "Latest log: ${latest}"
    tail -20 "${latest}" || true
  else
    echo "No log found yet."
  fi
}

kill_run() {
  pkill -f "sgemm_bench" >/dev/null 2>&1 || true
  echo "✓ Stopped any running sgemm_bench"
}

run_24h() {
  if [[ ! -x "${BIN}" ]]; then
    echo "❌ ${BIN} not found. Run: make"
    exit 1
  fi

  local LOGFILE="24h_benchmark_lmul8_$(date +%Y%m%d_%H%M%S).log"
  local start end now
  start="$(date +%s)"
  end="$((start + 24*3600))"

  {
    echo "====================================================="
    echo "24-HOUR RISC-V SGEMM COMPREHENSIVE BENCHMARK"
    echo "Kernel: ${KERNEL_NAME} (LMUL=8, 64x2)"
    echo "Start: $(date)"
    echo "Host: $(hostname)"
    echo "====================================================="
    echo "$(ts) 24-hour comprehensive benchmark started"
  } | tee -a "${LOGFILE}"

  local cycle=0
  while :; do
    now="$(date +%s)"
    if (( now >= end )); then
      echo "$(ts) ✅ 24-hour time limit reached. Stopping." | tee -a "${LOGFILE}"
      break
    fi

    cycle=$((cycle+1))
    echo "$(ts) === STARTING CYCLE ${cycle} ===" | tee -a "${LOGFILE}"

    for s in "${SIZES[@]}"; do
      now="$(date +%s)"; if (( now >= end )); then break; fi
      line="$(${BIN} "${s}" "${s}" "${s}" 1.0 3 10)"
      read -r M N K t gflops gbs intensity vec_eff tail bound <<<"${line}"
      echo "$(ts) Cycle ${cycle} | ${s}³: ${gflops} GFLOPS, ${t} sec, ${bound}" | tee -a "${LOGFILE}"
    done

    for r in "${RECTS[@]}"; do
      now="$(date +%s)"; if (( now >= end )); then break; fi
      read -r M N K <<<"${r}"
      line="$(${BIN} "${M}" "${N}" "${K}" 1.0 3 10)"
      read -r _M _N _K t gflops gbs intensity vec_eff tail bound <<<"${line}"
      echo "$(ts) Cycle ${cycle} | ${M}x${N}x${K}: ${gflops} GFLOPS, ${t} sec, ${bound}" | tee -a "${LOGFILE}"
    done
  done

  echo "$(ts) Benchmark finished. Log saved: ${LOGFILE}" | tee -a "${LOGFILE}"
}

run_bg() {
  local LOGFILE="24h_benchmark_lmul8_$(date +%Y%m%d_%H%M%S).log"
  echo "Starting background run, log: ${LOGFILE}"
  nohup bash "$0" 24h > "${LOGFILE}" 2>&1 &
  echo "✓ Background PID: $!"
}

cmd="${1:-}"
case "${cmd}" in
  24h) run_24h ;;
  bg|background) run_bg ;;
  monitor) monitor ;;
  status) status_only ;;
  kill) kill_run ;;
  ""|-h|--help|help) usage ;;
  *) echo "Unknown command: ${cmd}"; usage; exit 1 ;;
esac
