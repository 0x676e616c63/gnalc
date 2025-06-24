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
    movz	w24,	#0
    movz	fp,	#336
    movz	w25,	#0
    movz	w23,	#0
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
    mov	w26,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w6,	#0
    movz	fp,	#356
    movz	w5,	#0
    movz	w2,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#452
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

    movz	fp,	#444
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#580
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w26
    movz	fp,	#572
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#484
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
    add	w24,	w1,	w23
    asr	w21,	w24,	#8
    lsl	w22,	w21,	#8
    sub	w24,	w1,	w22
    str	w24,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w21,	#128
    movz	fp,	#444
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


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
    add	w22,	w16,	#1
    movz	w25,	#0
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
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
    add	x22,	x0,	x2
    movz	w2,	#0
    str	w23,	[x22]

    add	w22,	w16,	#4
    ldr	x1,	[sp, fp]

    movz	fp,	#476
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w17,	#8961
    movz	w24,	#43913
    movz	w3,	#56574
    movz	w5,	#21622
    movz	w28,	#0
    movz	w20,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w24,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w5,	#4146,	lsl #16
    movk	w20,	#50130,	lsl #16
    mov	w26,	w17
    mov	w18,	w24
    mov	w13,	w3
    mov	w14,	w5
    mov	w6,	w20

main_63:
    movz	w17,	#0
    mov	w24,	w28
    mov	w10,	w17

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w15,	w10,	#2
    lsl	w3,	w24,	#2
    movz	fp,	#436
    add	w11,	w24,	#2
    mov	x15,	x15
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    lsl	w5,	w11,	#2
    ldr	x0,	[sp, fp]

    add	w11,	w24,	#4
    movz	fp,	#436
    add	x15,	x15,	#16
    add	x2,	x0,	x3
    movk	fp,	#2,	lsl #16
    add	w0,	w24,	#1
    add	w21,	w11,	#2
    ldr	w4,	[x2]

    lsl	w16,	w0,	#2
    ldr	x9,	[sp, fp]

    lsl	w20,	w4,	#24
    movz	fp,	#436
    add	x1,	x9,	x16
    movk	fp,	#2,	lsl #16
    add	w9,	w10,	#1
    ldr	w3,	[x1]

    lsl	w10,	w9,	#2
    ldr	x23,	[sp, fp]

    lsl	w4,	w3,	#16
    movz	fp,	#436
    add	x17,	x23,	x5
    movk	fp,	#2,	lsl #16
    add	w7,	w4,	w20
    mov	x4,	x10
    ldr	w1,	[x17]

    add	x4,	sp,	x4
    ldr	x0,	[sp, fp]

    lsl	w2,	w1,	#8
    movz	fp,	#436
    add	x4,	x4,	#16
    add	w2,	w7,	w2
    movk	fp,	#2,	lsl #16
    add	w7,	w24,	#3
    lsl	w16,	w7,	#2
    add	x8,	x0,	x16
    lsl	w0,	w11,	#2
    ldr	w20,	[x8]

    add	w5,	w2,	w20
    str	w5,	[x15]

    ldr	x10,	[sp, fp]

    movz	fp,	#436
    add	x25,	x10,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w11,	#1
    ldr	w1,	[x25]

    lsl	w17,	w0,	#2
    lsl	w20,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x1,	x1,	x17
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x1]

    ldr	x3,	[sp, fp]

    lsl	w7,	w5,	#16
    movz	fp,	#436
    add	w5,	w9,	#1
    add	w17,	w7,	w20
    movk	fp,	#2,	lsl #16
    lsl	w7,	w21,	#2
    add	x0,	x3,	x7
    add	w7,	w11,	#3
    ldr	w2,	[x0]

    lsl	w15,	w7,	#2
    ldr	x10,	[sp, fp]

    lsl	w3,	w2,	#8
    lsl	w7,	w5,	#2
    movz	fp,	#436
    add	x12,	x10,	x15
    add	w21,	w17,	w3
    movk	fp,	#2,	lsl #16
    add	w15,	w11,	#4
    ldr	w17,	[x12]

    add	w3,	w21,	w17
    add	w16,	w15,	#4
    lsl	w2,	w15,	#2
    add	w17,	w15,	#2
    str	w3,	[x4]

    add	w24,	w16,	#3
    ldr	x0,	[sp, fp]

    mov	x3,	x7
    movz	fp,	#436
    add	x1,	x0,	x2
    add	w7,	w15,	#1
    add	x3,	sp,	x3
    movk	fp,	#2,	lsl #16
    lsl	w0,	w17,	#2
    ldr	w4,	[x1]

    lsl	w11,	w7,	#2
    add	x3,	x3,	#16
    ldr	x19,	[sp, fp]

    lsl	w1,	w4,	#24
    movz	fp,	#436
    add	x8,	x19,	x11
    add	w4,	w15,	#3
    movk	fp,	#2,	lsl #16
    ldr	w11,	[x8]

    ldr	x20,	[sp, fp]

    lsl	w12,	w11,	#16
    movz	fp,	#436
    add	x20,	x20,	x0
    add	w11,	w5,	#1
    add	w12,	w12,	w1
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x20]

    lsl	w1,	w0,	#8
    lsl	w0,	w4,	#2
    add	w2,	w12,	w1
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x21,	x4,	x0
    movk	fp,	#2,	lsl #16
    lsl	w0,	w11,	#2
    mov	x5,	x0
    ldr	w1,	[x21]

    lsl	w0,	w16,	#2
    add	x5,	sp,	x5
    add	w7,	w2,	w1
    add	x5,	x5,	#16
    str	w7,	[x3]

    add	w7,	w16,	#1
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x25,	x8,	x0
    movk	fp,	#2,	lsl #16
    lsl	w12,	w7,	#2
    ldr	w1,	[x25]

    ldr	x3,	[sp, fp]

    lsl	w1,	w1,	#24
    movz	fp,	#436
    add	x8,	x3,	x12
    movk	fp,	#2,	lsl #16
    add	w3,	w16,	#2
    ldr	w17,	[x8]

    lsl	w7,	w3,	#2
    ldr	x12,	[sp, fp]

    lsl	w21,	w17,	#16
    movz	fp,	#436
    add	x4,	x12,	x7
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	w1
    add	w21,	w11,	#1
    lsl	w1,	w24,	#2
    ldr	w10,	[x4]

    ldr	x12,	[sp, fp]

    lsl	w15,	w10,	#8
    movz	fp,	#436
    add	w2,	w0,	w15
    movk	fp,	#2,	lsl #16
    add	x0,	x12,	x1
    lsl	w1,	w21,	#2
    add	w12,	w16,	#4
    ldr	w3,	[x0]

    add	w10,	w12,	#1
    mov	x0,	x1
    add	w3,	w2,	w3
    add	w1,	w12,	#4
    add	x0,	sp,	x0
    lsl	w16,	w10,	#2
    str	w3,	[x5]

    add	x0,	x0,	#16
    ldr	x23,	[sp, fp]

    lsl	w3,	w12,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	x2,	x23,	x3
    ldr	w4,	[x2]

    add	w2,	w12,	#2
    ldr	x15,	[sp, fp]

    lsl	w5,	w4,	#24
    movz	fp,	#436
    add	x11,	x15,	x16
    movk	fp,	#2,	lsl #16
    lsl	w4,	w2,	#2
    add	w2,	w12,	#3
    ldr	w17,	[x11]

    ldr	x15,	[sp, fp]

    lsl	w24,	w17,	#16
    movz	fp,	#436
    add	x3,	x15,	x4
    lsl	w17,	w1,	#2
    add	w24,	w24,	w5
    movk	fp,	#2,	lsl #16
    lsl	w4,	w2,	#2
    ldr	w7,	[x3]

    ldr	x27,	[sp, fp]

    lsl	w8,	w7,	#8
    movz	fp,	#436
    add	x3,	x27,	x4
    add	w9,	w24,	w8
    movk	fp,	#2,	lsl #16
    add	w8,	w1,	#2
    ldr	w5,	[x3]

    add	w5,	w9,	w5
    add	w9,	w1,	#1
    str	w5,	[x0]

    lsl	w5,	w9,	#2
    ldr	x2,	[sp, fp]

    add	w0,	w21,	#1
    movz	fp,	#436
    add	x16,	x2,	x17
    movk	fp,	#2,	lsl #16
    lsl	w12,	w0,	#2
    ldr	w23,	[x16]

    add	w0,	w0,	#1
    mov	x10,	x12
    ldr	x24,	[sp, fp]

    lsl	w3,	w23,	#24
    add	x10,	sp,	x10
    movz	fp,	#436
    add	x11,	x24,	x5
    movk	fp,	#2,	lsl #16
    add	x10,	x10,	#16
    ldr	w2,	[x11]

    lsl	w4,	w2,	#16
    add	w5,	w4,	w3
    ldr	x3,	[sp, fp]

    lsl	w4,	w8,	#2
    movz	fp,	#436
    add	x9,	x3,	x4
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x9]

    add	w9,	w1,	#4
    ldr	x8,	[sp, fp]

    lsl	w17,	w16,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w7,	w9,	#3
    add	w21,	w5,	w17
    lsl	w5,	w0,	#2
    add	w17,	w1,	#3
    lsl	w1,	w9,	#2
    lsl	w3,	w17,	#2
    add	x24,	x8,	x3
    mov	x3,	x5
    add	x3,	sp,	x3
    ldr	w4,	[x24]

    add	w25,	w21,	w4
    add	x3,	x3,	#16
    str	w25,	[x10]

    add	w10,	w9,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#436
    add	x17,	x16,	x1
    movk	fp,	#2,	lsl #16
    add	w16,	w9,	#1
    lsl	w25,	w10,	#2
    ldr	w2,	[x17]

    lsl	w10,	w7,	#2
    lsl	w11,	w16,	#2
    ldr	x17,	[sp, fp]

    lsl	w15,	w2,	#24
    movz	fp,	#436
    add	x17,	x17,	x11
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x17]

    ldr	x17,	[sp, fp]

    lsl	w1,	w24,	#16
    movz	fp,	#436
    add	x11,	x17,	x25
    add	w24,	w9,	#4
    add	w4,	w1,	w15
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x11]

    ldr	x20,	[sp, fp]

    lsl	w1,	w21,	#8
    add	x8,	x20,	x10
    add	w2,	w4,	w1
    add	w1,	w0,	#1
    ldr	w12,	[x8]

    mov	w10,	w1
    add	w5,	w2,	w12
    str	w5,	[x3]

    b	main_70

main_215:
    mov	w21,	w24
    mov	w2,	w10

main_217:
    lsl	w5,	w2,	#2
    lsl	w11,	w21,	#2
    movz	fp,	#436
    add	w25,	w2,	#1
    mov	x4,	x5
    movk	fp,	#2,	lsl #16
    add	x4,	sp,	x4
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x12,	x3,	x11
    add	x4,	x4,	#16
    movk	fp,	#2,	lsl #16
    add	w3,	w21,	#1
    ldr	w16,	[x12]

    lsl	w24,	w16,	#24
    lsl	w0,	w3,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#436
    add	x7,	x3,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	#2
    ldr	w9,	[x7]

    lsl	w16,	w0,	#2
    ldr	x3,	[sp, fp]

    lsl	w15,	w9,	#16
    movz	fp,	#436
    add	x1,	x3,	x16
    movk	fp,	#2,	lsl #16
    add	w15,	w15,	w24
    add	w3,	w21,	#3
    ldr	w7,	[x1]

    lsl	w17,	w3,	#2
    lsl	w8,	w7,	#8
    ldr	x7,	[sp, fp]

    add	w9,	w15,	w8
    add	x7,	x7,	x17
    ldr	w16,	[x7]

    add	w23,	w9,	w16
    str	w23,	[x4]

    add	w23,	w21,	#4
    cmp	w25,	#16
    bge	main_241

main_216:
    mov	w21,	w23
    mov	w2,	w25
    b	main_217

main_241:
    mov	w12,	w25
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]


main_242:
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#620
    lsl	w23,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x23
    add	x17,	sp,	x17
    ldr	w24,	[sp, fp]

    movz	fp,	#620
    sub	w25,	w24,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    ldr	w2,	[sp, fp]

    movz	fp,	#620
    sub	w4,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w7,	w4,	#2
    mov	x5,	x7
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w9,	[x5]

    add	w5,	w9,	w3
    sub	w11,	w3,	w5
    ldr	w3,	[sp, fp]

    movz	fp,	#620
    sub	w24,	w3,	#14
    add	w15,	w11,	w9
    movk	fp,	#2,	lsl #16
    lsl	w0,	w24,	#2
    sub	w5,	w15,	w5
    mov	x25,	x0
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w2,	[x25]

    ldr	w4,	[sp, fp]

    add	w0,	w2,	w5
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    sub	w3,	w5,	w0
    add	w10,	w3,	w2
    sub	w24,	w10,	w0
    sub	w0,	w4,	#16
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w24
    sub	w8,	w24,	w2
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

    movz	fp,	#620
    add	w5,	w16,	#1
    movk	fp,	#2,	lsl #16
    mov	w7,	w5
    str	w7,	[sp, fp]

    b	main_242

main_275:
    movz	fp,	#428
    mov	w1,	w18
    mov	w16,	w13
    mov	w9,	w14
    mov	w10,	w6
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]

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
    movz	w9,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w9
    str	w0,	[sp, fp]


main_277:
    movz	w7,	#48348
    movz	w16,	#60289
    movz	w25,	#31129
    movz	w24,	#65535
    movz	fp,	#412
    movk	w7,	#36635,	lsl #16
    movk	w16,	#28377,	lsl #16
    movk	w25,	#23170,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w21,	w7
    mov	w11,	w16
    mov	w15,	w25
    mov	w17,	w24
    movz	w7,	#49414
    movk	w7,	#51810,	lsl #16
    mov	w2,	w7
    ldr	w7,	[sp, fp]

    cmp	w7,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w16,	w17
    mov	w24,	w15
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    add	w20,	w20,	w19
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    sub	w7,	w16,	w5
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    add	w23,	w16,	w7
    add	w7,	w23,	w20
    sub	w25,	w20,	w7
    add	w16,	w25,	w23
    sub	w20,	w16,	w7
    sub	w9,	w20,	w16
    add	w20,	w9,	w7
    sub	w9,	w20,	w16
    mov	w12,	w9
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    cmp	w16,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    add	w20,	w20,	w23
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    sub	w12,	w16,	w20
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#416
    add	w9,	w12,	w4
    movk	fp,	#2,	lsl #16
    sub	w24,	w9,	w20
    ldr	w1,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w9,	w1,	w24
    ldr	w27,	[sp, fp]

    sub	w7,	w24,	w9
    add	w7,	w7,	w27
    sub	w9,	w7,	w9
    mov	w20,	w9
    mov	w9,	w11
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
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    add	w9,	w8,	w1
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#416
    add	w24,	w5,	w20
    movk	fp,	#2,	lsl #16
    add	w20,	w24,	w9
    sub	w16,	w9,	w20
    add	w3,	w16,	w24
    sub	w7,	w3,	w20
    sub	w16,	w7,	w3
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    add	w9,	w16,	w20
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    sub	w20,	w9,	w3
    add	w16,	w7,	w16
    add	w23,	w16,	w20
    sub	w9,	w20,	w23
    add	w16,	w9,	w16
    sub	w7,	w16,	w23
    sub	w7,	w7,	w16
    add	w20,	w7,	w23
    sub	w9,	w20,	w16
    mov	w20,	w9
    mov	w9,	w21
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w9,	w19,	w5
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    sub	w25,	w7,	w9
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#416
    add	w24,	w25,	w23
    movk	fp,	#2,	lsl #16
    sub	w25,	w24,	w9
    ldr	w16,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w7,	w16,	w25
    ldr	w5,	[sp, fp]

    sub	w20,	w25,	w7
    add	w16,	w20,	w5
    sub	w9,	w16,	w7
    mov	w20,	w9
    mov	w9,	w2

main_413:
    mov	w12,	w20
    mov	w24,	w9

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w3,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#428
    asr	w23,	w8,	#31
    movk	fp,	#2,	lsl #16
    lsr	w23,	w23,	#27
    ldr	w16,	[sp, fp]

    movz	fp,	#428
    add	w7,	w16,	w23
    movk	fp,	#2,	lsl #16
    asr	w23,	w7,	#5
    ldr	w25,	[sp, fp]

    movz	fp,	#412
    lsl	w9,	w23,	#5
    movk	fp,	#2,	lsl #16
    sub	w7,	w25,	w9
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w23,	w3,	w7
    lsl	w7,	w20,	#2
    mov	x9,	x7
    add	w10,	w23,	w10
    add	x9,	sp,	x9
    add	w23,	w10,	w12
    add	x9,	x9,	#16
    add	w3,	w23,	w24
    ldr	w20,	[x9]

    ldr	w16,	[sp, fp]

    movz	fp,	#424
    add	w9,	w3,	w20
    movk	fp,	#2,	lsl #16
    lsl	w3,	w16,	#30
    ldr	w12,	[sp, fp]

    movz	fp,	#424
    asr	w16,	w12,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w16,	#2
    ldr	w8,	[sp, fp]

    movz	fp,	#424
    add	w10,	w8,	w24
    movk	fp,	#2,	lsl #16
    asr	w20,	w10,	#30
    ldr	w12,	[sp, fp]

    movz	fp,	#412
    lsl	w23,	w20,	#30
    movk	fp,	#2,	lsl #16
    sub	w20,	w12,	w23
    ldr	w12,	[sp, fp]

    add	w7,	w12,	#1
    add	w10,	w3,	w20
    cmp	w7,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w23,	w17
    mov	w3,	w15
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w0,	w10,	w0
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w23,	w2
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    add	w2,	w16,	w1
    add	w17,	w2,	w0
    sub	w21,	w0,	w17
    add	w20,	w21,	w2
    sub	w21,	w20,	w17
    sub	w23,	w21,	w20
    add	w23,	w23,	w17
    sub	w21,	w23,	w20
    mov	w24,	w21
    b	main_347

main_364:
    cmp	w7,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    add	w17,	w10,	w17
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w24,	w3,	w17
    movk	fp,	#2,	lsl #16
    add	w0,	w24,	w10
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w17
    ldr	w27,	[sp, fp]

    add	w21,	w16,	w0
    sub	w2,	w0,	w21
    add	w20,	w2,	w27
    mov	w2,	w11
    sub	w17,	w20,	w21
    b	main_375

main_378:
    cmp	w7,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#428
    add	w24,	w10,	w27
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    add	w23,	w2,	w5
    movk	fp,	#2,	lsl #16
    add	w3,	w23,	w24
    sub	w12,	w24,	w3
    add	w2,	w12,	w23
    sub	w17,	w2,	w3
    sub	w20,	w17,	w2
    add	w0,	w20,	w3
    sub	w2,	w0,	w2
    ldr	w0,	[sp, fp]

    add	w12,	w0,	w10
    add	w1,	w12,	w2
    sub	w16,	w2,	w1
    add	w0,	w16,	w12
    sub	w20,	w0,	w1
    sub	w23,	w20,	w0
    add	w15,	w23,	w1
    sub	w16,	w15,	w0
    mov	w15,	w21
    mov	w20,	w16
    b	main_398

main_401:
    movz	fp,	#428
    mov	w15,	w2
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w17,	w10,	w3
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w16,	w17
    movk	fp,	#2,	lsl #16
    add	w12,	w1,	w10
    ldr	w0,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w1,	w12,	w17
    ldr	w8,	[sp, fp]

    add	w21,	w0,	w1
    sub	w12,	w1,	w21
    add	w12,	w12,	w8
    sub	w17,	w12,	w21
    mov	w20,	w17

main_398:
    mov	w17,	w20
    mov	w2,	w15

main_375:
    mov	w24,	w17
    mov	w3,	w2

main_347:
    lsl	w21,	w9,	#5
    asr	w1,	w9,	#31
    movz	fp,	#416
    add	w25,	w7,	#1
    lsr	w2,	w1,	#27
    movk	fp,	#2,	lsl #16
    add	w12,	w9,	w2
    lsl	w2,	w7,	#2
    mov	x23,	x2
    asr	w16,	w12,	#5
    add	x23,	sp,	x23
    lsl	w17,	w16,	#5
    add	x23,	x23,	#16
    sub	w17,	w9,	w17
    ldr	w0,	[x23]

    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w5,	w17,	w19
    movk	fp,	#2,	lsl #16
    add	w12,	w5,	w21
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w21,	w12,	w24
    add	w11,	w21,	w3
    add	w20,	w11,	w0
    ldr	w0,	[sp, fp]

    lsl	w11,	w4,	#30
    movz	fp,	#428
    asr	w16,	w0,	#31
    movk	fp,	#2,	lsl #16
    lsr	w23,	w16,	#2
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    add	w21,	w1,	w23
    movk	fp,	#2,	lsl #16
    asr	w2,	w21,	#30
    ldr	w4,	[sp, fp]

    lsl	w5,	w2,	#30
    sub	w16,	w4,	w5
    add	w17,	w11,	w16
    cmp	w25,	#80
    blt	main_276

main_433:
    add	w15,	w20,	w26
    add	w24,	w9,	w18
    add	w25,	w17,	w13
    movz	fp,	#432
    add	w2,	w28,	#64
    add	w20,	w10,	w14
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w7,	w7,	w6
    cmp	w2,	w22
    blt	main_62

main_441:
    movz	fp,	#460
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#468
    str	w15,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#580
    str	w24,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#572
    str	w25,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#484
    str	w20,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w7,	[x23]


main_442:
    cmp	w28,	#5
    bge	main_455

main_445:
    lsl	w16,	w28,	#2
    movz	fp,	#356
    lsl	w11,	w28,	#2
    mov	x23,	x16
    movk	fp,	#2,	lsl #16
    add	w28,	w28,	#1
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

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w1,	w6
    b	main_28

main_62:
    mov	w26,	w15
    mov	w18,	w24
    mov	w13,	w25
    mov	w14,	w20
    mov	w6,	w7
    mov	w28,	w2
    b	main_63

main_276:
    mov	w16,	w20
    movz	fp,	#428
    mov	w7,	w25
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    mov	w9,	w17
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#412
    mov	w10,	w8
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#452
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


