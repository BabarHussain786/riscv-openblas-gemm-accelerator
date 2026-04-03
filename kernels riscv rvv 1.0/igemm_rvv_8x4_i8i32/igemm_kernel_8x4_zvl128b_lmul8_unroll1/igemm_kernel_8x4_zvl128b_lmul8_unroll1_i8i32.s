	.file	"igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c"
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
	.globl	dgemm_kernel_8x4_zvl128b_lmul8_unroll1
	.type	dgemm_kernel_8x4_zvl128b_lmul8_unroll1, @function
dgemm_kernel_8x4_zvl128b_lmul8_unroll1:
.LFB0:
	.cfi_startproc
	csrr	t0,vlenb	#
	li	t1,24		#,
	mul	t1,t1,t0	#,,
	mv	t5,a1	# N, tmp1113
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	srai	a1,a1,63	#, tmp811, N
	andi	a1,a1,3	#, tmp812, tmp811
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:19: {
	addi	sp,sp,-224	#,,
	.cfi_def_cfa_offset 224
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a1,a1,t5	# N, tmp813, tmp812
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:19: {
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
	mv	s9,a5	# B, tmp1117
	sub	sp,sp,t1	#,,
	.cfi_escape 0xf,0xd,0x72,0,0x92,0xa2,0x38,0,0x8,0x30,0x1e,0x23,0xe0,0x1,0x22
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	srai	a5,a1,2	#, _901, tmp813
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t3,3		# tmp815,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:19: {
	sd	a0,8(sp)	# M, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	sd	a5,16(sp)	# _901, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:19: {
	mv	t1,a2	# K, tmp1114
	mv	s10,a4	# A, tmp1116
	mv	a2,a3	# alpha, tmp1115
	mv	t4,a6	# C, tmp1118
	mv	s11,a7	# ldc, tmp1119
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ble	t5,t3,.L48	#, N, tmp815,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	mv	a3,a0	# M, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:92:         if (M & 4) {
	andi	s0,a3,4	#, _32, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a0,63	#, tmp818, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	slli	a1,a7,1	#, _275, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:92:         if (M & 4) {
	sd	s0,24(sp)	# _32, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:154:         if (M & 2) {
	andi	s0,a3,2	#, _63, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:191:         if (M & 1) {
	andi	a3,a3,1	#, _183, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	a4,a1,a7	# ldc, _165, _275
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	andi	a6,a6,7	#, tmp819, tmp818
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:154:         if (M & 2) {
	sd	s0,32(sp)	# _63, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:191:         if (M & 1) {
	sd	a3,40(sp)	# _183, %sfp
	li	s0,8		# _2260,
	slli	a3,a7,2	#, _2047, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a6,a6,a0	# M, tmp820, tmp819
	slli	a5,t1,2	#, _2056, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	sd	a4,72(sp)	# _165, %sfp
	sd	a3,48(sp)	# _2047, %sfp
	slti	a0,a0,8	#, tmp828, M
	sd	s0,56(sp)	# _2260, %sfp
	mv	t0,a5	# _2056, _2056
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a6,3	#, _930, tmp820
	add	a4,s9,a5	# _2056, ivtmp.665, B
	addi	a3,s9,4	#, ivtmp.664, B
	slli	t3,t1,3	#, _942, K
	beq	a0,zero,.L126	#, tmp828,,
.L4:
	add	a0,t4,s11	# ldc, _197, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:166:             for (BLASLONG k = 0; k < K; k++) {
	sd	s9,120(sp)	# B, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:191:         if (M & 1) {
	li	t6,0		# ivtmp.660,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t2,0		# j,
	sd	a0,64(sp)	# _197, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:47:             for (BLASLONG k = 1; k < K; k++) {
	li	a7,1		# tmp1108,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	s0,a2,0xff	# _2317, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:166:             for (BLASLONG k = 0; k < K; k++) {
	sd	s1,104(sp)	# tmp1111, %sfp
	sd	t5,112(sp)	# N, %sfp
	mv	s9,s11	# ldc, ldc
.L18:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ld	s1,8(sp)		# M, %sfp
	li	t5,7		# tmp1552,
	ble	s1,t5,.L49	#, M, tmp1552,
	ld	s1,64(sp)		# _197, %sfp
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
	mv	s5,s10	# ivtmp.647, A
	add	s4,t4,t6	# ivtmp.660, ivtmp.648, C
	add	s3,s1,t6	# ivtmp.660, ivtmp.649, _197
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	s6,0		# i,
.L8:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:39:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(s5)	# A0,* ivtmp.647
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:44:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	lbu	s1,-2(a3)	# MEM[(FLOAT *)_187 + -2B], MEM[(FLOAT *)_187 + -2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:42:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	s7,-4(a3)	# MEM[(FLOAT *)_187 + -4B], MEM[(FLOAT *)_187 + -4B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:43:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	s2,-3(a3)	# MEM[(FLOAT *)_187 + -3B], MEM[(FLOAT *)_187 + -3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:45:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	lbu	t5,-1(a3)	# MEM[(FLOAT *)_187 + -1B], MEM[(FLOAT *)_187 + -1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:44:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	vmul.vx	v24,v8,s1	# result2, A0, MEM[(FLOAT *)_187 + -2B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:42:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v0,v8,s7	# result0, A0, MEM[(FLOAT *)_187 + -4B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:43:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v16,v8,s2	# result1, A0, MEM[(FLOAT *)_187 + -3B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:45:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	vmul.vx	v8,v8,t5	# result3, A0, MEM[(FLOAT *)_187 + -1B],
	addi	s1,sp,128	#, tmp1715,
	vs8r.v	v8,0(s1)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:47:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,a7,.L6	#, K, tmp1108,
	csrr	s2,vlenb	# tmp1711
	slli	s2,s2,3	#, tmp1712, tmp1711
	addi	s2,s2,128	#, tmp1713, tmp1710
	add	s2,s2,sp	#, tmp1710, tmp1710
	vs8r.v	v16,0(s2)	# result1, %sfp
	addi	s1,s5,8	#, ivtmp.640, ivtmp.647
	mv	t5,a3	# ivtmp.638, ivtmp.664
.L7:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:54:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(s1)	# A0,* ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:57:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s11,0(t5)	# MEM[(FLOAT *)_697], MEM[(FLOAT *)_697]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:58:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s8,1(t5)	# MEM[(FLOAT *)_697 + 1B], MEM[(FLOAT *)_697 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:59:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s7,2(t5)	# MEM[(FLOAT *)_697 + 2B], MEM[(FLOAT *)_697 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:60:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s2,3(t5)	# MEM[(FLOAT *)_697 + 3B], MEM[(FLOAT *)_697 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	t5,t5,4	#, ivtmp.638, ivtmp.638
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:57:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s11,v8	# result0, MEM[(FLOAT *)_697], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:58:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	csrr	s11,vlenb	# tmp1706
	slli	s11,s11,3	#, tmp1707, tmp1706
	addi	s11,s11,128	#, tmp1708, tmp1705
	add	s11,s11,sp	#, tmp1705, tmp1705
	vl8re8.v	v16,0(s11)	# %sfp, result1
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:59:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v24,s7,v8	# result2, MEM[(FLOAT *)_697 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:60:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	addi	s7,sp,128	#, tmp1698,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:47:             for (BLASLONG k = 1; k < K; k++) {
	addi	s1,s1,8	#, ivtmp.640, ivtmp.640
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:58:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v16,s8,v8	# result1, MEM[(FLOAT *)_697 + 1B], A0,
	vs8r.v	v16,0(s11)	# result1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:60:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v16,0(s7)	# %sfp, result3
	vmacc.vx	v16,s2,v8	# result3, MEM[(FLOAT *)_697 + 3B], A0,
	vs8r.v	v16,0(s7)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:47:             for (BLASLONG k = 1; k < K; k++) {
	bne	t5,a4,.L7	#, ivtmp.638, ivtmp.665,
	vl8re8.v	v16,0(s11)	# %sfp, result1
.L6:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:65:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v8,0(s4)	# c0,* ivtmp.648
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:73:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	csrr	s2,vlenb	# tmp1687
	slli	s2,s2,4	#, tmp1688, tmp1687
	addi	s2,s2,128	#, tmp1689, tmp1686
	add	s2,s2,sp	#, tmp1686, tmp1686
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:69:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s1,a1,s4	# ivtmp.648, _28, _275
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:73:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v8,a2,v0	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:71:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	t5,a1,s3	# ivtmp.649, _30, _275
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s6,s6,1	#, i, i
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	s5,s5,t3	# _942, ivtmp.647, ivtmp.647
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:73:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vs8r.v	v8,0(s2)	# c0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:67:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	csrr	s2,vlenb	# tmp1682
	slli	s2,s2,3	#, tmp1683, tmp1682
	addi	s2,s2,128	#, tmp1684, tmp1681
	add	s2,s2,sp	#, tmp1681, tmp1681
	vle8.v	v8,0(s3)	# c1,* ivtmp.649
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:69:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v0,0(s1)	# c2,* _28
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:67:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vs8r.v	v8,0(s2)	# c1, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:80:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	csrr	s2,vlenb	# tmp1677
	slli	s2,s2,4	#, tmp1678, tmp1677
	addi	s2,s2,128	#, tmp1679, tmp1676
	add	s2,s2,sp	#, tmp1676, tmp1676
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:75:             c2 = __riscv_vmacc_vx_i8m8(c2, alpha, result2, gvl);
	vmacc.vx	v0,a2,v24	# c2, alpha, result2,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:80:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vl8re8.v	v24,0(s2)	# %sfp, c0
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:71:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v8,0(t5)	# c3,* _30
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:74:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	csrr	s2,vlenb	# tmp1672
	slli	s2,s2,3	#, tmp1673, tmp1672
	addi	s2,s2,128	#, tmp1674, tmp1671
	add	s2,s2,sp	#, tmp1671, tmp1671
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:80:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v24,0(s4)	# c0,* ivtmp.648,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s4,s4,8	#, ivtmp.648, ivtmp.648
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:74:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vl8re8.v	v24,0(s2)	# %sfp, c1
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:76:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	addi	s2,sp,128	#, tmp1669,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:74:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vmacc.vx	v24,a2,v16	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:76:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	vl8re8.v	v16,0(s2)	# %sfp, result3
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:82:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v24,0(s3)	# c1,* ivtmp.649,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s3,s3,8	#, ivtmp.649, ivtmp.649
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:76:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	vmacc.vx	v8,a2,v16	# c3, alpha, result3,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:84:             __riscv_vse8_v_i8m8(&C[ci], c2, gvl);
	vse8.v	v0,0(s1)	# c2,* _28,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:86:             __riscv_vse8_v_i8m8(&C[ci], c3, gvl);
	vse8.v	v8,0(t5)	# c3,* _30,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:30:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	s6,a6,.L8	#, i, _930,
	ld	t5,56(sp)		# m_top, %sfp
.L5:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:92:         if (M & 4) {
	ld	s1,24(sp)		# _32, %sfp
	bne	s1,zero,.L127	#, _32,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:154:         if (M & 2) {
	ld	s1,32(sp)		# _63, %sfp
	bne	s1,zero,.L128	#, _63,,
.L12:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:191:         if (M & 1) {
	ld	s1,40(sp)		# _183, %sfp
	bne	s1,zero,.L129	#, _183,,
.L15:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ld	s1,48(sp)		# _2047, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	addi	t2,t2,1	#, j, j
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:26:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a3,a3,t0	# _2056, ivtmp.664, ivtmp.664
	add	t6,t6,s1	# _2047, ivtmp.660, ivtmp.660
	ld	s1,16(sp)		# _901, %sfp
	add	a4,a4,t0	# _2056, ivtmp.665, ivtmp.665
	blt	t2,s1,.L18	#, j, _901,
	mv	s11,s9	# ldc, ldc
	ld	t5,112(sp)		# N, %sfp
	ld	s9,120(sp)		# B, %sfp
	slli	a1,s1,2	#, n_top, _901
.L2:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:221:     if (N & 2) {
	andi	a5,t5,2	#, _256, N
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:221:     if (N & 2) {
	beq	a5,zero,.L125	#, _256,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ld	a3,8(sp)		# M, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a5,7		# tmp969,
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a0,a3,63	#, tmp965, M
	andi	a0,a0,7	#, tmp966, tmp965
	add	a0,a0,a3	# M, tmp967, tmp966
	srai	t0,a0,3	#, _854, tmp967
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	a3,a5,.L52	#, M, tmp969,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:227:             BLASLONG bi = n_top * K;
	mul	t2,t1,a1	# bi, K, n_top
	slli	a6,t1,1	#, _1021, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:238:             for (BLASLONG k = 1; k < K; k++) {
	li	s2,1		# tmp978,
	add	a6,s9,a6	# _1021, _2300, B
	slli	s3,t1,3	#, _1929, K
	mv	t3,s10	# ivtmp.609, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t6,0		# i,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:250:             BLASLONG ci = n_top * ldc + m_top;
	mul	a7,s11,a1	# _270, ldc, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:229:             int8_t B1 = B[bi + 1];
	add	s0,t2,s2	#, _260, bi
	add	a6,a6,t2	# bi, _1023, _2300
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:228:             int8_t B0 = B[bi + 0];
	add	s1,s9,t2	# bi, _259, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:229:             int8_t B1 = B[bi + 1];
	add	s0,s9,s0	# _260, _261, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:230:             bi += 2;
	addi	t2,t2,2	#, bi, bi
	add	a7,t4,a7	# _270, ivtmp.610, C
.L23:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:232:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(t3)	# A0,* ivtmp.609
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:235:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	a3,0(s1)	# *_259, *_259
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:236:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	a5,0(s0)	# *_261, *_261
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:235:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v16,v8,a3	# result0, A0, *_259,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:236:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v8,v8,a5	# result1, A0, *_261,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:238:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,s2,.L21	#, K, tmp978,
	add	a5,s9,t2	# bi, ivtmp.598, B
	addi	a3,t3,8	#, ivtmp.600, ivtmp.609
.L22:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:243:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a3)	# A0,* ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:246:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s4,0(a5)	# MEM[(FLOAT *)_297], MEM[(FLOAT *)_297]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:247:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a0,1(a5)	# MEM[(FLOAT *)_297 + 1B], MEM[(FLOAT *)_297 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:238:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,2	#, ivtmp.598, ivtmp.598
	addi	a3,a3,8	#, ivtmp.600, ivtmp.600
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:246:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,s4,v24	# result0, MEM[(FLOAT *)_297], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:247:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a0,v24	# result1, MEM[(FLOAT *)_297 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:238:             for (BLASLONG k = 1; k < K; k++) {
	bne	a5,a6,.L22	#, ivtmp.598, _1023,
.L21:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:252:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v0,0(a7)	# c0,* ivtmp.610
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:254:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a5,s11,a7	# ivtmp.610, _274, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:254:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v24,0(a5)	# c1,* _274
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t6,t6,1	#, i, i
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	t3,t3,s3	# _1929, ivtmp.609, ivtmp.609
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:256:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v0,a2,v16	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:257:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vmacc.vx	v24,a2,v8	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:261:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v0,0(a7)	# c0,* ivtmp.610,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a7,a7,8	#, ivtmp.610, ivtmp.610
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:263:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v24,0(a5)	# c1,* _274,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:225:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	t6,t0,.L23	#, i, _854,
	slli	a0,t0,3	#, m_top, _854
.L20:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:267:         if (M & 4) {
	ld	a5,8(sp)		# M, %sfp
	andi	a5,a5,4	#, _276, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:267:         if (M & 4) {
	beq	a5,zero,.L24	#, _276,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:270:             BLASLONG ai = m_top * K;
	mul	a4,t1,a0	# ai, K, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:268:             gvl = __riscv_vsetvl_e8m8(4);
	vsetivli	zero,4,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:282:             for (BLASLONG k = 1; k < K; k++) {
	li	a6,1		# tmp991,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:271:             BLASLONG bi = n_top * K;
	mul	a7,t1,a1	# bi, K, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:276:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	add	a3,s10,a4	# ai, _283, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:276:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(a3)	# A0,* _283
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:277:             ai += 4;
	addi	a3,a4,4	#, ai, ai
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:272:             int8_t B0 = B[bi + 0];
	add	a4,s9,a7	# bi, tmp985, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:279:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	t3,0(a4)	# *_279, *_279
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:280:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	a4,1(a4)	# *_281, *_281
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:279:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v16,v8,t3	# result0, A0, *_279,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:280:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v8,v8,a4	# result1, A0, *_281,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:274:             bi += 2;
	addi	a4,a7,2	#, bi, bi
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:282:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,a6,.L25	#, K, tmp991,
	slli	a6,t1,1	#, _311, K
	add	a6,s9,a6	# _311, _2278, B
	add	a4,s9,a4	# bi, ivtmp.582, B
	add	a3,s10,a3	# ai, ivtmp.584, A
	add	a6,a6,a7	# bi, _310, _2278
.L26:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:287:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v24,0(a3)	# A0,* ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:290:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	t3,0(a4)	# MEM[(FLOAT *)_315], MEM[(FLOAT *)_315]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:291:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	a7,1(a4)	# MEM[(FLOAT *)_315 + 1B], MEM[(FLOAT *)_315 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:282:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,2	#, ivtmp.582, ivtmp.582
	addi	a3,a3,4	#, ivtmp.584, ivtmp.584
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:290:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v16,t3,v24	# result0, MEM[(FLOAT *)_315], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:291:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v8,a7,v24	# result1, MEM[(FLOAT *)_315 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:282:             for (BLASLONG k = 1; k < K; k++) {
	bne	a6,a4,.L26	#, _310, ivtmp.582,
.L25:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:294:             BLASLONG ci = n_top * ldc + m_top;
	mul	a4,s11,a1	# _290, ldc, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:294:             BLASLONG ci = n_top * ldc + m_top;
	add	a4,a4,a0	# m_top, ci, _290
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:296:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a3,t4,a4	# ci, _292, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:296:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v0,0(a3)	# c0,* _292
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:297:             ci += ldc - gvl * 0;
	add	a4,s11,a4	# ci, ci_603, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:298:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a4,t4,a4	# ci_603, _294, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:298:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v24,0(a4)	# c1,* _294
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:308:             m_top += 4;
	addi	a0,a0,4	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:300:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v0,a2,v16	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:301:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vmacc.vx	v24,a2,v8	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:305:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v0,0(a3)	# c0,* _292,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:307:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v24,0(a4)	# c1,* _294,
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
.L24:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:311:         if (M & 2) {
	ld	a5,8(sp)		# M, %sfp
	andi	a5,a5,2	#, _295, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:311:         if (M & 2) {
	beq	a5,zero,.L27	#, _295,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:316:             BLASLONG ai = m_top * K;
	mul	a6,a0,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	t3,a2,0xff	# _2315, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:317:             BLASLONG bi = n_top * K;
	mul	a3,t1,a1	# bi, K, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:319:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L53	#, K,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp800,,,,
	vmv.v.i	v1,0	# vect_result3_1021.369,
	add	a6,s10,a6	# ai, vectp.371, A
	add	a3,s9,a3	# bi, vectp.377, B
	vmv1r.v	v8,v1	# vect_result3_1021.369, vect_result2_1019.368
	vmv1r.v	v7,v1	# vect_result3_1021.369, vect_result1_1017.367
	vmv1r.v	v6,v1	# vect_result3_1021.369, vect_result0_1015.366
	mv	a4,t1	# bnd.365, K
.L29:
	vsetvli	a5,a4,e8,m1,tu,ma	# bnd.365, _2042,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:320:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v4,(a6)	# vect_array.372, vectp.371,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:320:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v2,(a3)	# vect_array.378, vectp.377,
	slli	a7,a5,1	#, ivtmp_2102, _2042
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:319:             for (BLASLONG k = 0; k < K; k++) {
	sub	a4,a4,a5	# bnd.365, bnd.365, _2042
	add	a6,a6,a7	# ivtmp_2102, vectp.371, vectp.371
	add	a3,a3,a7	# ivtmp_2102, vectp.377, vectp.377
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:320:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v6,v4,v2	# vect_result0_1015.366, vect_array.372, vect_array.378,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:321:                 result1 += A[ai + 1] * B[bi + 0];
	vmacc.vv	v7,v5,v2	# vect_result1_1017.367, vect_array.372, vect_array.378,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:322:                 result2 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v8,v4,v3	# vect_result2_1019.368, vect_array.372, vect_array.378,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:323:                 result3 += A[ai + 1] * B[bi + 1];
	vmacc.vv	v1,v5,v3	# vect_result3_1021.369, vect_array.372, vect_array.378,
	bne	a4,zero,.L29	#, bnd.365,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp1146,,,,
	li	t6,0		# tmp1147,
	vmv.s.x	v5,t6	# tmp1145, tmp1147
	vredsum.vs	v1,v1,v5	# tmp1148, vect_result3_1021.369, tmp1145,
	vredsum.vs	v8,v8,v5	# tmp1153, vect_result2_1019.368, tmp1150,
	vredsum.vs	v7,v7,v5	# tmp1158, vect_result1_1017.367, tmp1155,
	vredsum.vs	v6,v6,v5	# tmp1163, vect_result0_1015.366, tmp1160,
	vmv.x.s	a4,v1	# tmp1001, tmp1148
	vmv.x.s	a3,v8	# tmp1002, tmp1153
	vmv.x.s	a6,v7	# tmp1003, tmp1158
	vmv.x.s	a7,v6	# tmp1004, tmp1163
	andi	a4,a4,0xff	# _2050, tmp1001
	andi	a3,a3,0xff	# _2060, tmp1002
	andi	a6,a6,0xff	# _2071, tmp1003
	andi	a7,a7,0xff	# _2082, tmp1004
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:332:             C[ci + 1 * ldc + 1] += alpha * result3;
	mulw	a4,a4,t3	# tmp1012, _2050, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:331:             C[ci + 1 * ldc + 0] += alpha * result2;
	mulw	a3,a3,t3	# tmp1010, _2060, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:332:             C[ci + 1 * ldc + 1] += alpha * result3;
	andi	a4,a4,0xff	# _2171, tmp1012
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:330:             C[ci + 0 * ldc + 1] += alpha * result1;
	mulw	a6,a6,t3	# tmp1008, _2071, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:331:             C[ci + 1 * ldc + 0] += alpha * result2;
	andi	a3,a3,0xff	# _2168, tmp1010
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a7,a7,t3	# tmp1006, _2082, _2315
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:330:             C[ci + 0 * ldc + 1] += alpha * result1;
	andi	a6,a6,0xff	# _2165, tmp1008
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a7,a7,0xff	# _2162, tmp1006
.L28:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:328:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s11,a1	# _324, ldc, n_top
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:328:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a0	# m_top, ci, _324
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	t0,t4,a5	# ci, _326, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	t6,0(t0)	# *_326, *_326
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:330:             C[ci + 0 * ldc + 1] += alpha * result1;
	add	t3,t4,a5	# _334, _335, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:331:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	a5,s11,a5	# ci, _343, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	a7,t6,a7	# _2162, tmp1017, *_326
	sb	a7,0(t0)	# tmp1017, *_326
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:330:             C[ci + 0 * ldc + 1] += alpha * result1;
	lbu	a7,1(t3)	# *_335, *_335
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:331:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	t6,t4,a5	# _343, _344, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:332:             C[ci + 1 * ldc + 1] += alpha * result3;
	add	a5,t4,a5	# _351, _352, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:330:             C[ci + 0 * ldc + 1] += alpha * result1;
	addw	a6,a7,a6	# _2165, tmp1022, *_335
	sb	a6,1(t3)	# tmp1022, *_335
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:331:             C[ci + 1 * ldc + 0] += alpha * result2;
	lbu	a6,0(t6)	# *_344, *_344
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:333:             m_top += 2;
	addi	a0,a0,2	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:331:             C[ci + 1 * ldc + 0] += alpha * result2;
	addw	a3,a6,a3	# _2168, tmp1026, *_344
	sb	a3,0(t6)	# tmp1026, *_344
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:332:             C[ci + 1 * ldc + 1] += alpha * result3;
	lbu	a3,1(a5)	# *_352, *_352
	addw	a4,a3,a4	# _2171, tmp1031, *_352
	sb	a4,1(a5)	# tmp1031, *_352
.L27:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:336:         if (M & 1) {
	ld	a5,8(sp)		# M, %sfp
	andi	a5,a5,1	#, _359, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:336:         if (M & 1) {
	beq	a5,zero,.L30	#, _359,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:339:             BLASLONG ai = m_top * K;
	mul	a7,a0,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	t3,a2,0xff	# _2314, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:340:             BLASLONG bi = n_top * K;
	mul	a3,t1,a1	# bi, K, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:342:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L54	#, K,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp804,,,,
	vmv.v.i	v1,0	# vect_result1_1028.339,
	addi	a6,a3,1	#, _2127, bi
	add	a7,s10,a7	# ai, vectp.341, A
	vmv1r.v	v2,v1	# vect_result1_1028.339, vect_result0_1026.338
	add	a6,s9,a6	# _2127, vectp.355, B
	add	a3,s9,a3	# bi, vectp.345, B
	mv	a4,t1	# bnd.337, K
.L32:
	vsetvli	a5,a4,e8,m1,tu,ma	# bnd.337, _2110,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:343:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v3,0(a7)	# vect__362.342,* vectp.341
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:343:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v5,0(a3)	# vect__366.346,* vectp.345
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:344:                 result1 += A[ai + 0] * B[bi + 1];
	vle8.v	v4,0(a6)	# vect__373.356,* vectp.355
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:342:             for (BLASLONG k = 0; k < K; k++) {
	sub	a4,a4,a5	# bnd.337, bnd.337, _2110
	add	a7,a7,a5	# _2110, vectp.341, vectp.341
	add	a3,a3,a5	# _2110, vectp.345, vectp.345
	add	a6,a6,a5	# _2110, vectp.355, vectp.355
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:343:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v2,v5,v3	# vect_result0_1026.338, vect__366.346, vect__362.342,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:344:                 result1 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v1,v4,v3	# vect_result1_1028.339, vect__373.356, vect__362.342,
	bne	a4,zero,.L32	#, bnd.337,,
	vsetvli	a4,zero,e8,m1,ta,ma	#, tmp1136,,,,
	li	a6,0		# tmp1137,
	vmv.s.x	v4,a6	# tmp1135, tmp1137
	vredsum.vs	v1,v1,v4	# tmp1138, vect_result1_1028.339, tmp1135,
	vredsum.vs	v2,v2,v4	# tmp1143, vect_result0_1026.338, tmp1140,
	vmv.x.s	a4,v1	# tmp1034, tmp1138
	vmv.x.s	a3,v2	# tmp1035, tmp1143
	andi	a4,a4,0xff	# _2118, tmp1034
	andi	a3,a3,0xff	# _2136, tmp1035
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:351:             C[ci + 1 * ldc + 0] += alpha * result1;
	mulw	a4,a4,t3	# tmp1039, _2118, _2314
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:350:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a3,a3,t3	# tmp1037, _2136, _2314
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:351:             C[ci + 1 * ldc + 0] += alpha * result1;
	andi	a4,a4,0xff	# _2212, tmp1039
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:350:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a3,a3,0xff	# _2209, tmp1037
.L31:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:349:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s11,a1	# _378, ldc, n_top
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:349:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a0	# m_top, ci, _378
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:350:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	a6,t4,a5	# ci, _380, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:350:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	a0,0(a6)	# *_380, *_380
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:351:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,s11,a5	# ci, _388, ldc
	add	a5,t4,a5	# _388, _390, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:350:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	a3,a0,a3	# _2209, tmp1044, *_380
	sb	a3,0(a6)	# tmp1044, *_380
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:351:             C[ci + 1 * ldc + 0] += alpha * result1;
	lbu	a3,0(a5)	# *_390, *_390
	addw	a4,a3,a4	# _2212, tmp1049, *_390
	sb	a4,0(a5)	# tmp1049, *_390
.L30:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:360:     if (N & 1) {
	andi	t5,t5,1	#, _397, N
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:355:         n_top += 2;
	addi	a1,a1,2	#, n_top, n_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:360:     if (N & 1) {
	bne	t5,zero,.L130	#, _397,,
.L105:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:469: }
	csrr	t0,vlenb	#
	li	t1,24		#,
	mul	t1,t1,t0	#,,
	li	a0,0		#,
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
	addi	sp,sp,224	#,,
	.cfi_def_cfa_offset 0
	jr	ra		#
.L129:
	.cfi_restore_state
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:196:             BLASLONG ai = m_top * K;
	mul	s3,t5,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:199:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L51	#, K,,
	vsetvli	s1,zero,e8,m1,ta,ma	#, tmp1111,,,,
	vmv.v.i	v2,0	# vect_result3_995.413,
	add	s3,s10,s3	# ai, vectp.415, A
	addi	s4,a3,-4	#, vectp.419, ivtmp.664
	vmv1r.v	v9,v2	# vect_result3_995.413, vect_result2_993.412
	vmv1r.v	v8,v2	# vect_result3_995.413, vect_result1_991.411
	vmv1r.v	v3,v2	# vect_result3_995.413, vect_result0_989.410
	mv	s2,t1	# ivtmp_1931, K
.L17:
	vsetvli	s1,s2,e8,m1,tu,ma	# ivtmp_1931, _1930,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:200:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e8.v	v4,(s4)	# vect_array.420, vectp.419,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:200:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v1,0(s3)	# vect__186.416,* vectp.415
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:199:             for (BLASLONG k = 0; k < K; k++) {
	slli	s5,s1,2	#, ivtmp_2012, _1930
	sub	s2,s2,s1	# ivtmp_1931, ivtmp_1931, _1930
	add	s3,s3,s1	# _1930, vectp.415, vectp.415
	add	s4,s4,s5	# ivtmp_2012, vectp.419, vectp.419
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:200:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v3,v1,v4	# vect_result0_989.410, vect__186.416, vect_array.420,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:201:                 result1 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v8,v1,v5	# vect_result1_991.411, vect__186.416, vect_array.420,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:202:                 result2 += A[ai + 0] * B[bi + 2];
	vmacc.vv	v9,v1,v6	# vect_result2_993.412, vect__186.416, vect_array.420,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:203:                 result3 += A[ai + 0] * B[bi + 3];
	vmacc.vv	v2,v1,v7	# vect_result3_995.413, vect__186.416, vect_array.420,
	bne	s2,zero,.L17	#, ivtmp_1931,,
	vsetvli	s3,zero,e8,m1,ta,ma	#, tmp1166,,,,
	li	s6,0		# tmp1167,
	vmv.s.x	v6,s6	# tmp1165, tmp1167
	vredsum.vs	v2,v2,v6	# tmp1168, vect_result3_995.413, tmp1165,
	vredsum.vs	v9,v9,v6	# tmp1173, vect_result2_993.412, tmp1170,
	vredsum.vs	v8,v8,v6	# tmp1178, vect_result1_991.411, tmp1175,
	vredsum.vs	v3,v3,v6	# tmp1183, vect_result0_989.410, tmp1180,
	vmv.x.s	s4,v2	# tmp931, tmp1168
	vmv.x.s	s3,v9	# tmp932, tmp1173
	vmv.x.s	s1,v8	# tmp933, tmp1178
	vmv.x.s	s2,v3	# tmp934, tmp1183
	andi	s4,s4,0xff	# _1938, tmp931
	andi	s3,s3,0xff	# _1976, tmp932
	andi	s1,s1,0xff	# _1987, tmp933
	andi	s2,s2,0xff	# _1998, tmp934
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:212:             C[ci + 3 * ldc + 0] += alpha * result3;
	mulw	s4,s4,s0	# tmp942, _1938, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:211:             C[ci + 2 * ldc + 0] += alpha * result2;
	mulw	s3,s3,s0	# tmp940, _1976, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:212:             C[ci + 3 * ldc + 0] += alpha * result3;
	andi	s7,s4,0xff	# _2033, tmp942
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:210:             C[ci + 1 * ldc + 0] += alpha * result1;
	mulw	s1,s1,s0	# tmp938, _1987, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:211:             C[ci + 2 * ldc + 0] += alpha * result2;
	andi	s6,s3,0xff	# _2030, tmp940
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:209:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	s2,s2,s0	# tmp936, _1998, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:210:             C[ci + 1 * ldc + 0] += alpha * result1;
	andi	s1,s1,0xff	# _2027, tmp938
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:209:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	s2,s2,0xff	# _2024, tmp936
.L16:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:208:             BLASLONG ci = n_top * ldc + m_top;
	add	t5,t6,t5	# m_top, ci, ivtmp.660
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:209:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	s5,t4,t5	# ci, _218, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:209:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	s4,0(s5)	# *_218, *_218
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:210:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	s3,s9,t5	# ci, _226, ldc
	add	s3,t4,s3	# _226, _228, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:209:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	s4,s4,s2	# _2024, tmp946, *_218
	sb	s4,0(s5)	# tmp946, *_218
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:210:             C[ci + 1 * ldc + 0] += alpha * result1;
	lbu	s4,0(s3)	# *_228, *_228
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:211:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	s2,a1,t5	# ci, _236, _275
	add	s2,t4,s2	# _236, _238, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:210:             C[ci + 1 * ldc + 0] += alpha * result1;
	addw	s4,s4,s1	# _2027, tmp951, *_228
	sb	s4,0(s3)	# tmp951, *_228
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:211:             C[ci + 2 * ldc + 0] += alpha * result2;
	lbu	s1,0(s2)	# *_238, *_238
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:212:             C[ci + 3 * ldc + 0] += alpha * result3;
	ld	s3,72(sp)		# _165, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:211:             C[ci + 2 * ldc + 0] += alpha * result2;
	addw	s1,s1,s6	# _2030, tmp956, *_238
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:212:             C[ci + 3 * ldc + 0] += alpha * result3;
	add	t5,s3,t5	# ci, _246, _165
	add	t5,t4,t5	# _246, _248, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:211:             C[ci + 2 * ldc + 0] += alpha * result2;
	sb	s1,0(s2)	# tmp956, *_238
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:212:             C[ci + 3 * ldc + 0] += alpha * result3;
	lbu	s1,0(t5)	# *_248, *_248
	addw	s1,s1,s7	# _2033, tmp961, *_248
	sb	s1,0(t5)	# tmp961, *_248
	j	.L15		#
.L127:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:95:             BLASLONG ai = m_top * K;
	mul	s1,t1,t5	# ai, K, m_top
	vsetivli	zero,4,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:108:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	lbu	s4,-2(a3)	# MEM[(FLOAT *)_186 + -2B], MEM[(FLOAT *)_186 + -2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:109:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	lbu	s3,-1(a3)	# MEM[(FLOAT *)_186 + -1B], MEM[(FLOAT *)_186 + -1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:106:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	s6,-4(a3)	# MEM[(FLOAT *)_186 + -4B], MEM[(FLOAT *)_186 + -4B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:107:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	lbu	s5,-3(a3)	# MEM[(FLOAT *)_186 + -3B], MEM[(FLOAT *)_186 + -3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:103:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	add	s2,s10,s1	# ai, _43, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:103:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(s2)	# A0,* _43
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:108:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	addi	s2,sp,128	#, tmp1667,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:104:             ai += 4;
	addi	s1,s1,4	#, ai, ai
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:108:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	vmul.vx	v8,v16,s4	# result2, A0, MEM[(FLOAT *)_186 + -2B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:106:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v0,v16,s6	# result0, A0, MEM[(FLOAT *)_186 + -4B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:107:             vint8m8_t result1 = __riscv_vmul_vx_i8m8(A0, B1, gvl);
	vmul.vx	v24,v16,s5	# result1, A0, MEM[(FLOAT *)_186 + -3B],
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:108:             vint8m8_t result2 = __riscv_vmul_vx_i8m8(A0, B2, gvl);
	vs8r.v	v8,0(s2)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:109:             vint8m8_t result3 = __riscv_vmul_vx_i8m8(A0, B3, gvl);
	vmul.vx	v8,v16,s3	# result3, A0, MEM[(FLOAT *)_186 + -1B],
	csrr	s2,vlenb	# tmp1663
	slli	s2,s2,3	#, tmp1664, tmp1663
	addi	s2,s2,128	#, tmp1665, tmp1662
	add	s2,s2,sp	#, tmp1662, tmp1662
	vs8r.v	v8,0(s2)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:111:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,a7,.L10	#, K, tmp1108,
	add	s2,s10,s1	# ai, ivtmp.626, A
	mv	s1,a3	# ivtmp.624, ivtmp.664
.L11:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:118:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(s2)	# A0,* ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:122:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	lbu	s5,1(s1)	# MEM[(FLOAT *)_1048 + 1B], MEM[(FLOAT *)_1048 + 1B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:123:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	lbu	s4,2(s1)	# MEM[(FLOAT *)_1048 + 2B], MEM[(FLOAT *)_1048 + 2B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:124:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	lbu	s3,3(s1)	# MEM[(FLOAT *)_1048 + 3B], MEM[(FLOAT *)_1048 + 3B]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:121:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s6,0(s1)	# MEM[(FLOAT *)_1048], MEM[(FLOAT *)_1048]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	s1,s1,4	#, ivtmp.624, ivtmp.624
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:122:                 result1 = __riscv_vmacc_vx_i8m8(result1, B1, A0, gvl);
	vmacc.vx	v24,s5,v8	# result1, MEM[(FLOAT *)_1048 + 1B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:123:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	addi	s5,sp,128	#, tmp1660,
	vl8re8.v	v16,0(s5)	# %sfp, result2
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:121:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v0,s6,v8	# result0, MEM[(FLOAT *)_1048], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:111:             for (BLASLONG k = 1; k < K; k++) {
	addi	s2,s2,4	#, ivtmp.626, ivtmp.626
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:123:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vmacc.vx	v16,s4,v8	# result2, MEM[(FLOAT *)_1048 + 2B], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:124:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	csrr	s4,vlenb	# tmp1654
	slli	s4,s4,3	#, tmp1655, tmp1654
	addi	s4,s4,128	#, tmp1656, tmp1653
	add	s4,s4,sp	#, tmp1653, tmp1653
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:123:                 result2 = __riscv_vmacc_vx_i8m8(result2, B2, A0, gvl);
	vs8r.v	v16,0(s5)	# result2, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:124:                 result3 = __riscv_vmacc_vx_i8m8(result3, B3, A0, gvl);
	vl8re8.v	v16,0(s4)	# %sfp, result3
	vmacc.vx	v16,s3,v8	# result3, MEM[(FLOAT *)_1048 + 3B], A0,
	vs8r.v	v16,0(s4)	# result3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:111:             for (BLASLONG k = 1; k < K; k++) {
	bne	s1,a4,.L11	#, ivtmp.624, ivtmp.665,
.L10:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:127:             BLASLONG ci = n_top * ldc + m_top;
	add	s1,t6,t5	# m_top, ci, ivtmp.660
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:129:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s4,t4,s1	# ci, _56, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:129:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v8,0(s4)	# c0,* _56
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:130:             ci += ldc - gvl * 0;
	add	s1,s9,s1	# ci, ci, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:137:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	csrr	s5,vlenb	# tmp1644
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:131:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s3,t4,s1	# ci, _58, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:137:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	slli	s5,s5,4	#, tmp1645, tmp1644
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:132:             ci += ldc - gvl * 0;
	add	s1,s9,s1	# ci, ci, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:137:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v8,a2,v0	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:134:             ci += ldc - gvl * 0;
	add	s2,s9,s1	# ci, ci_747, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:137:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	addi	s5,s5,128	#, tmp1646, tmp1643
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:135:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s2,t4,s2	# ci_747, _62, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:137:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	add	s5,s5,sp	#, tmp1643, tmp1643
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:135:             vint8m8_t c3 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(s2)	# c3,* _62
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:137:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vs8r.v	v8,0(s5)	# c0, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:140:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	csrr	s5,vlenb	# tmp1639
	slli	s5,s5,3	#, tmp1640, tmp1639
	addi	s5,s5,128	#, tmp1641, tmp1638
	add	s5,s5,sp	#, tmp1638, tmp1638
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:133:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	s1,t4,s1	# ci, _60, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:140:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	vl8re8.v	v8,0(s5)	# %sfp, result3
	csrr	s5,vlenb	# tmp1634
	slli	s5,s5,3	#, tmp1635, tmp1634
	addi	s5,s5,128	#, tmp1636, tmp1633
	add	s5,s5,sp	#, tmp1633, tmp1633
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:131:             vint8m8_t c1 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v0,0(s3)	# c1,* _58
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:140:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	vmacc.vx	v16,a2,v8	# c3, alpha, result3,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:151:             m_top += 4;
	addi	t5,t5,4	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:140:             c3 = __riscv_vmacc_vx_i8m8(c3, alpha, result3, gvl);
	vs8r.v	v16,0(s5)	# c3, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:144:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	csrr	s5,vlenb	# tmp1629
	slli	s5,s5,4	#, tmp1630, tmp1629
	addi	s5,s5,128	#, tmp1631, tmp1628
	add	s5,s5,sp	#, tmp1628, tmp1628
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:138:             c1 = __riscv_vmacc_vx_i8m8(c1, alpha, result1, gvl);
	vmacc.vx	v0,a2,v24	# c1, alpha, result1,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:144:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vl8re8.v	v8,0(s5)	# %sfp, c0
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:133:             vint8m8_t c2 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(s1)	# c2,* _60
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:144:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v8,0(s4)	# c0,* _56,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:139:             c2 = __riscv_vmacc_vx_i8m8(c2, alpha, result2, gvl);
	addi	s4,sp,128	#, tmp1626,
	vl8re8.v	v8,0(s4)	# %sfp, result2
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:146:             __riscv_vse8_v_i8m8(&C[ci], c1, gvl);
	vse8.v	v0,0(s3)	# c1,* _58,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:139:             c2 = __riscv_vmacc_vx_i8m8(c2, alpha, result2, gvl);
	vmacc.vx	v16,a2,v8	# c2, alpha, result2,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:148:             __riscv_vse8_v_i8m8(&C[ci], c2, gvl);
	vse8.v	v16,0(s1)	# c2,* _60,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:150:             __riscv_vse8_v_i8m8(&C[ci], c3, gvl);
	csrr	s1,vlenb	# tmp1622
	slli	s1,s1,3	#, tmp1623, tmp1622
	addi	s1,s1,128	#, tmp1624, tmp1621
	add	s1,s1,sp	#, tmp1621, tmp1621
	vl8re8.v	v16,0(s1)	# %sfp, c3
	vse8.v	v16,0(s2)	# c3,* _62,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:154:         if (M & 2) {
	ld	s1,32(sp)		# _63, %sfp
	beq	s1,zero,.L12	#, _63,,
.L128:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:163:             BLASLONG ai = m_top * K;
	mul	s3,t5,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:166:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L50	#, K,,
	vsetvli	s1,zero,e8,m1,ta,ma	#, tmp1111,,,,
	vmv.v.i	v1,0	# vect_result7_984.462,
	add	s3,s10,s3	# ai, vectp.464, A
	addi	s4,a3,-4	#, vectp.470, ivtmp.664
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
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v2,(s3)	# vect_array.465, vectp.464,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e8.v	v4,(s4)	# vect_array.471, vectp.470,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:166:             for (BLASLONG k = 0; k < K; k++) {
	slli	s6,s1,1	#, ivtmp_1918, _1814
	slli	s5,s1,2	#, ivtmp_1910, _1814
	sub	s2,s2,s1	# ivtmp_1815, ivtmp_1815, _1814
	add	s3,s3,s6	# ivtmp_1918, vectp.464, vectp.464
	add	s4,s4,s5	# ivtmp_1910, vectp.470, vectp.470
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:167:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v8,v2,v4	# vect_result0_970.455, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:168:                 result1 += A[ai + 1] * B[bi + 0];
	vmacc.vv	v9,v3,v4	# vect_result1_972.456, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:169:                 result2 += A[ai + 0] * B[bi + 1];
	vmacc.vv	v10,v2,v5	# vect_result2_974.457, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:170:                 result3 += A[ai + 1] * B[bi + 1];
	vmacc.vv	v11,v3,v5	# vect_result3_976.458, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:171:                 result4 += A[ai + 0] * B[bi + 2];
	vmacc.vv	v12,v2,v6	# vect_result4_978.459, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:172:                 result5 += A[ai + 1] * B[bi + 2];
	vmacc.vv	v13,v3,v6	# vect_result5_980.460, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:173:                 result6 += A[ai + 0] * B[bi + 3];
	vmacc.vv	v14,v2,v7	# vect_result6_982.461, vect_array.465, vect_array.471,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:174:                 result7 += A[ai + 1] * B[bi + 3];
	vmacc.vv	v1,v3,v7	# vect_result7_984.462, vect_array.465, vect_array.471,
	bne	s2,zero,.L14	#, ivtmp_1815,,
	vsetvli	s5,zero,e8,m1,ta,ma	#, tmp1186,,,,
	li	s11,0		# tmp1187,
	vmv.s.x	v16,s11	# tmp1185, tmp1187
	vredsum.vs	v12,v12,v16	# tmp1203, vect_result4_978.459, tmp1200,
	vredsum.vs	v11,v11,v16	# tmp1208, vect_result3_976.458, tmp1205,
	vredsum.vs	v10,v10,v16	# tmp1213, vect_result2_974.457, tmp1210,
	vredsum.vs	v1,v1,v16	# tmp1188, vect_result7_984.462, tmp1185,
	vredsum.vs	v14,v14,v16	# tmp1193, vect_result6_982.461, tmp1190,
	vredsum.vs	v13,v13,v16	# tmp1198, vect_result5_980.460, tmp1195,
	vredsum.vs	v9,v9,v16	# tmp1218, vect_result1_972.456, tmp1215,
	vredsum.vs	v8,v8,v16	# tmp1223, vect_result0_970.455, tmp1220,
	vmv.x.s	s5,v12	# tmp873, tmp1203
	vmv.x.s	s4,v11	# tmp874, tmp1208
	vmv.x.s	s3,v10	# tmp875, tmp1213
	vmv.x.s	s8,v1	# tmp870, tmp1188
	vmv.x.s	s7,v14	# tmp871, tmp1193
	vmv.x.s	s6,v13	# tmp872, tmp1198
	vmv.x.s	s1,v9	# tmp876, tmp1218
	vmv.x.s	s2,v8	# tmp877, tmp1223
	andi	s5,s5,0xff	# _1853, tmp873
	andi	s4,s4,0xff	# _1864, tmp874
	andi	s3,s3,0xff	# _1874, tmp875
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	mulw	s5,s5,s0	# tmp887, _1853, _2317
	andi	s8,s8,0xff	# _1822, tmp870
	andi	s7,s7,0xff	# _1832, tmp871
	andi	s6,s6,0xff	# _1843, tmp872
	andi	s1,s1,0xff	# _1885, tmp876
	andi	s2,s2,0xff	# _1896, tmp877
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	mulw	s4,s4,s0	# tmp885, _1864, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	andi	s5,s5,0xff	# _1955, tmp887
	sd	s5,96(sp)	# _1955, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	mulw	s3,s3,s0	# tmp883, _1874, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	andi	s4,s4,0xff	# _1952, tmp885
	sd	s4,88(sp)	# _1952, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:187:             C[ci + 3 * ldc + 1] += alpha * result7;
	mulw	s8,s8,s0	# tmp893, _1822, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	andi	s3,s3,0xff	# _1949, tmp883
	sd	s3,80(sp)	# _1949, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	mulw	s7,s7,s0	# tmp891, _1832, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:187:             C[ci + 3 * ldc + 1] += alpha * result7;
	andi	s8,s8,0xff	# _1964, tmp893
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	mulw	s6,s6,s0	# tmp889, _1843, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	andi	s7,s7,0xff	# _1961, tmp891
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	mulw	s1,s1,s0	# tmp881, _1885, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	andi	s11,s6,0xff	# _1958, tmp889
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	s2,s2,s0	# tmp879, _1896, _2317
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	andi	s4,s1,0xff	# _1946, tmp881
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	s2,s2,0xff	# _1943, tmp879
.L13:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:179:             BLASLONG ci = n_top * ldc + m_top;
	add	s1,t6,t5	# m_top, ci, ivtmp.660
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	s6,t4,s1	# ci, _114, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	s5,0(s6)	# *_114, *_114
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	add	s3,t4,s1	# _122, _123, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:188:             m_top += 2;
	addi	t5,t5,2	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:180:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	s5,s5,s2	# _1943, tmp897, *_114
	sb	s5,0(s6)	# tmp897, *_114
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	lbu	s5,1(s3)	# *_123, *_123
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	s2,s9,s1	# ci, _131, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	ld	s6,88(sp)		# _1952, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:181:             C[ci + 0 * ldc + 1] += alpha * result1;
	addw	s5,s5,s4	# _1946, tmp902, *_123
	sb	s5,1(s3)	# tmp902, *_123
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	s5,t4,s2	# _131, _132, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	lbu	s4,0(s5)	# *_132, *_132
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	add	s3,t4,s2	# _139, _140, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:182:             C[ci + 1 * ldc + 0] += alpha * result2;
	ld	s2,80(sp)		# _1949, %sfp
	addw	s4,s4,s2	# _1949, tmp906, *_132
	sb	s4,0(s5)	# tmp906, *_132
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	lbu	s4,1(s3)	# *_140, *_140
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	s2,a1,s1	# ci, _149, _275
	add	s5,t4,s2	# _149, _150, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:183:             C[ci + 1 * ldc + 1] += alpha * result3;
	addw	s4,s4,s6	# _1952, tmp911, *_140
	sb	s4,1(s3)	# tmp911, *_140
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	lbu	s3,0(s5)	# *_150, *_150
	ld	s4,96(sp)		# _1955, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	add	s2,t4,s2	# _157, _158, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:184:             C[ci + 2 * ldc + 0] += alpha * result4;
	addw	s3,s3,s4	# _1955, tmp915, *_150
	sb	s3,0(s5)	# tmp915, *_150
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	lbu	s3,1(s2)	# *_158, *_158
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	ld	s4,72(sp)		# _165, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	addw	s3,s3,s11	# _1958, tmp920, *_158
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	s1,s4,s1	# ci, _167, _165
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:185:             C[ci + 2 * ldc + 1] += alpha * result5;
	sb	s3,1(s2)	# tmp920, *_158
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	s4,t4,s1	# _167, _168, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	lbu	s2,0(s4)	# *_168, *_168
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:187:             C[ci + 3 * ldc + 1] += alpha * result7;
	add	s1,t4,s1	# _175, _176, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:186:             C[ci + 3 * ldc + 0] += alpha * result6;
	addw	s2,s2,s7	# _1961, tmp924, *_168
	sb	s2,0(s4)	# tmp924, *_168
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:187:             C[ci + 3 * ldc + 1] += alpha * result7;
	lbu	s2,1(s1)	# *_176, *_176
	addw	s2,s2,s8	# _1964, tmp929, *_176
	sb	s2,1(s1)	# tmp929, *_176
	j	.L12		#
.L49:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:27:         m_top = 0;
	li	t5,0		# m_top,
	j	.L5		#
.L125:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:360:     if (N & 1) {
	andi	t5,t5,1	#, _397, N
	vsetivli	zero,8,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:360:     if (N & 1) {
	beq	t5,zero,.L105	#, _397,,
.L130:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ld	a0,8(sp)		# M, %sfp
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a5,7		# tmp1057,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a4,a0,63	#, tmp1053, M
	andi	a4,a4,7	#, tmp1054, tmp1053
	add	a4,a4,a0	# M, tmp1055, tmp1054
	srai	t5,a4,3	#, _877, tmp1055
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	a0,a5,.L55	#, M, tmp1057,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:366:             BLASLONG bi = n_top * K;
	mul	a5,a1,t1	# bi.226_399, n_top, K
	add	a0,s9,t1	# K, _2276, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:375:             for (BLASLONG k = 1; k < K; k++) {
	li	t2,1		# tmp1061,
	slli	s0,t1,3	#, _972, K
	mv	a7,s10	# ivtmp.567, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t3,0		# i,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:385:             BLASLONG ci = n_top * ldc + m_top;
	mul	a6,a1,s11	# _407, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:367:             int8_t B0 = B[bi + 0];
	add	t0,s9,a5	# bi.226_399, _400, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:368:             bi += 1;
	add	t6,a5,t2	#, bi, bi.226_399
	add	a0,a0,a5	# bi.226_399, _66, _2276
	add	a6,t4,a6	# _407, ivtmp.568, C
.L38:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:370:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(a7)	# A0,* ivtmp.567
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:373:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	a5,0(t0)	# *_400, *_400
	vmul.vx	v8,v8,a5	# result0, A0, *_400,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:375:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,t2,.L36	#, K, tmp1061,
	add	a5,s9,t6	# bi, ivtmp.558, B
	addi	a4,a7,8	#, ivtmp.560, ivtmp.567
.L37:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:379:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a4)	# A0,* ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:382:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	s1,0(a5)	# MEM[(FLOAT *)_71], MEM[(FLOAT *)_71]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:375:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a5,1	#, ivtmp.558, ivtmp.558
	addi	a4,a4,8	#, ivtmp.560, ivtmp.560
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:382:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,s1,v16	# result0, MEM[(FLOAT *)_71], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:375:             for (BLASLONG k = 1; k < K; k++) {
	bne	a0,a5,.L37	#, _66, ivtmp.558,
.L36:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:387:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(a6)	# c0,* ivtmp.568
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t3,t3,1	#, i, i
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a7,a7,s0	# _972, ivtmp.567, ivtmp.567
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:388:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v16,a2,v8	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:392:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v16,0(a6)	# c0,* ivtmp.568,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:364:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a6,a6,8	#, ivtmp.568, ivtmp.568
	blt	t3,t5,.L38	#, i, _877,
	slli	a4,t5,3	#, m_top, _877
.L35:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:396:         if (M & 4) {
	ld	a5,8(sp)		# M, %sfp
	andi	a5,a5,4	#, _411, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:396:         if (M & 4) {
	beq	a5,zero,.L39	#, _411,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:399:             BLASLONG ai = m_top * K;
	mul	a5,t1,a4	# ai, K, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:397:             gvl = __riscv_vsetvl_e8m8(4);
	vsetivli	zero,4,e8,m8,ta,ma	#,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:409:             for (BLASLONG k = 1; k < K; k++) {
	li	a6,1		# tmp1070,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:400:             BLASLONG bi = n_top * K;
	mul	a7,a1,t1	# bi, n_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:404:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	add	a3,s10,a5	# ai, _416, A
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:404:             vint8m8_t A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v8,0(a3)	# A0,* _416
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:405:             ai += 4;
	addi	a5,a5,4	#, ai, ai
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:401:             int8_t B0 = B[bi + 0];
	add	a3,s9,a7	# bi, tmp1067, B
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:407:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	lbu	t3,0(a3)	# *_414, *_414
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:402:             bi += 1;
	add	a3,a7,a6	#, bi, bi
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:407:             vint8m8_t result0 = __riscv_vmul_vx_i8m8(A0, B0, gvl);
	vmul.vx	v8,v8,t3	# result0, A0, *_414,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:409:             for (BLASLONG k = 1; k < K; k++) {
	ble	t1,a6,.L40	#, K, tmp1070,
	add	a6,s9,t1	# K, _2275, B
	add	a3,s9,a3	# bi, ivtmp.544, B
	add	a5,s10,a5	# ai, ivtmp.546, A
	add	a6,a6,a7	# bi, _82, _2275
.L41:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:413:                 A0 = __riscv_vle8_v_i8m8(&A[ai + 0 * gvl], gvl);
	vle8.v	v16,0(a5)	# A0,* ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:416:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	lbu	a7,0(a3)	# MEM[(FLOAT *)_87], MEM[(FLOAT *)_87]
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:409:             for (BLASLONG k = 1; k < K; k++) {
	addi	a3,a3,1	#, ivtmp.544, ivtmp.544
	addi	a5,a5,4	#, ivtmp.546, ivtmp.546
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:416:                 result0 = __riscv_vmacc_vx_i8m8(result0, B0, A0, gvl);
	vmacc.vx	v8,a7,v16	# result0, MEM[(FLOAT *)_87], A0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:409:             for (BLASLONG k = 1; k < K; k++) {
	bne	a6,a3,.L41	#, _82, ivtmp.544,
.L40:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:419:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,a1,s11	# _421, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:419:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci_679, _421
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:421:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	add	a5,t4,a5	# ci_679, _423, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:421:             vint8m8_t c0 = __riscv_vle8_v_i8m8(&C[ci], gvl);
	vle8.v	v16,0(a5)	# c0,* _423
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:427:             m_top += 4;
	addi	a4,a4,4	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:422:             c0 = __riscv_vmacc_vx_i8m8(c0, alpha, result0, gvl);
	vmacc.vx	v16,a2,v8	# c0, alpha, result0,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:426:             __riscv_vse8_v_i8m8(&C[ci], c0, gvl);
	vse8.v	v16,0(a5)	# c0,* _423,
.L39:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:430:         if (M & 2) {
	ld	a5,8(sp)		# M, %sfp
	andi	a5,a5,2	#, _424, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:430:         if (M & 2) {
	beq	a5,zero,.L42	#, _424,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:433:             BLASLONG ai = m_top * K;
	mul	a6,a4,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a7,a2,0xff	# _2313, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:434:             BLASLONG bi = n_top * K;
	mul	a0,a1,t1	# bi, n_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:436:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L56	#, K,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp806,,,,
	vmv.v.i	v1,0	# vect_result1_1046.312,
	add	a6,s10,a6	# ai, vectp.314, A
	add	a0,s9,a0	# bi, vectp.320, B
	vmv1r.v	v2,v1	# vect_result1_1046.312, vect_result0_1044.311
	mv	a3,t1	# bnd.310, K
.L44:
	vsetvli	a5,a3,e8,m1,tu,ma	# bnd.310, _2175,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:437:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e8.v	v4,(a6)	# vect_array.315, vectp.314,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:437:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v3,0(a0)	# vect__431.321,* vectp.320
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:436:             for (BLASLONG k = 0; k < K; k++) {
	slli	t3,a5,1	#, ivtmp_2222, _2175
	sub	a3,a3,a5	# bnd.310, bnd.310, _2175
	add	a0,a0,a5	# _2175, vectp.320, vectp.320
	add	a6,a6,t3	# ivtmp_2222, vectp.314, vectp.314
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:437:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v2,v3,v4	# vect_result0_1044.311, vect__431.321, vect_array.315,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:438:                 result1 += A[ai + 1] * B[bi + 0];
	vmacc.vv	v1,v3,v5	# vect_result1_1046.312, vect__431.321, vect_array.315,
	bne	a3,zero,.L44	#, bnd.310,,
	vsetvli	a3,zero,e8,m1,ta,ma	#, tmp1126,,,,
	li	a6,0		# tmp1127,
	vmv.s.x	v4,a6	# tmp1125, tmp1127
	vredsum.vs	v1,v1,v4	# tmp1128, vect_result1_1046.312, tmp1125,
	vredsum.vs	v2,v2,v4	# tmp1133, vect_result0_1044.311, tmp1130,
	vmv.x.s	a3,v1	# tmp1078, tmp1128
	vmv.x.s	a0,v2	# tmp1079, tmp1133
	andi	a3,a3,0xff	# _2183, tmp1078
	andi	a0,a0,0xff	# _2194, tmp1079
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:445:             C[ci + 0 * ldc + 1] += alpha * result1;
	mulw	a3,a3,a7	# tmp1083, _2183, _2313
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:444:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a0,a0,a7	# tmp1081, _2194, _2313
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:445:             C[ci + 0 * ldc + 1] += alpha * result1;
	andi	a3,a3,0xff	# _2287, tmp1083
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:444:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a0,a0,0xff	# _2284, tmp1081
.L43:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:443:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,a1,s11	# _443, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:443:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci.258_444, _443
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:444:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	a7,t4,a5	# ci.258_444, _445, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:444:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	a6,0(a7)	# *_445, *_445
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:445:             C[ci + 0 * ldc + 1] += alpha * result1;
	add	a5,t4,a5	# _453, _454, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:446:             m_top += 2;
	addi	a4,a4,2	#, m_top, m_top
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:444:             C[ci + 0 * ldc + 0] += alpha * result0;
	addw	a0,a6,a0	# _2284, tmp1088, *_445
	sb	a0,0(a7)	# tmp1088, *_445
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:445:             C[ci + 0 * ldc + 1] += alpha * result1;
	lbu	a0,1(a5)	# *_454, *_454
	addw	a3,a0,a3	# _2287, tmp1093, *_454
	sb	a3,1(a5)	# tmp1093, *_454
.L42:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:449:         if (M & 1) {
	ld	a5,8(sp)		# M, %sfp
	andi	a5,a5,1	#, _461, M
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:449:         if (M & 1) {
	beq	a5,zero,.L105	#, _461,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:451:             BLASLONG ai = m_top * K;
	mul	a5,a4,t1	# ai, m_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:329:             C[ci + 0 * ldc + 0] += alpha * result0;
	andi	a2,a2,0xff	# _2312, alpha
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:452:             BLASLONG bi = n_top * K;
	mul	a3,a1,t1	# bi, n_top, K
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:454:             for (BLASLONG k = 0; k < K; k++) {
	ble	t1,zero,.L57	#, K,,
	vsetvli	a0,zero,e8,m1,ta,ma	#, tmp808,,,,
	vmv.v.i	v1,0	# vect_result0_1051.294,
	add	a5,s10,a5	# ai, vectp.296, A
	add	s9,s9,a3	# bi, vectp.300, B
.L47:
	vsetvli	a3,t1,e8,m1,tu,ma	# bnd.293, _2228,,,,
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:455:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v2,0(a5)	# vect__464.297,* vectp.296
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:455:                 result0 += A[ai + 0] * B[bi + 0];
	vle8.v	v3,0(s9)	# vect__468.301,* vectp.300
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:454:             for (BLASLONG k = 0; k < K; k++) {
	sub	t1,t1,a3	# bnd.293, bnd.293, _2228
	add	a5,a5,a3	# _2228, vectp.296, vectp.296
	add	s9,s9,a3	# _2228, vectp.300, vectp.300
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:455:                 result0 += A[ai + 0] * B[bi + 0];
	vmacc.vv	v1,v3,v2	# vect_result0_1051.294, vect__468.301, vect__464.297,
	bne	t1,zero,.L47	#, bnd.293,,
	vsetvli	a5,zero,e8,m1,ta,ma	#, tmp1121,,,,
	li	a3,0		# tmp1122,
	vmv.s.x	v2,a3	# tmp1120, tmp1122
	vredsum.vs	v1,v1,v2	# tmp1123, vect_result0_1051.294, tmp1120,
	vmv.x.s	a3,v1	# tmp1095, tmp1123
	andi	a3,a3,0xff	# _2236, tmp1095
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:461:             C[ci + 0 * ldc + 0] += alpha * result0;
	mulw	a3,a3,a2	# tmp1097, _2236, _2312
	andi	a3,a3,0xff	# _2308, tmp1097
.L46:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:460:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,a1,s11	# _473, n_top, ldc
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:460:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,a4	# m_top, ci_703, _473
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:461:             C[ci + 0 * ldc + 0] += alpha * result0;
	add	t4,t4,a5	# ci_703, _475, C
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:461:             C[ci + 0 * ldc + 0] += alpha * result0;
	lbu	a5,0(t4)	# *_475, *_475
	addw	a5,a5,a3	# _2308, tmp1103, *_475
	sb	a5,0(t4)	# tmp1103, *_475
	j	.L105		#
.L126:
	slli	a0,a6,3	#, _2260, _930
	sd	a0,56(sp)	# _2260, %sfp
	j	.L4		#
.L51:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:199:             for (BLASLONG k = 0; k < K; k++) {
	li	s7,0		# _2033,
	li	s6,0		# _2030,
	li	s1,0		# _2027,
	li	s2,0		# _2024,
	j	.L16		#
.L50:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:166:             for (BLASLONG k = 0; k < K; k++) {
	li	s8,0		# _1964,
	li	s7,0		# _1961,
	li	s11,0		# _1958,
	sd	zero,96(sp)	#, %sfp
	sd	zero,88(sp)	#, %sfp
	sd	zero,80(sp)	#, %sfp
	li	s4,0		# _1946,
	li	s2,0		# _1943,
	j	.L13		#
.L55:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:362:         m_top = 0;
	li	a4,0		# m_top,
	j	.L35		#
.L52:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:223:         m_top = 0;
	li	a0,0		# m_top,
	j	.L20		#
.L48:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:22:     BLASLONG n_top = 0;
	li	a1,0		# n_top,
	j	.L2		#
.L54:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:342:             for (BLASLONG k = 0; k < K; k++) {
	li	a4,0		# _2212,
	li	a3,0		# _2209,
	j	.L31		#
.L56:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:436:             for (BLASLONG k = 0; k < K; k++) {
	li	a3,0		# _2287,
	li	a0,0		# _2284,
	j	.L43		#
.L57:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:454:             for (BLASLONG k = 0; k < K; k++) {
	li	a3,0		# _2308,
	j	.L46		#
.L53:
# igemm_kernel_8x4_zvl128b_lmul8_unroll1_i8i32.c:319:             for (BLASLONG k = 0; k < K; k++) {
	li	a4,0		# _2171,
	li	a3,0		# _2168,
	li	a6,0		# _2165,
	li	a7,0		# _2162,
	j	.L28		#
	.cfi_endproc
.LFE0:
	.size	dgemm_kernel_8x4_zvl128b_lmul8_unroll1, .-dgemm_kernel_8x4_zvl128b_lmul8_unroll1
	.ident	"GCC: (Bianbu 14.2.0-4ubuntu2~24.04bb1) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
