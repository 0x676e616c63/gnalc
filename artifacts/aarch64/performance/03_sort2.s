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
    
    mov	w22,	w3
    mov	w24,	w2
    movz	fp,	#532
    mov	w27,	w0
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
    mov	w28,	w19
    cmp	w27,	w28
    beq	radixSort_360

radixSort_15:
    add	w23,	w24,	#1
    cmp	w23,	w22
    bge	radixSort_360

radixSort_18:
    cmp	w24,	w22
    bge	radixSort_52

radixSort_20:
    mov	w6,	w24

radixSort_22:
    lsl	w17,	w6,	#2
    movz	fp,	#532
    movz	w9,	#0
    ldr	x10,	[sp, fp]

    add	x16,	x10,	x17
    ldr	w0,	[x16]

    mov	w10,	w0

radixSort_26:
    cmp	w9,	w27
    bge	radixSort_33

radixSort_30:
    asr	w16,	w10,	#31
    add	w9,	w9,	#1
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
    mov	x14,	x12
    add	x14,	sp,	x14
    add	x14,	x14,	#416

radixSort_36:
    cmp	w13,	w27
    bge	radixSort_43

radixSort_40:
    asr	w16,	w0,	#31
    add	w13,	w13,	#1
    lsr	w17,	w16,	#28
    add	w7,	w0,	w17
    asr	w0,	w7,	#4
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
    str	w9,	[x14]

    cmp	w6,	w22
    blt	radixSort_22

radixSort_52:
    add	x14,	sp,	#288
    add	x10,	sp,	#352
    add	x17,	sp,	#416
    movz	w12,	#1
    str	w24,	[x14]

    ldr	w0,	[x17]

    add	w1,	w0,	w24
    str	w1,	[x10]


radixSort_58:
    cmp	w12,	#16
    bge	radixSort_71

radixSort_61:
    lsl	w0,	w12,	#2
    sub	w11,	w12,	#1
    lsl	w2,	w12,	#2
    lsl	w15,	w12,	#2
    mov	x7,	x0
    mov	x23,	x2
    lsl	w19,	w11,	#2
    add	w12,	w12,	#1
    mov	x9,	x15
    add	x7,	sp,	x7
    add	x23,	sp,	x23
    mov	x16,	x19
    add	x9,	sp,	x9
    add	x16,	sp,	x16
    add	x7,	x7,	#288
    add	x23,	x23,	#352
    add	x9,	x9,	#416
    add	x16,	x16,	#352
    ldr	w21,	[x16]

    str	w21,	[x7]

    ldr	w18,	[x9]

    add	w7,	w18,	w21
    str	w7,	[x23]

    b	radixSort_58

radixSort_71:
    movz	w13,	#0

radixSort_73:
    lsl	w21,	w13,	#2
    lsl	w11,	w13,	#2
    mov	x1,	x21
    mov	x9,	x11
    add	x1,	sp,	x1
    add	x9,	sp,	x9
    add	x1,	x1,	#288
    add	x9,	x9,	#352
    ldr	w23,	[x1]

    ldr	w9,	[x9]

    cmp	w23,	w9
    bge	radixSort_153

radixSort_82:
    lsl	w5,	w23,	#2
    movz	fp,	#532
    ldr	x12,	[sp, fp]

    add	x4,	x12,	x5
    ldr	w4,	[x4]


radixSort_86:
    mov	w0,	w4
    movz	w2,	#0

radixSort_88:
    cmp	w2,	w27
    bge	radixSort_95

radixSort_92:
    asr	w18,	w0,	#31
    add	w2,	w2,	#1
    lsr	w19,	w18,	#28
    add	w18,	w0,	w19
    asr	w0,	w18,	#4
    b	radixSort_88

radixSort_95:
    asr	w5,	w0,	#31
    lsr	w6,	w5,	#28
    add	w7,	w0,	w6
    asr	w16,	w7,	#4
    lsl	w18,	w16,	#4
    sub	w0,	w0,	w18
    cmp	w0,	w13
    bne	radixSort_98

radixSort_146:
    ldr	w11,	[x1]

    movz	fp,	#532
    add	w23,	w11,	#1
    lsl	w22,	w11,	#2
    ldr	x7,	[sp, fp]

    add	x19,	x7,	x22
    str	w4,	[x19]

    str	w23,	[x1]

    cmp	w23,	w9
    blt	radixSort_82

radixSort_153:
    add	w13,	w13,	#1
    cmp	w13,	#16
    blt	radixSort_73

radixSort_156:
    str	w24,	[x14]

    sub	w5,	w27,	#1
    add	x23,	sp,	#224
    add	x26,	sp,	#160
    add	x0,	sp,	#160
    add	x22,	sp,	#96
    movz	w20,	#0
    ldr	w12,	[x17]

    add	x27,	sp,	#96
    add	w3,	w12,	w24
    str	w3,	[x10]

    add	x10,	sp,	#224
    str	w5,	[sp, #540]

    str	x10,	[sp, #616]

    str	x0,	[sp, #560]

    str	x22,	[sp, #552]

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
    lsl	w24,	w3,	#2
    mov	x17,	x18
    mov	x10,	x24
    add	x17,	sp,	x17
    add	x10,	sp,	x10
    add	x17,	x17,	#288
    add	x10,	x10,	#352

radixSort_183:
    ldr	w19,	[x17]

    mov	x0,	x23
    movz	w1,	#0
    movz	w2,	#64
    str	w19,	[sp, #544]

    ldr	w24,	[x10]

    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x26
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x27
    bl	memset
    ldr	w11,	[sp, #540]

    mov	x5,	x28
    cmp	w11,	w5
    beq	radixSort_354

radixSort_189:
    ldr	w9,	[sp, #544]

    add	w2,	w9,	#1
    cmp	w2,	w24
    bge	radixSort_354

radixSort_192:
    ldr	w10,	[sp, #544]

    cmp	w10,	w24
    bge	radixSort_226

radixSort_194:
    ldr	w22,	[sp, #544]


radixSort_196:
    lsl	w5,	w22,	#2
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
    add	w22,	w22,	#1
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

    cmp	w22,	w24
    blt	radixSort_196

radixSort_226:
    ldr	w20,	[sp, #544]

    movz	w4,	#1
    ldr	x8,	[sp, #616]

    str	w20,	[x8]

    ldr	x2,	[sp, #552]

    ldr	w2,	[x2]

    ldr	w22,	[sp, #544]

    ldr	x24,	[sp, #560]

    add	w13,	w2,	w22
    str	w13,	[x24]


radixSort_229:
    cmp	w4,	#16
    bge	radixSort_242

radixSort_232:
    lsl	w0,	w4,	#2
    sub	w1,	w4,	#1
    lsl	w6,	w4,	#2
    lsl	w24,	w4,	#2
    mov	x22,	x0
    mov	x5,	x6
    add	w4,	w4,	#1
    lsl	w0,	w1,	#2
    add	x22,	sp,	x22
    add	x5,	sp,	x5
    mov	x8,	x0
    add	x8,	sp,	x8
    add	x22,	x22,	#224
    add	x5,	x5,	#160
    add	x8,	x8,	#160
    ldr	w1,	[x8]

    str	w1,	[x22]

    mov	x22,	x24
    add	x22,	sp,	x22
    add	x22,	x22,	#96
    ldr	w0,	[x22]

    add	w10,	w0,	w1
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
    ldr	x16,	[sp, fp]

    add	x10,	x16,	x11
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
    lsr	w14,	w12,	#28
    add	w6,	w8,	w14
    asr	w8,	w6,	#4
    b	radixSort_259

radixSort_266:
    asr	w7,	w8,	#31
    lsr	w10,	w7,	#28
    add	w11,	w8,	w10
    asr	w17,	w11,	#4
    lsl	w22,	w17,	#4
    sub	w22,	w8,	w22
    cmp	w22,	w5
    bne	radixSort_269

radixSort_317:
    ldr	w2,	[x0]

    movz	fp,	#532
    add	w1,	w2,	#1
    lsl	w17,	w2,	#2
    ldr	x12,	[sp, fp]

    add	x8,	x12,	x17
    str	w4,	[x8]

    str	w1,	[x0]

    cmp	w1,	w15
    blt	radixSort_253

radixSort_324:
    add	w5,	w5,	#1
    cmp	w5,	#16
    blt	radixSort_244

radixSort_327:
    ldr	w15,	[sp, #544]

    movz	w3,	#0
    ldr	x24,	[sp, #616]

    mov	w22,	w3
    str	w15,	[x24]

    ldr	x25,	[sp, #560]

    str	w13,	[x25]


radixSort_329:
    cmp	w22,	#0
    ble	radixSort_341

radixSort_332:
    lsl	w0,	w22,	#2
    sub	w17,	w22,	#1
    lsl	w1,	w22,	#2
    mov	x2,	x0
    mov	x10,	x1
    add	x2,	sp,	x2
    lsl	w19,	w17,	#2
    add	x10,	sp,	x10
    mov	x18,	x19
    add	x2,	x2,	#224
    lsl	w19,	w22,	#2
    add	x10,	x10,	#160
    add	x18,	sp,	x18
    add	x18,	x18,	#160
    ldr	w8,	[x18]

    mov	x18,	x19
    str	w8,	[x2]

    add	x18,	sp,	x18
    add	x18,	x18,	#96
    ldr	w24,	[x18]

    add	w7,	w24,	w8
    str	w7,	[x10]

    b	radixSort_344

radixSort_341:
    lsl	w12,	w22,	#2
    lsl	w10,	w22,	#2
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
    add	w3,	w22,	#1
    cmp	w3,	#16
    bge	radixSort_354

radixSort_328:
    mov	w22,	w3
    b	radixSort_329

radixSort_269:
    mov	w14,	w4
    movz	w2,	#0

radixSort_270:
    ldr	w10,	[sp, #540]

    cmp	w2,	w10
    bge	radixSort_277

radixSort_274:
    asr	w3,	w14,	#31
    add	w2,	w2,	#1
    lsr	w6,	w3,	#28
    add	w16,	w14,	w6
    asr	w14,	w16,	#4
    b	radixSort_270

radixSort_277:
    asr	w17,	w14,	#31
    movz	fp,	#532
    mov	w8,	w4
    movz	w12,	#0
    lsr	w22,	w17,	#28
    add	w24,	w14,	w22
    asr	w9,	w24,	#4
    lsl	w10,	w9,	#4
    sub	w19,	w14,	w10
    lsl	w24,	w19,	#2
    mov	x22,	x24
    add	x22,	sp,	x22
    add	x22,	x22,	#224
    ldr	w1,	[x22]

    ldr	x11,	[sp, fp]

    lsl	w7,	w1,	#2
    add	x2,	x11,	x7
    ldr	w3,	[x2]


radixSort_283:
    ldr	w9,	[sp, #540]

    cmp	w12,	w9
    bge	radixSort_290

radixSort_287:
    asr	w9,	w8,	#31
    add	w12,	w12,	#1
    lsr	w11,	w9,	#28
    add	w10,	w8,	w11
    asr	w8,	w10,	#4
    b	radixSort_283

radixSort_290:
    asr	w14,	w8,	#31
    movz	fp,	#532
    mov	w10,	w4
    lsr	w16,	w14,	#28
    add	w17,	w8,	w16
    asr	w24,	w17,	#4
    lsl	w1,	w24,	#4
    sub	w14,	w8,	w1
    lsl	w17,	w14,	#2
    mov	x16,	x17
    add	x16,	sp,	x16
    add	x16,	x16,	#224
    ldr	w22,	[x16]

    movz	w16,	#0
    lsl	w2,	w22,	#2
    ldr	x22,	[sp, fp]

    add	x24,	x22,	x2
    str	w4,	[x24]


radixSort_295:
    ldr	w9,	[sp, #540]

    cmp	w16,	w9
    bge	radixSort_302

radixSort_299:
    asr	w12,	w10,	#31
    add	w16,	w16,	#1
    lsr	w14,	w12,	#28
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
    mov	x2,	x8
    add	x2,	sp,	x2
    add	x2,	x2,	#224

radixSort_305:
    ldr	w16,	[sp, #540]

    cmp	w14,	w16
    bge	radixSort_312

radixSort_309:
    asr	w7,	w6,	#31
    add	w14,	w14,	#1
    lsr	w8,	w7,	#28
    add	w4,	w6,	w8
    asr	w6,	w4,	#4
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
    mov	x12,	x14
    add	x12,	sp,	x12
    add	x12,	x12,	#224
    ldr	w16,	[x12]

    add	w17,	w16,	#1
    str	w17,	[x2]

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
    mov	w0,	w4
    movz	w18,	#0

radixSort_99:
    cmp	w18,	w27
    bge	radixSort_106

radixSort_103:
    asr	w12,	w0,	#31
    add	w18,	w18,	#1
    lsr	w16,	w12,	#28
    add	w2,	w0,	w16
    asr	w0,	w2,	#4
    b	radixSort_99

radixSort_106:
    asr	w15,	w0,	#31
    movz	fp,	#532
    movz	w5,	#0
    lsr	w16,	w15,	#28
    mov	w15,	w4
    add	w18,	w0,	w16
    asr	w26,	w18,	#4
    lsl	w2,	w26,	#4
    sub	w18,	w0,	w2
    lsl	w23,	w18,	#2
    mov	x21,	x23
    add	x21,	sp,	x21
    add	x21,	x21,	#288
    ldr	w26,	[x21]

    ldr	x16,	[sp, fp]

    lsl	w7,	w26,	#2
    add	x0,	x16,	x7
    ldr	w0,	[x0]


radixSort_112:
    cmp	w5,	w27
    bge	radixSort_119

radixSort_116:
    asr	w6,	w15,	#31
    add	w5,	w5,	#1
    lsr	w18,	w6,	#28
    add	w15,	w15,	w18
    asr	w15,	w15,	#4
    b	radixSort_112

radixSort_119:
    asr	w18,	w15,	#31
    movz	fp,	#532
    lsr	w20,	w18,	#28
    mov	w18,	w4
    add	w23,	w15,	w20
    asr	w5,	w23,	#4
    lsl	w12,	w5,	#4
    sub	w11,	w15,	w12
    lsl	w15,	w11,	#2
    mov	x12,	x15
    add	x12,	sp,	x12
    add	x12,	x12,	#288
    ldr	w16,	[x12]

    ldr	x11,	[sp, fp]

    lsl	w22,	w16,	#2
    movz	w16,	#0
    add	x19,	x11,	x22
    str	w4,	[x19]


radixSort_124:
    cmp	w16,	w27
    bge	radixSort_131

radixSort_128:
    asr	w6,	w18,	#31
    add	w16,	w16,	#1
    lsr	w7,	w6,	#28
    add	w3,	w18,	w7
    asr	w18,	w3,	#4
    b	radixSort_124

radixSort_131:
    asr	w12,	w18,	#31
    mov	w6,	w4
    movz	w8,	#0
    lsr	w16,	w12,	#28
    add	w19,	w18,	w16
    asr	w20,	w19,	#4
    lsl	w5,	w20,	#4
    sub	w11,	w18,	w5
    lsl	w16,	w11,	#2
    mov	x21,	x16
    add	x21,	sp,	x21
    add	x21,	x21,	#288

radixSort_134:
    cmp	w8,	w27
    bge	radixSort_141

radixSort_138:
    asr	w20,	w6,	#31
    add	w8,	w8,	#1
    lsr	w4,	w20,	#28
    add	w15,	w6,	w4
    asr	w6,	w15,	#4
    b	radixSort_134

radixSort_141:
    asr	w16,	w6,	#31
    lsr	w18,	w16,	#28
    add	w4,	w6,	w18
    asr	w15,	w4,	#4
    lsl	w16,	w15,	#4
    sub	w12,	w6,	w16
    lsl	w4,	w12,	#2
    mov	x15,	x4
    mov	w4,	w0
    add	x15,	sp,	x15
    add	x15,	x15,	#288
    ldr	w5,	[x15]

    add	w6,	w5,	#1
    str	w6,	[x21]

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


