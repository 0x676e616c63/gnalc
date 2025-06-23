.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#656
    movk	fp,	#2,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#336
    movk	w2,	#2,	lsl #16
    bl	memset
    movz	w25,	#0
    movz	fp,	#336
    movz	w23,	#0
    movz	w24,	#0
    movz	w22,	#0
    movk	fp,	#2,	lsl #16
    add	x27,	sp,	fp
    movz	fp,	#340
    movk	fp,	#2,	lsl #16
    str	w25,	[x27]

    add	x19,	sp,	fp
    movz	fp,	#344
    movk	fp,	#2,	lsl #16
    str	w24,	[x19]

    add	x20,	sp,	fp
    movz	fp,	#348
    movk	fp,	#2,	lsl #16
    str	w23,	[x20]

    add	x21,	sp,	fp
    movz	fp,	#352
    movk	fp,	#2,	lsl #16
    str	w22,	[x21]

    add	x23,	sp,	fp
    movz	w21,	#0
    str	w21,	[x23]

    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w21,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	w6,	#0
    movz	fp,	#356
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x5,	sp,	fp
    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x5,	[sp, fp]

    movz	w5,	#0
    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    ldr	x17,	[sp, fp]

    movz	fp,	#360
    str	w6,	[x17]

    movk	fp,	#2,	lsl #16
    add	x3,	sp,	fp
    movz	fp,	#364
    movk	fp,	#2,	lsl #16
    str	w5,	[x3]

    add	x6,	sp,	fp
    movz	w3,	#0
    movz	fp,	#368
    movk	fp,	#2,	lsl #16
    str	w4,	[x6]

    add	x7,	sp,	fp
    movz	fp,	#372
    movk	fp,	#2,	lsl #16
    str	w3,	[x7]

    add	x8,	sp,	fp
    str	w2,	[x8]

    cmp	w21,	#0
    ble	main_460

main_18:
    add	x17,	sp,	#336
    movz	fp,	#468
    movz	w15,	#62464
    add	x28,	sp,	#16
    mov	x3,	x27
    add	x24,	x27,	#4
    add	x16,	x27,	#8
    add	x13,	x27,	#12
    add	x23,	x27,	#16
    mov	w11,	w21
    mov	w8,	w19
    movk	fp,	#2,	lsl #16
    movk	w15,	#1,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#480
    add	x2,	x0,	x15
    movk	fp,	#2,	lsl #16
    str	x2,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	x3,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#568
    movk	fp,	#2,	lsl #16
    str	x13,	[sp, fp]

    movz	fp,	#560
    movk	fp,	#2,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w0,	#0
    mov	w19,	w8
    movz	fp,	#452
    mov	w28,	w0
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]


main_31:
    movz	w2,	#32000
    cmp	w28,	w2
    bge	main_45

main_35:
    lsl	w3,	w28,	#2
    movz	fp,	#452
    add	w28,	w28,	#1
    mov	x7,	x3
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    ldr	w27,	[sp, fp]

    add	x7,	x7,	#336
    movz	fp,	#452
    lsl	w4,	w27,	#13
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#452
    add	w6,	w13,	w4
    movk	fp,	#2,	lsl #16
    asr	w8,	w6,	#31
    lsr	w9,	w8,	#15
    add	w10,	w6,	w9
    asr	w2,	w10,	#17
    add	w8,	w6,	w2
    lsl	w4,	w8,	#5
    add	w9,	w8,	w4
    asr	w12,	w9,	#31
    lsr	w13,	w12,	#24
    add	w14,	w9,	w13
    asr	w16,	w14,	#8
    lsl	w17,	w16,	#8
    sub	w6,	w9,	w17
    str	w6,	[x7]

    str	w9,	[sp, fp]

    b	main_31

main_45:
    movz	w1,	#128
    movz	fp,	#480
    movz	w24,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w24
    ldr	x18,	[sp, fp]

    str	w1,	[x18]


main_46:
    asr	w27,	w16,	#31
    lsr	w28,	w27,	#26
    add	w0,	w16,	w28
    asr	w10,	w0,	#6
    lsl	w11,	w10,	#6
    sub	w12,	w16,	w11
    cmp	w12,	#60
    beq	main_53

main_50:
    lsl	w17,	w16,	#2
    movz	fp,	#468
    movz	w12,	#0
    add	w23,	w16,	#1
    movk	fp,	#2,	lsl #16
    mov	w16,	w23
    ldr	x5,	[sp, fp]

    add	x10,	x5,	x17
    str	w12,	[x10]

    b	main_46

main_53:
    lsl	w2,	w16,	#2
    movz	fp,	#468
    movz	w24,	#0
    add	w21,	w16,	#1
    movz	w22,	#0
    movz	w20,	#125
    add	w27,	w16,	#3
    add	w23,	w16,	#4
    movk	fp,	#2,	lsl #16
    lsl	w21,	w21,	#2
    lsl	w28,	w27,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#468
    add	x1,	x1,	x2
    movk	fp,	#2,	lsl #16
    str	w24,	[x1]

    add	w24,	w16,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#468
    add	x21,	x2,	x21
    movk	fp,	#2,	lsl #16
    movz	w2,	#0
    lsl	w25,	w24,	#2
    str	w22,	[x21]

    ldr	x0,	[sp, fp]

    movz	fp,	#468
    add	x26,	x0,	x25
    movk	fp,	#2,	lsl #16
    str	w20,	[x26]

    ldr	x1,	[sp, fp]

    movz	fp,	#476
    add	x0,	x1,	x28
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x0]

    movz	w2,	#320
    str	w23,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w9,	#0
    movz	w3,	#8961
    movz	w20,	#43913
    movz	w12,	#56574
    movz	w25,	#21622
    movz	w5,	#57840
    mov	w28,	w9
    movk	w3,	#26437,	lsl #16
    movk	w20,	#61389,	lsl #16
    movk	w12,	#39098,	lsl #16
    movk	w25,	#4146,	lsl #16
    movk	w5,	#50130,	lsl #16
    mov	w11,	w3
    mov	w0,	w12
    mov	w21,	w25
    mov	w17,	w5
    mov	w3,	w20

main_63:
    movz	w4,	#0
    mov	w19,	w28
    mov	w6,	w4

main_70:
    cmp	w6,	#14
    bge	main_215

main_74:
    lsl	w8,	w6,	#2
    lsl	w2,	w19,	#2
    movz	fp,	#468
    add	w10,	w19,	#2
    add	w15,	w6,	#1
    mov	x12,	x8
    movk	fp,	#2,	lsl #16
    add	x12,	sp,	x12
    lsl	w8,	w10,	#2
    ldr	x14,	[sp, fp]

    add	w10,	w19,	#4
    add	x12,	x12,	#16
    movz	fp,	#468
    add	x27,	x14,	x2
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x27]

    ldr	x4,	[sp, fp]

    add	w27,	w19,	#1
    lsl	w20,	w2,	#24
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    lsl	w26,	w27,	#2
    add	x1,	x4,	x26
    ldr	w4,	[x1]

    ldr	x2,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#468
    add	x13,	x2,	x8
    add	w5,	w5,	w20
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x13]

    ldr	x7,	[sp, fp]

    add	w13,	w19,	#3
    lsl	w2,	w1,	#8
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    lsl	w16,	w13,	#2
    add	w2,	w5,	w2
    add	x14,	x7,	x16
    add	w7,	w15,	#1
    ldr	w16,	[x14]

    lsl	w22,	w7,	#2
    add	w27,	w2,	w16
    str	w27,	[x12]

    ldr	x20,	[sp, fp]

    lsl	w12,	w15,	#2
    movz	fp,	#468
    mov	x4,	x12
    movk	fp,	#2,	lsl #16
    lsl	w12,	w10,	#2
    add	x4,	sp,	x4
    add	x8,	x20,	x12
    add	w12,	w10,	#1
    add	x4,	x4,	#16
    ldr	w13,	[x8]

    lsl	w9,	w12,	#2
    ldr	x14,	[sp, fp]

    lsl	w5,	w13,	#24
    movz	fp,	#468
    add	x13,	x14,	x9
    movk	fp,	#2,	lsl #16
    add	w9,	w10,	#2
    ldr	w1,	[x13]

    lsl	w19,	w9,	#2
    ldr	x14,	[sp, fp]

    lsl	w2,	w1,	#16
    movz	fp,	#468
    add	x12,	x14,	x19
    mov	x1,	x22
    add	w5,	w2,	w5
    movk	fp,	#2,	lsl #16
    add	w19,	w10,	#3
    add	x1,	sp,	x1
    ldr	w14,	[x12]

    lsl	w16,	w14,	#8
    lsl	w23,	w19,	#2
    add	x1,	x1,	#16
    add	w24,	w5,	w16
    ldr	x16,	[sp, fp]

    movz	fp,	#468
    add	x20,	x16,	x23
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x20]

    add	w8,	w24,	w25
    str	w8,	[x4]

    ldr	x4,	[sp, fp]

    add	w8,	w10,	#4
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    add	w6,	w8,	#3
    add	w14,	w8,	#1
    add	w24,	w8,	#2
    lsl	w13,	w8,	#2
    lsl	w12,	w14,	#2
    add	x10,	x4,	x13
    lsl	w23,	w24,	#2
    ldr	w13,	[x10]

    ldr	x5,	[sp, fp]

    lsl	w10,	w13,	#24
    movz	fp,	#468
    add	x15,	x5,	x12
    lsl	w13,	w6,	#2
    movk	fp,	#2,	lsl #16
    add	w5,	w8,	#4
    ldr	w18,	[x15]

    lsl	w20,	w18,	#16
    add	w8,	w5,	#3
    add	w24,	w5,	#1
    add	w19,	w20,	w10
    ldr	x10,	[sp, fp]

    movz	fp,	#468
    add	x25,	x10,	x23
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x25]

    ldr	x12,	[sp, fp]

    lsl	w4,	w2,	#8
    movz	fp,	#468
    add	x12,	x12,	x13
    add	w26,	w19,	w4
    movk	fp,	#2,	lsl #16
    lsl	w19,	w5,	#2
    ldr	w15,	[x12]

    add	w10,	w26,	w15
    add	w26,	w7,	#1
    str	w10,	[x1]

    add	w10,	w5,	#2
    ldr	x13,	[sp, fp]

    lsl	w1,	w26,	#2
    movz	fp,	#468
    add	x15,	x13,	x19
    mov	x9,	x1
    lsl	w25,	w10,	#2
    movk	fp,	#2,	lsl #16
    add	x9,	sp,	x9
    ldr	w19,	[x15]

    ldr	x13,	[sp, fp]

    lsl	w15,	w24,	#2
    add	x9,	x9,	#16
    lsl	w20,	w19,	#24
    movz	fp,	#468
    add	x27,	x13,	x15
    movk	fp,	#2,	lsl #16
    lsl	w13,	w8,	#2
    ldr	w2,	[x27]

    ldr	x15,	[sp, fp]

    lsl	w4,	w2,	#16
    movz	fp,	#468
    add	x12,	x15,	x25
    add	w6,	w4,	w20
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    ldr	x20,	[sp, fp]

    lsl	w1,	w15,	#8
    movz	fp,	#468
    add	x10,	x20,	x13
    add	w2,	w6,	w1
    movk	fp,	#2,	lsl #16
    add	w13,	w5,	#4
    add	w6,	w26,	#1
    ldr	w14,	[x10]

    add	w15,	w2,	w14
    add	w18,	w13,	#3
    lsl	w1,	w13,	#2
    lsl	w8,	w6,	#2
    str	w15,	[x9]

    mov	x16,	x8
    lsl	w24,	w18,	#2
    add	w9,	w13,	#1
    ldr	x7,	[sp, fp]

    add	w8,	w13,	#2
    add	x16,	sp,	x16
    movz	fp,	#468
    lsl	w19,	w9,	#2
    add	x26,	x7,	x1
    lsl	w27,	w8,	#2
    movk	fp,	#2,	lsl #16
    add	x16,	x16,	#16
    ldr	w1,	[x26]

    ldr	x23,	[sp, fp]

    lsl	w5,	w1,	#24
    movz	fp,	#468
    add	x10,	x23,	x19
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x10]

    ldr	x25,	[sp, fp]

    lsl	w1,	w15,	#16
    movz	fp,	#468
    add	x9,	x25,	x27
    add	w2,	w1,	w5
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x9]

    ldr	x1,	[sp, fp]

    lsl	w14,	w12,	#8
    movz	fp,	#468
    add	x22,	x1,	x24
    add	w5,	w2,	w14
    movk	fp,	#2,	lsl #16
    add	w14,	w6,	#1
    ldr	w25,	[x22]

    add	w6,	w13,	#4
    add	w26,	w5,	w25
    lsl	w4,	w14,	#2
    add	w8,	w6,	#3
    add	w20,	w6,	#2
    lsl	w12,	w6,	#2
    str	w26,	[x16]

    mov	x5,	x4
    ldr	x15,	[sp, fp]

    lsl	w4,	w20,	#2
    add	x5,	sp,	x5
    movz	fp,	#468
    add	x9,	x15,	x12
    movk	fp,	#2,	lsl #16
    lsl	w12,	w8,	#2
    add	x5,	x5,	#16
    ldr	w13,	[x9]

    add	w9,	w6,	#1
    lsl	w2,	w13,	#24
    lsl	w23,	w9,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#468
    add	x10,	x9,	x23
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x10]

    ldr	x9,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#468
    add	x22,	x9,	x4
    add	w16,	w16,	w2
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x22]

    ldr	x13,	[sp, fp]

    lsl	w27,	w25,	#8
    movz	fp,	#468
    add	x10,	x13,	x12
    add	w1,	w16,	w27
    movk	fp,	#2,	lsl #16
    add	w12,	w6,	#4
    ldr	w13,	[x10]

    add	w9,	w1,	w13
    add	w8,	w12,	#2
    add	w22,	w12,	#1
    lsl	w10,	w12,	#2
    str	w9,	[x5]

    lsl	w7,	w8,	#2
    lsl	w25,	w22,	#2
    ldr	x26,	[sp, fp]

    add	w5,	w14,	#1
    add	w22,	w12,	#4
    movz	fp,	#468
    add	x9,	x26,	x10
    mov	w19,	w22
    lsl	w13,	w5,	#2
    movk	fp,	#2,	lsl #16
    mov	x1,	x13
    ldr	w13,	[x9]

    add	x1,	sp,	x1
    ldr	x18,	[sp, fp]

    lsl	w16,	w13,	#24
    movz	fp,	#468
    add	x24,	x18,	x25
    add	x1,	x1,	#16
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    ldr	x8,	[sp, fp]

    lsl	w2,	w27,	#16
    movz	fp,	#468
    add	x10,	x8,	x7
    add	w2,	w2,	w16
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x10]

    add	w10,	w12,	#3
    lsl	w16,	w14,	#8
    add	w4,	w2,	w16
    lsl	w14,	w10,	#2
    ldr	x10,	[sp, fp]

    add	x13,	x10,	x14
    add	w10,	w5,	#1
    mov	w6,	w10
    ldr	w15,	[x13]

    add	w9,	w4,	w15
    str	w9,	[x1]

    b	main_70

main_215:
    mov	w26,	w6

main_217:
    lsl	w15,	w26,	#2
    lsl	w27,	w19,	#2
    movz	fp,	#468
    add	w9,	w19,	#2
    add	w13,	w19,	#3
    mov	x15,	x15
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    ldr	x6,	[sp, fp]

    add	x15,	x15,	#16
    movz	fp,	#468
    add	x10,	x6,	x27
    movk	fp,	#2,	lsl #16
    add	w27,	w19,	#1
    add	w19,	w19,	#4
    ldr	w16,	[x10]

    lsl	w24,	w27,	#2
    ldr	x6,	[sp, fp]

    lsl	w18,	w16,	#24
    movz	fp,	#468
    add	x1,	x6,	x24
    movk	fp,	#2,	lsl #16
    lsl	w6,	w9,	#2
    ldr	w4,	[x1]

    ldr	x9,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#468
    add	x10,	x9,	x6
    add	w5,	w5,	w18
    movk	fp,	#2,	lsl #16
    add	w9,	w26,	#1
    ldr	w1,	[x10]

    lsl	w10,	w13,	#2
    lsl	w2,	w1,	#8
    ldr	x13,	[sp, fp]

    add	w1,	w5,	w2
    add	x18,	x13,	x10
    ldr	w24,	[x18]

    add	w10,	w1,	w24
    str	w10,	[x15]

    cmp	w9,	#16
    bge	main_241

main_216:
    mov	w26,	w9
    b	main_217

main_241:
    mov	w12,	w9

main_242:
    cmp	w12,	#80
    bge	main_275

main_245:
    lsl	w25,	w12,	#2
    sub	w27,	w12,	#3
    sub	w18,	w12,	#16
    mov	x2,	x25
    add	x2,	sp,	x2
    lsl	w4,	w27,	#2
    lsl	w24,	w18,	#2
    mov	x1,	x4
    add	x2,	x2,	#16
    mov	x19,	x24
    add	x1,	sp,	x1
    add	x19,	sp,	x19
    add	x1,	x1,	#16
    add	x19,	x19,	#16
    ldr	w6,	[x1]

    sub	w1,	w12,	#8
    lsl	w5,	w1,	#2
    mov	x4,	x5
    sub	w5,	w12,	#14
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w15,	[x4]

    add	w13,	w15,	w6
    sub	w10,	w6,	w13
    add	w1,	w10,	w15
    lsl	w10,	w5,	#2
    mov	x7,	x10
    sub	w8,	w1,	w13
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w4,	[x19]

    add	w1,	w14,	w8
    sub	w26,	w8,	w1
    add	w14,	w26,	w14
    sub	w22,	w14,	w1
    add	w16,	w4,	w22
    sub	w1,	w22,	w16
    add	w27,	w1,	w4
    sub	w14,	w27,	w16
    asr	w7,	w14,	#31
    lsl	w27,	w14,	#1
    lsr	w8,	w7,	#31
    add	w10,	w14,	w8
    asr	w25,	w10,	#1
    lsl	w26,	w25,	#1
    sub	w10,	w14,	w26
    add	w1,	w27,	w10
    str	w1,	[x2]

    add	w2,	w12,	#1
    mov	w12,	w2
    b	main_242

main_275:
    mov	w26,	w11
    movz	fp,	#460
    mov	w5,	w3
    mov	w22,	w0
    mov	w16,	w21
    mov	w2,	w17
    movz	w10,	#0
    movk	fp,	#2,	lsl #16
    mov	w24,	w10
    str	w26,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	w24,	[sp, fp]


main_277:
    movz	w25,	#48348
    movz	w15,	#60289
    movz	w7,	#49414
    movz	w18,	#31129
    movz	w27,	#65535
    movz	fp,	#444
    movk	w25,	#36635,	lsl #16
    movk	w15,	#28377,	lsl #16
    movk	w7,	#51810,	lsl #16
    movk	w18,	#23170,	lsl #16
    movk	w27,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w19,	w25
    mov	w4,	w7
    mov	w24,	w27
    mov	w7,	w18
    ldr	w18,	[sp, fp]

    cmp	w18,	#20
    bge	main_296

main_285:
    movz	fp,	#456
    mov	w9,	w24
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#456
    add	w27,	w23,	w16
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#448
    sub	w9,	w9,	w22
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    add	w22,	w1,	w9
    add	w25,	w22,	w27
    sub	w23,	w27,	w25
    add	w27,	w23,	w22
    sub	w9,	w27,	w25
    sub	w18,	w9,	w27
    add	w20,	w18,	w25
    mov	w25,	w7
    sub	w22,	w20,	w27
    mov	w18,	w22
    b	main_416

main_296:
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    cmp	w23,	#40
    bge	main_307

main_298:
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#456
    add	w18,	w6,	w1
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    sub	w20,	w1,	w18
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#448
    add	w27,	w20,	w8
    movk	fp,	#2,	lsl #16
    sub	w9,	w27,	w18
    ldr	w18,	[sp, fp]

    movz	fp,	#448
    add	w22,	w18,	w9
    movk	fp,	#2,	lsl #16
    sub	w20,	w9,	w22
    ldr	w9,	[sp, fp]

    add	w25,	w20,	w9
    sub	w18,	w25,	w22
    mov	w25,	w15
    b	main_416

main_307:
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    cmp	w5,	#60
    bge	main_327

main_309:
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#448
    add	w10,	w12,	w9
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#448
    add	w9,	w23,	w20
    movk	fp,	#2,	lsl #16
    add	w13,	w9,	w10
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    sub	w10,	w10,	w13
    ldr	w14,	[sp, fp]

    add	w6,	w1,	w14
    add	w10,	w10,	w9
    sub	w9,	w10,	w13
    sub	w16,	w9,	w10
    add	w18,	w16,	w13
    sub	w18,	w18,	w10
    add	w27,	w6,	w18
    sub	w18,	w18,	w27
    add	w9,	w18,	w6
    sub	w22,	w9,	w27
    sub	w25,	w22,	w9
    add	w10,	w25,	w27
    mov	w25,	w19
    sub	w18,	w10,	w9
    b	main_416

main_327:
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#456
    add	w18,	w16,	w12
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#464
    sub	w16,	w14,	w18
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#448
    add	w25,	w16,	w22
    movk	fp,	#2,	lsl #16
    sub	w9,	w25,	w18
    ldr	w5,	[sp, fp]

    mov	w25,	w4
    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    add	w22,	w5,	w9
    ldr	w16,	[sp, fp]

    sub	w20,	w9,	w22
    add	w9,	w20,	w16
    sub	w18,	w9,	w22

main_416:
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#460
    lsl	w6,	w16,	#5
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#460
    asr	w9,	w12,	#31
    movk	fp,	#2,	lsl #16
    lsr	w9,	w9,	#27
    ldr	w14,	[sp, fp]

    movz	fp,	#460
    add	w16,	w14,	w9
    movk	fp,	#2,	lsl #16
    asr	w20,	w16,	#5
    ldr	w16,	[sp, fp]

    lsl	w22,	w20,	#5
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    sub	w9,	w16,	w22
    ldr	w22,	[sp, fp]

    movz	fp,	#456
    add	w13,	w6,	w9
    movk	fp,	#2,	lsl #16
    lsl	w9,	w22,	#2
    mov	x6,	x9
    add	w27,	w13,	w2
    add	x6,	sp,	x6
    add	w22,	w27,	w18
    add	x6,	x6,	#16
    add	w2,	w22,	w25
    ldr	w10,	[x6]

    ldr	w16,	[sp, fp]

    movz	fp,	#456
    lsl	w20,	w16,	#30
    add	w2,	w2,	w10
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#456
    asr	w25,	w16,	#31
    movk	fp,	#2,	lsl #16
    lsr	w18,	w25,	#2
    ldr	w16,	[sp, fp]

    movz	fp,	#456
    add	w10,	w16,	w18
    movk	fp,	#2,	lsl #16
    asr	w14,	w10,	#30
    ldr	w22,	[sp, fp]

    movz	fp,	#444
    lsl	w14,	w14,	#30
    movk	fp,	#2,	lsl #16
    sub	w16,	w22,	w14
    ldr	w6,	[sp, fp]

    add	w23,	w6,	#1
    add	w22,	w20,	w16
    cmp	w23,	#20
    bge	main_364

main_336:
    movz	fp,	#460
    mov	w10,	w24
    movk	fp,	#2,	lsl #16
    mov	w24,	w7
    ldr	w12,	[sp, fp]

    movz	fp,	#460
    add	w13,	w22,	w12
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#464
    sub	w14,	w10,	w4
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    add	w15,	w12,	w14
    add	w1,	w15,	w13
    sub	w25,	w13,	w1
    add	w18,	w25,	w15
    sub	w27,	w18,	w1
    sub	w6,	w27,	w18
    add	w9,	w6,	w1
    sub	w13,	w9,	w18
    mov	w14,	w13
    b	main_347

main_364:
    cmp	w23,	#40
    bge	main_378

main_366:
    movz	fp,	#460
    mov	w26,	w15
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#460
    add	w13,	w22,	w12
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#464
    sub	w24,	w25,	w13
    movk	fp,	#2,	lsl #16
    add	w1,	w24,	w22
    ldr	w5,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    sub	w4,	w1,	w13
    ldr	w24,	[sp, fp]

    add	w7,	w5,	w4
    sub	w10,	w4,	w7
    add	w13,	w10,	w24
    sub	w9,	w13,	w7
    b	main_375

main_378:
    cmp	w23,	#60
    bge	main_401

main_380:
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#460
    add	w24,	w22,	w14
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#464
    add	w26,	w15,	w4
    movk	fp,	#2,	lsl #16
    add	w1,	w26,	w24
    ldr	w6,	[sp, fp]

    sub	w7,	w24,	w1
    add	w15,	w7,	w26
    add	w26,	w6,	w22
    sub	w10,	w15,	w1
    sub	w13,	w10,	w15
    add	w18,	w13,	w1
    sub	w24,	w18,	w15
    add	w7,	w26,	w24
    sub	w6,	w24,	w7
    add	w1,	w6,	w26
    sub	w13,	w1,	w7
    sub	w14,	w13,	w1
    add	w18,	w14,	w7
    mov	w7,	w19
    sub	w9,	w18,	w1
    mov	w13,	w9
    b	main_398

main_401:
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#460
    add	w1,	w22,	w24
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#464
    sub	w7,	w8,	w1
    movk	fp,	#2,	lsl #16
    add	w9,	w7,	w22
    ldr	w13,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    sub	w10,	w9,	w1
    ldr	w7,	[sp, fp]

    add	w6,	w13,	w10
    sub	w14,	w10,	w6
    add	w19,	w14,	w7
    mov	w7,	w4
    sub	w10,	w19,	w6
    mov	w13,	w10

main_398:
    mov	w9,	w13
    mov	w26,	w7

main_375:
    mov	w14,	w9
    mov	w24,	w26

main_347:
    lsl	w4,	w2,	#5
    asr	w10,	w2,	#31
    movz	fp,	#448
    lsr	w13,	w10,	#27
    movk	fp,	#2,	lsl #16
    add	w18,	w2,	w13
    asr	w18,	w18,	#5
    lsl	w26,	w18,	#5
    lsl	w18,	w23,	#2
    sub	w16,	w2,	w26
    mov	x13,	x18
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w8,	[sp, fp]

    movz	fp,	#460
    add	w1,	w16,	w8
    movk	fp,	#2,	lsl #16
    add	w26,	w1,	w4
    ldr	w1,	[sp, fp]

    movz	fp,	#460
    lsl	w12,	w1,	#30
    add	w20,	w26,	w14
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w4,	w20,	w24
    movz	fp,	#460
    asr	w15,	w10,	#31
    movk	fp,	#2,	lsl #16
    add	w16,	w4,	w13
    lsr	w19,	w15,	#2
    ldr	w4,	[sp, fp]

    movz	fp,	#460
    add	w1,	w4,	w19
    movk	fp,	#2,	lsl #16
    asr	w6,	w1,	#30
    lsl	w10,	w6,	#30
    ldr	w6,	[sp, fp]

    sub	w9,	w6,	w10
    add	w6,	w23,	#1
    add	w20,	w12,	w9
    cmp	w6,	#80
    blt	main_276

main_433:
    add	w15,	w16,	w11
    add	w5,	w2,	w3
    add	w12,	w20,	w0
    add	w24,	w22,	w21
    movz	fp,	#464
    add	w1,	w28,	#64
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#476
    add	w20,	w6,	w17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    cmp	w1,	w6
    blt	main_62

main_441:
    movz	fp,	#412
    movz	w11,	#0
    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#420
    str	w15,	[x19]

    movk	fp,	#2,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#404
    str	w5,	[x8]

    movk	fp,	#2,	lsl #16
    ldr	x18,	[sp, fp]

    movz	fp,	#568
    str	w12,	[x18]

    movk	fp,	#2,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#560
    str	w24,	[x27]

    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    str	w20,	[x28]


main_442:
    cmp	w11,	#5
    bge	main_455

main_445:
    lsl	w4,	w11,	#2
    movz	fp,	#356
    lsl	w23,	w11,	#2
    mov	x3,	x4
    movk	fp,	#2,	lsl #16
    add	w11,	w11,	#1
    mov	x22,	x23
    add	x3,	sp,	x3
    add	x22,	sp,	x22
    add	x3,	x3,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w18,	[x3]

    add	x22,	x22,	fp
    ldr	w26,	[x22]

    add	w20,	w26,	w18
    sub	w21,	w18,	w20
    add	w27,	w21,	w26
    sub	w25,	w27,	w20
    str	w25,	[x3]

    b	main_442

main_455:
    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w27,	w26,	#1
    cmp	w27,	#0
    ble	main_460

main_27:
    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    mov	w8,	w19
    b	main_28

main_62:
    mov	w11,	w15
    mov	w3,	w5
    mov	w0,	w12
    mov	w21,	w24
    mov	w17,	w20
    mov	w28,	w1
    b	main_63

main_276:
    mov	w15,	w16
    movz	fp,	#460
    mov	w12,	w2
    mov	w1,	w6
    mov	w4,	w20
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#444
    mov	w2,	w12
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#488
    movz	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	x1,	[sp, fp]

    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#656
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


