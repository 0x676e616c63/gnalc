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
    movz	w26,	#0
    movz	fp,	#336
    movz	w24,	#0
    movz	w23,	#0
    movz	w25,	#0
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
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#468
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
    mov	x26,	x21
    add	x8,	x21,	#12
    add	x16,	x21,	#16
    movk	fp,	#2,	lsl #16
    movk	w11,	#1,	lsl #16
    str	x17,	[sp, fp]

    add	x17,	x21,	#4
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#460
    add	x25,	x0,	x11
    movk	fp,	#2,	lsl #16
    mov	w0,	w19
    add	x11,	x21,	#8
    str	x25,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#628
    movk	fp,	#2,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#636
    movk	fp,	#2,	lsl #16
    str	x17,	[sp, fp]

    movz	fp,	#484
    movk	fp,	#2,	lsl #16
    str	x11,	[sp, fp]

    mov	w11,	w27
    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x8,	[sp, fp]

    movz	fp,	#572
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
    movz	fp,	#460
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
    add	w21,	w16,	#4
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
    add	w0,	w16,	#3
    movz	w2,	#0
    str	w23,	[x22]

    lsl	w25,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#452
    add	x24,	x1,	x25
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w2,	[x24]

    movz	w2,	#320
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w1,	#0
    movz	w17,	#8961
    movz	w26,	#43913
    movz	w5,	#56574
    movz	w6,	#21622
    movz	w19,	#57840
    movk	w17,	#26437,	lsl #16
    movk	w26,	#61389,	lsl #16
    movk	w5,	#39098,	lsl #16
    movk	w6,	#4146,	lsl #16
    movk	w19,	#50130,	lsl #16
    mov	w12,	w17
    mov	w3,	w26
    mov	w13,	w5
    mov	w22,	w6
    mov	w0,	w19

main_63:
    movz	w23,	#0
    mov	w26,	w1
    mov	w16,	w23

main_70:
    cmp	w16,	#14
    bge	main_215

main_74:
    lsl	w23,	w16,	#2
    lsl	w8,	w26,	#2
    movz	fp,	#444
    add	w15,	w26,	#2
    add	w10,	w26,	#3
    add	w16,	w16,	#1
    mov	x19,	x23
    movk	fp,	#2,	lsl #16
    add	x19,	sp,	x19
    lsl	w17,	w10,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#444
    add	x7,	x4,	x8
    add	x19,	x19,	#16
    movk	fp,	#2,	lsl #16
    add	w4,	w26,	#1
    ldr	w9,	[x7]

    ldr	x14,	[sp, fp]

    lsl	w18,	w9,	#24
    lsl	w24,	w4,	#2
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    add	x5,	x14,	x24
    ldr	w8,	[x5]

    ldr	x27,	[sp, fp]

    lsl	w9,	w8,	#16
    movz	fp,	#444
    add	w11,	w9,	w18
    movk	fp,	#2,	lsl #16
    lsl	w9,	w15,	#2
    add	w15,	w26,	#4
    add	x25,	x27,	x9
    add	w24,	w15,	#2
    ldr	w4,	[x25]

    ldr	x2,	[sp, fp]

    lsl	w6,	w4,	#8
    movz	fp,	#444
    add	w7,	w11,	w6
    movk	fp,	#2,	lsl #16
    add	x11,	x2,	x17
    add	w17,	w15,	#4
    lsl	w2,	w15,	#2
    ldr	w23,	[x11]

    lsl	w11,	w16,	#2
    add	w10,	w7,	w23
    mov	x8,	x11
    lsl	w11,	w24,	#2
    add	x8,	sp,	x8
    str	w10,	[x19]

    ldr	x14,	[sp, fp]

    add	x8,	x8,	#16
    movz	fp,	#444
    add	x27,	x14,	x2
    movk	fp,	#2,	lsl #16
    add	w2,	w15,	#1
    ldr	w5,	[x27]

    lsl	w19,	w2,	#2
    lsl	w26,	w5,	#24
    ldr	x5,	[sp, fp]

    movz	fp,	#444
    add	x4,	x5,	x19
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x4]

    ldr	x7,	[sp, fp]

    lsl	w10,	w9,	#16
    movz	fp,	#444
    add	x4,	x7,	x11
    add	w19,	w10,	w26
    movk	fp,	#2,	lsl #16
    add	w11,	w15,	#3
    ldr	w7,	[x4]

    ldr	x14,	[sp, fp]

    lsl	w9,	w7,	#8
    lsl	w23,	w11,	#2
    movz	fp,	#444
    add	w24,	w19,	w9
    movk	fp,	#2,	lsl #16
    add	x14,	x14,	x23
    add	w9,	w16,	#1
    ldr	w26,	[x14]

    lsl	w11,	w9,	#2
    add	w7,	w24,	w26
    add	w24,	w17,	#2
    str	w7,	[x8]

    lsl	w2,	w24,	#2
    ldr	x4,	[sp, fp]

    lsl	w8,	w17,	#2
    mov	x7,	x11
    movz	fp,	#444
    add	w11,	w17,	#1
    add	x7,	sp,	x7
    add	x5,	x4,	x8
    movk	fp,	#2,	lsl #16
    add	w8,	w17,	#3
    lsl	w16,	w11,	#2
    ldr	w10,	[x5]

    add	x7,	x7,	#16
    ldr	x20,	[sp, fp]

    lsl	w5,	w10,	#24
    movz	fp,	#444
    add	x14,	x20,	x16
    movk	fp,	#2,	lsl #16
    ldr	w16,	[x14]

    ldr	x23,	[sp, fp]

    lsl	w18,	w16,	#16
    movz	fp,	#444
    add	x26,	x23,	x2
    add	w16,	w9,	#1
    add	w18,	w18,	w5
    movk	fp,	#2,	lsl #16
    add	w23,	w17,	#4
    ldr	w2,	[x26]

    add	w26,	w16,	#1
    lsl	w4,	w2,	#8
    add	w9,	w23,	#1
    lsl	w2,	w23,	#2
    add	w6,	w18,	w4
    lsl	w4,	w8,	#2
    lsl	w15,	w9,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#444
    add	x24,	x8,	x4
    movk	fp,	#2,	lsl #16
    lsl	w4,	w16,	#2
    mov	x10,	x4
    ldr	w5,	[x24]

    add	x10,	sp,	x10
    add	w11,	w6,	w5
    add	x10,	x10,	#16
    str	w11,	[x7]

    ldr	x14,	[sp, fp]

    movz	fp,	#444
    add	x27,	x14,	x2
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x27]

    add	w27,	w23,	#3
    ldr	x8,	[sp, fp]

    lsl	w4,	w5,	#24
    movz	fp,	#444
    add	x11,	x8,	x15
    lsl	w5,	w26,	#2
    movk	fp,	#2,	lsl #16
    add	w8,	w23,	#2
    ldr	w18,	[x11]

    ldr	x17,	[sp, fp]

    lsl	w11,	w8,	#2
    lsl	w24,	w18,	#16
    movz	fp,	#444
    add	x9,	x17,	x11
    add	w18,	w23,	#4
    add	w4,	w24,	w4
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x9]

    lsl	w8,	w18,	#2
    ldr	x17,	[sp, fp]

    lsl	w19,	w15,	#8
    movz	fp,	#444
    add	w15,	w18,	#1
    add	w7,	w4,	w19
    movk	fp,	#2,	lsl #16
    lsl	w4,	w27,	#2
    lsl	w24,	w15,	#2
    add	x2,	x17,	x4
    add	w15,	w18,	#4
    mov	x4,	x5
    add	w5,	w18,	#2
    add	x4,	sp,	x4
    ldr	w6,	[x2]

    add	w7,	w7,	w6
    add	x4,	x4,	#16
    str	w7,	[x10]

    ldr	x25,	[sp, fp]

    movz	fp,	#444
    add	x6,	x25,	x8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w5,	#2
    ldr	w9,	[x6]

    add	w6,	w18,	#3
    ldr	x19,	[sp, fp]

    lsl	w10,	w9,	#24
    movz	fp,	#444
    add	x16,	x19,	x24
    movk	fp,	#2,	lsl #16
    lsl	w9,	w6,	#2
    ldr	w25,	[x16]

    add	w16,	w15,	#1
    ldr	x19,	[sp, fp]

    lsl	w27,	w25,	#16
    movz	fp,	#444
    add	x7,	x19,	x8
    movk	fp,	#2,	lsl #16
    add	w27,	w27,	w10
    ldr	w10,	[x7]

    ldr	x28,	[sp, fp]

    lsl	w11,	w10,	#8
    movz	fp,	#444
    add	x8,	x28,	x9
    add	w14,	w27,	w11
    movk	fp,	#2,	lsl #16
    lsl	w11,	w16,	#2
    ldr	w10,	[x8]

    add	w16,	w15,	#2
    add	w10,	w14,	w10
    lsl	w9,	w16,	#2
    str	w10,	[x4]

    ldr	x7,	[sp, fp]

    add	w10,	w26,	#1
    movz	fp,	#444
    lsl	w26,	w15,	#2
    movk	fp,	#2,	lsl #16
    lsl	w24,	w10,	#2
    add	x25,	x7,	x26
    mov	x6,	x24
    add	x6,	sp,	x6
    ldr	w27,	[x25]

    ldr	x28,	[sp, fp]

    lsl	w7,	w27,	#24
    add	x6,	x6,	#16
    movz	fp,	#444
    add	x19,	x28,	x11
    add	w27,	w15,	#3
    movk	fp,	#2,	lsl #16
    ldr	w4,	[x19]

    ldr	x11,	[sp, fp]

    lsl	w5,	w4,	#16
    movz	fp,	#444
    add	x18,	x11,	x9
    add	w8,	w5,	w7
    movk	fp,	#2,	lsl #16
    lsl	w7,	w27,	#2
    add	w5,	w10,	#1
    ldr	w24,	[x18]

    add	w10,	w15,	#4
    ldr	x14,	[sp, fp]

    lsl	w26,	w24,	#8
    movz	fp,	#444
    add	x4,	x14,	x7
    add	w15,	w10,	#2
    add	w23,	w10,	#1
    add	w24,	w8,	w26
    movk	fp,	#2,	lsl #16
    add	w14,	w10,	#3
    ldr	w9,	[x4]

    lsl	w16,	w23,	#2
    add	w26,	w10,	#4
    lsl	w4,	w10,	#2
    add	w2,	w24,	w9
    lsl	w9,	w5,	#2
    add	w5,	w5,	#1
    mov	x8,	x9
    str	w2,	[x6]

    add	x8,	sp,	x8
    ldr	x18,	[sp, fp]

    movz	fp,	#444
    add	x19,	x18,	x4
    add	x8,	x8,	#16
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x19]

    ldr	x19,	[sp, fp]

    lsl	w18,	w6,	#24
    movz	fp,	#444
    add	x24,	x19,	x16
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    ldr	x19,	[sp, fp]

    lsl	w2,	w27,	#16
    movz	fp,	#444
    lsl	w27,	w15,	#2
    add	w4,	w2,	w18
    movk	fp,	#2,	lsl #16
    add	x16,	x19,	x27
    ldr	w24,	[x16]

    ldr	x23,	[sp, fp]

    lsl	w16,	w14,	#2
    lsl	w6,	w24,	#8
    add	x15,	x23,	x16
    add	w6,	w4,	w6
    mov	w16,	w5
    ldr	w17,	[x15]

    add	w11,	w6,	w17
    str	w11,	[x8]

    b	main_70

main_215:
    mov	w24,	w26
    mov	w6,	w16

main_217:
    lsl	w10,	w6,	#2
    lsl	w16,	w24,	#2
    movz	fp,	#444
    add	w7,	w24,	#1
    add	w4,	w24,	#2
    mov	x9,	x10
    movk	fp,	#2,	lsl #16
    add	x9,	sp,	x9
    lsl	w2,	w7,	#2
    ldr	x8,	[sp, fp]

    add	x9,	x9,	#16
    movz	fp,	#444
    add	x18,	x8,	x16
    movk	fp,	#2,	lsl #16
    ldr	w25,	[x18]

    lsl	w18,	w4,	#2
    ldr	x7,	[sp, fp]

    lsl	w27,	w25,	#24
    movz	fp,	#444
    add	x10,	x7,	x2
    add	w25,	w24,	#4
    movk	fp,	#2,	lsl #16
    add	w7,	w24,	#3
    ldr	w14,	[x10]

    lsl	w26,	w7,	#2
    ldr	x8,	[sp, fp]

    lsl	w17,	w14,	#16
    movz	fp,	#444
    add	x5,	x8,	x18
    movk	fp,	#2,	lsl #16
    add	w17,	w17,	w27
    add	w27,	w6,	#1
    ldr	w11,	[x5]

    lsl	w14,	w11,	#8
    ldr	x11,	[sp, fp]

    add	w14,	w17,	w14
    add	x10,	x11,	x26
    ldr	w18,	[x10]

    add	w26,	w14,	w18
    str	w26,	[x9]

    cmp	w27,	#16
    bge	main_241

main_216:
    mov	w24,	w25
    mov	w6,	w27
    b	main_217

main_241:
    mov	w16,	w27
    movz	fp,	#624
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]


main_242:
    movz	fp,	#624
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    cmp	w10,	#80
    bge	main_275

main_245:
    movz	fp,	#624
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#624
    lsl	w25,	w11,	#2
    movk	fp,	#2,	lsl #16
    mov	x23,	x25
    add	x23,	sp,	x23
    ldr	w26,	[sp, fp]

    movz	fp,	#624
    sub	w2,	w26,	#3
    add	x23,	x23,	#16
    movk	fp,	#2,	lsl #16
    lsl	w6,	w2,	#2
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w5,	[sp, fp]

    movz	fp,	#624
    sub	w9,	w5,	#8
    movk	fp,	#2,	lsl #16
    lsl	w11,	w9,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w14,	[x10]

    ldr	w6,	[sp, fp]

    add	w10,	w14,	w7
    movz	fp,	#624
    sub	w26,	w6,	#14
    movk	fp,	#2,	lsl #16
    sub	w16,	w7,	w10
    lsl	w4,	w26,	#2
    mov	x27,	x4
    add	w24,	w16,	w14
    add	x27,	sp,	x27
    sub	w10,	w24,	w10
    add	x27,	x27,	#16
    ldr	w6,	[x27]

    add	w2,	w6,	w10
    sub	w7,	w10,	w2
    add	w14,	w7,	w6
    ldr	w7,	[sp, fp]

    movz	fp,	#624
    sub	w4,	w7,	#16
    sub	w26,	w14,	w2
    movk	fp,	#2,	lsl #16
    lsl	w7,	w4,	#2
    mov	x5,	x7
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w8,	[x5]

    add	w7,	w8,	w26
    sub	w14,	w26,	w7
    add	w15,	w14,	w8
    sub	w18,	w15,	w7
    asr	w4,	w18,	#31
    lsl	w11,	w18,	#1
    lsr	w5,	w4,	#31
    add	w7,	w18,	w5
    asr	w16,	w7,	#1
    lsl	w17,	w16,	#1
    sub	w8,	w18,	w17
    add	w9,	w11,	w8
    str	w9,	[x23]

    ldr	w18,	[sp, fp]

    movz	fp,	#624
    add	w10,	w18,	#1
    movk	fp,	#2,	lsl #16
    mov	w9,	w10
    str	w9,	[sp, fp]

    b	main_242

main_275:
    mov	w27,	w12
    movz	fp,	#436
    mov	w4,	w3
    mov	w19,	w13
    mov	w14,	w22
    mov	w6,	w0
    movz	w9,	#0
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]

    mov	w4,	w9
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w19,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w14,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w4,	[sp, fp]


main_277:
    movz	w5,	#48348
    movz	w16,	#60289
    movz	w2,	#31129
    movz	w26,	#65535
    movz	fp,	#412
    movk	w5,	#36635,	lsl #16
    movk	w16,	#28377,	lsl #16
    movk	w2,	#23170,	lsl #16
    movk	w26,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w24,	w5
    mov	w11,	w16
    mov	w18,	w2
    mov	w19,	w26
    ldr	w17,	[sp, fp]

    movz	w5,	#49414
    movk	w5,	#51810,	lsl #16
    cmp	w17,	#20
    bge	main_296

main_285:
    movz	fp,	#432
    mov	w4,	w19
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#432
    add	w7,	w26,	w20
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#416
    sub	w4,	w4,	w16
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    add	w16,	w23,	w4
    add	w17,	w16,	w7
    sub	w9,	w7,	w17
    add	w27,	w9,	w16
    sub	w14,	w27,	w17
    sub	w4,	w14,	w27
    add	w14,	w4,	w17
    sub	w9,	w14,	w27
    mov	w27,	w18
    b	main_416

main_296:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    cmp	w23,	#40
    bge	main_307

main_298:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#432
    add	w9,	w2,	w25
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#440
    sub	w14,	w25,	w9
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#416
    add	w27,	w14,	w10
    movk	fp,	#2,	lsl #16
    sub	w14,	w27,	w9
    mov	w27,	w11
    ldr	w9,	[sp, fp]

    movz	fp,	#416
    add	w7,	w9,	w14
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    sub	w4,	w14,	w7
    add	w4,	w4,	w28
    sub	w9,	w4,	w7
    mov	w14,	w9
    b	main_413

main_307:
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    cmp	w25,	#60
    bge	main_327

main_309:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#416
    add	w27,	w15,	w9
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#416
    add	w14,	w14,	w25
    movk	fp,	#2,	lsl #16
    add	w26,	w14,	w27
    ldr	w20,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w16,	w27,	w26
    ldr	w23,	[sp, fp]

    add	w2,	w16,	w14
    sub	w4,	w2,	w26
    sub	w14,	w4,	w2
    add	w17,	w14,	w26
    add	w26,	w20,	w23
    sub	w9,	w17,	w2
    add	w17,	w26,	w9
    sub	w27,	w9,	w17
    add	w14,	w27,	w26
    mov	w27,	w24
    sub	w4,	w14,	w17
    sub	w4,	w4,	w14
    add	w16,	w4,	w17
    sub	w9,	w16,	w14
    mov	w14,	w9
    b	main_413

main_327:
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#432
    add	w7,	w23,	w14
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#440
    sub	w4,	w15,	w7
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#416
    add	w27,	w4,	w25
    movk	fp,	#2,	lsl #16
    sub	w7,	w27,	w7
    ldr	w23,	[sp, fp]

    mov	w27,	w5
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w4,	w23,	w7
    ldr	w15,	[sp, fp]

    sub	w16,	w7,	w4
    add	w14,	w16,	w15
    sub	w9,	w14,	w4
    mov	w14,	w9

main_413:
    mov	w9,	w14

main_416:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#436
    lsl	w16,	w4,	#5
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#436
    asr	w17,	w15,	#31
    movk	fp,	#2,	lsl #16
    lsr	w26,	w17,	#27
    ldr	w20,	[sp, fp]

    movz	fp,	#436
    add	w14,	w20,	w26
    movk	fp,	#2,	lsl #16
    asr	w17,	w14,	#5
    ldr	w28,	[sp, fp]

    movz	fp,	#412
    lsl	w26,	w17,	#5
    movk	fp,	#2,	lsl #16
    sub	w14,	w28,	w26
    ldr	w25,	[sp, fp]

    movz	fp,	#432
    lsl	w4,	w25,	#2
    movk	fp,	#2,	lsl #16
    add	w26,	w16,	w14
    mov	x16,	x4
    add	x16,	sp,	x16
    add	w2,	w26,	w6
    add	x16,	x16,	#16
    add	w9,	w2,	w9
    ldr	w16,	[x16]

    add	w14,	w9,	w27
    ldr	w23,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w14,	w14,	w16
    lsl	w16,	w23,	#30
    ldr	w23,	[sp, fp]

    movz	fp,	#432
    asr	w7,	w23,	#31
    movk	fp,	#2,	lsl #16
    lsr	w26,	w7,	#2
    ldr	w17,	[sp, fp]

    movz	fp,	#432
    add	w26,	w17,	w26
    movk	fp,	#2,	lsl #16
    asr	w9,	w26,	#30
    ldr	w23,	[sp, fp]

    movz	fp,	#412
    lsl	w7,	w9,	#30
    movk	fp,	#2,	lsl #16
    sub	w17,	w23,	w7
    ldr	w23,	[sp, fp]

    add	w2,	w23,	#1
    add	w17,	w16,	w17
    cmp	w2,	#20
    bge	main_364

main_336:
    movz	fp,	#436
    mov	w16,	w19
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#436
    add	w23,	w17,	w5
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#440
    sub	w5,	w16,	w6
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    add	w6,	w16,	w5
    add	w9,	w6,	w23
    sub	w23,	w23,	w9
    add	w19,	w23,	w6
    sub	w23,	w19,	w9
    sub	w24,	w23,	w19
    add	w27,	w24,	w9
    sub	w23,	w27,	w19
    mov	w25,	w23
    b	main_347

main_364:
    cmp	w2,	#40
    bge	main_378

main_366:
    movz	fp,	#436
    mov	w4,	w11
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#436
    add	w23,	w17,	w25
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#440
    sub	w9,	w9,	w23
    movk	fp,	#2,	lsl #16
    add	w5,	w9,	w17
    sub	w5,	w5,	w23
    ldr	w23,	[sp, fp]

    movz	fp,	#440
    add	w6,	w23,	w5
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    sub	w16,	w5,	w6
    add	w19,	w16,	w27
    sub	w23,	w19,	w6
    b	main_375

main_378:
    cmp	w2,	#60
    bge	main_401

main_380:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#436
    add	w26,	w17,	w26
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#440
    add	w23,	w7,	w11
    movk	fp,	#2,	lsl #16
    add	w5,	w23,	w26
    ldr	w27,	[sp, fp]

    add	w18,	w27,	w17
    sub	w6,	w26,	w5
    add	w11,	w6,	w23
    sub	w23,	w11,	w5
    sub	w6,	w23,	w11
    add	w5,	w6,	w5
    sub	w7,	w5,	w11
    add	w5,	w18,	w7
    sub	w16,	w7,	w5
    add	w16,	w16,	w18
    sub	w19,	w16,	w5
    sub	w27,	w19,	w16
    add	w6,	w27,	w5
    sub	w19,	w6,	w16
    mov	w6,	w24
    mov	w25,	w19
    b	main_398

main_401:
    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#436
    add	w23,	w17,	w8
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#440
    sub	w11,	w24,	w23
    movk	fp,	#2,	lsl #16
    add	w16,	w11,	w17
    ldr	w6,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    sub	w7,	w16,	w23
    ldr	w16,	[sp, fp]

    add	w23,	w6,	w7
    mov	w6,	w5
    sub	w18,	w7,	w23
    add	w7,	w18,	w16
    sub	w23,	w7,	w23
    mov	w25,	w23

main_398:
    mov	w23,	w25
    mov	w4,	w6

main_375:
    mov	w25,	w23
    mov	w18,	w4

main_347:
    lsl	w9,	w14,	#5
    asr	w24,	w14,	#31
    lsl	w26,	w2,	#2
    movz	fp,	#416
    lsr	w5,	w24,	#27
    mov	x23,	x26
    movk	fp,	#2,	lsl #16
    add	x23,	sp,	x23
    add	w11,	w14,	w5
    add	x23,	x23,	#16
    asr	w19,	w11,	#5
    lsl	w5,	w19,	#5
    sub	w19,	w14,	w5
    ldr	w5,	[x23]

    ldr	w26,	[sp, fp]

    movz	fp,	#436
    add	w15,	w19,	w26
    movk	fp,	#2,	lsl #16
    add	w15,	w15,	w9
    ldr	w11,	[sp, fp]

    movz	fp,	#436
    movk	fp,	#2,	lsl #16
    add	w7,	w15,	w25
    ldr	w28,	[sp, fp]

    movz	fp,	#436
    asr	w19,	w28,	#31
    add	w15,	w7,	w18
    movk	fp,	#2,	lsl #16
    lsr	w26,	w19,	#2
    ldr	w6,	[sp, fp]

    add	w25,	w15,	w5
    movz	fp,	#436
    add	w6,	w6,	w26
    lsl	w15,	w11,	#30
    movk	fp,	#2,	lsl #16
    add	w26,	w2,	#1
    asr	w9,	w6,	#30
    lsl	w16,	w9,	#30
    ldr	w9,	[sp, fp]

    sub	w18,	w9,	w16
    add	w19,	w15,	w18
    cmp	w26,	#80
    blt	main_276

main_433:
    add	w16,	w25,	w12
    add	w6,	w14,	w3
    add	w19,	w19,	w13
    add	w4,	w17,	w22
    movz	fp,	#440
    add	w7,	w1,	#64
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    add	w0,	w10,	w0
    cmp	w7,	w21
    blt	main_62

main_441:
    movz	fp,	#628
    movz	w27,	#0
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#636
    str	w16,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x3,	[sp, fp]

    movz	fp,	#484
    str	w6,	[x3]

    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#476
    str	w19,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#572
    str	w4,	[x22]

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

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    mov	w0,	w6
    b	main_28

main_62:
    mov	w12,	w16
    mov	w3,	w6
    mov	w13,	w19
    mov	w22,	w4
    mov	w1,	w7
    b	main_63

main_276:
    mov	w20,	w25
    movz	fp,	#436
    mov	w7,	w14
    mov	w16,	w17
    mov	w10,	w26
    mov	w15,	w19
    movk	fp,	#2,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w16,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#412
    mov	w6,	w11
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    b	main_277

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#468
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


