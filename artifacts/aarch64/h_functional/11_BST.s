.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global value
.align	2
value:
    .zero	40000

.global left_child
.align	2
left_child:
    .zero	40000

.global right_child
.align	2
right_child:
    .zero	40000

.global now
.align	2
now:
    .zero	4


.text

.globl insert
insert:
insert_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x22, x23, [sp, #16]
    stp	x24, x25, [sp, #32]
    stp	x26, x27, [sp, #48]
    stp	x28, fp, [sp, #64]
    str	lr, [sp, 80]

    movz	w15,	#65535
    mov	w20,	w0
    movk	w15,	#65535,	lsl #16
    cmp	w20,	w15
    beq	insert_4

insert_11:
    lsl	w9,	w20,	#2
    adrp	x26, :got:value
    ldr	x26, [x26, #:got_lo12:value]
    add	x24,	x26,	x9
    ldr	w27,	[x24]

    cmp	w1,	w27
    ble	insert_19

insert_15:
    lsl	w18,	w20,	#2
    adrp	x23, :got:right_child
    ldr	x23, [x23, #:got_lo12:right_child]
    add	x19,	x23,	x18
    ldr	w0,	[x19]

    bl	insert
    str	w0,	[x19]

    b	insert_23

insert_19:
    lsl	w24,	w20,	#2
    adrp	x28, :got:left_child
    ldr	x28, [x28, #:got_lo12:left_child]
    add	x25,	x28,	x24
    ldr	w0,	[x25]

    bl	insert
    str	w0,	[x25]

    b	insert_23

insert_4:
    adrp	x12, :got:now
    adrp	x16, :got:value
    adrp	x24, :got:left_child
    adrp	x27, :got:right_child
    adrp	x8, :got:now
    ldr	x12, [x12, #:got_lo12:now]
    ldr	w11,	[x12]

    lsl	w20,	w11,	#2
    lsl	w17,	w11,	#2
    ldr	x16, [x16, #:got_lo12:value]
    lsl	w28,	w11,	#2
    add	x13,	x16,	x28
    add	w28,	w11,	#1
    str	w1,	[x13]

    ldr	x24, [x24, #:got_lo12:left_child]
    add	x22,	x24,	x17
    str	w15,	[x22]

    ldr	x27, [x27, #:got_lo12:right_child]
    add	x25,	x27,	x20
    sub	w20,	w28,	#1
    str	w15,	[x25]

    ldr	x8, [x8, #:got_lo12:now]
    str	w28,	[x8]


insert_23:
    mov	w0,	w20
    ldp	x19, x20, [sp, #0]
    ldp	x22, x23, [sp, #16]
    ldp	x24, x25, [sp, #32]
    ldp	x26, x27, [sp, #48]
    ldp	x28, fp, [sp, #64]
    ldr	lr, [sp, 80]

    add	sp, sp, #96
    ret


.globl delete
delete:
delete_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w6,	#65535
    mov	w26,	w0
    movk	w6,	#65535,	lsl #16
    cmp	w26,	w6
    beq	delete_61

delete_4:
    lsl	w24,	w26,	#2
    adrp	x20, :got:value
    ldr	x20, [x20, #:got_lo12:value]
    add	x19,	x20,	x24
    ldr	w27,	[x19]

    cmp	w1,	w27
    bgt	delete_8

delete_12:
    cmp	w1,	w27
    blt	delete_14

delete_18:
    lsl	w2,	w26,	#2
    adrp	x27, :got:left_child
    ldr	x27, [x27, #:got_lo12:left_child]
    add	x24,	x27,	x2
    ldr	w28,	[x24]

    cmp	w28,	w6
    bne	delete_28

delete_22:
    lsl	w14,	w26,	#2
    adrp	x9, :got:right_child
    ldr	x9, [x9, #:got_lo12:right_child]
    add	x7,	x9,	x14
    ldr	w10,	[x7]

    cmp	w10,	w6
    beq	delete_61

delete_28:
    cmp	w28,	w6
    beq	delete_36

delete_30:
    lsl	w21,	w26,	#2
    adrp	x15, :got:right_child
    ldr	x15, [x15, #:got_lo12:right_child]
    add	x23,	x15,	x21
    ldr	w0,	[x23]

    cmp	w0,	w6
    beq	delete_36

delete_41:
    mov	w13,	w0

delete_43:
    cmp	w13,	w6
    beq	delete_50

delete_46:
    lsl	w3,	w13,	#2
    adrp	x21, :got:left_child
    ldr	x21, [x21, #:got_lo12:left_child]
    add	x18,	x21,	x3
    ldr	w24,	[x18]

    cmp	w24,	w6
    beq	delete_52

delete_42:
    mov	w13,	w24
    b	delete_43

delete_50:
    mov	w13,	w6

delete_52:
    lsl	w24,	w13,	#2
    adrp	x25, :got:value
    ldr	x25, [x25, #:got_lo12:value]
    add	x22,	x25,	x24
    ldr	w27,	[x22]

    str	w27,	[x19]

    ldr	w1,	[x22]

    bl	delete
    mov	w6,	w26
    str	w0,	[x23]

    b	delete_61

delete_36:
    cmp	w28,	w6
    bne	delete_60

delete_38:
    lsl	w16,	w26,	#2
    adrp	x24, :got:right_child
    ldr	x24, [x24, #:got_lo12:right_child]
    add	x22,	x24,	x16
    ldr	w6,	[x22]

    b	delete_61

delete_60:
    mov	w6,	w28
    b	delete_61

delete_14:
    lsl	w0,	w26,	#2
    adrp	x25, :got:left_child
    ldr	x25, [x25, #:got_lo12:left_child]
    add	x25,	x25,	x0
    ldr	w0,	[x25]

    bl	delete
    mov	w6,	w26
    str	w0,	[x25]

    b	delete_61

delete_8:
    lsl	w23,	w26,	#2
    adrp	x19, :got:right_child
    ldr	x19, [x19, #:got_lo12:right_child]
    add	x21,	x19,	x23
    ldr	w0,	[x21]

    bl	delete
    mov	w6,	w26
    str	w0,	[x21]


delete_61:
    mov	w0,	w6
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


.globl inorder
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
    movz	w18,	#1
    adrp	x23, :got:value
    adrp	x25, :got:left_child
    movz	w10,	#65535
    adrp	x14, :got:right_child
    movz	w22,	#1
    adrp	x15, :got:now
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
    bge	main_15

main_11:
    bl	getint
    mov	w1,	w0
    movz	w0,	#0
    bl	insert
    add	w22,	w22,	#1
    b	main_8

main_15:
    movz	w0,	#0
    bl	inorder
    movz	w0,	#10
    bl	putch
    bl	getint
    movz	w25,	#0
    movz	w23,	#0
    mov	w20,	w0

main_17:
    cmp	w25,	w20
    bge	main_25

main_21:
    bl	getint
    mov	w1,	w0
    mov	w0,	w23
    bl	delete
    add	w25,	w25,	#1
    mov	w23,	w0
    b	main_17

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


