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
    movz	w24,	#0
    movz	w23,	#0
    movz	fp,	#336
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
    movz	w5,	#0
    movz	fp,	#356
    movz	w6,	#0
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
    movz	fp,	#444
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x26,	x20
    add	x8,	x20,	#12
    add	x16,	x20,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x20,	#4
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#532
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
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

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#428
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#428
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#428
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
    movz	fp,	#444
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
    movz	fp,	#444
    add	w21,	w3,	#1
    movz	w22,	#125
    add	w19,	w3,	#4
    movk	fp,	#2,	lsl #16
    lsl	w27,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x23,	x28,	x24
    movk	fp,	#2,	lsl #16
    movz	w24,	#0
    movz	w28,	#0
    str	w28,	[x23]

    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x1,	x0,	x27
    movk	fp,	#2,	lsl #16
    str	w24,	[x1]

    ldr	x0,	[sp, fp]

    add	w24,	w3,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w2,	w24,	#2
    add	x20,	x0,	x2
    movz	w2,	#0
    add	w0,	w3,	#3
    str	w22,	[x20]

    lsl	w24,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#524
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
    movz	w3,	#56574
    movz	w18,	#57840
    mov	w7,	w23
    movk	w17,	#26437,	lsl #16
    movk	w24,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w18,	#50130,	lsl #16
    mov	w11,	w17
    mov	w13,	w24
    mov	w0,	w3
    mov	w27,	w18
    movz	w3,	#21622
    movk	w3,	#4146,	lsl #16
    mov	w21,	w3

main_63:
    movz	w18,	#0
    mov	w23,	w7
    mov	w12,	w18

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w18,	w12,	#2
    lsl	w4,	w23,	#2
    movz	fp,	#444
    add	w6,	w23,	#3
    add	w12,	w12,	#1
    mov	x18,	x18
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    ldr	x1,	[sp, fp]

    add	x18,	x18,	#16
    movz	fp,	#444
    add	x3,	x1,	x4
    movk	fp,	#2,	lsl #16
    add	w1,	w23,	#1
    ldr	w5,	[x3]

    lsl	w20,	w1,	#2
    ldr	x10,	[sp, fp]

    lsl	w14,	w5,	#24
    movz	fp,	#444
    add	x2,	x10,	x20
    movk	fp,	#2,	lsl #16
    lsl	w10,	w6,	#2
    ldr	w4,	[x2]

    ldr	x25,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#444
    add	w8,	w5,	w14
    movk	fp,	#2,	lsl #16
    add	w14,	w23,	#2
    lsl	w5,	w14,	#2
    add	w14,	w23,	#4
    add	x22,	x25,	x5
    add	w17,	w14,	#2
    ldr	w1,	[x22]

    ldr	x28,	[sp, fp]

    lsl	w3,	w1,	#8
    movz	fp,	#444
    add	w3,	w8,	w3
    movk	fp,	#2,	lsl #16
    add	x8,	x28,	x10
    lsl	w28,	w14,	#2
    ldr	w15,	[x8]

    add	w6,	w3,	w15
    str	w6,	[x18]

    ldr	x8,	[sp, fp]

    lsl	w6,	w12,	#2
    movz	fp,	#444
    add	x24,	x8,	x28
    mov	x4,	x6
    movk	fp,	#2,	lsl #16
    lsl	w8,	w17,	#2
    add	w28,	w14,	#1
    ldr	w2,	[x24]

    add	x4,	sp,	x4
    lsl	w23,	w2,	#24
    lsl	w15,	w28,	#2
    ldr	x2,	[sp, fp]

    add	x4,	x4,	#16
    add	w28,	w12,	#1
    movz	fp,	#444
    add	x1,	x2,	x15
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x1]

    ldr	x3,	[sp, fp]

    lsl	w6,	w5,	#16
    movz	fp,	#444
    add	x1,	x3,	x8
    add	w15,	w6,	w23
    movk	fp,	#2,	lsl #16
    add	w8,	w14,	#3
    ldr	w3,	[x1]

    add	w1,	w14,	#4
    ldr	x9,	[sp, fp]

    lsl	w22,	w8,	#2
    lsl	w5,	w3,	#8
    movz	fp,	#444
    lsl	w8,	w28,	#2
    add	w14,	w1,	#3
    add	w6,	w1,	#1
    add	x9,	x9,	x22
    add	w20,	w15,	w5
    movk	fp,	#2,	lsl #16
    mov	x8,	x8
    lsl	w24,	w6,	#2
    add	w22,	w1,	#2
    ldr	w23,	[x9]

    add	x8,	sp,	x8
    add	w3,	w20,	w23
    add	w23,	w28,	#1
    add	x8,	x8,	#16
    str	w3,	[x4]

    ldr	x2,	[sp, fp]

    lsl	w4,	w1,	#2
    movz	fp,	#444
    add	x3,	x2,	x4
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    ldr	w5,	[x3]

    ldr	x16,	[sp, fp]

    lsl	w3,	w5,	#24
    movz	fp,	#444
    add	x10,	x16,	x24
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x10]

    ldr	x18,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#444
    add	x24,	x18,	x2
    add	w20,	w16,	w3
    movk	fp,	#2,	lsl #16
    lsl	w3,	w14,	#2
    ldr	w4,	[x24]

    ldr	x5,	[sp, fp]

    lsl	w6,	w4,	#8
    movz	fp,	#444
    add	x16,	x5,	x3
    add	w2,	w20,	w6
    movk	fp,	#2,	lsl #16
    add	w5,	w1,	#4
    ldr	w4,	[x16]

    lsl	w1,	w23,	#2
    add	w9,	w2,	w4
    mov	x24,	x1
    add	w17,	w5,	#4
    add	w6,	w5,	#1
    lsl	w22,	w5,	#2
    add	x24,	sp,	x24
    str	w9,	[x8]

    ldr	x8,	[sp, fp]

    add	x24,	x24,	#16
    movz	fp,	#444
    add	x20,	x8,	x22
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x20]

    add	w20,	w5,	#3
    ldr	x9,	[sp, fp]

    lsl	w4,	w2,	#24
    movz	fp,	#444
    lsl	w2,	w6,	#2
    movk	fp,	#2,	lsl #16
    lsl	w28,	w20,	#2
    add	x8,	x9,	x2
    ldr	w12,	[x8]

    ldr	x9,	[sp, fp]

    lsl	w15,	w12,	#16
    movz	fp,	#444
    add	w1,	w15,	w4
    movk	fp,	#2,	lsl #16
    add	w15,	w17,	#1
    add	w4,	w5,	#2
    lsl	w20,	w15,	#2
    lsl	w14,	w4,	#2
    add	x8,	x9,	x14
    add	w9,	w23,	#1
    ldr	w10,	[x8]

    add	w6,	w9,	#1
    lsl	w2,	w9,	#2
    lsl	w14,	w10,	#8
    ldr	x10,	[sp, fp]

    add	w3,	w1,	w14
    movz	fp,	#444
    add	x22,	x10,	x28
    mov	x1,	x2
    movk	fp,	#2,	lsl #16
    add	x1,	sp,	x1
    ldr	w4,	[x22]

    add	x1,	x1,	#16
    add	w3,	w3,	w4
    lsl	w4,	w17,	#2
    str	w3,	[x24]

    ldr	x25,	[sp, fp]

    movz	fp,	#444
    add	x3,	x25,	x4
    movk	fp,	#2,	lsl #16
    add	w4,	w17,	#2
    ldr	w5,	[x3]

    lsl	w4,	w4,	#2
    add	w3,	w17,	#3
    ldr	x25,	[sp, fp]

    lsl	w8,	w5,	#24
    movz	fp,	#444
    add	x16,	x25,	x20
    movk	fp,	#2,	lsl #16
    lsl	w20,	w6,	#2
    mov	x2,	x20
    ldr	w24,	[x16]

    add	x2,	sp,	x2
    ldr	x23,	[sp, fp]

    lsl	w28,	w24,	#16
    movz	fp,	#444
    add	x5,	x23,	x4
    add	x2,	x2,	#16
    add	w28,	w28,	w8
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x5]

    lsl	w5,	w3,	#2
    lsl	w12,	w8,	#8
    add	w10,	w28,	w12
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x4,	x28,	x5
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x4]

    add	w8,	w10,	w8
    add	w10,	w17,	#4
    str	w8,	[x1]

    add	w12,	w10,	#1
    lsl	w23,	w10,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#444
    add	x22,	x3,	x23
    lsl	w8,	w12,	#2
    movk	fp,	#2,	lsl #16
    add	w12,	w10,	#2
    ldr	w24,	[x22]

    ldr	x26,	[sp, fp]

    lsl	w4,	w24,	#24
    lsl	w5,	w12,	#2
    movz	fp,	#444
    add	x15,	x26,	x8
    add	w24,	w10,	#3
    add	w12,	w6,	#1
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x15]

    ldr	x8,	[sp, fp]

    lsl	w3,	w1,	#16
    movz	fp,	#444
    add	x16,	x8,	x5
    add	w4,	w3,	w4
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x16]

    ldr	x9,	[sp, fp]

    lsl	w23,	w22,	#8
    movz	fp,	#444
    add	w20,	w4,	w23
    movk	fp,	#2,	lsl #16
    lsl	w4,	w24,	#2
    add	x1,	x9,	x4
    add	w4,	w10,	#4
    ldr	w5,	[x1]

    add	w23,	w4,	#4
    add	w8,	w4,	#3
    add	w17,	w4,	#1
    lsl	w1,	w4,	#2
    add	w28,	w20,	w5
    lsl	w5,	w12,	#2
    lsl	w9,	w17,	#2
    mov	x3,	x5
    str	w28,	[x2]

    add	x3,	sp,	x3
    ldr	x16,	[sp, fp]

    movz	fp,	#444
    add	x15,	x16,	x1
    add	x3,	x3,	#16
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x15]

    ldr	x17,	[sp, fp]

    lsl	w16,	w5,	#24
    movz	fp,	#444
    add	x22,	x17,	x9
    movk	fp,	#2,	lsl #16
    add	w9,	w4,	#2
    ldr	w24,	[x22]

    ldr	x17,	[sp, fp]

    lsl	w22,	w9,	#2
    lsl	w28,	w24,	#16
    movz	fp,	#444
    add	x10,	x17,	x22
    movk	fp,	#2,	lsl #16
    add	w1,	w28,	w16
    ldr	w17,	[x10]

    ldr	x22,	[sp, fp]

    lsl	w10,	w8,	#2
    lsl	w2,	w17,	#8
    add	x9,	x22,	x10
    add	w2,	w1,	w2
    ldr	w14,	[x9]

    add	w6,	w2,	w14
    str	w6,	[x3]

    add	w3,	w12,	#1
    mov	w12,	w3
    b	main_70

main_215:
    mov	w20,	w23
    mov	w2,	w12

main_217:
    lsl	w6,	w2,	#2
    lsl	w14,	w20,	#2
    movz	fp,	#444
    add	w1,	w20,	#2
    add	w24,	w2,	#1
    mov	x5,	x6
    movk	fp,	#2,	lsl #16
    add	x5,	sp,	x5
    ldr	x4,	[sp, fp]

    add	x5,	x5,	#16
    movz	fp,	#444
    add	x15,	x4,	x14
    movk	fp,	#2,	lsl #16
    lsl	w14,	w1,	#2
    add	w4,	w20,	#1
    ldr	w22,	[x15]

    lsl	w28,	w4,	#2
    ldr	x3,	[sp, fp]

    lsl	w23,	w22,	#24
    movz	fp,	#444
    add	x6,	x3,	x28
    add	w22,	w20,	#4
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x6]

    ldr	x4,	[sp, fp]

    lsl	w12,	w9,	#16
    movz	fp,	#444
    add	x3,	x4,	x14
    add	w12,	w12,	w23
    movk	fp,	#2,	lsl #16
    add	w4,	w20,	#3
    ldr	w8,	[x3]

    lsl	w9,	w8,	#8
    lsl	w23,	w4,	#2
    ldr	x8,	[sp, fp]

    add	w9,	w12,	w9
    add	x6,	x8,	x23
    ldr	w14,	[x6]

    add	w23,	w9,	w14
    str	w23,	[x5]

    cmp	w24,	#16
    bge	main_241

main_216:
    mov	w20,	w22
    mov	w2,	w24
    b	main_217

main_241:
    mov	w15,	w24
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#492
    lsl	w22,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x22
    add	x18,	sp,	x18
    ldr	w25,	[sp, fp]

    movz	fp,	#492
    sub	w28,	w25,	#3
    add	x18,	x18,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w28,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    ldr	w4,	[sp, fp]

    movz	fp,	#492
    sub	w5,	w4,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w5,	#2
    mov	x6,	x8
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w9,	[x6]

    ldr	w4,	[sp, fp]

    add	w6,	w9,	w3
    movz	fp,	#492
    sub	w23,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w14,	w3,	w6
    lsl	w1,	w23,	#2
    mov	x24,	x1
    add	w20,	w14,	w9
    add	x24,	sp,	x24
    sub	w6,	w20,	w6
    add	x24,	x24,	#16
    ldr	w2,	[x24]

    ldr	w5,	[sp, fp]

    add	w28,	w2,	w6
    movz	fp,	#492
    sub	w1,	w5,	#16
    movk	fp,	#2,	lsl #16
    sub	w3,	w6,	w28
    add	w6,	w3,	w2
    lsl	w3,	w1,	#2
    mov	x2,	x3
    sub	w23,	w6,	w28
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w4,	[x2]

    add	w3,	w4,	w23
    sub	w9,	w23,	w3
    add	w12,	w9,	w4
    sub	w14,	w12,	w3
    asr	w1,	w14,	#31
    lsl	w6,	w14,	#1
    lsr	w2,	w1,	#31
    add	w3,	w14,	w2
    asr	w12,	w3,	#1
    lsl	w16,	w12,	#1
    sub	w4,	w14,	w16
    add	w5,	w6,	w4
    str	w5,	[x18]

    ldr	w17,	[sp, fp]

    movz	fp,	#492
    add	w6,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w6
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w24,	w11
    movz	fp,	#436
    mov	w2,	w13
    mov	w18,	w0
    mov	w10,	w21
    mov	w4,	w27
    movz	w3,	#0
    movk	fp,	#2,	lsl #16
    mov	w28,	w3
    str	w24,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w28,	[sp, fp]


main_277:
    movz	w3,	#48348
    movz	w12,	#60289
    movz	w28,	#31129
    movz	w22,	#65535
    movz	fp,	#412
    movk	w3,	#36635,	lsl #16
    movk	w12,	#28377,	lsl #16
    movk	w28,	#23170,	lsl #16
    movk	w22,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w20,	w3
    mov	w6,	w12
    mov	w16,	w28
    mov	w15,	w22
    ldr	w17,	[sp, fp]

    movz	w3,	#49414
    movk	w3,	#51810,	lsl #16
    mov	w2,	w3
    cmp	w17,	#20
    bge	main_296

main_285:
    movz	fp,	#432
    mov	w3,	w15
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#432
    add	w12,	w25,	w18
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    sub	w10,	w3,	w10
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    add	w22,	w18,	w10
    add	w3,	w22,	w12
    sub	w23,	w12,	w3
    add	w5,	w23,	w22
    sub	w28,	w5,	w3
    sub	w12,	w28,	w5
    add	w17,	w12,	w3
    sub	w17,	w17,	w5
    mov	w24,	w17
    mov	w17,	w16
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    cmp	w18,	#40
    bge	main_307

main_298:
    movz	fp,	#432
    mov	w28,	w6
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#432
    add	w17,	w26,	w24
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#440
    sub	w22,	w22,	w17
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    add	w3,	w22,	w8
    movk	fp,	#2,	lsl #16
    sub	w24,	w3,	w17
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w12,	w5,	w24
    ldr	w26,	[sp, fp]

    sub	w10,	w24,	w12
    add	w10,	w10,	w26
    sub	w17,	w10,	w12
    mov	w5,	w17
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    cmp	w24,	#60
    bge	main_327

main_309:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    add	w3,	w10,	w5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#416
    add	w23,	w10,	w23
    movk	fp,	#2,	lsl #16
    add	w22,	w23,	w3
    ldr	w18,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w5,	w3,	w22
    add	w17,	w5,	w23
    sub	w10,	w17,	w22
    sub	w12,	w10,	w17
    add	w3,	w12,	w22
    ldr	w12,	[sp, fp]

    add	w12,	w18,	w12
    sub	w17,	w3,	w17
    add	w28,	w12,	w17
    sub	w3,	w17,	w28
    add	w24,	w3,	w12
    sub	w22,	w24,	w28
    sub	w10,	w22,	w24
    add	w12,	w10,	w28
    mov	w28,	w20
    sub	w17,	w12,	w24
    mov	w5,	w17
    b	main_413

main_327:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    add	w12,	w18,	w9
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#440
    sub	w22,	w9,	w12
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#416
    add	w17,	w22,	w23
    movk	fp,	#2,	lsl #16
    sub	w12,	w17,	w12
    ldr	w18,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w10,	w18,	w12
    ldr	w9,	[sp, fp]

    sub	w28,	w12,	w10
    add	w22,	w28,	w9
    mov	w28,	w2
    sub	w17,	w22,	w10
    mov	w5,	w17

main_413:
    mov	w24,	w5
    mov	w17,	w28

main_416:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#436
    lsl	w23,	w1,	#5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#436
    asr	w12,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w10,	w12,	#27
    ldr	w14,	[sp, fp]

    movz	fp,	#436
    add	w22,	w14,	w10
    movk	fp,	#2,	lsl #16
    asr	w12,	w22,	#5
    ldr	w25,	[sp, fp]

    movz	fp,	#412
    lsl	w10,	w12,	#5
    movk	fp,	#2,	lsl #16
    sub	w22,	w25,	w10
    add	w28,	w23,	w22
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    lsl	w10,	w22,	#2
    movk	fp,	#2,	lsl #16
    mov	x3,	x10
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    ldr	w12,	[x3]

    ldr	w18,	[sp, fp]

    add	w3,	w28,	w4
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w24,	w3,	w24
    add	w28,	w24,	w17
    add	w10,	w28,	w12
    lsl	w12,	w18,	#30
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    asr	w22,	w18,	#31
    movk	fp,	#2,	lsl #16
    lsr	w23,	w22,	#2
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    add	w24,	w9,	w23
    movk	fp,	#2,	lsl #16
    asr	w3,	w24,	#30
    ldr	w18,	[sp, fp]

    movz	fp,	#412
    lsl	w22,	w3,	#30
    movk	fp,	#2,	lsl #16
    sub	w22,	w18,	w22
    ldr	w9,	[sp, fp]

    add	w4,	w9,	#1
    add	w22,	w12,	w22
    cmp	w4,	#20
    bge	main_364

main_336:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#436
    add	w20,	w22,	w1
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#440
    sub	w1,	w15,	w2
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    add	w2,	w14,	w1
    add	w15,	w2,	w20
    sub	w17,	w20,	w15
    add	w12,	w17,	w2
    sub	w17,	w12,	w15
    sub	w20,	w17,	w12
    add	w28,	w20,	w15
    sub	w20,	w28,	w12
    mov	w12,	w16
    mov	w24,	w20
    b	main_347

main_364:
    cmp	w4,	#40
    bge	main_378

main_366:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    add	w16,	w22,	w20
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#440
    sub	w23,	w5,	w16
    movk	fp,	#2,	lsl #16
    add	w1,	w23,	w22
    mov	w23,	w6
    sub	w1,	w1,	w16
    ldr	w16,	[sp, fp]

    movz	fp,	#440
    add	w18,	w16,	w1
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    sub	w3,	w1,	w18
    add	w16,	w3,	w25
    sub	w17,	w16,	w18
    b	main_375

main_378:
    cmp	w4,	#60
    bge	main_401

main_380:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#436
    add	w23,	w22,	w24
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#440
    add	w17,	w3,	w8
    movk	fp,	#2,	lsl #16
    add	w2,	w17,	w23
    ldr	w25,	[sp, fp]

    add	w6,	w25,	w22
    sub	w12,	w23,	w2
    add	w3,	w12,	w17
    sub	w16,	w3,	w2
    sub	w17,	w16,	w3
    add	w1,	w17,	w2
    mov	w2,	w20
    sub	w3,	w1,	w3
    add	w1,	w6,	w3
    sub	w12,	w3,	w1
    add	w24,	w12,	w6
    sub	w17,	w24,	w1
    sub	w28,	w17,	w24
    add	w3,	w28,	w1
    sub	w16,	w3,	w24
    mov	w18,	w16
    b	main_398

main_401:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#436
    add	w16,	w22,	w3
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#440
    sub	w5,	w17,	w16
    movk	fp,	#2,	lsl #16
    add	w6,	w5,	w22
    ldr	w1,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w3,	w6,	w16
    ldr	w8,	[sp, fp]

    add	w18,	w1,	w3
    sub	w6,	w3,	w18
    add	w5,	w6,	w8
    sub	w17,	w5,	w18
    mov	w18,	w17

main_398:
    mov	w17,	w18
    mov	w23,	w2

main_375:
    mov	w24,	w17
    mov	w12,	w23

main_347:
    lsl	w6,	w10,	#5
    asr	w20,	w10,	#31
    lsl	w28,	w4,	#2
    movz	fp,	#416
    lsr	w2,	w20,	#27
    mov	x23,	x28
    movk	fp,	#2,	lsl #16
    add	x23,	sp,	x23
    add	w15,	w10,	w2
    add	x23,	x23,	#16
    asr	w20,	w15,	#5
    lsl	w1,	w20,	#5
    sub	w5,	w10,	w1
    ldr	w1,	[x23]

    ldr	w18,	[sp, fp]

    movz	fp,	#436
    add	w5,	w5,	w18
    movk	fp,	#2,	lsl #16
    add	w6,	w5,	w6
    ldr	w5,	[sp, fp]

    movz	fp,	#436
    add	w17,	w6,	w24
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    add	w6,	w17,	w12
    movz	fp,	#436
    asr	w15,	w26,	#31
    lsl	w12,	w5,	#30
    movk	fp,	#2,	lsl #16
    add	w23,	w6,	w1
    lsr	w18,	w15,	#2
    ldr	w2,	[sp, fp]

    movz	fp,	#436
    add	w17,	w2,	w18
    movk	fp,	#2,	lsl #16
    asr	w3,	w17,	#30
    ldr	w5,	[sp, fp]

    add	w17,	w4,	#1
    lsl	w6,	w3,	#30
    sub	w16,	w5,	w6
    add	w24,	w12,	w16
    cmp	w17,	#80
    blt	main_276

main_433:
    add	w18,	w23,	w11
    add	w16,	w10,	w13
    add	w2,	w22,	w21
    movz	fp,	#440
    add	w9,	w7,	#64
    add	w10,	w24,	w0
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    add	w3,	w8,	w27
    cmp	w9,	w19
    blt	main_62

main_441:
    movz	fp,	#508
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#516
    str	w18,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#500
    str	w16,	[x4]

    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#452
    str	w10,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#404
    str	w2,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w3,	[x23]


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

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w18
    mov	w13,	w16
    mov	w0,	w10
    mov	w21,	w2
    mov	w27,	w3
    mov	w7,	w9
    b	main_63

main_276:
    mov	w18,	w23
    movz	fp,	#436
    mov	w26,	w10
    mov	w12,	w22
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    mov	w12,	w24
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#412
    mov	w4,	w8
    movk	fp,	#2,	lsl #16
    mov	w8,	w17
    str	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

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


