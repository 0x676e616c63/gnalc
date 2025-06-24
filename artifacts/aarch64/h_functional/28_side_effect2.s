.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#80
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w5,	#0
    add	x3,	sp,	#16
    add	x26,	sp,	#20
    add	x0,	sp,	#24
    add	x14,	sp,	#32
    add	x18,	sp,	#28
    add	x4,	sp,	#88
    add	x23,	sp,	#52
    movz	w1,	#0
    add	x16,	sp,	#84
    add	x6,	sp,	#76
    add	x21,	sp,	#36
    add	x7,	sp,	#48
    add	x22,	sp,	#72
    add	x15,	sp,	#44
    add	x11,	sp,	#68
    add	x12,	sp,	#80
    add	x2,	sp,	#64
    add	x9,	sp,	#40
    add	x24,	sp,	#60
    add	x20,	sp,	#56

main_22:
    add	w1,	w1,	#1
    movz	w8,	#0
    cmp	w8,	w5
    bge	main_28

main_27:
    movz	w10,	#1
    movz	w17,	#1
    str	w10,	[x3]

    b	main_29

main_28:
    movz	w17,	#0

main_29:
    cmp	w17,	#0
    beq	main_214

main_32:
    add	w1,	w1,	#1
    movz	w13,	#1
    cmp	w13,	w5
    bge	main_37

main_35:
    movz	w17,	#1
    str	w17,	[x26]

    ldr	w19,	[x3]

    b	main_38

main_37:
    movz	w19,	#0

main_38:
    cmp	w19,	#0
    beq	main_214

main_41:
    add	w1,	w1,	#1
    movz	w19,	#2
    cmp	w19,	w5
    bge	main_46

main_44:
    movz	w25,	#1
    str	w25,	[x0]

    ldr	w25,	[x26]

    b	main_47

main_46:
    movz	w25,	#0

main_47:
    cmp	w25,	#0
    beq	main_214

main_50:
    add	w1,	w1,	#1
    movz	w27,	#3
    cmp	w27,	w5
    bge	main_55

main_53:
    movz	w28,	#1
    str	w28,	[x18]

    ldr	w27,	[x0]

    b	main_56

main_55:
    movz	w27,	#0

main_56:
    cmp	w27,	#0
    beq	main_214

main_59:
    add	w1,	w1,	#1
    movz	w8,	#4
    cmp	w8,	w5
    bge	main_64

main_62:
    movz	w10,	#1
    str	w10,	[x14]

    ldr	w28,	[x18]

    b	main_65

main_64:
    movz	w28,	#0

main_65:
    cmp	w28,	#0
    beq	main_214

main_68:
    add	w1,	w1,	#1
    movz	w13,	#5
    cmp	w13,	w5
    bge	main_73

main_71:
    movz	w17,	#1
    str	w17,	[x21]

    ldr	w8,	[x14]

    b	main_74

main_73:
    movz	w8,	#0

main_74:
    cmp	w8,	#0
    beq	main_214

main_77:
    add	w1,	w1,	#1
    movz	w19,	#6
    cmp	w19,	w5
    bge	main_82

main_80:
    movz	w25,	#1
    str	w25,	[x9]

    ldr	w10,	[x21]

    b	main_83

main_82:
    movz	w10,	#0

main_83:
    cmp	w10,	#0
    beq	main_214

main_86:
    add	w1,	w1,	#1
    movz	w27,	#7
    cmp	w27,	w5
    bge	main_91

main_89:
    movz	w28,	#1
    str	w28,	[x15]

    ldr	w13,	[x9]

    b	main_92

main_91:
    movz	w13,	#0

main_92:
    cmp	w13,	#0
    beq	main_214

main_95:
    add	w1,	w1,	#1
    movz	w8,	#8
    cmp	w8,	w5
    bge	main_100

main_98:
    movz	w10,	#1
    str	w10,	[x7]

    ldr	w17,	[x15]

    b	main_101

main_100:
    movz	w17,	#0

main_101:
    cmp	w17,	#0
    beq	main_214

main_104:
    add	w1,	w1,	#1
    movz	w13,	#9
    cmp	w13,	w5
    bge	main_109

main_107:
    movz	w17,	#1
    str	w17,	[x23]

    ldr	w19,	[x7]

    b	main_110

main_109:
    movz	w19,	#0

main_110:
    cmp	w19,	#0
    beq	main_214

main_113:
    add	w1,	w1,	#1
    movz	w19,	#10
    cmp	w19,	w5
    bge	main_118

main_116:
    movz	w25,	#1
    str	w25,	[x20]

    ldr	w25,	[x23]

    b	main_119

main_118:
    movz	w25,	#0

main_119:
    cmp	w25,	#0
    beq	main_214

main_122:
    add	w1,	w1,	#1
    movz	w27,	#11
    cmp	w27,	w5
    bge	main_127

main_125:
    movz	w28,	#1
    str	w28,	[x24]

    ldr	w27,	[x20]

    b	main_128

main_127:
    movz	w27,	#0

main_128:
    cmp	w27,	#0
    beq	main_214

main_131:
    add	w1,	w1,	#1
    movz	w8,	#12
    cmp	w8,	w5
    bge	main_136

main_134:
    movz	w10,	#1
    str	w10,	[x2]

    ldr	w28,	[x24]

    b	main_137

main_136:
    movz	w28,	#0

main_137:
    cmp	w28,	#0
    beq	main_214

main_140:
    add	w1,	w1,	#1
    movz	w13,	#13
    cmp	w13,	w5
    bge	main_145

main_143:
    movz	w17,	#1
    str	w17,	[x11]

    ldr	w8,	[x2]

    b	main_146

main_145:
    movz	w8,	#0

main_146:
    cmp	w8,	#0
    beq	main_214

main_149:
    add	w1,	w1,	#1
    movz	w19,	#14
    cmp	w19,	w5
    bge	main_154

main_152:
    movz	w25,	#1
    str	w25,	[x22]

    ldr	w10,	[x11]

    b	main_155

main_154:
    movz	w10,	#0

main_155:
    cmp	w10,	#0
    beq	main_214

main_158:
    add	w1,	w1,	#1
    movz	w27,	#15
    cmp	w27,	w5
    bge	main_163

main_161:
    movz	w28,	#1
    str	w28,	[x6]

    ldr	w13,	[x22]

    b	main_164

main_163:
    movz	w13,	#0

main_164:
    cmp	w13,	#0
    beq	main_214

main_167:
    add	w1,	w1,	#1
    movz	w8,	#16
    cmp	w8,	w5
    bge	main_172

main_170:
    movz	w10,	#1
    str	w10,	[x12]

    ldr	w17,	[x6]

    b	main_173

main_172:
    movz	w17,	#0

main_173:
    cmp	w17,	#0
    beq	main_214

main_176:
    add	w1,	w1,	#1
    movz	w13,	#17
    cmp	w13,	w5
    bge	main_181

main_179:
    movz	w17,	#1
    str	w17,	[x16]

    ldr	w19,	[x12]

    b	main_182

main_181:
    movz	w19,	#0

main_182:
    cmp	w19,	#0
    beq	main_214

main_185:
    add	w28,	w1,	#1
    movz	w13,	#18
    cmp	w13,	w5
    bge	main_190

main_188:
    movz	w17,	#1
    str	w17,	[x4]

    ldr	w10,	[x16]

    b	main_191

main_190:
    movz	w10,	#0

main_191:
    add	w25,	w28,	#1
    cmp	w10,	#0
    csel	w1,	w25,	w28,	ne

main_214:
    add	w5,	w5,	#1
    cmp	w5,	#20
    blt	main_22

main_218:
    movz	w17,	#0

main_220:
    add	w1,	w1,	#2
    movz	w27,	#0
    cmp	w27,	w17
    bge	main_226

main_225:
    movz	w28,	#0
    movz	w8,	#0
    str	w28,	[x3]

    b	main_227

main_226:
    movz	w8,	#1

main_227:
    cmp	w8,	#0
    bne	main_412

main_230:
    add	w1,	w1,	#2
    movz	w5,	#1
    cmp	w5,	w17
    bge	main_235

main_233:
    movz	w8,	#0
    str	w8,	[x26]

    ldr	w10,	[x3]

    b	main_236

main_235:
    movz	w10,	#1

main_236:
    cmp	w10,	#0
    bne	main_412

main_239:
    add	w1,	w1,	#2
    movz	w10,	#2
    cmp	w10,	w17
    bge	main_244

main_242:
    movz	w13,	#0
    str	w13,	[x0]

    ldr	w13,	[x26]

    b	main_245

main_244:
    movz	w13,	#1

main_245:
    cmp	w13,	#0
    bne	main_412

main_248:
    add	w1,	w1,	#2
    movz	w19,	#3
    cmp	w19,	w17
    bge	main_253

main_251:
    movz	w25,	#0
    str	w25,	[x18]

    ldr	w19,	[x0]

    b	main_254

main_253:
    movz	w19,	#1

main_254:
    cmp	w19,	#0
    bne	main_412

main_257:
    add	w1,	w1,	#2
    movz	w27,	#4
    cmp	w27,	w17
    bge	main_262

main_260:
    movz	w28,	#0
    str	w28,	[x14]

    ldr	w25,	[x18]

    b	main_263

main_262:
    movz	w25,	#1

main_263:
    cmp	w25,	#0
    bne	main_412

main_266:
    add	w1,	w1,	#2
    movz	w5,	#5
    cmp	w5,	w17
    bge	main_271

main_269:
    movz	w8,	#0
    str	w8,	[x21]

    ldr	w27,	[x14]

    b	main_272

main_271:
    movz	w27,	#1

main_272:
    cmp	w27,	#0
    bne	main_412

main_275:
    add	w1,	w1,	#2
    movz	w10,	#6
    cmp	w10,	w17
    bge	main_280

main_278:
    movz	w13,	#0
    str	w13,	[x9]

    ldr	w28,	[x21]

    b	main_281

main_280:
    movz	w28,	#1

main_281:
    cmp	w28,	#0
    bne	main_412

main_284:
    add	w1,	w1,	#2
    movz	w19,	#7
    cmp	w19,	w17
    bge	main_289

main_287:
    movz	w25,	#0
    str	w25,	[x15]

    ldr	w5,	[x9]

    b	main_290

main_289:
    movz	w5,	#1

main_290:
    cmp	w5,	#0
    bne	main_412

main_293:
    add	w1,	w1,	#2
    movz	w27,	#8
    cmp	w27,	w17
    bge	main_298

main_296:
    movz	w28,	#0
    str	w28,	[x7]

    ldr	w8,	[x15]

    b	main_299

main_298:
    movz	w8,	#1

main_299:
    cmp	w8,	#0
    bne	main_412

main_302:
    add	w1,	w1,	#2
    movz	w5,	#9
    cmp	w5,	w17
    bge	main_307

main_305:
    movz	w8,	#0
    str	w8,	[x23]

    ldr	w10,	[x7]

    b	main_308

main_307:
    movz	w10,	#1

main_308:
    cmp	w10,	#0
    bne	main_412

main_311:
    add	w1,	w1,	#2
    movz	w10,	#10
    cmp	w10,	w17
    bge	main_316

main_314:
    movz	w13,	#0
    str	w13,	[x20]

    ldr	w13,	[x23]

    b	main_317

main_316:
    movz	w13,	#1

main_317:
    cmp	w13,	#0
    bne	main_412

main_320:
    add	w1,	w1,	#2
    movz	w19,	#11
    cmp	w19,	w17
    bge	main_325

main_323:
    movz	w25,	#0
    str	w25,	[x24]

    ldr	w19,	[x20]

    b	main_326

main_325:
    movz	w19,	#1

main_326:
    cmp	w19,	#0
    bne	main_412

main_329:
    add	w1,	w1,	#2
    movz	w27,	#12
    cmp	w27,	w17
    bge	main_334

main_332:
    movz	w28,	#0
    str	w28,	[x2]

    ldr	w25,	[x24]

    b	main_335

main_334:
    movz	w25,	#1

main_335:
    cmp	w25,	#0
    bne	main_412

main_338:
    add	w1,	w1,	#2
    movz	w5,	#13
    cmp	w5,	w17
    bge	main_343

main_341:
    movz	w8,	#0
    str	w8,	[x11]

    ldr	w27,	[x2]

    b	main_344

main_343:
    movz	w27,	#1

main_344:
    cmp	w27,	#0
    bne	main_412

main_347:
    add	w1,	w1,	#2
    movz	w10,	#14
    cmp	w10,	w17
    bge	main_352

main_350:
    movz	w13,	#0
    str	w13,	[x22]

    ldr	w28,	[x11]

    b	main_353

main_352:
    movz	w28,	#1

main_353:
    cmp	w28,	#0
    bne	main_412

main_356:
    add	w1,	w1,	#2
    movz	w19,	#15
    cmp	w19,	w17
    bge	main_361

main_359:
    movz	w25,	#0
    str	w25,	[x6]

    ldr	w5,	[x22]

    b	main_362

main_361:
    movz	w5,	#1

main_362:
    cmp	w5,	#0
    bne	main_412

main_365:
    add	w1,	w1,	#2
    movz	w27,	#16
    cmp	w27,	w17
    bge	main_370

main_368:
    movz	w28,	#0
    str	w28,	[x12]

    ldr	w8,	[x6]

    b	main_371

main_370:
    movz	w8,	#1

main_371:
    cmp	w8,	#0
    bne	main_412

main_374:
    add	w1,	w1,	#2
    movz	w5,	#17
    cmp	w5,	w17
    bge	main_379

main_377:
    movz	w8,	#0
    str	w8,	[x16]

    ldr	w10,	[x12]

    b	main_380

main_379:
    movz	w10,	#1

main_380:
    cmp	w10,	#0
    bne	main_412

main_383:
    add	w5,	w1,	#2
    movz	w19,	#18
    cmp	w19,	w17
    bge	main_388

main_386:
    movz	w25,	#0
    str	w25,	[x4]

    ldr	w25,	[x16]

    b	main_389

main_388:
    movz	w25,	#1

main_389:
    add	w13,	w5,	#2
    cmp	w25,	#0
    csel	w1,	w5,	w13,	ne

main_412:
    add	w17,	w17,	#1
    cmp	w17,	#20
    blt	main_220

main_416:
    movz	w12,	#1

main_418:
    cmp	w12,	#20
    bge	main_442

main_422:
    sub	w10,	w12,	#1
    add	w1,	w1,	#1
    cmp	w10,	w12
    bge	main_435

main_426:
    lsl	w25,	w10,	#2
    movz	w8,	#1
    mov	x17,	x25
    add	x17,	sp,	x17
    add	x17,	x17,	#16
    str	w8,	[x17]

    cmp	w10,	#0
    bne	main_431

main_429:
    ldr	w4,	[x3]

    b	main_436

main_431:
    sub	w4,	w10,	#1
    lsl	w8,	w4,	#2
    mov	x5,	x8
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w4,	[x5]

    b	main_436

main_435:
    movz	w4,	#0

main_436:
    add	w12,	w12,	#1
    cmp	w4,	#0
    bne	main_418

main_442:
    add	w27,	w1,	#3
    ldr	w28,	[x3]

    cmp	w28,	#0
    beq	main_453

main_447:
    add	w27,	w27,	#3
    ldr	w3,	[x26]

    cmp	w3,	#0
    bne	main_468

main_453:
    add	w27,	w27,	#3
    ldr	w8,	[x0]

    cmp	w8,	#0
    beq	main_468

main_458:
    add	w27,	w27,	#3
    ldr	w13,	[x18]


main_468:
    add	w1,	w27,	#3
    ldr	w19,	[x14]

    cmp	w19,	#0
    beq	main_499

main_473:
    add	w1,	w1,	#3
    ldr	w3,	[x21]

    cmp	w3,	#0
    beq	main_488

main_477:
    add	w1,	w1,	#3
    ldr	w8,	[x9]

    cmp	w8,	#0
    bne	main_488

main_481:
    add	w1,	w1,	#3
    ldr	w13,	[x15]

    cmp	w13,	#0
    bne	main_499

main_488:
    add	w1,	w1,	#3
    ldr	w17,	[x7]


main_499:
    add	w4,	w1,	#3
    ldr	w27,	[x23]

    cmp	w27,	#0
    beq	main_510

main_504:
    add	w4,	w4,	#3
    ldr	w13,	[x20]

    cmp	w13,	#0
    beq	main_540

main_510:
    add	w4,	w4,	#3
    ldr	w3,	[x24]

    cmp	w3,	#0
    beq	main_540

main_515:
    add	w4,	w4,	#3
    ldr	w26,	[x2]

    cmp	w26,	#0
    beq	main_540

main_519:
    add	w4,	w4,	#3
    ldr	w25,	[x11]

    cmp	w25,	#0
    beq	main_540

main_523:
    add	w4,	w4,	#3
    ldr	w5,	[x22]

    cmp	w5,	#0
    beq	main_540

main_527:
    add	w4,	w4,	#3
    ldr	w2,	[x6]


main_540:
    add	w2,	w4,	#3
    cmp	w28,	#0
    beq	main_559

main_544:
    add	w2,	w2,	#3
    ldr	w3,	[x0]

    cmp	w3,	#0
    beq	main_559

main_548:
    add	w2,	w2,	#3
    ldr	w11,	[x18]

    cmp	w11,	#0
    bne	main_559

main_552:
    add	w2,	w2,	#3
    cmp	w19,	#0
    beq	main_583

main_559:
    add	w2,	w2,	#3
    ldr	w23,	[x21]

    cmp	w23,	#0
    bne	main_583

main_564:
    add	w2,	w2,	#3
    ldr	w9,	[x9]

    cmp	w9,	#0
    beq	main_574

main_568:
    add	w2,	w2,	#3
    ldr	w15,	[x15]

    cmp	w15,	#0
    beq	main_583

main_574:
    add	w2,	w2,	#3
    ldr	w12,	[x7]

    cmp	w12,	#0
    bne	main_583

main_585:
    movz	w8,	#0
    b	main_586

main_583:
    movz	w8,	#1

main_586:
    add	w0,	w2,	w8
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


