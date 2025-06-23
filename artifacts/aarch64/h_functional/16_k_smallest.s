.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global array
.align	2
array:
    .zero	4000


.text

.globl findSmallest
findSmallest:
findSmallest_4:
    sub	sp, sp, #80
    stp	x20, x21, [sp, #0]
    stp	x22, x24, [sp, #16]
    stp	x25, x27, [sp, #32]
    stp	x28, fp, [sp, #48]
    str	lr, [sp, 64]

    cmp	w0,	w1
    beq	findSmallest_51

findSmallest_6:
    lsl	w25,	w1,	#2
    adrp	x22, :got:array
    ldr	x22, [x22, #:got_lo12:array]
    add	x11,	x22,	x25
    ldr	w25,	[x11]

    cmp	w0,	w1
    blt	findSmallest_10

findSmallest_27:
    mov	w22,	w0
    b	findSmallest_29

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
    beq	findSmallest_35

findSmallest_43:
    cmp	w2,	w22
    bge	findSmallest_47

findSmallest_45:
    sub	w1,	w22,	#1
    bl	findSmallest
    b	findSmallest_51

findSmallest_47:
    add	w0,	w22,	#1
    bl	findSmallest
    b	findSmallest_51

findSmallest_35:
    movz	w24,	#0

findSmallest_36:
    cmp	w24,	w22
    bge	findSmallest_51

findSmallest_39:
    lsl	w20,	w24,	#2
    adrp	x0, :got:array
    ldr	x0, [x0, #:got_lo12:array]
    add	x27,	x0,	x20
    ldr	w0,	[x27]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	w24,	w24,	#1
    b	findSmallest_36

findSmallest_51:
    ldp	x20, x21, [sp, #0]
    ldp	x22, x24, [sp, #16]
    ldp	x25, x27, [sp, #32]
    ldp	x28, fp, [sp, #48]
    ldr	lr, [sp, 64]

    add	sp, sp, #80
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w27,	w0
    bl	getint
    movz	w22,	#0
    mov	w24,	w0

main_3:
    cmp	w22,	w27
    bge	main_10

main_6:
    lsl	w21,	w22,	#2
    adrp	x19, :got:array
    ldr	x19, [x19, #:got_lo12:array]
    add	x20,	x19,	x21
    bl	getint
    add	w22,	w22,	#1
    str	w0,	[x20]

    b	main_3

main_10:
    sub	w1,	w27,	#1
    movz	w0,	#0
    mov	w2,	w24
    mov	w3,	w27
    bl	findSmallest
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


