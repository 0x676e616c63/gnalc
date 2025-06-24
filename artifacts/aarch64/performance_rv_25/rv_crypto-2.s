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
    movz	w26,	#0
    movz	w24,	#0
    movz	w23,	#0
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
    movz	w6,	#0
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#500
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
    mov	w1,	w19
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x20,	#4
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#492
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w1
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#420
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#420
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#420
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
    add	w25,	w1,	w23
    asr	w21,	w25,	#8
    lsl	w22,	w21,	#8
    sub	w25,	w1,	w22
    str	w25,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w20,	#128
    movz	fp,	#492
    movz	w28,	#32001
    movk	fp,	#2,	lsl #16
    mov	w3,	w28
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


main_46:
    asr	w23,	w3,	#31
    lsr	w26,	w23,	#26
    add	w27,	w3,	w26
    asr	w28,	w27,	#6
    lsl	w0,	w28,	#6
    sub	w26,	w3,	w0
    cmp	w26,	#60
    beq	main_53

main_50:
    lsl	w1,	w3,	#2
    movz	fp,	#436
    movz	w0,	#0
    add	w12,	w3,	#1
    movk	fp,	#2,	lsl #16
    mov	w3,	w12
    ldr	x7,	[sp, fp]

    add	x8,	x7,	x1
    str	w0,	[x8]

    b	main_46

main_53:
    lsl	w2,	w3,	#2
    movz	fp,	#436
    add	w21,	w3,	#1
    movz	w26,	#0
    movz	w22,	#125
    movk	fp,	#2,	lsl #16
    lsl	w27,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x23,	x28,	x2
    movk	fp,	#2,	lsl #16
    movz	w28,	#0
    str	w28,	[x23]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x27
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    ldr	x0,	[sp, fp]

    add	w26,	w3,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x19,	x0,	x2
    movz	w2,	#0
    add	w0,	w3,	#3
    str	w22,	[x19]

    lsl	w26,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#524
    add	x23,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x23]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    add	w23,	w3,	#4
    bl	memset
    movz	w17,	#8961
    movz	w21,	#43913
    movz	w3,	#56574
    movz	w19,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w21,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w19,	#50130,	lsl #16
    mov	w27,	w17
    mov	w12,	w21
    mov	w4,	w3
    mov	w26,	w19
    movz	w21,	#0
    movz	w3,	#21622
    mov	w22,	w21
    movk	w3,	#4146,	lsl #16
    mov	w15,	w3

main_63:
    movz	w17,	#0
    mov	w20,	w22
    mov	w10,	w17

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w14,	w10,	#2
    lsl	w3,	w20,	#2
    movz	fp,	#436
    add	w0,	w20,	#1
    add	w11,	w20,	#2
    add	w10,	w10,	#1
    mov	x14,	x14
    movk	fp,	#2,	lsl #16
    lsl	w16,	w0,	#2
    add	x14,	sp,	x14
    lsl	w5,	w11,	#2
    ldr	x28,	[sp, fp]

    add	w11,	w20,	#4
    movz	fp,	#436
    add	x14,	x14,	#16
    add	x2,	x28,	x3
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w13,	w6,	#24
    movz	fp,	#436
    add	x1,	x9,	x16
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x1]

    ldr	x24,	[sp, fp]

    lsl	w6,	w3,	#16
    movz	fp,	#436
    add	x17,	x24,	x5
    add	w8,	w6,	w13
    movk	fp,	#2,	lsl #16
    add	w6,	w20,	#3
    ldr	w0,	[x17]

    add	w17,	w11,	#2
    ldr	x28,	[sp, fp]

    lsl	w9,	w6,	#2
    lsl	w1,	w0,	#8
    movz	fp,	#436
    lsl	w6,	w10,	#2
    add	x7,	x28,	x9
    add	w2,	w8,	w1
    movk	fp,	#2,	lsl #16
    mov	x3,	x6
    lsl	w28,	w11,	#2
    lsl	w8,	w17,	#2
    ldr	w16,	[x7]

    add	x3,	sp,	x3
    add	w7,	w2,	w16
    add	x3,	x3,	#16
    str	w7,	[x14]

    ldr	x7,	[sp, fp]

    movz	fp,	#436
    add	x21,	x7,	x28
    movk	fp,	#2,	lsl #16
    add	w28,	w11,	#1
    ldr	w0,	[x21]

    lsl	w14,	w28,	#2
    lsl	w18,	w0,	#24
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x0,	x0,	x14
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x0]

    ldr	x1,	[sp, fp]

    lsl	w6,	w2,	#16
    movz	fp,	#436
    add	x0,	x1,	x8
    add	w13,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	w8,	w11,	#3
    ldr	w2,	[x0]

    lsl	w5,	w2,	#8
    lsl	w16,	w8,	#2
    add	w18,	w13,	w5
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x9,	x8,	x16
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x9]

    add	w1,	w18,	w17
    str	w1,	[x3]

    ldr	x0,	[sp, fp]

    add	w3,	w10,	#1
    movz	fp,	#436
    add	w10,	w11,	#4
    movk	fp,	#2,	lsl #16
    lsl	w8,	w3,	#2
    add	w16,	w10,	#4
    add	w17,	w10,	#2
    add	w7,	w10,	#1
    lsl	w5,	w10,	#2
    mov	x2,	x8
    lsl	w28,	w17,	#2
    add	x1,	x0,	x5
    lsl	w13,	w7,	#2
    add	x2,	sp,	x2
    add	w5,	w10,	#3
    ldr	w6,	[x1]

    add	x2,	x2,	#16
    ldr	x18,	[sp, fp]

    lsl	w1,	w6,	#24
    movz	fp,	#436
    add	x9,	x18,	x13
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x9]

    ldr	x18,	[sp, fp]

    lsl	w14,	w13,	#16
    movz	fp,	#436
    add	x18,	x18,	x28
    add	w13,	w14,	w1
    movk	fp,	#2,	lsl #16
    ldr	w28,	[x18]

    ldr	x6,	[sp, fp]

    lsl	w0,	w28,	#8
    movz	fp,	#436
    add	w1,	w13,	w0
    movk	fp,	#2,	lsl #16
    add	w13,	w3,	#1
    lsl	w0,	w5,	#2
    add	w3,	w16,	#1
    add	x17,	x6,	x0
    lsl	w28,	w13,	#2
    mov	x7,	x28
    ldr	w5,	[x17]

    lsl	w28,	w16,	#2
    add	x7,	sp,	x7
    add	w8,	w1,	w5
    add	x7,	x7,	#16
    str	w8,	[x2]

    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x21,	x8,	x28
    movk	fp,	#2,	lsl #16
    lsl	w8,	w3,	#2
    ldr	w0,	[x21]

    add	w21,	w16,	#3
    ldr	x3,	[sp, fp]

    lsl	w0,	w0,	#24
    movz	fp,	#436
    add	x6,	x3,	x8
    movk	fp,	#2,	lsl #16
    add	w3,	w16,	#2
    ldr	w10,	[x6]

    lsl	w8,	w3,	#2
    ldr	x11,	[sp, fp]

    lsl	w17,	w10,	#16
    movz	fp,	#436
    add	x5,	x11,	x8
    movk	fp,	#2,	lsl #16
    add	w0,	w17,	w0
    ldr	w10,	[x5]

    ldr	x11,	[sp, fp]

    lsl	w14,	w10,	#8
    movz	fp,	#436
    add	w2,	w0,	w14
    movk	fp,	#2,	lsl #16
    add	w14,	w13,	#1
    lsl	w0,	w21,	#2
    add	w13,	w16,	#4
    add	x28,	x11,	x0
    add	w10,	w13,	#1
    lsl	w3,	w13,	#2
    ldr	w1,	[x28]

    add	w1,	w2,	w1
    lsl	w16,	w10,	#2
    add	w10,	w13,	#4
    str	w1,	[x7]

    ldr	x21,	[sp, fp]

    lsl	w1,	w14,	#2
    lsl	w20,	w10,	#2
    movz	fp,	#436
    add	x2,	x21,	x3
    mov	x0,	x1
    movk	fp,	#2,	lsl #16
    add	w1,	w13,	#2
    add	x0,	sp,	x0
    ldr	w5,	[x2]

    lsl	w3,	w1,	#2
    ldr	x17,	[sp, fp]

    add	x0,	x0,	#16
    lsl	w7,	w5,	#24
    movz	fp,	#436
    add	x11,	x17,	x16
    movk	fp,	#2,	lsl #16
    ldr	w18,	[x11]

    add	w11,	w10,	#2
    ldr	x16,	[sp, fp]

    lsl	w21,	w18,	#16
    movz	fp,	#436
    add	x2,	x16,	x3
    movk	fp,	#2,	lsl #16
    add	w21,	w21,	w7
    ldr	w6,	[x2]

    add	w2,	w13,	#3
    ldr	x25,	[sp, fp]

    lsl	w7,	w6,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w5,	w2,	#2
    add	w9,	w21,	w7
    add	x3,	x25,	x5
    lsl	w5,	w11,	#2
    ldr	w7,	[x3]

    add	w7,	w9,	w7
    add	w9,	w10,	#1
    str	w7,	[x0]

    lsl	w6,	w9,	#2
    ldr	x0,	[sp, fp]

    add	w7,	w14,	#1
    movz	fp,	#436
    add	x17,	x0,	x20
    movk	fp,	#2,	lsl #16
    lsl	w16,	w7,	#2
    ldr	w21,	[x17]

    add	w7,	w7,	#1
    mov	x1,	x16
    ldr	x25,	[sp, fp]

    lsl	w2,	w21,	#24
    add	x1,	sp,	x1
    movz	fp,	#436
    add	x13,	x25,	x6
    add	w21,	w10,	#3
    movk	fp,	#2,	lsl #16
    add	x1,	x1,	#16
    ldr	w0,	[x13]

    lsl	w3,	w0,	#16
    add	w3,	w3,	w2
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x14,	x2,	x5
    movk	fp,	#2,	lsl #16
    lsl	w5,	w7,	#2
    lsl	w2,	w21,	#2
    ldr	w17,	[x14]

    ldr	x8,	[sp, fp]

    lsl	w18,	w17,	#8
    movz	fp,	#436
    add	x0,	x8,	x2
    add	w18,	w3,	w18
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x0]

    mov	x0,	x5
    add	w28,	w18,	w3
    add	x0,	sp,	x0
    add	w3,	w10,	#4
    str	w28,	[x1]

    add	x0,	x0,	#16
    add	w8,	w3,	#3
    add	w20,	w3,	#4
    ldr	x16,	[sp, fp]

    lsl	w1,	w3,	#2
    movz	fp,	#436
    lsl	w11,	w8,	#2
    movk	fp,	#2,	lsl #16
    add	x14,	x16,	x1
    add	w16,	w3,	#1
    ldr	w5,	[x14]

    lsl	w9,	w16,	#2
    ldr	x17,	[sp, fp]

    lsl	w14,	w5,	#24
    movz	fp,	#436
    add	x17,	x17,	x9
    movk	fp,	#2,	lsl #16
    add	w9,	w3,	#2
    ldr	w21,	[x17]

    lsl	w19,	w9,	#2
    ldr	x17,	[sp, fp]

    lsl	w28,	w21,	#16
    movz	fp,	#436
    add	x10,	x17,	x19
    movk	fp,	#2,	lsl #16
    add	w1,	w28,	w14
    ldr	w17,	[x10]

    ldr	x19,	[sp, fp]

    lsl	w2,	w17,	#8
    add	x10,	x19,	x11
    add	w1,	w1,	w2
    add	w2,	w7,	#1
    ldr	w13,	[x10]

    mov	w10,	w2
    add	w6,	w1,	w13
    str	w6,	[x0]

    b	main_70

main_215:
    mov	w18,	w20
    mov	w1,	w10

main_217:
    lsl	w7,	w1,	#2
    lsl	w11,	w18,	#2
    movz	fp,	#436
    add	w2,	w18,	#1
    add	w0,	w18,	#2
    add	w21,	w1,	#1
    add	w19,	w18,	#4
    mov	x5,	x7
    movk	fp,	#2,	lsl #16
    lsl	w28,	w2,	#2
    add	x5,	sp,	x5
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x13,	x3,	x11
    add	x5,	x5,	#16
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x13]

    lsl	w13,	w0,	#2
    ldr	x2,	[sp, fp]

    lsl	w20,	w16,	#24
    movz	fp,	#436
    add	x3,	x2,	x28
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x3]

    ldr	x3,	[sp, fp]

    lsl	w10,	w8,	#16
    movz	fp,	#436
    add	x2,	x3,	x13
    add	w10,	w10,	w20
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x2]

    add	w2,	w18,	#3
    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w10,	w9
    lsl	w17,	w2,	#2
    add	x3,	x8,	x17
    ldr	w11,	[x3]

    add	w20,	w9,	w11
    str	w20,	[x5]

    cmp	w21,	#16
    bge	main_241

main_216:
    mov	w18,	w19
    mov	w1,	w21
    b	main_217

main_241:
    mov	w13,	w21
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]


main_242:
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#468
    lsl	w19,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x19
    add	x17,	sp,	x17
    ldr	w24,	[sp, fp]

    movz	fp,	#468
    sub	w21,	w24,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w1,	w21,	#2
    mov	x28,	x1
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    ldr	w2,	[x28]

    ldr	w3,	[sp, fp]

    movz	fp,	#468
    sub	w5,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w5,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w9,	[x7]

    ldr	w3,	[sp, fp]

    add	w7,	w9,	w2
    movz	fp,	#468
    sub	w20,	w3,	#14
    movk	fp,	#2,	lsl #16
    sub	w11,	w2,	w7
    lsl	w28,	w20,	#2
    mov	x21,	x28
    add	w14,	w11,	w9
    add	x21,	sp,	x21
    sub	w7,	w14,	w7
    add	x21,	x21,	#16
    ldr	w0,	[x21]

    ldr	w5,	[sp, fp]

    add	w28,	w0,	w7
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    sub	w1,	w7,	w28
    add	w6,	w1,	w0
    sub	w0,	w5,	#16
    sub	w20,	w6,	w28
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w20
    sub	w9,	w20,	w2
    add	w10,	w9,	w3
    sub	w13,	w10,	w2
    asr	w0,	w13,	#31
    lsl	w7,	w13,	#1
    lsr	w1,	w0,	#31
    add	w2,	w13,	w1
    asr	w10,	w2,	#1
    lsl	w11,	w10,	#1
    sub	w3,	w13,	w11
    add	w6,	w7,	w3
    str	w6,	[x17]

    ldr	w16,	[sp, fp]

    movz	fp,	#468
    add	w7,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w27
    movz	fp,	#428
    mov	w1,	w12
    mov	w16,	w4
    mov	w9,	w15
    mov	w28,	w26
    movz	w3,	#0
    movk	fp,	#2,	lsl #16
    str	w25,	[sp, fp]

    mov	w25,	w3
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w25,	[sp, fp]


main_277:
    movz	w1,	#48348
    movz	w11,	#60289
    movz	w21,	#31129
    movz	w19,	#65535
    movz	fp,	#412
    movk	w1,	#36635,	lsl #16
    movk	w11,	#28377,	lsl #16
    movk	w21,	#23170,	lsl #16
    movk	w19,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w1
    mov	w14,	w21
    mov	w16,	w19
    ldr	w10,	[sp, fp]

    movz	w1,	#49414
    movk	w1,	#51810,	lsl #16
    cmp	w10,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w0,	w16
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w3,	w19,	w17
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    sub	w0,	w0,	w9
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w6,	w13,	w0
    add	w7,	w6,	w3
    sub	w5,	w3,	w7
    add	w19,	w5,	w6
    sub	w21,	w19,	w7
    sub	w0,	w21,	w19
    mov	w21,	w14
    add	w5,	w0,	w7
    sub	w3,	w5,	w19
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    cmp	w13,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    mov	w21,	w11
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#424
    add	w3,	w25,	w20
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w17,	w3
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    add	w20,	w7,	w5
    movk	fp,	#2,	lsl #16
    sub	w19,	w20,	w3
    ldr	w3,	[sp, fp]

    movz	fp,	#416
    add	w0,	w3,	w19
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    sub	w3,	w19,	w0
    add	w3,	w3,	w25
    sub	w3,	w3,	w0
    mov	w5,	w3
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    cmp	w17,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#416
    add	w20,	w6,	w3
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    add	w6,	w7,	w17
    movk	fp,	#2,	lsl #16
    add	w21,	w6,	w20
    ldr	w13,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w20,	w21
    ldr	w9,	[sp, fp]

    add	w7,	w0,	w6
    sub	w0,	w7,	w21
    sub	w5,	w0,	w7
    add	w6,	w5,	w21
    mov	w21,	w18
    sub	w3,	w6,	w7
    add	w7,	w13,	w9
    add	w19,	w7,	w3
    sub	w20,	w3,	w19
    add	w6,	w20,	w7
    sub	w17,	w6,	w19
    sub	w0,	w17,	w6
    add	w5,	w0,	w19
    sub	w3,	w5,	w6
    mov	w5,	w3
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w0,	w13,	w7
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w6,	w0
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    add	w6,	w6,	w20
    movk	fp,	#2,	lsl #16
    sub	w3,	w6,	w0
    ldr	w13,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w0,	w13,	w3
    ldr	w8,	[sp, fp]

    sub	w21,	w3,	w0
    add	w5,	w21,	w8
    mov	w21,	w1
    sub	w3,	w5,	w0
    mov	w5,	w3

main_413:
    mov	w3,	w5

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w6,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#428
    asr	w7,	w8,	#31
    movk	fp,	#2,	lsl #16
    lsr	w19,	w7,	#27
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    add	w7,	w9,	w19
    movk	fp,	#2,	lsl #16
    asr	w7,	w7,	#5
    ldr	w13,	[sp, fp]

    movz	fp,	#412
    lsl	w17,	w7,	#5
    movk	fp,	#2,	lsl #16
    sub	w7,	w13,	w17
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    lsl	w0,	w17,	#2
    add	w19,	w6,	w7
    movk	fp,	#2,	lsl #16
    mov	x0,	x0
    add	x0,	sp,	x0
    add	w19,	w19,	w28
    add	x0,	x0,	#16
    add	w5,	w19,	w3
    ldr	w6,	[x0]

    add	w7,	w5,	w21
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w7,	w7,	w6
    lsl	w6,	w17,	#30
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    asr	w3,	w17,	#31
    movk	fp,	#2,	lsl #16
    lsr	w5,	w3,	#2
    ldr	w9,	[sp, fp]

    movz	fp,	#424
    add	w17,	w9,	w5
    movk	fp,	#2,	lsl #16
    asr	w5,	w17,	#30
    ldr	w17,	[sp, fp]

    lsl	w5,	w5,	#30
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    sub	w5,	w17,	w5
    ldr	w8,	[sp, fp]

    add	w21,	w8,	#1
    add	w17,	w6,	w5
    cmp	w21,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w6,	w16
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w20,	w17,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w6,	w1
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w1,	w10,	w0
    add	w5,	w1,	w20
    sub	w13,	w20,	w5
    add	w11,	w13,	w1
    sub	w13,	w11,	w5
    sub	w16,	w13,	w11
    mov	w13,	w14
    add	w19,	w16,	w5
    sub	w18,	w19,	w11
    mov	w20,	w18
    b	main_347

main_364:
    cmp	w21,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#428
    add	w9,	w17,	w16
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w19,	w3,	w9
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w17
    ldr	w14,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w9
    ldr	w24,	[sp, fp]

    add	w16,	w14,	w0
    sub	w3,	w0,	w16
    mov	w0,	w11
    add	w9,	w3,	w24
    sub	w14,	w9,	w16
    b	main_375

main_378:
    cmp	w21,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#428
    add	w16,	w17,	w20
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    add	w14,	w1,	w8
    movk	fp,	#2,	lsl #16
    add	w0,	w14,	w16
    ldr	w24,	[sp, fp]

    add	w6,	w24,	w17
    sub	w1,	w16,	w0
    add	w3,	w1,	w14
    mov	w1,	w18
    sub	w13,	w3,	w0
    sub	w14,	w13,	w3
    add	w0,	w14,	w0
    sub	w3,	w0,	w3
    add	w0,	w6,	w3
    sub	w9,	w3,	w0
    add	w28,	w9,	w6
    sub	w13,	w28,	w0
    sub	w19,	w13,	w28
    add	w20,	w19,	w0
    sub	w13,	w20,	w28
    mov	w16,	w13
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w11,	w17,	w0
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    sub	w5,	w16,	w11
    movk	fp,	#2,	lsl #16
    add	w6,	w5,	w17
    ldr	w28,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w6,	w11
    ldr	w6,	[sp, fp]

    add	w14,	w28,	w0
    sub	w9,	w0,	w14
    add	w28,	w9,	w6
    sub	w14,	w28,	w14
    mov	w16,	w14

main_398:
    mov	w14,	w16
    mov	w0,	w1

main_375:
    mov	w20,	w14
    mov	w13,	w0

main_347:
    lsl	w1,	w7,	#5
    asr	w16,	w7,	#31
    lsl	w19,	w21,	#2
    movz	fp,	#416
    lsr	w28,	w16,	#27
    mov	x14,	x19
    movk	fp,	#2,	lsl #16
    add	x14,	sp,	x14
    add	w6,	w7,	w28
    add	x14,	x14,	#16
    asr	w16,	w6,	#5
    lsl	w0,	w16,	#5
    sub	w9,	w7,	w0
    ldr	w0,	[x14]

    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w6,	w9,	w18
    movk	fp,	#2,	lsl #16
    add	w6,	w6,	w1
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    lsl	w9,	w3,	#30
    movk	fp,	#2,	lsl #16
    add	w14,	w6,	w20
    ldr	w25,	[sp, fp]

    add	w20,	w21,	#1
    movz	fp,	#428
    asr	w10,	w25,	#31
    add	w6,	w14,	w13
    movk	fp,	#2,	lsl #16
    lsr	w18,	w10,	#2
    add	w16,	w6,	w0
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w14,	w0,	w18
    movk	fp,	#2,	lsl #16
    asr	w3,	w14,	#30
    lsl	w6,	w3,	#30
    ldr	w3,	[sp, fp]

    sub	w11,	w3,	w6
    add	w18,	w9,	w11
    cmp	w20,	#80
    blt	main_276

main_433:
    add	w10,	w16,	w27
    add	w5,	w18,	w4
    add	w17,	w17,	w15
    movz	fp,	#432
    add	w28,	w22,	#64
    add	w16,	w7,	w12
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w8,	w7,	w26
    cmp	w28,	w23
    blt	main_62

main_441:
    movz	fp,	#508
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#516
    str	w10,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#484
    str	w16,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#476
    str	w5,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#540
    str	w17,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w8,	[x23]


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

    add	w3,	w15,	w16
    sub	w0,	w16,	w3
    add	w16,	w0,	w15
    sub	w20,	w16,	w3
    str	w20,	[x22]

    b	main_442

main_455:
    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w4,	w26,	#1
    cmp	w4,	#0
    ble	main_460

main_27:
    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w1,	w6
    b	main_28

main_62:
    mov	w27,	w10
    mov	w12,	w16
    mov	w4,	w5
    mov	w15,	w17
    mov	w26,	w8
    mov	w22,	w28
    b	main_63

main_276:
    mov	w14,	w16
    movz	fp,	#428
    mov	w21,	w7
    mov	w10,	w17
    mov	w9,	w18
    movk	fp,	#2,	lsl #16
    mov	w7,	w20
    str	w14,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w21,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#412
    mov	w28,	w8
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#500
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


