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
    movz	w0,	#4000
    adrp	x21, :got:a
    ldr	x21, [x21, #:got_lo12:a]
    madd	x0,	x20,	x0,	x21

    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#1000
    bne	main_330
    b	main_2

main_11:
    movz	w0,	#23
    bl	_sysy_starttime
    movz	w7,	#0

main_13:
    movz	w3,	#4000
    adrp	x21, :got:b
    ldr	x21, [x21, #:got_lo12:b]
    madd	x10,	x7,	x3,	x21

    movz	w21,	#0

main_16:
    cmp	x21,	#1000
    bge	main_60

main_19:
    lsl	x9,	x21,	#2
    movz	w27,	#4000
    adrp	x17, :got:a
    lsl	x15,	x7,	#2
    movz	w24,	#4000
    adrp	x22, :got:a
    lsl	x11,	x7,	#2
    adrp	x3, :got:a
    movz	w18,	#4000
    lsl	x0,	x7,	#2
    movz	w5,	#4000
    add	x6,	x10,	x9
    ldr	x17, [x17, #:got_lo12:a]
    madd	x16,	x21,	x27,	x17

    add	x14,	x16,	x15
    ldr	w16,	[x14]

    adrp	x14, :got:a
    str	w16,	[x6]

    ldr	x22, [x22, #:got_lo12:a]
    add	x16,	x21,	#1
    madd	x21,	x16,	x24,	x22

    lsl	x4,	x16,	#2
    add	x9,	x21,	x11
    add	x20,	x10,	x4
    lsl	x11,	x7,	#2
    movz	w21,	#4000
    ldr	w12,	[x9]

    str	w12,	[x20]

    lsl	x20,	x7,	#2
    ldr	x3, [x3, #:got_lo12:a]
    add	x12,	x16,	#1
    adrp	x16, :got:a
    madd	x1,	x12,	x21,	x3

    lsl	x15,	x12,	#2
    add	x19,	x1,	x20
    add	x13,	x10,	x15
    lsl	x20,	x7,	#2
    add	x15,	x12,	#1
    ldr	w21,	[x19]

    str	w21,	[x13]

    lsl	x24,	x15,	#2
    ldr	x14, [x14, #:got_lo12:a]
    madd	x13,	x15,	x18,	x14

    add	x19,	x10,	x24
    add	x28,	x13,	x0
    adrp	x24, :got:a
    ldr	w1,	[x28]

    add	x28,	x15,	#1
    str	w1,	[x19]

    movz	w15,	#4000
    ldr	x24, [x24, #:got_lo12:a]
    add	x13,	x28,	#1
    lsl	x4,	x28,	#2
    madd	x22,	x28,	x15,	x24

    add	x0,	x10,	x4
    add	x9,	x22,	x11
    add	x26,	x13,	#1
    lsl	x15,	x13,	#2
    adrp	x4, :got:a
    lsl	x11,	x7,	#2
    ldr	w12,	[x9]

    add	x14,	x10,	x15
    lsl	x24,	x26,	#2
    movz	w9,	#4000
    str	w12,	[x0]

    add	x15,	x26,	#1
    add	x25,	x10,	x24
    ldr	x4, [x4, #:got_lo12:a]
    lsl	x0,	x7,	#2
    movz	w12,	#4000
    madd	x2,	x13,	x12,	x4

    lsl	x4,	x15,	#2
    add	x19,	x2,	x20
    add	x8,	x10,	x4
    ldr	w21,	[x19]

    str	w21,	[x14]

    add	w21,	w15,	#1
    ldr	x16, [x16, #:got_lo12:a]
    madd	x14,	x26,	x9,	x16

    add	x28,	x14,	x0
    ldr	w1,	[x28]

    str	w1,	[x25]

    adrp	x25, :got:a
    ldr	x25, [x25, #:got_lo12:a]
    madd	x23,	x15,	x5,	x25

    add	x9,	x23,	x11
    ldr	w12,	[x9]

    str	w12,	[x8]

    b	main_16

main_60:
    add	w7,	w7,	#1
    cmp	w7,	#1000
    blt	main_13

main_63:
    movz	w0,	#0

main_65:
    movz	w2,	#4000
    adrp	x18, :got:a
    movz	w1,	#4000
    adrp	x10, :got:c
    ldr	x18, [x18, #:got_lo12:a]
    ldr	x10, [x10, #:got_lo12:c]
    madd	x19,	x0,	x2,	x18

    madd	x23,	x0,	x1,	x10

    movz	w10,	#0

main_70:
    movz	w11,	#0
    movz	w16,	#0

main_72:
    cmp	x11,	#1000
    bge	main_141

main_76:
    lsl	x25,	x11,	#2
    movz	w8,	#4000
    adrp	x15, :got:b
    lsl	w3,	w10,	#2
    adrp	x21, :got:b
    adrp	x7, :got:b
    lsl	w27,	w10,	#2
    add	x24,	x19,	x25
    ldr	w17,	[x24]

    add	x24,	x11,	#1
    ldr	x15, [x15, #:got_lo12:b]
    madd	x13,	x11,	x8,	x15

    movz	w15,	#4000
    add	x2,	x13,	x3
    lsl	x6,	x24,	#2
    lsl	w13,	w10,	#2
    ldr	w4,	[x2]

    add	x5,	x19,	x6
    movz	w2,	#4000
    madd	w16,	w4,	w17,	w16

    adrp	x6, :got:b
    ldr	w3,	[x5]

    ldr	x21, [x21, #:got_lo12:b]
    movz	w5,	#4000
    madd	x18,	x24,	x5,	x21

    add	x12,	x18,	x13
    ldr	w14,	[x12]

    lsl	w12,	w10,	#2
    madd	w11,	w14,	w3,	w16

    add	x16,	x24,	#1
    movz	w24,	#4000
    lsl	x20,	x16,	#2
    add	x3,	x16,	#1
    add	x18,	x19,	x20
    lsl	x5,	x3,	#2
    ldr	w20,	[x18]

    ldr	x7, [x7, #:got_lo12:b]
    madd	x4,	x16,	x2,	x7

    add	x26,	x4,	x27
    movz	w27,	#4000
    add	x4,	x19,	x5
    ldr	w28,	[x26]

    lsl	w26,	w10,	#2
    ldr	w8,	[x4]

    madd	w2,	w28,	w20,	w11

    add	x28,	x3,	#1
    adrp	x20, :got:b
    ldr	x20, [x20, #:got_lo12:b]
    madd	x18,	x3,	x27,	x20

    adrp	x20, :got:b
    add	x11,	x18,	x12
    lsl	x18,	x28,	#2
    ldr	w13,	[x11]

    add	x17,	x19,	x18
    lsl	w11,	w10,	#2
    madd	w21,	w13,	w8,	w2

    ldr	w1,	[x17]

    ldr	x6, [x6, #:got_lo12:b]
    madd	x4,	x28,	x24,	x6

    adrp	x6, :got:b
    add	x24,	x28,	#1
    add	x25,	x4,	x26
    add	x14,	x24,	#1
    lsl	x4,	x24,	#2
    ldr	w27,	[x25]

    add	x3,	x19,	x4
    lsl	w25,	w10,	#2
    madd	w22,	w27,	w1,	w21

    movz	w21,	#4000
    ldr	w17,	[x3]

    ldr	x20, [x20, #:got_lo12:b]
    madd	x18,	x24,	x21,	x20

    adrp	x21, :got:b
    add	x9,	x18,	x11
    movz	w18,	#4000
    ldr	w12,	[x9]

    lsl	w9,	w10,	#2
    madd	w12,	w12,	w17,	w22

    lsl	x17,	x14,	#2
    add	x16,	x19,	x17
    ldr	w8,	[x16]

    ldr	x6, [x6, #:got_lo12:b]
    madd	x4,	x14,	x18,	x6

    add	x24,	x4,	x25
    ldr	w26,	[x24]

    madd	w7,	w26,	w8,	w12

    add	x12,	x14,	#1
    lsl	x3,	x12,	#2
    add	x2,	x19,	x3
    ldr	w27,	[x2]

    ldr	x21, [x21, #:got_lo12:b]
    madd	x18,	x12,	x15,	x21

    add	x8,	x18,	x9
    ldr	w11,	[x8]

    madd	w16,	w11,	w27,	w7

    add	w11,	w12,	#1
    b	main_72

main_141:
    lsl	w2,	w10,	#2
    add	w10,	w10,	#1
    add	x1,	x23,	x2
    str	w16,	[x1]

    cmp	w10,	#1000
    blt	main_70

main_145:
    add	w0,	w0,	#1
    cmp	w0,	#1000
    blt	main_65

main_148:
    movz	w13,	#0

main_150:
    movz	w28,	#4000
    adrp	x18, :got:c
    movz	w5,	#0
    movz	w15,	#65535
    ldr	x18, [x18, #:got_lo12:c]
    movk	w15,	#32767,	lsl #16
    madd	x23,	x13,	x28,	x18


main_153:
    cmp	w5,	#1000
    bge	main_198

main_157:
    lsl	w28,	w5,	#2
    add	x27,	x23,	x28
    ldr	w0,	[x27]

    cmp	w0,	w15
    csel	w8,	w0,	w15,	lt
    add	w16,	w5,	#1
    lsl	w28,	w16,	#2
    add	x27,	x23,	x28
    ldr	w0,	[x27]

    cmp	w0,	w8
    add	w26,	w16,	#1
    csel	w24,	w0,	w8,	lt
    lsl	w5,	w26,	#2
    add	x4,	x23,	x5
    ldr	w6,	[x4]

    cmp	w6,	w24
    add	w3,	w26,	#1
    csel	w2,	w6,	w24,	lt
    lsl	w11,	w3,	#2
    add	x10,	x23,	x11
    ldr	w12,	[x10]

    cmp	w12,	w2
    add	w9,	w3,	#1
    csel	w8,	w12,	w2,	lt
    lsl	w18,	w9,	#2
    add	x17,	x23,	x18
    ldr	w19,	[x17]

    cmp	w19,	w8
    add	w16,	w9,	#1
    csel	w15,	w19,	w8,	lt
    lsl	w25,	w16,	#2
    add	x24,	x23,	x25
    ldr	w26,	[x24]

    cmp	w26,	w15
    csel	w25,	w26,	w15,	lt
    add	w26,	w16,	#1
    lsl	w2,	w26,	#2
    add	x1,	x23,	x2
    ldr	w3,	[x1]

    cmp	w3,	w25
    add	w4,	w26,	#1
    csel	w3,	w3,	w25,	lt
    lsl	w8,	w4,	#2
    add	x7,	x23,	x8
    ldr	w9,	[x7]

    cmp	w9,	w3
    add	w5,	w4,	#1
    csel	w15,	w9,	w3,	lt
    b	main_153

main_198:
    movz	w7,	#0

main_199:
    cmp	w7,	#1000
    bge	main_219

main_202:
    lsl	w27,	w7,	#2
    add	w17,	w7,	#1
    add	x26,	x23,	x27
    add	w20,	w17,	#1
    lsl	w14,	w17,	#2
    str	w15,	[x26]

    add	x12,	x23,	x14
    add	w24,	w20,	#1
    lsl	w18,	w20,	#2
    str	w15,	[x12]

    add	x17,	x23,	x18
    add	w27,	w24,	#1
    lsl	w21,	w24,	#2
    str	w15,	[x17]

    add	x20,	x23,	x21
    add	w1,	w27,	#1
    lsl	w25,	w27,	#2
    str	w15,	[x20]

    add	x24,	x23,	x25
    add	w6,	w1,	#1
    lsl	w28,	w1,	#2
    str	w15,	[x24]

    add	x27,	x23,	x28
    add	w9,	w6,	#1
    lsl	w2,	w6,	#2
    str	w15,	[x27]

    add	x1,	x23,	x2
    add	w7,	w9,	#1
    lsl	w5,	w9,	#2
    str	w15,	[x1]

    add	x4,	x23,	x5
    str	w15,	[x4]

    b	main_199

main_219:
    add	w13,	w13,	#1
    cmp	w13,	#1000
    blt	main_150

main_222:
    movz	w17,	#0

main_224:
    movz	w16,	#4000
    adrp	x15, :got:c
    movz	w22,	#0
    ldr	x15, [x15, #:got_lo12:c]
    madd	x19,	x17,	x16,	x15


main_227:
    cmp	x22,	#1000
    bge	main_279

main_230:
    lsl	x14,	x22,	#2
    movz	w20,	#4000
    adrp	x6, :got:c
    lsl	x21,	x17,	#2
    movz	w18,	#0
    movz	w15,	#4000
    movz	w13,	#0
    adrp	x12, :got:c
    lsl	x16,	x17,	#2
    movz	w7,	#4000
    movz	w3,	#4000
    add	x2,	x19,	x14
    ldr	x6, [x6, #:got_lo12:c]
    add	x14,	x22,	#1
    madd	x4,	x22,	x20,	x6

    movz	w22,	#0
    lsl	x6,	x17,	#2
    lsl	x1,	x14,	#2
    add	x20,	x4,	x21
    add	x21,	x19,	x1
    ldr	w9,	[x20]

    adrp	x1, :got:c
    sub	w24,	w18,	w9
    str	w24,	[x2]

    lsl	x2,	x17,	#2
    add	x24,	x14,	#1
    ldr	x1, [x1, #:got_lo12:c]
    madd	x28,	x14,	x15,	x1

    lsl	x11,	x24,	#2
    add	x14,	x24,	#1
    add	x5,	x28,	x6
    add	x27,	x19,	x11
    adrp	x6, :got:c
    lsl	x23,	x14,	#2
    lsl	x28,	x17,	#2
    ldr	w4,	[x5]

    movz	w11,	#4000
    add	x10,	x19,	x23
    movz	w5,	#0
    sub	w8,	w13,	w4
    str	w8,	[x21]

    ldr	x12, [x12, #:got_lo12:c]
    madd	x9,	x24,	x11,	x12

    adrp	x24, :got:c
    lsl	x12,	x17,	#2
    add	x15,	x9,	x16
    movz	w9,	#0
    ldr	w15,	[x15]

    sub	w20,	w9,	w15
    adrp	x15, :got:c
    lsl	x9,	x17,	#2
    str	w20,	[x27]

    ldr	x24, [x24, #:got_lo12:c]
    madd	x21,	x14,	x7,	x24

    movz	w24,	#4000
    add	x7,	x14,	#1
    add	x27,	x21,	x28
    lsl	x21,	x17,	#2
    movz	w28,	#4000
    add	x16,	x7,	#1
    lsl	x4,	x7,	#2
    ldr	w27,	[x27]

    add	x26,	x19,	x4
    sub	w1,	w5,	w27
    lsl	x14,	x16,	#2
    str	w1,	[x10]

    movz	w1,	#0
    adrp	x10, :got:c
    ldr	x6, [x6, #:got_lo12:c]
    madd	x3,	x7,	x3,	x6

    add	x7,	x19,	x14
    add	x8,	x3,	x9
    movz	w3,	#4000
    ldr	w9,	[x8]

    sub	w11,	w1,	w9
    str	w11,	[x26]

    movz	w26,	#0
    ldr	x15, [x15, #:got_lo12:c]
    madd	x13,	x16,	x28,	x15

    adrp	x28, :got:c
    add	x20,	x13,	x21
    ldr	w20,	[x20]

    sub	w23,	w26,	w20
    str	w23,	[x7]

    ldr	x28, [x28, #:got_lo12:c]
    add	x7,	x16,	#1
    lsl	x26,	x7,	#2
    add	x23,	x19,	x26
    madd	x26,	x7,	x24,	x28

    add	x24,	x7,	#1
    add	x1,	x26,	x2
    lsl	x7,	x24,	#2
    ldr	w2,	[x1]

    movz	w1,	#0
    sub	w4,	w22,	w2
    add	x25,	x19,	x7
    add	w22,	w24,	#1
    str	w4,	[x23]

    ldr	x10, [x10, #:got_lo12:c]
    madd	x7,	x24,	x3,	x10

    add	x11,	x7,	x12
    ldr	w13,	[x11]

    sub	w14,	w1,	w13
    str	w14,	[x25]

    b	main_227

main_279:
    add	w17,	w17,	#1
    cmp	w17,	#1000
    blt	main_224

main_282:
    movz	w19,	#0
    movz	w27,	#0

main_284:
    movz	w6,	#4000
    adrp	x21, :got:c
    ldr	x21, [x21, #:got_lo12:c]
    madd	x18,	x19,	x6,	x21

    movz	w6,	#0

main_288:
    cmp	w6,	#1000
    bge	main_325

main_292:
    lsl	w15,	w6,	#2
    add	w22,	w6,	#1
    add	x14,	x18,	x15
    add	w28,	w22,	#1
    lsl	w1,	w22,	#2
    ldr	w16,	[x14]

    add	x0,	x18,	x1
    add	w4,	w28,	#1
    lsl	w6,	w28,	#2
    add	w23,	w16,	w27
    ldr	w2,	[x0]

    add	x5,	x18,	x6
    add	w9,	w4,	#1
    lsl	w11,	w4,	#2
    add	w26,	w2,	w23
    ldr	w7,	[x5]

    add	x10,	x18,	x11
    lsl	w16,	w9,	#2
    add	w3,	w7,	w26
    ldr	w12,	[x10]

    add	x15,	x18,	x16
    add	w7,	w9,	#1
    add	w8,	w12,	w3
    ldr	w17,	[x15]

    add	w13,	w7,	#1
    lsl	w23,	w7,	#2
    add	w14,	w17,	w8
    add	x22,	x18,	x23
    add	w1,	w13,	#1
    lsl	w28,	w13,	#2
    ldr	w24,	[x22]

    add	x27,	x18,	x28
    add	w6,	w1,	#1
    lsl	w4,	w1,	#2
    add	w22,	w24,	w14
    ldr	w0,	[x27]

    add	x3,	x18,	x4
    add	w0,	w0,	w22
    ldr	w5,	[x3]

    add	w27,	w5,	w0
    b	main_288

main_325:
    add	w19,	w19,	#1
    cmp	w19,	#1000
    blt	main_284

main_328:
    movz	w0,	#92
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#0

main_330:
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


