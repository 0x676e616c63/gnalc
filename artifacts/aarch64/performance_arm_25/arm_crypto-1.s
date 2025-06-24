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
    movz	w24,	#0
    movz	fp,	#336
    movz	w23,	#0
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
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	x5,	[sp, fp]

    movz	w5,	#0
    movz	fp,	#508
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
    mov	x6,	x27
    add	x20,	x27,	#4
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

    movz	fp,	#500
    add	x2,	x0,	x15
    movk	fp,	#2,	lsl #16
    str	x2,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	x6,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x13,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w0,	#0
    mov	w19,	w8
    movz	fp,	#420
    mov	w28,	w0
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]


main_31:
    movz	w2,	#32000
    cmp	w28,	w2
    bge	main_45

main_35:
    lsl	w3,	w28,	#2
    movz	fp,	#420
    add	w28,	w28,	#1
    mov	x7,	x3
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    ldr	w27,	[sp, fp]

    add	x7,	x7,	#336
    movz	fp,	#420
    lsl	w4,	w27,	#13
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#420
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
    movz	fp,	#500
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

    movz	fp,	#496
    add	x0,	x1,	x28
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x0]

    movz	w2,	#320
    str	w23,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w9,	#0
    movz	w20,	#43913
    movz	w3,	#8961
    movz	w11,	#56574
    movz	w25,	#21622
    movz	w5,	#57840
    mov	w23,	w9
    movk	w20,	#61389,	lsl #16
    movk	w3,	#26437,	lsl #16
    movk	w11,	#39098,	lsl #16
    movk	w25,	#4146,	lsl #16
    movk	w5,	#50130,	lsl #16
    mov	w12,	w20
    mov	w2,	w3
    mov	w0,	w11
    mov	w26,	w25
    mov	w17,	w5

main_63:
    movz	w5,	#0
    mov	w19,	w23
    mov	w6,	w5

main_70:
    cmp	w6,	#14
    bge	main_215

main_74:
    lsl	w8,	w6,	#2
    lsl	w3,	w19,	#2
    movz	fp,	#468
    add	w10,	w19,	#2
    mov	x11,	x8
    movk	fp,	#2,	lsl #16
    add	x11,	sp,	x11
    ldr	x14,	[sp, fp]

    lsl	w8,	w10,	#2
    movz	fp,	#468
    add	x27,	x14,	x3
    add	x11,	x11,	#16
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x27]

    add	w27,	w19,	#1
    lsl	w20,	w4,	#24
    ldr	x4,	[sp, fp]

    movz	fp,	#468
    lsl	w25,	w27,	#2
    movk	fp,	#2,	lsl #16
    add	x28,	x4,	x25
    ldr	w5,	[x28]

    ldr	x1,	[sp, fp]

    lsl	w7,	w5,	#16
    movz	fp,	#468
    add	x13,	x1,	x8
    add	w7,	w7,	w20
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x13]

    ldr	x8,	[sp, fp]

    add	w13,	w19,	#3
    lsl	w3,	w1,	#8
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    lsl	w16,	w13,	#2
    add	w3,	w7,	w3
    add	w7,	w6,	#1
    add	x14,	x8,	x16
    ldr	w16,	[x14]

    add	w27,	w3,	w16
    add	w16,	w19,	#4
    str	w27,	[x11]

    add	w8,	w16,	#4
    ldr	x20,	[sp, fp]

    lsl	w11,	w7,	#2
    movz	fp,	#468
    mov	x5,	x11
    movk	fp,	#2,	lsl #16
    add	w4,	w8,	#3
    add	w21,	w8,	#2
    lsl	w11,	w16,	#2
    add	x5,	sp,	x5
    lsl	w21,	w21,	#2
    add	x9,	x20,	x11
    add	x5,	x5,	#16
    add	w11,	w16,	#1
    ldr	w13,	[x9]

    ldr	x14,	[sp, fp]

    lsl	w9,	w11,	#2
    lsl	w10,	w13,	#24
    movz	fp,	#468
    add	x13,	x14,	x9
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x13]

    ldr	x14,	[sp, fp]

    lsl	w3,	w1,	#16
    movz	fp,	#468
    add	w6,	w3,	w10
    movk	fp,	#2,	lsl #16
    add	w10,	w16,	#2
    lsl	w19,	w10,	#2
    lsl	w10,	w8,	#2
    add	x11,	x14,	x19
    ldr	w14,	[x11]

    add	w11,	w8,	#1
    lsl	w15,	w14,	#8
    add	w14,	w7,	#1
    add	w22,	w6,	w15
    lsl	w11,	w11,	#2
    add	w15,	w16,	#3
    lsl	w19,	w14,	#2
    mov	x1,	x19
    lsl	w24,	w15,	#2
    add	x1,	sp,	x1
    ldr	x15,	[sp, fp]

    movz	fp,	#468
    add	x20,	x15,	x24
    add	x1,	x1,	#16
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x20]

    add	w9,	w22,	w25
    str	w9,	[x5]

    ldr	x3,	[sp, fp]

    movz	fp,	#468
    add	x7,	x3,	x10
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x7]

    ldr	x6,	[sp, fp]

    lsl	w7,	w10,	#24
    movz	fp,	#468
    add	x13,	x6,	x11
    movk	fp,	#2,	lsl #16
    add	w6,	w8,	#4
    lsl	w11,	w4,	#2
    ldr	w16,	[x13]

    add	w8,	w6,	#3
    add	w10,	w6,	#2
    lsl	w18,	w16,	#16
    add	w16,	w18,	w7
    lsl	w18,	w6,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#468
    add	x24,	x7,	x21
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    add	w24,	w6,	#1
    ldr	x9,	[sp, fp]

    lsl	w28,	w27,	#8
    movz	fp,	#468
    add	x7,	x9,	x11
    add	w27,	w14,	#1
    add	w28,	w16,	w28
    movk	fp,	#2,	lsl #16
    lsl	w14,	w24,	#2
    lsl	w3,	w27,	#2
    ldr	w15,	[x7]

    mov	x9,	x3
    add	w7,	w28,	w15
    add	x9,	sp,	x9
    str	w7,	[x1]

    add	x9,	x9,	#16
    ldr	x13,	[sp, fp]

    movz	fp,	#468
    add	x15,	x13,	x18
    movk	fp,	#2,	lsl #16
    ldr	w19,	[x15]

    ldr	x13,	[sp, fp]

    lsl	w20,	w19,	#24
    movz	fp,	#468
    add	x25,	x13,	x14
    movk	fp,	#2,	lsl #16
    lsl	w13,	w8,	#2
    ldr	w3,	[x25]

    ldr	x15,	[sp, fp]

    lsl	w25,	w10,	#2
    lsl	w5,	w3,	#16
    movz	fp,	#468
    add	x11,	x15,	x25
    movk	fp,	#2,	lsl #16
    add	w7,	w5,	w20
    ldr	w15,	[x11]

    ldr	x19,	[sp, fp]

    lsl	w1,	w15,	#8
    movz	fp,	#468
    add	x10,	x19,	x13
    add	w3,	w7,	w1
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x10]

    add	w10,	w27,	#1
    add	w15,	w3,	w14
    add	w14,	w6,	#4
    str	w15,	[x9]

    lsl	w7,	w10,	#2
    add	w18,	w14,	#3
    add	w8,	w14,	#1
    lsl	w28,	w14,	#2
    ldr	x6,	[sp, fp]

    mov	x16,	x7
    movz	fp,	#468
    lsl	w24,	w18,	#2
    lsl	w19,	w8,	#2
    add	x25,	x6,	x28
    add	w7,	w14,	#2
    add	x16,	sp,	x16
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x25]

    add	x16,	x16,	#16
    ldr	x22,	[sp, fp]

    lsl	w6,	w1,	#24
    movz	fp,	#468
    add	x9,	x22,	x19
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x9]

    ldr	x27,	[sp, fp]

    lsl	w1,	w15,	#16
    movz	fp,	#468
    add	w4,	w1,	w6
    movk	fp,	#2,	lsl #16
    lsl	w1,	w7,	#2
    add	x8,	x27,	x1
    ldr	w11,	[x8]

    ldr	x28,	[sp, fp]

    lsl	w13,	w11,	#8
    movz	fp,	#468
    add	x21,	x28,	x24
    add	w5,	w4,	w13
    movk	fp,	#2,	lsl #16
    add	w13,	w10,	#1
    ldr	w25,	[x21]

    add	w25,	w5,	w25
    lsl	w6,	w13,	#2
    add	w5,	w14,	#4
    mov	x6,	x6
    str	w25,	[x16]

    add	x6,	sp,	x6
    add	w19,	w5,	#2
    lsl	w11,	w5,	#2
    ldr	x15,	[sp, fp]

    add	x6,	x6,	#16
    movz	fp,	#468
    lsl	w4,	w19,	#2
    add	x9,	x15,	x11
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x9]

    ldr	x10,	[sp, fp]

    add	w9,	w5,	#1
    lsl	w3,	w14,	#24
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    lsl	w21,	w9,	#2
    add	w9,	w5,	#3
    add	x10,	x10,	x21
    lsl	w11,	w9,	#2
    ldr	w15,	[x10]

    ldr	x10,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#468
    add	x21,	x10,	x4
    add	w16,	w16,	w3
    movk	fp,	#2,	lsl #16
    add	w4,	w13,	#1
    ldr	w25,	[x21]

    add	w13,	w5,	#4
    ldr	x14,	[sp, fp]

    lsl	w27,	w25,	#8
    movz	fp,	#468
    add	x10,	x14,	x11
    add	w8,	w13,	#2
    add	w21,	w13,	#1
    add	w1,	w16,	w27
    movk	fp,	#2,	lsl #16
    lsl	w11,	w4,	#2
    ldr	w14,	[x10]

    lsl	w7,	w8,	#2
    lsl	w10,	w13,	#2
    add	w9,	w1,	w14
    mov	x1,	x11
    add	x1,	sp,	x1
    str	w9,	[x6]

    ldr	x25,	[sp, fp]

    add	x1,	x1,	#16
    movz	fp,	#468
    add	x9,	x25,	x10
    movk	fp,	#2,	lsl #16
    lsl	w25,	w21,	#2
    add	w10,	w13,	#3
    add	w21,	w13,	#4
    ldr	w11,	[x9]

    mov	w19,	w21
    lsl	w14,	w10,	#2
    ldr	x18,	[sp, fp]

    lsl	w16,	w11,	#24
    movz	fp,	#468
    add	x24,	x18,	x25
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    ldr	x8,	[sp, fp]

    lsl	w28,	w27,	#16
    movz	fp,	#468
    add	x9,	x8,	x7
    add	w28,	w28,	w16
    movk	fp,	#2,	lsl #16
    ldr	w11,	[x9]

    ldr	x10,	[sp, fp]

    lsl	w15,	w11,	#8
    add	x11,	x10,	x14
    add	w5,	w28,	w15
    add	w10,	w4,	#1
    mov	w6,	w10
    ldr	w15,	[x11]

    add	w9,	w5,	w15
    str	w9,	[x1]

    b	main_70

main_215:
    mov	w27,	w6

main_217:
    lsl	w14,	w27,	#2
    lsl	w25,	w19,	#2
    movz	fp,	#468
    add	w9,	w19,	#2
    add	w13,	w19,	#3
    mov	x15,	x14
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    ldr	x6,	[sp, fp]

    add	x15,	x15,	#16
    movz	fp,	#468
    add	x10,	x6,	x25
    movk	fp,	#2,	lsl #16
    add	w25,	w19,	#1
    add	w19,	w19,	#4
    ldr	w14,	[x10]

    lsl	w22,	w25,	#2
    ldr	x6,	[sp, fp]

    lsl	w18,	w14,	#24
    movz	fp,	#468
    add	x28,	x6,	x22
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x28]

    lsl	w6,	w5,	#16
    add	w7,	w6,	w18
    lsl	w6,	w9,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#468
    add	x10,	x9,	x6
    movk	fp,	#2,	lsl #16
    add	w9,	w27,	#1
    ldr	w1,	[x10]

    lsl	w10,	w13,	#2
    lsl	w3,	w1,	#8
    ldr	x13,	[sp, fp]

    add	w1,	w7,	w3
    add	x16,	x13,	x10
    ldr	w24,	[x16]

    add	w10,	w1,	w24
    str	w10,	[x15]

    cmp	w9,	#16
    bge	main_241

main_216:
    mov	w27,	w9
    b	main_217

main_241:
    mov	w11,	w9

main_242:
    cmp	w11,	#80
    bge	main_275

main_245:
    lsl	w24,	w11,	#2
    sub	w28,	w11,	#3
    sub	w1,	w11,	#8
    sub	w16,	w11,	#16
    mov	x3,	x24
    lsl	w5,	w28,	#2
    add	x3,	sp,	x3
    lsl	w7,	w1,	#2
    lsl	w24,	w16,	#2
    mov	x4,	x5
    mov	x19,	x24
    add	x3,	x3,	#16
    mov	x5,	x7
    add	x4,	sp,	x4
    add	x19,	sp,	x19
    add	x5,	sp,	x5
    add	x4,	x4,	#16
    add	x19,	x19,	#16
    add	x5,	x5,	#16
    ldr	w6,	[x4]

    ldr	w15,	[x5]

    add	w13,	w15,	w6
    sub	w10,	w6,	w13
    sub	w6,	w11,	#14
    add	w1,	w10,	w15
    lsl	w10,	w6,	#2
    mov	x7,	x10
    sub	w8,	w1,	w13
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w13,	[x7]

    add	w28,	w13,	w8
    sub	w25,	w8,	w28
    add	w14,	w25,	w13
    sub	w21,	w14,	w28
    ldr	w28,	[x19]

    add	w16,	w28,	w21
    sub	w1,	w21,	w16
    add	w28,	w1,	w28
    sub	w14,	w28,	w16
    asr	w7,	w14,	#31
    lsl	w28,	w14,	#1
    lsr	w8,	w7,	#31
    add	w10,	w14,	w8
    asr	w24,	w10,	#1
    lsl	w25,	w24,	#1
    sub	w10,	w14,	w25
    add	w1,	w28,	w10
    str	w1,	[x3]

    add	w3,	w11,	#1
    mov	w11,	w3
    b	main_242

main_275:
    mov	w28,	w2
    movz	fp,	#460
    mov	w7,	w12
    mov	w20,	w0
    mov	w16,	w26
    mov	w3,	w17
    movz	w13,	#0
    movk	fp,	#2,	lsl #16
    mov	w22,	w13
    str	w28,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w22,	[sp, fp]


main_277:
    movz	w25,	#48348
    movz	w15,	#60289
    movz	w9,	#49414
    movz	w20,	#31129
    movz	fp,	#412
    movk	w25,	#36635,	lsl #16
    movk	w15,	#28377,	lsl #16
    movk	w9,	#51810,	lsl #16
    movk	w20,	#23170,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w19,	w25
    mov	w13,	w15
    mov	w6,	w9
    mov	w10,	w20
    ldr	w18,	[sp, fp]

    movz	w25,	#65535
    movk	w25,	#65535,	lsl #16
    mov	w22,	w25
    cmp	w18,	#20
    bge	main_296

main_285:
    movz	fp,	#456
    mov	w15,	w22
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#456
    add	w28,	w24,	w16
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    sub	w7,	w15,	w21
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    add	w21,	w1,	w7
    add	w25,	w21,	w28
    sub	w24,	w28,	w25
    add	w28,	w24,	w21
    sub	w7,	w28,	w25
    sub	w16,	w7,	w28
    add	w18,	w16,	w25
    sub	w21,	w18,	w28
    mov	w28,	w10
    mov	w24,	w21
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    cmp	w24,	#40
    bge	main_307

main_298:
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#456
    add	w18,	w5,	w1
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    sub	w20,	w1,	w18
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    add	w28,	w20,	w5
    movk	fp,	#2,	lsl #16
    sub	w7,	w28,	w18
    ldr	w18,	[sp, fp]

    movz	fp,	#416
    add	w21,	w18,	w7
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    sub	w18,	w7,	w21
    mov	w7,	w13
    add	w25,	w18,	w8
    sub	w20,	w25,	w21
    mov	w21,	w20
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    cmp	w1,	#60
    bge	main_327

main_309:
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#416
    add	w9,	w11,	w8
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    add	w7,	w24,	w20
    movk	fp,	#2,	lsl #16
    add	w4,	w7,	w9
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    sub	w9,	w9,	w4
    add	w9,	w9,	w7
    sub	w7,	w9,	w4
    sub	w16,	w7,	w9
    add	w18,	w16,	w4
    sub	w16,	w18,	w9
    ldr	w18,	[sp, fp]

    add	w7,	w1,	w18
    add	w25,	w7,	w16
    sub	w16,	w16,	w25
    add	w4,	w16,	w7
    mov	w7,	w19
    sub	w21,	w4,	w25
    sub	w28,	w21,	w4
    add	w9,	w28,	w25
    sub	w18,	w9,	w4
    mov	w21,	w18
    b	main_413

main_327:
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#456
    add	w18,	w16,	w11
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#464
    sub	w16,	w15,	w18
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    add	w25,	w16,	w21
    movk	fp,	#2,	lsl #16
    sub	w7,	w25,	w18
    ldr	w4,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w21,	w4,	w7
    ldr	w16,	[sp, fp]

    sub	w18,	w7,	w21
    add	w7,	w18,	w16
    sub	w18,	w7,	w21
    mov	w7,	w6
    mov	w21,	w18

main_413:
    mov	w24,	w21
    mov	w28,	w7

main_416:
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#460
    lsl	w4,	w16,	#5
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#460
    asr	w7,	w11,	#31
    movk	fp,	#2,	lsl #16
    lsr	w7,	w7,	#27
    ldr	w15,	[sp, fp]

    movz	fp,	#460
    add	w16,	w15,	w7
    movk	fp,	#2,	lsl #16
    asr	w18,	w16,	#5
    ldr	w16,	[sp, fp]

    lsl	w20,	w18,	#5
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    sub	w7,	w16,	w20
    ldr	w20,	[sp, fp]

    movz	fp,	#456
    add	w14,	w4,	w7
    movk	fp,	#2,	lsl #16
    lsl	w4,	w20,	#2
    mov	x25,	x4
    add	w21,	w14,	w3
    add	x25,	sp,	x25
    add	w21,	w21,	w24
    add	x25,	x25,	#16
    add	w3,	w21,	w28
    ldr	w9,	[x25]

    ldr	w16,	[sp, fp]

    movz	fp,	#456
    lsl	w18,	w16,	#30
    add	w3,	w3,	w9
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#456
    asr	w25,	w16,	#31
    movk	fp,	#2,	lsl #16
    lsr	w20,	w25,	#2
    ldr	w16,	[sp, fp]

    movz	fp,	#456
    add	w9,	w16,	w20
    movk	fp,	#2,	lsl #16
    asr	w15,	w9,	#30
    ldr	w21,	[sp, fp]

    movz	fp,	#412
    lsl	w15,	w15,	#30
    movk	fp,	#2,	lsl #16
    sub	w15,	w21,	w15
    ldr	w4,	[sp, fp]

    add	w24,	w4,	#1
    add	w21,	w18,	w15
    cmp	w24,	#20
    bge	main_364

main_336:
    movz	fp,	#460
    mov	w15,	w22
    mov	w25,	w10
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#460
    add	w6,	w21,	w11
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#464
    sub	w14,	w15,	w4
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w15,	w13,	w14
    add	w7,	w15,	w6
    sub	w22,	w6,	w7
    add	w18,	w22,	w15
    sub	w28,	w18,	w7
    sub	w4,	w28,	w18
    add	w6,	w4,	w7
    sub	w13,	w6,	w18
    mov	w14,	w13
    b	main_347

main_364:
    cmp	w24,	#40
    bge	main_378

main_366:
    movz	fp,	#460
    mov	w27,	w13
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#460
    add	w14,	w21,	w11
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#464
    sub	w22,	w25,	w14
    movk	fp,	#2,	lsl #16
    add	w1,	w22,	w21
    sub	w4,	w1,	w14
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    add	w9,	w1,	w4
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    sub	w10,	w4,	w9
    add	w14,	w10,	w22
    sub	w9,	w14,	w9
    b	main_375

main_378:
    cmp	w24,	#60
    bge	main_401

main_380:
    movz	fp,	#460
    mov	w16,	w19
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#460
    add	w20,	w21,	w14
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#464
    add	w27,	w15,	w1
    movk	fp,	#2,	lsl #16
    add	w1,	w27,	w20
    ldr	w7,	[sp, fp]

    add	w25,	w7,	w21
    sub	w6,	w20,	w1
    add	w10,	w6,	w27
    sub	w13,	w10,	w1
    sub	w14,	w13,	w10
    add	w18,	w14,	w1
    sub	w22,	w18,	w10
    add	w9,	w25,	w22
    sub	w7,	w22,	w9
    add	w1,	w7,	w25
    sub	w13,	w1,	w9
    sub	w14,	w13,	w1
    add	w18,	w14,	w9
    sub	w9,	w18,	w1
    mov	w13,	w9
    b	main_398

main_401:
    movz	fp,	#460
    mov	w16,	w6
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#460
    add	w1,	w21,	w22
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#464
    sub	w4,	w9,	w1
    movk	fp,	#2,	lsl #16
    add	w7,	w4,	w21
    ldr	w13,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    sub	w10,	w7,	w1
    ldr	w5,	[sp, fp]

    add	w4,	w13,	w10
    sub	w15,	w10,	w4
    add	w19,	w15,	w5
    sub	w10,	w19,	w4
    mov	w13,	w10

main_398:
    mov	w9,	w13
    mov	w27,	w16

main_375:
    mov	w14,	w9
    mov	w25,	w27

main_347:
    lsl	w4,	w3,	#5
    asr	w9,	w3,	#31
    movz	fp,	#416
    lsr	w10,	w9,	#27
    movk	fp,	#2,	lsl #16
    add	w19,	w3,	w10
    asr	w19,	w19,	#5
    lsl	w27,	w19,	#5
    lsl	w19,	w24,	#2
    sub	w18,	w3,	w27
    mov	x10,	x19
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w13,	[x10]

    ldr	w8,	[sp, fp]

    movz	fp,	#460
    add	w1,	w18,	w8
    movk	fp,	#2,	lsl #16
    add	w27,	w1,	w4
    ldr	w28,	[sp, fp]

    movz	fp,	#460
    lsl	w11,	w28,	#30
    movk	fp,	#2,	lsl #16
    add	w19,	w27,	w14
    ldr	w10,	[sp, fp]

    movz	fp,	#460
    asr	w15,	w10,	#31
    add	w1,	w19,	w25
    movk	fp,	#2,	lsl #16
    lsr	w19,	w15,	#2
    add	w16,	w1,	w13
    ldr	w1,	[sp, fp]

    movz	fp,	#460
    add	w1,	w1,	w19
    movk	fp,	#2,	lsl #16
    asr	w7,	w1,	#30
    ldr	w6,	[sp, fp]

    lsl	w10,	w7,	#30
    sub	w10,	w6,	w10
    add	w6,	w24,	#1
    add	w28,	w11,	w10
    cmp	w6,	#80
    blt	main_276

main_433:
    add	w4,	w16,	w2
    add	w11,	w28,	w0
    movz	fp,	#464
    add	w23,	w23,	#64
    add	w16,	w3,	w12
    add	w28,	w21,	w26
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#496
    add	w20,	w6,	w17
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    cmp	w23,	w5
    blt	main_62

main_441:
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#432
    str	w4,	[x23]

    movk	fp,	#2,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#424
    str	w16,	[x4]

    movk	fp,	#2,	lsl #16
    ldr	x18,	[sp, fp]

    movz	fp,	#488
    str	w11,	[x18]

    movk	fp,	#2,	lsl #16
    movz	w11,	#0
    ldr	x26,	[sp, fp]

    movz	fp,	#480
    str	w28,	[x26]

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
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w27,	w26,	#1
    cmp	w27,	#0
    ble	main_460

main_27:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    mov	w8,	w19
    b	main_28

main_62:
    mov	w2,	w4
    mov	w12,	w16
    mov	w0,	w11
    mov	w26,	w28
    mov	w17,	w20
    b	main_63

main_276:
    mov	w15,	w16
    movz	fp,	#460
    mov	w20,	w21
    mov	w1,	w6
    mov	w4,	w28
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#412
    mov	w3,	w11
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#508
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


