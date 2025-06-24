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
    str	w0,	[sp, #1396]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1400]

    mov	w0,	w26

main_4:
    cmp	w0,	#100
    bge	main_10

main_7:
    lsl	w10,	w0,	#2
    movz	w25,	#0
    add	w26,	w0,	#1
    mov	x2,	x10
    mov	w0,	w26
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    str	w25,	[x2]

    b	main_4

main_10:
    movz	w27,	#0
    ldr	w15,	[sp, #1396]

    cmp	w27,	w15
    bge	main_427

main_12:
    add	x7,	sp,	#20
    movz	fp,	#1668
    add	x4,	sp,	#24
    add	x26,	sp,	#28
    add	x15,	sp,	#32
    add	x11,	sp,	#36
    add	x13,	sp,	#40
    add	x27,	sp,	#44
    add	x1,	sp,	#48
    add	x9,	sp,	#52
    add	x22,	sp,	#56
    add	x19,	sp,	#60
    add	x16,	sp,	#64
    add	x5,	sp,	#68
    add	x24,	sp,	#72
    add	x18,	sp,	#76
    add	x6,	sp,	#80
    add	x14,	sp,	#84
    add	x3,	sp,	#88
    add	x28,	sp,	#92
    add	x25,	sp,	#96
    add	x8,	sp,	#100
    add	x21,	sp,	#104
    add	x20,	sp,	#108
    add	x17,	sp,	#112
    add	x2,	sp,	#116
    add	x10,	sp,	#120
    add	x23,	sp,	#124
    add	x0,	sp,	#128
    str	x7,	[sp, fp]

    movz	fp,	#1660
    str	x4,	[sp, fp]

    movz	fp,	#1804
    str	x26,	[sp, fp]

    movz	fp,	#1572
    str	x15,	[sp, fp]

    movz	fp,	#1764
    str	x11,	[sp, fp]

    movz	fp,	#1684
    str	x13,	[sp, fp]

    movz	fp,	#1644
    str	x27,	[sp, fp]

    movz	fp,	#1652
    str	x1,	[sp, fp]

    movz	fp,	#1836
    str	x9,	[sp, fp]

    movz	fp,	#1708
    str	x22,	[sp, fp]

    movz	fp,	#1700
    str	x19,	[sp, fp]

    movz	fp,	#1692
    str	x16,	[sp, fp]

    movz	fp,	#1748
    str	x5,	[sp, fp]

    movz	fp,	#1596
    str	x24,	[sp, fp]

    movz	fp,	#1580
    str	x18,	[sp, fp]

    movz	fp,	#1828
    str	x6,	[sp, fp]

    add	x6,	sp,	#132
    movz	fp,	#1772
    str	x14,	[sp, fp]

    movz	fp,	#1820
    str	x3,	[sp, fp]

    movz	fp,	#1732
    str	x28,	[sp, fp]

    movz	fp,	#1724
    str	x25,	[sp, fp]

    movz	fp,	#1756
    str	x8,	[sp, fp]

    movz	fp,	#1588
    str	x21,	[sp, fp]

    movz	fp,	#1788
    str	x20,	[sp, fp]

    movz	fp,	#1780
    str	x17,	[sp, fp]

    movz	fp,	#1740
    str	x2,	[sp, fp]

    movz	fp,	#1676
    str	x10,	[sp, fp]

    movz	fp,	#1796
    str	x23,	[sp, fp]

    movz	fp,	#1812
    str	x0,	[sp, fp]

    movz	fp,	#596
    add	x0,	sp,	#136
    str	x6,	[sp, #448]

    add	x6,	sp,	#140
    str	x0,	[sp, fp]

    movz	fp,	#988
    add	x0,	sp,	#144
    str	x6,	[sp, #440]

    add	x6,	sp,	#148
    str	x0,	[sp, #608]

    add	x0,	sp,	#152
    str	x6,	[sp, fp]

    add	x6,	sp,	#156
    movz	fp,	#996
    str	x0,	[sp, fp]

    add	x0,	sp,	#160
    movz	fp,	#1004
    str	x6,	[sp, fp]

    add	x6,	sp,	#164
    movz	fp,	#1012
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#1020
    str	x6,	[sp, fp]

    add	x6,	sp,	#172
    movz	fp,	#1028
    str	x0,	[sp, fp]

    movz	fp,	#1036
    add	x0,	sp,	#176
    str	x6,	[sp, #624]

    add	x6,	sp,	#180
    str	x0,	[sp, #632]

    add	x0,	sp,	#184
    str	x6,	[sp, #640]

    add	x6,	sp,	#188
    str	x0,	[sp, #648]

    add	x0,	sp,	#192
    str	x6,	[sp, #656]

    add	x6,	sp,	#196
    str	x0,	[sp, #664]

    add	x0,	sp,	#200
    str	x6,	[sp, #672]

    add	x6,	sp,	#204
    str	x0,	[sp, #680]

    add	x0,	sp,	#208
    str	x6,	[sp, #688]

    add	x6,	sp,	#212
    str	x0,	[sp, #696]

    add	x0,	sp,	#216
    str	x6,	[sp, #704]

    add	x6,	sp,	#220
    str	x0,	[sp, #712]

    add	x0,	sp,	#224
    str	x6,	[sp, #728]

    add	x6,	sp,	#228
    str	x0,	[sp, #736]

    add	x0,	sp,	#232
    str	x6,	[sp, fp]

    movz	fp,	#1044
    add	x6,	sp,	#236
    str	x0,	[sp, #720]

    add	x0,	sp,	#240
    str	x6,	[sp, #416]

    add	x6,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x6,	[sp, fp]

    add	x6,	sp,	#252
    movz	fp,	#1052
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#1060
    str	x6,	[sp, fp]

    add	x6,	sp,	#260
    movz	fp,	#1068
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#1076
    str	x6,	[sp, fp]

    add	x6,	sp,	#268
    movz	fp,	#1084
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#1092
    str	x6,	[sp, fp]

    add	x6,	sp,	#276
    movz	fp,	#1100
    str	x0,	[sp, fp]

    add	x0,	sp,	#280
    movz	fp,	#1108
    str	x6,	[sp, fp]

    add	x6,	sp,	#284
    movz	fp,	#1116
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#1124
    str	x6,	[sp, fp]

    add	x6,	sp,	#292
    movz	fp,	#1132
    str	x0,	[sp, fp]

    add	x0,	sp,	#296
    movz	fp,	#1140
    str	x6,	[sp, fp]

    add	x6,	sp,	#300
    movz	fp,	#1148
    str	x0,	[sp, fp]

    add	x0,	sp,	#304
    movz	fp,	#1156
    str	x6,	[sp, fp]

    add	x6,	sp,	#308
    movz	fp,	#1164
    str	x0,	[sp, fp]

    add	x0,	sp,	#312
    movz	fp,	#1172
    str	x6,	[sp, fp]

    add	x6,	sp,	#316
    movz	fp,	#1180
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#1188
    str	x6,	[sp, fp]

    add	x6,	sp,	#324
    movz	fp,	#1196
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#1204
    str	x6,	[sp, fp]

    add	x6,	sp,	#332
    movz	fp,	#1212
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#1220
    str	x6,	[sp, fp]

    add	x6,	sp,	#340
    movz	fp,	#1228
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1236
    str	x6,	[sp, fp]

    add	x6,	sp,	#348
    movz	fp,	#1244
    str	x0,	[sp, fp]

    add	x0,	sp,	#352
    movz	fp,	#1252
    str	x6,	[sp, fp]

    add	x6,	sp,	#356
    movz	fp,	#1260
    str	x0,	[sp, fp]

    add	x0,	sp,	#360
    movz	fp,	#1268
    str	x6,	[sp, fp]

    add	x6,	sp,	#364
    movz	fp,	#1276
    str	x0,	[sp, fp]

    add	x0,	sp,	#368
    movz	fp,	#1284
    str	x6,	[sp, fp]

    add	x6,	sp,	#372
    movz	fp,	#1292
    str	x0,	[sp, fp]

    add	x0,	sp,	#376
    movz	fp,	#1300
    str	x6,	[sp, fp]

    add	x6,	sp,	#380
    movz	fp,	#1308
    str	x0,	[sp, fp]

    add	x0,	sp,	#384
    movz	fp,	#1316
    str	x6,	[sp, fp]

    add	x6,	sp,	#388
    movz	fp,	#1324
    str	x0,	[sp, fp]

    add	x0,	sp,	#392
    movz	fp,	#1332
    str	x6,	[sp, fp]

    add	x6,	sp,	#396
    movz	fp,	#1340
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1348
    str	x6,	[sp, fp]

    add	x6,	sp,	#404
    movz	fp,	#1356
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1364
    str	x6,	[sp, fp]

    add	x6,	sp,	#412
    movz	fp,	#1372
    str	x0,	[sp, fp]

    movz	w0,	#0
    movz	fp,	#1380
    str	x6,	[sp, fp]

    str	w0,	[sp, #1392]

    movz	w0,	#0
    str	w0,	[sp, #1388]


main_113:
    ldr	w6,	[sp, #1400]

    cmp	w6,	#1
    ble	main_413

main_117:
    movz	w0,	#1
    movz	fp,	#1668
    ldr	x2,	[sp, fp]

    str	w0,	[x2]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#2
    ble	main_413

main_119:
    movz	w0,	#2
    movz	fp,	#1660
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#3
    ble	main_413

main_121:
    movz	w0,	#3
    movz	fp,	#1804
    ldr	x23,	[sp, fp]

    str	w0,	[x23]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1572
    ldr	x9,	[sp, fp]

    str	w0,	[x9]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#5
    ble	main_413

main_125:
    movz	w0,	#5
    movz	fp,	#1764
    ldr	x7,	[sp, fp]

    str	w0,	[x7]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    movz	fp,	#1684
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    movz	fp,	#1644
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    movz	fp,	#1652
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    movz	fp,	#1836
    ldr	x6,	[sp, fp]

    str	w0,	[x6]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#10
    ble	main_413

main_135:
    movz	w0,	#10
    movz	fp,	#1708
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#11
    ble	main_413

main_137:
    movz	w0,	#11
    movz	fp,	#1700
    ldr	x14,	[sp, fp]

    str	w0,	[x14]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#12
    ble	main_413

main_139:
    movz	w0,	#12
    movz	fp,	#1692
    ldr	x11,	[sp, fp]

    str	w0,	[x11]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1748
    ldr	x1,	[sp, fp]

    str	w0,	[x1]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#14
    ble	main_413

main_143:
    movz	w0,	#14
    movz	fp,	#1596
    ldr	x19,	[sp, fp]

    str	w0,	[x19]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    movz	fp,	#1580
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    movz	fp,	#1828
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    movz	fp,	#1772
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1820
    ldr	x1,	[sp, fp]

    str	w0,	[x1]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#19
    ble	main_413

main_153:
    movz	w0,	#19
    movz	fp,	#1732
    ldr	x24,	[sp, fp]

    str	w0,	[x24]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#20
    ble	main_413

main_155:
    movz	w0,	#20
    movz	fp,	#1724
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#21
    ble	main_413

main_157:
    movz	w0,	#21
    movz	fp,	#1756
    ldr	x4,	[sp, fp]

    str	w0,	[x4]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1588
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#23
    ble	main_413

main_161:
    movz	w0,	#23
    movz	fp,	#1788
    ldr	x17,	[sp, fp]

    str	w0,	[x17]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1780
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    movz	fp,	#1740
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    movz	fp,	#1676
    ldr	x5,	[sp, fp]

    str	w0,	[x5]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1796
    ldr	x20,	[sp, fp]

    str	w0,	[x20]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w0,	#28
    movz	fp,	#1812
    ldr	x26,	[sp, fp]

    str	w0,	[x26]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#29
    ble	main_413

main_173:
    movz	w0,	#29
    mov	w6,	w0
    ldr	x0,	[sp, #448]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w0,	#30
    movz	fp,	#596
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    mov	w6,	w0
    ldr	x0,	[sp, #440]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w0,	#32
    mov	w6,	w0
    ldr	x0,	[sp, #608]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    movz	fp,	#988
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    movz	fp,	#996
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    movz	fp,	#1004
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    movz	fp,	#1012
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#37
    ble	main_413

main_189:
    movz	w0,	#37
    movz	fp,	#1020
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w0,	#38
    movz	fp,	#1028
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#39
    ble	main_413

main_193:
    movz	w0,	#39
    mov	w6,	w0
    ldr	x0,	[sp, #624]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    mov	w6,	w0
    ldr	x0,	[sp, #632]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#41
    ble	main_413

main_197:
    movz	w0,	#41
    mov	w6,	w0
    ldr	x0,	[sp, #640]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    mov	w6,	w0
    ldr	x0,	[sp, #648]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    mov	w6,	w0
    ldr	x0,	[sp, #656]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    mov	w6,	w0
    ldr	x0,	[sp, #664]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    mov	w6,	w0
    ldr	x0,	[sp, #672]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w0,	#46
    mov	w6,	w0
    ldr	x0,	[sp, #680]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#47
    ble	main_413

main_209:
    movz	w0,	#47
    mov	w6,	w0
    ldr	x0,	[sp, #688]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w0,	#48
    mov	w6,	w0
    ldr	x0,	[sp, #696]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    mov	w6,	w0
    ldr	x0,	[sp, #704]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w0,	#50
    mov	w6,	w0
    ldr	x0,	[sp, #712]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    mov	w6,	w0
    ldr	x0,	[sp, #728]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    mov	w6,	w0
    ldr	x0,	[sp, #736]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    movz	fp,	#1036
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    mov	w6,	w0
    ldr	x0,	[sp, #720]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#55
    ble	main_413

main_225:
    movz	w0,	#55
    mov	w6,	w0
    ldr	x0,	[sp, #416]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#56
    ble	main_413

main_227:
    movz	w0,	#56
    mov	w6,	w0
    ldr	x0,	[sp, #424]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#57
    ble	main_413

main_229:
    movz	w0,	#57
    movz	fp,	#1044
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#1052
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#59
    ble	main_413

main_233:
    movz	w0,	#59
    movz	fp,	#1060
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#1068
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    movz	fp,	#1076
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    movz	fp,	#1084
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#1092
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#64
    ble	main_413

main_243:
    movz	w0,	#64
    movz	fp,	#1100
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#65
    ble	main_413

main_245:
    movz	w0,	#65
    movz	fp,	#1108
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#66
    ble	main_413

main_247:
    movz	w0,	#66
    movz	fp,	#1116
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#1124
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#68
    ble	main_413

main_251:
    movz	w0,	#68
    movz	fp,	#1132
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1400]

    cmp	w6,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#1140
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    movz	fp,	#1148
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    movz	fp,	#1156
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#1164
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w0,	#73
    movz	fp,	#1172
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#74
    ble	main_413

main_263:
    movz	w0,	#74
    movz	fp,	#1180
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w0,	#75
    movz	fp,	#1188
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#1196
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w0,	#77
    movz	fp,	#1204
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#1212
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    movz	fp,	#1220
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    movz	fp,	#1228
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#1236
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#82
    ble	main_413

main_279:
    movz	w0,	#82
    movz	fp,	#1244
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w0,	#83
    movz	fp,	#1252
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w0,	#84
    movz	fp,	#1260
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1268
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w0,	#86
    movz	fp,	#1276
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#1284
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    movz	fp,	#1292
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    movz	fp,	#1300
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#1308
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#91
    ble	main_413

main_297:
    movz	w0,	#91
    movz	fp,	#1316
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w0,	#92
    movz	fp,	#1324
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#93
    ble	main_413

main_301:
    movz	w0,	#93
    movz	fp,	#1332
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1340
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#95
    ble	main_413

main_305:
    movz	w0,	#95
    movz	fp,	#1348
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#1356
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    movz	fp,	#1364
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    movz	fp,	#1372
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1400]

    cmp	w0,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#1380
    mov	w6,	w0
    ldr	x0,	[sp, fp]

    str	w6,	[x0]


main_413:
    ldr	w6,	[sp, #1388]

    add	w6,	w6,	#1
    str	w6,	[sp, #456]

    ldr	w0,	[sp, #1392]

    str	w0,	[sp, #616]

    movz	w0,	#0
    str	w0,	[sp, #620]


main_415:
    ldr	w0,	[sp, #620]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w6,	[sp, #620]

    lsl	w0,	w6,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    str	w0,	[sp, #3180]

    ldr	w0,	[sp, #616]

    ldr	w1,	[sp, #3180]

    ldr	w6,	[sp, #620]

    add	w0,	w1,	w0
    add	w6,	w6,	#1
    str	w6,	[sp, #604]

    str	w0,	[sp, #616]

    ldr	w0,	[sp, #604]

    str	w0,	[sp, #620]

    b	main_415

main_424:
    movz	w0,	#65535
    ldr	w6,	[sp, #616]

    sdiv	w6,	w6,	w0
    str	w6,	[sp, #984]

    ldr	w0,	[sp, #984]

    ldr	w6,	[sp, #984]

    lsl	w0,	w0,	#16
    sub	w0,	w0,	w6,	lsl #0
    ldr	w6,	[sp, #616]

    ldr	w25,	[sp, #456]

    sub	w0,	w6,	w0
    str	w25,	[sp, #3160]

    ldr	w7,	[sp, #1396]

    str	w7,	[sp, #2848]

    ldr	w11,	[sp, #2848]

    ldr	w26,	[sp, #3160]

    cmp	w26,	w11
    bge	main_429

main_112:
    str	w0,	[sp, #1392]

    ldr	w0,	[sp, #456]

    str	w0,	[sp, #1388]

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


