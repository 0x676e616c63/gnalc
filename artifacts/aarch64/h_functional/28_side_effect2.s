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
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#80
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w6,	#0
    add	x13,	sp,	#84
    add	x10,	sp,	#80
    add	x12,	sp,	#76
    add	x26,	sp,	#72
    add	x17,	sp,	#68
    add	x9,	sp,	#88
    add	x3,	sp,	#16
    add	x1,	sp,	#56
    add	x5,	sp,	#20
    add	x28,	sp,	#60
    add	x21,	sp,	#24
    add	x4,	sp,	#64
    add	x8,	sp,	#28
    add	x15,	sp,	#32
    add	x16,	sp,	#36
    add	x7,	sp,	#40
    add	x14,	sp,	#44
    add	x2,	sp,	#48
    movz	w27,	#0
    add	x0,	sp,	#52

main_22:
    add	w27,	w27,	#1
    movz	w11,	#0
    cmp	w11,	w6
    blt	main_27

main_28:
    movz	w20,	#0
    b	main_29

main_27:
    movz	w18,	#1
    movz	w20,	#1
    str	w18,	[x3]


main_29:
    cmp	w20,	#0
    beq	main_214

main_32:
    add	w27,	w27,	#1
    movz	w19,	#1
    cmp	w19,	w6
    blt	main_35

main_37:
    movz	w22,	#0
    b	main_38

main_35:
    movz	w20,	#1
    str	w20,	[x5]

    ldr	w22,	[x3]


main_38:
    cmp	w22,	#0
    beq	main_214

main_41:
    add	w27,	w27,	#1
    movz	w22,	#2
    cmp	w22,	w6
    blt	main_44

main_46:
    movz	w23,	#0
    b	main_47

main_44:
    movz	w23,	#1
    str	w23,	[x21]

    ldr	w23,	[x5]


main_47:
    cmp	w23,	#0
    beq	main_214

main_50:
    add	w27,	w27,	#1
    movz	w24,	#3
    cmp	w24,	w6
    blt	main_53

main_55:
    movz	w24,	#0
    b	main_56

main_53:
    movz	w25,	#1
    str	w25,	[x8]

    ldr	w24,	[x21]


main_56:
    cmp	w24,	#0
    beq	main_214

main_59:
    add	w27,	w27,	#1
    movz	w11,	#4
    cmp	w11,	w6
    blt	main_62

main_64:
    movz	w25,	#0
    b	main_65

main_62:
    movz	w18,	#1
    str	w18,	[x15]

    ldr	w25,	[x8]


main_65:
    cmp	w25,	#0
    beq	main_214

main_68:
    add	w27,	w27,	#1
    movz	w19,	#5
    cmp	w19,	w6
    blt	main_71

main_73:
    movz	w11,	#0
    b	main_74

main_71:
    movz	w20,	#1
    str	w20,	[x16]

    ldr	w11,	[x15]


main_74:
    cmp	w11,	#0
    beq	main_214

main_77:
    add	w27,	w27,	#1
    movz	w22,	#6
    cmp	w22,	w6
    blt	main_80

main_82:
    movz	w18,	#0
    b	main_83

main_80:
    movz	w23,	#1
    str	w23,	[x7]

    ldr	w18,	[x16]


main_83:
    cmp	w18,	#0
    beq	main_214

main_86:
    add	w27,	w27,	#1
    movz	w24,	#7
    cmp	w24,	w6
    blt	main_89

main_91:
    movz	w19,	#0
    b	main_92

main_89:
    movz	w25,	#1
    str	w25,	[x14]

    ldr	w19,	[x7]


main_92:
    cmp	w19,	#0
    beq	main_214

main_95:
    add	w27,	w27,	#1
    movz	w11,	#8
    cmp	w11,	w6
    blt	main_98

main_100:
    movz	w20,	#0
    b	main_101

main_98:
    movz	w18,	#1
    str	w18,	[x2]

    ldr	w20,	[x14]


main_101:
    cmp	w20,	#0
    beq	main_214

main_104:
    add	w27,	w27,	#1
    movz	w19,	#9
    cmp	w19,	w6
    blt	main_107

main_109:
    movz	w22,	#0
    b	main_110

main_107:
    movz	w20,	#1
    str	w20,	[x0]

    ldr	w22,	[x2]


main_110:
    cmp	w22,	#0
    beq	main_214

main_113:
    add	w27,	w27,	#1
    movz	w22,	#10
    cmp	w22,	w6
    blt	main_116

main_118:
    movz	w23,	#0
    b	main_119

main_116:
    movz	w23,	#1
    str	w23,	[x1]

    ldr	w23,	[x0]


main_119:
    cmp	w23,	#0
    beq	main_214

main_122:
    add	w27,	w27,	#1
    movz	w24,	#11
    cmp	w24,	w6
    blt	main_125

main_127:
    movz	w24,	#0
    b	main_128

main_125:
    movz	w25,	#1
    str	w25,	[x28]

    ldr	w24,	[x1]


main_128:
    cmp	w24,	#0
    beq	main_214

main_131:
    add	w27,	w27,	#1
    movz	w11,	#12
    cmp	w11,	w6
    blt	main_134

main_136:
    movz	w25,	#0
    b	main_137

main_134:
    movz	w18,	#1
    str	w18,	[x4]

    ldr	w25,	[x28]


main_137:
    cmp	w25,	#0
    beq	main_214

main_140:
    add	w27,	w27,	#1
    movz	w19,	#13
    cmp	w19,	w6
    blt	main_143

main_145:
    movz	w11,	#0
    b	main_146

main_143:
    movz	w20,	#1
    str	w20,	[x17]

    ldr	w11,	[x4]


main_146:
    cmp	w11,	#0
    beq	main_214

main_149:
    add	w27,	w27,	#1
    movz	w22,	#14
    cmp	w22,	w6
    blt	main_152

main_154:
    movz	w18,	#0
    b	main_155

main_152:
    movz	w23,	#1
    str	w23,	[x26]

    ldr	w18,	[x17]


main_155:
    cmp	w18,	#0
    beq	main_214

main_158:
    add	w27,	w27,	#1
    movz	w24,	#15
    cmp	w24,	w6
    blt	main_161

main_163:
    movz	w19,	#0
    b	main_164

main_161:
    movz	w25,	#1
    str	w25,	[x12]

    ldr	w19,	[x26]


main_164:
    cmp	w19,	#0
    beq	main_214

main_167:
    add	w27,	w27,	#1
    movz	w11,	#16
    cmp	w11,	w6
    blt	main_170

main_172:
    movz	w20,	#0
    b	main_173

main_170:
    movz	w18,	#1
    str	w18,	[x10]

    ldr	w20,	[x12]


main_173:
    cmp	w20,	#0
    beq	main_214

main_176:
    add	w27,	w27,	#1
    movz	w19,	#17
    cmp	w19,	w6
    blt	main_179

main_181:
    movz	w22,	#0
    b	main_182

main_179:
    movz	w20,	#1
    str	w20,	[x13]

    ldr	w22,	[x10]


main_182:
    cmp	w22,	#0
    beq	main_214

main_185:
    add	w27,	w27,	#1
    movz	w20,	#18
    cmp	w20,	w6
    blt	main_188

main_190:
    movz	w19,	#0
    b	main_191

main_188:
    movz	w22,	#1
    str	w22,	[x9]

    ldr	w19,	[x13]


main_191:
    add	w24,	w27,	#1
    cmp	w19,	#0
    csel	w27,	w24,	w27,	ne

main_214:
    add	w6,	w6,	#1
    cmp	w6,	#20
    blt	main_22

main_218:
    movz	w19,	#0

main_220:
    add	w27,	w27,	#2
    movz	w24,	#0
    cmp	w24,	w19
    blt	main_225

main_226:
    movz	w11,	#1
    b	main_227

main_225:
    movz	w25,	#0
    movz	w11,	#0
    str	w25,	[x3]


main_227:
    cmp	w11,	#0
    bne	main_412

main_230:
    add	w27,	w27,	#2
    movz	w6,	#1
    cmp	w6,	w19
    blt	main_233

main_235:
    movz	w18,	#1
    b	main_236

main_233:
    movz	w11,	#0
    str	w11,	[x5]

    ldr	w18,	[x3]


main_236:
    cmp	w18,	#0
    bne	main_412

main_239:
    add	w27,	w27,	#2
    movz	w18,	#2
    cmp	w18,	w19
    blt	main_242

main_244:
    movz	w20,	#1
    b	main_245

main_242:
    movz	w20,	#0
    str	w20,	[x21]

    ldr	w20,	[x5]


main_245:
    cmp	w20,	#0
    bne	main_412

main_248:
    add	w27,	w27,	#2
    movz	w22,	#3
    cmp	w22,	w19
    blt	main_251

main_253:
    movz	w22,	#1
    b	main_254

main_251:
    movz	w23,	#0
    str	w23,	[x8]

    ldr	w22,	[x21]


main_254:
    cmp	w22,	#0
    bne	main_412

main_257:
    add	w27,	w27,	#2
    movz	w24,	#4
    cmp	w24,	w19
    blt	main_260

main_262:
    movz	w23,	#1
    b	main_263

main_260:
    movz	w25,	#0
    str	w25,	[x15]

    ldr	w23,	[x8]


main_263:
    cmp	w23,	#0
    bne	main_412

main_266:
    add	w27,	w27,	#2
    movz	w6,	#5
    cmp	w6,	w19
    blt	main_269

main_271:
    movz	w24,	#1
    b	main_272

main_269:
    movz	w11,	#0
    str	w11,	[x16]

    ldr	w24,	[x15]


main_272:
    cmp	w24,	#0
    bne	main_412

main_275:
    add	w27,	w27,	#2
    movz	w18,	#6
    cmp	w18,	w19
    blt	main_278

main_280:
    movz	w25,	#1
    b	main_281

main_278:
    movz	w20,	#0
    str	w20,	[x7]

    ldr	w25,	[x16]


main_281:
    cmp	w25,	#0
    bne	main_412

main_284:
    add	w27,	w27,	#2
    movz	w22,	#7
    cmp	w22,	w19
    blt	main_287

main_289:
    movz	w6,	#1
    b	main_290

main_287:
    movz	w23,	#0
    str	w23,	[x14]

    ldr	w6,	[x7]


main_290:
    cmp	w6,	#0
    bne	main_412

main_293:
    add	w27,	w27,	#2
    movz	w24,	#8
    cmp	w24,	w19
    blt	main_296

main_298:
    movz	w11,	#1
    b	main_299

main_296:
    movz	w25,	#0
    str	w25,	[x2]

    ldr	w11,	[x14]


main_299:
    cmp	w11,	#0
    bne	main_412

main_302:
    add	w27,	w27,	#2
    movz	w6,	#9
    cmp	w6,	w19
    blt	main_305

main_307:
    movz	w18,	#1
    b	main_308

main_305:
    movz	w11,	#0
    str	w11,	[x0]

    ldr	w18,	[x2]


main_308:
    cmp	w18,	#0
    bne	main_412

main_311:
    add	w27,	w27,	#2
    movz	w18,	#10
    cmp	w18,	w19
    blt	main_314

main_316:
    movz	w20,	#1
    b	main_317

main_314:
    movz	w20,	#0
    str	w20,	[x1]

    ldr	w20,	[x0]


main_317:
    cmp	w20,	#0
    bne	main_412

main_320:
    add	w27,	w27,	#2
    movz	w22,	#11
    cmp	w22,	w19
    blt	main_323

main_325:
    movz	w22,	#1
    b	main_326

main_323:
    movz	w23,	#0
    str	w23,	[x28]

    ldr	w22,	[x1]


main_326:
    cmp	w22,	#0
    bne	main_412

main_329:
    add	w27,	w27,	#2
    movz	w24,	#12
    cmp	w24,	w19
    blt	main_332

main_334:
    movz	w23,	#1
    b	main_335

main_332:
    movz	w25,	#0
    str	w25,	[x4]

    ldr	w23,	[x28]


main_335:
    cmp	w23,	#0
    bne	main_412

main_338:
    add	w27,	w27,	#2
    movz	w6,	#13
    cmp	w6,	w19
    blt	main_341

main_343:
    movz	w24,	#1
    b	main_344

main_341:
    movz	w11,	#0
    str	w11,	[x17]

    ldr	w24,	[x4]


main_344:
    cmp	w24,	#0
    bne	main_412

main_347:
    add	w27,	w27,	#2
    movz	w18,	#14
    cmp	w18,	w19
    blt	main_350

main_352:
    movz	w25,	#1
    b	main_353

main_350:
    movz	w20,	#0
    str	w20,	[x26]

    ldr	w25,	[x17]


main_353:
    cmp	w25,	#0
    bne	main_412

main_356:
    add	w27,	w27,	#2
    movz	w22,	#15
    cmp	w22,	w19
    blt	main_359

main_361:
    movz	w6,	#1
    b	main_362

main_359:
    movz	w23,	#0
    str	w23,	[x12]

    ldr	w6,	[x26]


main_362:
    cmp	w6,	#0
    bne	main_412

main_365:
    add	w27,	w27,	#2
    movz	w24,	#16
    cmp	w24,	w19
    blt	main_368

main_370:
    movz	w11,	#1
    b	main_371

main_368:
    movz	w25,	#0
    str	w25,	[x10]

    ldr	w11,	[x12]


main_371:
    cmp	w11,	#0
    bne	main_412

main_374:
    add	w27,	w27,	#2
    movz	w6,	#17
    cmp	w6,	w19
    blt	main_377

main_379:
    movz	w18,	#1
    b	main_380

main_377:
    movz	w11,	#0
    str	w11,	[x13]

    ldr	w18,	[x10]


main_380:
    cmp	w18,	#0
    bne	main_412

main_383:
    add	w25,	w27,	#2
    movz	w23,	#18
    cmp	w23,	w19
    blt	main_386

main_388:
    movz	w24,	#1
    b	main_389

main_386:
    movz	w11,	#0
    str	w11,	[x9]

    ldr	w24,	[x13]


main_389:
    add	w22,	w25,	#2
    cmp	w24,	#0
    csel	w27,	w25,	w22,	ne

main_412:
    add	w19,	w19,	#1
    cmp	w19,	#20
    blt	main_220

main_416:
    movz	w13,	#1

main_418:
    cmp	w13,	#20
    bge	main_442

main_422:
    sub	w11,	w13,	#1
    add	w27,	w27,	#1
    cmp	w11,	w13
    blt	main_426

main_435:
    movz	w23,	#0
    b	main_436

main_426:
    lsl	w23,	w11,	#2
    movz	w9,	#1
    mov	x20,	x23
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    str	w9,	[x20]

    cmp	w11,	#0
    beq	main_429

main_431:
    sub	w25,	w11,	#1
    lsl	w9,	w25,	#2
    mov	x6,	x9
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w23,	[x6]

    b	main_436

main_429:
    ldr	w23,	[x3]


main_436:
    add	w13,	w13,	#1
    cmp	w23,	#0
    bne	main_418

main_442:
    add	w20,	w27,	#3
    ldr	w25,	[x3]

    cmp	w25,	#0
    beq	main_453

main_447:
    add	w20,	w20,	#3
    ldr	w5,	[x5]

    cmp	w5,	#0
    bne	main_468

main_453:
    add	w20,	w20,	#3
    ldr	w10,	[x21]

    cmp	w10,	#0
    beq	main_468

main_458:
    add	w20,	w20,	#3
    ldr	w18,	[x8]


main_468:
    add	w10,	w20,	#3
    ldr	w24,	[x15]

    cmp	w24,	#0
    beq	main_499

main_473:
    add	w10,	w10,	#3
    ldr	w3,	[x16]

    cmp	w3,	#0
    beq	main_488

main_477:
    add	w10,	w10,	#3
    ldr	w9,	[x7]

    cmp	w9,	#0
    bne	main_488

main_481:
    add	w10,	w10,	#3
    ldr	w15,	[x14]

    cmp	w15,	#0
    bne	main_499

main_488:
    add	w10,	w10,	#3
    ldr	w20,	[x2]


main_499:
    add	w3,	w10,	#3
    ldr	w27,	[x0]

    cmp	w27,	#0
    beq	main_510

main_504:
    add	w3,	w3,	#3
    ldr	w11,	[x1]

    cmp	w11,	#0
    beq	main_540

main_510:
    add	w3,	w3,	#3
    ldr	w1,	[x28]

    cmp	w1,	#0
    beq	main_540

main_515:
    add	w3,	w3,	#3
    ldr	w27,	[x4]

    cmp	w27,	#0
    beq	main_540

main_519:
    add	w3,	w3,	#3
    ldr	w23,	[x17]

    cmp	w23,	#0
    beq	main_540

main_523:
    add	w3,	w3,	#3
    ldr	w5,	[x26]

    cmp	w5,	#0
    beq	main_540

main_527:
    add	w3,	w3,	#3
    ldr	w1,	[x12]


main_540:
    add	w0,	w3,	#3
    cmp	w25,	#0
    beq	main_559

main_544:
    add	w0,	w0,	#3
    ldr	w4,	[x21]

    cmp	w4,	#0
    beq	main_559

main_548:
    add	w0,	w0,	#3
    ldr	w11,	[x8]

    cmp	w11,	#0
    bne	main_559

main_552:
    add	w0,	w0,	#3
    cmp	w24,	#0
    beq	main_583

main_559:
    add	w0,	w0,	#3
    ldr	w23,	[x16]

    cmp	w23,	#0
    bne	main_583

main_564:
    add	w0,	w0,	#3
    ldr	w9,	[x7]

    cmp	w9,	#0
    beq	main_574

main_568:
    add	w0,	w0,	#3
    ldr	w15,	[x14]

    cmp	w15,	#0
    beq	main_583

main_574:
    add	w0,	w0,	#3
    ldr	w12,	[x2]

    cmp	w12,	#0
    bne	main_583

main_585:
    movz	w8,	#0
    b	main_586

main_583:
    movz	w8,	#1

main_586:
    add	w0,	w0,	w8
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


