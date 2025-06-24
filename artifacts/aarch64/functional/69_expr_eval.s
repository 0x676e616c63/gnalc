.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2128
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w20,	w0
    bl	getch
    movz	w21,	#32

main_5:
    cmp	w21,	#10
    cset	w12,	eq
    cmp	w21,	#32
    movz	w3,	#1
    csel	w14,	w3,	w12,	eq
    cmp	w14,	#0
    beq	main_14

main_12:
    bl	getch
    mov	w21,	w0
    b	main_5

main_14:
    cmp	w21,	#57
    cset	w18,	le
    cmp	w21,	#48
    movz	w4,	#0
    csel	w23,	w18,	w4,	ge
    cmp	w23,	#0
    beq	main_34

main_20:
    sub	w26,	w21,	#48

main_22:
    bl	getch
    cmp	w0,	#57
    cset	w1,	le
    cmp	w0,	#48
    movz	w6,	#0
    csel	w3,	w1,	w6,	ge
    cmp	w3,	#0
    beq	main_36

main_30:
    lsl	w2,	w26,	#1
    add	w15,	w2,	w26,	lsl #3
    add	w16,	w15,	w0
    sub	w26,	w16,	#48
    b	main_22

main_36:
    movz	w5,	#0
    movz	w22,	#0
    mov	w8,	w26
    mov	w27,	w22
    b	main_37

main_34:
    bl	getch
    movz	w8,	#0
    mov	w27,	w21
    movz	w5,	#1

main_37:
    cmp	w20,	#0
    beq	main_373

main_43:
    add	x4,	sp,	#1040
    add	x16,	sp,	#16
    add	x14,	sp,	#1040
    movz	fp,	#2076
    add	x24,	sp,	#16
    mov	w22,	w20
    mov	w26,	w0
    str	x4,	[sp, #2096]

    mov	w20,	w27
    str	x16,	[sp, #2120]

    str	x14,	[sp, fp]

    movz	fp,	#2076
    ldr	x25,	[sp, fp]

    movz	fp,	#2076
    str	x25,	[sp, #2064]

    mov	w25,	w5
    ldr	x16,	[sp, fp]

    add	x3,	x16,	#4
    str	x3,	[sp, #2088]

    str	x24,	[sp, #2112]

    ldr	x9,	[sp, #2112]

    str	x9,	[sp, #2104]

    str	w22,	[sp, #2084]

    mov	w22,	w8

main_52:
    ldr	x0,	[sp, #2096]

    movz	w1,	#0
    movz	w2,	#1024
    bl	memset
    movz	w2,	#1024
    movz	w1,	#0
    ldr	x0,	[sp, #2120]

    bl	memset
    movz	w2,	#65535
    movk	w2,	#65535,	lsl #16
    mov	w19,	w2
    cmp	w25,	#0
    bne	main_59

main_60:
    movz	w5,	#1
    ldr	x8,	[sp, #2064]

    mov	w21,	w26
    str	w5,	[x8]

    ldr	x4,	[sp, #2088]

    str	w22,	[x4]


main_61:
    cmp	w21,	#10
    cset	w7,	eq
    cmp	w21,	#32
    movz	w2,	#1
    csel	w9,	w2,	w7,	eq
    cmp	w9,	#0
    beq	main_70

main_68:
    bl	getch
    mov	w21,	w0
    b	main_61

main_70:
    cmp	w21,	#57
    cset	w13,	le
    cmp	w21,	#48
    movz	w3,	#0
    csel	w15,	w13,	w3,	ge
    cmp	w15,	#0
    beq	main_90

main_76:
    sub	w22,	w21,	#48
    mov	w28,	w22

main_78:
    bl	getch
    cmp	w0,	#57
    cset	w6,	le
    cmp	w0,	#48
    movz	w10,	#0
    csel	w8,	w6,	w10,	ge
    cmp	w8,	#0
    beq	main_92

main_86:
    lsl	w17,	w28,	#1
    add	w4,	w17,	w28,	lsl #3
    add	w2,	w4,	w0
    sub	w22,	w2,	#48
    mov	w28,	w22
    b	main_78

main_92:
    movz	w4,	#0
    mov	w25,	w20
    mov	w14,	w28
    mov	w20,	w0
    b	main_93

main_90:
    bl	getch
    mov	w25,	w21
    movz	w4,	#1
    mov	w14,	w22
    mov	w20,	w0

main_93:
    str	w25,	[sp, #2072]

    mov	w22,	w14

main_98:
    cmp	w4,	#1
    bne	main_279

main_104:
    ldr	w17,	[sp, #2072]

    cmp	w17,	#43
    beq	main_115

main_106:
    ldr	w18,	[sp, #2072]

    cmp	w18,	#45
    beq	main_116

main_108:
    ldr	w21,	[sp, #2072]

    cmp	w21,	#42
    beq	main_117

main_110:
    ldr	w23,	[sp, #2072]

    cmp	w23,	#37
    ldr	w24,	[sp, #2072]

    movz	w14,	#0
    movz	w7,	#20
    csel	w16,	w7,	w14,	eq
    cmp	w24,	#47
    movz	w6,	#20
    csel	w4,	w6,	w16,	eq
    b	main_118

main_117:
    movz	w4,	#20
    b	main_118

main_116:
    movz	w4,	#10
    b	main_118

main_115:
    movz	w4,	#10

main_118:
    cmp	w4,	#0
    bne	main_121

main_280:
    mov	w19,	w20
    b	main_281

main_121:
    mov	w26,	w20

main_122:
    cmp	w26,	#10
    cset	w4,	eq
    cmp	w26,	#32
    movz	w15,	#1
    csel	w6,	w15,	w4,	eq
    cmp	w6,	#0
    beq	main_131

main_129:
    bl	getch
    mov	w26,	w0
    b	main_122

main_131:
    cmp	w26,	#57
    cset	w10,	le
    cmp	w26,	#48
    movz	w16,	#0
    csel	w12,	w10,	w16,	ge
    cmp	w12,	#0
    beq	main_151

main_137:
    sub	w22,	w26,	#48

main_139:
    bl	getch
    cmp	w0,	#57
    cset	w7,	le
    cmp	w0,	#48
    movz	w13,	#0
    csel	w9,	w7,	w13,	ge
    cmp	w9,	#0
    beq	main_153

main_147:
    lsl	w20,	w22,	#1
    add	w13,	w20,	w22,	lsl #3
    add	w14,	w13,	w0
    sub	w22,	w14,	#48
    b	main_139

main_153:
    movz	w7,	#0
    ldr	w25,	[sp, #2072]

    mov	w27,	w22
    mov	w2,	w0
    b	main_154

main_151:
    bl	getch
    mov	w27,	w22
    mov	w25,	w26
    movz	w7,	#1
    mov	w2,	w0

main_154:
    mov	w22,	w7
    mov	w26,	w25
    mov	w28,	w27
    mov	w27,	w2

main_159:
    ldr	x17,	[sp, #2104]

    ldr	w1,	[x17]

    cmp	w1,	#0
    beq	main_233

main_166:
    lsl	w8,	w1,	#2
    ldr	x6,	[sp, #2112]

    add	x7,	x6,	x8
    ldr	w14,	[x7]

    cmp	w14,	#43
    beq	main_179

main_170:
    cmp	w14,	#45
    beq	main_180

main_172:
    cmp	w14,	#42
    beq	main_181

main_174:
    cmp	w14,	#37
    movz	w25,	#0
    movz	w7,	#20
    csel	w12,	w7,	w25,	eq
    cmp	w14,	#47
    movz	w6,	#20
    csel	w3,	w6,	w12,	eq
    b	main_182

main_181:
    movz	w3,	#20
    b	main_182

main_180:
    movz	w3,	#10
    b	main_182

main_179:
    movz	w3,	#10

main_182:
    ldr	w23,	[sp, #2072]

    cmp	w23,	#43
    beq	main_194

main_185:
    ldr	w24,	[sp, #2072]

    cmp	w24,	#45
    beq	main_195

main_187:
    ldr	w25,	[sp, #2072]

    cmp	w25,	#42
    beq	main_196

main_189:
    ldr	w2,	[sp, #2072]

    cmp	w2,	#37
    ldr	w4,	[sp, #2072]

    movz	w5,	#0
    movz	w18,	#20
    csel	w7,	w18,	w5,	eq
    cmp	w4,	#47
    movz	w17,	#20
    csel	w8,	w17,	w7,	eq
    b	main_197

main_196:
    movz	w8,	#20
    b	main_197

main_195:
    movz	w8,	#10
    b	main_197

main_194:
    movz	w8,	#10

main_197:
    cmp	w3,	w8
    blt	main_233

main_200:
    sub	w7,	w1,	#1
    ldr	x13,	[sp, #2104]

    movz	fp,	#2076
    str	w7,	[x13]

    ldr	x8,	[sp, #2064]

    ldr	w8,	[x8]

    sub	w16,	w8,	#1
    ldr	x24,	[sp, fp]

    lsl	w10,	w8,	#2
    movz	fp,	#2076
    sub	w25,	w16,	#1
    lsl	w17,	w16,	#2
    add	x9,	x24,	x10
    ldr	w18,	[x9]

    ldr	x11,	[sp, #2064]

    str	w16,	[x11]

    ldr	x2,	[sp, fp]

    add	x5,	x2,	x17
    ldr	w20,	[x5]

    ldr	x2,	[sp, #2064]

    str	w25,	[x2]

    cmp	w14,	#43
    bne	main_212

main_210:
    add	w9,	w20,	w18
    b	main_229

main_212:
    cmp	w14,	#45
    bne	main_216

main_214:
    sub	w9,	w20,	w18
    b	main_229

main_216:
    cmp	w14,	#42
    bne	main_220

main_218:
    mul	w9,	w20,	w18
    b	main_229

main_220:
    cmp	w14,	#47
    bne	main_224

main_222:
    sdiv	w9,	w20,	w18
    b	main_229

main_224:
    cmp	w14,	#37
    bne	main_228

main_226:
    sdiv	w4,	w20,	w18
    msub	w9,	w4,	w18,	w20

    b	main_229

main_228:
    movz	w9,	#0

main_229:
    ldr	x8,	[sp, #2064]

    str	w16,	[x8]

    str	w9,	[x5]

    b	main_159

main_233:
    add	w13,	w1,	#1
    ldr	x25,	[sp, #2104]

    lsl	w15,	w13,	#2
    str	w13,	[x25]

    ldr	x14,	[sp, #2112]

    ldr	w9,	[sp, #2072]

    add	x15,	x14,	x15
    str	w9,	[x15]

    cmp	w22,	#0
    bne	main_237

main_238:
    ldr	x4,	[sp, #2064]

    movz	fp,	#2076
    ldr	w8,	[x4]

    ldr	x5,	[sp, #2064]

    add	w10,	w8,	#1
    lsl	w11,	w10,	#2
    str	w10,	[x5]

    ldr	x17,	[sp, fp]

    add	x10,	x17,	x11
    str	w28,	[x10]


main_242:
    cmp	w27,	#10
    cset	w13,	eq
    cmp	w27,	#32
    movz	w8,	#1
    csel	w15,	w8,	w13,	eq
    cmp	w15,	#0
    beq	main_251

main_249:
    bl	getch
    mov	w27,	w0
    b	main_242

main_251:
    cmp	w27,	#57
    cset	w20,	le
    cmp	w27,	#48
    movz	w9,	#0
    csel	w2,	w20,	w9,	ge
    cmp	w2,	#0
    beq	main_271

main_257:
    sub	w21,	w27,	#48

main_259:
    bl	getch
    cmp	w0,	#57
    cset	w7,	le
    cmp	w0,	#48
    movz	w15,	#0
    csel	w9,	w7,	w15,	ge
    cmp	w9,	#0
    beq	main_273

main_267:
    lsl	w20,	w21,	#1
    add	w18,	w20,	w21,	lsl #3
    add	w20,	w18,	w0
    sub	w21,	w20,	#48
    b	main_259

main_273:
    movz	w4,	#0
    mov	w10,	w26
    mov	w2,	w21
    mov	w20,	w0
    b	main_274

main_271:
    bl	getch
    mov	w2,	w28
    mov	w10,	w27
    movz	w4,	#1
    mov	w20,	w0

main_274:
    str	w10,	[sp, #2072]

    mov	w22,	w2
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
    mov	w21,	w22
    mov	w13,	w19
    mov	w19,	w26
    mov	w26,	w27
    b	main_363

main_279:
    mov	w19,	w20

main_281:
    cmp	w19,	#10
    cset	w2,	eq
    cmp	w19,	#32
    movz	w20,	#1
    csel	w4,	w20,	w2,	eq
    cmp	w4,	#0
    beq	main_290

main_288:
    bl	getch
    mov	w19,	w0
    b	main_281

main_290:
    cmp	w19,	#57
    cset	w8,	le
    cmp	w19,	#48
    movz	w25,	#0
    csel	w10,	w8,	w25,	ge
    cmp	w10,	#0
    beq	main_310

main_296:
    sub	w3,	w19,	#48
    mov	w22,	w3

main_298:
    bl	getch
    cmp	w0,	#57
    cset	w13,	le
    cmp	w0,	#48
    movz	w2,	#0
    csel	w15,	w13,	w2,	ge
    cmp	w15,	#0
    beq	main_312

main_306:
    lsl	w14,	w22,	#1
    add	w3,	w14,	w22,	lsl #3
    add	w2,	w3,	w0
    sub	w3,	w2,	#48
    mov	w22,	w3
    b	main_298

main_312:
    movz	w28,	#0
    ldr	w10,	[sp, #2072]

    mov	w20,	w22
    mov	w25,	w10
    b	main_313

main_310:
    bl	getch
    mov	w20,	w22
    mov	w25,	w19
    movz	w28,	#1

main_313:
    ldr	x14,	[sp, #2104]

    ldr	w10,	[x14]

    cmp	w10,	#0
    beq	main_359

main_322:
    lsl	w2,	w10,	#2
    ldr	x13,	[sp, #2112]

    movz	fp,	#2076
    sub	w10,	w10,	#1
    add	x6,	x13,	x2
    ldr	w11,	[x6]

    ldr	x24,	[sp, #2104]

    str	w10,	[x24]

    ldr	x6,	[sp, #2064]

    ldr	w3,	[x6]

    ldr	x19,	[sp, fp]

    sub	w2,	w3,	#1
    lsl	w7,	w3,	#2
    movz	fp,	#2076
    sub	w16,	w2,	#1
    lsl	w13,	w2,	#2
    add	x6,	x19,	x7
    ldr	w22,	[x6]

    ldr	x7,	[sp, #2064]

    str	w2,	[x7]

    ldr	x21,	[sp, fp]

    add	x4,	x21,	x13
    ldr	w7,	[x4]

    ldr	x8,	[sp, #2064]

    str	w16,	[x8]

    cmp	w11,	#43
    bne	main_337

main_335:
    add	w3,	w7,	w22
    b	main_354

main_337:
    cmp	w11,	#45
    bne	main_341

main_339:
    sub	w3,	w7,	w22
    b	main_354

main_341:
    cmp	w11,	#42
    bne	main_345

main_343:
    mul	w3,	w7,	w22
    b	main_354

main_345:
    cmp	w11,	#47
    bne	main_349

main_347:
    sdiv	w3,	w7,	w22
    b	main_354

main_349:
    cmp	w11,	#37
    bne	main_353

main_351:
    sdiv	w12,	w7,	w22
    msub	w3,	w12,	w22,	w7

    b	main_354

main_353:
    movz	w3,	#0

main_354:
    ldr	x19,	[sp, #2064]

    str	w2,	[x19]

    str	w3,	[x4]

    cmp	w10,	#0
    bne	main_322

main_359:
    ldr	x14,	[sp, #2064]

    movz	fp,	#2076
    mov	w21,	w28
    mov	w19,	w25
    mov	w26,	w0
    ldr	w3,	[x14]

    mov	w28,	w20
    ldr	x27,	[sp, fp]

    lsl	w5,	w3,	#2
    add	x4,	x27,	x5
    ldr	w13,	[x4]

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
    mov	w28,	w22
    mov	w21,	w25
    mov	w13,	w19
    mov	w19,	w20

main_363:
    mov	w0,	w13
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w22,	[sp, #2084]

    sub	w4,	w22,	#1
    cmp	w4,	#0
    beq	main_373

main_51:
    str	w4,	[sp, #2084]

    mov	w25,	w21
    mov	w20,	w19
    mov	w22,	w28
    b	main_52

main_373:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2128
    ret


