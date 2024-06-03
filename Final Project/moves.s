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
	.file	"moves.c"
	.text
	.global	MOVE_NONE
	.global	MOVE_BRUH
	.global	MOVE_DEATHRAY
	.global	MOVE_BLAST2
	.global	MOVE_BLAST1
	.global	MOVE_SHIELD2
	.global	MOVE_SHIELD1
	.global	MOVE_TORPEDO2
	.global	MOVE_TORPEDO1
	.global	MOVE_TRANSCEND
	.global	MOVE_DASH
	.global	MOVE_LHEALBURST
	.global	MOVE_SHEALBURST
	.global	MOVE_LHEAL
	.global	MOVE_SHEAL
	.global	MOVE_RESOLVE
	.global	MOVE_REGEN
	.global	MOVE_WAVE
	.global	MOVE_PUFFUP
	.global	MOVE_FLAIL
	.global	MOVE_SLASH
	.global	MOVE_STRIKE
	.global	MOVE_BITE
	.global	MOVE_NIBBLE
	.data
	.align	2
	.type	MOVE_BRUH, %object
	.size	MOVE_BRUH, 88
MOVE_BRUH:
	.ascii	"BRUH\000"
	.space	5
	.ascii	"*VINE BOOM SFX*\000"
	.space	45
	.space	1
	.word	30
	.word	1
	.word	0
	.word	0
	.type	MOVE_DEATHRAY, %object
	.size	MOVE_DEATHRAY, 88
MOVE_DEATHRAY:
	.ascii	"DEATHRAY\000"
	.space	1
	.ascii	"%s\012ANNIHILATED\012%s!\000"
	.space	42
	.space	1
	.word	99
	.word	0
	.word	0
	.word	0
	.type	MOVE_BLAST2, %object
	.size	MOVE_BLAST2, 88
MOVE_BLAST2:
	.ascii	"BLAST+\000"
	.space	3
	.ascii	"%s BLASTED\012THE ENEMY!\000"
	.space	39
	.space	1
	.word	5
	.word	1
	.word	0
	.word	0
	.type	MOVE_BLAST1, %object
	.size	MOVE_BLAST1, 88
MOVE_BLAST1:
	.ascii	"BLAST\000"
	.space	4
	.ascii	"%s BLASTED\012THE ENEMY!\000"
	.space	39
	.space	1
	.word	3
	.word	1
	.word	0
	.word	0
	.type	MOVE_SHIELD2, %object
	.size	MOVE_SHIELD2, 88
MOVE_SHIELD2:
	.ascii	"SHIELD+\000"
	.space	2
	.ascii	"%s SHIELDED\012%s!\000"
	.space	45
	.space	1
	.word	0
	.word	0
	.word	1
	.word	8
	.type	MOVE_SHIELD1, %object
	.size	MOVE_SHIELD1, 88
MOVE_SHIELD1:
	.ascii	"SHIELD\000"
	.space	3
	.ascii	"%s SHIELDED\012%s!\000"
	.space	45
	.space	1
	.word	0
	.word	0
	.word	1
	.word	4
	.type	MOVE_TORPEDO2, %object
	.size	MOVE_TORPEDO2, 88
MOVE_TORPEDO2:
	.ascii	"TORPEDO+\000"
	.space	1
	.ascii	"%s FIRED\012A TORPEDO AT\012%s!\000"
	.space	35
	.space	1
	.word	8
	.word	0
	.word	0
	.word	0
	.type	MOVE_TORPEDO1, %object
	.size	MOVE_TORPEDO1, 88
MOVE_TORPEDO1:
	.ascii	"TORPEDO\000"
	.space	2
	.ascii	"%s FIRED\012A TORPEDO AT\012%s!\000"
	.space	35
	.space	1
	.word	6
	.word	0
	.word	0
	.word	0
	.type	MOVE_TRANSCEND, %object
	.size	MOVE_TRANSCEND, 88
MOVE_TRANSCEND:
	.ascii	"TRANSCEND\000"
	.ascii	"%s TRANSCENDEDMORTALITY.\000"
	.space	36
	.space	1
	.word	0
	.word	0
	.word	1
	.word	0
	.type	MOVE_DASH, %object
	.size	MOVE_DASH, 88
MOVE_DASH:
	.ascii	"DASH\000"
	.space	5
	.ascii	"%s MOVED WITHINCREDIBLE SPEED!\012+1 TURN\000"
	.space	22
	.space	1
	.word	0
	.word	0
	.word	1
	.word	0
	.type	MOVE_LHEALBURST, %object
	.size	MOVE_LHEALBURST, 88
MOVE_LHEALBURST:
	.ascii	"L H BURST\000"
	.ascii	"%s HEALED\012THEIR ALLIES!\000"
	.space	37
	.space	1
	.word	0
	.word	1
	.word	1
	.word	5
	.type	MOVE_SHEALBURST, %object
	.size	MOVE_SHEALBURST, 88
MOVE_SHEALBURST:
	.ascii	"S H BURST\000"
	.ascii	"%s HEALED\012THEIR ALLIES!\000"
	.space	37
	.space	1
	.word	0
	.word	1
	.word	1
	.word	3
	.type	MOVE_LHEAL, %object
	.size	MOVE_LHEAL, 88
MOVE_LHEAL:
	.ascii	"L HEAL\000"
	.space	3
	.ascii	"%s HEALED %s!\000"
	.space	47
	.space	1
	.word	0
	.word	0
	.word	1
	.word	6
	.type	MOVE_SHEAL, %object
	.size	MOVE_SHEAL, 88
MOVE_SHEAL:
	.ascii	"S HEAL\000"
	.space	3
	.ascii	"%s HEALED %s!\000"
	.space	47
	.space	1
	.word	0
	.word	0
	.word	1
	.word	4
	.type	MOVE_RESOLVE, %object
	.size	MOVE_RESOLVE, 88
MOVE_RESOLVE:
	.ascii	"RESOLVE\000"
	.space	2
	.ascii	"%s\012RESOLVED TO WIN!\000"
	.space	41
	.space	1
	.word	0
	.word	0
	.word	1
	.word	8
	.type	MOVE_REGEN, %object
	.size	MOVE_REGEN, 88
MOVE_REGEN:
	.ascii	"REGEN\000"
	.space	4
	.ascii	"%s\012REGENERATED!\000"
	.space	45
	.space	1
	.word	0
	.word	0
	.word	1
	.word	4
	.type	MOVE_WAVE, %object
	.size	MOVE_WAVE, 88
MOVE_WAVE:
	.ascii	"TIDE WAVE\000"
	.ascii	"%s CREATED\012A TIDAL WAVE!\000"
	.space	36
	.space	1
	.word	6
	.word	1
	.word	0
	.word	0
	.type	MOVE_PUFFUP, %object
	.size	MOVE_PUFFUP, 88
MOVE_PUFFUP:
	.ascii	"PUFF UP\000"
	.space	2
	.ascii	"%s PUFFED UP!\000"
	.space	47
	.space	1
	.word	5
	.word	1
	.word	0
	.word	0
	.type	MOVE_FLAIL, %object
	.size	MOVE_FLAIL, 88
MOVE_FLAIL:
	.ascii	"FLAIL\000"
	.space	4
	.ascii	"%s FLAILED\012AROUND!\000"
	.space	42
	.space	1
	.word	3
	.word	1
	.word	0
	.word	0
	.type	MOVE_SLASH, %object
	.size	MOVE_SLASH, 88
MOVE_SLASH:
	.ascii	"SLASH\000"
	.space	4
	.ascii	"%s SLASHED\012%s!\000"
	.space	46
	.space	1
	.word	8
	.word	0
	.word	0
	.word	0
	.type	MOVE_STRIKE, %object
	.size	MOVE_STRIKE, 88
MOVE_STRIKE:
	.ascii	"STRIKE\000"
	.space	3
	.ascii	"%s STRUCK\012%s!\000"
	.space	47
	.space	1
	.word	8
	.word	0
	.word	0
	.word	0
	.type	MOVE_BITE, %object
	.size	MOVE_BITE, 88
MOVE_BITE:
	.ascii	"BITE\000"
	.space	5
	.ascii	"%s BIT\012INTO %s!\000"
	.space	45
	.space	1
	.word	6
	.word	0
	.word	0
	.word	0
	.type	MOVE_NIBBLE, %object
	.size	MOVE_NIBBLE, 88
MOVE_NIBBLE:
	.ascii	"NIBBLE\000"
	.space	3
	.ascii	"%s NIBBLED\012ON %s!\000"
	.space	43
	.space	1
	.word	4
	.word	0
	.word	0
	.word	0
	.bss
	.align	2
	.type	MOVE_NONE, %object
	.size	MOVE_NONE, 88
MOVE_NONE:
	.space	88
	.ident	"GCC: (devkitARM release 53) 9.1.0"
