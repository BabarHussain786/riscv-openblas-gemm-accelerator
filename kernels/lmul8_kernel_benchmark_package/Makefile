# Makefile for LMUL=8 (64x2) SGEMM kernel benchmark
CC = gcc
CFLAGS = -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra
LDFLAGS = -lm

TARGET = sgemm_bench
KERNEL = sgemm_kernel_64x2_zvl256b_lmul8.c
BENCHMARK = sgemm_kernel_64x2_zvl256b_lmul8_benchmark.c

.PHONY: all clean run quick 24h 24h-bg monitor status kill help

all: $(TARGET)

$(TARGET): $(KERNEL) $(BENCHMARK)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	@echo "✓ Built $@ (LMUL=8 64x2)"

clean:
	rm -f $(TARGET) *.o
	@echo "✓ Cleaned"

run: $(TARGET)
	@./$(TARGET) $(M) $(N) $(K) 1.0 5 20

quick: $(TARGET)
	@./$(TARGET) 256 256 256 1.0 3 10

24h: $(TARGET)
	@chmod +x run_bench_lmul8.sh
	@./run_bench_lmul8.sh 24h

24h-bg: $(TARGET)
	@chmod +x run_bench_lmul8.sh
	@./run_bench_lmul8.sh bg

monitor:
	@./run_bench_lmul8.sh monitor

status:
	@./run_bench_lmul8.sh status

kill:
	@./run_bench_lmul8.sh kill

help:
	@echo "LMUL=8 BENCHMARK COMMANDS:"
	@echo "  make                 - Build"
	@echo "  make quick           - Quick sanity run"
	@echo "  make run M= N= K=     - Single run"
	@echo "  make 24h / 24h-bg    - 24-hour benchmark"
	@echo "  make monitor/status/kill"
