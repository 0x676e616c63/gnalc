.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#29120
    movk	fp,	#11,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w24,	#53392
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w24,	#3,	lsl #16
    mov	x2,	x24
    bl	memset
    mov	x2,	x24
    movz	w1,	#0
    movz	fp,	#53408
    movk	fp,	#3,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    mov	x2,	x24
    movz	w1,	#0
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w20,	#0

main_5:
    cmp	w20,	#250
    bge	main_14

main_8:
    movz	w25,	#1000
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    mul	w22,	w20,	w25
    mov	x0,	x22
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#250
    bne	main_423
    b	main_5

main_14:
    movz	w0,	#23
    bl	_sysy_starttime
    movz	w27,	#0

main_16:
    movz	w9,	#1000
    movz	fp,	#53408
    movk	fp,	#3,	lsl #16
    mul	w7,	w27,	w9
    movz	w9,	#0
    mov	x25,	x7
    add	x25,	sp,	x25
    add	x25,	x25,	fp

main_19:
    cmp	w9,	#248
    bge	main_65

main_22:
    lsl	w19,	w9,	#2
    movz	w17,	#1000
    movz	fp,	#41264
    lsl	w23,	w27,	#2
    lsl	w6,	w27,	#2
    movz	w20,	#1000
    lsl	w14,	w27,	#2
    lsl	w3,	w27,	#2
    movz	w11,	#1000
    add	x1,	x25,	x19
    mul	w21,	w9,	w17
    movk	fp,	#7,	lsl #16
    lsl	w17,	w27,	#2
    add	w9,	w9,	#1
    mov	x26,	x21
    add	x26,	sp,	x26
    lsl	w13,	w9,	#2
    add	x26,	x26,	fp
    add	x10,	x25,	x13
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x22,	x26,	x23
    movz	w26,	#1000
    ldr	w24,	[x22]

    str	w24,	[x1]

    movz	w1,	#1000
    mul	w15,	w9,	w1
    mov	x1,	x15
    add	x1,	sp,	x1
    add	x1,	x1,	fp
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x16,	x1,	x17
    add	w17,	w9,	#1
    ldr	w18,	[x16]

    add	w22,	w17,	#1
    mul	w23,	w17,	w26
    lsl	w21,	w17,	#2
    str	w18,	[x10]

    lsl	w26,	w27,	#2
    mov	x9,	x23
    lsl	w2,	w22,	#2
    movz	w17,	#1000
    add	x18,	x25,	x21
    movz	w23,	#1000
    add	x9,	sp,	x9
    mul	w4,	w22,	w23
    add	x9,	x9,	fp
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x24,	x9,	x26
    add	x26,	x25,	x2
    ldr	w28,	[x24]

    str	w28,	[x18]

    mov	x18,	x4
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x5,	x18,	x6
    ldr	w7,	[x5]

    add	w5,	w22,	#1
    str	w7,	[x26]

    lsl	w22,	w27,	#2
    mul	w12,	w5,	w20
    lsl	w10,	w5,	#2
    mov	x28,	x12
    add	x6,	x25,	x10
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x13,	x28,	x14
    add	w14,	w5,	#1
    ldr	w15,	[x13]

    mul	w20,	w14,	w17
    lsl	w18,	w14,	#2
    str	w15,	[x6]

    mov	x7,	x20
    add	x15,	x25,	x18
    add	x7,	sp,	x7
    add	x7,	x7,	fp
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x21,	x7,	x22
    add	w7,	w14,	#1
    movz	w14,	#1000
    ldr	w23,	[x21]

    lsl	w28,	w7,	#2
    add	w22,	w7,	#1
    mul	w1,	w7,	w14
    str	w23,	[x15]

    add	x5,	x25,	x28
    mov	x16,	x1
    mul	w9,	w22,	w11
    lsl	w7,	w22,	#2
    add	x16,	sp,	x16
    lsl	w11,	w27,	#2
    mov	x24,	x9
    add	x17,	x25,	x7
    add	w9,	w22,	#1
    add	x24,	sp,	x24
    add	x16,	x16,	fp
    movz	fp,	#41264
    movk	fp,	#7,	lsl #16
    add	x2,	x16,	x3
    add	x24,	x24,	fp
    ldr	w4,	[x2]

    add	x10,	x24,	x11
    str	w4,	[x5]

    ldr	w12,	[x10]

    str	w12,	[x17]

    b	main_19

main_65:
    lsl	w4,	w9,	#2
    movz	w20,	#1000
    movz	fp,	#41264
    lsl	w8,	w27,	#2
    add	x5,	x25,	x4
    mul	w6,	w9,	w20
    movk	fp,	#7,	lsl #16
    add	w9,	w9,	#1
    mov	x14,	x6
    add	x14,	sp,	x14
    add	x14,	x14,	fp
    add	x7,	x14,	x8
    ldr	w10,	[x7]

    str	w10,	[x5]

    cmp	w9,	#250
    blt	main_65

main_73:
    add	w27,	w27,	#1
    cmp	w27,	#250
    blt	main_16

main_76:
    movz	w8,	#0

main_78:
    movz	w11,	#1000
    movz	fp,	#41264
    movz	w23,	#1000
    movz	w25,	#0
    mul	w1,	w8,	w11
    movk	fp,	#7,	lsl #16
    mov	x18,	x1
    mul	w1,	w8,	w23
    add	x18,	sp,	x18
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x18,	x18,	fp
    add	x0,	x0,	#16

main_83:
    movz	w6,	#0
    movz	w14,	#0

main_85:
    cmp	w6,	#248
    bge	main_180

main_89:
    lsl	w7,	w6,	#2
    movz	w15,	#1000
    movz	fp,	#53408
    lsl	w13,	w25,	#2
    add	x5,	x18,	x7
    mul	w11,	w6,	w15
    movk	fp,	#3,	lsl #16
    mov	x24,	x11
    add	x24,	sp,	x24
    ldr	w19,	[x5]

    add	x24,	x24,	fp
    add	x12,	x24,	x13
    ldr	w4,	[x12]

    mul	w21,	w4,	w19
    asr	w5,	w21,	#31
    lsr	w7,	w5,	#31
    madd	w9,	w4,	w19,	w7

    madd	w19,	w4,	w19,	w14

    asr	w1,	w9,	#1
    lsl	w2,	w1,	#1
    sub	w3,	w21,	w2
    cmp	w3,	#0
    movz	fp,	#53408
    movz	w2,	#1000
    add	w26,	w6,	#1
    csel	w16,	w19,	w14,	eq
    lsl	w24,	w25,	#2
    movk	fp,	#3,	lsl #16
    mul	w22,	w26,	w2
    lsl	w19,	w26,	#2
    mov	x3,	x22
    add	x17,	x18,	x19
    add	x3,	sp,	x3
    ldr	w20,	[x17]

    add	x3,	x3,	fp
    add	x23,	x3,	x24
    ldr	w28,	[x23]

    madd	w1,	w28,	w20,	w16

    mul	w4,	w28,	w20
    asr	w10,	w4,	#31
    lsr	w11,	w10,	#31
    madd	w12,	w28,	w20,	w11

    asr	w5,	w12,	#1
    lsl	w6,	w5,	#1
    sub	w11,	w4,	w6
    cmp	w11,	#0
    lsl	w12,	w25,	#2
    add	w19,	w26,	#1
    movz	fp,	#53408
    csel	w9,	w1,	w16,	eq
    movz	w26,	#1000
    movk	fp,	#3,	lsl #16
    lsl	w6,	w19,	#2
    mul	w10,	w19,	w26
    add	x5,	x18,	x6
    mov	x20,	x10
    add	x20,	sp,	x20
    ldr	w6,	[x5]

    add	x20,	x20,	fp
    add	x11,	x20,	x12
    ldr	w4,	[x11]

    madd	w16,	w4,	w6,	w9

    mul	w24,	w4,	w6
    asr	w13,	w24,	#31
    lsr	w14,	w13,	#31
    madd	w15,	w4,	w6,	w14

    asr	w28,	w15,	#1
    lsl	w1,	w28,	#1
    sub	w27,	w24,	w1
    cmp	w27,	#0
    csel	w2,	w16,	w9,	eq
    add	w3,	w19,	#1
    movz	w20,	#1000
    movz	fp,	#53408
    lsl	w28,	w25,	#2
    movk	fp,	#3,	lsl #16
    lsl	w22,	w3,	#2
    mul	w26,	w3,	w20
    mov	x7,	x26
    add	x21,	x18,	x22
    add	x7,	sp,	x7
    ldr	w21,	[x21]

    add	x7,	x7,	fp
    add	x27,	x7,	x28
    ldr	w27,	[x27]

    madd	w4,	w27,	w21,	w2

    mul	w13,	w27,	w21
    asr	w16,	w13,	#31
    lsr	w17,	w16,	#31
    madd	w19,	w27,	w21,	w17

    asr	w22,	w19,	#1
    lsl	w23,	w22,	#1
    sub	w15,	w13,	w23
    cmp	w15,	#0
    csel	w5,	w4,	w2,	eq
    add	w7,	w3,	#1
    movz	fp,	#53408
    movz	w15,	#1000
    movk	fp,	#3,	lsl #16
    lsl	w10,	w7,	#2
    mul	w13,	w7,	w15
    lsl	w15,	w25,	#2
    mov	x24,	x13
    add	x9,	x18,	x10
    add	x24,	sp,	x24
    ldr	w28,	[x9]

    add	x24,	x24,	fp
    add	x14,	x24,	x15
    ldr	w19,	[x14]

    mul	w6,	w19,	w28
    asr	w20,	w6,	#31
    lsr	w21,	w20,	#31
    madd	w20,	w19,	w28,	w5

    madd	w22,	w19,	w28,	w21

    asr	w16,	w22,	#1
    lsl	w17,	w16,	#1
    sub	w3,	w6,	w17
    cmp	w3,	#0
    csel	w27,	w20,	w5,	eq
    movz	w10,	#1000
    movz	fp,	#53408
    lsl	w3,	w25,	#2
    add	w5,	w7,	#1
    movk	fp,	#3,	lsl #16
    mul	w1,	w5,	w10
    lsl	w26,	w5,	#2
    mov	x13,	x1
    add	x24,	x18,	x26
    add	x13,	sp,	x13
    ldr	w4,	[x24]

    add	x13,	x13,	fp
    add	x2,	x13,	x3
    ldr	w10,	[x2]

    madd	w7,	w10,	w4,	w27

    mul	w28,	w10,	w4
    asr	w23,	w28,	#31
    lsr	w24,	w23,	#31
    madd	w26,	w10,	w4,	w24

    asr	w11,	w26,	#1
    lsl	w12,	w11,	#1
    sub	w20,	w28,	w12
    cmp	w20,	#0
    csel	w14,	w7,	w27,	eq
    add	w20,	w5,	#1
    movz	w4,	#1000
    movz	fp,	#53408
    lsl	w19,	w25,	#2
    movk	fp,	#3,	lsl #16
    lsl	w13,	w20,	#2
    mul	w16,	w20,	w4
    mov	x1,	x16
    add	x12,	x18,	x13
    add	x1,	sp,	x1
    ldr	w15,	[x12]

    add	x1,	x1,	fp
    add	x17,	x1,	x19
    ldr	w10,	[x17]

    madd	w23,	w10,	w15,	w14

    mul	w19,	w10,	w15
    asr	w27,	w19,	#31
    lsr	w28,	w27,	#31
    madd	w1,	w10,	w15,	w28

    asr	w5,	w1,	#1
    lsl	w6,	w5,	#1
    sub	w7,	w19,	w6
    cmp	w7,	#0
    csel	w22,	w23,	w14,	eq
    add	w26,	w20,	#1
    movz	fp,	#53408
    movz	w3,	#1000
    lsl	w6,	w25,	#2
    movk	fp,	#3,	lsl #16
    lsl	w1,	w26,	#2
    mul	w4,	w26,	w3
    mov	x17,	x4
    add	x28,	x18,	x1
    add	x17,	sp,	x17
    ldr	w9,	[x28]

    add	x17,	x17,	fp
    add	x5,	x17,	x6
    ldr	w5,	[x5]

    madd	w11,	w5,	w9,	w22

    mul	w13,	w5,	w9
    asr	w2,	w13,	#31
    lsr	w3,	w2,	#31
    madd	w4,	w5,	w9,	w3

    asr	w28,	w4,	#1
    lsl	w1,	w28,	#1
    sub	w24,	w13,	w1
    cmp	w24,	#0
    add	w6,	w26,	#1
    csel	w14,	w11,	w22,	eq
    b	main_85

main_180:
    lsl	w3,	w6,	#2
    movz	w20,	#1000
    movz	fp,	#53408
    lsl	w10,	w25,	#2
    add	x2,	x18,	x3
    mul	w7,	w6,	w20
    movk	fp,	#3,	lsl #16
    mov	x27,	x7
    add	x27,	sp,	x27
    ldr	w1,	[x2]

    add	x27,	x27,	fp
    add	x9,	x27,	x10
    ldr	w24,	[x9]

    madd	w15,	w24,	w1,	w14

    mul	w2,	w24,	w1
    asr	w7,	w2,	#31
    lsr	w9,	w7,	#31
    madd	w10,	w24,	w1,	w9

    asr	w7,	w10,	#1
    lsl	w9,	w7,	#1
    sub	w5,	w2,	w9
    cmp	w5,	#0
    add	w6,	w6,	#1
    csel	w14,	w15,	w14,	eq
    cmp	w6,	#250
    blt	main_180

main_195:
    lsl	w21,	w25,	#2
    add	w25,	w25,	#1
    add	x20,	x0,	x21
    str	w14,	[x20]

    cmp	w25,	#250
    blt	main_83

main_199:
    add	w8,	w8,	#1
    cmp	w8,	#250
    blt	main_78

main_202:
    movz	w7,	#0

main_204:
    movz	w1,	#1000
    movz	w6,	#0
    movz	w4,	#65535
    mul	w28,	w7,	w1
    movk	w4,	#32767,	lsl #16
    mov	x12,	x28
    add	x12,	sp,	x12
    add	x12,	x12,	#16

main_207:
    cmp	w6,	#248
    bge	main_254

main_211:
    lsl	w17,	w6,	#2
    add	x16,	x12,	x17
    ldr	w18,	[x16]

    cmp	w18,	w4
    csel	w1,	w18,	w4,	lt
    add	w8,	w6,	#1
    lsl	w13,	w8,	#2
    add	x11,	x12,	x13
    ldr	w14,	[x11]

    cmp	w14,	w1
    csel	w15,	w14,	w1,	lt
    add	w14,	w8,	#1
    lsl	w19,	w14,	#2
    add	x18,	x12,	x19
    ldr	w20,	[x18]

    cmp	w20,	w15
    add	w22,	w14,	#1
    csel	w20,	w20,	w15,	lt
    lsl	w25,	w22,	#2
    add	x24,	x12,	x25
    ldr	w26,	[x24]

    cmp	w26,	w20
    add	w5,	w22,	#1
    csel	w4,	w26,	w20,	lt
    lsl	w2,	w5,	#2
    add	x1,	x12,	x2
    ldr	w3,	[x1]

    cmp	w3,	w4
    add	w13,	w5,	#1
    csel	w11,	w3,	w4,	lt
    lsl	w9,	w13,	#2
    add	x8,	x12,	x9
    ldr	w10,	[x8]

    cmp	w10,	w11
    add	w19,	w13,	#1
    csel	w18,	w10,	w11,	lt
    lsl	w16,	w19,	#2
    add	x15,	x12,	x16
    ldr	w17,	[x15]

    cmp	w17,	w18
    add	w26,	w19,	#1
    csel	w24,	w17,	w18,	lt
    lsl	w22,	w26,	#2
    add	x21,	x12,	x22
    ldr	w23,	[x21]

    cmp	w23,	w24
    add	w6,	w26,	#1
    csel	w4,	w23,	w24,	lt
    b	main_207

main_254:
    lsl	w15,	w6,	#2
    add	x14,	x12,	x15
    ldr	w16,	[x14]

    cmp	w16,	w4
    add	w6,	w6,	#1
    csel	w4,	w16,	w4,	lt
    cmp	w6,	#250
    blt	main_254

main_263:
    movz	w22,	#0

main_264:
    cmp	w22,	#248
    bge	main_286

main_267:
    lsl	w23,	w22,	#2
    add	w16,	w22,	#1
    add	x21,	x12,	x23
    add	w19,	w16,	#1
    lsl	w9,	w16,	#2
    str	w4,	[x21]

    add	x8,	x12,	x9
    add	w22,	w19,	#1
    lsl	w13,	w19,	#2
    str	w4,	[x8]

    add	x11,	x12,	x13
    add	w25,	w22,	#1
    lsl	w16,	w22,	#2
    str	w4,	[x11]

    add	x15,	x12,	x16
    add	w28,	w25,	#1
    lsl	w19,	w25,	#2
    str	w4,	[x15]

    add	x18,	x12,	x19
    add	w2,	w28,	#1
    lsl	w22,	w28,	#2
    str	w4,	[x18]

    add	x21,	x12,	x22
    add	w6,	w2,	#1
    lsl	w25,	w2,	#2
    str	w4,	[x21]

    add	x24,	x12,	x25
    add	w22,	w6,	#1
    lsl	w28,	w6,	#2
    str	w4,	[x24]

    add	x27,	x12,	x28
    str	w4,	[x27]

    b	main_264

main_286:
    lsl	w21,	w22,	#2
    add	w22,	w22,	#1
    add	x20,	x12,	x21
    str	w4,	[x20]

    cmp	w22,	#250
    blt	main_286

main_291:
    add	w7,	w7,	#1
    cmp	w7,	#250
    blt	main_204

main_294:
    movz	w14,	#0

main_296:
    movz	w21,	#1000
    movz	w25,	#0
    mul	w4,	w14,	w21
    mov	x17,	x4
    add	x17,	sp,	x17
    add	x17,	x17,	#16

main_299:
    cmp	w25,	#248
    bge	main_353

main_302:
    lsl	w11,	w25,	#2
    lsl	w16,	w14,	#2
    movz	w9,	#0
    movz	w20,	#1000
    lsl	w28,	w14,	#2
    movz	w18,	#0
    lsl	w8,	w14,	#2
    movz	w12,	#0
    add	x22,	x17,	x11
    movz	w11,	#1000
    mul	w13,	w25,	w11
    movz	w11,	#1000
    mov	x3,	x13
    movz	w13,	#0
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    add	x15,	x3,	x16
    movz	w16,	#1000
    add	w3,	w25,	#1
    ldr	w7,	[x15]

    add	w21,	w3,	#1
    mul	w26,	w3,	w20
    lsl	w24,	w3,	#2
    movz	w15,	#1000
    sub	w19,	w9,	w7
    mov	x23,	x26
    mul	w6,	w21,	w16
    lsl	w4,	w21,	#2
    add	w3,	w21,	#1
    movz	w9,	#0
    str	w19,	[x22]

    add	x23,	sp,	x23
    add	x5,	x17,	x4
    add	x19,	x17,	x24
    mul	w16,	w3,	w11
    mov	x4,	x6
    add	x23,	x23,	#16
    add	x4,	sp,	x4
    add	x27,	x23,	x28
    add	x4,	x4,	#16
    ldr	w28,	[x27]

    add	x7,	x4,	x8
    sub	w1,	w18,	w28
    lsl	w28,	w14,	#2
    str	w1,	[x19]

    lsl	w19,	w14,	#2
    ldr	w8,	[x7]

    movz	w7,	#1000
    sub	w10,	w13,	w8
    lsl	w8,	w14,	#2
    lsl	w13,	w3,	#2
    str	w10,	[x5]

    add	x2,	x17,	x13
    movz	w5,	#0
    mov	x13,	x16
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    add	x18,	x13,	x19
    lsl	w19,	w14,	#2
    ldr	w20,	[x18]

    add	w18,	w3,	#1
    sub	w21,	w9,	w20
    movz	w20,	#1000
    str	w21,	[x2]

    add	w23,	w18,	#1
    mul	w26,	w18,	w7
    lsl	w24,	w18,	#2
    movz	w18,	#0
    mul	w6,	w23,	w20
    lsl	w4,	w23,	#2
    add	x16,	x17,	x24
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    add	x27,	x24,	x28
    lsl	w28,	w14,	#2
    ldr	w0,	[x27]

    sub	w1,	w5,	w0
    mov	x5,	x6
    add	x5,	sp,	x5
    str	w1,	[x16]

    add	x1,	x17,	x4
    add	x5,	x5,	#16
    add	x7,	x5,	x8
    movz	w8,	#0
    ldr	w9,	[x7]

    sub	w10,	w18,	w9
    add	w9,	w23,	#1
    str	w10,	[x1]

    add	w3,	w9,	#1
    mul	w16,	w9,	w15
    lsl	w13,	w9,	#2
    movz	w10,	#1000
    mov	x15,	x16
    lsl	w24,	w3,	#2
    add	x26,	x17,	x13
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    add	x18,	x15,	x19
    ldr	w21,	[x18]

    sub	w21,	w12,	w21
    add	x12,	x17,	x24
    str	w21,	[x26]

    mul	w26,	w3,	w10
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    add	x27,	x25,	x28
    add	w25,	w3,	#1
    ldr	w1,	[x27]

    sub	w1,	w8,	w1
    str	w1,	[x12]

    b	main_299

main_353:
    lsl	w5,	w25,	#2
    movz	w16,	#1000
    lsl	w9,	w14,	#2
    movz	w13,	#0
    add	x22,	x17,	x5
    mul	w7,	w25,	w16
    add	w25,	w25,	#1
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    add	x8,	x0,	x9
    ldr	w4,	[x8]

    sub	w11,	w13,	w4
    str	w11,	[x22]

    cmp	w25,	#250
    blt	main_353

main_362:
    add	w14,	w14,	#1
    cmp	w14,	#250
    blt	main_296

main_365:
    movz	w11,	#0
    movz	w24,	#0

main_367:
    movz	w18,	#1000
    movz	w22,	#0
    mul	w17,	w11,	w18
    mov	x17,	x17
    add	x17,	sp,	x17
    add	x17,	x17,	#16

main_371:
    cmp	w22,	#248
    bge	main_410

main_375:
    lsl	w15,	w22,	#2
    add	x14,	x17,	x15
    ldr	w16,	[x14]

    add	w0,	w16,	w24
    add	w24,	w22,	#1
    add	w6,	w24,	#1
    lsl	w26,	w24,	#2
    add	x25,	x17,	x26
    add	w12,	w6,	#1
    lsl	w2,	w6,	#2
    ldr	w27,	[x25]

    add	x1,	x17,	x2
    add	w18,	w12,	#1
    lsl	w7,	w12,	#2
    add	w5,	w27,	w0
    ldr	w3,	[x1]

    add	x6,	x17,	x7
    add	w23,	w18,	#1
    lsl	w13,	w18,	#2
    add	w10,	w3,	w5
    ldr	w8,	[x6]

    add	x12,	x17,	x13
    add	w0,	w23,	#1
    lsl	w19,	w23,	#2
    add	w16,	w8,	w10
    ldr	w14,	[x12]

    add	x18,	x17,	x19
    add	w7,	w0,	#1
    lsl	w24,	w0,	#2
    add	w22,	w14,	w16
    ldr	w20,	[x18]

    add	x23,	x17,	x24
    lsl	w0,	w7,	#2
    add	w28,	w20,	w22
    ldr	w25,	[x23]

    add	w22,	w7,	#1
    add	w6,	w25,	w28
    add	x28,	x17,	x0
    ldr	w1,	[x28]

    add	w24,	w1,	w6
    b	main_371

main_410:
    lsl	w4,	w22,	#2
    add	w22,	w22,	#1
    add	x3,	x17,	x4
    ldr	w5,	[x3]

    add	w24,	w5,	w24
    cmp	w22,	#250
    blt	main_410

main_418:
    add	w11,	w11,	#1
    cmp	w11,	#250
    blt	main_367

main_421:
    movz	w0,	#93
    bl	_sysy_stoptime
    mov	w0,	w24
    bl	putint
    movz	w0,	#0

main_423:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#29120
    movk	fp,	#11,	lsl #16
    add	sp, sp, fp
    ret


