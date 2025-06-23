.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #3392
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1152]

    bl	getint
    str	w0,	[sp, #1156]

    movz	w0,	#0

main_4:
    cmp	w0,	#100
    bge	main_10

main_7:
    lsl	w4,	w0,	#2
    movz	w25,	#0
    add	w0,	w0,	#1
    mov	x16,	x4
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    str	w25,	[x16]

    b	main_4

main_10:
    movz	w28,	#0
    ldr	w15,	[sp, #1152]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x3,	sp,	#20
    add	x19,	sp,	#24
    add	x22,	sp,	#28
    add	x6,	sp,	#32
    add	x16,	sp,	#36
    add	x25,	sp,	#40
    add	x14,	sp,	#44
    add	x28,	sp,	#48
    add	x0,	sp,	#52
    add	x21,	sp,	#56
    add	x18,	sp,	#60
    add	x10,	sp,	#64
    add	x8,	sp,	#68
    add	x4,	sp,	#72
    add	x1,	sp,	#76
    add	x24,	sp,	#80
    add	x2,	sp,	#84
    add	x26,	sp,	#88
    add	x23,	sp,	#92
    add	x27,	sp,	#96
    add	x7,	sp,	#100
    add	x11,	sp,	#104
    add	x5,	sp,	#108
    add	x17,	sp,	#112
    add	x20,	sp,	#116
    add	x15,	sp,	#120
    add	x9,	sp,	#124
    add	x13,	sp,	#128
    movz	fp,	#452
    str	x3,	[sp, #1816]

    str	x19,	[sp, #1192]

    str	x22,	[sp, #1200]

    str	x6,	[sp, #1824]

    str	x16,	[sp, #1184]

    str	x25,	[sp, #1720]

    str	x14,	[sp, #1768]

    str	x28,	[sp, #1728]

    str	x0,	[sp, #1808]

    add	x0,	sp,	#132
    str	x21,	[sp, #1712]

    str	x18,	[sp, #1704]

    str	x10,	[sp, #1168]

    str	x8,	[sp, #1752]

    str	x4,	[sp, #1480]

    str	x1,	[sp, #1472]

    str	x24,	[sp, #1456]

    str	x2,	[sp, #1736]

    str	x26,	[sp, #1800]

    str	x23,	[sp, #1792]

    str	x27,	[sp, #1464]

    str	x7,	[sp, #1488]

    str	x11,	[sp, #1760]

    str	x5,	[sp, #1744]

    str	x17,	[sp, #1776]

    str	x20,	[sp, #1784]

    str	x15,	[sp, #1696]

    str	x9,	[sp, #1832]

    str	x13,	[sp, #1176]

    str	x0,	[sp, fp]

    movz	fp,	#468
    add	x0,	sp,	#136
    str	x0,	[sp, fp]

    movz	fp,	#436
    add	x0,	sp,	#140
    str	x0,	[sp, fp]

    movz	fp,	#444
    add	x0,	sp,	#144
    str	x0,	[sp, fp]

    add	x0,	sp,	#148
    str	x0,	[sp, #696]

    add	x0,	sp,	#152
    str	x0,	[sp, #704]

    add	x0,	sp,	#156
    str	x0,	[sp, #712]

    add	x0,	sp,	#160
    str	x0,	[sp, #720]

    add	x0,	sp,	#164
    str	x0,	[sp, #728]

    add	x0,	sp,	#168
    str	x0,	[sp, #736]

    add	x0,	sp,	#172
    str	x0,	[sp, #744]

    add	x0,	sp,	#176
    str	x0,	[sp, #752]

    add	x0,	sp,	#180
    str	x0,	[sp, #760]

    add	x0,	sp,	#184
    str	x0,	[sp, #768]

    add	x0,	sp,	#188
    str	x0,	[sp, #776]

    add	x0,	sp,	#192
    str	x0,	[sp, #784]

    add	x0,	sp,	#196
    str	x0,	[sp, #624]

    add	x0,	sp,	#200
    str	x0,	[sp, #632]

    add	x0,	sp,	#204
    str	x0,	[sp, #640]

    add	x0,	sp,	#208
    str	x0,	[sp, #648]

    add	x0,	sp,	#212
    str	x0,	[sp, #664]

    add	x0,	sp,	#216
    str	x0,	[sp, #672]

    add	x0,	sp,	#220
    str	x0,	[sp, #680]

    add	x0,	sp,	#224
    str	x0,	[sp, #688]

    add	x0,	sp,	#228
    str	x0,	[sp, #792]

    add	x0,	sp,	#232
    str	x0,	[sp, #656]

    add	x0,	sp,	#236
    str	x0,	[sp, #416]

    add	x0,	sp,	#240
    str	x0,	[sp, #424]

    add	x0,	sp,	#244
    str	x0,	[sp, #800]

    add	x0,	sp,	#248
    str	x0,	[sp, #808]

    add	x0,	sp,	#252
    str	x0,	[sp, #816]

    add	x0,	sp,	#256
    str	x0,	[sp, #824]

    add	x0,	sp,	#260
    str	x0,	[sp, #832]

    add	x0,	sp,	#264
    str	x0,	[sp, #840]

    add	x0,	sp,	#268
    str	x0,	[sp, #848]

    add	x0,	sp,	#272
    str	x0,	[sp, #856]

    add	x0,	sp,	#276
    str	x0,	[sp, #864]

    add	x0,	sp,	#280
    str	x0,	[sp, #872]

    add	x0,	sp,	#284
    str	x0,	[sp, #880]

    add	x0,	sp,	#288
    str	x0,	[sp, #888]

    add	x0,	sp,	#292
    str	x0,	[sp, #896]

    add	x0,	sp,	#296
    str	x0,	[sp, #904]

    add	x0,	sp,	#300
    str	x0,	[sp, #912]

    add	x0,	sp,	#304
    str	x0,	[sp, #920]

    add	x0,	sp,	#308
    str	x0,	[sp, #928]

    add	x0,	sp,	#312
    str	x0,	[sp, #936]

    add	x0,	sp,	#316
    str	x0,	[sp, #944]

    add	x0,	sp,	#320
    str	x0,	[sp, #952]

    add	x0,	sp,	#324
    str	x0,	[sp, #960]

    add	x0,	sp,	#328
    str	x0,	[sp, #968]

    add	x0,	sp,	#332
    str	x0,	[sp, #976]

    add	x0,	sp,	#336
    str	x0,	[sp, #984]

    add	x0,	sp,	#340
    str	x0,	[sp, #992]

    add	x0,	sp,	#344
    str	x0,	[sp, #1000]

    add	x0,	sp,	#348
    str	x0,	[sp, #1008]

    add	x0,	sp,	#352
    str	x0,	[sp, #1016]

    add	x0,	sp,	#356
    str	x0,	[sp, #1024]

    add	x0,	sp,	#360
    str	x0,	[sp, #1032]

    add	x0,	sp,	#364
    str	x0,	[sp, #1040]

    add	x0,	sp,	#368
    str	x0,	[sp, #1048]

    add	x0,	sp,	#372
    str	x0,	[sp, #1056]

    add	x0,	sp,	#376
    str	x0,	[sp, #1064]

    add	x0,	sp,	#380
    str	x0,	[sp, #1072]

    add	x0,	sp,	#384
    str	x0,	[sp, #1080]

    add	x0,	sp,	#388
    str	x0,	[sp, #1088]

    add	x0,	sp,	#392
    str	x0,	[sp, #1096]

    add	x0,	sp,	#396
    str	x0,	[sp, #1104]

    add	x0,	sp,	#400
    str	x0,	[sp, #1112]

    add	x0,	sp,	#404
    str	x0,	[sp, #1120]

    add	x0,	sp,	#408
    str	x0,	[sp, #1128]

    add	x0,	sp,	#412
    str	x0,	[sp, #1136]

    movz	w0,	#0
    str	w0,	[sp, #1148]

    movz	w0,	#0
    str	w0,	[sp, #1144]


main_113:
    ldr	w0,	[sp, #1156]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w0,	#1
    ldr	x1,	[sp, #1816]

    str	w0,	[x1]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#2
    ble	main_413

main_119:
    movz	w0,	#2
    ldr	x15,	[sp, #1192]

    str	w0,	[x15]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w0,	#3
    ldr	x18,	[sp, #1200]

    str	w0,	[x18]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    ldr	x3,	[sp, #1824]

    str	w0,	[x3]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w0,	#5
    ldr	x12,	[sp, #1184]

    str	w0,	[x12]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    ldr	x21,	[sp, #1720]

    str	w0,	[x21]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    ldr	x11,	[sp, #1768]

    str	w0,	[x11]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    ldr	x24,	[sp, #1728]

    str	w0,	[x24]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    ldr	x26,	[sp, #1808]

    str	w0,	[x26]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#10
    ble	main_413

main_135:
    movz	w0,	#10
    ldr	x16,	[sp, #1712]

    str	w0,	[x16]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w0,	#11
    ldr	x13,	[sp, #1704]

    str	w0,	[x13]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#12
    ble	main_413

main_139:
    movz	w0,	#12
    ldr	x5,	[sp, #1168]

    str	w0,	[x5]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    ldr	x4,	[sp, #1752]

    str	w0,	[x4]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#14
    ble	main_413

main_143:
    movz	w0,	#14
    ldr	x28,	[sp, #1480]

    str	w0,	[x28]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    ldr	x25,	[sp, #1472]

    str	w0,	[x25]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    ldr	x19,	[sp, #1456]

    str	w0,	[x19]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    ldr	x27,	[sp, #1736]

    str	w0,	[x27]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    ldr	x23,	[sp, #1800]

    str	w0,	[x23]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w0,	#19
    ldr	x20,	[sp, #1792]

    str	w0,	[x20]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#20
    ble	main_413

main_155:
    movz	w0,	#20
    ldr	x22,	[sp, #1464]

    str	w0,	[x22]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w0,	#21
    ldr	x2,	[sp, #1488]

    str	w0,	[x2]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    ldr	x8,	[sp, #1760]

    str	w0,	[x8]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w0,	#23
    ldr	x2,	[sp, #1744]

    str	w0,	[x2]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    ldr	x14,	[sp, #1776]

    str	w0,	[x14]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    ldr	x17,	[sp, #1784]

    str	w0,	[x17]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    ldr	x10,	[sp, #1696]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    ldr	x7,	[sp, #1832]

    str	w0,	[x7]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w0,	#28
    ldr	x9,	[sp, #1176]

    str	w0,	[x9]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#29
    ble	main_413

main_173:
    movz	w0,	#29
    movz	fp,	#452
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w0,	#30
    movz	fp,	#468
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    movz	fp,	#436
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w0,	#32
    movz	fp,	#444
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    ldr	x10,	[sp, #696]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    ldr	x10,	[sp, #704]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    ldr	x10,	[sp, #712]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    ldr	x10,	[sp, #720]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#37
    ble	main_413

main_189:
    movz	w0,	#37
    ldr	x10,	[sp, #728]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w0,	#38
    ldr	x10,	[sp, #736]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#39
    ble	main_413

main_193:
    movz	w0,	#39
    ldr	x10,	[sp, #744]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    ldr	x10,	[sp, #752]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#41
    ble	main_413

main_197:
    movz	w0,	#41
    ldr	x10,	[sp, #760]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    ldr	x10,	[sp, #768]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    ldr	x10,	[sp, #776]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    ldr	x10,	[sp, #784]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    ldr	x10,	[sp, #624]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w0,	#46
    ldr	x10,	[sp, #632]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#47
    ble	main_413

main_209:
    movz	w0,	#47
    ldr	x10,	[sp, #640]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w0,	#48
    ldr	x10,	[sp, #648]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    ldr	x10,	[sp, #664]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w0,	#50
    ldr	x10,	[sp, #672]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    ldr	x10,	[sp, #680]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    ldr	x10,	[sp, #688]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    ldr	x10,	[sp, #792]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    ldr	x10,	[sp, #656]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w0,	#55
    ldr	x10,	[sp, #416]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#56
    ble	main_413

main_227:
    movz	w0,	#56
    ldr	x10,	[sp, #424]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w0,	#57
    ldr	x10,	[sp, #800]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    ldr	x10,	[sp, #808]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w0,	#59
    ldr	x10,	[sp, #816]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    ldr	x10,	[sp, #824]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    ldr	x10,	[sp, #832]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    ldr	x10,	[sp, #840]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    ldr	x10,	[sp, #848]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#64
    ble	main_413

main_243:
    movz	w0,	#64
    ldr	x10,	[sp, #856]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w0,	#65
    ldr	x10,	[sp, #864]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#66
    ble	main_413

main_247:
    movz	w0,	#66
    ldr	x10,	[sp, #872]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    ldr	x10,	[sp, #880]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#68
    ble	main_413

main_251:
    movz	w0,	#68
    ldr	x10,	[sp, #888]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    ldr	x10,	[sp, #896]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    ldr	x10,	[sp, #904]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    ldr	x10,	[sp, #912]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    ldr	x10,	[sp, #920]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w0,	#73
    ldr	x10,	[sp, #928]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#74
    ble	main_413

main_263:
    movz	w0,	#74
    ldr	x10,	[sp, #936]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w0,	#75
    ldr	x10,	[sp, #944]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    ldr	x10,	[sp, #952]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w0,	#77
    ldr	x10,	[sp, #960]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    ldr	x10,	[sp, #968]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    ldr	x10,	[sp, #976]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    ldr	x10,	[sp, #984]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    ldr	x10,	[sp, #992]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#82
    ble	main_413

main_279:
    movz	w0,	#82
    ldr	x10,	[sp, #1000]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w0,	#83
    ldr	x10,	[sp, #1008]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w0,	#84
    ldr	x10,	[sp, #1016]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    ldr	x10,	[sp, #1024]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w0,	#86
    ldr	x10,	[sp, #1032]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    ldr	x10,	[sp, #1040]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    ldr	x10,	[sp, #1048]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    ldr	x10,	[sp, #1056]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    ldr	x10,	[sp, #1064]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#91
    ble	main_413

main_297:
    movz	w0,	#91
    ldr	x10,	[sp, #1072]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w0,	#92
    ldr	x10,	[sp, #1080]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#93
    ble	main_413

main_301:
    movz	w0,	#93
    ldr	x10,	[sp, #1088]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    ldr	x10,	[sp, #1096]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#95
    ble	main_413

main_305:
    movz	w0,	#95
    ldr	x10,	[sp, #1104]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    ldr	x10,	[sp, #1112]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    ldr	x10,	[sp, #1120]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    ldr	x10,	[sp, #1128]

    str	w0,	[x10]

    ldr	w0,	[sp, #1156]

    cmp	w0,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    ldr	x10,	[sp, #1136]

    str	w0,	[x10]


main_413:
    ldr	w0,	[sp, #1144]

    add	w0,	w0,	#1
    str	w0,	[sp, #460]

    ldr	w0,	[sp, #1148]

    str	w0,	[sp, #616]

    movz	w0,	#0
    str	w0,	[sp, #464]


main_415:
    ldr	w0,	[sp, #464]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w0,	[sp, #464]

    lsl	w0,	w0,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w10,	[x0]

    ldr	w0,	[sp, #616]

    add	w0,	w10,	w0
    ldr	w10,	[sp, #464]

    add	w10,	w10,	#1
    str	w10,	[sp, #620]

    str	w0,	[sp, #616]

    ldr	w0,	[sp, #620]

    str	w0,	[sp, #464]

    b	main_415

main_424:
    movz	w0,	#65535
    ldr	w10,	[sp, #616]

    sdiv	w0,	w10,	w0
    str	w0,	[sp, #432]

    ldr	w0,	[sp, #432]

    lsl	w10,	w0,	#16
    ldr	w0,	[sp, #432]

    sub	w10,	w10,	w0,	lsl #0
    ldr	w0,	[sp, #616]

    ldr	w26,	[sp, #460]

    sub	w0,	w0,	w10
    str	w26,	[sp, #3276]

    ldr	w7,	[sp, #1152]

    str	w7,	[sp, #604]

    ldr	w8,	[sp, #604]

    ldr	w27,	[sp, #3276]

    cmp	w27,	w8
    bge	main_429

main_112:
    str	w0,	[sp, #1148]

    ldr	w0,	[sp, #460]

    str	w0,	[sp, #1144]

    b	main_113

main_427:
    movz	w0,	#0

main_429:
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#402
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #3392
    ret


