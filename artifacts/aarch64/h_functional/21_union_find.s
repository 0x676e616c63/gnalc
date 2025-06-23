.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global parent
.align	2
parent:
    .zero	4020


.text

.globl find
find:
find_1:
    sub	sp, sp, #48
    stp	x22, x24, [sp, #0]
    stp	x28, fp, [sp, #16]
    str	lr, [sp, 32]

    adrp	x3, :got:parent
    lsl	w24,	w0,	#2
    ldr	x3, [x3, #:got_lo12:parent]
    add	x22,	x3,	x24
    ldr	w4,	[x22]

    cmp	w4,	w0
    beq	find_15

find_5:
    lsl	w0,	w4,	#2
    adrp	x8, :got:parent
    ldr	x8, [x8, #:got_lo12:parent]
    add	x28,	x8,	x0
    ldr	w0,	[x28]

    cmp	w0,	w4
    beq	find_11

find_9:
    bl	find
    str	w0,	[x28]

    b	find_12

find_11:
    mov	w0,	w4

find_12:
    str	w0,	[x22]


find_15:
    ldp	x22, x24, [sp, #0]
    ldp	x28, fp, [sp, #16]
    ldr	lr, [sp, 32]

    add	sp, sp, #48
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w20,	w0
    bl	getint
    movz	w18,	#0
    mov	w19,	w0

main_3:
    cmp	w18,	w20
    bge	main_9

main_6:
    lsl	w9,	w18,	#2
    adrp	x5, :got:parent
    ldr	x5, [x5, #:got_lo12:parent]
    add	x3,	x5,	x9
    str	w18,	[x3]

    add	w18,	w18,	#1
    b	main_3

main_9:
    movz	w13,	#0
    cmp	w13,	w19
    blt	main_11

main_26:
    movz	w14,	#0
    movz	w0,	#0
    b	main_28

main_11:
    movz	w25,	#0

main_13:
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w23,	w0
    mov	w0,	w28
    bl	find
    mov	w26,	w0
    mov	w0,	w23
    bl	find
    cmp	w26,	w0
    beq	main_23

main_20:
    lsl	w9,	w0,	#2
    adrp	x21, :got:parent
    ldr	x21, [x21, #:got_lo12:parent]
    add	x17,	x21,	x9
    str	w26,	[x17]


main_23:
    add	w25,	w25,	#1
    cmp	w25,	w19
    blt	main_13

main_27:
    movz	w14,	#0
    movz	w0,	#0

main_28:
    cmp	w14,	w20
    bge	main_39

main_32:
    lsl	w23,	w14,	#2
    adrp	x18, :got:parent
    add	w26,	w0,	#1
    ldr	x18, [x18, #:got_lo12:parent]
    add	x16,	x18,	x23
    ldr	w24,	[x16]

    cmp	w24,	w14
    add	w14,	w14,	#1
    csel	w0,	w26,	w0,	eq
    cset	w22,	eq
    b	main_28

main_39:
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


