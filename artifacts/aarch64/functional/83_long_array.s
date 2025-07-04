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
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w27,	#0

main_4:
    movz	w1,	#9984
    cmp	w27,	w1
    blt	main_7

main_138:
    lsl	w20,	w27,	#2
    movz	fp,	#40016
    mul	w9,	w27,	w27
    movz	w15,	#10
    add	w2,	w27,	#1
    movz	w3,	#10
    movz	w1,	#10
    mov	x5,	x20
    sdiv	w26,	w9,	w15
    add	x5,	sp,	x5
    mul	w11,	w2,	w2
    add	w20,	w2,	#1
    lsl	w14,	w26,	#1
    sdiv	w21,	w11,	w3
    add	x5,	x5,	fp
    lsl	w28,	w21,	#1
    add	w13,	w20,	#1
    mul	w17,	w20,	w20
    lsl	w10,	w20,	#2
    add	w25,	w14,	w26,	lsl #3
    movz	fp,	#40016
    sdiv	w19,	w17,	w1
    add	w24,	w13,	#1
    lsl	w15,	w13,	#2
    mov	x10,	x10
    add	w26,	w28,	w21,	lsl #3
    sub	w22,	w9,	w25
    lsl	w0,	w19,	#1
    mov	x14,	x15
    add	x10,	sp,	x10
    movz	w28,	#10
    sub	w7,	w11,	w26
    str	w22,	[x5]

    add	w23,	w0,	w19,	lsl #3
    add	x14,	sp,	x14
    movz	w26,	#10
    lsl	w5,	w2,	#2
    mul	w0,	w24,	w24
    sub	w12,	w17,	w23
    mov	x4,	x5
    mul	w23,	w13,	w13
    add	x4,	sp,	x4
    sdiv	w13,	w0,	w26
    sdiv	w16,	w23,	w28
    lsl	w2,	w13,	#1
    lsl	w1,	w16,	#1
    add	x4,	x4,	fp
    add	w20,	w1,	w16,	lsl #3
    movz	fp,	#40016
    str	w7,	[x4]

    add	x10,	x10,	fp
    sub	w17,	w23,	w20
    movz	fp,	#40016
    lsl	w20,	w24,	#2
    str	w12,	[x10]

    add	x14,	x14,	fp
    mov	x23,	x20
    movz	fp,	#40016
    movz	w20,	#10
    add	x23,	sp,	x23
    str	w17,	[x14]

    add	w17,	w2,	w13,	lsl #3
    add	x23,	x23,	fp
    add	w2,	w24,	#1
    movz	fp,	#40016
    movz	w24,	#10
    sub	w22,	w0,	w17
    mul	w6,	w2,	w2
    lsl	w25,	w2,	#2
    add	w12,	w2,	#1
    sdiv	w10,	w6,	w24
    str	w22,	[x23]

    mov	x0,	x25
    movz	w2,	#10000
    lsl	w3,	w10,	#1
    mul	w13,	w12,	w12
    lsl	w1,	w12,	#2
    add	w24,	w12,	#1
    movz	w22,	#10
    add	x0,	sp,	x0
    add	w14,	w3,	w10,	lsl #3
    mov	x8,	x1
    sdiv	w7,	w13,	w22
    mul	w18,	w24,	w24
    add	x8,	sp,	x8
    add	x0,	x0,	fp
    sub	w27,	w6,	w14
    lsl	w4,	w7,	#1
    movz	fp,	#40016
    lsl	w6,	w24,	#2
    str	w27,	[x0]

    add	w11,	w4,	w7,	lsl #3
    add	x8,	x8,	fp
    mov	x23,	x6
    add	w27,	w24,	#1
    movz	fp,	#40016
    sub	w3,	w13,	w11
    add	x23,	sp,	x23
    str	w3,	[x8]

    add	x23,	x23,	fp
    sdiv	w3,	w18,	w20
    lsl	w5,	w3,	#1
    add	w8,	w5,	w3,	lsl #3
    sub	w8,	w18,	w8
    str	w8,	[x23]

    cmp	w27,	w2
    blt	main_138

main_173:
    movz	w0,	#0

main_174:
    movz	w28,	#9984
    cmp	w0,	w28
    blt	main_177

main_324:
    lsl	w7,	w0,	#2
    lsl	w9,	w0,	#2
    movz	fp,	#40016
    movz	w4,	#10
    add	w6,	w0,	#1
    movz	w19,	#10
    movz	w17,	#10
    movz	w15,	#10
    mov	x13,	x7
    mov	x8,	x9
    add	w27,	w6,	#1
    lsl	w21,	w6,	#2
    add	x13,	sp,	x13
    add	x8,	sp,	x8
    lsl	w2,	w27,	#2
    add	x13,	x13,	#16
    add	x8,	x8,	fp
    mov	x1,	x2
    movz	fp,	#40016
    add	x1,	sp,	x1
    ldr	w10,	[x8]

    mov	x8,	x21
    mul	w10,	w10,	w10
    add	x8,	sp,	x8
    sdiv	w5,	w10,	w4
    lsl	w23,	w5,	#1
    add	x8,	x8,	#16
    add	w3,	w23,	w5,	lsl #3
    lsl	w23,	w6,	#2
    mov	x22,	x23
    sub	w12,	w10,	w3
    add	x22,	sp,	x22
    str	w12,	[x13]

    add	x22,	x22,	fp
    movz	fp,	#40016
    ldr	w24,	[x22]

    add	x1,	x1,	fp
    mul	w10,	w24,	w24
    movz	fp,	#40016
    sdiv	w26,	w10,	w19
    lsl	w7,	w26,	#1
    add	w0,	w7,	w26,	lsl #3
    sub	w26,	w10,	w0
    lsl	w0,	w27,	#2
    mov	x4,	x0
    str	w26,	[x8]

    add	x4,	sp,	x4
    ldr	w3,	[x1]

    mul	w18,	w3,	w3
    add	x4,	x4,	#16
    add	w3,	w27,	#1
    sdiv	w22,	w18,	w17
    lsl	w8,	w22,	#1
    lsl	w10,	w3,	#2
    add	w25,	w8,	w22,	lsl #3
    mov	x9,	x10
    lsl	w8,	w3,	#2
    add	x9,	sp,	x9
    mov	x1,	x8
    sub	w5,	w18,	w25
    add	x1,	sp,	x1
    add	x9,	x9,	fp
    movz	fp,	#40016
    str	w5,	[x4]

    add	x1,	x1,	#16
    ldr	w11,	[x9]

    mul	w28,	w11,	w11
    sdiv	w18,	w28,	w15
    add	w15,	w3,	#1
    lsl	w9,	w18,	#1
    add	w21,	w9,	w18,	lsl #3
    lsl	w16,	w15,	#2
    lsl	w18,	w15,	#2
    mov	x11,	x16
    mov	x17,	x18
    sub	w13,	w28,	w21
    add	x11,	sp,	x11
    add	x17,	sp,	x17
    add	w28,	w15,	#1
    str	w13,	[x1]

    add	x11,	x11,	#16
    add	x17,	x17,	fp
    lsl	w26,	w28,	#2
    lsl	w24,	w28,	#2
    movz	w13,	#10
    movz	fp,	#40016
    mov	x25,	x26
    ldr	w19,	[x17]

    mov	x22,	x24
    add	x25,	sp,	x25
    mul	w7,	w19,	w19
    add	x22,	sp,	x22
    sdiv	w14,	w7,	w13
    lsl	w10,	w14,	#1
    add	x25,	x25,	fp
    add	x22,	x22,	#16
    add	w17,	w10,	w14,	lsl #3
    movz	fp,	#40016
    sub	w21,	w7,	w17
    movz	w7,	#10
    str	w21,	[x11]

    add	w21,	w28,	#1
    movz	w11,	#10
    ldr	w27,	[x25]

    mul	w8,	w27,	w27
    lsl	w5,	w21,	#2
    lsl	w3,	w21,	#2
    add	w25,	w21,	#1
    sdiv	w9,	w8,	w11
    mov	x4,	x5
    lsl	w11,	w9,	#1
    add	x4,	sp,	x4
    add	w13,	w11,	w9,	lsl #3
    lsl	w11,	w25,	#2
    movz	w9,	#10
    add	x4,	x4,	fp
    mov	x20,	x11
    sub	w0,	w8,	w13
    movz	fp,	#40016
    add	x20,	sp,	x20
    mov	x13,	x3
    add	x13,	sp,	x13
    str	w0,	[x22]

    add	x20,	x20,	#16
    add	w0,	w25,	#1
    add	x13,	x13,	#16
    ldr	w6,	[x4]

    mul	w19,	w6,	w6
    sdiv	w5,	w19,	w9
    lsl	w12,	w5,	#1
    add	w9,	w12,	w5,	lsl #3
    sub	w8,	w19,	w9
    str	w8,	[x13]

    lsl	w13,	w25,	#2
    mov	x12,	x13
    add	x12,	sp,	x12
    add	x12,	x12,	fp
    ldr	w14,	[x12]

    mul	w9,	w14,	w14
    sdiv	w1,	w9,	w7
    lsl	w13,	w1,	#1
    add	w5,	w13,	w1,	lsl #3
    movz	w1,	#10000
    sub	w16,	w9,	w5
    str	w16,	[x20]

    cmp	w0,	w1
    blt	main_324

main_375:
    movz	w24,	#0

main_376:
    movz	w5,	#10000
    cmp	w24,	w5
    blt	main_379

main_524:
    movz	w24,	#0
    movz	w27,	#0

main_526:
    cmp	w24,	#10
    blt	main_530

main_535:
    cmp	w24,	#20
    blt	main_537

main_752:
    cmp	w24,	#30
    blt	main_754

main_782:
    lsl	w17,	w24,	#2
    movz	fp,	#14480
    movz	w4,	#34452
    mov	x16,	x17
    movk	fp,	#1,	lsl #16
    movk	w4,	#1,	lsl #16
    add	x16,	sp,	x16
    add	x16,	x16,	fp
    ldr	w8,	[x16]

    lsl	w25,	w8,	#0
    add	w19,	w25,	w8,	lsl #3
    add	w12,	w19,	w27
    sdiv	w10,	w12,	w4
    msub	w27,	w10,	w4,	w12

    b	main_792

main_754:
    lsl	w23,	w24,	#2
    movz	fp,	#40016
    lsl	w17,	w24,	#2
    movz	w28,	#5000
    mov	x22,	x23
    mov	x16,	x17
    add	x22,	sp,	x22
    add	x16,	sp,	x16
    add	x22,	x22,	fp
    add	x16,	x16,	#16
    ldr	w2,	[x22]

    ldr	w19,	[x16]


main_760:
    cmp	w28,	#2233
    bgt	main_764

main_770:
    add	w25,	w27,	w2
    lsl	w5,	w28,	#2
    movz	fp,	#14480
    movz	w23,	#13333
    movz	w22,	#13333
    add	w28,	w28,	#2
    mov	x4,	x5
    movk	fp,	#1,	lsl #16
    add	x4,	sp,	x4
    add	x4,	x4,	fp
    ldr	w6,	[x4]

    add	w3,	w25,	w6
    sdiv	w0,	w3,	w23
    msub	w27,	w0,	w22,	w3

    b	main_777

main_764:
    add	w5,	w19,	w27
    lsl	w12,	w28,	#2
    movz	fp,	#40016
    add	w28,	w28,	#1
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	fp
    ldr	w13,	[x11]

    sub	w27,	w5,	w13

main_777:
    movz	w16,	#10000
    cmp	w28,	w16
    blt	main_760

main_781:
    mov	w0,	w27
    bl	putint
    b	main_792

main_537:
    lsl	w17,	w24,	#2
    movz	fp,	#14480
    movz	w5,	#5000
    mov	x16,	x17
    movk	fp,	#1,	lsl #16
    add	x16,	sp,	x16
    add	x16,	x16,	fp
    ldr	w3,	[x16]


main_540:
    movz	w19,	#9992
    cmp	w5,	w19
    blt	main_544

main_707:
    add	w2,	w3,	w27
    lsl	w15,	w5,	#2
    movz	fp,	#40016
    add	w27,	w5,	#1
    mov	x14,	x15
    add	x14,	sp,	x14
    add	w6,	w27,	#1
    lsl	w1,	w27,	#2
    mov	x0,	x1
    add	x14,	x14,	fp
    add	x0,	sp,	x0
    add	w12,	w6,	#1
    lsl	w8,	w6,	#2
    movz	fp,	#40016
    mov	x7,	x8
    ldr	w16,	[x14]

    add	x7,	sp,	x7
    add	w22,	w12,	#1
    add	x0,	x0,	fp
    lsl	w14,	w12,	#2
    sub	w28,	w2,	w16
    movz	fp,	#40016
    mov	x13,	x14
    lsl	w20,	w22,	#2
    ldr	w2,	[x0]

    add	w15,	w3,	w28
    add	x7,	x7,	fp
    add	x13,	sp,	x13
    mov	x19,	x20
    add	w0,	w22,	#1
    movz	fp,	#40016
    ldr	w9,	[x7]

    sub	w23,	w15,	w2
    movz	w20,	#10000
    add	x19,	sp,	x19
    add	w10,	w0,	#1
    lsl	w27,	w0,	#2
    add	x13,	x13,	fp
    add	w21,	w3,	w23
    mov	x26,	x27
    movz	fp,	#40016
    add	w16,	w10,	#1
    lsl	w5,	w10,	#2
    ldr	w15,	[x13]

    sub	w1,	w21,	w9
    add	x26,	sp,	x26
    add	x19,	x19,	fp
    lsl	w11,	w16,	#2
    mov	x4,	x5
    add	w28,	w3,	w1
    movz	fp,	#40016
    ldr	w21,	[x19]

    mov	x10,	x11
    add	w5,	w16,	#1
    add	x4,	sp,	x4
    sub	w8,	w28,	w15
    add	x26,	x26,	fp
    add	x10,	sp,	x10
    movz	fp,	#40016
    ldr	w28,	[x26]

    add	w6,	w3,	w8
    add	x4,	x4,	fp
    movz	fp,	#40016
    sub	w15,	w6,	w21
    add	x10,	x10,	fp
    ldr	w6,	[x4]

    add	w12,	w3,	w15
    sub	w21,	w12,	w28
    ldr	w12,	[x10]

    add	w21,	w3,	w21
    sub	w28,	w21,	w6
    add	w28,	w3,	w28
    sub	w27,	w28,	w12
    cmp	w5,	w20
    blt	main_707

main_751:
    mov	w0,	w27
    bl	putint
    b	main_792

main_544:
    add	w7,	w3,	w27
    lsl	w12,	w5,	#2
    movz	fp,	#40016
    add	w4,	w5,	#1
    mov	x11,	x12
    add	x11,	sp,	x11
    lsl	w25,	w4,	#2
    mov	x23,	x25
    add	x11,	x11,	fp
    add	x23,	sp,	x23
    movz	fp,	#40016
    ldr	w13,	[x11]

    add	x23,	x23,	fp
    sub	w27,	w7,	w13
    movz	fp,	#40016
    ldr	w26,	[x23]

    add	w13,	w3,	w27
    sub	w20,	w13,	w26
    add	w13,	w4,	#1
    add	w22,	w3,	w20
    add	w21,	w13,	#1
    lsl	w2,	w13,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	w28,	w21,	#1
    lsl	w9,	w21,	#2
    mov	x8,	x9
    add	x1,	x1,	fp
    add	x8,	sp,	x8
    add	w6,	w28,	#1
    lsl	w15,	w28,	#2
    movz	fp,	#40016
    mov	x14,	x15
    ldr	w4,	[x1]

    add	x14,	sp,	x14
    lsl	w21,	w6,	#2
    add	x8,	x8,	fp
    sub	w27,	w22,	w4
    mov	x20,	x21
    movz	fp,	#40016
    add	x20,	sp,	x20
    ldr	w10,	[x8]

    add	w0,	w3,	w27
    add	x14,	x14,	fp
    movz	fp,	#40016
    ldr	w16,	[x14]

    sub	w5,	w0,	w10
    add	x20,	x20,	fp
    movz	fp,	#40016
    add	w7,	w3,	w5
    ldr	w22,	[x20]

    sub	w12,	w7,	w16
    add	w13,	w3,	w12
    sub	w18,	w13,	w22
    add	w13,	w6,	#1
    add	w20,	w3,	w18
    add	w23,	w13,	#1
    lsl	w28,	w13,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	w1,	w23,	#1
    lsl	w6,	w23,	#2
    mov	x5,	x6
    add	x27,	x27,	fp
    add	x5,	sp,	x5
    add	w8,	w1,	#1
    lsl	w12,	w1,	#2
    movz	fp,	#40016
    mov	x11,	x12
    ldr	w0,	[x27]

    add	x11,	sp,	x11
    add	w14,	w8,	#1
    lsl	w18,	w8,	#2
    add	x5,	x5,	fp
    sub	w25,	w20,	w0
    mov	x17,	x18
    movz	fp,	#40016
    add	w6,	w14,	#1
    add	x17,	sp,	x17
    ldr	w7,	[x5]

    add	w0,	w3,	w25
    add	x11,	x11,	fp
    lsl	w25,	w14,	#2
    add	w12,	w6,	#1
    lsl	w2,	w6,	#2
    sub	w4,	w0,	w7
    movz	fp,	#40016
    ldr	w13,	[x11]

    mov	x23,	x25
    add	w18,	w12,	#1
    lsl	w9,	w12,	#2
    mov	x1,	x2
    add	w7,	w3,	w4
    add	x17,	x17,	fp
    add	x23,	sp,	x23
    add	w25,	w18,	#1
    lsl	w15,	w18,	#2
    mov	x8,	x9
    add	x1,	sp,	x1
    sub	w10,	w7,	w13
    movz	fp,	#40016
    ldr	w19,	[x17]

    add	w5,	w25,	#1
    lsl	w21,	w25,	#2
    mov	x14,	x15
    add	x8,	sp,	x8
    add	w13,	w3,	w10
    add	x23,	x23,	fp
    lsl	w28,	w5,	#2
    mov	x20,	x21
    add	x14,	sp,	x14
    sub	w16,	w13,	w19
    movz	fp,	#40016
    ldr	w26,	[x23]

    mov	x27,	x28
    add	x20,	sp,	x20
    add	x1,	x1,	fp
    add	w19,	w3,	w16
    add	x27,	sp,	x27
    movz	fp,	#40016
    ldr	w4,	[x1]

    sub	w22,	w19,	w26
    add	x8,	x8,	fp
    movz	fp,	#40016
    ldr	w10,	[x8]

    add	w0,	w3,	w22
    add	x14,	x14,	fp
    movz	fp,	#40016
    sub	w0,	w0,	w4
    ldr	w16,	[x14]

    add	x20,	x20,	fp
    movz	fp,	#40016
    add	w7,	w3,	w0
    ldr	w22,	[x20]

    add	x27,	x27,	fp
    movz	fp,	#40016
    sub	w7,	w7,	w10
    ldr	w0,	[x27]

    add	w13,	w3,	w7
    sub	w13,	w13,	w16
    add	w19,	w3,	w13
    add	w13,	w5,	#1
    sub	w20,	w19,	w22
    lsl	w6,	w13,	#2
    add	w19,	w13,	#1
    mov	x5,	x6
    add	w1,	w3,	w20
    add	x5,	sp,	x5
    add	w26,	w19,	#1
    lsl	w12,	w19,	#2
    mov	x11,	x12
    sub	w27,	w1,	w0
    add	x5,	x5,	fp
    lsl	w18,	w26,	#2
    add	x11,	sp,	x11
    movz	fp,	#40016
    mov	x17,	x18
    ldr	w7,	[x5]

    add	w10,	w3,	w27
    add	x11,	x11,	fp
    add	x17,	sp,	x17
    movz	fp,	#40016
    sub	w5,	w10,	w7
    ldr	w13,	[x11]

    add	x17,	x17,	fp
    movz	fp,	#40016
    add	w16,	w3,	w5
    ldr	w19,	[x17]

    add	w5,	w26,	#1
    sub	w11,	w16,	w13
    add	w14,	w5,	#1
    lsl	w25,	w5,	#2
    mov	x23,	x25
    add	w22,	w3,	w11
    add	x23,	sp,	x23
    add	w20,	w14,	#1
    lsl	w2,	w14,	#2
    mov	x1,	x2
    sub	w18,	w22,	w19
    add	x23,	x23,	fp
    add	w27,	w20,	#1
    lsl	w9,	w20,	#2
    add	x1,	sp,	x1
    movz	fp,	#40016
    ldr	w26,	[x23]

    add	w0,	w3,	w18
    add	w6,	w27,	#1
    lsl	w15,	w27,	#2
    mov	x8,	x9
    add	x1,	x1,	fp
    sub	w25,	w0,	w26
    mov	x14,	x15
    add	w13,	w6,	#1
    lsl	w21,	w6,	#2
    add	x8,	sp,	x8
    movz	fp,	#40016
    ldr	w4,	[x1]

    add	w10,	w3,	w25
    add	x14,	sp,	x14
    lsl	w28,	w13,	#2
    mov	x20,	x21
    add	x8,	x8,	fp
    sub	w2,	w10,	w4
    mov	x27,	x28
    add	w21,	w13,	#1
    add	x20,	sp,	x20
    movz	fp,	#40016
    ldr	w10,	[x8]

    add	w16,	w3,	w2
    add	x27,	sp,	x27
    add	w28,	w21,	#1
    lsl	w6,	w21,	#2
    add	x14,	x14,	fp
    mov	x5,	x6
    sub	w9,	w16,	w10
    movz	fp,	#40016
    lsl	w12,	w28,	#2
    add	x5,	sp,	x5
    ldr	w16,	[x14]

    add	x20,	x20,	fp
    add	w22,	w3,	w9
    mov	x11,	x12
    movz	fp,	#40016
    add	x11,	sp,	x11
    sub	w16,	w22,	w16
    add	x27,	x27,	fp
    ldr	w22,	[x20]

    movz	fp,	#40016
    add	w0,	w3,	w16
    add	x5,	x5,	fp
    movz	fp,	#40016
    sub	w22,	w0,	w22
    add	x11,	x11,	fp
    ldr	w0,	[x27]

    movz	fp,	#40016
    ldr	w7,	[x5]

    add	w8,	w3,	w22
    ldr	w13,	[x11]

    sub	w0,	w8,	w0
    add	w16,	w3,	w0
    sub	w7,	w16,	w7
    add	w22,	w3,	w7
    add	w7,	w28,	#1
    sub	w14,	w22,	w13
    lsl	w18,	w7,	#2
    add	w13,	w7,	#1
    mov	x17,	x18
    add	w0,	w3,	w14
    add	x17,	sp,	x17
    lsl	w25,	w13,	#2
    mov	x23,	x25
    add	x17,	x17,	fp
    add	x23,	sp,	x23
    movz	fp,	#40016
    ldr	w19,	[x17]

    add	x23,	x23,	fp
    sub	w20,	w0,	w19
    movz	fp,	#40016
    ldr	w26,	[x23]

    add	w7,	w3,	w20
    add	w23,	w13,	#1
    sub	w27,	w7,	w26
    lsl	w2,	w23,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	w16,	w3,	w27
    add	x1,	x1,	fp
    movz	fp,	#40016
    ldr	w4,	[x1]

    add	w1,	w23,	#1
    sub	w6,	w16,	w4
    lsl	w9,	w1,	#2
    add	w22,	w3,	w6
    mov	x8,	x9
    add	w9,	w1,	#1
    add	x8,	sp,	x8
    add	w5,	w9,	#1
    lsl	w15,	w9,	#2
    add	x8,	x8,	fp
    mov	x14,	x15
    movz	fp,	#40016
    add	x14,	sp,	x14
    ldr	w10,	[x8]

    add	x14,	x14,	fp
    sub	w12,	w22,	w10
    ldr	w16,	[x14]

    add	w0,	w3,	w12
    sub	w27,	w0,	w16
    b	main_540

main_530:
    lsl	w25,	w24,	#2
    movz	fp,	#14480
    movz	w20,	#1333
    movz	w19,	#1333
    mov	x23,	x25
    movk	fp,	#1,	lsl #16
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w26,	[x23]

    add	w22,	w26,	w27
    sdiv	w20,	w22,	w20
    msub	w27,	w20,	w19,	w22

    mov	w0,	w27
    bl	putint

main_792:
    add	w24,	w24,	#1
    movz	w12,	#10000
    cmp	w24,	w12
    blt	main_526

main_796:
    mov	w0,	w27
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    add	sp, sp, fp
    ret


main_379:
    lsl	w18,	w24,	#2
    movz	fp,	#14480
    lsl	w20,	w24,	#2
    movz	w1,	#100
    movz	w0,	#100
    lsl	w26,	w24,	#2
    add	w15,	w24,	#1
    mov	x10,	x18
    movk	fp,	#1,	lsl #16
    mov	x19,	x20
    mov	x25,	x26
    movz	w24,	#100
    add	w13,	w15,	#1
    lsl	w3,	w15,	#2
    add	x10,	sp,	x10
    add	x19,	sp,	x19
    add	x25,	sp,	x25
    mov	x2,	x3
    lsl	w8,	w13,	#2
    add	x2,	sp,	x2
    add	x10,	x10,	fp
    add	x19,	x19,	#16
    mov	x12,	x8
    movz	fp,	#40016
    add	x12,	sp,	x12
    ldr	w21,	[x19]

    add	x25,	x25,	fp
    movz	w19,	#100
    mul	w27,	w21,	w21
    movz	fp,	#14480
    sdiv	w9,	w27,	w1
    movk	fp,	#1,	lsl #16
    msub	w28,	w9,	w0,	w27

    ldr	w27,	[x25]

    lsl	w25,	w15,	#2
    add	w28,	w27,	w28
    mov	x22,	x25
    lsl	w27,	w15,	#2
    movz	w25,	#100
    add	x22,	sp,	x22
    str	w28,	[x10]

    lsl	w15,	w13,	#2
    mov	x26,	x27
    lsl	w10,	w13,	#2
    add	x22,	x22,	fp
    mov	x14,	x15
    movz	w27,	#100
    add	x26,	sp,	x26
    mov	x9,	x10
    movz	fp,	#40016
    add	x14,	sp,	x14
    add	x9,	sp,	x9
    add	x26,	x26,	#16
    add	x2,	x2,	fp
    movz	fp,	#14480
    add	x9,	x9,	#16
    movk	fp,	#1,	lsl #16
    ldr	w28,	[x26]

    add	x12,	x12,	fp
    movz	w26,	#100
    ldr	w4,	[x2]

    mul	w16,	w28,	w28
    movz	fp,	#40016
    movz	w28,	#100
    add	x14,	x14,	fp
    sdiv	w23,	w16,	w28
    movz	fp,	#14480
    msub	w20,	w23,	w27,	w16

    movk	fp,	#1,	lsl #16
    add	w5,	w4,	w20
    str	w5,	[x22]

    ldr	w11,	[x9]

    ldr	w16,	[x14]

    mul	w2,	w11,	w11
    movz	w14,	#100
    sdiv	w18,	w2,	w26
    msub	w3,	w18,	w25,	w2

    add	w2,	w13,	#1
    add	w17,	w16,	w3
    lsl	w27,	w2,	#2
    lsl	w22,	w2,	#2
    lsl	w20,	w2,	#2
    str	w17,	[x12]

    mov	x26,	x27
    mov	x21,	x22
    add	w2,	w2,	#1
    mov	x3,	x20
    add	x26,	sp,	x26
    movz	w22,	#100
    add	x21,	sp,	x21
    movz	w20,	#100
    add	x3,	sp,	x3
    lsl	w10,	w2,	#2
    lsl	w5,	w2,	#2
    mov	x9,	x10
    add	x21,	x21,	#16
    mov	x4,	x5
    add	x3,	x3,	fp
    add	x9,	sp,	x9
    add	x4,	sp,	x4
    movz	fp,	#40016
    ldr	w23,	[x21]

    add	x26,	x26,	fp
    movz	w21,	#100
    add	x4,	x4,	#16
    mul	w15,	w23,	w23
    movz	fp,	#14480
    movz	w23,	#100
    ldr	w28,	[x26]

    sdiv	w13,	w15,	w24
    movk	fp,	#1,	lsl #16
    msub	w15,	w13,	w23,	w15

    add	w0,	w28,	w15
    str	w0,	[x3]

    ldr	w6,	[x4]

    lsl	w3,	w2,	#2
    mul	w0,	w6,	w6
    mov	x26,	x3
    sdiv	w8,	w0,	w22
    add	x26,	sp,	x26
    msub	w1,	w8,	w21,	w0

    add	x26,	x26,	fp
    movz	fp,	#40016
    add	x9,	x9,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w11,	[x9]

    add	w9,	w2,	#1
    add	w12,	w11,	w1
    lsl	w22,	w9,	#2
    lsl	w17,	w9,	#2
    lsl	w15,	w9,	#2
    str	w12,	[x26]

    mov	x21,	x22
    mov	x16,	x17
    add	w9,	w9,	#1
    mov	x15,	x15
    add	x21,	sp,	x21
    movz	w17,	#100
    add	x16,	sp,	x16
    add	x15,	sp,	x15
    lsl	w5,	w9,	#2
    lsl	w0,	w9,	#2
    lsl	w27,	w9,	#2
    mov	x4,	x5
    add	x16,	x16,	#16
    add	x15,	x15,	fp
    mov	x28,	x0
    add	x4,	sp,	x4
    movz	fp,	#40016
    add	w0,	w9,	#1
    ldr	w18,	[x16]

    add	x28,	sp,	x28
    add	x21,	x21,	fp
    movz	w16,	#100
    lsl	w12,	w0,	#2
    lsl	w10,	w0,	#2
    mul	w13,	w18,	w18
    add	x28,	x28,	#16
    movz	fp,	#14480
    ldr	w23,	[x21]

    mov	x11,	x12
    movz	w18,	#100
    sdiv	w3,	w13,	w20
    movk	fp,	#1,	lsl #16
    mov	x21,	x10
    movz	w12,	#100
    add	x11,	sp,	x11
    msub	w13,	w3,	w19,	w13

    add	x21,	sp,	x21
    add	w24,	w23,	w13
    mov	x13,	x27
    add	x11,	x11,	#16
    add	x13,	sp,	x13
    str	w24,	[x15]

    movz	w15,	#100
    ldr	w1,	[x28]

    add	x13,	x13,	fp
    mul	w26,	w1,	w1
    movz	fp,	#40016
    sdiv	w27,	w26,	w18
    msub	w28,	w27,	w17,	w26

    add	x4,	x4,	fp
    lsl	w17,	w0,	#2
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w6,	[x4]

    add	x21,	x21,	fp
    movz	w4,	#100
    add	w7,	w6,	w28
    movz	fp,	#40016
    str	w7,	[x13]

    ldr	w13,	[x11]

    mul	w10,	w13,	w13
    movz	w13,	#100
    sdiv	w22,	w10,	w16
    mov	x16,	x17
    msub	w11,	w22,	w15,	w10

    add	x16,	sp,	x16
    movz	w10,	#100
    add	x16,	x16,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w18,	[x16]

    add	w16,	w0,	#1
    add	w19,	w18,	w11
    movz	w11,	#100
    str	w19,	[x21]

    lsl	w0,	w16,	#2
    lsl	w24,	w16,	#2
    lsl	w22,	w16,	#2
    mov	x28,	x0
    mov	x23,	x24
    mov	x8,	x22
    add	x28,	sp,	x28
    add	x23,	sp,	x23
    add	x8,	sp,	x8
    add	x23,	x23,	#16
    add	x8,	x8,	fp
    movz	fp,	#40016
    ldr	w25,	[x23]

    add	x28,	x28,	fp
    mul	w25,	w25,	w25
    movz	fp,	#14480
    sdiv	w17,	w25,	w14
    movk	fp,	#1,	lsl #16
    ldr	w1,	[x28]

    msub	w25,	w17,	w13,	w25

    movz	w28,	#100
    add	w17,	w16,	#1
    add	w2,	w1,	w25
    lsl	w7,	w17,	#2
    lsl	w5,	w17,	#2
    str	w2,	[x8]

    mov	x6,	x7
    mov	x1,	x5
    movz	w7,	#100
    add	x6,	sp,	x6
    add	w5,	w17,	#1
    add	x1,	sp,	x1
    add	x6,	x6,	#16
    lsl	w24,	w5,	#2
    lsl	w19,	w5,	#2
    add	x1,	x1,	fp
    mov	x18,	x19
    movz	fp,	#40016
    ldr	w8,	[x6]

    add	x18,	sp,	x18
    mul	w3,	w8,	w8
    movz	w8,	#100
    sdiv	w12,	w3,	w12
    add	x18,	x18,	#16
    msub	w9,	w12,	w11,	w3

    lsl	w12,	w17,	#2
    lsl	w17,	w5,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w13,	[x11]

    add	w11,	w5,	#1
    add	w14,	w13,	w9
    movz	w5,	#100
    movz	w9,	#100
    str	w14,	[x1]

    lsl	w2,	w11,	#2
    lsl	w0,	w11,	#2
    ldr	w20,	[x18]

    mov	x1,	x17
    mul	w23,	w20,	w20
    add	x1,	sp,	x1
    sdiv	w6,	w23,	w10
    msub	w21,	w6,	w9,	w23

    mov	x23,	x24
    add	x1,	x1,	fp
    mov	x24,	x0
    add	x23,	sp,	x23
    movz	fp,	#40016
    movz	w0,	#100
    add	x24,	sp,	x24
    add	x23,	x23,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w25,	[x23]

    add	x24,	x24,	fp
    add	w26,	w25,	w21
    movz	fp,	#40016
    str	w26,	[x1]

    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    mul	w9,	w3,	w3
    movz	w3,	#100
    sdiv	w1,	w9,	w8
    msub	w10,	w1,	w7,	w9

    lsl	w7,	w11,	#2
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x6,	x6,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w8,	[x6]

    movz	w6,	#100
    add	w9,	w8,	w10
    str	w9,	[x24]

    add	w24,	w11,	#1
    lsl	w19,	w24,	#2
    lsl	w14,	w24,	#2
    add	w7,	w24,	#1
    lsl	w12,	w24,	#2
    mov	x18,	x19
    mov	x13,	x14
    mov	x9,	x12
    add	x18,	sp,	x18
    lsl	w2,	w7,	#2
    lsl	w26,	w7,	#2
    lsl	w24,	w7,	#2
    add	x13,	sp,	x13
    add	x9,	sp,	x9
    mov	x1,	x2
    mov	x14,	x24
    movz	w2,	#100
    add	x13,	x13,	#16
    add	x1,	sp,	x1
    add	x9,	x9,	fp
    add	x14,	sp,	x14
    movz	fp,	#40016
    ldr	w15,	[x13]

    add	x18,	x18,	fp
    mul	w20,	w15,	w15
    movz	fp,	#14480
    sdiv	w25,	w20,	w6
    movk	fp,	#1,	lsl #16
    msub	w22,	w25,	w5,	w20

    mov	x25,	x26
    ldr	w20,	[x18]

    add	x14,	x14,	fp
    add	x25,	sp,	x25
    add	w21,	w20,	w22
    movz	fp,	#40016
    add	x25,	x25,	#16
    add	x1,	x1,	fp
    str	w21,	[x9]

    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w27,	[x25]

    mul	w6,	w27,	w27
    sdiv	w20,	w6,	w4
    msub	w8,	w20,	w3,	w6

    add	w6,	w7,	#1
    ldr	w3,	[x1]

    movz	w1,	#100
    add	w4,	w3,	w8
    add	w12,	w6,	#1
    lsl	w9,	w6,	#2
    lsl	w7,	w6,	#2
    str	w4,	[x14]

    mov	x8,	x9
    mov	x24,	x7
    lsl	w26,	w12,	#2
    lsl	w21,	w12,	#2
    lsl	w14,	w6,	#2
    add	x8,	sp,	x8
    add	x24,	sp,	x24
    mov	x25,	x26
    mov	x13,	x14
    add	x25,	sp,	x25
    add	x8,	x8,	#16
    add	x13,	sp,	x13
    add	x24,	x24,	fp
    movz	fp,	#40016
    ldr	w10,	[x8]

    add	x13,	x13,	fp
    mul	w19,	w10,	w10
    movz	fp,	#14480
    sdiv	w15,	w19,	w2
    movk	fp,	#1,	lsl #16
    msub	w20,	w15,	w1,	w19

    lsl	w19,	w12,	#2
    ldr	w15,	[x13]

    add	w16,	w15,	w20
    mov	x20,	x21
    add	x20,	sp,	x20
    str	w16,	[x24]

    add	w24,	w12,	#1
    mov	x16,	x19
    add	x20,	x20,	#16
    add	x16,	sp,	x16
    ldr	w22,	[x20]

    add	x16,	x16,	fp
    mul	w3,	w22,	w22
    movz	fp,	#40016
    sdiv	w9,	w3,	w0
    add	x25,	x25,	fp
    msub	w3,	w9,	w28,	w3

    ldr	w27,	[x25]

    add	w28,	w27,	w3
    str	w28,	[x16]

    b	main_376

main_177:
    lsl	w15,	w0,	#2
    lsl	w17,	w0,	#2
    movz	fp,	#40016
    movz	w20,	#10
    mov	x7,	x15
    mov	x16,	x17
    add	x7,	sp,	x7
    add	x16,	sp,	x16
    add	x7,	x7,	#16
    add	x16,	x16,	fp
    movz	fp,	#40016
    ldr	w18,	[x16]

    mul	w22,	w18,	w18
    movz	w18,	#10
    sdiv	w25,	w22,	w20
    lsl	w4,	w25,	#1
    add	w14,	w4,	w25,	lsl #3
    sub	w20,	w22,	w14
    add	w14,	w0,	#1
    str	w20,	[x7]

    add	w26,	w14,	#1
    lsl	w12,	w14,	#2
    lsl	w10,	w14,	#2
    mov	x11,	x12
    movz	w14,	#10
    mov	x21,	x10
    lsl	w20,	w26,	#2
    add	w12,	w26,	#1
    add	x11,	sp,	x11
    add	x21,	sp,	x21
    mov	x19,	x20
    add	w22,	w12,	#1
    add	x19,	sp,	x19
    add	x11,	x11,	fp
    add	x21,	x21,	#16
    movz	fp,	#40016
    lsl	w5,	w22,	#2
    ldr	w13,	[x11]

    add	x19,	x19,	fp
    mul	w27,	w13,	w13
    movz	fp,	#40016
    sdiv	w8,	w27,	w18
    lsl	w18,	w26,	#2
    lsl	w16,	w8,	#1
    lsl	w26,	w12,	#2
    mov	x1,	x18
    add	w3,	w16,	w8,	lsl #3
    add	x1,	sp,	x1
    movz	w16,	#10
    sub	w15,	w27,	w3
    add	x1,	x1,	#16
    str	w15,	[x21]

    ldr	w21,	[x19]

    mul	w7,	w21,	w21
    mov	x21,	x26
    sdiv	w4,	w7,	w16
    add	x21,	sp,	x21
    lsl	w17,	w4,	#1
    add	w28,	w17,	w4,	lsl #3
    add	x21,	x21,	#16
    add	w4,	w22,	#1
    sub	w23,	w7,	w28
    lsl	w15,	w4,	#2
    lsl	w13,	w4,	#2
    lsl	w7,	w22,	#2
    lsl	w28,	w12,	#2
    str	w23,	[x1]

    mov	x13,	x13
    mov	x6,	x7
    movz	w12,	#10
    mov	x27,	x28
    add	x13,	sp,	x13
    add	x6,	sp,	x6
    add	x27,	sp,	x27
    add	x13,	x13,	#16
    add	x27,	x27,	fp
    movz	fp,	#40016
    ldr	w0,	[x27]

    add	x6,	x6,	fp
    mul	w16,	w0,	w0
    movz	fp,	#40016
    sdiv	w0,	w16,	w14
    mov	x14,	x15
    lsl	w18,	w0,	#1
    add	x14,	sp,	x14
    add	w24,	w18,	w0,	lsl #3
    add	x14,	x14,	fp
    sub	w2,	w16,	w24
    movz	fp,	#40016
    mov	x24,	x5
    add	x24,	sp,	x24
    str	w2,	[x21]

    ldr	w8,	[x6]

    add	x24,	x24,	#16
    movz	w6,	#10
    mul	w26,	w8,	w8
    movz	w8,	#10
    sdiv	w25,	w26,	w12
    lsl	w19,	w25,	#1
    add	w20,	w19,	w25,	lsl #3
    sub	w10,	w26,	w20
    str	w10,	[x24]

    movz	w10,	#10
    ldr	w16,	[x14]

    mul	w5,	w16,	w16
    sdiv	w21,	w5,	w10
    lsl	w20,	w21,	#1
    add	w16,	w20,	w21,	lsl #3
    add	w20,	w4,	#1
    sub	w18,	w5,	w16
    add	w10,	w20,	#1
    lsl	w23,	w20,	#2
    lsl	w21,	w20,	#2
    mov	x22,	x23
    str	w18,	[x13]

    mov	x17,	x21
    lsl	w2,	w10,	#2
    lsl	w0,	w10,	#2
    add	x22,	sp,	x22
    add	x17,	sp,	x17
    mov	x1,	x2
    mov	x4,	x0
    movz	w2,	#10
    add	x1,	sp,	x1
    add	x22,	x22,	fp
    add	x17,	x17,	#16
    add	x4,	sp,	x4
    movz	fp,	#40016
    ldr	w24,	[x22]

    add	x1,	x1,	fp
    add	x4,	x4,	#16
    mul	w15,	w24,	w24
    movz	fp,	#40016
    sdiv	w16,	w15,	w8
    lsl	w21,	w16,	#1
    add	w12,	w21,	w16,	lsl #3
    sub	w26,	w15,	w12
    add	w15,	w10,	#1
    str	w26,	[x17]

    lsl	w10,	w15,	#2
    ldr	w3,	[x1]

    mov	x9,	x10
    add	w1,	w15,	#1
    mul	w25,	w3,	w3
    add	x9,	sp,	x9
    sdiv	w12,	w25,	w6
    lsl	w18,	w1,	#2
    lsl	w16,	w1,	#2
    add	x9,	x9,	fp
    lsl	w22,	w12,	#1
    mov	x17,	x18
    mov	x26,	x16
    movz	fp,	#40016
    add	w8,	w22,	w12,	lsl #3
    add	x17,	sp,	x17
    add	x26,	sp,	x26
    sub	w5,	w25,	w8
    add	x17,	x17,	fp
    add	x26,	x26,	#16
    lsl	w8,	w15,	#2
    movz	fp,	#40016
    str	w5,	[x4]

    mov	x21,	x8
    movz	w4,	#10
    ldr	w11,	[x9]

    add	x21,	sp,	x21
    mul	w0,	w11,	w11
    sdiv	w8,	w0,	w4
    lsl	w23,	w8,	#1
    add	x21,	x21,	#16
    add	w4,	w23,	w8,	lsl #3
    add	w8,	w1,	#1
    sub	w13,	w0,	w4
    str	w13,	[x21]

    ldr	w19,	[x17]

    mul	w15,	w19,	w19
    sdiv	w4,	w15,	w2
    lsl	w24,	w4,	#1
    add	w0,	w24,	w4,	lsl #3
    lsl	w24,	w8,	#2
    mov	x23,	x24
    sub	w21,	w15,	w0
    add	x23,	sp,	x23
    movz	w0,	#10
    str	w21,	[x26]

    add	x23,	x23,	#16
    lsl	w26,	w8,	#2
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    movz	fp,	#40016
    ldr	w27,	[x25]

    mul	w6,	w27,	w27
    movz	w27,	#10
    sdiv	w0,	w6,	w0
    lsl	w25,	w0,	#1
    add	w25,	w25,	w0,	lsl #3
    sub	w0,	w6,	w25
    add	w25,	w8,	#1
    str	w0,	[x23]

    add	w7,	w25,	#1
    lsl	w5,	w25,	#2
    lsl	w3,	w25,	#2
    movz	w23,	#10
    mov	x4,	x5
    movz	w25,	#10
    lsl	w13,	w7,	#2
    lsl	w11,	w7,	#2
    mov	x18,	x3
    add	x4,	sp,	x4
    mov	x12,	x13
    mov	x1,	x11
    add	x18,	sp,	x18
    add	x12,	sp,	x12
    add	x4,	x4,	fp
    add	x1,	sp,	x1
    movz	fp,	#40016
    add	x18,	x18,	#16
    ldr	w6,	[x4]

    add	x1,	x1,	#16
    add	x12,	x12,	fp
    mul	w3,	w6,	w6
    movz	fp,	#40016
    sdiv	w24,	w3,	w27
    lsl	w26,	w24,	#1
    add	w21,	w26,	w24,	lsl #3
    sub	w8,	w3,	w21
    str	w8,	[x18]

    ldr	w14,	[x12]

    mul	w11,	w14,	w14
    sdiv	w20,	w11,	w25
    lsl	w27,	w20,	#1
    add	w17,	w27,	w20,	lsl #3
    sub	w16,	w11,	w17
    add	w17,	w7,	#1
    str	w16,	[x1]

    lsl	w21,	w17,	#2
    lsl	w19,	w17,	#2
    mov	x20,	x21
    mov	x12,	x19
    add	x20,	sp,	x20
    movz	w19,	#10
    add	x12,	sp,	x12
    add	x20,	x20,	fp
    add	x12,	x12,	#16
    movz	fp,	#40016
    ldr	w22,	[x20]

    mul	w21,	w22,	w22
    add	w22,	w17,	#1
    sdiv	w16,	w21,	w23
    lsl	w28,	w16,	#1
    lsl	w0,	w22,	#2
    lsl	w27,	w22,	#2
    add	w13,	w28,	w16,	lsl #3
    mov	x23,	x27
    mov	x28,	x0
    add	x23,	sp,	x23
    add	x28,	sp,	x28
    sub	w24,	w21,	w13
    add	x23,	x23,	#16
    movz	w21,	#10
    add	x28,	x28,	fp
    str	w24,	[x12]

    movz	fp,	#40016
    ldr	w1,	[x28]

    mul	w3,	w1,	w1
    sdiv	w13,	w3,	w21
    add	w21,	w22,	#1
    lsl	w0,	w13,	#1
    add	w9,	w0,	w13,	lsl #3
    lsl	w8,	w21,	#2
    lsl	w6,	w21,	#2
    add	w0,	w21,	#1
    mov	x7,	x8
    sub	w3,	w3,	w9
    mov	x14,	x6
    add	x7,	sp,	x7
    add	x14,	sp,	x14
    lsl	w16,	w0,	#2
    str	w3,	[x23]

    mov	x15,	x16
    add	x7,	x7,	fp
    add	x14,	x14,	#16
    add	x15,	sp,	x15
    movz	fp,	#40016
    ldr	w9,	[x7]

    add	x15,	x15,	fp
    mul	w13,	w9,	w9
    movz	fp,	#40016
    sdiv	w9,	w13,	w19
    lsl	w1,	w9,	#1
    add	w5,	w1,	w9,	lsl #3
    sub	w11,	w13,	w5
    movz	w13,	#10
    str	w11,	[x14]

    ldr	w17,	[x15]

    lsl	w14,	w0,	#2
    movz	w15,	#10
    mul	w22,	w17,	w17
    mov	x23,	x14
    movz	w17,	#10
    add	w14,	w0,	#1
    add	x23,	sp,	x23
    sdiv	w5,	w22,	w17
    lsl	w2,	w5,	#1
    lsl	w24,	w14,	#2
    add	x23,	x23,	#16
    add	w1,	w2,	w5,	lsl #3
    sub	w19,	w22,	w1
    lsl	w22,	w14,	#2
    mov	x4,	x22
    str	w19,	[x23]

    add	x4,	sp,	x4
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x4,	x4,	#16
    add	x23,	x23,	fp
    movz	fp,	#40016
    ldr	w25,	[x23]

    mul	w2,	w25,	w25
    sdiv	w0,	w2,	w15
    lsl	w3,	w0,	#1
    add	w26,	w3,	w0,	lsl #3
    sub	w27,	w2,	w26
    add	w26,	w14,	#1
    str	w27,	[x4]

    lsl	w3,	w26,	#2
    lsl	w1,	w26,	#2
    mov	x2,	x3
    mov	x16,	x1
    movz	w3,	#10
    add	x2,	sp,	x2
    add	x16,	sp,	x16
    add	x2,	x2,	fp
    add	x16,	x16,	#16
    movz	fp,	#40016
    ldr	w4,	[x2]

    mul	w10,	w4,	w4
    sdiv	w25,	w10,	w13
    lsl	w4,	w25,	#1
    add	w22,	w4,	w25,	lsl #3
    sub	w6,	w10,	w22
    str	w6,	[x16]

    add	w6,	w26,	#1
    add	w23,	w6,	#1
    lsl	w11,	w6,	#2
    lsl	w9,	w6,	#2
    mov	x10,	x11
    mov	x26,	x9
    movz	w11,	#10
    add	w4,	w23,	#1
    lsl	w19,	w23,	#2
    lsl	w17,	w23,	#2
    add	x10,	sp,	x10
    movz	w9,	#10
    add	x26,	sp,	x26
    lsl	w27,	w4,	#2
    lsl	w25,	w4,	#2
    mov	x7,	x17
    add	x10,	x10,	fp
    add	x26,	x26,	#16
    add	x7,	sp,	x7
    movz	fp,	#40016
    ldr	w12,	[x10]

    add	x7,	x7,	#16
    mul	w20,	w12,	w12
    sdiv	w21,	w20,	w11
    lsl	w5,	w21,	#1
    add	w18,	w5,	w21,	lsl #3
    sub	w14,	w20,	w18
    mov	x18,	x19
    add	x18,	sp,	x18
    str	w14,	[x26]

    mov	x26,	x27
    add	x18,	x18,	fp
    add	x26,	sp,	x26
    movz	fp,	#40016
    ldr	w20,	[x18]

    add	x26,	x26,	fp
    mov	x18,	x25
    mul	w0,	w20,	w20
    movz	fp,	#40016
    add	x18,	sp,	x18
    sdiv	w17,	w0,	w9
    lsl	w6,	w17,	#1
    add	x18,	x18,	#16
    add	w14,	w6,	w17,	lsl #3
    sub	w22,	w0,	w14
    str	w22,	[x7]

    movz	w7,	#10
    ldr	w28,	[x26]

    mul	w0,	w28,	w28
    add	w28,	w4,	#1
    sdiv	w13,	w0,	w7
    lsl	w7,	w13,	#1
    lsl	w6,	w28,	#2
    lsl	w4,	w28,	#2
    add	w10,	w7,	w13,	lsl #3
    mov	x5,	x6
    mov	x26,	x4
    add	x5,	sp,	x5
    add	x26,	sp,	x26
    sub	w1,	w0,	w10
    add	x5,	x5,	fp
    add	x26,	x26,	#16
    movz	fp,	#40016
    str	w1,	[x18]

    ldr	w7,	[x5]

    movz	w5,	#10
    mul	w20,	w7,	w7
    add	w7,	w28,	#1
    sdiv	w9,	w20,	w5
    lsl	w8,	w9,	#1
    add	w0,	w7,	#1
    lsl	w14,	w7,	#2
    lsl	w12,	w7,	#2
    add	w6,	w8,	w9,	lsl #3
    mov	x13,	x14
    mov	x16,	x12
    add	x13,	sp,	x13
    add	x16,	sp,	x16
    sub	w9,	w20,	w6
    add	x13,	x13,	fp
    add	x16,	x16,	#16
    str	w9,	[x26]

    ldr	w15,	[x13]

    mul	w28,	w15,	w15
    sdiv	w4,	w28,	w3
    lsl	w9,	w4,	#1
    add	w2,	w9,	w4,	lsl #3
    sub	w17,	w28,	w2
    str	w17,	[x16]

    b	main_174

main_7:
    lsl	w10,	w27,	#2
    movz	fp,	#40016
    mul	w4,	w27,	w27
    movz	w26,	#10
    movz	w24,	#10
    movz	w22,	#10
    movz	w18,	#10
    mov	x15,	x10
    sdiv	w12,	w4,	w26
    add	x15,	sp,	x15
    lsl	w28,	w12,	#1
    add	x15,	x15,	fp
    add	w26,	w28,	w12,	lsl #3
    movz	fp,	#40016
    add	w28,	w27,	#1
    sub	w12,	w4,	w26
    add	w7,	w28,	#1
    mul	w9,	w28,	w28
    lsl	w25,	w28,	#2
    sdiv	w23,	w9,	w24
    str	w12,	[x15]

    mov	x21,	x25
    mul	w16,	w7,	w7
    lsl	w1,	w7,	#2
    lsl	w11,	w23,	#1
    add	x21,	sp,	x21
    sdiv	w20,	w16,	w22
    mov	x0,	x1
    add	w14,	w11,	w23,	lsl #3
    lsl	w12,	w20,	#1
    add	x21,	x21,	fp
    add	w1,	w7,	#1
    add	x0,	sp,	x0
    add	w11,	w12,	w20,	lsl #3
    sub	w27,	w9,	w14
    movz	fp,	#40016
    add	w7,	w1,	#1
    mul	w23,	w1,	w1
    lsl	w6,	w1,	#2
    movz	w12,	#10
    movz	w20,	#10
    sub	w3,	w16,	w11
    str	w27,	[x21]

    add	x0,	x0,	fp
    mul	w28,	w7,	w7
    mov	x4,	x6
    sdiv	w17,	w23,	w20
    lsl	w11,	w7,	#2
    movz	fp,	#40016
    str	w3,	[x0]

    movz	w6,	#10
    add	x4,	sp,	x4
    lsl	w13,	w17,	#1
    mov	x10,	x11
    movz	w0,	#10
    add	x10,	sp,	x10
    add	x4,	x4,	fp
    add	w8,	w13,	w17,	lsl #3
    movz	fp,	#40016
    sdiv	w13,	w28,	w18
    lsl	w14,	w13,	#1
    sub	w8,	w23,	w8
    add	x10,	x10,	fp
    add	w5,	w14,	w13,	lsl #3
    movz	fp,	#40016
    add	w14,	w7,	#1
    str	w8,	[x4]

    sub	w13,	w28,	w5
    movz	w8,	#10
    add	w3,	w14,	#1
    lsl	w16,	w14,	#2
    mul	w5,	w14,	w14
    mov	x21,	x16
    str	w13,	[x10]

    movz	w14,	#10
    movz	w16,	#10
    add	x21,	sp,	x21
    sdiv	w10,	w5,	w16
    add	x21,	x21,	fp
    lsl	w15,	w10,	#1
    movz	fp,	#40016
    add	w2,	w15,	w10,	lsl #3
    mul	w10,	w3,	w3
    sdiv	w7,	w10,	w14
    sub	w18,	w5,	w2
    lsl	w16,	w7,	#1
    add	w28,	w16,	w7,	lsl #3
    str	w18,	[x21]

    lsl	w21,	w3,	#2
    sub	w23,	w10,	w28
    mov	x25,	x21
    add	w10,	w3,	#1
    add	x25,	sp,	x25
    add	w19,	w10,	#1
    mul	w16,	w10,	w10
    lsl	w26,	w10,	#2
    add	x25,	x25,	fp
    sdiv	w4,	w16,	w12
    movz	w10,	#10
    add	w13,	w19,	#1
    mov	x2,	x26
    movz	fp,	#40016
    str	w23,	[x25]

    lsl	w17,	w4,	#1
    add	x2,	sp,	x2
    mul	w15,	w13,	w13
    lsl	w7,	w13,	#2
    mul	w23,	w19,	w19
    add	w25,	w17,	w4,	lsl #3
    add	x2,	x2,	fp
    sdiv	w27,	w15,	w8
    mov	x12,	x7
    sdiv	w1,	w23,	w10
    sub	w28,	w16,	w25
    movz	fp,	#40016
    add	x12,	sp,	x12
    lsl	w18,	w1,	#1
    movz	w25,	#10
    str	w28,	[x2]

    add	w22,	w18,	w1,	lsl #3
    lsl	w2,	w19,	#2
    lsl	w19,	w27,	#1
    mov	x9,	x2
    sub	w4,	w23,	w22
    add	w2,	w13,	#1
    add	x9,	sp,	x9
    add	w19,	w19,	w27,	lsl #3
    add	w8,	w2,	#1
    add	x9,	x9,	fp
    movz	fp,	#40016
    add	w3,	w8,	#1
    mul	w10,	w8,	w8
    lsl	w17,	w8,	#2
    str	w4,	[x9]

    add	x12,	x12,	fp
    mov	x28,	x17
    mul	w4,	w2,	w2
    sub	w9,	w15,	w19
    movz	fp,	#40016
    add	x28,	sp,	x28
    sdiv	w24,	w4,	w6
    str	w9,	[x12]

    lsl	w20,	w24,	#1
    lsl	w12,	w2,	#2
    add	w16,	w20,	w24,	lsl #3
    movz	w2,	#10
    mov	x22,	x12
    add	x22,	sp,	x22
    sub	w14,	w4,	w16
    mul	w16,	w3,	w3
    movz	w4,	#10
    add	x22,	x22,	fp
    sdiv	w17,	w16,	w2
    sdiv	w20,	w10,	w4
    movz	fp,	#40016
    lsl	w21,	w20,	#1
    str	w14,	[x22]

    add	x28,	x28,	fp
    add	w13,	w21,	w20,	lsl #3
    lsl	w22,	w3,	#2
    movz	fp,	#40016
    movz	w21,	#10
    mov	x5,	x22
    sub	w19,	w10,	w13
    lsl	w22,	w17,	#1
    add	x5,	sp,	x5
    add	w10,	w22,	w17,	lsl #3
    str	w19,	[x28]

    add	x5,	x5,	fp
    sub	w24,	w16,	w10
    movz	fp,	#40016
    add	w10,	w3,	#1
    str	w24,	[x5]

    add	w1,	w10,	#1
    mul	w22,	w10,	w10
    lsl	w27,	w10,	#2
    sdiv	w14,	w22,	w0
    mov	x8,	x27
    lsl	w23,	w14,	#1
    mul	w28,	w1,	w1
    lsl	w3,	w1,	#2
    movz	w27,	#10
    add	x8,	sp,	x8
    add	w7,	w23,	w14,	lsl #3
    mov	x17,	x3
    sdiv	w11,	w28,	w27
    add	w23,	w1,	#1
    add	x8,	x8,	fp
    add	x17,	sp,	x17
    sub	w0,	w22,	w7
    lsl	w24,	w11,	#1
    mul	w20,	w23,	w23
    add	w16,	w23,	#1
    movz	fp,	#40016
    add	w4,	w24,	w11,	lsl #3
    str	w0,	[x8]

    add	w22,	w16,	#1
    lsl	w13,	w16,	#2
    add	x17,	x17,	fp
    sub	w5,	w28,	w4
    lsl	w8,	w23,	#2
    movz	fp,	#40016
    add	w0,	w22,	#1
    lsl	w18,	w22,	#2
    str	w5,	[x17]

    movz	w23,	#10
    mov	x19,	x8
    mov	x7,	x18
    movz	w17,	#10
    sdiv	w8,	w20,	w25
    add	x19,	sp,	x19
    add	x7,	sp,	x7
    lsl	w25,	w8,	#1
    add	x19,	x19,	fp
    add	w1,	w25,	w8,	lsl #3
    movz	fp,	#40016
    sub	w10,	w20,	w1
    mov	x1,	x13
    movz	w13,	#10
    add	x1,	sp,	x1
    str	w10,	[x19]

    movz	w19,	#10
    mul	w10,	w16,	w16
    add	x1,	x1,	fp
    sdiv	w5,	w10,	w23
    movz	fp,	#40016
    lsl	w23,	w0,	#2
    lsl	w26,	w5,	#1
    mov	x11,	x23
    add	x7,	x7,	fp
    add	x11,	sp,	x11
    add	w27,	w26,	w5,	lsl #3
    movz	fp,	#40016
    add	x11,	x11,	fp
    sub	w15,	w10,	w27
    movz	fp,	#40016
    str	w15,	[x1]

    mul	w15,	w22,	w22
    sdiv	w2,	w15,	w21
    lsl	w27,	w2,	#1
    add	w24,	w27,	w2,	lsl #3
    sub	w20,	w15,	w24
    movz	w15,	#10
    str	w20,	[x7]

    movz	w7,	#10
    mul	w20,	w0,	w0
    sdiv	w27,	w20,	w19
    add	w19,	w0,	#1
    lsl	w28,	w27,	#1
    add	w21,	w28,	w27,	lsl #3
    add	w27,	w19,	#1
    lsl	w28,	w19,	#2
    sub	w25,	w20,	w21
    add	w23,	w27,	#1
    lsl	w4,	w27,	#2
    mov	x20,	x28
    mov	x21,	x4
    str	w25,	[x11]

    mul	w28,	w19,	w19
    mul	w10,	w23,	w23
    lsl	w9,	w23,	#2
    add	x20,	sp,	x20
    add	x21,	sp,	x21
    mul	w19,	w27,	w27
    sdiv	w25,	w28,	w17
    mov	x4,	x9
    sdiv	w22,	w19,	w15
    add	x20,	x20,	fp
    lsl	w0,	w25,	#1
    add	x4,	sp,	x4
    movz	fp,	#40016
    add	w18,	w0,	w25,	lsl #3
    add	x21,	x21,	fp
    movz	fp,	#40016
    sub	w1,	w28,	w18
    add	x4,	x4,	fp
    movz	fp,	#40016
    str	w1,	[x20]

    lsl	w1,	w22,	#1
    add	w15,	w1,	w22,	lsl #3
    sub	w6,	w19,	w15
    sdiv	w19,	w10,	w13
    lsl	w2,	w19,	#1
    str	w6,	[x21]

    add	w12,	w2,	w19,	lsl #3
    sub	w11,	w10,	w12
    add	w12,	w23,	#1
    str	w11,	[x4]

    add	w5,	w12,	#1
    mul	w18,	w12,	w12
    lsl	w14,	w12,	#2
    movz	w11,	#10
    mov	x4,	x14
    mul	w23,	w5,	w5
    lsl	w19,	w5,	#2
    sdiv	w16,	w18,	w11
    add	x4,	sp,	x4
    mov	x17,	x19
    lsl	w3,	w16,	#1
    add	x17,	sp,	x17
    add	x4,	x4,	fp
    add	w9,	w3,	w16,	lsl #3
    movz	fp,	#40016
    sub	w16,	w18,	w9
    add	x17,	x17,	fp
    movz	w9,	#10
    movz	fp,	#40016
    str	w16,	[x4]

    sdiv	w13,	w23,	w9
    lsl	w4,	w13,	#1
    add	w6,	w4,	w13,	lsl #3
    add	w13,	w5,	#1
    sub	w21,	w23,	w6
    add	w4,	w13,	#1
    mul	w28,	w13,	w13
    lsl	w24,	w13,	#2
    sdiv	w10,	w28,	w7
    str	w21,	[x17]

    mov	x22,	x24
    mul	w8,	w4,	w4
    lsl	w0,	w4,	#2
    lsl	w5,	w10,	#1
    add	x22,	sp,	x22
    mov	x1,	x0
    add	w3,	w5,	w10,	lsl #3
    add	x1,	sp,	x1
    add	x22,	x22,	fp
    movz	w5,	#10
    movz	fp,	#40016
    sub	w26,	w28,	w3
    sdiv	w7,	w8,	w5
    add	x1,	x1,	fp
    movz	w28,	#10
    movz	w3,	#10
    lsl	w6,	w7,	#1
    str	w26,	[x22]

    movz	fp,	#40016
    add	w0,	w6,	w7,	lsl #3
    add	w6,	w4,	#1
    sub	w2,	w8,	w0
    mul	w23,	w6,	w6
    lsl	w5,	w6,	#2
    sdiv	w3,	w23,	w3
    mov	x9,	x5
    str	w2,	[x1]

    lsl	w7,	w3,	#1
    add	w5,	w6,	#1
    add	x9,	sp,	x9
    movz	w1,	#10
    add	w26,	w7,	w3,	lsl #3
    mul	w17,	w5,	w5
    lsl	w10,	w5,	#2
    add	x9,	x9,	fp
    sub	w7,	w23,	w26
    sdiv	w0,	w17,	w1
    mov	x14,	x10
    movz	fp,	#40016
    lsl	w8,	w0,	#1
    str	w7,	[x9]

    add	x14,	sp,	x14
    add	w23,	w8,	w0,	lsl #3
    add	w8,	w5,	#1
    add	x14,	x14,	fp
    sub	w12,	w17,	w23
    movz	fp,	#40016
    mul	w21,	w8,	w8
    lsl	w15,	w8,	#2
    sdiv	w26,	w21,	w28
    mov	x16,	x15
    str	w12,	[x14]

    lsl	w9,	w26,	#1
    add	x16,	sp,	x16
    add	w14,	w8,	#1
    add	w20,	w9,	w26,	lsl #3
    movz	w26,	#10
    add	x16,	x16,	fp
    mul	w28,	w14,	w14
    sub	w17,	w21,	w20
    movz	fp,	#40016
    sdiv	w23,	w28,	w26
    lsl	w20,	w14,	#2
    lsl	w10,	w23,	#1
    mov	x24,	x20
    str	w17,	[x16]

    add	x24,	sp,	x24
    add	w17,	w10,	w23,	lsl #3
    add	w23,	w14,	#1
    add	x24,	x24,	fp
    sub	w22,	w28,	w17
    movz	fp,	#40016
    mul	w4,	w23,	w23
    lsl	w25,	w23,	#2
    mov	x2,	x25
    str	w22,	[x24]

    add	x2,	sp,	x2
    movz	w22,	#10
    movz	w24,	#10
    add	x2,	x2,	fp
    sdiv	w20,	w4,	w24
    movz	fp,	#40016
    lsl	w11,	w20,	#1
    add	w14,	w11,	w20,	lsl #3
    sub	w27,	w4,	w14
    add	w4,	w23,	#1
    str	w27,	[x2]

    mul	w9,	w4,	w4
    lsl	w1,	w4,	#2
    add	w27,	w4,	#1
    sdiv	w17,	w9,	w22
    mov	x8,	x1
    lsl	w12,	w17,	#1
    add	x8,	sp,	x8
    add	w11,	w12,	w17,	lsl #3
    add	x8,	x8,	fp
    sub	w3,	w9,	w11
    str	w3,	[x8]

    b	main_4

