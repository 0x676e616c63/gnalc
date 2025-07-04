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
    movz	fp,	#31440
    movk	fp,	#16,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w24,	#32320
    movz	w1,	#0
    movz	fp,	#64656
    movk	w24,	#5,	lsl #16
    movk	fp,	#10,	lsl #16
    mov	x2,	x24
    add	x0,	sp,	fp
    bl	memset
    mov	x2,	x24
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    mov	x2,	x24
    movz	w1,	#0
    movz	fp,	#32336
    movk	fp,	#5,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w20,	#0

main_5:
    cmp	w20,	#300
    blt	main_8

main_14:
    movz	w0,	#23
    bl	_sysy_starttime
    movz	w3,	#0

main_16:
    movz	w9,	#1200
    movz	w0,	#0
    mul	w1,	w3,	w9
    mov	x8,	x1
    add	x8,	sp,	x8
    add	x8,	x8,	#16

main_19:
    cmp	w0,	#296
    blt	main_22

main_65:
    lsl	w15,	w0,	#2
    movz	w23,	#1200
    movz	fp,	#32336
    lsl	w19,	w3,	#2
    add	x24,	x8,	x15
    mul	w17,	w0,	w23
    movk	fp,	#5,	lsl #16
    add	w0,	w0,	#1
    mov	x21,	x17
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    add	x18,	x21,	x19
    ldr	w20,	[x18]

    str	w20,	[x24]

    cmp	w0,	#300
    blt	main_65

main_73:
    add	w3,	w3,	#1
    cmp	w3,	#300
    blt	main_16

main_76:
    movz	w21,	#0

main_78:
    movz	w13,	#1200
    movz	fp,	#32336
    movz	w24,	#1200
    movz	w22,	#0
    mul	w15,	w21,	w13
    movk	fp,	#5,	lsl #16
    mul	w12,	w21,	w24
    mov	x26,	x15
    mov	x14,	x12
    add	x26,	sp,	x26
    add	x14,	sp,	x14
    add	x26,	x26,	fp
    movz	fp,	#64656
    movk	fp,	#10,	lsl #16
    add	x14,	x14,	fp

main_83:
    movz	w7,	#0
    movz	w28,	#0

main_85:
    cmp	w7,	#296
    blt	main_89

main_180:
    lsl	w4,	w7,	#2
    movz	w13,	#1200
    lsl	w10,	w22,	#2
    add	x3,	x26,	x4
    mul	w8,	w7,	w13
    mov	x17,	x8
    add	x17,	sp,	x17
    ldr	w1,	[x3]

    add	x17,	x17,	#16
    add	x9,	x17,	x10
    ldr	w17,	[x9]

    madd	w15,	w17,	w1,	w28

    mul	w20,	w17,	w1
    asr	w4,	w20,	#31
    lsr	w5,	w4,	#31
    madd	w6,	w17,	w1,	w5

    asr	w10,	w6,	#1
    lsl	w11,	w10,	#1
    sub	w25,	w20,	w11
    cmp	w25,	#0
    add	w7,	w7,	#1
    csel	w28,	w15,	w28,	eq
    cmp	w7,	#300
    blt	main_180

main_195:
    lsl	w3,	w22,	#2
    add	w22,	w22,	#1
    add	x2,	x14,	x3
    str	w28,	[x2]

    cmp	w22,	#300
    blt	main_83

main_199:
    add	w21,	w21,	#1
    cmp	w21,	#300
    blt	main_78

main_202:
    movz	w15,	#0

main_204:
    movz	w21,	#1200
    movz	fp,	#64656
    movz	w20,	#0
    movz	w10,	#65535
    mul	w13,	w15,	w21
    movk	fp,	#10,	lsl #16
    movk	w10,	#32767,	lsl #16
    mov	x2,	x13
    add	x2,	sp,	x2
    add	x2,	x2,	fp

main_207:
    cmp	w20,	#296
    blt	main_211

main_254:
    lsl	w7,	w20,	#2
    add	x6,	x2,	x7
    ldr	w8,	[x6]

    cmp	w8,	w10
    add	w20,	w20,	#1
    csel	w10,	w8,	w10,	lt
    cmp	w20,	#300
    blt	main_254

main_263:
    movz	w14,	#0

main_264:
    cmp	w14,	#296
    blt	main_267

main_286:
    lsl	w18,	w14,	#2
    add	w14,	w14,	#1
    add	x17,	x2,	x18
    str	w10,	[x17]

    cmp	w14,	#300
    blt	main_286

main_291:
    add	w15,	w15,	#1
    cmp	w15,	#300
    blt	main_204

main_294:
    movz	w0,	#0

main_296:
    movz	w24,	#1200
    movz	fp,	#64656
    movz	w2,	#0
    movk	fp,	#10,	lsl #16
    mul	w3,	w0,	w24
    mov	x7,	x3
    add	x7,	sp,	x7
    add	x7,	x7,	fp

main_299:
    cmp	w2,	#296
    blt	main_302

main_353:
    lsl	w20,	w2,	#2
    movz	w17,	#1200
    movz	fp,	#64656
    lsl	w24,	w0,	#2
    movz	w15,	#0
    add	x14,	x7,	x20
    mul	w22,	w2,	w17
    movk	fp,	#10,	lsl #16
    add	w2,	w2,	#1
    mov	x28,	x22
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    add	x23,	x28,	x24
    ldr	w5,	[x23]

    sub	w26,	w15,	w5
    str	w26,	[x14]

    cmp	w2,	#300
    blt	main_353

main_362:
    add	w0,	w0,	#1
    cmp	w0,	#300
    blt	main_296

main_365:
    movz	w12,	#0
    movz	w24,	#0

main_367:
    movz	w13,	#1200
    movz	fp,	#64656
    movz	w2,	#0
    movk	fp,	#10,	lsl #16
    mul	w15,	w12,	w13
    mov	x3,	x15
    add	x3,	sp,	x3
    add	x3,	x3,	fp

main_371:
    cmp	w2,	#296
    blt	main_375

main_410:
    lsl	w16,	w2,	#2
    add	w2,	w2,	#1
    add	x15,	x3,	x16
    ldr	w17,	[x15]

    add	w24,	w17,	w24
    cmp	w2,	#300
    blt	main_410

main_418:
    add	w12,	w12,	#1
    cmp	w12,	#300
    blt	main_367

main_421:
    movz	w0,	#93
    bl	_sysy_stoptime
    mov	w0,	w24
    bl	putint
    movz	w0,	#0
    b	main_423

main_375:
    lsl	w25,	w2,	#2
    add	w6,	w2,	#1
    add	x23,	x3,	x25
    add	w11,	w6,	#1
    lsl	w4,	w6,	#2
    ldr	w26,	[x23]

    add	x2,	x3,	x4
    add	w17,	w11,	#1
    lsl	w9,	w11,	#2
    add	w1,	w26,	w24
    ldr	w5,	[x2]

    add	x8,	x3,	x9
    add	w22,	w17,	#1
    lsl	w15,	w17,	#2
    add	w7,	w5,	w1
    ldr	w10,	[x8]

    add	x14,	x3,	x15
    add	w28,	w22,	#1
    lsl	w20,	w22,	#2
    add	w13,	w10,	w7
    ldr	w16,	[x14]

    add	x19,	x3,	x20
    add	w8,	w28,	#1
    lsl	w25,	w28,	#2
    add	w18,	w16,	w13
    ldr	w21,	[x19]

    add	x24,	x3,	x25
    add	w14,	w8,	#1
    lsl	w1,	w8,	#2
    add	w23,	w21,	w18
    ldr	w26,	[x24]

    add	x0,	x3,	x1
    add	w7,	w26,	w23
    ldr	w2,	[x0]

    add	w13,	w2,	w7
    add	w2,	w14,	#1
    lsl	w7,	w14,	#2
    add	x6,	x3,	x7
    ldr	w8,	[x6]

    add	w24,	w8,	w13
    b	main_371

main_302:
    lsl	w4,	w2,	#2
    movz	w3,	#1200
    movz	fp,	#64656
    lsl	w9,	w0,	#2
    movz	w1,	#0
    movz	w28,	#1200
    lsl	w26,	w0,	#2
    lsl	w17,	w0,	#2
    movz	w27,	#1200
    add	x5,	x7,	x4
    mul	w6,	w2,	w3
    movk	fp,	#10,	lsl #16
    add	w2,	w2,	#1
    mov	x16,	x6
    add	x16,	sp,	x16
    mul	w24,	w2,	w28
    lsl	w22,	w2,	#2
    add	x16,	x16,	fp
    mov	x14,	x24
    movz	fp,	#64656
    movz	w24,	#1200
    add	x14,	sp,	x14
    movk	fp,	#10,	lsl #16
    add	x8,	x16,	x9
    add	x16,	x7,	x22
    add	x14,	x14,	fp
    movz	w22,	#0
    ldr	w20,	[x8]

    movz	fp,	#64656
    lsl	w8,	w0,	#2
    sub	w11,	w1,	w20
    add	x25,	x14,	x26
    movk	fp,	#10,	lsl #16
    add	w1,	w2,	#1
    movz	w20,	#1200
    str	w11,	[x5]

    movz	w14,	#0
    movz	w26,	#0
    ldr	w18,	[x25]

    lsl	w3,	w1,	#2
    add	w11,	w1,	#1
    mul	w5,	w1,	w24
    sub	w28,	w26,	w18
    add	x19,	x7,	x3
    mov	x24,	x5
    add	w23,	w11,	#1
    mul	w15,	w11,	w20
    lsl	w13,	w11,	#2
    lsl	w26,	w0,	#2
    movz	w18,	#0
    str	w28,	[x16]

    add	x24,	sp,	x24
    mov	x5,	x15
    add	x2,	x7,	x13
    add	x5,	sp,	x5
    add	x24,	x24,	fp
    movz	fp,	#64656
    movk	fp,	#10,	lsl #16
    add	x6,	x24,	x8
    add	x5,	x5,	fp
    lsl	w8,	w0,	#2
    movz	fp,	#64656
    ldr	w28,	[x6]

    movk	fp,	#10,	lsl #16
    add	x16,	x5,	x17
    sub	w10,	w22,	w28
    lsl	w17,	w0,	#2
    lsl	w22,	w23,	#2
    str	w10,	[x19]

    add	x12,	x7,	x22
    ldr	w10,	[x16]

    movz	w16,	#1200
    sub	w19,	w18,	w10
    movz	w10,	#0
    mul	w24,	w23,	w16
    str	w19,	[x2]

    mov	x15,	x24
    add	w19,	w23,	#1
    add	x15,	sp,	x15
    lsl	w3,	w19,	#2
    add	x15,	x15,	fp
    movz	fp,	#64656
    add	x2,	x7,	x3
    movk	fp,	#10,	lsl #16
    add	x25,	x15,	x26
    lsl	w26,	w0,	#2
    ldr	w20,	[x25]

    sub	w28,	w14,	w20
    str	w28,	[x12]

    movz	w12,	#1200
    mul	w5,	w19,	w12
    mov	x25,	x5
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    movz	fp,	#64656
    movk	fp,	#10,	lsl #16
    add	x6,	x25,	x8
    movz	w8,	#1200
    ldr	w1,	[x6]

    sub	w10,	w10,	w1
    add	w1,	w19,	#1
    str	w10,	[x2]

    mul	w15,	w1,	w8
    add	w21,	w1,	#1
    lsl	w13,	w1,	#2
    mov	x6,	x15
    add	x6,	sp,	x6
    add	w2,	w21,	#1
    mul	w24,	w21,	w27
    lsl	w22,	w21,	#2
    add	x14,	x7,	x13
    add	x6,	x6,	fp
    add	x22,	x7,	x22
    movz	fp,	#64656
    movk	fp,	#10,	lsl #16
    add	x16,	x6,	x17
    movz	w6,	#0
    ldr	w12,	[x16]

    mov	x16,	x24
    sub	w19,	w6,	w12
    add	x16,	sp,	x16
    str	w19,	[x14]

    add	x16,	x16,	fp
    add	x25,	x16,	x26
    ldr	w20,	[x25]

    movz	w25,	#0
    sub	w28,	w25,	w20
    str	w28,	[x22]

    b	main_299

main_267:
    lsl	w9,	w14,	#2
    add	w24,	w14,	#1
    add	x8,	x2,	x9
    add	w0,	w24,	#1
    lsl	w28,	w24,	#2
    str	w10,	[x8]

    add	x27,	x2,	x28
    add	w4,	w0,	#1
    lsl	w3,	w0,	#2
    str	w10,	[x27]

    add	x1,	x2,	x3
    add	w7,	w4,	#1
    lsl	w6,	w4,	#2
    str	w10,	[x1]

    add	x5,	x2,	x6
    add	w11,	w7,	#1
    lsl	w9,	w7,	#2
    str	w10,	[x5]

    add	x8,	x2,	x9
    add	w14,	w11,	#1
    lsl	w13,	w11,	#2
    str	w10,	[x8]

    add	x12,	x2,	x13
    add	w18,	w14,	#1
    lsl	w17,	w14,	#2
    str	w10,	[x12]

    add	x16,	x2,	x17
    lsl	w20,	w18,	#2
    add	w14,	w18,	#1
    str	w10,	[x16]

    add	x19,	x2,	x20
    str	w10,	[x19]

    b	main_264

main_211:
    lsl	w8,	w20,	#2
    add	x7,	x2,	x8
    ldr	w9,	[x7]

    cmp	w9,	w10
    csel	w24,	w9,	w10,	lt
    add	w0,	w20,	#1
    lsl	w6,	w0,	#2
    add	x5,	x2,	x6
    ldr	w7,	[x5]

    cmp	w7,	w24
    add	w8,	w0,	#1
    csel	w7,	w7,	w24,	lt
    lsl	w12,	w8,	#2
    add	x11,	x2,	x12
    ldr	w13,	[x11]

    cmp	w13,	w7
    csel	w14,	w13,	w7,	lt
    add	w13,	w8,	#1
    lsl	w19,	w13,	#2
    add	x18,	x2,	x19
    ldr	w20,	[x18]

    cmp	w20,	w14
    add	w22,	w13,	#1
    csel	w20,	w20,	w14,	lt
    lsl	w25,	w22,	#2
    add	x24,	x2,	x25
    ldr	w26,	[x24]

    cmp	w26,	w20
    add	w6,	w22,	#1
    csel	w5,	w26,	w20,	lt
    lsl	w3,	w6,	#2
    add	x1,	x2,	x3
    ldr	w4,	[x1]

    cmp	w4,	w5
    add	w12,	w6,	#1
    csel	w11,	w4,	w5,	lt
    lsl	w9,	w12,	#2
    add	x8,	x2,	x9
    ldr	w10,	[x8]

    cmp	w10,	w11
    add	w20,	w12,	#1
    csel	w18,	w10,	w11,	lt
    lsl	w16,	w20,	#2
    add	x14,	x2,	x16
    ldr	w17,	[x14]

    cmp	w17,	w18
    add	w20,	w20,	#1
    csel	w10,	w17,	w18,	lt
    b	main_207

main_89:
    lsl	w27,	w7,	#2
    movz	w1,	#1200
    lsl	w4,	w22,	#2
    add	x25,	x26,	x27
    mul	w2,	w7,	w1
    ldr	w13,	[x25]

    mov	x25,	x2
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    add	x3,	x25,	x4
    ldr	w5,	[x3]

    mul	w16,	w5,	w13
    asr	w8,	w16,	#31
    lsr	w9,	w8,	#31
    madd	w10,	w5,	w13,	w9

    asr	w2,	w10,	#1
    madd	w9,	w5,	w13,	w28

    lsl	w3,	w2,	#1
    sub	w4,	w16,	w3
    cmp	w4,	#0
    add	w18,	w7,	#1
    csel	w16,	w9,	w28,	eq
    movz	w25,	#1200
    lsl	w28,	w22,	#2
    lsl	w20,	w18,	#2
    mul	w25,	w18,	w25
    mov	x12,	x25
    add	x19,	x26,	x20
    add	x12,	sp,	x12
    ldr	w6,	[x19]

    add	x12,	x12,	#16
    add	x27,	x12,	x28
    ldr	w7,	[x27]

    mul	w1,	w7,	w6
    asr	w11,	w1,	#31
    lsr	w12,	w11,	#31
    madd	w13,	w7,	w6,	w12

    asr	w2,	w13,	#1
    lsl	w3,	w2,	#1
    sub	w20,	w1,	w3
    madd	w3,	w7,	w6,	w16

    cmp	w20,	#0
    csel	w10,	w3,	w16,	eq
    add	w24,	w18,	#1
    movz	w20,	#1200
    lsl	w13,	w22,	#2
    lsl	w8,	w24,	#2
    mul	w11,	w24,	w20
    mov	x2,	x11
    add	x7,	x26,	x8
    add	x2,	sp,	x2
    ldr	w3,	[x7]

    add	x2,	x2,	#16
    add	x12,	x2,	x13
    ldr	w0,	[x12]

    madd	w18,	w0,	w3,	w10

    mul	w19,	w0,	w3
    asr	w15,	w19,	#31
    lsr	w16,	w15,	#31
    madd	w17,	w0,	w3,	w16

    asr	w25,	w17,	#1
    lsl	w27,	w25,	#1
    sub	w8,	w19,	w27
    cmp	w8,	#0
    csel	w5,	w18,	w10,	eq
    add	w7,	w24,	#1
    lsl	w2,	w22,	#2
    movz	w15,	#1200
    lsl	w25,	w7,	#2
    mul	w0,	w7,	w15
    mov	x18,	x0
    add	x24,	x26,	x25
    add	x18,	sp,	x18
    ldr	w11,	[x24]

    add	x18,	x18,	#16
    add	x1,	x18,	x2
    ldr	w9,	[x1]

    madd	w6,	w9,	w11,	w5

    mul	w1,	w9,	w11
    asr	w18,	w1,	#31
    lsr	w19,	w18,	#31
    madd	w20,	w9,	w11,	w19

    asr	w18,	w20,	#1
    lsl	w19,	w18,	#1
    sub	w27,	w1,	w19
    cmp	w27,	#0
    csel	w8,	w6,	w5,	eq
    add	w2,	w7,	#1
    lsl	w17,	w22,	#2
    lsl	w11,	w2,	#2
    add	x10,	x26,	x11
    ldr	w18,	[x10]

    movz	w10,	#1200
    mul	w15,	w2,	w10
    mov	x6,	x15
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    add	x16,	x6,	x17
    ldr	w11,	[x16]

    mul	w3,	w11,	w18
    asr	w23,	w3,	#31
    lsr	w24,	w23,	#31
    madd	w23,	w11,	w18,	w8

    madd	w25,	w11,	w18,	w24

    asr	w12,	w25,	#1
    lsl	w13,	w12,	#1
    sub	w12,	w3,	w13
    cmp	w12,	#0
    csel	w17,	w23,	w8,	eq
    add	w20,	w2,	#1
    movz	w5,	#1200
    lsl	w0,	w20,	#2
    mul	w3,	w20,	w5
    lsl	w5,	w22,	#2
    mov	x24,	x3
    add	x28,	x26,	x0
    add	x24,	sp,	x24
    ldr	w18,	[x28]

    add	x24,	x24,	#16
    add	x4,	x24,	x5
    ldr	w10,	[x4]

    madd	w9,	w10,	w18,	w17

    mul	w23,	w10,	w18
    asr	w27,	w23,	#31
    lsr	w28,	w27,	#31
    madd	w0,	w10,	w18,	w28

    asr	w7,	w0,	#1
    lsl	w8,	w7,	#1
    sub	w2,	w23,	w8
    cmp	w2,	#0
    movz	w0,	#1200
    csel	w5,	w9,	w17,	eq
    add	w6,	w20,	#1
    lsl	w20,	w22,	#2
    mul	w18,	w6,	w0
    lsl	w15,	w6,	#2
    mov	x10,	x18
    add	x13,	x26,	x15
    add	x10,	sp,	x10
    ldr	w7,	[x13]

    add	x10,	x10,	#16
    add	x19,	x10,	x20
    ldr	w13,	[x19]

    madd	w27,	w13,	w7,	w5

    mul	w28,	w13,	w7
    asr	w1,	w28,	#31
    lsr	w2,	w1,	#31
    madd	w3,	w13,	w7,	w2

    asr	w2,	w3,	#1
    lsl	w3,	w2,	#1
    sub	w17,	w28,	w3
    cmp	w17,	#0
    csel	w16,	w27,	w5,	eq
    add	w13,	w6,	#1
    movz	w24,	#1200
    lsl	w8,	w22,	#2
    lsl	w3,	w13,	#2
    mul	w6,	w13,	w24
    mov	x0,	x6
    add	x2,	x26,	x3
    add	x0,	sp,	x0
    ldr	w28,	[x2]

    add	x0,	x0,	#16
    add	x7,	x0,	x8
    ldr	w19,	[x7]

    madd	w12,	w19,	w28,	w16

    mul	w8,	w19,	w28
    asr	w4,	w8,	#31
    lsr	w5,	w4,	#31
    madd	w6,	w19,	w28,	w5

    asr	w25,	w6,	#1
    lsl	w27,	w25,	#1
    sub	w6,	w8,	w27
    cmp	w6,	#0
    add	w7,	w13,	#1
    csel	w28,	w12,	w16,	eq
    b	main_85

main_22:
    lsl	w27,	w0,	#2
    movz	w25,	#1200
    movz	fp,	#32336
    lsl	w4,	w3,	#2
    add	w23,	w0,	#1
    lsl	w11,	w3,	#2
    movz	w19,	#1200
    movz	w16,	#1200
    lsl	w7,	w3,	#2
    add	x18,	x8,	x27
    mul	w1,	w0,	w25
    movk	fp,	#5,	lsl #16
    lsl	w6,	w23,	#2
    lsl	w27,	w3,	#2
    mov	x22,	x1
    add	x6,	x8,	x6
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    movz	fp,	#32336
    movk	fp,	#5,	lsl #16
    add	x2,	x22,	x4
    movz	w22,	#1200
    ldr	w5,	[x2]

    mul	w9,	w23,	w22
    add	w2,	w23,	#1
    str	w5,	[x18]

    mov	x9,	x9
    add	x9,	sp,	x9
    mul	w17,	w2,	w19
    lsl	w15,	w2,	#2
    lsl	w19,	w3,	#2
    mov	x17,	x17
    add	x9,	x9,	fp
    add	x13,	x8,	x15
    add	x17,	sp,	x17
    movz	fp,	#32336
    movk	fp,	#5,	lsl #16
    add	x10,	x9,	x11
    add	x17,	x17,	fp
    movz	fp,	#32336
    ldr	w12,	[x10]

    movk	fp,	#5,	lsl #16
    add	x18,	x17,	x19
    movz	w10,	#1200
    str	w12,	[x6]

    add	w17,	w2,	#1
    ldr	w20,	[x18]

    mul	w25,	w17,	w16
    add	w4,	w17,	#1
    lsl	w23,	w17,	#2
    str	w20,	[x13]

    lsl	w16,	w3,	#2
    mov	x25,	x25
    add	w18,	w4,	#1
    lsl	w2,	w4,	#2
    add	x24,	x8,	x23
    movz	w13,	#1200
    add	x25,	sp,	x25
    add	x14,	x8,	x2
    lsl	w12,	w18,	#2
    mul	w5,	w4,	w13
    movz	w4,	#1200
    mov	x6,	x5
    add	x25,	x25,	fp
    add	x22,	x8,	x12
    add	x6,	sp,	x6
    movz	fp,	#32336
    movk	fp,	#5,	lsl #16
    add	x26,	x25,	x27
    add	x6,	x6,	fp
    add	w27,	w18,	#1
    movz	fp,	#32336
    ldr	w28,	[x26]

    movk	fp,	#5,	lsl #16
    add	x6,	x6,	x7
    add	w0,	w27,	#1
    lsl	w20,	w27,	#2
    str	w28,	[x24]

    movz	w7,	#1200
    lsl	w24,	w3,	#2
    lsl	w28,	w0,	#2
    ldr	w9,	[x6]

    add	x1,	x8,	x20
    str	w9,	[x14]

    add	x11,	x8,	x28
    mul	w14,	w18,	w10
    mov	x15,	x14
    add	x15,	sp,	x15
    add	x15,	x15,	fp
    movz	fp,	#32336
    movk	fp,	#5,	lsl #16
    add	x15,	x15,	x16
    ldr	w17,	[x15]

    str	w17,	[x22]

    mul	w22,	w27,	w7
    mov	x23,	x22
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    movz	fp,	#32336
    movk	fp,	#5,	lsl #16
    add	x23,	x23,	x24
    ldr	w25,	[x23]

    str	w25,	[x1]

    mul	w1,	w0,	w4
    add	w0,	w0,	#1
    lsl	w4,	w3,	#2
    mov	x5,	x1
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    add	x2,	x5,	x4
    ldr	w5,	[x2]

    str	w5,	[x11]

    b	main_19

main_8:
    movz	w26,	#1200
    movz	fp,	#32336
    movk	fp,	#5,	lsl #16
    mul	w25,	w20,	w26
    mov	x0,	x25
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    bl	getarray
    add	w20,	w20,	#1
    cmp	w0,	#300
    beq	main_5

main_423:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#31440
    movk	fp,	#16,	lsl #16
    add	sp, sp, fp
    ret


