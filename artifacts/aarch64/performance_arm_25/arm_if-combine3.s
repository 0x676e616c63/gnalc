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
    str	w0,	[sp, #1252]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1256]

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
    ldr	w15,	[sp, #1252]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x8,	sp,	#20
    movz	fp,	#1620
    add	x13,	sp,	#24
    add	x20,	sp,	#28
    add	x6,	sp,	#32
    add	x5,	sp,	#36
    add	x22,	sp,	#40
    add	x16,	sp,	#44
    add	x17,	sp,	#48
    add	x2,	sp,	#52
    add	x18,	sp,	#56
    add	x24,	sp,	#60
    add	x23,	sp,	#64
    add	x26,	sp,	#68
    add	x28,	sp,	#72
    add	x10,	sp,	#76
    add	x11,	sp,	#80
    add	x21,	sp,	#84
    add	x9,	sp,	#88
    add	x25,	sp,	#92
    add	x1,	sp,	#96
    add	x27,	sp,	#100
    add	x3,	sp,	#104
    add	x19,	sp,	#108
    add	x4,	sp,	#112
    add	x7,	sp,	#116
    add	x15,	sp,	#120
    add	x0,	sp,	#124
    add	x14,	sp,	#128
    str	x8,	[sp, fp]

    movz	fp,	#1276
    str	x13,	[sp, fp]

    movz	fp,	#1652
    str	x20,	[sp, fp]

    add	x20,	sp,	#132
    movz	fp,	#1692
    str	x6,	[sp, fp]

    movz	fp,	#1612
    str	x5,	[sp, fp]

    movz	fp,	#1300
    str	x22,	[sp, fp]

    movz	fp,	#1284
    str	x16,	[sp, fp]

    movz	fp,	#1644
    str	x17,	[sp, fp]

    movz	fp,	#1604
    str	x2,	[sp, fp]

    movz	fp,	#1444
    str	x18,	[sp, fp]

    movz	fp,	#1556
    str	x24,	[sp, fp]

    movz	fp,	#1660
    str	x23,	[sp, fp]

    movz	fp,	#1668
    str	x26,	[sp, fp]

    movz	fp,	#1596
    str	x28,	[sp, fp]

    movz	fp,	#1268
    str	x10,	[sp, fp]

    movz	fp,	#1628
    str	x11,	[sp, fp]

    movz	fp,	#1452
    str	x21,	[sp, fp]

    movz	fp,	#1700
    str	x9,	[sp, fp]

    movz	fp,	#1588
    str	x25,	[sp, fp]

    movz	fp,	#1572
    str	x1,	[sp, fp]

    movz	fp,	#1564
    str	x27,	[sp, fp]

    movz	fp,	#1684
    str	x3,	[sp, fp]

    movz	fp,	#1292
    str	x19,	[sp, fp]

    movz	fp,	#1580
    str	x4,	[sp, fp]

    movz	fp,	#1260
    str	x7,	[sp, fp]

    movz	fp,	#1436
    str	x15,	[sp, fp]

    movz	fp,	#1676
    str	x0,	[sp, fp]

    movz	fp,	#1636
    str	x14,	[sp, fp]

    movz	fp,	#884
    str	x20,	[sp, fp]

    movz	fp,	#452
    add	x20,	sp,	#136
    str	x20,	[sp, fp]

    movz	fp,	#524
    add	x20,	sp,	#140
    str	x20,	[sp, fp]

    movz	fp,	#476
    add	x20,	sp,	#144
    str	x20,	[sp, fp]

    movz	fp,	#484
    add	x20,	sp,	#148
    str	x20,	[sp, fp]

    movz	fp,	#492
    add	x20,	sp,	#152
    str	x20,	[sp, fp]

    movz	fp,	#500
    add	x20,	sp,	#156
    str	x20,	[sp, fp]

    movz	fp,	#508
    add	x20,	sp,	#160
    str	x20,	[sp, fp]

    movz	fp,	#516
    add	x20,	sp,	#164
    str	x20,	[sp, fp]

    movz	fp,	#844
    add	x20,	sp,	#168
    str	x20,	[sp, fp]

    movz	fp,	#852
    add	x20,	sp,	#172
    str	x20,	[sp, fp]

    movz	fp,	#860
    add	x20,	sp,	#176
    str	x20,	[sp, fp]

    movz	fp,	#868
    add	x20,	sp,	#180
    str	x20,	[sp, fp]

    movz	fp,	#876
    add	x20,	sp,	#184
    str	x20,	[sp, fp]

    movz	fp,	#756
    add	x20,	sp,	#188
    str	x20,	[sp, fp]

    movz	fp,	#764
    add	x20,	sp,	#192
    str	x20,	[sp, fp]

    movz	fp,	#772
    add	x20,	sp,	#196
    str	x20,	[sp, fp]

    movz	fp,	#780
    add	x20,	sp,	#200
    str	x20,	[sp, fp]

    movz	fp,	#788
    add	x20,	sp,	#204
    str	x20,	[sp, fp]

    movz	fp,	#796
    add	x20,	sp,	#208
    str	x20,	[sp, fp]

    movz	fp,	#804
    add	x20,	sp,	#212
    str	x20,	[sp, fp]

    movz	fp,	#812
    add	x20,	sp,	#216
    str	x20,	[sp, fp]

    movz	fp,	#828
    add	x20,	sp,	#220
    str	x20,	[sp, fp]

    movz	fp,	#836
    add	x20,	sp,	#224
    str	x20,	[sp, fp]

    movz	fp,	#892
    add	x20,	sp,	#228
    str	x20,	[sp, fp]

    movz	fp,	#820
    add	x20,	sp,	#232
    str	x20,	[sp, fp]

    movz	fp,	#900
    add	x20,	sp,	#236
    str	x20,	[sp, #416]

    add	x20,	sp,	#240
    str	x20,	[sp, #424]

    add	x20,	sp,	#244
    str	x20,	[sp, fp]

    movz	fp,	#908
    add	x20,	sp,	#248
    str	x20,	[sp, fp]

    movz	fp,	#916
    add	x20,	sp,	#252
    str	x20,	[sp, fp]

    movz	fp,	#924
    add	x20,	sp,	#256
    str	x20,	[sp, fp]

    movz	fp,	#932
    add	x20,	sp,	#260
    str	x20,	[sp, fp]

    movz	fp,	#940
    add	x20,	sp,	#264
    str	x20,	[sp, fp]

    movz	fp,	#948
    add	x20,	sp,	#268
    str	x20,	[sp, fp]

    movz	fp,	#956
    add	x20,	sp,	#272
    str	x20,	[sp, fp]

    movz	fp,	#964
    add	x20,	sp,	#276
    str	x20,	[sp, fp]

    movz	fp,	#972
    add	x20,	sp,	#280
    str	x20,	[sp, fp]

    movz	fp,	#980
    add	x20,	sp,	#284
    str	x20,	[sp, fp]

    movz	fp,	#988
    add	x20,	sp,	#288
    str	x20,	[sp, fp]

    movz	fp,	#996
    add	x20,	sp,	#292
    str	x20,	[sp, fp]

    movz	fp,	#1004
    add	x20,	sp,	#296
    str	x20,	[sp, fp]

    movz	fp,	#1012
    add	x20,	sp,	#300
    str	x20,	[sp, fp]

    movz	fp,	#1020
    add	x20,	sp,	#304
    str	x20,	[sp, fp]

    movz	fp,	#1028
    add	x20,	sp,	#308
    str	x20,	[sp, fp]

    movz	fp,	#1036
    add	x20,	sp,	#312
    str	x20,	[sp, fp]

    movz	fp,	#1044
    add	x20,	sp,	#316
    str	x20,	[sp, fp]

    movz	fp,	#1052
    add	x20,	sp,	#320
    str	x20,	[sp, fp]

    movz	fp,	#1060
    add	x20,	sp,	#324
    str	x20,	[sp, fp]

    movz	fp,	#1068
    add	x20,	sp,	#328
    str	x20,	[sp, fp]

    movz	fp,	#1076
    add	x20,	sp,	#332
    str	x20,	[sp, fp]

    movz	fp,	#1084
    add	x20,	sp,	#336
    str	x20,	[sp, fp]

    movz	fp,	#1092
    add	x20,	sp,	#340
    str	x20,	[sp, fp]

    movz	fp,	#1100
    add	x20,	sp,	#344
    str	x20,	[sp, fp]

    movz	fp,	#1108
    add	x20,	sp,	#348
    str	x20,	[sp, fp]

    movz	fp,	#1116
    add	x20,	sp,	#352
    str	x20,	[sp, fp]

    movz	fp,	#1124
    add	x20,	sp,	#356
    str	x20,	[sp, fp]

    movz	fp,	#1132
    add	x20,	sp,	#360
    str	x20,	[sp, fp]

    movz	fp,	#1140
    add	x20,	sp,	#364
    str	x20,	[sp, fp]

    movz	fp,	#1148
    add	x20,	sp,	#368
    str	x20,	[sp, fp]

    movz	fp,	#1156
    add	x20,	sp,	#372
    str	x20,	[sp, fp]

    movz	fp,	#1164
    add	x20,	sp,	#376
    str	x20,	[sp, fp]

    movz	fp,	#1172
    add	x20,	sp,	#380
    str	x20,	[sp, fp]

    movz	fp,	#1180
    add	x20,	sp,	#384
    str	x20,	[sp, fp]

    movz	fp,	#1188
    add	x20,	sp,	#388
    str	x20,	[sp, fp]

    movz	fp,	#1196
    add	x20,	sp,	#392
    str	x20,	[sp, fp]

    movz	fp,	#1204
    add	x20,	sp,	#396
    str	x20,	[sp, fp]

    movz	fp,	#1212
    add	x20,	sp,	#400
    str	x20,	[sp, fp]

    movz	fp,	#1220
    add	x20,	sp,	#404
    str	x20,	[sp, fp]

    movz	fp,	#1228
    add	x20,	sp,	#408
    str	x20,	[sp, fp]

    movz	fp,	#1236
    add	x20,	sp,	#412
    str	x20,	[sp, fp]

    movz	w20,	#0
    str	w20,	[sp, #1248]

    movz	w20,	#0
    str	w20,	[sp, #1244]


main_113:
    ldr	w20,	[sp, #1256]

    cmp	w20,	#1
    ble	main_413

main_117:
    movz	w20,	#1
    movz	fp,	#1620
    ldr	x3,	[sp, fp]

    str	w20,	[x3]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#2
    ble	main_413

main_119:
    movz	w20,	#2
    movz	fp,	#1276
    ldr	x7,	[sp, fp]

    str	w20,	[x7]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#3
    ble	main_413

main_121:
    movz	w20,	#3
    movz	fp,	#1652
    ldr	x15,	[sp, fp]

    str	w20,	[x15]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#4
    ble	main_413

main_123:
    movz	w20,	#4
    movz	fp,	#1692
    ldr	x2,	[sp, fp]

    str	w20,	[x2]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#5
    ble	main_413

main_125:
    movz	w20,	#5
    movz	fp,	#1612
    ldr	x0,	[sp, fp]

    str	w20,	[x0]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#6
    ble	main_413

main_127:
    movz	w20,	#6
    movz	fp,	#1300
    ldr	x16,	[sp, fp]

    str	w20,	[x16]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#7
    ble	main_413

main_129:
    movz	w20,	#7
    movz	fp,	#1284
    ldr	x10,	[sp, fp]

    str	w20,	[x10]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#8
    ble	main_413

main_131:
    movz	w20,	#8
    movz	fp,	#1644
    ldr	x12,	[sp, fp]

    str	w20,	[x12]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#9
    ble	main_413

main_133:
    movz	w20,	#9
    movz	fp,	#1604
    ldr	x27,	[sp, fp]

    str	w20,	[x27]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#10
    ble	main_413

main_135:
    movz	w20,	#10
    movz	fp,	#1444
    ldr	x11,	[sp, fp]

    str	w20,	[x11]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#11
    ble	main_413

main_137:
    movz	w20,	#11
    movz	fp,	#1556
    ldr	x17,	[sp, fp]

    str	w20,	[x17]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#12
    ble	main_413

main_139:
    movz	w20,	#12
    movz	fp,	#1660
    ldr	x18,	[sp, fp]

    str	w20,	[x18]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#13
    ble	main_413

main_141:
    movz	w20,	#13
    movz	fp,	#1668
    ldr	x23,	[sp, fp]

    str	w20,	[x23]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#14
    ble	main_413

main_143:
    movz	w20,	#14
    movz	fp,	#1596
    ldr	x24,	[sp, fp]

    str	w20,	[x24]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#15
    ble	main_413

main_145:
    movz	w20,	#15
    movz	fp,	#1268
    ldr	x4,	[sp, fp]

    str	w20,	[x4]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#16
    ble	main_413

main_147:
    movz	w20,	#16
    movz	fp,	#1628
    ldr	x6,	[sp, fp]

    str	w20,	[x6]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#17
    ble	main_413

main_149:
    movz	w20,	#17
    movz	fp,	#1452
    ldr	x14,	[sp, fp]

    str	w20,	[x14]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#18
    ble	main_413

main_151:
    movz	w20,	#18
    movz	fp,	#1700
    ldr	x5,	[sp, fp]

    str	w20,	[x5]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#19
    ble	main_413

main_153:
    movz	w20,	#19
    movz	fp,	#1588
    ldr	x19,	[sp, fp]

    str	w20,	[x19]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#20
    ble	main_413

main_155:
    movz	w20,	#20
    movz	fp,	#1572
    ldr	x25,	[sp, fp]

    str	w20,	[x25]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#21
    ble	main_413

main_157:
    movz	w20,	#21
    movz	fp,	#1564
    ldr	x22,	[sp, fp]

    str	w20,	[x22]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#22
    ble	main_413

main_159:
    movz	w20,	#22
    movz	fp,	#1684
    ldr	x0,	[sp, fp]

    str	w20,	[x0]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#23
    ble	main_413

main_161:
    movz	w20,	#23
    movz	fp,	#1292
    ldr	x13,	[sp, fp]

    str	w20,	[x13]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#24
    ble	main_413

main_163:
    movz	w20,	#24
    movz	fp,	#1580
    ldr	x28,	[sp, fp]

    str	w20,	[x28]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#25
    ble	main_413

main_165:
    movz	w20,	#25
    movz	fp,	#1260
    ldr	x1,	[sp, fp]

    str	w20,	[x1]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#26
    ble	main_413

main_167:
    movz	w20,	#26
    movz	fp,	#1436
    ldr	x8,	[sp, fp]

    str	w20,	[x8]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#27
    ble	main_413

main_169:
    movz	w20,	#27
    movz	fp,	#1676
    ldr	x26,	[sp, fp]

    str	w20,	[x26]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#28
    ble	main_413

main_171:
    movz	w20,	#28
    movz	fp,	#1636
    ldr	x9,	[sp, fp]

    str	w20,	[x9]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#29
    ble	main_413

main_173:
    movz	w20,	#29
    movz	fp,	#884
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2864]

    ldr	x22,	[sp, #2864]

    str	w20,	[x22]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#30
    ble	main_413

main_175:
    movz	w20,	#30
    movz	fp,	#452
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2872]

    ldr	x25,	[sp, #2872]

    str	w20,	[x25]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#31
    ble	main_413

main_177:
    movz	w20,	#31
    movz	fp,	#524
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2880]

    ldr	x28,	[sp, #2880]

    str	w20,	[x28]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#32
    ble	main_413

main_179:
    movz	w20,	#32
    movz	fp,	#476
    mov	w22,	w20
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #2896]

    ldr	x2,	[sp, #2896]

    str	w22,	[x2]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#33
    ble	main_413

main_181:
    movz	w20,	#33
    movz	fp,	#484
    mov	w22,	w20
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #2888]

    ldr	x5,	[sp, #2888]

    str	w22,	[x5]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#34
    ble	main_413

main_183:
    movz	w20,	#34
    movz	fp,	#492
    mov	w22,	w20
    ldr	x4,	[sp, fp]

    movz	fp,	#1812
    str	x4,	[sp, fp]

    movz	fp,	#1812
    ldr	x5,	[sp, fp]

    str	w22,	[x5]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#35
    ble	main_413

main_185:
    movz	w20,	#35
    movz	fp,	#500
    mov	w22,	w20
    ldr	x1,	[sp, fp]

    movz	fp,	#1804
    str	x1,	[sp, fp]

    movz	fp,	#1804
    ldr	x2,	[sp, fp]

    str	w22,	[x2]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#36
    ble	main_413

main_187:
    movz	w20,	#36
    movz	fp,	#508
    ldr	x27,	[sp, fp]

    movz	fp,	#1796
    str	x27,	[sp, fp]

    movz	fp,	#1796
    ldr	x28,	[sp, fp]

    str	w20,	[x28]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#37
    ble	main_413

main_189:
    movz	w20,	#37
    movz	fp,	#516
    ldr	x24,	[sp, fp]

    movz	fp,	#1788
    str	x24,	[sp, fp]

    movz	fp,	#1788
    ldr	x25,	[sp, fp]

    str	w20,	[x25]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#38
    ble	main_413

main_191:
    movz	w20,	#38
    movz	fp,	#844
    ldr	x21,	[sp, fp]

    movz	fp,	#1780
    str	x21,	[sp, fp]

    movz	fp,	#1780
    ldr	x22,	[sp, fp]

    str	w20,	[x22]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#39
    ble	main_413

main_193:
    movz	w20,	#39
    movz	fp,	#852
    mov	w22,	w20
    ldr	x18,	[sp, fp]

    movz	fp,	#1772
    str	x18,	[sp, fp]

    movz	fp,	#1772
    ldr	x19,	[sp, fp]

    str	w22,	[x19]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#40
    ble	main_413

main_195:
    movz	w20,	#40
    movz	fp,	#860
    mov	w22,	w20
    ldr	x15,	[sp, fp]

    movz	fp,	#1764
    str	x15,	[sp, fp]

    movz	fp,	#1764
    ldr	x16,	[sp, fp]

    str	w22,	[x16]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#41
    ble	main_413

main_197:
    movz	w20,	#41
    movz	fp,	#868
    mov	w22,	w20
    ldr	x12,	[sp, fp]

    movz	fp,	#1756
    str	x12,	[sp, fp]

    movz	fp,	#1756
    ldr	x13,	[sp, fp]

    str	w22,	[x13]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#42
    ble	main_413

main_199:
    movz	w20,	#42
    movz	fp,	#876
    mov	w22,	w20
    ldr	x9,	[sp, fp]

    movz	fp,	#1748
    str	x9,	[sp, fp]

    movz	fp,	#1748
    ldr	x10,	[sp, fp]

    str	w22,	[x10]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#43
    ble	main_413

main_201:
    movz	w20,	#43
    movz	fp,	#756
    mov	w22,	w20
    ldr	x6,	[sp, fp]

    movz	fp,	#1740
    str	x6,	[sp, fp]

    movz	fp,	#1740
    ldr	x7,	[sp, fp]

    str	w22,	[x7]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#44
    ble	main_413

main_203:
    movz	w20,	#44
    movz	fp,	#764
    mov	w22,	w20
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #3024]

    ldr	x4,	[sp, #3024]

    str	w22,	[x4]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#45
    ble	main_413

main_205:
    movz	w20,	#45
    movz	fp,	#772
    mov	w22,	w20
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #3016]

    ldr	x1,	[sp, #3016]

    str	w22,	[x1]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#46
    ble	main_413

main_207:
    movz	w20,	#46
    movz	fp,	#780
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #3008]

    ldr	x27,	[sp, #3008]

    str	w20,	[x27]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#47
    ble	main_413

main_209:
    movz	w20,	#47
    movz	fp,	#788
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #3000]

    ldr	x24,	[sp, #3000]

    str	w20,	[x24]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#48
    ble	main_413

main_211:
    movz	w20,	#48
    movz	fp,	#796
    mov	w22,	w20
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #2992]

    ldr	x21,	[sp, #2992]

    str	w22,	[x21]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#49
    ble	main_413

main_213:
    movz	w20,	#49
    movz	fp,	#804
    mov	w22,	w20
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #2984]

    ldr	x18,	[sp, #2984]

    str	w22,	[x18]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#50
    ble	main_413

main_215:
    movz	w20,	#50
    movz	fp,	#812
    mov	w22,	w20
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #2976]

    ldr	x15,	[sp, #2976]

    str	w22,	[x15]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#51
    ble	main_413

main_217:
    movz	w20,	#51
    movz	fp,	#828
    mov	w22,	w20
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #2968]

    ldr	x12,	[sp, #2968]

    str	w22,	[x12]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#52
    ble	main_413

main_219:
    movz	w20,	#52
    movz	fp,	#836
    mov	w22,	w20
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #2960]

    ldr	x9,	[sp, #2960]

    str	w22,	[x9]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#53
    ble	main_413

main_221:
    movz	w20,	#53
    movz	fp,	#892
    mov	w22,	w20
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #2952]

    ldr	x6,	[sp, #2952]

    str	w22,	[x6]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#54
    ble	main_413

main_223:
    movz	w20,	#54
    movz	fp,	#820
    mov	w22,	w20
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #2944]

    ldr	x3,	[sp, #2944]

    str	w22,	[x3]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#55
    ble	main_413

main_225:
    movz	w20,	#55
    ldr	x28,	[sp, #416]

    mov	w21,	w20
    str	x28,	[sp, #2936]

    ldr	x0,	[sp, #2936]

    str	w21,	[x0]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#56
    ble	main_413

main_227:
    movz	w20,	#56
    ldr	x25,	[sp, #424]

    str	x25,	[sp, #2928]

    ldr	x26,	[sp, #2928]

    str	w20,	[x26]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#57
    ble	main_413

main_229:
    movz	w20,	#57
    movz	fp,	#900
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #2920]

    ldr	x23,	[sp, #2920]

    str	w20,	[x23]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#58
    ble	main_413

main_231:
    movz	w20,	#58
    movz	fp,	#908
    mov	w22,	w20
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #2912]

    ldr	x20,	[sp, #2912]

    str	w22,	[x20]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#59
    ble	main_413

main_233:
    movz	w20,	#59
    movz	fp,	#916
    mov	w22,	w20
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #2904]

    ldr	x17,	[sp, #2904]

    str	w22,	[x17]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#60
    ble	main_413

main_235:
    movz	w20,	#60
    movz	fp,	#924
    mov	w22,	w20
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #2304]

    ldr	x14,	[sp, #2304]

    str	w22,	[x14]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#61
    ble	main_413

main_237:
    movz	w20,	#61
    movz	fp,	#932
    mov	w22,	w20
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #2296]

    ldr	x11,	[sp, #2296]

    str	w22,	[x11]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#62
    ble	main_413

main_239:
    movz	w20,	#62
    movz	fp,	#940
    mov	w22,	w20
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #2288]

    ldr	x8,	[sp, #2288]

    str	w22,	[x8]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#63
    ble	main_413

main_241:
    movz	w20,	#63
    movz	fp,	#948
    mov	w22,	w20
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #2280]

    ldr	x5,	[sp, #2280]

    str	w22,	[x5]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#64
    ble	main_413

main_243:
    movz	w20,	#64
    movz	fp,	#956
    mov	w22,	w20
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #2272]

    ldr	x2,	[sp, #2272]

    str	w22,	[x2]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#65
    ble	main_413

main_245:
    movz	w20,	#65
    movz	fp,	#964
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2264]

    ldr	x28,	[sp, #2264]

    str	w20,	[x28]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#66
    ble	main_413

main_247:
    movz	w20,	#66
    movz	fp,	#972
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2256]

    ldr	x25,	[sp, #2256]

    str	w20,	[x25]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#67
    ble	main_413

main_249:
    movz	w20,	#67
    movz	fp,	#980
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2376]

    ldr	x22,	[sp, #2376]

    str	w20,	[x22]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#68
    ble	main_413

main_251:
    movz	w20,	#68
    movz	fp,	#988
    mov	w22,	w20
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #2368]

    ldr	x19,	[sp, #2368]

    str	w22,	[x19]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#69
    ble	main_413

main_253:
    movz	w20,	#69
    movz	fp,	#996
    mov	w22,	w20
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #2360]

    ldr	x16,	[sp, #2360]

    str	w22,	[x16]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#70
    ble	main_413

main_255:
    movz	w20,	#70
    movz	fp,	#1004
    mov	w22,	w20
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #2352]

    ldr	x13,	[sp, #2352]

    str	w22,	[x13]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#71
    ble	main_413

main_257:
    movz	w20,	#71
    movz	fp,	#1012
    mov	w22,	w20
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #2344]

    ldr	x10,	[sp, #2344]

    str	w22,	[x10]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#72
    ble	main_413

main_259:
    movz	w20,	#72
    movz	fp,	#1020
    mov	w22,	w20
    ldr	x6,	[sp, fp]

    str	x6,	[sp, #2336]

    ldr	x7,	[sp, #2336]

    str	w22,	[x7]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#73
    ble	main_413

main_261:
    movz	w20,	#73
    movz	fp,	#1028
    mov	w22,	w20
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #2328]

    ldr	x4,	[sp, #2328]

    str	w22,	[x4]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#74
    ble	main_413

main_263:
    movz	w20,	#74
    movz	fp,	#1036
    mov	w22,	w20
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #3072]

    ldr	x1,	[sp, #3072]

    str	w22,	[x1]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#75
    ble	main_413

main_265:
    movz	w20,	#75
    movz	fp,	#1044
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #3064]

    ldr	x27,	[sp, #3064]

    str	w20,	[x27]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#76
    ble	main_413

main_267:
    movz	w20,	#76
    movz	fp,	#1052
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #3056]

    ldr	x24,	[sp, #3056]

    str	w20,	[x24]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#77
    ble	main_413

main_269:
    movz	w20,	#77
    movz	fp,	#1060
    mov	w22,	w20
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #3048]

    ldr	x21,	[sp, #3048]

    str	w22,	[x21]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#78
    ble	main_413

main_271:
    movz	w20,	#78
    movz	fp,	#1068
    mov	w22,	w20
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #3040]

    ldr	x18,	[sp, #3040]

    str	w22,	[x18]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#79
    ble	main_413

main_273:
    movz	w20,	#79
    movz	fp,	#1076
    mov	w22,	w20
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #3032]

    ldr	x15,	[sp, #3032]

    str	w22,	[x15]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#80
    ble	main_413

main_275:
    movz	w20,	#80
    movz	fp,	#1084
    mov	w22,	w20
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #2448]

    ldr	x12,	[sp, #2448]

    str	w22,	[x12]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#81
    ble	main_413

main_277:
    movz	w20,	#81
    movz	fp,	#1092
    mov	w22,	w20
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #2440]

    ldr	x9,	[sp, #2440]

    str	w22,	[x9]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#82
    ble	main_413

main_279:
    movz	w20,	#82
    movz	fp,	#1100
    mov	w22,	w20
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #2432]

    ldr	x6,	[sp, #2432]

    str	w22,	[x6]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#83
    ble	main_413

main_281:
    movz	w20,	#83
    movz	fp,	#1108
    mov	w22,	w20
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #2424]

    ldr	x3,	[sp, #2424]

    str	w22,	[x3]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#84
    ble	main_413

main_283:
    movz	w20,	#84
    movz	fp,	#1116
    mov	w21,	w20
    ldr	x28,	[sp, fp]

    str	x28,	[sp, #2416]

    ldr	x0,	[sp, #2416]

    str	w21,	[x0]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#85
    ble	main_413

main_285:
    movz	w20,	#85
    movz	fp,	#1124
    ldr	x25,	[sp, fp]

    str	x25,	[sp, #2408]

    ldr	x26,	[sp, #2408]

    str	w20,	[x26]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#86
    ble	main_413

main_287:
    movz	w20,	#86
    movz	fp,	#1132
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #3104]

    ldr	x23,	[sp, #3104]

    str	w20,	[x23]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#87
    ble	main_413

main_289:
    movz	w20,	#87
    movz	fp,	#1140
    mov	w22,	w20
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3096]

    ldr	x20,	[sp, #3096]

    str	w22,	[x20]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#88
    ble	main_413

main_291:
    movz	w20,	#88
    movz	fp,	#1148
    mov	w22,	w20
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3088]

    ldr	x17,	[sp, #3088]

    str	w22,	[x17]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#89
    ble	main_413

main_293:
    movz	w20,	#89
    movz	fp,	#1156
    mov	w22,	w20
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3080]

    ldr	x14,	[sp, #3080]

    str	w22,	[x14]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#90
    ble	main_413

main_295:
    movz	w20,	#90
    movz	fp,	#1164
    mov	w22,	w20
    ldr	x10,	[sp, fp]

    movz	fp,	#1732
    str	x10,	[sp, fp]

    movz	fp,	#1732
    ldr	x11,	[sp, fp]

    str	w22,	[x11]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#91
    ble	main_413

main_297:
    movz	w20,	#91
    movz	fp,	#1172
    mov	w22,	w20
    ldr	x7,	[sp, fp]

    movz	fp,	#1724
    str	x7,	[sp, fp]

    movz	fp,	#1724
    ldr	x8,	[sp, fp]

    str	w22,	[x8]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#92
    ble	main_413

main_299:
    movz	w20,	#92
    movz	fp,	#1180
    mov	w22,	w20
    ldr	x4,	[sp, fp]

    movz	fp,	#1716
    str	x4,	[sp, fp]

    movz	fp,	#1716
    ldr	x5,	[sp, fp]

    str	w22,	[x5]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#93
    ble	main_413

main_301:
    movz	w20,	#93
    movz	fp,	#1188
    mov	w22,	w20
    ldr	x1,	[sp, fp]

    movz	fp,	#1708
    str	x1,	[sp, fp]

    movz	fp,	#1708
    ldr	x2,	[sp, fp]

    str	w22,	[x2]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#94
    ble	main_413

main_303:
    movz	w20,	#94
    movz	fp,	#1196
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2400]

    ldr	x28,	[sp, #2400]

    str	w20,	[x28]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#95
    ble	main_413

main_305:
    movz	w20,	#95
    movz	fp,	#1204
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2392]

    ldr	x25,	[sp, #2392]

    str	w20,	[x25]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#96
    ble	main_413

main_307:
    movz	w20,	#96
    movz	fp,	#1212
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2384]

    ldr	x22,	[sp, #2384]

    str	w20,	[x22]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#97
    ble	main_413

main_309:
    movz	w20,	#97
    movz	fp,	#1220
    mov	w22,	w20
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #2320]

    ldr	x19,	[sp, #2320]

    str	w22,	[x19]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#98
    ble	main_413

main_311:
    movz	w20,	#98
    movz	fp,	#1228
    mov	w22,	w20
    ldr	x15,	[sp, fp]

    movz	fp,	#468
    str	x15,	[sp, fp]

    movz	fp,	#468
    ldr	x16,	[sp, fp]

    str	w22,	[x16]

    ldr	w20,	[sp, #1256]

    cmp	w20,	#99
    ble	main_413

main_313:
    movz	w20,	#99
    movz	fp,	#1236
    mov	w22,	w20
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #2312]

    ldr	x13,	[sp, #2312]

    str	w22,	[x13]


main_413:
    ldr	w20,	[sp, #1244]

    add	w20,	w20,	#1
    str	w20,	[sp, #440]

    ldr	w20,	[sp, #1248]

    str	w20,	[sp, #444]

    movz	w20,	#0
    str	w20,	[sp, #448]


main_415:
    ldr	w20,	[sp, #448]

    cmp	w20,	#100
    bge	main_424

main_419:
    ldr	w20,	[sp, #448]

    lsl	w20,	w20,	#2
    mov	x20,	x20
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w22,	[x20]

    ldr	w13,	[sp, #444]

    str	w13,	[sp, #2684]

    ldr	w14,	[sp, #2684]

    ldr	w10,	[sp, #448]

    add	w24,	w22,	w14
    str	w10,	[sp, #2680]

    mov	w20,	w24
    ldr	w11,	[sp, #2680]

    add	w4,	w11,	#1
    str	w4,	[sp, #2672]

    ldr	w5,	[sp, #2672]

    str	w5,	[sp, #432]

    str	w20,	[sp, #444]

    ldr	w20,	[sp, #432]

    str	w20,	[sp, #448]

    b	main_415

main_424:
    movz	w20,	#65535
    ldr	w16,	[sp, #444]

    mov	w22,	w20
    str	w16,	[sp, #2688]

    ldr	w17,	[sp, #2688]

    sdiv	w20,	w17,	w22
    str	w20,	[sp, #436]

    ldr	w20,	[sp, #436]

    ldr	w7,	[sp, #436]

    lsl	w22,	w20,	#16
    str	w7,	[sp, #2676]

    ldr	w8,	[sp, #2676]

    ldr	w19,	[sp, #444]

    sub	w22,	w22,	w8,	lsl #0
    str	w19,	[sp, #2692]

    ldr	w20,	[sp, #2692]

    ldr	w7,	[sp, #440]

    sub	w24,	w20,	w22
    str	w7,	[sp, #1820]

    ldr	w22,	[sp, #1252]

    str	w22,	[sp, #2696]

    ldr	w8,	[sp, #1820]

    ldr	w0,	[sp, #2696]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w20,	w24
    str	w20,	[sp, #1248]

    ldr	w20,	[sp, #440]

    str	w20,	[sp, #1244]

    b	main_113

main_428:
    mov	w0,	w24
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


