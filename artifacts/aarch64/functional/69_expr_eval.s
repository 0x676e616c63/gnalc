.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #2160
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w24,	w0
    bl	getch
    movz	w21,	#32

main_5:
    cmp	w21,	#10
    cset	w13,	eq
    cmp	w21,	#32
    movz	w4,	#1
    csel	w15,	w4,	w13,	eq
    cmp	w15,	#0
    bne	main_12

main_14:
    cmp	w21,	#57
    cset	w18,	le
    cmp	w21,	#48
    movz	w5,	#0
    csel	w20,	w18,	w5,	ge
    cmp	w20,	#0
    bne	main_20

main_34:
    bl	getch
    mov	w23,	w21
    movz	w10,	#0
    movz	w6,	#1
    mov	w27,	w10
    b	main_37

main_20:
    sub	w1,	w21,	#48
    mov	w22,	w1

main_22:
    bl	getch
    cmp	w0,	#57
    cset	w3,	le
    cmp	w0,	#48
    movz	w7,	#0
    csel	w4,	w3,	w7,	ge
    cmp	w4,	#0
    bne	main_30

main_36:
    movz	w6,	#0
    movz	w25,	#0
    mov	w27,	w22
    mov	w23,	w25

main_37:
    cmp	w24,	#0
    beq	main_373

main_43:
    add	x21,	sp,	#1040
    add	x16,	sp,	#16
    add	x2,	sp,	#1040
    add	x5,	sp,	#16
    movz	fp,	#2084
    mov	w17,	w24
    mov	w28,	w23
    mov	w26,	w0
    str	x16,	[sp, #2096]

    mov	w24,	w6
    mov	w23,	w27
    str	x2,	[sp, #2064]

    ldr	x9,	[sp, #2064]

    str	x9,	[sp, #2072]

    ldr	x4,	[sp, #2064]

    add	x18,	x4,	#4
    str	x18,	[sp, #2120]

    str	x5,	[sp, #2112]

    ldr	x19,	[sp, #2112]

    str	x19,	[sp, fp]

    str	w17,	[sp, #2128]


main_52:
    mov	x0,	x21
    movz	w1,	#0
    movz	w2,	#1024
    bl	memset
    movz	w2,	#1024
    movz	w1,	#0
    ldr	x0,	[sp, #2096]

    bl	memset
    movz	w3,	#65535
    movk	w3,	#65535,	lsl #16
    mov	w27,	w3
    cmp	w24,	#0
    beq	main_60

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
    mov	w22,	w26
    mov	w12,	w28
    mov	w4,	w24
    mov	w18,	w27
    str	w4,	[sp, #2092]

    str	w12,	[sp, #2148]

    b	main_363

main_60:
    movz	w12,	#1
    ldr	x10,	[sp, #2072]

    mov	w22,	w26
    str	w12,	[x10]

    ldr	x17,	[sp, #2120]

    str	w23,	[x17]


main_61:
    cmp	w22,	#10
    cset	w4,	eq
    cmp	w22,	#32
    movz	w12,	#1
    csel	w6,	w12,	w4,	eq
    cmp	w6,	#0
    bne	main_68

main_70:
    cmp	w22,	#57
    cset	w9,	le
    cmp	w22,	#48
    movz	w13,	#0
    csel	w11,	w9,	w13,	ge
    cmp	w11,	#0
    bne	main_76

main_90:
    bl	getch
    mov	w18,	w23
    mov	w6,	w22
    movz	w15,	#1
    mov	w14,	w0
    b	main_93

main_76:
    sub	w25,	w22,	#48
    mov	w23,	w25

main_78:
    bl	getch
    cmp	w0,	#57
    cset	w3,	le
    cmp	w0,	#48
    movz	w18,	#0
    csel	w5,	w3,	w18,	ge
    cmp	w5,	#0
    bne	main_86

main_92:
    movz	w15,	#0
    mov	w6,	w28
    mov	w18,	w23
    mov	w14,	w0

main_93:
    str	w6,	[sp, #2080]

    mov	w23,	w18

main_98:
    cmp	w15,	#1
    beq	main_104

main_279:
    mov	w27,	w14
    b	main_281

main_104:
    ldr	w16,	[sp, #2080]

    cmp	w16,	#43
    bne	main_106

main_115:
    movz	w5,	#10
    b	main_118

main_106:
    ldr	w17,	[sp, #2080]

    cmp	w17,	#45
    bne	main_108

main_116:
    movz	w5,	#10
    b	main_118

main_108:
    ldr	w18,	[sp, #2080]

    cmp	w18,	#42
    bne	main_110

main_117:
    movz	w5,	#20
    b	main_118

main_110:
    ldr	w19,	[sp, #2080]

    cmp	w19,	#37
    ldr	w20,	[sp, #2080]

    movz	w6,	#0
    movz	w13,	#20
    csel	w7,	w13,	w6,	eq
    cmp	w20,	#47
    movz	w12,	#20
    csel	w5,	w12,	w7,	eq

main_118:
    cmp	w5,	#0
    beq	main_280

main_121:
    mov	w26,	w14

main_122:
    cmp	w26,	#10
    cset	w17,	eq
    cmp	w26,	#32
    movz	w4,	#1
    csel	w24,	w4,	w17,	eq
    cmp	w24,	#0
    bne	main_129

main_131:
    cmp	w26,	#57
    cset	w7,	le
    cmp	w26,	#48
    movz	w4,	#0
    csel	w4,	w7,	w4,	ge
    cmp	w4,	#0
    bne	main_137

main_151:
    bl	getch
    mov	w8,	w23
    mov	w10,	w26
    movz	w11,	#1
    mov	w3,	w0
    b	main_154

main_137:
    sub	w26,	w26,	#48
    mov	w24,	w26

main_139:
    bl	getch
    cmp	w0,	#57
    cset	w2,	le
    cmp	w0,	#48
    movz	w18,	#0
    csel	w7,	w2,	w18,	ge
    cmp	w7,	#0
    bne	main_147

main_153:
    movz	w11,	#0
    ldr	w10,	[sp, #2080]

    mov	w8,	w24
    mov	w3,	w0

main_154:
    mov	w25,	w11
    mov	w24,	w10
    mov	w26,	w8
    mov	w28,	w3

main_159:
    movz	fp,	#2084
    ldr	x4,	[sp, fp]

    ldr	w3,	[x4]

    cmp	w3,	#0
    beq	main_233

main_166:
    lsl	w16,	w3,	#2
    ldr	x10,	[sp, #2112]

    add	x15,	x10,	x16
    ldr	w18,	[x15]

    cmp	w18,	#43
    bne	main_170

main_179:
    movz	w2,	#10
    b	main_182

main_170:
    cmp	w18,	#45
    bne	main_172

main_180:
    movz	w2,	#10
    b	main_182

main_172:
    cmp	w18,	#42
    bne	main_174

main_181:
    movz	w2,	#20
    b	main_182

main_174:
    cmp	w18,	#37
    movz	w6,	#0
    movz	w7,	#20
    csel	w23,	w7,	w6,	eq
    cmp	w18,	#47
    movz	w12,	#20
    csel	w2,	w12,	w23,	eq

main_182:
    ldr	w6,	[sp, #2080]

    cmp	w6,	#43
    bne	main_185

main_194:
    movz	w9,	#10
    b	main_197

main_185:
    ldr	w7,	[sp, #2080]

    cmp	w7,	#45
    bne	main_187

main_195:
    movz	w9,	#10
    b	main_197

main_187:
    ldr	w8,	[sp, #2080]

    cmp	w8,	#42
    bne	main_189

main_196:
    movz	w9,	#20
    b	main_197

main_189:
    ldr	w9,	[sp, #2080]

    cmp	w9,	#37
    ldr	w10,	[sp, #2080]

    movz	w13,	#0
    movz	w5,	#20
    csel	w13,	w5,	w13,	eq
    cmp	w10,	#47
    movz	w4,	#20
    csel	w9,	w4,	w13,	eq

main_197:
    cmp	w2,	w9
    bge	main_200

main_233:
    add	w18,	w3,	#1
    movz	fp,	#2084
    ldr	x13,	[sp, fp]

    lsl	w7,	w18,	#2
    str	w18,	[x13]

    ldr	x4,	[sp, #2112]

    ldr	w13,	[sp, #2080]

    add	x8,	x4,	x7
    str	w13,	[x8]

    cmp	w25,	#0
    beq	main_238

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
    mov	w22,	w28
    mov	w23,	w26
    mov	w13,	w24
    mov	w0,	w25
    mov	w18,	w27
    str	w0,	[sp, #2092]

    str	w13,	[sp, #2148]

    b	main_363

main_238:
    ldr	x9,	[sp, #2072]

    ldr	w15,	[x9]

    ldr	x10,	[sp, #2072]

    add	w18,	w15,	#1
    lsl	w22,	w18,	#2
    str	w18,	[x10]

    ldr	x5,	[sp, #2064]

    add	x17,	x5,	x22
    str	w26,	[x17]


main_242:
    cmp	w28,	#10
    cset	w25,	eq
    cmp	w28,	#32
    movz	w16,	#1
    csel	w3,	w16,	w25,	eq
    cmp	w3,	#0
    bne	main_249

main_251:
    cmp	w28,	#57
    cset	w6,	le
    cmp	w28,	#48
    movz	w23,	#0
    csel	w8,	w6,	w23,	ge
    cmp	w8,	#0
    bne	main_257

main_277:
    bl	getch
    mov	w8,	w26
    mov	w18,	w28
    movz	w15,	#1
    mov	w14,	w0
    b	main_272

main_257:
    sub	w6,	w28,	#48
    mov	w28,	w6

main_259:
    bl	getch
    cmp	w0,	#57
    cset	w16,	le
    cmp	w0,	#48
    movz	w6,	#0
    csel	w18,	w16,	w6,	ge
    cmp	w18,	#0
    bne	main_267

main_271:
    movz	w15,	#0
    mov	w18,	w24
    mov	w8,	w28
    mov	w14,	w0

main_272:
    str	w18,	[sp, #2080]

    mov	w23,	w8
    b	main_98

main_267:
    lsl	w17,	w28,	#1
    add	w8,	w17,	w28,	lsl #3
    add	w9,	w8,	w0
    sub	w6,	w9,	#48
    mov	w28,	w6
    b	main_259

main_249:
    bl	getch
    mov	w28,	w0
    b	main_242

main_200:
    sub	w9,	w3,	#1
    movz	fp,	#2084
    ldr	x6,	[sp, fp]

    str	w9,	[x6]

    ldr	x13,	[sp, #2072]

    ldr	w6,	[x13]

    ldr	x3,	[sp, #2064]

    lsl	w14,	w6,	#2
    sub	w6,	w6,	#1
    add	x11,	x3,	x14
    lsl	w1,	w6,	#2
    sub	w2,	w6,	#1
    ldr	w5,	[x11]

    ldr	x4,	[sp, #2072]

    str	w6,	[x4]

    ldr	x17,	[sp, #2064]

    add	x11,	x17,	x1
    ldr	w14,	[x11]

    ldr	x12,	[sp, #2072]

    str	w2,	[x12]

    cmp	w18,	#43
    beq	main_210

main_212:
    cmp	w18,	#45
    beq	main_214

main_216:
    cmp	w18,	#42
    beq	main_218

main_220:
    cmp	w18,	#47
    beq	main_222

main_224:
    cmp	w18,	#37
    beq	main_226

main_228:
    movz	w16,	#0
    b	main_229

main_226:
    sdiv	w4,	w14,	w5
    msub	w16,	w4,	w5,	w14

    b	main_229

main_222:
    sdiv	w16,	w14,	w5
    b	main_229

main_218:
    mul	w16,	w14,	w5
    b	main_229

main_214:
    sub	w16,	w14,	w5
    b	main_229

main_210:
    add	w16,	w14,	w5

main_229:
    ldr	x2,	[sp, #2072]

    str	w6,	[x2]

    str	w16,	[x11]

    b	main_159

main_147:
    lsl	w23,	w24,	#1
    add	w10,	w23,	w24,	lsl #3
    add	w11,	w10,	w0
    sub	w26,	w11,	#48
    mov	w24,	w26
    b	main_139

main_129:
    bl	getch
    mov	w26,	w0
    b	main_122

main_280:
    mov	w27,	w14

main_281:
    cmp	w27,	#10
    cset	w16,	eq
    cmp	w27,	#32
    movz	w3,	#1
    csel	w18,	w3,	w16,	eq
    cmp	w18,	#0
    bne	main_288

main_290:
    cmp	w27,	#57
    cset	w28,	le
    cmp	w27,	#48
    movz	w4,	#0
    csel	w8,	w28,	w4,	ge
    cmp	w8,	#0
    bne	main_296

main_310:
    bl	getch
    mov	w10,	w23
    mov	w25,	w27
    movz	w15,	#1
    b	main_313

main_296:
    sub	w6,	w27,	#48
    mov	w23,	w6

main_298:
    bl	getch
    cmp	w0,	#57
    cset	w6,	le
    cmp	w0,	#48
    movz	w9,	#0
    csel	w8,	w6,	w9,	ge
    cmp	w8,	#0
    bne	main_306

main_312:
    movz	w15,	#0
    ldr	w11,	[sp, #2080]

    mov	w10,	w23
    mov	w25,	w11

main_313:
    movz	fp,	#2084
    ldr	x16,	[sp, fp]

    ldr	w17,	[x16]

    cmp	w17,	#0
    beq	main_359

main_322:
    lsl	w16,	w17,	#2
    ldr	x22,	[sp, #2112]

    movz	fp,	#2084
    sub	w17,	w17,	#1
    add	x13,	x22,	x16
    ldr	w1,	[x13]

    ldr	x4,	[sp, fp]

    str	w17,	[x4]

    ldr	x22,	[sp, #2072]

    ldr	w26,	[x22]

    sub	w22,	w26,	#1
    ldr	x3,	[sp, #2064]

    lsl	w5,	w26,	#2
    sub	w12,	w22,	#1
    lsl	w2,	w22,	#2
    add	x27,	x3,	x5
    ldr	w9,	[x27]

    ldr	x23,	[sp, #2072]

    str	w22,	[x23]

    ldr	x4,	[sp, #2064]

    add	x7,	x4,	x2
    ldr	w6,	[x7]

    ldr	x24,	[sp, #2072]

    str	w12,	[x24]

    cmp	w1,	#43
    beq	main_335

main_337:
    cmp	w1,	#45
    beq	main_339

main_341:
    cmp	w1,	#42
    beq	main_343

main_345:
    cmp	w1,	#47
    beq	main_347

main_349:
    cmp	w1,	#37
    beq	main_351

main_353:
    movz	w4,	#0
    b	main_354

main_351:
    sdiv	w28,	w6,	w9
    msub	w4,	w28,	w9,	w6

    b	main_354

main_347:
    sdiv	w4,	w6,	w9
    b	main_354

main_343:
    mul	w4,	w6,	w9
    b	main_354

main_339:
    sub	w4,	w6,	w9
    b	main_354

main_335:
    add	w4,	w6,	w9

main_354:
    ldr	x5,	[sp, #2072]

    str	w22,	[x5]

    str	w4,	[x7]

    cmp	w17,	#0
    bne	main_322

main_359:
    ldr	x13,	[sp, #2072]

    mov	w16,	w25
    mov	w23,	w10
    ldr	w18,	[x13]

    ldr	x1,	[sp, #2064]

    lsl	w24,	w18,	#2
    add	x22,	x1,	x24
    ldr	w18,	[x22]

    mov	w22,	w0
    str	w15,	[sp, #2092]

    str	w16,	[sp, #2148]


main_363:
    mov	w0,	w18
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w17,	[sp, #2128]

    sub	w1,	w17,	#1
    cmp	w1,	#0
    bne	main_51

main_373:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2160
    ret


main_51:
    str	w1,	[sp, #2128]

    mov	w26,	w22
    ldr	w4,	[sp, #2092]

    ldr	w15,	[sp, #2148]

    mov	w24,	w4
    mov	w28,	w15
    b	main_52

main_306:
    lsl	w13,	w23,	#1
    add	w3,	w13,	w23,	lsl #3
    add	w4,	w3,	w0
    sub	w6,	w4,	#48
    mov	w23,	w6
    b	main_298

main_288:
    bl	getch
    mov	w27,	w0
    b	main_281

main_86:
    lsl	w25,	w23,	#1
    add	w6,	w25,	w23,	lsl #3
    add	w7,	w6,	w0
    sub	w25,	w7,	#48
    mov	w23,	w25
    b	main_78

main_68:
    bl	getch
    mov	w22,	w0
    b	main_61

main_30:
    lsl	w5,	w22,	#1
    add	w13,	w5,	w22,	lsl #3
    add	w14,	w13,	w0
    sub	w1,	w14,	#48
    mov	w22,	w1
    b	main_22

main_12:
    bl	getch
    mov	w21,	w0
    b	main_5

