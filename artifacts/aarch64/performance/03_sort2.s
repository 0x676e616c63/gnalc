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
    add	x12,	sp,	#288
    add	x26,	sp,	#352
    add	x5,	sp,	#416
    movz	w4,	#1
    str	w24,	[x12]

    ldr	w17,	[x5]

    add	w18,	w17,	w24
    str	w18,	[x26]


radixSort_58:
    cmp	w4,	#16
    bge	radixSort_71

radixSort_61:
    lsl	w8,	w4,	#2
    sub	w9,	w4,	#1
    lsl	w16,	w4,	#2
    mov	x18,	x8
    mov	x1,	x16
    add	x18,	sp,	x18
    lsl	w11,	w9,	#2
    add	x1,	sp,	x1
    mov	x10,	x11
    add	x18,	x18,	#288
    add	x10,	sp,	x10
    add	x1,	x1,	#352
    add	x10,	x10,	#352
    ldr	w3,	[x10]

    str	w3,	[x18]

    lsl	w18,	w4,	#2
    add	w4,	w4,	#1
    mov	x17,	x18
    add	x17,	sp,	x17
    add	x17,	x17,	#416
    ldr	w19,	[x17]

    add	w20,	w19,	w3
    str	w20,	[x1]

    b	radixSort_58

radixSort_71:
    movz	w13,	#0

radixSort_73:
    lsl	w1,	w13,	#2
    lsl	w4,	w13,	#2
    mov	x20,	x1
    mov	x3,	x4
    add	x20,	sp,	x20
    add	x3,	sp,	x3
    add	x20,	x20,	#288
    add	x3,	x3,	#352
    ldr	w14,	[x20]

    ldr	w9,	[x3]

    cmp	w14,	w9
    bge	radixSort_153

radixSort_82:
    lsl	w15,	w14,	#2
    movz	fp,	#532
    ldr	x7,	[sp, fp]

    add	x11,	x7,	x15
    ldr	w21,	[x11]


radixSort_86:
    mov	w0,	w21
    movz	w3,	#0

radixSort_88:
    cmp	w3,	w27
    bge	radixSort_95

radixSort_92:
    asr	w14,	w0,	#31
    add	w3,	w3,	#1
    lsr	w15,	w14,	#28
    add	w6,	w0,	w15
    asr	w0,	w6,	#4
    b	radixSort_88

radixSort_95:
    asr	w8,	w0,	#31
    lsr	w10,	w8,	#28
    add	w14,	w0,	w10
    asr	w19,	w14,	#4
    lsl	w23,	w19,	#4
    sub	w14,	w0,	w23
    cmp	w14,	w13
    bne	radixSort_98

radixSort_146:
    ldr	w15,	[x20]

    movz	fp,	#532
    add	w14,	w15,	#1
    lsl	w28,	w15,	#2
    ldr	x8,	[sp, fp]

    add	x19,	x8,	x28
    str	w21,	[x19]

    str	w14,	[x20]

    cmp	w14,	w9
    blt	radixSort_82

radixSort_153:
    add	w13,	w13,	#1
    cmp	w13,	#16
    blt	radixSort_73

radixSort_156:
    str	w24,	[x12]

    add	x21,	sp,	#224
    add	x20,	sp,	#160
    add	x28,	sp,	#96
    add	x10,	sp,	#224
    movz	fp,	#604
    add	x0,	sp,	#160
    add	x25,	sp,	#96
    movz	w19,	#0
    ldr	w2,	[x5]

    sub	w5,	w27,	#1
    add	w23,	w2,	w24
    str	w23,	[x26]

    str	w5,	[sp, #540]

    str	x10,	[sp, fp]

    movz	fp,	#548
    str	x0,	[sp, fp]

    movz	fp,	#612
    str	x25,	[sp, fp]

    ldr	w3,	[sp, #540]

    str	w19,	[sp, #488]

    sub	w24,	w3,	#1

radixSort_168:
    ldr	w6,	[sp, #488]

    cmp	w6,	#0
    ble	radixSort_180

radixSort_171:
    ldr	w7,	[sp, #488]

    ldr	w27,	[sp, #488]

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

    ldr	w0,	[sp, #488]

    ldr	w12,	[sp, #488]

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
    ldr	w11,	[sp, #488]

    ldr	w3,	[sp, #488]

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

    movz	fp,	#604
    ldr	x15,	[sp, fp]

    movz	fp,	#612
    str	w12,	[x15]

    movz	w12,	#1
    ldr	x2,	[sp, fp]

    movz	fp,	#548
    ldr	w14,	[x2]

    ldr	w13,	[sp, #544]

    ldr	x26,	[sp, fp]

    add	w0,	w14,	w13
    str	w0,	[x26]


radixSort_229:
    cmp	w12,	#16
    bge	radixSort_242

radixSort_232:
    lsl	w8,	w12,	#2
    sub	w9,	w12,	#1
    lsl	w16,	w12,	#2
    lsl	w18,	w12,	#2
    mov	x13,	x8
    mov	x15,	x16
    lsl	w11,	w9,	#2
    add	w12,	w12,	#1
    mov	x17,	x18
    add	x13,	sp,	x13
    add	x15,	sp,	x15
    mov	x10,	x11
    add	x17,	sp,	x17
    add	x10,	sp,	x10
    add	x13,	x13,	#224
    add	x15,	x15,	#160
    add	x17,	x17,	#96
    add	x10,	x10,	#160
    ldr	w4,	[x10]

    str	w4,	[x13]

    ldr	w23,	[x17]

    add	w26,	w23,	w4
    str	w26,	[x15]

    b	radixSort_229

radixSort_242:
    movz	w17,	#0
    mov	w16,	w17

radixSort_244:
    lsl	w3,	w16,	#2
    lsl	w4,	w16,	#2
    mov	x26,	x3
    mov	x3,	x4
    add	x26,	sp,	x26
    add	x3,	sp,	x3
    add	x26,	x26,	#224
    add	x3,	x3,	#160
    ldr	w8,	[x26]

    ldr	w15,	[x3]

    cmp	w8,	w15
    bge	radixSort_324

radixSort_253:
    lsl	w8,	w8,	#2
    movz	fp,	#532
    ldr	x10,	[sp, fp]

    add	x7,	x10,	x8
    ldr	w8,	[x7]

    mov	w9,	w8

radixSort_257:
    mov	w8,	w9
    movz	w12,	#0

radixSort_259:
    ldr	w3,	[sp, #540]

    cmp	w12,	w3
    bge	radixSort_266

radixSort_263:
    asr	w2,	w8,	#31
    add	w12,	w12,	#1
    lsr	w3,	w2,	#28
    add	w3,	w8,	w3
    asr	w8,	w3,	#4
    b	radixSort_259

radixSort_266:
    asr	w4,	w8,	#31
    lsr	w5,	w4,	#28
    add	w6,	w8,	w5
    asr	w13,	w6,	#4
    lsl	w14,	w13,	#4
    sub	w1,	w8,	w14
    cmp	w1,	w16
    bne	radixSort_269

radixSort_317:
    ldr	w13,	[x26]

    movz	fp,	#532
    add	w8,	w13,	#1
    lsl	w4,	w13,	#2
    ldr	x10,	[sp, fp]

    add	x3,	x10,	x4
    str	w9,	[x3]

    str	w8,	[x26]

    cmp	w8,	w15
    blt	radixSort_253

radixSort_324:
    add	w17,	w16,	#1
    cmp	w17,	#16
    blt	radixSort_243

radixSort_327:
    ldr	w3,	[sp, #544]

    movz	fp,	#604
    movz	w7,	#0
    ldr	x10,	[sp, fp]

    mov	w23,	w7
    movz	fp,	#548
    str	w3,	[x10]

    ldr	x27,	[sp, fp]

    str	w0,	[x27]


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
    mov	w16,	w17
    b	radixSort_244

radixSort_269:
    mov	w6,	w9
    movz	w2,	#0

radixSort_270:
    ldr	w5,	[sp, #540]

    cmp	w2,	w5
    bge	radixSort_277

radixSort_274:
    asr	w13,	w6,	#31
    add	w2,	w2,	#1
    lsr	w14,	w13,	#28
    add	w12,	w6,	w14
    asr	w6,	w12,	#4
    b	radixSort_270

radixSort_277:
    asr	w14,	w6,	#31
    movz	fp,	#532
    mov	w11,	w9
    lsr	w17,	w14,	#28
    add	w18,	w6,	w17
    movz	w17,	#0
    mov	w23,	w17
    asr	w12,	w18,	#4
    lsl	w13,	w12,	#4
    sub	w3,	w6,	w13
    lsl	w5,	w3,	#2
    mov	x4,	x5
    add	x4,	sp,	x4
    add	x4,	x4,	#224
    ldr	w6,	[x4]

    ldr	x7,	[sp, fp]

    lsl	w10,	w6,	#2
    add	x7,	x7,	x10
    ldr	w3,	[x7]


radixSort_283:
    ldr	w18,	[sp, #540]

    cmp	w23,	w18
    bge	radixSort_290

radixSort_287:
    asr	w14,	w11,	#31
    add	w17,	w23,	#1
    mov	w23,	w17
    lsr	w18,	w14,	#28
    add	w5,	w11,	w18
    asr	w11,	w5,	#4
    b	radixSort_283

radixSort_290:
    asr	w6,	w11,	#31
    movz	fp,	#532
    movz	w1,	#0
    lsr	w7,	w6,	#28
    mov	w4,	w1
    add	w8,	w11,	w7
    asr	w12,	w8,	#4
    lsl	w13,	w12,	#4
    sub	w8,	w11,	w13
    lsl	w12,	w8,	#2
    mov	w8,	w9
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#224
    ldr	w13,	[x11]

    lsl	w17,	w13,	#2
    ldr	x13,	[sp, fp]

    add	x14,	x13,	x17
    str	w9,	[x14]


radixSort_295:
    ldr	w23,	[sp, #540]

    cmp	w4,	w23
    bge	radixSort_302

radixSort_299:
    asr	w5,	w8,	#31
    add	w1,	w4,	#1
    mov	w4,	w1
    lsr	w6,	w5,	#28
    add	w14,	w8,	w6
    asr	w8,	w14,	#4
    b	radixSort_295

radixSort_302:
    asr	w18,	w8,	#31
    movz	w13,	#0
    lsr	w23,	w18,	#28
    add	w1,	w8,	w23
    asr	w23,	w1,	#4
    lsl	w1,	w23,	#4
    sub	w11,	w8,	w1
    lsl	w5,	w11,	#2
    mov	x14,	x5
    add	x14,	sp,	x14
    add	x14,	x14,	#224

radixSort_305:
    ldr	w8,	[sp, #540]

    cmp	w13,	w8
    bge	radixSort_312

radixSort_309:
    asr	w17,	w9,	#31
    add	w13,	w13,	#1
    lsr	w18,	w17,	#28
    add	w2,	w9,	w18
    asr	w9,	w2,	#4
    b	radixSort_305

radixSort_312:
    asr	w5,	w9,	#31
    lsr	w6,	w5,	#28
    add	w7,	w9,	w6
    asr	w2,	w7,	#4
    lsl	w5,	w2,	#4
    sub	w9,	w9,	w5
    lsl	w11,	w9,	#2
    mov	w9,	w3
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#224
    ldr	w12,	[x10]

    add	w13,	w12,	#1
    str	w13,	[x14]

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
    mov	w14,	w21
    movz	w23,	#0

radixSort_99:
    cmp	w23,	w27
    bge	radixSort_106

radixSort_103:
    asr	w2,	w14,	#31
    add	w23,	w23,	#1
    lsr	w3,	w2,	#28
    add	w8,	w14,	w3
    asr	w14,	w8,	#4
    b	radixSort_99

radixSort_106:
    asr	w10,	w14,	#31
    movz	fp,	#532
    mov	w15,	w21
    movz	w2,	#0
    lsr	w16,	w10,	#28
    add	w0,	w14,	w16
    asr	w0,	w0,	#4
    lsl	w1,	w0,	#4
    sub	w1,	w14,	w1
    lsl	w7,	w1,	#2
    mov	x4,	x7
    add	x4,	sp,	x4
    add	x4,	x4,	#288
    ldr	w8,	[x4]

    ldr	x18,	[sp, fp]

    lsl	w0,	w8,	#2
    add	x14,	x18,	x0
    ldr	w0,	[x14]


radixSort_112:
    cmp	w2,	w27
    bge	radixSort_119

radixSort_116:
    asr	w7,	w15,	#31
    add	w2,	w2,	#1
    lsr	w10,	w7,	#28
    add	w6,	w15,	w10
    asr	w15,	w6,	#4
    b	radixSort_112

radixSort_119:
    asr	w4,	w15,	#31
    movz	fp,	#532
    lsr	w6,	w4,	#28
    add	w8,	w15,	w6
    asr	w11,	w8,	#4
    lsl	w14,	w11,	#4
    sub	w2,	w15,	w14
    lsl	w4,	w2,	#2
    mov	w2,	w21
    mov	x3,	x4
    movz	w4,	#0
    add	x3,	sp,	x3
    add	x3,	x3,	#288
    ldr	w6,	[x3]

    ldr	x14,	[sp, fp]

    lsl	w10,	w6,	#2
    add	x8,	x14,	x10
    str	w21,	[x8]


radixSort_124:
    cmp	w4,	w27
    bge	radixSort_131

radixSort_128:
    asr	w28,	w2,	#31
    add	w4,	w4,	#1
    lsr	w1,	w28,	#28
    add	w16,	w2,	w1
    asr	w2,	w16,	#4
    b	radixSort_124

radixSort_131:
    asr	w23,	w2,	#31
    lsr	w28,	w23,	#28
    add	w1,	w2,	w28
    asr	w6,	w1,	#4
    lsl	w7,	w6,	#4
    movz	w6,	#0
    sub	w19,	w2,	w7
    lsl	w28,	w19,	#2
    mov	x14,	x28
    add	x14,	sp,	x14
    add	x14,	x14,	#288

radixSort_134:
    cmp	w6,	w27
    bge	radixSort_141

radixSort_138:
    asr	w23,	w21,	#31
    add	w6,	w6,	#1
    lsr	w1,	w23,	#28
    add	w16,	w21,	w1
    asr	w21,	w16,	#4
    b	radixSort_134

radixSort_141:
    asr	w15,	w21,	#31
    lsr	w18,	w15,	#28
    add	w1,	w21,	w18
    asr	w10,	w1,	#4
    lsl	w15,	w10,	#4
    sub	w16,	w21,	w15
    mov	w21,	w0
    lsl	w1,	w16,	#2
    mov	x17,	x1
    add	x17,	sp,	x17
    add	x17,	x17,	#288
    ldr	w2,	[x17]

    add	w3,	w2,	#1
    str	w3,	[x14]

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


