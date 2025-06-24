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
    movz	w26,	#0
    movz	fp,	#336
    movz	w24,	#0
    movz	w25,	#0
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
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#548
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

    movz	fp,	#460
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#376
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
    str	w25,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w20,	#128
    movz	fp,	#460
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w8,	w1
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


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
    add	w21,	w8,	#1
    movz	w23,	#125
    add	w20,	w8,	#4
    movk	fp,	#2,	lsl #16
    lsl	w2,	w21,	#2
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
    add	x21,	x0,	x2
    movz	w2,	#0
    str	w23,	[x21]

    ldr	x1,	[sp, fp]

    movz	fp,	#452
    add	x25,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x25]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w28,	#0
    movz	w17,	#8961
    movz	w6,	#21622
    movz	w27,	#43913
    movz	w3,	#56574
    movz	w21,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w21,	#50130,	lsl #16
    mov	w11,	w17
    mov	w16,	w6
    mov	w18,	w27
    mov	w0,	w3
    mov	w6,	w21

main_63:
    movz	w19,	#0
    mov	w26,	w28
    mov	w12,	w19

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w17,	w12,	#2
    lsl	w4,	w26,	#2
    movz	fp,	#436
    add	w13,	w26,	#2
    add	w12,	w12,	#1
    mov	x15,	x17
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    lsl	w7,	w13,	#2
    ldr	x1,	[sp, fp]

    add	w13,	w26,	#4
    add	x15,	x15,	#16
    movz	fp,	#436
    add	x3,	x1,	x4
    movk	fp,	#2,	lsl #16
    add	w1,	w26,	#1
    ldr	w5,	[x3]

    lsl	w19,	w1,	#2
    ldr	x10,	[sp, fp]

    lsl	w21,	w5,	#24
    movz	fp,	#436
    add	x2,	x10,	x19
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x2]

    ldr	x24,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#436
    add	w8,	w5,	w21
    movk	fp,	#2,	lsl #16
    add	x21,	x24,	x7
    ldr	w2,	[x21]

    ldr	x1,	[sp, fp]

    lsl	w3,	w2,	#8
    movz	fp,	#436
    add	w3,	w8,	w3
    movk	fp,	#2,	lsl #16
    add	w8,	w26,	#3
    lsl	w14,	w8,	#2
    add	x9,	x1,	x14
    lsl	w1,	w13,	#2
    ldr	w21,	[x9]

    lsl	w9,	w12,	#2
    add	w7,	w3,	w21
    mov	x5,	x9
    add	x5,	sp,	x5
    str	w7,	[x15]

    ldr	x10,	[sp, fp]

    add	x5,	x5,	#16
    movz	fp,	#436
    add	x27,	x10,	x1
    movk	fp,	#2,	lsl #16
    add	w1,	w13,	#1
    ldr	w2,	[x27]

    lsl	w19,	w1,	#2
    lsl	w23,	w2,	#24
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x2,	x2,	x19
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x2]

    add	w2,	w13,	#4
    ldr	x4,	[sp, fp]

    lsl	w8,	w7,	#16
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w17,	w8,	w23
    add	w23,	w13,	#2
    lsl	w8,	w23,	#2
    add	x1,	x4,	x8
    add	w8,	w13,	#3
    ldr	w3,	[x1]

    ldr	x10,	[sp, fp]

    lsl	w4,	w3,	#8
    movz	fp,	#436
    add	w23,	w17,	w4
    movk	fp,	#2,	lsl #16
    lsl	w17,	w8,	#2
    add	x10,	x10,	x17
    ldr	w21,	[x10]

    add	w4,	w23,	w21
    add	w23,	w2,	#2
    str	w4,	[x5]

    ldr	x1,	[sp, fp]

    lsl	w5,	w2,	#2
    add	w4,	w12,	#1
    movz	fp,	#436
    add	x3,	x1,	x5
    movk	fp,	#2,	lsl #16
    lsl	w1,	w23,	#2
    add	w14,	w4,	#1
    lsl	w9,	w4,	#2
    ldr	w7,	[x3]

    mov	x8,	x9
    ldr	x17,	[sp, fp]

    lsl	w3,	w7,	#24
    add	w9,	w2,	#1
    add	x8,	sp,	x8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w27,	w9,	#2
    add	x8,	x8,	#16
    add	x12,	x17,	x27
    ldr	w15,	[x12]

    ldr	x22,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#436
    add	x1,	x22,	x1
    add	w19,	w17,	w3
    movk	fp,	#2,	lsl #16
    add	w17,	w2,	#3
    ldr	w5,	[x1]

    ldr	x7,	[sp, fp]

    lsl	w10,	w5,	#8
    lsl	w1,	w17,	#2
    movz	fp,	#436
    add	w3,	w19,	w10
    add	w17,	w2,	#4
    add	x23,	x7,	x1
    movk	fp,	#2,	lsl #16
    lsl	w1,	w14,	#2
    add	w26,	w17,	#3
    mov	x7,	x1
    ldr	w5,	[x23]

    lsl	w1,	w17,	#2
    add	x7,	sp,	x7
    add	w10,	w3,	w5
    add	x7,	x7,	#16
    str	w10,	[x8]

    add	w8,	w17,	#1
    ldr	x9,	[sp, fp]

    movz	fp,	#436
    add	x27,	x9,	x1
    movk	fp,	#2,	lsl #16
    lsl	w12,	w8,	#2
    ldr	w2,	[x27]

    ldr	x4,	[sp, fp]

    lsl	w2,	w2,	#24
    movz	fp,	#436
    add	x9,	x4,	x12
    movk	fp,	#2,	lsl #16
    add	w4,	w17,	#2
    ldr	w15,	[x9]

    lsl	w8,	w4,	#2
    ldr	x13,	[sp, fp]

    lsl	w23,	w15,	#16
    movz	fp,	#436
    add	x5,	x13,	x8
    movk	fp,	#2,	lsl #16
    add	w1,	w23,	w2
    add	w8,	w17,	#4
    lsl	w2,	w26,	#2
    ldr	w12,	[x5]

    add	w10,	w8,	#1
    ldr	x13,	[sp, fp]

    lsl	w15,	w12,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w12,	w10,	#2
    add	w3,	w1,	w15
    add	x1,	x13,	x2
    ldr	w4,	[x1]

    add	w4,	w3,	w4
    str	w4,	[x7]

    ldr	x19,	[sp, fp]

    add	w4,	w14,	#1
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w26,	w4,	#1
    lsl	w2,	w4,	#2
    mov	x17,	x2
    lsl	w2,	w8,	#2
    add	x17,	sp,	x17
    add	x1,	x19,	x2
    add	x17,	x17,	#16
    ldr	w3,	[x1]

    add	w1,	w8,	#2
    ldr	x19,	[sp, fp]

    lsl	w5,	w3,	#24
    movz	fp,	#436
    add	x13,	x19,	x12
    movk	fp,	#2,	lsl #16
    lsl	w1,	w1,	#2
    ldr	w15,	[x13]

    lsl	w13,	w26,	#2
    ldr	x14,	[sp, fp]

    lsl	w19,	w15,	#16
    mov	x12,	x13
    movz	fp,	#436
    add	x2,	x14,	x1
    add	w19,	w19,	w5
    add	x12,	sp,	x12
    movk	fp,	#2,	lsl #16
    add	w1,	w8,	#3
    ldr	w7,	[x2]

    add	x12,	x12,	#16
    ldr	x25,	[sp, fp]

    lsl	w3,	w1,	#2
    lsl	w14,	w7,	#8
    movz	fp,	#436
    add	x2,	x25,	x3
    add	w10,	w19,	w14
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x2]

    add	w2,	w8,	#4
    add	w5,	w10,	w5
    add	w25,	w2,	#3
    add	w8,	w2,	#2
    lsl	w23,	w2,	#2
    add	w10,	w2,	#1
    str	w5,	[x17]

    add	w2,	w2,	#4
    ldr	x5,	[sp, fp]

    lsl	w7,	w10,	#2
    movz	fp,	#436
    add	x15,	x5,	x23
    add	w10,	w26,	#1
    movk	fp,	#2,	lsl #16
    lsl	w5,	w8,	#2
    add	w26,	w2,	#4
    ldr	w27,	[x15]

    lsl	w4,	w27,	#24
    ldr	x27,	[sp, fp]

    movz	fp,	#436
    add	x15,	x27,	x7
    movk	fp,	#2,	lsl #16
    lsl	w7,	w10,	#2
    ldr	w1,	[x15]

    ldr	x9,	[sp, fp]

    lsl	w3,	w1,	#16
    movz	fp,	#436
    add	x9,	x9,	x5
    add	w4,	w3,	w4
    movk	fp,	#2,	lsl #16
    mov	x5,	x7
    ldr	w15,	[x9]

    add	x5,	sp,	x5
    ldr	x9,	[sp, fp]

    lsl	w17,	w15,	#8
    movz	fp,	#436
    add	x5,	x5,	#16
    add	w23,	w4,	w17
    movk	fp,	#2,	lsl #16
    lsl	w4,	w25,	#2
    add	x3,	x9,	x4
    ldr	w8,	[x3]

    add	w1,	w23,	w8
    add	w8,	w2,	#3
    str	w1,	[x12]

    lsl	w14,	w8,	#2
    add	w12,	w2,	#2
    ldr	x15,	[sp, fp]

    lsl	w1,	w2,	#2
    movz	fp,	#436
    add	x19,	x15,	x1
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x19]

    ldr	x15,	[sp, fp]

    add	w19,	w2,	#1
    lsl	w17,	w4,	#24
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w9,	w19,	#2
    add	x23,	x15,	x9
    ldr	w1,	[x23]

    lsl	w23,	w12,	#2
    lsl	w3,	w1,	#16
    add	w4,	w3,	w17
    ldr	x17,	[sp, fp]

    movz	fp,	#436
    add	x13,	x17,	x23
    movk	fp,	#2,	lsl #16
    ldr	w23,	[x13]

    ldr	x22,	[sp, fp]

    lsl	w1,	w23,	#8
    add	x12,	x22,	x14
    add	w3,	w4,	w1
    ldr	w15,	[x12]

    add	w7,	w3,	w15
    add	w3,	w10,	#1
    mov	w12,	w3
    str	w7,	[x5]

    b	main_70

main_215:
    mov	w23,	w26
    mov	w3,	w12

main_217:
    lsl	w7,	w3,	#2
    lsl	w13,	w23,	#2
    movz	fp,	#436
    add	w27,	w3,	#1
    mov	x5,	x7
    movk	fp,	#2,	lsl #16
    add	x5,	sp,	x5
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x14,	x4,	x13
    add	x5,	x5,	#16
    movk	fp,	#2,	lsl #16
    add	w4,	w23,	#1
    ldr	w19,	[x14]

    lsl	w26,	w19,	#24
    lsl	w1,	w4,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x8,	x4,	x1
    movk	fp,	#2,	lsl #16
    add	w1,	w23,	#2
    ldr	w10,	[x8]

    lsl	w17,	w1,	#2
    ldr	x4,	[sp, fp]

    lsl	w14,	w10,	#16
    movz	fp,	#436
    add	x2,	x4,	x17
    movk	fp,	#2,	lsl #16
    add	w14,	w14,	w26
    add	w4,	w23,	#3
    ldr	w8,	[x2]

    lsl	w21,	w4,	#2
    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w10,	w14,	w9
    add	x8,	x8,	x21
    ldr	w15,	[x8]

    add	w25,	w10,	w15
    str	w25,	[x5]

    add	w25,	w23,	#4
    cmp	w27,	#16
    bge	main_241

main_216:
    mov	w23,	w25
    mov	w3,	w27
    b	main_217

main_241:
    mov	w14,	w27
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#444
    lsl	w25,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x19,	x25
    add	x19,	sp,	x19
    ldr	w25,	[sp, fp]

    movz	fp,	#444
    sub	w27,	w25,	#3
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w27,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w4,	[x2]

    ldr	w3,	[sp, fp]

    movz	fp,	#444
    sub	w5,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w5,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w10,	[x7]

    add	w7,	w10,	w4
    sub	w13,	w4,	w7
    ldr	w4,	[sp, fp]

    movz	fp,	#444
    sub	w26,	w4,	#14
    add	w17,	w13,	w10
    movk	fp,	#2,	lsl #16
    lsl	w1,	w26,	#2
    sub	w7,	w17,	w7
    mov	x27,	x1
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    ldr	w3,	[x27]

    ldr	w5,	[sp, fp]

    add	w1,	w3,	w7
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    sub	w4,	w7,	w1
    add	w10,	w4,	w3
    sub	w26,	w10,	w1
    sub	w1,	w5,	#16
    lsl	w3,	w1,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w4,	[x2]

    add	w3,	w4,	w26
    sub	w9,	w26,	w3
    add	w12,	w9,	w4
    sub	w15,	w12,	w3
    asr	w1,	w15,	#31
    lsl	w10,	w15,	#1
    lsr	w2,	w1,	#31
    add	w3,	w15,	w2
    asr	w12,	w3,	#1
    lsl	w13,	w12,	#1
    sub	w4,	w15,	w13
    add	w5,	w10,	w4
    str	w5,	[x19]

    ldr	w17,	[sp, fp]

    movz	fp,	#444
    add	w7,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w7
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w11
    movz	fp,	#428
    mov	w2,	w18
    mov	w21,	w0
    mov	w10,	w16
    mov	w1,	w6
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]

    mov	w2,	w5
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w21,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]


main_277:
    movz	w5,	#48348
    movz	w10,	#60289
    movz	w4,	#49414
    movz	w27,	#31129
    movz	w25,	#65535
    movz	fp,	#412
    movk	w5,	#36635,	lsl #16
    movk	w10,	#28377,	lsl #16
    movk	w4,	#51810,	lsl #16
    movk	w27,	#23170,	lsl #16
    movk	w25,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w23,	w5
    mov	w7,	w10
    mov	w2,	w4
    mov	w13,	w27
    mov	w17,	w25
    ldr	w15,	[sp, fp]

    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w4,	w17
    mov	w26,	w13
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#424
    add	w9,	w22,	w19
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    sub	w4,	w4,	w12
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w10,	w21,	w4
    add	w14,	w10,	w9
    sub	w19,	w9,	w14
    add	w27,	w19,	w10
    sub	w19,	w27,	w14
    sub	w4,	w19,	w27
    add	w9,	w4,	w14
    sub	w5,	w9,	w27
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
    ldr	w24,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#424
    add	w5,	w27,	w24
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    sub	w14,	w21,	w5
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    add	w26,	w14,	w9
    movk	fp,	#2,	lsl #16
    sub	w10,	w26,	w5
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    add	w4,	w5,	w10
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w5,	w10,	w4
    add	w5,	w5,	w26
    mov	w26,	w7
    sub	w5,	w5,	w4
    mov	w9,	w5
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    cmp	w21,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    mov	w26,	w23
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    add	w27,	w12,	w5
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    add	w9,	w9,	w21
    movk	fp,	#2,	lsl #16
    add	w19,	w9,	w27
    sub	w14,	w27,	w19
    add	w5,	w14,	w9
    sub	w4,	w5,	w19
    sub	w9,	w4,	w5
    add	w14,	w9,	w19
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w5,	w14,	w5
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w14,	w19,	w21
    add	w19,	w14,	w5
    sub	w27,	w5,	w19
    add	w14,	w27,	w14
    sub	w5,	w14,	w19
    sub	w4,	w5,	w14
    add	w9,	w4,	w19
    sub	w5,	w9,	w14
    mov	w9,	w5
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#424
    add	w4,	w21,	w9
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w12,	w4
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    add	w26,	w9,	w22
    movk	fp,	#2,	lsl #16
    sub	w14,	w26,	w4
    ldr	w19,	[sp, fp]

    mov	w26,	w2
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w4,	w19,	w14
    ldr	w10,	[sp, fp]

    sub	w19,	w14,	w4
    add	w9,	w19,	w10
    sub	w5,	w9,	w4
    mov	w9,	w5

main_413:
    mov	w5,	w9

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    lsl	w10,	w3,	#5
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#428
    asr	w14,	w14,	#31
    movk	fp,	#2,	lsl #16
    lsr	w25,	w14,	#27
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    add	w14,	w19,	w25
    movk	fp,	#2,	lsl #16
    asr	w14,	w14,	#5
    ldr	w25,	[sp, fp]

    movz	fp,	#412
    lsl	w19,	w14,	#5
    movk	fp,	#2,	lsl #16
    sub	w14,	w25,	w19
    ldr	w21,	[sp, fp]

    movz	fp,	#424
    lsl	w4,	w21,	#2
    movk	fp,	#2,	lsl #16
    mov	x19,	x4
    add	w27,	w10,	w14
    add	x19,	sp,	x19
    add	w25,	w27,	w1
    add	x19,	x19,	#16
    add	w5,	w25,	w5
    ldr	w10,	[x19]

    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w9,	w5,	w26
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w14,	w9,	w10
    movz	fp,	#424
    asr	w4,	w21,	#31
    lsl	w9,	w19,	#30
    movk	fp,	#2,	lsl #16
    lsr	w5,	w4,	#2
    ldr	w15,	[sp, fp]

    movz	fp,	#424
    add	w19,	w15,	w5
    movk	fp,	#2,	lsl #16
    asr	w5,	w19,	#30
    ldr	w21,	[sp, fp]

    movz	fp,	#412
    lsl	w4,	w5,	#30
    movk	fp,	#2,	lsl #16
    sub	w10,	w21,	w4
    ldr	w21,	[sp, fp]

    add	w26,	w21,	#1
    add	w10,	w9,	w10
    cmp	w26,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    add	w19,	w10,	w1
    movk	fp,	#2,	lsl #16
    mov	w1,	w17
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w1,	w3
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    add	w2,	w12,	w1
    add	w7,	w2,	w19
    sub	w15,	w19,	w7
    add	w9,	w15,	w2
    sub	w15,	w9,	w7
    sub	w19,	w15,	w9
    add	w23,	w19,	w7
    sub	w17,	w23,	w9
    mov	w19,	w17
    b	main_347

main_364:
    cmp	w26,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    mov	w27,	w7
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#428
    add	w17,	w10,	w21
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w4,	w17
    movk	fp,	#2,	lsl #16
    add	w1,	w9,	w10
    sub	w1,	w1,	w17
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    add	w4,	w17,	w1
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    sub	w5,	w1,	w4
    add	w13,	w5,	w24
    sub	w17,	w13,	w4
    b	main_375

main_378:
    cmp	w26,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w21,	w10,	w22
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    add	w15,	w3,	w7
    movk	fp,	#2,	lsl #16
    add	w9,	w15,	w21
    ldr	w24,	[sp, fp]

    sub	w2,	w21,	w9
    add	w5,	w2,	w15
    mov	w2,	w23
    sub	w17,	w5,	w9
    sub	w4,	w17,	w5
    add	w1,	w4,	w9
    add	w9,	w24,	w10
    sub	w4,	w1,	w5
    add	w1,	w9,	w4
    sub	w7,	w4,	w1
    add	w13,	w7,	w9
    sub	w15,	w13,	w1
    sub	w21,	w15,	w13
    add	w1,	w21,	w1
    sub	w15,	w1,	w13
    mov	w19,	w15
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    add	w17,	w10,	w4
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w5,	w19,	w17
    movk	fp,	#2,	lsl #16
    add	w7,	w5,	w10
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w4,	w7,	w17
    ldr	w12,	[sp, fp]

    add	w17,	w1,	w4
    sub	w7,	w4,	w17
    add	w1,	w7,	w12
    sub	w17,	w1,	w17
    mov	w19,	w17

main_398:
    mov	w17,	w19
    mov	w27,	w2

main_375:
    mov	w19,	w17
    mov	w13,	w27

main_347:
    lsl	w15,	w14,	#5
    asr	w2,	w14,	#31
    lsl	w25,	w26,	#2
    movz	fp,	#416
    lsr	w4,	w2,	#27
    mov	x21,	x25
    movk	fp,	#2,	lsl #16
    add	x21,	sp,	x21
    add	w5,	w14,	w4
    add	x21,	x21,	#16
    asr	w5,	w5,	#5
    ldr	w1,	[x21]

    lsl	w9,	w5,	#5
    ldr	w22,	[sp, fp]

    sub	w7,	w14,	w9
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w5,	w7,	w22
    ldr	w8,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w7,	w5,	w15
    ldr	w27,	[sp, fp]

    movz	fp,	#428
    asr	w15,	w27,	#31
    add	w5,	w7,	w19
    movk	fp,	#2,	lsl #16
    lsr	w23,	w15,	#2
    ldr	w2,	[sp, fp]

    add	w7,	w5,	w13
    movz	fp,	#428
    add	w4,	w2,	w23
    movk	fp,	#2,	lsl #16
    add	w19,	w7,	w1
    ldr	w5,	[sp, fp]

    asr	w4,	w4,	#30
    lsl	w7,	w8,	#30
    lsl	w9,	w4,	#30
    add	w4,	w26,	#1
    sub	w13,	w5,	w9
    add	w25,	w7,	w13
    cmp	w4,	#80
    blt	main_276

main_433:
    add	w17,	w19,	w11
    add	w26,	w14,	w18
    add	w15,	w25,	w0
    movz	fp,	#432
    add	w3,	w28,	#64
    add	w19,	w10,	w16
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w8,	w7,	w6
    cmp	w3,	w20
    blt	main_62

main_441:
    movz	fp,	#492
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#500
    str	w17,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#484
    str	w26,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#468
    str	w15,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#476
    str	w19,	[x22]

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
    sub	w21,	w17,	w6
    str	w21,	[x25]

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

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w17
    mov	w18,	w26
    mov	w0,	w15
    mov	w16,	w19
    mov	w6,	w8
    mov	w28,	w3
    b	main_63

main_276:
    mov	w17,	w19
    movz	fp,	#428
    mov	w5,	w14
    mov	w13,	w10
    mov	w8,	w4
    mov	w12,	w25
    movk	fp,	#2,	lsl #16
    str	w17,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    mov	w1,	w10
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#548
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


