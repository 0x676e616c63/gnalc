.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global array
.align	2
array:
.type array, %object
    .zero	4000

.data

.text

.globl findSmallest
.align 2
.p2align 4,,11
.type findSmallest, %function
findSmallest:
findSmallest_4:
    sub	sp, sp, #96
    stp	x20, x21, [sp, #0]
    stp	x22, x23, [sp, #16]
    stp	x24, x25, [sp, #32]
    stp	x26, x27, [sp, #48]
    stp	x28, fp, [sp, #64]
    str	lr, [sp, 80]

    cmp	w0,	w1
    beq	findSmallest_51

findSmallest_6:
    lsl	w25,	w1,	#2
    adrp	x22, :got:array
    ldr	x22, [x22, #:got_lo12:array]
    add	x11,	x22,	x25
    ldr	w25,	[x11]

    cmp	w0,	w1
    bge	findSmallest_27

findSmallest_10:
    mov	w22,	w0
    mov	w14,	w0

findSmallest_12:
    lsl	w28,	w14,	#2
    adrp	x21, :got:array
    ldr	x21, [x21, #:got_lo12:array]
    add	x12,	x21,	x28
    ldr	w16,	[x12]

    cmp	w16,	w25
    bgt	findSmallest_23

findSmallest_18:
    lsl	w8,	w22,	#2
    adrp	x27, :got:array
    add	w22,	w22,	#1
    ldr	x27, [x27, #:got_lo12:array]
    add	x7,	x27,	x8
    ldr	w28,	[x7]

    str	w28,	[x12]

    str	w16,	[x7]


findSmallest_23:
    add	w14,	w14,	#1
    cmp	w14,	w1
    blt	findSmallest_12
    b	findSmallest_29

findSmallest_27:
    mov	w22,	w0

findSmallest_29:
    lsl	w8,	w22,	#2
    adrp	x18, :got:array
    ldr	x18, [x18, #:got_lo12:array]
    add	x15,	x18,	x8
    ldr	w10,	[x15]

    ldr	w20,	[x11]

    str	w20,	[x15]

    str	w10,	[x11]

    cmp	w2,	w22
    bne	findSmallest_43

findSmallest_35:
    movz	w24,	#0

findSmallest_36:
    cmp	w24,	w22
    bge	findSmallest_51

findSmallest_39:
    lsl	w28,	w24,	#2
    adrp	x26, :got:array
    ldr	x26, [x26, #:got_lo12:array]
    add	x23,	x26,	x28
    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	w24,	w24,	#1
    b	findSmallest_36

findSmallest_43:
    cmp	w2,	w22
    blt	findSmallest_45

findSmallest_47:
    add	w0,	w22,	#1
    bl	findSmallest
    b	findSmallest_51

findSmallest_45:
    sub	w1,	w22,	#1
    bl	findSmallest

findSmallest_51:
    ldp	x20, x21, [sp, #0]
    ldp	x22, x23, [sp, #16]
    ldp	x24, x25, [sp, #32]
    ldp	x26, x27, [sp, #48]
    ldp	x28, fp, [sp, #64]
    ldr	lr, [sp, 80]

    add	sp, sp, #96
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
    mov	w24,	w0
    bl	getint
    movz	w22,	#0
    mov	w28,	w0

main_3:
    cmp	w22,	w24
    blt	main_6

main_10:
    sub	w1,	w24,	#1
    movz	w0,	#0
    mov	w2,	w28
    mov	w3,	w24
    bl	findSmallest
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_6:
    lsl	w23,	w22,	#2
    adrp	x20, :got:array
    ldr	x20, [x20, #:got_lo12:array]
    add	x21,	x20,	x23
    bl	getint
    add	w22,	w22,	#1
    str	w0,	[x21]

    b	main_3

