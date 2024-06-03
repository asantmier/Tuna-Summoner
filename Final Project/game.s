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
	.file	"game.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"BUDDY\000"
	.text
	.align	2
	.global	initParty
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	initParty, %function
initParty:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r5, .L4
	ldr	r4, .L4+4
	mov	lr, r5
	mov	ip, r4
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [r4, #16]
	ldm	lr, {r0, r1}
	add	lr, r5, #56
	stm	ip, {r0, r1}
	str	r3, [r4, #20]
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, r4, #56
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldm	lr, {r0, r1}
	ldr	lr, [r4, #72]
	stm	ip, {r0, r1}
	str	lr, [r4, #76]
	mov	r2, #10
	ldr	r1, .L4+8
	ldr	r3, .L4+12
	add	r0, r4, #56
	mov	lr, pc
	bx	r3
	add	lr, r5, #112
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, r4, #112
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldm	lr, {r0, r1}
	add	lr, r5, #112
	stm	ip, {r0, r1}
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, r4, #168
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldm	lr, {r0, r1}
	pop	{r4, r5, r6, lr}
	stm	ip, {r0, r1}
	bx	lr
.L5:
	.align	2
.L4:
	.word	.LANCHOR0
	.word	battleAllies
	.word	.LC0
	.word	strncpy
	.size	initParty, .-initParty
	.align	2
	.global	initGame
	.syntax unified
	.arm
	.fpu softvfp
	.type	initGame, %function
initGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r2, #0
	mov	r3, #100
	str	lr, [sp, #-4]!
	ldr	lr, .L8
	ldr	ip, .L8+4
	ldr	r0, .L8+8
	ldr	r1, .L8+12
	str	r2, [lr]
	ldr	lr, [sp], #4
	str	r2, [ip]
	str	r3, [r0]
	str	r3, [r1]
	b	initParty
.L9:
	.align	2
.L8:
	.word	.LANCHOR1
	.word	gameVictory
	.word	submarineMaxHp
	.word	submarineHp
	.size	initGame, .-initGame
	.global	__aeabi_idiv
	.align	2
	.global	tilesRed
	.syntax unified
	.arm
	.fpu softvfp
	.type	tilesRed, %function
tilesRed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mul	r4, r2, r0
	mov	r5, r1
	mov	r0, r4
	mov	r1, r3
	ldr	r8, .L17
	mov	r6, r2
	mov	r7, r3
	mov	lr, pc
	bx	r8
	cmp	r0, r5
	movge	r0, #0
	bge	.L10
	add	r4, r4, r6
	mov	r0, r4
	mov	r1, r7
	mov	lr, pc
	bx	r8
	cmp	r0, r5
	movge	r0, #1
	bge	.L10
	add	r4, r4, r6
	mov	r0, r4
	mov	r1, r7
	mov	lr, pc
	bx	r8
	cmp	r0, r5
	movge	r0, #2
	bge	.L10
	mov	r1, r7
	add	r0, r4, r6
	mov	lr, pc
	bx	r8
	cmp	r0, r5
	movlt	r0, #4
	movge	r0, #3
.L10:
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L18:
	.align	2
.L17:
	.word	__aeabi_idiv
	.size	tilesRed, .-tilesRed
	.global	cheater
	.comm	battleOpponents,224,4
	.comm	battleAllies,224,4
	.global	CBT_NONE
	.global	CBT_SUBMARINE
	.global	CBT_GOD
	.global	CBT_BARRACUDA
	.global	CBT_PUFFER
	.global	CBT_ANGLER
	.global	CBT_SHARK
	.global	CBT_FISH
	.comm	gameVictory,4,4
	.comm	submarineHp,4,4
	.comm	submarineMaxHp,4,4
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	CBT_SUBMARINE, %object
	.size	CBT_SUBMARINE, 56
CBT_SUBMARINE:
	.ascii	"SUBMARINE\000"
	.space	2
	.word	1
	.word	20
	.word	20
	.word	3
	.word	MOVE_TORPEDO1
	.word	MOVE_SHIELD1
	.word	MOVE_BLAST1
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	512
	.type	CBT_FISH, %object
	.size	CBT_FISH, 56
CBT_FISH:
	.ascii	"FISH\000"
	.space	5
	.space	2
	.word	1
	.word	10
	.word	10
	.word	3
	.word	MOVE_NIBBLE
	.word	MOVE_FLAIL
	.word	MOVE_REGEN
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	576
	.type	CBT_NONE, %object
	.size	CBT_NONE, 56
CBT_NONE:
	.ascii	"NONE\000"
	.space	5
	.space	2
	.word	0
	.word	0
	.word	0
	.word	0
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	512
	.type	CBT_GOD, %object
	.size	CBT_GOD, 56
CBT_GOD:
	.ascii	"TUNA GOD\000"
	.space	1
	.space	2
	.word	1
	.word	60
	.word	60
	.word	6
	.word	MOVE_BITE
	.word	MOVE_SLASH
	.word	MOVE_RESOLVE
	.word	MOVE_LHEALBURST
	.word	MOVE_WAVE
	.word	MOVE_TRANSCEND
	.word	848
	.type	CBT_BARRACUDA, %object
	.size	CBT_BARRACUDA, 56
CBT_BARRACUDA:
	.ascii	"BARRACUDA\000"
	.space	2
	.word	1
	.word	14
	.word	14
	.word	2
	.word	MOVE_BITE
	.word	MOVE_DASH
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	640
	.type	CBT_PUFFER, %object
	.size	CBT_PUFFER, 56
CBT_PUFFER:
	.ascii	"PUFFER\000"
	.space	3
	.space	2
	.word	1
	.word	28
	.word	28
	.word	3
	.word	MOVE_NIBBLE
	.word	MOVE_PUFFUP
	.word	MOVE_SHEALBURST
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	712
	.type	CBT_ANGLER, %object
	.size	CBT_ANGLER, 56
CBT_ANGLER:
	.ascii	"ANGLER\000"
	.space	3
	.space	2
	.word	1
	.word	24
	.word	24
	.word	3
	.word	MOVE_BITE
	.word	MOVE_LHEAL
	.word	MOVE_LHEALBURST
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	648
	.type	CBT_SHARK, %object
	.size	CBT_SHARK, 56
CBT_SHARK:
	.ascii	"SHARK\000"
	.space	4
	.space	2
	.word	1
	.word	16
	.word	16
	.word	2
	.word	MOVE_STRIKE
	.word	MOVE_SHEAL
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	MOVE_NONE
	.word	704
	.bss
	.align	2
	.set	.LANCHOR1,. + 0
	.type	cheater, %object
	.size	cheater, 4
cheater:
	.space	4
	.ident	"GCC: (devkitARM release 53) 9.1.0"
