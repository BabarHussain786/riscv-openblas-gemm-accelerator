#!/usr/bin/env bash
set -u

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${BASE_DIR}/summary_results_1024"
mkdir -p "${OUT_DIR}"

M="${M:-1024}"
N="${N:-1024}"
K="${K:-1024}"
RUNS="${RUNS:-6}"
AI_CPUSET="${AI_CPUSET:-0-3}"
GP_CPUSET="${GP_CPUSET:-4-6}"
RUN_ON="${RUN_ON:-ai}"  # ai | gp | both

if command -v taskset >/dev/null 2>&1; then
  HAVE_TASKSET=1
else
  HAVE_TASKSET=0
fi

TS="$(date +"%Y%m%d_%H%M%S")"
LIVE_LOG="${OUT_DIR}/ime_live_${TS}.log"

IME_ROOT="${BASE_DIR}/IME_KERNEL_8x4_WITH_RVV_AND_SCALAR_FALLBACK"

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

run_ime() {
  mapfile -t dirs < <(find "${IME_ROOT}" -maxdepth 1 -type d -name "ime_kernel_8x4_zvl128b_*_unroll*" | sort)
  if [ "${#dirs[@]}" -eq 0 ]; then
    echo "[ERROR] No IME kernel directories found." | tee -a "${LIVE_LOG}"
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
        : > "${log_file}"

        {
          echo "Kernel: ${kernel}__${target_tag}"
          echo "Shape: ${M} x ${N} x ${K}"
          echo "CPUSET: ${cpuset}"
        } >> "${log_file}"

        if [ "${label}" = "GP" ]; then
          {
            echo "NOTE: IME on GP cpuset may use scalar fallback (not IME hardware path)."
          } >> "${log_file}"
          echo "[WARN] ${kernel} on GP (${cpuset}) may run scalar fallback." | tee -a "${LIVE_LOG}"
        fi

        echo "TARGET: ${label} (cpuset=${cpuset})" | tee -a "${LIVE_LOG}"

        for run in $(seq 1 "${RUNS}"); do
          rc=0
          if local_out="$(run_bench_cmd "${cpuset}" ./bench "${M}" "${N}" "${K}" 2>&1)"; then
            rc=0
          else
            rc=$?
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
            echo "[WARN] bench exited non-zero for ${kernel} on ${label} (exit ${rc})" | tee -a "${LIVE_LOG}"
            break
          fi
        done
      done
    )
  done
}

merge_ime() {
  merged="${OUT_DIR}/ime_square_${M}_runs${RUNS}.log"
  {
    echo "IME merged results"
    echo "Generated: $(date)"
    echo
    for f in "${OUT_DIR}"/ime_kernel_8x4_zvl128b_*_unroll*_AI_*_square_results.log \
             "${OUT_DIR}"/ime_kernel_8x4_zvl128b_*_unroll*_GP_*_square_results.log; do
      [ -f "${f}" ] || continue
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
echo "IME real-performance run" | tee "${LIVE_LOG}"
echo "Generated: $(date)" | tee -a "${LIVE_LOG}"
echo "RUN_ON=${RUN_ON}, AI_CPUSET=${AI_CPUSET}, GP_CPUSET=${GP_CPUSET}" | tee -a "${LIVE_LOG}"
echo "M=${M} N=${N} K=${K} RUNS=${RUNS}" | tee -a "${LIVE_LOG}"
if [ "${HAVE_TASKSET}" -eq 1 ]; then
  echo "taskset: enabled" | tee -a "${LIVE_LOG}"
else
  echo "taskset: NOT FOUND (running without affinity pinning)" | tee -a "${LIVE_LOG}"
fi
if [ "${RUN_ON}" != "ai" ]; then
  echo "[WARN] For true IME hardware performance, use RUN_ON=ai (AI_CPUSET=${AI_CPUSET})." | tee -a "${LIVE_LOG}"
fi

run_ime
merge_ime
echo "Saved live log to: ${LIVE_LOG}" | tee -a "${LIVE_LOG}"

