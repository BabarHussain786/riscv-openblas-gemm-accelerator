# Makefile — build LMUL=1 RVV SGEMM benchmarks (baseline + threaded wrapper)

CC ?= gcc

# Adjust -march to match your board/toolchain.
# For Banana Pi BPI-F3 / SpacemiT K1 (RVV 1.0) you may use:
#   -march=rv64gcv_zvl256b
CFLAGS ?= -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra

LDFLAGS ?= -lm

BIN_BASE = sgemm_bench_lmul1
SRC_BASE = sgemm_kernel_16x8_zvl256b_lmul1_opt.c sgemm_kernel_16x8_zvl256b_lmul1_opt_benchmark.c

BIN_THR  = sgemm_bench_lmul1_threaded
SRC_THR  = sgemm_kernel_16x8_zvl256b_lmul1_opt.c \
           sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded.c \
           sgemm_kernel_16x8_zvl256b_lmul1_opt_threaded_benchmark.c

# OpenMP flags (GCC/Clang)
OMPFLAGS ?= -fopenmp

all: $(BIN_BASE) $(BIN_THR)

$(BIN_BASE): $(SRC_BASE)
	$(CC) $(CFLAGS) $(SRC_BASE) -o $@ $(LDFLAGS)

$(BIN_THR): $(SRC_THR)
	$(CC) $(CFLAGS) $(OMPFLAGS) $(SRC_THR) -o $@ $(LDFLAGS)

clean:
	rm -f $(BIN_BASE) $(BIN_THR) *.o
