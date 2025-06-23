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
    movz	w23,	#0
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
    movz	w6,	#0
    movz	w5,	#0
    movz	w2,	#0
    movz	fp,	#356
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#444
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

    movz	fp,	#548
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#532
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
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
    lsr	w24,	w22,	#24
    add	w25,	w1,	w24
    asr	w21,	w25,	#8
    lsl	w22,	w21,	#8
    sub	w25,	w1,	w22
    str	w25,	[x13]

    str	w1,	[sp, fp]

    b	main_31

main_45:
    movz	w20,	#128
    movz	fp,	#548
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w1
    ldr	x12,	[sp, fp]

    str	w20,	[x12]


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
    add	w21,	w16,	#1
    movz	w25,	#0
    movz	w22,	#125
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
    str	w25,	[x1]

    add	w1,	w16,	#3
    ldr	x0,	[sp, fp]

    add	w25,	w16,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x21,	x0,	x2
    movz	w2,	#0
    str	w22,	[x21]

    ldr	x1,	[sp, fp]

    movz	fp,	#540
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    add	w25,	w16,	#4
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w21,	#0
    movz	w26,	#43913
    movz	w17,	#8961
    movz	w5,	#56574
    movz	w6,	#21622
    movk	w26,	#61389,	lsl #16
    movk	w17,	#26437,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w28,	w26
    mov	w2,	w17
    mov	w14,	w5
    mov	w20,	w6
    movz	w17,	#57840
    movk	w17,	#50130,	lsl #16
    mov	w26,	w17
    mov	w17,	w21

main_63:
    movz	w13,	#0
    mov	w19,	w17
    mov	w10,	w13

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w13,	w10,	#2
    lsl	w5,	w19,	#2
    movz	fp,	#436
    add	w11,	w19,	#2
    add	w10,	w10,	#1
    mov	x13,	x13
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    lsl	w7,	w11,	#2
    ldr	x0,	[sp, fp]

    add	w11,	w19,	#4
    add	x13,	x13,	#16
    movz	fp,	#436
    add	x4,	x0,	x5
    movk	fp,	#2,	lsl #16
    add	w22,	w11,	#1
    lsl	w24,	w11,	#2
    add	w0,	w19,	#1
    ldr	w6,	[x4]

    ldr	x9,	[sp, fp]

    lsl	w18,	w6,	#24
    lsl	w15,	w0,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	x1,	x9,	x15
    ldr	w5,	[x1]

    ldr	x21,	[sp, fp]

    lsl	w6,	w5,	#16
    movz	fp,	#436
    add	x16,	x21,	x7
    add	w8,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	w7,	w19,	#3
    ldr	w0,	[x16]

    add	w19,	w11,	#2
    lsl	w16,	w22,	#2
    ldr	x27,	[sp, fp]

    lsl	w12,	w7,	#2
    lsl	w3,	w0,	#8
    movz	fp,	#436
    add	x9,	x27,	x12
    add	w4,	w8,	w3
    movk	fp,	#2,	lsl #16
    add	w12,	w11,	#4
    lsl	w8,	w10,	#2
    ldr	w18,	[x9]

    mov	x6,	x8
    add	w7,	w4,	w18
    add	x6,	sp,	x6
    str	w7,	[x13]

    add	x6,	x6,	#16
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x21,	x8,	x24
    movk	fp,	#2,	lsl #16
    lsl	w8,	w19,	#2
    ldr	w1,	[x21]

    lsl	w18,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x0,	x1,	x16
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    ldr	x4,	[sp, fp]

    lsl	w7,	w5,	#16
    movz	fp,	#436
    add	x0,	x4,	x8
    add	w15,	w7,	w18
    movk	fp,	#2,	lsl #16
    add	w8,	w11,	#3
    ldr	w4,	[x0]

    ldr	x9,	[sp, fp]

    lsl	w5,	w4,	#8
    movz	fp,	#436
    add	w16,	w15,	w5
    movk	fp,	#2,	lsl #16
    lsl	w5,	w12,	#2
    lsl	w15,	w8,	#2
    add	x9,	x9,	x15
    ldr	w18,	[x9]

    add	w4,	w16,	w18
    add	w16,	w12,	#2
    str	w4,	[x6]

    lsl	w24,	w16,	#2
    ldr	x0,	[sp, fp]

    add	w6,	w10,	#1
    movz	fp,	#436
    add	x1,	x0,	x5
    movk	fp,	#2,	lsl #16
    add	w5,	w12,	#3
    lsl	w8,	w6,	#2
    ldr	w7,	[x1]

    mov	x3,	x8
    ldr	x18,	[sp, fp]

    lsl	w1,	w7,	#24
    add	w8,	w12,	#1
    add	x3,	sp,	x3
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w11,	w8,	#2
    add	x3,	x3,	#16
    add	x9,	x18,	x11
    ldr	w11,	[x9]

    ldr	x18,	[sp, fp]

    lsl	w13,	w11,	#16
    movz	fp,	#436
    add	x18,	x18,	x24
    add	w11,	w13,	w1
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x18]

    add	w18,	w6,	#1
    lsl	w0,	w22,	#8
    add	w6,	w12,	#4
    add	w4,	w11,	w0
    lsl	w0,	w5,	#2
    add	w7,	w6,	#1
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x19,	x5,	x0
    movk	fp,	#2,	lsl #16
    add	w5,	w6,	#2
    lsl	w0,	w18,	#2
    ldr	w1,	[x19]

    mov	x22,	x0
    lsl	w11,	w5,	#2
    lsl	w19,	w6,	#2
    add	w8,	w4,	w1
    add	x22,	sp,	x22
    str	w8,	[x3]

    add	x22,	x22,	#16
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x15,	x8,	x19
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x15]

    ldr	x9,	[sp, fp]

    add	w15,	w6,	#3
    lsl	w4,	w1,	#24
    movz	fp,	#436
    lsl	w1,	w7,	#2
    movk	fp,	#2,	lsl #16
    lsl	w21,	w15,	#2
    add	x8,	x9,	x1
    ldr	w12,	[x8]

    ldr	x9,	[sp, fp]

    lsl	w16,	w12,	#16
    movz	fp,	#436
    add	x8,	x9,	x11
    add	w12,	w6,	#4
    add	w0,	w16,	w4
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x8]

    add	w13,	w12,	#1
    lsl	w5,	w12,	#2
    lsl	w11,	w10,	#8
    ldr	x10,	[sp, fp]

    lsl	w15,	w13,	#2
    add	w4,	w0,	w11
    movz	fp,	#436
    add	x16,	x10,	x21
    movk	fp,	#2,	lsl #16
    add	w10,	w18,	#1
    ldr	w3,	[x16]

    add	w7,	w10,	#1
    lsl	w1,	w10,	#2
    add	w4,	w4,	w3
    add	w10,	w12,	#4
    mov	x0,	x1
    add	x0,	sp,	x0
    str	w4,	[x22]

    add	w11,	w10,	#2
    add	w4,	w12,	#2
    ldr	x22,	[sp, fp]

    add	x0,	x0,	#16
    movz	fp,	#436
    add	x3,	x22,	x5
    movk	fp,	#2,	lsl #16
    lsl	w5,	w4,	#2
    ldr	w6,	[x3]

    ldr	x21,	[sp, fp]

    add	w3,	w12,	#3
    lsl	w8,	w6,	#24
    movz	fp,	#436
    add	x15,	x21,	x15
    add	w12,	w10,	#1
    movk	fp,	#2,	lsl #16
    ldr	w19,	[x15]

    lsl	w15,	w7,	#2
    ldr	x18,	[sp, fp]

    lsl	w22,	w19,	#16
    movz	fp,	#436
    add	x6,	x18,	x5
    add	w19,	w10,	#3
    add	w22,	w22,	w8
    movk	fp,	#2,	lsl #16
    lsl	w18,	w10,	#2
    ldr	w9,	[x6]

    lsl	w6,	w3,	#2
    ldr	x27,	[sp, fp]

    lsl	w13,	w9,	#8
    mov	x3,	x15
    movz	fp,	#436
    add	x5,	x27,	x6
    add	w9,	w22,	w13
    add	x3,	sp,	x3
    movk	fp,	#2,	lsl #16
    lsl	w6,	w11,	#2
    ldr	w8,	[x5]

    add	x3,	x3,	#16
    add	w8,	w9,	w8
    lsl	w9,	w12,	#2
    str	w8,	[x0]

    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x16,	x4,	x18
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x16]

    ldr	x23,	[sp, fp]

    lsl	w4,	w21,	#24
    movz	fp,	#436
    add	x15,	x23,	x9
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x15]

    ldr	x8,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#436
    add	x13,	x8,	x6
    add	w5,	w1,	w4
    movk	fp,	#2,	lsl #16
    add	w1,	w7,	#1
    lsl	w4,	w19,	#2
    ldr	w16,	[x13]

    add	w7,	w10,	#4
    ldr	x11,	[sp, fp]

    lsl	w18,	w16,	#8
    lsl	w8,	w1,	#2
    movz	fp,	#436
    add	w9,	w7,	#3
    add	w10,	w7,	#2
    add	x0,	x11,	x4
    add	w16,	w5,	w18
    add	w1,	w1,	#1
    movk	fp,	#2,	lsl #16
    lsl	w21,	w10,	#2
    mov	x5,	x8
    ldr	w6,	[x0]

    add	x5,	sp,	x5
    lsl	w0,	w7,	#2
    add	w24,	w16,	w6
    add	x5,	x5,	#16
    str	w24,	[x3]

    ldr	x15,	[sp, fp]

    movz	fp,	#436
    add	x16,	x15,	x0
    movk	fp,	#2,	lsl #16
    add	w15,	w7,	#1
    ldr	w3,	[x16]

    lsl	w11,	w15,	#2
    lsl	w13,	w3,	#24
    ldr	x15,	[sp, fp]

    movz	fp,	#436
    add	x16,	x15,	x11
    movk	fp,	#2,	lsl #16
    lsl	w11,	w9,	#2
    ldr	w19,	[x16]

    ldr	x16,	[sp, fp]

    lsl	w22,	w19,	#16
    movz	fp,	#436
    add	x12,	x16,	x21
    add	w0,	w22,	w13
    movk	fp,	#2,	lsl #16
    ldr	w19,	[x12]

    lsl	w3,	w19,	#8
    ldr	x19,	[sp, fp]

    add	w4,	w0,	w3
    add	x10,	x19,	x11
    add	w19,	w7,	#4
    ldr	w12,	[x10]

    mov	w10,	w1
    add	w8,	w4,	w12
    str	w8,	[x5]

    b	main_70

main_215:
    mov	w16,	w19
    mov	w3,	w10

main_217:
    lsl	w7,	w3,	#2
    lsl	w11,	w16,	#2
    movz	fp,	#436
    add	w4,	w16,	#1
    add	w0,	w16,	#2
    add	w22,	w3,	#1
    mov	x6,	x7
    movk	fp,	#2,	lsl #16
    lsl	w24,	w4,	#2
    add	x6,	sp,	x6
    ldr	x5,	[sp, fp]

    add	w4,	w16,	#3
    movz	fp,	#436
    add	x12,	x5,	x11
    add	x6,	x6,	#16
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    ldr	x1,	[sp, fp]

    lsl	w18,	w15,	#24
    movz	fp,	#436
    add	x7,	x1,	x24
    lsl	w15,	w0,	#2
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x7]

    ldr	x5,	[sp, fp]

    lsl	w12,	w10,	#16
    movz	fp,	#436
    add	x1,	x5,	x15
    add	w12,	w12,	w18
    movk	fp,	#2,	lsl #16
    lsl	w18,	w4,	#2
    ldr	w8,	[x1]

    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w12,	w9
    add	x7,	x8,	x18
    ldr	w13,	[x7]

    add	w18,	w9,	w13
    str	w18,	[x6]

    add	w18,	w16,	#4
    cmp	w22,	#16
    bge	main_241

main_216:
    mov	w16,	w18
    mov	w3,	w22
    b	main_217

main_241:
    mov	w12,	w22
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]


main_242:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#504
    lsl	w19,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x13,	x19
    add	x13,	sp,	x13
    ldr	w23,	[sp, fp]

    movz	fp,	#504
    sub	w24,	w23,	#3
    add	x13,	x13,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w24,	#2
    mov	x1,	x3
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w5,	[x1]

    ldr	w3,	[sp, fp]

    movz	fp,	#504
    sub	w6,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w6,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w9,	[x7]

    ldr	w4,	[sp, fp]

    add	w7,	w9,	w5
    movz	fp,	#504
    sub	w19,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w11,	w5,	w7
    lsl	w0,	w19,	#2
    mov	x22,	x0
    add	w15,	w11,	w9
    add	x22,	sp,	x22
    sub	w7,	w15,	w7
    add	x22,	x22,	#16
    ldr	w3,	[x22]

    ldr	w5,	[sp, fp]

    add	w24,	w3,	w7
    movz	fp,	#504
    sub	w0,	w5,	#16
    movk	fp,	#2,	lsl #16
    sub	w1,	w7,	w24
    lsl	w4,	w0,	#2
    add	w8,	w1,	w3
    mov	x1,	x4
    add	x1,	sp,	x1
    sub	w21,	w8,	w24
    add	x1,	x1,	#16
    ldr	w5,	[x1]

    add	w4,	w5,	w21
    sub	w9,	w21,	w4
    add	w10,	w9,	w5
    sub	w15,	w10,	w4
    asr	w0,	w15,	#31
    lsl	w9,	w15,	#1
    lsr	w1,	w0,	#31
    add	w4,	w15,	w1
    asr	w10,	w4,	#1
    lsl	w11,	w10,	#1
    sub	w5,	w15,	w11
    add	w6,	w9,	w5
    str	w6,	[x13]

    ldr	w15,	[sp, fp]

    movz	fp,	#504
    add	w7,	w15,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w23,	w2
    movz	fp,	#428
    mov	w1,	w28
    mov	w9,	w20
    mov	w24,	w26
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w4
    str	w23,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_277:
    movz	w0,	#48348
    movz	w9,	#60289
    movz	w1,	#49414
    movz	w22,	#31129
    movz	w19,	#65535
    movz	fp,	#412
    movk	w0,	#36635,	lsl #16
    movk	w9,	#28377,	lsl #16
    movk	w1,	#51810,	lsl #16
    movk	w22,	#23170,	lsl #16
    movk	w19,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w16,	w0
    mov	w8,	w9
    mov	w13,	w22
    mov	w15,	w19
    ldr	w11,	[sp, fp]

    cmp	w11,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w0,	w15
    mov	w22,	w13
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w3,	w19,	w12
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    sub	w0,	w0,	w10
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    add	w9,	w18,	w0
    add	w18,	w9,	w3
    sub	w4,	w3,	w18
    add	w21,	w4,	w9
    sub	w9,	w21,	w18
    sub	w0,	w9,	w21
    add	w6,	w0,	w18
    sub	w3,	w6,	w21
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    cmp	w12,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#424
    add	w3,	w22,	w21
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w18,	w3
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#416
    add	w18,	w9,	w6
    movk	fp,	#2,	lsl #16
    sub	w22,	w18,	w3
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w0,	w5,	w22
    ldr	w27,	[sp, fp]

    sub	w3,	w22,	w0
    mov	w22,	w8
    add	w3,	w3,	w27
    sub	w3,	w3,	w0
    mov	w4,	w3
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    cmp	w18,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    mov	w22,	w16
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    add	w21,	w9,	w5
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#416
    add	w6,	w7,	w18
    movk	fp,	#2,	lsl #16
    add	w9,	w6,	w21
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w18,	w21,	w9
    ldr	w19,	[sp, fp]

    add	w3,	w18,	w6
    sub	w0,	w3,	w9
    sub	w6,	w0,	w3
    add	w18,	w6,	w9
    sub	w3,	w18,	w3
    add	w18,	w12,	w19
    add	w19,	w18,	w3
    sub	w21,	w3,	w19
    add	w9,	w21,	w18
    sub	w3,	w9,	w19
    sub	w0,	w3,	w9
    add	w6,	w0,	w19
    sub	w3,	w6,	w9
    mov	w4,	w3
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#424
    add	w0,	w18,	w7
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w9,	w0
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    add	w22,	w6,	w19
    movk	fp,	#2,	lsl #16
    sub	w3,	w22,	w0
    ldr	w12,	[sp, fp]

    mov	w22,	w1
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w0,	w12,	w3
    ldr	w9,	[sp, fp]

    sub	w18,	w3,	w0
    add	w4,	w18,	w9
    sub	w3,	w4,	w0
    mov	w4,	w3

main_413:
    mov	w3,	w4

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w6,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#428
    asr	w18,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w19,	w18,	#27
    ldr	w12,	[sp, fp]

    movz	fp,	#428
    add	w0,	w12,	w19
    movk	fp,	#2,	lsl #16
    asr	w18,	w0,	#5
    ldr	w23,	[sp, fp]

    movz	fp,	#412
    lsl	w19,	w18,	#5
    movk	fp,	#2,	lsl #16
    sub	w0,	w23,	w19
    ldr	w18,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w19,	w6,	w0
    lsl	w0,	w18,	#2
    mov	x18,	x0
    add	w19,	w19,	w24
    add	x18,	sp,	x18
    add	w4,	w19,	w3
    add	x18,	x18,	#16
    ldr	w9,	[x18]

    add	w18,	w4,	w22
    add	w9,	w18,	w9
    ldr	w18,	[sp, fp]

    movz	fp,	#424
    lsl	w18,	w18,	#30
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    asr	w3,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w4,	w3,	#2
    ldr	w12,	[sp, fp]

    movz	fp,	#424
    add	w6,	w12,	w4
    movk	fp,	#2,	lsl #16
    asr	w6,	w6,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#412
    lsl	w4,	w6,	#30
    movk	fp,	#2,	lsl #16
    sub	w4,	w19,	w4
    ldr	w19,	[sp, fp]

    add	w22,	w19,	#1
    add	w18,	w18,	w4
    cmp	w22,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w6,	w15
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w12,	w18,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w6,	w1
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w1,	w10,	w0
    add	w3,	w1,	w12
    sub	w12,	w12,	w3
    add	w11,	w12,	w1
    sub	w12,	w11,	w3
    sub	w15,	w12,	w11
    mov	w12,	w13
    add	w19,	w15,	w3
    sub	w16,	w19,	w11
    mov	w21,	w16
    b	main_347

main_364:
    cmp	w22,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#428
    add	w13,	w18,	w15
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w5,	w13
    movk	fp,	#2,	lsl #16
    add	w0,	w6,	w18
    sub	w0,	w0,	w13
    ldr	w13,	[sp, fp]

    movz	fp,	#432
    add	w3,	w13,	w0
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    sub	w6,	w0,	w3
    mov	w0,	w8
    add	w12,	w6,	w19
    sub	w13,	w12,	w3
    b	main_375

main_378:
    cmp	w22,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    mov	w1,	w16
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#428
    add	w15,	w18,	w15
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    add	w12,	w3,	w7
    movk	fp,	#2,	lsl #16
    add	w4,	w12,	w15
    ldr	w19,	[sp, fp]

    add	w11,	w19,	w18
    sub	w24,	w15,	w4
    add	w6,	w24,	w12
    sub	w13,	w6,	w4
    sub	w3,	w13,	w6
    add	w0,	w3,	w4
    sub	w3,	w0,	w6
    add	w0,	w11,	w3
    sub	w8,	w3,	w0
    add	w11,	w8,	w11
    sub	w12,	w11,	w0
    sub	w19,	w12,	w11
    add	w24,	w19,	w0
    sub	w12,	w24,	w11
    mov	w15,	w12
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    add	w13,	w18,	w4
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    sub	w6,	w15,	w13
    movk	fp,	#2,	lsl #16
    add	w8,	w6,	w18
    ldr	w0,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w3,	w8,	w13
    ldr	w10,	[sp, fp]

    add	w13,	w0,	w3
    sub	w8,	w3,	w13
    add	w24,	w8,	w10
    sub	w13,	w24,	w13
    mov	w15,	w13

main_398:
    mov	w13,	w15
    mov	w0,	w1

main_375:
    mov	w21,	w13
    mov	w12,	w0

main_347:
    lsl	w13,	w9,	#5
    asr	w1,	w9,	#31
    lsl	w19,	w22,	#2
    movz	fp,	#416
    lsr	w4,	w1,	#27
    mov	x8,	x19
    movk	fp,	#2,	lsl #16
    add	x8,	sp,	x8
    add	w6,	w9,	w4
    add	x8,	x8,	#16
    asr	w1,	w6,	#5
    ldr	w0,	[x8]

    lsl	w4,	w1,	#5
    ldr	w16,	[sp, fp]

    sub	w3,	w9,	w4
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w6,	w3,	w16
    ldr	w7,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w8,	w6,	w13
    ldr	w23,	[sp, fp]

    movz	fp,	#428
    add	w4,	w8,	w21
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    add	w8,	w4,	w12
    movz	fp,	#428
    asr	w12,	w23,	#31
    movk	fp,	#2,	lsl #16
    add	w15,	w8,	w0
    lsr	w19,	w12,	#2
    ldr	w5,	[sp, fp]

    lsl	w8,	w7,	#30
    add	w3,	w1,	w19
    add	w1,	w22,	#1
    asr	w4,	w3,	#30
    lsl	w6,	w4,	#30
    sub	w11,	w5,	w6
    add	w8,	w8,	w11
    cmp	w1,	#80
    blt	main_276

main_433:
    add	w2,	w15,	w2
    add	w9,	w9,	w28
    add	w19,	w8,	w14
    add	w22,	w18,	w20
    movz	fp,	#432
    add	w21,	w17,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w4,	w7,	w26
    cmp	w21,	w25
    blt	main_62

main_441:
    movz	fp,	#472
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#532
    str	w2,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#516
    str	w9,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#508
    str	w19,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#464
    str	w22,	[x21]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w4,	[x23]


main_442:
    cmp	w28,	#5
    bge	main_455

main_445:
    lsl	w16,	w28,	#2
    movz	fp,	#356
    lsl	w11,	w28,	#2
    mov	x22,	x16
    movk	fp,	#2,	lsl #16
    add	w28,	w28,	#1
    mov	x10,	x11
    add	x22,	sp,	x22
    add	x10,	sp,	x10
    add	x22,	x22,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x22]

    add	x10,	x10,	fp
    ldr	w15,	[x10]

    add	w5,	w15,	w16
    sub	w0,	w16,	w5
    add	w16,	w0,	w15
    sub	w20,	w16,	w5
    str	w20,	[x22]

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

    mov	w1,	w6
    b	main_28

main_62:
    mov	w28,	w9
    mov	w14,	w19
    mov	w20,	w22
    mov	w26,	w4
    mov	w17,	w21
    b	main_63

main_276:
    mov	w13,	w15
    movz	fp,	#428
    mov	w22,	w9
    mov	w12,	w18
    mov	w6,	w1
    movk	fp,	#2,	lsl #16
    mov	w9,	w8
    str	w13,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    mov	w24,	w10
    movk	fp,	#2,	lsl #16
    str	w6,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#444
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


