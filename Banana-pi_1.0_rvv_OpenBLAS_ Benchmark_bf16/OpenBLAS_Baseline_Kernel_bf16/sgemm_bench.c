#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

typedef long BLASLONG;
typedef float FLOAT;
typedef __bf16 IFLOAT;

/* Kernel declaration */
int sgemm_kernel_bf16(
    BLASLONG M, BLASLONG N, BLASLONG K,
    FLOAT alpha,
    IFLOAT *A,
    IFLOAT *B,
    FLOAT *C,
    BLASLONG ldc
);

static double now_sec(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

static void fill_bf16(IFLOAT *x, size_t n)
{
    for(size_t i=0;i<n;i++)
        x[i] = (IFLOAT)((float)((i%13)-6)*0.1f);
}

static void fill_fp32(FLOAT *x, size_t n)
{
    for(size_t i=0;i<n;i++)
        x[i] = (FLOAT)((i%17)-8)*0.1f;
}

int main(int argc,char**argv)
{
    if(argc<4){
        printf("Usage: %s M N K\n",argv[0]);
        return 0;
    }

    BLASLONG M=atol(argv[1]);
    BLASLONG N=atol(argv[2]);
    BLASLONG K=atol(argv[3]);

    size_t sizeA=(size_t)M*K;
    size_t sizeB=(size_t)N*K;
    size_t sizeC=(size_t)M*N;

    IFLOAT *A = aligned_alloc(64,sizeA*sizeof(IFLOAT));
    IFLOAT *B = aligned_alloc(64,sizeB*sizeof(IFLOAT));
    FLOAT  *C = aligned_alloc(64,sizeC*sizeof(FLOAT));

    fill_bf16(A,sizeA);
    fill_bf16(B,sizeB);
    fill_fp32(C,sizeC);

    double t0=now_sec();

    sgemm_kernel_bf16(
        M,N,K,
        1.0f,
        A,B,C,M
    );

    double t1=now_sec();

    double time=t1-t0;

    double gflops =
        (2.0*(double)M*N*K)/(time*1e9);

    printf("M=%ld N=%ld K=%ld\n",M,N,K);
    printf("Time: %.6f sec\n",time);
    printf("GFLOPS: %.4f\n",gflops);

    free(A);
    free(B);
    free(C);

    return 0;
}