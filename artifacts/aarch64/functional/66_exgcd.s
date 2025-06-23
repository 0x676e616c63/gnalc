.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl exgcd
exgcd:
exgcd_4:
    sub	sp, sp, #96
    stp	x20, x21, [sp, #0]
    stp	x22, x23, [sp, #16]
    stp	x24, x25, [sp, #32]
    stp	x26, x27, [sp, #48]
    stp	x28, fp, [sp, #64]
    str	lr, [sp, 80]

    mov	x28,	x3
    mov	x22,	x2
    mov	w24,	w1
    mov	w23,	w0
    cmp	w24,	#0
    bne	exgcd_9

exgcd_6:
    movz	w18,	#1
    movz	w4,	#0
    str	w18,	[x22]

    str	w4,	[x28]

    b	exgcd_36

exgcd_9:
    sdiv	w26,	w23,	w24
    msub	w21,	w26,	w24,	w23

    cmp	w21,	#0
    bne	exgcd_15

exgcd_12:
    movz	w1,	#1
    movz	w0,	#0
    str	w1,	[x22]

    str	w0,	[x28]

    mov	w0,	w24
    b	exgcd_26

exgcd_15:
    sdiv	w25,	w24,	w21
    mov	w0,	w21
    mov	x2,	x22
    mov	x3,	x28
    msub	w1,	w25,	w21,	w24

    bl	exgcd
    sdiv	w25,	w24,	w21
    ldr	w27,	[x22]

    ldr	w20,	[x28]

    str	w20,	[x22]

    ldr	w8,	[x28]

    msub	w10,	w8,	w25,	w27

    str	w10,	[x28]


exgcd_26:
    ldr	w2,	[x22]

    sdiv	w5,	w23,	w24
    ldr	w12,	[x28]

    mov	w23,	w0
    str	w12,	[x22]

    ldr	w20,	[x28]

    msub	w22,	w20,	w5,	w2

    str	w22,	[x28]


exgcd_36:
    mov	w0,	w23
    ldp	x20, x21, [sp, #0]
    ldp	x22, x23, [sp, #16]
    ldp	x24, x25, [sp, #32]
    ldp	x26, x27, [sp, #48]
    ldp	x28, fp, [sp, #64]
    ldr	lr, [sp, 80]

    add	sp, sp, #96
    ret


.globl main
main:
main_0:
    sub	sp, sp, #32
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#15
    movz	w0,	#1
    add	x3,	sp,	#20
    movz	w20,	#1
    add	x26,	sp,	#16
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


