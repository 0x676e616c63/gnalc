.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#624
    movk	fp,	#2,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#336
    movk	w2,	#2,	lsl #16
    bl	memset
    movz	w24,	#0
    movz	fp,	#336
    movz	w23,	#0
    movz	w22,	#0
    movz	w25,	#0
    movk	fp,	#2,	lsl #16
    add	x27,	sp,	fp
    movz	fp,	#340
    movk	fp,	#2,	lsl #16
    str	w25,	[x27]

    add	x19,	sp,	fp
    movz	fp,	#344
    movk	fp,	#2,	lsl #16
    str	w24,	[x19]

    add	x20,	sp,	fp
    movz	fp,	#348
    movk	fp,	#2,	lsl #16
    str	w23,	[x20]

    add	x21,	sp,	fp
    movz	fp,	#352
    movk	fp,	#2,	lsl #16
    str	w22,	[x21]

    add	x23,	sp,	fp
    movz	w21,	#0
    str	w21,	[x23]

    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w26,	w0
    movz	w0,	#161
    bl	_sysy_starttime
    movz	w6,	#0
    movz	w4,	#0
    movz	fp,	#356
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    add	x2,	sp,	fp
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	x2,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#360
    str	w6,	[x14]

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
    add	x9,	sp,	#336
    movz	fp,	#432
    movz	w15,	#62464
    add	x22,	sp,	#16
    mov	x3,	x27
    add	x16,	x27,	#4
    add	x13,	x27,	#8
    add	x10,	x27,	#12
    add	x18,	x27,	#16
    mov	w21,	w26
    mov	w0,	w28
    movk	fp,	#2,	lsl #16
    movk	w15,	#1,	lsl #16
    str	x9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#400
    add	x25,	x19,	x15
    movk	fp,	#2,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#384
    movk	fp,	#2,	lsl #16
    str	x3,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#504
    movk	fp,	#2,	lsl #16
    str	x13,	[sp, fp]

    movz	fp,	#496
    movk	fp,	#2,	lsl #16
    str	x10,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	x18,	[sp, fp]


main_28:
    movz	w22,	#0
    movz	fp,	#412
    mov	w20,	w22
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_31:
    movz	w13,	#32000
    cmp	w20,	w13
    blt	main_35

main_45:
    movz	w3,	#128
    movz	fp,	#400
    movz	w9,	#32001
    movk	fp,	#2,	lsl #16
    ldr	x11,	[sp, fp]

    str	w3,	[x11]

    mov	w3,	w9

main_46:
    asr	w9,	w3,	#31
    lsr	w10,	w9,	#26
    add	w11,	w3,	w10
    asr	w17,	w11,	#6
    lsl	w18,	w17,	#6
    sub	w0,	w3,	w18
    cmp	w0,	#60
    bne	main_50

main_53:
    lsl	w1,	w3,	#2
    movz	fp,	#432
    movz	w2,	#0
    add	w20,	w3,	#1
    add	w28,	w3,	#3
    movk	fp,	#2,	lsl #16
    lsl	w22,	w20,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#432
    add	x0,	x19,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#125
    str	w2,	[x0]

    movz	w0,	#0
    ldr	x19,	[sp, fp]

    movz	fp,	#432
    add	x24,	x19,	x22
    movk	fp,	#2,	lsl #16
    str	w0,	[x24]

    ldr	x0,	[sp, fp]

    add	w24,	w3,	#2
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    lsl	w27,	w24,	#2
    add	x26,	x0,	x27
    add	w27,	w3,	#4
    str	w1,	[x26]

    ldr	x2,	[sp, fp]

    lsl	w1,	w28,	#2
    movz	fp,	#576
    movz	w28,	#0
    add	x2,	x2,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w28,	[x2]

    movz	w2,	#320
    str	w27,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    bl	memset
    movz	fp,	#440
    movz	w16,	#8961
    movz	w7,	#43913
    movz	w0,	#21622
    movz	w20,	#56574
    movz	w4,	#57840
    movk	fp,	#2,	lsl #16
    movk	w16,	#26437,	lsl #16
    movk	w7,	#61389,	lsl #16
    movk	w0,	#4146,	lsl #16
    movk	w20,	#39098,	lsl #16
    movk	w4,	#50130,	lsl #16
    mov	w11,	w16
    mov	w28,	w7
    mov	w5,	w0
    mov	w19,	w20
    mov	w16,	w4
    movz	w0,	#0
    mov	w26,	w0
    str	w26,	[sp, fp]


main_63:
    movz	w1,	#0
    movz	fp,	#440
    mov	w7,	w1
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    mov	w22,	w24

main_70:
    cmp	w7,	#14
    blt	main_74

main_215:
    mov	w6,	w7

main_217:
    lsl	w17,	w6,	#2
    lsl	w0,	w22,	#2
    movz	fp,	#432
    add	w9,	w22,	#1
    add	w8,	w22,	#2
    add	w18,	w22,	#3
    mov	x1,	x17
    movk	fp,	#2,	lsl #16
    lsl	w3,	w9,	#2
    add	w22,	w22,	#4
    lsl	w27,	w18,	#2
    add	x1,	sp,	x1
    ldr	x7,	[sp, fp]

    movz	fp,	#432
    add	x10,	x7,	x0
    add	x1,	x1,	#16
    movk	fp,	#2,	lsl #16
    ldr	w2,	[x10]

    ldr	x7,	[sp, fp]

    lsl	w4,	w2,	#24
    movz	fp,	#432
    add	x10,	x7,	x3
    movk	fp,	#2,	lsl #16
    lsl	w3,	w8,	#2
    ldr	w0,	[x10]

    ldr	x12,	[sp, fp]

    lsl	w2,	w0,	#16
    movz	fp,	#432
    add	x10,	x12,	x3
    add	w4,	w2,	w4
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x10]

    ldr	x7,	[sp, fp]

    lsl	w14,	w13,	#8
    add	x20,	x7,	x27
    add	w9,	w4,	w14
    add	w7,	w6,	#1
    ldr	w27,	[x20]

    add	w10,	w9,	w27
    str	w10,	[x1]

    cmp	w7,	#16
    blt	main_216

main_242:
    cmp	w7,	#80
    blt	main_245

main_275:
    mov	w13,	w11
    movz	fp,	#424
    mov	w1,	w28
    mov	w8,	w19
    mov	w3,	w5
    mov	w26,	w16
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    mov	w7,	w6
    str	w13,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]


main_277:
    movz	w10,	#60289
    movz	w17,	#48348
    movz	w24,	#49414
    movz	w12,	#31129
    movz	w27,	#65535
    movz	fp,	#408
    movk	w10,	#28377,	lsl #16
    movk	w17,	#36635,	lsl #16
    movk	w24,	#51810,	lsl #16
    movk	w12,	#23170,	lsl #16
    movk	w27,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w1,	w17
    mov	w20,	w24
    mov	w2,	w12
    ldr	w17,	[sp, fp]

    mov	w24,	w27
    cmp	w17,	#20
    blt	main_285

main_370:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    cmp	w0,	#40
    blt	main_372

main_381:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    cmp	w3,	#60
    blt	main_383

main_401:
    movz	fp,	#416
    mov	w18,	w20
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    add	w17,	w17,	w14
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#428
    sub	w8,	w13,	w17
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#420
    add	w9,	w8,	w25
    movk	fp,	#2,	lsl #16
    sub	w27,	w9,	w17
    ldr	w7,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    add	w9,	w7,	w27
    ldr	w4,	[sp, fp]

    sub	w6,	w27,	w9
    add	w23,	w6,	w4
    sub	w7,	w23,	w9
    b	main_410

main_383:
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#420
    add	w9,	w3,	w25
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#420
    add	w27,	w15,	w14
    movk	fp,	#2,	lsl #16
    add	w17,	w27,	w9
    ldr	w15,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    sub	w12,	w9,	w17
    ldr	w3,	[sp, fp]

    add	w7,	w12,	w27
    sub	w18,	w7,	w17
    sub	w23,	w18,	w7
    add	w18,	w15,	w3
    add	w27,	w23,	w17
    sub	w9,	w27,	w7
    add	w17,	w18,	w9
    sub	w8,	w9,	w17
    add	w6,	w8,	w18
    mov	w18,	w1
    sub	w23,	w6,	w17
    sub	w8,	w23,	w6
    add	w12,	w8,	w17
    sub	w7,	w12,	w6

main_410:
    mov	w23,	w18
    b	main_416

main_372:
    movz	fp,	#416
    mov	w23,	w10
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#416
    add	w18,	w7,	w3
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#428
    sub	w9,	w3,	w18
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#420
    add	w17,	w9,	w6
    movk	fp,	#2,	lsl #16
    sub	w9,	w17,	w18
    ldr	w17,	[sp, fp]

    movz	fp,	#420
    add	w25,	w17,	w9
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    sub	w7,	w9,	w25
    add	w17,	w7,	w14
    sub	w7,	w17,	w25
    b	main_416

main_285:
    movz	fp,	#416
    mov	w8,	w24
    mov	w23,	w2
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#416
    add	w25,	w13,	w7
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#420
    sub	w8,	w8,	w12
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    add	w8,	w17,	w8
    add	w17,	w8,	w25
    sub	w18,	w25,	w17
    add	w8,	w18,	w8
    sub	w27,	w8,	w17
    sub	w9,	w27,	w8
    add	w6,	w9,	w17
    sub	w7,	w6,	w8

main_416:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#424
    lsl	w6,	w4,	#5
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#424
    asr	w17,	w3,	#31
    movk	fp,	#2,	lsl #16
    lsr	w8,	w17,	#27
    ldr	w12,	[sp, fp]

    movz	fp,	#424
    add	w22,	w12,	w8
    movk	fp,	#2,	lsl #16
    asr	w27,	w22,	#5
    ldr	w12,	[sp, fp]

    movz	fp,	#408
    lsl	w18,	w27,	#5
    movk	fp,	#2,	lsl #16
    sub	w12,	w12,	w18
    add	w9,	w6,	w12
    ldr	w6,	[sp, fp]

    movz	fp,	#416
    lsl	w6,	w6,	#2
    add	w26,	w9,	w26
    movk	fp,	#2,	lsl #16
    mov	x6,	x6
    add	x6,	sp,	x6
    add	w22,	w26,	w7
    add	x6,	x6,	#16
    add	w27,	w22,	w23
    ldr	w12,	[x6]

    ldr	w14,	[sp, fp]

    add	w6,	w27,	w12
    movz	fp,	#416
    lsl	w7,	w14,	#30
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#416
    asr	w22,	w17,	#31
    movk	fp,	#2,	lsl #16
    lsr	w23,	w22,	#2
    ldr	w15,	[sp, fp]

    movz	fp,	#416
    add	w25,	w15,	w23
    movk	fp,	#2,	lsl #16
    asr	w9,	w25,	#30
    ldr	w18,	[sp, fp]

    movz	fp,	#408
    lsl	w17,	w9,	#30
    movk	fp,	#2,	lsl #16
    sub	w9,	w18,	w17
    ldr	w0,	[sp, fp]

    add	w3,	w0,	#1
    add	w12,	w7,	w9
    cmp	w3,	#20
    blt	main_359

main_296:
    cmp	w3,	#40
    blt	main_350

main_298:
    cmp	w3,	#60
    blt	main_300

main_341:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#424
    add	w17,	w12,	w7
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#428
    sub	w1,	w15,	w17
    movk	fp,	#2,	lsl #16
    add	w2,	w1,	w12
    ldr	w4,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    sub	w7,	w2,	w17
    ldr	w14,	[sp, fp]

    add	w22,	w4,	w7
    sub	w9,	w7,	w22
    add	w13,	w9,	w14
    sub	w18,	w13,	w22
    mov	w13,	w20
    mov	w22,	w18
    b	main_318

main_300:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#424
    add	w24,	w12,	w14
    movk	fp,	#2,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w22,	w18,	w2
    movk	fp,	#2,	lsl #16
    add	w25,	w22,	w24
    ldr	w14,	[sp, fp]

    add	w27,	w14,	w12
    sub	w8,	w24,	w25
    add	w7,	w8,	w22
    sub	w17,	w7,	w25
    sub	w20,	w17,	w7
    add	w24,	w20,	w25
    sub	w25,	w24,	w7
    add	w13,	w27,	w25
    sub	w8,	w25,	w13
    add	w0,	w8,	w27
    sub	w10,	w0,	w13
    sub	w17,	w10,	w0
    add	w23,	w17,	w13
    mov	w13,	w1
    sub	w20,	w23,	w0
    mov	w22,	w20

main_318:
    mov	w26,	w13
    b	main_321

main_350:
    movz	fp,	#424
    mov	w26,	w10
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#424
    add	w13,	w12,	w0
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    sub	w1,	w9,	w13
    movk	fp,	#2,	lsl #16
    add	w7,	w1,	w12
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    sub	w13,	w7,	w13
    ldr	w4,	[sp, fp]

    add	w22,	w22,	w13
    sub	w24,	w13,	w22
    add	w25,	w24,	w4
    sub	w20,	w25,	w22
    mov	w22,	w20

main_321:
    mov	w24,	w26
    b	main_324

main_359:
    movz	fp,	#424
    mov	w17,	w24
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#424
    add	w18,	w12,	w13
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#428
    sub	w7,	w17,	w22
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w8,	w13,	w7
    add	w7,	w8,	w18
    sub	w26,	w18,	w7
    add	w25,	w26,	w8
    sub	w23,	w25,	w7
    sub	w24,	w23,	w25
    add	w0,	w24,	w7
    mov	w24,	w2
    sub	w20,	w0,	w25
    mov	w22,	w20

main_324:
    lsl	w18,	w6,	#5
    asr	w0,	w6,	#31
    movz	fp,	#420
    add	w17,	w3,	#1
    lsr	w1,	w0,	#27
    movk	fp,	#2,	lsl #16
    lsl	w0,	w3,	#2
    add	w7,	w6,	w1
    mov	x27,	x0
    add	x27,	sp,	x27
    asr	w9,	w7,	#5
    add	x27,	x27,	#16
    lsl	w13,	w9,	#5
    ldr	w26,	[x27]

    sub	w2,	w6,	w13
    ldr	w10,	[sp, fp]

    movz	fp,	#424
    add	w1,	w2,	w10
    movk	fp,	#2,	lsl #16
    add	w14,	w1,	w18
    add	w2,	w14,	w22
    ldr	w14,	[sp, fp]

    movz	fp,	#424
    add	w1,	w2,	w24
    movk	fp,	#2,	lsl #16
    lsl	w2,	w14,	#30
    ldr	w23,	[sp, fp]

    add	w1,	w1,	w26
    movz	fp,	#424
    asr	w23,	w23,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w23,	#2
    ldr	w14,	[sp, fp]

    movz	fp,	#424
    add	w0,	w14,	w24
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    asr	w20,	w0,	#30
    lsl	w22,	w20,	#30
    sub	w13,	w15,	w22
    add	w20,	w2,	w13
    cmp	w17,	#80
    bge	main_433

main_276:
    movz	fp,	#424
    mov	w7,	w6
    mov	w3,	w12
    mov	w24,	w17
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#408
    mov	w26,	w4
    movk	fp,	#2,	lsl #16
    str	w24,	[sp, fp]

    movz	fp,	#428
    mov	w24,	w20
    movk	fp,	#2,	lsl #16
    str	w24,	[sp, fp]

    b	main_277

main_433:
    add	w14,	w1,	w11
    add	w6,	w6,	w28
    add	w22,	w20,	w19
    add	w5,	w12,	w5
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#440
    add	w18,	w4,	w16
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#576
    add	w10,	w0,	#64
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    cmp	w10,	w20
    bge	main_441

main_62:
    mov	w11,	w14
    mov	w28,	w6
    mov	w19,	w22
    mov	w16,	w18
    mov	w0,	w10
    movz	fp,	#440
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]

    b	main_63

main_441:
    movz	fp,	#384
    movz	w3,	#0
    movk	fp,	#2,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#376
    str	w14,	[x23]

    movk	fp,	#2,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#504
    str	w6,	[x15]

    movk	fp,	#2,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#496
    str	w22,	[x27]

    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#488
    str	w5,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x20,	[sp, fp]

    str	w18,	[x20]


main_442:
    cmp	w3,	#5
    blt	main_445

main_455:
    sub	w6,	w21,	#1
    cmp	w6,	#0
    bgt	main_27

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#444
    movz	w0,	#5
    movk	fp,	#2,	lsl #16
    ldr	x1,	[sp, fp]

    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#624
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


main_27:
    mov	w21,	w6
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    mov	w0,	w28
    b	main_28

main_445:
    lsl	w12,	w3,	#2
    movz	fp,	#356
    lsl	w25,	w3,	#2
    mov	x13,	x12
    movk	fp,	#2,	lsl #16
    add	w3,	w3,	#1
    mov	x23,	x25
    add	x13,	sp,	x13
    add	x23,	sp,	x23
    add	x13,	x13,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x13]

    add	x23,	x23,	fp
    ldr	w28,	[x23]

    add	w15,	w28,	w7
    sub	w14,	w7,	w15
    add	w0,	w14,	w28
    sub	w15,	w0,	w15
    str	w15,	[x13]

    b	main_442

main_245:
    lsl	w13,	w7,	#2
    sub	w17,	w7,	#3
    sub	w3,	w7,	#8
    sub	w25,	w7,	#16
    mov	x10,	x13
    lsl	w22,	w17,	#2
    add	x10,	sp,	x10
    lsl	w6,	w3,	#2
    lsl	w27,	w25,	#2
    mov	x18,	x22
    mov	x4,	x6
    add	x10,	x10,	#16
    mov	x26,	x27
    add	x18,	sp,	x18
    add	x4,	sp,	x4
    add	x26,	sp,	x26
    add	x18,	x18,	#16
    add	x4,	x4,	#16
    add	x26,	x26,	#16
    ldr	w24,	[x18]

    ldr	w15,	[x4]

    sub	w4,	w7,	#14
    add	w3,	w15,	w24
    lsl	w12,	w4,	#2
    sub	w2,	w24,	w3
    mov	x9,	x12
    add	x9,	sp,	x9
    add	w2,	w2,	w15
    add	x9,	x9,	#16
    sub	w8,	w2,	w3
    ldr	w15,	[x9]

    ldr	w2,	[x26]

    add	w4,	w15,	w8
    sub	w9,	w8,	w4
    add	w18,	w9,	w15
    sub	w12,	w18,	w4
    add	w27,	w2,	w12
    sub	w25,	w12,	w27
    add	w3,	w25,	w2
    sub	w18,	w3,	w27
    asr	w25,	w18,	#31
    lsl	w6,	w18,	#1
    lsr	w26,	w25,	#31
    add	w27,	w18,	w26
    asr	w1,	w27,	#1
    lsl	w2,	w1,	#1
    add	w1,	w7,	#1
    sub	w0,	w18,	w2
    mov	w7,	w1
    add	w2,	w6,	w0
    str	w2,	[x10]

    b	main_242

main_216:
    mov	w6,	w7
    b	main_217

main_74:
    lsl	w4,	w7,	#2
    lsl	w8,	w22,	#2
    movz	fp,	#432
    add	w26,	w22,	#1
    add	w6,	w22,	#3
    mov	x0,	x4
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	x0
    lsl	w17,	w26,	#2
    ldr	x3,	[sp, fp]

    add	x0,	x0,	#16
    movz	fp,	#432
    add	x4,	x3,	x8
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x4]

    ldr	x12,	[sp, fp]

    lsl	w18,	w9,	#24
    movz	fp,	#432
    add	x27,	x12,	x17
    add	w9,	w22,	#2
    movk	fp,	#2,	lsl #16
    lsl	w12,	w6,	#2
    ldr	w2,	[x27]

    ldr	x15,	[sp, fp]

    lsl	w3,	w2,	#16
    movz	fp,	#432
    lsl	w2,	w9,	#2
    add	w4,	w3,	w18
    movk	fp,	#2,	lsl #16
    add	x10,	x15,	x2
    add	w15,	w7,	#1
    ldr	w2,	[x10]

    lsl	w17,	w15,	#2
    ldr	x18,	[sp, fp]

    lsl	w3,	w2,	#8
    mov	x9,	x17
    movz	fp,	#432
    add	x10,	x18,	x12
    add	w8,	w4,	w3
    add	x9,	sp,	x9
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x10]

    add	x9,	x9,	#16
    add	w4,	w8,	w13
    add	w13,	w22,	#4
    str	w4,	[x0]

    add	w7,	w13,	#4
    add	w24,	w13,	#3
    lsl	w22,	w13,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#432
    add	x18,	x8,	x22
    movk	fp,	#2,	lsl #16
    add	w8,	w13,	#1
    ldr	w23,	[x18]

    ldr	x0,	[sp, fp]

    lsl	w18,	w8,	#2
    lsl	w6,	w23,	#24
    movz	fp,	#432
    add	x12,	x0,	x18
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x12]

    ldr	x2,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#432
    add	w3,	w1,	w6
    movk	fp,	#2,	lsl #16
    add	w6,	w13,	#2
    lsl	w0,	w6,	#2
    add	x10,	x2,	x0
    lsl	w0,	w24,	#2
    ldr	w20,	[x10]

    add	w10,	w7,	#1
    ldr	x1,	[sp, fp]

    lsl	w22,	w20,	#8
    movz	fp,	#432
    add	x26,	x1,	x0
    movk	fp,	#2,	lsl #16
    lsl	w23,	w10,	#2
    add	w4,	w3,	w22
    add	w3,	w15,	#1
    ldr	w0,	[x26]

    add	w18,	w4,	w0
    add	w20,	w3,	#1
    lsl	w24,	w3,	#2
    lsl	w0,	w7,	#2
    str	w18,	[x9]

    add	w9,	w7,	#3
    ldr	x17,	[sp, fp]

    mov	x18,	x24
    movz	fp,	#432
    add	x26,	x17,	x0
    add	w24,	w7,	#2
    add	x18,	sp,	x18
    movk	fp,	#2,	lsl #16
    add	w7,	w7,	#4
    lsl	w2,	w24,	#2
    ldr	w0,	[x26]

    add	x18,	x18,	#16
    ldr	x10,	[sp, fp]

    add	w22,	w7,	#4
    lsl	w4,	w0,	#24
    add	w24,	w7,	#1
    movz	fp,	#432
    add	x12,	x10,	x23
    movk	fp,	#2,	lsl #16
    add	w17,	w22,	#3
    lsl	w25,	w24,	#2
    ldr	w14,	[x12]

    lsl	w12,	w7,	#2
    ldr	x10,	[sp, fp]

    lsl	w15,	w14,	#16
    movz	fp,	#432
    add	x26,	x10,	x2
    movk	fp,	#2,	lsl #16
    add	w15,	w15,	w4
    lsl	w2,	w20,	#2
    add	w20,	w20,	#1
    ldr	w0,	[x26]

    ldr	x10,	[sp, fp]

    lsl	w1,	w0,	#8
    add	w23,	w20,	#1
    movz	fp,	#432
    add	w0,	w15,	w1
    movk	fp,	#2,	lsl #16
    mov	x1,	x2
    lsl	w15,	w9,	#2
    add	x1,	sp,	x1
    add	w9,	w7,	#2
    add	x10,	x10,	x15
    add	x1,	x1,	#16
    lsl	w6,	w9,	#2
    ldr	w14,	[x10]

    add	w26,	w0,	w14
    str	w26,	[x18]

    ldr	x27,	[sp, fp]

    movz	fp,	#432
    add	x8,	x27,	x12
    movk	fp,	#2,	lsl #16
    lsl	w27,	w17,	#2
    ldr	w12,	[x8]

    add	w8,	w7,	#3
    ldr	x0,	[sp, fp]

    lsl	w14,	w12,	#24
    lsl	w7,	w20,	#2
    movz	fp,	#432
    add	x26,	x0,	x25
    lsl	w13,	w8,	#2
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x26]

    ldr	x3,	[sp, fp]

    lsl	w2,	w0,	#16
    movz	fp,	#432
    add	x10,	x3,	x6
    add	w2,	w2,	w14
    movk	fp,	#2,	lsl #16
    lsl	w6,	w22,	#2
    ldr	w14,	[x10]

    ldr	x8,	[sp, fp]

    lsl	w0,	w14,	#8
    movz	fp,	#432
    add	x10,	x8,	x13
    add	w2,	w2,	w0
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x10]

    add	w8,	w2,	w13
    mov	x2,	x7
    add	x2,	sp,	x2
    str	w8,	[x1]

    ldr	x7,	[sp, fp]

    add	x2,	x2,	#16
    movz	fp,	#432
    add	x4,	x7,	x6
    movk	fp,	#2,	lsl #16
    add	w7,	w22,	#1
    ldr	w8,	[x4]

    lsl	w0,	w7,	#2
    ldr	x10,	[sp, fp]

    lsl	w3,	w8,	#24
    add	w7,	w22,	#2
    movz	fp,	#432
    add	x8,	x10,	x0
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x8]

    ldr	x14,	[sp, fp]

    lsl	w1,	w12,	#16
    movz	fp,	#432
    add	w6,	w1,	w3
    movk	fp,	#2,	lsl #16
    lsl	w3,	w23,	#2
    lsl	w1,	w7,	#2
    add	x9,	x14,	x1
    ldr	w12,	[x9]

    lsl	w13,	w12,	#8
    add	w4,	w6,	w13
    ldr	x13,	[sp, fp]

    movz	fp,	#432
    add	x24,	x13,	x27
    movk	fp,	#2,	lsl #16
    mov	x13,	x3
    add	x13,	sp,	x13
    ldr	w27,	[x24]

    add	w4,	w4,	w27
    add	x13,	x13,	#16
    str	w4,	[x2]

    ldr	x2,	[sp, fp]

    add	w4,	w22,	#4
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    add	w20,	w4,	#2
    add	w6,	w4,	#1
    lsl	w15,	w4,	#2
    lsl	w3,	w20,	#2
    add	x12,	x2,	x15
    lsl	w2,	w6,	#2
    add	w6,	w4,	#3
    ldr	w18,	[x12]

    ldr	x22,	[sp, fp]

    lsl	w1,	w18,	#24
    movz	fp,	#432
    add	x7,	x22,	x2
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x7]

    ldr	x27,	[sp, fp]

    lsl	w14,	w10,	#16
    movz	fp,	#432
    add	x24,	x27,	x3
    lsl	w10,	w6,	#2
    add	w15,	w14,	w1
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x24]

    ldr	x26,	[sp, fp]

    lsl	w0,	w27,	#8
    movz	fp,	#432
    add	x7,	x26,	x10
    add	w8,	w15,	w0
    movk	fp,	#2,	lsl #16
    add	w15,	w4,	#4
    ldr	w12,	[x7]

    add	w12,	w8,	w12
    add	w22,	w15,	#4
    add	w20,	w15,	#1
    lsl	w1,	w15,	#2
    add	w8,	w23,	#1
    str	w12,	[x13]

    lsl	w6,	w20,	#2
    ldr	x12,	[sp, fp]

    lsl	w13,	w8,	#2
    movz	fp,	#432
    add	x27,	x12,	x1
    mov	x23,	x13
    movk	fp,	#2,	lsl #16
    add	x23,	sp,	x23
    ldr	w1,	[x27]

    add	x23,	x23,	#16
    ldr	x2,	[sp, fp]

    lsl	w14,	w1,	#24
    movz	fp,	#432
    add	x26,	x2,	x6
    movk	fp,	#2,	lsl #16
    add	w6,	w15,	#2
    ldr	w0,	[x26]

    lsl	w7,	w6,	#2
    ldr	x9,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#432
    add	x7,	x9,	x7
    movk	fp,	#2,	lsl #16
    add	w2,	w1,	w14
    add	w1,	w15,	#3
    ldr	w12,	[x7]

    ldr	x6,	[sp, fp]

    lsl	w13,	w12,	#8
    lsl	w3,	w1,	#2
    add	w12,	w8,	#1
    add	w10,	w2,	w13
    add	x2,	x6,	x3
    ldr	w7,	[x2]

    add	w27,	w10,	w7
    mov	w7,	w12
    str	w27,	[x23]

    b	main_70

main_50:
    lsl	w16,	w3,	#2
    movz	fp,	#432
    movz	w14,	#0
    add	w5,	w3,	#1
    movk	fp,	#2,	lsl #16
    mov	w3,	w5
    ldr	x26,	[sp, fp]

    add	x19,	x26,	x16
    str	w14,	[x19]

    b	main_46

main_35:
    lsl	w17,	w20,	#2
    movz	fp,	#412
    add	w20,	w20,	#1
    mov	x1,	x17
    movk	fp,	#2,	lsl #16
    add	x1,	sp,	x1
    ldr	w4,	[sp, fp]

    add	x1,	x1,	#336
    movz	fp,	#412
    lsl	w18,	w4,	#13
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    add	w24,	w10,	w18
    movk	fp,	#2,	lsl #16
    asr	w7,	w24,	#31
    lsr	w8,	w7,	#15
    add	w9,	w24,	w8
    asr	w27,	w9,	#17
    add	w26,	w24,	w27
    lsl	w0,	w26,	#5
    add	w25,	w26,	w0
    asr	w10,	w25,	#31
    lsr	w11,	w10,	#24
    add	w12,	w25,	w11
    asr	w27,	w12,	#8
    lsl	w28,	w27,	#8
    sub	w0,	w25,	w28
    str	w0,	[x1]

    str	w25,	[sp, fp]

    b	main_31

