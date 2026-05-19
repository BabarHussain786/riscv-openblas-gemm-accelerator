CC=gcc
CFLAGS=-O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wno-unknown-pragmas
TARGET=bench
KERNEL=ime_kernel_8x8_zvl256b_lmul1_unroll2.c
BENCH=ime_bench.c
RVV_FALLBACK=../../igemm_rvv_8x8_i8i32/igemm_kernel_8x8_zvl256b_lmul1_unroll2/igemm_kernel_8x8_zvl256b_lmul1_unroll2_i8i32.c

all: $(TARGET)

$(TARGET): $(KERNEL) $(RVV_FALLBACK) $(BENCH)
	$(CC) $(CFLAGS) $(KERNEL) $(RVV_FALLBACK) $(BENCH) -o $(TARGET)

clean:
	rm -f $(TARGET)