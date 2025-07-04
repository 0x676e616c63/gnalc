.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global a
.align	2
a:
.type a, %object
    .zero	120000040

.data

.text

.globl radixSort
.align 2
.p2align 4,,11
.type radixSort, %function
radixSort:
radixSort_4:
    sub	sp, sp, #656
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w23,	w3
    mov	w24,	w2
    movz	fp,	#532
    mov	w26,	w0
    movz	w2,	#64
    add	x0,	sp,	#288
    str	x1,	[sp, fp]

    movz	w1,	#0
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    add	x0,	sp,	#352
    bl	memset
    movz	w1,	#0
    movz	w2,	#64
    add	x0,	sp,	#416
    bl	memset
    movz	w22,	#65535
    movk	w22,	#65535,	lsl #16
    mov	w21,	w22
    cmp	w26,	w21
    beq	radixSort_360

radixSort_15:
    add	w28,	w24,	#1
    cmp	w28,	w23
    bge	radixSort_360

radixSort_18:
    cmp	w24,	w23
    bge	radixSort_52

radixSort_20:
    mov	w6,	w24

radixSort_22:
    lsl	w17,	w6,	#2
    movz	fp,	#532
    ldr	x10,	[sp, fp]

    add	x16,	x10,	x17
    movz	w10,	#0
    ldr	w0,	[x16]

    mov	w4,	w0

radixSort_26:
    cmp	w10,	w26
    blt	radixSort_30

radixSort_33:
    asr	w8,	w4,	#31
    movz	w12,	#0
    lsr	w10,	w8,	#28
    add	w11,	w4,	w10
    asr	w14,	w11,	#4
    lsl	w15,	w14,	#4
    sub	w7,	w4,	w15
    lsl	w10,	w7,	#2
    mov	x18,	x10
    add	x18,	sp,	x18
    add	x18,	x18,	#416

radixSort_36:
    cmp	w12,	w26
    blt	radixSort_40

radixSort_43:
    asr	w20,	w0,	#31
    add	w6,	w6,	#1
    lsr	w2,	w20,	#28
    add	w3,	w0,	w2
    asr	w9,	w3,	#4
    lsl	w10,	w9,	#4
    sub	w5,	w0,	w10
    lsl	w1,	w5,	#2
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x0,	x0,	#416
    ldr	w2,	[x0]

    add	w3,	w2,	#1
    str	w3,	[x18]

    cmp	w6,	w23
    blt	radixSort_22
    b	radixSort_52

radixSort_40:
    asr	w16,	w0,	#31
    add	w12,	w12,	#1
    lsr	w17,	w16,	#28
    add	w7,	w0,	w17
    asr	w0,	w7,	#4
    b	radixSort_36

radixSort_30:
    asr	w9,	w4,	#31
    add	w10,	w10,	#1
    lsr	w12,	w9,	#28
    add	w22,	w4,	w12
    asr	w4,	w22,	#4
    b	radixSort_26

radixSort_52:
    add	x5,	sp,	#288
    add	x25,	sp,	#352
    add	x4,	sp,	#416
    movz	w13,	#1
    str	w24,	[x5]

    ldr	w0,	[x4]

    add	w1,	w0,	w24
    str	w1,	[x25]


radixSort_58:
    cmp	w13,	#16
    blt	radixSort_61

radixSort_71:
    movz	w14,	#0

radixSort_73:
    lsl	w0,	w14,	#2
    lsl	w9,	w14,	#2
    mov	x3,	x0
    mov	x8,	x9
    add	x3,	sp,	x3
    add	x8,	sp,	x8
    add	x3,	x3,	#288
    add	x8,	x8,	#352
    ldr	w23,	[x3]

    ldr	w10,	[x8]

    cmp	w23,	w10
    bge	radixSort_153

radixSort_82:
    lsl	w16,	w23,	#2
    movz	fp,	#532
    ldr	x12,	[sp, fp]

    add	x15,	x12,	x16
    ldr	w2,	[x15]

    mov	w6,	w2

radixSort_86:
    mov	w11,	w6
    movz	w16,	#0

radixSort_88:
    cmp	w16,	w26
    blt	radixSort_92

radixSort_95:
    asr	w1,	w11,	#31
    lsr	w16,	w1,	#28
    add	w18,	w11,	w16
    asr	w22,	w18,	#4
    lsl	w23,	w22,	#4
    sub	w13,	w11,	w23
    cmp	w13,	w14
    beq	radixSort_146

radixSort_98:
    mov	w13,	w6
    movz	w19,	#0

radixSort_99:
    cmp	w19,	w26
    blt	radixSort_103

radixSort_106:
    asr	w0,	w13,	#31
    movz	fp,	#532
    mov	w17,	w6
    movz	w18,	#0
    lsr	w1,	w0,	#28
    add	w2,	w13,	w1
    asr	w1,	w2,	#4
    lsl	w16,	w1,	#4
    sub	w1,	w13,	w16
    lsl	w7,	w1,	#2
    mov	x2,	x7
    add	x2,	sp,	x2
    add	x2,	x2,	#288
    ldr	w9,	[x2]

    ldr	x1,	[sp, fp]

    lsl	w13,	w9,	#2
    add	x11,	x1,	x13
    ldr	w8,	[x11]


radixSort_112:
    cmp	w18,	w26
    blt	radixSort_116

radixSort_119:
    asr	w7,	w17,	#31
    movz	fp,	#532
    mov	w20,	w6
    movz	w22,	#0
    lsr	w12,	w7,	#28
    add	w15,	w17,	w12
    asr	w28,	w15,	#4
    lsl	w0,	w28,	#4
    sub	w2,	w17,	w0
    lsl	w12,	w2,	#2
    mov	x7,	x12
    add	x7,	sp,	x7
    add	x7,	x7,	#288
    ldr	w15,	[x7]

    lsl	w17,	w15,	#2
    ldr	x15,	[sp, fp]

    add	x16,	x15,	x17
    str	w6,	[x16]


radixSort_124:
    cmp	w22,	w26
    blt	radixSort_128

radixSort_131:
    asr	w16,	w20,	#31
    mov	w28,	w6
    movz	w1,	#0
    lsr	w17,	w16,	#28
    add	w18,	w20,	w17
    asr	w2,	w18,	#4
    lsl	w17,	w2,	#4
    sub	w20,	w20,	w17
    lsl	w23,	w20,	#2
    mov	x7,	x23
    add	x7,	sp,	x7
    add	x7,	x7,	#288

radixSort_134:
    cmp	w1,	w26
    blt	radixSort_138

radixSort_141:
    asr	w19,	w28,	#31
    lsr	w20,	w19,	#28
    add	w22,	w28,	w20
    asr	w16,	w22,	#4
    lsl	w17,	w16,	#4
    sub	w2,	w28,	w17
    lsl	w11,	w2,	#2
    mov	x6,	x11
    add	x6,	sp,	x6
    add	x6,	x6,	#288
    ldr	w13,	[x6]

    mov	w6,	w8
    add	w15,	w13,	#1
    str	w15,	[x7]

    b	radixSort_86

radixSort_138:
    asr	w2,	w28,	#31
    add	w1,	w1,	#1
    lsr	w6,	w2,	#28
    add	w9,	w28,	w6
    asr	w9,	w9,	#4
    mov	w28,	w9
    b	radixSort_134

radixSort_128:
    asr	w12,	w20,	#31
    add	w22,	w22,	#1
    lsr	w15,	w12,	#28
    add	w1,	w20,	w15
    asr	w20,	w1,	#4
    b	radixSort_124

radixSort_116:
    asr	w20,	w17,	#31
    add	w18,	w18,	#1
    lsr	w23,	w20,	#28
    add	w12,	w17,	w23
    asr	w17,	w12,	#4
    b	radixSort_112

radixSort_103:
    asr	w11,	w13,	#31
    add	w19,	w19,	#1
    lsr	w16,	w11,	#28
    add	w13,	w13,	w16
    asr	w13,	w13,	#4
    b	radixSort_99

radixSort_146:
    ldr	w0,	[x3]

    movz	fp,	#532
    add	w23,	w0,	#1
    lsl	w22,	w0,	#2
    ldr	x15,	[sp, fp]

    add	x20,	x15,	x22
    str	w6,	[x20]

    str	w23,	[x3]

    cmp	w23,	w10
    blt	radixSort_82
    b	radixSort_153

radixSort_92:
    asr	w22,	w11,	#31
    add	w16,	w16,	#1
    lsr	w23,	w22,	#28
    add	w20,	w11,	w23
    asr	w11,	w20,	#4
    b	radixSort_88

radixSort_153:
    add	w14,	w14,	#1
    cmp	w14,	#16
    blt	radixSort_73

radixSort_156:
    str	w24,	[x5]

    add	x22,	sp,	#160
    add	x23,	sp,	#96
    movz	fp,	#636
    add	x17,	sp,	#160
    add	x14,	sp,	#96
    movz	w20,	#0
    sub	w5,	w26,	#1
    ldr	w6,	[x4]

    add	w2,	w6,	w24
    add	x24,	sp,	#224
    str	w2,	[x25]

    add	x2,	sp,	#224
    str	w5,	[sp, #540]

    str	x2,	[sp, fp]

    movz	fp,	#580
    str	x17,	[sp, fp]

    movz	fp,	#564
    str	x14,	[sp, fp]

    ldr	w3,	[sp, #540]

    str	w20,	[sp, #480]

    sub	w28,	w3,	#1

radixSort_168:
    ldr	w6,	[sp, #480]

    cmp	w6,	#0
    bgt	radixSort_171

radixSort_180:
    ldr	w7,	[sp, #480]

    ldr	w6,	[sp, #480]

    lsl	w4,	w7,	#2
    lsl	w7,	w6,	#2
    mov	x3,	x4
    mov	x2,	x7
    add	x3,	sp,	x3
    add	x2,	sp,	x2
    add	x3,	x3,	#288
    add	x2,	x2,	#352
    b	radixSort_183

radixSort_171:
    ldr	w9,	[sp, #480]

    ldr	w1,	[sp, #480]

    lsl	w8,	w9,	#2
    sub	w10,	w1,	#1
    mov	x3,	x8
    add	x3,	sp,	x3
    lsl	w12,	w10,	#2
    add	x3,	x3,	#288
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#352
    ldr	w6,	[x11]

    str	w6,	[x3]

    ldr	w15,	[sp, #480]

    lsl	w8,	w15,	#2
    ldr	w15,	[sp, #480]

    mov	x2,	x8
    lsl	w10,	w15,	#2
    add	x2,	sp,	x2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x2,	x2,	#352
    add	x9,	x9,	#416
    ldr	w11,	[x9]

    add	w12,	w11,	w6
    str	w12,	[x2]


radixSort_183:
    ldr	w20,	[x3]

    mov	x0,	x24
    movz	w1,	#0
    ldr	w2,	[x2]

    str	w2,	[sp, #644]

    movz	w2,	#64
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x22
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x23
    bl	memset
    ldr	w9,	[sp, #540]

    mov	x18,	x21
    cmp	w9,	w18
    beq	radixSort_354

radixSort_189:
    add	w0,	w20,	#1
    ldr	w4,	[sp, #644]

    cmp	w0,	w4
    bge	radixSort_354

radixSort_192:
    ldr	w5,	[sp, #644]

    cmp	w20,	w5
    bge	radixSort_226

radixSort_194:
    mov	w7,	w20

radixSort_196:
    lsl	w17,	w7,	#2
    movz	fp,	#532
    ldr	x3,	[sp, fp]

    add	x16,	x3,	x17
    movz	w17,	#0
    ldr	w26,	[x16]

    mov	w0,	w26

radixSort_200:
    ldr	w2,	[sp, #540]

    cmp	w17,	w2
    blt	radixSort_204

radixSort_207:
    asr	w15,	w0,	#31
    lsr	w16,	w15,	#28
    add	w17,	w0,	w16
    asr	w6,	w17,	#4
    lsl	w8,	w6,	#4
    sub	w25,	w0,	w8
    lsl	w0,	w25,	#2
    movz	w25,	#0
    mov	x9,	x0
    add	x9,	sp,	x9
    add	x9,	x9,	#96

radixSort_210:
    ldr	w2,	[sp, #540]

    cmp	w25,	w2
    blt	radixSort_214

radixSort_217:
    asr	w0,	w26,	#31
    add	w7,	w7,	#1
    lsr	w2,	w0,	#28
    add	w0,	w26,	w2
    asr	w11,	w0,	#4
    lsl	w12,	w11,	#4
    sub	w2,	w26,	w12
    lsl	w4,	w2,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#96
    ldr	w5,	[x3]

    add	w6,	w5,	#1
    str	w6,	[x9]

    ldr	w18,	[sp, #644]

    cmp	w7,	w18
    blt	radixSort_196
    b	radixSort_226

radixSort_214:
    asr	w3,	w26,	#31
    add	w25,	w25,	#1
    lsr	w0,	w3,	#28
    add	w3,	w26,	w0
    asr	w26,	w3,	#4
    b	radixSort_210

radixSort_204:
    asr	w3,	w0,	#31
    add	w17,	w17,	#1
    lsr	w4,	w3,	#28
    add	w6,	w0,	w4
    asr	w0,	w6,	#4
    b	radixSort_200

radixSort_226:
    movz	fp,	#636
    movz	w4,	#1
    ldr	x0,	[sp, fp]

    movz	fp,	#564
    str	w20,	[x0]

    ldr	x10,	[sp, fp]

    movz	fp,	#580
    ldr	w1,	[x10]

    add	w12,	w1,	w20
    ldr	x1,	[sp, fp]

    str	w12,	[x1]


radixSort_229:
    cmp	w4,	#16
    blt	radixSort_232

radixSort_242:
    movz	w5,	#0

radixSort_244:
    lsl	w1,	w5,	#2
    lsl	w11,	w5,	#2
    mov	x25,	x1
    mov	x10,	x11
    add	x25,	sp,	x25
    add	x10,	sp,	x10
    add	x25,	x25,	#224
    add	x10,	x10,	#160
    ldr	w14,	[x25]

    ldr	w10,	[x10]

    cmp	w14,	w10
    bge	radixSort_324

radixSort_253:
    lsl	w26,	w14,	#2
    movz	fp,	#532
    ldr	x7,	[sp, fp]

    add	x18,	x7,	x26
    ldr	w1,	[x18]

    mov	w2,	w1

radixSort_257:
    mov	w0,	w2
    movz	w9,	#0

radixSort_259:
    ldr	w1,	[sp, #540]

    cmp	w9,	w1
    blt	radixSort_263

radixSort_266:
    asr	w8,	w0,	#31
    lsr	w18,	w8,	#28
    add	w4,	w0,	w18
    asr	w4,	w4,	#4
    lsl	w6,	w4,	#4
    sub	w0,	w0,	w6
    cmp	w0,	w5
    beq	radixSort_317

radixSort_269:
    mov	w3,	w2
    movz	w13,	#0

radixSort_270:
    ldr	w4,	[sp, #540]

    cmp	w13,	w4
    blt	radixSort_274

radixSort_277:
    asr	w6,	w3,	#31
    movz	fp,	#532
    movz	w17,	#0
    lsr	w7,	w6,	#28
    add	w9,	w3,	w7
    asr	w11,	w9,	#4
    lsl	w13,	w11,	#4
    sub	w6,	w3,	w13
    mov	w13,	w2
    lsl	w9,	w6,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	#224
    ldr	w11,	[x8]

    ldr	x18,	[sp, fp]

    lsl	w15,	w11,	#2
    add	x14,	x18,	x15
    ldr	w1,	[x14]


radixSort_283:
    ldr	w0,	[sp, #540]

    cmp	w17,	w0
    blt	radixSort_287

radixSort_290:
    asr	w4,	w13,	#31
    movz	fp,	#532
    mov	w15,	w2
    movz	w26,	#0
    lsr	w6,	w4,	#28
    add	w7,	w13,	w6
    asr	w4,	w7,	#4
    lsl	w9,	w4,	#4
    sub	w18,	w13,	w9
    lsl	w4,	w18,	#2
    mov	x0,	x4
    add	x0,	sp,	x0
    add	x0,	x0,	#224
    ldr	w6,	[x0]

    ldr	x4,	[sp, fp]

    lsl	w11,	w6,	#2
    add	x7,	x4,	x11
    str	w2,	[x7]


radixSort_295:
    ldr	w3,	[sp, #540]

    cmp	w26,	w3
    blt	radixSort_299

radixSort_302:
    asr	w9,	w15,	#31
    lsr	w11,	w9,	#28
    add	w13,	w15,	w11
    asr	w0,	w13,	#4
    lsl	w4,	w0,	#4
    movz	w0,	#0
    sub	w13,	w15,	w4
    lsl	w16,	w13,	#2
    mov	x6,	x16
    add	x6,	sp,	x6
    add	x6,	x6,	#224

radixSort_305:
    ldr	w11,	[sp, #540]

    cmp	w0,	w11
    blt	radixSort_309

radixSort_312:
    asr	w17,	w2,	#31
    lsr	w26,	w17,	#28
    add	w0,	w2,	w26
    asr	w11,	w0,	#4
    lsl	w13,	w11,	#4
    sub	w26,	w2,	w13
    lsl	w2,	w26,	#2
    mov	x0,	x2
    mov	w2,	w1
    add	x0,	sp,	x0
    add	x0,	x0,	#224
    ldr	w8,	[x0]

    add	w18,	w8,	#1
    str	w18,	[x6]

    b	radixSort_257

radixSort_309:
    asr	w3,	w2,	#31
    add	w0,	w0,	#1
    lsr	w8,	w3,	#28
    add	w11,	w2,	w8
    asr	w2,	w11,	#4
    b	radixSort_305

radixSort_299:
    asr	w7,	w15,	#31
    add	w26,	w26,	#1
    lsr	w9,	w7,	#28
    add	w4,	w15,	w9
    asr	w15,	w4,	#4
    b	radixSort_295

radixSort_287:
    asr	w16,	w13,	#31
    add	w17,	w17,	#1
    lsr	w0,	w16,	#28
    add	w9,	w13,	w0
    asr	w13,	w9,	#4
    b	radixSort_283

radixSort_274:
    asr	w16,	w3,	#31
    add	w13,	w13,	#1
    lsr	w17,	w16,	#28
    add	w26,	w3,	w17
    asr	w3,	w26,	#4
    b	radixSort_270

radixSort_317:
    ldr	w8,	[x25]

    movz	fp,	#532
    add	w14,	w8,	#1
    lsl	w0,	w8,	#2
    ldr	x4,	[sp, fp]

    add	x26,	x4,	x0
    str	w2,	[x26]

    str	w14,	[x25]

    cmp	w14,	w10
    blt	radixSort_253
    b	radixSort_324

radixSort_263:
    asr	w1,	w0,	#31
    add	w9,	w9,	#1
    lsr	w3,	w1,	#28
    add	w4,	w0,	w3
    asr	w0,	w4,	#4
    b	radixSort_259

radixSort_324:
    add	w5,	w5,	#1
    cmp	w5,	#16
    blt	radixSort_244

radixSort_327:
    movz	fp,	#636
    movz	w6,	#0
    mov	w25,	w6
    ldr	x13,	[sp, fp]

    movz	fp,	#580
    str	w20,	[x13]

    ldr	x15,	[sp, fp]

    str	w12,	[x15]


radixSort_329:
    cmp	w25,	#0
    bgt	radixSort_332

radixSort_341:
    lsl	w26,	w25,	#2
    lsl	w16,	w25,	#2
    mov	x18,	x26
    mov	x17,	x16
    add	x18,	sp,	x18
    add	x17,	sp,	x17
    add	x18,	x18,	#224
    add	x17,	x17,	#160
    b	radixSort_344

radixSort_332:
    lsl	w2,	w25,	#2
    sub	w1,	w25,	#1
    lsl	w9,	w25,	#2
    lsl	w4,	w25,	#2
    mov	x18,	x2
    mov	x17,	x9
    lsl	w1,	w1,	#2
    mov	x3,	x4
    add	x18,	sp,	x18
    add	x17,	sp,	x17
    mov	x0,	x1
    add	x3,	sp,	x3
    add	x0,	sp,	x0
    add	x18,	x18,	#224
    add	x17,	x17,	#160
    add	x3,	x3,	#96
    add	x0,	x0,	#160
    ldr	w5,	[x0]

    str	w5,	[x18]

    ldr	w7,	[x3]

    add	w11,	w7,	w5
    str	w11,	[x17]


radixSort_344:
    ldr	w2,	[x18]

    mov	w0,	w28
    movz	fp,	#532
    ldr	w3,	[x17]

    ldr	x1,	[sp, fp]

    bl	radixSort
    add	w6,	w25,	#1
    cmp	w6,	#16
    blt	radixSort_328

radixSort_354:
    ldr	w13,	[sp, #480]

    add	w5,	w13,	#1
    cmp	w5,	#16
    blt	radixSort_167

radixSort_360:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #656
    ret


radixSort_167:
    str	w5,	[sp, #480]

    b	radixSort_168

radixSort_328:
    mov	w25,	w6
    b	radixSort_329

radixSort_232:
    lsl	w0,	w4,	#2
    sub	w26,	w4,	#1
    lsl	w5,	w4,	#2
    lsl	w14,	w4,	#2
    mov	x10,	x0
    mov	x3,	x5
    lsl	w2,	w26,	#2
    add	w4,	w4,	#1
    mov	x13,	x14
    add	x10,	sp,	x10
    add	x3,	sp,	x3
    mov	x0,	x2
    add	x13,	sp,	x13
    add	x0,	sp,	x0
    add	x10,	x10,	#224
    add	x3,	x3,	#160
    add	x13,	x13,	#96
    add	x0,	x0,	#160
    ldr	w0,	[x0]

    str	w0,	[x10]

    ldr	w15,	[x13]

    add	w10,	w15,	w0
    str	w10,	[x3]

    b	radixSort_229

radixSort_61:
    lsl	w17,	w13,	#2
    sub	w15,	w13,	#1
    lsl	w23,	w13,	#2
    lsl	w2,	w13,	#2
    mov	x16,	x17
    mov	x22,	x23
    lsl	w19,	w15,	#2
    add	w13,	w13,	#1
    mov	x1,	x2
    add	x16,	sp,	x16
    add	x22,	sp,	x22
    mov	x18,	x19
    add	x1,	sp,	x1
    add	x18,	sp,	x18
    add	x16,	x16,	#288
    add	x22,	x22,	#352
    add	x1,	x1,	#416
    add	x18,	x18,	#352
    ldr	w20,	[x18]

    str	w20,	[x16]

    ldr	w3,	[x1]

    add	w10,	w3,	w20
    str	w10,	[x22]

    b	radixSort_58

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    adrp	x22, :got:a
    ldr	x22, [x22, #:got_lo12:a]
    mov	x0,	x22
    bl	getarray
    mov	w21,	w0
    movz	w0,	#90
    bl	_sysy_starttime
    mov	w3,	w21
    movz	w2,	#0
    mov	x1,	x22
    movz	w0,	#8
    bl	radixSort
    movz	w19,	#0
    movz	w16,	#0

main_3:
    cmp	w16,	w21
    blt	main_7

main_15:
    movz	w23,	#0
    sub	w26,	w23,	w19
    cmp	w19,	#0
    movz	w0,	#102
    csel	w28,	w26,	w19,	lt
    cset	w22,	lt
    bl	_sysy_stoptime
    mov	w0,	w28
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_7:
    lsl	w18,	w16,	#2
    adrp	x2, :got:a
    add	w10,	w16,	#2
    ldr	x2, [x2, #:got_lo12:a]
    add	x0,	x2,	x18
    ldr	w13,	[x0]

    sdiv	w24,	w13,	w10
    mul	w22,	w24,	w10
    msub	w24,	w24,	w10,	w13

    madd	w19,	w24,	w16,	w19

    mul	w6,	w24,	w16
    add	w16,	w16,	#1
    b	main_3

