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
    movz	fp,	#336
    movz	w26,	#0
    movz	w23,	#0
    movz	w24,	#0
    movz	w25,	#0
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

    movz	fp,	#532
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
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
    movz	fp,	#532
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
    add	w20,	w13,	#4
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
    ldr	x1,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#524
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w2,	#0
    movz	w17,	#8961
    movz	w19,	#57840
    movz	w27,	#43913
    movz	w5,	#56574
    movz	w6,	#21622
    mov	w1,	w2
    movk	w17,	#26437,	lsl #16
    movk	w19,	#50130,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w11,	w17
    mov	w0,	w19
    mov	w3,	w27
    mov	w21,	w5
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
    movz	fp,	#436
    add	w4,	w26,	#1
    add	w15,	w26,	#2
    add	w12,	w26,	#3
    mov	x19,	x19
    movk	fp,	#2,	lsl #16
    lsl	w23,	w4,	#2
    add	x19,	sp,	x19
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x7,	x5,	x8
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x7]

    ldr	x13,	[sp, fp]

    lsl	w18,	w9,	#24
    movz	fp,	#436
    add	x5,	x13,	x23
    movk	fp,	#2,	lsl #16
    lsl	w13,	w15,	#2
    ldr	w8,	[x5]

    ldr	x27,	[sp, fp]

    lsl	w9,	w8,	#16
    movz	fp,	#436
    add	x24,	x27,	x13
    add	w10,	w9,	w18
    movk	fp,	#2,	lsl #16
    add	w13,	w14,	#1
    lsl	w18,	w12,	#2
    ldr	w5,	[x24]

    ldr	x4,	[sp, fp]

    lsl	w8,	w5,	#8
    lsl	w14,	w13,	#2
    movz	fp,	#436
    add	x16,	x4,	x18
    add	w7,	w10,	w8
    mov	x12,	x14
    movk	fp,	#2,	lsl #16
    add	x12,	sp,	x12
    ldr	w23,	[x16]

    add	w16,	w26,	#4
    add	w10,	w7,	w23
    add	x12,	x12,	#16
    add	w24,	w16,	#2
    add	w2,	w16,	#1
    lsl	w4,	w16,	#2
    str	w10,	[x19]

    ldr	x9,	[sp, fp]

    lsl	w19,	w2,	#2
    movz	fp,	#436
    add	x27,	x9,	x4
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x27]

    ldr	x6,	[sp, fp]

    lsl	w25,	w7,	#24
    movz	fp,	#436
    add	x5,	x6,	x19
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x5]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#436
    add	w23,	w10,	w25
    movk	fp,	#2,	lsl #16
    lsl	w10,	w24,	#2
    add	x4,	x7,	x10
    add	w10,	w16,	#3
    ldr	w7,	[x4]

    lsl	w18,	w10,	#2
    ldr	x9,	[sp, fp]

    lsl	w8,	w7,	#8
    add	w10,	w13,	#1
    movz	fp,	#436
    add	x15,	x9,	x18
    add	w24,	w23,	w8
    movk	fp,	#2,	lsl #16
    add	w18,	w16,	#4
    ldr	w25,	[x15]

    add	w8,	w24,	w25
    add	w24,	w18,	#2
    str	w8,	[x12]

    ldr	x4,	[sp, fp]

    lsl	w8,	w18,	#2
    lsl	w12,	w10,	#2
    movz	fp,	#436
    add	x5,	x4,	x8
    mov	x7,	x12
    movk	fp,	#2,	lsl #16
    lsl	w4,	w24,	#2
    add	w12,	w18,	#1
    add	x7,	sp,	x7
    ldr	w9,	[x5]

    ldr	x19,	[sp, fp]

    lsl	w5,	w9,	#24
    lsl	w15,	w12,	#2
    add	x7,	x7,	#16
    movz	fp,	#436
    add	w12,	w18,	#3
    add	x13,	x19,	x15
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x13]

    ldr	x23,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#436
    add	x25,	x23,	x4
    add	w15,	w10,	#1
    add	w16,	w16,	w5
    movk	fp,	#2,	lsl #16
    add	w23,	w18,	#4
    lsl	w4,	w12,	#2
    ldr	w2,	[x25]

    ldr	x6,	[sp, fp]

    lsl	w5,	w2,	#8
    movz	fp,	#436
    add	x24,	x6,	x4
    add	w9,	w16,	w5
    movk	fp,	#2,	lsl #16
    lsl	w4,	w23,	#2
    lsl	w6,	w15,	#2
    ldr	w5,	[x24]

    mov	x10,	x6
    add	w12,	w9,	w5
    add	x10,	sp,	x10
    str	w12,	[x7]

    add	x10,	x10,	#16
    add	w12,	w23,	#1
    ldr	x13,	[sp, fp]

    movz	fp,	#436
    add	x27,	x13,	x4
    movk	fp,	#2,	lsl #16
    lsl	w16,	w12,	#2
    ldr	w7,	[x27]

    add	w27,	w23,	#3
    ldr	x8,	[sp, fp]

    lsl	w5,	w7,	#24
    movz	fp,	#436
    add	x13,	x8,	x16
    movk	fp,	#2,	lsl #16
    add	w8,	w23,	#2
    ldr	w19,	[x13]

    lsl	w12,	w8,	#2
    ldr	x16,	[sp, fp]

    lsl	w24,	w19,	#16
    movz	fp,	#436
    add	x9,	x16,	x12
    movk	fp,	#2,	lsl #16
    add	w4,	w24,	w5
    lsl	w5,	w27,	#2
    ldr	w14,	[x9]

    ldr	x16,	[sp, fp]

    lsl	w18,	w14,	#8
    movz	fp,	#436
    add	x2,	x16,	x5
    add	w7,	w4,	w18
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x2]

    add	w8,	w7,	w9
    add	w9,	w15,	#1
    add	w15,	w23,	#4
    str	w8,	[x10]

    lsl	w5,	w9,	#2
    ldr	x23,	[sp, fp]

    add	w2,	w15,	#2
    add	w13,	w15,	#1
    mov	x19,	x5
    movz	fp,	#436
    lsl	w5,	w15,	#2
    add	x19,	sp,	x19
    lsl	w13,	w13,	#2
    movk	fp,	#2,	lsl #16
    add	x4,	x23,	x5
    add	x19,	x19,	#16
    ldr	w7,	[x4]

    lsl	w4,	w2,	#2
    ldr	x22,	[sp, fp]

    lsl	w8,	w7,	#24
    movz	fp,	#436
    add	x14,	x22,	x13
    movk	fp,	#2,	lsl #16
    ldr	w18,	[x14]

    add	w14,	w15,	#4
    ldr	x16,	[sp, fp]

    lsl	w24,	w18,	#16
    movz	fp,	#436
    add	x5,	x16,	x4
    movk	fp,	#2,	lsl #16
    lsl	w26,	w14,	#2
    add	w24,	w24,	w8
    add	w4,	w15,	#3
    ldr	w10,	[x5]

    add	w15,	w14,	#2
    ldr	x27,	[sp, fp]

    lsl	w18,	w10,	#8
    lsl	w7,	w4,	#2
    movz	fp,	#436
    add	w10,	w9,	#1
    add	w13,	w24,	w18
    add	x5,	x27,	x7
    movk	fp,	#2,	lsl #16
    lsl	w23,	w10,	#2
    ldr	w8,	[x5]

    mov	x7,	x23
    add	w8,	w13,	w8
    add	x7,	sp,	x7
    str	w8,	[x19]

    add	x7,	x7,	#16
    add	w19,	w14,	#1
    ldr	x6,	[sp, fp]

    movz	fp,	#436
    add	x24,	x6,	x26
    movk	fp,	#2,	lsl #16
    lsl	w16,	w19,	#2
    ldr	w27,	[x24]

    ldr	x28,	[sp, fp]

    lsl	w9,	w27,	#24
    movz	fp,	#436
    add	x23,	x28,	x16
    add	w27,	w14,	#3
    movk	fp,	#2,	lsl #16
    add	w14,	w14,	#4
    ldr	w4,	[x23]

    ldr	x12,	[sp, fp]

    lsl	w5,	w4,	#16
    add	w26,	w14,	#4
    movz	fp,	#436
    add	w8,	w5,	w9
    movk	fp,	#2,	lsl #16
    lsl	w9,	w15,	#2
    add	x18,	x12,	x9
    lsl	w9,	w27,	#2
    ldr	w24,	[x18]

    ldr	x12,	[sp, fp]

    lsl	w25,	w24,	#8
    movz	fp,	#436
    add	x5,	x12,	x9
    add	w24,	w8,	w25
    movk	fp,	#2,	lsl #16
    add	w8,	w10,	#1
    ldr	w12,	[x5]

    add	w4,	w24,	w12
    lsl	w13,	w8,	#2
    add	w12,	w14,	#3
    str	w4,	[x7]

    lsl	w4,	w14,	#2
    ldr	x18,	[sp, fp]

    mov	x7,	x13
    movz	fp,	#436
    add	x19,	x18,	x4
    add	x7,	sp,	x7
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x19]

    add	x7,	x7,	#16
    add	w19,	w14,	#1
    lsl	w18,	w5,	#24
    lsl	w15,	w19,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#436
    add	x24,	x19,	x15
    movk	fp,	#2,	lsl #16
    add	w15,	w14,	#2
    ldr	w27,	[x24]

    ldr	x19,	[sp, fp]

    lsl	w2,	w27,	#16
    movz	fp,	#436
    lsl	w27,	w15,	#2
    add	w5,	w2,	w18
    movk	fp,	#2,	lsl #16
    lsl	w15,	w12,	#2
    add	x19,	x19,	x27
    ldr	w24,	[x19]

    ldr	x23,	[sp, fp]

    lsl	w4,	w24,	#8
    add	x13,	x23,	x15
    add	w9,	w5,	w4
    add	w5,	w8,	#1
    ldr	w16,	[x13]

    mov	w14,	w5
    add	w10,	w9,	w16
    str	w10,	[x7]

    b	main_70

main_215:
    mov	w24,	w26
    mov	w7,	w14

main_217:
    lsl	w10,	w7,	#2
    lsl	w15,	w24,	#2
    movz	fp,	#436
    add	w2,	w7,	#1
    mov	x9,	x10
    movk	fp,	#2,	lsl #16
    add	w10,	w24,	#1
    add	x9,	sp,	x9
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x16,	x8,	x15
    lsl	w4,	w10,	#2
    add	x9,	x9,	#16
    movk	fp,	#2,	lsl #16
    add	w10,	w24,	#3
    ldr	w23,	[x16]

    ldr	x6,	[sp, fp]

    lsl	w27,	w23,	#24
    lsl	w25,	w10,	#2
    movz	fp,	#436
    add	x12,	x6,	x4
    movk	fp,	#2,	lsl #16
    add	w4,	w24,	#2
    ldr	w16,	[x12]

    ldr	x8,	[sp, fp]

    lsl	w18,	w16,	#16
    movz	fp,	#436
    add	w19,	w18,	w27
    movk	fp,	#2,	lsl #16
    lsl	w18,	w4,	#2
    add	x5,	x8,	x18
    ldr	w12,	[x5]

    lsl	w13,	w12,	#8
    ldr	x12,	[sp, fp]

    add	w13,	w19,	w13
    add	x12,	x12,	x25
    add	w25,	w24,	#4
    ldr	w19,	[x12]

    add	w26,	w13,	w19
    str	w26,	[x9]

    cmp	w2,	#16
    bge	main_241

main_216:
    mov	w24,	w25
    mov	w7,	w2
    b	main_217

main_241:
    mov	w15,	w2
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    cmp	w10,	#80
    bge	main_275

main_245:
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#520
    lsl	w26,	w12,	#2
    movk	fp,	#2,	lsl #16
    mov	x23,	x26
    add	x23,	sp,	x23
    ldr	w26,	[sp, fp]

    movz	fp,	#520
    sub	w5,	w26,	#3
    add	x23,	x23,	#16
    movk	fp,	#2,	lsl #16
    lsl	w7,	w5,	#2
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w10,	[x6]

    ldr	w5,	[sp, fp]

    movz	fp,	#520
    sub	w8,	w5,	#8
    movk	fp,	#2,	lsl #16
    lsl	w12,	w8,	#2
    mov	x9,	x12
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w13,	[x9]

    ldr	w6,	[sp, fp]

    add	w9,	w13,	w10
    movz	fp,	#520
    sub	w26,	w6,	#14
    movk	fp,	#2,	lsl #16
    sub	w15,	w10,	w9
    lsl	w6,	w26,	#2
    mov	x2,	x6
    add	w19,	w15,	w13
    add	x2,	sp,	x2
    sub	w10,	w19,	w9
    add	x2,	x2,	#16
    ldr	w7,	[x2]

    add	w4,	w7,	w10
    sub	w9,	w10,	w4
    add	w14,	w9,	w7
    ldr	w7,	[sp, fp]

    movz	fp,	#520
    sub	w27,	w14,	w4
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
    sub	w19,	w14,	w7
    asr	w4,	w19,	#31
    lsl	w12,	w19,	#1
    lsr	w5,	w4,	#31
    add	w7,	w19,	w5
    asr	w14,	w7,	#1
    lsl	w16,	w14,	#1
    sub	w8,	w19,	w16
    add	w9,	w12,	w8
    str	w9,	[x23]

    ldr	w18,	[sp, fp]

    movz	fp,	#520
    add	w10,	w18,	#1
    movk	fp,	#2,	lsl #16
    mov	w9,	w10
    str	w9,	[sp, fp]

    b	main_242

main_275:
    mov	w27,	w11
    movz	fp,	#428
    mov	w4,	w3
    mov	w22,	w21
    mov	w13,	w17
    mov	w15,	w0
    movz	w14,	#0
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    mov	w4,	w14
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]


main_277:
    movz	w7,	#48348
    movz	w19,	#60289
    movz	w13,	#49414
    movz	w2,	#31129
    movz	w27,	#65535
    movz	fp,	#412
    movk	w7,	#36635,	lsl #16
    movk	w19,	#28377,	lsl #16
    movk	w13,	#51810,	lsl #16
    movk	w2,	#23170,	lsl #16
    movk	w27,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w24,	w7
    mov	w14,	w19
    mov	w18,	w2
    mov	w23,	w27
    ldr	w12,	[sp, fp]

    mov	w7,	w13
    cmp	w12,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#424
    add	w27,	w26,	w19
    movk	fp,	#2,	lsl #16
    mov	w19,	w23
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    sub	w8,	w19,	w10
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w26,	w19,	w8
    add	w8,	w26,	w27
    sub	w13,	w27,	w8
    add	w27,	w13,	w26
    sub	w19,	w27,	w8
    sub	w13,	w19,	w27
    add	w25,	w13,	w8
    sub	w13,	w25,	w27
    mov	w27,	w18
    mov	w16,	w13
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#424
    add	w25,	w27,	w25
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w19,	w19,	w25
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    add	w19,	w19,	w9
    movk	fp,	#2,	lsl #16
    sub	w13,	w19,	w25
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w16,	w5,	w13
    ldr	w28,	[sp, fp]

    sub	w8,	w13,	w16
    add	w8,	w8,	w28
    sub	w13,	w8,	w16
    mov	w25,	w13
    mov	w13,	w14
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    cmp	w25,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    add	w19,	w12,	w5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#416
    add	w6,	w10,	w25
    movk	fp,	#2,	lsl #16
    add	w26,	w6,	w19
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w2,	w19,	w26
    ldr	w19,	[sp, fp]

    add	w16,	w12,	w19
    add	w2,	w2,	w6
    sub	w8,	w2,	w26
    sub	w25,	w8,	w2
    add	w13,	w25,	w26
    sub	w25,	w13,	w2
    add	w26,	w16,	w25
    sub	w19,	w25,	w26
    add	w27,	w19,	w16
    sub	w6,	w27,	w26
    sub	w8,	w6,	w27
    add	w25,	w8,	w26
    sub	w13,	w25,	w27
    mov	w25,	w13
    mov	w13,	w24
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#424
    add	w16,	w22,	w10
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#432
    sub	w8,	w10,	w16
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#416
    add	w13,	w8,	w25
    movk	fp,	#2,	lsl #16
    sub	w13,	w13,	w16
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w8,	w19,	w13
    ldr	w12,	[sp, fp]

    sub	w19,	w13,	w8
    add	w25,	w19,	w12
    sub	w13,	w25,	w8
    mov	w25,	w13
    mov	w13,	w7

main_413:
    mov	w16,	w25
    mov	w27,	w13

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    lsl	w6,	w4,	#5
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#428
    asr	w2,	w13,	#31
    movk	fp,	#2,	lsl #16
    lsr	w25,	w2,	#27
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w19,	w19,	w25
    movk	fp,	#2,	lsl #16
    asr	w2,	w19,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#412
    lsl	w8,	w2,	#5
    movk	fp,	#2,	lsl #16
    sub	w19,	w28,	w8
    ldr	w28,	[sp, fp]

    movz	fp,	#424
    lsl	w8,	w28,	#2
    add	w19,	w6,	w19
    movk	fp,	#2,	lsl #16
    mov	x13,	x8
    add	x13,	sp,	x13
    add	w15,	w19,	w15
    add	x13,	x13,	#16
    add	w25,	w15,	w16
    ldr	w26,	[x13]

    add	w6,	w25,	w27
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w8,	w6,	w26
    ldr	w16,	[sp, fp]

    lsl	w6,	w19,	#30
    movz	fp,	#424
    asr	w25,	w16,	#31
    movk	fp,	#2,	lsl #16
    lsr	w15,	w25,	#2
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w15,	w13,	w15
    movk	fp,	#2,	lsl #16
    asr	w26,	w15,	#30
    ldr	w16,	[sp, fp]

    movz	fp,	#412
    lsl	w27,	w26,	#30
    movk	fp,	#2,	lsl #16
    sub	w25,	w16,	w27
    ldr	w15,	[sp, fp]

    add	w13,	w15,	#1
    add	w16,	w6,	w25
    cmp	w13,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w19,	w23
    mov	w6,	w18
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    add	w14,	w16,	w4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w19,	w5
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w5,	w19,	w4
    add	w25,	w5,	w14
    sub	w24,	w14,	w25
    add	w23,	w24,	w5
    sub	w24,	w23,	w25
    sub	w26,	w24,	w23
    add	w27,	w26,	w25
    sub	w25,	w27,	w23
    mov	w27,	w25
    b	main_347

main_364:
    cmp	w13,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#428
    add	w24,	w16,	w23
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w9,	w24
    movk	fp,	#2,	lsl #16
    add	w4,	w6,	w16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w5,	w4,	w24
    ldr	w28,	[sp, fp]

    add	w4,	w19,	w5
    sub	w15,	w5,	w4
    mov	w5,	w14
    add	w25,	w15,	w28
    sub	w23,	w25,	w4
    b	main_375

main_378:
    cmp	w13,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    add	w27,	w16,	w2
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    add	w26,	w7,	w12
    movk	fp,	#2,	lsl #16
    add	w15,	w26,	w27
    sub	w19,	w27,	w15
    add	w14,	w19,	w26
    sub	w25,	w14,	w15
    sub	w4,	w25,	w14
    add	w4,	w4,	w15
    sub	w6,	w4,	w14
    ldr	w4,	[sp, fp]

    add	w18,	w4,	w16
    add	w4,	w18,	w6
    sub	w19,	w6,	w4
    add	w14,	w19,	w18
    sub	w25,	w14,	w4
    sub	w27,	w25,	w14
    add	w18,	w27,	w4
    sub	w19,	w18,	w14
    mov	w18,	w24
    mov	w25,	w19
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#428
    add	w24,	w16,	w6
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w5,	w19,	w24
    movk	fp,	#2,	lsl #16
    add	w18,	w5,	w16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w18,	w24
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    add	w25,	w5,	w4
    sub	w18,	w4,	w25
    add	w14,	w18,	w12
    mov	w18,	w7
    sub	w23,	w14,	w25
    mov	w25,	w23

main_398:
    mov	w23,	w25
    mov	w5,	w18

main_375:
    mov	w27,	w23
    mov	w6,	w5

main_347:
    lsl	w25,	w8,	#5
    asr	w5,	w8,	#31
    movz	fp,	#416
    lsr	w14,	w5,	#27
    movk	fp,	#2,	lsl #16
    add	w18,	w8,	w14
    asr	w19,	w18,	#5
    lsl	w4,	w19,	#5
    lsl	w19,	w13,	#2
    sub	w23,	w8,	w4
    mov	x7,	x19
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w4,	[x7]

    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w14,	w23,	w22
    movk	fp,	#2,	lsl #16
    add	w18,	w14,	w25
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w5,	w18,	w27
    add	w15,	w5,	w6
    add	w5,	w13,	#1
    add	w25,	w15,	w4
    ldr	w4,	[sp, fp]

    lsl	w15,	w9,	#30
    movz	fp,	#428
    asr	w23,	w4,	#31
    movk	fp,	#2,	lsl #16
    lsr	w27,	w23,	#2
    ldr	w6,	[sp, fp]

    movz	fp,	#428
    add	w4,	w6,	w27
    movk	fp,	#2,	lsl #16
    asr	w7,	w4,	#30
    ldr	w9,	[sp, fp]

    lsl	w14,	w7,	#30
    sub	w19,	w9,	w14
    add	w18,	w15,	w19
    cmp	w5,	#80
    blt	main_276

main_433:
    add	w24,	w25,	w11
    add	w5,	w8,	w3
    add	w2,	w18,	w21
    add	w19,	w16,	w17
    movz	fp,	#432
    add	w12,	w1,	#64
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w0,	w10,	w0
    cmp	w12,	w20
    blt	main_62

main_441:
    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#480
    str	w24,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#464
    str	w5,	[x4]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#444
    str	w2,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#452
    str	w19,	[x22]

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

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w24
    mov	w3,	w5
    mov	w21,	w2
    mov	w17,	w19
    mov	w1,	w12
    b	main_63

main_276:
    mov	w22,	w25
    movz	fp,	#428
    mov	w13,	w8
    mov	w15,	w16
    mov	w9,	w5
    movk	fp,	#2,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#412
    mov	w15,	w13
    movk	fp,	#2,	lsl #16
    mov	w13,	w18
    str	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

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


