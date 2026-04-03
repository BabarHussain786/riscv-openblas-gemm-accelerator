# FP32 SGEMM RVV Vector Kernel 8×8 (Zvl128b)
## LMUL × Unrolling-Factor Exploration

This suite evaluates FP32 8×8 SGEMM kernels by sweeping:

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

Populate this section from actual folder names in this directory (LMUL/unroll combinations and baseline variants), for example:

- `...lmul1_unroll1`
- `...lmul1_unroll2`
- `...lmul2_unroll4`
- `...lmul4_unroll8`
- etc.

> Keep names exactly as directory names for reproducibility.

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

This suite is an empirical tuning framework to select the best **LMUL + unrolling factor** pair for FP32 8×8 SGEMM on your target RVV platform.