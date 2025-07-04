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
    add	x18,	sp,	#16
    add	x17,	sp,	#3216
    adrp	x23, :got:corr
    adrp	x25, :got:data
    ldr	x25, [x25, #:got_lo12:data]
    ldr	x23, [x23, #:got_lo12:corr]

main_10:
    lsl	w7,	w2,	#2
    movz	w20,	#0
    movz	w27,	#0
    add	x21,	x17,	x7
    str	w20,	[x21]


main_13:
    cmp	x27,	#800
    blt	main_16

main_58:
    ldr	w7,	[x21]

    movz	w22,	#800
    add	w2,	w2,	#1
    sdiv	w0,	w7,	w22
    str	w0,	[x21]

    cmp	w2,	#800
    blt	main_10

main_63:
    movz	w6,	#0

main_65:
    lsl	w14,	w6,	#2
    movz	w26,	#0
    lsl	w7,	w6,	#2
    movz	w12,	#0
    add	x11,	x18,	x14
    add	x5,	x17,	x7
    str	w26,	[x11]

    ldr	w0,	[x5]


main_70:
    cmp	x12,	#800
    blt	main_73

main_131:
    ldr	w20,	[x11]

    movz	w28,	#800
    sdiv	w12,	w20,	w28
    mul	w13,	w12,	w12
    str	w13,	[x11]

    cmp	w13,	#1
    bgt	main_138

main_136:
    movz	w0,	#1
    str	w0,	[x11]


main_138:
    add	w6,	w6,	#1
    cmp	w6,	#800
    blt	main_65

main_141:
    movz	w3,	#0

main_143:
    movz	w1,	#3200
    movz	w14,	#0
    madd	x0,	x3,	x1,	x25


main_146:
    movz	w21,	#50176
    movk	w21,	#9,	lsl #16
    cmp	w14,	#800
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
    madd	x28,	x3,	x10,	x23

    mov	w15,	w4
    add	x27,	x28,	x9
    str	w2,	[x27]


main_241:
    lsl	x13,	x15,	#2
    movz	w14,	#0
    add	x0,	x28,	x13
    str	w14,	[x0]

    movz	w14,	#0

main_244:
    cmp	x14,	#800
    blt	main_247

main_313:
    movz	w18,	#3200
    lsl	x13,	x3,	#2
    ldr	w20,	[x0]

    madd	x18,	x15,	x18,	x23

    add	w15,	w15,	#1
    add	x19,	x18,	x13
    str	w20,	[x19]

    cmp	w15,	#800
    blt	main_241

main_319:
    cmp	w4,	#799
    bge	main_321

main_234:
    mov	w3,	w4
    b	main_235

main_321:
    movz	w20,	#896
    movz	w27,	#1
    movz	w0,	#81
    movk	w20,	#39,	lsl #16
    add	x28,	x23,	x20
    add	x19,	x28,	#3196
    str	w27,	[x19]

    bl	_sysy_stoptime
    mov	w0,	w21
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

    movz	w26,	#3200
    lsl	x12,	x3,	#2
    lsl	x17,	x15,	#2
    movz	w20,	#3200
    lsl	x6,	x3,	#2
    lsl	x9,	x15,	#2
    madd	x5,	x14,	x26,	x25

    add	x16,	x5,	x17
    add	x11,	x5,	x12
    lsl	x17,	x3,	#2
    add	x5,	x14,	#1
    movz	w14,	#3200
    ldr	w24,	[x11]

    madd	x7,	x5,	x20,	x25

    movz	w11,	#3200
    ldr	w18,	[x16]

    lsl	x20,	x15,	#2
    add	x16,	x7,	x17
    madd	w26,	w18,	w24,	w2

    add	x19,	x7,	x20
    movz	w17,	#3200
    lsl	x18,	x3,	#2
    movz	w2,	#3200
    add	x24,	x5,	#1
    ldr	w27,	[x16]

    lsl	x7,	x3,	#2
    ldr	w22,	[x19]

    lsl	x19,	x3,	#2
    madd	w20,	w22,	w27,	w26

    lsl	x22,	x15,	#2
    madd	x26,	x24,	x17,	x25

    add	x8,	x26,	x9
    add	x5,	x26,	x6
    add	x26,	x24,	#1
    ldr	w17,	[x5]

    madd	x13,	x26,	x14,	x25

    movz	w5,	#3200
    ldr	w10,	[x8]

    madd	w16,	w10,	w17,	w20

    add	x20,	x13,	x22
    lsl	x10,	x15,	#2
    add	x17,	x13,	x18
    ldr	w6,	[x17]

    add	x17,	x26,	#1
    ldr	w24,	[x20]

    lsl	x20,	x3,	#2
    madd	w16,	w24,	w6,	w16

    lsl	x24,	x15,	#2
    madd	x8,	x17,	x11,	x25

    add	x9,	x8,	x10
    add	x6,	x8,	x7
    movz	w8,	#3200
    add	x7,	x17,	#1
    ldr	w22,	[x6]

    add	x13,	x7,	#1
    ldr	w11,	[x9]

    madd	w9,	w11,	w22,	w16

    lsl	x11,	x15,	#2
    madd	x22,	x7,	x8,	x25

    add	x6,	x13,	#1
    madd	x16,	x13,	x5,	x25

    lsl	x8,	x3,	#2
    add	x18,	x22,	x19
    add	x22,	x22,	x24
    madd	x5,	x6,	x2,	x25

    add	x7,	x16,	x8
    ldr	w10,	[x18]

    ldr	w26,	[x22]

    ldr	w1,	[x7]

    madd	w19,	w26,	w10,	w9

    lsl	x26,	x15,	#2
    add	x10,	x16,	x11
    add	x24,	x5,	x26
    ldr	w12,	[x10]

    madd	w11,	w12,	w1,	w19

    add	x19,	x5,	x20
    ldr	w14,	[x19]

    ldr	w27,	[x24]

    madd	w2,	w27,	w14,	w11

    add	w14,	w6,	#1
    str	w2,	[x0]

    b	main_244

main_149:
    lsl	w6,	w14,	#2
    lsl	w9,	w14,	#2
    lsl	w13,	w14,	#2
    add	x20,	x0,	x6
    add	x8,	x17,	x9
    add	x12,	x18,	x13
    ldr	w4,	[x20]

    ldr	w10,	[x8]

    ldr	w15,	[x12]

    sub	w4,	w4,	w10
    mul	w16,	w15,	w21
    sdiv	w19,	w4,	w16
    add	w16,	w14,	#1
    str	w19,	[x20]

    lsl	w5,	w16,	#2
    lsl	w28,	w16,	#2
    lsl	w24,	w16,	#2
    add	x4,	x18,	x5
    add	x27,	x17,	x28
    add	x19,	x0,	x24
    ldr	w10,	[x19]

    ldr	w1,	[x27]

    ldr	w6,	[x4]

    sub	w2,	w10,	w1
    mul	w7,	w6,	w21
    add	w10,	w16,	#1
    sdiv	w8,	w2,	w7
    lsl	w20,	w10,	#2
    lsl	w14,	w10,	#2
    lsl	w11,	w10,	#2
    str	w8,	[x19]

    add	x13,	x17,	x14
    add	x19,	x18,	x20
    add	x11,	x0,	x11
    ldr	w2,	[x11]

    ldr	w15,	[x13]

    add	w13,	w10,	#1
    ldr	w22,	[x19]

    sub	w16,	w2,	w15
    mul	w24,	w22,	w21
    lsl	w9,	w13,	#2
    lsl	w5,	w13,	#2
    lsl	w1,	w13,	#2
    sdiv	w26,	w16,	w24
    add	x8,	x18,	x9
    add	x4,	x17,	x5
    str	w26,	[x11]

    add	x26,	x0,	x1
    ldr	w22,	[x26]

    ldr	w6,	[x4]

    ldr	w10,	[x8]

    sub	w15,	w22,	w6
    mul	w11,	w10,	w21
    sdiv	w12,	w15,	w11
    add	w11,	w13,	#1
    str	w12,	[x26]

    add	w24,	w11,	#1
    lsl	w27,	w11,	#2
    lsl	w20,	w11,	#2
    lsl	w15,	w11,	#2
    add	x26,	x18,	x27
    lsl	w13,	w24,	#2
    lsl	w9,	w24,	#2
    lsl	w6,	w24,	#2
    add	x19,	x17,	x20
    add	x16,	x0,	x15
    add	x12,	x18,	x13
    add	x8,	x17,	x9
    add	x27,	x0,	x6
    add	w9,	w24,	#1
    ldr	w10,	[x16]

    ldr	w22,	[x19]

    ldr	w28,	[x26]

    sub	w7,	w10,	w22
    mul	w1,	w28,	w21
    lsl	w22,	w9,	#2
    sdiv	w2,	w7,	w1
    add	x1,	x0,	x22
    str	w2,	[x16]

    add	w22,	w9,	#1
    ldr	w4,	[x27]

    ldr	w10,	[x8]

    ldr	w14,	[x12]

    sub	w28,	w4,	w10
    lsl	w13,	w22,	#2
    mul	w15,	w14,	w21
    lsl	w10,	w22,	#2
    lsl	w4,	w9,	#2
    add	x12,	x17,	x13
    sdiv	w16,	w28,	w15
    add	x2,	x18,	x4
    str	w16,	[x27]

    lsl	w27,	w9,	#2
    ldr	w19,	[x1]

    add	x26,	x17,	x27
    ldr	w28,	[x26]

    ldr	w5,	[x2]

    sub	w20,	w19,	w28
    mul	w6,	w5,	w21
    lsl	w19,	w22,	#2
    add	x5,	x0,	x10
    sdiv	w7,	w20,	w6
    add	x16,	x18,	x19
    str	w7,	[x1]

    ldr	w11,	[x5]

    ldr	w14,	[x12]

    ldr	w20,	[x16]

    sub	w10,	w11,	w14
    mul	w1,	w20,	w21
    add	w14,	w22,	#1
    sdiv	w2,	w10,	w1
    str	w2,	[x5]

    b	main_146

main_73:
    ldr	w16,	[x11]

    movz	w26,	#3200
    lsl	w8,	w6,	#2
    add	x21,	x12,	#1
    movz	w24,	#3200
    lsl	w14,	w6,	#2
    movz	w22,	#3200
    lsl	w27,	w6,	#2
    lsl	w4,	w6,	#2
    madd	x28,	x12,	x26,	x25

    add	x7,	x28,	x8
    ldr	w9,	[x7]

    movz	w7,	#3200
    sub	w10,	w9,	w0
    movz	w9,	#3200
    madd	w2,	w10,	w10,	w16

    madd	x16,	x21,	x24,	x25

    add	x24,	x21,	#1
    add	x13,	x16,	x14
    lsl	w21,	w6,	#2
    madd	x1,	x24,	x22,	x25

    ldr	w15,	[x13]

    add	x24,	x24,	#1
    add	x26,	x1,	x27
    sub	w16,	w15,	w0
    lsl	w15,	w6,	#2
    madd	x13,	x24,	x9,	x25

    ldr	w28,	[x26]

    madd	w5,	w16,	w16,	w2

    lsl	w9,	w6,	#2
    sub	w1,	w28,	w0
    add	x8,	x13,	x9
    add	x9,	x24,	#1
    madd	w22,	w1,	w1,	w5

    ldr	w10,	[x8]

    movz	w1,	#3200
    add	x28,	x9,	#1
    madd	x26,	x9,	x7,	x25

    movz	w5,	#3200
    sub	w12,	w10,	w0
    add	x20,	x26,	x21
    madd	x9,	x28,	x5,	x25

    madd	w27,	w12,	w12,	w22

    add	x3,	x9,	x4
    add	x12,	x28,	#1
    ldr	w22,	[x20]

    lsl	w28,	w6,	#2
    sub	w24,	w22,	w0
    ldr	w5,	[x3]

    movz	w3,	#3200
    sub	w7,	w5,	w0
    madd	w26,	w24,	w24,	w27

    madd	x21,	x12,	x3,	x25

    madd	w2,	w7,	w7,	w26

    add	x14,	x21,	x15
    ldr	w16,	[x14]

    sub	w19,	w16,	w0
    add	x16,	x12,	#1
    madd	w3,	w19,	w19,	w2

    add	w12,	w16,	#1
    madd	x4,	x16,	x1,	x25

    add	x27,	x4,	x28
    ldr	w1,	[x27]

    sub	w2,	w1,	w0
    madd	w4,	w2,	w2,	w3

    str	w4,	[x11]

    b	main_70

main_16:
    ldr	w4,	[x21]

    movz	w13,	#3200
    lsl	w10,	w2,	#2
    add	x12,	x27,	#1
    lsl	w22,	w2,	#2
    lsl	w3,	w2,	#2
    movz	w7,	#3200
    movz	w5,	#3200
    lsl	w19,	w2,	#2
    madd	x15,	x27,	x13,	x25

    add	x0,	x12,	#1
    add	x9,	x15,	x10
    lsl	w15,	w2,	#2
    lsl	w10,	w2,	#2
    ldr	w11,	[x9]

    add	x13,	x0,	#1
    movz	w9,	#3200
    add	w1,	w11,	w4
    movz	w11,	#3200
    add	x26,	x13,	#1
    madd	x6,	x13,	x7,	x25

    madd	x27,	x0,	x9,	x25

    madd	x14,	x12,	x11,	x25

    lsl	w0,	w2,	#2
    add	x9,	x6,	x10
    add	x8,	x26,	#1
    madd	x13,	x26,	x5,	x25

    add	x20,	x14,	x22
    add	x16,	x13,	x19
    ldr	w24,	[x20]

    add	w28,	w24,	w1
    add	x1,	x27,	x3
    movz	w3,	#3200
    ldr	w4,	[x1]

    madd	x26,	x8,	x3,	x25

    ldr	w11,	[x9]

    add	w12,	w4,	w28
    ldr	w20,	[x16]

    add	x28,	x26,	x0
    add	w22,	w11,	w12
    ldr	w1,	[x28]

    movz	w28,	#3200
    add	w7,	w20,	w22
    add	x20,	x8,	#1
    lsl	w8,	w2,	#2
    add	w16,	w1,	w7
    movz	w1,	#3200
    madd	x5,	x20,	x1,	x25

    add	x1,	x20,	#1
    add	x7,	x5,	x8
    add	w27,	w1,	#1
    madd	x12,	x1,	x28,	x25

    ldr	w9,	[x7]

    add	x14,	x12,	x15
    add	w0,	w9,	w16
    ldr	w16,	[x14]

    add	w19,	w16,	w0
    str	w19,	[x21]

    b	main_13

