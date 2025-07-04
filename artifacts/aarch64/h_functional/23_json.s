.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global pos
.align	2
pos:
.type pos, %object
    .zero	4

.global buffer
.align	2
buffer:
.type buffer, %object
    .zero	200000000

.data

.text

.globl detect_item
.align 2
.p2align 4,,11
.type detect_item, %function
detect_item:
detect_item_3:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w22,	w2
    mov	x21,	x1

detect_item_4:
    adrp	x13, :got:pos
    ldr	x13, [x13, #:got_lo12:pos]
    ldr	w12,	[x13]

    cmp	w12,	w22
    bge	detect_item_766

detect_item_11:
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    ldr	w11,	[x16]

    cmp	w11,	w22
    bge	detect_item_34

detect_item_14:
    lsl	w19,	w11,	#2
    add	x18,	x21,	x19
    ldr	w20,	[x18]

    cmp	w20,	#32
    beq	detect_item_18

detect_item_20:
    cmp	w20,	#9
    beq	detect_item_22

detect_item_24:
    cmp	w20,	#10
    beq	detect_item_26

detect_item_28:
    cmp	w20,	#13
    beq	detect_item_30

detect_item_34:
    cmp	w0,	#0
    beq	detect_item_36

detect_item_71:
    cmp	w0,	#1
    bne	detect_item_194

detect_item_73:
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    ldr	w14,	[x15]

    lsl	w17,	w14,	#2
    add	x16,	x21,	x17
    ldr	w18,	[x16]

    cmp	w18,	#43
    beq	detect_item_78

detect_item_81:
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    ldr	w20,	[x23]

    lsl	w25,	w20,	#2
    add	x24,	x21,	x25
    ldr	w26,	[x24]

    cmp	w26,	#45
    bne	detect_item_90

detect_item_86:
    adrp	x0, :got:pos
    adrp	x2, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    ldr	w28,	[x0]

    ldr	x2, [x2, #:got_lo12:pos]
    add	w15,	w28,	#1
    str	w15,	[x2]

    b	detect_item_90

detect_item_78:
    adrp	x4, :got:pos
    adrp	x6, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w3,	[x4]

    ldr	x6, [x6, #:got_lo12:pos]
    add	w19,	w3,	#1
    str	w19,	[x6]


detect_item_90:
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    ldr	w7,	[x8]

    cmp	w7,	w22
    blt	detect_item_93

detect_item_801:
    movz	w0,	#0
    b	detect_item_807

detect_item_93:
    adrp	x11, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w10,	[x11]

    lsl	w13,	w10,	#2
    add	x12,	x21,	x13
    ldr	w1,	[x12]

    cmp	w1,	#57
    cset	w16,	le
    cmp	w1,	#48
    movz	w6,	#0
    csel	w18,	w16,	w6,	ge
    cmp	w18,	#0
    beq	detect_item_802

detect_item_103:
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    ldr	w15,	[x23]

    cmp	w15,	w22
    bge	detect_item_118

detect_item_106:
    lsl	w26,	w15,	#2
    add	x25,	x21,	x26
    ldr	w13,	[x25]

    cmp	w13,	#57
    cset	w0,	le
    cmp	w13,	#48
    movz	w9,	#0
    csel	w2,	w0,	w9,	ge
    cmp	w2,	#1
    beq	detect_item_114

detect_item_118:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    cmp	w4,	w22
    bge	detect_item_146

detect_item_121:
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    ldr	w7,	[x8]

    lsl	w10,	w7,	#2
    add	x9,	x21,	x10
    ldr	w11,	[x9]

    cmp	w11,	#46
    bne	detect_item_146

detect_item_126:
    adrp	x14, :got:pos
    adrp	x16, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    ldr	w13,	[x14]

    ldr	x16, [x16, #:got_lo12:pos]
    add	w3,	w13,	#1
    str	w3,	[x16]


detect_item_129:
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    ldr	w16,	[x18]

    cmp	w16,	w22
    bge	detect_item_146

detect_item_132:
    lsl	w23,	w16,	#2
    add	x20,	x21,	x23
    ldr	w10,	[x20]

    cmp	w10,	#57
    cset	w26,	le
    cmp	w10,	#48
    movz	w11,	#0
    csel	w28,	w26,	w11,	ge
    cmp	w28,	#1
    beq	detect_item_140

detect_item_146:
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    ldr	w1,	[x2]

    cmp	w1,	w22
    blt	detect_item_149

detect_item_803:
    movz	w0,	#1
    b	detect_item_807

detect_item_149:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    lsl	w7,	w4,	#2
    add	x6,	x21,	x7
    ldr	w8,	[x6]

    cmp	w8,	#101
    beq	detect_item_154

detect_item_804:
    movz	w0,	#1
    b	detect_item_807

detect_item_154:
    adrp	x11, :got:pos
    adrp	x13, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w10,	[x11]

    ldr	x13, [x13, #:got_lo12:pos]
    add	w1,	w10,	#1
    str	w1,	[x13]

    cmp	w1,	w22
    bge	detect_item_168

detect_item_158:
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    ldr	w15,	[x16]

    lsl	w18,	w15,	#2
    add	x17,	x21,	x18
    ldr	w19,	[x17]

    cmp	w19,	#43
    bne	detect_item_168

detect_item_163:
    adrp	x24, :got:pos
    adrp	x26, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    ldr	w23,	[x24]

    ldr	x26, [x26, #:got_lo12:pos]
    add	w12,	w23,	#1
    str	w12,	[x26]


detect_item_168:
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w27,	[x28]

    cmp	w27,	w22
    bge	detect_item_181

detect_item_171:
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    ldr	w1,	[x2]

    lsl	w4,	w1,	#2
    add	x3,	x21,	x4
    ldr	w5,	[x3]

    cmp	w5,	#45
    bne	detect_item_181

detect_item_176:
    adrp	x8, :got:pos
    adrp	x10, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    ldr	w7,	[x8]

    ldr	x10, [x10, #:got_lo12:pos]
    add	w28,	w7,	#1
    str	w28,	[x10]


detect_item_181:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w28,	[x12]

    cmp	w28,	w22
    blt	detect_item_184

detect_item_805:
    movz	w0,	#1
    b	detect_item_807

detect_item_184:
    lsl	w15,	w28,	#2
    add	x14,	x21,	x15
    ldr	w6,	[x14]

    cmp	w6,	#57
    cset	w18,	le
    cmp	w6,	#48
    movz	w16,	#0
    csel	w20,	w18,	w16,	ge
    cmp	w20,	#1
    beq	detect_item_192

detect_item_806:
    movz	w0,	#1
    b	detect_item_807

detect_item_192:
    add	w12,	w28,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w12,	[x25]

    b	detect_item_181

detect_item_140:
    add	w14,	w16,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w14,	[x27]

    b	detect_item_129

detect_item_114:
    add	w17,	w15,	#1
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    str	w17,	[x0]

    b	detect_item_103

detect_item_802:
    movz	w0,	#0
    b	detect_item_807

detect_item_194:
    cmp	w0,	#2
    bne	detect_item_225

detect_item_196:
    adrp	x3, :got:pos
    adrp	x5, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    ldr	w2,	[x3]

    ldr	x5, [x5, #:got_lo12:pos]
    add	w24,	w2,	#1
    str	w24,	[x5]


detect_item_199:
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    ldr	w18,	[x7]

    cmp	w18,	w22
    bge	detect_item_214

detect_item_202:
    lsl	w10,	w18,	#2
    add	x9,	x21,	x10
    ldr	w11,	[x9]

    cmp	w11,	#34
    bne	detect_item_206

detect_item_214:
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    ldr	w13,	[x14]

    cmp	w13,	w22
    blt	detect_item_217

detect_item_799:
    movz	w0,	#0
    b	detect_item_807

detect_item_217:
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    ldr	w17,	[x18]

    lsl	w20,	w17,	#2
    add	x23,	x21,	x20
    ldr	w25,	[x23]

    cmp	w25,	#34
    beq	detect_item_222

detect_item_800:
    movz	w0,	#0
    b	detect_item_807

detect_item_222:
    adrp	x28, :got:pos
    adrp	x1, :got:pos
    movz	w0,	#1
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w27,	[x28]

    ldr	x1, [x1, #:got_lo12:pos]
    add	w26,	w27,	#1
    str	w26,	[x1]

    b	detect_item_807

detect_item_206:
    cmp	w11,	#92
    beq	detect_item_208

detect_item_210:
    add	w19,	w18,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w19,	[x1]

    b	detect_item_199

detect_item_208:
    add	w23,	w18,	#2
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    str	w23,	[x3]

    b	detect_item_199

detect_item_225:
    cmp	w0,	#3
    bne	detect_item_385

detect_item_227:
    adrp	x6, :got:pos
    adrp	x8, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    ldr	w5,	[x6]

    ldr	x8, [x8, #:got_lo12:pos]
    add	w28,	w5,	#1
    str	w28,	[x8]


detect_item_230:
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    ldr	w26,	[x10]

    cmp	w26,	w22
    bge	detect_item_253

detect_item_233:
    lsl	w13,	w26,	#2
    add	x12,	x21,	x13
    ldr	w14,	[x12]

    cmp	w14,	#32
    beq	detect_item_237

detect_item_239:
    cmp	w14,	#9
    beq	detect_item_241

detect_item_243:
    cmp	w14,	#10
    beq	detect_item_245

detect_item_247:
    cmp	w14,	#13
    beq	detect_item_249

detect_item_253:
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    ldr	w19,	[x20]

    cmp	w19,	w22
    bge	detect_item_266

detect_item_256:
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    ldr	w24,	[x25]

    lsl	w27,	w24,	#2
    add	x26,	x21,	x27
    ldr	w28,	[x26]

    cmp	w28,	#93
    beq	detect_item_261

detect_item_266:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    beq	detect_item_795

detect_item_270:
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w23,	[x4]

    cmp	w23,	w22
    bge	detect_item_295

detect_item_273:
    lsl	w7,	w23,	#2
    add	x6,	x21,	x7
    ldr	w8,	[x6]

    cmp	w8,	#32
    beq	detect_item_277

detect_item_279:
    cmp	w8,	#9
    beq	detect_item_281

detect_item_283:
    cmp	w8,	#10
    beq	detect_item_285

detect_item_287:
    cmp	w8,	#13
    beq	detect_item_289

detect_item_295:
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    ldr	w4,	[x14]

    lsl	w16,	w4,	#2
    add	x15,	x21,	x16
    ldr	w17,	[x15]

    cmp	w17,	#44
    beq	detect_item_300

detect_item_351:
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    ldr	w10,	[x20]

    cmp	w10,	w22
    bge	detect_item_374

detect_item_354:
    lsl	w25,	w10,	#2
    add	x24,	x21,	x25
    ldr	w26,	[x24]

    cmp	w26,	#32
    beq	detect_item_358

detect_item_360:
    cmp	w26,	#9
    beq	detect_item_362

detect_item_364:
    cmp	w26,	#10
    beq	detect_item_366

detect_item_368:
    cmp	w26,	#13
    beq	detect_item_370

detect_item_374:
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    ldr	w2,	[x3]

    cmp	w2,	w22
    blt	detect_item_377

detect_item_797:
    movz	w0,	#0
    b	detect_item_807

detect_item_377:
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w3,	[x4]

    lsl	w6,	w3,	#2
    add	x6,	x21,	x6
    ldr	w8,	[x6]

    cmp	w8,	#93
    beq	detect_item_382

detect_item_798:
    movz	w0,	#0
    b	detect_item_807

detect_item_382:
    adrp	x11, :got:pos
    adrp	x13, :got:pos
    movz	w0,	#1
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w10,	[x11]

    ldr	x13, [x13, #:got_lo12:pos]
    add	w11,	w10,	#1
    str	w11,	[x13]

    b	detect_item_807

detect_item_370:
    add	w9,	w10,	#1
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    str	w9,	[x16]

    b	detect_item_351

detect_item_366:
    add	w11,	w10,	#1
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    str	w11,	[x18]

    b	detect_item_351

detect_item_362:
    add	w13,	w10,	#1
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    str	w13,	[x20]

    b	detect_item_351

detect_item_358:
    add	w15,	w10,	#1
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    str	w15,	[x24]

    b	detect_item_351

detect_item_300:
    add	w17,	w4,	#1
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    str	w17,	[x26]


detect_item_302:
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w24,	[x28]

    cmp	w24,	w22
    bge	detect_item_325

detect_item_305:
    lsl	w2,	w24,	#2
    add	x1,	x21,	x2
    ldr	w3,	[x1]

    cmp	w3,	#32
    beq	detect_item_309

detect_item_311:
    cmp	w3,	#9
    beq	detect_item_313

detect_item_315:
    cmp	w3,	#10
    beq	detect_item_317

detect_item_319:
    cmp	w3,	#13
    beq	detect_item_321

detect_item_325:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_329

detect_item_796:
    movz	w0,	#0
    b	detect_item_807

detect_item_329:
    adrp	x11, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w7,	[x11]

    cmp	w7,	w22
    bge	detect_item_295

detect_item_332:
    lsl	w14,	w7,	#2
    add	x13,	x21,	x14
    ldr	w15,	[x13]

    cmp	w15,	#32
    beq	detect_item_336

detect_item_338:
    cmp	w15,	#9
    beq	detect_item_340

detect_item_342:
    cmp	w15,	#10
    beq	detect_item_344

detect_item_346:
    cmp	w15,	#13
    bne	detect_item_295

detect_item_348:
    add	w15,	w7,	#1
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    str	w15,	[x23]

    b	detect_item_329

detect_item_344:
    add	w17,	w7,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w17,	[x25]

    b	detect_item_329

detect_item_340:
    add	w19,	w7,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w19,	[x27]

    b	detect_item_329

detect_item_336:
    add	w24,	w7,	#1
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    str	w24,	[x0]

    b	detect_item_329

detect_item_321:
    add	w26,	w24,	#1
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    str	w26,	[x2]

    b	detect_item_302

detect_item_317:
    add	w28,	w24,	#1
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    str	w28,	[x4]

    b	detect_item_302

detect_item_313:
    add	w1,	w24,	#1
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    str	w1,	[x6]

    b	detect_item_302

detect_item_309:
    add	w3,	w24,	#1
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    str	w3,	[x8]

    b	detect_item_302

detect_item_289:
    add	w5,	w23,	#1
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    str	w5,	[x10]

    b	detect_item_270

detect_item_285:
    add	w7,	w23,	#1
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w7,	[x12]

    b	detect_item_270

detect_item_281:
    add	w9,	w23,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w9,	[x14]

    b	detect_item_270

detect_item_277:
    add	w11,	w23,	#1
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    str	w11,	[x16]

    b	detect_item_270

detect_item_795:
    movz	w0,	#0
    b	detect_item_807

detect_item_261:
    adrp	x13, :got:pos
    adrp	x15, :got:pos
    movz	w0,	#1
    ldr	x13, [x13, #:got_lo12:pos]
    ldr	w12,	[x13]

    ldr	x15, [x15, #:got_lo12:pos]
    add	w16,	w12,	#1
    str	w16,	[x15]

    b	detect_item_807

detect_item_249:
    add	w17,	w26,	#1
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    str	w17,	[x24]

    b	detect_item_230

detect_item_245:
    add	w19,	w26,	#1
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    str	w19,	[x26]

    b	detect_item_230

detect_item_241:
    add	w23,	w26,	#1
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    str	w23,	[x28]

    b	detect_item_230

detect_item_237:
    add	w26,	w26,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w26,	[x1]

    b	detect_item_230

detect_item_385:
    cmp	w0,	#4
    beq	detect_item_387

detect_item_664:
    cmp	w0,	#5
    beq	detect_item_666

detect_item_696:
    cmp	w0,	#6
    beq	detect_item_698

detect_item_734:
    cmp	w0,	#7
    beq	detect_item_736

detect_item_789:
    movz	w0,	#0
    b	detect_item_807

detect_item_736:
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    ldr	w6,	[x7]

    add	w8,	w6,	#3
    cmp	w8,	w22
    blt	detect_item_740

detect_item_790:
    movz	w0,	#0
    b	detect_item_807

detect_item_740:
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    ldr	w5,	[x6]

    lsl	w8,	w5,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#110
    beq	detect_item_745

detect_item_791:
    movz	w0,	#0
    b	detect_item_807

detect_item_745:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    add	w13,	w11,	#1
    lsl	w15,	w13,	#2
    add	x14,	x21,	x15
    ldr	w16,	[x14]

    cmp	w16,	#117
    beq	detect_item_751

detect_item_792:
    movz	w0,	#0
    b	detect_item_807

detect_item_751:
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    ldr	w18,	[x19]

    add	w20,	w18,	#2
    lsl	w23,	w20,	#2
    add	x22,	x21,	x23
    ldr	w24,	[x22]

    cmp	w24,	#108
    beq	detect_item_757

detect_item_793:
    movz	w0,	#0
    b	detect_item_807

detect_item_757:
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    ldr	w26,	[x27]

    add	w28,	w26,	#3
    lsl	w1,	w28,	#2
    add	x26,	x21,	x1
    ldr	w28,	[x26]

    cmp	w28,	#108
    beq	detect_item_763

detect_item_794:
    movz	w0,	#0
    b	detect_item_807

detect_item_763:
    adrp	x2, :got:pos
    adrp	x4, :got:pos
    movz	w0,	#1
    ldr	x2, [x2, #:got_lo12:pos]
    ldr	w1,	[x2]

    ldr	x4, [x4, #:got_lo12:pos]
    add	w7,	w1,	#4
    str	w7,	[x4]

    b	detect_item_807

detect_item_698:
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    ldr	w14,	[x15]

    add	w16,	w14,	#4
    cmp	w16,	w22
    blt	detect_item_702

detect_item_783:
    movz	w0,	#0
    b	detect_item_807

detect_item_702:
    adrp	x13, :got:pos
    ldr	x13, [x13, #:got_lo12:pos]
    ldr	w12,	[x13]

    lsl	w15,	w12,	#2
    add	x14,	x21,	x15
    ldr	w16,	[x14]

    cmp	w16,	#102
    beq	detect_item_707

detect_item_784:
    movz	w0,	#0
    b	detect_item_807

detect_item_707:
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    ldr	w18,	[x19]

    add	w20,	w18,	#1
    lsl	w23,	w20,	#2
    add	x22,	x21,	x23
    ldr	w24,	[x22]

    cmp	w24,	#97
    beq	detect_item_713

detect_item_785:
    movz	w0,	#0
    b	detect_item_807

detect_item_713:
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    ldr	w26,	[x27]

    add	w28,	w26,	#2
    lsl	w1,	w28,	#2
    add	x0,	x21,	x1
    ldr	w2,	[x0]

    cmp	w2,	#108
    beq	detect_item_719

detect_item_786:
    movz	w0,	#0
    b	detect_item_807

detect_item_719:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    add	w6,	w4,	#3
    lsl	w8,	w6,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#115
    beq	detect_item_725

detect_item_787:
    movz	w0,	#0
    b	detect_item_807

detect_item_725:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    add	w13,	w11,	#4
    lsl	w15,	w13,	#2
    add	x10,	x21,	x15
    ldr	w12,	[x10]

    cmp	w12,	#101
    beq	detect_item_731

detect_item_788:
    movz	w0,	#0
    b	detect_item_807

detect_item_731:
    adrp	x15, :got:pos
    adrp	x17, :got:pos
    movz	w0,	#1
    ldr	x15, [x15, #:got_lo12:pos]
    ldr	w14,	[x15]

    ldr	x17, [x17, #:got_lo12:pos]
    add	w21,	w14,	#5
    str	w21,	[x17]

    b	detect_item_807

detect_item_666:
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    ldr	w2,	[x3]

    add	w4,	w2,	#3
    cmp	w4,	w22
    blt	detect_item_670

detect_item_778:
    movz	w0,	#0
    b	detect_item_807

detect_item_670:
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w27,	[x28]

    lsl	w1,	w27,	#2
    add	x0,	x21,	x1
    ldr	w2,	[x0]

    cmp	w2,	#116
    beq	detect_item_675

detect_item_779:
    movz	w0,	#0
    b	detect_item_807

detect_item_675:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    add	w6,	w4,	#1
    lsl	w8,	w6,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#114
    beq	detect_item_681

detect_item_780:
    movz	w0,	#0
    b	detect_item_807

detect_item_681:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    add	w13,	w11,	#2
    lsl	w15,	w13,	#2
    add	x14,	x21,	x15
    ldr	w16,	[x14]

    cmp	w16,	#117
    beq	detect_item_687

detect_item_781:
    movz	w0,	#0
    b	detect_item_807

detect_item_687:
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    ldr	w18,	[x19]

    add	w20,	w18,	#3
    lsl	w23,	w20,	#2
    add	x16,	x21,	x23
    ldr	w18,	[x16]

    cmp	w18,	#101
    beq	detect_item_693

detect_item_782:
    movz	w0,	#0
    b	detect_item_807

detect_item_693:
    adrp	x21, :got:pos
    adrp	x23, :got:pos
    movz	w0,	#1
    ldr	x21, [x21, #:got_lo12:pos]
    ldr	w20,	[x21]

    ldr	x23, [x23, #:got_lo12:pos]
    add	w28,	w20,	#4
    str	w28,	[x23]

    b	detect_item_807

detect_item_387:
    adrp	x11, :got:pos
    adrp	x13, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w10,	[x11]

    ldr	x13, [x13, #:got_lo12:pos]
    add	w14,	w10,	#1
    str	w14,	[x13]


detect_item_390:
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    ldr	w5,	[x15]

    cmp	w5,	w22
    bge	detect_item_413

detect_item_393:
    lsl	w18,	w5,	#2
    add	x17,	x21,	x18
    ldr	w19,	[x17]

    cmp	w19,	#32
    beq	detect_item_397

detect_item_399:
    cmp	w19,	#9
    beq	detect_item_401

detect_item_403:
    cmp	w19,	#10
    beq	detect_item_405

detect_item_407:
    cmp	w19,	#13
    beq	detect_item_409

detect_item_413:
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    ldr	w26,	[x27]

    cmp	w26,	w22
    bge	detect_item_426

detect_item_416:
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    ldr	w0,	[x1]

    lsl	w3,	w0,	#2
    add	x2,	x21,	x3
    ldr	w4,	[x2]

    cmp	w4,	#125
    beq	detect_item_421

detect_item_426:
    movz	w0,	#2
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    beq	detect_item_768

detect_item_430:
    adrp	x9, :got:pos
    ldr	x9, [x9, #:got_lo12:pos]
    ldr	w2,	[x9]

    cmp	w2,	w22
    bge	detect_item_453

detect_item_433:
    lsl	w12,	w2,	#2
    add	x11,	x21,	x12
    ldr	w13,	[x11]

    cmp	w13,	#32
    beq	detect_item_437

detect_item_439:
    cmp	w13,	#9
    beq	detect_item_441

detect_item_443:
    cmp	w13,	#10
    beq	detect_item_445

detect_item_447:
    cmp	w13,	#13
    beq	detect_item_449

detect_item_453:
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    ldr	w18,	[x19]

    cmp	w18,	w22
    blt	detect_item_456

detect_item_769:
    movz	w0,	#0
    b	detect_item_807

detect_item_456:
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    ldr	w23,	[x24]

    lsl	w26,	w23,	#2
    add	x25,	x21,	x26
    ldr	w27,	[x25]

    cmp	w27,	#58
    beq	detect_item_461

detect_item_770:
    movz	w0,	#0
    b	detect_item_807

detect_item_461:
    adrp	x1, :got:pos
    adrp	x3, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    ldr	w0,	[x1]

    ldr	x3, [x3, #:got_lo12:pos]
    add	w6,	w0,	#1
    str	w6,	[x3]


detect_item_464:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w1,	[x5]

    cmp	w1,	w22
    bge	detect_item_487

detect_item_467:
    lsl	w8,	w1,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#32
    beq	detect_item_471

detect_item_473:
    cmp	w9,	#9
    beq	detect_item_475

detect_item_477:
    cmp	w9,	#10
    beq	detect_item_479

detect_item_481:
    cmp	w9,	#13
    beq	detect_item_483

detect_item_487:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    beq	detect_item_771

detect_item_491:
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    ldr	w13,	[x17]

    cmp	w13,	w22
    bge	detect_item_516

detect_item_494:
    lsl	w20,	w13,	#2
    add	x19,	x21,	x20
    ldr	w23,	[x19]

    cmp	w23,	#32
    beq	detect_item_498

detect_item_500:
    cmp	w23,	#9
    beq	detect_item_502

detect_item_504:
    cmp	w23,	#10
    beq	detect_item_506

detect_item_508:
    cmp	w23,	#13
    beq	detect_item_510

detect_item_516:
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    ldr	w28,	[x0]

    lsl	w2,	w28,	#2
    add	x1,	x21,	x2
    ldr	w3,	[x1]

    cmp	w3,	#44
    beq	detect_item_521

detect_item_630:
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    ldr	w5,	[x6]

    cmp	w5,	w22
    bge	detect_item_653

detect_item_633:
    lsl	w9,	w5,	#2
    add	x8,	x21,	x9
    ldr	w10,	[x8]

    cmp	w10,	#32
    beq	detect_item_637

detect_item_639:
    cmp	w10,	#9
    beq	detect_item_641

detect_item_643:
    cmp	w10,	#10
    beq	detect_item_645

detect_item_647:
    cmp	w10,	#13
    beq	detect_item_649

detect_item_653:
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    ldr	w15,	[x16]

    cmp	w15,	w22
    blt	detect_item_656

detect_item_776:
    movz	w0,	#0
    b	detect_item_807

detect_item_656:
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    ldr	w6,	[x7]

    lsl	w9,	w6,	#2
    add	x28,	x21,	x9
    ldr	w1,	[x28]

    cmp	w1,	#125
    beq	detect_item_661

detect_item_777:
    movz	w0,	#0
    b	detect_item_807

detect_item_661:
    adrp	x4, :got:pos
    adrp	x6, :got:pos
    movz	w0,	#1
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w3,	[x4]

    ldr	x6, [x6, #:got_lo12:pos]
    add	w15,	w3,	#1
    str	w15,	[x6]

    b	detect_item_807

detect_item_649:
    add	w7,	w5,	#1
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    str	w7,	[x2]

    b	detect_item_630

detect_item_645:
    add	w9,	w5,	#1
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    str	w9,	[x4]

    b	detect_item_630

detect_item_641:
    add	w11,	w5,	#1
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    str	w11,	[x6]

    b	detect_item_630

detect_item_637:
    add	w13,	w5,	#1
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    str	w13,	[x8]

    b	detect_item_630

detect_item_521:
    add	w15,	w28,	#1
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    str	w15,	[x10]


detect_item_523:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w17,	[x12]

    cmp	w17,	w22
    bge	detect_item_546

detect_item_526:
    lsl	w15,	w17,	#2
    add	x14,	x21,	x15
    ldr	w16,	[x14]

    cmp	w16,	#32
    beq	detect_item_530

detect_item_532:
    cmp	w16,	#9
    beq	detect_item_534

detect_item_536:
    cmp	w16,	#10
    beq	detect_item_538

detect_item_540:
    cmp	w16,	#13
    beq	detect_item_542

detect_item_546:
    movz	w0,	#2
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    beq	detect_item_772

detect_item_550:
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    ldr	w24,	[x26]

    cmp	w24,	w22
    bge	detect_item_573

detect_item_553:
    lsl	w0,	w24,	#2
    add	x28,	x21,	x0
    ldr	w1,	[x28]

    cmp	w1,	#32
    beq	detect_item_557

detect_item_559:
    cmp	w1,	#9
    beq	detect_item_561

detect_item_563:
    cmp	w1,	#10
    beq	detect_item_565

detect_item_567:
    cmp	w1,	#13
    beq	detect_item_569

detect_item_573:
    cmp	w24,	w22
    blt	detect_item_575

detect_item_773:
    movz	w0,	#0
    b	detect_item_807

detect_item_575:
    lsl	w8,	w24,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#58
    beq	detect_item_579

detect_item_774:
    movz	w0,	#0
    b	detect_item_807

detect_item_579:
    add	w18,	w24,	#1
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w18,	[x12]


detect_item_581:
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    ldr	w24,	[x14]

    cmp	w24,	w22
    bge	detect_item_604

detect_item_584:
    lsl	w17,	w24,	#2
    add	x16,	x21,	x17
    ldr	w18,	[x16]

    cmp	w18,	#32
    beq	detect_item_588

detect_item_590:
    cmp	w18,	#9
    beq	detect_item_592

detect_item_594:
    cmp	w18,	#10
    beq	detect_item_596

detect_item_598:
    cmp	w18,	#13
    beq	detect_item_600

detect_item_604:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_608

detect_item_775:
    movz	w0,	#0
    b	detect_item_807

detect_item_608:
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w10,	[x28]

    cmp	w10,	w22
    bge	detect_item_516

detect_item_611:
    lsl	w2,	w10,	#2
    add	x1,	x21,	x2
    ldr	w3,	[x1]

    cmp	w3,	#32
    beq	detect_item_615

detect_item_617:
    cmp	w3,	#9
    beq	detect_item_619

detect_item_621:
    cmp	w3,	#10
    beq	detect_item_623

detect_item_625:
    cmp	w3,	#13
    bne	detect_item_516

detect_item_627:
    add	w16,	w10,	#1
    adrp	x9, :got:pos
    ldr	x9, [x9, #:got_lo12:pos]
    str	w16,	[x9]

    b	detect_item_608

detect_item_623:
    add	w18,	w10,	#1
    adrp	x11, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    str	w18,	[x11]

    b	detect_item_608

detect_item_619:
    add	w20,	w10,	#1
    adrp	x13, :got:pos
    ldr	x13, [x13, #:got_lo12:pos]
    str	w20,	[x13]

    b	detect_item_608

detect_item_615:
    add	w24,	w10,	#1
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    str	w24,	[x15]

    b	detect_item_608

detect_item_600:
    add	w26,	w24,	#1
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    str	w26,	[x17]

    b	detect_item_581

detect_item_596:
    add	w28,	w24,	#1
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    str	w28,	[x19]

    b	detect_item_581

detect_item_592:
    add	w1,	w24,	#1
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    str	w1,	[x23]

    b	detect_item_581

detect_item_588:
    add	w3,	w24,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w3,	[x25]

    b	detect_item_581

detect_item_569:
    add	w5,	w24,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w5,	[x27]

    b	detect_item_550

detect_item_565:
    add	w8,	w24,	#1
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    str	w8,	[x0]

    b	detect_item_550

detect_item_561:
    add	w10,	w24,	#1
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    str	w10,	[x2]

    b	detect_item_550

detect_item_557:
    add	w12,	w24,	#1
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    str	w12,	[x4]

    b	detect_item_550

detect_item_772:
    movz	w0,	#0
    b	detect_item_807

detect_item_542:
    add	w14,	w17,	#1
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    str	w14,	[x6]

    b	detect_item_523

detect_item_538:
    add	w16,	w17,	#1
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    str	w16,	[x8]

    b	detect_item_523

detect_item_534:
    add	w18,	w17,	#1
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    str	w18,	[x10]

    b	detect_item_523

detect_item_530:
    add	w20,	w17,	#1
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w20,	[x12]

    b	detect_item_523

detect_item_510:
    add	w24,	w13,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w24,	[x14]

    b	detect_item_491

detect_item_506:
    add	w26,	w13,	#1
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    str	w26,	[x16]

    b	detect_item_491

detect_item_502:
    add	w28,	w13,	#1
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    str	w28,	[x18]

    b	detect_item_491

detect_item_498:
    add	w1,	w13,	#1
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    str	w1,	[x20]

    b	detect_item_491

detect_item_771:
    movz	w0,	#0
    b	detect_item_807

detect_item_483:
    add	w3,	w1,	#1
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    str	w3,	[x24]

    b	detect_item_464

detect_item_479:
    add	w5,	w1,	#1
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    str	w5,	[x26]

    b	detect_item_464

detect_item_475:
    add	w7,	w1,	#1
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    str	w7,	[x28]

    b	detect_item_464

detect_item_471:
    add	w10,	w1,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w10,	[x1]

    b	detect_item_464

detect_item_449:
    add	w12,	w2,	#1
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    str	w12,	[x3]

    b	detect_item_430

detect_item_445:
    add	w14,	w2,	#1
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    str	w14,	[x5]

    b	detect_item_430

detect_item_441:
    add	w16,	w2,	#1
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    str	w16,	[x7]

    b	detect_item_430

detect_item_437:
    add	w18,	w2,	#1
    adrp	x9, :got:pos
    ldr	x9, [x9, #:got_lo12:pos]
    str	w18,	[x9]

    b	detect_item_430

detect_item_768:
    movz	w0,	#0
    b	detect_item_807

detect_item_421:
    adrp	x9, :got:pos
    adrp	x11, :got:pos
    movz	w0,	#1
    ldr	x9, [x9, #:got_lo12:pos]
    ldr	w8,	[x9]

    ldr	x11, [x11, #:got_lo12:pos]
    add	w24,	w8,	#1
    str	w24,	[x11]

    b	detect_item_807

detect_item_409:
    add	w26,	w5,	#1
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    str	w26,	[x15]

    b	detect_item_390

detect_item_405:
    add	w28,	w5,	#1
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    str	w28,	[x17]

    b	detect_item_390

detect_item_401:
    add	w1,	w5,	#1
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    str	w1,	[x19]

    b	detect_item_390

detect_item_397:
    add	w3,	w5,	#1
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    str	w3,	[x23]

    b	detect_item_390

detect_item_36:
    lsl	w25,	w11,	#2
    add	x24,	x21,	x25
    ldr	w18,	[x24]

    cmp	w18,	#123
    bne	detect_item_51

detect_item_40:
    movz	w0,	#4
    b	detect_item_4

detect_item_51:
    cmp	w18,	#91
    bne	detect_item_53

detect_item_41:
    movz	w0,	#3
    b	detect_item_4

detect_item_53:
    cmp	w18,	#34
    bne	detect_item_55

detect_item_42:
    movz	w0,	#2
    b	detect_item_4

detect_item_55:
    cmp	w18,	#57
    cset	w2,	le
    cmp	w18,	#48
    movz	w11,	#0
    csel	w4,	w2,	w11,	ge
    cmp	w4,	#1
    bne	detect_item_61

detect_item_43:
    movz	w0,	#1
    b	detect_item_4

detect_item_61:
    cmp	w18,	#43
    bne	detect_item_63

detect_item_44:
    movz	w0,	#1
    b	detect_item_4

detect_item_63:
    cmp	w18,	#45
    bne	detect_item_65

detect_item_45:
    movz	w0,	#1
    b	detect_item_4

detect_item_65:
    cmp	w18,	#116
    bne	detect_item_67

detect_item_46:
    movz	w0,	#5
    b	detect_item_4

detect_item_67:
    cmp	w18,	#102
    bne	detect_item_69

detect_item_47:
    movz	w0,	#6
    b	detect_item_4

detect_item_69:
    cmp	w18,	#110
    beq	detect_item_48

detect_item_767:
    movz	w0,	#0
    b	detect_item_807

detect_item_48:
    movz	w0,	#7
    b	detect_item_4

detect_item_30:
    add	w28,	w11,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w28,	[x25]

    b	detect_item_11

detect_item_26:
    add	w2,	w11,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w2,	[x27]

    b	detect_item_11

detect_item_22:
    add	w5,	w11,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w5,	[x1]

    b	detect_item_11

detect_item_18:
    add	w7,	w11,	#1
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    str	w7,	[x3]

    b	detect_item_11

detect_item_766:
    movz	w0,	#0

detect_item_807:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getch
    movz	w19,	#0
    mov	w4,	w0

main_2:
    cmp	w4,	#35
    bne	main_6

main_10:
    adrp	x28, :got:buffer
    ldr	x28, [x28, #:got_lo12:buffer]

main_12:
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    ldr	w26,	[x2]

    cmp	w26,	w19
    bge	main_35

main_15:
    lsl	w5,	w26,	#2
    add	x4,	x28,	x5
    ldr	w6,	[x4]

    cmp	w6,	#32
    beq	main_19

main_21:
    cmp	w6,	#9
    beq	main_23

main_25:
    cmp	w6,	#10
    beq	main_27

main_29:
    cmp	w6,	#13
    beq	main_31

main_35:
    movz	w0,	#0
    mov	x1,	x28
    mov	w2,	w19
    bl	detect_item

main_37:
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    ldr	w9,	[x26]

    cmp	w9,	w19
    bge	main_60

main_40:
    lsl	w2,	w9,	#2
    add	x1,	x28,	x2
    ldr	w3,	[x1]

    cmp	w3,	#32
    beq	main_44

main_46:
    cmp	w3,	#9
    beq	main_48

main_50:
    cmp	w3,	#10
    beq	main_52

main_54:
    cmp	w3,	#13
    beq	main_56

main_60:
    cmp	w0,	#0
    bne	main_62

main_63:
    movz	w0,	#110
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#116
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#1
    b	main_64

main_62:
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#0

main_64:
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_56:
    add	w15,	w9,	#1
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    str	w15,	[x10]

    b	main_37

main_52:
    add	w17,	w9,	#1
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w17,	[x12]

    b	main_37

main_48:
    add	w20,	w9,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w20,	[x14]

    b	main_37

main_44:
    add	w22,	w9,	#1
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    str	w22,	[x16]

    b	main_37

main_31:
    add	w17,	w26,	#1
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    str	w17,	[x5]

    b	main_12

main_27:
    add	w20,	w26,	#1
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    str	w20,	[x7]

    b	main_12

main_23:
    add	w22,	w26,	#1
    adrp	x9, :got:pos
    ldr	x9, [x9, #:got_lo12:pos]
    str	w22,	[x9]

    b	main_12

main_19:
    add	w24,	w26,	#1
    adrp	x11, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    str	w24,	[x11]

    b	main_12

main_6:
    lsl	w23,	w19,	#2
    adrp	x25, :got:buffer
    add	w19,	w19,	#1
    ldr	x25, [x25, #:got_lo12:buffer]
    add	x23,	x25,	x23
    str	w4,	[x23]

    bl	getch
    mov	w4,	w0
    b	main_2

