CC ?= gcc
CFLAGS ?= -O3 -std=c11 -Wall -Wextra
RVVFLAGS ?= -march=rv64gcv_zvl256b -mabi=lp64d
LDFLAGS ?= -lm

.PHONY: all clean

all: sgemm_bench_lmul1 sgemm_bench_lmul2 sgemm_kunroll2_bench

sgemm_bench_lmul1: sgemm_kernel_16x8_zvl256b_lmul1_opt.c sgemm_kernel_16x8_zvl256b_lmul1_opt_benchmark.c
	$(CC) $(CFLAGS) $(RVVFLAGS) $^ -o $@ $(LDFLAGS)

sgemm_bench_lmul2: sgemm_kernel_16x8_zvl256b_lmul2.c sgemm_kernel_16x8_zvl256b_lmul2_benchmark.c
	$(CC) $(CFLAGS) $(RVVFLAGS) $^ -o $@ $(LDFLAGS)

sgemm_kunroll2_bench: sgemm_kunroll2_bench.c sgemm_kernel_16x8_zvl256b_lmul1_kunroll2.c
	$(CC) $(CFLAGS) $(RVVFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f sgemm_bench_lmul1 sgemm_bench_lmul2 sgemm_kunroll2_bench
