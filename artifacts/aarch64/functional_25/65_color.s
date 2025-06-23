.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global dp
.align	2
dp:
    .zero	52907904


.text

.globl dfs
dfs:
dfs_6:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w23,	#9072
    mov	x24,	x0
    mov	w19,	w5
    mov	x25,	x1
    movz	w27,	#55744
    mov	x28,	x2
    mov	w22,	w3
    movz	w26,	#32224
    mov	w20,	w4
    adrp	x21, :got:dp
    lsl	w0,	w19,	#2
    movk	w27,	#44,	lsl #16
    lsl	w6,	w22,	#9
    movk	w26,	#2,	lsl #16
    movz	w4,	#65535
    lsl	w7,	w20,	#5
    ldr	x21, [x21, #:got_lo12:dp]
    movk	w4,	#65535,	lsl #16
    madd	x17,	x24,	x27,	x21

    sub	w21,	w6,	w22,	lsl #3
    madd	x26,	x25,	x26,	x17

    madd	x15,	x28,	x23,	x26

    sub	w26,	w7,	w20,	lsl #2
    add	x17,	x15,	x21
    add	x5,	x17,	x26
    add	x27,	x5,	x0
    ldr	w0,	[x27]

    cmp	w0,	w4
    bne	dfs_90

dfs_15:
    add	w10,	w25,	w24
    add	w11,	w10,	w28
    add	w12,	w11,	w22
    add	w13,	w12,	w20
    cmp	w13,	#0
    beq	dfs_89

dfs_21:
    movz	w21,	#51719
    movk	w21,	#15258,	lsl #16
    cmp	x24,	#0
    beq	dfs_31

dfs_23:
    cmp	w19,	#2
    movz	w5,	#1
    mov	w4,	w20
    mov	w3,	w22
    mov	x1,	x25
    mov	x2,	x28
    sub	w0,	w24,	#1
    cset	w23,	eq
    sub	w23,	w24,	w23
    bl	dfs
    mul	w26,	w0,	w23
    sdiv	w10,	w26,	w21
    msub	w26,	w10,	w21,	w26

    b	dfs_32

dfs_31:
    movz	w26,	#0

dfs_32:
    cmp	x25,	#0
    beq	dfs_46

dfs_35:
    cmp	w19,	#3
    movz	w5,	#2
    mov	x2,	x28
    sub	w1,	w25,	#1
    add	w0,	w24,	#1
    mov	w4,	w20
    cset	w3,	eq
    sub	w23,	w25,	w3
    mov	w3,	w22
    bl	dfs
    madd	w9,	w0,	w23,	w26

    sdiv	w13,	w9,	w21
    msub	w26,	w13,	w21,	w9


dfs_46:
    cmp	x28,	#0
    beq	dfs_60

dfs_49:
    cmp	w19,	#4
    mov	w4,	w20
    mov	w3,	w22
    mov	x0,	x24
    sub	w2,	w28,	#1
    add	w1,	w25,	#1
    cset	w5,	eq
    sub	w23,	w28,	w5
    movz	w5,	#3
    bl	dfs
    madd	w26,	w0,	w23,	w26

    sdiv	w16,	w26,	w21
    msub	w26,	w16,	w21,	w26


dfs_60:
    cmp	w22,	#0
    beq	dfs_74

dfs_63:
    cmp	w19,	#5
    movz	w5,	#4
    mov	w4,	w20
    mov	x1,	x25
    sub	w3,	w22,	#1
    add	w2,	w28,	#1
    mov	x0,	x24
    cset	w23,	eq
    sub	w19,	w22,	w23
    bl	dfs
    madd	w2,	w0,	w19,	w26

    sdiv	w26,	w2,	w21
    msub	w26,	w26,	w21,	w2


dfs_74:
    cmp	w20,	#0
    beq	dfs_85

dfs_77:
    add	w3,	w22,	#1
    sub	w4,	w20,	#1
    mov	x0,	x24
    mov	x1,	x25
    mov	x2,	x28
    movz	w5,	#5
    bl	dfs
    madd	w0,	w0,	w20,	w26

    sdiv	w7,	w0,	w21
    msub	w26,	w7,	w21,	w0


dfs_85:
    sdiv	w1,	w26,	w21
    msub	w0,	w1,	w21,	w26

    str	w0,	[x27]

    b	dfs_90

dfs_89:
    movz	w0,	#1

dfs_90:
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
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#80
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    movz	w10,	#0
    mov	w27,	w0

main_4:
    movz	w7,	#55744
    adrp	x22, :got:dp
    movz	w12,	#0
    movk	w7,	#44,	lsl #16
    ldr	x22, [x22, #:got_lo12:dp]
    mul	x21,	x10,	x7
    madd	x9,	x10,	x7,	x22


main_8:
    movz	w20,	#32224
    movz	w6,	#0
    movk	w20,	#2,	lsl #16
    madd	x15,	x12,	x20,	x9

    mul	x25,	x12,	x20

main_12:
    movz	w5,	#9072
    movz	w19,	#0
    madd	x17,	x6,	x5,	x15

    mul	x8,	x6,	x5

main_16:
    lsl	w1,	w19,	#9
    movz	w24,	#0
    sub	w23,	w1,	w19,	lsl #3
    add	x7,	x17,	x23

main_20:
    lsl	w20,	w24,	#5
    movz	w3,	#65535
    movk	w3,	#65535,	lsl #16
    sub	w25,	w20,	w24,	lsl #2
    add	w24,	w24,	#1
    add	x18,	x7,	x25
    add	x25,	x18,	#24
    add	x14,	x18,	#20
    add	x13,	x18,	#16
    add	x11,	x18,	#12
    add	x8,	x18,	#8
    add	x5,	x18,	#4
    str	w3,	[x18]

    str	w3,	[x5]

    str	w3,	[x8]

    str	w3,	[x11]

    str	w3,	[x13]

    str	w3,	[x14]

    str	w3,	[x25]

    cmp	w24,	#18
    blt	main_20

main_32:
    add	w19,	w19,	#1
    cmp	w19,	#18
    blt	main_16

main_35:
    add	w6,	w6,	#1
    cmp	w6,	#18
    blt	main_12

main_38:
    add	w12,	w12,	#1
    cmp	w12,	#18
    blt	main_8

main_41:
    add	w10,	w10,	#1
    cmp	w10,	#18
    blt	main_4

main_44:
    movz	w21,	#0

main_45:
    cmp	w21,	w27
    bge	main_54

main_48:
    bl	getint
    add	w21,	w21,	#1
    lsl	w17,	w0,	#2
    mov	x6,	x17
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w18,	[x6]

    add	w19,	w18,	#1
    str	w19,	[x6]

    b	main_45

main_54:
    add	x27,	sp,	#20
    add	x25,	sp,	#24
    add	x18,	sp,	#36
    movz	w5,	#0
    ldr	w0,	[x27]

    add	x27,	sp,	#32
    ldr	w1,	[x25]

    add	x25,	sp,	#28
    ldr	w2,	[x25]

    ldr	w3,	[x27]

    ldr	w4,	[x18]

    bl	dfs
    mov	w21,	w0
    mov	w0,	w21
    bl	putint
    mov	w0,	w21
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


