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
    movz	fp,	#52128
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#4020
    movz	w1,	#0
    movz	fp,	#48096
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#4020
    movz	w1,	#0
    movz	fp,	#20036
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#4020
    movz	w1,	#0
    movz	fp,	#44076
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#20020
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#20020
    movz	w1,	#0
    movz	fp,	#24056
    add	x0,	sp,	fp
    bl	memset
    bl	getch
    mov	w27,	w0

main_7:
    cmp	w27,	#48
    blt	main_14

main_10:
    cmp	w27,	#57
    bgt	main_14

main_17:
    cmp	w27,	#48
    blt	main_26

main_20:
    cmp	w27,	#57
    ble	main_22

main_26:
    bl	getch
    movz	w23,	#0
    mov	w2,	w0

main_28:
    cmp	w2,	#48
    blt	main_36

main_32:
    cmp	w2,	#57
    bgt	main_36

main_40:
    movz	w25,	#0

main_41:
    cmp	w2,	#48
    blt	main_54

main_45:
    cmp	w2,	#57
    ble	main_47

main_54:
    movz	w5,	#0
    sub	w4,	w5,	w25
    cmp	w23,	#0
    movz	w9,	#0
    csel	w11,	w4,	w25,	ne

main_58:
    movz	w4,	#65535
    movk	w4,	#65535,	lsl #16
    mov	w21,	w4
    cmp	w9,	#952
    blt	main_61

main_176:
    lsl	w16,	w9,	#2
    movz	fp,	#44076
    add	w14,	w9,	#1
    mov	w19,	w21
    mov	w10,	w21
    mov	w8,	w21
    mov	x15,	x16
    add	w18,	w14,	#1
    lsl	w13,	w14,	#2
    add	x15,	sp,	x15
    mov	x17,	x13
    mov	w13,	w21
    add	x17,	sp,	x17
    lsl	w16,	w18,	#2
    add	x15,	x15,	fp
    mov	x22,	x16
    movz	fp,	#44076
    add	x22,	sp,	x22
    str	w21,	[x15]

    add	x17,	x17,	fp
    mov	w15,	w21
    movz	fp,	#44076
    str	w19,	[x17]

    add	x22,	x22,	fp
    mov	w17,	w21
    movz	fp,	#44076
    str	w17,	[x22]

    add	w22,	w18,	#1
    lsl	w19,	w22,	#2
    mov	x25,	x19
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    movz	fp,	#44076
    str	w15,	[x25]

    add	w25,	w22,	#1
    add	w1,	w25,	#1
    lsl	w23,	w25,	#2
    mov	x28,	x23
    add	x28,	sp,	x28
    add	w5,	w1,	#1
    lsl	w26,	w1,	#2
    mov	x3,	x26
    add	x28,	x28,	fp
    add	x3,	sp,	x3
    add	w9,	w5,	#1
    lsl	w1,	w5,	#2
    movz	fp,	#44076
    mov	x6,	x1
    str	w13,	[x28]

    add	x6,	sp,	x6
    lsl	w4,	w9,	#2
    add	x3,	x3,	fp
    add	w9,	w9,	#1
    movz	fp,	#44076
    str	w10,	[x3]

    add	x6,	x6,	fp
    mov	x10,	x4
    movz	fp,	#44076
    add	x10,	sp,	x10
    str	w8,	[x6]

    mov	w6,	w21
    add	x10,	x10,	fp
    str	w6,	[x10]

    cmp	w9,	#1000
    blt	main_176

main_197:
    lsl	w16,	w9,	#2
    movz	fp,	#44076
    mov	w23,	w21
    add	w9,	w9,	#1
    mov	x22,	x16
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    str	w23,	[x22]

    cmp	w9,	#1005
    blt	main_197

main_202:
    cmp	w11,	#0
    beq	main_412

main_204:
    movz	fp,	#20040
    movz	w13,	#0
    mov	w23,	w11
    mov	w19,	w13
    add	x26,	sp,	fp

main_207:
    bl	getch
    mov	w24,	w0

main_211:
    cmp	w24,	#81
    beq	main_220

main_214:
    cmp	w24,	#85
    bne	main_216

main_220:
    cmp	w24,	#81
    beq	main_222

main_333:
    bl	getch
    movz	w27,	#0
    mov	w12,	w0

main_335:
    cmp	w12,	#48
    blt	main_343

main_339:
    cmp	w12,	#57
    bgt	main_343

main_347:
    movz	w22,	#0

main_348:
    cmp	w12,	#48
    blt	main_361

main_352:
    cmp	w12,	#57
    ble	main_354

main_361:
    movz	w20,	#0
    sub	w24,	w20,	w22
    cmp	w27,	#0
    csel	w28,	w24,	w22,	ne
    bl	getch
    movz	w9,	#0
    mov	w16,	w0
    mov	w25,	w9

main_366:
    cmp	w16,	#48
    blt	main_374

main_370:
    cmp	w16,	#57
    bgt	main_374

main_378:
    movz	w17,	#0

main_379:
    cmp	w16,	#48
    blt	main_392

main_383:
    cmp	w16,	#57
    ble	main_385

main_392:
    movz	w16,	#0
    sub	w20,	w16,	w17
    cmp	w25,	#0
    lsl	w22,	w28,	#2
    lsl	w18,	w19,	#2
    movz	fp,	#24056
    lsl	w16,	w19,	#2
    csel	w9,	w20,	w17,	ne
    mov	x7,	x22
    mov	x12,	x18
    mov	x15,	x16
    lsl	w2,	w9,	#2
    add	x7,	sp,	x7
    add	x12,	sp,	x12
    add	x15,	sp,	x15
    mov	x10,	x2
    add	x10,	sp,	x10
    add	x12,	x12,	#16
    add	x15,	x15,	fp
    movz	fp,	#44076
    str	w9,	[x15]

    add	x7,	x7,	fp
    movz	fp,	#24056
    ldr	w24,	[x7]

    str	w24,	[x12]

    add	w24,	w19,	#1
    str	w19,	[x7]

    add	w25,	w24,	#1
    lsl	w6,	w24,	#2
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    movz	fp,	#44076
    str	w28,	[x5]

    add	x10,	x10,	fp
    lsl	w28,	w24,	#2
    mov	x16,	x28
    ldr	w3,	[x10]

    add	x16,	sp,	x16
    add	x16,	x16,	#16
    str	w3,	[x16]

    str	w24,	[x10]

    b	main_406

main_385:
    lsl	w18,	w17,	#1
    add	w27,	w18,	w17,	lsl #3
    add	w18,	w16,	w27
    sub	w24,	w18,	#48
    bl	getch
    mov	w17,	w24
    mov	w16,	w0
    b	main_379

main_374:
    cmp	w16,	#45
    movz	w18,	#1
    csel	w27,	w18,	w25,	eq
    bl	getch
    mov	w25,	w27
    mov	w16,	w0
    b	main_366

main_354:
    lsl	w20,	w22,	#1
    add	w20,	w20,	w22,	lsl #3
    add	w22,	w12,	w20
    sub	w22,	w22,	#48
    bl	getch
    mov	w12,	w0
    b	main_348

main_343:
    cmp	w12,	#45
    movz	w25,	#1
    csel	w27,	w25,	w27,	eq
    bl	getch
    mov	w12,	w0
    b	main_335

main_222:
    bl	getch
    movz	w20,	#0
    mov	w24,	w0

main_224:
    cmp	w24,	#48
    blt	main_232

main_228:
    cmp	w24,	#57
    bgt	main_232

main_236:
    movz	w28,	#0

main_237:
    cmp	w24,	#48
    blt	main_250

main_241:
    cmp	w24,	#57
    ble	main_243

main_250:
    movz	w25,	#0
    sub	w25,	w25,	w28
    cmp	w20,	#0
    csel	w20,	w25,	w28,	ne
    bl	getch
    movz	w17,	#0
    mov	w7,	w0
    mov	w27,	w17

main_255:
    cmp	w7,	#48
    blt	main_263

main_259:
    cmp	w7,	#57
    bgt	main_263

main_267:
    movz	w4,	#0

main_268:
    cmp	w7,	#48
    blt	main_281

main_272:
    cmp	w7,	#57
    ble	main_274

main_281:
    movz	w13,	#0
    sub	w1,	w13,	w4
    cmp	w27,	#0
    movz	w12,	#1
    movz	w0,	#1
    movz	w14,	#0
    movz	fp,	#48096
    lsl	w16,	w20,	#2
    csel	w13,	w1,	w4,	ne
    mov	x5,	x16
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    str	w0,	[x5]

    movz	w0,	#0
    str	w20,	[x26]


main_292:
    add	w14,	w14,	#1
    movz	fp,	#20036
    lsl	w8,	w14,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	fp
    ldr	w28,	[x7]

    cmp	w28,	w13
    mov	w8,	w21
    movz	fp,	#44076
    lsl	w16,	w28,	#2
    movz	w18,	#1
    mov	x15,	x16
    csel	w0,	w18,	w0,	eq
    add	x15,	sp,	x15
    add	x15,	x15,	fp
    ldr	w17,	[x15]

    cmp	w17,	w8
    beq	main_288

main_306:
    lsl	w8,	w17,	#2
    movz	fp,	#24056
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	fp
    movz	fp,	#48096
    ldr	w9,	[x7]

    lsl	w11,	w9,	#2
    mov	x25,	x11
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    ldr	w15,	[x25]

    cmp	w15,	#0
    bne	main_318

main_314:
    movz	w11,	#1
    add	w12,	w12,	#1
    movz	fp,	#20036
    str	w11,	[x25]

    lsl	w22,	w12,	#2
    mov	x20,	x22
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    str	w9,	[x20]


main_318:
    lsl	w6,	w17,	#2
    mov	w16,	w21
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w17,	[x5]

    cmp	w17,	w16
    bne	main_306

main_288:
    cmp	w14,	w12
    blt	main_292

main_323:
    movz	w24,	#0

main_324:
    cmp	w24,	w12
    ble	main_327

main_332:
    bl	putint
    movz	w0,	#10
    bl	putch
    mov	w25,	w19

main_406:
    sub	w13,	w23,	#1
    cmp	w13,	#0
    bne	main_206

main_412:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#52128
    add	sp, sp, fp
    ret


main_206:
    mov	w19,	w25
    mov	w23,	w13
    b	main_207

main_327:
    lsl	w15,	w24,	#2
    movz	fp,	#20036
    movz	w1,	#0
    add	w24,	w24,	#1
    mov	x14,	x15
    add	x14,	sp,	x14
    add	x14,	x14,	fp
    movz	fp,	#48096
    ldr	w16,	[x14]

    lsl	w18,	w16,	#2
    mov	x18,	x18
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    str	w1,	[x18]

    b	main_324

main_274:
    lsl	w24,	w4,	#1
    add	w18,	w24,	w4,	lsl #3
    add	w22,	w7,	w18
    sub	w24,	w22,	#48
    bl	getch
    mov	w4,	w24
    mov	w7,	w0
    b	main_268

main_263:
    cmp	w7,	#45
    movz	w25,	#1
    csel	w22,	w25,	w27,	eq
    bl	getch
    mov	w27,	w22
    mov	w7,	w0
    b	main_255

main_243:
    lsl	w25,	w28,	#1
    add	w25,	w25,	w28,	lsl #3
    add	w24,	w24,	w25
    sub	w28,	w24,	#48
    bl	getch
    mov	w24,	w0
    b	main_237

main_232:
    cmp	w24,	#45
    movz	w25,	#1
    csel	w20,	w25,	w20,	eq
    bl	getch
    mov	w24,	w0
    b	main_224

main_216:
    bl	getch
    mov	w24,	w0
    b	main_211

main_61:
    lsl	w14,	w9,	#2
    movz	fp,	#44076
    mov	w7,	w21
    add	w27,	w9,	#1
    mov	w5,	w21
    mov	w3,	w21
    mov	w1,	w21
    mov	w15,	w21
    mov	x26,	x14
    add	w2,	w27,	#1
    lsl	w4,	w27,	#2
    add	x26,	sp,	x26
    mov	w27,	w21
    mov	x16,	x4
    add	w6,	w2,	#1
    add	x16,	sp,	x16
    add	x26,	x26,	fp
    movz	fp,	#44076
    add	w8,	w6,	#1
    lsl	w10,	w6,	#2
    str	w7,	[x26]

    add	x16,	x16,	fp
    mov	x23,	x10
    lsl	w7,	w2,	#2
    add	w13,	w8,	#1
    lsl	w14,	w8,	#2
    movz	fp,	#44076
    str	w5,	[x16]

    add	x23,	sp,	x23
    mov	x19,	x7
    lsl	w17,	w13,	#2
    mov	x25,	x14
    add	w16,	w13,	#1
    add	x19,	sp,	x19
    add	x25,	sp,	x25
    mov	w13,	w21
    lsl	w20,	w16,	#2
    add	x19,	x19,	fp
    mov	x4,	x20
    movz	fp,	#44076
    mov	w20,	w21
    add	x4,	sp,	x4
    str	w3,	[x19]

    add	x23,	x23,	fp
    add	w19,	w16,	#1
    movz	fp,	#44076
    str	w1,	[x23]

    add	x25,	x25,	fp
    lsl	w24,	w19,	#2
    mov	w23,	w21
    mov	x1,	x17
    movz	fp,	#44076
    str	w27,	[x25]

    mov	w17,	w21
    add	x1,	sp,	x1
    mov	w25,	w21
    add	x1,	x1,	fp
    movz	fp,	#44076
    str	w25,	[x1]

    add	x4,	x4,	fp
    movz	fp,	#44076
    str	w23,	[x4]

    mov	w4,	w21
    mov	x23,	x24
    add	w24,	w19,	#1
    add	x23,	sp,	x23
    mov	w19,	w21
    lsl	w27,	w24,	#2
    add	x23,	x23,	fp
    add	w28,	w24,	#1
    mov	x10,	x27
    movz	fp,	#44076
    mov	w24,	w21
    str	w21,	[x23]

    add	x10,	sp,	x10
    add	w3,	w28,	#1
    lsl	w2,	w28,	#2
    mov	x14,	x2
    add	x10,	x10,	fp
    mov	w2,	w21
    add	w6,	w3,	#1
    lsl	w5,	w3,	#2
    add	x14,	sp,	x14
    movz	fp,	#44076
    str	w19,	[x10]

    mov	x18,	x5
    add	w9,	w6,	#1
    lsl	w8,	w6,	#2
    add	x14,	x14,	fp
    mov	w10,	w21
    add	x18,	sp,	x18
    mov	w6,	w21
    mov	x22,	x8
    lsl	w12,	w9,	#2
    movz	fp,	#44076
    str	w17,	[x14]

    mov	w8,	w21
    add	x22,	sp,	x22
    mov	x25,	x12
    add	x18,	x18,	fp
    add	w14,	w9,	#1
    add	x25,	sp,	x25
    movz	fp,	#44076
    str	w15,	[x18]

    add	w19,	w14,	#1
    add	x22,	x22,	fp
    lsl	w15,	w14,	#2
    movz	fp,	#44076
    mov	w14,	w21
    mov	x28,	x15
    str	w13,	[x22]

    add	w23,	w19,	#1
    lsl	w18,	w19,	#2
    add	x25,	x25,	fp
    add	x28,	sp,	x28
    mov	x3,	x18
    add	w26,	w23,	#1
    lsl	w22,	w23,	#2
    movz	fp,	#44076
    str	w10,	[x25]

    mov	w18,	w21
    add	x3,	sp,	x3
    add	w27,	w26,	#1
    mov	x7,	x22
    add	x28,	x28,	fp
    lsl	w25,	w26,	#2
    mov	w22,	w21
    add	x7,	sp,	x7
    add	w5,	w27,	#1
    movz	fp,	#44076
    str	w8,	[x28]

    mov	w26,	w21
    mov	x10,	x25
    add	x3,	x3,	fp
    add	w8,	w5,	#1
    lsl	w28,	w27,	#2
    mov	w25,	w21
    add	x10,	sp,	x10
    movz	fp,	#44076
    str	w6,	[x3]

    add	w12,	w8,	#1
    mov	x13,	x28
    add	x7,	x7,	fp
    lsl	w6,	w8,	#2
    lsl	w3,	w5,	#2
    mov	w28,	w21
    add	x13,	sp,	x13
    add	w15,	w12,	#1
    lsl	w9,	w12,	#2
    movz	fp,	#44076
    str	w4,	[x7]

    mov	x19,	x6
    mov	x16,	x3
    mov	w12,	w21
    add	x10,	x10,	fp
    mov	w7,	w21
    add	x19,	sp,	x19
    mov	w3,	w21
    add	x16,	sp,	x16
    movz	fp,	#44076
    str	w2,	[x10]

    add	x13,	x13,	fp
    movz	fp,	#44076
    str	w28,	[x13]

    add	x16,	x16,	fp
    lsl	w13,	w15,	#2
    movz	fp,	#44076
    mov	x27,	x13
    str	w26,	[x16]

    add	x19,	x19,	fp
    add	x27,	sp,	x27
    movz	fp,	#44076
    str	w24,	[x19]

    mov	x24,	x9
    mov	w9,	w21
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    movz	fp,	#44076
    str	w22,	[x24]

    add	x27,	x27,	fp
    movz	fp,	#44076
    str	w20,	[x27]

    add	w20,	w15,	#1
    mov	w15,	w21
    add	w24,	w20,	#1
    lsl	w16,	w20,	#2
    mov	x2,	x16
    mov	w16,	w21
    add	x2,	sp,	x2
    add	w27,	w24,	#1
    lsl	w19,	w24,	#2
    mov	x5,	x19
    add	x2,	x2,	fp
    add	x5,	sp,	x5
    lsl	w23,	w27,	#2
    movz	fp,	#44076
    mov	x8,	x23
    str	w18,	[x2]

    add	x5,	x5,	fp
    add	x8,	sp,	x8
    add	w2,	w27,	#1
    movz	fp,	#44076
    mov	w27,	w21
    str	w16,	[x5]

    add	w6,	w2,	#1
    lsl	w26,	w2,	#2
    add	x8,	x8,	fp
    mov	w5,	w21
    mov	x13,	x26
    movz	fp,	#44076
    add	w10,	w6,	#1
    lsl	w1,	w6,	#2
    str	w14,	[x8]

    add	x13,	sp,	x13
    mov	x16,	x1
    lsl	w4,	w10,	#2
    add	w14,	w10,	#1
    add	x13,	x13,	fp
    mov	w1,	w21
    add	x16,	sp,	x16
    mov	x19,	x4
    add	w17,	w14,	#1
    movz	fp,	#44076
    str	w12,	[x13]

    add	x19,	sp,	x19
    add	x16,	x16,	fp
    mov	w13,	w21
    add	w22,	w17,	#1
    lsl	w10,	w17,	#2
    movz	fp,	#44076
    mov	x26,	x10
    str	w9,	[x16]

    add	x26,	sp,	x26
    add	w24,	w22,	#1
    add	x19,	x19,	fp
    movz	fp,	#44076
    str	w7,	[x19]

    add	w28,	w24,	#1
    lsl	w17,	w24,	#2
    mov	w19,	w21
    lsl	w7,	w14,	#2
    mov	x4,	x17
    lsl	w20,	w28,	#2
    lsl	w14,	w22,	#2
    mov	x23,	x7
    add	x4,	sp,	x4
    mov	x2,	x14
    mov	x7,	x20
    add	x23,	sp,	x23
    add	x2,	sp,	x2
    mov	w20,	w21
    add	x7,	sp,	x7
    add	x23,	x23,	fp
    movz	fp,	#44076
    str	w5,	[x23]

    add	x26,	x26,	fp
    mov	w23,	w21
    movz	fp,	#44076
    str	w3,	[x26]

    add	x2,	x2,	fp
    add	w3,	w28,	#1
    movz	fp,	#44076
    str	w1,	[x2]

    add	x4,	x4,	fp
    lsl	w24,	w3,	#2
    movz	fp,	#44076
    add	w3,	w3,	#1
    mov	x10,	x24
    str	w27,	[x4]

    add	x7,	x7,	fp
    mov	w24,	w21
    add	x10,	sp,	x10
    lsl	w27,	w3,	#2
    movz	fp,	#44076
    str	w25,	[x7]

    mov	x26,	x27
    add	x10,	x10,	fp
    add	x26,	sp,	x26
    movz	fp,	#44076
    str	w23,	[x10]

    add	x26,	x26,	fp
    add	w10,	w3,	#1
    movz	fp,	#44076
    str	w21,	[x26]

    add	w14,	w10,	#1
    lsl	w2,	w10,	#2
    mov	w10,	w21
    mov	x17,	x2
    mov	w2,	w21
    add	x17,	sp,	x17
    add	w18,	w14,	#1
    lsl	w5,	w14,	#2
    mov	x22,	x5
    add	x17,	x17,	fp
    add	x22,	sp,	x22
    lsl	w8,	w18,	#2
    movz	fp,	#44076
    mov	x25,	x8
    str	w19,	[x17]

    add	x22,	x22,	fp
    mov	w8,	w21
    add	x25,	sp,	x25
    mov	w17,	w21
    movz	fp,	#44076
    str	w17,	[x22]

    add	x25,	x25,	fp
    add	w22,	w18,	#1
    movz	fp,	#44076
    str	w15,	[x25]

    add	w26,	w22,	#1
    lsl	w12,	w22,	#2
    mov	x28,	x12
    add	w1,	w26,	#1
    lsl	w15,	w26,	#2
    add	x28,	sp,	x28
    mov	w26,	w21
    mov	x3,	x15
    add	w4,	w1,	#1
    lsl	w18,	w1,	#2
    add	x28,	x28,	fp
    add	x3,	sp,	x3
    mov	x6,	x18
    movz	fp,	#44076
    lsl	w22,	w4,	#2
    add	x6,	sp,	x6
    str	w13,	[x28]

    add	x3,	x3,	fp
    movz	fp,	#44076
    str	w10,	[x3]

    add	x6,	x6,	fp
    mov	x10,	x22
    movz	fp,	#44076
    add	x10,	sp,	x10
    str	w8,	[x6]

    add	w8,	w4,	#1
    mov	w6,	w21
    add	x10,	x10,	fp
    mov	w4,	w21
    movz	fp,	#44076
    lsl	w25,	w8,	#2
    add	w12,	w8,	#1
    str	w6,	[x10]

    mov	x14,	x25
    add	x14,	sp,	x14
    add	w15,	w12,	#1
    lsl	w28,	w12,	#2
    mov	x17,	x28
    add	x14,	x14,	fp
    mov	w28,	w21
    add	w18,	w15,	#1
    lsl	w3,	w15,	#2
    add	x17,	sp,	x17
    movz	fp,	#44076
    str	w4,	[x14]

    mov	x19,	x3
    add	w22,	w18,	#1
    lsl	w6,	w18,	#2
    add	x17,	x17,	fp
    mov	w14,	w21
    add	x19,	sp,	x19
    mov	w18,	w21
    mov	x23,	x6
    lsl	w9,	w22,	#2
    movz	fp,	#44076
    str	w2,	[x17]

    add	x23,	sp,	x23
    mov	x27,	x9
    add	x19,	x19,	fp
    mov	w9,	w21
    add	x27,	sp,	x27
    movz	fp,	#44076
    str	w28,	[x19]

    add	x23,	x23,	fp
    movz	fp,	#44076
    str	w26,	[x23]

    add	x27,	x27,	fp
    movz	fp,	#44076
    str	w24,	[x27]

    add	w27,	w22,	#1
    mov	w22,	w21
    lsl	w13,	w27,	#2
    mov	x2,	x13
    add	x2,	sp,	x2
    add	x2,	x2,	fp
    movz	fp,	#44076
    str	w22,	[x2]

    add	w2,	w27,	#1
    lsl	w16,	w2,	#2
    mov	x5,	x16
    mov	w16,	w21
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    movz	fp,	#44076
    str	w20,	[x5]

    add	w5,	w2,	#1
    lsl	w19,	w5,	#2
    mov	x8,	x19
    add	x8,	sp,	x8
    add	x8,	x8,	fp
    movz	fp,	#44076
    str	w18,	[x8]

    add	w8,	w5,	#1
    mov	w5,	w21
    lsl	w23,	w8,	#2
    mov	x12,	x23
    add	x12,	sp,	x12
    add	x12,	x12,	fp
    movz	fp,	#44076
    str	w16,	[x12]

    add	w12,	w8,	#1
    add	w17,	w12,	#1
    lsl	w26,	w12,	#2
    mov	w12,	w21
    mov	x16,	x26
    add	x16,	sp,	x16
    add	w20,	w17,	#1
    lsl	w1,	w17,	#2
    mov	x19,	x1
    add	x16,	x16,	fp
    add	x19,	sp,	x19
    lsl	w4,	w20,	#2
    add	w17,	w20,	#1
    movz	fp,	#44076
    mov	x23,	x4
    str	w14,	[x16]

    add	x23,	sp,	x23
    add	w28,	w17,	#1
    lsl	w7,	w17,	#2
    add	x19,	x19,	fp
    mov	x26,	x7
    movz	fp,	#44076
    mov	w7,	w21
    lsl	w10,	w28,	#2
    add	x26,	sp,	x26
    str	w12,	[x19]

    add	x23,	x23,	fp
    mov	x1,	x10
    movz	fp,	#44076
    add	x1,	sp,	x1
    str	w9,	[x23]

    add	x26,	x26,	fp
    add	w9,	w28,	#1
    movz	fp,	#44076
    str	w7,	[x26]

    add	x1,	x1,	fp
    str	w5,	[x1]

    b	main_58

main_47:
    lsl	w24,	w25,	#1
    add	w21,	w24,	w25,	lsl #3
    add	w22,	w2,	w21
    sub	w25,	w22,	#48
    bl	getch
    mov	w2,	w0
    b	main_41

main_36:
    cmp	w2,	#45
    movz	w20,	#1
    csel	w23,	w20,	w23,	eq
    bl	getch
    mov	w2,	w0
    b	main_28

main_22:
    bl	getch
    mov	w27,	w0
    b	main_17

main_14:
    bl	getch
    mov	w27,	w0
    b	main_7

