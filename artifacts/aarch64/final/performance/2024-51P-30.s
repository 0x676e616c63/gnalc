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
    str	w0,	[sp, #1092]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1096]

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
    ldr	w15,	[sp, #1092]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x23,	sp,	#20
    movz	fp,	#1644
    add	x24,	sp,	#24
    add	x10,	sp,	#28
    add	x3,	sp,	#32
    add	x13,	sp,	#36
    add	x6,	sp,	#40
    add	x28,	sp,	#44
    add	x9,	sp,	#48
    add	x14,	sp,	#52
    add	x0,	sp,	#56
    add	x1,	sp,	#60
    add	x15,	sp,	#64
    add	x7,	sp,	#68
    add	x4,	sp,	#72
    add	x2,	sp,	#76
    add	x25,	sp,	#80
    add	x18,	sp,	#84
    add	x11,	sp,	#88
    add	x21,	sp,	#92
    add	x22,	sp,	#96
    add	x19,	sp,	#100
    add	x16,	sp,	#104
    add	x20,	sp,	#108
    add	x8,	sp,	#112
    add	x5,	sp,	#116
    add	x17,	sp,	#120
    add	x27,	sp,	#124
    add	x26,	sp,	#128
    str	x23,	[sp, fp]

    movz	fp,	#1548
    str	x24,	[sp, fp]

    movz	fp,	#1484
    str	x10,	[sp, fp]

    movz	fp,	#1668
    str	x3,	[sp, fp]

    movz	fp,	#1492
    str	x13,	[sp, fp]

    add	x13,	sp,	#132
    movz	fp,	#1676
    str	x6,	[sp, fp]

    movz	fp,	#1580
    str	x28,	[sp, fp]

    movz	fp,	#1684
    str	x9,	[sp, fp]

    movz	fp,	#1620
    str	x14,	[sp, fp]

    movz	fp,	#1660
    str	x0,	[sp, fp]

    movz	fp,	#1564
    str	x1,	[sp, fp]

    movz	fp,	#1428
    str	x15,	[sp, fp]

    movz	fp,	#1476
    str	x7,	[sp, fp]

    movz	fp,	#1572
    str	x4,	[sp, fp]

    movz	fp,	#1588
    str	x2,	[sp, fp]

    movz	fp,	#1524
    str	x25,	[sp, fp]

    movz	fp,	#1532
    str	x18,	[sp, fp]

    movz	fp,	#1612
    str	x11,	[sp, fp]

    movz	fp,	#1540
    str	x21,	[sp, fp]

    movz	fp,	#1516
    str	x22,	[sp, fp]

    movz	fp,	#1508
    str	x19,	[sp, fp]

    movz	fp,	#1500
    str	x16,	[sp, fp]

    movz	fp,	#1636
    str	x20,	[sp, fp]

    movz	fp,	#1604
    str	x8,	[sp, fp]

    movz	fp,	#1596
    str	x5,	[sp, fp]

    movz	fp,	#1628
    str	x17,	[sp, fp]

    movz	fp,	#1556
    str	x27,	[sp, fp]

    movz	fp,	#1652
    str	x26,	[sp, fp]

    movz	fp,	#532
    str	x13,	[sp, #448]

    add	x13,	sp,	#136
    str	x13,	[sp, fp]

    movz	fp,	#612
    add	x13,	sp,	#140
    str	x13,	[sp, fp]

    movz	fp,	#620
    add	x13,	sp,	#144
    str	x13,	[sp, fp]

    movz	fp,	#628
    add	x13,	sp,	#148
    str	x13,	[sp, fp]

    movz	fp,	#700
    add	x13,	sp,	#152
    str	x13,	[sp, fp]

    movz	fp,	#708
    add	x13,	sp,	#156
    str	x13,	[sp, fp]

    movz	fp,	#716
    add	x13,	sp,	#160
    str	x13,	[sp, fp]

    movz	fp,	#476
    add	x13,	sp,	#164
    str	x13,	[sp, fp]

    movz	fp,	#484
    add	x13,	sp,	#168
    str	x13,	[sp, fp]

    movz	fp,	#492
    add	x13,	sp,	#172
    str	x13,	[sp, fp]

    movz	fp,	#500
    add	x13,	sp,	#176
    str	x13,	[sp, fp]

    movz	fp,	#508
    add	x13,	sp,	#180
    str	x13,	[sp, fp]

    movz	fp,	#516
    add	x13,	sp,	#184
    str	x13,	[sp, fp]

    movz	fp,	#524
    add	x13,	sp,	#188
    str	x13,	[sp, fp]

    movz	fp,	#540
    add	x13,	sp,	#192
    str	x13,	[sp, fp]

    movz	fp,	#548
    add	x13,	sp,	#196
    str	x13,	[sp, fp]

    movz	fp,	#556
    add	x13,	sp,	#200
    str	x13,	[sp, fp]

    movz	fp,	#564
    add	x13,	sp,	#204
    str	x13,	[sp, fp]

    movz	fp,	#572
    add	x13,	sp,	#208
    str	x13,	[sp, fp]

    movz	fp,	#580
    add	x13,	sp,	#212
    str	x13,	[sp, fp]

    movz	fp,	#588
    add	x13,	sp,	#216
    str	x13,	[sp, fp]

    movz	fp,	#596
    add	x13,	sp,	#220
    str	x13,	[sp, fp]

    movz	fp,	#604
    add	x13,	sp,	#224
    str	x13,	[sp, fp]

    movz	fp,	#732
    add	x13,	sp,	#228
    str	x13,	[sp, fp]

    movz	fp,	#724
    add	x13,	sp,	#232
    str	x13,	[sp, fp]

    movz	fp,	#740
    add	x13,	sp,	#236
    str	x13,	[sp, #416]

    add	x13,	sp,	#240
    str	x13,	[sp, #424]

    add	x13,	sp,	#244
    str	x13,	[sp, fp]

    movz	fp,	#748
    add	x13,	sp,	#248
    str	x13,	[sp, fp]

    movz	fp,	#756
    add	x13,	sp,	#252
    str	x13,	[sp, fp]

    movz	fp,	#764
    add	x13,	sp,	#256
    str	x13,	[sp, fp]

    movz	fp,	#772
    add	x13,	sp,	#260
    str	x13,	[sp, fp]

    movz	fp,	#780
    add	x13,	sp,	#264
    str	x13,	[sp, fp]

    movz	fp,	#788
    add	x13,	sp,	#268
    str	x13,	[sp, fp]

    movz	fp,	#796
    add	x13,	sp,	#272
    str	x13,	[sp, fp]

    movz	fp,	#804
    add	x13,	sp,	#276
    str	x13,	[sp, fp]

    movz	fp,	#812
    add	x13,	sp,	#280
    str	x13,	[sp, fp]

    movz	fp,	#820
    add	x13,	sp,	#284
    str	x13,	[sp, fp]

    movz	fp,	#828
    add	x13,	sp,	#288
    str	x13,	[sp, fp]

    movz	fp,	#836
    add	x13,	sp,	#292
    str	x13,	[sp, fp]

    movz	fp,	#844
    add	x13,	sp,	#296
    str	x13,	[sp, fp]

    movz	fp,	#852
    add	x13,	sp,	#300
    str	x13,	[sp, fp]

    movz	fp,	#860
    add	x13,	sp,	#304
    str	x13,	[sp, fp]

    movz	fp,	#868
    add	x13,	sp,	#308
    str	x13,	[sp, fp]

    movz	fp,	#876
    add	x13,	sp,	#312
    str	x13,	[sp, fp]

    movz	fp,	#884
    add	x13,	sp,	#316
    str	x13,	[sp, fp]

    movz	fp,	#892
    add	x13,	sp,	#320
    str	x13,	[sp, fp]

    movz	fp,	#900
    add	x13,	sp,	#324
    str	x13,	[sp, fp]

    movz	fp,	#908
    add	x13,	sp,	#328
    str	x13,	[sp, fp]

    movz	fp,	#916
    add	x13,	sp,	#332
    str	x13,	[sp, fp]

    movz	fp,	#924
    add	x13,	sp,	#336
    str	x13,	[sp, fp]

    movz	fp,	#932
    add	x13,	sp,	#340
    str	x13,	[sp, fp]

    movz	fp,	#940
    add	x13,	sp,	#344
    str	x13,	[sp, fp]

    movz	fp,	#948
    add	x13,	sp,	#348
    str	x13,	[sp, fp]

    movz	fp,	#956
    add	x13,	sp,	#352
    str	x13,	[sp, fp]

    movz	fp,	#964
    add	x13,	sp,	#356
    str	x13,	[sp, fp]

    movz	fp,	#972
    add	x13,	sp,	#360
    str	x13,	[sp, fp]

    movz	fp,	#980
    add	x13,	sp,	#364
    str	x13,	[sp, fp]

    movz	fp,	#988
    add	x13,	sp,	#368
    str	x13,	[sp, fp]

    movz	fp,	#996
    add	x13,	sp,	#372
    str	x13,	[sp, fp]

    movz	fp,	#1004
    add	x13,	sp,	#376
    str	x13,	[sp, fp]

    movz	fp,	#1012
    add	x13,	sp,	#380
    str	x13,	[sp, fp]

    movz	fp,	#1020
    add	x13,	sp,	#384
    str	x13,	[sp, fp]

    movz	fp,	#1028
    add	x13,	sp,	#388
    str	x13,	[sp, fp]

    movz	fp,	#1036
    add	x13,	sp,	#392
    str	x13,	[sp, fp]

    movz	fp,	#1044
    add	x13,	sp,	#396
    str	x13,	[sp, fp]

    movz	fp,	#1052
    add	x13,	sp,	#400
    str	x13,	[sp, fp]

    movz	fp,	#1060
    add	x13,	sp,	#404
    str	x13,	[sp, fp]

    movz	fp,	#1068
    add	x13,	sp,	#408
    str	x13,	[sp, fp]

    movz	fp,	#1076
    add	x13,	sp,	#412
    str	x13,	[sp, fp]

    movz	w13,	#0
    str	w13,	[sp, #1088]

    movz	w13,	#0
    str	w13,	[sp, #1084]


main_113:
    ldr	w13,	[sp, #1096]

    cmp	w13,	#1
    ble	main_413

main_117:
    movz	w13,	#1
    movz	fp,	#1644
    ldr	x20,	[sp, fp]

    str	w13,	[x20]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#2
    ble	main_413

main_119:
    movz	w13,	#2
    movz	fp,	#1548
    ldr	x19,	[sp, fp]

    str	w13,	[x19]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#3
    ble	main_413

main_121:
    movz	w13,	#3
    movz	fp,	#1484
    ldr	x4,	[sp, fp]

    str	w13,	[x4]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#4
    ble	main_413

main_123:
    movz	w13,	#4
    movz	fp,	#1668
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#5
    ble	main_413

main_125:
    movz	w13,	#5
    movz	fp,	#1492
    ldr	x7,	[sp, fp]

    str	w13,	[x7]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#6
    ble	main_413

main_127:
    movz	w13,	#6
    movz	fp,	#1676
    ldr	x2,	[sp, fp]

    str	w13,	[x2]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#7
    ble	main_413

main_129:
    movz	w13,	#7
    movz	fp,	#1580
    ldr	x24,	[sp, fp]

    str	w13,	[x24]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#8
    ble	main_413

main_131:
    movz	w13,	#8
    movz	fp,	#1684
    ldr	x5,	[sp, fp]

    str	w13,	[x5]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#9
    ble	main_413

main_133:
    movz	w13,	#9
    movz	fp,	#1620
    ldr	x9,	[sp, fp]

    str	w13,	[x9]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#10
    ble	main_413

main_135:
    movz	w13,	#10
    movz	fp,	#1660
    ldr	x26,	[sp, fp]

    str	w13,	[x26]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#11
    ble	main_413

main_137:
    movz	w13,	#11
    movz	fp,	#1564
    ldr	x25,	[sp, fp]

    str	w13,	[x25]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#12
    ble	main_413

main_139:
    movz	w13,	#12
    movz	fp,	#1428
    ldr	x8,	[sp, fp]

    str	w13,	[x8]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#13
    ble	main_413

main_141:
    movz	w13,	#13
    movz	fp,	#1476
    ldr	x1,	[sp, fp]

    str	w13,	[x1]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#14
    ble	main_413

main_143:
    movz	w13,	#14
    movz	fp,	#1572
    ldr	x28,	[sp, fp]

    str	w13,	[x28]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#15
    ble	main_413

main_145:
    movz	w13,	#15
    movz	fp,	#1588
    ldr	x27,	[sp, fp]

    str	w13,	[x27]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#16
    ble	main_413

main_147:
    movz	w13,	#16
    movz	fp,	#1524
    ldr	x21,	[sp, fp]

    str	w13,	[x21]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#17
    ble	main_413

main_149:
    movz	w13,	#17
    movz	fp,	#1532
    ldr	x11,	[sp, fp]

    str	w13,	[x11]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#18
    ble	main_413

main_151:
    movz	w13,	#18
    movz	fp,	#1612
    ldr	x6,	[sp, fp]

    str	w13,	[x6]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#19
    ble	main_413

main_153:
    movz	w13,	#19
    movz	fp,	#1540
    ldr	x16,	[sp, fp]

    str	w13,	[x16]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#20
    ble	main_413

main_155:
    movz	w13,	#20
    movz	fp,	#1516
    ldr	x18,	[sp, fp]

    str	w13,	[x18]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#21
    ble	main_413

main_157:
    movz	w13,	#21
    movz	fp,	#1508
    ldr	x15,	[sp, fp]

    str	w13,	[x15]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#22
    ble	main_413

main_159:
    movz	w13,	#22
    movz	fp,	#1500
    ldr	x10,	[sp, fp]

    str	w13,	[x10]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#23
    ble	main_413

main_161:
    movz	w13,	#23
    movz	fp,	#1636
    ldr	x17,	[sp, fp]

    str	w13,	[x17]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#24
    ble	main_413

main_163:
    movz	w13,	#24
    movz	fp,	#1604
    ldr	x3,	[sp, fp]

    str	w13,	[x3]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#25
    ble	main_413

main_165:
    movz	w13,	#25
    movz	fp,	#1596
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#26
    ble	main_413

main_167:
    movz	w13,	#26
    movz	fp,	#1628
    ldr	x12,	[sp, fp]

    str	w13,	[x12]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#27
    ble	main_413

main_169:
    movz	w13,	#27
    movz	fp,	#1556
    ldr	x22,	[sp, fp]

    str	w13,	[x22]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#28
    ble	main_413

main_171:
    movz	w13,	#28
    movz	fp,	#1652
    ldr	x23,	[sp, fp]

    str	w13,	[x23]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#29
    ble	main_413

main_173:
    movz	w13,	#29
    ldr	x21,	[sp, #448]

    str	x21,	[sp, #3080]

    ldr	x22,	[sp, #3080]

    str	w13,	[x22]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#30
    ble	main_413

main_175:
    movz	w13,	#30
    movz	fp,	#532
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3088]

    ldr	x25,	[sp, #3088]

    str	w13,	[x25]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#31
    ble	main_413

main_177:
    movz	w13,	#31
    movz	fp,	#612
    ldr	x27,	[sp, fp]

    movz	fp,	#2140
    str	x27,	[sp, fp]

    movz	fp,	#2140
    ldr	x28,	[sp, fp]

    str	w13,	[x28]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#32
    ble	main_413

main_179:
    movz	w13,	#32
    movz	fp,	#620
    mov	w15,	w13
    ldr	x1,	[sp, fp]

    movz	fp,	#2148
    str	x1,	[sp, fp]

    movz	fp,	#2148
    ldr	x2,	[sp, fp]

    str	w15,	[x2]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#33
    ble	main_413

main_181:
    movz	w13,	#33
    movz	fp,	#628
    mov	w15,	w13
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3096]

    ldr	x5,	[sp, #3096]

    str	w15,	[x5]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#34
    ble	main_413

main_183:
    movz	w13,	#34
    movz	fp,	#700
    mov	w15,	w13
    ldr	x4,	[sp, fp]

    movz	fp,	#2228
    str	x4,	[sp, fp]

    movz	fp,	#2228
    ldr	x5,	[sp, fp]

    str	w15,	[x5]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#35
    ble	main_413

main_185:
    movz	w13,	#35
    movz	fp,	#708
    mov	w15,	w13
    ldr	x1,	[sp, fp]

    movz	fp,	#2220
    str	x1,	[sp, fp]

    movz	fp,	#2220
    ldr	x2,	[sp, fp]

    str	w15,	[x2]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#36
    ble	main_413

main_187:
    movz	w13,	#36
    movz	fp,	#716
    ldr	x27,	[sp, fp]

    movz	fp,	#2212
    str	x27,	[sp, fp]

    movz	fp,	#2212
    ldr	x28,	[sp, fp]

    str	w13,	[x28]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#37
    ble	main_413

main_189:
    movz	w13,	#37
    movz	fp,	#476
    ldr	x24,	[sp, fp]

    movz	fp,	#2204
    str	x24,	[sp, fp]

    movz	fp,	#2204
    ldr	x25,	[sp, fp]

    str	w13,	[x25]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#38
    ble	main_413

main_191:
    movz	w13,	#38
    movz	fp,	#484
    ldr	x21,	[sp, fp]

    movz	fp,	#2196
    str	x21,	[sp, fp]

    movz	fp,	#2196
    ldr	x22,	[sp, fp]

    str	w13,	[x22]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#39
    ble	main_413

main_193:
    movz	w13,	#39
    movz	fp,	#492
    ldr	x18,	[sp, fp]

    movz	fp,	#2188
    str	x18,	[sp, fp]

    movz	fp,	#2188
    ldr	x19,	[sp, fp]

    str	w13,	[x19]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#40
    ble	main_413

main_195:
    movz	w13,	#40
    movz	fp,	#500
    ldr	x15,	[sp, fp]

    movz	fp,	#2180
    str	x15,	[sp, fp]

    movz	fp,	#2180
    ldr	x16,	[sp, fp]

    str	w13,	[x16]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#41
    ble	main_413

main_197:
    movz	w13,	#41
    movz	fp,	#508
    mov	w15,	w13
    ldr	x12,	[sp, fp]

    movz	fp,	#2172
    str	x12,	[sp, fp]

    movz	fp,	#2172
    ldr	x13,	[sp, fp]

    str	w15,	[x13]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#42
    ble	main_413

main_199:
    movz	w13,	#42
    movz	fp,	#516
    mov	w15,	w13
    ldr	x9,	[sp, fp]

    movz	fp,	#2164
    str	x9,	[sp, fp]

    movz	fp,	#2164
    ldr	x10,	[sp, fp]

    str	w15,	[x10]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#43
    ble	main_413

main_201:
    movz	w13,	#43
    movz	fp,	#524
    mov	w15,	w13
    ldr	x6,	[sp, fp]

    movz	fp,	#2156
    str	x6,	[sp, fp]

    movz	fp,	#2156
    ldr	x7,	[sp, fp]

    str	w15,	[x7]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#44
    ble	main_413

main_203:
    movz	w13,	#44
    movz	fp,	#540
    mov	w15,	w13
    ldr	x3,	[sp, fp]

    movz	fp,	#2020
    str	x3,	[sp, fp]

    movz	fp,	#2020
    ldr	x4,	[sp, fp]

    str	w15,	[x4]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#45
    ble	main_413

main_205:
    movz	w13,	#45
    movz	fp,	#548
    mov	w15,	w13
    ldr	x0,	[sp, fp]

    movz	fp,	#2012
    str	x0,	[sp, fp]

    movz	fp,	#2012
    ldr	x1,	[sp, fp]

    str	w15,	[x1]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#46
    ble	main_413

main_207:
    movz	w13,	#46
    movz	fp,	#556
    ldr	x26,	[sp, fp]

    movz	fp,	#2004
    str	x26,	[sp, fp]

    movz	fp,	#2004
    ldr	x27,	[sp, fp]

    str	w13,	[x27]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#47
    ble	main_413

main_209:
    movz	w13,	#47
    movz	fp,	#564
    ldr	x23,	[sp, fp]

    movz	fp,	#1996
    str	x23,	[sp, fp]

    movz	fp,	#1996
    ldr	x24,	[sp, fp]

    str	w13,	[x24]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#48
    ble	main_413

main_211:
    movz	w13,	#48
    movz	fp,	#572
    ldr	x20,	[sp, fp]

    movz	fp,	#1988
    str	x20,	[sp, fp]

    movz	fp,	#1988
    ldr	x21,	[sp, fp]

    str	w13,	[x21]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#49
    ble	main_413

main_213:
    movz	w13,	#49
    movz	fp,	#580
    ldr	x17,	[sp, fp]

    movz	fp,	#1980
    str	x17,	[sp, fp]

    movz	fp,	#1980
    ldr	x18,	[sp, fp]

    str	w13,	[x18]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#50
    ble	main_413

main_215:
    movz	w13,	#50
    movz	fp,	#588
    ldr	x14,	[sp, fp]

    movz	fp,	#1972
    str	x14,	[sp, fp]

    movz	fp,	#1972
    ldr	x15,	[sp, fp]

    str	w13,	[x15]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#51
    ble	main_413

main_217:
    movz	w13,	#51
    movz	fp,	#596
    mov	w15,	w13
    ldr	x11,	[sp, fp]

    movz	fp,	#1964
    str	x11,	[sp, fp]

    movz	fp,	#1964
    ldr	x12,	[sp, fp]

    str	w15,	[x12]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#52
    ble	main_413

main_219:
    movz	w13,	#52
    movz	fp,	#604
    mov	w15,	w13
    ldr	x8,	[sp, fp]

    movz	fp,	#1956
    str	x8,	[sp, fp]

    movz	fp,	#1956
    ldr	x9,	[sp, fp]

    str	w15,	[x9]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#53
    ble	main_413

main_221:
    movz	w13,	#53
    movz	fp,	#732
    mov	w15,	w13
    ldr	x5,	[sp, fp]

    movz	fp,	#1948
    str	x5,	[sp, fp]

    movz	fp,	#1948
    ldr	x6,	[sp, fp]

    str	w15,	[x6]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#54
    ble	main_413

main_223:
    movz	w13,	#54
    movz	fp,	#724
    mov	w15,	w13
    ldr	x2,	[sp, fp]

    movz	fp,	#1940
    str	x2,	[sp, fp]

    movz	fp,	#1940
    ldr	x3,	[sp, fp]

    str	w15,	[x3]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#55
    ble	main_413

main_225:
    movz	w13,	#55
    ldr	x28,	[sp, #416]

    movz	fp,	#2132
    mov	w14,	w13
    str	x28,	[sp, fp]

    movz	fp,	#2132
    ldr	x0,	[sp, fp]

    str	w14,	[x0]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#56
    ble	main_413

main_227:
    movz	w13,	#56
    ldr	x25,	[sp, #424]

    movz	fp,	#2124
    str	x25,	[sp, fp]

    movz	fp,	#2124
    ldr	x26,	[sp, fp]

    str	w13,	[x26]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#57
    ble	main_413

main_229:
    movz	w13,	#57
    movz	fp,	#740
    ldr	x22,	[sp, fp]

    movz	fp,	#2116
    str	x22,	[sp, fp]

    movz	fp,	#2116
    ldr	x23,	[sp, fp]

    str	w13,	[x23]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#58
    ble	main_413

main_231:
    movz	w13,	#58
    movz	fp,	#748
    ldr	x19,	[sp, fp]

    movz	fp,	#2108
    str	x19,	[sp, fp]

    movz	fp,	#2108
    ldr	x20,	[sp, fp]

    str	w13,	[x20]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#59
    ble	main_413

main_233:
    movz	w13,	#59
    movz	fp,	#756
    ldr	x16,	[sp, fp]

    movz	fp,	#2100
    str	x16,	[sp, fp]

    movz	fp,	#2100
    ldr	x17,	[sp, fp]

    str	w13,	[x17]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#60
    ble	main_413

main_235:
    movz	w13,	#60
    movz	fp,	#764
    mov	w15,	w13
    ldr	x13,	[sp, fp]

    movz	fp,	#2092
    str	x13,	[sp, fp]

    movz	fp,	#2092
    ldr	x14,	[sp, fp]

    str	w15,	[x14]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#61
    ble	main_413

main_237:
    movz	w13,	#61
    movz	fp,	#772
    mov	w15,	w13
    ldr	x10,	[sp, fp]

    movz	fp,	#2084
    str	x10,	[sp, fp]

    movz	fp,	#2084
    ldr	x11,	[sp, fp]

    str	w15,	[x11]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#62
    ble	main_413

main_239:
    movz	w13,	#62
    movz	fp,	#780
    mov	w15,	w13
    ldr	x7,	[sp, fp]

    movz	fp,	#2076
    str	x7,	[sp, fp]

    movz	fp,	#2076
    ldr	x8,	[sp, fp]

    str	w15,	[x8]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#63
    ble	main_413

main_241:
    movz	w13,	#63
    movz	fp,	#788
    mov	w15,	w13
    ldr	x4,	[sp, fp]

    movz	fp,	#1796
    str	x4,	[sp, fp]

    movz	fp,	#1796
    ldr	x5,	[sp, fp]

    str	w15,	[x5]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#64
    ble	main_413

main_243:
    movz	w13,	#64
    movz	fp,	#796
    mov	w15,	w13
    ldr	x1,	[sp, fp]

    movz	fp,	#1788
    str	x1,	[sp, fp]

    movz	fp,	#1788
    ldr	x2,	[sp, fp]

    str	w15,	[x2]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#65
    ble	main_413

main_245:
    movz	w13,	#65
    movz	fp,	#804
    ldr	x27,	[sp, fp]

    movz	fp,	#1780
    str	x27,	[sp, fp]

    movz	fp,	#1780
    ldr	x28,	[sp, fp]

    str	w13,	[x28]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#66
    ble	main_413

main_247:
    movz	w13,	#66
    movz	fp,	#812
    ldr	x24,	[sp, fp]

    movz	fp,	#1772
    str	x24,	[sp, fp]

    movz	fp,	#1772
    ldr	x25,	[sp, fp]

    str	w13,	[x25]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#67
    ble	main_413

main_249:
    movz	w13,	#67
    movz	fp,	#820
    ldr	x21,	[sp, fp]

    movz	fp,	#1764
    str	x21,	[sp, fp]

    movz	fp,	#1764
    ldr	x22,	[sp, fp]

    str	w13,	[x22]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#68
    ble	main_413

main_251:
    movz	w13,	#68
    movz	fp,	#828
    ldr	x18,	[sp, fp]

    movz	fp,	#1756
    str	x18,	[sp, fp]

    movz	fp,	#1756
    ldr	x19,	[sp, fp]

    str	w13,	[x19]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#69
    ble	main_413

main_253:
    movz	w13,	#69
    movz	fp,	#836
    ldr	x15,	[sp, fp]

    movz	fp,	#2068
    str	x15,	[sp, fp]

    movz	fp,	#2068
    ldr	x16,	[sp, fp]

    str	w13,	[x16]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#70
    ble	main_413

main_255:
    movz	w13,	#70
    movz	fp,	#844
    mov	w15,	w13
    ldr	x12,	[sp, fp]

    movz	fp,	#2060
    str	x12,	[sp, fp]

    movz	fp,	#2060
    ldr	x13,	[sp, fp]

    str	w15,	[x13]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#71
    ble	main_413

main_257:
    movz	w13,	#71
    movz	fp,	#852
    mov	w15,	w13
    ldr	x9,	[sp, fp]

    movz	fp,	#2052
    str	x9,	[sp, fp]

    movz	fp,	#2052
    ldr	x10,	[sp, fp]

    str	w15,	[x10]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#72
    ble	main_413

main_259:
    movz	w13,	#72
    movz	fp,	#860
    mov	w15,	w13
    ldr	x6,	[sp, fp]

    movz	fp,	#2044
    str	x6,	[sp, fp]

    movz	fp,	#2044
    ldr	x7,	[sp, fp]

    str	w15,	[x7]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#73
    ble	main_413

main_261:
    movz	w13,	#73
    movz	fp,	#868
    mov	w15,	w13
    ldr	x3,	[sp, fp]

    movz	fp,	#2036
    str	x3,	[sp, fp]

    movz	fp,	#2036
    ldr	x4,	[sp, fp]

    str	w15,	[x4]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#74
    ble	main_413

main_263:
    movz	w13,	#74
    movz	fp,	#876
    mov	w15,	w13
    ldr	x0,	[sp, fp]

    movz	fp,	#2028
    str	x0,	[sp, fp]

    movz	fp,	#2028
    ldr	x1,	[sp, fp]

    str	w15,	[x1]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#75
    ble	main_413

main_265:
    movz	w13,	#75
    movz	fp,	#884
    ldr	x26,	[sp, fp]

    movz	fp,	#1932
    str	x26,	[sp, fp]

    movz	fp,	#1932
    ldr	x27,	[sp, fp]

    str	w13,	[x27]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#76
    ble	main_413

main_267:
    movz	w13,	#76
    movz	fp,	#892
    ldr	x23,	[sp, fp]

    movz	fp,	#1924
    str	x23,	[sp, fp]

    movz	fp,	#1924
    ldr	x24,	[sp, fp]

    str	w13,	[x24]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#77
    ble	main_413

main_269:
    movz	w13,	#77
    movz	fp,	#900
    ldr	x20,	[sp, fp]

    movz	fp,	#1916
    str	x20,	[sp, fp]

    movz	fp,	#1916
    ldr	x21,	[sp, fp]

    str	w13,	[x21]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#78
    ble	main_413

main_271:
    movz	w13,	#78
    movz	fp,	#908
    ldr	x17,	[sp, fp]

    movz	fp,	#1908
    str	x17,	[sp, fp]

    movz	fp,	#1908
    ldr	x18,	[sp, fp]

    str	w13,	[x18]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#79
    ble	main_413

main_273:
    movz	w13,	#79
    movz	fp,	#916
    ldr	x14,	[sp, fp]

    movz	fp,	#1900
    str	x14,	[sp, fp]

    movz	fp,	#1900
    ldr	x15,	[sp, fp]

    str	w13,	[x15]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#80
    ble	main_413

main_275:
    movz	w13,	#80
    movz	fp,	#924
    mov	w15,	w13
    ldr	x11,	[sp, fp]

    movz	fp,	#1836
    str	x11,	[sp, fp]

    movz	fp,	#1836
    ldr	x12,	[sp, fp]

    str	w15,	[x12]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#81
    ble	main_413

main_277:
    movz	w13,	#81
    movz	fp,	#932
    mov	w15,	w13
    ldr	x8,	[sp, fp]

    movz	fp,	#1828
    str	x8,	[sp, fp]

    movz	fp,	#1828
    ldr	x9,	[sp, fp]

    str	w15,	[x9]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#82
    ble	main_413

main_279:
    movz	w13,	#82
    movz	fp,	#940
    mov	w15,	w13
    ldr	x5,	[sp, fp]

    movz	fp,	#1820
    str	x5,	[sp, fp]

    movz	fp,	#1820
    ldr	x6,	[sp, fp]

    str	w15,	[x6]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#83
    ble	main_413

main_281:
    movz	w13,	#83
    movz	fp,	#948
    mov	w15,	w13
    ldr	x2,	[sp, fp]

    movz	fp,	#1812
    str	x2,	[sp, fp]

    movz	fp,	#1812
    ldr	x3,	[sp, fp]

    str	w15,	[x3]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#84
    ble	main_413

main_283:
    movz	w13,	#84
    movz	fp,	#956
    mov	w14,	w13
    ldr	x28,	[sp, fp]

    movz	fp,	#1804
    str	x28,	[sp, fp]

    movz	fp,	#1804
    ldr	x0,	[sp, fp]

    str	w14,	[x0]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#85
    ble	main_413

main_285:
    movz	w13,	#85
    movz	fp,	#964
    ldr	x25,	[sp, fp]

    movz	fp,	#1748
    str	x25,	[sp, fp]

    movz	fp,	#1748
    ldr	x26,	[sp, fp]

    str	w13,	[x26]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#86
    ble	main_413

main_287:
    movz	w13,	#86
    movz	fp,	#972
    ldr	x22,	[sp, fp]

    movz	fp,	#1740
    str	x22,	[sp, fp]

    movz	fp,	#1740
    ldr	x23,	[sp, fp]

    str	w13,	[x23]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#87
    ble	main_413

main_289:
    movz	w13,	#87
    movz	fp,	#980
    ldr	x19,	[sp, fp]

    movz	fp,	#1732
    str	x19,	[sp, fp]

    movz	fp,	#1732
    ldr	x20,	[sp, fp]

    str	w13,	[x20]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#88
    ble	main_413

main_291:
    movz	w13,	#88
    movz	fp,	#988
    ldr	x16,	[sp, fp]

    movz	fp,	#1724
    str	x16,	[sp, fp]

    movz	fp,	#1724
    ldr	x17,	[sp, fp]

    str	w13,	[x17]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#89
    ble	main_413

main_293:
    movz	w13,	#89
    movz	fp,	#996
    mov	w15,	w13
    ldr	x13,	[sp, fp]

    movz	fp,	#1716
    str	x13,	[sp, fp]

    movz	fp,	#1716
    ldr	x14,	[sp, fp]

    str	w15,	[x14]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#90
    ble	main_413

main_295:
    movz	w13,	#90
    movz	fp,	#1004
    mov	w15,	w13
    ldr	x10,	[sp, fp]

    movz	fp,	#1708
    str	x10,	[sp, fp]

    movz	fp,	#1708
    ldr	x11,	[sp, fp]

    str	w15,	[x11]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#91
    ble	main_413

main_297:
    movz	w13,	#91
    movz	fp,	#1012
    mov	w15,	w13
    ldr	x7,	[sp, fp]

    movz	fp,	#1700
    str	x7,	[sp, fp]

    movz	fp,	#1700
    ldr	x8,	[sp, fp]

    str	w15,	[x8]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#92
    ble	main_413

main_299:
    movz	w13,	#92
    movz	fp,	#1020
    mov	w15,	w13
    ldr	x4,	[sp, fp]

    movz	fp,	#1692
    str	x4,	[sp, fp]

    movz	fp,	#1692
    ldr	x5,	[sp, fp]

    str	w15,	[x5]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#93
    ble	main_413

main_301:
    movz	w13,	#93
    movz	fp,	#1028
    mov	w15,	w13
    ldr	x1,	[sp, fp]

    movz	fp,	#1892
    str	x1,	[sp, fp]

    movz	fp,	#1892
    ldr	x2,	[sp, fp]

    str	w15,	[x2]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#94
    ble	main_413

main_303:
    movz	w13,	#94
    movz	fp,	#1036
    ldr	x27,	[sp, fp]

    movz	fp,	#1884
    str	x27,	[sp, fp]

    movz	fp,	#1884
    ldr	x28,	[sp, fp]

    str	w13,	[x28]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#95
    ble	main_413

main_305:
    movz	w13,	#95
    movz	fp,	#1044
    ldr	x24,	[sp, fp]

    movz	fp,	#1876
    str	x24,	[sp, fp]

    movz	fp,	#1876
    ldr	x25,	[sp, fp]

    str	w13,	[x25]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#96
    ble	main_413

main_307:
    movz	w13,	#96
    movz	fp,	#1052
    ldr	x21,	[sp, fp]

    movz	fp,	#1868
    str	x21,	[sp, fp]

    movz	fp,	#1868
    ldr	x22,	[sp, fp]

    str	w13,	[x22]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#97
    ble	main_413

main_309:
    movz	w13,	#97
    movz	fp,	#1060
    ldr	x18,	[sp, fp]

    movz	fp,	#1860
    str	x18,	[sp, fp]

    movz	fp,	#1860
    ldr	x19,	[sp, fp]

    str	w13,	[x19]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#98
    ble	main_413

main_311:
    movz	w13,	#98
    movz	fp,	#1068
    ldr	x15,	[sp, fp]

    movz	fp,	#1852
    str	x15,	[sp, fp]

    movz	fp,	#1852
    ldr	x16,	[sp, fp]

    str	w13,	[x16]

    ldr	w13,	[sp, #1096]

    cmp	w13,	#99
    ble	main_413

main_313:
    movz	w13,	#99
    movz	fp,	#1076
    mov	w15,	w13
    ldr	x12,	[sp, fp]

    movz	fp,	#1844
    str	x12,	[sp, fp]

    movz	fp,	#1844
    ldr	x13,	[sp, fp]

    str	w15,	[x13]


main_413:
    ldr	w13,	[sp, #1084]

    add	w13,	w13,	#1
    str	w13,	[sp, #436]

    ldr	w13,	[sp, #1088]

    str	w13,	[sp, #432]

    movz	w13,	#0
    str	w13,	[sp, #456]


main_415:
    ldr	w13,	[sp, #456]

    cmp	w13,	#100
    bge	main_424

main_419:
    ldr	w13,	[sp, #456]

    lsl	w13,	w13,	#2
    mov	x13,	x13
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w15,	[x13]

    ldr	w13,	[sp, #432]

    str	w13,	[sp, #2900]

    ldr	w14,	[sp, #2900]

    ldr	w10,	[sp, #456]

    add	w17,	w15,	w14
    str	w10,	[sp, #2896]

    mov	w13,	w17
    ldr	w11,	[sp, #2896]

    add	w4,	w11,	#1
    str	w4,	[sp, #2888]

    ldr	w5,	[sp, #2888]

    str	w5,	[sp, #472]

    str	w13,	[sp, #432]

    ldr	w13,	[sp, #472]

    str	w13,	[sp, #456]

    b	main_415

main_424:
    movz	w13,	#65535
    ldr	w16,	[sp, #432]

    str	w16,	[sp, #2904]

    ldr	w17,	[sp, #2904]

    sdiv	w13,	w17,	w13
    str	w13,	[sp, #460]

    ldr	w13,	[sp, #460]

    ldr	w7,	[sp, #460]

    lsl	w15,	w13,	#16
    str	w7,	[sp, #2892]

    ldr	w8,	[sp, #2892]

    ldr	w19,	[sp, #432]

    sub	w13,	w15,	w8,	lsl #0
    str	w19,	[sp, #2908]

    ldr	w20,	[sp, #2908]

    ldr	w7,	[sp, #436]

    sub	w16,	w20,	w13
    str	w7,	[sp, #2236]

    ldr	w22,	[sp, #1092]

    str	w22,	[sp, #2912]

    ldr	w8,	[sp, #2236]

    ldr	w0,	[sp, #2912]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w13,	w16
    str	w13,	[sp, #1088]

    ldr	w13,	[sp, #436]

    str	w13,	[sp, #1084]

    b	main_113

main_428:
    mov	w0,	w16
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


