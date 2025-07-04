.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global value
.align	2
value:
.type value, %object
    .zero	40000

.global left_child
.align	2
left_child:
.type left_child, %object
    .zero	40000

.global right_child
.align	2
right_child:
.type right_child, %object
    .zero	40000

.global now
.align	2
now:
.type now, %object
    .zero	4

.data

.text

.globl insert
.align 2
.p2align 4,,11
.type insert, %function
insert:
insert_2:
    sub	sp, sp, #80
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x25, [sp, #32]
    stp	x26, x28, [sp, #48]
    stp	fp, lr, [sp, #64]
    
    movz	w12,	#65535
    mov	w20,	w0
    movk	w12,	#65535,	lsl #16
    cmp	w20,	w12
    bne	insert_11

insert_4:
    adrp	x25, :got:now
    adrp	x28, :got:value
    adrp	x8, :got:left_child
    adrp	x22, :got:now
    ldr	x25, [x25, #:got_lo12:now]
    ldr	w10,	[x25]

    lsl	w4,	w10,	#2
    ldr	x28, [x28, #:got_lo12:value]
    lsl	w11,	w10,	#2
    add	x26,	x28,	x11
    adrp	x11, :got:right_child
    str	w1,	[x26]

    ldr	x8, [x8, #:got_lo12:left_child]
    lsl	w1,	w10,	#2
    add	x6,	x8,	x1
    str	w12,	[x6]

    ldr	x11, [x11, #:got_lo12:right_child]
    add	x9,	x11,	x4
    str	w12,	[x9]

    ldr	x22, [x22, #:got_lo12:now]
    add	w12,	w10,	#1
    sub	w20,	w12,	#1
    str	w12,	[x22]

    b	insert_23

insert_11:
    lsl	w25,	w20,	#2
    adrp	x12, :got:value
    ldr	x12, [x12, #:got_lo12:value]
    add	x10,	x12,	x25
    ldr	w13,	[x10]

    cmp	w1,	w13
    bgt	insert_15

insert_19:
    lsl	w23,	w20,	#2
    adrp	x26, :got:left_child
    ldr	x26, [x26, #:got_lo12:left_child]
    add	x25,	x26,	x23
    ldr	w0,	[x25]

    bl	insert
    str	w0,	[x25]

    b	insert_23

insert_15:
    lsl	w0,	w20,	#2
    adrp	x19, :got:right_child
    ldr	x19, [x19, #:got_lo12:right_child]
    add	x21,	x19,	x0
    ldr	w0,	[x21]

    bl	insert
    str	w0,	[x21]


insert_23:
    mov	w0,	w20
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x25, [sp, #32]
    ldp	x26, x28, [sp, #48]
    ldp	fp, lr, [sp, #64]
    
    add	sp, sp, #80
    ret


.globl delete
.align 2
.p2align 4,,11
.type delete, %function
delete:
delete_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w8,	#65535
    mov	w19,	w0
    movk	w8,	#65535,	lsl #16
    cmp	w19,	w8
    beq	delete_61

delete_4:
    lsl	w25,	w19,	#2
    adrp	x21, :got:value
    ldr	x21, [x21, #:got_lo12:value]
    add	x21,	x21,	x25
    ldr	w27,	[x21]

    cmp	w1,	w27
    ble	delete_12

delete_8:
    lsl	w24,	w19,	#2
    adrp	x25, :got:right_child
    ldr	x25, [x25, #:got_lo12:right_child]
    add	x28,	x25,	x24
    ldr	w0,	[x28]

    bl	delete
    mov	w8,	w19
    str	w0,	[x28]

    b	delete_61

delete_12:
    cmp	w1,	w27
    bge	delete_18

delete_14:
    lsl	w21,	w19,	#2
    adrp	x20, :got:left_child
    ldr	x20, [x20, #:got_lo12:left_child]
    add	x25,	x20,	x21
    ldr	w0,	[x25]

    bl	delete
    mov	w8,	w19
    str	w0,	[x25]

    b	delete_61

delete_18:
    lsl	w14,	w19,	#2
    adrp	x9, :got:left_child
    ldr	x9, [x9, #:got_lo12:left_child]
    add	x6,	x9,	x14
    ldr	w24,	[x6]

    cmp	w24,	w8
    bne	delete_28

delete_22:
    lsl	w27,	w19,	#2
    adrp	x20, :got:right_child
    ldr	x20, [x20, #:got_lo12:right_child]
    add	x17,	x20,	x27
    ldr	w22,	[x17]

    cmp	w22,	w8
    beq	delete_61

delete_28:
    cmp	w24,	w8
    beq	delete_36

delete_30:
    lsl	w4,	w19,	#2
    adrp	x28, :got:right_child
    ldr	x28, [x28, #:got_lo12:right_child]
    add	x23,	x28,	x4
    ldr	w0,	[x23]

    cmp	w0,	w8
    beq	delete_36

delete_41:
    mov	w12,	w0

delete_43:
    cmp	w12,	w8
    beq	delete_52

delete_46:
    lsl	w16,	w12,	#2
    adrp	x5, :got:left_child
    ldr	x5, [x5, #:got_lo12:left_child]
    add	x3,	x5,	x16
    ldr	w14,	[x3]

    cmp	w14,	w8
    bne	delete_42

delete_51:
    mov	w8,	w12

delete_52:
    lsl	w28,	w8,	#2
    adrp	x27, :got:value
    ldr	x27, [x27, #:got_lo12:value]
    add	x26,	x27,	x28
    ldr	w28,	[x26]

    str	w28,	[x21]

    ldr	w1,	[x26]

    bl	delete
    mov	w8,	w19
    str	w0,	[x23]

    b	delete_61

delete_42:
    mov	w12,	w14
    b	delete_43

delete_36:
    cmp	w24,	w8
    beq	delete_38

delete_60:
    mov	w8,	w24
    b	delete_61

delete_38:
    lsl	w27,	w19,	#2
    adrp	x5, :got:right_child
    ldr	x5, [x5, #:got_lo12:right_child]
    add	x3,	x5,	x27
    ldr	w8,	[x3]


delete_61:
    mov	w0,	w8
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


.globl inorder
.align 2
.p2align 4,,11
.type inorder, %function
inorder:
inorder_1:
    sub	sp, sp, #64
    stp	x19, x23, [sp, #0]
    stp	x24, x26, [sp, #16]
    stp	x28, fp, [sp, #32]
    str	lr, [sp, 48]

    movz	w10,	#65535
    mov	w28,	w0
    movk	w10,	#65535,	lsl #16
    cmp	w28,	w10
    beq	inorder_11

inorder_3:
    lsl	w19,	w28,	#2
    adrp	x26, :got:left_child
    ldr	x26, [x26, #:got_lo12:left_child]
    add	x24,	x26,	x19
    ldr	w0,	[x24]

    bl	inorder
    adrp	x19, :got:value
    lsl	w24,	w28,	#2
    ldr	x19, [x19, #:got_lo12:value]
    add	x0,	x19,	x24
    ldr	w0,	[x0]

    bl	putint
    movz	w0,	#32
    bl	putch
    adrp	x18, :got:right_child
    lsl	w23,	w28,	#2
    ldr	x18, [x18, #:got_lo12:right_child]
    add	x28,	x18,	x23
    ldr	w0,	[x28]

    bl	inorder

inorder_11:
    ldp	x19, x23, [sp, #0]
    ldp	x24, x26, [sp, #16]
    ldp	x28, fp, [sp, #32]
    ldr	lr, [sp, 48]

    add	sp, sp, #64
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w18,	#0
    adrp	x25, :got:now
    ldr	x25, [x25, #:got_lo12:now]
    str	w18,	[x25]

    bl	getint
    mov	w27,	w0
    cmp	w27,	#0
    beq	main_27

main_3:
    bl	getint
    movz	w22,	#1
    adrp	x25, :got:left_child
    movz	w18,	#1
    adrp	x23, :got:value
    adrp	x15, :got:now
    movz	w10,	#65535
    adrp	x14, :got:right_child
    ldr	x23, [x23, #:got_lo12:value]
    movk	w10,	#65535,	lsl #16
    str	w0,	[x23]

    ldr	x25, [x25, #:got_lo12:left_child]
    str	w10,	[x25]

    ldr	x14, [x14, #:got_lo12:right_child]
    str	w10,	[x14]

    ldr	x15, [x15, #:got_lo12:now]
    str	w18,	[x15]


main_8:
    cmp	w22,	w27
    blt	main_11

main_15:
    movz	w0,	#0
    bl	inorder
    movz	w0,	#10
    bl	putch
    bl	getint
    movz	w25,	#0
    movz	w23,	#0
    mov	w27,	w0

main_17:
    cmp	w25,	w27
    blt	main_21

main_25:
    mov	w0,	w23
    bl	inorder
    movz	w0,	#10
    bl	putch

main_27:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_21:
    bl	getint
    mov	w1,	w0
    mov	w0,	w23
    bl	delete
    add	w25,	w25,	#1
    mov	w23,	w0
    b	main_17

main_11:
    bl	getint
    mov	w1,	w0
    movz	w0,	#0
    bl	insert
    add	w22,	w22,	#1
    b	main_8

