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
    str	w0,	[sp, #1488]

    bl	getint
    str	w0,	[sp, #1492]

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
    ldr	w15,	[sp, #1488]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x5,	sp,	#20
    add	x22,	sp,	#24
    add	x23,	sp,	#28
    add	x16,	sp,	#32
    add	x3,	sp,	#36
    add	x21,	sp,	#40
    add	x2,	sp,	#44
    add	x9,	sp,	#48
    add	x7,	sp,	#52
    add	x14,	sp,	#56
    add	x15,	sp,	#60
    add	x13,	sp,	#64
    add	x26,	sp,	#68
    add	x6,	sp,	#72
    add	x8,	sp,	#76
    add	x24,	sp,	#80
    add	x20,	sp,	#84
    add	x4,	sp,	#88
    add	x28,	sp,	#92
    add	x18,	sp,	#96
    add	x25,	sp,	#100
    add	x0,	sp,	#104
    add	x1,	sp,	#108
    add	x11,	sp,	#112
    add	x27,	sp,	#116
    add	x10,	sp,	#120
    add	x19,	sp,	#124
    add	x17,	sp,	#128
    str	x5,	[sp, #1864]

    str	x22,	[sp, #1824]

    add	x22,	sp,	#136
    str	x23,	[sp, #1912]

    str	x16,	[sp, #1808]

    str	x3,	[sp, #1936]

    str	x21,	[sp, #1512]

    str	x2,	[sp, #1856]

    str	x9,	[sp, #1952]

    str	x7,	[sp, #1784]

    str	x14,	[sp, #1888]

    str	x15,	[sp, #1104]

    str	x13,	[sp, #1800]

    str	x26,	[sp, #1920]

    str	x6,	[sp, #1944]

    str	x8,	[sp, #1872]

    str	x24,	[sp, #1520]

    str	x20,	[sp, #1904]

    str	x4,	[sp, #1544]

    str	x28,	[sp, #1848]

    str	x18,	[sp, #1504]

    str	x25,	[sp, #1840]

    str	x0,	[sp, #1928]

    add	x0,	sp,	#132
    str	x1,	[sp, #1536]

    str	x11,	[sp, #1880]

    str	x27,	[sp, #1528]

    str	x10,	[sp, #1792]

    str	x19,	[sp, #1816]

    str	x17,	[sp, #1896]

    str	x0,	[sp, #584]

    add	x0,	sp,	#140
    str	x22,	[sp, #432]

    add	x22,	sp,	#144
    str	x0,	[sp, #1112]

    add	x0,	sp,	#148
    str	x22,	[sp, #1120]

    add	x22,	sp,	#152
    str	x0,	[sp, #736]

    add	x0,	sp,	#156
    str	x22,	[sp, #744]

    add	x22,	sp,	#164
    str	x0,	[sp, #752]

    add	x0,	sp,	#160
    str	x0,	[sp, #760]

    add	x0,	sp,	#168
    str	x22,	[sp, #768]

    add	x22,	sp,	#172
    str	x0,	[sp, #776]

    add	x0,	sp,	#176
    str	x22,	[sp, #784]

    add	x22,	sp,	#180
    str	x0,	[sp, #792]

    add	x0,	sp,	#184
    str	x22,	[sp, #800]

    add	x22,	sp,	#188
    str	x0,	[sp, #808]

    add	x0,	sp,	#192
    str	x22,	[sp, #816]

    add	x22,	sp,	#200
    str	x0,	[sp, #824]

    add	x0,	sp,	#196
    str	x0,	[sp, #832]

    add	x0,	sp,	#204
    str	x22,	[sp, #840]

    add	x22,	sp,	#208
    str	x0,	[sp, #848]

    add	x0,	sp,	#212
    str	x22,	[sp, #856]

    add	x22,	sp,	#216
    str	x0,	[sp, #872]

    add	x0,	sp,	#220
    str	x22,	[sp, #880]

    add	x22,	sp,	#224
    str	x0,	[sp, #888]

    add	x0,	sp,	#228
    str	x22,	[sp, #896]

    add	x22,	sp,	#232
    str	x0,	[sp, #1128]

    add	x0,	sp,	#240
    str	x22,	[sp, #864]

    add	x22,	sp,	#236
    str	x22,	[sp, #416]

    add	x22,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x22,	[sp, #1136]

    add	x22,	sp,	#252
    str	x0,	[sp, #1144]

    add	x0,	sp,	#256
    str	x22,	[sp, #1152]

    add	x22,	sp,	#260
    str	x0,	[sp, #1160]

    add	x0,	sp,	#264
    str	x22,	[sp, #1168]

    add	x22,	sp,	#268
    str	x0,	[sp, #1176]

    add	x0,	sp,	#272
    str	x22,	[sp, #1184]

    add	x22,	sp,	#280
    str	x0,	[sp, #1192]

    add	x0,	sp,	#276
    str	x0,	[sp, #1200]

    add	x0,	sp,	#284
    str	x22,	[sp, #1208]

    add	x22,	sp,	#288
    str	x0,	[sp, #1216]

    add	x0,	sp,	#292
    str	x22,	[sp, #1224]

    add	x22,	sp,	#296
    str	x0,	[sp, #1232]

    add	x0,	sp,	#300
    str	x22,	[sp, #1240]

    add	x22,	sp,	#304
    str	x0,	[sp, #1248]

    add	x0,	sp,	#308
    str	x22,	[sp, #1256]

    add	x22,	sp,	#316
    str	x0,	[sp, #1264]

    add	x0,	sp,	#312
    str	x0,	[sp, #1272]

    add	x0,	sp,	#320
    str	x22,	[sp, #1280]

    add	x22,	sp,	#324
    str	x0,	[sp, #1288]

    add	x0,	sp,	#328
    str	x22,	[sp, #1296]

    add	x22,	sp,	#332
    str	x0,	[sp, #1304]

    add	x0,	sp,	#336
    str	x22,	[sp, #1312]

    add	x22,	sp,	#340
    str	x0,	[sp, #1320]

    add	x0,	sp,	#344
    str	x22,	[sp, #1328]

    add	x22,	sp,	#348
    str	x0,	[sp, #1336]

    add	x0,	sp,	#356
    str	x22,	[sp, #1344]

    add	x22,	sp,	#352
    str	x22,	[sp, #1352]

    add	x22,	sp,	#360
    str	x0,	[sp, #1360]

    add	x0,	sp,	#364
    str	x22,	[sp, #1368]

    add	x22,	sp,	#368
    str	x0,	[sp, #1376]

    add	x0,	sp,	#372
    str	x22,	[sp, #1384]

    add	x22,	sp,	#376
    str	x0,	[sp, #1392]

    add	x0,	sp,	#380
    str	x22,	[sp, #1400]

    add	x22,	sp,	#384
    str	x0,	[sp, #1408]

    add	x0,	sp,	#388
    str	x22,	[sp, #1416]

    add	x22,	sp,	#396
    str	x0,	[sp, #1424]

    add	x0,	sp,	#392
    str	x0,	[sp, #1432]

    add	x0,	sp,	#400
    str	x22,	[sp, #1440]

    add	x22,	sp,	#404
    str	x0,	[sp, #1448]

    add	x0,	sp,	#408
    str	x22,	[sp, #1456]

    add	x22,	sp,	#412
    str	x0,	[sp, #1464]

    movz	w0,	#0
    str	x22,	[sp, #1472]

    str	w0,	[sp, #1484]

    movz	w0,	#0
    str	w0,	[sp, #1480]


main_113:
    ldr	w0,	[sp, #1492]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w0,	#1
    ldr	x2,	[sp, #1864]

    str	w0,	[x2]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#2
    ble	main_413

main_119:
    movz	w22,	#2
    ldr	x18,	[sp, #1824]

    mov	w0,	w22
    str	w0,	[x18]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w0,	#3
    ldr	x19,	[sp, #1912]

    mov	w22,	w0
    str	w22,	[x19]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    ldr	x10,	[sp, #1808]

    mov	w22,	w0
    str	w22,	[x10]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w0,	#5
    ldr	x1,	[sp, #1936]

    str	w0,	[x1]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#6
    ble	main_413

main_127:
    movz	w22,	#6
    ldr	x14,	[sp, #1512]

    str	w22,	[x14]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w22,	#7
    ldr	x27,	[sp, #1856]

    mov	w0,	w22
    str	w0,	[x27]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    ldr	x5,	[sp, #1952]

    mov	w22,	w0
    str	w22,	[x5]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w22,	#9
    ldr	x3,	[sp, #1784]

    mov	w0,	w22
    str	w0,	[x3]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#10
    ble	main_413

main_135:
    movz	w0,	#10
    ldr	x11,	[sp, #1888]

    str	w0,	[x11]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w22,	#11
    ldr	x10,	[sp, #1104]

    mov	w0,	w22
    str	w0,	[x10]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#12
    ble	main_413

main_139:
    movz	w0,	#12
    ldr	x7,	[sp, #1800]

    mov	w22,	w0
    str	w22,	[x7]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    ldr	x23,	[sp, #1920]

    mov	w22,	w0
    str	w22,	[x23]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#14
    ble	main_413

main_143:
    movz	w0,	#14
    ldr	x4,	[sp, #1944]

    str	w0,	[x4]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w22,	#15
    ldr	x3,	[sp, #1872]

    str	w22,	[x3]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#16
    ble	main_413

main_147:
    movz	w22,	#16
    ldr	x19,	[sp, #1520]

    mov	w0,	w22
    str	w0,	[x19]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    ldr	x15,	[sp, #1904]

    mov	w22,	w0
    str	w22,	[x15]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#18
    ble	main_413

main_151:
    movz	w22,	#18
    ldr	x28,	[sp, #1544]

    mov	w0,	w22
    str	w0,	[x28]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w0,	#19
    ldr	x24,	[sp, #1848]

    str	w0,	[x24]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#20
    ble	main_413

main_155:
    movz	w22,	#20
    ldr	x13,	[sp, #1504]

    mov	w0,	w22
    str	w0,	[x13]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w0,	#21
    ldr	x20,	[sp, #1840]

    mov	w22,	w0
    str	w22,	[x20]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    ldr	x26,	[sp, #1928]

    mov	w22,	w0
    str	w22,	[x26]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w0,	#23
    ldr	x25,	[sp, #1536]

    str	w0,	[x25]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#24
    ble	main_413

main_163:
    movz	w22,	#24
    ldr	x6,	[sp, #1880]

    str	w22,	[x6]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w22,	#25
    mov	w0,	w22
    ldr	x22,	[sp, #1528]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    ldr	x4,	[sp, #1792]

    mov	w22,	w0
    str	w22,	[x4]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#27
    ble	main_413

main_169:
    movz	w22,	#27
    ldr	x15,	[sp, #1816]

    mov	w0,	w22
    str	w0,	[x15]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w0,	#28
    ldr	x14,	[sp, #1896]

    str	w0,	[x14]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#29
    ble	main_413

main_173:
    movz	w22,	#29
    mov	w0,	w22
    ldr	x22,	[sp, #584]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w0,	#30
    ldr	x22,	[sp, #432]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    mov	w22,	w0
    ldr	x0,	[sp, #1112]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w0,	#32
    ldr	x22,	[sp, #1120]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#33
    ble	main_413

main_181:
    movz	w22,	#33
    ldr	x0,	[sp, #736]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w22,	#34
    mov	w0,	w22
    ldr	x22,	[sp, #744]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    mov	w22,	w0
    ldr	x0,	[sp, #752]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w22,	#36
    mov	w0,	w22
    ldr	x22,	[sp, #760]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#37
    ble	main_413

main_189:
    movz	w0,	#37
    mov	w22,	w0
    ldr	x0,	[sp, #768]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w22,	#38
    mov	w0,	w22
    ldr	x22,	[sp, #776]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#39
    ble	main_413

main_193:
    movz	w0,	#39
    mov	w22,	w0
    ldr	x0,	[sp, #784]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    ldr	x22,	[sp, #792]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#41
    ble	main_413

main_197:
    movz	w0,	#41
    ldr	x22,	[sp, #800]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w22,	#42
    ldr	x0,	[sp, #808]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#43
    ble	main_413

main_201:
    movz	w22,	#43
    mov	w0,	w22
    ldr	x22,	[sp, #816]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    mov	w22,	w0
    ldr	x0,	[sp, #824]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#45
    ble	main_413

main_205:
    movz	w22,	#45
    mov	w0,	w22
    ldr	x22,	[sp, #832]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w0,	#46
    ldr	x22,	[sp, #840]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#47
    ble	main_413

main_209:
    movz	w22,	#47
    mov	w0,	w22
    ldr	x22,	[sp, #848]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w0,	#48
    mov	w22,	w0
    ldr	x0,	[sp, #856]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    mov	w22,	w0
    ldr	x0,	[sp, #872]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w0,	#50
    mov	w22,	w0
    ldr	x0,	[sp, #880]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#51
    ble	main_413

main_217:
    movz	w22,	#51
    mov	w0,	w22
    ldr	x22,	[sp, #888]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w22,	#52
    ldr	x0,	[sp, #896]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    mov	w22,	w0
    ldr	x0,	[sp, #1128]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w22,	#54
    mov	w0,	w22
    ldr	x22,	[sp, #864]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w0,	#55
    ldr	x22,	[sp, #416]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#56
    ble	main_413

main_227:
    movz	w22,	#56
    mov	w0,	w22
    ldr	x22,	[sp, #424]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w0,	#57
    mov	w22,	w0
    ldr	x0,	[sp, #1136]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    mov	w22,	w0
    ldr	x0,	[sp, #1144]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w0,	#59
    mov	w22,	w0
    ldr	x0,	[sp, #1152]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#60
    ble	main_413

main_235:
    movz	w22,	#60
    ldr	x0,	[sp, #1160]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w22,	#61
    mov	w0,	w22
    ldr	x22,	[sp, #1168]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    mov	w22,	w0
    ldr	x0,	[sp, #1176]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w22,	#63
    mov	w0,	w22
    ldr	x22,	[sp, #1184]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#64
    ble	main_413

main_243:
    movz	w0,	#64
    ldr	x22,	[sp, #1192]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w22,	#65
    mov	w0,	w22
    ldr	x22,	[sp, #1200]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#66
    ble	main_413

main_247:
    movz	w0,	#66
    ldr	x22,	[sp, #1208]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    mov	w22,	w0
    ldr	x0,	[sp, #1216]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#68
    ble	main_413

main_251:
    movz	w0,	#68
    ldr	x22,	[sp, #1224]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w22,	#69
    ldr	x0,	[sp, #1232]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#70
    ble	main_413

main_255:
    movz	w22,	#70
    mov	w0,	w22
    ldr	x22,	[sp, #1240]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    mov	w22,	w0
    ldr	x0,	[sp, #1248]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#72
    ble	main_413

main_259:
    movz	w22,	#72
    mov	w0,	w22
    ldr	x22,	[sp, #1256]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w0,	#73
    ldr	x22,	[sp, #1264]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#74
    ble	main_413

main_263:
    movz	w22,	#74
    mov	w0,	w22
    ldr	x22,	[sp, #1272]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w0,	#75
    mov	w22,	w0
    ldr	x0,	[sp, #1280]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    ldr	x22,	[sp, #1288]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w0,	#77
    ldr	x22,	[sp, #1296]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#78
    ble	main_413

main_271:
    movz	w22,	#78
    ldr	x0,	[sp, #1304]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w22,	#79
    mov	w0,	w22
    ldr	x22,	[sp, #1312]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    ldr	x22,	[sp, #1320]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w22,	#81
    ldr	x0,	[sp, #1328]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#82
    ble	main_413

main_279:
    movz	w0,	#82
    ldr	x22,	[sp, #1336]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w22,	#83
    mov	w0,	w22
    ldr	x22,	[sp, #1344]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w0,	#84
    mov	w22,	w0
    ldr	x0,	[sp, #1352]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    mov	w22,	w0
    ldr	x0,	[sp, #1360]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w0,	#86
    ldr	x22,	[sp, #1368]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#87
    ble	main_413

main_289:
    movz	w22,	#87
    ldr	x0,	[sp, #1376]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w22,	#88
    mov	w0,	w22
    ldr	x22,	[sp, #1384]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    mov	w22,	w0
    ldr	x0,	[sp, #1392]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w22,	#90
    mov	w0,	w22
    ldr	x22,	[sp, #1400]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#91
    ble	main_413

main_297:
    movz	w0,	#91
    ldr	x22,	[sp, #1408]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w22,	#92
    mov	w0,	w22
    ldr	x22,	[sp, #1416]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#93
    ble	main_413

main_301:
    movz	w0,	#93
    mov	w22,	w0
    ldr	x0,	[sp, #1424]

    str	w22,	[x0]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    mov	w22,	w0
    ldr	x0,	[sp, #1432]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#95
    ble	main_413

main_305:
    movz	w0,	#95
    ldr	x22,	[sp, #1440]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w22,	#96
    mov	w0,	w22
    ldr	x22,	[sp, #1448]

    str	w0,	[x22]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#97
    ble	main_413

main_309:
    movz	w22,	#97
    mov	w0,	w22
    ldr	x22,	[sp, #1456]

    str	w0,	[x22]

    ldr	w0,	[sp, #1492]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    mov	w22,	w0
    ldr	x0,	[sp, #1464]

    str	w22,	[x0]

    ldr	w22,	[sp, #1492]

    cmp	w22,	#99
    ble	main_413

main_313:
    movz	w22,	#99
    mov	w0,	w22
    ldr	x22,	[sp, #1472]

    str	w0,	[x22]


main_413:
    ldr	w22,	[sp, #1480]

    add	w0,	w22,	#1
    movz	w22,	#0
    str	w0,	[sp, #732]

    ldr	w0,	[sp, #1484]

    str	w0,	[sp, #728]

    str	w22,	[sp, #440]


main_415:
    ldr	w0,	[sp, #440]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w22,	[sp, #440]

    lsl	w0,	w22,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w22,	[sp, #728]

    add	w0,	w0,	w22
    ldr	w22,	[sp, #440]

    add	w22,	w22,	#1
    str	w22,	[sp, #592]

    str	w0,	[sp, #728]

    ldr	w22,	[sp, #592]

    str	w22,	[sp, #440]

    b	main_415

main_424:
    movz	w0,	#65535
    ldr	w22,	[sp, #728]

    sdiv	w22,	w22,	w0
    str	w22,	[sp, #580]

    ldr	w0,	[sp, #580]

    lsl	w22,	w0,	#16
    ldr	w0,	[sp, #580]

    sub	w22,	w22,	w0,	lsl #0
    ldr	w0,	[sp, #728]

    ldr	w25,	[sp, #732]

    sub	w0,	w0,	w22
    str	w25,	[sp, #2796]

    ldr	w7,	[sp, #1488]

    str	w7,	[sp, #708]

    ldr	w8,	[sp, #708]

    ldr	w26,	[sp, #2796]

    cmp	w26,	w8
    bge	main_429

main_112:
    str	w0,	[sp, #1484]

    ldr	w0,	[sp, #732]

    str	w0,	[sp, #1480]

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


