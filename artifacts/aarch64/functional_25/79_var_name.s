.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#80
    add	x0,	sp,	#16
    bl	memset
    movz	w23,	#2
    add	x4,	sp,	#20
    movz	w22,	#0
    movz	w6,	#2
    movz	w7,	#1
    add	x3,	sp,	#16
    str	w7,	[x3]

    str	w6,	[x4]


main_5:
    cmp	w23,	#18
    bge	main_108

main_9:
    lsl	w18,	w23,	#2
    sub	w21,	w23,	#1
    sub	w28,	w23,	#2
    mov	x18,	x18
    add	x18,	sp,	x18
    lsl	w25,	w21,	#2
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
    str	w0,	[x18]

    add	w24,	w0,	w22
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w19,	w23,	#1
    sub	w0,	w19,	#1
    lsl	w25,	w19,	#2
    sub	w23,	w19,	#2
    mov	x26,	x25
    add	x26,	sp,	x26
    lsl	w20,	w0,	#2
    lsl	w27,	w23,	#2
    mov	x18,	x20
    add	x26,	x26,	#16
    add	x18,	sp,	x18
    ldr	w25,	[x26]

    add	x18,	x18,	#16
    ldr	w21,	[x18]

    add	w20,	w21,	w25
    mov	x25,	x27
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w28,	[x25]

    add	w0,	w20,	w28
    str	w0,	[x26]

    add	w27,	w0,	w24
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w28,	w19,	#1
    lsl	w18,	w28,	#2
    sub	w24,	w28,	#1
    sub	w19,	w28,	#2
    mov	x21,	x18
    add	x21,	sp,	x21
    lsl	w26,	w24,	#2
    lsl	w22,	w19,	#2
    mov	x25,	x26
    add	x21,	x21,	#16
    add	x25,	sp,	x25
    ldr	w20,	[x21]

    add	x25,	x25,	#16
    ldr	w0,	[x25]

    add	w24,	w0,	w20
    mov	x20,	x22
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w23,	[x20]

    add	w0,	w24,	w23
    add	w22,	w0,	w27
    str	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w26,	w28,	#1
    lsl	w24,	w26,	#2
    sub	w21,	w26,	#1
    sub	w28,	w26,	#2
    mov	x18,	x24
    add	x18,	sp,	x18
    lsl	w24,	w21,	#2
    lsl	w19,	w28,	#2
    mov	x23,	x24
    add	x18,	x18,	#16
    mov	x0,	x19
    add	x23,	sp,	x23
    add	x0,	sp,	x0
    ldr	w20,	[x18]

    add	x23,	x23,	#16
    add	x0,	x0,	#16
    ldr	w25,	[x23]

    add	w24,	w25,	w20
    ldr	w20,	[x0]

    add	w0,	w24,	w20
    str	w0,	[x18]

    add	w27,	w0,	w22
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w25,	w26,	#1
    sub	w22,	w25,	#2
    sub	w0,	w25,	#1
    lsl	w18,	w25,	#2
    mov	x24,	x18
    lsl	w26,	w22,	#2
    lsl	w19,	w0,	#2
    add	x24,	sp,	x24
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x24,	x24,	#16
    add	x18,	x18,	#16
    ldr	w23,	[x24]

    ldr	w20,	[x18]

    add	w19,	w20,	w23
    mov	x23,	x26
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w28,	[x23]

    add	w0,	w19,	w28
    str	w0,	[x24]

    add	w22,	w0,	w27
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w24,	w25,	#1
    sub	w19,	w24,	#2
    sub	w26,	w24,	#1
    lsl	w25,	w24,	#2
    mov	x21,	x25
    lsl	w23,	w19,	#2
    lsl	w28,	w26,	#2
    add	x21,	sp,	x21
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x21,	x21,	#16
    add	x27,	x27,	#16
    ldr	w20,	[x21]

    ldr	w0,	[x27]

    add	w26,	w0,	w20
    mov	x20,	x23
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w25,	[x20]

    add	w0,	w26,	w25
    add	w27,	w0,	w22
    str	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w24,	#1
    sub	w28,	w23,	#2
    sub	w21,	w23,	#1
    lsl	w18,	w23,	#2
    mov	x18,	x18
    lsl	w19,	w28,	#2
    lsl	w24,	w21,	#2
    add	x18,	sp,	x18
    mov	x0,	x19
    mov	x22,	x24
    add	x0,	sp,	x0
    add	x22,	sp,	x22
    add	x18,	x18,	#16
    add	x0,	x0,	#16
    add	x22,	x22,	#16
    ldr	w20,	[x18]

    ldr	w25,	[x22]

    add	w24,	w25,	w20
    ldr	w20,	[x0]

    add	w0,	w24,	w20
    add	w22,	w0,	w27
    str	w0,	[x18]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w25,	w23,	#1
    sub	w0,	w25,	#1
    sub	w23,	w25,	#2
    lsl	w24,	w25,	#2
    mov	x26,	x24
    lsl	w19,	w0,	#2
    lsl	w27,	w23,	#2
    add	x26,	sp,	x26
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x26,	x26,	#16
    add	x18,	x18,	#16
    ldr	w24,	[x26]

    ldr	w20,	[x18]

    add	w19,	w20,	w24
    mov	x24,	x27
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w28,	[x24]

    add	w0,	w19,	w28
    add	w22,	w0,	w22
    str	w0,	[x26]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w25,	#1
    b	main_5

main_108:
    lsl	w18,	w23,	#2
    sub	w26,	w23,	#1
    sub	w19,	w23,	#2
    mov	x21,	x18
    add	x21,	sp,	x21
    lsl	w28,	w26,	#2
    lsl	w24,	w19,	#2
    mov	x27,	x28
    add	x21,	x21,	#16
    add	x27,	sp,	x27
    ldr	w20,	[x21]

    add	x27,	x27,	#16
    ldr	w0,	[x27]

    add	w26,	w0,	w20
    mov	x20,	x24
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w25,	[x20]

    add	w0,	w26,	w25
    add	w22,	w0,	w22
    str	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w23,	#1
    cmp	w23,	#20
    blt	main_108

main_124:
    mov	w0,	w22
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


