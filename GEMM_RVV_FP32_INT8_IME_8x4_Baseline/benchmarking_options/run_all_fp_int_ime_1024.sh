#!/usr/bin/env bash
set -u

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${BASE_DIR}/summary_results_1024"
mkdir -p "${OUT_DIR}"

M="${M:-1024}"
N="${N:-1024}"
K="${K:-1024}"
RUNS="${RUNS:-6}"
AI_CPUSET="${AI_CPUSET:-0-3}"
GP_CPUSET="${GP_CPUSET:-4-7}"
RUN_ON="${RUN_ON:-both}"  # ai | gp | both

if command -v taskset >/dev/null 2>&1; then
  HAVE_TASKSET=1
else
  HAVE_TASKSET=0
fi

TS="$(date +"%Y%m%d_%H%M%S")"
LIVE_LOG="${OUT_DIR}/all_fp_int_ime_live_${TS}.log"

FP32_ROOT="${BASE_DIR}/FP32_SGEMM_RVV_Vector_Kernel"
INT8_ROOT="${BASE_DIR}/INT8_iGEMM_8x4"
INT8_MF2_ROOT="${BASE_DIR}/INT8_iGEMM_8x4"
INT8_MF4_ROOT="${BASE_DIR}/INT8_iGEMM_8x4"
INT8_MF8_ROOT="${BASE_DIR}/INT8_iGEMM_8x4"
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

run_family() {
  local family_name="$1"
  local family_root="$2"
  local pattern="$3"

  mapfile -t dirs < <(find "${family_root}" -maxdepth 1 -type d -name "${pattern}" | sort)
  if [ "${#dirs[@]}" -eq 0 ]; then
    echo "[WARN] ${family_name}: no kernel directories found for pattern ${pattern}" | tee -a "${LIVE_LOG}"
    return 0
  fi

  echo "" | tee -a "${LIVE_LOG}"
  echo "##################################################" | tee -a "${LIVE_LOG}"
  echo "FAMILY: ${family_name}" | tee -a "${LIVE_LOG}"
  echo "##################################################" | tee -a "${LIVE_LOG}"

  for d in "${dirs[@]}"; do
    local kernel
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
        for target in "${RUN_TARGETS[@]}"; do
          local label
          local cpuset
          local target_tag
          local log_file
          label="${target%%:*}"
          cpuset="${target#*:}"
          target_tag="$(tag_from_target "${label}" "${cpuset}")"
          log_file="${OUT_DIR}/${kernel}_${target_tag}_square_results.log"
          : > "${log_file}"
          {
            echo "Kernel: ${kernel}__${target_tag}"
            echo "Shape: ${M} x ${N} x ${K}"
            echo "CPUSET: ${cpuset}"
            echo "Build: FAILED"
            echo "Build log:"
            cat "/tmp/make_${kernel}.log"
          } >> "${log_file}"
        done
        rm -f "/tmp/make_${kernel}.log"
        exit 0
      fi
      rm -f "/tmp/make_${kernel}.log"

      for target in "${RUN_TARGETS[@]}"; do
        local label
        local cpuset
        local target_tag
        local log_file
        local run
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

        echo "TARGET: ${label} (cpuset=${cpuset})" | tee -a "${LIVE_LOG}"

        for run in $(seq 1 "${RUNS}"); do
          local local_out
          local rc
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
            echo "[ERROR] bench failed for ${kernel} on ${label} (exit ${rc})" | tee -a "${LIVE_LOG}"
            break
          fi
        done
      done
    )
  done
}

build_run_targets

echo "All FP/INT/IME kernel benchmarks (square ${M})" | tee "${LIVE_LOG}"
echo "Generated: $(date)" | tee -a "${LIVE_LOG}"
echo "RUNS: ${RUNS}" | tee -a "${LIVE_LOG}"
echo "RUN_ON: ${RUN_ON}" | tee -a "${LIVE_LOG}"
echo "AI_CPUSET: ${AI_CPUSET}" | tee -a "${LIVE_LOG}"
echo "GP_CPUSET: ${GP_CPUSET}" | tee -a "${LIVE_LOG}"
if [ "${HAVE_TASKSET}" -eq 1 ]; then
  echo "taskset: enabled" | tee -a "${LIVE_LOG}"
else
  echo "taskset: NOT FOUND (running without affinity pinning)" | tee -a "${LIVE_LOG}"
fi
echo "Output dir: ${OUT_DIR}" | tee -a "${LIVE_LOG}"

run_family "FP32" "${FP32_ROOT}" "sgemm_kernel_8x4_*_lmul*_unroll*"
run_family "INT8_iGEMM" "${INT8_ROOT}" "igemm_kernel_8x4_*_lmul[1248]_unroll*"
run_family "INT8_iGEMM_MF2" "${INT8_MF2_ROOT}" "igemm_kernel_8x4_*_lmulmf2_unroll*"
run_family "INT8_iGEMM_MF4" "${INT8_MF4_ROOT}" "igemm_kernel_8x4_*_lmulmf4_unroll*"
run_family "INT8_iGEMM_MF8" "${INT8_MF8_ROOT}" "igemm_kernel_8x4_*_lmulmf8_unroll*"
run_family "IME" "${IME_ROOT}" "ime_kernel_8x4_*_unroll*"

MERGED_FILE="${OUT_DIR}/all_fp_int_ime_square_${M}_runs${RUNS}.log"
{
  echo "All FP/INT/IME merged results"
  echo "Generated: $(date)"
  echo
  for f in "${OUT_DIR}"/*_square_results.log; do
    [ -f "${f}" ] || continue
    bn="$(basename "${f}")"
    case "${bn}" in
      # Accept both legacy logs (..._square_results.log) and target-tagged logs
      # (..._AI_0_3_square_results.log / ..._GP_4_7_square_results.log).
      sgemm_kernel_8x4_*_lmul*_unroll*_square_results.log|\
      sgemm_kernel_8x4_*_lmul*_unroll*_*_square_results.log|\
      igemm_kernel_8x4_*_lmul*_unroll*_square_results.log|\
      igemm_kernel_8x4_*_lmul*_unroll*_*_square_results.log|\
      ime_kernel_8x4_*_unroll*_square_results.log|\
      ime_kernel_8x4_*_unroll*_*_square_results.log)
        ;;
      *)
        continue
        ;;
    esac
    echo "=================================================="
    echo "FILE: ${bn}"
    echo "=================================================="
    cat "${f}"
    echo
  done
} > "${MERGED_FILE}"

echo "" | tee -a "${LIVE_LOG}"
echo "Saved full live output to: ${LIVE_LOG}" | tee -a "${LIVE_LOG}"
echo "Saved merged results to: ${MERGED_FILE}" | tee -a "${LIVE_LOG}"
