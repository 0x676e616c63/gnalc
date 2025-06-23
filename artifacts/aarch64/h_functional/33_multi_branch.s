.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w8,	#0
    mov	w28,	w0
    cmp	w8,	w28
    bge	main_504

main_3:
    movz	w20,	#0

main_5:
    bl	getint
    cmp	w0,	#0
    ble	main_496

main_9:
    cmp	w0,	#100
    bge	main_497

main_11:
    cmp	w0,	#99
    bge	main_493

main_13:
    cmp	w0,	#98
    bge	main_490

main_15:
    cmp	w0,	#97
    bge	main_487

main_17:
    cmp	w0,	#96
    bge	main_484

main_19:
    cmp	w0,	#95
    bge	main_481

main_21:
    cmp	w0,	#94
    bge	main_478

main_23:
    cmp	w0,	#93
    bge	main_475

main_25:
    cmp	w0,	#92
    bge	main_472

main_27:
    cmp	w0,	#91
    bge	main_469

main_29:
    cmp	w0,	#90
    bge	main_466

main_31:
    cmp	w0,	#89
    bge	main_463

main_33:
    cmp	w0,	#88
    bge	main_460

main_35:
    cmp	w0,	#87
    bge	main_457

main_37:
    cmp	w0,	#86
    bge	main_454

main_39:
    cmp	w0,	#85
    bge	main_451

main_41:
    cmp	w0,	#84
    bge	main_448

main_43:
    cmp	w0,	#83
    bge	main_445

main_45:
    cmp	w0,	#82
    bge	main_442

main_47:
    cmp	w0,	#81
    bge	main_439

main_49:
    cmp	w0,	#80
    bge	main_436

main_51:
    cmp	w0,	#79
    bge	main_433

main_53:
    cmp	w0,	#78
    bge	main_430

main_55:
    cmp	w0,	#77
    bge	main_427

main_57:
    cmp	w0,	#76
    bge	main_424

main_59:
    cmp	w0,	#75
    bge	main_421

main_61:
    cmp	w0,	#74
    bge	main_418

main_63:
    cmp	w0,	#73
    bge	main_415

main_65:
    cmp	w0,	#72
    bge	main_412

main_67:
    cmp	w0,	#71
    bge	main_409

main_69:
    cmp	w0,	#70
    bge	main_406

main_71:
    cmp	w0,	#69
    bge	main_403

main_73:
    cmp	w0,	#68
    bge	main_400

main_75:
    cmp	w0,	#67
    bge	main_397

main_77:
    cmp	w0,	#66
    bge	main_394

main_79:
    cmp	w0,	#65
    bge	main_391

main_81:
    cmp	w0,	#64
    bge	main_388

main_83:
    cmp	w0,	#63
    bge	main_385

main_85:
    cmp	w0,	#62
    bge	main_382

main_87:
    cmp	w0,	#61
    bge	main_379

main_89:
    cmp	w0,	#60
    bge	main_376

main_91:
    cmp	w0,	#59
    bge	main_373

main_93:
    cmp	w0,	#58
    bge	main_370

main_95:
    cmp	w0,	#57
    bge	main_367

main_97:
    cmp	w0,	#56
    bge	main_364

main_99:
    cmp	w0,	#55
    bge	main_361

main_101:
    cmp	w0,	#54
    bge	main_358

main_103:
    cmp	w0,	#53
    bge	main_355

main_105:
    cmp	w0,	#52
    bge	main_352

main_107:
    cmp	w0,	#51
    bge	main_349

main_109:
    cmp	w0,	#50
    bge	main_346

main_111:
    cmp	w0,	#49
    bge	main_343

main_113:
    cmp	w0,	#48
    bge	main_340

main_115:
    cmp	w0,	#47
    bge	main_337

main_117:
    cmp	w0,	#46
    bge	main_334

main_119:
    cmp	w0,	#45
    bge	main_331

main_121:
    cmp	w0,	#44
    bge	main_328

main_123:
    cmp	w0,	#43
    bge	main_325

main_125:
    cmp	w0,	#42
    bge	main_322

main_127:
    cmp	w0,	#41
    bge	main_319

main_129:
    cmp	w0,	#40
    bge	main_316

main_131:
    cmp	w0,	#39
    bge	main_313

main_133:
    cmp	w0,	#38
    bge	main_310

main_135:
    cmp	w0,	#37
    bge	main_307

main_137:
    cmp	w0,	#36
    bge	main_304

main_139:
    cmp	w0,	#35
    bge	main_301

main_141:
    cmp	w0,	#34
    bge	main_298

main_143:
    cmp	w0,	#33
    bge	main_295

main_145:
    cmp	w0,	#32
    bge	main_292

main_147:
    cmp	w0,	#31
    bge	main_289

main_149:
    cmp	w0,	#30
    bge	main_286

main_151:
    cmp	w0,	#29
    bge	main_283

main_153:
    cmp	w0,	#28
    bge	main_280

main_155:
    cmp	w0,	#27
    bge	main_277

main_157:
    cmp	w0,	#26
    bge	main_274

main_159:
    cmp	w0,	#25
    bge	main_271

main_161:
    cmp	w0,	#24
    bge	main_268

main_163:
    cmp	w0,	#23
    bge	main_265

main_165:
    cmp	w0,	#22
    bge	main_262

main_167:
    cmp	w0,	#21
    bge	main_259

main_169:
    cmp	w0,	#20
    bge	main_256

main_171:
    cmp	w0,	#19
    bge	main_253

main_173:
    cmp	w0,	#18
    bge	main_250

main_175:
    cmp	w0,	#17
    bge	main_247

main_177:
    cmp	w0,	#16
    bge	main_244

main_179:
    cmp	w0,	#15
    bge	main_241

main_181:
    cmp	w0,	#14
    bge	main_238

main_183:
    cmp	w0,	#13
    bge	main_235

main_185:
    cmp	w0,	#12
    bge	main_232

main_187:
    cmp	w0,	#11
    bge	main_229

main_189:
    cmp	w0,	#10
    bge	main_226

main_191:
    cmp	w0,	#9
    bge	main_223

main_193:
    cmp	w0,	#8
    bge	main_220

main_195:
    cmp	w0,	#7
    bge	main_217

main_197:
    cmp	w0,	#6
    bge	main_214

main_199:
    cmp	w0,	#5
    bge	main_211

main_201:
    cmp	w0,	#4
    bge	main_208

main_203:
    cmp	w0,	#2
    movz	w16,	#2
    movz	w3,	#1
    csel	w7,	w3,	w16,	lt
    cmp	w0,	#3
    movz	w8,	#3
    csel	w0,	w7,	w8,	lt
    b	main_498

main_208:
    movz	w0,	#4
    b	main_498

main_211:
    movz	w0,	#5
    b	main_498

main_214:
    movz	w0,	#6
    b	main_498

main_217:
    movz	w0,	#7
    b	main_498

main_220:
    movz	w0,	#8
    b	main_498

main_223:
    movz	w0,	#9
    b	main_498

main_226:
    movz	w0,	#10
    b	main_498

main_229:
    movz	w0,	#11
    b	main_498

main_232:
    movz	w0,	#12
    b	main_498

main_235:
    movz	w0,	#13
    b	main_498

main_238:
    movz	w0,	#14
    b	main_498

main_241:
    movz	w0,	#15
    b	main_498

main_244:
    movz	w0,	#16
    b	main_498

main_247:
    movz	w0,	#17
    b	main_498

main_250:
    movz	w0,	#18
    b	main_498

main_253:
    movz	w0,	#19
    b	main_498

main_256:
    movz	w0,	#20
    b	main_498

main_259:
    movz	w0,	#21
    b	main_498

main_262:
    movz	w0,	#22
    b	main_498

main_265:
    movz	w0,	#23
    b	main_498

main_268:
    movz	w0,	#24
    b	main_498

main_271:
    movz	w0,	#25
    b	main_498

main_274:
    movz	w0,	#26
    b	main_498

main_277:
    movz	w0,	#27
    b	main_498

main_280:
    movz	w0,	#28
    b	main_498

main_283:
    movz	w0,	#29
    b	main_498

main_286:
    movz	w0,	#30
    b	main_498

main_289:
    movz	w0,	#31
    b	main_498

main_292:
    movz	w0,	#32
    b	main_498

main_295:
    movz	w0,	#33
    b	main_498

main_298:
    movz	w0,	#34
    b	main_498

main_301:
    movz	w0,	#35
    b	main_498

main_304:
    movz	w0,	#36
    b	main_498

main_307:
    movz	w0,	#37
    b	main_498

main_310:
    movz	w0,	#38
    b	main_498

main_313:
    movz	w0,	#39
    b	main_498

main_316:
    movz	w0,	#40
    b	main_498

main_319:
    movz	w0,	#41
    b	main_498

main_322:
    movz	w0,	#42
    b	main_498

main_325:
    movz	w0,	#43
    b	main_498

main_328:
    movz	w0,	#44
    b	main_498

main_331:
    movz	w0,	#45
    b	main_498

main_334:
    movz	w0,	#46
    b	main_498

main_337:
    movz	w0,	#47
    b	main_498

main_340:
    movz	w0,	#48
    b	main_498

main_343:
    movz	w0,	#49
    b	main_498

main_346:
    movz	w0,	#50
    b	main_498

main_349:
    movz	w0,	#51
    b	main_498

main_352:
    movz	w0,	#52
    b	main_498

main_355:
    movz	w0,	#53
    b	main_498

main_358:
    movz	w0,	#54
    b	main_498

main_361:
    movz	w0,	#55
    b	main_498

main_364:
    movz	w0,	#56
    b	main_498

main_367:
    movz	w0,	#57
    b	main_498

main_370:
    movz	w0,	#58
    b	main_498

main_373:
    movz	w0,	#59
    b	main_498

main_376:
    movz	w0,	#60
    b	main_498

main_379:
    movz	w0,	#61
    b	main_498

main_382:
    movz	w0,	#62
    b	main_498

main_385:
    movz	w0,	#63
    b	main_498

main_388:
    movz	w0,	#64
    b	main_498

main_391:
    movz	w0,	#65
    b	main_498

main_394:
    movz	w0,	#66
    b	main_498

main_397:
    movz	w0,	#67
    b	main_498

main_400:
    movz	w0,	#68
    b	main_498

main_403:
    movz	w0,	#69
    b	main_498

main_406:
    movz	w0,	#70
    b	main_498

main_409:
    movz	w0,	#71
    b	main_498

main_412:
    movz	w0,	#72
    b	main_498

main_415:
    movz	w0,	#73
    b	main_498

main_418:
    movz	w0,	#74
    b	main_498

main_421:
    movz	w0,	#75
    b	main_498

main_424:
    movz	w0,	#76
    b	main_498

main_427:
    movz	w0,	#77
    b	main_498

main_430:
    movz	w0,	#78
    b	main_498

main_433:
    movz	w0,	#79
    b	main_498

main_436:
    movz	w0,	#80
    b	main_498

main_439:
    movz	w0,	#81
    b	main_498

main_442:
    movz	w0,	#82
    b	main_498

main_445:
    movz	w0,	#83
    b	main_498

main_448:
    movz	w0,	#84
    b	main_498

main_451:
    movz	w0,	#85
    b	main_498

main_454:
    movz	w0,	#86
    b	main_498

main_457:
    movz	w0,	#87
    b	main_498

main_460:
    movz	w0,	#88
    b	main_498

main_463:
    movz	w0,	#89
    b	main_498

main_466:
    movz	w0,	#90
    b	main_498

main_469:
    movz	w0,	#91
    b	main_498

main_472:
    movz	w0,	#92
    b	main_498

main_475:
    movz	w0,	#93
    b	main_498

main_478:
    movz	w0,	#94
    b	main_498

main_481:
    movz	w0,	#95
    b	main_498

main_484:
    movz	w0,	#96
    b	main_498

main_487:
    movz	w0,	#97
    b	main_498

main_490:
    movz	w0,	#98
    b	main_498

main_493:
    movz	w0,	#99
    b	main_498

main_497:
    movz	w0,	#100
    b	main_498

main_496:
    movz	w0,	#100

main_498:
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w20,	#1
    cmp	w20,	w28
    blt	main_5

main_504:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


