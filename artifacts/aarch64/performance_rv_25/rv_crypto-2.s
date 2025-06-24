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
    movz	w26,	#0
    movz	fp,	#336
    movz	w24,	#0
    movz	w23,	#0
    movk	fp,	#2,	lsl #16
    add	x21,	sp,	fp
    movz	fp,	#340
    movk	fp,	#2,	lsl #16
    str	w26,	[x21]

    add	x19,	sp,	fp
    movz	fp,	#344
    movk	fp,	#2,	lsl #16
    str	w25,	[x19]

    add	x20,	sp,	fp
    movz	fp,	#348
    movk	fp,	#2,	lsl #16
    str	w24,	[x20]

    add	x22,	sp,	fp
    movz	fp,	#352
    movk	fp,	#2,	lsl #16
    str	w23,	[x22]

    add	x24,	sp,	fp
    movz	w22,	#0
    str	w22,	[x24]

    bl	getint
    mov	w22,	w0
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
    add	x20,	sp,	#16
    mov	x26,	x21
    add	x8,	x21,	#12
    add	x16,	x21,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x21,	#4
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#532
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x21,	#8
    mov	w0,	w22
    str	x25,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
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
    mov	x26,	x15
    movk	fp,	#2,	lsl #16
    add	x26,	sp,	x26
    ldr	w0,	[sp, fp]

    add	x26,	x26,	#336
    movz	fp,	#420
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#420
    add	w1,	w14,	w17
    movk	fp,	#2,	lsl #16
    asr	w18,	w1,	#31
    lsr	w20,	w18,	#15
    add	w21,	w1,	w20
    asr	w20,	w21,	#17
    add	w3,	w1,	w20
    lsl	w22,	w3,	#5
    add	w1,	w3,	w22
    asr	w23,	w1,	#31
    lsr	w24,	w23,	#24
    add	w25,	w1,	w24
    asr	w22,	w25,	#8
    lsl	w23,	w22,	#8
    sub	w25,	w1,	w23
    str	w25,	[x26]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w21,	#128
    movz	fp,	#532
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w13,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w26,	w13,	#31
    lsr	w28,	w26,	#26
    add	w0,	w13,	w28
    asr	w1,	w0,	#6
    lsl	w2,	w1,	#6
    sub	w28,	w13,	w2
    cmp	w28,	#60
    beq	main_53

main_50:
    lsl	w3,	w13,	#2
    movz	fp,	#436
    movz	w0,	#0
    add	w12,	w13,	#1
    movk	fp,	#2,	lsl #16
    mov	w13,	w12
    ldr	x5,	[sp, fp]

    add	x6,	x5,	x3
    str	w0,	[x6]

    b	main_46

main_53:
    lsl	w26,	w13,	#2
    movz	fp,	#436
    add	w22,	w13,	#1
    movz	w24,	#125
    movk	fp,	#2,	lsl #16
    lsl	w20,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x25,	x28,	x26
    movk	fp,	#2,	lsl #16
    movz	w26,	#0
    movz	w28,	#0
    str	w28,	[x25]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x18,	x0,	x20
    movk	fp,	#2,	lsl #16
    str	w26,	[x18]

    ldr	x0,	[sp, fp]

    add	w26,	w13,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x22,	x0,	x2
    add	w2,	w13,	#3
    str	w24,	[x22]

    lsl	w26,	w2,	#2
    ldr	x1,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#524
    add	x25,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x25]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    add	w25,	w13,	#4
    bl	memset
    movz	w28,	#0
    movz	w17,	#8961
    movz	w26,	#43913
    movz	w3,	#56574
    movz	w6,	#21622
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w27,	w17
    mov	w12,	w26
    mov	w4,	w3
    mov	w20,	w6
    movz	w17,	#57840
    movk	w17,	#50130,	lsl #16
    mov	w16,	w17

main_63:
    movz	w15,	#0
    mov	w22,	w28
    mov	w10,	w15

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w14,	w10,	#2
    lsl	w3,	w22,	#2
    movz	fp,	#436
    add	w11,	w22,	#2
    add	w10,	w10,	#1
    mov	x14,	x14
    movk	fp,	#2,	lsl #16
    add	x14,	sp,	x14
    lsl	w11,	w11,	#2
    lsl	w13,	w10,	#2
    ldr	x0,	[sp, fp]

    add	x14,	x14,	#16
    movz	fp,	#436
    add	x2,	x0,	x3
    movk	fp,	#2,	lsl #16
    add	w0,	w22,	#1
    ldr	w6,	[x2]

    lsl	w15,	w0,	#2
    ldr	x9,	[sp, fp]

    lsl	w18,	w6,	#24
    movz	fp,	#436
    add	x1,	x9,	x15
    movk	fp,	#2,	lsl #16
    mov	x9,	x13
    add	x9,	sp,	x9
    ldr	w3,	[x1]

    ldr	x21,	[sp, fp]

    lsl	w6,	w3,	#16
    add	x9,	x9,	#16
    movz	fp,	#436
    add	x17,	x21,	x11
    add	w7,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	w11,	w22,	#4
    ldr	w0,	[x17]

    add	w21,	w11,	#2
    ldr	x26,	[sp, fp]

    lsl	w2,	w0,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w2,	w7,	w2
    add	w7,	w22,	#3
    lsl	w17,	w7,	#2
    add	x15,	x26,	x17
    lsl	w26,	w11,	#2
    ldr	w18,	[x15]

    add	w7,	w2,	w18
    str	w7,	[x14]

    lsl	w7,	w21,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x24,	x5,	x26
    movk	fp,	#2,	lsl #16
    add	w26,	w11,	#1
    ldr	w1,	[x24]

    lsl	w17,	w26,	#2
    lsl	w18,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x0,	x1,	x17
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    ldr	x3,	[sp, fp]

    lsl	w6,	w5,	#16
    movz	fp,	#436
    add	x0,	x3,	x7
    add	w5,	w10,	#1
    add	w18,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	w7,	w11,	#3
    ldr	w2,	[x0]

    ldr	x6,	[sp, fp]

    lsl	w3,	w2,	#8
    lsl	w15,	w7,	#2
    movz	fp,	#436
    add	w18,	w18,	w3
    movk	fp,	#2,	lsl #16
    add	x8,	x6,	x15
    add	w15,	w11,	#4
    ldr	w17,	[x8]

    add	w7,	w15,	#1
    lsl	w8,	w5,	#2
    add	w3,	w18,	w17
    mov	x2,	x8
    add	x2,	sp,	x2
    lsl	w11,	w7,	#2
    str	w3,	[x9]

    add	x2,	x2,	#16
    ldr	x0,	[sp, fp]

    lsl	w3,	w15,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	x1,	x0,	x3
    add	w3,	w15,	#3
    ldr	w6,	[x1]

    ldr	x17,	[sp, fp]

    lsl	w1,	w6,	#24
    movz	fp,	#436
    add	x9,	x17,	x11
    movk	fp,	#2,	lsl #16
    add	w17,	w15,	#2
    add	w15,	w15,	#4
    ldr	w11,	[x9]

    lsl	w26,	w17,	#2
    ldr	x18,	[sp, fp]

    add	w22,	w15,	#3
    add	w6,	w15,	#1
    lsl	w13,	w11,	#16
    movz	fp,	#436
    add	x18,	x18,	x26
    movk	fp,	#2,	lsl #16
    lsl	w14,	w6,	#2
    add	w11,	w13,	w1
    ldr	w26,	[x18]

    lsl	w0,	w26,	#8
    lsl	w26,	w15,	#2
    add	w7,	w11,	w0
    add	w11,	w5,	#1
    lsl	w0,	w3,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x21,	x3,	x0
    movk	fp,	#2,	lsl #16
    lsl	w0,	w11,	#2
    ldr	w1,	[x21]

    add	w8,	w7,	w1
    mov	x7,	x0
    add	x7,	sp,	x7
    str	w8,	[x2]

    ldr	x8,	[sp, fp]

    add	x7,	x7,	#16
    movz	fp,	#436
    add	x24,	x8,	x26
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x24]

    ldr	x3,	[sp, fp]

    lsl	w0,	w1,	#24
    movz	fp,	#436
    add	x8,	x3,	x14
    movk	fp,	#2,	lsl #16
    add	w3,	w15,	#2
    ldr	w18,	[x8]

    ldr	x13,	[sp, fp]

    lsl	w8,	w3,	#2
    lsl	w21,	w18,	#16
    movz	fp,	#436
    add	x5,	x13,	x8
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	w0
    ldr	w10,	[x5]

    ldr	x13,	[sp, fp]

    lsl	w14,	w10,	#8
    movz	fp,	#436
    add	w2,	w0,	w14
    movk	fp,	#2,	lsl #16
    lsl	w0,	w22,	#2
    add	w22,	w11,	#1
    add	x26,	x13,	x0
    add	w13,	w15,	#4
    lsl	w1,	w22,	#2
    ldr	w3,	[x26]

    mov	x0,	x1
    add	w10,	w13,	#1
    add	w3,	w2,	w3
    add	w1,	w13,	#2
    add	x0,	sp,	x0
    lsl	w15,	w10,	#2
    str	w3,	[x7]

    add	x0,	x0,	#16
    add	w10,	w13,	#4
    ldr	x19,	[sp, fp]

    lsl	w3,	w13,	#2
    movz	fp,	#436
    add	x2,	x19,	x3
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x2]

    ldr	x14,	[sp, fp]

    add	w2,	w13,	#3
    lsl	w7,	w5,	#24
    movz	fp,	#436
    add	x11,	x14,	x15
    lsl	w5,	w1,	#2
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x11]

    ldr	x14,	[sp, fp]

    add	w11,	w10,	#2
    lsl	w21,	w17,	#16
    movz	fp,	#436
    add	x3,	x14,	x5
    movk	fp,	#2,	lsl #16
    add	w21,	w21,	w7
    lsl	w5,	w2,	#2
    ldr	w7,	[x3]

    ldr	x24,	[sp, fp]

    lsl	w14,	w7,	#8
    movz	fp,	#436
    add	x3,	x24,	x5
    add	w9,	w21,	w14
    movk	fp,	#2,	lsl #16
    lsl	w5,	w11,	#2
    lsl	w21,	w10,	#2
    ldr	w7,	[x3]

    add	w7,	w9,	w7
    str	w7,	[x0]

    ldr	x3,	[sp, fp]

    add	w7,	w22,	#1
    movz	fp,	#436
    add	x17,	x3,	x21
    add	w22,	w10,	#3
    movk	fp,	#2,	lsl #16
    lsl	w15,	w7,	#2
    ldr	w24,	[x17]

    mov	x2,	x15
    add	w17,	w10,	#1
    lsl	w3,	w24,	#24
    add	x2,	sp,	x2
    ldr	x24,	[sp, fp]

    movz	fp,	#436
    lsl	w14,	w17,	#2
    movk	fp,	#2,	lsl #16
    add	x2,	x2,	#16
    add	x18,	x24,	x14
    ldr	w0,	[x18]

    ldr	x8,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#436
    add	x14,	x8,	x5
    add	w3,	w1,	w3
    movk	fp,	#2,	lsl #16
    add	w1,	w7,	#1
    ldr	w17,	[x14]

    ldr	x9,	[sp, fp]

    lsl	w18,	w17,	#8
    lsl	w11,	w1,	#2
    movz	fp,	#436
    add	w18,	w3,	w18
    add	w1,	w1,	#1
    movk	fp,	#2,	lsl #16
    lsl	w3,	w22,	#2
    add	x0,	x9,	x3
    ldr	w6,	[x0]

    add	w26,	w18,	w6
    add	w6,	w10,	#4
    str	w26,	[x2]

    add	w8,	w6,	#3
    add	w10,	w6,	#2
    lsl	w0,	w6,	#2
    ldr	x15,	[sp, fp]

    mov	x2,	x11
    movz	fp,	#436
    lsl	w24,	w10,	#2
    add	x17,	x15,	x0
    add	x2,	sp,	x2
    movk	fp,	#2,	lsl #16
    add	w15,	w6,	#1
    ldr	w3,	[x17]

    add	x2,	x2,	#16
    ldr	x17,	[sp, fp]

    lsl	w11,	w15,	#2
    lsl	w14,	w3,	#24
    movz	fp,	#436
    add	x17,	x17,	x11
    movk	fp,	#2,	lsl #16
    lsl	w11,	w8,	#2
    ldr	w22,	[x17]

    ldr	x17,	[sp, fp]

    lsl	w26,	w22,	#16
    movz	fp,	#436
    add	x17,	x17,	x24
    add	w22,	w6,	#4
    add	w0,	w26,	w14
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x17]

    ldr	x19,	[sp, fp]

    lsl	w3,	w21,	#8
    add	x10,	x19,	x11
    add	w7,	w0,	w3
    ldr	w13,	[x10]

    mov	w10,	w1
    add	w7,	w7,	w13
    str	w7,	[x2]

    b	main_70

main_215:
    mov	w18,	w22
    mov	w2,	w10

main_217:
    lsl	w7,	w2,	#2
    lsl	w11,	w18,	#2
    movz	fp,	#436
    add	w0,	w18,	#2
    add	w24,	w2,	#1
    mov	x5,	x7
    movk	fp,	#2,	lsl #16
    add	x5,	sp,	x5
    ldr	x3,	[sp, fp]

    add	x5,	x5,	#16
    movz	fp,	#436
    add	x13,	x3,	x11
    movk	fp,	#2,	lsl #16
    add	w3,	w18,	#1
    ldr	w15,	[x13]

    lsl	w26,	w3,	#2
    ldr	x1,	[sp, fp]

    lsl	w21,	w15,	#24
    movz	fp,	#436
    add	x7,	x1,	x26
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x7]

    ldr	x3,	[sp, fp]

    lsl	w15,	w14,	#16
    movz	fp,	#436
    add	w17,	w15,	w21
    movk	fp,	#2,	lsl #16
    lsl	w15,	w0,	#2
    add	x1,	x3,	x15
    add	w3,	w18,	#3
    ldr	w8,	[x1]

    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w17,	w9
    lsl	w17,	w3,	#2
    add	x7,	x8,	x17
    ldr	w17,	[x7]

    add	w21,	w9,	w17
    str	w21,	[x5]

    add	w21,	w18,	#4
    cmp	w24,	#16
    bge	main_241

main_216:
    mov	w18,	w21
    mov	w2,	w24
    b	main_217

main_241:
    mov	w13,	w24
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]


main_242:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#516
    lsl	w21,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x15,	x21
    add	x15,	sp,	x15
    ldr	w23,	[sp, fp]

    movz	fp,	#516
    sub	w26,	w23,	#3
    add	x15,	x15,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w8,	[x1]

    ldr	w2,	[sp, fp]

    movz	fp,	#516
    sub	w3,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w7,	w3,	#2
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w9,	[x6]

    ldr	w3,	[sp, fp]

    add	w6,	w9,	w8
    movz	fp,	#516
    sub	w22,	w3,	#14
    movk	fp,	#2,	lsl #16
    sub	w11,	w8,	w6
    lsl	w0,	w22,	#2
    mov	x24,	x0
    add	w14,	w11,	w9
    add	x24,	sp,	x24
    sub	w7,	w14,	w6
    add	x24,	x24,	#16
    ldr	w2,	[x24]

    ldr	w5,	[sp, fp]

    add	w26,	w2,	w7
    movz	fp,	#516
    sub	w0,	w5,	#16
    movk	fp,	#2,	lsl #16
    sub	w1,	w7,	w26
    add	w10,	w1,	w2
    lsl	w2,	w0,	#2
    mov	x1,	x2
    sub	w22,	w10,	w26
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w22
    sub	w9,	w22,	w2
    add	w10,	w9,	w3
    sub	w14,	w10,	w2
    asr	w0,	w14,	#31
    lsl	w9,	w14,	#1
    lsr	w1,	w0,	#31
    add	w2,	w14,	w1
    asr	w10,	w2,	#1
    lsl	w11,	w10,	#1
    sub	w3,	w14,	w11
    add	w6,	w9,	w3
    str	w6,	[x15]

    ldr	w15,	[sp, fp]

    movz	fp,	#516
    add	w7,	w15,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w26,	w27
    movz	fp,	#428
    mov	w1,	w12
    mov	w14,	w4
    mov	w9,	w20
    mov	w13,	w16
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w5
    str	w26,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_277:
    movz	w1,	#48348
    movz	w0,	#60289
    movz	w5,	#49414
    movz	w24,	#31129
    movz	w22,	#65535
    movz	fp,	#412
    movk	w1,	#36635,	lsl #16
    movk	w0,	#28377,	lsl #16
    movk	w5,	#51810,	lsl #16
    movk	w24,	#23170,	lsl #16
    movk	w22,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w1
    mov	w21,	w5
    mov	w11,	w24
    mov	w14,	w22
    ldr	w8,	[sp, fp]

    cmp	w8,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w1,	w14
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#424
    add	w22,	w15,	w17
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    sub	w8,	w1,	w8
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w24,	w15,	w8
    add	w1,	w24,	w22
    sub	w5,	w22,	w1
    add	w22,	w5,	w24
    sub	w17,	w22,	w1
    sub	w15,	w17,	w22
    add	w17,	w15,	w1
    mov	w15,	w11
    sub	w5,	w17,	w22
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    cmp	w10,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    add	w6,	w17,	w22
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    sub	w8,	w15,	w6
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#416
    add	w1,	w8,	w2
    movk	fp,	#2,	lsl #16
    sub	w8,	w1,	w6
    ldr	w3,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w5,	w3,	w8
    ldr	w26,	[sp, fp]

    sub	w15,	w8,	w5
    add	w15,	w15,	w26
    sub	w5,	w15,	w5
    mov	w15,	w0
    mov	w6,	w5
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    cmp	w15,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    add	w8,	w9,	w3
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    add	w24,	w7,	w17
    movk	fp,	#2,	lsl #16
    add	w5,	w24,	w8
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w26,	w8,	w5
    add	w1,	w26,	w24
    sub	w8,	w1,	w5
    sub	w17,	w8,	w1
    add	w5,	w17,	w5
    ldr	w17,	[sp, fp]

    add	w17,	w9,	w17
    sub	w6,	w5,	w1
    add	w15,	w17,	w6
    sub	w8,	w6,	w15
    add	w17,	w8,	w17
    sub	w5,	w17,	w15
    sub	w8,	w5,	w17
    add	w22,	w8,	w15
    mov	w15,	w18
    sub	w5,	w22,	w17
    mov	w6,	w5
    b	main_413

main_327:
    movz	fp,	#424
    mov	w15,	w21
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    add	w5,	w17,	w7
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w9,	w5
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    add	w8,	w1,	w22
    movk	fp,	#2,	lsl #16
    sub	w22,	w8,	w5
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w8,	w10,	w22
    ldr	w7,	[sp, fp]

    sub	w17,	w22,	w8
    add	w6,	w17,	w7
    sub	w5,	w6,	w8
    mov	w6,	w5

main_413:
    mov	w5,	w6

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    lsl	w8,	w2,	#5
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    asr	w17,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w6,	w17,	#27
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w22,	w22,	w6
    movk	fp,	#2,	lsl #16
    asr	w17,	w22,	#5
    ldr	w24,	[sp, fp]

    movz	fp,	#412
    lsl	w6,	w17,	#5
    movk	fp,	#2,	lsl #16
    sub	w22,	w24,	w6
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    lsl	w26,	w19,	#2
    movk	fp,	#2,	lsl #16
    add	w24,	w8,	w22
    mov	x8,	x26
    add	x8,	sp,	x8
    add	w22,	w24,	w13
    add	x8,	x8,	#16
    add	w1,	w22,	w5
    ldr	w6,	[x8]

    add	w17,	w1,	w15
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w8,	w17,	w6
    ldr	w10,	[sp, fp]

    lsl	w17,	w13,	#30
    movz	fp,	#424
    asr	w6,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w13,	w6,	#2
    ldr	w9,	[sp, fp]

    movz	fp,	#424
    add	w1,	w9,	w13
    movk	fp,	#2,	lsl #16
    asr	w1,	w1,	#30
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    lsl	w6,	w1,	#30
    movk	fp,	#2,	lsl #16
    sub	w24,	w10,	w6
    ldr	w10,	[sp, fp]

    add	w13,	w10,	#1
    add	w26,	w17,	w24
    cmp	w13,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w24,	w14
    movk	fp,	#2,	lsl #16
    mov	w14,	w11
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w9,	w26,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w24,	w1
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w1,	w15,	w0
    add	w21,	w1,	w9
    sub	w17,	w9,	w21
    add	w17,	w17,	w1
    sub	w22,	w17,	w21
    sub	w24,	w22,	w17
    add	w0,	w24,	w21
    sub	w15,	w0,	w17
    mov	w17,	w15
    b	main_347

main_364:
    cmp	w13,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    add	w17,	w26,	w17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w7,	w17
    movk	fp,	#2,	lsl #16
    add	w2,	w6,	w26
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w5,	w2,	w17
    ldr	w21,	[sp, fp]

    add	w2,	w15,	w5
    sub	w14,	w5,	w2
    add	w22,	w14,	w21
    sub	w11,	w22,	w2
    b	main_375

main_378:
    cmp	w13,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w0,	w26,	w19
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    add	w24,	w3,	w7
    movk	fp,	#2,	lsl #16
    add	w11,	w24,	w0
    ldr	w21,	[sp, fp]

    sub	w14,	w0,	w11
    add	w9,	w14,	w24
    sub	w0,	w9,	w11
    sub	w1,	w0,	w9
    add	w0,	w1,	w11
    add	w11,	w21,	w26
    sub	w2,	w0,	w9
    add	w1,	w11,	w2
    sub	w14,	w2,	w1
    add	w11,	w14,	w11
    sub	w22,	w11,	w1
    sub	w0,	w22,	w11
    mov	w22,	w18
    add	w14,	w0,	w1
    sub	w9,	w14,	w11
    mov	w11,	w9
    b	main_398

main_401:
    movz	fp,	#428
    mov	w22,	w21
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    add	w15,	w26,	w2
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w11,	w15
    movk	fp,	#2,	lsl #16
    add	w5,	w1,	w26
    ldr	w0,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w1,	w5,	w15
    ldr	w6,	[sp, fp]

    add	w18,	w0,	w1
    sub	w5,	w1,	w18
    add	w5,	w5,	w6
    sub	w9,	w5,	w18
    mov	w11,	w9

main_398:
    mov	w0,	w22

main_375:
    mov	w17,	w11
    mov	w14,	w0

main_347:
    lsl	w21,	w8,	#5
    asr	w1,	w8,	#31
    lsl	w15,	w13,	#2
    movz	fp,	#416
    lsr	w5,	w1,	#27
    mov	x11,	x15
    movk	fp,	#2,	lsl #16
    add	x11,	sp,	x11
    add	w9,	w8,	w5
    add	x11,	x11,	#16
    asr	w24,	w9,	#5
    ldr	w0,	[x11]

    lsl	w6,	w24,	#5
    ldr	w18,	[sp, fp]

    sub	w24,	w8,	w6
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w6,	w24,	w18
    ldr	w5,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w9,	w6,	w21
    ldr	w23,	[sp, fp]

    movz	fp,	#428
    asr	w15,	w23,	#31
    add	w2,	w9,	w17
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    add	w9,	w2,	w14
    movz	fp,	#428
    add	w2,	w13,	#1
    movk	fp,	#2,	lsl #16
    add	w18,	w9,	w0
    lsl	w9,	w5,	#30
    lsr	w5,	w15,	#2
    add	w1,	w1,	w5
    asr	w5,	w1,	#30
    lsl	w11,	w5,	#30
    ldr	w5,	[sp, fp]

    sub	w15,	w5,	w11
    add	w0,	w9,	w15
    cmp	w2,	#80
    blt	main_276

main_433:
    add	w10,	w18,	w27
    add	w15,	w8,	w12
    add	w5,	w0,	w4
    add	w24,	w26,	w20
    movz	fp,	#432
    add	w3,	w28,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w21,	w7,	w16
    cmp	w3,	w25
    blt	main_62

main_441:
    movz	fp,	#460
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#468
    str	w10,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#452
    str	w15,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#444
    str	w5,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#476
    str	w24,	[x20]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w21,	[x23]


main_442:
    cmp	w0,	#5
    bge	main_455

main_445:
    lsl	w17,	w0,	#2
    movz	fp,	#356
    lsl	w12,	w0,	#2
    mov	x25,	x17
    movk	fp,	#2,	lsl #16
    add	w0,	w0,	#1
    mov	x11,	x12
    add	x25,	sp,	x25
    add	x11,	sp,	x11
    add	x25,	x25,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x25]

    add	x11,	x11,	fp
    ldr	w16,	[x11]

    add	w6,	w16,	w17
    sub	w1,	w17,	w6
    add	w17,	w1,	w16
    sub	w22,	w17,	w6
    str	w22,	[x25]

    b	main_442

main_455:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w4,	w26,	#1
    cmp	w4,	#0
    ble	main_460

main_27:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w27,	w10
    mov	w12,	w15
    mov	w4,	w5
    mov	w20,	w24
    mov	w16,	w21
    mov	w28,	w3
    b	main_63

main_276:
    mov	w15,	w18
    movz	fp,	#428
    mov	w13,	w26
    mov	w9,	w0
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    mov	w8,	w2
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    mov	w13,	w10
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

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


