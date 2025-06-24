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
    add	x0,	sp,	#16
    movk	w2,	#2,	lsl #16
    bl	memset
    movz	w25,	#0
    movz	w26,	#0
    movz	fp,	#356
    movz	w24,	#0
    movz	w23,	#0
    movk	fp,	#2,	lsl #16
    add	x20,	sp,	fp
    movz	fp,	#360
    movk	fp,	#2,	lsl #16
    str	w26,	[x20]

    add	x19,	sp,	fp
    movz	fp,	#364
    movk	fp,	#2,	lsl #16
    str	w25,	[x19]

    add	x21,	sp,	fp
    movz	fp,	#368
    movk	fp,	#2,	lsl #16
    str	w24,	[x21]

    add	x22,	sp,	fp
    movz	fp,	#372
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
    movz	w5,	#0
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#340
    str	w6,	[x12]

    movk	fp,	#2,	lsl #16
    add	x3,	sp,	fp
    movz	fp,	#344
    movk	fp,	#2,	lsl #16
    str	w5,	[x3]

    add	x6,	sp,	fp
    movz	w3,	#0
    movz	fp,	#348
    movk	fp,	#2,	lsl #16
    str	w4,	[x6]

    add	x7,	sp,	fp
    movz	fp,	#352
    movk	fp,	#2,	lsl #16
    str	w3,	[x7]

    add	x8,	sp,	fp
    str	w2,	[x8]

    cmp	w27,	#0
    ble	main_460

main_18:
    add	x17,	sp,	#16
    movz	fp,	#444
    movz	w11,	#62464
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

    movz	fp,	#452
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    add	x11,	x20,	#8
    mov	w0,	w19
    str	x25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#2,	lsl #16
    add	x22,	sp,	fp
    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#384
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

    add	x13,	x13,	#16
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
    movz	fp,	#452
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
    lsl	w25,	w8,	#2
    movz	fp,	#444
    add	w22,	w8,	#1
    movz	w23,	#125
    movk	fp,	#2,	lsl #16
    lsl	w2,	w22,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#444
    add	x24,	x28,	x25
    movk	fp,	#2,	lsl #16
    movz	w25,	#0
    movz	w28,	#0
    str	w28,	[x24]

    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x1,	x0,	x2
    movk	fp,	#2,	lsl #16
    str	w25,	[x1]

    add	w1,	w8,	#3
    ldr	x0,	[sp, fp]

    add	w25,	w8,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    lsl	w2,	w25,	#2
    lsl	w25,	w1,	#2
    add	x22,	x0,	x2
    movz	w2,	#0
    str	w23,	[x22]

    add	w23,	w8,	#4
    ldr	x1,	[sp, fp]

    movz	fp,	#500
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w27,	#43913
    movz	w17,	#8961
    movz	w3,	#56574
    movz	w6,	#21622
    movz	w28,	#0
    movz	w21,	#57840
    movk	w27,	#61389,	lsl #16
    movk	w17,	#26437,	lsl #16
    movk	w3,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w21,	#50130,	lsl #16
    mov	w12,	w27
    mov	w10,	w17
    mov	w4,	w3
    mov	w2,	w6
    mov	w22,	w21

main_63:
    movz	w18,	#0
    mov	w24,	w28
    mov	w14,	w18

main_70:
    cmp	w14,	#14
    bge	main_215

main_74:
    lsl	w18,	w14,	#2
    movz	fp,	#16
    lsl	w5,	w24,	#2
    add	w0,	w24,	#1
    add	w13,	w24,	#2
    add	w8,	w24,	#3
    add	w14,	w14,	#1
    mov	x17,	x18
    movk	fp,	#2,	lsl #16
    lsl	w20,	w0,	#2
    lsl	w15,	w8,	#2
    add	x17,	sp,	x17
    add	x17,	x17,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#444
    add	x3,	x27,	x5
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x3]

    ldr	x11,	[sp, fp]

    lsl	w16,	w7,	#24
    movz	fp,	#444
    add	x1,	x11,	x20
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x1]

    ldr	x25,	[sp, fp]

    lsl	w7,	w5,	#16
    movz	fp,	#444
    add	w9,	w7,	w16
    movk	fp,	#2,	lsl #16
    lsl	w7,	w13,	#2
    add	w13,	w24,	#4
    add	x21,	x25,	x7
    add	w20,	w13,	#2
    ldr	w0,	[x21]

    ldr	x27,	[sp, fp]

    lsl	w1,	w0,	#8
    movz	fp,	#16
    add	w3,	w9,	w1
    movk	fp,	#2,	lsl #16
    add	w1,	w13,	#4
    add	x9,	x27,	x15
    lsl	w27,	w13,	#2
    ldr	w18,	[x9]

    lsl	w9,	w14,	#2
    add	w8,	w3,	w18
    mov	x6,	x9
    add	x6,	sp,	x6
    str	w8,	[x17]

    add	x6,	x6,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x9,	[sp, fp]

    movz	fp,	#444
    add	x25,	x9,	x27
    movk	fp,	#2,	lsl #16
    lsl	w9,	w20,	#2
    add	w27,	w13,	#1
    ldr	w0,	[x25]

    lsl	w24,	w0,	#24
    lsl	w17,	w27,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x0,	x0,	x17
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x0]

    ldr	x5,	[sp, fp]

    lsl	w8,	w7,	#16
    movz	fp,	#444
    add	x0,	x5,	x9
    add	w17,	w8,	w24
    movk	fp,	#2,	lsl #16
    add	w9,	w13,	#3
    add	w8,	w1,	#1
    ldr	w3,	[x0]

    ldr	x11,	[sp, fp]

    lsl	w5,	w3,	#8
    lsl	w18,	w9,	#2
    lsl	w25,	w8,	#2
    movz	fp,	#16
    add	w20,	w17,	w5
    add	x11,	x11,	x18
    movk	fp,	#2,	lsl #16
    ldr	w24,	[x11]

    add	w5,	w20,	w24
    add	w24,	w1,	#2
    str	w5,	[x6]

    lsl	w6,	w1,	#2
    add	w5,	w14,	#1
    lsl	w11,	w5,	#2
    mov	x9,	x11
    add	x9,	sp,	x9
    add	x9,	x9,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#444
    add	x3,	x0,	x6
    movk	fp,	#2,	lsl #16
    lsl	w0,	w24,	#2
    ldr	w7,	[x3]

    ldr	x17,	[sp, fp]

    lsl	w3,	w7,	#24
    movz	fp,	#444
    add	x14,	x17,	x25
    movk	fp,	#2,	lsl #16
    add	w17,	w1,	#3
    ldr	w16,	[x14]

    lsl	w18,	w16,	#16
    add	w20,	w18,	w3
    ldr	x18,	[sp, fp]

    movz	fp,	#444
    add	x27,	x18,	x0
    movk	fp,	#2,	lsl #16
    lsl	w0,	w17,	#2
    ldr	w3,	[x27]

    ldr	x7,	[sp, fp]

    lsl	w11,	w3,	#8
    movz	fp,	#16
    add	w3,	w20,	w11
    movk	fp,	#2,	lsl #16
    add	x20,	x7,	x0
    ldr	w6,	[x20]

    add	w20,	w5,	#1
    add	w13,	w3,	w6
    add	w6,	w1,	#4
    str	w13,	[x9]

    add	w7,	w20,	#1
    lsl	w27,	w20,	#2
    add	w5,	w6,	#2
    add	w8,	w6,	#1
    lsl	w24,	w6,	#2
    mov	x25,	x27
    add	x25,	sp,	x25
    lsl	w1,	w8,	#2
    add	w8,	w6,	#4
    add	x25,	x25,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x9,	[sp, fp]

    movz	fp,	#444
    add	x21,	x9,	x24
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x21]

    add	w21,	w6,	#3
    ldr	x11,	[sp, fp]

    lsl	w3,	w0,	#24
    movz	fp,	#444
    add	x9,	x11,	x1
    movk	fp,	#2,	lsl #16
    lsl	w27,	w21,	#2
    ldr	w15,	[x9]

    ldr	x11,	[sp, fp]

    lsl	w17,	w15,	#16
    movz	fp,	#444
    lsl	w15,	w5,	#2
    add	w0,	w17,	w3
    movk	fp,	#2,	lsl #16
    add	x9,	x11,	x15
    ldr	w13,	[x9]

    add	w9,	w7,	#1
    lsl	w14,	w13,	#8
    ldr	x13,	[sp, fp]

    add	w3,	w0,	w14
    movz	fp,	#16
    add	x24,	x13,	x27
    movk	fp,	#2,	lsl #16
    add	w27,	w8,	#2
    add	w13,	w8,	#1
    ldr	w1,	[x24]

    lsl	w27,	w27,	#2
    lsl	w13,	w13,	#2
    add	w5,	w3,	w1
    lsl	w1,	w7,	#2
    mov	x18,	x1
    str	w5,	[x25]

    lsl	w1,	w8,	#2
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#444
    add	x0,	x19,	x1
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x0]

    ldr	x19,	[sp, fp]

    lsl	w5,	w3,	#24
    movz	fp,	#444
    add	x14,	x19,	x13
    movk	fp,	#2,	lsl #16
    add	w13,	w8,	#4
    ldr	w17,	[x14]

    lsl	w24,	w13,	#2
    ldr	x14,	[sp, fp]

    lsl	w20,	w17,	#16
    movz	fp,	#444
    add	x0,	x14,	x27
    movk	fp,	#2,	lsl #16
    add	w17,	w20,	w5
    add	w14,	w13,	#1
    lsl	w20,	w9,	#2
    ldr	w6,	[x0]

    ldr	x25,	[sp, fp]

    add	w0,	w8,	#3
    lsl	w15,	w6,	#8
    movz	fp,	#16
    lsl	w8,	w14,	#2
    movk	fp,	#2,	lsl #16
    lsl	w3,	w0,	#2
    add	w11,	w17,	w15
    add	w14,	w13,	#2
    add	x1,	x25,	x3
    mov	x3,	x20
    lsl	w6,	w14,	#2
    add	x3,	sp,	x3
    ldr	w5,	[x1]

    add	w5,	w11,	w5
    add	x3,	x3,	fp
    movz	fp,	#444
    str	w5,	[x18]

    movk	fp,	#2,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#444
    add	x21,	x5,	x24
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x21]

    ldr	x26,	[sp, fp]

    lsl	w1,	w25,	#24
    movz	fp,	#444
    add	x17,	x26,	x8
    add	w25,	w13,	#3
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x17]

    ldr	x8,	[sp, fp]

    lsl	w5,	w0,	#16
    movz	fp,	#444
    add	x16,	x8,	x6
    add	w5,	w5,	w1
    movk	fp,	#2,	lsl #16
    lsl	w1,	w25,	#2
    ldr	w20,	[x16]

    ldr	x11,	[sp, fp]

    lsl	w24,	w20,	#8
    movz	fp,	#16
    add	x0,	x11,	x1
    add	w20,	w5,	w24
    movk	fp,	#2,	lsl #16
    add	w11,	w13,	#4
    ldr	w7,	[x0]

    add	w0,	w9,	#1
    add	w27,	w20,	w7
    add	w24,	w11,	#4
    add	w13,	w11,	#2
    add	w18,	w11,	#1
    add	w8,	w11,	#3
    lsl	w1,	w11,	#2
    lsl	w7,	w0,	#2
    str	w27,	[x3]

    mov	x5,	x7
    lsl	w14,	w18,	#2
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x16,	[sp, fp]

    movz	fp,	#444
    add	x17,	x16,	x1
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x17]

    ldr	x17,	[sp, fp]

    lsl	w16,	w3,	#24
    movz	fp,	#444
    add	x20,	x17,	x14
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x20]

    ldr	x17,	[sp, fp]

    lsl	w27,	w25,	#16
    movz	fp,	#444
    lsl	w25,	w13,	#2
    add	w1,	w27,	w16
    movk	fp,	#2,	lsl #16
    add	x14,	x17,	x25
    ldr	w20,	[x14]

    ldr	x19,	[sp, fp]

    lsl	w14,	w8,	#2
    lsl	w3,	w20,	#8
    add	x13,	x19,	x14
    add	w3,	w1,	w3
    add	w1,	w0,	#1
    ldr	w15,	[x13]

    mov	w14,	w1
    add	w7,	w3,	w15
    str	w7,	[x5]

    b	main_70

main_215:
    mov	w20,	w24
    mov	w3,	w14

main_217:
    lsl	w8,	w3,	#2
    movz	fp,	#16
    lsl	w14,	w20,	#2
    add	w1,	w20,	#1
    add	w0,	w20,	#2
    add	w25,	w3,	#1
    mov	x6,	x8
    movk	fp,	#2,	lsl #16
    lsl	w27,	w1,	#2
    add	x6,	sp,	x6
    add	x6,	x6,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#444
    add	x16,	x5,	x14
    movk	fp,	#2,	lsl #16
    ldr	w21,	[x16]

    lsl	w16,	w0,	#2
    ldr	x1,	[sp, fp]

    lsl	w24,	w21,	#24
    movz	fp,	#444
    add	x8,	x1,	x27
    add	w21,	w20,	#4
    movk	fp,	#2,	lsl #16
    ldr	w11,	[x8]

    ldr	x5,	[sp, fp]

    lsl	w15,	w11,	#16
    movz	fp,	#444
    add	x1,	x5,	x16
    add	w15,	w15,	w24
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x1]

    add	w1,	w20,	#3
    lsl	w11,	w9,	#8
    ldr	x9,	[sp, fp]

    add	w11,	w15,	w11
    lsl	w24,	w1,	#2
    add	x8,	x9,	x24
    ldr	w16,	[x8]

    add	w24,	w11,	w16
    str	w24,	[x6]

    cmp	w25,	#16
    bge	main_241

main_216:
    mov	w20,	w21
    mov	w3,	w25
    b	main_217

main_241:
    mov	w15,	w25
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]


main_242:
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    cmp	w9,	#80
    bge	main_275

main_245:
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#16
    lsl	w21,	w11,	#2
    movk	fp,	#2,	lsl #16
    mov	x18,	x21
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#16
    sub	w25,	w25,	#3
    movk	fp,	#2,	lsl #16
    lsl	w3,	w25,	#2
    mov	x1,	x3
    add	x1,	sp,	x1
    add	x1,	x1,	fp
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x1]

    ldr	w3,	[sp, fp]

    movz	fp,	#16
    sub	w6,	w3,	#8
    movk	fp,	#2,	lsl #16
    lsl	w9,	w6,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	fp
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	w11,	[x8]

    add	w8,	w11,	w5
    sub	w14,	w5,	w8
    ldr	w5,	[sp, fp]

    movz	fp,	#16
    sub	w24,	w5,	#14
    add	w20,	w14,	w11
    movk	fp,	#2,	lsl #16
    lsl	w27,	w24,	#2
    sub	w8,	w20,	w8
    mov	x25,	x27
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x25]

    ldr	w6,	[sp, fp]

    add	w27,	w3,	w8
    movz	fp,	#16
    movk	fp,	#2,	lsl #16
    sub	w0,	w8,	w27
    add	w9,	w0,	w3
    sub	w0,	w6,	#16
    sub	w24,	w9,	w27
    lsl	w3,	w0,	#2
    mov	x1,	x3
    add	x1,	sp,	x1
    add	x1,	x1,	fp
    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x1]

    add	w3,	w5,	w24
    sub	w11,	w24,	w3
    add	w13,	w11,	w5
    sub	w16,	w13,	w3
    asr	w0,	w16,	#31
    lsl	w9,	w16,	#1
    lsr	w1,	w0,	#31
    add	w3,	w16,	w1
    asr	w14,	w3,	#1
    lsl	w15,	w14,	#1
    sub	w5,	w16,	w15
    add	w7,	w9,	w5
    str	w7,	[x18]

    ldr	w17,	[sp, fp]

    movz	fp,	#540
    add	w8,	w17,	#1
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    b	main_242

main_275:
    mov	w25,	w10
    movz	fp,	#436
    mov	w1,	w12
    mov	w17,	w4
    mov	w9,	w2
    mov	w3,	w22
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    mov	w0,	w6
    str	w25,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w17,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_277:
    movz	w1,	#48348
    movz	w14,	#60289
    movz	w27,	#31129
    movz	w24,	#65535
    movz	fp,	#420
    movk	w1,	#36635,	lsl #16
    movk	w14,	#28377,	lsl #16
    movk	w27,	#23170,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w20,	w1
    mov	w9,	w14
    mov	w16,	w27
    mov	w17,	w24
    ldr	w15,	[sp, fp]

    movz	w1,	#49414
    movk	w1,	#51810,	lsl #16
    cmp	w15,	#20
    bge	main_296

main_285:
    movz	fp,	#432
    mov	w14,	w17
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#432
    add	w0,	w24,	w18
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    sub	w6,	w14,	w13
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w11,	w19,	w6
    mov	w6,	w16
    add	w14,	w11,	w0
    sub	w7,	w0,	w14
    add	w25,	w7,	w11
    sub	w11,	w25,	w14
    sub	w0,	w11,	w25
    add	w7,	w0,	w14
    sub	w11,	w7,	w25
    mov	w7,	w11
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
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#432
    add	w7,	w27,	w21
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#440
    sub	w15,	w21,	w7
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#424
    add	w25,	w15,	w6
    movk	fp,	#2,	lsl #16
    sub	w25,	w25,	w7
    ldr	w6,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w6,	w6,	w25
    ldr	w26,	[sp, fp]

    sub	w0,	w25,	w6
    add	w0,	w0,	w26
    sub	w11,	w0,	w6
    mov	w6,	w9
    mov	w24,	w11
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
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w25,	w13,	w6
    movk	fp,	#2,	lsl #16
    mov	w6,	w20
    ldr	w11,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#424
    add	w7,	w11,	w21
    movk	fp,	#2,	lsl #16
    add	w15,	w7,	w25
    ldr	w18,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w14,	w25,	w15
    ldr	w19,	[sp, fp]

    add	w27,	w14,	w7
    add	w14,	w18,	w19
    sub	w0,	w27,	w15
    sub	w7,	w0,	w27
    add	w11,	w7,	w15
    sub	w7,	w11,	w27
    add	w15,	w14,	w7
    sub	w25,	w7,	w15
    add	w11,	w25,	w14
    sub	w0,	w11,	w15
    sub	w0,	w0,	w11
    add	w7,	w0,	w15
    sub	w11,	w7,	w11
    mov	w24,	w11
    b	main_413

main_327:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    add	w6,	w19,	w11
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#440
    sub	w0,	w13,	w6
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#424
    add	w25,	w0,	w21
    movk	fp,	#2,	lsl #16
    sub	w6,	w25,	w6
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w0,	w19,	w6
    ldr	w13,	[sp, fp]

    sub	w14,	w6,	w0
    mov	w6,	w1
    add	w11,	w14,	w13
    sub	w11,	w11,	w0
    mov	w24,	w11

main_413:
    mov	w7,	w24

main_416:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#436
    lsl	w15,	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#436
    asr	w14,	w13,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w14,	#27
    ldr	w19,	[sp, fp]

    movz	fp,	#436
    add	w14,	w19,	w24
    movk	fp,	#2,	lsl #16
    asr	w14,	w14,	#5
    ldr	w26,	[sp, fp]

    movz	fp,	#420
    lsl	w24,	w14,	#5
    movk	fp,	#2,	lsl #16
    sub	w14,	w26,	w24
    ldr	w24,	[sp, fp]

    movz	fp,	#16
    lsl	w0,	w24,	#2
    add	w25,	w15,	w14
    movk	fp,	#2,	lsl #16
    mov	x15,	x0
    add	x15,	sp,	x15
    add	w27,	w25,	w3
    add	x15,	x15,	fp
    add	w11,	w27,	w7
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x15]

    add	w7,	w11,	w6
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w11,	w7,	w14
    lsl	w7,	w19,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#432
    asr	w6,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w6,	#2
    ldr	w15,	[sp, fp]

    movz	fp,	#432
    add	w24,	w15,	w24
    movk	fp,	#2,	lsl #16
    asr	w6,	w24,	#30
    ldr	w19,	[sp, fp]

    movz	fp,	#420
    lsl	w6,	w6,	#30
    movk	fp,	#2,	lsl #16
    sub	w15,	w19,	w6
    ldr	w19,	[sp, fp]

    add	w27,	w19,	#1
    add	w14,	w7,	w15
    cmp	w27,	#20
    bge	main_364

main_336:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#436
    add	w6,	w14,	w0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#440
    sub	w0,	w17,	w1
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w1,	w15,	w0
    add	w7,	w1,	w6
    sub	w17,	w6,	w7
    add	w15,	w17,	w1
    sub	w17,	w15,	w7
    sub	w18,	w17,	w15
    add	w24,	w18,	w7
    sub	w20,	w24,	w15
    mov	w15,	w16
    mov	w24,	w20
    b	main_347

main_364:
    cmp	w27,	#40
    bge	main_378

main_366:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    add	w17,	w14,	w20
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#440
    sub	w6,	w5,	w17
    movk	fp,	#2,	lsl #16
    add	w0,	w6,	w14
    ldr	w18,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w0,	w0,	w17
    ldr	w24,	[sp, fp]

    add	w1,	w18,	w0
    sub	w6,	w0,	w1
    mov	w0,	w9
    add	w16,	w6,	w24
    sub	w17,	w16,	w1
    b	main_375

main_378:
    cmp	w27,	#60
    bge	main_401

main_380:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#436
    add	w18,	w14,	w21
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#440
    add	w17,	w1,	w8
    movk	fp,	#2,	lsl #16
    add	w0,	w17,	w18
    ldr	w24,	[sp, fp]

    add	w7,	w24,	w14
    sub	w1,	w18,	w0
    add	w6,	w1,	w17
    sub	w17,	w6,	w0
    sub	w1,	w17,	w6
    add	w0,	w1,	w0
    sub	w3,	w0,	w6
    add	w0,	w7,	w3
    sub	w9,	w3,	w0
    add	w9,	w9,	w7
    sub	w16,	w9,	w0
    sub	w24,	w16,	w9
    add	w1,	w24,	w0
    sub	w16,	w1,	w9
    mov	w1,	w20
    mov	w18,	w16
    b	main_398

main_401:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#436
    add	w17,	w14,	w5
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#440
    sub	w6,	w19,	w17
    movk	fp,	#2,	lsl #16
    add	w7,	w6,	w14
    ldr	w26,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w0,	w7,	w17
    ldr	w13,	[sp, fp]

    add	w17,	w26,	w0
    sub	w7,	w0,	w17
    add	w3,	w7,	w13
    sub	w17,	w3,	w17
    mov	w18,	w17

main_398:
    mov	w17,	w18
    mov	w0,	w1

main_375:
    mov	w24,	w17
    mov	w15,	w0

main_347:
    lsl	w6,	w11,	#5
    asr	w18,	w11,	#31
    lsl	w20,	w27,	#2
    movz	fp,	#16
    lsr	w0,	w18,	#27
    mov	x17,	x20
    movk	fp,	#2,	lsl #16
    add	x17,	sp,	x17
    add	w7,	w11,	w0
    add	x17,	x17,	fp
    asr	w16,	w7,	#5
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    lsl	w0,	w16,	#5
    sub	w9,	w11,	w0
    ldr	w0,	[x17]

    ldr	w20,	[sp, fp]

    movz	fp,	#436
    add	w7,	w9,	w20
    movk	fp,	#2,	lsl #16
    add	w7,	w7,	w6
    ldr	w8,	[sp, fp]

    movz	fp,	#436
    lsl	w9,	w8,	#30
    movk	fp,	#2,	lsl #16
    add	w3,	w7,	w24
    ldr	w25,	[sp, fp]

    movz	fp,	#436
    asr	w16,	w25,	#31
    add	w7,	w3,	w15
    movk	fp,	#2,	lsl #16
    lsr	w21,	w16,	#2
    add	w20,	w7,	w0
    ldr	w0,	[sp, fp]

    movz	fp,	#436
    add	w1,	w0,	w21
    movk	fp,	#2,	lsl #16
    asr	w3,	w1,	#30
    ldr	w6,	[sp, fp]

    add	w1,	w27,	#1
    lsl	w7,	w3,	#30
    sub	w15,	w6,	w7
    add	w25,	w9,	w15
    cmp	w1,	#80
    blt	main_276

main_433:
    add	w15,	w20,	w10
    add	w24,	w11,	w12
    add	w6,	w25,	w4
    movz	fp,	#440
    add	w11,	w14,	w2
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    add	w1,	w5,	w22
    add	w5,	w28,	#64
    cmp	w5,	w23
    blt	main_62

main_441:
    movz	fp,	#484
    movz	w0,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#492
    str	w15,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#476
    str	w24,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#468
    str	w6,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#404
    str	w11,	[x22]

    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    str	w1,	[x23]


main_442:
    cmp	w0,	#5
    bge	main_455

main_445:
    lsl	w17,	w0,	#2
    movz	fp,	#336
    lsl	w12,	w0,	#2
    mov	x24,	x17
    movk	fp,	#2,	lsl #16
    add	w0,	w0,	#1
    mov	x11,	x12
    add	x24,	sp,	x24
    add	x11,	sp,	x11
    add	x24,	x24,	fp
    movz	fp,	#356
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

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w10,	w15
    mov	w12,	w24
    mov	w4,	w6
    mov	w2,	w11
    mov	w22,	w1
    mov	w28,	w5
    b	main_63

main_276:
    mov	w18,	w20
    movz	fp,	#436
    mov	w26,	w11
    mov	w15,	w14
    mov	w8,	w1
    mov	w13,	w25
    movk	fp,	#2,	lsl #16
    str	w18,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#420
    mov	w3,	w11
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w13,	[sp, fp]

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


