.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#8016
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#8000
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
    bge	main_28

main_9:
    lsl	w12,	w8,	#2
    add	w17,	w8,	#1
    add	x11,	x23,	x12
    add	w20,	w17,	#1
    lsl	w2,	w17,	#2
    str	w8,	[x11]

    add	x1,	x23,	x2
    add	w24,	w20,	#1
    lsl	w5,	w20,	#2
    str	w17,	[x1]

    add	x4,	x23,	x5
    add	w28,	w24,	#1
    lsl	w8,	w24,	#2
    str	w20,	[x4]

    add	x7,	x23,	x8
    add	w2,	w28,	#1
    lsl	w11,	w28,	#2
    str	w24,	[x7]

    add	x10,	x23,	x11
    add	w5,	w2,	#1
    lsl	w14,	w2,	#2
    str	w28,	[x10]

    add	x13,	x23,	x14
    add	w8,	w5,	#1
    lsl	w17,	w5,	#2
    str	w2,	[x13]

    add	x16,	x23,	x17
    lsl	w20,	w8,	#2
    str	w5,	[x16]

    add	x19,	x23,	x20
    str	w8,	[x19]

    add	w8,	w8,	#1
    b	main_6

main_28:
    lsl	w10,	w8,	#2
    add	x9,	x23,	x10
    str	w8,	[x9]

    add	w8,	w8,	#1
    cmp	w8,	#100
    blt	main_28

main_33:
    add	w26,	w26,	#1
    cmp	w26,	#20
    blt	main_3

main_36:
    movz	fp,	#7616
    add	x26,	sp,	fp
    movz	fp,	#7216
    add	x28,	x26,	#92
    add	x18,	sp,	fp
    movz	fp,	#6816
    ldr	w0,	[x28]

    add	x22,	sp,	fp
    lsl	w20,	w0,	#2
    movz	fp,	#6416
    add	x19,	x18,	x20
    add	x28,	sp,	fp
    movz	fp,	#6016
    ldr	w21,	[x19]

    add	x20,	sp,	fp
    lsl	w24,	w21,	#2
    movz	fp,	#5616
    add	x23,	x22,	x24
    add	x24,	sp,	fp
    movz	fp,	#5216
    ldr	w25,	[x23]

    lsl	w0,	w25,	#2
    add	x28,	x28,	x0
    ldr	w19,	[x28]

    lsl	w21,	w19,	#2
    add	x19,	sp,	fp
    add	x20,	x20,	x21
    movz	fp,	#4816
    ldr	w23,	[x20]

    lsl	w25,	w23,	#2
    add	x23,	sp,	fp
    add	x24,	x24,	x25
    movz	fp,	#4416
    add	x28,	sp,	fp
    ldr	w0,	[x24]

    lsl	w18,	w0,	#2
    add	x0,	x19,	x18
    ldr	w21,	[x0]

    lsl	w22,	w21,	#2
    add	x21,	x23,	x22
    ldr	w25,	[x21]

    add	x21,	sp,	#4016
    lsl	w27,	w25,	#2
    add	x25,	x28,	x27
    ldr	w19,	[x25]

    add	x25,	sp,	#3616
    lsl	w19,	w19,	#2
    add	x18,	x21,	x19
    ldr	w23,	[x18]

    add	x18,	sp,	#3216
    lsl	w23,	w23,	#2
    add	x22,	x25,	x23
    add	x23,	sp,	#2816
    ldr	w0,	[x22]

    lsl	w28,	w0,	#2
    add	x27,	x18,	x28
    add	x18,	sp,	#1216
    add	x28,	sp,	#2416
    ldr	w21,	[x27]

    lsl	w20,	w21,	#2
    add	x21,	sp,	#2016
    add	x19,	x23,	x20
    ldr	w25,	[x19]

    lsl	w24,	w25,	#2
    add	x25,	sp,	#1616
    add	x23,	x28,	x24
    ldr	w19,	[x23]

    lsl	w0,	w19,	#2
    add	x28,	x21,	x0
    ldr	w23,	[x28]

    add	x28,	sp,	#416
    lsl	w21,	w23,	#2
    add	x23,	sp,	#816
    add	x20,	x25,	x21
    ldr	w0,	[x20]

    add	x20,	sp,	#16
    lsl	w25,	w0,	#2
    add	x24,	x18,	x25
    ldr	w21,	[x24]

    movz	w24,	#400
    lsl	w18,	w21,	#2
    add	x0,	x23,	x18
    movz	w23,	#400
    ldr	w25,	[x0]

    add	x0,	x26,	#72
    lsl	w22,	w25,	#2
    add	x21,	x28,	x22
    movz	w22,	#400
    ldr	w19,	[x21]

    lsl	w27,	w19,	#2
    add	x25,	x20,	x27
    ldr	w27,	[x25]

    ldr	w26,	[x0]

    mul	w20,	w26,	w24
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    add	x21,	x19,	#68
    ldr	w19,	[x21]

    movz	w21,	#400
    mul	w24,	w19,	w23
    movz	w19,	#400
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    add	x25,	x23,	#64
    ldr	w24,	[x25]

    mul	w0,	w24,	w22
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    add	x18,	x28,	#60
    ldr	w0,	[x18]

    mul	w21,	w0,	w21
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    add	x22,	x20,	#56
    movz	w20,	#400
    ldr	w22,	[x22]

    mul	w25,	w22,	w20
    movz	w20,	#400
    movz	w22,	#400
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    add	x26,	x24,	#52
    ldr	w26,	[x26]

    mul	w18,	w26,	w19
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    add	x19,	x0,	#48
    ldr	w19,	[x19]

    mul	w22,	w19,	w22
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    add	x23,	x21,	#44
    movz	w21,	#400
    ldr	w24,	[x23]

    mul	w26,	w24,	w21
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    add	x28,	x25,	#40
    ldr	w0,	[x28]

    mul	w19,	w0,	w20
    mov	x18,	x19
    movz	w19,	#400
    add	x18,	sp,	x18
    add	x18,	x18,	#16
    add	x20,	x18,	#36
    movz	w18,	#400
    ldr	w22,	[x20]

    mul	w23,	w22,	w19
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    add	x24,	x22,	#32
    ldr	w26,	[x24]

    mul	w28,	w26,	w18
    mov	x26,	x28
    movz	w28,	#400
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    add	x0,	x26,	#28
    movz	w26,	#400
    ldr	w20,	[x0]

    movz	w0,	#400
    mul	w20,	w20,	w0
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    add	x21,	x19,	#24
    ldr	w23,	[x21]

    mul	w24,	w23,	w28
    mov	x23,	x24
    movz	w24,	#400
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    add	x25,	x23,	#20
    movz	w23,	#400
    ldr	w0,	[x25]

    movz	w25,	#400
    mul	w0,	w0,	w26
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    add	x18,	x28,	#16
    ldr	w21,	[x18]

    mul	w21,	w21,	w25
    mov	x20,	x21
    movz	w21,	#400
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    add	x22,	x20,	#12
    ldr	w26,	[x22]

    movz	w22,	#400
    mul	w25,	w26,	w24
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    add	x26,	x24,	#8
    ldr	w19,	[x26]

    mul	w18,	w19,	w23
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    add	x19,	x0,	#4
    ldr	w24,	[x19]

    mul	w22,	w24,	w22
    mov	x23,	x22
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w0,	[x23]

    mul	w26,	w0,	w21
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    add	x28,	x25,	#224
    ldr	w0,	[x28]

    add	w0,	w0,	w27
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#8016
    add	sp, sp, fp
    ret


