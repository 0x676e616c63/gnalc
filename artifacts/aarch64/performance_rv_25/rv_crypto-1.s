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
    mov	w26,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w2,	#0
    movz	w6,	#0
    movz	fp,	#356
    movz	w4,	#0
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#496
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
    movz	fp,	#444
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
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#484
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    str	x25,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w26
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	w11,	[sp, fp]


main_28:
    movz	w5,	#0
    mov	w7,	w1
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
    movz	fp,	#484
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
    movz	fp,	#444
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
    movz	fp,	#444
    movz	w27,	#0
    add	w22,	w16,	#1
    movz	w25,	#0
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x24,	x28,	x2
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    str	w27,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    ldr	x0,	[sp, fp]

    add	w25,	w16,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    add	w0,	w16,	#3
    str	w23,	[x22]

    lsl	w25,	w0,	#2
    add	w22,	w16,	#4
    ldr	x1,	[sp, fp]

    movz	fp,	#476
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w27,	#0
    movz	w17,	#8961
    movz	w26,	#43913
    movz	w3,	#56574
    movz	w5,	#21622
    movz	w19,	#57840
    mov	w24,	w27
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w5,	#4146,	lsl #16
    movk	w19,	#50130,	lsl #16
    mov	w11,	w17
    mov	w15,	w26
    mov	w0,	w19
    mov	w26,	w3

main_63:
    movz	w19,	#0
    mov	w25,	w24
    mov	w13,	w19

main_70:
    cmp	w13,	#14
    bge	main_215

main_74:
    lsl	w19,	w13,	#2
    lsl	w6,	w25,	#2
    movz	fp,	#444
    add	w2,	w25,	#1
    add	w14,	w25,	#2
    add	w13,	w13,	#1
    mov	x19,	x19
    movk	fp,	#2,	lsl #16
    lsl	w21,	w2,	#2
    add	x19,	sp,	x19
    lsl	w9,	w14,	#2
    ldr	x1,	[sp, fp]

    add	w14,	w25,	#4
    movz	fp,	#444
    add	x19,	x19,	#16
    add	x4,	x1,	x6
    movk	fp,	#2,	lsl #16
    ldr	w8,	[x4]

    ldr	x12,	[sp, fp]

    lsl	w17,	w8,	#24
    movz	fp,	#444
    add	x3,	x12,	x21
    movk	fp,	#2,	lsl #16
    add	w21,	w14,	#2
    ldr	w6,	[x3]

    ldr	x27,	[sp, fp]

    lsl	w8,	w6,	#16
    movz	fp,	#444
    add	x23,	x27,	x9
    add	w10,	w8,	w17
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x23]

    ldr	x1,	[sp, fp]

    lsl	w3,	w2,	#8
    movz	fp,	#444
    add	w4,	w10,	w3
    movk	fp,	#2,	lsl #16
    add	w3,	w13,	#1
    add	w10,	w25,	#3
    lsl	w16,	w10,	#2
    lsl	w10,	w13,	#2
    add	x12,	x1,	x16
    mov	x8,	x10
    lsl	w1,	w14,	#2
    add	x8,	sp,	x8
    ldr	w18,	[x12]

    add	x8,	x8,	#16
    add	w9,	w4,	w18
    str	w9,	[x19]

    ldr	x12,	[sp, fp]

    movz	fp,	#444
    add	x27,	x12,	x1
    movk	fp,	#2,	lsl #16
    add	w1,	w14,	#1
    ldr	w2,	[x27]

    lsl	w18,	w1,	#2
    lsl	w25,	w2,	#24
    ldr	x2,	[sp, fp]

    movz	fp,	#444
    add	x2,	x2,	x18
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x2]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#444
    add	w18,	w10,	w25
    movk	fp,	#2,	lsl #16
    lsl	w10,	w21,	#2
    add	x2,	x7,	x10
    add	w10,	w14,	#3
    ldr	w4,	[x2]

    lsl	w23,	w10,	#2
    ldr	x12,	[sp, fp]

    lsl	w6,	w4,	#8
    movz	fp,	#444
    add	x12,	x12,	x23
    add	w4,	w14,	#4
    add	w21,	w18,	w6
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x12]

    add	w9,	w4,	#1
    lsl	w12,	w3,	#2
    add	w7,	w21,	w25
    mov	x10,	x12
    add	w25,	w4,	#2
    lsl	w27,	w9,	#2
    add	x10,	sp,	x10
    str	w7,	[x8]

    ldr	x2,	[sp, fp]

    lsl	w7,	w4,	#2
    add	x10,	x10,	#16
    movz	fp,	#444
    add	x6,	x2,	x7
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    ldr	w8,	[x6]

    ldr	x18,	[sp, fp]

    lsl	w6,	w8,	#24
    movz	fp,	#444
    add	x14,	x18,	x27
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    add	w14,	w3,	#1
    ldr	x19,	[sp, fp]

    lsl	w18,	w17,	#16
    movz	fp,	#444
    add	x1,	x19,	x2
    movk	fp,	#2,	lsl #16
    add	w23,	w18,	w6
    add	w18,	w4,	#3
    ldr	w6,	[x1]

    lsl	w1,	w14,	#2
    ldr	x8,	[sp, fp]

    lsl	w2,	w18,	#2
    lsl	w13,	w6,	#8
    mov	x9,	x1
    movz	fp,	#444
    add	x21,	x8,	x2
    add	w6,	w23,	w13
    add	x9,	sp,	x9
    movk	fp,	#2,	lsl #16
    add	w8,	w14,	#1
    ldr	w7,	[x21]

    add	x9,	x9,	#16
    add	w21,	w4,	#4
    add	w13,	w6,	w7
    lsl	w1,	w21,	#2
    str	w13,	[x10]

    add	w10,	w21,	#1
    ldr	x12,	[sp, fp]

    movz	fp,	#444
    add	x27,	x12,	x1
    movk	fp,	#2,	lsl #16
    lsl	w13,	w10,	#2
    ldr	w2,	[x27]

    add	w27,	w21,	#3
    ldr	x6,	[sp, fp]

    lsl	w2,	w2,	#24
    movz	fp,	#444
    add	x12,	x6,	x13
    movk	fp,	#2,	lsl #16
    add	w6,	w21,	#2
    ldr	w17,	[x12]

    lsl	w10,	w6,	#2
    ldr	x16,	[sp, fp]

    lsl	w19,	w17,	#16
    movz	fp,	#444
    add	x7,	x16,	x10
    movk	fp,	#2,	lsl #16
    add	w2,	w19,	w2
    add	w10,	w21,	#4
    ldr	w13,	[x7]

    ldr	x16,	[sp, fp]

    lsl	w17,	w13,	#8
    movz	fp,	#444
    add	w13,	w10,	#1
    add	w4,	w2,	w17
    movk	fp,	#2,	lsl #16
    lsl	w2,	w27,	#2
    lsl	w13,	w13,	#2
    add	x1,	x16,	x2
    ldr	w3,	[x1]

    add	w1,	w10,	#2
    add	w7,	w4,	w3
    lsl	w3,	w8,	#2
    mov	x19,	x3
    str	w7,	[x9]

    lsl	w1,	w1,	#2
    lsl	w3,	w10,	#2
    add	x19,	sp,	x19
    ldr	x21,	[sp, fp]

    movz	fp,	#444
    add	x2,	x21,	x3
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x2]

    ldr	x18,	[sp, fp]

    lsl	w6,	w4,	#24
    movz	fp,	#444
    add	x14,	x18,	x13
    movk	fp,	#2,	lsl #16
    ldr	w17,	[x14]

    ldr	x16,	[sp, fp]

    lsl	w23,	w17,	#16
    movz	fp,	#444
    add	x2,	x16,	x1
    add	w23,	w23,	w6
    movk	fp,	#2,	lsl #16
    add	w1,	w8,	#1
    ldr	w9,	[x2]

    ldr	x27,	[sp, fp]

    add	w2,	w10,	#3
    lsl	w16,	w9,	#8
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w4,	w2,	#2
    add	w12,	w23,	w16
    lsl	w16,	w1,	#2
    add	x3,	x27,	x4
    mov	x13,	x16
    add	w4,	w10,	#4
    add	x13,	sp,	x13
    ldr	w6,	[x3]

    add	w16,	w4,	#1
    lsl	w25,	w4,	#2
    add	x13,	x13,	#16
    add	w6,	w12,	w6
    add	w12,	w4,	#2
    str	w6,	[x19]

    ldr	x9,	[sp, fp]

    movz	fp,	#444
    add	x21,	x9,	x25
    movk	fp,	#2,	lsl #16
    lsl	w9,	w16,	#2
    ldr	w27,	[x21]

    ldr	x28,	[sp, fp]

    lsl	w6,	w27,	#24
    movz	fp,	#444
    add	x18,	x28,	x9
    add	w27,	w4,	#3
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x18]

    ldr	x14,	[sp, fp]

    lsl	w7,	w3,	#16
    movz	fp,	#444
    add	w8,	w7,	w6
    movk	fp,	#2,	lsl #16
    lsl	w6,	w27,	#2
    lsl	w7,	w12,	#2
    add	w27,	w1,	#1
    add	x14,	x14,	x7
    ldr	w18,	[x14]

    ldr	x14,	[sp, fp]

    lsl	w23,	w18,	#8
    movz	fp,	#444
    add	x3,	x14,	x6
    add	w21,	w8,	w23
    movk	fp,	#2,	lsl #16
    lsl	w8,	w27,	#2
    ldr	w12,	[x3]

    add	w2,	w21,	w12
    add	w12,	w4,	#4
    mov	x4,	x8
    str	w2,	[x13]

    add	x4,	sp,	x4
    add	w8,	w12,	#3
    ldr	x16,	[sp, fp]

    lsl	w2,	w12,	#2
    movz	fp,	#444
    add	x4,	x4,	#16
    movk	fp,	#2,	lsl #16
    add	x17,	x16,	x2
    ldr	w3,	[x17]

    add	w17,	w12,	#1
    lsl	w16,	w3,	#24
    lsl	w13,	w17,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#444
    add	x21,	x17,	x13
    movk	fp,	#2,	lsl #16
    add	w13,	w12,	#2
    ldr	w25,	[x21]

    ldr	x17,	[sp, fp]

    lsl	w1,	w25,	#16
    movz	fp,	#444
    lsl	w25,	w13,	#2
    add	w3,	w1,	w16
    movk	fp,	#2,	lsl #16
    lsl	w13,	w8,	#2
    add	x14,	x17,	x25
    add	w25,	w12,	#4
    ldr	w19,	[x14]

    lsl	w2,	w19,	#8
    ldr	x19,	[sp, fp]

    add	w6,	w3,	w2
    add	x10,	x19,	x13
    add	w3,	w27,	#1
    mov	w13,	w3
    ldr	w14,	[x10]

    add	w7,	w6,	w14
    str	w7,	[x4]

    b	main_70

main_215:
    mov	w21,	w25
    mov	w6,	w13

main_217:
    lsl	w9,	w6,	#2
    lsl	w14,	w21,	#2
    movz	fp,	#444
    add	w3,	w21,	#1
    add	w2,	w21,	#2
    mov	x7,	x9
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    lsl	w1,	w3,	#2
    lsl	w17,	w2,	#2
    ldr	x4,	[sp, fp]

    add	x7,	x7,	#16
    movz	fp,	#444
    add	x16,	x4,	x14
    movk	fp,	#2,	lsl #16
    ldr	w23,	[x16]

    ldr	x4,	[sp, fp]

    lsl	w27,	w23,	#24
    movz	fp,	#444
    add	x10,	x4,	x1
    add	w23,	w21,	#4
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x10]

    ldr	x4,	[sp, fp]

    lsl	w16,	w13,	#16
    movz	fp,	#444
    add	x3,	x4,	x17
    add	w16,	w16,	w27
    movk	fp,	#2,	lsl #16
    add	w27,	w6,	#1
    ldr	w10,	[x3]

    add	w3,	w21,	#3
    lsl	w12,	w10,	#8
    ldr	x10,	[sp, fp]

    add	w12,	w16,	w12
    lsl	w25,	w3,	#2
    add	x10,	x10,	x25
    ldr	w17,	[x10]

    add	w25,	w12,	w17
    str	w25,	[x7]

    cmp	w27,	#16
    bge	main_241

main_216:
    mov	w21,	w23
    mov	w6,	w27
    b	main_217

main_241:
    mov	w14,	w27
    movz	fp,	#536
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]


main_242:
    movz	fp,	#536
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#536
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#536
    lsl	w23,	w10,	#2
    movk	fp,	#2,	lsl #16
    mov	x19,	x23
    add	x19,	sp,	x19
    ldr	w25,	[sp, fp]

    movz	fp,	#536
    sub	w27,	w25,	#3
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    lsl	w6,	w27,	#2
    mov	x4,	x6
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w7,	[x4]

    ldr	w3,	[sp, fp]

    movz	fp,	#536
    sub	w6,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w10,	w6,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w12,	[x9]

    ldr	w4,	[sp, fp]

    add	w9,	w12,	w7
    movz	fp,	#536
    sub	w25,	w4,	#14
    movk	fp,	#2,	lsl #16
    sub	w14,	w7,	w9
    lsl	w1,	w25,	#2
    mov	x27,	x1
    add	w21,	w14,	w12
    add	x27,	sp,	x27
    sub	w9,	w21,	w9
    add	x27,	x27,	#16
    ldr	w6,	[x27]

    add	w1,	w6,	w9
    sub	w3,	w9,	w1
    add	w12,	w3,	w6
    ldr	w6,	[sp, fp]

    movz	fp,	#536
    sub	w2,	w6,	#16
    sub	w25,	w12,	w1
    movk	fp,	#2,	lsl #16
    lsl	w4,	w2,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    ldr	w6,	[x3]

    add	w4,	w6,	w25
    sub	w12,	w25,	w4
    add	w13,	w12,	w6
    sub	w18,	w13,	w4
    asr	w2,	w18,	#31
    lsl	w10,	w18,	#1
    lsr	w3,	w2,	#31
    add	w4,	w18,	w3
    asr	w13,	w4,	#1
    lsl	w17,	w13,	#1
    sub	w6,	w18,	w17
    add	w8,	w10,	w6
    str	w8,	[x19]

    ldr	w17,	[sp, fp]

    movz	fp,	#536
    add	w9,	w17,	#1
    movk	fp,	#2,	lsl #16
    mov	w8,	w9
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w28,	w11
    movz	fp,	#436
    mov	w3,	w15
    mov	w20,	w26
    mov	w9,	w5
    mov	w6,	w0
    movz	w7,	#0
    movk	fp,	#2,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    mov	w3,	w7
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]


main_277:
    movz	w7,	#48348
    movz	w16,	#60289
    movz	w23,	#65535
    movz	fp,	#420
    movk	w7,	#36635,	lsl #16
    movk	w16,	#28377,	lsl #16
    movk	w23,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w21,	w7
    mov	w10,	w16
    mov	w18,	w23
    ldr	w17,	[sp, fp]

    movz	w7,	#49414
    movk	w7,	#51810,	lsl #16
    mov	w4,	w7
    movz	w7,	#31129
    movk	w7,	#23170,	lsl #16
    mov	w16,	w7
    cmp	w17,	#20
    bge	main_296

main_285:
    movz	fp,	#432
    mov	w8,	w18
    mov	w1,	w16
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#432
    add	w7,	w27,	w19
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#424
    sub	w14,	w8,	w14
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    add	w17,	w20,	w14
    add	w23,	w17,	w7
    sub	w12,	w7,	w23
    add	w27,	w12,	w17
    sub	w14,	w27,	w23
    sub	w12,	w14,	w27
    add	w14,	w12,	w23
    sub	w14,	w14,	w27
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
    ldr	w23,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#432
    add	w14,	w1,	w23
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#440
    sub	w17,	w20,	w14
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    add	w27,	w17,	w7
    movk	fp,	#2,	lsl #16
    sub	w1,	w27,	w14
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w7,	w7,	w1
    ldr	w28,	[sp, fp]

    sub	w14,	w1,	w7
    mov	w1,	w10
    add	w14,	w14,	w28
    sub	w14,	w14,	w7
    mov	w19,	w14
    b	main_413

main_307:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    cmp	w25,	#60
    bge	main_327

main_309:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#424
    add	w27,	w14,	w7
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#424
    add	w14,	w12,	w20
    movk	fp,	#2,	lsl #16
    add	w17,	w14,	w27
    sub	w19,	w27,	w17
    add	w1,	w19,	w14
    ldr	w19,	[sp, fp]

    movz	fp,	#440
    sub	w12,	w1,	w17
    movk	fp,	#2,	lsl #16
    sub	w14,	w12,	w1
    add	w23,	w14,	w17
    sub	w14,	w23,	w1
    ldr	w23,	[sp, fp]

    add	w7,	w19,	w23
    add	w1,	w7,	w14
    sub	w27,	w14,	w1
    add	w17,	w27,	w7
    sub	w7,	w17,	w1
    sub	w12,	w7,	w17
    add	w14,	w12,	w1
    mov	w1,	w21
    sub	w14,	w14,	w17
    mov	w19,	w14
    b	main_413

main_327:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    add	w7,	w20,	w12
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#440
    sub	w14,	w14,	w7
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#424
    add	w1,	w14,	w23
    movk	fp,	#2,	lsl #16
    sub	w14,	w1,	w7
    ldr	w19,	[sp, fp]

    mov	w1,	w4
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w12,	w19,	w14
    ldr	w13,	[sp, fp]

    sub	w17,	w14,	w12
    add	w8,	w17,	w13
    sub	w14,	w8,	w12
    mov	w19,	w14

main_413:
    mov	w14,	w19

main_416:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#436
    lsl	w17,	w3,	#5
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#436
    asr	w23,	w12,	#31
    movk	fp,	#2,	lsl #16
    lsr	w8,	w23,	#27
    ldr	w23,	[sp, fp]

    movz	fp,	#436
    add	w19,	w23,	w8
    movk	fp,	#2,	lsl #16
    asr	w23,	w19,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#420
    lsl	w7,	w23,	#5
    movk	fp,	#2,	lsl #16
    sub	w19,	w28,	w7
    ldr	w23,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w27,	w17,	w19
    lsl	w17,	w23,	#2
    mov	x19,	x17
    add	w6,	w27,	w6
    add	x19,	sp,	x19
    add	w17,	w6,	w14
    add	x19,	x19,	#16
    add	w17,	w17,	w1
    ldr	w19,	[x19]

    add	w12,	w17,	w19
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    lsl	w6,	w19,	#30
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#432
    asr	w23,	w20,	#31
    movk	fp,	#2,	lsl #16
    lsr	w27,	w23,	#2
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    add	w23,	w19,	w27
    movk	fp,	#2,	lsl #16
    asr	w17,	w23,	#30
    ldr	w20,	[sp, fp]

    movz	fp,	#420
    lsl	w23,	w17,	#30
    movk	fp,	#2,	lsl #16
    sub	w19,	w20,	w23
    ldr	w20,	[sp, fp]

    add	w27,	w20,	#1
    add	w19,	w6,	w19
    cmp	w27,	#20
    bge	main_364

main_336:
    movz	fp,	#436
    mov	w8,	w18
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#436
    add	w14,	w19,	w2
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#440
    sub	w2,	w8,	w3
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w4,	w13,	w2
    add	w7,	w4,	w14
    sub	w17,	w14,	w7
    add	w21,	w17,	w4
    sub	w17,	w21,	w7
    sub	w18,	w17,	w21
    add	w1,	w18,	w7
    sub	w18,	w1,	w21
    mov	w23,	w18
    b	main_347

main_364:
    cmp	w27,	#40
    bge	main_378

main_366:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#436
    add	w18,	w19,	w21
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w6,	w18
    movk	fp,	#2,	lsl #16
    add	w2,	w7,	w19
    ldr	w20,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w2,	w2,	w18
    ldr	w25,	[sp, fp]

    add	w4,	w20,	w2
    sub	w7,	w2,	w4
    add	w16,	w7,	w25
    sub	w18,	w16,	w4
    mov	w4,	w10
    b	main_375

main_378:
    cmp	w27,	#60
    bge	main_401

main_380:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#436
    add	w18,	w19,	w23
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#440
    add	w17,	w3,	w9
    movk	fp,	#2,	lsl #16
    add	w6,	w17,	w18
    ldr	w25,	[sp, fp]

    add	w8,	w25,	w19
    sub	w4,	w18,	w6
    add	w7,	w4,	w17
    sub	w18,	w7,	w6
    sub	w4,	w18,	w7
    add	w2,	w4,	w6
    sub	w6,	w2,	w7
    add	w4,	w8,	w6
    sub	w10,	w6,	w4
    mov	w6,	w21
    add	w14,	w10,	w8
    sub	w16,	w14,	w4
    sub	w1,	w16,	w14
    add	w4,	w1,	w4
    sub	w17,	w4,	w14
    mov	w23,	w17
    b	main_398

main_401:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#436
    add	w18,	w19,	w7
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    sub	w7,	w21,	w18
    movk	fp,	#2,	lsl #16
    add	w8,	w7,	w19
    ldr	w1,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w6,	w8,	w18
    ldr	w13,	[sp, fp]

    add	w17,	w1,	w6
    sub	w8,	w6,	w17
    add	w6,	w8,	w13
    sub	w18,	w6,	w17
    mov	w6,	w4
    mov	w23,	w18

main_398:
    mov	w18,	w23
    mov	w4,	w6

main_375:
    mov	w23,	w18
    mov	w16,	w4

main_347:
    lsl	w7,	w12,	#5
    asr	w18,	w12,	#31
    lsl	w21,	w27,	#2
    movz	fp,	#424
    lsr	w4,	w18,	#27
    mov	x17,	x21
    movk	fp,	#2,	lsl #16
    add	x17,	sp,	x17
    add	w8,	w12,	w4
    add	x17,	x17,	#16
    asr	w14,	w8,	#5
    lsl	w2,	w14,	#5
    sub	w10,	w12,	w2
    ldr	w2,	[x17]

    ldr	w25,	[sp, fp]

    movz	fp,	#436
    add	w8,	w10,	w25
    movk	fp,	#2,	lsl #16
    add	w8,	w8,	w7
    ldr	w9,	[sp, fp]

    movz	fp,	#436
    lsl	w10,	w9,	#30
    movk	fp,	#2,	lsl #16
    add	w6,	w8,	w23
    ldr	w28,	[sp, fp]

    movz	fp,	#436
    asr	w17,	w28,	#31
    add	w8,	w6,	w16
    movk	fp,	#2,	lsl #16
    lsr	w25,	w17,	#2
    add	w23,	w8,	w2
    ldr	w2,	[sp, fp]

    movz	fp,	#436
    add	w4,	w2,	w25
    movk	fp,	#2,	lsl #16
    asr	w6,	w4,	#30
    ldr	w8,	[sp, fp]

    add	w4,	w27,	#1
    lsl	w7,	w6,	#30
    sub	w14,	w8,	w7
    add	w1,	w10,	w14
    cmp	w4,	#80
    blt	main_276

main_433:
    add	w16,	w23,	w11
    add	w21,	w12,	w15
    add	w8,	w19,	w5
    movz	fp,	#440
    add	w12,	w1,	w26
    movk	fp,	#2,	lsl #16
    add	w1,	w24,	#64
    ldr	w7,	[sp, fp]

    add	w0,	w7,	w0
    cmp	w1,	w22
    blt	main_62

main_441:
    movz	fp,	#540
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#548
    str	w16,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#468
    str	w21,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#460
    str	w12,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#404
    str	w8,	[x22]

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

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w1,	w6
    b	main_28

main_62:
    mov	w11,	w16
    mov	w15,	w21
    mov	w26,	w12
    mov	w5,	w8
    mov	w24,	w1
    b	main_63

main_276:
    mov	w20,	w23
    movz	fp,	#436
    mov	w3,	w12
    mov	w16,	w19
    mov	w10,	w4
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#420
    mov	w6,	w13
    movk	fp,	#2,	lsl #16
    mov	w13,	w1
    str	w10,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#496
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


