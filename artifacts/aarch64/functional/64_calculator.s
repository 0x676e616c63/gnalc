.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
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
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#40000
    movz	w1,	#0
    movz	fp,	#40016
    add	x0,	sp,	fp
    bl	memset
    movz	w1,	#0
    movz	w2,	#40000
    add	x0,	sp,	#16
    bl	memset
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    add	x22,	sp,	fp
    bl	getch
    movz	w27,	#0
    mov	w19,	w0

main_7:
    cmp	w19,	#13
    beq	main_19

main_11:
    cmp	w19,	#10
    beq	main_19

main_13:
    lsl	w28,	w27,	#2
    add	w27,	w27,	#1
    add	x26,	x22,	x28
    str	w19,	[x26]

    bl	getch
    mov	w19,	w0
    b	main_7

main_19:
    movz	w19,	#0
    cmp	w19,	w27
    blt	main_21

main_289:
    movz	w23,	#1
    movz	w26,	#0
    b	main_294

main_21:
    movz	w23,	#1
    movz	w6,	#0
    movz	w26,	#0

main_23:
    lsl	w7,	w6,	#2
    movz	fp,	#54480
    mov	x5,	x7
    movk	fp,	#1,	lsl #16
    add	x5,	sp,	x5
    add	x5,	x5,	fp
    ldr	w13,	[x5]

    cmp	w13,	#57
    cset	w17,	le
    cmp	w13,	#48
    movz	w3,	#0
    csel	w19,	w17,	w3,	ge
    cmp	w19,	#1
    bne	main_37

main_34:
    lsl	w22,	w23,	#2
    movz	fp,	#14480
    add	w23,	w23,	#1
    mov	x21,	x22
    movk	fp,	#1,	lsl #16
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    str	w13,	[x21]

    b	main_284

main_37:
    cmp	w13,	#40
    bne	main_43

main_39:
    add	w26,	w26,	#1
    movz	fp,	#40016
    movz	w3,	#40
    lsl	w1,	w26,	#2
    mov	x20,	x1
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    str	w3,	[x20]


main_43:
    cmp	w13,	#94
    bne	main_50

main_46:
    add	w26,	w26,	#1
    movz	fp,	#40016
    lsl	w5,	w26,	#2
    mov	x25,	x5
    movz	w5,	#94
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    str	w5,	[x25]


main_50:
    cmp	w13,	#41
    bne	main_70

main_53:
    sub	w8,	w26,	#1
    lsl	w11,	w26,	#2
    movz	fp,	#40016
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	fp
    ldr	w7,	[x10]


main_57:
    cmp	w7,	#40
    beq	main_72

main_62:
    lsl	w10,	w23,	#2
    movz	fp,	#14480
    movz	w12,	#32
    add	w11,	w23,	#1
    sub	w16,	w8,	#1
    lsl	w24,	w8,	#2
    mov	x21,	x10
    movk	fp,	#1,	lsl #16
    add	w23,	w23,	#2
    lsl	w14,	w11,	#2
    mov	w8,	w16
    mov	x22,	x24
    add	x21,	sp,	x21
    add	x22,	sp,	x22
    add	x21,	x21,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w12,	[x21]

    mov	x12,	x14
    add	x12,	sp,	x12
    add	x12,	x12,	fp
    movz	fp,	#40016
    str	w7,	[x12]

    add	x22,	x22,	fp
    ldr	w7,	[x22]

    b	main_57

main_70:
    mov	w8,	w26

main_72:
    cmp	w13,	#43
    bne	main_117

main_78:
    lsl	w0,	w8,	#2
    movz	fp,	#40016
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    ldr	w22,	[x28]

    cmp	w22,	#43
    beq	main_100

main_84:
    cmp	w22,	#45
    beq	main_100

main_86:
    cmp	w22,	#42
    beq	main_100

main_88:
    cmp	w22,	#47
    beq	main_100

main_90:
    cmp	w22,	#37
    beq	main_100

main_92:
    cmp	w22,	#94
    bne	main_111

main_100:
    sub	w8,	w8,	#1
    lsl	w12,	w23,	#2
    movz	fp,	#14480
    movz	w19,	#32
    add	w14,	w23,	#1
    mov	x4,	x12
    movk	fp,	#1,	lsl #16
    add	w23,	w23,	#2
    add	x4,	sp,	x4
    lsl	w16,	w14,	#2
    mov	x15,	x16
    add	x4,	x4,	fp
    add	x15,	sp,	x15
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w19,	[x4]

    add	x15,	x15,	fp
    str	w22,	[x15]

    cmp	w8,	#0
    movz	w21,	#1
    movz	w16,	#0
    csel	w19,	w16,	w21,	eq
    cmp	w19,	#0
    bne	main_78

main_111:
    add	w8,	w8,	#1
    movz	fp,	#40016
    movz	w21,	#43
    lsl	w24,	w8,	#2
    mov	x17,	x24
    add	x17,	sp,	x17
    add	x17,	x17,	fp
    str	w21,	[x17]


main_117:
    cmp	w13,	#45
    bne	main_162

main_123:
    lsl	w28,	w8,	#2
    movz	fp,	#40016
    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    ldr	w1,	[x26]

    cmp	w1,	#43
    beq	main_145

main_129:
    cmp	w1,	#45
    beq	main_145

main_131:
    cmp	w1,	#42
    beq	main_145

main_133:
    cmp	w1,	#47
    beq	main_145

main_135:
    cmp	w1,	#37
    beq	main_145

main_137:
    cmp	w1,	#94
    bne	main_156

main_145:
    sub	w8,	w8,	#1
    lsl	w11,	w23,	#2
    movz	fp,	#14480
    movz	w0,	#32
    add	w12,	w23,	#1
    mov	x5,	x11
    movk	fp,	#1,	lsl #16
    add	w23,	w23,	#2
    add	x5,	sp,	x5
    lsl	w15,	w12,	#2
    mov	x14,	x15
    add	x5,	x5,	fp
    add	x14,	sp,	x14
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w0,	[x5]

    add	x14,	x14,	fp
    str	w1,	[x14]

    cmp	w8,	#0
    movz	w2,	#1
    movz	w25,	#0
    csel	w18,	w25,	w2,	eq
    cmp	w18,	#0
    bne	main_123

main_156:
    add	w8,	w8,	#1
    movz	fp,	#40016
    movz	w2,	#45
    lsl	w22,	w8,	#2
    mov	x18,	x22
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    str	w2,	[x18]


main_162:
    cmp	w13,	#42
    bne	main_201

main_168:
    lsl	w26,	w8,	#2
    movz	fp,	#40016
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	fp
    ldr	w25,	[x25]

    cmp	w25,	#42
    beq	main_184

main_174:
    cmp	w25,	#47
    beq	main_184

main_176:
    cmp	w25,	#37
    beq	main_184

main_178:
    cmp	w25,	#94
    bne	main_195

main_184:
    sub	w8,	w8,	#1
    lsl	w7,	w23,	#2
    movz	fp,	#14480
    movz	w10,	#32
    add	w9,	w23,	#1
    mov	x2,	x7
    movk	fp,	#1,	lsl #16
    add	w23,	w23,	#2
    add	x2,	sp,	x2
    lsl	w11,	w9,	#2
    add	x2,	x2,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w10,	[x2]

    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	fp
    str	w25,	[x10]

    cmp	w8,	#0
    movz	w14,	#1
    movz	w5,	#0
    csel	w15,	w5,	w14,	eq
    cmp	w15,	#0
    bne	main_168

main_195:
    add	w8,	w8,	#1
    movz	fp,	#40016
    movz	w20,	#42
    lsl	w19,	w8,	#2
    mov	x15,	x19
    add	x15,	sp,	x15
    add	x15,	x15,	fp
    str	w20,	[x15]


main_201:
    cmp	w13,	#47
    bne	main_240

main_207:
    lsl	w22,	w8,	#2
    movz	fp,	#40016
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w16,	[x21]

    cmp	w16,	#42
    beq	main_223

main_213:
    cmp	w16,	#47
    beq	main_223

main_215:
    cmp	w16,	#37
    beq	main_223

main_217:
    cmp	w16,	#94
    bne	main_234

main_223:
    sub	w8,	w8,	#1
    lsl	w3,	w23,	#2
    movz	fp,	#14480
    movz	w28,	#32
    add	w4,	w23,	#1
    mov	x0,	x3
    movk	fp,	#1,	lsl #16
    add	w23,	w23,	#2
    add	x0,	sp,	x0
    lsl	w7,	w4,	#2
    mov	x5,	x7
    add	x0,	x0,	fp
    add	x5,	sp,	x5
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w28,	[x0]

    add	x5,	x5,	fp
    str	w16,	[x5]

    cmp	w8,	#0
    movz	w16,	#1
    movz	w24,	#0
    csel	w11,	w24,	w16,	eq
    cmp	w11,	#0
    bne	main_207

main_234:
    add	w8,	w8,	#1
    movz	fp,	#40016
    movz	w1,	#47
    lsl	w16,	w8,	#2
    mov	x14,	x16
    add	x14,	sp,	x14
    add	x14,	x14,	fp
    str	w1,	[x14]


main_240:
    cmp	w13,	#37
    bne	main_279

main_246:
    lsl	w5,	w8,	#2
    movz	fp,	#40016
    mov	x4,	x5
    add	x4,	sp,	x4
    add	x4,	x4,	fp
    ldr	w1,	[x4]

    cmp	w1,	#42
    beq	main_262

main_252:
    cmp	w1,	#47
    beq	main_262

main_254:
    cmp	w1,	#37
    beq	main_262

main_256:
    cmp	w1,	#94
    bne	main_273

main_262:
    sub	w8,	w8,	#1
    lsl	w15,	w23,	#2
    movz	fp,	#14480
    movz	w9,	#32
    add	w16,	w23,	#1
    mov	x28,	x15
    movk	fp,	#1,	lsl #16
    add	w23,	w23,	#2
    add	x28,	sp,	x28
    lsl	w18,	w16,	#2
    mov	x17,	x18
    add	x28,	x28,	fp
    add	x17,	sp,	x17
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w9,	[x28]

    add	x17,	x17,	fp
    str	w1,	[x17]

    cmp	w8,	#0
    movz	w26,	#1
    movz	w4,	#0
    csel	w21,	w4,	w26,	eq
    cmp	w21,	#0
    bne	main_246

main_273:
    add	w8,	w8,	#1
    movz	fp,	#40016
    movz	w11,	#37
    lsl	w26,	w8,	#2
    mov	x12,	x26
    add	x12,	sp,	x12
    add	x12,	x12,	fp
    str	w11,	[x12]


main_279:
    lsl	w0,	w23,	#2
    movz	fp,	#14480
    movz	w22,	#32
    mov	w26,	w8
    add	w23,	w23,	#1
    mov	x13,	x0
    movk	fp,	#1,	lsl #16
    add	x13,	sp,	x13
    add	x13,	x13,	fp
    str	w22,	[x13]


main_284:
    add	w6,	w6,	#1
    cmp	w6,	w27
    blt	main_23

main_294:
    cmp	w26,	#0
    ble	main_306

main_298:
    sub	w28,	w26,	#1
    lsl	w1,	w26,	#2
    movz	fp,	#40016
    lsl	w4,	w23,	#2
    movz	w19,	#32
    add	w5,	w23,	#1
    mov	w26,	w28
    mov	x0,	x1
    mov	x25,	x4
    add	w23,	w23,	#2
    lsl	w7,	w5,	#2
    add	x0,	sp,	x0
    add	x25,	sp,	x25
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x0,	x0,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    ldr	w18,	[x0]

    add	x25,	x25,	fp
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    str	w19,	[x25]

    add	x6,	x6,	fp
    str	w18,	[x6]

    b	main_294

main_306:
    lsl	w9,	w23,	#2
    movz	fp,	#14480
    movz	w19,	#64
    mov	x7,	x9
    movk	fp,	#1,	lsl #16
    add	x7,	sp,	x7
    add	x7,	x7,	fp
    movz	fp,	#14484
    movk	fp,	#1,	lsl #16
    str	w19,	[x7]

    add	x10,	sp,	fp
    ldr	w16,	[x10]

    cmp	w16,	#64
    beq	main_408

main_311:
    movz	w7,	#1
    movz	w1,	#0

main_313:
    cmp	w16,	#43
    beq	main_334

main_318:
    cmp	w16,	#45
    beq	main_334

main_320:
    cmp	w16,	#42
    beq	main_334

main_322:
    cmp	w16,	#47
    beq	main_334

main_324:
    cmp	w16,	#37
    beq	main_334

main_326:
    cmp	w16,	#94
    beq	main_334

main_374:
    cmp	w16,	#32
    beq	main_399

main_376:
    sub	w3,	w16,	#48
    add	w1,	w1,	#1
    movz	w17,	#1
    lsl	w26,	w1,	#2
    mov	x11,	x26
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    str	w3,	[x11]


main_380:
    add	w22,	w17,	w7
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    lsl	w24,	w22,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w25,	[x23]

    cmp	w25,	#32
    beq	main_392

main_386:
    sub	w3,	w25,	#48
    ldr	w15,	[x11]

    add	w17,	w17,	#1
    lsl	w14,	w15,	#1
    add	w0,	w14,	w15,	lsl #3
    add	w2,	w0,	w3
    str	w2,	[x11]

    b	main_380

main_392:
    add	w6,	w7,	w17
    sub	w7,	w6,	#1
    b	main_399

main_334:
    sub	w6,	w1,	#1
    lsl	w9,	w1,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    lsl	w27,	w6,	#2
    mov	x22,	x27
    add	x8,	x8,	#16
    add	x22,	sp,	x22
    ldr	w15,	[x8]

    add	x22,	x22,	#16
    ldr	w17,	[x22]

    add	w18,	w17,	w15
    cmp	w16,	#43
    sub	w3,	w17,	w15
    movz	w26,	#0
    csel	w21,	w18,	w26,	eq
    cmp	w16,	#45
    mul	w8,	w17,	w15
    csel	w24,	w3,	w21,	eq
    cmp	w16,	#42
    csel	w11,	w8,	w24,	eq
    cmp	w16,	#47
    bne	main_353

main_350:
    sdiv	w11,	w17,	w15

main_353:
    cmp	w16,	#37
    bne	main_359

main_356:
    sdiv	w0,	w17,	w15
    msub	w11,	w0,	w15,	w17


main_359:
    cmp	w16,	#94
    bne	main_372

main_362:
    movz	w11,	#1

main_363:
    cmp	w15,	#0
    beq	main_372

main_367:
    mul	w11,	w11,	w17
    sub	w15,	w15,	#1
    b	main_363

main_372:
    str	w11,	[x22]

    mov	w1,	w6

main_399:
    add	w7,	w7,	#1
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    lsl	w11,	w7,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	fp
    ldr	w16,	[x10]

    cmp	w16,	#64
    bne	main_313

main_408:
    add	x0,	sp,	#20
    ldr	w0,	[x0]

    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#28944
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


