#!/usr/bin/env bash
# run_bench_lmul1.sh — quick benchmark runner for LMUL=1 optimized kernel
set -euo pipefail

KERNEL="sgemm_kernel_16x8_zvl256b_lmul1_opt"
BIN="./sgemm_bench_lmul1"

echo "=============================================="
echo "RISC-V SGEMM Kernel Benchmark"
echo "Kernel: ${KERNEL}"
echo "=============================================="

echo
echo "Compiling..."
make clean >/dev/null 2>&1 || true
make

echo
echo "=== QUICK TESTS ==="
# Format: M N K iters check
${BIN} 256 256 256 50 1
${BIN} 512 512 512 30 0
${BIN} 1024 1024 1024 10 0
${BIN} 2048 2048 2048 5 0

echo
echo "Done."
