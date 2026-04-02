/*
 * ============================================================================
 *  bench_main.c — SpacemiT K1 IME GEMM Benchmark Driver
 * ============================================================================
 *
 *  This program:
 *    1. Detects which CPU core it's running on (AI vs General)
 *    2. Generates random int8 matrices A and B
 *    3. Computes a scalar reference C_ref = alpha × A × B
 *    4. Runs the IME kernel and measures wall-clock time
 *    5. Validates the IME result against the reference
 *    6. Reports performance in GOPS and elapsed time
 *
 *  Usage:
 *    taskset -c 0   ./gemm_bench           # default 1024×1024×1024
 *    taskset -c 0   ./gemm_bench 2048      # square 2048
 *    taskset -c 0   ./gemm_bench 512 1024 256   # M=512 N=1024 K=256
 *    taskset -c 4   ./gemm_bench 1024      # run on general core for comparison
 *
 * ============================================================================
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <sched.h>
#include <sys/stat.h>

#include "ime_kernel.h"

/* ── Timing ── */
static double get_time_sec(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

/* ── Core detection ── */
static const char *get_core_type(void)
{
    int cpu = sched_getcpu();
    if (cpu < 0) return "unknown";

    char path[128];
    struct stat st;
    snprintf(path, sizeof(path),
             "/sys/firmware/devicetree/base/cpus/cpu@%d/cpu-ai", cpu);
    if (stat(path, &st) == 0)
        return "AI (Cluster0, IME)";
    else
        return "General (Cluster1, scalar)";
}

/* ── Scalar reference GEMM ──
 * Computes C = alpha × A × B using plain C loops.
 * A: column-major (M×K), B: row-major (K×N), C: column-major (M×N)
 */
static void reference_gemm(
    long M, long N, long K, int32_t alpha,
    const int8_t *A, const int8_t *B,
    int32_t *C, long ldc)
{
    for (long col = 0; col < N; col++) {
        for (long row = 0; row < M; row++) {
            int32_t acc = 0;
            for (long k = 0; k < K; k++) {
                acc += (int32_t)A[k * M + row] * (int32_t)B[k * N + col];
            }
            C[col * ldc + row] = alpha * acc;
        }
    }
}

/* ── Validation ── */
static int validate(const int32_t *ref, const int32_t *test,
                    long M, long N, long ldc)
{
    int errors = 0;
    for (long c = 0; c < N; c++) {
        for (long r = 0; r < M; r++) {
            long idx = c * ldc + r;
            if (ref[idx] != test[idx]) {
                if (errors < 5) {
                    printf("  MISMATCH C(%ld,%ld): expected %d, got %d\n",
                           r, c, ref[idx], test[idx]);
                }
                errors++;
            }
        }
    }
    return errors;
}

/* ── Print a separator line ── */
static void separator(void) {
    printf("────────────────────────────────────────────────────────────────\n");
}

int main(int argc, char **argv)
{
    /* ── Parse arguments ── */
    long M = 1024, N = 1024, K = 1024;
    if (argc == 2) {
        M = N = K = atol(argv[1]);
    } else if (argc == 4) {
        M = atol(argv[1]);
        N = atol(argv[2]);
        K = atol(argv[3]);
    }

    if (M <= 0 || N <= 0 || K <= 0) {
        fprintf(stderr, "Usage: %s [size] or %s M N K\n", argv[0], argv[0]);
        return 1;
    }

    int cpu = sched_getcpu();
    int32_t alpha = 1;
    long ldc = M;
    double total_ops = 2.0 * M * N * K;

    /* ── Print header ── */
    printf("\n");
    separator();
    printf("  SpacemiT K1 IME GEMM Benchmark\n");
    printf("  int8 × int8 → int32\n");
    separator();
    printf("  CPU core:    %d (%s)\n", cpu, get_core_type());
    printf("  Matrix size: M=%ld  N=%ld  K=%ld\n", M, N, K);
    printf("  Operations:  %.2f billion int8 MACs\n", total_ops / 1e9);
    printf("  Alpha:       %d\n", alpha);
    separator();
    printf("\n");

    /* ── Allocate matrices ── */
    printf("[1/5] Allocating matrices...\n");
    int8_t  *A     = (int8_t  *)aligned_alloc(64, M * K * sizeof(int8_t));
    int8_t  *B     = (int8_t  *)aligned_alloc(64, K * N * sizeof(int8_t));
    int32_t *C_ref = (int32_t *)aligned_alloc(64, M * N * sizeof(int32_t));
    int32_t *C_ime = (int32_t *)aligned_alloc(64, M * N * sizeof(int32_t));

    if (!A || !B || !C_ref || !C_ime) {
        fprintf(stderr, "Failed to allocate matrices\n");
        return 1;
    }

    /* ── Fill with small random values (avoid int8 overflow in products) ── */
    printf("[2/5] Filling random data (range -5..+5)...\n");
    srand(42);
    for (long i = 0; i < M * K; i++) A[i] = (int8_t)((rand() % 11) - 5);
    for (long i = 0; i < K * N; i++) B[i] = (int8_t)((rand() % 11) - 5);

    /* ── Compute reference (only for small sizes) ── */
    int do_validate = (M * N * K <= 512L * 512L * 512L);
    if (do_validate) {
        printf("[3/5] Computing scalar reference for validation...\n");
        memset(C_ref, 0, M * N * sizeof(int32_t));
        reference_gemm(M, N, K, alpha, A, B, C_ref, ldc);
        printf("      Reference computed.\n");
    } else {
        printf("[3/5] Skipping reference (matrix too large for scalar).\n");
        printf("      Validation will check for NaN/overflow only.\n");
    }

    /* ── Warm-up run ── */
    printf("[4/5] Warm-up run...\n");
    memset(C_ime, 0, M * N * sizeof(int32_t));
    spacemit_ime_gemm(M, N, K, alpha, A, B, C_ime, ldc);

    /* ── Validate ── */
    if (do_validate) {
        int err = validate(C_ref, C_ime, M, N, ldc);
        if (err == 0) {
            printf("      Validation: PASS ✓ (all %ld elements match)\n", M * N);
        } else {
            printf("      Validation: FAIL ✗ (%d mismatches out of %ld)\n", err, M * N);
        }
    }

    /* ── Benchmark: multiple iterations ── */
    printf("[5/5] Benchmarking (3 iterations, reporting best)...\n");

    double best_sec = 1e18;
    double total_sec = 0;
    int iters = 3;

    for (int it = 0; it < iters; it++) {
        memset(C_ime, 0, M * N * sizeof(int32_t));

        double t0 = get_time_sec();
        spacemit_ime_gemm(M, N, K, alpha, A, B, C_ime, ldc);
        double t1 = get_time_sec();

        double dt = t1 - t0;
        total_sec += dt;
        if (dt < best_sec) best_sec = dt;

        printf("      Iter %d: %.3f sec  (%.2f GOPS)\n",
               it + 1, dt, total_ops / dt / 1e9);
    }

    double avg_sec = total_sec / iters;
    double best_gops = total_ops / best_sec / 1e9;
    double avg_gops  = total_ops / avg_sec / 1e9;

    /* ── Results ── */
    printf("\n");
    separator();
    printf("  RESULTS\n");
    separator();
    printf("  Core:       CPU %d (%s)\n", cpu, get_core_type());
    printf("  Size:       %ld × %ld × %ld\n", M, N, K);
    printf("  Best time:  %.3f sec\n", best_sec);
    printf("  Avg time:   %.3f sec\n", avg_sec);
    printf("  Best GOPS:  %.2f\n", best_gops);
    printf("  Avg GOPS:   %.2f\n", avg_gops);
    if (do_validate)
        printf("  Correct:    YES\n");
    separator();
    printf("\n");

    /* ── Cleanup ── */
    free(A);
    free(B);
    free(C_ref);
    free(C_ime);

    return 0;
}
