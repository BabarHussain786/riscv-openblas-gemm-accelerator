CC = gcc

CFLAGS = -O3 -march=rv64gcv_zvl256b -mabi=lp64d -Wall -std=c11

TARGET = bench

all: $(TARGET)

$(TARGET): sgemm_kernel_16x8_zvl256b_lmul2.c sgemm_bench.c
	$(CC) $(CFLAGS) $^ -o $(TARGET)

clean:
	rm -f $(TARGET)
