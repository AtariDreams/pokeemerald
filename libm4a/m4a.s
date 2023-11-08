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
	.global	SoundMainRAM_Buffer
	.section	.bss.code,"aw",%nobits
	.align	2
	.type	SoundMainRAM_Buffer, %object
	.size	SoundMainRAM_Buffer, 2048
SoundMainRAM_Buffer:
	.space	2048
	.global	gSoundInfo
	.bss
	.align	2
	.type	gSoundInfo, %object
	.size	gSoundInfo, 4016
gSoundInfo:
	.space	4016
	.global	gPokemonCrySongs
	.align	2
	.type	gPokemonCrySongs, %object
	.size	gPokemonCrySongs, 104
gPokemonCrySongs:
	.space	104
	.global	gPokemonCryMusicPlayers
	.align	2
	.type	gPokemonCryMusicPlayers, %object
	.size	gPokemonCryMusicPlayers, 128
gPokemonCryMusicPlayers:
	.space	128
	.global	gMPlayJumpTable
	.align	2
	.type	gMPlayJumpTable, %object
	.size	gMPlayJumpTable, 144
gMPlayJumpTable:
	.space	144
	.global	gCgbChans
	.align	2
	.type	gCgbChans, %object
	.size	gCgbChans, 256
gCgbChans:
	.space	256
	.global	gPokemonCryTracks
	.align	2
	.type	gPokemonCryTracks, %object
	.size	gPokemonCryTracks, 320
gPokemonCryTracks:
	.space	320
	.global	gPokemonCrySong
	.align	2
	.type	gPokemonCrySong, %object
	.size	gPokemonCrySong, 52
gPokemonCrySong:
	.space	52
	.global	gMPlayInfo_BGM
	.align	2
	.type	gMPlayInfo_BGM, %object
	.size	gMPlayInfo_BGM, 64
gMPlayInfo_BGM:
	.space	64
	.global	gMPlayInfo_SE1
	.align	2
	.type	gMPlayInfo_SE1, %object
	.size	gMPlayInfo_SE1, 64
gMPlayInfo_SE1:
	.space	64
	.global	gMPlayInfo_SE2
	.align	2
	.type	gMPlayInfo_SE2, %object
	.size	gMPlayInfo_SE2, 64
gMPlayInfo_SE2:
	.space	64
	.global	gMPlayInfo_SE3
	.align	2
	.type	gMPlayInfo_SE3, %object
	.size	gMPlayInfo_SE3, 64
gMPlayInfo_SE3:
	.space	64
	.global	gMPlayMemAccArea
	.align	2
	.type	gMPlayMemAccArea, %object
	.size	gMPlayMemAccArea, 16
gMPlayMemAccArea:
	.space	16
	.text
	.align	2
	.global	MidiKeyToFreq
	.arch armv4t
	.fpu softvfp
	.syntax unified
	.arm
	.type	MidiKeyToFreq, %function
MidiKeyToFreq:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #178
	movhi	r1, #178
	movhi	ip, #179
	movhi	r2, #-16777216
	push	{r4, lr}
	movls	lr, #0
	movhi	lr, #0
	ldr	r3, .L6
	addls	ip, r1, #1
	ldrb	r1, [r3, r1]	@ zero_extendqisi2
	ldr	r4, .L6+4
	ldrb	ip, [r3, ip]	@ zero_extendqisi2
	and	r3, r1, #15
	ldr	r3, [r4, r3, lsl #2]
	lsr	r1, r1, #4
	lsr	r3, r3, r1
	and	r1, ip, #15
	ldr	r1, [r4, r1, lsl #2]
	lsr	ip, ip, #4
	rsb	r1, r3, r1, lsr ip
	lslls	r2, r2, #24
	umull	r4, ip, r1, r2
	mla	r2, r1, lr, ip
	ldr	r0, [r0, #4]
	add	r3, r3, r2
	umull	r2, r0, r3, r0
	pop	{r4, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	gScaleTable
	.word	gFreqTable
	.size	MidiKeyToFreq, .-MidiKeyToFreq
	.align	1
	.p2align 2,,3
	.global	UnusedDummyFunc
	.arch armv4t
	.fpu softvfp
	.syntax unified
	.code	16
	.thumb_func
	.type	UnusedDummyFunc, %function
UnusedDummyFunc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	@ sp needed
	bx	lr
	.size	UnusedDummyFunc, .-UnusedDummyFunc
	.align	1
	.p2align 2,,3
	.global	MPlayContinue
	.syntax unified
	.code	16
	.thumb_func
	.type	MPlayContinue, %function
MPlayContinue:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, [r0, #52]
	ldr	r3, .L12
	cmp	r2, r3
	bne	.L10
	ldr	r3, .L12+4
	str	r3, [r0, #52]
	ldr	r3, [r0, #4]
	lsls	r3, r3, #1
	lsrs	r3, r3, #1
	str	r3, [r0, #4]
	str	r2, [r0, #52]
.L10:
	@ sp needed
	bx	lr
.L13:
	.align	2
.L12:
	.word	1752395091
	.word	1752395092
	.size	MPlayContinue, .-MPlayContinue
	.align	1
	.p2align 2,,3
	.global	MPlayFadeOut
	.syntax unified
	.code	16
	.thumb_func
	.type	MPlayFadeOut, %function
MPlayFadeOut:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #52]
	ldr	r2, .L16
	cmp	r3, r2
	bne	.L14
	ldr	r2, .L16+4
	str	r2, [r0, #52]
	lsls	r2, r1, #16
	orrs	r1, r2
	movs	r2, #128
	lsls	r2, r2, #1
	str	r1, [r0, #36]
	strh	r2, [r0, #40]
	str	r3, [r0, #52]
.L14:
	@ sp needed
	bx	lr
.L17:
	.align	2
.L16:
	.word	1752395091
	.word	1752395092
	.size	MPlayFadeOut, .-MPlayFadeOut
	.align	1
	.p2align 2,,3
	.global	m4aSoundInit
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSoundInit, %function
m4aSoundInit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, fp
	mov	r6, r9
	mov	r5, r8
	mov	r7, r10
	movs	r4, #128
	movs	r3, #1
	push	{r5, r6, r7, lr}
	ldr	r0, .L87
	lsls	r4, r4, #2
	bics	r0, r3
	movs	r2, r4
	ldr	r1, .L87+4
	sub	sp, sp, #12
	bl	CpuFastSet
	ldr	r0, .L87+8
	bl	SoundInit
	ldr	r0, .L87+12
	bl	MPlayExtender
	ldr	r3, .L87+16
	ldr	r5, [r3]
	ldr	r3, .L87+20
	ldr	r6, [r5]
	cmp	r6, r3
	bne	.L19
	ldr	r3, .L87+24
	str	r3, [r5]
	movs	r3, #5
	movs	r2, #0
	strb	r3, [r5, #6]
	movs	r1, #64
	movs	r3, #0
	strb	r2, [r3]
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r1, r1, #128
	strb	r2, [r3, r4]
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r1, r1, #64
	strb	r2, [r3, r1]
	adds	r3, r3, #12
	strb	r3, [r5, #7]
	ldr	r2, .L87+28
	ldrb	r1, [r2]
	adds	r3, r3, #51
	ands	r3, r1
	movs	r1, #64
	movs	r0, #128
	orrs	r3, r1
	strb	r3, [r2]
	lsls	r0, r0, #11
	bl	SampleFreqSet
	str	r6, [r5]
.L19:
	movs	r3, #48
	mov	r10, r3
	ldr	r3, .L87+32
	mov	r9, r3
	ldr	r3, .L87+16
	mov	fp, r3
	ldr	r3, .L87+36
	str	r3, [sp]
	ldr	r3, .L87+40
	ldr	r4, .L87+44
	str	r3, [sp, #4]
	add	r10, r10, r4
.L24:
	ldrb	r6, [r4, #8]
	ldr	r5, [r4]
	cmp	r6, #0
	beq	.L20
	mov	r3, fp
	ldr	r7, [r3]
	ldr	r3, .L87+20
	ldr	r2, [r7]
	cmp	r2, r3
	bne	.L20
	ldr	r3, [r4, #4]
	mov	r8, r3
	ldr	r3, .L87+24
	str	r3, [r7]
	movs	r3, #140
	ldr	r2, [sp]
	movs	r0, r5
	ldr	r3, [r2, r3]
	bl	.L89
	mov	r3, r8
	str	r3, [r5, #44]
	adds	r3, r6, #0
	cmp	r6, #16
	bls	.L21
	movs	r3, #16
.L21:
	strb	r3, [r5, #8]
	movs	r3, #128
	lsls	r3, r3, #24
	str	r3, [r5, #4]
	mov	r2, r8
	movs	r3, #0
	strb	r3, [r2]
	cmp	r6, #1
	beq	.L22
	movs	r2, #80
	mov	r1, r8
	strb	r3, [r1, r2]
	cmp	r6, #2
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #3
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #4
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #5
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #6
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #7
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #8
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #9
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #10
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #11
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #12
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #13
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #14
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
	cmp	r6, #15
	beq	.L22
	adds	r2, r2, #80
	strb	r3, [r1, r2]
.L22:
	ldr	r3, [r7, #32]
	cmp	r3, #0
	beq	.L23
	str	r3, [r5, #56]
	ldr	r3, [r7, #36]
	str	r3, [r5, #60]
.L23:
	ldr	r3, [sp, #4]
	str	r5, [r7, #36]
	str	r3, [r7, #32]
	ldr	r3, .L87+20
	str	r3, [r5, #52]
	str	r3, [r7]
.L20:
	ldrh	r3, [r4, #10]
	strb	r3, [r5, #11]
	mov	r3, r9
	adds	r4, r4, #12
	str	r3, [r5, #24]
	cmp	r4, r10
	bne	.L24
	movs	r2, #52
	ldr	r0, .L87+48
	ldr	r1, .L87+52
	bl	memcpy
	ldr	r3, .L87+16
	ldr	r5, [r3]
	ldr	r3, .L87+20
	ldr	r2, [r5]
	cmp	r2, r3
	beq	.L86
	ldr	r4, .L87+56
.L25:
	movs	r7, #0
	ldr	r3, .L87+16
	ldr	r5, [r3]
	ldr	r3, .L87+20
	ldr	r2, [r5]
	str	r7, [r4, #32]
	cmp	r2, r3
	bne	.L28
	movs	r2, #140
	ldr	r3, .L87+24
	ldr	r6, .L87+60
	str	r3, [r5]
	ldr	r3, .L87+36
	movs	r0, r6
	ldr	r3, [r3, r2]
	bl	.L89
	movs	r2, r4
	movs	r3, r6
	adds	r2, r2, #160
	movs	r1, #2
	str	r2, [r6, #44]
	movs	r2, #72
	subs	r3, r3, #64
	strb	r1, [r3, r2]
	movs	r2, #128
	lsls	r2, r2, #24
	str	r2, [r3, #68]
	movs	r2, #160
	strb	r7, [r4, r2]
	adds	r2, r2, #80
	strb	r7, [r4, r2]
	ldr	r2, [r5, #32]
	cmp	r2, #0
	beq	.L29
	str	r2, [r3, #120]
	ldr	r2, [r5, #36]
	str	r2, [r3, #124]
.L29:
	ldr	r3, .L87+40
	str	r6, [r5, #36]
	str	r3, [r5, #32]
	ldr	r3, .L87+20
	str	r3, [r6, #52]
	str	r3, [r5]
.L28:
	movs	r3, #192
	movs	r2, #0
	str	r2, [r4, r3]
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
.L86:
	movs	r2, #140
	ldr	r3, .L87+24
	ldr	r6, .L87+64
	str	r3, [r5]
	ldr	r3, .L87+36
	movs	r0, r6
	ldr	r3, [r3, r2]
	bl	.L89
	movs	r3, #2
	strb	r3, [r6, #8]
	movs	r3, #128
	lsls	r3, r3, #24
	movs	r2, #80
	str	r3, [r6, #4]
	movs	r3, #0
	ldr	r4, .L87+56
	strb	r3, [r4, r2]
	strb	r3, [r4]
	ldr	r3, [r5, #32]
	str	r4, [r6, #44]
	cmp	r3, #0
	beq	.L27
	str	r3, [r6, #56]
	ldr	r3, [r5, #36]
	str	r3, [r6, #60]
.L27:
	ldr	r3, .L87+40
	str	r6, [r5, #36]
	str	r3, [r5, #32]
	ldr	r3, .L87+20
	str	r3, [r6, #52]
	str	r3, [r5]
	b	.L25
.L88:
	.align	2
.L87:
	.word	SoundMainRAM
	.word	SoundMainRAM_Buffer
	.word	gSoundInfo
	.word	gCgbChans
	.word	50364400
	.word	1752395091
	.word	1752395092
	.word	67109001
	.word	gMPlayMemAccArea
	.word	gMPlayJumpTable
	.word	MPlayMain
	.word	gMPlayTable
	.word	gPokemonCrySong
	.word	gPokemonCrySongTemplate
	.word	gPokemonCryTracks
	.word	gPokemonCryMusicPlayers+64
	.word	gPokemonCryMusicPlayers
	.size	m4aSoundInit, .-m4aSoundInit
	.align	1
	.p2align 2,,3
	.global	m4aSoundMain
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSoundMain, %function
m4aSoundMain:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	bl	SoundMain
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
	.size	m4aSoundMain, .-m4aSoundMain
	.align	1
	.p2align 2,,3
	.global	m4aSongNumStart
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSongNumStart, %function
m4aSongNumStart:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r2, .L93
	lsls	r3, r0, #3
	adds	r3, r3, r2
	ldrh	r1, [r3, #4]
	lsls	r2, r1, #1
	adds	r2, r2, r1
	ldr	r1, .L93+4
	lsls	r2, r2, #2
	ldr	r0, [r1, r2]
	ldr	r2, .L93+8
	ldr	r1, [r0, #52]
	cmp	r1, r2
	bne	.L91
	ldr	r1, [r3]
	bl	MPlayStart.part.0
.L91:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L94:
	.align	2
.L93:
	.word	gSongTable
	.word	gMPlayTable
	.word	1752395091
	.size	m4aSongNumStart, .-m4aSongNumStart
	.align	1
	.p2align 2,,3
	.global	m4aSongNumStartOrChange
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSongNumStartOrChange, %function
m4aSongNumStartOrChange:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r2, .L104
	lsls	r3, r0, #3
	adds	r3, r3, r2
	ldrh	r1, [r3, #4]
	lsls	r2, r1, #1
	adds	r2, r2, r1
	ldr	r1, .L104+4
	lsls	r2, r2, #2
	ldr	r0, [r1, r2]
	ldr	r1, [r3]
	ldr	r3, [r0]
	cmp	r3, r1
	beq	.L96
.L98:
	ldr	r2, [r0, #52]
	ldr	r3, .L104+8
	cmp	r2, r3
	beq	.L103
.L95:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L103:
	bl	MPlayStart.part.0
	b	.L95
.L96:
	ldr	r3, [r0, #4]
	lsls	r2, r3, #16
	beq	.L98
	cmp	r3, #0
	bge	.L95
	b	.L98
.L105:
	.align	2
.L104:
	.word	gSongTable
	.word	gMPlayTable
	.word	1752395091
	.size	m4aSongNumStartOrChange, .-m4aSongNumStartOrChange
	.align	1
	.p2align 2,,3
	.global	m4aSongNumStartOrContinue
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSongNumStartOrContinue, %function
m4aSongNumStartOrContinue:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r2, .L111
	lsls	r3, r0, #3
	adds	r3, r3, r2
	ldrh	r1, [r3, #4]
	lsls	r2, r1, #1
	adds	r2, r2, r1
	ldr	r1, .L111+4
	lsls	r2, r2, #2
	ldr	r0, [r1, r2]
	ldr	r1, [r3]
	ldr	r3, [r0]
	cmp	r3, r1
	beq	.L107
	ldr	r2, [r0, #52]
	ldr	r3, .L111+8
	cmp	r2, r3
	beq	.L110
.L106:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L107:
	ldr	r2, [r0, #4]
	lsls	r1, r2, #16
	bne	.L109
	ldr	r1, [r0, #52]
	ldr	r2, .L111+8
	cmp	r1, r2
	bne	.L106
	movs	r1, r3
.L110:
	bl	MPlayStart.part.0
	b	.L106
.L109:
	cmp	r2, #0
	bge	.L106
	ldr	r2, [r0, #52]
	ldr	r3, .L111+8
	cmp	r2, r3
	bne	.L106
	ldr	r3, .L111+12
	str	r3, [r0, #52]
	ldr	r3, [r0, #4]
	lsls	r3, r3, #1
	lsrs	r3, r3, #1
	str	r3, [r0, #4]
	str	r2, [r0, #52]
	b	.L106
.L112:
	.align	2
.L111:
	.word	gSongTable
	.word	gMPlayTable
	.word	1752395091
	.word	1752395092
	.size	m4aSongNumStartOrContinue, .-m4aSongNumStartOrContinue
	.align	1
	.p2align 2,,3
	.global	m4aSongNumStop
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSongNumStop, %function
m4aSongNumStop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r3, .L122
	lsls	r0, r0, #3
	adds	r0, r0, r3
	ldrh	r2, [r0, #4]
	lsls	r3, r2, #1
	adds	r3, r3, r2
	ldr	r2, .L122+4
	lsls	r3, r3, #2
	ldr	r4, [r2, r3]
	ldr	r3, [r0]
	ldr	r2, [r4]
	cmp	r2, r3
	beq	.L121
.L113:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L121:
	ldr	r2, [r4, #52]
	ldr	r3, .L122+8
	cmp	r2, r3
	bne	.L113
	ldr	r3, .L122+12
	str	r3, [r4, #52]
	movs	r3, #128
	ldr	r2, [r4, #4]
	lsls	r3, r3, #24
	ldrb	r5, [r4, #8]
	orrs	r3, r2
	str	r3, [r4, #4]
	ldr	r6, [r4, #44]
	cmp	r5, #0
	beq	.L115
.L116:
	movs	r1, r6
	movs	r0, r4
	subs	r5, r5, #1
	bl	TrackStop
	adds	r6, r6, #80
	cmp	r5, #0
	bne	.L116
.L115:
	ldr	r3, .L122+8
	str	r3, [r4, #52]
	b	.L113
.L123:
	.align	2
.L122:
	.word	gSongTable
	.word	gMPlayTable
	.word	1752395091
	.word	1752395092
	.size	m4aSongNumStop, .-m4aSongNumStop
	.align	1
	.p2align 2,,3
	.global	m4aSongNumContinue
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSongNumContinue, %function
m4aSongNumContinue:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L127
	lsls	r0, r0, #3
	adds	r0, r0, r3
	ldrh	r2, [r0, #4]
	lsls	r3, r2, #1
	adds	r3, r3, r2
	ldr	r2, .L127+4
	lsls	r3, r3, #2
	ldr	r3, [r2, r3]
	ldr	r2, [r0]
	ldr	r1, [r3]
	cmp	r1, r2
	beq	.L126
.L124:
	@ sp needed
	bx	lr
.L126:
	ldr	r1, [r3, #52]
	ldr	r2, .L127+8
	cmp	r1, r2
	bne	.L124
	ldr	r2, .L127+12
	str	r2, [r3, #52]
	ldr	r2, [r3, #4]
	lsls	r2, r2, #1
	lsrs	r2, r2, #1
	str	r2, [r3, #4]
	str	r1, [r3, #52]
	b	.L124
.L128:
	.align	2
.L127:
	.word	gSongTable
	.word	gMPlayTable
	.word	1752395091
	.word	1752395092
	.size	m4aSongNumContinue, .-m4aSongNumContinue
	.align	1
	.p2align 2,,3
	.global	m4aMPlayAllStop
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayAllStop, %function
m4aMPlayAllStop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	movs	r3, #48
	mov	r6, r9
	mov	r9, r3
	ldr	r3, .L154
	mov	r5, r8
	mov	r8, r3
	ldr	r3, .L154+4
	mov	lr, fp
	mov	fp, r3
	movs	r3, #128
	mov	r7, r10
	lsls	r3, r3, #24
	mov	r10, r3
	push	{r5, r6, r7, lr}
	ldr	r7, .L154+8
	add	r9, r9, r7
.L133:
	ldr	r6, [r7]
	ldr	r3, [r6, #52]
	cmp	r3, r8
	bne	.L130
	mov	r3, fp
	str	r3, [r6, #52]
	mov	r2, r10
	ldr	r3, [r6, #4]
	ldrb	r4, [r6, #8]
	orrs	r3, r2
	str	r3, [r6, #4]
	ldr	r5, [r6, #44]
	cmp	r4, #0
	beq	.L131
.L132:
	movs	r1, r5
	movs	r0, r6
	subs	r4, r4, #1
	bl	TrackStop
	adds	r5, r5, #80
	cmp	r4, #0
	bne	.L132
.L131:
	mov	r3, r8
	str	r3, [r6, #52]
.L130:
	adds	r7, r7, #12
	cmp	r9, r7
	bne	.L133
	ldr	r7, .L154+12
	ldr	r3, .L154
	ldr	r2, [r7, #52]
	movs	r6, r7
	cmp	r2, r3
	beq	.L153
.L146:
	ldr	r2, [r7, #116]
	ldr	r3, .L154
	cmp	r2, r3
	bne	.L129
	movs	r3, #1
	mov	r9, r3
	adds	r6, r6, #64
.L138:
	mov	r3, r9
	ldr	r2, .L154+4
	lsls	r3, r3, #6
	mov	r8, r3
	adds	r3, r7, r3
	str	r2, [r3, #52]
	movs	r3, #128
	ldr	r2, [r6, #4]
	lsls	r3, r3, #24
	ldrb	r4, [r6, #8]
	orrs	r3, r2
	str	r3, [r6, #4]
	ldr	r5, [r6, #44]
	cmp	r4, #0
	beq	.L135
.L136:
	movs	r1, r5
	movs	r0, r6
	subs	r4, r4, #1
	bl	TrackStop
	adds	r5, r5, #80
	cmp	r4, #0
	bne	.L136
.L135:
	mov	r3, r8
	ldr	r2, .L154
	adds	r3, r7, r3
	str	r2, [r3, #52]
	mov	r3, r9
	cmp	r3, #1
	bne	.L146
.L129:
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L153:
	movs	r3, #0
	mov	r9, r3
	b	.L138
.L155:
	.align	2
.L154:
	.word	1752395091
	.word	1752395092
	.word	gMPlayTable
	.word	gPokemonCryMusicPlayers
	.size	m4aMPlayAllStop, .-m4aMPlayAllStop
	.align	1
	.p2align 2,,3
	.global	m4aMPlayContinue
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayContinue, %function
m4aMPlayContinue:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, [r0, #52]
	ldr	r3, .L158
	cmp	r2, r3
	bne	.L156
	ldr	r3, .L158+4
	str	r3, [r0, #52]
	ldr	r3, [r0, #4]
	lsls	r3, r3, #1
	lsrs	r3, r3, #1
	str	r3, [r0, #4]
	str	r2, [r0, #52]
.L156:
	@ sp needed
	bx	lr
.L159:
	.align	2
.L158:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayContinue, .-m4aMPlayContinue
	.align	1
	.p2align 2,,3
	.global	m4aMPlayAllContinue
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayAllContinue, %function
m4aMPlayAllContinue:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L167
	ldr	r2, [r3]
	ldr	r1, .L167+4
	ldr	r0, [r2, #52]
	cmp	r0, r1
	bne	.L161
	ldr	r1, .L167+8
	str	r1, [r2, #52]
	ldr	r1, [r2, #4]
	lsls	r1, r1, #1
	lsrs	r1, r1, #1
	str	r1, [r2, #4]
	str	r0, [r2, #52]
.L161:
	ldr	r2, [r3, #12]
	ldr	r1, .L167+4
	ldr	r0, [r2, #52]
	cmp	r0, r1
	bne	.L162
	ldr	r1, .L167+8
	str	r1, [r2, #52]
	ldr	r1, [r2, #4]
	lsls	r1, r1, #1
	lsrs	r1, r1, #1
	str	r1, [r2, #4]
	str	r0, [r2, #52]
.L162:
	ldr	r2, [r3, #24]
	ldr	r1, .L167+4
	ldr	r0, [r2, #52]
	cmp	r0, r1
	bne	.L163
	ldr	r1, .L167+8
	str	r1, [r2, #52]
	ldr	r1, [r2, #4]
	lsls	r1, r1, #1
	lsrs	r1, r1, #1
	str	r1, [r2, #4]
	str	r0, [r2, #52]
.L163:
	ldr	r3, [r3, #36]
	ldr	r2, .L167+4
	ldr	r1, [r3, #52]
	cmp	r1, r2
	bne	.L164
	ldr	r2, .L167+8
	str	r2, [r3, #52]
	ldr	r2, [r3, #4]
	lsls	r2, r2, #1
	lsrs	r2, r2, #1
	str	r2, [r3, #4]
	str	r1, [r3, #52]
.L164:
	ldr	r3, .L167+12
	ldr	r2, .L167+4
	ldr	r1, [r3, #52]
	cmp	r1, r2
	bne	.L165
	ldr	r2, .L167+8
	str	r2, [r3, #52]
	ldr	r2, [r3, #4]
	lsls	r2, r2, #1
	lsrs	r2, r2, #1
	str	r2, [r3, #4]
	str	r1, [r3, #52]
.L165:
	ldr	r1, [r3, #116]
	ldr	r2, .L167+4
	cmp	r1, r2
	bne	.L160
	ldr	r2, .L167+8
	str	r2, [r3, #116]
	ldr	r2, [r3, #68]
	lsls	r2, r2, #1
	lsrs	r2, r2, #1
	str	r2, [r3, #68]
	str	r1, [r3, #116]
.L160:
	@ sp needed
	bx	lr
.L168:
	.align	2
.L167:
	.word	gMPlayTable
	.word	1752395091
	.word	1752395092
	.word	gPokemonCryMusicPlayers
	.size	m4aMPlayAllContinue, .-m4aMPlayAllContinue
	.align	1
	.p2align 2,,3
	.global	m4aMPlayFadeOut
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayFadeOut, %function
m4aMPlayFadeOut:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #52]
	ldr	r2, .L171
	cmp	r3, r2
	bne	.L169
	ldr	r2, .L171+4
	str	r2, [r0, #52]
	lsls	r2, r1, #16
	orrs	r1, r2
	movs	r2, #128
	lsls	r2, r2, #1
	str	r1, [r0, #36]
	strh	r2, [r0, #40]
	str	r3, [r0, #52]
.L169:
	@ sp needed
	bx	lr
.L172:
	.align	2
.L171:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayFadeOut, .-m4aMPlayFadeOut
	.align	1
	.p2align 2,,3
	.global	m4aMPlayFadeOutTemporarily
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayFadeOutTemporarily, %function
m4aMPlayFadeOutTemporarily:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #52]
	ldr	r2, .L175
	cmp	r3, r2
	bne	.L173
	ldr	r2, .L175+4
	str	r2, [r0, #52]
	lsls	r2, r1, #16
	orrs	r1, r2
	movs	r2, #2
	adds	r2, r2, #255
	str	r1, [r0, #36]
	strh	r2, [r0, #40]
	str	r3, [r0, #52]
.L173:
	@ sp needed
	bx	lr
.L176:
	.align	2
.L175:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayFadeOutTemporarily, .-m4aMPlayFadeOutTemporarily
	.align	1
	.p2align 2,,3
	.global	m4aMPlayFadeIn
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayFadeIn, %function
m4aMPlayFadeIn:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #52]
	ldr	r2, .L179
	cmp	r3, r2
	bne	.L177
	ldr	r2, .L179+4
	str	r2, [r0, #52]
	lsls	r2, r1, #16
	orrs	r1, r2
	movs	r2, #2
	strh	r2, [r0, #40]
	ldr	r2, [r0, #4]
	lsls	r2, r2, #1
	lsrs	r2, r2, #1
	str	r1, [r0, #36]
	str	r2, [r0, #4]
	str	r3, [r0, #52]
.L177:
	@ sp needed
	bx	lr
.L180:
	.align	2
.L179:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayFadeIn, .-m4aMPlayFadeIn
	.align	1
	.p2align 2,,3
	.global	m4aMPlayImmInit
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayImmInit, %function
m4aMPlayImmInit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r8
	mov	lr, r10
	mov	r7, r9
	ldr	r2, [r0, #52]
	ldr	r3, .L193
	mov	r8, r0
	push	{r6, r7, lr}
	cmp	r2, r3
	bne	.L181
	movs	r3, r0
	ldr	r3, [r3, #52]
	ldrb	r5, [r0, #8]
	ldr	r4, [r0, #44]
	cmp	r5, #0
	beq	.L183
	ldr	r3, .L193+4
	mov	r10, r3
	movs	r3, #140
	movs	r6, r4
	movs	r7, #64
	mov	r9, r3
	adds	r6, r6, #36
.L185:
	ldrb	r3, [r4]
	tst	r7, r3
	beq	.L184
	mov	r2, r9
	mov	r3, r10
	movs	r0, r4
	ldr	r3, [r3, r2]
	bl	.L89
	movs	r3, #128
	strb	r3, [r4]
	subs	r3, r3, #126
	strb	r3, [r4, #15]
	adds	r3, r3, #20
	strb	r3, [r4, #25]
	subs	r3, r3, #21
	strb	r7, [r4, #19]
	strb	r3, [r6]
.L184:
	subs	r5, r5, #1
	adds	r4, r4, #80
	adds	r6, r6, #80
	cmp	r5, #0
	bne	.L185
.L183:
	mov	r3, r8
	ldr	r3, [r3, #52]
.L181:
	@ sp needed
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L194:
	.align	2
.L193:
	.word	1752395091
	.word	gMPlayJumpTable
	.size	m4aMPlayImmInit, .-m4aMPlayImmInit
	.align	1
	.p2align 2,,3
	.global	MPlayExtender
	.syntax unified
	.code	16
	.thumb_func
	.type	MPlayExtender, %function
MPlayExtender:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, #143
	ldr	r3, .L198
	push	{r4, r5, r6, r7, lr}
	movs	r1, #0
	strh	r2, [r3]
	movs	r3, #8
	movs	r4, r0
	movs	r0, #0
	ldr	r2, .L198+4
	ldr	r5, .L198+8
	strh	r1, [r2]
	strb	r3, [r5]
	ldr	r5, .L198+12
	strb	r3, [r5]
	ldr	r5, .L198+16
	strb	r3, [r5]
	ldr	r5, .L198+20
	adds	r3, r3, #120
	strb	r3, [r5]
	ldr	r5, .L198+24
	strb	r3, [r5]
	ldr	r5, .L198+28
	strb	r3, [r5]
	ldr	r5, .L198+32
	strb	r0, [r5]
	movs	r5, #119
	strb	r5, [r2]
	ldr	r2, .L198+36
	ldr	r5, [r2]
	ldr	r2, .L198+40
	ldr	r6, [r5]
	sub	sp, sp, #12
	cmp	r6, r2
	beq	.L197
.L195:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L197:
	ldr	r2, .L198+44
	ldr	r7, .L198+48
	str	r2, [r5]
	ldr	r2, .L198+52
	str	r7, [r2, #32]
	ldr	r7, .L198+56
	str	r7, [r2, #68]
	ldr	r7, .L198+60
	str	r7, [r2, #76]
	ldr	r7, .L198+64
	str	r7, [r2, #112]
	ldr	r7, .L198+68
	str	r7, [r2, #116]
	ldr	r7, .L198+72
	str	r7, [r2, #120]
	ldr	r7, .L198+76
	str	r7, [r2, #124]
	ldr	r7, .L198+80
	str	r7, [r2, r3]
	movs	r7, #132
	ldr	r3, .L198+84
	str	r3, [r2, r7]
	ldr	r3, .L198+88
	str	r3, [r5, #40]
	ldr	r3, .L198+92
	str	r3, [r5, #44]
	ldr	r3, .L198+96
	str	r4, [r5, #28]
	str	r3, [r5, #48]
	strb	r0, [r5, #12]
	str	r1, [sp, #4]
	ldr	r2, .L198+100
	movs	r1, r4
	add	r0, sp, #4
	bl	CpuFastSet
	movs	r3, #1
	strb	r3, [r4, #1]
	adds	r3, r3, #16
	strb	r3, [r4, #28]
	movs	r3, r4
	movs	r2, #2
	adds	r3, r3, #64
	strb	r2, [r3, #1]
	adds	r2, r2, #32
	strb	r2, [r3, #28]
	adds	r3, r3, #64
	subs	r2, r2, #31
	strb	r2, [r3, #1]
	adds	r2, r2, #65
	strb	r2, [r3, #28]
	movs	r3, #4
	adds	r4, r4, #192
	strb	r3, [r4, #1]
	adds	r3, r3, #132
	strb	r3, [r4, #28]
	str	r6, [r5]
	b	.L195
.L199:
	.align	2
.L198:
	.word	67108996
	.word	67108992
	.word	67108963
	.word	67108969
	.word	67108985
	.word	67108965
	.word	67108973
	.word	67108989
	.word	67108976
	.word	50364400
	.word	1752395091
	.word	1752395092
	.word	ply_memacc
	.word	gMPlayJumpTable
	.word	ply_lfos
	.word	ply_mod
	.word	ply_xcmd
	.word	ply_endtie
	.word	SampleFreqSet
	.word	TrackStop
	.word	FadeOutBody
	.word	TrkVolPitSet
	.word	CgbSound
	.word	CgbOscOff
	.word	MidiKeyToCgbFreq
	.word	16777280
	.size	MPlayExtender, .-MPlayExtender
	.align	1
	.p2align 2,,3
	.global	MusicPlayerJumpTableCopy
	.syntax unified
	.code	16
	.thumb_func
	.type	MusicPlayerJumpTableCopy, %function
MusicPlayerJumpTableCopy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.syntax divided
@ 375 "src/m4a.c" 1
	svc 0x2A
@ 0 "" 2
	.thumb
	.syntax unified
	@ sp needed
	bx	lr
	.size	MusicPlayerJumpTableCopy, .-MusicPlayerJumpTableCopy
	.align	1
	.p2align 2,,3
	.global	ClearChain
	.syntax unified
	.code	16
	.thumb_func
	.type	ClearChain, %function
ClearChain:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, #136
	push	{r4, lr}
	ldr	r3, .L202
	@ sp needed
	ldr	r3, [r3, r2]
	bl	.L89
	pop	{r4}
	pop	{r0}
	bx	r0
.L203:
	.align	2
.L202:
	.word	gMPlayJumpTable
	.size	ClearChain, .-ClearChain
	.align	1
	.p2align 2,,3
	.global	Clear64byte
	.syntax unified
	.code	16
	.thumb_func
	.type	Clear64byte, %function
Clear64byte:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, #140
	push	{r4, lr}
	ldr	r3, .L205
	@ sp needed
	ldr	r3, [r3, r2]
	bl	.L89
	pop	{r4}
	pop	{r0}
	bx	r0
.L206:
	.align	2
.L205:
	.word	gMPlayJumpTable
	.size	Clear64byte, .-Clear64byte
	.align	1
	.p2align 2,,3
	.global	SoundInit
	.syntax unified
	.code	16
	.thumb_func
	.type	SoundInit, %function
SoundInit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #0
	push	{r4, r5, lr}
	ldr	r2, .L218
	str	r3, [r0]
	ldr	r3, [r2]
	movs	r4, r0
	sub	sp, sp, #12
	lsls	r3, r3, #6
	bpl	.L208
	ldr	r3, .L218+4
	str	r3, [r2]
.L208:
	ldr	r2, .L218+8
	ldr	r3, [r2]
	lsls	r3, r3, #6
	bpl	.L209
	ldr	r3, .L218+4
	str	r3, [r2]
.L209:
	movs	r3, #128
	ldr	r2, .L218+12
	lsls	r3, r3, #3
	strh	r3, [r2]
	ldr	r2, .L218+16
	strh	r3, [r2]
	movs	r2, #143
	ldr	r3, .L218+20
	strh	r2, [r3]
	ldr	r3, .L218+24
	ldr	r2, .L218+28
	strh	r2, [r3]
	movs	r3, #63
	ldr	r2, .L218+32
	ldrb	r1, [r2]
	ands	r3, r1
	movs	r1, #64
	orrs	r3, r1
	strb	r3, [r2]
	movs	r3, #212
	lsls	r3, r3, #2
	adds	r2, r4, r3
	ldr	r3, .L218+36
	str	r2, [r3]
	ldr	r3, .L218+40
	ldr	r2, .L218+44
	str	r2, [r3]
	movs	r3, #152
	lsls	r3, r3, #4
	adds	r2, r4, r3
	ldr	r3, .L218+48
	str	r2, [r3]
	ldr	r3, .L218+52
	ldr	r2, .L218+56
	str	r2, [r3]
	ldr	r3, .L218+60
	str	r4, [r3]
	movs	r3, #0
	movs	r1, r4
	ldr	r2, .L218+64
	add	r0, sp, #4
	str	r3, [sp, #4]
	bl	CpuFastSet
	ldr	r3, .L218+68
	strh	r3, [r4, #6]
	ldr	r3, .L218+72
	ldr	r5, .L218+76
	str	r3, [r4, #56]
	ldr	r3, .L218+80
	movs	r0, r5
	str	r3, [r4, #40]
	str	r3, [r4, #44]
	str	r3, [r4, #48]
	str	r3, [r4, #60]
	bl	MPlayJumpTableCopy
	movs	r0, #128
	str	r5, [r4, #52]
	lsls	r0, r0, #11
	bl	SampleFreqSet
	ldr	r3, .L218+84
	str	r3, [r4]
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L219:
	.align	2
.L218:
	.word	67109060
	.word	-2076180476
	.word	67109072
	.word	67109062
	.word	67109074
	.word	67108996
	.word	67108994
	.word	-22258
	.word	67109001
	.word	67109052
	.word	67109056
	.word	67109024
	.word	67109064
	.word	67109068
	.word	67109028
	.word	50364400
	.word	16778220
	.word	3848
	.word	ply_note
	.word	gMPlayJumpTable
	.word	DummyFunc
	.word	1752395091
	.size	SoundInit, .-SoundInit
	.global	__aeabi_uidiv
	.global	__aeabi_idiv
	.align	1
	.p2align 2,,3
	.global	SampleFreqSet
	.syntax unified
	.code	16
	.thumb_func
	.type	SampleFreqSet, %function
SampleFreqSet:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L239
	push	{r4, r5, r6, lr}
	ldr	r1, [r3]
	ldr	r2, .L239+4
	ldr	r3, [r1]
	adds	r2, r3, r2
	movs	r4, r0
	sub	sp, sp, #8
	cmp	r2, #1
	bhi	.L221
	movs	r2, #0
	adds	r3, r3, #10
	str	r3, [r1]
	ldr	r3, .L239+8
	strh	r2, [r3]
	ldr	r2, .L239+12
	ldr	r3, [r2]
	lsls	r3, r3, #6
	bpl	.L222
	ldr	r3, .L239+16
	str	r3, [r2]
.L222:
	ldr	r2, .L239+20
	ldr	r3, [r2]
	lsls	r3, r3, #6
	bmi	.L238
.L223:
	movs	r3, #128
	ldr	r2, .L239+24
	lsls	r3, r3, #3
	strh	r3, [r2]
	ldr	r2, .L239+28
	strh	r3, [r2]
	movs	r3, #0
	str	r3, [sp, #4]
	movs	r3, #212
	lsls	r3, r3, #2
	mov	ip, r3
	ldr	r2, .L239+32
	add	r1, r1, ip
	add	r0, sp, #4
	bl	CpuFastSet
.L221:
	ldr	r6, .L239
	lsls	r0, r4, #12
	ldr	r5, [r6]
	lsrs	r0, r0, #28
	ldr	r3, .L239+36
	strb	r0, [r5, #8]
	subs	r0, r0, #1
	lsls	r0, r0, #1
	ldrh	r4, [r0, r3]
	movs	r0, #198
	movs	r1, r4
	str	r4, [r5, #16]
	lsls	r0, r0, #3
	bl	__aeabi_idiv
	ldr	r3, .L239+40
	mov	ip, r3
	strb	r0, [r5, #11]
	ldr	r0, .L239+44
	muls	r0, r4
	ldr	r1, .L239+48
	add	r0, r0, ip
	bl	__aeabi_idiv
	movs	r1, r0
	str	r0, [r5, #20]
	movs	r0, #128
	lsls	r0, r0, #17
	bl	__aeabi_idiv
	ldr	r1, [r6]
	adds	r0, r0, #1
	ldr	r3, [r1]
	ldr	r2, .L239+52
	asrs	r0, r0, #1
	str	r0, [r5, #24]
	cmp	r3, r2
	beq	.L220
	ldr	r2, .L239+56
	ldr	r0, .L239+24
	strh	r2, [r0]
	ldr	r0, .L239+28
	strh	r2, [r0]
	movs	r2, #0
	subs	r3, r3, #10
	strb	r2, [r1, #4]
	str	r3, [r1]
	ldr	r2, .L239+60
.L225:
	ldrb	r3, [r2]
	cmp	r3, #159
	beq	.L225
	ldr	r2, .L239+60
.L226:
	ldrb	r3, [r2]
	cmp	r3, #159
	bne	.L226
	ldr	r1, [r1, #16]
	ldr	r0, .L239+64
	bl	__aeabi_idiv
	movs	r2, #128
	ldr	r3, .L239+68
	lsls	r0, r0, #16
	lsrs	r0, r0, #16
	strh	r0, [r3]
	ldr	r3, .L239+8
	strh	r2, [r3]
.L220:
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L238:
	ldr	r3, .L239+16
	str	r3, [r2]
	b	.L223
.L240:
	.align	2
.L239:
	.word	50364400
	.word	-1752395091
	.word	67109122
	.word	67109060
	.word	-2076180476
	.word	67109072
	.word	67109062
	.word	67109074
	.word	16778008
	.word	gPcmSamplesPerVBlankTable
	.word	5000
	.word	597275
	.word	10000
	.word	1752395091
	.word	-18944
	.word	67108870
	.word	-280896
	.word	67109120
	.size	SampleFreqSet, .-SampleFreqSet
	.align	1
	.p2align 2,,3
	.global	m4aSoundMode
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSoundMode, %function
m4aSoundMode:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L264
	push	{r4, r5, r6, lr}
	ldr	r4, [r2]
	ldr	r2, .L264+4
	ldr	r1, [r4]
	movs	r3, r0
	cmp	r1, r2
	bne	.L241
	ldr	r2, .L264+8
	str	r2, [r4]
	movs	r2, #255
	tst	r2, r0
	beq	.L243
	subs	r2, r2, #128
	ands	r2, r0
	strb	r2, [r4, #5]
.L243:
	movs	r2, #240
	movs	r1, r3
	lsls	r2, r2, #4
	ands	r1, r2
	tst	r3, r2
	beq	.L244
	lsrs	r1, r1, #8
	strb	r1, [r4, #6]
	movs	r2, #0
	movs	r1, #0
	movs	r0, #64
	strb	r1, [r2]
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
	adds	r0, r0, #64
	strb	r1, [r2, r0]
.L244:
	movs	r2, #240
	movs	r1, r3
	lsls	r2, r2, #8
	ands	r1, r2
	tst	r3, r2
	beq	.L245
	lsrs	r1, r1, #12
	strb	r1, [r4, #7]
.L245:
	movs	r1, #176
	movs	r2, r3
	lsls	r1, r1, #16
	ands	r2, r1
	tst	r3, r1
	beq	.L246
	movs	r1, #63
	ldr	r0, .L264+12
	ldrb	r5, [r0]
	lsrs	r2, r2, #14
	ands	r1, r5
	orrs	r2, r1
	lsls	r2, r2, #24
	lsrs	r2, r2, #24
	strb	r2, [r0]
.L246:
	movs	r2, #240
	movs	r0, r3
	lsls	r2, r2, #12
	ands	r0, r2
	tst	r3, r2
	bne	.L263
.L247:
	ldr	r3, .L264+4
	str	r3, [r4]
.L241:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L263:
	bl	SampleFreqSet
	b	.L247
.L265:
	.align	2
.L264:
	.word	50364400
	.word	1752395091
	.word	1752395092
	.word	67109001
	.size	m4aSoundMode, .-m4aSoundMode
	.align	1
	.p2align 2,,3
	.global	SoundClear
	.syntax unified
	.code	16
	.thumb_func
	.type	SoundClear, %function
SoundClear:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldr	r3, .L274
	ldr	r4, [r3]
	ldr	r3, .L274+4
	ldr	r2, [r4]
	cmp	r2, r3
	bne	.L266
	ldr	r3, .L274+8
	movs	r2, #80
	str	r3, [r4]
	movs	r3, #0
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	adds	r2, r2, #64
	strb	r3, [r4, r2]
	ldr	r6, [r4, #28]
	cmp	r6, #0
	beq	.L268
	movs	r5, #1
	movs	r7, #0
.L269:
	lsls	r0, r5, #24
	ldr	r3, [r4, #44]
	lsrs	r0, r0, #24
	adds	r5, r5, #1
	bl	.L89
	strb	r7, [r6]
	adds	r6, r6, #64
	cmp	r5, #5
	bne	.L269
.L268:
	ldr	r3, .L274+4
	str	r3, [r4]
.L266:
	@ sp needed
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L275:
	.align	2
.L274:
	.word	50364400
	.word	1752395091
	.word	1752395092
	.size	SoundClear, .-SoundClear
	.align	1
	.p2align 2,,3
	.global	m4aSoundVSyncOff
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSoundVSyncOff, %function
m4aSoundVSyncOff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L289
	push	{lr}
	ldr	r1, [r3]
	ldr	r2, .L289+4
	ldr	r3, [r1]
	adds	r2, r3, r2
	sub	sp, sp, #12
	cmp	r2, #1
	bhi	.L276
	movs	r2, #0
	adds	r3, r3, #10
	str	r3, [r1]
	ldr	r3, .L289+8
	strh	r2, [r3]
	ldr	r2, .L289+12
	ldr	r3, [r2]
	lsls	r3, r3, #6
	bpl	.L278
	ldr	r3, .L289+16
	str	r3, [r2]
.L278:
	ldr	r2, .L289+20
	ldr	r3, [r2]
	lsls	r3, r3, #6
	bmi	.L288
.L279:
	movs	r3, #128
	ldr	r2, .L289+24
	lsls	r3, r3, #3
	strh	r3, [r2]
	ldr	r2, .L289+28
	strh	r3, [r2]
	movs	r3, #0
	str	r3, [sp, #4]
	movs	r3, #212
	lsls	r3, r3, #2
	mov	ip, r3
	ldr	r2, .L289+32
	add	r1, r1, ip
	add	r0, sp, #4
	bl	CpuFastSet
.L276:
	add	sp, sp, #12
	@ sp needed
	pop	{r0}
	bx	r0
.L288:
	ldr	r3, .L289+16
	str	r3, [r2]
	b	.L279
.L290:
	.align	2
.L289:
	.word	50364400
	.word	-1752395091
	.word	67109122
	.word	67109060
	.word	-2076180476
	.word	67109072
	.word	67109062
	.word	67109074
	.word	16778008
	.size	m4aSoundVSyncOff, .-m4aSoundVSyncOff
	.align	1
	.p2align 2,,3
	.global	m4aSoundVSyncOn
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSoundVSyncOn, %function
m4aSoundVSyncOn:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L298
	ldr	r1, [r3]
	ldr	r2, .L298+4
	ldr	r3, [r1]
	push	{r4, lr}
	cmp	r3, r2
	beq	.L291
	ldr	r2, .L298+8
	ldr	r0, .L298+12
	strh	r2, [r0]
	ldr	r0, .L298+16
	strh	r2, [r0]
	movs	r2, #0
	subs	r3, r3, #10
	strb	r2, [r1, #4]
	str	r3, [r1]
	ldr	r2, .L298+20
.L293:
	ldrb	r3, [r2]
	cmp	r3, #159
	beq	.L293
	ldr	r2, .L298+20
.L294:
	ldrb	r3, [r2]
	cmp	r3, #159
	bne	.L294
	ldr	r1, [r1, #16]
	ldr	r0, .L298+24
	bl	__aeabi_idiv
	movs	r2, #128
	ldr	r3, .L298+28
	lsls	r0, r0, #16
	lsrs	r0, r0, #16
	strh	r0, [r3]
	ldr	r3, .L298+32
	strh	r2, [r3]
.L291:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L299:
	.align	2
.L298:
	.word	50364400
	.word	1752395091
	.word	-18944
	.word	67109062
	.word	67109074
	.word	67108870
	.word	-280896
	.word	67109120
	.word	67109122
	.size	m4aSoundVSyncOn, .-m4aSoundVSyncOn
	.align	1
	.p2align 2,,3
	.global	m4aSoundVSync
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aSoundVSync, %function
m4aSoundVSync:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r1, .L315
	mov	ip, r1
	ldr	r3, .L315+4
	ldr	r2, [r3]
	ldr	r3, [r2]
	add	r3, r3, ip
	cmp	r3, #1
	bhi	.L300
	ldrb	r3, [r2, #4]
	subs	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r2, #4]
	lsls	r3, r3, #24
	cmp	r3, #0
	ble	.L314
.L300:
	@ sp needed
	bx	lr
.L314:
	ldrb	r3, [r2, #11]
	strb	r3, [r2, #4]
	ldr	r2, .L315+8
	ldr	r3, [r2]
	lsls	r3, r3, #6
	bpl	.L304
	ldr	r3, .L315+12
	str	r3, [r2]
.L304:
	ldr	r2, .L315+16
	ldr	r3, [r2]
	lsls	r3, r3, #6
	bpl	.L305
	ldr	r3, .L315+12
	str	r3, [r2]
.L305:
	movs	r2, #128
	ldr	r1, .L315+20
	ldr	r3, .L315+24
	lsls	r2, r2, #3
	strh	r2, [r1]
	strh	r2, [r3]
	ldr	r2, .L315+28
	strh	r2, [r1]
	strh	r2, [r3]
	b	.L300
.L316:
	.align	2
.L315:
	.word	-1752395091
	.word	50364400
	.word	67109060
	.word	-2076180476
	.word	67109072
	.word	67109062
	.word	67109074
	.word	-18944
	.size	m4aSoundVSync, .-m4aSoundVSync
	.align	1
	.p2align 2,,3
	.global	MPlayOpen
	.syntax unified
	.code	16
	.thumb_func
	.type	MPlayOpen, %function
MPlayOpen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	movs	r7, r0
	movs	r6, r1
	subs	r4, r2, #0
	beq	.L317
	ldr	r3, .L375
	ldr	r5, [r3]
	ldr	r3, .L375+4
	ldr	r2, [r5]
	cmp	r2, r3
	beq	.L373
.L317:
	@ sp needed
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L373:
	movs	r2, #140
	ldr	r3, .L375+8
	str	r3, [r5]
	ldr	r3, .L375+12
	ldr	r3, [r3, r2]
	bl	.L89
	str	r6, [r7, #44]
	adds	r3, r4, #0
	cmp	r4, #16
	bhi	.L374
.L319:
	strb	r3, [r7, #8]
	movs	r3, #128
	lsls	r3, r3, #24
	str	r3, [r7, #4]
	movs	r3, #0
	strb	r3, [r6]
	cmp	r4, #1
	beq	.L320
	movs	r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #2
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #3
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #4
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #5
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #6
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #7
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #8
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #9
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #10
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #11
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #12
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #13
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #14
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
	cmp	r4, #15
	beq	.L320
	adds	r2, r2, #80
	strb	r3, [r6, r2]
.L320:
	ldr	r3, [r5, #32]
	cmp	r3, #0
	beq	.L321
	str	r3, [r7, #56]
	ldr	r3, [r5, #36]
	str	r3, [r7, #60]
.L321:
	ldr	r3, .L375+16
	str	r7, [r5, #36]
	str	r3, [r5, #32]
	ldr	r3, .L375+4
	str	r3, [r7, #52]
	str	r3, [r5]
	b	.L317
.L374:
	movs	r3, #16
	b	.L319
.L376:
	.align	2
.L375:
	.word	50364400
	.word	1752395091
	.word	1752395092
	.word	gMPlayJumpTable
	.word	MPlayMain
	.size	MPlayOpen, .-MPlayOpen
	.align	1
	.p2align 2,,3
	.global	MPlayStart
	.syntax unified
	.code	16
	.thumb_func
	.type	MPlayStart, %function
MPlayStart:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, [r0, #52]
	ldr	r3, .L379
	push	{r4, lr}
	cmp	r2, r3
	bne	.L377
	bl	MPlayStart.part.0
.L377:
	@ sp needed
	pop	{r4}
	pop	{r0}
	bx	r0
.L380:
	.align	2
.L379:
	.word	1752395091
	.size	MPlayStart, .-MPlayStart
	.align	1
	.p2align 2,,3
	.global	m4aMPlayStop
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayStop, %function
m4aMPlayStop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, [r0, #52]
	ldr	r3, .L389
	push	{r4, r5, r6, lr}
	movs	r6, r0
	cmp	r2, r3
	bne	.L381
	ldr	r3, .L389+4
	str	r3, [r0, #52]
	movs	r3, #128
	ldr	r2, [r0, #4]
	lsls	r3, r3, #24
	ldrb	r4, [r0, #8]
	orrs	r3, r2
	str	r3, [r0, #4]
	ldr	r5, [r0, #44]
	cmp	r4, #0
	beq	.L383
.L384:
	movs	r1, r5
	movs	r0, r6
	subs	r4, r4, #1
	bl	TrackStop
	adds	r5, r5, #80
	cmp	r4, #0
	bne	.L384
.L383:
	ldr	r3, .L389
	str	r3, [r6, #52]
.L381:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L390:
	.align	2
.L389:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayStop, .-m4aMPlayStop
	.align	1
	.p2align 2,,3
	.global	FadeOutBody
	.syntax unified
	.code	16
	.thumb_func
	.type	FadeOutBody, %function
FadeOutBody:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldrh	r2, [r0, #36]
	movs	r6, r0
	cmp	r2, #0
	beq	.L391
	ldrh	r3, [r0, #38]
	subs	r3, r3, #1
	lsls	r3, r3, #16
	lsrs	r1, r3, #16
	cmp	r3, #0
	bne	.L412
	ldrh	r3, [r0, #40]
	strh	r2, [r0, #38]
	ldrb	r5, [r0, #8]
	ldr	r4, [r0, #44]
	lsls	r2, r3, #30
	bpl	.L396
	adds	r3, r3, #16
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	cmp	r3, #255
	bls	.L397
	movs	r3, #128
	lsls	r3, r3, #1
	strh	r3, [r0, #40]
	strh	r1, [r0, #36]
.L398:
	cmp	r5, #0
	beq	.L391
	movs	r0, #3
	lsls	r3, r3, #22
	lsrs	r2, r3, #24
.L405:
	ldrb	r3, [r4]
	lsls	r1, r3, #24
	bpl	.L404
	orrs	r3, r0
	strb	r2, [r4, #19]
	strb	r3, [r4]
.L404:
	subs	r5, r5, #1
	adds	r4, r4, #80
	cmp	r5, #0
	bne	.L405
.L391:
	@ sp needed
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L412:
	strh	r1, [r0, #38]
	b	.L391
.L396:
	subs	r3, r3, #16
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	lsls	r2, r3, #16
	strh	r3, [r0, #40]
	asrs	r2, r2, #16
	cmp	r2, #0
	bgt	.L398
	cmp	r5, #0
	beq	.L399
	movs	r7, #1
.L401:
	movs	r1, r4
	movs	r0, r6
	bl	TrackStop
	movs	r2, r7
	ldrh	r3, [r6, #40]
	ands	r2, r3
	tst	r7, r3
	bne	.L400
	strb	r2, [r4]
.L400:
	subs	r5, r5, #1
	adds	r4, r4, #80
	cmp	r5, #0
	bne	.L401
.L402:
	cmp	r2, #0
	bne	.L413
	movs	r3, #128
	lsls	r3, r3, #24
.L403:
	str	r3, [r6, #4]
	movs	r3, #0
	strh	r3, [r6, #36]
	b	.L391
.L397:
	strh	r3, [r0, #40]
	b	.L398
.L413:
	movs	r3, #128
	ldr	r2, [r6, #4]
	lsls	r3, r3, #24
	orrs	r3, r2
	b	.L403
.L399:
	movs	r2, #1
	ands	r2, r3
	b	.L402
	.size	FadeOutBody, .-FadeOutBody
	.align	1
	.p2align 2,,3
	.global	TrkVolPitSet
	.syntax unified
	.code	16
	.thumb_func
	.type	TrkVolPitSet, %function
TrkVolPitSet:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldrb	r2, [r1]
	push	{r4, r5, lr}
	lsls	r3, r2, #31
	bpl	.L415
	ldrb	r3, [r1, #18]
	ldrb	r0, [r1, #19]
	muls	r0, r3
	movs	r3, #20
	movs	r5, #21
	ldrsb	r3, [r1, r3]
	ldrsb	r5, [r1, r5]
	ldrb	r4, [r1, #24]
	lsls	r3, r3, #1
	lsrs	r0, r0, #5
	adds	r3, r3, r5
	cmp	r4, #1
	beq	.L431
	cmp	r4, #2
	bne	.L417
	movs	r4, #22
	ldrsb	r4, [r1, r4]
	adds	r3, r3, r4
.L417:
	cmp	r3, #127
	ble	.L418
	movs	r3, #127
.L419:
	movs	r4, r3
	adds	r4, r4, #128
	muls	r4, r0
	lsrs	r4, r4, #8
	strb	r4, [r1, #16]
	movs	r4, #127
	subs	r3, r4, r3
	muls	r0, r3
	lsrs	r0, r0, #8
	strb	r0, [r1, #17]
.L415:
	lsls	r3, r2, #29
	bpl	.L420
	movs	r3, #14
	ldrb	r0, [r1, #15]
	ldrsb	r3, [r1, r3]
	muls	r0, r3
	movs	r3, #12
	ldrsb	r3, [r1, r3]
	adds	r3, r3, r0
	movs	r0, #10
	ldrsb	r0, [r1, r0]
	lsls	r3, r3, #2
	lsls	r0, r0, #8
	adds	r3, r3, r0
	movs	r0, #11
	ldrsb	r0, [r1, r0]
	lsls	r0, r0, #8
	adds	r3, r3, r0
	ldrb	r0, [r1, #13]
	adds	r3, r3, r0
	ldrb	r0, [r1, #24]
	cmp	r0, #0
	beq	.L432
.L421:
	lsls	r0, r3, #8
	lsls	r3, r3, #16
	lsrs	r3, r3, #24
	orrs	r3, r0
	strh	r3, [r1, #8]
.L420:
	@ sp needed
	movs	r3, #5
	bics	r2, r3
	strb	r2, [r1]
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L432:
	movs	r0, #22
	ldrsb	r0, [r1, r0]
	lsls	r0, r0, #4
	adds	r3, r3, r0
	b	.L421
.L418:
	movs	r4, r3
	adds	r4, r4, #128
	bge	.L419
	movs	r3, #128
	rsbs	r3, r3, #0
	b	.L419
.L431:
	movs	r4, #22
	ldrsb	r4, [r1, r4]
	adds	r4, r4, #128
	muls	r0, r4
	lsrs	r0, r0, #7
	b	.L417
	.size	TrkVolPitSet, .-TrkVolPitSet
	.align	1
	.p2align 2,,3
	.global	MidiKeyToCgbFreq
	.syntax unified
	.code	16
	.thumb_func
	.type	MidiKeyToCgbFreq, %function
MidiKeyToCgbFreq:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	cmp	r0, #4
	beq	.L442
	cmp	r1, #35
	bhi	.L443
	movs	r0, #0
	movs	r5, #1
	movs	r1, #0
.L438:
	movs	r3, #15
	ldr	r4, .L445
	ldrb	r2, [r4, r1]
	ldrb	r4, [r4, r5]
	ldr	r1, .L445+4
	asrs	r6, r2, #4
	ands	r2, r3
	ands	r3, r4
	lsls	r2, r2, #1
	lsls	r3, r3, #1
	ldrsh	r2, [r2, r1]
	ldrsh	r3, [r3, r1]
	asrs	r5, r4, #4
	asrs	r2, r2, r6
	asrs	r3, r3, r5
	subs	r3, r3, r2
	muls	r0, r3
	movs	r3, #128
	lsls	r3, r3, #4
	mov	ip, r3
	asrs	r0, r0, #8
	adds	r0, r0, r2
	add	r0, r0, ip
.L433:
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L443:
	subs	r1, r1, #36
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	cmp	r1, #130
	bls	.L444
	movs	r0, #255
	movs	r5, #131
	movs	r1, #130
	b	.L438
.L442:
	movs	r3, #0
	cmp	r1, #20
	bls	.L435
	subs	r1, r1, #21
	adds	r3, r1, #0
	lsls	r1, r1, #24
	lsrs	r1, r1, #24
	cmp	r1, #59
	bls	.L436
	movs	r3, #59
.L436:
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
.L435:
	ldr	r2, .L445+8
	ldrb	r0, [r2, r3]
	b	.L433
.L444:
	movs	r0, r2
	adds	r5, r1, #1
	b	.L438
.L446:
	.align	2
.L445:
	.word	gCgbScaleTable
	.word	gCgbFreqTable
	.word	gNoiseTable
	.size	MidiKeyToCgbFreq, .-MidiKeyToCgbFreq
	.align	1
	.p2align 2,,3
	.global	CgbOscOff
	.syntax unified
	.code	16
	.thumb_func
	.type	CgbOscOff, %function
CgbOscOff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #2
	beq	.L448
	cmp	r0, #3
	beq	.L449
	cmp	r0, #1
	bne	.L450
	movs	r2, #8
	ldr	r3, .L452
	strb	r2, [r3]
	ldr	r3, .L452+4
	adds	r2, r2, #120
	strb	r2, [r3]
.L447:
	@ sp needed
	bx	lr
.L449:
	movs	r2, #0
	ldr	r3, .L452+8
	strb	r2, [r3]
	b	.L447
.L448:
	movs	r2, #8
	ldr	r3, .L452+12
	strb	r2, [r3]
	ldr	r3, .L452+16
	adds	r2, r2, #120
	strb	r2, [r3]
	b	.L447
.L450:
	movs	r2, #8
	ldr	r3, .L452+20
	strb	r2, [r3]
	ldr	r3, .L452+24
	adds	r2, r2, #120
	strb	r2, [r3]
	b	.L447
.L453:
	.align	2
.L452:
	.word	67108963
	.word	67108965
	.word	67108976
	.word	67108969
	.word	67108973
	.word	67108985
	.word	67108989
	.size	CgbOscOff, .-CgbOscOff
	.align	1
	.p2align 2,,3
	.global	CgbModVol
	.syntax unified
	.code	16
	.thumb_func
	.type	CgbModVol, %function
CgbModVol:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r3, .L460
	ldr	r2, [r3]
	ldrb	r4, [r2, #9]
	movs	r2, #1
	ldrb	r3, [r0, #2]
	ldrb	r1, [r0, #3]
	ands	r2, r4
	bne	.L455
	adds	r2, r2, #15
	cmp	r3, r1
	bcs	.L458
	cmp	r3, #0
	beq	.L459
.L455:
	movs	r2, #255
	adds	r3, r3, r1
	lsls	r3, r3, #24
	lsrs	r3, r3, #28
.L457:
	ldrb	r1, [r0, #6]
	@ sp needed
	strb	r3, [r0, #10]
	muls	r3, r1
	adds	r3, r3, #15
	asrs	r3, r3, #4
	strb	r3, [r0, #25]
	ldrb	r3, [r0, #28]
	ands	r3, r2
	strb	r3, [r0, #27]
	pop	{r4}
	pop	{r0}
	bx	r0
.L459:
	movs	r2, #240
.L458:
	adds	r3, r3, r1
	lsls	r3, r3, #24
	lsrs	r3, r3, #28
	b	.L457
.L461:
	.align	2
.L460:
	.word	50364400
	.size	CgbModVol, .-CgbModVol
	.align	1
	.p2align 2,,3
	.global	CgbSound
	.syntax unified
	.code	16
	.thumb_func
	.type	CgbSound, %function
CgbSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r9
	mov	lr, fp
	mov	r7, r10
	mov	r5, r8
	push	{r5, r6, r7, lr}
	ldr	r3, .L579
	ldr	r3, [r3]
	mov	r9, r3
	ldrb	r3, [r3, #10]
	movs	r2, #14
	sub	sp, sp, #44
	cmp	r3, #0
	beq	.L463
	subs	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r2, r3, #24
.L463:
	mov	r3, r9
	movs	r0, #0
	movs	r5, #1
	mov	r4, r9
	strb	r2, [r3, #10]
	ldr	r1, [r3, #28]
	ldr	r3, .L579+4
	str	r3, [sp, #8]
	ldr	r3, .L579+8
	str	r3, [sp, #12]
	ldr	r3, .L579+12
	str	r3, [sp, #16]
.L521:
	ldrb	r3, [r1]
	movs	r6, #56
	movs	r2, r3
	bics	r2, r6
	beq	.L464
	cmp	r5, #4
	bne	.LCB2916
	b	.L524	@long jump
.LCB2916:
	ldr	r7, .L579+16
	mov	r8, r7
	ldr	r7, .L579+20
	mov	r10, r7
	ldr	r2, [sp, #8]
	ldr	r2, [r2, r0]
	mov	fp, r2
	ldr	r2, [sp, #12]
	ldr	r2, [r2, r0]
	lsls	r6, r5, #3
	str	r2, [sp, #4]
	ldr	r2, [sp, #16]
	add	r8, r8, r6
	add	r10, r10, r6
	subs	r6, r5, #1
	lsls	r6, r6, #24
	ldr	r2, [r2, r0]
	lsrs	r6, r6, #24
.L465:
	ldrb	r7, [r4, #10]
	str	r7, [sp, #20]
	ldrb	r7, [r2]
	mov	r9, r7
	lsls	r7, r3, #24
	bmi	.L567
	movs	r7, #4
	tst	r7, r3
	bne	.L482
	ldr	r7, .L579+24
	ldrb	r7, [r7]
	asrs	r7, r7, r6
	lsls	r7, r7, #31
	bpl	.LCB2963
	b	.L483	@long jump
.LCB2963:
.L482:
	ldrb	r3, [r1, #13]
	subs	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r1, #13]
	lsls	r3, r3, #24
	cmp	r3, #0
	ble	.L467
.L566:
	ldrb	r3, [r1, #29]
.L484:
	lsls	r6, r3, #30
	bpl	.L513
	ldr	r3, [r1, #32]
	cmp	r5, #4
	bne	.LCB2986
	b	.L514	@long jump
.LCB2986:
.L503:
	ldrb	r6, [r1, #1]
	lsls	r6, r6, #28
	bpl	.L515
	ldr	r6, .L579+28
	ldrb	r6, [r6]
	cmp	r6, #63
	ble	.LCB2999
	b	.L516	@long jump
.LCB2999:
	ldr	r6, .L579+32
	adds	r3, r3, #2
	ands	r3, r6
	str	r3, [r1, #32]
.L515:
	mov	r6, r8
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r6]
.L517:
	movs	r7, #63
	ldr	r3, [r1, #32]
	ldrb	r6, [r1, #26]
	lsrs	r3, r3, #8
	bics	r6, r7
	ands	r3, r7
	orrs	r3, r6
	mov	r6, r10
	strb	r3, [r1, #26]
	strb	r3, [r6]
	ldrb	r3, [r1, #29]
.L513:
	lsls	r3, r3, #31
	bpl	.L489
	ldr	r6, .L579+36
	ldrb	r7, [r1, #28]
	ldrb	r3, [r6]
	bics	r3, r7
	ldrb	r7, [r1, #27]
	orrs	r3, r7
	strb	r3, [r6]
	cmp	r5, #3
	bne	.LCB3046
	b	.L522	@long jump
.LCB3046:
	movs	r6, #15
	mov	r7, r9
	ldrb	r3, [r1, #9]
	ands	r6, r7
	lsls	r3, r3, #4
	adds	r3, r3, r6
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r2]
	movs	r2, #128
	mov	r6, r10
	ldrb	r3, [r1, #26]
	rsbs	r2, r2, #0
	orrs	r3, r2
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r6]
	cmp	r5, #1
	bne	.LCB3065
	b	.L568	@long jump
.LCB3065:
.L489:
	movs	r3, #0
	strb	r3, [r1, #29]
.L464:
	adds	r0, r0, #4
	adds	r5, r5, #1
	adds	r1, r1, #64
	cmp	r0, #16
	bne	.L521
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L567:
	lsls	r3, r3, #25
	bpl	.L569
.L467:
	cmp	r5, #2
	bne	.LCB3101
	b	.L485	@long jump
.LCB3101:
	cmp	r5, #3
	bne	.LCB3103
	b	.L486	@long jump
.LCB3103:
	cmp	r5, #1
	beq	.LCB3105
	b	.L487	@long jump
.LCB3105:
	movs	r2, #8
	ldr	r3, .L579+40
	strb	r2, [r3]
	ldr	r3, .L579+44
	adds	r2, r2, #120
	strb	r2, [r3]
.L488:
	movs	r3, #0
	strb	r3, [r1]
	b	.L489
.L524:
	ldr	r2, .L579+48
	ldr	r7, .L579+52
	mov	r10, r2
	str	r7, [sp, #4]
	ldr	r2, .L579+56
	ldr	r7, .L579+60
	mov	r8, r2
	movs	r6, #3
	mov	fp, r7
	ldr	r2, .L579+64
	b	.L465
.L569:
	movs	r3, #3
	strb	r3, [r1]
	strb	r3, [r1, #29]
	ldr	r3, .L579
	ldr	r6, [r3]
	ldrb	r7, [r1, #3]
	ldrb	r6, [r6, #9]
	mov	ip, r7
	ldrb	r3, [r1, #2]
	lsls	r6, r6, #31
	bmi	.LCB3148
	b	.L570	@long jump
.LCB3148:
.L468:
	movs	r6, #255
	add	r3, r3, ip
	lsls	r3, r3, #24
	lsrs	r3, r3, #28
.L470:
	ldrb	r7, [r1, #6]
	mov	ip, r7
	movs	r7, r3
	strb	r3, [r1, #10]
	mov	r3, ip
	muls	r3, r7
	adds	r3, r3, #15
	asrs	r3, r3, #4
	strb	r3, [r1, #25]
	ldrb	r3, [r1, #28]
	ands	r3, r6
	strb	r3, [r1, #27]
	cmp	r5, #2
	beq	.L472
	cmp	r5, #3
	bne	.LCB3172
	b	.L473	@long jump
.LCB3172:
	cmp	r5, #1
	beq	.LCB3174
	b	.L474	@long jump
.LCB3174:
	mov	r6, fp
	ldrb	r3, [r1, #31]
	strb	r3, [r6]
.L472:
	ldr	r3, [r1, #36]
	ldrb	r6, [r1, #30]
	lsls	r3, r3, #6
	adds	r3, r3, r6
	lsls	r3, r3, #24
	ldr	r6, [sp, #4]
	lsrs	r3, r3, #24
	strb	r3, [r6]
.L475:
	movs	r6, #8
	mov	r9, r6
	ldrb	r6, [r1, #30]
	subs	r7, r6, #1
	sbcs	r6, r6, r7
	ldrb	r3, [r1, #4]
	lsls	r6, r6, #6
	strb	r6, [r1, #26]
	add	r9, r9, r3
.L478:
	strb	r3, [r1, #11]
	cmp	r3, #0
	beq	.LCB3202
	b	.L479	@long jump
.LCB3202:
	ldrb	r3, [r1]
.L480:
	subs	r3, r3, #1
	ldrb	r6, [r1, #5]
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r1]
	strb	r6, [r1, #11]
	cmp	r6, #0
	bne	.LCB3213
	b	.L571	@long jump
.LCB3213:
	movs	r7, #1
	ldrb	r3, [r1, #29]
	orrs	r3, r7
	strb	r3, [r1, #29]
	ldrb	r3, [r1, #10]
	strb	r3, [r1, #9]
	subs	r3, r6, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	cmp	r5, #3
	beq	.L481
	mov	r9, r6
.L481:
	ldr	r6, [sp, #20]
	strb	r3, [r1, #11]
	cmp	r6, #0
	beq	.LCB3231
	b	.L566	@long jump
.LCB3231:
.L492:
	movs	r6, #1
	rsbs	r6, r6, #0
	str	r6, [sp, #20]
	cmp	r3, #0
	bne	.L564
.L495:
	cmp	r5, #3
	bne	.LCB3240
	b	.L572	@long jump
.LCB3240:
.L496:
	ldr	r3, .L579
	ldr	r7, [r3]
	ldrb	r7, [r7, #9]
	ldrb	r6, [r1, #2]
	ldrb	r3, [r1, #3]
	lsls	r7, r7, #31
	bpl	.LCB3252
	b	.L497	@long jump
.LCB3252:
	cmp	r6, r3
	bcc	.LCB3254
	b	.L573	@long jump
.LCB3254:
	cmp	r6, #0
	beq	.LCB3256
	b	.L497	@long jump
.LCB3256:
	movs	r7, #240
	str	r7, [sp, #28]
.L500:
	adds	r3, r6, r3
	lsls	r3, r3, #24
	lsrs	r3, r3, #28
	str	r3, [sp, #24]
	b	.L499
.L483:
	lsls	r6, r3, #25
	bpl	.L490
	movs	r6, #3
	tst	r6, r3
	beq	.L490
	bics	r3, r6
	ldrb	r6, [r1, #7]
	strb	r3, [r1]
	strb	r6, [r1, #11]
	cmp	r6, #0
	beq	.LCB3290
	b	.L493	@long jump
.LCB3290:
.L563:
	ldrb	r6, [r1, #10]
	str	r6, [sp, #4]
.L494:
	ldrb	r6, [r1, #12]
	ldr	r7, [sp, #4]
	muls	r7, r6
	movs	r6, r7
	adds	r6, r6, #255
	asrs	r6, r6, #8
	strb	r6, [r1, #9]
	bne	.LCB3304
	b	.L467	@long jump
.LCB3304:
	movs	r6, #4
	orrs	r3, r6
	strb	r3, [r1]
	movs	r3, #1
	ldrb	r6, [r1, #29]
	orrs	r3, r6
	strb	r3, [r1, #29]
	cmp	r5, #3
	bne	.LCB3315
	b	.L574	@long jump
.LCB3315:
	movs	r6, #8
	mov	r9, r6
	b	.L484
.L487:
	movs	r2, #8
	ldr	r3, .L579+64
	strb	r2, [r3]
	ldr	r3, .L579+48
	adds	r2, r2, #120
	strb	r2, [r3]
	b	.L488
.L486:
	movs	r2, #0
	ldr	r3, .L579+68
	strb	r2, [r3]
	b	.L488
.L570:
	movs	r6, #15
	cmp	r3, r7
	bcs	.LCB3341
	b	.L575	@long jump
.LCB3341:
.L471:
	add	r3, r3, ip
	lsls	r3, r3, #24
	lsrs	r3, r3, #28
	b	.L470
.L490:
	ldrb	r3, [r1, #11]
	cmp	r3, #0
	beq	.L495
.L564:
	subs	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	b	.L481
.L473:
	ldr	r6, [r1, #36]
	ldr	r3, [r1, #40]
	cmp	r6, r3
	beq	.L476
	movs	r3, #64
	mov	r6, fp
	strb	r3, [r6]
	ldr	r3, [r1, #36]
	ldr	r6, [r3]
	mov	ip, r6
	mov	r7, ip
	ldr	r6, .L579+72
	str	r7, [r6]
	ldr	r6, [r3, #4]
	mov	ip, r6
	mov	r7, ip
	ldr	r6, .L579+76
	str	r7, [r6]
	ldr	r6, [r3, #8]
	mov	ip, r6
	mov	r7, ip
	ldr	r6, .L579+80
	str	r7, [r6]
	ldr	r6, [r3, #12]
	mov	ip, r6
	mov	r7, ip
	ldr	r6, .L579+84
	str	r7, [r6]
	str	r3, [r1, #40]
.L476:
	movs	r3, #0
	mov	r6, fp
	strb	r3, [r6]
	ldr	r6, [sp, #4]
	ldrb	r3, [r1, #30]
	strb	r3, [r6]
	cmp	r3, #0
	bne	.LCB3401
	b	.L477	@long jump
.LCB3401:
	movs	r3, #192
	strb	r3, [r1, #26]
	ldrb	r3, [r1, #4]
	b	.L478
.L568:
	mov	r3, fp
	ldrb	r3, [r3]
	lsls	r3, r3, #28
	bpl	.LCB3418
	b	.L489	@long jump
.LCB3418:
	ldrb	r3, [r1, #26]
	orrs	r3, r2
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r6]
	b	.L489
.L580:
	.align	2
.L579:
	.word	50364400
	.word	CSWTCH.49
	.word	CSWTCH.50
	.word	CSWTCH.51
	.word	67108956
	.word	67108957
	.word	67108996
	.word	67109001
	.word	2044
	.word	67108993
	.word	67108963
	.word	67108965
	.word	67108989
	.word	67108984
	.word	67108988
	.word	67108977
	.word	67108985
	.word	67108976
	.word	67109008
	.word	67109012
	.word	67109016
	.word	67109020
.L485:
	movs	r2, #8
	ldr	r3, .L581
	strb	r2, [r3]
	ldr	r3, .L581+4
	adds	r2, r2, #120
	strb	r2, [r3]
	b	.L488
.L479:
	movs	r6, #0
	subs	r3, r3, #1
	lsls	r3, r3, #24
	strb	r6, [r1, #9]
	lsrs	r3, r3, #24
	b	.L481
.L497:
	adds	r6, r6, r3
	lsls	r6, r6, #24
	lsrs	r3, r6, #28
	str	r3, [sp, #24]
	movs	r3, #255
	str	r3, [sp, #28]
.L499:
	ldrb	r3, [r1, #6]
	mov	ip, r3
	ldr	r6, [sp, #24]
	mov	r7, ip
	muls	r7, r6
	adds	r7, r7, #15
	asrs	r7, r7, #4
	lsls	r3, r7, #24
	movs	r7, #3
	str	r3, [sp, #36]
	lsrs	r3, r3, #24
	strb	r6, [r1, #10]
	str	r6, [sp, #4]
	str	r3, [sp, #32]
	ldr	r6, [sp, #28]
	strb	r3, [r1, #25]
	ldrb	r3, [r1, #28]
	ands	r3, r6
	movs	r6, r7
	strb	r3, [r1, #27]
	ldrb	r3, [r1]
	ands	r6, r3
	tst	r7, r3
	bne	.L501
	ldrb	r6, [r1, #9]
	subs	r6, r6, #1
	lsls	r6, r6, #24
	lsrs	r6, r6, #24
	strb	r6, [r1, #9]
	lsls	r6, r6, #24
	cmp	r6, #0
	bgt	.LCB3517
	b	.L494	@long jump
.LCB3517:
	ldrb	r3, [r1, #7]
	subs	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	b	.L481
.L474:
	ldrb	r3, [r1, #30]
	ldr	r6, [sp, #4]
	strb	r3, [r6]
	mov	r6, r8
	ldr	r3, [r1, #36]
	lsls	r3, r3, #27
	lsrs	r3, r3, #24
	strb	r3, [r6]
	b	.L475
.L575:
	cmp	r3, #0
	beq	.LCB3539
	b	.L468	@long jump
.LCB3539:
	movs	r6, #240
	b	.L471
.L574:
	lsls	r6, r6, #30
	bmi	.L576
	ldr	r6, .L581+8
	ldrb	r7, [r1, #28]
	ldrb	r3, [r6]
	bics	r3, r7
	ldrb	r7, [r1, #27]
	orrs	r3, r7
	strb	r3, [r6]
.L522:
	ldrb	r6, [r1, #9]
	ldr	r3, .L581+12
	ldrb	r3, [r3, r6]
	strb	r3, [r2]
	ldrb	r3, [r1, #26]
	cmp	r3, #127
	bhi	.LCB3571
	b	.L489	@long jump
.LCB3571:
	movs	r3, #128
	mov	r2, fp
	strb	r3, [r2]
	mov	r3, r10
	ldrb	r2, [r1, #26]
	strb	r2, [r3]
	movs	r3, #127
	ands	r3, r2
	strb	r3, [r1, #26]
	b	.L489
.L514:
	mov	r6, r8
	ldrb	r7, [r6]
	movs	r6, #8
	ands	r6, r7
	orrs	r3, r6
	mov	r6, r8
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r6]
	b	.L517
.L501:
	cmp	r6, #1
	beq	.L506
	ldrb	r7, [r1, #9]
	cmp	r6, #2
	beq	.L577
	adds	r7, r7, #1
	lsls	r7, r7, #24
	ldr	r6, [sp, #24]
	lsrs	r7, r7, #24
	strb	r7, [r1, #9]
	cmp	r7, r6
	bcc	.LCB3611
	b	.L480	@long jump
.LCB3611:
	ldrb	r3, [r1, #4]
	b	.L564
.L571:
	ldrb	r6, [r1, #6]
	mov	ip, r6
.L509:
	mov	r6, ip
	cmp	r6, #0
	beq	.L578
	movs	r6, #1
	subs	r3, r3, #1
	strb	r3, [r1]
	ldrb	r3, [r1, #29]
	orrs	r3, r6
	strb	r3, [r1, #29]
	ldrb	r3, [r1, #25]
	str	r3, [sp, #32]
	cmp	r5, #3
	beq	.L506
	movs	r3, #8
	mov	r9, r3
.L506:
	ldr	r3, [sp, #32]
	strb	r3, [r1, #9]
	movs	r3, #6
	b	.L481
.L516:
	cmp	r6, #127
	ble	.LCB3646
	b	.L515	@long jump
.LCB3646:
	ldr	r6, .L581+16
	adds	r3, r3, #1
	ands	r3, r6
	str	r3, [r1, #32]
	b	.L515
.L477:
	movs	r3, #128
	strb	r3, [r1, #26]
	ldrb	r3, [r1, #4]
	b	.L478
.L578:
	adds	r6, r6, #3
	bics	r3, r6
	strb	r3, [r1]
	b	.L563
.L573:
	movs	r7, #15
	str	r7, [sp, #28]
	b	.L500
.L493:
	movs	r7, #1
	ldrb	r3, [r1, #29]
	orrs	r3, r7
	strb	r3, [r1, #29]
	subs	r3, r6, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	cmp	r5, #3
	bne	.LCB3685
	b	.L481	@long jump
.LCB3685:
	mov	r9, r6
	b	.L481
.L572:
	movs	r6, #1
	ldrb	r3, [r1, #29]
	orrs	r3, r6
	strb	r3, [r1, #29]
	b	.L496
.L577:
	subs	r6, r7, #1
	lsls	r6, r6, #24
	ldr	r7, [sp, #36]
	lsrs	r6, r6, #24
	strb	r6, [r1, #9]
	lsls	r6, r6, #24
	cmp	r7, r6
	bge	.L509
	ldrb	r3, [r1, #5]
	subs	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	b	.L481
.L576:
	ldr	r3, [r1, #32]
	b	.L503
.L582:
	.align	2
.L581:
	.word	67108969
	.word	67108973
	.word	67108993
	.word	gCgb3Vol
	.word	2046
	.size	CgbSound, .-CgbSound
	.align	1
	.p2align 2,,3
	.global	m4aMPlayTempoControl
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayTempoControl, %function
m4aMPlayTempoControl:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #52]
	ldr	r2, .L585
	cmp	r3, r2
	bne	.L583
	ldr	r2, .L585+4
	str	r2, [r0, #52]
	ldrh	r2, [r0, #28]
	strh	r1, [r0, #30]
	muls	r1, r2
	asrs	r1, r1, #8
	strh	r1, [r0, #32]
	str	r3, [r0, #52]
.L583:
	@ sp needed
	bx	lr
.L586:
	.align	2
.L585:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayTempoControl, .-m4aMPlayTempoControl
	.align	1
	.p2align 2,,3
	.global	m4aMPlayVolumeControl
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayVolumeControl, %function
m4aMPlayVolumeControl:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	ldr	r3, .L597
	ldr	r4, [r0, #52]
	cmp	r4, r3
	bne	.L587
	ldr	r3, .L597+4
	str	r3, [r0, #52]
	ldrb	r3, [r0, #8]
	ldr	r4, [r0, #44]
	cmp	r3, #0
	beq	.L592
	movs	r5, #3
	lsls	r2, r2, #22
	lsrs	r6, r2, #24
	mov	ip, r5
	movs	r2, #1
.L591:
	tst	r2, r1
	beq	.L590
	ldrb	r5, [r4]
	lsls	r7, r5, #24
	bpl	.L590
	mov	r7, ip
	orrs	r5, r7
	strb	r6, [r4, #19]
	strb	r5, [r4]
.L590:
	subs	r3, r3, #1
	adds	r4, r4, #80
	lsls	r2, r2, #1
	cmp	r3, #0
	bne	.L591
.L592:
	ldr	r3, .L597
	str	r3, [r0, #52]
.L587:
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L598:
	.align	2
.L597:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayVolumeControl, .-m4aMPlayVolumeControl
	.align	1
	.p2align 2,,3
	.global	m4aMPlayPitchControl
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayPitchControl, %function
m4aMPlayPitchControl:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	lr, r8
	ldr	r4, [r0, #52]
	ldr	r3, .L609
	push	{lr}
	cmp	r4, r3
	bne	.L599
	ldr	r3, .L609+4
	str	r3, [r0, #52]
	ldrb	r3, [r0, #8]
	ldr	r4, [r0, #44]
	cmp	r3, #0
	beq	.L604
	movs	r6, #12
	asrs	r5, r2, #8
	mov	r8, r5
	mov	ip, r6
	movs	r5, #1
.L603:
	tst	r5, r1
	beq	.L602
	ldrb	r6, [r4]
	lsls	r7, r6, #24
	bpl	.L602
	mov	r7, r8
	strb	r7, [r4, #11]
	mov	r7, ip
	orrs	r6, r7
	strb	r2, [r4, #13]
	strb	r6, [r4]
.L602:
	subs	r3, r3, #1
	adds	r4, r4, #80
	lsls	r5, r5, #1
	cmp	r3, #0
	bne	.L603
.L604:
	ldr	r3, .L609
	str	r3, [r0, #52]
.L599:
	@ sp needed
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L610:
	.align	2
.L609:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayPitchControl, .-m4aMPlayPitchControl
	.align	1
	.p2align 2,,3
	.global	m4aMPlayPanpotControl
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayPanpotControl, %function
m4aMPlayPanpotControl:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	ldr	r3, .L622
	ldr	r4, [r0, #52]
	cmp	r4, r3
	bne	.L611
	movs	r6, #3
	ldr	r3, .L622+4
	str	r3, [r0, #52]
	ldrb	r3, [r0, #8]
	movs	r4, #1
	mov	ip, r6
	ldr	r5, [r0, #44]
	cmp	r3, #0
	beq	.L616
.L615:
	tst	r4, r1
	beq	.L614
	ldrb	r6, [r5]
	lsls	r7, r6, #24
	bpl	.L614
	mov	r7, ip
	orrs	r6, r7
	strb	r2, [r5, #21]
	strb	r6, [r5]
.L614:
	subs	r3, r3, #1
	adds	r5, r5, #80
	lsls	r4, r4, #1
	cmp	r3, #0
	bne	.L615
.L616:
	ldr	r3, .L622
	str	r3, [r0, #52]
.L611:
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L623:
	.align	2
.L622:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayPanpotControl, .-m4aMPlayPanpotControl
	.align	1
	.p2align 2,,3
	.global	ClearModM
	.syntax unified
	.code	16
	.thumb_func
	.type	ClearModM, %function
ClearModM:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r3, #0
	ldrb	r2, [r0, #24]
	strb	r3, [r0, #26]
	strb	r3, [r0, #22]
	ldrb	r3, [r0]
	cmp	r2, #0
	bne	.L625
	adds	r2, r2, #12
	orrs	r3, r2
.L626:
	strb	r3, [r0]
	@ sp needed
	bx	lr
.L625:
	movs	r2, #3
	orrs	r3, r2
	b	.L626
	.size	ClearModM, .-ClearModM
	.align	1
	.p2align 2,,3
	.global	m4aMPlayModDepthSet
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayModDepthSet, %function
m4aMPlayModDepthSet:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	ldr	r3, .L646
	ldr	r4, [r0, #52]
	cmp	r4, r3
	bne	.L627
	ldr	r3, .L646+4
	str	r3, [r0, #52]
	ldrb	r3, [r0, #8]
	ldr	r4, [r0, #44]
	cmp	r3, #0
	beq	.L636
	cmp	r2, #0
	beq	.L637
	movs	r5, #1
.L632:
	tst	r1, r5
	beq	.L631
	ldrb	r6, [r4]
	cmp	r6, #127
	bls	.L631
	strb	r2, [r4, #23]
.L631:
	subs	r3, r3, #1
	lsls	r5, r5, #1
	adds	r4, r4, #80
	cmp	r3, #0
	bne	.L632
.L636:
	ldr	r3, .L646
	str	r3, [r0, #52]
.L627:
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L637:
	movs	r2, #1
	movs	r7, #0
	b	.L630
.L634:
	subs	r3, r3, #1
	lsls	r2, r2, #1
	adds	r4, r4, #80
	cmp	r3, #0
	beq	.L636
.L630:
	tst	r2, r1
	beq	.L634
	ldrb	r5, [r4]
	lsls	r6, r5, #24
	bpl	.L634
	ldrb	r6, [r4, #24]
	strb	r7, [r4, #23]
	strb	r7, [r4, #26]
	strb	r7, [r4, #22]
	cmp	r6, #0
	bne	.L635
	movs	r6, #12
	orrs	r5, r6
	strb	r5, [r4]
	b	.L634
.L635:
	movs	r6, #3
	orrs	r5, r6
	strb	r5, [r4]
	b	.L634
.L647:
	.align	2
.L646:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayModDepthSet, .-m4aMPlayModDepthSet
	.align	1
	.p2align 2,,3
	.global	m4aMPlayLFOSpeedSet
	.syntax unified
	.code	16
	.thumb_func
	.type	m4aMPlayLFOSpeedSet, %function
m4aMPlayLFOSpeedSet:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	ldr	r3, .L667
	ldr	r4, [r0, #52]
	cmp	r4, r3
	bne	.L648
	ldr	r3, .L667+4
	str	r3, [r0, #52]
	ldrb	r3, [r0, #8]
	ldr	r4, [r0, #44]
	cmp	r3, #0
	beq	.L657
	cmp	r2, #0
	beq	.L658
	movs	r5, #1
.L653:
	tst	r1, r5
	beq	.L652
	ldrb	r6, [r4]
	cmp	r6, #127
	bls	.L652
	strb	r2, [r4, #25]
.L652:
	subs	r3, r3, #1
	lsls	r5, r5, #1
	adds	r4, r4, #80
	cmp	r3, #0
	bne	.L653
.L657:
	ldr	r3, .L667
	str	r3, [r0, #52]
.L648:
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L658:
	movs	r2, #1
	movs	r7, #0
	b	.L651
.L655:
	subs	r3, r3, #1
	lsls	r2, r2, #1
	adds	r4, r4, #80
	cmp	r3, #0
	beq	.L657
.L651:
	tst	r2, r1
	beq	.L655
	ldrb	r5, [r4]
	lsls	r6, r5, #24
	bpl	.L655
	ldrb	r6, [r4, #24]
	strb	r7, [r4, #25]
	strb	r7, [r4, #26]
	strb	r7, [r4, #22]
	cmp	r6, #0
	bne	.L656
	movs	r6, #12
	orrs	r5, r6
	strb	r5, [r4]
	b	.L655
.L656:
	movs	r6, #3
	orrs	r5, r6
	strb	r5, [r4]
	b	.L655
.L668:
	.align	2
.L667:
	.word	1752395091
	.word	1752395092
	.size	m4aMPlayLFOSpeedSet, .-m4aMPlayLFOSpeedSet
	.align	1
	.p2align 2,,3
	.global	ply_memacc
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_memacc, %function
ply_memacc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldr	r3, [r1, #64]
	adds	r2, r3, #1
	str	r2, [r1, #64]
	adds	r4, r3, #2
	ldr	r6, [r0, #24]
	ldrb	r2, [r3]
	str	r4, [r1, #64]
	adds	r5, r3, #3
	ldrb	r4, [r3, #1]
	str	r5, [r1, #64]
	adds	r4, r6, r4
	ldrb	r7, [r3, #2]
	cmp	r2, #17
	bhi	.L669
	ldr	r5, .L703
	lsls	r2, r2, #2
	ldr	r2, [r5, r2]
	mov	pc, r2
	.section	.rodata
	.align	2
.L672:
	.word	.L689
	.word	.L688
	.word	.L687
	.word	.L686
	.word	.L685
	.word	.L684
	.word	.L683
	.word	.L682
	.word	.L681
	.word	.L680
	.word	.L679
	.word	.L678
	.word	.L677
	.word	.L676
	.word	.L675
	.word	.L674
	.word	.L673
	.word	.L671
	.text
.L677:
	ldrb	r4, [r4]
	ldrb	r2, [r6, r7]
	cmp	r4, r2
	beq	.L702
.L701:
	adds	r3, r3, #7
	str	r3, [r1, #64]
.L669:
	@ sp needed
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L673:
	ldrb	r4, [r4]
	ldrb	r2, [r6, r7]
	cmp	r4, r2
	bhi	.L701
.L702:
	ldr	r3, .L703+4
	ldr	r3, [r3, #4]
	bl	.L89
	b	.L669
.L671:
	ldrb	r4, [r4]
	ldrb	r2, [r6, r7]
	cmp	r4, r2
	bcs	.L701
	b	.L702
.L689:
	strb	r7, [r4]
	b	.L669
.L688:
	ldrb	r3, [r4]
	adds	r3, r7, r3
	strb	r3, [r4]
	b	.L669
.L687:
	ldrb	r3, [r4]
	subs	r3, r3, r7
	strb	r3, [r4]
	b	.L669
.L686:
	ldrb	r3, [r6, r7]
	strb	r3, [r4]
	b	.L669
.L685:
	ldrb	r3, [r6, r7]
	ldrb	r2, [r4]
	adds	r3, r3, r2
	strb	r3, [r4]
	b	.L669
.L684:
	ldrb	r3, [r4]
	ldrb	r2, [r6, r7]
	subs	r3, r3, r2
	strb	r3, [r4]
	b	.L669
.L683:
	ldrb	r2, [r4]
	cmp	r2, r7
	bne	.L701
	b	.L702
.L682:
	ldrb	r2, [r4]
	cmp	r2, r7
	bne	.L702
	b	.L701
.L681:
	ldrb	r2, [r4]
	cmp	r2, r7
	bls	.L701
	b	.L702
.L676:
	ldrb	r4, [r4]
	ldrb	r2, [r6, r7]
	cmp	r4, r2
	bne	.L702
	b	.L701
.L675:
	ldrb	r4, [r4]
	ldrb	r2, [r6, r7]
	cmp	r4, r2
	bls	.L701
	b	.L702
.L674:
	ldrb	r4, [r4]
	ldrb	r2, [r6, r7]
	cmp	r4, r2
	bcc	.L701
	b	.L702
.L679:
	ldrb	r2, [r4]
	cmp	r2, r7
	bhi	.L701
	b	.L702
.L678:
	ldrb	r2, [r4]
	cmp	r2, r7
	bcs	.L701
	b	.L702
.L680:
	ldrb	r2, [r4]
	cmp	r2, r7
	bcc	.L701
	b	.L702
.L704:
	.align	2
.L703:
	.word	.L672
	.word	gMPlayJumpTable
	.size	ply_memacc, .-ply_memacc
	.align	1
	.p2align 2,,3
	.global	ply_xcmd
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xcmd, %function
ply_xcmd:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, [r1, #64]
	push	{r4, lr}
	adds	r3, r2, #1
	str	r3, [r1, #64]
	@ sp needed
	ldrb	r2, [r2]
	ldr	r3, .L706
	lsls	r2, r2, #2
	ldr	r3, [r2, r3]
	bl	.L89
	pop	{r4}
	pop	{r0}
	bx	r0
.L707:
	.align	2
.L706:
	.word	gXcmdTable
	.size	ply_xcmd, .-ply_xcmd
	.align	1
	.p2align 2,,3
	.global	ply_xxx
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xxx, %function
ply_xxx:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r3, .L709
	@ sp needed
	ldr	r3, [r3]
	bl	.L89
	pop	{r4}
	pop	{r0}
	bx	r0
.L710:
	.align	2
.L709:
	.word	gMPlayJumpTable
	.size	ply_xxx, .-ply_xxx
	.align	1
	.p2align 2,,3
	.global	ply_xwave
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xwave, %function
ply_xwave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	ldrb	r2, [r3, #1]
	ldrb	r0, [r3]
	lsls	r2, r2, #8
	orrs	r2, r0
	ldrb	r0, [r3, #2]
	lsls	r0, r0, #16
	orrs	r0, r2
	ldrb	r2, [r3, #3]
	lsls	r2, r2, #24
	orrs	r2, r0
	adds	r3, r3, #4
	str	r2, [r1, #40]
	str	r3, [r1, #64]
	bx	lr
	.size	ply_xwave, .-ply_xwave
	.align	1
	.p2align 2,,3
	.global	ply_xtype
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xtype, %function
ply_xtype:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r2, [r3]
	movs	r3, #36
	strb	r2, [r1, r3]
	bx	lr
	.size	ply_xtype, .-ply_xtype
	.align	1
	.p2align 2,,3
	.global	ply_xatta
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xatta, %function
ply_xatta:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r2, [r3]
	movs	r3, #44
	strb	r2, [r1, r3]
	bx	lr
	.size	ply_xatta, .-ply_xatta
	.align	1
	.p2align 2,,3
	.global	ply_xdeca
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xdeca, %function
ply_xdeca:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r2, [r3]
	movs	r3, #45
	strb	r2, [r1, r3]
	bx	lr
	.size	ply_xdeca, .-ply_xdeca
	.align	1
	.p2align 2,,3
	.global	ply_xsust
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xsust, %function
ply_xsust:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r2, [r3]
	movs	r3, #46
	strb	r2, [r1, r3]
	bx	lr
	.size	ply_xsust, .-ply_xsust
	.align	1
	.p2align 2,,3
	.global	ply_xrele
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xrele, %function
ply_xrele:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r2, [r3]
	movs	r3, #47
	strb	r2, [r1, r3]
	bx	lr
	.size	ply_xrele, .-ply_xrele
	.align	1
	.p2align 2,,3
	.global	ply_xiecv
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xiecv, %function
ply_xiecv:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r3, [r3]
	strb	r3, [r1, #30]
	bx	lr
	.size	ply_xiecv, .-ply_xiecv
	.align	1
	.p2align 2,,3
	.global	ply_xiecl
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xiecl, %function
ply_xiecl:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r3, [r3]
	strb	r3, [r1, #31]
	bx	lr
	.size	ply_xiecl, .-ply_xiecl
	.align	1
	.p2align 2,,3
	.global	ply_xleng
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xleng, %function
ply_xleng:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r2, [r3]
	movs	r3, #38
	strb	r2, [r1, r3]
	bx	lr
	.size	ply_xleng, .-ply_xleng
	.align	1
	.p2align 2,,3
	.global	ply_xswee
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xswee, %function
ply_xswee:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	adds	r2, r3, #1
	str	r2, [r1, #64]
	ldrb	r2, [r3]
	movs	r3, #39
	strb	r2, [r1, r3]
	bx	lr
	.size	ply_xswee, .-ply_xswee
	.align	1
	.p2align 2,,3
	.global	ply_xcmd_0C
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xcmd_0C, %function
ply_xcmd_0C:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r2, [r1, #64]
	ldrb	r0, [r2, #1]
	ldrb	r4, [r2]
	ldrh	r3, [r1, #58]
	lsls	r0, r0, #8
	orrs	r0, r4
	cmp	r3, r0
	bcs	.L722
	movs	r0, #1
	adds	r3, r3, #1
	lsls	r3, r3, #16
	strb	r0, [r1, #1]
	lsrs	r3, r3, #16
	subs	r2, r2, #2
.L723:
	str	r2, [r1, #64]
	@ sp needed
	strh	r3, [r1, #58]
	pop	{r4}
	pop	{r0}
	bx	r0
.L722:
	movs	r3, #0
	adds	r2, r2, #2
	b	.L723
	.size	ply_xcmd_0C, .-ply_xcmd_0C
	.align	1
	.p2align 2,,3
	.global	ply_xcmd_0D
	.syntax unified
	.code	16
	.thumb_func
	.type	ply_xcmd_0D, %function
ply_xcmd_0D:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #64]
	@ sp needed
	ldrb	r2, [r3, #1]
	ldrb	r0, [r3]
	lsls	r2, r2, #8
	orrs	r2, r0
	ldrb	r0, [r3, #2]
	lsls	r0, r0, #16
	orrs	r0, r2
	ldrb	r2, [r3, #3]
	lsls	r2, r2, #24
	orrs	r2, r0
	adds	r3, r3, #4
	str	r2, [r1, #60]
	str	r3, [r1, #64]
	bx	lr
	.size	ply_xcmd_0D, .-ply_xcmd_0D
	.align	1
	.p2align 2,,3
	.global	DummyFunc
	.syntax unified
	.code	16
	.thumb_func
	.type	DummyFunc, %function
DummyFunc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	@ sp needed
	bx	lr
	.size	DummyFunc, .-DummyFunc
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryTone
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryTone, %function
SetPokemonCryTone:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r10
	mov	lr, fp
	mov	r6, r9
	mov	r5, r8
	push	{r5, r6, r7, lr}
	ldr	r2, .L738
	ldrb	r3, [r2]
	mov	r10, r0
	sub	sp, sp, #12
	cmp	r3, #0
	bne	.L727
	ldr	r3, [r2, #32]
	cmp	r3, #0
	beq	.L734
	ldr	r3, [r3, #44]
	cmp	r3, r2
	bne	.L734
.L727:
	movs	r1, #160
	ldr	r5, .L738+4
	ldrb	r1, [r2, r1]
	ldr	r3, [r5, #12]
	cmp	r1, #0
	beq	.L737
.L729:
	ldr	r2, [r5, #76]
	cmp	r3, r2
	sbcs	r3, r3, r3
	movs	r1, #51
	rsbs	r3, r3, #0
	subs	r2, r3, #1
	bics	r2, r1
	subs	r1, r1, #34
	mov	r9, r1
	adds	r1, r1, #7
	mov	r8, r1
	adds	r1, r1, #2
	mov	fp, r1
	ldr	r6, .L738+8
	adds	r2, r2, #52
	add	r9, r9, r2
	add	r8, r8, r2
	add	fp, fp, r2
	adds	r2, r6, r2
	lsls	r7, r3, #6
	str	r2, [sp, #4]
	adds	r7, r5, r7
.L728:
	movs	r4, #52
	muls	r4, r3
	lsls	r2, r3, #6
	adds	r5, r5, r2
	ldr	r2, .L738+12
	adds	r4, r6, r4
	str	r2, [r5, #52]
	movs	r0, r4
	movs	r2, #52
	ldr	r1, .L738+16
	bl	memcpy
	mov	r3, r10
	str	r3, [r4, #4]
	mov	r3, r9
	adds	r3, r6, r3
	str	r3, [r4, #8]
	mov	r3, r8
	adds	r3, r6, r3
	str	r3, [r4, #12]
	ldr	r3, .L738+20
	str	r3, [r5, #52]
	ldr	r2, [r5, #52]
	add	r6, r6, fp
	str	r6, [r4, #20]
	cmp	r2, r3
	bne	.L726
	movs	r0, r7
	ldr	r1, [sp, #4]
	bl	MPlayStart.part.0
.L726:
	movs	r0, r7
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
.L737:
	adds	r1, r1, #192
	ldr	r1, [r2, r1]
	cmp	r1, #0
	beq	.L736
	ldr	r1, [r1, #44]
	adds	r2, r2, #160
	cmp	r1, r2
	beq	.L729
.L736:
	movs	r3, #78
	movs	r7, r5
	ldr	r2, .L738+24
	mov	fp, r3
	subs	r3, r3, #2
	mov	r8, r3
	str	r2, [sp, #4]
	subs	r3, r3, #7
	subs	r2, r2, #52
	mov	r9, r3
	movs	r6, r2
	adds	r7, r7, #64
	subs	r3, r3, #68
	b	.L728
.L734:
	movs	r3, #26
	ldr	r5, .L738+4
	mov	fp, r3
	ldr	r6, .L738+8
	subs	r3, r3, #2
	mov	r8, r3
	subs	r3, r3, #7
	mov	r9, r3
	movs	r7, r5
	movs	r3, #0
	str	r6, [sp, #4]
	b	.L728
.L739:
	.align	2
.L738:
	.word	gPokemonCryTracks
	.word	gPokemonCryMusicPlayers
	.word	gPokemonCrySongs
	.word	1752395092
	.word	gPokemonCrySong
	.word	1752395091
	.word	gPokemonCrySongs+52
	.size	SetPokemonCryTone, .-SetPokemonCryTone
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryVolume
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryVolume, %function
SetPokemonCryVolume:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, #127
	@ sp needed
	ldr	r3, .L741
	ands	r2, r0
	strb	r2, [r3, #29]
	bx	lr
.L742:
	.align	2
.L741:
	.word	gPokemonCrySong
	.size	SetPokemonCryVolume, .-SetPokemonCryVolume
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryPanpot
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryPanpot, %function
SetPokemonCryPanpot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, r0
	@ sp needed
	movs	r0, #127
	adds	r2, r2, #64
	ands	r0, r2
	movs	r2, #40
	ldr	r3, .L744
	strb	r0, [r3, r2]
	bx	lr
.L745:
	.align	2
.L744:
	.word	gPokemonCrySong
	.size	SetPokemonCryPanpot, .-SetPokemonCryPanpot
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryPitch
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryPitch, %function
SetPokemonCryPitch:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	ldr	r2, .L747
	@ sp needed
	ldrb	r1, [r2, #18]
	ldrb	r3, [r2, #25]
	subs	r3, r3, r1
	movs	r1, #127
	movs	r5, #42
	adds	r0, r0, #128
	lsls	r0, r0, #16
	asrs	r0, r0, #16
	asrs	r4, r0, #8
	ands	r4, r1
	strb	r4, [r2, r5]
	movs	r4, r1
	lsls	r3, r3, #24
	lsls	r0, r0, #23
	lsrs	r3, r3, #24
	lsrs	r0, r0, #24
	ands	r4, r0
	adds	r0, r0, r3
	ands	r1, r0
	strb	r4, [r2, #18]
	strb	r1, [r2, #25]
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L748:
	.align	2
.L747:
	.word	gPokemonCrySong
	.size	SetPokemonCryPitch, .-SetPokemonCryPitch
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryLength
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryLength, %function
SetPokemonCryLength:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L750
	@ sp needed
	strh	r0, [r3, #46]
	bx	lr
.L751:
	.align	2
.L750:
	.word	gPokemonCrySong
	.size	SetPokemonCryLength, .-SetPokemonCryLength
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryRelease
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryRelease, %function
SetPokemonCryRelease:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, #38
	@ sp needed
	ldr	r3, .L753
	strb	r0, [r3, r2]
	bx	lr
.L754:
	.align	2
.L753:
	.word	gPokemonCrySong
	.size	SetPokemonCryRelease, .-SetPokemonCryRelease
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryProgress
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryProgress, %function
SetPokemonCryProgress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L756
	@ sp needed
	str	r0, [r3, #32]
	bx	lr
.L757:
	.align	2
.L756:
	.word	gPokemonCrySong
	.size	SetPokemonCryProgress, .-SetPokemonCryProgress
	.align	1
	.p2align 2,,3
	.global	IsPokemonCryPlaying
	.syntax unified
	.code	16
	.thumb_func
	.type	IsPokemonCryPlaying, %function
IsPokemonCryPlaying:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #44]
	ldr	r2, [r3, #32]
	cmp	r2, #0
	beq	.L760
	ldr	r0, [r2, #44]
	subs	r0, r0, r3
	rsbs	r3, r0, #0
	adcs	r0, r0, r3
.L758:
	@ sp needed
	bx	lr
.L760:
	movs	r0, #0
	b	.L758
	.size	IsPokemonCryPlaying, .-IsPokemonCryPlaying
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryChorus
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryChorus, %function
SetPokemonCryChorus:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	beq	.L763
	movs	r2, #127
	ldr	r3, .L764
	ldrb	r1, [r3, #18]
	adds	r1, r1, r0
	ands	r2, r1
	strb	r2, [r3, #25]
	movs	r2, #2
.L762:
	@ sp needed
	strb	r2, [r3]
	bx	lr
.L763:
	movs	r2, #1
	ldr	r3, .L764
	b	.L762
.L765:
	.align	2
.L764:
	.word	gPokemonCrySong
	.size	SetPokemonCryChorus, .-SetPokemonCryChorus
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryStereo
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryStereo, %function
SetPokemonCryStereo:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L769
	ldr	r2, [r3]
	ldr	r3, .L769+4
	cmp	r0, #0
	beq	.L767
	ldr	r1, .L769+8
	strh	r1, [r3]
	movs	r1, #1
	ldrb	r3, [r2, #9]
	bics	r3, r1
.L768:
	strb	r3, [r2, #9]
	@ sp needed
	bx	lr
.L767:
	ldr	r1, .L769+12
	strh	r1, [r3]
	movs	r1, #1
	ldrb	r3, [r2, #9]
	orrs	r3, r1
	b	.L768
.L770:
	.align	2
.L769:
	.word	50364400
	.word	67108994
	.word	8462
	.word	13058
	.size	SetPokemonCryStereo, .-SetPokemonCryStereo
	.align	1
	.p2align 2,,3
	.global	SetPokemonCryPriority
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPokemonCryPriority, %function
SetPokemonCryPriority:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L772
	@ sp needed
	strb	r0, [r3, #2]
	bx	lr
.L773:
	.align	2
.L772:
	.word	gPokemonCrySong
	.size	SetPokemonCryPriority, .-SetPokemonCryPriority
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	MPlayStart.part.0, %function
MPlayStart.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r7, r9
	mov	r6, r8
	mov	lr, r10
	ldr	r3, .L802
	push	{r6, r7, lr}
	movs	r6, r0
	movs	r7, r1
	str	r3, [r0, #52]
	ldrb	r3, [r0, #11]
	cmp	r3, #0
	bne	.L775
	ldrb	r2, [r1, #2]
.L776:
	ldr	r1, [r7, #4]
	str	r1, [r6, #48]
	movs	r1, #8
	strb	r2, [r6, #9]
	ldr	r2, .L802+4
	str	r2, [r6, #28]
	movs	r2, #150
	mov	r8, r1
	adds	r1, r1, #184
	movs	r3, #0
	mov	r10, r1
	movs	r1, #0
	str	r2, [r6, #32]
	ldrb	r2, [r7]
	str	r3, [r6, #4]
	str	r3, [r6, #12]
	strh	r3, [r6, #36]
	movs	r5, #0
	mov	r9, r1
	str	r7, [r6]
	ldr	r4, [r6, #44]
	ldrb	r3, [r6, #8]
	add	r8, r8, r7
	cmp	r2, #0
	bne	.L782
	b	.L781
.L786:
	movs	r1, r4
	movs	r0, r6
	bl	TrackStop
	mov	r3, r10
	mov	r2, r8
	strb	r3, [r4]
	mov	r3, r9
	str	r3, [r4, #32]
	ldmia	r2!, {r3}
	str	r3, [r4, #64]
	ldrb	r3, [r7]
	adds	r5, r5, #1
	mov	r8, r2
	adds	r4, r4, #80
	cmp	r5, r3
	bcs	.L799
	ldrb	r3, [r6, #8]
.L782:
	cmp	r3, r5
	bhi	.L786
.L787:
	ldrb	r3, [r7, #3]
	lsls	r2, r3, #24
	bmi	.L801
.L779:
	@ sp needed
	ldr	r3, .L802+8
	str	r3, [r6, #52]
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L799:
	ldrb	r3, [r6, #8]
.L781:
	movs	r2, #0
	mov	r8, r2
	cmp	r3, r5
	bls	.L787
.L783:
	movs	r1, r4
	movs	r0, r6
	bl	TrackStop
	mov	r3, r8
	strb	r3, [r4]
	ldrb	r3, [r6, #8]
	adds	r5, r5, #1
	adds	r4, r4, #80
	cmp	r5, r3
	bcc	.L783
	ldrb	r3, [r7, #3]
	lsls	r2, r3, #24
	bpl	.L779
.L801:
	ldr	r2, .L802+12
	ldr	r2, [r2]
	ldr	r0, .L802+8
	ldr	r1, [r2]
	cmp	r1, r0
	bne	.L779
	ldr	r0, .L802
	str	r0, [r2]
	movs	r0, #127
	ands	r3, r0
	strb	r3, [r2, #5]
	str	r1, [r2]
	b	.L779
.L775:
	ldr	r3, [r0]
	cmp	r3, #0
	beq	.L777
	ldr	r3, [r0, #44]
	ldrb	r3, [r3]
	lsls	r3, r3, #25
	bpl	.L777
	ldrb	r3, [r1, #2]
.L778:
	movs	r2, r3
	ldrb	r3, [r6, #9]
	cmp	r3, r2
	bhi	.L779
	b	.L776
.L777:
	ldr	r1, [r6, #4]
	ldrb	r3, [r7, #2]
	lsls	r0, r1, #16
	movs	r2, r3
	cmp	r0, #0
	beq	.L776
	cmp	r1, #0
	bge	.L778
	b	.L776
.L803:
	.align	2
.L802:
	.word	1752395092
	.word	16777366
	.word	1752395091
	.word	50364400
	.size	MPlayStart.part.0, .-MPlayStart.part.0
	.section	.rodata
	.align	2
	.type	CSWTCH.49, %object
	.size	CSWTCH.49, 12
CSWTCH.49:
	.word	67108960
	.word	67108961
	.word	67108976
	.align	2
	.type	CSWTCH.50, %object
	.size	CSWTCH.50, 12
CSWTCH.50:
	.word	67108962
	.word	67108968
	.word	67108978
	.align	2
	.type	CSWTCH.51, %object
	.size	CSWTCH.51, 12
CSWTCH.51:
	.word	67108963
	.word	67108969
	.word	67108979
	.ident	"GCC: (devkitARM release 62) 13.2.0"
	.text
	.code 16
	.align	1
.L89:
	bx	r3
.text
	.align	2, 0

