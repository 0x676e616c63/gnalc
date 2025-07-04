.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#21264
    movk	fp,	#7,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w24,	#28928
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w24,	#2,	lsl #16
    mov	x2,	x24
    bl	memset
    mov	x2,	x24
    movz	w1,	#0
    movz	fp,	#28944
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    mov	x2,	x24
    movz	w1,	#0
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w20,	#0

main_5:
    cmp	w20,	#200
    blt	main_8

main_14:
    movz	w0,	#23
    bl	_sysy_starttime
    movz	w26,	#0

main_16:
    movz	w4,	#800
    movz	fp,	#28944
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    mul	w20,	w26,	w4
    mov	x4,	x20
    add	x4,	sp,	x4
    add	x4,	x4,	fp

main_19:
    cmp	w28,	#200
    blt	main_22

main_63:
    add	w26,	w26,	#1
    cmp	w26,	#200
    blt	main_16

main_66:
    movz	w20,	#0

main_68:
    movz	w6,	#800
    movz	fp,	#57872
    movz	w5,	#800
    movz	w21,	#0
    mul	w26,	w20,	w6
    movk	fp,	#4,	lsl #16
    mul	w22,	w20,	w5
    mov	x23,	x26
    mov	x25,	x22
    add	x23,	sp,	x23
    add	x25,	sp,	x25
    add	x23,	x23,	fp
    add	x25,	x25,	#16

main_73:
    movz	w2,	#0
    movz	w26,	#0

main_75:
    cmp	w2,	#200
    blt	main_79

main_168:
    lsl	w18,	w21,	#2
    add	w21,	w21,	#1
    add	x17,	x25,	x18
    str	w26,	[x17]

    cmp	w21,	#200
    blt	main_73

main_172:
    add	w20,	w20,	#1
    cmp	w20,	#200
    blt	main_68

main_175:
    movz	w12,	#0

main_177:
    movz	w8,	#800
    movz	w14,	#0
    movz	w6,	#65535
    mul	w8,	w12,	w8
    movk	w6,	#32767,	lsl #16
    mov	x23,	x8
    add	x23,	sp,	x23
    add	x23,	x23,	#16

main_180:
    cmp	w14,	#200
    blt	main_184

main_225:
    movz	w8,	#0

main_226:
    cmp	w8,	#200
    blt	main_229

main_246:
    add	w12,	w12,	#1
    cmp	w12,	#200
    blt	main_177

main_249:
    movz	w17,	#0

main_251:
    movz	w9,	#800
    movz	w22,	#0
    mul	w14,	w17,	w9
    mov	x10,	x14
    add	x10,	sp,	x10
    add	x10,	x10,	#16

main_254:
    cmp	w22,	#200
    blt	main_257

main_306:
    add	w17,	w17,	#1
    cmp	w17,	#200
    blt	main_251

main_309:
    movz	w4,	#0
    movz	w27,	#0

main_311:
    movz	w20,	#800
    movz	w21,	#0
    mul	w15,	w4,	w20
    mov	x0,	x15
    add	x0,	sp,	x0
    add	x0,	x0,	#16

main_315:
    cmp	w21,	#200
    blt	main_319

main_352:
    add	w4,	w4,	#1
    cmp	w4,	#200
    blt	main_311

main_355:
    movz	w0,	#93
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#0
    b	main_357

main_319:
    lsl	w13,	w21,	#2
    add	x12,	x0,	x13
    add	w13,	w21,	#1
    ldr	w14,	[x12]

    add	w21,	w13,	#1
    lsl	w26,	w13,	#2
    add	w22,	w14,	w27
    add	x25,	x0,	x26
    lsl	w3,	w21,	#2
    ldr	w27,	[x25]

    add	x2,	x0,	x3
    add	w20,	w27,	w22
    add	w27,	w21,	#1
    ldr	w5,	[x2]

    add	w25,	w5,	w20
    lsl	w9,	w27,	#2
    add	w5,	w27,	#1
    add	x8,	x0,	x9
    lsl	w14,	w5,	#2
    ldr	w10,	[x8]

    add	x13,	x0,	x14
    add	w3,	w10,	w25
    add	w10,	w5,	#1
    ldr	w15,	[x13]

    add	w9,	w15,	w3
    lsl	w19,	w10,	#2
    add	w15,	w10,	#1
    add	x18,	x0,	x19
    add	w22,	w15,	#1
    lsl	w24,	w15,	#2
    ldr	w20,	[x18]

    add	x23,	x0,	x24
    lsl	w1,	w22,	#2
    add	w14,	w20,	w9
    ldr	w25,	[x23]

    add	x28,	x0,	x1
    add	w21,	w25,	w14
    ldr	w2,	[x28]

    add	w27,	w2,	w21
    add	w21,	w22,	#1
    b	main_315

main_257:
    lsl	w23,	w22,	#2
    movz	w15,	#800
    lsl	w27,	w17,	#2
    movz	w13,	#0
    add	w24,	w22,	#1
    movz	w11,	#800
    movz	w9,	#0
    movz	w7,	#800
    movz	w5,	#0
    movz	w3,	#800
    movz	w1,	#0
    add	x20,	x10,	x23
    mul	w25,	w22,	w15
    mul	w18,	w24,	w11
    lsl	w15,	w24,	#2
    mov	x2,	x25
    mov	x4,	x18
    add	x2,	sp,	x2
    add	x28,	x10,	x15
    add	x4,	sp,	x4
    add	x2,	x2,	#16
    add	x4,	x4,	#16
    add	x26,	x2,	x27
    ldr	w6,	[x26]

    movz	w26,	#0
    sub	w0,	w13,	w6
    str	w0,	[x20]

    lsl	w0,	w17,	#2
    lsl	w20,	w17,	#2
    add	x19,	x4,	x20
    movz	w4,	#800
    ldr	w8,	[x19]

    sub	w22,	w9,	w8
    add	w9,	w24,	#1
    str	w22,	[x28]

    add	w24,	w9,	#1
    mul	w27,	w9,	w7
    lsl	w25,	w9,	#2
    mov	x15,	x27
    lsl	w9,	w17,	#2
    add	x15,	sp,	x15
    mul	w7,	w24,	w3
    add	x13,	x10,	x25
    mov	x25,	x7
    add	x15,	x15,	#16
    add	w7,	w24,	#1
    add	x25,	sp,	x25
    add	x28,	x15,	x0
    add	w21,	w7,	#1
    add	x25,	x25,	#16
    lsl	w15,	w7,	#2
    ldr	w20,	[x28]

    add	x8,	x25,	x9
    movz	w28,	#800
    sub	w2,	w5,	w20
    lsl	w25,	w21,	#2
    mul	w18,	w7,	w28
    lsl	w20,	w17,	#2
    lsl	w5,	w24,	#2
    add	x23,	x10,	x25
    str	w2,	[x13]

    movz	w24,	#800
    add	x27,	x10,	x5
    ldr	w0,	[x8]

    mov	x5,	x18
    add	x8,	x10,	x15
    sub	w12,	w1,	w0
    movz	w18,	#0
    add	x5,	sp,	x5
    add	w15,	w21,	#1
    lsl	w0,	w17,	#2
    str	w12,	[x27]

    add	x5,	x5,	#16
    mul	w27,	w21,	w24
    mov	x16,	x27
    add	x16,	sp,	x16
    add	x19,	x5,	x20
    lsl	w5,	w15,	#2
    add	x16,	x16,	#16
    ldr	w9,	[x19]

    add	x11,	x10,	x5
    sub	w22,	w26,	w9
    add	x28,	x16,	x0
    lsl	w9,	w17,	#2
    str	w22,	[x8]

    movz	w22,	#0
    ldr	w20,	[x28]

    add	w28,	w15,	#1
    sub	w2,	w22,	w20
    movz	w20,	#800
    str	w2,	[x23]

    mul	w7,	w15,	w20
    movz	w2,	#0
    lsl	w20,	w17,	#2
    lsl	w15,	w28,	#2
    mov	x26,	x7
    add	x26,	sp,	x26
    add	x25,	x10,	x15
    add	x26,	x26,	#16
    add	x8,	x26,	x9
    ldr	w1,	[x8]

    sub	w12,	w18,	w1
    mul	w18,	w28,	w4
    mov	x6,	x18
    str	w12,	[x11]

    add	x6,	sp,	x6
    add	x6,	x6,	#16
    add	x19,	x6,	x20
    ldr	w12,	[x19]

    sub	w22,	w2,	w12
    str	w22,	[x25]

    add	w22,	w28,	#1
    b	main_254

main_229:
    lsl	w27,	w8,	#2
    add	w10,	w8,	#1
    add	x26,	x23,	x27
    add	w14,	w10,	#1
    lsl	w19,	w10,	#2
    str	w6,	[x26]

    add	x18,	x23,	x19
    add	w17,	w14,	#1
    lsl	w22,	w14,	#2
    str	w6,	[x18]

    add	x21,	x23,	x22
    lsl	w26,	w17,	#2
    str	w6,	[x21]

    add	x25,	x23,	x26
    add	w21,	w17,	#1
    str	w6,	[x25]

    add	w26,	w21,	#1
    lsl	w0,	w21,	#2
    add	x28,	x23,	x0
    lsl	w3,	w26,	#2
    add	w0,	w26,	#1
    str	w6,	[x28]

    add	x2,	x23,	x3
    lsl	w7,	w0,	#2
    add	w3,	w0,	#1
    str	w6,	[x2]

    add	x5,	x23,	x7
    add	w8,	w3,	#1
    lsl	w10,	w3,	#2
    str	w6,	[x5]

    add	x9,	x23,	x10
    str	w6,	[x9]

    b	main_226

main_184:
    lsl	w26,	w14,	#2
    add	x25,	x23,	x26
    ldr	w27,	[x25]

    cmp	w27,	w6
    csel	w2,	w27,	w6,	lt
    add	w11,	w14,	#1
    lsl	w28,	w11,	#2
    add	x27,	x23,	x28
    ldr	w0,	[x27]

    cmp	w0,	w2
    csel	w19,	w0,	w2,	lt
    add	w20,	w11,	#1
    lsl	w5,	w20,	#2
    add	x4,	x23,	x5
    ldr	w6,	[x4]

    cmp	w6,	w19
    add	w28,	w20,	#1
    csel	w26,	w6,	w19,	lt
    lsl	w11,	w28,	#2
    add	x10,	x23,	x11
    ldr	w13,	[x10]

    cmp	w13,	w26
    add	w5,	w28,	#1
    csel	w4,	w13,	w26,	lt
    lsl	w18,	w5,	#2
    add	x17,	x23,	x18
    ldr	w19,	[x17]

    cmp	w19,	w4
    add	w11,	w5,	#1
    csel	w10,	w19,	w4,	lt
    lsl	w25,	w11,	#2
    add	x24,	x23,	x25
    ldr	w26,	[x24]

    cmp	w26,	w10
    add	w21,	w11,	#1
    csel	w20,	w26,	w10,	lt
    lsl	w2,	w21,	#2
    add	x1,	x23,	x2
    ldr	w3,	[x1]

    cmp	w3,	w20
    add	w0,	w21,	#1
    csel	w28,	w3,	w20,	lt
    lsl	w8,	w0,	#2
    add	x7,	x23,	x8
    ldr	w9,	[x7]

    cmp	w9,	w28
    add	w14,	w0,	#1
    csel	w6,	w9,	w28,	lt
    b	main_180

main_79:
    lsl	w9,	w2,	#2
    movz	w13,	#800
    movz	fp,	#28944
    lsl	w14,	w21,	#2
    add	x8,	x23,	x9
    mul	w12,	w2,	w13
    movk	fp,	#2,	lsl #16
    mov	x5,	x12
    add	x5,	sp,	x5
    ldr	w17,	[x8]

    add	x5,	x5,	fp
    add	x13,	x5,	x14
    ldr	w3,	[x13]

    mul	w8,	w3,	w17
    madd	w18,	w3,	w17,	w26

    asr	w22,	w8,	#31
    lsr	w24,	w22,	#31
    madd	w27,	w3,	w17,	w24

    asr	w22,	w27,	#1
    lsl	w24,	w22,	#1
    sub	w11,	w8,	w24
    cmp	w11,	#0
    lsl	w14,	w21,	#2
    movz	fp,	#28944
    add	w22,	w2,	#1
    csel	w10,	w18,	w26,	eq
    movk	fp,	#2,	lsl #16
    lsl	w9,	w22,	#2
    add	x8,	x23,	x9
    ldr	w28,	[x8]

    movz	w8,	#800
    mul	w12,	w22,	w8
    mov	x0,	x12
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    add	x13,	x0,	x14
    ldr	w9,	[x13]

    madd	w18,	w9,	w28,	w10

    mul	w1,	w9,	w28
    asr	w6,	w1,	#31
    lsr	w7,	w6,	#31
    madd	w8,	w9,	w28,	w7

    asr	w2,	w8,	#1
    lsl	w3,	w2,	#1
    sub	w6,	w1,	w3
    cmp	w6,	#0
    movz	fp,	#28944
    movz	w3,	#800
    add	w19,	w22,	#1
    csel	w12,	w18,	w10,	eq
    movk	fp,	#2,	lsl #16
    mul	w1,	w19,	w3
    lsl	w27,	w19,	#2
    lsl	w3,	w21,	#2
    mov	x15,	x1
    add	x26,	x23,	x27
    add	x15,	sp,	x15
    ldr	w28,	[x26]

    add	x15,	x15,	fp
    add	x2,	x15,	x3
    ldr	w15,	[x2]

    madd	w7,	w15,	w28,	w12

    mul	w18,	w15,	w28
    asr	w9,	w18,	#31
    lsr	w10,	w9,	#31
    madd	w11,	w15,	w28,	w10

    asr	w26,	w11,	#1
    lsl	w27,	w26,	#1
    sub	w24,	w18,	w27
    cmp	w24,	#0
    movz	w27,	#800
    csel	w26,	w7,	w12,	eq
    add	w0,	w19,	#1
    movz	fp,	#28944
    lsl	w17,	w21,	#2
    movk	fp,	#2,	lsl #16
    mul	w15,	w0,	w27
    lsl	w12,	w0,	#2
    mov	x4,	x15
    add	x11,	x23,	x12
    add	x4,	sp,	x4
    ldr	w28,	[x11]

    add	x4,	x4,	fp
    add	x16,	x4,	x17
    ldr	w8,	[x16]

    madd	w24,	w8,	w28,	w26

    mul	w9,	w8,	w28
    asr	w12,	w9,	#31
    lsr	w13,	w12,	#31
    madd	w14,	w8,	w28,	w13

    asr	w17,	w14,	#1
    lsl	w18,	w17,	#1
    sub	w10,	w9,	w18
    cmp	w10,	#0
    movz	w22,	#800
    csel	w11,	w24,	w26,	eq
    add	w7,	w0,	#1
    movz	fp,	#28944
    lsl	w6,	w21,	#2
    movk	fp,	#2,	lsl #16
    mul	w4,	w7,	w22
    lsl	w1,	w7,	#2
    mov	x19,	x4
    add	x0,	x23,	x1
    add	x19,	sp,	x19
    ldr	w1,	[x0]

    add	x19,	x19,	fp
    add	x5,	x19,	x6
    ldr	w6,	[x5]

    madd	w10,	w6,	w1,	w11

    mul	w3,	w6,	w1
    asr	w15,	w3,	#31
    lsr	w16,	w15,	#31
    madd	w17,	w6,	w1,	w16

    asr	w12,	w17,	#1
    lsl	w13,	w12,	#1
    sub	w0,	w3,	w13
    cmp	w0,	#0
    csel	w4,	w10,	w11,	eq
    add	w5,	w7,	#1
    lsl	w22,	w21,	#2
    movz	w17,	#800
    movz	fp,	#28944
    lsl	w15,	w5,	#2
    mul	w18,	w5,	w17
    movk	fp,	#2,	lsl #16
    mov	x8,	x18
    add	x14,	x23,	x15
    add	x8,	sp,	x8
    ldr	w10,	[x14]

    add	x8,	x8,	fp
    add	x19,	x8,	x22
    ldr	w0,	[x19]

    madd	w28,	w0,	w10,	w4

    mul	w26,	w0,	w10
    asr	w18,	w26,	#31
    lsr	w19,	w18,	#31
    madd	w22,	w0,	w10,	w19

    asr	w7,	w22,	#1
    lsl	w8,	w7,	#1
    sub	w14,	w26,	w8
    cmp	w14,	#0
    csel	w16,	w28,	w4,	eq
    add	w15,	w5,	#1
    movz	w12,	#800
    movz	fp,	#28944
    lsl	w9,	w21,	#2
    movk	fp,	#2,	lsl #16
    lsl	w4,	w15,	#2
    mul	w7,	w15,	w12
    mov	x27,	x7
    add	x3,	x23,	x4
    add	x27,	sp,	x27
    ldr	w5,	[x3]

    add	x27,	x27,	fp
    add	x8,	x27,	x9
    ldr	w18,	[x8]

    mul	w13,	w18,	w5
    asr	w24,	w13,	#31
    lsr	w26,	w24,	#31
    madd	w27,	w18,	w5,	w26

    asr	w2,	w27,	#1
    lsl	w3,	w2,	#1
    sub	w4,	w13,	w3
    madd	w13,	w18,	w5,	w16

    cmp	w4,	#0
    csel	w9,	w13,	w16,	eq
    movz	fp,	#28944
    movz	w7,	#800
    lsl	w27,	w21,	#2
    add	w16,	w15,	#1
    movk	fp,	#2,	lsl #16
    mul	w24,	w16,	w7
    lsl	w18,	w16,	#2
    mov	x12,	x24
    add	x17,	x23,	x18
    add	x12,	sp,	x12
    ldr	w22,	[x17]

    add	x12,	x12,	fp
    add	x26,	x12,	x27
    ldr	w13,	[x26]

    madd	w2,	w13,	w22,	w9

    mul	w7,	w13,	w22
    asr	w28,	w7,	#31
    lsr	w0,	w28,	#31
    madd	w1,	w13,	w22,	w0

    asr	w26,	w1,	#1
    lsl	w27,	w26,	#1
    sub	w19,	w7,	w27
    cmp	w19,	#0
    csel	w26,	w2,	w9,	eq
    add	w2,	w16,	#1
    b	main_75

main_22:
    lsl	w17,	w28,	#2
    movz	w8,	#800
    movz	fp,	#57872
    lsl	w21,	w26,	#2
    add	w24,	w28,	#1
    movz	w5,	#800
    lsl	w3,	w26,	#2
    lsl	w12,	w26,	#2
    movz	w25,	#800
    lsl	w0,	w26,	#2
    add	x14,	x4,	x17
    mul	w19,	w28,	w8
    movk	fp,	#4,	lsl #16
    mul	w1,	w24,	w5
    lsl	w28,	w24,	#2
    mov	x9,	x19
    add	x9,	sp,	x9
    add	x16,	x4,	x28
    mov	x28,	x1
    add	x9,	x9,	fp
    add	x28,	sp,	x28
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x20,	x9,	x21
    add	x28,	x28,	fp
    movz	fp,	#57872
    ldr	w22,	[x20]

    movk	fp,	#4,	lsl #16
    add	x2,	x28,	x3
    lsl	w20,	w26,	#2
    str	w22,	[x14]

    movz	w28,	#800
    add	w14,	w24,	#1
    movz	w22,	#800
    ldr	w5,	[x2]

    movz	w2,	#800
    str	w5,	[x16]

    add	w17,	w14,	#1
    lsl	w8,	w14,	#2
    mul	w10,	w14,	w2
    add	x9,	x4,	x8
    add	w5,	w17,	#1
    mul	w18,	w17,	w28
    lsl	w16,	w17,	#2
    mov	x8,	x10
    lsl	w17,	w26,	#2
    add	x8,	sp,	x8
    mul	w27,	w5,	w25
    lsl	w24,	w5,	#2
    add	x15,	x4,	x16
    mov	x25,	x27
    add	x8,	x8,	fp
    mov	x16,	x18
    add	x25,	sp,	x25
    movz	fp,	#57872
    add	x16,	sp,	x16
    movk	fp,	#4,	lsl #16
    add	x11,	x8,	x12
    add	x16,	x16,	fp
    ldr	w13,	[x11]

    movz	fp,	#57872
    str	w13,	[x9]

    movk	fp,	#4,	lsl #16
    add	x19,	x16,	x20
    lsl	w9,	w26,	#2
    add	x25,	x25,	fp
    add	x16,	x4,	x24
    movz	fp,	#57872
    ldr	w21,	[x19]

    movk	fp,	#4,	lsl #16
    add	x28,	x25,	x0
    movz	w19,	#800
    str	w21,	[x15]

    lsl	w25,	w26,	#2
    add	w0,	w5,	#1
    ldr	w1,	[x28]

    str	w1,	[x16]

    mul	w7,	w0,	w22
    lsl	w5,	w0,	#2
    mov	x6,	x7
    add	x15,	x4,	x5
    add	x6,	sp,	x6
    add	x6,	x6,	fp
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x8,	x6,	x9
    add	w9,	w0,	#1
    ldr	w10,	[x8]

    lsl	w13,	w9,	#2
    str	w10,	[x15]

    mul	w15,	w9,	w19
    add	x24,	x4,	x13
    add	w19,	w9,	#1
    mov	x14,	x15
    add	x14,	sp,	x14
    add	w28,	w19,	#1
    lsl	w21,	w19,	#2
    add	x14,	x14,	fp
    add	x5,	x4,	x21
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x16,	x14,	x17
    ldr	w18,	[x16]

    movz	w16,	#800
    str	w18,	[x24]

    mul	w23,	w19,	w16
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    add	x24,	x22,	x25
    ldr	w27,	[x24]

    str	w27,	[x5]

    b	main_19

main_8:
    movz	w28,	#800
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    mul	w19,	w20,	w28
    mov	x0,	x19
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#200
    beq	main_5

main_357:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#21264
    movk	fp,	#7,	lsl #16
    add	sp, sp, fp
    ret


