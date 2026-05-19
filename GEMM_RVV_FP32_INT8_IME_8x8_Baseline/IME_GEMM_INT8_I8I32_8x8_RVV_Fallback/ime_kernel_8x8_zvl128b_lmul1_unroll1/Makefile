CC=gcc
CFLAGS=-O3 -march=rv64gcv_zvl128b -mabi=lp64d -std=c11 -Wall -Wno-unknown-pragmas
TARGET=bench
KERNEL=ime_kernel_8x8_zvl128b_lmul1_unroll1.c
RVV_FALLBACK=../../INT8_iGEMM_8x8/igemm_kernel_8x8_zvl128b_lmul1_unroll1/igemm_kernel_8x8_zvl128b_lmul1_unroll1.c
BENCH=ime_bench.c

all: $(TARGET)

$(TARGET): $(KERNEL) $(RVV_FALLBACK) $(BENCH)
	$(CC) $(CFLAGS) $(KERNEL) $(RVV_FALLBACK) $(BENCH) -o $(TARGET)

clean:
	rm -f $(TARGET)
