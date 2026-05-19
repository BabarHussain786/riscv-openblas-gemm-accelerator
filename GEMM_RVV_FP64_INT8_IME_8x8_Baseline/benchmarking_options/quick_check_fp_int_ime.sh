#!/usr/bin/env bash
set -u

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

M="${M:-256}"
N="${N:-256}"
K="${K:-256}"
AI_CPUSET="${AI_CPUSET:-0-3}"
GP_CPUSET="${GP_CPUSET:-4-7}"
RUN_ON="${RUN_ON:-both}"  # ai | gp | both
INCLUDE_MF8="${INCLUDE_MF8:-0}"  # 0: skip unsupported mf8 variants

if command -v taskset >/dev/null 2>&1; then
  HAVE_TASKSET=1
else
  HAVE_TASKSET=0
fi

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
      echo "[ERROR] RUN_ON must be one of: ai, gp, both (got: ${RUN_ON})"
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

check_family() {
  local family_name="$1"
  local family_root="$2"
  local pattern="$3"

  mapfile -t dirs < <(find "${family_root}" -maxdepth 1 -type d -name "${pattern}" | sort)
  if [ "${#dirs[@]}" -eq 0 ]; then
    echo "[WARN] ${family_name}: no kernel dirs found (${pattern})"
    return 0
  fi

  echo "=========================================================="
  echo "FAMILY: ${family_name}"
  echo "=========================================================="

  for d in "${dirs[@]}"; do
    local kernel
    kernel="$(basename "${d}")"

    (
      cd "${d}" || exit 1
      make clean >/dev/null 2>&1 || true
      if ! make >/tmp/make_${kernel}.log 2>&1; then
        printf "%-55s [ FAIL ]\n" "${kernel}"
        echo "---- make log (${kernel}) ----"
        cat "/tmp/make_${kernel}.log" 2>/dev/null || true
        rm -f "/tmp/make_${kernel}.log"
        exit 0
      fi

      for target in "${RUN_TARGETS[@]}"; do
        local label
        local cpuset
        local target_tag
        label="${target%%:*}"
        cpuset="${target#*:}"
        target_tag="$(tag_from_target "${label}" "${cpuset}")"

        if run_bench_cmd "${cpuset}" ./bench "${M}" "${N}" "${K}" >/tmp/run_${kernel}_${target_tag}.log 2>&1; then
          printf "%-55s [%-2s %s] [ OK ]\n" "${kernel}" "${label}" "${cpuset}"
        else
          printf "%-55s [%-2s %s] [ FAIL ]\n" "${kernel}" "${label}" "${cpuset}"
          echo "---- make log (${kernel}) ----"
          cat "/tmp/make_${kernel}.log" 2>/dev/null || true
          echo "---- run log (${kernel}, ${label} ${cpuset}) ----"
          cat "/tmp/run_${kernel}_${target_tag}.log" 2>/dev/null || true
        fi
      done
      rm -f "/tmp/make_${kernel}.log" /tmp/run_${kernel}_*.log
    )
  done
}

build_run_targets
echo "Quick check settings: RUN_ON=${RUN_ON}, AI_CPUSET=${AI_CPUSET}, GP_CPUSET=${GP_CPUSET}"
if [ "${HAVE_TASKSET}" -eq 1 ]; then
  echo "taskset: enabled"
else
  echo "taskset: NOT FOUND (running without affinity pinning)"
fi

check_family "FP64" "${BASE_DIR}/FP64_Double_dgemm_kernel_8x8" "dgemm_kernel_8x8_zvl256b_lmul*_unroll*"
check_family "INT8_iGEMM_LMUL1" "${BASE_DIR}/igemm_rvv_8x8_i8i32" "igemm_kernel_8x8_zvl256b_lmul1_unroll*"
check_family "INT8_iGEMM_LMUL2" "${BASE_DIR}/igemm_rvv_8x8_i8i32" "igemm_kernel_8x8_zvl256b_lmul2_unroll*"
check_family "INT8_iGEMM_LMUL4" "${BASE_DIR}/igemm_rvv_8x8_i8i32" "igemm_kernel_8x8_zvl256b_lmul4_unroll*"
check_family "INT8_iGEMM_LMUL8" "${BASE_DIR}/igemm_rvv_8x8_i8i32" "igemm_kernel_8x8_zvl256b_lmul8_unroll*"
check_family "INT8_iGEMM_MF2" "${BASE_DIR}/igemm_rvv_8x8_i8i32" "igemm_kernel_8x8_zvl256b_lmulmf2_unroll*"
check_family "INT8_iGEMM_MF4" "${BASE_DIR}/igemm_rvv_8x8_i8i32" "igemm_kernel_8x8_zvl256b_lmulmf4_unroll*"
if [ "${INCLUDE_MF8}" = "1" ]; then
  check_family "INT8_iGEMM_MF8" "${BASE_DIR}/igemm_rvv_8x8_i8i32" "igemm_kernel_8x8_zvl256b_lmulmf8_unroll*"
else
  echo "[INFO] Skipping INT8_iGEMM_MF8 in quick-check (set INCLUDE_MF8=1 to force run)."
fi
check_family "IME" "${BASE_DIR}/IME_KERNEL_8x8_WITH_RVV_AND_SCALAR_FALLBACK" "ime_kernel_8x8_zvl256b_*_unroll*"

echo "=========================================================="
echo "Quick check complete."
