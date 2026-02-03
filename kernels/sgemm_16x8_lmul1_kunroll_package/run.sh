#!/usr/bin/env bash
set -euo pipefail
echo "[build] make"
make clean >/dev/null 2>&1 || true
make

echo
echo "[run] quick test (small)"
./sgemm_kunroll2_bench 128 128 128 10

echo
echo "[run] larger (adjust as you like)"
./sgemm_kunroll2_bench 1024 1024 1024 5
