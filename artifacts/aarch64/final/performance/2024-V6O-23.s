.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #3168
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1120]

    bl	getint
    str	w0,	[sp, #1124]

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
    ldr	w15,	[sp, #1120]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x19,	sp,	#20
    add	x18,	sp,	#24
    add	x3,	sp,	#28
    add	x25,	sp,	#32
    add	x9,	sp,	#36
    add	x22,	sp,	#40
    add	x16,	sp,	#44
    add	x13,	sp,	#48
    add	x0,	sp,	#52
    add	x26,	sp,	#56
    add	x17,	sp,	#60
    add	x14,	sp,	#64
    add	x10,	sp,	#68
    add	x28,	sp,	#72
    add	x27,	sp,	#76
    add	x24,	sp,	#80
    add	x7,	sp,	#84
    add	x15,	sp,	#88
    add	x23,	sp,	#92
    add	x20,	sp,	#96
    add	x21,	sp,	#100
    add	x11,	sp,	#104
    add	x5,	sp,	#108
    add	x2,	sp,	#112
    add	x4,	sp,	#116
    add	x6,	sp,	#120
    add	x8,	sp,	#124
    add	x1,	sp,	#128
    movz	fp,	#564
    str	x19,	[sp, #1672]

    str	x18,	[sp, #1528]

    str	x3,	[sp, #1784]

    str	x25,	[sp, #1688]

    str	x9,	[sp, #1800]

    str	x22,	[sp, #1680]

    str	x16,	[sp, #1664]

    str	x13,	[sp, #1656]

    str	x0,	[sp, #1776]

    add	x0,	sp,	#132
    str	x26,	[sp, #1768]

    str	x17,	[sp, #1744]

    str	x14,	[sp, #1736]

    str	x10,	[sp, #1648]

    str	x28,	[sp, #1696]

    add	x28,	sp,	#136
    str	x27,	[sp, #1552]

    str	x24,	[sp, #1544]

    str	x7,	[sp, #1640]

    str	x15,	[sp, #1520]

    str	x23,	[sp, #1760]

    str	x20,	[sp, #1752]

    str	x21,	[sp, #1536]

    str	x11,	[sp, #1728]

    str	x5,	[sp, #1712]

    str	x2,	[sp, #1704]

    str	x4,	[sp, #1632]

    str	x6,	[sp, #1792]

    str	x8,	[sp, #1720]

    str	x1,	[sp, #1624]

    str	x0,	[sp, fp]

    add	x0,	sp,	#140
    movz	fp,	#556
    str	x28,	[sp, fp]

    add	x28,	sp,	#144
    movz	fp,	#580
    str	x0,	[sp, #440]

    add	x0,	sp,	#148
    str	x28,	[sp, #632]

    add	x28,	sp,	#152
    str	x0,	[sp, #640]

    add	x0,	sp,	#156
    str	x28,	[sp, #656]

    add	x28,	sp,	#164
    str	x0,	[sp, #664]

    add	x0,	sp,	#160
    str	x0,	[sp, #672]

    add	x0,	sp,	#168
    str	x28,	[sp, #680]

    add	x28,	sp,	#172
    str	x0,	[sp, #688]

    add	x0,	sp,	#176
    str	x28,	[sp, fp]

    add	x28,	sp,	#180
    movz	fp,	#588
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#596
    str	x28,	[sp, fp]

    add	x28,	sp,	#188
    movz	fp,	#604
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#612
    str	x28,	[sp, fp]

    add	x28,	sp,	#200
    movz	fp,	#620
    str	x0,	[sp, fp]

    add	x0,	sp,	#196
    str	x0,	[sp, #696]

    add	x0,	sp,	#204
    str	x28,	[sp, #704]

    add	x28,	sp,	#208
    str	x0,	[sp, #712]

    add	x0,	sp,	#212
    str	x28,	[sp, #720]

    add	x28,	sp,	#216
    str	x0,	[sp, #728]

    add	x0,	sp,	#220
    str	x28,	[sp, #736]

    add	x28,	sp,	#224
    str	x0,	[sp, #744]

    add	x0,	sp,	#228
    str	x28,	[sp, #760]

    add	x28,	sp,	#232
    str	x0,	[sp, #768]

    add	x0,	sp,	#240
    str	x28,	[sp, #752]

    add	x28,	sp,	#236
    str	x28,	[sp, #416]

    add	x28,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x28,	[sp, #432]

    add	x28,	sp,	#252
    str	x0,	[sp, #776]

    add	x0,	sp,	#256
    str	x28,	[sp, #784]

    add	x28,	sp,	#260
    str	x0,	[sp, #792]

    add	x0,	sp,	#264
    str	x28,	[sp, #800]

    add	x28,	sp,	#268
    str	x0,	[sp, #808]

    add	x0,	sp,	#272
    str	x28,	[sp, #816]

    add	x28,	sp,	#280
    str	x0,	[sp, #824]

    add	x0,	sp,	#276
    str	x0,	[sp, #832]

    add	x0,	sp,	#284
    str	x28,	[sp, #840]

    add	x28,	sp,	#288
    str	x0,	[sp, #848]

    add	x0,	sp,	#292
    str	x28,	[sp, #856]

    add	x28,	sp,	#296
    str	x0,	[sp, #864]

    add	x0,	sp,	#300
    str	x28,	[sp, #872]

    add	x28,	sp,	#304
    str	x0,	[sp, #880]

    add	x0,	sp,	#308
    str	x28,	[sp, #888]

    add	x28,	sp,	#316
    str	x0,	[sp, #896]

    add	x0,	sp,	#312
    str	x0,	[sp, #904]

    add	x0,	sp,	#320
    str	x28,	[sp, #912]

    add	x28,	sp,	#324
    str	x0,	[sp, #920]

    add	x0,	sp,	#328
    str	x28,	[sp, #928]

    add	x28,	sp,	#332
    str	x0,	[sp, #936]

    add	x0,	sp,	#336
    str	x28,	[sp, #944]

    add	x28,	sp,	#340
    str	x0,	[sp, #952]

    add	x0,	sp,	#344
    str	x28,	[sp, #960]

    add	x28,	sp,	#348
    str	x0,	[sp, #968]

    add	x0,	sp,	#356
    str	x28,	[sp, #976]

    add	x28,	sp,	#352
    str	x28,	[sp, #984]

    add	x28,	sp,	#360
    str	x0,	[sp, #992]

    add	x0,	sp,	#364
    str	x28,	[sp, #1000]

    add	x28,	sp,	#368
    str	x0,	[sp, #1008]

    add	x0,	sp,	#372
    str	x28,	[sp, #1016]

    add	x28,	sp,	#376
    str	x0,	[sp, #1024]

    add	x0,	sp,	#380
    str	x28,	[sp, #1032]

    add	x28,	sp,	#384
    str	x0,	[sp, #1040]

    add	x0,	sp,	#388
    str	x28,	[sp, #1048]

    add	x28,	sp,	#396
    str	x0,	[sp, #1056]

    add	x0,	sp,	#392
    str	x0,	[sp, #1064]

    add	x0,	sp,	#400
    str	x28,	[sp, #1072]

    add	x28,	sp,	#404
    str	x0,	[sp, #1080]

    add	x0,	sp,	#408
    str	x28,	[sp, #1088]

    add	x28,	sp,	#412
    str	x0,	[sp, #1096]

    movz	w0,	#0
    str	x28,	[sp, #1104]

    str	w0,	[sp, #1116]

    movz	w0,	#0
    str	w0,	[sp, #1112]


main_113:
    ldr	w0,	[sp, #1124]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w0,	#1
    ldr	x15,	[sp, #1672]

    str	w0,	[x15]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#2
    ble	main_413

main_119:
    movz	w28,	#2
    ldr	x13,	[sp, #1528]

    mov	w0,	w28
    str	w0,	[x13]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w0,	#3
    mov	w28,	w0
    ldr	x0,	[sp, #1784]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    ldr	x19,	[sp, #1688]

    mov	w28,	w0
    str	w28,	[x19]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w0,	#5
    ldr	x7,	[sp, #1800]

    str	w0,	[x7]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#6
    ble	main_413

main_127:
    movz	w28,	#6
    ldr	x16,	[sp, #1680]

    str	w28,	[x16]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w28,	#7
    ldr	x12,	[sp, #1664]

    mov	w0,	w28
    str	w0,	[x12]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    ldr	x7,	[sp, #1656]

    mov	w28,	w0
    str	w28,	[x7]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w28,	#9
    ldr	x26,	[sp, #1776]

    mov	w0,	w28
    str	w0,	[x26]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#10
    ble	main_413

main_135:
    movz	w0,	#10
    ldr	x23,	[sp, #1768]

    str	w0,	[x23]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w28,	#11
    ldr	x14,	[sp, #1744]

    mov	w0,	w28
    str	w0,	[x14]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#12
    ble	main_413

main_139:
    movz	w0,	#12
    ldr	x9,	[sp, #1736]

    mov	w28,	w0
    str	w28,	[x9]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    ldr	x4,	[sp, #1648]

    mov	w28,	w0
    str	w28,	[x4]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#14
    ble	main_413

main_143:
    movz	w0,	#14
    ldr	x24,	[sp, #1696]

    str	w0,	[x24]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w28,	#15
    ldr	x20,	[sp, #1552]

    str	w28,	[x20]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#16
    ble	main_413

main_147:
    movz	w28,	#16
    ldr	x19,	[sp, #1544]

    mov	w0,	w28
    str	w0,	[x19]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    ldr	x1,	[sp, #1640]

    mov	w28,	w0
    str	w28,	[x1]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#18
    ble	main_413

main_151:
    movz	w28,	#18
    ldr	x10,	[sp, #1520]

    mov	w0,	w28
    str	w0,	[x10]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w0,	#19
    ldr	x20,	[sp, #1760]

    str	w0,	[x20]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#20
    ble	main_413

main_155:
    movz	w28,	#20
    ldr	x17,	[sp, #1752]

    mov	w0,	w28
    str	w0,	[x17]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w0,	#21
    ldr	x14,	[sp, #1536]

    mov	w28,	w0
    str	w28,	[x14]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    ldr	x6,	[sp, #1728]

    mov	w28,	w0
    str	w28,	[x6]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w0,	#23
    ldr	x2,	[sp, #1712]

    str	w0,	[x2]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#24
    ble	main_413

main_163:
    movz	w28,	#24
    ldr	x26,	[sp, #1704]

    str	w28,	[x26]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w28,	#25
    mov	w0,	w28
    ldr	x28,	[sp, #1632]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    ldr	x2,	[sp, #1792]

    mov	w28,	w0
    str	w28,	[x2]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#27
    ble	main_413

main_169:
    movz	w28,	#27
    ldr	x5,	[sp, #1720]

    mov	w0,	w28
    str	w0,	[x5]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w0,	#28
    ldr	x25,	[sp, #1624]

    str	w0,	[x25]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#29
    ble	main_413

main_173:
    movz	w28,	#29
    movz	fp,	#564
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w0,	#30
    movz	fp,	#556
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    mov	w28,	w0
    ldr	x0,	[sp, #440]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w0,	#32
    ldr	x28,	[sp, #632]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#33
    ble	main_413

main_181:
    movz	w28,	#33
    ldr	x0,	[sp, #640]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w28,	#34
    mov	w0,	w28
    ldr	x28,	[sp, #656]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    mov	w28,	w0
    ldr	x0,	[sp, #664]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w28,	#36
    mov	w0,	w28
    ldr	x28,	[sp, #672]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#37
    ble	main_413

main_189:
    movz	w0,	#37
    mov	w28,	w0
    ldr	x0,	[sp, #680]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w28,	#38
    mov	w0,	w28
    ldr	x28,	[sp, #688]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#39
    ble	main_413

main_193:
    movz	w0,	#39
    movz	fp,	#580
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#588
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#41
    ble	main_413

main_197:
    movz	w0,	#41
    movz	fp,	#596
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w28,	#42
    movz	fp,	#604
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#43
    ble	main_413

main_201:
    movz	w28,	#43
    movz	fp,	#612
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    movz	fp,	#620
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#45
    ble	main_413

main_205:
    movz	w28,	#45
    mov	w0,	w28
    ldr	x28,	[sp, #696]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w0,	#46
    ldr	x28,	[sp, #704]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#47
    ble	main_413

main_209:
    movz	w28,	#47
    mov	w0,	w28
    ldr	x28,	[sp, #712]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w0,	#48
    mov	w28,	w0
    ldr	x0,	[sp, #720]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    mov	w28,	w0
    ldr	x0,	[sp, #728]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w0,	#50
    mov	w28,	w0
    ldr	x0,	[sp, #736]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#51
    ble	main_413

main_217:
    movz	w28,	#51
    mov	w0,	w28
    ldr	x28,	[sp, #744]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w28,	#52
    ldr	x0,	[sp, #760]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    mov	w28,	w0
    ldr	x0,	[sp, #768]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w28,	#54
    mov	w0,	w28
    ldr	x28,	[sp, #752]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w0,	#55
    ldr	x28,	[sp, #416]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#56
    ble	main_413

main_227:
    movz	w28,	#56
    mov	w0,	w28
    ldr	x28,	[sp, #424]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w0,	#57
    mov	w28,	w0
    ldr	x0,	[sp, #432]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    mov	w28,	w0
    ldr	x0,	[sp, #776]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w0,	#59
    mov	w28,	w0
    ldr	x0,	[sp, #784]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#60
    ble	main_413

main_235:
    movz	w28,	#60
    ldr	x0,	[sp, #792]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w28,	#61
    mov	w0,	w28
    ldr	x28,	[sp, #800]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    mov	w28,	w0
    ldr	x0,	[sp, #808]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w28,	#63
    mov	w0,	w28
    ldr	x28,	[sp, #816]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#64
    ble	main_413

main_243:
    movz	w0,	#64
    ldr	x28,	[sp, #824]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w28,	#65
    mov	w0,	w28
    ldr	x28,	[sp, #832]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#66
    ble	main_413

main_247:
    movz	w0,	#66
    ldr	x28,	[sp, #840]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    mov	w28,	w0
    ldr	x0,	[sp, #848]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#68
    ble	main_413

main_251:
    movz	w0,	#68
    ldr	x28,	[sp, #856]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w28,	#69
    ldr	x0,	[sp, #864]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#70
    ble	main_413

main_255:
    movz	w28,	#70
    mov	w0,	w28
    ldr	x28,	[sp, #872]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    mov	w28,	w0
    ldr	x0,	[sp, #880]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#72
    ble	main_413

main_259:
    movz	w28,	#72
    mov	w0,	w28
    ldr	x28,	[sp, #888]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w0,	#73
    ldr	x28,	[sp, #896]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#74
    ble	main_413

main_263:
    movz	w28,	#74
    mov	w0,	w28
    ldr	x28,	[sp, #904]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w0,	#75
    mov	w28,	w0
    ldr	x0,	[sp, #912]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    ldr	x28,	[sp, #920]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w0,	#77
    ldr	x28,	[sp, #928]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#78
    ble	main_413

main_271:
    movz	w28,	#78
    ldr	x0,	[sp, #936]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w28,	#79
    mov	w0,	w28
    ldr	x28,	[sp, #944]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    ldr	x28,	[sp, #952]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w28,	#81
    ldr	x0,	[sp, #960]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#82
    ble	main_413

main_279:
    movz	w0,	#82
    ldr	x28,	[sp, #968]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w28,	#83
    mov	w0,	w28
    ldr	x28,	[sp, #976]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w0,	#84
    mov	w28,	w0
    ldr	x0,	[sp, #984]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    mov	w28,	w0
    ldr	x0,	[sp, #992]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w0,	#86
    ldr	x28,	[sp, #1000]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#87
    ble	main_413

main_289:
    movz	w28,	#87
    ldr	x0,	[sp, #1008]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w28,	#88
    mov	w0,	w28
    ldr	x28,	[sp, #1016]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    mov	w28,	w0
    ldr	x0,	[sp, #1024]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w28,	#90
    mov	w0,	w28
    ldr	x28,	[sp, #1032]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#91
    ble	main_413

main_297:
    movz	w0,	#91
    ldr	x28,	[sp, #1040]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w28,	#92
    mov	w0,	w28
    ldr	x28,	[sp, #1048]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#93
    ble	main_413

main_301:
    movz	w0,	#93
    mov	w28,	w0
    ldr	x0,	[sp, #1056]

    str	w28,	[x0]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    mov	w28,	w0
    ldr	x0,	[sp, #1064]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#95
    ble	main_413

main_305:
    movz	w0,	#95
    ldr	x28,	[sp, #1072]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w28,	#96
    mov	w0,	w28
    ldr	x28,	[sp, #1080]

    str	w0,	[x28]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#97
    ble	main_413

main_309:
    movz	w28,	#97
    mov	w0,	w28
    ldr	x28,	[sp, #1088]

    str	w0,	[x28]

    ldr	w0,	[sp, #1124]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    mov	w28,	w0
    ldr	x0,	[sp, #1096]

    str	w28,	[x0]

    ldr	w28,	[sp, #1124]

    cmp	w28,	#99
    ble	main_413

main_313:
    movz	w28,	#99
    mov	w0,	w28
    ldr	x28,	[sp, #1104]

    str	w0,	[x28]


main_413:
    ldr	w28,	[sp, #1112]

    add	w0,	w28,	#1
    movz	w28,	#0
    str	w0,	[sp, #448]

    ldr	w0,	[sp, #1116]

    str	w0,	[sp, #552]

    str	w28,	[sp, #576]


main_415:
    ldr	w0,	[sp, #576]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w28,	[sp, #576]

    lsl	w0,	w28,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w28,	[sp, #552]

    add	w28,	w0,	w28
    ldr	w0,	[sp, #576]

    add	w0,	w0,	#1
    str	w0,	[sp, #628]

    mov	w0,	w28
    str	w0,	[sp, #552]

    ldr	w28,	[sp, #628]

    str	w28,	[sp, #576]

    b	main_415

main_424:
    movz	w0,	#65535
    ldr	w28,	[sp, #552]

    sdiv	w28,	w28,	w0
    str	w28,	[sp, #572]

    ldr	w0,	[sp, #572]

    lsl	w28,	w0,	#16
    ldr	w0,	[sp, #572]

    sub	w28,	w28,	w0,	lsl #0
    ldr	w0,	[sp, #552]

    ldr	w27,	[sp, #448]

    sub	w0,	w0,	w28
    str	w27,	[sp, #2780]

    ldr	w7,	[sp, #1120]

    str	w7,	[sp, #540]

    ldr	w8,	[sp, #540]

    ldr	w28,	[sp, #2780]

    cmp	w28,	w8
    bge	main_429

main_112:
    str	w0,	[sp, #1116]

    ldr	w0,	[sp, #448]

    str	w0,	[sp, #1112]

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
    
    add	sp, sp, #3168
    ret


