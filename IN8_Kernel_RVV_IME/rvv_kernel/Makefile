# ==============================================================================
#  Makefile — SpacemiT K1 Pure RVV GEMM Benchmark (baseline for IME comparison)
# ==============================================================================

CC      = gcc
CFLAGS  = -O3 -march=rv64gcv -mabi=lp64d -Wall -Wextra -Wno-unused-parameter
LDFLAGS = -lm

TARGET  = gemm_rvv
SRCS    = bench_rvv.c rvv_kernel.c
HDRS    = rvv_kernel.h

.PHONY: all clean test bench compare help

all: $(TARGET)

$(TARGET): $(SRCS) $(HDRS)
	$(CC) $(CFLAGS) -o $@ $(SRCS) $(LDFLAGS)
	@echo ""
	@echo "Build OK: ./$(TARGET)"
	@echo "  taskset -c 0 ./$(TARGET)       # AI core"
	@echo "  taskset -c 4 ./$(TARGET)       # GP core"
	@echo "  taskset -c 0 ./$(TARGET) 2048  # large"

clean:
	rm -f $(TARGET)

test: $(TARGET)
	@echo "=== Correctness (64³, both clusters) ==="
	taskset -c 0 ./$(TARGET) 64
	taskset -c 4 ./$(TARGET) 64

bench: $(TARGET)
	@echo "=== Benchmark 1024³ (both clusters) ==="
	taskset -c 0 ./$(TARGET) 1024
	taskset -c 4 ./$(TARGET) 1024

compare: $(TARGET)
	@echo "=== AI vs GP comparison ==="
	@for s in 256 512 1024; do \
		echo ""; echo "--- $${s}³ ---"; \
		taskset -c 0 ./$(TARGET) $$s; \
		taskset -c 4 ./$(TARGET) $$s; \
	done

help:
	@echo "Targets: all, test, bench, compare, clean"
