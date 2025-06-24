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
    movz	w24,	#0
    movz	w23,	#0
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
    mov	w19,	w0
    bl	getint
    mov	w27,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	w5,	#0
    movz	w4,	#0
    movz	w6,	#0
    movz	fp,	#356
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#456
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
    movz	fp,	#440
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x26,	x21
    add	x8,	x21,	#12
    add	x16,	x21,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x21,	#4
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#448
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x21,	#8
    str	x25,	[sp, fp]

    movz	fp,	#628
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#596
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#588
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#604
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#384
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#424
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#424
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#424
    add	w1,	w15,	w17
    movk	fp,	#2,	lsl #16
    asr	w18,	w1,	#31
    lsr	w19,	w18,	#15
    add	w21,	w1,	w19
    asr	w19,	w21,	#17
    add	w3,	w1,	w19
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
    movz	w21,	#128
    movz	fp,	#448
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w24,	w16,	#31
    lsr	w25,	w24,	#26
    add	w26,	w16,	w25
    asr	w0,	w26,	#6
    lsl	w2,	w0,	#6
    sub	w25,	w16,	w2
    cmp	w25,	#60
    beq	main_53

main_50:
    lsl	w3,	w16,	#2
    movz	fp,	#440
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
    movz	fp,	#440
    movz	w27,	#0
    add	w22,	w16,	#1
    movz	w25,	#0
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#440
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    str	w27,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#440
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    ldr	x0,	[sp, fp]

    add	w25,	w16,	#2
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    add	w0,	w16,	#3
    str	w23,	[x22]

    lsl	w25,	w0,	#2
    add	w22,	w16,	#4
    ldr	x1,	[sp, fp]

    movz	fp,	#628
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w1,	#0
    movz	w17,	#8961
    movz	w26,	#43913
    movz	w5,	#56574
    movz	w6,	#21622
    movz	w19,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w19,	#50130,	lsl #16
    mov	w11,	w17
    mov	w3,	w26
    mov	w21,	w5
    mov	w0,	w19
    mov	w17,	w6

main_63:
    movz	w23,	#0
    mov	w26,	w1
    mov	w14,	w23

main_70:
    cmp	w14,	#14
    bge	main_215

main_74:
    lsl	w19,	w14,	#2
    lsl	w8,	w26,	#2
    movz	fp,	#440
    add	w15,	w26,	#2
    add	w10,	w26,	#3
    add	w14,	w14,	#1
    mov	x19,	x19
    movk	fp,	#2,	lsl #16
    add	x19,	sp,	x19
    lsl	w16,	w10,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#440
    add	x7,	x4,	x8
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    add	w4,	w26,	#1
    ldr	w9,	[x7]

    ldr	x13,	[sp, fp]

    lsl	w18,	w9,	#24
    lsl	w23,	w4,	#2
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    add	x5,	x13,	x23
    ldr	w8,	[x5]

    ldr	x27,	[sp, fp]

    lsl	w9,	w8,	#16
    movz	fp,	#440
    add	w12,	w9,	w18
    movk	fp,	#2,	lsl #16
    lsl	w9,	w15,	#2
    add	w15,	w26,	#4
    add	x24,	x27,	x9
    add	w2,	w15,	#1
    ldr	w5,	[x24]

    add	w24,	w15,	#2
    ldr	x4,	[sp, fp]

    lsl	w6,	w5,	#8
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    add	w7,	w12,	w6
    add	x12,	x4,	x16
    add	w16,	w15,	#4
    lsl	w4,	w15,	#2
    ldr	w23,	[x12]

    lsl	w12,	w14,	#2
    add	w10,	w7,	w23
    mov	x8,	x12
    lsl	w12,	w24,	#2
    add	x8,	sp,	x8
    str	w10,	[x19]

    lsl	w19,	w2,	#2
    ldr	x13,	[sp, fp]

    add	x8,	x8,	#16
    movz	fp,	#440
    add	x27,	x13,	x4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x27]

    lsl	w25,	w5,	#24
    ldr	x5,	[sp, fp]

    movz	fp,	#440
    add	x5,	x5,	x19
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x5]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#440
    add	x4,	x7,	x12
    add	w19,	w10,	w25
    movk	fp,	#2,	lsl #16
    add	w12,	w15,	#3
    ldr	w7,	[x4]

    ldr	x13,	[sp, fp]

    lsl	w9,	w7,	#8
    lsl	w23,	w12,	#2
    movz	fp,	#440
    add	w24,	w19,	w9
    movk	fp,	#2,	lsl #16
    add	x13,	x13,	x23
    add	w9,	w14,	#1
    ldr	w25,	[x13]

    lsl	w12,	w9,	#2
    add	w7,	w24,	w25
    add	w24,	w16,	#2
    str	w7,	[x8]

    ldr	x4,	[sp, fp]

    lsl	w8,	w16,	#2
    mov	x7,	x12
    movz	fp,	#440
    add	x5,	x4,	x8
    add	w12,	w16,	#1
    add	x7,	sp,	x7
    movk	fp,	#2,	lsl #16
    add	w8,	w16,	#3
    lsl	w4,	w24,	#2
    ldr	w10,	[x5]

    lsl	w15,	w12,	#2
    add	x7,	x7,	#16
    ldr	x20,	[sp, fp]

    lsl	w5,	w10,	#24
    movz	fp,	#440
    add	x13,	x20,	x15
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x13]

    ldr	x23,	[sp, fp]

    lsl	w18,	w15,	#16
    movz	fp,	#440
    add	x25,	x23,	x4
    add	w15,	w9,	#1
    add	w18,	w18,	w5
    movk	fp,	#2,	lsl #16
    add	w23,	w16,	#4
    lsl	w4,	w8,	#2
    ldr	w2,	[x25]

    ldr	x8,	[sp, fp]

    lsl	w5,	w2,	#8
    add	w9,	w23,	#1
    movz	fp,	#440
    add	x24,	x8,	x4
    add	w6,	w18,	w5
    movk	fp,	#2,	lsl #16
    lsl	w4,	w15,	#2
    lsl	w14,	w9,	#2
    mov	x10,	x4
    ldr	w5,	[x24]

    lsl	w4,	w23,	#2
    add	x10,	sp,	x10
    add	w12,	w6,	w5
    add	x10,	x10,	#16
    str	w12,	[x7]

    ldr	x13,	[sp, fp]

    movz	fp,	#440
    add	x27,	x13,	x4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x27]

    add	w27,	w23,	#3
    ldr	x8,	[sp, fp]

    lsl	w5,	w5,	#24
    movz	fp,	#440
    add	x12,	x8,	x14
    movk	fp,	#2,	lsl #16
    add	w8,	w23,	#2
    ldr	w18,	[x12]

    ldr	x16,	[sp, fp]

    lsl	w12,	w8,	#2
    lsl	w24,	w18,	#16
    movz	fp,	#440
    add	w8,	w15,	#1
    add	x9,	x16,	x12
    add	w4,	w24,	w5
    movk	fp,	#2,	lsl #16
    lsl	w5,	w27,	#2
    add	w26,	w8,	#1
    ldr	w14,	[x9]

    ldr	x16,	[sp, fp]

    lsl	w18,	w14,	#8
    movz	fp,	#440
    add	x2,	x16,	x5
    add	w7,	w4,	w18
    movk	fp,	#2,	lsl #16
    lsl	w5,	w8,	#2
    ldr	w6,	[x2]

    mov	x19,	x5
    add	w7,	w7,	w6
    add	x19,	sp,	x19
    str	w7,	[x10]

    add	x19,	x19,	#16
    add	w10,	w23,	#4
    ldr	x23,	[sp, fp]

    movz	fp,	#440
    lsl	w5,	w10,	#2
    add	w2,	w10,	#2
    add	w14,	w10,	#1
    movk	fp,	#2,	lsl #16
    add	x4,	x23,	x5
    lsl	w14,	w14,	#2
    ldr	w7,	[x4]

    lsl	w4,	w2,	#2
    ldr	x20,	[sp, fp]

    lsl	w9,	w7,	#24
    movz	fp,	#440
    add	x15,	x20,	x14
    movk	fp,	#2,	lsl #16
    ldr	w18,	[x15]

    lsl	w15,	w26,	#2
    ldr	x16,	[sp, fp]

    lsl	w24,	w18,	#16
    mov	x14,	x15
    movz	fp,	#440
    add	x5,	x16,	x4
    add	w24,	w24,	w9
    add	x14,	sp,	x14
    movk	fp,	#2,	lsl #16
    add	w4,	w10,	#3
    ldr	w9,	[x5]

    add	x14,	x14,	#16
    ldr	x27,	[sp, fp]

    lsl	w7,	w4,	#2
    lsl	w16,	w9,	#8
    movz	fp,	#440
    add	x5,	x27,	x7
    add	w13,	w24,	w16
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x5]

    add	w5,	w10,	#4
    add	w9,	w13,	w9
    add	w12,	w5,	#2
    lsl	w25,	w5,	#2
    add	w13,	w5,	#1
    str	w9,	[x19]

    ldr	x8,	[sp, fp]

    movz	fp,	#440
    add	x19,	x8,	x25
    lsl	w9,	w13,	#2
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x19]

    ldr	x28,	[sp, fp]

    lsl	w7,	w27,	#24
    movz	fp,	#440
    add	x18,	x28,	x9
    add	w27,	w5,	#3
    movk	fp,	#2,	lsl #16
    lsl	w9,	w12,	#2
    ldr	w4,	[x18]

    ldr	x12,	[sp, fp]

    lsl	w6,	w4,	#16
    movz	fp,	#440
    add	x13,	x12,	x9
    add	w8,	w6,	w7
    movk	fp,	#2,	lsl #16
    lsl	w7,	w27,	#2
    ldr	w18,	[x13]

    add	w13,	w5,	#4
    ldr	x12,	[sp, fp]

    lsl	w23,	w18,	#8
    movz	fp,	#440
    add	x6,	x12,	x7
    movk	fp,	#2,	lsl #16
    lsl	w5,	w13,	#2
    add	w24,	w8,	w23
    add	w12,	w13,	#3
    ldr	w10,	[x6]

    add	w4,	w24,	w10
    str	w4,	[x14]

    add	w14,	w13,	#2
    ldr	x18,	[sp, fp]

    add	w4,	w26,	#1
    movz	fp,	#440
    add	x19,	x18,	x5
    add	w26,	w13,	#4
    movk	fp,	#2,	lsl #16
    lsl	w9,	w4,	#2
    ldr	w6,	[x19]

    mov	x8,	x9
    add	w19,	w13,	#1
    lsl	w18,	w6,	#24
    add	x8,	sp,	x8
    lsl	w15,	w19,	#2
    add	x8,	x8,	#16
    ldr	x19,	[sp, fp]

    movz	fp,	#440
    add	x24,	x19,	x15
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    ldr	x19,	[sp, fp]

    lsl	w2,	w27,	#16
    movz	fp,	#440
    lsl	w27,	w14,	#2
    add	w7,	w2,	w18
    movk	fp,	#2,	lsl #16
    add	x15,	x19,	x27
    ldr	w24,	[x15]

    ldr	x23,	[sp, fp]

    lsl	w15,	w12,	#2
    lsl	w5,	w24,	#8
    add	x14,	x23,	x15
    add	w6,	w7,	w5
    add	w5,	w4,	#1
    ldr	w16,	[x14]

    mov	w14,	w5
    add	w10,	w6,	w16
    str	w10,	[x8]

    b	main_70

main_215:
    mov	w24,	w26
    mov	w6,	w14

main_217:
    lsl	w10,	w6,	#2
    lsl	w15,	w24,	#2
    movz	fp,	#440
    add	w7,	w24,	#1
    add	w2,	w6,	#1
    mov	x9,	x10
    movk	fp,	#2,	lsl #16
    add	x9,	sp,	x9
    lsl	w4,	w7,	#2
    ldr	x8,	[sp, fp]

    add	x9,	x9,	#16
    movz	fp,	#440
    add	x16,	x8,	x15
    movk	fp,	#2,	lsl #16
    ldr	w23,	[x16]

    ldr	x7,	[sp, fp]

    lsl	w27,	w23,	#24
    movz	fp,	#440
    add	x10,	x7,	x4
    movk	fp,	#2,	lsl #16
    add	w7,	w24,	#3
    add	w4,	w24,	#2
    ldr	w13,	[x10]

    lsl	w25,	w7,	#2
    ldr	x8,	[sp, fp]

    lsl	w18,	w4,	#2
    lsl	w16,	w13,	#16
    movz	fp,	#440
    add	x5,	x8,	x18
    add	w16,	w16,	w27
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x5]

    lsl	w13,	w12,	#8
    ldr	x12,	[sp, fp]

    add	w13,	w16,	w13
    add	x10,	x12,	x25
    add	w25,	w24,	#4
    ldr	w18,	[x10]

    add	w26,	w13,	w18
    str	w26,	[x9]

    cmp	w2,	#16
    bge	main_241

main_216:
    mov	w24,	w25
    mov	w6,	w2
    b	main_217

main_241:
    mov	w15,	w2
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    cmp	w10,	#80
    bge	main_275

main_245:
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#496
    lsl	w26,	w12,	#2
    movk	fp,	#2,	lsl #16
    mov	x23,	x26
    add	x23,	sp,	x23
    ldr	w26,	[sp, fp]

    movz	fp,	#496
    sub	w2,	w26,	#3
    add	x23,	x23,	#16
    movk	fp,	#2,	lsl #16
    lsl	w6,	w2,	#2
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w5,	[sp, fp]

    movz	fp,	#496
    sub	w9,	w5,	#8
    movk	fp,	#2,	lsl #16
    lsl	w12,	w9,	#2
    mov	x10,	x12
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w13,	[x10]

    ldr	w6,	[sp, fp]

    add	w10,	w13,	w7
    movz	fp,	#496
    sub	w26,	w6,	#14
    movk	fp,	#2,	lsl #16
    sub	w15,	w7,	w10
    lsl	w4,	w26,	#2
    mov	x2,	x4
    add	w19,	w15,	w13
    add	x2,	sp,	x2
    sub	w10,	w19,	w10
    add	x2,	x2,	#16
    ldr	w6,	[x2]

    add	w4,	w6,	w10
    sub	w7,	w10,	w4
    add	w13,	w7,	w6
    ldr	w7,	[sp, fp]

    movz	fp,	#496
    sub	w27,	w13,	w4
    movk	fp,	#2,	lsl #16
    sub	w4,	w7,	#16
    lsl	w7,	w4,	#2
    mov	x5,	x7
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w8,	[x5]

    add	w7,	w8,	w27
    sub	w13,	w27,	w7
    add	w14,	w13,	w8
    sub	w18,	w14,	w7
    asr	w4,	w18,	#31
    lsl	w12,	w18,	#1
    lsr	w5,	w4,	#31
    add	w7,	w18,	w5
    asr	w14,	w7,	#1
    lsl	w16,	w14,	#1
    sub	w8,	w18,	w16
    add	w9,	w12,	w8
    str	w9,	[x23]

    ldr	w18,	[sp, fp]

    movz	fp,	#496
    add	w10,	w18,	#1
    movk	fp,	#2,	lsl #16
    mov	w9,	w10
    str	w9,	[sp, fp]

    b	main_242

main_275:
    mov	w27,	w11
    movz	fp,	#432
    mov	w4,	w3
    mov	w13,	w17
    movz	w9,	#0
    movk	fp,	#2,	lsl #16
    mov	w5,	w9
    str	w27,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    mov	w4,	w0
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    str	w21,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]


main_277:
    movz	w6,	#48348
    movz	w15,	#60289
    movz	w2,	#31129
    movz	w26,	#65535
    movz	fp,	#416
    movk	w6,	#36635,	lsl #16
    movk	w15,	#28377,	lsl #16
    movk	w2,	#23170,	lsl #16
    movk	w26,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w24,	w6
    mov	w12,	w15
    mov	w9,	w2
    mov	w19,	w26
    ldr	w18,	[sp, fp]

    movz	w6,	#49414
    movk	w6,	#51810,	lsl #16
    mov	w5,	w6
    cmp	w18,	#20
    bge	main_296

main_285:
    movz	fp,	#428
    mov	w6,	w19
    mov	w27,	w9
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#428
    add	w13,	w26,	w20
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#420
    sub	w6,	w6,	w16
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    add	w16,	w23,	w6
    add	w18,	w16,	w13
    sub	w15,	w13,	w18
    add	w2,	w15,	w16
    sub	w15,	w2,	w18
    sub	w6,	w15,	w2
    add	w16,	w6,	w18
    sub	w13,	w16,	w2
    b	main_416

main_296:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    cmp	w20,	#40
    bge	main_307

main_298:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    add	w13,	w2,	w25
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#436
    sub	w8,	w23,	w13
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#420
    add	w27,	w8,	w10
    movk	fp,	#2,	lsl #16
    sub	w27,	w27,	w13
    ldr	w10,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    add	w6,	w10,	w27
    ldr	w28,	[sp, fp]

    sub	w8,	w27,	w6
    mov	w27,	w12
    add	w8,	w8,	w28
    sub	w13,	w8,	w6
    mov	w15,	w13
    b	main_413

main_307:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    cmp	w25,	#60
    bge	main_327

main_309:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#420
    add	w2,	w15,	w10
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#420
    add	w26,	w15,	w25
    movk	fp,	#2,	lsl #16
    add	w8,	w26,	w2
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    sub	w16,	w2,	w8
    ldr	w23,	[sp, fp]

    add	w2,	w16,	w26
    add	w26,	w20,	w23
    sub	w6,	w2,	w8
    sub	w15,	w6,	w2
    add	w18,	w15,	w8
    sub	w13,	w18,	w2
    add	w27,	w26,	w13
    sub	w2,	w13,	w27
    add	w13,	w2,	w26
    sub	w6,	w13,	w27
    sub	w6,	w6,	w13
    add	w16,	w6,	w27
    mov	w27,	w24
    sub	w13,	w16,	w13
    mov	w15,	w13
    b	main_413

main_327:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#428
    add	w6,	w23,	w14
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#436
    sub	w13,	w15,	w6
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#420
    add	w27,	w13,	w25
    movk	fp,	#2,	lsl #16
    sub	w13,	w27,	w6
    ldr	w20,	[sp, fp]

    mov	w27,	w5
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    add	w6,	w20,	w13
    ldr	w15,	[sp, fp]

    sub	w16,	w13,	w6
    add	w13,	w16,	w15
    sub	w13,	w13,	w6
    mov	w15,	w13

main_413:
    mov	w13,	w15

main_416:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#432
    lsl	w15,	w6,	#5
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    asr	w18,	w16,	#31
    movk	fp,	#2,	lsl #16
    lsr	w26,	w18,	#27
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    add	w16,	w20,	w26
    movk	fp,	#2,	lsl #16
    asr	w18,	w16,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#416
    lsl	w26,	w18,	#5
    movk	fp,	#2,	lsl #16
    sub	w16,	w28,	w26
    ldr	w25,	[sp, fp]

    movz	fp,	#428
    lsl	w8,	w25,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x8
    add	w2,	w15,	w16
    add	x18,	sp,	x18
    add	w26,	w2,	w4
    add	x18,	x18,	#16
    add	w13,	w26,	w13
    ldr	w16,	[x18]

    ldr	w20,	[sp, fp]

    movz	fp,	#428
    add	w15,	w13,	w27
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    add	w16,	w15,	w16
    movz	fp,	#428
    asr	w6,	w23,	#31
    lsl	w15,	w20,	#30
    movk	fp,	#2,	lsl #16
    lsr	w26,	w6,	#2
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w18,	w18,	w26
    movk	fp,	#2,	lsl #16
    asr	w13,	w18,	#30
    ldr	w23,	[sp, fp]

    movz	fp,	#416
    lsl	w6,	w13,	#30
    movk	fp,	#2,	lsl #16
    sub	w13,	w23,	w6
    ldr	w23,	[sp, fp]

    add	w27,	w23,	#1
    add	w15,	w15,	w13
    cmp	w27,	#20
    bge	main_364

main_336:
    movz	fp,	#432
    mov	w2,	w19
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    add	w18,	w15,	w4
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#436
    sub	w4,	w2,	w6
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    add	w5,	w14,	w4
    add	w8,	w5,	w18
    sub	w19,	w18,	w8
    add	w18,	w19,	w5
    sub	w19,	w18,	w8
    sub	w23,	w19,	w18
    add	w26,	w23,	w8
    sub	w19,	w26,	w18
    mov	w23,	w19
    b	main_347

main_364:
    cmp	w27,	#40
    bge	main_378

main_366:
    movz	fp,	#432
    mov	w2,	w12
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#432
    add	w19,	w15,	w23
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#436
    sub	w8,	w8,	w19
    movk	fp,	#2,	lsl #16
    add	w4,	w8,	w15
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    sub	w4,	w4,	w19
    ldr	w26,	[sp, fp]

    add	w5,	w20,	w4
    sub	w9,	w4,	w5
    add	w18,	w9,	w26
    sub	w19,	w18,	w5
    b	main_375

main_378:
    cmp	w27,	#60
    bge	main_401

main_380:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#432
    add	w23,	w15,	w25
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#436
    add	w19,	w6,	w10
    movk	fp,	#2,	lsl #16
    add	w4,	w19,	w23
    ldr	w26,	[sp, fp]

    add	w13,	w26,	w15
    sub	w5,	w23,	w4
    add	w9,	w5,	w19
    sub	w19,	w9,	w4
    sub	w5,	w19,	w9
    add	w4,	w5,	w4
    mov	w5,	w24
    sub	w6,	w4,	w9
    add	w4,	w13,	w6
    sub	w12,	w6,	w4
    add	w12,	w12,	w13
    sub	w18,	w12,	w4
    sub	w26,	w18,	w12
    add	w4,	w26,	w4
    sub	w18,	w4,	w12
    mov	w23,	w18
    b	main_398

main_401:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    add	w19,	w15,	w7
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#436
    sub	w9,	w23,	w19
    movk	fp,	#2,	lsl #16
    add	w12,	w9,	w15
    ldr	w4,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    sub	w6,	w12,	w19
    ldr	w13,	[sp, fp]

    add	w19,	w4,	w6
    sub	w12,	w6,	w19
    add	w4,	w12,	w13
    sub	w19,	w4,	w19
    mov	w23,	w19

main_398:
    mov	w19,	w23
    mov	w2,	w5

main_375:
    mov	w23,	w19
    mov	w9,	w2

main_347:
    lsl	w19,	w16,	#5
    asr	w5,	w16,	#31
    lsl	w25,	w27,	#2
    movz	fp,	#420
    lsr	w8,	w5,	#27
    mov	x18,	x25
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    add	w12,	w16,	w8
    add	x18,	x18,	#16
    asr	w8,	w12,	#5
    ldr	w4,	[x18]

    lsl	w12,	w8,	#5
    ldr	w25,	[sp, fp]

    sub	w12,	w16,	w12
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w12,	w12,	w25
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w13,	w12,	w19
    ldr	w28,	[sp, fp]

    movz	fp,	#432
    asr	w18,	w28,	#31
    add	w6,	w13,	w23
    movk	fp,	#2,	lsl #16
    lsr	w25,	w18,	#2
    ldr	w5,	[sp, fp]

    add	w12,	w6,	w9
    movz	fp,	#432
    add	w5,	w5,	w25
    movk	fp,	#2,	lsl #16
    add	w24,	w12,	w4
    asr	w8,	w5,	#30
    lsl	w12,	w10,	#30
    add	w5,	w27,	#1
    lsl	w13,	w8,	#30
    ldr	w8,	[sp, fp]

    sub	w14,	w8,	w13
    add	w2,	w12,	w14
    cmp	w5,	#80
    blt	main_276

main_433:
    add	w18,	w24,	w11
    add	w5,	w16,	w3
    add	w27,	w2,	w21
    add	w19,	w15,	w17
    movz	fp,	#436
    add	w8,	w1,	#64
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    add	w0,	w9,	w0
    cmp	w8,	w22
    blt	main_62

main_441:
    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#620
    str	w18,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#596
    str	w5,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#588
    str	w27,	[x13]

    movk	fp,	#2,	lsl #16
    movz	w27,	#0
    ldr	x22,	[sp, fp]

    movz	fp,	#604
    str	w19,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w0,	[x23]


main_442:
    cmp	w27,	#5
    bge	main_455

main_445:
    lsl	w16,	w27,	#2
    movz	fp,	#356
    lsl	w11,	w27,	#2
    mov	x23,	x16
    movk	fp,	#2,	lsl #16
    add	w27,	w27,	#1
    mov	x10,	x11
    add	x23,	sp,	x23
    add	x10,	sp,	x10
    add	x23,	x23,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x23]

    add	x10,	x10,	fp
    ldr	w15,	[x10]

    add	w5,	w15,	w16
    sub	w0,	w16,	w5
    add	w16,	w0,	w15
    sub	w21,	w16,	w5
    str	w21,	[x23]

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

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w18
    mov	w3,	w5
    mov	w21,	w27
    mov	w17,	w19
    mov	w1,	w8
    b	main_63

main_276:
    mov	w20,	w24
    movz	fp,	#432
    mov	w4,	w16
    mov	w12,	w5
    movk	fp,	#2,	lsl #16
    mov	w16,	w15
    str	w20,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#416
    mov	w4,	w14
    movk	fp,	#2,	lsl #16
    mov	w14,	w2
    str	w12,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#456
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


