/*
 * ╔══════════════════════════════════════════════════════════════════════════╗
 * ║  rvv_kernel.c — RVV MIRROR of IME GEMM Micro-Kernel                   ║
 * ║  ONLY vmadot replaced. Everything else identical to ime_kernel.c.      ║
 * ╚══════════════════════════════════════════════════════════════════════════╝
 *
 * PURPOSE: Fair ISA comparison. Same structure, same data flow, different insn.
 *
 * WHAT CHANGED from ime_kernel.c:
 *   Section 1: vmadot #defines     → REMOVED
 *   Section 2: detect_ime_available → REMOVED (RVV runs on all cores)
 *   Section 4: 4× .word vmadot     → 4× RVV vwmul+vwredsum+vmv_x_s block
 *   Section 6: dispatch             → REMOVED (always RVV)
 *
 * WHAT IS IDENTICAL:
 *   Section 3: packing (byte-identical)
 *   Section 4: accumulator zeroing, B load, A loads, alpha scale, C store
 *   Section 5: scalar fallback (byte-identical)
 *   Section 6: loop structure, allocation, tails (byte-identical)
 *
 * COMPILE: gcc -O3 -march=rv64gcv -mabi=lp64d -o gemm bench_rvv.c rvv_kernel.c
 */

#include <riscv_vector.h>
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "rvv_kernel.h"

/* ═══════════════════════════════════════════
 * SECTION 1: (REMOVED — no vmadot encodings)
 * SECTION 2: (REMOVED — no AI-core detection)
 * ═══════════════════════════════════════════ */

/* ═══════════════════════════════════════════
 * SECTION 3: PACKING (identical to IME)
 * ═══════════════════════════════════════════ */
static void pack_A_panel(const int8_t *A, BLASLONG m_top, BLASLONG M,
                         int8_t *dst, BLASLONG K_main) {
    const BLASLONG K_steps = K_main / IME_KR;
    for (BLASLONG ks = 0; ks < K_steps; ks++) {
        const BLASLONG kb = ks * IME_KR;
        for (int sub = 0; sub < 4; sub++) {
            int r0 = sub * 2;
            for (int r = r0; r < r0+2; r++)
                for (int kk = 0; kk < IME_KR; kk++)
                    *dst++ = A[(kb+kk)*M + m_top + r];
        }
    }
}

static void pack_B_panel(const int8_t *B, BLASLONG n_top, BLASLONG N,
                         int8_t *dst, BLASLONG K_main) {
    const BLASLONG K_steps = K_main / IME_KR;
    for (BLASLONG ks = 0; ks < K_steps; ks++) {
        const BLASLONG kb = ks * IME_KR;
        for (int c = 0; c < NR; c++)
            for (int kk = 0; kk < IME_KR; kk++)
                *dst++ = B[(kb+kk)*N + n_top + c];
    }
}

/* ═══════════════════════════════════════════
 * SECTION 4: RVV MIRROR MICRO-KERNEL (8×4)
 *
 * IDENTICAL to IME kernel EXCEPT:
 *   4× ".word vmadot" replaced by RVV compute block.
 *
 * SAME: accumulator zeroing (STEP 1)
 * SAME: vsetvli mode (STEP 2)
 * SAME: A loads vle8 v16..v19 (STEP 3 loads)
 * SAME: B load vle8 v20 (STEP 3 load)
 * CHANGED: 4× vmadot → RVV compute (STEP 3 compute)
 * SAME: alpha scale vmul.vx (STEP 4)
 * SAME: strided C store (STEP 5)
 *
 * RVV COMPUTE (replaces each vmadot):
 *   vmadot does: acc[2×4] += A_sub[2×8] × B[4×8]^T
 *
 *   RVV equivalent for one vmadot:
 *     For row r in {0,1} within sub-panel:
 *       For col c in {0,1,2,3}:
 *         vwmul.vv: A_row[8] × B_col[8] → 8×i16
 *         vwredsum: 8×i16 → 1×i32 (dot product)
 *         vmv.x.s: extract scalar → acc[r][c]
 *
 *   8 dot products per vmadot replacement.
 *   4 vmadot replacements = 32 dot products per K-step.
 *
 * Since the asm store needs v8/v10/v12/v14 in paired
 * layout, we compute into a C array then load into
 * vector registers for the IDENTICAL store sequence.
 * ═══════════════════════════════════════════ */

static void rvv_mirror_kernel_8x4(
    BLASLONG K_main, int32_t alpha,
    const int8_t *A_pack, const int8_t *B_pack,
    int32_t *C, BLASLONG ldc)
{
    const BLASLONG K_steps = K_main / IME_KR;

    /*
     * Paired accumulators — SAME layout as IME's v8/v10/v12/v14.
     * pair[p][0..3] = even row of pair, pair[p][4..7] = odd row.
     */
    int32_t pair[4][8] __attribute__((aligned(32)));
    memset(pair, 0, sizeof(pair));

    const int8_t *a_ptr = A_pack;
    const int8_t *b_ptr = B_pack;

    /* ── K-LOOP (same iteration count, same pointer advance as IME) ── */
    for (BLASLONG ks = 0; ks < K_steps; ks++) {

        /*
         * LOADS — identical to IME:
         *   a_ptr[0..15]  = A sub-panel 0 (rows 0-1, 2×8)  ← IME: vle8 v16
         *   a_ptr[16..31] = A sub-panel 1 (rows 2-3, 2×8)  ← IME: vle8 v17
         *   a_ptr[32..47] = A sub-panel 2 (rows 4-5, 2×8)  ← IME: vle8 v18
         *   a_ptr[48..63] = A sub-panel 3 (rows 6-7, 2×8)  ← IME: vle8 v19
         *   b_ptr[0..31]  = B panel (cols 0-3, 4×8)         ← IME: vle8 v20
         *
         * Same data, same offsets, same reuse pattern.
         */

        size_t vl8 = __riscv_vsetvl_e8m1(IME_KR); /* vl=8 for dot products */

        /* Pre-load 4 B columns as vectors (B loaded once, reused 4× per sub-panel).
         * B_pack layout: [col0:k0..k7][col1:k0..k7][col2:k0..k7][col3:k0..k7]
         * This is the SAME data that IME loaded into v20 as one 32B block. */
        vint8m1_t vb0 = __riscv_vle8_v_i8m1(&b_ptr[0*IME_KR], vl8);
        vint8m1_t vb1 = __riscv_vle8_v_i8m1(&b_ptr[1*IME_KR], vl8);
        vint8m1_t vb2 = __riscv_vle8_v_i8m1(&b_ptr[2*IME_KR], vl8);
        vint8m1_t vb3 = __riscv_vle8_v_i8m1(&b_ptr[3*IME_KR], vl8);

        /* Zero scalar for widen-reduce initial value */
        vint32m1_t vzero = __riscv_vmv_v_x_i32m1(0, 1);

        /*
         * COMPUTE — replaces 4× vmadot with RVV vwmul+vwredsum.
         *
         * For each sub-panel s (0..3), same as IME's 4 vmadot calls:
         *   IME:  vmadot v_acc_s, v_a_s, v20
         *   RVV:  for each row r in sub-panel (2 rows):
         *           for each col c (4 cols):
         *             dot = vwmul(A_row, B_col) → vwredsum → vmv_x_s
         *             pair[s][r*4+c] += dot
         */
        for (int sub = 0; sub < 4; sub++) {
            const int8_t *a_sub = &a_ptr[sub * 16]; /* same offset as IME vle8 */

            for (int row = 0; row < 2; row++) {
                /* Load A row: 8×int8 — same data as inside IME's v16..v19 */
                vint8m1_t va = __riscv_vle8_v_i8m1(&a_sub[row * IME_KR], vl8);

                size_t vl16 = __riscv_vsetvl_e16m2(IME_KR);

                /* 4 dot products: A_row[8] · B_col[8] for each col */
                /* vwmul: int8×int8 → int16 (8 products) */
                /* vwredsum: Σ 8×int16 → 1×int32 (widening reduction) */
                /* vmv_x_s: extract scalar result */

                vint16m2_t p0 = __riscv_vwmul_vv_i16m2(va, vb0, vl8);
                vint16m2_t p1 = __riscv_vwmul_vv_i16m2(va, vb1, vl8);
                vint16m2_t p2 = __riscv_vwmul_vv_i16m2(va, vb2, vl8);
                vint16m2_t p3 = __riscv_vwmul_vv_i16m2(va, vb3, vl8);

                vint32m1_t s0 = __riscv_vwredsum_vs_i16m2_i32m1(p0, vzero, vl16);
                vint32m1_t s1 = __riscv_vwredsum_vs_i16m2_i32m1(p1, vzero, vl16);
                vint32m1_t s2 = __riscv_vwredsum_vs_i16m2_i32m1(p2, vzero, vl16);
                vint32m1_t s3 = __riscv_vwredsum_vs_i16m2_i32m1(p3, vzero, vl16);

                int pos = row * 4; /* 0 for even row, 4 for odd row */
                pair[sub][pos+0] += __riscv_vmv_x_s_i32m1_i32(s0);
                pair[sub][pos+1] += __riscv_vmv_x_s_i32m1_i32(s1);
                pair[sub][pos+2] += __riscv_vmv_x_s_i32m1_i32(s2);
                pair[sub][pos+3] += __riscv_vmv_x_s_i32m1_i32(s3);
            }
        }

        /* Pointer advance — IDENTICAL to IME */
        a_ptr += 64;  /* 4 sub-panels × 16B */
        b_ptr += 32;  /* 1 B panel × 32B    */
    }

    /*
     * STORE — IDENTICAL asm block from IME kernel.
     * Load paired accumulators into v8/v10/v12/v14,
     * then run the EXACT SAME alpha scale + strided store.
     */
    __asm__ __volatile__ (
        /* Load paired accumulators → v8/v10/v12/v14 (same as IME layout) */
        "li         t0, 8\n\t"
        "vsetvli    zero, t0, e32, m1, ta, ma\n\t"
        "vle32.v    v8,  (%[p0])\n\t"
        "vle32.v    v10, (%[p1])\n\t"
        "vle32.v    v12, (%[p2])\n\t"
        "vle32.v    v14, (%[p3])\n\t"

        /* STEP 4: Scale by alpha — IDENTICAL to IME */
        "vmul.vx    v8,  v8,  %[alpha]\n\t"
        "vmul.vx    v10, v10, %[alpha]\n\t"
        "vmul.vx    v12, v12, %[alpha]\n\t"
        "vmul.vx    v14, v14, %[alpha]\n\t"

        /* STEP 5: Strided store — IDENTICAL to IME (byte-for-byte) */
        "slli       t4, %[ldc], 2\n\t"
        "li         t0, 4\n\t"
        "vsetvli    zero, t0, e32, m1, ta, ma\n\t"

        /* Row 0: v8[0:3] */
        "mv         t5, %[cptr]\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v8\n\t"
        "vsse32.v   v24, (t5), t4\n\t"
        /* Row 1: v8[4:7] → slidedown */
        "addi       t5, %[cptr], 4\n\t"
        "vslidedown.vi v25, v8, 4\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v25\n\t"
        "vsse32.v   v24, (t5), t4\n\t"
        /* Row 2: v10[0:3] */
        "addi       t5, %[cptr], 8\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v10\n\t"
        "vsse32.v   v24, (t5), t4\n\t"
        /* Row 3: v10[4:7] */
        "addi       t5, %[cptr], 12\n\t"
        "vslidedown.vi v25, v10, 4\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v25\n\t"
        "vsse32.v   v24, (t5), t4\n\t"
        /* Row 4: v12[0:3] */
        "addi       t5, %[cptr], 16\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v12\n\t"
        "vsse32.v   v24, (t5), t4\n\t"
        /* Row 5: v12[4:7] */
        "addi       t5, %[cptr], 20\n\t"
        "vslidedown.vi v25, v12, 4\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v25\n\t"
        "vsse32.v   v24, (t5), t4\n\t"
        /* Row 6: v14[0:3] */
        "addi       t5, %[cptr], 24\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v14\n\t"
        "vsse32.v   v24, (t5), t4\n\t"
        /* Row 7: v14[4:7] */
        "addi       t5, %[cptr], 28\n\t"
        "vslidedown.vi v25, v14, 4\n\t"
        "vlse32.v   v24, (t5), t4\n\t"
        "vadd.vv    v24, v24, v25\n\t"
        "vsse32.v   v24, (t5), t4\n\t"

        : : [p0]"r"(pair[0]), [p1]"r"(pair[1]),
            [p2]"r"(pair[2]), [p3]"r"(pair[3]),
            [alpha]"r"(alpha), [cptr]"r"(C), [ldc]"r"(ldc)
        : "t0", "t4", "t5", "memory",
          "v8", "v10", "v12", "v14", "v24", "v25"
    );
}


/* ═══════════════════════════════════════════
 * SECTION 5: SCALAR FALLBACK (identical to IME)
 * ═══════════════════════════════════════════ */
static void scalar_gemm_block(
    BLASLONG rows, BLASLONG cols, BLASLONG K, int32_t alpha,
    const int8_t *A, BLASLONG lda, const int8_t *B, BLASLONG ldb,
    int32_t *C, BLASLONG ldc) {
    for (BLASLONG c=0;c<cols;c++)
        for (BLASLONG r=0;r<rows;r++) {
            int32_t acc=0;
            for (BLASLONG k=0;k<K;k++)
                acc += (int32_t)A[k*lda+r] * (int32_t)B[k*ldb+c];
            C[c*ldc+r] += alpha*acc;
        }
}

static int scalar_gemm_full(
    BLASLONG M,BLASLONG N,BLASLONG K,int32_t alpha,
    const int8_t *A,const int8_t *B,int32_t *C,BLASLONG ldc) {
    BLASLONG n_top=0;
    for(BLASLONG j=0;j<N/NR;j++){
        BLASLONG m_top=0;
        for(BLASLONG i=0;i<M/MR;i++){scalar_gemm_block(MR,NR,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=MR;}
        BLASLONG mr=M%MR;
        if(mr>=4){scalar_gemm_block(4,NR,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=4;mr-=4;}
        if(mr>=2){scalar_gemm_block(2,NR,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=2;mr-=2;}
        if(mr>=1){scalar_gemm_block(1,NR,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);}
        n_top+=NR;
    }
    if(N&2){
        BLASLONG m_top=0;
        for(BLASLONG i=0;i<M/MR;i++){scalar_gemm_block(MR,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=MR;}
        BLASLONG mr=M%MR;
        if(mr>=4){scalar_gemm_block(4,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=4;mr-=4;}
        if(mr>=2){scalar_gemm_block(2,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=2;mr-=2;}
        if(mr>=1){scalar_gemm_block(1,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);}
        n_top+=2;
    }
    if(N&1){
        BLASLONG m_top=0;
        for(BLASLONG i=0;i<M/MR;i++){scalar_gemm_block(MR,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=MR;}
        BLASLONG mr=M%MR;
        if(mr>=4){scalar_gemm_block(4,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=4;mr-=4;}
        if(mr>=2){scalar_gemm_block(2,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=2;mr-=2;}
        if(mr>=1){scalar_gemm_block(1,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);}
    }
    return 0;
}


/* ═══════════════════════════════════════════
 * SECTION 6: PUBLIC API (identical to IME minus dispatch)
 * ═══════════════════════════════════════════ */
int spacemit_rvv_gemm(
    BLASLONG M,BLASLONG N,BLASLONG K,int32_t alpha,
    const int8_t *A,const int8_t *B,int32_t *C,BLASLONG ldc)
{
    /* ── Validate (identical to IME) ── */
    if(M<=0||N<=0||K<=0) return 0;
    if(ldc<M){fprintf(stderr,"rvv_gemm: ldc<M\n");return -1;}
    if(!A||!B||!C){fprintf(stderr,"rvv_gemm: null\n");return -1;}

    /* ── NO dispatch — always RVV (this is the only difference from IME) ── */

    /* ── RVV path setup (identical to IME) ── */
    const BLASLONG K_steps=K/IME_KR, K_main=K_steps*IME_KR;
    const BLASLONG M_blocks=M/MR, N_blocks=N/NR;
    if(K_main==0||M_blocks==0||N_blocks==0){
        scalar_gemm_block(M,N,K,alpha,A,M,B,N,C,ldc); return 0;
    }

    /* ── Allocate (identical to IME) ── */
    const BLASLONG Apb=K_steps*64, Bpb=K_steps*32;
    int8_t *Aall=(int8_t*)aligned_alloc(64,M_blocks*Apb);
    int8_t *Bp=(int8_t*)aligned_alloc(64,Bpb);
    if(!Aall||!Bp){free(Aall);free(Bp);return scalar_gemm_full(M,N,K,alpha,A,B,C,ldc);}

    /* ── PHASE 1: Pack A once (identical to IME) ── */
    for(BLASLONG i=0;i<M_blocks;i++)
        pack_A_panel(A,i*MR,M,&Aall[i*Apb],K_main);

    /* ── PHASE 2: N-loop × M-loop (identical structure, different kernel call) ── */
    BLASLONG n_top=0;
    for(BLASLONG j=0;j<N_blocks;j++){
        pack_B_panel(B,n_top,N,Bp,K_main); /* identical B packing */
        BLASLONG m_top=0;
        for(BLASLONG i=0;i<M_blocks;i++){
            rvv_mirror_kernel_8x4(K_main,alpha,&Aall[i*Apb],Bp,&C[n_top*ldc+m_top],ldc);
            if(K_main<K) scalar_gemm_block(MR,NR,K-K_main,alpha,&A[m_top+K_main*M],M,&B[n_top+K_main*N],N,&C[n_top*ldc+m_top],ldc);
            m_top+=MR;
        }
        BLASLONG mr=M%MR;
        if(mr>=4){scalar_gemm_block(4,NR,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=4;mr-=4;}
        if(mr>=2){scalar_gemm_block(2,NR,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=2;mr-=2;}
        if(mr>=1){scalar_gemm_block(1,NR,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);}
        n_top+=NR;
    }

    /* ── PHASE 3: N tails (identical to IME) ── */
    if(N&2){
        BLASLONG m_top=0;
        for(BLASLONG i=0;i<M/MR;i++){scalar_gemm_block(MR,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=MR;}
        BLASLONG mr=M%MR;
        if(mr>=4){scalar_gemm_block(4,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=4;mr-=4;}
        if(mr>=2){scalar_gemm_block(2,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=2;mr-=2;}
        if(mr>=1){scalar_gemm_block(1,2,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);}
        n_top+=2;
    }
    if(N&1){
        BLASLONG m_top=0;
        for(BLASLONG i=0;i<M/MR;i++){scalar_gemm_block(MR,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=MR;}
        BLASLONG mr=M%MR;
        if(mr>=4){scalar_gemm_block(4,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=4;mr-=4;}
        if(mr>=2){scalar_gemm_block(2,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);m_top+=2;mr-=2;}
        if(mr>=1){scalar_gemm_block(1,1,K,alpha,&A[m_top],M,&B[n_top],N,&C[n_top*ldc+m_top],ldc);}
    }

    /* ── Cleanup (identical to IME) ── */
    free(Aall); free(Bp);
    return 0;
}
