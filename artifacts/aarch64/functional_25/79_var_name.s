.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

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
    movz	w23,	#2
    movz	w6,	#2
    movz	w21,	#0
    add	x4,	sp,	#20
    movz	w7,	#1
    add	x3,	sp,	#16
    str	w7,	[x3]

    str	w6,	[x4]


main_5:
    cmp	w23,	#18
    blt	main_9

main_108:
    lsl	w18,	w23,	#2
    sub	w22,	w23,	#1
    sub	w28,	w23,	#2
    mov	x18,	x18
    add	x18,	sp,	x18
    lsl	w25,	w22,	#2
    lsl	w19,	w28,	#2
    mov	x24,	x25
    add	x18,	x18,	#16
    mov	x0,	x19
    add	x24,	sp,	x24
    add	x0,	sp,	x0
    ldr	w20,	[x18]

    add	x24,	x24,	#16
    add	x0,	x0,	#16
    ldr	w26,	[x24]

    add	w25,	w26,	w20
    ldr	w20,	[x0]

    add	w0,	w25,	w20
    add	w21,	w0,	w21
    str	w0,	[x18]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w23,	#1
    cmp	w23,	#20
    blt	main_108

main_124:
    mov	w0,	w21
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


main_9:
    lsl	w26,	w23,	#2
    sub	w18,	w23,	#1
    sub	w25,	w23,	#2
    mov	x27,	x26
    add	x27,	sp,	x27
    lsl	w20,	w18,	#2
    lsl	w28,	w25,	#2
    mov	x19,	x20
    add	x27,	x27,	#16
    add	x19,	sp,	x19
    ldr	w26,	[x27]

    add	x19,	x19,	#16
    ldr	w22,	[x19]

    add	w22,	w22,	w26
    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w0,	[x26]

    add	w0,	w22,	w0
    str	w0,	[x27]

    add	w21,	w0,	w21
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w19,	w23,	#1
    lsl	w20,	w19,	#2
    sub	w27,	w19,	#1
    sub	w22,	w19,	#2
    mov	x24,	x20
    add	x24,	sp,	x24
    lsl	w0,	w27,	#2
    mov	x28,	x0
    add	x24,	x24,	#16
    add	x28,	sp,	x28
    ldr	w25,	[x24]

    add	x28,	x28,	#16
    ldr	w18,	[x28]

    add	w27,	w18,	w25
    lsl	w25,	w22,	#2
    mov	x23,	x25
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w26,	[x23]

    add	w0,	w27,	w26
    str	w0,	[x24]

    add	w23,	w0,	w21
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w27,	w19,	#1
    lsl	w25,	w27,	#2
    sub	w22,	w27,	#1
    sub	w0,	w27,	#2
    mov	x19,	x25
    add	x19,	sp,	x19
    lsl	w25,	w22,	#2
    lsl	w20,	w0,	#2
    mov	x24,	x25
    add	x19,	x19,	#16
    mov	x18,	x20
    add	x24,	sp,	x24
    add	x18,	sp,	x18
    ldr	w21,	[x19]

    add	x24,	x24,	#16
    add	x18,	x18,	#16
    ldr	w26,	[x24]

    add	w26,	w26,	w21
    ldr	w21,	[x18]

    add	w0,	w26,	w21
    str	w0,	[x19]

    add	w28,	w0,	w23
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w26,	w27,	#1
    lsl	w19,	w26,	#2
    sub	w18,	w26,	#1
    sub	w23,	w26,	#2
    mov	x25,	x19
    add	x25,	sp,	x25
    lsl	w20,	w18,	#2
    lsl	w27,	w23,	#2
    mov	x19,	x20
    add	x25,	x25,	#16
    add	x19,	sp,	x19
    ldr	w24,	[x25]

    add	x19,	x19,	#16
    ldr	w21,	[x19]

    add	w21,	w21,	w24
    mov	x24,	x27
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w0,	[x24]

    add	w0,	w21,	w0
    str	w0,	[x25]

    add	w23,	w0,	w28
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w25,	w26,	#1
    lsl	w26,	w25,	#2
    sub	w27,	w25,	#1
    sub	w20,	w25,	#2
    mov	x22,	x26
    add	x22,	sp,	x22
    lsl	w0,	w27,	#2
    mov	x28,	x0
    add	x22,	x22,	#16
    add	x28,	sp,	x28
    ldr	w24,	[x22]

    add	x28,	x28,	#16
    ldr	w18,	[x28]

    add	w27,	w18,	w24
    lsl	w24,	w20,	#2
    mov	x21,	x24
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    ldr	w26,	[x21]

    add	w0,	w27,	w26
    str	w0,	[x22]

    add	w28,	w0,	w23
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w24,	w25,	#1
    sub	w22,	w24,	#1
    sub	w0,	w24,	#2
    lsl	w19,	w24,	#2
    mov	x19,	x19
    lsl	w25,	w22,	#2
    lsl	w20,	w0,	#2
    add	x19,	sp,	x19
    mov	x23,	x25
    mov	x18,	x20
    add	x23,	sp,	x23
    add	x18,	sp,	x18
    add	x19,	x19,	#16
    add	x23,	x23,	#16
    add	x18,	x18,	#16
    ldr	w21,	[x19]

    ldr	w26,	[x23]

    add	w26,	w26,	w21
    ldr	w21,	[x18]

    add	w0,	w26,	w21
    add	w23,	w0,	w28
    str	w0,	[x19]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w22,	w24,	#1
    sub	w25,	w22,	#2
    sub	w18,	w22,	#1
    lsl	w26,	w22,	#2
    mov	x27,	x26
    lsl	w28,	w25,	#2
    lsl	w20,	w18,	#2
    add	x27,	sp,	x27
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x27,	x27,	#16
    add	x19,	x19,	#16
    ldr	w26,	[x27]

    ldr	w21,	[x19]

    add	w21,	w21,	w26
    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w0,	[x26]

    add	w0,	w21,	w0
    add	w28,	w0,	w23
    str	w0,	[x27]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w22,	w22,	#1
    sub	w20,	w22,	#2
    sub	w26,	w22,	#1
    lsl	w19,	w22,	#2
    mov	x23,	x19
    lsl	w0,	w26,	#2
    add	x23,	sp,	x23
    mov	x27,	x0
    add	x27,	sp,	x27
    add	x23,	x23,	#16
    add	x27,	x27,	#16
    ldr	w24,	[x23]

    ldr	w18,	[x27]

    add	w26,	w18,	w24
    lsl	w24,	w20,	#2
    mov	x21,	x24
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    ldr	w25,	[x21]

    add	w0,	w26,	w25
    add	w21,	w0,	w28
    str	w0,	[x23]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w22,	#1
    b	main_5

