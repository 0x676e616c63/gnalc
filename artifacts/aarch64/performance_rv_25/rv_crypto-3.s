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
    movz	w25,	#0
    movz	w24,	#0
    movz	w23,	#0
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
    mov	w27,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w6,	#0
    movz	w5,	#0
    movz	fp,	#356
    movz	w2,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#536
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#536
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

    movz	fp,	#528
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#384
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
    add	w25,	w1,	w23
    asr	w21,	w25,	#8
    lsl	w22,	w21,	#8
    sub	w25,	w1,	w22
    str	w25,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w20,	#128
    movz	fp,	#528
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
    add	w21,	w3,	#1
    movz	w26,	#0
    movz	w22,	#125
    movk	fp,	#2,	lsl #16
    lsl	w27,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x23,	x28,	x2
    movk	fp,	#2,	lsl #16
    movz	w28,	#0
    str	w28,	[x23]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x27
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    ldr	x0,	[sp, fp]

    add	w26,	w3,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x19,	x0,	x2
    movz	w2,	#0
    add	w0,	w3,	#3
    str	w22,	[x19]

    lsl	w26,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#520
    add	x23,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x23]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    add	w23,	w3,	#4
    bl	memset
    movz	w21,	#0
    movz	w17,	#8961
    movz	w26,	#43913
    movz	w19,	#57840
    movz	w3,	#56574
    movz	w2,	#21622
    mov	w22,	w21
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w19,	#50130,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w2,	#4146,	lsl #16
    mov	w11,	w17
    mov	w28,	w26
    mov	w14,	w3
    mov	w5,	w2
    mov	w26,	w19

main_63:
    movz	w17,	#0
    mov	w20,	w22
    mov	w10,	w17

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w17,	w10,	#2
    lsl	w3,	w20,	#2
    movz	fp,	#436
    add	w0,	w20,	#1
    add	w6,	w20,	#3
    add	w10,	w10,	#1
    mov	x15,	x17
    movk	fp,	#2,	lsl #16
    lsl	w18,	w0,	#2
    add	x15,	sp,	x15
    ldr	x27,	[sp, fp]

    movz	fp,	#436
    add	x2,	x27,	x3
    add	x15,	x15,	#16
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w12,	w4,	#24
    movz	fp,	#436
    add	x1,	x9,	x18
    movk	fp,	#2,	lsl #16
    lsl	w9,	w6,	#2
    lsl	w6,	w10,	#2
    ldr	w3,	[x1]

    ldr	x24,	[sp, fp]

    lsl	w4,	w3,	#16
    movz	fp,	#436
    mov	x3,	x6
    add	w8,	w4,	w12
    movk	fp,	#2,	lsl #16
    add	x3,	sp,	x3
    add	w12,	w20,	#2
    add	x3,	x3,	#16
    lsl	w4,	w12,	#2
    add	w12,	w20,	#4
    add	x19,	x24,	x4
    add	w16,	w12,	#2
    ldr	w0,	[x19]

    ldr	x27,	[sp, fp]

    lsl	w1,	w0,	#8
    movz	fp,	#436
    add	x7,	x27,	x9
    add	w2,	w8,	w1
    movk	fp,	#2,	lsl #16
    lsl	w27,	w12,	#2
    lsl	w8,	w16,	#2
    ldr	w13,	[x7]

    add	w7,	w2,	w13
    str	w7,	[x15]

    ldr	x7,	[sp, fp]

    movz	fp,	#436
    add	x21,	x7,	x27
    movk	fp,	#2,	lsl #16
    add	w27,	w12,	#1
    ldr	w0,	[x21]

    lsl	w13,	w27,	#2
    lsl	w20,	w0,	#24
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x0,	x0,	x13
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x0]

    ldr	x1,	[sp, fp]

    lsl	w6,	w2,	#16
    movz	fp,	#436
    add	x0,	x1,	x8
    add	w13,	w6,	w20
    movk	fp,	#2,	lsl #16
    add	w8,	w12,	#3
    ldr	w2,	[x0]

    lsl	w4,	w2,	#8
    lsl	w16,	w8,	#2
    add	w18,	w13,	w4
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x9,	x8,	x16
    movk	fp,	#2,	lsl #16
    ldr	w20,	[x9]

    add	w1,	w18,	w20
    str	w1,	[x3]

    ldr	x0,	[sp, fp]

    add	w3,	w10,	#1
    movz	fp,	#436
    add	w10,	w12,	#4
    movk	fp,	#2,	lsl #16
    lsl	w8,	w3,	#2
    add	w7,	w10,	#1
    add	w17,	w10,	#2
    lsl	w4,	w10,	#2
    mov	x2,	x8
    add	x2,	sp,	x2
    lsl	w13,	w7,	#2
    lsl	w27,	w17,	#2
    add	x1,	x0,	x4
    add	x2,	x2,	#16
    add	w4,	w10,	#3
    ldr	w6,	[x1]

    ldr	x18,	[sp, fp]

    lsl	w1,	w6,	#24
    movz	fp,	#436
    add	x8,	x18,	x13
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x8]

    ldr	x18,	[sp, fp]

    lsl	w15,	w13,	#16
    movz	fp,	#436
    add	x20,	x18,	x27
    add	w13,	w15,	w1
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x20]

    ldr	x6,	[sp, fp]

    lsl	w0,	w27,	#8
    movz	fp,	#436
    add	w1,	w13,	w0
    movk	fp,	#2,	lsl #16
    add	w13,	w3,	#1
    lsl	w0,	w4,	#2
    add	x16,	x6,	x0
    lsl	w27,	w13,	#2
    mov	x6,	x27
    ldr	w4,	[x16]

    add	x6,	sp,	x6
    add	w16,	w10,	#4
    add	w7,	w1,	w4
    add	x6,	x6,	#16
    add	w3,	w16,	#1
    lsl	w27,	w16,	#2
    str	w7,	[x2]

    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x21,	x8,	x27
    movk	fp,	#2,	lsl #16
    lsl	w8,	w3,	#2
    ldr	w0,	[x21]

    add	w21,	w16,	#3
    ldr	x3,	[sp, fp]

    lsl	w0,	w0,	#24
    movz	fp,	#436
    add	x7,	x3,	x8
    movk	fp,	#2,	lsl #16
    add	w3,	w16,	#2
    ldr	w10,	[x7]

    lsl	w8,	w3,	#2
    ldr	x12,	[sp, fp]

    lsl	w15,	w10,	#16
    add	w3,	w13,	#1
    movz	fp,	#436
    add	x4,	x12,	x8
    add	w0,	w15,	w0
    movk	fp,	#2,	lsl #16
    add	w7,	w3,	#1
    ldr	w10,	[x4]

    ldr	x12,	[sp, fp]

    lsl	w15,	w10,	#8
    lsl	w18,	w7,	#2
    movz	fp,	#436
    add	w2,	w0,	w15
    movk	fp,	#2,	lsl #16
    lsl	w0,	w21,	#2
    add	x27,	x12,	x0
    ldr	w1,	[x27]

    add	w1,	w2,	w1
    str	w1,	[x6]

    lsl	w1,	w3,	#2
    add	w6,	w16,	#4
    mov	x17,	x1
    ldr	x16,	[sp, fp]

    add	x17,	sp,	x17
    movz	fp,	#436
    add	w27,	w6,	#2
    add	w10,	w6,	#1
    lsl	w1,	w6,	#2
    movk	fp,	#2,	lsl #16
    add	x17,	x17,	#16
    lsl	w27,	w27,	#2
    lsl	w10,	w10,	#2
    add	x0,	x16,	x1
    ldr	w2,	[x0]

    ldr	x16,	[sp, fp]

    lsl	w4,	w2,	#24
    movz	fp,	#436
    add	x12,	x16,	x10
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    ldr	x12,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#436
    add	x0,	x12,	x27
    add	w15,	w16,	w4
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x0]

    ldr	x24,	[sp, fp]

    add	w0,	w6,	#3
    lsl	w10,	w2,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w0,	#2
    add	w9,	w15,	w10
    add	w10,	w6,	#4
    add	x1,	x24,	x2
    add	w12,	w10,	#2
    lsl	w20,	w10,	#2
    ldr	w4,	[x1]

    mov	x1,	x18
    add	w4,	w9,	w4
    add	x1,	sp,	x1
    add	w9,	w10,	#1
    str	w4,	[x17]

    add	x1,	x1,	#16
    lsl	w6,	w9,	#2
    lsl	w4,	w12,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x19,	x0,	x20
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x19]

    ldr	x25,	[sp, fp]

    lsl	w2,	w21,	#24
    movz	fp,	#436
    add	x13,	x25,	x6
    add	w21,	w10,	#3
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x13]

    lsl	w3,	w0,	#16
    add	w3,	w3,	w2
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x15,	x2,	x4
    movk	fp,	#2,	lsl #16
    add	w4,	w10,	#4
    lsl	w2,	w21,	#2
    ldr	w17,	[x15]

    add	w9,	w4,	#2
    ldr	x8,	[sp, fp]

    lsl	w20,	w17,	#8
    movz	fp,	#436
    add	x0,	x8,	x2
    movk	fp,	#2,	lsl #16
    add	w18,	w3,	w20
    add	w8,	w4,	#3
    add	w20,	w4,	#4
    ldr	w3,	[x0]

    add	w0,	w7,	#1
    add	w27,	w18,	w3
    lsl	w6,	w0,	#2
    str	w27,	[x1]

    mov	x3,	x6
    ldr	x16,	[sp, fp]

    lsl	w1,	w4,	#2
    add	x3,	sp,	x3
    movz	fp,	#436
    add	x13,	x16,	x1
    movk	fp,	#2,	lsl #16
    add	x3,	x3,	#16
    add	w16,	w4,	#1
    ldr	w2,	[x13]

    lsl	w12,	w16,	#2
    lsl	w15,	w2,	#24
    ldr	x16,	[sp, fp]

    movz	fp,	#436
    add	x17,	x16,	x12
    movk	fp,	#2,	lsl #16
    lsl	w12,	w8,	#2
    ldr	w21,	[x17]

    ldr	x17,	[sp, fp]

    lsl	w27,	w21,	#16
    movz	fp,	#436
    lsl	w21,	w9,	#2
    add	w1,	w27,	w15
    movk	fp,	#2,	lsl #16
    add	x10,	x17,	x21
    ldr	w16,	[x10]

    ldr	x19,	[sp, fp]

    lsl	w2,	w16,	#8
    add	x9,	x19,	x12
    add	w1,	w1,	w2
    ldr	w13,	[x9]

    add	w7,	w1,	w13
    add	w1,	w0,	#1
    mov	w10,	w1
    str	w7,	[x3]

    b	main_70

main_215:
    mov	w18,	w20
    mov	w1,	w10

main_217:
    lsl	w6,	w1,	#2
    lsl	w12,	w18,	#2
    movz	fp,	#436
    add	w2,	w18,	#1
    add	w0,	w18,	#2
    add	w21,	w1,	#1
    mov	x4,	x6
    movk	fp,	#2,	lsl #16
    lsl	w27,	w2,	#2
    add	x4,	sp,	x4
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x13,	x3,	x12
    add	x4,	x4,	#16
    movk	fp,	#2,	lsl #16
    lsl	w12,	w0,	#2
    ldr	w19,	[x13]

    ldr	x2,	[sp, fp]

    lsl	w20,	w19,	#24
    movz	fp,	#436
    add	x3,	x2,	x27
    add	w19,	w18,	#4
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x3]

    ldr	x3,	[sp, fp]

    lsl	w10,	w8,	#16
    movz	fp,	#436
    add	x2,	x3,	x12
    add	w10,	w10,	w20
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x2]

    add	w2,	w18,	#3
    lsl	w9,	w7,	#8
    ldr	x7,	[sp, fp]

    add	w9,	w10,	w9
    lsl	w20,	w2,	#2
    add	x3,	x7,	x20
    ldr	w12,	[x3]

    add	w20,	w9,	w12
    str	w20,	[x4]

    cmp	w21,	#16
    bge	main_241

main_216:
    mov	w18,	w19
    mov	w1,	w21
    b	main_217

main_241:
    mov	w13,	w21
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]


main_242:
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#476
    lsl	w19,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x19
    add	x17,	sp,	x17
    ldr	w24,	[sp, fp]

    movz	fp,	#476
    sub	w21,	w24,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w1,	w21,	#2
    mov	x27,	x1
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    ldr	w2,	[x27]

    ldr	w3,	[sp, fp]

    movz	fp,	#476
    sub	w4,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w4,	#2
    mov	x6,	x8
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w9,	[x6]

    ldr	w3,	[sp, fp]

    add	w6,	w9,	w2
    movz	fp,	#476
    sub	w20,	w3,	#14
    movk	fp,	#2,	lsl #16
    sub	w12,	w2,	w6
    lsl	w27,	w20,	#2
    mov	x21,	x27
    add	w18,	w12,	w9
    add	x21,	sp,	x21
    sub	w7,	w18,	w6
    add	x21,	x21,	#16
    ldr	w0,	[x21]

    ldr	w4,	[sp, fp]

    add	w27,	w0,	w7
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    sub	w1,	w7,	w27
    add	w6,	w1,	w0
    sub	w0,	w4,	#16
    sub	w20,	w6,	w27
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w20
    sub	w9,	w20,	w2
    add	w10,	w9,	w3
    sub	w13,	w10,	w2
    asr	w0,	w13,	#31
    lsl	w6,	w13,	#1
    lsr	w1,	w0,	#31
    add	w2,	w13,	w1
    asr	w10,	w2,	#1
    lsl	w12,	w10,	#1
    sub	w3,	w13,	w12
    add	w4,	w6,	w3
    str	w4,	[x17]

    ldr	w16,	[sp, fp]

    movz	fp,	#476
    add	w7,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w20,	w11
    movz	fp,	#428
    mov	w1,	w28
    mov	w16,	w14
    mov	w7,	w5
    mov	w2,	w26
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    mov	w27,	w4
    str	w20,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]


main_277:
    movz	w1,	#48348
    movz	w12,	#60289
    movz	w27,	#31129
    movz	w20,	#65535
    movz	fp,	#412
    movk	w1,	#36635,	lsl #16
    movk	w12,	#28377,	lsl #16
    movk	w27,	#23170,	lsl #16
    movk	w20,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w1
    mov	w8,	w12
    mov	w15,	w27
    mov	w16,	w20
    ldr	w13,	[sp, fp]

    movz	w1,	#49414
    movk	w1,	#51810,	lsl #16
    cmp	w13,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w12,	w16
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    add	w0,	w20,	w17
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    sub	w4,	w12,	w9
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    add	w9,	w17,	w4
    add	w12,	w9,	w0
    sub	w6,	w0,	w12
    add	w20,	w6,	w9
    mov	w9,	w15
    sub	w27,	w20,	w12
    sub	w0,	w27,	w20
    add	w6,	w0,	w12
    sub	w6,	w6,	w20
    mov	w4,	w6
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    cmp	w17,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    mov	w9,	w8
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#424
    add	w4,	w27,	w21
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w12,	w19,	w4
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#416
    add	w21,	w12,	w6
    movk	fp,	#2,	lsl #16
    sub	w20,	w21,	w4
    ldr	w4,	[sp, fp]

    movz	fp,	#416
    add	w0,	w4,	w20
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    sub	w4,	w20,	w0
    add	w4,	w4,	w27
    sub	w6,	w4,	w0
    mov	w17,	w6
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#416
    add	w21,	w7,	w4
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    add	w9,	w7,	w19
    movk	fp,	#2,	lsl #16
    add	w27,	w9,	w21
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w21,	w27
    add	w12,	w0,	w9
    sub	w0,	w12,	w27
    sub	w6,	w0,	w12
    add	w9,	w6,	w27
    sub	w4,	w9,	w12
    ldr	w12,	[sp, fp]

    add	w12,	w17,	w12
    add	w20,	w12,	w4
    sub	w21,	w4,	w20
    add	w9,	w21,	w12
    sub	w17,	w9,	w20
    sub	w0,	w17,	w9
    add	w6,	w0,	w20
    sub	w6,	w6,	w9
    mov	w9,	w18
    mov	w17,	w6
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    add	w0,	w17,	w7
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w7,	w0
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    add	w9,	w9,	w20
    movk	fp,	#2,	lsl #16
    sub	w9,	w9,	w0
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w0,	w17,	w9
    sub	w27,	w9,	w0
    ldr	w9,	[sp, fp]

    add	w6,	w27,	w9
    mov	w9,	w1
    sub	w6,	w6,	w0
    mov	w17,	w6

main_413:
    mov	w4,	w17

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w12,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#428
    asr	w17,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w21,	w17,	#27
    ldr	w13,	[sp, fp]

    movz	fp,	#428
    add	w17,	w13,	w21
    movk	fp,	#2,	lsl #16
    asr	w17,	w17,	#5
    ldr	w19,	[sp, fp]

    movz	fp,	#412
    lsl	w20,	w17,	#5
    movk	fp,	#2,	lsl #16
    sub	w17,	w19,	w20
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    lsl	w0,	w20,	#2
    add	w21,	w12,	w17
    movk	fp,	#2,	lsl #16
    mov	x0,	x0
    add	x0,	sp,	x0
    add	w27,	w21,	w2
    add	x0,	x0,	#16
    add	w4,	w27,	w4
    ldr	w12,	[x0]

    add	w6,	w4,	w9
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w9,	w6,	w12
    lsl	w6,	w17,	#30
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    asr	w2,	w17,	#31
    movk	fp,	#2,	lsl #16
    lsr	w4,	w2,	#2
    ldr	w10,	[sp, fp]

    movz	fp,	#424
    add	w20,	w10,	w4
    movk	fp,	#2,	lsl #16
    asr	w4,	w20,	#30
    ldr	w17,	[sp, fp]

    movz	fp,	#412
    lsl	w4,	w4,	#30
    movk	fp,	#2,	lsl #16
    sub	w17,	w17,	w4
    ldr	w7,	[sp, fp]

    add	w21,	w7,	#1
    add	w17,	w6,	w17
    cmp	w21,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w2,	w16
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w20,	w17,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w2,	w1
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w1,	w10,	w0
    add	w4,	w1,	w20
    sub	w12,	w20,	w4
    add	w8,	w12,	w1
    mov	w12,	w15
    sub	w13,	w8,	w4
    sub	w16,	w13,	w8
    add	w19,	w16,	w4
    sub	w18,	w19,	w8
    mov	w20,	w18
    b	main_347

main_364:
    cmp	w21,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w12,	w17,	w19
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w19,	w3,	w12
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w17
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w12
    ldr	w24,	[sp, fp]

    add	w16,	w15,	w0
    sub	w2,	w0,	w16
    mov	w0,	w8
    add	w6,	w2,	w24
    sub	w15,	w6,	w16
    b	main_375

main_378:
    cmp	w21,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#428
    add	w16,	w17,	w20
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    add	w15,	w1,	w7
    movk	fp,	#2,	lsl #16
    add	w0,	w15,	w16
    ldr	w24,	[sp, fp]

    add	w8,	w24,	w17
    sub	w1,	w16,	w0
    add	w2,	w1,	w15
    sub	w13,	w2,	w0
    sub	w15,	w13,	w2
    add	w0,	w15,	w0
    sub	w2,	w0,	w2
    add	w0,	w8,	w2
    sub	w6,	w2,	w0
    add	w27,	w6,	w8
    sub	w13,	w27,	w0
    sub	w19,	w13,	w27
    add	w1,	w19,	w0
    sub	w13,	w1,	w27
    mov	w1,	w18
    mov	w16,	w13
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w12,	w17,	w0
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w16,	w12
    movk	fp,	#2,	lsl #16
    add	w6,	w4,	w17
    ldr	w27,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w6,	w12
    ldr	w6,	[sp, fp]

    add	w15,	w27,	w0
    sub	w8,	w0,	w15
    add	w2,	w8,	w6
    sub	w15,	w2,	w15
    mov	w16,	w15

main_398:
    mov	w15,	w16
    mov	w0,	w1

main_375:
    mov	w20,	w15
    mov	w12,	w0

main_347:
    lsl	w13,	w9,	#5
    asr	w1,	w9,	#31
    lsl	w19,	w21,	#2
    movz	fp,	#416
    lsr	w2,	w1,	#27
    add	w21,	w21,	#1
    mov	x15,	x19
    movk	fp,	#2,	lsl #16
    add	w4,	w9,	w2
    add	x15,	sp,	x15
    asr	w4,	w4,	#5
    add	x15,	x15,	#16
    lsl	w6,	w4,	#5
    ldr	w0,	[x15]

    sub	w6,	w9,	w6
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w4,	w6,	w18
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w6,	w4,	w13
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    add	w15,	w6,	w20
    movz	fp,	#428
    asr	w10,	w25,	#31
    movk	fp,	#2,	lsl #16
    add	w6,	w15,	w12
    lsr	w18,	w10,	#2
    add	w16,	w6,	w0
    ldr	w0,	[sp, fp]

    lsl	w6,	w3,	#30
    movz	fp,	#428
    add	w15,	w0,	w18
    movk	fp,	#2,	lsl #16
    asr	w2,	w15,	#30
    ldr	w3,	[sp, fp]

    lsl	w4,	w2,	#30
    sub	w12,	w3,	w4
    add	w18,	w6,	w12
    cmp	w21,	#80
    blt	main_276

main_433:
    add	w15,	w16,	w11
    add	w19,	w18,	w14
    add	w6,	w17,	w5
    movz	fp,	#432
    add	w27,	w22,	#64
    add	w16,	w9,	w28
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w8,	w7,	w26
    cmp	w27,	w23
    blt	main_62

main_441:
    movz	fp,	#488
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#496
    str	w15,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#480
    str	w16,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#548
    str	w19,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#512
    str	w6,	[x22]

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

    add	w3,	w15,	w16
    sub	w0,	w16,	w3
    add	w16,	w0,	w15
    sub	w20,	w16,	w3
    str	w20,	[x22]

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

    mov	w1,	w6
    b	main_28

main_62:
    mov	w11,	w15
    mov	w28,	w16
    mov	w14,	w19
    mov	w5,	w6
    mov	w26,	w8
    mov	w22,	w27
    b	main_63

main_276:
    mov	w15,	w16
    movz	fp,	#428
    mov	w3,	w9
    mov	w10,	w17
    mov	w7,	w21
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    mov	w10,	w18
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#412
    mov	w2,	w8
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#536
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


