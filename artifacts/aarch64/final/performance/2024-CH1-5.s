.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global a
.align	2
a:
    .zero	120000040


.text

.globl radixSort
radixSort:
radixSort_4:
    sub	sp, sp, #656
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w23,	w2
    mov	w25,	w3
    str	x1,	[sp, #536]

    mov	w28,	w0
    movz	w2,	#64
    movz	w1,	#0
    add	x0,	sp,	#288
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    add	x0,	sp,	#352
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    add	x0,	sp,	#416
    bl	memset
    movz	w19,	#65535
    movk	w19,	#65535,	lsl #16
    mov	w27,	w19
    cmp	w28,	w27
    beq	radixSort_360

radixSort_15:
    add	w19,	w23,	#1
    cmp	w19,	w25
    bge	radixSort_360

radixSort_18:
    cmp	w23,	w25
    bge	radixSort_52

radixSort_20:
    mov	w6,	w23

radixSort_22:
    lsl	w17,	w6,	#2
    ldr	x10,	[sp, #536]

    movz	w7,	#0
    add	x16,	x10,	x17
    ldr	w0,	[x16]

    mov	w10,	w0

radixSort_26:
    cmp	w7,	w28
    bge	radixSort_33

radixSort_30:
    asr	w16,	w10,	#31
    add	w7,	w7,	#1
    lsr	w17,	w16,	#28
    add	w11,	w10,	w17
    asr	w10,	w11,	#4
    b	radixSort_26

radixSort_33:
    asr	w13,	w10,	#31
    lsr	w14,	w13,	#28
    movz	w13,	#0
    add	w15,	w10,	w14
    asr	w16,	w15,	#4
    lsl	w17,	w16,	#4
    sub	w10,	w10,	w17
    lsl	w12,	w10,	#2
    mov	x21,	x12
    add	x21,	sp,	x21
    add	x21,	x21,	#416

radixSort_36:
    cmp	w13,	w28
    bge	radixSort_43

radixSort_40:
    asr	w16,	w0,	#31
    add	w13,	w13,	#1
    lsr	w17,	w16,	#28
    add	w4,	w0,	w17
    asr	w0,	w4,	#4
    b	radixSort_36

radixSort_43:
    asr	w2,	w0,	#31
    add	w6,	w6,	#1
    lsr	w3,	w2,	#28
    add	w4,	w0,	w3
    asr	w11,	w4,	#4
    lsl	w12,	w11,	#4
    sub	w3,	w0,	w12
    lsl	w5,	w3,	#2
    mov	x4,	x5
    add	x4,	sp,	x4
    add	x4,	x4,	#416
    ldr	w8,	[x4]

    add	w9,	w8,	#1
    str	w9,	[x21]

    cmp	w6,	w25
    blt	radixSort_22

radixSort_52:
    add	x3,	sp,	#288
    add	x26,	sp,	#352
    add	x14,	sp,	#416
    movz	w12,	#1
    str	w23,	[x3]

    ldr	w0,	[x14]

    add	w1,	w0,	w23
    str	w1,	[x26]


radixSort_58:
    cmp	w12,	#16
    bge	radixSort_71

radixSort_61:
    lsl	w0,	w12,	#2
    sub	w13,	w12,	#1
    lsl	w22,	w12,	#2
    lsl	w15,	w12,	#2
    mov	x6,	x0
    mov	x21,	x22
    lsl	w17,	w13,	#2
    add	w12,	w12,	#1
    mov	x11,	x15
    add	x6,	sp,	x6
    add	x21,	sp,	x21
    mov	x16,	x17
    add	x11,	sp,	x11
    add	x16,	sp,	x16
    add	x6,	x6,	#288
    add	x21,	x21,	#352
    add	x11,	x11,	#416
    add	x16,	x16,	#352
    ldr	w19,	[x16]

    str	w19,	[x6]

    ldr	w16,	[x11]

    add	w6,	w16,	w19
    str	w6,	[x21]

    b	radixSort_58

radixSort_71:
    movz	w13,	#0

radixSort_73:
    lsl	w19,	w13,	#2
    lsl	w9,	w13,	#2
    mov	x1,	x19
    mov	x8,	x9
    add	x1,	sp,	x1
    add	x8,	sp,	x8
    add	x1,	x1,	#288
    add	x8,	x8,	#352
    ldr	w22,	[x1]

    ldr	w8,	[x8]

    cmp	w22,	w8
    bge	radixSort_153

radixSort_82:
    lsl	w7,	w22,	#2
    ldr	x16,	[sp, #536]

    add	x6,	x16,	x7
    ldr	w5,	[x6]


radixSort_86:
    mov	w0,	w5
    movz	w2,	#0

radixSort_88:
    cmp	w2,	w28
    bge	radixSort_95

radixSort_92:
    asr	w11,	w0,	#31
    add	w2,	w2,	#1
    lsr	w17,	w11,	#28
    add	w16,	w0,	w17
    asr	w0,	w16,	#4
    b	radixSort_88

radixSort_95:
    asr	w6,	w0,	#31
    lsr	w9,	w6,	#28
    add	w10,	w0,	w9
    asr	w15,	w10,	#4
    lsl	w16,	w15,	#4
    sub	w0,	w0,	w16
    cmp	w0,	w13
    bne	radixSort_98

radixSort_146:
    ldr	w6,	[x1]

    ldr	x12,	[sp, #536]

    lsl	w22,	w6,	#2
    add	x20,	x12,	x22
    add	w22,	w6,	#1
    str	w5,	[x20]

    str	w22,	[x1]

    cmp	w22,	w8
    blt	radixSort_82

radixSort_153:
    add	w13,	w13,	#1
    cmp	w13,	#16
    blt	radixSort_73

radixSort_156:
    str	w23,	[x3]

    sub	w5,	w28,	#1
    add	x25,	sp,	#224
    add	x22,	sp,	#96
    movz	fp,	#604
    add	x0,	sp,	#160
    add	x24,	sp,	#96
    movz	w20,	#0
    ldr	w10,	[x14]

    add	w3,	w10,	w23
    add	x10,	sp,	#224
    add	x23,	sp,	#160
    str	w3,	[x26]

    str	w5,	[sp, #544]

    str	x10,	[sp, fp]

    movz	fp,	#548
    str	x0,	[sp, fp]

    movz	fp,	#612
    str	x24,	[sp, fp]

    ldr	w3,	[sp, #544]

    str	w20,	[sp, #488]

    sub	w21,	w3,	#1

radixSort_168:
    ldr	w6,	[sp, #488]

    cmp	w6,	#0
    ble	radixSort_180

radixSort_171:
    ldr	w7,	[sp, #488]

    ldr	w3,	[sp, #488]

    lsl	w6,	w7,	#2
    sub	w5,	w3,	#1
    mov	x17,	x6
    add	x17,	sp,	x17
    lsl	w7,	w5,	#2
    add	x17,	x17,	#288
    mov	x6,	x7
    add	x6,	sp,	x6
    add	x6,	x6,	#352
    ldr	w5,	[x6]

    str	w5,	[x17]

    ldr	w10,	[sp, #488]

    ldr	w8,	[sp, #488]

    lsl	w0,	w10,	#2
    lsl	w8,	w8,	#2
    mov	x10,	x0
    mov	x1,	x8
    add	x10,	sp,	x10
    add	x1,	sp,	x1
    add	x10,	x10,	#352
    add	x1,	x1,	#416
    ldr	w0,	[x1]

    add	w4,	w0,	w5
    str	w4,	[x10]

    b	radixSort_183

radixSort_180:
    ldr	w11,	[sp, #488]

    ldr	w3,	[sp, #488]

    lsl	w18,	w11,	#2
    lsl	w28,	w3,	#2
    mov	x17,	x18
    mov	x10,	x28
    add	x17,	sp,	x17
    add	x10,	sp,	x10
    add	x17,	x17,	#288
    add	x10,	x10,	#352

radixSort_183:
    ldr	w19,	[x17]

    mov	x0,	x25
    movz	w1,	#0
    movz	w2,	#64
    str	w19,	[sp, #532]

    ldr	w28,	[x10]

    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x23
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x22
    bl	memset
    ldr	w11,	[sp, #544]

    mov	x5,	x27
    cmp	w11,	w5
    beq	radixSort_354

radixSort_189:
    ldr	w9,	[sp, #532]

    add	w2,	w9,	#1
    cmp	w2,	w28
    bge	radixSort_354

radixSort_192:
    ldr	w10,	[sp, #532]

    cmp	w10,	w28
    bge	radixSort_226

radixSort_194:
    ldr	w26,	[sp, #532]


radixSort_196:
    lsl	w5,	w26,	#2
    ldr	x19,	[sp, #536]

    movz	w7,	#0
    add	x4,	x19,	x5
    ldr	w14,	[x4]

    mov	w18,	w14

radixSort_200:
    ldr	w1,	[sp, #544]

    cmp	w7,	w1
    bge	radixSort_207

radixSort_204:
    asr	w9,	w18,	#31
    add	w7,	w7,	#1
    lsr	w10,	w9,	#28
    add	w3,	w18,	w10
    asr	w18,	w3,	#4
    b	radixSort_200

radixSort_207:
    asr	w4,	w18,	#31
    movz	w7,	#0
    lsr	w5,	w4,	#28
    add	w6,	w18,	w5
    asr	w10,	w6,	#4
    lsl	w11,	w10,	#4
    sub	w1,	w18,	w11
    lsl	w3,	w1,	#2
    mov	x0,	x3
    add	x0,	sp,	x0
    add	x0,	x0,	#96

radixSort_210:
    ldr	w4,	[sp, #544]

    cmp	w7,	w4
    bge	radixSort_217

radixSort_214:
    asr	w18,	w14,	#31
    add	w7,	w7,	#1
    lsr	w19,	w18,	#28
    add	w12,	w14,	w19
    asr	w14,	w12,	#4
    b	radixSort_210

radixSort_217:
    asr	w12,	w14,	#31
    add	w26,	w26,	#1
    lsr	w13,	w12,	#28
    add	w15,	w14,	w13
    asr	w18,	w15,	#4
    lsl	w19,	w18,	#4
    sub	w9,	w14,	w19
    lsl	w11,	w9,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#96
    ldr	w12,	[x10]

    add	w13,	w12,	#1
    str	w13,	[x0]

    cmp	w26,	w28
    blt	radixSort_196

radixSort_226:
    ldr	w20,	[sp, #532]

    movz	fp,	#604
    movz	w4,	#1
    ldr	x8,	[sp, fp]

    movz	fp,	#612
    str	w20,	[x8]

    ldr	x2,	[sp, fp]

    movz	fp,	#548
    ldr	w2,	[x2]

    ldr	w24,	[sp, #532]

    ldr	x26,	[sp, fp]

    add	w12,	w2,	w24
    str	w12,	[x26]


radixSort_229:
    cmp	w4,	#16
    bge	radixSort_242

radixSort_232:
    lsl	w0,	w4,	#2
    sub	w1,	w4,	#1
    lsl	w6,	w4,	#2
    lsl	w28,	w4,	#2
    mov	x26,	x0
    mov	x5,	x6
    add	w4,	w4,	#1
    lsl	w0,	w1,	#2
    add	x26,	sp,	x26
    add	x5,	sp,	x5
    mov	x8,	x0
    add	x8,	sp,	x8
    add	x26,	x26,	#224
    add	x5,	x5,	#160
    add	x8,	x8,	#160
    ldr	w1,	[x8]

    str	w1,	[x26]

    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	#96
    ldr	w0,	[x26]

    add	w10,	w0,	w1
    str	w10,	[x5]

    b	radixSort_229

radixSort_242:
    movz	w5,	#0

radixSort_244:
    lsl	w13,	w5,	#2
    lsl	w8,	w5,	#2
    mov	x0,	x13
    mov	x7,	x8
    add	x0,	sp,	x0
    add	x7,	sp,	x7
    add	x0,	x0,	#224
    add	x7,	x7,	#160
    ldr	w1,	[x0]

    ldr	w17,	[x7]

    cmp	w1,	w17
    bge	radixSort_324

radixSort_253:
    lsl	w11,	w1,	#2
    ldr	x15,	[sp, #536]

    add	x10,	x15,	x11
    ldr	w4,	[x10]


radixSort_257:
    mov	w8,	w4
    movz	w2,	#0

radixSort_259:
    ldr	w9,	[sp, #544]

    cmp	w2,	w9
    bge	radixSort_266

radixSort_263:
    asr	w13,	w8,	#31
    add	w2,	w2,	#1
    lsr	w14,	w13,	#28
    add	w6,	w8,	w14
    asr	w8,	w6,	#4
    b	radixSort_259

radixSort_266:
    asr	w7,	w8,	#31
    lsr	w10,	w7,	#28
    add	w11,	w8,	w10
    asr	w16,	w11,	#4
    lsl	w19,	w16,	#4
    sub	w26,	w8,	w19
    cmp	w26,	w5
    bne	radixSort_269

radixSort_317:
    ldr	w2,	[x0]

    add	w1,	w2,	#1
    ldr	x13,	[sp, #536]

    lsl	w16,	w2,	#2
    add	x8,	x13,	x16
    str	w4,	[x8]

    str	w1,	[x0]

    cmp	w1,	w17
    blt	radixSort_253

radixSort_324:
    add	w5,	w5,	#1
    cmp	w5,	#16
    blt	radixSort_244

radixSort_327:
    ldr	w15,	[sp, #532]

    movz	fp,	#604
    movz	w3,	#0
    ldr	x26,	[sp, fp]

    movz	fp,	#548
    str	w15,	[x26]

    mov	w26,	w3
    ldr	x28,	[sp, fp]

    str	w12,	[x28]


radixSort_329:
    cmp	w26,	#0
    ble	radixSort_341

radixSort_332:
    lsl	w0,	w26,	#2
    sub	w17,	w26,	#1
    lsl	w1,	w26,	#2
    mov	x2,	x0
    mov	x10,	x1
    add	x2,	sp,	x2
    lsl	w19,	w17,	#2
    add	x10,	sp,	x10
    mov	x18,	x19
    add	x2,	x2,	#224
    lsl	w19,	w26,	#2
    add	x10,	x10,	#160
    add	x18,	sp,	x18
    add	x18,	x18,	#160
    ldr	w8,	[x18]

    mov	x18,	x19
    str	w8,	[x2]

    add	x18,	sp,	x18
    add	x18,	x18,	#96
    ldr	w28,	[x18]

    add	w7,	w28,	w8
    str	w7,	[x10]

    b	radixSort_344

radixSort_341:
    lsl	w12,	w26,	#2
    lsl	w10,	w26,	#2
    mov	x2,	x12
    mov	x10,	x10
    add	x2,	sp,	x2
    add	x10,	sp,	x10
    add	x2,	x2,	#224
    add	x10,	x10,	#160

radixSort_344:
    ldr	w2,	[x2]

    mov	w0,	w21
    ldr	w3,	[x10]

    ldr	x1,	[sp, #536]

    bl	radixSort
    add	w3,	w26,	#1
    cmp	w3,	#16
    bge	radixSort_354

radixSort_328:
    mov	w26,	w3
    b	radixSort_329

radixSort_269:
    mov	w14,	w4
    movz	w2,	#0

radixSort_270:
    ldr	w10,	[sp, #544]

    cmp	w2,	w10
    bge	radixSort_277

radixSort_274:
    asr	w3,	w14,	#31
    add	w2,	w2,	#1
    lsr	w6,	w3,	#28
    add	w15,	w14,	w6
    asr	w14,	w15,	#4
    b	radixSort_270

radixSort_277:
    asr	w16,	w14,	#31
    mov	w8,	w4
    movz	w13,	#0
    lsr	w19,	w16,	#28
    add	w28,	w14,	w19
    asr	w9,	w28,	#4
    lsl	w10,	w9,	#4
    sub	w18,	w14,	w10
    lsl	w28,	w18,	#2
    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	#224
    ldr	w1,	[x26]

    ldr	x11,	[sp, #536]

    lsl	w7,	w1,	#2
    add	x2,	x11,	x7
    ldr	w3,	[x2]


radixSort_283:
    ldr	w9,	[sp, #544]

    cmp	w13,	w9
    bge	radixSort_290

radixSort_287:
    asr	w9,	w8,	#31
    add	w13,	w13,	#1
    lsr	w11,	w9,	#28
    add	w10,	w8,	w11
    asr	w8,	w10,	#4
    b	radixSort_283

radixSort_290:
    asr	w14,	w8,	#31
    mov	w10,	w4
    lsr	w15,	w14,	#28
    add	w16,	w8,	w15
    asr	w26,	w16,	#4
    lsl	w1,	w26,	#4
    sub	w14,	w8,	w1
    lsl	w16,	w14,	#2
    mov	x15,	x16
    add	x15,	sp,	x15
    add	x15,	x15,	#224
    ldr	w19,	[x15]

    movz	w15,	#0
    ldr	x24,	[sp, #536]

    lsl	w1,	w19,	#2
    add	x28,	x24,	x1
    str	w4,	[x28]


radixSort_295:
    ldr	w9,	[sp, #544]

    cmp	w15,	w9
    bge	radixSort_302

radixSort_299:
    asr	w13,	w10,	#31
    add	w15,	w15,	#1
    lsr	w14,	w13,	#28
    add	w1,	w10,	w14
    asr	w10,	w1,	#4
    b	radixSort_295

radixSort_302:
    asr	w2,	w10,	#31
    lsr	w6,	w2,	#28
    add	w7,	w10,	w6
    mov	w6,	w4
    asr	w7,	w7,	#4
    lsl	w9,	w7,	#4
    sub	w14,	w10,	w9
    lsl	w8,	w14,	#2
    movz	w14,	#0
    mov	x8,	x8
    add	x8,	sp,	x8
    add	x8,	x8,	#224

radixSort_305:
    ldr	w13,	[sp, #544]

    cmp	w14,	w13
    bge	radixSort_312

radixSort_309:
    asr	w2,	w6,	#31
    add	w14,	w14,	#1
    lsr	w4,	w2,	#28
    add	w2,	w6,	w4
    asr	w6,	w2,	#4
    b	radixSort_305

radixSort_312:
    asr	w9,	w6,	#31
    mov	w4,	w3
    lsr	w10,	w9,	#28
    add	w11,	w6,	w10
    asr	w9,	w11,	#4
    lsl	w10,	w9,	#4
    sub	w11,	w6,	w10
    lsl	w14,	w11,	#2
    mov	x13,	x14
    add	x13,	sp,	x13
    add	x13,	x13,	#224
    ldr	w15,	[x13]

    add	w16,	w15,	#1
    str	w16,	[x8]

    b	radixSort_257

radixSort_354:
    ldr	w13,	[sp, #488]

    add	w5,	w13,	#1
    cmp	w5,	#16
    bge	radixSort_360

radixSort_167:
    str	w5,	[sp, #488]

    b	radixSort_168

radixSort_98:
    mov	w0,	w5
    movz	w15,	#0

radixSort_99:
    cmp	w15,	w28
    bge	radixSort_106

radixSort_103:
    asr	w7,	w0,	#31
    add	w15,	w15,	#1
    lsr	w10,	w7,	#28
    add	w2,	w0,	w10
    asr	w0,	w2,	#4
    b	radixSort_99

radixSort_106:
    asr	w9,	w0,	#31
    movz	w6,	#0
    lsr	w15,	w9,	#28
    add	w16,	w0,	w15
    mov	w15,	w5
    asr	w25,	w16,	#4
    lsl	w2,	w25,	#4
    sub	w19,	w0,	w2
    lsl	w22,	w19,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#288
    ldr	w25,	[x21]

    ldr	x18,	[sp, #536]

    lsl	w2,	w25,	#2
    add	x0,	x18,	x2
    ldr	w0,	[x0]


radixSort_112:
    cmp	w6,	w28
    bge	radixSort_119

radixSort_116:
    asr	w7,	w15,	#31
    add	w6,	w6,	#1
    lsr	w10,	w7,	#28
    add	w17,	w15,	w10
    asr	w15,	w17,	#4
    b	radixSort_112

radixSort_119:
    asr	w19,	w15,	#31
    movz	w10,	#0
    lsr	w21,	w19,	#28
    add	w25,	w15,	w21
    asr	w6,	w25,	#4
    lsl	w7,	w6,	#4
    sub	w15,	w15,	w7
    lsl	w17,	w15,	#2
    mov	x16,	x17
    mov	w17,	w5
    add	x16,	sp,	x16
    add	x16,	x16,	#288
    ldr	w18,	[x16]

    ldr	x6,	[sp, #536]

    lsl	w22,	w18,	#2
    add	x20,	x6,	x22
    str	w5,	[x20]


radixSort_124:
    cmp	w10,	w28
    bge	radixSort_131

radixSort_128:
    asr	w9,	w17,	#31
    add	w10,	w10,	#1
    lsr	w11,	w9,	#28
    add	w4,	w17,	w11
    asr	w17,	w4,	#4
    b	radixSort_124

radixSort_131:
    asr	w7,	w17,	#31
    lsr	w10,	w7,	#28
    mov	w7,	w5
    add	w16,	w17,	w10
    movz	w10,	#0
    asr	w18,	w16,	#4
    lsl	w6,	w18,	#4
    sub	w6,	w17,	w6
    lsl	w15,	w6,	#2
    mov	x2,	x15
    add	x2,	sp,	x2
    add	x2,	x2,	#288

radixSort_134:
    cmp	w10,	w28
    bge	radixSort_141

radixSort_138:
    asr	w18,	w7,	#31
    add	w10,	w10,	#1
    lsr	w5,	w18,	#28
    add	w9,	w7,	w5
    asr	w7,	w9,	#4
    b	radixSort_134

radixSort_141:
    asr	w15,	w7,	#31
    lsr	w16,	w15,	#28
    add	w5,	w7,	w16
    asr	w17,	w5,	#4
    lsl	w18,	w17,	#4
    sub	w11,	w7,	w18
    lsl	w5,	w11,	#2
    mov	x12,	x5
    mov	w5,	w0
    add	x12,	sp,	x12
    add	x12,	x12,	#288
    ldr	w7,	[x12]

    add	w9,	w7,	#1
    str	w9,	[x2]

    b	radixSort_86

radixSort_360:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #656
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    adrp	x22, :got:a
    ldr	x22, [x22, #:got_lo12:a]
    mov	x0,	x22
    bl	getarray
    mov	w20,	w0
    movz	w0,	#90
    bl	_sysy_starttime
    mov	w3,	w20
    movz	w2,	#0
    mov	x1,	x22
    movz	w0,	#8
    bl	radixSort
    movz	w24,	#0
    movz	w16,	#0

main_3:
    cmp	w16,	w20
    bge	main_15

main_7:
    lsl	w13,	w16,	#2
    adrp	x28, :got:a
    add	w7,	w16,	#2
    ldr	x28, [x28, #:got_lo12:a]
    add	x26,	x28,	x13
    ldr	w10,	[x26]

    sdiv	w22,	w10,	w7
    mul	w19,	w22,	w7
    msub	w19,	w22,	w7,	w10

    madd	w24,	w19,	w16,	w24

    mul	w3,	w19,	w16
    add	w16,	w16,	#1
    b	main_3

main_15:
    movz	w22,	#0
    sub	w25,	w22,	w24
    cmp	w24,	#0
    movz	w0,	#102
    csel	w27,	w25,	w24,	lt
    cset	w19,	lt
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


