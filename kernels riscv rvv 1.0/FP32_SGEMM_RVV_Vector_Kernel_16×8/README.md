# FP32 SGEMM RVV Vector Kernel 16×8 (Zvl128b)
## LMUL × Unrolling-Factor Exploration

This suite evaluates FP32 16×8 SGEMM kernels by sweeping:

- **LMUL** (vector register grouping), and
- **Unrolling factor** (how many operations are expanded per iteration).

---

## What this suite is trying to do

Find the best-performing variant by testing all LMUL/unrolling combinations under identical benchmark conditions, then comparing:

- best/avg runtime
- best/avg GFLOPS
- run-to-run stability

---

## Meaning of LMUL

- **LMUL1**: low register usage, conservative baseline  
- **LMUL2**: moderate parallelism increase  
- **LMUL4**: higher parallelism, higher register pressure  
- **LMUL8**: maximum grouping in this suite, highest pressure/risk

---

## Meaning of Unrolling Factor (only)

Unrolling factor = how many repeated compute steps are emitted per loop pass:

- **unroll1**: baseline (minimal expansion)
- **unroll2**: moderate expansion
- **unroll4**: stronger expansion
- **unroll8**: aggressive expansion

### Effect of higher unrolling factor
- less loop-control overhead
- more instruction-level parallelism opportunity
- larger code size
- potentially higher register pressure / instruction-cache pressure

So higher unrolling can improve performance up to a point; beyond that, it may regress.

---

## Variant list

### OpenBLAS-style baseline family
- `OpenBLAS_Baseline_Kernel_FP32`
- `OpenBLAS_Baseline_Kernel_FP32_Fractional`
- `OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll2`
- `OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll4`
- `OpenBLAS_Baseline_Kernel_FP32_Fractional-unroll8`

### LMUL × Unrolling combinations

#### LMUL1
- `sgemm_kernel_16x8_zvl128b_lmul1_unroll1`
- `sgemm_kernel_16x8_zvl128b_lmul1_unroll2`
- `sgemm_kernel_16x8_zvl128b_lmul1_unroll4`
- `sgemm_kernel_16x8_zvl128b_lmul1_unroll8`

#### LMUL2
- `sgemm_kernel_16x8_zvl128b_lmul2_unroll1`
- `sgemm_kernel_16x8_zvl128b_lmul2_unroll2`
- `sgemm_kernel_16x8_zvl128b_lmul2_unroll4`
- `sgemm_kernel_16x8_zvl128b_lmul2_unroll8`

#### LMUL4
- `sgemm_kernel_16x8_zvl128b_lmul4_unroll1`
- `sgemm_kernel_16x8_zvl128b_lmul4_unroll2`
- `sgemm_kernel_16x8_zvl128b_lmul4_unroll4`
- `sgemm_kernel_16x8_zvl128b_lmul4_unroll8`

#### LMUL8
- `sgemm_kernel_16x8_zvl128b_lmul8_unroll1`
- `sgemm_kernel_16x8_zvl128b_lmul8_unroll2`
- `sgemm_kernel_16x8_zvl128b_lmul8_unroll4`
- `sgemm_kernel_16x8_zvl128b_lmul8_unroll8`

---

## Run flow

```bash
make clean && make
taskset -c 0 ./bench 2048 2048 2048
```

If orchestration scripts exist:

```bash
chmod +x *.sh
./run_all.sh
```

---

## Bottom line

This suite is an empirical tuning framework to select the best **LMUL + unrolling factor** pair for FP32 16×8 SGEMM on your target RVV platform.