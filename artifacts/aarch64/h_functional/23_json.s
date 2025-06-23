.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global pos
.align	2
pos:
    .zero	4

.global buffer
.align	2
buffer:
    .zero	200000000


.text

.globl detect_item
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
    blt	detect_item_11

detect_item_766:
    movz	w0,	#0
    b	detect_item_807

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
    bne	detect_item_20

detect_item_18:
    add	w28,	w11,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w28,	[x25]

    b	detect_item_11

detect_item_20:
    cmp	w20,	#9
    bne	detect_item_24

detect_item_22:
    add	w3,	w11,	#1
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    str	w3,	[x28]

    b	detect_item_11

detect_item_24:
    cmp	w20,	#10
    bne	detect_item_28

detect_item_26:
    add	w7,	w11,	#1
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    str	w7,	[x3]

    b	detect_item_11

detect_item_28:
    cmp	w20,	#13
    bne	detect_item_34

detect_item_30:
    add	w10,	w11,	#1
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    str	w10,	[x6]

    b	detect_item_11

detect_item_34:
    cmp	w0,	#0
    bne	detect_item_71

detect_item_36:
    lsl	w24,	w11,	#2
    add	x23,	x21,	x24
    ldr	w20,	[x23]

    cmp	w20,	#123
    beq	detect_item_60

detect_item_40:
    cmp	w20,	#91
    beq	detect_item_61

detect_item_42:
    cmp	w20,	#34
    beq	detect_item_62

detect_item_44:
    cmp	w20,	#57
    cset	w1,	le
    cmp	w20,	#48
    movz	w6,	#0
    csel	w3,	w1,	w6,	ge
    cmp	w3,	#1
    beq	detect_item_63

detect_item_50:
    cmp	w20,	#43
    beq	detect_item_64

detect_item_52:
    cmp	w20,	#45
    beq	detect_item_65

detect_item_54:
    cmp	w20,	#116
    beq	detect_item_66

detect_item_56:
    cmp	w20,	#102
    beq	detect_item_67

detect_item_58:
    cmp	w20,	#110
    bne	detect_item_767

detect_item_68:
    movz	w0,	#7
    b	detect_item_4

detect_item_767:
    movz	w0,	#0
    b	detect_item_807

detect_item_67:
    movz	w0,	#6
    b	detect_item_4

detect_item_66:
    movz	w0,	#5
    b	detect_item_4

detect_item_65:
    movz	w0,	#1
    b	detect_item_4

detect_item_64:
    movz	w0,	#1
    b	detect_item_4

detect_item_63:
    movz	w0,	#1
    b	detect_item_4

detect_item_62:
    movz	w0,	#2
    b	detect_item_4

detect_item_61:
    movz	w0,	#3
    b	detect_item_4

detect_item_60:
    movz	w0,	#4
    b	detect_item_4

detect_item_71:
    cmp	w0,	#1
    bne	detect_item_194

detect_item_73:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    lsl	w14,	w11,	#2
    add	x13,	x21,	x14
    ldr	w15,	[x13]

    cmp	w15,	#43
    bne	detect_item_81

detect_item_78:
    adrp	x18, :got:pos
    adrp	x20, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    ldr	w17,	[x18]

    ldr	x20, [x20, #:got_lo12:pos]
    add	w6,	w17,	#1
    str	w6,	[x20]

    b	detect_item_90

detect_item_81:
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    ldr	w23,	[x24]

    lsl	w26,	w23,	#2
    add	x25,	x21,	x26
    ldr	w27,	[x25]

    cmp	w27,	#45
    bne	detect_item_90

detect_item_86:
    adrp	x1, :got:pos
    adrp	x3, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    ldr	w0,	[x1]

    ldr	x3, [x3, #:got_lo12:pos]
    add	w17,	w0,	#1
    str	w17,	[x3]


detect_item_90:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    cmp	w4,	w22
    bge	detect_item_768

detect_item_93:
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    ldr	w7,	[x8]

    lsl	w10,	w7,	#2
    add	x9,	x21,	x10
    ldr	w28,	[x9]

    cmp	w28,	#57
    cset	w13,	le
    cmp	w28,	#48
    movz	w8,	#0
    csel	w15,	w13,	w8,	ge
    cmp	w15,	#0
    bne	detect_item_103

detect_item_769:
    movz	w0,	#0
    b	detect_item_807

detect_item_103:
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    ldr	w24,	[x18]

    cmp	w24,	w22
    bge	detect_item_118

detect_item_106:
    lsl	w23,	w24,	#2
    add	x20,	x21,	x23
    ldr	w10,	[x20]

    cmp	w10,	#57
    cset	w26,	le
    cmp	w10,	#48
    movz	w10,	#0
    csel	w28,	w26,	w10,	ge
    cmp	w28,	#1
    bne	detect_item_118

detect_item_114:
    add	w17,	w24,	#1
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    str	w17,	[x2]

    b	detect_item_103

detect_item_118:
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w3,	[x4]

    cmp	w3,	w22
    bge	detect_item_146

detect_item_121:
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    ldr	w6,	[x7]

    lsl	w9,	w6,	#2
    add	x8,	x21,	x9
    ldr	w10,	[x8]

    cmp	w10,	#46
    bne	detect_item_146

detect_item_126:
    adrp	x13, :got:pos
    adrp	x15, :got:pos
    ldr	x13, [x13, #:got_lo12:pos]
    ldr	w12,	[x13]

    ldr	x15, [x15, #:got_lo12:pos]
    add	w3,	w12,	#1
    str	w3,	[x15]


detect_item_129:
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    ldr	w26,	[x17]

    cmp	w26,	w22
    bge	detect_item_146

detect_item_132:
    lsl	w20,	w26,	#2
    add	x19,	x21,	x20
    ldr	w10,	[x19]

    cmp	w10,	#57
    cset	w25,	le
    cmp	w10,	#48
    movz	w13,	#0
    csel	w27,	w25,	w13,	ge
    cmp	w27,	#1
    bne	detect_item_146

detect_item_140:
    add	w17,	w26,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w17,	[x1]

    b	detect_item_129

detect_item_146:
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    ldr	w2,	[x3]

    cmp	w2,	w22
    bge	detect_item_770

detect_item_149:
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    ldr	w5,	[x6]

    lsl	w8,	w5,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#101
    bne	detect_item_771

detect_item_154:
    adrp	x12, :got:pos
    adrp	x14, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    ldr	x14, [x14, #:got_lo12:pos]
    add	w3,	w11,	#1
    str	w3,	[x14]

    cmp	w3,	w22
    bge	detect_item_168

detect_item_158:
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    ldr	w16,	[x17]

    lsl	w19,	w16,	#2
    add	x18,	x21,	x19
    ldr	w20,	[x18]

    cmp	w20,	#43
    bne	detect_item_168

detect_item_163:
    adrp	x25, :got:pos
    adrp	x27, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    ldr	w24,	[x25]

    ldr	x27, [x27, #:got_lo12:pos]
    add	w14,	w24,	#1
    str	w14,	[x27]


detect_item_168:
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    ldr	w28,	[x0]

    cmp	w28,	w22
    bge	detect_item_181

detect_item_171:
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    ldr	w2,	[x3]

    lsl	w5,	w2,	#2
    add	x4,	x21,	x5
    ldr	w6,	[x4]

    cmp	w6,	#45
    bne	detect_item_181

detect_item_176:
    adrp	x9, :got:pos
    adrp	x11, :got:pos
    ldr	x9, [x9, #:got_lo12:pos]
    ldr	w8,	[x9]

    ldr	x11, [x11, #:got_lo12:pos]
    add	w1,	w8,	#1
    str	w1,	[x11]


detect_item_181:
    adrp	x13, :got:pos
    ldr	x13, [x13, #:got_lo12:pos]
    ldr	w6,	[x13]

    cmp	w6,	w22
    bge	detect_item_772

detect_item_184:
    lsl	w16,	w6,	#2
    add	x15,	x21,	x16
    ldr	w8,	[x15]

    cmp	w8,	#57
    cset	w19,	le
    cmp	w8,	#48
    movz	w18,	#0
    csel	w23,	w19,	w18,	ge
    cmp	w23,	#1
    bne	detect_item_773

detect_item_192:
    add	w14,	w6,	#1
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    str	w14,	[x26]

    b	detect_item_181

detect_item_773:
    movz	w0,	#1
    b	detect_item_807

detect_item_772:
    movz	w0,	#1
    b	detect_item_807

detect_item_771:
    movz	w0,	#1
    b	detect_item_807

detect_item_770:
    movz	w0,	#1
    b	detect_item_807

detect_item_768:
    movz	w0,	#0
    b	detect_item_807

detect_item_194:
    cmp	w0,	#2
    bne	detect_item_225

detect_item_196:
    adrp	x0, :got:pos
    adrp	x2, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    ldr	w28,	[x0]

    ldr	x2, [x2, #:got_lo12:pos]
    add	w20,	w28,	#1
    str	w20,	[x2]


detect_item_199:
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w18,	[x4]

    cmp	w18,	w22
    bge	detect_item_214

detect_item_202:
    lsl	w7,	w18,	#2
    add	x6,	x21,	x7
    ldr	w8,	[x6]

    cmp	w8,	#34
    beq	detect_item_214

detect_item_206:
    cmp	w8,	#92
    bne	detect_item_210

detect_item_208:
    add	w3,	w18,	#2
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w3,	[x12]

    b	detect_item_199

detect_item_210:
    add	w5,	w18,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w5,	[x14]

    b	detect_item_199

detect_item_214:
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    ldr	w15,	[x16]

    cmp	w15,	w22
    bge	detect_item_774

detect_item_217:
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    ldr	w18,	[x19]

    lsl	w22,	w18,	#2
    add	x23,	x21,	x22
    ldr	w25,	[x23]

    cmp	w25,	#34
    bne	detect_item_775

detect_item_222:
    adrp	x28, :got:pos
    adrp	x1, :got:pos
    movz	w0,	#1
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w27,	[x28]

    ldr	x1, [x1, #:got_lo12:pos]
    add	w27,	w27,	#1
    str	w27,	[x1]

    b	detect_item_807

detect_item_775:
    movz	w0,	#0
    b	detect_item_807

detect_item_774:
    movz	w0,	#0
    b	detect_item_807

detect_item_225:
    cmp	w0,	#3
    bne	detect_item_385

detect_item_227:
    adrp	x3, :got:pos
    adrp	x5, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    ldr	w2,	[x3]

    ldr	x5, [x5, #:got_lo12:pos]
    add	w26,	w2,	#1
    str	w26,	[x5]


detect_item_230:
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    ldr	w26,	[x7]

    cmp	w26,	w22
    bge	detect_item_253

detect_item_233:
    lsl	w10,	w26,	#2
    add	x9,	x21,	x10
    ldr	w11,	[x9]

    cmp	w11,	#32
    bne	detect_item_239

detect_item_237:
    add	w6,	w26,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w6,	[x14]

    b	detect_item_230

detect_item_239:
    cmp	w11,	#9
    bne	detect_item_243

detect_item_241:
    add	w9,	w26,	#1
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    str	w9,	[x17]

    b	detect_item_230

detect_item_243:
    cmp	w11,	#10
    bne	detect_item_247

detect_item_245:
    add	w12,	w26,	#1
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    str	w12,	[x20]

    b	detect_item_230

detect_item_247:
    cmp	w11,	#13
    bne	detect_item_253

detect_item_249:
    add	w15,	w26,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w15,	[x25]

    b	detect_item_230

detect_item_253:
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    ldr	w26,	[x27]

    cmp	w26,	w22
    bge	detect_item_266

detect_item_256:
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    ldr	w0,	[x1]

    lsl	w3,	w0,	#2
    add	x2,	x21,	x3
    ldr	w4,	[x2]

    cmp	w4,	#93
    bne	detect_item_266

detect_item_261:
    adrp	x6, :got:pos
    adrp	x8, :got:pos
    movz	w0,	#1
    ldr	x6, [x6, #:got_lo12:pos]
    ldr	w5,	[x6]

    ldr	x8, [x8, #:got_lo12:pos]
    add	w6,	w5,	#1
    str	w6,	[x8]

    b	detect_item_807

detect_item_266:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_270

detect_item_776:
    movz	w0,	#0
    b	detect_item_807

detect_item_270:
    adrp	x13, :got:pos
    ldr	x13, [x13, #:got_lo12:pos]
    ldr	w6,	[x13]

    cmp	w6,	w22
    bge	detect_item_295

detect_item_273:
    lsl	w16,	w6,	#2
    add	x15,	x21,	x16
    ldr	w17,	[x15]

    cmp	w17,	#32
    bne	detect_item_279

detect_item_277:
    add	w13,	w6,	#1
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    str	w13,	[x20]

    b	detect_item_270

detect_item_279:
    cmp	w17,	#9
    bne	detect_item_283

detect_item_281:
    add	w16,	w6,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w16,	[x25]

    b	detect_item_270

detect_item_283:
    cmp	w17,	#10
    bne	detect_item_287

detect_item_285:
    add	w19,	w6,	#1
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    str	w19,	[x28]

    b	detect_item_270

detect_item_287:
    cmp	w17,	#13
    bne	detect_item_295

detect_item_289:
    add	w25,	w6,	#1
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    str	w25,	[x2]

    b	detect_item_270

detect_item_295:
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w0,	[x4]

    lsl	w6,	w0,	#2
    add	x5,	x21,	x6
    ldr	w7,	[x5]

    cmp	w7,	#44
    bne	detect_item_351

detect_item_300:
    add	w4,	w0,	#1
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    str	w4,	[x10]


detect_item_302:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w8,	[x12]

    cmp	w8,	w22
    bge	detect_item_325

detect_item_305:
    lsl	w15,	w8,	#2
    add	x14,	x21,	x15
    ldr	w16,	[x14]

    cmp	w16,	#32
    bne	detect_item_311

detect_item_309:
    add	w13,	w8,	#1
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    str	w13,	[x19]

    b	detect_item_302

detect_item_311:
    cmp	w16,	#9
    bne	detect_item_315

detect_item_313:
    add	w16,	w8,	#1
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    str	w16,	[x24]

    b	detect_item_302

detect_item_315:
    cmp	w16,	#10
    bne	detect_item_319

detect_item_317:
    add	w19,	w8,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w19,	[x27]

    b	detect_item_302

detect_item_319:
    cmp	w16,	#13
    bne	detect_item_325

detect_item_321:
    add	w25,	w8,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w25,	[x1]

    b	detect_item_302

detect_item_325:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_329

detect_item_777:
    movz	w0,	#0
    b	detect_item_807

detect_item_329:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    cmp	w4,	w22
    bge	detect_item_295

detect_item_332:
    lsl	w8,	w4,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#32
    bne	detect_item_338

detect_item_336:
    add	w7,	w4,	#1
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w7,	[x12]

    b	detect_item_329

detect_item_338:
    cmp	w9,	#9
    bne	detect_item_342

detect_item_340:
    add	w10,	w4,	#1
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    str	w10,	[x15]

    b	detect_item_329

detect_item_342:
    cmp	w9,	#10
    bne	detect_item_346

detect_item_344:
    add	w13,	w4,	#1
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    str	w13,	[x18]

    b	detect_item_329

detect_item_346:
    cmp	w9,	#13
    bne	detect_item_295

detect_item_348:
    add	w16,	w4,	#1
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    str	w16,	[x23]

    b	detect_item_329

detect_item_351:
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    ldr	w25,	[x25]

    cmp	w25,	w22
    bge	detect_item_374

detect_item_354:
    lsl	w28,	w25,	#2
    add	x27,	x21,	x28
    ldr	w0,	[x27]

    cmp	w0,	#32
    bne	detect_item_360

detect_item_358:
    add	w28,	w25,	#1
    adrp	x3, :got:pos
    ldr	x3, [x3, #:got_lo12:pos]
    str	w28,	[x3]

    b	detect_item_351

detect_item_360:
    cmp	w0,	#9
    bne	detect_item_364

detect_item_362:
    add	w2,	w25,	#1
    adrp	x6, :got:pos
    ldr	x6, [x6, #:got_lo12:pos]
    str	w2,	[x6]

    b	detect_item_351

detect_item_364:
    cmp	w0,	#10
    bne	detect_item_368

detect_item_366:
    add	w5,	w25,	#1
    adrp	x9, :got:pos
    ldr	x9, [x9, #:got_lo12:pos]
    str	w5,	[x9]

    b	detect_item_351

detect_item_368:
    cmp	w0,	#13
    bne	detect_item_374

detect_item_370:
    add	w8,	w25,	#1
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w8,	[x12]

    b	detect_item_351

detect_item_374:
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    ldr	w13,	[x14]

    cmp	w13,	w22
    bge	detect_item_778

detect_item_377:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    lsl	w14,	w11,	#2
    add	x11,	x21,	x14
    ldr	w13,	[x11]

    cmp	w13,	#93
    bne	detect_item_779

detect_item_382:
    adrp	x16, :got:pos
    adrp	x18, :got:pos
    movz	w0,	#1
    ldr	x16, [x16, #:got_lo12:pos]
    ldr	w15,	[x16]

    ldr	x18, [x18, #:got_lo12:pos]
    add	w20,	w15,	#1
    str	w20,	[x18]

    b	detect_item_807

detect_item_779:
    movz	w0,	#0
    b	detect_item_807

detect_item_778:
    movz	w0,	#0
    b	detect_item_807

detect_item_385:
    cmp	w0,	#4
    bne	detect_item_664

detect_item_387:
    adrp	x1, :got:pos
    adrp	x3, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    ldr	w0,	[x1]

    ldr	x3, [x3, #:got_lo12:pos]
    add	w0,	w0,	#1
    str	w0,	[x3]


detect_item_390:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w13,	[x5]

    cmp	w13,	w22
    bge	detect_item_413

detect_item_393:
    lsl	w8,	w13,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#32
    bne	detect_item_399

detect_item_397:
    add	w9,	w13,	#1
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    str	w9,	[x12]

    b	detect_item_390

detect_item_399:
    cmp	w9,	#9
    bne	detect_item_403

detect_item_401:
    add	w12,	w13,	#1
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    str	w12,	[x15]

    b	detect_item_390

detect_item_403:
    cmp	w9,	#10
    bne	detect_item_407

detect_item_405:
    add	w15,	w13,	#1
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    str	w15,	[x18]

    b	detect_item_390

detect_item_407:
    cmp	w9,	#13
    bne	detect_item_413

detect_item_409:
    add	w18,	w13,	#1
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    str	w18,	[x23]

    b	detect_item_390

detect_item_413:
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    ldr	w24,	[x25]

    cmp	w24,	w22
    bge	detect_item_426

detect_item_416:
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w27,	[x28]

    lsl	w1,	w27,	#2
    add	x0,	x21,	x1
    ldr	w2,	[x0]

    cmp	w2,	#125
    bne	detect_item_426

detect_item_421:
    adrp	x23, :got:pos
    adrp	x25, :got:pos
    movz	w0,	#1
    ldr	x23, [x23, #:got_lo12:pos]
    ldr	w22,	[x23]

    ldr	x25, [x25, #:got_lo12:pos]
    add	w28,	w22,	#1
    str	w28,	[x25]

    b	detect_item_807

detect_item_426:
    movz	w0,	#2
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_430

detect_item_780:
    movz	w0,	#0
    b	detect_item_807

detect_item_430:
    adrp	x11, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w24,	[x11]

    cmp	w24,	w22
    bge	detect_item_453

detect_item_433:
    lsl	w14,	w24,	#2
    add	x13,	x21,	x14
    ldr	w15,	[x13]

    cmp	w15,	#32
    bne	detect_item_439

detect_item_437:
    add	w16,	w24,	#1
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    str	w16,	[x18]

    b	detect_item_430

detect_item_439:
    cmp	w15,	#9
    bne	detect_item_443

detect_item_441:
    add	w19,	w24,	#1
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    str	w19,	[x23]

    b	detect_item_430

detect_item_443:
    cmp	w15,	#10
    bne	detect_item_447

detect_item_445:
    add	w24,	w24,	#1
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    str	w24,	[x26]

    b	detect_item_430

detect_item_447:
    cmp	w15,	#13
    bne	detect_item_453

detect_item_449:
    add	w28,	w24,	#1
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    str	w28,	[x0]

    b	detect_item_430

detect_item_453:
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    ldr	w1,	[x2]

    cmp	w1,	w22
    bge	detect_item_781

detect_item_456:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    lsl	w7,	w4,	#2
    add	x6,	x21,	x7
    ldr	w8,	[x6]

    cmp	w8,	#58
    bne	detect_item_782

detect_item_461:
    adrp	x11, :got:pos
    adrp	x13, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w10,	[x11]

    ldr	x13, [x13, #:got_lo12:pos]
    add	w12,	w10,	#1
    str	w12,	[x13]


detect_item_464:
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    ldr	w2,	[x15]

    cmp	w2,	w22
    bge	detect_item_487

detect_item_467:
    lsl	w18,	w2,	#2
    add	x17,	x21,	x18
    ldr	w19,	[x17]

    cmp	w19,	#32
    bne	detect_item_473

detect_item_471:
    add	w23,	w2,	#1
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    str	w23,	[x24]

    b	detect_item_464

detect_item_473:
    cmp	w19,	#9
    bne	detect_item_477

detect_item_475:
    add	w26,	w2,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w26,	[x27]

    b	detect_item_464

detect_item_477:
    cmp	w19,	#10
    bne	detect_item_481

detect_item_479:
    add	w2,	w2,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w2,	[x1]

    b	detect_item_464

detect_item_481:
    cmp	w19,	#13
    bne	detect_item_487

detect_item_483:
    add	w5,	w2,	#1
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    str	w5,	[x4]

    b	detect_item_464

detect_item_487:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_491

detect_item_783:
    movz	w0,	#0
    b	detect_item_807

detect_item_491:
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    ldr	w27,	[x8]

    cmp	w27,	w22
    bge	detect_item_516

detect_item_494:
    lsl	w11,	w27,	#2
    add	x10,	x21,	x11
    ldr	w12,	[x10]

    cmp	w12,	#32
    bne	detect_item_500

detect_item_498:
    add	w16,	w27,	#1
    adrp	x15, :got:pos
    ldr	x15, [x15, #:got_lo12:pos]
    str	w16,	[x15]

    b	detect_item_491

detect_item_500:
    cmp	w12,	#9
    bne	detect_item_504

detect_item_502:
    add	w19,	w27,	#1
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    str	w19,	[x18]

    b	detect_item_491

detect_item_504:
    cmp	w12,	#10
    bne	detect_item_508

detect_item_506:
    add	w24,	w27,	#1
    adrp	x23, :got:pos
    ldr	x23, [x23, #:got_lo12:pos]
    str	w24,	[x23]

    b	detect_item_491

detect_item_508:
    cmp	w12,	#13
    bne	detect_item_516

detect_item_510:
    add	w27,	w27,	#1
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    str	w27,	[x26]

    b	detect_item_491

detect_item_516:
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w19,	[x28]

    lsl	w1,	w19,	#2
    add	x0,	x21,	x1
    ldr	w2,	[x0]

    cmp	w2,	#44
    bne	detect_item_630

detect_item_521:
    add	w7,	w19,	#1
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    str	w7,	[x5]


detect_item_523:
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    ldr	w0,	[x7]

    cmp	w0,	w22
    bge	detect_item_546

detect_item_526:
    lsl	w10,	w0,	#2
    add	x9,	x21,	x10
    ldr	w11,	[x9]

    cmp	w11,	#32
    bne	detect_item_532

detect_item_530:
    add	w16,	w0,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w16,	[x14]

    b	detect_item_523

detect_item_532:
    cmp	w11,	#9
    bne	detect_item_536

detect_item_534:
    add	w19,	w0,	#1
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    str	w19,	[x17]

    b	detect_item_523

detect_item_536:
    cmp	w11,	#10
    bne	detect_item_540

detect_item_538:
    add	w24,	w0,	#1
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    str	w24,	[x20]

    b	detect_item_523

detect_item_540:
    cmp	w11,	#13
    bne	detect_item_546

detect_item_542:
    add	w27,	w0,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w27,	[x25]

    b	detect_item_523

detect_item_546:
    movz	w0,	#2
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_550

detect_item_784:
    movz	w0,	#0
    b	detect_item_807

detect_item_550:
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    ldr	w5,	[x0]

    cmp	w5,	w22
    bge	detect_item_573

detect_item_553:
    lsl	w3,	w5,	#2
    add	x2,	x21,	x3
    ldr	w4,	[x2]

    cmp	w4,	#32
    bne	detect_item_559

detect_item_557:
    add	w10,	w5,	#1
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    str	w10,	[x7]

    b	detect_item_550

detect_item_559:
    cmp	w4,	#9
    bne	detect_item_563

detect_item_561:
    add	w13,	w5,	#1
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    str	w13,	[x10]

    b	detect_item_550

detect_item_563:
    cmp	w4,	#10
    bne	detect_item_567

detect_item_565:
    add	w16,	w5,	#1
    adrp	x13, :got:pos
    ldr	x13, [x13, #:got_lo12:pos]
    str	w16,	[x13]

    b	detect_item_550

detect_item_567:
    cmp	w4,	#13
    bne	detect_item_573

detect_item_569:
    add	w19,	w5,	#1
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    str	w19,	[x16]

    b	detect_item_550

detect_item_573:
    cmp	w5,	w22
    bge	detect_item_785

detect_item_575:
    lsl	w19,	w5,	#2
    add	x18,	x21,	x19
    ldr	w20,	[x18]

    cmp	w20,	#58
    bne	detect_item_786

detect_item_579:
    add	w28,	w5,	#1
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    str	w28,	[x25]


detect_item_581:
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    ldr	w26,	[x27]

    cmp	w26,	w22
    bge	detect_item_604

detect_item_584:
    lsl	w1,	w26,	#2
    add	x0,	x21,	x1
    ldr	w2,	[x0]

    cmp	w2,	#32
    bne	detect_item_590

detect_item_588:
    add	w9,	w26,	#1
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    str	w9,	[x5]

    b	detect_item_581

detect_item_590:
    cmp	w2,	#9
    bne	detect_item_594

detect_item_592:
    add	w12,	w26,	#1
    adrp	x8, :got:pos
    ldr	x8, [x8, #:got_lo12:pos]
    str	w12,	[x8]

    b	detect_item_581

detect_item_594:
    cmp	w2,	#10
    bne	detect_item_598

detect_item_596:
    add	w15,	w26,	#1
    adrp	x11, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    str	w15,	[x11]

    b	detect_item_581

detect_item_598:
    cmp	w2,	#13
    bne	detect_item_604

detect_item_600:
    add	w18,	w26,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w18,	[x14]

    b	detect_item_581

detect_item_604:
    movz	w0,	#0
    mov	x1,	x21
    mov	w2,	w22
    bl	detect_item
    cmp	w0,	#0
    bne	detect_item_608

detect_item_787:
    movz	w0,	#0
    b	detect_item_807

detect_item_608:
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    ldr	w17,	[x18]

    cmp	w17,	w22
    bge	detect_item_516

detect_item_611:
    lsl	w23,	w17,	#2
    add	x20,	x21,	x23
    ldr	w24,	[x20]

    cmp	w24,	#32
    bne	detect_item_617

detect_item_615:
    add	w2,	w17,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w2,	[x27]

    b	detect_item_608

detect_item_617:
    cmp	w24,	#9
    bne	detect_item_621

detect_item_619:
    add	w6,	w17,	#1
    adrp	x1, :got:pos
    ldr	x1, [x1, #:got_lo12:pos]
    str	w6,	[x1]

    b	detect_item_608

detect_item_621:
    cmp	w24,	#10
    bne	detect_item_625

detect_item_623:
    add	w9,	w17,	#1
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    str	w9,	[x4]

    b	detect_item_608

detect_item_625:
    cmp	w24,	#13
    bne	detect_item_516

detect_item_627:
    add	w12,	w17,	#1
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    str	w12,	[x7]

    b	detect_item_608

detect_item_786:
    movz	w0,	#0
    b	detect_item_807

detect_item_785:
    movz	w0,	#0
    b	detect_item_807

detect_item_630:
    adrp	x9, :got:pos
    ldr	x9, [x9, #:got_lo12:pos]
    ldr	w14,	[x9]

    cmp	w14,	w22
    bge	detect_item_653

detect_item_633:
    lsl	w12,	w14,	#2
    add	x11,	x21,	x12
    ldr	w13,	[x11]

    cmp	w13,	#32
    bne	detect_item_639

detect_item_637:
    add	w23,	w14,	#1
    adrp	x16, :got:pos
    ldr	x16, [x16, #:got_lo12:pos]
    str	w23,	[x16]

    b	detect_item_630

detect_item_639:
    cmp	w13,	#9
    bne	detect_item_643

detect_item_641:
    add	w26,	w14,	#1
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    str	w26,	[x19]

    b	detect_item_630

detect_item_643:
    cmp	w13,	#10
    bne	detect_item_647

detect_item_645:
    add	w0,	w14,	#1
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    str	w0,	[x24]

    b	detect_item_630

detect_item_647:
    cmp	w13,	#13
    bne	detect_item_653

detect_item_649:
    add	w3,	w14,	#1
    adrp	x27, :got:pos
    ldr	x27, [x27, #:got_lo12:pos]
    str	w3,	[x27]

    b	detect_item_630

detect_item_653:
    adrp	x0, :got:pos
    ldr	x0, [x0, #:got_lo12:pos]
    ldr	w28,	[x0]

    cmp	w28,	w22
    bge	detect_item_788

detect_item_656:
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    ldr	w16,	[x17]

    lsl	w19,	w16,	#2
    add	x8,	x21,	x19
    ldr	w10,	[x8]

    cmp	w10,	#125
    bne	detect_item_789

detect_item_661:
    adrp	x13, :got:pos
    adrp	x15, :got:pos
    movz	w0,	#1
    ldr	x13, [x13, #:got_lo12:pos]
    ldr	w12,	[x13]

    ldr	x15, [x15, #:got_lo12:pos]
    add	w25,	w12,	#1
    str	w25,	[x15]

    b	detect_item_807

detect_item_789:
    movz	w0,	#0
    b	detect_item_807

detect_item_788:
    movz	w0,	#0
    b	detect_item_807

detect_item_782:
    movz	w0,	#0
    b	detect_item_807

detect_item_781:
    movz	w0,	#0
    b	detect_item_807

detect_item_664:
    cmp	w0,	#5
    bne	detect_item_696

detect_item_666:
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    ldr	w13,	[x14]

    add	w15,	w13,	#3
    cmp	w15,	w22
    bge	detect_item_790

detect_item_670:
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w3,	[x4]

    lsl	w6,	w3,	#2
    add	x5,	x21,	x6
    ldr	w7,	[x5]

    cmp	w7,	#116
    bne	detect_item_791

detect_item_675:
    adrp	x10, :got:pos
    ldr	x10, [x10, #:got_lo12:pos]
    ldr	w9,	[x10]

    add	w11,	w9,	#1
    lsl	w13,	w11,	#2
    add	x12,	x21,	x13
    ldr	w14,	[x12]

    cmp	w14,	#114
    bne	detect_item_792

detect_item_681:
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    ldr	w16,	[x17]

    add	w18,	w16,	#2
    lsl	w20,	w18,	#2
    add	x19,	x21,	x20
    ldr	w22,	[x19]

    cmp	w22,	#117
    bne	detect_item_793

detect_item_687:
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    ldr	w24,	[x25]

    add	w26,	w24,	#3
    lsl	w28,	w26,	#2
    add	x15,	x21,	x28
    ldr	w17,	[x15]

    cmp	w17,	#101
    bne	detect_item_794

detect_item_693:
    adrp	x20, :got:pos
    adrp	x22, :got:pos
    movz	w0,	#1
    ldr	x20, [x20, #:got_lo12:pos]
    ldr	w19,	[x20]

    ldr	x22, [x22, #:got_lo12:pos]
    add	w4,	w19,	#4
    str	w4,	[x22]

    b	detect_item_807

detect_item_794:
    movz	w0,	#0
    b	detect_item_807

detect_item_793:
    movz	w0,	#0
    b	detect_item_807

detect_item_792:
    movz	w0,	#0
    b	detect_item_807

detect_item_791:
    movz	w0,	#0
    b	detect_item_807

detect_item_790:
    movz	w0,	#0
    b	detect_item_807

detect_item_696:
    cmp	w0,	#6
    bne	detect_item_734

detect_item_698:
    adrp	x25, :got:pos
    ldr	x25, [x25, #:got_lo12:pos]
    ldr	w24,	[x25]

    add	w26,	w24,	#4
    cmp	w26,	w22
    bge	detect_item_795

detect_item_702:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    lsl	w14,	w11,	#2
    add	x13,	x21,	x14
    ldr	w15,	[x13]

    cmp	w15,	#102
    bne	detect_item_796

detect_item_707:
    adrp	x18, :got:pos
    ldr	x18, [x18, #:got_lo12:pos]
    ldr	w17,	[x18]

    add	w19,	w17,	#1
    lsl	w22,	w19,	#2
    add	x20,	x21,	x22
    ldr	w23,	[x20]

    cmp	w23,	#97
    bne	detect_item_797

detect_item_713:
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    ldr	w25,	[x26]

    add	w27,	w25,	#2
    lsl	w0,	w27,	#2
    add	x28,	x21,	x0
    ldr	w1,	[x28]

    cmp	w1,	#108
    bne	detect_item_798

detect_item_719:
    adrp	x4, :got:pos
    ldr	x4, [x4, #:got_lo12:pos]
    ldr	w3,	[x4]

    add	w5,	w3,	#3
    lsl	w7,	w5,	#2
    add	x6,	x21,	x7
    ldr	w8,	[x6]

    cmp	w8,	#115
    bne	detect_item_799

detect_item_725:
    adrp	x11, :got:pos
    ldr	x11, [x11, #:got_lo12:pos]
    ldr	w10,	[x11]

    add	w12,	w10,	#4
    lsl	w14,	w12,	#2
    add	x0,	x21,	x14
    ldr	w2,	[x0]

    cmp	w2,	#101
    bne	detect_item_800

detect_item_731:
    adrp	x5, :got:pos
    adrp	x7, :got:pos
    movz	w0,	#1
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    ldr	x7, [x7, #:got_lo12:pos]
    add	w20,	w4,	#5
    str	w20,	[x7]

    b	detect_item_807

detect_item_800:
    movz	w0,	#0
    b	detect_item_807

detect_item_799:
    movz	w0,	#0
    b	detect_item_807

detect_item_798:
    movz	w0,	#0
    b	detect_item_807

detect_item_797:
    movz	w0,	#0
    b	detect_item_807

detect_item_796:
    movz	w0,	#0
    b	detect_item_807

detect_item_795:
    movz	w0,	#0
    b	detect_item_807

detect_item_734:
    cmp	w0,	#7
    bne	detect_item_801

detect_item_736:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    add	w13,	w11,	#3
    cmp	w13,	w22
    bge	detect_item_802

detect_item_740:
    adrp	x28, :got:pos
    ldr	x28, [x28, #:got_lo12:pos]
    ldr	w27,	[x28]

    lsl	w1,	w27,	#2
    add	x0,	x21,	x1
    ldr	w2,	[x0]

    cmp	w2,	#110
    bne	detect_item_803

detect_item_745:
    adrp	x5, :got:pos
    ldr	x5, [x5, #:got_lo12:pos]
    ldr	w4,	[x5]

    add	w6,	w4,	#1
    lsl	w8,	w6,	#2
    add	x7,	x21,	x8
    ldr	w9,	[x7]

    cmp	w9,	#117
    bne	detect_item_804

detect_item_751:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    add	w13,	w11,	#2
    lsl	w15,	w13,	#2
    add	x14,	x21,	x15
    ldr	w16,	[x14]

    cmp	w16,	#108
    bne	detect_item_805

detect_item_757:
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    ldr	w18,	[x19]

    add	w20,	w18,	#3
    lsl	w23,	w20,	#2
    add	x7,	x21,	x23
    ldr	w9,	[x7]

    cmp	w9,	#108
    bne	detect_item_806

detect_item_763:
    adrp	x12, :got:pos
    adrp	x14, :got:pos
    movz	w0,	#1
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w11,	[x12]

    ldr	x14, [x14, #:got_lo12:pos]
    add	w28,	w11,	#4
    str	w28,	[x14]

    b	detect_item_807

detect_item_806:
    movz	w0,	#0
    b	detect_item_807

detect_item_805:
    movz	w0,	#0
    b	detect_item_807

detect_item_804:
    movz	w0,	#0
    b	detect_item_807

detect_item_803:
    movz	w0,	#0
    b	detect_item_807

detect_item_802:
    movz	w0,	#0
    b	detect_item_807

detect_item_801:
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
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getch
    movz	w23,	#0
    mov	w22,	w0

main_2:
    cmp	w22,	#35
    beq	main_10

main_6:
    lsl	w26,	w23,	#2
    adrp	x19, :got:buffer
    add	w23,	w23,	#1
    ldr	x19, [x19, #:got_lo12:buffer]
    add	x28,	x19,	x26
    str	w22,	[x28]

    bl	getch
    mov	w22,	w0
    b	main_2

main_10:
    adrp	x28, :got:buffer
    ldr	x28, [x28, #:got_lo12:buffer]

main_12:
    adrp	x7, :got:pos
    ldr	x7, [x7, #:got_lo12:pos]
    ldr	w3,	[x7]

    cmp	w3,	w23
    bge	main_35

main_15:
    lsl	w10,	w3,	#2
    add	x9,	x28,	x10
    ldr	w11,	[x9]

    cmp	w11,	#32
    bne	main_21

main_19:
    add	w26,	w3,	#1
    adrp	x14, :got:pos
    ldr	x14, [x14, #:got_lo12:pos]
    str	w26,	[x14]

    b	main_12

main_21:
    cmp	w11,	#9
    bne	main_25

main_23:
    add	w1,	w3,	#1
    adrp	x17, :got:pos
    ldr	x17, [x17, #:got_lo12:pos]
    str	w1,	[x17]

    b	main_12

main_25:
    cmp	w11,	#10
    bne	main_29

main_27:
    add	w4,	w3,	#1
    adrp	x20, :got:pos
    ldr	x20, [x20, #:got_lo12:pos]
    str	w4,	[x20]

    b	main_12

main_29:
    cmp	w11,	#13
    bne	main_35

main_31:
    add	w7,	w3,	#1
    adrp	x24, :got:pos
    ldr	x24, [x24, #:got_lo12:pos]
    str	w7,	[x24]

    b	main_12

main_35:
    movz	w0,	#0
    mov	x1,	x28
    mov	w2,	w23
    bl	detect_item

main_37:
    adrp	x12, :got:pos
    ldr	x12, [x12, #:got_lo12:pos]
    ldr	w22,	[x12]

    cmp	w22,	w23
    bge	main_60

main_40:
    lsl	w15,	w22,	#2
    add	x14,	x28,	x15
    ldr	w16,	[x14]

    cmp	w16,	#32
    bne	main_46

main_44:
    add	w25,	w22,	#1
    adrp	x19, :got:pos
    ldr	x19, [x19, #:got_lo12:pos]
    str	w25,	[x19]

    b	main_37

main_46:
    cmp	w16,	#9
    bne	main_50

main_48:
    add	w1,	w22,	#1
    adrp	x22, :got:pos
    ldr	x22, [x22, #:got_lo12:pos]
    str	w1,	[x22]

    b	main_37

main_50:
    cmp	w16,	#10
    bne	main_54

main_52:
    add	w4,	w22,	#1
    adrp	x26, :got:pos
    ldr	x26, [x26, #:got_lo12:pos]
    str	w4,	[x26]

    b	main_37

main_54:
    cmp	w16,	#13
    bne	main_60

main_56:
    add	w8,	w22,	#1
    adrp	x2, :got:pos
    ldr	x2, [x2, #:got_lo12:pos]
    str	w8,	[x2]

    b	main_37

main_60:
    cmp	w0,	#0
    beq	main_63

main_62:
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    b	main_64

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

main_64:
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


