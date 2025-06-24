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
    movz	fp,	#336
    movz	w26,	#0
    movz	w24,	#0
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
    movz	fp,	#624
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#624
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

    movz	fp,	#616
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#608
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#600
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#412
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#412
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#412
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
    movz	fp,	#616
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w1
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


main_46:
    asr	w24,	w16,	#31
    lsr	w26,	w24,	#26
    add	w27,	w16,	w26
    asr	w0,	w27,	#6
    lsl	w2,	w0,	#6
    sub	w26,	w16,	w2
    cmp	w26,	#60
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
    add	w21,	w16,	#1
    movz	w26,	#0
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w21,	#2
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    ldr	x0,	[sp, fp]

    add	w26,	w16,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x21,	x0,	x2
    movz	w2,	#0
    add	w0,	w16,	#3
    str	w23,	[x21]

    lsl	w26,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#608
    add	x24,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    add	w24,	w16,	#4
    bl	memset
    movz	w21,	#0
    movz	w17,	#8961
    movz	w27,	#43913
    movz	w3,	#56574
    movz	w5,	#21622
    movz	w19,	#57840
    mov	w1,	w21
    movk	w17,	#26437,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w5,	#4146,	lsl #16
    movk	w19,	#50130,	lsl #16
    mov	w11,	w17
    mov	w14,	w27
    mov	w26,	w3
    mov	w23,	w19

main_63:
    movz	w19,	#0
    mov	w27,	w1
    mov	w13,	w19

main_70:
    cmp	w13,	#14
    bge	main_215

main_74:
    lsl	w19,	w13,	#2
    lsl	w6,	w27,	#2
    movz	fp,	#436
    add	w15,	w27,	#2
    add	w13,	w13,	#1
    mov	x19,	x19
    movk	fp,	#2,	lsl #16
    add	x19,	sp,	x19
    lsl	w9,	w15,	#2
    ldr	x0,	[sp, fp]

    add	w15,	w27,	#4
    add	x19,	x19,	#16
    movz	fp,	#436
    add	x4,	x0,	x6
    movk	fp,	#2,	lsl #16
    add	w0,	w27,	#1
    ldr	w8,	[x4]

    lsl	w20,	w0,	#2
    ldr	x12,	[sp, fp]

    lsl	w17,	w8,	#24
    movz	fp,	#436
    add	x3,	x12,	x20
    movk	fp,	#2,	lsl #16
    add	w20,	w15,	#2
    ldr	w6,	[x3]

    ldr	x25,	[sp, fp]

    lsl	w8,	w6,	#16
    movz	fp,	#436
    add	x21,	x25,	x9
    add	w10,	w8,	w17
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x21]

    ldr	x0,	[sp, fp]

    lsl	w3,	w2,	#8
    movz	fp,	#436
    add	w4,	w10,	w3
    movk	fp,	#2,	lsl #16
    add	w10,	w27,	#3
    lsl	w16,	w10,	#2
    lsl	w10,	w13,	#2
    add	x12,	x0,	x16
    mov	x8,	x10
    lsl	w0,	w15,	#2
    add	w16,	w15,	#4
    add	x8,	sp,	x8
    ldr	w18,	[x12]

    add	w9,	w4,	w18
    add	x8,	x8,	#16
    str	w9,	[x19]

    ldr	x12,	[sp, fp]

    movz	fp,	#436
    add	x28,	x12,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w15,	#1
    ldr	w2,	[x28]

    lsl	w18,	w0,	#2
    lsl	w27,	w2,	#24
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x2,	x2,	x18
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x2]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#436
    add	w9,	w13,	#1
    add	w18,	w10,	w27
    movk	fp,	#2,	lsl #16
    lsl	w10,	w20,	#2
    add	x0,	x7,	x10
    add	w10,	w15,	#3
    ldr	w4,	[x0]

    lsl	w21,	w10,	#2
    ldr	x12,	[sp, fp]

    lsl	w6,	w4,	#8
    lsl	w10,	w9,	#2
    movz	fp,	#436
    add	x12,	x12,	x21
    lsl	w4,	w16,	#2
    add	w20,	w18,	w6
    movk	fp,	#2,	lsl #16
    add	w21,	w16,	#2
    ldr	w27,	[x12]

    add	w7,	w20,	w27
    str	w7,	[x8]

    add	w8,	w16,	#1
    ldr	x0,	[sp, fp]

    mov	x7,	x10
    movz	fp,	#436
    add	x3,	x0,	x4
    add	x7,	sp,	x7
    lsl	w15,	w8,	#2
    movk	fp,	#2,	lsl #16
    lsl	w0,	w21,	#2
    ldr	w6,	[x3]

    add	x7,	x7,	#16
    ldr	x19,	[sp, fp]

    lsl	w3,	w6,	#24
    movz	fp,	#436
    add	x12,	x19,	x15
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    ldr	x20,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#436
    add	x27,	x20,	x0
    add	w15,	w9,	#1
    add	w17,	w17,	w3
    movk	fp,	#2,	lsl #16
    add	w3,	w16,	#3
    ldr	w0,	[x27]

    add	w8,	w15,	#1
    ldr	x4,	[sp, fp]

    lsl	w2,	w0,	#8
    movz	fp,	#436
    lsl	w0,	w3,	#2
    movk	fp,	#2,	lsl #16
    add	w6,	w17,	w2
    add	x20,	x4,	x0
    lsl	w0,	w15,	#2
    mov	x9,	x0
    ldr	w3,	[x20]

    add	x9,	sp,	x9
    add	w20,	w16,	#4
    add	w10,	w6,	w3
    add	x9,	x9,	#16
    lsl	w0,	w20,	#2
    str	w10,	[x7]

    add	w10,	w20,	#1
    ldr	x12,	[sp, fp]

    movz	fp,	#436
    add	x28,	x12,	x0
    movk	fp,	#2,	lsl #16
    lsl	w13,	w10,	#2
    ldr	w2,	[x28]

    add	w28,	w20,	#3
    ldr	x6,	[sp, fp]

    lsl	w2,	w2,	#24
    movz	fp,	#436
    add	x12,	x6,	x13
    movk	fp,	#2,	lsl #16
    add	w6,	w20,	#2
    ldr	w17,	[x12]

    lsl	w10,	w6,	#2
    ldr	x16,	[sp, fp]

    lsl	w19,	w17,	#16
    movz	fp,	#436
    add	x7,	x16,	x10
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w2
    add	w10,	w20,	#4
    lsl	w2,	w28,	#2
    ldr	w13,	[x7]

    ldr	x16,	[sp, fp]

    lsl	w17,	w13,	#8
    movz	fp,	#436
    add	w13,	w10,	#1
    add	w4,	w0,	w17
    movk	fp,	#2,	lsl #16
    add	x0,	x16,	x2
    lsl	w13,	w13,	#2
    ldr	w3,	[x0]

    add	w7,	w4,	w3
    lsl	w3,	w8,	#2
    mov	x19,	x3
    str	w7,	[x9]

    lsl	w3,	w10,	#2
    add	x19,	sp,	x19
    ldr	x21,	[sp, fp]

    movz	fp,	#436
    add	x0,	x21,	x3
    movk	fp,	#2,	lsl #16
    add	x19,	x19,	#16
    ldr	w4,	[x0]

    add	w0,	w10,	#2
    ldr	x18,	[sp, fp]

    lsl	w6,	w4,	#24
    movz	fp,	#436
    add	x15,	x18,	x13
    movk	fp,	#2,	lsl #16
    lsl	w0,	w0,	#2
    ldr	w17,	[x15]

    ldr	x16,	[sp, fp]

    lsl	w21,	w17,	#16
    movz	fp,	#436
    add	x2,	x16,	x0
    add	w21,	w21,	w6
    movk	fp,	#2,	lsl #16
    add	w0,	w10,	#3
    ldr	w9,	[x2]

    ldr	x27,	[sp, fp]

    lsl	w16,	w9,	#8
    lsl	w4,	w0,	#2
    movz	fp,	#436
    add	w12,	w21,	w16
    add	w0,	w8,	#1
    add	x3,	x27,	x4
    movk	fp,	#2,	lsl #16
    add	w4,	w10,	#4
    lsl	w16,	w0,	#2
    ldr	w6,	[x3]

    mov	x13,	x16
    lsl	w27,	w4,	#2
    add	w6,	w12,	w6
    add	w16,	w4,	#1
    add	x13,	sp,	x13
    add	w12,	w4,	#2
    str	w6,	[x19]

    add	x13,	x13,	#16
    ldr	x9,	[sp, fp]

    movz	fp,	#436
    add	x20,	x9,	x27
    movk	fp,	#2,	lsl #16
    lsl	w9,	w16,	#2
    ldr	w28,	[x20]

    lsl	w6,	w28,	#24
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x18,	x28,	x9
    movk	fp,	#2,	lsl #16
    add	w28,	w4,	#3
    ldr	w2,	[x18]

    ldr	x15,	[sp, fp]

    lsl	w7,	w2,	#16
    movz	fp,	#436
    add	w8,	w7,	w6
    movk	fp,	#2,	lsl #16
    lsl	w6,	w28,	#2
    lsl	w7,	w12,	#2
    add	x15,	x15,	x7
    ldr	w18,	[x15]

    ldr	x15,	[sp, fp]

    lsl	w21,	w18,	#8
    movz	fp,	#436
    add	x3,	x15,	x6
    add	w20,	w8,	w21
    movk	fp,	#2,	lsl #16
    add	w15,	w0,	#1
    ldr	w12,	[x3]

    add	w3,	w4,	#4
    add	w2,	w20,	w12
    lsl	w9,	w15,	#2
    mov	x8,	x9
    add	w21,	w3,	#1
    lsl	w0,	w3,	#2
    str	w2,	[x13]

    add	w9,	w3,	#3
    add	x8,	sp,	x8
    add	w13,	w3,	#2
    lsl	w12,	w21,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#436
    add	x18,	x17,	x0
    add	x8,	x8,	#16
    lsl	w21,	w13,	#2
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x18]

    ldr	x17,	[sp, fp]

    lsl	w18,	w6,	#24
    movz	fp,	#436
    add	x27,	x17,	x12
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x27]

    add	w27,	w3,	#4
    lsl	w2,	w0,	#16
    add	w4,	w2,	w18
    ldr	x18,	[sp, fp]

    movz	fp,	#436
    add	x16,	x18,	x21
    movk	fp,	#2,	lsl #16
    ldr	w20,	[x16]

    lsl	w16,	w9,	#2
    lsl	w0,	w20,	#8
    ldr	x20,	[sp, fp]

    add	w6,	w4,	w0
    add	x13,	x20,	x16
    add	w4,	w15,	#1
    ldr	w17,	[x13]

    mov	w13,	w4
    add	w7,	w6,	w17
    str	w7,	[x8]

    b	main_70

main_215:
    mov	w20,	w27
    mov	w6,	w13

main_217:
    lsl	w9,	w6,	#2
    lsl	w15,	w20,	#2
    movz	fp,	#436
    add	w3,	w20,	#1
    mov	x7,	x9
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    lsl	w0,	w3,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x16,	x4,	x15
    add	x7,	x7,	#16
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x16]

    ldr	x4,	[sp, fp]

    lsl	w28,	w21,	#24
    movz	fp,	#436
    add	x10,	x4,	x0
    add	w21,	w20,	#4
    movk	fp,	#2,	lsl #16
    add	w0,	w20,	#2
    ldr	w13,	[x10]

    ldr	x4,	[sp, fp]

    lsl	w16,	w13,	#16
    lsl	w17,	w0,	#2
    movz	fp,	#436
    add	w16,	w16,	w28
    movk	fp,	#2,	lsl #16
    add	x3,	x4,	x17
    add	w28,	w6,	#1
    ldr	w10,	[x3]

    add	w3,	w20,	#3
    lsl	w12,	w10,	#8
    ldr	x10,	[sp, fp]

    add	w12,	w16,	w12
    lsl	w27,	w3,	#2
    add	x10,	x10,	x27
    ldr	w17,	[x10]

    add	w27,	w12,	w17
    str	w27,	[x7]

    cmp	w28,	#16
    bge	main_241

main_216:
    mov	w20,	w21
    mov	w6,	w28
    b	main_217

main_241:
    mov	w15,	w28
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#508
    lsl	w21,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x19,	x21
    add	x19,	sp,	x19
    ldr	w25,	[sp, fp]

    movz	fp,	#508
    sub	w28,	w25,	#3
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    lsl	w6,	w28,	#2
    mov	x4,	x6
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w7,	[x4]

    ldr	w3,	[sp, fp]

    movz	fp,	#508
    sub	w6,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w10,	w6,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w12,	[x9]

    ldr	w4,	[sp, fp]

    add	w9,	w12,	w7
    movz	fp,	#508
    sub	w27,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w15,	w7,	w9
    lsl	w0,	w27,	#2
    mov	x28,	x0
    add	w20,	w15,	w12
    add	x28,	sp,	x28
    sub	w9,	w20,	w9
    add	x28,	x28,	#16
    ldr	w6,	[x28]

    add	w0,	w6,	w9
    sub	w3,	w9,	w0
    add	w12,	w3,	w6
    ldr	w6,	[sp, fp]

    movz	fp,	#508
    sub	w27,	w12,	w0
    movk	fp,	#2,	lsl #16
    sub	w0,	w6,	#16
    lsl	w4,	w0,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    ldr	w6,	[x3]

    add	w4,	w6,	w27
    sub	w12,	w27,	w4
    add	w13,	w12,	w6
    sub	w18,	w13,	w4
    asr	w0,	w18,	#31
    lsl	w10,	w18,	#1
    lsr	w3,	w0,	#31
    add	w4,	w18,	w3
    asr	w13,	w4,	#1
    lsl	w17,	w13,	#1
    sub	w6,	w18,	w17
    add	w8,	w10,	w6
    str	w8,	[x19]

    ldr	w17,	[sp, fp]

    movz	fp,	#508
    add	w9,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w9
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w28,	w11
    movz	fp,	#428
    mov	w3,	w14
    mov	w20,	w26
    mov	w9,	w5
    mov	w4,	w23
    movz	w7,	#0
    movk	fp,	#2,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    mov	w3,	w7
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]


main_277:
    movz	w3,	#48348
    movz	w15,	#60289
    movz	w2,	#31129
    movz	w21,	#65535
    movz	fp,	#404
    movk	w3,	#36635,	lsl #16
    movk	w15,	#28377,	lsl #16
    movk	w2,	#23170,	lsl #16
    movk	w21,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w20,	w3
    mov	w10,	w15
    mov	w18,	w2
    mov	w17,	w21
    ldr	w16,	[sp, fp]

    movz	w3,	#49414
    movk	w3,	#51810,	lsl #16
    cmp	w16,	#20
    bge	main_296

main_285:
    movz	fp,	#416
    mov	w7,	w17
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#416
    add	w2,	w27,	w19
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#408
    sub	w0,	w7,	w15
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w12,	w21,	w0
    add	w15,	w12,	w2
    sub	w8,	w2,	w15
    add	w28,	w8,	w12
    sub	w12,	w28,	w15
    sub	w0,	w12,	w28
    add	w8,	w0,	w15
    mov	w15,	w18
    sub	w16,	w8,	w28
    mov	w12,	w16
    b	main_416

main_296:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#416
    add	w12,	w0,	w22
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    sub	w15,	w21,	w12
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#408
    add	w28,	w15,	w7
    movk	fp,	#2,	lsl #16
    sub	w15,	w28,	w12
    ldr	w7,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w2,	w7,	w15
    ldr	w28,	[sp, fp]

    sub	w0,	w15,	w2
    mov	w15,	w10
    add	w0,	w0,	w28
    sub	w16,	w0,	w2
    mov	w28,	w16
    b	main_413

main_307:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    cmp	w25,	#60
    bge	main_327

main_309:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#408
    add	w28,	w15,	w7
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#408
    add	w8,	w12,	w21
    movk	fp,	#2,	lsl #16
    add	w15,	w8,	w28
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w16,	w28,	w15
    ldr	w22,	[sp, fp]

    add	w2,	w16,	w8
    add	w16,	w19,	w22
    sub	w0,	w2,	w15
    sub	w8,	w0,	w2
    add	w15,	w8,	w15
    sub	w12,	w15,	w2
    add	w7,	w16,	w12
    sub	w28,	w12,	w7
    add	w15,	w28,	w16
    sub	w2,	w15,	w7
    sub	w0,	w2,	w15
    add	w8,	w0,	w7
    sub	w16,	w8,	w15
    mov	w15,	w20
    mov	w28,	w16
    b	main_413

main_327:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    add	w2,	w21,	w12
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w15,	w2
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#408
    add	w0,	w7,	w22
    movk	fp,	#2,	lsl #16
    sub	w7,	w0,	w2
    ldr	w19,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w7
    ldr	w13,	[sp, fp]

    sub	w15,	w7,	w0
    add	w8,	w15,	w13
    mov	w15,	w3
    sub	w16,	w8,	w0
    mov	w28,	w16

main_413:
    mov	w12,	w28

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w8,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#428
    asr	w16,	w13,	#31
    movk	fp,	#2,	lsl #16
    lsr	w21,	w16,	#27
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w16,	w22,	w21
    movk	fp,	#2,	lsl #16
    asr	w16,	w16,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#404
    lsl	w21,	w16,	#5
    movk	fp,	#2,	lsl #16
    sub	w16,	w28,	w21
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    lsl	w0,	w22,	#2
    movk	fp,	#2,	lsl #16
    add	w28,	w8,	w16
    mov	x16,	x0
    add	x16,	sp,	x16
    add	w0,	w28,	w4
    add	x16,	x16,	#16
    ldr	w8,	[x16]

    ldr	w19,	[sp, fp]

    add	w16,	w0,	w12
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w12,	w16,	w15
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    asr	w4,	w21,	#31
    add	w12,	w12,	w8
    movk	fp,	#2,	lsl #16
    lsr	w16,	w4,	#2
    lsl	w8,	w19,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    add	w21,	w19,	w16
    movk	fp,	#2,	lsl #16
    asr	w7,	w21,	#30
    ldr	w21,	[sp, fp]

    lsl	w7,	w7,	#30
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    sub	w16,	w21,	w7
    ldr	w21,	[sp, fp]

    add	w28,	w21,	#1
    add	w16,	w8,	w16
    cmp	w28,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w8,	w17
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w15,	w16,	w0
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w8,	w3
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w3,	w13,	w0
    add	w7,	w3,	w15
    sub	w17,	w15,	w7
    add	w20,	w17,	w3
    sub	w17,	w20,	w7
    sub	w19,	w17,	w20
    add	w0,	w19,	w7
    mov	w7,	w18
    sub	w21,	w0,	w20
    mov	w0,	w21
    b	main_347

main_364:
    cmp	w28,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    mov	w2,	w10
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#428
    add	w19,	w16,	w21
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w6,	w19
    movk	fp,	#2,	lsl #16
    add	w0,	w7,	w16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w19
    ldr	w25,	[sp, fp]

    add	w3,	w20,	w0
    sub	w7,	w0,	w3
    add	w17,	w7,	w25
    sub	w19,	w17,	w3
    b	main_375

main_378:
    cmp	w28,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w19,	w16,	w22
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    add	w18,	w3,	w9
    movk	fp,	#2,	lsl #16
    add	w4,	w18,	w19
    ldr	w25,	[sp, fp]

    add	w8,	w25,	w16
    sub	w3,	w19,	w4
    add	w7,	w3,	w18
    sub	w19,	w7,	w4
    sub	w3,	w19,	w7
    add	w0,	w3,	w4
    sub	w4,	w0,	w7
    add	w2,	w8,	w4
    sub	w10,	w4,	w2
    mov	w4,	w20
    add	w15,	w10,	w8
    sub	w17,	w15,	w2
    sub	w0,	w17,	w15
    add	w3,	w0,	w2
    sub	w18,	w3,	w15
    mov	w21,	w18
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#428
    add	w19,	w16,	w7
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w21,	w19
    movk	fp,	#2,	lsl #16
    add	w8,	w7,	w16
    ldr	w0,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w2,	w8,	w19
    ldr	w13,	[sp, fp]

    add	w18,	w0,	w2
    sub	w8,	w2,	w18
    add	w4,	w8,	w13
    sub	w19,	w4,	w18
    mov	w4,	w3
    mov	w21,	w19

main_398:
    mov	w19,	w21
    mov	w2,	w4

main_375:
    mov	w0,	w19
    mov	w7,	w2

main_347:
    lsl	w19,	w12,	#5
    asr	w4,	w12,	#31
    lsl	w21,	w28,	#2
    movz	fp,	#408
    lsr	w8,	w4,	#27
    mov	x18,	x21
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    add	w10,	w12,	w8
    add	x18,	x18,	#16
    asr	w10,	w10,	#5
    ldr	w2,	[x18]

    lsl	w15,	w10,	#5
    ldr	w25,	[sp, fp]

    sub	w15,	w12,	w15
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w10,	w15,	w25
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w13,	w10,	w19
    ldr	w27,	[sp, fp]

    lsl	w10,	w9,	#30
    movz	fp,	#428
    asr	w18,	w27,	#31
    add	w4,	w13,	w0
    movk	fp,	#2,	lsl #16
    lsr	w27,	w18,	#2
    add	w8,	w4,	w7
    add	w21,	w8,	w2
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    add	w3,	w2,	w27
    movk	fp,	#2,	lsl #16
    asr	w4,	w3,	#30
    ldr	w8,	[sp, fp]

    lsl	w7,	w4,	#30
    sub	w15,	w8,	w7
    add	w8,	w28,	#1
    add	w0,	w10,	w15
    cmp	w8,	#80
    blt	main_276

main_433:
    add	w17,	w21,	w11
    add	w20,	w12,	w14
    add	w7,	w16,	w5
    movz	fp,	#432
    add	w1,	w1,	#64
    add	w12,	w0,	w26
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    add	w0,	w8,	w23
    cmp	w1,	w24
    blt	main_62

main_441:
    movz	fp,	#460
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#468
    str	w17,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#452
    str	w20,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#600
    str	w12,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#444
    str	w7,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w0,	[x23]


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
    sub	w20,	w16,	w5
    str	w20,	[x23]

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

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w17
    mov	w14,	w20
    mov	w26,	w12
    mov	w5,	w7
    mov	w23,	w0
    b	main_63

main_276:
    mov	w20,	w21
    movz	fp,	#428
    mov	w15,	w12
    mov	w10,	w8
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#404
    mov	w4,	w13
    movk	fp,	#2,	lsl #16
    mov	w13,	w0
    str	w10,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#624
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


