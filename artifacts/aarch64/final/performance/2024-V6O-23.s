.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#4208
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1268]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1272]

    mov	w0,	w26

main_4:
    cmp	w0,	#100
    bge	main_10

main_7:
    lsl	w9,	w0,	#2
    movz	w26,	#0
    mov	x2,	x9
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    str	w26,	[x2]

    add	w26,	w0,	#1
    mov	w0,	w26
    b	main_4

main_10:
    movz	w27,	#0
    ldr	w15,	[sp, #1268]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x17,	sp,	#20
    movz	fp,	#1588
    add	x24,	sp,	#24
    add	x20,	sp,	#28
    add	x2,	sp,	#32
    add	x26,	sp,	#36
    add	x5,	sp,	#40
    add	x8,	sp,	#44
    add	x6,	sp,	#48
    add	x18,	sp,	#52
    add	x15,	sp,	#56
    add	x7,	sp,	#60
    add	x16,	sp,	#64
    add	x4,	sp,	#68
    add	x1,	sp,	#72
    add	x27,	sp,	#76
    add	x11,	sp,	#80
    add	x23,	sp,	#84
    add	x0,	sp,	#88
    add	x19,	sp,	#92
    add	x22,	sp,	#96
    add	x13,	sp,	#100
    add	x10,	sp,	#104
    add	x28,	sp,	#108
    add	x25,	sp,	#112
    add	x14,	sp,	#116
    add	x3,	sp,	#120
    add	x9,	sp,	#124
    add	x21,	sp,	#128
    str	x17,	[sp, fp]

    movz	fp,	#1276
    str	x24,	[sp, fp]

    movz	fp,	#1596
    str	x20,	[sp, fp]

    movz	fp,	#1548
    str	x2,	[sp, fp]

    movz	fp,	#1612
    str	x26,	[sp, fp]

    movz	fp,	#1556
    str	x5,	[sp, fp]

    movz	fp,	#1564
    str	x8,	[sp, fp]

    movz	fp,	#1636
    str	x6,	[sp, fp]

    movz	fp,	#1308
    str	x18,	[sp, #736]

    str	x15,	[sp, #728]

    str	x7,	[sp, fp]

    add	x7,	sp,	#132
    movz	fp,	#1668
    str	x16,	[sp, fp]

    movz	fp,	#1300
    str	x4,	[sp, fp]

    movz	fp,	#1292
    str	x1,	[sp, fp]

    movz	fp,	#1284
    str	x27,	[sp, fp]

    movz	fp,	#1572
    str	x11,	[sp, fp]

    movz	fp,	#1604
    str	x23,	[sp, fp]

    movz	fp,	#1620
    str	x0,	[sp, fp]

    movz	fp,	#1676
    str	x19,	[sp, fp]

    movz	fp,	#1684
    str	x22,	[sp, fp]

    movz	fp,	#1660
    str	x13,	[sp, fp]

    movz	fp,	#1652
    str	x10,	[sp, fp]

    movz	fp,	#1700
    str	x28,	[sp, fp]

    movz	fp,	#1692
    str	x25,	[sp, fp]

    movz	fp,	#1580
    str	x14,	[sp, fp]

    movz	fp,	#1628
    str	x3,	[sp, fp]

    movz	fp,	#1644
    str	x9,	[sp, fp]

    movz	fp,	#436
    str	x21,	[sp, #744]

    str	x7,	[sp, #488]

    add	x7,	sp,	#136
    str	x7,	[sp, #472]

    add	x7,	sp,	#140
    str	x7,	[sp, fp]

    movz	fp,	#852
    add	x7,	sp,	#144
    str	x7,	[sp, #496]

    add	x7,	sp,	#148
    str	x7,	[sp, #504]

    add	x7,	sp,	#152
    str	x7,	[sp, #512]

    add	x7,	sp,	#156
    str	x7,	[sp, #824]

    add	x7,	sp,	#160
    str	x7,	[sp, #832]

    add	x7,	sp,	#164
    str	x7,	[sp, #840]

    add	x7,	sp,	#168
    str	x7,	[sp, fp]

    movz	fp,	#860
    add	x7,	sp,	#172
    str	x7,	[sp, fp]

    movz	fp,	#868
    add	x7,	sp,	#176
    str	x7,	[sp, fp]

    movz	fp,	#876
    add	x7,	sp,	#180
    str	x7,	[sp, fp]

    movz	fp,	#884
    add	x7,	sp,	#184
    str	x7,	[sp, fp]

    movz	fp,	#892
    add	x7,	sp,	#188
    str	x7,	[sp, fp]

    movz	fp,	#900
    add	x7,	sp,	#192
    str	x7,	[sp, #752]

    add	x7,	sp,	#196
    str	x7,	[sp, #760]

    add	x7,	sp,	#200
    str	x7,	[sp, #768]

    add	x7,	sp,	#204
    str	x7,	[sp, #776]

    add	x7,	sp,	#208
    str	x7,	[sp, #784]

    add	x7,	sp,	#212
    str	x7,	[sp, #792]

    add	x7,	sp,	#216
    str	x7,	[sp, #800]

    add	x7,	sp,	#220
    str	x7,	[sp, #808]

    add	x7,	sp,	#224
    str	x7,	[sp, #816]

    add	x7,	sp,	#228
    str	x7,	[sp, fp]

    movz	fp,	#908
    add	x7,	sp,	#232
    str	x7,	[sp, fp]

    movz	fp,	#916
    add	x7,	sp,	#236
    str	x7,	[sp, #416]

    add	x7,	sp,	#240
    str	x7,	[sp, #424]

    add	x7,	sp,	#244
    str	x7,	[sp, fp]

    movz	fp,	#924
    add	x7,	sp,	#248
    str	x7,	[sp, fp]

    movz	fp,	#932
    add	x7,	sp,	#252
    str	x7,	[sp, fp]

    movz	fp,	#940
    add	x7,	sp,	#256
    str	x7,	[sp, fp]

    movz	fp,	#948
    add	x7,	sp,	#260
    str	x7,	[sp, fp]

    movz	fp,	#956
    add	x7,	sp,	#264
    str	x7,	[sp, fp]

    movz	fp,	#964
    add	x7,	sp,	#268
    str	x7,	[sp, fp]

    movz	fp,	#972
    add	x7,	sp,	#272
    str	x7,	[sp, fp]

    movz	fp,	#980
    add	x7,	sp,	#276
    str	x7,	[sp, fp]

    movz	fp,	#988
    add	x7,	sp,	#280
    str	x7,	[sp, fp]

    movz	fp,	#996
    add	x7,	sp,	#284
    str	x7,	[sp, fp]

    movz	fp,	#1004
    add	x7,	sp,	#288
    str	x7,	[sp, fp]

    movz	fp,	#1012
    add	x7,	sp,	#292
    str	x7,	[sp, fp]

    movz	fp,	#1020
    add	x7,	sp,	#296
    str	x7,	[sp, fp]

    movz	fp,	#1028
    add	x7,	sp,	#300
    str	x7,	[sp, fp]

    movz	fp,	#1036
    add	x7,	sp,	#304
    str	x7,	[sp, fp]

    movz	fp,	#1044
    add	x7,	sp,	#308
    str	x7,	[sp, fp]

    movz	fp,	#1052
    add	x7,	sp,	#312
    str	x7,	[sp, fp]

    movz	fp,	#1060
    add	x7,	sp,	#316
    str	x7,	[sp, fp]

    movz	fp,	#1068
    add	x7,	sp,	#320
    str	x7,	[sp, fp]

    movz	fp,	#1076
    add	x7,	sp,	#324
    str	x7,	[sp, fp]

    movz	fp,	#1084
    add	x7,	sp,	#328
    str	x7,	[sp, fp]

    movz	fp,	#1092
    add	x7,	sp,	#332
    str	x7,	[sp, fp]

    movz	fp,	#1100
    add	x7,	sp,	#336
    str	x7,	[sp, fp]

    movz	fp,	#1108
    add	x7,	sp,	#340
    str	x7,	[sp, fp]

    movz	fp,	#1116
    add	x7,	sp,	#344
    str	x7,	[sp, fp]

    movz	fp,	#1124
    add	x7,	sp,	#348
    str	x7,	[sp, fp]

    movz	fp,	#1132
    add	x7,	sp,	#352
    str	x7,	[sp, fp]

    movz	fp,	#1140
    add	x7,	sp,	#356
    str	x7,	[sp, fp]

    movz	fp,	#1148
    add	x7,	sp,	#360
    str	x7,	[sp, fp]

    movz	fp,	#1156
    add	x7,	sp,	#364
    str	x7,	[sp, fp]

    movz	fp,	#1164
    add	x7,	sp,	#368
    str	x7,	[sp, fp]

    movz	fp,	#1172
    add	x7,	sp,	#372
    str	x7,	[sp, fp]

    movz	fp,	#1180
    add	x7,	sp,	#376
    str	x7,	[sp, fp]

    movz	fp,	#1188
    add	x7,	sp,	#380
    str	x7,	[sp, fp]

    movz	fp,	#1196
    add	x7,	sp,	#384
    str	x7,	[sp, fp]

    movz	fp,	#1204
    add	x7,	sp,	#388
    str	x7,	[sp, fp]

    movz	fp,	#1212
    add	x7,	sp,	#392
    str	x7,	[sp, fp]

    movz	fp,	#1220
    add	x7,	sp,	#396
    str	x7,	[sp, fp]

    movz	fp,	#1228
    add	x7,	sp,	#400
    str	x7,	[sp, fp]

    movz	fp,	#1236
    add	x7,	sp,	#404
    str	x7,	[sp, fp]

    movz	fp,	#1244
    add	x7,	sp,	#408
    str	x7,	[sp, fp]

    movz	fp,	#1252
    add	x7,	sp,	#412
    str	x7,	[sp, fp]

    movz	w7,	#0
    str	w7,	[sp, #1264]

    movz	w7,	#0
    str	w7,	[sp, #1260]


main_113:
    ldr	w7,	[sp, #1272]

    cmp	w7,	#1
    ble	main_413

main_117:
    movz	w7,	#1
    movz	fp,	#1588
    ldr	x14,	[sp, fp]

    str	w7,	[x14]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#2
    ble	main_413

main_119:
    movz	w7,	#2
    movz	fp,	#1276
    ldr	x19,	[sp, fp]

    str	w7,	[x19]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#3
    ble	main_413

main_121:
    movz	w7,	#3
    movz	fp,	#1596
    ldr	x17,	[sp, fp]

    str	w7,	[x17]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#4
    ble	main_413

main_123:
    movz	w7,	#4
    movz	fp,	#1548
    ldr	x27,	[sp, fp]

    str	w7,	[x27]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#5
    ble	main_413

main_125:
    movz	w7,	#5
    movz	fp,	#1612
    ldr	x23,	[sp, fp]

    str	w7,	[x23]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#6
    ble	main_413

main_127:
    movz	w7,	#6
    movz	fp,	#1556
    ldr	x0,	[sp, fp]

    str	w7,	[x0]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#7
    ble	main_413

main_129:
    movz	w7,	#7
    movz	fp,	#1564
    ldr	x3,	[sp, fp]

    str	w7,	[x3]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#8
    ble	main_413

main_131:
    movz	w7,	#8
    movz	fp,	#1636
    ldr	x2,	[sp, fp]

    str	w7,	[x2]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#9
    ble	main_413

main_133:
    movz	w7,	#9
    ldr	x13,	[sp, #736]

    str	w7,	[x13]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#10
    ble	main_413

main_135:
    movz	w7,	#10
    ldr	x10,	[sp, #728]

    str	w7,	[x10]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#11
    ble	main_413

main_137:
    movz	w7,	#11
    movz	fp,	#1308
    ldr	x1,	[sp, fp]

    str	w7,	[x1]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#12
    ble	main_413

main_139:
    movz	w7,	#12
    movz	fp,	#1668
    ldr	x12,	[sp, fp]

    str	w7,	[x12]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#13
    ble	main_413

main_141:
    movz	w7,	#13
    movz	fp,	#1300
    ldr	x28,	[sp, fp]

    str	w7,	[x28]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#14
    ble	main_413

main_143:
    movz	w7,	#14
    movz	fp,	#1292
    ldr	x25,	[sp, fp]

    str	w7,	[x25]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#15
    ble	main_413

main_145:
    movz	w7,	#15
    movz	fp,	#1284
    ldr	x22,	[sp, fp]

    str	w7,	[x22]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#16
    ble	main_413

main_147:
    movz	w7,	#16
    movz	fp,	#1572
    ldr	x6,	[sp, fp]

    str	w7,	[x6]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#17
    ble	main_413

main_149:
    movz	w7,	#17
    movz	fp,	#1604
    ldr	x20,	[sp, fp]

    str	w7,	[x20]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#18
    ble	main_413

main_151:
    movz	w7,	#18
    movz	fp,	#1620
    ldr	x26,	[sp, fp]

    str	w7,	[x26]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#19
    ble	main_413

main_153:
    movz	w7,	#19
    movz	fp,	#1676
    ldr	x15,	[sp, fp]

    str	w7,	[x15]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#20
    ble	main_413

main_155:
    movz	w7,	#20
    movz	fp,	#1684
    ldr	x18,	[sp, fp]

    str	w7,	[x18]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#21
    ble	main_413

main_157:
    movz	w7,	#21
    movz	fp,	#1660
    ldr	x9,	[sp, fp]

    str	w7,	[x9]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#22
    ble	main_413

main_159:
    movz	w7,	#22
    movz	fp,	#1652
    ldr	x4,	[sp, fp]

    str	w7,	[x4]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#23
    ble	main_413

main_161:
    movz	w7,	#23
    movz	fp,	#1700
    ldr	x24,	[sp, fp]

    str	w7,	[x24]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#24
    ble	main_413

main_163:
    movz	w7,	#24
    movz	fp,	#1692
    ldr	x21,	[sp, fp]

    str	w7,	[x21]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#25
    ble	main_413

main_165:
    movz	w7,	#25
    movz	fp,	#1580
    ldr	x11,	[sp, fp]

    str	w7,	[x11]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#26
    ble	main_413

main_167:
    movz	w7,	#26
    movz	fp,	#1628
    ldr	x0,	[sp, fp]

    str	w7,	[x0]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#27
    ble	main_413

main_169:
    movz	w7,	#27
    movz	fp,	#1644
    ldr	x5,	[sp, fp]

    str	w7,	[x5]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#28
    ble	main_413

main_171:
    movz	w7,	#28
    ldr	x16,	[sp, #744]

    str	w7,	[x16]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#29
    ble	main_413

main_173:
    movz	w7,	#29
    ldr	x21,	[sp, #488]

    str	x21,	[sp, #2984]

    ldr	x22,	[sp, #2984]

    str	w7,	[x22]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#30
    ble	main_413

main_175:
    movz	w7,	#30
    ldr	x24,	[sp, #472]

    str	x24,	[sp, #2992]

    ldr	x25,	[sp, #2992]

    str	w7,	[x25]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#31
    ble	main_413

main_177:
    movz	w7,	#31
    movz	fp,	#436
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3000]

    ldr	x28,	[sp, #3000]

    str	w7,	[x28]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#32
    ble	main_413

main_179:
    movz	w7,	#32
    ldr	x1,	[sp, #496]

    mov	w9,	w7
    str	x1,	[sp, #3008]

    ldr	x2,	[sp, #3008]

    str	w9,	[x2]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#33
    ble	main_413

main_181:
    movz	w7,	#33
    ldr	x4,	[sp, #504]

    movz	fp,	#2812
    mov	w9,	w7
    str	x4,	[sp, fp]

    movz	fp,	#2812
    ldr	x5,	[sp, fp]

    str	w9,	[x5]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#34
    ble	main_413

main_183:
    movz	w7,	#34
    ldr	x4,	[sp, #512]

    movz	fp,	#2124
    mov	w9,	w7
    str	x4,	[sp, fp]

    movz	fp,	#2124
    ldr	x5,	[sp, fp]

    str	w9,	[x5]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#35
    ble	main_413

main_185:
    movz	w7,	#35
    ldr	x1,	[sp, #824]

    movz	fp,	#1908
    mov	w9,	w7
    str	x1,	[sp, fp]

    movz	fp,	#1908
    ldr	x2,	[sp, fp]

    str	w9,	[x2]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#36
    ble	main_413

main_187:
    movz	w7,	#36
    ldr	x27,	[sp, #832]

    movz	fp,	#1900
    str	x27,	[sp, fp]

    movz	fp,	#1900
    ldr	x28,	[sp, fp]

    str	w7,	[x28]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#37
    ble	main_413

main_189:
    movz	w7,	#37
    ldr	x24,	[sp, #840]

    movz	fp,	#1892
    str	x24,	[sp, fp]

    movz	fp,	#1892
    ldr	x25,	[sp, fp]

    str	w7,	[x25]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#38
    ble	main_413

main_191:
    movz	w7,	#38
    movz	fp,	#852
    ldr	x21,	[sp, fp]

    movz	fp,	#1884
    str	x21,	[sp, fp]

    movz	fp,	#1884
    ldr	x22,	[sp, fp]

    str	w7,	[x22]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#39
    ble	main_413

main_193:
    movz	w7,	#39
    movz	fp,	#860
    ldr	x18,	[sp, fp]

    movz	fp,	#1876
    str	x18,	[sp, fp]

    movz	fp,	#1876
    ldr	x19,	[sp, fp]

    str	w7,	[x19]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#40
    ble	main_413

main_195:
    movz	w7,	#40
    movz	fp,	#868
    ldr	x15,	[sp, fp]

    movz	fp,	#1868
    str	x15,	[sp, fp]

    movz	fp,	#1868
    ldr	x16,	[sp, fp]

    str	w7,	[x16]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#41
    ble	main_413

main_197:
    movz	w7,	#41
    movz	fp,	#876
    ldr	x12,	[sp, fp]

    movz	fp,	#1860
    str	x12,	[sp, fp]

    movz	fp,	#1860
    ldr	x13,	[sp, fp]

    str	w7,	[x13]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#42
    ble	main_413

main_199:
    movz	w7,	#42
    movz	fp,	#884
    ldr	x9,	[sp, fp]

    movz	fp,	#1852
    str	x9,	[sp, fp]

    movz	fp,	#1852
    ldr	x10,	[sp, fp]

    str	w7,	[x10]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#43
    ble	main_413

main_201:
    movz	w7,	#43
    movz	fp,	#892
    mov	w9,	w7
    ldr	x6,	[sp, fp]

    movz	fp,	#1844
    str	x6,	[sp, fp]

    movz	fp,	#1844
    ldr	x7,	[sp, fp]

    str	w9,	[x7]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#44
    ble	main_413

main_203:
    movz	w7,	#44
    ldr	x3,	[sp, #752]

    movz	fp,	#1836
    mov	w9,	w7
    str	x3,	[sp, fp]

    movz	fp,	#1836
    ldr	x4,	[sp, fp]

    str	w9,	[x4]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#45
    ble	main_413

main_205:
    movz	w7,	#45
    ldr	x0,	[sp, #760]

    movz	fp,	#1828
    mov	w9,	w7
    str	x0,	[sp, fp]

    movz	fp,	#1828
    ldr	x1,	[sp, fp]

    str	w9,	[x1]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#46
    ble	main_413

main_207:
    movz	w7,	#46
    ldr	x26,	[sp, #768]

    movz	fp,	#1820
    str	x26,	[sp, fp]

    movz	fp,	#1820
    ldr	x27,	[sp, fp]

    str	w7,	[x27]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#47
    ble	main_413

main_209:
    movz	w7,	#47
    ldr	x23,	[sp, #776]

    movz	fp,	#1812
    str	x23,	[sp, fp]

    movz	fp,	#1812
    ldr	x24,	[sp, fp]

    str	w7,	[x24]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#48
    ble	main_413

main_211:
    movz	w7,	#48
    ldr	x20,	[sp, #784]

    movz	fp,	#1804
    str	x20,	[sp, fp]

    movz	fp,	#1804
    ldr	x21,	[sp, fp]

    str	w7,	[x21]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#49
    ble	main_413

main_213:
    movz	w7,	#49
    ldr	x17,	[sp, #792]

    movz	fp,	#1796
    str	x17,	[sp, fp]

    movz	fp,	#1796
    ldr	x18,	[sp, fp]

    str	w7,	[x18]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#50
    ble	main_413

main_215:
    movz	w7,	#50
    ldr	x14,	[sp, #800]

    movz	fp,	#1788
    str	x14,	[sp, fp]

    movz	fp,	#1788
    ldr	x15,	[sp, fp]

    str	w7,	[x15]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#51
    ble	main_413

main_217:
    movz	w7,	#51
    ldr	x11,	[sp, #808]

    movz	fp,	#1780
    str	x11,	[sp, fp]

    movz	fp,	#1780
    ldr	x12,	[sp, fp]

    str	w7,	[x12]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#52
    ble	main_413

main_219:
    movz	w7,	#52
    ldr	x8,	[sp, #816]

    str	x8,	[sp, #3136]

    ldr	x9,	[sp, #3136]

    str	w7,	[x9]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#53
    ble	main_413

main_221:
    movz	w7,	#53
    movz	fp,	#900
    mov	w9,	w7
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #3128]

    ldr	x6,	[sp, #3128]

    str	w9,	[x6]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#54
    ble	main_413

main_223:
    movz	w7,	#54
    movz	fp,	#908
    mov	w9,	w7
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #3120]

    ldr	x3,	[sp, #3120]

    str	w9,	[x3]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#55
    ble	main_413

main_225:
    movz	w7,	#55
    ldr	x28,	[sp, #416]

    mov	w8,	w7
    str	x28,	[sp, #3112]

    ldr	x0,	[sp, #3112]

    str	w8,	[x0]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#56
    ble	main_413

main_227:
    movz	w7,	#56
    ldr	x25,	[sp, #424]

    str	x25,	[sp, #3104]

    ldr	x26,	[sp, #3104]

    str	w7,	[x26]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#57
    ble	main_413

main_229:
    movz	w7,	#57
    movz	fp,	#916
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #3096]

    ldr	x23,	[sp, #3096]

    str	w7,	[x23]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#58
    ble	main_413

main_231:
    movz	w7,	#58
    movz	fp,	#924
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3088]

    ldr	x20,	[sp, #3088]

    str	w7,	[x20]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#59
    ble	main_413

main_233:
    movz	w7,	#59
    movz	fp,	#932
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3080]

    ldr	x17,	[sp, #3080]

    str	w7,	[x17]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#60
    ble	main_413

main_235:
    movz	w7,	#60
    movz	fp,	#940
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3072]

    ldr	x14,	[sp, #3072]

    str	w7,	[x14]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#61
    ble	main_413

main_237:
    movz	w7,	#61
    movz	fp,	#948
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #3064]

    ldr	x11,	[sp, #3064]

    str	w7,	[x11]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#62
    ble	main_413

main_239:
    movz	w7,	#62
    movz	fp,	#956
    mov	w9,	w7
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #3056]

    ldr	x8,	[sp, #3056]

    str	w9,	[x8]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#63
    ble	main_413

main_241:
    movz	w7,	#63
    movz	fp,	#964
    mov	w9,	w7
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3048]

    ldr	x5,	[sp, #3048]

    str	w9,	[x5]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#64
    ble	main_413

main_243:
    movz	w7,	#64
    movz	fp,	#972
    mov	w9,	w7
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3040]

    ldr	x2,	[sp, #3040]

    str	w9,	[x2]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#65
    ble	main_413

main_245:
    movz	w7,	#65
    movz	fp,	#980
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3032]

    ldr	x28,	[sp, #3032]

    str	w7,	[x28]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#66
    ble	main_413

main_247:
    movz	w7,	#66
    movz	fp,	#988
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3024]

    ldr	x25,	[sp, #3024]

    str	w7,	[x25]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#67
    ble	main_413

main_249:
    movz	w7,	#67
    movz	fp,	#996
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3016]

    ldr	x22,	[sp, #3016]

    str	w7,	[x22]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#68
    ble	main_413

main_251:
    movz	w7,	#68
    movz	fp,	#1004
    ldr	x18,	[sp, fp]

    movz	fp,	#2108
    str	x18,	[sp, fp]

    movz	fp,	#2108
    ldr	x19,	[sp, fp]

    str	w7,	[x19]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#69
    ble	main_413

main_253:
    movz	w7,	#69
    movz	fp,	#1012
    ldr	x15,	[sp, fp]

    movz	fp,	#2100
    str	x15,	[sp, fp]

    movz	fp,	#2100
    ldr	x16,	[sp, fp]

    str	w7,	[x16]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#70
    ble	main_413

main_255:
    movz	w7,	#70
    movz	fp,	#1020
    ldr	x12,	[sp, fp]

    movz	fp,	#2092
    str	x12,	[sp, fp]

    movz	fp,	#2092
    ldr	x13,	[sp, fp]

    str	w7,	[x13]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#71
    ble	main_413

main_257:
    movz	w7,	#71
    movz	fp,	#1028
    ldr	x9,	[sp, fp]

    movz	fp,	#2084
    str	x9,	[sp, fp]

    movz	fp,	#2084
    ldr	x10,	[sp, fp]

    str	w7,	[x10]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#72
    ble	main_413

main_259:
    movz	w7,	#72
    movz	fp,	#1036
    mov	w9,	w7
    ldr	x6,	[sp, fp]

    movz	fp,	#2076
    str	x6,	[sp, fp]

    movz	fp,	#2076
    ldr	x7,	[sp, fp]

    str	w9,	[x7]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#73
    ble	main_413

main_261:
    movz	w7,	#73
    movz	fp,	#1044
    mov	w9,	w7
    ldr	x3,	[sp, fp]

    movz	fp,	#2068
    str	x3,	[sp, fp]

    movz	fp,	#2068
    ldr	x4,	[sp, fp]

    str	w9,	[x4]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#74
    ble	main_413

main_263:
    movz	w7,	#74
    movz	fp,	#1052
    mov	w9,	w7
    ldr	x0,	[sp, fp]

    movz	fp,	#2060
    str	x0,	[sp, fp]

    movz	fp,	#2060
    ldr	x1,	[sp, fp]

    str	w9,	[x1]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#75
    ble	main_413

main_265:
    movz	w7,	#75
    movz	fp,	#1060
    ldr	x26,	[sp, fp]

    movz	fp,	#2052
    str	x26,	[sp, fp]

    movz	fp,	#2052
    ldr	x27,	[sp, fp]

    str	w7,	[x27]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#76
    ble	main_413

main_267:
    movz	w7,	#76
    movz	fp,	#1068
    ldr	x23,	[sp, fp]

    movz	fp,	#2044
    str	x23,	[sp, fp]

    movz	fp,	#2044
    ldr	x24,	[sp, fp]

    str	w7,	[x24]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#77
    ble	main_413

main_269:
    movz	w7,	#77
    movz	fp,	#1076
    ldr	x20,	[sp, fp]

    movz	fp,	#1772
    str	x20,	[sp, fp]

    movz	fp,	#1772
    ldr	x21,	[sp, fp]

    str	w7,	[x21]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#78
    ble	main_413

main_271:
    movz	w7,	#78
    movz	fp,	#1084
    ldr	x17,	[sp, fp]

    movz	fp,	#1764
    str	x17,	[sp, fp]

    movz	fp,	#1764
    ldr	x18,	[sp, fp]

    str	w7,	[x18]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#79
    ble	main_413

main_273:
    movz	w7,	#79
    movz	fp,	#1092
    ldr	x14,	[sp, fp]

    movz	fp,	#1756
    str	x14,	[sp, fp]

    movz	fp,	#1756
    ldr	x15,	[sp, fp]

    str	w7,	[x15]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#80
    ble	main_413

main_275:
    movz	w7,	#80
    movz	fp,	#1100
    ldr	x11,	[sp, fp]

    movz	fp,	#1748
    str	x11,	[sp, fp]

    movz	fp,	#1748
    ldr	x12,	[sp, fp]

    str	w7,	[x12]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#81
    ble	main_413

main_277:
    movz	w7,	#81
    movz	fp,	#1108
    ldr	x8,	[sp, fp]

    movz	fp,	#1740
    str	x8,	[sp, fp]

    movz	fp,	#1740
    ldr	x9,	[sp, fp]

    str	w7,	[x9]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#82
    ble	main_413

main_279:
    movz	w7,	#82
    movz	fp,	#1116
    mov	w9,	w7
    ldr	x5,	[sp, fp]

    movz	fp,	#1732
    str	x5,	[sp, fp]

    movz	fp,	#1732
    ldr	x6,	[sp, fp]

    str	w9,	[x6]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#83
    ble	main_413

main_281:
    movz	w7,	#83
    movz	fp,	#1124
    mov	w9,	w7
    ldr	x2,	[sp, fp]

    movz	fp,	#1724
    str	x2,	[sp, fp]

    movz	fp,	#1724
    ldr	x3,	[sp, fp]

    str	w9,	[x3]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#84
    ble	main_413

main_283:
    movz	w7,	#84
    movz	fp,	#1132
    mov	w8,	w7
    ldr	x28,	[sp, fp]

    movz	fp,	#1716
    str	x28,	[sp, fp]

    movz	fp,	#1716
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#85
    ble	main_413

main_285:
    movz	w7,	#85
    movz	fp,	#1140
    ldr	x25,	[sp, fp]

    movz	fp,	#1708
    str	x25,	[sp, fp]

    movz	fp,	#1708
    ldr	x26,	[sp, fp]

    str	w7,	[x26]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#86
    ble	main_413

main_287:
    movz	w7,	#86
    movz	fp,	#1148
    ldr	x22,	[sp, fp]

    movz	fp,	#1996
    str	x22,	[sp, fp]

    movz	fp,	#1996
    ldr	x23,	[sp, fp]

    str	w7,	[x23]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#87
    ble	main_413

main_289:
    movz	w7,	#87
    movz	fp,	#1156
    ldr	x19,	[sp, fp]

    movz	fp,	#1988
    str	x19,	[sp, fp]

    movz	fp,	#1988
    ldr	x20,	[sp, fp]

    str	w7,	[x20]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#88
    ble	main_413

main_291:
    movz	w7,	#88
    movz	fp,	#1164
    ldr	x16,	[sp, fp]

    movz	fp,	#1980
    str	x16,	[sp, fp]

    movz	fp,	#1980
    ldr	x17,	[sp, fp]

    str	w7,	[x17]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#89
    ble	main_413

main_293:
    movz	w7,	#89
    movz	fp,	#1172
    ldr	x13,	[sp, fp]

    movz	fp,	#1972
    str	x13,	[sp, fp]

    movz	fp,	#1972
    ldr	x14,	[sp, fp]

    str	w7,	[x14]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#90
    ble	main_413

main_295:
    movz	w7,	#90
    movz	fp,	#1180
    ldr	x10,	[sp, fp]

    movz	fp,	#1964
    str	x10,	[sp, fp]

    movz	fp,	#1964
    ldr	x11,	[sp, fp]

    str	w7,	[x11]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#91
    ble	main_413

main_297:
    movz	w7,	#91
    movz	fp,	#1188
    mov	w9,	w7
    ldr	x7,	[sp, fp]

    movz	fp,	#1956
    str	x7,	[sp, fp]

    movz	fp,	#1956
    ldr	x8,	[sp, fp]

    str	w9,	[x8]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#92
    ble	main_413

main_299:
    movz	w7,	#92
    movz	fp,	#1196
    mov	w9,	w7
    ldr	x4,	[sp, fp]

    movz	fp,	#1940
    str	x4,	[sp, fp]

    movz	fp,	#1940
    ldr	x5,	[sp, fp]

    str	w9,	[x5]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#93
    ble	main_413

main_301:
    movz	w7,	#93
    movz	fp,	#1204
    mov	w9,	w7
    ldr	x1,	[sp, fp]

    movz	fp,	#1932
    str	x1,	[sp, fp]

    movz	fp,	#1932
    ldr	x2,	[sp, fp]

    str	w9,	[x2]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#94
    ble	main_413

main_303:
    movz	w7,	#94
    movz	fp,	#1212
    ldr	x27,	[sp, fp]

    movz	fp,	#1924
    str	x27,	[sp, fp]

    movz	fp,	#1924
    ldr	x28,	[sp, fp]

    str	w7,	[x28]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#95
    ble	main_413

main_305:
    movz	w7,	#95
    movz	fp,	#1220
    ldr	x24,	[sp, fp]

    movz	fp,	#1916
    str	x24,	[sp, fp]

    movz	fp,	#1916
    ldr	x25,	[sp, fp]

    str	w7,	[x25]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#96
    ble	main_413

main_307:
    movz	w7,	#96
    movz	fp,	#1228
    ldr	x21,	[sp, fp]

    movz	fp,	#460
    str	x21,	[sp, fp]

    movz	fp,	#460
    ldr	x22,	[sp, fp]

    str	w7,	[x22]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#97
    ble	main_413

main_309:
    movz	w7,	#97
    movz	fp,	#1236
    ldr	x18,	[sp, fp]

    movz	fp,	#452
    str	x18,	[sp, fp]

    movz	fp,	#452
    ldr	x19,	[sp, fp]

    str	w7,	[x19]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#98
    ble	main_413

main_311:
    movz	w7,	#98
    movz	fp,	#1244
    ldr	x15,	[sp, fp]

    movz	fp,	#1948
    str	x15,	[sp, fp]

    movz	fp,	#1948
    ldr	x16,	[sp, fp]

    str	w7,	[x16]

    ldr	w7,	[sp, #1272]

    cmp	w7,	#99
    ble	main_413

main_313:
    movz	w7,	#99
    movz	fp,	#1252
    ldr	x12,	[sp, fp]

    movz	fp,	#2116
    str	x12,	[sp, fp]

    movz	fp,	#2116
    ldr	x13,	[sp, fp]

    str	w7,	[x13]


main_413:
    ldr	w7,	[sp, #1260]

    add	w7,	w7,	#1
    str	w7,	[sp, #484]

    ldr	w7,	[sp, #1264]

    str	w7,	[sp, #468]

    movz	w7,	#0
    str	w7,	[sp, #848]


main_415:
    ldr	w7,	[sp, #848]

    cmp	w7,	#100
    bge	main_424

main_419:
    ldr	w7,	[sp, #848]

    lsl	w7,	w7,	#2
    mov	x7,	x7
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w13,	[sp, #468]

    str	w13,	[sp, #2796]

    ldr	w14,	[sp, #2796]

    ldr	w10,	[sp, #848]

    add	w9,	w7,	w14
    str	w10,	[sp, #2792]

    mov	w7,	w9
    ldr	w11,	[sp, #2792]

    add	w4,	w11,	#1
    str	w4,	[sp, #2784]

    ldr	w5,	[sp, #2784]

    str	w5,	[sp, #480]

    str	w7,	[sp, #468]

    ldr	w7,	[sp, #480]

    str	w7,	[sp, #848]

    b	main_415

main_424:
    movz	w7,	#65535
    ldr	w16,	[sp, #468]

    str	w16,	[sp, #2800]

    ldr	w17,	[sp, #2800]

    sdiv	w7,	w17,	w7
    str	w7,	[sp, #432]

    ldr	w7,	[sp, #432]

    lsl	w9,	w7,	#16
    ldr	w7,	[sp, #432]

    str	w7,	[sp, #2788]

    ldr	w8,	[sp, #2788]

    ldr	w19,	[sp, #468]

    sub	w7,	w9,	w8,	lsl #0
    str	w19,	[sp, #2804]

    ldr	w20,	[sp, #2804]

    sub	w10,	w20,	w7
    ldr	w7,	[sp, #484]

    str	w7,	[sp, #2132]

    ldr	w22,	[sp, #1268]

    str	w22,	[sp, #2808]

    ldr	w8,	[sp, #2132]

    ldr	w0,	[sp, #2808]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w7,	w10
    str	w7,	[sp, #1264]

    ldr	w7,	[sp, #484]

    str	w7,	[sp, #1260]

    b	main_113

main_428:
    mov	w0,	w10
    b	main_429

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
    
    movz	fp,	#4208
    add	sp, sp, fp
    ret


