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
    movz	w4,	#0
    movz	fp,	#356
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#460
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

    movz	fp,	#452
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#532
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w1
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
    lsr	w24,	w22,	#24
    add	w25,	w1,	w24
    asr	w21,	w25,	#8
    lsl	w22,	w21,	#8
    sub	w25,	w1,	w22
    str	w25,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w20,	#128
    movz	fp,	#452
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w1
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


main_46:
    asr	w24,	w16,	#31
    lsr	w25,	w24,	#26
    add	w28,	w16,	w25
    asr	w0,	w28,	#6
    lsl	w2,	w0,	#6
    sub	w25,	w16,	w2
    cmp	w25,	#60
    beq	main_53

main_50:
    lsl	w3,	w16,	#2
    movz	fp,	#436
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
    movz	fp,	#436
    add	w21,	w16,	#1
    movz	w25,	#0
    movz	w22,	#125
    add	w26,	w16,	#4
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w21,	#2
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    add	w1,	w16,	#3
    ldr	x0,	[sp, fp]

    add	w25,	w16,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x21,	x0,	x2
    movz	w2,	#0
    str	w22,	[x21]

    ldr	x1,	[sp, fp]

    movz	fp,	#444
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w19,	#0
    movz	w17,	#8961
    movz	w25,	#43913
    movz	w3,	#56574
    movz	w6,	#21622
    movk	w17,	#26437,	lsl #16
    movk	w25,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w11,	w17
    mov	w28,	w25
    mov	w4,	w3
    movz	w17,	#57840
    mov	w25,	w6
    movk	w17,	#50130,	lsl #16
    mov	w21,	w17
    mov	w17,	w19

main_63:
    movz	w15,	#0
    mov	w19,	w17
    mov	w10,	w15

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w15,	w10,	#2
    lsl	w3,	w19,	#2
    movz	fp,	#436
    add	w0,	w19,	#1
    add	w12,	w19,	#2
    add	w10,	w10,	#1
    mov	x14,	x15
    movk	fp,	#2,	lsl #16
    lsl	w16,	w0,	#2
    add	x14,	sp,	x14
    lsl	w7,	w12,	#2
    ldr	x27,	[sp, fp]

    add	w12,	w19,	#4
    movz	fp,	#436
    add	x14,	x14,	#16
    add	x2,	x27,	x3
    movk	fp,	#2,	lsl #16
    lsl	w24,	w12,	#2
    ldr	w6,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w18,	w6,	#24
    movz	fp,	#436
    add	x1,	x9,	x16
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x1]

    ldr	x22,	[sp, fp]

    lsl	w6,	w3,	#16
    movz	fp,	#436
    add	w8,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	x18,	x22,	x7
    add	w22,	w12,	#1
    ldr	w0,	[x18]

    lsl	w16,	w22,	#2
    ldr	x27,	[sp, fp]

    lsl	w1,	w0,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w2,	w8,	w1
    add	w8,	w19,	#3
    lsl	w13,	w8,	#2
    lsl	w8,	w10,	#2
    add	x9,	x27,	x13
    mov	x6,	x8
    add	w13,	w12,	#4
    add	x6,	sp,	x6
    ldr	w18,	[x9]

    add	x6,	x6,	#16
    add	w7,	w2,	w18
    str	w7,	[x14]

    add	w7,	w13,	#1
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x20,	x8,	x24
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x20]

    lsl	w19,	w0,	#24
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x0,	x0,	x16
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    ldr	x3,	[sp, fp]

    lsl	w8,	w5,	#16
    movz	fp,	#436
    add	w15,	w8,	w19
    movk	fp,	#2,	lsl #16
    add	w19,	w12,	#2
    lsl	w8,	w19,	#2
    add	x0,	x3,	x8
    add	w8,	w12,	#3
    lsl	w12,	w7,	#2
    ldr	w2,	[x0]

    ldr	x9,	[sp, fp]

    lsl	w3,	w2,	#8
    movz	fp,	#436
    lsl	w2,	w13,	#2
    add	w16,	w15,	w3
    movk	fp,	#2,	lsl #16
    lsl	w15,	w8,	#2
    add	x9,	x9,	x15
    add	w15,	w13,	#4
    ldr	w19,	[x9]

    add	w3,	w16,	w19
    add	w16,	w13,	#2
    str	w3,	[x6]

    lsl	w24,	w16,	#2
    ldr	x0,	[sp, fp]

    add	w6,	w10,	#1
    movz	fp,	#436
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    lsl	w8,	w6,	#2
    ldr	w3,	[x1]

    mov	x5,	x8
    ldr	x18,	[sp, fp]

    lsl	w1,	w3,	#24
    add	x5,	sp,	x5
    movz	fp,	#436
    add	x9,	x18,	x12
    movk	fp,	#2,	lsl #16
    add	x5,	x5,	#16
    ldr	w12,	[x9]

    ldr	x18,	[sp, fp]

    lsl	w14,	w12,	#16
    movz	fp,	#436
    add	x19,	x18,	x24
    add	w12,	w14,	w1
    movk	fp,	#2,	lsl #16
    add	w1,	w13,	#3
    ldr	w22,	[x19]

    ldr	x2,	[sp, fp]

    lsl	w0,	w22,	#8
    movz	fp,	#436
    add	w3,	w12,	w0
    movk	fp,	#2,	lsl #16
    add	w12,	w6,	#1
    lsl	w0,	w1,	#2
    add	w6,	w15,	#1
    add	x19,	x2,	x0
    lsl	w24,	w12,	#2
    lsl	w10,	w6,	#2
    mov	x7,	x24
    ldr	w1,	[x19]

    lsl	w24,	w15,	#2
    add	x7,	sp,	x7
    add	w8,	w3,	w1
    add	x7,	x7,	#16
    str	w8,	[x5]

    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x20,	x8,	x24
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x20]

    add	w20,	w15,	#3
    ldr	x3,	[sp, fp]

    lsl	w0,	w0,	#24
    movz	fp,	#436
    add	x9,	x3,	x10
    movk	fp,	#2,	lsl #16
    add	w3,	w15,	#2
    ldr	w14,	[x9]

    lsl	w8,	w3,	#2
    ldr	x13,	[sp, fp]

    lsl	w19,	w14,	#16
    movz	fp,	#436
    add	x5,	x13,	x8
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w0
    add	w8,	w15,	#4
    ldr	w10,	[x5]

    add	w5,	w12,	#1
    ldr	x13,	[sp, fp]

    lsl	w14,	w10,	#8
    movz	fp,	#436
    add	w10,	w8,	#1
    movk	fp,	#2,	lsl #16
    add	w2,	w0,	w14
    lsl	w0,	w20,	#2
    lsl	w10,	w10,	#2
    add	x22,	x13,	x0
    ldr	w1,	[x22]

    add	w22,	w8,	#2
    add	w3,	w2,	w1
    lsl	w1,	w5,	#2
    mov	x15,	x1
    str	w3,	[x7]

    lsl	w24,	w22,	#2
    lsl	w1,	w8,	#2
    add	x15,	sp,	x15
    add	w7,	w5,	#1
    ldr	x16,	[sp, fp]

    movz	fp,	#436
    add	x0,	x16,	x1
    add	x15,	x15,	#16
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x0]

    ldr	x16,	[sp, fp]

    lsl	w3,	w2,	#24
    movz	fp,	#436
    add	x12,	x16,	x10
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	#4
    ldr	w14,	[x12]

    lsl	w19,	w10,	#2
    ldr	x12,	[sp, fp]

    lsl	w16,	w14,	#16
    movz	fp,	#436
    add	x0,	x12,	x24
    movk	fp,	#2,	lsl #16
    add	w14,	w16,	w3
    add	w12,	w10,	#2
    lsl	w16,	w7,	#2
    ldr	w6,	[x0]

    lsl	w5,	w12,	#2
    ldr	x22,	[sp, fp]

    add	w0,	w8,	#3
    lsl	w13,	w6,	#8
    movz	fp,	#436
    add	w9,	w14,	w13
    movk	fp,	#2,	lsl #16
    lsl	w2,	w0,	#2
    add	w13,	w10,	#1
    add	x1,	x22,	x2
    ldr	w3,	[x1]

    add	w3,	w9,	w3
    lsl	w9,	w13,	#2
    str	w3,	[x15]

    ldr	x2,	[sp, fp]

    mov	x3,	x16
    movz	fp,	#436
    add	x18,	x2,	x19
    add	x3,	sp,	x3
    movk	fp,	#2,	lsl #16
    ldr	w20,	[x18]

    add	x3,	x3,	#16
    ldr	x23,	[sp, fp]

    lsl	w1,	w20,	#24
    movz	fp,	#436
    add	x15,	x23,	x9
    add	w20,	w10,	#3
    movk	fp,	#2,	lsl #16
    add	w9,	w10,	#4
    ldr	w0,	[x15]

    ldr	x8,	[sp, fp]

    lsl	w2,	w0,	#16
    movz	fp,	#436
    add	x14,	x8,	x5
    add	w2,	w2,	w1
    movk	fp,	#2,	lsl #16
    lsl	w1,	w20,	#2
    ldr	w16,	[x14]

    ldr	x12,	[sp, fp]

    lsl	w19,	w16,	#8
    movz	fp,	#436
    add	x0,	x12,	x1
    add	w16,	w2,	w19
    movk	fp,	#2,	lsl #16
    lsl	w1,	w9,	#2
    ldr	w6,	[x0]

    add	w0,	w7,	#1
    add	w24,	w16,	w6
    lsl	w7,	w0,	#2
    str	w24,	[x3]

    mov	x2,	x7
    ldr	x15,	[sp, fp]

    add	w7,	w9,	#3
    add	x2,	sp,	x2
    movz	fp,	#436
    add	x16,	x15,	x1
    movk	fp,	#2,	lsl #16
    add	w15,	w9,	#1
    add	x2,	x2,	#16
    ldr	w3,	[x16]

    lsl	w12,	w15,	#2
    lsl	w14,	w3,	#24
    ldr	x15,	[sp, fp]

    movz	fp,	#436
    add	x16,	x15,	x12
    movk	fp,	#2,	lsl #16
    add	w12,	w9,	#2
    ldr	w20,	[x16]

    ldr	x16,	[sp, fp]

    lsl	w22,	w20,	#16
    movz	fp,	#436
    lsl	w20,	w12,	#2
    add	w1,	w22,	w14
    movk	fp,	#2,	lsl #16
    lsl	w12,	w7,	#2
    add	x13,	x16,	x20
    ldr	w19,	[x13]

    lsl	w3,	w19,	#8
    ldr	x19,	[sp, fp]

    add	w3,	w1,	w3
    add	x10,	x19,	x12
    add	w1,	w0,	#1
    add	w19,	w9,	#4
    ldr	w13,	[x10]

    mov	w10,	w1
    add	w6,	w3,	w13
    str	w6,	[x2]

    b	main_70

main_215:
    mov	w16,	w19
    mov	w3,	w10

main_217:
    lsl	w7,	w3,	#2
    lsl	w12,	w16,	#2
    movz	fp,	#436
    add	w1,	w16,	#1
    add	w0,	w16,	#2
    add	w22,	w3,	#1
    mov	x5,	x7
    movk	fp,	#2,	lsl #16
    lsl	w24,	w1,	#2
    add	x5,	sp,	x5
    lsl	w15,	w0,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x13,	x2,	x12
    add	x5,	x5,	#16
    movk	fp,	#2,	lsl #16
    ldr	w18,	[x13]

    ldr	x1,	[sp, fp]

    lsl	w19,	w18,	#24
    movz	fp,	#436
    add	x7,	x1,	x24
    add	w18,	w16,	#4
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x7]

    ldr	x2,	[sp, fp]

    lsl	w13,	w10,	#16
    movz	fp,	#436
    add	x1,	x2,	x15
    add	w13,	w13,	w19
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x1]

    add	w1,	w16,	#3
    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w13,	w9
    lsl	w19,	w1,	#2
    add	x7,	x8,	x19
    ldr	w14,	[x7]

    add	w19,	w9,	w14
    str	w19,	[x5]

    cmp	w22,	#16
    bge	main_241

main_216:
    mov	w16,	w18
    mov	w3,	w22
    b	main_217

main_241:
    mov	w13,	w22
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]


main_242:
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#500
    lsl	w19,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x15,	x19
    add	x15,	sp,	x15
    ldr	w23,	[sp, fp]

    movz	fp,	#500
    sub	w22,	w23,	#3
    add	x15,	x15,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w22,	#2
    mov	x1,	x3
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w5,	[x1]

    ldr	w2,	[sp, fp]

    movz	fp,	#500
    sub	w3,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w3,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w9,	[x7]

    ldr	w3,	[sp, fp]

    add	w7,	w9,	w5
    movz	fp,	#500
    sub	w19,	w3,	#14
    movk	fp,	#2,	lsl #16
    sub	w12,	w5,	w7
    lsl	w24,	w19,	#2
    mov	x22,	x24
    add	w16,	w12,	w9
    add	x22,	sp,	x22
    sub	w7,	w16,	w7
    add	x22,	x22,	#16
    ldr	w2,	[x22]

    ldr	w5,	[sp, fp]

    add	w24,	w2,	w7
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    sub	w0,	w7,	w24
    add	w8,	w0,	w2
    sub	w0,	w5,	#16
    sub	w20,	w8,	w24
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w20
    sub	w9,	w20,	w2
    add	w10,	w9,	w3
    sub	w16,	w10,	w2
    asr	w0,	w16,	#31
    lsl	w9,	w16,	#1
    lsr	w1,	w0,	#31
    add	w2,	w16,	w1
    asr	w10,	w2,	#1
    lsl	w12,	w10,	#1
    sub	w3,	w16,	w12
    add	w6,	w9,	w3
    str	w6,	[x15]

    ldr	w15,	[sp, fp]

    movz	fp,	#500
    add	w7,	w15,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w23,	w11
    movz	fp,	#428
    mov	w1,	w28
    mov	w14,	w4
    mov	w9,	w25
    mov	w0,	w21
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    mov	w2,	w5
    str	w23,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w13,	#60289
    movz	w5,	#49414
    movz	w20,	#65535
    movz	fp,	#404
    movk	w2,	#36635,	lsl #16
    movk	w13,	#28377,	lsl #16
    movk	w5,	#51810,	lsl #16
    movk	w20,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w16,	w2
    mov	w8,	w13
    mov	w14,	w20
    mov	w2,	w5
    ldr	w13,	[sp, fp]

    movz	w5,	#31129
    movk	w5,	#23170,	lsl #16
    mov	w15,	w5
    cmp	w13,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w13,	w14
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    add	w5,	w20,	w18
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#408
    sub	w12,	w13,	w10
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w13,	w19,	w12
    add	w20,	w13,	w5
    sub	w9,	w5,	w20
    add	w22,	w9,	w13
    sub	w13,	w22,	w20
    sub	w9,	w13,	w22
    add	w12,	w9,	w20
    sub	w9,	w12,	w22
    mov	w12,	w15
    mov	w6,	w9
    b	main_416

main_296:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    cmp	w18,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#424
    add	w6,	w24,	w22
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w13,	w19,	w6
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#408
    add	w20,	w13,	w5
    movk	fp,	#2,	lsl #16
    sub	w24,	w20,	w6
    ldr	w5,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w5,	w5,	w24
    ldr	w27,	[sp, fp]

    sub	w12,	w24,	w5
    add	w12,	w12,	w27
    sub	w9,	w12,	w5
    mov	w12,	w8
    mov	w18,	w9
    b	main_413

main_307:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#408
    add	w22,	w10,	w5
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#408
    add	w12,	w9,	w19
    movk	fp,	#2,	lsl #16
    add	w13,	w12,	w22
    sub	w18,	w22,	w13
    add	w5,	w18,	w12
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w5,	w13
    movk	fp,	#2,	lsl #16
    sub	w12,	w9,	w5
    add	w20,	w12,	w13
    sub	w6,	w20,	w5
    ldr	w20,	[sp, fp]

    add	w24,	w18,	w20
    add	w20,	w24,	w6
    sub	w22,	w6,	w20
    add	w13,	w22,	w24
    sub	w6,	w13,	w20
    sub	w9,	w6,	w13
    add	w12,	w9,	w20
    sub	w9,	w12,	w13
    mov	w12,	w16
    mov	w18,	w9
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w5,	w19,	w9
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    sub	w12,	w10,	w5
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#408
    add	w24,	w12,	w20
    movk	fp,	#2,	lsl #16
    sub	w12,	w24,	w5
    ldr	w18,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w9,	w18,	w12
    ldr	w10,	[sp, fp]

    sub	w18,	w12,	w9
    mov	w12,	w2
    add	w6,	w18,	w10
    sub	w9,	w6,	w9
    mov	w18,	w9

main_413:
    mov	w6,	w18

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    lsl	w13,	w1,	#5
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    asr	w20,	w9,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w20,	#27
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w9,	w19,	w24
    movk	fp,	#2,	lsl #16
    asr	w20,	w9,	#5
    ldr	w24,	[sp, fp]

    movz	fp,	#404
    lsl	w5,	w20,	#5
    movk	fp,	#2,	lsl #16
    sub	w9,	w24,	w5
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w22,	w13,	w9
    lsl	w13,	w20,	#2
    mov	x20,	x13
    add	w22,	w22,	w0
    add	x20,	sp,	x20
    add	w6,	w22,	w6
    add	x20,	x20,	#16
    add	w13,	w6,	w12
    ldr	w18,	[x20]

    add	w9,	w13,	w18
    ldr	w18,	[sp, fp]

    movz	fp,	#424
    lsl	w0,	w18,	#30
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    asr	w20,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w13,	w20,	#2
    ldr	w18,	[sp, fp]

    movz	fp,	#424
    add	w18,	w18,	w13
    movk	fp,	#2,	lsl #16
    asr	w13,	w18,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#404
    lsl	w20,	w13,	#30
    movk	fp,	#2,	lsl #16
    sub	w13,	w19,	w20
    ldr	w19,	[sp, fp]

    add	w22,	w19,	#1
    add	w18,	w0,	w13
    cmp	w22,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w3,	w14
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w13,	w18,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w3,	w1
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w2,	w10,	w0
    add	w3,	w2,	w13
    sub	w13,	w13,	w3
    add	w12,	w13,	w2
    sub	w13,	w12,	w3
    sub	w14,	w13,	w12
    mov	w13,	w15
    add	w19,	w14,	w3
    sub	w16,	w19,	w12
    mov	w20,	w16
    b	main_347

main_364:
    cmp	w22,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#428
    add	w14,	w18,	w16
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w3,	w14
    movk	fp,	#2,	lsl #16
    add	w0,	w6,	w18
    sub	w0,	w0,	w14
    ldr	w14,	[sp, fp]

    movz	fp,	#432
    add	w3,	w14,	w0
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    sub	w5,	w0,	w3
    mov	w0,	w8
    add	w13,	w5,	w20
    sub	w14,	w13,	w3
    b	main_375

main_378:
    cmp	w22,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    mov	w2,	w16
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w15,	w18,	w19
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    add	w14,	w1,	w7
    movk	fp,	#2,	lsl #16
    add	w8,	w14,	w15
    ldr	w20,	[sp, fp]

    add	w6,	w20,	w18
    sub	w0,	w15,	w8
    add	w5,	w0,	w14
    sub	w15,	w5,	w8
    sub	w3,	w15,	w5
    add	w0,	w3,	w8
    sub	w3,	w0,	w5
    add	w0,	w6,	w3
    sub	w8,	w3,	w0
    add	w12,	w8,	w6
    sub	w13,	w12,	w0
    sub	w19,	w13,	w12
    add	w0,	w19,	w0
    sub	w13,	w0,	w12
    mov	w15,	w13
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w14,	w18,	w3
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    sub	w5,	w15,	w14
    movk	fp,	#2,	lsl #16
    add	w6,	w5,	w18
    ldr	w27,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w6,	w14
    ldr	w10,	[sp, fp]

    add	w14,	w27,	w0
    sub	w6,	w0,	w14
    add	w0,	w6,	w10
    sub	w14,	w0,	w14
    mov	w15,	w14

main_398:
    mov	w14,	w15
    mov	w0,	w2

main_375:
    mov	w20,	w14
    mov	w13,	w0

main_347:
    lsl	w14,	w9,	#5
    asr	w2,	w9,	#31
    lsl	w19,	w22,	#2
    movz	fp,	#408
    lsr	w3,	w2,	#27
    mov	x8,	x19
    movk	fp,	#2,	lsl #16
    add	x8,	sp,	x8
    add	w5,	w9,	w3
    add	x8,	x8,	#16
    asr	w3,	w5,	#5
    ldr	w0,	[x8]

    lsl	w5,	w3,	#5
    ldr	w16,	[sp, fp]

    sub	w5,	w9,	w5
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w5,	w5,	w16
    ldr	w7,	[sp, fp]

    movz	fp,	#428
    lsl	w8,	w7,	#30
    movk	fp,	#2,	lsl #16
    add	w6,	w5,	w14
    ldr	w23,	[sp, fp]

    movz	fp,	#428
    add	w5,	w6,	w20
    movk	fp,	#2,	lsl #16
    add	w6,	w5,	w13
    asr	w13,	w23,	#31
    add	w15,	w6,	w0
    lsr	w20,	w13,	#2
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w3,	w0,	w20
    movk	fp,	#2,	lsl #16
    asr	w3,	w3,	#30
    ldr	w6,	[sp, fp]

    lsl	w5,	w3,	#30
    sub	w12,	w6,	w5
    add	w5,	w22,	#1
    add	w13,	w8,	w12
    cmp	w5,	#80
    blt	main_276

main_433:
    add	w14,	w15,	w11
    add	w5,	w13,	w4
    add	w8,	w18,	w25
    movz	fp,	#432
    add	w17,	w17,	#64
    add	w15,	w9,	w28
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w22,	w7,	w21
    cmp	w17,	w26
    blt	main_62

main_441:
    movz	fp,	#532
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#540
    str	w14,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#524
    str	w15,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#516
    str	w5,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#504
    str	w8,	[x21]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w22,	[x23]


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

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w1,	w6
    b	main_28

main_62:
    mov	w11,	w14
    mov	w28,	w15
    mov	w4,	w5
    mov	w25,	w8
    mov	w21,	w22
    b	main_63

main_276:
    mov	w14,	w15
    movz	fp,	#428
    mov	w24,	w9
    mov	w12,	w18
    mov	w7,	w5
    mov	w10,	w13
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w24,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#404
    mov	w0,	w9
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#460
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


