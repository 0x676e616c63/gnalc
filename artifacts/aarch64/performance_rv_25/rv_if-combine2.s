.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #3184
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1132]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1136]

    mov	w0,	w26

main_4:
    cmp	w0,	#100
    bge	main_10

main_7:
    lsl	w9,	w0,	#2
    movz	w25,	#0
    add	w26,	w0,	#1
    mov	x1,	x9
    mov	w0,	w26
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    str	w25,	[x1]

    b	main_4

main_10:
    movz	w27,	#0
    ldr	w15,	[sp, #1132]

    cmp	w27,	w15
    bge	main_427

main_12:
    add	x4,	sp,	#20
    movz	fp,	#1604
    add	x9,	sp,	#24
    add	x22,	sp,	#28
    add	x5,	sp,	#32
    add	x0,	sp,	#36
    add	x28,	sp,	#40
    add	x6,	sp,	#44
    add	x7,	sp,	#48
    add	x1,	sp,	#52
    add	x13,	sp,	#56
    add	x20,	sp,	#60
    add	x11,	sp,	#64
    add	x23,	sp,	#68
    add	x26,	sp,	#72
    add	x27,	sp,	#76
    add	x18,	sp,	#80
    add	x16,	sp,	#84
    add	x10,	sp,	#88
    add	x8,	sp,	#92
    add	x15,	sp,	#96
    add	x17,	sp,	#100
    add	x14,	sp,	#104
    add	x25,	sp,	#108
    add	x19,	sp,	#112
    add	x21,	sp,	#116
    add	x24,	sp,	#120
    add	x3,	sp,	#124
    add	x2,	sp,	#128
    str	x4,	[sp, fp]

    movz	fp,	#1772
    str	x9,	[sp, fp]

    movz	fp,	#1652
    str	x22,	[sp, fp]

    movz	fp,	#1684
    str	x5,	[sp, fp]

    movz	fp,	#1748
    str	x0,	[sp, fp]

    add	x0,	sp,	#136
    movz	fp,	#1668
    str	x28,	[sp, fp]

    movz	fp,	#1764
    str	x6,	[sp, fp]

    add	x6,	sp,	#132
    movz	fp,	#1612
    str	x7,	[sp, fp]

    movz	fp,	#1556
    str	x1,	[sp, fp]

    movz	fp,	#1628
    str	x13,	[sp, fp]

    movz	fp,	#1724
    str	x20,	[sp, fp]

    movz	fp,	#1700
    str	x11,	[sp, fp]

    movz	fp,	#1732
    str	x23,	[sp, fp]

    movz	fp,	#1740
    str	x26,	[sp, fp]

    movz	fp,	#1548
    str	x27,	[sp, fp]

    movz	fp,	#1524
    str	x18,	[sp, fp]

    movz	fp,	#1636
    str	x16,	[sp, fp]

    movz	fp,	#1620
    str	x10,	[sp, fp]

    movz	fp,	#1692
    str	x8,	[sp, fp]

    movz	fp,	#1516
    str	x15,	[sp, fp]

    movz	fp,	#1716
    str	x17,	[sp, fp]

    movz	fp,	#1708
    str	x14,	[sp, fp]

    movz	fp,	#1660
    str	x25,	[sp, fp]

    movz	fp,	#1644
    str	x19,	[sp, fp]

    movz	fp,	#1532
    str	x21,	[sp, fp]

    movz	fp,	#1540
    str	x24,	[sp, fp]

    movz	fp,	#1756
    str	x3,	[sp, fp]

    movz	fp,	#1676
    str	x2,	[sp, fp]

    movz	fp,	#444
    str	x6,	[sp, #552]

    add	x6,	sp,	#140
    str	x0,	[sp, #544]

    add	x0,	sp,	#144
    str	x6,	[sp, fp]

    movz	fp,	#772
    add	x6,	sp,	#148
    str	x0,	[sp, #584]

    add	x0,	sp,	#152
    str	x6,	[sp, #592]

    movz	w6,	#0
    str	x0,	[sp, #600]

    add	x0,	sp,	#156
    str	x0,	[sp, #608]

    add	x0,	sp,	#160
    str	x0,	[sp, #616]

    add	x0,	sp,	#164
    str	x0,	[sp, #624]

    add	x0,	sp,	#168
    str	x0,	[sp, #632]

    add	x0,	sp,	#172
    str	x0,	[sp, #640]

    add	x0,	sp,	#176
    str	x0,	[sp, #648]

    add	x0,	sp,	#180
    str	x0,	[sp, #656]

    add	x0,	sp,	#184
    str	x0,	[sp, #664]

    add	x0,	sp,	#188
    str	x0,	[sp, #672]

    add	x0,	sp,	#192
    str	x0,	[sp, #680]

    add	x0,	sp,	#196
    str	x0,	[sp, #688]

    add	x0,	sp,	#200
    str	x0,	[sp, #696]

    add	x0,	sp,	#204
    str	x0,	[sp, #704]

    add	x0,	sp,	#208
    str	x0,	[sp, #712]

    add	x0,	sp,	#212
    str	x0,	[sp, #720]

    add	x0,	sp,	#216
    str	x0,	[sp, #728]

    add	x0,	sp,	#220
    str	x0,	[sp, #736]

    add	x0,	sp,	#224
    str	x0,	[sp, #752]

    add	x0,	sp,	#228
    str	x0,	[sp, fp]

    movz	fp,	#780
    add	x0,	sp,	#232
    str	x0,	[sp, #744]

    add	x0,	sp,	#236
    str	x0,	[sp, #416]

    add	x0,	sp,	#240
    str	x0,	[sp, #424]

    add	x0,	sp,	#244
    str	x0,	[sp, fp]

    movz	fp,	#788
    add	x0,	sp,	#248
    str	x0,	[sp, fp]

    movz	fp,	#796
    add	x0,	sp,	#252
    str	x0,	[sp, fp]

    movz	fp,	#804
    add	x0,	sp,	#256
    str	x0,	[sp, fp]

    movz	fp,	#812
    add	x0,	sp,	#260
    str	x0,	[sp, fp]

    movz	fp,	#820
    add	x0,	sp,	#264
    str	x0,	[sp, fp]

    movz	fp,	#828
    add	x0,	sp,	#268
    str	x0,	[sp, fp]

    movz	fp,	#836
    add	x0,	sp,	#272
    str	x0,	[sp, fp]

    movz	fp,	#844
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    movz	fp,	#852
    add	x0,	sp,	#280
    str	x0,	[sp, fp]

    movz	fp,	#860
    add	x0,	sp,	#284
    str	x0,	[sp, fp]

    movz	fp,	#868
    add	x0,	sp,	#288
    str	x0,	[sp, fp]

    movz	fp,	#876
    add	x0,	sp,	#292
    str	x0,	[sp, fp]

    movz	fp,	#884
    add	x0,	sp,	#296
    str	x0,	[sp, fp]

    movz	fp,	#892
    add	x0,	sp,	#300
    str	x0,	[sp, fp]

    movz	fp,	#900
    add	x0,	sp,	#304
    str	x0,	[sp, fp]

    movz	fp,	#908
    add	x0,	sp,	#308
    str	x0,	[sp, fp]

    movz	fp,	#916
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    movz	fp,	#924
    add	x0,	sp,	#316
    str	x0,	[sp, fp]

    movz	fp,	#932
    add	x0,	sp,	#320
    str	x0,	[sp, fp]

    movz	fp,	#940
    add	x0,	sp,	#324
    str	x0,	[sp, fp]

    movz	fp,	#948
    add	x0,	sp,	#328
    str	x0,	[sp, fp]

    movz	fp,	#956
    add	x0,	sp,	#332
    str	x0,	[sp, fp]

    movz	fp,	#964
    add	x0,	sp,	#336
    str	x0,	[sp, fp]

    movz	fp,	#972
    add	x0,	sp,	#340
    str	x0,	[sp, fp]

    movz	fp,	#980
    add	x0,	sp,	#344
    str	x0,	[sp, fp]

    movz	fp,	#988
    add	x0,	sp,	#348
    str	x0,	[sp, fp]

    movz	fp,	#996
    add	x0,	sp,	#352
    str	x0,	[sp, fp]

    movz	fp,	#1004
    add	x0,	sp,	#356
    str	x0,	[sp, fp]

    movz	fp,	#1012
    add	x0,	sp,	#360
    str	x0,	[sp, fp]

    movz	fp,	#1020
    add	x0,	sp,	#364
    str	x0,	[sp, fp]

    movz	fp,	#1028
    add	x0,	sp,	#368
    str	x0,	[sp, fp]

    movz	fp,	#1036
    add	x0,	sp,	#372
    str	x0,	[sp, fp]

    movz	fp,	#1044
    add	x0,	sp,	#376
    str	x0,	[sp, fp]

    movz	fp,	#1052
    add	x0,	sp,	#380
    str	x0,	[sp, fp]

    movz	fp,	#1060
    add	x0,	sp,	#384
    str	x0,	[sp, fp]

    movz	fp,	#1068
    add	x0,	sp,	#388
    str	x0,	[sp, fp]

    movz	fp,	#1076
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    movz	fp,	#1084
    add	x0,	sp,	#396
    str	x0,	[sp, fp]

    movz	fp,	#1092
    add	x0,	sp,	#400
    str	x0,	[sp, fp]

    movz	fp,	#1100
    add	x0,	sp,	#404
    str	x0,	[sp, fp]

    movz	fp,	#1108
    add	x0,	sp,	#408
    str	x0,	[sp, fp]

    movz	fp,	#1116
    add	x0,	sp,	#412
    str	x0,	[sp, fp]

    mov	w0,	w6
    movz	w6,	#0
    str	w0,	[sp, #1128]

    mov	w0,	w6
    str	w0,	[sp, #1124]


main_113:
    ldr	w6,	[sp, #1136]

    cmp	w6,	#1
    ble	main_413

main_117:
    movz	w6,	#1
    movz	fp,	#1604
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#2
    ble	main_413

main_119:
    movz	w6,	#2
    movz	fp,	#1772
    ldr	x5,	[sp, fp]

    str	w6,	[x5]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#3
    ble	main_413

main_121:
    movz	w6,	#3
    movz	fp,	#1652
    ldr	x18,	[sp, fp]

    str	w6,	[x18]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#4
    ble	main_413

main_123:
    movz	w6,	#4
    movz	fp,	#1684
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#5
    ble	main_413

main_125:
    movz	w6,	#5
    movz	fp,	#1748
    ldr	x27,	[sp, fp]

    str	w6,	[x27]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#6
    ble	main_413

main_127:
    movz	w6,	#6
    movz	fp,	#1668
    ldr	x25,	[sp, fp]

    str	w6,	[x25]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#7
    ble	main_413

main_129:
    movz	w6,	#7
    movz	fp,	#1764
    ldr	x2,	[sp, fp]

    str	w6,	[x2]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#8
    ble	main_413

main_131:
    movz	w6,	#8
    movz	fp,	#1612
    ldr	x1,	[sp, fp]

    str	w6,	[x1]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#9
    ble	main_413

main_133:
    movz	w6,	#9
    movz	fp,	#1556
    ldr	x26,	[sp, fp]

    str	w6,	[x26]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#10
    ble	main_413

main_135:
    movz	w6,	#10
    movz	fp,	#1628
    ldr	x8,	[sp, fp]

    str	w6,	[x8]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#11
    ble	main_413

main_137:
    movz	w6,	#11
    movz	fp,	#1724
    ldr	x17,	[sp, fp]

    str	w6,	[x17]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#12
    ble	main_413

main_139:
    movz	w6,	#12
    movz	fp,	#1700
    ldr	x7,	[sp, fp]

    str	w6,	[x7]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#13
    ble	main_413

main_141:
    movz	w6,	#13
    movz	fp,	#1732
    ldr	x20,	[sp, fp]

    str	w6,	[x20]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#14
    ble	main_413

main_143:
    movz	w6,	#14
    movz	fp,	#1740
    ldr	x23,	[sp, fp]

    str	w6,	[x23]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#15
    ble	main_413

main_145:
    movz	w6,	#15
    movz	fp,	#1548
    ldr	x22,	[sp, fp]

    str	w6,	[x22]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#16
    ble	main_413

main_147:
    movz	w6,	#16
    movz	fp,	#1524
    ldr	x12,	[sp, fp]

    str	w6,	[x12]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#17
    ble	main_413

main_149:
    movz	w6,	#17
    movz	fp,	#1636
    ldr	x11,	[sp, fp]

    str	w6,	[x11]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#18
    ble	main_413

main_151:
    movz	w6,	#18
    movz	fp,	#1620
    ldr	x4,	[sp, fp]

    str	w6,	[x4]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#19
    ble	main_413

main_153:
    movz	w6,	#19
    movz	fp,	#1692
    ldr	x3,	[sp, fp]

    str	w6,	[x3]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#20
    ble	main_413

main_155:
    movz	w6,	#20
    movz	fp,	#1516
    ldr	x9,	[sp, fp]

    str	w6,	[x9]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#21
    ble	main_413

main_157:
    movz	w6,	#21
    movz	fp,	#1716
    ldr	x13,	[sp, fp]

    str	w6,	[x13]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#22
    ble	main_413

main_159:
    movz	w6,	#22
    movz	fp,	#1708
    ldr	x10,	[sp, fp]

    str	w6,	[x10]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#23
    ble	main_413

main_161:
    movz	w6,	#23
    movz	fp,	#1660
    ldr	x21,	[sp, fp]

    str	w6,	[x21]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#24
    ble	main_413

main_163:
    movz	w6,	#24
    movz	fp,	#1644
    ldr	x14,	[sp, fp]

    str	w6,	[x14]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#25
    ble	main_413

main_165:
    movz	w6,	#25
    movz	fp,	#1532
    ldr	x15,	[sp, fp]

    str	w6,	[x15]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w6,	#26
    movz	fp,	#1540
    ldr	x19,	[sp, fp]

    str	w6,	[x19]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#27
    ble	main_413

main_169:
    movz	w6,	#27
    movz	fp,	#1756
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w6,	#28
    movz	fp,	#1676
    ldr	x28,	[sp, fp]

    str	w6,	[x28]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#29
    ble	main_413

main_173:
    movz	w6,	#29
    ldr	x0,	[sp, #552]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w6,	#30
    ldr	x0,	[sp, #544]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#31
    ble	main_413

main_177:
    movz	w6,	#31
    movz	fp,	#444
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w6,	#32
    ldr	x0,	[sp, #584]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#33
    ble	main_413

main_181:
    movz	w6,	#33
    ldr	x0,	[sp, #592]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w6,	#34
    ldr	x0,	[sp, #600]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#35
    ble	main_413

main_185:
    movz	w6,	#35
    ldr	x0,	[sp, #608]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w6,	#36
    ldr	x0,	[sp, #616]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#37
    ble	main_413

main_189:
    movz	w6,	#37
    ldr	x0,	[sp, #624]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w6,	#38
    ldr	x0,	[sp, #632]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#39
    ble	main_413

main_193:
    movz	w6,	#39
    ldr	x0,	[sp, #640]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w6,	#40
    ldr	x0,	[sp, #648]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#41
    ble	main_413

main_197:
    movz	w6,	#41
    ldr	x0,	[sp, #656]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w6,	#42
    ldr	x0,	[sp, #664]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#43
    ble	main_413

main_201:
    movz	w6,	#43
    ldr	x0,	[sp, #672]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w6,	#44
    ldr	x0,	[sp, #680]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#45
    ble	main_413

main_205:
    movz	w6,	#45
    ldr	x0,	[sp, #688]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w6,	#46
    ldr	x0,	[sp, #696]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#47
    ble	main_413

main_209:
    movz	w6,	#47
    ldr	x0,	[sp, #704]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w6,	#48
    ldr	x0,	[sp, #712]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#49
    ble	main_413

main_213:
    movz	w6,	#49
    ldr	x0,	[sp, #720]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w6,	#50
    ldr	x0,	[sp, #728]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#51
    ble	main_413

main_217:
    movz	w6,	#51
    ldr	x0,	[sp, #736]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w6,	#52
    ldr	x0,	[sp, #752]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#53
    ble	main_413

main_221:
    movz	w6,	#53
    movz	fp,	#772
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w6,	#54
    ldr	x0,	[sp, #744]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#55
    ble	main_413

main_225:
    movz	w6,	#55
    ldr	x0,	[sp, #416]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#56
    ble	main_413

main_227:
    movz	w6,	#56
    ldr	x0,	[sp, #424]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#57
    ble	main_413

main_229:
    movz	w6,	#57
    movz	fp,	#780
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#58
    ble	main_413

main_231:
    movz	w6,	#58
    movz	fp,	#788
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#59
    ble	main_413

main_233:
    movz	w6,	#59
    movz	fp,	#796
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#60
    ble	main_413

main_235:
    movz	w6,	#60
    movz	fp,	#804
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#61
    ble	main_413

main_237:
    movz	w6,	#61
    movz	fp,	#812
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#62
    ble	main_413

main_239:
    movz	w6,	#62
    movz	fp,	#820
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#63
    ble	main_413

main_241:
    movz	w6,	#63
    movz	fp,	#828
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#64
    ble	main_413

main_243:
    movz	w6,	#64
    movz	fp,	#836
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#65
    ble	main_413

main_245:
    movz	w6,	#65
    movz	fp,	#844
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#66
    ble	main_413

main_247:
    movz	w6,	#66
    movz	fp,	#852
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#67
    ble	main_413

main_249:
    movz	w6,	#67
    movz	fp,	#860
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#68
    ble	main_413

main_251:
    movz	w6,	#68
    movz	fp,	#868
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#69
    ble	main_413

main_253:
    movz	w6,	#69
    movz	fp,	#876
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#70
    ble	main_413

main_255:
    movz	w6,	#70
    movz	fp,	#884
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#71
    ble	main_413

main_257:
    movz	w6,	#71
    movz	fp,	#892
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#72
    ble	main_413

main_259:
    movz	w6,	#72
    movz	fp,	#900
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#73
    ble	main_413

main_261:
    movz	w6,	#73
    movz	fp,	#908
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#74
    ble	main_413

main_263:
    movz	w6,	#74
    movz	fp,	#916
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#75
    ble	main_413

main_265:
    movz	w6,	#75
    movz	fp,	#924
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#76
    ble	main_413

main_267:
    movz	w6,	#76
    movz	fp,	#932
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#77
    ble	main_413

main_269:
    movz	w6,	#77
    movz	fp,	#940
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#78
    ble	main_413

main_271:
    movz	w6,	#78
    movz	fp,	#948
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#79
    ble	main_413

main_273:
    movz	w6,	#79
    movz	fp,	#956
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#80
    ble	main_413

main_275:
    movz	w6,	#80
    movz	fp,	#964
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#81
    ble	main_413

main_277:
    movz	w6,	#81
    movz	fp,	#972
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#82
    ble	main_413

main_279:
    movz	w6,	#82
    movz	fp,	#980
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#83
    ble	main_413

main_281:
    movz	w6,	#83
    movz	fp,	#988
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w6,	#84
    movz	fp,	#996
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#85
    ble	main_413

main_285:
    movz	w6,	#85
    movz	fp,	#1004
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w6,	#86
    movz	fp,	#1012
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#87
    ble	main_413

main_289:
    movz	w6,	#87
    movz	fp,	#1020
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w6,	#88
    movz	fp,	#1028
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#89
    ble	main_413

main_293:
    movz	w6,	#89
    movz	fp,	#1036
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w6,	#90
    movz	fp,	#1044
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#91
    ble	main_413

main_297:
    movz	w6,	#91
    movz	fp,	#1052
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w6,	#92
    movz	fp,	#1060
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#93
    ble	main_413

main_301:
    movz	w6,	#93
    movz	fp,	#1068
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w6,	#94
    movz	fp,	#1076
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#95
    ble	main_413

main_305:
    movz	w6,	#95
    movz	fp,	#1084
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w6,	#96
    movz	fp,	#1092
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#97
    ble	main_413

main_309:
    movz	w6,	#97
    movz	fp,	#1100
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w0,	[sp, #1136]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w6,	#98
    movz	fp,	#1108
    ldr	x0,	[sp, fp]

    str	w6,	[x0]

    ldr	w6,	[sp, #1136]

    cmp	w6,	#99
    ble	main_413

main_313:
    movz	w6,	#99
    movz	fp,	#1116
    ldr	x0,	[sp, fp]

    str	w6,	[x0]


main_413:
    ldr	w6,	[sp, #1124]

    add	w0,	w6,	#1
    str	w0,	[sp, #540]

    ldr	w6,	[sp, #1128]

    str	w6,	[sp, #760]

    movz	w6,	#0
    str	w6,	[sp, #452]


main_415:
    ldr	w0,	[sp, #452]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w0,	[sp, #452]

    lsl	w6,	w0,	#2
    mov	x6,	x6
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w7,	[x6]

    str	w7,	[sp, #2928]

    ldr	w0,	[sp, #760]

    ldr	w8,	[sp, #2928]

    add	w3,	w8,	w0
    str	w3,	[sp, #2296]

    ldr	w0,	[sp, #452]

    add	w0,	w0,	#1
    str	w0,	[sp, #440]

    ldr	w4,	[sp, #2296]

    mov	w6,	w4
    str	w6,	[sp, #760]

    ldr	w6,	[sp, #440]

    str	w6,	[sp, #452]

    b	main_415

main_424:
    movz	w6,	#65535
    ldr	w0,	[sp, #760]

    sdiv	w0,	w0,	w6
    str	w0,	[sp, #456]

    ldr	w0,	[sp, #456]

    lsl	w0,	w0,	#16
    str	w0,	[sp, #3084]

    ldr	w0,	[sp, #456]

    ldr	w1,	[sp, #3084]

    sub	w6,	w1,	w0,	lsl #0
    ldr	w0,	[sp, #760]

    ldr	w3,	[sp, #540]

    sub	w0,	w0,	w6
    str	w3,	[sp, #2908]

    ldr	w7,	[sp, #1132]

    str	w7,	[sp, #2152]

    ldr	w13,	[sp, #2152]

    ldr	w4,	[sp, #2908]

    cmp	w4,	w13
    bge	main_429

main_112:
    str	w0,	[sp, #1128]

    ldr	w6,	[sp, #540]

    mov	w0,	w6
    str	w0,	[sp, #1124]

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
    
    add	sp, sp, #3184
    ret


