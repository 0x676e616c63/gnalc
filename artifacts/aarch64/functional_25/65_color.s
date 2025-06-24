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
    
    movz	w21,	#9072
    mov	x28,	x0
    mov	x27,	x2
    movz	w23,	#32224
    mov	w19,	w3
    mov	w24,	w4
    mov	w25,	w5
    movz	w26,	#55744
    adrp	x20, :got:dp
    mov	x22,	x1
    movk	w23,	#2,	lsl #16
    lsl	w6,	w19,	#9
    movz	w4,	#65535
    lsl	w7,	w24,	#5
    lsl	w0,	w25,	#2
    movk	w26,	#44,	lsl #16
    ldr	x20, [x20, #:got_lo12:dp]
    movk	w4,	#65535,	lsl #16
    madd	x17,	x28,	x26,	x20

    sub	w20,	w6,	w19,	lsl #3
    madd	x23,	x22,	x23,	x17

    madd	x15,	x27,	x21,	x23

    sub	w23,	w7,	w24,	lsl #2
    add	x17,	x15,	x20
    add	x5,	x17,	x23
    add	x23,	x5,	x0
    ldr	w0,	[x23]

    cmp	w0,	w4
    bne	dfs_90

dfs_15:
    add	w10,	w22,	w28
    add	w11,	w10,	w27
    add	w12,	w11,	w19
    add	w13,	w12,	w24
    cmp	w13,	#0
    beq	dfs_89

dfs_21:
    movz	w21,	#51719
    movk	w21,	#15258,	lsl #16
    cmp	x28,	#0
    beq	dfs_31

dfs_23:
    cmp	w25,	#2
    movz	w5,	#1
    mov	w4,	w24
    mov	w3,	w19
    mov	x2,	x27
    mov	x1,	x22
    sub	w0,	w28,	#1
    cset	w20,	eq
    sub	w20,	w28,	w20
    bl	dfs
    mul	w26,	w0,	w20
    sdiv	w10,	w26,	w21
    msub	w26,	w10,	w21,	w26

    b	dfs_32

dfs_31:
    movz	w26,	#0

dfs_32:
    cmp	x22,	#0
    beq	dfs_46

dfs_35:
    cmp	w25,	#3
    movz	w5,	#2
    mov	w4,	w24
    sub	w1,	w22,	#1
    mov	x2,	x27
    add	w0,	w28,	#1
    cset	w3,	eq
    sub	w20,	w22,	w3
    mov	w3,	w19
    bl	dfs
    madd	w9,	w0,	w20,	w26

    sdiv	w13,	w9,	w21
    msub	w26,	w13,	w21,	w9


dfs_46:
    cmp	x27,	#0
    beq	dfs_60

dfs_49:
    cmp	w25,	#4
    mov	w4,	w24
    mov	w3,	w19
    sub	w2,	w27,	#1
    add	w1,	w22,	#1
    mov	x0,	x28
    cset	w5,	eq
    sub	w20,	w27,	w5
    movz	w5,	#3
    bl	dfs
    madd	w26,	w0,	w20,	w26

    sdiv	w16,	w26,	w21
    msub	w26,	w16,	w21,	w26


dfs_60:
    cmp	w19,	#0
    beq	dfs_74

dfs_63:
    cmp	w25,	#5
    mov	w4,	w24
    mov	x1,	x22
    mov	x0,	x28
    sub	w3,	w19,	#1
    movz	w5,	#4
    add	w2,	w27,	#1
    cset	w25,	eq
    sub	w20,	w19,	w25
    bl	dfs
    madd	w2,	w0,	w20,	w26

    sdiv	w26,	w2,	w21
    msub	w26,	w26,	w21,	w2


dfs_74:
    cmp	w24,	#0
    beq	dfs_85

dfs_77:
    add	w3,	w19,	#1
    sub	w4,	w24,	#1
    mov	x0,	x28
    mov	x1,	x22
    mov	x2,	x27
    movz	w5,	#5
    bl	dfs
    madd	w0,	w0,	w24,	w26

    sdiv	w7,	w0,	w21
    msub	w26,	w7,	w21,	w0


dfs_85:
    sdiv	w1,	w26,	w21
    msub	w0,	w1,	w21,	w26

    str	w0,	[x23]

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
    add	x14,	x18,	#20
    add	x13,	x18,	#16
    add	x8,	x18,	#8
    add	x25,	x18,	#24
    add	x11,	x18,	#12
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


