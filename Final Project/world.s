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
	.file	"world.c"
	.text
	.align	2
	.global	returnFromBattle
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	returnFromBattle, %function
returnFromBattle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #0
	ldr	r3, .L3
	ldr	r3, [r3]
	ldr	r2, .L3+4
	add	r0, r3, r3, lsl #2
	add	r3, r3, r0, lsl #1
	ldr	r0, .L3+8
	add	r3, r2, r3, lsl #2
	str	r1, [r3, #32]
	str	r1, [r0]
	bx	lr
.L4:
	.align	2
.L3:
	.word	opponentIdx
	.word	enemies
	.word	.LANCHOR0
	.size	returnFromBattle, .-returnFromBattle
	.align	2
	.global	initPlayer
	.syntax unified
	.arm
	.fpu softvfp
	.type	initPlayer, %function
initPlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r2, #0
	mov	r6, #8192
	mov	r5, #2048
	mov	r4, #128
	mov	lr, #32
	mov	ip, #16
	mov	r0, #8
	mov	r1, #1
	ldr	r3, .L7
	str	r6, [r3]
	str	r5, [r3, #4]
	str	r4, [r3, #8]
	str	lr, [r3, #12]
	str	ip, [r3, #24]
	str	r0, [r3, #28]
	str	r1, [r3, #32]
	str	r2, [r3, #16]
	str	r2, [r3, #20]
	pop	{r4, r5, r6, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	player
	.size	initPlayer, .-initPlayer
	.align	2
	.global	initBullets
	.syntax unified
	.arm
	.fpu softvfp
	.type	initBullets, %function
initBullets:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #0
	mov	ip, #2
	mov	r2, r1
	mov	r0, #1
	ldr	r3, .L13
.L10:
	add	r1, r1, #1
	cmp	r1, #5
	str	r1, [r3, #36]
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	str	r2, [r3, #16]
	str	r2, [r3, #20]
	str	ip, [r3, #24]
	str	r0, [r3, #28]
	str	r2, [r3, #32]
	add	r3, r3, #40
	bne	.L10
	bx	lr
.L14:
	.align	2
.L13:
	.word	bullets
	.size	initBullets, .-initBullets
	.align	2
	.global	initEnemies
	.syntax unified
	.arm
	.fpu softvfp
	.type	initEnemies, %function
initEnemies:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L19
	ldr	r3, [r3, #4]
	ldr	ip, .L19+4
	add	r1, r3, r3, lsl #5
	ldr	r0, .L19+8
	add	r1, r3, r1, lsl #1
	ldr	r2, .L19+12
	ldr	r3, .L19+16
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	r1, r1, r1, lsl #2
	ldr	fp, [ip]
	ldr	r10, [r0]
	add	r2, r2, r1, lsl #4
	add	r9, r3, #2640
.L16:
	ldr	r1, [r2]
	ldr	r0, [r2, #4]
	add	r4, r2, #32
	str	r1, [r3]
	ldr	r8, [r2, #16]
	ldr	r7, [r2, #20]
	ldr	r6, [r2, #24]
	ldr	r5, [r2, #28]
	ldm	r4, {r4, lr}
	ldr	ip, [r2, #40]
	rsb	r1, fp, r1, asr #6
	str	r1, [r3, #8]
	rsb	r1, r10, r0, asr #6
	str	r0, [r3, #4]
	str	r1, [r3, #12]
	str	r8, [r3, #16]
	str	r7, [r3, #20]
	str	r6, [r3, #24]
	str	r5, [r3, #28]
	str	r4, [r3, #32]
	str	lr, [r3, #36]
	str	ip, [r3, #40]
	add	r3, r3, #44
	cmp	r3, r9
	add	r2, r2, #44
	bne	.L16
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L20:
	.align	2
.L19:
	.word	.LANCHOR0
	.word	bg2xOff
	.word	bg2yOff
	.word	levels
	.word	enemies
	.size	initEnemies, .-initEnemies
	.align	2
	.global	initMines
	.syntax unified
	.arm
	.fpu softvfp
	.type	initMines, %function
initMines:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, #8
	ldr	r3, .L25
	ldr	r3, [r3, #4]
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	r1, r3, r3, lsl #5
	ldr	lr, .L25+4
	ldr	r0, .L25+8
	add	r1, r3, r1, lsl #1
	ldr	r2, .L25+12
	ldr	r3, .L25+16
	add	r1, r1, r1, lsl #2
	ldr	r10, [lr]
	ldr	r9, [r0]
	add	r2, r2, r1, lsl #4
	add	fp, r3, #2400
.L22:
	add	r0, r2, #2640
	ldm	r0, {r0, r1}
	add	r4, r2, #2672
	ldr	r6, [r2, #2656]
	ldr	r5, [r2, #2660]
	ldm	r4, {r4, lr}
	rsb	r8, r10, r0, asr #6
	rsb	r7, r9, r1, asr #6
	str	ip, [r3, #24]
	str	ip, [r3, #28]
	str	r7, [r3, #12]
	str	r6, [r3, #16]
	str	r5, [r3, #20]
	str	r4, [r3, #32]
	str	lr, [r3, #36]
	stm	r3, {r0, r1, r8}
	add	r3, r3, #40
	cmp	r3, fp
	add	r2, r2, #40
	bne	.L22
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L26:
	.align	2
.L25:
	.word	.LANCHOR0
	.word	bg2xOff
	.word	bg2yOff
	.word	levels
	.word	mines
	.size	initMines, .-initMines
	.align	2
	.global	initPickups
	.syntax unified
	.arm
	.fpu softvfp
	.type	initPickups, %function
initPickups:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, #8
	ldr	r3, .L31
	ldr	r2, [r3, #4]
	push	{r4, r5, r6, r7, r8, r9, lr}
	add	r1, r2, r2, lsl #5
	ldr	lr, .L31+4
	ldr	r0, .L31+8
	add	r1, r2, r1, lsl #1
	ldr	r3, .L31+12
	ldr	r2, .L31+16
	add	r1, r1, r1, lsl #2
	ldr	r9, [lr]
	ldr	r8, [r0]
	add	r2, r2, r1, lsl #4
	add	r7, r3, #320
.L28:
	ldm	r2, {r0, r1}
	add	r4, r2, #24
	ldm	r4, {r4, lr}
	rsb	r6, r9, r0, asr #6
	rsb	r5, r8, r1, asr #6
	str	ip, [r3, #16]
	str	ip, [r3, #20]
	str	r5, [r3, #12]
	str	r4, [r3, #24]
	str	lr, [r3, #28]
	stm	r3, {r0, r1, r6}
	add	r3, r3, #32
	cmp	r3, r7
	add	r2, r2, #32
	bne	.L28
	pop	{r4, r5, r6, r7, r8, r9, lr}
	bx	lr
.L32:
	.align	2
.L31:
	.word	.LANCHOR0
	.word	bg2xOff
	.word	bg2yOff
	.word	pickups
	.word	levels+5040
	.size	initPickups, .-initPickups
	.align	2
	.global	initWorld
	.syntax unified
	.arm
	.fpu softvfp
	.type	initWorld, %function
initWorld:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	lr, #0
	mov	r4, #1
	mov	r10, #8192
	mov	r9, #2048
	mov	r8, #128
	mov	r7, #32
	mov	r6, #16
	mov	r5, #8
	mov	r1, lr
	mov	r2, lr
	mov	ip, r4
	mov	r0, #2
	ldr	r3, .L37
	str	lr, [r3, #4]
	str	lr, [r3]
	ldr	r3, .L37+4
	str	lr, [r3, #16]
	str	lr, [r3, #20]
	str	r10, [r3]
	str	r9, [r3, #4]
	str	r8, [r3, #8]
	str	r7, [r3, #12]
	str	r6, [r3, #24]
	str	r5, [r3, #28]
	str	r4, [r3, #32]
	ldr	r3, .L37+8
.L34:
	add	r1, r1, #1
	cmp	r1, #5
	str	r1, [r3, #36]
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	str	r2, [r3, #16]
	str	r2, [r3, #20]
	str	r0, [r3, #24]
	str	ip, [r3, #28]
	str	r2, [r3, #32]
	add	r3, r3, #40
	bne	.L34
	bl	initEnemies
	bl	initMines
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	b	initPickups
.L38:
	.align	2
.L37:
	.word	.LANCHOR0
	.word	player
	.word	bullets
	.size	initWorld, .-initWorld
	.align	2
	.global	doCollision
	.syntax unified
	.arm
	.fpu softvfp
	.type	doCollision, %function
doCollision:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r6, #0
	ldr	r4, .L85
	ldr	r8, .L85+4
	ldr	r10, .L85+8
	ldr	r9, .L85+12
	sub	sp, sp, #20
	b	.L45
.L40:
	add	r6, r6, #1
	cmp	r6, #60
	add	r4, r4, #44
	beq	.L81
.L45:
	ldr	r3, [r4, #32]
	cmp	r3, #0
	beq	.L40
	ldr	r0, [r4, #28]
	ldr	r1, [r4, #24]
	ldm	r4, {ip, lr}
	add	r2, r8, #24
	ldm	r2, {r2, r3}
	lsl	r0, r0, #6
	stm	sp, {ip, lr}
	lsl	r1, r1, #6
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	lsl	r3, r3, #6
	ldm	r8, {r0, r1}
	lsl	r2, r2, #6
	mov	lr, pc
	bx	r10
	subs	r7, r0, #0
	bne	.L82
	ldr	r5, .L85+12
	ldr	r3, [r5, #32]
	cmp	r3, #0
	bne	.L83
.L43:
	add	r7, r7, #1
	cmp	r7, #5
	add	r5, r5, #40
	beq	.L40
	ldr	r3, [r5, #32]
	cmp	r3, #0
	beq	.L43
.L83:
	ldr	r0, [r4, #28]
	ldr	r1, [r4, #24]
	ldm	r4, {ip, lr}
	add	r2, r5, #24
	ldm	r2, {r2, r3}
	lsl	r0, r0, #6
	stm	sp, {ip, lr}
	lsl	r1, r1, #6
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	lsl	r3, r3, #6
	ldm	r5, {r0, r1}
	lsl	r2, r2, #6
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	beq	.L43
	mov	r2, #0
	mov	ip, #8704
	mov	r1, #1
	add	r7, r7, r7, lsl #2
	add	r7, r9, r7, lsl #3
	ldr	r3, [r7, #36]
	ldr	r0, .L85+16
	lsl	r3, r3, #3
	str	r2, [r7, #32]
	strh	ip, [r0, r3]	@ movhi
	ldr	r2, .L85+20
	ldr	r3, .L85+24
	str	r1, [r2]
	str	r6, [r3]
.L39:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L81:
	ldr	r4, .L85+28
	ldr	r5, .L85+4
	ldr	r7, .L85+8
	ldr	r8, .L85+32
	ldr	fp, .L85+36
	ldr	r10, .L85+40
	ldr	r9, .L85+44
	add	r6, r4, #2400
	b	.L49
.L47:
	add	r4, r4, #40
	cmp	r4, r6
	beq	.L84
.L49:
	ldr	r3, [r4, #32]
	cmp	r3, #0
	beq	.L47
	ldr	r0, [r4, #28]
	ldr	r1, [r4, #24]
	ldm	r4, {ip, lr}
	add	r2, r5, #24
	ldm	r2, {r2, r3}
	lsl	r0, r0, #6
	stm	sp, {ip, lr}
	lsl	r1, r1, #6
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	lsl	r3, r3, #6
	ldm	r5, {r0, r1}
	lsl	r2, r2, #6
	mov	lr, pc
	bx	r7
	cmp	r0, #0
	beq	.L47
	mov	r2, #0
	ldr	r1, [r4, #36]
	ldr	r3, [r8]
	str	r2, [r4, #32]
	sub	r3, r3, r1
	mov	r0, r10
	ldr	r1, [fp]
	add	r4, r4, #40
	str	r3, [r8]
	mov	lr, pc
	bx	r9
	cmp	r4, r6
	bne	.L49
.L84:
	ldr	r4, .L85+48
	ldr	r5, .L85+4
	ldr	r7, .L85+8
	ldr	r10, .L85+52
	ldr	r9, .L85+56
	ldr	r8, .L85+44
	ldr	fp, .L85+32
	add	r6, r4, #320
	b	.L59
.L51:
	add	r4, r4, #32
	cmp	r4, r6
	beq	.L39
.L59:
	ldr	r3, [r4, #24]
	cmp	r3, #0
	beq	.L51
	ldr	r0, [r4, #20]
	add	r2, r5, #24
	lsl	r0, r0, #6
	ldm	r2, {r2, r3}
	ldr	r1, [r4, #16]
	ldr	ip, [r4, #4]
	str	r0, [sp, #12]
	ldr	r0, [r4]
	lsl	r1, r1, #6
	stm	sp, {r0, ip}
	str	r1, [sp, #8]
	lsl	r3, r3, #6
	ldm	r5, {r0, r1}
	lsl	r2, r2, #6
	mov	lr, pc
	bx	r7
	cmp	r0, #0
	beq	.L51
	mov	r2, #0
	mov	r0, r9
	ldr	r1, [r10]
	str	r2, [r4, #24]
	mov	lr, pc
	bx	r8
	ldr	r3, [r4, #28]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L51
.L54:
	.word	.L57
	.word	.L56
	.word	.L55
	.word	.L53
.L53:
	ldr	r3, .L85+60
	ldr	r2, [r3]
	ldr	r3, .L85+64
	ldr	r1, [r3, #16]
	str	r1, [r3, #20]
	ldr	r1, [r3, #72]
	str	r1, [r3, #76]
	ldr	r1, [r3, #128]
	str	r1, [r3, #132]
	ldr	r1, [r3, #184]
	str	r1, [r3, #188]
	ldr	r3, [fp]
	add	r3, r3, #50
	cmp	r2, r3
	movge	r2, r3
	str	r2, [fp]
	b	.L51
.L55:
	ldr	r3, .L85+64
	ldr	r2, .L85+68
	str	r2, [r3, #32]
	b	.L51
.L56:
	ldr	r3, .L85+64
	ldr	r2, .L85+72
	str	r2, [r3, #36]
	b	.L51
.L57:
	ldr	r3, .L85+64
	ldr	r2, .L85+76
	str	r2, [r3, #28]
	b	.L51
.L82:
	mov	r1, #1
	ldr	r2, .L85+20
	ldr	r3, .L85+24
	str	r1, [r2]
	str	r6, [r3]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L86:
	.align	2
.L85:
	.word	enemies
	.word	player
	.word	collision
	.word	bullets
	.word	shadowOAM
	.word	.LANCHOR0
	.word	opponentIdx
	.word	mines
	.word	submarineHp
	.word	boomsfx_length
	.word	boomsfx_data
	.word	playSoundB
	.word	pickups
	.word	fanfaresfx_length
	.word	fanfaresfx_data
	.word	submarineMaxHp
	.word	battleAllies
	.word	MOVE_SHIELD2
	.word	MOVE_BLAST2
	.word	MOVE_TORPEDO2
	.size	doCollision, .-doCollision
	.align	2
	.global	movePlayer
	.syntax unified
	.arm
	.fpu softvfp
	.type	movePlayer, %function
movePlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	ldr	r4, .L130
	ldr	r8, [r4, #16]
	ldr	r3, [r4]
	add	r7, r4, #20
	adds	r2, r3, r8
	movmi	r2, #0
	ldm	r7, {r7, ip}
	sub	sp, sp, #8
	rsbmi	r8, r3, #0
	bmi	.L89
	add	r1, r2, ip, lsl #6
	cmp	r1, #65536
	subgt	r1, r1, #65536
	subgt	r8, r8, r1
	addgt	r2, r3, r8
	asr	r2, r2, #6
.L89:
	ldr	r1, [r4, #4]
	adds	r3, r1, r7
	movmi	r3, #0
	ldr	r0, [r4, #28]
	rsbmi	r7, r1, #0
	bmi	.L92
	add	lr, r1, r0, lsl #6
	cmp	lr, #65536
	lsl	lr, r0, #6
	addgt	r3, r3, lr
	subgt	r3, r3, #65536
	subgt	r7, r7, r3
	addgt	r3, r1, r7
	asr	r3, r3, #6
.L92:
	ldr	r10, .L130+4
	str	r0, [sp, #4]
	mov	r1, #1024
	str	ip, [sp]
	ldr	r0, [r10]
	ldr	r9, .L130+8
	mov	lr, pc
	bx	r9
	cmp	r0, #0
	bgt	.L124
	ldr	r3, [r4]
	eor	r6, r8, r8, asr #31
	sub	r6, r6, r8, asr #31
	add	r8, r8, r3
	ldr	r3, [r4, #4]
	add	r3, r7, r3
	eor	r5, r7, r7, asr #31
	str	r8, [r4]
	str	r3, [r4, #4]
	sub	r5, r5, r7, asr #31
.L98:
	ldr	r2, [r4, #16]
	cmp	r2, #0
	rsblt	r2, r2, #0
	cmp	r2, r6
	movgt	r2, #0
	strgt	r2, [r4, #16]
	ldr	r2, [r4, #20]
	cmp	r2, #0
	rsblt	r2, r2, #0
	cmp	r2, r5
	movgt	r2, #0
	ldr	r5, .L130+12
	ldr	r0, [r5]
	strgt	r2, [r4, #20]
	rsb	r1, r0, r8, asr #6
	cmp	r0, #0
	movgt	r2, #1
	movle	r2, #0
	cmp	r1, #78
	movgt	r2, #0
	ldr	lr, .L130+16
	ldr	ip, [lr]
	cmp	r2, #0
	rsb	r2, ip, r3, asr #6
	str	r1, [r4, #8]
	str	r2, [r4, #12]
	ldr	r6, [r4, #24]
	asr	r8, r8, #6
	asr	r3, r3, #6
	bne	.L125
.L101:
	add	r0, r1, r6
	cmp	r0, #159
	bgt	.L126
.L104:
	cmp	r2, #51
	movle	r1, #1
	movgt	r1, #0
	cmp	ip, #0
	movle	r1, #0
	cmp	r1, #0
	ldr	r1, [r4, #28]
	bne	.L127
.L107:
	add	r3, r2, r1
	cmp	r3, #105
	ble	.L87
	ldr	r0, [lr]
	cmp	r0, #864
	blt	.L109
.L87:
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L126:
	ldr	r7, [r5]
	cmp	r7, #784
	bge	.L104
.L103:
	sub	r0, r0, #159
	add	r8, r0, r7
	cmp	r8, #784
	subgt	r8, r8, #784
	subgt	r0, r0, r8
	rsble	r6, r6, #159
	addgt	r0, r0, r7
	addgt	r8, r8, r1
	strle	r6, [r4, #8]
	strle	r8, [r5]
	strgt	r0, [r5]
	strgt	r8, [r4, #8]
	b	.L104
.L127:
	rsb	r5, r2, #52
	cmp	ip, r5
	bge	.L128
	mov	r0, #0
	sub	r2, r3, r5
	add	r3, r2, r1
	cmp	r3, #105
	str	r2, [r4, #12]
	str	r0, [lr]
	ble	.L87
.L109:
	sub	r3, r3, #105
	add	ip, r3, r0
	cmp	ip, #864
	subgt	ip, ip, #864
	subgt	r3, r3, ip
	rsble	r1, r1, #105
	addgt	r3, r3, r0
	addgt	ip, ip, r2
	strle	r1, [r4, #12]
	strle	ip, [lr]
	strgt	r3, [lr]
	strgt	ip, [r4, #12]
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L124:
	add	r6, r8, r8, lsl #1
	add	r5, r7, r7, lsl #1
	add	r2, r6, #3
	cmp	r6, #0
	movlt	r6, r2
	add	r3, r5, #3
	cmp	r5, #0
	movlt	r5, r3
	ldm	r4, {r2, r3}
	ldr	r0, [r4, #28]
	ldr	r1, [r4, #24]
	add	r2, r2, r6, asr #2
	add	r3, r3, r5, asr #2
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r0, [r10]
	mov	r1, #1024
	asr	r2, r2, #6
	asr	r3, r3, #6
	mov	lr, pc
	bx	r9
	cmp	r0, #0
	asr	r6, r6, #2
	asr	r5, r5, #2
	bgt	.L129
.L95:
	ldr	r8, [r4]
	ldr	r3, [r4, #4]
	add	r8, r6, r8
	add	r3, r5, r3
	cmp	r6, #0
	bic	r8, r8, #63
	bic	r3, r3, #63
	rsblt	r6, r6, #0
	cmp	r5, #0
	str	r8, [r4]
	str	r3, [r4, #4]
	rsblt	r5, r5, #0
	b	.L98
.L125:
	rsb	r9, r1, #79
	cmp	r0, r9
	blt	.L102
	mov	r1, #79
	sub	r0, r0, r9
	str	r0, [r5]
	str	r1, [r4, #8]
	b	.L101
.L102:
	mov	r7, #0
	sub	r1, r8, r9
	add	r0, r1, r6
	cmp	r0, #159
	str	r1, [r4, #8]
	str	r7, [r5]
	bgt	.L103
	b	.L104
.L128:
	mov	r2, #52
	sub	r3, ip, r5
	str	r3, [lr]
	str	r2, [r4, #12]
	b	.L107
.L129:
	ldm	r4, {r2, r3}
	ldr	r0, [r4, #28]
	ldr	r1, [r4, #24]
	add	r5, r7, r7, lsr #31
	add	r6, r8, r8, lsr #31
	add	r3, r3, r5, asr #1
	add	r2, r2, r6, asr #1
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r0, [r10]
	mov	r1, #1024
	asr	r3, r3, #6
	asr	r2, r2, #6
	mov	lr, pc
	bx	r9
	cmp	r0, #0
	asr	r5, r5, #1
	asr	r6, r6, #1
	ble	.L95
	add	r6, r8, #3
	cmp	r8, #0
	movlt	r8, r6
	add	r3, r7, #3
	cmp	r7, #0
	movlt	r7, r3
	add	r1, r4, #24
	ldm	r4, {r2, r3}
	ldm	r1, {r1, ip}
	add	r3, r3, r7, asr #2
	add	r2, r2, r8, asr #2
	stm	sp, {r1, ip}
	ldr	r0, [r10]
	mov	r1, #1024
	asr	r2, r2, #6
	asr	r3, r3, #6
	mov	lr, pc
	bx	r9
	cmp	r0, #0
	asr	r6, r8, #2
	asr	r7, r7, #2
	ble	.L97
	mov	r5, #0
	ldr	r8, [r4]
	mov	r6, r5
	ldr	r3, [r4, #4]
	b	.L98
.L97:
	ldr	r8, [r4]
	ldr	r3, [r4, #4]
	add	r8, r6, r8
	add	r3, r7, r3
	bic	r8, r8, #63
	bic	r3, r3, #63
	cmp	r6, #0
	eor	r5, r7, r7, asr #31
	str	r8, [r4]
	str	r3, [r4, #4]
	rsblt	r6, r6, #0
	sub	r5, r5, r7, asr #31
	b	.L98
.L131:
	.align	2
.L130:
	.word	player
	.word	.LANCHOR1
	.word	collisionCheck
	.word	bg2xOff
	.word	bg2yOff
	.size	movePlayer, .-movePlayer
	.align	2
	.global	drawPlayer
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawPlayer, %function
drawPlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L143
	ldr	r3, [r1, #8]
	cmp	r3, #10
	push	{r4, lr}
	ldr	r2, [r1, #12]
	addle	r4, r3, #1
	ble	.L134
	mov	r4, #1
	add	r2, r2, r4
	rsbs	r3, r2, #0
	and	r3, r3, #3
	and	r2, r2, #3
	rsbpl	r2, r3, #0
	str	r2, [r1, #12]
.L134:
	ldr	ip, .L143+4
	ldr	r3, [ip, #8]
	ldrb	lr, [ip, #12]	@ zero_extendqisi2
	ldr	r0, .L143+8
	lsl	r3, r3, #23
	lsr	r3, r3, #23
	orr	lr, lr, #24576
	strh	r3, [r0, #2]	@ movhi
	strh	lr, [r0]	@ movhi
	cmp	r2, #3
	ldrls	pc, [pc, r2, asl #2]
	b	.L135
.L137:
	.word	.L140
	.word	.L139
	.word	.L138
	.word	.L136
.L136:
	ldr	r2, .L143+12
	strh	r2, [r0, #4]	@ movhi
.L135:
	ldr	r2, [ip, #32]
	cmp	r2, #0
	orreq	r3, r3, #4096
	strheq	r3, [r0, #2]	@ movhi
	str	r4, [r1, #8]
	pop	{r4, lr}
	bx	lr
.L140:
	mov	r2, #2944
	strh	r2, [r0, #4]	@ movhi
	b	.L135
.L139:
	ldr	r2, .L143+16
	strh	r2, [r0, #4]	@ movhi
	b	.L135
.L138:
	ldr	r2, .L143+20
	strh	r2, [r0, #4]	@ movhi
	b	.L135
.L144:
	.align	2
.L143:
	.word	.LANCHOR0
	.word	player
	.word	shadowOAM
	.word	2956
	.word	2948
	.word	2952
	.size	drawPlayer, .-drawPlayer
	.align	2
	.global	firePlayer
	.syntax unified
	.arm
	.fpu softvfp
	.type	firePlayer, %function
firePlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L154
	ldr	r3, [r0, #32]
	cmp	r3, #1
	push	{r4, r5, r6, lr}
	mov	r3, #0
	moveq	r4, #96
	mvnne	r4, #95
	ldrne	lr, .L154+4
	ldr	r2, [r0]
	ldreq	ip, [r0, #24]
	ldrne	ip, [lr, #24]
	ldreq	lr, .L154+4
	ldr	r1, .L154+4
	addeq	ip, r2, ip, lsl #6
	subne	ip, r2, ip, lsl #6
.L150:
	ldr	r2, [r1, #32]
	cmp	r2, #0
	beq	.L153
	add	r3, r3, #1
	cmp	r3, #5
	add	r1, r1, #40
	bne	.L150
	pop	{r4, r5, r6, lr}
	bx	lr
.L153:
	mov	r5, #1
	ldr	r1, [r0, #28]
	ldr	r6, [r0, #4]
	add	r1, r1, r1, lsr #31
	asr	r1, r1, r5
	add	r6, r6, r1, lsl #6
	add	r3, r3, r3, lsl #2
	ldr	r1, .L154+8
	str	ip, [lr, r3, lsl #3]
	add	r3, lr, r3, lsl #3
	asr	ip, ip, #6
	asr	lr, r6, #6
	str	r4, [r3, #16]
	str	r5, [r3, #32]
	ldr	r4, .L154+12
	str	r6, [r3, #4]
	str	lr, [r3, #12]
	ldr	r1, [r1]
	str	r2, [r3, #20]
	str	ip, [r3, #8]
	ldr	r0, .L154+16
	mov	lr, pc
	bx	r4
	pop	{r4, r5, r6, lr}
	bx	lr
.L155:
	.align	2
.L154:
	.word	player
	.word	bullets
	.word	shootsfx_length
	.word	playSoundB
	.word	shootsfx_data
	.size	firePlayer, .-firePlayer
	.align	2
	.global	updatePlayer
	.syntax unified
	.arm
	.fpu softvfp
	.type	updatePlayer, %function
updatePlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L223
	ldrh	r3, [r2, #48]
	tst	r3, #256
	push	{r4, lr}
	ldrh	r3, [r2, #48]
	beq	.L157
	ands	r3, r3, #32
	bne	.L158
	ldr	r4, .L223+4
	mvn	r2, #19
	ldr	r0, [r4, #16]
	b	.L159
.L157:
	tst	r3, #32
	bne	.L160
	mov	r3, #1
	mvn	r2, #9
	ldr	r4, .L223+4
	ldr	r0, [r4, #16]
.L159:
	ldr	r1, .L223+8
	ldr	r1, [r1]
	add	r2, r2, r0
	cmp	r1, #0
	str	r2, [r4, #16]
	beq	.L161
	ldr	r2, .L223
	ldrh	r2, [r2, #48]
	tst	r2, #512
	mvneq	r2, #191
	streq	r2, [r4, #16]
.L161:
	ldr	r0, .L223
	ldrh	r2, [r0, #48]
	tst	r2, #64
	bne	.L164
.L221:
	cmp	r3, #0
	mvnne	ip, #9
	mvneq	ip, #19
	ldr	r2, [r4, #20]
	cmp	r1, #0
	add	r2, r2, ip
	str	r2, [r4, #20]
	beq	.L174
	ldrh	r2, [r0, #48]
	tst	r2, #512
	mvneq	r2, #191
	streq	r2, [r4, #20]
.L168:
	ldr	r2, .L223
	ldrh	r2, [r2, #48]
	tst	r2, #512
	beq	.L175
.L191:
	ldr	r2, [r4, #20]
.L174:
	cmp	r3, #0
	ldr	r0, [r4, #16]
	beq	.L218
	cmp	r0, #24
	mov	r3, #24
	mvn	r1, #23
	bgt	.L188
.L189:
	cmp	r0, r1
	strlt	r1, [r4, #16]
.L178:
	cmp	r3, r2
	strlt	r3, [r4, #20]
	blt	.L175
	cmp	r1, r2
	strgt	r1, [r4, #20]
.L175:
	bl	movePlayer
	ldr	r3, [r4, #16]
	cmp	r3, #0
	movgt	r3, #1
	strgt	r3, [r4, #32]
	bgt	.L182
	movne	r3, #0
	strne	r3, [r4, #32]
.L182:
	ldr	r3, .L223+12
	ldrh	r3, [r3]
	tst	r3, #1
	beq	.L183
	ldr	r3, .L223+16
	ldrh	r3, [r3]
	tst	r3, #1
	beq	.L219
.L183:
	pop	{r4, lr}
	b	drawPlayer
.L160:
	ldrh	r3, [r2, #48]
	tst	r3, #16
	movne	r3, #1
	beq	.L220
.L186:
	ldr	r2, .L223+8
	ldr	r1, [r2]
	cmp	r1, #0
	ldr	r4, .L223+4
	beq	.L162
	ldr	r2, .L223
	ldrh	r2, [r2, #48]
	ands	r2, r2, #512
	bne	.L162
.L217:
	ldr	r0, .L223
	str	r2, [r4, #16]
	ldrh	r2, [r0, #48]
	tst	r2, #64
	beq	.L221
.L164:
	ldrh	r2, [r0, #48]
	tst	r2, #128
	bne	.L169
	cmp	r3, #0
	movne	ip, #10
	moveq	ip, #20
	ldr	r2, [r4, #20]
	cmp	r1, #0
	add	r2, r2, ip
	str	r2, [r4, #20]
	beq	.L174
	ldrh	r2, [r0, #48]
	tst	r2, #512
	moveq	r2, #192
	streq	r2, [r4, #20]
	b	.L168
.L158:
	ldrh	r3, [r2, #48]
	ands	r3, r3, #16
	movne	r3, #0
	bne	.L186
	mov	r2, #20
	ldr	r4, .L223+4
	ldr	r0, [r4, #16]
.L184:
	ldr	r1, .L223+8
	ldr	r1, [r1]
	add	r2, r2, r0
	cmp	r1, #0
	str	r2, [r4, #16]
	beq	.L161
	ldr	r2, .L223
	ldrh	r2, [r2, #48]
	tst	r2, #512
	moveq	r2, #192
	streq	r2, [r4, #16]
	b	.L161
.L218:
	cmp	r0, #48
	mov	r3, #48
	mvn	r1, #47
	ble	.L189
.L188:
	str	r3, [r4, #16]
	b	.L178
.L169:
	cmp	r1, #0
	bne	.L222
.L171:
	ldr	r2, [r4, #20]
	cmp	r2, #0
	ble	.L172
	sub	r2, r2, #1
	str	r2, [r4, #20]
.L173:
	cmp	r1, #0
	beq	.L191
	b	.L168
.L162:
	ldr	r2, [r4, #16]
	cmp	r2, #0
	ble	.L163
	sub	r2, r2, #1
	str	r2, [r4, #16]
	b	.L161
.L222:
	ldrh	r2, [r0, #48]
	ands	r2, r2, #512
	streq	r2, [r4, #20]
	beq	.L168
	b	.L171
.L220:
	ldr	r4, .L223+4
	mov	r3, #1
	mov	r2, #10
	ldr	r0, [r4, #16]
	b	.L184
.L219:
	bl	firePlayer
	pop	{r4, lr}
	b	drawPlayer
.L163:
	beq	.L161
	add	r2, r2, #1
	b	.L217
.L172:
	addne	r2, r2, #1
	strne	r2, [r4, #20]
	b	.L173
.L224:
	.align	2
.L223:
	.word	67109120
	.word	player
	.word	cheater
	.word	oldButtons
	.word	buttons
	.size	updatePlayer, .-updatePlayer
	.align	2
	.global	updateBullet
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateBullet, %function
updateBullet:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	r4, r0
	ldr	r2, [r0]
	ldr	r0, [r0, #16]
	ldr	r3, [r4, #4]
	ldr	r1, [r4, #20]
	add	r2, r2, r0
	add	r3, r3, r1
	cmp	r2, #0
	add	r1, r4, #24
	stm	r4, {r2, r3}
	ldm	r1, {r1, ip}
	sub	sp, sp, #12
	blt	.L226
	add	r0, r2, r1, lsl #6
	cmp	r0, #65536
	movle	r0, #0
	movgt	r0, #1
	orrs	r0, r0, r3, lsr #31
	beq	.L239
.L226:
	mov	r0, #0
	str	r0, [r4, #32]
.L227:
	stm	sp, {r1, ip}
	ldr	r0, .L241
	mov	r1, #1024
	ldr	r0, [r0]
	ldr	r5, .L241+4
	asr	r3, r3, #6
	asr	r2, r2, #6
	mov	lr, pc
	bx	r5
	cmp	r0, #0
	bne	.L228
	ldr	r3, .L241+8
	ldr	r2, .L241+12
	ldr	r0, [r3]
	ldr	r2, [r2]
	ldr	r3, [r4, #32]
	ldr	ip, [r4]
	ldr	r1, [r4, #4]
	rsb	r2, r2, ip, asr #6
	rsb	r0, r0, r1, asr #6
	cmp	r3, #0
	str	r2, [r4, #8]
	str	r0, [r4, #12]
	ldr	r3, [r4, #36]
	beq	.L230
	ldr	r1, [r4, #24]
	add	r1, r2, r1
	cmp	r1, #0
	movgt	r1, #1
	movle	r1, #0
	cmp	r2, #240
	movgt	r1, #0
	cmp	r1, #0
	bne	.L240
.L230:
	mov	r1, #512
	ldr	r2, .L241+16
	lsl	r3, r3, #3
	strh	r1, [r2, r3]	@ movhi
.L225:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, lr}
	bx	lr
.L228:
	mov	r1, #0
	ldr	r2, .L241+12
	ldr	r3, .L241+8
	ldr	r2, [r2]
	ldr	ip, [r4]
	ldr	r3, [r3]
	ldr	r0, [r4, #4]
	rsb	r2, r2, ip, asr #6
	rsb	r3, r3, r0, asr #6
	str	r3, [r4, #12]
	str	r2, [r4, #8]
	str	r1, [r4, #32]
	ldr	r3, [r4, #36]
	b	.L230
.L239:
	add	r0, r3, ip, lsl #6
	cmp	r0, #65536
	ble	.L227
	b	.L226
.L240:
	ldr	r1, [r4, #28]
	add	r1, r0, r1
	cmp	r1, #0
	movgt	r1, #1
	movle	r1, #0
	cmp	r0, #160
	movgt	r1, #0
	cmp	r1, #0
	beq	.L230
	mov	ip, #3040
	ldr	r1, .L241+16
	and	r0, r0, #255
	lsl	r2, r2, #23
	lsl	lr, r3, #3
	orr	r0, r0, #8192
	add	r3, r1, r3, lsl #3
	lsr	r2, r2, #23
	strh	r0, [r1, lr]	@ movhi
	strh	r2, [r3, #2]	@ movhi
	strh	ip, [r3, #4]	@ movhi
	b	.L225
.L242:
	.align	2
.L241:
	.word	.LANCHOR1
	.word	collisionCheck
	.word	bg2yOff
	.word	bg2xOff
	.word	shadowOAM
	.size	updateBullet, .-updateBullet
	.align	2
	.global	freeEnemySprites
	.syntax unified
	.arm
	.fpu softvfp
	.type	freeEnemySprites, %function
freeEnemySprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #512
	mov	r0, #0
	ldr	r3, .L244
	ldr	r1, .L244+4
	strh	r2, [r3, #48]	@ movhi
	strh	r2, [r3, #56]	@ movhi
	strh	r2, [r3, #64]	@ movhi
	strh	r2, [r3, #72]	@ movhi
	strh	r2, [r3, #80]	@ movhi
	strh	r2, [r3, #88]	@ movhi
	strh	r2, [r3, #96]	@ movhi
	strh	r2, [r3, #104]	@ movhi
	strh	r2, [r3, #112]	@ movhi
	strh	r2, [r3, #120]	@ movhi
	str	r0, [r1, #16]
	bx	lr
.L245:
	.align	2
.L244:
	.word	shadowOAM
	.word	.LANCHOR0
	.size	freeEnemySprites, .-freeEnemySprites
	.align	2
	.global	drawEnemy
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawEnemy, %function
drawEnemy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, .L276
	ldr	r2, [ip, #16]
	cmp	r2, #9
	bxgt	lr
	ldr	r3, [r0, #40]
	ldrb	r1, [r0, #12]	@ zero_extendqisi2
	cmp	r3, #5
	push	{r4, r5, r6, lr}
	orr	r5, r1, #24576
	ldr	r1, [r0, #8]
	add	r0, r2, #6
	beq	.L274
	ldr	r6, .L276+4
	ldr	lr, [ip, #20]
	lsl	r1, r1, #23
	lsl	r4, r0, #3
	lsr	r1, r1, #23
	add	r0, r6, r0, lsl #3
	cmp	lr, #1
	strh	r5, [r6, r4]	@ movhi
	strh	r1, [r0, #2]	@ movhi
	beq	.L250
	cmp	lr, #2
	beq	.L251
	cmp	lr, #0
	beq	.L275
.L249:
	add	r2, r2, #1
	str	r2, [ip, #16]
	pop	{r4, r5, r6, lr}
	bx	lr
.L275:
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L249
.L253:
	.word	.L257
	.word	.L256
	.word	.L255
	.word	.L254
	.word	.L252
.L251:
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L249
.L265:
	.word	.L269
	.word	.L268
	.word	.L267
	.word	.L266
	.word	.L264
.L250:
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L249
.L259:
	.word	.L263
	.word	.L262
	.word	.L261
	.word	.L260
	.word	.L258
.L274:
	lsl	r1, r1, #23
	lsr	r1, r1, #23
	mvn	r1, r1, lsl #17
	mov	lr, #2896
	mvn	r1, r1, lsr #17
	ldr	r3, .L276+4
	lsl	r4, r0, #3
	add	r2, r2, #1
	add	r0, r3, r0, lsl #3
	strh	r5, [r3, r4]	@ movhi
	strh	lr, [r0, #4]	@ movhi
	strh	r1, [r0, #2]	@ movhi
	pop	{r4, r5, r6, lr}
	str	r2, [ip, #16]
	bx	lr
.L258:
	ldr	r3, .L276+8
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L257:
	mov	r3, #2976
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L256:
	mov	r3, #2992
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L255:
	mov	r3, #3024
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L254:
	mov	r3, #3056
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L252:
	mov	r3, #2960
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L269:
	ldr	r3, .L276+12
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L268:
	ldr	r3, .L276+16
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L267:
	ldr	r3, .L276+20
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L266:
	ldr	r3, .L276+24
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L264:
	ldr	r3, .L276+28
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L263:
	ldr	r3, .L276+32
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L262:
	ldr	r3, .L276+36
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L261:
	ldr	r3, .L276+40
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L260:
	ldr	r3, .L276+44
	add	r4, r6, r4
	strh	r3, [r4, #4]	@ movhi
	b	.L249
.L277:
	.align	2
.L276:
	.word	.LANCHOR0
	.word	shadowOAM
	.word	2964
	.word	2984
	.word	3000
	.word	3032
	.word	3064
	.word	2968
	.word	2980
	.word	2996
	.word	3028
	.word	3060
	.size	drawEnemy, .-drawEnemy
	.align	2
	.global	updateEnemy
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateEnemy, %function
updateEnemy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, [r0]
	ldr	r1, [r0, #16]
	push	{r4, lr}
	add	ip, ip, r1
	ldr	r4, [r0, #20]
	ldr	r1, [r0, #4]
	ldr	r2, .L291
	ldr	lr, .L291+4
	add	r1, r1, r4
	ldr	r2, [r2]
	ldr	lr, [lr]
	ldr	r4, [r0, #32]
	rsb	r2, r2, ip, asr #6
	rsb	lr, lr, r1, asr #6
	cmp	r4, #0
	stmib	r0, {r1, r2, lr}
	str	ip, [r0]
	beq	.L278
	ldr	r1, [r0, #24]
	add	r1, r2, r1
	cmp	r1, #0
	movgt	r1, #1
	movle	r1, #0
	cmp	r2, #240
	movgt	r1, #0
	cmp	r1, #0
	bne	.L290
.L278:
	pop	{r4, lr}
	bx	lr
.L290:
	ldr	r3, [r0, #28]
	add	r3, lr, r3
	cmp	r3, #0
	movgt	r3, #1
	movle	r3, #0
	cmp	lr, #160
	movgt	r3, #0
	cmp	r3, #0
	beq	.L278
	pop	{r4, lr}
	b	drawEnemy
.L292:
	.align	2
.L291:
	.word	bg2xOff
	.word	bg2yOff
	.size	updateEnemy, .-updateEnemy
	.align	2
	.global	freeMineSprites
	.syntax unified
	.arm
	.fpu softvfp
	.type	freeMineSprites, %function
freeMineSprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #512
	ldr	r3, .L296
	add	r2, r3, #160
.L294:
	strh	r1, [r3, #192]	@ movhi
	add	r3, r3, #8
	cmp	r3, r2
	bne	.L294
	mov	r2, #0
	ldr	r3, .L296+4
	str	r2, [r3, #24]
	bx	lr
.L297:
	.align	2
.L296:
	.word	shadowOAM
	.word	.LANCHOR0
	.size	freeMineSprites, .-freeMineSprites
	.align	2
	.global	drawMine
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawMine, %function
drawMine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, .L309
	ldr	r3, [ip, #24]
	cmp	r3, #19
	bxgt	lr
	ldr	r1, [ip, #28]
	cmp	r1, #1
	push	{r4, lr}
	add	r2, r3, #24
	beq	.L300
	cmp	r1, #2
	beq	.L301
	cmp	r1, #0
	moveq	r4, #3008
	ldreq	lr, .L309+4
	addeq	r1, lr, r2, lsl #3
	ldrne	lr, .L309+4
	strheq	r4, [r1, #4]	@ movhi
	lslne	r2, r2, #3
	lsleq	r2, r2, #3
.L302:
	ldr	r1, [r0, #8]
	ldrb	r0, [r0, #12]	@ zero_extendqisi2
	add	r3, r3, #1
	lsl	r1, r1, #23
	str	r3, [ip, #24]
	lsr	r1, r1, #23
	add	r3, lr, r2
	orr	r0, r0, #8192
	strh	r0, [lr, r2]	@ movhi
	strh	r1, [r3, #2]	@ movhi
	pop	{r4, lr}
	bx	lr
.L301:
	ldr	lr, .L309+4
	ldr	r4, .L309+8
	add	r1, lr, r2, lsl #3
	strh	r4, [r1, #4]	@ movhi
	lsl	r2, r2, #3
	b	.L302
.L300:
	ldr	lr, .L309+4
	ldr	r4, .L309+12
	add	r1, lr, r2, lsl #3
	strh	r4, [r1, #4]	@ movhi
	lsl	r2, r2, #3
	b	.L302
.L310:
	.align	2
.L309:
	.word	.LANCHOR0
	.word	shadowOAM
	.word	3012
	.word	3010
	.size	drawMine, .-drawMine
	.align	2
	.global	updateMine
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateMine, %function
updateMine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, [r0]
	ldr	r1, [r0, #16]
	push	{r4, lr}
	add	ip, ip, r1
	ldr	r4, [r0, #20]
	ldr	r1, [r0, #4]
	ldr	r2, .L324
	ldr	lr, .L324+4
	add	r1, r1, r4
	ldr	r2, [r2]
	ldr	lr, [lr]
	ldr	r4, [r0, #32]
	rsb	r2, r2, ip, asr #6
	rsb	lr, lr, r1, asr #6
	cmp	r4, #0
	stmib	r0, {r1, r2, lr}
	str	ip, [r0]
	beq	.L311
	ldr	r1, [r0, #24]
	add	r1, r2, r1
	cmp	r1, #0
	movgt	r1, #1
	movle	r1, #0
	cmp	r2, #240
	movgt	r1, #0
	cmp	r1, #0
	bne	.L323
.L311:
	pop	{r4, lr}
	bx	lr
.L323:
	ldr	r3, [r0, #28]
	add	r3, lr, r3
	cmp	r3, #0
	movgt	r3, #1
	movle	r3, #0
	cmp	lr, #160
	movgt	r3, #0
	cmp	r3, #0
	beq	.L311
	pop	{r4, lr}
	b	drawMine
.L325:
	.align	2
.L324:
	.word	bg2xOff
	.word	bg2yOff
	.size	updateMine, .-updateMine
	.align	2
	.global	freePickupSprites
	.syntax unified
	.arm
	.fpu softvfp
	.type	freePickupSprites, %function
freePickupSprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r2, #512
	mov	r0, #0
	ldr	r3, .L328
	str	lr, [sp, #-4]!
	add	ip, r3, #360
	add	lr, r3, #352
	ldr	r1, .L328+4
	strh	r2, [lr]	@ movhi
	strh	r2, [ip]	@ movhi
	add	lr, r3, #368
	add	ip, r3, #376
	add	r3, r3, #384
	strh	r2, [lr]	@ movhi
	strh	r2, [ip]	@ movhi
	ldr	lr, [sp], #4
	strh	r2, [r3]	@ movhi
	str	r0, [r1, #32]
	bx	lr
.L329:
	.align	2
.L328:
	.word	shadowOAM
	.word	.LANCHOR0
	.size	freePickupSprites, .-freePickupSprites
	.align	2
	.global	drawPickup
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawPickup, %function
drawPickup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, .L342
	ldr	r3, [ip, #32]
	cmp	r3, #4
	bxgt	lr
	ldr	r1, [r0, #8]
	push	{r4, r5, lr}
	ldrb	r4, [r0, #12]	@ zero_extendqisi2
	ldr	lr, .L342+4
	ldr	r5, [r0, #28]
	add	r2, r3, #44
	lsl	r1, r1, #23
	lsl	r0, r2, #3
	lsr	r1, r1, #23
	orr	r4, r4, #8192
	add	r2, lr, r2, lsl #3
	strh	r4, [lr, r0]	@ movhi
	strh	r1, [r2, #2]	@ movhi
	cmp	r5, #3
	ldrls	pc, [pc, r5, asl #2]
	b	.L332
.L334:
	.word	.L337
	.word	.L336
	.word	.L335
	.word	.L333
.L333:
	ldr	r2, .L342+8
	add	lr, lr, r0
	strh	r2, [lr, #4]	@ movhi
.L332:
	add	r3, r3, #1
	str	r3, [ip, #32]
	pop	{r4, r5, lr}
	bx	lr
.L337:
	ldr	r2, .L342+12
	add	lr, lr, r0
	add	r3, r3, #1
	strh	r2, [lr, #4]	@ movhi
	str	r3, [ip, #32]
	pop	{r4, r5, lr}
	bx	lr
.L336:
	ldr	r2, .L342+16
	add	lr, lr, r0
	add	r3, r3, #1
	strh	r2, [lr, #4]	@ movhi
	str	r3, [ip, #32]
	pop	{r4, r5, lr}
	bx	lr
.L335:
	ldr	r2, .L342+20
	add	lr, lr, r0
	add	r3, r3, #1
	strh	r2, [lr, #4]	@ movhi
	str	r3, [ip, #32]
	pop	{r4, r5, lr}
	bx	lr
.L343:
	.align	2
.L342:
	.word	.LANCHOR0
	.word	shadowOAM
	.word	3050
	.word	3046
	.word	3048
	.word	3044
	.size	drawPickup, .-drawPickup
	.align	2
	.global	updatePickup
	.syntax unified
	.arm
	.fpu softvfp
	.type	updatePickup, %function
updatePickup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L357
	ldr	ip, [r0]
	ldr	r1, .L357+4
	ldr	r2, [r2]
	str	lr, [sp, #-4]!
	rsb	r2, r2, ip, asr #6
	ldr	r1, [r1]
	ldr	lr, [r0, #4]
	ldr	ip, [r0, #24]
	rsb	r1, r1, lr, asr #6
	cmp	ip, #0
	str	r2, [r0, #8]
	str	r1, [r0, #12]
	beq	.L344
	ldr	ip, [r0, #16]
	add	ip, r2, ip
	cmp	ip, #0
	movgt	ip, #1
	movle	ip, #0
	cmp	r2, #240
	movgt	ip, #0
	cmp	ip, #0
	bne	.L356
.L344:
	ldr	lr, [sp], #4
	bx	lr
.L356:
	ldr	r3, [r0, #20]
	add	r3, r1, r3
	cmp	r3, #0
	movgt	r3, #1
	movle	r3, #0
	cmp	r1, #160
	movgt	r3, #0
	cmp	r3, #0
	beq	.L344
	ldr	lr, [sp], #4
	b	drawPickup
.L358:
	.align	2
.L357:
	.word	bg2xOff
	.word	bg2yOff
	.size	updatePickup, .-updatePickup
	.align	2
	.global	updateHealthBar
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateHealthBar, %function
updateHealthBar:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	ldr	r7, .L365
	ldr	r1, [r7]
	cmp	r1, #0
	movle	r5, #1824
	movgt	r5, #1792
	mov	lr, #16
	ldr	r8, .L365+4
	ldr	r4, .L365+8
	ldr	r10, .L365+12
	ldr	ip, .L365+16
	ldr	r6, .L365+20
	ldr	r9, .L365+24
	ldr	r2, [r8]
	mov	r3, #26
	mov	r0, #1
	strh	lr, [r4, #130]	@ movhi
	strh	r5, [r4, #132]	@ movhi
	strh	ip, [r4, #138]	@ movhi
	strh	r6, [r4, #128]	@ movhi
	strh	r10, [r4, #136]	@ movhi
	mov	lr, pc
	bx	r9
	ldr	r5, .L365+28
	sub	r0, r5, r0
	lsl	r0, r0, #1
	ldr	ip, .L365+32
	orr	r0, r0, #1024
	ldr	r2, [r8]
	ldr	r1, [r7]
	strh	r0, [r4, #140]	@ movhi
	mov	r3, #26
	mov	r0, #5
	strh	ip, [r4, #146]	@ movhi
	strh	r10, [r4, #144]	@ movhi
	mov	lr, pc
	bx	r9
	sub	r0, r5, r0
	lsl	r0, r0, #1
	ldr	ip, .L365+36
	orr	r0, r0, #1024
	ldr	r2, [r8]
	ldr	r1, [r7]
	strh	r0, [r4, #148]	@ movhi
	mov	r3, #26
	mov	r0, #9
	strh	ip, [r4, #154]	@ movhi
	strh	r10, [r4, #152]	@ movhi
	mov	lr, pc
	bx	r9
	sub	r0, r5, r0
	lsl	r0, r0, #1
	ldr	ip, .L365+40
	orr	r0, r0, #1024
	ldr	r2, [r8]
	ldr	r1, [r7]
	strh	r0, [r4, #156]	@ movhi
	mov	r3, #26
	mov	r0, #13
	strh	ip, [r4, #162]	@ movhi
	strh	r10, [r4, #160]	@ movhi
	mov	lr, pc
	bx	r9
	sub	r0, r5, r0
	lsl	r0, r0, #1
	ldr	ip, .L365+44
	orr	r0, r0, #1024
	ldr	r2, [r8]
	ldr	r1, [r7]
	strh	r0, [r4, #164]	@ movhi
	mov	r3, #26
	mov	r0, #17
	strh	ip, [r4, #170]	@ movhi
	strh	r10, [r4, #168]	@ movhi
	mov	lr, pc
	bx	r9
	sub	r0, r5, r0
	lsl	r0, r0, #1
	ldr	ip, .L365+48
	orr	r0, r0, #1024
	ldr	r1, [r7]
	ldr	r2, [r8]
	strh	r0, [r4, #172]	@ movhi
	mov	r3, #26
	mov	r0, #21
	strh	r10, [r4, #176]	@ movhi
	strh	ip, [r4, #178]	@ movhi
	mov	lr, pc
	bx	r9
	ldr	r3, [r8]
	ldr	r2, .L365+52
	add	r3, r3, r3, lsl #2
	add	r3, r3, r3, lsl #2
	smull	r1, r2, r3, r2
	ldr	r1, [r7]
	asr	r3, r3, #31
	rsb	r3, r3, r2, asr #3
	cmp	r3, r1
	movlt	r3, #1792
	movge	r3, #1824
	sub	r5, r5, r0
	ldr	r2, .L365+56
	lsl	r5, r5, #1
	orr	r5, r5, #1024
	strh	r5, [r4, #180]	@ movhi
	strh	r6, [r4, #184]	@ movhi
	strh	r3, [r4, #188]	@ movhi
	strh	r2, [r4, #186]	@ movhi
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L366:
	.align	2
.L365:
	.word	submarineHp
	.word	submarineMaxHp
	.word	shadowOAM
	.word	24578
	.word	16408
	.word	8194
	.word	tilesRed
	.word	389
	.word	16440
	.word	16472
	.word	16504
	.word	16536
	.word	16568
	.word	1321528399
	.word	4312
	.size	updateHealthBar, .-updateHealthBar
	.align	2
	.global	updateWorld
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateWorld, %function
updateWorld:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r6, .L403
	ldr	r3, [r6, #36]
	cmp	r3, #20
	movgt	r2, #1
	ldrgt	r1, [r6, #20]
	ldrgt	r3, .L403+4
	addgt	r1, r1, r2
	smullgt	r0, r3, r1, r3
	subgt	r3, r3, r1, asr #31
	addgt	r3, r3, r3, lsl r2
	subgt	r3, r1, r3
	addle	r2, r3, #1
	strgt	r3, [r6, #20]
	ldr	r3, [r6, #40]
	cmp	r3, #20
	movgt	r3, #1
	ldrgt	r1, [r6, #28]
	str	r2, [r6, #36]
	ldrgt	r2, .L403+4
	addgt	r1, r1, r3
	smullgt	r0, r2, r1, r2
	subgt	r2, r2, r1, asr #31
	addgt	r2, r2, r2, lsl r3
	addle	r3, r3, #1
	subgt	r2, r1, r2
	strgt	r2, [r6, #28]
	str	r3, [r6, #40]
	bl	updatePlayer
	ldr	r4, .L403+8
	add	r5, r4, #200
.L373:
	ldr	r3, [r4, #32]
	cmp	r3, #0
	bne	.L399
.L372:
	add	r4, r4, #40
	cmp	r4, r5
	bne	.L373
	mov	r2, #512
	mov	r1, #0
	ldr	r3, .L403+12
	ldr	r4, .L403+16
	strh	r2, [r3, #48]	@ movhi
	strh	r2, [r3, #56]	@ movhi
	strh	r2, [r3, #64]	@ movhi
	strh	r2, [r3, #72]	@ movhi
	strh	r2, [r3, #80]	@ movhi
	strh	r2, [r3, #88]	@ movhi
	strh	r2, [r3, #96]	@ movhi
	strh	r2, [r3, #104]	@ movhi
	strh	r2, [r3, #112]	@ movhi
	strh	r2, [r3, #120]	@ movhi
	add	r5, r4, #2640
	str	r1, [r6, #16]
	b	.L375
.L374:
	add	r4, r4, #44
	cmp	r5, r4
	beq	.L400
.L375:
	ldr	r3, [r4, #32]
	cmp	r3, #0
	beq	.L374
	mov	r0, r4
	add	r4, r4, #44
	bl	updateEnemy
	cmp	r5, r4
	bne	.L375
.L400:
	mov	r1, #512
	ldr	r3, .L403+12
	add	r2, r3, #160
.L376:
	strh	r1, [r3, #192]	@ movhi
	add	r3, r3, #8
	cmp	r2, r3
	bne	.L376
	mov	r3, #0
	ldr	r4, .L403+20
	str	r3, [r6, #24]
	add	r5, r4, #2400
	b	.L378
.L377:
	add	r4, r4, #40
	cmp	r5, r4
	beq	.L401
.L378:
	ldr	r3, [r4, #32]
	cmp	r3, #0
	beq	.L377
	mov	r0, r4
	add	r4, r4, #40
	bl	updateMine
	cmp	r5, r4
	bne	.L378
.L401:
	ldr	r2, .L403+24
	mov	r3, #512
	mov	r1, r2
	mov	r0, #0
	strh	r3, [r1], #8	@ movhi
	ldr	r4, .L403+28
	strh	r3, [r1]	@ movhi
	add	r5, r4, #320
	str	r0, [r6, #32]
	strh	r3, [r2, #16]	@ movhi
	strh	r3, [r2, #24]	@ movhi
	strh	r3, [r2, #32]	@ movhi
	b	.L380
.L379:
	add	r4, r4, #32
	cmp	r4, r5
	beq	.L402
.L380:
	ldr	r3, [r4, #24]
	cmp	r3, #0
	beq	.L379
	mov	r0, r4
	add	r4, r4, #32
	bl	updatePickup
	cmp	r4, r5
	bne	.L380
.L402:
	bl	doCollision
	pop	{r4, r5, r6, lr}
	b	updateHealthBar
.L399:
	mov	r0, r4
	bl	updateBullet
	b	.L372
.L404:
	.align	2
.L403:
	.word	.LANCHOR0
	.word	1431655766
	.word	bullets
	.word	shadowOAM
	.word	enemies
	.word	mines
	.word	shadowOAM+352
	.word	pickups
	.size	updateWorld, .-updateWorld
	.global	mineAniFrame
	.global	mineFrameCounter
	.global	enemyAniFrame
	.global	enemyFrameCounter
	.global	drawnPickups
	.global	drawnMines
	.global	drawnEnemies
	.comm	opponentIdx,4,4
	.global	doBattle
	.global	level
	.comm	pickups,320,4
	.comm	mines,2400,4
	.comm	enemies,2640,4
	.comm	bullets,200,4
	.comm	player,36,4
	.global	collisionMap
	.comm	soundB,32,4
	.comm	soundA,32,4
	.global	levels
	.data
	.align	2
	.set	.LANCHOR1,. + 0
	.type	collisionMap, %object
	.size	collisionMap, 4
collisionMap:
	.word	world1collisionBitmap
	.type	levels, %object
	.size	levels, 5360
levels:
	.word	2048
	.word	10240
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	11776
	.word	11264
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	4096
	.word	21504
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	16384
	.word	22528
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	21504
	.word	21504
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	26624
	.word	11776
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	21568
	.word	8192
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	28160
	.word	4608
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	38912
	.word	5632
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	39936
	.word	8704
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	47616
	.word	7680
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	53248
	.word	8704
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	45120
	.word	11776
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	54272
	.word	19968
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	41472
	.word	20544
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	49664
	.word	30208
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	41984
	.word	32768
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	48192
	.word	34304
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	41472
	.word	39936
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	52288
	.word	39936
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	4
	.word	45056
	.word	44608
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	59904
	.word	43008
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	62464
	.word	36352
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	53248
	.word	48640
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	3
	.word	49664
	.word	51712
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	2
	.word	56320
	.word	60928
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	34816
	.word	61440
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	27136
	.word	61440
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	35840
	.word	42496
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	3
	.word	33792
	.word	31744
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	34944
	.word	25600
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	0
	.word	25088
	.word	33280
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	30208
	.word	35392
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	28736
	.word	40000
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	2
	.word	21056
	.word	36416
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	23040
	.word	41472
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	4
	.word	23040
	.word	44544
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	17408
	.word	41408
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	3
	.word	15360
	.word	37376
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	1
	.word	11776
	.word	34816
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	2
	.word	6144
	.word	38400
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	4
	.word	2048
	.word	35584
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	4
	.word	4352
	.word	29696
	.space	16
	.word	16
	.word	8
	.word	1
	.word	0
	.word	3
	.word	10752
	.word	59392
	.space	16
	.word	32
	.word	16
	.word	1
	.word	0
	.word	5
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	9728
	.word	22528
	.space	24
	.word	1
	.word	10
	.word	11264
	.word	22528
	.space	24
	.word	1
	.word	10
	.word	12800
	.word	22528
	.space	24
	.word	1
	.word	10
	.word	16384
	.word	20992
	.space	24
	.word	1
	.word	10
	.word	25088
	.word	20992
	.space	24
	.word	1
	.word	10
	.word	29696
	.word	19968
	.space	24
	.word	1
	.word	10
	.word	33280
	.word	11776
	.space	24
	.word	1
	.word	10
	.word	31232
	.word	13824
	.space	24
	.word	1
	.word	10
	.word	30208
	.word	13824
	.space	24
	.word	1
	.word	10
	.word	47104
	.word	21504
	.space	24
	.word	1
	.word	10
	.word	48128
	.word	20992
	.space	24
	.word	1
	.word	10
	.word	49152
	.word	21376
	.space	24
	.word	1
	.word	10
	.word	50176
	.word	21504
	.space	24
	.word	1
	.word	10
	.word	51200
	.word	21504
	.space	24
	.word	1
	.word	10
	.word	52224
	.word	21504
	.space	24
	.word	1
	.word	10
	.word	53248
	.word	20992
	.space	24
	.word	1
	.word	10
	.word	54272
	.word	20992
	.space	24
	.word	1
	.word	10
	.word	55296
	.word	20992
	.space	24
	.word	1
	.word	10
	.word	50688
	.word	31232
	.space	24
	.word	1
	.word	10
	.word	61440
	.word	26624
	.space	24
	.word	1
	.word	10
	.word	62464
	.word	26624
	.space	24
	.word	1
	.word	10
	.word	61440
	.word	24064
	.space	24
	.word	1
	.word	10
	.word	64000
	.word	24064
	.space	24
	.word	1
	.word	10
	.word	62464
	.word	22016
	.space	24
	.word	1
	.word	10
	.word	63488
	.word	19968
	.space	24
	.word	1
	.word	10
	.word	61952
	.word	17920
	.space	24
	.word	1
	.word	10
	.word	62976
	.word	16384
	.space	24
	.word	1
	.word	10
	.word	64000
	.word	15360
	.space	24
	.word	1
	.word	10
	.word	62464
	.word	13312
	.space	24
	.word	1
	.word	10
	.word	62976
	.word	12800
	.space	24
	.word	1
	.word	10
	.word	61952
	.word	10240
	.space	24
	.word	1
	.word	10
	.word	63488
	.word	8192
	.space	24
	.word	1
	.word	10
	.word	61952
	.word	7168
	.space	24
	.word	1
	.word	10
	.word	62976
	.word	5632
	.space	24
	.word	1
	.word	10
	.word	64000
	.word	5632
	.space	24
	.word	1
	.word	10
	.word	48128
	.word	48640
	.space	24
	.word	1
	.word	10
	.word	45056
	.word	51712
	.space	24
	.word	1
	.word	10
	.word	41472
	.word	47616
	.space	24
	.word	1
	.word	10
	.word	43008
	.word	51712
	.space	24
	.word	1
	.word	10
	.word	39936
	.word	50176
	.space	24
	.word	1
	.word	10
	.word	38400
	.word	48640
	.space	24
	.word	1
	.word	10
	.word	37888
	.word	52736
	.space	24
	.word	1
	.word	10
	.word	35840
	.word	51712
	.space	24
	.word	1
	.word	10
	.word	33280
	.word	50688
	.space	24
	.word	1
	.word	10
	.word	32256
	.word	52736
	.space	24
	.word	1
	.word	10
	.word	30208
	.word	49152
	.space	24
	.word	1
	.word	10
	.word	28672
	.word	52224
	.space	24
	.word	1
	.word	10
	.word	27648
	.word	48640
	.space	24
	.word	1
	.word	10
	.word	23040
	.word	52224
	.space	24
	.word	1
	.word	10
	.word	21504
	.word	51712
	.space	24
	.word	1
	.word	10
	.word	30208
	.word	43008
	.space	24
	.word	1
	.word	10
	.word	17408
	.word	45056
	.space	24
	.word	1
	.word	10
	.word	12800
	.word	39424
	.space	24
	.word	1
	.word	10
	.word	28672
	.word	29184
	.space	24
	.word	1
	.word	10
	.word	28672
	.word	27136
	.space	24
	.word	1
	.word	10
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	49152
	.word	512
	.space	16
	.word	1
	.word	0
	.word	48640
	.word	51712
	.space	16
	.word	1
	.word	2
	.word	1280
	.word	29696
	.space	16
	.word	1
	.word	1
	.word	57856
	.word	1536
	.space	16
	.word	1
	.word	3
	.word	27648
	.word	60480
	.space	16
	.word	1
	.word	3
	.word	36352
	.word	44800
	.space	16
	.word	1
	.word	3
	.word	44032
	.word	61440
	.space	16
	.word	1
	.word	3
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	doBattle, %object
	.size	doBattle, 4
doBattle:
	.space	4
	.type	level, %object
	.size	level, 4
level:
	.space	4
	.type	frameCounter.5011, %object
	.size	frameCounter.5011, 4
frameCounter.5011:
	.space	4
	.type	aniFrame.5012, %object
	.size	aniFrame.5012, 4
aniFrame.5012:
	.space	4
	.type	drawnEnemies, %object
	.size	drawnEnemies, 4
drawnEnemies:
	.space	4
	.type	enemyAniFrame, %object
	.size	enemyAniFrame, 4
enemyAniFrame:
	.space	4
	.type	drawnMines, %object
	.size	drawnMines, 4
drawnMines:
	.space	4
	.type	mineAniFrame, %object
	.size	mineAniFrame, 4
mineAniFrame:
	.space	4
	.type	drawnPickups, %object
	.size	drawnPickups, 4
drawnPickups:
	.space	4
	.type	enemyFrameCounter, %object
	.size	enemyFrameCounter, 4
enemyFrameCounter:
	.space	4
	.type	mineFrameCounter, %object
	.size	mineFrameCounter, 4
mineFrameCounter:
	.space	4
	.ident	"GCC: (devkitARM release 53) 9.1.0"
