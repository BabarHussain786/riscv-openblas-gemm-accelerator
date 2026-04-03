	.file	"dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c"
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
	.globl	dgemm_kernel_8x4_zvl128b_lmul8_unroll2
	.type	dgemm_kernel_8x4_zvl128b_lmul8_unroll2, @function
dgemm_kernel_8x4_zvl128b_lmul8_unroll2:
.LFB0:
	.cfi_startproc
	csrr	t0,vlenb	#
	addi	sp,sp,-160	#,,
	.cfi_def_cfa_offset 160
	slli	t1,t0,5	#,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	srai	a7,a1,63	#, tmp725, N
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:18: {
	sd	s0,152(sp)	#,
	sd	s1,144(sp)	#,
	sd	s3,128(sp)	#,
	sd	s2,136(sp)	#,
	sd	s4,120(sp)	#,
	sd	s5,112(sp)	#,
	sd	s6,104(sp)	#,
	sd	s7,96(sp)	#,
	sd	s8,88(sp)	#,
	sd	s9,80(sp)	#,
	sd	s10,72(sp)	#,
	sd	s11,64(sp)	#,
	mv	t3,a1	# N, tmp938
	sub	sp,sp,t1	#,,
	.cfi_escape 0xf,0xd,0x72,0,0x92,0xa2,0x38,0,0x8,0x40,0x1e,0x23,0xa0,0x1,0x22
	.cfi_offset 8, -8
	.cfi_offset 9, -16
	.cfi_offset 19, -32
	.cfi_offset 18, -24
	.cfi_offset 20, -40
	.cfi_offset 21, -48
	.cfi_offset 22, -56
	.cfi_offset 23, -64
	.cfi_offset 24, -72
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	andi	a7,a7,3	#, tmp726, tmp725
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t1,3		# tmp729,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	a7,a7,a1	# N, tmp727, tmp726
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:18: {
	fmv.d	fa4,fa0	# alpha, tmp940
	mv	s1,a0	# M, tmp937
	mv	a1,a2	# K, tmp939
	mv	s0,a3	# A, tmp941
	mv	t6,a4	# B, tmp942
	mv	t4,a5	# C, tmp943
	mv	s3,a6	# ldc, tmp944
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ble	t3,t1,.L48	#, N, tmp729,
	slli	s6,a2,5	#, _1652, K
	add	a3,a4,s6	# _1652, ivtmp.483, B
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:92:         if (M & 4) {
	andi	a4,s1,4	#, _46, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a0,63	#, tmp732, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	slli	a5,s3,1	#, _150, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:92:         if (M & 4) {
	sd	a4,0(sp)	# _46, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:155:         if (M & 2) {
	andi	a4,s1,2	#, _91, M
	slli	a2,s3,5	#, _1636, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	andi	a6,a6,7	#, tmp733, tmp732
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	sd	a5,32(sp)	# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:155:         if (M & 2) {
	sd	a4,8(sp)	# _91, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	a5,a5,s3	# ldc, _164, _150
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:194:         if (M & 1) {
	andi	a4,s1,1	#, _178, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a6,a6,a0	# M, tmp734, tmp733
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:194:         if (M & 1) {
	sd	a4,16(sp)	# _178, %sfp
	sd	a2,24(sp)	# _1636, %sfp
	slli	a4,s3,2	#, _1660, ldc
	slti	a0,a0,8	#, tmp742, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	sd	a5,40(sp)	# _164, %sfp
	mv	s4,a4	# _1660, _1660
	srai	t5,a7,2	#, _917, tmp727
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	a6,a6,3	#, _947, tmp734
	addi	a4,t6,32	#, ivtmp.482, B
	mv	t2,t4	# ivtmp.485, C
	slli	t1,a1,6	#, _1684, K
	slli	a2,s3,3	#, _1672, ldc
	li	s7,8		# _1906,
	beq	a0,zero,.L165	#, tmp742,,
.L4:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:194:         if (M & 1) {
	li	s2,0		# ivtmp.478,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	li	t0,0		# j,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:48:             for (BLASLONG k = 1; k < K; k++) {
	li	a7,1		# tmp893,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:93:             gvl = __riscv_vsetvl_e64m8(4);
	mv	s8,s4	# _1660, _1660
	sd	t3,48(sp)	# N, %sfp
	sd	t6,56(sp)	# B, %sfp
.L18:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t3,7		# tmp1271,
	ble	s1,t3,.L49	#, M, tmp1271,
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
	mv	s9,s0	# ivtmp.463, A
	mv	s5,t2	# ivtmp.464, ivtmp.485
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	s10,0		# i,
.L8:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:38:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(s9)	# A0,* ivtmp.463
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:34:             double B2 = B[bi + 2];
	fld	fa3,-16(a4)	# B2, MEM[(FLOAT *)_1631 + -16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:41:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa1,-32(a4)	# MEM[(FLOAT *)_1631 + -32B], MEM[(FLOAT *)_1631 + -32B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:33:             double B1 = B[bi + 1];
	fld	fa2,-24(a4)	# B1, MEM[(FLOAT *)_1631 + -24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:35:             double B3 = B[bi + 3];
	fld	fa5,-8(a4)	# B3, MEM[(FLOAT *)_1631 + -8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:43:             vfloat64m8_t result2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	csrr	t3,vlenb	# tmp1525
	vfmul.vf	v24,v8,fa3	# result2, A0, B2,
	slli	t3,t3,3	#, tmp1526, tmp1525
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:41:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	vfmul.vf	v16,v8,fa1	# result0, A0, MEM[(FLOAT *)_1631 + -32B],
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:42:             vfloat64m8_t result1 = __riscv_vfmul_vf_f64m8(A0, B1, gvl);
	vfmul.vf	v0,v8,fa2	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:43:             vfloat64m8_t result2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	addi	t3,t3,64	#, tmp1527, tmp1524
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:44:             vfloat64m8_t result3 = __riscv_vfmul_vf_f64m8(A0, B3, gvl);
	vfmul.vf	v8,v8,fa5	# result3, A0, B3,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:43:             vfloat64m8_t result2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	add	t3,t3,sp	#, tmp1524, tmp1524
	vs8r.v	v24,0(t3)	# result2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:44:             vfloat64m8_t result3 = __riscv_vfmul_vf_f64m8(A0, B3, gvl);
	csrr	t3,vlenb	# tmp1520
	slli	t3,t3,4	#, tmp1521, tmp1520
	addi	t3,t3,64	#, tmp1522, tmp1519
	add	t3,t3,sp	#, tmp1519, tmp1519
	vs8r.v	v8,0(t3)	# result3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:48:             for (BLASLONG k = 1; k < K; k++) {
	ble	a1,a7,.L6	#, K, tmp893,
	sub	s4,a3,a4	# tmp931, ivtmp.483, ivtmp.482
	addi	s4,s4,-32	#, tmp932, tmp931
	srli	s4,s4,5	#, tmp930, tmp932
	andi	s4,s4,1	#, tmp934, tmp930
	addi	t6,s9,64	#, ivtmp.456, ivtmp.463
	mv	t3,a4	# ivtmp.454, ivtmp.482
	bne	s4,zero,.L139	#, tmp934,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:55:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(t6)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:60:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	csrr	t6,vlenb	# tmp1344
	slli	t6,t6,3	#, tmp1345, tmp1344
	addi	t6,t6,64	#, tmp1346, tmp1343
	add	t6,t6,sp	#, tmp1343, tmp1343
	vl8re64.v	v8,0(t6)	# %sfp, result2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:51:                 B2 = B[bi + 2];
	fld	fa3,16(a4)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:60:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	csrr	t6,vlenb	# tmp1339
	slli	t6,t6,3	#, tmp1340, tmp1339
	addi	t6,t6,64	#, tmp1341, tmp1338
	add	t6,t6,sp	#, tmp1338, tmp1338
	vfmacc.vf	v8,fa3,v24	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:52:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa1,0(a4)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:50:                 B1 = B[bi + 1];
	fld	fa2,8(a4)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t3,a4,32	#, ivtmp.454, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa1,v24	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:60:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	vs8r.v	v8,0(t6)	# result2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:61:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	csrr	t6,vlenb	# tmp1334
	slli	t6,t6,4	#, tmp1335, tmp1334
	addi	t6,t6,64	#, tmp1336, tmp1333
	add	t6,t6,sp	#, tmp1333, tmp1333
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:59:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v0,fa2,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:61:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	vl8re64.v	v8,0(t6)	# %sfp, result3
	csrr	t6,vlenb	# tmp1329
	slli	t6,t6,4	#, tmp1330, tmp1329
	addi	t6,t6,64	#, tmp1331, tmp1328
	add	t6,t6,sp	#, tmp1328, tmp1328
	vfmacc.vf	v8,fa5,v24	# result3, B3, A0,
	vs8r.v	v8,0(t6)	# result3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,s9,128	#, ivtmp.456, ivtmp.463
	beq	a3,t3,.L6	#, ivtmp.483, ivtmp.454,
.L139:
	addi	s4,sp,64	#, tmp1515,
	vs8r.v	v16,0(s4)	# result0, %sfp
.L7:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	addi	s11,sp,64	#, tmp1513,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:55:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(t6)	# A0,* ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vl8re64.v	v8,0(s11)	# %sfp, result0
	fld	fa2,0(t3)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:51:                 B2 = B[bi + 2];
	fld	fa1,16(t3)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:50:                 B1 = B[bi + 1];
	fld	fa3,8(t3)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:52:                 B3 = B[bi + 3];
	fld	fa5,24(t3)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	s4,t6,64	#, tmp936, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa2,v24	# result0, MEM[(FLOAT *)_1698], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:59:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v0,fa3,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa2,32(t3)	# MEM[(FLOAT *)_1698], MEM[(FLOAT *)_1698]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:50:                 B1 = B[bi + 1];
	fld	fa3,40(t3)	# B1, MEM[(FLOAT *)_1698 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:48:             for (BLASLONG k = 1; k < K; k++) {
	addi	t3,t3,64	#, ivtmp.454, ivtmp.454
	addi	t6,t6,128	#, ivtmp.456, ivtmp.456
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vs8r.v	v8,0(s11)	# result0, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:60:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	csrr	s11,vlenb	# tmp1507
	slli	s11,s11,3	#, tmp1508, tmp1507
	addi	s11,s11,64	#, tmp1509, tmp1506
	add	s11,s11,sp	#, tmp1506, tmp1506
	vl8re64.v	v8,0(s11)	# %sfp, result2
	csrr	s11,vlenb	# tmp1502
	slli	s11,s11,3	#, tmp1503, tmp1502
	addi	s11,s11,64	#, tmp1504, tmp1501
	add	s11,s11,sp	#, tmp1501, tmp1501
	vfmacc.vf	v8,fa1,v24	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:51:                 B2 = B[bi + 2];
	fld	fa1,-16(t3)	# B2, MEM[(FLOAT *)_1698 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:60:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	vs8r.v	v8,0(s11)	# result2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:61:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	csrr	s11,vlenb	# tmp1497
	slli	s11,s11,4	#, tmp1498, tmp1497
	addi	s11,s11,64	#, tmp1499, tmp1496
	add	s11,s11,sp	#, tmp1496, tmp1496
	vl8re64.v	v16,0(s11)	# %sfp, result3
	vfmacc.vf	v16,fa5,v24	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:55:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(s4)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	addi	s4,sp,64	#, tmp1494,
	vl8re64.v	v8,0(s4)	# %sfp, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:52:                 B3 = B[bi + 3];
	fld	fa5,-8(t3)	# B3, MEM[(FLOAT *)_1698 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:59:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v0,fa3,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:58:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa2,v24	# result0, MEM[(FLOAT *)_1698], A0,
	vs8r.v	v8,0(s4)	# result0, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:60:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	csrr	s4,vlenb	# tmp1488
	slli	s4,s4,3	#, tmp1489, tmp1488
	addi	s4,s4,64	#, tmp1490, tmp1487
	add	s4,s4,sp	#, tmp1487, tmp1487
	vl8re64.v	v8,0(s4)	# %sfp, result2
	csrr	s4,vlenb	# tmp1483
	slli	s4,s4,3	#, tmp1484, tmp1483
	addi	s4,s4,64	#, tmp1485, tmp1482
	add	s4,s4,sp	#, tmp1482, tmp1482
	vfmacc.vf	v8,fa1,v24	# result2, B2, A0,
	vs8r.v	v8,0(s4)	# result2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:61:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	vmv8r.v	v8,v16	# result3, result3
	vfmacc.vf	v8,fa5,v24	# result3, B3, A0,
	vs8r.v	v8,0(s11)	# result3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:48:             for (BLASLONG k = 1; k < K; k++) {
	bne	a3,t3,.L7	#, ivtmp.483, ivtmp.454,
	addi	t3,sp,64	#, tmp1475,
	vl8re64.v	v16,0(t3)	# %sfp, result0
.L6:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:66:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v24,0(s5)	# c0,* ivtmp.464
	add	t6,a2,s5	# ivtmp.464, _1671, _1672
	add	t3,t6,a2	# _1672, _1668, _1671
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:72:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	s4,t3,a2	# _1672, _44, _1668
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:68:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	addi	s11,sp,64	#, tmp1473,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:72:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v8,0(s4)	# c3,* _44
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:73:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	vfmacc.vf	v24,fa4,v16	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:68:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v16,0(t6)	# c1,* _1671
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s10,s10,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	s9,s9,t1	# _1684, ivtmp.463, ivtmp.463
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:68:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vs8r.v	v16,0(s11)	# c1, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:76:             c3 = __riscv_vfmacc_vf_f64m8(c3, alpha, result3, gvl);
	csrr	s11,vlenb	# tmp1469
	slli	s11,s11,4	#, tmp1470, tmp1469
	addi	s11,s11,64	#, tmp1471, tmp1468
	add	s11,s11,sp	#, tmp1468, tmp1468
	vl8re64.v	v16,0(s11)	# %sfp, result3
	csrr	s11,vlenb	# tmp1464
	slli	s11,s11,4	#, tmp1465, tmp1464
	addi	s11,s11,64	#, tmp1466, tmp1463
	add	s11,s11,sp	#, tmp1463, tmp1463
	vfmacc.vf	v8,fa4,v16	# c3, alpha, result3,
	vs8r.v	v8,0(s11)	# c3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:74:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, result1, gvl);
	addi	s11,sp,64	#, tmp1461,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:70:             vfloat64m8_t c2 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v8,0(t3)	# c2,* _1668
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:80:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v24,0(s5)	# c0,* ivtmp.464,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	s5,s5,64	#, ivtmp.464, ivtmp.464
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:74:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, result1, gvl);
	vl8re64.v	v16,0(s11)	# %sfp, c1
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:75:             c2 = __riscv_vfmacc_vf_f64m8(c2, alpha, result2, gvl);
	csrr	s11,vlenb	# tmp1457
	slli	s11,s11,3	#, tmp1458, tmp1457
	addi	s11,s11,64	#, tmp1459, tmp1456
	add	s11,s11,sp	#, tmp1456, tmp1456
	vl8re64.v	v24,0(s11)	# %sfp, result2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:74:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, result1, gvl);
	vfmacc.vf	v16,fa4,v0	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:75:             c2 = __riscv_vfmacc_vf_f64m8(c2, alpha, result2, gvl);
	vfmacc.vf	v8,fa4,v24	# c2, alpha, result2,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:82:             __riscv_vse64_v_f64m8(&C[ci], c1, gvl);
	vse64.v	v16,0(t6)	# c1,* _1671,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:84:             __riscv_vse64_v_f64m8(&C[ci], c2, gvl);
	vse64.v	v8,0(t3)	# c2,* _1668,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:86:             __riscv_vse64_v_f64m8(&C[ci], c3, gvl);
	csrr	t3,vlenb	# tmp1452
	slli	t3,t3,4	#, tmp1453, tmp1452
	addi	t3,t3,64	#, tmp1454, tmp1451
	add	t3,t3,sp	#, tmp1451, tmp1451
	vl8re64.v	v8,0(t3)	# %sfp, c3
	vse64.v	v8,0(s4)	# c3,* _44,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:29:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	s10,a6,.L8	#, i, _947,
	mv	t3,s7	# m_top, _1906
.L5:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:92:         if (M & 4) {
	ld	t6,0(sp)		# _46, %sfp
	bne	t6,zero,.L166	#, _46,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:155:         if (M & 2) {
	ld	t6,8(sp)		# _91, %sfp
	bne	t6,zero,.L167	#, _91,,
.L12:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:194:         if (M & 1) {
	ld	t6,16(sp)		# _178, %sfp
	bne	t6,zero,.L168	#, _178,,
.L15:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	ld	t3,24(sp)		# _1636, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	addi	t0,t0,1	#, j, j
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:25:     for (BLASLONG j = 0; j < N / 4; j += 1) {
	add	s2,s2,s8	# _1660, ivtmp.478, ivtmp.478
	add	a4,a4,s6	# _1652, ivtmp.482, ivtmp.482
	add	a3,a3,s6	# _1652, ivtmp.483, ivtmp.483
	add	t2,t2,t3	# _1636, ivtmp.485, ivtmp.485
	blt	t0,t5,.L18	#, j, _917,
	ld	t3,48(sp)		# N, %sfp
	ld	t6,56(sp)		# B, %sfp
	slli	t5,t5,2	#, n_top, _917
.L2:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:226:     if (N & 2) {
	andi	a5,t3,2	#, _234, N
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:226:     if (N & 2) {
	beq	a5,zero,.L164	#, _234,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t1,s1,63	#, tmp794, M
	andi	t1,t1,7	#, tmp795, tmp794
	add	t1,t1,s1	# M, tmp796, tmp795
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a4,7		# tmp798,
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t1,t1,3	#, _887, tmp796
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	s1,a4,.L52	#, M, tmp798,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:232:             BLASLONG bi = n_top * K;
	mul	a4,a1,t5	# bi.110_236, K, n_top
	slli	a6,a1,1	#, _348, K
	slli	s7,a1,6	#, _180, K
	mv	a7,s0	# ivtmp.422, A
	slli	s6,s3,3	#, _192, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t2,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:245:             for (BLASLONG k = 1; k < K; k++) {
	li	s5,1		# tmp808,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:257:             BLASLONG ci = n_top * ldc + m_top;
	mul	a0,t5,s3	# _549, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:233:             double B0 = B[bi + 0];
	slli	s2,a4,3	#, _237, bi.110_236
	addi	t0,a4,2	#, _810, bi.110_236
	add	a6,a6,a4	# bi.110_236, _350, _348
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:234:             double B1 = B[bi + 1];
	addi	s4,s2,8	#, _240, _237
	slli	t0,t0,3	#, _337, _810
	slli	a6,a6,3	#, _617, _350
	add	s4,t6,s4	# _240, _241, B
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:233:             double B0 = B[bi + 0];
	add	s2,t6,s2	# _237, _238, B
	add	t0,t6,t0	# _337, ivtmp.410, B
	slli	a0,a0,3	#, _185, _549
	add	a6,t6,a6	# _617, _619, B
	add	a0,t4,a0	# _185, ivtmp.423, C
.L23:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:237:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a7)	# A0,* ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:240:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa3,0(s2)	# *_238, *_238
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:234:             double B1 = B[bi + 1];
	fld	fa5,0(s4)	# B1, *_241
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:240:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	vfmul.vf	v16,v8,fa3	# result0, A0, *_238,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:241:             vfloat64m8_t result1 = __riscv_vfmul_vf_f64m8(A0, B1, gvl);
	vfmul.vf	v8,v8,fa5	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:245:             for (BLASLONG k = 1; k < K; k++) {
	ble	a1,s5,.L21	#, K, tmp808,
	sub	a2,a6,t0	# tmp917, _619, ivtmp.410
	addi	a2,a2,-16	#, tmp918, tmp917
	srli	a2,a2,4	#, tmp916, tmp918
	andi	a2,a2,1	#, tmp920, tmp916
	addi	a3,a7,64	#, ivtmp.412, ivtmp.422
	mv	a4,t0	# ivtmp.410, ivtmp.410
	bne	a2,zero,.L145	#, tmp920,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:250:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:253:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa3,0(t0)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:247:                 B1 = B[bi + 1];
	fld	fa5,8(t0)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:245:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,t0,16	#, ivtmp.410, ivtmp.410
	addi	a3,a7,128	#, ivtmp.412, ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:253:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa3,v24	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:254:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v8,fa5,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:245:             for (BLASLONG k = 1; k < K; k++) {
	beq	a6,a4,.L21	#, _619, ivtmp.410,
.L145:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:250:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(a3)	# A0,* ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:253:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa3,0(a4)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:247:                 B1 = B[bi + 1];
	fld	fa5,8(a4)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:245:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a3,64	#, tmp922, ivtmp.412
	addi	a4,a4,32	#, ivtmp.410, ivtmp.410
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:250:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	addi	a3,a3,128	#, ivtmp.412, ivtmp.412
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:253:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa3,v24	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:254:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v8,fa5,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:250:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(a2)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:253:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa3,-16(a4)	# MEM[(FLOAT *)_346], MEM[(FLOAT *)_346]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:247:                 B1 = B[bi + 1];
	fld	fa5,-8(a4)	# B1, MEM[(FLOAT *)_346 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:253:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa3,v24	# result0, MEM[(FLOAT *)_346], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:254:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v8,fa5,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:245:             for (BLASLONG k = 1; k < K; k++) {
	bne	a6,a4,.L145	#, _619, ivtmp.410,
.L21:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:259:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v0,0(a0)	# c0,* ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:261:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	a4,a0,s6	# _192, _260, ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:261:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v24,0(a4)	# c1,* _260
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t2,t2,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a7,a7,s7	# _180, ivtmp.422, ivtmp.422
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:262:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	vfmacc.vf	v0,fa4,v16	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:263:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, result1, gvl);
	vfmacc.vf	v24,fa4,v8	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:267:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v0,0(a0)	# c0,* ivtmp.423,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a0,a0,64	#, ivtmp.423, ivtmp.423
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:269:             __riscv_vse64_v_f64m8(&C[ci], c1, gvl);
	vse64.v	v24,0(a4)	# c1,* _260,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:230:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	blt	t2,t1,.L23	#, i, _887,
	slli	t1,t1,3	#, m_top, _887
.L20:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:273:         if (M & 4) {
	andi	a5,s1,4	#, _262, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:273:         if (M & 4) {
	beq	a5,zero,.L24	#, _262,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:276:             BLASLONG ai = m_top * K;
	mul	a4,a1,t1	# ai, K, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:274:             gvl = __riscv_vsetvl_e64m8(4);
	vsetivli	zero,4,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:290:             for (BLASLONG k = 1; k < K; k++) {
	li	a2,1		# tmp816,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:277:             BLASLONG bi = n_top * K;
	mul	a0,a1,t5	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:282:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	slli	a3,a4,3	#, _271, ai
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:282:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	add	a3,s0,a3	# _271, _272, A
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:282:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a3)	# A0,* _272
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:283:             ai += 4;
	addi	a3,a4,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:278:             double B0 = B[bi + 0];
	slli	a4,a0,3	#, _265, bi
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:279:             double B1 = B[bi + 1];
	add	a4,t6,a4	# _265, tmp811, B
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:285:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa3,0(a4)	# *_266, *_266
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:279:             double B1 = B[bi + 1];
	fld	fa5,8(a4)	# B1, *_269
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:280:             bi += 2;
	addi	a4,a0,2	#, bi, bi
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:285:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	vfmul.vf	v16,v8,fa3	# result0, A0, *_266,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:286:             vfloat64m8_t result1 = __riscv_vfmul_vf_f64m8(A0, B1, gvl);
	vfmul.vf	v8,v8,fa5	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:290:             for (BLASLONG k = 1; k < K; k++) {
	ble	a1,a2,.L25	#, K, tmp816,
	slli	a2,a1,1	#, _411, K
	add	a2,a2,a0	# bi, _413, _411
	slli	a4,a4,3	#, _1068, bi
	slli	a2,a2,3	#, _414, _413
	add	a4,t6,a4	# _1068, ivtmp.393, B
	add	a2,t6,a2	# _414, _416, B
	sub	a0,a2,a4	# tmp910, _416, ivtmp.393
	addi	a0,a0,-16	#, tmp911, tmp910
	srli	a0,a0,4	#, tmp909, tmp911
	slli	a3,a3,3	#, _407, ai
	andi	a0,a0,1	#, tmp913, tmp909
	add	a3,s0,a3	# _407, ivtmp.395, A
	bne	a0,zero,.L144	#, tmp913,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:295:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:298:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa3,0(a4)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:292:                 B1 = B[bi + 1];
	fld	fa5,8(a4)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:290:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,16	#, ivtmp.393, ivtmp.393
	addi	a3,a3,32	#, ivtmp.395, ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:298:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa3,v24	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:299:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v8,fa5,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:290:             for (BLASLONG k = 1; k < K; k++) {
	beq	a2,a4,.L25	#, _416, ivtmp.393,
.L144:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:295:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(a3)	# A0,* ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:298:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa3,0(a4)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:292:                 B1 = B[bi + 1];
	fld	fa5,8(a4)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:290:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a3,32	#, tmp915, ivtmp.395
	addi	a4,a4,32	#, ivtmp.393, ivtmp.393
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:295:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	addi	a3,a3,64	#, ivtmp.395, ivtmp.395
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:298:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa3,v24	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:299:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v8,fa5,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:295:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v24,0(a0)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:298:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa3,-16(a4)	# MEM[(FLOAT *)_409], MEM[(FLOAT *)_409]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:292:                 B1 = B[bi + 1];
	fld	fa5,-8(a4)	# B1, MEM[(FLOAT *)_409 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:298:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa3,v24	# result0, MEM[(FLOAT *)_409], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:299:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v8,fa5,v24	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:290:             for (BLASLONG k = 1; k < K; k++) {
	bne	a2,a4,.L144	#, _416, ivtmp.393,
.L25:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:302:             BLASLONG ci = n_top * ldc + m_top;
	mul	a4,s3,t5	# _282, ldc, n_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:302:             BLASLONG ci = n_top * ldc + m_top;
	add	a4,a4,t1	# m_top, ci, _282
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:304:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	slli	a3,a4,3	#, _284, ci
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:304:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	a3,t4,a3	# _284, _285, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:304:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v0,0(a3)	# c0,* _285
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:305:             ci += ldc - gvl * 0;
	add	a4,s3,a4	# ci, ci_575, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:306:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	slli	a4,a4,3	#, _287, ci_575
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:306:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	a4,t4,a4	# _287, _288, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:306:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v24,0(a4)	# c1,* _288
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:315:             m_top += 4;
	addi	t1,t1,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:307:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	vfmacc.vf	v0,fa4,v16	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:308:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, result1, gvl);
	vfmacc.vf	v24,fa4,v8	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:312:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v0,0(a3)	# c0,* _285,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:314:             __riscv_vse64_v_f64m8(&C[ci], c1, gvl);
	vse64.v	v24,0(a4)	# c1,* _288,
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
.L24:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:318:         if (M & 2) {
	andi	a5,s1,2	#, _289, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:318:         if (M & 2) {
	beq	a5,zero,.L27	#, _289,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:323:             BLASLONG ai = m_top * K;
	mul	a3,t1,a1	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:322:             double result3 = 0;
	fmv.d.x	fa5,zero	# result3,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:324:             BLASLONG bi = n_top * K;
	mul	a4,a1,t5	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:328:             for (BLASLONG k = 0; k < K; k++) {
	ble	a1,zero,.L53	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:321:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:320:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:319:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	slli	a3,a3,3	#, _1819, ai
	slli	a4,a4,3	#, _1811, bi
	add	a3,s0,a3	# _1819, vectp.271, A
	add	a4,t6,a4	# _1811, vectp.276, B
	mv	a2,a1	# bnd.269, K
.L29:
	vsetvli	a5,a2,e64,m1,ta,ma	# bnd.269, _1796,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:329:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v2,(a4)	# vect_array.277, vectp.276,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:329:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v4,(a3)	# vect_array.272, vectp.271,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:329:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v12,fa1	# tmp955, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:330:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v11,fa2	# tmp957, result1
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:331:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v10,fa3	# tmp959, result2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:332:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.s.f	v9,fa5	# tmp961, result3
	slli	a0,a5,4	#, ivtmp_1822, _1796
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:328:             for (BLASLONG k = 0; k < K; k++) {
	sub	a2,a2,a5	# bnd.269, bnd.269, _1796
	add	a3,a3,a0	# ivtmp_1822, vectp.271, vectp.271
	add	a4,a4,a0	# ivtmp_1822, vectp.276, vectp.276
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:331:                 result2 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v6,v4,v3	# vect__308.284, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:329:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v8,v4,v2	# vect__298.280, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:330:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v7,v5,v2	# vect__303.282, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:332:                 result3 += A[ai + 1] * B[bi + 1];
	vfmul.vv	v1,v5,v3	# vect__309.286, vect_array.272, vect_array.277,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:331:                 result2 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v2,v6,v10	# tmp960, vect__308.284, tmp959,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:329:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v8,v12	# tmp956, vect__298.280, tmp955,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:330:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v3,v7,v11	# tmp958, vect__303.282, tmp957,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:332:                 result3 += A[ai + 1] * B[bi + 1];
	vfredosum.vs	v1,v1,v9	# tmp962, vect__309.286, tmp961,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:331:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa3,v2	# result2, tmp960
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:329:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa1,v4	# result0, tmp956
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:330:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	fa2,v3	# result1, tmp958
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:332:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.f.s	fa5,v1	# result3, tmp962
	bne	a2,zero,.L29	#, bnd.269,,
.L28:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:337:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s3,t5	# _310, ldc, n_top
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:337:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,t1	# m_top, ci, _310
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:338:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a4,a5,3	#, _312, ci
	add	a2,t4,a4	# _312, _313, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:338:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa0,0(a2)	# *_313, *_313
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:339:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	a4,a4,8	#, _318, _312
	add	a4,t4,a4	# _318, _319, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:338:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa1,fa4,fa1,fa0	# _316, alpha, result0, *_313
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:340:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	a5,s3,a5	# ci, _323, ldc
	slli	a5,a5,3	#, _325, _323
	add	a3,t4,a5	# _325, _326, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:341:             C[ci + 1 * ldc + 1] += alpha * result3;
	addi	a5,a5,8	#, _331, _325
	add	a5,t4,a5	# _331, _332, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:342:             m_top += 2;
	addi	t1,t1,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:338:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa1,0(a2)	# _316, *_313
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:339:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	fa1,0(a4)	# *_319, *_319
	fmadd.d	fa2,fa4,fa2,fa1	# _322, alpha, result1, *_319
	fsd	fa2,0(a4)	# _322, *_319
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:340:             C[ci + 1 * ldc + 0] += alpha * result2;
	fld	fa2,0(a3)	# *_326, *_326
	fmadd.d	fa3,fa4,fa3,fa2	# _329, alpha, result2, *_326
	fsd	fa3,0(a3)	# _329, *_326
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:341:             C[ci + 1 * ldc + 1] += alpha * result3;
	fld	fa3,0(a5)	# *_332, *_332
	fmadd.d	fa5,fa4,fa5,fa3	# _335, alpha, result3, *_332
	fsd	fa5,0(a5)	# _335, *_332
.L27:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:345:         if (M & 1) {
	andi	a5,s1,1	#, _336, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:345:         if (M & 1) {
	beq	a5,zero,.L30	#, _336,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:348:             BLASLONG ai = m_top * K;
	mul	a3,t1,a1	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:347:             double result1 = 0;
	fmv.d.x	fa5,zero	# result1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:349:             BLASLONG bi = n_top * K;
	mul	a4,a1,t5	# bi, K, n_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:353:             for (BLASLONG k = 0; k < K; k++) {
	ble	a1,zero,.L54	#, K,,
	slli	a4,a4,3	#, _1844, bi
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:346:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	addi	a0,a4,8	#, _1834, _1844
	slli	a3,a3,3	#, _1851, ai
	add	a3,s0,a3	# _1851, vectp.256, A
	add	a0,t6,a0	# _1834, vectp.264, B
	add	a4,t6,a4	# _1844, vectp.259, B
	mv	a2,a1	# bnd.254, K
.L32:
	vsetvli	a5,a2,e64,m1,ta,ma	# bnd.254, _1826,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:354:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v3,0(a3)	# vect__340.257,* vectp.256
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:354:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v2,0(a4)	# vect__344.260,* vectp.259
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:355:                 result1 += A[ai + 0] * B[bi + 1];
	vle64.v	v1,0(a0)	# vect__349.265,* vectp.264
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:354:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v5,fa3	# tmp951, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:355:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v4,fa5	# tmp953, result1
	slli	a6,a5,3	#, ivtmp_1854, _1826
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:353:             for (BLASLONG k = 0; k < K; k++) {
	sub	a2,a2,a5	# bnd.254, bnd.254, _1826
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:354:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v2,v2,v3	# vect__345.261, vect__344.260, vect__340.257,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:355:                 result1 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v1,v1,v3	# vect__350.266, vect__349.265, vect__340.257,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:353:             for (BLASLONG k = 0; k < K; k++) {
	add	a3,a3,a6	# ivtmp_1854, vectp.256, vectp.256
	add	a4,a4,a6	# ivtmp_1854, vectp.259, vectp.259
	add	a0,a0,a6	# ivtmp_1854, vectp.264, vectp.264
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:354:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v2,v2,v5	# tmp952, vect__345.261, tmp951,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:355:                 result1 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v1,v1,v4	# tmp954, vect__350.266, tmp953,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:354:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa3,v2	# result0, tmp952
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:355:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa5,v1	# result1, tmp954
	bne	a2,zero,.L32	#, bnd.254,,
.L31:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:360:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,s3,t5	# _351, ldc, n_top
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:360:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,t1	# m_top, ci, _351
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:361:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a4,a5,3	#, _353, ci
	add	a4,t4,a4	# _353, _354, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:361:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa2,0(a4)	# *_354, *_354
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:362:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,s3,a5	# ci, _358, ldc
	slli	a5,a5,3	#, _360, _358
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:361:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa3,fa4,fa3,fa2	# _357, alpha, result0, *_354
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:362:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	a5,t4,a5	# _360, _361, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:361:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa3,0(a4)	# _357, *_354
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:362:             C[ci + 1 * ldc + 0] += alpha * result1;
	fld	fa3,0(a5)	# *_361, *_361
	fmadd.d	fa5,fa4,fa5,fa3	# _364, alpha, result1, *_361
	fsd	fa5,0(a5)	# _364, *_361
.L30:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:371:     if (N & 1) {
	andi	a5,t3,1	#, _365, N
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:366:         n_top += 2;
	addi	t5,t5,2	#, n_top, n_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:371:     if (N & 1) {
	bne	a5,zero,.L169	#, _365,,
.L135:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:488: }
	csrr	t0,vlenb	#
	slli	t1,t0,5	#,,
	add	sp,sp,t1	#,,
	.cfi_remember_state
	.cfi_def_cfa_offset 160
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
	li	a0,0		#,
	addi	sp,sp,160	#,,
	.cfi_def_cfa_offset 0
	jr	ra		#
.L168:
	.cfi_restore_state
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:199:             BLASLONG ai = m_top * K;
	mul	s5,t3,a1	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:198:             double result3 = 0;
	fmv.d.x	fa5,zero	# result3,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:204:             for (BLASLONG k = 0; k < K; k++) {
	ble	a1,zero,.L51	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:197:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:196:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:195:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	slli	s5,s5,3	#, _1789, ai
	add	s5,s0,s5	# _1789, vectp.291, A
	addi	s9,a4,-32	#, vectp.294, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:204:             for (BLASLONG k = 0; k < K; k++) {
	mv	s4,a1	# ivtmp_1766, K
.L17:
	vsetvli	t6,s4,e64,m1,ta,ma	# ivtmp_1766, _1765,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:205:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e64.v	v4,(s9)	# vect_array.295, vectp.294,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:205:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(s5)	# vect__182.292,* vectp.291
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:205:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v12,fa1	# tmp963, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:206:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v11,fa2	# tmp965, result1
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:207:                 result2 += A[ai + 0] * B[bi + 2];
	vfmv.s.f	v10,fa3	# tmp967, result2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:208:                 result3 += A[ai + 0] * B[bi + 3];
	vfmv.s.f	v9,fa5	# tmp969, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:204:             for (BLASLONG k = 0; k < K; k++) {
	slli	s10,t6,3	#, ivtmp_1792, _1765
	add	s5,s5,s10	# ivtmp_1792, vectp.291, vectp.291
	sub	s4,s4,t6	# ivtmp_1766, ivtmp_1766, _1765
	slli	s10,t6,5	#, ivtmp_1785, _1765
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:205:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v8,v1,v4	# vect__187.300, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:206:                 result1 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v3,v1,v5	# vect__192.302, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:207:                 result2 += A[ai + 0] * B[bi + 2];
	vfmul.vv	v2,v1,v6	# vect__197.304, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:208:                 result3 += A[ai + 0] * B[bi + 3];
	vfmul.vv	v1,v1,v7	# vect__202.306, vect__182.292, vect_array.295,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:204:             for (BLASLONG k = 0; k < K; k++) {
	add	s9,s9,s10	# ivtmp_1785, vectp.294, vectp.294
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:205:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v8,v12	# tmp964, vect__187.300, tmp963,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:206:                 result1 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v3,v3,v11	# tmp966, vect__192.302, tmp965,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:207:                 result2 += A[ai + 0] * B[bi + 2];
	vfredosum.vs	v2,v2,v10	# tmp968, vect__197.304, tmp967,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:208:                 result3 += A[ai + 0] * B[bi + 3];
	vfredosum.vs	v1,v1,v9	# tmp970, vect__202.306, tmp969,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:205:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa1,v4	# result0, tmp964
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:206:                 result1 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	fa2,v3	# result1, tmp966
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:207:                 result2 += A[ai + 0] * B[bi + 2];
	vfmv.f.s	fa3,v2	# result2, tmp968
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:208:                 result3 += A[ai + 0] * B[bi + 3];
	vfmv.f.s	fa5,v1	# result3, tmp970
	bne	s4,zero,.L17	#, ivtmp_1766,,
.L16:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:213:             BLASLONG ci = n_top * ldc + m_top;
	add	t3,s2,t3	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:214:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	s5,t3,3	#, _205, ci
	add	s5,t4,s5	# _205, _206, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:214:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa0,0(s5)	# *_206, *_206
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:215:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	s4,s3,t3	# ci, _210, ldc
	slli	s4,s4,3	#, _212, _210
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:214:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa1,fa4,fa1,fa0	# _209, alpha, result0, *_206
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:215:             C[ci + 1 * ldc + 0] += alpha * result1;
	add	s4,t4,s4	# _212, _213, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:216:             C[ci + 2 * ldc + 0] += alpha * result2;
	ld	t6,32(sp)		# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:217:             C[ci + 3 * ldc + 0] += alpha * result3;
	ld	s9,40(sp)		# _164, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:216:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	t6,t6,t3	# ci, _218, _150
	slli	t6,t6,3	#, _220, _218
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:214:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa1,0(s5)	# _209, *_206
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:215:             C[ci + 1 * ldc + 0] += alpha * result1;
	fld	fa1,0(s4)	# *_213, *_213
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:216:             C[ci + 2 * ldc + 0] += alpha * result2;
	add	t6,t4,t6	# _220, _221, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:217:             C[ci + 3 * ldc + 0] += alpha * result3;
	add	t3,s9,t3	# ci, _226, _164
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:215:             C[ci + 1 * ldc + 0] += alpha * result1;
	fmadd.d	fa2,fa4,fa2,fa1	# _216, alpha, result1, *_213
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:217:             C[ci + 3 * ldc + 0] += alpha * result3;
	slli	t3,t3,3	#, _228, _226
	add	t3,t4,t3	# _228, _229, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:215:             C[ci + 1 * ldc + 0] += alpha * result1;
	fsd	fa2,0(s4)	# _216, *_213
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:216:             C[ci + 2 * ldc + 0] += alpha * result2;
	fld	fa2,0(t6)	# *_221, *_221
	fmadd.d	fa3,fa4,fa3,fa2	# _224, alpha, result2, *_221
	fsd	fa3,0(t6)	# _224, *_221
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:217:             C[ci + 3 * ldc + 0] += alpha * result3;
	fld	fa3,0(t3)	# *_229, *_229
	fmadd.d	fa5,fa4,fa5,fa3	# _232, alpha, result3, *_229
	fsd	fa5,0(t3)	# _232, *_229
	j	.L15		#
.L166:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:95:             BLASLONG ai = m_top * K;
	mul	t6,a1,t3	# ai, K, m_top
	vsetivli	zero,4,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:106:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa1,-32(a4)	# MEM[(FLOAT *)_1632 + -32B], MEM[(FLOAT *)_1632 + -32B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:108:             vfloat64m8_t result2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	csrr	s5,vlenb	# tmp1442
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:99:             double B2 = B[bi + 2];
	fld	fa3,-16(a4)	# B2, MEM[(FLOAT *)_1632 + -16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:98:             double B1 = B[bi + 1];
	fld	fa2,-24(a4)	# B1, MEM[(FLOAT *)_1632 + -24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:100:             double B3 = B[bi + 3];
	fld	fa5,-8(a4)	# B3, MEM[(FLOAT *)_1632 + -8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:103:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	slli	s4,t6,3	#, _61, ai
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:103:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	add	s4,s0,s4	# _61, _62, A
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:103:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v16,0(s4)	# A0,* _62
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:104:             ai += 4;
	addi	s4,t6,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:106:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	csrr	t6,vlenb	# tmp1447
	slli	t6,t6,3	#, tmp1448, tmp1447
	addi	t6,t6,64	#, tmp1449, tmp1446
	add	t6,t6,sp	#, tmp1446, tmp1446
	vfmul.vf	v8,v16,fa1	# result0, A0, MEM[(FLOAT *)_1632 + -32B],
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:108:             vfloat64m8_t result2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	vfmul.vf	v0,v16,fa3	# result2, A0, B2,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:107:             vfloat64m8_t result1 = __riscv_vfmul_vf_f64m8(A0, B1, gvl);
	vfmul.vf	v24,v16,fa2	# result1, A0, B1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:109:             vfloat64m8_t result3 = __riscv_vfmul_vf_f64m8(A0, B3, gvl);
	vfmul.vf	v16,v16,fa5	# result3, A0, B3,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:106:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	vs8r.v	v8,0(t6)	# result0, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:108:             vfloat64m8_t result2 = __riscv_vfmul_vf_f64m8(A0, B2, gvl);
	li	t6,24		# tmp1441,
	mul	t6,t6,s5	# tmp1443, tmp1441, tmp1442
	addi	t6,t6,64	#, tmp1444, tmp1441
	add	t6,t6,sp	#, tmp1441, tmp1441
	vs8r.v	v0,0(t6)	# result2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	ble	a1,a7,.L10	#, K, tmp893,
	sub	s5,a3,a4	# tmp924, ivtmp.483, ivtmp.482
	addi	s5,s5,-32	#, tmp925, tmp924
	srli	s5,s5,5	#, tmp923, tmp925
	slli	s4,s4,3	#, _1072, ai
	andi	s5,s5,1	#, tmp927, tmp923
	add	s4,s0,s4	# _1072, ivtmp.441, A
	mv	t6,a4	# ivtmp.439, ivtmp.482
	beq	s5,zero,.L130	#, tmp927,,
	addi	s5,sp,64	#, tmp1439,
	vs8r.v	v24,0(s5)	# result1, %sfp
	csrr	s5,vlenb	# tmp1435
	slli	s5,s5,4	#, tmp1436, tmp1435
	addi	s5,s5,64	#, tmp1437, tmp1434
	add	s5,s5,sp	#, tmp1434, tmp1434
	vs8r.v	v16,0(s5)	# result3, %sfp
.L146:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	csrr	s9,vlenb	# tmp1418
	slli	s9,s9,3	#, tmp1419, tmp1418
	addi	s9,s9,64	#, tmp1420, tmp1417
	add	s9,s9,sp	#, tmp1417, tmp1417
	vl8re64.v	v16,0(s9)	# %sfp, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:124:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	addi	s9,sp,64	#, tmp1415,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:120:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(s4)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:124:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vl8re64.v	v24,0(s9)	# %sfp, result1
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:115:                 B1 = B[bi + 1];
	fld	fa2,8(t6)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa1,0(t6)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:116:                 B2 = B[bi + 2];
	fld	fa3,16(t6)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:117:                 B3 = B[bi + 3];
	fld	fa5,24(t6)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s5,s4,32	#, tmp929, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:124:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v24,fa2,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa1,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:125:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	vfmacc.vf	v0,fa3,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa1,32(t6)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:115:                 B1 = B[bi + 1];
	fld	fa2,40(t6)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:116:                 B2 = B[bi + 2];
	fld	fa3,48(t6)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:124:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vs8r.v	v24,0(s9)	# result1, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:126:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	csrr	s9,vlenb	# tmp1409
	slli	s9,s9,4	#, tmp1410, tmp1409
	addi	s9,s9,64	#, tmp1411, tmp1408
	add	s9,s9,sp	#, tmp1408, tmp1408
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,t6,64	#, ivtmp.439, ivtmp.439
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:126:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	vl8re64.v	v24,0(s9)	# %sfp, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s4,s4,64	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:126:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	vfmacc.vf	v24,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:120:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(s5)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	csrr	s5,vlenb	# tmp1404
	slli	s5,s5,3	#, tmp1405, tmp1404
	addi	s5,s5,64	#, tmp1406, tmp1403
	add	s5,s5,sp	#, tmp1403, tmp1403
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:117:                 B3 = B[bi + 3];
	fld	fa5,-8(t6)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v16,fa1,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:125:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	vfmacc.vf	v0,fa3,v8	# result2, B2, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vs8r.v	v16,0(s5)	# result0, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:124:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	addi	s5,sp,64	#, tmp1401,
	vl8re64.v	v16,0(s5)	# %sfp, result1
	vfmacc.vf	v16,fa2,v8	# result1, B1, A0,
	vs8r.v	v16,0(s5)	# result1, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:126:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	vmv8r.v	v16,v24	# result3, result3
	vfmacc.vf	v16,fa5,v8	# result3, B3, A0,
	vs8r.v	v16,0(s9)	# result3, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	bne	t6,a3,.L146	#, ivtmp.439, ivtmp.483,
	addi	t6,sp,64	#, tmp1392,
	vl8re64.v	v24,0(t6)	# %sfp, result1
	csrr	s4,vlenb	# tmp1388
	li	t6,24		# tmp1387,
	mul	t6,t6,s4	# tmp1389, tmp1387, tmp1388
	addi	t6,t6,64	#, tmp1390, tmp1387
	add	t6,t6,sp	#, tmp1387, tmp1387
	vs8r.v	v0,0(t6)	# result2, %sfp
.L10:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:138:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	csrr	s10,vlenb	# tmp1378
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:129:             BLASLONG ci = n_top * ldc + m_top;
	add	t6,s2,t3	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:138:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	slli	s10,s10,3	#, tmp1379, tmp1378
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:131:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	slli	s9,t6,3	#, _80, ci
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:138:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	addi	s10,s10,64	#, tmp1380, tmp1377
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:131:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	s9,t4,s9	# _80, _81, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:138:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	add	s10,s10,sp	#, tmp1377, tmp1377
	vl8re64.v	v0,0(s10)	# %sfp, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:131:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v8,0(s9)	# c0,* _81
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:138:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	addi	s10,sp,64	#, tmp1375,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:132:             ci += ldc - gvl * 0;
	add	t6,s3,t6	# ci, ci, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:133:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	slli	s5,t6,3	#, _83, ci
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:133:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	s5,t4,s5	# _83, _84, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:134:             ci += ldc - gvl * 0;
	add	t6,s3,t6	# ci, ci, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:138:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	vfmacc.vf	v8,fa4,v0	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:136:             ci += ldc - gvl * 0;
	add	s4,s3,t6	# ci, ci_739, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:137:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	slli	s4,s4,3	#, _89, ci_739
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:137:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	s4,t4,s4	# _89, _90, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:135:             vfloat64m8_t c2 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	slli	t6,t6,3	#, _86, ci
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:135:             vfloat64m8_t c2 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	t6,t4,t6	# _86, _87, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:138:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	vs8r.v	v8,0(s10)	# c0, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:152:             m_top += 4;
	addi	t3,t3,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:133:             vfloat64m8_t c1 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v0,0(s5)	# c1,* _84
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:137:             vfloat64m8_t c3 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v8,0(s4)	# c3,* _90
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:139:             c1 = __riscv_vfmacc_vf_f64m8(c1, alpha, result1, gvl);
	vfmacc.vf	v0,fa4,v24	# c1, alpha, result1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:145:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vl8re64.v	v24,0(s10)	# %sfp, c0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:141:             c3 = __riscv_vfmacc_vf_f64m8(c3, alpha, result3, gvl);
	vfmacc.vf	v8,fa4,v16	# c3, alpha, result3,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:140:             c2 = __riscv_vfmacc_vf_f64m8(c2, alpha, result2, gvl);
	csrr	s10,vlenb	# tmp1369
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:135:             vfloat64m8_t c2 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v16,0(t6)	# c2,* _87
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:145:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v24,0(s9)	# c0,* _81,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:140:             c2 = __riscv_vfmacc_vf_f64m8(c2, alpha, result2, gvl);
	li	s9,24		# tmp1368,
	mul	s9,s9,s10	# tmp1370, tmp1368, tmp1369
	addi	s9,s9,64	#, tmp1371, tmp1368
	add	s9,s9,sp	#, tmp1368, tmp1368
	vl8re64.v	v24,0(s9)	# %sfp, result2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:147:             __riscv_vse64_v_f64m8(&C[ci], c1, gvl);
	vse64.v	v0,0(s5)	# c1,* _84,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:140:             c2 = __riscv_vfmacc_vf_f64m8(c2, alpha, result2, gvl);
	vfmacc.vf	v16,fa4,v24	# c2, alpha, result2,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:149:             __riscv_vse64_v_f64m8(&C[ci], c2, gvl);
	vse64.v	v16,0(t6)	# c2,* _87,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:151:             __riscv_vse64_v_f64m8(&C[ci], c3, gvl);
	vse64.v	v8,0(s4)	# c3,* _90,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:155:         if (M & 2) {
	ld	t6,8(sp)		# _91, %sfp
	beq	t6,zero,.L12	#, _91,,
.L167:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:164:             BLASLONG ai = m_top * K;
	mul	s5,t3,a1	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:163:             double result7 = 0;
	fmv.d.x	fa5,zero	# result7,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:169:             for (BLASLONG k = 0; k < K; k++) {
	ble	a1,zero,.L50	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:162:             double result6 = 0;
	fmv.d	fa3,fa5	# result6, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:161:             double result5 = 0;
	fmv.d	fa2,fa5	# result5, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:160:             double result4 = 0;
	fmv.d	fa1,fa5	# result4, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:159:             double result3 = 0;
	fmv.d	fa0,fa5	# result3, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:158:             double result2 = 0;
	fmv.d	ft0,fa5	# result2, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:157:             double result1 = 0;
	fmv.d	ft1,fa5	# result1, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:156:             double result0 = 0;
	fmv.d	ft2,fa5	# result0, result7
	slli	s5,s5,3	#, _1758, ai
	add	s5,s0,s5	# _1758, vectp.311, A
	addi	s9,a4,-32	#, vectp.316, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:169:             for (BLASLONG k = 0; k < K; k++) {
	mv	s4,a1	# ivtmp_1726, K
.L14:
	vsetvli	t6,s4,e64,m1,ta,ma	# ivtmp_1726, _1725,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v2,(s5)	# vect_array.312, vectp.311,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg4e64.v	v4,(s9)	# vect_array.317, vectp.316,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v22,ft2	# tmp971, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:171:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v21,ft1	# tmp973, result1
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:172:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.s.f	v20,ft0	# tmp975, result2
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:173:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.s.f	v19,fa0	# tmp977, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:174:                 result4 += A[ai + 0] * B[bi + 2];
	vfmv.s.f	v18,fa1	# tmp979, result4
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:175:                 result5 += A[ai + 1] * B[bi + 2];
	vfmv.s.f	v17,fa2	# tmp981, result5
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:176:                 result6 += A[ai + 0] * B[bi + 3];
	vfmv.s.f	v16,fa3	# tmp983, result6
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:177:                 result7 += A[ai + 1] * B[bi + 3];
	vfmv.s.f	v15,fa5	# tmp985, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:169:             for (BLASLONG k = 0; k < K; k++) {
	slli	s10,t6,4	#, ivtmp_1761, _1725
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v14,v2,v4	# vect__100.322, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:171:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v13,v3,v4	# vect__105.324, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:172:                 result2 += A[ai + 0] * B[bi + 1];
	vfmul.vv	v12,v2,v5	# vect__110.326, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:173:                 result3 += A[ai + 1] * B[bi + 1];
	vfmul.vv	v11,v3,v5	# vect__111.328, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:174:                 result4 += A[ai + 0] * B[bi + 2];
	vfmul.vv	v10,v2,v6	# vect__116.330, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:175:                 result5 += A[ai + 1] * B[bi + 2];
	vfmul.vv	v9,v3,v6	# vect__117.332, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v4,v14,v22	# tmp972, vect__100.322, tmp971,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:176:                 result6 += A[ai + 0] * B[bi + 3];
	vfmul.vv	v8,v2,v7	# vect__122.334, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:177:                 result7 += A[ai + 1] * B[bi + 3];
	vfmul.vv	v1,v3,v7	# vect__123.336, vect_array.312, vect_array.317,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:172:                 result2 += A[ai + 0] * B[bi + 1];
	vfredosum.vs	v2,v12,v20	# tmp976, vect__110.326, tmp975,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:169:             for (BLASLONG k = 0; k < K; k++) {
	add	s5,s5,s10	# ivtmp_1761, vectp.311, vectp.311
	sub	s4,s4,t6	# ivtmp_1726, ivtmp_1726, _1725
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:171:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v3,v13,v21	# tmp974, vect__105.324, tmp973,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:169:             for (BLASLONG k = 0; k < K; k++) {
	slli	s10,t6,5	#, ivtmp_1753, _1725
	add	s9,s9,s10	# ivtmp_1753, vectp.316, vectp.316
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:173:                 result3 += A[ai + 1] * B[bi + 1];
	vfredosum.vs	v5,v11,v19	# tmp978, vect__111.328, tmp977,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:170:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	ft2,v4	# result0, tmp972
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:177:                 result7 += A[ai + 1] * B[bi + 3];
	vfredosum.vs	v1,v1,v15	# tmp986, vect__123.336, tmp985,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:172:                 result2 += A[ai + 0] * B[bi + 1];
	vfmv.f.s	ft0,v2	# result2, tmp976
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:174:                 result4 += A[ai + 0] * B[bi + 2];
	vfredosum.vs	v4,v10,v18	# tmp980, vect__116.330, tmp979,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:171:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	ft1,v3	# result1, tmp974
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:176:                 result6 += A[ai + 0] * B[bi + 3];
	vfredosum.vs	v2,v8,v16	# tmp984, vect__122.334, tmp983,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:173:                 result3 += A[ai + 1] * B[bi + 1];
	vfmv.f.s	fa0,v5	# result3, tmp978
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:175:                 result5 += A[ai + 1] * B[bi + 2];
	vfredosum.vs	v3,v9,v17	# tmp982, vect__117.332, tmp981,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:177:                 result7 += A[ai + 1] * B[bi + 3];
	vfmv.f.s	fa5,v1	# result7, tmp986
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:174:                 result4 += A[ai + 0] * B[bi + 2];
	vfmv.f.s	fa1,v4	# result4, tmp980
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:176:                 result6 += A[ai + 0] * B[bi + 3];
	vfmv.f.s	fa3,v2	# result6, tmp984
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:175:                 result5 += A[ai + 1] * B[bi + 2];
	vfmv.f.s	fa2,v3	# result5, tmp982
	bne	s4,zero,.L14	#, ivtmp_1726,,
.L13:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:182:             BLASLONG ci = n_top * ldc + m_top;
	add	t6,s2,t3	# m_top, ci, ivtmp.478
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	s5,t6,3	#, _126, ci
	add	s4,t4,s5	# _126, _127, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	ft3,0(s4)	# *_127, *_127
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	s5,s5,8	#, _132, _126
	add	s9,t4,s5	# _132, _133, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	ft2,fa4,ft2,ft3	# _130, alpha, result0, *_127
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	add	s5,s3,t6	# ci, _137, ldc
	slli	s5,s5,3	#, _139, _137
	add	s11,t4,s5	# _139, _140, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	add	s5,t4,s5	# _145, _146, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	ld	s10,40(sp)		# _164, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:191:             m_top += 2;
	addi	t3,t3,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:183:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	ft2,0(s4)	# _130, *_127
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	ft2,0(s9)	# *_133, *_133
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	ld	s4,32(sp)		# _150, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	fmadd.d	ft1,fa4,ft1,ft2	# _136, alpha, result1, *_133
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	s4,s4,t6	# ci, _151, _150
	slli	s4,s4,3	#, _153, _151
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	t6,s10,t6	# ci, _165, _164
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	add	s10,t4,s4	# _153, _154, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	add	s4,t4,s4	# _159, _160, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	slli	t6,t6,3	#, _167, _165
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:184:             C[ci + 0 * ldc + 1] += alpha * result1;
	fsd	ft1,0(s9)	# _136, *_133
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	fld	ft1,0(s11)	# *_140, *_140
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	add	s9,t4,t6	# _167, _168, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:190:             C[ci + 3 * ldc + 1] += alpha * result7;
	add	t6,t4,t6	# _173, _174, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:185:             C[ci + 1 * ldc + 0] += alpha * result2;
	fmadd.d	ft0,fa4,ft0,ft1	# _143, alpha, result2, *_140
	fsd	ft0,0(s11)	# _143, *_140
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:186:             C[ci + 1 * ldc + 1] += alpha * result3;
	fld	ft0,8(s5)	# *_146, *_146
	fmadd.d	fa0,fa4,fa0,ft0	# _149, alpha, result3, *_146
	fsd	fa0,8(s5)	# _149, *_146
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:187:             C[ci + 2 * ldc + 0] += alpha * result4;
	fld	fa0,0(s10)	# *_154, *_154
	fmadd.d	fa1,fa4,fa1,fa0	# _157, alpha, result4, *_154
	fsd	fa1,0(s10)	# _157, *_154
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:188:             C[ci + 2 * ldc + 1] += alpha * result5;
	fld	fa1,8(s4)	# *_160, *_160
	fmadd.d	fa2,fa4,fa2,fa1	# _163, alpha, result5, *_160
	fsd	fa2,8(s4)	# _163, *_160
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:189:             C[ci + 3 * ldc + 0] += alpha * result6;
	fld	fa2,0(s9)	# *_168, *_168
	fmadd.d	fa3,fa4,fa3,fa2	# _171, alpha, result6, *_168
	fsd	fa3,0(s9)	# _171, *_168
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:190:             C[ci + 3 * ldc + 1] += alpha * result7;
	fld	fa3,8(t6)	# *_174, *_174
	fmadd.d	fa5,fa4,fa5,fa3	# _177, alpha, result7, *_174
	fsd	fa5,8(t6)	# _177, *_174
	j	.L12		#
.L130:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	csrr	s5,vlenb	# tmp1364
	slli	s5,s5,3	#, tmp1365, tmp1364
	addi	s5,s5,64	#, tmp1366, tmp1363
	add	s5,s5,sp	#, tmp1363, tmp1363
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:120:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(s4)	# A0,* ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vl8re64.v	v0,0(s5)	# %sfp, result0
	fld	fa1,0(a4)	# MEM[(FLOAT *)_431], MEM[(FLOAT *)_431]
	csrr	s5,vlenb	# tmp1359
	slli	s5,s5,3	#, tmp1360, tmp1359
	addi	s5,s5,64	#, tmp1361, tmp1358
	add	s5,s5,sp	#, tmp1358, tmp1358
	vfmacc.vf	v0,fa1,v8	# result0, MEM[(FLOAT *)_431], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:125:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	csrr	s9,vlenb	# tmp1354
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:116:                 B2 = B[bi + 2];
	fld	fa3,16(a4)	# B2, MEM[(FLOAT *)_431 + 16B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:115:                 B1 = B[bi + 1];
	fld	fa2,8(a4)	# B1, MEM[(FLOAT *)_431 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:117:                 B3 = B[bi + 3];
	fld	fa5,24(a4)	# B3, MEM[(FLOAT *)_431 + 24B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	t6,a4,32	#, ivtmp.439, ivtmp.482
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:123:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vs8r.v	v0,0(s5)	# result0, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:125:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	li	s5,24		# tmp1353,
	mul	s5,s5,s9	# tmp1355, tmp1353, tmp1354
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:124:                 result1 = __riscv_vfmacc_vf_f64m8(result1, B1, A0, gvl);
	vfmacc.vf	v24,fa2,v8	# result1, B1, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:126:                 result3 = __riscv_vfmacc_vf_f64m8(result3, B3, A0, gvl);
	vfmacc.vf	v16,fa5,v8	# result3, B3, A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	addi	s4,s4,32	#, ivtmp.441, ivtmp.441
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:125:                 result2 = __riscv_vfmacc_vf_f64m8(result2, B2, A0, gvl);
	addi	s5,s5,64	#, tmp1356, tmp1353
	add	s5,s5,sp	#, tmp1353, tmp1353
	vl8re64.v	v0,0(s5)	# %sfp, result2
	li	s5,24		# tmp1348,
	mul	s5,s5,s9	# tmp1350, tmp1348, tmp1349
	vfmacc.vf	v0,fa3,v8	# result2, B2, A0,
	addi	s5,s5,64	#, tmp1351, tmp1348
	add	s5,s5,sp	#, tmp1348, tmp1348
	vs8r.v	v0,0(s5)	# result2, %sfp
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:113:             for (BLASLONG k = 1; k < K; k++) {
	beq	t6,a3,.L10	#, ivtmp.439, ivtmp.483,
	addi	s5,sp,64	#, tmp1432,
	vs8r.v	v24,0(s5)	# result1, %sfp
	csrr	s9,vlenb	# tmp1428
	li	s5,24		# tmp1427,
	mul	s5,s5,s9	# tmp1429, tmp1427, tmp1428
	addi	s5,s5,64	#, tmp1430, tmp1427
	add	s5,s5,sp	#, tmp1427, tmp1427
	vl8re64.v	v0,0(s5)	# %sfp, result2
	slli	s5,s9,4	#, tmp1424, tmp1423
	addi	s5,s5,64	#, tmp1425, tmp1422
	add	s5,s5,sp	#, tmp1422, tmp1422
	vs8r.v	v16,0(s5)	# result3, %sfp
	j	.L146		#
.L49:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:26:         m_top = 0;
	li	t3,0		# m_top,
	j	.L5		#
.L164:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:371:     if (N & 1) {
	andi	a5,t3,1	#, _365, N
	vsetivli	zero,8,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:371:     if (N & 1) {
	beq	a5,zero,.L135	#, _365,,
.L169:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t1,s1,63	#, tmp850, M
	andi	t1,t1,7	#, tmp851, tmp850
	add	t1,t1,s1	# M, tmp852, tmp851
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	a5,7		# tmp854,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	srai	t1,t1,3	#, _892, tmp852
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	ble	s1,a5,.L55	#, M, tmp854,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:377:             BLASLONG bi = n_top * K;
	mul	t3,t5,a1	# bi_695, n_top, K
	slli	t2,a1,6	#, _103, K
	add	a0,t2,s0	# A, ivtmp.381, _103
	mv	a7,s0	# ivtmp.376, A
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	li	t0,0		# i,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:388:             for (BLASLONG k = 1; k < K; k++) {
	li	s2,1		# tmp859,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:398:             BLASLONG ci = n_top * ldc + m_top;
	mul	a6,s3,t5	# _521, ldc, n_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:378:             double B0 = B[bi + 0];
	slli	t3,t3,3	#, _368, bi_695
	add	t3,t6,t3	# _368, _369, B
	slli	a6,a6,3	#, _108, _521
	add	a6,t4,a6	# _108, ivtmp.377, C
.L38:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:381:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a7)	# A0,* ivtmp.376
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:384:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa5,0(t3)	# *_369, *_369
	vfmul.vf	v8,v8,fa5	# result0, A0, *_369,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:388:             for (BLASLONG k = 1; k < K; k++) {
	ble	a1,s2,.L36	#, K, tmp859,
	addi	a5,a7,64	#, ivtmp.369, ivtmp.376
	sub	a2,a0,a5	# tmp903, ivtmp.381, ivtmp.369
	addi	a2,a2,-64	#, tmp904, tmp903
	srli	a2,a2,6	#, tmp902, tmp904
	andi	a2,a2,1	#, tmp906, tmp902
	mv	a3,t3	# ivtmp.368, _369
	bne	a2,zero,.L143	#, tmp906,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:392:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v16,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:395:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa5,8(t3)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:388:             for (BLASLONG k = 1; k < K; k++) {
	addi	a5,a7,128	#, ivtmp.369, ivtmp.376
	addi	a3,t3,8	#, ivtmp.368, _369
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:395:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa5,v16	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:388:             for (BLASLONG k = 1; k < K; k++) {
	beq	a0,a5,.L36	#, ivtmp.381, ivtmp.369,
.L143:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:392:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v16,0(a5)	# A0,* ivtmp.369
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:395:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa5,8(a3)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:388:             for (BLASLONG k = 1; k < K; k++) {
	addi	a2,a5,64	#, tmp908, ivtmp.369
	addi	a5,a5,128	#, ivtmp.369, ivtmp.369
	addi	a3,a3,16	#, ivtmp.368, ivtmp.368
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:395:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa5,v16	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:392:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v16,0(a2)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:395:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa5,0(a3)	# MEM[(FLOAT *)_1764 + 8B], MEM[(FLOAT *)_1764 + 8B]
	vfmacc.vf	v8,fa5,v16	# result0, MEM[(FLOAT *)_1764 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:388:             for (BLASLONG k = 1; k < K; k++) {
	bne	a0,a5,.L143	#, ivtmp.381, ivtmp.369,
.L36:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:400:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v16,0(a6)	# c0,* ivtmp.377
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	t0,t0,1	#, i, i
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	add	a7,a7,t2	# _103, ivtmp.376, ivtmp.376
	add	a0,a0,t2	# _103, ivtmp.381, ivtmp.381
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:401:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	vfmacc.vf	v16,fa4,v8	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:405:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v16,0(a6)	# c0,* ivtmp.377,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:375:         for (BLASLONG i = 0; i < M / 8; i += 1) {
	addi	a6,a6,64	#, ivtmp.377, ivtmp.377
	blt	t0,t1,.L38	#, i, _892,
	slli	t1,t1,3	#, m_top, _892
.L35:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:409:         if (M & 4) {
	andi	a5,s1,4	#, _384, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:409:         if (M & 4) {
	beq	a5,zero,.L39	#, _384,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:412:             BLASLONG ai = m_top * K;
	mul	a5,a1,t1	# ai, K, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:410:             gvl = __riscv_vsetvl_e64m8(4);
	vsetivli	zero,4,e64,m8,ta,ma	#,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:424:             for (BLASLONG k = 1; k < K; k++) {
	li	a0,1		# tmp866,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:413:             BLASLONG bi = n_top * K;
	mul	a2,t5,a1	# bi.185_386, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:417:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	slli	a4,a5,3	#, _390, ai
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:417:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	add	a4,s0,a4	# _390, _391, A
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:417:             vfloat64m8_t A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v8,0(a4)	# A0,* _391
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:418:             ai += 4;
	addi	a5,a5,4	#, ai, ai
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:414:             double B0 = B[bi + 0];
	slli	a4,a2,3	#, _387, bi.185_386
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:414:             double B0 = B[bi + 0];
	add	a4,t6,a4	# _387, tmp864, B
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:420:             vfloat64m8_t result0 = __riscv_vfmul_vf_f64m8(A0, B0, gvl);
	fld	fa5,0(a4)	# *_388, *_388
	vfmul.vf	v8,v8,fa5	# result0, A0, *_388,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:424:             for (BLASLONG k = 1; k < K; k++) {
	ble	a1,a0,.L40	#, K, tmp866,
	add	a2,a1,a2	# bi.185_386, _302, K
	addi	a0,t6,-8	#, _1921, B
	slli	a2,a2,3	#, _301, _302
	add	a2,a2,a0	# _1921, _298, _301
	sub	a0,a2,a4	# tmp896, _298, ivtmp.354
	addi	a0,a0,-8	#, tmp897, tmp896
	srli	a0,a0,3	#, tmp895, tmp897
	slli	a5,a5,3	#, _307, ai
	andi	a0,a0,1	#, tmp899, tmp895
	add	a5,s0,a5	# _307, ivtmp.355, A
	bne	a0,zero,.L142	#, tmp899,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:428:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v16,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:431:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa5,8(a4)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:424:             for (BLASLONG k = 1; k < K; k++) {
	addi	a4,a4,8	#, ivtmp.354, ivtmp.354
	addi	a5,a5,32	#, ivtmp.355, ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:431:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa5,v16	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:424:             for (BLASLONG k = 1; k < K; k++) {
	beq	a4,a2,.L40	#, ivtmp.354, _298,
.L142:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:428:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v16,0(a5)	# A0,* ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:431:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa5,8(a4)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:424:             for (BLASLONG k = 1; k < K; k++) {
	addi	a0,a5,32	#, tmp901, ivtmp.355
	addi	a4,a4,16	#, ivtmp.354, ivtmp.354
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:428:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	addi	a5,a5,64	#, ivtmp.355, ivtmp.355
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:431:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	vfmacc.vf	v8,fa5,v16	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:428:                 A0 = __riscv_vle64_v_f64m8(&A[ai + 0 * gvl], gvl);
	vle64.v	v16,0(a0)	# A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:431:                 result0 = __riscv_vfmacc_vf_f64m8(result0, B0, A0, gvl);
	fld	fa5,0(a4)	# MEM[(FLOAT *)_305 + 8B], MEM[(FLOAT *)_305 + 8B]
	vfmacc.vf	v8,fa5,v16	# result0, MEM[(FLOAT *)_305 + 8B], A0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:424:             for (BLASLONG k = 1; k < K; k++) {
	bne	a4,a2,.L142	#, ivtmp.354, _298,
.L40:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:434:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,t5,s3	# _398, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:434:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,t1	# m_top, ci_662, _398
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:436:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	slli	a5,a5,3	#, _400, ci_662
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:436:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	add	a5,t4,a5	# _400, _401, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:436:             vfloat64m8_t c0 = __riscv_vle64_v_f64m8(&C[ci], gvl);
	vle64.v	v16,0(a5)	# c0,* _401
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:442:             m_top += 4;
	addi	t1,t1,4	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:437:             c0 = __riscv_vfmacc_vf_f64m8(c0, alpha, result0, gvl);
	vfmacc.vf	v16,fa4,v8	# c0, alpha, result0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:441:             __riscv_vse64_v_f64m8(&C[ci], c0, gvl);
	vse64.v	v16,0(a5)	# c0,* _401,
.L39:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:445:         if (M & 2) {
	andi	a5,s1,2	#, _402, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:445:         if (M & 2) {
	beq	a5,zero,.L42	#, _402,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:448:             BLASLONG ai = m_top * K;
	mul	a3,t1,a1	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:447:             double result1 = 0;
	fmv.d.x	fa5,zero	# result1,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:449:             BLASLONG bi = n_top * K;
	mul	a4,t5,a1	# bi, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:453:             for (BLASLONG k = 0; k < K; k++) {
	ble	a1,zero,.L56	#, K,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:446:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	slli	a3,a3,3	#, _1876, ai
	slli	a4,a4,3	#, _1868, bi
	add	a3,s0,a3	# _1876, vectp.242, A
	add	a4,t6,a4	# _1868, vectp.247, B
	mv	a2,a1	# bnd.240, K
.L44:
	vsetvli	a5,a2,e64,m1,ta,ma	# bnd.240, _1858,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:454:                 result0 += A[ai + 0] * B[bi + 0];
	vlseg2e64.v	v4,(a3)	# vect_array.243, vectp.242,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:454:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(a4)	# vect__410.248,* vectp.247
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:454:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v6,fa3	# tmp947, result0
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:455:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.s.f	v3,fa5	# tmp949, result1
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:453:             for (BLASLONG k = 0; k < K; k++) {
	slli	a6,a5,4	#, ivtmp_1879, _1858
	slli	a0,a5,3	#, ivtmp_1871, _1858
	sub	a2,a2,a5	# bnd.240, bnd.240, _1858
	add	a3,a3,a6	# ivtmp_1879, vectp.242, vectp.242
	add	a4,a4,a0	# ivtmp_1871, vectp.247, vectp.247
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:454:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v2,v1,v4	# vect__411.249, vect__410.248, vect_array.243,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:455:                 result1 += A[ai + 1] * B[bi + 0];
	vfmul.vv	v1,v1,v5	# vect__416.251, vect__410.248, vect_array.243,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:454:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v2,v2,v6	# tmp948, vect__411.249, tmp947,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:455:                 result1 += A[ai + 1] * B[bi + 0];
	vfredosum.vs	v1,v1,v3	# tmp950, vect__416.251, tmp949,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:454:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.f.s	fa3,v2	# result0, tmp948
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:455:                 result1 += A[ai + 1] * B[bi + 0];
	vfmv.f.s	fa5,v1	# result1, tmp950
	bne	a2,zero,.L44	#, bnd.240,,
.L43:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:460:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,t5,s3	# _417, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:460:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,t1	# m_top, ci_677, _417
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:461:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a5,a5,3	#, _419, ci_677
	add	a4,t4,a5	# _419, _420, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:461:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa2,0(a4)	# *_420, *_420
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:462:             C[ci + 0 * ldc + 1] += alpha * result1;
	addi	a5,a5,8	#, _425, _419
	add	a5,t4,a5	# _425, _426, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:461:             C[ci + 0 * ldc + 0] += alpha * result0;
	fmadd.d	fa3,fa4,fa3,fa2	# _423, alpha, result0, *_420
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:463:             m_top += 2;
	addi	t1,t1,2	#, m_top, m_top
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:461:             C[ci + 0 * ldc + 0] += alpha * result0;
	fsd	fa3,0(a4)	# _423, *_420
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:462:             C[ci + 0 * ldc + 1] += alpha * result1;
	fld	fa3,0(a5)	# *_426, *_426
	fmadd.d	fa5,fa4,fa5,fa3	# _429, alpha, result1, *_426
	fsd	fa5,0(a5)	# _429, *_426
.L42:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:466:         if (M & 1) {
	andi	s1,s1,1	#, _430, M
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:466:         if (M & 1) {
	beq	s1,zero,.L135	#, _430,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:468:             BLASLONG ai = m_top * K;
	mul	a3,t1,a1	# ai, m_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:467:             double result0 = 0;
	fmv.d.x	fa5,zero	# result0,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:469:             BLASLONG bi = n_top * K;
	mul	a4,t5,a1	# bi, n_top, K
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:473:             for (BLASLONG k = 0; k < K; k++) {
	ble	a1,zero,.L46	#, K,,
	slli	a3,a3,3	#, _1898, ai
	slli	a4,a4,3	#, _1891, bi
	add	a3,s0,a3	# _1898, vectp.232, A
	add	a4,t6,a4	# _1891, vectp.235, B
.L47:
	vsetvli	a5,a1,e64,m1,ta,ma	# bnd.230, _1883,,,,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:474:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v3,0(a3)	# vect__434.233,* vectp.232
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:474:                 result0 += A[ai + 0] * B[bi + 0];
	vle64.v	v1,0(a4)	# vect__438.236,* vectp.235
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:474:                 result0 += A[ai + 0] * B[bi + 0];
	vfmv.s.f	v2,fa5	# tmp945, result0
	slli	a2,a5,3	#, ivtmp_1903, _1883
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:473:             for (BLASLONG k = 0; k < K; k++) {
	sub	a1,a1,a5	# bnd.230, bnd.230, _1883
	add	a3,a3,a2	# ivtmp_1903, vectp.232, vectp.232
	add	a4,a4,a2	# ivtmp_1903, vectp.235, vectp.235
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:474:                 result0 += A[ai + 0] * B[bi + 0];
	vfmul.vv	v1,v1,v3	# vect__439.237, vect__438.236, vect__434.233,
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:474:                 result0 += A[ai + 0] * B[bi + 0];
	vfredosum.vs	v1,v1,v2	# tmp946, vect__439.237, tmp945,
	vfmv.f.s	fa5,v1	# result0, tmp946
	bne	a1,zero,.L47	#, bnd.230,,
.L46:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:479:             BLASLONG ci = n_top * ldc + m_top;
	mul	a5,t5,s3	# _440, n_top, ldc
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:479:             BLASLONG ci = n_top * ldc + m_top;
	add	a5,a5,t1	# m_top, ci_688, _440
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:480:             C[ci + 0 * ldc + 0] += alpha * result0;
	slli	a5,a5,3	#, _442, ci_688
	add	a5,t4,a5	# _442, _443, C
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:480:             C[ci + 0 * ldc + 0] += alpha * result0;
	fld	fa3,0(a5)	# *_443, *_443
	fmadd.d	fa5,fa4,fa5,fa3	# _446, alpha, result0, *_443
	fsd	fa5,0(a5)	# _446, *_443
	j	.L135		#
.L165:
	slli	s7,a6,3	#, _1906, _947
	j	.L4		#
.L50:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:162:             double result6 = 0;
	fmv.d	fa3,fa5	# result6, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:161:             double result5 = 0;
	fmv.d	fa2,fa5	# result5, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:160:             double result4 = 0;
	fmv.d	fa1,fa5	# result4, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:159:             double result3 = 0;
	fmv.d	fa0,fa5	# result3, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:158:             double result2 = 0;
	fmv.d	ft0,fa5	# result2, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:157:             double result1 = 0;
	fmv.d	ft1,fa5	# result1, result7
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:156:             double result0 = 0;
	fmv.d	ft2,fa5	# result0, result7
	j	.L13		#
.L51:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:197:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:196:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:195:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	j	.L16		#
.L55:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:373:         m_top = 0;
	li	t1,0		# m_top,
	j	.L35		#
.L52:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:228:         m_top = 0;
	li	t1,0		# m_top,
	j	.L20		#
.L48:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:21:     BLASLONG n_top = 0;
	li	t5,0		# n_top,
	j	.L2		#
.L54:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:346:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	j	.L31		#
.L56:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:446:             double result0 = 0;
	fmv.d	fa3,fa5	# result0, result1
	j	.L43		#
.L53:
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:321:             double result2 = 0;
	fmv.d	fa3,fa5	# result2, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:320:             double result1 = 0;
	fmv.d	fa2,fa5	# result1, result3
# dgemm_kernel_8x4_zvl128b_lmul8_unroll2.c:319:             double result0 = 0;
	fmv.d	fa1,fa5	# result0, result3
	j	.L28		#
	.cfi_endproc
.LFE0:
	.size	dgemm_kernel_8x4_zvl128b_lmul8_unroll2, .-dgemm_kernel_8x4_zvl128b_lmul8_unroll2
	.ident	"GCC: (Bianbu 14.2.0-4ubuntu2~24.04bb1) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
