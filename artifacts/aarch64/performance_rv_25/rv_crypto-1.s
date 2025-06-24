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
    movz	w23,	#0
    movz	w24,	#0
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
    movz	w6,	#0
    movz	w2,	#0
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#612
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
    movz	fp,	#524
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x26,	x20
    add	x8,	x20,	#12
    add	x16,	x20,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x20,	#4
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#628
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#580
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#588
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#568
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#508
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#508
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#508
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
    movz	w21,	#128
    movz	fp,	#628
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w8,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w24,	w8,	#31
    lsr	w25,	w24,	#26
    add	w28,	w8,	w25
    asr	w1,	w28,	#6
    lsl	w2,	w1,	#6
    sub	w25,	w8,	w2
    cmp	w25,	#60
    beq	main_53

main_50:
    lsl	w3,	w8,	#2
    movz	fp,	#524
    movz	w0,	#0
    add	w12,	w8,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w12
    ldr	x5,	[sp, fp]

    add	x6,	x5,	x3
    str	w0,	[x6]

    b	main_46

main_53:
    lsl	w25,	w8,	#2
    movz	fp,	#524
    add	w22,	w8,	#1
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#524
    add	x24,	x28,	x25
    movk	fp,	#2,	lsl #16
    movz	w25,	#0
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#524
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    add	w1,	w8,	#3
    ldr	x0,	[sp, fp]

    add	w25,	w8,	#2
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    str	w23,	[x22]

    add	w23,	w8,	#4
    ldr	x1,	[sp, fp]

    movz	fp,	#620
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w24,	#0
    movz	w17,	#8961
    movz	w6,	#21622
    movz	w27,	#43913
    movz	w18,	#57840
    movz	w5,	#56574
    movk	w17,	#26437,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w18,	#50130,	lsl #16
    movk	w5,	#39098,	lsl #16
    mov	w11,	w17
    mov	w1,	w6
    mov	w3,	w27
    mov	w20,	w5
    mov	w27,	w18
    mov	w18,	w24

main_63:
    movz	w16,	#0
    mov	w22,	w18
    mov	w12,	w16

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w16,	w12,	#2
    lsl	w6,	w22,	#2
    movz	fp,	#524
    add	w13,	w22,	#2
    add	w12,	w12,	#1
    mov	x15,	x16
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    lsl	w8,	w13,	#2
    ldr	x0,	[sp, fp]

    add	w13,	w22,	#4
    add	x15,	x15,	#16
    movz	fp,	#524
    add	x4,	x0,	x6
    movk	fp,	#2,	lsl #16
    add	w25,	w13,	#1
    add	w0,	w22,	#1
    ldr	w7,	[x4]

    lsl	w17,	w0,	#2
    ldr	x10,	[sp, fp]

    lsl	w16,	w7,	#24
    movz	fp,	#524
    add	x2,	x10,	x17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x2]

    ldr	x24,	[sp, fp]

    lsl	w7,	w6,	#16
    movz	fp,	#524
    add	x21,	x24,	x8
    add	w9,	w7,	w16
    movk	fp,	#2,	lsl #16
    add	w8,	w22,	#3
    lsl	w16,	w25,	#2
    ldr	w2,	[x21]

    add	w25,	w12,	#1
    add	w21,	w13,	#2
    ldr	x0,	[sp, fp]

    lsl	w14,	w8,	#2
    lsl	w4,	w2,	#8
    movz	fp,	#524
    add	x10,	x0,	x14
    add	w4,	w9,	w4
    movk	fp,	#2,	lsl #16
    lsl	w0,	w13,	#2
    lsl	w9,	w12,	#2
    ldr	w17,	[x10]

    mov	x7,	x9
    add	w8,	w4,	w17
    lsl	w9,	w21,	#2
    add	x7,	sp,	x7
    str	w8,	[x15]

    add	x7,	x7,	#16
    ldr	x10,	[sp, fp]

    movz	fp,	#524
    add	x24,	x10,	x0
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x24]

    lsl	w22,	w2,	#24
    ldr	x2,	[sp, fp]

    movz	fp,	#524
    add	x2,	x2,	x16
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x2]

    add	w2,	w13,	#4
    ldr	x5,	[sp, fp]

    lsl	w8,	w6,	#16
    movz	fp,	#524
    add	x0,	x5,	x9
    movk	fp,	#2,	lsl #16
    add	w21,	w2,	#2
    add	w16,	w8,	w22
    add	w9,	w13,	#3
    add	w8,	w2,	#1
    ldr	w4,	[x0]

    ldr	x10,	[sp, fp]

    lsl	w6,	w4,	#8
    lsl	w28,	w8,	#2
    movz	fp,	#524
    add	w17,	w16,	w6
    movk	fp,	#2,	lsl #16
    lsl	w16,	w9,	#2
    lsl	w9,	w25,	#2
    add	x10,	x10,	x16
    mov	x9,	x9
    add	x9,	sp,	x9
    ldr	w22,	[x10]

    add	x9,	x9,	#16
    add	w5,	w17,	w22
    str	w5,	[x7]

    ldr	x0,	[sp, fp]

    lsl	w5,	w2,	#2
    movz	fp,	#524
    add	x4,	x0,	x5
    movk	fp,	#2,	lsl #16
    lsl	w0,	w21,	#2
    ldr	w7,	[x4]

    ldr	x15,	[sp, fp]

    lsl	w4,	w7,	#24
    movz	fp,	#524
    add	x12,	x15,	x28
    add	w7,	w2,	#4
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x12]

    lsl	w22,	w7,	#2
    ldr	x17,	[sp, fp]

    lsl	w15,	w14,	#16
    movz	fp,	#524
    add	x24,	x17,	x0
    movk	fp,	#2,	lsl #16
    add	w16,	w15,	w4
    add	w15,	w2,	#3
    ldr	w5,	[x24]

    ldr	x6,	[sp, fp]

    lsl	w8,	w5,	#8
    lsl	w0,	w15,	#2
    movz	fp,	#524
    add	w5,	w16,	w8
    movk	fp,	#2,	lsl #16
    add	x17,	x6,	x0
    add	w8,	w7,	#1
    ldr	w4,	[x17]

    add	w17,	w25,	#1
    add	w10,	w5,	w4
    add	w6,	w17,	#1
    lsl	w0,	w17,	#2
    str	w10,	[x9]

    mov	x28,	x0
    ldr	x9,	[sp, fp]

    add	x28,	sp,	x28
    movz	fp,	#524
    add	x21,	x9,	x22
    movk	fp,	#2,	lsl #16
    add	x28,	x28,	#16
    ldr	w2,	[x21]

    add	w21,	w7,	#3
    ldr	x10,	[sp, fp]

    lsl	w5,	w2,	#24
    movz	fp,	#524
    lsl	w2,	w8,	#2
    movk	fp,	#2,	lsl #16
    lsl	w24,	w21,	#2
    add	w8,	w6,	#1
    add	x9,	x10,	x2
    lsl	w2,	w6,	#2
    ldr	w14,	[x9]

    ldr	x10,	[sp, fp]

    lsl	w16,	w14,	#16
    movz	fp,	#524
    add	w0,	w16,	w5
    movk	fp,	#2,	lsl #16
    mov	x16,	x2
    add	w5,	w7,	#2
    add	x16,	sp,	x16
    lsl	w13,	w5,	#2
    add	x16,	x16,	#16
    add	x9,	x10,	x13
    ldr	w12,	[x9]

    add	w9,	w7,	#4
    lsl	w13,	w12,	#8
    ldr	x12,	[sp, fp]

    add	w4,	w0,	w13
    movz	fp,	#524
    add	w25,	w9,	#2
    lsl	w2,	w9,	#2
    add	x22,	x12,	x24
    movk	fp,	#2,	lsl #16
    add	w12,	w9,	#1
    ldr	w5,	[x22]

    lsl	w12,	w12,	#2
    add	w5,	w4,	w5
    str	w5,	[x28]

    ldr	x17,	[sp, fp]

    movz	fp,	#524
    add	x0,	x17,	x2
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x0]

    lsl	w0,	w25,	#2
    ldr	x17,	[sp, fp]

    lsl	w7,	w4,	#24
    movz	fp,	#524
    add	x13,	x17,	x12
    movk	fp,	#2,	lsl #16
    add	w12,	w9,	#4
    ldr	w15,	[x13]

    lsl	w22,	w12,	#2
    add	w13,	w12,	#2
    ldr	x14,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#524
    add	x2,	x14,	x0
    add	w17,	w17,	w7
    movk	fp,	#2,	lsl #16
    add	w0,	w9,	#3
    ldr	w7,	[x2]

    ldr	x24,	[sp, fp]

    lsl	w14,	w7,	#8
    lsl	w4,	w0,	#2
    movz	fp,	#524
    add	w10,	w17,	w14
    movk	fp,	#2,	lsl #16
    add	x2,	x24,	x4
    add	w14,	w12,	#1
    lsl	w17,	w8,	#2
    mov	x4,	x17
    ldr	w7,	[x2]

    add	x4,	sp,	x4
    add	w7,	w10,	w7
    lsl	w10,	w14,	#2
    add	x4,	x4,	#16
    str	w7,	[x16]

    lsl	w7,	w13,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#524
    add	x21,	x5,	x22
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x21]

    ldr	x25,	[sp, fp]

    lsl	w5,	w24,	#24
    movz	fp,	#524
    add	x16,	x25,	x10
    add	w24,	w12,	#3
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x16]

    ldr	x9,	[sp, fp]

    lsl	w2,	w0,	#16
    movz	fp,	#524
    add	x15,	x9,	x7
    add	w5,	w2,	w5
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x15]

    ldr	x13,	[sp, fp]

    lsl	w22,	w17,	#8
    movz	fp,	#524
    add	w17,	w5,	w22
    movk	fp,	#2,	lsl #16
    lsl	w5,	w24,	#2
    add	x2,	x13,	x5
    ldr	w7,	[x2]

    add	w2,	w8,	#1
    add	w0,	w17,	w7
    add	w8,	w12,	#4
    str	w0,	[x4]

    lsl	w9,	w2,	#2
    add	w22,	w8,	#4
    add	w10,	w8,	#3
    add	w12,	w8,	#2
    ldr	x15,	[sp, fp]

    lsl	w0,	w8,	#2
    add	w2,	w2,	#1
    mov	x4,	x9
    movz	fp,	#524
    add	x16,	x15,	x0
    add	x4,	sp,	x4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x16]

    add	x4,	x4,	#16
    add	w16,	w8,	#1
    lsl	w15,	w5,	#24
    lsl	w13,	w16,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#524
    add	x17,	x16,	x13
    movk	fp,	#2,	lsl #16
    lsl	w13,	w10,	#2
    ldr	w24,	[x17]

    ldr	x16,	[sp, fp]

    lsl	w25,	w24,	#16
    movz	fp,	#524
    lsl	w24,	w12,	#2
    add	w5,	w25,	w15
    movk	fp,	#2,	lsl #16
    add	x14,	x16,	x24
    ldr	w21,	[x14]

    ldr	x19,	[sp, fp]

    lsl	w0,	w21,	#8
    add	x12,	x19,	x13
    add	w5,	w5,	w0
    ldr	w14,	[x12]

    mov	w12,	w2
    add	w9,	w5,	w14
    str	w9,	[x4]

    b	main_70

main_215:
    mov	w17,	w22
    mov	w4,	w12

main_217:
    lsl	w8,	w4,	#2
    lsl	w13,	w17,	#2
    movz	fp,	#524
    add	w28,	w4,	#1
    mov	x7,	x8
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    ldr	x5,	[sp, fp]

    movz	fp,	#524
    add	x14,	x5,	x13
    add	x7,	x7,	#16
    movk	fp,	#2,	lsl #16
    add	w5,	w17,	#1
    ldr	w21,	[x14]

    lsl	w24,	w21,	#24
    lsl	w0,	w5,	#2
    add	w21,	w17,	#4
    ldr	x5,	[sp, fp]

    movz	fp,	#524
    add	x8,	x5,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w17,	#2
    ldr	w12,	[x8]

    lsl	w15,	w0,	#2
    ldr	x5,	[sp, fp]

    lsl	w14,	w12,	#16
    movz	fp,	#524
    add	x2,	x5,	x15
    movk	fp,	#2,	lsl #16
    add	w14,	w14,	w24
    add	w5,	w17,	#3
    ldr	w9,	[x2]

    lsl	w22,	w5,	#2
    lsl	w10,	w9,	#8
    ldr	x9,	[sp, fp]

    add	w10,	w14,	w10
    add	x8,	x9,	x22
    ldr	w15,	[x8]

    add	w22,	w10,	w15
    str	w22,	[x7]

    cmp	w28,	#16
    bge	main_241

main_216:
    mov	w17,	w21
    mov	w4,	w28
    b	main_217

main_241:
    mov	w14,	w28
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#564
    lsl	w24,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x16,	x24
    add	x16,	sp,	x16
    ldr	w25,	[sp, fp]

    movz	fp,	#564
    sub	w28,	w25,	#3
    add	x16,	x16,	#16
    movk	fp,	#2,	lsl #16
    lsl	w4,	w28,	#2
    mov	x2,	x4
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w6,	[x2]

    ldr	w4,	[sp, fp]

    movz	fp,	#564
    sub	w7,	w4,	#8
    movk	fp,	#2,	lsl #16
    lsl	w9,	w7,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w5,	[sp, fp]

    add	w8,	w10,	w6
    movz	fp,	#564
    sub	w22,	w5,	#14
    movk	fp,	#2,	lsl #16
    sub	w13,	w6,	w8
    lsl	w0,	w22,	#2
    mov	x28,	x0
    add	w17,	w13,	w10
    add	x28,	sp,	x28
    sub	w8,	w17,	w8
    add	x28,	x28,	#16
    ldr	w4,	[x28]

    ldr	w6,	[sp, fp]

    add	w0,	w4,	w8
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    sub	w5,	w8,	w0
    add	w10,	w5,	w4
    sub	w25,	w10,	w0
    sub	w0,	w6,	#16
    lsl	w4,	w0,	#2
    mov	x2,	x4
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w6,	[x2]

    add	w4,	w6,	w25
    sub	w10,	w25,	w4
    add	w12,	w10,	w6
    sub	w15,	w12,	w4
    asr	w0,	w15,	#31
    lsl	w9,	w15,	#1
    lsr	w2,	w0,	#31
    add	w4,	w15,	w2
    asr	w12,	w4,	#1
    lsl	w13,	w12,	#1
    sub	w6,	w15,	w13
    add	w7,	w9,	w6
    str	w7,	[x16]

    ldr	w16,	[sp, fp]

    movz	fp,	#564
    add	w8,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w11
    movz	fp,	#516
    mov	w2,	w3
    mov	w17,	w20
    mov	w9,	w1
    mov	w0,	w27
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]

    mov	w2,	w6
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    str	w17,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w13,	#60289
    movz	w4,	#49414
    movz	w28,	#31129
    movz	w24,	#65535
    movz	fp,	#500
    movk	w2,	#36635,	lsl #16
    movk	w13,	#28377,	lsl #16
    movk	w4,	#51810,	lsl #16
    movk	w28,	#23170,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w17,	w2
    mov	w15,	w28
    mov	w16,	w24
    ldr	w14,	[sp, fp]

    mov	w2,	w4
    cmp	w14,	#20
    bge	main_296

main_285:
    movz	fp,	#512
    mov	w9,	w16
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#512
    add	w6,	w22,	w19
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#504
    sub	w4,	w9,	w12
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w9,	w21,	w4
    add	w14,	w9,	w6
    sub	w10,	w6,	w14
    add	w28,	w10,	w9
    mov	w10,	w15
    sub	w9,	w28,	w14
    sub	w4,	w9,	w28
    add	w7,	w4,	w14
    sub	w7,	w7,	w28
    mov	w6,	w7
    b	main_416

main_296:
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#512
    add	w6,	w26,	w22
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#520
    sub	w7,	w21,	w6
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#504
    add	w24,	w7,	w8
    movk	fp,	#2,	lsl #16
    sub	w10,	w24,	w6
    ldr	w6,	[sp, fp]

    movz	fp,	#504
    add	w4,	w6,	w10
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w6,	w10,	w4
    mov	w10,	w13
    add	w6,	w6,	w26
    sub	w7,	w6,	w4
    mov	w14,	w7
    b	main_413

main_307:
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    cmp	w21,	#60
    bge	main_327

main_309:
    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#504
    add	w28,	w10,	w6
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#504
    add	w7,	w9,	w21
    movk	fp,	#2,	lsl #16
    add	w25,	w7,	w28
    ldr	w19,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    sub	w14,	w28,	w25
    ldr	w22,	[sp, fp]

    add	w28,	w14,	w7
    add	w14,	w19,	w22
    sub	w4,	w28,	w25
    sub	w7,	w4,	w28
    add	w10,	w7,	w25
    sub	w6,	w10,	w28
    mov	w10,	w17
    add	w24,	w14,	w6
    sub	w28,	w6,	w24
    add	w7,	w28,	w14
    sub	w4,	w7,	w24
    sub	w4,	w4,	w7
    add	w9,	w4,	w24
    sub	w7,	w9,	w7
    mov	w14,	w7
    b	main_413

main_327:
    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#512
    add	w4,	w21,	w9
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#520
    sub	w7,	w10,	w4
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#504
    add	w28,	w7,	w22
    movk	fp,	#2,	lsl #16
    sub	w7,	w28,	w4
    ldr	w19,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    add	w4,	w19,	w7
    ldr	w12,	[sp, fp]

    sub	w10,	w7,	w4
    add	w7,	w10,	w12
    mov	w10,	w2
    sub	w7,	w7,	w4
    mov	w14,	w7

main_413:
    mov	w6,	w14

main_416:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#516
    lsl	w9,	w4,	#5
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#516
    asr	w14,	w14,	#31
    movk	fp,	#2,	lsl #16
    lsr	w25,	w14,	#27
    ldr	w21,	[sp, fp]

    movz	fp,	#516
    add	w7,	w21,	w25
    movk	fp,	#2,	lsl #16
    asr	w14,	w7,	#5
    ldr	w26,	[sp, fp]

    movz	fp,	#500
    lsl	w25,	w14,	#5
    movk	fp,	#2,	lsl #16
    sub	w7,	w26,	w25
    ldr	w22,	[sp, fp]

    movz	fp,	#512
    lsl	w4,	w22,	#2
    movk	fp,	#2,	lsl #16
    mov	x14,	x4
    add	w28,	w9,	w7
    add	x14,	sp,	x14
    add	w25,	w28,	w0
    add	x14,	x14,	#16
    add	w6,	w25,	w6
    ldr	w9,	[x14]

    ldr	w19,	[sp, fp]

    movz	fp,	#512
    add	w10,	w6,	w10
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w10,	w10,	w9
    movz	fp,	#512
    asr	w4,	w21,	#31
    lsl	w9,	w19,	#30
    movk	fp,	#2,	lsl #16
    lsr	w6,	w4,	#2
    ldr	w19,	[sp, fp]

    movz	fp,	#512
    add	w14,	w19,	w6
    movk	fp,	#2,	lsl #16
    asr	w6,	w14,	#30
    ldr	w21,	[sp, fp]

    movz	fp,	#500
    lsl	w4,	w6,	#30
    movk	fp,	#2,	lsl #16
    sub	w7,	w21,	w4
    ldr	w21,	[sp, fp]

    add	w25,	w21,	#1
    add	w14,	w9,	w7
    cmp	w25,	#20
    bge	main_364

main_336:
    movz	fp,	#516
    mov	w4,	w16
    mov	w9,	w15
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#516
    add	w13,	w14,	w0
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#520
    sub	w0,	w4,	w2
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    add	w2,	w12,	w0
    add	w4,	w2,	w13
    sub	w16,	w13,	w4
    add	w13,	w16,	w2
    sub	w16,	w13,	w4
    sub	w17,	w16,	w13
    add	w22,	w17,	w4
    sub	w21,	w22,	w13
    mov	w24,	w21
    b	main_347

main_364:
    cmp	w25,	#40
    bge	main_378

main_366:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#516
    add	w16,	w14,	w19
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#520
    sub	w6,	w6,	w16
    movk	fp,	#2,	lsl #16
    add	w0,	w6,	w14
    sub	w0,	w0,	w16
    ldr	w16,	[sp, fp]

    movz	fp,	#520
    add	w2,	w16,	w0
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    sub	w6,	w0,	w2
    mov	w0,	w13
    add	w15,	w6,	w22
    sub	w16,	w15,	w2
    b	main_375

main_378:
    cmp	w25,	#60
    bge	main_401

main_380:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#516
    add	w21,	w14,	w21
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#520
    add	w16,	w4,	w8
    movk	fp,	#2,	lsl #16
    add	w9,	w16,	w21
    ldr	w22,	[sp, fp]

    add	w13,	w22,	w14
    sub	w0,	w21,	w9
    add	w6,	w0,	w16
    sub	w16,	w6,	w9
    sub	w2,	w16,	w6
    add	w0,	w2,	w9
    mov	w2,	w17
    sub	w4,	w0,	w6
    add	w0,	w13,	w4
    sub	w9,	w4,	w0
    add	w9,	w9,	w13
    sub	w15,	w9,	w0
    sub	w22,	w15,	w9
    add	w0,	w22,	w0
    sub	w15,	w0,	w9
    mov	w21,	w15
    b	main_398

main_401:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#516
    add	w16,	w14,	w5
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#520
    sub	w6,	w17,	w16
    movk	fp,	#2,	lsl #16
    add	w9,	w6,	w14
    ldr	w0,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    sub	w4,	w9,	w16
    ldr	w12,	[sp, fp]

    add	w16,	w0,	w4
    sub	w9,	w4,	w16
    add	w0,	w9,	w12
    sub	w16,	w0,	w16
    mov	w21,	w16

main_398:
    mov	w16,	w21
    mov	w0,	w2

main_375:
    mov	w24,	w16
    mov	w9,	w0

main_347:
    lsl	w16,	w10,	#5
    asr	w2,	w10,	#31
    lsl	w21,	w25,	#2
    movz	fp,	#504
    lsr	w4,	w2,	#27
    mov	x13,	x21
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    add	w7,	w10,	w4
    add	x13,	x13,	#16
    asr	w4,	w7,	#5
    ldr	w0,	[x13]

    lsl	w6,	w4,	#5
    ldr	w19,	[sp, fp]

    sub	w6,	w10,	w6
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    add	w6,	w6,	w19
    ldr	w8,	[sp, fp]

    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    add	w12,	w6,	w16
    add	w4,	w12,	w24
    ldr	w24,	[sp, fp]

    movz	fp,	#516
    asr	w15,	w24,	#31
    add	w9,	w4,	w9
    movk	fp,	#2,	lsl #16
    lsr	w22,	w15,	#2
    ldr	w2,	[sp, fp]

    add	w17,	w9,	w0
    movz	fp,	#516
    add	w2,	w2,	w22
    lsl	w9,	w8,	#30
    movk	fp,	#2,	lsl #16
    asr	w4,	w2,	#30
    ldr	w6,	[sp, fp]

    lsl	w12,	w4,	#30
    add	w4,	w25,	#1
    sub	w13,	w6,	w12
    add	w24,	w9,	w13
    cmp	w4,	#80
    blt	main_276

main_433:
    add	w17,	w17,	w11
    add	w4,	w10,	w3
    add	w6,	w24,	w20
    add	w15,	w14,	w1
    movz	fp,	#520
    add	w22,	w18,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w8,	w7,	w27
    cmp	w22,	w23
    blt	main_62

main_441:
    movz	fp,	#580
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#588
    str	w17,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#492
    str	w4,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#484
    str	w6,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#568
    str	w15,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w8,	[x23]


main_442:
    cmp	w0,	#5
    bge	main_455

main_445:
    lsl	w17,	w0,	#2
    movz	fp,	#356
    lsl	w12,	w0,	#2
    mov	x24,	x17
    movk	fp,	#2,	lsl #16
    add	w0,	w0,	#1
    mov	x11,	x12
    add	x24,	sp,	x24
    add	x11,	sp,	x11
    add	x24,	x24,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x24]

    add	x11,	x11,	fp
    ldr	w16,	[x11]

    add	w6,	w16,	w17
    sub	w1,	w17,	w6
    add	w17,	w1,	w16
    sub	w22,	w17,	w6
    str	w22,	[x24]

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

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w17
    mov	w3,	w4
    mov	w20,	w6
    mov	w1,	w15
    mov	w27,	w8
    mov	w18,	w22
    b	main_63

main_276:
    mov	w16,	w17
    movz	fp,	#516
    mov	w28,	w10
    mov	w13,	w14
    mov	w8,	w4
    mov	w12,	w24
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#500
    mov	w0,	w10
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#612
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


