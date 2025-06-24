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
    mov	w22,	w0
    bl	getint
    mov	w27,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w6,	#0
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movz	w2,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#448
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
    add	x21,	sp,	#16
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

    movz	fp,	#472
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    mov	w0,	w22
    str	x25,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	x21,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#384
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
    lsr	w19,	w18,	#15
    add	w20,	w1,	w19
    asr	w19,	w20,	#17
    add	w3,	w1,	w19
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
    movz	w20,	#128
    movz	fp,	#472
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w13,	w1
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


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
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    lsl	w19,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x25,	x28,	x26
    movk	fp,	#2,	lsl #16
    movz	w26,	#0
    movz	w28,	#0
    str	w28,	[x25]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x18,	x0,	x19
    movk	fp,	#2,	lsl #16
    add	w19,	w13,	#4
    str	w26,	[x18]

    ldr	x0,	[sp, fp]

    add	w26,	w13,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x22,	x0,	x2
    add	w2,	w13,	#3
    str	w23,	[x22]

    lsl	w26,	w2,	#2
    ldr	x1,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#464
    add	x25,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x25]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w17,	#8961
    movz	w26,	#43913
    movz	w5,	#56574
    movz	w6,	#21622
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w27,	w17
    mov	w3,	w26
    mov	w13,	w5
    mov	w20,	w6
    movz	w17,	#57840
    movz	w26,	#0
    movk	w17,	#50130,	lsl #16
    mov	w28,	w26
    mov	w16,	w17

main_63:
    movz	w14,	#0
    mov	w23,	w28
    mov	w10,	w14

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w14,	w10,	#2
    lsl	w5,	w23,	#2
    movz	fp,	#436
    add	w11,	w23,	#2
    add	w8,	w10,	#1
    mov	x14,	x14
    movk	fp,	#2,	lsl #16
    add	x14,	sp,	x14
    lsl	w11,	w11,	#2
    lsl	w12,	w8,	#2
    ldr	x0,	[sp, fp]

    add	x14,	x14,	#16
    movz	fp,	#436
    add	x2,	x0,	x5
    movk	fp,	#2,	lsl #16
    add	w0,	w23,	#1
    ldr	w6,	[x2]

    lsl	w15,	w0,	#2
    ldr	x9,	[sp, fp]

    lsl	w18,	w6,	#24
    movz	fp,	#436
    add	x1,	x9,	x15
    movk	fp,	#2,	lsl #16
    mov	x9,	x12
    add	x9,	sp,	x9
    ldr	w5,	[x1]

    ldr	x21,	[sp, fp]

    lsl	w6,	w5,	#16
    add	x9,	x9,	#16
    movz	fp,	#436
    add	x17,	x21,	x11
    add	w7,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	w11,	w23,	#4
    add	w6,	w23,	#3
    ldr	w0,	[x17]

    add	w22,	w11,	#2
    ldr	x26,	[sp, fp]

    lsl	w17,	w6,	#2
    lsl	w2,	w0,	#8
    movz	fp,	#436
    add	x15,	x26,	x17
    add	w2,	w7,	w2
    movk	fp,	#2,	lsl #16
    lsl	w26,	w11,	#2
    ldr	w18,	[x15]

    add	w15,	w11,	#4
    add	w7,	w2,	w18
    str	w7,	[x14]

    lsl	w7,	w22,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x25,	x5,	x26
    movk	fp,	#2,	lsl #16
    add	w26,	w11,	#1
    ldr	w1,	[x25]

    lsl	w17,	w26,	#2
    lsl	w18,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x0,	x1,	x17
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x0]

    ldr	x2,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#436
    add	x0,	x2,	x7
    add	w4,	w8,	#1
    add	w18,	w5,	w18
    movk	fp,	#2,	lsl #16
    add	w7,	w11,	#3
    ldr	w2,	[x0]

    lsl	w8,	w4,	#2
    ldr	x6,	[sp, fp]

    lsl	w14,	w7,	#2
    lsl	w5,	w2,	#8
    mov	x1,	x8
    movz	fp,	#436
    add	x12,	x6,	x14
    add	w18,	w18,	w5
    add	w8,	w15,	#1
    add	x1,	sp,	x1
    movk	fp,	#2,	lsl #16
    add	w6,	w15,	#4
    ldr	w17,	[x12]

    lsl	w5,	w15,	#2
    lsl	w11,	w8,	#2
    add	x1,	x1,	#16
    lsl	w23,	w6,	#2
    add	w2,	w18,	w17
    str	w2,	[x9]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x2,	x0,	x5
    movk	fp,	#2,	lsl #16
    add	w5,	w15,	#3
    ldr	w7,	[x2]

    ldr	x17,	[sp, fp]

    lsl	w2,	w7,	#24
    movz	fp,	#436
    add	x9,	x17,	x11
    movk	fp,	#2,	lsl #16
    add	w17,	w15,	#2
    ldr	w11,	[x9]

    lsl	w26,	w17,	#2
    ldr	x18,	[sp, fp]

    lsl	w12,	w11,	#16
    movz	fp,	#436
    add	x18,	x18,	x26
    movk	fp,	#2,	lsl #16
    add	w11,	w12,	w2
    add	w12,	w6,	#4
    ldr	w26,	[x18]

    add	w18,	w4,	#1
    lsl	w0,	w26,	#8
    add	w7,	w11,	w0
    lsl	w0,	w5,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x22,	x5,	x0
    movk	fp,	#2,	lsl #16
    add	w5,	w6,	#1
    lsl	w0,	w18,	#2
    ldr	w2,	[x22]

    mov	x25,	x0
    add	w8,	w7,	w2
    add	x25,	sp,	x25
    str	w8,	[x1]

    add	x25,	x25,	#16
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x15,	x8,	x23
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x15]

    ldr	x9,	[sp, fp]

    lsl	w4,	w1,	#24
    movz	fp,	#436
    lsl	w1,	w5,	#2
    movk	fp,	#2,	lsl #16
    add	x7,	x9,	x1
    ldr	w15,	[x7]

    ldr	x9,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#436
    add	w15,	w6,	#3
    add	w0,	w17,	w4
    movk	fp,	#2,	lsl #16
    add	w4,	w6,	#2
    lsl	w26,	w15,	#2
    lsl	w11,	w4,	#2
    add	x8,	x9,	x11
    add	w9,	w12,	#1
    ldr	w10,	[x8]

    lsl	w9,	w9,	#2
    lsl	w11,	w10,	#8
    ldr	x10,	[sp, fp]

    add	w2,	w0,	w11
    movz	fp,	#436
    add	x17,	x10,	x26
    movk	fp,	#2,	lsl #16
    add	w26,	w12,	#2
    ldr	w4,	[x17]

    lsl	w26,	w26,	#2
    add	w2,	w2,	w4
    add	w4,	w18,	#1
    str	w2,	[x25]

    add	w7,	w4,	#1
    lsl	w1,	w4,	#2
    ldr	x17,	[sp, fp]

    mov	x14,	x1
    movz	fp,	#436
    lsl	w1,	w12,	#2
    add	x14,	sp,	x14
    movk	fp,	#2,	lsl #16
    add	x0,	x17,	x1
    add	x14,	x14,	#16
    ldr	w2,	[x0]

    ldr	x17,	[sp, fp]

    lsl	w6,	w2,	#24
    movz	fp,	#436
    add	x10,	x17,	x9
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x10]

    ldr	x10,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#436
    add	x0,	x10,	x26
    add	w15,	w17,	w6
    movk	fp,	#2,	lsl #16
    add	w10,	w12,	#4
    ldr	w5,	[x0]

    ldr	x22,	[sp, fp]

    add	w0,	w12,	#3
    add	w11,	w10,	#2
    lsl	w18,	w5,	#8
    movz	fp,	#436
    lsl	w2,	w0,	#2
    add	w9,	w15,	w18
    movk	fp,	#2,	lsl #16
    lsl	w18,	w10,	#2
    lsl	w15,	w7,	#2
    add	x1,	x22,	x2
    add	w22,	w10,	#3
    ldr	w6,	[x1]

    mov	x1,	x15
    add	w6,	w9,	w6
    add	x1,	sp,	x1
    str	w6,	[x14]

    add	x1,	x1,	#16
    lsl	w6,	w11,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x17,	x2,	x18
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x17]

    add	w17,	w10,	#1
    lsl	w4,	w25,	#24
    ldr	x25,	[sp, fp]

    movz	fp,	#436
    lsl	w14,	w17,	#2
    movk	fp,	#2,	lsl #16
    add	x18,	x25,	x14
    ldr	w0,	[x18]

    ldr	x5,	[sp, fp]

    lsl	w2,	w0,	#16
    movz	fp,	#436
    add	x14,	x5,	x6
    add	w4,	w2,	w4
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    ldr	x9,	[sp, fp]

    lsl	w18,	w17,	#8
    movz	fp,	#436
    add	w18,	w4,	w18
    movk	fp,	#2,	lsl #16
    lsl	w4,	w22,	#2
    add	x0,	x9,	x4
    ldr	w5,	[x0]

    add	w26,	w18,	w5
    add	w5,	w10,	#4
    str	w26,	[x1]

    add	w23,	w5,	#4
    add	w9,	w5,	#2
    lsl	w0,	w5,	#2
    ldr	x15,	[sp, fp]

    add	w1,	w7,	#1
    movz	fp,	#436
    lsl	w25,	w9,	#2
    add	x17,	x15,	x0
    movk	fp,	#2,	lsl #16
    add	w9,	w5,	#3
    lsl	w11,	w1,	#2
    add	w15,	w5,	#1
    ldr	w4,	[x17]

    add	w1,	w1,	#1
    mov	x2,	x11
    ldr	x17,	[sp, fp]

    lsl	w14,	w4,	#24
    lsl	w11,	w15,	#2
    add	x2,	sp,	x2
    movz	fp,	#436
    add	x17,	x17,	x11
    movk	fp,	#2,	lsl #16
    lsl	w11,	w9,	#2
    add	x2,	x2,	#16
    ldr	w22,	[x17]

    ldr	x17,	[sp, fp]

    lsl	w26,	w22,	#16
    movz	fp,	#436
    add	x17,	x17,	x25
    add	w0,	w26,	w14
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x17]

    ldr	x21,	[sp, fp]

    lsl	w4,	w22,	#8
    add	x10,	x21,	x11
    add	w7,	w0,	w4
    ldr	w12,	[x10]

    mov	w10,	w1
    add	w8,	w7,	w12
    str	w8,	[x2]

    b	main_70

main_215:
    mov	w18,	w23
    mov	w1,	w10

main_217:
    lsl	w7,	w1,	#2
    lsl	w11,	w18,	#2
    movz	fp,	#436
    add	w0,	w18,	#2
    add	w25,	w1,	#1
    add	w22,	w18,	#4
    mov	x6,	x7
    movk	fp,	#2,	lsl #16
    add	x6,	sp,	x6
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x12,	x4,	x11
    add	x6,	x6,	#16
    movk	fp,	#2,	lsl #16
    add	w4,	w18,	#1
    ldr	w15,	[x12]

    ldr	x2,	[sp, fp]

    lsl	w17,	w15,	#24
    lsl	w26,	w4,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	x5,	x2,	x26
    ldr	w14,	[x5]

    ldr	x4,	[sp, fp]

    lsl	w15,	w14,	#16
    movz	fp,	#436
    add	w17,	w15,	w17
    movk	fp,	#2,	lsl #16
    lsl	w15,	w0,	#2
    add	x2,	x4,	x15
    add	w4,	w18,	#3
    ldr	w8,	[x2]

    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w17,	w9
    lsl	w17,	w4,	#2
    add	x5,	x8,	x17
    ldr	w17,	[x5]

    add	w17,	w9,	w17
    str	w17,	[x6]

    cmp	w25,	#16
    bge	main_241

main_216:
    mov	w18,	w22
    mov	w1,	w25
    b	main_217

main_241:
    mov	w12,	w25
    movz	fp,	#600
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]


main_242:
    movz	fp,	#600
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#600
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#600
    lsl	w22,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x14,	x22
    add	x14,	sp,	x14
    ldr	w24,	[sp, fp]

    movz	fp,	#600
    sub	w26,	w24,	#3
    add	x14,	x14,	#16
    movk	fp,	#2,	lsl #16
    lsl	w1,	w26,	#2
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w2,	[sp, fp]

    movz	fp,	#600
    sub	w5,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w7,	w5,	#2
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w9,	[x6]

    ldr	w4,	[sp, fp]

    add	w6,	w9,	w8
    movz	fp,	#600
    sub	w23,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w11,	w8,	w6
    lsl	w0,	w23,	#2
    mov	x25,	x0
    add	w15,	w11,	w9
    add	x25,	sp,	x25
    sub	w7,	w15,	w6
    add	x25,	x25,	#16
    ldr	w1,	[x25]

    ldr	w5,	[sp, fp]

    add	w26,	w1,	w7
    movz	fp,	#600
    sub	w0,	w5,	#16
    movk	fp,	#2,	lsl #16
    sub	w2,	w7,	w26
    add	w10,	w2,	w1
    lsl	w2,	w0,	#2
    mov	x1,	x2
    sub	w23,	w10,	w26
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w5,	[x1]

    add	w2,	w5,	w23
    sub	w9,	w23,	w2
    add	w10,	w9,	w5
    sub	w12,	w10,	w2
    asr	w0,	w12,	#31
    lsl	w9,	w12,	#1
    lsr	w1,	w0,	#31
    add	w2,	w12,	w1
    asr	w10,	w2,	#1
    lsl	w11,	w10,	#1
    sub	w5,	w12,	w11
    add	w6,	w9,	w5
    str	w6,	[x14]

    ldr	w15,	[sp, fp]

    movz	fp,	#600
    add	w7,	w15,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w27
    movz	fp,	#428
    mov	w1,	w3
    mov	w14,	w13
    mov	w9,	w20
    mov	w12,	w16
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    mov	w26,	w6
    str	w25,	[sp, fp]

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
    str	w26,	[sp, fp]


main_277:
    movz	w1,	#48348
    movz	w0,	#60289
    movz	w23,	#31129
    movz	w22,	#65535
    movz	fp,	#412
    movk	w1,	#36635,	lsl #16
    movk	w0,	#28377,	lsl #16
    movk	w23,	#23170,	lsl #16
    movk	w22,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w1
    mov	w4,	w23
    mov	w14,	w22
    ldr	w9,	[sp, fp]

    movz	w1,	#49414
    movk	w1,	#51810,	lsl #16
    mov	w25,	w1
    cmp	w9,	#20
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
    add	w15,	w15,	w17
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    sub	w22,	w1,	w9
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    add	w23,	w17,	w22
    add	w1,	w23,	w15
    sub	w22,	w15,	w1
    add	w23,	w22,	w23
    sub	w17,	w23,	w1
    sub	w17,	w17,	w23
    add	w17,	w17,	w1
    sub	w6,	w17,	w23
    mov	w17,	w4
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    cmp	w11,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    add	w8,	w17,	w22
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w15,	w8
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#416
    add	w1,	w9,	w2
    movk	fp,	#2,	lsl #16
    sub	w9,	w1,	w8
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w6,	w5,	w9
    ldr	w26,	[sp, fp]

    sub	w17,	w9,	w6
    add	w17,	w17,	w26
    sub	w6,	w17,	w6
    mov	w17,	w0
    mov	w8,	w6
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
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    add	w6,	w8,	w5
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    add	w23,	w9,	w17
    movk	fp,	#2,	lsl #16
    add	w22,	w23,	w6
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w26,	w6,	w22
    add	w1,	w26,	w23
    sub	w15,	w1,	w22
    sub	w17,	w15,	w1
    add	w6,	w17,	w22
    ldr	w17,	[sp, fp]

    add	w17,	w10,	w17
    sub	w8,	w6,	w1
    add	w9,	w17,	w8
    sub	w6,	w8,	w9
    add	w17,	w6,	w17
    sub	w6,	w17,	w9
    sub	w15,	w6,	w17
    add	w22,	w15,	w9
    sub	w6,	w22,	w17
    mov	w17,	w18
    mov	w8,	w6
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    add	w6,	w17,	w8
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    sub	w23,	w8,	w6
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    add	w9,	w23,	w22
    movk	fp,	#2,	lsl #16
    sub	w9,	w9,	w6
    ldr	w11,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w15,	w11,	w9
    ldr	w8,	[sp, fp]

    sub	w17,	w9,	w15
    add	w8,	w17,	w8
    mov	w17,	w25
    sub	w6,	w8,	w15
    mov	w8,	w6

main_413:
    mov	w6,	w8

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    lsl	w9,	w2,	#5
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#428
    asr	w15,	w11,	#31
    movk	fp,	#2,	lsl #16
    lsr	w8,	w15,	#27
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w8,	w22,	w8
    movk	fp,	#2,	lsl #16
    asr	w15,	w8,	#5
    ldr	w24,	[sp, fp]

    movz	fp,	#412
    lsl	w26,	w15,	#5
    movk	fp,	#2,	lsl #16
    sub	w8,	w24,	w26
    ldr	w21,	[sp, fp]

    movz	fp,	#424
    lsl	w26,	w21,	#2
    movk	fp,	#2,	lsl #16
    add	w23,	w9,	w8
    mov	x9,	x26
    add	x9,	sp,	x9
    add	w22,	w23,	w12
    add	x9,	x9,	#16
    add	w1,	w22,	w6
    ldr	w8,	[x9]

    add	w17,	w1,	w17
    ldr	w12,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w9,	w17,	w8
    ldr	w11,	[sp, fp]

    lsl	w17,	w12,	#30
    movz	fp,	#424
    asr	w8,	w11,	#31
    movk	fp,	#2,	lsl #16
    lsr	w12,	w8,	#2
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    add	w1,	w7,	w12
    movk	fp,	#2,	lsl #16
    asr	w1,	w1,	#30
    ldr	w11,	[sp, fp]

    movz	fp,	#412
    lsl	w8,	w1,	#30
    movk	fp,	#2,	lsl #16
    sub	w23,	w11,	w8
    ldr	w11,	[sp, fp]

    add	w12,	w11,	#1
    add	w26,	w17,	w23
    cmp	w12,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w23,	w14
    movk	fp,	#2,	lsl #16
    mov	w14,	w4
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w11,	w26,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w23,	w1
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w1,	w15,	w0
    add	w17,	w1,	w11
    sub	w18,	w11,	w17
    add	w15,	w18,	w1
    sub	w23,	w15,	w17
    sub	w25,	w23,	w15
    add	w25,	w25,	w17
    sub	w17,	w25,	w15
    mov	w22,	w17
    b	main_347

main_364:
    cmp	w12,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    add	w15,	w26,	w17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w7,	w15
    movk	fp,	#2,	lsl #16
    add	w2,	w6,	w26
    sub	w4,	w2,	w15
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    add	w2,	w15,	w4
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    sub	w14,	w4,	w2
    add	w23,	w14,	w21
    sub	w14,	w23,	w2
    b	main_375

main_378:
    cmp	w12,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    add	w0,	w26,	w17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    add	w25,	w4,	w7
    movk	fp,	#2,	lsl #16
    add	w2,	w25,	w0
    ldr	w21,	[sp, fp]

    sub	w11,	w0,	w2
    add	w11,	w11,	w25
    sub	w0,	w11,	w2
    sub	w1,	w0,	w11
    add	w0,	w1,	w2
    mov	w1,	w18
    sub	w2,	w0,	w11
    add	w11,	w21,	w26
    add	w0,	w11,	w2
    sub	w14,	w2,	w0
    add	w8,	w14,	w11
    sub	w23,	w8,	w0
    sub	w25,	w23,	w8
    add	w14,	w25,	w0
    sub	w11,	w14,	w8
    mov	w14,	w11
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    add	w14,	w26,	w1
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w11,	w14
    movk	fp,	#2,	lsl #16
    add	w6,	w1,	w26
    ldr	w0,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w1,	w6,	w14
    ldr	w6,	[sp, fp]

    add	w18,	w0,	w1
    sub	w8,	w1,	w18
    mov	w1,	w25
    add	w4,	w8,	w6
    sub	w11,	w4,	w18
    mov	w14,	w11

main_398:
    mov	w0,	w1

main_375:
    mov	w22,	w14
    mov	w14,	w0

main_347:
    lsl	w8,	w9,	#5
    asr	w0,	w9,	#31
    lsl	w18,	w12,	#2
    movz	fp,	#416
    lsr	w1,	w0,	#27
    movk	fp,	#2,	lsl #16
    add	w17,	w9,	w1
    asr	w11,	w17,	#5
    mov	x17,	x18
    lsl	w0,	w11,	#5
    add	x17,	sp,	x17
    sub	w15,	w9,	w0
    add	x17,	x17,	#16
    ldr	w0,	[x17]

    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w7,	w15,	w18
    movk	fp,	#2,	lsl #16
    add	w8,	w7,	w8
    ldr	w5,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w2,	w8,	w22
    ldr	w24,	[sp, fp]

    movz	fp,	#428
    add	w8,	w2,	w14
    movk	fp,	#2,	lsl #16
    asr	w14,	w24,	#31
    ldr	w1,	[sp, fp]

    add	w18,	w8,	w0
    lsr	w4,	w14,	#2
    movz	fp,	#428
    add	w0,	w12,	#1
    lsl	w8,	w5,	#30
    add	w1,	w1,	w4
    movk	fp,	#2,	lsl #16
    asr	w6,	w1,	#30
    ldr	w4,	[sp, fp]

    lsl	w11,	w6,	#30
    sub	w15,	w4,	w11
    add	w1,	w8,	w15
    cmp	w0,	#80
    blt	main_276

main_433:
    add	w12,	w18,	w27
    add	w4,	w9,	w3
    add	w26,	w26,	w20
    movz	fp,	#432
    add	w2,	w28,	#64
    add	w18,	w1,	w13
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w22,	w7,	w16
    cmp	w2,	w19
    blt	main_62

main_441:
    movz	fp,	#480
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#488
    str	w12,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#504
    str	w4,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#496
    str	w18,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#612
    str	w26,	[x20]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w22,	[x23]


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
    movz	fp,	#384
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w4,	w26,	#1
    cmp	w4,	#0
    ble	main_460

main_27:
    movz	fp,	#384
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w27,	w12
    mov	w3,	w4
    mov	w13,	w18
    mov	w20,	w26
    mov	w16,	w22
    mov	w28,	w2
    b	main_63

main_276:
    mov	w15,	w18
    movz	fp,	#428
    mov	w5,	w9
    mov	w12,	w26
    mov	w8,	w0
    movk	fp,	#2,	lsl #16
    mov	w9,	w1
    str	w15,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    mov	w12,	w10
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#448
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


