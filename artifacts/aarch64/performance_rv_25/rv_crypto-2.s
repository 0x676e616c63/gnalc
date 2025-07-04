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
    movz	w23,	#0
    movz	w25,	#0
    movz	w24,	#0
    movz	fp,	#336
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
    movz	fp,	#356
    movz	w5,	#0
    movz	w4,	#0
    movz	w6,	#0
    movk	fp,	#2,	lsl #16
    add	x2,	sp,	fp
    movz	fp,	#404
    movk	fp,	#2,	lsl #16
    str	x2,	[sp, fp]

    movz	w2,	#0
    movz	fp,	#404
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
    mov	w23,	w26
    mov	w0,	w28
    movk	fp,	#2,	lsl #16
    movk	w15,	#1,	lsl #16
    str	x9,	[sp, fp]

    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#396
    add	x25,	x19,	x15
    movk	fp,	#2,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#380
    movk	fp,	#2,	lsl #16
    str	x3,	[sp, fp]

    movz	fp,	#476
    movk	fp,	#2,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#468
    movk	fp,	#2,	lsl #16
    str	x13,	[sp, fp]

    movz	fp,	#460
    movk	fp,	#2,	lsl #16
    str	x10,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#2,	lsl #16
    str	x18,	[sp, fp]


main_28:
    movz	w21,	#0
    movz	fp,	#416
    mov	w20,	w21
    movk	fp,	#2,	lsl #16
    str	w0,	[sp, fp]


main_31:
    movz	w13,	#32000
    cmp	w20,	w13
    blt	main_35

main_45:
    movz	w3,	#128
    movz	fp,	#396
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
    add	w18,	w3,	#4
    movk	fp,	#2,	lsl #16
    lsl	w21,	w20,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#432
    add	x0,	x19,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#125
    str	w2,	[x0]

    movz	w0,	#0
    ldr	x19,	[sp, fp]

    movz	fp,	#432
    add	x24,	x19,	x21
    movk	fp,	#2,	lsl #16
    str	w0,	[x24]

    ldr	x0,	[sp, fp]

    add	w24,	w3,	#2
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    lsl	w26,	w24,	#2
    add	x26,	x0,	x26
    str	w1,	[x26]

    ldr	x2,	[sp, fp]

    lsl	w1,	w28,	#2
    movz	fp,	#440
    movz	w28,	#0
    add	x2,	x2,	x1
    movk	fp,	#2,	lsl #16
    movz	w1,	#0
    str	w28,	[x2]

    movz	w2,	#320
    str	w18,	[sp, fp]

    movz	fp,	#388
    movk	fp,	#2,	lsl #16
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w3,	#0
    movz	w16,	#8961
    movz	fp,	#444
    movz	w9,	#43913
    movz	w22,	#56574
    movz	w1,	#21622
    movz	w6,	#57840
    mov	w24,	w3
    movk	w16,	#26437,	lsl #16
    movk	fp,	#2,	lsl #16
    movk	w9,	#61389,	lsl #16
    movk	w22,	#39098,	lsl #16
    movk	w1,	#4146,	lsl #16
    movk	w6,	#50130,	lsl #16
    mov	w2,	w16
    str	w24,	[sp, fp]

    mov	w12,	w9
    mov	w21,	w22
    mov	w17,	w1
    mov	w0,	w6

main_63:
    movz	w5,	#0
    movz	fp,	#444
    mov	w8,	w5
    movk	fp,	#2,	lsl #16
    ldr	w20,	[sp, fp]

    mov	w24,	w20

main_70:
    cmp	w8,	#14
    blt	main_74

main_215:
    mov	w7,	w8

main_217:
    lsl	w20,	w7,	#2
    lsl	w3,	w24,	#2
    movz	fp,	#432
    mov	x5,	x20
    movk	fp,	#2,	lsl #16
    add	w20,	w24,	#3
    add	x5,	sp,	x5
    ldr	x9,	[sp, fp]

    lsl	w1,	w20,	#2
    movz	fp,	#432
    add	x5,	x5,	#16
    add	x11,	x9,	x3
    movk	fp,	#2,	lsl #16
    ldr	w6,	[x11]

    ldr	x10,	[sp, fp]

    add	w11,	w24,	#1
    lsl	w8,	w6,	#24
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    lsl	w6,	w11,	#2
    add	w11,	w24,	#2
    add	x13,	x10,	x6
    add	w24,	w24,	#4
    ldr	w3,	[x13]

    ldr	x14,	[sp, fp]

    lsl	w6,	w3,	#16
    movz	fp,	#432
    add	w9,	w6,	w8
    movk	fp,	#2,	lsl #16
    lsl	w8,	w11,	#2
    add	x13,	x14,	x8
    add	w8,	w7,	#1
    ldr	w15,	[x13]

    ldr	x10,	[sp, fp]

    lsl	w16,	w15,	#8
    add	x25,	x10,	x1
    add	w11,	w9,	w16
    ldr	w1,	[x25]

    add	w11,	w11,	w1
    str	w11,	[x5]

    cmp	w8,	#16
    blt	main_216

main_242:
    cmp	w8,	#80
    blt	main_245

main_275:
    mov	w15,	w2
    movz	fp,	#424
    mov	w3,	w12
    mov	w10,	w21
    mov	w7,	w17
    movz	w8,	#0
    movk	fp,	#2,	lsl #16
    str	w15,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w3,	[sp, fp]

    mov	w3,	w0
    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]

    mov	w10,	w8
    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    str	w10,	[sp, fp]


main_277:
    movz	w5,	#60289
    movz	w16,	#48348
    movz	w18,	#49414
    movz	w10,	#31129
    movz	w24,	#65535
    movz	fp,	#376
    movk	w5,	#28377,	lsl #16
    movk	w16,	#36635,	lsl #16
    movk	w18,	#51810,	lsl #16
    movk	w10,	#23170,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	fp,	#2,	lsl #16
    mov	w28,	w5
    mov	w4,	w16
    mov	w14,	w18
    mov	w8,	w10
    mov	w20,	w24
    ldr	w19,	[sp, fp]

    cmp	w19,	#20
    blt	main_285

main_370:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    cmp	w5,	#40
    blt	main_372

main_381:
    movz	fp,	#376
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    cmp	w7,	#60
    blt	main_383

main_401:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#420
    add	w22,	w27,	w24
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    sub	w10,	w19,	w22
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#412
    add	w16,	w10,	w26
    movk	fp,	#2,	lsl #16
    sub	w7,	w16,	w22
    ldr	w15,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    add	w16,	w15,	w7
    ldr	w11,	[sp, fp]

    sub	w5,	w7,	w16
    add	w5,	w5,	w11
    sub	w10,	w5,	w16
    mov	w11,	w10
    mov	w10,	w14
    b	main_410

main_383:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#412
    add	w16,	w10,	w5
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#412
    add	w10,	w25,	w22
    movk	fp,	#2,	lsl #16
    add	w24,	w10,	w16
    ldr	w25,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    sub	w7,	w16,	w24
    add	w11,	w7,	w10
    sub	w26,	w11,	w24
    sub	w6,	w26,	w11
    add	w7,	w6,	w24
    sub	w10,	w7,	w11
    ldr	w7,	[sp, fp]

    add	w24,	w25,	w7
    add	w6,	w24,	w10
    sub	w10,	w10,	w6
    add	w5,	w10,	w24
    sub	w18,	w5,	w6
    sub	w22,	w18,	w5
    add	w7,	w22,	w6
    sub	w10,	w7,	w5
    mov	w11,	w10
    mov	w10,	w4

main_410:
    mov	w22,	w11
    mov	w18,	w10
    b	main_413

main_372:
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#420
    add	w26,	w13,	w9
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    sub	w22,	w9,	w26
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#412
    add	w10,	w22,	w11
    movk	fp,	#2,	lsl #16
    sub	w10,	w10,	w26
    ldr	w27,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    add	w1,	w27,	w10
    ldr	w24,	[sp, fp]

    sub	w7,	w10,	w1
    add	w18,	w7,	w24
    sub	w10,	w18,	w1
    mov	w18,	w28
    mov	w22,	w10

main_413:
    mov	w10,	w22
    mov	w11,	w18
    b	main_416

main_285:
    movz	fp,	#420
    mov	w5,	w20
    movk	fp,	#2,	lsl #16
    ldr	w11,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#420
    add	w22,	w19,	w11
    movk	fp,	#2,	lsl #16
    mov	w11,	w8
    ldr	w16,	[sp, fp]

    movz	fp,	#412
    sub	w10,	w5,	w16
    movk	fp,	#2,	lsl #16
    ldr	w25,	[sp, fp]

    add	w10,	w25,	w10
    add	w25,	w10,	w22
    sub	w26,	w22,	w25
    add	w16,	w26,	w10
    sub	w7,	w16,	w25
    sub	w10,	w7,	w16
    add	w5,	w10,	w25
    sub	w10,	w5,	w16

main_416:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#424
    lsl	w5,	w15,	#5
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#424
    asr	w24,	w16,	#31
    movk	fp,	#2,	lsl #16
    lsr	w25,	w24,	#27
    ldr	w19,	[sp, fp]

    movz	fp,	#424
    add	w26,	w19,	w25
    movk	fp,	#2,	lsl #16
    asr	w7,	w26,	#5
    ldr	w24,	[sp, fp]

    movz	fp,	#376
    lsl	w22,	w7,	#5
    movk	fp,	#2,	lsl #16
    sub	w26,	w24,	w22
    ldr	w15,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    add	w24,	w5,	w26
    lsl	w5,	w15,	#2
    mov	x5,	x5
    add	w6,	w24,	w3
    add	x5,	sp,	x5
    add	w3,	w6,	w10
    add	x5,	x5,	#16
    add	w6,	w3,	w11
    ldr	w7,	[x5]

    ldr	w18,	[sp, fp]

    movz	fp,	#420
    lsl	w3,	w18,	#30
    add	w6,	w6,	w7
    movk	fp,	#2,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#420
    asr	w16,	w22,	#31
    movk	fp,	#2,	lsl #16
    lsr	w25,	w16,	#2
    ldr	w22,	[sp, fp]

    movz	fp,	#420
    add	w5,	w22,	w25
    movk	fp,	#2,	lsl #16
    asr	w24,	w5,	#30
    ldr	w26,	[sp, fp]

    movz	fp,	#376
    lsl	w11,	w24,	#30
    movk	fp,	#2,	lsl #16
    sub	w18,	w26,	w11
    add	w22,	w3,	w18
    ldr	w3,	[sp, fp]

    add	w3,	w3,	#1
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
    ldr	w10,	[sp, fp]

    movz	fp,	#424
    add	w24,	w22,	w10
    movk	fp,	#2,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#428
    sub	w7,	w16,	w24
    movk	fp,	#2,	lsl #16
    add	w8,	w7,	w22
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    sub	w10,	w8,	w24
    ldr	w16,	[sp, fp]

    mov	w8,	w14
    add	w24,	w9,	w10
    sub	w18,	w10,	w24
    add	w20,	w18,	w16
    sub	w20,	w20,	w24
    mov	w24,	w20
    b	main_318

main_300:
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#424
    add	w25,	w22,	w14
    movk	fp,	#2,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    add	w20,	w18,	w9
    movk	fp,	#2,	lsl #16
    add	w27,	w20,	w25
    sub	w11,	w25,	w27
    add	w7,	w11,	w20
    sub	w16,	w7,	w27
    sub	w18,	w16,	w7
    ldr	w16,	[sp, fp]

    add	w28,	w16,	w22
    add	w20,	w18,	w27
    sub	w1,	w20,	w7
    add	w18,	w28,	w1
    sub	w10,	w1,	w18
    add	w8,	w10,	w28
    sub	w14,	w8,	w18
    sub	w20,	w14,	w8
    add	w24,	w20,	w18
    sub	w20,	w24,	w8
    mov	w8,	w4
    mov	w24,	w20

main_318:
    mov	w20,	w24
    mov	w5,	w8
    b	main_321

main_350:
    movz	fp,	#424
    mov	w5,	w28
    movk	fp,	#2,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#424
    add	w11,	w22,	w4
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#428
    sub	w8,	w10,	w11
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	w22
    ldr	w18,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    sub	w11,	w10,	w11
    ldr	w9,	[sp, fp]

    add	w20,	w18,	w11
    sub	w16,	w11,	w20
    add	w18,	w16,	w9
    sub	w18,	w18,	w20
    mov	w20,	w18

main_321:
    mov	w25,	w20
    mov	w16,	w5
    b	main_324

main_359:
    movz	fp,	#424
    mov	w5,	w20
    mov	w16,	w8
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#424
    add	w24,	w22,	w15
    movk	fp,	#2,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#428
    sub	w10,	w5,	w19
    movk	fp,	#2,	lsl #16
    ldr	w15,	[sp, fp]

    add	w11,	w15,	w10
    add	w14,	w11,	w24
    sub	w27,	w24,	w14
    add	w28,	w27,	w11
    sub	w24,	w28,	w14
    sub	w25,	w24,	w28
    add	w4,	w25,	w14
    sub	w24,	w4,	w28
    mov	w25,	w24

main_324:
    lsl	w5,	w6,	#5
    asr	w14,	w6,	#31
    lsl	w1,	w3,	#2
    movz	fp,	#412
    lsr	w20,	w14,	#27
    mov	x28,	x1
    movk	fp,	#2,	lsl #16
    add	x28,	sp,	x28
    add	w24,	w6,	w20
    add	x28,	x28,	#16
    asr	w24,	w24,	#5
    ldr	w4,	[x28]

    lsl	w26,	w24,	#5
    ldr	w14,	[sp, fp]

    sub	w27,	w6,	w26
    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w18,	w27,	w14
    ldr	w15,	[sp, fp]

    movz	fp,	#424
    movk	fp,	#2,	lsl #16
    add	w20,	w18,	w5
    ldr	w27,	[sp, fp]

    lsl	w5,	w15,	#30
    movz	fp,	#424
    add	w10,	w20,	w25
    movk	fp,	#2,	lsl #16
    asr	w25,	w27,	#31
    ldr	w15,	[sp, fp]

    add	w7,	w10,	w16
    lsr	w28,	w25,	#2
    movz	fp,	#424
    add	w25,	w3,	#1
    movk	fp,	#2,	lsl #16
    add	w8,	w7,	w4
    ldr	w16,	[sp, fp]

    add	w4,	w15,	w28
    asr	w19,	w4,	#30
    lsl	w20,	w19,	#30
    sub	w14,	w16,	w20
    add	w18,	w5,	w14
    cmp	w25,	#80
    bge	main_433

main_276:
    mov	w7,	w8
    movz	fp,	#424
    mov	w9,	w6
    mov	w27,	w25
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    mov	w7,	w22
    movz	fp,	#420
    movk	fp,	#2,	lsl #16
    str	w9,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#2,	lsl #16
    str	w7,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#2,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#376
    mov	w3,	w7
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#428
    mov	w27,	w18
    movk	fp,	#2,	lsl #16
    str	w27,	[sp, fp]

    b	main_277

main_433:
    add	w3,	w8,	w2
    add	w15,	w6,	w12
    add	w25,	w18,	w21
    movz	fp,	#428
    add	w18,	w22,	w17
    movk	fp,	#2,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#444
    add	w0,	w6,	w0
    movk	fp,	#2,	lsl #16
    ldr	w26,	[sp, fp]

    movz	fp,	#440
    add	w11,	w26,	#64
    movk	fp,	#2,	lsl #16
    ldr	w27,	[sp, fp]

    cmp	w11,	w27
    bge	main_441

main_62:
    mov	w2,	w3
    mov	w12,	w15
    mov	w21,	w25
    mov	w17,	w18
    mov	w26,	w11
    movz	fp,	#444
    movk	fp,	#2,	lsl #16
    str	w26,	[sp, fp]

    b	main_63

main_441:
    movz	fp,	#380
    movk	fp,	#2,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#476
    str	w3,	[x21]

    movk	fp,	#2,	lsl #16
    movz	w3,	#0
    ldr	x14,	[sp, fp]

    movz	fp,	#468
    str	w15,	[x14]

    movk	fp,	#2,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#460
    str	w25,	[x27]

    movk	fp,	#2,	lsl #16
    ldr	x12,	[sp, fp]

    movz	fp,	#452
    str	w18,	[x12]

    movk	fp,	#2,	lsl #16
    ldr	x20,	[sp, fp]

    str	w0,	[x20]


main_442:
    cmp	w3,	#5
    blt	main_445

main_455:
    sub	w6,	w23,	#1
    cmp	w6,	#0
    bgt	main_27

main_460:
    movz	w0,	#184
    bl	_sysy_stoptime
    movz	fp,	#404
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
    mov	w23,	w6
    movz	fp,	#416
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
    mov	x22,	x24
    add	x13,	sp,	x13
    add	x22,	sp,	x22
    add	x13,	x13,	fp
    movz	fp,	#336
    movk	fp,	#2,	lsl #16
    ldr	w7,	[x13]

    add	x22,	x22,	fp
    ldr	w27,	[x22]

    add	w15,	w27,	w7
    sub	w14,	w7,	w15
    add	w0,	w14,	w27
    sub	w15,	w0,	w15
    str	w15,	[x13]

    b	main_442

main_245:
    lsl	w15,	w8,	#2
    sub	w19,	w8,	#3
    sub	w5,	w8,	#8
    sub	w10,	w8,	#14
    sub	w27,	w8,	#16
    mov	x13,	x15
    lsl	w24,	w19,	#2
    add	x13,	sp,	x13
    lsl	w9,	w5,	#2
    lsl	w14,	w10,	#2
    lsl	w1,	w27,	#2
    mov	x22,	x24
    add	x13,	x13,	#16
    mov	x7,	x9
    mov	x11,	x14
    mov	x28,	x1
    add	x22,	sp,	x22
    add	x7,	sp,	x7
    add	x11,	sp,	x11
    add	x28,	sp,	x28
    add	x22,	x22,	#16
    add	x7,	x7,	#16
    add	x11,	x11,	#16
    add	x28,	x28,	#16
    ldr	w26,	[x22]

    ldr	w16,	[x7]

    ldr	w18,	[x11]

    add	w9,	w16,	w26
    sub	w4,	w26,	w9
    add	w6,	w4,	w16
    sub	w9,	w6,	w9
    ldr	w6,	[x28]

    add	w10,	w18,	w9
    sub	w11,	w9,	w10
    add	w22,	w11,	w18
    sub	w14,	w22,	w10
    add	w1,	w6,	w14
    sub	w27,	w14,	w1
    add	w6,	w27,	w6
    sub	w22,	w6,	w1
    asr	w27,	w22,	#31
    lsl	w10,	w22,	#1
    lsr	w28,	w27,	#31
    add	w1,	w22,	w28
    asr	w5,	w1,	#1
    lsl	w6,	w5,	#1
    add	w5,	w8,	#1
    sub	w3,	w22,	w6
    mov	w8,	w5
    add	w4,	w10,	w3
    str	w4,	[x13]

    b	main_242

main_216:
    mov	w7,	w8
    b	main_217

main_74:
    lsl	w9,	w8,	#2
    lsl	w11,	w24,	#2
    movz	fp,	#432
    add	w28,	w24,	#1
    mov	x3,	x9
    movk	fp,	#2,	lsl #16
    add	x3,	sp,	x3
    lsl	w20,	w28,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#432
    add	x9,	x7,	x11
    add	x3,	x3,	#16
    movk	fp,	#2,	lsl #16
    ldr	w11,	[x9]

    ldr	x14,	[sp, fp]

    lsl	w19,	w11,	#24
    movz	fp,	#432
    add	x1,	x14,	x20
    add	w11,	w24,	#2
    movk	fp,	#2,	lsl #16
    ldr	w5,	[x1]

    lsl	w4,	w11,	#2
    ldr	x18,	[sp, fp]

    lsl	w6,	w5,	#16
    add	w11,	w24,	#3
    movz	fp,	#432
    add	x13,	x18,	x4
    add	w7,	w6,	w19
    movk	fp,	#2,	lsl #16
    lsl	w14,	w11,	#2
    add	w18,	w8,	#1
    ldr	w6,	[x13]

    ldr	x20,	[sp, fp]

    lsl	w9,	w6,	#8
    lsl	w19,	w18,	#2
    movz	fp,	#432
    add	x13,	x20,	x14
    add	w9,	w7,	w9
    mov	x11,	x19
    movk	fp,	#2,	lsl #16
    add	x11,	sp,	x11
    ldr	w15,	[x13]

    add	w9,	w9,	w15
    add	x11,	x11,	#16
    add	w15,	w24,	#4
    str	w9,	[x3]

    add	w26,	w15,	#3
    lsl	w25,	w15,	#2
    add	w9,	w15,	#2
    ldr	x10,	[sp, fp]

    movz	fp,	#432
    add	x20,	x10,	x25
    movk	fp,	#2,	lsl #16
    add	w10,	w15,	#1
    lsl	w1,	w9,	#2
    ldr	w25,	[x20]

    lsl	w20,	w10,	#2
    ldr	x3,	[sp, fp]

    lsl	w8,	w25,	#24
    movz	fp,	#432
    add	x13,	x3,	x20
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x13]

    lsl	w5,	w3,	#16
    lsl	w3,	w26,	#2
    add	w7,	w5,	w8
    add	w8,	w15,	#4
    ldr	x5,	[sp, fp]

    movz	fp,	#432
    add	x13,	x5,	x1
    movk	fp,	#2,	lsl #16
    add	w10,	w8,	#4
    ldr	w22,	[x13]

    add	w13,	w8,	#1
    ldr	x4,	[sp, fp]

    lsl	w25,	w22,	#8
    movz	fp,	#432
    add	x28,	x4,	x3
    movk	fp,	#2,	lsl #16
    add	w6,	w7,	w25
    lsl	w25,	w13,	#2
    add	w7,	w18,	#1
    ldr	w3,	[x28]

    add	w20,	w6,	w3
    add	w24,	w7,	#1
    lsl	w26,	w7,	#2
    lsl	w3,	w8,	#2
    mov	x22,	x26
    str	w20,	[x11]

    add	w26,	w8,	#2
    add	x22,	sp,	x22
    add	w11,	w8,	#3
    add	w20,	w24,	#1
    ldr	x19,	[sp, fp]

    lsl	w5,	w26,	#2
    movz	fp,	#432
    add	x22,	x22,	#16
    add	x28,	x19,	x3
    add	w26,	w10,	#1
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x28]

    lsl	w27,	w26,	#2
    ldr	x13,	[sp, fp]

    lsl	w9,	w3,	#24
    movz	fp,	#432
    add	x14,	x13,	x25
    movk	fp,	#2,	lsl #16
    add	w25,	w10,	#4
    ldr	w16,	[x14]

    add	w19,	w25,	#3
    lsl	w14,	w10,	#2
    ldr	x13,	[sp, fp]

    lsl	w18,	w16,	#16
    movz	fp,	#432
    add	x28,	x13,	x5
    lsl	w16,	w11,	#2
    add	w18,	w18,	w9
    movk	fp,	#2,	lsl #16
    add	w11,	w10,	#2
    ldr	w3,	[x28]

    ldr	x13,	[sp, fp]

    lsl	w4,	w3,	#8
    lsl	w7,	w11,	#2
    movz	fp,	#432
    add	x13,	x13,	x16
    add	w3,	w18,	w4
    add	w11,	w10,	#3
    movk	fp,	#2,	lsl #16
    lsl	w4,	w24,	#2
    lsl	w10,	w25,	#2
    ldr	w15,	[x13]

    add	w24,	w20,	#1
    mov	x4,	x4
    add	w28,	w3,	w15
    add	x4,	sp,	x4
    str	w28,	[x22]

    add	x4,	x4,	#16
    ldr	x1,	[sp, fp]

    movz	fp,	#432
    add	x9,	x1,	x14
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x9]

    ldr	x3,	[sp, fp]

    lsl	w16,	w13,	#24
    movz	fp,	#432
    add	x28,	x3,	x27
    movk	fp,	#2,	lsl #16
    ldr	w3,	[x28]

    ldr	x8,	[sp, fp]

    lsl	w5,	w3,	#16
    movz	fp,	#432
    add	x13,	x8,	x7
    add	w5,	w5,	w16
    movk	fp,	#2,	lsl #16
    lsl	w8,	w20,	#2
    ldr	w15,	[x13]

    lsl	w3,	w15,	#8
    lsl	w15,	w11,	#2
    add	w6,	w5,	w3
    ldr	x11,	[sp, fp]

    movz	fp,	#432
    add	x13,	x11,	x15
    movk	fp,	#2,	lsl #16
    ldr	w15,	[x13]

    add	w9,	w6,	w15
    str	w9,	[x4]

    ldr	x9,	[sp, fp]

    mov	x4,	x8
    movz	fp,	#432
    add	x8,	x9,	x10
    add	x4,	sp,	x4
    movk	fp,	#2,	lsl #16
    ldr	w10,	[x8]

    add	x4,	x4,	#16
    ldr	x13,	[sp, fp]

    add	w8,	w25,	#1
    lsl	w6,	w10,	#24
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    lsl	w1,	w8,	#2
    add	x10,	x13,	x1
    lsl	w1,	w19,	#2
    ldr	w13,	[x10]

    ldr	x16,	[sp, fp]

    add	w10,	w25,	#2
    lsl	w7,	w13,	#16
    movz	fp,	#432
    movk	fp,	#2,	lsl #16
    lsl	w5,	w10,	#2
    add	w9,	w7,	w6
    add	w6,	w25,	#4
    add	x11,	x16,	x5
    add	w25,	w6,	#2
    lsl	w18,	w6,	#2
    ldr	w14,	[x11]

    add	w11,	w24,	#1
    lsl	w15,	w14,	#8
    add	w8,	w9,	w15
    add	w9,	w6,	#1
    ldr	x15,	[sp, fp]

    movz	fp,	#432
    add	x26,	x15,	x1
    movk	fp,	#2,	lsl #16
    lsl	w5,	w9,	#2
    ldr	w1,	[x26]

    add	w8,	w8,	w1
    str	w8,	[x4]

    ldr	x7,	[sp, fp]

    lsl	w8,	w24,	#2
    movz	fp,	#432
    add	x14,	x7,	x18
    mov	x15,	x8
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    ldr	w22,	[x14]

    ldr	x26,	[sp, fp]

    lsl	w7,	w22,	#24
    add	x15,	x15,	#16
    movz	fp,	#432
    add	x10,	x26,	x5
    movk	fp,	#2,	lsl #16
    ldr	w13,	[x10]

    ldr	x1,	[sp, fp]

    lsl	w16,	w13,	#16
    movz	fp,	#432
    add	w18,	w16,	w7
    movk	fp,	#2,	lsl #16
    lsl	w7,	w25,	#2
    add	x26,	x1,	x7
    add	w7,	w6,	#3
    ldr	w1,	[x26]

    lsl	w13,	w7,	#2
    ldr	x28,	[sp, fp]

    lsl	w3,	w1,	#8
    movz	fp,	#432
    add	x9,	x28,	x13
    movk	fp,	#2,	lsl #16
    add	w10,	w18,	w3
    add	w18,	w6,	#4
    ldr	w13,	[x9]

    add	w14,	w10,	w13
    add	w24,	w18,	#1
    lsl	w4,	w18,	#2
    str	w14,	[x15]

    lsl	w7,	w24,	#2
    ldr	x14,	[sp, fp]

    lsl	w15,	w11,	#2
    add	w24,	w18,	#4
    movz	fp,	#432
    add	x1,	x14,	x4
    mov	x25,	x15
    movk	fp,	#2,	lsl #16
    add	x25,	sp,	x25
    ldr	w4,	[x1]

    ldr	x5,	[sp, fp]

    lsl	w16,	w4,	#24
    add	x25,	x25,	#16
    movz	fp,	#432
    add	x28,	x5,	x7
    movk	fp,	#2,	lsl #16
    add	w7,	w18,	#2
    ldr	w3,	[x28]

    lsl	w9,	w7,	#2
    ldr	x8,	[sp, fp]

    lsl	w4,	w3,	#16
    movz	fp,	#432
    add	x9,	x8,	x9
    movk	fp,	#2,	lsl #16
    add	w5,	w4,	w16
    ldr	w13,	[x9]

    ldr	x8,	[sp, fp]

    lsl	w14,	w13,	#8
    add	w13,	w5,	w14
    add	w14,	w11,	#1
    add	w5,	w18,	#3
    lsl	w7,	w5,	#2
    add	x6,	x8,	x7
    mov	w8,	w14
    ldr	w9,	[x6]

    add	w1,	w13,	w9
    str	w1,	[x25]

    b	main_70

main_50:
    lsl	w16,	w3,	#2
    movz	fp,	#432
    movz	w14,	#0
    add	w5,	w3,	#1
    movk	fp,	#2,	lsl #16
    mov	w3,	w5
    ldr	x25,	[sp, fp]

    add	x19,	x25,	x16
    str	w14,	[x19]

    b	main_46

main_35:
    lsl	w17,	w20,	#2
    movz	fp,	#416
    add	w20,	w20,	#1
    mov	x1,	x17
    movk	fp,	#2,	lsl #16
    add	x1,	sp,	x1
    ldr	w4,	[sp, fp]

    add	x1,	x1,	#336
    movz	fp,	#416
    lsl	w18,	w4,	#13
    movk	fp,	#2,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#416
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
    asr	w26,	w12,	#8
    lsl	w28,	w26,	#8
    sub	w0,	w24,	w28
    str	w0,	[x1]

    str	w24,	[sp, fp]

    b	main_31

