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
    movz	w23,	#0
    movz	w25,	#0
    movz	w26,	#0
    movz	fp,	#336
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
    movz	fp,	#356
    movz	w2,	#0
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#496
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
    movz	fp,	#452
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
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#420
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#528
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#544
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w1
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#436
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#436
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#436
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
    movz	fp,	#420
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
    movz	fp,	#452
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
    movz	fp,	#452
    add	w21,	w3,	#1
    movz	w26,	#0
    movz	w22,	#125
    movk	fp,	#2,	lsl #16
    lsl	w27,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#452
    add	x23,	x28,	x2
    movk	fp,	#2,	lsl #16
    movz	w28,	#0
    str	w28,	[x23]

    ldr	x0,	[sp, fp]

    movz	fp,	#452
    add	x1,	x0,	x27
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    ldr	x0,	[sp, fp]

    add	w26,	w3,	#2
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x19,	x0,	x2
    movz	w2,	#0
    add	w0,	w3,	#3
    str	w22,	[x19]

    lsl	w26,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#412
    add	x23,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x23]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    add	w23,	w3,	#4
    bl	memset
    movz	w27,	#0
    movz	w17,	#8961
    movz	w21,	#43913
    movz	w3,	#56574
    mov	w28,	w27
    movk	w17,	#26437,	lsl #16
    movk	w21,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    mov	w26,	w17
    mov	w12,	w21
    mov	w19,	w3
    movz	w17,	#57840
    movz	w3,	#21622
    movk	w17,	#50130,	lsl #16
    movk	w3,	#4146,	lsl #16
    mov	w6,	w17
    mov	w15,	w3

main_63:
    movz	w17,	#0
    mov	w21,	w28
    mov	w10,	w17

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w14,	w10,	#2
    lsl	w3,	w21,	#2
    movz	fp,	#452
    add	w11,	w21,	#2
    add	w5,	w21,	#3
    add	w10,	w10,	#1
    mov	x14,	x14
    movk	fp,	#2,	lsl #16
    add	x14,	sp,	x14
    lsl	w8,	w5,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#452
    add	x2,	x0,	x3
    add	x14,	x14,	#16
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	#1
    ldr	w4,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w13,	w4,	#24
    lsl	w16,	w0,	#2
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    add	x1,	x9,	x16
    ldr	w3,	[x1]

    ldr	x24,	[sp, fp]

    lsl	w4,	w3,	#16
    movz	fp,	#452
    add	w7,	w4,	w13
    movk	fp,	#2,	lsl #16
    lsl	w4,	w11,	#2
    add	w11,	w21,	#4
    add	x17,	x24,	x4
    lsl	w4,	w10,	#2
    add	w27,	w11,	#1
    mov	x3,	x4
    ldr	w1,	[x17]

    add	x3,	sp,	x3
    add	w17,	w11,	#2
    ldr	x0,	[sp, fp]

    lsl	w2,	w1,	#8
    movz	fp,	#452
    add	x3,	x3,	#16
    movk	fp,	#2,	lsl #16
    add	w2,	w7,	w2
    add	x7,	x0,	x8
    lsl	w0,	w11,	#2
    ldr	w16,	[x7]

    add	w5,	w2,	w16
    str	w5,	[x14]

    lsl	w14,	w27,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#452
    add	x22,	x7,	x0
    movk	fp,	#2,	lsl #16
    lsl	w7,	w17,	#2
    ldr	w1,	[x22]

    lsl	w18,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#452
    add	x1,	x1,	x14
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x1]

    ldr	x2,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#452
    add	x0,	x2,	x7
    add	w9,	w5,	w18
    movk	fp,	#2,	lsl #16
    add	w7,	w11,	#3
    ldr	w2,	[x0]

    lsl	w4,	w2,	#8
    lsl	w16,	w7,	#2
    add	w18,	w9,	w4
    ldr	x7,	[sp, fp]

    add	w4,	w10,	#1
    movz	fp,	#452
    add	x9,	x7,	x16
    movk	fp,	#2,	lsl #16
    lsl	w7,	w4,	#2
    ldr	w17,	[x9]

    add	w9,	w11,	#4
    add	w2,	w18,	w17
    add	w16,	w9,	#4
    add	w17,	w9,	#2
    str	w2,	[x3]

    ldr	x0,	[sp, fp]

    lsl	w3,	w9,	#2
    mov	x2,	x7
    movz	fp,	#452
    add	x1,	x0,	x3
    add	w7,	w9,	#1
    add	x2,	sp,	x2
    movk	fp,	#2,	lsl #16
    lsl	w0,	w17,	#2
    ldr	w5,	[x1]

    lsl	w13,	w7,	#2
    add	x2,	x2,	#16
    ldr	x18,	[sp, fp]

    lsl	w1,	w5,	#24
    movz	fp,	#452
    add	x8,	x18,	x13
    add	w5,	w9,	#3
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x8]

    ldr	x20,	[sp, fp]

    lsl	w14,	w13,	#16
    movz	fp,	#452
    add	x18,	x20,	x0
    add	w13,	w4,	#1
    add	w14,	w14,	w1
    movk	fp,	#2,	lsl #16
    lsl	w0,	w5,	#2
    ldr	w27,	[x18]

    add	w4,	w16,	#1
    ldr	x5,	[sp, fp]

    lsl	w1,	w27,	#8
    movz	fp,	#452
    add	x17,	x5,	x0
    add	w1,	w14,	w1
    movk	fp,	#2,	lsl #16
    lsl	w0,	w13,	#2
    ldr	w3,	[x17]

    mov	x5,	x0
    add	w7,	w1,	w3
    lsl	w0,	w16,	#2
    add	x5,	sp,	x5
    str	w7,	[x2]

    add	x5,	x5,	#16
    lsl	w7,	w4,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#452
    add	x22,	x8,	x0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x22]

    add	w22,	w16,	#3
    ldr	x3,	[sp, fp]

    lsl	w1,	w1,	#24
    movz	fp,	#452
    add	x7,	x3,	x7
    movk	fp,	#2,	lsl #16
    add	w3,	w16,	#2
    ldr	w9,	[x7]

    ldr	x11,	[sp, fp]

    lsl	w7,	w3,	#2
    lsl	w17,	w9,	#16
    movz	fp,	#452
    add	x4,	x11,	x7
    movk	fp,	#2,	lsl #16
    add	w0,	w17,	w1
    lsl	w1,	w22,	#2
    ldr	w10,	[x4]

    ldr	x11,	[sp, fp]

    lsl	w14,	w10,	#8
    movz	fp,	#452
    add	x27,	x11,	x1
    add	w2,	w0,	w14
    movk	fp,	#2,	lsl #16
    add	w11,	w13,	#1
    ldr	w3,	[x27]

    add	w13,	w16,	#4
    add	w2,	w2,	w3
    add	w20,	w11,	#1
    lsl	w1,	w11,	#2
    add	w10,	w13,	#1
    lsl	w3,	w13,	#2
    str	w2,	[x5]

    mov	x0,	x1
    lsl	w11,	w20,	#2
    ldr	x22,	[sp, fp]

    lsl	w16,	w10,	#2
    add	x0,	sp,	x0
    movz	fp,	#452
    add	x2,	x22,	x3
    mov	x10,	x11
    movk	fp,	#2,	lsl #16
    add	x0,	x0,	#16
    add	x10,	sp,	x10
    ldr	w4,	[x2]

    add	w2,	w13,	#2
    ldr	x17,	[sp, fp]

    add	x10,	x10,	#16
    lsl	w5,	w4,	#24
    movz	fp,	#452
    add	x14,	x17,	x16
    lsl	w3,	w2,	#2
    movk	fp,	#2,	lsl #16
    add	w2,	w13,	#3
    ldr	w18,	[x14]

    ldr	x16,	[sp, fp]

    lsl	w22,	w18,	#16
    lsl	w4,	w2,	#2
    movz	fp,	#452
    add	x3,	x16,	x3
    add	w22,	w22,	w5
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    ldr	x25,	[sp, fp]

    lsl	w7,	w5,	#8
    movz	fp,	#452
    add	x3,	x25,	x4
    add	w9,	w22,	w7
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    add	w5,	w9,	w5
    str	w5,	[x0]

    ldr	x1,	[sp, fp]

    add	w0,	w13,	#4
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    add	w7,	w0,	#1
    lsl	w16,	w0,	#2
    add	x14,	x1,	x16
    lsl	w4,	w7,	#2
    add	w7,	w0,	#2
    ldr	w21,	[x14]

    ldr	x24,	[sp, fp]

    lsl	w2,	w21,	#24
    movz	fp,	#452
    add	x8,	x24,	x4
    movk	fp,	#2,	lsl #16
    lsl	w4,	w7,	#2
    ldr	w1,	[x8]

    lsl	w3,	w1,	#16
    add	w3,	w3,	w2
    ldr	x2,	[sp, fp]

    movz	fp,	#452
    add	x8,	x2,	x4
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x8]

    ldr	x5,	[sp, fp]

    lsl	w16,	w14,	#8
    movz	fp,	#452
    add	w18,	w3,	w16
    movk	fp,	#2,	lsl #16
    add	w16,	w0,	#3
    lsl	w2,	w16,	#2
    add	x22,	x5,	x2
    add	w5,	w0,	#4
    add	w2,	w20,	#1
    ldr	w3,	[x22]

    add	w21,	w5,	#4
    add	w8,	w5,	#3
    add	w9,	w5,	#2
    lsl	w0,	w5,	#2
    lsl	w4,	w2,	#2
    add	w22,	w18,	w3
    mov	x3,	x4
    add	x3,	sp,	x3
    str	w22,	[x10]

    ldr	x16,	[sp, fp]

    add	x3,	x3,	#16
    movz	fp,	#452
    add	x14,	x16,	x0
    movk	fp,	#2,	lsl #16
    add	w16,	w5,	#1
    ldr	w1,	[x14]

    lsl	w11,	w16,	#2
    ldr	x17,	[sp, fp]

    lsl	w14,	w1,	#24
    movz	fp,	#452
    add	x17,	x17,	x11
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x17]

    ldr	x17,	[sp, fp]

    lsl	w27,	w22,	#16
    movz	fp,	#452
    lsl	w22,	w9,	#2
    add	w4,	w27,	w14
    movk	fp,	#2,	lsl #16
    add	x10,	x17,	x22
    ldr	w17,	[x10]

    ldr	x20,	[sp, fp]

    lsl	w10,	w8,	#2
    lsl	w0,	w17,	#8
    add	x9,	x20,	x10
    add	w1,	w4,	w0
    ldr	w13,	[x9]

    add	w7,	w1,	w13
    add	w1,	w2,	#1
    mov	w10,	w1
    str	w7,	[x3]

    b	main_70

main_215:
    mov	w18,	w21
    mov	w1,	w10

main_217:
    lsl	w5,	w1,	#2
    lsl	w11,	w18,	#2
    movz	fp,	#452
    add	w27,	w1,	#1
    add	w20,	w18,	#4
    mov	x4,	x5
    movk	fp,	#2,	lsl #16
    add	x4,	sp,	x4
    ldr	x3,	[sp, fp]

    add	x4,	x4,	#16
    movz	fp,	#452
    add	x13,	x3,	x11
    movk	fp,	#2,	lsl #16
    add	w3,	w18,	#1
    ldr	w16,	[x13]

    lsl	w0,	w3,	#2
    lsl	w22,	w16,	#24
    ldr	x3,	[sp, fp]

    movz	fp,	#452
    add	x5,	x3,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w18,	#2
    ldr	w8,	[x5]

    lsl	w13,	w0,	#2
    ldr	x3,	[sp, fp]

    lsl	w9,	w8,	#16
    movz	fp,	#452
    add	x2,	x3,	x13
    movk	fp,	#2,	lsl #16
    add	w9,	w9,	w22
    add	w3,	w18,	#3
    ldr	w7,	[x2]

    lsl	w17,	w3,	#2
    lsl	w8,	w7,	#8
    ldr	x7,	[sp, fp]

    add	w9,	w9,	w8
    add	x5,	x7,	x17
    ldr	w10,	[x5]

    add	w21,	w9,	w10
    str	w21,	[x4]

    cmp	w27,	#16
    bge	main_241

main_216:
    mov	w18,	w20
    mov	w1,	w27
    b	main_217

main_241:
    mov	w13,	w27
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]


main_242:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#492
    lsl	w21,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x21
    add	x17,	sp,	x17
    ldr	w24,	[sp, fp]

    movz	fp,	#492
    sub	w27,	w24,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w1,	w27,	#2
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w2,	[x0]

    ldr	w3,	[sp, fp]

    movz	fp,	#492
    sub	w4,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w7,	w4,	#2
    mov	x5,	x7
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w9,	[x5]

    ldr	w3,	[sp, fp]

    add	w5,	w9,	w2
    movz	fp,	#492
    sub	w21,	w3,	#14
    movk	fp,	#2,	lsl #16
    sub	w11,	w2,	w5
    lsl	w0,	w21,	#2
    mov	x27,	x0
    add	w14,	w11,	w9
    add	x27,	sp,	x27
    sub	w5,	w14,	w5
    add	x27,	x27,	#16
    ldr	w1,	[x27]

    ldr	w4,	[sp, fp]

    add	w0,	w1,	w5
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    sub	w3,	w5,	w0
    add	w5,	w3,	w1
    sub	w22,	w5,	w0
    sub	w0,	w4,	#16
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w22
    sub	w8,	w22,	w2
    add	w10,	w8,	w3
    sub	w13,	w10,	w2
    asr	w0,	w13,	#31
    lsl	w7,	w13,	#1
    lsr	w1,	w0,	#31
    add	w2,	w13,	w1
    asr	w10,	w2,	#1
    lsl	w11,	w10,	#1
    sub	w3,	w13,	w11
    add	w4,	w7,	w3
    str	w4,	[x17]

    ldr	w16,	[sp, fp]

    movz	fp,	#492
    add	w5,	w16,	#1
    movk	fp,	#2,	lsl #16
    mov	w7,	w5
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w26
    movz	fp,	#444
    mov	w1,	w12
    mov	w18,	w19
    mov	w9,	w15
    mov	w3,	w6
    movz	w2,	#0
    movk	fp,	#2,	lsl #16
    mov	w27,	w2
    str	w25,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w10,	#60289
    movz	w27,	#31129
    movz	w21,	#65535
    movz	fp,	#428
    movk	w2,	#36635,	lsl #16
    movk	w10,	#28377,	lsl #16
    movk	w27,	#23170,	lsl #16
    movk	w21,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w2
    mov	w5,	w10
    mov	w14,	w27
    mov	w16,	w21
    ldr	w13,	[sp, fp]

    movz	w2,	#49414
    movk	w2,	#51810,	lsl #16
    mov	w1,	w2
    cmp	w13,	#20
    bge	main_296

main_285:
    movz	fp,	#440
    mov	w17,	w16
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    add	w9,	w21,	w20
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    sub	w10,	w17,	w8
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w17,	w13,	w10
    add	w2,	w17,	w9
    sub	w21,	w9,	w2
    mov	w9,	w14
    add	w7,	w21,	w17
    sub	w22,	w7,	w2
    sub	w10,	w22,	w7
    add	w13,	w10,	w2
    sub	w7,	w13,	w7
    mov	w13,	w7
    b	main_416

main_296:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    cmp	w17,	#40
    bge	main_307

main_298:
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    add	w9,	w21,	w22
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#448
    sub	w17,	w20,	w9
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    add	w7,	w17,	w7
    movk	fp,	#2,	lsl #16
    sub	w13,	w7,	w9
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w7,	w4,	w13
    ldr	w27,	[sp, fp]

    sub	w10,	w13,	w7
    add	w10,	w10,	w27
    sub	w7,	w10,	w7
    mov	w10,	w5
    mov	w22,	w7
    b	main_413

main_307:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    cmp	w20,	#60
    bge	main_327

main_309:
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    add	w2,	w9,	w4
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    add	w21,	w9,	w21
    movk	fp,	#2,	lsl #16
    add	w13,	w21,	w2
    ldr	w17,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    sub	w7,	w2,	w13
    ldr	w11,	[sp, fp]

    add	w7,	w7,	w21
    sub	w9,	w7,	w13
    sub	w10,	w9,	w7
    add	w2,	w10,	w13
    add	w13,	w17,	w11
    sub	w9,	w2,	w7
    add	w27,	w13,	w9
    sub	w2,	w9,	w27
    add	w17,	w2,	w13
    sub	w13,	w17,	w27
    sub	w9,	w13,	w17
    add	w10,	w9,	w27
    sub	w7,	w10,	w17
    mov	w10,	w18
    mov	w22,	w7
    b	main_413

main_327:
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#440
    add	w7,	w13,	w8
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#448
    sub	w17,	w9,	w7
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    add	w13,	w17,	w22
    movk	fp,	#2,	lsl #16
    sub	w21,	w13,	w7
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w9,	w17,	w21
    ldr	w8,	[sp, fp]

    sub	w22,	w21,	w9
    add	w10,	w22,	w8
    sub	w7,	w10,	w9
    mov	w10,	w1
    mov	w22,	w7

main_413:
    mov	w13,	w22
    mov	w9,	w10

main_416:
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#444
    lsl	w17,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#444
    asr	w21,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w10,	w21,	#27
    ldr	w20,	[sp, fp]

    movz	fp,	#444
    add	w27,	w20,	w10
    movk	fp,	#2,	lsl #16
    asr	w21,	w27,	#5
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    lsl	w21,	w21,	#5
    movk	fp,	#2,	lsl #16
    sub	w27,	w22,	w21
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    lsl	w10,	w21,	#2
    add	w22,	w17,	w27
    movk	fp,	#2,	lsl #16
    mov	x2,	x10
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w17,	[x2]

    add	w2,	w22,	w3
    add	w22,	w2,	w13
    add	w27,	w22,	w9
    add	w10,	w27,	w17
    ldr	w17,	[sp, fp]

    movz	fp,	#440
    lsl	w9,	w17,	#30
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#440
    asr	w7,	w13,	#31
    movk	fp,	#2,	lsl #16
    lsr	w13,	w7,	#2
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    add	w22,	w8,	w13
    movk	fp,	#2,	lsl #16
    asr	w2,	w22,	#30
    ldr	w13,	[sp, fp]

    movz	fp,	#428
    lsl	w17,	w2,	#30
    movk	fp,	#2,	lsl #16
    sub	w20,	w13,	w17
    add	w7,	w9,	w20
    ldr	w9,	[sp, fp]

    add	w0,	w9,	#1
    cmp	w0,	#20
    bge	main_364

main_336:
    movz	fp,	#444
    mov	w17,	w16
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#444
    add	w22,	w7,	w1
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#448
    sub	w1,	w17,	w2
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w2,	w13,	w1
    add	w16,	w2,	w22
    sub	w17,	w22,	w16
    add	w13,	w17,	w2
    sub	w18,	w13,	w16
    sub	w20,	w18,	w13
    add	w21,	w20,	w16
    sub	w17,	w21,	w13
    mov	w20,	w17
    b	main_347

main_364:
    cmp	w0,	#40
    bge	main_378

main_366:
    movz	fp,	#444
    mov	w27,	w5
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#444
    add	w16,	w7,	w17
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#448
    sub	w21,	w4,	w16
    movk	fp,	#2,	lsl #16
    add	w1,	w21,	w7
    sub	w1,	w1,	w16
    ldr	w16,	[sp, fp]

    movz	fp,	#448
    add	w18,	w16,	w1
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    sub	w3,	w1,	w18
    add	w17,	w3,	w24
    sub	w17,	w17,	w18
    b	main_375

main_378:
    cmp	w0,	#60
    bge	main_401

main_380:
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#444
    add	w21,	w7,	w22
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#448
    add	w20,	w3,	w8
    movk	fp,	#2,	lsl #16
    add	w2,	w20,	w21
    ldr	w24,	[sp, fp]

    add	w9,	w24,	w7
    sub	w13,	w21,	w2
    add	w3,	w13,	w20
    sub	w16,	w3,	w2
    sub	w17,	w16,	w3
    add	w1,	w17,	w2
    mov	w2,	w18
    sub	w3,	w1,	w3
    add	w1,	w9,	w3
    sub	w13,	w3,	w1
    add	w27,	w13,	w9
    sub	w17,	w27,	w1
    sub	w21,	w17,	w27
    add	w3,	w21,	w1
    sub	w16,	w3,	w27
    mov	w20,	w16
    b	main_398

main_401:
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#444
    add	w16,	w7,	w3
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#448
    sub	w5,	w17,	w16
    movk	fp,	#2,	lsl #16
    add	w9,	w5,	w7
    ldr	w2,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    sub	w3,	w9,	w16
    ldr	w8,	[sp, fp]

    add	w18,	w2,	w3
    mov	w2,	w1
    sub	w9,	w3,	w18
    add	w5,	w9,	w8
    sub	w17,	w5,	w18
    mov	w20,	w17

main_398:
    mov	w17,	w20
    mov	w27,	w2

main_375:
    mov	w20,	w17
    mov	w14,	w27

main_347:
    lsl	w9,	w10,	#5
    asr	w21,	w10,	#31
    movz	fp,	#432
    lsr	w27,	w21,	#27
    movk	fp,	#2,	lsl #16
    add	w13,	w10,	w27
    lsl	w27,	w0,	#2
    mov	x22,	x27
    asr	w21,	w13,	#5
    add	w27,	w0,	#1
    add	x22,	sp,	x22
    lsl	w1,	w21,	#5
    add	x22,	x22,	#16
    sub	w5,	w10,	w1
    ldr	w1,	[x22]

    ldr	w18,	[sp, fp]

    movz	fp,	#444
    add	w5,	w5,	w18
    movk	fp,	#2,	lsl #16
    add	w9,	w5,	w9
    ldr	w4,	[sp, fp]

    movz	fp,	#444
    lsl	w11,	w4,	#30
    movk	fp,	#2,	lsl #16
    add	w17,	w9,	w20
    ldr	w25,	[sp, fp]

    movz	fp,	#444
    add	w9,	w17,	w14
    movk	fp,	#2,	lsl #16
    asr	w14,	w25,	#31
    ldr	w2,	[sp, fp]

    add	w18,	w9,	w1
    lsr	w20,	w14,	#2
    movz	fp,	#444
    add	w17,	w2,	w20
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    asr	w3,	w17,	#30
    lsl	w5,	w3,	#30
    sub	w16,	w4,	w5
    add	w1,	w11,	w16
    cmp	w27,	#80
    blt	main_276

main_433:
    add	w14,	w18,	w26
    add	w16,	w10,	w12
    add	w21,	w1,	w19
    movz	fp,	#448
    add	w4,	w28,	#64
    add	w18,	w7,	w15
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w7,	w7,	w6
    cmp	w4,	w23
    blt	main_62

main_441:
    movz	fp,	#528
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#536
    str	w14,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#520
    str	w16,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#512
    str	w21,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#544
    str	w18,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w7,	[x23]


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

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w1,	w6
    b	main_28

main_62:
    mov	w26,	w14
    mov	w12,	w16
    mov	w19,	w21
    mov	w15,	w18
    mov	w6,	w7
    mov	w28,	w4
    b	main_63

main_276:
    mov	w16,	w18
    movz	fp,	#444
    mov	w13,	w10
    mov	w11,	w7
    movk	fp,	#2,	lsl #16
    mov	w10,	w1
    str	w16,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    mov	w3,	w9
    movk	fp,	#2,	lsl #16
    mov	w9,	w27
    str	w9,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#496
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


