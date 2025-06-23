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
    movz	fp,	#336
    movz	w24,	#0
    movz	w23,	#0
    movz	w26,	#0
    movz	w25,	#0
    movk	fp,	#2,	lsl #16
    add	x20,	sp,	fp
    movz	fp,	#340
    movk	fp,	#2,	lsl #16
    str	w26,	[x20]

    add	x19,	sp,	fp
    movz	fp,	#344
    movk	fp,	#2,	lsl #16
    str	w25,	[x19]

    add	x21,	sp,	fp
    movz	fp,	#348
    movk	fp,	#2,	lsl #16
    str	w24,	[x21]

    add	x22,	sp,	fp
    movz	fp,	#352
    movk	fp,	#2,	lsl #16
    str	w23,	[x22]

    add	x24,	sp,	fp
    movz	w22,	#0
    str	w22,	[x24]

    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w27,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	fp,	#356
    movz	w6,	#0
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#360
    str	w6,	[x12]

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

    cmp	w27,	#0
    ble	main_460

main_18:
    add	x17,	sp,	#336
    movz	fp,	#436
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x26,	x20
    add	x8,	x20,	#12
    add	x16,	x20,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x20,	#4
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#532
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#412
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#412
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#412
    add	w1,	w15,	w17
    movk	fp,	#2,	lsl #16
    asr	w18,	w1,	#31
    lsr	w19,	w18,	#15
    add	w20,	w1,	w19
    asr	w19,	w20,	#17
    add	w3,	w1,	w19
    lsl	w21,	w3,	#5
    add	w1,	w3,	w21
    asr	w22,	w1,	#31
    lsr	w23,	w22,	#24
    add	w24,	w1,	w23
    asr	w21,	w24,	#8
    lsl	w22,	w21,	#8
    sub	w24,	w1,	w22
    str	w24,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w20,	#128
    movz	fp,	#532
    movz	w0,	#32001
    movk	fp,	#2,	lsl #16
    mov	w3,	w0
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


main_46:
    asr	w23,	w3,	#31
    lsr	w24,	w23,	#26
    add	w27,	w3,	w24
    asr	w28,	w27,	#6
    lsl	w1,	w28,	#6
    sub	w24,	w3,	w1
    cmp	w24,	#60
    beq	main_53

main_50:
    lsl	w2,	w3,	#2
    movz	fp,	#436
    movz	w0,	#0
    add	w12,	w3,	#1
    movk	fp,	#2,	lsl #16
    mov	w3,	w12
    ldr	x7,	[sp, fp]

    add	x8,	x7,	x2
    str	w0,	[x8]

    b	main_46

main_53:
    lsl	w24,	w3,	#2
    movz	fp,	#436
    add	w21,	w3,	#1
    movz	w22,	#125
    add	w19,	w3,	#4
    movk	fp,	#2,	lsl #16
    lsl	w27,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x23,	x28,	x24
    movk	fp,	#2,	lsl #16
    movz	w24,	#0
    movz	w28,	#0
    str	w28,	[x23]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x27
    movk	fp,	#2,	lsl #16
    str	w24,	[x1]

    ldr	x0,	[sp, fp]

    add	w24,	w3,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w24,	#2
    add	x20,	x0,	x2
    movz	w2,	#0
    add	w0,	w3,	#3
    str	w22,	[x20]

    lsl	w24,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#460
    add	x23,	x1,	x24
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x23]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w23,	#0
    movz	w17,	#8961
    movz	w24,	#43913
    movz	w5,	#56574
    movz	w4,	#21622
    movz	w21,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w24,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w4,	#4146,	lsl #16
    movk	w21,	#50130,	lsl #16
    mov	w2,	w17
    mov	w12,	w24
    mov	w0,	w5
    mov	w16,	w4
    mov	w27,	w21

main_63:
    movz	w18,	#0
    mov	w22,	w23
    mov	w11,	w18

main_70:
    cmp	w11,	#14
    bge	main_215

main_74:
    lsl	w15,	w11,	#2
    lsl	w6,	w22,	#2
    movz	fp,	#436
    add	w1,	w22,	#1
    mov	x15,	x15
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    lsl	w17,	w1,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x5,	x28,	x6
    add	x15,	x15,	#16
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x5]

    ldr	x10,	[sp, fp]

    lsl	w13,	w7,	#24
    movz	fp,	#436
    add	x3,	x10,	x17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x3]

    ldr	x25,	[sp, fp]

    lsl	w7,	w6,	#16
    movz	fp,	#436
    add	w9,	w7,	w13
    movk	fp,	#2,	lsl #16
    add	w7,	w22,	#3
    add	w13,	w22,	#2
    lsl	w10,	w7,	#2
    lsl	w6,	w13,	#2
    add	w13,	w22,	#4
    add	x18,	x25,	x6
    add	w17,	w13,	#2
    ldr	w1,	[x18]

    ldr	x28,	[sp, fp]

    lsl	w3,	w1,	#8
    movz	fp,	#436
    add	x8,	x28,	x10
    add	w5,	w9,	w3
    movk	fp,	#2,	lsl #16
    lsl	w28,	w13,	#2
    add	w10,	w11,	#1
    ldr	w14,	[x8]

    lsl	w9,	w17,	#2
    add	w8,	w5,	w14
    lsl	w7,	w10,	#2
    mov	x5,	x7
    str	w8,	[x15]

    add	x5,	sp,	x5
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x24,	x8,	x28
    add	x5,	x5,	#16
    movk	fp,	#2,	lsl #16
    add	w28,	w13,	#1
    ldr	w1,	[x24]

    lsl	w20,	w1,	#24
    lsl	w14,	w28,	#2
    ldr	x1,	[sp, fp]

    add	w28,	w13,	#4
    movz	fp,	#436
    add	x1,	x1,	x14
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x1]

    ldr	x3,	[sp, fp]

    lsl	w7,	w4,	#16
    movz	fp,	#436
    add	x1,	x3,	x9
    add	w4,	w10,	#1
    add	w14,	w7,	w20
    movk	fp,	#2,	lsl #16
    add	w9,	w13,	#3
    ldr	w6,	[x1]

    add	w13,	w28,	#3
    lsl	w7,	w6,	#8
    lsl	w15,	w9,	#2
    lsl	w6,	w28,	#2
    add	w20,	w14,	w7
    ldr	x9,	[sp, fp]

    movz	fp,	#436
    add	x14,	x9,	x15
    movk	fp,	#2,	lsl #16
    lsl	w9,	w4,	#2
    mov	x8,	x9
    ldr	w18,	[x14]

    add	w9,	w28,	#1
    add	x8,	sp,	x8
    add	w3,	w20,	w18
    add	w18,	w28,	#2
    lsl	w22,	w9,	#2
    str	w3,	[x5]

    add	x8,	x8,	#16
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x3,	x1,	x6
    movk	fp,	#2,	lsl #16
    lsl	w1,	w18,	#2
    ldr	w7,	[x3]

    ldr	x15,	[sp, fp]

    lsl	w3,	w7,	#24
    movz	fp,	#436
    add	x11,	x15,	x22
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x11]

    ldr	x20,	[sp, fp]

    lsl	w15,	w14,	#16
    movz	fp,	#436
    add	x24,	x20,	x1
    add	w17,	w15,	w3
    movk	fp,	#2,	lsl #16
    lsl	w1,	w13,	#2
    ldr	w3,	[x24]

    add	w13,	w4,	#1
    ldr	x6,	[sp, fp]

    lsl	w7,	w3,	#8
    movz	fp,	#436
    add	x15,	x6,	x1
    add	w3,	w17,	w7
    movk	fp,	#2,	lsl #16
    add	w17,	w28,	#4
    ldr	w5,	[x15]

    lsl	w28,	w13,	#2
    add	w10,	w3,	w5
    add	w5,	w17,	#1
    str	w10,	[x8]

    ldr	x9,	[sp, fp]

    mov	x8,	x28
    movz	fp,	#436
    lsl	w28,	w17,	#2
    add	x8,	sp,	x8
    movk	fp,	#2,	lsl #16
    add	x24,	x9,	x28
    lsl	w9,	w5,	#2
    add	x8,	x8,	#16
    ldr	w1,	[x24]

    add	w24,	w17,	#3
    ldr	x6,	[sp, fp]

    lsl	w1,	w1,	#24
    movz	fp,	#436
    add	x7,	x6,	x9
    movk	fp,	#2,	lsl #16
    add	w6,	w17,	#2
    ldr	w11,	[x7]

    lsl	w9,	w6,	#2
    ldr	x14,	[sp, fp]

    lsl	w15,	w11,	#16
    movz	fp,	#436
    add	x7,	x14,	x9
    movk	fp,	#2,	lsl #16
    add	w1,	w15,	w1
    ldr	w11,	[x7]

    add	w7,	w17,	#4
    ldr	x14,	[sp, fp]

    lsl	w15,	w11,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w11,	w7,	#1
    add	w5,	w1,	w15
    lsl	w1,	w24,	#2
    lsl	w11,	w11,	#2
    add	x28,	x14,	x1
    ldr	w3,	[x28]

    add	w28,	w7,	#2
    add	w3,	w5,	w3
    add	w5,	w13,	#1
    str	w3,	[x8]

    lsl	w28,	w28,	#2
    add	w9,	w5,	#1
    ldr	x18,	[sp, fp]

    lsl	w3,	w5,	#2
    movz	fp,	#436
    mov	x15,	x3
    movk	fp,	#2,	lsl #16
    lsl	w3,	w7,	#2
    add	x15,	sp,	x15
    add	x1,	x18,	x3
    add	x15,	x15,	#16
    ldr	w6,	[x1]

    ldr	x18,	[sp, fp]

    lsl	w8,	w6,	#24
    movz	fp,	#436
    add	x13,	x18,	x11
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x13]

    ldr	x13,	[sp, fp]

    lsl	w18,	w17,	#16
    movz	fp,	#436
    add	x1,	x13,	x28
    add	w17,	w18,	w8
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x1]

    ldr	x25,	[sp, fp]

    add	w1,	w7,	#3
    lsl	w11,	w4,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w6,	w1,	#2
    add	w10,	w17,	w11
    lsl	w17,	w9,	#2
    add	w11,	w7,	#4
    add	x3,	x25,	x6
    add	w13,	w11,	#2
    lsl	w22,	w11,	#2
    ldr	w8,	[x3]

    mov	x3,	x17
    add	w8,	w10,	w8
    add	x3,	sp,	x3
    add	w10,	w11,	#1
    str	w8,	[x15]

    add	x3,	x3,	#16
    lsl	w7,	w10,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x18,	x1,	x22
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x18]

    ldr	x26,	[sp, fp]

    lsl	w4,	w24,	#24
    movz	fp,	#436
    add	x14,	x26,	x7
    add	w24,	w11,	#3
    movk	fp,	#2,	lsl #16
    lsl	w7,	w13,	#2
    ldr	w1,	[x14]

    lsl	w5,	w1,	#16
    add	w6,	w5,	w4
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x15,	x4,	x7
    movk	fp,	#2,	lsl #16
    lsl	w4,	w24,	#2
    ldr	w18,	[x15]

    ldr	x8,	[sp, fp]

    lsl	w20,	w18,	#8
    movz	fp,	#436
    add	x1,	x8,	x4
    add	w20,	w6,	w20
    movk	fp,	#2,	lsl #16
    add	w4,	w11,	#4
    add	w8,	w9,	#1
    ldr	w5,	[x1]

    add	w28,	w20,	w5
    add	w22,	w4,	#4
    add	w17,	w4,	#1
    lsl	w6,	w8,	#2
    str	w28,	[x3]

    mov	x1,	x6
    lsl	w10,	w17,	#2
    ldr	x15,	[sp, fp]

    lsl	w3,	w4,	#2
    add	x1,	sp,	x1
    movz	fp,	#436
    add	x14,	x15,	x3
    movk	fp,	#2,	lsl #16
    add	x1,	x1,	#16
    ldr	w7,	[x14]

    ldr	x17,	[sp, fp]

    lsl	w15,	w7,	#24
    movz	fp,	#436
    add	x18,	x17,	x10
    movk	fp,	#2,	lsl #16
    add	w10,	w4,	#2
    ldr	w24,	[x18]

    lsl	w21,	w10,	#2
    ldr	x17,	[sp, fp]

    lsl	w28,	w24,	#16
    add	w10,	w4,	#3
    movz	fp,	#436
    add	x11,	x17,	x21
    add	w3,	w28,	w15
    movk	fp,	#2,	lsl #16
    lsl	w13,	w10,	#2
    ldr	w17,	[x11]

    ldr	x21,	[sp, fp]

    lsl	w5,	w17,	#8
    add	x11,	x21,	x13
    add	w3,	w3,	w5
    add	w5,	w8,	#1
    ldr	w14,	[x11]

    mov	w11,	w5
    add	w9,	w3,	w14
    str	w9,	[x1]

    b	main_70

main_215:
    mov	w20,	w22
    mov	w3,	w11

main_217:
    lsl	w8,	w3,	#2
    lsl	w13,	w20,	#2
    movz	fp,	#436
    add	w4,	w20,	#1
    add	w1,	w20,	#2
    add	w24,	w3,	#1
    add	w21,	w20,	#4
    mov	x7,	x8
    movk	fp,	#2,	lsl #16
    lsl	w28,	w4,	#2
    add	x7,	sp,	x7
    ldr	x6,	[sp, fp]

    movz	fp,	#436
    add	x14,	x6,	x13
    add	x7,	x7,	#16
    movk	fp,	#2,	lsl #16
    lsl	w13,	w1,	#2
    ldr	w17,	[x14]

    ldr	x4,	[sp, fp]

    lsl	w22,	w17,	#24
    movz	fp,	#436
    add	x5,	x4,	x28
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x5]

    ldr	x6,	[sp, fp]

    lsl	w11,	w9,	#16
    movz	fp,	#436
    add	x4,	x6,	x13
    add	w11,	w11,	w22
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x4]

    add	w4,	w20,	#3
    lsl	w10,	w9,	#8
    ldr	x9,	[sp, fp]

    add	w10,	w11,	w10
    lsl	w18,	w4,	#2
    add	x5,	x9,	x18
    ldr	w13,	[x5]

    add	w22,	w10,	w13
    str	w22,	[x7]

    cmp	w24,	#16
    bge	main_241

main_216:
    mov	w20,	w21
    mov	w3,	w24
    b	main_217

main_241:
    mov	w14,	w24
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#524
    lsl	w21,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x21
    add	x18,	sp,	x18
    ldr	w25,	[sp, fp]

    movz	fp,	#524
    sub	w24,	w25,	#3
    add	x18,	x18,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w24,	#2
    mov	x28,	x3
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    ldr	w4,	[x28]

    ldr	w5,	[sp, fp]

    movz	fp,	#524
    sub	w7,	w5,	#8
    movk	fp,	#2,	lsl #16
    lsl	w9,	w7,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w5,	[sp, fp]

    add	w8,	w10,	w4
    movz	fp,	#524
    sub	w22,	w5,	#14
    movk	fp,	#2,	lsl #16
    sub	w13,	w4,	w8
    lsl	w28,	w22,	#2
    mov	x24,	x28
    add	w15,	w13,	w10
    add	x24,	sp,	x24
    sub	w8,	w15,	w8
    add	x24,	x24,	#16
    ldr	w1,	[x24]

    ldr	w6,	[sp, fp]

    add	w28,	w1,	w8
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    sub	w3,	w8,	w28
    add	w7,	w3,	w1
    sub	w1,	w6,	#16
    sub	w22,	w7,	w28
    lsl	w5,	w1,	#2
    mov	x3,	x5
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    ldr	w6,	[x3]

    add	w5,	w6,	w22
    sub	w10,	w22,	w5
    add	w11,	w10,	w6
    sub	w14,	w11,	w5
    asr	w1,	w14,	#31
    lsl	w7,	w14,	#1
    lsr	w3,	w1,	#31
    add	w5,	w14,	w3
    asr	w11,	w5,	#1
    lsl	w13,	w11,	#1
    sub	w6,	w14,	w13
    add	w7,	w7,	w6
    str	w7,	[x18]

    ldr	w17,	[sp, fp]

    movz	fp,	#524
    add	w8,	w17,	#1
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w22,	w2
    movz	fp,	#428
    mov	w3,	w12
    mov	w18,	w0
    mov	w10,	w16
    mov	w28,	w27
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    mov	w26,	w6
    str	w22,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]


main_277:
    movz	w4,	#48348
    movz	w10,	#60289
    movz	w24,	#31129
    movz	w21,	#65535
    movz	fp,	#404
    movk	w4,	#36635,	lsl #16
    movk	w10,	#28377,	lsl #16
    movk	w24,	#23170,	lsl #16
    movk	w21,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w20,	w4
    mov	w9,	w10
    mov	w15,	w24
    mov	w17,	w21
    ldr	w13,	[sp, fp]

    movz	w4,	#49414
    movk	w4,	#51810,	lsl #16
    cmp	w13,	#20
    bge	main_296

main_285:
    movz	fp,	#416
    mov	w1,	w17
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    add	w5,	w21,	w14
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#408
    sub	w1,	w1,	w11
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    add	w10,	w14,	w1
    add	w18,	w10,	w5
    sub	w6,	w5,	w18
    add	w21,	w6,	w10
    sub	w24,	w21,	w18
    sub	w1,	w24,	w21
    mov	w24,	w15
    add	w7,	w1,	w18
    sub	w5,	w7,	w21
    b	main_416

main_296:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    cmp	w14,	#40
    bge	main_307

main_298:
    movz	fp,	#416
    mov	w24,	w9
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#416
    add	w5,	w26,	w22
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    sub	w10,	w18,	w5
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#408
    add	w22,	w10,	w6
    movk	fp,	#2,	lsl #16
    sub	w21,	w22,	w5
    ldr	w6,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w1,	w6,	w21
    ldr	w25,	[sp, fp]

    sub	w5,	w21,	w1
    add	w5,	w5,	w25
    sub	w5,	w5,	w1
    mov	w6,	w5
    b	main_413

main_307:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    cmp	w18,	#60
    bge	main_327

main_309:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#408
    add	w22,	w7,	w6
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#408
    add	w10,	w8,	w18
    movk	fp,	#2,	lsl #16
    add	w24,	w10,	w22
    ldr	w14,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w1,	w22,	w24
    ldr	w11,	[sp, fp]

    add	w10,	w1,	w10
    sub	w1,	w10,	w24
    sub	w7,	w1,	w10
    add	w18,	w7,	w24
    mov	w24,	w20
    sub	w5,	w18,	w10
    add	w18,	w14,	w11
    add	w21,	w18,	w5
    sub	w22,	w5,	w21
    add	w7,	w22,	w18
    sub	w18,	w7,	w21
    sub	w1,	w18,	w7
    add	w10,	w1,	w21
    sub	w5,	w10,	w7
    mov	w6,	w5
    b	main_413

main_327:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#416
    add	w1,	w14,	w8
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w7,	w1
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#408
    add	w7,	w7,	w21
    movk	fp,	#2,	lsl #16
    sub	w5,	w7,	w1
    ldr	w14,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w1,	w14,	w5
    ldr	w10,	[sp, fp]

    sub	w24,	w5,	w1
    add	w6,	w24,	w10
    mov	w24,	w4
    sub	w5,	w6,	w1
    mov	w6,	w5

main_413:
    mov	w5,	w6

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    lsl	w7,	w1,	#5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#428
    asr	w18,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w21,	w18,	#27
    ldr	w11,	[sp, fp]

    movz	fp,	#428
    add	w10,	w11,	w21
    movk	fp,	#2,	lsl #16
    asr	w18,	w10,	#5
    ldr	w14,	[sp, fp]

    movz	fp,	#404
    lsl	w21,	w18,	#5
    movk	fp,	#2,	lsl #16
    sub	w10,	w14,	w21
    ldr	w18,	[sp, fp]

    movz	fp,	#416
    lsl	w1,	w18,	#2
    movk	fp,	#2,	lsl #16
    mov	x1,	x1
    add	w21,	w7,	w10
    add	x1,	sp,	x1
    add	w21,	w21,	w28
    add	x1,	x1,	#16
    add	w6,	w21,	w5
    ldr	w10,	[x1]

    add	w18,	w6,	w24
    add	w10,	w18,	w10
    ldr	w18,	[sp, fp]

    movz	fp,	#416
    lsl	w18,	w18,	#30
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#416
    asr	w5,	w14,	#31
    movk	fp,	#2,	lsl #16
    lsr	w6,	w5,	#2
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    add	w7,	w8,	w6
    movk	fp,	#2,	lsl #16
    asr	w7,	w7,	#30
    ldr	w14,	[sp, fp]

    movz	fp,	#404
    lsl	w5,	w7,	#30
    movk	fp,	#2,	lsl #16
    sub	w6,	w14,	w5
    ldr	w8,	[sp, fp]

    add	w24,	w8,	#1
    add	w18,	w18,	w6
    cmp	w24,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w7,	w17
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    add	w22,	w18,	w1
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w7,	w3
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    add	w4,	w11,	w1
    add	w6,	w4,	w22
    sub	w14,	w22,	w6
    add	w13,	w14,	w4
    sub	w14,	w13,	w6
    sub	w17,	w14,	w13
    mov	w14,	w15
    add	w21,	w17,	w6
    sub	w20,	w21,	w13
    mov	w22,	w20
    b	main_347

main_364:
    cmp	w24,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    add	w13,	w18,	w17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#432
    sub	w21,	w6,	w13
    movk	fp,	#2,	lsl #16
    add	w1,	w21,	w18
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w1,	w1,	w13
    ldr	w25,	[sp, fp]

    add	w17,	w15,	w1
    sub	w6,	w1,	w17
    mov	w1,	w9
    add	w13,	w6,	w25
    sub	w15,	w13,	w17
    b	main_375

main_378:
    cmp	w24,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w17,	w18,	w22
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    add	w15,	w3,	w8
    movk	fp,	#2,	lsl #16
    add	w1,	w15,	w17
    ldr	w25,	[sp, fp]

    add	w13,	w25,	w18
    sub	w4,	w17,	w1
    add	w6,	w4,	w15
    mov	w4,	w20
    sub	w14,	w6,	w1
    sub	w15,	w14,	w6
    add	w1,	w15,	w1
    sub	w5,	w1,	w6
    add	w1,	w13,	w5
    sub	w9,	w5,	w1
    add	w28,	w9,	w13
    sub	w14,	w28,	w1
    sub	w21,	w14,	w28
    add	w22,	w21,	w1
    sub	w14,	w22,	w28
    mov	w17,	w14
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    add	w13,	w18,	w1
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w17,	w13
    movk	fp,	#2,	lsl #16
    add	w9,	w7,	w18
    ldr	w28,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w1,	w9,	w13
    ldr	w7,	[sp, fp]

    add	w15,	w28,	w1
    sub	w13,	w1,	w15
    add	w28,	w13,	w7
    sub	w15,	w28,	w15
    mov	w17,	w15

main_398:
    mov	w15,	w17
    mov	w1,	w4

main_375:
    mov	w22,	w15
    mov	w14,	w1

main_347:
    lsl	w15,	w10,	#5
    asr	w4,	w10,	#31
    lsl	w21,	w24,	#2
    movz	fp,	#408
    lsr	w6,	w4,	#27
    mov	x13,	x21
    movk	fp,	#2,	lsl #16
    add	w21,	w24,	#1
    add	x13,	sp,	x13
    add	w7,	w10,	w6
    add	x13,	x13,	#16
    asr	w6,	w7,	#5
    lsl	w7,	w6,	#5
    ldr	w1,	[x13]

    sub	w7,	w10,	w7
    ldr	w20,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w7,	w7,	w20
    ldr	w5,	[sp, fp]

    movz	fp,	#428
    add	w9,	w7,	w15
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    add	w15,	w9,	w22
    movz	fp,	#428
    asr	w11,	w26,	#31
    movk	fp,	#2,	lsl #16
    add	w9,	w15,	w14
    lsr	w20,	w11,	#2
    add	w17,	w9,	w1
    ldr	w1,	[sp, fp]

    lsl	w9,	w5,	#30
    movz	fp,	#428
    add	w15,	w1,	w20
    movk	fp,	#2,	lsl #16
    asr	w6,	w15,	#30
    ldr	w5,	[sp, fp]

    lsl	w11,	w6,	#30
    sub	w13,	w5,	w11
    add	w22,	w9,	w13
    cmp	w21,	#80
    blt	main_276

main_433:
    add	w4,	w17,	w2
    add	w15,	w22,	w0
    add	w18,	w18,	w16
    movz	fp,	#432
    add	w28,	w23,	#64
    add	w17,	w10,	w12
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w9,	w7,	w27
    cmp	w28,	w19
    blt	main_62

main_441:
    movz	fp,	#484
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#452
    str	w4,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#476
    str	w17,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#468
    str	w15,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#444
    str	w18,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w9,	[x23]


main_442:
    cmp	w27,	#5
    bge	main_455

main_445:
    lsl	w16,	w27,	#2
    movz	fp,	#356
    lsl	w11,	w27,	#2
    mov	x22,	x16
    movk	fp,	#2,	lsl #16
    add	w27,	w27,	#1
    mov	x10,	x11
    add	x22,	sp,	x22
    add	x10,	sp,	x10
    add	x22,	x22,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x22]

    add	x10,	x10,	fp
    ldr	w15,	[x10]

    add	w4,	w15,	w16
    sub	w0,	w16,	w4
    add	w16,	w0,	w15
    sub	w20,	w16,	w4
    str	w20,	[x22]

    b	main_442

main_455:
    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w4,	w26,	#1
    cmp	w4,	#0
    ble	main_460

main_27:
    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w2,	w4
    mov	w12,	w17
    mov	w0,	w15
    mov	w16,	w18
    mov	w27,	w9
    mov	w23,	w28
    b	main_63

main_276:
    mov	w15,	w17
    movz	fp,	#428
    mov	w26,	w10
    mov	w11,	w18
    mov	w7,	w21
    movk	fp,	#2,	lsl #16
    mov	w10,	w22
    str	w15,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#404
    mov	w28,	w9
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#540
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


