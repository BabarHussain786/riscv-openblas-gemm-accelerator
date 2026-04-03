	.file	"dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c"
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
	.globl	dgemm_kernel_8x4_zvl128b_lmul4_unroll8
	.type	dgemm_kernel_8x4_zvl128b_lmul4_unroll8, @function
dgemm_kernel_8x4_zvl128b_lmul4_unroll8:
.LFB0:
	.cfi_startproc
	addi	sp,sp,-176	#,,
	.cfi_def_cfa_offset 176
	mv	a7,a1	# N, tmp974
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	srai	a1,a1,63	#, tmp725, N
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:18: {
	sd	s3,144(sp)	#,
	sd	s4,136(sp)	#,
	sd	s6,120(sp)	#,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	andi	a1,a1,3	#, tmp726, tmp725
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:18: {
	sd	s0,168(sp)	#,
	sd	s1,160(sp)	#,
	sd	s2,152(sp)	#,
	sd	s5,128(sp)	#,
	sd	s7,112(sp)	#,
	sd	s8,104(sp)	#,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t1,3		# tmp729,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:18: {
	fmv.d	fa1,fa0	# alpha, tmp976
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a1,a1,a7	# N, tmp727, tmp726
	.cfi_offset 19, -32
	.cfi_offset 20, -40
	.cfi_offset 22, -56
	.cfi_offset 8, -8
	.cfi_offset 9, -16
	.cfi_offset 18, -24
	.cfi_offset 21, -48
	.cfi_offset 23, -64
	.cfi_offset 24, -72
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:18: {
	mv	s4,a0	# M, tmp973
	mv	t4,a2	# K, tmp975
	mv	s3,a3	# A, tmp977
	mv	t2,a5	# C, tmp979
	mv	s6,a6	# ldc, tmp980
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ble	a7,t1,.L48	#, N, tmp729,
	slli	s7,a2,5	#, _1652, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:91:         if (M & 4) {
	andi	a2,a0,4	#, _46, M
	sd	a2,8(sp)	# _46, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:153:         if (M & 2) {
	andi	a2,a0,2	#, _91, M
	sd	a2,16(sp)	# _91, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:191:         if (M & 1) {
	andi	a2,a0,1	#, _178, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	slli	a5,a6,1	#, _150, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t5,a0,63	#, tmp732, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:191:         if (M & 1) {
	sd	a2,24(sp)	# _178, %sfp
	slli	a2,a6,2	#, _1660, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	andi	t5,t5,7	#, tmp733, tmp732
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	sd	a5,48(sp)	# _150, %sfp
	sd	a2,40(sp)	# _1660, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	a5,a5,a6	# ldc, _164, _150
	slli	a2,a6,5	#, _1636, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	t5,t5,a0	# M, tmp734, tmp733
	sd	s9,96(sp)	#,
	sd	s10,88(sp)	#,
	sd	s11,80(sp)	#,
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
	slti	a3,a0,8	#, tmp742, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	sd	a5,56(sp)	# _164, %sfp
	sd	a2,32(sp)	# _1636, %sfp
	srai	s0,a1,2	#, _917, tmp727
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t5,t5,3	#, _947, tmp734
	add	t3,a4,s7	# _1652, ivtmp.483, B
	addi	a1,a4,32	#, ivtmp.482, B
	mv	s2,t2	# ivtmp.485, C
	slli	t0,t4,6	#, _1684, K
	slli	t1,a6,3	#, _1672, ldc
	li	s8,8		# _1906,
	beq	a3,zero,.L312	#, tmp742,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:191:         if (M & 1) {
	li	s5,0		# ivtmp.478,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	s1,0		# j,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	s11,7		# tmp744,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	li	t6,1		# tmp893,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:92:             gvl = __riscv_vsetvl_e64m4(4);
	sd	a7,64(sp)	# N, %sfp
	sd	a4,72(sp)	# B, %sfp
.L18:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	s4,s11,.L49	#, M, tmp744,
	vsetivli	zero,8,e64,m4,ta,ma	#,,,,
	mv	a7,s3	# ivtmp.463, A
	mv	a6,s2	# ivtmp.464, ivtmp.485
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	s9,0		# i,
.L8:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:38:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v4,0(a7)	# A0,* ivtmp.463
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:41:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	fld	fa2,-32(a1)	# MEM[(FLOAT *)_1631 + -32B], MEM[(FLOAT *)_1631 + -32B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:33:             double B1 = B[bi + 1];
	fld	fa3,-24(a1)	# B1, MEM[(FLOAT *)_1631 + -24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:34:             double B2 = B[bi + 2];
	fld	fa4,-16(a1)	# B2, MEM[(FLOAT *)_1631 + -16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:35:             double B3 = B[bi + 3];
	fld	fa5,-8(a1)	# B3, MEM[(FLOAT *)_1631 + -8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:41:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	vfmul.vf	v12,v4,fa2	# result0, A0, MEM[(FLOAT *)_1631 + -32B],
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:42:             vfloat64m4_t result1 = __riscv_vfmul_vf_f64m4(A0, B1, gvl);
	vfmul.vf	v16,v4,fa3	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:43:             vfloat64m4_t result2 = __riscv_vfmul_vf_f64m4(A0, B2, gvl);
	vfmul.vf	v20,v4,fa4	# result2, A0, B2,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:44:             vfloat64m4_t result3 = __riscv_vfmul_vf_f64m4(A0, B3, gvl);
	vfmul.vf	v4,v4,fa5	# result3, A0, B3,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	ble	t4,t6,.L6	#, K, tmp893,
	sub	a0,t3,a1	# tmp961, ivtmp.483, ivtmp.482
	addi	a0,a0,-32	#, tmp962, tmp961
	srli	a0,a0,5	#, tmp960, tmp962
	addi	a0,a0,1	#, tmp963, tmp960
	andi	a0,a0,7	#, tmp964, tmp963
	addi	a2,a7,64	#, ivtmp.456, ivtmp.463
	mv	a4,a1	# ivtmp.454, ivtmp.482
	beq	a0,zero,.L7	#, tmp964,,
	li	s10,1		# tmp970,
	beq	a0,s10,.L220	#, tmp964, tmp970,
	li	s10,2		# tmp969,
	beq	a0,s10,.L221	#, tmp964, tmp969,
	li	s10,3		# tmp968,
	beq	a0,s10,.L222	#, tmp964, tmp968,
	li	s10,4		# tmp967,
	beq	a0,s10,.L223	#, tmp964, tmp967,
	li	s10,5		# tmp966,
	beq	a0,s10,.L224	#, tmp964, tmp966,
	li	s10,6		# tmp965,
	beq	a0,s10,.L225	#, tmp964, tmp965,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a1)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a1)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a1)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a1)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a1,32	#, ivtmp.454, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a7,128	#, ivtmp.456, ivtmp.463
.L225:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,64	#, ivtmp.456, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,32	#, ivtmp.454, ivtmp.454
.L224:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,64	#, ivtmp.456, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,32	#, ivtmp.454, ivtmp.454
.L223:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,64	#, ivtmp.456, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,32	#, ivtmp.454, ivtmp.454
.L222:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,64	#, ivtmp.456, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,32	#, ivtmp.454, ivtmp.454
.L221:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,64	#, ivtmp.456, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,32	#, ivtmp.454, ivtmp.454
.L220:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,32	#, ivtmp.454, ivtmp.454
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,64	#, ivtmp.456, ivtmp.456
	beq	t3,a4,.L6	#, ivtmp.483, ivtmp.454,
.L7:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	s10,a2,64	#, tmp972, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(s10)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,32(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,40(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,48(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,56(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,128	#, ivtmp.456, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,64(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,72(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,80(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,88(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s10,128	#, ivtmp.456, tmp972
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,96(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,104(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,112(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,120(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s10,192	#, ivtmp.456, tmp972
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,128(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,136(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,144(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,152(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s10,256	#, ivtmp.456, tmp972
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,168(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,176(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,160(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,184(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s10,320	#, ivtmp.456, tmp972
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,200(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,208(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,216(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,192(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s10,384	#, ivtmp.456, tmp972
	addi	a0,a4,32	#, tmp971, ivtmp.454
	addi	a4,a0,224	#, ivtmp.454, tmp971
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:54:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a2)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,192(a0)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:49:                 B1 = B[bi + 1];
	fld	fa3,200(a0)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:50:                 B2 = B[bi + 2];
	fld	fa4,208(a0)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:51:                 B3 = B[bi + 3];
	fld	fa5,216(a0)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s10,448	#, ivtmp.456, tmp972
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:57:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:58:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:59:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:60:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	bne	t3,a4,.L7	#, ivtmp.483, ivtmp.454,
.L6:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:65:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v24,0(a6)	# c0,* ivtmp.464
	add	a2,t1,a6	# ivtmp.464, _1671, _1672
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:67:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v28,0(a2)	# c1,* _1671
	add	a4,a2,t1	# _1672, _1668, _1671
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:71:             vfloat64m4_t c3 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a0,a4,t1	# _1672, _44, _1668
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:71:             vfloat64m4_t c3 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v8,0(a0)	# c3,* _44
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:72:             c0 = __riscv_vfmacc_vf_f64m4(c0, alpha, result0, gvl);
	vfmacc.vf	v24,fa1,v12	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:69:             vfloat64m4_t c2 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v12,0(a4)	# c2,* _1668
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:73:             c1 = __riscv_vfmacc_vf_f64m4(c1, alpha, result1, gvl);
	vfmacc.vf	v28,fa1,v16	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s9,s9,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a7,a7,t0	# _1684, ivtmp.463, ivtmp.463
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:75:             c3 = __riscv_vfmacc_vf_f64m4(c3, alpha, result3, gvl);
	vfmacc.vf	v8,fa1,v4	# c3, alpha, result3,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:79:             __riscv_vse64_v_f64m4(&C[ci], c0, gvl);
	vse64.v	v24,0(a6)	# c0,* ivtmp.464,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:74:             c2 = __riscv_vfmacc_vf_f64m4(c2, alpha, result2, gvl);
	vfmacc.vf	v12,fa1,v20	# c2, alpha, result2,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a6,a6,64	#, ivtmp.464, ivtmp.464
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:81:             __riscv_vse64_v_f64m4(&C[ci], c1, gvl);
	vse64.v	v28,0(a2)	# c1,* _1671,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:83:             __riscv_vse64_v_f64m4(&C[ci], c2, gvl);
	vse64.v	v12,0(a4)	# c2,* _1668,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:85:             __riscv_vse64_v_f64m4(&C[ci], c3, gvl);
	vse64.v	v8,0(a0)	# c3,* _44,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	s9,t5,.L8	#, i, _947,
	mv	a4,s8	# m_top, _1906
.L5:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:91:         if (M & 4) {
	ld	a2,8(sp)		# _46, %sfp
	bne	a2,zero,.L313	#, _46,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:153:         if (M & 2) {
	ld	a2,16(sp)		# _91, %sfp
	bne	a2,zero,.L314	#, _91,,
.L12:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:191:         if (M & 1) {
	ld	a2,24(sp)		# _178, %sfp
	bne	a2,zero,.L315	#, _178,,
.L15:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ld	a4,40(sp)		# _1660, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	addi	s1,s1,1	#, j, j
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a1,a1,s7	# _1652, ivtmp.482, ivtmp.482
	add	s5,s5,a4	# _1660, ivtmp.478, ivtmp.478
	ld	a4,32(sp)		# _1636, %sfp
	add	t3,t3,s7	# _1652, ivtmp.483, ivtmp.483
	add	s2,s2,a4	# _1636, ivtmp.485, ivtmp.485
	blt	s1,s0,.L18	#, j, _917,
	ld	a7,64(sp)		# N, %sfp
	ld	a4,72(sp)		# B, %sfp
	ld	s9,96(sp)		#,
	.cfi_restore 25
	ld	s10,88(sp)		#,
	.cfi_restore 26
	ld	s11,80(sp)		#,
	.cfi_restore 27
	slli	s0,s0,2	#, n_top, _917
.L2:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:222:     if (N & 2) {
	andi	a5,a7,2	#, _234, N
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:222:     if (N & 2) {
	beq	a5,zero,.L311	#, _234,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,s4,63	#, tmp794, M
	andi	a6,a6,7	#, tmp795, tmp794
	add	a6,a6,s4	# M, tmp796, tmp795
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a3,7		# tmp798,
	vsetivli	zero,8,e64,m4,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a6,3	#, _887, tmp796
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	s4,a3,.L52	#, M, tmp798,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:228:             BLASLONG bi = n_top * K;
	mul	a3,t4,s0	# bi.110_236, K, n_top
	slli	t1,t4,1	#, _348, K
	slli	s7,t4,6	#, _180, K
	mv	t3,s3	# ivtmp.422, A
	slli	s5,s6,3	#, _192, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t6,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	li	s2,1		# tmp808,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:252:             BLASLONG ci = n_top * ldc + m_top;
	mul	a0,s0,s6	# _549, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:229:             double B0 = B[bi + 0];
	slli	t0,a3,3	#, _237, bi.110_236
	addi	t5,a3,2	#, _810, bi.110_236
	add	t1,t1,a3	# bi.110_236, _350, _348
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:230:             double B1 = B[bi + 1];
	addi	s1,t0,8	#, _240, _237
	slli	t5,t5,3	#, _337, _810
	slli	t1,t1,3	#, _617, _350
	add	s1,a4,s1	# _240, _241, B
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:229:             double B0 = B[bi + 0];
	add	t0,a4,t0	# _237, _238, B
	add	t5,a4,t5	# _337, ivtmp.410, B
	slli	a0,a0,3	#, _185, _549
	add	t1,a4,t1	# _617, _619, B
	add	a0,t2,a0	# _185, ivtmp.423, C
.L23:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:233:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v4,0(t3)	# A0,* ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:236:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	fld	fa4,0(t0)	# *_238, *_238
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:230:             double B1 = B[bi + 1];
	fld	fa5,0(s1)	# B1, *_241
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:236:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	vfmul.vf	v8,v4,fa4	# result0, A0, *_238,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:237:             vfloat64m4_t result1 = __riscv_vfmul_vf_f64m4(A0, B1, gvl);
	vfmul.vf	v4,v4,fa5	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	ble	t4,s2,.L21	#, K, tmp808,
	sub	a1,t1,t5	# tmp935, _619, ivtmp.410
	addi	a1,a1,-16	#, tmp936, tmp935
	srli	a1,a1,4	#, tmp934, tmp936
	addi	a1,a1,1	#, tmp937, tmp934
	andi	a1,a1,7	#, tmp938, tmp937
	addi	a3,t3,64	#, ivtmp.412, ivtmp.422
	mv	a2,t5	# ivtmp.410, ivtmp.410
	beq	a1,zero,.L295	#, tmp938,,
	li	s8,1		# tmp944,
	beq	a1,s8,.L232	#, tmp938, tmp944,
	li	s8,2		# tmp943,
	beq	a1,s8,.L233	#, tmp938, tmp943,
	li	s8,3		# tmp942,
	beq	a1,s8,.L234	#, tmp938, tmp942,
	li	s8,4		# tmp941,
	beq	a1,s8,.L235	#, tmp938, tmp941,
	li	s8,5		# tmp940,
	beq	a1,s8,.L236	#, tmp938, tmp940,
	li	s8,6		# tmp939,
	beq	a1,s8,.L237	#, tmp938, tmp939,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(t5)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(t5)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,t5,16	#, ivtmp.410, ivtmp.410
	addi	a3,t3,128	#, ivtmp.412, ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L237:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,64	#, ivtmp.412, ivtmp.412
	addi	a2,a2,16	#, ivtmp.410, ivtmp.410
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L236:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,64	#, ivtmp.412, ivtmp.412
	addi	a2,a2,16	#, ivtmp.410, ivtmp.410
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L235:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,64	#, ivtmp.412, ivtmp.412
	addi	a2,a2,16	#, ivtmp.410, ivtmp.410
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L234:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,64	#, ivtmp.412, ivtmp.412
	addi	a2,a2,16	#, ivtmp.410, ivtmp.410
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L233:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,64	#, ivtmp.412, ivtmp.412
	addi	a2,a2,16	#, ivtmp.410, ivtmp.410
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L232:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,16	#, ivtmp.410, ivtmp.410
	addi	a3,a3,64	#, ivtmp.412, ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	beq	t1,a2,.L21	#, _619, ivtmp.410,
.L295:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	s8,a3,64	#, tmp946, ivtmp.412
	addi	a3,a3,128	#, ivtmp.412, ivtmp.412
	addi	a1,a2,16	#, tmp945, ivtmp.410
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(s8)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,16(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,24(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,32(a2)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,40(a2)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,s8,128	#, ivtmp.412, tmp946
	addi	a2,a1,112	#, ivtmp.410, tmp945
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,32(a1)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,40(a1)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,s8,192	#, ivtmp.412, tmp946
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,48(a1)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,56(a1)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,s8,256	#, ivtmp.412, tmp946
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,64(a1)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,72(a1)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,s8,320	#, ivtmp.412, tmp946
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,80(a1)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,88(a1)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,s8,384	#, ivtmp.412, tmp946
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:245:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,96(a1)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:242:                 B1 = B[bi + 1];
	fld	fa5,104(a1)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,s8,448	#, ivtmp.412, tmp946
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:248:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:249:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:240:             for (BLASLONG k = 1; k < K; k++) {
	bne	t1,a2,.L295	#, _619, ivtmp.410,
.L21:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:254:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v16,0(a0)	# c0,* ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:256:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a3,a0,s5	# _192, _260, ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:256:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v12,0(a3)	# c1,* _260
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t6,t6,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	t3,t3,s7	# _180, ivtmp.422, ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:257:             c0 = __riscv_vfmacc_vf_f64m4(c0, alpha, result0, gvl);
	vfmacc.vf	v16,fa1,v8	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:258:             c1 = __riscv_vfmacc_vf_f64m4(c1, alpha, result1, gvl);
	vfmacc.vf	v12,fa1,v4	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:262:             __riscv_vse64_v_f64m4(&C[ci], c0, gvl);
	vse64.v	v16,0(a0)	# c0,* ivtmp.423,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a0,a0,64	#, ivtmp.423, ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:264:             __riscv_vse64_v_f64m4(&C[ci], c1, gvl);
	vse64.v	v12,0(a3)	# c1,* _260,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:226:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	t6,a6,.L23	#, i, _887,
	slli	a6,a6,3	#, m_top, _887
.L20:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:268:         if (M & 4) {
	andi	a5,s4,4	#, _262, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:268:         if (M & 4) {
	beq	a5,zero,.L24	#, _262,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:271:             BLASLONG ai = m_top * K;
	mul	a3,t4,a6	# ai, K, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:269:             gvl = __riscv_vsetvl_e64m4(4);
	vsetivli	zero,4,e64,m4,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	li	t1,1		# tmp816,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:272:             BLASLONG bi = n_top * K;
	mul	a1,t4,s0	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:277:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	slli	a2,a3,3	#, _271, ai
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:277:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	add	a2,s3,a2	# _271, _272, A
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:277:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v4,0(a2)	# A0,* _272
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:278:             ai += 4;
	addi	a3,a3,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:273:             double B0 = B[bi + 0];
	slli	a2,a1,3	#, _265, bi
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:274:             double B1 = B[bi + 1];
	add	a2,a4,a2	# _265, tmp811, B
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:280:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	fld	fa4,0(a2)	# *_266, *_266
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:274:             double B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, *_269
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:275:             bi += 2;
	addi	a2,a1,2	#, bi, bi
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:280:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	vfmul.vf	v8,v4,fa4	# result0, A0, *_266,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:281:             vfloat64m4_t result1 = __riscv_vfmul_vf_f64m4(A0, B1, gvl);
	vfmul.vf	v4,v4,fa5	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	ble	t4,t1,.L25	#, K, tmp816,
	slli	a0,t4,1	#, _411, K
	add	a0,a0,a1	# bi, _413, _411
	slli	a2,a2,3	#, _1068, bi
	slli	a0,a0,3	#, _414, _413
	add	a2,a4,a2	# _1068, ivtmp.393, B
	add	a0,a4,a0	# _414, _416, B
	sub	a1,a0,a2	# tmp922, _416, ivtmp.393
	addi	a1,a1,-16	#, tmp923, tmp922
	srli	a1,a1,4	#, tmp921, tmp923
	add	a1,a1,t1	#, tmp924, tmp921
	slli	a3,a3,3	#, _407, ai
	andi	a1,a1,7	#, tmp925, tmp924
	add	a3,s3,a3	# _407, ivtmp.395, A
	beq	a1,zero,.L294	#, tmp925,,
	beq	a1,t1,.L238	#, tmp925, tmp816,
	li	t1,2		# tmp930,
	beq	a1,t1,.L239	#, tmp925, tmp930,
	li	t1,3		# tmp929,
	beq	a1,t1,.L240	#, tmp925, tmp929,
	li	t1,4		# tmp928,
	beq	a1,t1,.L241	#, tmp925, tmp928,
	li	t1,5		# tmp927,
	beq	a1,t1,.L242	#, tmp925, tmp927,
	li	t1,6		# tmp926,
	bne	a1,t1,.L316	#, tmp925, tmp926,
.L243:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
	addi	a2,a2,16	#, ivtmp.393, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L242:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
	addi	a2,a2,16	#, ivtmp.393, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L241:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
	addi	a2,a2,16	#, ivtmp.393, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L240:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
	addi	a2,a2,16	#, ivtmp.393, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L239:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
	addi	a2,a2,16	#, ivtmp.393, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
.L238:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,16	#, ivtmp.393, ivtmp.393
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	beq	a0,a2,.L25	#, _416, ivtmp.393,
.L294:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	t1,a3,32	#, tmp933, ivtmp.395
	addi	a3,a3,64	#, ivtmp.395, ivtmp.395
	addi	a1,a2,16	#, tmp932, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(t1)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,16(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,24(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,32(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,40(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,t1,64	#, ivtmp.395, tmp933
	addi	a2,a1,112	#, ivtmp.393, tmp932
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,32(a1)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,40(a1)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,t1,96	#, ivtmp.395, tmp933
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,48(a1)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,56(a1)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,t1,128	#, ivtmp.395, tmp933
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,64(a1)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,72(a1)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,t1,160	#, ivtmp.395, tmp933
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,80(a1)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,88(a1)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,t1,192	#, ivtmp.395, tmp933
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,96(a1)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,104(a1)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,t1,224	#, ivtmp.395, tmp933
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	bne	a0,a2,.L294	#, _416, ivtmp.393,
.L25:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:296:             BLASLONG ci = n_top * ldc + m_top;
	mul	a3,s6,s0	# _282, ldc, n_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:296:             BLASLONG ci = n_top * ldc + m_top;
	add	a3,a3,a6	# m_top, ci, _282
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:298:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	slli	a2,a3,3	#, _284, ci
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:298:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a2,t2,a2	# _284, _285, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:298:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v16,0(a2)	# c0,* _285
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:299:             ci += ldc - gvl * 0;
	add	a3,s6,a3	# ci, ci_575, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:300:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	slli	a3,a3,3	#, _287, ci_575
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:300:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a3,t2,a3	# _287, _288, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:300:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v12,0(a3)	# c1,* _288
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:309:             m_top += 4;
	addi	a6,a6,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:301:             c0 = __riscv_vfmacc_vf_f64m4(c0, alpha, result0, gvl);
	vfmacc.vf	v16,fa1,v8	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:302:             c1 = __riscv_vfmacc_vf_f64m4(c1, alpha, result1, gvl);
	vfmacc.vf	v12,fa1,v4	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:306:             __riscv_vse64_v_f64m4(&C[ci], c0, gvl);
	vse64.v	v16,0(a2)	# c0,* _285,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:308:             __riscv_vse64_v_f64m4(&C[ci], c1, gvl);
	vse64.v	v12,0(a3)	# c1,* _288,
	vsetivli	zero,8,e64,m4,ta,ma	#,,,,
.L24:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:312:         if (M & 2) {
	andi	a5,s4,2	#, _289, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:312:         if (M & 2) {
	beq	a5,zero,.L27	#, _289,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:317:             BLASLONG ai = m_top * K;
	mul	a2,a6,t4	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:316:             double result3 = 0;
	fmv.d.x	fa5,zero	# result3,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:318:             BLASLONG bi = n_top * K;
	mul	a3,t4,s0	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:321:             for (BLASLONG k = 0; k < K; k++) {
	ble	t4,zero,.L53	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:315:             double result2 = 0;
	fmv.d	fa4,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:314:             double result1 = 0;
	fmv.d	fa3,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:313:             double result0 = 0;
	fmv.d	fa2,fa5	# result0, result3
	slli	a2,a2,3	#, _1819, ai
	slli	a3,a3,3	#, _1811, bi
	add	a2,s3,a2	# _1819, vectp.271, A
	add	a3,a4,a3	# _1811, vectp.276, B
	mv	a1,t4	# bnd.269, K
.L29:
	vsetvli	a5,a1,e64,m1,ta,ma	# bnd.269, _1796,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:322:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v2,(a3)	# vect_array.277, vectp.276,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:322:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v4,(a2)	# vect_array.272, vectp.271,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:322:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v12,fa2	# tmp991, result0
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:323:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v11,fa3	# tmp993, result1
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:324:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v10,fa4	# tmp995, result2
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:325:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.s.f	v9,fa5	# tmp997, result3
	slli	a0,a5,4	#, ivtmp_1822, _1796
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:321:             for (BLASLONG k = 0; k < K; k++) {
	sub	a1,a1,a5	# bnd.269, bnd.269, _1796
	add	a2,a2,a0	# ivtmp_1822, vectp.271, vectp.271
	add	a3,a3,a0	# ivtmp_1822, vectp.276, vectp.276
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:324:                 result2 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v6,v4,v3	# vect__308.284, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:322:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v8,v4,v2	# vect__298.280, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:323:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v7,v5,v2	# vect__303.282, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:325:                 result3 += A[ai + 1] * B[bi + 1];
	vfmul.vv	v1,v5,v3	# vect__309.286, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:324:                 result2 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v2,v6,v10	# tmp996, vect__308.284, tmp995,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:322:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v8,v12	# tmp992, vect__298.280, tmp991,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:323:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v3,v7,v11	# tmp994, vect__303.282, tmp993,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:325:                 result3 += A[ai + 1] * B[bi + 1];
	vfredosum.vs	v1,v1,v9	# tmp998, vect__309.286, tmp997,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:324:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa4,v2	# result2, tmp996
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:322:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa2,v4	# result0, tmp992
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:323:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	fa3,v3	# result1, tmp994
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:325:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.f.s	fa5,v1	# result3, tmp998
	bne	a1,zero,.L29	#, bnd.269,,
.L28:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:330:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s6,s0	# _310, ldc, n_top
	vsetivli	zero,8,e64,m4,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:330:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a6	# m_top, ci, _310
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:331:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a3,a5,3	#, _312, ci
	add	a1,t2,a3	# _312, _313, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:331:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa0,0(a1)	# *_313, *_313
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:332:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	a3,a3,8	#, _318, _312
	add	a3,t2,a3	# _318, _319, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:331:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa2,fa1,fa2,fa0	# _316, alpha, result0, *_313
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:333:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	a5,s6,a5	# ci, _323, ldc
	slli	a5,a5,3	#, _325, _323
	add	a2,t2,a5	# _325, _326, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:334:             C[ci + 1 * ldc + 1] += alpha * result3;
	addi	a5,a5,8	#, _331, _325
	add	a5,t2,a5	# _331, _332, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:335:             m_top += 2;
	addi	a6,a6,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:331:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa2,0(a1)	# _316, *_313
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:332:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	fa2,0(a3)	# *_319, *_319
	fmadd.d	fa3,fa1,fa3,fa2	# _322, alpha, result1, *_319
	fsd	fa3,0(a3)	# _322, *_319
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:333:             C[ci + 1 * ldc + 0] += alpha * result2;
	fld	fa3,0(a2)	# *_326, *_326
	fmadd.d	fa4,fa1,fa4,fa3	# _329, alpha, result2, *_326
	fsd	fa4,0(a2)	# _329, *_326
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:334:             C[ci + 1 * ldc + 1] += alpha * result3;
	fld	fa4,0(a5)	# *_332, *_332
	fmadd.d	fa5,fa1,fa5,fa4	# _335, alpha, result3, *_332
	fsd	fa5,0(a5)	# _335, *_332
.L27:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:338:         if (M & 1) {
	andi	a5,s4,1	#, _336, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:338:         if (M & 1) {
	beq	a5,zero,.L30	#, _336,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:341:             BLASLONG ai = m_top * K;
	mul	a2,a6,t4	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:340:             double result1 = 0;
	fmv.d.x	fa5,zero	# result1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:342:             BLASLONG bi = n_top * K;
	mul	a3,t4,s0	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:345:             for (BLASLONG k = 0; k < K; k++) {
	ble	t4,zero,.L54	#, K,,
	slli	a3,a3,3	#, _1844, bi
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:339:             double result0 = 0;
	fmv.d	fa4,fa5	# result0, result1
	addi	a0,a3,8	#, _1834, _1844
	slli	a2,a2,3	#, _1851, ai
	add	a2,s3,a2	# _1851, vectp.256, A
	add	a0,a4,a0	# _1834, vectp.264, B
	add	a3,a4,a3	# _1844, vectp.259, B
	mv	a1,t4	# bnd.254, K
.L32:
	vsetvli	a5,a1,e64,m1,ta,ma	# bnd.254, _1826,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:346:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v3,0(a2)	# vect__340.257,* vectp.256
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:346:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v2,0(a3)	# vect__344.260,* vectp.259
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:347:                 result1 += A[ai + 0] * B[bi + 1];
	vle64.v	v1,0(a0)	# vect__349.265,* vectp.264
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:346:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v5,fa4	# tmp987, result0
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:347:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v4,fa5	# tmp989, result1
	slli	t1,a5,3	#, ivtmp_1854, _1826
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:345:             for (BLASLONG k = 0; k < K; k++) {
	sub	a1,a1,a5	# bnd.254, bnd.254, _1826
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:346:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v2,v2,v3	# vect__345.261, vect__344.260, vect__340.257,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:347:                 result1 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v1,v1,v3	# vect__350.266, vect__349.265, vect__340.257,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:345:             for (BLASLONG k = 0; k < K; k++) {
	add	a2,a2,t1	# ivtmp_1854, vectp.256, vectp.256
	add	a3,a3,t1	# ivtmp_1854, vectp.259, vectp.259
	add	a0,a0,t1	# ivtmp_1854, vectp.264, vectp.264
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:346:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v2,v2,v5	# tmp988, vect__345.261, tmp987,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:347:                 result1 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v1,v1,v4	# tmp990, vect__350.266, tmp989,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:346:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa4,v2	# result0, tmp988
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:347:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa5,v1	# result1, tmp990
	bne	a1,zero,.L32	#, bnd.254,,
.L31:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:352:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s6,s0	# _351, ldc, n_top
	vsetivli	zero,8,e64,m4,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:352:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a6	# m_top, ci, _351
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:353:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a3,a5,3	#, _353, ci
	add	a3,t2,a3	# _353, _354, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:353:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa3,0(a3)	# *_354, *_354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:354:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,s6,a5	# ci, _358, ldc
	slli	a5,a5,3	#, _360, _358
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:353:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa4,fa1,fa4,fa3	# _357, alpha, result0, *_354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:354:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,t2,a5	# _360, _361, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:353:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa4,0(a3)	# _357, *_354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:354:             C[ci + 1 * ldc + 0] += alpha * result1;
	fld	fa4,0(a5)	# *_361, *_361
	fmadd.d	fa5,fa1,fa5,fa4	# _364, alpha, result1, *_361
	fsd	fa5,0(a5)	# _364, *_361
.L30:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:363:     if (N & 1) {
	andi	a5,a7,1	#, _365, N
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:358:         n_top += 2;
	addi	s0,s0,2	#, n_top, n_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:363:     if (N & 1) {
	bne	a5,zero,.L317	#, _365,,
.L279:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:476: }
	ld	s0,168(sp)		#,
	.cfi_restore 8
	ld	s1,160(sp)		#,
	.cfi_restore 9
	ld	s2,152(sp)		#,
	.cfi_restore 18
	ld	s3,144(sp)		#,
	.cfi_restore 19
	ld	s4,136(sp)		#,
	.cfi_restore 20
	ld	s5,128(sp)		#,
	.cfi_restore 21
	ld	s6,120(sp)		#,
	.cfi_restore 22
	ld	s7,112(sp)		#,
	.cfi_restore 23
	ld	s8,104(sp)		#,
	.cfi_restore 24
	li	a0,0		#,
	addi	sp,sp,176	#,,
	.cfi_def_cfa_offset 0
	jr	ra		#
.L315:
	.cfi_def_cfa_offset 176
	.cfi_offset 8, -8
	.cfi_offset 9, -16
	.cfi_offset 18, -24
	.cfi_offset 19, -32
	.cfi_offset 20, -40
	.cfi_offset 21, -48
	.cfi_offset 22, -56
	.cfi_offset 23, -64
	.cfi_offset 24, -72
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:196:             BLASLONG ai = m_top * K;
	mul	a6,a4,t4	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:195:             double result3 = 0;
	fmv.d.x	fa5,zero	# result3,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:200:             for (BLASLONG k = 0; k < K; k++) {
	ble	t4,zero,.L51	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:194:             double result2 = 0;
	fmv.d	fa4,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:193:             double result1 = 0;
	fmv.d	fa3,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:192:             double result0 = 0;
	fmv.d	fa2,fa5	# result0, result3
	slli	a6,a6,3	#, _1789, ai
	add	a6,s3,a6	# _1789, vectp.291, A
	addi	a7,a1,-32	#, vectp.294, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:200:             for (BLASLONG k = 0; k < K; k++) {
	mv	a0,t4	# ivtmp_1766, K
.L17:
	vsetvli	a2,a0,e64,m1,ta,ma	# ivtmp_1766, _1765,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:201:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e64.v	v4,(a7)	# vect_array.295, vectp.294,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:201:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(a6)	# vect__182.292,* vectp.291
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:201:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v12,fa2	# tmp999, result0
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:202:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v11,fa3	# tmp1001, result1
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:203:                 result2 += A[ai + 0] * B[bi + 2];
	vfmv.s.f	v10,fa4	# tmp1003, result2
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:204:                 result3 += A[ai + 0] * B[bi + 3];
	vfmv.s.f	v9,fa5	# tmp1005, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:200:             for (BLASLONG k = 0; k < K; k++) {
	slli	s9,a2,3	#, ivtmp_1792, _1765
	add	a6,a6,s9	# ivtmp_1792, vectp.291, vectp.291
	sub	a0,a0,a2	# ivtmp_1766, ivtmp_1766, _1765
	slli	s9,a2,5	#, ivtmp_1785, _1765
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:201:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v8,v1,v4	# vect__187.300, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:202:                 result1 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v3,v1,v5	# vect__192.302, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:203:                 result2 += A[ai + 0] * B[bi + 2];
	vfmul.vv	v2,v1,v6	# vect__197.304, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:204:                 result3 += A[ai + 0] * B[bi + 3];
	vfmul.vv	v1,v1,v7	# vect__202.306, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:200:             for (BLASLONG k = 0; k < K; k++) {
	add	a7,a7,s9	# ivtmp_1785, vectp.294, vectp.294
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:201:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v8,v12	# tmp1000, vect__187.300, tmp999,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:202:                 result1 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v3,v3,v11	# tmp1002, vect__192.302, tmp1001,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:203:                 result2 += A[ai + 0] * B[bi + 2];
	vfredosum.vs	v2,v2,v10	# tmp1004, vect__197.304, tmp1003,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:204:                 result3 += A[ai + 0] * B[bi + 3];
	vfredosum.vs	v1,v1,v9	# tmp1006, vect__202.306, tmp1005,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:201:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa2,v4	# result0, tmp1000
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:202:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa3,v3	# result1, tmp1002
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:203:                 result2 += A[ai + 0] * B[bi + 2];
	vfmv.f.s	fa4,v2	# result2, tmp1004
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:204:                 result3 += A[ai + 0] * B[bi + 3];
	vfmv.f.s	fa5,v1	# result3, tmp1006
	bne	a0,zero,.L17	#, ivtmp_1766,,
.L16:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:209:             BLASLONG ci = n_top * ldc + m_top;
	add	a4,s5,a4	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:210:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a6,a4,3	#, _205, ci
	add	a6,t2,a6	# _205, _206, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:210:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa0,0(a6)	# *_206, *_206
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:211:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a0,s6,a4	# ci, _210, ldc
	slli	a0,a0,3	#, _212, _210
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:210:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa2,fa1,fa2,fa0	# _209, alpha, result0, *_206
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:211:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a0,t2,a0	# _212, _213, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:212:             C[ci + 2 * ldc + 0] += alpha * result2;
	ld	a2,48(sp)		# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:213:             C[ci + 3 * ldc + 0] += alpha * result3;
	ld	a7,56(sp)		# _164, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:212:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	a2,a2,a4	# ci, _218, _150
	slli	a2,a2,3	#, _220, _218
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:210:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa2,0(a6)	# _209, *_206
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:211:             C[ci + 1 * ldc + 0] += alpha * result1;
	fld	fa2,0(a0)	# *_213, *_213
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:212:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	a2,t2,a2	# _220, _221, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:213:             C[ci + 3 * ldc + 0] += alpha * result3;
	add	a4,a7,a4	# ci, _226, _164
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:211:             C[ci + 1 * ldc + 0] += alpha * result1;
	fmadd.d	fa3,fa1,fa3,fa2	# _216, alpha, result1, *_213
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:213:             C[ci + 3 * ldc + 0] += alpha * result3;
	slli	a4,a4,3	#, _228, _226
	add	a4,t2,a4	# _228, _229, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:211:             C[ci + 1 * ldc + 0] += alpha * result1;
	fsd	fa3,0(a0)	# _216, *_213
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:212:             C[ci + 2 * ldc + 0] += alpha * result2;
	fld	fa3,0(a2)	# *_221, *_221
	fmadd.d	fa4,fa1,fa4,fa3	# _224, alpha, result2, *_221
	fsd	fa4,0(a2)	# _224, *_221
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:213:             C[ci + 3 * ldc + 0] += alpha * result3;
	fld	fa4,0(a4)	# *_229, *_229
	fmadd.d	fa5,fa1,fa5,fa4	# _232, alpha, result3, *_229
	fsd	fa5,0(a4)	# _232, *_229
	j	.L15		#
.L313:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:94:             BLASLONG ai = m_top * K;
	mul	a0,t4,a4	# ai, K, m_top
	vsetivli	zero,4,e64,m4,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:105:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	fld	fa2,-32(a1)	# MEM[(FLOAT *)_1632 + -32B], MEM[(FLOAT *)_1632 + -32B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:97:             double B1 = B[bi + 1];
	fld	fa3,-24(a1)	# B1, MEM[(FLOAT *)_1632 + -24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:98:             double B2 = B[bi + 2];
	fld	fa4,-16(a1)	# B2, MEM[(FLOAT *)_1632 + -16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:99:             double B3 = B[bi + 3];
	fld	fa5,-8(a1)	# B3, MEM[(FLOAT *)_1632 + -8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:102:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	slli	a2,a0,3	#, _61, ai
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:102:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	add	a2,s3,a2	# _61, _62, A
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:102:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v4,0(a2)	# A0,* _62
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:103:             ai += 4;
	addi	a0,a0,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:105:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	vfmul.vf	v12,v4,fa2	# result0, A0, MEM[(FLOAT *)_1632 + -32B],
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:106:             vfloat64m4_t result1 = __riscv_vfmul_vf_f64m4(A0, B1, gvl);
	vfmul.vf	v16,v4,fa3	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:107:             vfloat64m4_t result2 = __riscv_vfmul_vf_f64m4(A0, B2, gvl);
	vfmul.vf	v20,v4,fa4	# result2, A0, B2,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:108:             vfloat64m4_t result3 = __riscv_vfmul_vf_f64m4(A0, B3, gvl);
	vfmul.vf	v4,v4,fa5	# result3, A0, B3,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	ble	t4,t6,.L10	#, K, tmp893,
	sub	a6,t3,a1	# tmp948, ivtmp.483, ivtmp.482
	addi	a6,a6,-32	#, tmp949, tmp948
	srli	a6,a6,5	#, tmp947, tmp949
	addi	a6,a6,1	#, tmp950, tmp947
	slli	a0,a0,3	#, _1072, ai
	andi	a6,a6,7	#, tmp951, tmp950
	add	a0,s3,a0	# _1072, ivtmp.441, A
	mv	a2,a1	# ivtmp.439, ivtmp.482
	beq	a6,zero,.L11	#, tmp951,,
	li	a7,1		# tmp957,
	beq	a6,a7,.L226	#, tmp951, tmp957,
	li	a7,2		# tmp956,
	beq	a6,a7,.L227	#, tmp951, tmp956,
	li	a7,3		# tmp955,
	beq	a6,a7,.L228	#, tmp951, tmp955,
	li	a7,4		# tmp954,
	beq	a6,a7,.L229	#, tmp951, tmp954,
	li	a7,5		# tmp953,
	beq	a6,a7,.L230	#, tmp951, tmp953,
	li	a7,6		# tmp952,
	beq	a6,a7,.L231	#, tmp951, tmp952,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a1)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a1)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a1)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a1)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,32	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a1,32	#, ivtmp.439, ivtmp.482
.L231:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,32	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,32	#, ivtmp.439, ivtmp.439
.L230:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,32	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,32	#, ivtmp.439, ivtmp.439
.L229:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,32	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,32	#, ivtmp.439, ivtmp.439
.L228:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,32	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,32	#, ivtmp.439, ivtmp.439
.L227:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,32	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,32	#, ivtmp.439, ivtmp.439
.L226:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,32	#, ivtmp.439, ivtmp.439
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,32	#, ivtmp.441, ivtmp.441
	beq	a2,t3,.L10	#, ivtmp.439, ivtmp.483,
.L11:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,0(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,8(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,16(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,24(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a7,a0,32	#, tmp959, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a7)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,32(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,40(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,48(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,56(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a0,64	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,64(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,72(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,80(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,88(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a7,64	#, ivtmp.441, tmp959
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,96(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,104(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,112(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,120(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a7,96	#, ivtmp.441, tmp959
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,128(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,136(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,144(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,152(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a7,128	#, ivtmp.441, tmp959
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,168(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,176(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,160(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,184(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a7,160	#, ivtmp.441, tmp959
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,200(a2)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,208(a2)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,216(a2)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,192(a2)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a7,192	#, ivtmp.441, tmp959
	addi	a6,a2,32	#, tmp958, ivtmp.439
	addi	a2,a6,224	#, ivtmp.439, tmp958
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:118:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a0)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa2,192(a6)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:113:                 B1 = B[bi + 1];
	fld	fa3,200(a6)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:114:                 B2 = B[bi + 2];
	fld	fa4,208(a6)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:115:                 B3 = B[bi + 3];
	fld	fa5,216(a6)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a7,224	#, ivtmp.441, tmp959
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:121:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v12,fa2,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:122:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v16,fa3,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:123:                 result2 = __riscv_vfmacc_vf_f64m4(result2, B2, A0, gvl);
	vfmacc.vf	v20,fa4,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:124:                 result3 = __riscv_vfmacc_vf_f64m4(result3, B3, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:111:             for (BLASLONG k = 1; k < K; k++) {
	bne	a2,t3,.L11	#, ivtmp.439, ivtmp.483,
.L10:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:127:             BLASLONG ci = n_top * ldc + m_top;
	add	a2,s5,a4	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:129:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	slli	a7,a2,3	#, _80, ci
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:129:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a7,t2,a7	# _80, _81, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:129:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v28,0(a7)	# c0,* _81
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:130:             ci += ldc - gvl * 0;
	add	a2,s6,a2	# ci, ci, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:131:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	slli	a6,a2,3	#, _83, ci
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:131:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a6,t2,a6	# _83, _84, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:131:             vfloat64m4_t c1 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v24,0(a6)	# c1,* _84
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:132:             ci += ldc - gvl * 0;
	add	a2,s6,a2	# ci, ci, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:136:             c0 = __riscv_vfmacc_vf_f64m4(c0, alpha, result0, gvl);
	vfmacc.vf	v28,fa1,v12	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:134:             ci += ldc - gvl * 0;
	add	a0,s6,a2	# ci, ci_739, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:135:             vfloat64m4_t c3 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	slli	a0,a0,3	#, _89, ci_739
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:133:             vfloat64m4_t c2 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	slli	a2,a2,3	#, _86, ci
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:133:             vfloat64m4_t c2 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a2,t2,a2	# _86, _87, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:135:             vfloat64m4_t c3 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a0,t2,a0	# _89, _90, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:133:             vfloat64m4_t c2 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v12,0(a2)	# c2,* _87
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:135:             vfloat64m4_t c3 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v8,0(a0)	# c3,* _90
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:137:             c1 = __riscv_vfmacc_vf_f64m4(c1, alpha, result1, gvl);
	vfmacc.vf	v24,fa1,v16	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:143:             __riscv_vse64_v_f64m4(&C[ci], c0, gvl);
	vse64.v	v28,0(a7)	# c0,* _81,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:150:             m_top += 4;
	addi	a4,a4,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:138:             c2 = __riscv_vfmacc_vf_f64m4(c2, alpha, result2, gvl);
	vfmacc.vf	v12,fa1,v20	# c2, alpha, result2,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:139:             c3 = __riscv_vfmacc_vf_f64m4(c3, alpha, result3, gvl);
	vfmacc.vf	v8,fa1,v4	# c3, alpha, result3,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:145:             __riscv_vse64_v_f64m4(&C[ci], c1, gvl);
	vse64.v	v24,0(a6)	# c1,* _84,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:147:             __riscv_vse64_v_f64m4(&C[ci], c2, gvl);
	vse64.v	v12,0(a2)	# c2,* _87,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:149:             __riscv_vse64_v_f64m4(&C[ci], c3, gvl);
	vse64.v	v8,0(a0)	# c3,* _90,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:153:         if (M & 2) {
	ld	a2,16(sp)		# _91, %sfp
	beq	a2,zero,.L12	#, _91,,
.L314:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:162:             BLASLONG ai = m_top * K;
	mul	a6,a4,t4	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:161:             double result7 = 0;
	fmv.d.x	fa5,zero	# result7,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:166:             for (BLASLONG k = 0; k < K; k++) {
	ble	t4,zero,.L50	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:160:             double result6 = 0;
	fmv.d	fa4,fa5	# result6, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:159:             double result5 = 0;
	fmv.d	fa3,fa5	# result5, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:158:             double result4 = 0;
	fmv.d	fa2,fa5	# result4, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:157:             double result3 = 0;
	fmv.d	fa0,fa5	# result3, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:156:             double result2 = 0;
	fmv.d	ft0,fa5	# result2, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:155:             double result1 = 0;
	fmv.d	ft1,fa5	# result1, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:154:             double result0 = 0;
	fmv.d	ft2,fa5	# result0, result7
	slli	a6,a6,3	#, _1758, ai
	add	a6,s3,a6	# _1758, vectp.311, A
	addi	a7,a1,-32	#, vectp.316, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:166:             for (BLASLONG k = 0; k < K; k++) {
	mv	a0,t4	# ivtmp_1726, K
.L14:
	vsetvli	a2,a0,e64,m1,ta,ma	# ivtmp_1726, _1725,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v2,(a6)	# vect_array.312, vectp.311,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e64.v	v4,(a7)	# vect_array.317, vectp.316,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v22,ft2	# tmp1007, result0
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:168:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v21,ft1	# tmp1009, result1
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:169:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v20,ft0	# tmp1011, result2
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:170:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.s.f	v19,fa0	# tmp1013, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:171:                 result4 += A[ai + 0] * B[bi + 2];
	vfmv.s.f	v18,fa2	# tmp1015, result4
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:172:                 result5 += A[ai + 1] * B[bi + 2];
	vfmv.s.f	v17,fa3	# tmp1017, result5
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:173:                 result6 += A[ai + 0] * B[bi + 3];
	vfmv.s.f	v16,fa4	# tmp1019, result6
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:174:                 result7 += A[ai + 1] * B[bi + 3];
	vfmv.s.f	v15,fa5	# tmp1021, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:166:             for (BLASLONG k = 0; k < K; k++) {
	slli	s9,a2,4	#, ivtmp_1761, _1725
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v14,v2,v4	# vect__100.322, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:168:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v13,v3,v4	# vect__105.324, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:169:                 result2 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v12,v2,v5	# vect__110.326, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:170:                 result3 += A[ai + 1] * B[bi + 1];
	vfmul.vv	v11,v3,v5	# vect__111.328, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:171:                 result4 += A[ai + 0] * B[bi + 2];
	vfmul.vv	v10,v2,v6	# vect__116.330, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:172:                 result5 += A[ai + 1] * B[bi + 2];
	vfmul.vv	v9,v3,v6	# vect__117.332, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v14,v22	# tmp1008, vect__100.322, tmp1007,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:173:                 result6 += A[ai + 0] * B[bi + 3];
	vfmul.vv	v8,v2,v7	# vect__122.334, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:174:                 result7 += A[ai + 1] * B[bi + 3];
	vfmul.vv	v1,v3,v7	# vect__123.336, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:169:                 result2 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v2,v12,v20	# tmp1012, vect__110.326, tmp1011,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:166:             for (BLASLONG k = 0; k < K; k++) {
	add	a6,a6,s9	# ivtmp_1761, vectp.311, vectp.311
	sub	a0,a0,a2	# ivtmp_1726, ivtmp_1726, _1725
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:168:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v3,v13,v21	# tmp1010, vect__105.324, tmp1009,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:166:             for (BLASLONG k = 0; k < K; k++) {
	slli	s9,a2,5	#, ivtmp_1753, _1725
	add	a7,a7,s9	# ivtmp_1753, vectp.316, vectp.316
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:170:                 result3 += A[ai + 1] * B[bi + 1];
	vfredosum.vs	v5,v11,v19	# tmp1014, vect__111.328, tmp1013,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	ft2,v4	# result0, tmp1008
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:174:                 result7 += A[ai + 1] * B[bi + 3];
	vfredosum.vs	v1,v1,v15	# tmp1022, vect__123.336, tmp1021,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:169:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	ft0,v2	# result2, tmp1012
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:171:                 result4 += A[ai + 0] * B[bi + 2];
	vfredosum.vs	v4,v10,v18	# tmp1016, vect__116.330, tmp1015,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:168:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	ft1,v3	# result1, tmp1010
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:173:                 result6 += A[ai + 0] * B[bi + 3];
	vfredosum.vs	v2,v8,v16	# tmp1020, vect__122.334, tmp1019,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:170:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.f.s	fa0,v5	# result3, tmp1014
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:172:                 result5 += A[ai + 1] * B[bi + 2];
	vfredosum.vs	v3,v9,v17	# tmp1018, vect__117.332, tmp1017,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:174:                 result7 += A[ai + 1] * B[bi + 3];
	vfmv.f.s	fa5,v1	# result7, tmp1022
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:171:                 result4 += A[ai + 0] * B[bi + 2];
	vfmv.f.s	fa2,v4	# result4, tmp1016
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:173:                 result6 += A[ai + 0] * B[bi + 3];
	vfmv.f.s	fa4,v2	# result6, tmp1020
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:172:                 result5 += A[ai + 1] * B[bi + 2];
	vfmv.f.s	fa3,v3	# result5, tmp1018
	bne	a0,zero,.L14	#, ivtmp_1726,,
.L13:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:179:             BLASLONG ci = n_top * ldc + m_top;
	add	a2,s5,a4	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a6,a2,3	#, _126, ci
	add	a0,t2,a6	# _126, _127, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	ft3,0(a0)	# *_127, *_127
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	a6,a6,8	#, _132, _126
	add	a7,t2,a6	# _132, _133, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	ft2,fa1,ft2,ft3	# _130, alpha, result0, *_127
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	a6,s6,a2	# ci, _137, ldc
	slli	a6,a6,3	#, _139, _137
	add	s10,t2,a6	# _139, _140, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	addi	a6,a6,8	#, _145, _139
	add	a6,t2,a6	# _145, _146, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	ld	s9,56(sp)		# _164, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	ft2,0(a0)	# _130, *_127
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	ft2,0(a7)	# *_133, *_133
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	ld	a0,48(sp)		# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:188:             m_top += 2;
	addi	a4,a4,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	fmadd.d	ft1,fa1,ft1,ft2	# _136, alpha, result1, *_133
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	a0,a0,a2	# ci, _151, _150
	slli	a0,a0,3	#, _153, _151
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	a2,s9,a2	# ci, _165, _164
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	s9,t2,a0	# _153, _154, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	addi	a0,a0,8	#, _159, _153
	add	a0,t2,a0	# _159, _160, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	fsd	ft1,0(a7)	# _136, *_133
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	fld	ft1,0(s10)	# *_140, *_140
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	slli	a2,a2,3	#, _167, _165
	add	a7,t2,a2	# _167, _168, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	fmadd.d	ft0,fa1,ft0,ft1	# _143, alpha, result2, *_140
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:187:             C[ci + 3 * ldc + 1] += alpha * result7;
	add	a2,t2,a2	# _173, _174, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	fsd	ft0,0(s10)	# _143, *_140
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	fld	ft0,0(a6)	# *_146, *_146
	fmadd.d	fa0,fa1,fa0,ft0	# _149, alpha, result3, *_146
	fsd	fa0,0(a6)	# _149, *_146
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	fld	fa0,0(s9)	# *_154, *_154
	fmadd.d	fa2,fa1,fa2,fa0	# _157, alpha, result4, *_154
	fsd	fa2,0(s9)	# _157, *_154
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	fld	fa2,0(a0)	# *_160, *_160
	fmadd.d	fa3,fa1,fa3,fa2	# _163, alpha, result5, *_160
	fsd	fa3,0(a0)	# _163, *_160
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	fld	fa3,0(a7)	# *_168, *_168
	fmadd.d	fa4,fa1,fa4,fa3	# _171, alpha, result6, *_168
	fsd	fa4,0(a7)	# _171, *_168
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:187:             C[ci + 3 * ldc + 1] += alpha * result7;
	fld	fa4,8(a2)	# *_174, *_174
	fmadd.d	fa5,fa1,fa5,fa4	# _177, alpha, result7, *_174
	fsd	fa5,8(a2)	# _177, *_174
	j	.L12		#
.L49:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:26:         m_top = 0;
	li	a4,0		# m_top,
	j	.L5		#
.L311:
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 27
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:363:     if (N & 1) {
	andi	a5,a7,1	#, _365, N
	vsetivli	zero,8,e64,m4,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:363:     if (N & 1) {
	beq	a5,zero,.L279	#, _365,,
.L317:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a2,s4,63	#, tmp850, M
	andi	a2,a2,7	#, tmp851, tmp850
	add	a2,a2,s4	# M, tmp852, tmp851
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a5,7		# tmp854,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t6,a2,3	#, _892, tmp852
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	s4,a5,.L55	#, M, tmp854,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:369:             BLASLONG bi = n_top * K;
	mul	t3,s0,t4	# bi_695, n_top, K
	slli	t0,t4,6	#, _103, K
	add	a7,t0,s3	# A, ivtmp.381, _103
	mv	t1,s3	# ivtmp.376, A
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t5,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	li	s1,1		# tmp859,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:389:             BLASLONG ci = n_top * ldc + m_top;
	mul	a6,s6,s0	# _521, ldc, n_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:370:             double B0 = B[bi + 0];
	slli	t3,t3,3	#, _368, bi_695
	add	t3,a4,t3	# _368, _369, B
	slli	a6,a6,3	#, _108, _521
	add	a6,t2,a6	# _108, ivtmp.377, C
.L38:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:373:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v4,0(t1)	# A0,* ivtmp.376
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:376:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	fld	fa5,0(t3)	# *_369, *_369
	vfmul.vf	v4,v4,fa5	# result0, A0, *_369,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	ble	t4,s1,.L36	#, K, tmp859,
	addi	a5,t1,64	#, ivtmp.369, ivtmp.376
	sub	a1,a7,a5	# tmp909, ivtmp.381, ivtmp.369
	addi	a1,a1,-64	#, tmp910, tmp909
	srli	a1,a1,6	#, tmp908, tmp910
	addi	a1,a1,1	#, tmp911, tmp908
	andi	a1,a1,7	#, tmp912, tmp911
	mv	a2,t3	# ivtmp.368, _369
	beq	a1,zero,.L293	#, tmp912,,
	li	a0,1		# tmp918,
	beq	a1,a0,.L244	#, tmp912, tmp918,
	li	a0,2		# tmp917,
	beq	a1,a0,.L245	#, tmp912, tmp917,
	li	a0,3		# tmp916,
	beq	a1,a0,.L246	#, tmp912, tmp916,
	li	a0,4		# tmp915,
	beq	a1,a0,.L247	#, tmp912, tmp915,
	li	a0,5		# tmp914,
	beq	a1,a0,.L248	#, tmp912, tmp914,
	li	a0,6		# tmp913,
	beq	a1,a0,.L249	#, tmp912, tmp913,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t3)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,t3,8	#, ivtmp.368, _369
	addi	a5,t1,128	#, ivtmp.369, ivtmp.376
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
.L249:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.369, ivtmp.369
	addi	a2,a2,8	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
.L248:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.369, ivtmp.369
	addi	a2,a2,8	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
.L247:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.369, ivtmp.369
	addi	a2,a2,8	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
.L246:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.369, ivtmp.369
	addi	a2,a2,8	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
.L245:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.369, ivtmp.369
	addi	a2,a2,8	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
.L244:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.369, ivtmp.369
	addi	a2,a2,8	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	beq	a7,a5,.L36	#, ivtmp.381, ivtmp.369,
.L293:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a1,a5,64	#, tmp920, ivtmp.369
	addi	a5,a5,128	#, ivtmp.369, ivtmp.369
	mv	a0,a2	# tmp919, ivtmp.368
	addi	a2,a2,64	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a1)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,-48(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,-40(a2)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,128	#, ivtmp.369, tmp920
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,32(a0)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,192	#, ivtmp.369, tmp920
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,40(a0)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,256	#, ivtmp.369, tmp920
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,48(a0)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,320	#, ivtmp.369, tmp920
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,56(a0)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,384	#, ivtmp.369, tmp920
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:383:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,64(a0)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,448	#, ivtmp.369, tmp920
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:386:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:379:             for (BLASLONG k = 1; k < K; k++) {
	bne	a7,a5,.L293	#, ivtmp.381, ivtmp.369,
.L36:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:391:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v8,0(a6)	# c0,* ivtmp.377
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t5,t5,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	t1,t1,t0	# _103, ivtmp.376, ivtmp.376
	add	a7,a7,t0	# _103, ivtmp.381, ivtmp.381
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:392:             c0 = __riscv_vfmacc_vf_f64m4(c0, alpha, result0, gvl);
	vfmacc.vf	v8,fa1,v4	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:396:             __riscv_vse64_v_f64m4(&C[ci], c0, gvl);
	vse64.v	v8,0(a6)	# c0,* ivtmp.377,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:367:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a6,a6,64	#, ivtmp.377, ivtmp.377
	blt	t5,t6,.L38	#, i, _892,
	slli	a2,t6,3	#, m_top, _892
.L35:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:400:         if (M & 4) {
	andi	a5,s4,4	#, _384, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:400:         if (M & 4) {
	beq	a5,zero,.L39	#, _384,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:403:             BLASLONG ai = m_top * K;
	mul	a5,t4,a2	# ai, K, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:401:             gvl = __riscv_vsetvl_e64m4(4);
	vsetivli	zero,4,e64,m4,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	li	a7,1		# tmp866,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:404:             BLASLONG bi = n_top * K;
	mul	a1,s0,t4	# bi.185_386, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:408:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	slli	a0,a5,3	#, _390, ai
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:408:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	add	a0,s3,a0	# _390, _391, A
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:408:             vfloat64m4_t A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v4,0(a0)	# A0,* _391
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:409:             ai += 4;
	addi	a5,a5,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:405:             double B0 = B[bi + 0];
	slli	a6,a1,3	#, _387, bi.185_386
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:405:             double B0 = B[bi + 0];
	add	a6,a4,a6	# _387, tmp864, B
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:411:             vfloat64m4_t result0 = __riscv_vfmul_vf_f64m4(A0, B0, gvl);
	fld	fa5,0(a6)	# *_388, *_388
	vfmul.vf	v4,v4,fa5	# result0, A0, *_388,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	ble	t4,a7,.L40	#, K, tmp866,
	add	a0,t4,a1	# bi.185_386, _302, K
	slli	a0,a0,3	#, _301, _302
	addi	a1,a4,-8	#, _1921, B
	add	a0,a0,a1	# _1921, _298, _301
	sub	a1,a0,a6	# tmp896, _298, ivtmp.354
	addi	a1,a1,-8	#, tmp897, tmp896
	srli	a1,a1,3	#, tmp895, tmp897
	add	a1,a1,a7	#, tmp898, tmp895
	slli	a5,a5,3	#, _307, ai
	andi	a1,a1,7	#, tmp899, tmp898
	mv	t1,a6	# ivtmp.354, tmp864
	add	a5,s3,a5	# _307, ivtmp.355, A
	beq	a1,zero,.L292	#, tmp899,,
	beq	a1,a7,.L250	#, tmp899, tmp866,
	li	a6,2		# tmp904,
	beq	a1,a6,.L251	#, tmp899, tmp904,
	li	a6,3		# tmp903,
	beq	a1,a6,.L252	#, tmp899, tmp903,
	li	a6,4		# tmp902,
	beq	a1,a6,.L253	#, tmp899, tmp902,
	li	a6,5		# tmp901,
	beq	a1,a6,.L254	#, tmp899, tmp901,
	li	a6,6		# tmp900,
	bne	a1,a6,.L318	#, tmp899, tmp900,
.L255:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
	addi	t1,t1,8	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
.L254:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
	addi	t1,t1,8	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
.L253:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
	addi	t1,t1,8	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
.L252:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
	addi	t1,t1,8	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
.L251:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
	addi	t1,t1,8	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
.L250:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	t1,t1,8	#, ivtmp.354, ivtmp.354
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	beq	t1,a0,.L40	#, ivtmp.354, _298,
.L292:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a1,a5,32	#, tmp907, ivtmp.355
	addi	a5,a5,64	#, ivtmp.355, ivtmp.355
	mv	a6,t1	# tmp906, ivtmp.354
	addi	t1,t1,64	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a1)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,-48(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,-40(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,64	#, ivtmp.355, tmp907
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,32(a6)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,96	#, ivtmp.355, tmp907
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,40(a6)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,128	#, ivtmp.355, tmp907
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,48(a6)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,160	#, ivtmp.355, tmp907
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,56(a6)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,192	#, ivtmp.355, tmp907
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,64(a6)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a1,224	#, ivtmp.355, tmp907
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	bne	t1,a0,.L292	#, ivtmp.354, _298,
.L40:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:424:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s0,s6	# _398, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:424:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a2	# m_top, ci_662, _398
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:426:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	slli	a5,a5,3	#, _400, ci_662
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:426:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	add	a5,t2,a5	# _400, _401, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:426:             vfloat64m4_t c0 = __riscv_vle64_v_f64m4(&C[ci], gvl);
	vle64.v	v8,0(a5)	# c0,* _401
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:432:             m_top += 4;
	addi	a2,a2,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:427:             c0 = __riscv_vfmacc_vf_f64m4(c0, alpha, result0, gvl);
	vfmacc.vf	v8,fa1,v4	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:431:             __riscv_vse64_v_f64m4(&C[ci], c0, gvl);
	vse64.v	v8,0(a5)	# c0,* _401,
.L39:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:435:         if (M & 2) {
	andi	a5,s4,2	#, _402, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:435:         if (M & 2) {
	beq	a5,zero,.L42	#, _402,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:438:             BLASLONG ai = m_top * K;
	mul	a1,a2,t4	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:437:             double result1 = 0;
	fmv.d.x	fa5,zero	# result1,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:439:             BLASLONG bi = n_top * K;
	mul	a3,s0,t4	# bi, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:442:             for (BLASLONG k = 0; k < K; k++) {
	ble	t4,zero,.L56	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:436:             double result0 = 0;
	fmv.d	fa4,fa5	# result0, result1
	slli	a1,a1,3	#, _1876, ai
	slli	a3,a3,3	#, _1868, bi
	add	a1,s3,a1	# _1876, vectp.242, A
	add	a3,a4,a3	# _1868, vectp.247, B
	mv	a0,t4	# bnd.240, K
.L44:
	vsetvli	a5,a0,e64,m1,ta,ma	# bnd.240, _1858,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:443:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v4,(a1)	# vect_array.243, vectp.242,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:443:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(a3)	# vect__410.248,* vectp.247
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:443:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v6,fa4	# tmp983, result0
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:444:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v3,fa5	# tmp985, result1
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:442:             for (BLASLONG k = 0; k < K; k++) {
	slli	a7,a5,4	#, ivtmp_1879, _1858
	slli	a6,a5,3	#, ivtmp_1871, _1858
	sub	a0,a0,a5	# bnd.240, bnd.240, _1858
	add	a1,a1,a7	# ivtmp_1879, vectp.242, vectp.242
	add	a3,a3,a6	# ivtmp_1871, vectp.247, vectp.247
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:443:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v2,v1,v4	# vect__411.249, vect__410.248, vect_array.243,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:444:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v1,v1,v5	# vect__416.251, vect__410.248, vect_array.243,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:443:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v2,v2,v6	# tmp984, vect__411.249, tmp983,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:444:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v1,v1,v3	# tmp986, vect__416.251, tmp985,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:443:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa4,v2	# result0, tmp984
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:444:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	fa5,v1	# result1, tmp986
	bne	a0,zero,.L44	#, bnd.240,,
.L43:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:449:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s0,s6	# _417, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:449:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a2	# m_top, ci_677, _417
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:450:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a5,a5,3	#, _419, ci_677
	add	a3,t2,a5	# _419, _420, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:450:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa3,0(a3)	# *_420, *_420
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:451:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	a5,a5,8	#, _425, _419
	add	a5,t2,a5	# _425, _426, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:450:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa4,fa1,fa4,fa3	# _423, alpha, result0, *_420
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:452:             m_top += 2;
	addi	a2,a2,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:450:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa4,0(a3)	# _423, *_420
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:451:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	fa4,0(a5)	# *_426, *_426
	fmadd.d	fa5,fa1,fa5,fa4	# _429, alpha, result1, *_426
	fsd	fa5,0(a5)	# _429, *_426
.L42:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:455:         if (M & 1) {
	andi	s4,s4,1	#, _430, M
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:455:         if (M & 1) {
	beq	s4,zero,.L279	#, _430,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:457:             BLASLONG ai = m_top * K;
	mul	a3,a2,t4	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:456:             double result0 = 0;
	fmv.d.x	fa5,zero	# result0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:458:             BLASLONG bi = n_top * K;
	mul	a5,s0,t4	# bi, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:461:             for (BLASLONG k = 0; k < K; k++) {
	ble	t4,zero,.L46	#, K,,
	slli	a3,a3,3	#, _1898, ai
	slli	a5,a5,3	#, _1891, bi
	add	a3,s3,a3	# _1898, vectp.232, A
	add	a4,a4,a5	# _1891, vectp.235, B
.L47:
	vsetvli	a5,t4,e64,m1,ta,ma	# bnd.230, _1883,,,,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:462:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v3,0(a3)	# vect__434.233,* vectp.232
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:462:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(a4)	# vect__438.236,* vectp.235
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:462:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v2,fa5	# tmp981, result0
	slli	a1,a5,3	#, ivtmp_1903, _1883
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:461:             for (BLASLONG k = 0; k < K; k++) {
	sub	t4,t4,a5	# bnd.230, bnd.230, _1883
	add	a3,a3,a1	# ivtmp_1903, vectp.232, vectp.232
	add	a4,a4,a1	# ivtmp_1903, vectp.235, vectp.235
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:462:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v1,v1,v3	# vect__439.237, vect__438.236, vect__434.233,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:462:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v1,v1,v2	# tmp982, vect__439.237, tmp981,
	vfmv.f.s	fa5,v1	# result0, tmp982
	bne	t4,zero,.L47	#, bnd.230,,
.L46:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:467:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s0,s6	# _440, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:467:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a2	# m_top, ci_688, _440
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:468:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a5,a5,3	#, _442, ci_688
	add	a5,t2,a5	# _442, _443, C
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:468:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa4,0(a5)	# *_443, *_443
	fmadd.d	fa5,fa1,fa5,fa4	# _446, alpha, result0, *_443
	fsd	fa5,0(a5)	# _446, *_443
	j	.L279		#
.L312:
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
	slli	s8,t5,3	#, _1906, _947
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:191:         if (M & 1) {
	li	s5,0		# ivtmp.478,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	s1,0		# j,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	s11,7		# tmp744,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:47:             for (BLASLONG k = 1; k < K; k++) {
	li	t6,1		# tmp893,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:92:             gvl = __riscv_vsetvl_e64m4(4);
	sd	a7,64(sp)	# N, %sfp
	sd	a4,72(sp)	# B, %sfp
	j	.L18		#
.L51:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:194:             double result2 = 0;
	fmv.d	fa4,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:193:             double result1 = 0;
	fmv.d	fa3,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:192:             double result0 = 0;
	fmv.d	fa2,fa5	# result0, result3
	j	.L16		#
.L50:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:160:             double result6 = 0;
	fmv.d	fa4,fa5	# result6, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:159:             double result5 = 0;
	fmv.d	fa3,fa5	# result5, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:158:             double result4 = 0;
	fmv.d	fa2,fa5	# result4, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:157:             double result3 = 0;
	fmv.d	fa0,fa5	# result3, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:156:             double result2 = 0;
	fmv.d	ft0,fa5	# result2, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:155:             double result1 = 0;
	fmv.d	ft1,fa5	# result1, result7
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:154:             double result0 = 0;
	fmv.d	ft2,fa5	# result0, result7
	j	.L13		#
.L52:
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 27
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:224:         m_top = 0;
	li	a6,0		# m_top,
	j	.L20		#
.L55:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:365:         m_top = 0;
	li	a2,0		# m_top,
	j	.L35		#
.L48:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:21:     BLASLONG n_top = 0;
	li	s0,0		# n_top,
	j	.L2		#
.L318:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:418:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa5,8(t1)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:414:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
	addi	t1,t1,8	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:421:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v4,fa5,v8	# result0, MEM[(FLOAT *)_305 + 8B], A0,
	j	.L255		#
.L53:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:315:             double result2 = 0;
	fmv.d	fa4,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:314:             double result1 = 0;
	fmv.d	fa3,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:313:             double result0 = 0;
	fmv.d	fa2,fa5	# result0, result3
	j	.L28		#
.L54:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:339:             double result0 = 0;
	fmv.d	fa4,fa5	# result0, result1
	j	.L31		#
.L56:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:436:             double result0 = 0;
	fmv.d	fa4,fa5	# result0, result1
	j	.L43		#
.L316:
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:289:                 A0 = __riscv_vle64_v_f64m4(&A[ai + 0 * gvl], gvl);
	vle64.v	v12,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	fld	fa4,0(a2)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:286:                 B1 = B[bi + 1];
	fld	fa5,8(a2)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:284:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
	addi	a2,a2,16	#, ivtmp.393, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:292:                 result0 = __riscv_vfmacc_vf_f64m4(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa4,v12	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul4_unroll8.c:293:                 result1 = __riscv_vfmacc_vf_f64m4(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa5,v12	# result1, B1, A0,
	j	.L243		#
	.cfi_endproc
.LFE0:
	.size	dgemm_kernel_8x4_zvl128b_lmul4_unroll8, .-dgemm_kernel_8x4_zvl128b_lmul4_unroll8
	.ident	"GCC: (Bianbu 14.2.0-4ubuntu2~24.04bb1) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
