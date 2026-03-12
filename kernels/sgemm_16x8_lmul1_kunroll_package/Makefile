# Makefile — 24-hour SGEMM benchmark (LMUL=1, K-unroll×2)

CC      = gcc
CFLAGS  = -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra
LDFLAGS = -lm

TARGET    = sgemm_kunroll2_bench
KERNEL    = sgemm_kernel_16x8_zvl256b_lmul1_kunroll2.c
BENCHMARK = sgemm_kunroll2_bench.c
SCRIPT    = run_bench_kunroll2.sh

.PHONY: all clean 24h 24h-bg monitor status kill help

# -------- build --------
all: $(TARGET)

$(TARGET): $(KERNEL) $(BENCHMARK)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	@echo "✓ Built $@ (LMUL=1, K-unroll×2)"

# -------- clean --------
clean:
	rm -f $(TARGET) *.o 24h_benchmark_kunroll2_*.log
	@echo "✓ Cleaned"

# -------- 24-hour interactive --------
24h: $(TARGET)
	@chmod +x $(SCRIPT)
	@./$(SCRIPT) 24h

# -------- 24-hour background --------
24h-bg: $(TARGET)
	@chmod +x $(SCRIPT)
	@./$(SCRIPT) bg

# -------- monitor --------
monitor:
	@if ps aux | grep -v grep | grep -q "$(TARGET)"; then \
		echo "✓ K-unroll×2 benchmark is RUNNING"; \
		ps aux | grep $(TARGET) | grep -v grep; \
		echo ""; \
		ls -t 24h_benchmark_kunroll2_*.log 2>/dev/null | head -1 | xargs -r tail -10; \
	else \
		echo "✗ No K-unroll×2 benchmark running"; \
	fi

# -------- status --------
status:
	@if ps aux | grep -v grep | grep -q "$(TARGET)"; then \
		echo "STATUS: RUNNING"; \
		ps aux | grep $(TARGET) | grep -v grep | awk '{print "PID:",$$2}'; \
	else \
		echo "STATUS: STOPPED"; \
	fi

# -------- kill --------
kill:
	@pkill -f "$(TARGET)" 2>/dev/null || true
	@pkill -f "$(SCRIPT)" 2>/dev/null || true
	@echo "✓ K-unroll×2 benchmark stopped"

# -------- help --------
help:
	@echo "K-UNROLL×2 24-HOUR BENCHMARK COMMANDS:"
	@echo "  make          - Build"
	@echo "  make 24h      - 24-hour benchmark (interactive)"
	@echo "  make 24h-bg   - 24-hour benchmark (background)"
	@echo "  make monitor  - Monitor progress"
	@echo "  make status   - Check status"
	@echo "  make kill     - Stop benchmark"
	@echo "  make clean    - Clean files"
