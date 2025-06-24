.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global to
.align	2
to:
    .zero	20020

.global next
.align	2
next:
    .zero	20020

.global head
.align	2
head:
    .zero	4020

.global vis
.align	2
vis:
    .zero	4020


.text

.globl same
same:
same_2:
    sub	sp, sp, #80
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x24, x25, [sp, #32]
    stp	x26, x28, [sp, #48]
    stp	fp, lr, [sp, #64]
    
    movz	w6,	#1
    adrp	x2, :got:vis
    lsl	w14,	w0,	#2
    mov	w19,	w1
    ldr	x2, [x2, #:got_lo12:vis]
    add	x13,	x2,	x14
    str	w6,	[x13]

    cmp	w0,	w19
    beq	same_52

same_5:
    lsl	w4,	w0,	#2
    adrp	x11, :got:head
    ldr	x11, [x11, #:got_lo12:head]
    add	x9,	x11,	x4
    ldr	w20,	[x9]


same_8:
    movz	w24,	#65535
    movk	w24,	#65535,	lsl #16
    cmp	w20,	w24
    beq	same_55

same_11:
    lsl	w28,	w20,	#2
    adrp	x25, :got:to
    adrp	x0, :got:vis
    ldr	x25, [x25, #:got_lo12:to]
    add	x22,	x25,	x28
    ldr	w25,	[x22]

    ldr	x0, [x0, #:got_lo12:vis]
    lsl	w4,	w25,	#2
    add	x7,	x0,	x4
    ldr	w1,	[x7]

    cmp	w1,	#0
    bne	same_49

same_17:
    movz	w14,	#1
    str	w14,	[x7]

    cmp	w25,	w19
    beq	same_39

same_19:
    lsl	w10,	w25,	#2
    adrp	x6, :got:head
    ldr	x6, [x6, #:got_lo12:head]
    add	x4,	x6,	x10
    ldr	w21,	[x4]


same_22:
    cmp	w21,	w24
    beq	same_43

same_25:
    lsl	w22,	w21,	#2
    adrp	x15, :got:to
    adrp	x28, :got:vis
    ldr	x15, [x15, #:got_lo12:to]
    add	x13,	x15,	x22
    ldr	w0,	[x13]

    ldr	x28, [x28, #:got_lo12:vis]
    lsl	w14,	w0,	#2
    add	x26,	x28,	x14
    ldr	w1,	[x26]

    cmp	w1,	#0
    bne	same_36

same_31:
    mov	w1,	w19
    bl	same
    cmp	w0,	#0
    beq	same_36

same_44:
    movz	w0,	#1
    b	same_40

same_36:
    lsl	w0,	w21,	#2
    adrp	x25, :got:next
    ldr	x25, [x25, #:got_lo12:next]
    add	x22,	x25,	x0
    ldr	w21,	[x22]

    b	same_22

same_43:
    movz	w0,	#0
    b	same_40

same_39:
    movz	w0,	#1

same_40:
    cmp	w0,	#0
    beq	same_49

same_56:
    movz	w0,	#1
    b	same_53

same_49:
    lsl	w13,	w20,	#2
    adrp	x20, :got:next
    ldr	x20, [x20, #:got_lo12:next]
    add	x17,	x20,	x13
    ldr	w20,	[x17]

    b	same_8

same_55:
    movz	w0,	#0
    b	same_53

same_52:
    movz	w0,	#1

same_53:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x24, x25, [sp, #32]
    ldp	x26, x28, [sp, #48]
    ldp	fp, lr, [sp, #64]
    
    add	sp, sp, #80
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getch
    movz	w27,	#0
    mov	w24,	w0

main_2:
    cmp	w24,	#48
    blt	main_10

main_6:
    cmp	w24,	#57
    bgt	main_10

main_14:
    movz	w22,	#0

main_15:
    cmp	w24,	#48
    blt	main_28

main_19:
    cmp	w24,	#57
    bgt	main_28

main_21:
    lsl	w26,	w22,	#1
    add	w28,	w26,	w22,	lsl #3
    add	w19,	w24,	w28
    sub	w22,	w19,	#48
    bl	getch
    mov	w24,	w0
    b	main_15

main_28:
    movz	w25,	#0
    sub	w26,	w25,	w22
    cmp	w27,	#0
    csel	w22,	w26,	w22,	ne
    cset	w24,	ne
    bl	getch
    movz	w21,	#0
    mov	w28,	w0

main_33:
    cmp	w28,	#48
    blt	main_41

main_37:
    cmp	w28,	#57
    bgt	main_41

main_45:
    movz	w19,	#0

main_46:
    cmp	w28,	#48
    blt	main_59

main_50:
    cmp	w28,	#57
    bgt	main_59

main_52:
    lsl	w18,	w19,	#1
    add	w26,	w18,	w19,	lsl #3
    add	w23,	w28,	w26
    sub	w19,	w23,	#48
    bl	getch
    mov	w28,	w0
    b	main_46

main_59:
    movz	w8,	#0
    sub	w23,	w8,	w19
    cmp	w21,	#0
    movz	w4,	#0
    csel	w27,	w23,	w19,	ne
    cset	w6,	ne

main_63:
    movz	w10,	#65535
    movk	w10,	#65535,	lsl #16
    cmp	w4,	#952
    bge	main_181

main_66:
    lsl	w21,	w4,	#2
    adrp	x1, :got:head
    add	w9,	w4,	#1
    adrp	x24, :got:head
    adrp	x5, :got:head
    adrp	x13, :got:head
    adrp	x17, :got:head
    ldr	x1, [x1, #:got_lo12:head]
    add	w15,	w9,	#1
    lsl	w4,	w9,	#2
    add	x26,	x1,	x21
    adrp	x1, :got:head
    add	w20,	w15,	#1
    lsl	w9,	w15,	#2
    str	w10,	[x26]

    ldr	x24, [x24, #:got_lo12:head]
    add	w25,	w20,	#1
    lsl	w14,	w20,	#2
    add	x21,	x24,	x4
    add	w2,	w25,	#1
    lsl	w18,	w25,	#2
    str	w10,	[x21]

    adrp	x21, :got:head
    ldr	x1, [x1, #:got_lo12:head]
    add	w6,	w2,	#1
    lsl	w23,	w2,	#2
    add	x26,	x1,	x9
    adrp	x9, :got:head
    lsl	w28,	w6,	#2
    str	w10,	[x26]

    adrp	x26, :got:head
    ldr	x5, [x5, #:got_lo12:head]
    add	x3,	x5,	x14
    adrp	x14, :got:head
    str	w10,	[x3]

    adrp	x3, :got:head
    ldr	x9, [x9, #:got_lo12:head]
    add	x7,	x9,	x18
    adrp	x18, :got:head
    str	w10,	[x7]

    adrp	x7, :got:head
    ldr	x14, [x14, #:got_lo12:head]
    add	x12,	x14,	x23
    adrp	x23, :got:head
    str	w10,	[x12]

    add	w12,	w6,	#1
    ldr	x18, [x18, #:got_lo12:head]
    add	x16,	x18,	x28
    adrp	x28, :got:head
    lsl	w4,	w12,	#2
    str	w10,	[x16]

    add	w16,	w12,	#1
    ldr	x23, [x23, #:got_lo12:head]
    adrp	x12, :got:head
    add	x20,	x23,	x4
    adrp	x4, :got:head
    lsl	w8,	w16,	#2
    add	w23,	w16,	#1
    str	w10,	[x20]

    adrp	x16, :got:head
    adrp	x20, :got:head
    ldr	x28, [x28, #:got_lo12:head]
    lsl	w14,	w23,	#2
    add	x25,	x28,	x8
    adrp	x8, :got:head
    add	w28,	w23,	#1
    str	w10,	[x25]

    lsl	w18,	w28,	#2
    ldr	x4, [x4, #:got_lo12:head]
    add	x2,	x4,	x14
    add	w4,	w28,	#1
    str	w10,	[x2]

    lsl	w23,	w4,	#2
    ldr	x8, [x8, #:got_lo12:head]
    add	x6,	x8,	x18
    add	w8,	w4,	#1
    str	w10,	[x6]

    add	w14,	w8,	#1
    lsl	w28,	w8,	#2
    ldr	x13, [x13, #:got_lo12:head]
    add	x11,	x13,	x23
    add	w18,	w14,	#1
    lsl	w4,	w14,	#2
    str	w10,	[x11]

    add	w25,	w18,	#1
    lsl	w8,	w18,	#2
    ldr	x17, [x17, #:got_lo12:head]
    add	x15,	x17,	x28
    add	w2,	w25,	#1
    lsl	w14,	w25,	#2
    adrp	x25, :got:head
    str	w10,	[x15]

    add	w6,	w2,	#1
    lsl	w18,	w2,	#2
    adrp	x15, :got:head
    ldr	x21, [x21, #:got_lo12:head]
    adrp	x2, :got:head
    add	x19,	x21,	x4
    add	w11,	w6,	#1
    lsl	w23,	w6,	#2
    adrp	x6, :got:head
    str	w10,	[x19]

    lsl	w28,	w11,	#2
    adrp	x19, :got:head
    ldr	x26, [x26, #:got_lo12:head]
    add	x24,	x26,	x8
    str	w10,	[x24]

    adrp	x24, :got:head
    ldr	x3, [x3, #:got_lo12:head]
    add	x1,	x3,	x14
    str	w10,	[x1]

    adrp	x1, :got:head
    ldr	x7, [x7, #:got_lo12:head]
    add	x5,	x7,	x18
    str	w10,	[x5]

    ldr	x12, [x12, #:got_lo12:head]
    add	x9,	x12,	x23
    str	w10,	[x9]

    ldr	x16, [x16, #:got_lo12:head]
    add	x14,	x16,	x28
    add	w16,	w11,	#1
    adrp	x11, :got:head
    str	w10,	[x14]

    lsl	w4,	w16,	#2
    ldr	x20, [x20, #:got_lo12:head]
    add	x18,	x20,	x4
    add	w20,	w16,	#1
    str	w10,	[x18]

    add	w26,	w20,	#1
    lsl	w8,	w20,	#2
    ldr	x25, [x25, #:got_lo12:head]
    add	x23,	x25,	x8
    add	w5,	w26,	#1
    lsl	w14,	w26,	#2
    str	w10,	[x23]

    add	w9,	w5,	#1
    lsl	w18,	w5,	#2
    ldr	x2, [x2, #:got_lo12:head]
    adrp	x5, :got:head
    add	x28,	x2,	x14
    lsl	w23,	w9,	#2
    add	w14,	w9,	#1
    adrp	x9, :got:head
    str	w10,	[x28]

    add	w20,	w14,	#1
    lsl	w28,	w14,	#2
    ldr	x6, [x6, #:got_lo12:head]
    add	x4,	x6,	x18
    add	w25,	w20,	#1
    str	w10,	[x4]

    add	w3,	w25,	#1
    lsl	w4,	w20,	#2
    ldr	x11, [x11, #:got_lo12:head]
    add	x8,	x11,	x23
    lsl	w14,	w3,	#2
    str	w10,	[x8]

    lsl	w8,	w25,	#2
    ldr	x15, [x15, #:got_lo12:head]
    add	x13,	x15,	x28
    str	w10,	[x13]

    ldr	x19, [x19, #:got_lo12:head]
    add	x17,	x19,	x4
    str	w10,	[x17]

    ldr	x24, [x24, #:got_lo12:head]
    add	x21,	x24,	x8
    add	w8,	w3,	#1
    str	w10,	[x21]

    add	w13,	w8,	#1
    lsl	w18,	w8,	#2
    adrp	x21, :got:head
    ldr	x1, [x1, #:got_lo12:head]
    add	x26,	x1,	x14
    add	w17,	w13,	#1
    lsl	w23,	w13,	#2
    adrp	x14, :got:head
    str	w10,	[x26]

    lsl	w28,	w17,	#2
    adrp	x26, :got:head
    ldr	x5, [x5, #:got_lo12:head]
    add	x3,	x5,	x18
    adrp	x18, :got:head
    str	w10,	[x3]

    adrp	x3, :got:head
    ldr	x9, [x9, #:got_lo12:head]
    add	x7,	x9,	x23
    add	w23,	w17,	#1
    adrp	x17, :got:head
    str	w10,	[x7]

    lsl	w4,	w23,	#2
    adrp	x7, :got:head
    ldr	x14, [x14, #:got_lo12:head]
    add	x12,	x14,	x28
    add	w28,	w23,	#1
    adrp	x23, :got:head
    str	w10,	[x12]

    lsl	w8,	w28,	#2
    adrp	x12, :got:head
    ldr	x18, [x18, #:got_lo12:head]
    add	x16,	x18,	x4
    add	w4,	w28,	#1
    adrp	x28, :got:head
    str	w10,	[x16]

    lsl	w13,	w4,	#2
    add	w11,	w4,	#1
    adrp	x16, :got:head
    ldr	x23, [x23, #:got_lo12:head]
    adrp	x4, :got:head
    add	x20,	x23,	x8
    add	w15,	w11,	#1
    lsl	w18,	w11,	#2
    adrp	x8, :got:head
    str	w10,	[x20]

    add	w19,	w15,	#1
    lsl	w23,	w15,	#2
    adrp	x20, :got:head
    ldr	x28, [x28, #:got_lo12:head]
    add	x25,	x28,	x13
    adrp	x13, :got:head
    lsl	w28,	w19,	#2
    str	w10,	[x25]

    add	w25,	w19,	#1
    ldr	x4, [x4, #:got_lo12:head]
    add	x2,	x4,	x18
    lsl	w4,	w25,	#2
    str	w10,	[x2]

    add	w2,	w25,	#1
    ldr	x8, [x8, #:got_lo12:head]
    adrp	x25, :got:head
    add	x6,	x8,	x23
    lsl	w8,	w2,	#2
    str	w10,	[x6]

    add	w6,	w2,	#1
    ldr	x13, [x13, #:got_lo12:head]
    adrp	x2, :got:head
    add	x11,	x13,	x28
    lsl	w13,	w6,	#2
    str	w10,	[x11]

    adrp	x11, :got:head
    ldr	x17, [x17, #:got_lo12:head]
    add	x15,	x17,	x4
    str	w10,	[x15]

    adrp	x15, :got:head
    ldr	x21, [x21, #:got_lo12:head]
    add	x19,	x21,	x8
    str	w10,	[x19]

    ldr	x26, [x26, #:got_lo12:head]
    add	x24,	x26,	x13
    add	w13,	w6,	#1
    adrp	x6, :got:head
    str	w10,	[x24]

    add	w17,	w13,	#1
    lsl	w18,	w13,	#2
    ldr	x3, [x3, #:got_lo12:head]
    add	x1,	x3,	x18
    add	w21,	w17,	#1
    lsl	w23,	w17,	#2
    str	w10,	[x1]

    lsl	w28,	w21,	#2
    adrp	x1, :got:head
    ldr	x7, [x7, #:got_lo12:head]
    add	x5,	x7,	x23
    str	w10,	[x5]

    adrp	x5, :got:head
    ldr	x12, [x12, #:got_lo12:head]
    add	x9,	x12,	x28
    add	w28,	w21,	#1
    str	w10,	[x9]

    lsl	w4,	w28,	#2
    adrp	x9, :got:head
    ldr	x16, [x16, #:got_lo12:head]
    add	x14,	x16,	x4
    add	w4,	w28,	#1
    str	w10,	[x14]

    lsl	w8,	w4,	#2
    ldr	x20, [x20, #:got_lo12:head]
    add	x18,	x20,	x8
    add	w8,	w4,	#1
    str	w10,	[x18]

    add	w14,	w8,	#1
    lsl	w13,	w8,	#2
    ldr	x25, [x25, #:got_lo12:head]
    add	x23,	x25,	x13
    add	w19,	w14,	#1
    lsl	w18,	w14,	#2
    adrp	x14, :got:head
    str	w10,	[x23]

    add	w24,	w19,	#1
    lsl	w23,	w19,	#2
    ldr	x2, [x2, #:got_lo12:head]
    adrp	x19, :got:head
    add	x28,	x2,	x18
    add	w2,	w24,	#1
    str	w10,	[x28]

    lsl	w28,	w24,	#2
    ldr	x6, [x6, #:got_lo12:head]
    adrp	x24, :got:head
    add	x4,	x6,	x23
    add	w6,	w2,	#1
    str	w10,	[x4]

    lsl	w4,	w2,	#2
    ldr	x11, [x11, #:got_lo12:head]
    add	x8,	x11,	x28
    add	w11,	w6,	#1
    str	w10,	[x8]

    add	w16,	w11,	#1
    lsl	w8,	w6,	#2
    ldr	x15, [x15, #:got_lo12:head]
    add	x13,	x15,	x4
    lsl	w18,	w16,	#2
    str	w10,	[x13]

    lsl	w13,	w11,	#2
    ldr	x19, [x19, #:got_lo12:head]
    add	x17,	x19,	x8
    str	w10,	[x17]

    ldr	x24, [x24, #:got_lo12:head]
    add	x21,	x24,	x13
    str	w10,	[x21]

    add	w21,	w16,	#1
    ldr	x1, [x1, #:got_lo12:head]
    add	x26,	x1,	x18
    lsl	w23,	w21,	#2
    str	w10,	[x26]

    add	w26,	w21,	#1
    ldr	x5, [x5, #:got_lo12:head]
    add	x3,	x5,	x23
    lsl	w28,	w26,	#2
    add	w5,	w26,	#1
    str	w10,	[x3]

    ldr	x9, [x9, #:got_lo12:head]
    lsl	w4,	w5,	#2
    add	x7,	x9,	x28
    str	w10,	[x7]

    ldr	x14, [x14, #:got_lo12:head]
    add	x12,	x14,	x4
    add	w4,	w5,	#1
    str	w10,	[x12]

    b	main_63

main_181:
    lsl	w15,	w4,	#2
    adrp	x11, :got:head
    add	w14,	w4,	#1
    adrp	x23, :got:head
    adrp	x28, :got:head
    adrp	x21, :got:head
    ldr	x11, [x11, #:got_lo12:head]
    adrp	x4, :got:head
    add	w18,	w14,	#1
    lsl	w13,	w14,	#2
    add	x8,	x11,	x15
    lsl	w17,	w18,	#2
    str	w10,	[x8]

    adrp	x8, :got:head
    ldr	x23, [x23, #:got_lo12:head]
    add	x20,	x23,	x13
    adrp	x13, :got:head
    str	w10,	[x20]

    ldr	x28, [x28, #:got_lo12:head]
    add	x25,	x28,	x17
    adrp	x17, :got:head
    str	w10,	[x25]

    ldr	x4, [x4, #:got_lo12:head]
    add	w25,	w18,	#1
    lsl	w23,	w25,	#2
    add	x2,	x4,	x23
    str	w10,	[x2]

    ldr	x8, [x8, #:got_lo12:head]
    add	w2,	w25,	#1
    add	w7,	w2,	#1
    lsl	w28,	w2,	#2
    add	x6,	x8,	x28
    add	w12,	w7,	#1
    lsl	w4,	w7,	#2
    str	w10,	[x6]

    add	w16,	w12,	#1
    lsl	w8,	w12,	#2
    ldr	x13, [x13, #:got_lo12:head]
    add	x11,	x13,	x4
    add	w4,	w16,	#1
    lsl	w13,	w16,	#2
    str	w10,	[x11]

    ldr	x17, [x17, #:got_lo12:head]
    add	x15,	x17,	x8
    str	w10,	[x15]

    ldr	x21, [x21, #:got_lo12:head]
    add	x19,	x21,	x13
    str	w10,	[x19]

    cmp	w4,	#1000
    blt	main_181

main_202:
    lsl	w26,	w4,	#2
    adrp	x20, :got:head
    add	w4,	w4,	#1
    ldr	x20, [x20, #:got_lo12:head]
    add	x18,	x20,	x26
    str	w10,	[x18]

    cmp	w4,	#1005
    blt	main_202

main_207:
    cmp	w27,	#0
    beq	main_376

main_209:
    movz	w21,	#0

main_211:
    bl	getch
    mov	w24,	w0

main_215:
    cmp	w24,	#81
    beq	main_224

main_218:
    cmp	w24,	#85
    beq	main_224

main_220:
    bl	getch
    mov	w24,	w0
    b	main_215

main_224:
    cmp	w24,	#81
    bne	main_297

main_226:
    bl	getch
    movz	w24,	#0
    mov	w28,	w0

main_228:
    cmp	w28,	#48
    blt	main_236

main_232:
    cmp	w28,	#57
    bgt	main_236

main_240:
    movz	w23,	#0

main_241:
    cmp	w28,	#48
    blt	main_254

main_245:
    cmp	w28,	#57
    bgt	main_254

main_247:
    lsl	w19,	w23,	#1
    add	w19,	w19,	w23,	lsl #3
    add	w20,	w28,	w19
    sub	w23,	w20,	#48
    bl	getch
    mov	w28,	w0
    b	main_241

main_254:
    movz	w25,	#0
    sub	w20,	w25,	w23
    cmp	w24,	#0
    cset	w28,	ne
    csel	w28,	w20,	w23,	ne
    bl	getch
    movz	w23,	#0
    mov	w4,	w0

main_259:
    cmp	w4,	#48
    blt	main_267

main_263:
    cmp	w4,	#57
    bgt	main_267

main_271:
    movz	w26,	#0

main_272:
    cmp	w4,	#48
    blt	main_285

main_276:
    cmp	w4,	#57
    bgt	main_285

main_278:
    lsl	w20,	w26,	#1
    add	w19,	w20,	w26,	lsl #3
    add	w20,	w4,	w19
    sub	w26,	w20,	#48
    bl	getch
    mov	w4,	w0
    b	main_272

main_285:
    movz	w17,	#0
    sub	w8,	w17,	w26
    cmp	w23,	#0
    csel	w1,	w8,	w26,	ne
    movz	w5,	#1
    cset	w0,	ne

main_289:
    cmp	w5,	w22
    bgt	main_295

main_292:
    lsl	w15,	w5,	#2
    adrp	x14, :got:vis
    movz	w19,	#0
    add	w5,	w5,	#1
    ldr	x14, [x14, #:got_lo12:vis]
    add	x13,	x14,	x15
    str	w19,	[x13]

    b	main_289

main_295:
    mov	w0,	w28
    bl	same
    bl	putint
    movz	w0,	#10
    bl	putch
    b	main_370

main_267:
    cmp	w4,	#45
    movz	w25,	#1
    cset	w20,	eq
    csel	w23,	w25,	w23,	eq
    bl	getch
    mov	w4,	w0
    b	main_259

main_236:
    cmp	w28,	#45
    movz	w26,	#1
    cset	w19,	eq
    csel	w24,	w26,	w24,	eq
    bl	getch
    mov	w28,	w0
    b	main_228

main_297:
    bl	getch
    movz	w26,	#0
    mov	w15,	w0

main_299:
    cmp	w15,	#48
    blt	main_307

main_303:
    cmp	w15,	#57
    bgt	main_307

main_311:
    movz	w25,	#0

main_312:
    cmp	w15,	#48
    blt	main_325

main_316:
    cmp	w15,	#57
    bgt	main_325

main_318:
    lsl	w18,	w25,	#1
    add	w20,	w18,	w25,	lsl #3
    add	w23,	w15,	w20
    sub	w25,	w23,	#48
    bl	getch
    mov	w15,	w0
    b	main_312

main_325:
    movz	w28,	#0
    sub	w24,	w28,	w25
    cmp	w26,	#0
    csel	w23,	w24,	w25,	ne
    cset	w18,	ne
    bl	getch
    movz	w19,	#0
    mov	w13,	w0

main_330:
    cmp	w13,	#48
    blt	main_338

main_334:
    cmp	w13,	#57
    bgt	main_338

main_342:
    movz	w26,	#0

main_343:
    cmp	w13,	#48
    blt	main_356

main_347:
    cmp	w13,	#57
    bgt	main_356

main_349:
    lsl	w28,	w26,	#1
    add	w20,	w28,	w26,	lsl #3
    add	w24,	w13,	w20
    sub	w26,	w24,	#48
    bl	getch
    mov	w13,	w0
    b	main_343

main_356:
    movz	w9,	#0
    sub	w12,	w9,	w26
    cmp	w19,	#0
    lsl	w7,	w23,	#2
    adrp	x18, :got:head
    adrp	x20, :got:next
    adrp	x17, :got:to
    cset	w24,	ne
    lsl	w1,	w21,	#2
    csel	w10,	w12,	w26,	ne
    lsl	w4,	w21,	#2
    ldr	x17, [x17, #:got_lo12:to]
    lsl	w12,	w10,	#2
    adrp	x26, :got:head
    add	x15,	x17,	x1
    str	w10,	[x15]

    adrp	x15, :got:next
    ldr	x20, [x20, #:got_lo12:next]
    ldr	x26, [x26, #:got_lo12:head]
    add	x2,	x20,	x4
    add	x6,	x26,	x7
    adrp	x7, :got:to
    ldr	w28,	[x6]

    str	w28,	[x2]

    str	w21,	[x6]

    ldr	x7, [x7, #:got_lo12:to]
    add	w6,	w21,	#1
    lsl	w9,	w6,	#2
    lsl	w3,	w6,	#2
    add	x5,	x7,	x3
    str	w23,	[x5]

    ldr	x15, [x15, #:got_lo12:next]
    ldr	x18, [x18, #:got_lo12:head]
    add	x21,	x15,	x9
    add	x11,	x18,	x12
    ldr	w19,	[x11]

    str	w19,	[x21]

    add	w21,	w6,	#1
    str	w6,	[x11]


main_370:
    sub	w27,	w27,	#1
    cmp	w27,	#0
    bne	main_211

main_376:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_338:
    cmp	w13,	#45
    movz	w18,	#1
    cset	w24,	eq
    csel	w19,	w18,	w19,	eq
    bl	getch
    mov	w13,	w0
    b	main_330

main_307:
    cmp	w15,	#45
    movz	w24,	#1
    cset	w28,	eq
    csel	w26,	w24,	w26,	eq
    bl	getch
    mov	w15,	w0
    b	main_299

main_41:
    cmp	w28,	#45
    movz	w25,	#1
    cset	w28,	eq
    csel	w21,	w25,	w21,	eq
    bl	getch
    mov	w28,	w0
    b	main_33

main_10:
    cmp	w24,	#45
    movz	w26,	#1
    cset	w19,	eq
    csel	w27,	w26,	w27,	eq
    bl	getch
    mov	w24,	w0
    b	main_2

