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
    movz	w5,	#0
    movz	w6,	#0
    movz	fp,	#356
    movz	w2,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#488
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
    movz	fp,	#460
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
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#480
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#384
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w1
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#444
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#444
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#444
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
    movz	fp,	#480
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
    movz	fp,	#460
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
    movz	fp,	#460
    add	w21,	w16,	#1
    movz	w25,	#0
    movz	w22,	#125
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#460
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w21,	#2
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#460
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    ldr	x0,	[sp, fp]

    add	w1,	w16,	#3
    add	w25,	w16,	#2
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x21,	x0,	x2
    movz	w2,	#0
    str	w22,	[x21]

    ldr	x1,	[sp, fp]

    movz	fp,	#428
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    add	w25,	w16,	#4
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w28,	#0
    movz	w17,	#8961
    movz	w22,	#43913
    movz	w5,	#56574
    movz	w6,	#21622
    movk	w17,	#26437,	lsl #16
    movk	w22,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    mov	w27,	w17
    mov	w3,	w22
    mov	w19,	w5
    mov	w13,	w6
    movz	w17,	#57840
    movk	w17,	#50130,	lsl #16
    mov	w15,	w17

main_63:
    movz	w16,	#0
    mov	w20,	w28
    mov	w10,	w16

main_70:
    cmp	w10,	#14
    bge	main_215

main_74:
    lsl	w14,	w10,	#2
    lsl	w5,	w20,	#2
    movz	fp,	#460
    add	w11,	w20,	#2
    add	w7,	w20,	#3
    add	w10,	w10,	#1
    mov	x14,	x14
    movk	fp,	#2,	lsl #16
    add	x14,	sp,	x14
    ldr	x0,	[sp, fp]

    movz	fp,	#460
    add	x2,	x0,	x5
    add	x14,	x14,	#16
    movk	fp,	#2,	lsl #16
    add	w0,	w20,	#1
    ldr	w6,	[x2]

    ldr	x9,	[sp, fp]

    lsl	w18,	w6,	#24
    lsl	w16,	w0,	#2
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    add	x1,	x9,	x16
    lsl	w9,	w10,	#2
    lsl	w16,	w7,	#2
    ldr	w5,	[x1]

    ldr	x22,	[sp, fp]

    lsl	w6,	w5,	#16
    movz	fp,	#460
    mov	x5,	x9
    add	w8,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	x5,	sp,	x5
    lsl	w6,	w11,	#2
    add	w11,	w20,	#4
    add	x17,	x22,	x6
    add	x5,	x5,	#16
    add	w20,	w11,	#2
    add	w22,	w11,	#1
    ldr	w1,	[x17]

    ldr	x0,	[sp, fp]

    lsl	w2,	w1,	#8
    lsl	w17,	w22,	#2
    movz	fp,	#460
    add	w2,	w8,	w2
    movk	fp,	#2,	lsl #16
    add	x8,	x0,	x16
    lsl	w0,	w11,	#2
    ldr	w18,	[x8]

    lsl	w8,	w20,	#2
    add	w7,	w2,	w18
    str	w7,	[x14]

    add	w14,	w11,	#4
    ldr	x9,	[sp, fp]

    movz	fp,	#460
    add	x21,	x9,	x0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x21]

    lsl	w18,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#460
    add	x1,	x1,	x17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x1]

    ldr	x4,	[sp, fp]

    lsl	w7,	w6,	#16
    movz	fp,	#460
    add	x0,	x4,	x8
    add	w17,	w7,	w18
    movk	fp,	#2,	lsl #16
    add	w8,	w11,	#3
    ldr	w2,	[x0]

    ldr	x9,	[sp, fp]

    lsl	w6,	w2,	#8
    lsl	w16,	w8,	#2
    movz	fp,	#460
    lsl	w2,	w14,	#2
    add	w17,	w17,	w6
    add	x9,	x9,	x16
    movk	fp,	#2,	lsl #16
    add	w6,	w10,	#1
    add	w16,	w14,	#4
    ldr	w18,	[x9]

    lsl	w8,	w6,	#2
    add	w4,	w17,	w18
    add	w17,	w14,	#2
    str	w4,	[x5]

    add	w5,	w14,	#3
    ldr	x0,	[sp, fp]

    mov	x4,	x8
    movz	fp,	#460
    add	x1,	x0,	x2
    add	w8,	w14,	#1
    add	x4,	sp,	x4
    movk	fp,	#2,	lsl #16
    lsl	w0,	w17,	#2
    ldr	w7,	[x1]

    lsl	w11,	w8,	#2
    add	x4,	x4,	#16
    ldr	x18,	[sp, fp]

    lsl	w1,	w7,	#24
    movz	fp,	#460
    add	x9,	x18,	x11
    movk	fp,	#2,	lsl #16
    ldr	w11,	[x9]

    ldr	x20,	[sp, fp]

    lsl	w12,	w11,	#16
    movz	fp,	#460
    add	x18,	x20,	x0
    add	w11,	w6,	#1
    add	w12,	w12,	w1
    movk	fp,	#2,	lsl #16
    lsl	w0,	w5,	#2
    ldr	w22,	[x18]

    add	w6,	w16,	#1
    ldr	x5,	[sp, fp]

    lsl	w1,	w22,	#8
    movz	fp,	#460
    add	x20,	x5,	x0
    add	w2,	w12,	w1
    movk	fp,	#2,	lsl #16
    add	w5,	w11,	#1
    lsl	w0,	w11,	#2
    lsl	w12,	w6,	#2
    ldr	w1,	[x20]

    mov	x7,	x0
    add	w8,	w2,	w1
    lsl	w0,	w16,	#2
    add	x7,	sp,	x7
    str	w8,	[x4]

    add	x7,	x7,	#16
    ldr	x9,	[sp, fp]

    movz	fp,	#460
    add	x21,	x9,	x0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x21]

    add	w21,	w16,	#3
    ldr	x4,	[sp, fp]

    lsl	w1,	w1,	#24
    movz	fp,	#460
    add	x8,	x4,	x12
    movk	fp,	#2,	lsl #16
    add	w4,	w16,	#2
    ldr	w17,	[x8]

    ldr	x12,	[sp, fp]

    lsl	w8,	w4,	#2
    lsl	w20,	w17,	#16
    movz	fp,	#460
    add	x6,	x12,	x8
    movk	fp,	#2,	lsl #16
    add	w0,	w20,	w1
    add	w8,	w5,	#1
    lsl	w1,	w21,	#2
    ldr	w10,	[x6]

    ldr	x12,	[sp, fp]

    lsl	w14,	w10,	#8
    movz	fp,	#460
    add	x22,	x12,	x1
    add	w2,	w0,	w14
    movk	fp,	#2,	lsl #16
    lsl	w1,	w5,	#2
    ldr	w4,	[x22]

    mov	x14,	x1
    add	w4,	w2,	w4
    add	x14,	sp,	x14
    str	w4,	[x7]

    add	x14,	x14,	#16
    ldr	x17,	[sp, fp]

    add	w7,	w16,	#4
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    add	w22,	w7,	#2
    add	w10,	w7,	#1
    lsl	w1,	w7,	#2
    lsl	w10,	w10,	#2
    add	x0,	x17,	x1
    ldr	w2,	[x0]

    lsl	w0,	w22,	#2
    ldr	x17,	[sp, fp]

    lsl	w6,	w2,	#24
    movz	fp,	#460
    add	x11,	x17,	x10
    movk	fp,	#2,	lsl #16
    add	w10,	w7,	#4
    ldr	w16,	[x11]

    lsl	w20,	w10,	#2
    add	w11,	w10,	#1
    ldr	x12,	[sp, fp]

    lsl	w17,	w16,	#16
    movz	fp,	#460
    add	x1,	x12,	x0
    add	w17,	w17,	w6
    movk	fp,	#2,	lsl #16
    add	w0,	w7,	#3
    ldr	w6,	[x1]

    lsl	w7,	w11,	#2
    ldr	x22,	[sp, fp]

    lsl	w16,	w6,	#8
    lsl	w2,	w0,	#2
    add	w11,	w10,	#2
    movz	fp,	#460
    add	w9,	w17,	w16
    add	x1,	x22,	x2
    movk	fp,	#2,	lsl #16
    lsl	w16,	w8,	#2
    add	w8,	w8,	#1
    mov	x2,	x16
    ldr	w6,	[x1]

    add	x2,	sp,	x2
    add	w6,	w9,	w6
    add	x2,	x2,	#16
    str	w6,	[x14]

    lsl	w6,	w11,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#460
    add	x17,	x4,	x20
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x17]

    ldr	x23,	[sp, fp]

    lsl	w4,	w21,	#24
    movz	fp,	#460
    add	x17,	x23,	x7
    add	w21,	w10,	#3
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x17]

    ldr	x7,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#460
    add	x14,	x7,	x6
    add	w4,	w1,	w4
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    ldr	x9,	[sp, fp]

    lsl	w18,	w17,	#8
    movz	fp,	#460
    add	w17,	w4,	w18
    movk	fp,	#2,	lsl #16
    lsl	w4,	w21,	#2
    add	x1,	x9,	x4
    ldr	w6,	[x1]

    add	w1,	w10,	#4
    add	w0,	w17,	w6
    lsl	w6,	w8,	#2
    mov	x5,	x6
    str	w0,	[x2]

    add	w10,	w1,	#2
    add	x5,	sp,	x5
    ldr	x16,	[sp, fp]

    lsl	w0,	w1,	#2
    movz	fp,	#460
    lsl	w18,	w10,	#2
    movk	fp,	#2,	lsl #16
    add	x5,	x5,	#16
    add	x17,	x16,	x0
    add	w16,	w1,	#1
    ldr	w4,	[x17]

    lsl	w9,	w16,	#2
    ldr	x17,	[sp, fp]

    lsl	w14,	w4,	#24
    movz	fp,	#460
    add	x17,	x17,	x9
    movk	fp,	#2,	lsl #16
    add	w9,	w1,	#3
    ldr	w21,	[x17]

    ldr	x17,	[sp, fp]

    lsl	w22,	w21,	#16
    movz	fp,	#460
    add	x11,	x17,	x18
    add	w2,	w22,	w14
    movk	fp,	#2,	lsl #16
    ldr	w20,	[x11]

    lsl	w11,	w9,	#2
    lsl	w0,	w20,	#8
    ldr	x20,	[sp, fp]

    add	w2,	w2,	w0
    add	x10,	x20,	x11
    add	w20,	w1,	#4
    ldr	w12,	[x10]

    add	w7,	w2,	w12
    add	w2,	w8,	#1
    mov	w10,	w2
    str	w7,	[x5]

    b	main_70

main_215:
    mov	w17,	w20
    mov	w2,	w10

main_217:
    lsl	w7,	w2,	#2
    lsl	w11,	w17,	#2
    movz	fp,	#460
    add	w24,	w2,	#1
    mov	x6,	x7
    movk	fp,	#2,	lsl #16
    add	x6,	sp,	x6
    ldr	x4,	[sp, fp]

    movz	fp,	#460
    add	x12,	x4,	x11
    add	x6,	x6,	#16
    movk	fp,	#2,	lsl #16
    add	w4,	w17,	#1
    ldr	w16,	[x12]

    lsl	w21,	w16,	#24
    lsl	w0,	w4,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#460
    add	x7,	x4,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w17,	#2
    ldr	w9,	[x7]

    lsl	w16,	w0,	#2
    ldr	x4,	[sp, fp]

    lsl	w14,	w9,	#16
    movz	fp,	#460
    add	x1,	x4,	x16
    movk	fp,	#2,	lsl #16
    add	w14,	w14,	w21
    add	w4,	w17,	#3
    ldr	w8,	[x1]

    lsl	w18,	w4,	#2
    lsl	w9,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w9,	w14,	w9
    add	x7,	x8,	x18
    add	w18,	w17,	#4
    ldr	w16,	[x7]

    add	w20,	w9,	w16
    str	w20,	[x6]

    cmp	w24,	#16
    bge	main_241

main_216:
    mov	w17,	w18
    mov	w2,	w24
    b	main_217

main_241:
    mov	w12,	w24
    movz	fp,	#544
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]


main_242:
    movz	fp,	#544
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#544
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#544
    lsl	w21,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x16,	x21
    add	x16,	sp,	x16
    ldr	w23,	[sp, fp]

    movz	fp,	#544
    sub	w24,	w23,	#3
    add	x16,	x16,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w24,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w4,	[x1]

    ldr	w2,	[sp, fp]

    movz	fp,	#544
    sub	w6,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w6,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w9,	[x7]

    add	w7,	w9,	w4
    sub	w11,	w4,	w7
    ldr	w4,	[sp, fp]

    movz	fp,	#544
    sub	w20,	w4,	#14
    add	w14,	w11,	w9
    movk	fp,	#2,	lsl #16
    lsl	w0,	w20,	#2
    sub	w7,	w14,	w7
    mov	x24,	x0
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w2,	[x24]

    ldr	w5,	[sp, fp]

    add	w0,	w2,	w7
    movz	fp,	#544
    movk	fp,	#2,	lsl #16
    sub	w4,	w7,	w0
    add	w10,	w4,	w2
    sub	w22,	w10,	w0
    sub	w0,	w5,	#16
    lsl	w2,	w0,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w5,	[x1]

    add	w2,	w5,	w22
    sub	w9,	w22,	w2
    add	w10,	w9,	w5
    sub	w14,	w10,	w2
    asr	w0,	w14,	#31
    lsl	w9,	w14,	#1
    lsr	w1,	w0,	#31
    add	w2,	w14,	w1
    asr	w10,	w2,	#1
    lsl	w11,	w10,	#1
    sub	w5,	w14,	w11
    add	w6,	w9,	w5
    str	w6,	[x16]

    ldr	w16,	[sp, fp]

    movz	fp,	#544
    add	w7,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w26,	w27
    movz	fp,	#452
    mov	w1,	w3
    mov	w17,	w19
    mov	w9,	w13
    mov	w24,	w15
    movz	w2,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w2
    str	w26,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w17,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_277:
    movz	w1,	#48348
    movz	w11,	#60289
    movz	w2,	#49414
    movz	w22,	#31129
    movz	w20,	#65535
    movz	fp,	#436
    movk	w1,	#36635,	lsl #16
    movk	w11,	#28377,	lsl #16
    movk	w2,	#51810,	lsl #16
    movk	w22,	#23170,	lsl #16
    movk	w20,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w17,	w1
    mov	w9,	w11
    mov	w14,	w22
    mov	w16,	w20
    mov	w1,	w2
    ldr	w11,	[sp, fp]

    cmp	w11,	#20
    bge	main_296

main_285:
    movz	fp,	#448
    mov	w2,	w16
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#448
    add	w6,	w20,	w18
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w2,	w10
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    add	w12,	w18,	w7
    add	w20,	w12,	w6
    sub	w7,	w6,	w20
    add	w22,	w7,	w12
    sub	w11,	w22,	w20
    sub	w6,	w11,	w22
    add	w11,	w6,	w20
    sub	w6,	w11,	w22
    mov	w4,	w6
    mov	w6,	w14
    b	main_416

main_296:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    cmp	w12,	#40
    bge	main_307

main_298:
    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#448
    add	w4,	w23,	w21
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#456
    sub	w11,	w18,	w4
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#440
    add	w20,	w11,	w6
    movk	fp,	#2,	lsl #16
    sub	w7,	w20,	w4
    ldr	w4,	[sp, fp]

    movz	fp,	#440
    add	w2,	w4,	w7
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w7,	w7,	w2
    add	w7,	w7,	w26
    sub	w6,	w7,	w2
    mov	w12,	w6
    mov	w6,	w9
    b	main_413

main_307:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    cmp	w18,	#60
    bge	main_327

main_309:
    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    add	w22,	w8,	w4
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#440
    add	w12,	w7,	w18
    movk	fp,	#2,	lsl #16
    add	w21,	w12,	w22
    sub	w11,	w22,	w21
    add	w2,	w11,	w12
    ldr	w12,	[sp, fp]

    movz	fp,	#456
    sub	w6,	w2,	w21
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    sub	w11,	w6,	w2
    add	w20,	w11,	w21
    add	w21,	w12,	w18
    sub	w4,	w20,	w2
    add	w12,	w21,	w4
    sub	w22,	w4,	w12
    add	w11,	w22,	w21
    sub	w4,	w11,	w12
    sub	w6,	w4,	w11
    add	w12,	w6,	w12
    sub	w6,	w12,	w11
    mov	w12,	w6
    mov	w6,	w17
    b	main_413

main_327:
    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#448
    add	w2,	w18,	w7
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#456
    sub	w11,	w8,	w2
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    add	w21,	w11,	w21
    movk	fp,	#2,	lsl #16
    sub	w11,	w21,	w2
    ldr	w12,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    add	w6,	w12,	w11
    ldr	w8,	[sp, fp]

    sub	w12,	w11,	w6
    add	w4,	w12,	w8
    sub	w6,	w4,	w6
    mov	w12,	w6
    mov	w6,	w1

main_413:
    mov	w4,	w12

main_416:
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#452
    lsl	w11,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#452
    asr	w21,	w10,	#31
    movk	fp,	#2,	lsl #16
    lsr	w22,	w21,	#27
    ldr	w18,	[sp, fp]

    movz	fp,	#452
    add	w7,	w18,	w22
    movk	fp,	#2,	lsl #16
    asr	w21,	w7,	#5
    ldr	w23,	[sp, fp]

    movz	fp,	#436
    lsl	w22,	w21,	#5
    movk	fp,	#2,	lsl #16
    sub	w7,	w23,	w22
    ldr	w20,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    add	w22,	w11,	w7
    lsl	w11,	w20,	#2
    mov	x20,	x11
    add	w21,	w22,	w24
    add	x20,	sp,	x20
    add	w7,	w21,	w4
    add	x20,	x20,	#16
    add	w12,	w7,	w6
    ldr	w20,	[x20]

    ldr	w18,	[sp, fp]

    movz	fp,	#448
    lsl	w2,	w18,	#30
    add	w11,	w12,	w20
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#448
    asr	w21,	w20,	#31
    movk	fp,	#2,	lsl #16
    lsr	w20,	w21,	#2
    ldr	w12,	[sp, fp]

    movz	fp,	#448
    add	w12,	w12,	w20
    movk	fp,	#2,	lsl #16
    asr	w20,	w12,	#30
    lsl	w22,	w20,	#30
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    sub	w7,	w20,	w22
    movk	fp,	#2,	lsl #16
    add	w12,	w2,	w7
    ldr	w20,	[sp, fp]

    add	w22,	w20,	#1
    cmp	w22,	#20
    bge	main_364

main_336:
    movz	fp,	#452
    mov	w2,	w16
    mov	w7,	w14
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#452
    add	w17,	w12,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#456
    sub	w0,	w2,	w1
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    add	w1,	w9,	w0
    add	w2,	w1,	w17
    sub	w16,	w17,	w2
    add	w9,	w16,	w1
    sub	w16,	w9,	w2
    sub	w17,	w16,	w9
    add	w20,	w17,	w2
    sub	w18,	w20,	w9
    mov	w21,	w18
    b	main_347

main_364:
    cmp	w22,	#40
    bge	main_378

main_366:
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#452
    add	w16,	w12,	w17
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#456
    sub	w6,	w5,	w16
    movk	fp,	#2,	lsl #16
    add	w0,	w6,	w12
    sub	w0,	w0,	w16
    ldr	w16,	[sp, fp]

    movz	fp,	#456
    add	w2,	w16,	w0
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    sub	w4,	w0,	w2
    mov	w0,	w9
    add	w14,	w4,	w21
    sub	w16,	w14,	w2
    b	main_375

main_378:
    cmp	w22,	#60
    bge	main_401

main_380:
    movz	fp,	#452
    mov	w1,	w17
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#452
    add	w18,	w12,	w20
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#456
    add	w16,	w2,	w7
    movk	fp,	#2,	lsl #16
    add	w7,	w16,	w18
    ldr	w21,	[sp, fp]

    add	w9,	w21,	w12
    sub	w0,	w18,	w7
    add	w4,	w0,	w16
    sub	w16,	w4,	w7
    sub	w2,	w16,	w4
    add	w0,	w2,	w7
    sub	w2,	w0,	w4
    add	w0,	w9,	w2
    sub	w7,	w2,	w0
    add	w9,	w7,	w9
    sub	w14,	w9,	w0
    sub	w20,	w14,	w9
    add	w24,	w20,	w0
    sub	w14,	w24,	w9
    mov	w18,	w14
    b	main_398

main_401:
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#452
    add	w16,	w12,	w4
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#456
    sub	w4,	w17,	w16
    movk	fp,	#2,	lsl #16
    add	w7,	w4,	w12
    ldr	w0,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    sub	w2,	w7,	w16
    ldr	w9,	[sp, fp]

    add	w16,	w0,	w2
    sub	w7,	w2,	w16
    add	w24,	w7,	w9
    sub	w16,	w24,	w16
    mov	w18,	w16

main_398:
    mov	w16,	w18
    mov	w0,	w1

main_375:
    mov	w21,	w16
    mov	w7,	w0

main_347:
    lsl	w16,	w11,	#5
    asr	w1,	w11,	#31
    lsl	w20,	w22,	#2
    movz	fp,	#440
    lsr	w2,	w1,	#27
    mov	x9,	x20
    movk	fp,	#2,	lsl #16
    add	x9,	sp,	x9
    add	w6,	w11,	w2
    add	x9,	x9,	#16
    asr	w2,	w6,	#5
    ldr	w0,	[x9]

    lsl	w4,	w2,	#5
    ldr	w18,	[sp, fp]

    sub	w4,	w11,	w4
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    add	w4,	w4,	w18
    add	w9,	w4,	w16
    add	w4,	w9,	w21
    add	w7,	w4,	w7
    add	w17,	w7,	w0
    ldr	w7,	[sp, fp]

    movz	fp,	#452
    lsl	w7,	w7,	#30
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#452
    asr	w14,	w23,	#31
    movk	fp,	#2,	lsl #16
    lsr	w20,	w14,	#2
    ldr	w1,	[sp, fp]

    movz	fp,	#452
    add	w2,	w1,	w20
    movk	fp,	#2,	lsl #16
    asr	w2,	w2,	#30
    ldr	w5,	[sp, fp]

    lsl	w6,	w2,	#30
    add	w2,	w22,	#1
    sub	w10,	w5,	w6
    add	w1,	w7,	w10
    cmp	w2,	#80
    blt	main_276

main_433:
    add	w9,	w17,	w27
    add	w6,	w11,	w3
    add	w0,	w1,	w19
    movz	fp,	#456
    add	w4,	w28,	#64
    add	w17,	w12,	w13
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    add	w22,	w8,	w15
    cmp	w4,	w25
    blt	main_62

main_441:
    movz	fp,	#504
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#420
    str	w9,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#496
    str	w6,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#472
    str	w0,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#548
    str	w17,	[x21]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w22,	[x23]


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

    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w1,	w6
    b	main_28

main_62:
    mov	w27,	w9
    mov	w3,	w6
    mov	w19,	w0
    mov	w13,	w17
    mov	w15,	w22
    mov	w28,	w4
    b	main_63

main_276:
    mov	w16,	w17
    movz	fp,	#452
    mov	w23,	w11
    mov	w8,	w2
    mov	w9,	w1
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#436
    mov	w24,	w10
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#488
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


