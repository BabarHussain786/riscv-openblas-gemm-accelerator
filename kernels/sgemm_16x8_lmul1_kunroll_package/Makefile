CC ?= gcc
CFLAGS ?= -O3 -std=c11 -Wall -Wextra
# For BananaPi K1 / SpacemiT X60 with RVV:
RVVFLAGS ?= -march=rv64gcv_zvl256b -mabi=lp64d

all: sgemm_kunroll2_bench

sgemm_kunroll2_bench: sgemm_kunroll2_bench.c sgemm_kernel_16x8_zvl256b_lmul1_kunroll2.c
	$(CC) $(CFLAGS) $(RVVFLAGS) $^ -o $@

clean:
	rm -f sgemm_kunroll2_bench
