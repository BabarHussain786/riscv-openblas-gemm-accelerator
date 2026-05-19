#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUT_DIR="${BASE_DIR}/summary_results_1024"
mkdir -p "${OUT_DIR}"

M="${M:-1024}"
N="${N:-1024}"
K="${K:-1024}"
RUNS="${RUNS:-6}"
AI_CPUSET="${AI_CPUSET:-0-3}"
GP_CPUSET="${GP_CPUSET:-4-7}"
RUN_ON="${RUN_ON:-ai}"  # ai | gp | both
KEEP_OLD_LOGS="${KEEP_OLD_LOGS:-0}"  # 0: clean old per-kernel logs before run

if command -v taskset >/dev/null 2>&1; then
  HAVE_TASKSET=1
else
  HAVE_TASKSET=0
fi

TS="$(date +"%Y%m%d_%H%M%S")"
LIVE_LOG="${OUT_DIR}/FP32_live_${TS}.log"

FP32_ROOT="${BASE_DIR}/FP32_SGEMM_RVV_Vector_Kernel_8x8"

declare -a RUN_TARGETS=()

build_run_targets() {
  case "${RUN_ON}" in
    ai)
      RUN_TARGETS=("AI:${AI_CPUSET}")
      ;;
    gp)
      RUN_TARGETS=("GP:${GP_CPUSET}")
      ;;
    both)
      RUN_TARGETS=("AI:${AI_CPUSET}" "GP:${GP_CPUSET}")
      ;;
    *)
      echo "[ERROR] RUN_ON must be one of: ai, gp, both (got: ${RUN_ON})" | tee -a "${LIVE_LOG}"
      exit 1
      ;;
  esac
}

tag_from_target() {
  local label="$1"
  local cpuset="$2"
  printf "%s_%s" "${label}" "${cpuset}" | tr ',-' '__'
}

run_bench_cmd() {
  local cpuset="$1"
  shift
  if [ "${HAVE_TASKSET}" -eq 1 ]; then
    taskset -c "${cpuset}" "$@"
  else
    "$@"
  fi
}

cleanup_old_logs() {
  if [ "${KEEP_OLD_LOGS}" = "1" ]; then
    return 0
  fi
  rm -f "${OUT_DIR}"/sgemm_kernel_8x8_*_lmul*_unroll*_AI_*_square_results.log
  rm -f "${OUT_DIR}"/sgemm_kernel_8x8_*_lmul*_unroll*_GP_*_square_results.log
}

run_FP32() {
  mapfile -t dirs < <(find "${FP32_ROOT}" -maxdepth 1 -type d -name "sgemm_kernel_8x8_*_lmul*_unroll*" | sort)
  if [ "${#dirs[@]}" -eq 0 ]; then
    echo "[ERROR] No FP32 kernel directories found." | tee -a "${LIVE_LOG}"
    exit 1
  fi

  for d in "${dirs[@]}"; do
    kernel="$(basename "${d}")"
    echo "" | tee -a "${LIVE_LOG}"
    echo "==================================================" | tee -a "${LIVE_LOG}"
    echo "KERNEL: ${kernel}" | tee -a "${LIVE_LOG}"
    echo "==================================================" | tee -a "${LIVE_LOG}"

    (
      cd "${d}" || exit 1

      make clean >/dev/null 2>&1 || true
      if ! make >/tmp/make_${kernel}.log 2>&1; then
        echo "[ERROR] build failed for ${kernel}" | tee -a "${LIVE_LOG}"
        cat "/tmp/make_${kernel}.log" | tee -a "${LIVE_LOG}"
        rm -f "/tmp/make_${kernel}.log"
        exit 0
      fi
      rm -f "/tmp/make_${kernel}.log"

      for target in "${RUN_TARGETS[@]}"; do
        label="${target%%:*}"
        cpuset="${target#*:}"
        target_tag="$(tag_from_target "${label}" "${cpuset}")"
        log_file="${OUT_DIR}/${kernel}_${target_tag}_square_results.log"
        target_failed=0
        : > "${log_file}"

        {
          echo "Kernel: ${kernel}__${target_tag}"
          echo "Shape: ${M} x ${N} x ${K}"
          echo "CPUSET: ${cpuset}"
        } >> "${log_file}"

        echo "TARGET: ${label} (cpuset=${cpuset})" | tee -a "${LIVE_LOG}"

        for run in $(seq 1 "${RUNS}"); do
          rc=0
          if local_out="$(run_bench_cmd "${cpuset}" ./bench "${M}" "${N}" "${K}" 2>&1)"; then
            rc=0
          else
            rc=$?
          fi

          if [ "${rc}" -eq 0 ] && ! printf "%s\n" "${local_out}" | grep -q '^GFLOPS:'; then
            rc=98
            local_out="${local_out}
[WARN] missing GFLOPS line in benchmark output"
          fi

          {
            echo "Run ${run}"
            echo "Target: ${label}"
            echo "CPUSET: ${cpuset}"
            echo "${local_out}"
          } >> "${log_file}"

          echo "Run ${run} [${label} ${cpuset}]" | tee -a "${LIVE_LOG}"
          echo "${local_out}" | tee -a "${LIVE_LOG}"

          if [ "${rc}" -ne 0 ]; then
            target_failed=1
            echo "[WARN] bench exited non-zero for ${kernel} on ${label} (exit ${rc})" | tee -a "${LIVE_LOG}"
            break
          fi
        done

        if [ "${target_failed}" -eq 0 ]; then
          echo "Status: OK" >> "${log_file}"
        else
          echo "Status: FAILED" >> "${log_file}"
        fi
      done
    )
  done
}

merge_FP32() {
  merged="${OUT_DIR}/FP32_square_${M}_runs${RUNS}.log"
  {
    echo "FP32 merged results"
    echo "Generated: $(date)"
    echo
    for f in "${OUT_DIR}"/sgemm_kernel_8x8_*_lmul*_unroll*_AI_*_square_results.log \
             "${OUT_DIR}"/sgemm_kernel_8x8_*_lmul*_unroll*_GP_*_square_results.log; do
      [ -f "${f}" ] || continue
      grep -q '^Status: OK$' "${f}" || continue
      grep -q '^GFLOPS:' "${f}" || continue
      echo "=================================================="
      echo "FILE: $(basename "${f}")"
      echo "=================================================="
      cat "${f}"
      echo
    done
  } > "${merged}"
  echo "Merged file: ${merged}" | tee -a "${LIVE_LOG}"
}

build_run_targets
cleanup_old_logs
echo "FP32 real-performance run" | tee "${LIVE_LOG}"
echo "Generated: $(date)" | tee -a "${LIVE_LOG}"
echo "RUN_ON=${RUN_ON}, AI_CPUSET=${AI_CPUSET}, GP_CPUSET=${GP_CPUSET}" | tee -a "${LIVE_LOG}"
echo "M=${M} N=${N} K=${K} RUNS=${RUNS}" | tee -a "${LIVE_LOG}"
echo "KEEP_OLD_LOGS=${KEEP_OLD_LOGS}" | tee -a "${LIVE_LOG}"
if [ "${HAVE_TASKSET}" -eq 1 ]; then
  echo "taskset: enabled" | tee -a "${LIVE_LOG}"
else
  echo "taskset: NOT FOUND (running without affinity pinning)" | tee -a "${LIVE_LOG}"
fi

run_FP32
merge_FP32
echo "Saved live log to: ${LIVE_LOG}" | tee -a "${LIVE_LOG}"
