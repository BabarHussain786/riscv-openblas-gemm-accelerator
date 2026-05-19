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
RUN_ON="${RUN_ON:-both}"  # ai | gp | both
INCLUDE_MF8="${INCLUDE_MF8:-0}"      # 0: skip unsupported mf8 variants, 1: include
KEEP_OLD_LOGS="${KEEP_OLD_LOGS:-0}"  # 0: clean old per-kernel logs before run

if command -v taskset >/dev/null 2>&1; then
  HAVE_TASKSET=1
else
  HAVE_TASKSET=0
fi

TS="$(date +"%Y%m%d_%H%M%S")"
LIVE_LOG="${OUT_DIR}/all_fp_int_ime_live_${TS}.log"

FP32_ROOT="${BASE_DIR}/FP32_SGEMM_RVV_Vector_Kernel_8x8"
INT8_ROOT="${BASE_DIR}/INT8_iGEMM_8x8"
INT8_MF2_ROOT="${BASE_DIR}/INT8_iGEMM_8x8"
INT8_MF4_ROOT="${BASE_DIR}/INT8_iGEMM_8x8"
INT8_MF8_ROOT="${BASE_DIR}/INT8_iGEMM_8x8"
IME_ROOT="${BASE_DIR}/IME_KERNEL_8x8_WITH_RVV_FALLBACK"

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
  rm -f "${OUT_DIR}"/igemm_kernel_8x8_*_lmul*_unroll*_AI_*_square_results.log
  rm -f "${OUT_DIR}"/igemm_kernel_8x8_*_lmul*_unroll*_GP_*_square_results.log
  rm -f "${OUT_DIR}"/ime_kernel_8x8_zvl128b_lmul*_unroll*_AI_*_square_results.log
  rm -f "${OUT_DIR}"/ime_kernel_8x8_zvl128b_lmul*_unroll*_GP_*_square_results.log
}

run_family() {
  local family_name="$1"
  local family_root="$2"
  local pattern="$3"
  local metric_key="${4:-GOPS:}"

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
        local target_failed=0

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

          if [ "${rc}" -eq 0 ] && ! printf "%s\n" "${local_out}" | grep -q "^${metric_key}"; then
            rc=98
            local_out="${local_out}
[WARN] missing ${metric_key} line in benchmark output"
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
            echo "[ERROR] bench failed for ${kernel} on ${label} (exit ${rc})" | tee -a "${LIVE_LOG}"
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

build_run_targets
cleanup_old_logs

echo "All FP/INT/IME kernel benchmarks (square ${M})" | tee "${LIVE_LOG}"
echo "Generated: $(date)" | tee -a "${LIVE_LOG}"
echo "RUNS: ${RUNS}" | tee -a "${LIVE_LOG}"
echo "RUN_ON: ${RUN_ON}" | tee -a "${LIVE_LOG}"
echo "AI_CPUSET: ${AI_CPUSET}" | tee -a "${LIVE_LOG}"
echo "GP_CPUSET: ${GP_CPUSET}" | tee -a "${LIVE_LOG}"
echo "INCLUDE_MF8: ${INCLUDE_MF8}" | tee -a "${LIVE_LOG}"
echo "KEEP_OLD_LOGS: ${KEEP_OLD_LOGS}" | tee -a "${LIVE_LOG}"
if [ "${HAVE_TASKSET}" -eq 1 ]; then
  echo "taskset: enabled" | tee -a "${LIVE_LOG}"
else
  echo "taskset: NOT FOUND (running without affinity pinning)" | tee -a "${LIVE_LOG}"
fi
echo "Output dir: ${OUT_DIR}" | tee -a "${LIVE_LOG}"

run_family "FP32" "${FP32_ROOT}" "sgemm_kernel_8x8_*_lmul*_unroll*" "GFLOPS:"
run_family "INT8_iGEMM_LMUL1" "${INT8_ROOT}" "igemm_kernel_8x8_*_lmul1_unroll*" "GOPS:"
run_family "INT8_iGEMM_LMUL2" "${INT8_ROOT}" "igemm_kernel_8x8_*_lmul2_unroll*" "GOPS:"
run_family "INT8_iGEMM_LMUL4" "${INT8_ROOT}" "igemm_kernel_8x8_*_lmul4_unroll*" "GOPS:"
run_family "INT8_iGEMM_LMUL8" "${INT8_ROOT}" "igemm_kernel_8x8_*_lmul8_unroll*" "GOPS:"
run_family "INT8_iGEMM_MF2" "${INT8_MF2_ROOT}" "igemm_kernel_8x8_*_lmulmf2_unroll*" "GOPS:"
run_family "INT8_iGEMM_MF4" "${INT8_MF4_ROOT}" "igemm_kernel_8x8_*_lmulmf4_unroll*" "GOPS:"
if [ "${INCLUDE_MF8}" = "1" ]; then
  run_family "INT8_iGEMM_MF8" "${INT8_MF8_ROOT}" "igemm_kernel_8x8_*_lmulmf8_unroll*" "GOPS:"
else
  echo "[INFO] Skipping INT8_iGEMM_MF8 (set INCLUDE_MF8=1 to force run)." | tee -a "${LIVE_LOG}"
fi
run_family "IME" "${IME_ROOT}" "ime_kernel_8x8_zvl128b_lmul*_unroll*" "GOPS:"

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
      # (..._AI_0_3_square_results.log / ..._GP_4_6_square_results.log).
      sgemm_kernel_8x8_*_lmul*_unroll*_square_results.log|\
      sgemm_kernel_8x8_*_lmul*_unroll*_*_square_results.log|\
      igemm_kernel_8x8_*_lmul*_unroll*_square_results.log|\
      igemm_kernel_8x8_*_lmul*_unroll*_*_square_results.log|\
      ime_kernel_8x8_zvl128b_lmul*_unroll*_square_results.log|\
      ime_kernel_8x8_zvl128b_lmul*_unroll*_*_square_results.log)
        ;;
      *)
        continue
        ;;
    esac
    grep -q '^Status: OK$' "${f}" || continue
    if ! grep -q '^GFLOPS:' "${f}" && ! grep -q '^GOPS:' "${f}"; then
      continue
    fi
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
