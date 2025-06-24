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
    str	w0,	[sp, #1012]

    bl	getint
    str	w0,	[sp, #1016]

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
    ldr	w15,	[sp, #1012]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x25,	sp,	#20
    movz	fp,	#1596
    add	x21,	sp,	#24
    add	x8,	sp,	#28
    add	x19,	sp,	#32
    add	x4,	sp,	#36
    add	x27,	sp,	#40
    add	x2,	sp,	#44
    add	x3,	sp,	#48
    add	x17,	sp,	#52
    add	x13,	sp,	#56
    add	x10,	sp,	#60
    add	x28,	sp,	#64
    add	x15,	sp,	#68
    add	x9,	sp,	#72
    add	x0,	sp,	#76
    add	x6,	sp,	#80
    add	x5,	sp,	#84
    add	x20,	sp,	#88
    add	x16,	sp,	#92
    add	x7,	sp,	#96
    add	x22,	sp,	#100
    add	x18,	sp,	#104
    add	x24,	sp,	#108
    add	x26,	sp,	#112
    add	x11,	sp,	#116
    add	x23,	sp,	#120
    add	x14,	sp,	#124
    add	x1,	sp,	#128
    str	x25,	[sp, fp]

    movz	fp,	#1436
    str	x21,	[sp, fp]

    movz	fp,	#1628
    str	x8,	[sp, fp]

    movz	fp,	#1580
    str	x19,	[sp, fp]

    movz	fp,	#1540
    str	x4,	[sp, fp]

    movz	fp,	#1452
    str	x27,	[sp, fp]

    movz	fp,	#1612
    str	x2,	[sp, fp]

    movz	fp,	#1692
    str	x3,	[sp, fp]

    movz	fp,	#1652
    str	x17,	[sp, fp]

    movz	fp,	#1564
    str	x13,	[sp, fp]

    add	x13,	sp,	#136
    movz	fp,	#1556
    str	x10,	[sp, fp]

    movz	fp,	#1604
    str	x28,	[sp, fp]

    movz	fp,	#1420
    str	x15,	[sp, fp]

    movz	fp,	#1708
    str	x9,	[sp, fp]

    movz	fp,	#1684
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#1700
    str	x6,	[sp, fp]

    movz	fp,	#1620
    str	x5,	[sp, fp]

    movz	fp,	#1660
    str	x20,	[sp, fp]

    movz	fp,	#1572
    str	x16,	[sp, fp]

    movz	fp,	#1548
    str	x7,	[sp, fp]

    movz	fp,	#1588
    str	x22,	[sp, fp]

    movz	fp,	#1428
    str	x18,	[sp, fp]

    movz	fp,	#1444
    str	x24,	[sp, fp]

    movz	fp,	#1676
    str	x26,	[sp, fp]

    movz	fp,	#1636
    str	x11,	[sp, fp]

    movz	fp,	#1668
    str	x23,	[sp, fp]

    movz	fp,	#1644
    str	x14,	[sp, fp]

    movz	fp,	#1524
    str	x1,	[sp, fp]

    movz	fp,	#436
    str	x0,	[sp, fp]

    add	x0,	sp,	#140
    movz	fp,	#540
    str	x13,	[sp, fp]

    movz	fp,	#628
    add	x13,	sp,	#144
    str	x0,	[sp, #448]

    add	x0,	sp,	#148
    str	x13,	[sp, #456]

    add	x13,	sp,	#152
    str	x0,	[sp, fp]

    add	x0,	sp,	#156
    movz	fp,	#636
    str	x13,	[sp, fp]

    add	x13,	sp,	#164
    movz	fp,	#644
    str	x0,	[sp, fp]

    movz	fp,	#476
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#484
    str	x13,	[sp, fp]

    add	x13,	sp,	#172
    movz	fp,	#492
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#500
    str	x13,	[sp, fp]

    add	x13,	sp,	#180
    movz	fp,	#508
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#516
    str	x13,	[sp, fp]

    add	x13,	sp,	#188
    movz	fp,	#524
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#532
    str	x13,	[sp, fp]

    add	x13,	sp,	#200
    movz	fp,	#548
    str	x0,	[sp, fp]

    movz	fp,	#556
    add	x0,	sp,	#196
    str	x0,	[sp, fp]

    add	x0,	sp,	#204
    movz	fp,	#564
    str	x13,	[sp, fp]

    add	x13,	sp,	#208
    movz	fp,	#572
    str	x0,	[sp, fp]

    add	x0,	sp,	#212
    movz	fp,	#580
    str	x13,	[sp, fp]

    add	x13,	sp,	#216
    movz	fp,	#588
    str	x0,	[sp, fp]

    add	x0,	sp,	#220
    movz	fp,	#596
    str	x13,	[sp, fp]

    add	x13,	sp,	#224
    movz	fp,	#604
    str	x0,	[sp, fp]

    add	x0,	sp,	#228
    movz	fp,	#612
    str	x13,	[sp, fp]

    add	x13,	sp,	#232
    movz	fp,	#652
    str	x0,	[sp, fp]

    add	x0,	sp,	#240
    movz	fp,	#620
    str	x13,	[sp, fp]

    movz	fp,	#660
    add	x13,	sp,	#236
    str	x13,	[sp, #416]

    add	x13,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x13,	[sp, fp]

    add	x13,	sp,	#252
    movz	fp,	#668
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#676
    str	x13,	[sp, fp]

    add	x13,	sp,	#260
    movz	fp,	#684
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#692
    str	x13,	[sp, fp]

    add	x13,	sp,	#268
    movz	fp,	#700
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#708
    str	x13,	[sp, fp]

    add	x13,	sp,	#280
    movz	fp,	#716
    str	x0,	[sp, fp]

    movz	fp,	#724
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#732
    str	x13,	[sp, fp]

    add	x13,	sp,	#288
    movz	fp,	#740
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#748
    str	x13,	[sp, fp]

    add	x13,	sp,	#296
    movz	fp,	#756
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#764
    str	x13,	[sp, fp]

    add	x13,	sp,	#304
    movz	fp,	#772
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#780
    str	x13,	[sp, fp]

    add	x13,	sp,	#316
    movz	fp,	#788
    str	x0,	[sp, fp]

    movz	fp,	#796
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#804
    str	x13,	[sp, fp]

    add	x13,	sp,	#324
    movz	fp,	#812
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#820
    str	x13,	[sp, fp]

    add	x13,	sp,	#332
    movz	fp,	#828
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#836
    str	x13,	[sp, fp]

    add	x13,	sp,	#340
    movz	fp,	#844
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#852
    str	x13,	[sp, fp]

    add	x13,	sp,	#348
    movz	fp,	#860
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#868
    str	x13,	[sp, fp]

    movz	fp,	#876
    add	x13,	sp,	#352
    str	x13,	[sp, fp]

    add	x13,	sp,	#360
    movz	fp,	#884
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#892
    str	x13,	[sp, fp]

    add	x13,	sp,	#368
    movz	fp,	#900
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#908
    str	x13,	[sp, fp]

    add	x13,	sp,	#376
    movz	fp,	#916
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#924
    str	x13,	[sp, fp]

    add	x13,	sp,	#384
    movz	fp,	#932
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#940
    str	x13,	[sp, fp]

    add	x13,	sp,	#396
    movz	fp,	#948
    str	x0,	[sp, fp]

    movz	fp,	#956
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#964
    str	x13,	[sp, fp]

    add	x13,	sp,	#404
    movz	fp,	#972
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#980
    str	x13,	[sp, fp]

    add	x13,	sp,	#412
    movz	fp,	#988
    str	x0,	[sp, fp]

    movz	fp,	#996
    str	x13,	[sp, fp]

    movz	w13,	#0
    mov	w0,	w13
    movz	w13,	#0
    str	w0,	[sp, #1008]

    mov	w0,	w13
    str	w0,	[sp, #1004]


main_113:
    ldr	w0,	[sp, #1016]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w13,	#1
    movz	fp,	#1596
    mov	w0,	w13
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#2
    ble	main_413

main_119:
    movz	w13,	#2
    movz	fp,	#1436
    ldr	x15,	[sp, fp]

    str	w13,	[x15]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w13,	#3
    movz	fp,	#1628
    mov	w0,	w13
    ldr	x5,	[sp, fp]

    str	w0,	[x5]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1580
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w13,	#5
    movz	fp,	#1540
    ldr	x28,	[sp, fp]

    str	w13,	[x28]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    movz	fp,	#1452
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    movz	fp,	#1612
    mov	w13,	w0
    ldr	x27,	[sp, fp]

    str	w13,	[x27]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#8
    ble	main_413

main_131:
    movz	w13,	#8
    movz	fp,	#1692
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    movz	fp,	#1652
    mov	w13,	w0
    ldr	x12,	[sp, fp]

    str	w13,	[x12]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#10
    ble	main_413

main_135:
    movz	w13,	#10
    movz	fp,	#1564
    mov	w0,	w13
    ldr	x9,	[sp, fp]

    str	w0,	[x9]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w13,	#11
    movz	fp,	#1556
    ldr	x4,	[sp, fp]

    str	w13,	[x4]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#12
    ble	main_413

main_139:
    movz	w13,	#12
    movz	fp,	#1604
    mov	w0,	w13
    ldr	x24,	[sp, fp]

    str	w0,	[x24]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1420
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#14
    ble	main_413

main_143:
    movz	w13,	#14
    movz	fp,	#1708
    ldr	x5,	[sp, fp]

    str	w13,	[x5]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    movz	fp,	#1684
    ldr	x26,	[sp, fp]

    str	w0,	[x26]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    movz	fp,	#1700
    mov	w13,	w0
    ldr	x2,	[sp, fp]

    str	w13,	[x2]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w13,	#17
    movz	fp,	#1620
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1660
    mov	w13,	w0
    ldr	x16,	[sp, fp]

    str	w13,	[x16]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w13,	#19
    movz	fp,	#1572
    mov	w0,	w13
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#20
    ble	main_413

main_155:
    movz	w13,	#20
    movz	fp,	#1548
    ldr	x1,	[sp, fp]

    str	w13,	[x1]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w13,	#21
    movz	fp,	#1588
    mov	w0,	w13
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1428
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w13,	#23
    movz	fp,	#1444
    ldr	x18,	[sp, fp]

    str	w13,	[x18]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1676
    ldr	x23,	[sp, fp]

    str	w0,	[x23]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    movz	fp,	#1636
    mov	w13,	w0
    ldr	x6,	[sp, fp]

    str	w13,	[x6]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w13,	#26
    movz	fp,	#1668
    ldr	x19,	[sp, fp]

    str	w13,	[x19]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1644
    mov	w13,	w0
    ldr	x9,	[sp, fp]

    str	w13,	[x9]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w13,	#28
    movz	fp,	#1524
    mov	w0,	w13
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#29
    ble	main_413

main_173:
    movz	w13,	#29
    movz	fp,	#436
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w13,	#30
    movz	fp,	#540
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    ldr	x13,	[sp, #448]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w13,	#32
    ldr	x0,	[sp, #456]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    movz	fp,	#628
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    movz	fp,	#636
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#35
    ble	main_413

main_185:
    movz	w13,	#35
    movz	fp,	#644
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    movz	fp,	#476
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#37
    ble	main_413

main_189:
    movz	w13,	#37
    movz	fp,	#484
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w13,	#38
    movz	fp,	#492
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#39
    ble	main_413

main_193:
    movz	w13,	#39
    movz	fp,	#500
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#508
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#41
    ble	main_413

main_197:
    movz	w13,	#41
    movz	fp,	#516
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    movz	fp,	#524
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    movz	fp,	#532
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w13,	#44
    movz	fp,	#548
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    movz	fp,	#556
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w13,	#46
    movz	fp,	#564
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#47
    ble	main_413

main_209:
    movz	w13,	#47
    movz	fp,	#572
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w13,	#48
    movz	fp,	#580
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    movz	fp,	#588
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w13,	#50
    movz	fp,	#596
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    movz	fp,	#604
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    movz	fp,	#612
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#53
    ble	main_413

main_221:
    movz	w13,	#53
    movz	fp,	#652
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    movz	fp,	#620
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w13,	#55
    mov	w0,	w13
    ldr	x13,	[sp, #416]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#56
    ble	main_413

main_227:
    movz	w13,	#56
    ldr	x0,	[sp, #424]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w13,	#57
    movz	fp,	#660
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#668
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w13,	#59
    movz	fp,	#676
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#684
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    movz	fp,	#692
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#62
    ble	main_413

main_239:
    movz	w13,	#62
    movz	fp,	#700
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#708
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#64
    ble	main_413

main_243:
    movz	w13,	#64
    movz	fp,	#716
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w13,	#65
    movz	fp,	#724
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#66
    ble	main_413

main_247:
    movz	w13,	#66
    movz	fp,	#732
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#740
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#68
    ble	main_413

main_251:
    movz	w13,	#68
    movz	fp,	#748
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#756
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    movz	fp,	#764
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w13,	#71
    movz	fp,	#772
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#780
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w13,	#73
    movz	fp,	#788
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#74
    ble	main_413

main_263:
    movz	w13,	#74
    movz	fp,	#796
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w13,	#75
    movz	fp,	#804
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#812
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w13,	#77
    movz	fp,	#820
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#828
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    movz	fp,	#836
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#80
    ble	main_413

main_275:
    movz	w13,	#80
    movz	fp,	#844
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#852
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#82
    ble	main_413

main_279:
    movz	w13,	#82
    movz	fp,	#860
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w13,	#83
    movz	fp,	#868
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w13,	#84
    movz	fp,	#876
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#884
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w13,	#86
    movz	fp,	#892
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#900
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    movz	fp,	#908
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#89
    ble	main_413

main_293:
    movz	w13,	#89
    movz	fp,	#916
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#924
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#91
    ble	main_413

main_297:
    movz	w13,	#91
    movz	fp,	#932
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w13,	#92
    movz	fp,	#940
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#93
    ble	main_413

main_301:
    movz	w13,	#93
    movz	fp,	#948
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#956
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#95
    ble	main_413

main_305:
    movz	w13,	#95
    movz	fp,	#964
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#972
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    movz	fp,	#980
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1016]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w13,	#98
    movz	fp,	#988
    mov	w0,	w13
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w13,	[sp, #1016]

    cmp	w13,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#996
    mov	w13,	w0
    ldr	x0,	[sp, fp]

    str	w13,	[x0]


main_413:
    ldr	w13,	[sp, #1004]

    add	w0,	w13,	#1
    str	w0,	[sp, #432]

    ldr	w0,	[sp, #1008]

    str	w0,	[sp, #472]

    movz	w0,	#0
    mov	w13,	w0
    str	w13,	[sp, #468]


main_415:
    ldr	w0,	[sp, #468]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w13,	[sp, #468]

    lsl	w0,	w13,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w13,	[sp, #472]

    add	w0,	w0,	w13
    ldr	w13,	[sp, #468]

    add	w13,	w13,	#1
    str	w13,	[sp, #444]

    str	w0,	[sp, #472]

    ldr	w13,	[sp, #444]

    str	w13,	[sp, #468]

    b	main_415

main_424:
    movz	w13,	#65535
    ldr	w0,	[sp, #472]

    sdiv	w13,	w0,	w13
    str	w13,	[sp, #464]

    ldr	w0,	[sp, #464]

    lsl	w26,	w0,	#16
    str	w26,	[sp, #2820]

    ldr	w0,	[sp, #464]

    ldr	w27,	[sp, #2820]

    sub	w13,	w27,	w0,	lsl #0
    ldr	w0,	[sp, #472]

    sub	w13,	w0,	w13
    ldr	w0,	[sp, #432]

    str	w0,	[sp, #2824]

    ldr	w5,	[sp, #1012]

    str	w5,	[sp, #1876]

    ldr	w7,	[sp, #1876]

    ldr	w1,	[sp, #2824]

    cmp	w1,	w7
    bge	main_428

main_112:
    mov	w0,	w13
    str	w0,	[sp, #1008]

    ldr	w0,	[sp, #432]

    str	w0,	[sp, #1004]

    b	main_113

main_428:
    mov	w0,	w13
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
    
    add	sp, sp, #3168
    ret


