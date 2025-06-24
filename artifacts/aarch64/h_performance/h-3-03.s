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
    movz	w6,	#0
    add	x12,	sp,	#16
    adrp	x11, :got:corr
    add	x28,	sp,	#3216
    adrp	x21, :got:data
    ldr	x21, [x21, #:got_lo12:data]
    ldr	x11, [x11, #:got_lo12:corr]

main_10:
    lsl	w7,	w6,	#2
    movz	w20,	#0
    movz	w0,	#0
    add	x8,	x28,	x7
    str	w20,	[x8]


main_13:
    cmp	x0,	#800
    bge	main_58

main_16:
    ldr	w4,	[x8]

    movz	w13,	#3200
    lsl	w15,	w6,	#2
    add	x17,	x0,	#1
    movz	w9,	#3200
    movz	w7,	#3200
    lsl	w22,	w6,	#2
    lsl	w10,	w6,	#2
    madd	x1,	x0,	x13,	x21

    madd	x19,	x17,	x9,	x21

    add	x14,	x1,	x15
    lsl	w1,	w6,	#2
    ldr	w16,	[x14]

    lsl	w14,	w6,	#2
    add	w26,	w16,	w4
    movz	w4,	#3200
    add	x13,	x19,	x14
    lsl	w19,	w6,	#2
    ldr	w15,	[x13]

    add	w24,	w15,	w26
    add	x26,	x17,	#1
    add	x15,	x26,	#1
    madd	x27,	x26,	x7,	x21

    lsl	w7,	w6,	#2
    add	x20,	x27,	x22
    lsl	w27,	w6,	#2
    madd	x9,	x15,	x4,	x21

    ldr	w23,	[x20]

    add	x0,	x9,	x1
    add	w14,	w23,	w24
    add	x24,	x15,	#1
    ldr	w2,	[x0]

    movz	w0,	#3200
    add	w22,	w2,	w14
    add	x5,	x24,	#1
    movz	w2,	#3200
    madd	x18,	x24,	x2,	x21

    add	x25,	x5,	#1
    madd	x26,	x5,	x0,	x21

    movz	w24,	#3200
    add	x9,	x18,	x10
    add	x18,	x26,	x19
    movz	w26,	#3200
    ldr	w13,	[x9]

    madd	x5,	x25,	x26,	x21

    ldr	w20,	[x18]

    add	w3,	w13,	w22
    add	x26,	x5,	x27
    add	w2,	w20,	w3
    ldr	w0,	[x26]

    add	w27,	w0,	w2
    add	x0,	x25,	#1
    madd	x17,	x0,	x24,	x21

    add	w0,	w0,	#1
    add	x5,	x17,	x7
    ldr	w9,	[x5]

    add	w10,	w9,	w27
    str	w10,	[x8]

    b	main_13

main_58:
    ldr	w25,	[x8]

    movz	w14,	#800
    add	w6,	w6,	#1
    sdiv	w15,	w25,	w14
    str	w15,	[x8]

    cmp	w6,	#800
    blt	main_10

main_63:
    movz	w22,	#0

main_65:
    lsl	w26,	w22,	#2
    movz	w15,	#0
    lsl	w19,	w22,	#2
    movz	w2,	#0
    add	x23,	x12,	x26
    add	x18,	x28,	x19
    str	w15,	[x23]

    ldr	w7,	[x18]


main_70:
    cmp	x2,	#800
    bge	main_131

main_73:
    ldr	w20,	[x23]

    movz	w17,	#3200
    lsl	w9,	w22,	#2
    add	x1,	x2,	#1
    movz	w4,	#3200
    lsl	w26,	w22,	#2
    lsl	w15,	w22,	#2
    madd	x17,	x2,	x17,	x21

    madd	x16,	x1,	x4,	x21

    movz	w2,	#3200
    add	x8,	x17,	x9
    add	x25,	x16,	x26
    movz	w26,	#3200
    ldr	w10,	[x8]

    lsl	w8,	w22,	#2
    ldr	w27,	[x25]

    sub	w13,	w10,	w7
    sub	w0,	w27,	w7
    lsl	w27,	w22,	#2
    madd	w19,	w13,	w13,	w20

    madd	w17,	w0,	w0,	w19

    movz	w0,	#3200
    add	x19,	x1,	#1
    add	x4,	x19,	#1
    madd	x1,	x19,	x2,	x21

    lsl	w19,	w22,	#2
    add	x6,	x1,	x8
    madd	x13,	x4,	x0,	x21

    add	x8,	x4,	#1
    ldr	w9,	[x6]

    add	x18,	x13,	x19
    sub	w10,	w9,	w7
    madd	x26,	x8,	x26,	x21

    add	x6,	x8,	#1
    ldr	w20,	[x18]

    lsl	w9,	w22,	#2
    madd	w3,	w10,	w10,	w17

    movz	w18,	#3200
    sub	w24,	w20,	w7
    movz	w20,	#3200
    madd	w25,	w24,	w24,	w3

    movz	w24,	#3200
    lsl	w3,	w22,	#2
    madd	x8,	x6,	x24,	x21

    add	x2,	x26,	x3
    add	x14,	x8,	x15
    ldr	w4,	[x2]

    add	x2,	x6,	#1
    ldr	w16,	[x14]

    sub	w5,	w4,	w7
    sub	w17,	w16,	w7
    madd	x19,	x2,	x20,	x21

    madd	w5,	w5,	w5,	w25

    add	x26,	x19,	x27
    madd	w25,	w17,	w17,	w5

    add	x19,	x2,	#1
    ldr	w0,	[x26]

    add	w2,	w19,	#1
    madd	x4,	x19,	x18,	x21

    sub	w1,	w0,	w7
    add	x8,	x4,	x9
    madd	w16,	w1,	w1,	w25

    ldr	w10,	[x8]

    sub	w13,	w10,	w7
    madd	w15,	w13,	w13,	w16

    str	w15,	[x23]

    b	main_70

main_131:
    ldr	w16,	[x23]

    movz	w18,	#800
    sdiv	w2,	w16,	w18
    mul	w3,	w2,	w2
    str	w3,	[x23]

    cmp	w3,	#1
    bgt	main_138

main_136:
    movz	w19,	#1
    str	w19,	[x23]


main_138:
    add	w22,	w22,	#1
    cmp	w22,	#800
    blt	main_65

main_141:
    movz	w7,	#0

main_143:
    movz	w22,	#3200
    movz	w13,	#0
    madd	x26,	x7,	x22,	x21


main_146:
    movz	w23,	#50176
    movk	w23,	#9,	lsl #16
    cmp	w13,	#800
    bge	main_230

main_149:
    lsl	w2,	w13,	#2
    lsl	w5,	w13,	#2
    lsl	w10,	w13,	#2
    add	x1,	x26,	x2
    add	x4,	x28,	x5
    add	x9,	x12,	x10
    ldr	w3,	[x1]

    ldr	w6,	[x4]

    ldr	w14,	[x9]

    sub	w4,	w3,	w6
    mul	w15,	w14,	w23
    sdiv	w16,	w4,	w15
    add	w15,	w13,	#1
    str	w16,	[x1]

    lsl	w0,	w15,	#2
    lsl	w22,	w15,	#2
    add	w25,	w15,	#1
    lsl	w18,	w15,	#2
    add	x27,	x12,	x0
    add	x20,	x28,	x22
    add	x9,	x26,	x18
    lsl	w16,	w25,	#2
    lsl	w10,	w25,	#2
    lsl	w6,	w25,	#2
    ldr	w8,	[x9]

    add	x15,	x12,	x16
    add	x4,	x26,	x6
    ldr	w24,	[x20]

    ldr	w1,	[x27]

    sub	w5,	w8,	w24
    mul	w2,	w1,	w23
    sdiv	w3,	w5,	w2
    str	w3,	[x9]

    add	x9,	x28,	x10
    ldr	w1,	[x4]

    ldr	w13,	[x9]

    add	w9,	w25,	#1
    ldr	w17,	[x15]

    sub	w24,	w1,	w13
    mul	w18,	w17,	w23
    lsl	w0,	w9,	#2
    sdiv	w19,	w24,	w18
    add	x27,	x28,	x0
    lsl	w24,	w9,	#2
    str	w19,	[x4]

    add	x14,	x26,	x24
    lsl	w4,	w9,	#2
    add	x3,	x12,	x4
    ldr	w19,	[x14]

    add	w4,	w9,	#1
    ldr	w1,	[x27]

    ldr	w5,	[x3]

    sub	w17,	w19,	w1
    lsl	w20,	w4,	#2
    lsl	w16,	w4,	#2
    lsl	w13,	w4,	#2
    mul	w6,	w5,	w23
    add	x19,	x12,	x20
    add	x15,	x28,	x16
    sdiv	w8,	w17,	w6
    add	x6,	x26,	x13
    str	w8,	[x14]

    ldr	w9,	[x6]

    ldr	w17,	[x15]

    ldr	w22,	[x19]

    sub	w5,	w9,	w17
    mul	w24,	w22,	w23
    sdiv	w25,	w5,	w24
    add	w24,	w4,	#1
    str	w25,	[x6]

    lsl	w9,	w24,	#2
    lsl	w4,	w24,	#2
    lsl	w1,	w24,	#2
    add	x8,	x12,	x9
    add	x3,	x28,	x4
    add	x19,	x26,	x1
    add	w4,	w24,	#1
    ldr	w2,	[x19]

    lsl	w27,	w4,	#2
    lsl	w20,	w4,	#2
    lsl	w17,	w4,	#2
    ldr	w5,	[x3]

    add	x25,	x12,	x27
    ldr	w10,	[x8]

    sub	w0,	w2,	w5
    mul	w13,	w10,	w23
    add	x10,	x26,	x17
    sdiv	w14,	w0,	w13
    str	w14,	[x19]

    add	x19,	x28,	x20
    ldr	w18,	[x10]

    ldr	w22,	[x19]

    ldr	w0,	[x25]

    sub	w18,	w18,	w22
    mul	w1,	w0,	w23
    sdiv	w2,	w18,	w1
    add	w18,	w4,	#1
    str	w2,	[x10]

    add	w13,	w18,	#1
    lsl	w9,	w18,	#2
    lsl	w5,	w18,	#2
    add	x8,	x28,	x9
    add	x17,	x26,	x5
    ldr	w15,	[x17]

    ldr	w10,	[x8]

    sub	w19,	w15,	w10
    lsl	w15,	w18,	#2
    add	x14,	x12,	x15
    ldr	w16,	[x14]

    mul	w23,	w16,	w23
    sdiv	w24,	w19,	w23
    str	w24,	[x17]

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

    lsl	x9,	x13,	#2
    lsl	x5,	x25,	#2
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

