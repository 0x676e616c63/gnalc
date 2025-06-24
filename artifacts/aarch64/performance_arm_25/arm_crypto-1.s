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
    
    movz	w1,	#0
    movz	w2,	#0
    add	x0,	sp,	#336
    movk	w2,	#2,	lsl #16
    bl	memset
    movz	w23,	#0
    movz	w25,	#0
    movz	w24,	#0
    movz	fp,	#336
    movz	w26,	#0
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
    mov	w26,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	w6,	#0
    movz	w5,	#0
    movz	w4,	#0
    movz	fp,	#356
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#492
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

    cmp	w26,	#0
    ble	main_460

main_18:
    add	x17,	sp,	#336
    movz	fp,	#444
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x27,	x20
    add	x8,	x20,	#12
    add	x16,	x20,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x20,	#4
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#484
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    mov	w0,	w19
    str	x25,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#532
    movk	fp,	#2,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w26
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
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
    movz	w21,	#128
    movz	fp,	#484
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
    lsl	w25,	w8,	#2
    movz	fp,	#444
    add	w22,	w8,	#1
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x24,	x28,	x25
    movk	fp,	#2,	lsl #16
    movz	w25,	#0
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    add	w1,	w8,	#3
    ldr	x0,	[sp, fp]

    add	w25,	w8,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    str	w23,	[x22]

    add	w23,	w8,	#4
    ldr	x1,	[sp, fp]

    movz	fp,	#548
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w17,	#8961
    movz	w21,	#0
    movz	w26,	#43913
    movz	w5,	#56574
    movz	w7,	#21622
    movz	w18,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w7,	#4146,	lsl #16
    movk	w18,	#50130,	lsl #16
    mov	w11,	w17
    mov	w3,	w26
    mov	w0,	w5
    mov	w22,	w18
    mov	w26,	w7
    mov	w18,	w21

main_63:
    movz	w16,	#0
    mov	w21,	w18
    mov	w12,	w16

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w16,	w12,	#2
    lsl	w6,	w21,	#2
    movz	fp,	#444
    add	w1,	w21,	#1
    add	w13,	w21,	#2
    add	w12,	w12,	#1
    mov	x15,	x16
    movk	fp,	#2,	lsl #16
    lsl	w17,	w1,	#2
    add	x15,	sp,	x15
    lsl	w8,	w13,	#2
    ldr	x28,	[sp, fp]

    add	w13,	w21,	#4
    movz	fp,	#444
    add	x15,	x15,	#16
    add	x4,	x28,	x6
    movk	fp,	#2,	lsl #16
    add	w25,	w13,	#1
    ldr	w7,	[x4]

    ldr	x10,	[sp, fp]

    lsl	w20,	w7,	#24
    movz	fp,	#444
    add	x2,	x10,	x17
    movk	fp,	#2,	lsl #16
    lsl	w17,	w25,	#2
    ldr	w6,	[x2]

    ldr	x24,	[sp, fp]

    lsl	w7,	w6,	#16
    movz	fp,	#444
    add	w9,	w7,	w20
    movk	fp,	#2,	lsl #16
    add	x20,	x24,	x8
    ldr	w1,	[x20]

    ldr	x28,	[sp, fp]

    lsl	w2,	w1,	#8
    movz	fp,	#444
    add	w4,	w9,	w2
    movk	fp,	#2,	lsl #16
    add	w9,	w21,	#3
    lsl	w14,	w9,	#2
    lsl	w9,	w12,	#2
    add	x10,	x28,	x14
    mov	x7,	x9
    add	w14,	w13,	#4
    lsl	w28,	w13,	#2
    add	x7,	sp,	x7
    ldr	w20,	[x10]

    add	w8,	w4,	w20
    add	x7,	x7,	#16
    str	w8,	[x15]

    ldr	x9,	[sp, fp]

    movz	fp,	#444
    add	x24,	x9,	x28
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x24]

    lsl	w21,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#444
    add	x1,	x1,	x17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x1]

    ldr	x5,	[sp, fp]

    lsl	w9,	w6,	#16
    movz	fp,	#444
    add	w16,	w9,	w21
    movk	fp,	#2,	lsl #16
    add	w21,	w13,	#2
    lsl	w9,	w21,	#2
    add	x1,	x5,	x9
    add	w9,	w13,	#3
    ldr	w4,	[x1]

    ldr	x10,	[sp, fp]

    lsl	w6,	w4,	#8
    movz	fp,	#444
    lsl	w4,	w14,	#2
    add	w17,	w16,	w6
    movk	fp,	#2,	lsl #16
    lsl	w16,	w9,	#2
    add	x10,	x10,	x16
    add	w16,	w14,	#4
    ldr	w21,	[x10]

    add	w5,	w17,	w21
    str	w5,	[x7]

    ldr	x1,	[sp, fp]

    add	w7,	w12,	#1
    movz	fp,	#444
    add	x2,	x1,	x4
    movk	fp,	#2,	lsl #16
    lsl	w9,	w7,	#2
    ldr	w8,	[x2]

    mov	x6,	x9
    ldr	x17,	[sp, fp]

    lsl	w2,	w8,	#24
    add	w9,	w14,	#1
    add	x6,	sp,	x6
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w13,	w9,	#2
    add	x6,	x6,	#16
    add	x10,	x17,	x13
    add	w17,	w14,	#2
    ldr	w13,	[x10]

    lsl	w28,	w17,	#2
    ldr	x19,	[sp, fp]

    lsl	w15,	w13,	#16
    movz	fp,	#444
    add	x21,	x19,	x28
    movk	fp,	#2,	lsl #16
    add	w13,	w15,	w2
    add	w2,	w14,	#3
    ldr	w25,	[x21]

    ldr	x4,	[sp, fp]

    lsl	w1,	w25,	#8
    movz	fp,	#444
    add	w5,	w13,	w1
    movk	fp,	#2,	lsl #16
    add	w13,	w7,	#1
    lsl	w1,	w2,	#2
    add	w7,	w16,	#1
    add	x21,	x4,	x1
    lsl	w28,	w13,	#2
    lsl	w12,	w7,	#2
    mov	x8,	x28
    ldr	w2,	[x21]

    lsl	w28,	w16,	#2
    add	x8,	sp,	x8
    add	w9,	w5,	w2
    add	x8,	x8,	#16
    str	w9,	[x6]

    add	w6,	w13,	#1
    ldr	x9,	[sp, fp]

    movz	fp,	#444
    add	x24,	x9,	x28
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x24]

    add	w24,	w16,	#3
    ldr	x5,	[sp, fp]

    lsl	w1,	w1,	#24
    movz	fp,	#444
    add	x10,	x5,	x12
    movk	fp,	#2,	lsl #16
    add	w5,	w16,	#2
    ldr	w15,	[x10]

    lsl	w9,	w5,	#2
    ldr	x14,	[sp, fp]

    lsl	w21,	w15,	#16
    movz	fp,	#444
    add	x7,	x14,	x9
    movk	fp,	#2,	lsl #16
    add	w1,	w21,	w1
    add	w9,	w16,	#4
    ldr	w12,	[x7]

    ldr	x14,	[sp, fp]

    lsl	w15,	w12,	#8
    movz	fp,	#444
    add	w12,	w9,	#1
    add	w4,	w1,	w15
    movk	fp,	#2,	lsl #16
    lsl	w1,	w24,	#2
    lsl	w12,	w12,	#2
    add	x25,	x14,	x1
    ldr	w2,	[x25]

    add	w25,	w9,	#2
    add	w5,	w4,	w2
    lsl	w2,	w6,	#2
    mov	x16,	x2
    str	w5,	[x8]

    lsl	w28,	w25,	#2
    lsl	w2,	w9,	#2
    add	x16,	sp,	x16
    add	w8,	w6,	#1
    ldr	x17,	[sp, fp]

    movz	fp,	#444
    add	x1,	x17,	x2
    add	x16,	x16,	#16
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x1]

    ldr	x17,	[sp, fp]

    lsl	w7,	w4,	#24
    movz	fp,	#444
    add	x13,	x17,	x12
    movk	fp,	#2,	lsl #16
    add	w12,	w9,	#4
    ldr	w15,	[x13]

    lsl	w21,	w12,	#2
    ldr	x13,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#444
    add	x1,	x13,	x28
    movk	fp,	#2,	lsl #16
    add	w15,	w17,	w7
    add	w13,	w12,	#2
    lsl	w17,	w8,	#2
    ldr	w7,	[x1]

    mov	x5,	x17
    ldr	x24,	[sp, fp]

    add	w1,	w9,	#3
    lsl	w14,	w7,	#8
    add	x5,	sp,	x5
    movz	fp,	#444
    lsl	w4,	w1,	#2
    add	w10,	w15,	w14
    add	x5,	x5,	#16
    movk	fp,	#2,	lsl #16
    add	x2,	x24,	x4
    add	w14,	w12,	#1
    ldr	w7,	[x2]

    add	w7,	w10,	w7
    lsl	w10,	w14,	#2
    str	w7,	[x16]

    lsl	w7,	w13,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#444
    add	x20,	x4,	x21
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x20]

    ldr	x25,	[sp, fp]

    lsl	w2,	w24,	#24
    movz	fp,	#444
    add	x16,	x25,	x10
    add	w24,	w12,	#3
    movk	fp,	#2,	lsl #16
    add	w10,	w12,	#4
    ldr	w1,	[x16]

    ldr	x9,	[sp, fp]

    lsl	w4,	w1,	#16
    add	w16,	w10,	#1
    movz	fp,	#444
    add	x15,	x9,	x7
    add	w4,	w4,	w2
    movk	fp,	#2,	lsl #16
    add	w9,	w10,	#3
    lsl	w2,	w24,	#2
    ldr	w17,	[x15]

    ldr	x13,	[sp, fp]

    lsl	w21,	w17,	#8
    movz	fp,	#444
    add	x1,	x13,	x2
    add	w17,	w4,	w21
    movk	fp,	#2,	lsl #16
    lsl	w13,	w16,	#2
    lsl	w2,	w10,	#2
    ldr	w7,	[x1]

    add	w1,	w8,	#1
    add	w28,	w17,	w7
    lsl	w8,	w1,	#2
    str	w28,	[x5]

    mov	x4,	x8
    ldr	x15,	[sp, fp]

    add	x4,	sp,	x4
    movz	fp,	#444
    add	x17,	x15,	x2
    movk	fp,	#2,	lsl #16
    add	x4,	x4,	#16
    ldr	w5,	[x17]

    ldr	x16,	[sp, fp]

    lsl	w15,	w5,	#24
    movz	fp,	#444
    add	x17,	x16,	x13
    movk	fp,	#2,	lsl #16
    add	w13,	w10,	#2
    ldr	w24,	[x17]

    ldr	x16,	[sp, fp]

    lsl	w25,	w24,	#16
    movz	fp,	#444
    lsl	w24,	w13,	#2
    add	w2,	w25,	w15
    movk	fp,	#2,	lsl #16
    lsl	w13,	w9,	#2
    add	x14,	x16,	x24
    ldr	w21,	[x14]

    ldr	x20,	[sp, fp]

    lsl	w5,	w21,	#8
    add	x12,	x20,	x13
    add	w21,	w10,	#4
    add	w5,	w2,	w5
    add	w2,	w1,	#1
    ldr	w14,	[x12]

    mov	w12,	w2
    add	w8,	w5,	w14
    str	w8,	[x4]

    b	main_70

main_215:
    mov	w17,	w21
    mov	w5,	w12

main_217:
    lsl	w8,	w5,	#2
    lsl	w13,	w17,	#2
    movz	fp,	#444
    add	w2,	w17,	#1
    add	w1,	w17,	#2
    add	w25,	w5,	#1
    mov	x7,	x8
    movk	fp,	#2,	lsl #16
    lsl	w28,	w2,	#2
    add	x7,	sp,	x7
    lsl	w16,	w1,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#444
    add	x14,	x4,	x13
    add	x7,	x7,	#16
    movk	fp,	#2,	lsl #16
    ldr	w20,	[x14]

    ldr	x2,	[sp, fp]

    lsl	w21,	w20,	#24
    movz	fp,	#444
    add	x8,	x2,	x28
    add	w20,	w17,	#4
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x8]

    ldr	x4,	[sp, fp]

    lsl	w14,	w12,	#16
    movz	fp,	#444
    add	x2,	x4,	x16
    add	w14,	w14,	w21
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x2]

    add	w2,	w17,	#3
    lsl	w10,	w9,	#8
    ldr	x9,	[sp, fp]

    add	w10,	w14,	w10
    lsl	w21,	w2,	#2
    add	x8,	x9,	x21
    ldr	w15,	[x8]

    add	w21,	w10,	w15
    str	w21,	[x7]

    cmp	w25,	#16
    bge	main_241

main_216:
    mov	w17,	w20
    mov	w5,	w25
    b	main_217

main_241:
    mov	w14,	w25
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#476
    lsl	w21,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x16,	x21
    add	x16,	sp,	x16
    ldr	w25,	[sp, fp]

    movz	fp,	#476
    sub	w25,	w25,	#3
    add	x16,	x16,	#16
    movk	fp,	#2,	lsl #16
    lsl	w5,	w25,	#2
    mov	x2,	x5
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w6,	[x2]

    ldr	w4,	[sp, fp]

    movz	fp,	#476
    sub	w7,	w4,	#8
    movk	fp,	#2,	lsl #16
    lsl	w9,	w7,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w5,	[sp, fp]

    add	w8,	w10,	w6
    movz	fp,	#476
    sub	w21,	w5,	#14
    movk	fp,	#2,	lsl #16
    sub	w13,	w6,	w8
    lsl	w28,	w21,	#2
    mov	x25,	x28
    add	w17,	w13,	w10
    add	x25,	sp,	x25
    sub	w8,	w17,	w8
    add	x25,	x25,	#16
    ldr	w4,	[x25]

    ldr	w6,	[sp, fp]

    add	w28,	w4,	w8
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    sub	w1,	w8,	w28
    add	w9,	w1,	w4
    sub	w1,	w6,	#16
    sub	w24,	w9,	w28
    lsl	w4,	w1,	#2
    mov	x2,	x4
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w6,	[x2]

    add	w4,	w6,	w24
    sub	w10,	w24,	w4
    add	w12,	w10,	w6
    sub	w17,	w12,	w4
    asr	w1,	w17,	#31
    lsl	w10,	w17,	#1
    lsr	w2,	w1,	#31
    add	w4,	w17,	w2
    asr	w12,	w4,	#1
    lsl	w13,	w12,	#1
    sub	w6,	w17,	w13
    add	w7,	w10,	w6
    str	w7,	[x16]

    ldr	w16,	[sp, fp]

    movz	fp,	#476
    add	w8,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w11
    movz	fp,	#436
    mov	w2,	w3
    mov	w16,	w0
    mov	w10,	w26
    mov	w1,	w22
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    mov	w4,	w6
    str	w25,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w14,	#60289
    movz	w6,	#49414
    movz	w24,	#65535
    movz	fp,	#420
    movk	w2,	#36635,	lsl #16
    movk	w14,	#28377,	lsl #16
    movk	w6,	#51810,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w17,	w2
    mov	w9,	w14
    mov	w16,	w24
    ldr	w15,	[sp, fp]

    mov	w2,	w6
    movz	w6,	#31129
    movk	w6,	#23170,	lsl #16
    mov	w10,	w6
    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#432
    mov	w14,	w16
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    add	w6,	w21,	w19
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    sub	w14,	w14,	w13
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    add	w20,	w20,	w14
    add	w24,	w20,	w6
    sub	w13,	w6,	w24
    add	w25,	w13,	w20
    sub	w15,	w25,	w24
    sub	w13,	w15,	w25
    add	w15,	w13,	w24
    sub	w13,	w15,	w25
    mov	w15,	w10
    mov	w7,	w13
    b	main_416

main_296:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#432
    add	w7,	w27,	w24
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#440
    sub	w15,	w20,	w7
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#424
    add	w24,	w15,	w6
    movk	fp,	#2,	lsl #16
    mov	w15,	w9
    sub	w28,	w24,	w7
    ldr	w6,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w6,	w6,	w28
    ldr	w27,	[sp, fp]

    sub	w14,	w28,	w6
    add	w14,	w14,	w27
    sub	w13,	w14,	w6
    mov	w20,	w13
    b	main_413

main_307:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    cmp	w20,	#60
    bge	main_327

main_309:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w25,	w13,	w6
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    add	w24,	w12,	w20
    movk	fp,	#2,	lsl #16
    add	w14,	w24,	w25
    ldr	w19,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w20,	w25,	w14
    ldr	w21,	[sp, fp]

    add	w28,	w19,	w21
    add	w6,	w20,	w24
    sub	w13,	w6,	w14
    sub	w15,	w13,	w6
    add	w24,	w15,	w14
    sub	w7,	w24,	w6
    add	w24,	w28,	w7
    sub	w25,	w7,	w24
    add	w15,	w25,	w28
    sub	w7,	w15,	w24
    sub	w13,	w7,	w15
    add	w20,	w13,	w24
    sub	w13,	w20,	w15
    mov	w15,	w17
    mov	w20,	w13
    b	main_413

main_327:
    movz	fp,	#432
    mov	w15,	w2
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    add	w6,	w20,	w12
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w13,	w6
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#424
    add	w28,	w7,	w21
    movk	fp,	#2,	lsl #16
    sub	w6,	w28,	w6
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w13,	w19,	w6
    ldr	w12,	[sp, fp]

    sub	w20,	w6,	w13
    add	w7,	w20,	w12
    sub	w13,	w7,	w13
    mov	w20,	w13

main_413:
    mov	w7,	w20

main_416:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#436
    lsl	w14,	w4,	#5
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#436
    asr	w25,	w12,	#31
    movk	fp,	#2,	lsl #16
    lsr	w6,	w25,	#27
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    add	w13,	w20,	w6
    movk	fp,	#2,	lsl #16
    asr	w25,	w13,	#5
    ldr	w27,	[sp, fp]

    movz	fp,	#420
    lsl	w28,	w25,	#5
    movk	fp,	#2,	lsl #16
    sub	w13,	w27,	w28
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w25,	w14,	w13
    lsl	w14,	w21,	#2
    mov	x24,	x14
    add	w25,	w25,	w1
    add	x24,	sp,	x24
    add	w7,	w25,	w7
    add	x24,	x24,	#16
    add	w15,	w7,	w15
    ldr	w24,	[x24]

    ldr	w19,	[sp, fp]

    movz	fp,	#432
    lsl	w1,	w19,	#30
    add	w13,	w15,	w24
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    asr	w24,	w20,	#31
    movk	fp,	#2,	lsl #16
    lsr	w14,	w24,	#2
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    add	w20,	w19,	w14
    movk	fp,	#2,	lsl #16
    asr	w20,	w20,	#30
    lsl	w25,	w20,	#30
    ldr	w20,	[sp, fp]

    movz	fp,	#420
    sub	w15,	w20,	w25
    movk	fp,	#2,	lsl #16
    add	w20,	w1,	w15
    ldr	w19,	[sp, fp]

    add	w25,	w19,	#1
    cmp	w25,	#20
    bge	main_364

main_336:
    movz	fp,	#436
    mov	w5,	w16
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#436
    add	w15,	w20,	w1
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#440
    sub	w1,	w5,	w2
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    add	w2,	w12,	w1
    add	w5,	w2,	w15
    sub	w15,	w15,	w5
    add	w14,	w15,	w2
    sub	w15,	w14,	w5
    sub	w16,	w15,	w14
    add	w21,	w16,	w5
    sub	w17,	w21,	w14
    mov	w14,	w10
    mov	w24,	w17
    b	main_347

main_364:
    cmp	w25,	#40
    bge	main_378

main_366:
    movz	fp,	#436
    mov	w28,	w9
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#436
    add	w15,	w20,	w17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w6,	w15
    movk	fp,	#2,	lsl #16
    add	w1,	w7,	w20
    sub	w1,	w1,	w15
    ldr	w15,	[sp, fp]

    movz	fp,	#440
    add	w5,	w15,	w1
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    sub	w6,	w1,	w5
    add	w14,	w6,	w21
    sub	w15,	w14,	w5
    b	main_375

main_378:
    cmp	w25,	#60
    bge	main_401

main_380:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#436
    add	w16,	w20,	w19
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#440
    add	w15,	w2,	w8
    movk	fp,	#2,	lsl #16
    mov	w2,	w17
    add	w9,	w15,	w16
    ldr	w21,	[sp, fp]

    add	w10,	w21,	w20
    sub	w1,	w16,	w9
    add	w6,	w1,	w15
    sub	w16,	w6,	w9
    sub	w5,	w16,	w6
    add	w1,	w5,	w9
    sub	w5,	w1,	w6
    add	w1,	w10,	w5
    sub	w9,	w5,	w1
    add	w10,	w9,	w10
    sub	w14,	w10,	w1
    sub	w21,	w14,	w10
    add	w1,	w21,	w1
    sub	w14,	w1,	w10
    mov	w16,	w14
    b	main_398

main_401:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#436
    add	w15,	w20,	w5
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#440
    sub	w6,	w16,	w15
    movk	fp,	#2,	lsl #16
    add	w9,	w6,	w20
    ldr	w28,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w1,	w9,	w15
    ldr	w10,	[sp, fp]

    add	w15,	w28,	w1
    sub	w9,	w1,	w15
    add	w1,	w9,	w10
    sub	w15,	w1,	w15
    mov	w16,	w15

main_398:
    mov	w15,	w16
    mov	w28,	w2

main_375:
    mov	w24,	w15
    mov	w14,	w28

main_347:
    lsl	w15,	w13,	#5
    asr	w2,	w13,	#31
    lsl	w21,	w25,	#2
    movz	fp,	#424
    lsr	w5,	w2,	#27
    mov	x9,	x21
    movk	fp,	#2,	lsl #16
    add	x9,	sp,	x9
    add	w7,	w13,	w5
    add	x9,	x9,	#16
    asr	w5,	w7,	#5
    ldr	w1,	[x9]

    lsl	w6,	w5,	#5
    ldr	w17,	[sp, fp]

    sub	w6,	w13,	w6
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w6,	w6,	w17
    ldr	w8,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w9,	w6,	w15
    add	w6,	w9,	w24
    ldr	w24,	[sp, fp]

    movz	fp,	#436
    add	w9,	w6,	w14
    movk	fp,	#2,	lsl #16
    asr	w14,	w24,	#31
    add	w6,	w25,	#1
    add	w16,	w9,	w1
    lsr	w24,	w14,	#2
    ldr	w1,	[sp, fp]

    lsl	w9,	w8,	#30
    movz	fp,	#436
    add	w5,	w1,	w24
    movk	fp,	#2,	lsl #16
    asr	w5,	w5,	#30
    ldr	w7,	[sp, fp]

    lsl	w10,	w5,	#30
    sub	w12,	w7,	w10
    add	w14,	w9,	w12
    cmp	w6,	#80
    blt	main_276

main_433:
    add	w16,	w16,	w11
    add	w5,	w13,	w3
    add	w15,	w14,	w0
    add	w9,	w20,	w26
    movz	fp,	#440
    add	w18,	w18,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w28,	w7,	w22
    cmp	w18,	w23
    blt	main_62

main_441:
    movz	fp,	#532
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#540
    str	w16,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#524
    str	w5,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#516
    str	w15,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#412
    str	w9,	[x21]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    str	w28,	[x22]


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

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w16
    mov	w3,	w5
    mov	w0,	w15
    mov	w26,	w9
    mov	w22,	w28
    b	main_63

main_276:
    mov	w15,	w16
    movz	fp,	#436
    mov	w1,	w13
    mov	w8,	w6
    mov	w12,	w14
    movk	fp,	#2,	lsl #16
    mov	w13,	w20
    str	w15,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#420
    mov	w1,	w10
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#492
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


