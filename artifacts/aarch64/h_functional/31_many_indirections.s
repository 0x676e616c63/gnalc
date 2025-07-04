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
    movz	fp,	#8016
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#8000
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w26,	#0

main_3:
    movz	w27,	#400
    movz	w8,	#0
    mul	w2,	w26,	w27
    mov	x23,	x2
    add	x23,	sp,	x23
    add	x23,	x23,	#16

main_6:
    cmp	w8,	#96
    blt	main_9

main_28:
    lsl	w12,	w8,	#2
    add	x11,	x23,	x12
    str	w8,	[x11]

    add	w8,	w8,	#1
    cmp	w8,	#100
    blt	main_28

main_33:
    add	w26,	w26,	#1
    cmp	w26,	#20
    blt	main_3

main_36:
    movz	fp,	#7616
    add	x25,	sp,	fp
    movz	fp,	#7216
    add	x26,	x25,	#92
    ldr	w23,	[x26]

    lsl	w18,	w23,	#2
    add	x26,	sp,	fp
    movz	fp,	#6816
    add	x0,	x26,	x18
    add	x18,	sp,	fp
    movz	fp,	#6416
    ldr	w0,	[x0]

    lsl	w22,	w0,	#2
    add	x21,	x18,	x22
    add	x22,	sp,	fp
    movz	fp,	#6016
    ldr	w21,	[x21]

    add	x28,	sp,	fp
    lsl	w27,	w21,	#2
    movz	fp,	#5616
    add	x26,	x22,	x27
    add	x20,	sp,	fp
    movz	fp,	#5216
    ldr	w26,	[x26]

    add	x24,	sp,	fp
    lsl	w19,	w26,	#2
    movz	fp,	#4816
    add	x18,	x28,	x19
    ldr	w19,	[x18]

    add	x18,	sp,	fp
    lsl	w23,	w19,	#2
    movz	fp,	#4416
    add	x22,	x20,	x23
    ldr	w23,	[x22]

    add	x22,	sp,	fp
    lsl	w28,	w23,	#2
    add	x27,	x24,	x28
    add	x28,	sp,	#4016
    ldr	w0,	[x27]

    lsl	w20,	w0,	#2
    add	x19,	x18,	x20
    add	x20,	sp,	#3616
    ldr	w21,	[x19]

    lsl	w24,	w21,	#2
    add	x23,	x22,	x24
    add	x24,	sp,	#3216
    ldr	w26,	[x23]

    lsl	w0,	w26,	#2
    add	x28,	x28,	x0
    ldr	w19,	[x28]

    add	x28,	sp,	#2016
    lsl	w21,	w19,	#2
    add	x19,	sp,	#2816
    add	x20,	x20,	x21
    ldr	w23,	[x20]

    lsl	w26,	w23,	#2
    add	x23,	sp,	#2416
    add	x24,	x24,	x26
    ldr	w0,	[x24]

    lsl	w18,	w0,	#2
    add	x0,	x19,	x18
    ldr	w21,	[x0]

    lsl	w22,	w21,	#2
    add	x21,	x23,	x22
    ldr	w26,	[x21]

    add	x21,	sp,	#1616
    lsl	w27,	w26,	#2
    add	x26,	x28,	x27
    ldr	w19,	[x26]

    add	x26,	sp,	#1216
    lsl	w19,	w19,	#2
    add	x18,	x21,	x19
    ldr	w23,	[x18]

    add	x18,	sp,	#816
    lsl	w23,	w23,	#2
    add	x22,	x26,	x23
    add	x23,	sp,	#416
    ldr	w0,	[x22]

    lsl	w28,	w0,	#2
    add	x27,	x18,	x28
    add	x28,	sp,	#16
    ldr	w21,	[x27]

    add	x27,	x25,	#72
    lsl	w20,	w21,	#2
    movz	w25,	#400
    add	x19,	x23,	x20
    ldr	w26,	[x19]

    lsl	w24,	w26,	#2
    add	x23,	x28,	x24
    movz	w28,	#400
    ldr	w21,	[x23]

    ldr	w22,	[x27]

    movz	w27,	#400
    mul	w18,	w22,	w28
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    add	x19,	x0,	#68
    ldr	w26,	[x19]

    mul	w23,	w26,	w27
    movz	w26,	#400
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    add	x24,	x22,	#64
    ldr	w19,	[x24]

    mul	w27,	w19,	w26
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    add	x28,	x26,	#60
    movz	w26,	#400
    ldr	w24,	[x28]

    mul	w19,	w24,	w25
    movz	w24,	#400
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#16
    add	x20,	x18,	#56
    ldr	w0,	[x20]

    mul	w24,	w0,	w24
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    add	x25,	x23,	#52
    movz	w23,	#400
    ldr	w22,	[x25]

    movz	w25,	#400
    mul	w28,	w22,	w23
    movz	w23,	#400
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    add	x0,	x27,	#48
    ldr	w27,	[x0]

    mul	w20,	w27,	w26
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    add	x22,	x19,	#44
    ldr	w19,	[x22]

    mul	w25,	w19,	w25
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    add	x26,	x24,	#40
    movz	w24,	#400
    ldr	w25,	[x26]

    mul	w0,	w25,	w24
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    add	x18,	x28,	#36
    ldr	w0,	[x18]

    mul	w22,	w0,	w23
    mov	x20,	x22
    movz	w22,	#400
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    add	x23,	x20,	#32
    movz	w20,	#400
    ldr	w23,	[x23]

    mul	w26,	w23,	w22
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    add	x27,	x25,	#28
    ldr	w27,	[x27]

    mul	w18,	w27,	w20
    mov	x0,	x18
    movz	w18,	#400
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    add	x19,	x0,	#24
    movz	w0,	#400
    ldr	w20,	[x19]

    movz	w19,	#400
    mul	w23,	w20,	w19
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    add	x24,	x22,	#20
    ldr	w25,	[x24]

    mul	w27,	w25,	w18
    mov	x26,	x27
    movz	w27,	#400
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    add	x28,	x26,	#16
    ldr	w18,	[x28]

    movz	w28,	#400
    mul	w19,	w18,	w0
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#16
    add	x20,	x18,	#12
    ldr	w22,	[x20]

    mul	w24,	w22,	w28
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    add	x25,	x23,	#8
    ldr	w26,	[x25]

    movz	w25,	#400
    mul	w28,	w26,	w27
    movz	w26,	#400
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    add	x0,	x27,	#4
    ldr	w19,	[x0]

    mul	w20,	w19,	w26
    mov	x22,	x20
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    ldr	w24,	[x22]

    mul	w25,	w24,	w25
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    add	x26,	x24,	#224
    ldr	w27,	[x26]

    add	w0,	w27,	w21
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#8016
    add	sp, sp, fp
    ret


main_9:
    lsl	w20,	w8,	#2
    add	w6,	w8,	#1
    add	x19,	x23,	x20
    add	w9,	w6,	#1
    lsl	w4,	w6,	#2
    str	w8,	[x19]

    add	x3,	x23,	x4
    add	w12,	w9,	#1
    lsl	w7,	w9,	#2
    str	w6,	[x3]

    add	w15,	w12,	#1
    lsl	w10,	w12,	#2
    add	x6,	x23,	x7
    add	w18,	w15,	#1
    lsl	w13,	w15,	#2
    str	w9,	[x6]

    add	x9,	x23,	x10
    add	w21,	w18,	#1
    lsl	w16,	w18,	#2
    str	w12,	[x9]

    add	w25,	w21,	#1
    lsl	w19,	w21,	#2
    add	x12,	x23,	x13
    add	w8,	w25,	#1
    lsl	w22,	w25,	#2
    str	w15,	[x12]

    add	x15,	x23,	x16
    str	w18,	[x15]

    add	x18,	x23,	x19
    str	w21,	[x18]

    add	x21,	x23,	x22
    str	w25,	[x21]

    b	main_6

