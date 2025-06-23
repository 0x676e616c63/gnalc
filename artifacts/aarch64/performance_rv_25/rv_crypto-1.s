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
    movz	w23,	#0
    movz	w25,	#0
    movz	w24,	#0
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
    movz	w2,	#0
    movz	fp,	#356
    movz	w6,	#0
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#596
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#596
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
    movz	fp,	#444
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x26,	x20
    add	x8,	x20,	#12
    add	x16,	x20,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x20,	#4
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#588
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#580
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
    movz	fp,	#572
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#428
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#428
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#428
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
    movz	fp,	#588
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
    movz	fp,	#444
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
    movz	fp,	#444
    add	w21,	w8,	#1
    movz	w23,	#125
    add	w20,	w8,	#4
    movk	fp,	#2,	lsl #16
    lsl	w2,	w21,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x25,	x28,	x26
    movk	fp,	#2,	lsl #16
    movz	w26,	#0
    movz	w28,	#0
    str	w28,	[x25]

    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    add	w1,	w8,	#3
    ldr	x0,	[sp, fp]

    add	w26,	w8,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    lsl	w26,	w1,	#2
    add	x21,	x0,	x2
    movz	w2,	#0
    str	w23,	[x21]

    ldr	x1,	[sp, fp]

    movz	fp,	#580
    add	x25,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x25]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w25,	#0
    movz	w17,	#8961
    movz	w3,	#56574
    movz	w6,	#21622
    movz	w27,	#43913
    movz	w21,	#57840
    mov	w18,	w25
    movk	w17,	#26437,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w21,	#50130,	lsl #16
    mov	w11,	w17
    mov	w0,	w3
    mov	w5,	w6
    mov	w17,	w27
    mov	w27,	w21

main_63:
    movz	w16,	#0
    mov	w26,	w18
    mov	w12,	w16

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w16,	w12,	#2
    lsl	w4,	w26,	#2
    movz	fp,	#444
    add	w13,	w26,	#2
    add	w12,	w12,	#1
    mov	x15,	x16
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    lsl	w8,	w13,	#2
    ldr	x1,	[sp, fp]

    add	w13,	w26,	#4
    add	x15,	x15,	#16
    movz	fp,	#444
    add	x3,	x1,	x4
    movk	fp,	#2,	lsl #16
    add	w1,	w26,	#1
    ldr	w6,	[x3]

    lsl	w19,	w1,	#2
    ldr	x10,	[sp, fp]

    lsl	w21,	w6,	#24
    movz	fp,	#444
    add	x2,	x10,	x19
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x2]

    ldr	x23,	[sp, fp]

    lsl	w6,	w4,	#16
    movz	fp,	#444
    add	w9,	w6,	w21
    movk	fp,	#2,	lsl #16
    add	x21,	x23,	x8
    add	w8,	w26,	#3
    add	w26,	w12,	#1
    ldr	w2,	[x21]

    lsl	w14,	w8,	#2
    ldr	x1,	[sp, fp]

    lsl	w3,	w2,	#8
    movz	fp,	#444
    add	x10,	x1,	x14
    movk	fp,	#2,	lsl #16
    add	w3,	w9,	w3
    lsl	w1,	w13,	#2
    lsl	w9,	w12,	#2
    ldr	w21,	[x10]

    mov	x7,	x9
    add	w8,	w3,	w21
    add	x7,	sp,	x7
    str	w8,	[x15]

    add	x7,	x7,	#16
    ldr	x10,	[sp, fp]

    movz	fp,	#444
    add	x28,	x10,	x1
    movk	fp,	#2,	lsl #16
    add	w1,	w13,	#1
    ldr	w2,	[x28]

    lsl	w19,	w1,	#2
    lsl	w23,	w2,	#24
    ldr	x2,	[sp, fp]

    movz	fp,	#444
    add	x2,	x2,	x19
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x2]

    add	w2,	w13,	#4
    ldr	x4,	[sp, fp]

    lsl	w8,	w6,	#16
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    add	w16,	w8,	w23
    add	w23,	w13,	#2
    lsl	w9,	w23,	#2
    add	x1,	x4,	x9
    add	w9,	w13,	#3
    ldr	w3,	[x1]

    ldr	x10,	[sp, fp]

    lsl	w4,	w3,	#8
    movz	fp,	#444
    add	w23,	w16,	w4
    movk	fp,	#2,	lsl #16
    lsl	w16,	w9,	#2
    lsl	w9,	w26,	#2
    add	x10,	x10,	x16
    mov	x8,	x9
    add	x8,	sp,	x8
    ldr	w21,	[x10]

    add	x8,	x8,	#16
    add	w4,	w23,	w21
    add	w21,	w2,	#2
    str	w4,	[x7]

    add	w7,	w2,	#1
    ldr	x1,	[sp, fp]

    lsl	w4,	w2,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w28,	w7,	#2
    add	x3,	x1,	x4
    lsl	w1,	w21,	#2
    ldr	w6,	[x3]

    ldr	x15,	[sp, fp]

    lsl	w3,	w6,	#24
    movz	fp,	#444
    add	x12,	x15,	x28
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x12]

    ldr	x21,	[sp, fp]

    lsl	w15,	w14,	#16
    movz	fp,	#444
    add	x1,	x21,	x1
    add	w14,	w26,	#1
    add	w16,	w15,	w3
    movk	fp,	#2,	lsl #16
    add	w15,	w2,	#3
    ldr	w4,	[x1]

    ldr	x6,	[sp, fp]

    lsl	w9,	w4,	#8
    lsl	w1,	w15,	#2
    movz	fp,	#444
    add	w4,	w16,	w9
    movk	fp,	#2,	lsl #16
    add	x21,	x6,	x1
    add	w16,	w2,	#4
    lsl	w1,	w14,	#2
    mov	x7,	x1
    ldr	w3,	[x21]

    add	w25,	w16,	#3
    lsl	w1,	w16,	#2
    add	x7,	sp,	x7
    add	w10,	w4,	w3
    add	x7,	x7,	#16
    str	w10,	[x8]

    add	w8,	w16,	#1
    ldr	x10,	[sp, fp]

    movz	fp,	#444
    add	x28,	x10,	x1
    movk	fp,	#2,	lsl #16
    lsl	w12,	w8,	#2
    ldr	w2,	[x28]

    ldr	x4,	[sp, fp]

    lsl	w2,	w2,	#24
    movz	fp,	#444
    add	x9,	x4,	x12
    movk	fp,	#2,	lsl #16
    add	w4,	w16,	#2
    ldr	w15,	[x9]

    ldr	x13,	[sp, fp]

    lsl	w9,	w4,	#2
    lsl	w23,	w15,	#16
    movz	fp,	#444
    add	x6,	x13,	x9
    movk	fp,	#2,	lsl #16
    add	w1,	w23,	w2
    add	w9,	w16,	#4
    lsl	w2,	w25,	#2
    ldr	w12,	[x6]

    ldr	x13,	[sp, fp]

    lsl	w15,	w12,	#8
    movz	fp,	#444
    add	w12,	w9,	#1
    add	w3,	w1,	w15
    movk	fp,	#2,	lsl #16
    add	x1,	x13,	x2
    lsl	w12,	w12,	#2
    ldr	w4,	[x1]

    add	w4,	w3,	w4
    str	w4,	[x7]

    ldr	x19,	[sp, fp]

    add	w4,	w14,	#1
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w2,	w4,	#2
    mov	x16,	x2
    lsl	w2,	w9,	#2
    add	x16,	sp,	x16
    add	x1,	x19,	x2
    add	x16,	x16,	#16
    ldr	w3,	[x1]

    add	w1,	w9,	#2
    ldr	x19,	[sp, fp]

    lsl	w6,	w3,	#24
    movz	fp,	#444
    add	x13,	x19,	x12
    movk	fp,	#2,	lsl #16
    lsl	w1,	w1,	#2
    add	w12,	w9,	#4
    ldr	w15,	[x13]

    add	w25,	w12,	#3
    lsl	w23,	w12,	#2
    add	w13,	w12,	#2
    ldr	x14,	[sp, fp]

    lsl	w19,	w15,	#16
    movz	fp,	#444
    add	x2,	x14,	x1
    movk	fp,	#2,	lsl #16
    add	w19,	w19,	w6
    add	w1,	w9,	#3
    ldr	w7,	[x2]

    lsl	w3,	w1,	#2
    ldr	x24,	[sp, fp]

    lsl	w14,	w7,	#8
    movz	fp,	#444
    add	x2,	x24,	x3
    add	w7,	w4,	#1
    add	w10,	w19,	w14
    movk	fp,	#2,	lsl #16
    add	w14,	w12,	#1
    ldr	w6,	[x2]

    lsl	w19,	w7,	#2
    add	w6,	w10,	w6
    mov	x3,	x19
    lsl	w10,	w14,	#2
    add	x3,	sp,	x3
    str	w6,	[x16]

    add	x3,	x3,	#16
    lsl	w6,	w13,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#444
    add	x21,	x4,	x23
    movk	fp,	#2,	lsl #16
    ldr	w28,	[x21]

    lsl	w4,	w28,	#24
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x16,	x28,	x10
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x16]

    ldr	x9,	[sp, fp]

    lsl	w2,	w1,	#16
    movz	fp,	#444
    add	x15,	x9,	x6
    add	w4,	w2,	w4
    movk	fp,	#2,	lsl #16
    add	w9,	w7,	#1
    ldr	w19,	[x15]

    ldr	x13,	[sp, fp]

    lsl	w23,	w19,	#8
    movz	fp,	#444
    add	w23,	w4,	w23
    movk	fp,	#2,	lsl #16
    lsl	w4,	w25,	#2
    add	x2,	x13,	x4
    ldr	w8,	[x2]

    add	w2,	w12,	#4
    add	w1,	w23,	w8
    lsl	w8,	w9,	#2
    mov	x6,	x8
    str	w1,	[x3]

    add	w12,	w2,	#2
    add	w26,	w2,	#4
    add	w16,	w2,	#1
    add	w8,	w2,	#3
    add	x6,	sp,	x6
    ldr	x15,	[sp, fp]

    lsl	w1,	w2,	#2
    lsl	w21,	w12,	#2
    lsl	w10,	w16,	#2
    lsl	w13,	w8,	#2
    add	x6,	x6,	#16
    movz	fp,	#444
    add	x19,	x15,	x1
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x19]

    ldr	x16,	[sp, fp]

    lsl	w15,	w4,	#24
    movz	fp,	#444
    add	x19,	x16,	x10
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x19]

    ldr	x16,	[sp, fp]

    lsl	w1,	w25,	#16
    movz	fp,	#444
    add	x14,	x16,	x21
    add	w3,	w1,	w15
    movk	fp,	#2,	lsl #16
    ldr	w23,	[x14]

    ldr	x22,	[sp, fp]

    lsl	w1,	w23,	#8
    add	x10,	x22,	x13
    add	w4,	w3,	w1
    add	w3,	w9,	#1
    ldr	w14,	[x10]

    mov	w12,	w3
    add	w7,	w4,	w14
    str	w7,	[x6]

    b	main_70

main_215:
    mov	w23,	w26
    mov	w3,	w12

main_217:
    lsl	w7,	w3,	#2
    lsl	w13,	w23,	#2
    movz	fp,	#444
    add	w28,	w3,	#1
    mov	x6,	x7
    movk	fp,	#2,	lsl #16
    add	x6,	sp,	x6
    ldr	x4,	[sp, fp]

    movz	fp,	#444
    add	x14,	x4,	x13
    add	x6,	x6,	#16
    movk	fp,	#2,	lsl #16
    add	w4,	w23,	#1
    ldr	w19,	[x14]

    lsl	w25,	w19,	#24
    lsl	w1,	w4,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#444
    add	x8,	x4,	x1
    movk	fp,	#2,	lsl #16
    add	w1,	w23,	#2
    ldr	w12,	[x8]

    lsl	w16,	w1,	#2
    ldr	x4,	[sp, fp]

    lsl	w14,	w12,	#16
    movz	fp,	#444
    add	x2,	x4,	x16
    movk	fp,	#2,	lsl #16
    add	w14,	w14,	w25
    add	w4,	w23,	#3
    add	w25,	w23,	#4
    ldr	w8,	[x2]

    lsl	w21,	w4,	#2
    lsl	w10,	w8,	#8
    ldr	x8,	[sp, fp]

    add	w10,	w14,	w10
    add	x8,	x8,	x21
    ldr	w15,	[x8]

    add	w21,	w10,	w15
    str	w21,	[x6]

    cmp	w28,	#16
    bge	main_241

main_216:
    mov	w23,	w25
    mov	w3,	w28
    b	main_217

main_241:
    mov	w14,	w28
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#564
    lsl	w25,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x16,	x25
    add	x16,	sp,	x16
    ldr	w25,	[sp, fp]

    movz	fp,	#564
    sub	w28,	w25,	#3
    add	x16,	x16,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w28,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w6,	[x2]

    ldr	w3,	[sp, fp]

    movz	fp,	#564
    sub	w4,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w9,	w4,	#2
    mov	x7,	x9
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w10,	[x7]

    ldr	w4,	[sp, fp]

    add	w7,	w10,	w6
    movz	fp,	#564
    sub	w26,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w13,	w6,	w7
    lsl	w1,	w26,	#2
    mov	x28,	x1
    add	w19,	w13,	w10
    add	x28,	sp,	x28
    sub	w8,	w19,	w7
    add	x28,	x28,	#16
    ldr	w3,	[x28]

    ldr	w6,	[sp, fp]

    add	w1,	w3,	w8
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    sub	w4,	w8,	w1
    add	w10,	w4,	w3
    sub	w26,	w10,	w1
    sub	w1,	w6,	#16
    lsl	w3,	w1,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w4,	[x2]

    add	w3,	w4,	w26
    sub	w10,	w26,	w3
    add	w12,	w10,	w4
    sub	w15,	w12,	w3
    asr	w1,	w15,	#31
    lsl	w10,	w15,	#1
    lsr	w2,	w1,	#31
    add	w3,	w15,	w2
    asr	w12,	w3,	#1
    lsl	w13,	w12,	#1
    sub	w4,	w15,	w13
    add	w6,	w10,	w4
    str	w6,	[x16]

    ldr	w16,	[sp, fp]

    movz	fp,	#564
    add	w8,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w11
    movz	fp,	#436
    mov	w2,	w17
    mov	w21,	w0
    mov	w8,	w5
    mov	w1,	w27
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]

    mov	w2,	w6
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w21,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]


main_277:
    movz	w6,	#48348
    movz	w13,	#60289
    movz	w4,	#49414
    movz	w28,	#31129
    movz	w25,	#65535
    movz	fp,	#420
    movk	w6,	#36635,	lsl #16
    movk	w13,	#28377,	lsl #16
    movk	w4,	#51810,	lsl #16
    movk	w28,	#23170,	lsl #16
    movk	w25,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w23,	w6
    mov	w9,	w13
    mov	w2,	w4
    mov	w15,	w28
    mov	w16,	w25
    ldr	w14,	[sp, fp]

    cmp	w14,	#20
    bge	main_296

main_285:
    movz	fp,	#432
    mov	w10,	w16
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    add	w6,	w22,	w19
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#424
    sub	w4,	w10,	w12
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w10,	w21,	w4
    add	w13,	w10,	w6
    sub	w19,	w6,	w13
    add	w28,	w19,	w10
    sub	w19,	w28,	w13
    sub	w4,	w19,	w28
    add	w7,	w4,	w13
    mov	w13,	w15
    sub	w7,	w7,	w28
    mov	w6,	w7
    b	main_416

main_296:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#432
    add	w6,	w26,	w24
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w21,	w6
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#424
    add	w25,	w7,	w8
    movk	fp,	#2,	lsl #16
    sub	w13,	w25,	w6
    ldr	w6,	[sp, fp]

    movz	fp,	#424
    add	w4,	w6,	w13
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w6,	w13,	w4
    mov	w13,	w9
    add	w6,	w6,	w26
    sub	w7,	w6,	w4
    mov	w19,	w7
    b	main_413

main_307:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    cmp	w21,	#60
    bge	main_327

main_309:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#424
    add	w28,	w12,	w6
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#424
    add	w7,	w8,	w21
    movk	fp,	#2,	lsl #16
    add	w13,	w7,	w28
    sub	w19,	w28,	w13
    add	w6,	w19,	w7
    ldr	w19,	[sp, fp]

    movz	fp,	#440
    sub	w4,	w6,	w13
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    sub	w7,	w4,	w6
    add	w13,	w7,	w13
    sub	w6,	w13,	w6
    add	w13,	w19,	w22
    add	w25,	w13,	w6
    sub	w28,	w6,	w25
    add	w13,	w28,	w13
    sub	w6,	w13,	w25
    sub	w4,	w6,	w13
    add	w7,	w4,	w25
    sub	w7,	w7,	w13
    mov	w13,	w23
    mov	w19,	w7
    b	main_413

main_327:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    add	w4,	w21,	w8
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w12,	w4
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#424
    add	w28,	w7,	w22
    movk	fp,	#2,	lsl #16
    sub	w13,	w28,	w4
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w4,	w19,	w13
    ldr	w10,	[sp, fp]

    sub	w19,	w13,	w4
    mov	w13,	w2
    add	w7,	w19,	w10
    sub	w7,	w7,	w4
    mov	w19,	w7

main_413:
    mov	w6,	w19

main_416:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#436
    lsl	w10,	w3,	#5
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#436
    asr	w19,	w14,	#31
    movk	fp,	#2,	lsl #16
    lsr	w25,	w19,	#27
    ldr	w21,	[sp, fp]

    movz	fp,	#436
    add	w7,	w21,	w25
    movk	fp,	#2,	lsl #16
    asr	w19,	w7,	#5
    ldr	w26,	[sp, fp]

    movz	fp,	#420
    lsl	w25,	w19,	#5
    movk	fp,	#2,	lsl #16
    sub	w7,	w26,	w25
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    lsl	w4,	w22,	#2
    movk	fp,	#2,	lsl #16
    mov	x25,	x4
    add	w28,	w10,	w7
    add	x25,	sp,	x25
    add	w26,	w28,	w1
    add	x25,	x25,	#16
    add	w6,	w26,	w6
    ldr	w10,	[x25]

    ldr	w19,	[sp, fp]

    movz	fp,	#432
    add	w7,	w6,	w13
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    add	w13,	w7,	w10
    movz	fp,	#432
    asr	w4,	w21,	#31
    lsl	w7,	w19,	#30
    movk	fp,	#2,	lsl #16
    lsr	w10,	w4,	#2
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    add	w19,	w19,	w10
    movk	fp,	#2,	lsl #16
    asr	w6,	w19,	#30
    ldr	w21,	[sp, fp]

    movz	fp,	#420
    lsl	w4,	w6,	#30
    movk	fp,	#2,	lsl #16
    sub	w10,	w21,	w4
    ldr	w21,	[sp, fp]

    add	w26,	w21,	#1
    add	w19,	w7,	w10
    cmp	w26,	#20
    bge	main_364

main_336:
    movz	fp,	#436
    mov	w4,	w16
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#436
    add	w14,	w19,	w1
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#440
    sub	w1,	w4,	w2
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w2,	w10,	w1
    add	w7,	w2,	w14
    sub	w10,	w14,	w7
    add	w9,	w10,	w2
    mov	w10,	w15
    sub	w14,	w9,	w7
    sub	w16,	w14,	w9
    add	w23,	w16,	w7
    sub	w21,	w23,	w9
    mov	w25,	w21
    b	main_347

main_364:
    cmp	w26,	#40
    bge	main_378

main_366:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#436
    add	w15,	w19,	w21
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w4,	w15
    movk	fp,	#2,	lsl #16
    add	w1,	w7,	w19
    sub	w1,	w1,	w15
    ldr	w15,	[sp, fp]

    movz	fp,	#440
    add	w4,	w15,	w1
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    sub	w6,	w1,	w4
    mov	w1,	w9
    add	w10,	w6,	w23
    sub	w15,	w10,	w4
    b	main_375

main_378:
    cmp	w26,	#60
    bge	main_401

main_380:
    movz	fp,	#436
    mov	w2,	w23
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#436
    add	w16,	w19,	w21
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#440
    add	w15,	w3,	w8
    movk	fp,	#2,	lsl #16
    add	w9,	w15,	w16
    ldr	w22,	[sp, fp]

    sub	w1,	w16,	w9
    add	w6,	w1,	w15
    sub	w15,	w6,	w9
    sub	w4,	w15,	w6
    add	w1,	w4,	w9
    add	w9,	w22,	w19
    sub	w4,	w1,	w6
    add	w1,	w9,	w4
    sub	w7,	w4,	w1
    add	w10,	w7,	w9
    sub	w14,	w10,	w1
    sub	w21,	w14,	w10
    add	w1,	w21,	w1
    sub	w14,	w1,	w10
    mov	w16,	w14
    b	main_398

main_401:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#436
    add	w15,	w19,	w4
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#440
    sub	w6,	w16,	w15
    movk	fp,	#2,	lsl #16
    add	w7,	w6,	w19
    ldr	w1,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w4,	w7,	w15
    ldr	w10,	[sp, fp]

    add	w15,	w1,	w4
    sub	w7,	w4,	w15
    add	w1,	w7,	w10
    sub	w15,	w1,	w15
    mov	w16,	w15

main_398:
    mov	w15,	w16
    mov	w1,	w2

main_375:
    mov	w25,	w15
    mov	w10,	w1

main_347:
    lsl	w14,	w13,	#5
    asr	w2,	w13,	#31
    lsl	w23,	w26,	#2
    movz	fp,	#424
    lsr	w4,	w2,	#27
    mov	x16,	x23
    movk	fp,	#2,	lsl #16
    add	x16,	sp,	x16
    add	w6,	w13,	w4
    add	x16,	x16,	#16
    asr	w4,	w6,	#5
    ldr	w1,	[x16]

    lsl	w9,	w4,	#5
    ldr	w21,	[sp, fp]

    sub	w6,	w13,	w9
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w6,	w6,	w21
    ldr	w8,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w7,	w6,	w14
    ldr	w28,	[sp, fp]

    movz	fp,	#436
    asr	w14,	w28,	#31
    add	w6,	w7,	w25
    movk	fp,	#2,	lsl #16
    lsr	w23,	w14,	#2
    ldr	w2,	[sp, fp]

    add	w7,	w6,	w10
    movz	fp,	#436
    add	w4,	w2,	w23
    movk	fp,	#2,	lsl #16
    add	w16,	w7,	w1
    ldr	w6,	[sp, fp]

    asr	w4,	w4,	#30
    lsl	w7,	w8,	#30
    lsl	w9,	w4,	#30
    add	w4,	w26,	#1
    sub	w12,	w6,	w9
    add	w6,	w7,	w12
    cmp	w4,	#80
    blt	main_276

main_433:
    add	w25,	w16,	w11
    add	w23,	w13,	w17
    add	w10,	w6,	w0
    add	w8,	w19,	w5
    movz	fp,	#440
    add	w26,	w18,	#64
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    add	w4,	w6,	w27
    cmp	w26,	w20
    blt	main_62

main_441:
    movz	fp,	#460
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#468
    str	w25,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#452
    str	w23,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#572
    str	w10,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#404
    str	w8,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w4,	[x23]


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

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w25
    mov	w17,	w23
    mov	w0,	w10
    mov	w5,	w8
    mov	w27,	w4
    mov	w18,	w26
    b	main_63

main_276:
    mov	w15,	w16
    movz	fp,	#436
    mov	w7,	w13
    mov	w14,	w19
    mov	w9,	w4
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#420
    mov	w1,	w12
    movk	fp,	#2,	lsl #16
    mov	w12,	w6
    str	w9,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#596
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


