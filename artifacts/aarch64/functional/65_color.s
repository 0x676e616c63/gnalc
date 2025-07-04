.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global dp
.align	2
dp:
.type dp, %object
    .zero	52907904

.data

.text

.globl dfs
.align 2
.p2align 4,,11
.type dfs, %function
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
    mov	x25,	x0
    mov	x26,	x1
    mov	x22,	x2
    mov	w28,	w3
    mov	w20,	w4
    movz	w24,	#32224
    mov	w19,	w5
    adrp	x21, :got:dp
    movz	w27,	#55744
    lsl	w6,	w28,	#9
    movz	w4,	#65535
    lsl	w7,	w20,	#5
    movk	w24,	#2,	lsl #16
    lsl	w0,	w19,	#2
    ldr	x21, [x21, #:got_lo12:dp]
    movk	w27,	#44,	lsl #16
    movk	w4,	#65535,	lsl #16
    madd	x17,	x25,	x27,	x21

    sub	w21,	w6,	w28,	lsl #3
    madd	x24,	x26,	x24,	x17

    madd	x15,	x22,	x23,	x24

    sub	w24,	w7,	w20,	lsl #2
    add	x17,	x15,	x21
    add	x5,	x17,	x24
    add	x24,	x5,	x0
    ldr	w0,	[x24]

    cmp	w0,	w4
    bne	dfs_90

dfs_15:
    add	w10,	w26,	w25
    add	w11,	w10,	w22
    add	w12,	w11,	w28
    add	w13,	w12,	w20
    cmp	w13,	#0
    bne	dfs_21

dfs_89:
    movz	w0,	#1
    b	dfs_90

dfs_21:
    movz	w21,	#51719
    movk	w21,	#15258,	lsl #16
    cmp	x25,	#0
    bne	dfs_23

dfs_31:
    movz	w27,	#0
    b	dfs_32

dfs_23:
    cmp	w19,	#2
    movz	w5,	#1
    mov	w4,	w20
    mov	w3,	w28
    mov	x2,	x22
    sub	w0,	w25,	#1
    mov	x1,	x26
    cset	w23,	eq
    sub	w23,	w25,	w23
    bl	dfs
    mul	w27,	w0,	w23
    sdiv	w10,	w27,	w21
    msub	w27,	w10,	w21,	w27


dfs_32:
    cmp	x26,	#0
    beq	dfs_46

dfs_35:
    cmp	w19,	#3
    mov	w4,	w20
    mov	x2,	x22
    add	w0,	w25,	#1
    movz	w5,	#2
    sub	w1,	w26,	#1
    cset	w3,	eq
    sub	w23,	w26,	w3
    mov	w3,	w28
    bl	dfs
    madd	w9,	w0,	w23,	w27

    sdiv	w13,	w9,	w21
    msub	w27,	w13,	w21,	w9


dfs_46:
    cmp	x22,	#0
    beq	dfs_60

dfs_49:
    cmp	w19,	#4
    mov	w3,	w28
    mov	x0,	x25
    sub	w2,	w22,	#1
    add	w1,	w26,	#1
    mov	w4,	w20
    cset	w5,	eq
    sub	w23,	w22,	w5
    movz	w5,	#3
    bl	dfs
    madd	w27,	w0,	w23,	w27

    sdiv	w16,	w27,	w21
    msub	w27,	w16,	w21,	w27


dfs_60:
    cmp	w28,	#0
    beq	dfs_74

dfs_63:
    cmp	w19,	#5
    movz	w5,	#4
    mov	x1,	x26
    mov	w4,	w20
    mov	x0,	x25
    sub	w3,	w28,	#1
    add	w2,	w22,	#1
    cset	w23,	eq
    sub	w19,	w28,	w23
    bl	dfs
    madd	w2,	w0,	w19,	w27

    sdiv	w27,	w2,	w21
    msub	w27,	w27,	w21,	w2


dfs_74:
    cmp	w20,	#0
    beq	dfs_85

dfs_77:
    add	w3,	w28,	#1
    sub	w4,	w20,	#1
    mov	x0,	x25
    mov	x1,	x26
    mov	x2,	x22
    movz	w5,	#5
    bl	dfs
    madd	w0,	w0,	w20,	w27

    sdiv	w7,	w0,	w21
    msub	w27,	w7,	w21,	w0


dfs_85:
    sdiv	w1,	w27,	w21
    msub	w0,	w1,	w21,	w27

    str	w0,	[x24]


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
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#80
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    movz	w20,	#0
    mov	w27,	w0

main_4:
    movz	w7,	#55744
    adrp	x22, :got:dp
    movz	w17,	#0
    movk	w7,	#44,	lsl #16
    ldr	x22, [x22, #:got_lo12:dp]
    mul	x21,	x20,	x7
    madd	x9,	x20,	x7,	x22


main_8:
    movz	w19,	#32224
    movz	w6,	#0
    movk	w19,	#2,	lsl #16
    madd	x13,	x17,	x19,	x9

    mul	x25,	x17,	x19

main_12:
    movz	w5,	#9072
    movz	w22,	#0
    madd	x16,	x6,	x5,	x13

    mul	x8,	x6,	x5

main_16:
    lsl	w1,	w22,	#9
    movz	w14,	#0
    sub	w23,	w1,	w22,	lsl #3
    add	x7,	x16,	x23

main_20:
    lsl	w19,	w14,	#5
    movz	w3,	#65535
    movk	w3,	#65535,	lsl #16
    sub	w25,	w19,	w14,	lsl #2
    add	w14,	w14,	#1
    add	x18,	x7,	x25
    add	x25,	x18,	#24
    add	x11,	x18,	#16
    add	x10,	x18,	#12
    add	x8,	x18,	#8
    add	x5,	x18,	#4
    add	x12,	x18,	#20
    str	w3,	[x18]

    str	w3,	[x5]

    str	w3,	[x8]

    str	w3,	[x10]

    str	w3,	[x11]

    str	w3,	[x12]

    str	w3,	[x25]

    cmp	w14,	#18
    blt	main_20

main_32:
    add	w22,	w22,	#1
    cmp	w22,	#18
    blt	main_16

main_35:
    add	w6,	w6,	#1
    cmp	w6,	#18
    blt	main_12

main_38:
    add	w17,	w17,	#1
    cmp	w17,	#18
    blt	main_8

main_41:
    add	w20,	w20,	#1
    cmp	w20,	#18
    blt	main_4

main_44:
    movz	w23,	#0

main_45:
    cmp	w23,	w27
    blt	main_48

main_54:
    add	x21,	sp,	#20
    add	x19,	sp,	#24
    add	x25,	sp,	#36
    movz	w5,	#0
    ldr	w0,	[x21]

    add	x21,	sp,	#32
    ldr	w1,	[x19]

    add	x19,	sp,	#28
    ldr	w2,	[x19]

    ldr	w3,	[x21]

    ldr	w4,	[x25]

    bl	dfs
    mov	w25,	w0
    mov	w0,	w25
    bl	putint
    mov	w0,	w25
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


main_48:
    bl	getint
    add	w23,	w23,	#1
    lsl	w2,	w0,	#2
    mov	x19,	x2
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    ldr	w3,	[x19]

    add	w4,	w3,	#1
    str	w4,	[x19]

    b	main_45

