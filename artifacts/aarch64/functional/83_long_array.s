.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w7,	#0

main_4:
    movz	w1,	#9984
    cmp	w7,	w1
    bge	main_138

main_7:
    lsl	w21,	w7,	#2
    movz	fp,	#40016
    mul	w11,	w7,	w7
    movz	w8,	#10
    add	w2,	w7,	#1
    movz	w22,	#10
    movz	w20,	#10
    movz	w14,	#10
    mov	x5,	x21
    sdiv	w17,	w11,	w8
    mul	w12,	w2,	w2
    add	x5,	sp,	x5
    lsl	w15,	w17,	#1
    sdiv	w8,	w12,	w22
    lsl	w28,	w8,	#1
    add	x5,	x5,	fp
    add	w13,	w15,	w17,	lsl #3
    add	w10,	w28,	w8,	lsl #3
    movz	fp,	#40016
    sub	w23,	w11,	w13
    sub	w7,	w12,	w10
    add	w13,	w2,	#1
    str	w23,	[x5]

    add	w19,	w13,	#1
    mul	w18,	w13,	w13
    lsl	w10,	w13,	#2
    lsl	w5,	w2,	#2
    sdiv	w6,	w18,	w20
    mov	x11,	x10
    mul	w24,	w19,	w19
    lsl	w15,	w19,	#2
    mov	x3,	x5
    lsl	w0,	w6,	#1
    add	x11,	sp,	x11
    mov	x16,	x15
    add	x3,	sp,	x3
    add	x16,	sp,	x16
    add	x3,	x3,	fp
    movz	fp,	#40016
    str	w7,	[x3]

    add	x11,	x11,	fp
    add	w7,	w0,	w6,	lsl #3
    movz	fp,	#40016
    add	x16,	x16,	fp
    sub	w12,	w18,	w7
    movz	fp,	#40016
    movz	w18,	#10
    str	w12,	[x11]

    sdiv	w3,	w24,	w18
    movz	w12,	#10
    lsl	w1,	w3,	#1
    add	w4,	w1,	w3,	lsl #3
    sub	w17,	w24,	w4
    add	w24,	w19,	#1
    str	w17,	[x16]

    mul	w0,	w24,	w24
    lsl	w20,	w24,	#2
    movz	w16,	#10
    mov	x23,	x20
    add	x23,	sp,	x23
    sdiv	w28,	w0,	w16
    lsl	w2,	w28,	#1
    add	x23,	x23,	fp
    add	w1,	w2,	w28,	lsl #3
    movz	fp,	#40016
    add	w28,	w24,	#1
    sub	w22,	w0,	w1
    mul	w6,	w28,	w28
    lsl	w25,	w28,	#2
    mov	x10,	x25
    str	w22,	[x23]

    sdiv	w25,	w6,	w14
    add	x10,	sp,	x10
    lsl	w3,	w25,	#1
    add	w27,	w3,	w25,	lsl #3
    add	x10,	x10,	fp
    movz	w25,	#10
    movz	fp,	#40016
    sub	w27,	w6,	w27
    str	w27,	[x10]

    movz	w27,	#10
    add	w10,	w28,	#1
    add	w16,	w10,	#1
    mul	w11,	w10,	w10
    lsl	w1,	w10,	#2
    sdiv	w22,	w11,	w12
    movz	w10,	#10
    mov	x7,	x1
    add	w23,	w16,	#1
    mul	w17,	w16,	w16
    lsl	w6,	w16,	#2
    lsl	w4,	w22,	#1
    add	x7,	sp,	x7
    sdiv	w19,	w17,	w10
    add	w1,	w23,	#1
    mov	x13,	x6
    add	w24,	w4,	w22,	lsl #3
    lsl	w5,	w19,	#1
    add	x7,	x7,	fp
    add	x13,	sp,	x13
    add	w9,	w1,	#1
    mul	w0,	w1,	w1
    movz	w4,	#10
    sub	w3,	w11,	w24
    add	w21,	w5,	w19,	lsl #3
    movz	fp,	#40016
    mul	w24,	w23,	w23
    lsl	w11,	w23,	#2
    str	w3,	[x7]

    add	x13,	x13,	fp
    sub	w8,	w17,	w21
    mov	x20,	x11
    movz	fp,	#40016
    lsl	w21,	w9,	#2
    add	x20,	sp,	x20
    mov	x2,	x21
    str	w8,	[x13]

    add	x2,	sp,	x2
    movz	w8,	#10
    add	x20,	x20,	fp
    sdiv	w16,	w24,	w8
    movz	fp,	#40016
    lsl	w6,	w16,	#1
    add	w18,	w6,	w16,	lsl #3
    movz	w6,	#10
    lsl	w16,	w1,	#2
    mov	x26,	x16
    sub	w13,	w24,	w18
    add	x26,	sp,	x26
    str	w13,	[x20]

    add	x26,	x26,	fp
    add	w20,	w9,	#1
    sdiv	w13,	w0,	w6
    movz	fp,	#40016
    mul	w6,	w9,	w9
    lsl	w7,	w13,	#1
    sdiv	w10,	w6,	w4
    mul	w5,	w20,	w20
    add	x2,	x2,	fp
    add	w15,	w7,	w13,	lsl #3
    lsl	w8,	w10,	#1
    movz	fp,	#40016
    add	w12,	w8,	w10,	lsl #3
    sub	w18,	w0,	w15
    movz	w0,	#10
    sub	w23,	w6,	w12
    str	w18,	[x26]

    lsl	w26,	w20,	#2
    str	w23,	[x2]

    mov	x18,	x26
    add	w23,	w20,	#1
    movz	w2,	#10
    add	x18,	sp,	x18
    sdiv	w6,	w5,	w2
    mul	w19,	w23,	w23
    lsl	w2,	w23,	#2
    add	x18,	x18,	fp
    lsl	w9,	w6,	#1
    sdiv	w3,	w19,	w0
    mov	x17,	x2
    movz	fp,	#40016
    add	w9,	w9,	w6,	lsl #3
    lsl	w10,	w3,	#1
    add	x17,	sp,	x17
    sub	w28,	w5,	w9
    add	w6,	w10,	w3,	lsl #3
    add	x17,	x17,	fp
    movz	fp,	#40016
    str	w28,	[x18]

    sub	w4,	w19,	w6
    add	w28,	w23,	#1
    str	w4,	[x17]

    add	w10,	w28,	#1
    mul	w23,	w28,	w28
    lsl	w7,	w28,	#2
    sdiv	w0,	w23,	w27
    mov	x21,	x7
    lsl	w11,	w0,	#1
    add	w15,	w10,	#1
    mul	w1,	w10,	w10
    lsl	w12,	w10,	#2
    add	x21,	sp,	x21
    add	w3,	w11,	w0,	lsl #3
    sdiv	w26,	w1,	w25
    mul	w27,	w15,	w15
    lsl	w17,	w15,	#2
    mov	x28,	x12
    add	x21,	x21,	fp
    sub	w9,	w23,	w3
    mov	x10,	x17
    lsl	w12,	w26,	#1
    add	x28,	sp,	x28
    movz	fp,	#40016
    movz	w23,	#10
    str	w9,	[x21]

    add	w17,	w15,	#1
    add	x10,	sp,	x10
    add	w0,	w12,	w26,	lsl #3
    add	x28,	x28,	fp
    sdiv	w23,	w27,	w23
    movz	w21,	#10
    lsl	w22,	w17,	#2
    sub	w14,	w1,	w0
    movz	fp,	#40016
    lsl	w13,	w23,	#1
    mov	x9,	x22
    add	x10,	x10,	fp
    add	x9,	sp,	x9
    str	w14,	[x28]

    add	w26,	w13,	w23,	lsl #3
    movz	fp,	#40016
    sub	w19,	w27,	w26
    add	x9,	x9,	fp
    add	w26,	w17,	#1
    movz	fp,	#40016
    str	w19,	[x10]

    mul	w16,	w26,	w26
    lsl	w27,	w26,	#2
    movz	w19,	#10
    mul	w10,	w17,	w17
    mov	x18,	x27
    sdiv	w20,	w10,	w21
    sdiv	w17,	w16,	w19
    add	x18,	sp,	x18
    lsl	w14,	w20,	#1
    lsl	w15,	w17,	#1
    add	x18,	x18,	fp
    add	w23,	w14,	w20,	lsl #3
    movz	fp,	#40016
    add	w20,	w15,	w17,	lsl #3
    movz	w15,	#10
    movz	w17,	#10
    sub	w24,	w10,	w23
    sub	w0,	w16,	w20
    str	w24,	[x9]

    add	w9,	w26,	#1
    str	w0,	[x18]

    mul	w14,	w9,	w9
    lsl	w3,	w9,	#2
    add	w18,	w9,	#1
    sdiv	w13,	w14,	w17
    mov	x1,	x3
    movz	w9,	#10
    lsl	w16,	w13,	#1
    add	x1,	sp,	x1
    add	w23,	w18,	#1
    mul	w0,	w18,	w18
    lsl	w8,	w18,	#2
    add	w17,	w16,	w13,	lsl #3
    add	x1,	x1,	fp
    sdiv	w10,	w0,	w15
    add	w26,	w23,	#1
    mov	x7,	x8
    lsl	w13,	w23,	#2
    sub	w5,	w14,	w17
    movz	fp,	#40016
    add	x7,	sp,	x7
    add	w3,	w26,	#1
    mov	x8,	x13
    lsl	w17,	w10,	#1
    str	w5,	[x1]

    add	x7,	x7,	fp
    movz	w13,	#10
    add	x8,	sp,	x8
    add	w14,	w17,	w10,	lsl #3
    mul	w5,	w23,	w23
    movz	fp,	#40016
    lsl	w23,	w3,	#2
    sub	w10,	w0,	w14
    add	x8,	x8,	fp
    mov	x21,	x23
    movz	fp,	#40016
    add	x21,	sp,	x21
    str	w10,	[x7]

    add	w10,	w3,	#1
    sdiv	w7,	w5,	w13
    mul	w13,	w26,	w26
    lsl	w18,	w7,	#1
    mul	w23,	w10,	w10
    lsl	w28,	w10,	#2
    add	w11,	w18,	w7,	lsl #3
    lsl	w18,	w26,	#2
    movz	w7,	#10
    mov	x26,	x28
    sub	w15,	w5,	w11
    sdiv	w27,	w23,	w7
    add	x26,	sp,	x26
    movz	w11,	#10
    str	w15,	[x8]

    sdiv	w4,	w13,	w11
    mov	x15,	x18
    lsl	w19,	w4,	#1
    mul	w18,	w3,	w3
    add	x15,	sp,	x15
    add	w8,	w19,	w4,	lsl #3
    movz	w3,	#10
    sdiv	w1,	w18,	w9
    add	x15,	x15,	fp
    sub	w20,	w13,	w8
    movz	fp,	#40016
    add	x21,	x21,	fp
    str	w20,	[x15]

    movz	fp,	#40016
    lsl	w20,	w1,	#1
    add	x26,	x26,	fp
    add	w5,	w20,	w1,	lsl #3
    movz	fp,	#40016
    sub	w25,	w18,	w5
    movz	w5,	#10
    add	w18,	w10,	#1
    str	w25,	[x21]

    mul	w0,	w18,	w18
    lsl	w4,	w18,	#2
    lsl	w21,	w27,	#1
    sdiv	w24,	w0,	w5
    mov	x4,	x4
    lsl	w22,	w24,	#1
    add	w2,	w21,	w27,	lsl #3
    add	x4,	sp,	x4
    add	w28,	w22,	w24,	lsl #3
    add	w24,	w18,	#1
    sub	w1,	w23,	w2
    add	x4,	x4,	fp
    sub	w6,	w0,	w28
    movz	fp,	#40016
    lsl	w9,	w24,	#2
    add	w2,	w24,	#1
    str	w1,	[x26]

    movz	w28,	#10
    mov	x10,	x9
    movz	w26,	#10
    add	w7,	w2,	#1
    lsl	w14,	w2,	#2
    movz	w1,	#10
    str	w6,	[x4]

    add	x10,	sp,	x10
    mov	x15,	x14
    lsl	w19,	w7,	#2
    mul	w6,	w24,	w24
    add	x15,	sp,	x15
    sdiv	w20,	w6,	w3
    add	x10,	x10,	fp
    lsl	w23,	w20,	#1
    movz	fp,	#40016
    add	w25,	w23,	w20,	lsl #3
    add	x15,	x15,	fp
    movz	w20,	#10
    movz	fp,	#40016
    sub	w11,	w6,	w25
    str	w11,	[x10]

    mul	w11,	w2,	w2
    sdiv	w17,	w11,	w1
    lsl	w24,	w17,	#1
    add	w22,	w24,	w17,	lsl #3
    sub	w16,	w11,	w22
    mov	x22,	x19
    add	x22,	sp,	x22
    str	w16,	[x15]

    mul	w16,	w7,	w7
    add	x22,	x22,	fp
    sdiv	w14,	w16,	w28
    movz	fp,	#40016
    add	w28,	w7,	#1
    lsl	w25,	w14,	#1
    mul	w12,	w28,	w28
    lsl	w24,	w28,	#2
    add	w19,	w25,	w14,	lsl #3
    sdiv	w11,	w12,	w26
    lsl	w26,	w11,	#1
    sub	w21,	w16,	w19
    add	w16,	w26,	w11,	lsl #3
    str	w21,	[x22]

    sub	w26,	w12,	w16
    add	w22,	w28,	#1
    mov	x21,	x24
    movz	w24,	#10
    add	x21,	sp,	x21
    lsl	w0,	w22,	#2
    mov	x7,	x0
    add	x21,	x21,	fp
    mul	w0,	w22,	w22
    add	x7,	sp,	x7
    movz	fp,	#40016
    sdiv	w8,	w0,	w24
    str	w26,	[x21]

    lsl	w27,	w8,	#1
    add	x7,	x7,	fp
    add	w13,	w27,	w8,	lsl #3
    movz	fp,	#40016
    sub	w2,	w0,	w13
    add	w0,	w22,	#1
    movz	w22,	#10
    str	w2,	[x7]

    mul	w6,	w0,	w0
    lsl	w5,	w0,	#2
    add	w8,	w0,	#1
    mov	x14,	x5
    sdiv	w5,	w6,	w22
    add	x14,	sp,	x14
    lsl	w28,	w5,	#1
    mul	w13,	w8,	w8
    add	x14,	x14,	fp
    add	w10,	w28,	w5,	lsl #3
    sdiv	w3,	w13,	w20
    movz	fp,	#40016
    lsl	w0,	w3,	#1
    sub	w7,	w6,	w10
    lsl	w10,	w8,	#2
    mov	x21,	x10
    str	w7,	[x14]

    add	x21,	sp,	x21
    add	w7,	w0,	w3,	lsl #3
    add	x21,	x21,	fp
    sub	w12,	w13,	w7
    add	w7,	w8,	#1
    str	w12,	[x21]

    b	main_4

main_138:
    lsl	w13,	w7,	#2
    movz	fp,	#40016
    mul	w1,	w7,	w7
    movz	w24,	#10
    add	w21,	w7,	#1
    movz	w9,	#10
    mov	x16,	x13
    sdiv	w14,	w1,	w24
    movz	w7,	#10
    add	x16,	sp,	x16
    add	w26,	w21,	#1
    lsl	w20,	w21,	#2
    lsl	w19,	w14,	#1
    mul	w13,	w21,	w21
    add	x16,	x16,	fp
    mov	x5,	x20
    mul	w18,	w26,	w26
    lsl	w25,	w26,	#2
    add	w10,	w19,	w14,	lsl #3
    sdiv	w6,	w13,	w9
    movz	fp,	#40016
    add	x5,	sp,	x5
    mov	x12,	x25
    lsl	w2,	w6,	#1
    sub	w15,	w1,	w10
    add	x12,	sp,	x12
    add	x5,	x5,	fp
    add	w6,	w2,	w6,	lsl #3
    add	w10,	w26,	#1
    movz	fp,	#40016
    str	w15,	[x16]

    sdiv	w2,	w18,	w7
    sub	w22,	w13,	w6
    add	x12,	x12,	fp
    add	w14,	w10,	#1
    mul	w8,	w10,	w10
    lsl	w1,	w10,	#2
    movz	w15,	#10000
    lsl	w3,	w2,	#1
    str	w22,	[x5]

    movz	fp,	#40016
    add	w19,	w14,	#1
    lsl	w6,	w14,	#2
    mov	x17,	x1
    add	w3,	w3,	w2,	lsl #3
    movz	w5,	#10
    lsl	w11,	w19,	#2
    mov	x21,	x6
    movz	w1,	#10
    add	x17,	sp,	x17
    sub	w27,	w18,	w3
    sdiv	w28,	w8,	w5
    add	x21,	sp,	x21
    lsl	w4,	w28,	#1
    add	x17,	x17,	fp
    str	w27,	[x12]

    add	w0,	w4,	w28,	lsl #3
    movz	fp,	#40016
    mul	w12,	w14,	w14
    mov	x28,	x11
    sub	w3,	w8,	w0
    add	x21,	x21,	fp
    add	x28,	sp,	x28
    movz	fp,	#40016
    str	w3,	[x17]

    add	x28,	x28,	fp
    mul	w17,	w19,	w19
    movz	w3,	#10
    movz	fp,	#40016
    sdiv	w22,	w17,	w1
    sdiv	w25,	w12,	w3
    lsl	w6,	w22,	#1
    lsl	w5,	w25,	#1
    add	w23,	w6,	w22,	lsl #3
    add	w26,	w5,	w25,	lsl #3
    sub	w13,	w17,	w23
    sub	w8,	w12,	w26
    add	w26,	w19,	#1
    str	w8,	[x21]

    mul	w23,	w26,	w26
    lsl	w16,	w26,	#2
    str	w13,	[x28]

    mov	x4,	x16
    movz	w28,	#10
    add	x4,	sp,	x4
    sdiv	w19,	w23,	w28
    add	x4,	x4,	fp
    lsl	w7,	w19,	#1
    movz	fp,	#40016
    add	w20,	w7,	w19,	lsl #3
    sub	w18,	w23,	w20
    str	w18,	[x4]

    add	w4,	w26,	#1
    movz	w26,	#10
    mul	w0,	w4,	w4
    lsl	w21,	w4,	#2
    add	w7,	w4,	#1
    sdiv	w16,	w0,	w26
    mov	x11,	x21
    lsl	w8,	w16,	#1
    add	x11,	sp,	x11
    add	w17,	w8,	w16,	lsl #3
    add	x11,	x11,	fp
    sub	w23,	w0,	w17
    str	w23,	[x11]

    cmp	w7,	w15
    blt	main_138

main_173:
    movz	w9,	#0

main_174:
    movz	w12,	#9984
    cmp	w9,	w12
    bge	main_324

main_177:
    lsl	w27,	w9,	#2
    lsl	w0,	w9,	#2
    movz	fp,	#40016
    movz	w16,	#10
    add	w20,	w9,	#1
    mov	x8,	x27
    mov	x28,	x0
    add	x8,	sp,	x8
    add	x28,	sp,	x28
    add	w24,	w20,	#1
    lsl	w9,	w20,	#2
    lsl	w7,	w20,	#2
    add	x8,	x8,	#16
    add	x28,	x28,	fp
    lsl	w15,	w24,	#2
    movz	fp,	#40016
    mov	x2,	x15
    ldr	w1,	[x28]

    add	x2,	sp,	x2
    movz	w28,	#10
    mul	w26,	w1,	w1
    sdiv	w1,	w26,	w16
    add	x2,	x2,	#16
    lsl	w27,	w1,	#1
    add	w22,	w27,	w1,	lsl #3
    sub	w3,	w26,	w22
    movz	w22,	#10
    mov	x26,	x7
    add	x26,	sp,	x26
    str	w3,	[x8]

    mov	x8,	x9
    add	x26,	x26,	#16
    add	x8,	sp,	x8
    add	x8,	x8,	fp
    movz	fp,	#40016
    ldr	w10,	[x8]

    mul	w21,	w10,	w10
    sdiv	w17,	w21,	w28
    lsl	w10,	w17,	#1
    add	w14,	w10,	w17,	lsl #3
    lsl	w17,	w24,	#2
    mov	x16,	x17
    sub	w12,	w21,	w14
    add	x16,	sp,	x16
    add	w14,	w24,	#1
    str	w12,	[x26]

    add	x16,	x16,	fp
    lsl	w25,	w14,	#2
    lsl	w23,	w14,	#2
    movz	w26,	#10
    movz	fp,	#40016
    ldr	w18,	[x16]

    mov	x24,	x25
    movz	w16,	#10
    mul	w1,	w18,	w18
    add	w25,	w14,	#1
    add	x24,	sp,	x24
    mov	x18,	x23
    sdiv	w13,	w1,	w26
    add	x18,	sp,	x18
    lsl	w11,	w13,	#1
    lsl	w4,	w25,	#2
    add	x24,	x24,	fp
    add	w10,	w11,	w13,	lsl #3
    mov	x3,	x4
    add	x18,	x18,	#16
    movz	fp,	#40016
    add	x3,	sp,	x3
    sub	w20,	w1,	w10
    add	x3,	x3,	fp
    str	w20,	[x2]

    movz	fp,	#40016
    lsl	w2,	w25,	#2
    ldr	w26,	[x24]

    mov	x1,	x2
    movz	w24,	#10
    mul	w11,	w26,	w26
    add	x1,	sp,	x1
    sdiv	w8,	w11,	w24
    lsl	w12,	w8,	#1
    add	x1,	x1,	#16
    add	w6,	w12,	w8,	lsl #3
    sub	w28,	w11,	w6
    str	w28,	[x18]

    ldr	w5,	[x3]

    mul	w20,	w5,	w5
    sdiv	w4,	w20,	w22
    lsl	w13,	w4,	#1
    add	w2,	w13,	w4,	lsl #3
    add	w4,	w25,	#1
    sub	w7,	w20,	w2
    lsl	w12,	w4,	#2
    lsl	w10,	w4,	#2
    movz	w20,	#10
    mov	x11,	x12
    str	w7,	[x1]

    movz	w12,	#10
    add	x11,	sp,	x11
    mov	x7,	x10
    add	x7,	sp,	x7
    add	x11,	x11,	fp
    add	x7,	x7,	#16
    movz	fp,	#40016
    ldr	w13,	[x11]

    mul	w1,	w13,	w13
    add	w13,	w4,	#1
    sdiv	w0,	w1,	w20
    lsl	w14,	w0,	#1
    add	w5,	w13,	#1
    lsl	w18,	w13,	#2
    lsl	w20,	w13,	#2
    add	w27,	w14,	w0,	lsl #3
    mov	x24,	x18
    mov	x19,	x20
    lsl	w28,	w5,	#2
    lsl	w26,	w5,	#2
    movz	w14,	#10
    sub	w15,	w1,	w27
    movz	w18,	#10
    add	x24,	sp,	x24
    add	x19,	sp,	x19
    mov	x26,	x26
    mov	x27,	x28
    str	w15,	[x7]

    add	x24,	x24,	#16
    add	x26,	sp,	x26
    add	x19,	x19,	fp
    add	x27,	sp,	x27
    movz	fp,	#40016
    add	x26,	x26,	#16
    ldr	w21,	[x19]

    add	x27,	x27,	fp
    mul	w8,	w21,	w21
    movz	fp,	#40016
    sdiv	w25,	w8,	w18
    add	w18,	w5,	#1
    lsl	w15,	w25,	#1
    add	w23,	w15,	w25,	lsl #3
    lsl	w7,	w18,	#2
    lsl	w5,	w18,	#2
    add	w25,	w18,	#1
    mov	x6,	x7
    sub	w23,	w8,	w23
    mov	x13,	x5
    add	x6,	sp,	x6
    add	x13,	sp,	x13
    add	w9,	w25,	#1
    str	w23,	[x24]

    add	x6,	x6,	fp
    add	x13,	x13,	#16
    lsl	w23,	w9,	#2
    ldr	w0,	[x27]

    movz	fp,	#40016
    mul	w2,	w0,	w0
    sdiv	w21,	w2,	w16
    lsl	w16,	w21,	#1
    add	w19,	w16,	w21,	lsl #3
    sub	w2,	w2,	w19
    str	w2,	[x26]

    ldr	w8,	[x6]

    movz	w6,	#10
    mul	w28,	w8,	w8
    sdiv	w16,	w28,	w14
    lsl	w17,	w16,	#1
    add	w15,	w17,	w16,	lsl #3
    sub	w10,	w28,	w15
    lsl	w15,	w25,	#2
    mov	x14,	x15
    str	w10,	[x13]

    add	x14,	sp,	x14
    movz	w10,	#10
    lsl	w13,	w25,	#2
    mov	x22,	x13
    add	x14,	x14,	fp
    add	x22,	sp,	x22
    movz	fp,	#40016
    ldr	w16,	[x14]

    add	x22,	x22,	#16
    mul	w21,	w16,	w16
    sdiv	w12,	w21,	w12
    lsl	w18,	w12,	#1
    add	w11,	w18,	w12,	lsl #3
    sub	w18,	w21,	w11
    lsl	w21,	w9,	#2
    mov	x5,	x21
    str	w18,	[x22]

    add	x5,	sp,	x5
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x5,	x5,	#16
    add	x22,	x22,	fp
    movz	fp,	#40016
    ldr	w24,	[x22]

    mul	w18,	w24,	w24
    sdiv	w8,	w18,	w10
    lsl	w19,	w8,	#1
    add	w7,	w19,	w8,	lsl #3
    movz	w8,	#10
    sub	w26,	w18,	w7
    str	w26,	[x5]

    add	w26,	w9,	#1
    add	w14,	w26,	#1
    lsl	w2,	w26,	#2
    lsl	w0,	w26,	#2
    mov	x1,	x2
    mov	x22,	x0
    add	x1,	sp,	x1
    lsl	w10,	w14,	#2
    add	x22,	sp,	x22
    mov	x9,	x10
    add	x1,	x1,	fp
    add	x9,	sp,	x9
    add	x22,	x22,	#16
    movz	fp,	#40016
    ldr	w3,	[x1]

    add	x9,	x9,	fp
    mul	w27,	w3,	w3
    movz	fp,	#40016
    sdiv	w4,	w27,	w8
    lsl	w8,	w14,	#2
    lsl	w20,	w4,	#1
    add	w14,	w14,	#1
    mov	x2,	x8
    add	w3,	w20,	w4,	lsl #3
    add	x2,	sp,	x2
    movz	w4,	#10
    lsl	w18,	w14,	#2
    lsl	w16,	w14,	#2
    sub	w5,	w27,	w3
    add	x2,	x2,	#16
    mov	x17,	x18
    mov	x10,	x16
    add	x17,	sp,	x17
    add	x10,	sp,	x10
    str	w5,	[x22]

    add	w5,	w14,	#1
    ldr	w11,	[x9]

    add	x17,	x17,	fp
    add	x10,	x10,	#16
    mul	w8,	w11,	w11
    movz	fp,	#40016
    lsl	w26,	w5,	#2
    sdiv	w0,	w8,	w6
    lsl	w21,	w0,	#1
    add	w28,	w21,	w0,	lsl #3
    sub	w13,	w8,	w28
    str	w13,	[x2]

    movz	w2,	#10
    ldr	w19,	[x17]

    mul	w15,	w19,	w19
    sdiv	w25,	w15,	w4
    lsl	w22,	w25,	#1
    add	w24,	w22,	w25,	lsl #3
    mov	x25,	x26
    add	x25,	sp,	x25
    sub	w21,	w15,	w24
    lsl	w24,	w5,	#2
    add	x25,	x25,	fp
    mov	x22,	x24
    str	w21,	[x10]

    movz	fp,	#40016
    add	x22,	sp,	x22
    ldr	w27,	[x25]

    mul	w7,	w27,	w27
    add	x22,	x22,	#16
    movz	w27,	#10
    sdiv	w20,	w7,	w2
    lsl	w23,	w20,	#1
    add	w20,	w23,	w20,	lsl #3
    sub	w0,	w7,	w20
    add	w20,	w5,	#1
    str	w0,	[x22]

    add	w18,	w20,	#1
    lsl	w5,	w20,	#2
    lsl	w3,	w20,	#2
    movz	w0,	#10
    mov	x4,	x5
    mov	x10,	x3
    lsl	w13,	w18,	#2
    lsl	w11,	w18,	#2
    add	x4,	sp,	x4
    add	x10,	sp,	x10
    mov	x12,	x13
    mov	x5,	x11
    add	x12,	sp,	x12
    add	w11,	w18,	#1
    add	x4,	x4,	fp
    add	x10,	x10,	#16
    add	x5,	sp,	x5
    movz	fp,	#40016
    lsl	w21,	w11,	#2
    lsl	w19,	w11,	#2
    ldr	w6,	[x4]

    add	x12,	x12,	fp
    add	x5,	x5,	#16
    mov	x20,	x21
    mul	w15,	w6,	w6
    movz	fp,	#40016
    movz	w21,	#10
    add	x20,	sp,	x20
    sdiv	w16,	w15,	w0
    mov	x0,	x19
    lsl	w24,	w16,	#1
    add	x20,	x20,	fp
    movz	w19,	#10
    add	x0,	sp,	x0
    add	w16,	w24,	w16,	lsl #3
    movz	fp,	#40016
    add	x0,	x0,	#16
    sub	w8,	w15,	w16
    str	w8,	[x10]

    ldr	w14,	[x12]

    mul	w23,	w14,	w14
    add	w14,	w11,	#1
    sdiv	w12,	w23,	w27
    lsl	w25,	w12,	#1
    add	w10,	w14,	#1
    lsl	w27,	w14,	#2
    add	w12,	w25,	w12,	lsl #3
    movz	w25,	#10
    lsl	w6,	w10,	#2
    sub	w16,	w23,	w12
    movz	w23,	#10
    mov	x12,	x27
    add	x12,	sp,	x12
    str	w16,	[x5]

    ldr	w22,	[x20]

    add	x12,	x12,	#16
    mul	w4,	w22,	w22
    sdiv	w8,	w4,	w25
    lsl	w26,	w8,	#1
    add	w8,	w26,	w8,	lsl #3
    sub	w24,	w4,	w8
    lsl	w8,	w10,	#2
    mov	x7,	x8
    str	w24,	[x0]

    add	x7,	sp,	x7
    lsl	w0,	w14,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    movz	fp,	#40016
    ldr	w1,	[x28]

    add	x7,	x7,	fp
    mul	w13,	w1,	w1
    movz	fp,	#40016
    sdiv	w4,	w13,	w23
    mov	x23,	x6
    lsl	w27,	w4,	#1
    add	w6,	w10,	#1
    add	x23,	sp,	x23
    add	w4,	w27,	w4,	lsl #3
    lsl	w16,	w6,	#2
    lsl	w14,	w6,	#2
    add	x23,	x23,	#16
    sub	w3,	w13,	w4
    mov	x15,	x16
    add	x15,	sp,	x15
    str	w3,	[x12]

    ldr	w9,	[x7]

    add	x15,	x15,	fp
    mul	w22,	w9,	w9
    movz	fp,	#40016
    sdiv	w0,	w22,	w21
    mov	x21,	x14
    lsl	w28,	w0,	#1
    add	x21,	sp,	x21
    add	w0,	w28,	w0,	lsl #3
    add	x21,	x21,	#16
    sub	w11,	w22,	w0
    str	w11,	[x23]

    ldr	w17,	[x15]

    movz	w15,	#10
    mul	w3,	w17,	w17
    movz	w17,	#10
    sdiv	w25,	w3,	w19
    lsl	w0,	w25,	#1
    add	w25,	w0,	w25,	lsl #3
    sub	w19,	w3,	w25
    add	w3,	w6,	#1
    str	w19,	[x21]

    add	w0,	w3,	#1
    lsl	w24,	w3,	#2
    lsl	w22,	w3,	#2
    mov	x23,	x24
    mov	x13,	x22
    add	x23,	sp,	x23
    lsl	w3,	w0,	#2
    add	x13,	sp,	x13
    mov	x2,	x3
    add	x23,	x23,	fp
    add	x2,	sp,	x2
    add	x13,	x13,	#16
    movz	fp,	#40016
    ldr	w25,	[x23]

    add	x2,	x2,	fp
    mul	w11,	w25,	w25
    movz	fp,	#40016
    sdiv	w21,	w11,	w17
    lsl	w1,	w21,	#1
    add	w21,	w1,	w21,	lsl #3
    lsl	w1,	w0,	#2
    sub	w27,	w11,	w21
    str	w27,	[x13]

    ldr	w4,	[x2]

    mov	x13,	x1
    mul	w21,	w4,	w4
    add	x13,	sp,	x13
    sdiv	w17,	w21,	w15
    add	w15,	w0,	#1
    lsl	w2,	w17,	#1
    add	x13,	x13,	#16
    add	w17,	w2,	w17,	lsl #3
    lsl	w11,	w15,	#2
    lsl	w9,	w15,	#2
    mov	x10,	x11
    mov	x23,	x9
    sub	w6,	w21,	w17
    add	x10,	sp,	x10
    add	w9,	w15,	#1
    add	x23,	sp,	x23
    str	w6,	[x13]

    add	x10,	x10,	fp
    add	x23,	x23,	#16
    movz	w13,	#10
    ldr	w12,	[x10]

    mul	w28,	w12,	w12
    sdiv	w13,	w28,	w13
    lsl	w3,	w13,	#1
    add	w13,	w3,	w13,	lsl #3
    sub	w14,	w28,	w13
    str	w14,	[x23]

    b	main_174

main_324:
    lsl	w23,	w9,	#2
    lsl	w25,	w9,	#2
    movz	fp,	#40016
    movz	w3,	#10
    add	w0,	w9,	#1
    movz	w15,	#10
    movz	w13,	#10
    mov	x20,	x23
    mov	x24,	x25
    add	x20,	sp,	x20
    add	w8,	w0,	#1
    lsl	w25,	w0,	#2
    add	x24,	sp,	x24
    add	x20,	x20,	#16
    add	w21,	w8,	#1
    lsl	w6,	w8,	#2
    lsl	w4,	w8,	#2
    add	x24,	x24,	fp
    movz	fp,	#40016
    lsl	w12,	w21,	#2
    ldr	w26,	[x24]

    mul	w26,	w26,	w26
    sdiv	w7,	w26,	w3
    movz	w3,	#10
    lsl	w23,	w7,	#1
    add	w27,	w23,	w7,	lsl #3
    mov	x7,	x25
    mov	x25,	x12
    add	x7,	sp,	x7
    sub	w28,	w26,	w27
    add	x25,	sp,	x25
    lsl	w27,	w0,	#2
    add	x7,	x7,	#16
    mov	x26,	x27
    str	w28,	[x20]

    add	x25,	x25,	#16
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    movz	fp,	#40016
    ldr	w28,	[x26]

    mul	w11,	w28,	w28
    sdiv	w22,	w11,	w15
    mov	x15,	x4
    lsl	w5,	w22,	#1
    add	x15,	sp,	x15
    add	w18,	w5,	w22,	lsl #3
    mov	x5,	x6
    add	x15,	x15,	#16
    add	x5,	sp,	x5
    sub	w1,	w11,	w18
    movz	w11,	#10
    add	x5,	x5,	fp
    str	w1,	[x7]

    movz	fp,	#40016
    ldr	w7,	[x5]

    mul	w22,	w7,	w7
    sdiv	w18,	w22,	w13
    lsl	w6,	w18,	#1
    add	w14,	w6,	w18,	lsl #3
    sub	w9,	w22,	w14
    lsl	w14,	w21,	#2
    mov	x13,	x14
    str	w9,	[x15]

    add	x13,	sp,	x13
    movz	w9,	#10
    add	x13,	x13,	fp
    movz	fp,	#40016
    ldr	w15,	[x13]

    mul	w1,	w15,	w15
    sdiv	w14,	w1,	w11
    lsl	w7,	w14,	#1
    add	w10,	w7,	w14,	lsl #3
    add	w7,	w21,	#1
    sub	w17,	w1,	w10
    add	w16,	w7,	#1
    lsl	w22,	w7,	#2
    lsl	w20,	w7,	#2
    mov	x21,	x22
    str	w17,	[x25]

    movz	w7,	#10
    lsl	w1,	w16,	#2
    lsl	w28,	w16,	#2
    mov	x14,	x20
    add	x21,	sp,	x21
    mov	x0,	x1
    mov	x19,	x28
    add	x14,	sp,	x14
    add	x0,	sp,	x0
    add	x21,	x21,	fp
    add	x19,	sp,	x19
    movz	fp,	#40016
    add	x14,	x14,	#16
    ldr	w23,	[x21]

    add	x19,	x19,	#16
    add	x0,	x0,	fp
    mul	w13,	w23,	w23
    movz	fp,	#40016
    sdiv	w10,	w13,	w9
    lsl	w8,	w10,	#1
    add	w6,	w8,	w10,	lsl #3
    sub	w25,	w13,	w6
    str	w25,	[x14]

    add	w25,	w16,	#1
    ldr	w2,	[x0]

    mul	w21,	w2,	w2
    sdiv	w5,	w21,	w7
    lsl	w7,	w25,	#2
    lsl	w9,	w5,	#1
    mov	x28,	x7
    add	w2,	w9,	w5,	lsl #3
    add	x28,	sp,	x28
    movz	w5,	#10
    lsl	w9,	w25,	#2
    mov	x8,	x9
    sub	w4,	w21,	w2
    add	x28,	x28,	#16
    add	x8,	sp,	x8
    add	w21,	w25,	#1
    movz	w25,	#10000
    str	w4,	[x19]

    lsl	w17,	w21,	#2
    lsl	w15,	w21,	#2
    add	x8,	x8,	fp
    mov	x16,	x17
    mov	x19,	x15
    movz	fp,	#40016
    add	x16,	sp,	x16
    add	x19,	sp,	x19
    ldr	w10,	[x8]

    mul	w0,	w10,	w10
    add	x16,	x16,	fp
    add	x19,	x19,	#16
    sdiv	w1,	w0,	w5
    lsl	w10,	w1,	#1
    add	w27,	w10,	w1,	lsl #3
    sub	w12,	w0,	w27
    str	w12,	[x28]

    ldr	w18,	[x16]

    mul	w9,	w18,	w18
    sdiv	w26,	w9,	w3
    lsl	w11,	w26,	#1
    add	w23,	w11,	w26,	lsl #3
    sub	w20,	w9,	w23
    add	w9,	w21,	#1
    str	w20,	[x19]

    cmp	w9,	w25
    blt	main_324

main_375:
    movz	w24,	#0

main_376:
    movz	w1,	#10000
    cmp	w24,	w1
    bge	main_524

main_379:
    lsl	w4,	w24,	#2
    movz	fp,	#14480
    lsl	w6,	w24,	#2
    movz	w20,	#100
    movz	w19,	#100
    lsl	w11,	w24,	#2
    add	w27,	w24,	#1
    movz	w18,	#100
    movz	w17,	#100
    mov	x2,	x4
    movk	fp,	#1,	lsl #16
    mov	x5,	x6
    mov	x10,	x11
    lsl	w15,	w27,	#2
    lsl	w8,	w27,	#2
    add	x2,	sp,	x2
    add	x5,	sp,	x5
    add	x10,	sp,	x10
    mov	x14,	x15
    mov	x24,	x8
    add	x2,	x2,	fp
    movz	w15,	#100
    add	x5,	x5,	#16
    add	x14,	sp,	x14
    add	x24,	sp,	x24
    movz	fp,	#40016
    ldr	w7,	[x5]

    add	x10,	x10,	fp
    mul	w21,	w7,	w7
    movz	fp,	#14480
    sdiv	w7,	w21,	w20
    movk	fp,	#1,	lsl #16
    ldr	w12,	[x10]

    msub	w22,	w7,	w19,	w21

    add	x24,	x24,	fp
    lsl	w10,	w27,	#2
    add	w13,	w12,	w22
    movz	fp,	#40016
    mov	x9,	x10
    add	x14,	x14,	fp
    add	w10,	w27,	#1
    str	w13,	[x2]

    add	x9,	sp,	x9
    movz	fp,	#14480
    movz	w13,	#100
    add	w8,	w10,	#1
    lsl	w27,	w10,	#2
    lsl	w22,	w10,	#2
    lsl	w20,	w10,	#2
    add	x9,	x9,	#16
    movk	fp,	#1,	lsl #16
    lsl	w5,	w8,	#2
    lsl	w3,	w8,	#2
    mov	x26,	x27
    mov	x21,	x22
    lsl	w10,	w8,	#2
    ldr	w11,	[x9]

    mov	x25,	x3
    add	x26,	sp,	x26
    add	x21,	sp,	x21
    ldr	w16,	[x14]

    mul	w4,	w11,	w11
    add	w3,	w8,	#1
    add	x25,	sp,	x25
    movz	w14,	#100
    add	x21,	x21,	#16
    sdiv	w18,	w4,	w18
    lsl	w22,	w3,	#2
    msub	w9,	w18,	w17,	w4

    mov	x4,	x20
    add	w17,	w16,	w9
    add	x4,	sp,	x4
    mov	x9,	x10
    movz	w16,	#100
    movz	w10,	#100
    str	w17,	[x24]

    add	x9,	sp,	x9
    add	x4,	x4,	fp
    lsl	w17,	w3,	#2
    ldr	w23,	[x21]

    movz	fp,	#40016
    mul	w23,	w23,	w23
    add	x26,	x26,	fp
    sdiv	w12,	w23,	w16
    movz	fp,	#14480
    mov	x16,	x17
    msub	w21,	w12,	w15,	w23

    movk	fp,	#1,	lsl #16
    ldr	w28,	[x26]

    add	x16,	sp,	x16
    lsl	w15,	w3,	#2
    add	x25,	x25,	fp
    add	w0,	w28,	w21
    movz	fp,	#40016
    add	x16,	x16,	#16
    mov	x28,	x15
    add	x9,	x9,	fp
    add	x28,	sp,	x28
    str	w0,	[x4]

    movz	fp,	#14480
    mov	x4,	x5
    movk	fp,	#1,	lsl #16
    add	x4,	sp,	x4
    add	x28,	x28,	fp
    movz	fp,	#40016
    add	x4,	x4,	#16
    ldr	w6,	[x4]

    ldr	w11,	[x9]

    mul	w6,	w6,	w6
    movz	w9,	#100
    sdiv	w7,	w6,	w14
    msub	w7,	w7,	w13,	w6

    add	w12,	w11,	w7
    movz	w11,	#100
    str	w12,	[x25]

    movz	w12,	#100
    ldr	w18,	[x16]

    mul	w21,	w18,	w18
    sdiv	w2,	w21,	w12
    msub	w19,	w2,	w11,	w21

    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w23,	[x21]

    add	w24,	w23,	w19
    str	w24,	[x28]

    add	w24,	w3,	#1
    lsl	w5,	w24,	#2
    lsl	w0,	w24,	#2
    add	w23,	w24,	#1
    lsl	w27,	w24,	#2
    mov	x28,	x0
    mov	x20,	x27
    add	x28,	sp,	x28
    add	x20,	sp,	x20
    add	w3,	w23,	#1
    lsl	w17,	w23,	#2
    lsl	w12,	w23,	#2
    mov	x16,	x17
    add	x28,	x28,	#16
    add	x20,	x20,	fp
    lsl	w0,	w3,	#2
    lsl	w24,	w3,	#2
    lsl	w22,	w3,	#2
    mov	x11,	x12
    add	x16,	sp,	x16
    ldr	w1,	[x28]

    movz	fp,	#40016
    add	x11,	sp,	x11
    mov	x28,	x0
    mul	w4,	w1,	w1
    add	x28,	sp,	x28
    sdiv	w26,	w4,	w10
    add	x11,	x11,	#16
    lsl	w10,	w23,	#2
    msub	w8,	w26,	w9,	w4

    mov	x23,	x24
    mov	x4,	x5
    add	x23,	sp,	x23
    mov	x5,	x10
    add	x4,	sp,	x4
    add	x5,	sp,	x5
    add	x23,	x23,	#16
    add	x4,	x4,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w6,	[x4]

    add	x5,	x5,	fp
    movz	w4,	#100
    add	w7,	w6,	w8
    movz	fp,	#40016
    movz	w6,	#100
    movz	w8,	#100
    add	x16,	x16,	fp
    str	w7,	[x20]

    movz	fp,	#14480
    movz	w7,	#100
    ldr	w13,	[x11]

    movk	fp,	#1,	lsl #16
    mov	x11,	x22
    mul	w18,	w13,	w13
    add	x11,	sp,	x11
    sdiv	w21,	w18,	w8
    msub	w20,	w21,	w7,	w18

    add	x11,	x11,	fp
    ldr	w18,	[x16]

    movz	fp,	#40016
    add	w19,	w18,	w20
    add	x28,	x28,	fp
    str	w19,	[x5]

    movz	fp,	#14480
    movz	w5,	#100
    ldr	w25,	[x23]

    movk	fp,	#1,	lsl #16
    ldr	w1,	[x28]

    mul	w2,	w25,	w25
    movz	w28,	#100
    sdiv	w16,	w2,	w6
    msub	w5,	w16,	w5,	w2

    add	w2,	w1,	w5
    movz	w1,	#100
    str	w2,	[x11]

    add	w2,	w3,	#1
    movz	w3,	#100
    lsl	w7,	w2,	#2
    lsl	w5,	w2,	#2
    add	w27,	w2,	#1
    lsl	w12,	w2,	#2
    mov	x6,	x7
    mov	x22,	x5
    movz	w2,	#100
    add	x6,	sp,	x6
    lsl	w24,	w27,	#2
    lsl	w19,	w27,	#2
    add	x22,	sp,	x22
    mov	x23,	x24
    add	x6,	x6,	#16
    add	x23,	sp,	x23
    add	x22,	x22,	fp
    ldr	w8,	[x6]

    movz	fp,	#40016
    mul	w17,	w8,	w8
    sdiv	w11,	w17,	w4
    msub	w18,	w11,	w3,	w17

    lsl	w17,	w27,	#2
    mov	x11,	x12
    mov	x9,	x17
    add	x11,	sp,	x11
    add	x9,	sp,	x9
    add	x11,	x11,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w13,	[x11]

    add	x9,	x9,	fp
    add	w11,	w27,	#1
    add	w14,	w13,	w18
    movz	fp,	#40016
    mov	x18,	x19
    add	w4,	w11,	#1
    lsl	w7,	w11,	#2
    str	w14,	[x22]

    add	x23,	x23,	fp
    add	x18,	sp,	x18
    movz	fp,	#14480
    lsl	w19,	w4,	#2
    lsl	w12,	w4,	#2
    lsl	w14,	w4,	#2
    movk	fp,	#1,	lsl #16
    add	x18,	x18,	#16
    mov	x22,	x12
    mov	x13,	x14
    add	x22,	sp,	x22
    add	x13,	sp,	x13
    ldr	w20,	[x18]

    mov	x18,	x19
    ldr	w25,	[x23]

    add	x13,	x13,	#16
    mul	w0,	w20,	w20
    add	x18,	sp,	x18
    sdiv	w6,	w0,	w2
    lsl	w2,	w11,	#2
    msub	w1,	w6,	w1,	w0

    mov	x6,	x7
    lsl	w0,	w11,	#2
    add	w26,	w25,	w1
    add	x6,	sp,	x6
    mov	x27,	x0
    mov	x1,	x2
    movz	w0,	#100
    add	x27,	sp,	x27
    str	w26,	[x9]

    add	x1,	sp,	x1
    movz	w26,	#100
    add	x27,	x27,	fp
    add	x1,	x1,	#16
    movz	fp,	#40016
    add	x6,	x6,	fp
    ldr	w3,	[x1]

    movz	fp,	#14480
    mul	w5,	w3,	w3
    movk	fp,	#1,	lsl #16
    ldr	w8,	[x6]

    sdiv	w0,	w5,	w0
    add	x22,	x22,	fp
    msub	w16,	w0,	w28,	w5

    movz	fp,	#40016
    add	w9,	w8,	w16
    add	w16,	w4,	#1
    add	x18,	x18,	fp
    str	w9,	[x27]

    movz	fp,	#14480
    lsl	w2,	w16,	#2
    lsl	w24,	w16,	#2
    movz	w27,	#100
    ldr	w15,	[x13]

    movk	fp,	#1,	lsl #16
    mov	x1,	x2
    mov	x9,	x24
    ldr	w20,	[x18]

    mul	w25,	w15,	w15
    add	x1,	sp,	x1
    movz	w24,	#100
    add	x9,	sp,	x9
    sdiv	w23,	w25,	w27
    msub	w28,	w23,	w26,	w25

    add	x9,	x9,	fp
    movz	w23,	#100
    lsl	w26,	w16,	#2
    add	w21,	w20,	w28
    movz	fp,	#40016
    mov	x25,	x26
    add	x25,	sp,	x25
    str	w21,	[x22]

    add	x1,	x1,	fp
    movz	w22,	#100
    movz	fp,	#14480
    add	x25,	x25,	#16
    movk	fp,	#1,	lsl #16
    ldr	w27,	[x25]

    ldr	w3,	[x1]

    movz	w25,	#100
    mul	w10,	w27,	w27
    sdiv	w18,	w10,	w25
    msub	w14,	w18,	w24,	w10

    movz	w18,	#100
    add	w24,	w16,	#1
    add	w4,	w3,	w14
    add	w12,	w24,	#1
    lsl	w7,	w24,	#2
    lsl	w14,	w24,	#2
    str	w4,	[x9]

    mov	x28,	x7
    lsl	w9,	w24,	#2
    lsl	w21,	w12,	#2
    lsl	w19,	w12,	#2
    add	x28,	sp,	x28
    mov	x8,	x9
    mov	x20,	x21
    add	x8,	sp,	x8
    movz	w21,	#100
    add	x20,	sp,	x20
    add	x28,	x28,	fp
    add	x8,	x8,	#16
    movz	fp,	#40016
    add	x20,	x20,	#16
    ldr	w10,	[x8]

    mul	w25,	w10,	w10
    sdiv	w13,	w25,	w23
    msub	w26,	w13,	w22,	w25

    mov	x13,	x14
    add	x13,	sp,	x13
    add	x13,	x13,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w15,	[x13]

    mov	x13,	x19
    add	w16,	w15,	w26
    movz	w19,	#100
    add	x13,	sp,	x13
    add	w15,	w12,	#1
    lsl	w26,	w12,	#2
    str	w16,	[x28]

    mov	x25,	x26
    add	x13,	x13,	fp
    ldr	w22,	[x20]

    lsl	w4,	w15,	#2
    lsl	w2,	w15,	#2
    add	x25,	sp,	x25
    movz	fp,	#40016
    movz	w20,	#100
    mul	w9,	w22,	w22
    mov	x3,	x4
    mov	x12,	x2
    add	x25,	x25,	fp
    sdiv	w8,	w9,	w21
    add	x3,	sp,	x3
    add	x12,	sp,	x12
    movz	fp,	#14480
    msub	w9,	w8,	w20,	w9

    ldr	w27,	[x25]

    movk	fp,	#1,	lsl #16
    add	x3,	x3,	#16
    add	w28,	w27,	w9
    add	x12,	x12,	fp
    lsl	w9,	w15,	#2
    movz	fp,	#40016
    mov	x8,	x9
    str	w28,	[x13]

    add	x8,	sp,	x8
    ldr	w5,	[x3]

    mul	w23,	w5,	w5
    add	x8,	x8,	fp
    sdiv	w3,	w23,	w19
    msub	w24,	w3,	w18,	w23

    ldr	w10,	[x8]

    add	w11,	w10,	w24
    add	w24,	w15,	#1
    str	w11,	[x12]

    b	main_376

main_524:
    movz	w25,	#0
    movz	w28,	#0

main_526:
    cmp	w25,	#10
    bge	main_535

main_530:
    lsl	w24,	w25,	#2
    movz	fp,	#14480
    movz	w0,	#1333
    mov	x23,	x24
    movk	fp,	#1,	lsl #16
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w26,	[x23]

    add	w21,	w26,	w28
    movz	w28,	#1333
    sdiv	w0,	w21,	w0
    msub	w28,	w0,	w28,	w21

    mov	w0,	w28
    bl	putint
    b	main_792

main_535:
    cmp	w25,	#20
    bge	main_752

main_537:
    lsl	w26,	w25,	#2
    movz	fp,	#14480
    movz	w0,	#5000
    mov	x24,	x26
    movk	fp,	#1,	lsl #16
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w22,	[x24]


main_540:
    movz	w23,	#9992
    cmp	w0,	w23
    bge	main_707

main_544:
    add	w21,	w22,	w28
    lsl	w15,	w0,	#2
    movz	fp,	#40016
    add	w17,	w0,	#1
    mov	x14,	x15
    add	x14,	sp,	x14
    add	w26,	w17,	#1
    lsl	w9,	w17,	#2
    mov	x8,	x9
    add	x14,	x14,	fp
    add	x8,	sp,	x8
    add	w3,	w26,	#1
    lsl	w15,	w26,	#2
    movz	fp,	#40016
    ldr	w16,	[x14]

    add	w11,	w3,	#1
    add	x8,	x8,	fp
    mov	x14,	x15
    sub	w23,	w21,	w16
    movz	fp,	#40016
    add	x14,	sp,	x14
    ldr	w10,	[x8]

    add	w19,	w11,	#1
    lsl	w0,	w11,	#2
    lsl	w21,	w3,	#2
    add	w4,	w22,	w23
    add	x14,	x14,	fp
    lsl	w6,	w19,	#2
    mov	x28,	x0
    mov	x20,	x21
    movz	fp,	#40016
    ldr	w16,	[x14]

    sub	w23,	w4,	w10
    mov	x5,	x6
    add	x28,	sp,	x28
    add	x20,	sp,	x20
    add	x5,	sp,	x5
    add	w10,	w22,	w23
    add	x20,	x20,	fp
    sub	w2,	w10,	w16
    movz	fp,	#40016
    ldr	w23,	[x20]

    add	x28,	x28,	fp
    add	w16,	w22,	w2
    movz	fp,	#40016
    ldr	w1,	[x28]

    add	x5,	x5,	fp
    sub	w8,	w16,	w23
    add	w28,	w19,	#1
    movz	fp,	#40016
    ldr	w7,	[x5]

    add	w26,	w22,	w8
    lsl	w12,	w28,	#2
    add	w5,	w28,	#1
    mov	x11,	x12
    add	x11,	sp,	x11
    sub	w14,	w26,	w1
    lsl	w18,	w5,	#2
    add	x11,	x11,	fp
    mov	x17,	x18
    add	w4,	w22,	w14
    movz	fp,	#40016
    add	x17,	sp,	x17
    ldr	w13,	[x11]

    sub	w20,	w4,	w7
    add	w11,	w5,	#1
    add	x17,	x17,	fp
    movz	fp,	#40016
    add	w10,	w22,	w20
    lsl	w26,	w11,	#2
    ldr	w19,	[x17]

    mov	x24,	x26
    add	x24,	sp,	x24
    sub	w0,	w10,	w13
    add	x24,	x24,	fp
    add	w16,	w22,	w0
    movz	fp,	#40016
    ldr	w27,	[x24]

    sub	w6,	w16,	w19
    add	w23,	w22,	w6
    sub	w12,	w23,	w27
    add	w23,	w11,	#1
    add	w7,	w22,	w12
    add	w1,	w23,	#1
    lsl	w3,	w23,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    lsl	w9,	w1,	#2
    mov	x8,	x9
    add	x2,	x2,	fp
    add	x8,	sp,	x8
    movz	fp,	#40016
    ldr	w4,	[x2]

    add	x8,	x8,	fp
    sub	w19,	w7,	w4
    movz	fp,	#40016
    ldr	w10,	[x8]

    add	w13,	w22,	w19
    add	w8,	w1,	#1
    sub	w27,	w13,	w10
    lsl	w15,	w8,	#2
    mov	x14,	x15
    add	x14,	sp,	x14
    add	w19,	w22,	w27
    add	x14,	x14,	fp
    movz	fp,	#40016
    ldr	w16,	[x14]

    add	w14,	w8,	#1
    sub	w4,	w19,	w16
    add	w24,	w14,	#1
    lsl	w21,	w14,	#2
    add	w27,	w22,	w4
    mov	x20,	x21
    add	x20,	sp,	x20
    add	w3,	w24,	#1
    lsl	w0,	w24,	#2
    mov	x28,	x0
    add	x20,	x20,	fp
    add	x28,	sp,	x28
    movz	fp,	#40016
    ldr	w23,	[x20]

    add	x28,	x28,	fp
    sub	w10,	w27,	w23
    movz	fp,	#40016
    ldr	w1,	[x28]

    add	w6,	w22,	w10
    add	w10,	w3,	#1
    sub	w17,	w6,	w1
    add	w16,	w10,	#1
    lsl	w12,	w10,	#2
    lsl	w6,	w3,	#2
    mov	x11,	x12
    add	w13,	w22,	w17
    mov	x5,	x6
    add	w28,	w16,	#1
    lsl	w18,	w16,	#2
    add	x11,	sp,	x11
    add	x5,	sp,	x5
    mov	x17,	x18
    lsl	w26,	w28,	#2
    add	x17,	sp,	x17
    add	x5,	x5,	fp
    movz	fp,	#40016
    ldr	w7,	[x5]

    add	x11,	x11,	fp
    sub	w24,	w13,	w7
    movz	fp,	#40016
    ldr	w13,	[x11]

    add	x17,	x17,	fp
    add	w19,	w22,	w24
    movz	fp,	#40016
    mov	x24,	x26
    add	x24,	sp,	x24
    sub	w2,	w19,	w13
    ldr	w19,	[x17]

    add	x24,	x24,	fp
    add	w27,	w22,	w2
    movz	fp,	#40016
    sub	w8,	w27,	w19
    ldr	w27,	[x24]

    add	w4,	w22,	w8
    add	w8,	w28,	#1
    sub	w15,	w4,	w27
    lsl	w3,	w8,	#2
    mov	x2,	x3
    add	w13,	w22,	w15
    add	x2,	sp,	x2
    add	w15,	w8,	#1
    add	x2,	x2,	fp
    lsl	w9,	w15,	#2
    movz	fp,	#40016
    mov	x8,	x9
    ldr	w4,	[x2]

    add	x8,	sp,	x8
    sub	w21,	w13,	w4
    add	x8,	x8,	fp
    add	w19,	w22,	w21
    movz	fp,	#40016
    add	w21,	w15,	#1
    ldr	w10,	[x8]

    sub	w0,	w19,	w10
    add	w1,	w21,	#1
    lsl	w15,	w21,	#2
    mov	x14,	x15
    add	w27,	w22,	w0
    add	x14,	sp,	x14
    add	w9,	w1,	#1
    lsl	w21,	w1,	#2
    mov	x20,	x21
    add	x14,	x14,	fp
    add	x20,	sp,	x20
    lsl	w0,	w9,	#2
    movz	fp,	#40016
    mov	x28,	x0
    ldr	w16,	[x14]

    add	x20,	x20,	fp
    add	x28,	sp,	x28
    sub	w7,	w27,	w16
    movz	fp,	#40016
    add	w16,	w9,	#1
    ldr	w23,	[x20]

    add	w4,	w22,	w7
    add	x28,	x28,	fp
    add	w24,	w16,	#1
    lsl	w6,	w16,	#2
    movz	fp,	#40016
    mov	x5,	x6
    ldr	w1,	[x28]

    sub	w13,	w4,	w23
    add	w3,	w24,	#1
    add	x5,	sp,	x5
    add	w12,	w22,	w13
    add	w9,	w3,	#1
    lsl	w18,	w3,	#2
    add	x5,	x5,	fp
    mov	x17,	x18
    sub	w19,	w12,	w1
    movz	fp,	#40016
    lsl	w26,	w9,	#2
    add	w18,	w9,	#1
    add	x17,	sp,	x17
    ldr	w7,	[x5]

    lsl	w12,	w24,	#2
    add	w19,	w22,	w19
    add	w28,	w18,	#1
    lsl	w3,	w18,	#2
    mov	x24,	x26
    mov	x11,	x12
    sub	w27,	w19,	w7
    mov	x2,	x3
    add	w6,	w28,	#1
    lsl	w9,	w28,	#2
    add	x24,	sp,	x24
    add	x11,	sp,	x11
    add	w27,	w22,	w27
    add	x2,	sp,	x2
    add	w12,	w6,	#1
    lsl	w15,	w6,	#2
    mov	x8,	x9
    add	x11,	x11,	fp
    mov	x14,	x15
    add	x8,	sp,	x8
    lsl	w21,	w12,	#2
    movz	fp,	#40016
    ldr	w13,	[x11]

    add	x14,	sp,	x14
    mov	x20,	x21
    add	x17,	x17,	fp
    sub	w5,	w27,	w13
    add	w21,	w12,	#1
    add	x20,	sp,	x20
    movz	fp,	#40016
    ldr	w19,	[x17]

    add	w4,	w22,	w5
    lsl	w0,	w21,	#2
    add	x24,	x24,	fp
    mov	x28,	x0
    movz	fp,	#40016
    add	w0,	w21,	#1
    sub	w11,	w4,	w19
    add	x28,	sp,	x28
    ldr	w27,	[x24]

    add	x2,	x2,	fp
    movz	fp,	#40016
    add	w10,	w22,	w11
    ldr	w4,	[x2]

    add	x8,	x8,	fp
    movz	fp,	#40016
    sub	w16,	w10,	w27
    add	x14,	x14,	fp
    ldr	w10,	[x8]

    movz	fp,	#40016
    add	w19,	w22,	w16
    add	x20,	x20,	fp
    ldr	w16,	[x14]

    movz	fp,	#40016
    sub	w23,	w19,	w4
    add	x28,	x28,	fp
    add	w27,	w22,	w23
    ldr	w23,	[x20]

    ldr	w1,	[x28]

    sub	w2,	w27,	w10
    add	w4,	w22,	w2
    sub	w8,	w4,	w16
    add	w10,	w22,	w8
    sub	w14,	w10,	w23
    add	w18,	w22,	w14
    sub	w28,	w18,	w1
    b	main_540

main_707:
    add	w3,	w22,	w28
    lsl	w27,	w0,	#2
    movz	fp,	#40016
    add	w9,	w0,	#1
    mov	x26,	x27
    add	x26,	sp,	x26
    add	w15,	w9,	#1
    lsl	w12,	w9,	#2
    mov	x11,	x12
    add	x26,	x26,	fp
    add	x11,	sp,	x11
    add	w21,	w15,	#1
    lsl	w18,	w15,	#2
    movz	fp,	#40016
    mov	x17,	x18
    ldr	w28,	[x26]

    add	x17,	sp,	x17
    add	w5,	w21,	#1
    add	x11,	x11,	fp
    lsl	w26,	w21,	#2
    sub	w14,	w3,	w28
    movz	fp,	#40016
    mov	x24,	x26
    ldr	w13,	[x11]

    lsl	w3,	w5,	#2
    add	w4,	w22,	w14
    add	x17,	x17,	fp
    add	x24,	sp,	x24
    mov	x2,	x3
    movz	fp,	#40016
    add	x2,	sp,	x2
    ldr	w19,	[x17]

    sub	w6,	w4,	w13
    add	x24,	x24,	fp
    movz	fp,	#40016
    add	w10,	w22,	w6
    ldr	w27,	[x24]

    add	x2,	x2,	fp
    movz	fp,	#40016
    sub	w12,	w10,	w19
    ldr	w4,	[x2]

    add	w16,	w22,	w12
    add	w12,	w5,	#1
    sub	w19,	w16,	w27
    add	w18,	w12,	#1
    lsl	w9,	w12,	#2
    mov	x8,	x9
    add	w27,	w22,	w19
    add	x8,	sp,	x8
    lsl	w15,	w18,	#2
    mov	x14,	x15
    sub	w27,	w27,	w4
    add	x8,	x8,	fp
    add	x14,	sp,	x14
    movz	fp,	#40016
    ldr	w10,	[x8]

    add	w4,	w22,	w27
    add	x14,	x14,	fp
    add	w27,	w18,	#1
    movz	fp,	#40016
    sub	w4,	w4,	w10
    ldr	w16,	[x14]

    add	w0,	w27,	#1
    lsl	w21,	w27,	#2
    add	w10,	w22,	w4
    mov	x20,	x21
    movz	w4,	#10000
    add	x20,	sp,	x20
    sub	w10,	w10,	w16
    add	x20,	x20,	fp
    add	w16,	w22,	w10
    ldr	w23,	[x20]

    sub	w28,	w16,	w23
    cmp	w0,	w4
    blt	main_707

main_751:
    mov	w0,	w28
    bl	putint
    b	main_792

main_752:
    cmp	w25,	#30
    bge	main_782

main_754:
    lsl	w1,	w25,	#2
    lsl	w26,	w25,	#2
    movz	fp,	#40016
    movz	w3,	#5000
    mov	x0,	x1
    mov	x24,	x26
    add	x0,	sp,	x0
    add	x24,	sp,	x24
    add	x0,	x0,	#16
    add	x24,	x24,	fp
    ldr	w13,	[x0]

    ldr	w14,	[x24]


main_760:
    cmp	w3,	#2233
    ble	main_770

main_764:
    add	w18,	w13,	w28
    lsl	w20,	w3,	#2
    movz	fp,	#40016
    add	w3,	w3,	#1
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w21,	[x19]

    sub	w28,	w18,	w21
    b	main_777

main_770:
    add	w24,	w28,	w14
    lsl	w27,	w3,	#2
    movz	fp,	#14480
    movz	w6,	#13333
    movz	w5,	#13333
    add	w3,	w3,	#2
    mov	x26,	x27
    movk	fp,	#1,	lsl #16
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    ldr	w28,	[x26]

    add	w7,	w24,	w28
    sdiv	w4,	w7,	w6
    msub	w28,	w4,	w5,	w7


main_777:
    movz	w19,	#10000
    cmp	w3,	w19
    blt	main_760

main_781:
    mov	w0,	w28
    bl	putint
    b	main_792

main_782:
    lsl	w22,	w25,	#2
    movz	fp,	#14480
    movz	w12,	#34452
    mov	x21,	x22
    movk	fp,	#1,	lsl #16
    movk	w12,	#1,	lsl #16
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w17,	[x21]

    lsl	w27,	w17,	#0
    add	w24,	w27,	w17,	lsl #3
    add	w21,	w24,	w28
    sdiv	w10,	w21,	w12
    msub	w28,	w10,	w12,	w21


main_792:
    add	w25,	w25,	#1
    movz	w14,	#10000
    cmp	w25,	w14
    blt	main_526

main_796:
    mov	w0,	w28
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    add	sp, sp, fp
    ret


