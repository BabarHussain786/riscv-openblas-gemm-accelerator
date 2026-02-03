// sgemm_kunroll2_bench.c - simple correctness + timing for the kunroll2 kernel
#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

typedef long  BLASLONG;
typedef float FLOAT;

// Kernel prototype
int sgemm_kernel_16x8_zvl256b_lmul1_kunroll2(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha, FLOAT *A, FLOAT *B, FLOAT *C, BLASLONG ldc
);

static inline double now_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

static void fill(float *x, size_t n, unsigned seed){
    // deterministic pseudo-random-ish values in [-0.5,0.5]
    unsigned s = seed;
    for (size_t i=0;i<n;i++){
        s = 1664525u * s + 1013904223u;
        x[i] = ((s >> 8) & 0xFFFF) / 65535.0f - 0.5f;
    }
}

static void gemm_ref(int M,int N,int K,float alpha,const float*A,const float*B,float*C,int ldc){
    // column-major C with ldc, packed-B like kernel expects: B panel is (K x N) contiguous by columns.
    for (int j=0;j<N;j++){
        for (int i=0;i<M;i++){
            float acc = 0.0f;
            for (int k=0;k<K;k++){
                acc += A[(size_t)k*M + i] * B[(size_t)j*K + k];
            }
            C[(size_t)j*ldc + i] += alpha * acc;
        }
    }
}

static float max_abs_diff(const float *a, const float *b, size_t n){
    float md=0.0f;
    for(size_t i=0;i<n;i++){
        float d = fabsf(a[i]-b[i]);
        if(d>md) md=d;
    }
    return md;
}

int main(int argc, char **argv){
    int M = (argc>1)? atoi(argv[1]) : 256;
    int N = (argc>2)? atoi(argv[2]) : 256;
    int K = (argc>3)? atoi(argv[3]) : 256;
    int iters = (argc>4)? atoi(argv[4]) : 20;
    float alpha = 1.0f;

    if(M<=0||N<=0||K<=0){ fprintf(stderr,"Bad sizes\n"); return 1; }

    size_t sizeA = (size_t)M*K;
    size_t sizeB = (size_t)K*N; // packed as panels (K contiguous per column)
    size_t sizeC = (size_t)M*N;

    float *A = (float*)aligned_alloc(64, sizeA*sizeof(float));
    float *B = (float*)aligned_alloc(64, sizeB*sizeof(float));
    float *C = (float*)aligned_alloc(64, sizeC*sizeof(float));
    float *Cref = (float*)aligned_alloc(64, sizeC*sizeof(float));
    if(!A||!B||!C||!Cref){ fprintf(stderr,"alloc failed\n"); return 1; }

    fill(A,sizeA,1);
    fill(B,sizeB,2);
    fill(C,sizeC,3);
    memcpy(Cref,C,sizeC*sizeof(float));

    // correctness (single call)
    sgemm_kernel_16x8_zvl256b_lmul1_kunroll2(M,N,K,alpha,A,B,C,M);
    gemm_ref(M,N,K,alpha,A,B,Cref,M);
    float err = max_abs_diff(C,Cref,sizeC);
    printf("max_abs_err: %.6g\n", err);

    // timing
    double t0 = now_sec();
    for(int it=0; it<iters; it++){
        sgemm_kernel_16x8_zvl256b_lmul1_kunroll2(M,N,K,alpha,A,B,C,M);
    }
    double t1 = now_sec();
    double dt = (t1-t0)/iters;
    double gflops = (2.0*(double)M*(double)N*(double)K) / dt / 1e9;
    printf("M=%d N=%d K=%d  avg=%.6f s  GFLOPS=%.3f\n", M,N,K,dt,gflops);

    free(A); free(B); free(C); free(Cref);
    return 0;
}
