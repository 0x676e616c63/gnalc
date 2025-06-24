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
    movz	w24,	#0
    movz	w26,	#0
    movz	w23,	#0
    movz	w25,	#0
    movz	fp,	#336
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
    movz	w6,	#0
    movz	fp,	#356
    movz	w2,	#0
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#548
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
    movz	fp,	#444
    movz	w11,	#62464
    add	x20,	sp,	#16
    mov	x26,	x21
    add	x8,	x21,	#12
    add	x16,	x21,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x21,	#4
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#540
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w22
    add	x11,	x21,	#8
    str	x25,	[sp, fp]

    movz	fp,	#532
    movk	fp,	#2,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#396
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#392
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
    str	w25,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w22,	#128
    movz	fp,	#540
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w8,	w1
    ldr	x12,	[sp, fp]

    str	w22,	[x12]


main_46:
    asr	w25,	w8,	#31
    lsr	w26,	w25,	#26
    add	w28,	w8,	w26
    asr	w1,	w28,	#6
    lsl	w2,	w1,	#6
    sub	w26,	w8,	w2
    cmp	w26,	#60
    beq	main_53

main_50:
    lsl	w3,	w8,	#2
    movz	fp,	#444
    movz	w0,	#0
    add	w12,	w8,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w12
    ldr	x5,	[sp, fp]

    add	x6,	x5,	x3
    str	w0,	[x6]

    b	main_46

main_53:
    lsl	w26,	w8,	#2
    movz	fp,	#444
    add	w23,	w8,	#1
    movz	w24,	#125
    movk	fp,	#2,	lsl #16
    lsl	w2,	w23,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x25,	x28,	x26
    movk	fp,	#2,	lsl #16
    movz	w26,	#0
    movz	w28,	#0
    str	w28,	[x25]

    add	w28,	w8,	#4
    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    add	w1,	w8,	#3
    ldr	x0,	[sp, fp]

    add	w26,	w8,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    lsl	w26,	w1,	#2
    add	x23,	x0,	x2
    movz	w2,	#0
    str	w24,	[x23]

    ldr	x1,	[sp, fp]

    movz	fp,	#532
    add	x25,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x25]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w23,	#0
    movz	w17,	#8961
    movz	w24,	#43913
    movz	w5,	#56574
    movz	w6,	#21622
    movz	w20,	#57840
    mov	w22,	w23
    movk	w17,	#26437,	lsl #16
    movk	w24,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w20,	#50130,	lsl #16
    mov	w27,	w17
    mov	w3,	w24
    mov	w13,	w5
    mov	w14,	w6
    mov	w26,	w20

main_63:
    movz	w17,	#0
    mov	w23,	w22
    mov	w10,	w17

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w15,	w10,	#2
    lsl	w5,	w23,	#2
    movz	fp,	#444
    add	w0,	w23,	#1
    add	w11,	w23,	#2
    add	w10,	w10,	#1
    mov	x15,	x15
    movk	fp,	#2,	lsl #16
    lsl	w16,	w0,	#2
    add	x15,	sp,	x15
    lsl	w7,	w11,	#2
    lsl	w12,	w10,	#2
    ldr	x25,	[sp, fp]

    add	w11,	w23,	#4
    add	x15,	x15,	#16
    movz	fp,	#444
    add	x2,	x25,	x5
    movk	fp,	#2,	lsl #16
    add	w20,	w11,	#2
    ldr	w6,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w18,	w6,	#24
    movz	fp,	#444
    add	x1,	x9,	x16
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x1]

    ldr	x21,	[sp, fp]

    lsl	w6,	w5,	#16
    movz	fp,	#444
    add	x17,	x21,	x7
    add	w8,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	w7,	w23,	#3
    mov	x6,	x12
    ldr	w0,	[x17]

    add	x6,	sp,	x6
    ldr	x25,	[sp, fp]

    lsl	w1,	w0,	#8
    lsl	w17,	w7,	#2
    movz	fp,	#444
    add	x6,	x6,	#16
    add	w2,	w8,	w1
    add	x9,	x25,	x17
    movk	fp,	#2,	lsl #16
    lsl	w25,	w11,	#2
    ldr	w18,	[x9]

    add	w7,	w2,	w18
    str	w7,	[x15]

    ldr	x8,	[sp, fp]

    movz	fp,	#444
    add	x24,	x8,	x25
    movk	fp,	#2,	lsl #16
    lsl	w8,	w20,	#2
    add	w25,	w11,	#1
    ldr	w0,	[x24]

    lsl	w18,	w0,	#24
    lsl	w17,	w25,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x0,	x0,	x17
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x0]

    ldr	x1,	[sp, fp]

    lsl	w7,	w2,	#16
    movz	fp,	#444
    add	x0,	x1,	x8
    add	w18,	w7,	w18
    movk	fp,	#2,	lsl #16
    add	w8,	w11,	#3
    ldr	w2,	[x0]

    ldr	x9,	[sp, fp]

    lsl	w5,	w2,	#8
    lsl	w16,	w8,	#2
    movz	fp,	#444
    add	w18,	w18,	w5
    movk	fp,	#2,	lsl #16
    add	x9,	x9,	x16
    add	w16,	w11,	#4
    ldr	w17,	[x9]

    lsl	w5,	w16,	#2
    add	w1,	w18,	w17
    str	w1,	[x6]

    ldr	x0,	[sp, fp]

    add	w1,	w10,	#1
    movz	fp,	#444
    add	x4,	x0,	x5
    movk	fp,	#2,	lsl #16
    add	w5,	w16,	#3
    lsl	w8,	w1,	#2
    ldr	w7,	[x4]

    mov	x2,	x8
    ldr	x17,	[sp, fp]

    lsl	w4,	w7,	#24
    add	w8,	w16,	#1
    add	x2,	sp,	x2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w11,	w8,	#2
    add	x2,	x2,	#16
    add	x9,	x17,	x11
    add	w17,	w16,	#2
    add	w16,	w16,	#4
    ldr	w11,	[x9]

    lsl	w25,	w17,	#2
    ldr	x18,	[sp, fp]

    lsl	w12,	w11,	#16
    movz	fp,	#444
    add	x18,	x18,	x25
    movk	fp,	#2,	lsl #16
    add	w11,	w12,	w4
    ldr	w25,	[x18]

    ldr	x6,	[sp, fp]

    lsl	w0,	w25,	#8
    movz	fp,	#444
    add	w4,	w11,	w0
    movk	fp,	#2,	lsl #16
    add	w11,	w1,	#1
    lsl	w0,	w5,	#2
    add	x20,	x6,	x0
    add	w23,	w11,	#1
    lsl	w25,	w11,	#2
    mov	x7,	x25
    ldr	w5,	[x20]

    lsl	w25,	w16,	#2
    add	x7,	sp,	x7
    add	w8,	w4,	w5
    add	w4,	w16,	#1
    str	w8,	[x2]

    add	x7,	x7,	#16
    lsl	w15,	w4,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#444
    add	x24,	x8,	x25
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x24]

    add	w24,	w16,	#3
    ldr	x4,	[sp, fp]

    lsl	w0,	w0,	#24
    movz	fp,	#444
    add	x8,	x4,	x15
    movk	fp,	#2,	lsl #16
    add	w4,	w16,	#2
    ldr	w18,	[x8]

    ldr	x12,	[sp, fp]

    lsl	w8,	w4,	#2
    lsl	w20,	w18,	#16
    movz	fp,	#444
    add	x6,	x12,	x8
    movk	fp,	#2,	lsl #16
    add	w0,	w20,	w0
    ldr	w10,	[x6]

    ldr	x12,	[sp, fp]

    lsl	w15,	w10,	#8
    movz	fp,	#444
    add	w2,	w0,	w15
    movk	fp,	#2,	lsl #16
    lsl	w0,	w24,	#2
    add	x25,	x12,	x0
    add	w12,	w16,	#4
    ldr	w1,	[x25]

    add	w10,	w12,	#1
    lsl	w4,	w12,	#2
    add	w25,	w12,	#4
    add	w1,	w2,	w1
    lsl	w16,	w10,	#2
    add	w8,	w25,	#1
    str	w1,	[x7]

    ldr	x20,	[sp, fp]

    lsl	w1,	w23,	#2
    movz	fp,	#444
    add	x2,	x20,	x4
    mov	x0,	x1
    movk	fp,	#2,	lsl #16
    add	w1,	w12,	#2
    add	x0,	sp,	x0
    ldr	w6,	[x2]

    ldr	x15,	[sp, fp]

    lsl	w7,	w6,	#24
    lsl	w5,	w1,	#2
    add	x0,	x0,	#16
    movz	fp,	#444
    add	x11,	x15,	x16
    movk	fp,	#2,	lsl #16
    lsl	w16,	w25,	#2
    ldr	w17,	[x11]

    ldr	x15,	[sp, fp]

    lsl	w24,	w17,	#16
    movz	fp,	#444
    add	x2,	x15,	x5
    add	w24,	w24,	w7
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x2]

    add	w2,	w12,	#3
    lsl	w9,	w7,	#8
    add	w9,	w24,	w9
    lsl	w6,	w2,	#2
    ldr	x24,	[sp, fp]

    movz	fp,	#444
    add	x4,	x24,	x6
    movk	fp,	#2,	lsl #16
    lsl	w6,	w8,	#2
    add	w8,	w25,	#2
    ldr	w7,	[x4]

    add	w7,	w9,	w7
    lsl	w5,	w8,	#2
    str	w7,	[x0]

    ldr	x24,	[sp, fp]

    add	w0,	w23,	#1
    movz	fp,	#444
    add	x15,	x24,	x16
    movk	fp,	#2,	lsl #16
    lsl	w11,	w0,	#2
    ldr	w20,	[x15]

    mov	x9,	x11
    ldr	x21,	[sp, fp]

    lsl	w1,	w20,	#24
    add	x9,	sp,	x9
    movz	fp,	#444
    add	x11,	x21,	x6
    movk	fp,	#2,	lsl #16
    add	x9,	x9,	#16
    ldr	w2,	[x11]

    lsl	w4,	w2,	#16
    add	w4,	w4,	w1
    ldr	x1,	[sp, fp]

    movz	fp,	#444
    add	x10,	x1,	x5
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x10]

    add	w10,	w0,	#1
    ldr	x7,	[sp, fp]

    lsl	w16,	w15,	#8
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    add	w18,	w4,	w16
    add	w16,	w25,	#3
    lsl	w1,	w16,	#2
    add	x23,	x7,	x1
    lsl	w7,	w10,	#2
    add	w1,	w25,	#4
    mov	x0,	x7
    ldr	w2,	[x23]

    add	x0,	sp,	x0
    add	w8,	w1,	#3
    add	w23,	w18,	w2
    lsl	w2,	w1,	#2
    add	x0,	x0,	#16
    str	w23,	[x9]

    add	w23,	w1,	#4
    ldr	x16,	[sp, fp]

    movz	fp,	#444
    add	x17,	x16,	x2
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x17]

    add	w17,	w1,	#1
    lsl	w16,	w5,	#24
    lsl	w9,	w17,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#444
    add	x18,	x17,	x9
    movk	fp,	#2,	lsl #16
    add	w9,	w1,	#2
    ldr	w25,	[x18]

    lsl	w20,	w9,	#2
    ldr	x17,	[sp, fp]

    lsl	w2,	w25,	#16
    movz	fp,	#444
    add	x12,	x17,	x20
    movk	fp,	#2,	lsl #16
    add	w4,	w2,	w16
    ldr	w20,	[x12]

    ldr	x19,	[sp, fp]

    lsl	w12,	w8,	#2
    lsl	w2,	w20,	#8
    add	x11,	x19,	x12
    add	w4,	w4,	w2
    add	w2,	w10,	#1
    ldr	w15,	[x11]

    mov	w10,	w2
    add	w7,	w4,	w15
    str	w7,	[x0]

    b	main_70

main_215:
    mov	w18,	w23
    mov	w2,	w10

main_217:
    lsl	w7,	w2,	#2
    lsl	w11,	w18,	#2
    movz	fp,	#444
    add	w1,	w18,	#1
    add	w0,	w18,	#2
    add	w24,	w2,	#1
    add	w20,	w18,	#4
    mov	x6,	x7
    movk	fp,	#2,	lsl #16
    lsl	w25,	w1,	#2
    add	x6,	sp,	x6
    ldr	x4,	[sp, fp]

    movz	fp,	#444
    add	x12,	x4,	x11
    add	x6,	x6,	#16
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x12]

    ldr	x1,	[sp, fp]

    lsl	w23,	w16,	#24
    movz	fp,	#444
    add	x4,	x1,	x25
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x4]

    ldr	x4,	[sp, fp]

    lsl	w16,	w10,	#16
    movz	fp,	#444
    add	w17,	w16,	w23
    movk	fp,	#2,	lsl #16
    lsl	w16,	w0,	#2
    add	x1,	x4,	x16
    ldr	w8,	[x1]

    add	w1,	w18,	#3
    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w17,	w9
    lsl	w17,	w1,	#2
    add	x4,	x8,	x17
    ldr	w17,	[x4]

    add	w23,	w9,	w17
    str	w23,	[x6]

    cmp	w24,	#16
    bge	main_241

main_216:
    mov	w18,	w20
    mov	w2,	w24
    b	main_217

main_241:
    mov	w12,	w24
    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]


main_242:
    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#484
    lsl	w20,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x20
    add	x17,	sp,	x17
    ldr	w23,	[sp, fp]

    movz	fp,	#484
    sub	w24,	w23,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w24,	#2
    mov	x25,	x2
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w5,	[x25]

    ldr	w2,	[sp, fp]

    movz	fp,	#484
    sub	w6,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w6,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w9,	[x7]

    ldr	w4,	[sp, fp]

    add	w7,	w9,	w5
    movz	fp,	#484
    sub	w23,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w11,	w5,	w7
    lsl	w25,	w23,	#2
    mov	x24,	x25
    add	w15,	w11,	w9
    add	x24,	sp,	x24
    sub	w7,	w15,	w7
    add	x24,	x24,	#16
    ldr	w0,	[x24]

    ldr	w5,	[sp, fp]

    add	w25,	w0,	w7
    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    sub	w1,	w7,	w25
    add	w10,	w1,	w0
    sub	w0,	w5,	#16
    sub	w23,	w10,	w25
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w5,	[x1]

    add	w2,	w5,	w23
    sub	w9,	w23,	w2
    add	w10,	w9,	w5
    sub	w15,	w10,	w2
    asr	w0,	w15,	#31
    lsl	w9,	w15,	#1
    lsr	w1,	w0,	#31
    add	w2,	w15,	w1
    asr	w10,	w2,	#1
    lsl	w11,	w10,	#1
    sub	w5,	w15,	w11
    add	w6,	w9,	w5
    str	w6,	[x17]

    ldr	w16,	[sp, fp]

    movz	fp,	#484
    add	w7,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w27
    movz	fp,	#436
    mov	w1,	w3
    mov	w16,	w13
    mov	w9,	w14
    mov	w11,	w26
    movz	w2,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w2
    str	w25,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

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
    movz	w17,	#31129
    movz	w20,	#65535
    movz	fp,	#412
    movk	w1,	#36635,	lsl #16
    movk	w0,	#28377,	lsl #16
    movk	w5,	#51810,	lsl #16
    movk	w17,	#23170,	lsl #16
    movk	w20,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w1
    mov	w24,	w5
    mov	w7,	w17
    mov	w15,	w20
    ldr	w9,	[sp, fp]

    cmp	w9,	#20
    bge	main_296

main_285:
    movz	fp,	#432
    mov	w1,	w15
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    add	w20,	w16,	w17
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    sub	w5,	w1,	w9
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    add	w17,	w16,	w5
    add	w1,	w17,	w20
    sub	w4,	w20,	w1
    add	w20,	w4,	w17
    sub	w17,	w20,	w1
    sub	w8,	w17,	w20
    add	w16,	w8,	w1
    sub	w5,	w16,	w20
    mov	w8,	w5
    mov	w5,	w7
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    cmp	w12,	#40
    bge	main_307

main_298:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    add	w5,	w17,	w20
    movk	fp,	#2,	lsl #16
    mov	w17,	w0
    ldr	w16,	[sp, fp]

    movz	fp,	#440
    sub	w8,	w16,	w5
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#416
    add	w1,	w8,	w2
    movk	fp,	#2,	lsl #16
    sub	w25,	w1,	w5
    ldr	w4,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w4,	w4,	w25
    sub	w8,	w25,	w4
    ldr	w25,	[sp, fp]

    add	w8,	w8,	w25
    sub	w5,	w8,	w4
    mov	w8,	w5
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    cmp	w16,	#60
    bge	main_327

main_309:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    add	w8,	w10,	w4
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    add	w20,	w9,	w17
    movk	fp,	#2,	lsl #16
    add	w23,	w20,	w8
    ldr	w10,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w17,	w8,	w23
    ldr	w19,	[sp, fp]

    add	w1,	w17,	w20
    sub	w5,	w1,	w23
    sub	w16,	w5,	w1
    add	w4,	w16,	w23
    add	w16,	w10,	w19
    sub	w5,	w4,	w1
    add	w23,	w16,	w5
    sub	w8,	w5,	w23
    add	w17,	w8,	w16
    sub	w4,	w17,	w23
    sub	w5,	w4,	w17
    add	w16,	w5,	w23
    sub	w5,	w16,	w17
    mov	w17,	w18
    mov	w8,	w5
    b	main_413

main_327:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    add	w4,	w17,	w8
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#440
    sub	w1,	w10,	w4
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    add	w25,	w1,	w20
    movk	fp,	#2,	lsl #16
    sub	w20,	w25,	w4
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w5,	w12,	w20
    ldr	w9,	[sp, fp]

    sub	w17,	w20,	w5
    add	w8,	w17,	w9
    mov	w17,	w24
    sub	w5,	w8,	w5
    mov	w8,	w5

main_413:
    mov	w5,	w17

main_416:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#436
    lsl	w16,	w2,	#5
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#436
    asr	w17,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w23,	w17,	#27
    ldr	w21,	[sp, fp]

    movz	fp,	#436
    add	w20,	w21,	w23
    movk	fp,	#2,	lsl #16
    asr	w17,	w20,	#5
    ldr	w23,	[sp, fp]

    movz	fp,	#412
    lsl	w1,	w17,	#5
    movk	fp,	#2,	lsl #16
    sub	w20,	w23,	w1
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w23,	w16,	w20
    lsl	w20,	w19,	#2
    mov	x25,	x20
    add	w17,	w23,	w11
    add	x25,	sp,	x25
    add	w1,	w17,	w8
    add	x25,	x25,	#16
    add	w16,	w1,	w5
    ldr	w4,	[x25]

    ldr	w12,	[sp, fp]

    movz	fp,	#432
    add	w8,	w16,	w4
    movk	fp,	#2,	lsl #16
    lsl	w16,	w12,	#30
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    asr	w5,	w12,	#31
    movk	fp,	#2,	lsl #16
    lsr	w11,	w5,	#2
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    add	w1,	w10,	w11
    movk	fp,	#2,	lsl #16
    asr	w1,	w1,	#30
    ldr	w12,	[sp, fp]

    movz	fp,	#412
    lsl	w5,	w1,	#30
    movk	fp,	#2,	lsl #16
    sub	w23,	w12,	w5
    ldr	w12,	[sp, fp]

    add	w12,	w12,	#1
    add	w25,	w16,	w23
    cmp	w12,	#20
    bge	main_364

main_336:
    movz	fp,	#436
    mov	w4,	w15
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#436
    add	w16,	w25,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#440
    sub	w0,	w4,	w1
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w1,	w15,	w0
    add	w20,	w1,	w16
    sub	w17,	w16,	w20
    add	w17,	w17,	w1
    sub	w23,	w17,	w20
    sub	w24,	w23,	w17
    add	w1,	w24,	w20
    mov	w20,	w7
    sub	w18,	w1,	w17
    mov	w24,	w18
    b	main_347

main_364:
    cmp	w12,	#40
    bge	main_378

main_366:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#436
    add	w17,	w25,	w17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#440
    sub	w5,	w7,	w17
    movk	fp,	#2,	lsl #16
    add	w2,	w5,	w25
    ldr	w16,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w4,	w2,	w17
    ldr	w21,	[sp, fp]

    add	w2,	w16,	w4
    sub	w11,	w4,	w2
    add	w23,	w11,	w21
    sub	w17,	w23,	w2
    b	main_375

main_378:
    cmp	w12,	#60
    bge	main_401

main_380:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    add	w1,	w25,	w20
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#440
    add	w24,	w2,	w7
    movk	fp,	#2,	lsl #16
    add	w11,	w24,	w1
    ldr	w21,	[sp, fp]

    sub	w7,	w1,	w11
    add	w4,	w7,	w24
    add	w7,	w21,	w25
    sub	w20,	w4,	w11
    sub	w1,	w20,	w4
    add	w0,	w1,	w11
    sub	w2,	w0,	w4
    add	w0,	w7,	w2
    sub	w15,	w2,	w0
    add	w11,	w15,	w7
    sub	w23,	w11,	w0
    sub	w1,	w23,	w11
    add	w7,	w1,	w0
    mov	w1,	w18
    sub	w16,	w7,	w11
    mov	w17,	w16
    b	main_398

main_401:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#436
    add	w16,	w25,	w0
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#440
    sub	w1,	w11,	w16
    movk	fp,	#2,	lsl #16
    add	w2,	w1,	w25
    ldr	w23,	[sp, fp]

    mov	w1,	w24
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w0,	w2,	w16
    ldr	w7,	[sp, fp]

    add	w18,	w23,	w0
    sub	w2,	w0,	w18
    add	w4,	w2,	w7
    sub	w16,	w4,	w18
    mov	w17,	w16

main_398:
    mov	w0,	w1

main_375:
    mov	w24,	w17
    mov	w20,	w0

main_347:
    lsl	w18,	w8,	#5
    asr	w1,	w8,	#31
    lsl	w16,	w12,	#2
    movz	fp,	#416
    lsr	w2,	w1,	#27
    mov	x4,	x16
    movk	fp,	#2,	lsl #16
    add	x4,	sp,	x4
    add	w5,	w8,	w2
    add	x4,	x4,	#16
    asr	w11,	w5,	#5
    ldr	w0,	[x4]

    lsl	w1,	w11,	#5
    ldr	w17,	[sp, fp]

    sub	w15,	w8,	w1
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w4,	w15,	w17
    add	w6,	w4,	w18
    add	w2,	w6,	w24
    add	w6,	w2,	w20
    add	w18,	w6,	w0
    ldr	w6,	[sp, fp]

    movz	fp,	#436
    lsl	w6,	w6,	#30
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#436
    asr	w16,	w23,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w16,	#2
    ldr	w0,	[sp, fp]

    movz	fp,	#436
    add	w1,	w0,	w24
    movk	fp,	#2,	lsl #16
    asr	w2,	w1,	#30
    ldr	w5,	[sp, fp]

    lsl	w7,	w2,	#30
    add	w2,	w12,	#1
    sub	w16,	w5,	w7
    add	w0,	w6,	w16
    cmp	w2,	#80
    blt	main_276

main_433:
    add	w23,	w18,	w27
    add	w3,	w8,	w3
    add	w16,	w0,	w13
    movz	fp,	#440
    add	w18,	w25,	w14
    add	w0,	w22,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w2,	w7,	w26
    cmp	w0,	w28
    blt	main_62

main_441:
    movz	fp,	#492
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#500
    str	w23,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#524
    str	w3,	[x4]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#516
    str	w16,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#396
    str	w18,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w2,	[x23]


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
    sub	w23,	w17,	w6
    str	w23,	[x25]

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

    mov	w0,	w6
    b	main_28

main_62:
    mov	w27,	w23
    mov	w13,	w16
    mov	w14,	w18
    mov	w26,	w2
    mov	w22,	w0
    b	main_63

main_276:
    mov	w16,	w18
    movz	fp,	#436
    mov	w11,	w8
    mov	w12,	w25
    mov	w9,	w0
    movk	fp,	#2,	lsl #16
    mov	w8,	w2
    str	w16,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    mov	w11,	w10
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#548
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


