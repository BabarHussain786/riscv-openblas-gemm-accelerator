	.file	"dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c"
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
	.globl	dgemm_kernel_8x4_zvl128b_lmul1_unroll1
	.type	dgemm_kernel_8x4_zvl128b_lmul1_unroll1, @function
dgemm_kernel_8x4_zvl128b_lmul1_unroll1:
.LFB0:
	.cfi_startproc
	addi	sp,sp,-160	#,,
	.cfi_def_cfa_offset 160
	mv	t3,a1	# N, tmp896
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	srai	a1,a1,63	#, tmp725, N
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:18: {
	sd	s1,144(sp)	#,
	sd	s3,128(sp)	#,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	andi	a1,a1,3	#, tmp726, tmp725
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:18: {
	sd	s0,152(sp)	#,
	sd	s2,136(sp)	#,
	sd	s4,120(sp)	#,
	sd	s5,112(sp)	#,
	sd	s6,104(sp)	#,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	a7,3		# tmp729,
	.cfi_offset 9, -16
	.cfi_offset 19, -32
	.cfi_offset 8, -8
	.cfi_offset 18, -24
	.cfi_offset 20, -40
	.cfi_offset 21, -48
	.cfi_offset 22, -56
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:18: {
	mv	s1,a0	# M, tmp895
	fmv.d	fa4,fa0	# alpha, tmp898
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a1,a1,t3	# N, tmp727, tmp726
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:18: {
	mv	a0,a2	# K, tmp897
	mv	t5,a3	# A, tmp899
	mv	t0,a4	# B, tmp900
	mv	t4,a5	# C, tmp901
	mv	s3,a6	# ldc, tmp902
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ble	t3,a7,.L48	#, N, tmp729,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:90:         if (M & 4) {
	andi	a3,s1,4	#, _46, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:181:             C[ci + 2 * ldc + 0] += alpha * result4;
	slli	a5,s3,1	#, _150, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,s1,63	#, tmp732, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:90:         if (M & 4) {
	sd	a3,0(sp)	# _46, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:151:         if (M & 2) {
	andi	a3,s1,2	#, _91, M
	slli	s6,a2,5	#, _1652, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	andi	a6,a6,7	#, tmp733, tmp732
	slli	a2,s3,5	#, _1636, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:181:             C[ci + 2 * ldc + 0] += alpha * result4;
	sd	a5,32(sp)	# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:151:         if (M & 2) {
	sd	a3,8(sp)	# _91, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:183:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	a5,a5,s3	# ldc, _164, _150
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:188:         if (M & 1) {
	andi	a3,s1,1	#, _178, M
	sd	s7,96(sp)	#,
	srai	t6,a1,2	#, _917, tmp727
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a6,a6,s1	# M, tmp734, tmp733
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:188:         if (M & 1) {
	sd	a3,16(sp)	# _178, %sfp
	sd	a2,24(sp)	# _1636, %sfp
	slli	a3,s3,2	#, _1660, ldc
	sd	s8,88(sp)	#,
	sd	s9,80(sp)	#,
	sd	s10,72(sp)	#,
	sd	s11,64(sp)	#,
	.cfi_offset 23, -64
	.cfi_offset 24, -72
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
	slti	a1,s1,8	#, tmp742, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:183:             C[ci + 3 * ldc + 0] += alpha * result6;
	sd	a5,40(sp)	# _164, %sfp
	mv	s4,a3	# _1660, _1660
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a6,3	#, _947, tmp734
	add	a4,a4,s6	# _1652, ivtmp.483, B
	addi	a3,t0,32	#, ivtmp.482, B
	mv	s0,t4	# ivtmp.485, C
	slli	t1,a0,6	#, _1684, K
	slli	a2,s3,3	#, _1672, ldc
	li	s7,8		# _1906,
	beq	a1,zero,.L126	#, tmp742,,
.L4:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:188:         if (M & 1) {
	li	s2,0		# ivtmp.478,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t2,0		# j,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:46:             for (BLASLONG k = 1; k < K; k++) {
	li	a7,1		# tmp893,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:91:             gvl = __riscv_vsetvl_e64m1(4);
	mv	s8,s4	# _1660, _1660
	sd	t3,48(sp)	# N, %sfp
	sd	t0,56(sp)	# B, %sfp
.L18:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t3,7		# tmp1202,
	ble	s1,t3,.L49	#, M, tmp1202,
	vsetivli	zero,8,e64,m1,ta,ma	#,,,,
	mv	s9,t5	# ivtmp.463, A
	mv	t3,s0	# ivtmp.464, ivtmp.485
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	s10,0		# i,
.L8:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:38:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v2,0(s9)	# A0,* ivtmp.463
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:41:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	fld	fa1,-32(a3)	# MEM[(FLOAT *)_1631 + -32B], MEM[(FLOAT *)_1631 + -32B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:33:             double B1 = B[bi + 1];
	fld	fa2,-24(a3)	# B1, MEM[(FLOAT *)_1631 + -24B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:34:             double B2 = B[bi + 2];
	fld	fa3,-16(a3)	# B2, MEM[(FLOAT *)_1631 + -16B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:35:             double B3 = B[bi + 3];
	fld	fa5,-8(a3)	# B3, MEM[(FLOAT *)_1631 + -8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:41:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	vfmul.vf	v5,v2,fa1	# result0, A0, MEM[(FLOAT *)_1631 + -32B],
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:42:             vfloat64m1_t result1 = __riscv_vfmul_vf_f64m1(A0, B1, gvl);
	vfmul.vf	v4,v2,fa2	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:43:             vfloat64m1_t result2 = __riscv_vfmul_vf_f64m1(A0, B2, gvl);
	vfmul.vf	v3,v2,fa3	# result2, A0, B2,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:44:             vfloat64m1_t result3 = __riscv_vfmul_vf_f64m1(A0, B3, gvl);
	vfmul.vf	v2,v2,fa5	# result3, A0, B3,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:46:             for (BLASLONG k = 1; k < K; k++) {
	ble	a0,a7,.L6	#, K, tmp893,
	addi	s4,s9,64	#, ivtmp.456, ivtmp.463
	mv	t0,a3	# ivtmp.454, ivtmp.482
.L7:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:53:                 A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v1,0(s4)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:56:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	fld	fa2,0(t0)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:48:                 B1 = B[bi + 1];
	fld	fa3,8(t0)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:49:                 B2 = B[bi + 2];
	fld	fa1,16(t0)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:50:                 B3 = B[bi + 3];
	fld	fa5,24(t0)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:46:             for (BLASLONG k = 1; k < K; k++) {
	addi	t0,t0,32	#, ivtmp.454, ivtmp.454
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:56:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	vfmacc.vf	v5,fa2,v1	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:57:                 result1 = __riscv_vfmacc_vf_f64m1(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa3,v1	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:58:                 result2 = __riscv_vfmacc_vf_f64m1(result2, B2, A0, gvl);
	vfmacc.vf	v3,fa1,v1	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:59:                 result3 = __riscv_vfmacc_vf_f64m1(result3, B3, A0, gvl);
	vfmacc.vf	v2,fa5,v1	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:46:             for (BLASLONG k = 1; k < K; k++) {
	addi	s4,s4,64	#, ivtmp.456, ivtmp.456
	bne	a4,t0,.L7	#, ivtmp.483, ivtmp.454,
.L6:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:64:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v7,0(t3)	# c0,* ivtmp.464
	add	s4,a2,t3	# ivtmp.464, _1671, _1672
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:66:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v6,0(s4)	# c1,* _1671
	add	t0,s4,a2	# _1672, _1668, _1671
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:70:             vfloat64m1_t c3 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	s5,t0,a2	# _1672, _44, _1668
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:70:             vfloat64m1_t c3 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v1,0(s5)	# c3,* _44
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:71:             c0 = __riscv_vfmacc_vf_f64m1(c0, alpha, result0, gvl);
	vfmacc.vf	v7,fa4,v5	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:68:             vfloat64m1_t c2 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v5,0(t0)	# c2,* _1668
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:72:             c1 = __riscv_vfmacc_vf_f64m1(c1, alpha, result1, gvl);
	vfmacc.vf	v6,fa4,v4	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s10,s10,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	s9,s9,t1	# _1684, ivtmp.463, ivtmp.463
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:74:             c3 = __riscv_vfmacc_vf_f64m1(c3, alpha, result3, gvl);
	vfmacc.vf	v1,fa4,v2	# c3, alpha, result3,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:78:             __riscv_vse64_v_f64m1(&C[ci], c0, gvl);
	vse64.v	v7,0(t3)	# c0,* ivtmp.464,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:73:             c2 = __riscv_vfmacc_vf_f64m1(c2, alpha, result2, gvl);
	vfmacc.vf	v5,fa4,v3	# c2, alpha, result2,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t3,t3,64	#, ivtmp.464, ivtmp.464
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:80:             __riscv_vse64_v_f64m1(&C[ci], c1, gvl);
	vse64.v	v6,0(s4)	# c1,* _1671,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:82:             __riscv_vse64_v_f64m1(&C[ci], c2, gvl);
	vse64.v	v5,0(t0)	# c2,* _1668,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:84:             __riscv_vse64_v_f64m1(&C[ci], c3, gvl);
	vse64.v	v1,0(s5)	# c3,* _44,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	s10,a6,.L8	#, i, _947,
	mv	t3,s7	# m_top, _1906
.L5:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:90:         if (M & 4) {
	ld	t0,0(sp)		# _46, %sfp
	bne	t0,zero,.L127	#, _46,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:151:         if (M & 2) {
	ld	t0,8(sp)		# _91, %sfp
	bne	t0,zero,.L128	#, _91,,
.L12:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:188:         if (M & 1) {
	ld	t0,16(sp)		# _178, %sfp
	bne	t0,zero,.L129	#, _178,,
.L15:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ld	t3,24(sp)		# _1636, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	addi	t2,t2,1	#, j, j
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	s2,s2,s8	# _1660, ivtmp.478, ivtmp.478
	add	a3,a3,s6	# _1652, ivtmp.482, ivtmp.482
	add	a4,a4,s6	# _1652, ivtmp.483, ivtmp.483
	add	s0,s0,t3	# _1636, ivtmp.485, ivtmp.485
	blt	t2,t6,.L18	#, j, _917,
	ld	t3,48(sp)		# N, %sfp
	ld	t0,56(sp)		# B, %sfp
	ld	s7,96(sp)		#,
	.cfi_restore 23
	ld	s8,88(sp)		#,
	.cfi_restore 24
	ld	s9,80(sp)		#,
	.cfi_restore 25
	ld	s10,72(sp)		#,
	.cfi_restore 26
	ld	s11,64(sp)		#,
	.cfi_restore 27
	slli	t6,t6,2	#, n_top, _917
.L2:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:218:     if (N & 2) {
	andi	a5,t3,2	#, _234, N
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:218:     if (N & 2) {
	beq	a5,zero,.L125	#, _234,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a4,s1,63	#, tmp794, M
	andi	a4,a4,7	#, tmp795, tmp794
	add	a4,a4,s1	# M, tmp796, tmp795
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a5,7		# tmp798,
	vsetivli	zero,8,e64,m1,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t1,a4,3	#, _887, tmp796
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	s1,a5,.L52	#, M, tmp798,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:224:             BLASLONG bi = n_top * K;
	mul	a5,a0,t6	# bi.110_236, K, n_top
	slli	a2,a0,1	#, _348, K
	slli	s2,a0,6	#, _180, K
	mv	a6,t5	# ivtmp.422, A
	slli	s0,s3,3	#, _192, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a7,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:235:             for (BLASLONG k = 1; k < K; k++) {
	li	t2,1		# tmp808,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:247:             BLASLONG ci = n_top * ldc + m_top;
	mul	a1,t6,s3	# _549, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:225:             double B0 = B[bi + 0];
	slli	s5,a5,3	#, _237, bi.110_236
	addi	s4,a5,2	#, _810, bi.110_236
	add	a2,a2,a5	# bi.110_236, _350, _348
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:226:             double B1 = B[bi + 1];
	addi	s6,s5,8	#, _240, _237
	slli	s4,s4,3	#, _337, _810
	slli	a2,a2,3	#, _617, _350
	add	s6,t0,s6	# _240, _241, B
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:225:             double B0 = B[bi + 0];
	add	s5,t0,s5	# _237, _238, B
	add	s4,t0,s4	# _337, ivtmp.410, B
	slli	a1,a1,3	#, _185, _549
	add	a2,t0,a2	# _617, _619, B
	add	a1,t4,a1	# _185, ivtmp.423, C
.L23:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:229:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v1,0(a6)	# A0,* ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:232:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	fld	fa3,0(s5)	# *_238, *_238
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:226:             double B1 = B[bi + 1];
	fld	fa5,0(s6)	# B1, *_241
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:232:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	vfmul.vf	v2,v1,fa3	# result0, A0, *_238,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:233:             vfloat64m1_t result1 = __riscv_vfmul_vf_f64m1(A0, B1, gvl);
	vfmul.vf	v1,v1,fa5	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:235:             for (BLASLONG k = 1; k < K; k++) {
	ble	a0,t2,.L21	#, K, tmp808,
	addi	a3,a6,64	#, ivtmp.412, ivtmp.422
	mv	a5,s4	# ivtmp.410, ivtmp.410
.L22:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:240:                 A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v3,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:243:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	fld	fa3,0(a5)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:237:                 B1 = B[bi + 1];
	fld	fa5,8(a5)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:235:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,16	#, ivtmp.410, ivtmp.410
	addi	a3,a3,64	#, ivtmp.412, ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:243:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	vfmacc.vf	v2,fa3,v3	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:244:                 result1 = __riscv_vfmacc_vf_f64m1(result1, B1, A0, gvl);
	vfmacc.vf	v1,fa5,v3	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:235:             for (BLASLONG k = 1; k < K; k++) {
	bne	a2,a5,.L22	#, _619, ivtmp.410,
.L21:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:249:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v4,0(a1)	# c0,* ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:251:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	a5,a1,s0	# _192, _260, ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:251:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v3,0(a5)	# c1,* _260
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a7,a7,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a6,a6,s2	# _180, ivtmp.422, ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:252:             c0 = __riscv_vfmacc_vf_f64m1(c0, alpha, result0, gvl);
	vfmacc.vf	v4,fa4,v2	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:253:             c1 = __riscv_vfmacc_vf_f64m1(c1, alpha, result1, gvl);
	vfmacc.vf	v3,fa4,v1	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:257:             __riscv_vse64_v_f64m1(&C[ci], c0, gvl);
	vse64.v	v4,0(a1)	# c0,* ivtmp.423,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a1,a1,64	#, ivtmp.423, ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:259:             __riscv_vse64_v_f64m1(&C[ci], c1, gvl);
	vse64.v	v3,0(a5)	# c1,* _260,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:222:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	a7,t1,.L23	#, i, _887,
	slli	a4,t1,3	#, m_top, _887
.L20:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:263:         if (M & 4) {
	andi	a5,s1,4	#, _262, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:263:         if (M & 4) {
	beq	a5,zero,.L24	#, _262,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:266:             BLASLONG ai = m_top * K;
	mul	a5,a0,a4	# ai, K, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:264:             gvl = __riscv_vsetvl_e64m1(4);
	vsetivli	zero,4,e64,m1,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:278:             for (BLASLONG k = 1; k < K; k++) {
	li	a1,1		# tmp816,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:267:             BLASLONG bi = n_top * K;
	mul	a6,a0,t6	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:272:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	slli	a2,a5,3	#, _271, ai
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:272:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	add	a2,t5,a2	# _271, _272, A
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:272:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v1,0(a2)	# A0,* _272
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:273:             ai += 4;
	addi	a2,a5,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:268:             double B0 = B[bi + 0];
	slli	a5,a6,3	#, _265, bi
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:269:             double B1 = B[bi + 1];
	add	a5,t0,a5	# _265, tmp811, B
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:275:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	fld	fa3,0(a5)	# *_266, *_266
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:269:             double B1 = B[bi + 1];
	fld	fa5,8(a5)	# B1, *_269
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:270:             bi += 2;
	addi	a5,a6,2	#, bi, bi
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:275:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	vfmul.vf	v2,v1,fa3	# result0, A0, *_266,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:276:             vfloat64m1_t result1 = __riscv_vfmul_vf_f64m1(A0, B1, gvl);
	vfmul.vf	v1,v1,fa5	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:278:             for (BLASLONG k = 1; k < K; k++) {
	ble	a0,a1,.L25	#, K, tmp816,
	slli	a1,a0,1	#, _411, K
	add	a1,a1,a6	# bi, _413, _411
	slli	a5,a5,3	#, _1068, bi
	slli	a2,a2,3	#, _407, ai
	slli	a1,a1,3	#, _414, _413
	add	a5,t0,a5	# _1068, ivtmp.393, B
	add	a2,t5,a2	# _407, ivtmp.395, A
	add	a1,t0,a1	# _414, _416, B
.L26:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:283:                 A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v3,0(a2)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:286:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	fld	fa3,0(a5)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:280:                 B1 = B[bi + 1];
	fld	fa5,8(a5)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:278:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,16	#, ivtmp.393, ivtmp.393
	addi	a2,a2,32	#, ivtmp.395, ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:286:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	vfmacc.vf	v2,fa3,v3	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:287:                 result1 = __riscv_vfmacc_vf_f64m1(result1, B1, A0, gvl);
	vfmacc.vf	v1,fa5,v3	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:278:             for (BLASLONG k = 1; k < K; k++) {
	bne	a1,a5,.L26	#, _416, ivtmp.393,
.L25:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:290:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s3,t6	# _282, ldc, n_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:290:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci, _282
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:292:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	slli	a2,a5,3	#, _284, ci
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:292:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	a2,t4,a2	# _284, _285, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:292:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v4,0(a2)	# c0,* _285
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:293:             ci += ldc - gvl * 0;
	add	a5,s3,a5	# ci, ci_575, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:294:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	slli	a5,a5,3	#, _287, ci_575
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:294:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	a5,t4,a5	# _287, _288, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:294:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v3,0(a5)	# c1,* _288
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:303:             m_top += 4;
	addi	a4,a4,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:295:             c0 = __riscv_vfmacc_vf_f64m1(c0, alpha, result0, gvl);
	vfmacc.vf	v4,fa4,v2	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:296:             c1 = __riscv_vfmacc_vf_f64m1(c1, alpha, result1, gvl);
	vfmacc.vf	v3,fa4,v1	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:300:             __riscv_vse64_v_f64m1(&C[ci], c0, gvl);
	vse64.v	v4,0(a2)	# c0,* _285,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:302:             __riscv_vse64_v_f64m1(&C[ci], c1, gvl);
	vse64.v	v3,0(a5)	# c1,* _288,
	vsetivli	zero,8,e64,m1,ta,ma	#,,,,
.L24:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:306:         if (M & 2) {
	andi	a5,s1,2	#, _289, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:306:         if (M & 2) {
	beq	a5,zero,.L27	#, _289,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:311:             BLASLONG ai = m_top * K;
	mul	a2,a4,a0	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:310:             double result3 = 0;
	fmv.d.x	fa5,zero	# result3,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:312:             BLASLONG bi = n_top * K;
	mul	a3,a0,t6	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:314:             for (BLASLONG k = 0; k < K; k++) {
	ble	a0,zero,.L53	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:309:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:308:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:307:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	slli	a2,a2,3	#, _1819, ai
	slli	a3,a3,3	#, _1811, bi
	add	a2,t5,a2	# _1819, vectp.271, A
	add	a3,t0,a3	# _1811, vectp.276, B
	mv	a1,a0	# bnd.269, K
.L29:
	vsetvli	a5,a1,e64,m1,ta,ma	# bnd.269, _1796,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:315:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v2,(a3)	# vect_array.277, vectp.276,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:315:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v4,(a2)	# vect_array.272, vectp.271,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:315:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v12,fa1	# tmp913, result0
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:316:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v11,fa2	# tmp915, result1
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:317:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v10,fa3	# tmp917, result2
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:318:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.s.f	v9,fa5	# tmp919, result3
	slli	a6,a5,4	#, ivtmp_1822, _1796
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:314:             for (BLASLONG k = 0; k < K; k++) {
	sub	a1,a1,a5	# bnd.269, bnd.269, _1796
	add	a2,a2,a6	# ivtmp_1822, vectp.271, vectp.271
	add	a3,a3,a6	# ivtmp_1822, vectp.276, vectp.276
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:317:                 result2 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v6,v4,v3	# vect__308.284, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:315:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v8,v4,v2	# vect__298.280, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:316:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v7,v5,v2	# vect__303.282, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:318:                 result3 += A[ai + 1] * B[bi + 1];
	vfmul.vv	v1,v5,v3	# vect__309.286, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:317:                 result2 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v2,v6,v10	# tmp918, vect__308.284, tmp917,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:315:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v8,v12	# tmp914, vect__298.280, tmp913,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:316:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v3,v7,v11	# tmp916, vect__303.282, tmp915,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:318:                 result3 += A[ai + 1] * B[bi + 1];
	vfredosum.vs	v1,v1,v9	# tmp920, vect__309.286, tmp919,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:317:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa3,v2	# result2, tmp918
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:315:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa1,v4	# result0, tmp914
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:316:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	fa2,v3	# result1, tmp916
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:318:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.f.s	fa5,v1	# result3, tmp920
	bne	a1,zero,.L29	#, bnd.269,,
.L28:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:323:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s3,t6	# _310, ldc, n_top
	vsetivli	zero,8,e64,m1,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:323:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci, _310
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:324:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a3,a5,3	#, _312, ci
	add	a1,t4,a3	# _312, _313, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:324:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa0,0(a1)	# *_313, *_313
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:325:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	a3,a3,8	#, _318, _312
	add	a3,t4,a3	# _318, _319, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:324:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa1,fa4,fa1,fa0	# _316, alpha, result0, *_313
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:326:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	a5,s3,a5	# ci, _323, ldc
	slli	a5,a5,3	#, _325, _323
	add	a2,t4,a5	# _325, _326, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:327:             C[ci + 1 * ldc + 1] += alpha * result3;
	addi	a5,a5,8	#, _331, _325
	add	a5,t4,a5	# _331, _332, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:328:             m_top += 2;
	addi	a4,a4,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:324:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa1,0(a1)	# _316, *_313
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:325:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	fa1,0(a3)	# *_319, *_319
	fmadd.d	fa2,fa4,fa2,fa1	# _322, alpha, result1, *_319
	fsd	fa2,0(a3)	# _322, *_319
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:326:             C[ci + 1 * ldc + 0] += alpha * result2;
	fld	fa2,0(a2)	# *_326, *_326
	fmadd.d	fa3,fa4,fa3,fa2	# _329, alpha, result2, *_326
	fsd	fa3,0(a2)	# _329, *_326
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:327:             C[ci + 1 * ldc + 1] += alpha * result3;
	fld	fa3,0(a5)	# *_332, *_332
	fmadd.d	fa5,fa4,fa5,fa3	# _335, alpha, result3, *_332
	fsd	fa5,0(a5)	# _335, *_332
.L27:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:331:         if (M & 1) {
	andi	a5,s1,1	#, _336, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:331:         if (M & 1) {
	beq	a5,zero,.L30	#, _336,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:334:             BLASLONG ai = m_top * K;
	mul	a2,a4,a0	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:333:             double result1 = 0;
	fmv.d.x	fa5,zero	# result1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:335:             BLASLONG bi = n_top * K;
	mul	a3,a0,t6	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:337:             for (BLASLONG k = 0; k < K; k++) {
	ble	a0,zero,.L54	#, K,,
	slli	a3,a3,3	#, _1844, bi
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:332:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	addi	a6,a3,8	#, _1834, _1844
	slli	a2,a2,3	#, _1851, ai
	add	a2,t5,a2	# _1851, vectp.256, A
	add	a6,t0,a6	# _1834, vectp.264, B
	add	a3,t0,a3	# _1844, vectp.259, B
	mv	a1,a0	# bnd.254, K
.L32:
	vsetvli	a5,a1,e64,m1,ta,ma	# bnd.254, _1826,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:338:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v3,0(a2)	# vect__340.257,* vectp.256
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:338:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v2,0(a3)	# vect__344.260,* vectp.259
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:339:                 result1 += A[ai + 0] * B[bi + 1];
	vle64.v	v1,0(a6)	# vect__349.265,* vectp.264
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:338:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v5,fa3	# tmp909, result0
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:339:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v4,fa5	# tmp911, result1
	slli	a7,a5,3	#, ivtmp_1854, _1826
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:337:             for (BLASLONG k = 0; k < K; k++) {
	sub	a1,a1,a5	# bnd.254, bnd.254, _1826
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:338:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v2,v2,v3	# vect__345.261, vect__344.260, vect__340.257,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:339:                 result1 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v1,v1,v3	# vect__350.266, vect__349.265, vect__340.257,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:337:             for (BLASLONG k = 0; k < K; k++) {
	add	a2,a2,a7	# ivtmp_1854, vectp.256, vectp.256
	add	a3,a3,a7	# ivtmp_1854, vectp.259, vectp.259
	add	a6,a6,a7	# ivtmp_1854, vectp.264, vectp.264
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:338:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v2,v2,v5	# tmp910, vect__345.261, tmp909,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:339:                 result1 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v1,v1,v4	# tmp912, vect__350.266, tmp911,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:338:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa3,v2	# result0, tmp910
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:339:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa5,v1	# result1, tmp912
	bne	a1,zero,.L32	#, bnd.254,,
	vsetivli	zero,8,e64,m1,ta,ma	#,,,,
.L31:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:344:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s3,t6	# _351, ldc, n_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:344:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci, _351
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:345:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a4,a5,3	#, _353, ci
	add	a4,t4,a4	# _353, _354, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:345:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa2,0(a4)	# *_354, *_354
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:346:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,s3,a5	# ci, _358, ldc
	slli	a5,a5,3	#, _360, _358
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:345:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa3,fa4,fa3,fa2	# _357, alpha, result0, *_354
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:346:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,t4,a5	# _360, _361, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:345:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa3,0(a4)	# _357, *_354
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:346:             C[ci + 1 * ldc + 0] += alpha * result1;
	fld	fa3,0(a5)	# *_361, *_361
	fmadd.d	fa5,fa4,fa5,fa3	# _364, alpha, result1, *_361
	fsd	fa5,0(a5)	# _364, *_361
.L30:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:355:     if (N & 1) {
	andi	t3,t3,1	#, _365, N
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:350:         n_top += 2;
	addi	t6,t6,2	#, n_top, n_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:355:     if (N & 1) {
	bne	t3,zero,.L130	#, _365,,
.L105:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:464: }
	ld	s0,152(sp)		#,
	.cfi_restore 8
	ld	s1,144(sp)		#,
	.cfi_restore 9
	ld	s2,136(sp)		#,
	.cfi_restore 18
	ld	s3,128(sp)		#,
	.cfi_restore 19
	ld	s4,120(sp)		#,
	.cfi_restore 20
	ld	s5,112(sp)		#,
	.cfi_restore 21
	ld	s6,104(sp)		#,
	.cfi_restore 22
	li	a0,0		#,
	addi	sp,sp,160	#,,
	.cfi_def_cfa_offset 0
	jr	ra		#
.L129:
	.cfi_def_cfa_offset 160
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
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:193:             BLASLONG ai = m_top * K;
	mul	s5,t3,a0	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:192:             double result3 = 0;
	fmv.d.x	fa5,zero	# result3,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:196:             for (BLASLONG k = 0; k < K; k++) {
	ble	a0,zero,.L51	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:191:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:190:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:189:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	slli	s5,s5,3	#, _1789, ai
	add	s5,t5,s5	# _1789, vectp.291, A
	addi	s9,a3,-32	#, vectp.294, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:196:             for (BLASLONG k = 0; k < K; k++) {
	mv	s4,a0	# ivtmp_1766, K
.L17:
	vsetvli	t0,s4,e64,m1,ta,ma	# ivtmp_1766, _1765,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:197:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e64.v	v4,(s9)	# vect_array.295, vectp.294,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:197:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(s5)	# vect__182.292,* vectp.291
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:197:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v12,fa1	# tmp921, result0
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:198:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v11,fa2	# tmp923, result1
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:199:                 result2 += A[ai + 0] * B[bi + 2];
	vfmv.s.f	v10,fa3	# tmp925, result2
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:200:                 result3 += A[ai + 0] * B[bi + 3];
	vfmv.s.f	v9,fa5	# tmp927, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:196:             for (BLASLONG k = 0; k < K; k++) {
	slli	s10,t0,3	#, ivtmp_1792, _1765
	add	s5,s5,s10	# ivtmp_1792, vectp.291, vectp.291
	sub	s4,s4,t0	# ivtmp_1766, ivtmp_1766, _1765
	slli	s10,t0,5	#, ivtmp_1785, _1765
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:197:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v8,v1,v4	# vect__187.300, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:198:                 result1 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v3,v1,v5	# vect__192.302, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:199:                 result2 += A[ai + 0] * B[bi + 2];
	vfmul.vv	v2,v1,v6	# vect__197.304, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:200:                 result3 += A[ai + 0] * B[bi + 3];
	vfmul.vv	v1,v1,v7	# vect__202.306, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:196:             for (BLASLONG k = 0; k < K; k++) {
	add	s9,s9,s10	# ivtmp_1785, vectp.294, vectp.294
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:197:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v8,v12	# tmp922, vect__187.300, tmp921,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:198:                 result1 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v3,v3,v11	# tmp924, vect__192.302, tmp923,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:199:                 result2 += A[ai + 0] * B[bi + 2];
	vfredosum.vs	v2,v2,v10	# tmp926, vect__197.304, tmp925,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:200:                 result3 += A[ai + 0] * B[bi + 3];
	vfredosum.vs	v1,v1,v9	# tmp928, vect__202.306, tmp927,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:197:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa1,v4	# result0, tmp922
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:198:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa2,v3	# result1, tmp924
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:199:                 result2 += A[ai + 0] * B[bi + 2];
	vfmv.f.s	fa3,v2	# result2, tmp926
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:200:                 result3 += A[ai + 0] * B[bi + 3];
	vfmv.f.s	fa5,v1	# result3, tmp928
	bne	s4,zero,.L17	#, ivtmp_1766,,
.L16:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:205:             BLASLONG ci = n_top * ldc + m_top;
	add	t3,s2,t3	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:206:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	s5,t3,3	#, _205, ci
	add	s5,t4,s5	# _205, _206, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:206:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa0,0(s5)	# *_206, *_206
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:207:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	s4,s3,t3	# ci, _210, ldc
	slli	s4,s4,3	#, _212, _210
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:206:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa1,fa4,fa1,fa0	# _209, alpha, result0, *_206
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:207:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	s4,t4,s4	# _212, _213, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:208:             C[ci + 2 * ldc + 0] += alpha * result2;
	ld	t0,32(sp)		# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:209:             C[ci + 3 * ldc + 0] += alpha * result3;
	ld	s9,40(sp)		# _164, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:208:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	t0,t0,t3	# ci, _218, _150
	slli	t0,t0,3	#, _220, _218
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:206:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa1,0(s5)	# _209, *_206
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:207:             C[ci + 1 * ldc + 0] += alpha * result1;
	fld	fa1,0(s4)	# *_213, *_213
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:208:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	t0,t4,t0	# _220, _221, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:209:             C[ci + 3 * ldc + 0] += alpha * result3;
	add	t3,s9,t3	# ci, _226, _164
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:207:             C[ci + 1 * ldc + 0] += alpha * result1;
	fmadd.d	fa2,fa4,fa2,fa1	# _216, alpha, result1, *_213
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:209:             C[ci + 3 * ldc + 0] += alpha * result3;
	slli	t3,t3,3	#, _228, _226
	add	t3,t4,t3	# _228, _229, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:207:             C[ci + 1 * ldc + 0] += alpha * result1;
	fsd	fa2,0(s4)	# _216, *_213
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:208:             C[ci + 2 * ldc + 0] += alpha * result2;
	fld	fa2,0(t0)	# *_221, *_221
	fmadd.d	fa3,fa4,fa3,fa2	# _224, alpha, result2, *_221
	fsd	fa3,0(t0)	# _224, *_221
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:209:             C[ci + 3 * ldc + 0] += alpha * result3;
	fld	fa3,0(t3)	# *_229, *_229
	fmadd.d	fa5,fa4,fa5,fa3	# _232, alpha, result3, *_229
	fsd	fa5,0(t3)	# _232, *_229
	j	.L15		#
.L127:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:93:             BLASLONG ai = m_top * K;
	mul	t0,a0,t3	# ai, K, m_top
	vsetivli	zero,4,e64,m1,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:104:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	fld	fa1,-32(a3)	# MEM[(FLOAT *)_1632 + -32B], MEM[(FLOAT *)_1632 + -32B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:96:             double B1 = B[bi + 1];
	fld	fa2,-24(a3)	# B1, MEM[(FLOAT *)_1632 + -24B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:97:             double B2 = B[bi + 2];
	fld	fa3,-16(a3)	# B2, MEM[(FLOAT *)_1632 + -16B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:98:             double B3 = B[bi + 3];
	fld	fa5,-8(a3)	# B3, MEM[(FLOAT *)_1632 + -8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:101:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	slli	s4,t0,3	#, _61, ai
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:101:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	add	s4,t5,s4	# _61, _62, A
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:101:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v2,0(s4)	# A0,* _62
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:102:             ai += 4;
	addi	s4,t0,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:104:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	vfmul.vf	v5,v2,fa1	# result0, A0, MEM[(FLOAT *)_1632 + -32B],
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:105:             vfloat64m1_t result1 = __riscv_vfmul_vf_f64m1(A0, B1, gvl);
	vfmul.vf	v4,v2,fa2	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:106:             vfloat64m1_t result2 = __riscv_vfmul_vf_f64m1(A0, B2, gvl);
	vfmul.vf	v3,v2,fa3	# result2, A0, B2,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:107:             vfloat64m1_t result3 = __riscv_vfmul_vf_f64m1(A0, B3, gvl);
	vfmul.vf	v2,v2,fa5	# result3, A0, B3,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:109:             for (BLASLONG k = 1; k < K; k++) {
	ble	a0,a7,.L10	#, K, tmp893,
	slli	s4,s4,3	#, _1072, ai
	add	s4,t5,s4	# _1072, ivtmp.441, A
	mv	t0,a3	# ivtmp.439, ivtmp.482
.L11:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:116:                 A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v1,0(s4)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:119:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	fld	fa1,0(t0)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:111:                 B1 = B[bi + 1];
	fld	fa2,8(t0)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:112:                 B2 = B[bi + 2];
	fld	fa3,16(t0)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:113:                 B3 = B[bi + 3];
	fld	fa5,24(t0)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:109:             for (BLASLONG k = 1; k < K; k++) {
	addi	t0,t0,32	#, ivtmp.439, ivtmp.439
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:119:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	vfmacc.vf	v5,fa1,v1	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:120:                 result1 = __riscv_vfmacc_vf_f64m1(result1, B1, A0, gvl);
	vfmacc.vf	v4,fa2,v1	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:121:                 result2 = __riscv_vfmacc_vf_f64m1(result2, B2, A0, gvl);
	vfmacc.vf	v3,fa3,v1	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:122:                 result3 = __riscv_vfmacc_vf_f64m1(result3, B3, A0, gvl);
	vfmacc.vf	v2,fa5,v1	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:109:             for (BLASLONG k = 1; k < K; k++) {
	addi	s4,s4,32	#, ivtmp.441, ivtmp.441
	bne	t0,a4,.L11	#, ivtmp.439, ivtmp.483,
.L10:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:125:             BLASLONG ci = n_top * ldc + m_top;
	add	t0,s2,t3	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:127:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	slli	s9,t0,3	#, _80, ci
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:127:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	s9,t4,s9	# _80, _81, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:127:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v1,0(s9)	# c0,* _81
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:128:             ci += ldc - gvl * 0;
	add	t0,s3,t0	# ci, ci, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:129:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	slli	s5,t0,3	#, _83, ci
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:129:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	s5,t4,s5	# _83, _84, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:129:             vfloat64m1_t c1 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v6,0(s5)	# c1,* _84
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:130:             ci += ldc - gvl * 0;
	add	t0,s3,t0	# ci, ci, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:134:             c0 = __riscv_vfmacc_vf_f64m1(c0, alpha, result0, gvl);
	vmv1r.v	v7,v1	# c0, c0
	vfmacc.vf	v7,fa4,v5	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:132:             ci += ldc - gvl * 0;
	add	s4,s3,t0	# ci, ci_739, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:133:             vfloat64m1_t c3 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	slli	s4,s4,3	#, _89, ci_739
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:131:             vfloat64m1_t c2 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	slli	t0,t0,3	#, _86, ci
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:131:             vfloat64m1_t c2 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	t0,t4,t0	# _86, _87, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:133:             vfloat64m1_t c3 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	s4,t4,s4	# _89, _90, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:131:             vfloat64m1_t c2 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v5,0(t0)	# c2,* _87
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:133:             vfloat64m1_t c3 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v1,0(s4)	# c3,* _90
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:135:             c1 = __riscv_vfmacc_vf_f64m1(c1, alpha, result1, gvl);
	vfmacc.vf	v6,fa4,v4	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:141:             __riscv_vse64_v_f64m1(&C[ci], c0, gvl);
	vse64.v	v7,0(s9)	# c0,* _81,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:148:             m_top += 4;
	addi	t3,t3,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:136:             c2 = __riscv_vfmacc_vf_f64m1(c2, alpha, result2, gvl);
	vfmacc.vf	v5,fa4,v3	# c2, alpha, result2,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:137:             c3 = __riscv_vfmacc_vf_f64m1(c3, alpha, result3, gvl);
	vfmacc.vf	v1,fa4,v2	# c3, alpha, result3,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:143:             __riscv_vse64_v_f64m1(&C[ci], c1, gvl);
	vse64.v	v6,0(s5)	# c1,* _84,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:145:             __riscv_vse64_v_f64m1(&C[ci], c2, gvl);
	vse64.v	v5,0(t0)	# c2,* _87,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:147:             __riscv_vse64_v_f64m1(&C[ci], c3, gvl);
	vse64.v	v1,0(s4)	# c3,* _90,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:151:         if (M & 2) {
	ld	t0,8(sp)		# _91, %sfp
	beq	t0,zero,.L12	#, _91,,
.L128:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:160:             BLASLONG ai = m_top * K;
	mul	s5,t3,a0	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:159:             double result7 = 0;
	fmv.d.x	fa5,zero	# result7,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:163:             for (BLASLONG k = 0; k < K; k++) {
	ble	a0,zero,.L50	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:158:             double result6 = 0;
	fmv.d	fa3,fa5	# result6, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:157:             double result5 = 0;
	fmv.d	fa2,fa5	# result5, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:156:             double result4 = 0;
	fmv.d	fa1,fa5	# result4, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:155:             double result3 = 0;
	fmv.d	fa0,fa5	# result3, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:154:             double result2 = 0;
	fmv.d	ft0,fa5	# result2, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:153:             double result1 = 0;
	fmv.d	ft1,fa5	# result1, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:152:             double result0 = 0;
	fmv.d	ft2,fa5	# result0, result7
	slli	s5,s5,3	#, _1758, ai
	add	s5,t5,s5	# _1758, vectp.311, A
	addi	s9,a3,-32	#, vectp.316, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:163:             for (BLASLONG k = 0; k < K; k++) {
	mv	s4,a0	# ivtmp_1726, K
.L14:
	vsetvli	t0,s4,e64,m1,ta,ma	# ivtmp_1726, _1725,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:164:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v2,(s5)	# vect_array.312, vectp.311,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:164:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e64.v	v4,(s9)	# vect_array.317, vectp.316,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:164:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v22,ft2	# tmp929, result0
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:165:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v21,ft1	# tmp931, result1
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:166:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v20,ft0	# tmp933, result2
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:167:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.s.f	v19,fa0	# tmp935, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:168:                 result4 += A[ai + 0] * B[bi + 2];
	vfmv.s.f	v18,fa1	# tmp937, result4
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:169:                 result5 += A[ai + 1] * B[bi + 2];
	vfmv.s.f	v17,fa2	# tmp939, result5
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:170:                 result6 += A[ai + 0] * B[bi + 3];
	vfmv.s.f	v16,fa3	# tmp941, result6
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:171:                 result7 += A[ai + 1] * B[bi + 3];
	vfmv.s.f	v15,fa5	# tmp943, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:163:             for (BLASLONG k = 0; k < K; k++) {
	slli	s10,t0,4	#, ivtmp_1761, _1725
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:164:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v14,v2,v4	# vect__100.322, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:165:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v13,v3,v4	# vect__105.324, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:166:                 result2 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v12,v2,v5	# vect__110.326, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:167:                 result3 += A[ai + 1] * B[bi + 1];
	vfmul.vv	v11,v3,v5	# vect__111.328, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:168:                 result4 += A[ai + 0] * B[bi + 2];
	vfmul.vv	v10,v2,v6	# vect__116.330, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:169:                 result5 += A[ai + 1] * B[bi + 2];
	vfmul.vv	v9,v3,v6	# vect__117.332, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:164:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v14,v22	# tmp930, vect__100.322, tmp929,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:170:                 result6 += A[ai + 0] * B[bi + 3];
	vfmul.vv	v8,v2,v7	# vect__122.334, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:171:                 result7 += A[ai + 1] * B[bi + 3];
	vfmul.vv	v1,v3,v7	# vect__123.336, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:166:                 result2 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v2,v12,v20	# tmp934, vect__110.326, tmp933,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:163:             for (BLASLONG k = 0; k < K; k++) {
	add	s5,s5,s10	# ivtmp_1761, vectp.311, vectp.311
	sub	s4,s4,t0	# ivtmp_1726, ivtmp_1726, _1725
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:165:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v3,v13,v21	# tmp932, vect__105.324, tmp931,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:163:             for (BLASLONG k = 0; k < K; k++) {
	slli	s10,t0,5	#, ivtmp_1753, _1725
	add	s9,s9,s10	# ivtmp_1753, vectp.316, vectp.316
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:167:                 result3 += A[ai + 1] * B[bi + 1];
	vfredosum.vs	v5,v11,v19	# tmp936, vect__111.328, tmp935,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:164:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	ft2,v4	# result0, tmp930
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:171:                 result7 += A[ai + 1] * B[bi + 3];
	vfredosum.vs	v1,v1,v15	# tmp944, vect__123.336, tmp943,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:166:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	ft0,v2	# result2, tmp934
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:168:                 result4 += A[ai + 0] * B[bi + 2];
	vfredosum.vs	v4,v10,v18	# tmp938, vect__116.330, tmp937,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:165:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	ft1,v3	# result1, tmp932
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:170:                 result6 += A[ai + 0] * B[bi + 3];
	vfredosum.vs	v2,v8,v16	# tmp942, vect__122.334, tmp941,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:167:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.f.s	fa0,v5	# result3, tmp936
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:169:                 result5 += A[ai + 1] * B[bi + 2];
	vfredosum.vs	v3,v9,v17	# tmp940, vect__117.332, tmp939,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:171:                 result7 += A[ai + 1] * B[bi + 3];
	vfmv.f.s	fa5,v1	# result7, tmp944
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:168:                 result4 += A[ai + 0] * B[bi + 2];
	vfmv.f.s	fa1,v4	# result4, tmp938
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:170:                 result6 += A[ai + 0] * B[bi + 3];
	vfmv.f.s	fa3,v2	# result6, tmp942
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:169:                 result5 += A[ai + 1] * B[bi + 2];
	vfmv.f.s	fa2,v3	# result5, tmp940
	bne	s4,zero,.L14	#, ivtmp_1726,,
.L13:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:176:             BLASLONG ci = n_top * ldc + m_top;
	add	t0,s2,t3	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:177:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	s5,t0,3	#, _126, ci
	add	s4,t4,s5	# _126, _127, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:177:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	ft3,0(s4)	# *_127, *_127
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:178:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	s5,s5,8	#, _132, _126
	add	s9,t4,s5	# _132, _133, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:177:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	ft2,fa4,ft2,ft3	# _130, alpha, result0, *_127
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:179:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	s5,s3,t0	# ci, _137, ldc
	slli	s5,s5,3	#, _139, _137
	add	s11,t4,s5	# _139, _140, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:180:             C[ci + 1 * ldc + 1] += alpha * result3;
	addi	s5,s5,8	#, _145, _139
	add	s5,t4,s5	# _145, _146, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:183:             C[ci + 3 * ldc + 0] += alpha * result6;
	ld	s10,40(sp)		# _164, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:177:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	ft2,0(s4)	# _130, *_127
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:178:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	ft2,0(s9)	# *_133, *_133
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:181:             C[ci + 2 * ldc + 0] += alpha * result4;
	ld	s4,32(sp)		# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:185:             m_top += 2;
	addi	t3,t3,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:178:             C[ci + 0 * ldc + 1] += alpha * result1;
	fmadd.d	ft1,fa4,ft1,ft2	# _136, alpha, result1, *_133
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:181:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	s4,s4,t0	# ci, _151, _150
	slli	s4,s4,3	#, _153, _151
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:183:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	t0,s10,t0	# ci, _165, _164
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:181:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	s10,t4,s4	# _153, _154, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:182:             C[ci + 2 * ldc + 1] += alpha * result5;
	addi	s4,s4,8	#, _159, _153
	add	s4,t4,s4	# _159, _160, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:178:             C[ci + 0 * ldc + 1] += alpha * result1;
	fsd	ft1,0(s9)	# _136, *_133
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:179:             C[ci + 1 * ldc + 0] += alpha * result2;
	fld	ft1,0(s11)	# *_140, *_140
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:183:             C[ci + 3 * ldc + 0] += alpha * result6;
	slli	t0,t0,3	#, _167, _165
	add	s9,t4,t0	# _167, _168, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:179:             C[ci + 1 * ldc + 0] += alpha * result2;
	fmadd.d	ft0,fa4,ft0,ft1	# _143, alpha, result2, *_140
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:184:             C[ci + 3 * ldc + 1] += alpha * result7;
	addi	t0,t0,8	#, _173, _167
	add	t0,t4,t0	# _173, _174, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:179:             C[ci + 1 * ldc + 0] += alpha * result2;
	fsd	ft0,0(s11)	# _143, *_140
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:180:             C[ci + 1 * ldc + 1] += alpha * result3;
	fld	ft0,0(s5)	# *_146, *_146
	fmadd.d	fa0,fa4,fa0,ft0	# _149, alpha, result3, *_146
	fsd	fa0,0(s5)	# _149, *_146
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:181:             C[ci + 2 * ldc + 0] += alpha * result4;
	fld	fa0,0(s10)	# *_154, *_154
	fmadd.d	fa1,fa4,fa1,fa0	# _157, alpha, result4, *_154
	fsd	fa1,0(s10)	# _157, *_154
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:182:             C[ci + 2 * ldc + 1] += alpha * result5;
	fld	fa1,0(s4)	# *_160, *_160
	fmadd.d	fa2,fa4,fa2,fa1	# _163, alpha, result5, *_160
	fsd	fa2,0(s4)	# _163, *_160
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:183:             C[ci + 3 * ldc + 0] += alpha * result6;
	fld	fa2,0(s9)	# *_168, *_168
	fmadd.d	fa3,fa4,fa3,fa2	# _171, alpha, result6, *_168
	fsd	fa3,0(s9)	# _171, *_168
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:184:             C[ci + 3 * ldc + 1] += alpha * result7;
	fld	fa3,0(t0)	# *_174, *_174
	fmadd.d	fa5,fa4,fa5,fa3	# _177, alpha, result7, *_174
	fsd	fa5,0(t0)	# _177, *_174
	j	.L12		#
.L49:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:26:         m_top = 0;
	li	t3,0		# m_top,
	j	.L5		#
.L125:
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 27
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:355:     if (N & 1) {
	andi	t3,t3,1	#, _365, N
	vsetivli	zero,8,e64,m1,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:355:     if (N & 1) {
	beq	t3,zero,.L105	#, _365,,
.L130:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a4,s1,63	#, tmp850, M
	andi	a4,a4,7	#, tmp851, tmp850
	add	a4,a4,s1	# M, tmp852, tmp851
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a5,7		# tmp854,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t3,a4,3	#, _892, tmp852
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	s1,a5,.L55	#, M, tmp854,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:361:             BLASLONG bi = n_top * K;
	mul	a7,t6,a0	# bi_695, n_top, K
	slli	t2,a0,6	#, _103, K
	add	a2,t2,t5	# A, ivtmp.381, _103
	mv	a6,t5	# ivtmp.376, A
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t1,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:370:             for (BLASLONG k = 1; k < K; k++) {
	li	s0,1		# tmp859,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:380:             BLASLONG ci = n_top * ldc + m_top;
	mul	a1,s3,t6	# _521, ldc, n_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:362:             double B0 = B[bi + 0];
	slli	a7,a7,3	#, _368, bi_695
	add	a7,t0,a7	# _368, _369, B
	slli	a1,a1,3	#, _108, _521
	add	a1,t4,a1	# _108, ivtmp.377, C
.L38:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:365:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v1,0(a6)	# A0,* ivtmp.376
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:368:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	fld	fa5,0(a7)	# *_369, *_369
	vfmul.vf	v1,v1,fa5	# result0, A0, *_369,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:370:             for (BLASLONG k = 1; k < K; k++) {
	ble	a0,s0,.L36	#, K, tmp859,
	addi	a5,a6,64	#, ivtmp.369, ivtmp.376
	mv	a4,a7	# ivtmp.368, _369
.L37:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:374:                 A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v2,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:377:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	fld	fa5,8(a4)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:370:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,64	#, ivtmp.369, ivtmp.369
	addi	a4,a4,8	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:377:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	vfmacc.vf	v1,fa5,v2	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:370:             for (BLASLONG k = 1; k < K; k++) {
	bne	a2,a5,.L37	#, ivtmp.381, ivtmp.369,
.L36:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:382:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v2,0(a1)	# c0,* ivtmp.377
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t1,t1,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a6,a6,t2	# _103, ivtmp.376, ivtmp.376
	add	a2,a2,t2	# _103, ivtmp.381, ivtmp.381
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:383:             c0 = __riscv_vfmacc_vf_f64m1(c0, alpha, result0, gvl);
	vfmacc.vf	v2,fa4,v1	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:387:             __riscv_vse64_v_f64m1(&C[ci], c0, gvl);
	vse64.v	v2,0(a1)	# c0,* ivtmp.377,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:359:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a1,a1,64	#, ivtmp.377, ivtmp.377
	blt	t1,t3,.L38	#, i, _892,
	slli	a4,t3,3	#, m_top, _892
.L35:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:391:         if (M & 4) {
	andi	a5,s1,4	#, _384, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:391:         if (M & 4) {
	beq	a5,zero,.L39	#, _384,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:394:             BLASLONG ai = m_top * K;
	mul	a5,a0,a4	# ai, K, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:392:             gvl = __riscv_vsetvl_e64m1(4);
	vsetivli	zero,4,e64,m1,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:404:             for (BLASLONG k = 1; k < K; k++) {
	li	a6,1		# tmp866,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:395:             BLASLONG bi = n_top * K;
	mul	a1,t6,a0	# bi.185_386, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:399:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	slli	a3,a5,3	#, _390, ai
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:399:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	add	a3,t5,a3	# _390, _391, A
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:399:             vfloat64m1_t A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v1,0(a3)	# A0,* _391
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:400:             ai += 4;
	addi	a5,a5,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:396:             double B0 = B[bi + 0];
	slli	a3,a1,3	#, _387, bi.185_386
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:396:             double B0 = B[bi + 0];
	add	a3,t0,a3	# _387, tmp864, B
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:402:             vfloat64m1_t result0 = __riscv_vfmul_vf_f64m1(A0, B0, gvl);
	fld	fa5,0(a3)	# *_388, *_388
	vfmul.vf	v1,v1,fa5	# result0, A0, *_388,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:404:             for (BLASLONG k = 1; k < K; k++) {
	ble	a0,a6,.L40	#, K, tmp866,
	add	a1,a0,a1	# bi.185_386, _302, K
	slli	a1,a1,3	#, _301, _302
	slli	a5,a5,3	#, _307, ai
	addi	a6,t0,-8	#, _1921, B
	add	a5,t5,a5	# _307, ivtmp.355, A
	add	a1,a1,a6	# _1921, _298, _301
.L41:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:408:                 A0 = __riscv_vle64_v_f64m1(&A[ai + 0 * gvl], gvl);
	vle64.v	v2,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:411:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	fld	fa5,8(a3)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:404:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,8	#, ivtmp.354, ivtmp.354
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:411:                 result0 = __riscv_vfmacc_vf_f64m1(result0, B0, A0, gvl);
	vfmacc.vf	v1,fa5,v2	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:404:             for (BLASLONG k = 1; k < K; k++) {
	bne	a3,a1,.L41	#, ivtmp.354, _298,
.L40:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:414:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,t6,s3	# _398, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:414:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci_662, _398
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:416:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	slli	a5,a5,3	#, _400, ci_662
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:416:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	add	a5,t4,a5	# _400, _401, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:416:             vfloat64m1_t c0 = __riscv_vle64_v_f64m1(&C[ci], gvl);
	vle64.v	v2,0(a5)	# c0,* _401
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:422:             m_top += 4;
	addi	a4,a4,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:417:             c0 = __riscv_vfmacc_vf_f64m1(c0, alpha, result0, gvl);
	vfmacc.vf	v2,fa4,v1	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:421:             __riscv_vse64_v_f64m1(&C[ci], c0, gvl);
	vse64.v	v2,0(a5)	# c0,* _401,
.L39:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:425:         if (M & 2) {
	andi	a5,s1,2	#, _402, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:425:         if (M & 2) {
	beq	a5,zero,.L42	#, _402,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:428:             BLASLONG ai = m_top * K;
	mul	a2,a4,a0	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:427:             double result1 = 0;
	fmv.d.x	fa5,zero	# result1,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:429:             BLASLONG bi = n_top * K;
	mul	a3,t6,a0	# bi, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:431:             for (BLASLONG k = 0; k < K; k++) {
	ble	a0,zero,.L56	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:426:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	slli	a2,a2,3	#, _1876, ai
	slli	a3,a3,3	#, _1868, bi
	add	a2,t5,a2	# _1876, vectp.242, A
	add	a3,t0,a3	# _1868, vectp.247, B
	mv	a1,a0	# bnd.240, K
.L44:
	vsetvli	a5,a1,e64,m1,ta,ma	# bnd.240, _1858,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:432:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v4,(a2)	# vect_array.243, vectp.242,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:432:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(a3)	# vect__410.248,* vectp.247
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:432:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v6,fa3	# tmp905, result0
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:433:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v3,fa5	# tmp907, result1
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:431:             for (BLASLONG k = 0; k < K; k++) {
	slli	a7,a5,4	#, ivtmp_1879, _1858
	slli	a6,a5,3	#, ivtmp_1871, _1858
	sub	a1,a1,a5	# bnd.240, bnd.240, _1858
	add	a2,a2,a7	# ivtmp_1879, vectp.242, vectp.242
	add	a3,a3,a6	# ivtmp_1871, vectp.247, vectp.247
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:432:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v2,v1,v4	# vect__411.249, vect__410.248, vect_array.243,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:433:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v1,v1,v5	# vect__416.251, vect__410.248, vect_array.243,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:432:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v2,v2,v6	# tmp906, vect__411.249, tmp905,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:433:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v1,v1,v3	# tmp908, vect__416.251, tmp907,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:432:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa3,v2	# result0, tmp906
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:433:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	fa5,v1	# result1, tmp908
	bne	a1,zero,.L44	#, bnd.240,,
.L43:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:438:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,t6,s3	# _417, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:438:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci_677, _417
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:439:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a5,a5,3	#, _419, ci_677
	add	a3,t4,a5	# _419, _420, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:439:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa2,0(a3)	# *_420, *_420
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:440:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	a5,a5,8	#, _425, _419
	add	a5,t4,a5	# _425, _426, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:439:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa3,fa4,fa3,fa2	# _423, alpha, result0, *_420
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:441:             m_top += 2;
	addi	a4,a4,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:439:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa3,0(a3)	# _423, *_420
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:440:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	fa3,0(a5)	# *_426, *_426
	fmadd.d	fa5,fa4,fa5,fa3	# _429, alpha, result1, *_426
	fsd	fa5,0(a5)	# _429, *_426
.L42:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:444:         if (M & 1) {
	andi	s1,s1,1	#, _430, M
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:444:         if (M & 1) {
	beq	s1,zero,.L105	#, _430,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:446:             BLASLONG ai = m_top * K;
	mul	a3,a4,a0	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:445:             double result0 = 0;
	fmv.d.x	fa5,zero	# result0,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:447:             BLASLONG bi = n_top * K;
	mul	a5,t6,a0	# bi, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:449:             for (BLASLONG k = 0; k < K; k++) {
	ble	a0,zero,.L46	#, K,,
	slli	a3,a3,3	#, _1898, ai
	slli	a5,a5,3	#, _1891, bi
	add	t5,t5,a3	# _1898, vectp.232, A
	add	t0,t0,a5	# _1891, vectp.235, B
.L47:
	vsetvli	a5,a0,e64,m1,ta,ma	# bnd.230, _1883,,,,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:450:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v3,0(t5)	# vect__434.233,* vectp.232
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:450:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(t0)	# vect__438.236,* vectp.235
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:450:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v2,fa5	# tmp903, result0
	slli	a3,a5,3	#, ivtmp_1903, _1883
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:449:             for (BLASLONG k = 0; k < K; k++) {
	sub	a0,a0,a5	# bnd.230, bnd.230, _1883
	add	t5,t5,a3	# ivtmp_1903, vectp.232, vectp.232
	add	t0,t0,a3	# ivtmp_1903, vectp.235, vectp.235
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:450:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v1,v1,v3	# vect__439.237, vect__438.236, vect__434.233,
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:450:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v1,v1,v2	# tmp904, vect__439.237, tmp903,
	vfmv.f.s	fa5,v1	# result0, tmp904
	bne	a0,zero,.L47	#, bnd.230,,
.L46:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:455:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,t6,s3	# _440, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:455:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci_688, _440
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:456:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a5,a5,3	#, _442, ci_688
	add	t4,t4,a5	# _442, _443, C
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:456:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa3,0(t4)	# *_443, *_443
	fmadd.d	fa4,fa4,fa5,fa3	# _446, alpha, result0, *_443
	fsd	fa4,0(t4)	# _446, *_443
	j	.L105		#
.L126:
	.cfi_offset 23, -64
	.cfi_offset 24, -72
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
	slli	s7,a6,3	#, _1906, _947
	j	.L4		#
.L51:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:191:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:190:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:189:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	j	.L16		#
.L50:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:158:             double result6 = 0;
	fmv.d	fa3,fa5	# result6, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:157:             double result5 = 0;
	fmv.d	fa2,fa5	# result5, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:156:             double result4 = 0;
	fmv.d	fa1,fa5	# result4, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:155:             double result3 = 0;
	fmv.d	fa0,fa5	# result3, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:154:             double result2 = 0;
	fmv.d	ft0,fa5	# result2, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:153:             double result1 = 0;
	fmv.d	ft1,fa5	# result1, result7
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:152:             double result0 = 0;
	fmv.d	ft2,fa5	# result0, result7
	j	.L13		#
.L55:
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 27
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:357:         m_top = 0;
	li	a4,0		# m_top,
	j	.L35		#
.L52:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:220:         m_top = 0;
	li	a4,0		# m_top,
	j	.L20		#
.L48:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:21:     BLASLONG n_top = 0;
	li	t6,0		# n_top,
	j	.L2		#
.L54:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:332:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	j	.L31		#
.L56:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:426:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	j	.L43		#
.L53:
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:309:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:308:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul1_unroll1.c:307:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	j	.L28		#
	.cfi_endproc
.LFE0:
	.size	dgemm_kernel_8x4_zvl128b_lmul1_unroll1, .-dgemm_kernel_8x4_zvl128b_lmul1_unroll1
	.ident	"GCC: (Bianbu 14.2.0-4ubuntu2~24.04bb1) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
