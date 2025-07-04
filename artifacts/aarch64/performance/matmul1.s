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
    movz	w2,	#4000
    adrp	x14, :got:b
    movz	w28,	#0
    ldr	x14, [x14, #:got_lo12:b]
    madd	x17,	x3,	x2,	x14


main_16:
    cmp	x28,	#1000
    blt	main_19

main_60:
    add	w3,	w3,	#1
    cmp	w3,	#1000
    blt	main_13

main_63:
    movz	w20,	#0

main_65:
    movz	w4,	#4000
    adrp	x19, :got:a
    movz	w3,	#4000
    adrp	x9, :got:c
    movz	w22,	#0
    ldr	x19, [x19, #:got_lo12:a]
    ldr	x9, [x9, #:got_lo12:c]
    madd	x7,	x20,	x4,	x19

    madd	x25,	x20,	x3,	x9


main_70:
    movz	w2,	#0
    movz	w26,	#0

main_72:
    cmp	x2,	#1000
    blt	main_76

main_141:
    lsl	w19,	w22,	#2
    add	w22,	w22,	#1
    add	x18,	x25,	x19
    str	w26,	[x18]

    cmp	w22,	#1000
    blt	main_70

main_145:
    add	w20,	w20,	#1
    cmp	w20,	#1000
    blt	main_65

main_148:
    movz	w12,	#0

main_150:
    movz	w6,	#4000
    adrp	x4, :got:c
    movz	w14,	#0
    ldr	x4, [x4, #:got_lo12:c]
    madd	x23,	x12,	x6,	x4

    movz	w6,	#65535
    movk	w6,	#32767,	lsl #16

main_153:
    cmp	w14,	#1000
    blt	main_157

main_198:
    movz	w8,	#0

main_199:
    cmp	w8,	#1000
    blt	main_202

main_219:
    add	w12,	w12,	#1
    cmp	w12,	#1000
    blt	main_150

main_222:
    movz	w17,	#0

main_224:
    movz	w7,	#4000
    adrp	x12, :got:c
    movz	w22,	#0
    ldr	x12, [x12, #:got_lo12:c]
    madd	x12,	x17,	x7,	x12


main_227:
    cmp	x22,	#1000
    blt	main_230

main_279:
    add	w17,	w17,	#1
    cmp	w17,	#1000
    blt	main_224

main_282:
    movz	w4,	#0
    movz	w27,	#0

main_284:
    movz	w18,	#4000
    adrp	x5, :got:c
    movz	w21,	#0
    ldr	x5, [x5, #:got_lo12:c]
    madd	x2,	x4,	x18,	x5


main_288:
    cmp	w21,	#1000
    blt	main_292

main_325:
    add	w4,	w4,	#1
    cmp	w4,	#1000
    blt	main_284

main_328:
    movz	w0,	#92
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#0
    b	main_330

main_292:
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
    b	main_288

main_230:
    lsl	x26,	x22,	#2
    movz	w13,	#4000
    adrp	x7, :got:c
    lsl	x2,	x17,	#2
    movz	w11,	#0
    add	x0,	x22,	#1
    movz	w9,	#4000
    lsl	x25,	x17,	#2
    movz	w5,	#4000
    adrp	x23, :got:c
    lsl	x18,	x17,	#2
    add	x27,	x12,	x26
    ldr	x7, [x7, #:got_lo12:c]
    add	x28,	x0,	#1
    lsl	x20,	x0,	#2
    madd	x6,	x22,	x13,	x7

    movz	w22,	#4000
    movz	w7,	#0
    add	x1,	x6,	x2
    add	x3,	x12,	x20
    lsl	x6,	x17,	#2
    ldr	w10,	[x1]

    lsl	x1,	x28,	#2
    sub	w4,	w11,	w10
    adrp	x11, :got:c
    str	w4,	[x27]

    ldr	x11, [x11, #:got_lo12:c]
    madd	x8,	x0,	x9,	x11

    movz	w0,	#0
    lsl	x9,	x17,	#2
    add	x24,	x8,	x25
    ldr	w15,	[x24]

    movz	w24,	#0
    sub	w27,	w7,	w15
    adrp	x15, :got:c
    str	w27,	[x3]

    ldr	x23, [x23, #:got_lo12:c]
    movz	w3,	#0
    add	x27,	x12,	x1
    madd	x21,	x28,	x5,	x23

    movz	w1,	#4000
    add	x5,	x21,	x6
    lsl	x21,	x17,	#2
    add	x6,	x28,	#1
    movz	w28,	#0
    ldr	w26,	[x5]

    lsl	x11,	x6,	#2
    adrp	x5, :got:c
    sub	w8,	w3,	w26
    movz	w26,	#4000
    str	w8,	[x27]

    ldr	x5, [x5, #:got_lo12:c]
    add	x8,	x12,	x11
    madd	x2,	x6,	x1,	x5

    add	x16,	x2,	x18
    movz	w2,	#4000
    add	x18,	x6,	#1
    ldr	w7,	[x16]

    lsl	x23,	x18,	#2
    movz	w16,	#0
    sub	w20,	w28,	w7
    lsl	x28,	x17,	#2
    str	w20,	[x8]

    ldr	x15, [x15, #:got_lo12:c]
    add	x20,	x12,	x23
    madd	x13,	x18,	x26,	x15

    add	x27,	x13,	x28
    add	x13,	x18,	#1
    movz	w18,	#4000
    ldr	w19,	[x27]

    add	x28,	x13,	#1
    lsl	x4,	x13,	#2
    adrp	x27, :got:c
    sub	w1,	w24,	w19
    add	x6,	x12,	x4
    lsl	x15,	x28,	#2
    str	w1,	[x20]

    movz	w20,	#0
    ldr	x27, [x27, #:got_lo12:c]
    madd	x25,	x13,	x22,	x27

    add	x22,	x28,	#1
    add	x8,	x25,	x9
    add	x25,	x12,	x15
    ldr	w1,	[x8]

    lsl	x26,	x22,	#2
    adrp	x8, :got:c
    sub	w11,	w20,	w1
    add	x13,	x12,	x26
    str	w11,	[x6]

    ldr	x8, [x8, #:got_lo12:c]
    madd	x6,	x28,	x18,	x8

    add	x20,	x6,	x21
    adrp	x21, :got:c
    ldr	w11,	[x20]

    sub	w23,	w16,	w11
    str	w23,	[x25]

    ldr	x21, [x21, #:got_lo12:c]
    madd	x19,	x22,	x2,	x21

    add	w22,	w22,	#1
    lsl	x2,	x17,	#2
    add	x1,	x19,	x2
    ldr	w24,	[x1]

    sub	w4,	w0,	w24
    str	w4,	[x13]

    b	main_227

main_202:
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

    b	main_199

main_157:
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
    b	main_153

main_76:
    lsl	x23,	x2,	#2
    movz	w24,	#4000
    adrp	x19, :got:b
    lsl	w3,	w22,	#2
    add	x17,	x2,	#1
    adrp	x12, :got:b
    lsl	w28,	w22,	#2
    add	x21,	x7,	x23
    ldr	w14,	[x21]

    movz	w21,	#4000
    ldr	x19, [x19, #:got_lo12:b]
    madd	x18,	x2,	x24,	x19

    add	x2,	x17,	#1
    lsl	x19,	x17,	#2
    add	x1,	x18,	x3
    add	x18,	x7,	x19
    lsl	x5,	x2,	#2
    ldr	w4,	[x1]

    ldr	w9,	[x18]

    madd	w6,	w4,	w14,	w26

    movz	w18,	#4000
    ldr	x12, [x12, #:got_lo12:b]
    add	x4,	x7,	x5
    madd	x10,	x17,	x21,	x12

    add	x21,	x2,	#1
    lsl	w12,	w22,	#2
    add	x27,	x10,	x28
    adrp	x28, :got:b
    ldr	w0,	[x27]

    lsl	w27,	w22,	#2
    madd	w15,	w0,	w9,	w6

    movz	w6,	#4000
    movz	w9,	#4000
    ldr	w0,	[x4]

    ldr	x28, [x28, #:got_lo12:b]
    madd	x26,	x2,	x18,	x28

    lsl	x18,	x21,	#2
    add	x11,	x26,	x12
    adrp	x12, :got:b
    add	x17,	x7,	x18
    ldr	w13,	[x11]

    lsl	w11,	w22,	#2
    madd	w4,	w13,	w0,	w15

    ldr	w16,	[x17]

    adrp	x13, :got:b
    movz	w15,	#4000
    ldr	x12, [x12, #:got_lo12:b]
    madd	x10,	x21,	x15,	x12

    movz	w12,	#4000
    add	x26,	x10,	x27
    ldr	w28,	[x26]

    madd	w15,	w28,	w16,	w4

    adrp	x28, :got:b
    add	x16,	x21,	#1
    lsl	x4,	x16,	#2
    add	x3,	x7,	x4
    ldr	w0,	[x3]

    ldr	x28, [x28, #:got_lo12:b]
    madd	x26,	x16,	x12,	x28

    add	x28,	x16,	#1
    add	x10,	x26,	x11
    lsl	w26,	w22,	#2
    ldr	w12,	[x10]

    add	x1,	x28,	#1
    lsl	x17,	x28,	#2
    madd	w19,	w12,	w0,	w15

    add	x21,	x1,	#1
    lsl	x3,	x1,	#2
    add	x16,	x7,	x17
    add	x2,	x7,	x3
    movz	w3,	#4000
    ldr	w23,	[x16]

    lsl	x16,	x21,	#2
    ldr	x13, [x13, #:got_lo12:b]
    madd	x10,	x28,	x9,	x13

    adrp	x13, :got:b
    adrp	x28, :got:b
    add	x24,	x10,	x26
    lsl	w10,	w22,	#2
    ldr	w27,	[x24]

    lsl	w24,	w22,	#2
    ldr	w15,	[x2]

    madd	w19,	w27,	w23,	w19

    add	w2,	w21,	#1
    ldr	x28, [x28, #:got_lo12:b]
    madd	x26,	x1,	x6,	x28

    add	x9,	x26,	x10
    ldr	w11,	[x9]

    madd	w11,	w11,	w15,	w19

    add	x15,	x7,	x16
    ldr	w4,	[x15]

    ldr	x13, [x13, #:got_lo12:b]
    madd	x10,	x21,	x3,	x13

    add	x23,	x10,	x24
    ldr	w26,	[x23]

    madd	w26,	w26,	w4,	w11

    b	main_72

main_19:
    lsl	x12,	x28,	#2
    movz	w19,	#4000
    adrp	x6, :got:a
    lsl	x18,	x3,	#2
    adrp	x26, :got:a
    lsl	x0,	x3,	#2
    movz	w13,	#4000
    adrp	x7, :got:a
    lsl	x10,	x3,	#2
    adrp	x27, :got:a
    add	x9,	x17,	x12
    ldr	x6, [x6, #:got_lo12:a]
    madd	x4,	x28,	x19,	x6

    add	x16,	x4,	x18
    adrp	x18, :got:a
    ldr	w19,	[x16]

    movz	w16,	#4000
    str	w19,	[x9]

    ldr	x26, [x26, #:got_lo12:a]
    add	x19,	x28,	#1
    add	x6,	x19,	#1
    lsl	x24,	x19,	#2
    add	x20,	x17,	x24
    lsl	x5,	x6,	#2
    madd	x24,	x19,	x16,	x26

    add	x16,	x6,	#1
    add	x28,	x24,	x0
    add	x4,	x17,	x5
    lsl	x0,	x3,	#2
    ldr	w1,	[x28]

    lsl	x14,	x16,	#2
    str	w1,	[x20]

    add	x15,	x17,	x14
    lsl	x20,	x3,	#2
    ldr	x7, [x7, #:got_lo12:a]
    madd	x5,	x6,	x13,	x7

    movz	w7,	#4000
    add	x9,	x5,	x10
    movz	w10,	#4000
    ldr	w11,	[x9]

    adrp	x9, :got:a
    str	w11,	[x4]

    movz	w4,	#4000
    ldr	x18, [x18, #:got_lo12:a]
    madd	x14,	x16,	x10,	x18

    lsl	x10,	x3,	#2
    add	x19,	x14,	x20
    lsl	x20,	x3,	#2
    ldr	w21,	[x19]

    adrp	x19, :got:a
    str	w21,	[x15]

    ldr	x27, [x27, #:got_lo12:a]
    add	x15,	x16,	#1
    add	x18,	x15,	#1
    madd	x25,	x15,	x7,	x27

    lsl	x24,	x15,	#2
    movz	w27,	#4000
    add	x28,	x25,	x0
    lsl	x5,	x18,	#2
    add	x2,	x17,	x24
    lsl	x0,	x3,	#2
    ldr	w1,	[x28]

    add	x28,	x17,	x5
    str	w1,	[x2]

    movz	w1,	#4000
    ldr	x9, [x9, #:got_lo12:a]
    madd	x6,	x18,	x4,	x9

    add	x9,	x6,	x10
    ldr	w11,	[x9]

    str	w11,	[x28]

    ldr	x19, [x19, #:got_lo12:a]
    add	x28,	x18,	#1
    add	x11,	x28,	#1
    madd	x15,	x28,	x1,	x19

    lsl	x14,	x28,	#2
    add	x19,	x15,	x20
    adrp	x28, :got:a
    lsl	x24,	x11,	#2
    add	x10,	x17,	x14
    ldr	w21,	[x19]

    str	w21,	[x10]

    ldr	x28, [x28, #:got_lo12:a]
    add	x21,	x17,	x24
    madd	x26,	x11,	x27,	x28

    add	x28,	x26,	x0
    ldr	w1,	[x28]

    add	w28,	w11,	#1
    str	w1,	[x21]

    b	main_16

main_5:
    movz	w21,	#4000
    adrp	x0, :got:a
    ldr	x0, [x0, #:got_lo12:a]
    madd	x0,	x20,	x21,	x0

    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#1000
    beq	main_2

main_330:
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


