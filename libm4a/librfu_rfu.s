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
	.type	rfu_STC_fastCopy, %function
rfu_STC_fastCopy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r8
	ldr	r5, [r0]
	push	{lr}
	ldr	r4, [r1]
	subs	r3, r2, #1
	mov	ip, r3
	bcc	.L2
	mov	r3, ip
	cmp	r3, #6
	bls	.L11
	movs	r3, r5
	orrs	r3, r4
	lsls	r3, r3, #30
	bne	.L11
	adds	r3, r5, #1
	subs	r3, r4, r3
	cmp	r3, #2
	bls	.L11
	movs	r3, #0
	lsrs	r7, r2, #2
	lsls	r7, r7, #2
.L7:
	ldr	r6, [r5, r3]
	str	r6, [r4, r3]
	adds	r3, r3, #4
	cmp	r3, r7
	bne	.L7
	adds	r6, r5, r3
	mov	r8, r6
	mov	r6, ip
	adds	r7, r4, r3
	subs	r6, r6, r3
	cmp	r2, r3
	beq	.L10
	mov	r3, r8
	ldrb	r3, [r3]
	strb	r3, [r7]
	cmp	r6, #0
	beq	.L10
	mov	r3, r8
	ldrb	r3, [r3, #1]
	strb	r3, [r7, #1]
	cmp	r6, #1
	beq	.L10
	mov	r3, r8
	ldrb	r3, [r3, #2]
	strb	r3, [r7, #2]
.L10:
	adds	r5, r5, r2
	adds	r4, r4, r2
.L2:
	str	r5, [r0]
	@ sp needed
	str	r4, [r1]
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L11:
	movs	r3, #0
.L6:
	ldrb	r6, [r5, r3]
	strb	r6, [r4, r3]
	adds	r3, r3, #1
	cmp	r2, r3
	bne	.L6
	b	.L10
	.size	rfu_STC_fastCopy, .-rfu_STC_fastCopy
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_NI_constructLLSF, %function
rfu_STC_NI_constructLLSF:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r10
	mov	r5, r8
	mov	lr, fp
	mov	r6, r9
	ldr	r3, .L65
	mov	r8, r3
	ldr	r3, [r3]
	ldrb	r3, [r3]
	mov	r10, r3
	movs	r3, #32
	push	{r5, r6, r7, lr}
	sub	sp, sp, #20
	str	r0, [sp, #4]
	movs	r4, r2
	ldrh	r7, [r2]
	ldrb	r3, [r2, r3]
	ldr	r2, .L65+4
	cmp	r7, r2
	bne	.LCB116
	b	.L61	@long jump
.LCB116:
	lsls	r2, r7, #25
	bpl	.L62
	movs	r2, #0
	movs	r6, #0
	mov	ip, r2
.L34:
	ldr	r2, .L65+8
	mov	r9, r2
	mov	r2, r10
	lsls	r5, r2, #4
	mov	r2, r9
	movs	r0, #15
	str	r5, [sp]
	adds	r5, r2, r5
	ands	r0, r7
	ldrb	r7, [r5, #3]
	ldrb	r2, [r5, #4]
	lsls	r0, r0, r7
	ldrb	r7, [r4, #31]
	lsls	r7, r7, r2
	mov	r2, ip
	orrs	r0, r7
	orrs	r0, r2
	movs	r2, r3
	adds	r3, r4, r3
	ldrb	r7, [r5, #5]
	adds	r3, r3, #33
	ldrb	r3, [r3]
	ldrb	r5, [r5, #6]
	lsls	r2, r2, r7
	lsls	r3, r3, r5
	orrs	r0, r2
	orrs	r0, r3
	mov	r3, r10
	str	r0, [sp, #8]
	cmp	r3, #1
	bne	.L40
	ldrb	r3, [r4, #26]
	lsls	r3, r3, #18
	orrs	r3, r0
	str	r3, [sp, #8]
.L40:
	mov	r3, r9
	ldr	r2, [sp]
	ldrb	r2, [r3, r2]
	cmp	r2, #0
	beq	.L51
	movs	r3, #0
	add	r0, sp, #8
.L42:
	ldr	r5, [r1]
	adds	r7, r5, #1
	str	r7, [r1]
	adds	r3, r3, #1
	ldrb	r7, [r0]
	lsls	r3, r3, #24
	strb	r7, [r5]
	lsrs	r3, r3, #24
	adds	r0, r0, #1
	cmp	r3, r2
	bne	.L42
	adds	r5, r3, r6
	lsls	r5, r5, #16
	lsrs	r5, r5, #16
.L41:
	cmp	r6, #0
	beq	.L43
	movs	r3, #32
	ldrb	r3, [r4, r3]
	lsls	r3, r3, #2
	adds	r3, r4, r3
	ldr	r3, [r3, #4]
	str	r3, [sp, #12]
	mov	r3, r8
	ldr	r3, [r3, #4]
	mov	r2, ip
	ldr	r3, [r3, #4]
	add	r0, sp, #12
	bl	.L67
.L43:
	ldrh	r2, [r4]
	ldr	r3, .L65+4
	cmp	r2, r3
	beq	.L63
.L45:
	mov	r3, r8
	ldr	r2, [r3]
	ldrb	r3, [r2]
	cmp	r3, #1
	beq	.L60
	movs	r1, #1
	ldr	r0, [sp, #4]
	lsls	r1, r1, r0
	ldrb	r3, [r2, #14]
	orrs	r3, r1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
.L60:
	movs	r0, r5
	strb	r3, [r2, #14]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L62:
	ldr	r2, [r4, #20]
	ldrh	r6, [r4, #46]
	cmp	r2, r6
	bcc	.L39
.L58:
	mov	ip, r6
	b	.L34
.L63:
	movs	r2, #32
	ldrb	r3, [r4, r2]
	adds	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	cmp	r3, #4
	beq	.L46
	strb	r3, [r4, r2]
	b	.L45
.L61:
	ldr	r5, [r4, #40]
	ldr	r2, [r4, #48]
	movs	r0, #32
	movs	r6, #32
	adds	r5, r5, r2
	b	.L36
.L37:
	adds	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r4, r0]
	cmp	r3, #4
	beq	.L64
.L36:
	lsls	r2, r3, #2
	adds	r2, r4, r2
	ldr	r2, [r2, #4]
	cmp	r2, r5
	bcs	.L37
	ldrh	r6, [r4, #46]
	adds	r0, r2, r6
	cmp	r5, r0
	bcs	.L58
	subs	r5, r5, r2
	lsls	r5, r5, #16
	lsrs	r6, r5, #16
	mov	ip, r6
	b	.L34
.L64:
	movs	r3, #0
	strb	r3, [r4, r6]
	b	.L36
.L39:
	lsls	r6, r2, #16
	mov	ip, r2
	lsrs	r6, r6, #16
	b	.L34
.L46:
	movs	r3, #0
	strb	r3, [r4, r2]
	b	.L45
.L51:
	movs	r5, r6
	b	.L41
.L66:
	.align	2
.L65:
	.word	.LANCHOR0
	.word	32802
	.word	.LANCHOR1
	.size	rfu_STC_NI_constructLLSF, .-rfu_STC_NI_constructLLSF
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_removeLinkData, %function
rfu_STC_removeLinkData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #1
	push	{r4, r5, r6, r7, lr}
	movs	r5, r0
	movs	r4, #0
	lsls	r3, r3, r0
	ldr	r6, .L84
	ldr	r2, [r6, #8]
	adds	r2, r2, r5
	strb	r4, [r2, #14]
	ldr	r7, [r6]
	lsls	r0, r3, #24
	ldrb	r2, [r7, #2]
	lsrs	r0, r0, #24
	sub	sp, sp, #12
	tst	r0, r2
	beq	.L69
	ldrb	r4, [r7, #1]
	cmp	r4, #0
	bne	.L81
.L69:
	mvns	r4, r3
	movs	r3, r2
	ldrb	r2, [r7, #3]
	lsls	r4, r4, #24
	orrs	r0, r2
	lsrs	r4, r4, #24
	ldrb	r2, [r7]
	ands	r3, r4
	strb	r3, [r7, #2]
	strb	r0, [r7, #3]
	orrs	r3, r2
	beq	.L82
.L70:
	cmp	r1, #0
	bne	.L83
.L68:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L81:
	subs	r4, r4, #1
	strb	r4, [r7, #1]
	b	.L69
.L83:
	mov	r3, sp
	adds	r0, r3, #6
	movs	r3, #0
	strh	r3, [r0]
	lsls	r3, r5, #4
	subs	r3, r3, r5
	lsls	r3, r3, #1
	adds	r3, r3, #20
	ldr	r2, .L84+4
	adds	r1, r7, r3
	bl	CpuSet
	ldr	r3, [r6]
	ldrb	r2, [r3, #3]
	ands	r2, r4
	strb	r2, [r3, #3]
	ldrb	r2, [r3, #7]
	ands	r2, r4
	strb	r2, [r3, #7]
	movs	r2, #0
	adds	r3, r3, r5
	strb	r2, [r3, #10]
	b	.L68
.L82:
	adds	r3, r3, #255
	strb	r3, [r7]
	b	.L70
.L85:
	.align	2
.L84:
	.word	.LANCHOR0
	.word	16777231
	.size	rfu_STC_removeLinkData, .-rfu_STC_removeLinkData
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_NI_receive_Receiver, %function
rfu_STC_NI_receive_Receiver:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	mov	lr, fp
	ldr	r3, .L120
	mov	r8, r3
	push	{r5, r6, r7, lr}
	lsls	r3, r0, #2
	add	r3, r3, r8
	sub	sp, sp, #20
	str	r2, [sp, #12]
	ldr	r4, [r3, #12]
	ldrb	r7, [r1, #4]
	ldrh	r3, [r4, #52]
	mov	r9, r3
	adds	r3, r4, r7
	adds	r3, r3, #85
	ldrb	r3, [r3]
	mov	r10, r3
	ldrb	r3, [r1, #2]
	movs	r6, r0
	movs	r5, r1
	cmp	r3, #3
	beq	.L113
	cmp	r3, #2
	beq	.L114
	cmp	r3, #1
	bne	.LCB469
	b	.L99	@long jump
.LCB469:
.L112:
	movs	r3, #76
	ldrh	r3, [r4, r3]
.L89:
	cmp	r3, #0
	bne	.L86
	movs	r2, r4
	movs	r3, r4
	adds	r2, r2, #84
	strb	r7, [r2]
	ldrh	r2, [r4, #52]
	adds	r3, r3, #52
	cmp	r2, r9
	bne	.LCB484
	b	.L115	@long jump
.LCB484:
.L109:
	movs	r0, #1
	movs	r5, #0
	mov	r1, r8
	lsls	r0, r0, r6
	ldr	r3, .L120+4
	ldr	r7, [r1, #8]
	ldrh	r2, [r3]
	strh	r5, [r3]
	ldrb	r1, [r7, #2]
	orrs	r1, r0
	strb	r1, [r7, #2]
	strh	r5, [r4, #54]
	strh	r2, [r3]
.L86:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L114:
	ldr	r3, .L120+8
	cmp	r9, r3
	beq	.L116
	ldr	r3, .L120+12
	cmp	r9, r3
	bne	.L112
	mov	r3, r10
.L98:
	movs	r2, #3
	ldrb	r1, [r5, #5]
	adds	r3, r3, #1
	ands	r3, r2
	cmp	r1, r3
	bne	.L112
	mov	r3, r8
	lsls	r1, r7, #2
	ldr	r3, [r3, #4]
	adds	r1, r1, #56
	ldrh	r2, [r5, #6]
	ldr	r3, [r3, #4]
	adds	r1, r4, r1
	add	r0, sp, #12
	bl	.L67
	ldrh	r2, [r4, #52]
	ldr	r3, .L120+12
	ldrb	r7, [r5, #4]
	cmp	r2, r3
	bne	.LCB546
	b	.L107	@long jump
.LCB546:
.L108:
	ldrh	r2, [r5, #6]
	ldr	r3, [r4, #72]
	subs	r3, r3, r2
	str	r3, [r4, #72]
	adds	r3, r4, r7
	ldrb	r2, [r5, #5]
	adds	r3, r3, #85
	strb	r2, [r3]
	b	.L112
.L113:
	movs	r2, #1
	mov	r3, r8
	lsls	r2, r2, r0
	ldr	r1, [r3, #8]
	ldrb	r3, [r1, #1]
	orrs	r3, r2
	strb	r3, [r1, #1]
	movs	r3, #76
	ldr	r2, .L120+12
	ldrh	r3, [r4, r3]
	cmp	r9, r2
	bne	.L89
	movs	r2, #84
	movs	r1, #0
	strh	r1, [r4, r2]
	ldr	r2, .L120+16
	strh	r2, [r4, #52]
	b	.L89
.L116:
	ldr	r3, [r4, #72]
	cmp	r3, #0
	bne	.L112
	ldr	r3, [r4, #100]
	str	r3, [sp, #4]
	movs	r3, r4
	adds	r3, r3, #97
	ldrb	r3, [r3]
	cmp	r3, #1
	bne	.LCB591
	b	.L117	@long jump
.LCB591:
	ldr	r3, [r4, #108]
	ldr	r2, [sp, #4]
	cmp	r3, r2
	bcs	.LCB595
	b	.L118	@long jump
.LCB595:
	ldr	r3, [r4, #104]
	mov	fp, r3
.L94:
	mov	r3, fp
	str	r3, [r4, #56]
	movs	r3, #98
	movs	r0, r4
	ldrh	r2, [r4, r3]
	movs	r1, #0
	str	r2, [sp, #8]
	adds	r0, r0, #85
	movs	r2, #4
	bl	memset
	ldr	r2, [sp, #8]
	movs	r3, r2
	mov	ip, r2
	add	r3, r3, fp
	str	r3, [r4, #60]
	lsls	r3, r2, #1
	add	r3, r3, fp
	str	r3, [r4, #64]
	add	r3, r3, ip
	str	r3, [r4, #68]
	ldr	r3, [sp, #4]
	str	r3, [r4, #72]
	ldr	r3, .L120+20
	strh	r3, [r4, #52]
	movs	r3, #0
	b	.L98
.L115:
	adds	r3, r3, r7
	adds	r3, r3, #33
	ldrb	r3, [r3]
	cmp	r3, r10
	beq	.LCB635
	b	.L109	@long jump
.LCB635:
	ldrb	r3, [r5, #5]
	cmp	r3, r10
	beq	.LCB638
	b	.L86	@long jump
.LCB638:
	b	.L109
.L99:
	ldr	r2, .L120+8
	mov	r3, r10
	cmp	r9, r2
	beq	.L98
	mov	r3, r8
	ldr	r2, [r3]
	ldrb	r3, [r2]
	cmp	r3, #1
	beq	.L119
	movs	r3, r0
	movs	r7, #2
	movs	r1, #2
	adds	r3, r3, #16
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	adds	r3, r2, r3
.L101:
	mov	r2, r9
	cmp	r2, #0
	beq	.LCB663
	b	.L86	@long jump
.LCB663:
	adds	r2, r2, #1
	mov	fp, r2
	lsls	r2, r2, r6
	ldrb	r0, [r3]
	lsls	r2, r2, #24
	lsrs	r2, r2, #24
	cmp	r0, r1
	bcs	.L104
	movs	r3, #73
	ldr	r1, .L120+24
	strh	r3, [r4, #52]
	adds	r3, r3, #3
	strh	r1, [r4, r3]
	mov	r3, r8
	ldr	r1, [r3, #8]
	ldrb	r3, [r1, #4]
	orrs	r3, r2
	strb	r3, [r1, #4]
	b	.L86
.L119:
	movs	r3, r2
	movs	r7, #3
	movs	r1, #3
	adds	r3, r3, #15
	b	.L101
.L107:
	movs	r2, #98
	ldrh	r2, [r4, r2]
	lsls	r3, r7, #2
	adds	r3, r4, r3
	lsls	r1, r2, #1
	adds	r1, r1, r2
	ldr	r2, [r3, #56]
	adds	r2, r2, r1
	str	r2, [r3, #56]
	b	.L108
.L104:
	mov	r0, r9
	movs	r1, #76
	strh	r0, [r4, r1]
	ldrb	r1, [r3]
	subs	r1, r1, r7
	strb	r1, [r3]
	movs	r3, r4
	adds	r3, r3, #97
	str	r3, [r4, #56]
	movs	r3, #7
	str	r3, [r4, #72]
	movs	r3, r4
	mov	r1, fp
	adds	r3, r3, #52
	strb	r1, [r3, #31]
	movs	r1, #98
	strh	r0, [r4, r1]
	ldr	r1, .L120+28
	strb	r2, [r3, #26]
	strh	r1, [r4, #52]
	mov	r1, r8
	ldr	r1, [r1]
	ldrb	r0, [r1, #5]
	orrs	r2, r0
	strb	r2, [r1, #5]
	ldrb	r7, [r5, #4]
	adds	r3, r3, r7
	adds	r3, r3, #33
	ldrb	r3, [r3]
	b	.L98
.L117:
	mov	r2, r8
	ldr	r2, [r2]
	mov	fp, r2
	lsls	r3, r0, #4
	subs	r3, r3, r0
	lsls	r3, r3, #1
	adds	r3, r3, #24
	add	fp, fp, r3
	b	.L94
.L118:
	movs	r2, #1
	mov	r3, r8
	lsls	r2, r2, r0
	ldr	r1, [r3, #8]
	ldrb	r3, [r1, #4]
	orrs	r3, r2
	strb	r3, [r1, #4]
	mov	r3, r8
	ldr	r3, [r3]
	ldrb	r0, [r3, #5]
	bics	r0, r2
	movs	r2, #76
	strb	r0, [r3, #5]
	ldr	r0, .L120+32
	strh	r0, [r4, r2]
	subs	r2, r2, #5
	strh	r2, [r4, #52]
	ldrb	r2, [r1]
	cmp	r2, #127
	bhi	.L96
	ldrb	r2, [r3, #15]
	adds	r2, r2, #3
	strb	r2, [r3, #15]
	b	.L86
.L96:
	adds	r3, r3, r6
	ldrb	r2, [r3, #16]
	adds	r2, r2, #2
	strb	r2, [r3, #16]
	b	.L86
.L121:
	.align	2
.L120:
	.word	.LANCHOR0
	.word	67109384
	.word	32833
	.word	32834
	.word	-32701
	.word	-32702
	.word	1794
	.word	-32703
	.word	1793
	.size	rfu_STC_NI_receive_Receiver, .-rfu_STC_NI_receive_Receiver
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_REQ_callback, %function
rfu_STC_REQ_callback:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r4, r1
	movs	r5, r0
	ldr	r0, .L128
	bl	STWI_set_Callback_M
	ldr	r2, .L128+4
	ldr	r3, [r2, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L122
	ldr	r3, [r2, #4]
	movs	r1, r4
	movs	r0, r5
	ldr	r3, [r3]
	bl	.L67
.L122:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L129:
	.align	2
.L128:
	.word	rfu_CB_defaultCallback
	.word	.LANCHOR0
	.size	rfu_STC_REQ_callback, .-rfu_STC_REQ_callback
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_NI_receive_Sender.isra.0, %function
rfu_STC_NI_receive_Sender.isra.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r8
	mov	r7, r9
	mov	lr, r10
	ldr	r5, .L158
	push	{r6, r7, lr}
	lsls	r0, r0, #2
	adds	r0, r5, r0
	ldr	r6, [r0, #12]
	ldrb	r7, [r2, #4]
	ldrh	r3, [r6]
	mov	ip, r3
	adds	r3, r6, r7
	movs	r4, r1
	movs	r1, r3
	adds	r1, r1, #33
	ldrb	r1, [r1]
	ldrb	r0, [r2, #2]
	mov	r8, r1
	ldrb	r1, [r3, #27]
	cmp	r0, #2
	beq	.L152
	cmp	r0, #1
	bne	.L134
	ldr	r0, .L158+4
	cmp	ip, r0
	beq	.L132
.L133:
	movs	r0, r1
	ldrb	r2, [r6, #26]
	ands	r0, r2
	cmp	r2, r0
	beq	.L153
.L135:
	asrs	r1, r1, r4
	lsls	r1, r1, #31
	bpl	.L130
.L139:
	movs	r0, #16
	movs	r6, #0
	lsls	r0, r0, r4
	ldr	r2, .L158+8
	ldr	r7, [r5, #8]
	ldrh	r1, [r2]
	strh	r6, [r2]
	ldrb	r3, [r7, #2]
	orrs	r3, r0
	strb	r3, [r7, #2]
	lsls	r3, r4, #2
	adds	r3, r5, r3
	ldr	r3, [r3, #12]
	strh	r6, [r3, #2]
	strh	r1, [r2]
.L130:
	@ sp needed
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L134:
	cmp	r0, #3
	bne	.L133
	ldr	r0, .L158+12
	add	r0, r0, ip
	cmp	r0, #0
	bne	.L133
.L132:
	ldrb	r2, [r2, #5]
	cmp	r2, r8
	bne	.L133
.L155:
	movs	r2, #1
	lsls	r2, r2, r4
	orrs	r2, r1
	lsls	r2, r2, #24
	lsrs	r1, r2, #24
	movs	r0, r1
	strb	r1, [r3, #27]
	ldrb	r2, [r6, #26]
	ands	r0, r2
	cmp	r2, r0
	bne	.L135
.L153:
	mov	r2, r8
	adds	r1, r2, #1
	movs	r2, #3
	ands	r2, r1
	movs	r1, r3
	adds	r1, r1, #33
	strb	r2, [r1]
	movs	r1, #0
	strb	r1, [r3, #27]
	ldr	r3, .L158+16
	add	r3, r3, ip
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	cmp	r3, #1
	bls	.L154
	ldr	r3, .L158+20
	cmp	ip, r3
	bne	.L141
	ldr	r3, .L158+24
	strh	r3, [r6]
	b	.L139
.L152:
	ldr	r0, .L158+28
	cmp	ip, r0
	bne	.L133
	ldrb	r2, [r2, #5]
	cmp	r2, r8
	bne	.L133
	b	.L155
.L154:
	lsls	r7, r7, #2
	adds	r7, r6, r7
	ldr	r3, [r7, #4]
	mov	r10, r3
	ldrh	r3, [r6, #46]
	mov	r9, r3
	mov	r0, r9
	ldr	r3, [r6, #20]
	subs	r3, r3, r0
	ldr	r0, .L158+4
	cmp	ip, r0
	beq	.L156
	mov	r0, r9
	lsls	r0, r0, #2
	add	r0, r0, r10
	str	r0, [r7, #4]
	str	r3, [r6, #20]
	cmp	r3, #0
	ble	.L157
.L141:
	cmp	r8, r2
	bne	.L139
	b	.L130
.L156:
	mov	r0, r10
	add	r0, r0, r9
	str	r0, [r7, #4]
	str	r3, [r6, #20]
	cmp	r3, #0
	bgt	.L141
	movs	r3, #32
	movs	r0, r6
	strb	r1, [r6, r3]
	movs	r2, #4
	movs	r1, #1
	adds	r0, r0, #33
	ldr	r7, [r6, #40]
	bl	memset
	mov	r3, r9
	adds	r3, r7, r3
	str	r3, [r6, #8]
	mov	r3, r9
	lsls	r3, r3, #1
	str	r7, [r6, #4]
	adds	r7, r7, r3
	ldr	r3, [r6, #48]
	str	r3, [r6, #20]
	ldr	r3, .L158+32
	str	r7, [r6, #12]
	add	r7, r7, r9
	str	r7, [r6, #16]
	strh	r3, [r6]
	b	.L139
.L157:
	ldr	r3, .L158+36
	strh	r1, [r6, #32]
	str	r1, [r6, #20]
	strh	r3, [r6]
	b	.L139
.L159:
	.align	2
.L158:
	.word	.LANCHOR0
	.word	32801
	.word	67109384
	.word	-32803
	.word	32735
	.word	32803
	.word	-32736
	.word	32802
	.word	-32734
	.word	-32733
	.size	rfu_STC_NI_receive_Sender.isra.0, .-rfu_STC_NI_receive_Sender.isra.0
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_UNI_receive.isra.0, %function
rfu_STC_UNI_receive.isra.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r6, .L173
	lsls	r3, r0, #2
	adds	r3, r6, r3
	ldr	r4, [r3, #28]
	movs	r3, #0
	strh	r3, [r4, #14]
	ldr	r3, [r4, #24]
	sub	sp, sp, #16
	movs	r5, r0
	str	r2, [sp, #4]
	cmp	r3, r1
	bcs	.L161
	ldr	r3, .L173+4
	str	r3, [r4, #12]
.L162:
	movs	r2, #16
	lsls	r2, r2, r5
	ldr	r1, [r6, #8]
	ldrb	r3, [r1, #4]
	orrs	r3, r2
	strb	r3, [r1, #4]
.L160:
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L161:
	ldrb	r2, [r4, #19]
	ldrb	r3, [r4, #18]
	cmp	r2, #0
	beq	.L163
	cmp	r3, #0
	bne	.L172
.L164:
	ldr	r3, .L173+8
	strh	r3, [r4, #12]
	ldr	r3, [r4, #20]
	str	r3, [sp, #12]
	ldr	r3, [r6, #4]
	movs	r2, r1
	strh	r1, [r4, #16]
	ldr	r3, [r3, #4]
	add	r1, sp, #12
	add	r0, sp, #4
	bl	.L67
	movs	r3, #1
	strb	r3, [r4, #18]
	movs	r3, #0
	strh	r3, [r4, #12]
	ldrh	r3, [r4, #14]
	cmp	r3, #0
	beq	.L160
	b	.L162
.L163:
	cmp	r3, #0
	beq	.L164
	movs	r3, #225
	lsls	r3, r3, #3
	strh	r3, [r4, #14]
	b	.L164
.L172:
	ldr	r3, .L173+12
	strh	r3, [r4, #14]
	b	.L162
.L174:
	.align	2
.L173:
	.word	.LANCHOR0
	.word	117506121
	.word	-32702
	.word	1801
	.size	rfu_STC_UNI_receive.isra.0, .-rfu_STC_UNI_receive.isra.0
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_analyzeLLSF, %function
rfu_STC_analyzeLLSF:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	mov	lr, fp
	push	{r5, r6, r7, lr}
	movs	r6, #1
	ldr	r7, .L256
	ldr	r3, [r7]
	mov	r10, r3
	ldrb	r3, [r3]
	sub	sp, sp, #28
	str	r0, [sp, #8]
	bics	r6, r3
	movs	r0, r2
	ldr	r2, .L256+4
	lsls	r6, r6, #4
	ldrb	r4, [r2, r6]
	movs	r5, r1
	mov	r9, r3
	cmp	r4, r0
	bls	.LCB1185
	b	.L176	@long jump
.LCB1185:
	cmp	r4, #0
	bne	.LCB1187
	b	.L197	@long jump
.LCB1187:
	movs	r1, #0
	movs	r3, #0
	mov	ip, r2
.L178:
	ldrb	r0, [r5, r1]
	lsls	r2, r1, #3
	lsls	r0, r0, r2
	adds	r1, r1, #1
	orrs	r3, r0
	lsls	r0, r1, #24
	lsrs	r0, r0, #24
	cmp	r4, r0
	bhi	.L178
	mov	r2, ip
	lsls	r1, r3, #16
	lsrs	r1, r1, #16
	str	r1, [sp, #4]
	adds	r5, r5, r4
.L177:
	movs	r0, r3
	adds	r2, r2, r6
	ldrb	r1, [r2, #1]
	lsrs	r0, r0, r1
	movs	r1, r0
	movs	r6, r3
	ldrb	r0, [r2, #7]
	ands	r0, r1
	add	r1, sp, #16
	strb	r0, [r1]
	ldrb	r1, [r2, #2]
	lsrs	r6, r6, r1
	ldrb	r1, [r2, #8]
	ands	r1, r6
	movs	r6, r1
	str	r1, [sp, #12]
	add	r1, sp, #16
	strb	r6, [r1, #1]
	movs	r1, r3
	ldrb	r6, [r2, #3]
	lsrs	r1, r1, r6
	movs	r6, r1
	ldrb	r1, [r2, #9]
	ands	r1, r6
	mov	ip, r1
	mov	r6, ip
	add	r1, sp, #16
	strb	r6, [r1, #2]
	movs	r1, r3
	ldrb	r6, [r2, #4]
	lsrs	r1, r1, r6
	movs	r6, r1
	ldrb	r1, [r2, #10]
	ands	r1, r6
	mov	r8, r1
	mov	r6, r8
	add	r1, sp, #16
	strb	r6, [r1, #3]
	movs	r1, r3
	ldrb	r6, [r2, #5]
	lsrs	r1, r1, r6
	ldrb	r6, [r2, #11]
	ands	r6, r1
	add	r1, sp, #16
	strb	r6, [r1, #4]
	ldrb	r6, [r2, #6]
	lsrs	r3, r3, r6
	ldrb	r6, [r2, #12]
	ands	r6, r3
	strb	r6, [r1, #5]
	ldr	r3, [sp, #4]
	ldrh	r6, [r2, #14]
	ands	r6, r3
	strh	r6, [r1, #6]
	cmp	r0, #0
	bne	.L179
	mov	r3, r10
	mov	r2, r9
	ldrb	r3, [r3, #2]
	cmp	r2, #1
	beq	.L253
	movs	r2, r3
	ldr	r1, [sp, #12]
	ands	r2, r1
	mov	r9, r2
	tst	r3, r1
	beq	.L179
	mov	r3, ip
	cmp	r3, #4
	bne	.LCB1291
	b	.L200	@long jump
.LCB1291:
	mov	r3, r8
	cmp	r3, #0
	bne	.LCB1294
	b	.L201	@long jump
.LCB1294:
	movs	r3, #1
	tst	r3, r2
	beq	.L189
	mov	r2, r10
	ldrb	r2, [r2, #4]
	tst	r3, r2
	beq	.L189
	movs	r1, #0
	movs	r0, #0
	add	r2, sp, #16
	bl	rfu_STC_NI_receive_Sender.isra.0
.L189:
	movs	r3, #2
	mov	r2, r9
	tst	r3, r2
	beq	.L190
	ldr	r2, [r7]
	ldrb	r2, [r2, #4]
	tst	r3, r2
	beq	.L190
	movs	r1, #1
	movs	r0, #1
	add	r2, sp, #16
	bl	rfu_STC_NI_receive_Sender.isra.0
.L190:
	movs	r3, #4
	mov	r2, r9
	tst	r3, r2
	beq	.L191
	ldr	r2, [r7]
	ldrb	r2, [r2, #4]
	tst	r3, r2
	beq	.L191
	movs	r1, #2
	movs	r0, #2
	add	r2, sp, #16
	bl	rfu_STC_NI_receive_Sender.isra.0
.L191:
	movs	r3, #8
	mov	r2, r9
	tst	r3, r2
	beq	.L179
	ldr	r2, [r7]
	ldrb	r2, [r2, #4]
	tst	r3, r2
	beq	.L179
	movs	r1, #3
	movs	r0, #3
	add	r2, sp, #16
	bl	rfu_STC_NI_receive_Sender.isra.0
.L179:
	adds	r4, r4, r6
	lsls	r0, r4, #16
	lsrs	r0, r0, #16
.L176:
	add	sp, sp, #28
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L253:
	ldr	r2, [sp, #8]
	asrs	r3, r3, r2
	mov	r2, r9
	tst	r2, r3
	beq	.L179
	mov	r3, ip
	cmp	r3, #4
	beq	.L254
	mov	r3, r8
	cmp	r3, #0
	beq	.L255
	mov	r3, r9
	ldr	r2, [sp, #8]
	lsls	r3, r3, r2
	ldr	r2, [r7, #12]
	ldrb	r2, [r2, #26]
	tst	r3, r2
	beq	.L183
	mov	r2, r10
	ldrb	r2, [r2, #4]
	tst	r3, r2
	bne	.L184
.L183:
	ldr	r2, [r7, #16]
	ldrb	r2, [r2, #26]
	tst	r3, r2
	beq	.L185
	mov	r2, r10
	ldrb	r2, [r2, #4]
	tst	r3, r2
	bne	.L198
.L185:
	ldr	r2, [r7, #20]
	ldrb	r2, [r2, #26]
	tst	r3, r2
	beq	.L186
	mov	r2, r10
	ldrb	r2, [r2, #4]
	tst	r3, r2
	beq	.L179
	movs	r0, #2
.L184:
	ldr	r1, [sp, #8]
	add	r2, sp, #16
	bl	rfu_STC_NI_receive_Sender.isra.0
	b	.L179
.L197:
	movs	r3, #0
	str	r3, [sp, #4]
	b	.L177
.L254:
	movs	r2, r5
	movs	r1, r6
	ldr	r0, [sp, #8]
	bl	rfu_STC_UNI_receive.isra.0
	b	.L179
.L201:
	movs	r3, #1
	mov	r8, r3
	movs	r3, r5
	movs	r7, #0
	movs	r5, r2
	mov	r9, r3
.L188:
	movs	r3, r5
	mov	r2, r8
	asrs	r3, r3, r7
	tst	r2, r3
	beq	.L194
	lsls	r0, r7, #24
	mov	r2, r9
	lsrs	r0, r0, #24
	add	r1, sp, #16
	bl	rfu_STC_NI_receive_Receiver
.L194:
	adds	r7, r7, #1
	cmp	r7, #4
	bne	.L188
	b	.L179
.L200:
	movs	r3, #1
	mov	r8, r3
	movs	r3, r5
	movs	r7, #0
	movs	r5, r2
	mov	r9, r3
.L187:
	movs	r3, r5
	mov	r2, r8
	asrs	r3, r3, r7
	tst	r2, r3
	beq	.L195
	lsls	r0, r7, #24
	mov	r2, r9
	movs	r1, r6
	lsrs	r0, r0, #24
	bl	rfu_STC_UNI_receive.isra.0
.L195:
	adds	r7, r7, #1
	cmp	r7, #4
	bne	.L187
	b	.L179
.L255:
	movs	r2, r5
	ldr	r0, [sp, #8]
	add	r1, sp, #16
	bl	rfu_STC_NI_receive_Receiver
	b	.L179
.L186:
	ldr	r2, [r7, #24]
	ldrb	r2, [r2, #26]
	tst	r3, r2
	bne	.LCB1537
	b	.L179	@long jump
.LCB1537:
	mov	r2, r10
	ldrb	r2, [r2, #4]
	movs	r0, #3
	tst	r3, r2
	bne	.LCB1543
	b	.L179	@long jump
.LCB1543:
	b	.L184
.L198:
	mov	r0, r9
	b	.L184
.L257:
	.align	2
.L256:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.size	rfu_STC_analyzeLLSF, .-rfu_STC_analyzeLLSF
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_STC_clearAPIVariables, %function
rfu_STC_clearAPIVariables:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	push	{r5, r6, r7, lr}
	ldr	r4, .L261
	ldrh	r3, [r4]
	sub	sp, sp, #20
	movs	r5, #0
	str	r3, [sp]
	ldr	r3, .L261+4
	mov	r8, r3
	strh	r5, [r4]
	ldr	r1, [r3, #8]
	add	r3, sp, #8
	movs	r0, r3
	ldr	r2, .L261+8
	ldrb	r6, [r1]
	strh	r5, [r3]
	bl	CpuSet
	mov	r3, r8
	ldr	r2, [r3, #8]
	movs	r3, #8
	ands	r3, r6
	strb	r3, [r2]
	add	r3, sp, #8
	adds	r0, r3, #2
	mov	r3, r8
	ldr	r2, .L261+12
	ldr	r1, [r3]
	strh	r5, [r0]
	bl	CpuSet
	mov	r3, r8
	movs	r2, #4
	ldr	r3, [r3]
	strb	r2, [r3, #9]
	mov	r2, r8
	movs	r1, #0
	ldr	r2, [r2, #8]
	strb	r1, [r2, #6]
	movs	r2, #255
	strb	r2, [r3]
	ldrh	r3, [r4]
	str	r3, [sp, #4]
	movs	r3, #12
	add	r3, r3, r8
	mov	r10, r3
	movs	r3, #28
	strh	r5, [r4]
	movs	r4, #0
	add	r3, r3, r8
	mov	r9, r3
	add	r3, sp, #8
	add	r7, sp, #12
	adds	r6, r3, #6
.L259:
	movs	r3, #0
	mov	fp, r3
	mov	r3, r10
	ldmia	r3!, {r1}
	movs	r0, r7
	ldr	r2, .L261+16
	mov	r10, r3
	strh	r5, [r7]
	bl	CpuSet
	mov	r3, r9
	ldmia	r3!, {r1}
	ldr	r2, .L261+20
	movs	r0, r6
	mov	r9, r3
	strh	r5, [r6]
	bl	CpuSet
	mov	r3, r8
	movs	r1, #16
	ldr	r3, [r3]
	adds	r2, r3, r4
	adds	r4, r4, #1
	strb	r1, [r2, #16]
	cmp	r4, #4
	bne	.L259
	movs	r2, #87
	strb	r2, [r3, #15]
	mov	r2, fp
	strh	r5, [r3, #4]
	strb	r2, [r3, #6]
	mov	r3, r8
	ldr	r3, [r3, #8]
	ldr	r1, [sp, #4]
	strb	r2, [r3, #2]
	ldr	r2, .L261
	strh	r1, [r2]
	mov	r1, fp
	strh	r5, [r3, #18]
	strb	r1, [r3, #9]
	str	r5, [r3, #20]
	strh	r5, [r3, #24]
	ldr	r3, [sp]
	strh	r3, [r2]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L262:
	.align	2
.L261:
	.word	67109384
	.word	.LANCHOR0
	.word	16777236
	.word	16777301
	.word	16777268
	.word	16777226
	.size	rfu_STC_clearAPIVariables, .-rfu_STC_clearAPIVariables
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_sendData2, %function
rfu_CB_sendData2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r4, r1
	ldr	r0, .L269
	bl	STWI_set_Callback_M
	ldr	r2, .L269+4
	ldr	r3, [r2, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L263
	ldr	r3, [r2, #4]
	movs	r1, r4
	movs	r0, #36
	ldr	r3, [r3]
	bl	.L67
.L263:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L270:
	.align	2
.L269:
	.word	rfu_CB_defaultCallback
	.word	.LANCHOR0
	.size	rfu_CB_sendData2, .-rfu_CB_sendData2
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_stopMode, %function
rfu_CB_stopMode:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r5, r0
	subs	r4, r1, #0
	bne	.L272
	movs	r2, #128
	ldr	r3, .L278
	lsls	r2, r2, #6
	strh	r2, [r3]
.L272:
	ldr	r0, .L278+4
	bl	STWI_set_Callback_M
	ldr	r2, .L278+8
	ldr	r3, [r2, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L271
	ldr	r3, [r2, #4]
	movs	r1, r4
	movs	r0, r5
	ldr	r3, [r3]
	bl	.L67
.L271:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L279:
	.align	2
.L278:
	.word	67109160
	.word	rfu_CB_defaultCallback
	.word	.LANCHOR0
	.size	rfu_CB_stopMode, .-rfu_CB_stopMode
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_reset, %function
rfu_CB_reset:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r5, r0
	subs	r4, r1, #0
	beq	.L287
.L281:
	ldr	r0, .L288
	bl	STWI_set_Callback_M
	ldr	r2, .L288+4
	ldr	r3, [r2, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L280
	ldr	r3, [r2, #4]
	movs	r1, r4
	movs	r0, r5
	ldr	r3, [r3]
	bl	.L67
.L280:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L287:
	bl	rfu_STC_clearAPIVariables
	b	.L281
.L289:
	.align	2
.L288:
	.word	rfu_CB_defaultCallback
	.word	.LANCHOR0
	.size	rfu_CB_reset, .-rfu_CB_reset
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_startSearchChild, %function
rfu_CB_startSearchChild:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r6, r0
	subs	r4, r1, #0
	ldr	r5, .L299
	bne	.L291
	movs	r2, #1
	ldr	r3, [r5, #8]
	strb	r2, [r3, #9]
.L291:
	ldr	r0, .L299+4
	bl	STWI_set_Callback_M
	ldr	r3, [r5, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L290
	ldr	r3, [r5, #4]
	movs	r1, r4
	movs	r0, r6
	ldr	r3, [r3]
	bl	.L67
.L290:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L300:
	.align	2
.L299:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.size	rfu_CB_startSearchChild, .-rfu_CB_startSearchChild
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_configGameData, %function
rfu_CB_configGameData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r8
	movs	r6, r1
	mov	r8, r0
	push	{lr}
	cmp	r1, #0
	beq	.L326
	ldr	r7, .L331
.L302:
	ldr	r0, .L331+4
	bl	STWI_set_Callback_M
	ldr	r3, [r7, #8]
	strh	r6, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L301
	ldr	r3, [r7, #4]
	movs	r1, r6
	mov	r0, r8
	ldr	r3, [r3]
	bl	.L67
.L301:
	@ sp needed
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L326:
	movs	r1, #144
	ldr	r3, .L331+8
	ldr	r3, [r3]
	ldr	r7, .L331
	ldr	r2, [r3, #36]
	ldr	r3, [r7]
	ldrb	r0, [r2, #4]
	strh	r0, [r3, r1]
	ldrb	r1, [r2, #5]
	lsls	r1, r1, #8
	orrs	r0, r1
	lsls	r4, r0, #16
	movs	r5, #0
	adds	r1, r2, #6
	asrs	r4, r4, #16
	bmi	.L330
.L303:
	movs	r4, #144
	strh	r0, [r3, r4]
	movs	r0, #143
	strb	r5, [r3, r0]
	movs	r0, r3
	movs	r4, r1
	adds	r0, r0, #146
	orrs	r4, r0
	lsls	r4, r4, #30
	bne	.L304
	adds	r4, r2, #7
	subs	r0, r0, r4
	cmp	r0, #2
	bls	.L304
	ldr	r0, [r1]
	movs	r1, #146
	str	r0, [r3, r1]
	movs	r1, r2
	adds	r1, r1, #10
	ldr	r0, [r1]
	movs	r1, #150
	str	r0, [r3, r1]
	adds	r4, r4, #7
	ldr	r5, [r4]
	movs	r4, #154
	str	r5, [r3, r4]
	ldrb	r1, [r2, #18]
.L305:
	movs	r0, #158
	strb	r1, [r3, r0]
	movs	r1, r3
	movs	r0, r2
	adds	r1, r1, #161
	orrs	r0, r1
	lsls	r0, r0, #30
	bne	.L306
	movs	r0, r2
	adds	r0, r0, #21
	subs	r1, r1, r0
	cmp	r1, #2
	bls	.L306
	movs	r1, #161
	ldr	r0, [r2, #20]
	str	r0, [r3, r1]
	ldr	r1, [r2, #24]
	movs	r2, #165
	str	r1, [r3, r2]
	b	.L302
.L330:
	movs	r4, #128
	lsls	r4, r4, #24
	mov	ip, r4
	lsls	r0, r0, #16
	add	r0, r0, ip
	lsrs	r0, r0, #16
	adds	r5, r5, #1
	b	.L303
.L304:
	movs	r1, #146
	ldrb	r0, [r2, #6]
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #7]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #8]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #9]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #10]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #11]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #12]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #13]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #14]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #15]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #16]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #17]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r1, [r2, #18]
	b	.L305
.L306:
	movs	r1, #161
	ldrb	r0, [r2, #20]
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #21]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #22]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #23]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #24]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #25]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r0, [r2, #26]
	adds	r1, r1, #1
	strb	r0, [r3, r1]
	ldrb	r1, [r2, #27]
	movs	r2, #168
	strb	r1, [r3, r2]
	b	.L302
.L332:
	.align	2
.L331:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	gSTWIStatus
	.size	rfu_CB_configGameData, .-rfu_CB_configGameData
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_startSearchParent, %function
rfu_CB_startSearchParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	push	{r5, r6, r7, lr}
	sub	sp, sp, #20
	subs	r4, r1, #0
	str	r0, [sp]
	beq	.L342
	ldr	r3, .L344
	mov	r8, r3
.L334:
	ldr	r0, .L344+4
	bl	STWI_set_Callback_M
	mov	r3, r8
	ldr	r3, [r3, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L333
	mov	r3, r8
	ldr	r3, [r3, #4]
	movs	r1, r4
	ldr	r3, [r3]
	ldr	r0, [sp]
	bl	.L67
.L333:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L342:
	ldr	r3, .L344+8
	ldrh	r2, [r3]
	str	r2, [sp, #4]
	strh	r1, [r3]
	ldr	r3, .L344
	mov	r8, r3
	movs	r3, #12
	add	r3, r3, r8
	mov	fp, r3
	movs	r3, #28
	add	r3, r3, r8
	mov	r10, r3
	add	r3, sp, #8
	adds	r6, r3, #6
	movs	r3, #0
	mov	r4, fp
	movs	r5, #0
	mov	r9, r3
	mov	fp, r1
	add	r7, sp, #12
.L335:
	mov	r3, r9
	movs	r0, r7
	ldmia	r4!, {r1}
	ldr	r2, .L344+12
	strh	r3, [r7]
	bl	CpuSet
	mov	r3, r9
	strh	r3, [r6]
	mov	r3, r10
	ldmia	r3!, {r1}
	ldr	r2, .L344+16
	movs	r0, r6
	mov	r10, r3
	bl	CpuSet
	mov	r3, r8
	movs	r1, #16
	ldr	r3, [r3]
	adds	r2, r3, r5
	adds	r5, r5, #1
	strb	r1, [r2, #16]
	cmp	r5, #4
	bne	.L335
	movs	r2, #87
	strb	r2, [r3, #15]
	mov	r2, r9
	strh	r2, [r3, #4]
	mov	r2, r8
	movs	r1, #0
	ldr	r2, [r2, #8]
	strb	r1, [r3, #6]
	ldr	r0, [sp, #4]
	strb	r1, [r2, #2]
	ldr	r2, .L344+8
	strh	r0, [r2]
	mov	r2, r9
	mov	r4, fp
	strh	r2, [r3, #10]
	strh	r2, [r3, #12]
	strb	r1, [r3, #1]
	strh	r2, [r3, #2]
	strb	r1, [r3, #7]
	b	.L334
.L345:
	.align	2
.L344:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	67109384
	.word	16777268
	.word	16777226
	.size	rfu_CB_startSearchParent, .-rfu_CB_startSearchParent
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_CHILD_pollConnectRecovery, %function
rfu_CB_CHILD_pollConnectRecovery:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	lr, r9
	mov	r7, r8
	movs	r6, r0
	movs	r4, r1
	push	{r7, lr}
	ldr	r5, .L375
	cmp	r1, #0
	bne	.L347
	movs	r3, #220
	ldr	r2, [r5, #4]
	ldr	r3, [r2, r3]
	ldrb	r3, [r3, #4]
	cmp	r3, #0
	beq	.L374
.L347:
	ldr	r0, .L375+4
	bl	STWI_set_Callback_M
	ldr	r3, [r5, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L346
	ldr	r3, [r5, #4]
	movs	r1, r4
	movs	r0, r6
	ldr	r3, [r3]
	bl	.L67
.L346:
	@ sp needed
	pop	{r6, r7}
	mov	r9, r7
	mov	r8, r6
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L374:
	ldr	r2, [r5, #8]
	ldrb	r1, [r2, #5]
	cmp	r1, #0
	beq	.L347
	ldr	r3, [r5]
	ldrb	r0, [r3, #3]
	movs	r7, r0
	mov	r9, r0
	movs	r0, #1
	ands	r7, r1
	mov	ip, r0
	strb	r4, [r3]
	tst	r0, r7
	beq	.L348
	mov	r8, r0
	mov	r0, r8
	ldrb	r7, [r3, #2]
	orrs	r7, r0
	strb	r7, [r3, #2]
	mov	r0, ip
	mov	r7, r9
	bics	r7, r0
	movs	r0, r7
	strb	r7, [r3, #3]
	mov	r9, r7
	ldrb	r7, [r3, #1]
	ands	r0, r1
	adds	r7, r7, #1
	strb	r7, [r3, #1]
	movs	r7, r0
	strb	r4, [r2, #10]
.L348:
	movs	r0, #2
	mov	ip, r0
	tst	r0, r7
	beq	.L349
	mov	r8, r0
	mov	r0, r8
	ldrb	r7, [r3, #2]
	orrs	r7, r0
	strb	r7, [r3, #2]
	mov	r0, ip
	mov	r7, r9
	bics	r7, r0
	movs	r0, r7
	strb	r7, [r3, #3]
	mov	r9, r7
	ldrb	r7, [r3, #1]
	adds	r7, r7, #1
	strb	r7, [r3, #1]
	movs	r7, #0
	ands	r0, r1
	strb	r7, [r2, #11]
	movs	r7, r0
.L349:
	movs	r0, #4
	mov	ip, r0
	tst	r0, r7
	beq	.L350
	mov	r8, r0
	mov	r0, r8
	ldrb	r7, [r3, #2]
	orrs	r7, r0
	strb	r7, [r3, #2]
	mov	r0, ip
	mov	r7, r9
	bics	r7, r0
	movs	r0, r7
	strb	r7, [r3, #3]
	mov	r9, r7
	ldrb	r7, [r3, #1]
	adds	r7, r7, #1
	strb	r7, [r3, #1]
	movs	r7, #0
	ands	r1, r0
	strb	r7, [r2, #12]
	movs	r7, r1
.L350:
	movs	r1, #8
	tst	r1, r7
	beq	.L351
	movs	r0, #8
	mov	ip, r0
	mov	r0, ip
	ldrb	r7, [r3, #2]
	orrs	r7, r0
	mov	r0, r9
	bics	r0, r1
	ldrb	r1, [r3, #1]
	adds	r1, r1, #1
	strb	r7, [r3, #2]
	strb	r0, [r3, #3]
	strb	r1, [r3, #1]
	movs	r3, #0
	strb	r3, [r2, #13]
.L351:
	movs	r3, #0
	strb	r3, [r2, #5]
	b	.L347
.L376:
	.align	2
.L375:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.size	rfu_CB_CHILD_pollConnectRecovery, .-rfu_CB_CHILD_pollConnectRecovery
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_sendData, %function
rfu_CB_sendData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r4, .L433
	subs	r5, r1, #0
	ldr	r3, [r4]
	bne	.L407
	ldr	r2, [r4, #28]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	beq	.L381
	strb	r5, [r2, #2]
.L381:
	ldr	r2, [r4, #12]
	ldr	r1, .L433+4
	ldrh	r0, [r2]
	cmp	r0, r1
	beq	.L423
	ldr	r2, [r4, #32]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	beq	.L388
.L428:
	movs	r1, #0
	strb	r1, [r2, #2]
.L388:
	ldr	r2, [r4, #16]
	ldr	r1, .L433+4
	ldrh	r0, [r2]
	cmp	r0, r1
	beq	.L424
	ldr	r2, [r4, #36]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	beq	.L395
.L430:
	movs	r1, #0
	strb	r1, [r2, #2]
.L395:
	ldr	r2, [r4, #20]
	ldr	r1, .L433+4
	ldrh	r0, [r2]
	cmp	r0, r1
	beq	.L425
	ldr	r2, [r4, #40]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	beq	.L402
.L432:
	movs	r1, #0
	strb	r1, [r2, #2]
.L402:
	ldr	r2, [r4, #24]
	ldr	r1, .L433+4
	ldrh	r0, [r2]
	cmp	r0, r1
	bne	.LCB2479
	b	.L426	@long jump
.LCB2479:
.L407:
	movs	r2, #0
	ldr	r0, .L433+8
	strb	r2, [r3, #14]
	bl	STWI_set_Callback_M
	ldr	r3, [r4, #8]
	strh	r5, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L377
	ldr	r3, [r4, #4]
	movs	r1, r5
	movs	r0, #36
	ldr	r3, [r3]
	bl	.L67
.L377:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L423:
	ldr	r0, [r4, #8]
	ldrh	r1, [r2, #46]
	ldrb	r0, [r0]
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	cmp	r0, #127
	bhi	.L427
	ldrb	r0, [r3, #15]
	adds	r0, r0, #3
	adds	r1, r1, r0
	strb	r1, [r3, #15]
.L387:
	ldrb	r0, [r2, #26]
	ldrb	r1, [r3, #4]
	bics	r1, r0
	strb	r1, [r3, #4]
	movs	r1, #45
	ldrb	r1, [r2, r1]
	cmp	r1, #1
	bne	.L386
	movs	r0, #1
	ldrb	r1, [r3, #7]
	orrs	r1, r0
	strb	r1, [r3, #7]
.L386:
	movs	r1, #38
	strh	r1, [r2]
	ldr	r2, [r4, #32]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	beq	.L388
	b	.L428
.L424:
	ldr	r0, [r4, #8]
	ldrh	r1, [r2, #46]
	ldrb	r0, [r0]
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	cmp	r0, #127
	bhi	.L429
	ldrb	r0, [r3, #15]
	adds	r0, r0, #3
	adds	r1, r1, r0
	strb	r1, [r3, #15]
.L394:
	ldrb	r0, [r2, #26]
	ldrb	r1, [r3, #4]
	bics	r1, r0
	strb	r1, [r3, #4]
	movs	r1, #45
	ldrb	r1, [r2, r1]
	cmp	r1, #1
	bne	.L393
	movs	r0, #2
	ldrb	r1, [r3, #7]
	orrs	r1, r0
	strb	r1, [r3, #7]
.L393:
	movs	r1, #38
	strh	r1, [r2]
	ldr	r2, [r4, #36]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	beq	.L395
	b	.L430
.L425:
	ldr	r0, [r4, #8]
	ldrh	r1, [r2, #46]
	ldrb	r0, [r0]
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	cmp	r0, #127
	bhi	.L431
	ldrb	r0, [r3, #15]
	adds	r0, r0, #3
	adds	r1, r1, r0
	strb	r1, [r3, #15]
.L401:
	ldrb	r0, [r2, #26]
	ldrb	r1, [r3, #4]
	bics	r1, r0
	strb	r1, [r3, #4]
	movs	r1, #45
	ldrb	r1, [r2, r1]
	cmp	r1, #1
	bne	.L400
	movs	r0, #4
	ldrb	r1, [r3, #7]
	orrs	r1, r0
	strb	r1, [r3, #7]
.L400:
	movs	r1, #38
	strh	r1, [r2]
	ldr	r2, [r4, #40]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	bne	.LCB2618
	b	.L402	@long jump
.LCB2618:
	b	.L432
.L426:
	ldr	r0, [r4, #8]
	ldrh	r1, [r2, #46]
	ldrb	r0, [r0]
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	cmp	r0, #127
	bhi	.L404
	ldrb	r0, [r3, #15]
	adds	r0, r0, #3
	adds	r1, r1, r0
	strb	r1, [r3, #15]
.L405:
	ldrb	r0, [r2, #26]
	ldrb	r1, [r3, #4]
	bics	r1, r0
	strb	r1, [r3, #4]
	movs	r1, #45
	ldrb	r1, [r2, r1]
	cmp	r1, #1
	bne	.L406
	movs	r0, #8
	ldrb	r1, [r3, #7]
	orrs	r1, r0
	strb	r1, [r3, #7]
.L406:
	movs	r1, #38
	strh	r1, [r2]
	b	.L407
.L404:
	ldrb	r0, [r3, #19]
	adds	r0, r0, #2
	adds	r1, r1, r0
	strb	r1, [r3, #19]
	b	.L405
.L431:
	ldrb	r0, [r3, #18]
	adds	r0, r0, #2
	adds	r1, r1, r0
	strb	r1, [r3, #18]
	b	.L401
.L429:
	ldrb	r0, [r3, #17]
	adds	r0, r0, #2
	adds	r1, r1, r0
	strb	r1, [r3, #17]
	b	.L394
.L427:
	ldrb	r0, [r3, #16]
	adds	r0, r0, #2
	adds	r1, r1, r0
	strb	r1, [r3, #16]
	b	.L387
.L434:
	.align	2
.L433:
	.word	.LANCHOR0
	.word	32800
	.word	rfu_CB_defaultCallback
	.size	rfu_CB_sendData, .-rfu_CB_sendData
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_pollConnectParent, %function
rfu_CB_pollConnectParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r8
	push	{lr}
	movs	r5, r0
	movs	r4, r1
	ldr	r6, .L454
	sub	sp, sp, #40
	cmp	r1, #0
	bne	.L437
	movs	r3, #220
	ldr	r2, [r6, #4]
	ldr	r3, [r2, r3]
	ldr	r2, [r3, #4]
	ldrb	r7, [r3, #6]
	ldrb	r3, [r3, #7]
	mov	ip, r2
	cmp	r3, #0
	beq	.L452
.L437:
	ldr	r0, .L454+4
	bl	STWI_set_Callback_M
	ldr	r3, [r6, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L435
	ldr	r3, [r6, #4]
	movs	r1, r4
	movs	r0, r5
	ldr	r3, [r3]
	bl	.L67
.L435:
	add	sp, sp, #40
	@ sp needed
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L452:
	adds	r3, r3, #1
	lsls	r3, r3, r7
	ldr	r1, [r6]
	lsls	r2, r3, #24
	ldrb	r0, [r1, #2]
	lsrs	r2, r2, #24
	tst	r2, r0
	bne	.L437
	orrs	r0, r2
	ldrb	r2, [r1, #3]
	bics	r2, r3
	strb	r2, [r1, #3]
	movs	r3, #140
	mov	r2, ip
	strb	r0, [r1, #2]
	strh	r2, [r1, r3]
	movs	r2, #128
	ldrb	r3, [r1, #1]
	adds	r3, r3, #1
	strb	r3, [r1, #1]
	strb	r4, [r1]
	ldr	r3, [r6, #8]
	ldrb	r0, [r3]
	rsbs	r2, r2, #0
	orrs	r2, r0
	strb	r2, [r3]
	ldrh	r3, [r3, #30]
	ldrh	r2, [r1, #20]
	cmp	r2, r3
	beq	.L442
	ldrh	r2, [r1, #50]
	cmp	r2, r3
	beq	.L443
	movs	r2, #80
	ldrh	r2, [r1, r2]
	cmp	r2, r3
	beq	.L444
	movs	r2, #110
	ldrh	r2, [r1, r2]
	cmp	r2, r3
	bne	.L437
	movs	r3, #3
.L439:
	lsls	r0, r3, #4
	subs	r0, r0, r3
	lsls	r0, r0, #1
	ldrb	r3, [r1, #8]
	adds	r0, r0, #20
	adds	r0, r1, r0
	cmp	r3, #0
	bne	.L453
.L440:
	lsls	r3, r7, #4
	subs	r3, r3, r7
	lsls	r3, r3, #1
	mov	r8, r3
	adds	r3, r3, #20
	adds	r1, r1, r3
	movs	r2, #15
	bl	CpuSet
	ldr	r3, [r6]
	add	r3, r3, r8
	strb	r7, [r3, #22]
	b	.L437
.L453:
	movs	r2, #15
	add	r1, sp, #8
	bl	CpuSet
	mov	r3, sp
	adds	r0, r3, #6
	movs	r3, #0
	ldr	r1, [r6]
	ldr	r2, .L454+8
	adds	r1, r1, #20
	strh	r3, [r0]
	bl	CpuSet
	movs	r3, #0
	ldr	r1, [r6]
	add	r0, sp, #8
	strb	r3, [r1, #8]
	b	.L440
.L442:
	movs	r3, #0
	b	.L439
.L443:
	movs	r3, #1
	b	.L439
.L444:
	movs	r3, #2
	b	.L439
.L455:
	.align	2
.L454:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	16777276
	.size	rfu_CB_pollConnectParent, .-rfu_CB_pollConnectParent
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_pollAndEndSearchChild, %function
rfu_CB_pollAndEndSearchChild:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	mov	lr, fp
	push	{r5, r6, r7, lr}
	movs	r6, r0
	movs	r5, r1
	ldr	r7, .L481
	sub	sp, sp, #12
	cmp	r1, #0
	beq	.L475
.L457:
	cmp	r6, #26
	beq	.L479
	cmp	r6, #27
	beq	.L476
.L478:
	ldr	r4, .L481+4
.L462:
	movs	r0, r4
	bl	STWI_set_Callback_M
	ldr	r3, [r7, #8]
	strh	r5, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L456
	ldr	r3, [r7, #4]
	movs	r1, r5
	movs	r0, r6
	ldr	r3, [r3]
	bl	.L67
.L456:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L476:
	ldr	r3, [r7]
	ldrb	r2, [r3]
	cmp	r2, #255
	beq	.L480
.L464:
	movs	r2, #0
	ldr	r3, [r7, #8]
	strb	r2, [r3, #9]
	b	.L478
.L479:
	movs	r2, #140
	ldr	r3, [r7]
	ldrh	r3, [r3, r2]
	mov	r8, r2
	ldr	r4, .L481+4
	cmp	r3, #0
	bne	.L462
	movs	r0, r4
	bl	STWI_set_Callback_M
	bl	STWI_send_SystemStatusREQ
	bl	STWI_poll_CommandEnd
	cmp	r0, #0
	bne	.L462
	movs	r3, #220
	mov	r1, r8
	ldr	r2, [r7, #4]
	ldr	r3, [r2, r3]
	ldrh	r2, [r3, #4]
	ldr	r3, [r7]
	strh	r2, [r3, r1]
	b	.L462
.L475:
	movs	r3, #220
	ldr	r2, [r7, #4]
	ldr	r4, [r2, r3]
	ldrb	r3, [r4, #1]
	adds	r4, r4, #4
	cmp	r3, #0
	beq	.L457
	ldr	r2, [r7, #8]
	mov	r8, r2
	movs	r2, #1
	mov	ip, r2
	adds	r2, r2, #239
	mov	r10, r2
	subs	r2, r2, #224
	mov	r9, r2
	mov	r0, r8
	ldr	r1, [r7]
	str	r6, [sp]
	str	r5, [sp, #4]
.L459:
	ldrb	r2, [r4, #2]
	cmp	r2, #3
	bhi	.L458
	ldrb	r5, [r1, #2]
	mov	r8, r5
	asrs	r5, r5, r2
	mov	fp, r5
	mov	r5, ip
	mov	r6, fp
	tst	r5, r6
	bne	.L458
	ldrb	r5, [r1, #3]
	asrs	r5, r5, r2
	mov	fp, r5
	mov	r5, ip
	mov	r6, fp
	tst	r5, r6
	bne	.L458
	mov	r6, r10
	adds	r5, r0, r2
	strb	r6, [r5, #14]
	mov	r6, r9
	adds	r5, r1, r2
	strb	r6, [r5, #10]
	mov	r5, ip
	lsls	r5, r5, r2
	mov	fp, r5
	mov	r5, r8
	mov	r6, fp
	orrs	r5, r6
	strb	r5, [r1, #2]
	ldrb	r5, [r1, #1]
	mov	r8, r5
	movs	r5, #1
	mov	fp, r5
	add	r8, r8, fp
	mov	r5, r8
	strb	r5, [r1, #1]
	ldrh	r5, [r4]
	mov	r8, r5
	lsls	r5, r2, #4
	subs	r5, r5, r2
	lsls	r5, r5, #1
	mov	fp, r5
	add	fp, fp, r1
	mov	r5, fp
	mov	r6, r8
	strb	r2, [r5, #22]
	strh	r6, [r5, #20]
	mov	r5, ip
	movs	r6, #127
	strb	r5, [r1]
	ldrb	r5, [r0]
	ands	r5, r6
	strb	r5, [r0]
	mov	r5, r8
	adds	r2, r2, #8
	lsls	r2, r2, #1
	adds	r2, r0, r2
	strh	r5, [r2, #2]
.L458:
	subs	r3, r3, #1
	lsls	r2, r3, #24
	lsrs	r3, r2, #24
	adds	r4, r4, #4
	cmp	r2, #0
	bne	.L459
	ldr	r6, [sp]
	ldr	r5, [sp, #4]
	b	.L457
.L480:
	movs	r1, #0
	subs	r2, r2, #115
	strh	r1, [r3, r2]
	b	.L464
.L482:
	.align	2
.L481:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.size	rfu_CB_pollAndEndSearchChild, .-rfu_CB_pollAndEndSearchChild
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_pollSearchParent, %function
rfu_CB_pollSearchParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	push	{r5, r6, r7, lr}
	mov	fp, r0
	movs	r4, r1
	sub	sp, sp, #12
	cmp	r1, #0
	beq	.L500
	ldr	r6, .L502
.L484:
	ldr	r0, .L502+4
	bl	STWI_set_Callback_M
	ldr	r3, [r6, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L483
	ldr	r3, [r6, #4]
	movs	r1, r4
	mov	r0, fp
	ldr	r3, [r3]
	bl	.L67
.L483:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L500:
	mov	r3, sp
	ldr	r6, .L502
	strh	r1, [r3, #6]
	ldr	r1, [r6]
	adds	r0, r3, #6
	ldr	r2, .L502+8
	adds	r1, r1, #20
	bl	CpuSet
	movs	r3, #220
	ldr	r2, [r6, #4]
	ldr	r2, [r2, r3]
	ldr	r3, [r6]
	mov	ip, r3
	movs	r3, #0
	mov	r0, ip
	ldrb	r1, [r2, #1]
	strb	r3, [r0, #8]
	adds	r2, r2, #4
	cmp	r1, #0
	beq	.L484
	movs	r0, #0
	b	.L486
.L485:
	movs	r3, #3
	adds	r0, r0, #1
	lsls	r0, r0, #24
	lsrs	r0, r0, #24
	adds	r2, r2, #28
	cmp	r3, r0
	bcc	.L484
	cmp	r1, #0
	beq	.L484
.L486:
	ldrb	r5, [r2, #6]
	ldrb	r3, [r2, #20]
	adds	r3, r3, r5
	ldrb	r5, [r2, #21]
	adds	r3, r3, r5
	ldrb	r5, [r2, #7]
	adds	r3, r3, r5
	ldrb	r5, [r2, #22]
	adds	r3, r3, r5
	ldrb	r5, [r2, #8]
	adds	r3, r3, r5
	ldrb	r5, [r2, #23]
	adds	r3, r3, r5
	ldrb	r5, [r2, #9]
	adds	r3, r3, r5
	ldrb	r5, [r2, #24]
	adds	r3, r3, r5
	ldrb	r5, [r2, #10]
	adds	r3, r3, r5
	ldrb	r5, [r2, #25]
	adds	r3, r3, r5
	ldrb	r5, [r2, #11]
	adds	r3, r3, r5
	ldrb	r5, [r2, #26]
	adds	r3, r3, r5
	ldrb	r5, [r2, #12]
	adds	r3, r3, r5
	ldrb	r5, [r2, #27]
	ldrb	r7, [r2, #13]
	adds	r3, r3, r5
	ldrb	r5, [r2, #19]
	mov	r9, r7
	mvns	r5, r5
	subs	r1, r1, #7
	lsls	r1, r1, #24
	add	r3, r3, r9
	lsrs	r1, r1, #24
	lsls	r5, r5, #24
	lsls	r3, r3, #24
	cmp	r3, r5
	bne	.L485
	mov	r3, ip
	ldrb	r3, [r3, #8]
	mov	r8, r3
	ldrh	r3, [r2]
	mov	r9, r3
	mov	r3, r8
	mov	r5, r8
	lsls	r3, r3, #4
	subs	r3, r3, r5
	mov	r5, r9
	lsls	r3, r3, #1
	add	r3, r3, ip
	strh	r5, [r3, #20]
	ldrb	r5, [r2, #2]
	strb	r5, [r3, #22]
	ldrh	r5, [r2, #4]
	lsls	r5, r5, #17
	lsrs	r5, r5, #17
	strh	r5, [r3, #24]
	ldrh	r5, [r2, #4]
	lsrs	r5, r5, #15
	strb	r5, [r3, #23]
	ldrb	r5, [r2, #6]
	strb	r5, [r3, #26]
	ldrb	r5, [r2, #7]
	strb	r5, [r3, #27]
	ldrb	r5, [r2, #8]
	strb	r5, [r3, #28]
	ldrb	r5, [r2, #9]
	strb	r5, [r3, #29]
	ldrb	r5, [r2, #10]
	strb	r5, [r3, #30]
	ldrb	r5, [r2, #11]
	strb	r5, [r3, #31]
	ldrb	r5, [r2, #12]
	mov	r10, r5
	movs	r5, #32
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #13]
	mov	r10, r5
	movs	r5, #33
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #14]
	mov	r10, r5
	movs	r5, #34
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #15]
	mov	r10, r5
	movs	r5, #35
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #16]
	mov	r10, r5
	movs	r5, #36
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #17]
	mov	r10, r5
	movs	r5, #37
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #18]
	mov	r10, r5
	movs	r5, #38
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #20]
	mov	r10, r5
	movs	r5, #41
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #21]
	mov	r10, r5
	movs	r5, #42
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #22]
	mov	r10, r5
	movs	r5, #43
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #23]
	mov	r10, r5
	movs	r5, #44
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #24]
	mov	r10, r5
	movs	r5, #45
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #25]
	mov	r10, r5
	movs	r5, #46
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #26]
	mov	r10, r5
	movs	r5, #47
	mov	r9, r5
	add	r9, r9, r3
	mov	r5, r9
	mov	r7, r10
	strb	r7, [r5]
	ldrb	r5, [r2, #27]
	adds	r3, r3, #48
	strb	r5, [r3]
	mov	r3, r8
	mov	r5, ip
	adds	r3, r3, #1
	strb	r3, [r5, #8]
	b	.L485
.L503:
	.align	2
.L502:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	16777276
	.size	rfu_CB_pollSearchParent, .-rfu_CB_pollSearchParent
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_recvData, %function
rfu_CB_recvData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r5, r8
	mov	r7, r10
	mov	r6, r9
	push	{r5, r6, r7, lr}
	mov	fp, r0
	movs	r4, r1
	ldr	r5, .L580
	sub	sp, sp, #12
	cmp	r1, #0
	bne	.L505
	movs	r3, #220
	ldr	r2, [r5, #4]
	ldr	r7, [r2, r3]
	ldrb	r3, [r7, #1]
	cmp	r3, #0
	bne	.L569
.L505:
	ldr	r0, .L580+4
	bl	STWI_set_Callback_M
	ldr	r3, [r5, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L504
	ldr	r3, [r5, #4]
	movs	r1, r4
	mov	r0, fp
	ldr	r3, [r3]
	bl	.L67
.L504:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L569:
	ldr	r2, [r5, #8]
	strb	r1, [r2, #1]
	ldr	r3, [r5]
	ldrb	r0, [r3]
	cmp	r0, #1
	beq	.L570
	movs	r1, #127
	ldrh	r6, [r7, #4]
	ands	r6, r1
	movs	r3, r6
	subs	r1, r3, #1
	sbcs	r3, r3, r1
	movs	r1, #14
	rsbs	r3, r3, #0
	bics	r3, r1
	adds	r3, r3, #15
	strb	r3, [r2, #1]
	adds	r7, r7, #8
	b	.L518
.L571:
	movs	r2, r6
	movs	r1, r7
	movs	r0, #0
	bl	rfu_STC_analyzeLLSF
	subs	r3, r6, r0
	lsls	r3, r3, #16
	adds	r7, r7, r0
	lsrs	r6, r3, #16
	cmp	r3, #0
	blt	.L515
.L518:
	cmp	r6, #0
	bne	.L571
.L515:
	ldr	r2, [r5, #12]
	ldr	r1, .L580+8
	ldrh	r0, [r2, #52]
	ldr	r3, [r5, #8]
	cmp	r0, r1
	bne	.LCB3500
	b	.L572	@long jump
.LCB3500:
.L519:
	ldr	r2, [r5, #16]
	ldr	r1, .L580+8
	ldrh	r0, [r2, #52]
	cmp	r0, r1
	bne	.LCB3506
	b	.L573	@long jump
.LCB3506:
.L525:
	ldr	r2, [r5, #20]
	ldr	r1, .L580+8
	ldrh	r0, [r2, #52]
	cmp	r0, r1
	beq	.L574
.L531:
	ldr	r2, [r5, #24]
	ldr	r1, .L580+8
	ldrh	r0, [r2, #52]
	cmp	r0, r1
	beq	.L575
.L537:
	ldrb	r3, [r3, #4]
	cmp	r3, #0
	beq	.L505
	movs	r4, #224
	lsls	r4, r4, #3
	orrs	r4, r3
	b	.L505
.L570:
	movs	r6, #31
	ldr	r3, [r7, #4]
	lsrs	r1, r3, #8
	mov	r10, r6
	ands	r6, r1
	movs	r1, r6
	mov	r9, r6
	mov	r6, sp
	strb	r1, [r6, #4]
	mov	r1, r10
	lsrs	r6, r3, #13
	ands	r1, r6
	mov	r6, sp
	mov	r8, r1
	strb	r1, [r6, #5]
	mov	r1, r10
	lsrs	r6, r3, #18
	ands	r6, r1
	mov	r1, sp
	strb	r6, [r1, #6]
	mov	r1, r10
	lsrs	r3, r3, #23
	ands	r3, r1
	mov	r1, sp
	strb	r3, [r1, #7]
	mov	r1, r9
	cmp	r1, #0
	bne	.L508
	strb	r0, [r2, #1]
.L508:
	mov	r1, r8
	cmp	r1, #0
	bne	.L509
	movs	r1, #2
	mov	r8, r1
	mov	r1, r8
	ldrb	r0, [r2, #1]
	orrs	r0, r1
	strb	r0, [r2, #1]
.L509:
	cmp	r6, #0
	bne	.L510
	movs	r6, #4
	ldrb	r0, [r2, #1]
	orrs	r0, r6
	strb	r0, [r2, #1]
.L510:
	cmp	r3, #0
	bne	.LCB3592
	b	.L576	@long jump
.LCB3592:
.L511:
	add	r3, sp, #4
	mov	r9, r3
	movs	r3, #0
	mov	r8, r3
	adds	r7, r7, #8
.L514:
	mov	r3, r9
	ldrb	r6, [r3]
	cmp	r6, #0
	bne	.L513
.L512:
	mov	r6, r8
	adds	r6, r6, #1
	lsls	r3, r6, #24
	lsrs	r3, r3, #24
	mov	r8, r3
	movs	r3, #1
	mov	ip, r3
	mov	r3, r8
	add	r9, r9, ip
	cmp	r3, #4
	bne	.L514
	b	.L515
.L513:
	movs	r2, r6
	movs	r1, r7
	mov	r0, r8
	bl	rfu_STC_analyzeLLSF
	lsls	r3, r0, #24
	lsrs	r3, r3, #24
	adds	r7, r7, r3
	subs	r3, r6, r3
	lsls	r3, r3, #24
	lsrs	r6, r3, #24
	mov	r3, r9
	strb	r6, [r3]
	lsls	r3, r6, #24
	cmp	r3, #0
	bgt	.L513
	b	.L512
.L575:
	ldrb	r1, [r3, #1]
	lsls	r1, r1, #28
	bmi	.L537
	movs	r0, r2
	adds	r0, r0, #97
	ldrb	r0, [r0]
	ldr	r1, [r5]
	cmp	r0, #1
	bne	.L538
	movs	r7, #8
	ldrb	r0, [r1, #7]
	orrs	r0, r7
	strb	r0, [r1, #7]
.L538:
	ldrb	r0, [r3]
	cmp	r0, #127
	bhi	.L539
	ldrb	r0, [r1, #15]
	adds	r0, r0, #3
	strb	r0, [r1, #15]
.L540:
	movs	r0, r2
	adds	r0, r0, #52
	ldrb	r7, [r0, #26]
	ldrb	r0, [r1, #5]
	bics	r0, r7
	strb	r0, [r1, #5]
	movs	r1, #70
	strh	r1, [r2, #52]
	b	.L537
.L574:
	ldrb	r1, [r3, #1]
	lsls	r1, r1, #29
	bpl	.LCB3688
	b	.L531	@long jump
.LCB3688:
	movs	r0, r2
	adds	r0, r0, #97
	ldrb	r0, [r0]
	ldr	r1, [r5]
	cmp	r0, #1
	bne	.L536
	movs	r7, #4
	ldrb	r0, [r1, #7]
	orrs	r0, r7
	strb	r0, [r1, #7]
.L536:
	ldrb	r0, [r3]
	cmp	r0, #127
	bhi	.L577
	ldrb	r0, [r1, #15]
	adds	r0, r0, #3
	strb	r0, [r1, #15]
.L535:
	movs	r0, r2
	adds	r0, r0, #52
	ldrb	r7, [r0, #26]
	ldrb	r0, [r1, #5]
	bics	r0, r7
	strb	r0, [r1, #5]
	movs	r1, #70
	strh	r1, [r2, #52]
	b	.L531
.L573:
	ldrb	r1, [r3, #1]
	lsls	r1, r1, #30
	bpl	.LCB3728
	b	.L525	@long jump
.LCB3728:
	movs	r0, r2
	adds	r0, r0, #97
	ldrb	r0, [r0]
	ldr	r1, [r5]
	cmp	r0, #1
	bne	.L530
	movs	r7, #2
	ldrb	r0, [r1, #7]
	orrs	r0, r7
	strb	r0, [r1, #7]
.L530:
	ldrb	r0, [r3]
	cmp	r0, #127
	bhi	.L578
	ldrb	r0, [r1, #15]
	adds	r0, r0, #3
	strb	r0, [r1, #15]
.L529:
	movs	r0, r2
	adds	r0, r0, #52
	ldrb	r7, [r0, #26]
	ldrb	r0, [r1, #5]
	bics	r0, r7
	strb	r0, [r1, #5]
	movs	r1, #70
	strh	r1, [r2, #52]
	b	.L525
.L572:
	ldrb	r1, [r3, #1]
	lsls	r1, r1, #31
	bpl	.LCB3768
	b	.L519	@long jump
.LCB3768:
	movs	r0, r2
	adds	r0, r0, #97
	ldrb	r0, [r0]
	ldr	r1, [r5]
	cmp	r0, #1
	bne	.L524
	movs	r7, #1
	ldrb	r0, [r1, #7]
	orrs	r0, r7
	strb	r0, [r1, #7]
.L524:
	ldrb	r0, [r3]
	cmp	r0, #127
	bhi	.L579
	ldrb	r0, [r1, #15]
	adds	r0, r0, #3
	strb	r0, [r1, #15]
.L523:
	movs	r0, r2
	adds	r0, r0, #52
	ldrb	r7, [r0, #26]
	ldrb	r0, [r1, #5]
	bics	r0, r7
	strb	r0, [r1, #5]
	movs	r1, #70
	strh	r1, [r2, #52]
	b	.L519
.L576:
	movs	r0, #8
	ldrb	r3, [r2, #1]
	orrs	r3, r0
	strb	r3, [r2, #1]
	b	.L511
.L579:
	ldrb	r0, [r1, #16]
	adds	r0, r0, #2
	strb	r0, [r1, #16]
	b	.L523
.L539:
	ldrb	r0, [r1, #19]
	adds	r0, r0, #2
	strb	r0, [r1, #19]
	b	.L540
.L578:
	ldrb	r0, [r1, #17]
	adds	r0, r0, #2
	strb	r0, [r1, #17]
	b	.L529
.L577:
	ldrb	r0, [r1, #18]
	adds	r0, r0, #2
	strb	r0, [r1, #18]
	b	.L535
.L581:
	.align	2
.L580:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	32835
	.size	rfu_CB_recvData, .-rfu_CB_recvData
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_defaultCallback, %function
rfu_CB_defaultCallback:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #12
	cmp	r0, #255
	beq	.L634
.L582:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L634:
	ldr	r4, .L645
	ldr	r3, [r4, #8]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bmi	.L635
	ldr	r1, [r4]
	ldrb	r3, [r1, #2]
	movs	r5, r3
	movs	r0, #1
	ldrb	r2, [r1, #3]
	orrs	r5, r2
	tst	r0, r5
	bne	.L636
.L585:
	movs	r2, #2
	tst	r2, r5
	bne	.L637
.L590:
	movs	r2, #4
	tst	r2, r5
	bne	.L638
.L595:
	movs	r2, #8
	tst	r2, r5
	beq	.LCB3909
	b	.L639	@long jump
.LCB3909:
.L600:
	movs	r3, #255
	strb	r3, [r1]
	b	.L582
.L635:
	ldr	r3, [r4, #4]
	ldr	r3, [r3]
	bl	.L67
	ldr	r1, [r4]
	ldrb	r3, [r1, #2]
	movs	r5, r3
	movs	r0, #1
	ldrb	r2, [r1, #3]
	orrs	r5, r2
	tst	r0, r5
	beq	.L585
.L636:
	movs	r7, #0
	ldr	r6, [r4, #8]
	strb	r7, [r6, #14]
	tst	r0, r3
	beq	.L589
	ldrb	r0, [r1, #1]
	cmp	r0, #0
	beq	.LCB3939
	b	.L640	@long jump
.LCB3939:
.L589:
	movs	r0, #1
	orrs	r2, r0
	strb	r2, [r1, #3]
	ldrb	r2, [r1]
	bics	r3, r0
	strb	r3, [r1, #2]
	orrs	r3, r2
	bne	.LCB3953
	b	.L587	@long jump
.LCB3953:
.L588:
	mov	r3, sp
	adds	r0, r3, #6
	movs	r3, #0
	ldr	r2, .L645+4
	adds	r1, r1, #20
	strh	r3, [r0]
	bl	CpuSet
	movs	r2, #1
	ldr	r1, [r4]
	ldrb	r3, [r1, #3]
	bics	r3, r2
	strb	r3, [r1, #3]
	ldrb	r3, [r1, #7]
	bics	r3, r2
	strb	r3, [r1, #7]
	movs	r2, #2
	movs	r3, #0
	strb	r3, [r1, #10]
	tst	r2, r5
	beq	.L590
.L637:
	movs	r0, #0
	ldr	r3, [r4, #8]
	strb	r0, [r3, #15]
	ldrb	r3, [r1, #2]
	tst	r2, r3
	beq	.L594
	ldrb	r2, [r1, #1]
	cmp	r2, #0
	bne	.L641
.L594:
	movs	r2, #2
	movs	r0, #2
	bics	r3, r2
	ldrb	r2, [r1, #3]
	orrs	r2, r0
	strb	r2, [r1, #3]
	ldrb	r2, [r1]
	strb	r3, [r1, #2]
	orrs	r3, r2
	beq	.L592
.L593:
	mov	r3, sp
	adds	r0, r3, #6
	movs	r3, #0
	ldr	r2, .L645+4
	adds	r1, r1, #50
	strh	r3, [r0]
	bl	CpuSet
	movs	r2, #2
	ldr	r1, [r4]
	ldrb	r3, [r1, #3]
	bics	r3, r2
	strb	r3, [r1, #3]
	ldrb	r3, [r1, #7]
	bics	r3, r2
	strb	r3, [r1, #7]
	movs	r2, #4
	movs	r3, #0
	strb	r3, [r1, #11]
	tst	r2, r5
	beq	.L595
.L638:
	movs	r0, #0
	ldr	r3, [r4, #8]
	strb	r0, [r3, #16]
	ldrb	r3, [r1, #2]
	tst	r2, r3
	beq	.L599
	ldrb	r2, [r1, #1]
	cmp	r2, #0
	bne	.L642
.L599:
	movs	r2, #4
	movs	r0, #4
	bics	r3, r2
	ldrb	r2, [r1, #3]
	orrs	r2, r0
	strb	r2, [r1, #3]
	ldrb	r2, [r1]
	strb	r3, [r1, #2]
	orrs	r3, r2
	beq	.L597
.L598:
	mov	r3, sp
	adds	r0, r3, #6
	movs	r3, #0
	ldr	r2, .L645+4
	adds	r1, r1, #80
	strh	r3, [r0]
	bl	CpuSet
	movs	r2, #4
	ldr	r1, [r4]
	ldrb	r3, [r1, #3]
	bics	r3, r2
	strb	r3, [r1, #3]
	ldrb	r3, [r1, #7]
	bics	r3, r2
	strb	r3, [r1, #7]
	movs	r2, #8
	movs	r3, #0
	strb	r3, [r1, #12]
	tst	r2, r5
	bne	.LCB4074
	b	.L600	@long jump
.LCB4074:
.L639:
	movs	r0, #0
	ldr	r3, [r4, #8]
	strb	r0, [r3, #17]
	ldrb	r3, [r1, #2]
	tst	r2, r3
	beq	.L601
	ldrb	r2, [r1, #1]
	cmp	r2, #0
	bne	.L643
.L601:
	movs	r2, #8
	movs	r0, #8
	bics	r3, r2
	ldrb	r2, [r1, #3]
	orrs	r2, r0
	strb	r2, [r1, #3]
	ldrb	r2, [r1]
	strb	r3, [r1, #2]
	orrs	r3, r2
	beq	.L644
.L602:
	mov	r3, sp
	adds	r0, r3, #6
	movs	r3, #0
	ldr	r2, .L645+4
	adds	r1, r1, #110
	strh	r3, [r0]
	bl	CpuSet
	movs	r2, #8
	ldr	r1, [r4]
	ldrb	r3, [r1, #3]
	bics	r3, r2
	strb	r3, [r1, #3]
	ldrb	r3, [r1, #7]
	bics	r3, r2
	strb	r3, [r1, #7]
	movs	r3, #0
	strb	r3, [r1, #13]
	b	.L600
.L640:
	subs	r0, r0, #1
	strb	r0, [r1, #1]
	b	.L589
.L641:
	subs	r2, r2, #1
	strb	r2, [r1, #1]
	b	.L594
.L642:
	subs	r2, r2, #1
	strb	r2, [r1, #1]
	b	.L599
.L643:
	subs	r2, r2, #1
	strb	r2, [r1, #1]
	b	.L601
.L644:
	adds	r3, r3, #255
	strb	r3, [r1]
	b	.L602
.L587:
	movs	r3, #255
	strb	r3, [r1]
	b	.L588
.L592:
	movs	r3, #255
	strb	r3, [r1]
	b	.L593
.L597:
	movs	r3, #255
	strb	r3, [r1]
	b	.L598
.L646:
	.align	2
.L645:
	.word	.LANCHOR0
	.word	16777231
	.size	rfu_CB_defaultCallback, .-rfu_CB_defaultCallback
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_sendData3, %function
rfu_CB_sendData3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	subs	r4, r1, #0
	bne	.L657
	cmp	r0, #255
	beq	.L658
.L647:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L657:
	ldr	r0, .L659
	bl	STWI_set_Callback_M
	ldr	r2, .L659+4
	ldr	r3, [r2, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L647
	ldr	r3, [r2, #4]
	movs	r1, r4
	movs	r0, #36
	ldr	r3, [r3]
	bl	.L67
	b	.L647
.L658:
	ldr	r0, .L659
	bl	STWI_set_Callback_M
	ldr	r2, .L659+4
	ldr	r3, [r2, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L647
	ldr	r3, [r2, #4]
	movs	r1, #0
	movs	r0, #255
	ldr	r3, [r3]
	bl	.L67
	b	.L647
.L660:
	.align	2
.L659:
	.word	rfu_CB_defaultCallback
	.word	.LANCHOR0
	.size	rfu_CB_sendData3, .-rfu_CB_sendData3
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CB_disconnect, %function
rfu_CB_disconnect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r8
	mov	lr, r10
	mov	r7, r9
	ldr	r4, .L714
	push	{r6, r7, lr}
	movs	r5, r1
	movs	r6, r0
	ldr	r2, [r4]
	cmp	r1, #3
	beq	.L707
	ldrb	r1, [r2, #3]
	ldr	r0, [r4, #8]
	ldrb	r3, [r2, #2]
	orrs	r3, r1
	ldrb	r1, [r0, #5]
	ands	r1, r3
	strb	r1, [r0, #5]
	movs	r0, #220
	ldr	r7, [r4, #4]
	ldr	r0, [r7, r0]
	ldr	r7, .L714+4
	strb	r1, [r0, #8]
	cmp	r5, #0
	bne	.L667
.L677:
	lsls	r1, r1, #31
	bmi	.L708
	ldr	r3, [r4, #8]
	ldrb	r3, [r3, #5]
	lsls	r3, r3, #30
	bmi	.L709
.L669:
	ldr	r3, [r4, #8]
	ldrb	r3, [r3, #5]
	lsls	r3, r3, #29
	bmi	.L710
.L670:
	ldr	r3, [r4, #8]
	ldrb	r3, [r3, #5]
	lsls	r3, r3, #28
	bmi	.L711
.L671:
	movs	r5, #0
	ldr	r2, [r4]
	ldrb	r3, [r2, #2]
	ldrb	r1, [r2, #3]
	orrs	r3, r1
.L667:
	cmp	r3, #0
	bne	.L672
	adds	r3, r3, #255
	strb	r3, [r2]
.L672:
	movs	r0, r7
	bl	STWI_set_Callback_M
	ldr	r3, [r4, #8]
	ldrb	r2, [r3]
	strh	r5, [r3, #28]
	lsls	r2, r2, #28
	bpl	.L673
	ldr	r3, [r4, #4]
	movs	r1, r5
	ldr	r3, [r3]
	movs	r0, r6
	bl	.L67
	ldr	r3, [r4, #8]
.L673:
	ldrb	r3, [r3, #9]
	cmp	r3, #0
	bne	.L712
.L661:
	@ sp needed
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L707:
	ldrb	r3, [r2]
	cmp	r3, #0
	beq	.L713
	movs	r3, #220
	ldr	r1, [r4, #4]
	ldr	r3, [r1, r3]
	ldr	r7, .L714+4
	mov	ip, r3
	ldrb	r1, [r2, #2]
	ldrb	r3, [r2, #3]
.L665:
	ldr	r0, [r4, #8]
	orrs	r3, r1
	ldrb	r1, [r0, #5]
	ands	r1, r3
	strb	r1, [r0, #5]
	mov	r0, ip
	strb	r1, [r0, #8]
	b	.L667
.L712:
	movs	r0, r7
	bl	STWI_set_Callback_M
	bl	STWI_send_SC_StartREQ
	bl	STWI_poll_CommandEnd
	subs	r5, r0, #0
	beq	.L661
	movs	r0, r7
	bl	STWI_set_Callback_M
	ldr	r3, [r4, #8]
	strh	r5, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L661
	ldr	r3, [r4, #4]
	movs	r1, r5
	movs	r0, #25
	ldr	r3, [r3]
	bl	.L67
	b	.L661
.L711:
	movs	r1, #1
	movs	r0, #3
	bl	rfu_STC_removeLinkData
	b	.L671
.L708:
	movs	r1, #1
	movs	r0, #0
	bl	rfu_STC_removeLinkData
	ldr	r3, [r4, #8]
	ldrb	r3, [r3, #5]
	lsls	r3, r3, #30
	bpl	.L669
.L709:
	movs	r1, #1
	movs	r0, #1
	bl	rfu_STC_removeLinkData
	ldr	r3, [r4, #8]
	ldrb	r3, [r3, #5]
	lsls	r3, r3, #29
	bpl	.L670
.L710:
	movs	r1, #1
	movs	r0, #2
	bl	rfu_STC_removeLinkData
	ldr	r3, [r4, #8]
	ldrb	r3, [r3, #5]
	lsls	r3, r3, #28
	bpl	.L671
	b	.L711
.L713:
	ldr	r7, .L714+4
	movs	r0, r7
	bl	STWI_set_Callback_M
	bl	STWI_send_SystemStatusREQ
	bl	STWI_poll_CommandEnd
	cmp	r0, #0
	beq	.L664
	movs	r3, #220
	ldr	r1, [r4, #4]
	ldr	r2, [r4]
	ldr	r3, [r1, r3]
	ldrb	r1, [r2, #2]
	mov	ip, r3
	ldrb	r3, [r2, #3]
	b	.L665
.L664:
	movs	r3, #220
	ldr	r2, [r4, #4]
	ldr	r3, [r2, r3]
	mov	ip, r3
	mov	r0, ip
	ldr	r3, [r4, #8]
	ldr	r2, [r4]
	mov	r10, r3
	ldrb	r0, [r0, #7]
	ldrb	r3, [r3, #5]
	ldrb	r1, [r2, #2]
	mov	r9, r3
	ldrb	r3, [r2, #3]
	cmp	r0, #0
	bne	.L665
	orrs	r1, r3
	mov	r3, r9
	ands	r1, r3
	mov	r3, r10
	strb	r1, [r3, #5]
	mov	r3, ip
	strb	r1, [r3, #8]
	b	.L677
.L715:
	.align	2
.L714:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.size	rfu_CB_disconnect, .-rfu_CB_disconnect
	.align	1
	.p2align 2,,3
	.global	rfu_initializeAPI
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_initializeAPI, %function
rfu_initializeAPI:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r6, r2
	movs	r2, r3
	movs	r3, #240
	lsls	r3, r3, #20
	movs	r4, r0
	ands	r3, r0
	movs	r0, #128
	lsls	r0, r0, #18
	cmp	r3, r0
	beq	.L743
	lsls	r3, r4, #30
	beq	.LCB4523
	b	.L727	@long jump
.LCB4523:
	cmp	r2, #0
	beq	.L719
	ldr	r3, .L744
	cmp	r1, r3
	bls	.L729
.L720:
	movs	r3, r4
	ldr	r5, .L744+4
	adds	r3, r3, #180
	str	r3, [r5, #8]
	adds	r3, r3, #40
	str	r3, [r5, #4]
	adds	r3, r3, #224
	str	r3, [r5, #12]
	movs	r3, #223
	lsls	r3, r3, #2
	adds	r3, r4, r3
	str	r3, [r5, #28]
	movs	r3, #139
	lsls	r3, r3, #2
	adds	r3, r4, r3
	str	r3, [r5, #16]
	movs	r3, #230
	lsls	r3, r3, #2
	adds	r3, r4, r3
	str	r3, [r5, #32]
	movs	r3, #167
	lsls	r3, r3, #2
	adds	r3, r4, r3
	str	r3, [r5, #20]
	movs	r3, #237
	lsls	r3, r3, #2
	adds	r3, r4, r3
	str	r3, [r5, #36]
	movs	r3, #195
	lsls	r3, r3, #2
	adds	r3, r4, r3
	str	r3, [r5, #24]
	movs	r3, #244
	lsls	r3, r3, #2
	adds	r3, r4, r3
	str	r3, [r5, #40]
	movs	r3, #251
	lsls	r3, r3, #2
	adds	r0, r4, r3
	str	r4, [r5]
	adds	r4, r4, #185
	adds	r4, r4, #255
	str	r0, [r4]
	movs	r1, r6
	bl	STWI_init_all
	bl	rfu_STC_clearAPIVariables
	movs	r3, #0
	ldr	r2, [r5, #12]
	str	r3, [r2, #104]
	str	r3, [r2, #108]
	ldr	r2, [r5, #28]
	str	r3, [r2, #20]
	str	r3, [r2, #24]
	ldr	r2, [r5, #16]
	str	r3, [r2, #104]
	str	r3, [r2, #108]
	ldr	r2, [r5, #32]
	str	r3, [r2, #20]
	str	r3, [r2, #24]
	ldr	r2, [r5, #20]
	str	r3, [r2, #104]
	str	r3, [r2, #108]
	ldr	r2, [r5, #36]
	str	r3, [r2, #20]
	str	r3, [r2, #24]
	ldr	r2, [r5, #24]
	str	r3, [r2, #104]
	str	r3, [r2, #108]
	ldr	r2, [r5, #40]
	ldr	r5, [r5, #4]
	movs	r4, r5
	str	r3, [r2, #20]
	str	r3, [r2, #24]
	movs	r2, #1
	ldr	r3, .L744+8
	adds	r4, r4, #8
	bics	r3, r2
	movs	r2, r4
	movs	r0, r3
	orrs	r2, r3
	adds	r0, r0, #96
	subs	r1, r5, r3
	lsls	r2, r2, #30
	bne	.L721
	adds	r2, r3, #2
	cmp	r4, r2
	beq	.L721
	adds	r1, r1, #8
.L722:
	ldr	r2, [r3]
	str	r2, [r1, r3]
	adds	r3, r3, #4
	cmp	r3, r0
	bne	.L722
.L723:
	movs	r0, #0
	adds	r4, r4, #1
	str	r4, [r5, #4]
.L718:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L743:
	cmp	r2, #0
	bne	.L727
	lsls	r3, r4, #30
	bne	.L727
.L719:
	ldr	r3, .L744+12
	cmp	r1, r3
	bhi	.L720
.L729:
	movs	r0, #1
	b	.L718
.L727:
	movs	r0, #2
	b	.L718
.L721:
	adds	r1, r1, #6
.L724:
	movs	r2, r3
	ldrh	r2, [r2]
	adds	r3, r3, #2
	strh	r2, [r3, r1]
	cmp	r3, r0
	bne	.L724
	b	.L723
.L745:
	.align	2
.L744:
	.word	3683
	.word	.LANCHOR0
	.word	rfu_STC_fastCopy
	.word	1283
	.size	rfu_initializeAPI, .-rfu_initializeAPI
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_PARENT_resumeRetransmitAndChange
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_PARENT_resumeRetransmitAndChange, %function
rfu_REQ_PARENT_resumeRetransmitAndChange:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L747
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_ResumeRetransmitAndChangeREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L748:
	.align	2
.L747:
	.word	rfu_STC_REQ_callback
	.size	rfu_REQ_PARENT_resumeRetransmitAndChange, .-rfu_REQ_PARENT_resumeRetransmitAndChange
	.align	1
	.p2align 2,,3
	.global	rfu_UNI_PARENT_getDRAC_ACK
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_UNI_PARENT_getDRAC_ACK, %function
rfu_UNI_PARENT_getDRAC_ACK:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, #0
	push	{r4, lr}
	strb	r2, [r0]
	ldr	r2, .L759
	ldr	r1, [r2]
	movs	r3, r0
	ldrb	r0, [r1]
	cmp	r0, #1
	bne	.L754
	ldr	r0, [r2, #4]
	movs	r2, #220
	ldr	r2, [r0, r2]
	ldrb	r4, [r2]
	cmp	r4, #40
	beq	.L751
	movs	r0, #16
	cmp	r4, #54
	bne	.L750
.L751:
	ldrb	r0, [r2, #1]
	cmp	r0, #0
	bne	.L752
	ldrb	r2, [r1, #2]
	strb	r2, [r3]
.L753:
	movs	r0, #0
.L750:
	@ sp needed
	pop	{r4}
	pop	{r1}
	bx	r1
.L754:
	movs	r0, #192
	lsls	r0, r0, #2
	b	.L750
.L752:
	ldrb	r2, [r2, #4]
	strb	r2, [r3]
	b	.L753
.L760:
	.align	2
.L759:
	.word	.LANCHOR0
	.size	rfu_UNI_PARENT_getDRAC_ACK, .-rfu_UNI_PARENT_getDRAC_ACK
	.align	1
	.p2align 2,,3
	.global	rfu_setTimerInterrupt
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_setTimerInterrupt, %function
rfu_setTimerInterrupt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, r0
	push	{r4, lr}
	movs	r0, r1
	@ sp needed
	movs	r1, r3
	bl	STWI_init_timer
	pop	{r4}
	pop	{r0}
	bx	r0
	.size	rfu_setTimerInterrupt, .-rfu_setTimerInterrupt
	.align	1
	.p2align 2,,3
	.global	rfu_getSTWIRecvBuffer
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_getSTWIRecvBuffer, %function
rfu_getSTWIRecvBuffer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L763
	@ sp needed
	ldr	r2, [r3, #4]
	movs	r3, #220
	ldr	r0, [r2, r3]
	bx	lr
.L764:
	.align	2
.L763:
	.word	.LANCHOR0
	.size	rfu_getSTWIRecvBuffer, .-rfu_getSTWIRecvBuffer
	.align	1
	.p2align 2,,3
	.global	rfu_setMSCCallback
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_setMSCCallback, %function
rfu_setMSCCallback:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	bl	STWI_set_Callback_S
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
	.size	rfu_setMSCCallback, .-rfu_setMSCCallback
	.align	1
	.p2align 2,,3
	.global	rfu_setREQCallback
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_setREQCallback, %function
rfu_setREQCallback:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L769
	ldr	r2, [r3, #4]
	str	r0, [r2]
	ldr	r2, [r3, #8]
	movs	r1, #8
	ldrb	r3, [r2]
	cmp	r0, #0
	beq	.L767
	orrs	r3, r1
.L768:
	strb	r3, [r2]
	@ sp needed
	bx	lr
.L767:
	bics	r3, r1
	b	.L768
.L770:
	.align	2
.L769:
	.word	.LANCHOR0
	.size	rfu_setREQCallback, .-rfu_setREQCallback
	.align	1
	.p2align 2,,3
	.global	rfu_waitREQComplete
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_waitREQComplete, %function
rfu_waitREQComplete:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	bl	STWI_poll_CommandEnd
	@ sp needed
	ldr	r3, .L772
	ldr	r3, [r3, #8]
	ldrh	r0, [r3, #28]
	pop	{r4}
	pop	{r1}
	bx	r1
.L773:
	.align	2
.L772:
	.word	.LANCHOR0
	.size	rfu_waitREQComplete, .-rfu_waitREQComplete
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_RFUStatus
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_RFUStatus, %function
rfu_REQ_RFUStatus:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L775
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_SystemStatusREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L776:
	.align	2
.L775:
	.word	rfu_STC_REQ_callback
	.size	rfu_REQ_RFUStatus, .-rfu_REQ_RFUStatus
	.align	1
	.p2align 2,,3
	.global	rfu_getRFUStatus
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_getRFUStatus, %function
rfu_getRFUStatus:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r4, #220
	ldr	r5, .L783
	ldr	r3, [r5, #4]
	ldr	r3, [r3, r4]
	ldrb	r3, [r3]
	movs	r6, r0
	movs	r0, #16
	cmp	r3, #147
	beq	.L782
.L778:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L782:
	bl	STWI_poll_CommandEnd
	cmp	r0, #0
	bne	.L779
	ldr	r3, [r5, #4]
	ldr	r3, [r3, r4]
	ldrb	r3, [r3, #7]
	movs	r0, #0
	strb	r3, [r6]
	b	.L778
.L779:
	movs	r3, #255
	movs	r0, #0
	strb	r3, [r6]
	b	.L778
.L784:
	.align	2
.L783:
	.word	.LANCHOR0
	.size	rfu_getRFUStatus, .-rfu_getRFUStatus
	.align	1
	.p2align 2,,3
	.global	rfu_MBOOT_CHILD_inheritanceLinkStatus
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_MBOOT_CHILD_inheritanceLinkStatus, %function
rfu_MBOOT_CHILD_inheritanceLinkStatus:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r3, .L794
	ldr	r0, .L794+4
	b	.L786
.L788:
	adds	r1, r3, #1
	ldrb	r3, [r3]
	cmp	r3, r2
	bne	.L790
	movs	r3, r1
.L786:
	ldrb	r2, [r3, r0]
	cmp	r2, #0
	bne	.L788
	movs	r2, #192
	movs	r3, #0
	ldr	r0, .L794+8
	lsls	r2, r2, #18
.L789:
	movs	r1, r2
	ldrh	r1, [r1]
	adds	r3, r3, r1
	lsls	r3, r3, #16
	adds	r2, r2, #2
	lsrs	r3, r3, #16
	cmp	r2, r0
	bne	.L789
	ldr	r2, .L794+12
	ldrh	r2, [r2]
	movs	r0, #1
	cmp	r2, r3
	beq	.L793
.L787:
	@ sp needed
	pop	{r4}
	pop	{r1}
	bx	r1
.L790:
	movs	r0, #1
	b	.L787
.L793:
	movs	r0, #192
	ldr	r4, .L794+16
	movs	r2, #85
	ldr	r1, [r4]
	lsls	r0, r0, #18
	bl	CpuSet
	movs	r3, #128
	ldr	r2, [r4, #8]
	ldrb	r1, [r2]
	rsbs	r3, r3, #0
	orrs	r3, r1
	movs	r0, #0
	strb	r3, [r2]
	b	.L787
.L795:
	.align	2
.L794:
	.word	50331888
	.word	.LANCHOR1-50331856
	.word	50331828
	.word	50331898
	.word	.LANCHOR0
	.size	rfu_MBOOT_CHILD_inheritanceLinkStatus, .-rfu_MBOOT_CHILD_inheritanceLinkStatus
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_stopMode
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_stopMode, %function
rfu_REQ_stopMode:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L812
	ldrh	r3, [r3]
	push	{r4, lr}
	cmp	r3, #0
	bne	.L797
	ldr	r0, .L812+4
	bl	STWI_set_Callback_M
	movs	r1, #6
	ldr	r2, .L812+8
	ldr	r3, [r2, #8]
	strh	r1, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bmi	.L811
.L798:
	movs	r2, #6
	ldr	r3, .L812+12
	ldr	r3, [r3]
	strh	r2, [r3, #18]
.L796:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L797:
	bl	AgbRFU_SoftReset
	bl	rfu_STC_clearAPIVariables
	movs	r0, #8
	bl	AgbRFU_checkID
	ldr	r3, .L812+16
	cmp	r0, r3
	bne	.L800
	ldr	r3, .L812+12
	ldr	r3, [r3]
	ldrb	r2, [r3, #10]
	ldr	r3, .L812+20
	mov	ip, r3
	movs	r3, #0
	add	r2, r2, ip
	lsls	r2, r2, #2
	str	r3, [r2]
	movs	r3, #131
	movs	r1, #131
	lsls	r3, r3, #16
	str	r3, [r2]
	lsls	r1, r1, #17
.L801:
	ldr	r3, [r2]
	lsls	r3, r3, #16
	cmp	r3, r1
	bcc	.L801
	movs	r3, #0
	ldr	r0, .L812+24
	str	r3, [r2]
	bl	STWI_set_Callback_M
	bl	STWI_send_StopModeREQ
	b	.L796
.L811:
	ldr	r3, [r2, #4]
	movs	r0, #61
	ldr	r3, [r3]
	bl	.L67
	b	.L798
.L800:
	movs	r2, #128
	ldr	r3, .L812+28
	lsls	r2, r2, #6
	strh	r2, [r3]
	ldr	r0, .L812+4
	bl	STWI_set_Callback_M
	movs	r1, #0
	ldr	r2, .L812+8
	ldr	r3, [r2, #8]
	strh	r1, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L796
	ldr	r3, [r2, #4]
	movs	r0, #61
	ldr	r3, [r3]
	bl	.L67
	b	.L796
.L813:
	.align	2
.L812:
	.word	67109384
	.word	rfu_CB_defaultCallback
	.word	.LANCHOR0
	.word	gSTWIStatus
	.word	32769
	.word	16777280
	.word	rfu_CB_stopMode
	.word	67109160
	.size	rfu_REQ_stopMode, .-rfu_REQ_stopMode
	.align	1
	.p2align 2,,3
	.global	rfu_REQBN_softReset_and_checkID
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQBN_softReset_and_checkID, %function
rfu_REQBN_softReset_and_checkID:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L819
	ldrh	r3, [r3]
	push	{r4, lr}
	cmp	r3, #0
	beq	.L818
	bl	AgbRFU_SoftReset
	bl	rfu_STC_clearAPIVariables
	movs	r0, #30
	bl	AgbRFU_checkID
	cmp	r0, #0
	bne	.L814
	movs	r2, #128
	ldr	r3, .L819+4
	lsls	r2, r2, #6
	strh	r2, [r3]
.L814:
	@ sp needed
	pop	{r4}
	pop	{r1}
	bx	r1
.L818:
	movs	r0, #1
	rsbs	r0, r0, #0
	b	.L814
.L820:
	.align	2
.L819:
	.word	67109384
	.word	67109160
	.size	rfu_REQBN_softReset_and_checkID, .-rfu_REQBN_softReset_and_checkID
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_reset
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_reset, %function
rfu_REQ_reset:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L822
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_ResetREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L823:
	.align	2
.L822:
	.word	rfu_CB_reset
	.size	rfu_REQ_reset, .-rfu_REQ_reset
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_configSystem
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_configSystem, %function
rfu_REQ_configSystem:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r6, r0
	ldr	r0, .L827
	movs	r4, r2
	movs	r5, r1
	bl	STWI_set_Callback_M
	movs	r0, #3
	movs	r3, #60
	ands	r0, r6
	movs	r2, r4
	movs	r1, r5
	orrs	r0, r3
	bl	STWI_send_SystemConfigREQ
	cmp	r4, #0
	bne	.L825
	movs	r2, #1
	ldr	r3, .L827+4
	ldr	r3, [r3, #8]
	strh	r2, [r3, #26]
.L824:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L825:
	movs	r3, #0
	movs	r0, #150
	ldr	r5, .L827+8
	movs	r1, r4
	ldrh	r6, [r5]
	lsls	r0, r0, #2
	strh	r3, [r5]
	bl	Div
	ldr	r3, .L827+4
	ldr	r3, [r3, #8]
	strh	r0, [r3, #26]
	strh	r6, [r5]
	b	.L824
.L828:
	.align	2
.L827:
	.word	rfu_STC_REQ_callback
	.word	.LANCHOR0
	.word	67109384
	.size	rfu_REQ_configSystem, .-rfu_REQ_configSystem
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_configGameData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_configGameData, %function
rfu_REQ_configGameData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r4, r3
	lsls	r3, r1, #24
	movs	r5, r0
	movs	r6, r2
	sub	sp, sp, #16
	lsrs	r3, r3, #24
	lsrs	r1, r1, #8
	cmp	r0, #0
	beq	.L830
	movs	r2, #128
	orrs	r1, r2
.L830:
	mov	r2, sp
	strb	r3, [r2]
	mov	r3, sp
	strb	r1, [r2, #1]
	adds	r0, r3, #2
	movs	r2, #13
	movs	r1, r6
	bl	memcpy
	ldrb	r3, [r4]
	ldrb	r2, [r4, #1]
	adds	r2, r2, r3
	ldrb	r3, [r4, #2]
	adds	r2, r2, r3
	ldrb	r3, [r4, #3]
	adds	r2, r2, r3
	ldrb	r3, [r6]
	adds	r2, r2, r3
	ldrb	r3, [r4, #4]
	adds	r2, r2, r3
	ldrb	r3, [r6, #1]
	adds	r2, r2, r3
	ldrb	r3, [r4, #5]
	adds	r2, r2, r3
	ldrb	r3, [r6, #2]
	adds	r2, r2, r3
	ldrb	r3, [r4, #6]
	adds	r2, r2, r3
	ldrb	r3, [r6, #3]
	adds	r2, r2, r3
	ldrb	r3, [r4, #7]
	adds	r2, r2, r3
	ldrb	r3, [r6, #4]
	adds	r2, r2, r3
	ldrb	r3, [r6, #5]
	adds	r2, r2, r3
	ldrb	r3, [r6, #6]
	adds	r2, r2, r3
	ldrb	r3, [r6, #7]
	adds	r2, r2, r3
	mvns	r2, r2
	mov	r3, sp
	strb	r2, [r3, #15]
	movs	r3, #0
	cmp	r5, #0
	bne	.L831
	mov	r3, sp
	ldrb	r3, [r3, #14]
.L831:
	mov	r2, sp
	ldr	r0, .L836
	strb	r3, [r2, #14]
	bl	STWI_set_Callback_M
	movs	r1, r4
	mov	r0, sp
	bl	STWI_send_GameConfigREQ
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L837:
	.align	2
.L836:
	.word	rfu_CB_configGameData
	.size	rfu_REQ_configGameData, .-rfu_REQ_configGameData
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_startSearchChild
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_startSearchChild, %function
rfu_REQ_startSearchChild:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r6, r9
	mov	r5, r8
	mov	r7, r10
	movs	r2, #0
	push	{r5, r6, r7, lr}
	ldr	r4, .L850
	ldr	r6, .L850+4
	ldr	r3, [r4, #8]
	movs	r0, r6
	strh	r2, [r3, #14]
	strh	r2, [r3, #16]
	sub	sp, sp, #20
	bl	STWI_set_Callback_M
	bl	STWI_send_SystemStatusREQ
	bl	STWI_poll_CommandEnd
	subs	r5, r0, #0
	bne	.L839
	movs	r3, #220
	ldr	r2, [r4, #4]
	ldr	r3, [r2, r3]
	ldrb	r3, [r3, #7]
	cmp	r3, #0
	beq	.L849
.L841:
	ldr	r0, .L850+8
	bl	STWI_set_Callback_M
	bl	STWI_send_SC_StartREQ
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L849:
	ldr	r2, .L850+12
	ldrh	r1, [r2]
	str	r1, [sp, #4]
	strh	r3, [r2]
	adds	r3, r3, #12
	mov	fp, r3
	adds	r3, r3, #16
	mov	r10, r3
	add	r3, sp, #8
	adds	r6, r3, #6
	movs	r3, #0
	mov	r8, r3
	add	fp, fp, r4
	add	r10, r10, r4
	add	r7, sp, #12
.L842:
	movs	r3, #0
	mov	r9, r3
	mov	r3, r8
	strh	r3, [r7]
	mov	r3, fp
	ldmia	r3!, {r1}
	movs	r0, r7
	ldr	r2, .L850+16
	mov	fp, r3
	bl	CpuSet
	mov	r3, r8
	strh	r3, [r6]
	mov	r3, r10
	ldmia	r3!, {r1}
	ldr	r2, .L850+20
	movs	r0, r6
	mov	r10, r3
	bl	CpuSet
	movs	r2, #16
	ldr	r1, [r4]
	adds	r3, r1, r5
	adds	r5, r5, #1
	strb	r2, [r3, #16]
	cmp	r5, #4
	bne	.L842
	movs	r3, #87
	strb	r3, [r1, #15]
	mov	r3, r8
	strh	r3, [r1, #4]
	mov	r3, r9
	mov	r2, r9
	strb	r3, [r1, #6]
	ldr	r3, [r4, #8]
	strb	r2, [r3, #2]
	ldr	r2, [sp, #4]
	ldr	r3, .L850+12
	strh	r2, [r3]
	add	r3, sp, #8
	adds	r0, r3, #2
	mov	r3, r8
	ldr	r2, .L850+24
	adds	r1, r1, #20
	strh	r3, [r0]
	bl	CpuSet
	mov	r2, r9
	ldr	r3, [r4]
	strb	r2, [r3, #8]
	mov	r2, r8
	strh	r2, [r3, #10]
	strh	r2, [r3, #12]
	mov	r2, r9
	strb	r2, [r3, #1]
	mov	r2, r8
	strh	r2, [r3, #2]
	mov	r2, r9
	strb	r2, [r3, #7]
	b	.L841
.L839:
	movs	r0, r6
	bl	STWI_set_Callback_M
	ldr	r3, [r4, #8]
	strh	r5, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L841
	ldr	r3, [r4, #4]
	movs	r1, r5
	movs	r0, #25
	ldr	r3, [r3]
	bl	.L67
	b	.L841
.L851:
	.align	2
.L850:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	rfu_CB_startSearchChild
	.word	67109384
	.word	16777268
	.word	16777226
	.word	16777276
	.size	rfu_REQ_startSearchChild, .-rfu_REQ_startSearchChild
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_pollSearchChild
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_pollSearchChild, %function
rfu_REQ_pollSearchChild:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L853
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_SC_PollingREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L854:
	.align	2
.L853:
	.word	rfu_CB_pollAndEndSearchChild
	.size	rfu_REQ_pollSearchChild, .-rfu_REQ_pollSearchChild
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_endSearchChild
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_endSearchChild, %function
rfu_REQ_endSearchChild:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L856
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_SC_EndREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L857:
	.align	2
.L856:
	.word	rfu_CB_pollAndEndSearchChild
	.size	rfu_REQ_endSearchChild, .-rfu_REQ_endSearchChild
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_startSearchParent
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_startSearchParent, %function
rfu_REQ_startSearchParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L859
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_SP_StartREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L860:
	.align	2
.L859:
	.word	rfu_CB_startSearchParent
	.size	rfu_REQ_startSearchParent, .-rfu_REQ_startSearchParent
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_pollSearchParent
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_pollSearchParent, %function
rfu_REQ_pollSearchParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L862
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_SP_PollingREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L863:
	.align	2
.L862:
	.word	rfu_CB_pollSearchParent
	.size	rfu_REQ_pollSearchParent, .-rfu_REQ_pollSearchParent
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_endSearchParent
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_endSearchParent, %function
rfu_REQ_endSearchParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L865
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_SP_EndREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L866:
	.align	2
.L865:
	.word	rfu_STC_REQ_callback
	.size	rfu_REQ_endSearchParent, .-rfu_REQ_endSearchParent
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_startConnectParent
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_startConnectParent, %function
rfu_REQ_startConnectParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r5, .L871
	ldr	r3, [r5]
	ldrh	r2, [r3, #20]
	movs	r4, r0
	cmp	r2, r0
	beq	.L868
	ldrh	r2, [r3, #50]
	cmp	r2, r0
	beq	.L868
	movs	r2, #80
	ldrh	r2, [r3, r2]
	cmp	r2, r0
	beq	.L868
	movs	r2, #110
	ldrh	r3, [r3, r2]
	cmp	r3, r0
	beq	.L868
	ldr	r0, .L871+4
	bl	STWI_set_Callback_M
	movs	r1, #128
	ldr	r3, [r5, #8]
	lsls	r1, r1, #1
	strh	r1, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L867
	ldr	r3, [r5, #4]
	movs	r0, #31
	ldr	r3, [r3]
	bl	.L67
.L867:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L868:
	ldr	r3, [r5, #8]
	ldr	r0, .L871+8
	strh	r4, [r3, #30]
	bl	STWI_set_Callback_M
	movs	r0, r4
	bl	STWI_send_CP_StartREQ
	b	.L867
.L872:
	.align	2
.L871:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	rfu_STC_REQ_callback
	.size	rfu_REQ_startConnectParent, .-rfu_REQ_startConnectParent
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_pollConnectParent
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_pollConnectParent, %function
rfu_REQ_pollConnectParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L874
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_CP_PollingREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L875:
	.align	2
.L874:
	.word	rfu_CB_pollConnectParent
	.size	rfu_REQ_pollConnectParent, .-rfu_REQ_pollConnectParent
	.align	1
	.p2align 2,,3
	.global	rfu_getConnectParentStatus
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_getConnectParentStatus, %function
rfu_getConnectParentStatus:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #255
	push	{r4, lr}
	strb	r3, [r0]
	ldr	r3, .L879
	movs	r2, r0
	ldr	r0, [r3, #4]
	movs	r3, #220
	ldr	r4, [r0, r3]
	ldrb	r3, [r4]
	adds	r3, r3, #96
	lsls	r3, r3, #24
	movs	r0, #16
	lsrs	r3, r3, #24
	cmp	r3, #1
	bhi	.L877
	movs	r0, #0
	ldrb	r3, [r4, #6]
	strb	r3, [r1]
	ldrb	r3, [r4, #7]
	strb	r3, [r2]
.L877:
	@ sp needed
	pop	{r4}
	pop	{r1}
	bx	r1
.L880:
	.align	2
.L879:
	.word	.LANCHOR0
	.size	rfu_getConnectParentStatus, .-rfu_getConnectParentStatus
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_endConnectParent
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_endConnectParent, %function
rfu_REQ_endConnectParent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L883
	bl	STWI_set_Callback_M
	bl	STWI_send_CP_EndREQ
	movs	r3, #220
	ldr	r2, .L883+4
	ldr	r1, [r2, #4]
	ldr	r3, [r1, r3]
	ldrb	r3, [r3, #6]
	cmp	r3, #3
	bhi	.L881
	ldr	r2, [r2, #8]
	adds	r3, r2, r3
	movs	r2, #0
	strb	r2, [r3, #10]
.L881:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L884:
	.align	2
.L883:
	.word	rfu_CB_pollConnectParent
	.word	.LANCHOR0
	.size	rfu_REQ_endConnectParent, .-rfu_REQ_endConnectParent
	.align	1
	.p2align 2,,3
	.global	rfu_syncVBlank
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_syncVBlank, %function
rfu_syncVBlank:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	push	{r5, r6, r7, lr}
	ldr	r4, .L995
	ldr	r3, [r4]
	ldrb	r1, [r3, #4]
	movs	r0, r1
	ldrb	r2, [r3, #5]
	orrs	r0, r2
	beq	.L886
	movs	r6, #0
	ldr	r5, .L995+4
	ldrh	r0, [r5]
	strh	r6, [r5]
	mov	fp, r0
	ldr	r0, [r4, #8]
	ldrb	r5, [r0, #2]
	mov	r10, r0
	movs	r0, #1
	lsrs	r7, r5, #4
	tst	r0, r1
	beq	.L887
	tst	r0, r5
	bne	.L887
	ldr	r0, [r4, #12]
	mov	r8, r0
	ldrh	r0, [r0, #2]
	mov	ip, r0
	movs	r0, #1
	mov	r9, r0
	add	ip, ip, r9
	mov	r0, r8
	mov	r6, ip
	strh	r6, [r0, #2]
.L887:
	movs	r0, #1
	tst	r0, r2
	beq	.L888
	tst	r0, r7
	bne	.L888
	ldr	r0, [r4, #12]
	mov	r8, r0
	ldrh	r0, [r0, #54]
	mov	ip, r0
	movs	r0, #1
	mov	r9, r0
	add	ip, ip, r9
	mov	r0, r8
	mov	r6, ip
	strh	r6, [r0, #54]
.L888:
	movs	r0, #2
	tst	r0, r1
	beq	.L889
	tst	r0, r5
	bne	.L889
	ldr	r0, [r4, #16]
	mov	r8, r0
	ldrh	r0, [r0, #2]
	mov	ip, r0
	movs	r0, #1
	mov	r9, r0
	add	ip, ip, r9
	mov	r0, r8
	mov	r6, ip
	strh	r6, [r0, #2]
.L889:
	movs	r0, #2
	tst	r0, r2
	beq	.L890
	tst	r0, r7
	bne	.L890
	ldr	r0, [r4, #16]
	mov	r8, r0
	ldrh	r0, [r0, #54]
	mov	ip, r0
	movs	r0, #1
	mov	r9, r0
	add	ip, ip, r9
	mov	r0, r8
	mov	r6, ip
	strh	r6, [r0, #54]
.L890:
	movs	r0, #4
	tst	r0, r1
	beq	.L891
	tst	r0, r5
	bne	.L891
	ldr	r0, [r4, #20]
	mov	r8, r0
	ldrh	r0, [r0, #2]
	mov	ip, r0
	movs	r0, #1
	mov	r9, r0
	add	ip, ip, r9
	mov	r0, r8
	mov	r6, ip
	strh	r6, [r0, #2]
.L891:
	movs	r0, #4
	tst	r0, r2
	beq	.L892
	tst	r0, r7
	bne	.L892
	ldr	r0, [r4, #20]
	mov	r8, r0
	ldrh	r0, [r0, #54]
	mov	ip, r0
	movs	r0, #1
	mov	r9, r0
	add	ip, ip, r9
	mov	r0, r8
	mov	r6, ip
	strh	r6, [r0, #54]
.L892:
	movs	r0, #8
	tst	r0, r1
	beq	.L893
	tst	r0, r5
	bne	.L893
	ldr	r5, [r4, #24]
	ldrh	r1, [r5, #2]
	adds	r1, r1, #1
	strh	r1, [r5, #2]
.L893:
	movs	r1, #8
	tst	r1, r2
	bne	.L987
.L894:
	movs	r2, #0
	mov	r1, r10
	strb	r2, [r1, #2]
	mov	r1, fp
	ldr	r2, .L995+4
	strh	r1, [r2]
.L886:
	ldrb	r3, [r3]
	cmp	r3, #255
	beq	.L896
	ldr	r2, [r4, #8]
	ldrb	r3, [r2, #6]
	cmp	r3, #0
	bne	.L988
	movs	r0, #1
	bl	STWI_read_status
	lsls	r0, r0, #24
	lsrs	r0, r0, #24
	cmp	r0, #1
	beq	.L989
.L898:
	ldr	r2, [r4, #8]
	ldrb	r3, [r2]
	lsls	r1, r3, #30
	bmi	.L906
	cmp	r0, #0
	bne	.L986
.L904:
	movs	r1, #4
	orrs	r3, r1
	adds	r1, r1, #101
	adds	r1, r1, #255
	strb	r3, [r2]
	strh	r1, [r2, #32]
.L905:
	movs	r1, #2
	orrs	r3, r1
.L986:
	movs	r0, #4
	strb	r3, [r2]
	tst	r0, r3
	beq	.L896
	ldrh	r1, [r2, #32]
	cmp	r1, #0
	beq	.L990
	subs	r1, r1, #1
	strh	r1, [r2, #32]
.L896:
	movs	r0, #0
.L914:
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L988:
	subs	r3, r3, #1
	movs	r0, #1
	strb	r3, [r2, #6]
	bl	STWI_read_status
	lsls	r0, r0, #24
	lsrs	r0, r0, #24
	cmp	r0, #1
	bne	.L898
.L989:
	ldr	r3, .L995+8
	ldr	r0, [r3]
	movs	r3, #44
	movs	r1, #2
	ldr	r2, [r4, #8]
	ldrb	r5, [r0, r3]
	ldrb	r3, [r2]
	ands	r1, r3
	cmp	r5, #0
	beq	.L899
	ldrb	r0, [r0, #6]
	cmp	r0, #39
	beq	.L901
	cmp	r0, #55
	beq	.L901
	cmp	r0, #37
	beq	.L901
.L899:
	cmp	r1, #0
	beq	.L986
.L903:
	movs	r1, #6
	bics	r3, r1
	strb	r3, [r2]
	b	.L896
.L906:
	cmp	r0, #0
	beq	.L905
	b	.L903
.L987:
	tst	r1, r7
	bne	.L894
	ldr	r1, [r4, #24]
	ldrh	r2, [r1, #54]
	adds	r2, r2, #1
	strh	r2, [r1, #54]
	b	.L894
.L901:
	cmp	r1, #0
	beq	.L904
	b	.L905
.L990:
	bics	r3, r0
	strb	r3, [r2]
	ldr	r3, [r4]
	ldrb	r5, [r3, #2]
	ldrb	r3, [r3, #3]
	orrs	r5, r3
	lsls	r3, r5, #31
	bmi	.L991
.L910:
	lsls	r3, r5, #30
	bmi	.L992
.L911:
	lsls	r3, r5, #29
	bmi	.L993
.L912:
	lsls	r5, r5, #28
	bmi	.L994
.L913:
	movs	r2, #255
	ldr	r3, [r4]
	movs	r0, #1
	strb	r2, [r3]
	b	.L914
.L991:
	movs	r0, #0
	adds	r1, r1, #1
	bl	rfu_STC_removeLinkData
	b	.L910
.L994:
	movs	r1, #1
	movs	r0, #3
	bl	rfu_STC_removeLinkData
	b	.L913
.L993:
	movs	r1, #1
	movs	r0, #2
	bl	rfu_STC_removeLinkData
	b	.L912
.L992:
	movs	r1, #1
	movs	r0, #1
	bl	rfu_STC_removeLinkData
	b	.L911
.L996:
	.align	2
.L995:
	.word	.LANCHOR0
	.word	67109384
	.word	gSTWIStatus
	.size	rfu_syncVBlank, .-rfu_syncVBlank
	.align	1
	.p2align 2,,3
	.global	rfu_REQBN_watchLink
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQBN_watchLink, %function
rfu_REQBN_watchLink:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	mov	fp, r3
	movs	r3, #0
	push	{r5, r6, r7, lr}
	mov	r8, r2
	strb	r3, [r1]
	strb	r3, [r2]
	mov	r2, fp
	ldr	r6, .L1148
	strb	r3, [r2]
	ldr	r3, [r6]
	ldrb	r2, [r3]
	movs	r7, r1
	sub	sp, sp, #28
	cmp	r2, #255
	beq	.L1054
	ldr	r2, .L1148+4
	ldr	r2, [r2]
	ldrb	r2, [r2, #20]
	cmp	r2, #0
	beq	.L1054
	ldr	r1, [r6, #8]
	ldrb	r2, [r1]
	lsls	r2, r2, #29
	bpl	.L1001
	movs	r2, #180
	lsls	r2, r2, #1
	strh	r2, [r1, #32]
.L1001:
	ldrb	r4, [r1, #6]
	lsls	r2, r0, #24
	lsrs	r2, r2, #24
	cmp	r4, #0
	bne	.L1139
	movs	r4, #4
	strb	r4, [r1, #6]
	cmp	r2, #41
	bne	.LCB6249
	b	.L1003	@long jump
.LCB6249:
	movs	r2, #155
	lsls	r2, r2, #1
	cmp	r0, r2
	bne	.LCB6253
	b	.L1058	@long jump
.LCB6253:
.L1023:
	movs	r3, #1
	str	r3, [sp, #4]
.L1005:
	movs	r4, #220
	ldr	r3, [r6, #4]
	ldr	r3, [r3, r4]
	ldr	r5, .L1148+8
	ldr	r2, [r3]
	ldr	r3, [r3, #4]
	movs	r0, r5
	mov	r10, r2
	str	r3, [sp, #16]
	bl	STWI_set_Callback_M
	bl	STWI_send_LinkStatusREQ
	bl	STWI_poll_CommandEnd
	lsls	r3, r0, #24
	lsrs	r2, r3, #24
	str	r2, [sp, #12]
	cmp	r3, #0
	beq	.LCB6275
	b	.L1024	@long jump
.LCB6275:
	ldr	r3, [r6, #4]
	ldr	r2, [r3, r4]
	ldr	r3, [r6]
	movs	r1, r3
	movs	r0, r2
	adds	r1, r1, #10
	orrs	r0, r1
	lsls	r0, r0, #30
	beq	.LCB6290
	b	.L1025	@long jump
.LCB6290:
	adds	r0, r2, #5
	subs	r0, r1, r0
	cmp	r0, #2
	bhi	.LCB6298
	b	.L1025	@long jump
.LCB6298:
	ldr	r2, [r2, #4]
	str	r2, [r1]
.L1026:
	mov	r2, r8
	movs	r4, #0
	mov	r8, r7
	str	r2, [sp, #20]
.L1052:
	ldr	r1, [r6, #8]
	adds	r1, r1, r4
	ldrb	r2, [r1, #14]
	cmp	r2, #0
	beq	.L1029
	subs	r2, r2, #4
	strb	r2, [r1, #14]
	adds	r2, r3, r4
	ldrb	r0, [r2, #10]
	cmp	r0, #15
	bhi	.L1029
	movs	r0, #16
	strb	r0, [r2, #10]
.L1029:
	movs	r7, #1
	lsls	r7, r7, r4
	ldrb	r2, [r3]
	str	r2, [sp, #8]
	ldr	r2, [sp, #4]
	lsls	r5, r7, #24
	lsrs	r5, r5, #24
	cmp	r2, #1
	bne	.LCB6335
	b	.L1140	@long jump
.LCB6335:
.L1031:
	ldrb	r2, [r3]
	cmp	r2, #1
	beq	.L1039
.L1138:
	ldrb	r2, [r3, #2]
.L1040:
	mov	r1, r8
	ldrb	r1, [r1]
	ands	r1, r5
	tst	r1, r2
	beq	.LCB6351
	b	.L1141	@long jump
.LCB6351:
.L1047:
	adds	r4, r4, #1
	cmp	r4, #4
	bne	.L1052
	ldr	r3, [sp, #12]
	cmp	r3, #0
	beq	.LCB6358
	b	.L1142	@long jump
.LCB6358:
.L1053:
	movs	r3, #220
	ldr	r2, [r6, #4]
	ldr	r3, [r2, r3]
	mov	r2, r10
	str	r2, [r3]
	ldr	r2, [sp, #16]
	str	r2, [r3, #4]
.L1054:
	movs	r4, #0
.L1059:
	movs	r0, r4
	add	sp, sp, #28
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L1139:
	cmp	r2, #41
	beq	.L1003
	movs	r2, #155
	lsls	r2, r2, #1
	cmp	r0, r2
	bne	.L1054
	movs	r0, #0
.L1004:
	movs	r2, #220
	ldr	r1, [r6, #4]
	ldr	r2, [r1, r2]
	ldrb	r3, [r3, #2]
	ldrb	r2, [r2, #5]
	bics	r3, r2
	strb	r3, [r7]
	movs	r1, #1
	mov	r3, r8
	strb	r1, [r3]
	ldrb	r2, [r7]
	ldr	r3, [r6]
	ldr	r4, [r6, #8]
	tst	r1, r2
	beq	.LCB6417
	b	.L1143	@long jump
.LCB6417:
.L1009:
	movs	r1, #2
	tst	r1, r2
	beq	.LCB6424
	b	.L1144	@long jump
.LCB6424:
.L1013:
	movs	r1, #4
	tst	r1, r2
	beq	.LCB6431
	b	.L1145	@long jump
.LCB6431:
.L1017:
	movs	r1, #8
	tst	r1, r2
	beq	.LCB6438
	b	.L1146	@long jump
.LCB6438:
.L1020:
	cmp	r0, #0
	beq	.LCB6441
	b	.L1023	@long jump
.LCB6441:
	b	.L1054
.L1039:
	adds	r2, r3, r4
	mov	r9, r2
	ldrb	r2, [r2, #10]
	mov	ip, r2
	cmp	r2, #0
	beq	.L1138
.L1037:
	ldrb	r1, [r3, #3]
	tst	r5, r1
	beq	.L1041
	mov	r2, ip
	cmp	r2, #10
	bhi	.LCB6461
	b	.L1042	@long jump
.LCB6461:
	mov	r3, fp
	mov	r2, fp
	movs	r0, #0
	ldrb	r3, [r3]
	orrs	r3, r5
	strb	r3, [r2]
	ldr	r3, [r6]
	ldrb	r1, [r3, #3]
	bics	r1, r7
	ldrb	r2, [r3, #2]
	strb	r1, [r3, #3]
	ldrb	r1, [r3, #1]
	orrs	r2, r5
	adds	r1, r1, #1
	strb	r2, [r3, #2]
	strb	r1, [r3, #1]
	ldr	r1, [r6, #8]
	adds	r1, r1, r4
	strb	r0, [r1, #10]
	b	.L1040
.L1003:
	movs	r3, #220
	ldr	r2, [r6, #4]
	ldr	r3, [r2, r3]
	ldrb	r2, [r3, #4]
	strb	r2, [r7]
	mov	r2, r8
	ldrb	r3, [r3, #5]
	strb	r3, [r2]
	cmp	r3, #1
	bne	.L1006
	ldr	r3, [r6]
	ldrb	r3, [r3, #2]
	strb	r3, [r7]
.L1006:
	movs	r3, #2
	str	r3, [sp, #4]
	b	.L1005
.L1140:
	ldrb	r2, [r3, #2]
	tst	r5, r2
	bne	.LCB6514
	b	.L1031	@long jump
.LCB6514:
	adds	r0, r3, r4
	mov	r9, r0
	ldrb	r0, [r0, #10]
	mov	ip, r0
	cmp	r0, #0
	bne	.L1032
	ldr	r2, [sp, #8]
	cmp	r2, #1
	beq	.LCB6523
	b	.L1033	@long jump
.LCB6523:
	ldrb	r2, [r1, #10]
	adds	r2, r2, #1
	lsls	r2, r2, #24
	lsrs	r2, r2, #24
	strb	r2, [r1, #10]
	cmp	r2, #3
	bhi	.LCB6530
	b	.L1138	@long jump
.LCB6530:
.L1135:
	mov	r3, r8
	mov	r2, r8
	ldrb	r3, [r3]
	orrs	r3, r5
	strb	r3, [r2]
	ldr	r3, [sp, #20]
	ldr	r2, [sp, #4]
	strb	r2, [r3]
.L1136:
	ldr	r3, [r6]
	b	.L1031
.L1141:
	movs	r0, #0
	ldr	r1, [r6, #8]
	adds	r1, r1, r4
	strb	r0, [r1, #14]
	tst	r2, r5
	bne	.L1055
.L1048:
	ldrb	r1, [r3, #3]
	orrs	r1, r5
	strb	r1, [r3, #3]
	ldrb	r1, [r3]
	bics	r2, r7
	strb	r2, [r3, #2]
	orrs	r2, r1
	beq	.LCB6570
	b	.L1047	@long jump
.LCB6570:
	adds	r2, r2, #255
	strb	r2, [r3]
	b	.L1047
.L1032:
	movs	r0, #0
	strb	r0, [r1, #10]
	ldr	r1, [sp, #8]
	cmp	r1, #1
	beq	.L1037
	mov	r1, r8
	ldrb	r1, [r1]
	ands	r1, r5
	tst	r1, r2
	bne	.LCB6590
	b	.L1047	@long jump
.LCB6590:
	movs	r0, #0
	ldr	r1, [r6, #8]
	adds	r1, r1, r4
	strb	r0, [r1, #14]
.L1055:
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	beq	.L1048
	subs	r1, r1, #1
	strb	r1, [r3, #1]
	b	.L1048
.L1041:
	ldrb	r2, [r3, #2]
	orrs	r1, r2
	tst	r1, r5
	beq	.LCB6612
	b	.L1040	@long jump
.LCB6612:
	bl	STWI_send_SlotStatusREQ
	bl	STWI_poll_CommandEnd
	movs	r3, #220
	ldr	r2, [r6, #4]
	ldr	r2, [r2, r3]
	ldrb	r1, [r2, #1]
	subs	r1, r1, #1
	lsls	r1, r1, #24
	lsrs	r3, r1, #24
	adds	r2, r2, #8
	cmp	r1, #0
	bne	.LCB6624
	b	.L1137	@long jump
.LCB6624:
	lsls	r1, r4, #24
	lsrs	r1, r1, #24
	str	r1, [sp, #8]
	movs	r1, #8
	mov	ip, r1
	add	ip, ip, r4
	mov	r1, ip
	lsls	r1, r1, #1
	mov	ip, r1
	ldr	r0, [r6, #8]
	add	r0, r0, ip
	adds	r1, r0, #2
	mov	ip, r1
	mov	r0, ip
	mov	r9, r5
	mov	ip, r4
	ldr	r1, [sp, #8]
	movs	r4, r3
	movs	r3, r0
	b	.L1045
.L1044:
	subs	r4, r4, #1
	lsls	r0, r4, #24
	adds	r2, r2, #4
	lsrs	r4, r0, #24
	cmp	r0, #0
	bne	.LCB6655
	b	.L1147	@long jump
.LCB6655:
.L1045:
	ldrb	r0, [r2, #2]
	cmp	r0, r1
	bne	.L1044
	ldrh	r5, [r3]
	ldrh	r0, [r2]
	cmp	r5, r0
	bne	.L1044
	mov	r5, r9
	ldr	r3, [sp, #12]
	orrs	r3, r5
	str	r3, [sp, #12]
	ldr	r3, [r6]
	mov	r4, ip
	ldrb	r2, [r3, #2]
	b	.L1040
.L1142:
	movs	r0, r3
	bl	STWI_send_DisconnectREQ
	bl	STWI_poll_CommandEnd
	b	.L1053
.L1024:
	movs	r4, #255
	ands	r4, r0
	movs	r0, r5
	bl	STWI_set_Callback_M
	ldr	r3, [r6, #8]
	strh	r4, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bmi	.LCB6698
	b	.L1059	@long jump
.LCB6698:
	ldr	r3, [r6, #4]
	movs	r1, r4
	movs	r0, #17
	ldr	r3, [r3]
	bl	.L67
	b	.L1059
.L1025:
	ldrb	r1, [r2, #4]
	strb	r1, [r3, #10]
	ldrb	r1, [r2, #5]
	strb	r1, [r3, #11]
	ldrb	r1, [r2, #6]
	strb	r1, [r3, #12]
	ldrb	r2, [r2, #7]
	strb	r2, [r3, #13]
	b	.L1026
.L1058:
	movs	r0, #1
	b	.L1004
.L1042:
	movs	r2, #0
	mov	r1, r9
	strb	r2, [r1, #10]
	ldrb	r2, [r3, #2]
	b	.L1040
.L1149:
	.align	2
.L1148:
	.word	.LANCHOR0
	.word	gSTWIStatus
	.word	rfu_CB_defaultCallback
.L1033:
	bl	STWI_send_SystemStatusREQ
	bl	STWI_poll_CommandEnd
	cmp	r0, #0
	beq	.LCB6744
	b	.L1136	@long jump
.LCB6744:
	movs	r3, #220
	ldr	r2, [r6, #4]
	ldr	r3, [r2, r3]
	ldrb	r3, [r3, #7]
	cmp	r3, #0
	bne	.LCB6750
	b	.L1135	@long jump
.LCB6750:
	ldr	r3, [r6, #8]
	mov	ip, r3
	adds	r1, r3, r4
	ldrb	r2, [r1, #10]
	adds	r2, r2, #1
	lsls	r2, r2, #24
	lsrs	r3, r2, #24
	mov	r2, ip
	mov	r9, r3
	strb	r3, [r1, #10]
	ldrh	r2, [r2, #26]
	ldr	r3, [r6]
	cmp	r2, r9
	bcc	.LCB6764
	b	.L1031	@long jump
.LCB6764:
	strb	r0, [r1, #10]
	ldrb	r0, [r3, #2]
	bl	STWI_send_DisconnectREQ
	bl	STWI_poll_CommandEnd
	b	.L1135
.L1146:
	movs	r2, #0
	strb	r2, [r3, #13]
	strb	r2, [r4, #17]
	ldrb	r2, [r3, #2]
	tst	r1, r2
	beq	.L1021
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	beq	.L1021
	subs	r1, r1, #1
	strb	r1, [r3, #1]
.L1021:
	movs	r1, #8
	movs	r4, #8
	bics	r2, r1
	ldrb	r1, [r3, #3]
	orrs	r1, r4
	strb	r1, [r3, #3]
	ldrb	r1, [r3]
	strb	r2, [r3, #2]
	orrs	r2, r1
	beq	.LCB6803
	b	.L1020	@long jump
.LCB6803:
	adds	r2, r2, #255
	strb	r2, [r3]
	b	.L1020
.L1143:
	movs	r2, #0
	strb	r2, [r3, #10]
	strb	r2, [r4, #14]
	ldrb	r2, [r3, #2]
	tst	r1, r2
	beq	.L1010
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	beq	.L1010
	subs	r1, r1, #1
	strb	r1, [r3, #1]
.L1010:
	movs	r1, #1
	movs	r5, #1
	bics	r2, r1
	ldrb	r1, [r3, #3]
	orrs	r1, r5
	strb	r1, [r3, #3]
	ldrb	r1, [r3]
	strb	r2, [r3, #2]
	orrs	r2, r1
	beq	.L1125
	ldrb	r2, [r7]
	b	.L1009
.L1125:
	movs	r2, #255
	strb	r2, [r3]
	ldrb	r2, [r7]
	b	.L1009
.L1145:
	movs	r2, #0
	strb	r2, [r3, #12]
	strb	r2, [r4, #16]
	ldrb	r2, [r3, #2]
	tst	r1, r2
	beq	.L1018
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	beq	.L1018
	subs	r1, r1, #1
	strb	r1, [r3, #1]
.L1018:
	movs	r1, #4
	movs	r5, #4
	bics	r2, r1
	ldrb	r1, [r3, #3]
	orrs	r1, r5
	strb	r1, [r3, #3]
	ldrb	r1, [r3]
	strb	r2, [r3, #2]
	orrs	r2, r1
	beq	.L1127
	ldrb	r2, [r7]
	b	.L1017
.L1127:
	movs	r2, #255
	strb	r2, [r3]
	ldrb	r2, [r7]
	b	.L1017
.L1144:
	movs	r2, #0
	strb	r2, [r3, #11]
	strb	r2, [r4, #15]
	ldrb	r2, [r3, #2]
	tst	r1, r2
	beq	.L1014
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	beq	.L1014
	subs	r1, r1, #1
	strb	r1, [r3, #1]
.L1014:
	movs	r1, #2
	movs	r5, #2
	bics	r2, r1
	ldrb	r1, [r3, #3]
	orrs	r1, r5
	strb	r1, [r3, #3]
	ldrb	r1, [r3]
	strb	r2, [r3, #2]
	orrs	r2, r1
	beq	.L1126
	ldrb	r2, [r7]
	b	.L1013
.L1126:
	movs	r2, #255
	strb	r2, [r3]
	ldrb	r2, [r7]
	b	.L1013
.L1147:
	mov	r5, r9
	mov	r4, ip
.L1137:
	ldr	r3, [r6]
	b	.L1138
	.size	rfu_REQBN_watchLink, .-rfu_REQBN_watchLink
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_disconnect
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_disconnect, %function
rfu_REQ_disconnect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldr	r5, .L1171
	ldr	r2, [r5]
	ldrb	r1, [r2, #3]
	ldrb	r3, [r2, #2]
	orrs	r3, r1
	movs	r4, r0
	tst	r3, r0
	beq	.L1150
	ldr	r3, [r5, #8]
	strb	r0, [r3, #5]
	ldrb	r2, [r2]
	cmp	r2, #255
	beq	.L1169
.L1153:
	ldrb	r3, [r3, #9]
	cmp	r3, #0
	beq	.L1155
	ldr	r7, .L1171+4
	movs	r0, r7
	bl	STWI_set_Callback_M
	bl	STWI_send_SC_EndREQ
	bl	STWI_poll_CommandEnd
	subs	r6, r0, #0
	bne	.L1170
.L1155:
	ldr	r0, .L1171+8
	bl	STWI_set_Callback_M
	movs	r0, r4
	bl	STWI_send_DisconnectREQ
.L1150:
	@ sp needed
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L1169:
	ldrb	r2, [r3]
	cmp	r2, #127
	bls	.L1153
	tst	r0, r1
	beq	.L1150
	movs	r1, #0
	movs	r0, #48
	bl	rfu_CB_disconnect
	b	.L1150
.L1170:
	movs	r0, r7
	bl	STWI_set_Callback_M
	ldr	r3, [r5, #8]
	strh	r6, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L1150
	ldr	r3, [r5, #4]
	movs	r1, r6
	movs	r0, #27
	ldr	r3, [r3]
	bl	.L67
	b	.L1150
.L1172:
	.align	2
.L1171:
	.word	.LANCHOR0
	.word	rfu_CB_defaultCallback
	.word	rfu_CB_disconnect
	.size	rfu_REQ_disconnect, .-rfu_REQ_disconnect
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_CHILD_startConnectRecovery
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_CHILD_startConnectRecovery, %function
rfu_REQ_CHILD_startConnectRecovery:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r6, .L1180
	ldr	r3, [r6, #8]
	movs	r4, r0
	strb	r0, [r3, #5]
	lsls	r3, r0, #31
	bmi	.L1176
	lsls	r3, r0, #30
	bmi	.L1177
	lsls	r3, r0, #29
	bmi	.L1178
	movs	r5, #8
	ands	r5, r0
	rsbs	r3, r5, #0
	adcs	r5, r5, r3
	adds	r5, r5, #3
.L1174:
	ldr	r0, .L1180+4
	@ sp needed
	bl	STWI_set_Callback_M
	movs	r3, #140
	ldr	r2, [r6]
	ldrh	r1, [r2, r3]
	lsls	r3, r5, #4
	subs	r3, r3, r5
	lsls	r3, r3, #1
	adds	r2, r2, r3
	ldrh	r0, [r2, #20]
	movs	r2, r4
	bl	STWI_send_CPR_StartREQ
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L1176:
	movs	r5, #0
	b	.L1174
.L1177:
	movs	r5, #1
	b	.L1174
.L1178:
	movs	r5, #2
	b	.L1174
.L1181:
	.align	2
.L1180:
	.word	.LANCHOR0
	.word	rfu_STC_REQ_callback
	.size	rfu_REQ_CHILD_startConnectRecovery, .-rfu_REQ_CHILD_startConnectRecovery
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_CHILD_pollConnectRecovery
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_CHILD_pollConnectRecovery, %function
rfu_REQ_CHILD_pollConnectRecovery:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L1183
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_CPR_PollingREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L1184:
	.align	2
.L1183:
	.word	rfu_CB_CHILD_pollConnectRecovery
	.size	rfu_REQ_CHILD_pollConnectRecovery, .-rfu_REQ_CHILD_pollConnectRecovery
	.align	1
	.p2align 2,,3
	.global	rfu_CHILD_getConnectRecoveryStatus
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_CHILD_getConnectRecoveryStatus, %function
rfu_CHILD_getConnectRecoveryStatus:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r3, #255
	strb	r3, [r0]
	ldr	r3, .L1188
	ldr	r1, [r3, #4]
	movs	r3, #220
	ldr	r1, [r1, r3]
	ldrb	r3, [r1]
	adds	r3, r3, #77
	lsls	r3, r3, #24
	movs	r2, r0
	lsrs	r3, r3, #24
	movs	r0, #16
	cmp	r3, #1
	bhi	.L1186
	movs	r0, #0
	ldrb	r3, [r1, #4]
	strb	r3, [r2]
.L1186:
	@ sp needed
	bx	lr
.L1189:
	.align	2
.L1188:
	.word	.LANCHOR0
	.size	rfu_CHILD_getConnectRecoveryStatus, .-rfu_CHILD_getConnectRecoveryStatus
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_CHILD_endConnectRecovery
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_CHILD_endConnectRecovery, %function
rfu_REQ_CHILD_endConnectRecovery:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L1191
	@ sp needed
	bl	STWI_set_Callback_M
	bl	STWI_send_CPR_EndREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L1192:
	.align	2
.L1191:
	.word	rfu_CB_CHILD_pollConnectRecovery
	.size	rfu_REQ_CHILD_endConnectRecovery, .-rfu_REQ_CHILD_endConnectRecovery
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_changeMasterSlave
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_changeMasterSlave, %function
rfu_REQ_changeMasterSlave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r0, #1
	bl	STWI_read_status
	cmp	r0, #1
	beq	.L1200
	ldr	r0, .L1201
	bl	STWI_set_Callback_M
	movs	r1, #0
	ldr	r2, .L1201+4
	ldr	r3, [r2, #8]
	strh	r1, [r3, #28]
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.L1193
	ldr	r3, [r2, #4]
	movs	r0, #39
	ldr	r3, [r3]
	bl	.L67
.L1193:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L1200:
	ldr	r0, .L1201+8
	bl	STWI_set_Callback_M
	bl	STWI_send_MS_ChangeREQ
	b	.L1193
.L1202:
	.align	2
.L1201:
	.word	rfu_CB_defaultCallback
	.word	.LANCHOR0
	.word	rfu_STC_REQ_callback
	.size	rfu_REQ_changeMasterSlave, .-rfu_REQ_changeMasterSlave
	.align	1
	.p2align 2,,3
	.global	rfu_getMasterSlave
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_getMasterSlave, %function
rfu_getMasterSlave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r0, #1
	push	{r4, lr}
	bl	STWI_read_status
	lsls	r0, r0, #24
	lsrs	r0, r0, #24
	cmp	r0, #1
	beq	.L1208
.L1204:
	@ sp needed
	pop	{r4}
	pop	{r1}
	bx	r1
.L1208:
	movs	r2, #44
	ldr	r3, .L1209
	ldr	r3, [r3]
	ldrb	r2, [r3, r2]
	cmp	r2, #0
	beq	.L1204
	ldrb	r3, [r3, #6]
	subs	r3, r3, #37
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	cmp	r3, #18
	bhi	.L1204
	ldr	r2, .L1209+4
	lsrs	r2, r2, r3
	movs	r3, #1
	ands	r0, r2
	eors	r0, r3
	b	.L1204
.L1210:
	.align	2
.L1209:
	.word	gSTWIStatus
	.word	262149
	.size	rfu_getMasterSlave, .-rfu_getMasterSlave
	.align	1
	.p2align 2,,3
	.global	rfu_clearAllSlot
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_clearAllSlot, %function
rfu_clearAllSlot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r10
	mov	r6, r9
	mov	r5, r8
	mov	lr, fp
	push	{r5, r6, r7, lr}
	ldr	r3, .L1214
	ldrh	r2, [r3]
	sub	sp, sp, #20
	str	r2, [sp, #4]
	movs	r2, #0
	strh	r2, [r3]
	ldr	r3, .L1214+4
	mov	r10, r3
	movs	r3, #12
	add	r3, r3, r10
	mov	r9, r3
	movs	r3, #28
	movs	r4, #0
	movs	r5, #0
	add	r3, r3, r10
	mov	r8, r3
	add	r3, sp, #8
	add	r7, sp, #12
	adds	r6, r3, #6
.L1212:
	movs	r3, #0
	mov	fp, r3
	mov	r3, r9
	ldmia	r3!, {r1}
	movs	r0, r7
	ldr	r2, .L1214+8
	mov	r9, r3
	strh	r5, [r7]
	bl	CpuSet
	mov	r3, r8
	ldmia	r3!, {r1}
	ldr	r2, .L1214+12
	movs	r0, r6
	mov	r8, r3
	strh	r5, [r6]
	bl	CpuSet
	mov	r3, r10
	movs	r1, #16
	ldr	r3, [r3]
	adds	r2, r3, r4
	adds	r4, r4, #1
	strb	r1, [r2, #16]
	cmp	r4, #4
	bne	.L1212
	movs	r2, #87
	strb	r2, [r3, #15]
	mov	r2, fp
	strh	r5, [r3, #4]
	strb	r2, [r3, #6]
	mov	r3, r10
	ldr	r3, [r3, #8]
	strb	r2, [r3, #2]
	ldr	r3, .L1214
	ldr	r2, [sp, #4]
	strh	r2, [r3]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L1215:
	.align	2
.L1214:
	.word	67109384
	.word	.LANCHOR0
	.word	16777268
	.word	16777226
	.size	rfu_clearAllSlot, .-rfu_clearAllSlot
	.align	1
	.p2align 2,,3
	.global	rfu_clearSlot
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_clearSlot, %function
rfu_clearSlot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r8
	push	{lr}
	movs	r4, r0
	movs	r5, r1
	sub	sp, sp, #8
	cmp	r1, #3
	bhi	.L1236
	lsls	r3, r0, #28
	bne	.LCB7398
	b	.L1237	@long jump
.LCB7398:
	movs	r2, #0
	ldr	r3, .L1256
	ldrh	r6, [r3]
	strh	r2, [r3]
	movs	r3, #12
	tst	r3, r0
	beq	.L1230
	movs	r7, #8
	ands	r7, r0
	lsls	r3, r0, #29
	bmi	.L1252
.L1221:
	cmp	r7, #0
	beq	.L1230
	movs	r0, #1
	ldr	r3, .L1256+4
	lsls	r2, r5, #2
	adds	r2, r3, r2
	ldr	r1, [r2, #12]
	ldr	r2, [r3]
	lsls	r0, r0, r5
	mov	ip, r2
	ldrb	r2, [r2, #5]
	bics	r2, r0
	mov	r0, ip
	strb	r2, [r0, #5]
	movs	r2, #1
	mov	r8, r2
	adds	r1, r1, #52
.L1222:
	movs	r0, #0
	ldrsh	r2, [r1, r0]
	cmp	r2, #0
	blt	.L1253
.L1224:
	mov	r3, sp
	adds	r0, r3, #2
	movs	r3, #0
	ldr	r2, .L1256+8
	strh	r3, [r0]
	bl	CpuSet
	mov	r3, r8
	cmp	r3, #1
	bne	.L1221
.L1230:
	lsls	r3, r4, #31
	bpl	.L1220
	ldr	r2, .L1256+4
	lsls	r3, r5, #2
	adds	r3, r2, r3
	ldr	r1, [r3, #28]
	movs	r0, #0
	ldrsh	r3, [r1, r0]
	cmp	r3, #0
	blt	.L1254
	movs	r3, #0
	add	r0, sp, #4
	ldr	r2, .L1256+12
	strh	r3, [r0]
	bl	CpuSet
.L1220:
	lsls	r4, r4, #30
	bmi	.L1255
.L1235:
	movs	r0, #0
	ldr	r3, .L1256
	strh	r6, [r3]
.L1217:
	add	sp, sp, #8
	@ sp needed
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L1255:
	mov	r3, sp
	adds	r0, r3, #6
	movs	r3, #0
	strh	r3, [r0]
	ldr	r3, .L1256+4
	lsls	r5, r5, #2
	adds	r3, r3, r5
	ldr	r1, [r3, #28]
	ldr	r2, .L1256+16
	adds	r1, r1, #12
	bl	CpuSet
	b	.L1235
.L1236:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1217
.L1252:
	ldr	r3, .L1256+4
	lsls	r2, r1, #2
	adds	r2, r3, r2
	ldr	r1, [r2, #12]
	ldr	r2, [r3]
	mov	r8, r2
	movs	r2, #44
	ldrb	r2, [r1, r2]
	mov	ip, r2
	mov	r2, r8
	mov	r0, ip
	ldrb	r2, [r2, #4]
	bics	r2, r0
	mov	r0, r8
	strb	r2, [r0, #4]
	movs	r2, #0
	mov	r8, r2
	b	.L1222
.L1254:
	ldr	r3, [r2]
	ldr	r2, [r2, #8]
	ldrb	r2, [r2]
	ldrb	r0, [r1, #4]
	cmp	r2, #127
	bhi	.L1233
	ldrb	r2, [r3, #15]
	adds	r2, r2, #3
	adds	r2, r0, r2
	strb	r2, [r3, #15]
.L1234:
	ldrb	r0, [r1, #3]
	ldrb	r2, [r3, #6]
	bics	r2, r0
	strb	r2, [r3, #6]
	movs	r3, #0
	add	r0, sp, #4
	ldr	r2, .L1256+12
	strh	r3, [r0]
	bl	CpuSet
	b	.L1220
.L1237:
	movs	r0, #192
	lsls	r0, r0, #3
	b	.L1217
.L1253:
	ldr	r2, [r3]
	ldr	r3, [r3, #8]
	ldrb	r3, [r3]
	cmp	r3, #127
	bhi	.L1225
	mov	r0, r8
	ldrb	r3, [r2, #15]
	cmp	r0, #0
	bne	.L1226
	ldrh	r0, [r1, #46]
	adds	r3, r3, r0
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
.L1226:
	adds	r3, r3, #3
	strb	r3, [r2, #15]
.L1227:
	movs	r3, #44
	ldrb	r3, [r1, r3]
	cmp	r3, #0
	bne	.LCB7600
	b	.L1224	@long jump
.LCB7600:
	movs	r3, #0
	strh	r3, [r1, #2]
	b	.L1224
.L1233:
	adds	r7, r3, r5
	ldrb	r2, [r7, #16]
	adds	r2, r2, #2
	adds	r0, r0, r2
	strb	r0, [r7, #16]
	b	.L1234
.L1225:
	mov	r0, r8
	adds	r2, r2, r5
	ldrb	r3, [r2, #16]
	cmp	r0, #0
	bne	.L1228
	ldrh	r0, [r1, #46]
	adds	r3, r3, r0
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
.L1228:
	adds	r3, r3, #2
	strb	r3, [r2, #16]
	b	.L1227
.L1257:
	.align	2
.L1256:
	.word	67109384
	.word	.LANCHOR0
	.word	16777242
	.word	16777222
	.word	16777220
	.size	rfu_clearSlot, .-rfu_clearSlot
	.align	1
	.p2align 2,,3
	.global	rfu_setRecvBuffer
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_setRecvBuffer, %function
rfu_setRecvBuffer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	cmp	r1, #3
	bhi	.L1262
	lsls	r4, r0, #26
	bmi	.L1264
	lsls	r0, r0, #27
	bpl	.L1263
	ldr	r0, .L1265
	lsls	r1, r1, #2
	adds	r0, r0, r1
	ldr	r1, [r0, #28]
	str	r2, [r1, #20]
	str	r3, [r1, #24]
.L1261:
	movs	r0, #0
.L1259:
	@ sp needed
	pop	{r4}
	pop	{r1}
	bx	r1
.L1264:
	ldr	r0, .L1265
	lsls	r1, r1, #2
	adds	r0, r0, r1
	ldr	r1, [r0, #12]
	str	r2, [r1, #104]
	str	r3, [r1, #108]
	b	.L1261
.L1262:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1259
.L1263:
	movs	r0, #192
	lsls	r0, r0, #3
	b	.L1259
.L1266:
	.align	2
.L1265:
	.word	.LANCHOR0
	.size	rfu_setRecvBuffer, .-rfu_setRecvBuffer
	.align	1
	.p2align 2,,3
	.global	rfu_NI_setSendData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_NI_setSendData, %function
rfu_NI_setSendData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r9
	mov	r5, r8
	mov	lr, fp
	mov	r7, r10
	push	{r5, r6, r7, lr}
	ldr	r6, .L1309
	ldr	r4, [r6]
	ldrb	r5, [r4]
	sub	sp, sp, #20
	mov	ip, r5
	str	r3, [sp]
	cmp	r5, #255
	bne	.LCB7725
	b	.L1280	@long jump
.LCB7725:
	lsls	r5, r0, #28
	bne	.LCB7731
	b	.L1281	@long jump
.LCB7731:
	ldrb	r5, [r4, #2]
	ldrb	r7, [r4, #3]
	orrs	r5, r7
	ands	r5, r0
	cmp	r0, r5
	bne	.L1282
	ldrb	r5, [r4, #4]
	mov	r8, r5
	tst	r5, r0
	beq	.LCB7746
	b	.L1283	@long jump
.LCB7746:
	movs	r5, #1
	movs	r7, r5
	ands	r7, r0
	str	r7, [sp, #8]
	tst	r5, r0
	beq	.LCB7754
	b	.L1284	@long jump
.LCB7754:
	lsls	r5, r0, #30
	bpl	.LCB7760
	b	.L1285	@long jump
.LCB7760:
	lsls	r5, r0, #29
	bpl	.LCB7766
	b	.L1286	@long jump
.LCB7766:
	movs	r5, #8
	ands	r5, r0
	rsbs	r7, r5, #0
	adcs	r5, r5, r7
	adds	r3, r5, #3
	str	r3, [sp, #4]
.L1269:
	mov	r7, ip
	cmp	r7, #1
	bne	.LCB7778
	b	.L1308	@long jump
.LCB7778:
	mov	r3, ip
	cmp	r7, #0
	beq	.L1273
	ldr	r7, .L1309+4
	lsls	r3, r3, #4
	ldrb	r7, [r3, r7]
	movs	r3, #0
	mov	ip, r3
.L1274:
	cmp	r1, r7
	bls	.L1289
	ldr	r3, .L1309+8
	mov	fp, r3
	ldrh	r3, [r3]
	str	r3, [sp, #12]
	movs	r3, #0
	mov	r9, r3
	mov	r3, fp
	mov	r5, r9
	strh	r5, [r3]
	ldr	r3, [sp, #4]
	lsls	r5, r3, #2
	mov	r3, r9
	adds	r5, r6, r5
	ldr	r5, [r5, #12]
	strh	r3, [r5, #24]
	adds	r3, r3, #45
	mov	fp, r3
	add	fp, fp, r5
	mov	r3, fp
	str	r3, [r5, #4]
	movs	r3, #7
	subs	r7, r1, r7
	str	r3, [r5, #20]
	adds	r3, r3, #37
	strb	r0, [r5, r3]
	strh	r7, [r5, #46]
	mov	r3, r9
	movs	r7, #45
	strb	r0, [r5, #26]
	strb	r3, [r5, r7]
	ldr	r3, [sp]
	str	r3, [r5, #48]
	mov	r3, r9
	strb	r3, [r5, #27]
	mov	r3, r9
	str	r3, [r5, #28]
	ldr	r3, .L1309+12
	str	r2, [r5, #40]
	str	r3, [r5, #32]
	movs	r2, #1
	movs	r3, #36
	strb	r2, [r5, r3]
	ldr	r3, [sp, #8]
	cmp	r3, #0
	beq	.L1275
	mov	r2, r9
	ldr	r3, [r6, #12]
	strh	r2, [r3, #2]
.L1275:
	lsls	r3, r0, #30
	bpl	.L1276
	movs	r2, #0
	ldr	r3, [r6, #16]
	strh	r2, [r3, #2]
.L1276:
	lsls	r3, r0, #29
	bpl	.L1277
	movs	r2, #0
	ldr	r3, [r6, #20]
	strh	r2, [r3, #2]
.L1277:
	lsls	r3, r0, #28
	bpl	.L1278
	movs	r2, #0
	ldr	r3, [r6, #24]
	strh	r2, [r3, #2]
.L1278:
	mov	r3, r8
	orrs	r0, r3
	mov	r3, ip
	strb	r0, [r4, #4]
	cmp	r3, #0
	beq	.L1279
	mov	r2, ip
	ldrb	r3, [r3]
	subs	r3, r3, r1
	strb	r3, [r2]
.L1279:
	ldr	r3, .L1309+16
	ldr	r2, [sp, #12]
	strh	r3, [r5]
	ldr	r3, .L1309+8
	movs	r0, #0
	strh	r2, [r3]
	b	.L1268
.L1282:
	ldr	r0, .L1309+20
.L1268:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L1273:
	ldr	r5, [sp, #4]
	adds	r5, r5, #16
	mov	ip, r5
	movs	r7, #2
	add	ip, ip, r4
.L1272:
	mov	r3, ip
	ldrb	r3, [r3]
	cmp	r3, r1
	bcs	.L1274
.L1289:
	movs	r0, #160
	lsls	r0, r0, #3
	b	.L1268
.L1281:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1268
.L1280:
	ldr	r0, .L1309+24
	b	.L1268
.L1308:
	movs	r3, #15
	mov	ip, r3
	adds	r7, r7, #2
	add	ip, ip, r4
	b	.L1272
.L1283:
	ldr	r0, .L1309+28
	b	.L1268
.L1284:
	movs	r3, #0
	str	r3, [sp, #4]
	b	.L1269
.L1285:
	movs	r3, #1
	str	r3, [sp, #4]
	b	.L1269
.L1286:
	movs	r3, #2
	str	r3, [sp, #4]
	b	.L1269
.L1310:
	.align	2
.L1309:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	67109384
	.word	16843008
	.word	-32735
	.word	1025
	.word	769
	.word	1026
	.size	rfu_NI_setSendData, .-rfu_NI_setSendData
	.align	1
	.p2align 2,,3
	.global	rfu_UNI_setSendData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_UNI_setSendData, %function
rfu_UNI_setSendData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r9
	mov	r7, r8
	ldr	r6, .L1343
	ldr	r3, [r6]
	ldrb	r5, [r3]
	push	{r7, lr}
	cmp	r5, #1
	beq	.L1339
	cmp	r5, #255
	beq	.L1324
	adds	r2, r2, #2
	lsls	r2, r2, #24
	lsrs	r2, r2, #24
	lsls	r4, r0, #28
	beq	.L1325
.L1342:
	ldrb	r4, [r3, #2]
	ldrb	r7, [r3, #3]
	orrs	r4, r7
	ands	r4, r0
	cmp	r0, r4
	bne	.L1326
	ldrb	r4, [r3, #6]
	tst	r4, r0
	bne	.L1327
	lsls	r4, r0, #31
	bmi	.L1328
	lsls	r4, r0, #30
	bmi	.L1329
	lsls	r4, r0, #29
	bmi	.L1330
	movs	r7, #8
	ands	r7, r0
	rsbs	r4, r7, #0
	adcs	r7, r7, r4
	adds	r7, r7, #3
.L1315:
	cmp	r5, #1
	beq	.L1340
	cmp	r5, #0
	bne	.L1341
	movs	r4, r7
	mov	ip, r3
	movs	r5, #2
	movs	r3, #2
	adds	r4, r4, #16
	add	ip, ip, r4
.L1318:
	mov	r4, ip
	ldrb	r4, [r4]
	cmp	r4, r2
	bcc	.L1334
	cmp	r5, r2
	bcs	.L1334
	ldr	r4, .L1343+4
	ldrh	r5, [r4]
	mov	r9, r5
	movs	r5, #0
	lsls	r7, r7, #2
	adds	r7, r6, r7
	strh	r5, [r4]
	ldr	r4, [r7, #28]
	subs	r3, r2, r3
	strh	r3, [r4, #4]
	mov	r3, ip
	strb	r0, [r4, #3]
	str	r1, [r4, #8]
	ldrb	r3, [r3]
	subs	r3, r3, r2
	mov	r2, ip
	strb	r3, [r2]
	ldr	r3, [r6]
	b	.L1322
.L1339:
	adds	r2, r2, #3
	lsls	r2, r2, #24
	lsrs	r2, r2, #24
	lsls	r4, r0, #28
	bne	.L1342
.L1325:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1337
.L1326:
	ldr	r0, .L1343+8
.L1337:
	@ sp needed
	pop	{r6, r7}
	mov	r9, r7
	mov	r8, r6
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L1324:
	ldr	r0, .L1343+12
	b	.L1337
.L1341:
	ldr	r4, .L1343+16
	lsls	r5, r5, #4
	ldrb	r4, [r5, r4]
	mov	ip, r4
	cmp	r4, r2
	bcs	.L1334
	ldr	r4, .L1343+4
	ldrh	r5, [r4]
	mov	r9, r5
	movs	r5, #0
	lsls	r7, r7, #2
	adds	r6, r6, r7
	strh	r5, [r4]
	ldr	r4, [r6, #28]
	str	r1, [r4, #8]
	mov	r1, ip
	subs	r2, r2, r1
	strb	r0, [r4, #3]
	strh	r2, [r4, #4]
.L1322:
	ldr	r2, .L1343+20
	strh	r2, [r4]
	ldrb	r2, [r3, #6]
	orrs	r2, r0
	strb	r2, [r3, #6]
	mov	r2, r9
	ldr	r3, .L1343+4
	movs	r0, #0
	strh	r2, [r3]
	b	.L1337
.L1340:
	movs	r4, #15
	mov	ip, r4
	adds	r5, r5, #2
	add	ip, ip, r3
	movs	r3, #3
	b	.L1318
.L1334:
	movs	r0, #160
	lsls	r0, r0, #3
	b	.L1337
.L1327:
	ldr	r0, .L1343+24
	b	.L1337
.L1328:
	movs	r7, #0
	b	.L1315
.L1329:
	movs	r7, #1
	b	.L1315
.L1330:
	movs	r7, #2
	b	.L1315
.L1344:
	.align	2
.L1343:
	.word	.LANCHOR0
	.word	67109384
	.word	1025
	.word	769
	.word	.LANCHOR1
	.word	-32732
	.word	1026
	.size	rfu_UNI_setSendData, .-rfu_UNI_setSendData
	.align	1
	.p2align 2,,3
	.global	rfu_NI_CHILD_setSendGameName
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_NI_CHILD_setSendGameName, %function
rfu_NI_CHILD_setSendGameName:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #128
	push	{r4, r5, r6, r7, lr}
	mov	r6, r9
	mov	r5, r8
	mov	lr, fp
	mov	r7, r10
	lsls	r3, r3, #17
	lsls	r3, r3, r0
	push	{r5, r6, r7, lr}
	ldr	r6, .L1372
	ldr	r4, [r6]
	ldrb	r5, [r4]
	lsrs	r3, r3, #24
	cmp	r5, #255
	bne	.LCB8230
	b	.L1358	@long jump
.LCB8230:
	lsls	r2, r3, #28
	bne	.LCB8236
	b	.L1359	@long jump
.LCB8236:
	ldrb	r2, [r4, #2]
	ldrb	r7, [r4, #3]
	orrs	r2, r7
	ands	r2, r3
	cmp	r3, r2
	bne	.L1360
	ldrb	r2, [r4, #4]
	mov	ip, r2
	tst	r2, r3
	beq	.LCB8251
	b	.L1361	@long jump
.LCB8251:
	cmp	r0, #0
	bne	.LCB8253
	b	.L1362	@long jump
.LCB8253:
	cmp	r0, #1
	bne	.LCB8255
	b	.L1363	@long jump
.LCB8255:
	cmp	r0, #2
	bne	.LCB8257
	b	.L1364	@long jump
.LCB8257:
	subs	r7, r0, #3
	subs	r2, r7, #1
	sbcs	r7, r7, r2
	adds	r2, r7, #3
	mov	fp, r2
.L1347:
	cmp	r5, #1
	beq	.L1371
	cmp	r5, #0
	beq	.L1351
	ldr	r2, .L1372+4
	lsls	r5, r5, #4
	ldrb	r5, [r5, r2]
	movs	r2, #0
	mov	r8, r2
.L1352:
	cmp	r1, r5
	bls	.L1367
	ldr	r2, .L1372+8
	ldrh	r7, [r2]
	mov	r9, r7
	movs	r7, #0
	strh	r7, [r2]
	mov	r2, fp
	mov	r10, r7
	lsls	r7, r2, #2
	adds	r7, r6, r7
	ldr	r2, [r7, #12]
	mov	r7, r10
	strh	r7, [r2, #24]
	movs	r7, r2
	adds	r7, r7, #45
	str	r7, [r2, #4]
	movs	r7, #7
	subs	r5, r1, r5
	str	r7, [r2, #20]
	adds	r7, r7, #37
	strb	r3, [r2, r7]
	strh	r5, [r2, #46]
	movs	r5, #1
	adds	r7, r7, #1
	strb	r3, [r2, #26]
	strb	r5, [r2, r7]
	subs	r7, r7, #19
	str	r7, [r2, #48]
	movs	r7, r4
	adds	r7, r7, #144
	str	r7, [r2, #40]
	movs	r7, #0
	strb	r7, [r2, #27]
	mov	r7, r10
	str	r7, [r2, #28]
	ldr	r7, .L1372+12
	str	r7, [r2, #32]
	movs	r7, #36
	strb	r5, [r2, r7]
	cmp	r0, #0
	bne	.L1353
	ldr	r5, [r6, #12]
	strh	r0, [r5, #2]
.L1356:
	mov	r0, ip
	orrs	r3, r0
	strb	r3, [r4, #4]
	mov	r3, r8
	cmp	r3, #0
	beq	.L1357
	ldrb	r3, [r3]
	subs	r3, r3, r1
	mov	r1, r8
	strb	r3, [r1]
.L1357:
	ldr	r3, .L1372+16
	strh	r3, [r2]
	mov	r2, r9
	ldr	r3, .L1372+8
	movs	r0, #0
	strh	r2, [r3]
	b	.L1346
.L1360:
	ldr	r0, .L1372+20
.L1346:
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L1351:
	mov	r2, fp
	adds	r2, r2, #16
	mov	r8, r2
	movs	r5, #2
	add	r8, r8, r4
.L1350:
	mov	r2, r8
	ldrb	r2, [r2]
	cmp	r2, r1
	bcs	.L1352
.L1367:
	movs	r0, #160
	lsls	r0, r0, #3
	b	.L1346
.L1359:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1346
.L1358:
	ldr	r0, .L1372+24
	b	.L1346
.L1371:
	movs	r2, #15
	mov	r8, r2
	adds	r5, r5, #2
	add	r8, r8, r4
	b	.L1350
.L1353:
	cmp	r0, #1
	bne	.L1355
	mov	r5, r10
	ldr	r0, [r6, #16]
	strh	r5, [r0, #2]
	b	.L1356
.L1355:
	cmp	r0, #2
	bne	.L1354
	mov	r5, r10
	ldr	r0, [r6, #20]
	strh	r5, [r0, #2]
	b	.L1356
.L1354:
	cmp	r0, #3
	bne	.L1356
	mov	r5, r10
	ldr	r0, [r6, #24]
	strh	r5, [r0, #2]
	b	.L1356
.L1361:
	ldr	r0, .L1372+28
	b	.L1346
.L1362:
	movs	r2, #0
	mov	fp, r2
	b	.L1347
.L1363:
	movs	r2, #1
	mov	fp, r2
	b	.L1347
.L1364:
	movs	r2, #2
	mov	fp, r2
	b	.L1347
.L1373:
	.align	2
.L1372:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	67109384
	.word	16843008
	.word	-32735
	.word	1025
	.word	769
	.word	1026
	.size	rfu_NI_CHILD_setSendGameName, .-rfu_NI_CHILD_setSendGameName
	.align	1
	.p2align 2,,3
	.global	rfu_changeSendTarget
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_changeSendTarget, %function
rfu_changeSendTarget:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	cmp	r1, #3
	bhi	.L1390
	cmp	r0, #32
	beq	.L1414
	cmp	r0, #16
	bne	.L1394
	ldr	r3, .L1419
	lsls	r0, r1, #2
	adds	r0, r3, r0
	ldr	r4, [r0, #28]
	ldr	r0, .L1419+4
	ldrh	r5, [r4]
	cmp	r5, r0
	bne	.L1395
	cmp	r1, #0
	beq	.L1415
	ldr	r0, [r3, #28]
	ldrb	r0, [r0, #3]
	cmp	r1, #1
	beq	.L1416
	ldr	r5, [r3, #32]
	ldrb	r5, [r5, #3]
	orrs	r0, r5
	cmp	r1, #2
	beq	.L1386
	ldr	r1, [r3, #36]
	ldrb	r1, [r1, #3]
	orrs	r1, r0
.L1388:
	movs	r5, r1
	ands	r5, r2
	tst	r1, r2
	bne	.L1396
	ldr	r1, .L1419+8
	ldrh	r0, [r1]
	strh	r5, [r1]
	ldr	r5, [r3]
	ldrb	r6, [r4, #3]
	ldrb	r3, [r5, #6]
	bics	r3, r6
	orrs	r3, r2
	strb	r3, [r5, #6]
	strb	r2, [r4, #3]
	strh	r0, [r1]
.L1377:
	movs	r0, #0
	b	.L1409
.L1414:
	ldr	r3, .L1419
	lsls	r4, r1, #2
	adds	r4, r3, r4
	ldr	r4, [r4, #12]
	movs	r7, #0
	ldrsh	r5, [r4, r7]
	ldrh	r6, [r4]
	cmp	r5, #0
	bge	.L1395
	tst	r0, r6
	beq	.L1395
	ldrb	r0, [r4, #26]
	movs	r6, r2
	movs	r5, r0
	bics	r6, r0
	eors	r5, r2
	cmp	r6, #0
	bne	.L1396
	cmp	r0, r2
	beq	.L1377
	ldr	r7, .L1419+8
	ldrh	r0, [r7]
	strh	r6, [r7]
	lsls	r7, r5, #31
	bpl	.L1378
	ldr	r7, [r3, #12]
	strh	r6, [r7, #2]
.L1378:
	lsls	r6, r5, #30
	bpl	.L1379
	movs	r7, #0
	ldr	r6, [r3, #16]
	strh	r7, [r6, #2]
.L1379:
	lsls	r6, r5, #29
	bpl	.L1380
	movs	r7, #0
	ldr	r6, [r3, #20]
	strh	r7, [r6, #2]
.L1380:
	lsls	r6, r5, #28
	bmi	.L1417
.L1381:
	ldr	r7, [r3]
	ldrb	r6, [r7, #4]
	bics	r6, r5
	strb	r6, [r7, #4]
	strb	r2, [r4, #26]
	cmp	r2, #0
	beq	.L1418
.L1382:
	ldr	r3, .L1419+8
	strh	r0, [r3]
	movs	r0, #0
	b	.L1409
.L1395:
	ldr	r0, .L1419+12
.L1409:
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L1390:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1409
.L1394:
	movs	r0, #192
	lsls	r0, r0, #3
	b	.L1409
.L1416:
	ldr	r1, [r3, #36]
	ldrb	r1, [r1, #3]
	orrs	r0, r1
.L1386:
	ldr	r1, [r3, #40]
	ldrb	r1, [r1, #3]
	orrs	r1, r0
	b	.L1388
.L1396:
	ldr	r0, .L1419+16
	b	.L1409
.L1415:
	ldr	r0, [r3, #36]
	ldr	r1, [r3, #32]
	ldrb	r0, [r0, #3]
	ldrb	r1, [r1, #3]
	orrs	r0, r1
	b	.L1386
.L1417:
	movs	r7, #0
	ldr	r6, [r3, #24]
	strh	r7, [r6, #2]
	b	.L1381
.L1418:
	ldr	r3, [r3, #8]
	ldrh	r2, [r4, #46]
	ldrb	r3, [r3]
	lsls	r2, r2, #24
	lsrs	r2, r2, #24
	cmp	r3, #127
	bhi	.L1383
	ldrb	r3, [r7, #15]
	adds	r3, r3, #3
	adds	r2, r2, r3
	strb	r2, [r7, #15]
.L1384:
	movs	r3, #39
	strh	r3, [r4]
	b	.L1382
.L1383:
	adds	r7, r7, r1
	ldrb	r3, [r7, #16]
	adds	r3, r3, #2
	adds	r2, r2, r3
	strb	r2, [r7, #16]
	b	.L1384
.L1420:
	.align	2
.L1419:
	.word	.LANCHOR0
	.word	32804
	.word	67109384
	.word	1027
	.word	1028
	.size	rfu_changeSendTarget, .-rfu_changeSendTarget
	.align	1
	.p2align 2,,3
	.global	rfu_NI_stopReceivingData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_NI_stopReceivingData, %function
rfu_NI_stopReceivingData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	cmp	r0, #3
	bhi	.L1426
	movs	r5, #0
	ldr	r4, .L1429
	ldr	r2, .L1429+4
	lsls	r3, r0, #2
	adds	r3, r4, r3
	ldr	r1, [r3, #12]
	ldrh	r3, [r2]
	strh	r5, [r2]
	movs	r6, #52
	ldrsh	r5, [r1, r6]
	ldrh	r2, [r1, #52]
	cmp	r5, #0
	blt	.L1428
.L1423:
	movs	r0, #0
	ldr	r2, .L1429+4
	strh	r3, [r2]
.L1422:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L1428:
	ldr	r5, .L1429+8
	mov	ip, r5
	add	r2, r2, ip
	rsbs	r5, r2, #0
	adcs	r2, r2, r5
	movs	r5, #1
	lsls	r5, r5, r0
	adds	r2, r2, #71
	strh	r2, [r1, #52]
	ldr	r2, [r4]
	ldrb	r1, [r2, #5]
	bics	r1, r5
	strb	r1, [r2, #5]
	ldr	r1, [r4, #8]
	ldrb	r1, [r1]
	cmp	r1, #127
	bhi	.L1425
	ldrb	r1, [r2, #15]
	adds	r1, r1, #3
	strb	r1, [r2, #15]
	b	.L1423
.L1426:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1422
.L1425:
	adds	r2, r2, r0
	ldrb	r1, [r2, #16]
	adds	r1, r1, #2
	strb	r1, [r2, #16]
	b	.L1423
.L1430:
	.align	2
.L1429:
	.word	.LANCHOR0
	.word	67109384
	.word	-32835
	.size	rfu_NI_stopReceivingData, .-rfu_NI_stopReceivingData
	.align	1
	.p2align 2,,3
	.global	rfu_UNI_changeAndReadySendData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_UNI_changeAndReadySendData, %function
rfu_UNI_changeAndReadySendData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	cmp	r0, #3
	bhi	.L1435
	ldr	r5, .L1440
	lsls	r3, r0, #2
	adds	r3, r5, r3
	ldr	r4, [r3, #28]
	ldr	r3, .L1440+4
	ldrh	r6, [r4]
	cmp	r6, r3
	bne	.L1436
	ldr	r5, [r5]
	ldrb	r6, [r5]
	ldrb	r3, [r4, #4]
	cmp	r6, #1
	beq	.L1438
	movs	r6, r0
	adds	r6, r6, #16
	adds	r6, r5, r6
	adds	r5, r5, r0
	ldrb	r0, [r5, #16]
	adds	r3, r3, r0
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	cmp	r3, r2
	bcc	.L1437
.L1439:
	movs	r7, #0
	ldr	r0, .L1440+8
	subs	r3, r3, r2
	ldrh	r5, [r0]
	strh	r7, [r0]
	str	r1, [r4, #8]
	strb	r3, [r6]
	movs	r3, #1
	strh	r2, [r4, #4]
	strb	r3, [r4, #2]
	strh	r5, [r0]
	movs	r0, #0
.L1432:
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L1436:
	ldr	r0, .L1440+12
	b	.L1432
.L1435:
	movs	r0, #128
	lsls	r0, r0, #3
	b	.L1432
.L1438:
	movs	r6, r5
	ldrb	r0, [r5, #15]
	adds	r3, r3, r0
	lsls	r3, r3, #24
	adds	r6, r6, #15
	lsrs	r3, r3, #24
	cmp	r3, r2
	bcs	.L1439
.L1437:
	movs	r0, #160
	lsls	r0, r0, #3
	b	.L1432
.L1441:
	.align	2
.L1440:
	.word	.LANCHOR0
	.word	32804
	.word	67109384
	.word	1027
	.size	rfu_UNI_changeAndReadySendData, .-rfu_UNI_changeAndReadySendData
	.align	1
	.p2align 2,,3
	.global	rfu_UNI_readySendData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_UNI_readySendData, %function
rfu_UNI_readySendData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #3
	bhi	.L1442
	ldr	r3, .L1445
	lsls	r0, r0, #2
	adds	r3, r3, r0
	ldr	r3, [r3, #28]
	ldr	r2, .L1445+4
	ldrh	r1, [r3]
	cmp	r1, r2
	beq	.L1444
.L1442:
	@ sp needed
	bx	lr
.L1444:
	movs	r2, #1
	strb	r2, [r3, #2]
	b	.L1442
.L1446:
	.align	2
.L1445:
	.word	.LANCHOR0
	.word	32804
	.size	rfu_UNI_readySendData, .-rfu_UNI_readySendData
	.align	1
	.p2align 2,,3
	.global	rfu_UNI_clearRecvNewDataFlag
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_UNI_clearRecvNewDataFlag, %function
rfu_UNI_clearRecvNewDataFlag:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #3
	bhi	.L1447
	movs	r2, #0
	ldr	r3, .L1449
	lsls	r0, r0, #2
	adds	r3, r3, r0
	ldr	r3, [r3, #28]
	strb	r2, [r3, #18]
.L1447:
	@ sp needed
	bx	lr
.L1450:
	.align	2
.L1449:
	.word	.LANCHOR0
	.size	rfu_UNI_clearRecvNewDataFlag, .-rfu_UNI_clearRecvNewDataFlag
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_sendData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_sendData, %function
rfu_REQ_sendData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r5, r8
	mov	lr, fp
	mov	r7, r10
	mov	r6, r9
	push	{r5, r6, r7, lr}
	ldr	r5, .L1535
	ldr	r3, [r5]
	ldrb	r2, [r3]
	movs	r4, r0
	sub	sp, sp, #28
	cmp	r2, #255
	beq	.L1451
	cmp	r2, #1
	beq	.L1523
	ldrb	r2, [r3, #14]
	cmp	r2, #0
	bne	.LCB8970
	b	.L1524	@long jump
.LCB8970:
.L1464:
	ldrb	r2, [r3, #14]
	cmp	r2, #0
	beq	.LCB8976
	b	.L1525	@long jump
.LCB8976:
	cmp	r4, #0
	beq	.L1451
	ldrb	r3, [r3]
	cmp	r3, #1
	bne	.LCB8981
	b	.L1486	@long jump
.LCB8981:
	ldr	r0, .L1535+4
	bl	STWI_set_Callback_M
	bl	STWI_send_MS_ChangeREQ
.L1451:
	add	sp, sp, #28
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L1523:
	ldrb	r1, [r3, #5]
	ldrb	r2, [r3, #4]
	orrs	r2, r1
	ldrb	r1, [r3, #6]
	orrs	r2, r1
	bne	.L1455
	ldr	r1, [r5, #8]
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	beq	.L1456
	movs	r3, #15
	strb	r2, [r1, #7]
	strb	r3, [r1, #8]
.L1457:
	movs	r2, #1
	ldr	r3, [r5, #4]
	str	r2, [r3, #104]
	adds	r2, r2, #254
	str	r2, [r3, #120]
	ldr	r0, .L1535+8
	bl	STWI_set_Callback_M
	cmp	r4, #0
	beq	.LCB9029
	b	.L1526	@long jump
.LCB9029:
	ldr	r0, [r5, #4]
	movs	r1, #1
	adds	r0, r0, #104
	bl	STWI_send_DataTxREQ
	b	.L1451
.L1455:
	ldrb	r2, [r3, #14]
	cmp	r2, #0
	bne	.L1464
.L1487:
	movs	r2, #0
	strb	r2, [r3, #14]
	ldr	r3, [r5, #4]
	adds	r3, r3, #108
	str	r3, [sp, #12]
	movs	r3, #12
	mov	r8, r3
	adds	r3, r3, #16
	mov	fp, r3
	movs	r3, #0
	add	r8, r8, r5
	add	fp, fp, r5
	mov	r9, r5
	movs	r6, #0
	mov	r5, fp
	mov	r10, r3
	mov	fp, r4
	mov	r4, r8
.L1477:
	ldr	r2, [r4]
	lsls	r3, r6, #24
	lsrs	r3, r3, #24
	mov	r8, r3
	movs	r1, #0
	ldrsh	r3, [r2, r1]
	movs	r7, #0
	cmp	r3, #0
	blt	.L1527
.L1466:
	movs	r1, #52
	ldrsh	r3, [r2, r1]
	cmp	r3, #0
	blt	.L1528
.L1467:
	ldr	r3, [r5]
	ldr	r2, .L1535+12
	mov	r8, r3
	ldrh	r3, [r3]
	cmp	r3, r2
	beq	.L1529
.L1468:
	cmp	r7, #0
	beq	.L1475
	mov	r3, r9
	ldr	r3, [r3]
	ldrb	r3, [r3]
	cmp	r3, #1
	bne	.LCB9092
	b	.L1530	@long jump
.LCB9092:
	lsls	r3, r6, #2
	adds	r3, r3, r6
	adds	r3, r3, #8
	lsls	r7, r7, r3
	mov	r3, r10
	orrs	r3, r7
	mov	r10, r3
.L1475:
	adds	r6, r6, #1
	adds	r4, r4, #4
	adds	r5, r5, #4
	cmp	r6, #4
	bne	.L1477
	mov	r3, r10
	mov	r4, fp
	mov	r5, r9
	cmp	r3, #0
	beq	.L1531
	ldr	r2, [sp, #12]
	lsls	r3, r2, #30
	beq	.L1480
	movs	r0, #0
	movs	r1, #3
.L1481:
	adds	r3, r2, #1
	str	r3, [sp, #12]
	strb	r0, [r2]
	ldr	r2, [sp, #12]
	tst	r2, r1
	bne	.L1481
.L1480:
	mov	r1, r10
	ldr	r3, [r5, #4]
	str	r1, [r3, #104]
	ldr	r3, [r5]
	ldrb	r1, [r3]
	cmp	r1, #0
	bne	.L1479
	ldr	r1, [r5, #4]
	subs	r2, r2, #108
	subs	r2, r2, r1
	mov	r10, r2
	b	.L1479
.L1456:
	ldrb	r3, [r1, #8]
	cmp	r3, #0
	beq	.LCB9146
	b	.L1532	@long jump
.LCB9146:
	ldrb	r3, [r1, #7]
	adds	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r1, #7]
.L1462:
	lsls	r3, r3, #28
	beq	.L1457
	cmp	r4, #0
	bne	.LCB9161
	b	.L1451	@long jump
.LCB9161:
.L1486:
	ldr	r3, .L1535+16
	ldr	r3, [r3]
	ldr	r3, [r3, #28]
	cmp	r3, #0
	bne	.LCB9167
	b	.L1451	@long jump
.LCB9167:
	movs	r0, #39
	bl	.L67
	b	.L1451
.L1525:
	ldr	r0, .L1535+20
	bl	STWI_set_Callback_M
	ldr	r3, [r5, #8]
	ldr	r1, [r3, #36]
	ldr	r0, [r5, #4]
	adds	r1, r1, #4
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	adds	r0, r0, #104
	cmp	r4, #0
	bne	.L1533
	bl	STWI_send_DataTxREQ
	b	.L1451
.L1524:
	ldrb	r1, [r3, #5]
	ldrb	r2, [r3, #4]
	orrs	r2, r1
	ldrb	r1, [r3, #6]
	orrs	r2, r1
	bne	.LCB9198
	b	.L1464	@long jump
.LCB9198:
	b	.L1487
.L1533:
	bl	STWI_send_DataTxAndChangeREQ
	b	.L1451
.L1528:
	mov	r0, r8
	adds	r2, r2, #52
	add	r1, sp, #12
	bl	rfu_STC_NI_constructLLSF
	adds	r7, r7, r0
	b	.L1467
.L1527:
	mov	r0, r8
	add	r1, sp, #12
	bl	rfu_STC_NI_constructLLSF
	ldr	r2, [r4]
	movs	r7, r0
	b	.L1466
.L1531:
	ldr	r3, [r5]
.L1479:
	mov	r1, r10
	ldr	r2, [r5, #8]
	str	r1, [r2, #36]
	b	.L1464
.L1526:
	ldr	r0, [r5, #4]
	movs	r1, #1
	adds	r0, r0, #104
	bl	STWI_send_DataTxAndChangeREQ
	b	.L1451
.L1529:
	mov	r3, r8
	ldrb	r3, [r3, #2]
	cmp	r3, #0
	bne	.LCB9248
	b	.L1468	@long jump
.LCB9248:
	mov	r3, r8
	ldrb	r3, [r3, #3]
	str	r3, [sp, #4]
	cmp	r3, #0
	bne	.LCB9253
	b	.L1468	@long jump
.LCB9253:
	mov	r3, r9
	ldr	r3, [r3]
	ldrb	r0, [r3]
	mov	r3, r8
	lsls	r1, r0, #4
	mov	ip, r1
	ldrh	r2, [r3, #4]
	ldr	r3, .L1535+24
	str	r3, [sp]
	add	r3, r3, ip
	ldrb	r3, [r3, #3]
	movs	r1, r3
	movs	r3, #4
	lsls	r3, r3, r1
	orrs	r3, r2
	cmp	r0, #1
	bne	.L1470
	ldr	r1, [sp, #4]
	lsls	r1, r1, #18
	orrs	r3, r1
.L1470:
	mov	r1, ip
	str	r3, [sp, #20]
	ldr	r3, [sp]
	ldrb	r1, [r3, r1]
	cmp	r1, #0
	beq	.L1489
	movs	r3, #0
	mov	ip, r4
	add	r2, sp, #20
.L1472:
	ldr	r0, [sp, #12]
	adds	r4, r0, #1
	str	r4, [sp, #12]
	adds	r3, r3, #1
	ldrb	r4, [r2]
	lsls	r3, r3, #24
	strb	r4, [r0]
	lsrs	r3, r3, #24
	adds	r2, r2, #1
	cmp	r3, r1
	bne	.L1472
	mov	r2, r8
	mov	r4, ip
	ldrh	r2, [r2, #4]
	str	r3, [sp]
.L1471:
	mov	r3, r8
	ldr	r3, [r3, #8]
	str	r3, [sp, #16]
	mov	r3, r9
	ldr	r3, [r3, #4]
	add	r1, sp, #12
	ldr	r3, [r3, #4]
	add	r0, sp, #16
	bl	.L67
	mov	r3, r9
	ldr	r2, [r3]
	ldrb	r3, [r2]
	cmp	r3, #1
	beq	.L1534
	movs	r1, #16
	lsls	r1, r1, r6
	ldrb	r3, [r2, #14]
	orrs	r3, r1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r2, #14]
.L1474:
	mov	r3, r8
	ldr	r2, [sp]
	mov	ip, r2
	ldrh	r3, [r3, #4]
	add	r3, r3, ip
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	adds	r7, r7, r3
	b	.L1468
.L1530:
	add	r10, r10, r7
	b	.L1475
.L1534:
	adds	r3, r3, #15
	strb	r3, [r2, #14]
	b	.L1474
.L1489:
	movs	r3, #0
	str	r3, [sp]
	b	.L1471
.L1532:
	subs	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r1, #8]
	beq	.LCB9365
	b	.L1457	@long jump
.LCB9365:
	ldrb	r3, [r1, #7]
	b	.L1462
.L1536:
	.align	2
.L1535:
	.word	.LANCHOR0
	.word	rfu_CB_sendData2
	.word	rfu_CB_sendData3
	.word	32804
	.word	gSTWIStatus
	.word	rfu_CB_sendData
	.word	.LANCHOR1
	.size	rfu_REQ_sendData, .-rfu_REQ_sendData
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_recvData
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_recvData, %function
rfu_REQ_recvData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L1542
	ldr	r3, [r2]
	ldrb	r1, [r3]
	push	{r4, lr}
	cmp	r1, #255
	beq	.L1537
	ldrb	r0, [r3, #5]
	ldr	r1, [r2, #8]
	ldrb	r2, [r3, #4]
	ldrb	r3, [r3, #6]
	orrs	r2, r0
	orrs	r3, r2
	strb	r3, [r1, #3]
	movs	r3, #0
	ldr	r0, .L1542+4
	strb	r3, [r1, #4]
	bl	STWI_set_Callback_M
	bl	STWI_send_DataRxREQ
.L1537:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L1543:
	.align	2
.L1542:
	.word	.LANCHOR0
	.word	rfu_CB_recvData
	.size	rfu_REQ_recvData, .-rfu_REQ_recvData
	.align	1
	.p2align 2,,3
	.global	rfu_REQ_noise
	.syntax unified
	.code	16
	.thumb_func
	.type	rfu_REQ_noise, %function
rfu_REQ_noise:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L1545
	@ sp needed
	bl	STWI_set_Callback_M
	movs	r1, #0
	movs	r0, #1
	bl	STWI_send_TestModeREQ
	pop	{r4}
	pop	{r0}
	bx	r0
.L1546:
	.align	2
.L1545:
	.word	rfu_STC_REQ_callback
	.size	rfu_REQ_noise, .-rfu_REQ_noise
	.global	gRfuFixed
	.global	gRfuStatic
	.global	gRfuLinkStatus
	.global	gRfuSlotStatusNI
	.global	gRfuSlotStatusUNI
	.section	.rodata
	.align	2
	.set	.LANCHOR1,. + 0
	.type	llsf_struct, %object
	.size	llsf_struct, 32
llsf_struct:
	.byte	2
	.byte	14
	.byte	0
	.byte	10
	.byte	9
	.byte	5
	.byte	7
	.byte	2
	.byte	0
	.byte	15
	.byte	1
	.byte	3
	.byte	3
	.space	1
	.short	31
	.byte	3
	.byte	22
	.byte	18
	.byte	14
	.byte	13
	.byte	9
	.byte	11
	.byte	3
	.byte	15
	.byte	15
	.byte	1
	.byte	3
	.byte	3
	.space	1
	.short	127
	.type	str_checkMbootLL, %object
	.size	str_checkMbootLL, 10
str_checkMbootLL:
	.ascii	"RFU-MBOOT\000"
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	gRfuLinkStatus, %object
	.size	gRfuLinkStatus, 4
gRfuLinkStatus:
	.space	4
	.type	gRfuFixed, %object
	.size	gRfuFixed, 4
gRfuFixed:
	.space	4
	.type	gRfuStatic, %object
	.size	gRfuStatic, 4
gRfuStatic:
	.space	4
	.type	gRfuSlotStatusNI, %object
	.size	gRfuSlotStatusNI, 16
gRfuSlotStatusNI:
	.space	16
	.type	gRfuSlotStatusUNI, %object
	.size	gRfuSlotStatusUNI, 16
gRfuSlotStatusUNI:
	.space	16
	.ident	"GCC: (devkitARM release 62) 13.2.0"
	.text
	.code 16
	.align	1
.L67:
	bx	r3
.text
	.align	2, 0

