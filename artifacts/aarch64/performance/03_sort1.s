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
    sub	sp, sp, #624
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w26,	w3
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
    movz	w23,	#65535
    movk	w23,	#65535,	lsl #16
    mov	w22,	w23
    cmp	w27,	w22
    beq	radixSort_360

radixSort_15:
    add	w14,	w24,	#1
    cmp	w14,	w26
    bge	radixSort_360

radixSort_18:
    cmp	w24,	w26
    bge	radixSort_52

radixSort_20:
    mov	w6,	w24

radixSort_22:
    lsl	w7,	w6,	#2
    movz	fp,	#532
    movz	w11,	#0
    ldr	x18,	[sp, fp]

    add	x4,	x18,	x7
    ldr	w14,	[x4]

    mov	w0,	w14

radixSort_26:
    cmp	w11,	w27
    bge	radixSort_33

radixSort_30:
    asr	w7,	w0,	#31
    add	w11,	w11,	#1
    lsr	w9,	w7,	#28
    add	w21,	w0,	w9
    asr	w0,	w21,	#4
    b	radixSort_26

radixSort_33:
    asr	w23,	w0,	#31
    lsr	w3,	w23,	#28
    add	w4,	w0,	w3
    asr	w5,	w4,	#4
    lsl	w7,	w5,	#4
    sub	w3,	w0,	w7
    lsl	w7,	w3,	#2
    movz	w3,	#0
    mov	x11,	x7
    add	x11,	sp,	x11
    add	x11,	x11,	#416

radixSort_36:
    cmp	w3,	w27
    bge	radixSort_43

radixSort_40:
    asr	w18,	w14,	#31
    add	w3,	w3,	#1
    lsr	w19,	w18,	#28
    add	w9,	w14,	w19
    asr	w14,	w9,	#4
    b	radixSort_36

radixSort_43:
    asr	w0,	w14,	#31
    add	w6,	w6,	#1
    lsr	w1,	w0,	#28
    add	w2,	w14,	w1
    asr	w9,	w2,	#4
    lsl	w12,	w9,	#4
    sub	w3,	w14,	w12
    lsl	w5,	w3,	#2
    mov	x4,	x5
    add	x4,	sp,	x4
    add	x4,	x4,	#416
    ldr	w8,	[x4]

    add	w9,	w8,	#1
    str	w9,	[x11]

    cmp	w6,	w26
    blt	radixSort_22

radixSort_52:
    add	x2,	sp,	#288
    add	x7,	sp,	#352
    add	x28,	sp,	#416
    movz	w6,	#1
    str	w24,	[x2]

    ldr	w17,	[x28]

    add	w18,	w17,	w24
    str	w18,	[x7]


radixSort_58:
    cmp	w6,	#16
    bge	radixSort_71

radixSort_61:
    lsl	w9,	w6,	#2
    sub	w11,	w6,	#1
    lsl	w16,	w6,	#2
    lsl	w18,	w6,	#2
    mov	x19,	x9
    mov	x1,	x16
    lsl	w13,	w11,	#2
    add	w6,	w6,	#1
    mov	x17,	x18
    add	x19,	sp,	x19
    add	x1,	sp,	x1
    mov	x12,	x13
    add	x17,	sp,	x17
    add	x12,	sp,	x12
    add	x19,	x19,	#288
    add	x1,	x1,	#352
    add	x17,	x17,	#416
    add	x12,	x12,	#352
    ldr	w5,	[x12]

    str	w5,	[x19]

    ldr	w19,	[x17]

    add	w20,	w19,	w5
    str	w20,	[x1]

    b	radixSort_58

radixSort_71:
    movz	w8,	#0

radixSort_73:
    lsl	w1,	w8,	#2
    lsl	w12,	w8,	#2
    mov	x0,	x1
    mov	x9,	x12
    add	x0,	sp,	x0
    add	x9,	sp,	x9
    add	x0,	x0,	#288
    add	x9,	x9,	#352
    ldr	w18,	[x0]

    ldr	w15,	[x9]

    cmp	w18,	w15
    bge	radixSort_153

radixSort_82:
    lsl	w19,	w18,	#2
    movz	fp,	#532
    ldr	x10,	[sp, fp]

    add	x17,	x10,	x19
    ldr	w21,	[x17]


radixSort_86:
    mov	w3,	w21
    movz	w9,	#0

radixSort_88:
    cmp	w9,	w27
    bge	radixSort_95

radixSort_92:
    asr	w14,	w3,	#31
    add	w9,	w9,	#1
    lsr	w16,	w14,	#28
    add	w13,	w3,	w16
    asr	w3,	w13,	#4
    b	radixSort_88

radixSort_95:
    asr	w14,	w3,	#31
    lsr	w16,	w14,	#28
    add	w18,	w3,	w16
    asr	w23,	w18,	#4
    lsl	w26,	w23,	#4
    sub	w18,	w3,	w26
    cmp	w18,	w8
    bne	radixSort_98

radixSort_146:
    ldr	w20,	[x0]

    movz	fp,	#532
    add	w18,	w20,	#1
    lsl	w1,	w20,	#2
    ldr	x11,	[sp, fp]

    add	x23,	x11,	x1
    str	w21,	[x23]

    str	w18,	[x0]

    cmp	w18,	w15
    blt	radixSort_82

radixSort_153:
    add	w8,	w8,	#1
    cmp	w8,	#16
    blt	radixSort_73

radixSort_156:
    str	w24,	[x2]

    sub	w5,	w27,	#1
    add	x21,	sp,	#224
    add	x20,	sp,	#160
    add	x10,	sp,	#224
    add	x0,	sp,	#160
    add	x25,	sp,	#96
    movz	w19,	#0
    ldr	w2,	[x28]

    add	x28,	sp,	#96
    add	w26,	w2,	w24
    str	w26,	[x7]

    str	w5,	[sp, #540]

    str	x10,	[sp, #616]

    str	x0,	[sp, #560]

    str	x25,	[sp, #552]

    ldr	w3,	[sp, #540]

    str	w19,	[sp, #480]

    sub	w24,	w3,	#1

radixSort_168:
    ldr	w6,	[sp, #480]

    cmp	w6,	#0
    ble	radixSort_180

radixSort_171:
    ldr	w7,	[sp, #480]

    ldr	w27,	[sp, #480]

    lsl	w4,	w7,	#2
    sub	w17,	w27,	#1
    mov	x9,	x4
    add	x9,	sp,	x9
    lsl	w23,	w17,	#2
    add	x9,	x9,	#288
    mov	x18,	x23
    add	x18,	sp,	x18
    add	x18,	x18,	#352
    ldr	w23,	[x18]

    str	w23,	[x9]

    ldr	w0,	[sp, #480]

    ldr	w12,	[sp, #480]

    lsl	w0,	w0,	#2
    lsl	w10,	w12,	#2
    mov	x4,	x0
    mov	x5,	x10
    add	x4,	sp,	x4
    add	x5,	sp,	x5
    add	x4,	x4,	#352
    add	x5,	x5,	#416
    ldr	w0,	[x5]

    add	w1,	w0,	w23
    str	w1,	[x4]

    b	radixSort_183

radixSort_180:
    ldr	w11,	[sp, #480]

    ldr	w3,	[sp, #480]

    lsl	w16,	w11,	#2
    lsl	w8,	w3,	#2
    mov	x9,	x16
    mov	x4,	x8
    add	x9,	sp,	x9
    add	x4,	sp,	x4
    add	x9,	x9,	#288
    add	x4,	x4,	#352

radixSort_183:
    ldr	w19,	[x9]

    mov	x0,	x21
    movz	w1,	#0
    movz	w2,	#64
    str	w19,	[sp, #544]

    ldr	w23,	[x4]

    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x20
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x28
    bl	memset
    ldr	w9,	[sp, #540]

    mov	x12,	x22
    cmp	w9,	w12
    beq	radixSort_354

radixSort_189:
    ldr	w9,	[sp, #544]

    add	w9,	w9,	#1
    cmp	w9,	w23
    bge	radixSort_354

radixSort_192:
    ldr	w10,	[sp, #544]

    cmp	w10,	w23
    bge	radixSort_226

radixSort_194:
    ldr	w5,	[sp, #544]


radixSort_196:
    lsl	w2,	w5,	#2
    movz	fp,	#532
    ldr	x26,	[sp, fp]

    add	x1,	x26,	x2
    ldr	w10,	[x1]

    movz	w1,	#0
    mov	w15,	w10

radixSort_200:
    ldr	w2,	[sp, #540]

    cmp	w1,	w2
    bge	radixSort_207

radixSort_204:
    asr	w13,	w15,	#31
    add	w1,	w1,	#1
    lsr	w14,	w13,	#28
    add	w9,	w15,	w14
    asr	w15,	w9,	#4
    b	radixSort_200

radixSort_207:
    asr	w8,	w15,	#31
    movz	w18,	#0
    lsr	w9,	w8,	#28
    add	w12,	w15,	w9
    asr	w14,	w12,	#4
    lsl	w17,	w14,	#4
    sub	w3,	w15,	w17
    lsl	w7,	w3,	#2
    mov	x4,	x7
    add	x4,	sp,	x4
    add	x4,	x4,	#96

radixSort_210:
    ldr	w1,	[sp, #540]

    cmp	w18,	w1
    bge	radixSort_217

radixSort_214:
    asr	w27,	w10,	#31
    add	w18,	w18,	#1
    lsr	w0,	w27,	#28
    add	w14,	w10,	w0
    asr	w10,	w14,	#4
    b	radixSort_210

radixSort_217:
    asr	w17,	w10,	#31
    add	w5,	w5,	#1
    lsr	w18,	w17,	#28
    add	w26,	w10,	w18
    asr	w26,	w26,	#4
    lsl	w27,	w26,	#4
    sub	w12,	w10,	w27
    lsl	w14,	w12,	#2
    mov	x13,	x14
    add	x13,	sp,	x13
    add	x13,	x13,	#96
    ldr	w15,	[x13]

    add	w16,	w15,	#1
    str	w16,	[x4]

    cmp	w5,	w23
    blt	radixSort_196

radixSort_226:
    ldr	w12,	[sp, #544]

    movz	w10,	#1
    ldr	x15,	[sp, #616]

    str	w12,	[x15]

    ldr	x2,	[sp, #552]

    ldr	w14,	[x2]

    ldr	w13,	[sp, #544]

    ldr	x26,	[sp, #560]

    add	w12,	w14,	w13
    str	w12,	[x26]


radixSort_229:
    cmp	w10,	#16
    bge	radixSort_242

radixSort_232:
    lsl	w6,	w10,	#2
    sub	w7,	w10,	#1
    lsl	w16,	w10,	#2
    lsl	w18,	w10,	#2
    mov	x11,	x6
    mov	x15,	x16
    lsl	w9,	w7,	#2
    add	w10,	w10,	#1
    mov	x17,	x18
    add	x11,	sp,	x11
    add	x15,	sp,	x15
    mov	x8,	x9
    add	x17,	sp,	x17
    add	x8,	sp,	x8
    add	x11,	x11,	#224
    add	x15,	x15,	#160
    add	x17,	x17,	#96
    add	x8,	x8,	#160
    ldr	w2,	[x8]

    str	w2,	[x11]

    ldr	w23,	[x17]

    add	w26,	w23,	w2
    str	w26,	[x15]

    b	radixSort_229

radixSort_242:
    movz	w16,	#0
    mov	w15,	w16

radixSort_244:
    lsl	w1,	w15,	#2
    lsl	w2,	w15,	#2
    mov	x26,	x1
    mov	x1,	x2
    add	x26,	sp,	x26
    add	x1,	sp,	x1
    add	x26,	x26,	#224
    add	x1,	x1,	#160
    ldr	w6,	[x26]

    ldr	w14,	[x1]

    cmp	w6,	w14
    bge	radixSort_324

radixSort_253:
    lsl	w6,	w6,	#2
    movz	fp,	#532
    ldr	x9,	[sp, fp]

    add	x5,	x9,	x6
    ldr	w7,	[x5]

    mov	w8,	w7

radixSort_257:
    mov	w7,	w8
    movz	w10,	#0

radixSort_259:
    ldr	w2,	[sp, #540]

    cmp	w10,	w2
    bge	radixSort_266

radixSort_263:
    asr	w0,	w7,	#31
    add	w10,	w10,	#1
    lsr	w1,	w0,	#28
    add	w1,	w7,	w1
    asr	w7,	w1,	#4
    b	radixSort_259

radixSort_266:
    asr	w2,	w7,	#31
    lsr	w3,	w2,	#28
    add	w4,	w7,	w3
    asr	w11,	w4,	#4
    lsl	w13,	w11,	#4
    sub	w0,	w7,	w13
    cmp	w0,	w15
    bne	radixSort_269

radixSort_317:
    ldr	w13,	[x26]

    movz	fp,	#532
    add	w6,	w13,	#1
    lsl	w2,	w13,	#2
    ldr	x9,	[sp, fp]

    add	x1,	x9,	x2
    str	w8,	[x1]

    str	w6,	[x26]

    cmp	w6,	w14
    blt	radixSort_253

radixSort_324:
    add	w16,	w15,	#1
    cmp	w16,	#16
    blt	radixSort_243

radixSort_327:
    ldr	w2,	[sp, #544]

    movz	w7,	#0
    ldr	x9,	[sp, #616]

    mov	w23,	w7
    str	w2,	[x9]

    ldr	x27,	[sp, #560]

    str	w12,	[x27]


radixSort_329:
    cmp	w23,	#0
    ble	radixSort_341

radixSort_332:
    lsl	w14,	w23,	#2
    sub	w17,	w23,	#1
    lsl	w1,	w23,	#2
    mov	x7,	x14
    mov	x0,	x1
    add	x7,	sp,	x7
    lsl	w26,	w17,	#2
    add	x0,	sp,	x0
    mov	x18,	x26
    add	x7,	x7,	#224
    add	x18,	sp,	x18
    add	x0,	x0,	#160
    add	x18,	x18,	#160
    ldr	w9,	[x18]

    lsl	w18,	w23,	#2
    str	w9,	[x7]

    mov	x17,	x18
    add	x17,	sp,	x17
    add	x17,	x17,	#96
    ldr	w26,	[x17]

    add	w27,	w26,	w9
    str	w27,	[x0]

    b	radixSort_344

radixSort_341:
    lsl	w6,	w23,	#2
    lsl	w11,	w23,	#2
    mov	x7,	x6
    mov	x0,	x11
    add	x7,	sp,	x7
    add	x0,	sp,	x0
    add	x7,	x7,	#224
    add	x0,	x0,	#160

radixSort_344:
    ldr	w2,	[x7]

    movz	fp,	#532
    ldr	w3,	[x0]

    ldr	x1,	[sp, fp]

    mov	w0,	w24
    bl	radixSort
    add	w17,	w23,	#1
    cmp	w17,	#16
    bge	radixSort_354

radixSort_328:
    mov	w23,	w17
    b	radixSort_329

radixSort_243:
    mov	w15,	w16
    b	radixSort_244

radixSort_269:
    mov	w4,	w8
    movz	w1,	#0

radixSort_270:
    ldr	w5,	[sp, #540]

    cmp	w1,	w5
    bge	radixSort_277

radixSort_274:
    asr	w11,	w4,	#31
    add	w1,	w1,	#1
    lsr	w13,	w11,	#28
    add	w10,	w4,	w13
    asr	w4,	w10,	#4
    b	radixSort_270

radixSort_277:
    asr	w13,	w4,	#31
    movz	fp,	#532
    lsr	w16,	w13,	#28
    add	w23,	w4,	w16
    movz	w16,	#0
    mov	w18,	w16
    asr	w10,	w23,	#4
    lsl	w11,	w10,	#4
    mov	w10,	w8
    sub	w1,	w4,	w11
    lsl	w3,	w1,	#2
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#224
    ldr	w4,	[x2]

    ldr	x7,	[sp, fp]

    lsl	w6,	w4,	#2
    add	x5,	x7,	x6
    ldr	w2,	[x5]


radixSort_283:
    ldr	w19,	[sp, #540]

    cmp	w18,	w19
    bge	radixSort_290

radixSort_287:
    asr	w13,	w10,	#31
    add	w16,	w18,	#1
    mov	w18,	w16
    lsr	w17,	w13,	#28
    add	w1,	w10,	w17
    asr	w10,	w1,	#4
    b	radixSort_283

radixSort_290:
    asr	w4,	w10,	#31
    movz	fp,	#532
    movz	w1,	#0
    lsr	w5,	w4,	#28
    add	w6,	w10,	w5
    asr	w7,	w6,	#4
    lsl	w11,	w7,	#4
    sub	w6,	w10,	w11
    lsl	w10,	w6,	#2
    mov	w6,	w1
    mov	x7,	x10
    add	x7,	sp,	x7
    add	x7,	x7,	#224
    ldr	w11,	[x7]

    mov	w7,	w8
    ldr	x13,	[sp, fp]

    lsl	w16,	w11,	#2
    add	x13,	x13,	x16
    str	w8,	[x13]


radixSort_295:
    ldr	w23,	[sp, #540]

    cmp	w6,	w23
    bge	radixSort_302

radixSort_299:
    asr	w1,	w7,	#31
    lsr	w4,	w1,	#28
    add	w1,	w6,	#1
    add	w13,	w7,	w4
    mov	w6,	w1
    asr	w7,	w13,	#4
    b	radixSort_295

radixSort_302:
    asr	w17,	w7,	#31
    movz	w13,	#0
    lsr	w27,	w17,	#28
    add	w1,	w7,	w27
    asr	w27,	w1,	#4
    lsl	w1,	w27,	#4
    sub	w10,	w7,	w1
    lsl	w1,	w10,	#2
    mov	x27,	x1
    add	x27,	sp,	x27
    add	x27,	x27,	#224

radixSort_305:
    ldr	w7,	[sp, #540]

    cmp	w13,	w7
    bge	radixSort_312

radixSort_309:
    asr	w11,	w8,	#31
    add	w13,	w13,	#1
    lsr	w17,	w11,	#28
    add	w0,	w8,	w17
    asr	w8,	w0,	#4
    b	radixSort_305

radixSort_312:
    asr	w1,	w8,	#31
    lsr	w4,	w1,	#28
    add	w5,	w8,	w4
    asr	w0,	w5,	#4
    lsl	w1,	w0,	#4
    sub	w7,	w8,	w1
    lsl	w9,	w7,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	#224
    ldr	w10,	[x8]

    mov	w8,	w2
    add	w11,	w10,	#1
    str	w11,	[x27]

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
    mov	w18,	w21
    movz	w26,	#0

radixSort_99:
    cmp	w26,	w27
    bge	radixSort_106

radixSort_103:
    asr	w4,	w18,	#31
    add	w26,	w26,	#1
    lsr	w5,	w4,	#28
    add	w11,	w18,	w5
    asr	w18,	w11,	#4
    b	radixSort_99

radixSort_106:
    asr	w12,	w18,	#31
    movz	fp,	#532
    lsr	w16,	w12,	#28
    add	w3,	w18,	w16
    mov	w16,	w21
    asr	w3,	w3,	#4
    lsl	w5,	w3,	#4
    sub	w3,	w18,	w5
    lsl	w10,	w3,	#2
    mov	x6,	x10
    add	x6,	sp,	x6
    add	x6,	x6,	#288
    ldr	w11,	[x6]

    movz	w6,	#0
    ldr	x19,	[sp, fp]

    lsl	w3,	w11,	#2
    add	x14,	x19,	x3
    ldr	w1,	[x14]


radixSort_112:
    cmp	w6,	w27
    bge	radixSort_119

radixSort_116:
    asr	w14,	w16,	#31
    add	w6,	w6,	#1
    lsr	w17,	w14,	#28
    add	w11,	w16,	w17
    asr	w16,	w11,	#4
    b	radixSort_112

radixSort_119:
    asr	w10,	w16,	#31
    movz	fp,	#532
    mov	w4,	w21
    lsr	w13,	w10,	#28
    add	w14,	w16,	w13
    asr	w13,	w14,	#4
    lsl	w14,	w13,	#4
    sub	w6,	w16,	w14
    lsl	w10,	w6,	#2
    movz	w6,	#0
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#288
    ldr	w13,	[x9]

    ldr	x14,	[sp, fp]

    lsl	w17,	w13,	#2
    add	x14,	x14,	x17
    str	w21,	[x14]


radixSort_124:
    cmp	w6,	w27
    bge	radixSort_131

radixSort_128:
    asr	w3,	w4,	#31
    add	w6,	w6,	#1
    lsr	w5,	w3,	#28
    add	w20,	w4,	w5
    asr	w4,	w20,	#4
    b	radixSort_124

radixSort_131:
    asr	w26,	w4,	#31
    movz	w9,	#0
    lsr	w3,	w26,	#28
    add	w5,	w4,	w3
    asr	w11,	w5,	#4
    lsl	w14,	w11,	#4
    sub	w23,	w4,	w14
    lsl	w3,	w23,	#2
    mov	x14,	x3
    add	x14,	sp,	x14
    add	x14,	x14,	#288

radixSort_134:
    cmp	w9,	w27
    bge	radixSort_141

radixSort_138:
    asr	w23,	w21,	#31
    add	w9,	w9,	#1
    lsr	w4,	w23,	#28
    add	w17,	w21,	w4
    asr	w21,	w17,	#4
    b	radixSort_134

radixSort_141:
    asr	w16,	w21,	#31
    lsr	w19,	w16,	#28
    add	w4,	w21,	w19
    asr	w17,	w4,	#4
    lsl	w19,	w17,	#4
    sub	w17,	w21,	w19
    mov	w21,	w1
    lsl	w4,	w17,	#2
    mov	x18,	x4
    add	x18,	sp,	x18
    add	x18,	x18,	#288
    ldr	w6,	[x18]

    add	w9,	w6,	#1
    str	w9,	[x14]

    b	radixSort_86

radixSort_360:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #624
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

    sdiv	w18,	w10,	w7
    msub	w19,	w18,	w7,	w10

    mul	w15,	w18,	w7
    madd	w24,	w19,	w16,	w24

    mul	w3,	w19,	w16
    add	w16,	w16,	#1
    b	main_3

main_15:
    movz	w19,	#0
    sub	w25,	w19,	w24
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


