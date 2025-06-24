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
    str	w0,	[sp, #1076]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1080]

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
    ldr	w15,	[sp, #1076]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x0,	sp,	#20
    movz	fp,	#1668
    add	x26,	sp,	#24
    add	x5,	sp,	#28
    add	x22,	sp,	#32
    add	x7,	sp,	#36
    add	x19,	sp,	#40
    add	x9,	sp,	#44
    add	x11,	sp,	#48
    add	x1,	sp,	#52
    add	x27,	sp,	#56
    add	x24,	sp,	#60
    add	x16,	sp,	#64
    add	x20,	sp,	#68
    add	x23,	sp,	#72
    add	x3,	sp,	#76
    add	x6,	sp,	#80
    add	x8,	sp,	#84
    add	x14,	sp,	#88
    add	x25,	sp,	#92
    add	x18,	sp,	#96
    add	x10,	sp,	#100
    add	x13,	sp,	#104
    add	x15,	sp,	#108
    add	x28,	sp,	#112
    add	x2,	sp,	#116
    add	x17,	sp,	#120
    add	x4,	sp,	#124
    add	x21,	sp,	#128
    str	x0,	[sp, fp]

    movz	fp,	#1660
    str	x26,	[sp, fp]

    movz	fp,	#1604
    str	x5,	[sp, fp]

    movz	fp,	#700
    str	x22,	[sp, fp]

    movz	fp,	#1116
    str	x7,	[sp, fp]

    movz	fp,	#692
    str	x19,	[sp, fp]

    movz	fp,	#1692
    str	x9,	[sp, fp]

    movz	fp,	#1620
    str	x11,	[sp, fp]

    movz	fp,	#1100
    str	x1,	[sp, fp]

    movz	fp,	#1092
    str	x27,	[sp, fp]

    movz	fp,	#1084
    str	x24,	[sp, fp]

    movz	fp,	#684
    str	x16,	[sp, fp]

    movz	fp,	#1644
    str	x20,	[sp, fp]

    movz	fp,	#1652
    str	x23,	[sp, fp]

    movz	fp,	#1676
    str	x3,	[sp, fp]

    movz	fp,	#1684
    str	x6,	[sp, fp]

    movz	fp,	#1612
    str	x8,	[sp, fp]

    movz	fp,	#1628
    str	x14,	[sp, fp]

    movz	fp,	#708
    str	x25,	[sp, fp]

    movz	fp,	#1300
    str	x18,	[sp, fp]

    movz	fp,	#668
    str	x10,	[sp, fp]

    movz	fp,	#676
    str	x13,	[sp, fp]

    movz	fp,	#1292
    str	x15,	[sp, fp]

    movz	fp,	#1588
    str	x28,	[sp, fp]

    movz	fp,	#1596
    str	x2,	[sp, fp]

    movz	fp,	#1636
    str	x17,	[sp, fp]

    movz	fp,	#1108
    str	x4,	[sp, fp]

    add	x4,	sp,	#132
    movz	fp,	#1308
    str	x21,	[sp, fp]

    movz	fp,	#716
    str	x4,	[sp, #488]

    add	x4,	sp,	#136
    str	x4,	[sp, fp]

    movz	fp,	#476
    add	x4,	sp,	#140
    str	x4,	[sp, fp]

    movz	fp,	#500
    add	x4,	sp,	#144
    str	x4,	[sp, #464]

    add	x4,	sp,	#148
    str	x4,	[sp, fp]

    movz	fp,	#508
    add	x4,	sp,	#152
    str	x4,	[sp, fp]

    movz	fp,	#516
    add	x4,	sp,	#156
    str	x4,	[sp, fp]

    movz	fp,	#524
    add	x4,	sp,	#160
    str	x4,	[sp, fp]

    movz	fp,	#532
    add	x4,	sp,	#164
    str	x4,	[sp, fp]

    movz	fp,	#540
    add	x4,	sp,	#168
    str	x4,	[sp, fp]

    movz	fp,	#548
    add	x4,	sp,	#172
    str	x4,	[sp, fp]

    movz	fp,	#556
    add	x4,	sp,	#176
    str	x4,	[sp, fp]

    movz	fp,	#564
    add	x4,	sp,	#180
    str	x4,	[sp, fp]

    movz	fp,	#572
    add	x4,	sp,	#184
    str	x4,	[sp, fp]

    movz	fp,	#580
    add	x4,	sp,	#188
    str	x4,	[sp, fp]

    movz	fp,	#588
    add	x4,	sp,	#192
    str	x4,	[sp, fp]

    movz	fp,	#596
    add	x4,	sp,	#196
    str	x4,	[sp, fp]

    movz	fp,	#604
    add	x4,	sp,	#200
    str	x4,	[sp, fp]

    movz	fp,	#612
    add	x4,	sp,	#204
    str	x4,	[sp, fp]

    movz	fp,	#620
    add	x4,	sp,	#208
    str	x4,	[sp, fp]

    movz	fp,	#628
    add	x4,	sp,	#212
    str	x4,	[sp, fp]

    movz	fp,	#644
    add	x4,	sp,	#216
    str	x4,	[sp, fp]

    movz	fp,	#652
    add	x4,	sp,	#220
    str	x4,	[sp, fp]

    movz	fp,	#660
    add	x4,	sp,	#224
    str	x4,	[sp, fp]

    movz	fp,	#724
    add	x4,	sp,	#228
    str	x4,	[sp, fp]

    movz	fp,	#636
    add	x4,	sp,	#232
    str	x4,	[sp, #416]

    add	x4,	sp,	#236
    str	x4,	[sp, #424]

    add	x4,	sp,	#240
    str	x4,	[sp, #432]

    add	x4,	sp,	#244
    str	x4,	[sp, fp]

    movz	fp,	#732
    add	x4,	sp,	#248
    str	x4,	[sp, fp]

    movz	fp,	#740
    add	x4,	sp,	#252
    str	x4,	[sp, fp]

    movz	fp,	#748
    add	x4,	sp,	#256
    str	x4,	[sp, fp]

    movz	fp,	#756
    add	x4,	sp,	#260
    str	x4,	[sp, fp]

    movz	fp,	#764
    add	x4,	sp,	#264
    str	x4,	[sp, fp]

    movz	fp,	#772
    add	x4,	sp,	#268
    str	x4,	[sp, fp]

    movz	fp,	#780
    add	x4,	sp,	#272
    str	x4,	[sp, fp]

    movz	fp,	#788
    add	x4,	sp,	#276
    str	x4,	[sp, fp]

    movz	fp,	#796
    add	x4,	sp,	#280
    str	x4,	[sp, fp]

    movz	fp,	#804
    add	x4,	sp,	#284
    str	x4,	[sp, fp]

    movz	fp,	#812
    add	x4,	sp,	#288
    str	x4,	[sp, fp]

    movz	fp,	#820
    add	x4,	sp,	#292
    str	x4,	[sp, fp]

    movz	fp,	#828
    add	x4,	sp,	#296
    str	x4,	[sp, fp]

    movz	fp,	#836
    add	x4,	sp,	#300
    str	x4,	[sp, fp]

    movz	fp,	#844
    add	x4,	sp,	#304
    str	x4,	[sp, fp]

    movz	fp,	#852
    add	x4,	sp,	#308
    str	x4,	[sp, fp]

    movz	fp,	#860
    add	x4,	sp,	#312
    str	x4,	[sp, fp]

    movz	fp,	#868
    add	x4,	sp,	#316
    str	x4,	[sp, fp]

    movz	fp,	#876
    add	x4,	sp,	#320
    str	x4,	[sp, fp]

    movz	fp,	#884
    add	x4,	sp,	#324
    str	x4,	[sp, fp]

    movz	fp,	#892
    add	x4,	sp,	#328
    str	x4,	[sp, fp]

    movz	fp,	#900
    add	x4,	sp,	#332
    str	x4,	[sp, fp]

    movz	fp,	#908
    add	x4,	sp,	#336
    str	x4,	[sp, fp]

    movz	fp,	#916
    add	x4,	sp,	#340
    str	x4,	[sp, fp]

    movz	fp,	#924
    add	x4,	sp,	#344
    str	x4,	[sp, fp]

    movz	fp,	#932
    add	x4,	sp,	#348
    str	x4,	[sp, fp]

    movz	fp,	#940
    add	x4,	sp,	#352
    str	x4,	[sp, fp]

    movz	fp,	#948
    add	x4,	sp,	#356
    str	x4,	[sp, fp]

    movz	fp,	#956
    add	x4,	sp,	#360
    str	x4,	[sp, fp]

    movz	fp,	#964
    add	x4,	sp,	#364
    str	x4,	[sp, fp]

    movz	fp,	#972
    add	x4,	sp,	#368
    str	x4,	[sp, fp]

    movz	fp,	#980
    add	x4,	sp,	#372
    str	x4,	[sp, fp]

    movz	fp,	#988
    add	x4,	sp,	#376
    str	x4,	[sp, fp]

    movz	fp,	#996
    add	x4,	sp,	#380
    str	x4,	[sp, fp]

    movz	fp,	#1004
    add	x4,	sp,	#384
    str	x4,	[sp, fp]

    movz	fp,	#1012
    add	x4,	sp,	#388
    str	x4,	[sp, fp]

    movz	fp,	#1020
    add	x4,	sp,	#392
    str	x4,	[sp, fp]

    movz	fp,	#1028
    add	x4,	sp,	#396
    str	x4,	[sp, fp]

    movz	fp,	#1036
    add	x4,	sp,	#400
    str	x4,	[sp, fp]

    movz	fp,	#1044
    add	x4,	sp,	#404
    str	x4,	[sp, fp]

    movz	fp,	#1052
    add	x4,	sp,	#408
    str	x4,	[sp, fp]

    movz	fp,	#1060
    add	x4,	sp,	#412
    str	x4,	[sp, fp]

    movz	w4,	#0
    str	w4,	[sp, #1072]

    movz	w4,	#0
    str	w4,	[sp, #1068]


main_113:
    ldr	w4,	[sp, #1080]

    cmp	w4,	#1
    ble	main_413

main_117:
    movz	w4,	#1
    movz	fp,	#1668
    ldr	x26,	[sp, fp]

    str	w4,	[x26]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#2
    ble	main_413

main_119:
    movz	w4,	#2
    movz	fp,	#1660
    ldr	x23,	[sp, fp]

    str	w4,	[x23]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#3
    ble	main_413

main_121:
    movz	w4,	#3
    movz	fp,	#1604
    ldr	x0,	[sp, fp]

    str	w4,	[x0]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#4
    ble	main_413

main_123:
    movz	w4,	#4
    movz	fp,	#700
    ldr	x18,	[sp, fp]

    str	w4,	[x18]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#5
    ble	main_413

main_125:
    movz	w4,	#5
    movz	fp,	#1116
    ldr	x1,	[sp, fp]

    str	w4,	[x1]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#6
    ble	main_413

main_127:
    movz	w4,	#6
    movz	fp,	#692
    ldr	x15,	[sp, fp]

    str	w4,	[x15]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#7
    ble	main_413

main_129:
    movz	w4,	#7
    movz	fp,	#1692
    ldr	x7,	[sp, fp]

    str	w4,	[x7]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#8
    ble	main_413

main_131:
    movz	w4,	#8
    movz	fp,	#1620
    ldr	x8,	[sp, fp]

    str	w4,	[x8]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#9
    ble	main_413

main_133:
    movz	w4,	#9
    movz	fp,	#1100
    ldr	x25,	[sp, fp]

    str	w4,	[x25]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#10
    ble	main_413

main_135:
    movz	w4,	#10
    movz	fp,	#1092
    ldr	x22,	[sp, fp]

    str	w4,	[x22]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#11
    ble	main_413

main_137:
    movz	w4,	#11
    movz	fp,	#1084
    ldr	x19,	[sp, fp]

    str	w4,	[x19]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#12
    ble	main_413

main_139:
    movz	w4,	#12
    movz	fp,	#684
    ldr	x12,	[sp, fp]

    str	w4,	[x12]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#13
    ble	main_413

main_141:
    movz	w4,	#13
    movz	fp,	#1644
    ldr	x17,	[sp, fp]

    str	w4,	[x17]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#14
    ble	main_413

main_143:
    movz	w4,	#14
    movz	fp,	#1652
    ldr	x20,	[sp, fp]

    str	w4,	[x20]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#15
    ble	main_413

main_145:
    movz	w4,	#15
    movz	fp,	#1676
    ldr	x0,	[sp, fp]

    str	w4,	[x0]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#16
    ble	main_413

main_147:
    movz	w4,	#16
    movz	fp,	#1684
    ldr	x2,	[sp, fp]

    str	w4,	[x2]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#17
    ble	main_413

main_149:
    movz	w4,	#17
    movz	fp,	#1612
    ldr	x3,	[sp, fp]

    str	w4,	[x3]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#18
    ble	main_413

main_151:
    movz	w4,	#18
    movz	fp,	#1628
    ldr	x11,	[sp, fp]

    str	w4,	[x11]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#19
    ble	main_413

main_153:
    movz	w4,	#19
    movz	fp,	#708
    ldr	x21,	[sp, fp]

    str	w4,	[x21]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#20
    ble	main_413

main_155:
    movz	w4,	#20
    movz	fp,	#1300
    ldr	x13,	[sp, fp]

    str	w4,	[x13]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#21
    ble	main_413

main_157:
    movz	w4,	#21
    movz	fp,	#668
    ldr	x6,	[sp, fp]

    str	w4,	[x6]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#22
    ble	main_413

main_159:
    movz	w4,	#22
    movz	fp,	#676
    ldr	x9,	[sp, fp]

    str	w4,	[x9]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#23
    ble	main_413

main_161:
    movz	w4,	#23
    movz	fp,	#1292
    ldr	x10,	[sp, fp]

    str	w4,	[x10]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#24
    ble	main_413

main_163:
    movz	w4,	#24
    movz	fp,	#1588
    ldr	x24,	[sp, fp]

    str	w4,	[x24]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#25
    ble	main_413

main_165:
    movz	w4,	#25
    movz	fp,	#1596
    ldr	x27,	[sp, fp]

    str	w4,	[x27]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#26
    ble	main_413

main_167:
    movz	w4,	#26
    movz	fp,	#1636
    ldr	x14,	[sp, fp]

    str	w4,	[x14]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#27
    ble	main_413

main_169:
    movz	w4,	#27
    movz	fp,	#1108
    ldr	x28,	[sp, fp]

    str	w4,	[x28]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#28
    ble	main_413

main_171:
    movz	w4,	#28
    movz	fp,	#1308
    ldr	x16,	[sp, fp]

    str	w4,	[x16]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#29
    ble	main_413

main_173:
    movz	w4,	#29
    ldr	x21,	[sp, #488]

    str	x21,	[sp, #3120]

    ldr	x22,	[sp, #3120]

    str	w4,	[x22]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#30
    ble	main_413

main_175:
    movz	w4,	#30
    movz	fp,	#716
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3128]

    ldr	x25,	[sp, #3128]

    str	w4,	[x25]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#31
    ble	main_413

main_177:
    movz	w4,	#31
    movz	fp,	#476
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3136]

    ldr	x28,	[sp, #3136]

    str	w4,	[x28]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#32
    ble	main_413

main_179:
    movz	w4,	#32
    ldr	x1,	[sp, #464]

    mov	w6,	w4
    str	x1,	[sp, #3144]

    ldr	x2,	[sp, #3144]

    str	w6,	[x2]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#33
    ble	main_413

main_181:
    movz	w4,	#33
    movz	fp,	#500
    mov	w6,	w4
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3152]

    ldr	x5,	[sp, #3152]

    str	w6,	[x5]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#34
    ble	main_413

main_183:
    movz	w4,	#34
    movz	fp,	#508
    mov	w6,	w4
    ldr	x4,	[sp, fp]

    movz	fp,	#1884
    str	x4,	[sp, fp]

    movz	fp,	#1884
    ldr	x5,	[sp, fp]

    str	w6,	[x5]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#35
    ble	main_413

main_185:
    movz	w4,	#35
    movz	fp,	#516
    mov	w6,	w4
    ldr	x1,	[sp, fp]

    movz	fp,	#1876
    str	x1,	[sp, fp]

    movz	fp,	#1876
    ldr	x2,	[sp, fp]

    str	w6,	[x2]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#36
    ble	main_413

main_187:
    movz	w4,	#36
    movz	fp,	#524
    ldr	x27,	[sp, fp]

    movz	fp,	#1868
    str	x27,	[sp, fp]

    movz	fp,	#1868
    ldr	x28,	[sp, fp]

    str	w4,	[x28]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#37
    ble	main_413

main_189:
    movz	w4,	#37
    movz	fp,	#532
    ldr	x24,	[sp, fp]

    movz	fp,	#1860
    str	x24,	[sp, fp]

    movz	fp,	#1860
    ldr	x25,	[sp, fp]

    str	w4,	[x25]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#38
    ble	main_413

main_191:
    movz	w4,	#38
    movz	fp,	#540
    ldr	x21,	[sp, fp]

    movz	fp,	#1852
    str	x21,	[sp, fp]

    movz	fp,	#1852
    ldr	x22,	[sp, fp]

    str	w4,	[x22]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#39
    ble	main_413

main_193:
    movz	w4,	#39
    movz	fp,	#548
    ldr	x18,	[sp, fp]

    movz	fp,	#1844
    str	x18,	[sp, fp]

    movz	fp,	#1844
    ldr	x19,	[sp, fp]

    str	w4,	[x19]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#40
    ble	main_413

main_195:
    movz	w4,	#40
    movz	fp,	#556
    ldr	x15,	[sp, fp]

    movz	fp,	#1836
    str	x15,	[sp, fp]

    movz	fp,	#1836
    ldr	x16,	[sp, fp]

    str	w4,	[x16]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#41
    ble	main_413

main_197:
    movz	w4,	#41
    movz	fp,	#564
    ldr	x12,	[sp, fp]

    movz	fp,	#1828
    str	x12,	[sp, fp]

    movz	fp,	#1828
    ldr	x13,	[sp, fp]

    str	w4,	[x13]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#42
    ble	main_413

main_199:
    movz	w4,	#42
    movz	fp,	#572
    ldr	x9,	[sp, fp]

    movz	fp,	#1820
    str	x9,	[sp, fp]

    movz	fp,	#1820
    ldr	x10,	[sp, fp]

    str	w4,	[x10]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#43
    ble	main_413

main_201:
    movz	w4,	#43
    movz	fp,	#580
    ldr	x6,	[sp, fp]

    movz	fp,	#1812
    str	x6,	[sp, fp]

    movz	fp,	#1812
    ldr	x7,	[sp, fp]

    str	w4,	[x7]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#44
    ble	main_413

main_203:
    movz	w4,	#44
    movz	fp,	#588
    mov	w6,	w4
    ldr	x3,	[sp, fp]

    movz	fp,	#1804
    str	x3,	[sp, fp]

    movz	fp,	#1804
    ldr	x4,	[sp, fp]

    str	w6,	[x4]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#45
    ble	main_413

main_205:
    movz	w4,	#45
    movz	fp,	#596
    mov	w6,	w4
    ldr	x0,	[sp, fp]

    movz	fp,	#1796
    str	x0,	[sp, fp]

    movz	fp,	#1796
    ldr	x1,	[sp, fp]

    str	w6,	[x1]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#46
    ble	main_413

main_207:
    movz	w4,	#46
    movz	fp,	#604
    ldr	x26,	[sp, fp]

    movz	fp,	#1788
    str	x26,	[sp, fp]

    movz	fp,	#1788
    ldr	x27,	[sp, fp]

    str	w4,	[x27]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#47
    ble	main_413

main_209:
    movz	w4,	#47
    movz	fp,	#612
    ldr	x23,	[sp, fp]

    movz	fp,	#1780
    str	x23,	[sp, fp]

    movz	fp,	#1780
    ldr	x24,	[sp, fp]

    str	w4,	[x24]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#48
    ble	main_413

main_211:
    movz	w4,	#48
    movz	fp,	#620
    ldr	x20,	[sp, fp]

    movz	fp,	#1772
    str	x20,	[sp, fp]

    movz	fp,	#1772
    ldr	x21,	[sp, fp]

    str	w4,	[x21]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#49
    ble	main_413

main_213:
    movz	w4,	#49
    movz	fp,	#628
    ldr	x17,	[sp, fp]

    movz	fp,	#1764
    str	x17,	[sp, fp]

    movz	fp,	#1764
    ldr	x18,	[sp, fp]

    str	w4,	[x18]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#50
    ble	main_413

main_215:
    movz	w4,	#50
    movz	fp,	#644
    ldr	x14,	[sp, fp]

    movz	fp,	#1756
    str	x14,	[sp, fp]

    movz	fp,	#1756
    ldr	x15,	[sp, fp]

    str	w4,	[x15]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#51
    ble	main_413

main_217:
    movz	w4,	#51
    movz	fp,	#652
    ldr	x11,	[sp, fp]

    movz	fp,	#1748
    str	x11,	[sp, fp]

    movz	fp,	#1748
    ldr	x12,	[sp, fp]

    str	w4,	[x12]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#52
    ble	main_413

main_219:
    movz	w4,	#52
    movz	fp,	#660
    ldr	x8,	[sp, fp]

    movz	fp,	#1740
    str	x8,	[sp, fp]

    movz	fp,	#1740
    ldr	x9,	[sp, fp]

    str	w4,	[x9]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#53
    ble	main_413

main_221:
    movz	w4,	#53
    movz	fp,	#724
    ldr	x5,	[sp, fp]

    movz	fp,	#1732
    str	x5,	[sp, fp]

    movz	fp,	#1732
    ldr	x6,	[sp, fp]

    str	w4,	[x6]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#54
    ble	main_413

main_223:
    movz	w4,	#54
    ldr	x2,	[sp, #416]

    movz	fp,	#1724
    mov	w6,	w4
    str	x2,	[sp, fp]

    movz	fp,	#1724
    ldr	x3,	[sp, fp]

    str	w6,	[x3]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#55
    ble	main_413

main_225:
    movz	w4,	#55
    ldr	x28,	[sp, #424]

    movz	fp,	#1716
    mov	w5,	w4
    str	x28,	[sp, fp]

    movz	fp,	#1716
    ldr	x0,	[sp, fp]

    str	w5,	[x0]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#56
    ble	main_413

main_227:
    movz	w4,	#56
    ldr	x25,	[sp, #432]

    movz	fp,	#1708
    str	x25,	[sp, fp]

    movz	fp,	#1708
    ldr	x26,	[sp, fp]

    str	w4,	[x26]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#57
    ble	main_413

main_229:
    movz	w4,	#57
    movz	fp,	#636
    ldr	x22,	[sp, fp]

    movz	fp,	#1700
    str	x22,	[sp, fp]

    movz	fp,	#1700
    ldr	x23,	[sp, fp]

    str	w4,	[x23]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#58
    ble	main_413

main_231:
    movz	w4,	#58
    movz	fp,	#732
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3280]

    ldr	x20,	[sp, #3280]

    str	w4,	[x20]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#59
    ble	main_413

main_233:
    movz	w4,	#59
    movz	fp,	#740
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3272]

    ldr	x17,	[sp, #3272]

    str	w4,	[x17]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#60
    ble	main_413

main_235:
    movz	w4,	#60
    movz	fp,	#748
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3264]

    ldr	x14,	[sp, #3264]

    str	w4,	[x14]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#61
    ble	main_413

main_237:
    movz	w4,	#61
    movz	fp,	#756
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #3256]

    ldr	x11,	[sp, #3256]

    str	w4,	[x11]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#62
    ble	main_413

main_239:
    movz	w4,	#62
    movz	fp,	#764
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #3248]

    ldr	x8,	[sp, #3248]

    str	w4,	[x8]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#63
    ble	main_413

main_241:
    movz	w4,	#63
    movz	fp,	#772
    mov	w6,	w4
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3240]

    ldr	x5,	[sp, #3240]

    str	w6,	[x5]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#64
    ble	main_413

main_243:
    movz	w4,	#64
    movz	fp,	#780
    mov	w6,	w4
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3232]

    ldr	x2,	[sp, #3232]

    str	w6,	[x2]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#65
    ble	main_413

main_245:
    movz	w4,	#65
    movz	fp,	#788
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3224]

    ldr	x28,	[sp, #3224]

    str	w4,	[x28]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#66
    ble	main_413

main_247:
    movz	w4,	#66
    movz	fp,	#796
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3216]

    ldr	x25,	[sp, #3216]

    str	w4,	[x25]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#67
    ble	main_413

main_249:
    movz	w4,	#67
    movz	fp,	#804
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3208]

    ldr	x22,	[sp, #3208]

    str	w4,	[x22]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#68
    ble	main_413

main_251:
    movz	w4,	#68
    movz	fp,	#812
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #3200]

    ldr	x19,	[sp, #3200]

    str	w4,	[x19]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#69
    ble	main_413

main_253:
    movz	w4,	#69
    movz	fp,	#820
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #3192]

    ldr	x16,	[sp, #3192]

    str	w4,	[x16]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#70
    ble	main_413

main_255:
    movz	w4,	#70
    movz	fp,	#828
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #3184]

    ldr	x13,	[sp, #3184]

    str	w4,	[x13]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#71
    ble	main_413

main_257:
    movz	w4,	#71
    movz	fp,	#836
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #3176]

    ldr	x10,	[sp, #3176]

    str	w4,	[x10]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#72
    ble	main_413

main_259:
    movz	w4,	#72
    movz	fp,	#844
    ldr	x6,	[sp, fp]

    str	x6,	[sp, #3168]

    ldr	x7,	[sp, #3168]

    str	w4,	[x7]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#73
    ble	main_413

main_261:
    movz	w4,	#73
    movz	fp,	#852
    mov	w6,	w4
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #3160]

    ldr	x4,	[sp, #3160]

    str	w6,	[x4]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#74
    ble	main_413

main_263:
    movz	w4,	#74
    movz	fp,	#860
    mov	w6,	w4
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #2512]

    ldr	x1,	[sp, #2512]

    str	w6,	[x1]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#75
    ble	main_413

main_265:
    movz	w4,	#75
    movz	fp,	#868
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #2504]

    ldr	x27,	[sp, #2504]

    str	w4,	[x27]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#76
    ble	main_413

main_267:
    movz	w4,	#76
    movz	fp,	#876
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #2496]

    ldr	x24,	[sp, #2496]

    str	w4,	[x24]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#77
    ble	main_413

main_269:
    movz	w4,	#77
    movz	fp,	#884
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #2488]

    ldr	x21,	[sp, #2488]

    str	w4,	[x21]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#78
    ble	main_413

main_271:
    movz	w4,	#78
    movz	fp,	#892
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #2480]

    ldr	x18,	[sp, #2480]

    str	w4,	[x18]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#79
    ble	main_413

main_273:
    movz	w4,	#79
    movz	fp,	#900
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #2472]

    ldr	x15,	[sp, #2472]

    str	w4,	[x15]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#80
    ble	main_413

main_275:
    movz	w4,	#80
    movz	fp,	#908
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #2464]

    ldr	x12,	[sp, #2464]

    str	w4,	[x12]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#81
    ble	main_413

main_277:
    movz	w4,	#81
    movz	fp,	#916
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #2456]

    ldr	x9,	[sp, #2456]

    str	w4,	[x9]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#82
    ble	main_413

main_279:
    movz	w4,	#82
    movz	fp,	#924
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #2448]

    ldr	x6,	[sp, #2448]

    str	w4,	[x6]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#83
    ble	main_413

main_281:
    movz	w4,	#83
    movz	fp,	#932
    mov	w6,	w4
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #2576]

    ldr	x3,	[sp, #2576]

    str	w6,	[x3]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#84
    ble	main_413

main_283:
    movz	w4,	#84
    movz	fp,	#940
    mov	w5,	w4
    ldr	x28,	[sp, fp]

    str	x28,	[sp, #2568]

    ldr	x0,	[sp, #2568]

    str	w5,	[x0]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#85
    ble	main_413

main_285:
    movz	w4,	#85
    movz	fp,	#948
    ldr	x25,	[sp, fp]

    str	x25,	[sp, #2560]

    ldr	x26,	[sp, #2560]

    str	w4,	[x26]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#86
    ble	main_413

main_287:
    movz	w4,	#86
    movz	fp,	#956
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #2552]

    ldr	x23,	[sp, #2552]

    str	w4,	[x23]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#87
    ble	main_413

main_289:
    movz	w4,	#87
    movz	fp,	#964
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #2544]

    ldr	x20,	[sp, #2544]

    str	w4,	[x20]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#88
    ble	main_413

main_291:
    movz	w4,	#88
    movz	fp,	#972
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #2536]

    ldr	x17,	[sp, #2536]

    str	w4,	[x17]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#89
    ble	main_413

main_293:
    movz	w4,	#89
    movz	fp,	#980
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #2528]

    ldr	x14,	[sp, #2528]

    str	w4,	[x14]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#90
    ble	main_413

main_295:
    movz	w4,	#90
    movz	fp,	#988
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #2520]

    ldr	x11,	[sp, #2520]

    str	w4,	[x11]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#91
    ble	main_413

main_297:
    movz	w4,	#91
    movz	fp,	#996
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #2624]

    ldr	x8,	[sp, #2624]

    str	w4,	[x8]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#92
    ble	main_413

main_299:
    movz	w4,	#92
    movz	fp,	#1004
    mov	w6,	w4
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #2616]

    ldr	x5,	[sp, #2616]

    str	w6,	[x5]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#93
    ble	main_413

main_301:
    movz	w4,	#93
    movz	fp,	#1012
    mov	w6,	w4
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #2608]

    ldr	x2,	[sp, #2608]

    str	w6,	[x2]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#94
    ble	main_413

main_303:
    movz	w4,	#94
    movz	fp,	#1020
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2600]

    ldr	x28,	[sp, #2600]

    str	w4,	[x28]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#95
    ble	main_413

main_305:
    movz	w4,	#95
    movz	fp,	#1028
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2592]

    ldr	x25,	[sp, #2592]

    str	w4,	[x25]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#96
    ble	main_413

main_307:
    movz	w4,	#96
    movz	fp,	#1036
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2584]

    ldr	x22,	[sp, #2584]

    str	w4,	[x22]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#97
    ble	main_413

main_309:
    movz	w4,	#97
    movz	fp,	#1044
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #2256]

    ldr	x19,	[sp, #2256]

    str	w4,	[x19]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#98
    ble	main_413

main_311:
    movz	w4,	#98
    movz	fp,	#1052
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #2248]

    ldr	x16,	[sp, #2248]

    str	w4,	[x16]

    ldr	w4,	[sp, #1080]

    cmp	w4,	#99
    ble	main_413

main_313:
    movz	w4,	#99
    movz	fp,	#1060
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #440]

    ldr	x13,	[sp, #440]

    str	w4,	[x13]


main_413:
    ldr	w4,	[sp, #1068]

    add	w4,	w4,	#1
    str	w4,	[sp, #496]

    ldr	w4,	[sp, #1072]

    str	w4,	[sp, #484]

    movz	w4,	#0
    str	w4,	[sp, #472]


main_415:
    ldr	w4,	[sp, #472]

    cmp	w4,	#100
    bge	main_424

main_419:
    ldr	w4,	[sp, #472]

    lsl	w4,	w4,	#2
    mov	x4,	x4
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w4,	[x4]

    ldr	w13,	[sp, #484]

    str	w13,	[sp, #2940]

    ldr	w14,	[sp, #2940]

    ldr	w10,	[sp, #472]

    add	w6,	w4,	w14
    str	w10,	[sp, #2936]

    ldr	w11,	[sp, #2936]

    add	w4,	w11,	#1
    str	w4,	[sp, #2928]

    mov	w4,	w6
    ldr	w5,	[sp, #2928]

    str	w5,	[sp, #452]

    str	w4,	[sp, #484]

    ldr	w4,	[sp, #452]

    str	w4,	[sp, #472]

    b	main_415

main_424:
    movz	w4,	#65535
    ldr	w16,	[sp, #484]

    str	w16,	[sp, #2944]

    ldr	w17,	[sp, #2944]

    sdiv	w4,	w17,	w4
    str	w4,	[sp, #448]

    ldr	w4,	[sp, #448]

    ldr	w7,	[sp, #448]

    lsl	w4,	w4,	#16
    str	w7,	[sp, #2932]

    ldr	w8,	[sp, #2932]

    ldr	w19,	[sp, #484]

    sub	w4,	w4,	w8,	lsl #0
    str	w19,	[sp, #2948]

    ldr	w20,	[sp, #2948]

    ldr	w7,	[sp, #496]

    sub	w5,	w20,	w4
    str	w7,	[sp, #1892]

    ldr	w22,	[sp, #1076]

    str	w22,	[sp, #2952]

    ldr	w8,	[sp, #1892]

    ldr	w0,	[sp, #2952]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w4,	w5
    str	w4,	[sp, #1072]

    ldr	w4,	[sp, #496]

    str	w4,	[sp, #1068]

    b	main_113

main_428:
    mov	w0,	w5
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


