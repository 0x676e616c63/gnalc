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
    
    mov	w25,	w3
    mov	w23,	w2
    movz	fp,	#532
    mov	w28,	w0
    movz	w2,	#64
    add	x0,	sp,	#288
    str	x1,	[sp, fp]

    movz	w1,	#0
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
    movz	fp,	#532
    movz	w7,	#0
    ldr	x10,	[sp, fp]

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
    add	x2,	sp,	#288
    add	x20,	sp,	#352
    add	x15,	sp,	#416
    movz	w12,	#1
    str	w23,	[x2]

    ldr	w0,	[x15]

    add	w1,	w0,	w23
    str	w1,	[x20]


radixSort_58:
    cmp	w12,	#16
    bge	radixSort_71

radixSort_61:
    lsl	w0,	w12,	#2
    sub	w13,	w12,	#1
    lsl	w25,	w12,	#2
    lsl	w14,	w12,	#2
    mov	x6,	x0
    mov	x22,	x25
    lsl	w17,	w13,	#2
    add	w12,	w12,	#1
    mov	x11,	x14
    add	x6,	sp,	x6
    add	x22,	sp,	x22
    mov	x16,	x17
    add	x11,	sp,	x11
    add	x16,	sp,	x16
    add	x6,	x6,	#288
    add	x22,	x22,	#352
    add	x11,	x11,	#416
    add	x16,	x16,	#352
    ldr	w18,	[x16]

    str	w18,	[x6]

    ldr	w16,	[x11]

    add	w6,	w16,	w18
    str	w6,	[x22]

    b	radixSort_58

radixSort_71:
    movz	w13,	#0

radixSort_73:
    lsl	w19,	w13,	#2
    lsl	w9,	w13,	#2
    mov	x4,	x19
    mov	x8,	x9
    add	x4,	sp,	x4
    add	x8,	sp,	x8
    add	x4,	x4,	#288
    add	x8,	x8,	#352
    ldr	w25,	[x4]

    ldr	w6,	[x8]

    cmp	w25,	w6
    bge	radixSort_153

radixSort_82:
    lsl	w8,	w25,	#2
    movz	fp,	#532
    ldr	x14,	[sp, fp]

    add	x5,	x14,	x8
    ldr	w5,	[x5]


radixSort_86:
    mov	w0,	w5
    movz	w1,	#0

radixSort_88:
    cmp	w1,	w28
    bge	radixSort_95

radixSort_92:
    asr	w11,	w0,	#31
    add	w1,	w1,	#1
    lsr	w17,	w11,	#28
    add	w16,	w0,	w17
    asr	w0,	w16,	#4
    b	radixSort_88

radixSort_95:
    asr	w3,	w0,	#31
    lsr	w8,	w3,	#28
    add	w10,	w0,	w8
    asr	w14,	w10,	#4
    lsl	w16,	w14,	#4
    sub	w26,	w0,	w16
    cmp	w26,	w13
    bne	radixSort_98

radixSort_146:
    ldr	w7,	[x4]

    movz	fp,	#532
    add	w25,	w7,	#1
    lsl	w21,	w7,	#2
    ldr	x11,	[sp, fp]

    add	x18,	x11,	x21
    str	w5,	[x18]

    str	w25,	[x4]

    cmp	w25,	w6
    blt	radixSort_82

radixSort_153:
    add	w13,	w13,	#1
    cmp	w13,	#16
    blt	radixSort_73

radixSort_156:
    str	w23,	[x2]

    sub	w5,	w28,	#1
    add	x25,	sp,	#224
    add	x22,	sp,	#96
    add	x0,	sp,	#160
    add	x24,	sp,	#96
    ldr	w10,	[x15]

    add	w3,	w10,	w23
    add	x10,	sp,	#224
    add	x23,	sp,	#160
    str	w3,	[x20]

    movz	w20,	#0
    str	w5,	[sp, #540]

    str	x10,	[sp, #616]

    str	x0,	[sp, #560]

    str	x24,	[sp, #552]

    ldr	w3,	[sp, #540]

    str	w20,	[sp, #480]

    sub	w21,	w3,	#1

radixSort_168:
    ldr	w6,	[sp, #480]

    cmp	w6,	#0
    ble	radixSort_180

radixSort_171:
    ldr	w7,	[sp, #480]

    ldr	w3,	[sp, #480]

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

    ldr	w10,	[sp, #480]

    ldr	w8,	[sp, #480]

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
    ldr	w11,	[sp, #480]

    ldr	w3,	[sp, #480]

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
    str	w19,	[sp, #544]

    ldr	w28,	[x10]

    bl	memset
    movz	w1,	#0
    movz	w2,	#64
    mov	x0,	x23
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x22
    bl	memset
    ldr	w11,	[sp, #540]

    mov	x5,	x27
    cmp	w11,	w5
    beq	radixSort_354

radixSort_189:
    ldr	w9,	[sp, #544]

    add	w2,	w9,	#1
    cmp	w2,	w28
    bge	radixSort_354

radixSort_192:
    ldr	w10,	[sp, #544]

    cmp	w10,	w28
    bge	radixSort_226

radixSort_194:
    ldr	w26,	[sp, #544]


radixSort_196:
    lsl	w5,	w26,	#2
    movz	fp,	#532
    movz	w7,	#0
    ldr	x19,	[sp, fp]

    add	x4,	x19,	x5
    ldr	w14,	[x4]

    mov	w18,	w14

radixSort_200:
    ldr	w1,	[sp, #540]

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
    ldr	w4,	[sp, #540]

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
    ldr	w20,	[sp, #544]

    movz	w4,	#1
    ldr	x8,	[sp, #616]

    str	w20,	[x8]

    ldr	x2,	[sp, #552]

    ldr	w2,	[x2]

    ldr	w24,	[sp, #544]

    add	w26,	w2,	w24
    ldr	x24,	[sp, #560]

    str	w26,	[x24]


radixSort_229:
    cmp	w4,	#16
    bge	radixSort_242

radixSort_232:
    lsl	w19,	w4,	#2
    sub	w28,	w4,	#1
    lsl	w6,	w4,	#2
    mov	x18,	x19
    mov	x5,	x6
    lsl	w19,	w4,	#2
    lsl	w0,	w28,	#2
    add	x18,	sp,	x18
    add	x5,	sp,	x5
    add	w4,	w4,	#1
    mov	x8,	x0
    add	x18,	x18,	#224
    add	x8,	sp,	x8
    add	x5,	x5,	#160
    add	x8,	x8,	#160
    ldr	w1,	[x8]

    str	w1,	[x18]

    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#96
    ldr	w28,	[x18]

    add	w10,	w28,	w1
    str	w10,	[x5]

    b	radixSort_229

radixSort_242:
    movz	w5,	#0

radixSort_244:
    lsl	w12,	w5,	#2
    lsl	w8,	w5,	#2
    mov	x0,	x12
    mov	x7,	x8
    add	x0,	sp,	x0
    add	x7,	sp,	x7
    add	x0,	x0,	#224
    add	x7,	x7,	#160
    ldr	w1,	[x0]

    ldr	w15,	[x7]

    cmp	w1,	w15
    bge	radixSort_324

radixSort_253:
    lsl	w11,	w1,	#2
    movz	fp,	#532
    ldr	x14,	[sp, fp]

    add	x10,	x14,	x11
    ldr	w4,	[x10]


radixSort_257:
    mov	w8,	w4
    movz	w2,	#0

radixSort_259:
    ldr	w9,	[sp, #540]

    cmp	w2,	w9
    bge	radixSort_266

radixSort_263:
    asr	w12,	w8,	#31
    add	w2,	w2,	#1
    lsr	w13,	w12,	#28
    add	w6,	w8,	w13
    asr	w8,	w6,	#4
    b	radixSort_259

radixSort_266:
    asr	w7,	w8,	#31
    lsr	w10,	w7,	#28
    add	w11,	w8,	w10
    asr	w16,	w11,	#4
    lsl	w17,	w16,	#4
    sub	w18,	w8,	w17
    cmp	w18,	w5
    bne	radixSort_269

radixSort_317:
    ldr	w1,	[x0]

    movz	fp,	#532
    lsl	w16,	w1,	#2
    ldr	x12,	[sp, fp]

    add	w1,	w1,	#1
    add	x6,	x12,	x16
    str	w4,	[x6]

    str	w1,	[x0]

    cmp	w1,	w15
    blt	radixSort_253

radixSort_324:
    add	w5,	w5,	#1
    cmp	w5,	#16
    blt	radixSort_244

radixSort_327:
    ldr	w14,	[sp, #544]

    movz	w3,	#0
    ldr	x24,	[sp, #616]

    str	w14,	[x24]

    ldr	x28,	[sp, #560]

    str	w26,	[x28]

    mov	w26,	w3

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
    movz	fp,	#532
    ldr	w3,	[x10]

    ldr	x1,	[sp, fp]

    bl	radixSort
    add	w3,	w26,	#1
    cmp	w3,	#16
    bge	radixSort_354

radixSort_328:
    mov	w26,	w3
    b	radixSort_329

radixSort_269:
    mov	w13,	w4
    movz	w2,	#0

radixSort_270:
    ldr	w10,	[sp, #540]

    cmp	w2,	w10
    bge	radixSort_277

radixSort_274:
    asr	w1,	w13,	#31
    add	w2,	w2,	#1
    lsr	w3,	w1,	#28
    add	w14,	w13,	w3
    asr	w13,	w14,	#4
    b	radixSort_270

radixSort_277:
    asr	w16,	w13,	#31
    movz	fp,	#532
    mov	w8,	w4
    movz	w12,	#0
    lsr	w17,	w16,	#28
    add	w19,	w13,	w17
    asr	w9,	w19,	#4
    lsl	w10,	w9,	#4
    sub	w16,	w13,	w10
    lsl	w19,	w16,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#224
    ldr	w28,	[x18]

    ldr	x11,	[sp, fp]

    lsl	w3,	w28,	#2
    add	x1,	x11,	x3
    ldr	w3,	[x1]


radixSort_283:
    ldr	w6,	[sp, #540]

    cmp	w12,	w6
    bge	radixSort_290

radixSort_287:
    asr	w7,	w8,	#31
    add	w12,	w12,	#1
    lsr	w9,	w7,	#28
    add	w10,	w8,	w9
    asr	w8,	w10,	#4
    b	radixSort_283

radixSort_290:
    asr	w13,	w8,	#31
    movz	fp,	#532
    mov	w10,	w4
    lsr	w14,	w13,	#28
    add	w16,	w8,	w14
    asr	w18,	w16,	#4
    lsl	w28,	w18,	#4
    sub	w13,	w8,	w28
    lsl	w16,	w13,	#2
    mov	x14,	x16
    add	x14,	sp,	x14
    add	x14,	x14,	#224
    ldr	w17,	[x14]

    movz	w14,	#0
    ldr	x19,	[sp, fp]

    lsl	w1,	w17,	#2
    add	x19,	x19,	x1
    str	w4,	[x19]


radixSort_295:
    ldr	w9,	[sp, #540]

    cmp	w14,	w9
    bge	radixSort_302

radixSort_299:
    asr	w12,	w10,	#31
    add	w14,	w14,	#1
    lsr	w13,	w12,	#28
    add	w28,	w10,	w13
    asr	w10,	w28,	#4
    b	radixSort_295

radixSort_302:
    asr	w1,	w10,	#31
    lsr	w2,	w1,	#28
    add	w6,	w10,	w2
    asr	w6,	w6,	#4
    lsl	w7,	w6,	#4
    mov	w6,	w4
    sub	w13,	w10,	w7
    lsl	w8,	w13,	#2
    movz	w13,	#0
    mov	x8,	x8
    add	x8,	sp,	x8
    add	x8,	x8,	#224

radixSort_305:
    ldr	w12,	[sp, #540]

    cmp	w13,	w12
    bge	radixSort_312

radixSort_309:
    asr	w1,	w6,	#31
    add	w13,	w13,	#1
    lsr	w2,	w1,	#28
    add	w2,	w6,	w2
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
    lsl	w13,	w11,	#2
    mov	x12,	x13
    add	x12,	sp,	x12
    add	x12,	x12,	#224
    ldr	w14,	[x12]

    add	w16,	w14,	#1
    str	w16,	[x8]

    b	radixSort_257

radixSort_354:
    ldr	w13,	[sp, #480]

    add	w5,	w13,	#1
    cmp	w5,	#16
    bge	radixSort_360

radixSort_167:
    str	w5,	[sp, #480]

    b	radixSort_168

radixSort_98:
    mov	w0,	w5
    movz	w14,	#0

radixSort_99:
    cmp	w14,	w28
    bge	radixSort_106

radixSort_103:
    asr	w7,	w0,	#31
    add	w14,	w14,	#1
    lsr	w10,	w7,	#28
    add	w0,	w0,	w10
    asr	w0,	w0,	#4
    b	radixSort_99

radixSort_106:
    asr	w9,	w0,	#31
    movz	fp,	#532
    movz	w7,	#0
    lsr	w14,	w9,	#28
    add	w16,	w0,	w14
    mov	w14,	w5
    asr	w22,	w16,	#4
    lsl	w26,	w22,	#4
    sub	w17,	w0,	w26
    lsl	w21,	w17,	#2
    mov	x19,	x21
    add	x19,	sp,	x19
    add	x19,	x19,	#288
    ldr	w25,	[x19]

    ldr	x17,	[sp, fp]

    lsl	w0,	w25,	#2
    add	x26,	x17,	x0
    ldr	w0,	[x26]


radixSort_112:
    cmp	w7,	w28
    bge	radixSort_119

radixSort_116:
    asr	w3,	w14,	#31
    add	w7,	w7,	#1
    lsr	w8,	w3,	#28
    add	w16,	w14,	w8
    asr	w14,	w16,	#4
    b	radixSort_112

radixSort_119:
    asr	w18,	w14,	#31
    movz	fp,	#532
    movz	w10,	#0
    lsr	w19,	w18,	#28
    add	w22,	w14,	w19
    asr	w3,	w22,	#4
    lsl	w7,	w3,	#4
    sub	w12,	w14,	w7
    lsl	w16,	w12,	#2
    mov	x14,	x16
    add	x14,	sp,	x14
    add	x14,	x14,	#288
    ldr	w17,	[x14]

    ldr	x3,	[sp, fp]

    lsl	w21,	w17,	#2
    mov	w17,	w5
    add	x18,	x3,	x21
    str	w5,	[x18]


radixSort_124:
    cmp	w10,	w28
    bge	radixSort_131

radixSort_128:
    asr	w8,	w17,	#31
    add	w10,	w10,	#1
    lsr	w11,	w8,	#28
    add	w1,	w17,	w11
    asr	w17,	w1,	#4
    b	radixSort_124

radixSort_131:
    asr	w7,	w17,	#31
    mov	w8,	w5
    lsr	w10,	w7,	#28
    add	w16,	w17,	w10
    movz	w10,	#0
    asr	w18,	w16,	#4
    lsl	w3,	w18,	#4
    sub	w3,	w17,	w3
    lsl	w14,	w3,	#2
    mov	x19,	x14
    add	x19,	sp,	x19
    add	x19,	x19,	#288

radixSort_134:
    cmp	w10,	w28
    bge	radixSort_141

radixSort_138:
    asr	w18,	w8,	#31
    add	w10,	w10,	#1
    lsr	w3,	w18,	#28
    add	w9,	w8,	w3
    asr	w8,	w9,	#4
    b	radixSort_134

radixSort_141:
    asr	w14,	w8,	#31
    mov	w5,	w0
    lsr	w16,	w14,	#28
    add	w3,	w8,	w16
    asr	w16,	w3,	#4
    lsl	w17,	w16,	#4
    sub	w11,	w8,	w17
    lsl	w3,	w11,	#2
    mov	x12,	x3
    add	x12,	sp,	x12
    add	x12,	x12,	#288
    ldr	w7,	[x12]

    add	w9,	w7,	#1
    str	w9,	[x19]

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


