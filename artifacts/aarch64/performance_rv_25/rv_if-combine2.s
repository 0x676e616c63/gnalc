.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #3408
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1380]

    bl	getint
    str	w0,	[sp, #1384]

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
    ldr	w15,	[sp, #1380]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x19,	sp,	#20
    movz	fp,	#1460
    add	x13,	sp,	#24
    add	x22,	sp,	#28
    add	x3,	sp,	#32
    add	x17,	sp,	#36
    add	x6,	sp,	#40
    add	x15,	sp,	#44
    add	x0,	sp,	#48
    add	x4,	sp,	#52
    add	x2,	sp,	#56
    add	x8,	sp,	#60
    add	x20,	sp,	#64
    add	x7,	sp,	#68
    add	x27,	sp,	#72
    add	x18,	sp,	#76
    add	x14,	sp,	#80
    add	x26,	sp,	#84
    add	x10,	sp,	#88
    add	x5,	sp,	#92
    add	x25,	sp,	#96
    add	x23,	sp,	#100
    add	x21,	sp,	#104
    add	x1,	sp,	#108
    add	x16,	sp,	#112
    add	x11,	sp,	#116
    add	x24,	sp,	#120
    add	x28,	sp,	#124
    add	x9,	sp,	#128
    str	x19,	[sp, fp]

    movz	fp,	#1444
    str	x13,	[sp, fp]

    movz	fp,	#1468
    str	x22,	[sp, fp]

    movz	fp,	#1804
    str	x3,	[sp, fp]

    movz	fp,	#1764
    str	x17,	[sp, fp]

    movz	fp,	#1812
    str	x6,	[sp, fp]

    movz	fp,	#1692
    str	x15,	[sp, fp]

    movz	fp,	#1796
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#1420
    str	x4,	[sp, fp]

    movz	fp,	#1724
    str	x2,	[sp, fp]

    movz	fp,	#1740
    str	x8,	[sp, fp]

    movz	fp,	#1772
    str	x20,	[sp, fp]

    movz	fp,	#1428
    str	x7,	[sp, fp]

    movz	fp,	#1404
    str	x27,	[sp, fp]

    movz	fp,	#1700
    str	x18,	[sp, fp]

    movz	fp,	#1756
    str	x14,	[sp, fp]

    movz	fp,	#1788
    str	x26,	[sp, fp]

    movz	fp,	#1436
    str	x10,	[sp, fp]

    movz	fp,	#1732
    str	x5,	[sp, fp]

    movz	fp,	#1708
    str	x25,	[sp, fp]

    movz	fp,	#1780
    str	x23,	[sp, fp]

    movz	fp,	#1388
    str	x21,	[sp, fp]

    movz	fp,	#1412
    str	x1,	[sp, fp]

    add	x1,	sp,	#136
    movz	fp,	#1452
    str	x16,	[sp, fp]

    movz	fp,	#1748
    str	x11,	[sp, fp]

    movz	fp,	#1396
    str	x24,	[sp, fp]

    movz	fp,	#1716
    str	x28,	[sp, fp]

    movz	fp,	#1820
    str	x9,	[sp, fp]

    movz	fp,	#972
    str	x0,	[sp, #576]

    add	x0,	sp,	#140
    str	x1,	[sp, #568]

    add	x1,	sp,	#144
    str	x0,	[sp, #832]

    add	x0,	sp,	#148
    str	x1,	[sp, #840]

    add	x1,	sp,	#152
    str	x0,	[sp, #848]

    add	x0,	sp,	#156
    str	x1,	[sp, #928]

    add	x1,	sp,	#164
    str	x0,	[sp, #936]

    add	x0,	sp,	#160
    str	x0,	[sp, #944]

    add	x0,	sp,	#168
    str	x1,	[sp, #952]

    add	x1,	sp,	#172
    str	x0,	[sp, #960]

    add	x0,	sp,	#176
    str	x1,	[sp, fp]

    add	x1,	sp,	#180
    movz	fp,	#980
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#988
    str	x1,	[sp, fp]

    add	x1,	sp,	#188
    movz	fp,	#996
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#1004
    str	x1,	[sp, fp]

    add	x1,	sp,	#200
    movz	fp,	#1012
    str	x0,	[sp, fp]

    movz	fp,	#1020
    add	x0,	sp,	#196
    str	x0,	[sp, #856]

    add	x0,	sp,	#204
    str	x1,	[sp, #864]

    add	x1,	sp,	#208
    str	x0,	[sp, #872]

    add	x0,	sp,	#212
    str	x1,	[sp, #880]

    add	x1,	sp,	#216
    str	x0,	[sp, #888]

    add	x0,	sp,	#220
    str	x1,	[sp, #896]

    add	x1,	sp,	#224
    str	x0,	[sp, #912]

    add	x0,	sp,	#228
    str	x1,	[sp, #920]

    add	x1,	sp,	#232
    str	x0,	[sp, fp]

    movz	fp,	#1028
    add	x0,	sp,	#240
    str	x1,	[sp, #904]

    add	x1,	sp,	#236
    str	x1,	[sp, #416]

    add	x1,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x1,	[sp, fp]

    add	x1,	sp,	#252
    movz	fp,	#1036
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#1044
    str	x1,	[sp, fp]

    add	x1,	sp,	#260
    movz	fp,	#1052
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#1060
    str	x1,	[sp, fp]

    add	x1,	sp,	#268
    movz	fp,	#1068
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#1076
    str	x1,	[sp, fp]

    add	x1,	sp,	#280
    movz	fp,	#1084
    str	x0,	[sp, fp]

    movz	fp,	#1092
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#1100
    str	x1,	[sp, fp]

    add	x1,	sp,	#288
    movz	fp,	#1108
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#1116
    str	x1,	[sp, fp]

    add	x1,	sp,	#296
    movz	fp,	#1124
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#1132
    str	x1,	[sp, fp]

    add	x1,	sp,	#304
    movz	fp,	#1140
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#1148
    str	x1,	[sp, fp]

    add	x1,	sp,	#316
    movz	fp,	#1156
    str	x0,	[sp, fp]

    movz	fp,	#1164
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#1172
    str	x1,	[sp, fp]

    add	x1,	sp,	#324
    movz	fp,	#1180
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#1188
    str	x1,	[sp, fp]

    add	x1,	sp,	#332
    movz	fp,	#1196
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#1204
    str	x1,	[sp, fp]

    add	x1,	sp,	#340
    movz	fp,	#1212
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1220
    str	x1,	[sp, fp]

    add	x1,	sp,	#348
    movz	fp,	#1228
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#1236
    str	x1,	[sp, fp]

    movz	fp,	#1244
    add	x1,	sp,	#352
    str	x1,	[sp, fp]

    add	x1,	sp,	#360
    movz	fp,	#1252
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#1260
    str	x1,	[sp, fp]

    add	x1,	sp,	#368
    movz	fp,	#1268
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#1276
    str	x1,	[sp, fp]

    add	x1,	sp,	#376
    movz	fp,	#1284
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#1292
    str	x1,	[sp, fp]

    add	x1,	sp,	#384
    movz	fp,	#1300
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#1308
    str	x1,	[sp, fp]

    add	x1,	sp,	#396
    movz	fp,	#1316
    str	x0,	[sp, fp]

    movz	fp,	#1324
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1332
    str	x1,	[sp, fp]

    add	x1,	sp,	#404
    movz	fp,	#1340
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1348
    str	x1,	[sp, fp]

    add	x1,	sp,	#412
    movz	fp,	#1356
    str	x0,	[sp, fp]

    movz	fp,	#1364
    str	x1,	[sp, fp]

    movz	w1,	#0
    mov	w0,	w1
    movz	w1,	#0
    str	w0,	[sp, #1376]

    mov	w0,	w1
    str	w0,	[sp, #1372]


main_113:
    ldr	w0,	[sp, #1384]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w1,	#1
    movz	fp,	#1460
    mov	w0,	w1
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#2
    ble	main_413

main_119:
    movz	w1,	#2
    movz	fp,	#1444
    ldr	x8,	[sp, fp]

    str	w1,	[x8]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w1,	#3
    movz	fp,	#1468
    mov	w0,	w1
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1804
    ldr	x1,	[sp, fp]

    str	w0,	[x1]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w1,	#5
    movz	fp,	#1764
    ldr	x13,	[sp, fp]

    str	w1,	[x13]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    movz	fp,	#1812
    ldr	x4,	[sp, fp]

    str	w0,	[x4]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    movz	fp,	#1692
    mov	w1,	w0
    ldr	x9,	[sp, fp]

    str	w1,	[x9]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#8
    ble	main_413

main_131:
    movz	w1,	#8
    movz	fp,	#1796
    ldr	x25,	[sp, fp]

    str	w1,	[x25]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    movz	fp,	#1420
    mov	w1,	w0
    ldr	x28,	[sp, fp]

    str	w1,	[x28]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#10
    ble	main_413

main_135:
    movz	w1,	#10
    movz	fp,	#1724
    mov	w0,	w1
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w1,	#11
    movz	fp,	#1740
    ldr	x4,	[sp, fp]

    str	w1,	[x4]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#12
    ble	main_413

main_139:
    movz	w1,	#12
    movz	fp,	#1772
    mov	w0,	w1
    ldr	x17,	[sp, fp]

    str	w0,	[x17]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1428
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#14
    ble	main_413

main_143:
    movz	w1,	#14
    movz	fp,	#1404
    ldr	x21,	[sp, fp]

    str	w1,	[x21]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    movz	fp,	#1700
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    movz	fp,	#1756
    mov	w1,	w0
    ldr	x10,	[sp, fp]

    str	w1,	[x10]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w1,	#17
    movz	fp,	#1788
    ldr	x22,	[sp, fp]

    str	w1,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1436
    mov	w1,	w0
    ldr	x5,	[sp, fp]

    str	w1,	[x5]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w1,	#19
    movz	fp,	#1732
    mov	w0,	w1
    ldr	x2,	[sp, fp]

    str	w0,	[x2]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#20
    ble	main_413

main_155:
    movz	w1,	#20
    movz	fp,	#1708
    ldr	x20,	[sp, fp]

    str	w1,	[x20]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w1,	#21
    movz	fp,	#1780
    mov	w0,	w1
    ldr	x20,	[sp, fp]

    str	w0,	[x20]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1388
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w1,	#23
    movz	fp,	#1412
    ldr	x24,	[sp, fp]

    str	w1,	[x24]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1452
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    movz	fp,	#1748
    mov	w1,	w0
    ldr	x7,	[sp, fp]

    str	w1,	[x7]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w1,	#26
    movz	fp,	#1396
    ldr	x18,	[sp, fp]

    str	w1,	[x18]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1716
    mov	w1,	w0
    ldr	x23,	[sp, fp]

    str	w1,	[x23]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w1,	#28
    movz	fp,	#1820
    mov	w0,	w1
    ldr	x7,	[sp, fp]

    str	w0,	[x7]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#29
    ble	main_413

main_173:
    movz	w1,	#29
    ldr	x0,	[sp, #576]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w1,	#30
    ldr	x22,	[sp, #568]

    mov	w0,	w1
    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    ldr	x22,	[sp, #832]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w1,	#32
    ldr	x0,	[sp, #840]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    ldr	x22,	[sp, #848]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    mov	w1,	w0
    ldr	x0,	[sp, #928]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#35
    ble	main_413

main_185:
    movz	w1,	#35
    ldr	x0,	[sp, #936]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    mov	w1,	w0
    ldr	x0,	[sp, #944]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#37
    ble	main_413

main_189:
    movz	w1,	#37
    ldr	x22,	[sp, #952]

    mov	w0,	w1
    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w1,	#38
    ldr	x0,	[sp, #960]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#39
    ble	main_413

main_193:
    movz	w1,	#39
    movz	fp,	#972
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#980
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#41
    ble	main_413

main_197:
    movz	w1,	#41
    movz	fp,	#988
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    movz	fp,	#996
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    movz	fp,	#1004
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w1,	#44
    movz	fp,	#1012
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    mov	w1,	w0
    ldr	x0,	[sp, #856]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w1,	#46
    ldr	x0,	[sp, #864]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#47
    ble	main_413

main_209:
    movz	w1,	#47
    ldr	x22,	[sp, #872]

    mov	w0,	w1
    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w1,	#48
    ldr	x22,	[sp, #880]

    mov	w0,	w1
    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    ldr	x22,	[sp, #888]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w1,	#50
    ldr	x22,	[sp, #896]

    mov	w0,	w1
    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    mov	w1,	w0
    ldr	x0,	[sp, #912]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    mov	w1,	w0
    ldr	x0,	[sp, #920]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#53
    ble	main_413

main_221:
    movz	w1,	#53
    movz	fp,	#1020
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    mov	w1,	w0
    ldr	x0,	[sp, #904]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w1,	#55
    ldr	x22,	[sp, #416]

    mov	w0,	w1
    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#56
    ble	main_413

main_227:
    movz	w1,	#56
    ldr	x0,	[sp, #424]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w1,	#57
    movz	fp,	#1028
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#1036
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w1,	#59
    movz	fp,	#1044
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#1052
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    movz	fp,	#1060
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#62
    ble	main_413

main_239:
    movz	w1,	#62
    movz	fp,	#1068
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#1076
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#64
    ble	main_413

main_243:
    movz	w1,	#64
    movz	fp,	#1084
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w1,	#65
    movz	fp,	#1092
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#66
    ble	main_413

main_247:
    movz	w1,	#66
    movz	fp,	#1100
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#1108
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#68
    ble	main_413

main_251:
    movz	w1,	#68
    movz	fp,	#1116
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#1124
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    movz	fp,	#1132
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w1,	#71
    movz	fp,	#1140
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#1148
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w1,	#73
    movz	fp,	#1156
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#74
    ble	main_413

main_263:
    movz	w1,	#74
    movz	fp,	#1164
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w1,	#75
    movz	fp,	#1172
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#1180
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w1,	#77
    movz	fp,	#1188
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#1196
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    movz	fp,	#1204
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#80
    ble	main_413

main_275:
    movz	w1,	#80
    movz	fp,	#1212
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#1220
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#82
    ble	main_413

main_279:
    movz	w1,	#82
    movz	fp,	#1228
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w1,	#83
    movz	fp,	#1236
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w1,	#84
    movz	fp,	#1244
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1252
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w1,	#86
    movz	fp,	#1260
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#1268
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    movz	fp,	#1276
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#89
    ble	main_413

main_293:
    movz	w1,	#89
    movz	fp,	#1284
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#1292
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#91
    ble	main_413

main_297:
    movz	w1,	#91
    movz	fp,	#1300
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w1,	#92
    movz	fp,	#1308
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#93
    ble	main_413

main_301:
    movz	w1,	#93
    movz	fp,	#1316
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1324
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#95
    ble	main_413

main_305:
    movz	w1,	#95
    movz	fp,	#1332
    ldr	x0,	[sp, fp]

    str	w1,	[x0]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#1340
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    movz	fp,	#1348
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1384]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w1,	#98
    movz	fp,	#1356
    mov	w0,	w1
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w1,	[sp, #1384]

    cmp	w1,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#1364
    mov	w1,	w0
    ldr	x0,	[sp, fp]

    str	w1,	[x0]


main_413:
    ldr	w1,	[sp, #1372]

    add	w0,	w1,	#1
    str	w0,	[sp, #596]

    ldr	w0,	[sp, #1376]

    str	w0,	[sp, #432]

    movz	w0,	#0
    mov	w1,	w0
    str	w1,	[sp, #436]


main_415:
    ldr	w0,	[sp, #436]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w1,	[sp, #436]

    lsl	w0,	w1,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w1,	[sp, #432]

    add	w3,	w0,	w1
    str	w3,	[sp, #2948]

    ldr	w0,	[sp, #436]

    add	w1,	w0,	#1
    str	w1,	[sp, #968]

    ldr	w4,	[sp, #2948]

    mov	w0,	w4
    str	w0,	[sp, #432]

    ldr	w1,	[sp, #968]

    str	w1,	[sp, #436]

    b	main_415

main_424:
    movz	w1,	#65535
    ldr	w0,	[sp, #432]

    sdiv	w1,	w0,	w1
    str	w1,	[sp, #584]

    ldr	w0,	[sp, #584]

    lsl	w28,	w0,	#16
    str	w28,	[sp, #2436]

    ldr	w1,	[sp, #584]

    ldr	w0,	[sp, #2436]

    sub	w22,	w0,	w1,	lsl #0
    ldr	w0,	[sp, #432]

    ldr	w2,	[sp, #596]

    sub	w1,	w0,	w22
    str	w2,	[sp, #2440]

    ldr	w6,	[sp, #1380]

    str	w6,	[sp, #1996]

    ldr	w8,	[sp, #1996]

    ldr	w3,	[sp, #2440]

    cmp	w3,	w8
    bge	main_428

main_112:
    mov	w0,	w1
    str	w0,	[sp, #1376]

    ldr	w0,	[sp, #596]

    str	w0,	[sp, #1372]

    b	main_113

main_428:
    mov	w0,	w1
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
    
    add	sp, sp, #3408
    ret


