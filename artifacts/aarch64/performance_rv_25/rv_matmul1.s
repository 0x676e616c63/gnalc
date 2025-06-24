.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
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
    movz	w1,	#0
    mov	x2,	x24
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w20,	#0

main_5:
    cmp	w20,	#200
    bge	main_14

main_8:
    movz	w19,	#800
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    mul	w24,	w20,	w19
    mov	x0,	x24
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#200
    bne	main_357
    b	main_5

main_14:
    movz	w0,	#23
    bl	_sysy_starttime
    movz	w7,	#0

main_16:
    movz	w5,	#800
    movz	fp,	#28944
    movz	w22,	#0
    movk	fp,	#2,	lsl #16
    mul	w27,	w7,	w5
    mov	x1,	x27
    add	x1,	sp,	x1
    add	x1,	x1,	fp

main_19:
    cmp	w22,	#200
    bge	main_63

main_22:
    lsl	w11,	w22,	#2
    movz	w0,	#800
    movz	fp,	#57872
    lsl	w15,	w7,	#2
    movz	w26,	#800
    lsl	w10,	w7,	#2
    movz	w23,	#800
    lsl	w18,	w7,	#2
    lsl	w6,	w7,	#2
    lsl	w3,	w7,	#2
    add	x20,	x1,	x11
    mul	w13,	w22,	w0
    movk	fp,	#4,	lsl #16
    mov	x17,	x13
    add	x17,	sp,	x17
    add	x17,	x17,	fp
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x14,	x17,	x15
    lsl	w15,	w7,	#2
    add	w17,	w22,	#1
    ldr	w16,	[x14]

    add	w28,	w17,	#1
    mul	w8,	w17,	w26
    lsl	w5,	w17,	#2
    str	w16,	[x20]

    lsl	w26,	w7,	#2
    mov	x21,	x8
    lsl	w14,	w28,	#2
    add	x22,	x1,	x5
    movz	w20,	#800
    mul	w16,	w28,	w23
    add	x21,	sp,	x21
    add	x4,	x1,	x14
    lsl	w23,	w7,	#2
    mov	x0,	x16
    movz	w14,	#800
    add	x0,	sp,	x0
    add	x21,	x21,	fp
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x9,	x21,	x10
    add	x0,	x0,	fp
    movz	fp,	#57872
    ldr	w11,	[x9]

    movk	fp,	#4,	lsl #16
    add	x17,	x0,	x18
    add	w9,	w28,	#1
    str	w11,	[x22]

    mul	w24,	w9,	w20
    lsl	w22,	w9,	#2
    ldr	w19,	[x17]

    mov	x10,	x24
    add	x13,	x1,	x22
    movz	w17,	#800
    str	w19,	[x4]

    add	w24,	w9,	#1
    add	x10,	sp,	x10
    mul	w4,	w24,	w17
    lsl	w2,	w24,	#2
    add	x10,	x10,	fp
    mov	x19,	x4
    movz	fp,	#57872
    add	x19,	sp,	x19
    movk	fp,	#4,	lsl #16
    add	x25,	x10,	x26
    add	x19,	x19,	fp
    add	x26,	x1,	x2
    movz	fp,	#57872
    ldr	w27,	[x25]

    movk	fp,	#4,	lsl #16
    add	x5,	x19,	x6
    str	w27,	[x13]

    add	w19,	w24,	#1
    ldr	w8,	[x5]

    mul	w13,	w19,	w14
    lsl	w11,	w19,	#2
    str	w8,	[x26]

    mov	x27,	x13
    add	x12,	x1,	x11
    add	x27,	sp,	x27
    movz	w11,	#800
    add	x27,	x27,	fp
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x14,	x27,	x15
    ldr	w16,	[x14]

    str	w16,	[x12]

    add	w16,	w19,	#1
    add	w9,	w16,	#1
    mul	w21,	w16,	w11
    lsl	w19,	w16,	#2
    mov	x8,	x21
    add	x8,	sp,	x8
    lsl	w27,	w9,	#2
    add	x17,	x1,	x19
    add	x8,	x8,	fp
    add	x5,	x1,	x27
    movz	fp,	#57872
    movk	fp,	#4,	lsl #16
    add	x22,	x8,	x23
    movz	w8,	#800
    ldr	w24,	[x22]

    mul	w0,	w9,	w8
    add	w22,	w9,	#1
    str	w24,	[x17]

    mov	x17,	x0
    add	x17,	sp,	x17
    add	x17,	x17,	fp
    add	x2,	x17,	x3
    ldr	w4,	[x2]

    str	w4,	[x5]

    b	main_19

main_63:
    add	w7,	w7,	#1
    cmp	w7,	#200
    blt	main_16

main_66:
    movz	w0,	#0

main_68:
    movz	w4,	#800
    movz	fp,	#57872
    movz	w3,	#800
    movz	w10,	#0
    mul	w12,	w0,	w4
    movk	fp,	#4,	lsl #16
    mov	x5,	x12
    mul	w12,	w0,	w3
    add	x5,	sp,	x5
    mov	x8,	x12
    add	x8,	sp,	x8
    add	x5,	x5,	fp
    add	x8,	x8,	#16

main_73:
    movz	w9,	#0
    movz	w15,	#0

main_75:
    cmp	w9,	#200
    bge	main_168

main_79:
    lsl	w16,	w9,	#2
    movz	w27,	#800
    movz	fp,	#28944
    lsl	w21,	w10,	#2
    add	x14,	x5,	x16
    mul	w19,	w9,	w27
    movk	fp,	#2,	lsl #16
    mov	x1,	x19
    add	x1,	sp,	x1
    ldr	w7,	[x14]

    add	x1,	x1,	fp
    add	x20,	x1,	x21
    ldr	w4,	[x20]

    mul	w19,	w4,	w7
    asr	w25,	w19,	#31
    lsr	w26,	w25,	#31
    madd	w25,	w4,	w7,	w15

    madd	w27,	w4,	w7,	w26

    asr	w11,	w27,	#1
    lsl	w12,	w11,	#1
    sub	w11,	w19,	w12
    cmp	w11,	#0
    lsl	w4,	w10,	#2
    movz	w22,	#800
    movz	fp,	#28944
    csel	w16,	w25,	w15,	eq
    movk	fp,	#2,	lsl #16
    add	w25,	w9,	#1
    mul	w2,	w25,	w22
    lsl	w27,	w25,	#2
    mov	x13,	x2
    add	x26,	x5,	x27
    add	x13,	sp,	x13
    ldr	w24,	[x26]

    add	x13,	x13,	fp
    add	x3,	x13,	x4
    ldr	w14,	[x3]

    mul	w7,	w14,	w24
    asr	w9,	w7,	#31
    lsr	w11,	w9,	#31
    madd	w12,	w14,	w24,	w11

    madd	w11,	w14,	w24,	w16

    asr	w20,	w12,	#1
    lsl	w21,	w20,	#1
    sub	w19,	w7,	w21
    cmp	w19,	#0
    lsl	w21,	w10,	#2
    movz	fp,	#28944
    add	w3,	w25,	#1
    csel	w2,	w11,	w16,	eq
    movz	w17,	#800
    movk	fp,	#2,	lsl #16
    lsl	w16,	w3,	#2
    mul	w19,	w3,	w17
    mov	x27,	x19
    add	x15,	x5,	x16
    add	x27,	sp,	x27
    ldr	w4,	[x15]

    add	x27,	x27,	fp
    add	x20,	x27,	x21
    ldr	w24,	[x20]

    madd	w25,	w24,	w4,	w2

    mul	w17,	w24,	w4
    asr	w13,	w17,	#31
    lsr	w14,	w13,	#31
    madd	w15,	w24,	w4,	w14

    asr	w15,	w15,	#1
    lsl	w16,	w15,	#1
    sub	w6,	w17,	w16
    cmp	w6,	#0
    csel	w26,	w25,	w2,	eq
    add	w20,	w3,	#1
    movz	fp,	#28944
    movz	w12,	#800
    lsl	w9,	w10,	#2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w20,	#2
    mul	w6,	w20,	w12
    mov	x17,	x6
    add	x1,	x5,	x2
    add	x17,	sp,	x17
    ldr	w4,	[x1]

    add	x17,	x17,	fp
    add	x7,	x17,	x9
    ldr	w27,	[x7]

    madd	w14,	w27,	w4,	w26

    mul	w22,	w27,	w4
    asr	w16,	w22,	#31
    lsr	w17,	w16,	#31
    madd	w18,	w27,	w4,	w17

    asr	w9,	w18,	#1
    lsl	w11,	w9,	#1
    sub	w23,	w22,	w11
    cmp	w23,	#0
    movz	w6,	#800
    csel	w17,	w14,	w26,	eq
    add	w25,	w20,	#1
    movz	fp,	#28944
    lsl	w24,	w10,	#2
    movk	fp,	#2,	lsl #16
    mul	w22,	w25,	w6
    lsl	w19,	w25,	#2
    mov	x3,	x22
    add	x18,	x5,	x19
    add	x3,	sp,	x3
    ldr	w9,	[x18]

    add	x3,	x3,	fp
    add	x23,	x3,	x24
    ldr	w23,	[x23]

    madd	w28,	w23,	w9,	w17

    mul	w13,	w23,	w9
    asr	w19,	w13,	#31
    lsr	w20,	w19,	#31
    madd	w21,	w23,	w9,	w20

    asr	w2,	w21,	#1
    lsl	w3,	w2,	#1
    sub	w12,	w13,	w3
    cmp	w12,	#0
    movz	w1,	#800
    movz	fp,	#28944
    csel	w28,	w28,	w17,	eq
    add	w3,	w25,	#1
    lsl	w13,	w10,	#2
    movk	fp,	#2,	lsl #16
    mul	w11,	w3,	w1
    lsl	w6,	w3,	#2
    mov	x21,	x11
    add	x4,	x5,	x6
    add	x21,	sp,	x21
    ldr	w17,	[x4]

    add	x21,	x21,	fp
    add	x12,	x21,	x13
    ldr	w13,	[x12]

    mul	w2,	w13,	w17
    asr	w22,	w2,	#31
    lsr	w23,	w22,	#31
    madd	w24,	w13,	w17,	w23

    madd	w17,	w13,	w17,	w28

    asr	w25,	w24,	#1
    lsl	w26,	w25,	#1
    sub	w27,	w2,	w26
    cmp	w27,	#0
    csel	w7,	w17,	w28,	eq
    add	w4,	w3,	#1
    movz	w24,	#800
    movz	fp,	#28944
    lsl	w27,	w10,	#2
    movk	fp,	#2,	lsl #16
    lsl	w22,	w4,	#2
    mul	w25,	w4,	w24
    mov	x9,	x25
    add	x21,	x5,	x22
    add	x9,	sp,	x9
    ldr	w28,	[x21]

    add	x9,	x9,	fp
    add	x26,	x9,	x27
    ldr	w6,	[x26]

    madd	w3,	w6,	w28,	w7

    mul	w19,	w6,	w28
    asr	w25,	w19,	#31
    lsr	w26,	w25,	#31
    madd	w27,	w6,	w28,	w26

    asr	w20,	w27,	#1
    lsl	w21,	w20,	#1
    sub	w17,	w19,	w21
    cmp	w17,	#0
    csel	w27,	w3,	w7,	eq
    add	w22,	w4,	#1
    movz	fp,	#28944
    lsl	w16,	w10,	#2
    movz	w19,	#800
    movk	fp,	#2,	lsl #16
    lsl	w11,	w22,	#2
    mul	w14,	w22,	w19
    add	x9,	x5,	x11
    mov	x25,	x14
    add	x25,	sp,	x25
    ldr	w11,	[x9]

    add	x25,	x25,	fp
    add	x15,	x25,	x16
    ldr	w4,	[x15]

    madd	w20,	w4,	w11,	w27

    mul	w17,	w4,	w11
    asr	w28,	w17,	#31
    lsr	w1,	w28,	#31
    madd	w2,	w4,	w11,	w1

    asr	w15,	w2,	#1
    lsl	w16,	w15,	#1
    sub	w3,	w17,	w16
    cmp	w3,	#0
    add	w9,	w22,	#1
    csel	w15,	w20,	w27,	eq
    b	main_75

main_168:
    lsl	w12,	w10,	#2
    add	w10,	w10,	#1
    add	x11,	x8,	x12
    str	w15,	[x11]

    cmp	w10,	#200
    blt	main_73

main_172:
    add	w0,	w0,	#1
    cmp	w0,	#200
    blt	main_68

main_175:
    movz	w13,	#0

main_177:
    movz	w18,	#800
    movz	w5,	#0
    movz	w15,	#65535
    mul	w23,	w13,	w18
    movk	w15,	#32767,	lsl #16
    mov	x1,	x23
    add	x1,	sp,	x1
    add	x1,	x1,	#16

main_180:
    cmp	w5,	#200
    bge	main_225

main_184:
    lsl	w7,	w5,	#2
    add	x6,	x1,	x7
    ldr	w8,	[x6]

    cmp	w8,	w15
    csel	w24,	w8,	w15,	lt
    add	w26,	w5,	#1
    lsl	w6,	w26,	#2
    add	x5,	x1,	x6
    ldr	w7,	[x5]

    cmp	w7,	w24
    add	w4,	w26,	#1
    csel	w3,	w7,	w24,	lt
    lsl	w12,	w4,	#2
    add	x11,	x1,	x12
    ldr	w14,	[x11]

    cmp	w14,	w3
    add	w10,	w4,	#1
    csel	w9,	w14,	w3,	lt
    lsl	w19,	w10,	#2
    add	x18,	x1,	x19
    ldr	w20,	[x18]

    cmp	w20,	w9
    add	w17,	w10,	#1
    csel	w16,	w20,	w9,	lt
    lsl	w25,	w17,	#2
    add	x24,	x1,	x25
    ldr	w26,	[x24]

    cmp	w26,	w16
    csel	w25,	w26,	w16,	lt
    add	w26,	w17,	#1
    lsl	w3,	w26,	#2
    add	x2,	x1,	x3
    ldr	w4,	[x2]

    cmp	w4,	w25
    add	w5,	w26,	#1
    csel	w4,	w4,	w25,	lt
    lsl	w9,	w5,	#2
    add	x8,	x1,	x9
    ldr	w10,	[x8]

    cmp	w10,	w4
    csel	w11,	w10,	w4,	lt
    add	w10,	w5,	#1
    lsl	w16,	w10,	#2
    add	x15,	x1,	x16
    ldr	w17,	[x15]

    cmp	w17,	w11
    add	w5,	w10,	#1
    csel	w15,	w17,	w11,	lt
    b	main_180

main_225:
    movz	w7,	#0

main_226:
    cmp	w7,	#200
    bge	main_246

main_229:
    lsl	w5,	w7,	#2
    add	w24,	w7,	#1
    add	x4,	x1,	x5
    add	w27,	w24,	#1
    lsl	w22,	w24,	#2
    str	w15,	[x4]

    add	x21,	x1,	x22
    add	w2,	w27,	#1
    lsl	w25,	w27,	#2
    str	w15,	[x21]

    add	x24,	x1,	x25
    add	w7,	w2,	#1
    lsl	w28,	w2,	#2
    str	w15,	[x24]

    add	x27,	x1,	x28
    add	w10,	w7,	#1
    lsl	w3,	w7,	#2
    str	w15,	[x27]

    add	x2,	x1,	x3
    add	w14,	w10,	#1
    lsl	w6,	w10,	#2
    str	w15,	[x2]

    add	x5,	x1,	x6
    add	w18,	w14,	#1
    lsl	w9,	w14,	#2
    str	w15,	[x5]

    add	x8,	x1,	x9
    add	w7,	w18,	#1
    lsl	w12,	w18,	#2
    str	w15,	[x8]

    add	x11,	x1,	x12
    str	w15,	[x11]

    b	main_226

main_246:
    add	w13,	w13,	#1
    cmp	w13,	#200
    blt	main_177

main_249:
    movz	w17,	#0

main_251:
    movz	w6,	#800
    movz	w22,	#0
    mul	w16,	w17,	w6
    mov	x2,	x16
    add	x2,	sp,	x2
    add	x2,	x2,	#16

main_254:
    cmp	w22,	#200
    bge	main_306

main_257:
    lsl	w21,	w22,	#2
    movz	w9,	#800
    lsl	w26,	w17,	#2
    movz	w7,	#0
    add	w23,	w22,	#1
    movz	w3,	#0
    movz	w1,	#800
    movz	w11,	#0
    add	x5,	x2,	x21
    mul	w24,	w22,	w9
    lsl	w6,	w23,	#2
    movz	w21,	#0
    mov	x10,	x24
    add	x20,	x2,	x6
    add	x10,	sp,	x10
    add	w6,	w23,	#1
    add	x10,	x10,	#16
    mul	w18,	w6,	w1
    mov	x13,	x18
    add	x25,	x10,	x26
    add	x13,	sp,	x13
    movz	w26,	#800
    lsl	w10,	w17,	#2
    ldr	w15,	[x25]

    add	x13,	x13,	#16
    sub	w28,	w7,	w15
    lsl	w15,	w6,	#2
    str	w28,	[x5]

    add	x0,	x2,	x15
    movz	w28,	#0
    movz	w5,	#800
    mul	w8,	w23,	w5
    movz	w23,	#800
    mov	x4,	x8
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    add	x9,	x4,	x10
    lsl	w10,	w17,	#2
    ldr	w9,	[x9]

    sub	w12,	w3,	w9
    str	w12,	[x20]

    lsl	w20,	w17,	#2
    add	x19,	x13,	x20
    movz	w20,	#0
    ldr	w18,	[x19]

    add	w19,	w6,	#1
    sub	w22,	w28,	w18
    movz	w18,	#800
    str	w22,	[x0]

    add	w4,	w19,	#1
    mul	w27,	w19,	w26
    lsl	w25,	w19,	#2
    movz	w22,	#800
    lsl	w0,	w17,	#2
    add	w7,	w4,	#1
    lsl	w6,	w4,	#2
    mov	x24,	x27
    add	x13,	x2,	x25
    mul	w8,	w4,	w22
    add	x27,	x2,	x6
    mul	w18,	w7,	w18
    lsl	w15,	w7,	#2
    add	x24,	sp,	x24
    mov	x5,	x8
    add	w6,	w7,	#1
    mov	x14,	x18
    add	x8,	x2,	x15
    add	x5,	sp,	x5
    add	x24,	x24,	#16
    add	x14,	sp,	x14
    lsl	w25,	w6,	#2
    movz	w15,	#0
    add	x5,	x5,	#16
    add	x28,	x24,	x0
    add	x14,	x14,	#16
    lsl	w0,	w17,	#2
    movz	w24,	#0
    add	x9,	x5,	x10
    ldr	w28,	[x28]

    lsl	w10,	w17,	#2
    sub	w3,	w24,	w28
    str	w3,	[x13]

    movz	w13,	#800
    ldr	w9,	[x9]

    sub	w12,	w20,	w9
    lsl	w20,	w17,	#2
    str	w12,	[x27]

    add	x19,	x14,	x20
    mul	w27,	w6,	w13
    ldr	w20,	[x19]

    sub	w22,	w15,	w20
    add	w20,	w6,	#1
    str	w22,	[x8]

    lsl	w6,	w20,	#2
    mul	w8,	w20,	w23
    add	x22,	x2,	x25
    add	x7,	x2,	x6
    mov	x25,	x27
    mov	x6,	x8
    add	x25,	sp,	x25
    add	x6,	sp,	x6
    add	x25,	x25,	#16
    add	x6,	x6,	#16
    add	x28,	x25,	x0
    add	x9,	x6,	x10
    ldr	w0,	[x28]

    sub	w3,	w11,	w0
    str	w3,	[x22]

    add	w22,	w20,	#1
    ldr	w10,	[x9]

    sub	w12,	w21,	w10
    str	w12,	[x7]

    b	main_254

main_306:
    add	w17,	w17,	#1
    cmp	w17,	#200
    blt	main_251

main_309:
    movz	w19,	#0
    movz	w27,	#0

main_311:
    movz	w25,	#800
    movz	w6,	#0
    mul	w16,	w19,	w25
    mov	x15,	x16
    add	x15,	sp,	x15
    add	x15,	x15,	#16

main_315:
    cmp	w6,	#200
    bge	main_352

main_319:
    lsl	w11,	w6,	#2
    add	w13,	w6,	#1
    add	x10,	x15,	x11
    add	w23,	w13,	#1
    lsl	w26,	w13,	#2
    ldr	w12,	[x10]

    add	x25,	x15,	x26
    add	w0,	w23,	#1
    lsl	w2,	w23,	#2
    add	w14,	w12,	w27
    add	x1,	x15,	x2
    ldr	w27,	[x25]

    add	w5,	w0,	#1
    lsl	w7,	w0,	#2
    add	w22,	w27,	w14
    ldr	w3,	[x1]

    add	x6,	x15,	x7
    add	w10,	w5,	#1
    lsl	w12,	w5,	#2
    add	w28,	w3,	w22
    ldr	w8,	[x6]

    add	x11,	x15,	x12
    lsl	w18,	w10,	#2
    add	w4,	w8,	w28
    ldr	w13,	[x11]

    add	x17,	x15,	x18
    add	w8,	w10,	#1
    add	w9,	w13,	w4
    ldr	w20,	[x17]

    lsl	w24,	w8,	#2
    add	w16,	w20,	w9
    add	x23,	x15,	x24
    add	w24,	w8,	#1
    ldr	w25,	[x23]

    add	w6,	w24,	#1
    lsl	w0,	w24,	#2
    add	w23,	w25,	w16
    add	x28,	x15,	x0
    ldr	w1,	[x28]

    add	w27,	w1,	w23
    b	main_315

main_352:
    add	w19,	w19,	#1
    cmp	w19,	#200
    blt	main_311

main_355:
    movz	w0,	#93
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#0

main_357:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#21264
    movk	fp,	#7,	lsl #16
    add	sp, sp, fp
    ret


