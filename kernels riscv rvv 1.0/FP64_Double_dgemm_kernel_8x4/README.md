# FP64 DGEMM RVV Kernel 8×4 (Zvl128b)
## LMUL × Unrolling-Factor Exploration

This suite evaluates FP64 8×4 DGEMM kernels by sweeping:

- **LMUL** (vector register grouping), and
- **Unrolling factor** (how many operations are expanded per iteration).

---

## What this suite is trying to do

Find the best-performing variant by testing all LMUL/unrolling combinations under identical benchmark conditions, then comparing:

- best/avg runtime
- best/avg GFLOPS
- run-to-run stability

---

## Operation

\[
C[M \times N] \mathrel{+}= A[M \times K] \times B[K \times N]
\]

- Data type: **float64 (FP64)**
- Micro-kernel tile: **8×4**
- ISA target: **RVV 1.0**

---

## Meaning of LMUL

- **LMUL1**: low register usage, conservative baseline  
- **LMUL2**: moderate parallelism increase  
- **LMUL4**: higher parallelism, higher register pressure  
- **LMUL8**: maximum grouping in this suite, highest pressure/risk

---

## Meaning of Unrolling Factor

Unrolling factor = how many repeated compute steps are emitted per loop pass:

- **unroll1**: baseline
- **unroll2**: moderate expansion
- **unroll4**: stronger expansion
- **unroll8**: aggressive expansion

Higher unrolling can reduce loop overhead and improve ILP, but excessive unrolling may hurt due to code-size/cache/register pressure.

---

## Variant list

Populate this section from actual folder names in this directory (LMUL/unroll combinations and baseline variants), keeping names exactly as directory names.

---

## Build and run

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

## Benchmark reporting

Use identical settings across variants and report:

- best/avg runtime
- best/avg GFLOPS
- iteration count
- core pinning policy

---

## Bottom line

This suite is an empirical tuning framework to select the best **LMUL + unrolling factor** pair for FP64 8×4 DGEMM on your target RVV platform.