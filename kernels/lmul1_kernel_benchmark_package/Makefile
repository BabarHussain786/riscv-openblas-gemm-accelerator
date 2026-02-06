# Makefile — 24-hour SGEMM benchmark (LMUL=1)

CC      = gcc
CFLAGS  = -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra
LDFLAGS = -lm

TARGET    = sgemm_bench_lmul1
KERNEL    = sgemm_kernel_16x8_zvl256b_lmul1_opt.c
BENCHMARK = sgemm_kernel_16x8_zvl256b_lmul1_opt_benchmark.c

.PHONY: all clean 24h 24h-bg monitor status kill help

all: $(TARGET)

$(TARGET): $(KERNEL) $(BENCHMARK)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	@echo "✓ Built $@ (LMUL=1)"

clean:
	rm -f $(TARGET) *.o 24h_benchmark_lmul1_*.log
	@echo "✓ Cleaned"

# 24-hour interactive
24h: $(TARGET)
	@chmod +x run_bench_lmul1.sh
	@./run_bench_lmul1.sh 24h

# 24-hour background
24h-bg: $(TARGET)
	@chmod +x run_bench_lmul1.sh
	@./run_bench_lmul1.sh bg

monitor:
	@if ps aux | grep -v grep | grep -q "$(TARGET)"; then \
		echo "✓ Benchmark is RUNNING"; \
		ps aux | grep $(TARGET) | grep -v grep; \
		ls -t 24h_benchmark_lmul1_*.log 2>/dev/null | head -1 | xargs -r tail -10; \
	else \
		echo "✗ No benchmark running"; \
	fi

status:
	@if ps aux | grep -v grep | grep -q "$(TARGET)"; then \
		echo "STATUS: RUNNING"; \
		ps aux | grep $(TARGET) | grep -v grep | awk '{print "PID:",$$2}'; \
	else \
		echo "STATUS: STOPPED"; \
	fi

kill:
	@pkill -f "$(TARGET)" 2>/dev/null || true
	@pkill -f "run_bench_lmul1.sh" 2>/dev/null || true
	@echo "✓ Benchmark stopped"

help:
	@echo "LMUL=1 24-HOUR BENCHMARK COMMANDS:"
	@echo "  make          - Build"
	@echo "  make 24h      - 24-hour benchmark (interactive)"
	@echo "  make 24h-bg   - 24-hour benchmark (background)"
	@echo "  make monitor  - Monitor progress"
	@echo "  make status   - Check status"
	@echo "  make kill     - Stop benchmark"
	@echo "  make clean    - Clean files"
