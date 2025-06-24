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
    mov	w22,	w0
    bl	getint
    mov	w27,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	w6,	#0
    movz	w5,	#0
    movz	w4,	#0
    movz	fp,	#356
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
    add	x20,	sp,	#16
    mov	x26,	x21
    add	x8,	x21,	#12
    add	x16,	x21,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x21,	#4
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#532
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x21,	#8
    mov	w0,	w22
    str	x25,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#524
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
    lsr	w20,	w18,	#15
    add	w21,	w1,	w20
    asr	w20,	w21,	#17
    add	w3,	w1,	w20
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
    movz	fp,	#532
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w8,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w25,	w8,	#31
    lsr	w26,	w25,	#26
    add	w28,	w8,	w26
    asr	w1,	w28,	#6
    lsl	w2,	w1,	#6
    sub	w26,	w8,	w2
    cmp	w26,	#60
    beq	main_53

main_50:
    lsl	w3,	w8,	#2
    movz	fp,	#436
    movz	w0,	#0
    add	w12,	w8,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w12
    ldr	x5,	[sp, fp]

    add	x6,	x5,	x3
    str	w0,	[x6]

    b	main_46

main_53:
    lsl	w26,	w8,	#2
    movz	fp,	#436
    add	w22,	w8,	#1
    movz	w23,	#125
    add	w20,	w8,	#4
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x25,	x28,	x26
    movk	fp,	#2,	lsl #16
    movz	w26,	#0
    movz	w28,	#0
    str	w28,	[x25]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    add	w1,	w8,	#3
    ldr	x0,	[sp, fp]

    add	w26,	w8,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    lsl	w26,	w1,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    str	w23,	[x22]

    ldr	x1,	[sp, fp]

    movz	fp,	#452
    add	x25,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x25]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w27,	#0
    movz	w17,	#8961
    movz	w23,	#43913
    movz	w5,	#21622
    movz	w3,	#56574
    movk	w17,	#26437,	lsl #16
    movk	w23,	#61389,	lsl #16
    movk	w5,	#4146,	lsl #16
    movk	w3,	#39098,	lsl #16
    mov	w26,	w17
    mov	w21,	w23
    mov	w14,	w5
    mov	w13,	w3
    movz	w17,	#57840
    mov	w23,	w27
    movk	w17,	#50130,	lsl #16
    mov	w6,	w17

main_63:
    movz	w17,	#0
    mov	w25,	w23
    mov	w10,	w17

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w15,	w10,	#2
    lsl	w3,	w25,	#2
    movz	fp,	#436
    add	w0,	w25,	#1
    add	w11,	w25,	#2
    add	w10,	w10,	#1
    mov	x15,	x15
    movk	fp,	#2,	lsl #16
    lsl	w16,	w0,	#2
    add	x15,	sp,	x15
    lsl	w7,	w11,	#2
    lsl	w12,	w10,	#2
    ldr	x28,	[sp, fp]

    add	w11,	w25,	#4
    add	x15,	x15,	#16
    movz	fp,	#436
    add	x2,	x28,	x3
    movk	fp,	#2,	lsl #16
    add	w22,	w11,	#2
    ldr	w4,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w18,	w4,	#24
    movz	fp,	#436
    add	x1,	x9,	x16
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x1]

    ldr	x24,	[sp, fp]

    lsl	w4,	w3,	#16
    movz	fp,	#436
    add	x17,	x24,	x7
    add	w5,	w4,	w18
    movk	fp,	#2,	lsl #16
    add	w7,	w25,	#3
    ldr	w0,	[x17]

    ldr	x28,	[sp, fp]

    lsl	w1,	w0,	#8
    lsl	w17,	w7,	#2
    movz	fp,	#436
    add	w2,	w5,	w1
    movk	fp,	#2,	lsl #16
    add	x9,	x28,	x17
    lsl	w28,	w11,	#2
    ldr	w18,	[x9]

    add	w5,	w2,	w18
    str	w5,	[x15]

    ldr	x8,	[sp, fp]

    mov	x5,	x12
    movz	fp,	#436
    add	x27,	x8,	x28
    add	x5,	sp,	x5
    movk	fp,	#2,	lsl #16
    add	w28,	w11,	#1
    ldr	w0,	[x27]

    add	x5,	x5,	#16
    lsl	w18,	w0,	#24
    lsl	w17,	w28,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x0,	x0,	x17
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x0]

    ldr	x3,	[sp, fp]

    lsl	w7,	w4,	#16
    movz	fp,	#436
    add	w18,	w7,	w18
    movk	fp,	#2,	lsl #16
    lsl	w7,	w22,	#2
    add	x0,	x3,	x7
    add	w7,	w11,	#3
    ldr	w2,	[x0]

    lsl	w16,	w7,	#2
    ldr	x9,	[sp, fp]

    lsl	w3,	w2,	#8
    movz	fp,	#436
    add	x9,	x9,	x16
    movk	fp,	#2,	lsl #16
    add	w18,	w18,	w3
    add	w16,	w11,	#4
    ldr	w17,	[x9]

    add	w3,	w18,	w17
    str	w3,	[x5]

    ldr	x0,	[sp, fp]

    lsl	w3,	w16,	#2
    add	w5,	w10,	#1
    movz	fp,	#436
    add	x1,	x0,	x3
    movk	fp,	#2,	lsl #16
    lsl	w7,	w5,	#2
    ldr	w4,	[x1]

    mov	x2,	x7
    ldr	x17,	[sp, fp]

    lsl	w1,	w4,	#24
    add	w7,	w16,	#1
    add	x2,	sp,	x2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w11,	w7,	#2
    add	x2,	x2,	#16
    add	x8,	x17,	x11
    add	w17,	w16,	#2
    ldr	w11,	[x8]

    lsl	w28,	w17,	#2
    ldr	x18,	[sp, fp]

    lsl	w12,	w11,	#16
    movz	fp,	#436
    add	x18,	x18,	x28
    movk	fp,	#2,	lsl #16
    add	w11,	w12,	w1
    add	w1,	w16,	#3
    ldr	w28,	[x18]

    add	w16,	w16,	#4
    ldr	x4,	[sp, fp]

    lsl	w0,	w28,	#8
    movz	fp,	#436
    add	w3,	w11,	w0
    movk	fp,	#2,	lsl #16
    add	w11,	w5,	#1
    lsl	w0,	w1,	#2
    add	x22,	x4,	x0
    add	w25,	w11,	#1
    lsl	w28,	w11,	#2
    mov	x5,	x28
    ldr	w1,	[x22]

    lsl	w28,	w16,	#2
    add	x5,	sp,	x5
    add	w7,	w3,	w1
    add	x5,	x5,	#16
    str	w7,	[x2]

    ldr	x7,	[sp, fp]

    movz	fp,	#436
    add	x27,	x7,	x28
    movk	fp,	#2,	lsl #16
    add	w7,	w16,	#1
    ldr	w0,	[x27]

    lsl	w15,	w7,	#2
    add	w27,	w16,	#3
    ldr	x3,	[sp, fp]

    lsl	w0,	w0,	#24
    movz	fp,	#436
    add	x8,	x3,	x15
    movk	fp,	#2,	lsl #16
    add	w3,	w16,	#2
    ldr	w18,	[x8]

    lsl	w7,	w3,	#2
    ldr	x12,	[sp, fp]

    lsl	w22,	w18,	#16
    movz	fp,	#436
    add	x4,	x12,	x7
    movk	fp,	#2,	lsl #16
    add	w0,	w22,	w0
    ldr	w10,	[x4]

    ldr	x12,	[sp, fp]

    lsl	w15,	w10,	#8
    movz	fp,	#436
    add	w2,	w0,	w15
    movk	fp,	#2,	lsl #16
    lsl	w0,	w27,	#2
    add	x28,	x12,	x0
    add	w12,	w16,	#4
    ldr	w1,	[x28]

    add	w10,	w12,	#1
    add	w3,	w2,	w1
    lsl	w1,	w25,	#2
    mov	x0,	x1
    str	w3,	[x5]

    lsl	w16,	w10,	#2
    add	w1,	w12,	#2
    add	x0,	sp,	x0
    ldr	x22,	[sp, fp]

    lsl	w3,	w12,	#2
    add	w10,	w12,	#4
    movz	fp,	#436
    add	x0,	x0,	#16
    add	x2,	x22,	x3
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x2]

    ldr	x15,	[sp, fp]

    lsl	w5,	w4,	#24
    movz	fp,	#436
    add	x11,	x15,	x16
    lsl	w4,	w1,	#2
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x11]

    ldr	x15,	[sp, fp]

    lsl	w27,	w17,	#16
    movz	fp,	#436
    add	x2,	x15,	x4
    add	w27,	w27,	w5
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x2]

    add	w2,	w12,	#3
    lsl	w9,	w7,	#8
    add	w12,	w10,	#1
    add	w9,	w27,	w9
    lsl	w4,	w2,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#436
    add	x3,	x27,	x4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    add	w5,	w9,	w5
    lsl	w9,	w12,	#2
    str	w5,	[x0]

    ldr	x3,	[sp, fp]

    add	w5,	w25,	#1
    movz	fp,	#436
    lsl	w25,	w10,	#2
    movk	fp,	#2,	lsl #16
    lsl	w16,	w5,	#2
    add	x17,	x3,	x25
    mov	x2,	x16
    add	x2,	sp,	x2
    ldr	w27,	[x17]

    lsl	w1,	w27,	#24
    add	x2,	x2,	#16
    ldr	x27,	[sp, fp]

    movz	fp,	#436
    add	x18,	x27,	x9
    movk	fp,	#2,	lsl #16
    add	w27,	w10,	#3
    add	w9,	w10,	#2
    ldr	w0,	[x18]

    ldr	x8,	[sp, fp]

    lsl	w3,	w0,	#16
    lsl	w4,	w9,	#2
    movz	fp,	#436
    add	w3,	w3,	w1
    movk	fp,	#2,	lsl #16
    add	x15,	x8,	x4
    lsl	w1,	w27,	#2
    ldr	w17,	[x15]

    ldr	x11,	[sp, fp]

    lsl	w18,	w17,	#8
    movz	fp,	#436
    add	x0,	x11,	x1
    add	w18,	w3,	w18
    movk	fp,	#2,	lsl #16
    add	w1,	w10,	#4
    ldr	w7,	[x0]

    add	w28,	w18,	w7
    add	w10,	w1,	#2
    add	w25,	w1,	#4
    lsl	w0,	w1,	#2
    add	w7,	w5,	#1
    str	w28,	[x2]

    lsl	w22,	w10,	#2
    ldr	x16,	[sp, fp]

    lsl	w8,	w7,	#2
    movz	fp,	#436
    add	x17,	x16,	x0
    mov	x4,	x8
    movk	fp,	#2,	lsl #16
    add	w16,	w1,	#1
    add	x4,	sp,	x4
    ldr	w3,	[x17]

    lsl	w8,	w16,	#2
    ldr	x17,	[sp, fp]

    add	x4,	x4,	#16
    lsl	w15,	w3,	#24
    movz	fp,	#436
    add	x17,	x17,	x8
    movk	fp,	#2,	lsl #16
    add	w8,	w1,	#3
    ldr	w27,	[x17]

    lsl	w10,	w8,	#2
    ldr	x17,	[sp, fp]

    lsl	w28,	w27,	#16
    movz	fp,	#436
    add	x12,	x17,	x22
    movk	fp,	#2,	lsl #16
    add	w0,	w28,	w15
    ldr	w22,	[x12]

    ldr	x19,	[sp, fp]

    lsl	w2,	w22,	#8
    add	x9,	x19,	x10
    add	w3,	w0,	w2
    add	w2,	w7,	#1
    ldr	w12,	[x9]

    mov	w10,	w2
    add	w5,	w3,	w12
    str	w5,	[x4]

    b	main_70

main_215:
    mov	w18,	w25
    mov	w2,	w10

main_217:
    lsl	w5,	w2,	#2
    lsl	w11,	w18,	#2
    movz	fp,	#436
    add	w1,	w18,	#1
    add	w0,	w18,	#2
    add	w27,	w2,	#1
    add	w22,	w18,	#4
    mov	x4,	x5
    movk	fp,	#2,	lsl #16
    lsl	w28,	w1,	#2
    add	x4,	sp,	x4
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x12,	x3,	x11
    add	x4,	x4,	#16
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x12]

    ldr	x1,	[sp, fp]

    lsl	w25,	w16,	#24
    movz	fp,	#436
    add	x7,	x1,	x28
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x7]

    ldr	x3,	[sp, fp]

    lsl	w16,	w10,	#16
    movz	fp,	#436
    add	w17,	w16,	w25
    movk	fp,	#2,	lsl #16
    lsl	w16,	w0,	#2
    add	x1,	x3,	x16
    ldr	w7,	[x1]

    add	w1,	w18,	#3
    lsl	w8,	w7,	#8
    ldr	x7,	[sp, fp]

    add	w9,	w17,	w8
    lsl	w17,	w1,	#2
    add	x7,	x7,	x17
    ldr	w17,	[x7]

    add	w25,	w9,	w17
    str	w25,	[x4]

    cmp	w27,	#16
    bge	main_241

main_216:
    mov	w18,	w22
    mov	w2,	w27
    b	main_217

main_241:
    mov	w12,	w27
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]


main_242:
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#520
    lsl	w22,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x22
    add	x17,	sp,	x17
    ldr	w25,	[sp, fp]

    movz	fp,	#520
    sub	w27,	w25,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w27,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w4,	[x1]

    ldr	w2,	[sp, fp]

    movz	fp,	#520
    sub	w3,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w7,	w3,	#2
    mov	x5,	x7
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w9,	[x5]

    ldr	w3,	[sp, fp]

    add	w5,	w9,	w4
    movz	fp,	#520
    sub	w25,	w3,	#14
    movk	fp,	#2,	lsl #16
    sub	w11,	w4,	w5
    lsl	w28,	w25,	#2
    mov	x27,	x28
    add	w15,	w11,	w9
    add	x27,	sp,	x27
    sub	w5,	w15,	w5
    add	x27,	x27,	#16
    ldr	w2,	[x27]

    ldr	w4,	[sp, fp]

    add	w28,	w2,	w5
    movz	fp,	#520
    movk	fp,	#2,	lsl #16
    sub	w0,	w5,	w28
    add	w10,	w0,	w2
    sub	w0,	w4,	#16
    sub	w25,	w10,	w28
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w25
    sub	w8,	w25,	w2
    add	w10,	w8,	w3
    sub	w15,	w10,	w2
    asr	w0,	w15,	#31
    lsl	w9,	w15,	#1
    lsr	w1,	w0,	#31
    add	w2,	w15,	w1
    asr	w10,	w2,	#1
    lsl	w11,	w10,	#1
    sub	w3,	w15,	w11
    add	w4,	w9,	w3
    str	w4,	[x17]

    ldr	w16,	[sp, fp]

    movz	fp,	#520
    add	w5,	w16,	#1
    movk	fp,	#2,	lsl #16
    mov	w7,	w5
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w27,	w26
    movz	fp,	#428
    mov	w1,	w21
    mov	w16,	w13
    mov	w9,	w14
    movz	w2,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w2
    str	w27,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    mov	w9,	w6
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w0,	#60289
    movz	w5,	#49414
    movz	w28,	#31129
    movz	w22,	#65535
    movz	fp,	#412
    movk	w2,	#36635,	lsl #16
    movk	w0,	#28377,	lsl #16
    movk	w5,	#51810,	lsl #16
    movk	w28,	#23170,	lsl #16
    movk	w22,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w2
    mov	w27,	w5
    mov	w12,	w28
    mov	w15,	w22
    ldr	w7,	[sp, fp]

    cmp	w7,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w3,	w15
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#424
    add	w17,	w16,	w17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#416
    sub	w3,	w3,	w7
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    add	w5,	w16,	w3
    add	w7,	w5,	w17
    sub	w28,	w17,	w7
    add	w16,	w28,	w5
    sub	w17,	w16,	w7
    sub	w3,	w17,	w16
    add	w5,	w3,	w7
    sub	w7,	w5,	w16
    mov	w5,	w12
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    cmp	w11,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    add	w5,	w17,	w22
    movk	fp,	#2,	lsl #16
    mov	w22,	w0
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w16,	w5
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#416
    add	w2,	w7,	w2
    movk	fp,	#2,	lsl #16
    sub	w7,	w2,	w5
    ldr	w3,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w28,	w3,	w7
    ldr	w25,	[sp, fp]

    sub	w3,	w7,	w28
    add	w3,	w3,	w25
    sub	w7,	w3,	w28
    mov	w16,	w7
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    cmp	w16,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    mov	w22,	w18
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    add	w5,	w8,	w3
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    add	w7,	w7,	w17
    movk	fp,	#2,	lsl #16
    add	w25,	w7,	w5
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w17,	w5,	w25
    ldr	w19,	[sp, fp]

    add	w2,	w17,	w7
    sub	w3,	w2,	w25
    sub	w5,	w3,	w2
    add	w16,	w5,	w25
    sub	w5,	w16,	w2
    add	w16,	w8,	w19
    add	w28,	w16,	w5
    sub	w5,	w5,	w28
    add	w2,	w5,	w16
    sub	w3,	w2,	w28
    sub	w3,	w3,	w2
    add	w7,	w3,	w28
    sub	w7,	w7,	w2
    mov	w16,	w7
    b	main_413

main_327:
    movz	fp,	#424
    mov	w22,	w27
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#424
    add	w28,	w17,	w5
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w16,	w7,	w28
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    add	w25,	w16,	w19
    movk	fp,	#2,	lsl #16
    sub	w17,	w25,	w28
    ldr	w11,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w3,	w11,	w17
    ldr	w7,	[sp, fp]

    sub	w17,	w17,	w3
    add	w2,	w17,	w7
    sub	w7,	w2,	w3
    mov	w16,	w7

main_413:
    mov	w7,	w16
    mov	w5,	w22

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    lsl	w16,	w2,	#5
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    asr	w22,	w17,	#31
    movk	fp,	#2,	lsl #16
    lsr	w25,	w22,	#27
    ldr	w24,	[sp, fp]

    movz	fp,	#428
    add	w17,	w24,	w25
    movk	fp,	#2,	lsl #16
    asr	w22,	w17,	#5
    ldr	w25,	[sp, fp]

    movz	fp,	#412
    lsl	w22,	w22,	#5
    movk	fp,	#2,	lsl #16
    sub	w17,	w25,	w22
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    lsl	w3,	w19,	#2
    movk	fp,	#2,	lsl #16
    mov	x28,	x3
    add	w25,	w16,	w17
    add	x28,	sp,	x28
    add	w16,	w25,	w9
    add	x28,	x28,	#16
    add	w2,	w16,	w7
    ldr	w17,	[x28]

    ldr	w11,	[sp, fp]

    movz	fp,	#424
    lsl	w28,	w11,	#30
    add	w5,	w2,	w5
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    add	w7,	w5,	w17
    movz	fp,	#424
    asr	w9,	w11,	#31
    movk	fp,	#2,	lsl #16
    lsr	w9,	w9,	#2
    ldr	w8,	[sp, fp]

    movz	fp,	#424
    add	w2,	w8,	w9
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    asr	w5,	w2,	#30
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    lsl	w9,	w5,	#30
    sub	w22,	w11,	w9
    ldr	w11,	[sp, fp]

    add	w11,	w11,	#1
    add	w28,	w28,	w22
    cmp	w11,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w2,	w12
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w3,	w28,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w15,	w1
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    add	w1,	w16,	w0
    add	w18,	w1,	w3
    sub	w17,	w3,	w18
    add	w17,	w17,	w1
    sub	w25,	w17,	w18
    sub	w27,	w25,	w17
    add	w1,	w27,	w18
    sub	w18,	w1,	w17
    mov	w25,	w18
    b	main_347

main_364:
    cmp	w11,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    add	w17,	w28,	w17
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    sub	w5,	w5,	w17
    movk	fp,	#2,	lsl #16
    add	w2,	w5,	w28
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w3,	w2,	w17
    ldr	w24,	[sp, fp]

    add	w2,	w16,	w3
    sub	w9,	w3,	w2
    add	w25,	w9,	w24
    sub	w16,	w25,	w2
    b	main_375

main_378:
    cmp	w11,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w1,	w28,	w22
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    add	w27,	w2,	w5
    movk	fp,	#2,	lsl #16
    add	w9,	w27,	w1
    ldr	w24,	[sp, fp]

    add	w5,	w24,	w28
    sub	w15,	w1,	w9
    add	w3,	w15,	w27
    sub	w22,	w3,	w9
    sub	w1,	w22,	w3
    add	w0,	w1,	w9
    sub	w2,	w0,	w3
    add	w0,	w5,	w2
    sub	w15,	w2,	w0
    add	w12,	w15,	w5
    sub	w25,	w12,	w0
    sub	w1,	w25,	w12
    add	w9,	w1,	w0
    sub	w15,	w9,	w12
    mov	w9,	w18
    mov	w16,	w15
    b	main_398

main_401:
    movz	fp,	#428
    mov	w9,	w27
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    add	w16,	w28,	w2
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w12,	w16
    movk	fp,	#2,	lsl #16
    add	w2,	w1,	w28
    ldr	w25,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w2,	w16
    ldr	w8,	[sp, fp]

    add	w18,	w25,	w0
    sub	w2,	w0,	w18
    add	w3,	w2,	w8
    sub	w15,	w3,	w18
    mov	w16,	w15

main_398:
    mov	w0,	w9

main_375:
    mov	w25,	w16
    mov	w2,	w0

main_347:
    lsl	w12,	w7,	#5
    asr	w0,	w7,	#31
    lsl	w18,	w11,	#2
    movz	fp,	#416
    lsr	w5,	w0,	#27
    movk	fp,	#2,	lsl #16
    add	w16,	w7,	w5
    mov	x5,	x18
    add	x5,	sp,	x5
    asr	w15,	w16,	#5
    add	x5,	x5,	#16
    lsl	w0,	w15,	#5
    sub	w9,	w7,	w0
    ldr	w0,	[x5]

    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w4,	w9,	w18
    movk	fp,	#2,	lsl #16
    add	w5,	w4,	w12
    add	w3,	w5,	w25
    ldr	w5,	[sp, fp]

    movz	fp,	#428
    add	w4,	w3,	w2
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    add	w18,	w4,	w0
    movz	fp,	#428
    asr	w16,	w25,	#31
    lsl	w4,	w5,	#30
    movk	fp,	#2,	lsl #16
    lsr	w27,	w16,	#2
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w1,	w0,	w27
    movk	fp,	#2,	lsl #16
    asr	w2,	w1,	#30
    ldr	w5,	[sp, fp]

    lsl	w3,	w2,	#30
    add	w2,	w11,	#1
    sub	w16,	w5,	w3
    add	w0,	w4,	w16
    cmp	w2,	#80
    blt	main_276

main_433:
    add	w11,	w18,	w26
    add	w4,	w7,	w21
    add	w16,	w0,	w13
    movz	fp,	#432
    add	w18,	w28,	w14
    add	w0,	w23,	#64
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    add	w8,	w8,	w6
    cmp	w0,	w20
    blt	main_62

main_441:
    movz	fp,	#476
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#444
    str	w11,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#468
    str	w4,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#460
    str	w16,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#524
    str	w18,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w8,	[x23]


main_442:
    cmp	w0,	#5
    bge	main_455

main_445:
    lsl	w17,	w0,	#2
    movz	fp,	#356
    lsl	w12,	w0,	#2
    mov	x25,	x17
    movk	fp,	#2,	lsl #16
    add	w0,	w0,	#1
    mov	x11,	x12
    add	x25,	sp,	x25
    add	x11,	sp,	x11
    add	x25,	x25,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x25]

    add	x11,	x11,	fp
    ldr	w16,	[x11]

    add	w6,	w16,	w17
    sub	w1,	w17,	w6
    add	w17,	w1,	w16
    sub	w22,	w17,	w6
    str	w22,	[x25]

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
    mov	w26,	w11
    mov	w21,	w4
    mov	w13,	w16
    mov	w14,	w18
    mov	w6,	w8
    mov	w23,	w0
    b	main_63

main_276:
    mov	w16,	w18
    movz	fp,	#428
    mov	w4,	w7
    mov	w12,	w28
    mov	w8,	w2
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    mov	w9,	w10
    movk	fp,	#2,	lsl #16
    mov	w10,	w0
    str	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

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


