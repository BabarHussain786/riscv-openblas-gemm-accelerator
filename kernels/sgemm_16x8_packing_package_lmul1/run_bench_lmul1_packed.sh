#!/usr/bin/env bash
set -e
make clean
make
./sgemm_bench_lmul1_packed
