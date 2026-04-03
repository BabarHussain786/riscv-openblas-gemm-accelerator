	.file	"igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c"
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
	.globl	dgemm_kernel_8x4_zvl128b_lmul8_unroll8
	.type	dgemm_kernel_8x4_zvl128b_lmul8_unroll8, @function
dgemm_kernel_8x4_zvl128b_lmul8_unroll8:
.LFB0:
	.cfi_startproc
	mv	t5,a1	# N, tmp1189
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	srai	a1,a1,63	#, tmp811, N
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:19: {
	csrr	t0,vlenb	#
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	andi	a1,a1,3	#, tmp812, tmp811
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:19: {
	addi	sp,sp,-224	#,,
	.cfi_def_cfa_offset 224
	slli	t1,t0,5	#,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a1,a1,t5	# N, tmp813, tmp812
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:19: {
	sd	s9,144(sp)	#,
	sd	s10,136(sp)	#,
	sd	s11,128(sp)	#,
	sd	s0,216(sp)	#,
	sd	s1,208(sp)	#,
	sd	s2,200(sp)	#,
	sd	s3,192(sp)	#,
	sd	s4,184(sp)	#,
	sd	s5,176(sp)	#,
	sd	s6,168(sp)	#,
	sd	s7,160(sp)	#,
	sd	s8,152(sp)	#,
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
	.cfi_offset 8, -8
	.cfi_offset 9, -16
	.cfi_offset 18, -24
	.cfi_offset 19, -32
	.cfi_offset 20, -40
	.cfi_offset 21, -48
	.cfi_offset 22, -56
	.cfi_offset 23, -64
	.cfi_offset 24, -72
	mv	s9,a5	# B, tmp1193
	sub	sp,sp,t1	#,,
	.cfi_escape 0xf,0xd,0x72,0,0x92,0xa2,0x38,0,0x8,0x40,0x1e,0x23,0xe0,0x1,0x22
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	srai	a5,a1,2	#, _901, tmp813
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t3,3		# tmp815,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:19: {
	sd	a0,24(sp)	# M, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	sd	a5,32(sp)	# _901, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:19: {
	mv	t1,a2	# K, tmp1190
	mv	s10,a4	# A, tmp1192
	mv	t4,a6	# C, tmp1194
	mv	s11,a7	# ldc, tmp1195
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ble	t5,t3,.L48	#, N, tmp815,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	mv	a4,a0	# M, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:93:         if (M & 4) {
	andi	s0,a4,4	#, _32, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a0,63	#, tmp818, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	slli	a1,a7,1	#, _275, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:93:         if (M & 4) {
	sd	s0,40(sp)	# _32, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:156:         if (M & 2) {
	andi	s0,a4,2	#, _63, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:194:         if (M & 1) {
	andi	a4,a4,1	#, _183, M
	slli	a5,a2,2	#, _2056, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	andi	a6,a6,7	#, tmp819, tmp818
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	a2,a1,a7	# ldc, _165, _275
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:156:         if (M & 2) {
	sd	s0,48(sp)	# _63, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:194:         if (M & 1) {
	sd	a4,56(sp)	# _183, %sfp
	li	s0,8		# _2260,
	slli	a4,a7,2	#, _2047, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a6,a6,a0	# M, tmp820, tmp819
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	sd	a2,88(sp)	# _165, %sfp
	sd	a4,64(sp)	# _2047, %sfp
	slti	a0,a0,8	#, tmp828, M
	sd	s0,72(sp)	# _2260, %sfp
	mv	t0,a5	# _2056, _2056
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a6,3	#, _930, tmp820
	add	a2,s9,a5	# _2056, ivtmp.665, B
	addi	a4,s9,4	#, ivtmp.664, B
	slli	t3,t1,3	#, _942, K
	beq	a0,zero,.L313	#, tmp828,,
.L4:
	add	a0,t4,s11	# ldc, _197, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:169:             for (BLASLONG k = 0; k < K; k++) {
	sd	s9,120(sp)	# B, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:194:         if (M & 1) {
	li	t6,0		# ivtmp.660,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t2,0		# j,
	sd	a0,80(sp)	# _197, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	li	a7,1		# tmp1108,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	s0,a3,0xff	# _2317, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:169:             for (BLASLONG k = 0; k < K; k++) {
	sd	s1,104(sp)	# tmp1111, %sfp
	sd	t5,112(sp)	# N, %sfp
	mv	s9,s11	# ldc, ldc
.L18:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ld	s1,24(sp)		# M, %sfp
	li	t5,7		# tmp1643,
	ble	s1,t5,.L49	#, M, tmp1643,
	ld	s1,80(sp)		# _197, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	mv	s6,t2	# j, j
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
	mv	s4,s10	# ivtmp.647, A
	add	s3,t4,t6	# ivtmp.660, ivtmp.648, C
	add	s1,s1,t6	# ivtmp.660, ivtmp.649, _197
	li	s5,0		# i,
	mv	t2,t6	# ivtmp.660, ivtmp.660
.L8:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:39:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s4)	# A0,* ivtmp.647
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:43:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	s2,-3(a4)	# MEM[(FLOAT *)_187 + -3B], MEM[(FLOAT *)_187 + -3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:45:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	lbu	t5,-1(a4)	# MEM[(FLOAT *)_187 + -1B], MEM[(FLOAT *)_187 + -1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:42:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	s7,-4(a4)	# MEM[(FLOAT *)_187 + -4B], MEM[(FLOAT *)_187 + -4B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:44:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	lbu	t6,-2(a4)	# MEM[(FLOAT *)_187 + -2B], MEM[(FLOAT *)_187 + -2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:43:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v8,v16,s2	# result1, A0, MEM[(FLOAT *)_187 + -3B],
	addi	s2,sp,128	#, tmp2424,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:42:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v24,v16,s7	# result0, A0, MEM[(FLOAT *)_187 + -4B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:43:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vs8r.v	v8,0(s2)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:44:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	vmul.vx	v8,v16,t6	# result2, A0, MEM[(FLOAT *)_187 + -2B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:45:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	vmul.vx	v16,v16,t5	# result3, A0, MEM[(FLOAT *)_187 + -1B],
	csrr	t5,vlenb	# tmp2420
	slli	t5,t5,4	#, tmp2421, tmp2420
	addi	t5,t5,128	#, tmp2422, tmp2419
	add	t5,t5,sp	#, tmp2419, tmp2419
	vs8r.v	v16,0(t5)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,a7,.L6	#, K, tmp1108,
	sub	s2,a2,a4	# tmp1176, ivtmp.665, ivtmp.664
	addi	s2,s2,-4	#, tmp1177, tmp1176
	srli	s2,s2,2	#, tmp1175, tmp1177
	addi	s2,s2,1	#, tmp1178, tmp1175
	andi	s2,s2,7	#, tmp1179, tmp1178
	addi	t6,s4,8	#, ivtmp.640, ivtmp.647
	mv	t5,a4	# ivtmp.638, ivtmp.664
	beq	s2,zero,.L287	#, tmp1179,,
	li	s7,1		# tmp1185,
	beq	s2,s7,.L220	#, tmp1179, tmp1185,
	li	s7,2		# tmp1184,
	beq	s2,s7,.L221	#, tmp1179, tmp1184,
	li	s7,3		# tmp1183,
	beq	s2,s7,.L222	#, tmp1179, tmp1183,
	li	s7,4		# tmp1182,
	beq	s2,s7,.L223	#, tmp1179, tmp1182,
	li	s7,5		# tmp1181,
	beq	s2,s7,.L224	#, tmp1179, tmp1181,
	li	s7,6		# tmp1180,
	beq	s2,s7,.L225	#, tmp1179, tmp1180,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	t5,sp,128	#, tmp1926,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result1
	lbu	s8,1(a4)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(a4)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(a4)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(a4)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s4,16	#, ivtmp.640, ivtmp.647
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s8,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v24,s11,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v8,s7,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(t5)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	t5,vlenb	# tmp1920
	slli	t5,t5,4	#, tmp1921, tmp1920
	addi	t5,t5,128	#, tmp1922, tmp1919
	add	t5,t5,sp	#, tmp1919, tmp1919
	vl8re8.v	v0,0(t5)	# %sfp, result3
	csrr	t5,vlenb	# tmp1915
	slli	t5,t5,4	#, tmp1916, tmp1915
	addi	t5,t5,128	#, tmp1917, tmp1914
	add	t5,t5,sp	#, tmp1914, tmp1914
	vmacc.vx	v0,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v0,0(t5)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,a4,4	#, ivtmp.638, ivtmp.664
.L225:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s8,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,8	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v24,s11,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s11,sp,128	#, tmp1912,
	vl8re8.v	v0,0(s11)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v8,s7,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s7,vlenb	# tmp1906
	slli	s7,s7,4	#, tmp1907, tmp1906
	addi	s7,s7,128	#, tmp1908, tmp1905
	add	s7,s7,sp	#, tmp1905, tmp1905
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s8,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,t5,4	#, ivtmp.638, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s11)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v0,0(s7)	# %sfp, result3
	vmacc.vx	v0,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v0,0(s7)	# result3, %sfp
.L224:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s8,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,8	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v24,s11,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s11,sp,128	#, tmp1898,
	vl8re8.v	v0,0(s11)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v8,s7,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s7,vlenb	# tmp1892
	slli	s7,s7,4	#, tmp1893, tmp1892
	addi	s7,s7,128	#, tmp1894, tmp1891
	add	s7,s7,sp	#, tmp1891, tmp1891
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s8,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,t5,4	#, ivtmp.638, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s11)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v0,0(s7)	# %sfp, result3
	vmacc.vx	v0,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v0,0(s7)	# result3, %sfp
.L223:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s8,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,8	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v24,s11,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s11,sp,128	#, tmp1884,
	vl8re8.v	v0,0(s11)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v8,s7,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s7,vlenb	# tmp1878
	slli	s7,s7,4	#, tmp1879, tmp1878
	addi	s7,s7,128	#, tmp1880, tmp1877
	add	s7,s7,sp	#, tmp1877, tmp1877
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s8,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,t5,4	#, ivtmp.638, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s11)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v0,0(s7)	# %sfp, result3
	vmacc.vx	v0,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v0,0(s7)	# result3, %sfp
.L222:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s8,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,8	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v24,s11,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s11,sp,128	#, tmp1870,
	vl8re8.v	v0,0(s11)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v8,s7,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s7,vlenb	# tmp1864
	slli	s7,s7,4	#, tmp1865, tmp1864
	addi	s7,s7,128	#, tmp1866, tmp1863
	add	s7,s7,sp	#, tmp1863, tmp1863
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s8,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,t5,4	#, ivtmp.638, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s11)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v0,0(s7)	# %sfp, result3
	vmacc.vx	v0,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v0,0(s7)	# result3, %sfp
.L221:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s8,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,8	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v24,s11,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s11,sp,128	#, tmp1856,
	vl8re8.v	v0,0(s11)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v8,s7,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s7,vlenb	# tmp1850
	slli	s7,s7,4	#, tmp1851, tmp1850
	addi	s7,s7,128	#, tmp1852, tmp1849
	add	s7,s7,sp	#, tmp1849, tmp1849
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s8,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,t5,4	#, ivtmp.638, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s11)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v0,0(s7)	# %sfp, result3
	vmacc.vx	v0,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v0,0(s7)	# result3, %sfp
.L220:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s8,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,t5,4	#, ivtmp.638, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v24,s11,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s11,sp,128	#, tmp1842,
	vl8re8.v	v0,0(s11)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v8,s7,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s7,vlenb	# tmp1836
	slli	s7,s7,4	#, tmp1837, tmp1836
	addi	s7,s7,128	#, tmp1838, tmp1835
	add	s7,s7,sp	#, tmp1835, tmp1835
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s8,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,8	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s11)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v0,0(s7)	# %sfp, result3
	vmacc.vx	v0,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v0,0(s7)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	beq	t5,a2,.L6	#, ivtmp.638, ivtmp.665,
.L287:
	sd	a1,8(sp)	# _275, %sfp
	csrr	a1,vlenb	# tmp2410
	slli	a1,a1,3	#, tmp2411, tmp2410
	addi	a1,a1,128	#, tmp2412, tmp2409
	add	a1,a1,sp	#, tmp2409, tmp2409
	vs8r.v	v24,0(a1)	# result0, %sfp
	vmv8r.v	v0,v8	# result2, result2
	sd	s4,16(sp)	# ivtmp.647, %sfp
.L7:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	a1,vlenb	# tmp2405
	slli	a1,a1,3	#, tmp2406, tmp2405
	addi	a1,a1,128	#, tmp2407, tmp2404
	add	a1,a1,sp	#, tmp2404, tmp2404
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vl8re8.v	v8,0(a1)	# %sfp, result0
	lbu	s8,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
	csrr	a1,vlenb	# tmp2400
	slli	a1,a1,3	#, tmp2401, tmp2400
	addi	a1,a1,128	#, tmp2402, tmp2399
	add	a1,a1,sp	#, tmp2399, tmp2399
	vmacc.vx	v8,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s7,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(a1)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	a1,sp,128	#, tmp2397,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmv8r.v	v24,v0	# result2, result2
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	s11,t6,8	#, tmp1187, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s8,4(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v8,0(a1)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,6(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,16	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	lbu	s7,5(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
	vs8r.v	v8,0(a1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	a1,vlenb	# tmp2391
	slli	a1,a1,4	#, tmp2392, tmp2391
	addi	a1,a1,128	#, tmp2393, tmp2390
	add	a1,a1,sp	#, tmp2390, tmp2390
	vl8re8.v	v8,0(a1)	# %sfp, result3
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	a1,vlenb	# tmp2386
	slli	a1,a1,3	#, tmp2387, tmp2386
	addi	a1,a1,128	#, tmp2388, tmp2385
	add	a1,a1,sp	#, tmp2385, tmp2385
	vl8re8.v	v0,0(a1)	# %sfp, result0
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s11)	# A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	a1,vlenb	# tmp2381
	slli	a1,a1,3	#, tmp2382, tmp2381
	addi	a1,a1,128	#, tmp2383, tmp2380
	add	a1,a1,sp	#, tmp2380, tmp2380
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,7(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s8,8(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,10(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v0,0(a1)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	a1,sp,128	#, tmp2378,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	lbu	s2,11(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(a1)	# %sfp, result1
	vmacc.vx	v0,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	lbu	s7,9(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
	vs8r.v	v0,0(a1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	a1,t5,4	#, tmp1186, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	t5,vlenb	# tmp2372
	slli	t5,t5,3	#, tmp2373, tmp2372
	addi	t5,t5,128	#, tmp2374, tmp2371
	add	t5,t5,sp	#, tmp2371, tmp2371
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result0
	csrr	t5,vlenb	# tmp2367
	slli	t5,t5,3	#, tmp2368, tmp2367
	addi	t5,t5,128	#, tmp2369, tmp2366
	add	t5,t5,sp	#, tmp2366, tmp2366
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s11,16	#, ivtmp.640, tmp1187
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s8,8(a1)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,10(a1)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v0,0(t5)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	t5,sp,128	#, tmp2364,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result1
	vmacc.vx	v0,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	lbu	s7,9(a1)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
	vs8r.v	v0,0(t5)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	t5,vlenb	# tmp2358
	slli	t5,t5,3	#, tmp2359, tmp2358
	addi	t5,t5,128	#, tmp2360, tmp2357
	add	t5,t5,sp	#, tmp2357, tmp2357
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,11(a1)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result0
	csrr	t5,vlenb	# tmp2353
	slli	t5,t5,3	#, tmp2354, tmp2353
	addi	t5,t5,128	#, tmp2355, tmp2352
	add	t5,t5,sp	#, tmp2352, tmp2352
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s11,24	#, ivtmp.640, tmp1187
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s8,12(a1)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
	vs8r.v	v0,0(t5)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	t5,sp,128	#, tmp2350,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,14(a1)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,15(a1)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result1
	vmacc.vx	v0,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	lbu	s7,13(a1)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
	vs8r.v	v0,0(t5)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	t5,vlenb	# tmp2344
	slli	t5,t5,3	#, tmp2345, tmp2344
	addi	t5,t5,128	#, tmp2346, tmp2343
	add	t5,t5,sp	#, tmp2343, tmp2343
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result0
	csrr	t5,vlenb	# tmp2339
	slli	t5,t5,3	#, tmp2340, tmp2339
	addi	t5,t5,128	#, tmp2341, tmp2338
	add	t5,t5,sp	#, tmp2338, tmp2338
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s11,32	#, ivtmp.640, tmp1187
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s8,16(a1)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
	vs8r.v	v0,0(t5)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	t5,sp,128	#, tmp2336,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,18(a1)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,19(a1)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result1
	vmacc.vx	v0,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	lbu	s7,17(a1)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
	vs8r.v	v0,0(t5)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	t5,vlenb	# tmp2330
	slli	t5,t5,3	#, tmp2331, tmp2330
	addi	t5,t5,128	#, tmp2332, tmp2329
	add	t5,t5,sp	#, tmp2329, tmp2329
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result0
	csrr	t5,vlenb	# tmp2325
	slli	t5,t5,3	#, tmp2326, tmp2325
	addi	t5,t5,128	#, tmp2327, tmp2324
	add	t5,t5,sp	#, tmp2324, tmp2324
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s11,40	#, ivtmp.640, tmp1187
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s8,20(a1)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
	vs8r.v	v0,0(t5)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	t5,sp,128	#, tmp2322,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,22(a1)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,23(a1)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result1
	vmacc.vx	v0,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	lbu	s7,21(a1)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
	vs8r.v	v0,0(t5)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	t5,vlenb	# tmp2316
	slli	t5,t5,3	#, tmp2317, tmp2316
	addi	t5,t5,128	#, tmp2318, tmp2315
	add	t5,t5,sp	#, tmp2315, tmp2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vl8re8.v	v0,0(t5)	# %sfp, result0
	csrr	t5,vlenb	# tmp2311
	slli	t5,t5,3	#, tmp2312, tmp2311
	addi	t5,t5,128	#, tmp2313, tmp2310
	add	t5,t5,sp	#, tmp2310, tmp2310
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s11,48	#, ivtmp.640, tmp1187
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v0,0(t5)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	t5,sp,128	#, tmp2308,
	vl8re8.v	v0,0(t5)	# %sfp, result1
	vmacc.vx	v0,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	vs8r.v	v0,0(t5)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,a1,28	#, ivtmp.638, tmp1186
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:55:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t6)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s8,24(a1)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s7,25(a1)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,26(a1)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,27(a1)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	a1,vlenb	# tmp2302
	slli	a1,a1,3	#, tmp2303, tmp2302
	addi	a1,a1,128	#, tmp2304, tmp2301
	add	a1,a1,sp	#, tmp2301, tmp2301
	vl8re8.v	v0,0(a1)	# %sfp, result0
	csrr	a1,vlenb	# tmp2297
	slli	a1,a1,3	#, tmp2298, tmp2297
	addi	a1,a1,128	#, tmp2299, tmp2296
	add	a1,a1,sp	#, tmp2296, tmp2296
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v8,s2,v16	# result3, MEM[(FLOAT *)_697 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s8,v16	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s4,v16	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s11,56	#, ivtmp.640, tmp1187
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:58:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v0,0(a1)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:59:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	a1,sp,128	#, tmp2294,
	vl8re8.v	v0,0(a1)	# %sfp, result1
	vmacc.vx	v0,s7,v16	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	vs8r.v	v0,0(a1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:61:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	a1,vlenb	# tmp2288
	slli	a1,a1,4	#, tmp2289, tmp2288
	addi	a1,a1,128	#, tmp2290, tmp2287
	add	a1,a1,sp	#, tmp2287, tmp2287
	vs8r.v	v8,0(a1)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:60:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmv8r.v	v0,v24	# result2, result2
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:48:             for (BLASLONG k = 1; k < K; k++) {
	bne	t5,a2,.L7	#, ivtmp.638, ivtmp.665,
	csrr	t5,vlenb	# tmp2283
	slli	t5,t5,3	#, tmp2284, tmp2283
	addi	t5,t5,128	#, tmp2285, tmp2282
	add	t5,t5,sp	#, tmp2282, tmp2282
	vl8re8.v	v24,0(t5)	# %sfp, result0
	ld	a1,8(sp)		# _275, %sfp
	ld	s4,16(sp)		# ivtmp.647, %sfp
	vmv8r.v	v8,v0	# result2, result2
.L6:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:66:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(s3)	# c0,* ivtmp.648
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:70:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	t6,a1,s3	# ivtmp.648, _28, _275
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:72:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	t5,a1,s1	# ivtmp.649, _30, _275
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:75:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	addi	s2,sp,128	#, tmp2280,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s5,s5,1	#, i, i
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	s4,s4,t3	# _942, ivtmp.647, ivtmp.647
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:74:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v16,a3,v24	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:68:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v24,0(s1)	# c1,* ivtmp.649
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:74:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmv8r.v	v0,v16	# c0, c0
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:70:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(t6)	# c2,* _28
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:76:             c2 = __riscv_vmacc_vx_i8m8(c2, alpha, result2, gvl);
	vmacc.vx	v16,a3,v8	# c2, alpha, result2,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:72:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v8,0(t5)	# c3,* _30
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:81:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v0,0(s3)	# c0,* ivtmp.648,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s3,s3,8	#, ivtmp.648, ivtmp.648
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:75:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vl8re8.v	v0,0(s2)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:77:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	csrr	s2,vlenb	# tmp2276
	slli	s2,s2,4	#, tmp2277, tmp2276
	addi	s2,s2,128	#, tmp2278, tmp2275
	add	s2,s2,sp	#, tmp2275, tmp2275
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:75:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vmacc.vx	v24,a3,v0	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:77:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	vl8re8.v	v0,0(s2)	# %sfp, result3
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:83:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v24,0(s1)	# c1,* ivtmp.649,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s1,s1,8	#, ivtmp.649, ivtmp.649
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:77:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	vmacc.vx	v8,a3,v0	# c3, alpha, result3,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:85:             __riscv_vse8_v_i8m8(&C[ci], c2, gvl);
	vse8.v	v16,0(t6)	# c2,* _28,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:87:             __riscv_vse8_v_i8m8(&C[ci], c3, gvl);
	vse8.v	v8,0(t5)	# c3,* _30,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	s5,a6,.L8	#, i, _930,
	ld	t5,72(sp)		# m_top, %sfp
	mv	t6,t2	# ivtmp.660, ivtmp.660
	mv	t2,s6	# j, j
.L5:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:93:         if (M & 4) {
	ld	s1,40(sp)		# _32, %sfp
	bne	s1,zero,.L314	#, _32,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:156:         if (M & 2) {
	ld	s1,48(sp)		# _63, %sfp
	bne	s1,zero,.L315	#, _63,,
.L12:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:194:         if (M & 1) {
	ld	s1,56(sp)		# _183, %sfp
	bne	s1,zero,.L316	#, _183,,
.L15:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ld	s1,64(sp)		# _2047, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	addi	t2,t2,1	#, j, j
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a4,a4,t0	# _2056, ivtmp.664, ivtmp.664
	add	t6,t6,s1	# _2047, ivtmp.660, ivtmp.660
	ld	s1,32(sp)		# _901, %sfp
	add	a2,a2,t0	# _2056, ivtmp.665, ivtmp.665
	blt	t2,s1,.L18	#, j, _901,
	mv	s11,s9	# ldc, ldc
	ld	t5,112(sp)		# N, %sfp
	ld	s9,120(sp)		# B, %sfp
	slli	a0,s1,2	#, n_top, _901
.L2:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:225:     if (N & 2) {
	andi	a5,t5,2	#, _256, N
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:225:     if (N & 2) {
	beq	a5,zero,.L19	#, _256,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ld	a2,24(sp)		# M, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a4,7		# tmp969,
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t3,a2,63	#, tmp965, M
	andi	t3,t3,7	#, tmp966, tmp965
	add	t3,t3,a2	# M, tmp967, tmp966
	srai	t3,t3,3	#, _854, tmp967
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	a2,a4,.L52	#, M, tmp969,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:231:             BLASLONG bi = n_top * K;
	mul	s0,t1,a0	# bi, K, n_top
	slli	t0,t1,1	#, _1021, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	li	s3,1		# tmp978,
	add	t0,s9,t0	# _1021, _2300, B
	slli	s4,t1,3	#, _1929, K
	mv	t6,s10	# ivtmp.609, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t2,0		# i,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:255:             BLASLONG ci = n_top * ldc + m_top;
	mul	a7,s11,a0	# _270, ldc, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:233:             int8_t B1 = B[bi + 1];
	add	s1,s0,s3	#, _260, bi
	add	t0,t0,s0	# bi, _1023, _2300
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:232:             int8_t B0 = B[bi + 0];
	add	s2,s9,s0	# bi, _259, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:233:             int8_t B1 = B[bi + 1];
	add	s1,s9,s1	# _260, _261, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:234:             bi += 2;
	addi	s0,s0,2	#, bi, bi
	add	a7,t4,a7	# _270, ivtmp.610, C
.L23:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:236:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(t6)	# A0,* ivtmp.609
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:239:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	a2,0(s2)	# *_259, *_259
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:240:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	a4,0(s1)	# *_261, *_261
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:239:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v16,v8,a2	# result0, A0, *_259,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:240:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v8,v8,a4	# result1, A0, *_261,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,s3,.L21	#, K, tmp978,
	add	a4,s9,s0	# bi, ivtmp.598, B
	sub	a1,t0,a4	# tmp1150, _1023, ivtmp.598
	addi	a1,a1,-2	#, tmp1151, tmp1150
	srli	a1,a1,1	#, tmp1149, tmp1151
	addi	a1,a1,1	#, tmp1152, tmp1149
	andi	a1,a1,7	#, tmp1153, tmp1152
	addi	a2,t6,8	#, ivtmp.600, ivtmp.609
	beq	a1,zero,.L293	#, tmp1153,,
	li	a6,1		# tmp1159,
	beq	a1,a6,.L232	#, tmp1153, tmp1159,
	li	a6,2		# tmp1158,
	beq	a1,a6,.L233	#, tmp1153, tmp1158,
	li	a6,3		# tmp1157,
	beq	a1,a6,.L234	#, tmp1153, tmp1157,
	li	a6,4		# tmp1156,
	beq	a1,a6,.L235	#, tmp1153, tmp1156,
	li	a6,5		# tmp1155,
	beq	a1,a6,.L236	#, tmp1153, tmp1155,
	li	a6,6		# tmp1154,
	beq	a1,a6,.L237	#, tmp1153, tmp1154,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,t6,16	#, ivtmp.600, ivtmp.609
	addi	a4,a4,2	#, ivtmp.598, ivtmp.598
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
.L237:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,8	#, ivtmp.600, ivtmp.600
	addi	a4,a4,2	#, ivtmp.598, ivtmp.598
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
.L236:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,8	#, ivtmp.600, ivtmp.600
	addi	a4,a4,2	#, ivtmp.598, ivtmp.598
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
.L235:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,8	#, ivtmp.600, ivtmp.600
	addi	a4,a4,2	#, ivtmp.598, ivtmp.598
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
.L234:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,8	#, ivtmp.600, ivtmp.600
	addi	a4,a4,2	#, ivtmp.598, ivtmp.598
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
.L233:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,8	#, ivtmp.600, ivtmp.600
	addi	a4,a4,2	#, ivtmp.598, ivtmp.598
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
.L232:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,2	#, ivtmp.598, ivtmp.598
	addi	a2,a2,8	#, ivtmp.600, ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	beq	a4,t0,.L21	#, ivtmp.598, _1023,
.L293:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	s6,a2,8	#, tmp1161, ivtmp.600
	addi	a2,a2,16	#, ivtmp.600, ivtmp.600
	addi	s5,a4,2	#, tmp1160, ivtmp.598
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(s6)	# A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,2(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,3(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,4(a4)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,5(a4)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s6,16	#, ivtmp.600, tmp1161
	addi	a4,s5,14	#, ivtmp.598, tmp1160
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,4(s5)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,5(s5)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s6,24	#, ivtmp.600, tmp1161
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,6(s5)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,7(s5)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s6,32	#, ivtmp.600, tmp1161
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,8(s5)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,9(s5)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s6,40	#, ivtmp.600, tmp1161
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,10(s5)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,11(s5)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s6,48	#, ivtmp.600, tmp1161
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:248:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a2)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,12(s5)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,13(s5)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,s6,56	#, ivtmp.600, tmp1161
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:251:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:252:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:243:             for (BLASLONG k = 1; k < K; k++) {
	bne	a4,t0,.L293	#, ivtmp.598, _1023,
.L21:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:257:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v0,0(a7)	# c0,* ivtmp.610
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:259:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a4,s11,a7	# ivtmp.610, _274, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:259:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v24,0(a4)	# c1,* _274
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t2,t2,1	#, i, i
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	t6,t6,s4	# _1929, ivtmp.609, ivtmp.609
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:261:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v0,a3,v16	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:262:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vmacc.vx	v24,a3,v8	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:266:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v0,0(a7)	# c0,* ivtmp.610,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a7,a7,8	#, ivtmp.610, ivtmp.610
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:268:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v24,0(a4)	# c1,* _274,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:229:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	t2,t3,.L23	#, i, _854,
	slli	t3,t3,3	#, m_top, _854
.L20:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:272:         if (M & 4) {
	ld	a5,24(sp)		# M, %sfp
	andi	a5,a5,4	#, _276, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:272:         if (M & 4) {
	beq	a5,zero,.L24	#, _276,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:275:             BLASLONG ai = m_top * K;
	mul	a4,t1,t3	# ai, K, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:273:             gvl = __riscv_vsetvl_e8m8(4);
	vsetivli	zero,4,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	li	a6,1		# tmp991,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:276:             BLASLONG bi = n_top * K;
	mul	a1,t1,a0	# bi, K, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:281:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	add	a2,s10,a4	# ai, _283, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:281:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(a2)	# A0,* _283
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:282:             ai += 4;
	addi	a4,a4,4	#, ai, ai
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:277:             int8_t B0 = B[bi + 0];
	add	a2,s9,a1	# bi, tmp985, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:284:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	a7,0(a2)	# *_279, *_279
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:285:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	a2,1(a2)	# *_281, *_281
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:284:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v16,v8,a7	# result0, A0, *_279,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:285:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v8,v8,a2	# result1, A0, *_281,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:279:             bi += 2;
	addi	a2,a1,2	#, bi, bi
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,a6,.L25	#, K, tmp991,
	slli	t6,t1,1	#, _311, K
	add	t6,s9,t6	# _311, _2278, B
	add	a2,s9,a2	# bi, ivtmp.582, B
	add	t6,t6,a1	# bi, _310, _2278
	sub	a1,t6,a2	# tmp1137, _310, ivtmp.582
	addi	a1,a1,-2	#, tmp1138, tmp1137
	srli	a1,a1,1	#, tmp1136, tmp1138
	add	a1,a1,a6	#, tmp1139, tmp1136
	andi	a1,a1,7	#, tmp1140, tmp1139
	add	a4,s10,a4	# ai, ivtmp.584, A
	beq	a1,zero,.L292	#, tmp1140,,
	beq	a1,a6,.L238	#, tmp1140, tmp991,
	li	a6,2		# tmp1145,
	beq	a1,a6,.L239	#, tmp1140, tmp1145,
	li	a6,3		# tmp1144,
	beq	a1,a6,.L240	#, tmp1140, tmp1144,
	li	a6,4		# tmp1143,
	beq	a1,a6,.L241	#, tmp1140, tmp1143,
	li	a6,5		# tmp1142,
	beq	a1,a6,.L242	#, tmp1140, tmp1142,
	li	a6,6		# tmp1141,
	bne	a1,a6,.L317	#, tmp1140, tmp1141,
.L243:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,4	#, ivtmp.584, ivtmp.584
	addi	a2,a2,2	#, ivtmp.582, ivtmp.582
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
.L242:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,4	#, ivtmp.584, ivtmp.584
	addi	a2,a2,2	#, ivtmp.582, ivtmp.582
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
.L241:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,4	#, ivtmp.584, ivtmp.584
	addi	a2,a2,2	#, ivtmp.582, ivtmp.582
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
.L240:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,4	#, ivtmp.584, ivtmp.584
	addi	a2,a2,2	#, ivtmp.582, ivtmp.582
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
.L239:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,4	#, ivtmp.584, ivtmp.584
	addi	a2,a2,2	#, ivtmp.582, ivtmp.582
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
.L238:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,2	#, ivtmp.582, ivtmp.582
	addi	a4,a4,4	#, ivtmp.584, ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	beq	t6,a2,.L25	#, _310, ivtmp.582,
.L292:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	t0,a4,4	#, tmp1148, ivtmp.584
	addi	a4,a4,8	#, ivtmp.584, ivtmp.584
	addi	a7,a2,2	#, tmp1147, ivtmp.582
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(t0)	# A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,2(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,3(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,4(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,5(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,8	#, ivtmp.584, tmp1148
	addi	a2,a7,14	#, ivtmp.582, tmp1147
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,4(a7)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,5(a7)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,12	#, ivtmp.584, tmp1148
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,6(a7)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,7(a7)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,16	#, ivtmp.584, tmp1148
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,8(a7)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,9(a7)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,20	#, ivtmp.584, tmp1148
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,10(a7)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,11(a7)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,24	#, ivtmp.584, tmp1148
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,12(a7)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,13(a7)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,28	#, ivtmp.584, tmp1148
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	bne	t6,a2,.L292	#, _310, ivtmp.582,
.L25:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:300:             BLASLONG ci = n_top * ldc + m_top;
	mul	a4,s11,a0	# _290, ldc, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:300:             BLASLONG ci = n_top * ldc + m_top;
	add	a4,a4,t3	# m_top, ci, _290
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:302:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a2,t4,a4	# ci, _292, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:302:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v24,0(a2)	# c0,* _292
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:303:             ci += ldc - gvl * 0;
	add	a4,s11,a4	# ci, ci_603, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:304:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a4,t4,a4	# ci_603, _294, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:304:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v0,0(a4)	# c1,* _294
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:314:             m_top += 4;
	addi	t3,t3,4	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:306:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v24,a3,v16	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:307:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vmacc.vx	v0,a3,v8	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:311:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v24,0(a2)	# c0,* _292,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:313:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v0,0(a4)	# c1,* _294,
.L24:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:317:         if (M & 2) {
	ld	a5,24(sp)		# M, %sfp
	andi	a5,a5,2	#, _295, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:317:         if (M & 2) {
	beq	a5,zero,.L27	#, _295,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:322:             BLASLONG ai = m_top * K;
	mul	a1,t3,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a7,a3,0xff	# _2315, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:323:             BLASLONG bi = n_top * K;
	mul	a2,t1,a0	# bi, K, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:326:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L53	#, K,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp800,,,,
	vmv.v.i	v1,0	# vect_result3_1021.369,
	add	a1,s10,a1	# ai, vectp.371, A
	add	a2,s9,a2	# bi, vectp.377, B
	vmv1r.v	v8,v1	# vect_result3_1021.369, vect_result2_1019.368
	vmv1r.v	v7,v1	# vect_result3_1021.369, vect_result1_1017.367
	vmv1r.v	v6,v1	# vect_result3_1021.369, vect_result0_1015.366
	mv	a4,t1	# bnd.365, K
.L29:
	vsetvli	a5,a4,e8,m1,tu,ma	# bnd.365, _2042,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:327:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v4,(a1)	# vect_array.372, vectp.371,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:327:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v2,(a2)	# vect_array.378, vectp.377,
	slli	a6,a5,1	#, ivtmp_2102, _2042
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:326:             for (BLASLONG k = 0; k < K; k++) {
	sub	a4,a4,a5	# bnd.365, bnd.365, _2042
	add	a1,a1,a6	# ivtmp_2102, vectp.371, vectp.371
	add	a2,a2,a6	# ivtmp_2102, vectp.377, vectp.377
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:327:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v6,v4,v2	# vect_result0_1015.366, vect_array.372, vect_array.378,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:328:                 result1 += A[ai + 1] * B[bi + 0];
	vmacc.vv	v7,v5,v2	# vect_result1_1017.367, vect_array.372, vect_array.378,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:329:                 result2 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v8,v4,v3	# vect_result2_1019.368, vect_array.372, vect_array.378,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:330:                 result3 += A[ai + 1] * B[bi + 1];
	vmacc.vv	v1,v5,v3	# vect_result3_1021.369, vect_array.372, vect_array.378,
	bne	a4,zero,.L29	#, bnd.365,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp1222,,,,
	li	t6,0		# tmp1223,
	vmv.s.x	v5,t6	# tmp1221, tmp1223
	vredsum.vs	v1,v1,v5	# tmp1224, vect_result3_1021.369, tmp1221,
	vredsum.vs	v8,v8,v5	# tmp1229, vect_result2_1019.368, tmp1226,
	vredsum.vs	v7,v7,v5	# tmp1234, vect_result1_1017.367, tmp1231,
	vredsum.vs	v6,v6,v5	# tmp1239, vect_result0_1015.366, tmp1236,
	vmv.x.s	a4,v1	# tmp1001, tmp1224
	vmv.x.s	a2,v8	# tmp1002, tmp1229
	vmv.x.s	a1,v7	# tmp1003, tmp1234
	vmv.x.s	a6,v6	# tmp1004, tmp1239
	andi	a4,a4,0xff	# _2050, tmp1001
	andi	a2,a2,0xff	# _2060, tmp1002
	andi	a1,a1,0xff	# _2071, tmp1003
	andi	a6,a6,0xff	# _2082, tmp1004
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:339:             C[ci + 1 * ldc + 1] += alpha * result3;
	mulw	a4,a4,a7	# tmp1012, _2050, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:338:             C[ci + 1 * ldc + 0] += alpha * result2;
	mulw	a2,a2,a7	# tmp1010, _2060, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:339:             C[ci + 1 * ldc + 1] += alpha * result3;
	andi	a4,a4,0xff	# _2171, tmp1012
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:337:             C[ci + 0 * ldc + 1] += alpha * result1;
	mulw	a1,a1,a7	# tmp1008, _2071, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:338:             C[ci + 1 * ldc + 0] += alpha * result2;
	andi	a2,a2,0xff	# _2168, tmp1010
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a6,a6,a7	# tmp1006, _2082, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:337:             C[ci + 0 * ldc + 1] += alpha * result1;
	andi	a1,a1,0xff	# _2165, tmp1008
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a6,a6,0xff	# _2162, tmp1006
.L28:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:335:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s11,a0	# _324, ldc, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:335:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,t3	# m_top, ci, _324
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	t0,t4,a5	# ci, _326, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	t6,0(t0)	# *_326, *_326
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:337:             C[ci + 0 * ldc + 1] += alpha * result1;
	add	a7,t4,a5	# _334, _335, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:338:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	a5,s11,a5	# ci, _343, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	a6,t6,a6	# _2162, tmp1017, *_326
	sb	a6,0(t0)	# tmp1017, *_326
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:337:             C[ci + 0 * ldc + 1] += alpha * result1;
	lbu	a6,1(a7)	# *_335, *_335
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:338:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	t6,t4,a5	# _343, _344, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:339:             C[ci + 1 * ldc + 1] += alpha * result3;
	add	a5,t4,a5	# _351, _352, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:337:             C[ci + 0 * ldc + 1] += alpha * result1;
	addw	a1,a6,a1	# _2165, tmp1022, *_335
	sb	a1,1(a7)	# tmp1022, *_335
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:338:             C[ci + 1 * ldc + 0] += alpha * result2;
	lbu	a1,0(t6)	# *_344, *_344
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:340:             m_top += 2;
	addi	t3,t3,2	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:338:             C[ci + 1 * ldc + 0] += alpha * result2;
	addw	a2,a1,a2	# _2168, tmp1026, *_344
	sb	a2,0(t6)	# tmp1026, *_344
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:339:             C[ci + 1 * ldc + 1] += alpha * result3;
	lbu	a2,1(a5)	# *_352, *_352
	addw	a4,a2,a4	# _2171, tmp1031, *_352
	sb	a4,1(a5)	# tmp1031, *_352
.L27:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:343:         if (M & 1) {
	ld	a5,24(sp)		# M, %sfp
	andi	a5,a5,1	#, _359, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:343:         if (M & 1) {
	beq	a5,zero,.L30	#, _359,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:346:             BLASLONG ai = m_top * K;
	mul	a6,t3,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a7,a3,0xff	# _2314, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:347:             BLASLONG bi = n_top * K;
	mul	a2,t1,a0	# bi, K, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:350:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L54	#, K,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp804,,,,
	vmv.v.i	v1,0	# vect_result1_1028.339,
	addi	a1,a2,1	#, _2127, bi
	add	a6,s10,a6	# ai, vectp.341, A
	vmv1r.v	v2,v1	# vect_result1_1028.339, vect_result0_1026.338
	add	a1,s9,a1	# _2127, vectp.355, B
	add	a2,s9,a2	# bi, vectp.345, B
	mv	a4,t1	# bnd.337, K
.L32:
	vsetvli	a5,a4,e8,m1,tu,ma	# bnd.337, _2110,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:351:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v3,0(a6)	# vect__362.342,* vectp.341
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:351:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v5,0(a2)	# vect__366.346,* vectp.345
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:352:                 result1 += A[ai + 0] * B[bi + 1];
	vle8.v	v4,0(a1)	# vect__373.356,* vectp.355
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:350:             for (BLASLONG k = 0; k < K; k++) {
	sub	a4,a4,a5	# bnd.337, bnd.337, _2110
	add	a6,a6,a5	# _2110, vectp.341, vectp.341
	add	a2,a2,a5	# _2110, vectp.345, vectp.345
	add	a1,a1,a5	# _2110, vectp.355, vectp.355
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:351:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v2,v5,v3	# vect_result0_1026.338, vect__366.346, vect__362.342,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:352:                 result1 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v1,v4,v3	# vect_result1_1028.339, vect__373.356, vect__362.342,
	bne	a4,zero,.L32	#, bnd.337,,
	vsetvli	a4,zero,e8,m1,ta,ma	#, tmp1212,,,,
	li	a1,0		# tmp1213,
	vmv.s.x	v4,a1	# tmp1211, tmp1213
	vredsum.vs	v1,v1,v4	# tmp1214, vect_result1_1028.339, tmp1211,
	vredsum.vs	v2,v2,v4	# tmp1219, vect_result0_1026.338, tmp1216,
	vmv.x.s	a4,v1	# tmp1034, tmp1214
	vmv.x.s	a2,v2	# tmp1035, tmp1219
	andi	a4,a4,0xff	# _2118, tmp1034
	andi	a2,a2,0xff	# _2136, tmp1035
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:359:             C[ci + 1 * ldc + 0] += alpha * result1;
	mulw	a4,a4,a7	# tmp1039, _2118, _2314
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:358:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a2,a2,a7	# tmp1037, _2136, _2314
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:359:             C[ci + 1 * ldc + 0] += alpha * result1;
	andi	a4,a4,0xff	# _2212, tmp1039
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:358:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a2,a2,0xff	# _2209, tmp1037
.L31:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:357:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s11,a0	# _378, ldc, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:357:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,t3	# m_top, ci, _378
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:358:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	a6,t4,a5	# ci, _380, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:358:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	a1,0(a6)	# *_380, *_380
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:359:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,s11,a5	# ci, _388, ldc
	add	a5,t4,a5	# _388, _390, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:358:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	a2,a1,a2	# _2209, tmp1044, *_380
	sb	a2,0(a6)	# tmp1044, *_380
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:359:             C[ci + 1 * ldc + 0] += alpha * result1;
	lbu	a2,0(a5)	# *_390, *_390
	addw	a4,a2,a4	# _2212, tmp1049, *_390
	sb	a4,0(a5)	# tmp1049, *_390
.L30:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:363:         n_top += 2;
	addi	a0,a0,2	#, n_top, n_top
.L19:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:368:     if (N & 1) {
	andi	a5,t5,1	#, _397, N
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:368:     if (N & 1) {
	beq	a5,zero,.L279	#, _397,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ld	a2,24(sp)		# M, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a4,7		# tmp1057,
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a1,a2,63	#, tmp1053, M
	andi	a1,a1,7	#, tmp1054, tmp1053
	add	a1,a1,a2	# M, tmp1055, tmp1054
	srai	t6,a1,3	#, _877, tmp1055
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	a2,a4,.L55	#, M, tmp1057,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:374:             BLASLONG bi = n_top * K;
	mul	a4,a0,t1	# bi.226_399, n_top, K
	add	t3,s9,t1	# K, _2276, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	li	s1,1		# tmp1061,
	slli	s2,t1,3	#, _972, K
	mv	a7,s10	# ivtmp.567, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t5,0		# i,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:394:             BLASLONG ci = n_top * ldc + m_top;
	mul	a6,a0,s11	# _407, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:375:             int8_t B0 = B[bi + 0];
	add	s0,s9,a4	# bi.226_399, _400, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:376:             bi += 1;
	add	t2,a4,s1	#, bi, bi.226_399
	add	t3,t3,a4	# bi.226_399, _66, _2276
	add	a6,t4,a6	# _407, ivtmp.568, C
.L38:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:378:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(a7)	# A0,* ivtmp.567
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:381:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	a4,0(s0)	# *_400, *_400
	vmul.vx	v8,v8,a4	# result0, A0, *_400,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,s1,.L36	#, K, tmp1061,
	add	a2,s9,t2	# bi, ivtmp.558, B
	sub	a1,t3,a2	# tmp1126, _66, ivtmp.558
	andi	a1,a1,7	#, tmp1127, tmp1126
	addi	a4,a7,8	#, ivtmp.560, ivtmp.567
	beq	a1,zero,.L291	#, tmp1127,,
	li	t0,1		# tmp1133,
	beq	a1,t0,.L244	#, tmp1127, tmp1133,
	li	t0,2		# tmp1132,
	beq	a1,t0,.L245	#, tmp1127, tmp1132,
	li	t0,3		# tmp1131,
	beq	a1,t0,.L246	#, tmp1127, tmp1131,
	li	t0,4		# tmp1130,
	beq	a1,t0,.L247	#, tmp1127, tmp1130,
	li	t0,5		# tmp1129,
	beq	a1,t0,.L248	#, tmp1127, tmp1129,
	li	t0,6		# tmp1128,
	beq	a1,t0,.L249	#, tmp1127, tmp1128,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a7,16	#, ivtmp.560, ivtmp.567
	addi	a2,a2,1	#, ivtmp.558, ivtmp.558
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
.L249:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,8	#, ivtmp.560, ivtmp.560
	addi	a2,a2,1	#, ivtmp.558, ivtmp.558
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
.L248:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,8	#, ivtmp.560, ivtmp.560
	addi	a2,a2,1	#, ivtmp.558, ivtmp.558
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
.L247:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,8	#, ivtmp.560, ivtmp.560
	addi	a2,a2,1	#, ivtmp.558, ivtmp.558
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
.L246:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,8	#, ivtmp.560, ivtmp.560
	addi	a2,a2,1	#, ivtmp.558, ivtmp.558
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
.L245:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,8	#, ivtmp.560, ivtmp.560
	addi	a2,a2,1	#, ivtmp.558, ivtmp.558
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
.L244:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a2,1	#, ivtmp.558, ivtmp.558
	addi	a4,a4,8	#, ivtmp.560, ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	beq	t3,a2,.L36	#, _66, ivtmp.558,
.L291:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,0(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	t0,a4,8	#, tmp1135, ivtmp.560
	addi	a4,a4,16	#, ivtmp.560, ivtmp.560
	addi	a2,a2,8	#, ivtmp.558, ivtmp.558
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t0)	# A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,-7(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,-6(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,16	#, ivtmp.560, tmp1135
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,-5(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,24	#, ivtmp.560, tmp1135
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,-4(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,32	#, ivtmp.560, tmp1135
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,-3(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,40	#, ivtmp.560, tmp1135
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,-2(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,48	#, ivtmp.560, tmp1135
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:388:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a1,-1(a2)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,56	#, ivtmp.560, tmp1135
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:391:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:384:             for (BLASLONG k = 1; k < K; k++) {
	bne	t3,a2,.L291	#, _66, ivtmp.558,
.L36:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:396:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(a6)	# c0,* ivtmp.568
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t5,t5,1	#, i, i
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a7,a7,s2	# _972, ivtmp.567, ivtmp.567
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:397:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v16,a3,v8	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:401:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v16,0(a6)	# c0,* ivtmp.568,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:372:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a6,a6,8	#, ivtmp.568, ivtmp.568
	blt	t5,t6,.L38	#, i, _877,
	slli	a1,t6,3	#, m_top, _877
.L35:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:405:         if (M & 4) {
	ld	a5,24(sp)		# M, %sfp
	andi	a5,a5,4	#, _411, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:405:         if (M & 4) {
	beq	a5,zero,.L39	#, _411,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:408:             BLASLONG ai = m_top * K;
	mul	a5,t1,a1	# ai, K, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:406:             gvl = __riscv_vsetvl_e8m8(4);
	vsetivli	zero,4,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	li	t3,1		# tmp1070,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:409:             BLASLONG bi = n_top * K;
	mul	a6,a0,t1	# bi, n_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:413:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	add	a4,s10,a5	# ai, _416, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:413:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(a4)	# A0,* _416
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:414:             ai += 4;
	addi	a5,a5,4	#, ai, ai
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:410:             int8_t B0 = B[bi + 0];
	add	a4,s9,a6	# bi, tmp1067, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:416:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	a7,0(a4)	# *_414, *_414
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:411:             bi += 1;
	add	a4,a6,t3	#, bi, bi
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:416:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v8,v8,a7	# result0, A0, *_414,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,t3,.L40	#, K, tmp1070,
	add	a7,s9,t1	# K, _2275, B
	add	a4,s9,a4	# bi, ivtmp.544, B
	add	a7,a7,a6	# bi, _82, _2275
	sub	a6,a7,a4	# tmp1114, _82, ivtmp.544
	andi	a6,a6,7	#, tmp1115, tmp1114
	add	a5,s10,a5	# ai, ivtmp.546, A
	beq	a6,zero,.L290	#, tmp1115,,
	beq	a6,t3,.L250	#, tmp1115, tmp1070,
	li	t3,2		# tmp1120,
	beq	a6,t3,.L251	#, tmp1115, tmp1120,
	li	t3,3		# tmp1119,
	beq	a6,t3,.L252	#, tmp1115, tmp1119,
	li	t3,4		# tmp1118,
	beq	a6,t3,.L253	#, tmp1115, tmp1118,
	li	t3,5		# tmp1117,
	beq	a6,t3,.L254	#, tmp1115, tmp1117,
	li	t3,6		# tmp1116,
	bne	a6,t3,.L318	#, tmp1115, tmp1116,
.L255:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
	addi	a4,a4,1	#, ivtmp.544, ivtmp.544
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
.L254:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
	addi	a4,a4,1	#, ivtmp.544, ivtmp.544
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
.L253:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
	addi	a4,a4,1	#, ivtmp.544, ivtmp.544
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
.L252:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
	addi	a4,a4,1	#, ivtmp.544, ivtmp.544
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
.L251:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
	addi	a4,a4,1	#, ivtmp.544, ivtmp.544
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
.L250:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,1	#, ivtmp.544, ivtmp.544
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	beq	a7,a4,.L40	#, _82, ivtmp.544,
.L290:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	t3,a5,4	#, tmp1123, ivtmp.546
	addi	a5,a5,8	#, ivtmp.546, ivtmp.546
	addi	a4,a4,8	#, ivtmp.544, ivtmp.544
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(t3)	# A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,-7(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,-6(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,t3,8	#, ivtmp.546, tmp1123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,-5(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,t3,12	#, ivtmp.546, tmp1123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,-4(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,t3,16	#, ivtmp.546, tmp1123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,-3(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,t3,20	#, ivtmp.546, tmp1123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,-2(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,t3,24	#, ivtmp.546, tmp1123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,-1(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,t3,28	#, ivtmp.546, tmp1123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	bne	a7,a4,.L290	#, _82, ivtmp.544,
.L40:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:429:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,a0,s11	# _421, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:429:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a1	# m_top, ci_679, _421
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:431:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a5,t4,a5	# ci_679, _423, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:431:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(a5)	# c0,* _423
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:437:             m_top += 4;
	addi	a1,a1,4	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:432:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v16,a3,v8	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:436:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v16,0(a5)	# c0,* _423,
.L39:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:440:         if (M & 2) {
	ld	a5,24(sp)		# M, %sfp
	andi	a5,a5,2	#, _424, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:440:         if (M & 2) {
	beq	a5,zero,.L42	#, _424,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:443:             BLASLONG ai = m_top * K;
	mul	a6,a1,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a7,a3,0xff	# _2313, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:444:             BLASLONG bi = n_top * K;
	mul	a2,a0,t1	# bi, n_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:447:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L56	#, K,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp806,,,,
	vmv.v.i	v1,0	# vect_result1_1046.312,
	add	a6,s10,a6	# ai, vectp.314, A
	add	a2,s9,a2	# bi, vectp.320, B
	vmv1r.v	v2,v1	# vect_result1_1046.312, vect_result0_1044.311
	mv	a4,t1	# bnd.310, K
.L44:
	vsetvli	a5,a4,e8,m1,tu,ma	# bnd.310, _2175,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:448:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v4,(a6)	# vect_array.315, vectp.314,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:448:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v3,0(a2)	# vect__431.321,* vectp.320
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:447:             for (BLASLONG k = 0; k < K; k++) {
	slli	t3,a5,1	#, ivtmp_2222, _2175
	sub	a4,a4,a5	# bnd.310, bnd.310, _2175
	add	a2,a2,a5	# _2175, vectp.320, vectp.320
	add	a6,a6,t3	# ivtmp_2222, vectp.314, vectp.314
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:448:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v2,v3,v4	# vect_result0_1044.311, vect__431.321, vect_array.315,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:449:                 result1 += A[ai + 1] * B[bi + 0];
	vmacc.vv	v1,v3,v5	# vect_result1_1046.312, vect__431.321, vect_array.315,
	bne	a4,zero,.L44	#, bnd.310,,
	vsetvli	a4,zero,e8,m1,ta,ma	#, tmp1202,,,,
	li	a6,0		# tmp1203,
	vmv.s.x	v4,a6	# tmp1201, tmp1203
	vredsum.vs	v1,v1,v4	# tmp1204, vect_result1_1046.312, tmp1201,
	vredsum.vs	v2,v2,v4	# tmp1209, vect_result0_1044.311, tmp1206,
	vmv.x.s	a4,v1	# tmp1078, tmp1204
	vmv.x.s	a2,v2	# tmp1079, tmp1209
	andi	a4,a4,0xff	# _2183, tmp1078
	andi	a2,a2,0xff	# _2194, tmp1079
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:456:             C[ci + 0 * ldc + 1] += alpha * result1;
	mulw	a4,a4,a7	# tmp1083, _2183, _2313
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:455:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a2,a2,a7	# tmp1081, _2194, _2313
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:456:             C[ci + 0 * ldc + 1] += alpha * result1;
	andi	a4,a4,0xff	# _2287, tmp1083
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:455:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a2,a2,0xff	# _2284, tmp1081
.L43:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:454:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,a0,s11	# _443, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:454:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a1	# m_top, ci.258_444, _443
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:455:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	a7,t4,a5	# ci.258_444, _445, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:455:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	a6,0(a7)	# *_445, *_445
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:456:             C[ci + 0 * ldc + 1] += alpha * result1;
	add	a5,t4,a5	# _453, _454, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:457:             m_top += 2;
	addi	a1,a1,2	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:455:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	a2,a6,a2	# _2284, tmp1088, *_445
	sb	a2,0(a7)	# tmp1088, *_445
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:456:             C[ci + 0 * ldc + 1] += alpha * result1;
	lbu	a2,1(a5)	# *_454, *_454
	addw	a4,a2,a4	# _2287, tmp1093, *_454
	sb	a4,1(a5)	# tmp1093, *_454
.L42:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:460:         if (M & 1) {
	ld	a5,24(sp)		# M, %sfp
	andi	a5,a5,1	#, _461, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:460:         if (M & 1) {
	beq	a5,zero,.L279	#, _461,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:462:             BLASLONG ai = m_top * K;
	mul	a2,a1,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:336:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a3,a3,0xff	# _2312, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:463:             BLASLONG bi = n_top * K;
	mul	a4,a0,t1	# bi, n_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:466:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L57	#, K,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp808,,,,
	vmv.v.i	v1,0	# vect_result0_1051.294,
	add	a2,s10,a2	# ai, vectp.296, A
	add	a4,s9,a4	# bi, vectp.300, B
.L47:
	vsetvli	a5,t1,e8,m1,tu,ma	# bnd.293, _2228,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:467:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v2,0(a2)	# vect__464.297,* vectp.296
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:467:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v3,0(a4)	# vect__468.301,* vectp.300
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:466:             for (BLASLONG k = 0; k < K; k++) {
	sub	t1,t1,a5	# bnd.293, bnd.293, _2228
	add	a2,a2,a5	# _2228, vectp.296, vectp.296
	add	a4,a4,a5	# _2228, vectp.300, vectp.300
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:467:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v1,v3,v2	# vect_result0_1051.294, vect__468.301, vect__464.297,
	bne	t1,zero,.L47	#, bnd.293,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp1197,,,,
	li	a4,0		# tmp1198,
	vmv.s.x	v2,a4	# tmp1196, tmp1198
	vredsum.vs	v1,v1,v2	# tmp1199, vect_result0_1051.294, tmp1196,
	vmv.x.s	a5,v1	# tmp1095, tmp1199
	andi	a5,a5,0xff	# _2236, tmp1095
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:473:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a5,a5,a3	# tmp1097, _2236, _2312
	andi	a5,a5,0xff	# _2308, tmp1097
.L46:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:472:             BLASLONG ci = n_top * ldc + m_top;
	mul	a4,a0,s11	# _473, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:472:             BLASLONG ci = n_top * ldc + m_top;
	add	a4,a4,a1	# m_top, ci_703, _473
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:473:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	a4,t4,a4	# ci_703, _475, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:473:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	a3,0(a4)	# *_475, *_475
	addw	a5,a3,a5	# _2308, tmp1103, *_475
	sb	a5,0(a4)	# tmp1103, *_475
.L279:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:481: }
	csrr	t0,vlenb	#
	slli	t1,t0,5	#,,
	add	sp,sp,t1	#,,
	.cfi_remember_state
	.cfi_def_cfa_offset 224
	ld	s0,216(sp)		#,
	.cfi_restore 8
	ld	s1,208(sp)		#,
	.cfi_restore 9
	ld	s2,200(sp)		#,
	.cfi_restore 18
	ld	s3,192(sp)		#,
	.cfi_restore 19
	ld	s4,184(sp)		#,
	.cfi_restore 20
	ld	s5,176(sp)		#,
	.cfi_restore 21
	ld	s6,168(sp)		#,
	.cfi_restore 22
	ld	s7,160(sp)		#,
	.cfi_restore 23
	ld	s8,152(sp)		#,
	.cfi_restore 24
	ld	s9,144(sp)		#,
	.cfi_restore 25
	ld	s10,136(sp)		#,
	.cfi_restore 26
	ld	s11,128(sp)		#,
	.cfi_restore 27
	li	a0,0		#,
	addi	sp,sp,224	#,,
	.cfi_def_cfa_offset 0
	jr	ra		#
.L316:
	.cfi_restore_state
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:199:             BLASLONG ai = m_top * K;
	mul	s3,t5,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:203:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L51	#, K,,
	vsetvli	s1,zero,e8,m1,ta,ma	#, tmp1111,,,,
	vmv.v.i	v2,0	# vect_result3_995.413,
	add	s3,s10,s3	# ai, vectp.415, A
	addi	s4,a4,-4	#, vectp.419, ivtmp.664
	vmv1r.v	v9,v2	# vect_result3_995.413, vect_result2_993.412
	vmv1r.v	v8,v2	# vect_result3_995.413, vect_result1_991.411
	vmv1r.v	v3,v2	# vect_result3_995.413, vect_result0_989.410
	mv	s2,t1	# ivtmp_1931, K
.L17:
	vsetvli	s1,s2,e8,m1,tu,ma	# ivtmp_1931, _1930,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:204:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e8.v	v4,(s4)	# vect_array.420, vectp.419,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:204:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v1,0(s3)	# vect__186.416,* vectp.415
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:203:             for (BLASLONG k = 0; k < K; k++) {
	slli	s5,s1,2	#, ivtmp_2012, _1930
	sub	s2,s2,s1	# ivtmp_1931, ivtmp_1931, _1930
	add	s3,s3,s1	# _1930, vectp.415, vectp.415
	add	s4,s4,s5	# ivtmp_2012, vectp.419, vectp.419
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:204:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v3,v1,v4	# vect_result0_989.410, vect__186.416, vect_array.420,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:205:                 result1 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v8,v1,v5	# vect_result1_991.411, vect__186.416, vect_array.420,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:206:                 result2 += A[ai + 0] * B[bi + 2];
	vmacc.vv	v9,v1,v6	# vect_result2_993.412, vect__186.416, vect_array.420,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:207:                 result3 += A[ai + 0] * B[bi + 3];
	vmacc.vv	v2,v1,v7	# vect_result3_995.413, vect__186.416, vect_array.420,
	bne	s2,zero,.L17	#, ivtmp_1931,,
	vsetvli	s3,zero,e8,m1,ta,ma	#, tmp1242,,,,
	li	s6,0		# tmp1243,
	vmv.s.x	v6,s6	# tmp1241, tmp1243
	vredsum.vs	v2,v2,v6	# tmp1244, vect_result3_995.413, tmp1241,
	vredsum.vs	v9,v9,v6	# tmp1249, vect_result2_993.412, tmp1246,
	vredsum.vs	v8,v8,v6	# tmp1254, vect_result1_991.411, tmp1251,
	vredsum.vs	v3,v3,v6	# tmp1259, vect_result0_989.410, tmp1256,
	vmv.x.s	s4,v2	# tmp931, tmp1244
	vmv.x.s	s3,v9	# tmp932, tmp1249
	vmv.x.s	s1,v8	# tmp933, tmp1254
	vmv.x.s	s2,v3	# tmp934, tmp1259
	andi	s4,s4,0xff	# _1938, tmp931
	andi	s3,s3,0xff	# _1976, tmp932
	andi	s1,s1,0xff	# _1987, tmp933
	andi	s2,s2,0xff	# _1998, tmp934
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:216:             C[ci + 3 * ldc + 0] += alpha * result3;
	mulw	s4,s4,s0	# tmp942, _1938, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:215:             C[ci + 2 * ldc + 0] += alpha * result2;
	mulw	s3,s3,s0	# tmp940, _1976, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:216:             C[ci + 3 * ldc + 0] += alpha * result3;
	andi	s7,s4,0xff	# _2033, tmp942
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:214:             C[ci + 1 * ldc + 0] += alpha * result1;
	mulw	s1,s1,s0	# tmp938, _1987, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:215:             C[ci + 2 * ldc + 0] += alpha * result2;
	andi	s6,s3,0xff	# _2030, tmp940
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:213:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	s2,s2,s0	# tmp936, _1998, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:214:             C[ci + 1 * ldc + 0] += alpha * result1;
	andi	s1,s1,0xff	# _2027, tmp938
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:213:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	s2,s2,0xff	# _2024, tmp936
.L16:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:212:             BLASLONG ci = n_top * ldc + m_top;
	add	t5,t6,t5	# m_top, ci, ivtmp.660
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:213:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	s5,t4,t5	# ci, _218, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:213:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	s4,0(s5)	# *_218, *_218
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:214:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	s3,s9,t5	# ci, _226, ldc
	add	s3,t4,s3	# _226, _228, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:213:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	s4,s4,s2	# _2024, tmp946, *_218
	sb	s4,0(s5)	# tmp946, *_218
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:214:             C[ci + 1 * ldc + 0] += alpha * result1;
	lbu	s4,0(s3)	# *_228, *_228
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:215:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	s2,a1,t5	# ci, _236, _275
	add	s2,t4,s2	# _236, _238, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:214:             C[ci + 1 * ldc + 0] += alpha * result1;
	addw	s4,s4,s1	# _2027, tmp951, *_228
	sb	s4,0(s3)	# tmp951, *_228
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:215:             C[ci + 2 * ldc + 0] += alpha * result2;
	lbu	s1,0(s2)	# *_238, *_238
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:216:             C[ci + 3 * ldc + 0] += alpha * result3;
	ld	s3,88(sp)		# _165, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:215:             C[ci + 2 * ldc + 0] += alpha * result2;
	addw	s1,s1,s6	# _2030, tmp956, *_238
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:216:             C[ci + 3 * ldc + 0] += alpha * result3;
	add	t5,s3,t5	# ci, _246, _165
	add	t5,t4,t5	# _246, _248, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:215:             C[ci + 2 * ldc + 0] += alpha * result2;
	sb	s1,0(s2)	# tmp956, *_238
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:216:             C[ci + 3 * ldc + 0] += alpha * result3;
	lbu	s1,0(t5)	# *_248, *_248
	addw	s1,s1,s7	# _2033, tmp961, *_248
	sb	s1,0(t5)	# tmp961, *_248
	j	.L15		#
.L314:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:96:             BLASLONG ai = m_top * K;
	mul	s1,t1,t5	# ai, K, m_top
	vsetivli	zero,4,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:107:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	s6,-4(a4)	# MEM[(FLOAT *)_186 + -4B], MEM[(FLOAT *)_186 + -4B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:110:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	lbu	s3,-1(a4)	# MEM[(FLOAT *)_186 + -1B], MEM[(FLOAT *)_186 + -1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:108:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	s5,-3(a4)	# MEM[(FLOAT *)_186 + -3B], MEM[(FLOAT *)_186 + -3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:109:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	lbu	s4,-2(a4)	# MEM[(FLOAT *)_186 + -2B], MEM[(FLOAT *)_186 + -2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:104:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	add	s2,s10,s1	# ai, _43, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:104:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(s2)	# A0,* _43
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:107:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	csrr	s2,vlenb	# tmp2271
	slli	s2,s2,4	#, tmp2272, tmp2271
	addi	s2,s2,128	#, tmp2273, tmp2270
	add	s2,s2,sp	#, tmp2270, tmp2270
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:105:             ai += 4;
	addi	s1,s1,4	#, ai, ai
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:107:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v16,v8,s6	# result0, A0, MEM[(FLOAT *)_186 + -4B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:108:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v24,v8,s5	# result1, A0, MEM[(FLOAT *)_186 + -3B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:109:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	vmul.vx	v0,v8,s4	# result2, A0, MEM[(FLOAT *)_186 + -2B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:110:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	vmul.vx	v8,v8,s3	# result3, A0, MEM[(FLOAT *)_186 + -1B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:107:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vs8r.v	v16,0(s2)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:110:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	csrr	s3,vlenb	# tmp2266
	li	s2,24		# tmp2265,
	mul	s2,s2,s3	# tmp2267, tmp2265, tmp2266
	addi	s2,s2,128	#, tmp2268, tmp2265
	add	s2,s2,sp	#, tmp2265, tmp2265
	vs8r.v	v8,0(s2)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,a7,.L10	#, K, tmp1108,
	sub	s3,a2,a4	# tmp1163, ivtmp.665, ivtmp.664
	addi	s3,s3,-4	#, tmp1164, tmp1163
	srli	s3,s3,2	#, tmp1162, tmp1164
	addi	s3,s3,1	#, tmp1165, tmp1162
	andi	s3,s3,7	#, tmp1166, tmp1165
	add	s2,s10,s1	# ai, ivtmp.626, A
	mv	s1,a4	# ivtmp.624, ivtmp.664
	beq	s3,zero,.L286	#, tmp1166,,
	li	s4,1		# tmp1172,
	beq	s3,s4,.L226	#, tmp1166, tmp1172,
	li	s4,2		# tmp1171,
	beq	s3,s4,.L227	#, tmp1166, tmp1171,
	li	s4,3		# tmp1170,
	beq	s3,s4,.L228	#, tmp1166, tmp1170,
	li	s4,4		# tmp1169,
	beq	s3,s4,.L229	#, tmp1166, tmp1169,
	li	s4,5		# tmp1168,
	beq	s3,s4,.L230	#, tmp1166, tmp1168,
	li	s4,6		# tmp1167,
	beq	s3,s4,.L231	#, tmp1166, tmp1167,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s1,vlenb	# tmp2064
	slli	s1,s1,4	#, tmp2065, tmp2064
	addi	s1,s1,128	#, tmp2066, tmp2063
	add	s1,s1,sp	#, tmp2063, tmp2063
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vl8re8.v	v8,0(s1)	# %sfp, result0
	lbu	s6,0(a4)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
	csrr	s1,vlenb	# tmp2059
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(a4)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	slli	s1,s1,4	#, tmp2060, tmp2059
	addi	s1,s1,128	#, tmp2061, tmp2058
	vmacc.vx	v8,s6,v16	# result0, MEM[(FLOAT *)_1048], A0,
	add	s1,s1,sp	#, tmp2058, tmp2058
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s4,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s4,vlenb	# tmp2054
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s1)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	li	s1,24		# tmp2053,
	mul	s1,s1,s4	# tmp2055, tmp2053, tmp2054
	lbu	s3,3(a4)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(a4)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s1,s1,128	#, tmp2056, tmp2053
	add	s1,s1,sp	#, tmp2053, tmp2053
	vl8re8.v	v8,0(s1)	# %sfp, result3
	li	s1,24		# tmp2048,
	mul	s1,s1,s4	# tmp2050, tmp2048, tmp2049
	vmacc.vx	v8,s3,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	addi	s1,s1,128	#, tmp2051, tmp2048
	add	s1,s1,sp	#, tmp2048, tmp2048
	vs8r.v	v8,0(s1)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s1,a4,4	#, ivtmp.624, ivtmp.664
.L231:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s7,vlenb	# tmp2044
	slli	s7,s7,4	#, tmp2045, tmp2044
	addi	s7,s7,128	#, tmp2046, tmp2043
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s4,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s5,vlenb	# tmp2034
	li	s4,24		# tmp2033,
	mul	s4,s4,s5	# tmp2035, tmp2033, tmp2034
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	add	s7,s7,sp	#, tmp2043, tmp2043
	vl8re8.v	v8,0(s7)	# %sfp, result0
	lbu	s6,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s3,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
	addi	s1,s1,4	#, ivtmp.624, ivtmp.624
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s6,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s4,s4,128	#, tmp2036, tmp2033
	add	s4,s4,sp	#, tmp2033, tmp2033
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s7)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v8,0(s4)	# %sfp, result3
	vmacc.vx	v8,s3,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	li	s3,24		# tmp2028,
	mul	s3,s3,s5	# tmp2030, tmp2028, tmp2029
	addi	s3,s3,128	#, tmp2031, tmp2028
	add	s3,s3,sp	#, tmp2028, tmp2028
	vs8r.v	v8,0(s3)	# result3, %sfp
.L230:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s7,vlenb	# tmp2024
	slli	s7,s7,4	#, tmp2025, tmp2024
	addi	s7,s7,128	#, tmp2026, tmp2023
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s4,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s5,vlenb	# tmp2014
	li	s4,24		# tmp2013,
	mul	s4,s4,s5	# tmp2015, tmp2013, tmp2014
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	add	s7,s7,sp	#, tmp2023, tmp2023
	vl8re8.v	v8,0(s7)	# %sfp, result0
	lbu	s6,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s3,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
	addi	s1,s1,4	#, ivtmp.624, ivtmp.624
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s6,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s4,s4,128	#, tmp2016, tmp2013
	add	s4,s4,sp	#, tmp2013, tmp2013
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s7)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v8,0(s4)	# %sfp, result3
	vmacc.vx	v8,s3,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	li	s3,24		# tmp2008,
	mul	s3,s3,s5	# tmp2010, tmp2008, tmp2009
	addi	s3,s3,128	#, tmp2011, tmp2008
	add	s3,s3,sp	#, tmp2008, tmp2008
	vs8r.v	v8,0(s3)	# result3, %sfp
.L229:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s7,vlenb	# tmp2004
	slli	s7,s7,4	#, tmp2005, tmp2004
	addi	s7,s7,128	#, tmp2006, tmp2003
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s4,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s5,vlenb	# tmp1994
	li	s4,24		# tmp1993,
	mul	s4,s4,s5	# tmp1995, tmp1993, tmp1994
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	add	s7,s7,sp	#, tmp2003, tmp2003
	vl8re8.v	v8,0(s7)	# %sfp, result0
	lbu	s6,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s3,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
	addi	s1,s1,4	#, ivtmp.624, ivtmp.624
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s6,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s4,s4,128	#, tmp1996, tmp1993
	add	s4,s4,sp	#, tmp1993, tmp1993
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s7)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v8,0(s4)	# %sfp, result3
	vmacc.vx	v8,s3,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	li	s3,24		# tmp1988,
	mul	s3,s3,s5	# tmp1990, tmp1988, tmp1989
	addi	s3,s3,128	#, tmp1991, tmp1988
	add	s3,s3,sp	#, tmp1988, tmp1988
	vs8r.v	v8,0(s3)	# result3, %sfp
.L228:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s7,vlenb	# tmp1984
	slli	s7,s7,4	#, tmp1985, tmp1984
	addi	s7,s7,128	#, tmp1986, tmp1983
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s4,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s5,vlenb	# tmp1974
	li	s4,24		# tmp1973,
	mul	s4,s4,s5	# tmp1975, tmp1973, tmp1974
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	add	s7,s7,sp	#, tmp1983, tmp1983
	vl8re8.v	v8,0(s7)	# %sfp, result0
	lbu	s6,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s3,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
	addi	s1,s1,4	#, ivtmp.624, ivtmp.624
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s6,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s4,s4,128	#, tmp1976, tmp1973
	add	s4,s4,sp	#, tmp1973, tmp1973
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s7)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v8,0(s4)	# %sfp, result3
	vmacc.vx	v8,s3,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	li	s3,24		# tmp1968,
	mul	s3,s3,s5	# tmp1970, tmp1968, tmp1969
	addi	s3,s3,128	#, tmp1971, tmp1968
	add	s3,s3,sp	#, tmp1968, tmp1968
	vs8r.v	v8,0(s3)	# result3, %sfp
.L227:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s7,vlenb	# tmp1964
	slli	s7,s7,4	#, tmp1965, tmp1964
	addi	s7,s7,128	#, tmp1966, tmp1963
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s4,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s5,vlenb	# tmp1954
	li	s4,24		# tmp1953,
	mul	s4,s4,s5	# tmp1955, tmp1953, tmp1954
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	add	s7,s7,sp	#, tmp1963, tmp1963
	vl8re8.v	v8,0(s7)	# %sfp, result0
	lbu	s6,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s3,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
	addi	s1,s1,4	#, ivtmp.624, ivtmp.624
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s6,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s4,s4,128	#, tmp1956, tmp1953
	add	s4,s4,sp	#, tmp1953, tmp1953
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s7)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v8,0(s4)	# %sfp, result3
	vmacc.vx	v8,s3,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	li	s3,24		# tmp1948,
	mul	s3,s3,s5	# tmp1950, tmp1948, tmp1949
	addi	s3,s3,128	#, tmp1951, tmp1948
	add	s3,s3,sp	#, tmp1948, tmp1948
	vs8r.v	v8,0(s3)	# result3, %sfp
.L226:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s7,vlenb	# tmp1944
	slli	s7,s7,4	#, tmp1945, tmp1944
	addi	s7,s7,128	#, tmp1946, tmp1943
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s4,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s5,vlenb	# tmp1934
	li	s4,24		# tmp1933,
	mul	s4,s4,s5	# tmp1935, tmp1933, tmp1934
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	add	s7,s7,sp	#, tmp1943, tmp1943
	vl8re8.v	v8,0(s7)	# %sfp, result0
	lbu	s6,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s3,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s1,s1,4	#, ivtmp.624, ivtmp.624
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s6,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s4,s4,128	#, tmp1936, tmp1933
	add	s4,s4,sp	#, tmp1933, tmp1933
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s7)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v8,0(s4)	# %sfp, result3
	vmacc.vx	v8,s3,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	li	s3,24		# tmp1928,
	mul	s3,s3,s5	# tmp1930, tmp1928, tmp1929
	addi	s3,s3,128	#, tmp1931, tmp1928
	add	s3,s3,sp	#, tmp1928, tmp1928
	vs8r.v	v8,0(s3)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	beq	s1,a2,.L10	#, ivtmp.624, ivtmp.665,
.L286:
	addi	s3,sp,128	#, tmp2256,
	vs8r.v	v24,0(s3)	# result1, %sfp
	csrr	s3,vlenb	# tmp2252
	slli	s3,s3,3	#, tmp2253, tmp2252
	addi	s3,s3,128	#, tmp2254, tmp2251
	add	s3,s3,sp	#, tmp2251, tmp2251
	vs8r.v	v0,0(s3)	# result2, %sfp
.L11:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	csrr	s3,vlenb	# tmp2247
	slli	s3,s3,4	#, tmp2248, tmp2247
	addi	s3,s3,128	#, tmp2249, tmp2246
	add	s3,s3,sp	#, tmp2246, tmp2246
	vl8re8.v	v8,0(s3)	# %sfp, result0
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s3,sp,128	#, tmp2244,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v24,0(s3)	# %sfp, result1
	lbu	s6,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s5,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s8,s2,4	#, tmp1174, ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s6,5(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,4(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v24,0(s3)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	csrr	s3,vlenb	# tmp2238
	slli	s3,s3,3	#, tmp2239, tmp2238
	addi	s3,s3,128	#, tmp2240, tmp2237
	add	s3,s3,sp	#, tmp2237, tmp2237
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,8	#, ivtmp.626, ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vl8re8.v	v24,0(s3)	# %sfp, result2
	csrr	s3,vlenb	# tmp2233
	slli	s3,s3,3	#, tmp2234, tmp2233
	addi	s3,s3,128	#, tmp2235, tmp2232
	add	s3,s3,sp	#, tmp2232, tmp2232
	vmacc.vx	v24,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s5,vlenb	# tmp2228
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vs8r.v	v24,0(s3)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	li	s3,24		# tmp2227,
	mul	s3,s3,s5	# tmp2229, tmp2227, tmp2228
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s5,6(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s3,s3,128	#, tmp2230, tmp2227
	add	s3,s3,sp	#, tmp2227, tmp2227
	vl8re8.v	v24,0(s3)	# %sfp, result3
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s3,sp,128	#, tmp2225,
	vl8re8.v	v0,0(s3)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v24,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s8)	# A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,7(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s6,9(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,8(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s3)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	csrr	s3,vlenb	# tmp2219
	slli	s3,s3,3	#, tmp2220, tmp2219
	addi	s3,s3,128	#, tmp2221, tmp2218
	add	s3,s3,sp	#, tmp2218, tmp2218
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v24,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vl8re8.v	v0,0(s3)	# %sfp, result2
	csrr	s3,vlenb	# tmp2214
	slli	s3,s3,3	#, tmp2215, tmp2214
	addi	s3,s3,128	#, tmp2216, tmp2213
	add	s3,s3,sp	#, tmp2213, tmp2213
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,11(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v0,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
	lbu	s5,10(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
	vs8r.v	v0,0(s3)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s3,s1,4	#, tmp1173, ivtmp.624
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s1,sp,128	#, tmp2211,
	vl8re8.v	v0,0(s1)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s8,8	#, ivtmp.626, tmp1174
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s6,9(s3)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,8(s3)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	csrr	s1,vlenb	# tmp2205
	slli	s1,s1,3	#, tmp2206, tmp2205
	addi	s1,s1,128	#, tmp2207, tmp2204
	add	s1,s1,sp	#, tmp2204, tmp2204
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v24,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vl8re8.v	v0,0(s1)	# %sfp, result2
	csrr	s1,vlenb	# tmp2200
	slli	s1,s1,3	#, tmp2201, tmp2200
	addi	s1,s1,128	#, tmp2202, tmp2199
	add	s1,s1,sp	#, tmp2199, tmp2199
	vmacc.vx	v0,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
	vs8r.v	v0,0(s1)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s1,sp,128	#, tmp2197,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s5,10(s3)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(s1)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,11(s3)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s8,12	#, ivtmp.626, tmp1174
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v24,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
	lbu	s6,13(s3)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,12(s3)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,15(s3)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	csrr	s1,vlenb	# tmp2191
	slli	s1,s1,3	#, tmp2192, tmp2191
	addi	s1,s1,128	#, tmp2193, tmp2190
	add	s1,s1,sp	#, tmp2190, tmp2190
	vl8re8.v	v0,0(s1)	# %sfp, result2
	csrr	s1,vlenb	# tmp2186
	slli	s1,s1,3	#, tmp2187, tmp2186
	addi	s1,s1,128	#, tmp2188, tmp2185
	add	s1,s1,sp	#, tmp2185, tmp2185
	vmacc.vx	v0,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
	lbu	s5,14(s3)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
	vs8r.v	v0,0(s1)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s1,sp,128	#, tmp2183,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(s1)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s8,16	#, ivtmp.626, tmp1174
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v24,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s6,17(s3)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,16(s3)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	csrr	s1,vlenb	# tmp2177
	slli	s1,s1,3	#, tmp2178, tmp2177
	addi	s1,s1,128	#, tmp2179, tmp2176
	add	s1,s1,sp	#, tmp2176, tmp2176
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,19(s3)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vl8re8.v	v0,0(s1)	# %sfp, result2
	csrr	s1,vlenb	# tmp2172
	slli	s1,s1,3	#, tmp2173, tmp2172
	addi	s1,s1,128	#, tmp2174, tmp2171
	add	s1,s1,sp	#, tmp2171, tmp2171
	vmacc.vx	v0,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
	lbu	s5,18(s3)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
	vs8r.v	v0,0(s1)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s1,sp,128	#, tmp2169,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(s1)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s8,20	#, ivtmp.626, tmp1174
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v24,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s6,21(s3)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,20(s3)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	csrr	s1,vlenb	# tmp2163
	slli	s1,s1,3	#, tmp2164, tmp2163
	addi	s1,s1,128	#, tmp2165, tmp2162
	add	s1,s1,sp	#, tmp2162, tmp2162
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,23(s3)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vl8re8.v	v0,0(s1)	# %sfp, result2
	csrr	s1,vlenb	# tmp2158
	slli	s1,s1,3	#, tmp2159, tmp2158
	addi	s1,s1,128	#, tmp2160, tmp2157
	add	s1,s1,sp	#, tmp2157, tmp2157
	vmacc.vx	v0,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
	lbu	s5,22(s3)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
	vs8r.v	v0,0(s1)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s1,sp,128	#, tmp2155,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v0,0(s1)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s8,24	#, ivtmp.626, tmp1174
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v0,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmacc.vx	v24,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vs8r.v	v0,0(s1)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	csrr	s1,vlenb	# tmp2149
	slli	s1,s1,3	#, tmp2150, tmp2149
	addi	s1,s1,128	#, tmp2151, tmp2148
	add	s1,s1,sp	#, tmp2148, tmp2148
	vl8re8.v	v0,0(s1)	# %sfp, result2
	csrr	s1,vlenb	# tmp2144
	slli	s1,s1,3	#, tmp2145, tmp2144
	addi	s1,s1,128	#, tmp2146, tmp2143
	add	s1,s1,sp	#, tmp2143, tmp2143
	vmacc.vx	v0,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
	vs8r.v	v0,0(s1)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:120:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s7,24(s3)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s4,27(s3)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s6,25(s3)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s5,26(s3)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s1,s3,28	#, ivtmp.624, tmp1173
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:123:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s7,v16	# result0, MEM[(FLOAT *)_1048], A0,
	csrr	s3,vlenb	# tmp2139
	slli	s3,s3,4	#, tmp2140, tmp2139
	addi	s3,s3,128	#, tmp2141, tmp2138
	add	s3,s3,sp	#, tmp2138, tmp2138
	vs8r.v	v8,0(s3)	# result0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	addi	s3,sp,128	#, tmp2136,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s8,28	#, ivtmp.626, tmp1174
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:124:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vl8re8.v	v8,0(s3)	# %sfp, result1
	vmacc.vx	v8,s6,v16	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
	vs8r.v	v8,0(s3)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:125:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmv8r.v	v8,v0	# result2, result2
	csrr	s3,vlenb	# tmp2125
	slli	s3,s3,3	#, tmp2126, tmp2125
	vmacc.vx	v8,s5,v16	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
	addi	s3,s3,128	#, tmp2127, tmp2124
	add	s3,s3,sp	#, tmp2124, tmp2124
	vs8r.v	v8,0(s3)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:126:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vmv8r.v	v8,v24	# result3, result3
	li	s3,24		# tmp2119,
	vmacc.vx	v8,s4,v16	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	csrr	s4,vlenb	# tmp2120
	mul	s3,s3,s4	# tmp2121, tmp2119, tmp2120
	addi	s3,s3,128	#, tmp2122, tmp2119
	add	s3,s3,sp	#, tmp2119, tmp2119
	vs8r.v	v8,0(s3)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:113:             for (BLASLONG k = 1; k < K; k++) {
	bne	s1,a2,.L11	#, ivtmp.624, ivtmp.665,
	addi	s1,sp,128	#, tmp2117,
	vl8re8.v	v24,0(s1)	# %sfp, result1
	slli	s1,s4,3	#, tmp2114, tmp2113
	addi	s1,s1,128	#, tmp2115, tmp2112
	add	s1,s1,sp	#, tmp2112, tmp2112
	vl8re8.v	v0,0(s1)	# %sfp, result2
.L10:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:129:             BLASLONG ci = n_top * ldc + m_top;
	add	s1,t6,t5	# m_top, ci, ivtmp.660
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:131:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s4,t4,s1	# ci, _56, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:132:             ci += ldc - gvl * 0;
	add	s1,s9,s1	# ci, ci, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:133:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s3,t4,s1	# ci, _58, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:134:             ci += ldc - gvl * 0;
	add	s1,s9,s1	# ci, ci, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:136:             ci += ldc - gvl * 0;
	add	s2,s9,s1	# ci, ci_747, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:137:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s2,t4,s2	# ci_747, _62, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:137:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v8,0(s2)	# c3,* _62
	csrr	s5,vlenb	# tmp2108
	slli	s5,s5,3	#, tmp2109, tmp2108
	addi	s5,s5,128	#, tmp2110, tmp2107
	add	s5,s5,sp	#, tmp2107, tmp2107
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:131:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(s4)	# c0,* _56
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:137:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vs8r.v	v8,0(s5)	# c3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:139:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	csrr	s5,vlenb	# tmp2103
	slli	s5,s5,4	#, tmp2104, tmp2103
	addi	s5,s5,128	#, tmp2105, tmp2102
	add	s5,s5,sp	#, tmp2102, tmp2102
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:142:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	csrr	s6,vlenb	# tmp2086
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:139:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vl8re8.v	v8,0(s5)	# %sfp, result0
	csrr	s5,vlenb	# tmp2098
	slli	s5,s5,4	#, tmp2099, tmp2098
	addi	s5,s5,128	#, tmp2100, tmp2097
	add	s5,s5,sp	#, tmp2097, tmp2097
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:135:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s1,t4,s1	# ci, _60, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:139:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v16,a3,v8	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:153:             m_top += 4;
	addi	t5,t5,4	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:139:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vs8r.v	v16,0(s5)	# c0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:133:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	addi	s5,sp,128	#, tmp2095,
	vle8.v	v8,0(s3)	# c1,* _58
	vs8r.v	v8,0(s5)	# c1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:142:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	csrr	s5,vlenb	# tmp2091
	slli	s5,s5,3	#, tmp2092, tmp2091
	addi	s5,s5,128	#, tmp2093, tmp2090
	add	s5,s5,sp	#, tmp2090, tmp2090
	vl8re8.v	v8,0(s5)	# %sfp, c3
	li	s5,24		# tmp2085,
	mul	s5,s5,s6	# tmp2087, tmp2085, tmp2086
	addi	s5,s5,128	#, tmp2088, tmp2085
	add	s5,s5,sp	#, tmp2085, tmp2085
	vl8re8.v	v16,0(s5)	# %sfp, result3
	slli	s5,s6,3	#, tmp2082, tmp2081
	addi	s5,s5,128	#, tmp2083, tmp2080
	add	s5,s5,sp	#, tmp2080, tmp2080
	vmacc.vx	v8,a3,v16	# c3, alpha, result3,
	vs8r.v	v8,0(s5)	# c3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:146:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	slli	s5,s6,4	#, tmp2077, tmp2076
	addi	s5,s5,128	#, tmp2078, tmp2075
	add	s5,s5,sp	#, tmp2075, tmp2075
	vl8re8.v	v16,0(s5)	# %sfp, c0
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:135:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v8,0(s1)	# c2,* _60
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:146:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v16,0(s4)	# c0,* _56,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:140:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	addi	s4,sp,128	#, tmp2073,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:141:             c2 = __riscv_vmacc_vx_i8m8(c2, alpha, result2, gvl);
	vmacc.vx	v8,a3,v0	# c2, alpha, result2,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:140:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vl8re8.v	v16,0(s4)	# %sfp, c1
	vmacc.vx	v16,a3,v24	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:148:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v16,0(s3)	# c1,* _58,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:150:             __riscv_vse8_v_i8m8(&C[ci], c2, gvl);
	vse8.v	v8,0(s1)	# c2,* _60,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:152:             __riscv_vse8_v_i8m8(&C[ci], c3, gvl);
	slli	s1,s6,3	#, tmp2070, tmp2069
	addi	s1,s1,128	#, tmp2071, tmp2068
	add	s1,s1,sp	#, tmp2068, tmp2068
	vl8re8.v	v8,0(s1)	# %sfp, c3
	vse8.v	v8,0(s2)	# c3,* _62,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:156:         if (M & 2) {
	ld	s1,48(sp)		# _63, %sfp
	beq	s1,zero,.L12	#, _63,,
.L315:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:165:             BLASLONG ai = m_top * K;
	mul	s3,t5,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:169:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L50	#, K,,
	vsetvli	s1,zero,e8,m1,ta,ma	#, tmp1111,,,,
	vmv.v.i	v1,0	# vect_result7_984.462,
	add	s3,s10,s3	# ai, vectp.464, A
	addi	s4,a4,-4	#, vectp.470, ivtmp.664
	vmv1r.v	v14,v1	# vect_result7_984.462, vect_result6_982.461
	vmv1r.v	v13,v1	# vect_result7_984.462, vect_result5_980.460
	vmv1r.v	v12,v1	# vect_result7_984.462, vect_result4_978.459
	vmv1r.v	v11,v1	# vect_result7_984.462, vect_result3_976.458
	vmv1r.v	v10,v1	# vect_result7_984.462, vect_result2_974.457
	vmv1r.v	v9,v1	# vect_result7_984.462, vect_result1_972.456
	vmv1r.v	v8,v1	# vect_result7_984.462, vect_result0_970.455
	mv	s2,t1	# ivtmp_1815, K
.L14:
	vsetvli	s1,s2,e8,m1,tu,ma	# ivtmp_1815, _1814,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v2,(s3)	# vect_array.465, vectp.464,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e8.v	v4,(s4)	# vect_array.471, vectp.470,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:169:             for (BLASLONG k = 0; k < K; k++) {
	slli	s6,s1,1	#, ivtmp_1918, _1814
	slli	s5,s1,2	#, ivtmp_1910, _1814
	sub	s2,s2,s1	# ivtmp_1815, ivtmp_1815, _1814
	add	s3,s3,s6	# ivtmp_1918, vectp.464, vectp.464
	add	s4,s4,s5	# ivtmp_1910, vectp.470, vectp.470
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v8,v2,v4	# vect_result0_970.455, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:171:                 result1 += A[ai + 1] * B[bi + 0];
	vmacc.vv	v9,v3,v4	# vect_result1_972.456, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:172:                 result2 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v10,v2,v5	# vect_result2_974.457, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:173:                 result3 += A[ai + 1] * B[bi + 1];
	vmacc.vv	v11,v3,v5	# vect_result3_976.458, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:174:                 result4 += A[ai + 0] * B[bi + 2];
	vmacc.vv	v12,v2,v6	# vect_result4_978.459, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:175:                 result5 += A[ai + 1] * B[bi + 2];
	vmacc.vv	v13,v3,v6	# vect_result5_980.460, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:176:                 result6 += A[ai + 0] * B[bi + 3];
	vmacc.vv	v14,v2,v7	# vect_result6_982.461, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:177:                 result7 += A[ai + 1] * B[bi + 3];
	vmacc.vv	v1,v3,v7	# vect_result7_984.462, vect_array.465, vect_array.471,
	bne	s2,zero,.L14	#, ivtmp_1815,,
	vsetvli	s5,zero,e8,m1,ta,ma	#, tmp1262,,,,
	li	s11,0		# tmp1263,
	vmv.s.x	v16,s11	# tmp1261, tmp1263
	vredsum.vs	v12,v12,v16	# tmp1279, vect_result4_978.459, tmp1276,
	vredsum.vs	v11,v11,v16	# tmp1284, vect_result3_976.458, tmp1281,
	vredsum.vs	v10,v10,v16	# tmp1289, vect_result2_974.457, tmp1286,
	vredsum.vs	v1,v1,v16	# tmp1264, vect_result7_984.462, tmp1261,
	vredsum.vs	v14,v14,v16	# tmp1269, vect_result6_982.461, tmp1266,
	vredsum.vs	v13,v13,v16	# tmp1274, vect_result5_980.460, tmp1271,
	vredsum.vs	v9,v9,v16	# tmp1294, vect_result1_972.456, tmp1291,
	vredsum.vs	v8,v8,v16	# tmp1299, vect_result0_970.455, tmp1296,
	vmv.x.s	s5,v12	# tmp873, tmp1279
	vmv.x.s	s4,v11	# tmp874, tmp1284
	vmv.x.s	s3,v10	# tmp875, tmp1289
	vmv.x.s	s8,v1	# tmp870, tmp1264
	vmv.x.s	s7,v14	# tmp871, tmp1269
	vmv.x.s	s6,v13	# tmp872, tmp1274
	vmv.x.s	s1,v9	# tmp876, tmp1294
	vmv.x.s	s2,v8	# tmp877, tmp1299
	andi	s5,s5,0xff	# _1853, tmp873
	andi	s4,s4,0xff	# _1864, tmp874
	andi	s3,s3,0xff	# _1874, tmp875
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	mulw	s5,s5,s0	# tmp887, _1853, _2317
	andi	s8,s8,0xff	# _1822, tmp870
	andi	s7,s7,0xff	# _1832, tmp871
	andi	s6,s6,0xff	# _1843, tmp872
	andi	s1,s1,0xff	# _1885, tmp876
	andi	s2,s2,0xff	# _1896, tmp877
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	mulw	s4,s4,s0	# tmp885, _1864, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	andi	s5,s5,0xff	# _1955, tmp887
	sd	s5,96(sp)	# _1955, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	mulw	s3,s3,s0	# tmp883, _1874, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	andi	s4,s4,0xff	# _1952, tmp885
	sd	s4,16(sp)	# _1952, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:190:             C[ci + 3 * ldc + 1] += alpha * result7;
	mulw	s8,s8,s0	# tmp893, _1822, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	andi	s3,s3,0xff	# _1949, tmp883
	sd	s3,8(sp)	# _1949, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	mulw	s7,s7,s0	# tmp891, _1832, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:190:             C[ci + 3 * ldc + 1] += alpha * result7;
	andi	s8,s8,0xff	# _1964, tmp893
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	mulw	s6,s6,s0	# tmp889, _1843, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	andi	s7,s7,0xff	# _1961, tmp891
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	mulw	s1,s1,s0	# tmp881, _1885, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	andi	s11,s6,0xff	# _1958, tmp889
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	s2,s2,s0	# tmp879, _1896, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	andi	s4,s1,0xff	# _1946, tmp881
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	s2,s2,0xff	# _1943, tmp879
.L13:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:182:             BLASLONG ci = n_top * ldc + m_top;
	add	s1,t6,t5	# m_top, ci, ivtmp.660
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	s6,t4,s1	# ci, _114, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	s5,0(s6)	# *_114, *_114
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	add	s3,t4,s1	# _122, _123, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:191:             m_top += 2;
	addi	t5,t5,2	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	s5,s5,s2	# _1943, tmp897, *_114
	sb	s5,0(s6)	# tmp897, *_114
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	lbu	s5,1(s3)	# *_123, *_123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	s2,s9,s1	# ci, _131, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	ld	s6,16(sp)		# _1952, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	addw	s5,s5,s4	# _1946, tmp902, *_123
	sb	s5,1(s3)	# tmp902, *_123
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	s5,t4,s2	# _131, _132, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	lbu	s4,0(s5)	# *_132, *_132
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	add	s3,t4,s2	# _139, _140, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	ld	s2,8(sp)		# _1949, %sfp
	addw	s4,s4,s2	# _1949, tmp906, *_132
	sb	s4,0(s5)	# tmp906, *_132
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	lbu	s4,1(s3)	# *_140, *_140
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	s2,a1,s1	# ci, _149, _275
	add	s5,t4,s2	# _149, _150, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	addw	s4,s4,s6	# _1952, tmp911, *_140
	sb	s4,1(s3)	# tmp911, *_140
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	lbu	s3,0(s5)	# *_150, *_150
	ld	s4,96(sp)		# _1955, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	add	s2,t4,s2	# _157, _158, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	addw	s3,s3,s4	# _1955, tmp915, *_150
	sb	s3,0(s5)	# tmp915, *_150
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	lbu	s3,1(s2)	# *_158, *_158
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	ld	s4,88(sp)		# _165, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	addw	s3,s3,s11	# _1958, tmp920, *_158
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	s1,s4,s1	# ci, _167, _165
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	sb	s3,1(s2)	# tmp920, *_158
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	s4,t4,s1	# _167, _168, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	lbu	s2,0(s4)	# *_168, *_168
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:190:             C[ci + 3 * ldc + 1] += alpha * result7;
	add	s1,t4,s1	# _175, _176, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	addw	s2,s2,s7	# _1961, tmp924, *_168
	sb	s2,0(s4)	# tmp924, *_168
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:190:             C[ci + 3 * ldc + 1] += alpha * result7;
	lbu	s2,1(s1)	# *_176, *_176
	addw	s2,s2,s8	# _1964, tmp929, *_176
	sb	s2,1(s1)	# tmp929, *_176
	j	.L12		#
.L49:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:27:         m_top = 0;
	li	t5,0		# m_top,
	j	.L5		#
.L313:
	slli	a0,a6,3	#, _2260, _930
	sd	a0,72(sp)	# _2260, %sfp
	j	.L4		#
.L50:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:169:             for (BLASLONG k = 0; k < K; k++) {
	li	s8,0		# _1964,
	li	s7,0		# _1961,
	li	s11,0		# _1958,
	sd	zero,96(sp)	#, %sfp
	sd	zero,16(sp)	#, %sfp
	sd	zero,8(sp)	#, %sfp
	li	s4,0		# _1946,
	li	s2,0		# _1943,
	j	.L13		#
.L51:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:203:             for (BLASLONG k = 0; k < K; k++) {
	li	s7,0		# _2033,
	li	s6,0		# _2030,
	li	s1,0		# _2027,
	li	s2,0		# _2024,
	j	.L16		#
.L55:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:370:         m_top = 0;
	li	a1,0		# m_top,
	j	.L35		#
.L52:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:227:         m_top = 0;
	li	t3,0		# m_top,
	j	.L20		#
.L48:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:22:     BLASLONG n_top = 0;
	li	a0,0		# n_top,
	j	.L2		#
.L318:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:423:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a4)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:419:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
	addi	a4,a4,1	#, ivtmp.544, ivtmp.544
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:426:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a6,v16	# result0, MEM[(FLOAT *)_87], A0,
	j	.L255		#
.L56:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:447:             for (BLASLONG k = 0; k < K; k++) {
	li	a4,0		# _2287,
	li	a2,0		# _2284,
	j	.L43		#
.L57:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:466:             for (BLASLONG k = 0; k < K; k++) {
	li	a5,0		# _2308,
	j	.L46		#
.L53:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:326:             for (BLASLONG k = 0; k < K; k++) {
	li	a4,0		# _2171,
	li	a2,0		# _2168,
	li	a1,0		# _2165,
	li	a6,0		# _2162,
	j	.L28		#
.L54:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:350:             for (BLASLONG k = 0; k < K; k++) {
	li	a4,0		# _2212,
	li	a2,0		# _2209,
	j	.L31		#
.L317:
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:293:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a4)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a6,0(a2)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a1,1(a2)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:288:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,4	#, ivtmp.584, ivtmp.584
	addi	a2,a2,2	#, ivtmp.582, ivtmp.582
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:296:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,a6,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll8_i8i32.c:297:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a1,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
	j	.L243		#
	.cfi_endproc
.LFE0:
	.size	dgemm_kernel_8x4_zvl128b_lmul8_unroll8, .-dgemm_kernel_8x4_zvl128b_lmul8_unroll8
	.ident	"GCC: (Bianbu 14.2.0-4ubuntu2~24.04bb1) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
