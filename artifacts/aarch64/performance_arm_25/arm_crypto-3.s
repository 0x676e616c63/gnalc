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
    mov	w26,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	fp,	#356
    movz	w6,	#0
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#528
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#528
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
    movz	fp,	#436
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x27,	x20
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

    movz	fp,	#520
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w26
    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w1
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
    movz	fp,	#520
    movz	w27,	#32001
    movk	fp,	#2,	lsl #16
    mov	w3,	w27
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


main_46:
    asr	w23,	w3,	#31
    lsr	w24,	w23,	#26
    add	w26,	w3,	w24
    asr	w27,	w26,	#6
    lsl	w0,	w27,	#6
    sub	w24,	w3,	w0
    cmp	w24,	#60
    beq	main_53

main_50:
    lsl	w1,	w3,	#2
    movz	fp,	#436
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
    movz	fp,	#436
    movz	w27,	#0
    add	w21,	w3,	#1
    movz	w24,	#0
    movz	w22,	#125
    add	w20,	w3,	#4
    movk	fp,	#2,	lsl #16
    lsl	w26,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x23,	x28,	x2
    movk	fp,	#2,	lsl #16
    str	w27,	[x23]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x26
    movk	fp,	#2,	lsl #16
    str	w24,	[x1]

    ldr	x0,	[sp, fp]

    add	w24,	w3,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w24,	#2
    add	x19,	x0,	x2
    movz	w2,	#0
    add	w0,	w3,	#3
    str	w22,	[x19]

    lsl	w24,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#512
    add	x23,	x1,	x24
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x23]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w17,	#8961
    movz	w24,	#43913
    movz	w19,	#57840
    movz	w5,	#56574
    movz	w4,	#21622
    movk	w17,	#26437,	lsl #16
    movk	w24,	#61389,	lsl #16
    movk	w19,	#50130,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w4,	#4146,	lsl #16
    mov	w2,	w17
    mov	w12,	w24
    mov	w0,	w19
    mov	w16,	w5
    mov	w27,	w4
    movz	w24,	#0

main_63:
    movz	w19,	#0
    mov	w23,	w24
    mov	w13,	w19

main_70:
    cmp	w13,	#14
    bge	main_215

main_74:
    lsl	w19,	w13,	#2
    lsl	w7,	w23,	#2
    movz	fp,	#436
    add	w3,	w23,	#1
    add	w13,	w13,	#1
    mov	x17,	x19
    movk	fp,	#2,	lsl #16
    add	x17,	sp,	x17
    lsl	w21,	w3,	#2
    ldr	x1,	[sp, fp]

    add	x17,	x17,	#16
    movz	fp,	#436
    add	x6,	x1,	x7
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x6]

    ldr	x11,	[sp, fp]

    lsl	w14,	w8,	#24
    movz	fp,	#436
    add	x5,	x11,	x21
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x5]

    ldr	x26,	[sp, fp]

    lsl	w8,	w7,	#16
    movz	fp,	#436
    add	w10,	w8,	w14
    movk	fp,	#2,	lsl #16
    add	w14,	w23,	#2
    lsl	w8,	w14,	#2
    add	w14,	w23,	#4
    add	x22,	x26,	x8
    add	w8,	w23,	#3
    add	w18,	w14,	#2
    ldr	w3,	[x22]

    lsl	w11,	w8,	#2
    ldr	x1,	[sp, fp]

    lsl	w4,	w3,	#8
    lsl	w8,	w13,	#2
    movz	fp,	#436
    mov	x7,	x8
    add	w6,	w10,	w4
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    add	x10,	x1,	x11
    lsl	w1,	w14,	#2
    ldr	w15,	[x10]

    add	x7,	x7,	#16
    add	w9,	w6,	w15
    str	w9,	[x17]

    ldr	x10,	[sp, fp]

    movz	fp,	#436
    add	x26,	x10,	x1
    movk	fp,	#2,	lsl #16
    lsl	w10,	w18,	#2
    add	w1,	w14,	#1
    ldr	w3,	[x26]

    lsl	w23,	w3,	#24
    lsl	w15,	w1,	#2
    ldr	x3,	[sp, fp]

    add	w1,	w14,	#4
    movz	fp,	#436
    add	x3,	x3,	x15
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    ldr	x4,	[sp, fp]

    lsl	w8,	w5,	#16
    movz	fp,	#436
    add	x3,	x4,	x10
    add	w15,	w8,	w23
    movk	fp,	#2,	lsl #16
    add	w10,	w14,	#3
    ldr	w6,	[x3]

    lsl	w8,	w6,	#8
    lsl	w18,	w10,	#2
    add	w6,	w13,	#1
    add	w21,	w15,	w8
    ldr	x10,	[sp, fp]

    add	w15,	w1,	#3
    lsl	w8,	w1,	#2
    movz	fp,	#436
    add	x11,	x10,	x18
    movk	fp,	#2,	lsl #16
    ldr	w23,	[x11]

    lsl	w11,	w6,	#2
    add	w4,	w21,	w23
    mov	x10,	x11
    add	w23,	w1,	#2
    add	w11,	w1,	#1
    add	x10,	sp,	x10
    str	w4,	[x7]

    ldr	x4,	[sp, fp]

    lsl	w26,	w11,	#2
    add	x10,	x10,	#16
    movz	fp,	#436
    add	x7,	x4,	x8
    movk	fp,	#2,	lsl #16
    lsl	w4,	w23,	#2
    ldr	w9,	[x7]

    ldr	x18,	[sp, fp]

    lsl	w7,	w9,	#24
    movz	fp,	#436
    add	x14,	x18,	x26
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    ldr	x21,	[sp, fp]

    lsl	w18,	w17,	#16
    movz	fp,	#436
    add	x3,	x21,	x4
    add	w19,	w18,	w7
    movk	fp,	#2,	lsl #16
    lsl	w4,	w15,	#2
    ldr	w5,	[x3]

    add	w15,	w6,	#1
    lsl	w9,	w5,	#8
    add	w5,	w19,	w9
    ldr	x9,	[sp, fp]

    movz	fp,	#436
    add	x18,	x9,	x4
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x18]

    add	w18,	w1,	#4
    add	w13,	w5,	w8
    lsl	w1,	w15,	#2
    mov	x9,	x1
    str	w13,	[x10]

    add	w6,	w18,	#1
    lsl	w1,	w18,	#2
    add	x9,	sp,	x9
    ldr	x11,	[sp, fp]

    lsl	w10,	w6,	#2
    movz	fp,	#436
    add	x9,	x9,	#16
    add	x26,	x11,	x1
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x26]

    add	w26,	w18,	#3
    ldr	x7,	[sp, fp]

    lsl	w3,	w3,	#24
    movz	fp,	#436
    add	x8,	x7,	x10
    movk	fp,	#2,	lsl #16
    add	w7,	w18,	#2
    ldr	w13,	[x8]

    lsl	w10,	w7,	#2
    ldr	x14,	[sp, fp]

    lsl	w17,	w13,	#16
    movz	fp,	#436
    add	x8,	x14,	x10
    movk	fp,	#2,	lsl #16
    add	w3,	w17,	w3
    ldr	w13,	[x8]

    ldr	x14,	[sp, fp]

    lsl	w17,	w13,	#8
    movz	fp,	#436
    add	w6,	w3,	w17
    movk	fp,	#2,	lsl #16
    lsl	w3,	w26,	#2
    add	x1,	x14,	x3
    ldr	w4,	[x1]

    add	w4,	w6,	w4
    add	w6,	w15,	#1
    str	w4,	[x9]

    add	w10,	w6,	#1
    lsl	w5,	w6,	#2
    add	w9,	w18,	#4
    mov	x19,	x5
    ldr	x18,	[sp, fp]

    add	x19,	sp,	x19
    lsl	w21,	w10,	#2
    movz	fp,	#436
    add	w1,	w9,	#2
    add	w13,	w9,	#1
    lsl	w5,	w9,	#2
    add	x19,	x19,	#16
    mov	x4,	x21
    movk	fp,	#2,	lsl #16
    lsl	w1,	w1,	#2
    lsl	w13,	w13,	#2
    add	x3,	x18,	x5
    add	x4,	sp,	x4
    ldr	w7,	[x3]

    add	x4,	x4,	#16
    ldr	x18,	[sp, fp]

    lsl	w8,	w7,	#24
    movz	fp,	#436
    add	x14,	x18,	x13
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    ldr	x15,	[sp, fp]

    lsl	w18,	w17,	#16
    movz	fp,	#436
    add	x3,	x15,	x1
    add	w18,	w18,	w8
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    ldr	x26,	[sp, fp]

    add	w3,	w9,	#3
    lsl	w13,	w5,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w7,	w3,	#2
    add	w11,	w18,	w13
    add	w13,	w9,	#4
    add	x5,	x26,	x7
    add	w14,	w13,	#1
    lsl	w23,	w13,	#2
    ldr	w8,	[x5]

    add	w8,	w11,	w8
    lsl	w9,	w14,	#2
    add	w14,	w13,	#2
    str	w8,	[x19]

    ldr	x3,	[sp, fp]

    lsl	w8,	w14,	#2
    movz	fp,	#436
    add	x22,	x3,	x23
    movk	fp,	#2,	lsl #16
    ldr	w26,	[x22]

    ldr	x28,	[sp, fp]

    lsl	w5,	w26,	#24
    movz	fp,	#436
    add	x15,	x28,	x9
    add	w26,	w13,	#3
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x15]

    lsl	w7,	w3,	#16
    add	w7,	w7,	w5
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x17,	x5,	x8
    movk	fp,	#2,	lsl #16
    lsl	w5,	w26,	#2
    ldr	w19,	[x17]

    ldr	x11,	[sp, fp]

    lsl	w23,	w19,	#8
    movz	fp,	#436
    add	x3,	x11,	x5
    add	w21,	w7,	w23
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x3]

    add	w3,	w10,	#1
    add	w1,	w21,	w6
    add	w6,	w13,	#4
    str	w1,	[x4]

    lsl	w9,	w3,	#2
    add	w23,	w6,	#4
    add	w11,	w6,	#2
    add	w18,	w6,	#1
    ldr	x17,	[sp, fp]

    lsl	w4,	w6,	#2
    mov	x7,	x9
    movz	fp,	#436
    add	x7,	sp,	x7
    lsl	w14,	w18,	#2
    add	x15,	x17,	x4
    movk	fp,	#2,	lsl #16
    add	x7,	x7,	#16
    ldr	w8,	[x15]

    ldr	x18,	[sp, fp]

    lsl	w17,	w8,	#24
    movz	fp,	#436
    add	x19,	x18,	x14
    movk	fp,	#2,	lsl #16
    ldr	w26,	[x19]

    ldr	x18,	[sp, fp]

    lsl	w1,	w26,	#16
    movz	fp,	#436
    lsl	w26,	w11,	#2
    add	w4,	w1,	w17
    movk	fp,	#2,	lsl #16
    add	w11,	w6,	#3
    add	x14,	x18,	x26
    ldr	w18,	[x14]

    ldr	x21,	[sp, fp]

    lsl	w14,	w11,	#2
    lsl	w5,	w18,	#8
    add	x13,	x21,	x14
    add	w5,	w4,	w5
    ldr	w15,	[x13]

    add	w10,	w5,	w15
    add	w5,	w3,	#1
    mov	w13,	w5
    str	w10,	[x7]

    b	main_70

main_215:
    mov	w21,	w23
    mov	w4,	w13

main_217:
    lsl	w9,	w4,	#2
    lsl	w14,	w21,	#2
    movz	fp,	#436
    add	w5,	w21,	#1
    add	w3,	w21,	#2
    mov	x8,	x9
    movk	fp,	#2,	lsl #16
    add	x8,	sp,	x8
    lsl	w1,	w5,	#2
    ldr	x7,	[sp, fp]

    add	w5,	w21,	#3
    add	x8,	x8,	#16
    movz	fp,	#436
    add	x15,	x7,	x14
    movk	fp,	#2,	lsl #16
    lsl	w23,	w5,	#2
    lsl	w14,	w3,	#2
    ldr	w22,	[x15]

    ldr	x7,	[sp, fp]

    lsl	w26,	w22,	#24
    movz	fp,	#436
    add	x6,	x7,	x1
    add	w22,	w21,	#4
    movk	fp,	#2,	lsl #16
    ldr	w11,	[x6]

    ldr	x7,	[sp, fp]

    lsl	w13,	w11,	#16
    movz	fp,	#436
    add	x6,	x7,	x14
    add	w13,	w13,	w26
    movk	fp,	#2,	lsl #16
    add	w26,	w4,	#1
    ldr	w10,	[x6]

    lsl	w11,	w10,	#8
    ldr	x10,	[sp, fp]

    add	w11,	w13,	w11
    add	x6,	x10,	x23
    ldr	w14,	[x6]

    add	w23,	w11,	w14
    str	w23,	[x8]

    cmp	w26,	#16
    bge	main_241

main_216:
    mov	w21,	w22
    mov	w4,	w26
    b	main_217

main_241:
    mov	w14,	w26
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
    lsl	w22,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x19,	x22
    add	x19,	sp,	x19
    ldr	w25,	[sp, fp]

    movz	fp,	#476
    sub	w26,	w25,	#3
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    lsl	w4,	w26,	#2
    mov	x1,	x4
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w6,	[x1]

    ldr	w4,	[sp, fp]

    movz	fp,	#476
    sub	w8,	w4,	#8
    movk	fp,	#2,	lsl #16
    lsl	w10,	w8,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w11,	[x9]

    ldr	w5,	[sp, fp]

    add	w9,	w11,	w6
    movz	fp,	#476
    sub	w23,	w5,	#14
    movk	fp,	#2,	lsl #16
    sub	w14,	w6,	w9
    lsl	w1,	w23,	#2
    mov	x26,	x1
    add	w21,	w14,	w11
    add	x26,	sp,	x26
    sub	w9,	w21,	w9
    add	x26,	x26,	#16
    ldr	w3,	[x26]

    ldr	w6,	[sp, fp]

    add	w1,	w3,	w9
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    sub	w5,	w9,	w1
    add	w9,	w5,	w3
    sub	w3,	w6,	#16
    sub	w23,	w9,	w1
    lsl	w6,	w3,	#2
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    add	w6,	w7,	w23
    sub	w11,	w23,	w6
    add	w13,	w11,	w7
    sub	w15,	w13,	w6
    asr	w3,	w15,	#31
    lsl	w8,	w15,	#1
    lsr	w5,	w3,	#31
    add	w6,	w15,	w5
    asr	w13,	w6,	#1
    lsl	w14,	w13,	#1
    sub	w7,	w15,	w14
    add	w8,	w8,	w7
    str	w8,	[x19]

    ldr	w17,	[sp, fp]

    movz	fp,	#476
    add	w9,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w9
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w23,	w2
    movz	fp,	#428
    mov	w5,	w12
    mov	w18,	w16
    mov	w11,	w27
    mov	w6,	w0
    movz	w7,	#0
    movk	fp,	#2,	lsl #16
    mov	w1,	w7
    str	w23,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]


main_277:
    movz	w5,	#48348
    movz	w15,	#60289
    movz	w7,	#49414
    movz	w4,	#31129
    movz	w23,	#65535
    movz	fp,	#404
    movk	w5,	#36635,	lsl #16
    movk	w15,	#28377,	lsl #16
    movk	w7,	#51810,	lsl #16
    movk	w4,	#23170,	lsl #16
    movk	w23,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w21,	w5
    mov	w11,	w15
    mov	w18,	w4
    mov	w17,	w23
    mov	w5,	w7
    ldr	w15,	[sp, fp]

    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#424
    add	w1,	w23,	w19
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#408
    sub	w15,	w17,	w13
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w23,	w19,	w15
    add	w7,	w23,	w1
    sub	w15,	w1,	w7
    add	w4,	w15,	w23
    sub	w1,	w4,	w7
    sub	w15,	w1,	w4
    add	w22,	w15,	w7
    mov	w15,	w18
    sub	w4,	w22,	w4
    mov	w8,	w4
    b	main_416

main_296:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#424
    add	w15,	w28,	w23
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    sub	w22,	w22,	w15
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#408
    add	w4,	w22,	w7
    movk	fp,	#2,	lsl #16
    sub	w23,	w4,	w15
    ldr	w8,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w7,	w8,	w23
    ldr	w28,	[sp, fp]

    sub	w15,	w23,	w7
    mov	w23,	w11
    add	w15,	w15,	w28
    sub	w4,	w15,	w7
    mov	w22,	w4
    b	main_413

main_307:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    cmp	w22,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#408
    add	w1,	w9,	w8
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#408
    add	w23,	w13,	w23
    movk	fp,	#2,	lsl #16
    add	w26,	w23,	w1
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w4,	w1,	w26
    add	w8,	w4,	w23
    mov	w23,	w21
    sub	w13,	w8,	w26
    sub	w15,	w13,	w8
    ldr	w13,	[sp, fp]

    add	w13,	w19,	w13
    add	w4,	w15,	w26
    sub	w15,	w4,	w8
    add	w26,	w13,	w15
    sub	w1,	w15,	w26
    add	w15,	w1,	w13
    sub	w22,	w15,	w26
    sub	w13,	w22,	w15
    add	w22,	w13,	w26
    sub	w4,	w22,	w15
    mov	w22,	w4
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w7,	w19,	w10
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    sub	w15,	w9,	w7
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#408
    add	w13,	w15,	w23
    movk	fp,	#2,	lsl #16
    mov	w23,	w5
    sub	w7,	w13,	w7
    ldr	w19,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w13,	w19,	w7
    ldr	w14,	[sp, fp]

    sub	w1,	w7,	w13
    add	w8,	w1,	w14
    sub	w4,	w8,	w13
    mov	w22,	w4

main_413:
    mov	w8,	w22
    mov	w15,	w23

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    lsl	w22,	w3,	#5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#428
    asr	w26,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w13,	w26,	#27
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w26,	w19,	w13
    movk	fp,	#2,	lsl #16
    asr	w26,	w26,	#5
    lsl	w23,	w26,	#5
    ldr	w26,	[sp, fp]

    movz	fp,	#404
    sub	w26,	w26,	w23
    movk	fp,	#2,	lsl #16
    add	w1,	w22,	w26
    ldr	w25,	[sp, fp]

    movz	fp,	#424
    lsl	w23,	w25,	#2
    movk	fp,	#2,	lsl #16
    mov	x4,	x23
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w23,	[x4]

    ldr	w19,	[sp, fp]

    add	w4,	w1,	w6
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w26,	w4,	w8
    add	w1,	w26,	w15
    lsl	w15,	w19,	#30
    ldr	w19,	[sp, fp]

    add	w8,	w1,	w23
    movz	fp,	#424
    asr	w7,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w23,	w7,	#2
    ldr	w10,	[sp, fp]

    movz	fp,	#424
    add	w26,	w10,	w23
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    asr	w4,	w26,	#30
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    lsl	w7,	w4,	#30
    ldr	w10,	[sp, fp]

    sub	w22,	w19,	w7
    add	w6,	w10,	#1
    add	w22,	w15,	w22
    cmp	w6,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w1,	w17
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w26,	w22,	w3
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w3,	w1,	w7
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    add	w5,	w14,	w3
    add	w13,	w5,	w26
    sub	w19,	w26,	w13
    add	w17,	w19,	w5
    sub	w19,	w17,	w13
    sub	w21,	w19,	w17
    add	w23,	w21,	w13
    sub	w21,	w23,	w17
    mov	w17,	w18
    mov	w26,	w21
    b	main_347

main_364:
    cmp	w6,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    mov	w5,	w11
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w15,	w22,	w18
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    sub	w26,	w9,	w15
    movk	fp,	#2,	lsl #16
    add	w3,	w26,	w22
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w3,	w3,	w15
    ldr	w26,	[sp, fp]

    add	w21,	w17,	w3
    sub	w7,	w3,	w21
    add	w18,	w7,	w26
    sub	w18,	w18,	w21
    b	main_375

main_378:
    cmp	w6,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#428
    add	w26,	w22,	w25
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    add	w19,	w4,	w11
    movk	fp,	#2,	lsl #16
    add	w3,	w19,	w26
    sub	w11,	w26,	w3
    ldr	w26,	[sp, fp]

    add	w13,	w26,	w22
    add	w7,	w11,	w19
    sub	w17,	w7,	w3
    sub	w19,	w17,	w7
    add	w3,	w19,	w3
    sub	w7,	w3,	w7
    add	w4,	w13,	w7
    sub	w15,	w7,	w4
    add	w3,	w15,	w13
    sub	w18,	w3,	w4
    sub	w23,	w18,	w3
    add	w7,	w23,	w4
    sub	w17,	w7,	w3
    mov	w7,	w21
    mov	w19,	w17
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w15,	w22,	w3
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    sub	w11,	w18,	w15
    movk	fp,	#2,	lsl #16
    add	w13,	w11,	w22
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w4,	w13,	w15
    ldr	w11,	[sp, fp]

    add	w19,	w1,	w4
    sub	w15,	w4,	w19
    add	w7,	w15,	w11
    sub	w18,	w7,	w19
    mov	w7,	w5
    mov	w19,	w18

main_398:
    mov	w18,	w19
    mov	w5,	w7

main_375:
    mov	w26,	w18
    mov	w17,	w5

main_347:
    lsl	w1,	w8,	#5
    asr	w7,	w8,	#31
    lsl	w23,	w6,	#2
    movz	fp,	#408
    lsr	w11,	w7,	#27
    mov	x21,	x23
    movk	fp,	#2,	lsl #16
    add	x21,	sp,	x21
    add	w13,	w8,	w11
    add	x21,	x21,	#16
    asr	w13,	w13,	#5
    ldr	w3,	[x21]

    lsl	w18,	w13,	#5
    ldr	w19,	[sp, fp]

    sub	w13,	w8,	w18
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w13,	w13,	w19
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    lsl	w14,	w9,	#30
    movk	fp,	#2,	lsl #16
    add	w13,	w13,	w1
    ldr	w28,	[sp, fp]

    movz	fp,	#428
    add	w18,	w13,	w26
    movk	fp,	#2,	lsl #16
    add	w13,	w18,	w17
    add	w18,	w6,	#1
    add	w19,	w13,	w3
    ldr	w3,	[sp, fp]

    asr	w13,	w28,	#31
    movz	fp,	#428
    lsr	w21,	w13,	#2
    movk	fp,	#2,	lsl #16
    add	w21,	w3,	w21
    asr	w7,	w21,	#30
    lsl	w13,	w7,	#30
    ldr	w7,	[sp, fp]

    sub	w17,	w7,	w13
    add	w23,	w14,	w17
    cmp	w18,	#80
    blt	main_276

main_433:
    add	w3,	w19,	w2
    add	w15,	w8,	w12
    add	w5,	w22,	w27
    movz	fp,	#432
    add	w4,	w24,	#64
    add	w19,	w23,	w16
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    add	w0,	w9,	w0
    cmp	w4,	w20
    blt	main_62

main_441:
    movz	fp,	#496
    movz	w26,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#504
    str	w3,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#488
    str	w15,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#480
    str	w19,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#536
    str	w5,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w0,	[x23]


main_442:
    cmp	w26,	#5
    bge	main_455

main_445:
    lsl	w16,	w26,	#2
    movz	fp,	#356
    lsl	w11,	w26,	#2
    mov	x22,	x16
    movk	fp,	#2,	lsl #16
    add	w26,	w26,	#1
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

    mov	w1,	w6
    b	main_28

main_62:
    mov	w2,	w3
    mov	w12,	w15
    mov	w16,	w19
    mov	w27,	w5
    mov	w24,	w4
    b	main_63

main_276:
    mov	w17,	w19
    movz	fp,	#428
    mov	w15,	w8
    mov	w13,	w22
    mov	w9,	w18
    movk	fp,	#2,	lsl #16
    str	w17,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    mov	w13,	w23
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#404
    mov	w6,	w10
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#528
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


