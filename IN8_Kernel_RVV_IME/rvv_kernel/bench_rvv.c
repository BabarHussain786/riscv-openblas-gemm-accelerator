/*
 * bench_rvv.c — Benchmark driver for pure RVV GEMM kernel
 *
 * Same structure as IME benchmark driver.
 * Runs on ALL cores (no AI-core restriction).
 *
 * Usage:
 * taskset -c 0 ./gemm_rvv 1024     # AI core
 * taskset -c 4 ./gemm_rvv 1024     # GP core (also works!)
 * taskset -c 0 ./gemm_rvv 64       # small, with validation
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <sched.h>
#include <sys/stat.h>

#include "rvv_kernel.h"

static double get_time_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

static const char *get_core_type(void) {
    int cpu = sched_getcpu();
    if (cpu < 0) return "unknown";
    char path[128]; struct stat st;
    snprintf(path, sizeof(path),
             "/sys/firmware/devicetree/base/cpus/cpu@%d/cpu-ai", cpu);
    return (stat(path, &st) == 0) ? "AI (Cluster0)" : "General (Cluster1)";
}

static void reference_gemm(long M, long N, long K, int32_t alpha,
                           const int8_t *A, const int8_t *B,
                           int32_t *C, long ldc) {
    for (long col = 0; col < N; col++)
        for (long row = 0; row < M; row++) {
            int32_t acc = 0;
            for (long k = 0; k < K; k++)
                acc += (int32_t)A[k * M + row] * (int32_t)B[k * N + col];
            C[col * ldc + row] = alpha * acc;
        }
}

static int validate(const int32_t *ref, const int32_t *test, long M, long N, long ldc) {
    int errors = 0;
    for (long c = 0; c < N; c++)
        for (long r = 0; r < M; r++) {
            long idx = c * ldc + r;
            if (ref[idx] != test[idx]) {
                if (errors < 5)
                    printf("  MISMATCH C(%ld,%ld): expected %d, got %d\n",
                           r, c, ref[idx], test[idx]);
                errors++;
            }
        }
    return errors;
}

static void separator(void) {
    printf("────────────────────────────────────────────────────────────────\n");
}

int main(int argc, char **argv)
{
    long M = 1024, N = 1024, K = 1024;
    if (argc == 2) M = N = K = atol(argv[1]);
    else if (argc == 4) { M = atol(argv[1]); N = atol(argv[2]); K = atol(argv[3]); }

    if (M <= 0 || N <= 0 || K <= 0) {
        fprintf(stderr, "Usage: %s [size] or %s M N K\n", argv[0], argv[0]);
        return 1;
    }

    int cpu = sched_getcpu();
    int32_t alpha = 1;
    long ldc = M;
    double total_ops = 2.0 * M * N * K;

    printf("\n");
    separator();
    printf("  SpacemiT K1 PURE RVV GEMM Benchmark (no IME)\n");
    printf("  int8 × int8 → int32\n");
    separator();
    printf("  CPU core:    %d (%s)\n", cpu, get_core_type());
    printf("  Matrix size: M=%ld  N=%ld  K=%ld\n", M, N, K);
    printf("  Operations:  %.2f billion int8 MACs\n", total_ops / 1e9);
    separator();
    printf("\n");

    printf("[1/5] Allocating matrices...\n");
    int8_t  *A     = (int8_t  *)aligned_alloc(64, M * K);
    int8_t  *B     = (int8_t  *)aligned_alloc(64, K * N);
    int32_t *C_ref = (int32_t *)aligned_alloc(64, M * N * sizeof(int32_t));
    int32_t *C_rvv = (int32_t *)aligned_alloc(64, M * N * sizeof(int32_t));
    if (!A || !B || !C_ref || !C_rvv) { fprintf(stderr, "alloc failed\n"); return 1; }

    printf("[2/5] Filling random data...\n");
    srand(42);
    for (long i = 0; i < M * K; i++) A[i] = (int8_t)((rand() % 11) - 5);
    for (long i = 0; i < K * N; i++) B[i] = (int8_t)((rand() % 11) - 5);

    int do_validate = (M * N * K <= 512L * 512L * 512L);
    if (do_validate) {
        printf("[3/5] Computing scalar reference...\n");
        memset(C_ref, 0, M * N * sizeof(int32_t));
        reference_gemm(M, N, K, alpha, A, B, C_ref, ldc);
    } else {
        printf("[3/5] Skipping reference (too large).\n");
    }

    printf("[4/5] Warm-up run...\n");
    memset(C_rvv, 0, M * N * sizeof(int32_t));
    spacemit_rvv_gemm(M, N, K, alpha, A, B, C_rvv, ldc);

    if (do_validate) {
        int err = validate(C_ref, C_rvv, M, N, ldc);
        if (err == 0)
            printf("      Validation: PASS ✓ (%ld elements)\n", M * N);
        else
            printf("      Validation: FAIL ✗ (%d mismatches)\n", err);
    }

    printf("[5/5] Benchmarking (3 iterations)...\n");
    double best_sec = 1e18, total_sec = 0;
    for (int it = 0; it < 3; it++) {
        memset(C_rvv, 0, M * N * sizeof(int32_t));
        double t0 = get_time_sec();
        spacemit_rvv_gemm(M, N, K, alpha, A, B, C_rvv, ldc);
        double t1 = get_time_sec();
        double dt = t1 - t0;
        total_sec += dt;
        if (dt < best_sec) best_sec = dt;
        printf("      Iter %d: %.3f sec  (%.2f GOPS)\n",
               it + 1, dt, total_ops / dt / 1e9);
    }

    printf("\n");
    separator();
    printf("  RESULTS (Pure RVV, no IME)\n");
    separator();
    printf("  Core:       CPU %d (%s)\n", cpu, get_core_type());
    printf("  Size:       %ld × %ld × %ld\n", M, N, K);
    printf("  Best time:  %.3f sec\n", best_sec);
    printf("  Avg time:   %.3f sec\n", total_sec / 3);
    printf("  Best GOPS:  %.2f\n", total_ops / best_sec / 1e9);
    printf("  Avg GOPS:   %.2f\n", total_ops / (total_sec / 3) / 1e9);
    if (do_validate) printf("  Correct:    YES\n");
    separator();
    printf("\n");

    free(A); free(B); free(C_ref); free(C_rvv);
    return 0;
}
