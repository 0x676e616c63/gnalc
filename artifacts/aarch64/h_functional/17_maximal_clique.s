.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global store
.align	2
store:
.type store, %object
    .zero	120

.global n
.align	2
n:
.type n, %object
    .zero	4

.global graph
.align	2
graph:
.type graph, %object
    .zero	3600

.data

.text

.globl maxCliques
.align 2
.p2align 4,,11
.type maxCliques, %function
maxCliques:
maxCliques_1:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w25,	#1
    adrp	x13, :got:n
    mov	w28,	w0
    ldr	x13, [x13, #:got_lo12:n]
    ldr	w26,	[x13]

    cmp	w25,	w26
    ble	maxCliques_4

maxCliques_96:
    movz	w0,	#0
    b	maxCliques_98

maxCliques_4:
    lsl	w23,	w28,	#2
    adrp	x11, :got:store
    add	w25,	w28,	#1
    adrp	x5, :got:store
    movz	w0,	#0
    movz	w21,	#1
    ldr	x11, [x11, #:got_lo12:store]
    add	w22,	w25,	#1
    lsl	w9,	w25,	#2
    ldr	x5, [x5, #:got_lo12:store]
    add	x24,	x11,	x23
    add	x27,	x5,	x9

maxCliques_10:
    str	w21,	[x24]

    movz	w5,	#1

maxCliques_13:
    cmp	w5,	w25
    blt	maxCliques_16

maxCliques_34:
    movz	w2,	#1
    b	maxCliques_36

maxCliques_16:
    add	w1,	w5,	#1
    lsl	w6,	w5,	#2
    adrp	x4, :got:store
    adrp	x9, :got:graph
    ldr	x4, [x4, #:got_lo12:store]
    add	x2,	x4,	x6
    ldr	w8,	[x2]

    ldr	x9, [x9, #:got_lo12:graph]
    lsl	w7,	w8,	#7
    sub	w10,	w7,	w8,	lsl #3
    add	x13,	x9,	x10

maxCliques_22:
    cmp	w1,	w25
    blt	maxCliques_25

maxCliques_32:
    add	w5,	w5,	#1
    b	maxCliques_13

maxCliques_25:
    lsl	w15,	w1,	#2
    adrp	x14, :got:store
    add	w1,	w1,	#1
    ldr	x14, [x14, #:got_lo12:store]
    add	x12,	x14,	x15
    ldr	w15,	[x12]

    lsl	w17,	w15,	#2
    add	x16,	x13,	x17
    ldr	w18,	[x16]

    cmp	w18,	#0
    bne	maxCliques_22

maxCliques_35:
    movz	w2,	#0

maxCliques_36:
    cmp	w2,	#0
    beq	maxCliques_92

maxCliques_39:
    cmp	w28,	w0
    movz	w14,	#1
    csel	w19,	w28,	w0,	gt
    cmp	w14,	w26
    bgt	maxCliques_85

maxCliques_43:
    movz	w16,	#0
    movz	w23,	#1

maxCliques_45:
    str	w23,	[x27]

    movz	w18,	#1

maxCliques_48:
    cmp	w18,	w22
    blt	maxCliques_51

maxCliques_69:
    movz	w0,	#1
    b	maxCliques_71

maxCliques_51:
    add	w9,	w18,	#1
    lsl	w6,	w18,	#2
    adrp	x20, :got:store
    adrp	x3, :got:graph
    ldr	x20, [x20, #:got_lo12:store]
    add	x15,	x20,	x6
    ldr	w10,	[x15]

    ldr	x3, [x3, #:got_lo12:graph]
    lsl	w5,	w10,	#7
    sub	w12,	w5,	w10,	lsl #3
    add	x14,	x3,	x12

maxCliques_57:
    cmp	w9,	w22
    blt	maxCliques_60

maxCliques_67:
    add	w18,	w18,	#1
    b	maxCliques_48

maxCliques_60:
    lsl	w20,	w9,	#2
    adrp	x8, :got:store
    add	w9,	w9,	#1
    ldr	x8, [x8, #:got_lo12:store]
    add	x6,	x8,	x20
    ldr	w10,	[x6]

    lsl	w12,	w10,	#2
    add	x11,	x14,	x12
    ldr	w13,	[x11]

    cmp	w13,	#0
    bne	maxCliques_57

maxCliques_70:
    movz	w0,	#0

maxCliques_71:
    cmp	w0,	#0
    beq	maxCliques_81

maxCliques_74:
    cmp	w25,	w16
    mov	w0,	w22
    csel	w20,	w25,	w16,	gt
    bl	maxCliques
    cmp	w0,	w20
    csel	w16,	w0,	w20,	gt

maxCliques_81:
    add	w23,	w23,	#1
    cmp	w23,	w26
    ble	maxCliques_45
    b	maxCliques_87

maxCliques_85:
    movz	w16,	#0

maxCliques_87:
    cmp	w16,	w19
    csel	w0,	w16,	w19,	gt

maxCliques_92:
    add	w21,	w21,	#1
    cmp	w21,	w26
    ble	maxCliques_10

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
.align 2
.p2align 4,,11
.type main, %function
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
    movz	w21,	#0
    mov	w19,	w0

main_4:
    cmp	w21,	w19
    blt	main_7

main_14:
    movz	w17,	#0

main_15:
    cmp	w17,	w19
    blt	main_18

main_29:
    movz	w0,	#1
    bl	maxCliques
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#4816
    add	sp, sp, fp
    ret


main_18:
    lsl	w2,	w17,	#3
    adrp	x14, :got:graph
    add	w17,	w17,	#1
    mov	x12,	x2
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    add	x5,	x12,	#4
    ldr	w27,	[x12]

    lsl	w16,	w27,	#2
    lsl	w9,	w27,	#7
    ldr	w12,	[x5]

    sub	w26,	w9,	w27,	lsl #3
    lsl	w10,	w12,	#7
    lsl	w11,	w12,	#2
    adrp	x9, :got:graph
    sub	w2,	w10,	w12,	lsl #3
    ldr	x9, [x9, #:got_lo12:graph]
    add	x25,	x9,	x26
    movz	w9,	#1
    add	x28,	x25,	x11
    str	w9,	[x28]

    ldr	x14, [x14, #:got_lo12:graph]
    add	x1,	x14,	x2
    movz	w2,	#1
    add	x5,	x1,	x16
    str	w2,	[x5]

    b	main_15

main_7:
    lsl	w20,	w21,	#3
    mov	x20,	x20
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    bl	getint
    add	x22,	x20,	#4
    str	w0,	[x20]

    bl	getint
    add	w21,	w21,	#1
    str	w0,	[x22]

    b	main_4

