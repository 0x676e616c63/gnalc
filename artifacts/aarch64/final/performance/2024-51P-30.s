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
    str	w0,	[sp, #1428]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1432]

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
    ldr	w15,	[sp, #1428]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x7,	sp,	#20
    movz	fp,	#1692
    add	x18,	sp,	#24
    add	x14,	sp,	#28
    add	x16,	sp,	#32
    add	x17,	sp,	#36
    add	x20,	sp,	#40
    add	x4,	sp,	#44
    add	x11,	sp,	#48
    add	x9,	sp,	#52
    add	x13,	sp,	#56
    add	x27,	sp,	#60
    add	x15,	sp,	#64
    add	x22,	sp,	#68
    add	x26,	sp,	#72
    add	x21,	sp,	#76
    add	x5,	sp,	#80
    add	x10,	sp,	#84
    add	x6,	sp,	#88
    add	x23,	sp,	#92
    add	x1,	sp,	#96
    add	x8,	sp,	#100
    add	x19,	sp,	#104
    add	x28,	sp,	#108
    add	x24,	sp,	#112
    add	x2,	sp,	#116
    add	x3,	sp,	#120
    add	x0,	sp,	#124
    add	x25,	sp,	#128
    str	x7,	[sp, fp]

    movz	fp,	#1508
    str	x18,	[sp, fp]

    movz	fp,	#1788
    str	x14,	[sp, fp]

    movz	fp,	#1716
    str	x16,	[sp, fp]

    movz	fp,	#1796
    str	x17,	[sp, fp]

    add	x17,	sp,	#132
    movz	fp,	#1804
    str	x20,	[sp, fp]

    movz	fp,	#1684
    str	x4,	[sp, fp]

    movz	fp,	#1780
    str	x11,	[sp, fp]

    movz	fp,	#1852
    str	x9,	[sp, fp]

    movz	fp,	#1708
    str	x13,	[sp, fp]

    movz	fp,	#1532
    str	x27,	[sp, fp]

    movz	fp,	#1500
    str	x15,	[sp, fp]

    movz	fp,	#1732
    str	x22,	[sp, fp]

    movz	fp,	#1820
    str	x26,	[sp, fp]

    movz	fp,	#1516
    str	x21,	[sp, fp]

    movz	fp,	#1764
    str	x5,	[sp, fp]

    movz	fp,	#1700
    str	x10,	[sp, fp]

    movz	fp,	#1844
    str	x6,	[sp, fp]

    movz	fp,	#1812
    str	x23,	[sp, fp]

    movz	fp,	#1676
    str	x1,	[sp, fp]

    movz	fp,	#1772
    str	x8,	[sp, fp]

    movz	fp,	#1724
    str	x19,	[sp, fp]

    movz	fp,	#1748
    str	x28,	[sp, fp]

    movz	fp,	#1524
    str	x24,	[sp, fp]

    movz	fp,	#1756
    str	x2,	[sp, fp]

    movz	fp,	#1836
    str	x3,	[sp, fp]

    movz	fp,	#1828
    str	x0,	[sp, fp]

    movz	fp,	#1740
    str	x25,	[sp, fp]

    movz	fp,	#620
    str	x17,	[sp, fp]

    movz	fp,	#652
    add	x17,	sp,	#136
    str	x17,	[sp, #600]

    add	x17,	sp,	#140
    str	x17,	[sp, #432]

    add	x17,	sp,	#144
    str	x17,	[sp, #608]

    add	x17,	sp,	#148
    str	x17,	[sp, #632]

    add	x17,	sp,	#152
    str	x17,	[sp, fp]

    movz	fp,	#660
    add	x17,	sp,	#156
    str	x17,	[sp, fp]

    movz	fp,	#668
    add	x17,	sp,	#160
    str	x17,	[sp, fp]

    movz	fp,	#676
    add	x17,	sp,	#164
    str	x17,	[sp, fp]

    movz	fp,	#1068
    add	x17,	sp,	#168
    str	x17,	[sp, #944]

    add	x17,	sp,	#172
    str	x17,	[sp, #952]

    add	x17,	sp,	#176
    str	x17,	[sp, #960]

    add	x17,	sp,	#180
    str	x17,	[sp, #968]

    add	x17,	sp,	#184
    str	x17,	[sp, #976]

    add	x17,	sp,	#188
    str	x17,	[sp, #984]

    add	x17,	sp,	#192
    str	x17,	[sp, #992]

    add	x17,	sp,	#196
    str	x17,	[sp, #1000]

    add	x17,	sp,	#200
    str	x17,	[sp, #1008]

    add	x17,	sp,	#204
    str	x17,	[sp, #1016]

    add	x17,	sp,	#208
    str	x17,	[sp, #1024]

    add	x17,	sp,	#212
    str	x17,	[sp, #1032]

    add	x17,	sp,	#216
    str	x17,	[sp, #1040]

    add	x17,	sp,	#220
    str	x17,	[sp, #1048]

    add	x17,	sp,	#224
    str	x17,	[sp, #1056]

    add	x17,	sp,	#228
    str	x17,	[sp, fp]

    movz	fp,	#684
    add	x17,	sp,	#232
    str	x17,	[sp, fp]

    movz	fp,	#1076
    add	x17,	sp,	#236
    str	x17,	[sp, #416]

    add	x17,	sp,	#240
    str	x17,	[sp, #424]

    add	x17,	sp,	#244
    str	x17,	[sp, fp]

    movz	fp,	#1084
    add	x17,	sp,	#248
    str	x17,	[sp, fp]

    movz	fp,	#1092
    add	x17,	sp,	#252
    str	x17,	[sp, fp]

    movz	fp,	#1100
    add	x17,	sp,	#256
    str	x17,	[sp, fp]

    movz	fp,	#1108
    add	x17,	sp,	#260
    str	x17,	[sp, fp]

    movz	fp,	#1116
    add	x17,	sp,	#264
    str	x17,	[sp, fp]

    movz	fp,	#1124
    add	x17,	sp,	#268
    str	x17,	[sp, fp]

    movz	fp,	#1132
    add	x17,	sp,	#272
    str	x17,	[sp, fp]

    movz	fp,	#1140
    add	x17,	sp,	#276
    str	x17,	[sp, fp]

    movz	fp,	#1148
    add	x17,	sp,	#280
    str	x17,	[sp, fp]

    movz	fp,	#1156
    add	x17,	sp,	#284
    str	x17,	[sp, fp]

    movz	fp,	#1164
    add	x17,	sp,	#288
    str	x17,	[sp, fp]

    movz	fp,	#1172
    add	x17,	sp,	#292
    str	x17,	[sp, fp]

    movz	fp,	#1180
    add	x17,	sp,	#296
    str	x17,	[sp, fp]

    movz	fp,	#1188
    add	x17,	sp,	#300
    str	x17,	[sp, fp]

    movz	fp,	#1196
    add	x17,	sp,	#304
    str	x17,	[sp, fp]

    movz	fp,	#1204
    add	x17,	sp,	#308
    str	x17,	[sp, fp]

    movz	fp,	#1212
    add	x17,	sp,	#312
    str	x17,	[sp, fp]

    movz	fp,	#1220
    add	x17,	sp,	#316
    str	x17,	[sp, fp]

    movz	fp,	#1228
    add	x17,	sp,	#320
    str	x17,	[sp, fp]

    movz	fp,	#1236
    add	x17,	sp,	#324
    str	x17,	[sp, fp]

    movz	fp,	#1244
    add	x17,	sp,	#328
    str	x17,	[sp, fp]

    movz	fp,	#1252
    add	x17,	sp,	#332
    str	x17,	[sp, fp]

    movz	fp,	#1260
    add	x17,	sp,	#336
    str	x17,	[sp, fp]

    movz	fp,	#1268
    add	x17,	sp,	#340
    str	x17,	[sp, fp]

    movz	fp,	#1276
    add	x17,	sp,	#344
    str	x17,	[sp, fp]

    movz	fp,	#1284
    add	x17,	sp,	#348
    str	x17,	[sp, fp]

    movz	fp,	#1292
    add	x17,	sp,	#352
    str	x17,	[sp, fp]

    movz	fp,	#1300
    add	x17,	sp,	#356
    str	x17,	[sp, fp]

    movz	fp,	#1308
    add	x17,	sp,	#360
    str	x17,	[sp, fp]

    movz	fp,	#1316
    add	x17,	sp,	#364
    str	x17,	[sp, fp]

    movz	fp,	#1324
    add	x17,	sp,	#368
    str	x17,	[sp, fp]

    movz	fp,	#1332
    add	x17,	sp,	#372
    str	x17,	[sp, fp]

    movz	fp,	#1340
    add	x17,	sp,	#376
    str	x17,	[sp, fp]

    movz	fp,	#1348
    add	x17,	sp,	#380
    str	x17,	[sp, fp]

    movz	fp,	#1356
    add	x17,	sp,	#384
    str	x17,	[sp, fp]

    movz	fp,	#1364
    add	x17,	sp,	#388
    str	x17,	[sp, fp]

    movz	fp,	#1372
    add	x17,	sp,	#392
    str	x17,	[sp, fp]

    movz	fp,	#1380
    add	x17,	sp,	#396
    str	x17,	[sp, fp]

    movz	fp,	#1388
    add	x17,	sp,	#400
    str	x17,	[sp, fp]

    movz	fp,	#1396
    add	x17,	sp,	#404
    str	x17,	[sp, fp]

    movz	fp,	#1404
    add	x17,	sp,	#408
    str	x17,	[sp, fp]

    movz	fp,	#1412
    add	x17,	sp,	#412
    str	x17,	[sp, fp]

    movz	w17,	#0
    str	w17,	[sp, #1424]

    movz	w17,	#0
    str	w17,	[sp, #1420]


main_113:
    ldr	w17,	[sp, #1432]

    cmp	w17,	#1
    ble	main_413

main_117:
    movz	w17,	#1
    movz	fp,	#1692
    ldr	x1,	[sp, fp]

    str	w17,	[x1]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#2
    ble	main_413

main_119:
    movz	w17,	#2
    movz	fp,	#1508
    ldr	x11,	[sp, fp]

    str	w17,	[x11]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#3
    ble	main_413

main_121:
    movz	w17,	#3
    movz	fp,	#1788
    ldr	x9,	[sp, fp]

    str	w17,	[x9]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#4
    ble	main_413

main_123:
    movz	w17,	#4
    movz	fp,	#1716
    ldr	x10,	[sp, fp]

    str	w17,	[x10]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#5
    ble	main_413

main_125:
    movz	w17,	#5
    movz	fp,	#1796
    ldr	x12,	[sp, fp]

    str	w17,	[x12]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#6
    ble	main_413

main_127:
    movz	w17,	#6
    movz	fp,	#1804
    ldr	x15,	[sp, fp]

    str	w17,	[x15]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#7
    ble	main_413

main_129:
    movz	w17,	#7
    movz	fp,	#1684
    ldr	x28,	[sp, fp]

    str	w17,	[x28]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#8
    ble	main_413

main_131:
    movz	w17,	#8
    movz	fp,	#1780
    ldr	x6,	[sp, fp]

    str	w17,	[x6]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#9
    ble	main_413

main_133:
    movz	w17,	#9
    movz	fp,	#1852
    ldr	x5,	[sp, fp]

    str	w17,	[x5]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#10
    ble	main_413

main_135:
    movz	w17,	#10
    movz	fp,	#1708
    ldr	x7,	[sp, fp]

    str	w17,	[x7]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#11
    ble	main_413

main_137:
    movz	w17,	#11
    movz	fp,	#1532
    ldr	x22,	[sp, fp]

    str	w17,	[x22]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#12
    ble	main_413

main_139:
    movz	w17,	#12
    movz	fp,	#1500
    ldr	x8,	[sp, fp]

    str	w17,	[x8]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#13
    ble	main_413

main_141:
    movz	w17,	#13
    movz	fp,	#1732
    ldr	x16,	[sp, fp]

    str	w17,	[x16]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#14
    ble	main_413

main_143:
    movz	w17,	#14
    movz	fp,	#1820
    ldr	x23,	[sp, fp]

    str	w17,	[x23]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#15
    ble	main_413

main_145:
    movz	w17,	#15
    movz	fp,	#1516
    ldr	x14,	[sp, fp]

    str	w17,	[x14]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#16
    ble	main_413

main_147:
    movz	w17,	#16
    movz	fp,	#1764
    ldr	x0,	[sp, fp]

    str	w17,	[x0]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#17
    ble	main_413

main_149:
    movz	w17,	#17
    movz	fp,	#1700
    ldr	x4,	[sp, fp]

    str	w17,	[x4]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#18
    ble	main_413

main_151:
    movz	w17,	#18
    movz	fp,	#1844
    ldr	x2,	[sp, fp]

    str	w17,	[x2]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#19
    ble	main_413

main_153:
    movz	w17,	#19
    movz	fp,	#1812
    ldr	x20,	[sp, fp]

    str	w17,	[x20]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#20
    ble	main_413

main_155:
    movz	w17,	#20
    movz	fp,	#1676
    ldr	x25,	[sp, fp]

    str	w17,	[x25]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#21
    ble	main_413

main_157:
    movz	w17,	#21
    movz	fp,	#1772
    ldr	x3,	[sp, fp]

    str	w17,	[x3]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#22
    ble	main_413

main_159:
    movz	w17,	#22
    movz	fp,	#1724
    ldr	x13,	[sp, fp]

    str	w17,	[x13]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#23
    ble	main_413

main_161:
    movz	w17,	#23
    movz	fp,	#1748
    ldr	x24,	[sp, fp]

    str	w17,	[x24]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#24
    ble	main_413

main_163:
    movz	w17,	#24
    movz	fp,	#1524
    ldr	x19,	[sp, fp]

    str	w17,	[x19]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#25
    ble	main_413

main_165:
    movz	w17,	#25
    movz	fp,	#1756
    ldr	x27,	[sp, fp]

    str	w17,	[x27]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#26
    ble	main_413

main_167:
    movz	w17,	#26
    movz	fp,	#1836
    ldr	x0,	[sp, fp]

    str	w17,	[x0]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#27
    ble	main_413

main_169:
    movz	w17,	#27
    movz	fp,	#1828
    ldr	x26,	[sp, fp]

    str	w17,	[x26]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#28
    ble	main_413

main_171:
    movz	w17,	#28
    movz	fp,	#1740
    ldr	x21,	[sp, fp]

    str	w17,	[x21]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#29
    ble	main_413

main_173:
    movz	w17,	#29
    movz	fp,	#620
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3136]

    ldr	x22,	[sp, #3136]

    str	w17,	[x22]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#30
    ble	main_413

main_175:
    movz	w17,	#30
    ldr	x24,	[sp, #600]

    str	x24,	[sp, #3144]

    ldr	x25,	[sp, #3144]

    str	w17,	[x25]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#31
    ble	main_413

main_177:
    movz	w17,	#31
    ldr	x27,	[sp, #432]

    str	x27,	[sp, #3152]

    ldr	x28,	[sp, #3152]

    str	w17,	[x28]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#32
    ble	main_413

main_179:
    movz	w17,	#32
    ldr	x1,	[sp, #608]

    mov	w19,	w17
    str	x1,	[sp, #3160]

    ldr	x2,	[sp, #3160]

    str	w19,	[x2]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#33
    ble	main_413

main_181:
    movz	w17,	#33
    ldr	x4,	[sp, #632]

    movz	fp,	#2972
    mov	w19,	w17
    str	x4,	[sp, fp]

    movz	fp,	#2972
    ldr	x5,	[sp, fp]

    str	w19,	[x5]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#34
    ble	main_413

main_183:
    movz	w17,	#34
    movz	fp,	#652
    mov	w19,	w17
    ldr	x4,	[sp, fp]

    movz	fp,	#2276
    str	x4,	[sp, fp]

    movz	fp,	#2276
    ldr	x5,	[sp, fp]

    str	w19,	[x5]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#35
    ble	main_413

main_185:
    movz	w17,	#35
    movz	fp,	#660
    mov	w19,	w17
    ldr	x1,	[sp, fp]

    movz	fp,	#2268
    str	x1,	[sp, fp]

    movz	fp,	#2268
    ldr	x2,	[sp, fp]

    str	w19,	[x2]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#36
    ble	main_413

main_187:
    movz	w17,	#36
    movz	fp,	#668
    ldr	x27,	[sp, fp]

    movz	fp,	#2260
    str	x27,	[sp, fp]

    movz	fp,	#2260
    ldr	x28,	[sp, fp]

    str	w17,	[x28]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#37
    ble	main_413

main_189:
    movz	w17,	#37
    movz	fp,	#676
    ldr	x24,	[sp, fp]

    movz	fp,	#2252
    str	x24,	[sp, fp]

    movz	fp,	#2252
    ldr	x25,	[sp, fp]

    str	w17,	[x25]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#38
    ble	main_413

main_191:
    movz	w17,	#38
    ldr	x21,	[sp, #944]

    movz	fp,	#2244
    str	x21,	[sp, fp]

    movz	fp,	#2244
    ldr	x22,	[sp, fp]

    str	w17,	[x22]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#39
    ble	main_413

main_193:
    movz	w17,	#39
    ldr	x18,	[sp, #952]

    movz	fp,	#2236
    str	x18,	[sp, fp]

    movz	fp,	#2236
    ldr	x19,	[sp, fp]

    str	w17,	[x19]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#40
    ble	main_413

main_195:
    movz	w17,	#40
    ldr	x15,	[sp, #960]

    mov	w19,	w17
    str	x15,	[sp, #3256]

    ldr	x16,	[sp, #3256]

    str	w19,	[x16]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#41
    ble	main_413

main_197:
    movz	w17,	#41
    ldr	x12,	[sp, #968]

    mov	w19,	w17
    str	x12,	[sp, #3248]

    ldr	x13,	[sp, #3248]

    str	w19,	[x13]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#42
    ble	main_413

main_199:
    movz	w17,	#42
    ldr	x9,	[sp, #976]

    mov	w19,	w17
    str	x9,	[sp, #3240]

    ldr	x10,	[sp, #3240]

    str	w19,	[x10]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#43
    ble	main_413

main_201:
    movz	w17,	#43
    ldr	x6,	[sp, #984]

    mov	w19,	w17
    str	x6,	[sp, #3232]

    ldr	x7,	[sp, #3232]

    str	w19,	[x7]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#44
    ble	main_413

main_203:
    movz	w17,	#44
    ldr	x3,	[sp, #992]

    mov	w19,	w17
    str	x3,	[sp, #3224]

    ldr	x4,	[sp, #3224]

    str	w19,	[x4]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#45
    ble	main_413

main_205:
    movz	w17,	#45
    ldr	x0,	[sp, #1000]

    mov	w19,	w17
    str	x0,	[sp, #3216]

    ldr	x1,	[sp, #3216]

    str	w19,	[x1]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#46
    ble	main_413

main_207:
    movz	w17,	#46
    ldr	x26,	[sp, #1008]

    str	x26,	[sp, #3208]

    ldr	x27,	[sp, #3208]

    str	w17,	[x27]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#47
    ble	main_413

main_209:
    movz	w17,	#47
    ldr	x23,	[sp, #1016]

    str	x23,	[sp, #3200]

    ldr	x24,	[sp, #3200]

    str	w17,	[x24]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#48
    ble	main_413

main_211:
    movz	w17,	#48
    ldr	x20,	[sp, #1024]

    str	x20,	[sp, #3192]

    ldr	x21,	[sp, #3192]

    str	w17,	[x21]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#49
    ble	main_413

main_213:
    movz	w17,	#49
    mov	w19,	w17
    ldr	x17,	[sp, #1032]

    str	x17,	[sp, #3184]

    ldr	x18,	[sp, #3184]

    str	w19,	[x18]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#50
    ble	main_413

main_215:
    movz	w17,	#50
    ldr	x14,	[sp, #1040]

    mov	w19,	w17
    str	x14,	[sp, #3176]

    ldr	x15,	[sp, #3176]

    str	w19,	[x15]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#51
    ble	main_413

main_217:
    movz	w17,	#51
    ldr	x11,	[sp, #1048]

    mov	w19,	w17
    str	x11,	[sp, #3168]

    ldr	x12,	[sp, #3168]

    str	w19,	[x12]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#52
    ble	main_413

main_219:
    movz	w17,	#52
    ldr	x8,	[sp, #1056]

    movz	fp,	#2052
    mov	w19,	w17
    str	x8,	[sp, fp]

    movz	fp,	#2052
    ldr	x9,	[sp, fp]

    str	w19,	[x9]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#53
    ble	main_413

main_221:
    movz	w17,	#53
    movz	fp,	#1068
    mov	w19,	w17
    ldr	x5,	[sp, fp]

    movz	fp,	#2044
    str	x5,	[sp, fp]

    movz	fp,	#2044
    ldr	x6,	[sp, fp]

    str	w19,	[x6]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#54
    ble	main_413

main_223:
    movz	w17,	#54
    movz	fp,	#684
    mov	w19,	w17
    ldr	x2,	[sp, fp]

    movz	fp,	#2036
    str	x2,	[sp, fp]

    movz	fp,	#2036
    ldr	x3,	[sp, fp]

    str	w19,	[x3]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#55
    ble	main_413

main_225:
    movz	w17,	#55
    ldr	x28,	[sp, #416]

    movz	fp,	#2028
    mov	w18,	w17
    str	x28,	[sp, fp]

    movz	fp,	#2028
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#56
    ble	main_413

main_227:
    movz	w17,	#56
    ldr	x25,	[sp, #424]

    movz	fp,	#2020
    str	x25,	[sp, fp]

    movz	fp,	#2020
    ldr	x26,	[sp, fp]

    str	w17,	[x26]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#57
    ble	main_413

main_229:
    movz	w17,	#57
    movz	fp,	#1076
    ldr	x22,	[sp, fp]

    movz	fp,	#2012
    str	x22,	[sp, fp]

    movz	fp,	#2012
    ldr	x23,	[sp, fp]

    str	w17,	[x23]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#58
    ble	main_413

main_231:
    movz	w17,	#58
    movz	fp,	#1084
    ldr	x19,	[sp, fp]

    movz	fp,	#2004
    str	x19,	[sp, fp]

    movz	fp,	#2004
    ldr	x20,	[sp, fp]

    str	w17,	[x20]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#59
    ble	main_413

main_233:
    movz	w17,	#59
    movz	fp,	#1092
    mov	w19,	w17
    ldr	x16,	[sp, fp]

    movz	fp,	#1996
    str	x16,	[sp, fp]

    movz	fp,	#1996
    ldr	x17,	[sp, fp]

    str	w19,	[x17]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#60
    ble	main_413

main_235:
    movz	w17,	#60
    movz	fp,	#1100
    mov	w19,	w17
    ldr	x13,	[sp, fp]

    movz	fp,	#1988
    str	x13,	[sp, fp]

    movz	fp,	#1988
    ldr	x14,	[sp, fp]

    str	w19,	[x14]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#61
    ble	main_413

main_237:
    movz	w17,	#61
    movz	fp,	#1108
    mov	w19,	w17
    ldr	x10,	[sp, fp]

    movz	fp,	#1980
    str	x10,	[sp, fp]

    movz	fp,	#1980
    ldr	x11,	[sp, fp]

    str	w19,	[x11]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#62
    ble	main_413

main_239:
    movz	w17,	#62
    movz	fp,	#1116
    mov	w19,	w17
    ldr	x7,	[sp, fp]

    movz	fp,	#1972
    str	x7,	[sp, fp]

    movz	fp,	#1972
    ldr	x8,	[sp, fp]

    str	w19,	[x8]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#63
    ble	main_413

main_241:
    movz	w17,	#63
    movz	fp,	#1124
    mov	w19,	w17
    ldr	x4,	[sp, fp]

    movz	fp,	#1964
    str	x4,	[sp, fp]

    movz	fp,	#1964
    ldr	x5,	[sp, fp]

    str	w19,	[x5]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#64
    ble	main_413

main_243:
    movz	w17,	#64
    movz	fp,	#1132
    mov	w19,	w17
    ldr	x1,	[sp, fp]

    movz	fp,	#1956
    str	x1,	[sp, fp]

    movz	fp,	#1956
    ldr	x2,	[sp, fp]

    str	w19,	[x2]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#65
    ble	main_413

main_245:
    movz	w17,	#65
    movz	fp,	#1140
    ldr	x27,	[sp, fp]

    movz	fp,	#1948
    str	x27,	[sp, fp]

    movz	fp,	#1948
    ldr	x28,	[sp, fp]

    str	w17,	[x28]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#66
    ble	main_413

main_247:
    movz	w17,	#66
    movz	fp,	#1148
    ldr	x24,	[sp, fp]

    movz	fp,	#1940
    str	x24,	[sp, fp]

    movz	fp,	#1940
    ldr	x25,	[sp, fp]

    str	w17,	[x25]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#67
    ble	main_413

main_249:
    movz	w17,	#67
    movz	fp,	#1156
    ldr	x21,	[sp, fp]

    movz	fp,	#1932
    str	x21,	[sp, fp]

    movz	fp,	#1932
    ldr	x22,	[sp, fp]

    str	w17,	[x22]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#68
    ble	main_413

main_251:
    movz	w17,	#68
    movz	fp,	#1164
    ldr	x18,	[sp, fp]

    movz	fp,	#1924
    str	x18,	[sp, fp]

    movz	fp,	#1924
    ldr	x19,	[sp, fp]

    str	w17,	[x19]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#69
    ble	main_413

main_253:
    movz	w17,	#69
    movz	fp,	#1172
    mov	w19,	w17
    ldr	x15,	[sp, fp]

    movz	fp,	#1916
    str	x15,	[sp, fp]

    movz	fp,	#1916
    ldr	x16,	[sp, fp]

    str	w19,	[x16]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#70
    ble	main_413

main_255:
    movz	w17,	#70
    movz	fp,	#1180
    mov	w19,	w17
    ldr	x12,	[sp, fp]

    movz	fp,	#1908
    str	x12,	[sp, fp]

    movz	fp,	#1908
    ldr	x13,	[sp, fp]

    str	w19,	[x13]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#71
    ble	main_413

main_257:
    movz	w17,	#71
    movz	fp,	#1188
    mov	w19,	w17
    ldr	x9,	[sp, fp]

    movz	fp,	#1900
    str	x9,	[sp, fp]

    movz	fp,	#1900
    ldr	x10,	[sp, fp]

    str	w19,	[x10]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#72
    ble	main_413

main_259:
    movz	w17,	#72
    movz	fp,	#1196
    mov	w19,	w17
    ldr	x6,	[sp, fp]

    movz	fp,	#1892
    str	x6,	[sp, fp]

    movz	fp,	#1892
    ldr	x7,	[sp, fp]

    str	w19,	[x7]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#73
    ble	main_413

main_261:
    movz	w17,	#73
    movz	fp,	#1204
    mov	w19,	w17
    ldr	x3,	[sp, fp]

    movz	fp,	#1884
    str	x3,	[sp, fp]

    movz	fp,	#1884
    ldr	x4,	[sp, fp]

    str	w19,	[x4]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#74
    ble	main_413

main_263:
    movz	w17,	#74
    movz	fp,	#1212
    mov	w19,	w17
    ldr	x0,	[sp, fp]

    movz	fp,	#1876
    str	x0,	[sp, fp]

    movz	fp,	#1876
    ldr	x1,	[sp, fp]

    str	w19,	[x1]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#75
    ble	main_413

main_265:
    movz	w17,	#75
    movz	fp,	#1220
    ldr	x26,	[sp, fp]

    movz	fp,	#2188
    str	x26,	[sp, fp]

    movz	fp,	#2188
    ldr	x27,	[sp, fp]

    str	w17,	[x27]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#76
    ble	main_413

main_267:
    movz	w17,	#76
    movz	fp,	#1228
    ldr	x23,	[sp, fp]

    movz	fp,	#2180
    str	x23,	[sp, fp]

    movz	fp,	#2180
    ldr	x24,	[sp, fp]

    str	w17,	[x24]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#77
    ble	main_413

main_269:
    movz	w17,	#77
    movz	fp,	#1236
    ldr	x20,	[sp, fp]

    movz	fp,	#2172
    str	x20,	[sp, fp]

    movz	fp,	#2172
    ldr	x21,	[sp, fp]

    str	w17,	[x21]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#78
    ble	main_413

main_271:
    movz	w17,	#78
    movz	fp,	#1244
    mov	w19,	w17
    ldr	x17,	[sp, fp]

    movz	fp,	#2164
    str	x17,	[sp, fp]

    movz	fp,	#2164
    ldr	x18,	[sp, fp]

    str	w19,	[x18]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#79
    ble	main_413

main_273:
    movz	w17,	#79
    movz	fp,	#1252
    mov	w19,	w17
    ldr	x14,	[sp, fp]

    movz	fp,	#2156
    str	x14,	[sp, fp]

    movz	fp,	#2156
    ldr	x15,	[sp, fp]

    str	w19,	[x15]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#80
    ble	main_413

main_275:
    movz	w17,	#80
    movz	fp,	#1260
    mov	w19,	w17
    ldr	x11,	[sp, fp]

    movz	fp,	#2148
    str	x11,	[sp, fp]

    movz	fp,	#2148
    ldr	x12,	[sp, fp]

    str	w19,	[x12]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#81
    ble	main_413

main_277:
    movz	w17,	#81
    movz	fp,	#1268
    mov	w19,	w17
    ldr	x8,	[sp, fp]

    movz	fp,	#2140
    str	x8,	[sp, fp]

    movz	fp,	#2140
    ldr	x9,	[sp, fp]

    str	w19,	[x9]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#82
    ble	main_413

main_279:
    movz	w17,	#82
    movz	fp,	#1276
    mov	w19,	w17
    ldr	x5,	[sp, fp]

    movz	fp,	#2132
    str	x5,	[sp, fp]

    movz	fp,	#2132
    ldr	x6,	[sp, fp]

    str	w19,	[x6]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#83
    ble	main_413

main_281:
    movz	w17,	#83
    movz	fp,	#1284
    mov	w19,	w17
    ldr	x2,	[sp, fp]

    movz	fp,	#2124
    str	x2,	[sp, fp]

    movz	fp,	#2124
    ldr	x3,	[sp, fp]

    str	w19,	[x3]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#84
    ble	main_413

main_283:
    movz	w17,	#84
    movz	fp,	#1292
    mov	w18,	w17
    ldr	x28,	[sp, fp]

    movz	fp,	#2116
    str	x28,	[sp, fp]

    movz	fp,	#2116
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#85
    ble	main_413

main_285:
    movz	w17,	#85
    movz	fp,	#1300
    ldr	x25,	[sp, fp]

    movz	fp,	#2108
    str	x25,	[sp, fp]

    movz	fp,	#2108
    ldr	x26,	[sp, fp]

    str	w17,	[x26]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#86
    ble	main_413

main_287:
    movz	w17,	#86
    movz	fp,	#1308
    ldr	x22,	[sp, fp]

    movz	fp,	#2100
    str	x22,	[sp, fp]

    movz	fp,	#2100
    ldr	x23,	[sp, fp]

    str	w17,	[x23]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#87
    ble	main_413

main_289:
    movz	w17,	#87
    movz	fp,	#1316
    ldr	x19,	[sp, fp]

    movz	fp,	#2092
    str	x19,	[sp, fp]

    movz	fp,	#2092
    ldr	x20,	[sp, fp]

    str	w17,	[x20]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#88
    ble	main_413

main_291:
    movz	w17,	#88
    movz	fp,	#1324
    mov	w19,	w17
    ldr	x16,	[sp, fp]

    movz	fp,	#2084
    str	x16,	[sp, fp]

    movz	fp,	#2084
    ldr	x17,	[sp, fp]

    str	w19,	[x17]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#89
    ble	main_413

main_293:
    movz	w17,	#89
    movz	fp,	#1332
    mov	w19,	w17
    ldr	x13,	[sp, fp]

    movz	fp,	#2076
    str	x13,	[sp, fp]

    movz	fp,	#2076
    ldr	x14,	[sp, fp]

    str	w19,	[x14]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#90
    ble	main_413

main_295:
    movz	w17,	#90
    movz	fp,	#1340
    mov	w19,	w17
    ldr	x10,	[sp, fp]

    movz	fp,	#2068
    str	x10,	[sp, fp]

    movz	fp,	#2068
    ldr	x11,	[sp, fp]

    str	w19,	[x11]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#91
    ble	main_413

main_297:
    movz	w17,	#91
    movz	fp,	#1348
    mov	w19,	w17
    ldr	x7,	[sp, fp]

    movz	fp,	#2228
    str	x7,	[sp, fp]

    movz	fp,	#2228
    ldr	x8,	[sp, fp]

    str	w19,	[x8]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#92
    ble	main_413

main_299:
    movz	w17,	#92
    movz	fp,	#1356
    mov	w19,	w17
    ldr	x4,	[sp, fp]

    movz	fp,	#2220
    str	x4,	[sp, fp]

    movz	fp,	#2220
    ldr	x5,	[sp, fp]

    str	w19,	[x5]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#93
    ble	main_413

main_301:
    movz	w17,	#93
    movz	fp,	#1364
    mov	w19,	w17
    ldr	x1,	[sp, fp]

    movz	fp,	#2212
    str	x1,	[sp, fp]

    movz	fp,	#2212
    ldr	x2,	[sp, fp]

    str	w19,	[x2]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#94
    ble	main_413

main_303:
    movz	w17,	#94
    movz	fp,	#1372
    ldr	x27,	[sp, fp]

    movz	fp,	#2204
    str	x27,	[sp, fp]

    movz	fp,	#2204
    ldr	x28,	[sp, fp]

    str	w17,	[x28]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#95
    ble	main_413

main_305:
    movz	w17,	#95
    movz	fp,	#1380
    ldr	x24,	[sp, fp]

    movz	fp,	#2196
    str	x24,	[sp, fp]

    movz	fp,	#2196
    ldr	x25,	[sp, fp]

    str	w17,	[x25]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#96
    ble	main_413

main_307:
    movz	w17,	#96
    movz	fp,	#1388
    ldr	x21,	[sp, fp]

    movz	fp,	#1868
    str	x21,	[sp, fp]

    movz	fp,	#1868
    ldr	x22,	[sp, fp]

    str	w17,	[x22]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#97
    ble	main_413

main_309:
    movz	w17,	#97
    movz	fp,	#1396
    ldr	x18,	[sp, fp]

    movz	fp,	#1860
    str	x18,	[sp, fp]

    movz	fp,	#1860
    ldr	x19,	[sp, fp]

    str	w17,	[x19]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#98
    ble	main_413

main_311:
    movz	w17,	#98
    movz	fp,	#1404
    mov	w19,	w17
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #640]

    ldr	x16,	[sp, #640]

    str	w19,	[x16]

    ldr	w17,	[sp, #1432]

    cmp	w17,	#99
    ble	main_413

main_313:
    movz	w17,	#99
    movz	fp,	#1412
    mov	w19,	w17
    ldr	x12,	[sp, fp]

    movz	fp,	#2060
    str	x12,	[sp, fp]

    movz	fp,	#2060
    ldr	x13,	[sp, fp]

    str	w19,	[x13]


main_413:
    ldr	w17,	[sp, #1420]

    add	w17,	w17,	#1
    str	w17,	[sp, #692]

    ldr	w17,	[sp, #1424]

    str	w17,	[sp, #648]

    movz	w17,	#0
    str	w17,	[sp, #616]


main_415:
    ldr	w17,	[sp, #616]

    cmp	w17,	#100
    bge	main_424

main_419:
    ldr	w17,	[sp, #616]

    lsl	w17,	w17,	#2
    mov	x17,	x17
    add	x17,	sp,	x17
    add	x17,	x17,	#16
    ldr	w19,	[x17]

    ldr	w13,	[sp, #648]

    str	w13,	[sp, #2948]

    ldr	w14,	[sp, #2948]

    ldr	w10,	[sp, #616]

    add	w21,	w19,	w14
    str	w10,	[sp, #2944]

    mov	w17,	w21
    ldr	w11,	[sp, #2944]

    add	w4,	w11,	#1
    str	w4,	[sp, #2936]

    ldr	w5,	[sp, #2936]

    str	w5,	[sp, #1064]

    str	w17,	[sp, #648]

    ldr	w17,	[sp, #1064]

    str	w17,	[sp, #616]

    b	main_415

main_424:
    movz	w17,	#65535
    ldr	w16,	[sp, #648]

    mov	w19,	w17
    str	w16,	[sp, #2952]

    ldr	w17,	[sp, #2952]

    sdiv	w17,	w17,	w19
    str	w17,	[sp, #628]

    ldr	w17,	[sp, #628]

    ldr	w7,	[sp, #628]

    lsl	w19,	w17,	#16
    str	w7,	[sp, #2940]

    ldr	w8,	[sp, #2940]

    sub	w17,	w19,	w8,	lsl #0
    ldr	w19,	[sp, #648]

    str	w19,	[sp, #2956]

    ldr	w20,	[sp, #2956]

    ldr	w7,	[sp, #692]

    sub	w20,	w20,	w17
    str	w7,	[sp, #2284]

    ldr	w22,	[sp, #1428]

    str	w22,	[sp, #2960]

    ldr	w8,	[sp, #2284]

    ldr	w0,	[sp, #2960]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w17,	w20
    str	w17,	[sp, #1424]

    ldr	w17,	[sp, #692]

    str	w17,	[sp, #1420]

    b	main_113

main_428:
    mov	w0,	w20
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


