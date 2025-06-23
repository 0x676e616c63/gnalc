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
    movz	w26,	#0
    movz	fp,	#336
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
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#564
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
    movz	fp,	#516
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x26,	x20
    add	x8,	x20,	#12
    add	x16,	x20,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x20,	#4
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#556
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#532
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#628
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#500
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#500
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#500
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
    movz	fp,	#556
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w1
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


main_46:
    asr	w24,	w16,	#31
    lsr	w26,	w24,	#26
    add	w27,	w16,	w26
    asr	w0,	w27,	#6
    lsl	w2,	w0,	#6
    sub	w26,	w16,	w2
    cmp	w26,	#60
    beq	main_53

main_50:
    lsl	w3,	w16,	#2
    movz	fp,	#516
    movz	w0,	#0
    add	w12,	w16,	#1
    movk	fp,	#2,	lsl #16
    mov	w16,	w12
    ldr	x5,	[sp, fp]

    add	x6,	x5,	x3
    str	w0,	[x6]

    b	main_46

main_53:
    lsl	w2,	w16,	#2
    movz	fp,	#516
    add	w21,	w16,	#1
    movz	w26,	#0
    movz	w22,	#125
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#516
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w21,	#2
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#516
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    ldr	x0,	[sp, fp]

    add	w26,	w16,	#2
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x21,	x0,	x2
    movz	w2,	#0
    add	w0,	w16,	#3
    str	w22,	[x21]

    lsl	w26,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#548
    add	x24,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    add	w24,	w16,	#4
    bl	memset
    movz	w17,	#8961
    movz	w27,	#43913
    movz	w5,	#56574
    movz	w6,	#21622
    movk	w17,	#26437,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w11,	w17
    mov	w3,	w27
    mov	w26,	w5
    mov	w22,	w6
    movz	w17,	#57840
    movz	w27,	#0
    movk	w17,	#50130,	lsl #16
    mov	w1,	w27
    mov	w18,	w17

main_63:
    movz	w17,	#0
    mov	w27,	w1
    mov	w13,	w17

main_70:
    cmp	w13,	#14
    bge	main_215

main_74:
    lsl	w17,	w13,	#2
    lsl	w7,	w27,	#2
    movz	fp,	#516
    add	w0,	w27,	#1
    add	w14,	w27,	#2
    add	w13,	w13,	#1
    mov	x17,	x17
    movk	fp,	#2,	lsl #16
    lsl	w19,	w0,	#2
    add	x17,	sp,	x17
    lsl	w9,	w14,	#2
    ldr	x2,	[sp, fp]

    add	w14,	w27,	#4
    movz	fp,	#516
    add	x17,	x17,	#16
    add	x6,	x2,	x7
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x6]

    ldr	x12,	[sp, fp]

    lsl	w16,	w8,	#24
    movz	fp,	#516
    add	x4,	x12,	x19
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x4]

    ldr	x23,	[sp, fp]

    lsl	w8,	w7,	#16
    movz	fp,	#516
    add	x20,	x23,	x9
    add	w10,	w8,	w16
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x20]

    add	w20,	w14,	#2
    ldr	x0,	[sp, fp]

    lsl	w5,	w2,	#8
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    add	w6,	w10,	w5
    add	w10,	w27,	#3
    lsl	w15,	w10,	#2
    lsl	w10,	w13,	#2
    add	x12,	x0,	x15
    mov	x8,	x10
    add	w15,	w14,	#4
    lsl	w0,	w14,	#2
    add	x8,	sp,	x8
    ldr	w19,	[x12]

    add	w5,	w15,	#3
    add	w9,	w6,	w19
    add	x8,	x8,	#16
    str	w9,	[x17]

    ldr	x12,	[sp, fp]

    movz	fp,	#516
    add	x28,	x12,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w14,	#1
    ldr	w4,	[x28]

    lsl	w17,	w0,	#2
    lsl	w21,	w4,	#24
    ldr	x4,	[sp, fp]

    movz	fp,	#516
    add	x2,	x4,	x17
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x2]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#516
    add	w9,	w13,	#1
    add	w17,	w10,	w21
    movk	fp,	#2,	lsl #16
    lsl	w10,	w20,	#2
    add	x0,	x7,	x10
    add	w10,	w14,	#3
    ldr	w6,	[x0]

    lsl	w19,	w10,	#2
    ldr	x12,	[sp, fp]

    lsl	w7,	w6,	#8
    lsl	w10,	w9,	#2
    movz	fp,	#516
    add	x12,	x12,	x19
    lsl	w6,	w15,	#2
    add	w20,	w17,	w7
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x12]

    add	w7,	w20,	w21
    add	w20,	w15,	#2
    str	w7,	[x8]

    ldr	x0,	[sp, fp]

    mov	x7,	x10
    movz	fp,	#516
    add	x4,	x0,	x6
    add	w10,	w15,	#1
    add	x7,	sp,	x7
    movk	fp,	#2,	lsl #16
    lsl	w0,	w20,	#2
    ldr	w8,	[x4]

    lsl	w14,	w10,	#2
    add	x7,	x7,	#16
    ldr	x19,	[sp, fp]

    lsl	w4,	w8,	#24
    movz	fp,	#516
    add	x12,	x19,	x14
    add	w8,	w15,	#4
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x12]

    lsl	w27,	w8,	#2
    ldr	x20,	[sp, fp]

    lsl	w16,	w14,	#16
    movz	fp,	#516
    add	x21,	x20,	x0
    movk	fp,	#2,	lsl #16
    add	w16,	w16,	w4
    ldr	w0,	[x21]

    add	w21,	w9,	#1
    lsl	w2,	w0,	#8
    lsl	w0,	w5,	#2
    add	w6,	w16,	w2
    ldr	x5,	[sp, fp]

    add	w9,	w21,	#1
    lsl	w2,	w21,	#2
    movz	fp,	#516
    add	x20,	x5,	x0
    mov	x28,	x2
    movk	fp,	#2,	lsl #16
    add	x28,	sp,	x28
    ldr	w4,	[x20]

    add	w10,	w6,	w4
    add	x28,	x28,	#16
    str	w10,	[x7]

    add	w7,	w8,	#2
    ldr	x10,	[sp, fp]

    movz	fp,	#516
    add	x19,	x10,	x27
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	#1
    lsl	w14,	w7,	#2
    ldr	w4,	[x19]

    add	w19,	w8,	#3
    ldr	x12,	[sp, fp]

    lsl	w6,	w4,	#24
    movz	fp,	#516
    lsl	w4,	w10,	#2
    movk	fp,	#2,	lsl #16
    add	x12,	x12,	x4
    lsl	w4,	w9,	#2
    add	w9,	w9,	#1
    ldr	w15,	[x12]

    ldr	x12,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#516
    add	x10,	x12,	x14
    add	w0,	w17,	w6
    movk	fp,	#2,	lsl #16
    mov	x17,	x4
    ldr	w13,	[x10]

    add	x17,	sp,	x17
    add	w10,	w8,	#4
    lsl	w14,	w13,	#8
    add	x17,	x17,	#16
    add	w6,	w0,	w14
    lsl	w4,	w10,	#2
    add	w13,	w10,	#1
    ldr	x14,	[sp, fp]

    lsl	w0,	w19,	#2
    movz	fp,	#516
    lsl	w13,	w13,	#2
    add	x20,	x14,	x0
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x20]

    add	w7,	w6,	w5
    str	w7,	[x28]

    ldr	x20,	[sp, fp]

    movz	fp,	#516
    add	x0,	x20,	x4
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x0]

    add	w0,	w10,	#2
    ldr	x19,	[sp, fp]

    lsl	w7,	w6,	#24
    movz	fp,	#516
    add	x14,	x19,	x13
    movk	fp,	#2,	lsl #16
    lsl	w0,	w0,	#2
    lsl	w19,	w9,	#2
    add	w13,	w10,	#4
    ldr	w16,	[x14]

    ldr	x15,	[sp, fp]

    lsl	w20,	w16,	#16
    add	w27,	w13,	#3
    lsl	w21,	w13,	#2
    add	w14,	w13,	#2
    movz	fp,	#516
    add	x2,	x15,	x0
    add	w20,	w20,	w7
    movk	fp,	#2,	lsl #16
    add	w0,	w10,	#3
    ldr	w8,	[x2]

    lsl	w6,	w0,	#2
    ldr	x25,	[sp, fp]

    lsl	w15,	w8,	#8
    movz	fp,	#516
    add	x4,	x25,	x6
    lsl	w8,	w14,	#2
    add	w12,	w20,	w15
    movk	fp,	#2,	lsl #16
    mov	x6,	x19
    add	w15,	w13,	#1
    ldr	w7,	[x4]

    add	x6,	sp,	x6
    add	w7,	w12,	w7
    lsl	w12,	w15,	#2
    add	x6,	x6,	#16
    str	w7,	[x17]

    ldr	x7,	[sp, fp]

    movz	fp,	#516
    add	x20,	x7,	x21
    movk	fp,	#2,	lsl #16
    ldr	w28,	[x20]

    lsl	w5,	w28,	#24
    ldr	x28,	[sp, fp]

    movz	fp,	#516
    add	x17,	x28,	x12
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x17]

    ldr	x12,	[sp, fp]

    lsl	w4,	w0,	#16
    movz	fp,	#516
    add	x16,	x12,	x8
    add	w7,	w4,	w5
    movk	fp,	#2,	lsl #16
    lsl	w5,	w27,	#2
    add	w4,	w13,	#4
    ldr	w20,	[x16]

    ldr	x14,	[sp, fp]

    lsl	w21,	w20,	#8
    movz	fp,	#516
    add	x2,	x14,	x5
    add	w20,	w7,	w21
    movk	fp,	#2,	lsl #16
    add	w14,	w4,	#2
    ldr	w10,	[x2]

    add	w0,	w20,	w10
    add	w10,	w9,	#1
    str	w0,	[x6]

    lsl	w9,	w10,	#2
    ldr	x16,	[sp, fp]

    lsl	w0,	w4,	#2
    mov	x8,	x9
    movz	fp,	#516
    add	x8,	sp,	x8
    add	x17,	x16,	x0
    movk	fp,	#2,	lsl #16
    add	x8,	x8,	#16
    ldr	w7,	[x17]

    add	w17,	w4,	#1
    lsl	w16,	w7,	#24
    lsl	w12,	w17,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#516
    add	x20,	x17,	x12
    movk	fp,	#2,	lsl #16
    add	w12,	w4,	#3
    ldr	w27,	[x20]

    lsl	w20,	w14,	#2
    ldr	x17,	[sp, fp]

    lsl	w0,	w27,	#16
    lsl	w14,	w12,	#2
    movz	fp,	#516
    add	x15,	x17,	x20
    add	w27,	w4,	#4
    add	w2,	w0,	w16
    movk	fp,	#2,	lsl #16
    ldr	w20,	[x15]

    lsl	w0,	w20,	#8
    ldr	x20,	[sp, fp]

    add	w6,	w2,	w0
    add	x13,	x20,	x14
    ldr	w15,	[x13]

    add	w9,	w6,	w15
    add	w6,	w10,	#1
    mov	w13,	w6
    str	w9,	[x8]

    b	main_70

main_215:
    mov	w20,	w27
    mov	w6,	w13

main_217:
    lsl	w9,	w6,	#2
    lsl	w14,	w20,	#2
    movz	fp,	#516
    add	w5,	w20,	#1
    add	w28,	w6,	#1
    mov	x8,	x9
    movk	fp,	#2,	lsl #16
    add	x8,	sp,	x8
    lsl	w0,	w5,	#2
    ldr	x7,	[sp, fp]

    add	x8,	x8,	#16
    movz	fp,	#516
    add	x15,	x7,	x14
    movk	fp,	#2,	lsl #16
    ldr	w19,	[x15]

    ldr	x5,	[sp, fp]

    lsl	w27,	w19,	#24
    movz	fp,	#516
    add	x10,	x5,	x0
    movk	fp,	#2,	lsl #16
    add	w5,	w20,	#3
    add	w0,	w20,	#2
    ldr	w13,	[x10]

    lsl	w21,	w5,	#2
    ldr	x7,	[sp, fp]

    lsl	w16,	w0,	#2
    lsl	w15,	w13,	#16
    movz	fp,	#516
    add	x4,	x7,	x16
    add	w15,	w15,	w27
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x4]

    lsl	w12,	w10,	#8
    ldr	x10,	[sp, fp]

    add	w12,	w15,	w12
    add	x10,	x10,	x21
    ldr	w16,	[x10]

    add	w21,	w12,	w16
    str	w21,	[x8]

    add	w21,	w20,	#4
    cmp	w28,	#16
    bge	main_241

main_216:
    mov	w20,	w21
    mov	w6,	w28
    b	main_217

main_241:
    mov	w14,	w28
    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#612
    lsl	w21,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x21
    add	x17,	sp,	x17
    ldr	w25,	[sp, fp]

    movz	fp,	#612
    sub	w0,	w25,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w6,	w0,	#2
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w4,	[sp, fp]

    movz	fp,	#612
    sub	w8,	w4,	#8
    movk	fp,	#2,	lsl #16
    lsl	w10,	w8,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w12,	[x9]

    ldr	w5,	[sp, fp]

    add	w9,	w12,	w7
    movz	fp,	#612
    sub	w27,	w5,	#14
    movk	fp,	#2,	lsl #16
    sub	w14,	w7,	w9
    lsl	w2,	w27,	#2
    mov	x28,	x2
    add	w19,	w14,	w12
    add	x28,	sp,	x28
    sub	w9,	w19,	w9
    add	x28,	x28,	#16
    ldr	w6,	[x28]

    add	w0,	w6,	w9
    sub	w5,	w9,	w0
    add	w12,	w5,	w6
    ldr	w6,	[sp, fp]

    movz	fp,	#612
    sub	w27,	w12,	w0
    movk	fp,	#2,	lsl #16
    sub	w0,	w6,	#16
    lsl	w6,	w0,	#2
    mov	x4,	x6
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w7,	[x4]

    add	w6,	w7,	w27
    sub	w12,	w27,	w6
    add	w13,	w12,	w7
    sub	w19,	w13,	w6
    asr	w0,	w19,	#31
    lsl	w10,	w19,	#1
    lsr	w4,	w0,	#31
    add	w6,	w19,	w4
    asr	w13,	w6,	#1
    lsl	w15,	w13,	#1
    sub	w7,	w19,	w15
    add	w8,	w10,	w7
    str	w8,	[x17]

    ldr	w16,	[sp, fp]

    movz	fp,	#612
    add	w9,	w16,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w9
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w28,	w11
    movz	fp,	#508
    mov	w20,	w26
    mov	w12,	w22
    mov	w2,	w18
    movz	w8,	#0
    movk	fp,	#2,	lsl #16
    mov	w5,	w8
    str	w28,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]


main_277:
    movz	w5,	#48348
    movz	w14,	#60289
    movz	w21,	#65535
    movz	fp,	#492
    movk	w5,	#36635,	lsl #16
    movk	w14,	#28377,	lsl #16
    movk	w21,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w20,	w5
    mov	w10,	w14
    mov	w17,	w21
    ldr	w16,	[sp, fp]

    movz	w5,	#49414
    movk	w5,	#51810,	lsl #16
    mov	w4,	w5
    movz	w5,	#31129
    movk	w5,	#23170,	lsl #16
    mov	w12,	w5
    cmp	w16,	#20
    bge	main_296

main_285:
    movz	fp,	#504
    mov	w5,	w17
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#504
    add	w7,	w25,	w19
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#496
    sub	w0,	w5,	w15
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w15,	w21,	w0
    add	w16,	w15,	w7
    sub	w8,	w7,	w16
    add	w28,	w8,	w15
    sub	w14,	w28,	w16
    sub	w0,	w14,	w28
    add	w14,	w0,	w16
    sub	w14,	w14,	w28
    mov	w8,	w14
    mov	w14,	w12
    b	main_416

main_296:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#504
    add	w8,	w28,	w23
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#512
    sub	w7,	w21,	w8
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#496
    add	w21,	w7,	w9
    movk	fp,	#2,	lsl #16
    sub	w15,	w21,	w8
    ldr	w8,	[sp, fp]

    movz	fp,	#496
    add	w5,	w8,	w15
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    sub	w0,	w15,	w5
    add	w0,	w0,	w28
    sub	w14,	w0,	w5
    mov	w21,	w14
    mov	w14,	w10
    b	main_413

main_307:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    cmp	w23,	#60
    bge	main_327

main_309:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#496
    add	w28,	w15,	w8
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#496
    add	w14,	w13,	w21
    movk	fp,	#2,	lsl #16
    add	w15,	w14,	w28
    ldr	w19,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    sub	w16,	w28,	w15
    ldr	w23,	[sp, fp]

    add	w21,	w19,	w23
    add	w5,	w16,	w14
    sub	w0,	w5,	w15
    sub	w14,	w0,	w5
    add	w16,	w14,	w15
    sub	w8,	w16,	w5
    add	w7,	w21,	w8
    sub	w28,	w8,	w7
    add	w15,	w28,	w21
    sub	w5,	w15,	w7
    sub	w0,	w5,	w15
    add	w14,	w0,	w7
    sub	w14,	w14,	w15
    mov	w21,	w14
    mov	w14,	w20
    b	main_413

main_327:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#504
    add	w5,	w21,	w13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#512
    sub	w7,	w15,	w5
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#496
    add	w0,	w7,	w23
    movk	fp,	#2,	lsl #16
    sub	w7,	w0,	w5
    ldr	w19,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w7
    ldr	w14,	[sp, fp]

    sub	w15,	w7,	w0
    add	w8,	w15,	w14
    sub	w14,	w8,	w0
    mov	w21,	w14
    mov	w14,	w4

main_413:
    mov	w8,	w21

main_416:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#508
    lsl	w15,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#508
    asr	w21,	w16,	#31
    movk	fp,	#2,	lsl #16
    lsr	w28,	w21,	#27
    ldr	w23,	[sp, fp]

    movz	fp,	#508
    add	w7,	w23,	w28
    movk	fp,	#2,	lsl #16
    asr	w21,	w7,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#492
    lsl	w0,	w21,	#5
    movk	fp,	#2,	lsl #16
    sub	w7,	w28,	w0
    ldr	w23,	[sp, fp]

    movz	fp,	#504
    lsl	w0,	w23,	#2
    movk	fp,	#2,	lsl #16
    mov	x16,	x0
    add	w28,	w15,	w7
    add	x16,	sp,	x16
    add	w28,	w28,	w2
    add	x16,	x16,	#16
    add	w8,	w28,	w8
    ldr	w16,	[x16]

    ldr	w19,	[sp, fp]

    movz	fp,	#504
    lsl	w15,	w19,	#30
    add	w14,	w8,	w14
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w14,	w14,	w16
    movz	fp,	#504
    asr	w5,	w21,	#31
    movk	fp,	#2,	lsl #16
    lsr	w8,	w5,	#2
    ldr	w19,	[sp, fp]

    movz	fp,	#504
    add	w16,	w19,	w8
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    asr	w8,	w16,	#30
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    lsl	w7,	w8,	#30
    sub	w8,	w21,	w7
    ldr	w21,	[sp, fp]

    add	w28,	w21,	#1
    add	w16,	w15,	w8
    cmp	w28,	#20
    bge	main_364

main_336:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#508
    add	w7,	w16,	w0
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#512
    sub	w0,	w17,	w4
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w4,	w15,	w0
    add	w8,	w4,	w7
    sub	w17,	w7,	w8
    add	w15,	w17,	w4
    sub	w17,	w15,	w8
    sub	w19,	w17,	w15
    add	w27,	w19,	w8
    sub	w21,	w27,	w15
    mov	w15,	w12
    mov	w0,	w21
    b	main_347

main_364:
    cmp	w28,	#40
    bge	main_378

main_366:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#508
    add	w19,	w16,	w20
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#512
    sub	w7,	w7,	w19
    movk	fp,	#2,	lsl #16
    add	w0,	w7,	w16
    sub	w0,	w0,	w19
    ldr	w19,	[sp, fp]

    movz	fp,	#512
    add	w4,	w19,	w0
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    sub	w8,	w0,	w4
    add	w15,	w8,	w23
    sub	w19,	w15,	w4
    mov	w4,	w10
    b	main_375

main_378:
    cmp	w28,	#60
    bge	main_401

main_380:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#508
    add	w19,	w16,	w21
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#512
    add	w17,	w5,	w9
    movk	fp,	#2,	lsl #16
    add	w12,	w17,	w19
    ldr	w23,	[sp, fp]

    sub	w2,	w19,	w12
    add	w8,	w2,	w17
    sub	w19,	w8,	w12
    sub	w4,	w19,	w8
    add	w0,	w4,	w12
    add	w12,	w23,	w16
    sub	w5,	w0,	w8
    add	w0,	w12,	w5
    sub	w10,	w5,	w0
    mov	w5,	w20
    add	w10,	w10,	w12
    sub	w15,	w10,	w0
    sub	w27,	w15,	w10
    add	w2,	w27,	w0
    sub	w17,	w2,	w10
    mov	w21,	w17
    b	main_398

main_401:
    movz	fp,	#508
    mov	w5,	w4
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#508
    add	w19,	w16,	w7
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#512
    sub	w8,	w20,	w19
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	w16
    ldr	w2,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    sub	w0,	w10,	w19
    ldr	w12,	[sp, fp]

    add	w17,	w2,	w0
    sub	w10,	w0,	w17
    add	w2,	w10,	w12
    sub	w19,	w2,	w17
    mov	w21,	w19

main_398:
    mov	w19,	w21
    mov	w4,	w5

main_375:
    mov	w0,	w19
    mov	w15,	w4

main_347:
    lsl	w19,	w14,	#5
    asr	w5,	w14,	#31
    lsl	w21,	w28,	#2
    movz	fp,	#496
    lsr	w8,	w5,	#27
    mov	x17,	x21
    movk	fp,	#2,	lsl #16
    add	x17,	sp,	x17
    add	w10,	w14,	w8
    add	x17,	x17,	#16
    asr	w7,	w10,	#5
    ldr	w2,	[x17]

    lsl	w10,	w7,	#5
    ldr	w23,	[sp, fp]

    sub	w8,	w14,	w10
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	w23
    ldr	w9,	[sp, fp]

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    add	w12,	w10,	w19
    ldr	w27,	[sp, fp]

    movz	fp,	#508
    asr	w17,	w27,	#31
    add	w5,	w12,	w0
    movk	fp,	#2,	lsl #16
    lsr	w27,	w17,	#2
    ldr	w4,	[sp, fp]

    add	w10,	w5,	w15
    movz	fp,	#508
    add	w4,	w4,	w27
    movk	fp,	#2,	lsl #16
    add	w20,	w10,	w2
    ldr	w8,	[sp, fp]

    asr	w7,	w4,	#30
    lsl	w10,	w9,	#30
    lsl	w12,	w7,	#30
    sub	w13,	w8,	w12
    add	w8,	w28,	#1
    add	w0,	w10,	w13
    cmp	w8,	#80
    blt	main_276

main_433:
    add	w21,	w20,	w11
    add	w4,	w14,	w3
    add	w10,	w0,	w26
    movz	fp,	#512
    add	w2,	w1,	#64
    add	w0,	w16,	w22
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    add	w19,	w9,	w18
    cmp	w2,	w24
    blt	main_62

main_441:
    movz	fp,	#532
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#540
    str	w21,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#628
    str	w4,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#620
    str	w10,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#524
    str	w0,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w19,	[x23]


main_442:
    cmp	w28,	#5
    bge	main_455

main_445:
    lsl	w16,	w28,	#2
    movz	fp,	#356
    lsl	w11,	w28,	#2
    mov	x22,	x16
    movk	fp,	#2,	lsl #16
    add	w28,	w28,	#1
    mov	x10,	x11
    add	x22,	sp,	x22
    add	x10,	sp,	x10
    add	x22,	x22,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x22]

    add	x10,	x10,	fp
    ldr	w15,	[x10]

    add	w5,	w15,	w16
    sub	w0,	w16,	w5
    add	w16,	w0,	w15
    sub	w20,	w16,	w5
    str	w20,	[x22]

    b	main_442

main_455:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w4,	w26,	#1
    cmp	w4,	#0
    ble	main_460

main_27:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w21
    mov	w3,	w4
    mov	w26,	w10
    mov	w22,	w0
    mov	w18,	w19
    mov	w1,	w2
    b	main_63

main_276:
    mov	w19,	w20
    movz	fp,	#508
    mov	w6,	w14
    mov	w15,	w16
    mov	w10,	w8
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	w6,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#492
    mov	w2,	w13
    movk	fp,	#2,	lsl #16
    mov	w13,	w0
    str	w10,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#564
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


