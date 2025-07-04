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
    movz	w23,	#0
    movz	fp,	#336
    movz	w25,	#0
    movz	w22,	#0
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
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movk	fp,	#2,	lsl #16
    add	x2,	sp,	fp
    movz	fp,	#480
    movk	fp,	#2,	lsl #16
    str	x2,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#480
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
    movz	fp,	#416
    movz	w15,	#62464
    add	x22,	sp,	#16
    mov	x0,	x27
    add	x13,	x27,	#8
    add	x10,	x27,	#12
    add	x18,	x27,	#16
    mov	w21,	w26
    movk	fp,	#2,	lsl #16
    movk	w15,	#1,	lsl #16
    str	x9,	[sp, fp]

    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#472
    add	x25,	x19,	x15
    movk	fp,	#2,	lsl #16
    add	x19,	x27,	#4
    str	x25,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    mov	w0,	w28
    movz	fp,	#548
    movk	fp,	#2,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#532
    movk	fp,	#2,	lsl #16
    str	x13,	[sp, fp]

    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x10,	[sp, fp]

    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    str	x18,	[sp, fp]


main_28:
    movz	w22,	#0
    movz	fp,	#400
    mov	w20,	w22
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_31:
    movz	w13,	#32000
    cmp	w20,	w13
    blt	main_35

main_45:
    movz	w3,	#128
    movz	fp,	#472
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
    movz	fp,	#416
    movz	w2,	#0
    add	w20,	w3,	#1
    add	w28,	w3,	#3
    add	w18,	w3,	#4
    movk	fp,	#2,	lsl #16
    lsl	w22,	w20,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#416
    add	x0,	x19,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#125
    str	w2,	[x0]

    movz	w0,	#0
    ldr	x19,	[sp, fp]

    movz	fp,	#416
    add	x24,	x19,	x22
    movk	fp,	#2,	lsl #16
    str	w0,	[x24]

    ldr	x0,	[sp, fp]

    add	w24,	w3,	#2
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    lsl	w27,	w24,	#2
    add	x26,	x0,	x27
    str	w1,	[x26]

    ldr	x2,	[sp, fp]

    lsl	w1,	w28,	#2
    movz	fp,	#380
    movz	w28,	#0
    add	x2,	x2,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w28,	[x2]

    movz	w2,	#320
    str	w18,	[sp, fp]

    movz	fp,	#464
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w0,	#0
    movz	w16,	#8961
    movz	fp,	#488
    movz	w9,	#43913
    movz	w23,	#56574
    movz	w1,	#21622
    movz	w7,	#57840
    mov	w24,	w0
    movk	w16,	#26437,	lsl #16
    movk	fp,	#2,	lsl #16
    movk	w9,	#61389,	lsl #16
    movk	w23,	#39098,	lsl #16
    movk	w1,	#4146,	lsl #16
    movk	w7,	#50130,	lsl #16
    mov	w2,	w16
    str	w24,	[sp, fp]

    mov	w11,	w9
    mov	w14,	w23
    mov	w4,	w1
    mov	w23,	w7

main_63:
    movz	w1,	#0
    movz	fp,	#488
    mov	w7,	w1
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    mov	w22,	w20

main_70:
    cmp	w7,	#14
    blt	main_74

main_215:
    mov	w6,	w7

main_217:
    lsl	w19,	w6,	#2
    lsl	w0,	w22,	#2
    movz	fp,	#416
    mov	x3,	x19
    movk	fp,	#2,	lsl #16
    add	w19,	w22,	#3
    add	x3,	sp,	x3
    ldr	x8,	[sp, fp]

    lsl	w27,	w19,	#2
    movz	fp,	#416
    add	x3,	x3,	#16
    add	x10,	x8,	x0
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x10]

    ldr	x9,	[sp, fp]

    add	w10,	w22,	#1
    lsl	w7,	w1,	#24
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    lsl	w5,	w10,	#2
    add	w10,	w22,	#2
    add	x12,	x9,	x5
    add	w22,	w22,	#4
    ldr	w0,	[x12]

    ldr	x13,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#416
    add	w8,	w1,	w7
    movk	fp,	#2,	lsl #16
    lsl	w7,	w10,	#2
    add	x12,	x13,	x7
    add	w7,	w6,	#1
    ldr	w15,	[x12]

    ldr	x9,	[sp, fp]

    lsl	w16,	w15,	#8
    add	x24,	x9,	x27
    add	w10,	w8,	w16
    ldr	w27,	[x24]

    add	w10,	w10,	w27
    str	w10,	[x3]

    cmp	w7,	#16
    blt	main_216

main_242:
    cmp	w7,	#80
    blt	main_245

main_275:
    mov	w15,	w2
    movz	fp,	#408
    mov	w0,	w11
    mov	w9,	w14
    mov	w5,	w4
    mov	w28,	w23
    movz	w7,	#0
    movk	fp,	#2,	lsl #16
    mov	w8,	w7
    str	w15,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#396
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	w8,	[sp, fp]


main_277:
    movz	w12,	#60289
    movz	w15,	#48348
    movz	w24,	#49414
    movz	w27,	#65535
    movz	fp,	#376
    movk	w12,	#28377,	lsl #16
    movk	w15,	#36635,	lsl #16
    movk	w24,	#51810,	lsl #16
    movk	w27,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w13,	w12
    mov	w1,	w15
    mov	w10,	w24
    mov	w25,	w27
    ldr	w18,	[sp, fp]

    movz	w15,	#31129
    movk	w15,	#23170,	lsl #16
    mov	w7,	w15
    cmp	w18,	#20
    blt	main_285

main_370:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    cmp	w0,	#40
    blt	main_372

main_381:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    cmp	w3,	#60
    blt	main_383

main_401:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#404
    add	w15,	w20,	w17
    movk	fp,	#2,	lsl #16
    mov	w20,	w10
    ldr	w17,	[sp, fp]

    movz	fp,	#412
    sub	w12,	w17,	w15
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#396
    add	w19,	w12,	w24
    movk	fp,	#2,	lsl #16
    sub	w27,	w19,	w15
    ldr	w9,	[sp, fp]

    movz	fp,	#396
    movk	fp,	#2,	lsl #16
    add	w15,	w9,	w27
    ldr	w3,	[sp, fp]

    sub	w5,	w27,	w15
    add	w24,	w5,	w3
    sub	w9,	w24,	w15
    b	main_410

main_383:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#396
    add	w15,	w0,	w26
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#396
    add	w27,	w18,	w17
    movk	fp,	#2,	lsl #16
    add	w22,	w27,	w15
    ldr	w18,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    sub	w12,	w15,	w22
    ldr	w3,	[sp, fp]

    add	w9,	w12,	w27
    sub	w20,	w9,	w22
    sub	w24,	w20,	w9
    add	w20,	w18,	w3
    add	w27,	w24,	w22
    sub	w9,	w27,	w9
    add	w15,	w20,	w9
    sub	w12,	w9,	w15
    add	w5,	w12,	w20
    mov	w20,	w1
    sub	w24,	w5,	w15
    sub	w9,	w24,	w5
    add	w12,	w9,	w15
    sub	w9,	w12,	w5

main_410:
    mov	w24,	w20
    b	main_416

main_372:
    movz	fp,	#404
    mov	w24,	w13
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#404
    add	w20,	w8,	w0
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#412
    sub	w12,	w0,	w20
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#396
    add	w15,	w12,	w8
    movk	fp,	#2,	lsl #16
    sub	w9,	w15,	w20
    ldr	w20,	[sp, fp]

    movz	fp,	#396
    add	w20,	w20,	w9
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    sub	w9,	w9,	w20
    add	w15,	w9,	w17
    sub	w9,	w15,	w20
    b	main_416

main_285:
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#404
    add	w26,	w16,	w8
    movk	fp,	#2,	lsl #16
    mov	w8,	w25
    ldr	w15,	[sp, fp]

    movz	fp,	#396
    sub	w12,	w8,	w15
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    add	w12,	w19,	w12
    add	w24,	w12,	w26
    sub	w20,	w26,	w24
    add	w15,	w20,	w12
    sub	w27,	w15,	w24
    sub	w9,	w27,	w15
    add	w5,	w9,	w24
    mov	w24,	w7
    sub	w9,	w5,	w15

main_416:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#408
    lsl	w5,	w3,	#5
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    movz	fp,	#408
    asr	w20,	w3,	#31
    movk	fp,	#2,	lsl #16
    lsr	w3,	w20,	#27
    ldr	w12,	[sp, fp]

    movz	fp,	#408
    add	w22,	w12,	w3
    movk	fp,	#2,	lsl #16
    asr	w26,	w22,	#5
    ldr	w12,	[sp, fp]

    movz	fp,	#376
    lsl	w20,	w26,	#5
    movk	fp,	#2,	lsl #16
    sub	w15,	w12,	w20
    ldr	w8,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    add	w12,	w5,	w15
    lsl	w5,	w8,	#2
    mov	x3,	x5
    add	w26,	w12,	w28
    add	x3,	sp,	x3
    add	w20,	w26,	w9
    add	x3,	x3,	#16
    add	w28,	w20,	w24
    ldr	w19,	[x3]

    ldr	w17,	[sp, fp]

    movz	fp,	#404
    lsl	w5,	w17,	#30
    add	w8,	w28,	w19
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#404
    asr	w20,	w19,	#31
    movk	fp,	#2,	lsl #16
    lsr	w22,	w20,	#2
    ldr	w18,	[sp, fp]

    movz	fp,	#404
    add	w26,	w18,	w22
    movk	fp,	#2,	lsl #16
    asr	w15,	w26,	#30
    ldr	w20,	[sp, fp]

    movz	fp,	#376
    lsl	w19,	w15,	#30
    movk	fp,	#2,	lsl #16
    sub	w15,	w20,	w19
    ldr	w0,	[sp, fp]

    add	w3,	w0,	#1
    add	w19,	w5,	w15
    cmp	w3,	#20
    blt	main_359

main_296:
    cmp	w3,	#40
    blt	main_350

main_298:
    cmp	w3,	#60
    blt	main_300

main_341:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#408
    add	w18,	w19,	w7
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#412
    sub	w0,	w16,	w18
    movk	fp,	#2,	lsl #16
    add	w1,	w0,	w19
    ldr	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    sub	w7,	w1,	w18
    ldr	w16,	[sp, fp]

    add	w22,	w9,	w7
    sub	w12,	w7,	w22
    add	w15,	w12,	w16
    sub	w20,	w15,	w22
    mov	w22,	w20
    b	main_318

main_300:
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#408
    add	w24,	w19,	w13
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#412
    add	w22,	w17,	w5
    movk	fp,	#2,	lsl #16
    add	w25,	w22,	w24
    sub	w10,	w24,	w25
    add	w5,	w10,	w22
    mov	w10,	w1
    sub	w15,	w5,	w25
    sub	w20,	w15,	w5
    ldr	w15,	[sp, fp]

    add	w26,	w15,	w19
    add	w25,	w20,	w25
    sub	w27,	w25,	w5
    add	w18,	w26,	w27
    sub	w9,	w27,	w18
    add	w5,	w9,	w26
    sub	w12,	w5,	w18
    sub	w15,	w12,	w5
    add	w22,	w15,	w18
    sub	w20,	w22,	w5
    mov	w22,	w20

main_318:
    mov	w26,	w10
    b	main_321

main_350:
    movz	fp,	#408
    mov	w26,	w13
    movk	fp,	#2,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#408
    add	w10,	w19,	w0
    movk	fp,	#2,	lsl #16
    ldr	w12,	[sp, fp]

    movz	fp,	#412
    sub	w1,	w12,	w10
    movk	fp,	#2,	lsl #16
    add	w9,	w1,	w19
    ldr	w22,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    sub	w12,	w9,	w10
    ldr	w7,	[sp, fp]

    add	w22,	w22,	w12
    sub	w25,	w12,	w22
    add	w27,	w25,	w7
    sub	w20,	w27,	w22
    mov	w22,	w20

main_321:
    mov	w25,	w26
    b	main_324

main_359:
    movz	fp,	#408
    mov	w18,	w25
    movk	fp,	#2,	lsl #16
    mov	w25,	w7
    ldr	w13,	[sp, fp]

    movz	fp,	#408
    add	w13,	w19,	w13
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#412
    sub	w1,	w18,	w20
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w9,	w15,	w1
    add	w10,	w9,	w13
    sub	w26,	w13,	w10
    add	w26,	w26,	w9
    sub	w22,	w26,	w10
    sub	w24,	w22,	w26
    add	w0,	w24,	w10
    sub	w20,	w0,	w26
    mov	w22,	w20

main_324:
    lsl	w9,	w8,	#5
    asr	w12,	w8,	#31
    lsl	w28,	w3,	#2
    movz	fp,	#396
    lsr	w15,	w12,	#27
    mov	x27,	x28
    movk	fp,	#2,	lsl #16
    add	x27,	sp,	x27
    add	w18,	w8,	w15
    add	x27,	x27,	#16
    asr	w18,	w18,	#5
    ldr	w28,	[x27]

    lsl	w24,	w18,	#5
    ldr	w12,	[sp, fp]

    sub	w20,	w8,	w24
    movz	fp,	#408
    movk	fp,	#2,	lsl #16
    add	w12,	w20,	w12
    add	w15,	w12,	w9
    add	w1,	w15,	w22
    ldr	w15,	[sp, fp]

    movz	fp,	#408
    add	w0,	w1,	w25
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    add	w1,	w0,	w28
    movz	fp,	#408
    asr	w24,	w25,	#31
    lsl	w0,	w15,	#30
    movk	fp,	#2,	lsl #16
    lsr	w26,	w24,	#2
    ldr	w15,	[sp, fp]

    movz	fp,	#408
    add	w28,	w15,	w26
    movk	fp,	#2,	lsl #16
    add	w15,	w3,	#1
    asr	w18,	w28,	#30
    ldr	w16,	[sp, fp]

    lsl	w20,	w18,	#30
    sub	w13,	w16,	w20
    add	w24,	w0,	w13
    cmp	w15,	#80
    bge	main_433

main_276:
    movz	fp,	#408
    mov	w12,	w8
    mov	w6,	w19
    mov	w22,	w15
    mov	w25,	w24
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	w12,	[sp, fp]

    movz	fp,	#396
    movk	fp,	#2,	lsl #16
    str	w6,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#376
    mov	w28,	w6
    movk	fp,	#2,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w25,	[sp, fp]

    b	main_277

main_433:
    add	w2,	w1,	w2
    add	w13,	w8,	w11
    add	w18,	w24,	w14
    add	w6,	w19,	w4
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#488
    add	w26,	w4,	w23
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#380
    add	w10,	w25,	#64
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    cmp	w10,	w27
    bge	main_441

main_62:
    mov	w11,	w13
    mov	w14,	w18
    mov	w4,	w6
    mov	w23,	w26
    mov	w25,	w10
    movz	fp,	#488
    movk	fp,	#2,	lsl #16
    str	w25,	[sp, fp]

    b	main_63

main_441:
    movz	fp,	#540
    movz	w3,	#0
    movk	fp,	#2,	lsl #16
    ldr	x17,	[sp, fp]

    movz	fp,	#548
    str	w2,	[x17]

    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#532
    str	w13,	[x19]

    movk	fp,	#2,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#524
    str	w18,	[x27]

    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#388
    str	w6,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    str	w26,	[x19]


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
    movz	fp,	#480
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
    movz	fp,	#400
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
    lsl	w16,	w7,	#2
    sub	w18,	w7,	#3
    sub	w5,	w7,	#8
    sub	w9,	w7,	#14
    sub	w25,	w7,	#16
    mov	x12,	x16
    lsl	w22,	w18,	#2
    add	x12,	sp,	x12
    lsl	w8,	w5,	#2
    lsl	w13,	w9,	#2
    lsl	w28,	w25,	#2
    mov	x20,	x22
    add	x12,	x12,	#16
    mov	x6,	x8
    mov	x10,	x13
    mov	x26,	x28
    add	x20,	sp,	x20
    add	x6,	sp,	x6
    add	x10,	sp,	x10
    add	x26,	sp,	x26
    add	x20,	x20,	#16
    add	x6,	x6,	#16
    add	x10,	x10,	#16
    add	x26,	x26,	#16
    ldr	w24,	[x20]

    ldr	w16,	[x6]

    ldr	w17,	[x10]

    add	w8,	w16,	w24
    sub	w3,	w24,	w8
    add	w5,	w3,	w16
    ldr	w3,	[x26]

    sub	w8,	w5,	w8
    add	w9,	w17,	w8
    sub	w10,	w8,	w9
    add	w20,	w10,	w17
    sub	w13,	w20,	w9
    add	w27,	w3,	w13
    sub	w25,	w13,	w27
    add	w5,	w25,	w3
    sub	w19,	w5,	w27
    asr	w25,	w19,	#31
    lsl	w6,	w19,	#1
    lsr	w27,	w25,	#31
    add	w28,	w19,	w27
    asr	w1,	w28,	#1
    lsl	w5,	w1,	#1
    add	w1,	w7,	#1
    sub	w0,	w19,	w5
    mov	w7,	w1
    add	w3,	w6,	w0
    str	w3,	[x12]

    b	main_242

main_216:
    mov	w6,	w7
    b	main_217

main_74:
    lsl	w8,	w7,	#2
    lsl	w10,	w22,	#2
    movz	fp,	#416
    add	w26,	w22,	#1
    mov	x0,	x8
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	x0
    lsl	w19,	w26,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#416
    add	x8,	x6,	x10
    add	x0,	x0,	#16
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x8]

    ldr	x13,	[sp, fp]

    lsl	w18,	w10,	#24
    movz	fp,	#416
    add	x27,	x13,	x19
    add	w10,	w22,	#2
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x27]

    ldr	x17,	[sp, fp]

    lsl	w5,	w3,	#16
    movz	fp,	#416
    lsl	w3,	w10,	#2
    add	w6,	w5,	w18
    movk	fp,	#2,	lsl #16
    add	w10,	w22,	#3
    add	x12,	x17,	x3
    add	w18,	w7,	#1
    lsl	w13,	w10,	#2
    ldr	w3,	[x12]

    lsl	w17,	w18,	#2
    ldr	x19,	[sp, fp]

    lsl	w8,	w3,	#8
    mov	x10,	x17
    movz	fp,	#416
    add	x12,	x19,	x13
    add	w8,	w6,	w8
    add	x10,	sp,	x10
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    add	x10,	x10,	#16
    add	w8,	w8,	w15
    add	w15,	w22,	#4
    str	w8,	[x0]

    add	w25,	w15,	#3
    lsl	w24,	w15,	#2
    add	w8,	w15,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#416
    add	x19,	x9,	x24
    movk	fp,	#2,	lsl #16
    add	w9,	w15,	#1
    ldr	w24,	[x19]

    ldr	x28,	[sp, fp]

    lsl	w19,	w9,	#2
    lsl	w7,	w24,	#24
    movz	fp,	#416
    add	x12,	x28,	x19
    movk	fp,	#2,	lsl #16
    lsl	w28,	w25,	#2
    ldr	w0,	[x12]

    ldr	x3,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#416
    lsl	w0,	w8,	#2
    add	w6,	w1,	w7
    movk	fp,	#2,	lsl #16
    add	w8,	w15,	#4
    add	x12,	x3,	x0
    add	w25,	w8,	#2
    add	w9,	w8,	#4
    ldr	w20,	[x12]

    add	w12,	w8,	#1
    ldr	x1,	[sp, fp]

    lsl	w3,	w25,	#2
    lsl	w24,	w20,	#8
    movz	fp,	#416
    add	x26,	x1,	x28
    lsl	w22,	w12,	#2
    add	w25,	w9,	#1
    add	w5,	w6,	w24
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x26]

    add	w19,	w5,	w0
    lsl	w0,	w8,	#2
    add	w5,	w18,	#1
    str	w19,	[x10]

    lsl	w24,	w5,	#2
    add	w10,	w8,	#3
    ldr	x18,	[sp, fp]

    mov	x20,	x24
    movz	fp,	#416
    add	x26,	x18,	x0
    add	w24,	w9,	#4
    add	x20,	sp,	x20
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x26]

    add	x20,	x20,	#16
    ldr	x12,	[sp, fp]

    lsl	w7,	w0,	#24
    movz	fp,	#416
    add	x13,	x12,	x22
    movk	fp,	#2,	lsl #16
    add	w22,	w5,	#1
    ldr	w16,	[x13]

    add	w19,	w22,	#1
    ldr	x12,	[sp, fp]

    lsl	w18,	w16,	#16
    movz	fp,	#416
    add	x26,	x12,	x3
    lsl	w16,	w10,	#2
    add	w18,	w18,	w7
    movk	fp,	#2,	lsl #16
    lsl	w3,	w22,	#2
    add	w10,	w9,	#2
    ldr	w0,	[x26]

    lsl	w7,	w19,	#2
    add	w22,	w19,	#1
    ldr	x12,	[sp, fp]

    lsl	w6,	w10,	#2
    lsl	w1,	w0,	#8
    movz	fp,	#416
    add	x12,	x12,	x16
    add	w10,	w9,	#3
    add	w0,	w18,	w1
    movk	fp,	#2,	lsl #16
    add	w18,	w24,	#3
    ldr	w15,	[x12]

    mov	x1,	x3
    lsl	w12,	w9,	#2
    add	w26,	w0,	w15
    lsl	w27,	w18,	#2
    add	x1,	sp,	x1
    lsl	w9,	w24,	#2
    str	w26,	[x20]

    add	x1,	x1,	#16
    lsl	w26,	w25,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#416
    add	x8,	x28,	x12
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x8]

    ldr	x0,	[sp, fp]

    lsl	w17,	w12,	#24
    movz	fp,	#416
    add	x26,	x0,	x26
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x26]

    ldr	x5,	[sp, fp]

    lsl	w3,	w0,	#16
    movz	fp,	#416
    add	x12,	x5,	x6
    add	w3,	w3,	w17
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    lsl	w0,	w15,	#8
    lsl	w15,	w10,	#2
    add	w5,	w3,	w0
    ldr	x10,	[sp, fp]

    mov	x3,	x7
    movz	fp,	#416
    add	x12,	x10,	x15
    add	x3,	sp,	x3
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x12]

    add	x3,	x3,	#16
    add	w8,	w5,	w15
    str	w8,	[x1]

    ldr	x8,	[sp, fp]

    movz	fp,	#416
    add	x7,	x8,	x9
    movk	fp,	#2,	lsl #16
    add	w8,	w24,	#1
    ldr	w9,	[x7]

    lsl	w0,	w8,	#2
    ldr	x12,	[sp, fp]

    lsl	w5,	w9,	#24
    movz	fp,	#416
    add	x9,	x12,	x0
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x9]

    ldr	x16,	[sp, fp]

    add	w9,	w24,	#2
    lsl	w1,	w12,	#16
    movz	fp,	#416
    movk	fp,	#2,	lsl #16
    add	w8,	w1,	w5
    add	w5,	w24,	#4
    lsl	w1,	w9,	#2
    add	x10,	x16,	x1
    add	w17,	w5,	#4
    add	w24,	w5,	#2
    lsl	w18,	w5,	#2
    ldr	w13,	[x10]

    add	w10,	w22,	#1
    lsl	w15,	w13,	#8
    add	w7,	w8,	w15
    add	w8,	w5,	#1
    ldr	x15,	[sp, fp]

    movz	fp,	#416
    add	x25,	x15,	x27
    movk	fp,	#2,	lsl #16
    ldr	w27,	[x25]

    add	w7,	w7,	w27
    str	w7,	[x3]

    lsl	w3,	w8,	#2
    ldr	x6,	[sp, fp]

    lsl	w7,	w22,	#2
    movz	fp,	#416
    add	x13,	x6,	x18
    add	w22,	w17,	#1
    mov	x15,	x7
    movk	fp,	#2,	lsl #16
    lsl	w6,	w24,	#2
    add	w7,	w5,	#3
    ldr	w20,	[x13]

    add	x15,	sp,	x15
    ldr	x25,	[sp, fp]

    lsl	w1,	w20,	#24
    movz	fp,	#416
    add	x9,	x25,	x3
    add	x15,	x15,	#16
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x9]

    ldr	x27,	[sp, fp]

    lsl	w16,	w12,	#16
    movz	fp,	#416
    add	x25,	x27,	x6
    lsl	w12,	w7,	#2
    add	w18,	w16,	w1
    movk	fp,	#2,	lsl #16
    lsl	w6,	w22,	#2
    ldr	w27,	[x25]

    add	w7,	w17,	#2
    lsl	w1,	w17,	#2
    lsl	w16,	w10,	#2
    add	w22,	w17,	#4
    ldr	x26,	[sp, fp]

    lsl	w0,	w27,	#8
    mov	x24,	x16
    movz	fp,	#416
    add	x8,	x26,	x12
    add	w9,	w18,	w0
    add	x24,	sp,	x24
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x8]

    add	x24,	x24,	#16
    lsl	w8,	w7,	#2
    add	w13,	w9,	w12
    str	w13,	[x15]

    add	w15,	w10,	#1
    ldr	x13,	[sp, fp]

    movz	fp,	#416
    add	x28,	x13,	x1
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x28]

    ldr	x3,	[sp, fp]

    lsl	w18,	w1,	#24
    movz	fp,	#416
    add	x26,	x3,	x6
    movk	fp,	#2,	lsl #16
    ldr	w0,	[x26]

    ldr	x9,	[sp, fp]

    lsl	w1,	w0,	#16
    movz	fp,	#416
    add	x8,	x9,	x8
    add	w3,	w1,	w18
    movk	fp,	#2,	lsl #16
    add	w1,	w17,	#3
    ldr	w12,	[x8]

    ldr	x7,	[sp, fp]

    lsl	w13,	w12,	#8
    lsl	w6,	w1,	#2
    add	w12,	w3,	w13
    add	x5,	x7,	x6
    mov	w7,	w15
    ldr	w8,	[x5]

    add	w28,	w12,	w8
    str	w28,	[x24]

    b	main_70

main_50:
    lsl	w16,	w3,	#2
    movz	fp,	#416
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
    movz	fp,	#400
    add	w20,	w20,	#1
    mov	x1,	x17
    movk	fp,	#2,	lsl #16
    add	x1,	sp,	x1
    ldr	w4,	[sp, fp]

    add	x1,	x1,	#336
    movz	fp,	#400
    lsl	w18,	w4,	#13
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#400
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

