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
    movz	fp,	#28944
    movk	fp,	#2,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#40000
    movz	w1,	#0
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#40000
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#40000
    movz	w1,	#0
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#40000
    movz	w1,	#0
    movz	fp,	#40016
    add	x0,	sp,	fp
    bl	memset
    add	x22,	sp,	#16
    bl	getch
    movz	w20,	#0
    mov	w26,	w0

main_7:
    cmp	w26,	#13
    beq	main_19

main_11:
    cmp	w26,	#10
    bne	main_13

main_19:
    movz	w18,	#0
    cmp	w18,	w20
    bge	main_289

main_21:
    movz	w10,	#1
    movz	w6,	#0
    movz	w27,	#0

main_23:
    lsl	w2,	w6,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    ldr	w7,	[x1]

    cmp	w7,	#57
    cset	w14,	le
    cmp	w7,	#48
    movz	w2,	#0
    csel	w16,	w14,	w2,	ge
    cmp	w16,	#1
    beq	main_34

main_37:
    cmp	w7,	#40
    bne	main_43

main_39:
    add	w27,	w27,	#1
    movz	fp,	#54480
    movz	w1,	#40
    movk	fp,	#1,	lsl #16
    lsl	w22,	w27,	#2
    mov	x14,	x22
    add	x14,	sp,	x14
    add	x14,	x14,	fp
    str	w1,	[x14]


main_43:
    cmp	w7,	#94
    bne	main_50

main_46:
    add	w27,	w27,	#1
    movz	fp,	#54480
    movz	w3,	#94
    movk	fp,	#1,	lsl #16
    lsl	w26,	w27,	#2
    mov	x18,	x26
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    str	w3,	[x18]


main_50:
    cmp	w7,	#41
    bne	main_72

main_53:
    sub	w17,	w27,	#1
    lsl	w2,	w27,	#2
    movz	fp,	#54480
    mov	x1,	x2
    movk	fp,	#1,	lsl #16
    add	x1,	sp,	x1
    add	x1,	x1,	fp
    ldr	w15,	[x1]


main_57:
    cmp	w15,	#40
    bne	main_62

main_71:
    mov	w27,	w17

main_72:
    cmp	w7,	#43
    bne	main_117

main_78:
    lsl	w9,	w27,	#2
    movz	fp,	#54480
    mov	x8,	x9
    movk	fp,	#1,	lsl #16
    add	x8,	sp,	x8
    add	x8,	x8,	fp
    ldr	w19,	[x8]

    cmp	w19,	#43
    beq	main_100

main_84:
    cmp	w19,	#45
    beq	main_100

main_86:
    cmp	w19,	#42
    beq	main_100

main_88:
    cmp	w19,	#47
    beq	main_100

main_90:
    cmp	w19,	#37
    beq	main_100

main_92:
    cmp	w19,	#94
    bne	main_111

main_100:
    sub	w27,	w27,	#1
    lsl	w21,	w10,	#2
    movz	fp,	#14480
    movz	w13,	#32
    add	w22,	w10,	#1
    mov	x14,	x21
    movk	fp,	#1,	lsl #16
    add	w10,	w10,	#2
    add	x14,	sp,	x14
    lsl	w24,	w22,	#2
    mov	x23,	x24
    add	x14,	x14,	fp
    add	x23,	sp,	x23
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w13,	[x14]

    add	x23,	x23,	fp
    str	w19,	[x23]

    cmp	w27,	#0
    movz	w15,	#1
    movz	w9,	#0
    csel	w28,	w9,	w15,	eq
    cmp	w28,	#0
    bne	main_78

main_111:
    add	w27,	w27,	#1
    movz	fp,	#54480
    movz	w15,	#43
    movk	fp,	#1,	lsl #16
    lsl	w3,	w27,	#2
    mov	x25,	x3
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    str	w15,	[x25]


main_117:
    cmp	w7,	#45
    bne	main_162

main_123:
    lsl	w8,	w27,	#2
    movz	fp,	#54480
    mov	x5,	x8
    movk	fp,	#1,	lsl #16
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    ldr	w18,	[x5]

    cmp	w18,	#43
    beq	main_145

main_129:
    cmp	w18,	#45
    beq	main_145

main_131:
    cmp	w18,	#42
    beq	main_145

main_133:
    cmp	w18,	#47
    beq	main_145

main_135:
    cmp	w18,	#37
    beq	main_145

main_137:
    cmp	w18,	#94
    bne	main_156

main_145:
    sub	w27,	w27,	#1
    lsl	w19,	w10,	#2
    movz	fp,	#14480
    movz	w22,	#32
    add	w21,	w10,	#1
    mov	x13,	x19
    movk	fp,	#1,	lsl #16
    add	w10,	w10,	#2
    add	x13,	sp,	x13
    lsl	w23,	w21,	#2
    add	x13,	x13,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w22,	[x13]

    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    str	w18,	[x22]

    cmp	w27,	#0
    movz	w24,	#1
    movz	w18,	#0
    csel	w26,	w18,	w24,	eq
    cmp	w26,	#0
    bne	main_123

main_156:
    add	w27,	w27,	#1
    movz	fp,	#54480
    movz	w24,	#45
    movk	fp,	#1,	lsl #16
    lsl	w2,	w27,	#2
    mov	x25,	x2
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    str	w24,	[x25]


main_162:
    cmp	w7,	#42
    bne	main_201

main_168:
    lsl	w5,	w27,	#2
    movz	fp,	#54480
    mov	x4,	x5
    movk	fp,	#1,	lsl #16
    add	x4,	sp,	x4
    add	x4,	x4,	fp
    ldr	w9,	[x4]

    cmp	w9,	#42
    beq	main_184

main_174:
    cmp	w9,	#47
    beq	main_184

main_176:
    cmp	w9,	#37
    beq	main_184

main_178:
    cmp	w9,	#94
    bne	main_195

main_184:
    sub	w27,	w27,	#1
    lsl	w16,	w10,	#2
    movz	fp,	#14480
    movz	w2,	#32
    add	w17,	w10,	#1
    mov	x12,	x16
    movk	fp,	#1,	lsl #16
    add	w10,	w10,	#2
    add	x12,	sp,	x12
    lsl	w19,	w17,	#2
    mov	x18,	x19
    add	x12,	x12,	fp
    add	x18,	sp,	x18
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w2,	[x12]

    add	x18,	x18,	fp
    str	w9,	[x18]

    cmp	w27,	#0
    movz	w4,	#1
    movz	w28,	#0
    csel	w23,	w28,	w4,	eq
    cmp	w23,	#0
    bne	main_168

main_195:
    add	w27,	w27,	#1
    movz	fp,	#54480
    movz	w4,	#42
    movk	fp,	#1,	lsl #16
    lsl	w28,	w27,	#2
    mov	x23,	x28
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    str	w4,	[x23]


main_201:
    cmp	w7,	#47
    bne	main_240

main_207:
    lsl	w2,	w27,	#2
    movz	fp,	#54480
    mov	x1,	x2
    movk	fp,	#1,	lsl #16
    add	x1,	sp,	x1
    add	x1,	x1,	fp
    ldr	w17,	[x1]

    cmp	w17,	#42
    beq	main_223

main_213:
    cmp	w17,	#47
    beq	main_223

main_215:
    cmp	w17,	#37
    beq	main_223

main_217:
    cmp	w17,	#94
    bne	main_234

main_223:
    sub	w27,	w27,	#1
    lsl	w13,	w10,	#2
    movz	fp,	#14480
    movz	w21,	#32
    add	w14,	w10,	#1
    mov	x8,	x13
    movk	fp,	#1,	lsl #16
    add	w10,	w10,	#2
    add	x8,	sp,	x8
    lsl	w16,	w14,	#2
    mov	x15,	x16
    add	x8,	x8,	fp
    add	x15,	sp,	x15
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w21,	[x8]

    add	x15,	x15,	fp
    str	w17,	[x15]

    cmp	w27,	#0
    movz	w9,	#1
    movz	w17,	#0
    csel	w19,	w17,	w9,	eq
    cmp	w19,	#0
    bne	main_207

main_234:
    add	w27,	w27,	#1
    movz	fp,	#54480
    movz	w23,	#47
    movk	fp,	#1,	lsl #16
    lsl	w24,	w27,	#2
    mov	x19,	x24
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    str	w23,	[x19]


main_240:
    cmp	w7,	#37
    bne	main_279

main_246:
    lsl	w15,	w27,	#2
    movz	fp,	#54480
    mov	x14,	x15
    movk	fp,	#1,	lsl #16
    add	x14,	sp,	x14
    add	x14,	x14,	fp
    ldr	w4,	[x14]

    cmp	w4,	#42
    beq	main_262

main_252:
    cmp	w4,	#47
    beq	main_262

main_254:
    cmp	w4,	#37
    beq	main_262

main_256:
    cmp	w4,	#94
    bne	main_273

main_262:
    sub	w27,	w27,	#1
    lsl	w24,	w10,	#2
    movz	fp,	#14480
    movz	w1,	#32
    add	w25,	w10,	#1
    mov	x8,	x24
    movk	fp,	#1,	lsl #16
    add	w10,	w10,	#2
    add	x8,	sp,	x8
    lsl	w28,	w25,	#2
    mov	x26,	x28
    add	x8,	x8,	fp
    add	x26,	sp,	x26
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w1,	[x8]

    add	x26,	x26,	fp
    str	w4,	[x26]

    cmp	w27,	#0
    movz	w18,	#1
    movz	w26,	#0
    csel	w2,	w26,	w18,	eq
    cmp	w2,	#0
    bne	main_246

main_273:
    add	w27,	w27,	#1
    movz	fp,	#54480
    movz	w3,	#37
    movk	fp,	#1,	lsl #16
    lsl	w7,	w27,	#2
    mov	x19,	x7
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    str	w3,	[x19]


main_279:
    lsl	w9,	w10,	#2
    movz	fp,	#14480
    movz	w5,	#32
    add	w10,	w10,	#1
    mov	x22,	x9
    movk	fp,	#1,	lsl #16
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    str	w5,	[x22]

    b	main_284

main_62:
    lsl	w26,	w10,	#2
    movz	fp,	#14480
    movz	w21,	#32
    add	w27,	w10,	#1
    sub	w19,	w17,	#1
    lsl	w5,	w17,	#2
    mov	x14,	x26
    movk	fp,	#1,	lsl #16
    add	w10,	w10,	#2
    lsl	w0,	w27,	#2
    mov	w17,	w19
    mov	x4,	x5
    add	x14,	sp,	x14
    mov	x28,	x0
    add	x4,	sp,	x4
    add	x28,	sp,	x28
    add	x14,	x14,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w21,	[x14]

    add	x28,	x28,	fp
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    str	w15,	[x28]

    add	x4,	x4,	fp
    ldr	w15,	[x4]

    b	main_57

main_34:
    lsl	w11,	w10,	#2
    movz	fp,	#14480
    add	w10,	w10,	#1
    mov	x9,	x11
    movk	fp,	#1,	lsl #16
    add	x9,	sp,	x9
    add	x9,	x9,	fp
    str	w7,	[x9]


main_284:
    add	w6,	w6,	#1
    cmp	w6,	w20
    blt	main_23
    b	main_294

main_289:
    movz	w10,	#1
    movz	w27,	#0

main_294:
    cmp	w27,	#0
    bgt	main_298

main_306:
    lsl	w24,	w10,	#2
    movz	fp,	#14480
    movz	w14,	#64
    mov	x22,	x24
    movk	fp,	#1,	lsl #16
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    movz	fp,	#14484
    movk	fp,	#1,	lsl #16
    str	w14,	[x22]

    add	x25,	sp,	fp
    ldr	w2,	[x25]

    cmp	w2,	#64
    beq	main_408

main_311:
    movz	w27,	#1
    movz	w11,	#0

main_313:
    cmp	w2,	#43
    beq	main_334

main_318:
    cmp	w2,	#45
    beq	main_334

main_320:
    cmp	w2,	#42
    beq	main_334

main_322:
    cmp	w2,	#47
    beq	main_334

main_324:
    cmp	w2,	#37
    beq	main_334

main_326:
    cmp	w2,	#94
    bne	main_374

main_334:
    sub	w1,	w11,	#1
    lsl	w4,	w11,	#2
    movz	fp,	#40016
    mov	x3,	x4
    add	x3,	sp,	x3
    lsl	w20,	w1,	#2
    mov	x23,	x20
    add	x3,	x3,	fp
    add	x23,	sp,	x23
    movz	fp,	#40016
    ldr	w12,	[x3]

    add	x23,	x23,	fp
    ldr	w22,	[x23]

    add	w9,	w22,	w12
    cmp	w2,	#43
    sub	w25,	w22,	w12
    movz	w17,	#0
    csel	w11,	w9,	w17,	eq
    cmp	w2,	#45
    mul	w0,	w22,	w12
    csel	w16,	w25,	w11,	eq
    cmp	w2,	#42
    csel	w8,	w0,	w16,	eq
    cmp	w2,	#47
    bne	main_353

main_350:
    sdiv	w8,	w22,	w12

main_353:
    cmp	w2,	#37
    bne	main_359

main_356:
    sdiv	w20,	w22,	w12
    msub	w8,	w20,	w12,	w22


main_359:
    cmp	w2,	#94
    bne	main_372

main_362:
    movz	w8,	#1

main_363:
    cmp	w12,	#0
    beq	main_372

main_367:
    mul	w8,	w8,	w22
    sub	w12,	w12,	#1
    b	main_363

main_372:
    str	w8,	[x23]

    b	main_399

main_374:
    cmp	w2,	#32
    beq	main_396

main_376:
    sub	w14,	w2,	#48
    add	w11,	w11,	#1
    movz	fp,	#40016
    movz	w4,	#1
    lsl	w7,	w11,	#2
    mov	x25,	x7
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    str	w14,	[x25]


main_380:
    add	w3,	w4,	w27
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    lsl	w6,	w3,	#2
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    ldr	w7,	[x5]

    cmp	w7,	#32
    bne	main_386

main_392:
    add	w10,	w27,	w4
    sub	w27,	w10,	#1

main_396:
    mov	w1,	w11

main_399:
    add	w27,	w27,	#1
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    lsl	w18,	w27,	#2
    mov	x17,	x18
    add	x17,	sp,	x17
    add	x17,	x17,	fp
    ldr	w2,	[x17]

    cmp	w2,	#64
    beq	main_408

main_312:
    mov	w11,	w1
    b	main_313

main_386:
    sub	w23,	w7,	#48
    ldr	w5,	[x25]

    add	w4,	w4,	#1
    lsl	w14,	w5,	#1
    add	w19,	w14,	w5,	lsl #3
    add	w20,	w19,	w23
    str	w20,	[x25]

    b	main_380

main_408:
    movz	fp,	#40020
    add	x27,	sp,	fp
    ldr	w0,	[x27]

    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#28944
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


main_298:
    sub	w0,	w27,	#1
    lsl	w3,	w27,	#2
    movz	fp,	#54480
    lsl	w6,	w10,	#2
    add	w7,	w10,	#1
    movz	w27,	#32
    mov	x2,	x3
    movk	fp,	#1,	lsl #16
    mov	x1,	x6
    add	w10,	w10,	#2
    lsl	w9,	w7,	#2
    add	x2,	sp,	x2
    add	x1,	sp,	x1
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x2,	x2,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w13,	[x2]

    add	x1,	x1,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w27,	[x1]

    add	x8,	x8,	fp
    mov	w27,	w0
    str	w13,	[x8]

    b	main_294

main_13:
    lsl	w23,	w20,	#2
    add	w20,	w20,	#1
    add	x21,	x22,	x23
    str	w26,	[x21]

    bl	getch
    mov	w26,	w0
    b	main_7

