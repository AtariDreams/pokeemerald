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
	.align	2
	.global	IntrSIO32
	.syntax unified
	.arm
	.type	IntrSIO32, %function
IntrSIO32:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L8
	ldr	r3, [r3]
	ldr	r2, [r3]
	cmp	r2, #10
	beq	.L6
	ldrb	r3, [r3, #20]	@ zero_extendqisi2
	cmp	r3, #1
	bne	sio32intr_clock_slave
.L7:
	b	sio32intr_clock_master
.L6:
	ldr	r0, [r3, #32]
	cmp	r0, #0
	bxeq	lr
	b	Callback_Dummy_ID
.L9:
	.align	2
.L8:
	.word	gSTWIStatus
	.size	IntrSIO32, .-IntrSIO32
	.align	2
	.syntax unified
	.arm
	.type	sio32intr_clock_master, %function
sio32intr_clock_master:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r2, #524288
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r7, #2
	mov	r6, #0
	mov	r5, #195
	mov	lr, #1
	mov	r4, #67108864
	ldr	r3, .L44
	ldr	r3, [r3]
	ldrb	ip, [r3, #10]	@ zero_extendqisi2
	add	r1, ip, #16777216
	ldr	r0, .L44+4
	lsl	r2, r2, ip
	add	r1, r1, #64
	ldr	ip, .L44+8
	lsl	r1, r1, r7
	lsr	r2, r2, #16
	strh	r6, [r0, #8]	@ movhi
	strh	ip, [r1]	@ movhi
	str	r7, [r3, #12]
	strh	r5, [r1, #2]	@ movhi
	strh	r2, [r0, #2]	@ movhi
	strh	lr, [r0, #8]	@ movhi
	ldr	r8, [r4, #288]
	ldr	ip, [r3]
	cmp	ip, r6
	bne	.L11
	cmp	r8, #-2147483648
	bne	.L12
	ldrb	r2, [r3, #5]	@ zero_extendqisi2
	ldrb	r0, [r3, #4]	@ zero_extendqisi2
	cmp	r0, r2
	ldrcs	r0, [r3, #36]
	ldrcs	r0, [r0, r2, lsl #2]
	addcs	r2, r2, lr
	strcs	r0, [r4, #288]
	strcc	lr, [r3]
	strbcs	r2, [r3, #5]
	strcc	r8, [r4, #288]
	b	.L14
.L11:
	ldr	ip, [r3]
	cmp	ip, #1
	beq	.L39
	ldr	r2, [r3]
	cmp	r2, #2
	beq	.L40
.L14:
	ldr	r0, .L44+12
	b	.L21
.L20:
	ldrh	r2, [r0, #40]
	tst	r2, #4
	bne	.L41
.L21:
	ldrb	r2, [r3, #16]	@ zero_extendqisi2
	cmp	r2, #1
	bne	.L20
.L38:
	mov	r2, #0
	strb	r2, [r3, #16]
.L10:
	pop	{r4, r5, r6, r7, r8, r9, lr}
	bx	lr
.L12:
	strh	ip, [r1]	@ movhi
	strh	ip, [r1, #2]	@ movhi
	strh	ip, [r0, #8]	@ movhi
	mov	ip, #4
	ldr	r4, .L44+16
	strh	r4, [r1]	@ movhi
	str	ip, [r3, #12]
	strh	r5, [r1, #2]	@ movhi
	strh	r2, [r0, #2]	@ movhi
	strh	lr, [r0, #8]	@ movhi
	pop	{r4, r5, r6, r7, r8, r9, lr}
	bx	lr
.L41:
	ldr	r2, .L44+20
	ldr	ip, .L44+12
	strh	r2, [r0, #40]	@ movhi
	b	.L23
.L22:
	ldrh	r2, [ip, #40]
	ands	r2, r2, #4
	beq	.L42
.L23:
	ldrb	r2, [r3, #16]	@ zero_extendqisi2
	cmp	r2, #1
	bne	.L22
	b	.L38
.L39:
	ldr	r9, .L44+24
	lsr	lr, r8, #16
	lsl	lr, lr, #16
	cmp	lr, r9
	bne	.L17
	lsr	r2, r8, #8
	and	r2, r2, #255
	ldr	r0, [r3, #40]
	cmp	r2, #0
	str	r8, [r0]
	strb	ip, [r3, #8]
	strb	r8, [r3, #9]
	strb	r2, [r3, #7]
	beq	.L37
	mov	r2, #-2147483648
	str	r7, [r3]
	str	r2, [r4, #288]
	b	.L14
.L40:
	ldrb	r2, [r3, #8]	@ zero_extendqisi2
	ldr	r0, [r3, #40]
	str	r8, [r0, r2, lsl #2]
	add	r2, r2, #1
	ldrb	r0, [r3, #7]	@ zero_extendqisi2
	and	r2, r2, #255
	cmp	r0, r2
	strb	r2, [r3, #8]
	movcs	r2, #-2147483648
	strcs	r2, [r4, #288]
	bcs	.L14
.L37:
	mov	r2, #3
	str	r2, [r3]
	b	.L14
.L42:
	str	r2, [r3, #12]
	strh	r2, [r1]	@ movhi
	strh	r2, [r1, #2]	@ movhi
	ldr	r1, [r3]
	cmp	r1, #3
	beq	.L43
	ldr	r2, .L44+28
	ldr	r3, .L44+32
	strh	r2, [ip, #40]	@ movhi
	pop	{r4, r5, r6, r7, r8, r9, lr}
	strh	r3, [ip, #40]	@ movhi
	bx	lr
.L17:
	mov	lr, #4
	ldr	r4, .L44+16
	strh	r6, [r1]	@ movhi
	strh	r6, [r1, #2]	@ movhi
	strh	r6, [r0, #8]	@ movhi
	strh	r4, [r1]	@ movhi
	str	lr, [r3, #12]
	strh	r5, [r1, #2]	@ movhi
	strh	r2, [r0, #2]	@ movhi
	strh	ip, [r0, #8]	@ movhi
	b	.L10
.L43:
	ldrb	r0, [r3, #9]	@ zero_extendqisi2
	cmp	r0, #183
	bhi	.L25
	cmp	r0, #164
	bls	.L26
	ldr	lr, .L44+36
	add	r1, r0, #91
	and	r1, r1, #255
	lsr	r1, lr, r1
	tst	r1, #1
	beq	.L26
	strb	r2, [r3, #20]
	mov	lr, #67108864
	mov	r4, #-2147483648
	mov	r2, #5
	ldr	r0, .L44+40
	ldr	r1, .L44+44
	str	r4, [lr, #288]
	strh	r0, [ip, #40]	@ movhi
	strh	r1, [ip, #40]	@ movhi
	str	r2, [r3]
.L29:
	mov	r1, #0
	ldr	r2, [r3, #24]
	cmp	r2, r1
	strb	r1, [r3, #44]
	beq	.L10
	ldrh	r1, [r3, #18]
	ldrb	r0, [r3, #6]	@ zero_extendqisi2
	pop	{r4, r5, r6, r7, r8, r9, lr}
	b	Callback_Dummy_M
.L25:
	cmp	r0, #238
	bne	.L26
	mov	r2, #4
	ldr	r0, .L44+28
	strh	r0, [ip, #40]	@ movhi
	str	r2, [r3]
	strh	r1, [r3, #18]	@ movhi
	b	.L29
.L26:
	mov	r2, #4
	ldr	r1, .L44+12
	ldr	r0, .L44+28
	strh	r0, [r1, #40]	@ movhi
	str	r2, [r3]
	b	.L29
.L45:
	.align	2
.L44:
	.word	gSTWIStatus
	.word	67109376
	.word	-1312
	.word	67109120
	.word	-2131
	.word	20491
	.word	-1721368576
	.word	20483
	.word	20611
	.word	327685
	.word	20482
	.word	20610
	.size	sio32intr_clock_master, .-sio32intr_clock_master
	.align	2
	.syntax unified
	.arm
	.type	sio32intr_clock_slave, %function
sio32intr_clock_slave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r0, #524288
	push	{r4, r5, r6, r7, r8, lr}
	mov	lr, #0
	mov	r7, #3
	mov	r6, #195
	mov	r5, #1
	ldr	r2, .L99
	ldr	r2, [r2]
	ldrb	r4, [r2, #10]	@ zero_extendqisi2
	add	r1, r4, #16777216
	ldr	r3, .L99+4
	add	r1, r1, #64
	ldr	r8, .L99+8
	lsl	r0, r0, r4
	lsl	ip, r1, #2
	lsr	r0, r0, #16
	strb	lr, [r2, #16]
	ldr	r1, .L99+12
	strh	lr, [r3, #8]	@ movhi
	strh	r8, [ip]	@ movhi
	str	r7, [r2, #12]
	strh	r6, [ip, #2]	@ movhi
	strh	r0, [r3, #2]	@ movhi
	strh	r5, [r3, #8]	@ movhi
	b	.L49
.L47:
	ldrh	r3, [r1, #40]
	ands	r3, r3, #4
	beq	.L91
.L49:
	ldrb	r3, [r2, #16]	@ zero_extendqisi2
	cmp	r3, #1
	bne	.L47
.L89:
	mov	r3, #0
	strb	r3, [r2, #16]
.L46:
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L91:
	mov	r4, #67108864
	ldr	lr, .L99+16
	strh	lr, [r1, #40]	@ movhi
	ldr	r1, [r4, #288]
	ldr	lr, [r2]
	cmp	lr, #5
	beq	.L92
	ldr	lr, [r2]
	cmp	lr, #6
	beq	.L93
	ldr	lr, [r2]
	cmp	lr, #7
	beq	.L94
.L56:
	ldr	r0, .L99+12
	b	.L65
.L64:
	ldrh	r3, [r0, #40]
	tst	r3, #4
	bne	.L95
.L65:
	ldrb	r3, [r2, #16]	@ zero_extendqisi2
	cmp	r3, #1
	bne	.L64
	b	.L89
.L94:
	cmp	r1, #-2147483648
	bne	.L62
	ldrb	r3, [r2, #8]	@ zero_extendqisi2
	ldrb	r1, [r2, #7]	@ zero_extendqisi2
	cmp	r1, r3
	movcc	r3, #8
	ldrcs	r1, [r2, #36]
	ldrcs	r1, [r1, r3, lsl #2]
	addcs	r3, r3, #1
	strcs	r1, [r4, #288]
	strcc	r3, [r2]
	strbcs	r3, [r2, #8]
	b	.L56
.L95:
	ldr	r3, [r2]
	cmp	r3, #8
	beq	.L96
	mov	r2, #0
	ldr	r3, .L99+4
	strh	r2, [r3, #8]	@ movhi
	ldrh	r3, [r0, #2]
	tst	r3, #128
	beq	.L70
	ldrh	r3, [r0, #2]
	tst	r3, #3
	ldr	r1, .L99+12
	ldrne	r2, .L99+20
	bne	.L71
	ldr	r2, .L99+24
.L72:
	ldrh	r3, [r1]
	cmp	r3, r2
	bhi	.L72
.L70:
	mov	r1, #1
	ldr	r3, .L99+12
	ldr	ip, .L99+28
	ldr	r0, .L99+32
	ldr	r2, .L99+4
	strh	ip, [r3, #40]	@ movhi
	pop	{r4, r5, r6, r7, r8, lr}
	strh	r0, [r3, #40]	@ movhi
	strh	r1, [r2, #8]	@ movhi
	bx	lr
.L71:
	ldrh	r3, [r1]
	cmp	r3, r2
	bne	.L70
	ldrh	r3, [r1]
	cmp	r3, r2
	beq	.L71
	b	.L70
.L92:
	mov	lr, #1
	ldr	r5, .L99+36
	cmp	r5, r1, lsr #16
	ldr	r5, [r2, #40]
	str	r1, [r5]
	strb	lr, [r2, #5]
	bne	.L51
	lsr	r0, r1, #8
	and	r0, r0, #255
	and	r1, r1, #255
	cmp	r0, #0
	strb	r0, [r2, #4]
	strb	r1, [r2, #6]
	bne	.L52
	sub	r3, r1, #39
	cmp	r1, #54
	cmpne	r3, #2
	ldr	r4, [r2, #36]
	bhi	.L53
	sub	r3, r1, #128
	and	r3, r3, #255
	strb	r3, [r2, #9]
	add	r3, r3, #-1728053248
	add	r3, r3, #6684672
	str	r3, [r4]
	strb	r0, [r2, #7]
.L54:
	mov	r0, #67108864
	mov	r3, #1
	mov	r1, #7
	ldr	lr, [r4]
	str	lr, [r0, #288]
	str	r1, [r2]
	strb	r3, [r2, #8]
	b	.L56
.L93:
	ldrb	r0, [r2, #5]	@ zero_extendqisi2
	ldr	lr, [r2, #40]
	str	r1, [lr, r0, lsl #2]
	add	r1, r0, #1
	ldrb	r0, [r2, #4]	@ zero_extendqisi2
	and	r1, r1, #255
	cmp	r0, r1
	movcs	r3, #-2147483648
	strb	r1, [r2, #5]
	strcs	r3, [r4, #288]
	bcs	.L56
	ldrb	r1, [r2, #6]	@ zero_extendqisi2
	sub	lr, r1, #40
	cmp	r1, #54
	cmpne	lr, #1
	ldr	r0, [r2, #36]
	bls	.L97
	sub	r1, r1, #16
	cmp	r1, #45
	movhi	r3, #2
	movls	r3, #1
	mov	r1, #1
	str	r3, [r0, #4]
	mov	r3, #3
	ldr	lr, .L99+40
	str	lr, [r0]
	strb	r1, [r2, #7]
	strh	r3, [r2, #18]	@ movhi
.L60:
	mov	lr, #67108864
	mov	r3, #1
	mov	r1, #7
	ldr	r0, [r0]
	str	r0, [lr, #288]
	str	r1, [r2]
	strb	r3, [r2, #8]
	b	.L56
.L51:
	mov	r5, #3
	mov	r4, #195
	ldr	r1, .L99+4
	strh	r3, [ip]	@ movhi
	strh	r3, [ip, #2]	@ movhi
	strh	r3, [r1, #8]	@ movhi
	ldr	r3, .L99+8
	strh	r3, [ip]	@ movhi
	str	r5, [r2, #12]
	strh	r4, [ip, #2]	@ movhi
	strh	r0, [r1, #2]	@ movhi
	strh	lr, [r1, #8]	@ movhi
	b	.L46
.L96:
	mov	r3, #0
	ldr	r1, .L99+28
	strh	r1, [r0, #40]	@ movhi
	ldr	r1, [r2, #28]
	str	r3, [r2, #12]
	strh	r3, [ip]	@ movhi
	strh	r3, [ip, #2]	@ movhi
	ldrh	ip, [r2, #18]
	cmp	ip, #3
	beq	.L98
	mov	r4, #67108864
	mov	ip, #1
	ldr	lr, .L99+44
	cmp	r1, #0
	str	r3, [r4, #288]
	strh	r3, [r0, #40]	@ movhi
	strh	lr, [r0, #40]	@ movhi
	strb	ip, [r2, #20]
	str	r3, [r2]
	beq	.L46
	ldrb	r0, [r2, #4]	@ zero_extendqisi2
	ldrb	r3, [r2, #6]	@ zero_extendqisi2
	pop	{r4, r5, r6, r7, r8, lr}
	orr	r0, r3, r0, lsl #8
	b	Callback_Dummy_S
.L52:
	mov	r1, #-2147483648
	mov	r3, #6
	str	r1, [r4, #288]
	strb	lr, [r2, #5]
	str	r3, [r2]
	b	.L56
.L62:
	ldr	r1, .L99+4
	strh	r3, [ip]	@ movhi
	strh	r3, [ip, #2]	@ movhi
	strh	r3, [r1, #8]	@ movhi
	ldr	r3, .L99+8
	mov	r4, #3
	strh	r3, [ip]	@ movhi
	mov	lr, #195
	mov	r3, #1
	str	r4, [r2, #12]
	strh	lr, [ip, #2]	@ movhi
	strh	r0, [r1, #2]	@ movhi
	strh	r3, [r1, #8]	@ movhi
	b	.L46
.L97:
	sub	r1, r1, #128
	and	r1, r1, #255
	strb	r1, [r2, #9]
	orr	r1, r1, #-1728053248
	orr	r1, r1, #6684672
	str	r1, [r0]
	strb	r3, [r2, #7]
	b	.L60
.L98:
	mov	lr, #5
	ldr	ip, .L99+32
	cmp	r1, r3
	str	lr, [r2]
	str	r3, [r2, #4]
	strb	r3, [r2, #20]
	strh	r3, [r2, #8]	@ movhi
	strb	r3, [r2, #16]
	str	r3, [r2, #12]
	strb	r3, [r2, #21]
	strh	r3, [r2, #18]	@ movhi
	strh	ip, [r0, #40]	@ movhi
	beq	.L46
	ldr	r0, .L99+48
	pop	{r4, r5, r6, r7, r8, lr}
	b	Callback_Dummy_S
.L53:
	sub	r1, r1, #16
	cmp	r1, #45
	movhi	r1, #2
	movls	r1, #1
	mov	r3, #3
	ldr	r0, .L99+40
	stm	r4, {r0, r1}
	strb	lr, [r2, #7]
	strh	r3, [r2, #18]	@ movhi
	b	.L54
.L100:
	.align	2
.L99:
	.word	gSTWIStatus
	.word	67109376
	.word	-1642
	.word	67109120
	.word	20490
	.word	65535
	.word	65435
	.word	20482
	.word	20610
	.word	39270
	.word	-1721368082
	.word	20483
	.word	494
	.size	sio32intr_clock_slave, .-sio32intr_clock_slave
	.align	2
	.syntax unified
	.arm
	.type	handshake_wait, %function
handshake_wait:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L107
	ldr	ip, .L107+4
	ldr	r1, [r3]
	lsl	r2, r0, #2
	b	.L104
.L102:
	ldrh	r3, [ip, #40]
	and	r3, r3, #4
	cmp	r3, r2
	beq	.L106
.L104:
	ldrb	r0, [r1, #16]	@ zero_extendqisi2
	cmp	r0, #1
	and	r0, r0, #255
	bne	.L102
	mov	r3, #0
	strb	r3, [r1, #16]
	bx	lr
.L106:
	mov	r0, #0
	bx	lr
.L108:
	.align	2
.L107:
	.word	gSTWIStatus
	.word	67109120
	.size	handshake_wait, .-handshake_wait
	.align	2
	.syntax unified
	.arm
	.type	STWI_set_timer_in_RAM, %function
STWI_set_timer_in_RAM:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r2, #0
	str	lr, [sp, #-4]!
	ldr	r1, .L117
	ldr	r1, [r1]
	ldr	r3, .L117+4
	ldrb	ip, [r1, #10]	@ zero_extendqisi2
	strh	r2, [r3, #8]	@ movhi
	add	r3, ip, #16777216
	add	r3, r3, #64
	cmp	r0, #100
	lsl	r2, r3, #2
	beq	.L110
	bhi	.L111
	cmp	r0, #50
	beq	.L112
	cmp	r0, #80
	moveq	r3, #2
	ldreq	r0, .L117+8
	strheq	r0, [r2]	@ movhi
	streq	r3, [r1, #12]
	b	.L114
.L111:
	cmp	r0, #130
	moveq	r3, #4
	ldreq	r0, .L117+12
	strheq	r0, [r2]	@ movhi
	streq	r3, [r1, #12]
.L114:
	mov	r3, #524288
	mov	lr, #195
	mov	r0, #1
	ldr	r1, .L117+4
	lsl	r3, r3, ip
	lsr	r3, r3, #16
	strh	lr, [r2, #2]	@ movhi
	strh	r3, [r1, #2]	@ movhi
	ldr	lr, [sp], #4
	strh	r0, [r1, #8]	@ movhi
	bx	lr
.L112:
	mvn	r0, #820
	mov	r3, #1
	strh	r0, [r2]	@ movhi
	str	r3, [r1, #12]
	b	.L114
.L110:
	mov	r3, #3
	ldr	r0, .L117+16
	strh	r0, [r2]	@ movhi
	str	r3, [r1, #12]
	b	.L114
.L118:
	.align	2
.L117:
	.word	gSTWIStatus
	.word	67109376
	.word	-1312
	.word	-2131
	.word	-1642
	.size	STWI_set_timer_in_RAM, .-STWI_set_timer_in_RAM
	.align	2
	.syntax unified
	.arm
	.type	STWI_stop_timer_in_RAM, %function
STWI_stop_timer_in_RAM:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #0
	ldr	r3, .L120
	ldr	r1, [r3]
	ldrb	r3, [r1, #10]	@ zero_extendqisi2
	add	r3, r3, #16777216
	add	r3, r3, #64
	lsl	r3, r3, #2
	str	r2, [r1, #12]
	strh	r2, [r3]	@ movhi
	strh	r2, [r3, #2]	@ movhi
	bx	lr
.L121:
	.align	2
.L120:
	.word	gSTWIStatus
	.size	STWI_stop_timer_in_RAM, .-STWI_stop_timer_in_RAM
	.align	2
	.syntax unified
	.arm
	.type	STWI_init_slave, %function
STWI_init_slave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #0
	mov	ip, #5
	ldr	r3, .L123
	ldr	r1, .L123+4
	ldr	r3, [r3]
	ldr	r0, .L123+8
	str	ip, [r3]
	str	r2, [r3, #4]
	strb	r2, [r3, #20]
	strh	r2, [r3, #8]	@ movhi
	strb	r2, [r3, #16]
	str	r2, [r3, #12]
	strb	r2, [r3, #21]
	strh	r2, [r3, #18]	@ movhi
	strh	r0, [r1, #40]	@ movhi
	bx	lr
.L124:
	.align	2
.L123:
	.word	gSTWIStatus
	.word	67109120
	.word	20610
	.size	STWI_init_slave, .-STWI_init_slave
	.align	2
	.syntax unified
	.arm
	.type	Callback_Dummy_M, %function
Callback_Dummy_M:
	@ Function supports interworking.
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.syntax divided
@ 393 "src/librfu_intr.c" 1
	bx r2
@ 0 "" 2
	.arm
	.syntax unified
	.size	Callback_Dummy_M, .-Callback_Dummy_M
	.align	2
	.syntax unified
	.arm
	.type	Callback_Dummy_S, %function
Callback_Dummy_S:
	@ Function supports interworking.
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.syntax divided
@ 399 "src/librfu_intr.c" 1
	bx r1
@ 0 "" 2
	.arm
	.syntax unified
	.size	Callback_Dummy_S, .-Callback_Dummy_S
	.align	2
	.syntax unified
	.arm
	.type	Callback_Dummy_ID, %function
Callback_Dummy_ID:
	@ Function supports interworking.
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.syntax divided
@ 405 "src/librfu_intr.c" 1
	bx r0
@ 0 "" 2
	.arm
	.syntax unified
	.size	Callback_Dummy_ID, .-Callback_Dummy_ID
	.ident	"GCC: (devkitARM release 62) 13.2.0"
.text
	.align	2, 0

