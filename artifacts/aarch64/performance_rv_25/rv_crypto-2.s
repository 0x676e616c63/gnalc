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
    movz	w4,	#0
    movz	w6,	#0
    movz	fp,	#356
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#620
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

    movz	fp,	#612
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#604
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#516
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
    movz	fp,	#612
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

    movz	fp,	#604
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
    movz	w21,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w24,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w21,	#50130,	lsl #16
    mov	w9,	w17
    mov	w12,	w24
    mov	w1,	w3
    mov	w27,	w21
    movz	w3,	#21622
    movk	w3,	#4146,	lsl #16
    mov	w5,	w3

main_63:
    movz	w18,	#0
    mov	w22,	w23
    mov	w14,	w18

main_70:
    cmp	w14,	#14
    bge	main_215

main_74:
    lsl	w18,	w14,	#2
    lsl	w4,	w22,	#2
    movz	fp,	#436
    add	w0,	w22,	#1
    add	w7,	w22,	#3
    mov	x17,	x18
    movk	fp,	#2,	lsl #16
    add	x17,	sp,	x17
    lsl	w20,	w0,	#2
    ldr	x28,	[sp, fp]

    add	x17,	x17,	#16
    movz	fp,	#436
    add	x3,	x28,	x4
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x3]

    ldr	x11,	[sp, fp]

    lsl	w13,	w6,	#24
    movz	fp,	#436
    add	x2,	x11,	x20
    movk	fp,	#2,	lsl #16
    lsl	w11,	w7,	#2
    ldr	w4,	[x2]

    ldr	x25,	[sp, fp]

    lsl	w6,	w4,	#16
    movz	fp,	#436
    add	w10,	w6,	w13
    movk	fp,	#2,	lsl #16
    add	w13,	w22,	#2
    lsl	w6,	w13,	#2
    add	x21,	x25,	x6
    ldr	w0,	[x21]

    ldr	x28,	[sp, fp]

    lsl	w2,	w0,	#8
    movz	fp,	#436
    add	x8,	x28,	x11
    add	w3,	w10,	w2
    movk	fp,	#2,	lsl #16
    add	w11,	w14,	#1
    ldr	w15,	[x8]

    add	w8,	w3,	w15
    lsl	w7,	w11,	#2
    add	w15,	w22,	#4
    mov	x4,	x7
    str	w8,	[x17]

    add	x4,	sp,	x4
    add	w13,	w15,	#4
    lsl	w28,	w15,	#2
    add	w17,	w15,	#2
    ldr	x8,	[sp, fp]

    add	x4,	x4,	#16
    movz	fp,	#436
    add	x24,	x8,	x28
    movk	fp,	#2,	lsl #16
    lsl	w10,	w17,	#2
    add	w8,	w13,	#1
    add	w28,	w15,	#1
    ldr	w0,	[x24]

    lsl	w22,	w0,	#24
    lsl	w14,	w28,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x0,	x0,	x14
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x0]

    ldr	x2,	[sp, fp]

    lsl	w7,	w3,	#16
    movz	fp,	#436
    add	x0,	x2,	x10
    add	w14,	w7,	w22
    movk	fp,	#2,	lsl #16
    add	w10,	w15,	#3
    ldr	w3,	[x0]

    lsl	w15,	w8,	#2
    lsl	w6,	w3,	#8
    lsl	w17,	w10,	#2
    add	w20,	w14,	w6
    ldr	x10,	[sp, fp]

    lsl	w6,	w13,	#2
    movz	fp,	#436
    add	x14,	x10,	x17
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x14]

    add	w2,	w20,	w22
    add	w20,	w13,	#2
    str	w2,	[x4]

    lsl	w28,	w20,	#2
    ldr	x0,	[sp, fp]

    add	w4,	w11,	#1
    movz	fp,	#436
    add	x2,	x0,	x6
    movk	fp,	#2,	lsl #16
    add	w6,	w13,	#3
    lsl	w10,	w4,	#2
    ldr	w7,	[x2]

    mov	x3,	x10
    ldr	x18,	[sp, fp]

    lsl	w2,	w7,	#24
    add	x3,	sp,	x3
    movz	fp,	#436
    add	x10,	x18,	x15
    movk	fp,	#2,	lsl #16
    add	w18,	w13,	#4
    add	x3,	x3,	#16
    ldr	w15,	[x10]

    ldr	x20,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#436
    add	x22,	x20,	x28
    add	w15,	w16,	w2
    movk	fp,	#2,	lsl #16
    ldr	w28,	[x22]

    ldr	x7,	[sp, fp]

    lsl	w0,	w28,	#8
    movz	fp,	#436
    add	w2,	w15,	w0
    movk	fp,	#2,	lsl #16
    add	w15,	w4,	#1
    lsl	w0,	w6,	#2
    add	w4,	w18,	#1
    add	x17,	x7,	x0
    lsl	w28,	w15,	#2
    mov	x7,	x28
    ldr	w6,	[x17]

    lsl	w28,	w18,	#2
    add	x7,	sp,	x7
    add	w8,	w2,	w6
    add	x7,	x7,	#16
    str	w8,	[x3]

    ldr	x10,	[sp, fp]

    movz	fp,	#436
    add	x24,	x10,	x28
    movk	fp,	#2,	lsl #16
    lsl	w10,	w4,	#2
    ldr	w0,	[x24]

    add	w24,	w18,	#3
    ldr	x4,	[sp, fp]

    lsl	w0,	w0,	#24
    movz	fp,	#436
    add	x8,	x4,	x10
    movk	fp,	#2,	lsl #16
    add	w4,	w18,	#2
    ldr	w13,	[x8]

    lsl	w10,	w4,	#2
    ldr	x14,	[sp, fp]

    lsl	w16,	w13,	#16
    movz	fp,	#436
    add	x6,	x14,	x10
    movk	fp,	#2,	lsl #16
    add	w0,	w16,	w0
    ldr	w13,	[x6]

    ldr	x14,	[sp, fp]

    lsl	w17,	w13,	#8
    movz	fp,	#436
    add	w3,	w0,	w17
    movk	fp,	#2,	lsl #16
    lsl	w0,	w24,	#2
    add	x28,	x14,	x0
    ldr	w2,	[x28]

    add	w2,	w3,	w2
    add	w3,	w15,	#1
    str	w2,	[x7]

    add	w22,	w3,	#1
    ldr	x20,	[sp, fp]

    lsl	w2,	w3,	#2
    add	w7,	w18,	#4
    movz	fp,	#436
    mov	x18,	x2
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    add	w28,	w7,	#2
    add	w13,	w7,	#1
    lsl	w2,	w7,	#2
    add	x18,	x18,	#16
    lsl	w28,	w28,	#2
    lsl	w13,	w13,	#2
    add	x0,	x20,	x2
    ldr	w4,	[x0]

    ldr	x20,	[sp, fp]

    lsl	w6,	w4,	#24
    movz	fp,	#436
    add	x14,	x20,	x13
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    ldr	x14,	[sp, fp]

    lsl	w20,	w17,	#16
    movz	fp,	#436
    add	x0,	x14,	x28
    add	w17,	w20,	w6
    movk	fp,	#2,	lsl #16
    lsl	w14,	w22,	#2
    add	w28,	w7,	#4
    ldr	w4,	[x0]

    ldr	x25,	[sp, fp]

    add	w0,	w7,	#3
    add	w8,	w28,	#1
    lsl	w20,	w28,	#2
    lsl	w13,	w4,	#8
    movz	fp,	#436
    add	w7,	w28,	#2
    lsl	w4,	w0,	#2
    add	w11,	w17,	w13
    movk	fp,	#2,	lsl #16
    add	x2,	x25,	x4
    lsl	w4,	w8,	#2
    ldr	w6,	[x2]

    add	w6,	w11,	w6
    mov	x11,	x14
    add	x11,	sp,	x11
    str	w6,	[x18]

    ldr	x3,	[sp, fp]

    add	x11,	x11,	#16
    movz	fp,	#436
    add	x16,	x3,	x20
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x16]

    ldr	x25,	[sp, fp]

    lsl	w2,	w21,	#24
    movz	fp,	#436
    add	x13,	x25,	x4
    add	w21,	w28,	#3
    movk	fp,	#2,	lsl #16
    lsl	w4,	w7,	#2
    ldr	w0,	[x13]

    ldr	x7,	[sp, fp]

    lsl	w3,	w0,	#16
    movz	fp,	#436
    add	x10,	x7,	x4
    add	w3,	w3,	w2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w21,	#2
    ldr	w16,	[x10]

    ldr	x7,	[sp, fp]

    lsl	w17,	w16,	#8
    movz	fp,	#436
    add	x0,	x7,	x2
    add	w20,	w3,	w17
    movk	fp,	#2,	lsl #16
    add	w3,	w28,	#4
    ldr	w6,	[x0]

    add	w24,	w20,	w6
    add	w8,	w3,	#3
    add	w10,	w3,	#2
    add	w17,	w3,	#1
    lsl	w0,	w3,	#2
    str	w24,	[x11]

    ldr	x15,	[sp, fp]

    add	w24,	w22,	#1
    lsl	w13,	w17,	#2
    movz	fp,	#436
    add	x14,	x15,	x0
    movk	fp,	#2,	lsl #16
    lsl	w6,	w24,	#2
    mov	x4,	x6
    ldr	w2,	[x14]

    add	x4,	sp,	x4
    ldr	x16,	[sp, fp]

    lsl	w15,	w2,	#24
    movz	fp,	#436
    add	x18,	x16,	x13
    add	x4,	x4,	#16
    movk	fp,	#2,	lsl #16
    lsl	w13,	w8,	#2
    ldr	w22,	[x18]

    ldr	x16,	[sp, fp]

    lsl	w28,	w22,	#16
    movz	fp,	#436
    lsl	w22,	w10,	#2
    add	w2,	w28,	w15
    movk	fp,	#2,	lsl #16
    add	x11,	x16,	x22
    add	w22,	w3,	#4
    ldr	w16,	[x11]

    ldr	x20,	[sp, fp]

    lsl	w0,	w16,	#8
    add	x10,	x20,	x13
    add	w2,	w2,	w0
    ldr	w14,	[x10]

    add	w7,	w2,	w14
    add	w2,	w24,	#1
    mov	w14,	w2
    str	w7,	[x4]

    b	main_70

main_215:
    mov	w20,	w22
    mov	w2,	w14

main_217:
    lsl	w7,	w2,	#2
    lsl	w14,	w20,	#2
    movz	fp,	#436
    add	w3,	w20,	#1
    add	w0,	w20,	#2
    add	w24,	w2,	#1
    mov	x6,	x7
    movk	fp,	#2,	lsl #16
    lsl	w28,	w3,	#2
    add	x6,	sp,	x6
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x16,	x4,	x14
    add	x6,	x6,	#16
    movk	fp,	#2,	lsl #16
    lsl	w14,	w0,	#2
    ldr	w21,	[x16]

    ldr	x3,	[sp, fp]

    lsl	w22,	w21,	#24
    movz	fp,	#436
    add	x4,	x3,	x28
    add	w21,	w20,	#4
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x4]

    ldr	x4,	[sp, fp]

    lsl	w13,	w10,	#16
    movz	fp,	#436
    add	x3,	x4,	x14
    add	w13,	w13,	w22
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x3]

    add	w3,	w20,	#3
    lsl	w11,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w11,	w13,	w11
    lsl	w22,	w3,	#2
    add	x4,	x8,	x22
    ldr	w14,	[x4]

    add	w22,	w11,	w14
    str	w22,	[x6]

    cmp	w24,	#16
    bge	main_241

main_216:
    mov	w20,	w21
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
    ldr	w10,	[sp, fp]

    cmp	w10,	#80
    bge	main_275

main_245:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#492
    lsl	w21,	w11,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x21
    add	x18,	sp,	x18
    ldr	w25,	[sp, fp]

    movz	fp,	#492
    sub	w24,	w25,	#3
    add	x18,	x18,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w24,	#2
    mov	x28,	x2
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    ldr	w3,	[x28]

    ldr	w4,	[sp, fp]

    movz	fp,	#492
    sub	w6,	w4,	#8
    movk	fp,	#2,	lsl #16
    lsl	w10,	w6,	#2
    mov	x7,	x10
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w11,	[x7]

    ldr	w4,	[sp, fp]

    add	w7,	w11,	w3
    movz	fp,	#492
    sub	w22,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w14,	w3,	w7
    lsl	w28,	w22,	#2
    mov	x24,	x28
    add	w20,	w14,	w11
    add	x24,	sp,	x24
    sub	w8,	w20,	w7
    add	x24,	x24,	#16
    ldr	w0,	[x24]

    ldr	w6,	[sp, fp]

    add	w28,	w0,	w8
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    sub	w2,	w8,	w28
    add	w7,	w2,	w0
    sub	w0,	w6,	#16
    sub	w22,	w7,	w28
    lsl	w3,	w0,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w4,	[x2]

    add	w3,	w4,	w22
    sub	w11,	w22,	w3
    add	w13,	w11,	w4
    sub	w13,	w13,	w3
    asr	w0,	w13,	#31
    lsl	w7,	w13,	#1
    lsr	w2,	w0,	#31
    add	w3,	w13,	w2
    asr	w14,	w3,	#1
    lsl	w15,	w14,	#1
    sub	w4,	w13,	w15
    add	w6,	w7,	w4
    str	w6,	[x18]

    ldr	w17,	[sp, fp]

    movz	fp,	#492
    add	w8,	w17,	#1
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w22,	w9
    movz	fp,	#428
    mov	w2,	w12
    mov	w18,	w1
    mov	w8,	w5
    mov	w3,	w27
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    mov	w28,	w6
    str	w22,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w28,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w14,	#60289
    movz	w28,	#31129
    movz	w22,	#65535
    movz	fp,	#412
    movk	w2,	#36635,	lsl #16
    movk	w14,	#28377,	lsl #16
    movk	w28,	#23170,	lsl #16
    movk	w22,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w20,	w2
    mov	w10,	w14
    mov	w16,	w28
    mov	w17,	w22
    ldr	w15,	[sp, fp]

    movz	w2,	#49414
    movk	w2,	#51810,	lsl #16
    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w0,	w17
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#424
    add	w6,	w24,	w18
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#416
    sub	w0,	w0,	w13
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    add	w11,	w18,	w0
    add	w14,	w11,	w6
    sub	w7,	w6,	w14
    add	w22,	w7,	w11
    sub	w28,	w22,	w14
    sub	w0,	w28,	w22
    add	w7,	w0,	w14
    sub	w11,	w7,	w22
    mov	w7,	w11
    mov	w11,	w16
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    cmp	w21,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#424
    add	w7,	w28,	w24
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    sub	w18,	w22,	w7
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#416
    add	w24,	w18,	w6
    movk	fp,	#2,	lsl #16
    sub	w11,	w24,	w7
    ldr	w6,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w6,	w6,	w11
    ldr	w26,	[sp, fp]

    sub	w0,	w11,	w6
    add	w0,	w0,	w26
    sub	w11,	w0,	w6
    mov	w22,	w11
    mov	w11,	w10
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    cmp	w22,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    add	w24,	w8,	w6
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    add	w14,	w8,	w22
    movk	fp,	#2,	lsl #16
    add	w6,	w14,	w24
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w24,	w6
    add	w14,	w0,	w14
    sub	w0,	w14,	w6
    sub	w7,	w0,	w14
    add	w11,	w7,	w6
    sub	w7,	w11,	w14
    ldr	w14,	[sp, fp]

    add	w14,	w18,	w14
    add	w22,	w14,	w7
    sub	w24,	w7,	w22
    add	w14,	w24,	w14
    sub	w18,	w14,	w22
    sub	w0,	w18,	w14
    add	w7,	w0,	w22
    sub	w11,	w7,	w14
    mov	w22,	w11
    mov	w11,	w20
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#424
    add	w6,	w18,	w8
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    sub	w11,	w8,	w6
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    add	w11,	w11,	w22
    movk	fp,	#2,	lsl #16
    sub	w6,	w11,	w6
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	w6
    ldr	w11,	[sp, fp]

    sub	w28,	w6,	w0
    add	w11,	w28,	w11
    sub	w11,	w11,	w0
    mov	w22,	w11
    mov	w11,	w2

main_413:
    mov	w7,	w22

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w18,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#428
    asr	w14,	w13,	#31
    movk	fp,	#2,	lsl #16
    lsr	w6,	w14,	#27
    ldr	w14,	[sp, fp]

    movz	fp,	#428
    add	w14,	w14,	w6
    movk	fp,	#2,	lsl #16
    asr	w14,	w14,	#5
    ldr	w21,	[sp, fp]

    movz	fp,	#412
    lsl	w22,	w14,	#5
    movk	fp,	#2,	lsl #16
    sub	w14,	w21,	w22
    ldr	w25,	[sp, fp]

    movz	fp,	#424
    lsl	w0,	w25,	#2
    movk	fp,	#2,	lsl #16
    mov	x0,	x0
    add	w24,	w18,	w14
    add	x0,	sp,	x0
    add	w28,	w24,	w3
    add	x0,	x0,	#16
    add	w7,	w28,	w7
    ldr	w14,	[x0]

    ldr	w21,	[sp, fp]

    movz	fp,	#424
    add	w7,	w7,	w11
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    add	w11,	w7,	w14
    movz	fp,	#424
    asr	w6,	w18,	#31
    lsl	w7,	w21,	#30
    movk	fp,	#2,	lsl #16
    lsr	w14,	w6,	#2
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w22,	w13,	w14
    movk	fp,	#2,	lsl #16
    asr	w6,	w22,	#30
    ldr	w18,	[sp, fp]

    movz	fp,	#412
    lsl	w14,	w6,	#30
    movk	fp,	#2,	lsl #16
    sub	w18,	w18,	w14
    ldr	w8,	[sp, fp]

    add	w28,	w8,	#1
    add	w18,	w7,	w18
    cmp	w28,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w3,	w17
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w22,	w18,	w0
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w3,	w2
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w2,	w13,	w0
    add	w6,	w2,	w22
    sub	w14,	w22,	w6
    add	w10,	w14,	w2
    mov	w14,	w16
    sub	w15,	w10,	w6
    sub	w17,	w15,	w10
    add	w22,	w17,	w6
    sub	w20,	w22,	w10
    mov	w22,	w20
    b	main_347

main_364:
    cmp	w28,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#428
    add	w14,	w18,	w21
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    sub	w21,	w4,	w14
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	w18
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w14
    ldr	w24,	[sp, fp]

    add	w17,	w17,	w0
    sub	w3,	w0,	w17
    add	w7,	w3,	w24
    mov	w24,	w10
    sub	w16,	w7,	w17
    b	main_375

main_378:
    cmp	w28,	#60
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
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    add	w16,	w2,	w8
    movk	fp,	#2,	lsl #16
    add	w0,	w16,	w17
    ldr	w24,	[sp, fp]

    add	w10,	w24,	w18
    sub	w2,	w17,	w0
    add	w3,	w2,	w16
    sub	w15,	w3,	w0
    sub	w16,	w15,	w3
    add	w0,	w16,	w0
    sub	w3,	w0,	w3
    add	w0,	w10,	w3
    sub	w7,	w3,	w0
    add	w24,	w7,	w10
    sub	w15,	w24,	w0
    sub	w22,	w15,	w24
    add	w2,	w22,	w0
    sub	w15,	w2,	w24
    mov	w2,	w20
    mov	w17,	w15
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w14,	w18,	w0
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w20,	w14
    movk	fp,	#2,	lsl #16
    add	w7,	w6,	w18
    ldr	w26,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w7,	w14
    ldr	w7,	[sp, fp]

    add	w16,	w26,	w0
    sub	w10,	w0,	w16
    add	w3,	w10,	w7
    sub	w16,	w3,	w16
    mov	w17,	w16

main_398:
    mov	w16,	w17
    mov	w24,	w2

main_375:
    mov	w22,	w16
    mov	w14,	w24

main_347:
    lsl	w15,	w11,	#5
    asr	w2,	w11,	#31
    lsl	w21,	w28,	#2
    movz	fp,	#416
    add	w24,	w28,	#1
    lsr	w3,	w2,	#27
    mov	x16,	x21
    movk	fp,	#2,	lsl #16
    add	w6,	w11,	w3
    add	x16,	sp,	x16
    asr	w6,	w6,	#5
    add	x16,	x16,	#16
    lsl	w7,	w6,	#5
    ldr	w0,	[x16]

    sub	w7,	w11,	w7
    ldr	w21,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w6,	w7,	w21
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    add	w7,	w6,	w15
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    add	w16,	w7,	w22
    movz	fp,	#428
    asr	w13,	w25,	#31
    movk	fp,	#2,	lsl #16
    add	w7,	w16,	w14
    lsr	w17,	w13,	#2
    add	w20,	w7,	w0
    ldr	w0,	[sp, fp]

    lsl	w7,	w4,	#30
    movz	fp,	#428
    add	w16,	w0,	w17
    movk	fp,	#2,	lsl #16
    asr	w3,	w16,	#30
    ldr	w4,	[sp, fp]

    lsl	w6,	w3,	#30
    sub	w14,	w4,	w6
    add	w2,	w7,	w14
    cmp	w24,	#80
    blt	main_276

main_433:
    add	w14,	w20,	w9
    add	w22,	w11,	w12
    add	w7,	w18,	w5
    movz	fp,	#432
    add	w28,	w23,	#64
    add	w11,	w2,	w1
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    add	w8,	w6,	w27
    cmp	w28,	w19
    blt	main_62

main_441:
    movz	fp,	#444
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#452
    str	w14,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#508
    str	w22,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#500
    str	w11,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#516
    str	w7,	[x22]

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

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w9,	w14
    mov	w12,	w22
    mov	w1,	w11
    mov	w5,	w7
    mov	w27,	w8
    mov	w23,	w28
    b	main_63

main_276:
    mov	w17,	w20
    movz	fp,	#428
    mov	w4,	w11
    mov	w15,	w18
    mov	w10,	w24
    mov	w13,	w2
    movk	fp,	#2,	lsl #16
    str	w17,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#412
    mov	w3,	w11
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#620
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


