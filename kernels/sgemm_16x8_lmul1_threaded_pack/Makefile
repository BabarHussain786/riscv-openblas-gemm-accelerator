CC ?= gcc

# For SpacemiT X60 / RVV 1.0 ZVL256B
CFLAGS  ?= -O3 -march=rv64gcv_zvl256b -mabi=lp64d -std=c11 -Wall -Wextra
LDFLAGS ?=

# Enable OpenMP if available
CFLAGS  += -fopenmp

TARGET = sgemm_threaded_pack_bench

SRCS = sgemm_threaded_pack_bench.c kernel_opt.c kernel_kunroll2.c

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $@ $(LDFLAGS)

clean:
	rm -f $(TARGET)
