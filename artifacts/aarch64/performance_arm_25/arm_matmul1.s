.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global a
.align	2
a:
    .zero	4000000

.global b
.align	2
b:
    .zero	4000000

.global c
.align	2
c:
    .zero	4000000


.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w20,	#0

main_2:
    cmp	x20,	#1000
    bge	main_11

main_5:
    movz	w19,	#4000
    adrp	x21, :got:a
    ldr	x21, [x21, #:got_lo12:a]
    madd	x0,	x20,	x19,	x21

    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#1000
    bne	main_354
    b	main_2

main_11:
    movz	w0,	#23
    bl	_sysy_starttime
    movz	w7,	#0

main_13:
    movz	w28,	#4000
    adrp	x20, :got:b
    movz	w21,	#0
    ldr	x20, [x20, #:got_lo12:b]
    madd	x27,	x7,	x28,	x20


main_16:
    cmp	x21,	#1000
    bge	main_60

main_19:
    lsl	x9,	x21,	#2
    movz	w23,	#4000
    adrp	x16, :got:a
    lsl	x14,	x7,	#2
    add	x28,	x21,	#1
    movz	w20,	#4000
    adrp	x22, :got:a
    lsl	x10,	x7,	#2
    movz	w17,	#4000
    adrp	x3, :got:a
    lsl	x19,	x7,	#2
    movz	w8,	#4000
    add	x6,	x27,	x9
    ldr	x16, [x16, #:got_lo12:a]
    lsl	x4,	x28,	#2
    madd	x15,	x21,	x23,	x16

    add	x13,	x15,	x14
    add	x0,	x27,	x4
    ldr	w15,	[x13]

    adrp	x13, :got:a
    str	w15,	[x6]

    ldr	x22, [x22, #:got_lo12:a]
    madd	x20,	x28,	x20,	x22

    add	x9,	x20,	x10
    lsl	x10,	x7,	#2
    ldr	w11,	[x9]

    str	w11,	[x0]

    movz	w11,	#4000
    ldr	x3, [x3, #:got_lo12:a]
    add	x0,	x28,	#1
    madd	x1,	x0,	x17,	x3

    add	x15,	x0,	#1
    lsl	x14,	x0,	#2
    add	x18,	x1,	x19
    lsl	x0,	x7,	#2
    lsl	x19,	x7,	#2
    lsl	x23,	x15,	#2
    add	x5,	x27,	x14
    ldr	w20,	[x18]

    movz	w14,	#4000
    add	x18,	x27,	x23
    str	w20,	[x5]

    adrp	x23, :got:a
    ldr	x13, [x13, #:got_lo12:a]
    madd	x12,	x15,	x14,	x13

    add	x28,	x12,	x0
    lsl	x0,	x7,	#2
    add	x12,	x15,	#1
    adrp	x15, :got:a
    ldr	w1,	[x28]

    lsl	x4,	x12,	#2
    str	w1,	[x18]

    ldr	x23, [x23, #:got_lo12:a]
    add	x5,	x27,	x4
    madd	x21,	x12,	x11,	x23

    adrp	x4, :got:a
    add	x12,	x12,	#1
    add	x9,	x21,	x10
    lsl	x10,	x7,	#2
    add	x25,	x12,	#1
    lsl	x14,	x12,	#2
    ldr	w11,	[x9]

    add	x13,	x27,	x14
    str	w11,	[x5]

    lsl	x23,	x25,	#2
    add	x14,	x25,	#1
    ldr	x4, [x4, #:got_lo12:a]
    add	x24,	x27,	x23
    madd	x2,	x12,	x8,	x4

    add	w21,	w14,	#1
    movz	w4,	#4000
    add	x18,	x2,	x19
    ldr	w20,	[x18]

    str	w20,	[x13]

    ldr	x15, [x15, #:got_lo12:a]
    madd	x13,	x25,	x4,	x15

    lsl	x4,	x14,	#2
    add	x28,	x13,	x0
    add	x8,	x27,	x4
    ldr	w1,	[x28]

    str	w1,	[x24]

    adrp	x24, :got:a
    movz	w1,	#4000
    ldr	x24, [x24, #:got_lo12:a]
    madd	x22,	x14,	x1,	x24

    add	x9,	x22,	x10
    ldr	w11,	[x9]

    str	w11,	[x8]

    b	main_16

main_60:
    add	w7,	w7,	#1
    cmp	w7,	#1000
    blt	main_13

main_63:
    movz	w0,	#0

main_65:
    movz	w26,	#4000
    adrp	x17, :got:a
    movz	w25,	#4000
    adrp	x9, :got:c
    movz	w10,	#0
    ldr	x17, [x17, #:got_lo12:a]
    ldr	x9, [x9, #:got_lo12:c]
    madd	x18,	x0,	x26,	x17

    madd	x25,	x0,	x25,	x9


main_70:
    movz	w9,	#0
    movz	w15,	#0

main_72:
    cmp	x9,	#1000
    bge	main_165

main_76:
    lsl	x24,	x9,	#2
    movz	w22,	#4000
    adrp	x14, :got:b
    lsl	w3,	w10,	#2
    add	x23,	x18,	x24
    ldr	w8,	[x23]

    ldr	x14, [x14, #:got_lo12:b]
    madd	x13,	x9,	x22,	x14

    add	x2,	x13,	x3
    ldr	w14,	[x2]

    mul	w4,	w14,	w8
    asr	w23,	w4,	#31
    lsr	w24,	w23,	#31
    madd	w26,	w14,	w8,	w24

    asr	w6,	w26,	#1
    lsl	w7,	w6,	#1
    sub	w22,	w4,	w7
    madd	w7,	w14,	w8,	w15

    cmp	w22,	#0
    csel	w13,	w7,	w15,	eq
    add	x19,	x9,	#1
    movz	w17,	#4000
    adrp	x24, :got:b
    lsl	w16,	w10,	#2
    lsl	x9,	x19,	#2
    add	x8,	x18,	x9
    ldr	w27,	[x8]

    ldr	x24, [x24, #:got_lo12:b]
    madd	x22,	x19,	x17,	x24

    add	x15,	x22,	x16
    ldr	w28,	[x15]

    madd	w21,	w28,	w27,	w13

    mul	w24,	w28,	w27
    asr	w4,	w24,	#31
    lsr	w5,	w4,	#31
    madd	w6,	w28,	w27,	w5

    asr	w15,	w6,	#1
    lsl	w16,	w15,	#1
    sub	w2,	w24,	w16
    cmp	w2,	#0
    csel	w3,	w21,	w13,	eq
    add	x6,	x19,	#1
    movz	w12,	#4000
    adrp	x14, :got:b
    lsl	w5,	w10,	#2
    lsl	x27,	x6,	#2
    add	x26,	x18,	x27
    ldr	w28,	[x26]

    ldr	x14, [x14, #:got_lo12:b]
    madd	x12,	x6,	x12,	x14

    add	x4,	x12,	x5
    ldr	w14,	[x4]

    mul	w1,	w14,	w28
    asr	w7,	w1,	#31
    lsr	w8,	w7,	#31
    madd	w9,	w14,	w28,	w8

    asr	w9,	w9,	#1
    lsl	w11,	w9,	#1
    madd	w9,	w14,	w28,	w3

    sub	w20,	w1,	w11
    cmp	w20,	#0
    csel	w19,	w9,	w3,	eq
    add	x20,	x6,	#1
    lsl	w22,	w10,	#2
    adrp	x3, :got:b
    movz	w6,	#4000
    lsl	x15,	x20,	#2
    add	x14,	x18,	x15
    ldr	w17,	[x14]

    ldr	x3, [x3, #:got_lo12:b]
    madd	x1,	x20,	x6,	x3

    add	x21,	x1,	x22
    ldr	w21,	[x21]

    madd	w27,	w21,	w17,	w19

    mul	w9,	w21,	w17
    asr	w11,	w9,	#31
    lsr	w12,	w11,	#31
    madd	w13,	w21,	w17,	w12

    asr	w4,	w13,	#1
    lsl	w5,	w4,	#1
    sub	w8,	w9,	w5
    cmp	w8,	#0
    csel	w23,	w27,	w19,	eq
    add	x6,	x20,	#1
    movz	w1,	#4000
    adrp	x21, :got:b
    lsl	w11,	w10,	#2
    lsl	x4,	x6,	#2
    add	x3,	x18,	x4
    ldr	w13,	[x3]

    ldr	x21, [x21, #:got_lo12:b]
    madd	x19,	x6,	x1,	x21

    add	x9,	x19,	x11
    ldr	w26,	[x9]

    mul	w2,	w26,	w13
    asr	w14,	w2,	#31
    lsr	w15,	w14,	#31
    madd	w16,	w26,	w13,	w15

    madd	w15,	w26,	w13,	w23

    asr	w27,	w16,	#1
    lsl	w28,	w27,	#1
    sub	w27,	w2,	w28
    cmp	w27,	#0
    csel	w11,	w15,	w23,	eq
    add	x13,	x6,	#1
    adrp	x9, :got:b
    movz	w24,	#4000
    lsl	w28,	w10,	#2
    lsl	x21,	x13,	#2
    add	x20,	x18,	x21
    ldr	w14,	[x20]

    ldr	x9, [x9, #:got_lo12:b]
    madd	x7,	x13,	x24,	x9

    add	x27,	x7,	x28
    ldr	w6,	[x27]

    madd	w4,	w6,	w14,	w11

    mul	w24,	w6,	w14
    asr	w17,	w24,	#31
    lsr	w19,	w17,	#31
    madd	w20,	w6,	w14,	w19

    asr	w21,	w20,	#1
    lsl	w22,	w21,	#1
    sub	w16,	w24,	w22
    cmp	w16,	#0
    csel	w1,	w4,	w11,	eq
    add	x17,	x13,	#1
    movz	w19,	#4000
    adrp	x28, :got:b
    lsl	w16,	w10,	#2
    lsl	x9,	x17,	#2
    add	x8,	x18,	x9
    ldr	w7,	[x8]

    ldr	x28, [x28, #:got_lo12:b]
    madd	x26,	x17,	x19,	x28

    add	x15,	x26,	x16
    ldr	w3,	[x15]

    mul	w13,	w3,	w7
    asr	w21,	w13,	#31
    lsr	w22,	w21,	#31
    madd	w21,	w3,	w7,	w1

    madd	w23,	w3,	w7,	w22

    asr	w15,	w23,	#1
    lsl	w16,	w15,	#1
    sub	w5,	w13,	w16
    cmp	w5,	#0
    csel	w13,	w21,	w1,	eq
    movz	w14,	#4000
    lsl	w5,	w10,	#2
    add	x1,	x17,	#1
    adrp	x17, :got:b
    lsl	x27,	x1,	#2
    add	x26,	x18,	x27
    ldr	w22,	[x26]

    ldr	x17, [x17, #:got_lo12:b]
    madd	x15,	x1,	x14,	x17

    add	x4,	x15,	x5
    ldr	w28,	[x4]

    mul	w7,	w28,	w22
    asr	w24,	w7,	#31
    lsr	w26,	w24,	#31
    madd	w27,	w28,	w22,	w26

    asr	w9,	w27,	#1
    lsl	w11,	w9,	#1
    madd	w9,	w28,	w22,	w13

    sub	w23,	w7,	w11
    cmp	w23,	#0
    csel	w15,	w9,	w13,	eq
    add	w9,	w1,	#1
    b	main_72

main_165:
    lsl	w2,	w10,	#2
    add	w10,	w10,	#1
    add	x1,	x25,	x2
    str	w15,	[x1]

    cmp	w10,	#1000
    blt	main_70

main_169:
    add	w0,	w0,	#1
    cmp	w0,	#1000
    blt	main_65

main_172:
    movz	w13,	#0

main_174:
    movz	w11,	#4000
    adrp	x16, :got:c
    movz	w5,	#0
    movz	w15,	#65535
    ldr	x16, [x16, #:got_lo12:c]
    movk	w15,	#32767,	lsl #16
    madd	x22,	x13,	x11,	x16


main_177:
    cmp	w5,	#1000
    bge	main_222

main_181:
    lsl	w27,	w5,	#2
    add	x26,	x22,	x27
    ldr	w28,	[x26]

    cmp	w28,	w15
    add	w16,	w5,	#1
    csel	w9,	w28,	w15,	lt
    lsl	w25,	w16,	#2
    add	x24,	x22,	x25
    ldr	w26,	[x24]

    cmp	w26,	w9
    csel	w25,	w26,	w9,	lt
    add	w26,	w16,	#1
    lsl	w2,	w26,	#2
    add	x1,	x22,	x2
    ldr	w3,	[x1]

    cmp	w3,	w25
    add	w4,	w26,	#1
    csel	w3,	w3,	w25,	lt
    lsl	w8,	w4,	#2
    add	x7,	x22,	x8
    ldr	w9,	[x7]

    cmp	w9,	w3
    csel	w10,	w9,	w3,	lt
    add	w9,	w4,	#1
    lsl	w15,	w9,	#2
    add	x14,	x22,	x15
    ldr	w16,	[x14]

    cmp	w16,	w10
    add	w17,	w9,	#1
    csel	w16,	w16,	w10,	lt
    lsl	w21,	w17,	#2
    add	x20,	x22,	x21
    ldr	w23,	[x20]

    cmp	w23,	w16
    add	w26,	w17,	#1
    csel	w24,	w23,	w16,	lt
    lsl	w28,	w26,	#2
    add	x27,	x22,	x28
    ldr	w0,	[x27]

    cmp	w0,	w24
    add	w8,	w26,	#1
    csel	w7,	w0,	w24,	lt
    lsl	w5,	w8,	#2
    add	x4,	x22,	x5
    ldr	w6,	[x4]

    cmp	w6,	w7
    add	w5,	w8,	#1
    csel	w15,	w6,	w7,	lt
    b	main_177

main_222:
    movz	w7,	#0

main_223:
    cmp	w7,	#1000
    bge	main_243

main_226:
    lsl	w26,	w7,	#2
    add	w17,	w7,	#1
    add	x25,	x22,	x26
    add	w20,	w17,	#1
    lsl	w11,	w17,	#2
    str	w15,	[x25]

    add	x10,	x22,	x11
    add	w24,	w20,	#1
    lsl	w16,	w20,	#2
    str	w15,	[x10]

    add	x14,	x22,	x16
    add	w27,	w24,	#1
    lsl	w19,	w24,	#2
    str	w15,	[x14]

    add	x18,	x22,	x19
    add	w1,	w27,	#1
    lsl	w23,	w27,	#2
    str	w15,	[x18]

    add	x21,	x22,	x23
    add	w5,	w1,	#1
    lsl	w26,	w1,	#2
    str	w15,	[x21]

    add	x25,	x22,	x26
    add	w9,	w5,	#1
    lsl	w0,	w5,	#2
    str	w15,	[x25]

    add	x28,	x22,	x0
    add	w7,	w9,	#1
    lsl	w3,	w9,	#2
    str	w15,	[x28]

    add	x2,	x22,	x3
    str	w15,	[x2]

    b	main_223

main_243:
    add	w13,	w13,	#1
    cmp	w13,	#1000
    blt	main_174

main_246:
    movz	w17,	#0

main_248:
    movz	w0,	#4000
    adrp	x13, :got:c
    movz	w22,	#0
    ldr	x13, [x13, #:got_lo12:c]
    madd	x10,	x17,	x0,	x13


main_251:
    cmp	x22,	#1000
    bge	main_303

main_254:
    lsl	x13,	x22,	#2
    movz	w3,	#4000
    adrp	x6, :got:c
    lsl	x19,	x17,	#2
    movz	w1,	#0
    add	x14,	x22,	#1
    movz	w28,	#4000
    movz	w24,	#4000
    lsl	x25,	x17,	#2
    movz	w15,	#4000
    add	x12,	x10,	x13
    ldr	x6, [x6, #:got_lo12:c]
    add	x11,	x14,	#1
    lsl	x27,	x14,	#2
    madd	x3,	x22,	x3,	x6

    add	x16,	x10,	x27
    lsl	x6,	x17,	#2
    lsl	x8,	x11,	#2
    movz	w22,	#0
    add	x18,	x3,	x19
    adrp	x27, :got:c
    lsl	x3,	x17,	#2
    ldr	w9,	[x18]

    movz	w18,	#0
    sub	w21,	w1,	w9
    adrp	x9, :got:c
    add	x1,	x10,	x8
    str	w21,	[x12]

    ldr	x27, [x27, #:got_lo12:c]
    madd	x26,	x14,	x28,	x27

    lsl	x28,	x17,	#2
    lsl	x14,	x17,	#2
    add	x2,	x26,	x3
    adrp	x3, :got:c
    movz	w26,	#0
    ldr	w2,	[x2]

    sub	w5,	w26,	w2
    add	x26,	x11,	#1
    str	w5,	[x16]

    lsl	x20,	x26,	#2
    ldr	x9, [x9, #:got_lo12:c]
    madd	x7,	x11,	x24,	x9

    add	x12,	x10,	x20
    movz	w9,	#0
    movz	w11,	#4000
    add	x13,	x7,	x14
    movz	w20,	#4000
    movz	w7,	#4000
    ldr	w13,	[x13]

    sub	w16,	w22,	w13
    movz	w13,	#0
    adrp	x22, :got:c
    str	w16,	[x1]

    ldr	x22, [x22, #:got_lo12:c]
    madd	x19,	x26,	x20,	x22

    add	x24,	x19,	x25
    ldr	w25,	[x24]

    sub	w27,	w18,	w25
    add	x18,	x26,	#1
    adrp	x26, :got:c
    str	w27,	[x12]

    lsl	x1,	x18,	#2
    ldr	x3, [x3, #:got_lo12:c]
    add	x2,	x10,	x1
    madd	x1,	x18,	x15,	x3

    adrp	x15, :got:c
    add	x5,	x1,	x6
    add	x1,	x18,	#1
    lsl	x18,	x17,	#2
    ldr	w6,	[x5]

    lsl	x12,	x1,	#2
    movz	w5,	#0
    sub	w8,	w13,	w6
    add	x0,	x10,	x12
    str	w8,	[x2]

    ldr	x15, [x15, #:got_lo12:c]
    madd	x12,	x1,	x11,	x15

    add	x16,	x12,	x18
    movz	w18,	#4000
    ldr	w19,	[x16]

    add	x16,	x1,	#1
    sub	w20,	w9,	w19
    lsl	x9,	x17,	#2
    str	w20,	[x0]

    lsl	x23,	x16,	#2
    ldr	x26, [x26, #:got_lo12:c]
    add	x15,	x10,	x23
    madd	x23,	x16,	x7,	x26

    adrp	x7, :got:c
    add	x27,	x23,	x28
    add	x23,	x16,	#1
    ldr	w0,	[x27]

    add	w22,	w23,	#1
    lsl	x4,	x23,	#2
    sub	w1,	w5,	w0
    str	w1,	[x15]

    movz	w15,	#0
    ldr	x7, [x7, #:got_lo12:c]
    add	x1,	x10,	x4
    madd	x5,	x23,	x18,	x7

    add	x8,	x5,	x9
    ldr	w11,	[x8]

    sub	w12,	w15,	w11
    str	w12,	[x1]

    b	main_251

main_303:
    add	w17,	w17,	#1
    cmp	w17,	#1000
    blt	main_248

main_306:
    movz	w19,	#0
    movz	w27,	#0

main_308:
    movz	w20,	#4000
    adrp	x17, :got:c
    movz	w6,	#0
    ldr	x17, [x17, #:got_lo12:c]
    madd	x16,	x19,	x20,	x17


main_312:
    cmp	w6,	#1000
    bge	main_349

main_316:
    lsl	w14,	w6,	#2
    add	w11,	w6,	#1
    add	x13,	x16,	x14
    add	w21,	w11,	#1
    ldr	w15,	[x13]

    lsl	w3,	w21,	#2
    add	w22,	w15,	w27
    lsl	w27,	w11,	#2
    add	x2,	x16,	x3
    add	x26,	x16,	x27
    ldr	w28,	[x26]

    add	w26,	w21,	#1
    ldr	w4,	[x2]

    add	w28,	w28,	w22
    add	w10,	w26,	#1
    lsl	w8,	w26,	#2
    add	w4,	w4,	w28
    add	x7,	x16,	x8
    lsl	w13,	w10,	#2
    ldr	w9,	[x7]

    add	x12,	x16,	x13
    add	w7,	w10,	#1
    add	w9,	w9,	w4
    ldr	w14,	[x12]

    add	w23,	w7,	#1
    lsl	w20,	w7,	#2
    add	w15,	w14,	w9
    add	x18,	x16,	x20
    add	w5,	w23,	#1
    lsl	w25,	w23,	#2
    ldr	w21,	[x18]

    add	x24,	x16,	x25
    add	w6,	w5,	#1
    lsl	w1,	w5,	#2
    add	w21,	w21,	w15
    ldr	w26,	[x24]

    add	x0,	x16,	x1
    add	w4,	w26,	w21
    ldr	w2,	[x0]

    add	w27,	w2,	w4
    b	main_312

main_349:
    add	w19,	w19,	#1
    cmp	w19,	#1000
    blt	main_308

main_352:
    movz	w0,	#93
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#0

main_354:
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


