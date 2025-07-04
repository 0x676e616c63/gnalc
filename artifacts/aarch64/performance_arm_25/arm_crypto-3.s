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
    movz	w25,	#0
    movz	fp,	#336
    movz	w23,	#0
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
    movz	w4,	#0
    movz	w6,	#0
    movz	fp,	#356
    movz	w5,	#0
    movk	fp,	#2,	lsl #16
    add	x2,	sp,	fp
    movz	fp,	#472
    movk	fp,	#2,	lsl #16
    str	x2,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#472
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
    movz	fp,	#404
    movz	w15,	#62464
    add	x22,	sp,	#16
    mov	x0,	x27
    add	x13,	x27,	#8
    add	x10,	x27,	#12
    add	x18,	x27,	#16
    movk	fp,	#2,	lsl #16
    movk	w15,	#1,	lsl #16
    str	x9,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#464
    add	x25,	x19,	x15
    movk	fp,	#2,	lsl #16
    add	x19,	x27,	#4
    str	x25,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    mov	w22,	w26
    movz	fp,	#524
    movk	fp,	#2,	lsl #16
    str	x0,	[sp, fp]

    mov	w0,	w28
    movz	fp,	#448
    movk	fp,	#2,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#508
    movk	fp,	#2,	lsl #16
    str	x13,	[sp, fp]

    movz	fp,	#500
    movk	fp,	#2,	lsl #16
    str	x10,	[sp, fp]

    movz	fp,	#492
    movk	fp,	#2,	lsl #16
    str	x18,	[sp, fp]


main_28:
    movz	w21,	#0
    movz	fp,	#384
    mov	w20,	w21
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_31:
    movz	w13,	#32000
    cmp	w20,	w13
    blt	main_35

main_45:
    movz	w3,	#128
    movz	fp,	#464
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
    movz	fp,	#404
    movz	w2,	#0
    add	w20,	w3,	#1
    add	w28,	w3,	#3
    add	w18,	w3,	#4
    movk	fp,	#2,	lsl #16
    lsl	w21,	w20,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#404
    add	x0,	x19,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#125
    str	w2,	[x0]

    movz	w0,	#0
    ldr	x19,	[sp, fp]

    movz	fp,	#404
    add	x24,	x19,	x21
    movk	fp,	#2,	lsl #16
    str	w0,	[x24]

    ldr	x0,	[sp, fp]

    add	w24,	w3,	#2
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    lsl	w27,	w24,	#2
    add	x26,	x0,	x27
    str	w1,	[x26]

    ldr	x2,	[sp, fp]

    lsl	w1,	w28,	#2
    movz	fp,	#436
    movz	w28,	#0
    add	x2,	x2,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w28,	[x2]

    movz	w2,	#320
    str	w18,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    bl	memset
    movz	fp,	#380
    movz	w16,	#8961
    movz	w7,	#43913
    movz	w1,	#21622
    movz	w21,	#56574
    movk	fp,	#2,	lsl #16
    movk	w16,	#26437,	lsl #16
    movk	w7,	#61389,	lsl #16
    movk	w1,	#4146,	lsl #16
    movk	w21,	#39098,	lsl #16
    mov	w11,	w16
    mov	w0,	w7
    mov	w4,	w21
    movz	w7,	#57840
    mov	w21,	w1
    movk	w7,	#50130,	lsl #16
    movz	w1,	#0
    mov	w17,	w7
    mov	w24,	w1
    str	w24,	[sp, fp]


main_63:
    movz	w2,	#0
    movz	fp,	#380
    mov	w8,	w2
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    mov	w23,	w20

main_70:
    cmp	w8,	#14
    blt	main_74

main_215:
    mov	w7,	w8

main_217:
    lsl	w18,	w7,	#2
    lsl	w1,	w23,	#2
    movz	fp,	#404
    add	w10,	w23,	#1
    add	w19,	w23,	#3
    mov	x2,	x18
    movk	fp,	#2,	lsl #16
    add	x2,	sp,	x2
    lsl	w5,	w10,	#2
    lsl	w27,	w19,	#2
    ldr	x8,	[sp, fp]

    add	x2,	x2,	#16
    add	w10,	w23,	#2
    movz	fp,	#404
    add	x12,	x8,	x1
    add	w23,	w23,	#4
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x12]

    ldr	x8,	[sp, fp]

    lsl	w6,	w3,	#24
    movz	fp,	#404
    add	x12,	x8,	x5
    movk	fp,	#2,	lsl #16
    add	w8,	w7,	#1
    lsl	w5,	w10,	#2
    ldr	w1,	[x12]

    ldr	x13,	[sp, fp]

    lsl	w3,	w1,	#16
    movz	fp,	#404
    add	x12,	x13,	x5
    add	w6,	w3,	w6
    movk	fp,	#2,	lsl #16
    ldr	w14,	[x12]

    ldr	x9,	[sp, fp]

    lsl	w15,	w14,	#8
    add	x20,	x9,	x27
    add	w10,	w6,	w15
    ldr	w28,	[x20]

    add	w12,	w10,	w28
    str	w12,	[x2]

    cmp	w8,	#16
    blt	main_216

main_242:
    cmp	w8,	#80
    blt	main_245

main_275:
    mov	w14,	w11
    movz	fp,	#396
    mov	w1,	w0
    mov	w7,	w4
    mov	w5,	w21
    movz	w8,	#0
    movk	fp,	#2,	lsl #16
    mov	w9,	w8
    str	w14,	[sp, fp]

    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    str	w1,	[sp, fp]

    mov	w1,	w17
    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]


main_277:
    movz	w3,	#60289
    movz	w13,	#48348
    movz	w15,	#49414
    movz	w7,	#31129
    movz	w23,	#65535
    movz	fp,	#376
    movk	w3,	#28377,	lsl #16
    movk	w13,	#36635,	lsl #16
    movk	w15,	#51810,	lsl #16
    movk	w7,	#23170,	lsl #16
    movk	w23,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w27,	w3
    mov	w2,	w13
    mov	w12,	w15
    mov	w5,	w7
    mov	w18,	w23
    ldr	w20,	[sp, fp]

    cmp	w20,	#20
    blt	main_285

main_370:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    ldr	w3,	[sp, fp]

    cmp	w3,	#40
    blt	main_372

main_381:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    cmp	w6,	#60
    blt	main_383

main_401:
    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#388
    add	w16,	w25,	w23
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#400
    sub	w9,	w20,	w16
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#392
    add	w13,	w9,	w26
    movk	fp,	#2,	lsl #16
    sub	w9,	w13,	w16
    ldr	w14,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    add	w13,	w14,	w9
    ldr	w10,	[sp, fp]

    sub	w3,	w9,	w13
    add	w3,	w3,	w10
    mov	w10,	w12
    sub	w7,	w3,	w13
    mov	w15,	w7
    b	main_410

main_383:
    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#392
    add	w13,	w8,	w28
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#392
    add	w8,	w24,	w20
    movk	fp,	#2,	lsl #16
    add	w16,	w8,	w13
    ldr	w24,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    sub	w10,	w13,	w16
    ldr	w6,	[sp, fp]

    add	w8,	w10,	w8
    sub	w25,	w8,	w16
    sub	w7,	w25,	w8
    add	w9,	w7,	w16
    sub	w10,	w9,	w8
    add	w8,	w24,	w6
    add	w25,	w8,	w10
    sub	w9,	w10,	w25
    add	w7,	w9,	w8
    sub	w15,	w7,	w25
    sub	w3,	w15,	w7
    add	w10,	w3,	w25
    sub	w7,	w10,	w7
    mov	w10,	w2
    mov	w15,	w7

main_410:
    mov	w23,	w15
    mov	w13,	w10
    b	main_413

main_372:
    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#388
    add	w25,	w13,	w8
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#400
    sub	w7,	w8,	w25
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#392
    add	w13,	w7,	w13
    movk	fp,	#2,	lsl #16
    sub	w10,	w13,	w25
    mov	w13,	w27
    ldr	w25,	[sp, fp]

    movz	fp,	#392
    add	w28,	w25,	w10
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    sub	w7,	w10,	w28
    add	w15,	w7,	w20
    sub	w7,	w15,	w28
    mov	w23,	w7

main_413:
    mov	w7,	w23
    mov	w9,	w13
    b	main_416

main_285:
    movz	fp,	#388
    mov	w16,	w18
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#388
    add	w15,	w19,	w10
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#392
    sub	w9,	w16,	w14
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    add	w9,	w25,	w9
    add	w24,	w9,	w15
    sub	w25,	w15,	w24
    add	w8,	w25,	w9
    sub	w9,	w8,	w24
    sub	w10,	w9,	w8
    mov	w9,	w5
    add	w3,	w10,	w24
    sub	w7,	w3,	w8

main_416:
    movz	fp,	#396
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#396
    lsl	w3,	w14,	#5
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#396
    asr	w23,	w15,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w23,	#27
    ldr	w19,	[sp, fp]

    movz	fp,	#396
    add	w25,	w19,	w24
    movk	fp,	#2,	lsl #16
    asr	w10,	w25,	#5
    ldr	w23,	[sp, fp]

    movz	fp,	#376
    lsl	w16,	w10,	#5
    movk	fp,	#2,	lsl #16
    sub	w25,	w23,	w16
    ldr	w14,	[sp, fp]

    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    add	w24,	w3,	w25
    lsl	w3,	w14,	#2
    mov	x8,	x3
    add	w10,	w24,	w1
    add	x8,	sp,	x8
    add	w1,	w10,	w7
    add	x8,	x8,	#16
    add	w9,	w1,	w9
    ldr	w8,	[x8]

    ldr	w19,	[sp, fp]

    movz	fp,	#388
    lsl	w1,	w19,	#30
    add	w3,	w9,	w8
    movk	fp,	#2,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#388
    asr	w15,	w23,	#31
    movk	fp,	#2,	lsl #16
    lsr	w24,	w15,	#2
    ldr	w20,	[sp, fp]

    movz	fp,	#388
    add	w7,	w20,	w24
    movk	fp,	#2,	lsl #16
    asr	w8,	w7,	#30
    ldr	w25,	[sp, fp]

    movz	fp,	#376
    lsl	w13,	w8,	#30
    movk	fp,	#2,	lsl #16
    sub	w15,	w25,	w13
    add	w23,	w1,	w15
    ldr	w1,	[sp, fp]

    add	w15,	w1,	#1
    cmp	w15,	#20
    blt	main_359

main_296:
    cmp	w15,	#40
    blt	main_350

main_298:
    cmp	w15,	#60
    blt	main_300

main_341:
    movz	fp,	#396
    movk	fp,	#2,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#396
    add	w20,	w23,	w8
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#400
    sub	w1,	w16,	w20
    movk	fp,	#2,	lsl #16
    add	w5,	w1,	w23
    ldr	w6,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    sub	w8,	w5,	w20
    ldr	w18,	[sp, fp]

    add	w20,	w6,	w8
    sub	w16,	w8,	w20
    add	w18,	w16,	w18
    sub	w18,	w18,	w20
    mov	w20,	w18
    b	main_318

main_300:
    movz	fp,	#396
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#396
    add	w25,	w23,	w13
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#400
    add	w18,	w18,	w6
    movk	fp,	#2,	lsl #16
    add	w20,	w18,	w25
    sub	w8,	w25,	w20
    add	w7,	w8,	w18
    sub	w13,	w7,	w20
    sub	w16,	w13,	w7
    ldr	w13,	[sp, fp]

    add	w28,	w13,	w23
    add	w18,	w16,	w20
    sub	w25,	w18,	w7
    add	w9,	w28,	w25
    sub	w7,	w25,	w9
    add	w28,	w7,	w28
    sub	w12,	w28,	w9
    sub	w18,	w12,	w28
    mov	w12,	w2
    add	w24,	w18,	w9
    sub	w18,	w24,	w28
    mov	w20,	w18

main_318:
    mov	w18,	w20
    mov	w25,	w12
    b	main_321

main_350:
    movz	fp,	#396
    mov	w25,	w27
    movk	fp,	#2,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#396
    add	w2,	w23,	w1
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#400
    sub	w5,	w9,	w2
    movk	fp,	#2,	lsl #16
    add	w7,	w5,	w23
    ldr	w16,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    sub	w9,	w7,	w2
    ldr	w6,	[sp, fp]

    add	w18,	w16,	w9
    sub	w13,	w9,	w18
    add	w16,	w13,	w6
    sub	w16,	w16,	w18
    mov	w18,	w16

main_321:
    mov	w24,	w18
    mov	w8,	w25
    b	main_324

main_359:
    movz	fp,	#396
    mov	w8,	w18
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#396
    add	w13,	w23,	w13
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#400
    sub	w7,	w8,	w20
    movk	fp,	#2,	lsl #16
    mov	w8,	w5
    ldr	w14,	[sp, fp]

    add	w9,	w14,	w7
    add	w10,	w9,	w13
    sub	w27,	w13,	w10
    add	w27,	w27,	w9
    sub	w24,	w27,	w10
    sub	w25,	w24,	w27
    add	w1,	w25,	w10
    sub	w20,	w1,	w27
    mov	w24,	w20

main_324:
    lsl	w20,	w3,	#5
    asr	w1,	w3,	#31
    movz	fp,	#392
    lsr	w7,	w1,	#27
    movk	fp,	#2,	lsl #16
    lsl	w1,	w15,	#2
    add	w10,	w3,	w7
    mov	x28,	x1
    add	x28,	sp,	x28
    asr	w12,	w10,	#5
    add	x28,	x28,	#16
    lsl	w16,	w12,	#5
    ldr	w26,	[x28]

    sub	w12,	w3,	w16
    ldr	w10,	[sp, fp]

    add	w16,	w15,	#1
    movz	fp,	#396
    add	w7,	w12,	w10
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    add	w18,	w7,	w20
    movz	fp,	#396
    lsl	w1,	w13,	#30
    movk	fp,	#2,	lsl #16
    add	w5,	w18,	w24
    ldr	w24,	[sp, fp]

    movz	fp,	#396
    asr	w24,	w24,	#31
    add	w28,	w5,	w8
    movk	fp,	#2,	lsl #16
    lsr	w25,	w24,	#2
    ldr	w13,	[sp, fp]

    add	w5,	w28,	w26
    movz	fp,	#396
    add	w27,	w13,	w25
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    asr	w19,	w27,	#30
    lsl	w20,	w19,	#30
    sub	w12,	w14,	w20
    add	w24,	w1,	w12
    cmp	w16,	#80
    bge	main_433

main_276:
    movz	fp,	#396
    mov	w27,	w16
    mov	w26,	w24
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    mov	w5,	w23
    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#2,	lsl #16
    str	w5,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#376
    mov	w1,	w6
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#400
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]

    b	main_277

main_433:
    add	w18,	w5,	w11
    add	w8,	w3,	w0
    add	w23,	w23,	w21
    movz	fp,	#400
    add	w5,	w24,	w4
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#380
    add	w20,	w4,	w17
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#436
    add	w14,	w26,	#64
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    cmp	w14,	w27
    bge	main_441

main_62:
    mov	w11,	w18
    mov	w0,	w8
    mov	w4,	w5
    mov	w21,	w23
    mov	w17,	w20
    mov	w6,	w14
    movz	fp,	#380
    movk	fp,	#2,	lsl #16
    str	w6,	[sp, fp]

    b	main_63

main_441:
    movz	fp,	#524
    movz	w3,	#0
    movk	fp,	#2,	lsl #16
    ldr	x16,	[sp, fp]

    movz	fp,	#448
    str	w18,	[x16]

    movk	fp,	#2,	lsl #16
    ldr	x18,	[sp, fp]

    movz	fp,	#508
    str	w8,	[x18]

    movk	fp,	#2,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#500
    str	w5,	[x27]

    movk	fp,	#2,	lsl #16
    ldr	x11,	[sp, fp]

    movz	fp,	#492
    str	w23,	[x11]

    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    str	w20,	[x19]


main_442:
    cmp	w3,	#5
    blt	main_445

main_455:
    sub	w6,	w22,	#1
    cmp	w6,	#0
    bgt	main_27

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#472
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
    mov	w22,	w6
    movz	fp,	#384
    movk	fp,	#2,	lsl #16
    ldr	w28,	[sp, fp]

    mov	w0,	w28
    b	main_28

main_445:
    lsl	w12,	w3,	#2
    movz	fp,	#356
    lsl	w24,	w3,	#2
    mov	x13,	x12
    movk	fp,	#2,	lsl #16
    add	w3,	w3,	#1
    mov	x23,	x24
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
    lsl	w14,	w8,	#2
    sub	w18,	w8,	#3
    sub	w3,	w8,	#8
    sub	w25,	w8,	#16
    mov	x12,	x14
    lsl	w23,	w18,	#2
    add	x12,	sp,	x12
    lsl	w7,	w3,	#2
    lsl	w28,	w25,	#2
    mov	x19,	x23
    mov	x6,	x7
    add	x12,	x12,	#16
    mov	x27,	x28
    add	x19,	sp,	x19
    add	x6,	sp,	x6
    add	x27,	sp,	x27
    add	x19,	x19,	#16
    add	x6,	x6,	#16
    add	x27,	x27,	#16
    ldr	w24,	[x19]

    ldr	w16,	[x6]

    add	w7,	w16,	w24
    sub	w2,	w24,	w7
    add	w3,	w2,	w16
    sub	w9,	w3,	w7
    sub	w7,	w8,	#14
    lsl	w13,	w7,	#2
    mov	x10,	x13
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w16,	[x10]

    ldr	w3,	[x27]

    add	w7,	w16,	w9
    sub	w10,	w9,	w7
    add	w19,	w10,	w16
    sub	w13,	w19,	w7
    add	w27,	w3,	w13
    sub	w26,	w13,	w27
    add	w5,	w26,	w3
    sub	w19,	w5,	w27
    asr	w26,	w19,	#31
    lsl	w6,	w19,	#1
    lsr	w27,	w26,	#31
    add	w28,	w19,	w27
    asr	w2,	w28,	#1
    lsl	w3,	w2,	#1
    sub	w1,	w19,	w3
    add	w2,	w6,	w1
    str	w2,	[x12]

    add	w2,	w8,	#1
    mov	w8,	w2
    b	main_242

main_216:
    mov	w7,	w8
    b	main_217

main_74:
    lsl	w7,	w8,	#2
    lsl	w10,	w23,	#2
    movz	fp,	#404
    add	w26,	w23,	#1
    mov	x1,	x7
    movk	fp,	#2,	lsl #16
    add	x1,	sp,	x1
    lsl	w18,	w26,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#404
    add	x6,	x5,	x10
    add	x1,	x1,	#16
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x6]

    ldr	x13,	[sp, fp]

    lsl	w19,	w10,	#24
    movz	fp,	#404
    add	x28,	x13,	x18
    add	w10,	w23,	#2
    movk	fp,	#2,	lsl #16
    add	w18,	w23,	#4
    ldr	w3,	[x28]

    lsl	w2,	w10,	#2
    ldr	x16,	[sp, fp]

    add	w25,	w18,	#3
    lsl	w5,	w3,	#16
    add	w10,	w23,	#3
    movz	fp,	#404
    add	x12,	x16,	x2
    add	w6,	w5,	w19
    lsl	w23,	w18,	#2
    movk	fp,	#2,	lsl #16
    lsl	w13,	w10,	#2
    ldr	w3,	[x12]

    add	w10,	w18,	#1
    ldr	x19,	[sp, fp]

    lsl	w5,	w3,	#8
    movz	fp,	#404
    add	x12,	x19,	x13
    add	w9,	w6,	w5
    movk	fp,	#2,	lsl #16
    lsl	w19,	w10,	#2
    ldr	w14,	[x12]

    add	w12,	w8,	#1
    add	w6,	w9,	w14
    add	w8,	w18,	#2
    lsl	w14,	w12,	#2
    str	w6,	[x1]

    add	w5,	w12,	#1
    lsl	w28,	w8,	#2
    mov	x9,	x14
    ldr	x13,	[sp, fp]

    add	x9,	sp,	x9
    movz	fp,	#404
    add	w20,	w5,	#1
    add	x15,	x13,	x23
    movk	fp,	#2,	lsl #16
    add	x9,	x9,	#16
    ldr	w24,	[x15]

    ldr	x1,	[sp, fp]

    lsl	w7,	w24,	#24
    movz	fp,	#404
    add	x14,	x1,	x19
    lsl	w24,	w5,	#2
    movk	fp,	#2,	lsl #16
    mov	x19,	x24
    ldr	w1,	[x14]

    add	x19,	sp,	x19
    lsl	w2,	w1,	#16
    lsl	w1,	w25,	#2
    add	x19,	x19,	#16
    add	w3,	w2,	w7
    add	w7,	w18,	#4
    ldr	x2,	[sp, fp]

    movz	fp,	#404
    add	x14,	x2,	x28
    movk	fp,	#2,	lsl #16
    add	w10,	w7,	#3
    add	w25,	w7,	#2
    add	w12,	w7,	#1
    add	w8,	w7,	#4
    ldr	w16,	[x14]

    ldr	x2,	[sp, fp]

    lsl	w23,	w16,	#8
    lsl	w24,	w12,	#2
    movz	fp,	#404
    add	x26,	x2,	x1
    add	w6,	w3,	w23
    movk	fp,	#2,	lsl #16
    lsl	w3,	w25,	#2
    add	w25,	w8,	#1
    ldr	w1,	[x26]

    add	w15,	w6,	w1
    lsl	w1,	w7,	#2
    str	w15,	[x9]

    ldr	x18,	[sp, fp]

    movz	fp,	#404
    add	x27,	x18,	x1
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x27]

    ldr	x12,	[sp, fp]

    lsl	w6,	w1,	#24
    movz	fp,	#404
    add	x13,	x12,	x24
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x13]

    lsl	w13,	w8,	#2
    ldr	x12,	[sp, fp]

    lsl	w16,	w15,	#16
    movz	fp,	#404
    add	x26,	x12,	x3
    movk	fp,	#2,	lsl #16
    add	w16,	w16,	w6
    ldr	w1,	[x26]

    lsl	w26,	w25,	#2
    ldr	x12,	[sp, fp]

    lsl	w2,	w1,	#8
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    add	w1,	w16,	w2
    lsl	w2,	w20,	#2
    lsl	w16,	w10,	#2
    mov	x2,	x2
    add	w10,	w8,	#2
    add	x12,	x12,	x16
    add	x2,	sp,	x2
    lsl	w7,	w10,	#2
    ldr	w15,	[x12]

    add	x2,	x2,	#16
    add	w10,	w8,	#3
    add	w27,	w1,	w15
    lsl	w14,	w10,	#2
    str	w27,	[x19]

    add	w19,	w20,	#1
    ldr	x28,	[sp, fp]

    add	w20,	w8,	#4
    movz	fp,	#404
    add	x9,	x28,	x13
    movk	fp,	#2,	lsl #16
    add	w24,	w19,	#1
    lsl	w8,	w19,	#2
    add	w18,	w20,	#3
    ldr	w13,	[x9]

    ldr	x1,	[sp, fp]

    lsl	w15,	w13,	#24
    lsl	w27,	w18,	#2
    movz	fp,	#404
    add	x26,	x1,	x26
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x26]

    ldr	x5,	[sp, fp]

    lsl	w3,	w1,	#16
    movz	fp,	#404
    add	x12,	x5,	x7
    add	w3,	w3,	w15
    movk	fp,	#2,	lsl #16
    add	w7,	w20,	#1
    ldr	w15,	[x12]

    ldr	x10,	[sp, fp]

    lsl	w1,	w15,	#8
    lsl	w28,	w7,	#2
    movz	fp,	#404
    add	x12,	x10,	x14
    add	w3,	w3,	w1
    movk	fp,	#2,	lsl #16
    mov	x1,	x8
    add	x1,	sp,	x1
    ldr	w14,	[x12]

    add	w9,	w3,	w14
    add	x1,	x1,	#16
    str	w9,	[x2]

    ldr	x8,	[sp, fp]

    lsl	w9,	w20,	#2
    movz	fp,	#404
    add	x6,	x8,	x9
    movk	fp,	#2,	lsl #16
    ldr	w9,	[x6]

    ldr	x10,	[sp, fp]

    lsl	w3,	w9,	#24
    movz	fp,	#404
    add	x9,	x10,	x28
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x9]

    add	w9,	w20,	#2
    ldr	x15,	[sp, fp]

    lsl	w5,	w13,	#16
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    lsl	w2,	w9,	#2
    add	w7,	w5,	w3
    lsl	w5,	w24,	#2
    add	x10,	x15,	x2
    ldr	w13,	[x10]

    add	w10,	w24,	#1
    lsl	w14,	w13,	#8
    add	w7,	w7,	w14
    ldr	x14,	[sp, fp]

    movz	fp,	#404
    add	x25,	x14,	x27
    movk	fp,	#2,	lsl #16
    mov	x14,	x5
    add	x14,	sp,	x14
    ldr	w28,	[x25]

    add	w6,	w7,	w28
    add	x14,	x14,	#16
    str	w6,	[x1]

    ldr	x3,	[sp, fp]

    add	w6,	w20,	#4
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    add	w20,	w6,	#2
    add	w7,	w6,	#1
    lsl	w16,	w6,	#2
    lsl	w5,	w20,	#2
    add	x13,	x3,	x16
    lsl	w3,	w7,	#2
    ldr	w19,	[x13]

    ldr	x23,	[sp, fp]

    lsl	w2,	w19,	#24
    movz	fp,	#404
    add	x9,	x23,	x3
    movk	fp,	#2,	lsl #16
    ldr	w12,	[x9]

    ldr	x27,	[sp, fp]

    lsl	w15,	w12,	#16
    movz	fp,	#404
    add	x25,	x27,	x5
    add	w16,	w15,	w2
    movk	fp,	#2,	lsl #16
    add	w5,	w6,	#3
    ldr	w28,	[x25]

    ldr	x26,	[sp, fp]

    lsl	w1,	w28,	#8
    lsl	w12,	w5,	#2
    movz	fp,	#404
    add	w9,	w16,	w1
    movk	fp,	#2,	lsl #16
    add	x8,	x26,	x12
    add	w16,	w6,	#4
    ldr	w13,	[x8]

    add	w23,	w16,	#4
    add	w6,	w16,	#2
    add	w20,	w16,	#1
    lsl	w2,	w16,	#2
    add	w13,	w9,	w13
    lsl	w8,	w6,	#2
    lsl	w7,	w20,	#2
    str	w13,	[x14]

    ldr	x13,	[sp, fp]

    lsl	w14,	w10,	#2
    movz	fp,	#404
    add	x28,	x13,	x2
    mov	x24,	x14
    movk	fp,	#2,	lsl #16
    add	x24,	sp,	x24
    ldr	w2,	[x28]

    ldr	x3,	[sp, fp]

    lsl	w15,	w2,	#24
    add	x24,	x24,	#16
    movz	fp,	#404
    add	x26,	x3,	x7
    movk	fp,	#2,	lsl #16
    ldr	w1,	[x26]

    ldr	x7,	[sp, fp]

    lsl	w2,	w1,	#16
    movz	fp,	#404
    add	x8,	x7,	x8
    add	w3,	w2,	w15
    movk	fp,	#2,	lsl #16
    add	w2,	w16,	#3
    ldr	w13,	[x8]

    ldr	x7,	[sp, fp]

    lsl	w14,	w13,	#8
    lsl	w5,	w2,	#2
    add	w13,	w10,	#1
    add	w12,	w3,	w14
    add	x3,	x7,	x5
    ldr	w8,	[x3]

    add	w28,	w12,	w8
    mov	w8,	w13
    str	w28,	[x24]

    b	main_70

main_50:
    lsl	w16,	w3,	#2
    movz	fp,	#404
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
    movz	fp,	#384
    add	w20,	w20,	#1
    mov	x26,	x17
    movk	fp,	#2,	lsl #16
    add	x26,	sp,	x26
    ldr	w4,	[sp, fp]

    add	x26,	x26,	#336
    movz	fp,	#384
    lsl	w18,	w4,	#13
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#384
    add	w24,	w10,	w18
    movk	fp,	#2,	lsl #16
    asr	w7,	w24,	#31
    lsr	w8,	w7,	#15
    add	w9,	w24,	w8
    asr	w27,	w9,	#17
    add	w25,	w24,	w27
    lsl	w0,	w25,	#5
    add	w24,	w25,	w0
    asr	w10,	w24,	#31
    lsr	w11,	w10,	#24
    add	w12,	w24,	w11
    asr	w27,	w12,	#8
    lsl	w28,	w27,	#8
    sub	w0,	w24,	w28
    str	w0,	[x26]

    str	w24,	[sp, fp]

    b	main_31

