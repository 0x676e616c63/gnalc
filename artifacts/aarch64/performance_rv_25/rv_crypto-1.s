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
    mov	w26,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	w6,	#0
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#420
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
    movz	fp,	#476
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
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#412
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#580
    movk	fp,	#2,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#588
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#572
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w26
    movz	fp,	#564
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#384
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w1
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_31:
    movz	w18,	#32000
    cmp	w5,	w18
    bge	main_45

main_35:
    lsl	w15,	w5,	#2
    movz	fp,	#460
    add	w5,	w5,	#1
    mov	x13,	x15
    movk	fp,	#2,	lsl #16
    add	x13,	sp,	x13
    ldr	w0,	[sp, fp]

    add	x13,	x13,	#336
    movz	fp,	#460
    lsl	w17,	w0,	#13
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#460
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
    movz	fp,	#412
    movz	w1,	#32001
    movk	fp,	#2,	lsl #16
    mov	w16,	w1
    ldr	x12,	[sp, fp]

    str	w21,	[x12]


main_46:
    asr	w24,	w16,	#31
    lsr	w25,	w24,	#26
    add	w26,	w16,	w25
    asr	w0,	w26,	#6
    lsl	w2,	w0,	#6
    sub	w25,	w16,	w2
    cmp	w25,	#60
    beq	main_53

main_50:
    lsl	w3,	w16,	#2
    movz	fp,	#476
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
    movz	fp,	#476
    movz	w27,	#0
    add	w22,	w16,	#1
    movz	w25,	#0
    movz	w23,	#125
    add	w26,	w16,	#4
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#476
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    str	w27,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#476
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    ldr	x0,	[sp, fp]

    add	w25,	w16,	#2
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    add	w0,	w16,	#3
    str	w23,	[x22]

    lsl	w25,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#404
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w22,	#0
    movz	w17,	#8961
    movz	w25,	#43913
    movz	w3,	#56574
    movz	w5,	#21622
    movz	w19,	#57840
    mov	w1,	w22
    movk	w17,	#26437,	lsl #16
    movk	w25,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w5,	#4146,	lsl #16
    movk	w19,	#50130,	lsl #16
    mov	w11,	w17
    mov	w16,	w3
    mov	w23,	w19

main_63:
    movz	w19,	#0
    mov	w24,	w1
    mov	w13,	w19

main_70:
    cmp	w13,	#14
    bge	main_215

main_74:
    lsl	w19,	w13,	#2
    lsl	w6,	w24,	#2
    movz	fp,	#476
    add	w14,	w24,	#2
    add	w13,	w13,	#1
    mov	x18,	x19
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    lsl	w9,	w14,	#2
    ldr	x0,	[sp, fp]

    add	w14,	w24,	#4
    add	x18,	x18,	#16
    movz	fp,	#476
    add	x4,	x0,	x6
    movk	fp,	#2,	lsl #16
    add	w0,	w24,	#1
    ldr	w8,	[x4]

    lsl	w21,	w0,	#2
    ldr	x12,	[sp, fp]

    lsl	w17,	w8,	#24
    movz	fp,	#476
    add	x3,	x12,	x21
    movk	fp,	#2,	lsl #16
    add	w21,	w14,	#2
    ldr	w6,	[x3]

    ldr	x27,	[sp, fp]

    lsl	w8,	w6,	#16
    movz	fp,	#476
    add	x22,	x27,	x9
    add	w10,	w8,	w17
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x22]

    ldr	x0,	[sp, fp]

    lsl	w3,	w2,	#8
    movz	fp,	#476
    add	w4,	w10,	w3
    movk	fp,	#2,	lsl #16
    add	w3,	w13,	#1
    add	w10,	w24,	#3
    lsl	w15,	w10,	#2
    lsl	w10,	w13,	#2
    add	x12,	x0,	x15
    mov	x8,	x10
    lsl	w0,	w14,	#2
    add	x8,	sp,	x8
    ldr	w19,	[x12]

    add	x8,	x8,	#16
    add	w9,	w4,	w19
    str	w9,	[x18]

    ldr	x12,	[sp, fp]

    movz	fp,	#476
    add	x27,	x12,	x0
    movk	fp,	#2,	lsl #16
    add	w0,	w14,	#1
    ldr	w2,	[x27]

    lsl	w18,	w0,	#2
    lsl	w24,	w2,	#24
    ldr	x2,	[sp, fp]

    movz	fp,	#476
    add	x2,	x2,	x18
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x2]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#476
    add	w18,	w10,	w24
    movk	fp,	#2,	lsl #16
    lsl	w10,	w21,	#2
    add	x0,	x7,	x10
    add	w10,	w14,	#3
    ldr	w4,	[x0]

    lsl	w19,	w10,	#2
    ldr	x12,	[sp, fp]

    lsl	w6,	w4,	#8
    movz	fp,	#476
    add	x12,	x12,	x19
    add	w4,	w14,	#4
    add	w21,	w18,	w6
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x12]

    add	w9,	w4,	#1
    lsl	w12,	w3,	#2
    add	w7,	w21,	w24
    mov	x10,	x12
    add	w24,	w4,	#2
    lsl	w27,	w9,	#2
    add	x10,	sp,	x10
    str	w7,	[x8]

    ldr	x0,	[sp, fp]

    lsl	w7,	w4,	#2
    add	x10,	x10,	#16
    movz	fp,	#476
    add	x6,	x0,	x7
    movk	fp,	#2,	lsl #16
    lsl	w0,	w24,	#2
    ldr	w8,	[x6]

    ldr	x18,	[sp, fp]

    lsl	w6,	w8,	#24
    movz	fp,	#476
    add	x14,	x18,	x27
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    ldr	x19,	[sp, fp]

    lsl	w18,	w17,	#16
    movz	fp,	#476
    add	x0,	x19,	x0
    add	w21,	w18,	w6
    movk	fp,	#2,	lsl #16
    add	w18,	w4,	#3
    ldr	w6,	[x0]

    ldr	x8,	[sp, fp]

    lsl	w13,	w6,	#8
    lsl	w0,	w18,	#2
    movz	fp,	#476
    add	w6,	w21,	w13
    movk	fp,	#2,	lsl #16
    add	x21,	x8,	x0
    ldr	w7,	[x21]

    add	w21,	w3,	#1
    add	w13,	w6,	w7
    add	w7,	w4,	#4
    str	w13,	[x10]

    add	w9,	w21,	#1
    lsl	w0,	w21,	#2
    add	w6,	w7,	#2
    lsl	w24,	w7,	#2
    ldr	x10,	[sp, fp]

    mov	x27,	x0
    movz	fp,	#476
    lsl	w14,	w6,	#2
    add	x22,	x10,	x24
    add	x27,	sp,	x27
    movk	fp,	#2,	lsl #16
    add	w10,	w7,	#1
    ldr	w2,	[x22]

    add	x27,	x27,	#16
    add	w22,	w7,	#3
    lsl	w3,	w10,	#2
    ldr	x12,	[sp, fp]

    lsl	w4,	w2,	#24
    movz	fp,	#476
    add	x12,	x12,	x3
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    ldr	x12,	[sp, fp]

    lsl	w18,	w15,	#16
    movz	fp,	#476
    add	x10,	x12,	x14
    add	w0,	w18,	w4
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x10]

    add	w10,	w7,	#4
    lsl	w14,	w13,	#8
    add	w4,	w0,	w14
    add	w13,	w10,	#1
    ldr	x14,	[sp, fp]

    lsl	w0,	w22,	#2
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    lsl	w13,	w13,	#2
    add	x24,	x14,	x0
    ldr	w3,	[x24]

    add	w8,	w4,	w3
    lsl	w3,	w9,	#2
    add	w9,	w9,	#1
    mov	x19,	x3
    str	w8,	[x27]

    lsl	w3,	w10,	#2
    add	x19,	sp,	x19
    ldr	x20,	[sp, fp]

    movz	fp,	#476
    add	x0,	x20,	x3
    movk	fp,	#2,	lsl #16
    add	x19,	x19,	#16
    ldr	w4,	[x0]

    add	w0,	w10,	#2
    ldr	x18,	[sp, fp]

    lsl	w6,	w4,	#24
    movz	fp,	#476
    add	x14,	x18,	x13
    movk	fp,	#2,	lsl #16
    lsl	w0,	w0,	#2
    add	w13,	w10,	#4
    ldr	w17,	[x14]

    lsl	w24,	w13,	#2
    add	w14,	w13,	#2
    ldr	x15,	[sp, fp]

    lsl	w21,	w17,	#16
    movz	fp,	#476
    add	x2,	x15,	x0
    add	w21,	w21,	w6
    movk	fp,	#2,	lsl #16
    add	w0,	w10,	#3
    ldr	w8,	[x2]

    ldr	x27,	[sp, fp]

    lsl	w15,	w8,	#8
    lsl	w4,	w0,	#2
    movz	fp,	#476
    add	w12,	w21,	w15
    movk	fp,	#2,	lsl #16
    add	x3,	x27,	x4
    add	w15,	w13,	#1
    lsl	w21,	w9,	#2
    ldr	w6,	[x3]

    add	w6,	w12,	w6
    lsl	w12,	w15,	#2
    str	w6,	[x19]

    ldr	x7,	[sp, fp]

    mov	x6,	x21
    movz	fp,	#476
    add	x22,	x7,	x24
    add	x6,	sp,	x6
    movk	fp,	#2,	lsl #16
    lsl	w7,	w14,	#2
    ldr	w27,	[x22]

    add	x6,	x6,	#16
    ldr	x28,	[sp, fp]

    lsl	w3,	w27,	#24
    movz	fp,	#476
    add	x18,	x28,	x12
    add	w27,	w13,	#3
    movk	fp,	#2,	lsl #16
    add	w13,	w13,	#4
    ldr	w0,	[x18]

    ldr	x12,	[sp, fp]

    lsl	w4,	w0,	#16
    movz	fp,	#476
    add	x17,	x12,	x7
    add	w4,	w4,	w3
    movk	fp,	#2,	lsl #16
    lsl	w3,	w27,	#2
    ldr	w21,	[x17]

    ldr	x14,	[sp, fp]

    lsl	w24,	w21,	#8
    movz	fp,	#476
    add	x2,	x14,	x3
    add	w21,	w4,	w24
    movk	fp,	#2,	lsl #16
    add	w24,	w13,	#4
    ldr	w10,	[x2]

    add	w2,	w9,	#1
    add	w0,	w21,	w10
    lsl	w9,	w2,	#2
    str	w0,	[x6]

    mov	x4,	x9
    ldr	x17,	[sp, fp]

    lsl	w0,	w13,	#2
    add	w9,	w13,	#3
    add	x4,	sp,	x4
    movz	fp,	#476
    add	x18,	x17,	x0
    movk	fp,	#2,	lsl #16
    add	x4,	x4,	#16
    ldr	w6,	[x18]

    add	w18,	w13,	#1
    lsl	w17,	w6,	#24
    lsl	w14,	w18,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#476
    add	x21,	x18,	x14
    movk	fp,	#2,	lsl #16
    add	w14,	w13,	#2
    ldr	w27,	[x21]

    ldr	x18,	[sp, fp]

    lsl	w0,	w27,	#16
    movz	fp,	#476
    lsl	w27,	w14,	#2
    add	w3,	w0,	w17
    movk	fp,	#2,	lsl #16
    lsl	w14,	w9,	#2
    add	x15,	x18,	x27
    ldr	w21,	[x15]

    ldr	x20,	[sp, fp]

    lsl	w0,	w21,	#8
    add	x12,	x20,	x14
    add	w6,	w3,	w0
    add	w3,	w2,	#1
    ldr	w15,	[x12]

    mov	w13,	w3
    add	w8,	w6,	w15
    str	w8,	[x4]

    b	main_70

main_215:
    mov	w21,	w24
    mov	w6,	w13

main_217:
    lsl	w9,	w6,	#2
    lsl	w14,	w21,	#2
    movz	fp,	#476
    add	w3,	w21,	#1
    mov	x7,	x9
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    lsl	w0,	w3,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#476
    add	x15,	x4,	x14
    add	x7,	x7,	#16
    movk	fp,	#2,	lsl #16
    ldr	w22,	[x15]

    ldr	x4,	[sp, fp]

    lsl	w27,	w22,	#24
    movz	fp,	#476
    add	x10,	x4,	x0
    add	w22,	w21,	#4
    movk	fp,	#2,	lsl #16
    add	w0,	w21,	#2
    ldr	w13,	[x10]

    ldr	x4,	[sp, fp]

    lsl	w15,	w13,	#16
    lsl	w17,	w0,	#2
    movz	fp,	#476
    add	w15,	w15,	w27
    movk	fp,	#2,	lsl #16
    add	x3,	x4,	x17
    add	w27,	w6,	#1
    ldr	w10,	[x3]

    add	w3,	w21,	#3
    lsl	w12,	w10,	#8
    ldr	x10,	[sp, fp]

    add	w12,	w15,	w12
    lsl	w24,	w3,	#2
    add	x10,	x10,	x24
    ldr	w17,	[x10]

    add	w24,	w12,	w17
    str	w24,	[x7]

    cmp	w27,	#16
    bge	main_241

main_216:
    mov	w21,	w22
    mov	w6,	w27
    b	main_217

main_241:
    mov	w14,	w27
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#620
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#620
    lsl	w22,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x19,	x22
    add	x19,	sp,	x19
    ldr	w24,	[sp, fp]

    movz	fp,	#620
    sub	w27,	w24,	#3
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    lsl	w6,	w27,	#2
    mov	x4,	x6
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w7,	[x4]

    ldr	w3,	[sp, fp]

    movz	fp,	#620
    sub	w6,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w10,	w6,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w12,	[x9]

    ldr	w4,	[sp, fp]

    add	w9,	w12,	w7
    movz	fp,	#620
    sub	w24,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w14,	w7,	w9
    lsl	w0,	w24,	#2
    mov	x27,	x0
    add	w21,	w14,	w12
    add	x27,	sp,	x27
    sub	w9,	w21,	w9
    add	x27,	x27,	#16
    ldr	w6,	[x27]

    add	w0,	w6,	w9
    sub	w3,	w9,	w0
    add	w12,	w3,	w6
    ldr	w6,	[sp, fp]

    movz	fp,	#620
    sub	w24,	w12,	w0
    movk	fp,	#2,	lsl #16
    sub	w0,	w6,	#16
    lsl	w4,	w0,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    ldr	w6,	[x3]

    add	w4,	w6,	w24
    sub	w12,	w24,	w4
    add	w13,	w12,	w6
    sub	w18,	w13,	w4
    asr	w0,	w18,	#31
    lsl	w10,	w18,	#1
    lsr	w3,	w0,	#31
    add	w4,	w18,	w3
    asr	w13,	w4,	#1
    lsl	w15,	w13,	#1
    sub	w6,	w18,	w15
    add	w8,	w10,	w6
    str	w8,	[x19]

    ldr	w17,	[sp, fp]

    movz	fp,	#620
    add	w9,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w9
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w28,	w11
    movz	fp,	#468
    mov	w3,	w25
    mov	w18,	w16
    mov	w9,	w5
    mov	w4,	w23
    movz	w7,	#0
    movk	fp,	#2,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    mov	w3,	w7
    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]


main_277:
    movz	w3,	#48348
    movz	w14,	#60289
    movz	w2,	#31129
    movz	w22,	#65535
    movz	fp,	#452
    movk	w3,	#36635,	lsl #16
    movk	w14,	#28377,	lsl #16
    movk	w2,	#23170,	lsl #16
    movk	w22,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w21,	w3
    mov	w12,	w14
    mov	w18,	w2
    mov	w17,	w22
    ldr	w15,	[sp, fp]

    movz	w3,	#49414
    movk	w3,	#51810,	lsl #16
    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#464
    mov	w7,	w17
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#464
    add	w2,	w24,	w19
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#456
    sub	w0,	w7,	w14
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    add	w10,	w20,	w0
    add	w14,	w10,	w2
    sub	w8,	w2,	w14
    add	w27,	w8,	w10
    sub	w10,	w27,	w14
    sub	w0,	w10,	w27
    add	w8,	w0,	w14
    mov	w0,	w18
    sub	w8,	w8,	w27
    b	main_416

main_296:
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    cmp	w19,	#40
    bge	main_307

main_298:
    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#464
    add	w8,	w0,	w22
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#472
    sub	w14,	w20,	w8
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#456
    add	w27,	w14,	w7
    movk	fp,	#2,	lsl #16
    sub	w14,	w27,	w8
    ldr	w7,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    add	w2,	w7,	w14
    ldr	w28,	[sp, fp]

    sub	w0,	w14,	w2
    add	w0,	w0,	w28
    sub	w8,	w0,	w2
    mov	w0,	w12
    mov	w14,	w8
    b	main_413

main_307:
    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    cmp	w22,	#60
    bge	main_327

main_309:
    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#456
    add	w27,	w14,	w7
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#456
    add	w8,	w10,	w20
    movk	fp,	#2,	lsl #16
    add	w14,	w8,	w27
    ldr	w19,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    sub	w15,	w27,	w14
    ldr	w22,	[sp, fp]

    add	w2,	w15,	w8
    add	w15,	w19,	w22
    sub	w0,	w2,	w14
    sub	w8,	w0,	w2
    add	w14,	w8,	w14
    sub	w8,	w14,	w2
    add	w7,	w15,	w8
    sub	w27,	w8,	w7
    add	w14,	w27,	w15
    sub	w2,	w14,	w7
    sub	w0,	w2,	w14
    add	w8,	w0,	w7
    mov	w0,	w21
    sub	w8,	w8,	w14
    mov	w14,	w8
    b	main_413

main_327:
    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#464
    add	w2,	w20,	w10
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#472
    sub	w10,	w14,	w2
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#456
    add	w0,	w10,	w22
    movk	fp,	#2,	lsl #16
    sub	w7,	w0,	w2
    ldr	w19,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w7
    ldr	w13,	[sp, fp]

    sub	w14,	w7,	w0
    add	w8,	w14,	w13
    sub	w8,	w8,	w0
    mov	w0,	w3
    mov	w14,	w8

main_413:
    mov	w8,	w14

main_416:
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#468
    lsl	w14,	w2,	#5
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#468
    asr	w15,	w13,	#31
    movk	fp,	#2,	lsl #16
    lsr	w27,	w15,	#27
    ldr	w22,	[sp, fp]

    movz	fp,	#468
    add	w15,	w22,	w27
    movk	fp,	#2,	lsl #16
    asr	w15,	w15,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#452
    lsl	w22,	w15,	#5
    movk	fp,	#2,	lsl #16
    sub	w15,	w28,	w22
    ldr	w22,	[sp, fp]

    movz	fp,	#464
    lsl	w2,	w22,	#2
    add	w27,	w14,	w15
    movk	fp,	#2,	lsl #16
    mov	x15,	x2
    add	x15,	sp,	x15
    add	w2,	w27,	w4
    add	x15,	x15,	#16
    add	w10,	w2,	w8
    ldr	w14,	[x15]

    add	w8,	w10,	w0
    ldr	w19,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	w14
    ldr	w20,	[sp, fp]

    lsl	w8,	w19,	#30
    movz	fp,	#464
    asr	w4,	w20,	#31
    movk	fp,	#2,	lsl #16
    lsr	w14,	w4,	#2
    ldr	w19,	[sp, fp]

    movz	fp,	#464
    add	w22,	w19,	w14
    movk	fp,	#2,	lsl #16
    asr	w7,	w22,	#30
    ldr	w20,	[sp, fp]

    movz	fp,	#452
    lsl	w4,	w7,	#30
    movk	fp,	#2,	lsl #16
    sub	w15,	w20,	w4
    ldr	w20,	[sp, fp]

    add	w27,	w20,	#1
    add	w15,	w8,	w15
    cmp	w27,	#20
    bge	main_364

main_336:
    movz	fp,	#468
    mov	w2,	w17
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#468
    add	w14,	w15,	w0
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#472
    sub	w0,	w2,	w4
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w3,	w13,	w0
    add	w7,	w3,	w14
    sub	w17,	w14,	w7
    add	w14,	w17,	w3
    sub	w17,	w14,	w7
    sub	w19,	w17,	w14
    mov	w17,	w18
    add	w24,	w19,	w7
    sub	w22,	w24,	w14
    mov	w0,	w22
    b	main_347

main_364:
    cmp	w27,	#40
    bge	main_378

main_366:
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#468
    add	w19,	w15,	w21
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#472
    sub	w7,	w6,	w19
    movk	fp,	#2,	lsl #16
    add	w0,	w7,	w15
    sub	w0,	w0,	w19
    ldr	w19,	[sp, fp]

    movz	fp,	#472
    add	w3,	w19,	w0
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    sub	w7,	w0,	w3
    add	w17,	w7,	w24
    sub	w19,	w17,	w3
    mov	w3,	w12
    b	main_375

main_378:
    cmp	w27,	#60
    bge	main_401

main_380:
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#468
    add	w19,	w15,	w22
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#472
    add	w18,	w3,	w9
    movk	fp,	#2,	lsl #16
    add	w4,	w18,	w19
    ldr	w24,	[sp, fp]

    add	w8,	w24,	w15
    sub	w3,	w19,	w4
    add	w7,	w3,	w18
    sub	w19,	w7,	w4
    sub	w3,	w19,	w7
    add	w0,	w3,	w4
    sub	w4,	w0,	w7
    add	w0,	w8,	w4
    sub	w12,	w4,	w0
    mov	w4,	w21
    add	w12,	w12,	w8
    sub	w17,	w12,	w0
    sub	w24,	w17,	w12
    add	w3,	w24,	w0
    sub	w18,	w3,	w12
    mov	w22,	w18
    b	main_398

main_401:
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#468
    add	w19,	w15,	w7
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#472
    sub	w7,	w20,	w19
    movk	fp,	#2,	lsl #16
    add	w8,	w7,	w15
    ldr	w0,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    sub	w2,	w8,	w19
    ldr	w13,	[sp, fp]

    add	w18,	w0,	w2
    sub	w8,	w2,	w18
    add	w4,	w8,	w13
    sub	w19,	w4,	w18
    mov	w4,	w3
    mov	w22,	w19

main_398:
    mov	w19,	w22
    mov	w3,	w4

main_375:
    mov	w0,	w19
    mov	w17,	w3

main_347:
    lsl	w19,	w10,	#5
    asr	w4,	w10,	#31
    lsl	w22,	w27,	#2
    movz	fp,	#456
    lsr	w7,	w4,	#27
    mov	x18,	x22
    movk	fp,	#2,	lsl #16
    add	x18,	sp,	x18
    add	w8,	w10,	w7
    add	x18,	x18,	#16
    asr	w8,	w8,	#5
    ldr	w2,	[x18]

    lsl	w12,	w8,	#5
    ldr	w22,	[sp, fp]

    sub	w12,	w10,	w12
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    add	w8,	w12,	w22
    ldr	w9,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    add	w12,	w8,	w19
    ldr	w28,	[sp, fp]

    movz	fp,	#468
    asr	w18,	w28,	#31
    add	w4,	w12,	w0
    movk	fp,	#2,	lsl #16
    lsr	w24,	w18,	#2
    lsl	w12,	w9,	#30
    add	w8,	w4,	w17
    add	w21,	w8,	w2
    ldr	w2,	[sp, fp]

    movz	fp,	#468
    add	w3,	w2,	w24
    movk	fp,	#2,	lsl #16
    asr	w4,	w3,	#30
    ldr	w8,	[sp, fp]

    lsl	w7,	w4,	#30
    sub	w14,	w8,	w7
    add	w7,	w27,	#1
    add	w18,	w12,	w14
    cmp	w7,	#80
    blt	main_276

main_433:
    add	w17,	w21,	w11
    add	w9,	w10,	w25
    add	w24,	w18,	w16
    add	w7,	w15,	w5
    movz	fp,	#472
    add	w1,	w1,	#64
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    add	w0,	w8,	w23
    cmp	w1,	w26
    blt	main_62

main_441:
    movz	fp,	#580
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#588
    str	w17,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#572
    str	w9,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#564
    str	w24,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#436
    str	w7,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w0,	[x23]


main_442:
    cmp	w27,	#5
    bge	main_455

main_445:
    lsl	w16,	w27,	#2
    movz	fp,	#356
    lsl	w11,	w27,	#2
    mov	x23,	x16
    movk	fp,	#2,	lsl #16
    add	w27,	w27,	#1
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

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w1,	w6
    b	main_28

main_62:
    mov	w11,	w17
    mov	w25,	w9
    mov	w16,	w24
    mov	w5,	w7
    mov	w23,	w0
    b	main_63

main_276:
    mov	w19,	w21
    movz	fp,	#468
    mov	w8,	w10
    mov	w14,	w15
    mov	w9,	w7
    mov	w13,	w18
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#452
    mov	w4,	w12
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#420
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


