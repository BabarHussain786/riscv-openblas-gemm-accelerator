# SpacemiT K1 INT8 GEMM Kernels (IME + RVV)

This repository contains two INT8 GEMM implementations for SpacemiT K1:

- **IME kernel** (AI core optimized using `vmadot`)
- **RVV mirror kernel** (pure RVV implementation for ISA comparison)

Both compute:

\[
C[M \times N] \mathrel{+}= \alpha \times A[M \times K] \times B[K \times N]
\]

with:

- `A`, `B`: `int8_t`
- `C`: `int32_t`

---

## 1) Directory Layout

Example structure:

```text
IN8_Kernel_RVV_IME/
├── IME kernel/
│   ├── bench_main.c
│   ├── ime_diag.c
│   ├── ime_kernel.c
│   ├── ime_kernel.h
│   └── run_all.sh
├── rvv_kernel/
│   ├── bench_rvv.c
│   ├── rvv_kernel.c
│   └── rvv_kernel.h
└── run_2048_it6_all.sh
```

> Note: your folder `IME kernel` contains a space, so always quote it in commands.

---

## 2) Kernel Overview

## 2.1 IME Kernel (`ime_kernel.c`)
- Uses SpacemiT K1 IME instruction (`vmadot`) for the main 8x4 tile.
- Auto-detects AI core capability via:
  - `/sys/firmware/devicetree/base/cpus/cpu@N/cpu-ai`
- On AI cores (typically CPU 0-3): runs IME fast path.
- On non-AI cores (typically CPU 4-7): falls back to scalar path.
- Packing strategy:
  - A panel packed once per M-block set
  - B panel packed per N-block
- Handles tails (`M`, `N`, `K` remainders) via scalar code.

## 2.2 RVV Mirror Kernel (`rvv_kernel.c`)
- Same high-level structure as IME path (packing, loops, tails).
- Replaces IME `vmadot` compute with pure RVV operations:
  - `vwmul` + `vwredsum` + scalar extraction
- Runs on all cores that support RVV 1.0.
- Intended for fair ISA-level comparison against IME.

---

## 3) Matrix Layout / API Contract

Both kernels use:

- `A`: **column-major**  
  `A(row, k)` at `A[k * M + row]`
- `B`: **row-major**  
  `B(k, col)` at `B[k * N + col]`
- `C`: **column-major**  
  `C(row, col)` at `C[col * ldc + row]`

APIs:

```c
int spacemit_ime_gemm(
    long M, long N, long K, int32_t alpha,
    const int8_t *A, const int8_t *B, int32_t *C, long ldc);

int spacemit_rvv_gemm(
    long M, long N, long K, int32_t alpha,
    const int8_t *A, const int8_t *B, int32_t *C, long ldc);
```

---

## 4) Benchmark Drivers

## 4.1 IME benchmark (`bench_main.c`)
- Detects core type (AI/General)
- Generates random `A`, `B` in range `[-5, +5]`
- Scalar reference validation for small sizes
- Warm-up + timed iterations
- Reports best/avg time and GOPS

## 4.2 RVV benchmark (`bench_rvv.c`)
- Similar benchmark flow as IME benchmark
- Calls `spacemit_rvv_gemm(...)`
- Works on both AI and General cores

---

## 5) Build Instructions

From project root:

```bash
gcc -O3 -march=rv64gcv -mabi=lp64d \
  -I"IME kernel" \
  -o gemm_ime "IME kernel/bench_main.c" "IME kernel/ime_kernel.c"

gcc -O3 -march=rv64gcv -mabi=lp64d \
  -I"rvv_kernel" \
  -o gemm_rvv "rvv_kernel/bench_rvv.c" "rvv_kernel/rvv_kernel.c"
```

---

## 6) Run Instructions (Core-wise)

### IME benchmark
AI core (CPU 0):
```bash
taskset -c 0 ./gemm_ime 1024
```

General core (CPU 4):
```bash
taskset -c 4 ./gemm_ime 1024
```

### RVV benchmark
AI core (CPU 0):
```bash
taskset -c 0 ./gemm_rvv 1024
```

General core (CPU 4):
```bash
taskset -c 4 ./gemm_rvv 1024
```

### Rectangular GEMM
```bash
taskset -c 0 ./gemm_ime 512 1024 256
taskset -c 0 ./gemm_rvv 512 1024 256
```

---

## 7) 2048x2048x2048 Benchmark (Recommended)

After compiling:

```bash
taskset -c 0 ./gemm_ime 2048
taskset -c 4 ./gemm_ime 2048
taskset -c 0 ./gemm_rvv 2048
taskset -c 4 ./gemm_rvv 2048
```

Save logs:

```bash
mkdir -p results_2048
taskset -c 0 ./gemm_ime 2048 | tee results_2048/ime_cpu0.log
taskset -c 4 ./gemm_ime 2048 | tee results_2048/ime_cpu4.log
taskset -c 0 ./gemm_rvv 2048 | tee results_2048/rvv_cpu0.log
taskset -c 4 ./gemm_rvv 2048 | tee results_2048/rvv_cpu4.log
```

---

## 8) Unified Automation Script

If present, run:

```bash
chmod +x run_2048_it6_all.sh
./run_2048_it6_all.sh
```

This script:
- patches benchmarks to 6 iterations
- compiles both binaries
- runs IME + RVV on CPU0 and CPU4
- saves logs and summary under `results_2048_it6/...`

---

## 9) IME Diagnostic Tool (`ime_diag.c`)

Purpose:
- reverse-engineer and verify IME accumulator/data mapping with controlled inputs.

Build:
```bash
gcc -O2 -march=rv64gcv -mabi=lp64d -o ime_diag "IME kernel/ime_diag.c"
```

Run on AI core:
```bash
taskset -c 0 ./ime_diag
```

---

## 10) Notes / Best Practices

- For stable performance, set CPU governor to `performance` (requires root).
- Run repeated tests and compare **best GOPS** and **avg GOPS**.
- Validate correctness for smaller sizes before running large benchmarks.
- Keep `ldc >= M`.
- Ensure your toolchain supports `-march=rv64gcv` and RVV 1.0 intrinsics.

---

## 11) Troubleshooting

- **`No such file or directory` for sources**  
  You are likely compiling from root while files are in subfolders. Use quoted paths shown above.

- **Script cannot find `bench_main.c`**  
  Update script paths to:
  - `IME kernel/bench_main.c`
  - `rvv_kernel/bench_rvv.c`

- **Illegal instruction on non-AI core (IME path)**  
  Use IME benchmark on AI cores for fast path (`taskset -c 0..3`), or use RVV benchmark on all cores.

- **`aligned_alloc` issues**  
  Build with a standard C library/toolchain supporting C11 aligned allocation.

---

## 12) License / Ownership

Add your project license and ownership details here.