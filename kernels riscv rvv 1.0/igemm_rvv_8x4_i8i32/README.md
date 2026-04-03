# IGEMM RVV Kernel 8×4 (INT8→INT32, Zvl128b)
## LMUL × Unrolling-Factor Exploration

This suite evaluates INT8 GEMM (accumulating into INT32) for an 8×4 RVV micro-kernel by sweeping:

- **LMUL** (vector register grouping), and
- **Unrolling factor** (how many operations are expanded per iteration).

---

## What this suite is trying to do

Find the best-performing variant by testing all LMUL/unrolling combinations under identical benchmark conditions, then comparing:

- best/avg runtime
- best/avg throughput (e.g., GOPS)
- run-to-run stability

---

## Operation

\[
C_{int32}[M \times N] \mathrel{+}= A_{int8}[M \times K] \times B_{int8}[K \times N]
\]

- Input type: **INT8**
- Accumulator/output type: **INT32**
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

Populate this section from actual folder names/files in this directory (LMUL/unroll combinations and baseline variants), keeping names exactly as directory names.

---

## Build and run

```bash
make clean && make
taskset -c 0 ./bench 2048 2048 2048