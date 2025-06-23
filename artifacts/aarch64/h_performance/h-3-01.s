.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global data
.align	2
data:
    .zero	2560000

.global corr
.align	2
corr:
    .zero	2560000


.text

.globl main
main:
main_0:
    movz	fp,	#6416
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#3200
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#3200
    movz	w1,	#0
    add	x0,	sp,	#3216
    bl	memset
    adrp	x0, :got:data
    ldr	x0, [x0, #:got_lo12:data]
    bl	getarray
    movz	w0,	#79
    bl	_sysy_starttime
    add	x0,	sp,	#16
    add	x12,	sp,	#3216
    adrp	x11, :got:corr
    movz	w7,	#0
    adrp	x21, :got:data
    ldr	x21, [x21, #:got_lo12:data]
    ldr	x11, [x11, #:got_lo12:corr]

main_10:
    lsl	w8,	w7,	#2
    movz	w22,	#0
    movz	w1,	#0
    add	x9,	x12,	x8
    str	w22,	[x9]


main_13:
    cmp	x1,	#800
    bge	main_58

main_16:
    ldr	w5,	[x9]

    movz	w14,	#3200
    lsl	w16,	w7,	#2
    add	x18,	x1,	#1
    movz	w10,	#3200
    movz	w8,	#3200
    lsl	w23,	w7,	#2
    lsl	w13,	w7,	#2
    madd	x2,	x1,	x14,	x21

    madd	x20,	x18,	x10,	x21

    add	x15,	x2,	x16
    lsl	w2,	w7,	#2
    ldr	w17,	[x15]

    lsl	w15,	w7,	#2
    add	w27,	w17,	w5
    movz	w5,	#3200
    add	x14,	x20,	x15
    lsl	w20,	w7,	#2
    ldr	w16,	[x14]

    add	w25,	w16,	w27
    add	x27,	x18,	#1
    add	x16,	x27,	#1
    madd	x28,	x27,	x8,	x21

    lsl	w8,	w7,	#2
    add	x22,	x28,	x23
    lsl	w28,	w7,	#2
    madd	x10,	x16,	x5,	x21

    ldr	w24,	[x22]

    add	x1,	x10,	x2
    add	w15,	w24,	w25
    add	x25,	x16,	#1
    ldr	w3,	[x1]

    movz	w1,	#3200
    add	w23,	w3,	w15
    add	x6,	x25,	#1
    movz	w3,	#3200
    madd	x19,	x25,	x3,	x21

    add	x26,	x6,	#1
    madd	x27,	x6,	x1,	x21

    movz	w25,	#3200
    add	x10,	x19,	x13
    add	x19,	x27,	x20
    movz	w27,	#3200
    ldr	w14,	[x10]

    madd	x6,	x26,	x27,	x21

    ldr	w22,	[x19]

    add	w4,	w14,	w23
    add	x27,	x6,	x28
    add	w3,	w22,	w4
    ldr	w1,	[x27]

    add	w28,	w1,	w3
    add	x1,	x26,	#1
    madd	x18,	x1,	x25,	x21

    add	w1,	w1,	#1
    add	x6,	x18,	x8
    ldr	w10,	[x6]

    add	w13,	w10,	w28
    str	w13,	[x9]

    b	main_13

main_58:
    ldr	w26,	[x9]

    movz	w15,	#800
    add	w7,	w7,	#1
    sdiv	w16,	w26,	w15
    str	w16,	[x9]

    cmp	w7,	#800
    blt	main_10

main_63:
    movz	w22,	#0

main_65:
    lsl	w27,	w22,	#2
    movz	w16,	#0
    lsl	w20,	w22,	#2
    movz	w3,	#0
    add	x24,	x0,	x27
    add	x19,	x12,	x20
    str	w16,	[x24]

    ldr	w8,	[x19]


main_70:
    cmp	x3,	#800
    bge	main_131

main_73:
    ldr	w15,	[x24]

    movz	w17,	#3200
    lsl	w10,	w22,	#2
    add	x2,	x3,	#1
    movz	w5,	#3200
    lsl	w27,	w22,	#2
    lsl	w16,	w22,	#2
    madd	x18,	x3,	x17,	x21

    movz	w3,	#3200
    madd	x17,	x2,	x5,	x21

    add	x9,	x18,	x10
    add	x26,	x17,	x27
    movz	w27,	#3200
    ldr	w13,	[x9]

    lsl	w9,	w22,	#2
    ldr	w28,	[x26]

    sub	w14,	w13,	w8
    sub	w1,	w28,	w8
    lsl	w28,	w22,	#2
    madd	w20,	w14,	w14,	w15

    madd	w18,	w1,	w1,	w20

    movz	w1,	#3200
    add	x20,	x2,	#1
    add	x5,	x20,	#1
    madd	x2,	x20,	x3,	x21

    lsl	w20,	w22,	#2
    add	x7,	x2,	x9
    madd	x14,	x5,	x1,	x21

    add	x9,	x5,	#1
    ldr	w10,	[x7]

    add	x19,	x14,	x20
    sub	w13,	w10,	w8
    madd	x27,	x9,	x27,	x21

    add	x7,	x9,	#1
    ldr	w23,	[x19]

    lsl	w10,	w22,	#2
    madd	w4,	w13,	w13,	w18

    movz	w19,	#3200
    sub	w25,	w23,	w8
    movz	w23,	#3200
    madd	w26,	w25,	w25,	w4

    movz	w25,	#3200
    lsl	w4,	w22,	#2
    madd	x9,	x7,	x25,	x21

    add	x3,	x27,	x4
    add	x15,	x9,	x16
    ldr	w5,	[x3]

    add	x3,	x7,	#1
    ldr	w17,	[x15]

    sub	w6,	w5,	w8
    sub	w18,	w17,	w8
    madd	x20,	x3,	x23,	x21

    madd	w6,	w6,	w6,	w26

    add	x27,	x20,	x28
    madd	w26,	w18,	w18,	w6

    add	x20,	x3,	#1
    ldr	w1,	[x27]

    add	w3,	w20,	#1
    madd	x5,	x20,	x19,	x21

    sub	w2,	w1,	w8
    add	x9,	x5,	x10
    madd	w17,	w2,	w2,	w26

    ldr	w13,	[x9]

    sub	w14,	w13,	w8
    madd	w16,	w14,	w14,	w17

    str	w16,	[x24]

    b	main_70

main_131:
    ldr	w17,	[x24]

    movz	w18,	#800
    sdiv	w3,	w17,	w18
    mul	w4,	w3,	w3
    str	w4,	[x24]

    cmp	w4,	#1
    bgt	main_138

main_136:
    movz	w19,	#1
    str	w19,	[x24]


main_138:
    add	w22,	w22,	#1
    cmp	w22,	#800
    blt	main_65

main_141:
    movz	w7,	#0

main_143:
    movz	w22,	#3200
    movz	w13,	#0
    madd	x27,	x7,	x22,	x21


main_146:
    movz	w23,	#50176
    movk	w23,	#9,	lsl #16
    cmp	w13,	#800
    bge	main_230

main_149:
    lsl	w3,	w13,	#2
    lsl	w6,	w13,	#2
    lsl	w14,	w13,	#2
    add	x2,	x27,	x3
    add	x5,	x12,	x6
    add	x10,	x0,	x14
    ldr	w4,	[x2]

    ldr	w8,	[x5]

    ldr	w15,	[x10]

    sub	w5,	w4,	w8
    mul	w16,	w15,	w23
    sdiv	w17,	w5,	w16
    add	w16,	w13,	#1
    str	w17,	[x2]

    add	w26,	w16,	#1
    lsl	w1,	w16,	#2
    lsl	w24,	w16,	#2
    lsl	w19,	w16,	#2
    add	x28,	x0,	x1
    lsl	w17,	w26,	#2
    lsl	w13,	w26,	#2
    lsl	w8,	w26,	#2
    add	x22,	x12,	x24
    add	x10,	x27,	x19
    add	x16,	x0,	x17
    add	x5,	x27,	x8
    ldr	w9,	[x10]

    ldr	w25,	[x22]

    ldr	w2,	[x28]

    sub	w6,	w9,	w25
    mul	w3,	w2,	w23
    sdiv	w4,	w6,	w3
    str	w4,	[x10]

    add	x10,	x12,	x13
    ldr	w2,	[x5]

    ldr	w14,	[x10]

    add	w10,	w26,	#1
    ldr	w18,	[x16]

    sub	w25,	w2,	w14
    mul	w19,	w18,	w23
    lsl	w1,	w10,	#2
    sdiv	w20,	w25,	w19
    add	x28,	x12,	x1
    lsl	w25,	w10,	#2
    str	w20,	[x5]

    add	x15,	x27,	x25
    lsl	w5,	w10,	#2
    add	x4,	x0,	x5
    ldr	w20,	[x15]

    add	w5,	w10,	#1
    ldr	w2,	[x28]

    ldr	w6,	[x4]

    sub	w18,	w20,	w2
    lsl	w22,	w5,	#2
    lsl	w17,	w5,	#2
    lsl	w14,	w5,	#2
    mul	w8,	w6,	w23
    add	x20,	x0,	x22
    add	x16,	x12,	x17
    sdiv	w9,	w18,	w8
    add	x8,	x27,	x14
    str	w9,	[x15]

    ldr	w10,	[x8]

    ldr	w18,	[x16]

    ldr	w24,	[x20]

    sub	w6,	w10,	w18
    mul	w25,	w24,	w23
    sdiv	w26,	w6,	w25
    add	w25,	w5,	#1
    str	w26,	[x8]

    lsl	w10,	w25,	#2
    lsl	w5,	w25,	#2
    lsl	w2,	w25,	#2
    add	x9,	x0,	x10
    add	x4,	x12,	x5
    add	x20,	x27,	x2
    add	w5,	w25,	#1
    ldr	w3,	[x20]

    lsl	w28,	w5,	#2
    lsl	w22,	w5,	#2
    lsl	w18,	w5,	#2
    ldr	w6,	[x4]

    add	x26,	x0,	x28
    ldr	w13,	[x9]

    sub	w1,	w3,	w6
    mul	w14,	w13,	w23
    add	x13,	x27,	x18
    sdiv	w15,	w1,	w14
    str	w15,	[x20]

    add	x20,	x12,	x22
    ldr	w19,	[x13]

    ldr	w24,	[x20]

    ldr	w1,	[x26]

    sub	w19,	w19,	w24
    mul	w2,	w1,	w23
    sdiv	w3,	w19,	w2
    add	w19,	w5,	#1
    str	w3,	[x13]

    lsl	w10,	w19,	#2
    lsl	w6,	w19,	#2
    add	x9,	x12,	x10
    add	x18,	x27,	x6
    ldr	w16,	[x18]

    ldr	w13,	[x9]

    sub	w10,	w16,	w13
    add	w13,	w19,	#1
    lsl	w16,	w19,	#2
    add	x15,	x0,	x16
    ldr	w17,	[x15]

    mul	w24,	w17,	w23
    sdiv	w25,	w10,	w24
    str	w25,	[x18]

    b	main_146

main_230:
    add	w7,	w7,	#1
    cmp	w7,	#800
    blt	main_143

main_233:
    movz	w25,	#0

main_235:
    movz	w27,	#3200
    lsl	x2,	x25,	#2
    movz	w20,	#1
    add	w28,	w25,	#1
    madd	x15,	x25,	x27,	x11

    mov	w13,	w28
    add	x3,	x15,	x2
    str	w20,	[x3]


main_241:
    lsl	x3,	x13,	#2
    movz	w27,	#0
    movz	w18,	#0
    add	x7,	x15,	x3
    str	w27,	[x7]


main_244:
    cmp	x18,	#800
    bge	main_313

main_247:
    ldr	w9,	[x7]

    movz	w27,	#3200
    lsl	x14,	x25,	#2
    lsl	x19,	x13,	#2
    movz	w22,	#3200
    lsl	x4,	x25,	#2
    lsl	x8,	x13,	#2
    lsl	x24,	x13,	#2
    madd	x0,	x18,	x27,	x21

    add	x18,	x18,	#1
    add	x17,	x0,	x19
    add	x12,	x0,	x14
    movz	w19,	#3200
    madd	x10,	x18,	x22,	x21

    add	x14,	x18,	#1
    ldr	w26,	[x12]

    add	x6,	x10,	x8
    add	x3,	x10,	x4
    movz	w12,	#3200
    madd	x27,	x14,	x19,	x21

    ldr	w20,	[x17]

    add	x22,	x27,	x24
    lsl	x19,	x25,	#2
    ldr	w5,	[x3]

    madd	w16,	w20,	w26,	w9

    add	x24,	x14,	#1
    add	x18,	x27,	x19
    ldr	w9,	[x6]

    lsl	x6,	x25,	#2
    madd	w16,	w9,	w5,	w16

    ldr	w20,	[x18]

    lsl	x5,	x25,	#2
    lsl	x9,	x13,	#2
    ldr	w26,	[x22]

    lsl	x22,	x25,	#2
    madd	w20,	w26,	w20,	w16

    lsl	x26,	x13,	#2
    movz	w16,	#3200
    madd	x18,	x24,	x16,	x21

    add	x8,	x18,	x9
    add	x4,	x18,	x5
    movz	w9,	#3200
    ldr	w16,	[x4]

    add	x4,	x24,	#1
    ldr	w10,	[x8]

    madd	w3,	w10,	w16,	w20

    lsl	x10,	x13,	#2
    lsl	x20,	x25,	#2
    madd	x5,	x4,	x12,	x21

    add	x16,	x4,	#1
    add	x24,	x5,	x26
    add	x19,	x5,	x20
    madd	x26,	x16,	x9,	x21

    ldr	w2,	[x19]

    add	x9,	x26,	x10
    add	x5,	x26,	x6
    ldr	w27,	[x24]

    movz	w6,	#3200
    madd	w8,	w27,	w2,	w3

    lsl	x27,	x13,	#2
    add	x3,	x16,	#1
    ldr	w20,	[x5]

    ldr	w12,	[x9]

    add	x2,	x3,	#1
    madd	w1,	w12,	w20,	w8

    madd	x12,	x3,	x6,	x21

    movz	w3,	#3200
    add	x26,	x12,	x27
    add	w18,	w2,	#1
    add	x20,	x12,	x22
    madd	x3,	x2,	x3,	x21

    lsl	x12,	x13,	#2
    ldr	w8,	[x20]

    add	x10,	x3,	x12
    ldr	w0,	[x26]

    madd	w1,	w0,	w8,	w1

    lsl	x8,	x25,	#2
    add	x6,	x3,	x8
    ldr	w27,	[x6]

    ldr	w14,	[x10]

    madd	w17,	w14,	w27,	w1

    str	w17,	[x7]

    b	main_244

main_313:
    movz	w1,	#3200
    lsl	x24,	x25,	#2
    ldr	w10,	[x7]

    madd	x20,	x13,	x1,	x11

    add	w13,	w13,	#1
    add	x26,	x20,	x24
    str	w10,	[x26]

    cmp	w13,	#800
    blt	main_241

main_319:
    cmp	w28,	#799
    blt	main_234

main_321:
    movz	w22,	#896
    movz	w21,	#1
    movz	w0,	#81
    movk	w22,	#39,	lsl #16
    add	x20,	x11,	x22
    add	x24,	x20,	#3196
    str	w21,	[x24]

    bl	_sysy_stoptime
    mov	w0,	w23
    adrp	x1, :got:corr
    ldr	x1, [x1, #:got_lo12:corr]
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#6416
    add	sp, sp, fp
    ret


main_234:
    mov	w25,	w28
    b	main_235

