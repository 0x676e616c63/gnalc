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
    movz	w23,	#0
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
    movz	w2,	#0
    movz	w4,	#0
    movz	w6,	#0
    movz	fp,	#356
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#476
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

    movz	fp,	#468
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#392
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
    movz	fp,	#468
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

    movz	fp,	#460
    add	x23,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x23]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    add	w23,	w3,	#4
    bl	memset
    movz	w17,	#8961
    movz	w26,	#43913
    movz	w3,	#56574
    movz	w2,	#21622
    movz	w19,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w2,	#4146,	lsl #16
    movk	w19,	#50130,	lsl #16
    mov	w10,	w17
    mov	w28,	w26
    mov	w4,	w3
    mov	w14,	w2
    mov	w21,	w19
    movz	w26,	#0
    mov	w27,	w26

main_63:
    movz	w16,	#0
    mov	w20,	w27
    mov	w12,	w16

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w16,	w12,	#2
    lsl	w3,	w20,	#2
    movz	fp,	#436
    add	w0,	w20,	#1
    add	w12,	w12,	#1
    mov	x16,	x16
    movk	fp,	#2,	lsl #16
    add	x16,	sp,	x16
    lsl	w17,	w0,	#2
    ldr	x26,	[sp, fp]

    add	x16,	x16,	#16
    movz	fp,	#436
    add	x2,	x26,	x3
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w11,	w6,	#24
    movz	fp,	#436
    add	x1,	x9,	x17
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x1]

    ldr	x22,	[sp, fp]

    lsl	w6,	w3,	#16
    movz	fp,	#436
    add	w8,	w6,	w11
    movk	fp,	#2,	lsl #16
    add	w6,	w20,	#3
    add	w11,	w20,	#2
    lsl	w5,	w11,	#2
    add	w11,	w20,	#4
    add	x18,	x22,	x5
    lsl	w5,	w12,	#2
    mov	x3,	x5
    ldr	w0,	[x18]

    add	x3,	sp,	x3
    ldr	x26,	[sp, fp]

    lsl	w1,	w0,	#8
    movz	fp,	#436
    add	x3,	x3,	#16
    add	w2,	w8,	w1
    movk	fp,	#2,	lsl #16
    lsl	w8,	w6,	#2
    add	x7,	x26,	x8
    lsl	w26,	w11,	#2
    ldr	w13,	[x7]

    add	w7,	w2,	w13
    str	w7,	[x16]

    add	w16,	w11,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#436
    add	x22,	x6,	x26
    movk	fp,	#2,	lsl #16
    add	w26,	w11,	#1
    lsl	w8,	w16,	#2
    ldr	w0,	[x22]

    lsl	w13,	w26,	#2
    lsl	w19,	w0,	#24
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x0,	x0,	x13
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    ldr	x2,	[sp, fp]

    lsl	w6,	w5,	#16
    movz	fp,	#436
    add	x0,	x2,	x8
    add	w9,	w6,	w19
    movk	fp,	#2,	lsl #16
    add	w8,	w11,	#3
    ldr	w2,	[x0]

    ldr	x7,	[sp, fp]

    lsl	w5,	w2,	#8
    lsl	w17,	w8,	#2
    movz	fp,	#436
    add	w18,	w9,	w5
    movk	fp,	#2,	lsl #16
    add	w5,	w12,	#1
    add	x9,	x7,	x17
    lsl	w8,	w5,	#2
    ldr	w19,	[x9]

    add	w9,	w11,	#4
    add	w2,	w18,	w19
    add	w7,	w9,	#1
    str	w2,	[x3]

    ldr	x0,	[sp, fp]

    lsl	w3,	w9,	#2
    mov	x2,	x8
    movz	fp,	#436
    lsl	w13,	w7,	#2
    add	x1,	x0,	x3
    add	x2,	sp,	x2
    movk	fp,	#2,	lsl #16
    add	w3,	w9,	#3
    ldr	w6,	[x1]

    add	x2,	x2,	#16
    ldr	x18,	[sp, fp]

    lsl	w1,	w6,	#24
    movz	fp,	#436
    add	x11,	x18,	x13
    movk	fp,	#2,	lsl #16
    add	w18,	w9,	#2
    ldr	w13,	[x11]

    lsl	w26,	w18,	#2
    lsl	w15,	w13,	#16
    ldr	x18,	[sp, fp]

    add	w13,	w15,	w1
    movz	fp,	#436
    add	x19,	x18,	x26
    movk	fp,	#2,	lsl #16
    ldr	w26,	[x19]

    add	w19,	w5,	#1
    ldr	x6,	[sp, fp]

    lsl	w0,	w26,	#8
    add	w5,	w9,	#4
    movz	fp,	#436
    lsl	w26,	w19,	#2
    add	w1,	w13,	w0
    lsl	w20,	w5,	#2
    movk	fp,	#2,	lsl #16
    mov	x22,	x26
    lsl	w0,	w3,	#2
    add	x22,	sp,	x22
    add	x16,	x6,	x0
    add	w6,	w5,	#1
    add	x22,	x22,	#16
    ldr	w3,	[x16]

    add	w8,	w1,	w3
    add	w3,	w5,	#2
    lsl	w1,	w6,	#2
    add	w6,	w5,	#4
    str	w8,	[x2]

    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x17,	x8,	x20
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x17]

    add	w17,	w5,	#3
    ldr	x9,	[sp, fp]

    lsl	w2,	w0,	#24
    movz	fp,	#436
    add	x7,	x9,	x1
    movk	fp,	#2,	lsl #16
    lsl	w26,	w17,	#2
    ldr	w9,	[x7]

    lsl	w13,	w9,	#16
    ldr	x9,	[sp, fp]

    add	w0,	w13,	w2
    movz	fp,	#436
    lsl	w13,	w3,	#2
    movk	fp,	#2,	lsl #16
    add	w3,	w19,	#1
    add	x8,	x9,	x13
    ldr	w11,	[x8]

    add	w8,	w3,	#1
    lsl	w12,	w11,	#8
    ldr	x11,	[sp, fp]

    add	w2,	w0,	w12
    movz	fp,	#436
    add	x18,	x11,	x26
    movk	fp,	#2,	lsl #16
    add	w26,	w6,	#2
    add	w11,	w6,	#1
    ldr	w1,	[x18]

    lsl	w26,	w26,	#2
    lsl	w11,	w11,	#2
    add	w2,	w2,	w1
    lsl	w1,	w3,	#2
    mov	x16,	x1
    str	w2,	[x22]

    lsl	w1,	w6,	#2
    add	x16,	sp,	x16
    ldr	x18,	[sp, fp]

    movz	fp,	#436
    add	x0,	x18,	x1
    movk	fp,	#2,	lsl #16
    add	x16,	x16,	#16
    ldr	w2,	[x0]

    ldr	x18,	[sp, fp]

    lsl	w5,	w2,	#24
    movz	fp,	#436
    add	x12,	x18,	x11
    movk	fp,	#2,	lsl #16
    add	w11,	w6,	#4
    ldr	w17,	[x12]

    add	w20,	w11,	#3
    lsl	w19,	w11,	#2
    ldr	x12,	[sp, fp]

    lsl	w18,	w17,	#16
    movz	fp,	#436
    add	x0,	x12,	x26
    add	w17,	w18,	w5
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    ldr	x22,	[sp, fp]

    add	w0,	w6,	#3
    lsl	w9,	w5,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w0,	#2
    add	w9,	w17,	w9
    lsl	w17,	w8,	#2
    add	x1,	x22,	x2
    ldr	w5,	[x1]

    mov	x1,	x17
    add	w5,	w9,	w5
    add	x1,	sp,	x1
    add	w9,	w11,	#1
    str	w5,	[x16]

    add	x1,	x1,	#16
    lsl	w6,	w9,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x18,	x2,	x19
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x18]

    ldr	x25,	[sp, fp]

    lsl	w2,	w22,	#24
    movz	fp,	#436
    add	x12,	x25,	x6
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x12]

    ldr	x6,	[sp, fp]

    add	w12,	w11,	#2
    lsl	w3,	w0,	#16
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w5,	w12,	#2
    add	w3,	w3,	w2
    lsl	w2,	w20,	#2
    add	x15,	x6,	x5
    add	w6,	w11,	#4
    ldr	w18,	[x15]

    add	w9,	w6,	#2
    add	w17,	w6,	#1
    ldr	x7,	[sp, fp]

    lsl	w19,	w18,	#8
    movz	fp,	#436
    add	x0,	x7,	x2
    lsl	w22,	w9,	#2
    lsl	w12,	w17,	#2
    add	w18,	w3,	w19
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    add	w0,	w8,	#1
    add	w26,	w18,	w5
    add	w8,	w6,	#3
    lsl	w5,	w0,	#2
    str	w26,	[x1]

    mov	x3,	x5
    ldr	x16,	[sp, fp]

    lsl	w1,	w6,	#2
    add	x3,	sp,	x3
    movz	fp,	#436
    add	x13,	x16,	x1
    movk	fp,	#2,	lsl #16
    add	x3,	x3,	#16
    ldr	w2,	[x13]

    ldr	x16,	[sp, fp]

    lsl	w15,	w2,	#24
    movz	fp,	#436
    add	x18,	x16,	x12
    movk	fp,	#2,	lsl #16
    lsl	w12,	w8,	#2
    ldr	w20,	[x18]

    ldr	x17,	[sp, fp]

    lsl	w26,	w20,	#16
    movz	fp,	#436
    add	x11,	x17,	x22
    add	w20,	w6,	#4
    add	w1,	w26,	w15
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x11]

    ldr	x19,	[sp, fp]

    lsl	w2,	w16,	#8
    add	x11,	x19,	x12
    add	w1,	w1,	w2
    ldr	w13,	[x11]

    add	w7,	w1,	w13
    add	w1,	w0,	#1
    mov	w12,	w1
    str	w7,	[x3]

    b	main_70

main_215:
    mov	w18,	w20
    mov	w1,	w12

main_217:
    lsl	w7,	w1,	#2
    lsl	w12,	w18,	#2
    movz	fp,	#436
    add	w2,	w18,	#1
    add	w0,	w18,	#2
    add	w22,	w1,	#1
    mov	x5,	x7
    movk	fp,	#2,	lsl #16
    lsl	w26,	w2,	#2
    add	x5,	sp,	x5
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x15,	x3,	x12
    add	x5,	x5,	#16
    movk	fp,	#2,	lsl #16
    lsl	w12,	w0,	#2
    ldr	w17,	[x15]

    ldr	x2,	[sp, fp]

    lsl	w19,	w17,	#24
    movz	fp,	#436
    add	x6,	x2,	x26
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x6]

    ldr	x3,	[sp, fp]

    lsl	w9,	w8,	#16
    movz	fp,	#436
    add	x2,	x3,	x12
    add	w9,	w9,	w19
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x2]

    add	w2,	w18,	#3
    lsl	w11,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w9,	w11
    lsl	w19,	w2,	#2
    add	x6,	x8,	x19
    ldr	w11,	[x6]

    add	w19,	w9,	w11
    str	w19,	[x5]

    add	w19,	w18,	#4
    cmp	w22,	#16
    bge	main_241

main_216:
    mov	w18,	w19
    mov	w1,	w22
    b	main_217

main_241:
    mov	w13,	w22
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]


main_242:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#516
    lsl	w19,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x16,	x19
    add	x16,	sp,	x16
    ldr	w24,	[sp, fp]

    movz	fp,	#516
    sub	w22,	w24,	#3
    add	x16,	x16,	#16
    movk	fp,	#2,	lsl #16
    lsl	w1,	w22,	#2
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w2,	[x0]

    ldr	w3,	[sp, fp]

    movz	fp,	#516
    sub	w5,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w5,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w9,	[x7]

    ldr	w3,	[sp, fp]

    add	w7,	w9,	w2
    movz	fp,	#516
    sub	w20,	w3,	#14
    movk	fp,	#2,	lsl #16
    sub	w12,	w2,	w7
    lsl	w26,	w20,	#2
    mov	x22,	x26
    add	w17,	w12,	w9
    add	x22,	sp,	x22
    sub	w7,	w17,	w7
    add	x22,	x22,	#16
    ldr	w1,	[x22]

    add	w26,	w1,	w7
    sub	w0,	w7,	w26
    add	w5,	w0,	w1
    sub	w20,	w5,	w26
    ldr	w5,	[sp, fp]

    movz	fp,	#516
    sub	w0,	w5,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w20
    sub	w9,	w20,	w2
    add	w11,	w9,	w3
    sub	w11,	w11,	w2
    asr	w0,	w11,	#31
    lsl	w6,	w11,	#1
    lsr	w1,	w0,	#31
    add	w2,	w11,	w1
    asr	w12,	w2,	#1
    lsl	w13,	w12,	#1
    sub	w3,	w11,	w13
    add	w6,	w6,	w3
    str	w6,	[x16]

    ldr	w16,	[sp, fp]

    movz	fp,	#516
    add	w7,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w22,	w10
    movz	fp,	#428
    mov	w1,	w28
    mov	w15,	w4
    mov	w9,	w14
    mov	w2,	w21
    movz	w3,	#0
    movk	fp,	#2,	lsl #16
    mov	w26,	w3
    str	w22,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]


main_277:
    movz	w3,	#48348
    movz	w12,	#60289
    movz	w26,	#31129
    movz	w20,	#65535
    movz	fp,	#412
    movk	w3,	#36635,	lsl #16
    movk	w12,	#28377,	lsl #16
    movk	w26,	#23170,	lsl #16
    movk	w20,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w3
    mov	w8,	w12
    mov	w15,	w26
    mov	w16,	w20
    ldr	w13,	[sp, fp]

    movz	w3,	#49414
    movk	w3,	#51810,	lsl #16
    mov	w1,	w3
    cmp	w13,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w9,	w16
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#424
    add	w5,	w22,	w17
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    sub	w11,	w9,	w12
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w17,	w13,	w11
    add	w3,	w17,	w5
    sub	w12,	w5,	w3
    add	w26,	w12,	w17
    sub	w22,	w26,	w3
    sub	w11,	w22,	w26
    add	w11,	w11,	w3
    sub	w11,	w11,	w26
    mov	w22,	w11
    mov	w11,	w15
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
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#424
    add	w11,	w24,	w22
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    sub	w20,	w20,	w11
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    add	w3,	w20,	w5
    movk	fp,	#2,	lsl #16
    mov	w20,	w8
    sub	w22,	w3,	w11
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w9,	w5,	w22
    ldr	w26,	[sp, fp]

    sub	w11,	w22,	w9
    add	w11,	w11,	w26
    sub	w11,	w11,	w9
    mov	w5,	w11
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    cmp	w20,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    add	w26,	w9,	w5
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    add	w17,	w9,	w20
    movk	fp,	#2,	lsl #16
    add	w12,	w17,	w26
    sub	w5,	w26,	w12
    add	w5,	w5,	w17
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w5,	w12
    movk	fp,	#2,	lsl #16
    sub	w11,	w9,	w5
    add	w3,	w11,	w12
    ldr	w12,	[sp, fp]

    add	w9,	w17,	w12
    sub	w11,	w3,	w5
    add	w22,	w9,	w11
    sub	w26,	w11,	w22
    add	w20,	w26,	w9
    sub	w12,	w20,	w22
    sub	w9,	w12,	w20
    add	w11,	w9,	w22
    sub	w11,	w11,	w20
    mov	w20,	w18
    mov	w5,	w11
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w9,	w13,	w9
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w12,	w7,	w9
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    add	w12,	w12,	w20
    movk	fp,	#2,	lsl #16
    mov	w20,	w1
    sub	w5,	w12,	w9
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w9,	w19,	w5
    ldr	w11,	[sp, fp]

    sub	w22,	w5,	w9
    add	w12,	w22,	w11
    sub	w11,	w12,	w9
    mov	w5,	w11

main_413:
    mov	w22,	w5
    mov	w11,	w20

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w17,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#428
    asr	w12,	w7,	#31
    movk	fp,	#2,	lsl #16
    lsr	w9,	w12,	#27
    ldr	w13,	[sp, fp]

    movz	fp,	#428
    add	w20,	w13,	w9
    movk	fp,	#2,	lsl #16
    asr	w12,	w20,	#5
    ldr	w20,	[sp, fp]

    lsl	w12,	w12,	#5
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    sub	w20,	w20,	w12
    ldr	w24,	[sp, fp]

    movz	fp,	#424
    lsl	w9,	w24,	#2
    add	w20,	w17,	w20
    movk	fp,	#2,	lsl #16
    mov	x26,	x9
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w12,	[x26]

    ldr	w19,	[sp, fp]

    add	w26,	w20,	w2
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w20,	w26,	w22
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w26,	w20,	w11
    movk	fp,	#2,	lsl #16
    lsl	w11,	w19,	#30
    ldr	w7,	[sp, fp]

    add	w9,	w26,	w12
    movz	fp,	#424
    asr	w12,	w13,	#31
    movk	fp,	#2,	lsl #16
    lsr	w17,	w12,	#2
    ldr	w13,	[sp, fp]

    movz	fp,	#412
    add	w20,	w7,	w17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    asr	w2,	w20,	#30
    lsl	w12,	w2,	#30
    add	w2,	w7,	#1
    sub	w17,	w13,	w12
    add	w17,	w11,	w17
    cmp	w2,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w26,	w16
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w20,	w17,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w26,	w1
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    add	w1,	w12,	w0
    mov	w12,	w15
    add	w11,	w1,	w20
    sub	w18,	w20,	w11
    add	w16,	w18,	w1
    sub	w18,	w16,	w11
    sub	w19,	w18,	w16
    add	w22,	w19,	w11
    sub	w19,	w22,	w16
    mov	w22,	w19
    b	main_347

main_364:
    cmp	w2,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w15,	w17,	w18
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    sub	w20,	w5,	w15
    movk	fp,	#2,	lsl #16
    add	w0,	w20,	w17
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w15
    ldr	w22,	[sp, fp]

    add	w18,	w16,	w0
    sub	w3,	w0,	w18
    add	w16,	w3,	w22
    mov	w3,	w8
    sub	w16,	w16,	w18
    b	main_375

main_378:
    cmp	w2,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#428
    add	w22,	w17,	w20
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    add	w19,	w1,	w8
    movk	fp,	#2,	lsl #16
    add	w1,	w19,	w22
    sub	w8,	w22,	w1
    ldr	w22,	[sp, fp]

    add	w3,	w8,	w19
    add	w8,	w22,	w17
    sub	w15,	w3,	w1
    sub	w16,	w15,	w3
    add	w0,	w16,	w1
    sub	w3,	w0,	w3
    add	w0,	w8,	w3
    sub	w12,	w3,	w0
    add	w26,	w12,	w8
    sub	w16,	w26,	w0
    sub	w22,	w16,	w26
    add	w1,	w22,	w0
    sub	w15,	w1,	w26
    mov	w1,	w18
    mov	w19,	w15
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w15,	w17,	w3
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    sub	w5,	w18,	w15
    movk	fp,	#2,	lsl #16
    add	w8,	w5,	w17
    ldr	w26,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w8,	w15
    ldr	w7,	[sp, fp]

    add	w18,	w26,	w0
    sub	w8,	w0,	w18
    add	w3,	w8,	w7
    sub	w16,	w3,	w18
    mov	w19,	w16

main_398:
    mov	w16,	w19
    mov	w3,	w1

main_375:
    mov	w22,	w16
    mov	w12,	w3

main_347:
    lsl	w26,	w9,	#5
    asr	w1,	w9,	#31
    lsl	w20,	w2,	#2
    movz	fp,	#416
    lsr	w3,	w1,	#27
    mov	x18,	x20
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    add	w5,	w9,	w3
    add	x18,	x18,	#16
    asr	w8,	w5,	#5
    ldr	w0,	[x18]

    lsl	w15,	w8,	#5
    ldr	w19,	[sp, fp]

    sub	w11,	w9,	w15
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w5,	w11,	w19
    add	w8,	w5,	w26
    ldr	w5,	[sp, fp]

    movz	fp,	#428
    add	w16,	w8,	w22
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    add	w8,	w16,	w12
    movz	fp,	#428
    asr	w13,	w25,	#31
    lsl	w12,	w5,	#30
    movk	fp,	#2,	lsl #16
    add	w19,	w8,	w0
    lsr	w18,	w13,	#2
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w16,	w0,	w18
    movk	fp,	#2,	lsl #16
    add	w18,	w2,	#1
    asr	w3,	w16,	#30
    ldr	w5,	[sp, fp]

    lsl	w8,	w3,	#30
    sub	w15,	w5,	w8
    add	w20,	w12,	w15
    cmp	w18,	#80
    blt	main_276

main_433:
    add	w13,	w19,	w10
    add	w11,	w9,	w28
    add	w4,	w20,	w4
    add	w17,	w17,	w14
    movz	fp,	#432
    add	w6,	w27,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w22,	w7,	w21
    cmp	w6,	w23
    blt	main_62

main_441:
    movz	fp,	#444
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#452
    str	w13,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#548
    str	w11,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#540
    str	w4,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#524
    str	w17,	[x21]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w22,	[x23]


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

    mov	w1,	w6
    b	main_28

main_62:
    mov	w10,	w13
    mov	w28,	w11
    mov	w14,	w17
    mov	w21,	w22
    mov	w27,	w6
    b	main_63

main_276:
    mov	w16,	w19
    movz	fp,	#428
    mov	w0,	w9
    mov	w12,	w17
    mov	w7,	w18
    mov	w11,	w20
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#412
    mov	w2,	w8
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#476
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


