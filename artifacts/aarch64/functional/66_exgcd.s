.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl exgcd
.align 2
.p2align 4,,11
.type exgcd, %function
exgcd:
exgcd_4:
    sub	sp, sp, #80
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x26, x28, [sp, #48]
    stp	fp, lr, [sp, #64]
    
    mov	x23,	x3
    mov	x19,	x2
    mov	w21,	w1
    mov	w26,	w0
    cmp	w21,	#0
    beq	exgcd_6

exgcd_9:
    sdiv	w24,	w26,	w21
    msub	w20,	w24,	w21,	w26

    cmp	w20,	#0
    beq	exgcd_12

exgcd_15:
    sdiv	w3,	w21,	w20
    mov	w0,	w20
    mov	x2,	x19
    msub	w1,	w3,	w20,	w21

    mov	x3,	x23
    bl	exgcd
    sdiv	w18,	w21,	w20
    ldr	w22,	[x19]

    ldr	w16,	[x23]

    str	w16,	[x19]

    ldr	w4,	[x23]

    msub	w6,	w4,	w18,	w22

    str	w6,	[x23]

    b	exgcd_26

exgcd_12:
    movz	w24,	#1
    movz	w22,	#0
    mov	w0,	w21
    str	w24,	[x19]

    str	w22,	[x23]


exgcd_26:
    ldr	w28,	[x19]

    sdiv	w3,	w26,	w21
    ldr	w10,	[x23]

    str	w10,	[x19]

    ldr	w18,	[x23]

    msub	w20,	w18,	w3,	w28

    str	w20,	[x23]

    b	exgcd_36

exgcd_6:
    movz	w16,	#1
    movz	w15,	#0
    mov	w0,	w26
    str	w16,	[x19]

    str	w15,	[x23]


exgcd_36:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x26, x28, [sp, #48]
    ldp	fp, lr, [sp, #64]
    
    add	sp, sp, #80
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #32
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#15
    movz	w0,	#1
    movz	w20,	#1
    add	x26,	sp,	#16
    add	x3,	sp,	#20
    mov	x2,	x26
    str	w20,	[x26]

    str	w0,	[x3]

    movz	w0,	#7
    bl	exgcd
    ldr	w26,	[x26]

    movz	w18,	#15
    movz	w28,	#15
    sdiv	w23,	w26,	w18
    lsl	w19,	w23,	#4
    sub	w22,	w19,	w23,	lsl #0
    sub	w27,	w26,	w22
    add	w19,	w27,	#15
    sdiv	w21,	w19,	w28
    lsl	w20,	w21,	#4
    sub	w20,	w20,	w21,	lsl #0
    sub	w0,	w19,	w20
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #32
    ret


