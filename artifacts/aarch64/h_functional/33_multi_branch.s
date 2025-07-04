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
    bgt	main_9

main_496:
    movz	w0,	#100
    b	main_498

main_9:
    cmp	w0,	#100
    blt	main_11

main_497:
    movz	w0,	#100
    b	main_498

main_11:
    cmp	w0,	#99
    blt	main_13

main_493:
    movz	w0,	#99
    b	main_498

main_13:
    cmp	w0,	#98
    blt	main_15

main_490:
    movz	w0,	#98
    b	main_498

main_15:
    cmp	w0,	#97
    blt	main_17

main_487:
    movz	w0,	#97
    b	main_498

main_17:
    cmp	w0,	#96
    blt	main_19

main_484:
    movz	w0,	#96
    b	main_498

main_19:
    cmp	w0,	#95
    blt	main_21

main_481:
    movz	w0,	#95
    b	main_498

main_21:
    cmp	w0,	#94
    blt	main_23

main_478:
    movz	w0,	#94
    b	main_498

main_23:
    cmp	w0,	#93
    blt	main_25

main_475:
    movz	w0,	#93
    b	main_498

main_25:
    cmp	w0,	#92
    blt	main_27

main_472:
    movz	w0,	#92
    b	main_498

main_27:
    cmp	w0,	#91
    blt	main_29

main_469:
    movz	w0,	#91
    b	main_498

main_29:
    cmp	w0,	#90
    blt	main_31

main_466:
    movz	w0,	#90
    b	main_498

main_31:
    cmp	w0,	#89
    blt	main_33

main_463:
    movz	w0,	#89
    b	main_498

main_33:
    cmp	w0,	#88
    blt	main_35

main_460:
    movz	w0,	#88
    b	main_498

main_35:
    cmp	w0,	#87
    blt	main_37

main_457:
    movz	w0,	#87
    b	main_498

main_37:
    cmp	w0,	#86
    blt	main_39

main_454:
    movz	w0,	#86
    b	main_498

main_39:
    cmp	w0,	#85
    blt	main_41

main_451:
    movz	w0,	#85
    b	main_498

main_41:
    cmp	w0,	#84
    blt	main_43

main_448:
    movz	w0,	#84
    b	main_498

main_43:
    cmp	w0,	#83
    blt	main_45

main_445:
    movz	w0,	#83
    b	main_498

main_45:
    cmp	w0,	#82
    blt	main_47

main_442:
    movz	w0,	#82
    b	main_498

main_47:
    cmp	w0,	#81
    blt	main_49

main_439:
    movz	w0,	#81
    b	main_498

main_49:
    cmp	w0,	#80
    blt	main_51

main_436:
    movz	w0,	#80
    b	main_498

main_51:
    cmp	w0,	#79
    blt	main_53

main_433:
    movz	w0,	#79
    b	main_498

main_53:
    cmp	w0,	#78
    blt	main_55

main_430:
    movz	w0,	#78
    b	main_498

main_55:
    cmp	w0,	#77
    blt	main_57

main_427:
    movz	w0,	#77
    b	main_498

main_57:
    cmp	w0,	#76
    blt	main_59

main_424:
    movz	w0,	#76
    b	main_498

main_59:
    cmp	w0,	#75
    blt	main_61

main_421:
    movz	w0,	#75
    b	main_498

main_61:
    cmp	w0,	#74
    blt	main_63

main_418:
    movz	w0,	#74
    b	main_498

main_63:
    cmp	w0,	#73
    blt	main_65

main_415:
    movz	w0,	#73
    b	main_498

main_65:
    cmp	w0,	#72
    blt	main_67

main_412:
    movz	w0,	#72
    b	main_498

main_67:
    cmp	w0,	#71
    blt	main_69

main_409:
    movz	w0,	#71
    b	main_498

main_69:
    cmp	w0,	#70
    blt	main_71

main_406:
    movz	w0,	#70
    b	main_498

main_71:
    cmp	w0,	#69
    blt	main_73

main_403:
    movz	w0,	#69
    b	main_498

main_73:
    cmp	w0,	#68
    blt	main_75

main_400:
    movz	w0,	#68
    b	main_498

main_75:
    cmp	w0,	#67
    blt	main_77

main_397:
    movz	w0,	#67
    b	main_498

main_77:
    cmp	w0,	#66
    blt	main_79

main_394:
    movz	w0,	#66
    b	main_498

main_79:
    cmp	w0,	#65
    blt	main_81

main_391:
    movz	w0,	#65
    b	main_498

main_81:
    cmp	w0,	#64
    blt	main_83

main_388:
    movz	w0,	#64
    b	main_498

main_83:
    cmp	w0,	#63
    blt	main_85

main_385:
    movz	w0,	#63
    b	main_498

main_85:
    cmp	w0,	#62
    blt	main_87

main_382:
    movz	w0,	#62
    b	main_498

main_87:
    cmp	w0,	#61
    blt	main_89

main_379:
    movz	w0,	#61
    b	main_498

main_89:
    cmp	w0,	#60
    blt	main_91

main_376:
    movz	w0,	#60
    b	main_498

main_91:
    cmp	w0,	#59
    blt	main_93

main_373:
    movz	w0,	#59
    b	main_498

main_93:
    cmp	w0,	#58
    blt	main_95

main_370:
    movz	w0,	#58
    b	main_498

main_95:
    cmp	w0,	#57
    blt	main_97

main_367:
    movz	w0,	#57
    b	main_498

main_97:
    cmp	w0,	#56
    blt	main_99

main_364:
    movz	w0,	#56
    b	main_498

main_99:
    cmp	w0,	#55
    blt	main_101

main_361:
    movz	w0,	#55
    b	main_498

main_101:
    cmp	w0,	#54
    blt	main_103

main_358:
    movz	w0,	#54
    b	main_498

main_103:
    cmp	w0,	#53
    blt	main_105

main_355:
    movz	w0,	#53
    b	main_498

main_105:
    cmp	w0,	#52
    blt	main_107

main_352:
    movz	w0,	#52
    b	main_498

main_107:
    cmp	w0,	#51
    blt	main_109

main_349:
    movz	w0,	#51
    b	main_498

main_109:
    cmp	w0,	#50
    blt	main_111

main_346:
    movz	w0,	#50
    b	main_498

main_111:
    cmp	w0,	#49
    blt	main_113

main_343:
    movz	w0,	#49
    b	main_498

main_113:
    cmp	w0,	#48
    blt	main_115

main_340:
    movz	w0,	#48
    b	main_498

main_115:
    cmp	w0,	#47
    blt	main_117

main_337:
    movz	w0,	#47
    b	main_498

main_117:
    cmp	w0,	#46
    blt	main_119

main_334:
    movz	w0,	#46
    b	main_498

main_119:
    cmp	w0,	#45
    blt	main_121

main_331:
    movz	w0,	#45
    b	main_498

main_121:
    cmp	w0,	#44
    blt	main_123

main_328:
    movz	w0,	#44
    b	main_498

main_123:
    cmp	w0,	#43
    blt	main_125

main_325:
    movz	w0,	#43
    b	main_498

main_125:
    cmp	w0,	#42
    blt	main_127

main_322:
    movz	w0,	#42
    b	main_498

main_127:
    cmp	w0,	#41
    blt	main_129

main_319:
    movz	w0,	#41
    b	main_498

main_129:
    cmp	w0,	#40
    blt	main_131

main_316:
    movz	w0,	#40
    b	main_498

main_131:
    cmp	w0,	#39
    blt	main_133

main_313:
    movz	w0,	#39
    b	main_498

main_133:
    cmp	w0,	#38
    blt	main_135

main_310:
    movz	w0,	#38
    b	main_498

main_135:
    cmp	w0,	#37
    blt	main_137

main_307:
    movz	w0,	#37
    b	main_498

main_137:
    cmp	w0,	#36
    blt	main_139

main_304:
    movz	w0,	#36
    b	main_498

main_139:
    cmp	w0,	#35
    blt	main_141

main_301:
    movz	w0,	#35
    b	main_498

main_141:
    cmp	w0,	#34
    blt	main_143

main_298:
    movz	w0,	#34
    b	main_498

main_143:
    cmp	w0,	#33
    blt	main_145

main_295:
    movz	w0,	#33
    b	main_498

main_145:
    cmp	w0,	#32
    blt	main_147

main_292:
    movz	w0,	#32
    b	main_498

main_147:
    cmp	w0,	#31
    blt	main_149

main_289:
    movz	w0,	#31
    b	main_498

main_149:
    cmp	w0,	#30
    blt	main_151

main_286:
    movz	w0,	#30
    b	main_498

main_151:
    cmp	w0,	#29
    blt	main_153

main_283:
    movz	w0,	#29
    b	main_498

main_153:
    cmp	w0,	#28
    blt	main_155

main_280:
    movz	w0,	#28
    b	main_498

main_155:
    cmp	w0,	#27
    blt	main_157

main_277:
    movz	w0,	#27
    b	main_498

main_157:
    cmp	w0,	#26
    blt	main_159

main_274:
    movz	w0,	#26
    b	main_498

main_159:
    cmp	w0,	#25
    blt	main_161

main_271:
    movz	w0,	#25
    b	main_498

main_161:
    cmp	w0,	#24
    blt	main_163

main_268:
    movz	w0,	#24
    b	main_498

main_163:
    cmp	w0,	#23
    blt	main_165

main_265:
    movz	w0,	#23
    b	main_498

main_165:
    cmp	w0,	#22
    blt	main_167

main_262:
    movz	w0,	#22
    b	main_498

main_167:
    cmp	w0,	#21
    blt	main_169

main_259:
    movz	w0,	#21
    b	main_498

main_169:
    cmp	w0,	#20
    blt	main_171

main_256:
    movz	w0,	#20
    b	main_498

main_171:
    cmp	w0,	#19
    blt	main_173

main_253:
    movz	w0,	#19
    b	main_498

main_173:
    cmp	w0,	#18
    blt	main_175

main_250:
    movz	w0,	#18
    b	main_498

main_175:
    cmp	w0,	#17
    blt	main_177

main_247:
    movz	w0,	#17
    b	main_498

main_177:
    cmp	w0,	#16
    blt	main_179

main_244:
    movz	w0,	#16
    b	main_498

main_179:
    cmp	w0,	#15
    blt	main_181

main_241:
    movz	w0,	#15
    b	main_498

main_181:
    cmp	w0,	#14
    blt	main_183

main_238:
    movz	w0,	#14
    b	main_498

main_183:
    cmp	w0,	#13
    blt	main_185

main_235:
    movz	w0,	#13
    b	main_498

main_185:
    cmp	w0,	#12
    blt	main_187

main_232:
    movz	w0,	#12
    b	main_498

main_187:
    cmp	w0,	#11
    blt	main_189

main_229:
    movz	w0,	#11
    b	main_498

main_189:
    cmp	w0,	#10
    blt	main_191

main_226:
    movz	w0,	#10
    b	main_498

main_191:
    cmp	w0,	#9
    blt	main_193

main_223:
    movz	w0,	#9
    b	main_498

main_193:
    cmp	w0,	#8
    blt	main_195

main_220:
    movz	w0,	#8
    b	main_498

main_195:
    cmp	w0,	#7
    blt	main_197

main_217:
    movz	w0,	#7
    b	main_498

main_197:
    cmp	w0,	#6
    blt	main_199

main_214:
    movz	w0,	#6
    b	main_498

main_199:
    cmp	w0,	#5
    blt	main_201

main_211:
    movz	w0,	#5
    b	main_498

main_201:
    cmp	w0,	#4
    blt	main_203

main_208:
    movz	w0,	#4
    b	main_498

main_203:
    cmp	w0,	#2
    movz	w16,	#2
    movz	w3,	#1
    csel	w7,	w3,	w16,	lt
    cmp	w0,	#3
    movz	w8,	#3
    csel	w0,	w7,	w8,	lt

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


