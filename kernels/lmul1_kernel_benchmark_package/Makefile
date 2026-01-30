
# Makefile — build LMUL=1 optimized RVV SGEMM micro-kernel benchmark (VLEN=256 target)

CC ?= gcc

# Adjust -march to match your board/toolchain.
# For Banana Pi BPI-F3 / SpacemiT K1 (RVV 1.0) you may use:
#   -march=rv64gcv_zvl256b
# If your toolchain prefers:
#   -march=rv64gcv -mattr=+zvl256b
CFLAGS ?= -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra

LDFLAGS ?= -lm

BIN = sgemm_bench_lmul1
SRC = sgemm_kernel_16x8_zvl256b_lmul1_opt.c sgemm_kernel_16x8_zvl256b_lmul1_opt_benchmark.c

all: $(BIN)

$(BIN): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $@ $(LDFLAGS)

clean:
	rm -f $(BIN) *.o
