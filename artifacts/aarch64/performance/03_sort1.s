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
    
    mov	w20,	w3
    mov	w24,	w2
    movz	fp,	#532
    mov	w19,	w0
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
    movz	w21,	#65535
    movk	w21,	#65535,	lsl #16
    mov	w25,	w21
    cmp	w19,	w25
    beq	radixSort_360

radixSort_15:
    add	w21,	w24,	#1
    cmp	w21,	w20
    bge	radixSort_360

radixSort_18:
    cmp	w24,	w20
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
    cmp	w10,	w19
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
    mov	x27,	x10
    add	x27,	sp,	x27
    add	x27,	x27,	#416

radixSort_36:
    cmp	w12,	w19
    blt	radixSort_40

radixSort_43:
    asr	w22,	w0,	#31
    add	w6,	w6,	#1
    lsr	w26,	w22,	#28
    add	w28,	w0,	w26
    asr	w9,	w28,	#4
    lsl	w10,	w9,	#4
    sub	w4,	w0,	w10
    lsl	w1,	w4,	#2
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x0,	x0,	#416
    ldr	w2,	[x0]

    add	w3,	w2,	#1
    str	w3,	[x27]

    cmp	w6,	w20
    blt	radixSort_22
    b	radixSort_52

radixSort_40:
    asr	w16,	w0,	#31
    add	w12,	w12,	#1
    lsr	w17,	w16,	#28
    add	w5,	w0,	w17
    asr	w0,	w5,	#4
    b	radixSort_36

radixSort_30:
    asr	w5,	w4,	#31
    add	w10,	w10,	#1
    lsr	w8,	w5,	#28
    add	w26,	w4,	w8
    asr	w4,	w26,	#4
    b	radixSort_26

radixSort_52:
    add	x2,	sp,	#288
    add	x22,	sp,	#352
    add	x4,	sp,	#416
    movz	w13,	#1
    str	w24,	[x2]

    ldr	w0,	[x4]

    add	w1,	w0,	w24
    str	w1,	[x22]


radixSort_58:
    cmp	w13,	#16
    blt	radixSort_61

radixSort_71:
    movz	w14,	#0

radixSort_73:
    lsl	w0,	w14,	#2
    lsl	w10,	w14,	#2
    mov	x6,	x0
    mov	x9,	x10
    add	x6,	sp,	x6
    add	x9,	sp,	x9
    add	x6,	x6,	#288
    add	x9,	x9,	#352
    ldr	w27,	[x6]

    ldr	w7,	[x9]

    cmp	w27,	w7
    bge	radixSort_153

radixSort_82:
    lsl	w18,	w27,	#2
    movz	fp,	#532
    ldr	x13,	[sp, fp]

    add	x16,	x13,	x18
    ldr	w0,	[x16]

    mov	w1,	w0

radixSort_86:
    mov	w11,	w1
    movz	w16,	#0

radixSort_88:
    cmp	w16,	w19
    blt	radixSort_92

radixSort_95:
    asr	w12,	w11,	#31
    lsr	w13,	w12,	#28
    add	w17,	w11,	w13
    asr	w27,	w17,	#4
    lsl	w28,	w27,	#4
    sub	w11,	w11,	w28
    cmp	w11,	w14
    beq	radixSort_146

radixSort_98:
    mov	w13,	w1
    movz	w20,	#0

radixSort_99:
    cmp	w20,	w19
    blt	radixSort_103

radixSort_106:
    asr	w0,	w13,	#31
    movz	fp,	#532
    mov	w17,	w1
    lsr	w3,	w0,	#28
    add	w10,	w13,	w3
    asr	w11,	w10,	#4
    lsl	w12,	w11,	#4
    sub	w3,	w13,	w12
    lsl	w11,	w3,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#288
    ldr	w12,	[x10]

    ldr	x3,	[sp, fp]

    lsl	w15,	w12,	#2
    add	x13,	x3,	x15
    movz	w15,	#0
    ldr	w9,	[x13]


radixSort_112:
    cmp	w15,	w19
    blt	radixSort_116

radixSort_119:
    asr	w13,	w17,	#31
    movz	fp,	#532
    mov	w21,	w1
    movz	w20,	#0
    lsr	w15,	w13,	#28
    add	w16,	w17,	w15
    asr	w0,	w16,	#4
    lsl	w3,	w0,	#4
    sub	w12,	w17,	w3
    lsl	w15,	w12,	#2
    mov	x13,	x15
    add	x13,	sp,	x13
    add	x13,	x13,	#288
    ldr	w16,	[x13]

    lsl	w18,	w16,	#2
    ldr	x16,	[sp, fp]

    add	x17,	x16,	x18
    str	w1,	[x17]


radixSort_124:
    cmp	w20,	w19
    blt	radixSort_128

radixSort_131:
    asr	w17,	w21,	#31
    lsr	w18,	w17,	#28
    add	w27,	w21,	w18
    asr	w13,	w27,	#4
    lsl	w15,	w13,	#4
    sub	w26,	w21,	w15
    lsl	w28,	w26,	#2
    mov	w26,	w1
    mov	x8,	x28
    movz	w1,	#0
    add	x8,	sp,	x8
    add	x8,	x8,	#288

radixSort_134:
    cmp	w1,	w19
    blt	radixSort_138

radixSort_141:
    asr	w21,	w26,	#31
    mov	w1,	w9
    lsr	w27,	w21,	#28
    add	w28,	w26,	w27
    asr	w17,	w28,	#4
    lsl	w20,	w17,	#4
    sub	w11,	w26,	w20
    lsl	w13,	w11,	#2
    mov	x12,	x13
    add	x12,	sp,	x12
    add	x12,	x12,	#288
    ldr	w15,	[x12]

    add	w16,	w15,	#1
    str	w16,	[x8]

    b	radixSort_86

radixSort_138:
    asr	w5,	w26,	#31
    add	w1,	w1,	#1
    lsr	w13,	w5,	#28
    add	w12,	w26,	w13
    asr	w5,	w12,	#4
    mov	w26,	w5
    b	radixSort_134

radixSort_128:
    asr	w15,	w21,	#31
    add	w20,	w20,	#1
    lsr	w16,	w15,	#28
    add	w3,	w21,	w16
    asr	w21,	w3,	#4
    b	radixSort_124

radixSort_116:
    asr	w27,	w17,	#31
    add	w15,	w15,	#1
    lsr	w28,	w27,	#28
    add	w16,	w17,	w28
    asr	w17,	w16,	#4
    b	radixSort_112

radixSort_103:
    asr	w16,	w13,	#31
    add	w20,	w20,	#1
    lsr	w17,	w16,	#28
    add	w15,	w13,	w17
    asr	w13,	w15,	#4
    b	radixSort_99

radixSort_146:
    ldr	w10,	[x6]

    movz	fp,	#532
    lsl	w27,	w10,	#2
    ldr	x16,	[sp, fp]

    add	x26,	x16,	x27
    add	w27,	w10,	#1
    str	w1,	[x26]

    str	w27,	[x6]

    cmp	w27,	w7
    blt	radixSort_82
    b	radixSort_153

radixSort_92:
    asr	w27,	w11,	#31
    add	w16,	w16,	#1
    lsr	w28,	w27,	#28
    add	w26,	w11,	w28
    asr	w11,	w26,	#4
    b	radixSort_88

radixSort_153:
    add	w14,	w14,	#1
    cmp	w14,	#16
    blt	radixSort_73

radixSort_156:
    str	w24,	[x2]

    sub	w5,	w19,	#1
    add	x20,	sp,	#224
    add	x21,	sp,	#160
    movz	fp,	#620
    add	x17,	sp,	#160
    add	x14,	sp,	#96
    add	x2,	sp,	#224
    ldr	w6,	[x4]

    add	w0,	w6,	w24
    movz	w24,	#0
    str	w0,	[x22]

    add	x22,	sp,	#96
    str	w5,	[sp, #540]

    str	x2,	[sp, fp]

    movz	fp,	#564
    str	x17,	[sp, #632]

    str	x14,	[sp, fp]

    ldr	w3,	[sp, #540]

    str	w24,	[sp, #528]

    sub	w28,	w3,	#1

radixSort_168:
    ldr	w6,	[sp, #528]

    cmp	w6,	#0
    bgt	radixSort_171

radixSort_180:
    ldr	w7,	[sp, #528]

    ldr	w6,	[sp, #528]

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
    ldr	w9,	[sp, #528]

    ldr	w1,	[sp, #528]

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

    ldr	w15,	[sp, #528]

    lsl	w8,	w15,	#2
    ldr	w15,	[sp, #528]

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
    ldr	w24,	[x3]

    mov	x0,	x20
    movz	w1,	#0
    ldr	w2,	[x2]

    str	w2,	[sp, #628]

    movz	w2,	#64
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x21
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    mov	x0,	x22
    bl	memset
    ldr	w9,	[sp, #540]

    mov	x18,	x25
    cmp	w9,	w18
    beq	radixSort_354

radixSort_189:
    add	w0,	w24,	#1
    ldr	w4,	[sp, #628]

    cmp	w0,	w4
    bge	radixSort_354

radixSort_192:
    ldr	w5,	[sp, #628]

    cmp	w24,	w5
    bge	radixSort_226

radixSort_194:
    mov	w7,	w24

radixSort_196:
    lsl	w17,	w7,	#2
    movz	fp,	#532
    ldr	x1,	[sp, fp]

    add	x16,	x1,	x17
    movz	w17,	#0
    ldr	w27,	[x16]

    mov	w0,	w27

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
    sub	w26,	w0,	w8
    lsl	w0,	w26,	#2
    movz	w26,	#0
    mov	x9,	x0
    add	x9,	sp,	x9
    add	x9,	x9,	#96

radixSort_210:
    ldr	w2,	[sp, #540]

    cmp	w26,	w2
    blt	radixSort_214

radixSort_217:
    asr	w0,	w27,	#31
    add	w7,	w7,	#1
    lsr	w2,	w0,	#28
    add	w0,	w27,	w2
    asr	w11,	w0,	#4
    lsl	w12,	w11,	#4
    sub	w2,	w27,	w12
    lsl	w4,	w2,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#96
    ldr	w5,	[x3]

    add	w6,	w5,	#1
    str	w6,	[x9]

    ldr	w18,	[sp, #628]

    cmp	w7,	w18
    blt	radixSort_196
    b	radixSort_226

radixSort_214:
    asr	w3,	w27,	#31
    add	w26,	w26,	#1
    lsr	w0,	w3,	#28
    add	w3,	w27,	w0
    asr	w27,	w3,	#4
    b	radixSort_210

radixSort_204:
    asr	w3,	w0,	#31
    add	w17,	w17,	#1
    lsr	w4,	w3,	#28
    add	w6,	w0,	w4
    asr	w0,	w6,	#4
    b	radixSort_200

radixSort_226:
    movz	fp,	#620
    movz	w4,	#1
    ldr	x0,	[sp, fp]

    movz	fp,	#564
    str	w24,	[x0]

    ldr	x10,	[sp, fp]

    ldr	w1,	[x10]

    add	w12,	w1,	w24
    ldr	x1,	[sp, #632]

    str	w12,	[x1]


radixSort_229:
    cmp	w4,	#16
    blt	radixSort_232

radixSort_242:
    movz	w5,	#0

radixSort_244:
    lsl	w1,	w5,	#2
    lsl	w11,	w5,	#2
    mov	x26,	x1
    mov	x10,	x11
    add	x26,	sp,	x26
    add	x10,	sp,	x10
    add	x26,	x26,	#224
    add	x10,	x10,	#160
    ldr	w14,	[x26]

    ldr	w10,	[x10]

    cmp	w14,	w10
    bge	radixSort_324

radixSort_253:
    lsl	w27,	w14,	#2
    movz	fp,	#532
    ldr	x7,	[sp, fp]

    add	x18,	x7,	x27
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
    movz	w27,	#0
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

    cmp	w27,	w3
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
    lsr	w27,	w17,	#28
    add	w0,	w2,	w27
    asr	w11,	w0,	#4
    lsl	w13,	w11,	#4
    sub	w27,	w2,	w13
    lsl	w2,	w27,	#2
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
    add	w27,	w27,	#1
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
    add	w27,	w3,	w17
    asr	w3,	w27,	#4
    b	radixSort_270

radixSort_317:
    ldr	w7,	[x26]

    movz	fp,	#532
    add	w14,	w7,	#1
    lsl	w1,	w7,	#2
    ldr	x4,	[sp, fp]

    add	x27,	x4,	x1
    str	w2,	[x27]

    str	w14,	[x26]

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
    movz	fp,	#620
    movz	w6,	#0
    mov	w26,	w6
    ldr	x13,	[sp, fp]

    str	w24,	[x13]

    ldr	x15,	[sp, #632]

    str	w12,	[x15]


radixSort_329:
    cmp	w26,	#0
    bgt	radixSort_332

radixSort_341:
    lsl	w27,	w26,	#2
    lsl	w16,	w26,	#2
    mov	x18,	x27
    mov	x17,	x16
    add	x18,	sp,	x18
    add	x17,	sp,	x17
    add	x18,	x18,	#224
    add	x17,	x17,	#160
    b	radixSort_344

radixSort_332:
    lsl	w2,	w26,	#2
    sub	w1,	w26,	#1
    lsl	w9,	w26,	#2
    lsl	w4,	w26,	#2
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
    add	w6,	w26,	#1
    cmp	w6,	#16
    blt	radixSort_328

radixSort_354:
    ldr	w13,	[sp, #528]

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
    str	w5,	[sp, #528]

    b	radixSort_168

radixSort_328:
    mov	w26,	w6
    b	radixSort_329

radixSort_232:
    lsl	w0,	w4,	#2
    sub	w27,	w4,	#1
    lsl	w5,	w4,	#2
    lsl	w14,	w4,	#2
    mov	x10,	x0
    mov	x3,	x5
    lsl	w2,	w27,	#2
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
    lsl	w18,	w13,	#2
    sub	w16,	w13,	#1
    lsl	w28,	w13,	#2
    lsl	w6,	w13,	#2
    mov	x17,	x18
    mov	x27,	x28
    lsl	w21,	w16,	#2
    add	w13,	w13,	#1
    mov	x1,	x6
    add	x17,	sp,	x17
    add	x27,	sp,	x27
    mov	x20,	x21
    add	x1,	sp,	x1
    add	x20,	sp,	x20
    add	x17,	x17,	#288
    add	x27,	x27,	#352
    add	x1,	x1,	#416
    add	x20,	x20,	#352
    ldr	w26,	[x20]

    str	w26,	[x17]

    ldr	w7,	[x1]

    add	w9,	w7,	w26
    str	w9,	[x27]

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

