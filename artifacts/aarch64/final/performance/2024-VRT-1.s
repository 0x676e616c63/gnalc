.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global a
.align	2
a:
.type a, %object
    .zero	4000000

.global b
.align	2
b:
.type b, %object
    .zero	4000000

.global c
.align	2
c:
.type c, %object
    .zero	4000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w20,	#0

main_2:
    cmp	x20,	#1000
    blt	main_5

main_11:
    movz	w0,	#23
    bl	_sysy_starttime
    movz	w3,	#0

main_13:
    movz	w27,	#4000
    adrp	x13, :got:b
    movz	w28,	#0
    ldr	x13, [x13, #:got_lo12:b]
    madd	x14,	x3,	x27,	x13


main_16:
    cmp	x28,	#1000
    blt	main_19

main_60:
    add	w3,	w3,	#1
    cmp	w3,	#1000
    blt	main_13

main_63:
    movz	w21,	#0

main_65:
    movz	w0,	#4000
    adrp	x19, :got:a
    movz	w28,	#4000
    adrp	x7, :got:c
    movz	w22,	#0
    ldr	x19, [x19, #:got_lo12:a]
    ldr	x7, [x7, #:got_lo12:c]
    madd	x17,	x21,	x0,	x19

    madd	x24,	x21,	x28,	x7


main_70:
    movz	w2,	#0
    movz	w26,	#0

main_72:
    cmp	x2,	#1000
    blt	main_76

main_165:
    lsl	w19,	w22,	#2
    add	w22,	w22,	#1
    add	x18,	x24,	x19
    str	w26,	[x18]

    cmp	w22,	#1000
    blt	main_70

main_169:
    add	w21,	w21,	#1
    cmp	w21,	#1000
    blt	main_65

main_172:
    movz	w12,	#0

main_174:
    movz	w2,	#4000
    adrp	x5, :got:c
    movz	w14,	#0
    movz	w6,	#65535
    ldr	x5, [x5, #:got_lo12:c]
    movk	w6,	#32767,	lsl #16
    madd	x23,	x12,	x2,	x5


main_177:
    cmp	w14,	#1000
    blt	main_181

main_222:
    movz	w8,	#0

main_223:
    cmp	w8,	#1000
    blt	main_226

main_243:
    add	w12,	w12,	#1
    cmp	w12,	#1000
    blt	main_174

main_246:
    movz	w18,	#0

main_248:
    movz	w3,	#4000
    adrp	x12, :got:c
    movz	w22,	#0
    ldr	x12, [x12, #:got_lo12:c]
    madd	x12,	x18,	x3,	x12


main_251:
    cmp	x22,	#1000
    blt	main_254

main_303:
    add	w18,	w18,	#1
    cmp	w18,	#1000
    blt	main_248

main_306:
    movz	w4,	#0
    movz	w27,	#0

main_308:
    movz	w15,	#4000
    adrp	x5, :got:c
    movz	w21,	#0
    ldr	x5, [x5, #:got_lo12:c]
    madd	x2,	x4,	x15,	x5


main_312:
    cmp	w21,	#1000
    blt	main_316

main_349:
    add	w4,	w4,	#1
    cmp	w4,	#1000
    blt	main_308

main_352:
    movz	w0,	#93
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#0
    b	main_354

main_316:
    lsl	w16,	w21,	#2
    add	w18,	w21,	#1
    add	x15,	x2,	x16
    add	w25,	w18,	#1
    lsl	w0,	w18,	#2
    ldr	w17,	[x15]

    add	x28,	x2,	x0
    lsl	w7,	w25,	#2
    add	w27,	w17,	w27
    ldr	w1,	[x28]

    add	x6,	x2,	x7
    add	w23,	w1,	w27
    add	w1,	w25,	#1
    ldr	w8,	[x6]

    add	w0,	w8,	w23
    lsl	w12,	w1,	#2
    add	w8,	w1,	#1
    add	x11,	x2,	x12
    lsl	w17,	w8,	#2
    ldr	w13,	[x11]

    add	x16,	x2,	x17
    add	w7,	w13,	w0
    add	w13,	w8,	#1
    ldr	w18,	[x16]

    add	w12,	w18,	w7
    lsl	w22,	w13,	#2
    add	w18,	w13,	#1
    add	x21,	x2,	x22
    lsl	w27,	w18,	#2
    ldr	w23,	[x21]

    add	x26,	x2,	x27
    add	w17,	w23,	w12
    ldr	w28,	[x26]

    add	w26,	w18,	#1
    add	w25,	w28,	w17
    add	w21,	w26,	#1
    lsl	w5,	w26,	#2
    add	x3,	x2,	x5
    ldr	w6,	[x3]

    add	w27,	w6,	w25
    b	main_312

main_254:
    lsl	x26,	x22,	#2
    movz	w8,	#4000
    adrp	x7, :got:c
    lsl	x2,	x18,	#2
    add	x0,	x22,	#1
    lsl	x25,	x18,	#2
    adrp	x23, :got:c
    lsl	x17,	x18,	#2
    lsl	x28,	x18,	#2
    lsl	x9,	x18,	#2
    add	x21,	x12,	x26
    ldr	x7, [x7, #:got_lo12:c]
    add	x16,	x0,	#1
    lsl	x20,	x0,	#2
    madd	x6,	x22,	x8,	x7

    add	x5,	x12,	x20
    add	x1,	x6,	x2
    movz	w6,	#0
    movz	w2,	#0
    ldr	w11,	[x1]

    lsl	x1,	x16,	#2
    sub	w4,	w6,	w11
    lsl	x6,	x18,	#2
    adrp	x11, :got:c
    add	x19,	x12,	x1
    str	w4,	[x21]

    ldr	x11, [x11, #:got_lo12:c]
    movz	w4,	#4000
    madd	x8,	x0,	x4,	x11

    adrp	x4, :got:c
    movz	w0,	#4000
    add	x24,	x8,	x25
    ldr	w15,	[x24]

    sub	w27,	w2,	w15
    adrp	x15, :got:c
    str	w27,	[x5]

    movz	w27,	#0
    ldr	x23, [x23, #:got_lo12:c]
    madd	x21,	x16,	x0,	x23

    movz	w23,	#0
    add	x5,	x21,	x6
    movz	w21,	#4000
    ldr	w25,	[x5]

    add	x5,	x16,	#1
    sub	w8,	w27,	w25
    movz	w25,	#4000
    str	w8,	[x19]

    lsl	x11,	x5,	#2
    movz	w19,	#0
    ldr	x4, [x4, #:got_lo12:c]
    add	x6,	x12,	x11
    madd	x2,	x5,	x25,	x4

    add	x16,	x2,	x17
    lsl	x2,	x18,	#2
    add	x17,	x5,	#1
    ldr	w7,	[x16]

    sub	w20,	w23,	w7
    lsl	x23,	x17,	#2
    str	w20,	[x6]

    add	x22,	x12,	x23
    ldr	x15, [x15, #:got_lo12:c]
    madd	x13,	x17,	x21,	x15

    lsl	x21,	x18,	#2
    movz	w15,	#0
    add	x27,	x13,	x28
    movz	w28,	#4000
    add	x13,	x17,	#1
    movz	w17,	#4000
    ldr	w20,	[x27]

    lsl	x4,	x13,	#2
    add	x3,	x13,	#1
    adrp	x27, :got:c
    sub	w1,	w19,	w20
    add	x6,	x12,	x4
    str	w1,	[x22]

    ldr	x27, [x27, #:got_lo12:c]
    madd	x25,	x13,	x17,	x27

    movz	w13,	#4000
    add	x8,	x25,	x9
    ldr	w1,	[x8]

    adrp	x8, :got:c
    sub	w11,	w15,	w1
    lsl	x15,	x3,	#2
    str	w11,	[x6]

    add	x27,	x12,	x15
    movz	w11,	#0
    ldr	x8, [x8, #:got_lo12:c]
    madd	x6,	x3,	x13,	x8

    add	x20,	x6,	x21
    add	x21,	x3,	#1
    ldr	w13,	[x20]

    add	w22,	w21,	#1
    lsl	x26,	x21,	#2
    adrp	x20, :got:c
    sub	w23,	w11,	w13
    add	x9,	x12,	x26
    movz	w26,	#0
    str	w23,	[x27]

    ldr	x20, [x20, #:got_lo12:c]
    madd	x19,	x21,	x28,	x20

    add	x1,	x19,	x2
    ldr	w23,	[x1]

    sub	w4,	w26,	w23
    str	w4,	[x9]

    b	main_251

main_226:
    lsl	w11,	w8,	#2
    add	w25,	w8,	#1
    add	x10,	x23,	x11
    add	w28,	w25,	#1
    lsl	w2,	w25,	#2
    str	w6,	[x10]

    add	x1,	x23,	x2
    lsl	w5,	w28,	#2
    add	w2,	w28,	#1
    str	w6,	[x1]

    add	x4,	x23,	x5
    lsl	w9,	w2,	#2
    add	w5,	w2,	#1
    str	w6,	[x4]

    add	x8,	x23,	x9
    lsl	w13,	w5,	#2
    add	w9,	w5,	#1
    str	w6,	[x8]

    add	x11,	x23,	x13
    lsl	w16,	w9,	#2
    add	w13,	w9,	#1
    str	w6,	[x11]

    add	x15,	x23,	x16
    lsl	w19,	w13,	#2
    add	w16,	w13,	#1
    str	w6,	[x15]

    add	x18,	x23,	x19
    add	w8,	w16,	#1
    lsl	w22,	w16,	#2
    str	w6,	[x18]

    add	x21,	x23,	x22
    str	w6,	[x21]

    b	main_223

main_181:
    lsl	w9,	w14,	#2
    add	x8,	x23,	x9
    ldr	w10,	[x8]

    cmp	w10,	w6
    csel	w17,	w10,	w6,	lt
    add	w27,	w14,	#1
    lsl	w10,	w27,	#2
    add	x9,	x23,	x10
    ldr	w11,	[x9]

    cmp	w11,	w17
    add	w4,	w27,	#1
    csel	w3,	w11,	w17,	lt
    lsl	w17,	w4,	#2
    add	x16,	x23,	x17
    ldr	w18,	[x16]

    cmp	w18,	w3
    add	w10,	w4,	#1
    csel	w9,	w18,	w3,	lt
    lsl	w24,	w10,	#2
    add	x22,	x23,	x24
    ldr	w25,	[x22]

    cmp	w25,	w9
    add	w20,	w10,	#1
    csel	w19,	w25,	w9,	lt
    lsl	w1,	w20,	#2
    add	x0,	x23,	x1
    ldr	w2,	[x0]

    cmp	w2,	w19
    add	w28,	w20,	#1
    csel	w26,	w2,	w19,	lt
    lsl	w7,	w28,	#2
    add	x6,	x23,	x7
    ldr	w8,	[x6]

    cmp	w8,	w26
    add	w5,	w28,	#1
    csel	w4,	w8,	w26,	lt
    lsl	w14,	w5,	#2
    add	x13,	x23,	x14
    ldr	w15,	[x13]

    cmp	w15,	w4
    add	w13,	w5,	#1
    csel	w10,	w15,	w4,	lt
    lsl	w20,	w13,	#2
    add	x19,	x23,	x20
    ldr	w21,	[x19]

    cmp	w21,	w10
    add	w14,	w13,	#1
    csel	w6,	w21,	w10,	lt
    b	main_177

main_76:
    lsl	x23,	x2,	#2
    movz	w6,	#4000
    lsl	w3,	w22,	#2
    add	x20,	x17,	x23
    ldr	w12,	[x20]

    adrp	x20, :got:b
    ldr	x20, [x20, #:got_lo12:b]
    madd	x18,	x2,	x6,	x20

    add	x1,	x18,	x3
    ldr	w16,	[x1]

    mul	w28,	w16,	w12
    madd	w7,	w16,	w12,	w26

    asr	w20,	w28,	#31
    lsr	w23,	w20,	#31
    madd	w25,	w16,	w12,	w23

    asr	w20,	w25,	#1
    lsl	w23,	w20,	#1
    sub	w0,	w28,	w23
    cmp	w0,	#0
    csel	w10,	w7,	w26,	eq
    add	x11,	x2,	#1
    movz	w1,	#4000
    adrp	x15, :got:b
    lsl	w2,	w22,	#2
    lsl	x25,	x11,	#2
    add	x23,	x17,	x25
    ldr	w25,	[x23]

    ldr	x15, [x15, #:got_lo12:b]
    madd	x13,	x11,	x1,	x15

    add	x1,	x13,	x2
    ldr	w15,	[x1]

    madd	w6,	w15,	w25,	w10

    mul	w19,	w15,	w25
    asr	w3,	w19,	#31
    lsr	w4,	w3,	#31
    madd	w5,	w15,	w25,	w4

    asr	w28,	w5,	#1
    lsl	w0,	w28,	#1
    sub	w23,	w19,	w0
    cmp	w23,	#0
    csel	w26,	w6,	w10,	eq
    add	x28,	x11,	#1
    movz	w25,	#4000
    adrp	x5, :got:b
    lsl	w18,	w22,	#2
    lsl	x11,	x28,	#2
    add	x10,	x17,	x11
    ldr	w2,	[x10]

    ldr	x5, [x5, #:got_lo12:b]
    madd	x3,	x28,	x25,	x5

    add	x16,	x3,	x18
    ldr	w13,	[x16]

    madd	w25,	w13,	w2,	w26

    mul	w12,	w13,	w2
    asr	w6,	w12,	#31
    lsr	w7,	w6,	#31
    madd	w8,	w13,	w2,	w7

    asr	w20,	w8,	#1
    lsl	w23,	w20,	#1
    sub	w10,	w12,	w23
    cmp	w10,	#0
    csel	w2,	w25,	w26,	eq
    add	x5,	x28,	#1
    movz	w20,	#4000
    lsl	w7,	w22,	#2
    adrp	x25, :got:b
    lsl	x1,	x5,	#2
    add	x0,	x17,	x1
    ldr	w28,	[x0]

    ldr	x25, [x25, #:got_lo12:b]
    madd	x20,	x5,	x20,	x25

    add	x6,	x20,	x7
    ldr	w7,	[x6]

    mul	w4,	w7,	w28
    asr	w9,	w4,	#31
    lsr	w10,	w9,	#31
    madd	w11,	w7,	w28,	w10

    asr	w14,	w11,	#1
    madd	w11,	w7,	w28,	w2

    lsl	w15,	w14,	#1
    sub	w1,	w4,	w15
    cmp	w1,	#0
    csel	w4,	w11,	w2,	eq
    add	x27,	x5,	#1
    lsl	w26,	w22,	#2
    adrp	x11, :got:b
    lsl	x16,	x27,	#2
    add	x15,	x17,	x16
    ldr	w3,	[x15]

    ldr	x11, [x11, #:got_lo12:b]
    movz	w15,	#4000
    madd	x9,	x27,	x15,	x11

    add	x25,	x9,	x26
    ldr	w2,	[x25]

    madd	w1,	w2,	w3,	w4

    mul	w28,	w2,	w3
    asr	w12,	w28,	#31
    lsr	w13,	w12,	#31
    madd	w14,	w2,	w3,	w13

    asr	w9,	w14,	#1
    lsl	w10,	w9,	#1
    sub	w18,	w28,	w10
    cmp	w18,	#0
    csel	w25,	w1,	w4,	eq
    add	x13,	x27,	#1
    movz	w10,	#4000
    adrp	x2, :got:b
    lsl	w12,	w22,	#2
    lsl	x6,	x13,	#2
    add	x5,	x17,	x6
    ldr	w27,	[x5]

    ldr	x2, [x2, #:got_lo12:b]
    madd	x0,	x13,	x10,	x2

    add	x11,	x0,	x12
    ldr	w28,	[x11]

    mul	w20,	w28,	w27
    asr	w15,	w20,	#31
    lsr	w16,	w15,	#31
    madd	w18,	w28,	w27,	w16

    madd	w16,	w28,	w27,	w25

    asr	w4,	w18,	#1
    lsl	w5,	w4,	#1
    sub	w7,	w20,	w5
    cmp	w7,	#0
    csel	w4,	w16,	w25,	eq
    add	x26,	x13,	#1
    adrp	x19, :got:b
    movz	w5,	#4000
    lsl	w2,	w22,	#2
    lsl	x25,	x26,	#2
    add	x23,	x17,	x25
    ldr	w6,	[x23]

    ldr	x19, [x19, #:got_lo12:b]
    madd	x16,	x26,	x5,	x19

    add	x1,	x16,	x2
    ldr	w16,	[x1]

    mul	w10,	w16,	w6
    asr	w19,	w10,	#31
    lsr	w20,	w19,	#31
    madd	w23,	w16,	w6,	w20

    madd	w6,	w16,	w6,	w4

    asr	w28,	w23,	#1
    lsl	w0,	w28,	#1
    sub	w27,	w10,	w0
    cmp	w27,	#0
    csel	w2,	w6,	w4,	eq
    add	x3,	x26,	#1
    lsl	w18,	w22,	#2
    adrp	x9, :got:b
    movz	w0,	#4000
    lsl	x11,	x3,	#2
    add	x10,	x17,	x11
    ldr	w8,	[x10]

    ldr	x9, [x9, #:got_lo12:b]
    madd	x6,	x3,	x0,	x9

    add	x16,	x6,	x18
    ldr	w12,	[x16]

    mul	w4,	w12,	w8
    asr	w25,	w4,	#31
    lsr	w26,	w25,	#31
    madd	w25,	w12,	w8,	w2

    madd	w27,	w12,	w8,	w26

    asr	w20,	w27,	#1
    lsl	w23,	w20,	#1
    sub	w13,	w4,	w23
    cmp	w13,	#0
    csel	w26,	w25,	w2,	eq
    add	w2,	w3,	#1
    b	main_72

main_19:
    lsl	x10,	x28,	#2
    movz	w1,	#4000
    adrp	x6, :got:a
    lsl	x16,	x3,	#2
    add	x20,	x28,	#1
    movz	w27,	#4000
    adrp	x23, :got:a
    lsl	x26,	x3,	#2
    movz	w24,	#4000
    adrp	x5, :got:a
    lsl	x7,	x3,	#2
    movz	w9,	#4000
    add	x18,	x14,	x10
    ldr	x6, [x6, #:got_lo12:a]
    lsl	x21,	x20,	#2
    madd	x2,	x28,	x1,	x6

    add	x15,	x2,	x16
    add	x10,	x14,	x21
    ldr	w17,	[x15]

    adrp	x15, :got:a
    str	w17,	[x18]

    lsl	x17,	x3,	#2
    ldr	x23, [x23, #:got_lo12:a]
    madd	x21,	x20,	x27,	x23

    add	x25,	x21,	x26
    movz	w21,	#4000
    add	x26,	x20,	#1
    ldr	w27,	[x25]

    lsl	x1,	x26,	#2
    adrp	x25, :got:a
    str	w27,	[x10]

    add	x12,	x14,	x1
    ldr	x5, [x5, #:got_lo12:a]
    madd	x2,	x26,	x24,	x5

    add	x6,	x2,	x7
    add	x7,	x26,	#1
    lsl	x26,	x3,	#2
    ldr	w8,	[x6]

    lsl	x11,	x7,	#2
    add	x6,	x7,	#1
    str	w8,	[x12]

    add	x23,	x14,	x11
    ldr	x15, [x15, #:got_lo12:a]
    add	x19,	x6,	#1
    madd	x12,	x7,	x21,	x15

    movz	w15,	#4000
    lsl	x21,	x6,	#2
    lsl	x7,	x3,	#2
    add	x16,	x12,	x17
    add	x28,	x19,	#1
    lsl	x1,	x19,	#2
    movz	w12,	#4000
    adrp	x17, :got:a
    ldr	w18,	[x16]

    add	x1,	x14,	x1
    lsl	x11,	x28,	#2
    add	x16,	x14,	x21
    str	w18,	[x23]

    add	x11,	x14,	x11
    ldr	x25, [x25, #:got_lo12:a]
    movz	w18,	#4000
    madd	x22,	x6,	x18,	x25

    adrp	x6, :got:a
    add	x25,	x22,	x26
    adrp	x26, :got:a
    ldr	w27,	[x25]

    str	w27,	[x16]

    ldr	x6, [x6, #:got_lo12:a]
    madd	x4,	x19,	x15,	x6

    add	x15,	x28,	#1
    add	x6,	x4,	x7
    lsl	x21,	x15,	#2
    ldr	w8,	[x6]

    str	w8,	[x1]

    add	x22,	x14,	x21
    ldr	x17, [x17, #:got_lo12:a]
    madd	x13,	x28,	x12,	x17

    add	w28,	w15,	#1
    lsl	x17,	x3,	#2
    add	x16,	x13,	x17
    ldr	w18,	[x16]

    str	w18,	[x11]

    ldr	x26, [x26, #:got_lo12:a]
    madd	x23,	x15,	x9,	x26

    lsl	x26,	x3,	#2
    add	x25,	x23,	x26
    ldr	w27,	[x25]

    str	w27,	[x22]

    b	main_16

main_5:
    movz	w28,	#4000
    adrp	x22, :got:a
    ldr	x22, [x22, #:got_lo12:a]
    madd	x0,	x20,	x28,	x22

    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#1000
    beq	main_2

main_354:
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


