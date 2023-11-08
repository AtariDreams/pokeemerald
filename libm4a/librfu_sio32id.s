	.arch armv4t
	.fpu softvfp
	.eabi_attribute 23, 1
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"<stdin>"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	Sio32IDIntr, %function
Sio32IDIntr:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r8
	mov	lr, r9
	ldr	r1, .L31
	ldr	r3, .L31+4
	ldrb	r0, [r1]
	push	{r7, lr}
	ldr	r7, [r3]
	cmp	r0, #1
	beq	.L2
	movs	r4, #128
	ldr	r2, .L31+8
	ldrh	r3, [r2]
	orrs	r3, r4
	strh	r3, [r2]
.L2:
	movs	r2, #1
	movs	r4, r7
	subs	r2, r2, r0
	lsls	r2, r2, #4
	lsls	r4, r4, r2
	ldrh	r5, [r1, #10]
	lsrs	r4, r4, #16
	mov	r9, r4
	lsls	r6, r0, #4
	cmp	r5, #0
	bne	.L3
	lsls	r7, r7, r6
	ldrh	r3, [r1, #6]
	lsrs	r7, r7, #16
	mov	r8, r3
	cmp	r3, r7
	beq	.L28
	movs	r3, #0
	ldr	r7, .L31+12
	mov	ip, r3
	mov	r8, r7
	strh	r5, [r1, #2]
.L16:
	mov	r3, r8
	strh	r3, [r1, #4]
	mov	r3, r9
	mvns	r3, r3
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1, #6]
	lsls	r7, r7, r2
	lsls	r3, r3, r6
	adds	r7, r7, r3
	ldr	r3, .L31+4
	str	r7, [r3]
	cmp	r0, #1
	beq	.L29
.L1:
	@ sp needed
	pop	{r6, r7}
	mov	r9, r7
	mov	r8, r6
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L3:
	ldrh	r3, [r1, #2]
	mov	ip, r3
.L9:
	mov	r7, ip
	cmp	r7, #3
	bls	.L26
.L10:
	mov	r3, r9
	mvns	r3, r3
	ldr	r4, .L31+16
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1, #6]
	strh	r4, [r1, #4]
	ldr	r1, .L31+20
	lsls	r3, r3, r6
	lsls	r1, r1, r2
	ldr	r2, .L31+4
	adds	r3, r1, r3
	str	r3, [r2]
	cmp	r0, #1
	bne	.L1
.L15:
	cmp	r5, #0
	bne	.L1
	movs	r1, #128
	ldr	r2, .L31+8
	ldrh	r3, [r2]
	orrs	r3, r1
	strh	r3, [r2]
	b	.L1
.L29:
	ldr	r3, .L31+24
	mov	r8, r3
	add	r4, r4, r8
	cmp	r4, #0
	beq	.L15
	mov	r3, ip
	cmp	r3, #0
	beq	.L1
	b	.L15
.L28:
	ldrh	r3, [r1, #2]
	mov	ip, r3
	cmp	r3, #3
	bhi	.L5
	ldrh	r7, [r1, #4]
	mvns	r7, r7
	lsls	r7, r7, #16
	lsrs	r7, r7, #16
	cmp	r8, r7
	beq	.L30
.L26:
	mov	r3, ip
	ldr	r7, .L31+28
	lsls	r3, r3, #1
	ldrh	r3, [r3, r7]
	mov	r8, r3
	movs	r7, r3
	b	.L16
.L5:
	movs	r5, r4
	strh	r4, [r1, #10]
	b	.L10
.L30:
	mov	r3, r8
	mvns	r7, r3
	lsls	r7, r7, #16
	lsrs	r7, r7, #16
	cmp	r7, r4
	bne	.L26
	mov	r7, ip
	adds	r7, r7, #1
	lsls	r7, r7, #16
	lsrs	r3, r7, #16
	mov	ip, r3
	strh	r3, [r1, #2]
	b	.L9
.L32:
	.align	2
.L31:
	.word	.LANCHOR0
	.word	67109152
	.word	67109160
	.word	18766
	.word	-32767
	.word	32769
	.word	-18766
	.word	.LANCHOR1
	.size	Sio32IDIntr, .-Sio32IDIntr
	.align	1
	.p2align 2,,3
	.global	AgbRFU_checkID
	.syntax unified
	.code	16
	.thumb_func
	.type	AgbRFU_checkID, %function
AgbRFU_checkID:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r9
	mov	lr, fp
	mov	r7, r10
	mov	r5, r8
	push	{r5, r6, r7, lr}
	ldr	r4, .L50
	ldrh	r3, [r4]
	mov	r9, r0
	sub	sp, sp, #12
	cmp	r3, #0
	bne	.LCB210
	b	.L44	@long jump
.LCB210:
	ldr	r7, .L50+4
	ldrh	r3, [r7]
	mov	r10, r3
	ldr	r3, .L50+8
	movs	r2, #10
	mov	r8, r3
	ldr	r3, [r3]
	ldr	r0, .L50+12
	str	r2, [r3]
	bl	STWI_set_Callback_ID
	movs	r2, #0
	mov	r3, r8
	strh	r2, [r4]
	ldr	r3, [r3]
	ldrb	r0, [r3, #10]
	movs	r3, #8
	lsls	r3, r3, r0
	movs	r0, #128
	ldrh	r1, [r7]
	orrs	r3, r0
	bics	r1, r3
	movs	r3, #1
	strh	r1, [r7]
	strh	r3, [r4]
	ldr	r3, .L50+16
	strh	r2, [r3]
	movs	r3, #128
	ldr	r5, .L50+20
	lsls	r3, r3, #5
	strh	r3, [r5]
	movs	r3, #129
	ldrh	r1, [r5]
	ldr	r4, .L50+24
	lsls	r3, r3, #7
	orrs	r3, r1
	strh	r3, [r5]
	movs	r1, r4
	str	r2, [sp, #4]
	add	r0, sp, #4
	ldr	r2, .L50+28
	bl	CpuSet
	movs	r2, #128
	ldr	r3, .L50+32
	strh	r2, [r3]
	mov	r3, r8
	ldr	r2, .L50+36
	movs	r0, #255
	mov	ip, r2
	ldr	r1, [r3]
	ldrb	r3, [r1, #10]
	mov	r2, r9
	lsls	r0, r0, #24
	add	r3, r3, ip
	mov	ip, r0
	lsls	r2, r2, #27
	add	r2, r2, ip
	lsls	r3, r3, #2
	lsrs	r2, r2, #24
	cmp	r2, #255
	bne	.LCB284
	b	.L45	@long jump
.LCB284:
	movs	r1, #1
	mov	fp, r1
	mov	ip, r1
.L43:
	ldrb	r1, [r4, #1]
	cmp	r1, #0
	beq	.L36
	cmp	r1, #1
	beq	.L37
	ldrh	r1, [r4, #10]
	cmp	r1, #0
	beq	.LCB300
	b	.L48	@long jump
.LCB300:
.L39:
	movs	r1, #0
	strh	r1, [r3, #2]
	strh	r1, [r3]
	adds	r1, r1, #131
	strh	r1, [r3, #2]
.L42:
	ldrh	r1, [r3]
	cmp	r1, #31
	bls	.L42
	movs	r1, #0
	subs	r2, r2, #1
	lsls	r2, r2, #24
	strh	r1, [r3, #2]
	lsrs	r2, r2, #24
	strh	r1, [r3]
	cmp	r2, #255
	bne	.L43
	mov	r3, r8
	ldr	r1, [r3]
	movs	r3, #0
	mov	r9, r3
	b	.L35
.L37:
	ldrh	r0, [r4, #10]
	cmp	r0, #0
	bne	.L40
	ldrb	r0, [r4]
	cmp	r0, #1
	beq	.L49
	ldrh	r0, [r4, #4]
	ldr	r6, .L50+40
	cmp	r0, r6
	beq	.L39
	ldrh	r0, [r4, #2]
	mov	r9, r0
	cmp	r0, #0
	bne	.L39
	ldr	r6, .L50
	strh	r0, [r6]
	movs	r6, #128
	ldr	r0, .L50+4
	ldrh	r0, [r0]
	bics	r0, r6
	ldr	r6, .L50+4
	strh	r0, [r6]
	ldr	r6, .L50
	strh	r1, [r6]
	mov	r6, r9
	ldr	r0, .L50+20
	strh	r6, [r0]
	movs	r0, #128
	ldr	r6, .L50+20
	lsls	r0, r0, #5
	strh	r0, [r6]
	movs	r6, #128
	ldr	r0, .L50+32
	strh	r6, [r0]
	ldr	r6, .L50+20
	ldrh	r0, [r6]
	movs	r6, r0
	movs	r0, #129
	lsls	r0, r0, #7
	orrs	r0, r6
	ldr	r6, .L50+20
	strh	r0, [r6]
	mov	r0, r9
	ldr	r6, .L50
	strh	r0, [r6]
	movs	r6, #128
	ldr	r0, .L50+4
	ldrh	r0, [r0]
	orrs	r0, r6
	ldr	r6, .L50+4
	strh	r0, [r6]
	ldr	r6, .L50
	strh	r1, [r6]
	b	.L39
.L36:
	mov	r0, fp
	mov	r6, ip
	strb	r0, [r4]
	ldrh	r0, [r5]
	orrs	r0, r6
	lsls	r0, r0, #16
	lsrs	r0, r0, #16
	strh	r0, [r5]
	movs	r0, #128
	ldr	r6, .L50
	strh	r1, [r6]
	ldrh	r1, [r7]
	orrs	r1, r0
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r7]
	mov	r1, fp
	strh	r1, [r6]
	mov	r1, ip
	strb	r1, [r4, #1]
	subs	r0, r0, #1
	ldrb	r1, [r5]
	subs	r0, r0, #255
	orrs	r1, r0
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	strb	r1, [r5]
	b	.L39
.L40:
	movs	r3, #2
	mov	r9, r0
	strb	r3, [r4, #1]
.L38:
	mov	r3, r8
	ldr	r1, [r3]
.L35:
	movs	r3, #0
	mov	r4, r10
	ldr	r2, .L50
	ldr	r0, .L50+4
	strh	r3, [r2]
	strh	r4, [r0]
	movs	r0, #1
	strh	r0, [r2]
	movs	r0, #0
	str	r3, [r1]
	bl	STWI_set_Callback_ID
.L33:
	mov	r0, r9
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L49:
	ldrh	r1, [r4, #2]
	cmp	r1, #0
	beq	.LCB544
	b	.L39	@long jump
.LCB544:
	ldr	r6, .L50
	strh	r1, [r6]
	mov	r9, r6
	ldr	r6, .L50+20
	ldrh	r1, [r6]
	movs	r6, #128
	orrs	r1, r6
	ldr	r6, .L50+20
	strh	r1, [r6]
	mov	r1, r9
	strh	r0, [r1]
	b	.L39
.L48:
	mov	r9, r1
	b	.L38
.L45:
	movs	r3, #0
	mov	r9, r3
	b	.L35
.L44:
	movs	r3, #1
	rsbs	r3, r3, #0
	mov	r9, r3
	b	.L33
.L51:
	.align	2
.L50:
	.word	67109384
	.word	67109376
	.word	gSTWIStatus
	.word	Sio32IDIntr
	.word	67109172
	.word	67109160
	.word	.LANCHOR0
	.word	83886083
	.word	67109378
	.word	16777280
	.word	32769
	.size	AgbRFU_checkID, .-AgbRFU_checkID
	.global	gRfuSIO32Id
	.section	.rodata
	.align	2
	.set	.LANCHOR1,. + 0
	.type	Sio32ConnectionData, %object
	.size	Sio32ConnectionData, 8
Sio32ConnectionData:
	.short	18766
	.short	21582
	.short	20037
	.short	20292
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	gRfuSIO32Id, %object
	.size	gRfuSIO32Id, 12
gRfuSIO32Id:
	.space	12
	.ident	"GCC: (devkitARM release 62) 13.2.0"
.text
	.align	2, 0

