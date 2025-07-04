.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global data
.align	2
data:
.type data, %object
    .zero	2560000

.global corr
.align	2
corr:
.type corr, %object
    .zero	2560000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
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
    movz	w2,	#0
    add	x6,	sp,	#16
    add	x18,	sp,	#3216
    adrp	x15, :got:corr
    adrp	x25, :got:data
    ldr	x25, [x25, #:got_lo12:data]
    ldr	x15, [x15, #:got_lo12:corr]

main_10:
    lsl	w8,	w2,	#2
    movz	w21,	#0
    movz	w27,	#0
    add	x22,	x18,	x8
    str	w21,	[x22]


main_13:
    cmp	x27,	#800
    blt	main_16

main_58:
    ldr	w8,	[x22]

    movz	w23,	#800
    add	w2,	w2,	#1
    sdiv	w0,	w8,	w23
    str	w0,	[x22]

    cmp	w2,	#800
    blt	main_10

main_63:
    movz	w7,	#0

main_65:
    lsl	w16,	w7,	#2
    movz	w26,	#0
    lsl	w8,	w7,	#2
    movz	w13,	#0
    add	x12,	x6,	x16
    add	x5,	x18,	x8
    str	w26,	[x12]

    ldr	w0,	[x5]


main_70:
    cmp	x13,	#800
    blt	main_73

main_131:
    ldr	w21,	[x12]

    movz	w28,	#800
    sdiv	w13,	w21,	w28
    mul	w14,	w13,	w13
    str	w14,	[x12]

    cmp	w14,	#1
    bgt	main_138

main_136:
    movz	w0,	#1
    str	w0,	[x12]


main_138:
    add	w7,	w7,	#1
    cmp	w7,	#800
    blt	main_65

main_141:
    movz	w3,	#0

main_143:
    movz	w1,	#3200
    movz	w16,	#0
    madd	x0,	x3,	x1,	x25


main_146:
    movz	w26,	#50176
    movk	w26,	#9,	lsl #16
    cmp	w16,	#800
    blt	main_149

main_230:
    add	w3,	w3,	#1
    cmp	w3,	#800
    blt	main_143

main_233:
    movz	w3,	#0

main_235:
    movz	w10,	#3200
    lsl	x9,	x3,	#2
    movz	w2,	#1
    add	w4,	w3,	#1
    madd	x28,	x3,	x10,	x15

    mov	w16,	w4
    add	x27,	x28,	x9
    str	w2,	[x27]


main_241:
    lsl	x13,	x16,	#2
    movz	w14,	#0
    add	x0,	x28,	x13
    str	w14,	[x0]

    movz	w14,	#0

main_244:
    cmp	x14,	#800
    blt	main_247

main_313:
    movz	w19,	#3200
    lsl	x13,	x3,	#2
    ldr	w21,	[x0]

    madd	x19,	x16,	x19,	x15

    add	w16,	w16,	#1
    add	x20,	x19,	x13
    str	w21,	[x20]

    cmp	w16,	#800
    blt	main_241

main_319:
    cmp	w4,	#799
    bge	main_321

main_234:
    mov	w3,	w4
    b	main_235

main_321:
    movz	w28,	#896
    movz	w27,	#1
    movz	w0,	#81
    movk	w28,	#39,	lsl #16
    add	x28,	x15,	x28
    add	x19,	x28,	#3196
    str	w27,	[x19]

    bl	_sysy_stoptime
    mov	w0,	w26
    adrp	x1, :got:corr
    ldr	x1, [x1, #:got_lo12:corr]
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#6416
    add	sp, sp, fp
    ret


main_247:
    ldr	w2,	[x0]

    movz	w24,	#3200
    lsl	x12,	x3,	#2
    lsl	x18,	x16,	#2
    movz	w21,	#3200
    lsl	x6,	x3,	#2
    lsl	x9,	x16,	#2
    madd	x5,	x14,	x24,	x25

    add	x17,	x5,	x18
    add	x11,	x5,	x12
    lsl	x18,	x3,	#2
    add	x5,	x14,	#1
    movz	w14,	#3200
    ldr	w23,	[x11]

    madd	x7,	x5,	x21,	x25

    movz	w11,	#3200
    ldr	w19,	[x17]

    lsl	x21,	x16,	#2
    add	x17,	x7,	x18
    madd	w24,	w19,	w23,	w2

    add	x20,	x7,	x21
    movz	w18,	#3200
    movz	w2,	#3200
    lsl	x19,	x3,	#2
    add	x23,	x5,	#1
    ldr	w27,	[x17]

    lsl	x7,	x3,	#2
    ldr	w22,	[x20]

    lsl	x20,	x3,	#2
    madd	w21,	w22,	w27,	w24

    lsl	x22,	x16,	#2
    madd	x24,	x23,	x18,	x25

    add	x8,	x24,	x9
    add	x5,	x24,	x6
    add	x24,	x23,	#1
    ldr	w18,	[x5]

    madd	x13,	x24,	x14,	x25

    movz	w5,	#3200
    ldr	w10,	[x8]

    madd	w17,	w10,	w18,	w21

    lsl	x10,	x16,	#2
    add	x21,	x13,	x22
    add	x18,	x13,	x19
    ldr	w6,	[x18]

    add	x18,	x24,	#1
    ldr	w23,	[x21]

    lsl	x21,	x3,	#2
    madd	w17,	w23,	w6,	w17

    lsl	x23,	x16,	#2
    madd	x8,	x18,	x11,	x25

    add	x9,	x8,	x10
    add	x6,	x8,	x7
    movz	w8,	#3200
    add	x7,	x18,	#1
    ldr	w22,	[x6]

    add	x13,	x7,	#1
    ldr	w11,	[x9]

    madd	w9,	w11,	w22,	w17

    lsl	x11,	x16,	#2
    madd	x22,	x7,	x8,	x25

    add	x6,	x13,	#1
    madd	x17,	x13,	x5,	x25

    lsl	x8,	x3,	#2
    add	x19,	x22,	x20
    add	x22,	x22,	x23
    madd	x5,	x6,	x2,	x25

    add	x7,	x17,	x8
    ldr	w10,	[x19]

    ldr	w24,	[x22]

    ldr	w1,	[x7]

    madd	w20,	w24,	w10,	w9

    lsl	x24,	x16,	#2
    add	x10,	x17,	x11
    add	x23,	x5,	x24
    ldr	w12,	[x10]

    madd	w11,	w12,	w1,	w20

    add	x20,	x5,	x21
    ldr	w14,	[x20]

    ldr	w27,	[x23]

    madd	w2,	w27,	w14,	w11

    add	w14,	w6,	#1
    str	w2,	[x0]

    b	main_244

main_149:
    lsl	w7,	w16,	#2
    lsl	w10,	w16,	#2
    lsl	w14,	w16,	#2
    add	x21,	x0,	x7
    add	x9,	x18,	x10
    add	x13,	x6,	x14
    ldr	w4,	[x21]

    ldr	w11,	[x9]

    ldr	w17,	[x13]

    sub	w4,	w4,	w11
    mul	w19,	w17,	w26
    sdiv	w20,	w4,	w19
    add	w19,	w16,	#1
    str	w20,	[x21]

    lsl	w5,	w19,	#2
    lsl	w28,	w19,	#2
    lsl	w23,	w19,	#2
    add	x4,	x6,	x5
    add	x27,	x18,	x28
    add	x20,	x0,	x23
    ldr	w11,	[x20]

    ldr	w1,	[x27]

    ldr	w7,	[x4]

    sub	w2,	w11,	w1
    mul	w8,	w7,	w26
    add	w11,	w19,	#1
    sdiv	w9,	w2,	w8
    lsl	w21,	w11,	#2
    lsl	w16,	w11,	#2
    lsl	w12,	w11,	#2
    str	w9,	[x20]

    add	x14,	x18,	x16
    add	x20,	x6,	x21
    add	x12,	x0,	x12
    ldr	w2,	[x12]

    ldr	w17,	[x14]

    add	w14,	w11,	#1
    ldr	w22,	[x20]

    sub	w19,	w2,	w17
    mul	w23,	w22,	w26
    lsl	w10,	w14,	#2
    lsl	w5,	w14,	#2
    lsl	w1,	w14,	#2
    sdiv	w24,	w19,	w23
    add	x9,	x6,	x10
    add	x4,	x18,	x5
    str	w24,	[x12]

    add	x24,	x0,	x1
    ldr	w22,	[x24]

    ldr	w7,	[x4]

    ldr	w11,	[x9]

    sub	w17,	w22,	w7
    mul	w12,	w11,	w26
    sdiv	w13,	w17,	w12
    add	w12,	w14,	#1
    str	w13,	[x24]

    add	w23,	w12,	#1
    lsl	w27,	w12,	#2
    lsl	w21,	w12,	#2
    lsl	w17,	w12,	#2
    add	x24,	x6,	x27
    lsl	w14,	w23,	#2
    lsl	w10,	w23,	#2
    lsl	w7,	w23,	#2
    add	x20,	x18,	x21
    add	x19,	x0,	x17
    add	x13,	x6,	x14
    add	x9,	x18,	x10
    add	x27,	x0,	x7
    add	w10,	w23,	#1
    ldr	w11,	[x19]

    ldr	w22,	[x20]

    ldr	w28,	[x24]

    sub	w8,	w11,	w22
    mul	w1,	w28,	w26
    lsl	w22,	w10,	#2
    sdiv	w2,	w8,	w1
    add	x1,	x0,	x22
    str	w2,	[x19]

    add	w22,	w10,	#1
    ldr	w4,	[x27]

    ldr	w11,	[x9]

    ldr	w16,	[x13]

    sub	w28,	w4,	w11
    lsl	w14,	w22,	#2
    mul	w17,	w16,	w26
    lsl	w4,	w10,	#2
    lsl	w11,	w22,	#2
    add	x13,	x18,	x14
    sdiv	w19,	w28,	w17
    add	x2,	x6,	x4
    str	w19,	[x27]

    lsl	w27,	w10,	#2
    ldr	w20,	[x1]

    add	x24,	x18,	x27
    ldr	w28,	[x24]

    ldr	w5,	[x2]

    sub	w21,	w20,	w28
    mul	w7,	w5,	w26
    lsl	w20,	w22,	#2
    add	x5,	x0,	x11
    sdiv	w8,	w21,	w7
    add	x19,	x6,	x20
    str	w8,	[x1]

    ldr	w12,	[x5]

    ldr	w16,	[x13]

    ldr	w21,	[x19]

    sub	w11,	w12,	w16
    mul	w1,	w21,	w26
    add	w16,	w22,	#1
    sdiv	w2,	w11,	w1
    str	w2,	[x5]

    b	main_146

main_73:
    ldr	w19,	[x12]

    movz	w26,	#3200
    lsl	w9,	w7,	#2
    add	x22,	x13,	#1
    movz	w24,	#3200
    lsl	w16,	w7,	#2
    lsl	w27,	w7,	#2
    lsl	w4,	w7,	#2
    madd	x28,	x13,	x26,	x25

    add	x8,	x28,	x9
    ldr	w10,	[x8]

    add	x8,	x22,	#1
    sub	w11,	w10,	w0
    movz	w10,	#3200
    madd	w2,	w11,	w11,	w19

    madd	x19,	x22,	x24,	x25

    add	x24,	x8,	#1
    movz	w22,	#3200
    add	x14,	x19,	x16
    madd	x1,	x8,	x22,	x25

    movz	w8,	#3200
    lsl	w22,	w7,	#2
    ldr	w17,	[x14]

    add	x26,	x1,	x27
    madd	x14,	x24,	x10,	x25

    sub	w19,	w17,	w0
    lsl	w10,	w7,	#2
    lsl	w17,	w7,	#2
    ldr	w28,	[x26]

    madd	w5,	w19,	w19,	w2

    add	x9,	x14,	x10
    sub	w1,	w28,	w0
    add	x10,	x24,	#1
    ldr	w11,	[x9]

    madd	w23,	w1,	w1,	w5

    add	x28,	x10,	#1
    madd	x26,	x10,	x8,	x25

    sub	w13,	w11,	w0
    movz	w5,	#3200
    movz	w1,	#3200
    add	x21,	x26,	x22
    madd	w27,	w13,	w13,	w23

    madd	x10,	x28,	x5,	x25

    add	x13,	x28,	#1
    add	x3,	x10,	x4
    ldr	w23,	[x21]

    lsl	w28,	w7,	#2
    sub	w24,	w23,	w0
    ldr	w5,	[x3]

    movz	w3,	#3200
    sub	w8,	w5,	w0
    madd	w26,	w24,	w24,	w27

    madd	x22,	x13,	x3,	x25

    madd	w2,	w8,	w8,	w26

    add	x16,	x22,	x17
    ldr	w19,	[x16]

    sub	w20,	w19,	w0
    add	x19,	x13,	#1
    madd	w3,	w20,	w20,	w2

    add	w13,	w19,	#1
    madd	x4,	x19,	x1,	x25

    add	x27,	x4,	x28
    ldr	w1,	[x27]

    sub	w2,	w1,	w0
    madd	w4,	w2,	w2,	w3

    str	w4,	[x12]

    b	main_70

main_16:
    ldr	w4,	[x22]

    movz	w13,	#3200
    lsl	w11,	w2,	#2
    lsl	w23,	w2,	#2
    movz	w9,	#3200
    lsl	w3,	w2,	#2
    movz	w7,	#3200
    movz	w5,	#3200
    lsl	w20,	w2,	#2
    madd	x17,	x27,	x13,	x25

    add	x13,	x27,	#1
    add	x10,	x17,	x11
    lsl	w17,	w2,	#2
    movz	w11,	#3200
    ldr	w12,	[x10]

    add	x0,	x13,	#1
    madd	x16,	x13,	x11,	x25

    add	w1,	w12,	w4
    lsl	w11,	w2,	#2
    add	x21,	x16,	x23
    madd	x27,	x0,	x9,	x25

    add	x0,	x0,	#1
    ldr	w24,	[x21]

    add	w28,	w24,	w1
    add	x26,	x0,	#1
    madd	x7,	x0,	x7,	x25

    add	x1,	x27,	x3
    lsl	w0,	w2,	#2
    add	x10,	x7,	x11
    movz	w3,	#3200
    add	x9,	x26,	#1
    madd	x14,	x26,	x5,	x25

    ldr	w4,	[x1]

    add	x19,	x14,	x20
    ldr	w12,	[x10]

    add	w28,	w4,	w28
    madd	x26,	x9,	x3,	x25

    ldr	w21,	[x19]

    add	w23,	w12,	w28
    add	x28,	x26,	x0
    add	w8,	w21,	w23
    ldr	w1,	[x28]

    add	x21,	x9,	#1
    movz	w28,	#3200
    lsl	w9,	w2,	#2
    add	w19,	w1,	w8
    movz	w1,	#3200
    madd	x5,	x21,	x1,	x25

    add	x1,	x21,	#1
    add	x8,	x5,	x9
    add	w27,	w1,	#1
    madd	x13,	x1,	x28,	x25

    ldr	w10,	[x8]

    add	x16,	x13,	x17
    add	w0,	w10,	w19
    ldr	w19,	[x16]

    add	w20,	w19,	w0
    str	w20,	[x22]

    b	main_13

