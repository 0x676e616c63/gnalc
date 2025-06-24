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
    movz	w24,	#0
    movz	w26,	#0
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
    movz	w4,	#0
    movz	fp,	#356
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#628
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#628
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

    movz	fp,	#620
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#556
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#392
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
    movz	fp,	#620
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w8,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w24,	w8,	#31
    lsr	w25,	w24,	#26
    add	w28,	w8,	w25
    asr	w1,	w28,	#6
    lsl	w2,	w1,	#6
    sub	w25,	w8,	w2
    cmp	w25,	#60
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
    lsl	w25,	w8,	#2
    movz	fp,	#436
    add	w22,	w8,	#1
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#436
    add	x24,	x28,	x25
    movk	fp,	#2,	lsl #16
    movz	w25,	#0
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    add	w1,	w8,	#3
    ldr	x0,	[sp, fp]

    add	w25,	w8,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    str	w23,	[x22]

    add	w23,	w8,	#4
    ldr	x1,	[sp, fp]

    movz	fp,	#564
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w28,	#0
    movz	w17,	#8961
    movz	w5,	#21622
    movz	w27,	#43913
    movz	w3,	#56574
    movz	w18,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w5,	#4146,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w18,	#50130,	lsl #16
    mov	w11,	w17
    mov	w2,	w5
    mov	w12,	w27
    mov	w20,	w3
    mov	w6,	w18

main_63:
    movz	w18,	#0
    mov	w24,	w28
    mov	w13,	w18

main_70:
    cmp	w13,	#14
    bge	main_215

main_74:
    lsl	w18,	w13,	#2
    lsl	w4,	w24,	#2
    movz	fp,	#436
    add	w14,	w24,	#2
    mov	x18,	x18
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    lsl	w7,	w14,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#436
    add	x3,	x0,	x4
    add	x18,	x18,	#16
    movk	fp,	#2,	lsl #16
    add	w0,	w24,	#1
    ldr	w5,	[x3]

    ldr	x10,	[sp, fp]

    lsl	w16,	w5,	#24
    lsl	w21,	w0,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	x1,	x10,	x21
    add	w10,	w13,	#1
    ldr	w4,	[x1]

    ldr	x25,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#436
    add	x22,	x25,	x7
    add	w8,	w5,	w16
    movk	fp,	#2,	lsl #16
    add	w16,	w24,	#4
    ldr	w1,	[x22]

    ldr	x0,	[sp, fp]

    lsl	w3,	w1,	#8
    add	w21,	w16,	#2
    add	w27,	w16,	#1
    movz	fp,	#436
    add	w3,	w8,	w3
    movk	fp,	#2,	lsl #16
    add	w8,	w24,	#3
    lsl	w15,	w8,	#2
    add	x9,	x0,	x15
    lsl	w0,	w16,	#2
    ldr	w17,	[x9]

    lsl	w9,	w10,	#2
    add	w7,	w3,	w17
    mov	x5,	x9
    lsl	w17,	w27,	#2
    add	x5,	sp,	x5
    str	w7,	[x18]

    ldr	x13,	[sp, fp]

    add	x5,	x5,	#16
    movz	fp,	#436
    add	x25,	x13,	x0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x25]

    lsl	w24,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x1,	x1,	x17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x1]

    ldr	x4,	[sp, fp]

    lsl	w8,	w7,	#16
    movz	fp,	#436
    add	w7,	w10,	#1
    add	w17,	w8,	w24
    movk	fp,	#2,	lsl #16
    lsl	w8,	w21,	#2
    add	x0,	x4,	x8
    add	w8,	w16,	#3
    ldr	w3,	[x0]

    lsl	w15,	w8,	#2
    ldr	x13,	[sp, fp]

    lsl	w4,	w3,	#8
    lsl	w8,	w7,	#2
    movz	fp,	#436
    add	x14,	x13,	x15
    add	w21,	w17,	w4
    movk	fp,	#2,	lsl #16
    add	w15,	w16,	#4
    ldr	w24,	[x14]

    add	w4,	w21,	w24
    add	w22,	w15,	#2
    lsl	w3,	w15,	#2
    str	w4,	[x5]

    ldr	x0,	[sp, fp]

    mov	x4,	x8
    movz	fp,	#436
    add	x1,	x0,	x3
    add	w8,	w15,	#1
    add	x4,	sp,	x4
    movk	fp,	#2,	lsl #16
    lsl	w0,	w22,	#2
    ldr	w5,	[x1]

    lsl	w14,	w8,	#2
    add	x4,	x4,	#16
    ldr	x18,	[sp, fp]

    lsl	w1,	w5,	#24
    movz	fp,	#436
    add	x9,	x18,	x14
    add	w5,	w15,	#3
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x9]

    ldr	x19,	[sp, fp]

    lsl	w16,	w14,	#16
    movz	fp,	#436
    add	x24,	x19,	x0
    add	w14,	w7,	#1
    add	w16,	w16,	w1
    movk	fp,	#2,	lsl #16
    lsl	w0,	w5,	#2
    ldr	w27,	[x24]

    ldr	x5,	[sp, fp]

    lsl	w1,	w27,	#8
    movz	fp,	#436
    add	x21,	x5,	x0
    add	w3,	w16,	w1
    movk	fp,	#2,	lsl #16
    lsl	w0,	w14,	#2
    ldr	w1,	[x21]

    mov	x7,	x0
    add	w21,	w15,	#4
    add	w8,	w3,	w1
    add	x7,	sp,	x7
    lsl	w0,	w21,	#2
    str	w8,	[x4]

    add	x7,	x7,	#16
    add	w8,	w21,	#1
    ldr	x9,	[sp, fp]

    movz	fp,	#436
    add	x25,	x9,	x0
    lsl	w13,	w8,	#2
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x25]

    add	w25,	w21,	#3
    ldr	x4,	[sp, fp]

    lsl	w1,	w1,	#24
    movz	fp,	#436
    add	x9,	x4,	x13
    movk	fp,	#2,	lsl #16
    add	w4,	w21,	#2
    ldr	w16,	[x9]

    lsl	w8,	w4,	#2
    ldr	x15,	[sp, fp]

    lsl	w18,	w16,	#16
    movz	fp,	#436
    add	x5,	x15,	x8
    movk	fp,	#2,	lsl #16
    add	w0,	w18,	w1
    add	w8,	w21,	#4
    lsl	w1,	w25,	#2
    ldr	w13,	[x5]

    add	w10,	w8,	#1
    add	w5,	w14,	#1
    ldr	x15,	[sp, fp]

    lsl	w16,	w13,	#8
    movz	fp,	#436
    add	x27,	x15,	x1
    lsl	w13,	w10,	#2
    add	w3,	w0,	w16
    movk	fp,	#2,	lsl #16
    lsl	w1,	w5,	#2
    ldr	w4,	[x27]

    mov	x18,	x1
    add	w27,	w8,	#2
    add	w4,	w3,	w4
    lsl	w1,	w8,	#2
    add	x18,	sp,	x18
    str	w4,	[x7]

    add	x18,	x18,	#16
    ldr	x21,	[sp, fp]

    movz	fp,	#436
    add	x0,	x21,	x1
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x0]

    lsl	w0,	w27,	#2
    ldr	x17,	[sp, fp]

    lsl	w4,	w3,	#24
    add	w27,	w5,	#1
    movz	fp,	#436
    add	x14,	x17,	x13
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x14]

    lsl	w14,	w27,	#2
    ldr	x15,	[sp, fp]

    lsl	w22,	w16,	#16
    mov	x13,	x14
    movz	fp,	#436
    add	x1,	x15,	x0
    add	w22,	w22,	w4
    add	x13,	sp,	x13
    movk	fp,	#2,	lsl #16
    add	w0,	w8,	#3
    ldr	w7,	[x1]

    add	x13,	x13,	#16
    ldr	x25,	[sp, fp]

    lsl	w3,	w0,	#2
    lsl	w15,	w7,	#8
    movz	fp,	#436
    add	x1,	x25,	x3
    add	w10,	w22,	w15
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x1]

    add	w1,	w8,	#4
    add	w4,	w10,	w4
    add	w8,	w1,	#2
    lsl	w22,	w1,	#2
    add	w10,	w1,	#1
    str	w4,	[x18]

    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x18,	x5,	x22
    lsl	w7,	w10,	#2
    movk	fp,	#2,	lsl #16
    lsl	w5,	w8,	#2
    add	w10,	w1,	#4
    ldr	w24,	[x18]

    ldr	x25,	[sp, fp]

    lsl	w4,	w24,	#24
    movz	fp,	#436
    add	x16,	x25,	x7
    add	w24,	w1,	#3
    movk	fp,	#2,	lsl #16
    lsl	w1,	w10,	#2
    ldr	w0,	[x16]

    ldr	x9,	[sp, fp]

    lsl	w3,	w0,	#16
    movz	fp,	#436
    add	x9,	x9,	x5
    add	w4,	w3,	w4
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x9]

    ldr	x9,	[sp, fp]

    lsl	w21,	w16,	#8
    movz	fp,	#436
    add	w21,	w4,	w21
    movk	fp,	#2,	lsl #16
    lsl	w4,	w24,	#2
    add	w24,	w10,	#4
    add	x3,	x9,	x4
    ldr	w8,	[x3]

    add	w0,	w21,	w8
    add	w8,	w10,	#3
    str	w0,	[x13]

    add	w13,	w10,	#2
    ldr	x16,	[sp, fp]

    add	w0,	w27,	#1
    movz	fp,	#436
    add	x17,	x16,	x1
    movk	fp,	#2,	lsl #16
    lsl	w7,	w0,	#2
    ldr	w3,	[x17]

    mov	x4,	x7
    add	w17,	w10,	#1
    lsl	w16,	w3,	#24
    add	x4,	sp,	x4
    lsl	w14,	w17,	#2
    add	x4,	x4,	#16
    ldr	x17,	[sp, fp]

    movz	fp,	#436
    add	x22,	x17,	x14
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x22]

    ldr	x17,	[sp, fp]

    lsl	w27,	w25,	#16
    movz	fp,	#436
    lsl	w25,	w13,	#2
    add	w5,	w27,	w16
    movk	fp,	#2,	lsl #16
    lsl	w13,	w8,	#2
    add	x14,	x17,	x25
    ldr	w21,	[x14]

    ldr	x19,	[sp, fp]

    lsl	w1,	w21,	#8
    add	x9,	x19,	x13
    add	w3,	w5,	w1
    add	w1,	w0,	#1
    ldr	w15,	[x9]

    mov	w13,	w1
    add	w7,	w3,	w15
    str	w7,	[x4]

    b	main_70

main_215:
    mov	w21,	w24
    mov	w3,	w13

main_217:
    lsl	w7,	w3,	#2
    lsl	w14,	w21,	#2
    movz	fp,	#436
    add	w27,	w3,	#1
    mov	x5,	x7
    movk	fp,	#2,	lsl #16
    add	x5,	sp,	x5
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x15,	x4,	x14
    add	x5,	x5,	#16
    movk	fp,	#2,	lsl #16
    add	w4,	w21,	#1
    ldr	w22,	[x15]

    lsl	w25,	w22,	#24
    lsl	w0,	w4,	#2
    add	w22,	w21,	#4
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x8,	x4,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	#2
    ldr	w10,	[x8]

    lsl	w16,	w0,	#2
    ldr	x4,	[sp, fp]

    lsl	w15,	w10,	#16
    movz	fp,	#436
    add	x1,	x4,	x16
    movk	fp,	#2,	lsl #16
    add	w15,	w15,	w25
    add	w4,	w21,	#3
    ldr	w8,	[x1]

    lsl	w24,	w4,	#2
    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w10,	w15,	w9
    add	x8,	x8,	x24
    ldr	w16,	[x8]

    add	w24,	w10,	w16
    str	w24,	[x5]

    cmp	w27,	#16
    bge	main_241

main_216:
    mov	w21,	w22
    mov	w3,	w27
    b	main_217

main_241:
    mov	w15,	w27
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#548
    lsl	w24,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x24
    add	x18,	sp,	x18
    ldr	w25,	[sp, fp]

    movz	fp,	#548
    sub	w27,	w25,	#3
    add	x18,	x18,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w27,	#2
    mov	x1,	x3
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w4,	[x1]

    ldr	w3,	[sp, fp]

    movz	fp,	#548
    sub	w5,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w5,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w10,	[x7]

    add	w7,	w10,	w4
    sub	w14,	w4,	w7
    ldr	w4,	[sp, fp]

    movz	fp,	#548
    sub	w24,	w4,	#14
    add	w21,	w14,	w10
    movk	fp,	#2,	lsl #16
    lsl	w0,	w24,	#2
    sub	w7,	w21,	w7
    mov	x27,	x0
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    ldr	w3,	[x27]

    ldr	w5,	[sp, fp]

    add	w0,	w3,	w7
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    sub	w4,	w7,	w0
    add	w10,	w4,	w3
    sub	w25,	w10,	w0
    sub	w0,	w5,	#16
    lsl	w3,	w0,	#2
    mov	x1,	x3
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w4,	[x1]

    add	w3,	w4,	w25
    sub	w9,	w25,	w3
    add	w13,	w9,	w4
    sub	w15,	w13,	w3
    asr	w0,	w15,	#31
    lsl	w9,	w15,	#1
    lsr	w1,	w0,	#31
    add	w3,	w15,	w1
    asr	w13,	w3,	#1
    lsl	w16,	w13,	#1
    sub	w4,	w15,	w16
    add	w5,	w9,	w4
    str	w5,	[x18]

    ldr	w17,	[sp, fp]

    movz	fp,	#548
    add	w7,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w7
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w11
    movz	fp,	#428
    mov	w1,	w12
    mov	w19,	w20
    mov	w9,	w2
    mov	w3,	w6
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w4
    str	w25,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_277:
    movz	w1,	#48348
    movz	w10,	#60289
    movz	w27,	#31129
    movz	w24,	#65535
    movz	fp,	#412
    movk	w1,	#36635,	lsl #16
    movk	w10,	#28377,	lsl #16
    movk	w27,	#23170,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w21,	w1
    mov	w9,	w10
    mov	w16,	w27
    mov	w17,	w24
    ldr	w15,	[sp, fp]

    movz	w1,	#49414
    movk	w1,	#51810,	lsl #16
    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w0,	w17
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#424
    add	w7,	w25,	w18
    movk	fp,	#2,	lsl #16
    mov	w25,	w16
    ldr	w13,	[sp, fp]

    movz	fp,	#416
    sub	w0,	w0,	w13
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w10,	w19,	w0
    add	w14,	w10,	w7
    sub	w18,	w7,	w14
    add	w27,	w18,	w10
    sub	w10,	w27,	w14
    sub	w0,	w10,	w27
    add	w7,	w0,	w14
    sub	w10,	w7,	w27
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    cmp	w18,	#40
    bge	main_307

main_298:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#424
    add	w10,	w27,	w22
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w14,	w19,	w10
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#416
    add	w25,	w14,	w7
    movk	fp,	#2,	lsl #16
    sub	w25,	w25,	w10
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w0,	w5,	w25
    ldr	w26,	[sp, fp]

    sub	w4,	w25,	w0
    mov	w25,	w9
    add	w4,	w4,	w26
    sub	w10,	w4,	w0
    mov	w14,	w10
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    cmp	w24,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#416
    add	w27,	w13,	w5
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    add	w7,	w8,	w19
    movk	fp,	#2,	lsl #16
    add	w25,	w7,	w27
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w14,	w27,	w25
    ldr	w19,	[sp, fp]

    add	w27,	w14,	w7
    add	w14,	w18,	w19
    sub	w0,	w27,	w25
    sub	w7,	w0,	w27
    add	w10,	w7,	w25
    mov	w25,	w21
    sub	w10,	w10,	w27
    add	w18,	w14,	w10
    sub	w27,	w10,	w18
    add	w7,	w27,	w14
    sub	w0,	w7,	w18
    sub	w0,	w0,	w7
    add	w10,	w0,	w18
    sub	w10,	w10,	w7
    mov	w14,	w10
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w0,	w19,	w8
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#432
    sub	w7,	w13,	w0
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    add	w25,	w7,	w22
    movk	fp,	#2,	lsl #16
    sub	w14,	w25,	w0
    ldr	w18,	[sp, fp]

    mov	w25,	w1
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w0,	w18,	w14
    ldr	w10,	[sp, fp]

    sub	w14,	w14,	w0
    add	w7,	w14,	w10
    sub	w10,	w7,	w0
    mov	w14,	w10

main_413:
    mov	w10,	w14

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    lsl	w7,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#428
    asr	w14,	w14,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w14,	#27
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w14,	w18,	w24
    movk	fp,	#2,	lsl #16
    asr	w14,	w14,	#5
    ldr	w26,	[sp, fp]

    movz	fp,	#412
    lsl	w18,	w14,	#5
    movk	fp,	#2,	lsl #16
    sub	w14,	w26,	w18
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    lsl	w0,	w19,	#2
    movk	fp,	#2,	lsl #16
    add	w27,	w7,	w14
    mov	x14,	x0
    add	x14,	sp,	x14
    add	w27,	w27,	w3
    add	x14,	x14,	#16
    ldr	w7,	[x14]

    ldr	w18,	[sp, fp]

    add	w14,	w27,	w10
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w10,	w14,	w25
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    asr	w3,	w19,	#31
    add	w14,	w10,	w7
    movk	fp,	#2,	lsl #16
    lsl	w7,	w18,	#30
    ldr	w15,	[sp, fp]

    lsr	w18,	w3,	#2
    movz	fp,	#424
    add	w24,	w15,	w18
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    asr	w4,	w24,	#30
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    lsl	w3,	w4,	#30
    sub	w18,	w19,	w3
    ldr	w19,	[sp, fp]

    add	w25,	w19,	#1
    add	w10,	w7,	w18
    cmp	w25,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w27,	w17
    mov	w3,	w16
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w9,	w10,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w27,	w1
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w1,	w15,	w0
    add	w4,	w1,	w9
    sub	w15,	w9,	w4
    add	w9,	w15,	w1
    sub	w15,	w9,	w4
    sub	w18,	w15,	w9
    add	w27,	w18,	w4
    sub	w21,	w27,	w9
    mov	w24,	w21
    b	main_347

main_364:
    cmp	w25,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    mov	w16,	w9
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#428
    add	w17,	w10,	w21
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w4,	w17
    movk	fp,	#2,	lsl #16
    add	w0,	w4,	w10
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w17
    ldr	w24,	[sp, fp]

    add	w1,	w19,	w0
    sub	w4,	w0,	w1
    add	w15,	w4,	w24
    sub	w17,	w15,	w1
    b	main_375

main_378:
    cmp	w25,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w22,	w10,	w22
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    add	w16,	w3,	w7
    movk	fp,	#2,	lsl #16
    add	w0,	w16,	w22
    ldr	w24,	[sp, fp]

    add	w9,	w24,	w10
    sub	w1,	w22,	w0
    add	w4,	w1,	w16
    sub	w17,	w4,	w0
    sub	w1,	w17,	w4
    add	w0,	w1,	w0
    sub	w3,	w0,	w4
    add	w0,	w9,	w3
    sub	w7,	w3,	w0
    add	w9,	w7,	w9
    sub	w16,	w9,	w0
    sub	w27,	w16,	w9
    add	w1,	w27,	w0
    sub	w16,	w1,	w9
    mov	w1,	w21
    mov	w18,	w16
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    add	w17,	w10,	w4
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w21,	w17
    movk	fp,	#2,	lsl #16
    add	w7,	w4,	w10
    ldr	w0,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w3,	w7,	w17
    ldr	w13,	[sp, fp]

    add	w17,	w0,	w3
    sub	w7,	w3,	w17
    add	w3,	w7,	w13
    sub	w17,	w3,	w17
    mov	w18,	w17

main_398:
    mov	w17,	w18
    mov	w16,	w1

main_375:
    mov	w24,	w17
    mov	w3,	w16

main_347:
    lsl	w16,	w14,	#5
    asr	w1,	w14,	#31
    lsl	w21,	w25,	#2
    movz	fp,	#416
    lsr	w4,	w1,	#27
    mov	x17,	x21
    movk	fp,	#2,	lsl #16
    add	x17,	sp,	x17
    add	w7,	w14,	w4
    add	x17,	x17,	#16
    asr	w7,	w7,	#5
    ldr	w0,	[x17]

    lsl	w9,	w7,	#5
    ldr	w22,	[sp, fp]

    sub	w9,	w14,	w9
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w7,	w9,	w22
    ldr	w8,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w9,	w7,	w16
    ldr	w26,	[sp, fp]

    movz	fp,	#428
    asr	w16,	w26,	#31
    add	w4,	w9,	w24
    movk	fp,	#2,	lsl #16
    lsr	w21,	w16,	#2
    add	w24,	w25,	#1
    ldr	w1,	[sp, fp]

    add	w7,	w4,	w3
    movz	fp,	#428
    add	w1,	w1,	w21
    movk	fp,	#2,	lsl #16
    add	w22,	w7,	w0
    ldr	w5,	[sp, fp]

    asr	w3,	w1,	#30
    lsl	w7,	w8,	#30
    lsl	w4,	w3,	#30
    sub	w15,	w5,	w4
    add	w17,	w7,	w15
    cmp	w24,	#80
    blt	main_276

main_433:
    add	w18,	w22,	w11
    add	w21,	w14,	w12
    add	w0,	w17,	w20
    add	w15,	w10,	w2
    movz	fp,	#432
    add	w3,	w28,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w9,	w7,	w6
    cmp	w3,	w23
    blt	main_62

main_441:
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#556
    str	w18,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#452
    str	w21,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#444
    str	w0,	[x14]

    movk	fp,	#2,	lsl #16
    movz	w0,	#0
    ldr	x22,	[sp, fp]

    movz	fp,	#508
    str	w15,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w9,	[x23]


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
    sub	w22,	w17,	w6
    str	w22,	[x24]

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

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w18
    mov	w12,	w21
    mov	w20,	w0
    mov	w2,	w15
    mov	w6,	w9
    mov	w28,	w3
    b	main_63

main_276:
    mov	w19,	w22
    movz	fp,	#428
    mov	w5,	w14
    mov	w13,	w10
    mov	w8,	w24
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    mov	w13,	w17
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#412
    mov	w3,	w9
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#628
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


