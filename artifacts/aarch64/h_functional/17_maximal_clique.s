.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global store
.align	2
store:
    .zero	120

.global n
.align	2
n:
    .zero	4

.global graph
.align	2
graph:
    .zero	3600


.text

.globl maxCliques
maxCliques:
maxCliques_1:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    adrp	x13, :got:n
    movz	w27,	#1
    mov	w19,	w0
    ldr	x13, [x13, #:got_lo12:n]
    ldr	w26,	[x13]

    cmp	w27,	w26
    bgt	maxCliques_96

maxCliques_4:
    lsl	w24,	w19,	#2
    adrp	x11, :got:store
    add	w25,	w19,	#1
    adrp	x5, :got:store
    movz	w0,	#0
    movz	w21,	#1
    ldr	x11, [x11, #:got_lo12:store]
    add	w22,	w25,	#1
    lsl	w9,	w25,	#2
    ldr	x5, [x5, #:got_lo12:store]
    add	x28,	x11,	x24
    add	x20,	x5,	x9

maxCliques_10:
    str	w21,	[x28]

    movz	w27,	#1

maxCliques_13:
    cmp	w27,	w25
    bge	maxCliques_34

maxCliques_16:
    add	w5,	w27,	#1
    lsl	w4,	w27,	#2
    adrp	x3, :got:store
    adrp	x8, :got:graph
    ldr	x3, [x3, #:got_lo12:store]
    add	x1,	x3,	x4
    ldr	w7,	[x1]

    ldr	x8, [x8, #:got_lo12:graph]
    lsl	w6,	w7,	#7
    sub	w9,	w6,	w7,	lsl #3
    add	x17,	x8,	x9

maxCliques_22:
    cmp	w5,	w25
    bge	maxCliques_32

maxCliques_25:
    lsl	w13,	w5,	#2
    adrp	x12, :got:store
    add	w5,	w5,	#1
    ldr	x12, [x12, #:got_lo12:store]
    add	x10,	x12,	x13
    ldr	w13,	[x10]

    lsl	w15,	w13,	#2
    add	x14,	x17,	x15
    ldr	w16,	[x14]

    cmp	w16,	#0
    bne	maxCliques_22

maxCliques_35:
    movz	w2,	#0
    b	maxCliques_36

maxCliques_32:
    add	w27,	w27,	#1
    b	maxCliques_13

maxCliques_34:
    movz	w2,	#1

maxCliques_36:
    cmp	w2,	#0
    beq	maxCliques_92

maxCliques_39:
    cmp	w19,	w0
    movz	w14,	#1
    csel	w27,	w19,	w0,	gt
    cmp	w14,	w26
    ble	maxCliques_43

maxCliques_85:
    movz	w16,	#0
    b	maxCliques_87

maxCliques_43:
    movz	w16,	#0
    movz	w23,	#1

maxCliques_45:
    str	w23,	[x20]

    movz	w18,	#1

maxCliques_48:
    cmp	w18,	w22
    bge	maxCliques_69

maxCliques_51:
    add	w24,	w18,	#1
    lsl	w6,	w18,	#2
    adrp	x17, :got:store
    adrp	x3, :got:graph
    ldr	x17, [x17, #:got_lo12:store]
    add	x14,	x17,	x6
    ldr	w9,	[x14]

    ldr	x3, [x3, #:got_lo12:graph]
    lsl	w5,	w9,	#7
    sub	w11,	w5,	w9,	lsl #3
    add	x13,	x3,	x11

maxCliques_57:
    cmp	w24,	w22
    bge	maxCliques_67

maxCliques_60:
    lsl	w15,	w24,	#2
    adrp	x7, :got:store
    add	w24,	w24,	#1
    ldr	x7, [x7, #:got_lo12:store]
    add	x5,	x7,	x15
    ldr	w8,	[x5]

    lsl	w10,	w8,	#2
    add	x9,	x13,	x10
    ldr	w11,	[x9]

    cmp	w11,	#0
    bne	maxCliques_57

maxCliques_70:
    movz	w0,	#0
    b	maxCliques_71

maxCliques_67:
    add	w18,	w18,	#1
    b	maxCliques_48

maxCliques_69:
    movz	w0,	#1

maxCliques_71:
    cmp	w0,	#0
    beq	maxCliques_81

maxCliques_74:
    cmp	w25,	w16
    mov	w0,	w22
    csel	w24,	w25,	w16,	gt
    bl	maxCliques
    cmp	w0,	w24
    csel	w16,	w0,	w24,	gt

maxCliques_81:
    add	w23,	w23,	#1
    cmp	w23,	w26
    ble	maxCliques_45

maxCliques_87:
    cmp	w16,	w27
    csel	w0,	w16,	w27,	gt

maxCliques_92:
    add	w21,	w21,	#1
    cmp	w21,	w26
    ble	maxCliques_10
    b	maxCliques_98

maxCliques_96:
    movz	w0,	#0

maxCliques_98:
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
    movz	fp,	#4816
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    adrp	x21, :got:n
    ldr	x21, [x21, #:got_lo12:n]
    str	w0,	[x21]

    bl	getint
    movz	w23,	#0
    mov	w27,	w0

main_4:
    cmp	w23,	w27
    bge	main_14

main_7:
    lsl	w18,	w23,	#3
    mov	x20,	x18
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    bl	getint
    add	x26,	x20,	#4
    str	w0,	[x20]

    bl	getint
    add	w23,	w23,	#1
    str	w0,	[x26]

    b	main_4

main_14:
    movz	w10,	#0

main_15:
    cmp	w10,	w27
    bge	main_29

main_18:
    lsl	w8,	w10,	#3
    adrp	x16, :got:graph
    adrp	x21, :got:graph
    add	w10,	w10,	#1
    mov	x18,	x8
    movz	w8,	#1
    add	x18,	sp,	x18
    add	x18,	x18,	#16
    add	x12,	x18,	#4
    ldr	w1,	[x18]

    lsl	w23,	w1,	#2
    lsl	w9,	w1,	#7
    ldr	w26,	[x12]

    sub	w3,	w9,	w1,	lsl #3
    lsl	w11,	w26,	#7
    lsl	w18,	w26,	#2
    ldr	x16, [x16, #:got_lo12:graph]
    add	x2,	x16,	x3
    add	x5,	x2,	x18
    str	w8,	[x5]

    movz	w5,	#1
    ldr	x21, [x21, #:got_lo12:graph]
    sub	w8,	w11,	w26,	lsl #3
    add	x7,	x21,	x8
    add	x12,	x7,	x23
    str	w5,	[x12]

    b	main_15

main_29:
    movz	w0,	#1
    bl	maxCliques
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#4816
    add	sp, sp, fp
    ret


