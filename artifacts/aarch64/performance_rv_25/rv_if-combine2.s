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
    str	w0,	[sp, #1028]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1032]

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
    ldr	w15,	[sp, #1028]

    cmp	w27,	w15
    bge	main_427

main_12:
    add	x25,	sp,	#20
    movz	fp,	#1628
    add	x20,	sp,	#24
    add	x0,	sp,	#28
    add	x14,	sp,	#32
    add	x13,	sp,	#36
    add	x9,	sp,	#40
    add	x15,	sp,	#44
    add	x2,	sp,	#48
    add	x28,	sp,	#52
    add	x1,	sp,	#56
    add	x7,	sp,	#60
    add	x8,	sp,	#64
    add	x11,	sp,	#68
    add	x17,	sp,	#72
    add	x5,	sp,	#76
    add	x16,	sp,	#80
    add	x19,	sp,	#84
    add	x18,	sp,	#88
    add	x21,	sp,	#92
    add	x4,	sp,	#96
    add	x10,	sp,	#100
    add	x24,	sp,	#104
    add	x23,	sp,	#108
    add	x6,	sp,	#112
    add	x3,	sp,	#116
    add	x22,	sp,	#120
    add	x27,	sp,	#124
    add	x26,	sp,	#128
    str	x25,	[sp, fp]

    movz	fp,	#1692
    str	x20,	[sp, fp]

    movz	fp,	#1716
    str	x0,	[sp, fp]

    add	x0,	sp,	#136
    movz	fp,	#1676
    str	x14,	[sp, fp]

    movz	fp,	#1044
    str	x13,	[sp, fp]

    movz	fp,	#1740
    str	x9,	[sp, fp]

    movz	fp,	#1308
    str	x15,	[sp, fp]

    movz	fp,	#1644
    str	x2,	[sp, fp]

    movz	fp,	#1636
    str	x28,	[sp, fp]

    movz	fp,	#1556
    str	x1,	[sp, fp]

    movz	fp,	#1572
    str	x7,	[sp, fp]

    movz	fp,	#1660
    str	x8,	[sp, fp]

    movz	fp,	#1668
    str	x11,	[sp, fp]

    movz	fp,	#1684
    str	x17,	[sp, fp]

    movz	fp,	#1652
    str	x5,	[sp, fp]

    movz	fp,	#1052
    str	x16,	[sp, fp]

    movz	fp,	#1060
    str	x19,	[sp, fp]

    movz	fp,	#1316
    str	x18,	[sp, fp]

    movz	fp,	#1532
    str	x21,	[sp, fp]

    add	x21,	sp,	#132
    movz	fp,	#1564
    str	x4,	[sp, fp]

    movz	fp,	#1036
    str	x10,	[sp, fp]

    movz	fp,	#1540
    str	x24,	[sp, fp]

    movz	fp,	#1700
    str	x23,	[sp, fp]

    movz	fp,	#1732
    str	x6,	[sp, fp]

    movz	fp,	#1724
    str	x3,	[sp, fp]

    movz	fp,	#1068
    str	x22,	[sp, fp]

    movz	fp,	#1548
    str	x27,	[sp, fp]

    movz	fp,	#1708
    str	x26,	[sp, fp]

    movz	fp,	#508
    str	x21,	[sp, fp]

    add	x21,	sp,	#140
    movz	fp,	#500
    str	x0,	[sp, fp]

    movz	fp,	#628
    add	x0,	sp,	#144
    str	x21,	[sp, #648]

    add	x21,	sp,	#148
    str	x0,	[sp, fp]

    add	x0,	sp,	#152
    movz	fp,	#636
    str	x21,	[sp, fp]

    add	x21,	sp,	#156
    movz	fp,	#516
    str	x0,	[sp, fp]

    add	x0,	sp,	#160
    movz	fp,	#524
    str	x21,	[sp, fp]

    add	x21,	sp,	#164
    movz	fp,	#532
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#452
    str	x21,	[sp, fp]

    add	x21,	sp,	#172
    movz	fp,	#460
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#468
    str	x21,	[sp, fp]

    add	x21,	sp,	#180
    movz	fp,	#476
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#484
    str	x21,	[sp, fp]

    add	x21,	sp,	#188
    movz	fp,	#492
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#540
    str	x21,	[sp, fp]

    add	x21,	sp,	#196
    movz	fp,	#548
    str	x0,	[sp, fp]

    add	x0,	sp,	#200
    movz	fp,	#556
    str	x21,	[sp, fp]

    add	x21,	sp,	#204
    movz	fp,	#564
    str	x0,	[sp, fp]

    add	x0,	sp,	#208
    movz	fp,	#572
    str	x21,	[sp, fp]

    add	x21,	sp,	#212
    movz	fp,	#580
    str	x0,	[sp, fp]

    add	x0,	sp,	#216
    movz	fp,	#588
    str	x21,	[sp, fp]

    add	x21,	sp,	#220
    movz	fp,	#596
    str	x0,	[sp, fp]

    add	x0,	sp,	#224
    movz	fp,	#604
    str	x21,	[sp, fp]

    add	x21,	sp,	#228
    movz	fp,	#620
    str	x0,	[sp, fp]

    add	x0,	sp,	#232
    movz	fp,	#668
    str	x21,	[sp, fp]

    add	x21,	sp,	#236
    movz	fp,	#612
    str	x0,	[sp, fp]

    movz	fp,	#676
    add	x0,	sp,	#240
    str	x21,	[sp, #416]

    add	x21,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x21,	[sp, fp]

    add	x21,	sp,	#252
    movz	fp,	#684
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#692
    str	x21,	[sp, fp]

    add	x21,	sp,	#260
    movz	fp,	#700
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#708
    str	x21,	[sp, fp]

    add	x21,	sp,	#268
    movz	fp,	#716
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#724
    str	x21,	[sp, fp]

    add	x21,	sp,	#276
    movz	fp,	#732
    str	x0,	[sp, fp]

    add	x0,	sp,	#280
    movz	fp,	#740
    str	x21,	[sp, fp]

    add	x21,	sp,	#284
    movz	fp,	#748
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#756
    str	x21,	[sp, fp]

    add	x21,	sp,	#292
    movz	fp,	#764
    str	x0,	[sp, fp]

    add	x0,	sp,	#296
    movz	fp,	#772
    str	x21,	[sp, fp]

    add	x21,	sp,	#300
    movz	fp,	#780
    str	x0,	[sp, fp]

    add	x0,	sp,	#304
    movz	fp,	#788
    str	x21,	[sp, fp]

    add	x21,	sp,	#308
    movz	fp,	#796
    str	x0,	[sp, fp]

    add	x0,	sp,	#312
    movz	fp,	#804
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#812
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#820
    str	x21,	[sp, fp]

    add	x21,	sp,	#324
    movz	fp,	#828
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#836
    str	x21,	[sp, fp]

    add	x21,	sp,	#332
    movz	fp,	#844
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#852
    str	x21,	[sp, fp]

    add	x21,	sp,	#340
    movz	fp,	#860
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#868
    str	x21,	[sp, fp]

    add	x21,	sp,	#348
    movz	fp,	#876
    str	x0,	[sp, fp]

    add	x0,	sp,	#352
    movz	fp,	#884
    str	x21,	[sp, fp]

    add	x21,	sp,	#356
    movz	fp,	#892
    str	x0,	[sp, fp]

    add	x0,	sp,	#360
    movz	fp,	#900
    str	x21,	[sp, fp]

    add	x21,	sp,	#364
    movz	fp,	#908
    str	x0,	[sp, fp]

    add	x0,	sp,	#368
    movz	fp,	#916
    str	x21,	[sp, fp]

    add	x21,	sp,	#372
    movz	fp,	#924
    str	x0,	[sp, fp]

    add	x0,	sp,	#376
    movz	fp,	#932
    str	x21,	[sp, fp]

    add	x21,	sp,	#380
    movz	fp,	#940
    str	x0,	[sp, fp]

    add	x0,	sp,	#384
    movz	fp,	#948
    str	x21,	[sp, fp]

    add	x21,	sp,	#388
    movz	fp,	#956
    str	x0,	[sp, fp]

    add	x0,	sp,	#392
    movz	fp,	#964
    str	x21,	[sp, fp]

    add	x21,	sp,	#396
    movz	fp,	#972
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#980
    str	x21,	[sp, fp]

    add	x21,	sp,	#404
    movz	fp,	#988
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#996
    str	x21,	[sp, fp]

    add	x21,	sp,	#412
    movz	fp,	#1004
    str	x0,	[sp, fp]

    movz	fp,	#1012
    str	x21,	[sp, fp]

    movz	w21,	#0
    mov	w0,	w21
    movz	w21,	#0
    str	w0,	[sp, #1024]

    mov	w0,	w21
    str	w0,	[sp, #1020]


main_113:
    ldr	w21,	[sp, #1032]

    cmp	w21,	#1
    ble	main_413

main_117:
    movz	w21,	#1
    movz	fp,	#1628
    ldr	x22,	[sp, fp]

    str	w21,	[x22]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#2
    ble	main_413

main_119:
    movz	w21,	#2
    movz	fp,	#1692
    ldr	x16,	[sp, fp]

    str	w21,	[x16]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#3
    ble	main_413

main_121:
    movz	w21,	#3
    movz	fp,	#1716
    ldr	x27,	[sp, fp]

    str	w21,	[x27]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#4
    ble	main_413

main_123:
    movz	w21,	#4
    movz	fp,	#1676
    ldr	x10,	[sp, fp]

    str	w21,	[x10]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#5
    ble	main_413

main_125:
    movz	w21,	#5
    movz	fp,	#1044
    ldr	x8,	[sp, fp]

    str	w21,	[x8]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#6
    ble	main_413

main_127:
    movz	w21,	#6
    movz	fp,	#1740
    ldr	x6,	[sp, fp]

    str	w21,	[x6]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#7
    ble	main_413

main_129:
    movz	w21,	#7
    movz	fp,	#1308
    ldr	x9,	[sp, fp]

    str	w21,	[x9]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#8
    ble	main_413

main_131:
    movz	w21,	#8
    movz	fp,	#1644
    ldr	x28,	[sp, fp]

    str	w21,	[x28]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#9
    ble	main_413

main_133:
    movz	w21,	#9
    movz	fp,	#1636
    ldr	x25,	[sp, fp]

    str	w21,	[x25]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#10
    ble	main_413

main_135:
    movz	w21,	#10
    movz	fp,	#1556
    ldr	x26,	[sp, fp]

    str	w21,	[x26]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#11
    ble	main_413

main_137:
    movz	w21,	#11
    movz	fp,	#1572
    ldr	x2,	[sp, fp]

    str	w21,	[x2]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#12
    ble	main_413

main_139:
    movz	w21,	#12
    movz	fp,	#1660
    ldr	x4,	[sp, fp]

    str	w21,	[x4]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#13
    ble	main_413

main_141:
    movz	w21,	#13
    movz	fp,	#1668
    ldr	x7,	[sp, fp]

    str	w21,	[x7]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#14
    ble	main_413

main_143:
    movz	w21,	#14
    movz	fp,	#1684
    ldr	x13,	[sp, fp]

    str	w21,	[x13]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#15
    ble	main_413

main_145:
    movz	w21,	#15
    movz	fp,	#1652
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#16
    ble	main_413

main_147:
    movz	w21,	#16
    movz	fp,	#1052
    ldr	x11,	[sp, fp]

    str	w21,	[x11]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#17
    ble	main_413

main_149:
    movz	w21,	#17
    movz	fp,	#1060
    ldr	x14,	[sp, fp]

    str	w21,	[x14]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#18
    ble	main_413

main_151:
    movz	w21,	#18
    movz	fp,	#1316
    ldr	x12,	[sp, fp]

    str	w21,	[x12]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#19
    ble	main_413

main_153:
    movz	w21,	#19
    movz	fp,	#1532
    ldr	x15,	[sp, fp]

    str	w21,	[x15]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#20
    ble	main_413

main_155:
    movz	w21,	#20
    movz	fp,	#1564
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#21
    ble	main_413

main_157:
    movz	w21,	#21
    movz	fp,	#1036
    ldr	x5,	[sp, fp]

    str	w21,	[x5]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#22
    ble	main_413

main_159:
    movz	w21,	#22
    movz	fp,	#1540
    ldr	x19,	[sp, fp]

    str	w21,	[x19]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#23
    ble	main_413

main_161:
    movz	w21,	#23
    movz	fp,	#1700
    ldr	x20,	[sp, fp]

    str	w21,	[x20]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#24
    ble	main_413

main_163:
    movz	w21,	#24
    movz	fp,	#1732
    ldr	x3,	[sp, fp]

    str	w21,	[x3]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#25
    ble	main_413

main_165:
    movz	w21,	#25
    movz	fp,	#1724
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w21,	#26
    movz	fp,	#1068
    ldr	x17,	[sp, fp]

    str	w21,	[x17]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#27
    ble	main_413

main_169:
    movz	w21,	#27
    movz	fp,	#1548
    ldr	x23,	[sp, fp]

    str	w21,	[x23]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w21,	#28
    movz	fp,	#1708
    ldr	x24,	[sp, fp]

    str	w21,	[x24]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#29
    ble	main_413

main_173:
    movz	w21,	#29
    movz	fp,	#508
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w21,	#30
    movz	fp,	#500
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#31
    ble	main_413

main_177:
    movz	w21,	#31
    ldr	x0,	[sp, #648]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w21,	#32
    movz	fp,	#628
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#33
    ble	main_413

main_181:
    movz	w21,	#33
    movz	fp,	#636
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w21,	#34
    movz	fp,	#516
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#35
    ble	main_413

main_185:
    movz	w21,	#35
    movz	fp,	#524
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w21,	#36
    movz	fp,	#532
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#37
    ble	main_413

main_189:
    movz	w21,	#37
    movz	fp,	#452
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w21,	#38
    movz	fp,	#460
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#39
    ble	main_413

main_193:
    movz	w21,	#39
    movz	fp,	#468
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w21,	#40
    movz	fp,	#476
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#41
    ble	main_413

main_197:
    movz	w21,	#41
    movz	fp,	#484
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w21,	#42
    movz	fp,	#492
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#43
    ble	main_413

main_201:
    movz	w21,	#43
    movz	fp,	#540
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w21,	#44
    movz	fp,	#548
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#45
    ble	main_413

main_205:
    movz	w21,	#45
    movz	fp,	#556
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w21,	#46
    movz	fp,	#564
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#47
    ble	main_413

main_209:
    movz	w21,	#47
    movz	fp,	#572
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w21,	#48
    movz	fp,	#580
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#49
    ble	main_413

main_213:
    movz	w21,	#49
    movz	fp,	#588
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w21,	#50
    movz	fp,	#596
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#51
    ble	main_413

main_217:
    movz	w21,	#51
    movz	fp,	#604
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w21,	#52
    movz	fp,	#620
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#53
    ble	main_413

main_221:
    movz	w21,	#53
    movz	fp,	#668
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w21,	#54
    movz	fp,	#612
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#55
    ble	main_413

main_225:
    movz	w21,	#55
    ldr	x0,	[sp, #416]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#56
    ble	main_413

main_227:
    movz	w21,	#56
    ldr	x0,	[sp, #424]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#57
    ble	main_413

main_229:
    movz	w21,	#57
    movz	fp,	#676
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#58
    ble	main_413

main_231:
    movz	w21,	#58
    movz	fp,	#684
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#59
    ble	main_413

main_233:
    movz	w21,	#59
    movz	fp,	#692
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#60
    ble	main_413

main_235:
    movz	w21,	#60
    movz	fp,	#700
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#61
    ble	main_413

main_237:
    movz	w21,	#61
    movz	fp,	#708
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#62
    ble	main_413

main_239:
    movz	w21,	#62
    movz	fp,	#716
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#63
    ble	main_413

main_241:
    movz	w21,	#63
    movz	fp,	#724
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#64
    ble	main_413

main_243:
    movz	w21,	#64
    movz	fp,	#732
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#65
    ble	main_413

main_245:
    movz	w21,	#65
    movz	fp,	#740
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#66
    ble	main_413

main_247:
    movz	w21,	#66
    movz	fp,	#748
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#67
    ble	main_413

main_249:
    movz	w21,	#67
    movz	fp,	#756
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#68
    ble	main_413

main_251:
    movz	w21,	#68
    movz	fp,	#764
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#69
    ble	main_413

main_253:
    movz	w21,	#69
    movz	fp,	#772
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#70
    ble	main_413

main_255:
    movz	w21,	#70
    movz	fp,	#780
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#71
    ble	main_413

main_257:
    movz	w21,	#71
    movz	fp,	#788
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#72
    ble	main_413

main_259:
    movz	w21,	#72
    movz	fp,	#796
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#73
    ble	main_413

main_261:
    movz	w21,	#73
    movz	fp,	#804
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#74
    ble	main_413

main_263:
    movz	w21,	#74
    movz	fp,	#812
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#75
    ble	main_413

main_265:
    movz	w21,	#75
    movz	fp,	#820
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#76
    ble	main_413

main_267:
    movz	w21,	#76
    movz	fp,	#828
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#77
    ble	main_413

main_269:
    movz	w21,	#77
    movz	fp,	#836
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#78
    ble	main_413

main_271:
    movz	w21,	#78
    movz	fp,	#844
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#79
    ble	main_413

main_273:
    movz	w21,	#79
    movz	fp,	#852
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#80
    ble	main_413

main_275:
    movz	w21,	#80
    movz	fp,	#860
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#81
    ble	main_413

main_277:
    movz	w21,	#81
    movz	fp,	#868
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#82
    ble	main_413

main_279:
    movz	w21,	#82
    movz	fp,	#876
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#83
    ble	main_413

main_281:
    movz	w21,	#83
    movz	fp,	#884
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w21,	#84
    movz	fp,	#892
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#85
    ble	main_413

main_285:
    movz	w21,	#85
    movz	fp,	#900
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w21,	#86
    movz	fp,	#908
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#87
    ble	main_413

main_289:
    movz	w21,	#87
    movz	fp,	#916
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w21,	#88
    movz	fp,	#924
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#89
    ble	main_413

main_293:
    movz	w21,	#89
    movz	fp,	#932
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w21,	#90
    movz	fp,	#940
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#91
    ble	main_413

main_297:
    movz	w21,	#91
    movz	fp,	#948
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w21,	#92
    movz	fp,	#956
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#93
    ble	main_413

main_301:
    movz	w21,	#93
    movz	fp,	#964
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w21,	#94
    movz	fp,	#972
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#95
    ble	main_413

main_305:
    movz	w21,	#95
    movz	fp,	#980
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w21,	#96
    movz	fp,	#988
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#97
    ble	main_413

main_309:
    movz	w21,	#97
    movz	fp,	#996
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1032]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w21,	#98
    movz	fp,	#1004
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#99
    ble	main_413

main_313:
    movz	w21,	#99
    movz	fp,	#1012
    ldr	x0,	[sp, fp]

    str	w21,	[x0]


main_413:
    ldr	w21,	[sp, #1020]

    add	w21,	w21,	#1
    str	w21,	[sp, #644]

    ldr	w21,	[sp, #1024]

    str	w21,	[sp, #448]

    movz	w21,	#0
    str	w21,	[sp, #444]


main_415:
    ldr	w0,	[sp, #444]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w21,	[sp, #444]

    lsl	w21,	w21,	#2
    mov	x21,	x21
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    ldr	w0,	[x21]

    str	w0,	[sp, #3112]

    ldr	w0,	[sp, #448]

    ldr	w1,	[sp, #3112]

    add	w21,	w1,	w0
    ldr	w0,	[sp, #444]

    add	w0,	w0,	#1
    str	w0,	[sp, #440]

    str	w21,	[sp, #448]

    ldr	w21,	[sp, #440]

    str	w21,	[sp, #444]

    b	main_415

main_424:
    movz	w21,	#65535
    ldr	w0,	[sp, #448]

    sdiv	w21,	w0,	w21
    str	w21,	[sp, #656]

    ldr	w0,	[sp, #656]

    lsl	w21,	w0,	#16
    ldr	w0,	[sp, #656]

    sub	w21,	w21,	w0,	lsl #0
    ldr	w0,	[sp, #448]

    ldr	w25,	[sp, #644]

    sub	w0,	w0,	w21
    str	w25,	[sp, #3388]

    ldr	w7,	[sp, #1028]

    str	w7,	[sp, #1932]

    ldr	w11,	[sp, #1932]

    ldr	w26,	[sp, #3388]

    cmp	w26,	w11
    bge	main_429

main_112:
    str	w0,	[sp, #1024]

    ldr	w21,	[sp, #644]

    mov	w0,	w21
    str	w0,	[sp, #1020]

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


