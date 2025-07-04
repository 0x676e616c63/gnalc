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
    movz	fp,	#540
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
    movz	w2,	#64
    movz	w1,	#0
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
    movz	fp,	#540
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
    add	x4,	sp,	#288
    add	x0,	sp,	#352
    add	x2,	sp,	#416
    movz	w14,	#1
    str	w24,	[x4]

    ldr	w3,	[x2]

    add	w6,	w3,	w24
    str	w6,	[x0]


radixSort_58:
    cmp	w14,	#16
    blt	radixSort_61

radixSort_71:
    movz	w15,	#0

radixSort_73:
    lsl	w3,	w15,	#2
    lsl	w11,	w15,	#2
    mov	x6,	x3
    mov	x10,	x11
    add	x6,	sp,	x6
    add	x10,	sp,	x10
    add	x6,	x6,	#288
    add	x10,	x10,	#352
    ldr	w25,	[x6]

    ldr	w11,	[x10]

    cmp	w25,	w11
    bge	radixSort_153

radixSort_82:
    lsl	w19,	w25,	#2
    movz	fp,	#540
    ldr	x14,	[sp, fp]

    add	x17,	x14,	x19
    ldr	w5,	[x17]

    mov	w7,	w5

radixSort_86:
    mov	w12,	w7
    movz	w17,	#0

radixSort_88:
    cmp	w17,	w26
    blt	radixSort_92

radixSort_95:
    asr	w13,	w12,	#31
    lsr	w17,	w13,	#28
    add	w19,	w12,	w17
    asr	w25,	w19,	#4
    lsl	w28,	w25,	#4
    sub	w14,	w12,	w28
    cmp	w14,	w15
    beq	radixSort_146

radixSort_98:
    mov	w14,	w7
    movz	w20,	#0

radixSort_99:
    cmp	w20,	w26
    blt	radixSort_103

radixSort_106:
    asr	w3,	w14,	#31
    movz	fp,	#540
    mov	w18,	w7
    movz	w19,	#0
    lsr	w8,	w3,	#28
    add	w9,	w14,	w8
    asr	w12,	w9,	#4
    lsl	w17,	w12,	#4
    sub	w8,	w14,	w17
    lsl	w10,	w8,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#288
    ldr	w12,	[x9]

    ldr	x8,	[sp, fp]

    lsl	w16,	w12,	#2
    add	x14,	x8,	x16
    ldr	w9,	[x14]


radixSort_112:
    cmp	w19,	w26
    blt	radixSort_116

radixSort_119:
    asr	w13,	w18,	#31
    movz	fp,	#540
    mov	w22,	w7
    movz	w23,	#0
    lsr	w16,	w13,	#28
    add	w17,	w18,	w16
    asr	w1,	w17,	#4
    lsl	w3,	w1,	#4
    sub	w10,	w18,	w3
    lsl	w16,	w10,	#2
    mov	x13,	x16
    add	x13,	sp,	x13
    add	x13,	x13,	#288
    ldr	w17,	[x13]

    lsl	w19,	w17,	#2
    ldr	x17,	[sp, fp]

    add	x18,	x17,	x19
    str	w7,	[x18]


radixSort_124:
    cmp	w23,	w26
    blt	radixSort_128

radixSort_131:
    asr	w18,	w22,	#31
    movz	w3,	#0
    lsr	w19,	w18,	#28
    add	w25,	w22,	w19
    asr	w14,	w25,	#4
    lsl	w18,	w14,	#4
    sub	w23,	w22,	w18
    lsl	w28,	w23,	#2
    mov	x19,	x28
    mov	w28,	w7
    add	x19,	sp,	x19
    add	x19,	x19,	#288

radixSort_134:
    cmp	w3,	w26
    blt	radixSort_138

radixSort_141:
    asr	w22,	w28,	#31
    mov	w7,	w9
    lsr	w23,	w22,	#28
    add	w25,	w28,	w23
    asr	w18,	w25,	#4
    lsl	w20,	w18,	#4
    sub	w8,	w28,	w20
    lsl	w14,	w8,	#2
    mov	x12,	x14
    add	x12,	sp,	x12
    add	x12,	x12,	#288
    ldr	w16,	[x12]

    add	w17,	w16,	#1
    str	w17,	[x19]

    b	radixSort_86

radixSort_138:
    asr	w7,	w28,	#31
    add	w3,	w3,	#1
    lsr	w14,	w7,	#28
    add	w13,	w28,	w14
    asr	w10,	w13,	#4
    mov	w28,	w10
    b	radixSort_134

radixSort_128:
    asr	w16,	w22,	#31
    add	w23,	w23,	#1
    lsr	w17,	w16,	#28
    add	w8,	w22,	w17
    asr	w22,	w8,	#4
    b	radixSort_124

radixSort_116:
    asr	w25,	w18,	#31
    add	w19,	w19,	#1
    lsr	w28,	w25,	#28
    add	w16,	w18,	w28
    asr	w18,	w16,	#4
    b	radixSort_112

radixSort_103:
    asr	w17,	w14,	#31
    add	w20,	w20,	#1
    lsr	w18,	w17,	#28
    add	w16,	w14,	w18
    asr	w14,	w16,	#4
    b	radixSort_99

radixSort_146:
    ldr	w10,	[x6]

    movz	fp,	#540
    lsl	w25,	w10,	#2
    ldr	x17,	[sp, fp]

    add	x23,	x17,	x25
    add	w25,	w10,	#1
    str	w7,	[x23]

    str	w25,	[x6]

    cmp	w25,	w11
    blt	radixSort_82
    b	radixSort_153

radixSort_92:
    asr	w25,	w12,	#31
    add	w17,	w17,	#1
    lsr	w28,	w25,	#28
    add	w23,	w12,	w28
    asr	w12,	w23,	#4
    b	radixSort_88

radixSort_153:
    add	w15,	w15,	#1
    cmp	w15,	#16
    blt	radixSort_73

radixSort_156:
    str	w24,	[x4]

    sub	w5,	w26,	#1
    add	x22,	sp,	#160
    add	x23,	sp,	#96
    add	x17,	sp,	#160
    movz	fp,	#636
    add	x14,	sp,	#96
    movz	w20,	#0
    ldr	w8,	[x2]

    add	x2,	sp,	#224
    add	w3,	w8,	w24
    add	x24,	sp,	#224
    str	w3,	[x0]

    str	w5,	[sp, #548]

    str	x2,	[sp, #600]

    str	x17,	[sp, fp]

    movz	fp,	#628
    str	x14,	[sp, fp]

    ldr	w3,	[sp, #548]

    str	w20,	[sp, #536]

    sub	w28,	w3,	#1

radixSort_168:
    ldr	w6,	[sp, #536]

    cmp	w6,	#0
    bgt	radixSort_171

radixSort_180:
    ldr	w7,	[sp, #536]

    ldr	w6,	[sp, #536]

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
    ldr	w9,	[sp, #536]

    ldr	w1,	[sp, #536]

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

    ldr	w15,	[sp, #536]

    lsl	w8,	w15,	#2
    ldr	w15,	[sp, #536]

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
    ldr	w9,	[sp, #548]

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
    movz	fp,	#540
    ldr	x3,	[sp, fp]

    add	x16,	x3,	x17
    movz	w17,	#0
    ldr	w26,	[x16]

    mov	w0,	w26

radixSort_200:
    ldr	w2,	[sp, #548]

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
    ldr	w2,	[sp, #548]

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
    ldr	x0,	[sp, #600]

    movz	fp,	#628
    movz	w4,	#1
    str	w20,	[x0]

    ldr	x10,	[sp, fp]

    movz	fp,	#636
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
    lsl	w13,	w5,	#2
    mov	x1,	x1
    mov	x11,	x13
    add	x1,	sp,	x1
    add	x11,	sp,	x11
    add	x1,	x1,	#224
    add	x11,	x11,	#160
    ldr	w15,	[x1]

    ldr	w9,	[x11]

    cmp	w15,	w9
    bge	radixSort_324

radixSort_253:
    lsl	w26,	w15,	#2
    movz	fp,	#540
    ldr	x8,	[sp, fp]

    add	x25,	x8,	x26
    ldr	w2,	[x25]

    mov	w3,	w2

radixSort_257:
    mov	w0,	w3
    movz	w11,	#0

radixSort_259:
    ldr	w2,	[sp, #548]

    cmp	w11,	w2
    blt	radixSort_263

radixSort_266:
    asr	w7,	w0,	#31
    lsr	w25,	w7,	#28
    add	w6,	w0,	w25
    asr	w6,	w6,	#4
    lsl	w7,	w6,	#4
    sub	w0,	w0,	w7
    cmp	w0,	w5
    beq	radixSort_317

radixSort_269:
    mov	w4,	w3
    movz	w14,	#0

radixSort_270:
    ldr	w2,	[sp, #548]

    cmp	w14,	w2
    blt	radixSort_274

radixSort_277:
    asr	w7,	w4,	#31
    movz	fp,	#540
    movz	w18,	#0
    lsr	w8,	w7,	#28
    add	w11,	w4,	w8
    asr	w14,	w11,	#4
    lsl	w15,	w14,	#4
    sub	w7,	w4,	w15
    lsl	w13,	w7,	#2
    mov	x10,	x13
    add	x10,	sp,	x10
    add	x10,	x10,	#224
    ldr	w14,	[x10]

    ldr	x19,	[sp, fp]

    lsl	w16,	w14,	#2
    mov	w14,	w3
    add	x15,	x19,	x16
    ldr	w2,	[x15]


radixSort_283:
    ldr	w0,	[sp, #548]

    cmp	w18,	w0
    blt	radixSort_287

radixSort_290:
    asr	w6,	w14,	#31
    movz	fp,	#540
    mov	w16,	w3
    movz	w26,	#0
    lsr	w7,	w6,	#28
    add	w8,	w14,	w7
    asr	w6,	w8,	#4
    lsl	w7,	w6,	#4
    sub	w25,	w14,	w7
    lsl	w6,	w25,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#224
    ldr	w7,	[x0]

    ldr	x6,	[sp, fp]

    lsl	w13,	w7,	#2
    add	x8,	x6,	x13
    str	w3,	[x8]


radixSort_295:
    ldr	w4,	[sp, #548]

    cmp	w26,	w4
    blt	radixSort_299

radixSort_302:
    asr	w11,	w16,	#31
    lsr	w14,	w11,	#28
    add	w15,	w16,	w14
    asr	w0,	w15,	#4
    lsl	w6,	w0,	#4
    movz	w0,	#0
    sub	w15,	w16,	w6
    lsl	w17,	w15,	#2
    mov	x7,	x17
    add	x7,	sp,	x7
    add	x7,	x7,	#224

radixSort_305:
    ldr	w8,	[sp, #548]

    cmp	w0,	w8
    blt	radixSort_309

radixSort_312:
    asr	w18,	w3,	#31
    lsr	w26,	w18,	#28
    add	w0,	w3,	w26
    asr	w13,	w0,	#4
    lsl	w15,	w13,	#4
    sub	w26,	w3,	w15
    lsl	w3,	w26,	#2
    mov	x0,	x3
    mov	w3,	w2
    add	x0,	sp,	x0
    add	x0,	x0,	#224
    ldr	w4,	[x0]

    add	w25,	w4,	#1
    str	w25,	[x7]

    b	radixSort_257

radixSort_309:
    asr	w4,	w3,	#31
    add	w0,	w0,	#1
    lsr	w10,	w4,	#28
    add	w8,	w3,	w10
    asr	w3,	w8,	#4
    b	radixSort_305

radixSort_299:
    asr	w8,	w16,	#31
    add	w26,	w26,	#1
    lsr	w11,	w8,	#28
    add	w6,	w16,	w11
    asr	w16,	w6,	#4
    b	radixSort_295

radixSort_287:
    asr	w17,	w14,	#31
    add	w18,	w18,	#1
    lsr	w0,	w17,	#28
    add	w11,	w14,	w0
    asr	w14,	w11,	#4
    b	radixSort_283

radixSort_274:
    asr	w17,	w4,	#31
    add	w14,	w14,	#1
    lsr	w18,	w17,	#28
    add	w26,	w4,	w18
    asr	w4,	w26,	#4
    b	radixSort_270

radixSort_317:
    ldr	w8,	[x1]

    movz	fp,	#540
    add	w15,	w8,	#1
    lsl	w2,	w8,	#2
    ldr	x6,	[sp, fp]

    add	x26,	x6,	x2
    str	w3,	[x26]

    str	w15,	[x1]

    cmp	w15,	w9
    blt	radixSort_253
    b	radixSort_324

radixSort_263:
    asr	w2,	w0,	#31
    add	w11,	w11,	#1
    lsr	w4,	w2,	#28
    add	w4,	w0,	w4
    asr	w0,	w4,	#4
    b	radixSort_259

radixSort_324:
    add	w5,	w5,	#1
    cmp	w5,	#16
    blt	radixSort_244

radixSort_327:
    ldr	x13,	[sp, #600]

    movz	fp,	#636
    movz	w6,	#0
    str	w20,	[x13]

    mov	w25,	w6
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
    movz	fp,	#540
    ldr	w3,	[x17]

    ldr	x1,	[sp, fp]

    bl	radixSort
    add	w6,	w25,	#1
    cmp	w6,	#16
    blt	radixSort_328

radixSort_354:
    ldr	w13,	[sp, #536]

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
    str	w5,	[sp, #536]

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
    lsl	w19,	w14,	#2
    sub	w17,	w14,	#1
    lsl	w3,	w14,	#2
    lsl	w7,	w14,	#2
    mov	x18,	x19
    mov	x25,	x3
    lsl	w22,	w17,	#2
    add	w14,	w14,	#1
    mov	x6,	x7
    add	x18,	sp,	x18
    add	x25,	sp,	x25
    mov	x20,	x22
    add	x6,	sp,	x6
    add	x20,	sp,	x20
    add	x18,	x18,	#288
    add	x25,	x25,	#352
    add	x6,	x6,	#416
    add	x20,	x20,	#352
    ldr	w23,	[x20]

    str	w23,	[x18]

    ldr	w8,	[x6]

    add	w11,	w8,	w23
    str	w11,	[x25]

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

