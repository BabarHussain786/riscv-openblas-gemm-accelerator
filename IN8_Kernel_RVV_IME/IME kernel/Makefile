# ==============================================================================
#  Makefile — SpacemiT K1 IME GEMM Benchmark
#
#  Targets:
#    make              Build the benchmark binary
#    make test         Quick correctness test (64×64×64 on both clusters)
#    make bench        Full benchmark (1024² on AI core + general core)
#    make bench-large  Large benchmark (2048² on AI core)
#    make sweep        Benchmark at 256, 512, 1024, 2048 on AI core
#    make compare      Side-by-side comparison: AI core vs general core
#    make clean        Remove build artifacts
# ==============================================================================

CC      = gcc
CFLAGS  = -O2 -march=rv64gcv -Wall -Wextra -Wno-unused-parameter
LDFLAGS = -lm

TARGET  = gemm_bench
SRCS    = bench_main.c ime_kernel.c
HDRS    = ime_kernel.h

.PHONY: all clean test bench bench-large sweep compare help

all: $(TARGET)

$(TARGET): $(SRCS) $(HDRS)
	$(CC) $(CFLAGS) -o $@ $(SRCS) $(LDFLAGS)
	@echo ""
	@echo "Build OK: ./$(TARGET)"
	@echo ""
	@echo "Quick start:"
	@echo "  taskset -c 0 ./$(TARGET)       # 1024² on AI core"
	@echo "  taskset -c 4 ./$(TARGET)       # 1024² on general core"
	@echo "  taskset -c 0 ./$(TARGET) 2048  # 2048² on AI core"

clean:
	rm -f $(TARGET)

# ── Quick correctness test (small matrix, runs fast) ──
test: $(TARGET)
	@echo ""
	@echo "═══════════════════════════════════════════════════"
	@echo "  CORRECTNESS TEST (64×64×64)"
	@echo "═══════════════════════════════════════════════════"
	@echo ""
	@echo "--- AI Core (CPU 0) ---"
	taskset -c 0 ./$(TARGET) 64
	@echo ""
	@echo "--- General Core (CPU 4) ---"
	taskset -c 4 ./$(TARGET) 64

# ── Standard benchmark (1024²) ──
bench: $(TARGET)
	@echo ""
	@echo "═══════════════════════════════════════════════════"
	@echo "  BENCHMARK 1024×1024×1024"
	@echo "═══════════════════════════════════════════════════"
	@echo ""
	@echo "--- AI Core (CPU 0) ---"
	taskset -c 0 ./$(TARGET) 1024
	@echo ""
	@echo "--- General Core (CPU 4) ---"
	taskset -c 4 ./$(TARGET) 1024

# ── Large benchmark (2048²) ──
bench-large: $(TARGET)
	@echo ""
	@echo "═══════════════════════════════════════════════════"
	@echo "  BENCHMARK 2048×2048×2048"
	@echo "═══════════════════════════════════════════════════"
	@echo ""
	taskset -c 0 ./$(TARGET) 2048

# ── Size sweep on AI core ──
sweep: $(TARGET)
	@echo ""
	@echo "═══════════════════════════════════════════════════"
	@echo "  SIZE SWEEP (AI Core, CPU 0)"
	@echo "═══════════════════════════════════════════════════"
	@for size in 128 256 512 1024 2048; do \
		echo ""; \
		echo "--- $$size × $$size × $$size ---"; \
		taskset -c 0 ./$(TARGET) $$size; \
	done

# ── Side-by-side comparison ──
compare: $(TARGET)
	@echo ""
	@echo "═══════════════════════════════════════════════════"
	@echo "  AI CORE vs GENERAL CORE COMPARISON"
	@echo "═══════════════════════════════════════════════════"
	@for size in 256 512 1024; do \
		echo ""; \
		echo "━━━━━ $$size × $$size × $$size ━━━━━"; \
		echo "  AI Core (CPU 0):"; \
		taskset -c 0 ./$(TARGET) $$size; \
		echo "  General Core (CPU 4):"; \
		taskset -c 4 ./$(TARGET) $$size; \
	done

help:
	@echo "SpacemiT K1 IME GEMM Benchmark"
	@echo ""
	@echo "Targets:"
	@echo "  make          Build"
	@echo "  make test     Correctness test (64³, both clusters)"
	@echo "  make bench    Benchmark 1024³ (both clusters)"
	@echo "  make bench-large  Benchmark 2048³ (AI core)"
	@echo "  make sweep    Size sweep 128-2048 (AI core)"
	@echo "  make compare  AI vs GP comparison at 256,512,1024"
	@echo "  make clean    Remove binary"
	@echo ""
	@echo "Manual run:"
	@echo "  taskset -c 0 ./gemm_bench [size]      # AI core"
	@echo "  taskset -c 4 ./gemm_bench [size]      # General core"
	@echo "  taskset -c 0 ./gemm_bench M N K       # Custom dimensions"
