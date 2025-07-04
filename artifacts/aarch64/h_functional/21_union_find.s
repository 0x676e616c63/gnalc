.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global parent
.align	2
parent:
.type parent, %object
    .zero	4020

.data

.text

.globl find
.align 2
.p2align 4,,11
.type find, %function
find:
find_1:
    sub	sp, sp, #48
    stp	x23, x24, [sp, #0]
    stp	x26, x28, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    adrp	x3, :got:parent
    lsl	w24,	w0,	#2
    ldr	x3, [x3, #:got_lo12:parent]
    add	x23,	x3,	x24
    ldr	w26,	[x23]

    cmp	w26,	w0
    beq	find_15

find_5:
    lsl	w0,	w26,	#2
    adrp	x7, :got:parent
    ldr	x7, [x7, #:got_lo12:parent]
    add	x28,	x7,	x0
    ldr	w0,	[x28]

    cmp	w0,	w26
    beq	find_12

find_9:
    bl	find
    mov	w26,	w0
    str	w26,	[x28]


find_12:
    str	w26,	[x23]

    mov	w0,	w26

find_15:
    ldp	x23, x24, [sp, #0]
    ldp	x26, x28, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w19,	w0
    bl	getint
    movz	w12,	#0
    mov	w21,	w0

main_3:
    cmp	w12,	w19
    blt	main_6

main_9:
    movz	w27,	#0
    cmp	w27,	w21
    bge	main_26

main_11:
    movz	w25,	#0

main_13:
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w27,	w0
    mov	w0,	w28
    bl	find
    mov	w20,	w0
    mov	w0,	w27
    bl	find
    cmp	w20,	w0
    beq	main_23

main_20:
    lsl	w5,	w0,	#2
    adrp	x15, :got:parent
    ldr	x15, [x15, #:got_lo12:parent]
    add	x13,	x15,	x5
    str	w20,	[x13]


main_23:
    add	w25,	w25,	#1
    cmp	w25,	w21
    blt	main_13

main_27:
    movz	w14,	#0
    movz	w0,	#0
    b	main_28

main_26:
    movz	w14,	#0
    movz	w0,	#0

main_28:
    cmp	w14,	w19
    blt	main_32

main_39:
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_32:
    lsl	w18,	w14,	#2
    adrp	x13, :got:parent
    add	w22,	w0,	#1
    ldr	x13, [x13, #:got_lo12:parent]
    add	x11,	x13,	x18
    ldr	w20,	[x11]

    cmp	w20,	w14
    add	w14,	w14,	#1
    csel	w0,	w22,	w0,	eq
    cset	w17,	eq
    b	main_28

main_6:
    lsl	w4,	w12,	#2
    adrp	x28, :got:parent
    ldr	x28, [x28, #:got_lo12:parent]
    add	x26,	x28,	x4
    str	w12,	[x26]

    add	w12,	w12,	#1
    b	main_3

