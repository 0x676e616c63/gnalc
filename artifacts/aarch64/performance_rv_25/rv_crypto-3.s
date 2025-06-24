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
    movz	w23,	#0
    movz	w26,	#0
    movz	w25,	#0
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
    movz	w2,	#0
    movz	fp,	#356
    movz	w4,	#0
    movz	w6,	#0
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

    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#596
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#400
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

    movz	fp,	#612
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w28,	#0
    movz	w17,	#8961
    movz	w3,	#56574
    movz	w6,	#21622
    movz	w27,	#43913
    movz	w18,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w18,	#50130,	lsl #16
    mov	w11,	w17
    mov	w0,	w3
    mov	w21,	w6
    mov	w13,	w27
    mov	w6,	w18

main_63:
    movz	w18,	#0
    mov	w24,	w28
    mov	w12,	w18

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w18,	w12,	#2
    lsl	w4,	w24,	#2
    movz	fp,	#436
    add	w14,	w24,	#2
    add	w16,	w24,	#4
    mov	x18,	x18
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    lsl	w7,	w14,	#2
    ldr	x1,	[sp, fp]

    add	x18,	x18,	#16
    movz	fp,	#436
    add	x3,	x1,	x4
    movk	fp,	#2,	lsl #16
    add	w1,	w24,	#1
    ldr	w5,	[x3]

    lsl	w20,	w1,	#2
    ldr	x10,	[sp, fp]

    lsl	w17,	w5,	#24
    movz	fp,	#436
    add	x2,	x10,	x20
    movk	fp,	#2,	lsl #16
    add	w10,	w12,	#1
    ldr	w4,	[x2]

    ldr	x25,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#436
    add	x22,	x25,	x7
    add	w8,	w5,	w17
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x22]

    ldr	x27,	[sp, fp]

    add	w22,	w16,	#2
    lsl	w3,	w1,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w3,	w8,	w3
    add	w8,	w24,	#3
    lsl	w15,	w8,	#2
    add	x9,	x27,	x15
    lsl	w27,	w16,	#2
    ldr	w20,	[x9]

    lsl	w9,	w10,	#2
    add	w7,	w3,	w20
    mov	x5,	x9
    add	x5,	sp,	x5
    str	w7,	[x18]

    ldr	x9,	[sp, fp]

    add	x5,	x5,	#16
    movz	fp,	#436
    add	x25,	x9,	x27
    movk	fp,	#2,	lsl #16
    add	w27,	w16,	#1
    ldr	w2,	[x25]

    lsl	w18,	w27,	#2
    lsl	w24,	w2,	#24
    ldr	x2,	[sp, fp]

    movz	fp,	#436
    add	x1,	x2,	x18
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x1]

    ldr	x4,	[sp, fp]

    lsl	w8,	w7,	#16
    movz	fp,	#436
    add	w7,	w10,	#1
    add	w17,	w8,	w24
    movk	fp,	#2,	lsl #16
    lsl	w8,	w22,	#2
    add	x1,	x4,	x8
    add	w8,	w16,	#3
    ldr	w3,	[x1]

    lsl	w15,	w8,	#2
    ldr	x12,	[sp, fp]

    lsl	w4,	w3,	#8
    lsl	w8,	w7,	#2
    movz	fp,	#436
    add	x14,	x12,	x15
    add	w20,	w17,	w4
    movk	fp,	#2,	lsl #16
    add	w15,	w16,	#4
    ldr	w24,	[x14]

    add	w4,	w20,	w24
    add	w22,	w15,	#2
    lsl	w3,	w15,	#2
    add	w20,	w15,	#4
    str	w4,	[x5]

    lsl	w27,	w22,	#2
    ldr	x1,	[sp, fp]

    add	w17,	w20,	#4
    mov	x4,	x8
    movz	fp,	#436
    add	x2,	x1,	x3
    add	w8,	w15,	#1
    add	x4,	sp,	x4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x2]

    lsl	w14,	w8,	#2
    add	x4,	x4,	#16
    ldr	x18,	[sp, fp]

    lsl	w2,	w5,	#24
    movz	fp,	#436
    add	x9,	x18,	x14
    add	w5,	w15,	#3
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x9]

    ldr	x19,	[sp, fp]

    lsl	w16,	w14,	#16
    movz	fp,	#436
    add	x24,	x19,	x27
    add	w14,	w16,	w2
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    lsl	w1,	w27,	#8
    lsl	w27,	w20,	#2
    add	w3,	w14,	w1
    add	w14,	w7,	#1
    lsl	w1,	w5,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#436
    add	x22,	x5,	x1
    add	w18,	w14,	#1
    movk	fp,	#2,	lsl #16
    lsl	w1,	w14,	#2
    ldr	w2,	[x22]

    mov	x7,	x1
    add	w8,	w3,	w2
    add	x7,	sp,	x7
    str	w8,	[x4]

    add	x7,	x7,	#16
    ldr	x8,	[sp, fp]

    movz	fp,	#436
    add	x25,	x8,	x27
    movk	fp,	#2,	lsl #16
    add	w8,	w20,	#1
    ldr	w2,	[x25]

    lsl	w12,	w8,	#2
    add	w25,	w20,	#3
    ldr	x4,	[sp, fp]

    lsl	w1,	w2,	#24
    movz	fp,	#436
    add	x9,	x4,	x12
    lsl	w2,	w18,	#2
    movk	fp,	#2,	lsl #16
    add	w4,	w20,	#2
    ldr	w16,	[x9]

    ldr	x15,	[sp, fp]

    lsl	w22,	w16,	#16
    lsl	w8,	w4,	#2
    movz	fp,	#436
    add	w1,	w22,	w1
    movk	fp,	#2,	lsl #16
    add	x5,	x15,	x8
    ldr	w12,	[x5]

    ldr	x15,	[sp, fp]

    lsl	w16,	w12,	#8
    movz	fp,	#436
    add	w12,	w17,	#1
    add	w3,	w1,	w16
    movk	fp,	#2,	lsl #16
    lsl	w1,	w25,	#2
    lsl	w20,	w12,	#2
    add	x27,	x15,	x1
    mov	x1,	x2
    add	w2,	w17,	#2
    add	x1,	sp,	x1
    ldr	w4,	[x27]

    add	w4,	w3,	w4
    add	x1,	x1,	#16
    str	w4,	[x7]

    ldr	x24,	[sp, fp]

    lsl	w4,	w17,	#2
    movz	fp,	#436
    add	x3,	x24,	x4
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x3]

    add	w3,	w17,	#3
    ldr	x15,	[sp, fp]

    lsl	w7,	w5,	#24
    movz	fp,	#436
    add	x14,	x15,	x20
    lsl	w5,	w2,	#2
    movk	fp,	#2,	lsl #16
    add	w2,	w17,	#4
    ldr	w24,	[x14]

    lsl	w22,	w2,	#2
    ldr	x15,	[sp, fp]

    lsl	w25,	w24,	#16
    movz	fp,	#436
    add	x4,	x15,	x5
    movk	fp,	#2,	lsl #16
    add	w25,	w25,	w7
    lsl	w5,	w3,	#2
    ldr	w8,	[x4]

    ldr	x26,	[sp, fp]

    lsl	w9,	w8,	#8
    movz	fp,	#436
    add	x4,	x26,	x5
    add	w10,	w25,	w9
    movk	fp,	#2,	lsl #16
    add	w9,	w2,	#2
    ldr	w7,	[x4]

    add	w7,	w10,	w7
    add	w10,	w2,	#1
    str	w7,	[x1]

    ldr	x3,	[sp, fp]

    lsl	w7,	w10,	#2
    add	w1,	w18,	#1
    movz	fp,	#436
    add	x20,	x3,	x22
    movk	fp,	#2,	lsl #16
    lsl	w15,	w1,	#2
    ldr	w24,	[x20]

    mov	x12,	x15
    ldr	x25,	[sp, fp]

    lsl	w3,	w24,	#24
    add	x12,	sp,	x12
    movz	fp,	#436
    add	x14,	x25,	x7
    add	w24,	w2,	#3
    movk	fp,	#2,	lsl #16
    add	w2,	w2,	#4
    add	x12,	x12,	#16
    ldr	w4,	[x14]

    add	w8,	w2,	#3
    lsl	w5,	w4,	#16
    ldr	x4,	[sp, fp]

    add	w7,	w5,	w3
    movz	fp,	#436
    lsl	w15,	w8,	#2
    lsl	w3,	w24,	#2
    lsl	w5,	w9,	#2
    movk	fp,	#2,	lsl #16
    add	x10,	x4,	x5
    ldr	w17,	[x10]

    add	w10,	w1,	#1
    ldr	x9,	[sp, fp]

    lsl	w22,	w17,	#8
    lsl	w1,	w2,	#2
    movz	fp,	#436
    add	x25,	x9,	x3
    add	w20,	w7,	w22
    movk	fp,	#2,	lsl #16
    add	w22,	w2,	#1
    lsl	w7,	w10,	#2
    ldr	w5,	[x25]

    add	w25,	w20,	w5
    lsl	w9,	w22,	#2
    mov	x5,	x7
    add	x5,	sp,	x5
    str	w25,	[x12]

    add	w12,	w2,	#2
    ldr	x16,	[sp, fp]

    add	x5,	x5,	#16
    movz	fp,	#436
    add	x18,	x16,	x1
    movk	fp,	#2,	lsl #16
    lsl	w22,	w12,	#2
    ldr	w4,	[x18]

    ldr	x16,	[sp, fp]

    lsl	w17,	w4,	#24
    movz	fp,	#436
    add	x24,	x16,	x9
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    add	w24,	w2,	#4
    lsl	w1,	w27,	#16
    add	w4,	w1,	w17
    ldr	x17,	[sp, fp]

    movz	fp,	#436
    add	x14,	x17,	x22
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x14]

    ldr	x20,	[sp, fp]

    lsl	w1,	w22,	#8
    add	x12,	x20,	x15
    add	w3,	w4,	w1
    ldr	w16,	[x12]

    add	w7,	w3,	w16
    add	w3,	w10,	#1
    mov	w12,	w3
    str	w7,	[x5]

    b	main_70

main_215:
    mov	w20,	w24
    mov	w3,	w12

main_217:
    lsl	w7,	w3,	#2
    lsl	w14,	w20,	#2
    movz	fp,	#436
    add	w1,	w20,	#2
    add	w25,	w3,	#1
    mov	x5,	x7
    movk	fp,	#2,	lsl #16
    add	x5,	sp,	x5
    lsl	w17,	w1,	#2
    ldr	x4,	[sp, fp]

    add	x5,	x5,	#16
    movz	fp,	#436
    add	x15,	x4,	x14
    movk	fp,	#2,	lsl #16
    add	w4,	w20,	#1
    ldr	w22,	[x15]

    lsl	w27,	w4,	#2
    ldr	x2,	[sp, fp]

    lsl	w24,	w22,	#24
    movz	fp,	#436
    add	x8,	x2,	x27
    add	w22,	w20,	#4
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x8]

    ldr	x4,	[sp, fp]

    lsl	w15,	w10,	#16
    movz	fp,	#436
    add	x2,	x4,	x17
    add	w15,	w15,	w24
    movk	fp,	#2,	lsl #16
    add	w4,	w20,	#3
    ldr	w8,	[x2]

    lsl	w9,	w8,	#8
    lsl	w24,	w4,	#2
    ldr	x8,	[sp, fp]

    add	w10,	w15,	w9
    add	x8,	x8,	x24
    ldr	w16,	[x8]

    add	w24,	w10,	w16
    str	w24,	[x5]

    cmp	w25,	#16
    bge	main_241

main_216:
    mov	w20,	w22
    mov	w3,	w25
    b	main_217

main_241:
    mov	w15,	w25
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#496
    lsl	w22,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x22
    add	x18,	sp,	x18
    ldr	w25,	[sp, fp]

    movz	fp,	#496
    sub	w27,	w25,	#3
    add	x18,	x18,	#16
    movk	fp,	#2,	lsl #16
    lsl	w3,	w27,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w4,	[x2]

    ldr	w3,	[sp, fp]

    movz	fp,	#496
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

    movz	fp,	#496
    sub	w24,	w4,	#14
    add	w20,	w14,	w10
    movk	fp,	#2,	lsl #16
    lsl	w1,	w24,	#2
    sub	w7,	w20,	w7
    mov	x25,	x1
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w3,	[x25]

    ldr	w5,	[sp, fp]

    add	w27,	w3,	w7
    movz	fp,	#496
    sub	w1,	w5,	#16
    movk	fp,	#2,	lsl #16
    sub	w2,	w7,	w27
    add	w9,	w2,	w3
    lsl	w3,	w1,	#2
    mov	x2,	x3
    sub	w24,	w9,	w27
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w4,	[x2]

    add	w3,	w4,	w24
    sub	w9,	w24,	w3
    add	w12,	w9,	w4
    sub	w15,	w12,	w3
    asr	w1,	w15,	#31
    lsl	w10,	w15,	#1
    lsr	w2,	w1,	#31
    add	w3,	w15,	w2
    asr	w12,	w3,	#1
    lsl	w16,	w12,	#1
    sub	w4,	w15,	w16
    add	w5,	w10,	w4
    str	w5,	[x18]

    ldr	w17,	[sp, fp]

    movz	fp,	#496
    add	w7,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w7
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w11
    movz	fp,	#428
    mov	w2,	w13
    mov	w18,	w0
    mov	w10,	w21
    mov	w3,	w6
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    mov	w1,	w4
    str	w25,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w2,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w10,	#60289
    movz	w27,	#31129
    movz	w24,	#65535
    movz	fp,	#412
    movk	w2,	#36635,	lsl #16
    movk	w10,	#28377,	lsl #16
    movk	w27,	#23170,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w20,	w2
    mov	w7,	w10
    mov	w16,	w27
    mov	w17,	w24
    ldr	w15,	[sp, fp]

    movz	w2,	#49414
    movk	w2,	#51810,	lsl #16
    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w1,	w17
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#424
    add	w4,	w25,	w18
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    sub	w1,	w1,	w12
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w10,	w19,	w1
    add	w14,	w10,	w4
    sub	w9,	w4,	w14
    add	w25,	w9,	w10
    sub	w18,	w25,	w14
    sub	w1,	w18,	w25
    add	w9,	w1,	w14
    sub	w10,	w9,	w25
    mov	w25,	w16
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
    ldr	w24,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#424
    add	w10,	w27,	w24
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w19,	w10
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#416
    add	w25,	w4,	w8
    movk	fp,	#2,	lsl #16
    sub	w25,	w25,	w10
    ldr	w5,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w1,	w5,	w25
    ldr	w26,	[sp, fp]

    sub	w4,	w25,	w1
    mov	w25,	w7
    add	w4,	w4,	w26
    sub	w10,	w4,	w1
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
    ldr	w12,	[sp, fp]

    movz	fp,	#416
    add	w25,	w12,	w5
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#416
    add	w9,	w9,	w19
    movk	fp,	#2,	lsl #16
    add	w18,	w9,	w25
    sub	w14,	w25,	w18
    add	w4,	w14,	w9
    sub	w1,	w4,	w18
    sub	w9,	w1,	w4
    add	w14,	w9,	w18
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    sub	w10,	w14,	w4
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w14,	w18,	w19
    add	w24,	w14,	w10
    sub	w25,	w10,	w24
    add	w14,	w25,	w14
    mov	w25,	w20
    sub	w4,	w14,	w24
    sub	w1,	w4,	w14
    add	w9,	w1,	w24
    sub	w10,	w9,	w14
    mov	w14,	w10
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w1,	w19,	w9
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w12,	w1
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#416
    add	w25,	w4,	w22
    movk	fp,	#2,	lsl #16
    sub	w10,	w25,	w1
    ldr	w18,	[sp, fp]

    mov	w25,	w2
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w1,	w18,	w10
    sub	w18,	w10,	w1
    ldr	w10,	[sp, fp]

    add	w9,	w18,	w10
    sub	w10,	w9,	w1
    mov	w14,	w10

main_413:
    mov	w10,	w14

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    lsl	w9,	w1,	#5
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
    lsl	w1,	w19,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x1
    add	w24,	w9,	w14
    add	x18,	sp,	x18
    add	w27,	w24,	w3
    add	x18,	x18,	#16
    add	w14,	w27,	w10
    ldr	w9,	[x18]

    ldr	w18,	[sp, fp]

    movz	fp,	#424
    add	w10,	w14,	w25
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w10,	w10,	w9
    movz	fp,	#424
    asr	w3,	w19,	#31
    lsl	w9,	w18,	#30
    movk	fp,	#2,	lsl #16
    lsr	w18,	w3,	#2
    ldr	w15,	[sp, fp]

    movz	fp,	#424
    add	w24,	w15,	w18
    movk	fp,	#2,	lsl #16
    asr	w4,	w24,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#412
    lsl	w3,	w4,	#30
    movk	fp,	#2,	lsl #16
    sub	w18,	w19,	w3
    ldr	w19,	[sp, fp]

    add	w25,	w19,	#1
    add	w14,	w9,	w18
    cmp	w25,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w27,	w17
    mov	w3,	w16
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#428
    add	w15,	w14,	w1
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    sub	w1,	w27,	w2
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    add	w2,	w12,	w1
    add	w4,	w2,	w15
    sub	w15,	w15,	w4
    add	w9,	w15,	w2
    sub	w15,	w9,	w4
    sub	w18,	w15,	w9
    add	w27,	w18,	w4
    sub	w20,	w27,	w9
    mov	w24,	w20
    b	main_347

main_364:
    cmp	w25,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    mov	w16,	w7
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#428
    add	w17,	w14,	w20
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w4,	w17
    movk	fp,	#2,	lsl #16
    add	w1,	w9,	w14
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w1,	w1,	w17
    ldr	w24,	[sp, fp]

    add	w3,	w19,	w1
    sub	w4,	w1,	w3
    add	w15,	w4,	w24
    sub	w17,	w15,	w3
    b	main_375

main_378:
    cmp	w25,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w22,	w14,	w22
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    add	w16,	w3,	w7
    movk	fp,	#2,	lsl #16
    add	w9,	w16,	w22
    ldr	w24,	[sp, fp]

    sub	w2,	w22,	w9
    add	w4,	w2,	w16
    sub	w17,	w4,	w9
    sub	w3,	w17,	w4
    add	w1,	w3,	w9
    add	w9,	w24,	w14
    sub	w3,	w1,	w4
    add	w1,	w9,	w3
    sub	w7,	w3,	w1
    add	w15,	w7,	w9
    sub	w16,	w15,	w1
    sub	w27,	w16,	w15
    add	w2,	w27,	w1
    sub	w16,	w2,	w15
    mov	w2,	w20
    mov	w18,	w16
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    add	w17,	w14,	w4
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    sub	w4,	w20,	w17
    movk	fp,	#2,	lsl #16
    add	w7,	w4,	w14
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w3,	w7,	w17
    ldr	w12,	[sp, fp]

    add	w17,	w1,	w3
    sub	w7,	w3,	w17
    add	w3,	w7,	w12
    sub	w17,	w3,	w17
    mov	w18,	w17

main_398:
    mov	w17,	w18
    mov	w16,	w2

main_375:
    mov	w24,	w17
    mov	w3,	w16

main_347:
    lsl	w7,	w10,	#5
    asr	w18,	w10,	#31
    lsl	w22,	w25,	#2
    movz	fp,	#416
    lsr	w2,	w18,	#27
    movk	fp,	#2,	lsl #16
    add	w9,	w10,	w2
    asr	w17,	w9,	#5
    lsl	w1,	w17,	#5
    mov	x17,	x22
    sub	w15,	w10,	w1
    add	x17,	sp,	x17
    add	x17,	x17,	#16
    ldr	w1,	[x17]

    ldr	w22,	[sp, fp]

    movz	fp,	#428
    add	w9,	w15,	w22
    movk	fp,	#2,	lsl #16
    add	w9,	w9,	w7
    ldr	w8,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w7,	w9,	w24
    ldr	w26,	[sp, fp]

    add	w24,	w25,	#1
    movz	fp,	#428
    asr	w16,	w26,	#31
    add	w7,	w7,	w3
    movk	fp,	#2,	lsl #16
    lsr	w20,	w16,	#2
    ldr	w2,	[sp, fp]

    add	w22,	w7,	w1
    movz	fp,	#428
    add	w3,	w2,	w20
    lsl	w7,	w8,	#30
    movk	fp,	#2,	lsl #16
    asr	w3,	w3,	#30
    ldr	w5,	[sp, fp]

    lsl	w4,	w3,	#30
    sub	w15,	w5,	w4
    add	w20,	w7,	w15
    cmp	w24,	#80
    blt	main_276

main_433:
    add	w17,	w22,	w11
    add	w18,	w10,	w13
    add	w25,	w20,	w0
    add	w27,	w14,	w21
    movz	fp,	#432
    add	w4,	w28,	#64
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w8,	w7,	w6
    cmp	w4,	w23
    blt	main_62

main_441:
    movz	fp,	#500
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#508
    str	w17,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#452
    str	w18,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#444
    str	w25,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#596
    str	w27,	[x21]

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

    mov	w0,	w6
    b	main_28

main_62:
    mov	w11,	w17
    mov	w13,	w18
    mov	w0,	w25
    mov	w21,	w27
    mov	w6,	w8
    mov	w28,	w4
    b	main_63

main_276:
    mov	w19,	w22
    movz	fp,	#428
    mov	w4,	w10
    mov	w12,	w14
    mov	w8,	w24
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    mov	w12,	w20
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#412
    mov	w3,	w9
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

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


