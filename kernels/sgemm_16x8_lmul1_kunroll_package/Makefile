# Makefile — SGEMM benchmark (LMUL=1, K-unroll×2)

CC      = gcc
CFLAGS  = -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra
LDFLAGS = -lm

TARGET    = sgemm_kunroll2_bench
KERNEL    = sgemm_kernel_16x8_zvl256b_lmul1_kunroll2.c
BENCHMARK = sgemm_kunroll2_bench.c

.PHONY: all clean run help

all: $(TARGET)

$(TARGET): $(KERNEL) $(BENCHMARK)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	@echo "✓ Built $@ (LMUL=1, K-unroll×2)"

clean:
	rm -f $(TARGET) *.o
	@echo "✓ Cleaned"

run: $(TARGET)
	@./$(TARGET) 2048 2048 2048 30 0

help:
	@echo "K-UNROLL×2 BENCHMARK COMMANDS:"
	@echo "  make        - Build"
	@echo "  make run    - Quick test (2048³)"
	@echo "  make clean  - Clean files"
