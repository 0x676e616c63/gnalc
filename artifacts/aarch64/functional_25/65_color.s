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
    
    mov	w19,	w3
    mov	x27,	x2
    movz	w28,	#55744
    mov	w23,	w4
    adrp	x21, :got:dp
    mov	w20,	w5
    mov	x26,	x1
    movz	w22,	#9072
    mov	x24,	x0
    movz	w25,	#32224
    lsl	w6,	w19,	#9
    movk	w28,	#44,	lsl #16
    movz	w4,	#65535
    lsl	w7,	w23,	#5
    ldr	x21, [x21, #:got_lo12:dp]
    lsl	w0,	w20,	#2
    movk	w25,	#2,	lsl #16
    movk	w4,	#65535,	lsl #16
    madd	x17,	x24,	x28,	x21

    sub	w21,	w6,	w19,	lsl #3
    madd	x25,	x26,	x25,	x17

    madd	x15,	x27,	x22,	x25

    sub	w25,	w7,	w23,	lsl #2
    add	x17,	x15,	x21
    add	x5,	x17,	x25
    add	x25,	x5,	x0
    ldr	w0,	[x25]

    cmp	w0,	w4
    bne	dfs_90

dfs_15:
    add	w10,	w26,	w24
    add	w11,	w10,	w27
    add	w12,	w11,	w19
    add	w13,	w12,	w23
    cmp	w13,	#0
    bne	dfs_21

dfs_89:
    movz	w0,	#1
    b	dfs_90

dfs_21:
    movz	w21,	#51719
    movk	w21,	#15258,	lsl #16
    cmp	x24,	#0
    bne	dfs_23

dfs_31:
    movz	w28,	#0
    b	dfs_32

dfs_23:
    cmp	w20,	#2
    mov	w3,	w19
    mov	x2,	x27
    sub	w0,	w24,	#1
    movz	w5,	#1
    mov	w4,	w23
    mov	x1,	x26
    cset	w22,	eq
    sub	w22,	w24,	w22
    bl	dfs
    mul	w28,	w0,	w22
    sdiv	w10,	w28,	w21
    msub	w28,	w10,	w21,	w28


dfs_32:
    cmp	x26,	#0
    beq	dfs_46

dfs_35:
    cmp	w20,	#3
    movz	w5,	#2
    mov	w4,	w23
    mov	x2,	x27
    sub	w1,	w26,	#1
    add	w0,	w24,	#1
    cset	w3,	eq
    sub	w22,	w26,	w3
    mov	w3,	w19
    bl	dfs
    madd	w9,	w0,	w22,	w28

    sdiv	w13,	w9,	w21
    msub	w28,	w13,	w21,	w9


dfs_46:
    cmp	x27,	#0
    beq	dfs_60

dfs_49:
    cmp	w20,	#4
    mov	w4,	w23
    mov	x0,	x24
    mov	w3,	w19
    sub	w2,	w27,	#1
    add	w1,	w26,	#1
    cset	w5,	eq
    sub	w22,	w27,	w5
    movz	w5,	#3
    bl	dfs
    madd	w28,	w0,	w22,	w28

    sdiv	w16,	w28,	w21
    msub	w28,	w16,	w21,	w28


dfs_60:
    cmp	w19,	#0
    beq	dfs_74

dfs_63:
    cmp	w20,	#5
    mov	x1,	x26
    mov	w4,	w23
    mov	x0,	x24
    sub	w3,	w19,	#1
    movz	w5,	#4
    add	w2,	w27,	#1
    cset	w22,	eq
    sub	w20,	w19,	w22
    bl	dfs
    madd	w2,	w0,	w20,	w28

    sdiv	w28,	w2,	w21
    msub	w28,	w28,	w21,	w2


dfs_74:
    cmp	w23,	#0
    beq	dfs_85

dfs_77:
    add	w3,	w19,	#1
    sub	w4,	w23,	#1
    mov	x0,	x24
    mov	x1,	x26
    mov	x2,	x27
    movz	w5,	#5
    bl	dfs
    madd	w0,	w0,	w23,	w28

    sdiv	w7,	w0,	w21
    msub	w28,	w7,	w21,	w0


dfs_85:
    sdiv	w1,	w28,	w21
    msub	w0,	w1,	w21,	w28

    str	w0,	[x25]


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
    add	x8,	x18,	#8
    add	x5,	x18,	#4
    add	x12,	x18,	#20
    add	x10,	x18,	#12
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

