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
	.type	STWI_intr_timer, %function
STWI_intr_timer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r4, .L29
	ldr	r3, [r4]
	ldr	r2, [r3, #12]
	cmp	r2, #3
	beq	.L2
	bgt	.L3
	cmp	r2, #1
	beq	.L4
	cmp	r2, #2
	bne	.L1
	movs	r1, #1
	movs	r5, #0
	ldrb	r4, [r3, #10]
	ldr	r0, .L29+4
	ldr	r2, .L29+8
	strb	r1, [r3, #16]
	adds	r2, r4, r2
	strh	r5, [r0]
	ldr	r5, .L29+12
	lsls	r2, r2, #2
	strh	r5, [r2]
	str	r1, [r3, #12]
	movs	r3, #195
	strh	r3, [r2, #2]
	movs	r3, #128
	lsls	r3, r3, #12
	lsls	r3, r3, r4
	ldr	r2, .L29+16
	lsrs	r3, r3, #16
	strh	r3, [r2]
	strh	r1, [r0]
.L1:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L3:
	cmp	r2, #4
	bne	.L1
.L4:
	movs	r1, #0
	ldrb	r0, [r3, #10]
	ldr	r2, .L29+8
	adds	r2, r0, r2
	lsls	r2, r2, #2
	str	r1, [r3, #12]
	strh	r1, [r2]
	strh	r1, [r2, #2]
	ldrb	r2, [r3, #21]
	cmp	r2, #1
	bls	.L28
	ldrb	r0, [r3, #6]
	movs	r2, r0
	subs	r2, r2, #37
	lsls	r2, r2, #24
	ldr	r5, [r3, #24]
	lsrs	r2, r2, #24
	cmp	r2, #18
	bhi	.L8
	ldr	r1, .L29+20
	lsrs	r1, r1, r2
	movs	r2, r1
	movs	r1, #1
	tst	r1, r2
	beq	.L8
	strh	r1, [r3, #18]
	movs	r2, #44
	movs	r1, #0
	strb	r1, [r3, r2]
	cmp	r5, #0
	beq	.L1
	ldrh	r1, [r3, #18]
	bl	.L31
	b	.L1
.L2:
	movs	r2, #1
	ldr	r0, .L29+8
	mov	ip, r0
	movs	r1, #0
	strb	r2, [r3, #16]
	ldrb	r2, [r3, #10]
	add	r2, r2, ip
	lsls	r2, r2, #2
	str	r1, [r3, #12]
	strh	r1, [r2]
	strh	r1, [r2, #2]
	movs	r2, #5
	movs	r0, #128
	str	r2, [r3]
	ldr	r2, .L29+24
	lsls	r0, r0, #24
	strh	r1, [r3, #4]
	str	r0, [r2]
	ldr	r2, .L29+28
	strh	r1, [r2]
	ldr	r1, .L29+32
	ldr	r3, [r3, #24]
	strh	r1, [r2]
	ldr	r1, .L29+36
	strh	r1, [r2]
	cmp	r3, #0
	beq	.L1
	movs	r1, #0
	movs	r0, #255
	bl	.L32
	b	.L1
.L28:
	adds	r2, r2, #1
	strb	r2, [r3, #21]
	ldrb	r2, [r3, #4]
	ldrb	r4, [r3, #6]
	lsls	r2, r2, #8
	orrs	r2, r4
	ldr	r4, .L29+40
	orrs	r2, r4
	ldr	r4, [r3, #36]
	str	r2, [r4]
	ldr	r4, .L29+24
	str	r2, [r4]
	movs	r2, #1
	str	r1, [r3]
	strb	r2, [r3, #5]
	ldr	r4, .L29+4
	ldrh	r5, [r4]
	strh	r1, [r4]
	adds	r1, r1, #8
	lsls	r1, r1, r0
	ldr	r2, .L29+44
	ldrh	r3, [r2]
	orrs	r3, r1
	movs	r1, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r2]
	ldrh	r3, [r2]
	orrs	r3, r1
	strh	r3, [r2]
	ldr	r3, .L29+28
	ldr	r2, .L29+48
	strh	r5, [r4]
	strh	r2, [r3]
	b	.L1
.L8:
	movs	r2, #1
	movs	r1, #0
	strh	r2, [r3, #18]
	adds	r2, r2, #43
	strb	r1, [r3, r2]
	cmp	r5, #0
	beq	.L10
	ldrh	r1, [r3, #18]
	bl	.L31
	ldr	r3, [r4]
.L10:
	movs	r2, #4
	str	r2, [r3]
	b	.L1
.L30:
	.align	2
.L29:
	.word	.LANCHOR0
	.word	67109384
	.word	16777280
	.word	-821
	.word	67109378
	.word	327685
	.word	67109152
	.word	67109160
	.word	20483
	.word	20610
	.word	-1721368576
	.word	67109376
	.word	20611
	.size	STWI_intr_timer, .-STWI_intr_timer
	.align	1
	.p2align 2,,3
	.global	STWI_init_all
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_init_all, %function
STWI_init_all:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	cmp	r2, #1
	beq	.L36
	ldr	r3, .L37
	str	r3, [r1]
	movs	r3, r0
	adds	r3, r3, #232
.L35:
	ldr	r2, .L37+4
	@ sp needed
	str	r3, [r2]
	movs	r2, #1
	str	r0, [r3, #40]
	adds	r0, r0, #116
	strb	r2, [r3, #20]
	str	r0, [r3, #36]
	movs	r2, #0
	movs	r1, #0
	movs	r0, #44
	movs	r4, #128
	str	r2, [r3]
	strb	r1, [r3, #7]
	strb	r1, [r3, #16]
	strb	r1, [r3, #21]
	strh	r2, [r3, #18]
	strh	r2, [r3, #4]
	strh	r2, [r3, #8]
	str	r2, [r3, #12]
	strb	r1, [r3, r0]
	ldr	r1, .L37+8
	adds	r0, r0, #212
	strh	r0, [r1]
	ldr	r1, .L37+12
	ldr	r0, .L37+16
	strh	r0, [r1]
	str	r2, [r3, #24]
	str	r2, [r3, #28]
	ldr	r3, .L37+20
	ldr	r0, .L37+24
	ldrh	r1, [r3]
	strh	r2, [r3]
	ldrh	r2, [r0]
	orrs	r2, r4
	strh	r2, [r0]
	strh	r1, [r3]
	pop	{r4}
	pop	{r0}
	bx	r0
.L36:
	movs	r2, r0
	adds	r2, r2, #232
	str	r2, [r1]
	ldr	r3, .L37
	ldr	r1, .L37+28
	str	r3, [r1]
	ldr	r3, .L37+32
	str	r2, [r3]
	ldr	r3, .L37+36
	ldr	r2, .L37+40
	str	r2, [r3]
	ldr	r3, [r3]
	ldr	r3, .L37+44
	adds	r3, r0, r3
	b	.L35
.L38:
	.align	2
.L37:
	.word	IntrSIO32
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	67109384
	.word	67109376
	.word	67109076
	.word	67109080
	.word	67109084
	.word	-2147482448
	.word	2632
	.size	STWI_init_all, .-STWI_init_all
	.align	1
	.p2align 2,,3
	.global	STWI_init_timer
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_init_timer, %function
STWI_init_timer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movs	r4, #255
	@ sp needed
	ldr	r3, .L40
	str	r3, [r0]
	ldr	r3, .L40+4
	ldr	r3, [r3]
	ands	r4, r1
	strb	r1, [r3, #10]
	movs	r1, #8
	movs	r3, #0
	lsls	r1, r1, r4
	ldr	r2, .L40+8
	ldr	r5, .L40+12
	ldrh	r0, [r2]
	strh	r3, [r2]
	ldrh	r3, [r5]
	orrs	r3, r1
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r5]
	strh	r0, [r2]
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L41:
	.align	2
.L40:
	.word	STWI_intr_timer
	.word	.LANCHOR0
	.word	67109384
	.word	67109376
	.size	STWI_init_timer, .-STWI_init_timer
	.align	1
	.p2align 2,,3
	.global	AgbRFU_SoftReset
	.syntax unified
	.code	16
	.thumb_func
	.type	AgbRFU_SoftReset, %function
AgbRFU_SoftReset:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L46
	mov	ip, r2
	movs	r2, #0
	ldr	r1, .L46+4
	ldr	r3, .L46+8
	push	{r4, lr}
	strh	r3, [r1]
	ldr	r3, .L46+12
	strh	r3, [r1]
	ldr	r3, .L46+16
	ldr	r0, [r3]
	ldrb	r3, [r0, #10]
	add	r3, r3, ip
	lsls	r3, r3, #2
	strh	r2, [r3, #2]
	strh	r2, [r3]
	adds	r2, r2, #131
	strh	r2, [r3, #2]
	ldrh	r2, [r3]
	cmp	r2, #17
	bhi	.L43
	ldr	r2, .L46+20
	adds	r4, r2, #0
.L44:
	strh	r4, [r1]
	ldrh	r2, [r3]
	cmp	r2, #17
	bls	.L44
.L43:
	@ sp needed
	movs	r2, #3
	strh	r2, [r3, #2]
	ldr	r3, .L46+4
	ldr	r2, .L46+12
	strh	r2, [r3]
	ldr	r3, .L46+24
	ldr	r2, .L46+28
	strh	r2, [r3]
	movs	r3, #0
	movs	r2, #0
	str	r3, [r0]
	str	r3, [r0, #4]
	strb	r2, [r0, #16]
	strh	r3, [r0, #8]
	strh	r3, [r0, #18]
	str	r3, [r0, #12]
	adds	r3, r3, #1
	strb	r3, [r0, #20]
	adds	r3, r3, #43
	strb	r2, [r0, #21]
	strb	r2, [r0, r3]
	pop	{r4}
	pop	{r0}
	bx	r0
.L47:
	.align	2
.L46:
	.word	16777280
	.word	67109172
	.word	-32768
	.word	-32608
	.word	.LANCHOR0
	.word	-32606
	.word	67109160
	.word	20483
	.size	AgbRFU_SoftReset, .-AgbRFU_SoftReset
	.align	1
	.p2align 2,,3
	.global	STWI_set_MS_mode
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_set_MS_mode, %function
STWI_set_MS_mode:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L49
	@ sp needed
	ldr	r3, [r3]
	strb	r0, [r3, #20]
	bx	lr
.L50:
	.align	2
.L49:
	.word	.LANCHOR0
	.size	STWI_set_MS_mode, .-STWI_set_MS_mode
	.align	1
	.p2align 2,,3
	.global	STWI_read_status
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_read_status, %function
STWI_read_status:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #2
	beq	.L52
	bhi	.L53
	cmp	r0, #0
	beq	.L59
	ldr	r3, .L61
	ldr	r3, [r3]
	ldrb	r0, [r3, #20]
.L57:
	@ sp needed
	bx	lr
.L53:
	cmp	r0, #3
	bne	.L60
	ldr	r3, .L61
	ldr	r3, [r3]
	ldrb	r0, [r3, #6]
	b	.L57
.L52:
	ldr	r3, .L61
	ldr	r3, [r3]
	ldr	r0, [r3]
	lsls	r0, r0, #16
	lsrs	r0, r0, #16
	b	.L57
.L59:
	ldr	r3, .L61
	ldr	r3, [r3]
	ldrh	r0, [r3, #18]
	b	.L57
.L60:
	ldr	r0, .L61+4
	b	.L57
.L62:
	.align	2
.L61:
	.word	.LANCHOR0
	.word	65535
	.size	STWI_read_status, .-STWI_read_status
	.align	1
	.p2align 2,,3
	.global	STWI_init_Callback_M
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_init_Callback_M, %function
STWI_init_Callback_M:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, #0
	@ sp needed
	ldr	r3, .L64
	ldr	r3, [r3]
	str	r2, [r3, #24]
	bx	lr
.L65:
	.align	2
.L64:
	.word	.LANCHOR0
	.size	STWI_init_Callback_M, .-STWI_init_Callback_M
	.align	1
	.p2align 2,,3
	.global	STWI_init_Callback_S
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_init_Callback_S, %function
STWI_init_Callback_S:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, #0
	@ sp needed
	ldr	r3, .L67
	ldr	r3, [r3]
	str	r2, [r3, #28]
	bx	lr
.L68:
	.align	2
.L67:
	.word	.LANCHOR0
	.size	STWI_init_Callback_S, .-STWI_init_Callback_S
	.align	1
	.p2align 2,,3
	.global	STWI_set_Callback_M
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_set_Callback_M, %function
STWI_set_Callback_M:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L70
	@ sp needed
	ldr	r3, [r3]
	str	r0, [r3, #24]
	bx	lr
.L71:
	.align	2
.L70:
	.word	.LANCHOR0
	.size	STWI_set_Callback_M, .-STWI_set_Callback_M
	.align	1
	.p2align 2,,3
	.global	STWI_set_Callback_S
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_set_Callback_S, %function
STWI_set_Callback_S:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L73
	@ sp needed
	ldr	r3, [r3]
	str	r0, [r3, #28]
	bx	lr
.L74:
	.align	2
.L73:
	.word	.LANCHOR0
	.size	STWI_set_Callback_S, .-STWI_set_Callback_S
	.align	1
	.p2align 2,,3
	.global	STWI_set_Callback_ID
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_set_Callback_ID, %function
STWI_set_Callback_ID:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L76
	@ sp needed
	ldr	r3, [r3]
	str	r0, [r3, #32]
	bx	lr
.L77:
	.align	2
.L76:
	.word	.LANCHOR0
	.size	STWI_set_Callback_ID, .-STWI_set_Callback_ID
	.align	1
	.p2align 2,,3
	.global	STWI_poll_CommandEnd
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_poll_CommandEnd, %function
STWI_poll_CommandEnd:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r1, #44
	ldr	r3, .L82
	ldr	r2, [r3]
.L79:
	ldrb	r3, [r2, r1]
	cmp	r3, #1
	beq	.L79
	@ sp needed
	ldrh	r0, [r2, #18]
	bx	lr
.L83:
	.align	2
.L82:
	.word	.LANCHOR0
	.size	STWI_poll_CommandEnd, .-STWI_poll_CommandEnd
	.align	1
	.p2align 2,,3
	.global	STWI_send_ResetREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_ResetREQ, %function
STWI_send_ResetREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L100
	ldr	r2, .L100+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L97
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L98
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L99
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #16
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L100+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L100+12
	ldr	r6, .L100+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L100+20
	str	r0, [r6]
	ldr	r6, .L100+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L100+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L100+32
	strh	r3, [r5]
.L84:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L99:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L84
	ldrh	r1, [r2, #18]
	adds	r0, r0, #16
	bl	.L32
	b	.L84
.L97:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L84
	movs	r0, #16
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L84
.L98:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L84
	ldrh	r1, [r2, #18]
	adds	r0, r0, #15
	bl	.L32
	b	.L84
.L101:
	.align	2
.L100:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368560
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_ResetREQ, .-STWI_send_ResetREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_LinkStatusREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_LinkStatusREQ, %function
STWI_send_LinkStatusREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L118
	ldr	r2, .L118+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L115
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L116
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L117
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #17
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L118+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L118+12
	ldr	r6, .L118+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L118+20
	str	r0, [r6]
	ldr	r6, .L118+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L118+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L118+32
	strh	r3, [r5]
.L102:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L117:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L102
	ldrh	r1, [r2, #18]
	adds	r0, r0, #17
	bl	.L32
	b	.L102
.L115:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L102
	movs	r0, #17
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L102
.L116:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L102
	ldrh	r1, [r2, #18]
	adds	r0, r0, #16
	bl	.L32
	b	.L102
.L119:
	.align	2
.L118:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368559
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_LinkStatusREQ, .-STWI_send_LinkStatusREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_VersionStatusREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_VersionStatusREQ, %function
STWI_send_VersionStatusREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L136
	ldr	r2, .L136+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L133
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L134
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L135
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #18
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L136+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L136+12
	ldr	r6, .L136+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L136+20
	str	r0, [r6]
	ldr	r6, .L136+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L136+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L136+32
	strh	r3, [r5]
.L120:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L135:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L120
	ldrh	r1, [r2, #18]
	adds	r0, r0, #18
	bl	.L32
	b	.L120
.L133:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L120
	movs	r0, #18
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L120
.L134:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L120
	ldrh	r1, [r2, #18]
	adds	r0, r0, #17
	bl	.L32
	b	.L120
.L137:
	.align	2
.L136:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368558
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_VersionStatusREQ, .-STWI_send_VersionStatusREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SystemStatusREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SystemStatusREQ, %function
STWI_send_SystemStatusREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L154
	ldr	r2, .L154+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L151
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L152
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L153
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #19
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L154+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L154+12
	ldr	r6, .L154+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L154+20
	str	r0, [r6]
	ldr	r6, .L154+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L154+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L154+32
	strh	r3, [r5]
.L138:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L153:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L138
	ldrh	r1, [r2, #18]
	adds	r0, r0, #19
	bl	.L32
	b	.L138
.L151:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L138
	movs	r0, #19
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L138
.L152:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L138
	ldrh	r1, [r2, #18]
	adds	r0, r0, #18
	bl	.L32
	b	.L138
.L155:
	.align	2
.L154:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368557
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SystemStatusREQ, .-STWI_send_SystemStatusREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SlotStatusREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SlotStatusREQ, %function
STWI_send_SlotStatusREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L172
	ldr	r2, .L172+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L169
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L170
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L171
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #20
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L172+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L172+12
	ldr	r6, .L172+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L172+20
	str	r0, [r6]
	ldr	r6, .L172+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L172+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L172+32
	strh	r3, [r5]
.L156:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L171:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L156
	ldrh	r1, [r2, #18]
	adds	r0, r0, #20
	bl	.L32
	b	.L156
.L169:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L156
	movs	r0, #20
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L156
.L170:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L156
	ldrh	r1, [r2, #18]
	adds	r0, r0, #19
	bl	.L32
	b	.L156
.L173:
	.align	2
.L172:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368556
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SlotStatusREQ, .-STWI_send_SlotStatusREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_ConfigStatusREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_ConfigStatusREQ, %function
STWI_send_ConfigStatusREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L190
	ldr	r2, .L190+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L187
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L188
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L189
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #21
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L190+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L190+12
	ldr	r6, .L190+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L190+20
	str	r0, [r6]
	ldr	r6, .L190+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L190+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L190+32
	strh	r3, [r5]
.L174:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L189:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L174
	ldrh	r1, [r2, #18]
	adds	r0, r0, #21
	bl	.L32
	b	.L174
.L187:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L174
	movs	r0, #21
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L174
.L188:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L174
	ldrh	r1, [r2, #18]
	adds	r0, r0, #20
	bl	.L32
	b	.L174
.L191:
	.align	2
.L190:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368555
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_ConfigStatusREQ, .-STWI_send_ConfigStatusREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_GameConfigREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_GameConfigREQ, %function
STWI_send_GameConfigREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L226
	ldr	r2, .L226+4
	ldrh	r3, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r3, #0
	bne	.LCB1504
	b	.L224	@long jump
.LCB1504:
	movs	r3, #44
	ldrb	r4, [r2, r3]
	cmp	r4, #1
	bne	.LCB1510
	b	.L225	@long jump
.LCB1510:
	ldrb	r4, [r2, #20]
	cmp	r4, #0
	bne	.L198
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L192
	movs	r0, #22
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L192
.L198:
	movs	r4, #1
	strb	r4, [r2, r3]
	movs	r3, #22
	movs	r4, #0
	strb	r3, [r2, #6]
	movs	r3, #0
	strb	r4, [r2, #21]
	str	r3, [r2]
	strb	r4, [r2, #16]
	movs	r4, #128
	strb	r3, [r2, #5]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	strh	r3, [r2, #18]
	str	r3, [r2, #12]
	ldr	r3, .L226+8
	lsls	r4, r4, #1
	strh	r4, [r3]
	ldr	r3, .L226+12
	ldr	r4, .L226+16
	strh	r4, [r3]
	movs	r3, #6
	strb	r3, [r2, #4]
	ldr	r3, [r2, #36]
	ldrh	r4, [r0]
	strh	r4, [r3, #4]
	adds	r4, r3, #6
	movs	r5, r4
	adds	r6, r0, #2
	orrs	r5, r6
	lsls	r5, r5, #30
	bne	.L199
	adds	r5, r0, #3
	subs	r5, r4, r5
	cmp	r5, #2
	bls	.L199
	ldr	r5, [r6]
	str	r5, [r4]
	adds	r4, r0, #6
	ldr	r5, [r4]
	movs	r4, r3
	adds	r4, r4, #10
	str	r5, [r4]
	movs	r4, r0
	adds	r4, r4, #10
	ldr	r5, [r4]
	movs	r4, r3
	adds	r4, r4, #14
	str	r5, [r4]
	ldrb	r4, [r0, #14]
	strb	r4, [r3, #18]
	ldrb	r0, [r0, #15]
.L200:
	strb	r0, [r3, #19]
	movs	r0, r3
	movs	r4, r1
	adds	r0, r0, #20
	orrs	r4, r0
	lsls	r4, r4, #30
	bne	.L201
	adds	r4, r1, #1
	subs	r0, r0, r4
	cmp	r0, #2
	bls	.L201
	ldr	r0, [r1]
	str	r0, [r3, #20]
	ldr	r1, [r1, #4]
	str	r1, [r3, #24]
.L202:
	ldrb	r3, [r2, #4]
	ldrb	r1, [r2, #6]
	lsls	r3, r3, #8
	orrs	r3, r1
	ldr	r1, .L226+20
	orrs	r3, r1
	ldr	r1, [r2, #36]
	str	r3, [r1]
	ldr	r1, .L226+24
	str	r3, [r1]
	movs	r3, #0
	movs	r1, #1
	str	r3, [r2]
	strb	r1, [r2, #5]
	ldr	r0, .L226
	ldrh	r4, [r0]
	strh	r3, [r0]
	ldrb	r5, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r5
	ldr	r1, .L226+28
	ldrh	r3, [r1]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1]
	ldrh	r3, [r1]
	orrs	r3, r2
	strh	r3, [r1]
	ldr	r2, .L226+32
	ldr	r3, .L226+12
	strh	r4, [r0]
	strh	r2, [r3]
.L192:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L224:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L192
.L223:
	movs	r0, #22
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L192
.L199:
	ldrb	r4, [r0, #2]
	strb	r4, [r3, #6]
	ldrb	r4, [r0, #3]
	strb	r4, [r3, #7]
	ldrb	r4, [r0, #4]
	strb	r4, [r3, #8]
	ldrb	r4, [r0, #5]
	strb	r4, [r3, #9]
	ldrb	r4, [r0, #6]
	strb	r4, [r3, #10]
	ldrb	r4, [r0, #7]
	strb	r4, [r3, #11]
	ldrb	r4, [r0, #8]
	strb	r4, [r3, #12]
	ldrb	r4, [r0, #9]
	strb	r4, [r3, #13]
	ldrb	r4, [r0, #10]
	strb	r4, [r3, #14]
	ldrb	r4, [r0, #11]
	strb	r4, [r3, #15]
	ldrb	r4, [r0, #12]
	strb	r4, [r3, #16]
	ldrb	r4, [r0, #13]
	strb	r4, [r3, #17]
	ldrb	r4, [r0, #14]
	strb	r4, [r3, #18]
	ldrb	r0, [r0, #15]
	b	.L200
.L225:
	movs	r1, #2
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	bne	.L223
	b	.L192
.L201:
	ldrb	r0, [r1]
	strb	r0, [r3, #20]
	ldrb	r0, [r1, #1]
	strb	r0, [r3, #21]
	ldrb	r0, [r1, #2]
	strb	r0, [r3, #22]
	ldrb	r0, [r1, #3]
	strb	r0, [r3, #23]
	ldrb	r0, [r1, #4]
	strb	r0, [r3, #24]
	ldrb	r0, [r1, #5]
	strb	r0, [r3, #25]
	ldrb	r0, [r1, #6]
	strb	r0, [r3, #26]
	ldrb	r1, [r1, #7]
	strb	r1, [r3, #27]
	b	.L202
.L227:
	.align	2
.L226:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368576
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_GameConfigREQ, .-STWI_send_GameConfigREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SystemConfigREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SystemConfigREQ, %function
STWI_send_SystemConfigREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r8
	ldr	r6, .L245
	ldr	r4, .L245+4
	ldrh	r3, [r6]
	movs	r5, r2
	push	{lr}
	ldr	r2, [r4]
	cmp	r3, #0
	beq	.L242
	movs	r3, #44
	ldrb	r4, [r2, r3]
	cmp	r4, #1
	beq	.L243
	ldrb	r4, [r2, #20]
	cmp	r4, #0
	beq	.L244
	movs	r4, #1
	strb	r4, [r2, r3]
	movs	r3, #23
	mov	r8, r4
	strb	r3, [r2, #6]
	movs	r4, #0
	movs	r3, #0
	movs	r7, #128
	str	r3, [r2]
	strb	r4, [r2, #21]
	strb	r4, [r2, #16]
	ldr	r4, .L245+8
	lsls	r7, r7, #1
	strh	r3, [r2, #18]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	str	r3, [r2, #12]
	strh	r7, [r4]
	ldr	r4, .L245+12
	ldr	r7, .L245+16
	strh	r7, [r4]
	mov	r7, r8
	strb	r7, [r2, #4]
	ldr	r7, [r2, #36]
	strb	r5, [r7, #4]
	strb	r1, [r7, #5]
	strh	r0, [r7, #6]
	ldrb	r1, [r2, #4]
	ldrb	r0, [r2, #6]
	lsls	r1, r1, #8
	orrs	r1, r0
	ldr	r0, .L245+20
	orrs	r1, r0
	ldr	r0, [r2, #36]
	str	r1, [r0]
	ldr	r0, .L245+24
	str	r1, [r0]
	mov	r1, r8
	str	r3, [r2]
	strb	r1, [r2, #5]
	ldrh	r0, [r6]
	strh	r3, [r6]
	ldrb	r5, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r5
	ldr	r1, .L245+28
	ldrh	r3, [r1]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1]
	ldrh	r3, [r1]
	orrs	r3, r2
	strh	r3, [r1]
	ldr	r3, .L245+32
	strh	r0, [r6]
	strh	r3, [r4]
.L228:
	@ sp needed
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L244:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L228
	movs	r0, #23
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L228
.L242:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L228
.L241:
	movs	r0, #23
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L228
.L243:
	movs	r1, #2
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	bne	.L241
	b	.L228
.L246:
	.align	2
.L245:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368576
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SystemConfigREQ, .-STWI_send_SystemConfigREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SC_StartREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SC_StartREQ, %function
STWI_send_SC_StartREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L263
	ldr	r2, .L263+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L260
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L261
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L262
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #25
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L263+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L263+12
	ldr	r6, .L263+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L263+20
	str	r0, [r6]
	ldr	r6, .L263+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L263+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L263+32
	strh	r3, [r5]
.L247:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L262:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L247
	ldrh	r1, [r2, #18]
	adds	r0, r0, #25
	bl	.L32
	b	.L247
.L260:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L247
	movs	r0, #25
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L247
.L261:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L247
	ldrh	r1, [r2, #18]
	adds	r0, r0, #24
	bl	.L32
	b	.L247
.L264:
	.align	2
.L263:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368551
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SC_StartREQ, .-STWI_send_SC_StartREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SC_PollingREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SC_PollingREQ, %function
STWI_send_SC_PollingREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L281
	ldr	r2, .L281+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L278
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L279
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L280
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #26
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L281+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L281+12
	ldr	r6, .L281+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L281+20
	str	r0, [r6]
	ldr	r6, .L281+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L281+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L281+32
	strh	r3, [r5]
.L265:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L280:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L265
	ldrh	r1, [r2, #18]
	adds	r0, r0, #26
	bl	.L32
	b	.L265
.L278:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L265
	movs	r0, #26
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L265
.L279:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L265
	ldrh	r1, [r2, #18]
	adds	r0, r0, #25
	bl	.L32
	b	.L265
.L282:
	.align	2
.L281:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368550
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SC_PollingREQ, .-STWI_send_SC_PollingREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SC_EndREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SC_EndREQ, %function
STWI_send_SC_EndREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L299
	ldr	r2, .L299+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L296
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L297
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L298
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #27
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L299+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L299+12
	ldr	r6, .L299+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L299+20
	str	r0, [r6]
	ldr	r6, .L299+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L299+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L299+32
	strh	r3, [r5]
.L283:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L298:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L283
	ldrh	r1, [r2, #18]
	adds	r0, r0, #27
	bl	.L32
	b	.L283
.L296:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L283
	movs	r0, #27
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L283
.L297:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L283
	ldrh	r1, [r2, #18]
	adds	r0, r0, #26
	bl	.L32
	b	.L283
.L300:
	.align	2
.L299:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368549
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SC_EndREQ, .-STWI_send_SC_EndREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SP_StartREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SP_StartREQ, %function
STWI_send_SP_StartREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L317
	ldr	r2, .L317+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L314
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L315
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L316
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #28
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L317+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L317+12
	ldr	r6, .L317+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L317+20
	str	r0, [r6]
	ldr	r6, .L317+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L317+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L317+32
	strh	r3, [r5]
.L301:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L316:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L301
	ldrh	r1, [r2, #18]
	adds	r0, r0, #28
	bl	.L32
	b	.L301
.L314:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L301
	movs	r0, #28
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L301
.L315:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L301
	ldrh	r1, [r2, #18]
	adds	r0, r0, #27
	bl	.L32
	b	.L301
.L318:
	.align	2
.L317:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368548
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SP_StartREQ, .-STWI_send_SP_StartREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SP_PollingREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SP_PollingREQ, %function
STWI_send_SP_PollingREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L335
	ldr	r2, .L335+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L332
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L333
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L334
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #29
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L335+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L335+12
	ldr	r6, .L335+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L335+20
	str	r0, [r6]
	ldr	r6, .L335+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L335+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L335+32
	strh	r3, [r5]
.L319:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L334:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L319
	ldrh	r1, [r2, #18]
	adds	r0, r0, #29
	bl	.L32
	b	.L319
.L332:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L319
	movs	r0, #29
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L319
.L333:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L319
	ldrh	r1, [r2, #18]
	adds	r0, r0, #28
	bl	.L32
	b	.L319
.L336:
	.align	2
.L335:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368547
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SP_PollingREQ, .-STWI_send_SP_PollingREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_SP_EndREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_SP_EndREQ, %function
STWI_send_SP_EndREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L353
	ldr	r2, .L353+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L350
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L351
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L352
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #30
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L353+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L353+12
	ldr	r6, .L353+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L353+20
	str	r0, [r6]
	ldr	r6, .L353+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L353+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L353+32
	strh	r3, [r5]
.L337:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L352:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L337
	ldrh	r1, [r2, #18]
	adds	r0, r0, #30
	bl	.L32
	b	.L337
.L350:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L337
	movs	r0, #30
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L337
.L351:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L337
	ldrh	r1, [r2, #18]
	adds	r0, r0, #29
	bl	.L32
	b	.L337
.L354:
	.align	2
.L353:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368546
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_SP_EndREQ, .-STWI_send_SP_EndREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_CP_StartREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_CP_StartREQ, %function
STWI_send_CP_StartREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L372
	ldr	r2, .L372+4
	ldrh	r3, [r1]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r3, #0
	beq	.L369
	movs	r3, #44
	ldrb	r4, [r2, r3]
	cmp	r4, #1
	beq	.L370
	ldrb	r4, [r2, #20]
	cmp	r4, #0
	beq	.L371
	movs	r4, #1
	strb	r4, [r2, r3]
	movs	r3, #31
	movs	r5, #0
	strb	r3, [r2, #6]
	movs	r3, #0
	movs	r6, #128
	str	r3, [r2]
	strb	r5, [r2, #21]
	strb	r5, [r2, #16]
	ldr	r5, .L372+8
	lsls	r6, r6, #1
	strh	r3, [r2, #18]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	str	r3, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L372+12
	ldr	r6, .L372+16
	strh	r6, [r5]
	ldr	r6, [r2, #36]
	strb	r4, [r2, #4]
	str	r0, [r6, #4]
	ldr	r0, .L372+20
	str	r0, [r6]
	ldr	r6, .L372+24
	str	r0, [r6]
	str	r3, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r1]
	strh	r3, [r1]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L372+28
	ldrh	r3, [r0]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r0]
	ldrh	r3, [r0]
	orrs	r3, r2
	strh	r3, [r0]
	ldr	r3, .L372+32
	strh	r4, [r1]
	strh	r3, [r5]
.L355:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L371:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L355
	movs	r0, #31
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L355
.L369:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L355
.L368:
	movs	r0, #31
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L355
.L370:
	movs	r1, #2
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	bne	.L368
	b	.L355
.L373:
	.align	2
.L372:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368289
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_CP_StartREQ, .-STWI_send_CP_StartREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_CP_PollingREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_CP_PollingREQ, %function
STWI_send_CP_PollingREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L390
	ldr	r2, .L390+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L387
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L388
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L389
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #32
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L390+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L390+12
	ldr	r6, .L390+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L390+20
	str	r0, [r6]
	ldr	r6, .L390+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L390+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L390+32
	strh	r3, [r5]
.L374:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L389:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L374
	ldrh	r1, [r2, #18]
	adds	r0, r0, #32
	bl	.L32
	b	.L374
.L387:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L374
	movs	r0, #32
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L374
.L388:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L374
	ldrh	r1, [r2, #18]
	adds	r0, r0, #31
	bl	.L32
	b	.L374
.L391:
	.align	2
.L390:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368544
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_CP_PollingREQ, .-STWI_send_CP_PollingREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_CP_EndREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_CP_EndREQ, %function
STWI_send_CP_EndREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L408
	ldr	r2, .L408+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L405
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L406
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L407
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #33
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L408+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L408+12
	ldr	r6, .L408+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L408+20
	str	r0, [r6]
	ldr	r6, .L408+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L408+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L408+32
	strh	r3, [r5]
.L392:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L407:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L392
	ldrh	r1, [r2, #18]
	adds	r0, r0, #33
	bl	.L32
	b	.L392
.L405:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L392
	movs	r0, #33
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L392
.L406:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L392
	ldrh	r1, [r2, #18]
	adds	r0, r0, #32
	bl	.L32
	b	.L392
.L409:
	.align	2
.L408:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368543
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_CP_EndREQ, .-STWI_send_CP_EndREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_DataTxREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_DataTxREQ, %function
STWI_send_DataTxREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L432
	push	{r4, r5, r6, lr}
	ldrh	r2, [r3]
	ldr	r4, .L432+4
	ldr	r3, [r4]
	cmp	r2, #0
	beq	.L429
	movs	r2, #44
	ldrb	r5, [r3, r2]
	cmp	r5, #1
	beq	.L430
	ldrb	r5, [r3, #20]
	cmp	r5, #0
	bne	.L416
	movs	r2, #4
	ldr	r4, [r3, #24]
	strh	r2, [r3, #18]
	cmp	r4, #0
	beq	.L410
	movs	r2, r3
	movs	r0, #36
	ldrh	r1, [r3, #18]
	bl	.L434
	b	.L410
.L416:
	movs	r5, #1
	strb	r5, [r3, r2]
	movs	r2, #36
	movs	r5, #0
	strb	r2, [r3, #6]
	movs	r2, #0
	strb	r5, [r3, #21]
	str	r2, [r3]
	strb	r5, [r3, #16]
	movs	r5, #128
	strb	r2, [r3, #5]
	strb	r2, [r3, #7]
	strh	r2, [r3, #8]
	str	r2, [r3, #12]
	strh	r2, [r3, #18]
	ldr	r2, .L432+8
	lsls	r5, r5, #1
	strh	r5, [r2]
	ldr	r5, .L432+12
	ldr	r2, .L432+16
	strh	r5, [r2]
	lsrs	r5, r1, #2
	lsls	r1, r1, #30
	bne	.L431
.L417:
	movs	r2, #128
	ldr	r1, [r3, #36]
	lsls	r2, r2, #19
	strb	r5, [r3, #4]
	orrs	r2, r5
	adds	r1, r1, #4
	bl	CpuSet
	ldr	r1, [r4]
	ldrb	r3, [r1, #4]
	ldrb	r2, [r1, #6]
	lsls	r3, r3, #8
	orrs	r3, r2
	ldr	r2, .L432+20
	orrs	r3, r2
	ldr	r2, [r1, #36]
	str	r3, [r2]
	ldr	r2, .L432+24
	str	r3, [r2]
	movs	r3, #0
	movs	r2, #1
	str	r3, [r1]
	strb	r2, [r1, #5]
	ldr	r4, .L432
	ldrh	r5, [r4]
	strh	r3, [r4]
	ldrb	r1, [r1, #10]
	adds	r2, r2, #7
	lsls	r2, r2, r1
	ldr	r0, .L432+28
	ldrh	r3, [r0]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r0]
	ldrh	r3, [r0]
	orrs	r3, r2
	strh	r3, [r0]
	ldr	r2, .L432+32
	ldr	r3, .L432+16
	strh	r5, [r4]
	strh	r2, [r3]
.L410:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L431:
	adds	r5, r5, #1
	b	.L417
.L429:
	adds	r2, r2, #6
	strh	r2, [r3, #18]
	ldr	r2, [r3, #24]
	cmp	r2, #0
	beq	.L410
.L428:
	movs	r0, #36
	ldrh	r1, [r3, #18]
	bl	.L435
	b	.L410
.L430:
	movs	r1, #2
	strh	r1, [r3, #18]
	movs	r1, #0
	strb	r1, [r3, r2]
	ldr	r2, [r3, #24]
	cmp	r2, #0
	bne	.L428
	b	.L410
.L433:
	.align	2
.L432:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	20483
	.word	67109160
	.word	-1721368576
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_DataTxREQ, .-STWI_send_DataTxREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_DataTxAndChangeREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_DataTxAndChangeREQ, %function
STWI_send_DataTxAndChangeREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L458
	push	{r4, r5, r6, lr}
	ldrh	r2, [r3]
	ldr	r4, .L458+4
	ldr	r3, [r4]
	cmp	r2, #0
	beq	.L455
	movs	r2, #44
	ldrb	r5, [r3, r2]
	cmp	r5, #1
	beq	.L456
	ldrb	r5, [r3, #20]
	cmp	r5, #0
	bne	.L442
	movs	r2, #4
	ldr	r4, [r3, #24]
	strh	r2, [r3, #18]
	cmp	r4, #0
	beq	.L436
	movs	r2, r3
	movs	r0, #37
	ldrh	r1, [r3, #18]
	bl	.L434
	b	.L436
.L442:
	movs	r5, #1
	strb	r5, [r3, r2]
	movs	r2, #37
	movs	r5, #0
	strb	r2, [r3, #6]
	movs	r2, #0
	strb	r5, [r3, #21]
	str	r2, [r3]
	strb	r5, [r3, #16]
	movs	r5, #128
	strb	r2, [r3, #5]
	strb	r2, [r3, #7]
	strh	r2, [r3, #8]
	str	r2, [r3, #12]
	strh	r2, [r3, #18]
	ldr	r2, .L458+8
	lsls	r5, r5, #1
	strh	r5, [r2]
	ldr	r5, .L458+12
	ldr	r2, .L458+16
	strh	r5, [r2]
	lsrs	r5, r1, #2
	lsls	r1, r1, #30
	bne	.L457
.L443:
	movs	r2, #128
	ldr	r1, [r3, #36]
	lsls	r2, r2, #19
	strb	r5, [r3, #4]
	orrs	r2, r5
	adds	r1, r1, #4
	bl	CpuSet
	ldr	r1, [r4]
	ldrb	r3, [r1, #4]
	ldrb	r2, [r1, #6]
	lsls	r3, r3, #8
	orrs	r3, r2
	ldr	r2, .L458+20
	orrs	r3, r2
	ldr	r2, [r1, #36]
	str	r3, [r2]
	ldr	r2, .L458+24
	str	r3, [r2]
	movs	r3, #0
	movs	r2, #1
	str	r3, [r1]
	strb	r2, [r1, #5]
	ldr	r4, .L458
	ldrh	r5, [r4]
	strh	r3, [r4]
	ldrb	r1, [r1, #10]
	adds	r2, r2, #7
	lsls	r2, r2, r1
	ldr	r0, .L458+28
	ldrh	r3, [r0]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r0]
	ldrh	r3, [r0]
	orrs	r3, r2
	strh	r3, [r0]
	ldr	r2, .L458+32
	ldr	r3, .L458+16
	strh	r5, [r4]
	strh	r2, [r3]
.L436:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L457:
	adds	r5, r5, #1
	b	.L443
.L455:
	adds	r2, r2, #6
	strh	r2, [r3, #18]
	ldr	r2, [r3, #24]
	cmp	r2, #0
	beq	.L436
.L454:
	movs	r0, #37
	ldrh	r1, [r3, #18]
	bl	.L435
	b	.L436
.L456:
	movs	r1, #2
	strh	r1, [r3, #18]
	movs	r1, #0
	strb	r1, [r3, r2]
	ldr	r2, [r3, #24]
	cmp	r2, #0
	bne	.L454
	b	.L436
.L459:
	.align	2
.L458:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	20483
	.word	67109160
	.word	-1721368576
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_DataTxAndChangeREQ, .-STWI_send_DataTxAndChangeREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_DataRxREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_DataRxREQ, %function
STWI_send_DataRxREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L476
	ldr	r2, .L476+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L473
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L474
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L475
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #38
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L476+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L476+12
	ldr	r6, .L476+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L476+20
	str	r0, [r6]
	ldr	r6, .L476+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L476+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L476+32
	strh	r3, [r5]
.L460:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L475:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L460
	ldrh	r1, [r2, #18]
	adds	r0, r0, #38
	bl	.L32
	b	.L460
.L473:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L460
	movs	r0, #38
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L460
.L474:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L460
	ldrh	r1, [r2, #18]
	adds	r0, r0, #37
	bl	.L32
	b	.L460
.L477:
	.align	2
.L476:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368538
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_DataRxREQ, .-STWI_send_DataRxREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_MS_ChangeREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_MS_ChangeREQ, %function
STWI_send_MS_ChangeREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L494
	ldr	r2, .L494+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L491
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L492
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L493
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #39
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L494+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L494+12
	ldr	r6, .L494+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L494+20
	str	r0, [r6]
	ldr	r6, .L494+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L494+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L494+32
	strh	r3, [r5]
.L478:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L493:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L478
	ldrh	r1, [r2, #18]
	adds	r0, r0, #39
	bl	.L32
	b	.L478
.L491:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L478
	movs	r0, #39
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L478
.L492:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L478
	ldrh	r1, [r2, #18]
	adds	r0, r0, #38
	bl	.L32
	b	.L478
.L495:
	.align	2
.L494:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368537
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_MS_ChangeREQ, .-STWI_send_MS_ChangeREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_DataReadyAndChangeREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_DataReadyAndChangeREQ, %function
STWI_send_DataReadyAndChangeREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L515
	ldr	r2, .L515+4
	ldrh	r3, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r3, #0
	beq	.L512
	movs	r3, #44
	ldrb	r1, [r2, r3]
	cmp	r1, #1
	beq	.L513
	ldrb	r1, [r2, #20]
	cmp	r1, #0
	bne	.L502
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L496
	movs	r0, #40
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L496
.L502:
	movs	r5, #1
	strb	r5, [r2, r3]
	movs	r3, #40
	movs	r1, #0
	strb	r3, [r2, #6]
	movs	r3, #0
	movs	r4, #128
	str	r3, [r2]
	strb	r3, [r2, #5]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	str	r3, [r2, #12]
	strb	r1, [r2, #16]
	strh	r3, [r2, #18]
	ldr	r3, .L515+8
	lsls	r4, r4, #1
	strb	r1, [r2, #21]
	strh	r4, [r3]
	ldr	r4, .L515+12
	ldr	r3, .L515+16
	strh	r4, [r3]
	ldr	r4, [r2, #36]
	cmp	r0, #0
	beq	.L514
	strb	r5, [r2, #4]
	strb	r0, [r4, #4]
	strb	r1, [r4, #5]
	strb	r1, [r4, #6]
	strb	r1, [r4, #7]
	ldrb	r3, [r2, #4]
	ldr	r4, [r2, #36]
	lsls	r3, r3, #8
.L504:
	ldrb	r1, [r2, #6]
	orrs	r1, r3
	ldr	r3, .L515+20
	orrs	r3, r1
	ldr	r1, .L515+24
	str	r3, [r4]
	str	r3, [r1]
	movs	r3, #0
	movs	r1, #1
	str	r3, [r2]
	strb	r1, [r2, #5]
	ldr	r0, .L515
	ldrh	r4, [r0]
	strh	r3, [r0]
	ldrb	r5, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r5
	ldr	r1, .L515+28
	ldrh	r3, [r1]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1]
	ldrh	r3, [r1]
	orrs	r3, r2
	strh	r3, [r1]
	ldr	r2, .L515+32
	ldr	r3, .L515+16
	strh	r4, [r0]
	strh	r2, [r3]
.L496:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L514:
	movs	r3, #0
	strb	r1, [r2, #4]
	b	.L504
.L512:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L496
.L511:
	movs	r0, #40
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L496
.L513:
	adds	r1, r1, #1
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	bne	.L511
	b	.L496
.L516:
	.align	2
.L515:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	20483
	.word	67109160
	.word	-1721368576
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_DataReadyAndChangeREQ, .-STWI_send_DataReadyAndChangeREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_DisconnectedAndChangeREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_DisconnectedAndChangeREQ, %function
STWI_send_DisconnectedAndChangeREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldr	r4, .L534
	ldr	r2, .L534+4
	ldrh	r3, [r4]
	ldr	r2, [r2]
	cmp	r3, #0
	beq	.L531
	movs	r3, #44
	ldrb	r5, [r2, r3]
	cmp	r5, #1
	beq	.L532
	ldrb	r5, [r2, #20]
	cmp	r5, #0
	beq	.L533
	movs	r6, #1
	strb	r6, [r2, r3]
	movs	r3, #41
	movs	r5, #0
	strb	r3, [r2, #6]
	movs	r3, #0
	movs	r7, #128
	mov	ip, r5
	str	r3, [r2]
	strb	r5, [r2, #21]
	strb	r5, [r2, #16]
	ldr	r5, .L534+8
	lsls	r7, r7, #1
	strh	r3, [r2, #18]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	str	r3, [r2, #12]
	strh	r7, [r5]
	ldr	r5, .L534+12
	ldr	r7, .L534+16
	strh	r7, [r5]
	ldr	r7, [r2, #36]
	strb	r6, [r2, #4]
	strb	r1, [r7, #5]
	mov	r1, ip
	strb	r0, [r7, #4]
	strb	r1, [r7, #6]
	strb	r1, [r7, #7]
	ldrb	r1, [r2, #4]
	ldrb	r0, [r2, #6]
	lsls	r1, r1, #8
	orrs	r1, r0
	ldr	r0, .L534+20
	orrs	r1, r0
	ldr	r0, [r2, #36]
	str	r1, [r0]
	ldr	r0, .L534+24
	str	r1, [r0]
	strb	r6, [r2, #5]
	str	r3, [r2]
	ldrh	r0, [r4]
	strh	r3, [r4]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r1, .L534+28
	ldrh	r3, [r1]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1]
	ldrh	r3, [r1]
	orrs	r3, r2
	strh	r3, [r1]
	ldr	r3, .L534+32
	strh	r0, [r4]
	strh	r3, [r5]
.L517:
	@ sp needed
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L533:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L517
	movs	r0, #41
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L517
.L531:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L517
.L530:
	movs	r0, #41
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L517
.L532:
	movs	r1, #2
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	bne	.L530
	b	.L517
.L535:
	.align	2
.L534:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368576
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_DisconnectedAndChangeREQ, .-STWI_send_DisconnectedAndChangeREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_ResumeRetransmitAndChangeREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_ResumeRetransmitAndChangeREQ, %function
STWI_send_ResumeRetransmitAndChangeREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L552
	ldr	r2, .L552+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L549
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L550
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L551
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #55
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L552+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L552+12
	ldr	r6, .L552+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L552+20
	str	r0, [r6]
	ldr	r6, .L552+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L552+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L552+32
	strh	r3, [r5]
.L536:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L551:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L536
	ldrh	r1, [r2, #18]
	adds	r0, r0, #55
	bl	.L32
	b	.L536
.L549:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L536
	movs	r0, #55
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L536
.L550:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L536
	ldrh	r1, [r2, #18]
	adds	r0, r0, #54
	bl	.L32
	b	.L536
.L553:
	.align	2
.L552:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368521
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_ResumeRetransmitAndChangeREQ, .-STWI_send_ResumeRetransmitAndChangeREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_DisconnectREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_DisconnectREQ, %function
STWI_send_DisconnectREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L571
	ldr	r2, .L571+4
	ldrh	r3, [r1]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r3, #0
	beq	.L568
	movs	r3, #44
	ldrb	r4, [r2, r3]
	cmp	r4, #1
	beq	.L569
	ldrb	r4, [r2, #20]
	cmp	r4, #0
	beq	.L570
	movs	r4, #1
	strb	r4, [r2, r3]
	movs	r3, #48
	movs	r5, #0
	strb	r3, [r2, #6]
	movs	r3, #0
	movs	r6, #128
	str	r3, [r2]
	strb	r5, [r2, #21]
	strb	r5, [r2, #16]
	ldr	r5, .L571+8
	lsls	r6, r6, #1
	strh	r3, [r2, #18]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	str	r3, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L571+12
	ldr	r6, .L571+16
	strh	r6, [r5]
	ldr	r6, [r2, #36]
	strb	r4, [r2, #4]
	str	r0, [r6, #4]
	ldr	r0, .L571+20
	str	r0, [r6]
	ldr	r6, .L571+24
	str	r0, [r6]
	str	r3, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r1]
	strh	r3, [r1]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L571+28
	ldrh	r3, [r0]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r0]
	ldrh	r3, [r0]
	orrs	r3, r2
	strh	r3, [r0]
	ldr	r3, .L571+32
	strh	r4, [r1]
	strh	r3, [r5]
.L554:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L570:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L554
	movs	r0, #48
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L554
.L568:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L554
.L567:
	movs	r0, #48
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L554
.L569:
	movs	r1, #2
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	bne	.L567
	b	.L554
.L572:
	.align	2
.L571:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368272
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_DisconnectREQ, .-STWI_send_DisconnectREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_TestModeREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_TestModeREQ, %function
STWI_send_TestModeREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldr	r5, .L589
	ldr	r2, .L589+4
	ldrh	r3, [r5]
	movs	r4, r0
	ldr	r2, [r2]
	cmp	r3, #0
	beq	.L586
	movs	r3, #44
	ldrb	r0, [r2, r3]
	cmp	r0, #1
	beq	.L587
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L588
	movs	r7, #1
	strb	r7, [r2, r3]
	movs	r3, #49
	movs	r0, #0
	strb	r3, [r2, #6]
	movs	r3, #0
	movs	r6, #128
	str	r3, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	ldr	r0, .L589+8
	lsls	r6, r6, #1
	strh	r3, [r2, #18]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	str	r3, [r2, #12]
	strh	r6, [r0]
	ldr	r6, .L589+12
	ldr	r0, .L589+16
	strh	r0, [r6]
	ldr	r0, [r2, #36]
	mov	ip, r0
	lsls	r0, r1, #8
	mov	r1, ip
	orrs	r0, r4
	strb	r7, [r2, #4]
	str	r0, [r1, #4]
	mov	r0, ip
	ldr	r1, .L589+20
	str	r1, [r0]
	ldr	r0, .L589+24
	str	r1, [r0]
	str	r3, [r2]
	strb	r7, [r2, #5]
	ldrh	r0, [r5]
	strh	r3, [r5]
	ldrb	r4, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r4
	ldr	r1, .L589+28
	ldrh	r3, [r1]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1]
	ldrh	r3, [r1]
	orrs	r3, r2
	strh	r3, [r1]
	ldr	r3, .L589+32
	strh	r0, [r5]
	strh	r3, [r6]
.L573:
	@ sp needed
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L588:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L573
	ldrh	r1, [r2, #18]
	adds	r0, r0, #49
	bl	.L32
	b	.L573
.L586:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L573
	movs	r0, #49
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L573
.L587:
	movs	r1, #2
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L573
	ldrh	r1, [r2, #18]
	adds	r0, r0, #48
	bl	.L32
	b	.L573
.L590:
	.align	2
.L589:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368271
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_TestModeREQ, .-STWI_send_TestModeREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_CPR_StartREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_CPR_StartREQ, %function
STWI_send_CPR_StartREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r8
	ldr	r7, .L608
	ldr	r4, .L608+4
	ldrh	r3, [r7]
	movs	r5, r2
	movs	r6, r1
	push	{lr}
	ldr	r2, [r4]
	cmp	r3, #0
	beq	.L605
	movs	r3, #44
	ldrb	r1, [r2, r3]
	cmp	r1, #1
	beq	.L606
	ldrb	r1, [r2, #20]
	cmp	r1, #0
	beq	.L607
	movs	r1, #1
	strb	r1, [r2, r3]
	movs	r3, #50
	mov	r8, r1
	strb	r3, [r2, #6]
	movs	r1, #0
	movs	r3, #0
	movs	r4, #128
	str	r3, [r2]
	strb	r1, [r2, #21]
	strb	r1, [r2, #16]
	ldr	r1, .L608+8
	lsls	r4, r4, #1
	strh	r3, [r2, #18]
	strb	r3, [r2, #7]
	strh	r3, [r2, #8]
	str	r3, [r2, #12]
	strh	r4, [r1]
	ldr	r4, .L608+12
	ldr	r1, .L608+16
	strh	r1, [r4]
	movs	r1, #2
	strb	r1, [r2, #4]
	ldr	r1, [r2, #36]
	mov	ip, r1
	lsls	r1, r0, #16
	mov	r0, ip
	orrs	r1, r6
	str	r1, [r0, #4]
	ldr	r1, .L608+20
	str	r5, [r0, #8]
	str	r1, [r0]
	ldr	r0, .L608+24
	str	r1, [r0]
	mov	r1, r8
	str	r3, [r2]
	strb	r1, [r2, #5]
	ldrh	r0, [r7]
	strh	r3, [r7]
	ldrb	r5, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r5
	ldr	r1, .L608+28
	ldrh	r3, [r1]
	orrs	r3, r2
	movs	r2, #128
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	strh	r3, [r1]
	ldrh	r3, [r1]
	orrs	r3, r2
	strh	r3, [r1]
	ldr	r3, .L608+32
	strh	r0, [r7]
	strh	r3, [r4]
.L591:
	@ sp needed
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L607:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L591
	movs	r0, #50
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L591
.L605:
	adds	r3, r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L591
.L604:
	movs	r0, #50
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L591
.L606:
	adds	r1, r1, #1
	strh	r1, [r2, #18]
	movs	r1, #0
	strb	r1, [r2, r3]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	bne	.L604
	b	.L591
.L609:
	.align	2
.L608:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368014
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_CPR_StartREQ, .-STWI_send_CPR_StartREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_CPR_PollingREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_CPR_PollingREQ, %function
STWI_send_CPR_PollingREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L626
	ldr	r2, .L626+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L623
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L624
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L625
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #51
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L626+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L626+12
	ldr	r6, .L626+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L626+20
	str	r0, [r6]
	ldr	r6, .L626+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L626+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L626+32
	strh	r3, [r5]
.L610:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L625:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L610
	ldrh	r1, [r2, #18]
	adds	r0, r0, #51
	bl	.L32
	b	.L610
.L623:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L610
	movs	r0, #51
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L610
.L624:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L610
	ldrh	r1, [r2, #18]
	adds	r0, r0, #50
	bl	.L32
	b	.L610
.L627:
	.align	2
.L626:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368525
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_CPR_PollingREQ, .-STWI_send_CPR_PollingREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_CPR_EndREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_CPR_EndREQ, %function
STWI_send_CPR_EndREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L644
	ldr	r2, .L644+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L641
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L642
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L643
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #52
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L644+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L644+12
	ldr	r6, .L644+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L644+20
	str	r0, [r6]
	ldr	r6, .L644+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L644+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L644+32
	strh	r3, [r5]
.L628:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L643:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L628
	ldrh	r1, [r2, #18]
	adds	r0, r0, #52
	bl	.L32
	b	.L628
.L641:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L628
	movs	r0, #52
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L628
.L642:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L628
	ldrh	r1, [r2, #18]
	adds	r0, r0, #51
	bl	.L32
	b	.L628
.L645:
	.align	2
.L644:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368524
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_CPR_EndREQ, .-STWI_send_CPR_EndREQ
	.align	1
	.p2align 2,,3
	.global	STWI_send_StopModeREQ
	.syntax unified
	.code	16
	.thumb_func
	.type	STWI_send_StopModeREQ, %function
STWI_send_StopModeREQ:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L662
	ldr	r2, .L662+4
	ldrh	r1, [r3]
	push	{r4, r5, r6, lr}
	ldr	r2, [r2]
	cmp	r1, #0
	beq	.L659
	movs	r1, #44
	ldrb	r0, [r2, r1]
	cmp	r0, #1
	beq	.L660
	ldrb	r0, [r2, #20]
	cmp	r0, #0
	beq	.L661
	movs	r4, #1
	strb	r4, [r2, r1]
	movs	r1, #61
	movs	r6, #128
	strb	r1, [r2, #6]
	movs	r0, #0
	movs	r1, #0
	ldr	r5, .L662+8
	lsls	r6, r6, #1
	str	r1, [r2]
	strb	r0, [r2, #21]
	strb	r0, [r2, #16]
	strb	r1, [r2, #7]
	strh	r1, [r2, #18]
	strh	r1, [r2, #8]
	str	r1, [r2, #12]
	strh	r6, [r5]
	ldr	r5, .L662+12
	ldr	r6, .L662+16
	strh	r6, [r5]
	strb	r0, [r2, #4]
	ldr	r6, [r2, #36]
	ldr	r0, .L662+20
	str	r0, [r6]
	ldr	r6, .L662+24
	str	r0, [r6]
	str	r1, [r2]
	strb	r4, [r2, #5]
	ldrh	r4, [r3]
	strh	r1, [r3]
	ldrb	r6, [r2, #10]
	movs	r2, #8
	lsls	r2, r2, r6
	ldr	r0, .L662+28
	ldrh	r1, [r0]
	orrs	r1, r2
	lsls	r1, r1, #16
	lsrs	r1, r1, #16
	strh	r1, [r0]
	movs	r1, #128
	ldrh	r2, [r0]
	orrs	r2, r1
	strh	r2, [r0]
	strh	r4, [r3]
	ldr	r3, .L662+32
	strh	r3, [r5]
.L646:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L661:
	movs	r3, #4
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L646
	ldrh	r1, [r2, #18]
	adds	r0, r0, #61
	bl	.L32
	b	.L646
.L659:
	movs	r3, #6
	strh	r3, [r2, #18]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L646
	movs	r0, #61
	ldrh	r1, [r2, #18]
	bl	.L32
	b	.L646
.L660:
	movs	r3, #2
	strh	r3, [r2, #18]
	movs	r3, #0
	strb	r3, [r2, r1]
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L646
	ldrh	r1, [r2, #18]
	adds	r0, r0, #60
	bl	.L32
	b	.L646
.L663:
	.align	2
.L662:
	.word	67109384
	.word	.LANCHOR0
	.word	67109172
	.word	67109160
	.word	20483
	.word	-1721368515
	.word	67109152
	.word	67109376
	.word	20611
	.size	STWI_send_StopModeREQ, .-STWI_send_StopModeREQ
	.global	gSTWIStatus
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	gSTWIStatus, %object
	.size	gSTWIStatus, 4
gSTWIStatus:
	.space	4
	.ident	"GCC: (devkitARM release 62) 13.2.0"
	.text
	.code 16
	.align	1
.L435:
	bx	r2
.L32:
	bx	r3
.L434:
	bx	r4
.L31:
	bx	r5
.text
	.align	2, 0

