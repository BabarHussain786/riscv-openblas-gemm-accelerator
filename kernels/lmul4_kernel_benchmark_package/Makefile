# Makefile — LMUL=4 SGEMM micro-kernel benchmark
CC      = gcc
CFLAGS  = -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra
LDFLAGS = -lm

TARGET   = sgemm_bench_lmul4
KERNEL   = sgemm_kernel_32x4_zvl256b_lmul4.c
BENCHSRC = sgemm_kernel_32x4_zvl256b_lmul4_benchmark.c

.PHONY: all clean 24h 24h-bg monitor status kill help

all: $(TARGET)

$(TARGET): $(KERNEL) $(BENCHSRC)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	@echo "✓ Built $@ (LMUL=4)"

clean:
	rm -f $(TARGET) *.o
	@echo "✓ Cleaned"

24h: $(TARGET)
	@chmod +x run_bench_lmul4.sh
	@./run_bench_lmul4.sh 24h

24h-bg: $(TARGET)
	@chmod +x run_bench_lmul4.sh
	@./run_bench_lmul4.sh bg

monitor:
	@if ps aux | grep -v grep | grep -q "$(TARGET)"; then \
		echo "✓ Benchmark is RUNNING"; \
		ps aux | grep $(TARGET) | grep -v grep; \
		echo ""; \
		ls -t 24h_benchmark_lmul4_*.log 2>/dev/null | head -1 | xargs -r tail -5; \
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
	@echo "✓ Benchmark stopped"

help:
	@echo "COMMANDS:"
	@echo "  make            - Build"
	@echo "  make 24h        - 24-hour benchmark (interactive)"
	@echo "  make 24h-bg     - 24-hour benchmark (background)"
	@echo "  make monitor    - Monitor progress"
	@echo "  make status     - Check status"
	@echo "  make kill       - Stop benchmark"
	@echo "  make clean      - Clean"
