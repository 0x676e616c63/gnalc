.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global f
.align	2
f:
    .zero	800400

.global dep
.align	2
dep:
    .zero	40020

.global to
.align	2
to:
    .zero	40020

.global next
.align	2
next:
    .zero	40020

.global head
.align	2
head:
    .zero	40020


.text

.globl tree
tree:
tree_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w20,	#0
    adrp	x4, :got:f
    adrp	x28, :got:dep
    lsl	w12,	w0,	#2
    ldr	x28, [x28, #:got_lo12:dep]
    add	x26,	x28,	x12
    lsl	w28,	w0,	#4
    str	w1,	[x26]

    add	w16,	w28,	w0,	lsl #6
    ldr	x4, [x4, #:got_lo12:f]
    add	x5,	x4,	x16

tree_5:
    lsl	w18,	w20,	#2
    add	x17,	x5,	x18
    ldr	w26,	[x17]

    cmp	w26,	#0
    beq	tree_17

tree_10:
    add	w22,	w20,	#1
    lsl	w4,	w26,	#4
    adrp	x27, :got:f
    lsl	w2,	w20,	#2
    add	w3,	w4,	w26,	lsl #6
    ldr	x27, [x27, #:got_lo12:f]
    lsl	w24,	w22,	#2
    add	w20,	w20,	#1
    add	x3,	x27,	x3
    add	x19,	x5,	x24
    add	x28,	x3,	x2
    ldr	w3,	[x28]

    str	w3,	[x19]

    b	tree_5

tree_17:
    lsl	w19,	w0,	#2
    adrp	x26, :got:head
    ldr	x26, [x26, #:got_lo12:head]
    add	x24,	x26,	x19
    movz	w26,	#65535
    movk	w26,	#65535,	lsl #16
    ldr	w21,	[x24]

    cmp	w21,	w26
    beq	tree_60

tree_21:
    add	w27,	w1,	#1
    add	w20,	w27,	#1

tree_25:
    lsl	w22,	w21,	#2
    adrp	x16, :got:to
    movz	w8,	#0
    ldr	x16, [x16, #:got_lo12:to]
    add	x14,	x16,	x22
    adrp	x22, :got:dep
    ldr	w12,	[x14]

    lsl	w25,	w12,	#4
    ldr	x22, [x22, #:got_lo12:dep]
    lsl	w28,	w12,	#2
    add	w2,	w25,	w12,	lsl #6
    add	x18,	x22,	x28
    adrp	x25, :got:f
    str	w27,	[x18]

    ldr	x25, [x25, #:got_lo12:f]
    add	x1,	x25,	x2

tree_31:
    lsl	w5,	w8,	#2
    add	x4,	x1,	x5
    ldr	w6,	[x4]

    cmp	w6,	#0
    beq	tree_43

tree_36:
    add	w9,	w8,	#1
    lsl	w23,	w6,	#4
    adrp	x14, :got:f
    lsl	w16,	w8,	#2
    add	w4,	w23,	w6,	lsl #6
    ldr	x14, [x14, #:got_lo12:f]
    lsl	w11,	w9,	#2
    add	w8,	w8,	#1
    add	x3,	x14,	x4
    add	x13,	x1,	x11
    add	x15,	x3,	x16
    ldr	w17,	[x15]

    str	w17,	[x13]

    b	tree_31

tree_43:
    lsl	w22,	w12,	#2
    adrp	x15, :got:head
    ldr	x15, [x15, #:got_lo12:head]
    add	x13,	x15,	x22
    ldr	w19,	[x13]


tree_46:
    cmp	w19,	w26
    beq	tree_54

tree_49:
    lsl	w24,	w19,	#2
    adrp	x1, :got:to
    ldr	x1, [x1, #:got_lo12:to]
    add	x28,	x1,	x24
    mov	w1,	w20
    ldr	w0,	[x28]

    bl	tree
    adrp	x28, :got:next
    lsl	w4,	w19,	#2
    ldr	x28, [x28, #:got_lo12:next]
    add	x24,	x28,	x4
    ldr	w19,	[x24]

    b	tree_46

tree_54:
    lsl	w2,	w21,	#2
    adrp	x24, :got:next
    ldr	x24, [x24, #:got_lo12:next]
    add	x22,	x24,	x2
    ldr	w21,	[x22]

    cmp	w21,	w26
    bne	tree_25

tree_60:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getch
    movz	w26,	#0
    mov	w19,	w0

main_2:
    cmp	w19,	#48
    blt	main_10

main_6:
    cmp	w19,	#57
    bgt	main_10

main_14:
    movz	w25,	#0

main_15:
    cmp	w19,	#48
    blt	main_28

main_19:
    cmp	w19,	#57
    bgt	main_28

main_21:
    lsl	w18,	w25,	#1
    add	w23,	w18,	w25,	lsl #3
    add	w21,	w19,	w23
    sub	w25,	w21,	#48
    bl	getch
    mov	w19,	w0
    b	main_15

main_28:
    movz	w28,	#0
    sub	w28,	w28,	w25
    cmp	w26,	#0
    cset	w26,	ne
    csel	w26,	w28,	w25,	ne
    bl	getch
    movz	w28,	#0
    mov	w23,	w0

main_33:
    cmp	w23,	#48
    blt	main_41

main_37:
    cmp	w23,	#57
    bgt	main_41

main_45:
    movz	w21,	#0

main_46:
    cmp	w23,	#48
    blt	main_59

main_50:
    cmp	w23,	#57
    bgt	main_59

main_52:
    lsl	w27,	w21,	#1
    add	w25,	w27,	w21,	lsl #3
    add	w27,	w23,	w25
    sub	w21,	w27,	#48
    bl	getch
    mov	w23,	w0
    b	main_46

main_59:
    movz	w13,	#0
    sub	w3,	w13,	w21
    cmp	w28,	#0
    movz	w16,	#1
    adrp	x14, :got:dep
    csel	w21,	w3,	w21,	ne
    movz	w7,	#16191
    cset	w12,	ne
    ldr	x14, [x14, #:got_lo12:dep]
    movk	w7,	#16191,	lsl #16
    str	w7,	[x14]


main_64:
    cmp	w16,	w26
    bgt	main_70

main_67:
    lsl	w11,	w16,	#2
    adrp	x2, :got:head
    movz	w14,	#65535
    add	w16,	w16,	#1
    ldr	x2, [x2, #:got_lo12:head]
    movk	w14,	#65535,	lsl #16
    add	x9,	x2,	x11
    str	w14,	[x9]

    b	main_64

main_70:
    movz	w16,	#1
    cmp	w16,	w26
    beq	main_150

main_72:
    movz	w25,	#1
    movz	w23,	#0

main_74:
    bl	getch
    movz	w19,	#0
    mov	w2,	w0

main_78:
    cmp	w2,	#48
    blt	main_86

main_82:
    cmp	w2,	#57
    bgt	main_86

main_90:
    movz	w27,	#0

main_91:
    cmp	w2,	#48
    blt	main_104

main_95:
    cmp	w2,	#57
    bgt	main_104

main_97:
    lsl	w22,	w27,	#1
    add	w18,	w22,	w27,	lsl #3
    add	w20,	w2,	w18
    sub	w27,	w20,	#48
    bl	getch
    mov	w2,	w0
    b	main_91

main_104:
    movz	w24,	#0
    sub	w22,	w24,	w27
    cmp	w19,	#0
    csel	w19,	w22,	w27,	ne
    cset	w28,	ne
    bl	getch
    movz	w22,	#0
    mov	w6,	w0

main_109:
    cmp	w6,	#48
    blt	main_117

main_113:
    cmp	w6,	#57
    bgt	main_117

main_121:
    movz	w27,	#0

main_122:
    cmp	w6,	#48
    blt	main_135

main_126:
    cmp	w6,	#57
    bgt	main_135

main_128:
    lsl	w28,	w27,	#1
    add	w20,	w28,	w27,	lsl #3
    add	w24,	w6,	w20
    sub	w27,	w24,	#48
    bl	getch
    mov	w6,	w0
    b	main_122

main_135:
    movz	w6,	#0
    sub	w11,	w6,	w27
    cmp	w22,	#0
    adrp	x1, :got:f
    add	w25,	w25,	#1
    cset	w28,	ne
    lsl	w3,	w23,	#2
    adrp	x13, :got:to
    adrp	x20, :got:head
    adrp	x16, :got:next
    csel	w10,	w11,	w27,	ne
    lsl	w6,	w23,	#2
    lsl	w9,	w19,	#2
    ldr	x13, [x13, #:got_lo12:to]
    add	x11,	x13,	x3
    str	w10,	[x11]

    ldr	x16, [x16, #:got_lo12:next]
    ldr	x20, [x20, #:got_lo12:head]
    add	x17,	x16,	x6
    add	x8,	x20,	x9
    ldr	w22,	[x8]

    str	w22,	[x17]

    lsl	w17,	w10,	#4
    str	w23,	[x8]

    ldr	x1, [x1, #:got_lo12:f]
    add	w23,	w23,	#1
    add	w15,	w17,	w10,	lsl #6
    add	x2,	x1,	x15
    str	w19,	[x2]

    cmp	w25,	w26
    bne	main_74

main_150:
    movz	w0,	#1
    movz	w1,	#1
    bl	tree
    cmp	w21,	#0
    beq	main_373

main_154:
    bl	getch
    movz	w20,	#0
    mov	w8,	w0

main_157:
    cmp	w8,	#48
    blt	main_165

main_161:
    cmp	w8,	#57
    bgt	main_165

main_169:
    movz	w25,	#0

main_170:
    cmp	w8,	#48
    blt	main_183

main_174:
    cmp	w8,	#57
    bgt	main_183

main_176:
    lsl	w26,	w25,	#1
    add	w26,	w26,	w25,	lsl #3
    add	w27,	w8,	w26
    sub	w25,	w27,	#48
    bl	getch
    mov	w8,	w0
    b	main_170

main_183:
    movz	w27,	#0
    sub	w18,	w27,	w25
    cmp	w20,	#0
    csel	w22,	w18,	w25,	ne
    cset	w20,	ne
    bl	getch
    movz	w26,	#0
    mov	w12,	w0

main_188:
    cmp	w12,	#48
    blt	main_196

main_192:
    cmp	w12,	#57
    bgt	main_196

main_200:
    movz	w20,	#0

main_201:
    cmp	w12,	#48
    blt	main_214

main_205:
    cmp	w12,	#57
    bgt	main_214

main_207:
    lsl	w25,	w20,	#1
    add	w18,	w25,	w20,	lsl #3
    add	w19,	w12,	w18
    sub	w20,	w19,	#48
    bl	getch
    mov	w12,	w0
    b	main_201

main_214:
    movz	w2,	#0
    sub	w4,	w2,	w20
    cmp	w26,	#0
    cset	w7,	ne
    csel	w8,	w4,	w20,	ne
    adrp	x18, :got:dep
    adrp	x24, :got:dep
    lsl	w10,	w22,	#2
    lsl	w14,	w8,	#2
    ldr	x18, [x18, #:got_lo12:dep]
    add	x9,	x18,	x10
    ldr	w10,	[x9]

    ldr	x24, [x24, #:got_lo12:dep]
    add	x4,	x24,	x14
    ldr	w25,	[x4]

    cmp	w10,	w25
    csel	x23,	x9,	x4,	lt
    csel	x16,	x4,	x9,	lt
    csel	w0,	w8,	w22,	lt
    csel	w13,	w22,	w8,	lt
    cset	w26,	lt
    ldr	w25,	[x16]

    ldr	w24,	[x23]

    cmp	w25,	w24
    ble	main_255

main_230:
    movz	w4,	#19

main_232:
    lsl	w9,	w0,	#4
    adrp	x2, :got:f
    lsl	w5,	w4,	#2
    ldr	x2, [x2, #:got_lo12:f]
    add	w1,	w9,	w0,	lsl #6
    add	x28,	x2,	x1
    add	x3,	x28,	x5
    ldr	w27,	[x3]

    cmp	w27,	#0
    beq	main_247

main_240:
    lsl	w9,	w27,	#2
    adrp	x10, :got:dep
    ldr	x10, [x10, #:got_lo12:dep]
    add	x1,	x10,	x9
    ldr	w11,	[x1]

    cmp	w11,	w24
    csel	w0,	w27,	w0,	ge
    csel	x16,	x1,	x16,	ge
    cset	w12,	ge

main_247:
    sub	w4,	w4,	#1
    ldr	w18,	[x16]

    cmp	w18,	w24
    bgt	main_232

main_255:
    cmp	w0,	w13
    beq	main_367

main_258:
    movz	w24,	#19

main_259:
    cmp	w24,	#4
    ble	main_347

main_264:
    lsl	w9,	w0,	#4
    adrp	x8, :got:f
    lsl	w10,	w24,	#2
    adrp	x15, :got:f
    lsl	w17,	w24,	#2
    add	w23,	w9,	w0,	lsl #6
    ldr	x8, [x8, #:got_lo12:f]
    add	x22,	x8,	x23
    add	x9,	x22,	x10
    lsl	w10,	w13,	#4
    ldr	w23,	[x9]

    add	w2,	w10,	w13,	lsl #6
    ldr	x15, [x15, #:got_lo12:f]
    add	x1,	x15,	x2
    add	x16,	x1,	x17
    ldr	w7,	[x16]

    cmp	w23,	w7
    cset	w19,	ne
    adrp	x12, :got:f
    csel	w27,	w23,	w0,	ne
    csel	w9,	w7,	w13,	ne
    sub	w5,	w24,	#1
    adrp	x18, :got:f
    ldr	x12, [x12, #:got_lo12:f]
    lsl	w23,	w27,	#4
    lsl	w24,	w9,	#4
    lsl	w14,	w5,	#2
    lsl	w20,	w5,	#2
    add	w15,	w23,	w27,	lsl #6
    add	w22,	w24,	w9,	lsl #6
    add	x13,	x12,	x15
    add	x13,	x13,	x14
    ldr	w11,	[x13]

    ldr	x18, [x18, #:got_lo12:f]
    add	x19,	x18,	x22
    add	x19,	x19,	x20
    ldr	w20,	[x19]

    cmp	w11,	w20
    cset	w23,	ne
    csel	w22,	w20,	w9,	ne
    csel	w19,	w11,	w27,	ne
    sub	w24,	w5,	#1
    adrp	x6, :got:f
    adrp	x0, :got:f
    lsl	w26,	w22,	#4
    lsl	w25,	w19,	#4
    lsl	w8,	w24,	#2
    lsl	w2,	w24,	#2
    ldr	x0, [x0, #:got_lo12:f]
    add	w10,	w26,	w22,	lsl #6
    add	w4,	w25,	w19,	lsl #6
    add	x3,	x0,	x4
    add	x1,	x3,	x2
    ldr	w5,	[x1]

    ldr	x6, [x6, #:got_lo12:f]
    add	x9,	x6,	x10
    add	x7,	x9,	x8
    ldr	w9,	[x7]

    cmp	w5,	w9
    adrp	x23, :got:f
    cset	w10,	ne
    csel	w13,	w9,	w22,	ne
    csel	w11,	w5,	w19,	ne
    sub	w15,	w24,	#1
    adrp	x16, :got:f
    lsl	w28,	w13,	#4
    lsl	w27,	w11,	#4
    ldr	x16, [x16, #:got_lo12:f]
    lsl	w25,	w15,	#2
    lsl	w18,	w15,	#2
    add	w20,	w27,	w11,	lsl #6
    add	w27,	w28,	w13,	lsl #6
    add	x19,	x16,	x20
    add	x17,	x19,	x18
    ldr	w22,	[x17]

    ldr	x23, [x23, #:got_lo12:f]
    add	x26,	x23,	x27
    add	x24,	x26,	x25
    ldr	w28,	[x24]

    cmp	w22,	w28
    cset	w27,	ne
    csel	w2,	w28,	w13,	ne
    csel	w7,	w22,	w11,	ne
    adrp	x4, :got:f
    adrp	x10, :got:f
    lsl	w1,	w2,	#4
    sub	w13,	w15,	#1
    lsl	w0,	w7,	#4
    ldr	x4, [x4, #:got_lo12:f]
    add	w15,	w1,	w2,	lsl #6
    add	w9,	w0,	w7,	lsl #6
    lsl	w12,	w13,	#2
    lsl	w6,	w13,	#2
    add	x8,	x4,	x9
    add	x5,	x8,	x6
    ldr	w0,	[x5]

    ldr	x10, [x10, #:got_lo12:f]
    add	x14,	x10,	x15
    add	x11,	x14,	x12
    ldr	w17,	[x11]

    cmp	w0,	w17
    adrp	x27, :got:f
    cset	w14,	ne
    csel	w6,	w17,	w2,	ne
    csel	w4,	w0,	w7,	ne
    sub	w9,	w13,	#1
    adrp	x20, :got:f
    lsl	w3,	w6,	#4
    lsl	w2,	w4,	#4
    ldr	x20, [x20, #:got_lo12:f]
    lsl	w0,	w9,	#2
    lsl	w23,	w9,	#2
    add	w3,	w3,	w6,	lsl #6
    add	w26,	w2,	w4,	lsl #6
    add	x25,	x20,	x26
    add	x22,	x25,	x23
    ldr	w13,	[x22]

    ldr	x27, [x27, #:got_lo12:f]
    add	x3,	x27,	x3
    add	x28,	x3,	x0
    ldr	w7,	[x28]

    cmp	w13,	w7
    cset	w2,	ne
    csel	w6,	w7,	w6,	ne
    csel	w3,	w13,	w4,	ne
    sub	w25,	w9,	#1
    adrp	x8, :got:f
    lsl	w5,	w6,	#4
    lsl	w4,	w3,	#4
    ldr	x8, [x8, #:got_lo12:f]
    lsl	w16,	w25,	#2
    lsl	w10,	w25,	#2
    add	w20,	w5,	w6,	lsl #6
    add	w14,	w4,	w3,	lsl #6
    add	x13,	x8,	x14
    adrp	x14, :got:f
    add	x9,	x13,	x10
    ldr	w12,	[x9]

    ldr	x14, [x14, #:got_lo12:f]
    add	x19,	x14,	x20
    add	x15,	x19,	x16
    ldr	w24,	[x15]

    cmp	w12,	w24
    cset	w18,	ne
    csel	w24,	w24,	w6,	ne
    csel	w22,	w12,	w3,	ne
    sub	w18,	w25,	#1
    lsl	w7,	w24,	#4
    lsl	w6,	w22,	#4
    adrp	x25, :got:f
    lsl	w4,	w18,	#2
    lsl	w27,	w18,	#2
    add	w9,	w7,	w24,	lsl #6
    add	w2,	w6,	w22,	lsl #6
    ldr	x25, [x25, #:got_lo12:f]
    add	x1,	x25,	x2
    adrp	x2, :got:f
    add	x26,	x1,	x27
    ldr	w15,	[x26]

    ldr	x2, [x2, #:got_lo12:f]
    add	x8,	x2,	x9
    add	x3,	x8,	x4
    ldr	w13,	[x3]

    cmp	w15,	w13
    csel	w0,	w15,	w22,	ne
    csel	w13,	w13,	w24,	ne
    cset	w6,	ne
    sub	w24,	w18,	#1
    b	main_259

main_347:
    lsl	w28,	w0,	#4
    adrp	x11, :got:f
    lsl	w14,	w24,	#2
    lsl	w1,	w13,	#4
    adrp	x18, :got:f
    lsl	w20,	w24,	#2
    add	w4,	w28,	w0,	lsl #6
    ldr	x11, [x11, #:got_lo12:f]
    add	w10,	w1,	w13,	lsl #6
    add	x3,	x11,	x4
    add	x12,	x3,	x14
    ldr	w6,	[x12]

    ldr	x18, [x18, #:got_lo12:f]
    add	x9,	x18,	x10
    add	x19,	x9,	x20
    ldr	w15,	[x19]

    cmp	w6,	w15
    sub	w24,	w24,	#1
    csel	w13,	w15,	w13,	ne
    csel	w0,	w6,	w0,	ne
    cset	w23,	ne
    cmp	w24,	#0
    bge	main_347

main_362:
    lsl	w25,	w0,	#4
    adrp	x1, :got:f
    ldr	x1, [x1, #:got_lo12:f]
    add	w9,	w25,	w0,	lsl #6
    add	x2,	x1,	x9
    ldr	w0,	[x2]


main_367:
    bl	putint
    movz	w0,	#10
    bl	putch
    sub	w21,	w21,	#1
    cmp	w21,	#0
    bne	main_154

main_373:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_196:
    cmp	w12,	#45
    movz	w23,	#1
    cset	w20,	eq
    csel	w26,	w23,	w26,	eq
    bl	getch
    mov	w12,	w0
    b	main_188

main_165:
    cmp	w8,	#45
    movz	w24,	#1
    cset	w28,	eq
    csel	w20,	w24,	w20,	eq
    bl	getch
    mov	w8,	w0
    b	main_157

main_117:
    cmp	w6,	#45
    movz	w24,	#1
    cset	w27,	eq
    csel	w22,	w24,	w22,	eq
    bl	getch
    mov	w6,	w0
    b	main_109

main_86:
    cmp	w2,	#45
    movz	w22,	#1
    cset	w28,	eq
    csel	w19,	w22,	w19,	eq
    bl	getch
    mov	w2,	w0
    b	main_78

main_41:
    cmp	w23,	#45
    movz	w23,	#1
    cset	w27,	eq
    csel	w28,	w23,	w28,	eq
    bl	getch
    mov	w23,	w0
    b	main_33

main_10:
    cmp	w19,	#45
    movz	w24,	#1
    cset	w25,	eq
    csel	w26,	w24,	w26,	eq
    bl	getch
    mov	w19,	w0
    b	main_2

