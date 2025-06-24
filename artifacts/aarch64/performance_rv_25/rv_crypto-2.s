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
    movz	w23,	#0
    movz	w26,	#0
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
    mov	w19,	w0
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
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#524
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
    movz	fp,	#516
    movz	w11,	#62464
    add	x22,	sp,	#16
    mov	x26,	x21
    add	x8,	x21,	#12
    add	x16,	x21,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x21,	#4
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#628
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x21,	#8
    str	x25,	[sp, fp]

    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#544
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#604
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#552
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w0
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#500
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#500
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#500
    add	w1,	w15,	w17
    movk	fp,	#2,	lsl #16
    asr	w18,	w1,	#31
    lsr	w19,	w18,	#15
    add	w21,	w1,	w19
    asr	w19,	w21,	#17
    add	w3,	w1,	w19
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
    movz	fp,	#628
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w8,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w25,	w8,	#31
    lsr	w26,	w25,	#26
    add	w0,	w8,	w26
    asr	w1,	w0,	#6
    lsl	w2,	w1,	#6
    sub	w26,	w8,	w2
    cmp	w26,	#60
    beq	main_53

main_50:
    lsl	w3,	w8,	#2
    movz	fp,	#516
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
    movz	fp,	#516
    add	w22,	w8,	#1
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#516
    add	x25,	x28,	x26
    movk	fp,	#2,	lsl #16
    movz	w26,	#0
    movz	w28,	#0
    str	w28,	[x25]

    ldr	x0,	[sp, fp]

    movz	fp,	#516
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w26,	[x1]

    ldr	x0,	[sp, fp]

    add	w26,	w8,	#2
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    lsl	w2,	w26,	#2
    add	x22,	x0,	x2
    add	w2,	w8,	#3
    str	w23,	[x22]

    lsl	w26,	w2,	#2
    add	w22,	w8,	#4
    ldr	x1,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#620
    add	x25,	x1,	x26
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x25]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w25,	#0
    movz	w17,	#8961
    movz	w5,	#56574
    movz	w27,	#43913
    movz	w6,	#21622
    movz	w21,	#57840
    mov	w18,	w25
    movk	w17,	#26437,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w21,	#50130,	lsl #16
    mov	w2,	w17
    mov	w13,	w5
    mov	w1,	w6
    mov	w17,	w27
    mov	w27,	w21

main_63:
    movz	w15,	#0
    mov	w26,	w18
    mov	w11,	w15

main_70:
    cmp	w11,	#14
    bge	main_215

main_74:
    lsl	w15,	w11,	#2
    lsl	w6,	w26,	#2
    movz	fp,	#516
    add	w12,	w26,	#2
    mov	x15,	x15
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    lsl	w8,	w12,	#2
    ldr	x0,	[sp, fp]

    add	w12,	w26,	#4
    movz	fp,	#516
    add	x15,	x15,	#16
    add	x5,	x0,	x6
    movk	fp,	#2,	lsl #16
    add	w0,	w26,	#1
    ldr	w7,	[x5]

    lsl	w16,	w0,	#2
    ldr	x10,	[sp, fp]

    lsl	w19,	w7,	#24
    movz	fp,	#516
    add	x3,	x10,	x16
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x3]

    ldr	x21,	[sp, fp]

    lsl	w7,	w6,	#16
    movz	fp,	#516
    add	w9,	w7,	w19
    movk	fp,	#2,	lsl #16
    add	w7,	w26,	#3
    add	x19,	x21,	x8
    lsl	w16,	w7,	#2
    ldr	w3,	[x19]

    ldr	x0,	[sp, fp]

    lsl	w4,	w3,	#8
    movz	fp,	#516
    add	x10,	x0,	x16
    add	w5,	w9,	w4
    movk	fp,	#2,	lsl #16
    lsl	w0,	w12,	#2
    ldr	w19,	[x10]

    add	w10,	w11,	#1
    add	w8,	w5,	w19
    add	w25,	w10,	#1
    lsl	w11,	w10,	#2
    str	w8,	[x15]

    mov	x7,	x11
    ldr	x11,	[sp, fp]

    add	x7,	sp,	x7
    movz	fp,	#516
    add	x28,	x11,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w12,	#1
    add	x7,	x7,	#16
    ldr	w3,	[x28]

    lsl	w16,	w0,	#2
    lsl	w21,	w3,	#24
    ldr	x3,	[sp, fp]

    movz	fp,	#516
    add	x3,	x3,	x16
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    ldr	x4,	[sp, fp]

    lsl	w6,	w5,	#16
    movz	fp,	#516
    add	w19,	w6,	w21
    movk	fp,	#2,	lsl #16
    add	w21,	w12,	#2
    lsl	w9,	w21,	#2
    add	w21,	w25,	#1
    add	x0,	x4,	x9
    add	w9,	w12,	#3
    ldr	w5,	[x0]

    lsl	w15,	w9,	#2
    add	w0,	w12,	#4
    ldr	x11,	[sp, fp]

    lsl	w6,	w5,	#8
    lsl	w9,	w25,	#2
    movz	fp,	#516
    add	w8,	w0,	#1
    add	x14,	x11,	x15
    add	w23,	w19,	w6
    mov	x9,	x9
    movk	fp,	#2,	lsl #16
    lsl	w6,	w0,	#2
    lsl	w28,	w8,	#2
    ldr	w19,	[x14]

    add	x9,	sp,	x9
    add	w4,	w23,	w19
    add	w19,	w0,	#2
    str	w4,	[x7]

    add	x9,	x9,	#16
    ldr	x3,	[sp, fp]

    movz	fp,	#516
    add	x4,	x3,	x6
    movk	fp,	#2,	lsl #16
    lsl	w3,	w19,	#2
    ldr	w7,	[x4]

    ldr	x15,	[sp, fp]

    lsl	w4,	w7,	#24
    movz	fp,	#516
    add	x11,	x15,	x28
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x11]

    ldr	x19,	[sp, fp]

    lsl	w15,	w14,	#16
    movz	fp,	#516
    add	x3,	x19,	x3
    add	w16,	w15,	w4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    ldr	x6,	[sp, fp]

    lsl	w7,	w5,	#8
    movz	fp,	#516
    add	w5,	w16,	w7
    movk	fp,	#2,	lsl #16
    add	w7,	w0,	#4
    add	w16,	w0,	#3
    lsl	w0,	w21,	#2
    mov	x28,	x0
    lsl	w3,	w16,	#2
    add	w14,	w7,	#4
    lsl	w26,	w7,	#2
    add	x28,	sp,	x28
    add	x19,	x6,	x3
    add	w6,	w7,	#1
    add	x28,	x28,	#16
    ldr	w4,	[x19]

    add	w10,	w5,	w4
    str	w10,	[x9]

    ldr	x9,	[sp, fp]

    movz	fp,	#516
    add	x16,	x9,	x26
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x16]

    ldr	x10,	[sp, fp]

    lsl	w5,	w3,	#24
    movz	fp,	#516
    lsl	w3,	w6,	#2
    movk	fp,	#2,	lsl #16
    add	w6,	w7,	#2
    add	x8,	x10,	x3
    lsl	w12,	w6,	#2
    ldr	w15,	[x8]

    lsl	w6,	w14,	#2
    ldr	x10,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#516
    add	x9,	x10,	x12
    add	w15,	w14,	#1
    add	w0,	w16,	w5
    movk	fp,	#2,	lsl #16
    add	w16,	w7,	#3
    ldr	w11,	[x9]

    lsl	w12,	w11,	#8
    add	w11,	w21,	#1
    add	w5,	w0,	w12
    ldr	x12,	[sp, fp]

    lsl	w0,	w16,	#2
    add	w8,	w11,	#1
    lsl	w3,	w11,	#2
    movz	fp,	#516
    lsl	w16,	w15,	#2
    add	x19,	x12,	x0
    add	w11,	w14,	#4
    movk	fp,	#2,	lsl #16
    mov	x0,	x3
    add	x0,	sp,	x0
    ldr	w4,	[x19]

    add	w4,	w5,	w4
    add	x0,	x0,	#16
    str	w4,	[x28]

    ldr	x26,	[sp, fp]

    movz	fp,	#516
    add	x4,	x26,	x6
    movk	fp,	#2,	lsl #16
    add	w6,	w14,	#2
    ldr	w7,	[x4]

    lsl	w5,	w6,	#2
    add	w4,	w14,	#3
    ldr	x23,	[sp, fp]

    lsl	w9,	w7,	#24
    add	w14,	w11,	#1
    movz	fp,	#516
    add	x16,	x23,	x16
    movk	fp,	#2,	lsl #16
    ldr	w23,	[x16]

    lsl	w16,	w8,	#2
    ldr	x21,	[sp, fp]

    lsl	w3,	w23,	#16
    movz	fp,	#516
    add	x7,	x21,	x5
    movk	fp,	#2,	lsl #16
    add	w3,	w3,	w9
    lsl	w21,	w11,	#2
    ldr	w12,	[x7]

    lsl	w7,	w4,	#2
    lsl	w19,	w12,	#8
    add	w12,	w11,	#2
    add	w10,	w3,	w19
    ldr	x3,	[sp, fp]

    movz	fp,	#516
    add	x6,	x3,	x7
    movk	fp,	#2,	lsl #16
    lsl	w7,	w12,	#2
    mov	x3,	x16
    ldr	w9,	[x6]

    add	x3,	sp,	x3
    add	w9,	w10,	w9
    lsl	w10,	w14,	#2
    add	x3,	x3,	#16
    str	w9,	[x0]

    add	w9,	w8,	#1
    ldr	x4,	[sp, fp]

    movz	fp,	#516
    add	x19,	x4,	x21
    movk	fp,	#2,	lsl #16
    lsl	w8,	w9,	#2
    ldr	w28,	[x19]

    lsl	w5,	w28,	#24
    ldr	x28,	[sp, fp]

    movz	fp,	#516
    add	x19,	x28,	x10
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x19]

    lsl	w4,	w0,	#16
    add	w6,	w4,	w5
    ldr	x5,	[sp, fp]

    movz	fp,	#516
    add	x15,	x5,	x7
    movk	fp,	#2,	lsl #16
    ldr	w19,	[x15]

    ldr	x12,	[sp, fp]

    lsl	w21,	w19,	#8
    movz	fp,	#516
    add	w23,	w6,	w21
    movk	fp,	#2,	lsl #16
    add	w21,	w11,	#3
    lsl	w5,	w21,	#2
    add	x4,	x12,	x5
    ldr	w6,	[x4]

    mov	x4,	x8
    add	w0,	w23,	w6
    add	x4,	sp,	x4
    str	w0,	[x3]

    add	x4,	x4,	#16
    ldr	x15,	[sp, fp]

    add	w3,	w11,	#4
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    add	w26,	w3,	#4
    lsl	w0,	w3,	#2
    add	x16,	x15,	x0
    ldr	w7,	[x16]

    add	w16,	w3,	#1
    lsl	w15,	w7,	#24
    lsl	w10,	w16,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#516
    add	x19,	x16,	x10
    movk	fp,	#2,	lsl #16
    add	w10,	w3,	#2
    ldr	w23,	[x19]

    ldr	x16,	[sp, fp]

    lsl	w19,	w10,	#2
    lsl	w0,	w23,	#16
    movz	fp,	#516
    add	w10,	w3,	#3
    add	x14,	x16,	x19
    add	w5,	w0,	w15
    movk	fp,	#2,	lsl #16
    lsl	w12,	w10,	#2
    ldr	w21,	[x14]

    ldr	x20,	[sp, fp]

    lsl	w0,	w21,	#8
    add	x11,	x20,	x12
    add	w5,	w5,	w0
    ldr	w14,	[x11]

    add	w8,	w5,	w14
    add	w5,	w9,	#1
    mov	w11,	w5
    str	w8,	[x4]

    b	main_70

main_215:
    mov	w23,	w26
    mov	w3,	w11

main_217:
    lsl	w8,	w3,	#2
    lsl	w12,	w23,	#2
    movz	fp,	#516
    add	w5,	w23,	#1
    add	w28,	w3,	#1
    add	w25,	w23,	#4
    mov	x7,	x8
    movk	fp,	#2,	lsl #16
    lsl	w0,	w5,	#2
    add	x7,	sp,	x7
    ldr	x6,	[sp, fp]

    movz	fp,	#516
    add	x14,	x6,	x12
    add	x7,	x7,	#16
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x14]

    ldr	x5,	[sp, fp]

    lsl	w21,	w16,	#24
    movz	fp,	#516
    add	x6,	x5,	x0
    movk	fp,	#2,	lsl #16
    add	w5,	w23,	#3
    add	w0,	w23,	#2
    ldr	w11,	[x6]

    lsl	w19,	w5,	#2
    ldr	x6,	[sp, fp]

    lsl	w15,	w11,	#16
    movz	fp,	#516
    movk	fp,	#2,	lsl #16
    add	w16,	w15,	w21
    lsl	w15,	w0,	#2
    add	x4,	x6,	x15
    ldr	w9,	[x4]

    lsl	w10,	w9,	#8
    ldr	x9,	[sp, fp]

    add	w10,	w16,	w10
    add	x6,	x9,	x19
    ldr	w16,	[x6]

    add	w19,	w10,	w16
    str	w19,	[x7]

    cmp	w28,	#16
    bge	main_241

main_216:
    mov	w23,	w25
    mov	w3,	w28
    b	main_217

main_241:
    mov	w14,	w28
    movz	fp,	#592
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#592
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#592
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#592
    lsl	w25,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x15,	x25
    add	x15,	sp,	x15
    ldr	w25,	[sp, fp]

    movz	fp,	#592
    sub	w28,	w25,	#3
    add	x15,	x15,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w28,	#2
    mov	x0,	x3
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w4,	[sp, fp]

    movz	fp,	#592
    sub	w7,	w4,	#8
    movk	fp,	#2,	lsl #16
    lsl	w9,	w7,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w5,	[sp, fp]

    add	w8,	w10,	w6
    movz	fp,	#592
    sub	w26,	w5,	#14
    movk	fp,	#2,	lsl #16
    sub	w12,	w6,	w8
    lsl	w0,	w26,	#2
    mov	x28,	x0
    add	w16,	w12,	w10
    add	x28,	sp,	x28
    sub	w8,	w16,	w8
    add	x28,	x28,	#16
    ldr	w3,	[x28]

    ldr	w6,	[sp, fp]

    add	w0,	w3,	w8
    movz	fp,	#592
    movk	fp,	#2,	lsl #16
    sub	w5,	w8,	w0
    add	w11,	w5,	w3
    sub	w26,	w11,	w0
    sub	w0,	w6,	#16
    lsl	w5,	w0,	#2
    mov	x3,	x5
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    ldr	w6,	[x3]

    add	w5,	w6,	w26
    sub	w10,	w26,	w5
    add	w11,	w10,	w6
    sub	w14,	w11,	w5
    asr	w0,	w14,	#31
    lsl	w9,	w14,	#1
    lsr	w3,	w0,	#31
    add	w5,	w14,	w3
    asr	w11,	w5,	#1
    lsl	w12,	w11,	#1
    sub	w6,	w14,	w12
    add	w7,	w9,	w6
    str	w7,	[x15]

    ldr	w16,	[sp, fp]

    movz	fp,	#592
    add	w8,	w16,	#1
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w24,	w2
    movz	fp,	#508
    mov	w3,	w17
    mov	w15,	w13
    mov	w9,	w1
    mov	w14,	w27
    movz	w7,	#0
    movk	fp,	#2,	lsl #16
    mov	w28,	w7
    str	w24,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	w28,	[sp, fp]


main_277:
    movz	w6,	#48348
    movz	w0,	#60289
    movz	w3,	#49414
    movz	w26,	#31129
    movz	w25,	#65535
    movz	fp,	#492
    movk	w6,	#36635,	lsl #16
    movk	w0,	#28377,	lsl #16
    movk	w3,	#51810,	lsl #16
    movk	w26,	#23170,	lsl #16
    movk	w25,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w23,	w6
    mov	w19,	w3
    mov	w15,	w25
    ldr	w10,	[sp, fp]

    mov	w6,	w26
    cmp	w10,	#20
    bge	main_296

main_285:
    movz	fp,	#504
    mov	w3,	w15
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#504
    add	w16,	w20,	w16
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#496
    sub	w21,	w3,	w10
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    add	w26,	w20,	w21
    add	w3,	w26,	w16
    sub	w25,	w16,	w3
    add	w9,	w25,	w26
    sub	w16,	w9,	w3
    sub	w21,	w16,	w9
    add	w25,	w21,	w3
    mov	w21,	w6
    sub	w7,	w25,	w9
    b	main_416

main_296:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    cmp	w12,	#40
    bge	main_307

main_298:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#504
    add	w9,	w20,	w21
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#512
    sub	w12,	w16,	w9
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#496
    add	w7,	w12,	w5
    movk	fp,	#2,	lsl #16
    sub	w28,	w7,	w9
    ldr	w7,	[sp, fp]

    movz	fp,	#496
    add	w7,	w7,	w28
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w21,	w28,	w7
    add	w21,	w21,	w26
    sub	w7,	w21,	w7
    mov	w21,	w0
    mov	w9,	w7
    b	main_413

main_307:
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    cmp	w16,	#60
    bge	main_327

main_309:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#496
    add	w7,	w9,	w7
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#496
    add	w28,	w10,	w20
    movk	fp,	#2,	lsl #16
    add	w3,	w28,	w7
    ldr	w11,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    sub	w21,	w7,	w3
    add	w28,	w21,	w28
    sub	w16,	w28,	w3
    sub	w21,	w16,	w28
    add	w3,	w21,	w3
    ldr	w21,	[sp, fp]

    add	w16,	w11,	w21
    sub	w9,	w3,	w28
    add	w28,	w16,	w9
    sub	w7,	w9,	w28
    add	w21,	w7,	w16
    sub	w3,	w21,	w28
    sub	w16,	w3,	w21
    add	w25,	w16,	w28
    sub	w7,	w25,	w21
    mov	w21,	w23
    mov	w9,	w7
    b	main_413

main_327:
    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#504
    add	w7,	w20,	w9
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#512
    sub	w26,	w9,	w7
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#496
    add	w28,	w26,	w21
    movk	fp,	#2,	lsl #16
    mov	w21,	w19
    sub	w26,	w28,	w7
    ldr	w12,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    add	w16,	w12,	w26
    ldr	w9,	[sp, fp]

    sub	w12,	w26,	w16
    add	w9,	w12,	w9
    sub	w7,	w9,	w16
    mov	w9,	w7

main_413:
    mov	w7,	w9

main_416:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#508
    lsl	w16,	w4,	#5
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#508
    asr	w12,	w11,	#31
    movk	fp,	#2,	lsl #16
    lsr	w12,	w12,	#27
    ldr	w25,	[sp, fp]

    movz	fp,	#508
    add	w9,	w25,	w12
    movk	fp,	#2,	lsl #16
    asr	w12,	w9,	#5
    ldr	w26,	[sp, fp]

    movz	fp,	#492
    lsl	w9,	w12,	#5
    movk	fp,	#2,	lsl #16
    sub	w9,	w26,	w9
    ldr	w20,	[sp, fp]

    movz	fp,	#504
    lsl	w28,	w20,	#2
    movk	fp,	#2,	lsl #16
    mov	x28,	x28
    add	w25,	w16,	w9
    add	x28,	sp,	x28
    add	w25,	w25,	w14
    add	x28,	x28,	#16
    add	w7,	w25,	w7
    ldr	w9,	[x28]

    ldr	w14,	[sp, fp]

    movz	fp,	#504
    add	w21,	w7,	w21
    movk	fp,	#2,	lsl #16
    lsl	w7,	w14,	#30
    ldr	w16,	[sp, fp]

    add	w9,	w21,	w9
    movz	fp,	#504
    asr	w3,	w16,	#31
    movk	fp,	#2,	lsl #16
    lsr	w16,	w3,	#2
    ldr	w10,	[sp, fp]

    movz	fp,	#504
    add	w12,	w10,	w16
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    asr	w25,	w12,	#30
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    lsl	w12,	w25,	#30
    ldr	w14,	[sp, fp]

    sub	w28,	w16,	w12
    add	w16,	w14,	#1
    add	w28,	w7,	w28
    cmp	w16,	#20
    bge	main_364

main_336:
    movz	fp,	#508
    mov	w12,	w15
    mov	w14,	w6
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#508
    add	w10,	w28,	w0
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#512
    sub	w0,	w12,	w3
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w3,	w15,	w0
    add	w19,	w3,	w10
    sub	w21,	w10,	w19
    add	w15,	w21,	w3
    sub	w25,	w15,	w19
    sub	w26,	w25,	w15
    add	w26,	w26,	w19
    sub	w19,	w26,	w15
    mov	w21,	w19
    b	main_347

main_364:
    cmp	w16,	#40
    bge	main_378

main_366:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#508
    add	w15,	w28,	w19
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#512
    sub	w6,	w8,	w15
    movk	fp,	#2,	lsl #16
    add	w4,	w6,	w28
    sub	w6,	w4,	w15
    ldr	w15,	[sp, fp]

    movz	fp,	#512
    add	w3,	w15,	w6
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    sub	w14,	w6,	w3
    add	w25,	w14,	w21
    sub	w14,	w25,	w3
    b	main_375

main_378:
    cmp	w16,	#60
    bge	main_401

main_380:
    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#508
    add	w0,	w28,	w19
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#512
    add	w26,	w5,	w8
    movk	fp,	#2,	lsl #16
    add	w6,	w26,	w0
    ldr	w20,	[sp, fp]

    sub	w12,	w0,	w6
    add	w10,	w12,	w26
    add	w12,	w20,	w28
    sub	w21,	w10,	w6
    sub	w0,	w21,	w10
    add	w0,	w0,	w6
    sub	w4,	w0,	w10
    add	w0,	w12,	w4
    sub	w14,	w4,	w0
    add	w7,	w14,	w12
    sub	w25,	w7,	w0
    sub	w26,	w25,	w7
    mov	w25,	w23
    add	w14,	w26,	w0
    sub	w12,	w14,	w7
    mov	w14,	w12
    b	main_398

main_401:
    movz	fp,	#508
    mov	w25,	w19
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#508
    add	w14,	w28,	w3
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#512
    sub	w3,	w12,	w14
    movk	fp,	#2,	lsl #16
    add	w7,	w3,	w28
    ldr	w0,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    sub	w3,	w7,	w14
    ldr	w8,	[sp, fp]

    add	w23,	w0,	w3
    sub	w7,	w3,	w23
    add	w7,	w7,	w8
    sub	w12,	w7,	w23
    mov	w14,	w12

main_398:
    mov	w0,	w25

main_375:
    mov	w21,	w14
    mov	w14,	w0

main_347:
    lsl	w12,	w9,	#5
    asr	w0,	w9,	#31
    movz	fp,	#496
    lsr	w3,	w0,	#27
    movk	fp,	#2,	lsl #16
    add	w19,	w9,	w3
    asr	w7,	w19,	#5
    lsl	w19,	w16,	#2
    lsl	w0,	w7,	#5
    mov	x6,	x19
    add	x6,	sp,	x6
    sub	w15,	w9,	w0
    add	x6,	x6,	#16
    ldr	w0,	[x6]

    ldr	w20,	[sp, fp]

    movz	fp,	#508
    add	w8,	w15,	w20
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	w12
    ldr	w7,	[sp, fp]

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    add	w3,	w10,	w21
    ldr	w26,	[sp, fp]

    movz	fp,	#508
    add	w10,	w3,	w14
    movk	fp,	#2,	lsl #16
    asr	w14,	w26,	#31
    ldr	w3,	[sp, fp]

    add	w21,	w10,	w0
    lsr	w26,	w14,	#2
    movz	fp,	#508
    lsl	w10,	w7,	#30
    add	w0,	w3,	w26
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    asr	w7,	w0,	#30
    add	w0,	w16,	#1
    lsl	w8,	w7,	#30
    sub	w15,	w5,	w8
    add	w12,	w10,	w15
    cmp	w0,	#80
    blt	main_276

main_433:
    add	w3,	w21,	w2
    add	w25,	w9,	w17
    add	w23,	w12,	w13
    add	w14,	w28,	w1
    movz	fp,	#512
    add	w19,	w18,	#64
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    add	w9,	w6,	w27
    cmp	w19,	w22
    blt	main_62

main_441:
    movz	fp,	#536
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#544
    str	w3,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#612
    str	w25,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#604
    str	w23,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#552
    str	w14,	[x22]

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
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    sub	w4,	w26,	#1
    cmp	w4,	#0
    ble	main_460

main_27:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w2,	w3
    mov	w17,	w25
    mov	w13,	w23
    mov	w1,	w14
    mov	w27,	w9
    mov	w18,	w19
    b	main_63

main_276:
    mov	w16,	w21
    movz	fp,	#508
    mov	w8,	w9
    mov	w14,	w28
    mov	w7,	w0
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#492
    mov	w14,	w10
    movk	fp,	#2,	lsl #16
    mov	w10,	w12
    str	w7,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#524
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


