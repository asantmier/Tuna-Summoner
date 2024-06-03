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
	.file	"main.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Battle timer interrupt\000"
	.text
	.align	2
	.global	interruptHandler
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	interruptHandler, %function
interruptHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r5, #0
	ldr	r4, .L9
	ldr	r3, .L9+4
	strh	r5, [r4, #8]	@ movhi
	mov	lr, pc
	bx	r3
	ldrh	r3, [r4, #2]
	tst	r3, #32
	bne	.L8
.L2:
	mov	r2, #1
	ldr	r3, .L9
	pop	{r4, r5, r6, lr}
	strh	r2, [r3, #8]	@ movhi
	bx	lr
.L8:
	ldr	r2, .L9+8
	ldr	r0, .L9+12
	ldr	r3, .L9+16
	str	r5, [r2]
	mov	lr, pc
	bx	r3
	mov	r3, #32
	ldr	r2, .L9+20
	ldr	r1, .L9+24
	ldr	ip, [r2]
	ldr	r2, .L9+28
	ldr	r1, [r1]
	str	ip, [r2]
	ldr	r0, .L9+32
	ldr	r2, .L9+36
	ldr	r0, [r0]
	str	r1, [r2]
	ldr	r1, .L9+40
	ldr	r2, .L9+44
	str	r0, [r1]
	strh	r5, [r2, #10]	@ movhi
	strh	r3, [r4, #2]	@ movhi
	b	.L2
.L10:
	.align	2
.L9:
	.word	67109376
	.word	soundInterruptHandler
	.word	waiting
	.word	.LC0
	.word	mgba_printf
	.word	nextTurnPoints
	.word	nextFighterIdx
	.word	turnPoints
	.word	nextTurn
	.word	fighterIdx
	.word	turn
	.word	67109120
	.size	interruptHandler, .-interruptHandler
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"Konami %d\000"
	.align	2
.LC2:
	.ascii	"Konami reset %d\000"
	.align	2
.LC3:
	.ascii	"CHEATER\000"
	.align	2
.LC4:
	.ascii	"Konami code confirmed\000"
	.text
	.align	2
	.global	lmao
	.syntax unified
	.arm
	.fpu softvfp
	.type	lmao, %function
lmao:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r4, .L29
	ldr	r1, .L29+4
	ldr	r2, .L29+8
	ldr	r5, [r4]
	ldr	r3, .L29+12
	ldrh	r0, [r1]
	ldr	r2, [r2, r5, lsl #2]
	ldrh	r1, [r3]
	bics	r3, r2, r0
	mvn	lr, r1
	mvn	r0, r0
	bne	.L17
	ands	r2, r2, lr
	bne	.L26
.L15:
	asr	r3, r0, r2
	ands	r3, r3, #1
	asr	ip, lr, r2
	add	r2, r2, #1
	bne	.L14
	tst	ip, #1
	bne	.L27
.L14:
	cmp	r2, #10
	bne	.L15
.L13:
	cmp	r5, #11
	beq	.L28
	pop	{r4, r5, r6, lr}
	bx	lr
.L17:
	mov	r2, #0
	b	.L15
.L28:
	mov	ip, #1
	mov	r2, #5
	mov	r3, #99
	ldr	r0, .L29+16
	ldr	r1, .L29+20
	str	r2, [r0, #24]
	str	ip, [r1]
	ldr	r2, .L29+24
	ldr	r1, .L29+28
	str	r2, [r0, #40]
	str	r1, [r0, #44]
	mov	r2, #10
	ldr	r1, .L29+32
	str	r3, [r0, #16]
	str	r3, [r0, #20]
	ldr	r3, .L29+36
	mov	lr, pc
	bx	r3
	ldr	r3, .L29+40
	ldr	r2, .L29+44
	ldr	r1, [r3]
	ldr	r0, .L29+48
	ldr	r3, .L29+52
	str	r1, [r2]
	mov	lr, pc
	bx	r3
	mov	r3, #0
	str	r3, [r4]
	pop	{r4, r5, r6, lr}
	bx	lr
.L26:
	add	r1, r5, #1
	ldr	r0, .L29+56
	ldr	r3, .L29+52
	str	r1, [r4]
	mov	lr, pc
	bx	r3
	ldr	r5, [r4]
	b	.L13
.L27:
	ldr	r0, .L29+60
	ldr	r2, .L29+52
	str	r3, [r4]
	mov	lr, pc
	bx	r2
	ldr	r5, [r4]
	b	.L13
.L30:
	.align	2
.L29:
	.word	.LANCHOR0
	.word	oldButtons
	.word	.LANCHOR1
	.word	buttons
	.word	battleAllies
	.word	cheater
	.word	MOVE_DEATHRAY
	.word	MOVE_BRUH
	.word	.LC3
	.word	strncpy
	.word	submarineMaxHp
	.word	submarineHp
	.word	.LC4
	.word	mgba_printf
	.word	.LC1
	.word	.LC2
	.size	lmao, .-lmao
	.align	2
	.global	goToStart
	.syntax unified
	.arm
	.fpu softvfp
	.type	goToStart, %function
goToStart:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r0, #3
	ldr	r4, .L33
	ldr	r3, .L33+4
	ldr	r2, .L33+8
	ldr	r1, .L33+12
	mov	lr, pc
	bx	r4
	mov	r0, #3
	ldr	r3, .L33+16
	ldr	r2, .L33+20
	ldr	r1, .L33+24
	mov	lr, pc
	bx	r4
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L33+28
	mov	lr, pc
	bx	r4
	mov	r3, #67108864
	mov	r4, #424
	mov	lr, #716
	mov	ip, #108544
	mov	r2, #0
	mov	r0, #352
	ldr	r1, .L33+32
	strh	r1, [r3, #8]	@ movhi
	ldr	r1, .L33+36
	strh	r1, [r3, #10]	@ movhi
	ldr	r1, .L33+40
	strh	r1, [r3]	@ movhi
	ldr	r1, .L33+44
	str	r4, [r1]
	ldr	r1, .L33+48
	str	lr, [r1]
	str	ip, [r3, #40]
	ldr	r1, [r1]
	lsl	r1, r1, #8
	str	r1, [r3, #44]
	ldr	lr, .L33+52
	ldr	ip, .L33+56
	ldr	r1, .L33+60
	str	r2, [lr]
	str	r0, [ip]
	pop	{r4, lr}
	strh	r2, [r3, #20]	@ movhi
	strh	r0, [r3, #22]	@ movhi
	str	r2, [r1]
	bx	lr
.L34:
	.align	2
.L33:
	.word	DMANow
	.word	67111824
	.word	100679680
	.word	splashscreenTiles
	.word	67109376
	.word	100694016
	.word	splashscreenMap
	.word	world1Pal
	.word	3972
	.word	-26997
	.word	5889
	.word	bg2xOff
	.word	bg2yOff
	.word	bg1xOff
	.word	bg1yOff
	.word	state
	.size	goToStart, .-goToStart
	.align	2
	.global	goToInstructions
	.syntax unified
	.arm
	.fpu softvfp
	.type	goToInstructions, %function
goToInstructions:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r0, #3
	ldr	r4, .L37
	ldr	r3, .L37+4
	ldr	r2, .L37+8
	ldr	r1, .L37+12
	mov	lr, pc
	bx	r4
	mov	r0, #3
	ldr	r3, .L37+16
	ldr	r2, .L37+20
	ldr	r1, .L37+24
	mov	lr, pc
	bx	r4
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L37+28
	mov	lr, pc
	bx	r4
	mov	r3, #67108864
	mov	r1, #1
	ldr	ip, .L37+32
	ldr	r0, .L37+36
	ldr	r2, .L37+40
	strh	ip, [r3, #8]	@ movhi
	pop	{r4, lr}
	strh	r0, [r3]	@ movhi
	str	r1, [r2]
	bx	lr
.L38:
	.align	2
.L37:
	.word	DMANow
	.word	67111904
	.word	100679680
	.word	instructionsTiles
	.word	67109376
	.word	100694016
	.word	instructionsMap
	.word	instructionsPal
	.word	3844
	.word	4353
	.word	state
	.size	goToInstructions, .-goToInstructions
	.align	2
	.global	instructions
	.syntax unified
	.arm
	.fpu softvfp
	.type	instructions, %function
instructions:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L46
	ldrh	r3, [r3]
	tst	r3, #4
	push	{r4, lr}
	beq	.L40
	ldr	r3, .L46+4
	ldrh	r3, [r3]
	tst	r3, #4
	beq	.L45
.L40:
	ldr	r3, .L46+8
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L45:
	bl	goToStart
	b	.L40
.L47:
	.align	2
.L46:
	.word	oldButtons
	.word	buttons
	.word	waitForVBlank
	.size	instructions, .-instructions
	.align	2
	.global	goToGame
	.syntax unified
	.arm
	.fpu softvfp
	.type	goToGame, %function
goToGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L50
	ldr	r4, .L50+4
	mov	lr, pc
	bx	r4
	mov	r3, #67108864
	mov	r1, #2
	ldr	ip, .L50+8
	ldr	r0, .L50+12
	ldr	r2, .L50+16
	strh	ip, [r3, #10]	@ movhi
	pop	{r4, lr}
	strh	r0, [r3]	@ movhi
	str	r1, [r2]
	bx	lr
.L51:
	.align	2
.L50:
	.word	world1Pal
	.word	DMANow
	.word	-26997
	.word	5633
	.word	state
	.size	goToGame, .-goToGame
	.align	2
	.global	goToBattle
	.syntax unified
	.arm
	.fpu softvfp
	.type	goToBattle, %function
goToBattle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r5, #67108864
	ldr	r2, .L54
	ldr	r4, .L54+4
	strh	r2, [r5, #8]	@ movhi
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L54+8
	mov	lr, pc
	bx	r4
	mov	r0, #3
	ldr	r3, .L54+12
	ldr	r2, .L54+16
	ldr	r1, .L54+20
	mov	lr, pc
	bx	r4
	ldr	r3, .L54+24
	ldr	r2, .L54+28
	ldr	r1, .L54+32
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r2, #3
	ldr	r1, .L54+36
	ldr	r3, .L54+40
	strh	r1, [r5]	@ movhi
	str	r2, [r3]
	pop	{r4, r5, r6, lr}
	bx	lr
.L55:
	.align	2
.L54:
	.word	3972
	.word	DMANow
	.word	tempbattlePal
	.word	67110816
	.word	100679680
	.word	tempbattleTiles
	.word	67109376
	.word	100694016
	.word	tempbattleMap
	.word	4353
	.word	state
	.size	goToBattle, .-goToBattle
	.align	2
	.global	goToPause
	.syntax unified
	.arm
	.fpu softvfp
	.type	goToPause, %function
goToPause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r4, #67108864
	ldr	r3, .L58
	mov	lr, pc
	bx	r3
	ldr	r2, .L58+4
	ldr	r5, .L58+8
	strh	r2, [r4, #8]	@ movhi
	mov	r0, #3
	ldr	r3, .L58+12
	ldr	r2, .L58+16
	ldr	r1, .L58+20
	mov	lr, pc
	bx	r5
	ldr	r3, .L58+24
	ldr	r2, .L58+28
	ldr	r1, .L58+32
	mov	r0, #3
	mov	lr, pc
	bx	r5
	mov	r2, #4
	ldr	r1, .L58+36
	ldr	r3, .L58+40
	strh	r1, [r4]	@ movhi
	str	r2, [r3]
	pop	{r4, r5, r6, lr}
	bx	lr
.L59:
	.align	2
.L58:
	.word	pauseSound
	.word	3972
	.word	DMANow
	.word	67111456
	.word	100679680
	.word	pauseTiles
	.word	67109376
	.word	100694016
	.word	pauseMap
	.word	5889
	.word	state
	.size	goToPause, .-goToPause
	.align	2
	.global	goToWin
	.syntax unified
	.arm
	.fpu softvfp
	.type	goToWin, %function
goToWin:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r4, #67108864
	ldr	r3, .L62
	mov	lr, pc
	bx	r3
	ldr	r2, .L62+4
	ldr	r5, .L62+8
	strh	r2, [r4, #8]	@ movhi
	mov	r0, #3
	ldr	r3, .L62+12
	ldr	r2, .L62+16
	ldr	r1, .L62+20
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L62+24
	ldr	r2, .L62+28
	ldr	r1, .L62+32
	mov	lr, pc
	bx	r5
	mov	r2, #5
	mov	ip, #1280
	mov	r0, #0
	mov	r1, #352
	ldr	lr, .L62+36
	ldr	r3, .L62+40
	str	r2, [lr]
	ldr	lr, .L62+44
	str	lr, [r3]
	str	ip, [r4, #40]
	ldr	r3, [r3]
	lsl	r3, r3, #8
	str	r3, [r4, #44]
	ldr	r5, .L62+48
	ldr	lr, .L62+52
	ldr	ip, .L62+56
	ldr	r3, .L62+60
	str	r0, [r5]
	str	r1, [lr]
	strh	r0, [r4, #20]	@ movhi
	strh	r1, [r4, #22]	@ movhi
	strh	ip, [r4]	@ movhi
	str	r2, [r3]
	pop	{r4, r5, r6, lr}
	bx	lr
.L63:
	.align	2
.L62:
	.word	stopSound
	.word	3972
	.word	DMANow
	.word	67112288
	.word	100679680
	.word	winTiles
	.word	67109376
	.word	100694016
	.word	winMap
	.word	bg2xOff
	.word	bg2yOff
	.word	858
	.word	bg1xOff
	.word	bg1yOff
	.word	1793
	.word	state
	.size	goToWin, .-goToWin
	.align	2
	.global	goToLose
	.syntax unified
	.arm
	.fpu softvfp
	.type	goToLose, %function
goToLose:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r5, #67108864
	ldr	r3, .L66
	mov	lr, pc
	bx	r3
	ldr	r2, .L66+4
	ldr	r4, .L66+8
	strh	r2, [r5, #8]	@ movhi
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L66+12
	mov	lr, pc
	bx	r4
	mov	r0, #3
	ldr	r3, .L66+16
	ldr	r2, .L66+20
	ldr	r1, .L66+24
	mov	lr, pc
	bx	r4
	ldr	r3, .L66+28
	ldr	r2, .L66+32
	ldr	r1, .L66+36
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r2, #6
	ldr	r1, .L66+40
	ldr	r3, .L66+44
	strh	r1, [r5]	@ movhi
	str	r2, [r3]
	pop	{r4, r5, r6, lr}
	bx	lr
.L67:
	.align	2
.L66:
	.word	stopSound
	.word	3844
	.word	DMANow
	.word	losePal
	.word	67111104
	.word	100679680
	.word	loseTiles
	.word	67109376
	.word	100694016
	.word	loseMap
	.word	257
	.word	state
	.size	goToLose, .-goToLose
	.align	2
	.global	battle
	.syntax unified
	.arm
	.fpu softvfp
	.type	battle, %function
battle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L85
	push	{r4, r5, r6, lr}
	mov	lr, pc
	bx	r3
	ldr	r3, .L85+4
	ldr	ip, [r3]
	add	r3, ip, #1
	bics	r3, r3, #2
	beq	.L81
	ldr	r4, .L85+8
.L69:
	ldr	r3, .L85+12
	mov	lr, pc
	bx	r3
	mov	r3, #512
	mov	r2, #117440512
	mov	r0, #3
	ldr	r1, .L85+16
	mov	lr, pc
	bx	r4
	mov	r2, #67108864
	ldr	r3, .L85+20
	ldr	r3, [r3]
	lsl	r3, r3, #8
	str	r3, [r2, #40]
	ldr	r3, .L85+24
	ldr	r3, [r3]
	lsl	r3, r3, #8
	str	r3, [r2, #44]
	pop	{r4, r5, r6, lr}
	bx	lr
.L81:
	ldr	r3, .L85+28
	mov	r2, r3
	ldr	r1, [r3, #16]
	str	r1, [r3, #20]
	add	lr, r3, #168
.L72:
	add	r1, r2, #72
	ldm	r1, {r1, r3}
	add	r0, r1, r1, lsr #31
	add	r3, r3, r0, asr #1
	cmp	r3, r1
	movge	r3, r1
	add	r2, r2, #56
	str	r3, [r2, #20]
	cmp	r2, lr
	bne	.L72
	cmn	ip, #1
	beq	.L83
	mov	r0, #1
	ldr	r3, .L85+32
	mov	lr, pc
	bx	r3
.L75:
	ldr	r3, .L85+36
	mov	lr, pc
	bx	r3
	ldr	r4, .L85+8
	mov	r2, #117440512
	mov	r0, #3
	ldr	r1, .L85+16
	mov	r3, #512
	mov	lr, pc
	bx	r4
	ldr	r3, .L85+40
	mov	lr, pc
	bx	r3
	ldr	r2, .L85+44
	ldr	r3, .L85+48
	ldr	r1, [r2]
	ldr	r3, [r3]
	mov	r2, #1
	ldr	r0, .L85+52
	ldr	r5, .L85+56
	mov	lr, pc
	bx	r5
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L85+60
	mov	lr, pc
	bx	r4
	mov	r3, #67108864
	mov	r1, #2
	ldr	ip, .L85+64
	ldr	r0, .L85+68
	ldr	r2, .L85+72
	strh	ip, [r3, #10]	@ movhi
	strh	r0, [r3]	@ movhi
	str	r1, [r2]
	b	.L69
.L83:
	ldr	r3, .L85+76
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L84
.L74:
	ldr	r2, .L85+80
	ldr	r3, [r2]
	mov	r0, #0
	sub	r3, r3, #20
	ldr	r1, .L85+32
	str	r3, [r2]
	mov	lr, pc
	bx	r1
	b	.L75
.L84:
	bl	goToLose
	b	.L74
.L86:
	.align	2
.L85:
	.word	updateBattle
	.word	battleStatus
	.word	DMANow
	.word	waitForVBlank
	.word	shadowOAM
	.word	bg2xOff
	.word	bg2yOff
	.word	battleAllies
	.word	returnFromBattle
	.word	hideSprites
	.word	stopSound
	.word	worldTheme_length
	.word	worldThemeCtr
	.word	worldTheme_data
	.word	playSoundA
	.word	world1Pal
	.word	-26997
	.word	5633
	.word	state
	.word	bossBattle
	.word	submarineHp
	.size	battle, .-battle
	.align	2
	.global	prepareWorldAnim
	.syntax unified
	.arm
	.fpu softvfp
	.type	prepareWorldAnim, %function
prepareWorldAnim:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r5, .L89
	ldr	r4, .L89+4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+8
	ldr	r1, .L89+12
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+16
	ldr	r1, .L89+20
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+24
	ldr	r1, .L89+28
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+32
	ldr	r1, .L89+36
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+40
	ldr	r1, .L89+44
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+48
	ldr	r1, .L89+52
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+56
	ldr	r1, .L89+60
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+64
	ldr	r1, .L89+68
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+72
	ldr	r1, .L89+76
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+80
	ldr	r1, .L89+84
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+88
	ldr	r1, .L89+92
	mov	lr, pc
	bx	r4
	mov	r3, r5
	mov	r0, #3
	ldr	r2, .L89+96
	ldr	r1, .L89+100
	mov	lr, pc
	bx	r4
	pop	{r4, r5, r6, lr}
	bx	lr
.L90:
	.align	2
.L89:
	.word	67108880
	.word	DMANow
	.word	100668416
	.word	100663744
	.word	100668480
	.word	100663424
	.word	100668544
	.word	100663488
	.word	100668608
	.word	100663680
	.word	100668672
	.word	100664128
	.word	100668736
	.word	100663552
	.word	100668800
	.word	100664192
	.word	100668864
	.word	100663616
	.word	100668928
	.word	100664704
	.word	100668992
	.word	100663808
	.word	100669056
	.word	100664640
	.word	100669120
	.word	100664064
	.size	prepareWorldAnim, .-prepareWorldAnim
	.align	2
	.global	initialize
	.syntax unified
	.arm
	.fpu softvfp
	.type	initialize, %function
initialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r4, #67108864
	mov	r8, #1
	mov	r5, #0
	ldr	r6, .L93
	mov	r3, #256
	mov	r0, #3
	strh	r8, [r4]	@ movhi
	ldr	r2, .L93+4
	ldr	r1, .L93+8
	mov	lr, pc
	bx	r6
	ldr	r7, .L93+12
	mov	r0, #3
	ldr	r3, .L93+16
	ldr	r2, .L93+20
	ldr	r1, .L93+24
	mov	lr, pc
	bx	r6
	mov	r0, #3
	ldr	r3, .L93+28
	ldr	r2, .L93+32
	ldr	r1, .L93+36
	mov	lr, pc
	bx	r6
	mov	r3, r7
	mov	r0, #3
	ldr	r2, .L93+40
	ldr	r1, .L93+44
	mov	lr, pc
	bx	r6
	ldr	r2, .L93+48
	mov	r0, #3
	strh	r2, [r4, #8]	@ movhi
	ldr	r3, .L93+52
	ldr	r2, .L93+56
	ldr	r1, .L93+60
	mov	lr, pc
	bx	r6
	mov	r0, #3
	ldr	r3, .L93+64
	ldr	r2, .L93+68
	ldr	r1, .L93+72
	mov	lr, pc
	bx	r6
	ldr	r3, .L93+76
	ldr	r1, .L93+80
	ldr	r2, .L93+84
	strh	r3, [r4, #10]	@ movhi
	mov	r0, #3
	str	r5, [r1]
	str	r5, [r2]
	ldr	r3, .L93+88
	strh	r5, [r4, #20]	@ movhi
	mov	r2, #100663296
	ldr	r1, .L93+92
	strh	r5, [r4, #22]	@ movhi
	mov	lr, pc
	bx	r6
	mov	r0, #3
	ldr	r3, .L93+96
	ldr	r2, .L93+100
	ldr	r1, .L93+104
	mov	lr, pc
	bx	r6
	ldr	r3, .L93+108
	ldm	r3, {r0, r1, r2, r3}
	add	ip, r4, #32
	stm	ip, {r0, r1, r2, r3}
	ldr	r1, .L93+112
	ldr	r2, .L93+116
	ldr	r3, .L93+120
	strh	r1, [r4, #12]	@ movhi
	str	r5, [r2]
	str	r5, [r3]
	str	r5, [r4, #40]
	ldr	r3, [r3]
	lsl	r3, r3, #8
	str	r3, [r4, #44]
	ldr	r3, .L93+124
	mov	lr, pc
	bx	r3
	mov	r0, #3
	ldr	r1, .L93+128
	mov	r2, #117440512
	mov	r3, #512
	mov	lr, pc
	bx	r6
	ldr	r3, .L93+132
	mov	lr, pc
	bx	r3
	ldr	r3, .L93+136
	mov	lr, pc
	bx	r3
	ldr	r2, .L93+140
	ldr	r3, .L93+144
	strh	r8, [r7, #8]	@ movhi
	str	r2, [r3, #4092]
	bl	prepareWorldAnim
	ldr	r3, .L93+148
	mov	lr, pc
	bx	r3
	ldr	r2, .L93+152
	ldr	r3, .L93+156
	strh	r2, [r4]	@ movhi
	ldr	r0, .L93+160
	ldrh	r1, [r3, #48]
	ldr	r3, .L93+164
	ldr	r2, .L93+168
	strh	r5, [r0]	@ movhi
	str	r5, [r3]
	pop	{r4, r5, r6, r7, r8, lr}
	strh	r1, [r2]	@ movhi
	b	goToStart
.L94:
	.align	2
.L93:
	.word	DMANow
	.word	83886592
	.word	spritesheetPal
	.word	67109376
	.word	67117056
	.word	100728832
	.word	spritesheetTiles
	.word	67111824
	.word	100679680
	.word	splashscreenTiles
	.word	100694016
	.word	splashscreenMap
	.word	3972
	.word	67109344
	.word	100696064
	.word	world1parallaxTiles
	.word	67109888
	.word	100708352
	.word	world1parallaxMap
	.word	-26997
	.word	bg1xOff
	.word	bg1yOff
	.word	67109952
	.word	world1Tiles
	.word	67112960
	.word	100712448
	.word	world1Map
	.word	bg_aff_default
	.word	-1918
	.word	bg2xOff
	.word	bg2yOff
	.word	hideSprites
	.word	shadowOAM
	.word	setupSounds
	.word	setupSoundInterrupts
	.word	interruptHandler
	.word	50360320
	.word	waitForVBlank
	.word	5121
	.word	67109120
	.word	oldButtons
	.word	randTimer
	.word	buttons
	.size	initialize, .-initialize
	.align	2
	.global	pause
	.syntax unified
	.arm
	.fpu softvfp
	.type	pause, %function
pause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L107
	ldrh	r3, [r3]
	tst	r3, #4
	push	{r4, lr}
	beq	.L96
	ldr	r2, .L107+4
	ldrh	r2, [r2]
	tst	r2, #4
	beq	.L105
.L96:
	tst	r3, #8
	beq	.L97
	ldr	r3, .L107+4
	ldrh	r3, [r3]
	tst	r3, #8
	beq	.L106
.L97:
	ldr	r3, .L107+8
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L105:
	ldr	r3, .L107+12
	mov	lr, pc
	bx	r3
	ldr	r4, .L107+16
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L107+20
	mov	lr, pc
	bx	r4
	mov	r3, #67108864
	mov	r1, #2
	ldr	ip, .L107+24
	ldr	r0, .L107+28
	ldr	r2, .L107+32
	strh	ip, [r3, #10]	@ movhi
	strh	r0, [r3]	@ movhi
	str	r1, [r2]
	b	.L97
.L106:
	bl	initialize
	b	.L97
.L108:
	.align	2
.L107:
	.word	oldButtons
	.word	buttons
	.word	waitForVBlank
	.word	unpauseSound
	.word	DMANow
	.word	world1Pal
	.word	-26997
	.word	5633
	.word	state
	.size	pause, .-pause
	.align	2
	.global	win
	.syntax unified
	.arm
	.fpu softvfp
	.type	win, %function
win:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L116
	ldrh	r3, [r3]
	tst	r3, #8
	push	{r4, lr}
	beq	.L110
	ldr	r3, .L116+4
	ldrh	r3, [r3]
	tst	r3, #8
	beq	.L115
.L110:
	ldr	r3, .L116+8
	mov	lr, pc
	bx	r3
	pop	{r4, lr}
	bx	lr
.L115:
	bl	initialize
	b	.L110
.L117:
	.align	2
.L116:
	.word	oldButtons
	.word	buttons
	.word	waitForVBlank
	.size	win, .-win
	.align	2
	.global	lose
	.syntax unified
	.arm
	.fpu softvfp
	.type	lose, %function
lose:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	b	win
	.size	lose, .-lose
	.align	2
	.global	worldAnim
	.syntax unified
	.arm
	.fpu softvfp
	.type	worldAnim, %function
worldAnim:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r4, .L126
	ldr	r3, [r4, #8]
	cmp	r3, #30
	ldr	r3, [r4, #4]
	ble	.L120
	mov	r0, #0
	ldr	r1, .L126+4
	add	r2, r3, #1
	smull	ip, r3, r1, r2
	sub	r3, r3, r2, asr #31
	add	r3, r3, r3, lsl #1
	sub	r3, r2, r3
	str	r3, [r4, #4]
	str	r0, [r4, #8]
.L120:
	cmp	r3, #1
	beq	.L121
	cmp	r3, #2
	beq	.L122
	cmp	r3, #0
	beq	.L125
.L123:
	ldr	r3, [r4, #8]
	add	r3, r3, #1
	str	r3, [r4, #8]
	pop	{r4, r5, r6, lr}
	bx	lr
.L121:
	ldr	r5, .L126+8
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+16
	ldr	r1, .L126+20
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+24
	ldr	r1, .L126+28
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+32
	ldr	r1, .L126+36
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+40
	ldr	r1, .L126+44
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+48
	ldr	r1, .L126+52
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+56
	ldr	r1, .L126+60
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+64
	ldr	r1, .L126+68
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+72
	ldr	r1, .L126+76
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+80
	ldr	r1, .L126+84
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+88
	ldr	r1, .L126+92
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+96
	ldr	r1, .L126+100
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+104
	ldr	r1, .L126+108
	mov	lr, pc
	bx	r5
	b	.L123
.L125:
	ldr	r5, .L126+8
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+16
	ldr	r1, .L126+112
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+24
	ldr	r1, .L126+116
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+32
	ldr	r1, .L126+120
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+40
	ldr	r1, .L126+124
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+48
	ldr	r1, .L126+128
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+56
	ldr	r1, .L126+132
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+64
	ldr	r1, .L126+136
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+72
	ldr	r1, .L126+140
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+80
	ldr	r1, .L126+144
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+88
	ldr	r1, .L126+148
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+96
	ldr	r1, .L126+152
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+104
	ldr	r1, .L126+156
	mov	lr, pc
	bx	r5
	b	.L123
.L122:
	ldr	r5, .L126+8
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+16
	ldr	r1, .L126+160
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+24
	ldr	r1, .L126+164
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+32
	ldr	r1, .L126+168
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+40
	ldr	r1, .L126+172
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+48
	ldr	r1, .L126+176
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+56
	ldr	r1, .L126+180
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+64
	ldr	r1, .L126+184
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+72
	ldr	r1, .L126+188
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+80
	ldr	r1, .L126+192
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+88
	ldr	r1, .L126+196
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+96
	ldr	r1, .L126+200
	mov	lr, pc
	bx	r5
	mov	r0, #3
	ldr	r3, .L126+12
	ldr	r2, .L126+104
	ldr	r1, .L126+204
	mov	lr, pc
	bx	r5
	b	.L123
.L127:
	.align	2
.L126:
	.word	.LANCHOR0
	.word	1431655766
	.word	DMANow
	.word	67108880
	.word	100663744
	.word	100667520
	.word	100663424
	.word	100667264
	.word	100663488
	.word	100667008
	.word	100663680
	.word	100667136
	.word	100664128
	.word	100667392
	.word	100663552
	.word	100666880
	.word	100664192
	.word	100666688
	.word	100663616
	.word	100666560
	.word	100664704
	.word	100666432
	.word	100663808
	.word	100666304
	.word	100664640
	.word	100666176
	.word	100664064
	.word	100666048
	.word	100668416
	.word	100668480
	.word	100668544
	.word	100668608
	.word	100668672
	.word	100668736
	.word	100668800
	.word	100668864
	.word	100668928
	.word	100668992
	.word	100669056
	.word	100669120
	.word	100667584
	.word	100667328
	.word	100667072
	.word	100667200
	.word	100667456
	.word	100666944
	.word	100666752
	.word	100666624
	.word	100666496
	.word	100666368
	.word	100666240
	.word	100666112
	.size	worldAnim, .-worldAnim
	.align	2
	.global	start
	.syntax unified
	.arm
	.fpu softvfp
	.type	start, %function
start:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r4, .L140
	ldr	r3, [r4]
	add	r3, r3, #1
	str	r3, [r4]
	bl	worldAnim
	ldr	r3, .L140+4
	ldrh	r3, [r3]
	tst	r3, #4
	beq	.L129
	ldr	r2, .L140+8
	ldrh	r2, [r2]
	tst	r2, #4
	beq	.L138
.L129:
	tst	r3, #8
	beq	.L130
	ldr	r3, .L140+8
	ldrh	r5, [r3]
	ands	r5, r5, #8
	beq	.L139
.L130:
	ldr	r3, .L140+12
	mov	lr, pc
	bx	r3
	pop	{r4, r5, r6, lr}
	bx	lr
.L138:
	mov	r3, #67108864
	ldr	r2, .L140+16
	strh	r2, [r3]	@ movhi
	bl	goToInstructions
	b	.L130
.L139:
	mov	r6, #67108864
	ldr	r0, [r4]
	ldr	r3, .L140+20
	mov	lr, pc
	bx	r3
	ldr	r3, .L140+24
	mov	lr, pc
	bx	r3
	ldr	r3, .L140+28
	mov	lr, pc
	bx	r3
	ldr	r3, .L140+32
	ldr	ip, .L140+36
	ldr	r1, [r3]
	mov	r2, #1
	mov	r3, r5
	ldr	r0, .L140+40
	ldr	r4, .L140+44
	str	r5, [ip]
	mov	lr, pc
	bx	r4
	ldr	r2, .L140+48
	ldr	r3, .L140+52
	str	r5, [r2]
	str	r5, [r3]
	str	r5, [r6, #40]
	ldr	r3, [r3]
	ldr	r1, .L140+56
	ldr	r2, .L140+60
	lsl	r3, r3, #8
	str	r3, [r6, #44]
	mov	r0, #3
	str	r5, [r1]
	str	r5, [r2]
	mov	r3, #256
	mov	r2, #83886080
	strh	r5, [r6, #20]	@ movhi
	ldr	r1, .L140+64
	strh	r5, [r6, #22]	@ movhi
	ldr	r4, .L140+68
	mov	lr, pc
	bx	r4
	mov	r2, #2
	ldr	r0, .L140+72
	ldr	r1, .L140+16
	ldr	r3, .L140+76
	strh	r0, [r6, #10]	@ movhi
	strh	r1, [r6]	@ movhi
	str	r2, [r3]
	b	.L130
.L141:
	.align	2
.L140:
	.word	randTimer
	.word	oldButtons
	.word	buttons
	.word	waitForVBlank
	.word	5633
	.word	srand
	.word	initGame
	.word	initWorld
	.word	worldTheme_length
	.word	worldThemeCtr
	.word	worldTheme_data
	.word	playSoundA
	.word	bg2xOff
	.word	bg2yOff
	.word	bg1xOff
	.word	bg1yOff
	.word	world1Pal
	.word	DMANow
	.word	-26997
	.word	state
	.size	start, .-start
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.global	__aeabi_d2iz
	.align	2
	.global	game
	.syntax unified
	.arm
	.fpu softvfp
	.type	game, %function
game:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L160
	push	{r4, r5, r6, r7, r8, lr}
	mov	lr, pc
	bx	r3
	bl	worldAnim
	ldr	r3, .L160+4
	ldrh	r3, [r3]
	tst	r3, #4
	beq	.L143
	ldr	r3, .L160+8
	ldrh	r3, [r3]
	tst	r3, #4
	beq	.L156
.L143:
	ldr	r3, .L160+12
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L157
.L144:
	mov	r5, #67108864
	ldr	r3, .L160+16
	mov	lr, pc
	bx	r3
	ldr	r6, .L160+20
	mov	r3, #512
	mov	r2, #117440512
	mov	r0, #3
	ldr	r1, .L160+24
	mov	lr, pc
	bx	r6
	ldr	r1, .L160+28
	ldr	r3, [r1]
	lsl	r3, r3, #8
	str	r3, [r5, #40]
	ldr	r2, .L160+32
	ldr	r3, [r2]
	lsl	r3, r3, #8
	str	r3, [r5, #44]
	ldr	r3, [r1]
	cmp	r3, #0
	add	r4, r3, #3
	movlt	r3, r4
	ldr	r1, .L160+36
	asr	r4, r3, #2
	ldr	r0, [r2]
	ldr	r3, .L160+40
	str	r4, [r1]
	mov	lr, pc
	bx	r3
	ldr	r7, .L160+44
	mov	r2, #0
	ldr	r3, .L160+48
	mov	lr, pc
	bx	r7
	ldr	r3, .L160+52
	mov	lr, pc
	bx	r3
	ldr	r1, .L160+56
	lsl	r3, r4, #16
	str	r0, [r1]
	ldr	r1, .L160+60
	lsr	r3, r3, #16
	strh	r3, [r5, #20]	@ movhi
	ldr	r3, [r1]
	lsl	r2, r0, #16
	lsr	r2, r2, #16
	cmp	r3, #0
	strh	r2, [r5, #22]	@ movhi
	ble	.L158
.L145:
	ldr	r3, .L160+64
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L159
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L159:
	ldr	r3, .L160+68
	ldr	r2, .L160+72
	ldr	r1, [r3, #28]
	ldr	r3, .L160+76
	str	r1, [r2]
	mov	lr, pc
	bx	r3
	ldr	r3, .L160+80
	mov	lr, pc
	bx	r3
	mov	r3, #512
	mov	r2, #117440512
	mov	r0, #3
	ldr	r1, .L160+24
	mov	lr, pc
	bx	r6
	ldr	r3, .L160+84
	ldr	r3, [r3]
	ldr	r2, .L160+88
	add	r1, r3, r3, lsl #2
	add	r3, r3, r1, lsl #1
	add	r3, r2, r3, lsl #2
	ldr	r0, [r3, #40]
	ldr	r3, .L160+92
	mov	lr, pc
	bx	r3
	ldr	r3, .L160+96
	ldr	r3, [r3]
	cmp	r3, #0
	ldrne	r2, .L160+100
	ldreq	r2, .L160+104
	ldrne	r1, [r2]
	ldreq	r1, [r2]
	ldr	r4, .L160+108
	movne	r3, #0
	movne	r2, #1
	moveq	r2, #1
	ldrne	r0, .L160+112
	ldreq	r0, .L160+116
	mov	lr, pc
	bx	r4
	pop	{r4, r5, r6, r7, r8, lr}
	b	goToBattle
.L157:
	bl	goToWin
	b	.L144
.L158:
	bl	goToLose
	b	.L145
.L156:
	bl	goToPause
	b	.L143
.L161:
	.align	2
.L160:
	.word	updateWorld
	.word	oldButtons
	.word	buttons
	.word	gameVictory
	.word	waitForVBlank
	.word	DMANow
	.word	shadowOAM
	.word	bg2xOff
	.word	bg2yOff
	.word	bg1xOff
	.word	__aeabi_i2d
	.word	__aeabi_ddiv
	.word	1074003968
	.word	__aeabi_d2iz
	.word	bg1yOff
	.word	submarineHp
	.word	doBattle
	.word	soundA
	.word	worldThemeCtr
	.word	stopSound
	.word	hideSprites
	.word	opponentIdx
	.word	enemies
	.word	initBattle
	.word	bossBattle
	.word	bossTheme_length
	.word	battleTheme_length
	.word	playSoundA
	.word	bossTheme_data
	.word	battleTheme_data
	.size	game, .-game
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r7, fp, lr}
	ldr	r3, .L175
	mov	lr, pc
	bx	r3
	ldr	r3, .L175+4
	mov	lr, pc
	bx	r3
	ldr	r6, .L175+8
	ldr	r9, .L175+12
	ldr	r5, .L175+16
	ldr	fp, .L175+20
	ldr	r10, .L175+24
	ldr	r8, .L175+28
	ldr	r7, .L175+32
	ldr	r4, .L175+36
.L163:
	ldr	r2, [r6]
	ldrh	r3, [r9]
.L164:
	strh	r3, [r5]	@ movhi
	ldrh	r3, [r4, #48]
	strh	r3, [r9]	@ movhi
	cmp	r2, #6
	ldrls	pc, [pc, r2, asl #2]
	b	.L164
.L166:
	.word	.L171
	.word	.L170
	.word	.L169
	.word	.L168
	.word	.L167
	.word	.L165
	.word	.L165
.L165:
	mov	lr, pc
	bx	r7
	b	.L163
.L167:
	ldr	r3, .L175+40
	mov	lr, pc
	bx	r3
	b	.L163
.L168:
	ldr	r3, .L175+44
	mov	lr, pc
	bx	r3
	mov	lr, pc
	bx	r8
	b	.L163
.L169:
	ldr	r3, .L175+48
	mov	lr, pc
	bx	r3
	mov	lr, pc
	bx	r8
	b	.L163
.L170:
	mov	lr, pc
	bx	r10
	b	.L163
.L171:
	mov	lr, pc
	bx	fp
	b	.L163
.L176:
	.align	2
.L175:
	.word	mgba_open
	.word	initialize
	.word	state
	.word	buttons
	.word	oldButtons
	.word	start
	.word	instructions
	.word	lmao
	.word	win
	.word	67109120
	.word	pause
	.word	battle
	.word	game
	.size	main, .-main
	.comm	worldThemeCtr,4,4
	.comm	randTimer,4,4
	.comm	bg1yOff,4,4
	.comm	bg1xOff,4,4
	.comm	bg2yOff,4,4
	.comm	bg2xOff,4,4
	.comm	shadowOAM,1024,4
	.comm	oldButtons,2,2
	.comm	buttons,2,2
	.comm	state,4,4
	.comm	soundB,32,4
	.comm	soundA,32,4
	.comm	levels,5360,4
	.section	.rodata
	.align	2
	.set	.LANCHOR1,. + 0
	.type	konami.5706, %object
	.size	konami.5706, 44
konami.5706:
	.word	64
	.word	64
	.word	128
	.word	128
	.word	32
	.word	16
	.word	32
	.word	16
	.word	2
	.word	1
	.word	8
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	konamiIdx.5707, %object
	.size	konamiIdx.5707, 4
konamiIdx.5707:
	.space	4
	.type	aniFrame.5806, %object
	.size	aniFrame.5806, 4
aniFrame.5806:
	.space	4
	.type	frameCounter.5805, %object
	.size	frameCounter.5805, 4
frameCounter.5805:
	.space	4
	.ident	"GCC: (devkitARM release 53) 9.1.0"
