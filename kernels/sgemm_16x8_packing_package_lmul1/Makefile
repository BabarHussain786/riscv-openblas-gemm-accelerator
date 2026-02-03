CC = gcc
CFLAGS = -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11
LDFLAGS = -lm

BIN = sgemm_bench_lmul1_packed

SRC = \
    sgemm_kernel_16x8_zvl256b_lmul1_opt.c \
    pack_b_16x8_fp32.c \
    sgemm_kernel_16x8_zvl256b_lmul1_opt_packed.c \
    sgemm_kernel_16x8_zvl256b_lmul1_opt_packed_benchmark.c

all: $(BIN)

$(BIN):
	$(CC) $(CFLAGS) $(SRC) -o $@ $(LDFLAGS)

clean:
	rm -f $(BIN)
