	.file	"dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zifencei2p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (Bianbu 14.2.0-4ubuntu2~24.04bb1) version 14.2.0 (riscv64-linux-gnu)
#	compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mabi=lp64d -misa-spec=20191213 -mtls-dialect=trad -march=rv64imafdcv_zicsr_zifencei_zve32f_zve32x_zve64d_zve64f_zve64x_zvl128b_zvl32b_zvl64b -O3 -fno-asynchronous-unwind-tables -fstack-protector-strong
	.text
	.align	1
	.globl	dgemm_kernel_8x4_zvl128b_lmul8_nounroll
	.type	dgemm_kernel_8x4_zvl128b_lmul8_nounroll, @function
dgemm_kernel_8x4_zvl128b_lmul8_nounroll:
.LFB0:
	.cfi_startproc
	csrr	t0,vlenb	#
	addi	sp,sp,-112	#,,
	.cfi_def_cfa_offset 112
	slli	t1,t0,5	#,,
	sd	s2,88(sp)	#,
	sd	s0,104(sp)	#,
	sd	s1,96(sp)	#,
	sd	s3,80(sp)	#,
	sd	s4,72(sp)	#,
	sd	s5,64(sp)	#,
	sd	s6,56(sp)	#,
	sd	s7,48(sp)	#,
	sd	s8,40(sp)	#,
	sd	s9,32(sp)	#,
	sd	s10,24(sp)	#,
	sd	s11,16(sp)	#,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	srai	a7,a1,63	#, tmp283, N
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:20: {
	sub	sp,sp,t1	#,,
	.cfi_escape 0xf,0xc,0x72,0,0x92,0xa2,0x38,0,0x8,0x40,0x1e,0x23,0x70,0x22
	.cfi_offset 18, -24
	.cfi_offset 8, -8
	.cfi_offset 9, -16
	.cfi_offset 19, -32
	.cfi_offset 20, -40
	.cfi_offset 21, -48
	.cfi_offset 22, -56
	.cfi_offset 23, -64
	.cfi_offset 24, -72
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:20: {
	mv	t4,a6	# tmp341, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	andi	a7,a7,3	#, tmp284, tmp283
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:20: {
	sd	a5,8(sp)	# tmp340, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	li	t1,3		# tmp287,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:20: {
	fmv.d	fa4,fa0	# alpha, tmp337
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	add	a7,a7,a1	# N, tmp285, tmp284
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:20: {
	mv	s2,a0	# M, tmp334
	mv	t3,a2	# K, tmp336
	mv	t0,a3	# A, tmp338
	mv	a6,a4	# B, tmp339
	mv	a5,t4	# ldc, tmp341
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	ble	a1,t1,.L20	#, N, tmp287,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	srai	t5,a0,63	#, tmp290, M
	andi	t5,t5,7	#, tmp291, tmp290
	ld	s0,8(sp)		# ivtmp.176, %sfp
	add	t5,t5,a0	# M, tmp292, tmp291
	slli	s1,a2,5	#, _277, K
	slli	s4,t4,5	#, _331, ldc
	srai	a3,a7,2	#, _272, tmp285
	srai	t5,t5,3	#, _276, tmp292
	add	a2,a4,s1	# _277, ivtmp.181, B
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:32:         gvl = __riscv_vsetvl_e64m8(8);
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
	addi	a0,a6,32	#, ivtmp.180, B
	slli	t4,t3,6	#, _461, K
	slli	t1,a5,3	#, _347, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	li	t2,0		# j,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	li	s3,7		# tmp294,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:53:             for (BLASLONG k = 1; k < K; k++) {
	li	t6,1		# tmp333,
.L4:
	mv	s10,t0	# ivtmp.160, A
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	mv	s8,s0	# ivtmp.161, ivtmp.176
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	li	a7,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	ble	s2,s3,.L8	#, M, tmp294,
.L7:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:45:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai], gvl);
	vle64.v	v16,0(s10)	# A0,* ivtmp.160
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:41:             double B2 = B[bi + 2];
	fld	fa3,-16(a0)	# B2, MEM[(FLOAT *)_264 + -16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:42:             double B3 = B[bi + 3];
	fld	fa5,-8(a0)	# B3, MEM[(FLOAT *)_264 + -8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:50:             vfloat64m8_t r2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	addi	s5,sp,16	#, tmp416,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:48:             vfloat64m8_t r0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa1,-32(a0)	# MEM[(FLOAT *)_264 + -32B], MEM[(FLOAT *)_264 + -32B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:40:             double B1 = B[bi + 1];
	fld	fa2,-24(a0)	# B1, MEM[(FLOAT *)_264 + -24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:50:             vfloat64m8_t r2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	vfmul.vf	v8,v16,fa3	# r2, A0, B2,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:48:             vfloat64m8_t r0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	vfmul.vf	v0,v16,fa1	# r0, A0, MEM[(FLOAT *)_264 + -32B],
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:49:             vfloat64m8_t r1 = __riscv_vfmul_vf_f64m8(A0, B1, gvl);
	vfmul.vf	v24,v16,fa2	# r1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:50:             vfloat64m8_t r2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	vs8r.v	v8,0(s5)	# r2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:51:             vfloat64m8_t r3 = __riscv_vfmul_vf_f64m8(A0, B3, gvl);
	vfmul.vf	v8,v16,fa5	# r3, A0, B3,
	csrr	s5,vlenb	# tmp397
	slli	s6,s5,3	#, tmp398, tmp397
	addi	s5,sp,16	#, tmp401,
	add	s6,s6,s5	# tmp401, tmp396, tmp396
	vs8r.v	v8,0(s6)	# r3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:53:             for (BLASLONG k = 1; k < K; k++) {
	ble	t3,t6,.L5	#, K, tmp333,
	addi	s7,s10,64	#, ivtmp.153, ivtmp.160
	mv	s6,a0	# ivtmp.151, ivtmp.180
.L6:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:66:                 r2 = __riscv_vfmacc_vf_f64m8(r2, B2, A0, gvl);
	addi	s5,sp,16	#, tmp414,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:61:                 A0 = __riscv_vle64_v_f64m8(&A[ai], gvl);
	vle64.v	v8,0(s7)	# A0,* ivtmp.153
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:66:                 r2 = __riscv_vfmacc_vf_f64m8(r2, B2, A0, gvl);
	vl8re64.v	v16,0(s5)	# %sfp, r2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:57:                 B2 = B[bi + 2];
	fld	fa1,16(s6)	# B2, MEM[(FLOAT *)_373 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:67:                 r3 = __riscv_vfmacc_vf_f64m8(r3, B3, A0, gvl);
	csrr	s9,vlenb	# tmp393
	slli	s9,s9,3	#, tmp394, tmp393
	add	s9,s9,s5	# tmp402, tmp392, tmp392
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:58:                 B3 = B[bi + 3];
	fld	fa5,24(s6)	# B3, MEM[(FLOAT *)_373 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:66:                 r2 = __riscv_vfmacc_vf_f64m8(r2, B2, A0, gvl);
	vfmacc.vf	v16,fa1,v8	# r2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:64:                 r0 = __riscv_vfmacc_vf_f64m8(r0, B0, A0, gvl);
	fld	fa2,0(s6)	# MEM[(FLOAT *)_373], MEM[(FLOAT *)_373]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:56:                 B1 = B[bi + 1];
	fld	fa3,8(s6)	# B1, MEM[(FLOAT *)_373 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:53:             for (BLASLONG k = 1; k < K; k++) {
	addi	s6,s6,32	#, ivtmp.151, ivtmp.151
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:64:                 r0 = __riscv_vfmacc_vf_f64m8(r0, B0, A0, gvl);
	vfmacc.vf	v0,fa2,v8	# r0, MEM[(FLOAT *)_373], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:65:                 r1 = __riscv_vfmacc_vf_f64m8(r1, B1, A0, gvl);
	vfmacc.vf	v24,fa3,v8	# r1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:66:                 r2 = __riscv_vfmacc_vf_f64m8(r2, B2, A0, gvl);
	vs8r.v	v16,0(s5)	# r2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:67:                 r3 = __riscv_vfmacc_vf_f64m8(r3, B3, A0, gvl);
	vl8re64.v	v16,0(s9)	# %sfp, r3
	csrr	s9,vlenb	# tmp389
	slli	s9,s9,3	#, tmp390, tmp389
	add	s9,s9,s5	# tmp403, tmp388, tmp388
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:53:             for (BLASLONG k = 1; k < K; k++) {
	addi	s7,s7,64	#, ivtmp.153, ivtmp.153
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:67:                 r3 = __riscv_vfmacc_vf_f64m8(r3, B3, A0, gvl);
	vfmacc.vf	v16,fa5,v8	# r3, B3, A0,
	vs8r.v	v16,0(s9)	# r3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:53:             for (BLASLONG k = 1; k < K; k++) {
	bne	a2,s6,.L6	#, ivtmp.181, ivtmp.151,
.L5:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:78:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	csrr	s5,vlenb	# tmp385
	li	s11,24		# tmp384,
	mul	s11,s11,s5	# tmp386, tmp384, tmp385
	add	s9,t1,s8	# ivtmp.161, _346, _347
	add	s7,s9,t1	# _347, _343, _346
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:78:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	s6,s7,t1	# _347, _44, _343
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:72:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v8,0(s8)	# c0,* ivtmp.161
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:78:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v16,0(s6)	# c3,* _44
	addi	s5,sp,16	#, tmp404,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	addi	a7,a7,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	add	s10,s10,t4	# _461, ivtmp.160, ivtmp.160
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:78:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	s11,s11,s5	# tmp404, tmp384, tmp384
	vs8r.v	v16,0(s11)	# c3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:80:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, r0, gvl);
	vfmacc.vf	v8,fa4,v0	# c0, alpha, r0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:74:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	csrr	s5,vlenb	# tmp381
	slli	s11,s5,4	#, tmp382, tmp381
	addi	s5,sp,16	#, tmp405,
	add	s11,s11,s5	# tmp405, tmp380, tmp380
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:83:             c3 = __riscv_vfmacc_vf_f64m8(c3, alpha, r3, gvl);
	csrr	s5,vlenb	# tmp377
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:80:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, r0, gvl);
	vmv8r.v	v16,v8	# c0, c0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:74:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v8,0(s9)	# c1,* _346
	vs8r.v	v8,0(s11)	# c1, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:83:             c3 = __riscv_vfmacc_vf_f64m8(c3, alpha, r3, gvl);
	li	s11,24		# tmp376,
	mul	s11,s11,s5	# tmp378, tmp376, tmp377
	addi	s5,sp,16	#, tmp406,
	add	s11,s11,s5	# tmp406, tmp376, tmp376
	vl8re64.v	v0,0(s11)	# %sfp, c3
	csrr	s11,vlenb	# tmp373
	slli	s11,s11,3	#, tmp374, tmp373
	add	s11,s11,s5	# tmp407, tmp372, tmp372
	vl8re64.v	v8,0(s11)	# %sfp, r3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:81:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, r1, gvl);
	csrr	s11,vlenb	# tmp369
	slli	s11,s11,4	#, tmp370, tmp369
	add	s11,s11,s5	# tmp408, tmp368, tmp368
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:83:             c3 = __riscv_vfmacc_vf_f64m8(c3, alpha, r3, gvl);
	vfmacc.vf	v0,fa4,v8	# c3, alpha, r3,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:76:             vfloat64m8_t c2 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v8,0(s7)	# c2,* _343
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:87:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v16,0(s8)	# c0,* ivtmp.161,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	addi	s8,s8,64	#, ivtmp.161, ivtmp.161
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:81:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, r1, gvl);
	vl8re64.v	v16,0(s11)	# %sfp, c1
	vfmacc.vf	v16,fa4,v24	# c1, alpha, r1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:82:             c2 = __riscv_vfmacc_vf_f64m8(c2, alpha, r2, gvl);
	vl8re64.v	v24,0(s5)	# %sfp, r2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:89:             __riscv_vse64_v_f64m8(&C[ci], c1, gvl);
	vse64.v	v16,0(s9)	# c1,* _346,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:82:             c2 = __riscv_vfmacc_vf_f64m8(c2, alpha, r2, gvl);
	vfmacc.vf	v8,fa4,v24	# c2, alpha, r2,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:91:             __riscv_vse64_v_f64m8(&C[ci], c2, gvl);
	vse64.v	v8,0(s7)	# c2,* _343,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:93:             __riscv_vse64_v_f64m8(&C[ci], c3, gvl);
	vse64.v	v0,0(s6)	# c3,* _44,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:34:         for (BLASLONG i = 0; i < M / 8; i++) {
	blt	a7,t5,.L7	#, i, _276,
.L8:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	addi	t2,t2,1	#, j, j
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:29:     for (BLASLONG j = 0; j < N / 4; j++) {
	add	s0,s0,s4	# _331, ivtmp.176, ivtmp.176
	add	a0,a0,s1	# _277, ivtmp.180, ivtmp.180
	add	a2,a2,s1	# _277, ivtmp.181, ivtmp.181
	blt	t2,a3,.L4	#, j, _272,
	slli	a3,a3,2	#, n_top, _272
.L2:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:105:     if (N & 2) {
	andi	a4,a1,2	#, _47, N
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:163:     if (N & 1) {
	andi	a1,a1,1	#, _491, N
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:105:     if (N & 2) {
	beq	a4,zero,.L9	#, _47,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	srai	t2,s2,63	#, tmp301, M
	andi	t2,t2,7	#, tmp302, tmp301
	add	t2,t2,s2	# M, tmp303, tmp302
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	li	a2,7		# tmp305,
	vsetivli	a4,8,e64,m8,ta,ma	#, _76,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	srai	t2,t2,3	#, _257, tmp303
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	ble	s2,a2,.L33	#, M, tmp305,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:113:             BLASLONG bi = n_top * K;
	mul	a2,t3,a3	# bi.40_49, K, n_top
	slli	a7,t3,1	#, _412, K
	slli	t4,t3,6	#, _461, K
	mv	t5,t0	# ivtmp.133, A
	slli	s1,a5,3	#, _390, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	li	t6,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:125:             for (BLASLONG k = 1; k < K; k++) {
	li	s0,1		# tmp316,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:138:             BLASLONG ci = n_top * ldc + m_top;
	mul	t1,a3,a5	# _46, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:115:             double B0 = B[bi];
	slli	s4,a2,3	#, _50, bi.40_49
	addi	s3,a2,2	#, _133, bi.40_49
	add	a7,a7,a2	# bi.40_49, _410, _412
	ld	a2,8(sp)		# C, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:116:             double B1 = B[bi + 1];
	addi	s6,s4,8	#, _53, _50
	slli	s3,s3,3	#, _423, _133
	slli	a7,a7,3	#, _409, _410
	add	s6,a6,s6	# _53, _54, B
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:115:             double B0 = B[bi];
	add	s4,a6,s4	# _50, _51, B
	slli	t1,t1,3	#, _397, _46
	add	s3,a6,s3	# _423, ivtmp.121, B
	add	a7,a6,a7	# _409, _407, B
	add	t1,a2,t1	# _397, ivtmp.134, C
.L13:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:119:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai], gvl);
	vle64.v	v8,0(t5)	# A0,* ivtmp.133
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:122:             vfloat64m8_t r0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa3,0(s4)	# *_51, *_51
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:116:             double B1 = B[bi + 1];
	fld	fa5,0(s6)	# B1, *_54
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:122:             vfloat64m8_t r0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	vfmul.vf	v16,v8,fa3	# r0, A0, *_51,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:123:             vfloat64m8_t r1 = __riscv_vfmul_vf_f64m8(A0, B1, gvl);
	vfmul.vf	v8,v8,fa5	# r1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:125:             for (BLASLONG k = 1; k < K; k++) {
	ble	t3,s0,.L11	#, K, tmp316,
	addi	a0,t5,64	#, ivtmp.123, ivtmp.133
	mv	a2,s3	# ivtmp.121, ivtmp.121
.L12:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:131:                 A0 = __riscv_vle64_v_f64m8(&A[ai], gvl);
	vle64.v	v24,0(a0)	# A0,* ivtmp.123
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:134:                 r0 = __riscv_vfmacc_vf_f64m8(r0, B0, A0, gvl);
	fld	fa3,0(a2)	# MEM[(FLOAT *)_414], MEM[(FLOAT *)_414]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:128:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_414 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:125:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,16	#, ivtmp.121, ivtmp.121
	addi	a0,a0,64	#, ivtmp.123, ivtmp.123
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:134:                 r0 = __riscv_vfmacc_vf_f64m8(r0, B0, A0, gvl);
	vfmacc.vf	v16,fa3,v24	# r0, MEM[(FLOAT *)_414], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:135:                 r1 = __riscv_vfmacc_vf_f64m8(r1, B1, A0, gvl);
	vfmacc.vf	v8,fa5,v24	# r1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:125:             for (BLASLONG k = 1; k < K; k++) {
	bne	a7,a2,.L12	#, _407, ivtmp.121,
.L11:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:140:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v0,0(t1)	# c0,* ivtmp.134
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:142:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	a2,s1,t1	# ivtmp.134, _73, _390
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:142:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v24,0(a2)	# c1,* _73
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	addi	t6,t6,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	add	t5,t5,t4	# _461, ivtmp.133, ivtmp.133
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:144:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, r0, gvl);
	vfmacc.vf	v0,fa4,v16	# c0, alpha, r0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:145:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, r1, gvl);
	vfmacc.vf	v24,fa4,v8	# c1, alpha, r1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:149:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v0,0(t1)	# c0,* ivtmp.134,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	addi	t1,t1,64	#, ivtmp.134, ivtmp.134
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:151:             __riscv_vse64_v_f64m8(&C[ci], c1, gvl);
	vse64.v	v24,0(a2)	# c1,* _73,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:110:         for (BLASLONG i = 0; i < M / 8; i++) {
	blt	t6,t2,.L13	#, i, _257,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:163:     if (N & 1) {
	beq	a1,zero,.L33	#, _491,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:156:         n_top += 2;
	addi	a3,a3,2	#, n_top, n_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	srai	a7,s2,3	#, _259, M
	vsetvli	zero,a4,e64,m8,ta,ma	# _76,,,,
.L19:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:192:             BLASLONG ci = n_top * ldc + m_top;
	mul	a1,a3,a5	# _126, n_top, ldc
	ld	a5,8(sp)		# C, %sfp
	add	a2,t0,t4	# _461, ivtmp.109, ivtmp.104
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	li	a0,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:181:             for (BLASLONG k = 1; k < K; k++) {
	li	t1,1		# tmp329,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:171:             BLASLONG bi = n_top * K;
	mul	a3,t3,a3	# bi_172, K, n_top
	slli	a1,a1,3	#, _466, _126
	add	a1,a5,a1	# _466, ivtmp.105, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:173:             double B0 = B[bi];
	slli	a5,a3,3	#, _78, bi_172
	add	a6,a6,a5	# _78, _79, B
.L18:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:176:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai], gvl);
	vle64.v	v8,0(t0)	# A0,* ivtmp.104
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:179:             vfloat64m8_t r0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa5,0(a6)	# *_79, *_79
	vfmul.vf	v8,v8,fa5	# r0, A0, *_79,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:181:             for (BLASLONG k = 1; k < K; k++) {
	ble	t3,t1,.L16	#, K, tmp329,
	addi	a5,t0,64	#, ivtmp.96, ivtmp.104
	mv	a3,a6	# ivtmp.95, _79
.L17:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:186:                 A0 = __riscv_vle64_v_f64m8(&A[ai], gvl);
	vle64.v	v16,0(a5)	# A0,* ivtmp.96
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:189:                 r0 = __riscv_vfmacc_vf_f64m8(r0, B0, A0, gvl);
	fld	fa5,8(a3)	# MEM[(FLOAT *)_450 + 8B], MEM[(FLOAT *)_450 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:181:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.96, ivtmp.96
	addi	a3,a3,8	#, ivtmp.95, ivtmp.95
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:189:                 r0 = __riscv_vfmacc_vf_f64m8(r0, B0, A0, gvl);
	vfmacc.vf	v8,fa5,v16	# r0, MEM[(FLOAT *)_450 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:181:             for (BLASLONG k = 1; k < K; k++) {
	bne	a5,a2,.L17	#, ivtmp.96, ivtmp.109,
.L16:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:194:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v16,0(a1)	# c0,* ivtmp.105
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	addi	a0,a0,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	add	t0,t0,t4	# _461, ivtmp.104, ivtmp.104
	add	a2,a2,t4	# _461, ivtmp.109, ivtmp.109
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:195:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, r0, gvl);
	vfmacc.vf	v16,fa4,v8	# c0, alpha, r0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:197:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v16,0(a1)	# c0,* ivtmp.105,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	addi	a1,a1,64	#, ivtmp.105, ivtmp.105
	blt	a0,a7,.L18	#, i, _259,
.L33:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:206: }
	csrr	t0,vlenb	#
	slli	t1,t0,5	#,,
	add	sp,sp,t1	#,,
	.cfi_remember_state
	.cfi_def_cfa_offset 112
	ld	s0,104(sp)		#,
	.cfi_restore 8
	ld	s1,96(sp)		#,
	.cfi_restore 9
	ld	s2,88(sp)		#,
	.cfi_restore 18
	ld	s3,80(sp)		#,
	.cfi_restore 19
	ld	s4,72(sp)		#,
	.cfi_restore 20
	ld	s5,64(sp)		#,
	.cfi_restore 21
	ld	s6,56(sp)		#,
	.cfi_restore 22
	ld	s7,48(sp)		#,
	.cfi_restore 23
	ld	s8,40(sp)		#,
	.cfi_restore 24
	ld	s9,32(sp)		#,
	.cfi_restore 25
	ld	s10,24(sp)		#,
	.cfi_restore 26
	ld	s11,16(sp)		#,
	.cfi_restore 27
	li	a0,0		#,
	addi	sp,sp,112	#,,
	.cfi_def_cfa_offset 0
	jr	ra		#
.L9:
	.cfi_restore_state
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:163:     if (N & 1) {
	beq	a1,zero,.L33	#, _491,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	srai	a7,s2,63	#, tmp320, M
	andi	a7,a7,7	#, tmp321, tmp320
	add	a7,a7,s2	# M, tmp322, tmp321
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	li	a2,7		# tmp324,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	srai	a7,a7,3	#, _259, tmp322
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:168:         for (BLASLONG i = 0; i < M / 8; i++) {
	ble	s2,a2,.L33	#, M, tmp324,
	slli	t4,t3,6	#, _461, K
	j	.L19		#
.L20:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll1.c:23:     BLASLONG n_top = 0;
	li	a3,0		# n_top,
	j	.L2		#
	.cfi_endproc
.LFE0:
	.size	dgemm_kernel_8x4_zvl128b_lmul8_nounroll, .-dgemm_kernel_8x4_zvl128b_lmul8_nounroll
	.ident	"GCC: (Bianbu 14.2.0-4ubuntu2~24.04bb1) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
