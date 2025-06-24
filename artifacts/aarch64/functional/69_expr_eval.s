.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2160
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w21,	w0
    bl	getch
    movz	w20,	#32

main_5:
    cmp	w20,	#10
    cset	w12,	eq
    cmp	w20,	#32
    movz	w3,	#1
    csel	w14,	w3,	w12,	eq
    cmp	w14,	#0
    beq	main_14

main_12:
    bl	getch
    mov	w20,	w0
    b	main_5

main_14:
    cmp	w20,	#57
    cset	w18,	le
    cmp	w20,	#48
    movz	w4,	#0
    csel	w23,	w18,	w4,	ge
    cmp	w23,	#0
    beq	main_34

main_20:
    sub	w22,	w20,	#48

main_22:
    bl	getch
    cmp	w0,	#57
    cset	w28,	le
    cmp	w0,	#48
    movz	w5,	#0
    csel	w3,	w28,	w5,	ge
    cmp	w3,	#0
    beq	main_36

main_30:
    lsl	w2,	w22,	#1
    add	w15,	w2,	w22,	lsl #3
    add	w16,	w15,	w0
    sub	w22,	w16,	#48
    b	main_22

main_36:
    movz	w9,	#0
    movz	w2,	#0
    mov	w13,	w22
    mov	w23,	w2
    b	main_37

main_34:
    bl	getch
    movz	w13,	#0
    mov	w23,	w20
    movz	w9,	#1

main_37:
    cmp	w21,	#0
    beq	main_373

main_43:
    add	x22,	sp,	#1040
    add	x20,	sp,	#16
    movz	fp,	#2108
    add	x6,	sp,	#1040
    add	x27,	sp,	#16
    mov	w14,	w21
    mov	w26,	w13
    str	x20,	[sp, fp]

    mov	w21,	w0
    mov	w20,	w9
    movz	fp,	#2076
    str	x6,	[sp, #2064]

    ldr	x15,	[sp, #2064]

    str	x15,	[sp, fp]

    movz	fp,	#2124
    ldr	x3,	[sp, #2064]

    add	x3,	x3,	#4
    str	x3,	[sp, fp]

    str	w14,	[sp, #2104]


main_52:
    mov	x0,	x22
    movz	w1,	#0
    movz	w2,	#1024
    bl	memset
    movz	w2,	#1024
    movz	w1,	#0
    movz	fp,	#2108
    ldr	x0,	[sp, fp]

    bl	memset
    movz	w3,	#65535
    movk	w3,	#65535,	lsl #16
    str	w3,	[sp, #2072]

    cmp	w20,	#0
    bne	main_59

main_60:
    movz	w3,	#1
    movz	fp,	#2076
    ldr	x16,	[sp, fp]

    movz	fp,	#2124
    str	w3,	[x16]

    ldr	x4,	[sp, fp]

    str	w26,	[x4]


main_61:
    cmp	w21,	#10
    cset	w2,	eq
    cmp	w21,	#32
    movz	w6,	#1
    csel	w6,	w6,	w2,	eq
    cmp	w6,	#0
    beq	main_70

main_68:
    bl	getch
    mov	w21,	w0
    b	main_61

main_70:
    cmp	w21,	#57
    cset	w5,	le
    cmp	w21,	#48
    movz	w8,	#0
    csel	w7,	w5,	w8,	ge
    cmp	w7,	#0
    beq	main_90

main_76:
    sub	w8,	w21,	#48
    mov	w26,	w8

main_78:
    bl	getch
    cmp	w0,	#57
    cset	w18,	le
    cmp	w0,	#48
    movz	w6,	#0
    csel	w20,	w18,	w6,	ge
    cmp	w20,	#0
    beq	main_92

main_86:
    lsl	w9,	w26,	#1
    add	w15,	w9,	w26,	lsl #3
    add	w16,	w15,	w0
    sub	w17,	w16,	#48
    mov	w26,	w17
    b	main_78

main_92:
    movz	w20,	#0
    mov	w5,	w23
    mov	w19,	w0
    b	main_93

main_90:
    bl	getch
    mov	w5,	w21
    movz	w20,	#1
    mov	w19,	w0

main_93:
    str	w5,	[sp, #2084]

    mov	w28,	w26

main_98:
    cmp	w20,	#1
    bne	main_281

main_104:
    ldr	w18,	[sp, #2084]

    cmp	w18,	#43
    beq	main_115

main_106:
    ldr	w21,	[sp, #2084]

    cmp	w21,	#45
    beq	main_116

main_108:
    ldr	w24,	[sp, #2084]

    cmp	w24,	#42
    beq	main_117

main_110:
    ldr	w25,	[sp, #2084]

    cmp	w25,	#37
    movz	w6,	#0
    ldr	w7,	[sp, #2084]

    movz	w9,	#20
    csel	w15,	w9,	w6,	eq
    cmp	w7,	#47
    movz	w8,	#20
    csel	w2,	w8,	w15,	eq
    b	main_118

main_117:
    movz	w2,	#20
    b	main_118

main_116:
    movz	w2,	#10
    b	main_118

main_115:
    movz	w2,	#10

main_118:
    cmp	w2,	#0
    beq	main_281

main_121:
    mov	w24,	w19

main_122:
    cmp	w24,	#10
    cset	w7,	eq
    cmp	w24,	#32
    movz	w9,	#1
    csel	w9,	w9,	w7,	eq
    cmp	w9,	#0
    beq	main_131

main_129:
    bl	getch
    mov	w24,	w0
    b	main_122

main_131:
    cmp	w24,	#57
    cset	w13,	le
    cmp	w24,	#48
    movz	w8,	#0
    csel	w15,	w13,	w8,	ge
    cmp	w15,	#0
    beq	main_151

main_137:
    sub	w14,	w24,	#48
    mov	w19,	w14

main_139:
    bl	getch
    cmp	w0,	#57
    cset	w3,	le
    cmp	w0,	#48
    movz	w14,	#0
    csel	w3,	w3,	w14,	ge
    cmp	w3,	#0
    beq	main_153

main_147:
    lsl	w10,	w19,	#1
    add	w21,	w10,	w19,	lsl #3
    add	w24,	w21,	w0
    sub	w25,	w24,	#48
    mov	w19,	w25
    b	main_139

main_153:
    movz	w2,	#0
    ldr	w12,	[sp, #2084]

    mov	w6,	w19
    mov	w13,	w0
    b	main_154

main_151:
    bl	getch
    mov	w6,	w28
    mov	w12,	w24
    movz	w2,	#1
    mov	w13,	w0

main_154:
    mov	w19,	w2
    mov	w26,	w12
    mov	w25,	w6
    mov	w20,	w13

main_159:
    ldr	w4,	[x27]

    cmp	w4,	#0
    beq	main_233

main_166:
    lsl	w10,	w4,	#2
    add	x9,	x27,	x10
    ldr	w1,	[x9]

    cmp	w1,	#43
    beq	main_179

main_170:
    cmp	w1,	#45
    beq	main_180

main_172:
    cmp	w1,	#42
    beq	main_181

main_174:
    cmp	w1,	#37
    movz	w16,	#0
    movz	w18,	#20
    csel	w3,	w18,	w16,	eq
    cmp	w1,	#47
    movz	w17,	#20
    csel	w15,	w17,	w3,	eq
    b	main_182

main_181:
    movz	w15,	#20
    b	main_182

main_180:
    movz	w15,	#10
    b	main_182

main_179:
    movz	w15,	#10

main_182:
    ldr	w11,	[sp, #2084]

    cmp	w11,	#43
    beq	main_194

main_185:
    ldr	w3,	[sp, #2084]

    cmp	w3,	#45
    beq	main_195

main_187:
    ldr	w5,	[sp, #2084]

    cmp	w5,	#42
    beq	main_196

main_189:
    ldr	w7,	[sp, #2084]

    cmp	w7,	#37
    ldr	w16,	[sp, #2084]

    movz	w21,	#0
    movz	w28,	#20
    csel	w5,	w28,	w21,	eq
    cmp	w16,	#47
    movz	w24,	#20
    csel	w11,	w24,	w5,	eq
    b	main_197

main_196:
    movz	w11,	#20
    b	main_197

main_195:
    movz	w11,	#10
    b	main_197

main_194:
    movz	w11,	#10

main_197:
    cmp	w15,	w11
    blt	main_233

main_200:
    sub	w6,	w4,	#1
    movz	fp,	#2076
    str	w6,	[x27]

    ldr	x6,	[sp, fp]

    movz	fp,	#2076
    ldr	w7,	[x6]

    ldr	x16,	[sp, #2064]

    lsl	w9,	w7,	#2
    add	x6,	x16,	x9
    sub	w9,	w7,	#1
    ldr	w17,	[x6]

    ldr	x3,	[sp, fp]

    movz	fp,	#2076
    str	w9,	[x3]

    ldr	x24,	[sp, #2064]

    lsl	w3,	w9,	#2
    add	x2,	x24,	x3
    sub	w24,	w9,	#1
    ldr	w28,	[x2]

    ldr	x6,	[sp, fp]

    str	w24,	[x6]

    cmp	w1,	#43
    bne	main_212

main_210:
    add	w12,	w28,	w17
    b	main_229

main_212:
    cmp	w1,	#45
    bne	main_216

main_214:
    sub	w12,	w28,	w17
    b	main_229

main_216:
    cmp	w1,	#42
    bne	main_220

main_218:
    mul	w12,	w28,	w17
    b	main_229

main_220:
    cmp	w1,	#47
    bne	main_224

main_222:
    sdiv	w12,	w28,	w17
    b	main_229

main_224:
    cmp	w1,	#37
    bne	main_228

main_226:
    sdiv	w11,	w28,	w17
    msub	w12,	w11,	w17,	w28

    b	main_229

main_228:
    movz	w12,	#0

main_229:
    movz	fp,	#2076
    ldr	x5,	[sp, fp]

    str	w9,	[x5]

    str	w12,	[x2]

    b	main_159

main_233:
    add	w13,	w4,	#1
    lsl	w15,	w13,	#2
    str	w13,	[x27]

    ldr	w8,	[sp, #2084]

    add	x14,	x27,	x15
    str	w8,	[x14]

    cmp	w19,	#0
    bne	main_237

main_238:
    movz	fp,	#2076
    mov	w21,	w20
    ldr	x17,	[sp, fp]

    movz	fp,	#2076
    ldr	w3,	[x17]

    add	w4,	w3,	#1
    ldr	x24,	[sp, fp]

    lsl	w6,	w4,	#2
    str	w4,	[x24]

    ldr	x10,	[sp, #2064]

    add	x5,	x10,	x6
    str	w25,	[x5]


main_242:
    cmp	w21,	#10
    cset	w8,	eq
    cmp	w21,	#32
    movz	w2,	#1
    csel	w10,	w2,	w8,	eq
    cmp	w10,	#0
    beq	main_251

main_249:
    bl	getch
    mov	w21,	w0
    b	main_242

main_251:
    cmp	w21,	#57
    cset	w14,	le
    cmp	w21,	#48
    movz	w3,	#0
    csel	w16,	w14,	w3,	ge
    cmp	w16,	#0
    beq	main_271

main_257:
    sub	w9,	w21,	#48
    mov	w28,	w9

main_259:
    bl	getch
    cmp	w0,	#57
    cset	w24,	le
    cmp	w0,	#48
    movz	w7,	#0
    csel	w5,	w24,	w7,	ge
    cmp	w5,	#0
    beq	main_273

main_267:
    lsl	w11,	w28,	#1
    add	w16,	w11,	w28,	lsl #3
    add	w17,	w16,	w0
    sub	w18,	w17,	#48
    mov	w28,	w18
    b	main_259

main_273:
    movz	w18,	#0
    mov	w23,	w26
    mov	w2,	w28
    mov	w19,	w0
    b	main_274

main_271:
    bl	getch
    mov	w2,	w25
    mov	w23,	w21
    movz	w18,	#1
    mov	w19,	w0

main_274:
    mov	w20,	w18
    str	w23,	[sp, #2084]

    mov	w28,	w2
    b	main_98

main_237:
    movz	w0,	#112
    bl	putch
    movz	w0,	#97
    bl	putch
    movz	w0,	#110
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#99
    bl	putch
    movz	w0,	#33
    bl	putch
    movz	w0,	#10
    bl	putch
    mov	w23,	w26
    mov	w24,	w19
    ldr	w4,	[sp, #2072]

    mov	w19,	w20
    b	main_363

main_281:
    cmp	w19,	#10
    cset	w7,	eq
    cmp	w19,	#32
    movz	w15,	#1
    csel	w9,	w15,	w7,	eq
    cmp	w9,	#0
    beq	main_290

main_288:
    bl	getch
    mov	w19,	w0
    b	main_281

main_290:
    cmp	w19,	#57
    cset	w13,	le
    cmp	w19,	#48
    movz	w16,	#0
    csel	w15,	w13,	w16,	ge
    cmp	w15,	#0
    beq	main_310

main_296:
    sub	w6,	w19,	#48
    mov	w24,	w6

main_298:
    bl	getch
    cmp	w0,	#57
    cset	w21,	le
    cmp	w0,	#48
    movz	w18,	#0
    csel	w1,	w21,	w18,	ge
    cmp	w1,	#0
    beq	main_312

main_306:
    lsl	w12,	w24,	#1
    add	w13,	w12,	w24,	lsl #3
    add	w14,	w13,	w0
    sub	w15,	w14,	#48
    mov	w24,	w15
    b	main_298

main_312:
    movz	w14,	#0
    ldr	w28,	[sp, #2084]

    mov	w8,	w24
    mov	w19,	w28
    b	main_313

main_310:
    bl	getch
    mov	w8,	w28
    movz	w14,	#1

main_313:
    ldr	w2,	[x27]

    cmp	w2,	#0
    beq	main_359

main_322:
    lsl	w4,	w2,	#2
    movz	fp,	#2076
    sub	w2,	w2,	#1
    add	x9,	x27,	x4
    ldr	w9,	[x9]

    str	w2,	[x27]

    ldr	x20,	[sp, fp]

    movz	fp,	#2076
    ldr	w15,	[x20]

    sub	w21,	w15,	#1
    ldr	x1,	[sp, #2064]

    lsl	w7,	w15,	#2
    lsl	w25,	w21,	#2
    add	x6,	x1,	x7
    ldr	w17,	[x6]

    ldr	x15,	[sp, fp]

    movz	fp,	#2076
    str	w21,	[x15]

    ldr	x13,	[sp, #2064]

    add	x6,	x13,	x25
    sub	w25,	w21,	#1
    ldr	w15,	[x6]

    ldr	x13,	[sp, fp]

    str	w25,	[x13]

    cmp	w9,	#43
    bne	main_337

main_335:
    add	w16,	w15,	w17
    b	main_354

main_337:
    cmp	w9,	#45
    bne	main_341

main_339:
    sub	w16,	w15,	w17
    b	main_354

main_341:
    cmp	w9,	#42
    bne	main_345

main_343:
    mul	w16,	w15,	w17
    b	main_354

main_345:
    cmp	w9,	#47
    bne	main_349

main_347:
    sdiv	w16,	w15,	w17
    b	main_354

main_349:
    cmp	w9,	#37
    bne	main_353

main_351:
    sdiv	w20,	w15,	w17
    msub	w16,	w20,	w17,	w15

    b	main_354

main_353:
    movz	w16,	#0

main_354:
    movz	fp,	#2076
    ldr	x23,	[sp, fp]

    str	w21,	[x23]

    str	w16,	[x6]

    cmp	w2,	#0
    bne	main_322

main_359:
    movz	fp,	#2076
    mov	w24,	w14
    mov	w23,	w19
    mov	w25,	w8
    ldr	x5,	[sp, fp]

    mov	w19,	w0
    ldr	w10,	[x5]

    ldr	x16,	[sp, #2064]

    lsl	w12,	w10,	#2
    add	x11,	x16,	x12
    ldr	w4,	[x11]

    b	main_363

main_59:
    movz	w0,	#112
    bl	putch
    movz	w0,	#97
    bl	putch
    movz	w0,	#110
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#99
    bl	putch
    movz	w0,	#33
    bl	putch
    movz	w0,	#10
    bl	putch
    mov	w19,	w21
    mov	w25,	w26
    mov	w24,	w20
    ldr	w4,	[sp, #2072]


main_363:
    mov	w0,	w4
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w26,	[sp, #2104]

    sub	w28,	w26,	#1
    cmp	w28,	#0
    beq	main_373

main_51:
    str	w28,	[sp, #2104]

    mov	w20,	w24
    mov	w26,	w25
    mov	w21,	w19
    b	main_52

main_373:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2160
    ret


