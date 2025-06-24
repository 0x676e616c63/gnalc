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
    str	w0,	[sp, #1372]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1376]

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
    ldr	w15,	[sp, #1372]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x0,	sp,	#20
    movz	fp,	#1676
    add	x16,	sp,	#24
    add	x27,	sp,	#28
    add	x24,	sp,	#32
    add	x4,	sp,	#36
    add	x5,	sp,	#40
    add	x7,	sp,	#44
    add	x9,	sp,	#48
    add	x15,	sp,	#52
    add	x23,	sp,	#56
    add	x19,	sp,	#60
    add	x17,	sp,	#64
    add	x11,	sp,	#68
    add	x25,	sp,	#72
    add	x1,	sp,	#76
    add	x6,	sp,	#80
    add	x2,	sp,	#84
    add	x8,	sp,	#88
    add	x20,	sp,	#92
    add	x10,	sp,	#96
    add	x14,	sp,	#100
    add	x18,	sp,	#104
    add	x28,	sp,	#108
    add	x26,	sp,	#112
    add	x3,	sp,	#116
    add	x21,	sp,	#120
    add	x13,	sp,	#124
    add	x22,	sp,	#128
    str	x0,	[sp, fp]

    movz	fp,	#1500
    str	x16,	[sp, fp]

    movz	fp,	#1572
    str	x27,	[sp, fp]

    movz	fp,	#1564
    str	x24,	[sp, fp]

    movz	fp,	#1588
    str	x4,	[sp, fp]

    movz	fp,	#1612
    str	x5,	[sp, fp]

    movz	fp,	#1476
    str	x7,	[sp, fp]

    movz	fp,	#1700
    str	x9,	[sp, fp]

    movz	fp,	#1540
    str	x15,	[sp, fp]

    movz	fp,	#1660
    str	x23,	[sp, fp]

    movz	fp,	#1508
    str	x19,	[sp, fp]

    movz	fp,	#1644
    str	x17,	[sp, fp]

    movz	fp,	#1628
    str	x11,	[sp, fp]

    movz	fp,	#1524
    str	x25,	[sp, fp]

    movz	fp,	#1580
    str	x1,	[sp, fp]

    movz	fp,	#1692
    str	x6,	[sp, fp]

    movz	fp,	#1604
    str	x2,	[sp, fp]

    add	x2,	sp,	#132
    movz	fp,	#1620
    str	x8,	[sp, fp]

    movz	fp,	#1652
    str	x20,	[sp, fp]

    movz	fp,	#1484
    str	x10,	[sp, fp]

    movz	fp,	#1636
    str	x14,	[sp, fp]

    movz	fp,	#1548
    str	x18,	[sp, fp]

    movz	fp,	#1596
    str	x28,	[sp, fp]

    movz	fp,	#1668
    str	x26,	[sp, fp]

    movz	fp,	#1684
    str	x3,	[sp, fp]

    movz	fp,	#1556
    str	x21,	[sp, fp]

    movz	fp,	#1492
    str	x13,	[sp, fp]

    movz	fp,	#1516
    str	x22,	[sp, fp]

    movz	fp,	#508
    str	x2,	[sp, #496]

    add	x2,	sp,	#136
    str	x2,	[sp, fp]

    movz	fp,	#956
    add	x2,	sp,	#140
    str	x2,	[sp, fp]

    movz	fp,	#484
    add	x2,	sp,	#144
    str	x2,	[sp, #456]

    add	x2,	sp,	#148
    str	x2,	[sp, fp]

    movz	fp,	#596
    add	x2,	sp,	#152
    str	x2,	[sp, fp]

    movz	fp,	#604
    add	x2,	sp,	#156
    str	x2,	[sp, fp]

    movz	fp,	#612
    add	x2,	sp,	#160
    str	x2,	[sp, fp]

    movz	fp,	#964
    add	x2,	sp,	#164
    str	x2,	[sp, fp]

    movz	fp,	#972
    add	x2,	sp,	#168
    str	x2,	[sp, fp]

    movz	fp,	#980
    add	x2,	sp,	#172
    str	x2,	[sp, fp]

    movz	fp,	#988
    add	x2,	sp,	#176
    str	x2,	[sp, fp]

    movz	fp,	#996
    add	x2,	sp,	#180
    str	x2,	[sp, fp]

    movz	fp,	#1004
    add	x2,	sp,	#184
    str	x2,	[sp, fp]

    movz	fp,	#1012
    add	x2,	sp,	#188
    str	x2,	[sp, fp]

    movz	fp,	#516
    add	x2,	sp,	#192
    str	x2,	[sp, fp]

    movz	fp,	#524
    add	x2,	sp,	#196
    str	x2,	[sp, fp]

    movz	fp,	#532
    add	x2,	sp,	#200
    str	x2,	[sp, fp]

    movz	fp,	#540
    add	x2,	sp,	#204
    str	x2,	[sp, fp]

    movz	fp,	#548
    add	x2,	sp,	#208
    str	x2,	[sp, fp]

    movz	fp,	#556
    add	x2,	sp,	#212
    str	x2,	[sp, fp]

    movz	fp,	#564
    add	x2,	sp,	#216
    str	x2,	[sp, fp]

    movz	fp,	#572
    add	x2,	sp,	#220
    str	x2,	[sp, fp]

    movz	fp,	#588
    add	x2,	sp,	#224
    str	x2,	[sp, fp]

    movz	fp,	#1020
    add	x2,	sp,	#228
    str	x2,	[sp, fp]

    movz	fp,	#580
    add	x2,	sp,	#232
    str	x2,	[sp, fp]

    movz	fp,	#1028
    add	x2,	sp,	#236
    str	x2,	[sp, #416]

    add	x2,	sp,	#240
    str	x2,	[sp, #424]

    add	x2,	sp,	#244
    str	x2,	[sp, #432]

    add	x2,	sp,	#248
    str	x2,	[sp, fp]

    movz	fp,	#1036
    add	x2,	sp,	#252
    str	x2,	[sp, fp]

    movz	fp,	#1044
    add	x2,	sp,	#256
    str	x2,	[sp, fp]

    movz	fp,	#1052
    add	x2,	sp,	#260
    str	x2,	[sp, fp]

    movz	fp,	#1060
    add	x2,	sp,	#264
    str	x2,	[sp, fp]

    movz	fp,	#1068
    add	x2,	sp,	#268
    str	x2,	[sp, fp]

    movz	fp,	#1076
    add	x2,	sp,	#272
    str	x2,	[sp, fp]

    movz	fp,	#1084
    add	x2,	sp,	#276
    str	x2,	[sp, fp]

    movz	fp,	#1092
    add	x2,	sp,	#280
    str	x2,	[sp, fp]

    movz	fp,	#1100
    add	x2,	sp,	#284
    str	x2,	[sp, fp]

    movz	fp,	#1108
    add	x2,	sp,	#288
    str	x2,	[sp, fp]

    movz	fp,	#1116
    add	x2,	sp,	#292
    str	x2,	[sp, fp]

    movz	fp,	#1124
    add	x2,	sp,	#296
    str	x2,	[sp, fp]

    movz	fp,	#1132
    add	x2,	sp,	#300
    str	x2,	[sp, fp]

    movz	fp,	#1140
    add	x2,	sp,	#304
    str	x2,	[sp, fp]

    movz	fp,	#1148
    add	x2,	sp,	#308
    str	x2,	[sp, fp]

    movz	fp,	#1156
    add	x2,	sp,	#312
    str	x2,	[sp, fp]

    movz	fp,	#1164
    add	x2,	sp,	#316
    str	x2,	[sp, fp]

    movz	fp,	#1172
    add	x2,	sp,	#320
    str	x2,	[sp, fp]

    movz	fp,	#1180
    add	x2,	sp,	#324
    str	x2,	[sp, fp]

    movz	fp,	#1188
    add	x2,	sp,	#328
    str	x2,	[sp, fp]

    movz	fp,	#1196
    add	x2,	sp,	#332
    str	x2,	[sp, fp]

    movz	fp,	#1204
    add	x2,	sp,	#336
    str	x2,	[sp, fp]

    movz	fp,	#1212
    add	x2,	sp,	#340
    str	x2,	[sp, fp]

    movz	fp,	#1220
    add	x2,	sp,	#344
    str	x2,	[sp, fp]

    movz	fp,	#1228
    add	x2,	sp,	#348
    str	x2,	[sp, fp]

    movz	fp,	#1236
    add	x2,	sp,	#352
    str	x2,	[sp, fp]

    movz	fp,	#1244
    add	x2,	sp,	#356
    str	x2,	[sp, fp]

    movz	fp,	#1252
    add	x2,	sp,	#360
    str	x2,	[sp, fp]

    movz	fp,	#1260
    add	x2,	sp,	#364
    str	x2,	[sp, fp]

    movz	fp,	#1268
    add	x2,	sp,	#368
    str	x2,	[sp, fp]

    movz	fp,	#1276
    add	x2,	sp,	#372
    str	x2,	[sp, fp]

    movz	fp,	#1284
    add	x2,	sp,	#376
    str	x2,	[sp, fp]

    movz	fp,	#1292
    add	x2,	sp,	#380
    str	x2,	[sp, fp]

    movz	fp,	#1300
    add	x2,	sp,	#384
    str	x2,	[sp, fp]

    movz	fp,	#1308
    add	x2,	sp,	#388
    str	x2,	[sp, fp]

    movz	fp,	#1316
    add	x2,	sp,	#392
    str	x2,	[sp, fp]

    movz	fp,	#1324
    add	x2,	sp,	#396
    str	x2,	[sp, fp]

    movz	fp,	#1332
    add	x2,	sp,	#400
    str	x2,	[sp, fp]

    movz	fp,	#1340
    add	x2,	sp,	#404
    str	x2,	[sp, fp]

    movz	fp,	#1348
    add	x2,	sp,	#408
    str	x2,	[sp, fp]

    movz	fp,	#1356
    add	x2,	sp,	#412
    str	x2,	[sp, fp]

    movz	w2,	#0
    str	w2,	[sp, #1368]

    movz	w2,	#0
    str	w2,	[sp, #1364]


main_113:
    ldr	w2,	[sp, #1376]

    cmp	w2,	#1
    ble	main_413

main_117:
    movz	w2,	#1
    movz	fp,	#1676
    ldr	x26,	[sp, fp]

    str	w2,	[x26]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#2
    ble	main_413

main_119:
    movz	w2,	#2
    movz	fp,	#1500
    ldr	x12,	[sp, fp]

    str	w2,	[x12]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#3
    ble	main_413

main_121:
    movz	w2,	#3
    movz	fp,	#1572
    ldr	x22,	[sp, fp]

    str	w2,	[x22]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#4
    ble	main_413

main_123:
    movz	w2,	#4
    movz	fp,	#1564
    ldr	x19,	[sp, fp]

    str	w2,	[x19]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#5
    ble	main_413

main_125:
    movz	w2,	#5
    movz	fp,	#1588
    ldr	x28,	[sp, fp]

    str	w2,	[x28]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#6
    ble	main_413

main_127:
    movz	w2,	#6
    movz	fp,	#1612
    ldr	x0,	[sp, fp]

    str	w2,	[x0]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#7
    ble	main_413

main_129:
    movz	w2,	#7
    movz	fp,	#1476
    ldr	x1,	[sp, fp]

    str	w2,	[x1]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#8
    ble	main_413

main_131:
    movz	w2,	#8
    movz	fp,	#1700
    ldr	x7,	[sp, fp]

    str	w2,	[x7]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#9
    ble	main_413

main_133:
    movz	w2,	#9
    movz	fp,	#1540
    ldr	x10,	[sp, fp]

    str	w2,	[x10]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#10
    ble	main_413

main_135:
    movz	w2,	#10
    movz	fp,	#1660
    ldr	x20,	[sp, fp]

    str	w2,	[x20]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#11
    ble	main_413

main_137:
    movz	w2,	#11
    movz	fp,	#1508
    ldr	x15,	[sp, fp]

    str	w2,	[x15]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#12
    ble	main_413

main_139:
    movz	w2,	#12
    movz	fp,	#1644
    ldr	x14,	[sp, fp]

    str	w2,	[x14]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#13
    ble	main_413

main_141:
    movz	w2,	#13
    movz	fp,	#1628
    ldr	x8,	[sp, fp]

    str	w2,	[x8]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#14
    ble	main_413

main_143:
    movz	w2,	#14
    movz	fp,	#1524
    ldr	x21,	[sp, fp]

    str	w2,	[x21]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#15
    ble	main_413

main_145:
    movz	w2,	#15
    movz	fp,	#1580
    ldr	x25,	[sp, fp]

    str	w2,	[x25]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#16
    ble	main_413

main_147:
    movz	w2,	#16
    movz	fp,	#1692
    ldr	x4,	[sp, fp]

    str	w2,	[x4]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#17
    ble	main_413

main_149:
    movz	w2,	#17
    movz	fp,	#1604
    ldr	x27,	[sp, fp]

    str	w2,	[x27]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#18
    ble	main_413

main_151:
    movz	w2,	#18
    movz	fp,	#1620
    ldr	x5,	[sp, fp]

    str	w2,	[x5]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#19
    ble	main_413

main_153:
    movz	w2,	#19
    movz	fp,	#1652
    ldr	x17,	[sp, fp]

    str	w2,	[x17]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#20
    ble	main_413

main_155:
    movz	w2,	#20
    movz	fp,	#1484
    ldr	x6,	[sp, fp]

    str	w2,	[x6]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#21
    ble	main_413

main_157:
    movz	w2,	#21
    movz	fp,	#1636
    ldr	x11,	[sp, fp]

    str	w2,	[x11]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#22
    ble	main_413

main_159:
    movz	w2,	#22
    movz	fp,	#1548
    ldr	x13,	[sp, fp]

    str	w2,	[x13]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#23
    ble	main_413

main_161:
    movz	w2,	#23
    movz	fp,	#1596
    ldr	x24,	[sp, fp]

    str	w2,	[x24]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#24
    ble	main_413

main_163:
    movz	w2,	#24
    movz	fp,	#1668
    ldr	x23,	[sp, fp]

    str	w2,	[x23]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#25
    ble	main_413

main_165:
    movz	w2,	#25
    movz	fp,	#1684
    ldr	x0,	[sp, fp]

    str	w2,	[x0]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#26
    ble	main_413

main_167:
    movz	w2,	#26
    movz	fp,	#1556
    ldr	x16,	[sp, fp]

    str	w2,	[x16]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#27
    ble	main_413

main_169:
    movz	w2,	#27
    movz	fp,	#1492
    ldr	x9,	[sp, fp]

    str	w2,	[x9]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#28
    ble	main_413

main_171:
    movz	w2,	#28
    movz	fp,	#1516
    ldr	x18,	[sp, fp]

    str	w2,	[x18]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#29
    ble	main_413

main_173:
    movz	w2,	#29
    ldr	x21,	[sp, #496]

    str	x21,	[sp, #2944]

    ldr	x22,	[sp, #2944]

    str	w2,	[x22]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#30
    ble	main_413

main_175:
    movz	w2,	#30
    movz	fp,	#508
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2952]

    ldr	x25,	[sp, #2952]

    str	w2,	[x25]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#31
    ble	main_413

main_177:
    movz	w2,	#31
    movz	fp,	#956
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2968]

    ldr	x28,	[sp, #2968]

    str	w2,	[x28]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#32
    ble	main_413

main_179:
    movz	w2,	#32
    ldr	x1,	[sp, #456]

    mov	w4,	w2
    str	x1,	[sp, #2976]

    ldr	x2,	[sp, #2976]

    str	w4,	[x2]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#33
    ble	main_413

main_181:
    movz	w2,	#33
    movz	fp,	#484
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #2960]

    ldr	x5,	[sp, #2960]

    str	w2,	[x5]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#34
    ble	main_413

main_183:
    movz	w2,	#34
    movz	fp,	#596
    ldr	x4,	[sp, fp]

    movz	fp,	#1932
    str	x4,	[sp, fp]

    movz	fp,	#1932
    ldr	x5,	[sp, fp]

    str	w2,	[x5]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#35
    ble	main_413

main_185:
    movz	w2,	#35
    movz	fp,	#604
    mov	w4,	w2
    ldr	x1,	[sp, fp]

    movz	fp,	#1924
    str	x1,	[sp, fp]

    movz	fp,	#1924
    ldr	x2,	[sp, fp]

    str	w4,	[x2]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#36
    ble	main_413

main_187:
    movz	w2,	#36
    movz	fp,	#612
    ldr	x27,	[sp, fp]

    movz	fp,	#1916
    str	x27,	[sp, fp]

    movz	fp,	#1916
    ldr	x28,	[sp, fp]

    str	w2,	[x28]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#37
    ble	main_413

main_189:
    movz	w2,	#37
    movz	fp,	#964
    ldr	x24,	[sp, fp]

    movz	fp,	#1908
    str	x24,	[sp, fp]

    movz	fp,	#1908
    ldr	x25,	[sp, fp]

    str	w2,	[x25]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#38
    ble	main_413

main_191:
    movz	w2,	#38
    movz	fp,	#972
    ldr	x21,	[sp, fp]

    movz	fp,	#1900
    str	x21,	[sp, fp]

    movz	fp,	#1900
    ldr	x22,	[sp, fp]

    str	w2,	[x22]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#39
    ble	main_413

main_193:
    movz	w2,	#39
    movz	fp,	#980
    ldr	x18,	[sp, fp]

    movz	fp,	#1892
    str	x18,	[sp, fp]

    movz	fp,	#1892
    ldr	x19,	[sp, fp]

    str	w2,	[x19]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#40
    ble	main_413

main_195:
    movz	w2,	#40
    movz	fp,	#988
    ldr	x15,	[sp, fp]

    movz	fp,	#1884
    str	x15,	[sp, fp]

    movz	fp,	#1884
    ldr	x16,	[sp, fp]

    str	w2,	[x16]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#41
    ble	main_413

main_197:
    movz	w2,	#41
    movz	fp,	#996
    ldr	x12,	[sp, fp]

    movz	fp,	#1876
    str	x12,	[sp, fp]

    movz	fp,	#1876
    ldr	x13,	[sp, fp]

    str	w2,	[x13]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#42
    ble	main_413

main_199:
    movz	w2,	#42
    movz	fp,	#1004
    ldr	x9,	[sp, fp]

    movz	fp,	#1868
    str	x9,	[sp, fp]

    movz	fp,	#1868
    ldr	x10,	[sp, fp]

    str	w2,	[x10]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#43
    ble	main_413

main_201:
    movz	w2,	#43
    movz	fp,	#1012
    ldr	x6,	[sp, fp]

    movz	fp,	#1860
    str	x6,	[sp, fp]

    movz	fp,	#1860
    ldr	x7,	[sp, fp]

    str	w2,	[x7]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#44
    ble	main_413

main_203:
    movz	w2,	#44
    movz	fp,	#516
    ldr	x3,	[sp, fp]

    movz	fp,	#1852
    str	x3,	[sp, fp]

    movz	fp,	#1852
    ldr	x4,	[sp, fp]

    str	w2,	[x4]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#45
    ble	main_413

main_205:
    movz	w2,	#45
    movz	fp,	#524
    mov	w4,	w2
    ldr	x0,	[sp, fp]

    movz	fp,	#1844
    str	x0,	[sp, fp]

    movz	fp,	#1844
    ldr	x1,	[sp, fp]

    str	w4,	[x1]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#46
    ble	main_413

main_207:
    movz	w2,	#46
    movz	fp,	#532
    ldr	x26,	[sp, fp]

    movz	fp,	#1836
    str	x26,	[sp, fp]

    movz	fp,	#1836
    ldr	x27,	[sp, fp]

    str	w2,	[x27]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#47
    ble	main_413

main_209:
    movz	w2,	#47
    movz	fp,	#540
    ldr	x23,	[sp, fp]

    movz	fp,	#1828
    str	x23,	[sp, fp]

    movz	fp,	#1828
    ldr	x24,	[sp, fp]

    str	w2,	[x24]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#48
    ble	main_413

main_211:
    movz	w2,	#48
    movz	fp,	#548
    ldr	x20,	[sp, fp]

    movz	fp,	#1820
    str	x20,	[sp, fp]

    movz	fp,	#1820
    ldr	x21,	[sp, fp]

    str	w2,	[x21]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#49
    ble	main_413

main_213:
    movz	w2,	#49
    movz	fp,	#556
    ldr	x17,	[sp, fp]

    movz	fp,	#1812
    str	x17,	[sp, fp]

    movz	fp,	#1812
    ldr	x18,	[sp, fp]

    str	w2,	[x18]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#50
    ble	main_413

main_215:
    movz	w2,	#50
    movz	fp,	#564
    ldr	x14,	[sp, fp]

    movz	fp,	#1804
    str	x14,	[sp, fp]

    movz	fp,	#1804
    ldr	x15,	[sp, fp]

    str	w2,	[x15]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#51
    ble	main_413

main_217:
    movz	w2,	#51
    movz	fp,	#572
    ldr	x11,	[sp, fp]

    movz	fp,	#1796
    str	x11,	[sp, fp]

    movz	fp,	#1796
    ldr	x12,	[sp, fp]

    str	w2,	[x12]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#52
    ble	main_413

main_219:
    movz	w2,	#52
    movz	fp,	#588
    ldr	x8,	[sp, fp]

    movz	fp,	#1788
    str	x8,	[sp, fp]

    movz	fp,	#1788
    ldr	x9,	[sp, fp]

    str	w2,	[x9]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#53
    ble	main_413

main_221:
    movz	w2,	#53
    movz	fp,	#1020
    ldr	x5,	[sp, fp]

    movz	fp,	#1780
    str	x5,	[sp, fp]

    movz	fp,	#1780
    ldr	x6,	[sp, fp]

    str	w2,	[x6]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#54
    ble	main_413

main_223:
    movz	w2,	#54
    movz	fp,	#580
    mov	w4,	w2
    ldr	x2,	[sp, fp]

    movz	fp,	#1772
    str	x2,	[sp, fp]

    movz	fp,	#1772
    ldr	x3,	[sp, fp]

    str	w4,	[x3]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#55
    ble	main_413

main_225:
    movz	w2,	#55
    ldr	x28,	[sp, #416]

    movz	fp,	#1764
    mov	w3,	w2
    str	x28,	[sp, fp]

    movz	fp,	#1764
    ldr	x0,	[sp, fp]

    str	w3,	[x0]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#56
    ble	main_413

main_227:
    movz	w2,	#56
    ldr	x25,	[sp, #424]

    movz	fp,	#1756
    str	x25,	[sp, fp]

    movz	fp,	#1756
    ldr	x26,	[sp, fp]

    str	w2,	[x26]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#57
    ble	main_413

main_229:
    movz	w2,	#57
    ldr	x22,	[sp, #432]

    movz	fp,	#1748
    str	x22,	[sp, fp]

    movz	fp,	#1748
    ldr	x23,	[sp, fp]

    str	w2,	[x23]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#58
    ble	main_413

main_231:
    movz	w2,	#58
    movz	fp,	#1028
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3104]

    ldr	x20,	[sp, #3104]

    str	w2,	[x20]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#59
    ble	main_413

main_233:
    movz	w2,	#59
    movz	fp,	#1036
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3096]

    ldr	x17,	[sp, #3096]

    str	w2,	[x17]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#60
    ble	main_413

main_235:
    movz	w2,	#60
    movz	fp,	#1044
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3088]

    ldr	x14,	[sp, #3088]

    str	w2,	[x14]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#61
    ble	main_413

main_237:
    movz	w2,	#61
    movz	fp,	#1052
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #3080]

    ldr	x11,	[sp, #3080]

    str	w2,	[x11]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#62
    ble	main_413

main_239:
    movz	w2,	#62
    movz	fp,	#1060
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #3072]

    ldr	x8,	[sp, #3072]

    str	w2,	[x8]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#63
    ble	main_413

main_241:
    movz	w2,	#63
    movz	fp,	#1068
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3064]

    ldr	x5,	[sp, #3064]

    str	w2,	[x5]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#64
    ble	main_413

main_243:
    movz	w2,	#64
    movz	fp,	#1076
    mov	w4,	w2
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3056]

    ldr	x2,	[sp, #3056]

    str	w4,	[x2]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#65
    ble	main_413

main_245:
    movz	w2,	#65
    movz	fp,	#1084
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3048]

    ldr	x28,	[sp, #3048]

    str	w2,	[x28]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#66
    ble	main_413

main_247:
    movz	w2,	#66
    movz	fp,	#1092
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3040]

    ldr	x25,	[sp, #3040]

    str	w2,	[x25]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#67
    ble	main_413

main_249:
    movz	w2,	#67
    movz	fp,	#1100
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3032]

    ldr	x22,	[sp, #3032]

    str	w2,	[x22]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#68
    ble	main_413

main_251:
    movz	w2,	#68
    movz	fp,	#1108
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #3024]

    ldr	x19,	[sp, #3024]

    str	w2,	[x19]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#69
    ble	main_413

main_253:
    movz	w2,	#69
    movz	fp,	#1116
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #3016]

    ldr	x16,	[sp, #3016]

    str	w2,	[x16]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#70
    ble	main_413

main_255:
    movz	w2,	#70
    movz	fp,	#1124
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #3008]

    ldr	x13,	[sp, #3008]

    str	w2,	[x13]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#71
    ble	main_413

main_257:
    movz	w2,	#71
    movz	fp,	#1132
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #3000]

    ldr	x10,	[sp, #3000]

    str	w2,	[x10]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#72
    ble	main_413

main_259:
    movz	w2,	#72
    movz	fp,	#1140
    ldr	x6,	[sp, fp]

    str	x6,	[sp, #2992]

    ldr	x7,	[sp, #2992]

    str	w2,	[x7]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#73
    ble	main_413

main_261:
    movz	w2,	#73
    movz	fp,	#1148
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #2984]

    ldr	x4,	[sp, #2984]

    str	w2,	[x4]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#74
    ble	main_413

main_263:
    movz	w2,	#74
    movz	fp,	#1156
    mov	w4,	w2
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #2096]

    ldr	x1,	[sp, #2096]

    str	w4,	[x1]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#75
    ble	main_413

main_265:
    movz	w2,	#75
    movz	fp,	#1164
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #2088]

    ldr	x27,	[sp, #2088]

    str	w2,	[x27]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#76
    ble	main_413

main_267:
    movz	w2,	#76
    movz	fp,	#1172
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #2080]

    ldr	x24,	[sp, #2080]

    str	w2,	[x24]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#77
    ble	main_413

main_269:
    movz	w2,	#77
    movz	fp,	#1180
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #2072]

    ldr	x21,	[sp, #2072]

    str	w2,	[x21]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#78
    ble	main_413

main_271:
    movz	w2,	#78
    movz	fp,	#1188
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #2064]

    ldr	x18,	[sp, #2064]

    str	w2,	[x18]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#79
    ble	main_413

main_273:
    movz	w2,	#79
    movz	fp,	#1196
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #2056]

    ldr	x15,	[sp, #2056]

    str	w2,	[x15]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#80
    ble	main_413

main_275:
    movz	w2,	#80
    movz	fp,	#1204
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #2048]

    ldr	x12,	[sp, #2048]

    str	w2,	[x12]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#81
    ble	main_413

main_277:
    movz	w2,	#81
    movz	fp,	#1212
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #2040]

    ldr	x9,	[sp, #2040]

    str	w2,	[x9]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#82
    ble	main_413

main_279:
    movz	w2,	#82
    movz	fp,	#1220
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #2032]

    ldr	x6,	[sp, #2032]

    str	w2,	[x6]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#83
    ble	main_413

main_281:
    movz	w2,	#83
    movz	fp,	#1228
    mov	w4,	w2
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #2024]

    ldr	x3,	[sp, #2024]

    str	w4,	[x3]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#84
    ble	main_413

main_283:
    movz	w2,	#84
    movz	fp,	#1236
    mov	w3,	w2
    ldr	x28,	[sp, fp]

    movz	fp,	#1740
    str	x28,	[sp, fp]

    movz	fp,	#1740
    ldr	x0,	[sp, fp]

    str	w3,	[x0]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#85
    ble	main_413

main_285:
    movz	w2,	#85
    movz	fp,	#1244
    ldr	x25,	[sp, fp]

    movz	fp,	#1732
    str	x25,	[sp, fp]

    movz	fp,	#1732
    ldr	x26,	[sp, fp]

    str	w2,	[x26]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#86
    ble	main_413

main_287:
    movz	w2,	#86
    movz	fp,	#1252
    ldr	x22,	[sp, fp]

    movz	fp,	#1724
    str	x22,	[sp, fp]

    movz	fp,	#1724
    ldr	x23,	[sp, fp]

    str	w2,	[x23]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#87
    ble	main_413

main_289:
    movz	w2,	#87
    movz	fp,	#1260
    ldr	x19,	[sp, fp]

    movz	fp,	#1716
    str	x19,	[sp, fp]

    movz	fp,	#1716
    ldr	x20,	[sp, fp]

    str	w2,	[x20]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#88
    ble	main_413

main_291:
    movz	w2,	#88
    movz	fp,	#1268
    ldr	x16,	[sp, fp]

    movz	fp,	#1708
    str	x16,	[sp, fp]

    movz	fp,	#1708
    ldr	x17,	[sp, fp]

    str	w2,	[x17]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#89
    ble	main_413

main_293:
    movz	w2,	#89
    movz	fp,	#1276
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #2128]

    ldr	x14,	[sp, #2128]

    str	w2,	[x14]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#90
    ble	main_413

main_295:
    movz	w2,	#90
    movz	fp,	#1284
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #2120]

    ldr	x11,	[sp, #2120]

    str	w2,	[x11]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#91
    ble	main_413

main_297:
    movz	w2,	#91
    movz	fp,	#1292
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #2112]

    ldr	x8,	[sp, #2112]

    str	w2,	[x8]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#92
    ble	main_413

main_299:
    movz	w2,	#92
    movz	fp,	#1300
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #2104]

    ldr	x5,	[sp, #2104]

    str	w2,	[x5]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#93
    ble	main_413

main_301:
    movz	w2,	#93
    movz	fp,	#1308
    mov	w4,	w2
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #2016]

    ldr	x2,	[sp, #2016]

    str	w4,	[x2]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#94
    ble	main_413

main_303:
    movz	w2,	#94
    movz	fp,	#1316
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2008]

    ldr	x28,	[sp, #2008]

    str	w2,	[x28]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#95
    ble	main_413

main_305:
    movz	w2,	#95
    movz	fp,	#1324
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2000]

    ldr	x25,	[sp, #2000]

    str	w2,	[x25]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#96
    ble	main_413

main_307:
    movz	w2,	#96
    movz	fp,	#1332
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2144]

    ldr	x22,	[sp, #2144]

    str	w2,	[x22]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#97
    ble	main_413

main_309:
    movz	w2,	#97
    movz	fp,	#1340
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #2136]

    ldr	x19,	[sp, #2136]

    str	w2,	[x19]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#98
    ble	main_413

main_311:
    movz	w2,	#98
    movz	fp,	#1348
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #440]

    ldr	x16,	[sp, #440]

    str	w2,	[x16]

    ldr	w2,	[sp, #1376]

    cmp	w2,	#99
    ble	main_413

main_313:
    movz	w2,	#99
    movz	fp,	#1356
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #2152]

    ldr	x13,	[sp, #2152]

    str	w2,	[x13]


main_413:
    ldr	w2,	[sp, #1364]

    add	w2,	w2,	#1
    str	w2,	[sp, #452]

    ldr	w2,	[sp, #1368]

    str	w2,	[sp, #448]

    movz	w2,	#0
    str	w2,	[sp, #492]


main_415:
    ldr	w2,	[sp, #492]

    cmp	w2,	#100
    bge	main_424

main_419:
    ldr	w2,	[sp, #492]

    lsl	w2,	w2,	#2
    mov	x2,	x2
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w2,	[x2]

    ldr	w13,	[sp, #448]

    str	w13,	[sp, #2764]

    ldr	w14,	[sp, #2764]

    ldr	w10,	[sp, #492]

    add	w2,	w2,	w14
    str	w10,	[sp, #2760]

    ldr	w11,	[sp, #2760]

    add	w4,	w11,	#1
    str	w4,	[sp, #2752]

    ldr	w5,	[sp, #2752]

    str	w5,	[sp, #504]

    str	w2,	[sp, #448]

    ldr	w2,	[sp, #504]

    str	w2,	[sp, #492]

    b	main_415

main_424:
    movz	w2,	#65535
    ldr	w16,	[sp, #448]

    str	w16,	[sp, #2768]

    ldr	w17,	[sp, #2768]

    sdiv	w2,	w17,	w2
    str	w2,	[sp, #464]

    ldr	w2,	[sp, #464]

    ldr	w7,	[sp, #464]

    lsl	w2,	w2,	#16
    str	w7,	[sp, #2756]

    ldr	w8,	[sp, #2756]

    ldr	w19,	[sp, #448]

    sub	w2,	w2,	w8,	lsl #0
    str	w19,	[sp, #2772]

    ldr	w20,	[sp, #2772]

    ldr	w7,	[sp, #452]

    sub	w3,	w20,	w2
    str	w7,	[sp, #1940]

    ldr	w22,	[sp, #1372]

    str	w22,	[sp, #2776]

    ldr	w8,	[sp, #1940]

    ldr	w0,	[sp, #2776]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w2,	w3
    str	w2,	[sp, #1368]

    ldr	w2,	[sp, #452]

    str	w2,	[sp, #1364]

    b	main_113

main_428:
    mov	w0,	w3
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


