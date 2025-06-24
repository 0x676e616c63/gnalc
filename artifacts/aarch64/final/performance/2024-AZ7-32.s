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
    str	w0,	[sp, #1436]

    bl	getint
    str	w0,	[sp, #1440]

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
    ldr	w15,	[sp, #1436]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x6,	sp,	#20
    add	x27,	sp,	#24
    movz	fp,	#1468
    add	x19,	sp,	#28
    add	x21,	sp,	#32
    add	x2,	sp,	#36
    add	x9,	sp,	#40
    add	x4,	sp,	#44
    add	x20,	sp,	#48
    add	x5,	sp,	#52
    add	x18,	sp,	#56
    add	x22,	sp,	#60
    add	x16,	sp,	#64
    add	x0,	sp,	#68
    add	x17,	sp,	#72
    add	x11,	sp,	#76
    add	x23,	sp,	#80
    add	x10,	sp,	#84
    add	x24,	sp,	#88
    add	x15,	sp,	#92
    add	x28,	sp,	#96
    add	x13,	sp,	#100
    add	x3,	sp,	#104
    add	x14,	sp,	#108
    add	x7,	sp,	#112
    add	x26,	sp,	#116
    add	x8,	sp,	#120
    add	x25,	sp,	#124
    add	x1,	sp,	#128
    str	x6,	[sp, #2112]

    str	x27,	[sp, fp]

    movz	fp,	#1844
    str	x19,	[sp, fp]

    movz	fp,	#1452
    str	x21,	[sp, fp]

    movz	fp,	#1804
    str	x2,	[sp, #2024]

    str	x9,	[sp, #2120]

    str	x4,	[sp, fp]

    movz	fp,	#1444
    str	x20,	[sp, #2072]

    str	x5,	[sp, #2032]

    str	x18,	[sp, fp]

    movz	fp,	#1852
    str	x22,	[sp, fp]

    movz	fp,	#1836
    str	x16,	[sp, fp]

    movz	fp,	#1820
    str	x0,	[sp, #2096]

    add	x0,	sp,	#132
    str	x17,	[sp, #2064]

    str	x11,	[sp, #2048]

    str	x23,	[sp, #2080]

    str	x10,	[sp, fp]

    movz	fp,	#1460
    str	x24,	[sp, fp]

    movz	fp,	#1740
    str	x15,	[sp, fp]

    movz	fp,	#1828
    str	x28,	[sp, #2016]

    add	x28,	sp,	#136
    str	x13,	[sp, fp]

    movz	fp,	#1812
    str	x3,	[sp, #2104]

    str	x14,	[sp, #2056]

    str	x7,	[sp, fp]

    movz	fp,	#1860
    str	x26,	[sp, #2088]

    str	x8,	[sp, #2040]

    str	x25,	[sp, fp]

    movz	fp,	#1476
    str	x1,	[sp, fp]

    movz	fp,	#1060
    str	x0,	[sp, #448]

    add	x0,	sp,	#140
    str	x28,	[sp, #600]

    add	x28,	sp,	#144
    str	x0,	[sp, fp]

    add	x0,	sp,	#148
    movz	fp,	#1068
    str	x28,	[sp, fp]

    add	x28,	sp,	#152
    movz	fp,	#764
    str	x0,	[sp, fp]

    add	x0,	sp,	#156
    movz	fp,	#772
    str	x28,	[sp, fp]

    add	x28,	sp,	#164
    movz	fp,	#780
    str	x0,	[sp, fp]

    movz	fp,	#788
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#796
    str	x28,	[sp, fp]

    add	x28,	sp,	#172
    movz	fp,	#804
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#812
    str	x28,	[sp, fp]

    add	x28,	sp,	#180
    movz	fp,	#820
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#828
    str	x28,	[sp, fp]

    add	x28,	sp,	#188
    movz	fp,	#836
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#844
    str	x28,	[sp, fp]

    add	x28,	sp,	#200
    movz	fp,	#860
    str	x0,	[sp, fp]

    movz	fp,	#868
    add	x0,	sp,	#196
    str	x0,	[sp, fp]

    add	x0,	sp,	#204
    movz	fp,	#876
    str	x28,	[sp, fp]

    add	x28,	sp,	#208
    movz	fp,	#884
    str	x0,	[sp, fp]

    add	x0,	sp,	#212
    movz	fp,	#892
    str	x28,	[sp, fp]

    add	x28,	sp,	#216
    movz	fp,	#900
    str	x0,	[sp, fp]

    add	x0,	sp,	#220
    movz	fp,	#908
    str	x28,	[sp, fp]

    add	x28,	sp,	#224
    movz	fp,	#916
    str	x0,	[sp, fp]

    add	x0,	sp,	#228
    movz	fp,	#1076
    str	x28,	[sp, fp]

    add	x28,	sp,	#232
    movz	fp,	#1084
    str	x0,	[sp, fp]

    add	x0,	sp,	#240
    movz	fp,	#852
    str	x28,	[sp, fp]

    movz	fp,	#1092
    add	x28,	sp,	#236
    str	x28,	[sp, #416]

    add	x28,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x28,	[sp, #432]

    add	x28,	sp,	#252
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#1100
    str	x28,	[sp, fp]

    add	x28,	sp,	#260
    movz	fp,	#1108
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#1116
    str	x28,	[sp, fp]

    add	x28,	sp,	#268
    movz	fp,	#1124
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#1132
    str	x28,	[sp, fp]

    add	x28,	sp,	#280
    movz	fp,	#1140
    str	x0,	[sp, fp]

    movz	fp,	#1148
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#1156
    str	x28,	[sp, fp]

    add	x28,	sp,	#288
    movz	fp,	#1164
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#1172
    str	x28,	[sp, fp]

    add	x28,	sp,	#296
    movz	fp,	#1180
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#1188
    str	x28,	[sp, fp]

    add	x28,	sp,	#304
    movz	fp,	#1196
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#1204
    str	x28,	[sp, fp]

    add	x28,	sp,	#316
    movz	fp,	#1212
    str	x0,	[sp, fp]

    movz	fp,	#1220
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#1228
    str	x28,	[sp, fp]

    add	x28,	sp,	#324
    movz	fp,	#1236
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#1244
    str	x28,	[sp, fp]

    add	x28,	sp,	#332
    movz	fp,	#1252
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#1260
    str	x28,	[sp, fp]

    add	x28,	sp,	#340
    movz	fp,	#1268
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1276
    str	x28,	[sp, fp]

    add	x28,	sp,	#348
    movz	fp,	#1284
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#1292
    str	x28,	[sp, fp]

    movz	fp,	#1300
    add	x28,	sp,	#352
    str	x28,	[sp, fp]

    add	x28,	sp,	#360
    movz	fp,	#1308
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#1316
    str	x28,	[sp, fp]

    add	x28,	sp,	#368
    movz	fp,	#1324
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#1332
    str	x28,	[sp, fp]

    add	x28,	sp,	#376
    movz	fp,	#1340
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#1348
    str	x28,	[sp, fp]

    add	x28,	sp,	#384
    movz	fp,	#1356
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#1364
    str	x28,	[sp, fp]

    add	x28,	sp,	#396
    movz	fp,	#1372
    str	x0,	[sp, fp]

    movz	fp,	#1380
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1388
    str	x28,	[sp, fp]

    add	x28,	sp,	#404
    movz	fp,	#1396
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1404
    str	x28,	[sp, fp]

    add	x28,	sp,	#412
    movz	fp,	#1412
    str	x0,	[sp, fp]

    movz	fp,	#1420
    str	x28,	[sp, fp]

    movz	w28,	#0
    mov	w0,	w28
    movz	w28,	#0
    str	w0,	[sp, #1432]

    mov	w0,	w28
    str	w0,	[sp, #1428]


main_113:
    ldr	w0,	[sp, #1440]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w28,	#1
    ldr	x4,	[sp, #2112]

    mov	w0,	w28
    str	w0,	[x4]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#2
    ble	main_413

main_119:
    movz	w28,	#2
    movz	fp,	#1468
    ldr	x21,	[sp, fp]

    str	w28,	[x21]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w28,	#3
    movz	fp,	#1844
    mov	w0,	w28
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1452
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w28,	#5
    ldr	x26,	[sp, #2024]

    str	w28,	[x26]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    ldr	x7,	[sp, #2120]

    str	w0,	[x7]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    movz	fp,	#1804
    mov	w28,	w0
    ldr	x27,	[sp, fp]

    str	w28,	[x27]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#8
    ble	main_413

main_131:
    movz	w28,	#8
    ldr	x15,	[sp, #2072]

    str	w28,	[x15]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    mov	w28,	w0
    ldr	x0,	[sp, #2032]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#10
    ble	main_413

main_135:
    movz	w28,	#10
    movz	fp,	#1444
    mov	w0,	w28
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w28,	#11
    movz	fp,	#1852
    ldr	x16,	[sp, fp]

    str	w28,	[x16]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#12
    ble	main_413

main_139:
    movz	w28,	#12
    movz	fp,	#1836
    mov	w0,	w28
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    ldr	x26,	[sp, #2096]

    str	w0,	[x26]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#14
    ble	main_413

main_143:
    movz	w28,	#14
    ldr	x12,	[sp, #2064]

    str	w28,	[x12]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    ldr	x8,	[sp, #2048]

    str	w0,	[x8]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    ldr	x19,	[sp, #2080]

    mov	w28,	w0
    str	w28,	[x19]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w28,	#17
    movz	fp,	#1820
    ldr	x4,	[sp, fp]

    str	w28,	[x4]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1460
    mov	w28,	w0
    ldr	x18,	[sp, fp]

    str	w28,	[x18]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w28,	#19
    movz	fp,	#1740
    mov	w0,	w28
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#20
    ble	main_413

main_155:
    movz	w28,	#20
    ldr	x23,	[sp, #2016]

    str	w28,	[x23]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w28,	#21
    movz	fp,	#1828
    mov	w0,	w28
    ldr	x9,	[sp, fp]

    str	w0,	[x9]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    ldr	x1,	[sp, #2104]

    str	w0,	[x1]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w28,	#23
    ldr	x9,	[sp, #2056]

    str	w28,	[x9]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1812
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    ldr	x22,	[sp, #2088]

    mov	w28,	w0
    str	w28,	[x22]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w28,	#26
    ldr	x3,	[sp, #2040]

    str	w28,	[x3]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1860
    mov	w28,	w0
    ldr	x20,	[sp, fp]

    str	w28,	[x20]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w28,	#28
    movz	fp,	#1476
    mov	w0,	w28
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#29
    ble	main_413

main_173:
    movz	w28,	#29
    ldr	x0,	[sp, #448]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w28,	#30
    mov	w0,	w28
    ldr	x28,	[sp, #600]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    movz	fp,	#1060
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w28,	#32
    movz	fp,	#1068
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    movz	fp,	#764
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    movz	fp,	#772
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#35
    ble	main_413

main_185:
    movz	w28,	#35
    movz	fp,	#780
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    movz	fp,	#788
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#37
    ble	main_413

main_189:
    movz	w28,	#37
    movz	fp,	#796
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w28,	#38
    movz	fp,	#804
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#39
    ble	main_413

main_193:
    movz	w28,	#39
    movz	fp,	#812
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#820
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#41
    ble	main_413

main_197:
    movz	w28,	#41
    movz	fp,	#828
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    movz	fp,	#836
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    movz	fp,	#844
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w28,	#44
    movz	fp,	#860
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    movz	fp,	#868
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w28,	#46
    movz	fp,	#876
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#47
    ble	main_413

main_209:
    movz	w28,	#47
    movz	fp,	#884
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w28,	#48
    movz	fp,	#892
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    movz	fp,	#900
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w28,	#50
    movz	fp,	#908
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    movz	fp,	#916
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    movz	fp,	#1076
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#53
    ble	main_413

main_221:
    movz	w28,	#53
    movz	fp,	#1084
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    movz	fp,	#852
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w28,	#55
    mov	w0,	w28
    ldr	x28,	[sp, #416]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#56
    ble	main_413

main_227:
    movz	w28,	#56
    ldr	x0,	[sp, #424]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w28,	#57
    mov	w0,	w28
    ldr	x28,	[sp, #432]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#1092
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w28,	#59
    movz	fp,	#1100
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#1108
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    movz	fp,	#1116
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#62
    ble	main_413

main_239:
    movz	w28,	#62
    movz	fp,	#1124
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#1132
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#64
    ble	main_413

main_243:
    movz	w28,	#64
    movz	fp,	#1140
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w28,	#65
    movz	fp,	#1148
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#66
    ble	main_413

main_247:
    movz	w28,	#66
    movz	fp,	#1156
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#1164
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#68
    ble	main_413

main_251:
    movz	w28,	#68
    movz	fp,	#1172
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#1180
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    movz	fp,	#1188
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w28,	#71
    movz	fp,	#1196
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#1204
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w28,	#73
    movz	fp,	#1212
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#74
    ble	main_413

main_263:
    movz	w28,	#74
    movz	fp,	#1220
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w28,	#75
    movz	fp,	#1228
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#1236
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w28,	#77
    movz	fp,	#1244
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#1252
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    movz	fp,	#1260
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#80
    ble	main_413

main_275:
    movz	w28,	#80
    movz	fp,	#1268
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#1276
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#82
    ble	main_413

main_279:
    movz	w28,	#82
    movz	fp,	#1284
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w28,	#83
    movz	fp,	#1292
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w28,	#84
    movz	fp,	#1300
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1308
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w28,	#86
    movz	fp,	#1316
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#1324
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    movz	fp,	#1332
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#89
    ble	main_413

main_293:
    movz	w28,	#89
    movz	fp,	#1340
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#1348
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#91
    ble	main_413

main_297:
    movz	w28,	#91
    movz	fp,	#1356
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w28,	#92
    movz	fp,	#1364
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#93
    ble	main_413

main_301:
    movz	w28,	#93
    movz	fp,	#1372
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1380
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#95
    ble	main_413

main_305:
    movz	w28,	#95
    movz	fp,	#1388
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#1396
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    movz	fp,	#1404
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1440]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w28,	#98
    movz	fp,	#1412
    mov	w0,	w28
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w28,	[sp, #1440]

    cmp	w28,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#1420
    mov	w28,	w0
    ldr	x0,	[sp, fp]

    str	w28,	[x0]


main_413:
    ldr	w28,	[sp, #1428]

    add	w0,	w28,	#1
    str	w0,	[sp, #760]

    ldr	w0,	[sp, #1432]

    str	w0,	[sp, #440]

    movz	w0,	#0
    mov	w28,	w0
    str	w28,	[sp, #608]


main_415:
    ldr	w0,	[sp, #608]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w28,	[sp, #608]

    lsl	w0,	w28,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w28,	[sp, #440]

    add	w3,	w0,	w28
    str	w3,	[sp, #3104]

    ldr	w0,	[sp, #608]

    add	w28,	w0,	#1
    str	w28,	[sp, #612]

    ldr	w4,	[sp, #3104]

    mov	w0,	w4
    str	w0,	[sp, #440]

    ldr	w28,	[sp, #612]

    str	w28,	[sp, #608]

    b	main_415

main_424:
    movz	w28,	#65535
    ldr	w0,	[sp, #440]

    sdiv	w28,	w0,	w28
    str	w28,	[sp, #444]

    ldr	w0,	[sp, #444]

    lsl	w28,	w0,	#16
    str	w28,	[sp, #3348]

    ldr	w24,	[sp, #444]

    ldr	w0,	[sp, #3348]

    sub	w28,	w0,	w24,	lsl #0
    ldr	w0,	[sp, #440]

    ldr	w2,	[sp, #760]

    sub	w28,	w0,	w28
    str	w2,	[sp, #3352]

    ldr	w5,	[sp, #1436]

    str	w5,	[sp, #2528]

    ldr	w7,	[sp, #2528]

    ldr	w3,	[sp, #3352]

    cmp	w3,	w7
    bge	main_428

main_112:
    mov	w0,	w28
    str	w0,	[sp, #1432]

    ldr	w0,	[sp, #760]

    str	w0,	[sp, #1428]

    b	main_113

main_428:
    mov	w0,	w28
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


