.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global SHIFT_TABLE
.align	2
SHIFT_TABLE:
    .word	1
    .word	2
    .word	4
    .word	8
    .word	16
    .word	32
    .word	64
    .word	128
    .word	256
    .word	512
    .word	1024
    .word	2048
    .word	4096
    .word	8192
    .word	16384
    .word	32768


.text

.globl long_func
long_func:
long_func_0:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w0,	#1
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w12,	#1
    movz	w21,	#1
    adrp	x6, :got:SHIFT_TABLE
    adrp	x0, :got:SHIFT_TABLE
    ldr	x0, [x0, #:got_lo12:SHIFT_TABLE]
    add	x28,	x0,	#4
    ldr	w26,	[x28]

    movz	w28,	#2
    ldr	x6, [x6, #:got_lo12:SHIFT_TABLE]
    add	x5,	x6,	#60
    ldr	w23,	[x5]


long_func_6:
    movz	w13,	#0
    movz	w1,	#0
    mov	w25,	w21
    movz	w17,	#1

long_func_11:
    asr	w4,	w25,	#31
    lsr	w5,	w4,	#31
    add	w6,	w25,	w5
    asr	w20,	w6,	#1
    lsl	w22,	w20,	#1
    sub	w9,	w25,	w22
    cmp	w9,	#0
    beq	long_func_27

long_func_18:
    asr	w7,	w17,	#31
    lsr	w8,	w7,	#31
    add	w9,	w17,	w8
    asr	w24,	w9,	#1
    lsl	w27,	w24,	#1
    sub	w11,	w17,	w27
    cmp	w11,	#0
    beq	long_func_27

long_func_21:
    lsl	w2,	w1,	#2
    adrp	x18, :got:SHIFT_TABLE
    ldr	x18, [x18, #:got_lo12:SHIFT_TABLE]
    add	x15,	x18,	x2
    ldr	w19,	[x15]

    add	w13,	w19,	w13

long_func_27:
    asr	w10,	w25,	#31
    asr	w15,	w17,	#31
    add	w1,	w1,	#1
    lsr	w11,	w10,	#31
    lsr	w16,	w15,	#31
    add	w7,	w25,	w11
    add	w10,	w17,	w16
    asr	w25,	w7,	#1
    asr	w17,	w10,	#1
    cmp	w1,	#16
    blt	long_func_11

long_func_33:
    cmp	w13,	#0
    beq	long_func_272

long_func_35:
    cmp	w28,	#0
    bne	long_func_37

long_func_276:
    movz	w0,	#0
    b	long_func_273

long_func_37:
    mov	w13,	w28
    movz	w0,	#0

long_func_39:
    movz	w16,	#0
    movz	w20,	#0
    mov	w11,	w13
    movz	w19,	#1

long_func_44:
    asr	w18,	w11,	#31
    lsr	w22,	w18,	#31
    add	w24,	w11,	w22
    asr	w27,	w24,	#1
    lsl	w1,	w27,	#1
    sub	w15,	w11,	w1
    cmp	w15,	#0
    beq	long_func_60

long_func_51:
    asr	w25,	w19,	#31
    lsr	w27,	w25,	#31
    add	w1,	w19,	w27
    asr	w2,	w1,	#1
    lsl	w3,	w2,	#1
    sub	w18,	w19,	w3
    cmp	w18,	#0
    beq	long_func_60

long_func_54:
    lsl	w7,	w20,	#2
    adrp	x27, :got:SHIFT_TABLE
    ldr	x27, [x27, #:got_lo12:SHIFT_TABLE]
    add	x24,	x27,	x7
    ldr	w1,	[x24]

    add	w16,	w1,	w16

long_func_60:
    asr	w2,	w11,	#31
    asr	w5,	w19,	#31
    add	w20,	w20,	#1
    lsr	w3,	w2,	#31
    lsr	w6,	w5,	#31
    add	w4,	w11,	w3
    add	w7,	w19,	w6
    asr	w11,	w4,	#1
    asr	w19,	w7,	#1
    cmp	w20,	#16
    blt	long_func_44

long_func_66:
    cmp	w16,	#0
    beq	long_func_161

long_func_68:
    cmp	w12,	#0
    beq	long_func_161

long_func_72:
    mov	w11,	w12

long_func_74:
    movz	w14,	#0
    movz	w1,	#0
    mov	w17,	w0
    mov	w19,	w11

long_func_78:
    asr	w7,	w17,	#31
    lsr	w8,	w7,	#31
    add	w9,	w17,	w8
    asr	w8,	w9,	#1
    lsl	w9,	w8,	#1
    sub	w27,	w17,	w9
    cmp	w27,	#0
    beq	long_func_95

long_func_85:
    asr	w10,	w19,	#31
    lsr	w15,	w10,	#31
    add	w16,	w19,	w15
    asr	w10,	w16,	#1
    lsl	w15,	w10,	#1
    sub	w3,	w19,	w15
    cmp	w3,	#0
    bne	long_func_105

long_func_88:
    lsl	w27,	w1,	#2
    adrp	x7, :got:SHIFT_TABLE
    ldr	x7, [x7, #:got_lo12:SHIFT_TABLE]
    add	x5,	x7,	x27
    ldr	w8,	[x5]

    add	w14,	w8,	w14
    b	long_func_105

long_func_95:
    asr	w18,	w19,	#31
    lsr	w20,	w18,	#31
    add	w22,	w19,	w20
    asr	w18,	w22,	#1
    lsl	w20,	w18,	#1
    sub	w10,	w19,	w20
    cmp	w10,	#0
    beq	long_func_105

long_func_98:
    lsl	w8,	w1,	#2
    adrp	x20, :got:SHIFT_TABLE
    ldr	x20, [x20, #:got_lo12:SHIFT_TABLE]
    add	x16,	x20,	x8
    ldr	w22,	[x16]

    add	w14,	w22,	w14

long_func_105:
    asr	w24,	w17,	#31
    add	w1,	w1,	#1
    lsr	w25,	w24,	#31
    add	w2,	w17,	w25
    asr	w17,	w2,	#1
    asr	w2,	w19,	#31
    lsr	w3,	w2,	#31
    add	w5,	w19,	w3
    asr	w19,	w5,	#1
    cmp	w1,	#16
    blt	long_func_78

long_func_111:
    movz	w15,	#0
    movz	w3,	#0

long_func_113:
    asr	w6,	w0,	#31
    lsr	w7,	w6,	#31
    add	w8,	w0,	w7
    asr	w25,	w8,	#1
    lsl	w27,	w25,	#1
    sub	w17,	w0,	w27
    cmp	w17,	#0
    beq	long_func_129

long_func_120:
    asr	w9,	w11,	#31
    lsr	w10,	w9,	#31
    add	w16,	w11,	w10
    asr	w1,	w16,	#1
    lsl	w2,	w1,	#1
    sub	w19,	w11,	w2
    cmp	w19,	#0
    beq	long_func_129

long_func_123:
    lsl	w9,	w3,	#2
    adrp	x25, :got:SHIFT_TABLE
    ldr	x25, [x25, #:got_lo12:SHIFT_TABLE]
    add	x22,	x25,	x9
    ldr	w27,	[x22]

    add	w15,	w27,	w15

long_func_129:
    asr	w17,	w0,	#31
    asr	w20,	w11,	#31
    add	w3,	w3,	#1
    lsr	w18,	w17,	#31
    lsr	w22,	w20,	#31
    add	w17,	w0,	w18
    add	w20,	w11,	w22
    asr	w0,	w17,	#1
    asr	w11,	w20,	#1
    cmp	w3,	#16
    blt	long_func_113

long_func_135:
    mul	w8,	w26,	w15
    movz	w11,	#0
    movz	w17,	#0
    movz	w19,	#65535

long_func_138:
    asr	w25,	w8,	#31
    lsr	w27,	w25,	#31
    add	w0,	w8,	w27
    asr	w5,	w0,	#1
    lsl	w6,	w5,	#1
    sub	w6,	w8,	w6
    cmp	w6,	#0
    beq	long_func_154

long_func_145:
    asr	w1,	w19,	#31
    lsr	w2,	w1,	#31
    add	w3,	w19,	w2
    asr	w7,	w3,	#1
    lsl	w9,	w7,	#1
    sub	w9,	w19,	w9
    cmp	w9,	#0
    beq	long_func_154

long_func_148:
    lsl	w4,	w17,	#2
    adrp	x18, :got:SHIFT_TABLE
    ldr	x18, [x18, #:got_lo12:SHIFT_TABLE]
    add	x15,	x18,	x4
    ldr	w20,	[x15]

    add	w11,	w20,	w11

long_func_154:
    asr	w4,	w8,	#31
    asr	w7,	w19,	#31
    add	w17,	w17,	#1
    lsr	w5,	w4,	#31
    lsr	w9,	w7,	#31
    add	w4,	w8,	w5
    add	w7,	w19,	w9
    asr	w8,	w4,	#1
    asr	w19,	w7,	#1
    cmp	w17,	#16
    blt	long_func_138

long_func_70:
    cmp	w11,	#0
    beq	long_func_165

long_func_73:
    mov	w0,	w14
    b	long_func_74

long_func_165:
    mov	w0,	w14

long_func_161:
    cmp	w12,	#0
    beq	long_func_260

long_func_170:
    mov	w5,	w12

long_func_172:
    movz	w24,	#0
    movz	w2,	#0
    mov	w18,	w5
    mov	w22,	w12

long_func_176:
    asr	w15,	w18,	#31
    lsr	w16,	w15,	#31
    add	w17,	w18,	w16
    asr	w19,	w17,	#1
    lsl	w20,	w19,	#1
    sub	w20,	w18,	w20
    cmp	w20,	#0
    beq	long_func_193

long_func_183:
    asr	w19,	w22,	#31
    lsr	w20,	w19,	#31
    add	w25,	w22,	w20
    asr	w25,	w25,	#1
    lsl	w27,	w25,	#1
    sub	w27,	w22,	w27
    cmp	w27,	#0
    bne	long_func_203

long_func_186:
    lsl	w1,	w2,	#2
    adrp	x6, :got:SHIFT_TABLE
    ldr	x6, [x6, #:got_lo12:SHIFT_TABLE]
    add	x3,	x6,	x1
    ldr	w7,	[x3]

    add	w24,	w7,	w24
    b	long_func_203

long_func_193:
    asr	w27,	w22,	#31
    lsr	w1,	w27,	#31
    add	w3,	w22,	w1
    asr	w3,	w3,	#1
    lsl	w4,	w3,	#1
    sub	w9,	w22,	w4
    cmp	w9,	#0
    beq	long_func_203

long_func_196:
    lsl	w10,	w2,	#2
    adrp	x15, :got:SHIFT_TABLE
    ldr	x15, [x15, #:got_lo12:SHIFT_TABLE]
    add	x11,	x15,	x10
    ldr	w16,	[x11]

    add	w24,	w16,	w24

long_func_203:
    asr	w4,	w18,	#31
    asr	w8,	w22,	#31
    add	w2,	w2,	#1
    lsr	w6,	w4,	#31
    lsr	w9,	w8,	#31
    add	w6,	w18,	w6
    add	w9,	w22,	w9
    asr	w18,	w6,	#1
    asr	w22,	w9,	#1
    cmp	w2,	#16
    blt	long_func_176

long_func_209:
    movz	w4,	#0
    movz	w10,	#0

long_func_211:
    asr	w11,	w5,	#31
    lsr	w14,	w11,	#31
    add	w15,	w5,	w14
    asr	w7,	w15,	#1
    lsl	w8,	w7,	#1
    sub	w8,	w5,	w8
    cmp	w8,	#0
    beq	long_func_227

long_func_218:
    asr	w16,	w12,	#31
    lsr	w17,	w16,	#31
    add	w18,	w12,	w17
    asr	w9,	w18,	#1
    lsl	w11,	w9,	#1
    sub	w11,	w12,	w11
    cmp	w11,	#0
    beq	long_func_227

long_func_221:
    lsl	w8,	w10,	#2
    adrp	x17, :got:SHIFT_TABLE
    ldr	x17, [x17, #:got_lo12:SHIFT_TABLE]
    add	x15,	x17,	x8
    ldr	w18,	[x15]

    add	w4,	w18,	w4

long_func_227:
    asr	w19,	w5,	#31
    asr	w25,	w12,	#31
    add	w10,	w10,	#1
    lsr	w20,	w19,	#31
    lsr	w27,	w25,	#31
    add	w17,	w5,	w20
    add	w20,	w12,	w27
    asr	w5,	w17,	#1
    asr	w12,	w20,	#1
    cmp	w10,	#16
    blt	long_func_211

long_func_233:
    mul	w17,	w26,	w4
    movz	w12,	#0
    movz	w6,	#0
    movz	w11,	#65535

long_func_236:
    asr	w2,	w17,	#31
    lsr	w3,	w2,	#31
    add	w4,	w17,	w3
    asr	w16,	w4,	#1
    lsl	w18,	w16,	#1
    sub	w2,	w17,	w18
    cmp	w2,	#0
    beq	long_func_252

long_func_243:
    asr	w5,	w11,	#31
    lsr	w7,	w5,	#31
    add	w8,	w11,	w7
    asr	w19,	w8,	#1
    lsl	w20,	w19,	#1
    sub	w4,	w11,	w20
    cmp	w4,	#0
    beq	long_func_252

long_func_246:
    lsl	w3,	w6,	#2
    adrp	x9, :got:SHIFT_TABLE
    ldr	x9, [x9, #:got_lo12:SHIFT_TABLE]
    add	x7,	x9,	x3
    ldr	w10,	[x7]

    add	w12,	w10,	w12

long_func_252:
    asr	w9,	w17,	#31
    asr	w15,	w11,	#31
    add	w6,	w6,	#1
    lsr	w10,	w9,	#31
    lsr	w16,	w15,	#31
    add	w7,	w17,	w10
    add	w10,	w11,	w16
    asr	w17,	w7,	#1
    asr	w11,	w10,	#1
    cmp	w6,	#16
    blt	long_func_236

long_func_168:
    cmp	w12,	#0
    beq	long_func_259

long_func_171:
    mov	w5,	w24
    b	long_func_172

long_func_259:
    mov	w12,	w24

long_func_260:
    movz	w17,	#32767
    cmp	w13,	w17
    ble	long_func_267

long_func_263:
    sdiv	w16,	w13,	w26
    add	w17,	w16,	#65536
    sub	w13,	w17,	w23
    b	long_func_269

long_func_267:
    sdiv	w13,	w13,	w26

long_func_269:
    cmp	w13,	#0
    bne	long_func_39
    b	long_func_273

long_func_272:
    mov	w0,	w12

long_func_273:
    cmp	w28,	#0
    bne	long_func_280

long_func_515:
    movz	w14,	#0
    b	long_func_517

long_func_280:
    mov	w25,	w28
    movz	w14,	#0

long_func_282:
    movz	w19,	#0
    movz	w22,	#0
    mov	w3,	w28
    movz	w24,	#1

long_func_287:
    asr	w16,	w3,	#31
    lsr	w17,	w16,	#31
    add	w18,	w3,	w17
    asr	w2,	w18,	#1
    lsl	w4,	w2,	#1
    sub	w6,	w3,	w4
    cmp	w6,	#0
    beq	long_func_303

long_func_294:
    asr	w20,	w24,	#31
    lsr	w27,	w20,	#31
    add	w1,	w24,	w27
    asr	w5,	w1,	#1
    lsl	w6,	w5,	#1
    sub	w8,	w24,	w6
    cmp	w8,	#0
    beq	long_func_303

long_func_297:
    lsl	w8,	w22,	#2
    adrp	x12, :got:SHIFT_TABLE
    ldr	x12, [x12, #:got_lo12:SHIFT_TABLE]
    add	x10,	x12,	x8
    ldr	w13,	[x10]

    add	w19,	w13,	w19

long_func_303:
    asr	w2,	w3,	#31
    asr	w6,	w24,	#31
    add	w22,	w22,	#1
    lsr	w4,	w2,	#31
    lsr	w7,	w6,	#31
    add	w20,	w3,	w4
    add	w2,	w24,	w7
    asr	w3,	w20,	#1
    asr	w24,	w2,	#1
    cmp	w22,	#16
    blt	long_func_287

long_func_309:
    cmp	w19,	#0
    beq	long_func_404

long_func_311:
    cmp	w25,	#0
    beq	long_func_404

long_func_315:
    mov	w2,	w25

long_func_317:
    movz	w18,	#0
    movz	w15,	#0
    mov	w8,	w14
    mov	w13,	w2

long_func_321:
    asr	w16,	w8,	#31
    lsr	w17,	w16,	#31
    add	w19,	w8,	w17
    asr	w17,	w19,	#1
    lsl	w19,	w17,	#1
    sub	w27,	w8,	w19
    cmp	w27,	#0
    beq	long_func_338

long_func_328:
    asr	w20,	w13,	#31
    lsr	w22,	w20,	#31
    add	w24,	w13,	w22
    asr	w20,	w24,	#1
    lsl	w22,	w20,	#1
    sub	w3,	w13,	w22
    cmp	w3,	#0
    bne	long_func_348

long_func_331:
    lsl	w10,	w15,	#2
    adrp	x7, :got:SHIFT_TABLE
    ldr	x7, [x7, #:got_lo12:SHIFT_TABLE]
    add	x5,	x7,	x10
    ldr	w9,	[x5]

    add	w18,	w9,	w18
    b	long_func_348

long_func_338:
    asr	w27,	w13,	#31
    lsr	w1,	w27,	#31
    add	w3,	w13,	w1
    asr	w27,	w3,	#1
    lsl	w1,	w27,	#1
    sub	w11,	w13,	w1
    cmp	w11,	#0
    beq	long_func_348

long_func_341:
    lsl	w22,	w15,	#2
    adrp	x19, :got:SHIFT_TABLE
    ldr	x19, [x19, #:got_lo12:SHIFT_TABLE]
    add	x16,	x19,	x22
    ldr	w20,	[x16]

    add	w18,	w20,	w18

long_func_348:
    asr	w4,	w8,	#31
    asr	w7,	w13,	#31
    add	w15,	w15,	#1
    lsr	w5,	w4,	#31
    lsr	w9,	w7,	#31
    add	w1,	w8,	w5
    add	w5,	w13,	w9
    asr	w8,	w1,	#1
    asr	w13,	w5,	#1
    cmp	w15,	#16
    blt	long_func_321

long_func_354:
    movz	w24,	#0
    movz	w13,	#0

long_func_356:
    asr	w6,	w14,	#31
    lsr	w7,	w6,	#31
    add	w8,	w14,	w7
    asr	w1,	w8,	#1
    lsl	w3,	w1,	#1
    sub	w5,	w14,	w3
    cmp	w5,	#0
    beq	long_func_372

long_func_363:
    asr	w9,	w2,	#31
    lsr	w10,	w9,	#31
    add	w11,	w2,	w10
    asr	w4,	w11,	#1
    lsl	w5,	w4,	#1
    sub	w7,	w2,	w5
    cmp	w7,	#0
    beq	long_func_372

long_func_366:
    lsl	w9,	w13,	#2
    adrp	x11, :got:SHIFT_TABLE
    ldr	x11, [x11, #:got_lo12:SHIFT_TABLE]
    add	x9,	x11,	x9
    ldr	w12,	[x9]

    add	w24,	w12,	w24

long_func_372:
    asr	w12,	w14,	#31
    asr	w17,	w2,	#31
    add	w13,	w13,	#1
    lsr	w15,	w12,	#31
    lsr	w19,	w17,	#31
    add	w8,	w14,	w15
    add	w10,	w2,	w19
    asr	w14,	w8,	#1
    asr	w2,	w10,	#1
    cmp	w13,	#16
    blt	long_func_356

long_func_378:
    mul	w22,	w26,	w24
    movz	w2,	#0
    movz	w1,	#0
    movz	w9,	#65535

long_func_381:
    asr	w24,	w22,	#31
    lsr	w27,	w24,	#31
    add	w3,	w22,	w27
    asr	w11,	w3,	#1
    lsl	w12,	w11,	#1
    sub	w27,	w22,	w12
    cmp	w27,	#0
    beq	long_func_397

long_func_388:
    asr	w4,	w9,	#31
    lsr	w5,	w4,	#31
    add	w6,	w9,	w5
    asr	w13,	w6,	#1
    lsl	w14,	w13,	#1
    sub	w4,	w9,	w14
    cmp	w4,	#0
    beq	long_func_397

long_func_391:
    lsl	w7,	w1,	#2
    adrp	x8, :got:SHIFT_TABLE
    ldr	x8, [x8, #:got_lo12:SHIFT_TABLE]
    add	x6,	x8,	x7
    ldr	w10,	[x6]

    add	w2,	w10,	w2

long_func_397:
    asr	w7,	w22,	#31
    asr	w11,	w9,	#31
    add	w1,	w1,	#1
    lsr	w8,	w7,	#31
    lsr	w12,	w11,	#31
    add	w27,	w22,	w8
    add	w5,	w9,	w12
    asr	w22,	w27,	#1
    asr	w9,	w5,	#1
    cmp	w1,	#16
    blt	long_func_381

long_func_313:
    cmp	w2,	#0
    beq	long_func_408

long_func_316:
    mov	w14,	w18
    b	long_func_317

long_func_408:
    mov	w14,	w18

long_func_404:
    cmp	w25,	#0
    beq	long_func_503

long_func_413:
    mov	w16,	w25

long_func_415:
    movz	w3,	#0
    movz	w17,	#0
    mov	w10,	w16
    mov	w19,	w25

long_func_419:
    asr	w24,	w10,	#31
    lsr	w27,	w24,	#31
    add	w1,	w10,	w27
    asr	w2,	w1,	#1
    lsl	w4,	w2,	#1
    sub	w22,	w10,	w4
    cmp	w22,	#0
    beq	long_func_436

long_func_426:
    asr	w2,	w19,	#31
    lsr	w4,	w2,	#31
    add	w5,	w19,	w4
    asr	w5,	w5,	#1
    lsl	w6,	w5,	#1
    sub	w27,	w19,	w6
    cmp	w27,	#0
    bne	long_func_446

long_func_429:
    lsl	w11,	w17,	#2
    adrp	x5, :got:SHIFT_TABLE
    ldr	x5, [x5, #:got_lo12:SHIFT_TABLE]
    add	x2,	x5,	x11
    ldr	w6,	[x2]

    add	w3,	w6,	w3
    b	long_func_446

long_func_436:
    asr	w6,	w19,	#31
    lsr	w7,	w6,	#31
    add	w8,	w19,	w7
    asr	w8,	w8,	#1
    lsl	w9,	w8,	#1
    sub	w8,	w19,	w9
    cmp	w8,	#0
    beq	long_func_446

long_func_439:
    lsl	w24,	w17,	#2
    adrp	x13, :got:SHIFT_TABLE
    ldr	x13, [x13, #:got_lo12:SHIFT_TABLE]
    add	x11,	x13,	x24
    ldr	w15,	[x11]

    add	w3,	w15,	w3

long_func_446:
    asr	w9,	w10,	#31
    asr	w13,	w19,	#31
    add	w17,	w17,	#1
    lsr	w11,	w9,	#31
    lsr	w15,	w13,	#31
    add	w5,	w10,	w11
    add	w8,	w19,	w15
    asr	w10,	w5,	#1
    asr	w19,	w8,	#1
    cmp	w17,	#16
    blt	long_func_419

long_func_452:
    movz	w2,	#0
    movz	w7,	#0

long_func_454:
    asr	w11,	w16,	#31
    lsr	w12,	w11,	#31
    add	w13,	w16,	w12
    asr	w10,	w13,	#1
    lsl	w11,	w10,	#1
    sub	w24,	w16,	w11
    cmp	w24,	#0
    beq	long_func_470

long_func_461:
    asr	w15,	w25,	#31
    lsr	w17,	w15,	#31
    add	w18,	w25,	w17
    asr	w12,	w18,	#1
    lsl	w13,	w12,	#1
    sub	w1,	w25,	w13
    cmp	w1,	#0
    beq	long_func_470

long_func_464:
    lsl	w10,	w7,	#2
    adrp	x8, :got:SHIFT_TABLE
    ldr	x8, [x8, #:got_lo12:SHIFT_TABLE]
    add	x5,	x8,	x10
    ldr	w9,	[x5]

    add	w2,	w9,	w2

long_func_470:
    asr	w19,	w16,	#31
    asr	w24,	w25,	#31
    add	w7,	w7,	#1
    lsr	w20,	w19,	#31
    lsr	w27,	w24,	#31
    add	w11,	w16,	w20
    add	w15,	w25,	w27
    asr	w16,	w11,	#1
    asr	w25,	w15,	#1
    cmp	w7,	#16
    blt	long_func_454

long_func_476:
    mul	w20,	w26,	w2
    movz	w25,	#0
    movz	w11,	#0
    movz	w24,	#65535

long_func_479:
    asr	w2,	w20,	#31
    lsr	w4,	w2,	#31
    add	w5,	w20,	w4
    asr	w17,	w5,	#1
    lsl	w18,	w17,	#1
    sub	w16,	w20,	w18
    cmp	w16,	#0
    beq	long_func_495

long_func_486:
    asr	w6,	w24,	#31
    lsr	w7,	w6,	#31
    add	w8,	w24,	w7
    asr	w19,	w8,	#1
    lsl	w22,	w19,	#1
    sub	w18,	w24,	w22
    cmp	w18,	#0
    beq	long_func_495

long_func_489:
    lsl	w5,	w11,	#2
    adrp	x1, :got:SHIFT_TABLE
    ldr	x1, [x1, #:got_lo12:SHIFT_TABLE]
    add	x22,	x1,	x5
    ldr	w2,	[x22]

    add	w25,	w2,	w25

long_func_495:
    asr	w9,	w20,	#31
    asr	w13,	w24,	#31
    add	w11,	w11,	#1
    lsr	w10,	w9,	#31
    lsr	w15,	w13,	#31
    add	w1,	w20,	w10
    add	w5,	w24,	w15
    asr	w20,	w1,	#1
    asr	w24,	w5,	#1
    cmp	w11,	#16
    blt	long_func_479

long_func_411:
    cmp	w25,	#0
    beq	long_func_502

long_func_414:
    mov	w16,	w3
    b	long_func_415

long_func_502:
    mov	w25,	w3

long_func_503:
    movz	w5,	#32767
    cmp	w28,	w5
    ble	long_func_510

long_func_506:
    sdiv	w20,	w28,	w26
    add	w22,	w20,	#65536
    sub	w28,	w22,	w23
    b	long_func_512

long_func_510:
    sdiv	w28,	w28,	w26

long_func_512:
    cmp	w28,	#0
    bne	long_func_282

long_func_517:
    movz	w17,	#32767
    cmp	w21,	w17
    ble	long_func_524

long_func_520:
    sdiv	w7,	w21,	w26
    add	w8,	w7,	#65536
    sub	w21,	w8,	w23
    b	long_func_526

long_func_524:
    sdiv	w21,	w21,	w26

long_func_526:
    cmp	w21,	#0
    bgt	long_func_5

long_func_529:
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w22,	#2

long_func_531:
    cmp	w22,	#0
    bgt	long_func_534

long_func_1059:
    movz	w0,	#1
    b	long_func_1061

long_func_534:
    movz	w8,	#2
    mov	w1,	w22
    movz	w4,	#1

long_func_536:
    movz	w19,	#0
    movz	w27,	#0
    mov	w7,	w1
    movz	w3,	#1

long_func_541:
    asr	w9,	w7,	#31
    lsr	w10,	w9,	#31
    add	w11,	w7,	w10
    asr	w17,	w11,	#1
    lsl	w18,	w17,	#1
    sub	w13,	w7,	w18
    cmp	w13,	#0
    beq	long_func_557

long_func_548:
    asr	w12,	w3,	#31
    lsr	w13,	w12,	#31
    add	w14,	w3,	w13
    asr	w20,	w14,	#1
    lsl	w21,	w20,	#1
    sub	w15,	w3,	w21
    cmp	w15,	#0
    beq	long_func_557

long_func_551:
    lsl	w13,	w27,	#2
    adrp	x20, :got:SHIFT_TABLE
    ldr	x20, [x20, #:got_lo12:SHIFT_TABLE]
    add	x17,	x20,	x13
    ldr	w21,	[x17]

    add	w19,	w21,	w19

long_func_557:
    asr	w15,	w7,	#31
    asr	w18,	w3,	#31
    add	w27,	w27,	#1
    lsr	w16,	w15,	#31
    lsr	w20,	w18,	#31
    add	w6,	w7,	w16
    add	w10,	w3,	w20
    asr	w7,	w6,	#1
    asr	w3,	w10,	#1
    cmp	w27,	#16
    blt	long_func_541

long_func_563:
    cmp	w19,	#0
    beq	long_func_802

long_func_565:
    cmp	w8,	#0
    bne	long_func_567

long_func_806:
    movz	w0,	#0
    b	long_func_803

long_func_567:
    mov	w17,	w8
    movz	w0,	#0

long_func_569:
    movz	w3,	#0
    movz	w24,	#0
    mov	w12,	w17
    movz	w9,	#1

long_func_574:
    asr	w27,	w12,	#31
    lsr	w28,	w27,	#31
    add	w2,	w12,	w28
    asr	w5,	w2,	#1
    lsl	w6,	w5,	#1
    sub	w11,	w12,	w6
    cmp	w11,	#0
    beq	long_func_590

long_func_581:
    asr	w5,	w9,	#31
    lsr	w6,	w5,	#31
    add	w7,	w9,	w6
    asr	w7,	w7,	#1
    lsl	w10,	w7,	#1
    sub	w14,	w9,	w10
    cmp	w14,	#0
    beq	long_func_590

long_func_584:
    lsl	w7,	w24,	#2
    adrp	x19, :got:SHIFT_TABLE
    ldr	x19, [x19, #:got_lo12:SHIFT_TABLE]
    add	x16,	x19,	x7
    ldr	w20,	[x16]

    add	w3,	w20,	w3

long_func_590:
    asr	w10,	w12,	#31
    asr	w14,	w9,	#31
    add	w24,	w24,	#1
    lsr	w11,	w10,	#31
    lsr	w15,	w14,	#31
    add	w25,	w12,	w11
    add	w2,	w9,	w15
    asr	w12,	w25,	#1
    asr	w9,	w2,	#1
    cmp	w24,	#16
    blt	long_func_574

long_func_596:
    cmp	w3,	#0
    beq	long_func_691

long_func_598:
    cmp	w4,	#0
    beq	long_func_691

long_func_602:
    mov	w28,	w4

long_func_604:
    movz	w14,	#0
    movz	w13,	#0
    mov	w25,	w0
    mov	w18,	w28

long_func_608:
    asr	w27,	w25,	#31
    lsr	w2,	w27,	#31
    add	w3,	w25,	w2
    asr	w11,	w3,	#1
    lsl	w12,	w11,	#1
    sub	w21,	w25,	w12
    cmp	w21,	#0
    beq	long_func_625

long_func_615:
    asr	w5,	w18,	#31
    lsr	w6,	w5,	#31
    add	w7,	w18,	w6
    asr	w15,	w7,	#1
    lsl	w16,	w15,	#1
    sub	w27,	w18,	w16
    cmp	w27,	#0
    bne	long_func_635

long_func_618:
    lsl	w5,	w13,	#2
    adrp	x6, :got:SHIFT_TABLE
    ldr	x6, [x6, #:got_lo12:SHIFT_TABLE]
    add	x3,	x6,	x5
    ldr	w7,	[x3]

    add	w14,	w7,	w14
    b	long_func_635

long_func_625:
    asr	w9,	w18,	#31
    lsr	w10,	w9,	#31
    add	w11,	w18,	w10
    asr	w20,	w11,	#1
    lsl	w21,	w20,	#1
    sub	w10,	w18,	w21
    cmp	w10,	#0
    beq	long_func_635

long_func_628:
    lsl	w15,	w13,	#2
    adrp	x16, :got:SHIFT_TABLE
    ldr	x16, [x16, #:got_lo12:SHIFT_TABLE]
    add	x12,	x16,	x15
    ldr	w19,	[x12]

    add	w14,	w19,	w14

long_func_635:
    asr	w12,	w25,	#31
    asr	w19,	w18,	#31
    add	w13,	w13,	#1
    lsr	w15,	w12,	#31
    lsr	w20,	w19,	#31
    add	w7,	w25,	w15
    add	w11,	w18,	w20
    asr	w25,	w7,	#1
    asr	w18,	w11,	#1
    cmp	w13,	#16
    blt	long_func_608

long_func_641:
    movz	w18,	#0
    movz	w2,	#0

long_func_643:
    asr	w13,	w0,	#31
    lsr	w15,	w13,	#31
    add	w16,	w0,	w15
    asr	w5,	w16,	#1
    lsl	w6,	w5,	#1
    sub	w11,	w0,	w6
    cmp	w11,	#0
    beq	long_func_659

long_func_650:
    asr	w19,	w28,	#31
    lsr	w20,	w19,	#31
    add	w21,	w28,	w20
    asr	w7,	w21,	#1
    lsl	w9,	w7,	#1
    sub	w13,	w28,	w9
    cmp	w13,	#0
    beq	long_func_659

long_func_653:
    lsl	w11,	w2,	#2
    adrp	x20, :got:SHIFT_TABLE
    ldr	x20, [x20, #:got_lo12:SHIFT_TABLE]
    add	x16,	x20,	x11
    ldr	w21,	[x16]

    add	w18,	w21,	w18

long_func_659:
    asr	w24,	w0,	#31
    asr	w3,	w28,	#31
    add	w2,	w2,	#1
    lsr	w25,	w24,	#31
    lsr	w5,	w3,	#31
    add	w10,	w0,	w25
    add	w15,	w28,	w5
    asr	w0,	w10,	#1
    asr	w28,	w15,	#1
    cmp	w2,	#16
    blt	long_func_643

long_func_665:
    mul	w9,	w26,	w18
    movz	w28,	#0
    movz	w19,	#0
    movz	w6,	#65535

long_func_668:
    asr	w5,	w9,	#31
    lsr	w7,	w5,	#31
    add	w10,	w9,	w7
    asr	w13,	w10,	#1
    lsl	w15,	w13,	#1
    sub	w5,	w9,	w15
    cmp	w5,	#0
    beq	long_func_684

long_func_675:
    asr	w11,	w6,	#31
    lsr	w12,	w11,	#31
    add	w13,	w6,	w12
    asr	w16,	w13,	#1
    lsl	w18,	w16,	#1
    sub	w10,	w6,	w18
    cmp	w10,	#0
    beq	long_func_684

long_func_678:
    lsl	w7,	w19,	#2
    adrp	x15, :got:SHIFT_TABLE
    ldr	x15, [x15, #:got_lo12:SHIFT_TABLE]
    add	x12,	x15,	x7
    ldr	w16,	[x12]

    add	w28,	w16,	w28

long_func_684:
    asr	w15,	w9,	#31
    asr	w20,	w6,	#31
    add	w19,	w19,	#1
    lsr	w16,	w15,	#31
    lsr	w21,	w20,	#31
    add	w0,	w9,	w16
    add	w5,	w6,	w21
    asr	w9,	w0,	#1
    asr	w6,	w5,	#1
    cmp	w19,	#16
    blt	long_func_668

long_func_600:
    cmp	w28,	#0
    beq	long_func_695

long_func_603:
    mov	w0,	w14
    b	long_func_604

long_func_695:
    mov	w0,	w14

long_func_691:
    cmp	w4,	#0
    beq	long_func_790

long_func_700:
    mov	w5,	w4

long_func_702:
    movz	w27,	#0
    movz	w16,	#0
    mov	w3,	w5
    mov	w25,	w4

long_func_706:
    asr	w12,	w3,	#31
    lsr	w13,	w12,	#31
    add	w14,	w3,	w13
    asr	w28,	w14,	#1
    lsl	w2,	w28,	#1
    sub	w24,	w3,	w2
    cmp	w24,	#0
    beq	long_func_723

long_func_713:
    asr	w15,	w25,	#31
    lsr	w18,	w15,	#31
    add	w19,	w25,	w18
    asr	w6,	w19,	#1
    lsl	w7,	w6,	#1
    sub	w2,	w25,	w7
    cmp	w2,	#0
    bne	long_func_733

long_func_716:
    lsl	w13,	w16,	#2
    adrp	x10, :got:SHIFT_TABLE
    ldr	x10, [x10, #:got_lo12:SHIFT_TABLE]
    add	x7,	x10,	x13
    ldr	w11,	[x7]

    add	w27,	w11,	w27
    b	long_func_733

long_func_723:
    asr	w20,	w25,	#31
    lsr	w21,	w20,	#31
    add	w24,	w25,	w21
    asr	w10,	w24,	#1
    lsl	w11,	w10,	#1
    sub	w13,	w25,	w11
    cmp	w13,	#0
    beq	long_func_733

long_func_726:
    lsl	w24,	w16,	#2
    adrp	x19, :got:SHIFT_TABLE
    ldr	x19, [x19, #:got_lo12:SHIFT_TABLE]
    add	x15,	x19,	x24
    ldr	w20,	[x15]

    add	w27,	w20,	w27

long_func_733:
    asr	w28,	w3,	#31
    asr	w7,	w25,	#31
    add	w16,	w16,	#1
    lsr	w2,	w28,	#31
    lsr	w9,	w7,	#31
    add	w14,	w3,	w2
    add	w20,	w25,	w9
    asr	w3,	w14,	#1
    asr	w25,	w20,	#1
    cmp	w16,	#16
    blt	long_func_706

long_func_739:
    movz	w18,	#0
    movz	w14,	#0

long_func_741:
    asr	w21,	w5,	#31
    lsr	w24,	w21,	#31
    add	w25,	w5,	w24
    asr	w13,	w25,	#1
    lsl	w15,	w13,	#1
    sub	w9,	w5,	w15
    cmp	w9,	#0
    beq	long_func_757

long_func_748:
    asr	w28,	w4,	#31
    lsr	w2,	w28,	#31
    add	w3,	w4,	w2
    asr	w16,	w3,	#1
    lsl	w19,	w16,	#1
    sub	w11,	w4,	w19
    cmp	w11,	#0
    beq	long_func_757

long_func_751:
    lsl	w12,	w14,	#2
    adrp	x16, :got:SHIFT_TABLE
    ldr	x16, [x16, #:got_lo12:SHIFT_TABLE]
    add	x13,	x16,	x12
    ldr	w19,	[x13]

    add	w18,	w19,	w18

long_func_757:
    asr	w6,	w5,	#31
    asr	w10,	w4,	#31
    add	w14,	w14,	#1
    lsr	w7,	w6,	#31
    lsr	w11,	w10,	#31
    add	w13,	w5,	w7
    add	w19,	w4,	w11
    asr	w5,	w13,	#1
    asr	w4,	w19,	#1
    cmp	w14,	#16
    blt	long_func_741

long_func_763:
    mul	w21,	w26,	w18
    movz	w4,	#0
    movz	w20,	#0
    movz	w12,	#65535

long_func_766:
    asr	w13,	w21,	#31
    lsr	w14,	w13,	#31
    add	w15,	w21,	w14
    asr	w25,	w15,	#1
    lsl	w28,	w25,	#1
    sub	w3,	w21,	w28
    cmp	w3,	#0
    beq	long_func_782

long_func_773:
    asr	w16,	w12,	#31
    lsr	w18,	w16,	#31
    add	w19,	w12,	w18
    asr	w2,	w19,	#1
    lsl	w3,	w2,	#1
    sub	w6,	w12,	w3
    cmp	w6,	#0
    beq	long_func_782

long_func_776:
    lsl	w9,	w20,	#2
    adrp	x11, :got:SHIFT_TABLE
    ldr	x11, [x11, #:got_lo12:SHIFT_TABLE]
    add	x9,	x11,	x9
    ldr	w13,	[x9]

    add	w4,	w13,	w4

long_func_782:
    asr	w24,	w21,	#31
    asr	w2,	w12,	#31
    add	w20,	w20,	#1
    lsr	w25,	w24,	#31
    lsr	w3,	w2,	#31
    add	w6,	w21,	w25
    add	w10,	w12,	w3
    asr	w21,	w6,	#1
    asr	w12,	w10,	#1
    cmp	w20,	#16
    blt	long_func_766

long_func_698:
    cmp	w4,	#0
    beq	long_func_789

long_func_701:
    mov	w5,	w27
    b	long_func_702

long_func_789:
    mov	w4,	w27

long_func_790:
    movz	w18,	#32767
    cmp	w17,	w18
    ble	long_func_797

long_func_793:
    sdiv	w17,	w17,	w26
    add	w18,	w17,	#65536
    sub	w17,	w18,	w23
    b	long_func_799

long_func_797:
    sdiv	w17,	w17,	w26

long_func_799:
    cmp	w17,	#0
    bne	long_func_569
    b	long_func_803

long_func_802:
    mov	w0,	w4

long_func_803:
    cmp	w8,	#0
    bne	long_func_810

long_func_1045:
    movz	w15,	#0
    b	long_func_1047

long_func_810:
    mov	w11,	w8
    movz	w15,	#0

long_func_812:
    movz	w12,	#0
    movz	w20,	#0
    mov	w18,	w8
    movz	w9,	#1

long_func_817:
    asr	w5,	w18,	#31
    lsr	w6,	w5,	#31
    add	w7,	w18,	w6
    asr	w10,	w7,	#1
    lsl	w13,	w10,	#1
    sub	w7,	w18,	w13
    cmp	w7,	#0
    beq	long_func_833

long_func_824:
    asr	w10,	w9,	#31
    lsr	w13,	w10,	#31
    add	w14,	w9,	w13
    asr	w14,	w14,	#1
    lsl	w16,	w14,	#1
    sub	w13,	w9,	w16
    cmp	w13,	#0
    beq	long_func_833

long_func_827:
    lsl	w17,	w20,	#2
    adrp	x19, :got:SHIFT_TABLE
    ldr	x19, [x19, #:got_lo12:SHIFT_TABLE]
    add	x16,	x19,	x17
    ldr	w21,	[x16]

    add	w12,	w21,	w12

long_func_833:
    asr	w16,	w18,	#31
    asr	w21,	w9,	#31
    add	w20,	w20,	#1
    lsr	w17,	w16,	#31
    lsr	w24,	w21,	#31
    add	w25,	w18,	w17
    add	w2,	w9,	w24
    asr	w18,	w25,	#1
    asr	w9,	w2,	#1
    cmp	w20,	#16
    blt	long_func_817

long_func_839:
    cmp	w12,	#0
    beq	long_func_934

long_func_841:
    cmp	w11,	#0
    beq	long_func_934

long_func_845:
    mov	w20,	w11

long_func_847:
    movz	w25,	#0
    movz	w6,	#0
    mov	w21,	w15
    mov	w18,	w20

long_func_851:
    asr	w14,	w21,	#31
    lsr	w16,	w14,	#31
    add	w17,	w21,	w16
    asr	w28,	w17,	#1
    lsl	w2,	w28,	#1
    sub	w7,	w21,	w2
    cmp	w7,	#0
    beq	long_func_868

long_func_858:
    asr	w19,	w18,	#31
    lsr	w24,	w19,	#31
    add	w27,	w18,	w24
    asr	w3,	w27,	#1
    lsl	w4,	w3,	#1
    sub	w10,	w18,	w4
    cmp	w10,	#0
    bne	long_func_878

long_func_861:
    lsl	w3,	w6,	#2
    adrp	x16, :got:SHIFT_TABLE
    ldr	x16, [x16, #:got_lo12:SHIFT_TABLE]
    add	x13,	x16,	x3
    ldr	w17,	[x13]

    add	w25,	w17,	w25
    b	long_func_878

long_func_868:
    asr	w28,	w18,	#31
    lsr	w2,	w28,	#31
    add	w3,	w18,	w2
    asr	w7,	w3,	#1
    lsl	w9,	w7,	#1
    sub	w24,	w18,	w9
    cmp	w24,	#0
    beq	long_func_878

long_func_871:
    lsl	w14,	w6,	#2
    adrp	x3, :got:SHIFT_TABLE
    ldr	x3, [x3, #:got_lo12:SHIFT_TABLE]
    add	x28,	x3,	x14
    ldr	w4,	[x28]

    add	w25,	w4,	w25

long_func_878:
    asr	w4,	w21,	#31
    asr	w9,	w18,	#31
    add	w6,	w6,	#1
    lsr	w5,	w4,	#31
    lsr	w10,	w9,	#31
    add	w14,	w21,	w5
    add	w18,	w18,	w10
    asr	w21,	w14,	#1
    asr	w18,	w18,	#1
    cmp	w6,	#16
    blt	long_func_851

long_func_884:
    movz	w4,	#0
    movz	w18,	#0

long_func_886:
    asr	w21,	w15,	#31
    lsr	w24,	w21,	#31
    add	w27,	w15,	w24
    asr	w10,	w27,	#1
    lsl	w12,	w10,	#1
    sub	w10,	w15,	w12
    cmp	w10,	#0
    beq	long_func_902

long_func_893:
    asr	w28,	w20,	#31
    lsr	w2,	w28,	#31
    add	w3,	w20,	w2
    asr	w13,	w3,	#1
    lsl	w14,	w13,	#1
    sub	w13,	w20,	w14
    cmp	w13,	#0
    beq	long_func_902

long_func_896:
    lsl	w24,	w18,	#2
    adrp	x19, :got:SHIFT_TABLE
    ldr	x19, [x19, #:got_lo12:SHIFT_TABLE]
    add	x16,	x19,	x24
    ldr	w21,	[x16]

    add	w4,	w21,	w4

long_func_902:
    asr	w5,	w15,	#31
    asr	w9,	w20,	#31
    add	w18,	w18,	#1
    lsr	w6,	w5,	#31
    add	w10,	w15,	w6
    asr	w15,	w10,	#1
    lsr	w10,	w9,	#31
    add	w14,	w20,	w10
    asr	w20,	w14,	#1
    cmp	w18,	#16
    blt	long_func_886

long_func_908:
    mul	w27,	w26,	w4
    movz	w20,	#0
    movz	w6,	#0
    movz	w28,	#65535

long_func_911:
    asr	w13,	w27,	#31
    lsr	w14,	w13,	#31
    add	w15,	w27,	w14
    asr	w18,	w15,	#1
    lsl	w19,	w18,	#1
    sub	w5,	w27,	w19
    cmp	w5,	#0
    beq	long_func_927

long_func_918:
    asr	w16,	w28,	#31
    lsr	w17,	w16,	#31
    add	w18,	w28,	w17
    asr	w21,	w18,	#1
    lsl	w24,	w21,	#1
    sub	w9,	w28,	w24
    cmp	w9,	#0
    beq	long_func_927

long_func_921:
    lsl	w17,	w6,	#2
    adrp	x14, :got:SHIFT_TABLE
    ldr	x14, [x14, #:got_lo12:SHIFT_TABLE]
    add	x12,	x14,	x17
    ldr	w15,	[x12]

    add	w20,	w15,	w20

long_func_927:
    asr	w19,	w27,	#31
    add	w6,	w6,	#1
    lsr	w21,	w19,	#31
    add	w2,	w27,	w21
    asr	w27,	w2,	#1
    asr	w2,	w28,	#31
    lsr	w3,	w2,	#31
    add	w5,	w28,	w3
    asr	w28,	w5,	#1
    cmp	w6,	#16
    blt	long_func_911

long_func_843:
    cmp	w20,	#0
    beq	long_func_938

long_func_846:
    mov	w15,	w25
    b	long_func_847

long_func_938:
    mov	w15,	w25

long_func_934:
    cmp	w11,	#0
    beq	long_func_1033

long_func_943:
    mov	w7,	w11

long_func_945:
    movz	w14,	#0
    movz	w10,	#0
    mov	w28,	w7
    mov	w27,	w11

long_func_949:
    asr	w2,	w28,	#31
    lsr	w3,	w2,	#31
    add	w4,	w28,	w3
    asr	w13,	w4,	#1
    lsl	w16,	w13,	#1
    sub	w9,	w28,	w16
    cmp	w9,	#0
    beq	long_func_966

long_func_956:
    asr	w5,	w27,	#31
    lsr	w6,	w5,	#31
    add	w9,	w27,	w6
    asr	w17,	w9,	#1
    lsl	w18,	w17,	#1
    sub	w13,	w27,	w18
    cmp	w13,	#0
    bne	long_func_976

long_func_959:
    lsl	w9,	w10,	#2
    adrp	x19, :got:SHIFT_TABLE
    ldr	x19, [x19, #:got_lo12:SHIFT_TABLE]
    add	x17,	x19,	x9
    ldr	w20,	[x17]

    add	w14,	w20,	w14
    b	long_func_976

long_func_966:
    asr	w12,	w27,	#31
    lsr	w13,	w12,	#31
    add	w16,	w27,	w13
    asr	w20,	w16,	#1
    lsl	w21,	w20,	#1
    sub	w24,	w27,	w21
    cmp	w24,	#0
    beq	long_func_976

long_func_969:
    lsl	w21,	w10,	#2
    adrp	x4, :got:SHIFT_TABLE
    ldr	x4, [x4, #:got_lo12:SHIFT_TABLE]
    add	x2,	x4,	x21
    ldr	w5,	[x2]

    add	w14,	w5,	w14

long_func_976:
    asr	w17,	w28,	#31
    asr	w20,	w27,	#31
    add	w10,	w10,	#1
    lsr	w18,	w17,	#31
    lsr	w21,	w20,	#31
    add	w24,	w28,	w18
    add	w2,	w27,	w21
    asr	w28,	w24,	#1
    asr	w27,	w2,	#1
    cmp	w10,	#16
    blt	long_func_949

long_func_982:
    movz	w24,	#0
    movz	w6,	#0

long_func_984:
    asr	w3,	w7,	#31
    lsr	w4,	w3,	#31
    add	w5,	w7,	w4
    asr	w21,	w5,	#1
    lsl	w25,	w21,	#1
    sub	w9,	w7,	w25
    cmp	w9,	#0
    beq	long_func_1000

long_func_991:
    asr	w9,	w11,	#31
    lsr	w10,	w9,	#31
    add	w12,	w11,	w10
    asr	w27,	w12,	#1
    lsl	w28,	w27,	#1
    sub	w12,	w11,	w28
    cmp	w12,	#0
    beq	long_func_1000

long_func_994:
    lsl	w27,	w6,	#2
    adrp	x18, :got:SHIFT_TABLE
    ldr	x18, [x18, #:got_lo12:SHIFT_TABLE]
    add	x16,	x18,	x27
    ldr	w19,	[x16]

    add	w24,	w19,	w24

long_func_1000:
    asr	w13,	w7,	#31
    asr	w18,	w11,	#31
    add	w6,	w6,	#1
    lsr	w16,	w13,	#31
    lsr	w19,	w18,	#31
    add	w16,	w7,	w16
    add	w19,	w11,	w19
    asr	w7,	w16,	#1
    asr	w11,	w19,	#1
    cmp	w6,	#16
    blt	long_func_984

long_func_1006:
    mul	w13,	w26,	w24
    movz	w11,	#0
    movz	w12,	#0
    movz	w2,	#65535

long_func_1009:
    asr	w24,	w13,	#31
    lsr	w25,	w24,	#31
    add	w27,	w13,	w25
    asr	w6,	w27,	#1
    lsl	w7,	w6,	#1
    sub	w4,	w13,	w7
    cmp	w4,	#0
    beq	long_func_1025

long_func_1016:
    asr	w28,	w2,	#31
    lsr	w3,	w28,	#31
    add	w4,	w2,	w3
    asr	w9,	w4,	#1
    lsl	w10,	w9,	#1
    sub	w6,	w2,	w10
    cmp	w6,	#0
    beq	long_func_1025

long_func_1019:
    lsl	w24,	w12,	#2
    adrp	x16, :got:SHIFT_TABLE
    ldr	x16, [x16, #:got_lo12:SHIFT_TABLE]
    add	x9,	x16,	x24
    ldr	w17,	[x9]

    add	w11,	w17,	w11

long_func_1025:
    asr	w5,	w13,	#31
    asr	w9,	w2,	#31
    add	w12,	w12,	#1
    lsr	w6,	w5,	#31
    lsr	w10,	w9,	#31
    add	w6,	w13,	w6
    add	w9,	w2,	w10
    asr	w13,	w6,	#1
    asr	w2,	w9,	#1
    cmp	w12,	#16
    blt	long_func_1009

long_func_941:
    cmp	w11,	#0
    beq	long_func_1032

long_func_944:
    mov	w7,	w14
    b	long_func_945

long_func_1032:
    mov	w11,	w14

long_func_1033:
    movz	w9,	#32767
    cmp	w8,	w9
    ble	long_func_1040

long_func_1036:
    sdiv	w2,	w8,	w26
    add	w3,	w2,	#65536
    sub	w8,	w3,	w23
    b	long_func_1042

long_func_1040:
    sdiv	w8,	w8,	w26

long_func_1042:
    cmp	w8,	#0
    bne	long_func_812

long_func_1047:
    movz	w20,	#32767
    cmp	w1,	w20
    ble	long_func_1054

long_func_1050:
    sdiv	w5,	w1,	w26
    add	w6,	w5,	#65536
    sub	w1,	w6,	w23
    b	long_func_1056

long_func_1054:
    sdiv	w1,	w1,	w26

long_func_1056:
    cmp	w1,	#0
    ble	long_func_1061

long_func_535:
    mov	w8,	w15
    mov	w4,	w0
    b	long_func_536

long_func_1061:
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w22,	w22,	#1
    cmp	w22,	#16
    blt	long_func_531

long_func_1065:
    movz	w13,	#0

long_func_1067:
    cmp	w13,	#16
    bge	long_func_1605

long_func_1070:
    cmp	w13,	#0
    bgt	long_func_1072

long_func_1597:
    movz	w0,	#1
    b	long_func_1599

long_func_1072:
    movz	w2,	#2
    mov	w4,	w13
    movz	w25,	#1

long_func_1074:
    movz	w9,	#0
    movz	w0,	#0
    mov	w15,	w4
    movz	w3,	#1

long_func_1079:
    asr	w11,	w15,	#31
    lsr	w12,	w11,	#31
    add	w14,	w15,	w12
    asr	w1,	w14,	#1
    lsl	w5,	w1,	#1
    sub	w8,	w15,	w5
    cmp	w8,	#0
    beq	long_func_1095

long_func_1086:
    asr	w16,	w3,	#31
    lsr	w17,	w16,	#31
    add	w18,	w3,	w17
    asr	w6,	w18,	#1
    lsl	w7,	w6,	#1
    sub	w11,	w3,	w7
    cmp	w11,	#0
    beq	long_func_1095

long_func_1089:
    lsl	w1,	w0,	#2
    adrp	x17, :got:SHIFT_TABLE
    ldr	x17, [x17, #:got_lo12:SHIFT_TABLE]
    add	x14,	x17,	x1
    ldr	w18,	[x14]

    add	w9,	w18,	w9

long_func_1095:
    asr	w19,	w15,	#31
    asr	w22,	w3,	#31
    add	w0,	w0,	#1
    lsr	w20,	w19,	#31
    lsr	w24,	w22,	#31
    add	w21,	w15,	w20
    add	w27,	w3,	w24
    asr	w15,	w21,	#1
    asr	w3,	w27,	#1
    cmp	w0,	#16
    blt	long_func_1079

long_func_1101:
    cmp	w9,	#0
    beq	long_func_1340

long_func_1103:
    cmp	w2,	#0
    bne	long_func_1105

long_func_1344:
    movz	w0,	#0
    b	long_func_1341

long_func_1105:
    mov	w15,	w2
    movz	w0,	#0

long_func_1107:
    movz	w8,	#0
    movz	w9,	#0
    mov	w3,	w15
    movz	w10,	#1

long_func_1112:
    asr	w7,	w3,	#31
    lsr	w11,	w7,	#31
    add	w12,	w3,	w11
    asr	w7,	w12,	#1
    lsl	w11,	w7,	#1
    sub	w21,	w3,	w11
    cmp	w21,	#0
    beq	long_func_1128

long_func_1119:
    asr	w14,	w10,	#31
    lsr	w16,	w14,	#31
    add	w17,	w10,	w16
    asr	w12,	w17,	#1
    lsl	w14,	w12,	#1
    sub	w24,	w10,	w14
    cmp	w24,	#0
    beq	long_func_1128

long_func_1122:
    lsl	w19,	w9,	#2
    adrp	x5, :got:SHIFT_TABLE
    ldr	x5, [x5, #:got_lo12:SHIFT_TABLE]
    add	x28,	x5,	x19
    ldr	w6,	[x28]

    add	w8,	w6,	w8

long_func_1128:
    asr	w18,	w3,	#31
    asr	w21,	w10,	#31
    add	w9,	w9,	#1
    lsr	w19,	w18,	#31
    lsr	w22,	w21,	#31
    add	w17,	w3,	w19
    add	w20,	w10,	w22
    asr	w3,	w17,	#1
    asr	w10,	w20,	#1
    cmp	w9,	#16
    blt	long_func_1112

long_func_1134:
    cmp	w8,	#0
    beq	long_func_1229

long_func_1136:
    cmp	w25,	#0
    beq	long_func_1229

long_func_1140:
    mov	w28,	w25

long_func_1142:
    movz	w19,	#0
    movz	w12,	#0
    mov	w7,	w0
    mov	w10,	w28

long_func_1146:
    asr	w27,	w7,	#31
    lsr	w1,	w27,	#31
    add	w3,	w7,	w1
    asr	w1,	w3,	#1
    lsl	w3,	w1,	#1
    sub	w6,	w7,	w3
    cmp	w6,	#0
    beq	long_func_1163

long_func_1153:
    asr	w5,	w10,	#31
    lsr	w6,	w5,	#31
    add	w8,	w10,	w6
    asr	w5,	w8,	#1
    lsl	w6,	w5,	#1
    sub	w9,	w10,	w6
    cmp	w9,	#0
    bne	long_func_1173

long_func_1156:
    lsl	w18,	w12,	#2
    adrp	x17, :got:SHIFT_TABLE
    ldr	x17, [x17, #:got_lo12:SHIFT_TABLE]
    add	x14,	x17,	x18
    ldr	w18,	[x14]

    add	w19,	w18,	w19
    b	long_func_1173

long_func_1163:
    asr	w9,	w10,	#31
    lsr	w11,	w9,	#31
    add	w14,	w10,	w11
    asr	w9,	w14,	#1
    lsl	w11,	w9,	#1
    sub	w21,	w10,	w11
    cmp	w21,	#0
    beq	long_func_1173

long_func_1166:
    lsl	w5,	w12,	#2
    adrp	x1, :got:SHIFT_TABLE
    ldr	x1, [x1, #:got_lo12:SHIFT_TABLE]
    add	x24,	x1,	x5
    ldr	w3,	[x24]

    add	w19,	w3,	w19

long_func_1173:
    asr	w16,	w7,	#31
    asr	w20,	w10,	#31
    add	w12,	w12,	#1
    lsr	w17,	w16,	#31
    lsr	w21,	w20,	#31
    add	w16,	w7,	w17
    add	w20,	w10,	w21
    asr	w7,	w16,	#1
    asr	w10,	w20,	#1
    cmp	w12,	#16
    blt	long_func_1146

long_func_1179:
    movz	w3,	#0
    movz	w20,	#0

long_func_1181:
    asr	w21,	w0,	#31
    lsr	w22,	w21,	#31
    add	w24,	w0,	w22
    asr	w7,	w24,	#1
    lsl	w8,	w7,	#1
    sub	w21,	w0,	w8
    cmp	w21,	#0
    beq	long_func_1197

long_func_1188:
    asr	w27,	w28,	#31
    lsr	w1,	w27,	#31
    add	w5,	w28,	w1
    asr	w9,	w5,	#1
    lsl	w10,	w9,	#1
    sub	w24,	w28,	w10
    cmp	w24,	#0
    beq	long_func_1197

long_func_1191:
    lsl	w21,	w20,	#2
    adrp	x6, :got:SHIFT_TABLE
    ldr	x6, [x6, #:got_lo12:SHIFT_TABLE]
    add	x1,	x6,	x21
    ldr	w7,	[x1]

    add	w3,	w7,	w3

long_func_1197:
    asr	w6,	w0,	#31
    asr	w9,	w28,	#31
    add	w20,	w20,	#1
    lsr	w7,	w6,	#31
    lsr	w10,	w9,	#31
    add	w0,	w0,	w7
    add	w7,	w28,	w10
    asr	w0,	w0,	#1
    asr	w28,	w7,	#1
    cmp	w20,	#16
    blt	long_func_1181

long_func_1203:
    mul	w0,	w26,	w3
    movz	w28,	#0
    movz	w5,	#0
    movz	w8,	#65535

long_func_1206:
    asr	w14,	w0,	#31
    lsr	w16,	w14,	#31
    add	w17,	w0,	w16
    asr	w17,	w17,	#1
    lsl	w18,	w17,	#1
    sub	w17,	w0,	w18
    cmp	w17,	#0
    beq	long_func_1222

long_func_1213:
    asr	w18,	w8,	#31
    lsr	w20,	w18,	#31
    add	w21,	w8,	w20
    asr	w20,	w21,	#1
    lsl	w21,	w20,	#1
    sub	w20,	w8,	w21
    cmp	w20,	#0
    beq	long_func_1222

long_func_1216:
    lsl	w17,	w5,	#2
    adrp	x27, :got:SHIFT_TABLE
    ldr	x27, [x27, #:got_lo12:SHIFT_TABLE]
    add	x22,	x27,	x17
    ldr	w1,	[x22]

    add	w28,	w1,	w28

long_func_1222:
    asr	w22,	w0,	#31
    asr	w1,	w8,	#31
    add	w5,	w5,	#1
    lsr	w24,	w22,	#31
    lsr	w3,	w1,	#31
    add	w18,	w0,	w24
    add	w22,	w8,	w3
    asr	w0,	w18,	#1
    asr	w8,	w22,	#1
    cmp	w5,	#16
    blt	long_func_1206

long_func_1138:
    cmp	w28,	#0
    beq	long_func_1233

long_func_1141:
    mov	w0,	w19
    b	long_func_1142

long_func_1233:
    mov	w0,	w19

long_func_1229:
    cmp	w25,	#0
    beq	long_func_1328

long_func_1238:
    mov	w20,	w25

long_func_1240:
    movz	w1,	#0
    movz	w17,	#0
    mov	w11,	w20
    mov	w18,	w25

long_func_1244:
    asr	w10,	w11,	#31
    lsr	w12,	w10,	#31
    add	w14,	w11,	w12
    asr	w14,	w14,	#1
    lsl	w16,	w14,	#1
    sub	w8,	w11,	w16
    cmp	w8,	#0
    beq	long_func_1261

long_func_1251:
    asr	w16,	w18,	#31
    lsr	w19,	w16,	#31
    add	w21,	w18,	w19
    asr	w19,	w21,	#1
    lsl	w21,	w19,	#1
    sub	w10,	w18,	w21
    cmp	w10,	#0
    bne	long_func_1271

long_func_1254:
    lsl	w27,	w17,	#2
    adrp	x19, :got:SHIFT_TABLE
    ldr	x19, [x19, #:got_lo12:SHIFT_TABLE]
    add	x14,	x19,	x27
    ldr	w21,	[x14]

    add	w1,	w21,	w1
    b	long_func_1271

long_func_1261:
    asr	w22,	w18,	#31
    lsr	w24,	w22,	#31
    add	w27,	w18,	w24
    asr	w24,	w27,	#1
    lsl	w27,	w24,	#1
    sub	w24,	w18,	w27
    cmp	w24,	#0
    beq	long_func_1271

long_func_1264:
    lsl	w10,	w17,	#2
    adrp	x5, :got:SHIFT_TABLE
    ldr	x5, [x5, #:got_lo12:SHIFT_TABLE]
    add	x28,	x5,	x10
    ldr	w6,	[x28]

    add	w1,	w6,	w1

long_func_1271:
    asr	w28,	w11,	#31
    asr	w6,	w18,	#31
    add	w17,	w17,	#1
    lsr	w3,	w28,	#31
    lsr	w7,	w6,	#31
    add	w24,	w11,	w3
    add	w3,	w18,	w7
    asr	w11,	w24,	#1
    asr	w18,	w3,	#1
    cmp	w17,	#16
    blt	long_func_1244

long_func_1277:
    movz	w22,	#0
    movz	w27,	#0

long_func_1279:
    asr	w5,	w20,	#31
    lsr	w6,	w5,	#31
    add	w7,	w20,	w6
    asr	w16,	w7,	#1
    lsl	w17,	w16,	#1
    sub	w17,	w20,	w17
    cmp	w17,	#0
    beq	long_func_1295

long_func_1286:
    asr	w8,	w25,	#31
    lsr	w9,	w8,	#31
    add	w10,	w25,	w9
    asr	w18,	w10,	#1
    lsl	w19,	w18,	#1
    sub	w19,	w25,	w19
    cmp	w19,	#0
    beq	long_func_1295

long_func_1289:
    lsl	w21,	w27,	#2
    adrp	x3, :got:SHIFT_TABLE
    ldr	x3, [x3, #:got_lo12:SHIFT_TABLE]
    add	x24,	x3,	x21
    ldr	w5,	[x24]

    add	w22,	w5,	w22

long_func_1295:
    asr	w11,	w20,	#31
    asr	w16,	w25,	#31
    add	w27,	w27,	#1
    lsr	w12,	w11,	#31
    lsr	w17,	w16,	#31
    add	w7,	w20,	w12
    add	w10,	w25,	w17
    asr	w20,	w7,	#1
    asr	w25,	w10,	#1
    cmp	w27,	#16
    blt	long_func_1279

long_func_1301:
    mul	w7,	w26,	w22
    movz	w25,	#0
    movz	w27,	#0
    movz	w5,	#65535

long_func_1304:
    asr	w21,	w7,	#31
    lsr	w22,	w21,	#31
    add	w24,	w7,	w22
    asr	w3,	w24,	#1
    lsl	w6,	w3,	#1
    sub	w16,	w7,	w6
    cmp	w16,	#0
    beq	long_func_1320

long_func_1311:
    asr	w28,	w5,	#31
    lsr	w3,	w28,	#31
    add	w6,	w5,	w3
    asr	w8,	w6,	#1
    lsl	w9,	w8,	#1
    sub	w18,	w5,	w9
    cmp	w18,	#0
    beq	long_func_1320

long_func_1314:
    lsl	w19,	w27,	#2
    adrp	x22, :got:SHIFT_TABLE
    ldr	x22, [x22, #:got_lo12:SHIFT_TABLE]
    add	x20,	x22,	x19
    ldr	w24,	[x20]

    add	w25,	w24,	w25

long_func_1320:
    asr	w8,	w7,	#31
    asr	w11,	w5,	#31
    add	w27,	w27,	#1
    lsr	w9,	w8,	#31
    lsr	w12,	w11,	#31
    add	w22,	w7,	w9
    add	w3,	w5,	w12
    asr	w7,	w22,	#1
    asr	w5,	w3,	#1
    cmp	w27,	#16
    blt	long_func_1304

long_func_1236:
    cmp	w25,	#0
    beq	long_func_1327

long_func_1239:
    mov	w20,	w1
    b	long_func_1240

long_func_1327:
    mov	w25,	w1

long_func_1328:
    movz	w11,	#32767
    cmp	w15,	w11
    ble	long_func_1335

long_func_1331:
    sdiv	w15,	w15,	w26
    add	w16,	w15,	#65536
    sub	w15,	w16,	w23
    b	long_func_1337

long_func_1335:
    sdiv	w15,	w15,	w26

long_func_1337:
    cmp	w15,	#0
    bne	long_func_1107
    b	long_func_1341

long_func_1340:
    mov	w0,	w25

long_func_1341:
    cmp	w2,	#0
    bne	long_func_1348

long_func_1583:
    movz	w25,	#0
    b	long_func_1585

long_func_1348:
    mov	w11,	w2
    movz	w25,	#0

long_func_1350:
    movz	w15,	#0
    movz	w8,	#0
    mov	w27,	w2
    movz	w16,	#1

long_func_1355:
    asr	w14,	w27,	#31
    lsr	w17,	w14,	#31
    add	w18,	w27,	w17
    asr	w14,	w18,	#1
    lsl	w17,	w14,	#1
    sub	w20,	w27,	w17
    cmp	w20,	#0
    beq	long_func_1371

long_func_1362:
    asr	w19,	w16,	#31
    lsr	w20,	w19,	#31
    add	w21,	w16,	w20
    asr	w18,	w21,	#1
    lsl	w19,	w18,	#1
    sub	w22,	w16,	w19
    cmp	w22,	#0
    beq	long_func_1371

long_func_1365:
    lsl	w1,	w8,	#2
    adrp	x3, :got:SHIFT_TABLE
    ldr	x3, [x3, #:got_lo12:SHIFT_TABLE]
    add	x28,	x3,	x1
    ldr	w5,	[x28]

    add	w15,	w5,	w15

long_func_1371:
    asr	w22,	w27,	#31
    asr	w1,	w16,	#31
    add	w8,	w8,	#1
    lsr	w24,	w22,	#31
    lsr	w3,	w1,	#31
    add	w17,	w27,	w24
    add	w19,	w16,	w3
    asr	w27,	w17,	#1
    asr	w16,	w19,	#1
    cmp	w8,	#16
    blt	long_func_1355

long_func_1377:
    cmp	w15,	#0
    beq	long_func_1472

long_func_1379:
    cmp	w11,	#0
    beq	long_func_1472

long_func_1383:
    mov	w20,	w11

long_func_1385:
    movz	w14,	#0
    movz	w7,	#0
    mov	w5,	w25
    mov	w15,	w20

long_func_1389:
    asr	w18,	w5,	#31
    lsr	w19,	w18,	#31
    add	w21,	w5,	w19
    asr	w17,	w21,	#1
    lsl	w18,	w17,	#1
    sub	w19,	w5,	w18
    cmp	w19,	#0
    beq	long_func_1406

long_func_1396:
    asr	w22,	w15,	#31
    lsr	w24,	w22,	#31
    add	w27,	w15,	w24
    asr	w19,	w27,	#1
    lsl	w21,	w19,	#1
    sub	w22,	w15,	w21
    cmp	w22,	#0
    bne	long_func_1416

long_func_1399:
    lsl	w18,	w7,	#2
    adrp	x1, :got:SHIFT_TABLE
    ldr	x1, [x1, #:got_lo12:SHIFT_TABLE]
    add	x27,	x1,	x18
    ldr	w3,	[x27]

    add	w14,	w3,	w14
    b	long_func_1416

long_func_1406:
    asr	w28,	w15,	#31
    lsr	w1,	w28,	#31
    add	w3,	w15,	w1
    asr	w24,	w3,	#1
    lsl	w27,	w24,	#1
    sub	w8,	w15,	w27
    cmp	w8,	#0
    beq	long_func_1416

long_func_1409:
    lsl	w1,	w7,	#2
    adrp	x16, :got:SHIFT_TABLE
    ldr	x16, [x16, #:got_lo12:SHIFT_TABLE]
    add	x10,	x16,	x1
    ldr	w17,	[x10]

    add	w14,	w17,	w14

long_func_1416:
    asr	w6,	w5,	#31
    asr	w10,	w15,	#31
    add	w7,	w7,	#1
    lsr	w8,	w6,	#31
    lsr	w12,	w10,	#31
    add	w24,	w5,	w8
    add	w1,	w15,	w12
    asr	w5,	w24,	#1
    asr	w15,	w1,	#1
    cmp	w7,	#16
    blt	long_func_1389

long_func_1422:
    movz	w16,	#0
    movz	w9,	#0

long_func_1424:
    asr	w3,	w25,	#31
    lsr	w5,	w3,	#31
    add	w6,	w25,	w5
    asr	w15,	w6,	#1
    lsl	w17,	w15,	#1
    sub	w22,	w25,	w17
    cmp	w22,	#0
    beq	long_func_1440

long_func_1431:
    asr	w7,	w20,	#31
    lsr	w8,	w7,	#31
    add	w10,	w20,	w8
    asr	w18,	w10,	#1
    lsl	w19,	w18,	#1
    sub	w27,	w20,	w19
    cmp	w27,	#0
    beq	long_func_1440

long_func_1434:
    lsl	w7,	w9,	#2
    adrp	x5, :got:SHIFT_TABLE
    ldr	x5, [x5, #:got_lo12:SHIFT_TABLE]
    add	x1,	x5,	x7
    ldr	w6,	[x1]

    add	w16,	w6,	w16

long_func_1440:
    asr	w12,	w25,	#31
    asr	w18,	w20,	#31
    add	w9,	w9,	#1
    lsr	w15,	w12,	#31
    lsr	w19,	w18,	#31
    add	w1,	w25,	w15
    add	w6,	w20,	w19
    asr	w25,	w1,	#1
    asr	w20,	w6,	#1
    cmp	w9,	#16
    blt	long_func_1424

long_func_1446:
    mul	w17,	w26,	w16
    movz	w20,	#0
    movz	w18,	#0
    movz	w28,	#65535

long_func_1449:
    asr	w22,	w17,	#31
    lsr	w24,	w22,	#31
    add	w25,	w17,	w24
    asr	w25,	w25,	#1
    lsl	w27,	w25,	#1
    sub	w16,	w17,	w27
    cmp	w16,	#0
    beq	long_func_1465

long_func_1456:
    asr	w27,	w28,	#31
    lsr	w1,	w27,	#31
    add	w3,	w28,	w1
    asr	w1,	w3,	#1
    lsl	w3,	w1,	#1
    sub	w21,	w28,	w3
    cmp	w21,	#0
    beq	long_func_1465

long_func_1459:
    lsl	w3,	w18,	#2
    adrp	x27, :got:SHIFT_TABLE
    ldr	x27, [x27, #:got_lo12:SHIFT_TABLE]
    add	x24,	x27,	x3
    ldr	w1,	[x24]

    add	w20,	w1,	w20

long_func_1465:
    asr	w5,	w17,	#31
    asr	w8,	w28,	#31
    add	w18,	w18,	#1
    lsr	w6,	w5,	#31
    lsr	w9,	w8,	#31
    add	w19,	w17,	w6
    add	w25,	w28,	w9
    asr	w17,	w19,	#1
    asr	w28,	w25,	#1
    cmp	w18,	#16
    blt	long_func_1449

long_func_1381:
    cmp	w20,	#0
    beq	long_func_1476

long_func_1384:
    mov	w25,	w14
    b	long_func_1385

long_func_1476:
    mov	w25,	w14

long_func_1472:
    cmp	w11,	#0
    beq	long_func_1571

long_func_1481:
    mov	w8,	w11

long_func_1483:
    movz	w7,	#0
    movz	w12,	#0
    mov	w10,	w8
    mov	w20,	w11

long_func_1487:
    asr	w1,	w10,	#31
    lsr	w3,	w1,	#31
    add	w5,	w10,	w3
    asr	w1,	w5,	#1
    lsl	w3,	w1,	#1
    sub	w21,	w10,	w3
    cmp	w21,	#0
    beq	long_func_1504

long_func_1494:
    asr	w6,	w20,	#31
    lsr	w9,	w6,	#31
    add	w14,	w20,	w9
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w24,	w20,	w6
    cmp	w24,	#0
    bne	long_func_1514

long_func_1497:
    lsl	w24,	w12,	#2
    adrp	x3, :got:SHIFT_TABLE
    ldr	x3, [x3, #:got_lo12:SHIFT_TABLE]
    add	x28,	x3,	x24
    ldr	w5,	[x28]

    add	w7,	w5,	w7
    b	long_func_1514

long_func_1504:
    asr	w15,	w20,	#31
    lsr	w16,	w15,	#31
    add	w17,	w20,	w16
    asr	w14,	w17,	#1
    lsl	w15,	w14,	#1
    sub	w9,	w20,	w15
    cmp	w9,	#0
    beq	long_func_1514

long_func_1507:
    lsl	w9,	w12,	#2
    adrp	x17, :got:SHIFT_TABLE
    ldr	x17, [x17, #:got_lo12:SHIFT_TABLE]
    add	x15,	x17,	x9
    ldr	w18,	[x15]

    add	w7,	w18,	w7

long_func_1514:
    asr	w18,	w10,	#31
    asr	w22,	w20,	#31
    add	w12,	w12,	#1
    lsr	w19,	w18,	#31
    lsr	w24,	w22,	#31
    add	w5,	w10,	w19
    add	w14,	w20,	w24
    asr	w10,	w5,	#1
    asr	w20,	w14,	#1
    cmp	w12,	#16
    blt	long_func_1487

long_func_1520:
    movz	w24,	#0
    movz	w17,	#0

long_func_1522:
    asr	w12,	w8,	#31
    lsr	w14,	w12,	#31
    add	w15,	w8,	w14
    asr	w27,	w15,	#1
    lsl	w28,	w27,	#1
    sub	w19,	w8,	w28
    cmp	w19,	#0
    beq	long_func_1538

long_func_1529:
    asr	w16,	w11,	#31
    lsr	w18,	w16,	#31
    add	w19,	w11,	w18
    asr	w1,	w19,	#1
    lsl	w3,	w1,	#1
    sub	w21,	w11,	w3
    cmp	w21,	#0
    beq	long_func_1538

long_func_1532:
    lsl	w10,	w17,	#2
    adrp	x1, :got:SHIFT_TABLE
    ldr	x1, [x1, #:got_lo12:SHIFT_TABLE]
    add	x27,	x1,	x10
    ldr	w3,	[x27]

    add	w24,	w3,	w24

long_func_1538:
    asr	w20,	w8,	#31
    asr	w27,	w11,	#31
    add	w17,	w17,	#1
    lsr	w21,	w20,	#31
    lsr	w28,	w27,	#31
    add	w6,	w8,	w21
    add	w11,	w11,	w28
    asr	w8,	w6,	#1
    asr	w11,	w11,	#1
    cmp	w17,	#16
    blt	long_func_1522

long_func_1544:
    mul	w14,	w26,	w24
    movz	w11,	#0
    movz	w20,	#65535
    movz	w24,	#0

long_func_1547:
    asr	w3,	w14,	#31
    lsr	w5,	w3,	#31
    add	w6,	w14,	w5
    asr	w9,	w6,	#1
    lsl	w10,	w9,	#1
    sub	w15,	w14,	w10
    cmp	w15,	#0
    beq	long_func_1563

long_func_1554:
    asr	w8,	w20,	#31
    lsr	w9,	w8,	#31
    add	w10,	w20,	w9
    asr	w12,	w10,	#1
    lsl	w15,	w12,	#1
    sub	w17,	w20,	w15
    cmp	w17,	#0
    beq	long_func_1563

long_func_1557:
    lsl	w5,	w24,	#2
    adrp	x22, :got:SHIFT_TABLE
    ldr	x22, [x22, #:got_lo12:SHIFT_TABLE]
    add	x19,	x22,	x5
    ldr	w27,	[x19]

    add	w11,	w27,	w11

long_func_1563:
    asr	w12,	w14,	#31
    asr	w17,	w20,	#31
    add	w24,	w24,	#1
    lsr	w15,	w12,	#31
    lsr	w18,	w17,	#31
    add	w22,	w14,	w15
    add	w1,	w20,	w18
    asr	w14,	w22,	#1
    asr	w20,	w1,	#1
    cmp	w24,	#16
    blt	long_func_1547

long_func_1479:
    cmp	w11,	#0
    beq	long_func_1570

long_func_1482:
    mov	w8,	w7
    b	long_func_1483

long_func_1570:
    mov	w11,	w7

long_func_1571:
    movz	w3,	#32767
    cmp	w2,	w3
    ble	long_func_1578

long_func_1574:
    sdiv	w27,	w2,	w26
    add	w28,	w27,	#65536
    sub	w2,	w28,	w23
    b	long_func_1580

long_func_1578:
    sdiv	w2,	w2,	w26

long_func_1580:
    cmp	w2,	#0
    bne	long_func_1350

long_func_1585:
    movz	w1,	#32767
    cmp	w4,	w1
    ble	long_func_1592

long_func_1588:
    sdiv	w3,	w4,	w26
    add	w4,	w3,	#65536
    sub	w4,	w4,	w23
    b	long_func_1594

long_func_1592:
    sdiv	w4,	w4,	w26

long_func_1594:
    cmp	w4,	#0
    ble	long_func_1599

long_func_1073:
    mov	w2,	w25
    mov	w25,	w0
    b	long_func_1074

long_func_1599:
    lsl	w9,	w13,	#2
    adrp	x10, :got:SHIFT_TABLE
    add	w13,	w13,	#1
    ldr	x10, [x10, #:got_lo12:SHIFT_TABLE]
    add	x8,	x10,	x9
    ldr	w11,	[x8]

    cmp	w11,	w0
    beq	long_func_1067

long_func_1606:
    movz	w0,	#1
    b	long_func_1607

long_func_1605:
    movz	w0,	#0

long_func_1607:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


long_func_5:
    mov	w28,	w14
    mov	w12,	w0
    b	long_func_6

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	long_func
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


