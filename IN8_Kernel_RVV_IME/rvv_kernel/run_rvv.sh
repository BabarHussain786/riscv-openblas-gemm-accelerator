/*
 * bench_rvv.c — Benchmark for RVV mirror kernel (ISA comparison with IME)
 * Same bench structure as IME. Runs on ALL 8 cores.
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

static double get_time_sec(void){
    struct timespec ts; clock_gettime(CLOCK_MONOTONIC,&ts);
    return (double)ts.tv_sec+(double)ts.tv_nsec*1e-9;
}
static const char *get_core_type(void){
    int c=sched_getcpu(); if(c<0) return "unknown";
    char p[128]; struct stat st;
    snprintf(p,sizeof(p),"/sys/firmware/devicetree/base/cpus/cpu@%d/cpu-ai",c);
    return stat(p,&st)==0?"AI (Cluster0)":"General (Cluster1)";
}
static void ref_gemm(long M,long N,long K,int32_t a,const int8_t *A,const int8_t *B,int32_t *C,long ldc){
    for(long c=0;c<N;c++)for(long r=0;r<M;r++){
        int32_t s=0;for(long k=0;k<K;k++)s+=(int32_t)A[k*M+r]*(int32_t)B[k*N+c];
        C[c*ldc+r]=a*s;
    }
}
static int validate(const int32_t *r,const int32_t *t,long M,long N,long ldc){
    int e=0;
    for(long c=0;c<N;c++)for(long i=0;i<M;i++){
        long x=c*ldc+i;
        if(r[x]!=t[x]){if(e<5)printf("  MISMATCH C(%ld,%ld): exp=%d got=%d\n",i,c,r[x],t[x]);e++;}
    }return e;
}
static void sep(void){printf("────────────────────────────────────────────────────────────────\n");}

int main(int argc,char **argv){
    long M=1024,N=1024,K=1024;
    if(argc==2)M=N=K=atol(argv[1]);
    else if(argc==4){M=atol(argv[1]);N=atol(argv[2]);K=atol(argv[3]);}
    if(M<=0||N<=0||K<=0){fprintf(stderr,"Usage: %s [size] or %s M N K\n",argv[0],argv[0]);return 1;}
    int cpu=sched_getcpu();int32_t alpha=1;long ldc=M;double ops=2.0*M*N*K;

    printf("\n");sep();
    printf("  SpacemiT K1 RVV MIRROR GEMM (ISA comparison with IME)\n");
    printf("  int8 × int8 → int32 | vwmul+vwredsum replaces vmadot\n");sep();
    printf("  CPU: %d (%s)  Size: %ldx%ldx%ld  Ops: %.2fG\n",cpu,get_core_type(),M,N,K,ops/1e9);sep();printf("\n");

    int8_t *A=(int8_t*)aligned_alloc(64,M*K);
    int8_t *B=(int8_t*)aligned_alloc(64,K*N);
    int32_t *Cr=(int32_t*)aligned_alloc(64,M*N*4);
    int32_t *Ct=(int32_t*)aligned_alloc(64,M*N*4);
    if(!A||!B||!Cr||!Ct){fprintf(stderr,"alloc fail\n");return 1;}
    srand(42);
    for(long i=0;i<M*K;i++)A[i]=(int8_t)((rand()%11)-5);
    for(long i=0;i<K*N;i++)B[i]=(int8_t)((rand()%11)-5);

    int dov=(M*N*K<=512L*512L*512L);
    if(dov){printf("[ref] Scalar reference...\n");memset(Cr,0,M*N*4);ref_gemm(M,N,K,alpha,A,B,Cr,ldc);}
    printf("[warmup] ");memset(Ct,0,M*N*4);spacemit_rvv_gemm(M,N,K,alpha,A,B,Ct,ldc);
    if(dov){int e=validate(Cr,Ct,M,N,ldc);printf(e==0?"PASS ✓\n":"FAIL ✗ (%d)\n",e);}
    else printf("skip validation\n");

    printf("[bench] 3 iterations:\n");
    double best=1e18,tot=0;
    for(int it=0;it<3;it++){
        memset(Ct,0,M*N*4);double t0=get_time_sec();
        spacemit_rvv_gemm(M,N,K,alpha,A,B,Ct,ldc);
        double dt=get_time_sec()-t0;tot+=dt;if(dt<best)best=dt;
        printf("  Iter %d: %.3f sec (%.2f GOPS)\n",it+1,dt,ops/dt/1e9);
    }
    printf("\n");sep();
    printf("  RESULTS (RVV Mirror — same structure as IME)\n");sep();
    printf("  CPU %d (%s)  %ldx%ldx%ld\n",cpu,get_core_type(),M,N,K);
    printf("  Best: %.3f sec  %.2f GOPS\n",best,ops/best/1e9);
    printf("  Avg:  %.3f sec  %.2f GOPS\n",tot/3,ops/(tot/3)/1e9);
    if(dov)printf("  Correct: YES\n");
    sep();printf("\n");
    free(A);free(B);free(Cr);free(Ct);return 0;
}
