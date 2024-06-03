	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"sound.c"
	.text
	.align	2
	.global	setupSounds
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	setupSounds, %function
setupSounds:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	mov	r0, #128
	mov	r1, #0
	ldr	r2, .L3
	strh	r0, [r3, #132]	@ movhi
	strh	r1, [r3, #128]	@ movhi
	strh	r2, [r3, #130]	@ movhi
	bx	lr
.L4:
	.align	2
.L3:
	.word	-1266
	.size	setupSounds, .-setupSounds
	.global	__aeabi_i2d
	.global	__aeabi_dmul
	.global	__aeabi_ddiv
	.global	__aeabi_d2iz
	.align	2
	.global	playSoundA
	.syntax unified
	.arm
	.fpu softvfp
	.type	playSoundA, %function
playSoundA:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r6, #0
	mov	r9, r2
	add	r2, r3, r3, lsl #2
	add	r2, r2, r2, lsl #2
	mov	r8, r1
	rsb	r2, r2, r2, lsl #3
	ldr	r1, .L7+8
	rsb	r2, r2, r2, lsl #6
	mov	r4, r3
	smull	r3, r1, r2, r1
	ldr	r3, .L7+12
	add	r1, r1, r2
	ldr	r3, [r3]
	asr	r2, r2, #31
	rsb	r1, r2, r1, asr #5
	mov	r5, r0
	str	r6, [r3, #20]
	add	r1, r0, r1
	mov	r3, #910163968
	mov	r0, #1
	ldr	r2, .L7+16
	ldr	r7, .L7+20
	mov	lr, pc
	bx	r7
	mov	ip, #128
	mvn	r2, #1520
	mov	r1, #1
	ldr	r7, .L7+24
	ldr	r3, .L7+28
	sub	r8, r8, #11008
	sub	r8, r8, #17
	strh	r6, [r3, #2]	@ movhi
	mov	r0, r8
	strh	r2, [r3]	@ movhi
	strh	ip, [r3, #2]	@ movhi
	ldr	r2, .L7+32
	str	r5, [r7]
	str	r9, [r7, #16]
	str	r8, [r7, #4]
	str	r1, [r7, #12]
	mov	lr, pc
	bx	r2
	ldr	r5, .L7+36
	adr	r3, .L7
	ldmia	r3, {r2-r3}
	mov	lr, pc
	bx	r5
	mov	r2, #0
	ldr	r5, .L7+40
	ldr	r3, .L7+44
	mov	lr, pc
	bx	r5
	ldr	r3, .L7+48
	mov	lr, pc
	bx	r3
	str	r4, [r7, #28]
	str	r0, [r7, #20]
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L8:
	.align	3
.L7:
	.word	1443109011
	.word	1078844686
	.word	-2004318071
	.word	dma
	.word	67109024
	.word	DMANow
	.word	soundA
	.word	67109120
	.word	__aeabi_i2d
	.word	__aeabi_dmul
	.word	__aeabi_ddiv
	.word	1086687360
	.word	__aeabi_d2iz
	.size	playSoundA, .-playSoundA
	.align	2
	.global	playSoundB
	.syntax unified
	.arm
	.fpu softvfp
	.type	playSoundB, %function
playSoundB:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r7, #0
	ldr	r3, .L11+8
	ldr	r3, [r3]
	mov	r5, r1
	mov	r6, r0
	mov	r8, r2
	mov	r1, r0
	str	r7, [r3, #32]
	mov	r0, #2
	mov	r3, #910163968
	ldr	r2, .L11+12
	ldr	r4, .L11+16
	mov	lr, pc
	bx	r4
	mov	r2, #1
	mvn	r0, #1520
	mov	r1, #128
	ldr	r4, .L11+20
	ldr	r3, .L11+24
	sub	r5, r5, #440
	sub	r5, r5, #1
	strh	r7, [r3, #6]	@ movhi
	strh	r0, [r3, #4]	@ movhi
	strh	r1, [r3, #6]	@ movhi
	mov	r0, r5
	str	r5, [r4, #4]
	str	r2, [r4, #12]
	ldr	r3, .L11+28
	str	r6, [r4]
	str	r8, [r4, #16]
	mov	lr, pc
	bx	r3
	ldr	r5, .L11+32
	adr	r3, .L11
	ldmia	r3, {r2-r3}
	mov	lr, pc
	bx	r5
	mov	r2, #0
	ldr	r5, .L11+36
	ldr	r3, .L11+40
	mov	lr, pc
	bx	r5
	ldr	r3, .L11+44
	mov	lr, pc
	bx	r3
	str	r7, [r4, #28]
	str	r0, [r4, #20]
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L12:
	.align	3
.L11:
	.word	1443109011
	.word	1078844686
	.word	dma
	.word	67109028
	.word	DMANow
	.word	soundB
	.word	67109120
	.word	__aeabi_i2d
	.word	__aeabi_dmul
	.word	__aeabi_ddiv
	.word	1086687360
	.word	__aeabi_d2iz
	.size	playSoundB, .-playSoundB
	.align	2
	.global	setupSoundInterrupts
	.syntax unified
	.arm
	.fpu softvfp
	.type	setupSoundInterrupts, %function
setupSoundInterrupts:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r0, #67108864
	mov	ip, #1
	ldr	r3, .L14
	ldrh	r1, [r0, #4]
	ldrh	r2, [r3]
	orr	r1, r1, #8
	orr	r2, r2, ip
	strh	r1, [r0, #4]	@ movhi
	strh	r2, [r3]	@ movhi
	strh	ip, [r3, #8]	@ movhi
	bx	lr
.L15:
	.align	2
.L14:
	.word	67109376
	.size	setupSoundInterrupts, .-setupSoundInterrupts
	.align	2
	.global	soundInterruptHandler
	.syntax unified
	.arm
	.fpu softvfp
	.type	soundInterruptHandler, %function
soundInterruptHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L35
	ldrh	r3, [r3, #2]
	tst	r3, #1
	bxeq	lr
	ldr	r0, .L35+4
	ldr	r3, [r0, #12]
	cmp	r3, #0
	push	{r4, lr}
	beq	.L19
	ldr	r3, [r0, #28]
	ldr	r2, [r0, #20]
	add	r3, r3, #1
	cmp	r3, r2
	str	r3, [r0, #28]
	ble	.L19
	ldr	r2, [r0, #16]
	cmp	r2, #0
	bne	.L33
	ldr	r1, .L35+8
	ldr	r3, .L35+12
	ldr	r1, [r1]
	str	r2, [r0, #12]
	str	r2, [r1, #20]
	strh	r2, [r3, #2]	@ movhi
.L19:
	ldr	r3, .L35+16
	ldr	r2, [r3, #12]
	cmp	r2, #0
	beq	.L23
	ldr	r2, [r3, #28]
	ldr	r1, [r3, #20]
	add	r2, r2, #1
	cmp	r2, r1
	str	r2, [r3, #28]
	ble	.L23
	ldr	r2, [r3, #16]
	cmp	r2, #0
	bne	.L34
	ldr	r0, .L35+8
	ldr	r1, .L35+12
	ldr	r0, [r0]
	str	r2, [r3, #12]
	str	r2, [r0, #32]
	strh	r2, [r1, #6]	@ movhi
.L23:
	mov	r2, #1
	ldr	r3, .L35
	pop	{r4, lr}
	strh	r2, [r3, #2]	@ movhi
	bx	lr
.L33:
	mov	r3, #0
	ldm	r0, {r0, r1}
	bl	playSoundA
	b	.L19
.L34:
	ldm	r3, {r0, r1}
	bl	playSoundB
	b	.L23
.L36:
	.align	2
.L35:
	.word	67109376
	.word	soundA
	.word	dma
	.word	67109120
	.word	soundB
	.size	soundInterruptHandler, .-soundInterruptHandler
	.align	2
	.global	pauseSound
	.syntax unified
	.arm
	.fpu softvfp
	.type	pauseSound, %function
pauseSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #0
	ldr	r2, .L38
	ldr	r0, .L38+4
	ldr	r1, .L38+8
	str	r3, [r0, #12]
	str	r3, [r1, #12]
	strh	r3, [r2, #2]	@ movhi
	strh	r3, [r2, #6]	@ movhi
	bx	lr
.L39:
	.align	2
.L38:
	.word	67109120
	.word	soundA
	.word	soundB
	.size	pauseSound, .-pauseSound
	.align	2
	.global	unpauseSound
	.syntax unified
	.arm
	.fpu softvfp
	.type	unpauseSound, %function
unpauseSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #128
	mov	r3, #1
	ldr	r2, .L41
	ldr	ip, .L41+4
	ldr	r0, .L41+8
	strh	r1, [r2, #2]	@ movhi
	str	r3, [ip, #12]
	strh	r1, [r2, #6]	@ movhi
	str	r3, [r0, #12]
	bx	lr
.L42:
	.align	2
.L41:
	.word	67109120
	.word	soundA
	.word	soundB
	.size	unpauseSound, .-unpauseSound
	.align	2
	.global	stopSound
	.syntax unified
	.arm
	.fpu softvfp
	.type	stopSound, %function
stopSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #0
	ldr	r2, .L44
	ldr	ip, .L44+4
	strh	r3, [r2, #2]	@ movhi
	ldr	r0, .L44+8
	strh	r3, [r2, #6]	@ movhi
	ldr	r1, .L44+12
	ldr	r2, [ip]
	str	r3, [r0, #12]
	str	r3, [r2, #20]
	str	r3, [r1, #12]
	str	r3, [r2, #32]
	bx	lr
.L45:
	.align	2
.L44:
	.word	67109120
	.word	dma
	.word	soundA
	.word	soundB
	.size	stopSound, .-stopSound
	.comm	soundB,32,4
	.comm	soundA,32,4
	.ident	"GCC: (devkitARM release 53) 9.1.0"
