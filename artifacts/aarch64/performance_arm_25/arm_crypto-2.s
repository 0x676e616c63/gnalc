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
    movz	fp,	#336
    movz	w23,	#0
    movz	w25,	#0
    movz	w24,	#0
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
    mov	w27,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	w5,	#0
    movz	w6,	#0
    movz	w4,	#0
    movz	fp,	#356
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#512
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

    movz	fp,	#504
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#384
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
    mov	x27,	x15
    movk	fp,	#2,	lsl #16
    add	x27,	sp,	x27
    ldr	w0,	[sp, fp]

    add	x27,	x27,	#336
    movz	fp,	#420
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#420
    add	w1,	w14,	w17
    movk	fp,	#2,	lsl #16
    asr	w18,	w1,	#31
    lsr	w19,	w18,	#15
    add	w20,	w1,	w19
    asr	w19,	w20,	#17
    add	w3,	w1,	w19
    lsl	w21,	w3,	#5
    add	w1,	w3,	w21
    asr	w23,	w1,	#31
    lsr	w24,	w23,	#24
    add	w25,	w1,	w24
    asr	w21,	w25,	#8
    lsl	w23,	w21,	#8
    sub	w25,	w1,	w23
    str	w25,	[x27]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w21,	#128
    movz	fp,	#504
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w13,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w25,	w13,	#31
    lsr	w26,	w25,	#26
    add	w0,	w13,	w26
    asr	w1,	w0,	#6
    lsl	w2,	w1,	#6
    sub	w26,	w13,	w2
    cmp	w26,	#60
    beq	main_53

main_50:
    lsl	w3,	w13,	#2
    movz	fp,	#436
    movz	w0,	#0
    add	w12,	w13,	#1
    movk	fp,	#2,	lsl #16
    mov	w13,	w12
    ldr	x5,	[sp, fp]

    add	x6,	x5,	x3
    str	w0,	[x6]

    b	main_46

main_53:
    lsl	w25,	w13,	#2
    movz	fp,	#436
    movz	w27,	#0
    add	w21,	w13,	#1
    add	w26,	w13,	#2
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    lsl	w18,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x24,	x28,	x25
    movk	fp,	#2,	lsl #16
    movz	w25,	#0
    str	w27,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x2,	x0,	x18
    movk	fp,	#2,	lsl #16
    str	w25,	[x2]

    ldr	x0,	[sp, fp]

    lsl	w2,	w26,	#2
    movz	fp,	#436
    add	x21,	x0,	x2
    movk	fp,	#2,	lsl #16
    add	w2,	w13,	#3
    str	w23,	[x21]

    lsl	w25,	w2,	#2
    add	w21,	w13,	#4
    ldr	x1,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#496
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w3,	#0
    movz	w17,	#8961
    movz	w27,	#43913
    movz	w23,	#57840
    movz	w5,	#56574
    movz	w6,	#21622
    mov	w1,	w3
    movk	w17,	#26437,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w23,	#50130,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w2,	w17
    mov	w19,	w27
    mov	w0,	w23
    mov	w14,	w5
    mov	w17,	w6

main_63:
    movz	w23,	#0
    mov	w27,	w1
    mov	w13,	w23

main_70:
    cmp	w13,	#14
    bge	main_215

main_74:
    lsl	w18,	w13,	#2
    lsl	w8,	w27,	#2
    movz	fp,	#436
    add	w4,	w27,	#1
    add	w15,	w27,	#2
    add	w11,	w27,	#3
    mov	x18,	x18
    movk	fp,	#2,	lsl #16
    lsl	w20,	w4,	#2
    add	x18,	sp,	x18
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x7,	x5,	x8
    add	x18,	x18,	#16
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x7]

    ldr	x12,	[sp, fp]

    lsl	w23,	w9,	#24
    movz	fp,	#436
    add	x6,	x12,	x20
    movk	fp,	#2,	lsl #16
    lsl	w20,	w11,	#2
    lsl	w12,	w15,	#2
    ldr	w8,	[x6]

    add	w15,	w27,	#4
    ldr	x26,	[sp, fp]

    lsl	w9,	w8,	#16
    movz	fp,	#436
    add	w10,	w9,	w23
    movk	fp,	#2,	lsl #16
    add	x23,	x26,	x12
    add	w12,	w13,	#1
    ldr	w5,	[x23]

    lsl	w13,	w12,	#2
    ldr	x4,	[sp, fp]

    lsl	w8,	w5,	#8
    mov	x11,	x13
    movz	fp,	#436
    add	x16,	x4,	x20
    add	w7,	w10,	w8
    add	x11,	sp,	x11
    movk	fp,	#2,	lsl #16
    lsl	w4,	w15,	#2
    ldr	w23,	[x16]

    add	x11,	x11,	#16
    add	w10,	w7,	w23
    str	w10,	[x18]

    ldr	x9,	[sp, fp]

    movz	fp,	#436
    add	x3,	x9,	x4
    movk	fp,	#2,	lsl #16
    add	w4,	w15,	#1
    ldr	w7,	[x3]

    lsl	w20,	w4,	#2
    ldr	x6,	[sp, fp]

    lsl	w24,	w7,	#24
    movz	fp,	#436
    add	x5,	x6,	x20
    movk	fp,	#2,	lsl #16
    add	w6,	w15,	#4
    ldr	w9,	[x5]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#436
    add	w23,	w10,	w24
    movk	fp,	#2,	lsl #16
    add	w24,	w15,	#2
    lsl	w10,	w24,	#2
    add	w24,	w6,	#2
    add	x4,	x7,	x10
    add	w10,	w15,	#3
    ldr	w7,	[x4]

    lsl	w18,	w10,	#2
    ldr	x9,	[sp, fp]

    lsl	w8,	w7,	#8
    movz	fp,	#436
    add	x16,	x9,	x18
    add	w7,	w12,	#1
    add	w25,	w23,	w8
    movk	fp,	#2,	lsl #16
    lsl	w9,	w6,	#2
    lsl	w12,	w7,	#2
    ldr	w23,	[x16]

    add	w16,	w7,	#1
    add	w8,	w25,	w23
    str	w8,	[x11]

    ldr	x4,	[sp, fp]

    mov	x11,	x12
    movz	fp,	#436
    add	x8,	x4,	x9
    add	w12,	w6,	#1
    add	x11,	sp,	x11
    movk	fp,	#2,	lsl #16
    lsl	w4,	w24,	#2
    ldr	w10,	[x8]

    lsl	w3,	w12,	#2
    add	x11,	x11,	#16
    ldr	x22,	[sp, fp]

    lsl	w9,	w10,	#24
    movz	fp,	#436
    add	x15,	x22,	x3
    movk	fp,	#2,	lsl #16
    ldr	w18,	[x15]

    ldr	x22,	[sp, fp]

    lsl	w20,	w18,	#16
    movz	fp,	#436
    add	x4,	x22,	x4
    add	w23,	w20,	w9
    movk	fp,	#2,	lsl #16
    add	w20,	w6,	#4
    ldr	w10,	[x4]

    lsl	w13,	w10,	#8
    add	w27,	w20,	#3
    ldr	x10,	[sp, fp]

    add	w9,	w23,	w13
    movz	fp,	#436
    add	w23,	w6,	#3
    movk	fp,	#2,	lsl #16
    lsl	w6,	w16,	#2
    lsl	w4,	w23,	#2
    add	x24,	x10,	x4
    lsl	w4,	w20,	#2
    mov	x10,	x6
    add	x10,	sp,	x10
    ldr	w8,	[x24]

    add	w13,	w9,	w8
    add	x10,	x10,	#16
    str	w13,	[x11]

    add	w11,	w20,	#1
    ldr	x12,	[sp, fp]

    movz	fp,	#436
    add	x3,	x12,	x4
    movk	fp,	#2,	lsl #16
    lsl	w15,	w11,	#2
    ldr	w7,	[x3]

    ldr	x8,	[sp, fp]

    lsl	w5,	w7,	#24
    movz	fp,	#436
    add	x12,	x8,	x15
    movk	fp,	#2,	lsl #16
    add	w8,	w20,	#2
    ldr	w23,	[x12]

    lsl	w11,	w8,	#2
    ldr	x15,	[sp, fp]

    lsl	w24,	w23,	#16
    movz	fp,	#436
    add	x9,	x15,	x11
    movk	fp,	#2,	lsl #16
    add	w4,	w24,	w5
    lsl	w5,	w27,	#2
    ldr	w13,	[x9]

    ldr	x15,	[sp, fp]

    lsl	w18,	w13,	#8
    movz	fp,	#436
    add	w7,	w4,	w18
    movk	fp,	#2,	lsl #16
    add	x4,	x15,	x5
    add	w15,	w20,	#4
    ldr	w9,	[x4]

    add	w12,	w15,	#1
    add	w8,	w7,	w9
    add	w9,	w16,	#1
    str	w8,	[x10]

    lsl	w12,	w12,	#2
    lsl	w6,	w9,	#2
    ldr	x22,	[sp, fp]

    mov	x18,	x6
    movz	fp,	#436
    lsl	w6,	w15,	#2
    add	x18,	sp,	x18
    movk	fp,	#2,	lsl #16
    add	x4,	x22,	x6
    add	x18,	x18,	#16
    ldr	w7,	[x4]

    add	w4,	w15,	#2
    ldr	x22,	[sp, fp]

    lsl	w8,	w7,	#24
    movz	fp,	#436
    add	x13,	x22,	x12
    movk	fp,	#2,	lsl #16
    lsl	w4,	w4,	#2
    ldr	w20,	[x13]

    add	w13,	w15,	#4
    ldr	x16,	[sp, fp]

    lsl	w23,	w20,	#16
    movz	fp,	#436
    add	x5,	x16,	x4
    movk	fp,	#2,	lsl #16
    lsl	w26,	w13,	#2
    add	w23,	w23,	w8
    add	w4,	w15,	#3
    ldr	w10,	[x5]

    add	w15,	w13,	#2
    ldr	x27,	[sp, fp]

    lsl	w20,	w10,	#8
    lsl	w7,	w4,	#2
    movz	fp,	#436
    add	w10,	w9,	#1
    add	w12,	w23,	w20
    add	x6,	x27,	x7
    movk	fp,	#2,	lsl #16
    add	w27,	w13,	#3
    lsl	w20,	w10,	#2
    ldr	w8,	[x6]

    mov	x7,	x20
    add	w8,	w12,	w8
    add	w20,	w13,	#1
    add	x7,	sp,	x7
    add	w13,	w13,	#4
    lsl	w16,	w20,	#2
    str	w8,	[x18]

    add	x7,	x7,	#16
    ldr	x6,	[sp, fp]

    movz	fp,	#436
    add	x23,	x6,	x26
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x23]

    lsl	w9,	w3,	#24
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x23,	x3,	x16
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x23]

    ldr	x11,	[sp, fp]

    lsl	w6,	w4,	#16
    movz	fp,	#436
    add	w8,	w6,	w9
    movk	fp,	#2,	lsl #16
    lsl	w9,	w15,	#2
    add	x18,	x11,	x9
    lsl	w9,	w27,	#2
    ldr	w23,	[x18]

    ldr	x11,	[sp, fp]

    lsl	w24,	w23,	#8
    movz	fp,	#436
    add	x5,	x11,	x9
    add	w25,	w8,	w24
    movk	fp,	#2,	lsl #16
    add	w8,	w10,	#1
    ldr	w11,	[x5]

    add	w4,	w25,	w11
    lsl	w12,	w8,	#2
    add	w11,	w13,	#3
    str	w4,	[x7]

    ldr	x18,	[sp, fp]

    lsl	w4,	w13,	#2
    mov	x7,	x12
    movz	fp,	#436
    add	x20,	x18,	x4
    add	x7,	sp,	x7
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x20]

    add	x7,	x7,	#16
    add	w20,	w13,	#1
    lsl	w18,	w6,	#24
    lsl	w15,	w20,	#2
    ldr	x20,	[sp, fp]

    movz	fp,	#436
    add	x23,	x20,	x15
    movk	fp,	#2,	lsl #16
    add	w15,	w13,	#2
    ldr	w27,	[x23]

    lsl	w3,	w15,	#2
    ldr	x22,	[sp, fp]

    lsl	w4,	w27,	#16
    lsl	w15,	w11,	#2
    movz	fp,	#436
    add	x20,	x22,	x3
    add	w27,	w13,	#4
    add	w6,	w4,	w18
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x20]

    ldr	x23,	[sp, fp]

    lsl	w4,	w24,	#8
    add	x12,	x23,	x15
    add	w9,	w6,	w4
    add	w6,	w8,	#1
    ldr	w16,	[x12]

    mov	w13,	w6
    add	w10,	w9,	w16
    str	w10,	[x7]

    b	main_70

main_215:
    mov	w25,	w27
    mov	w7,	w13

main_217:
    lsl	w10,	w7,	#2
    lsl	w15,	w25,	#2
    movz	fp,	#436
    add	w3,	w7,	#1
    mov	x9,	x10
    movk	fp,	#2,	lsl #16
    add	w10,	w25,	#1
    add	x9,	sp,	x9
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x16,	x8,	x15
    lsl	w4,	w10,	#2
    add	x9,	x9,	#16
    movk	fp,	#2,	lsl #16
    add	w10,	w25,	#3
    ldr	w20,	[x16]

    ldr	x8,	[sp, fp]

    lsl	w27,	w20,	#24
    lsl	w23,	w10,	#2
    movz	fp,	#436
    add	x11,	x8,	x4
    movk	fp,	#2,	lsl #16
    add	w4,	w25,	#2
    ldr	w16,	[x11]

    ldr	x8,	[sp, fp]

    lsl	w18,	w16,	#16
    movz	fp,	#436
    add	w20,	w18,	w27
    movk	fp,	#2,	lsl #16
    lsl	w18,	w4,	#2
    add	x6,	x8,	x18
    ldr	w11,	[x6]

    lsl	w12,	w11,	#8
    ldr	x11,	[sp, fp]

    add	w12,	w20,	w12
    add	x11,	x11,	x23
    ldr	w20,	[x11]

    add	w26,	w12,	w20
    str	w26,	[x9]

    add	w26,	w25,	#4
    cmp	w3,	#16
    bge	main_241

main_216:
    mov	w25,	w26
    mov	w7,	w3
    b	main_217

main_241:
    mov	w15,	w3
    movz	fp,	#552
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#552
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    cmp	w10,	#80
    bge	main_275

main_245:
    movz	fp,	#552
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#552
    lsl	w26,	w11,	#2
    movk	fp,	#2,	lsl #16
    mov	x23,	x26
    add	x23,	sp,	x23
    ldr	w26,	[sp, fp]

    movz	fp,	#552
    sub	w5,	w26,	#3
    add	x23,	x23,	#16
    movk	fp,	#2,	lsl #16
    lsl	w7,	w5,	#2
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w10,	[x6]

    ldr	w5,	[sp, fp]

    movz	fp,	#552
    sub	w8,	w5,	#8
    movk	fp,	#2,	lsl #16
    lsl	w11,	w8,	#2
    mov	x9,	x11
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w12,	[x9]

    ldr	w6,	[sp, fp]

    add	w9,	w12,	w10
    movz	fp,	#552
    sub	w27,	w6,	#14
    movk	fp,	#2,	lsl #16
    sub	w15,	w10,	w9
    lsl	w6,	w27,	#2
    mov	x3,	x6
    add	w18,	w15,	w12
    add	x3,	sp,	x3
    sub	w10,	w18,	w9
    add	x3,	x3,	#16
    ldr	w7,	[x3]

    add	w4,	w7,	w10
    sub	w9,	w10,	w4
    add	w13,	w9,	w7
    ldr	w7,	[sp, fp]

    movz	fp,	#552
    sub	w27,	w13,	w4
    movk	fp,	#2,	lsl #16
    sub	w4,	w7,	#16
    lsl	w7,	w4,	#2
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w8,	[x6]

    add	w7,	w8,	w27
    sub	w12,	w27,	w7
    add	w13,	w12,	w8
    sub	w20,	w13,	w7
    asr	w4,	w20,	#31
    lsl	w11,	w20,	#1
    lsr	w6,	w4,	#31
    add	w7,	w20,	w6
    asr	w13,	w7,	#1
    lsl	w15,	w13,	#1
    sub	w8,	w20,	w15
    add	w9,	w11,	w8
    str	w9,	[x23]

    ldr	w18,	[sp, fp]

    movz	fp,	#552
    add	w10,	w18,	#1
    movk	fp,	#2,	lsl #16
    mov	w9,	w10
    str	w9,	[sp, fp]

    b	main_242

main_275:
    mov	w27,	w2
    movz	fp,	#428
    mov	w6,	w19
    mov	w20,	w14
    mov	w12,	w17
    mov	w16,	w0
    movz	w13,	#0
    movk	fp,	#2,	lsl #16
    mov	w4,	w13
    str	w27,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w6,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]


main_277:
    movz	w9,	#48348
    movz	w20,	#60289
    movz	w12,	#49414
    movz	w3,	#31129
    movz	w27,	#65535
    movz	fp,	#412
    movk	w9,	#36635,	lsl #16
    movk	w20,	#28377,	lsl #16
    movk	w12,	#51810,	lsl #16
    movk	w3,	#23170,	lsl #16
    movk	w27,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w25,	w9
    mov	w13,	w20
    mov	w7,	w12
    mov	w23,	w27
    mov	w9,	w3
    ldr	w12,	[sp, fp]

    cmp	w12,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#424
    add	w27,	w24,	w20
    movk	fp,	#2,	lsl #16
    mov	w20,	w23
    ldr	w11,	[sp, fp]

    movz	fp,	#416
    sub	w15,	w20,	w11
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    add	w26,	w20,	w15
    add	w12,	w26,	w27
    sub	w15,	w27,	w12
    add	w27,	w15,	w26
    sub	w20,	w27,	w12
    sub	w18,	w20,	w27
    add	w24,	w18,	w12
    sub	w15,	w24,	w27
    mov	w27,	w9
    mov	w18,	w15
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    cmp	w20,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#424
    add	w24,	w26,	w24
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    sub	w18,	w20,	w24
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    add	w20,	w18,	w10
    movk	fp,	#2,	lsl #16
    sub	w27,	w20,	w24
    ldr	w6,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w15,	w6,	w27
    ldr	w28,	[sp, fp]

    sub	w18,	w27,	w15
    add	w18,	w18,	w28
    sub	w15,	w18,	w15
    mov	w24,	w15
    mov	w15,	w13
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
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    add	w20,	w12,	w6
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#416
    add	w6,	w11,	w24
    movk	fp,	#2,	lsl #16
    add	w18,	w6,	w20
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w3,	w20,	w18
    ldr	w20,	[sp, fp]

    add	w3,	w3,	w6
    sub	w15,	w3,	w18
    sub	w24,	w15,	w3
    add	w15,	w24,	w18
    add	w18,	w12,	w20
    sub	w24,	w15,	w3
    add	w27,	w18,	w24
    sub	w20,	w24,	w27
    add	w26,	w20,	w18
    sub	w6,	w26,	w27
    sub	w15,	w6,	w26
    add	w24,	w15,	w27
    sub	w15,	w24,	w26
    mov	w24,	w15
    mov	w15,	w25
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#424
    add	w15,	w22,	w11
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#432
    sub	w12,	w11,	w15
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#416
    add	w18,	w12,	w24
    movk	fp,	#2,	lsl #16
    sub	w12,	w18,	w15
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w15,	w20,	w12
    ldr	w11,	[sp, fp]

    sub	w20,	w12,	w15
    add	w20,	w20,	w11
    sub	w15,	w20,	w15
    mov	w24,	w15
    mov	w15,	w7

main_413:
    mov	w18,	w24
    mov	w27,	w15

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    lsl	w6,	w4,	#5
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#428
    asr	w3,	w15,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w3,	#27
    ldr	w20,	[sp, fp]

    movz	fp,	#428
    add	w20,	w20,	w24
    movk	fp,	#2,	lsl #16
    asr	w3,	w20,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#412
    lsl	w3,	w3,	#5
    movk	fp,	#2,	lsl #16
    sub	w20,	w28,	w3
    ldr	w26,	[sp, fp]

    movz	fp,	#424
    lsl	w15,	w26,	#2
    movk	fp,	#2,	lsl #16
    mov	x15,	x15
    add	w20,	w6,	w20
    add	x15,	sp,	x15
    add	w16,	w20,	w16
    add	x15,	x15,	#16
    add	w24,	w16,	w18
    ldr	w26,	[x15]

    ldr	w20,	[sp, fp]

    movz	fp,	#424
    add	w6,	w24,	w27
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    add	w12,	w6,	w26
    movz	fp,	#424
    lsl	w6,	w20,	#30
    movk	fp,	#2,	lsl #16
    asr	w20,	w18,	#31
    ldr	w15,	[sp, fp]

    lsr	w16,	w20,	#2
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w16,	w15,	w16
    ldr	w18,	[sp, fp]

    movz	fp,	#412
    asr	w26,	w16,	#30
    movk	fp,	#2,	lsl #16
    lsl	w26,	w26,	#30
    sub	w24,	w18,	w26
    ldr	w18,	[sp, fp]

    add	w15,	w18,	#1
    add	w16,	w6,	w24
    cmp	w15,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    add	w18,	w16,	w4
    movk	fp,	#2,	lsl #16
    mov	w4,	w23
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w4,	w7
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    add	w6,	w20,	w4
    add	w25,	w6,	w18
    sub	w24,	w18,	w25
    add	w23,	w24,	w6
    mov	w6,	w9
    sub	w24,	w23,	w25
    sub	w26,	w24,	w23
    add	w26,	w26,	w25
    sub	w25,	w26,	w23
    mov	w27,	w25
    b	main_347

main_364:
    cmp	w15,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    mov	w7,	w13
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w24,	w16,	w22
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w8,	w24
    movk	fp,	#2,	lsl #16
    add	w4,	w6,	w16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w5,	w4,	w24
    ldr	w3,	[sp, fp]

    add	w4,	w20,	w5
    sub	w18,	w5,	w4
    add	w25,	w18,	w3
    sub	w23,	w25,	w4
    b	main_375

main_378:
    cmp	w15,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w27,	w16,	w3
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    add	w26,	w7,	w10
    movk	fp,	#2,	lsl #16
    add	w13,	w26,	w27
    sub	w20,	w27,	w13
    add	w9,	w20,	w26
    sub	w24,	w9,	w13
    sub	w4,	w24,	w9
    add	w4,	w4,	w13
    sub	w7,	w4,	w9
    ldr	w4,	[sp, fp]

    add	w18,	w4,	w16
    add	w4,	w18,	w7
    sub	w20,	w7,	w4
    add	w9,	w20,	w18
    sub	w24,	w9,	w4
    sub	w26,	w24,	w9
    add	w18,	w26,	w4
    sub	w20,	w18,	w9
    mov	w24,	w20
    mov	w20,	w25
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#428
    add	w24,	w16,	w6
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w20,	w24
    movk	fp,	#2,	lsl #16
    mov	w20,	w7
    add	w18,	w6,	w16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w4,	w18,	w24
    ldr	w10,	[sp, fp]

    add	w25,	w5,	w4
    sub	w18,	w4,	w25
    add	w13,	w18,	w10
    sub	w23,	w13,	w25
    mov	w24,	w23

main_398:
    mov	w23,	w24
    mov	w7,	w20

main_375:
    mov	w27,	w23
    mov	w6,	w7

main_347:
    lsl	w25,	w12,	#5
    asr	w7,	w12,	#31
    movz	fp,	#416
    lsr	w9,	w7,	#27
    movk	fp,	#2,	lsl #16
    add	w18,	w12,	w9
    asr	w20,	w18,	#5
    lsl	w4,	w20,	#5
    lsl	w20,	w15,	#2
    sub	w23,	w12,	w4
    mov	x7,	x20
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w4,	[x7]

    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w11,	w23,	w22
    movk	fp,	#2,	lsl #16
    add	w18,	w11,	w25
    ldr	w8,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w5,	w18,	w27
    add	w13,	w5,	w6
    add	w24,	w13,	w4
    ldr	w4,	[sp, fp]

    lsl	w13,	w8,	#30
    movz	fp,	#428
    asr	w23,	w4,	#31
    movk	fp,	#2,	lsl #16
    lsr	w27,	w23,	#2
    ldr	w6,	[sp, fp]

    movz	fp,	#428
    add	w4,	w6,	w27
    movk	fp,	#2,	lsl #16
    asr	w7,	w4,	#30
    ldr	w8,	[sp, fp]

    add	w4,	w15,	#1
    lsl	w11,	w7,	#30
    sub	w20,	w8,	w11
    add	w13,	w13,	w20
    cmp	w4,	#80
    blt	main_276

main_433:
    add	w4,	w24,	w2
    add	w27,	w12,	w19
    add	w20,	w16,	w17
    movz	fp,	#432
    add	w8,	w1,	#64
    add	w24,	w13,	w14
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    add	w0,	w9,	w0
    cmp	w8,	w21
    blt	main_62

main_441:
    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#488
    str	w4,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#464
    str	w27,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#456
    str	w24,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#472
    str	w20,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w0,	[x23]

    movz	w0,	#0

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
    sub	w23,	w17,	w6
    str	w23,	[x24]

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

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w2,	w4
    mov	w19,	w27
    mov	w14,	w24
    mov	w17,	w20
    mov	w1,	w8
    b	main_63

main_276:
    mov	w20,	w24
    movz	fp,	#428
    mov	w8,	w12
    mov	w9,	w4
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#412
    mov	w16,	w12
    movk	fp,	#2,	lsl #16
    mov	w12,	w13
    str	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#512
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


