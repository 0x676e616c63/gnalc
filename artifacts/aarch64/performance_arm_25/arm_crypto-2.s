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
    movz	fp,	#336
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
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#460
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

    movz	fp,	#620
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#596
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#604
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#588
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#500
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
    movz	fp,	#620
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

    ldr	x0,	[sp, fp]

    add	w1,	w16,	#3
    add	w25,	w16,	#2
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x21,	x0,	x2
    movz	w2,	#0
    str	w22,	[x21]

    ldr	x1,	[sp, fp]

    movz	fp,	#612
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    add	w25,	w16,	#4
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w17,	#8961
    movz	w27,	#43913
    movz	w3,	#56574
    movz	w5,	#21622
    movk	w17,	#26437,	lsl #16
    movk	w27,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w5,	#4146,	lsl #16
    mov	w10,	w17
    mov	w28,	w27
    mov	w13,	w3
    mov	w20,	w5
    movz	w17,	#57840
    movz	w27,	#0
    movk	w17,	#50130,	lsl #16
    mov	w6,	w17

main_63:
    movz	w17,	#0
    mov	w21,	w27
    mov	w12,	w17

main_70:
    cmp	w12,	#14
    bge	main_215

main_74:
    lsl	w16,	w12,	#2
    lsl	w3,	w21,	#2
    movz	fp,	#436
    add	w11,	w21,	#2
    add	w12,	w12,	#1
    mov	x16,	x16
    movk	fp,	#2,	lsl #16
    add	x16,	sp,	x16
    lsl	w5,	w11,	#2
    ldr	x0,	[sp, fp]

    add	w11,	w21,	#4
    add	x16,	x16,	#16
    movz	fp,	#436
    add	x2,	x0,	x3
    movk	fp,	#2,	lsl #16
    lsl	w24,	w11,	#2
    add	w0,	w21,	#1
    ldr	w4,	[x2]

    lsl	w17,	w0,	#2
    ldr	x9,	[sp, fp]

    lsl	w18,	w4,	#24
    movz	fp,	#436
    add	x1,	x9,	x17
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x1]

    ldr	x23,	[sp, fp]

    lsl	w4,	w3,	#16
    movz	fp,	#436
    add	w7,	w4,	w18
    movk	fp,	#2,	lsl #16
    add	x18,	x23,	x5
    ldr	w0,	[x18]

    ldr	x26,	[sp, fp]

    lsl	w2,	w0,	#8
    movz	fp,	#436
    add	w2,	w7,	w2
    movk	fp,	#2,	lsl #16
    add	w7,	w21,	#3
    lsl	w14,	w7,	#2
    add	x8,	x26,	x14
    add	w14,	w11,	#4
    ldr	w18,	[x8]

    lsl	w8,	w12,	#2
    add	w5,	w2,	w18
    mov	x4,	x8
    add	x4,	sp,	x4
    str	w5,	[x16]

    ldr	x8,	[sp, fp]

    add	x4,	x4,	#16
    movz	fp,	#436
    add	x22,	x8,	x24
    movk	fp,	#2,	lsl #16
    add	w24,	w11,	#1
    ldr	w1,	[x22]

    lsl	w17,	w24,	#2
    lsl	w19,	w1,	#24
    ldr	x1,	[sp, fp]

    movz	fp,	#436
    add	x0,	x1,	x17
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    ldr	x3,	[sp, fp]

    lsl	w7,	w5,	#16
    movz	fp,	#436
    add	w5,	w12,	#1
    add	w16,	w7,	w19
    movk	fp,	#2,	lsl #16
    add	w19,	w11,	#2
    lsl	w7,	w19,	#2
    add	x0,	x3,	x7
    add	w7,	w11,	#3
    ldr	w2,	[x0]

    lsl	w17,	w7,	#2
    ldr	x9,	[sp, fp]

    lsl	w3,	w2,	#8
    lsl	w7,	w5,	#2
    movz	fp,	#436
    add	x9,	x9,	x17
    lsl	w2,	w14,	#2
    add	w18,	w16,	w3
    movk	fp,	#2,	lsl #16
    add	w17,	w14,	#4
    ldr	w19,	[x9]

    add	w3,	w18,	w19
    str	w3,	[x4]

    ldr	x0,	[sp, fp]

    mov	x3,	x7
    movz	fp,	#436
    add	x1,	x0,	x2
    add	w7,	w14,	#1
    add	x3,	sp,	x3
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x1]

    lsl	w12,	w7,	#2
    add	x3,	x3,	#16
    ldr	x18,	[sp, fp]

    lsl	w1,	w4,	#24
    movz	fp,	#436
    add	x8,	x18,	x12
    add	w4,	w14,	#3
    movk	fp,	#2,	lsl #16
    add	w18,	w14,	#2
    ldr	w12,	[x8]

    lsl	w15,	w12,	#16
    lsl	w24,	w18,	#2
    add	w12,	w15,	w1
    ldr	x18,	[sp, fp]

    movz	fp,	#436
    add	x19,	x18,	x24
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x19]

    lsl	w0,	w24,	#8
    lsl	w24,	w17,	#2
    add	w2,	w12,	w0
    add	w12,	w5,	#1
    lsl	w0,	w4,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x19,	x4,	x0
    movk	fp,	#2,	lsl #16
    lsl	w0,	w12,	#2
    mov	x5,	x0
    ldr	w1,	[x19]

    add	x5,	sp,	x5
    add	w7,	w2,	w1
    add	x5,	x5,	#16
    str	w7,	[x3]

    ldr	x7,	[sp, fp]

    movz	fp,	#436
    add	x22,	x7,	x24
    movk	fp,	#2,	lsl #16
    add	w7,	w17,	#1
    ldr	w1,	[x22]

    lsl	w11,	w7,	#2
    add	w22,	w17,	#3
    ldr	x3,	[sp, fp]

    lsl	w0,	w1,	#24
    movz	fp,	#436
    add	x8,	x3,	x11
    movk	fp,	#2,	lsl #16
    add	w3,	w17,	#2
    ldr	w15,	[x8]

    lsl	w7,	w3,	#2
    ldr	x14,	[sp, fp]

    lsl	w19,	w15,	#16
    movz	fp,	#436
    add	x4,	x14,	x7
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w0
    add	w7,	w17,	#4
    ldr	w11,	[x4]

    add	w9,	w7,	#1
    add	w4,	w12,	#1
    ldr	x14,	[sp, fp]

    lsl	w16,	w11,	#8
    movz	fp,	#436
    lsl	w1,	w4,	#2
    lsl	w11,	w9,	#2
    add	w2,	w0,	w16
    movk	fp,	#2,	lsl #16
    mov	x16,	x1
    lsl	w0,	w22,	#2
    lsl	w1,	w7,	#2
    add	x16,	sp,	x16
    add	w22,	w4,	#1
    add	x24,	x14,	x0
    add	x16,	x16,	#16
    ldr	w3,	[x24]

    add	w24,	w7,	#2
    add	w3,	w2,	w3
    lsl	w24,	w24,	#2
    str	w3,	[x5]

    ldr	x18,	[sp, fp]

    movz	fp,	#436
    add	x0,	x18,	x1
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x0]

    ldr	x18,	[sp, fp]

    lsl	w3,	w2,	#24
    movz	fp,	#436
    add	x12,	x18,	x11
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x12]

    ldr	x12,	[sp, fp]

    lsl	w18,	w17,	#16
    movz	fp,	#436
    add	x0,	x12,	x24
    add	w17,	w18,	w3
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x0]

    ldr	x23,	[sp, fp]

    add	w0,	w7,	#3
    lsl	w14,	w5,	#8
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    lsl	w2,	w0,	#2
    add	w9,	w17,	w14
    lsl	w14,	w22,	#2
    add	x1,	x23,	x2
    mov	x11,	x14
    add	x11,	sp,	x11
    ldr	w3,	[x1]

    add	x11,	x11,	#16
    add	w1,	w7,	#4
    add	w3,	w9,	w3
    add	w7,	w1,	#2
    lsl	w19,	w1,	#2
    add	w9,	w1,	#1
    str	w3,	[x16]

    ldr	x4,	[sp, fp]

    movz	fp,	#436
    add	x16,	x4,	x19
    lsl	w5,	w9,	#2
    movk	fp,	#2,	lsl #16
    lsl	w4,	w7,	#2
    add	w9,	w22,	#1
    ldr	w21,	[x16]

    ldr	x24,	[sp, fp]

    lsl	w3,	w21,	#24
    movz	fp,	#436
    add	x15,	x24,	x5
    add	w21,	w1,	#3
    movk	fp,	#2,	lsl #16
    lsl	w5,	w9,	#2
    add	w1,	w1,	#4
    ldr	w0,	[x15]

    ldr	x8,	[sp, fp]

    lsl	w2,	w0,	#16
    movz	fp,	#436
    add	x8,	x8,	x4
    add	w3,	w2,	w3
    movk	fp,	#2,	lsl #16
    mov	x4,	x5
    ldr	w16,	[x8]

    add	x4,	sp,	x4
    ldr	x8,	[sp, fp]

    lsl	w17,	w16,	#8
    movz	fp,	#436
    add	x4,	x4,	#16
    add	w18,	w3,	w17
    movk	fp,	#2,	lsl #16
    lsl	w3,	w21,	#2
    add	w21,	w1,	#4
    add	x0,	x8,	x3
    ldr	w7,	[x0]

    lsl	w0,	w1,	#2
    add	w24,	w18,	w7
    add	w7,	w1,	#3
    add	w18,	w1,	#1
    str	w24,	[x11]

    lsl	w14,	w7,	#2
    lsl	w8,	w18,	#2
    add	w11,	w1,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#436
    add	x17,	x16,	x0
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x17]

    ldr	x15,	[sp, fp]

    lsl	w17,	w3,	#24
    movz	fp,	#436
    add	x19,	x15,	x8
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x19]

    lsl	w19,	w11,	#2
    lsl	w0,	w24,	#16
    add	w3,	w0,	w17
    ldr	x17,	[sp, fp]

    movz	fp,	#436
    add	x12,	x17,	x19
    movk	fp,	#2,	lsl #16
    ldr	w19,	[x12]

    lsl	w0,	w19,	#8
    ldr	x19,	[sp, fp]

    add	w2,	w3,	w0
    add	x11,	x19,	x14
    ldr	w15,	[x11]

    add	w5,	w2,	w15
    add	w2,	w9,	#1
    mov	w12,	w2
    str	w5,	[x4]

    b	main_70

main_215:
    mov	w18,	w21
    mov	w2,	w12

main_217:
    lsl	w5,	w2,	#2
    lsl	w12,	w18,	#2
    movz	fp,	#436
    add	w0,	w18,	#2
    add	w22,	w2,	#1
    mov	x4,	x5
    movk	fp,	#2,	lsl #16
    add	x4,	sp,	x4
    lsl	w16,	w0,	#2
    ldr	x3,	[sp, fp]

    add	x4,	x4,	#16
    movz	fp,	#436
    add	x15,	x3,	x12
    movk	fp,	#2,	lsl #16
    add	w3,	w18,	#1
    ldr	w17,	[x15]

    lsl	w24,	w3,	#2
    ldr	x1,	[sp, fp]

    lsl	w21,	w17,	#24
    movz	fp,	#436
    add	x7,	x1,	x24
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x7]

    ldr	x3,	[sp, fp]

    lsl	w14,	w9,	#16
    movz	fp,	#436
    add	x1,	x3,	x16
    add	w14,	w14,	w21
    movk	fp,	#2,	lsl #16
    add	w3,	w18,	#3
    ldr	w7,	[x1]

    lsl	w8,	w7,	#8
    lsl	w19,	w3,	#2
    ldr	x7,	[sp, fp]

    add	w9,	w14,	w8
    add	x7,	x7,	x19
    add	w19,	w18,	#4
    ldr	w15,	[x7]

    add	w21,	w9,	w15
    str	w21,	[x4]

    cmp	w22,	#16
    bge	main_241

main_216:
    mov	w18,	w19
    mov	w2,	w22
    b	main_217

main_241:
    mov	w14,	w22
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    cmp	w8,	#80
    bge	main_275

main_245:
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#452
    lsl	w19,	w9,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x19
    add	x17,	sp,	x17
    ldr	w23,	[sp, fp]

    movz	fp,	#452
    sub	w24,	w23,	#3
    add	x17,	x17,	#16
    movk	fp,	#2,	lsl #16
    lsl	w2,	w24,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    ldr	w2,	[sp, fp]

    movz	fp,	#452
    sub	w4,	w2,	#8
    movk	fp,	#2,	lsl #16
    lsl	w7,	w4,	#2
    mov	x5,	x7
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w9,	[x5]

    add	w5,	w9,	w3
    sub	w12,	w3,	w5
    ldr	w3,	[sp, fp]

    movz	fp,	#452
    sub	w21,	w3,	#14
    add	w16,	w12,	w9
    movk	fp,	#2,	lsl #16
    lsl	w0,	w21,	#2
    sub	w5,	w16,	w5
    mov	x22,	x0
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    ldr	w2,	[x22]

    ldr	w4,	[sp, fp]

    add	w24,	w2,	w5
    movz	fp,	#452
    sub	w0,	w4,	#16
    movk	fp,	#2,	lsl #16
    sub	w1,	w5,	w24
    add	w8,	w1,	w2
    lsl	w2,	w0,	#2
    mov	x1,	x2
    sub	w21,	w8,	w24
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w3,	[x1]

    add	w2,	w3,	w21
    sub	w8,	w21,	w2
    add	w11,	w8,	w3
    sub	w15,	w11,	w2
    asr	w0,	w15,	#31
    lsl	w9,	w15,	#1
    lsr	w1,	w0,	#31
    add	w2,	w15,	w1
    asr	w12,	w2,	#1
    lsl	w14,	w12,	#1
    sub	w3,	w15,	w14
    add	w4,	w9,	w3
    str	w4,	[x17]

    ldr	w16,	[sp, fp]

    movz	fp,	#452
    add	w5,	w16,	#1
    movk	fp,	#2,	lsl #16
    mov	w7,	w5
    str	w7,	[sp, fp]

    b	main_242

main_275:
    mov	w23,	w10
    movz	fp,	#428
    mov	w1,	w28
    mov	w16,	w13
    mov	w9,	w20
    mov	w0,	w6
    movz	w3,	#0
    movk	fp,	#2,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    mov	w1,	w3
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]


main_277:
    movz	w2,	#48348
    movz	w9,	#60289
    movz	w24,	#31129
    movz	w21,	#65535
    movz	fp,	#412
    movk	w2,	#36635,	lsl #16
    movk	w9,	#28377,	lsl #16
    movk	w24,	#23170,	lsl #16
    movk	w21,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w18,	w2
    mov	w5,	w9
    mov	w15,	w24
    mov	w16,	w21
    ldr	w14,	[sp, fp]

    movz	w2,	#49414
    movk	w2,	#51810,	lsl #16
    mov	w1,	w2
    cmp	w14,	#20
    bge	main_296

main_285:
    movz	fp,	#424
    mov	w2,	w16
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#424
    add	w3,	w22,	w17
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#416
    sub	w2,	w2,	w11
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w9,	w19,	w2
    add	w12,	w9,	w3
    sub	w8,	w3,	w12
    add	w22,	w8,	w9
    sub	w17,	w22,	w12
    sub	w2,	w17,	w22
    add	w8,	w2,	w12
    sub	w8,	w8,	w22
    mov	w22,	w15
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
    ldr	w22,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#424
    add	w8,	w26,	w22
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w21,	w8
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#416
    add	w22,	w9,	w7
    movk	fp,	#2,	lsl #16
    sub	w22,	w22,	w8
    ldr	w4,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w3,	w4,	w22
    ldr	w26,	[sp, fp]

    sub	w2,	w22,	w3
    mov	w22,	w5
    add	w2,	w2,	w26
    sub	w8,	w2,	w3
    mov	w9,	w8
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    cmp	w21,	#60
    bge	main_327

main_309:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#416
    add	w22,	w11,	w4
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    add	w8,	w8,	w21
    movk	fp,	#2,	lsl #16
    add	w21,	w8,	w22
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w12,	w22,	w21
    ldr	w19,	[sp, fp]

    add	w3,	w12,	w8
    sub	w2,	w3,	w21
    sub	w8,	w2,	w3
    add	w12,	w8,	w21
    sub	w8,	w12,	w3
    add	w12,	w17,	w19
    add	w21,	w12,	w8
    sub	w22,	w8,	w21
    add	w17,	w22,	w12
    mov	w22,	w18
    sub	w3,	w17,	w21
    sub	w2,	w3,	w17
    add	w8,	w2,	w21
    sub	w8,	w8,	w17
    mov	w9,	w8
    b	main_413

main_327:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w3,	w19,	w8
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#432
    sub	w9,	w11,	w3
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#416
    add	w22,	w9,	w21
    movk	fp,	#2,	lsl #16
    sub	w3,	w22,	w3
    ldr	w19,	[sp, fp]

    mov	w22,	w1
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w2,	w19,	w3
    ldr	w9,	[sp, fp]

    sub	w17,	w3,	w2
    add	w9,	w17,	w9
    sub	w8,	w9,	w2
    mov	w9,	w8

main_413:
    mov	w8,	w9

main_416:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    lsl	w12,	w2,	#5
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#428
    asr	w9,	w11,	#31
    movk	fp,	#2,	lsl #16
    lsr	w21,	w9,	#27
    ldr	w17,	[sp, fp]

    movz	fp,	#428
    add	w9,	w17,	w21
    movk	fp,	#2,	lsl #16
    asr	w9,	w9,	#5
    ldr	w24,	[sp, fp]

    movz	fp,	#412
    lsl	w17,	w9,	#5
    movk	fp,	#2,	lsl #16
    sub	w9,	w24,	w17
    ldr	w23,	[sp, fp]

    movz	fp,	#424
    lsl	w2,	w23,	#2
    movk	fp,	#2,	lsl #16
    mov	x17,	x2
    add	w21,	w12,	w9
    add	x17,	sp,	x17
    add	w21,	w21,	w0
    add	x17,	x17,	#16
    add	w8,	w21,	w8
    ldr	w9,	[x17]

    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w8,	w8,	w22
    movk	fp,	#2,	lsl #16
    add	w9,	w8,	w9
    lsl	w8,	w19,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    asr	w3,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w12,	w3,	#2
    ldr	w14,	[sp, fp]

    movz	fp,	#424
    add	w17,	w14,	w12
    movk	fp,	#2,	lsl #16
    asr	w3,	w17,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#412
    lsl	w3,	w3,	#30
    movk	fp,	#2,	lsl #16
    sub	w12,	w19,	w3
    ldr	w19,	[sp, fp]

    add	w24,	w19,	#1
    add	w12,	w8,	w12
    cmp	w24,	#20
    bge	main_364

main_336:
    movz	fp,	#428
    mov	w2,	w16
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#428
    add	w17,	w12,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    sub	w0,	w2,	w1
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    add	w1,	w11,	w0
    add	w3,	w1,	w17
    sub	w14,	w17,	w3
    add	w8,	w14,	w1
    sub	w14,	w8,	w3
    sub	w17,	w14,	w8
    mov	w14,	w15
    add	w21,	w17,	w3
    sub	w18,	w21,	w8
    mov	w21,	w18
    b	main_347

main_364:
    cmp	w24,	#40
    bge	main_378

main_366:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w16,	w12,	w18
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#432
    sub	w8,	w3,	w16
    movk	fp,	#2,	lsl #16
    add	w0,	w8,	w12
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w16
    ldr	w22,	[sp, fp]

    add	w2,	w17,	w0
    mov	w17,	w5
    sub	w3,	w0,	w2
    add	w14,	w3,	w22
    sub	w16,	w14,	w2
    b	main_375

main_378:
    cmp	w24,	#60
    bge	main_401

main_380:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#428
    add	w19,	w12,	w21
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    add	w15,	w2,	w5
    movk	fp,	#2,	lsl #16
    add	w8,	w15,	w19
    ldr	w22,	[sp, fp]

    sub	w1,	w19,	w8
    add	w3,	w1,	w15
    mov	w1,	w18
    sub	w16,	w3,	w8
    sub	w2,	w16,	w3
    add	w0,	w2,	w8
    add	w8,	w22,	w12
    sub	w2,	w0,	w3
    add	w0,	w8,	w2
    sub	w5,	w2,	w0
    add	w14,	w5,	w8
    sub	w15,	w14,	w0
    sub	w21,	w15,	w14
    add	w0,	w21,	w0
    sub	w15,	w0,	w14
    mov	w17,	w15
    b	main_398

main_401:
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    add	w16,	w12,	w3
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#432
    sub	w3,	w18,	w16
    movk	fp,	#2,	lsl #16
    add	w5,	w3,	w12
    ldr	w0,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    sub	w2,	w5,	w16
    ldr	w11,	[sp, fp]

    add	w16,	w0,	w2
    sub	w5,	w2,	w16
    add	w0,	w5,	w11
    sub	w16,	w0,	w16
    mov	w17,	w16

main_398:
    mov	w16,	w17
    mov	w17,	w1

main_375:
    mov	w21,	w16
    mov	w14,	w17

main_347:
    lsl	w15,	w9,	#5
    asr	w1,	w9,	#31
    lsl	w19,	w24,	#2
    movz	fp,	#416
    lsr	w2,	w1,	#27
    mov	x16,	x19
    movk	fp,	#2,	lsl #16
    add	x16,	sp,	x16
    add	w3,	w9,	w2
    add	x16,	x16,	#16
    asr	w3,	w3,	#5
    ldr	w0,	[x16]

    lsl	w5,	w3,	#5
    ldr	w19,	[sp, fp]

    sub	w5,	w9,	w5
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w3,	w5,	w19
    ldr	w7,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    add	w5,	w3,	w15
    ldr	w23,	[sp, fp]

    movz	fp,	#428
    asr	w15,	w23,	#31
    add	w3,	w5,	w21
    movk	fp,	#2,	lsl #16
    lsr	w19,	w15,	#2
    ldr	w1,	[sp, fp]

    add	w5,	w3,	w14
    movz	fp,	#428
    add	w2,	w1,	w19
    movk	fp,	#2,	lsl #16
    add	w18,	w5,	w0
    ldr	w4,	[sp, fp]

    asr	w2,	w2,	#30
    lsl	w5,	w7,	#30
    lsl	w3,	w2,	#30
    add	w2,	w24,	#1
    sub	w14,	w4,	w3
    add	w22,	w5,	w14
    cmp	w2,	#80
    blt	main_276

main_433:
    add	w15,	w18,	w10
    add	w9,	w9,	w28
    add	w24,	w12,	w20
    movz	fp,	#432
    add	w5,	w27,	#64
    add	w18,	w22,	w13
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    add	w7,	w7,	w6
    cmp	w5,	w25
    blt	main_62

main_441:
    movz	fp,	#596
    movz	w28,	#0
    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#604
    str	w15,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#588
    str	w9,	[x2]

    movk	fp,	#2,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#492
    str	w18,	[x13]

    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#500
    str	w24,	[x21]

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
    mov	w10,	w15
    mov	w28,	w9
    mov	w13,	w18
    mov	w20,	w24
    mov	w6,	w7
    mov	w27,	w5
    b	main_63

main_276:
    mov	w17,	w18
    movz	fp,	#428
    mov	w24,	w9
    mov	w14,	w12
    mov	w7,	w2
    mov	w11,	w22
    movk	fp,	#2,	lsl #16
    str	w17,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w24,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#412
    mov	w0,	w9
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#460
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


