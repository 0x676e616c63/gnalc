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
    str	w0,	[sp, #1036]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1040]

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
    ldr	w15,	[sp, #1036]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x10,	sp,	#20
    movz	fp,	#1092
    add	x7,	sp,	#24
    add	x28,	sp,	#28
    add	x9,	sp,	#32
    add	x2,	sp,	#36
    add	x5,	sp,	#40
    add	x15,	sp,	#44
    add	x1,	sp,	#48
    add	x26,	sp,	#52
    add	x20,	sp,	#56
    add	x4,	sp,	#60
    add	x19,	sp,	#64
    add	x27,	sp,	#68
    add	x24,	sp,	#72
    add	x13,	sp,	#76
    add	x25,	sp,	#80
    add	x6,	sp,	#84
    add	x16,	sp,	#88
    add	x17,	sp,	#92
    add	x23,	sp,	#96
    add	x11,	sp,	#100
    add	x14,	sp,	#104
    add	x8,	sp,	#108
    add	x18,	sp,	#112
    add	x22,	sp,	#116
    add	x0,	sp,	#120
    add	x21,	sp,	#124
    add	x3,	sp,	#128
    str	x10,	[sp, fp]

    movz	fp,	#1084
    str	x7,	[sp, fp]

    movz	fp,	#1724
    str	x28,	[sp, fp]

    movz	fp,	#1828
    str	x9,	[sp, fp]

    movz	fp,	#1732
    str	x2,	[sp, fp]

    movz	fp,	#1740
    str	x5,	[sp, fp]

    movz	fp,	#1700
    str	x15,	[sp, fp]

    movz	fp,	#1068
    str	x1,	[sp, fp]

    movz	fp,	#1796
    str	x26,	[sp, fp]

    movz	fp,	#1780
    str	x20,	[sp, fp]

    movz	fp,	#1076
    str	x4,	[sp, fp]

    movz	fp,	#1532
    str	x19,	[sp, fp]

    movz	fp,	#1060
    str	x27,	[sp, fp]

    movz	fp,	#1052
    str	x24,	[sp, fp]

    movz	fp,	#1516
    str	x13,	[sp, fp]

    movz	fp,	#1548
    str	x25,	[sp, fp]

    movz	fp,	#1820
    str	x6,	[sp, fp]

    movz	fp,	#1524
    str	x16,	[sp, fp]

    movz	fp,	#1772
    str	x17,	[sp, fp]

    movz	fp,	#1788
    str	x23,	[sp, fp]

    movz	fp,	#1756
    str	x11,	[sp, fp]

    movz	fp,	#1764
    str	x14,	[sp, fp]

    add	x14,	sp,	#132
    movz	fp,	#1748
    str	x8,	[sp, fp]

    movz	fp,	#1708
    str	x18,	[sp, fp]

    movz	fp,	#1540
    str	x22,	[sp, fp]

    movz	fp,	#1804
    str	x0,	[sp, fp]

    movz	fp,	#1716
    str	x21,	[sp, fp]

    movz	fp,	#1812
    str	x3,	[sp, fp]

    movz	fp,	#468
    str	x14,	[sp, fp]

    movz	fp,	#460
    add	x14,	sp,	#136
    str	x14,	[sp, #488]

    add	x14,	sp,	#140
    str	x14,	[sp, fp]

    movz	fp,	#644
    add	x14,	sp,	#144
    str	x14,	[sp, #496]

    add	x14,	sp,	#148
    str	x14,	[sp, #504]

    add	x14,	sp,	#152
    str	x14,	[sp, #512]

    add	x14,	sp,	#156
    str	x14,	[sp, fp]

    movz	fp,	#652
    add	x14,	sp,	#160
    str	x14,	[sp, fp]

    movz	fp,	#660
    add	x14,	sp,	#164
    str	x14,	[sp, fp]

    movz	fp,	#668
    add	x14,	sp,	#168
    str	x14,	[sp, fp]

    movz	fp,	#676
    add	x14,	sp,	#172
    str	x14,	[sp, fp]

    movz	fp,	#532
    add	x14,	sp,	#176
    str	x14,	[sp, fp]

    movz	fp,	#540
    add	x14,	sp,	#180
    str	x14,	[sp, fp]

    movz	fp,	#548
    add	x14,	sp,	#184
    str	x14,	[sp, fp]

    movz	fp,	#556
    add	x14,	sp,	#188
    str	x14,	[sp, fp]

    movz	fp,	#564
    add	x14,	sp,	#192
    str	x14,	[sp, fp]

    movz	fp,	#572
    add	x14,	sp,	#196
    str	x14,	[sp, fp]

    movz	fp,	#580
    add	x14,	sp,	#200
    str	x14,	[sp, fp]

    movz	fp,	#588
    add	x14,	sp,	#204
    str	x14,	[sp, fp]

    movz	fp,	#596
    add	x14,	sp,	#208
    str	x14,	[sp, fp]

    movz	fp,	#604
    add	x14,	sp,	#212
    str	x14,	[sp, fp]

    movz	fp,	#620
    add	x14,	sp,	#216
    str	x14,	[sp, fp]

    movz	fp,	#628
    add	x14,	sp,	#220
    str	x14,	[sp, fp]

    movz	fp,	#636
    add	x14,	sp,	#224
    str	x14,	[sp, fp]

    movz	fp,	#684
    add	x14,	sp,	#228
    str	x14,	[sp, fp]

    movz	fp,	#612
    add	x14,	sp,	#232
    str	x14,	[sp, #416]

    add	x14,	sp,	#236
    str	x14,	[sp, #424]

    add	x14,	sp,	#240
    str	x14,	[sp, #432]

    add	x14,	sp,	#244
    str	x14,	[sp, fp]

    movz	fp,	#692
    add	x14,	sp,	#248
    str	x14,	[sp, fp]

    movz	fp,	#700
    add	x14,	sp,	#252
    str	x14,	[sp, fp]

    movz	fp,	#708
    add	x14,	sp,	#256
    str	x14,	[sp, fp]

    movz	fp,	#716
    add	x14,	sp,	#260
    str	x14,	[sp, fp]

    movz	fp,	#724
    add	x14,	sp,	#264
    str	x14,	[sp, fp]

    movz	fp,	#732
    add	x14,	sp,	#268
    str	x14,	[sp, fp]

    movz	fp,	#740
    add	x14,	sp,	#272
    str	x14,	[sp, fp]

    movz	fp,	#748
    add	x14,	sp,	#276
    str	x14,	[sp, fp]

    movz	fp,	#756
    add	x14,	sp,	#280
    str	x14,	[sp, fp]

    movz	fp,	#764
    add	x14,	sp,	#284
    str	x14,	[sp, fp]

    movz	fp,	#772
    add	x14,	sp,	#288
    str	x14,	[sp, fp]

    movz	fp,	#780
    add	x14,	sp,	#292
    str	x14,	[sp, fp]

    movz	fp,	#788
    add	x14,	sp,	#296
    str	x14,	[sp, fp]

    movz	fp,	#796
    add	x14,	sp,	#300
    str	x14,	[sp, fp]

    movz	fp,	#804
    add	x14,	sp,	#304
    str	x14,	[sp, fp]

    movz	fp,	#812
    add	x14,	sp,	#308
    str	x14,	[sp, fp]

    movz	fp,	#820
    add	x14,	sp,	#312
    str	x14,	[sp, fp]

    movz	fp,	#828
    add	x14,	sp,	#316
    str	x14,	[sp, fp]

    movz	fp,	#836
    add	x14,	sp,	#320
    str	x14,	[sp, fp]

    movz	fp,	#844
    add	x14,	sp,	#324
    str	x14,	[sp, fp]

    movz	fp,	#852
    add	x14,	sp,	#328
    str	x14,	[sp, fp]

    movz	fp,	#860
    add	x14,	sp,	#332
    str	x14,	[sp, fp]

    movz	fp,	#868
    add	x14,	sp,	#336
    str	x14,	[sp, fp]

    movz	fp,	#876
    add	x14,	sp,	#340
    str	x14,	[sp, fp]

    movz	fp,	#884
    add	x14,	sp,	#344
    str	x14,	[sp, fp]

    movz	fp,	#892
    add	x14,	sp,	#348
    str	x14,	[sp, fp]

    movz	fp,	#900
    add	x14,	sp,	#352
    str	x14,	[sp, fp]

    movz	fp,	#908
    add	x14,	sp,	#356
    str	x14,	[sp, fp]

    movz	fp,	#916
    add	x14,	sp,	#360
    str	x14,	[sp, fp]

    movz	fp,	#924
    add	x14,	sp,	#364
    str	x14,	[sp, fp]

    movz	fp,	#932
    add	x14,	sp,	#368
    str	x14,	[sp, fp]

    movz	fp,	#940
    add	x14,	sp,	#372
    str	x14,	[sp, fp]

    movz	fp,	#948
    add	x14,	sp,	#376
    str	x14,	[sp, fp]

    movz	fp,	#956
    add	x14,	sp,	#380
    str	x14,	[sp, fp]

    movz	fp,	#964
    add	x14,	sp,	#384
    str	x14,	[sp, fp]

    movz	fp,	#972
    add	x14,	sp,	#388
    str	x14,	[sp, fp]

    movz	fp,	#980
    add	x14,	sp,	#392
    str	x14,	[sp, fp]

    movz	fp,	#988
    add	x14,	sp,	#396
    str	x14,	[sp, fp]

    movz	fp,	#996
    add	x14,	sp,	#400
    str	x14,	[sp, fp]

    movz	fp,	#1004
    add	x14,	sp,	#404
    str	x14,	[sp, fp]

    movz	fp,	#1012
    add	x14,	sp,	#408
    str	x14,	[sp, fp]

    movz	fp,	#1020
    add	x14,	sp,	#412
    str	x14,	[sp, fp]

    movz	w14,	#0
    str	w14,	[sp, #1032]

    movz	w14,	#0
    str	w14,	[sp, #1028]


main_113:
    ldr	w14,	[sp, #1040]

    cmp	w14,	#1
    ble	main_413

main_117:
    movz	w14,	#1
    movz	fp,	#1092
    ldr	x4,	[sp, fp]

    str	w14,	[x4]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#2
    ble	main_413

main_119:
    movz	w14,	#2
    movz	fp,	#1084
    ldr	x1,	[sp, fp]

    str	w14,	[x1]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#3
    ble	main_413

main_121:
    movz	w14,	#3
    movz	fp,	#1724
    ldr	x24,	[sp, fp]

    str	w14,	[x24]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#4
    ble	main_413

main_123:
    movz	w14,	#4
    movz	fp,	#1828
    ldr	x5,	[sp, fp]

    str	w14,	[x5]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#5
    ble	main_413

main_125:
    movz	w14,	#5
    movz	fp,	#1732
    ldr	x27,	[sp, fp]

    str	w14,	[x27]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#6
    ble	main_413

main_127:
    movz	w14,	#6
    movz	fp,	#1740
    ldr	x0,	[sp, fp]

    str	w14,	[x0]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#7
    ble	main_413

main_129:
    movz	w14,	#7
    movz	fp,	#1700
    ldr	x8,	[sp, fp]

    str	w14,	[x8]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#8
    ble	main_413

main_131:
    movz	w14,	#8
    movz	fp,	#1068
    ldr	x25,	[sp, fp]

    str	w14,	[x25]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#9
    ble	main_413

main_133:
    movz	w14,	#9
    movz	fp,	#1796
    ldr	x23,	[sp, fp]

    str	w14,	[x23]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#10
    ble	main_413

main_135:
    movz	w14,	#10
    movz	fp,	#1780
    ldr	x17,	[sp, fp]

    str	w14,	[x17]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#11
    ble	main_413

main_137:
    movz	w14,	#11
    movz	fp,	#1076
    ldr	x28,	[sp, fp]

    str	w14,	[x28]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#12
    ble	main_413

main_139:
    movz	w14,	#12
    movz	fp,	#1532
    ldr	x13,	[sp, fp]

    str	w14,	[x13]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#13
    ble	main_413

main_141:
    movz	w14,	#13
    movz	fp,	#1060
    ldr	x22,	[sp, fp]

    str	w14,	[x22]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#14
    ble	main_413

main_143:
    movz	w14,	#14
    movz	fp,	#1052
    ldr	x19,	[sp, fp]

    str	w14,	[x19]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#15
    ble	main_413

main_145:
    movz	w14,	#15
    movz	fp,	#1516
    ldr	x7,	[sp, fp]

    str	w14,	[x7]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#16
    ble	main_413

main_147:
    movz	w14,	#16
    movz	fp,	#1548
    ldr	x21,	[sp, fp]

    str	w14,	[x21]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#17
    ble	main_413

main_149:
    movz	w14,	#17
    movz	fp,	#1820
    ldr	x2,	[sp, fp]

    str	w14,	[x2]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#18
    ble	main_413

main_151:
    movz	w14,	#18
    movz	fp,	#1524
    ldr	x10,	[sp, fp]

    str	w14,	[x10]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#19
    ble	main_413

main_153:
    movz	w14,	#19
    movz	fp,	#1772
    ldr	x12,	[sp, fp]

    str	w14,	[x12]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#20
    ble	main_413

main_155:
    movz	w14,	#20
    movz	fp,	#1788
    ldr	x20,	[sp, fp]

    str	w14,	[x20]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#21
    ble	main_413

main_157:
    movz	w14,	#21
    movz	fp,	#1756
    ldr	x6,	[sp, fp]

    str	w14,	[x6]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#22
    ble	main_413

main_159:
    movz	w14,	#22
    movz	fp,	#1764
    ldr	x9,	[sp, fp]

    str	w14,	[x9]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#23
    ble	main_413

main_161:
    movz	w14,	#23
    movz	fp,	#1748
    ldr	x3,	[sp, fp]

    str	w14,	[x3]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#24
    ble	main_413

main_163:
    movz	w14,	#24
    movz	fp,	#1708
    ldr	x11,	[sp, fp]

    str	w14,	[x11]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#25
    ble	main_413

main_165:
    movz	w14,	#25
    movz	fp,	#1540
    ldr	x18,	[sp, fp]

    str	w14,	[x18]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#26
    ble	main_413

main_167:
    movz	w14,	#26
    movz	fp,	#1804
    ldr	x26,	[sp, fp]

    str	w14,	[x26]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#27
    ble	main_413

main_169:
    movz	w14,	#27
    movz	fp,	#1716
    ldr	x16,	[sp, fp]

    str	w14,	[x16]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#28
    ble	main_413

main_171:
    movz	w14,	#28
    movz	fp,	#1812
    ldr	x0,	[sp, fp]

    str	w14,	[x0]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#29
    ble	main_413

main_173:
    movz	w14,	#29
    movz	fp,	#468
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3168]

    ldr	x22,	[sp, #3168]

    str	w14,	[x22]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#30
    ble	main_413

main_175:
    movz	w14,	#30
    ldr	x24,	[sp, #488]

    str	x24,	[sp, #3176]

    ldr	x25,	[sp, #3176]

    str	w14,	[x25]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#31
    ble	main_413

main_177:
    movz	w14,	#31
    movz	fp,	#460
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3184]

    ldr	x28,	[sp, #3184]

    str	w14,	[x28]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#32
    ble	main_413

main_179:
    movz	w14,	#32
    ldr	x1,	[sp, #496]

    mov	w16,	w14
    str	x1,	[sp, #3192]

    ldr	x2,	[sp, #3192]

    str	w16,	[x2]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#33
    ble	main_413

main_181:
    movz	w14,	#33
    ldr	x4,	[sp, #504]

    mov	w16,	w14
    str	x4,	[sp, #3200]

    ldr	x5,	[sp, #3200]

    str	w16,	[x5]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#34
    ble	main_413

main_183:
    movz	w14,	#34
    ldr	x4,	[sp, #512]

    movz	fp,	#2316
    mov	w16,	w14
    str	x4,	[sp, fp]

    movz	fp,	#2316
    ldr	x5,	[sp, fp]

    str	w16,	[x5]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#35
    ble	main_413

main_185:
    movz	w14,	#35
    movz	fp,	#644
    mov	w16,	w14
    ldr	x1,	[sp, fp]

    movz	fp,	#2308
    str	x1,	[sp, fp]

    movz	fp,	#2308
    ldr	x2,	[sp, fp]

    str	w16,	[x2]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#36
    ble	main_413

main_187:
    movz	w14,	#36
    movz	fp,	#652
    ldr	x27,	[sp, fp]

    movz	fp,	#2300
    str	x27,	[sp, fp]

    movz	fp,	#2300
    ldr	x28,	[sp, fp]

    str	w14,	[x28]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#37
    ble	main_413

main_189:
    movz	w14,	#37
    movz	fp,	#660
    ldr	x24,	[sp, fp]

    movz	fp,	#2292
    str	x24,	[sp, fp]

    movz	fp,	#2292
    ldr	x25,	[sp, fp]

    str	w14,	[x25]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#38
    ble	main_413

main_191:
    movz	w14,	#38
    movz	fp,	#668
    ldr	x21,	[sp, fp]

    movz	fp,	#2284
    str	x21,	[sp, fp]

    movz	fp,	#2284
    ldr	x22,	[sp, fp]

    str	w14,	[x22]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#39
    ble	main_413

main_193:
    movz	w14,	#39
    movz	fp,	#676
    ldr	x18,	[sp, fp]

    movz	fp,	#2276
    str	x18,	[sp, fp]

    movz	fp,	#2276
    ldr	x19,	[sp, fp]

    str	w14,	[x19]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#40
    ble	main_413

main_195:
    movz	w14,	#40
    movz	fp,	#532
    ldr	x15,	[sp, fp]

    movz	fp,	#2268
    str	x15,	[sp, fp]

    movz	fp,	#2268
    ldr	x16,	[sp, fp]

    str	w14,	[x16]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#41
    ble	main_413

main_197:
    movz	w14,	#41
    movz	fp,	#540
    mov	w16,	w14
    ldr	x12,	[sp, fp]

    movz	fp,	#2260
    str	x12,	[sp, fp]

    movz	fp,	#2260
    ldr	x13,	[sp, fp]

    str	w16,	[x13]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#42
    ble	main_413

main_199:
    movz	w14,	#42
    movz	fp,	#548
    mov	w16,	w14
    ldr	x9,	[sp, fp]

    movz	fp,	#2252
    str	x9,	[sp, fp]

    movz	fp,	#2252
    ldr	x10,	[sp, fp]

    str	w16,	[x10]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#43
    ble	main_413

main_201:
    movz	w14,	#43
    movz	fp,	#556
    mov	w16,	w14
    ldr	x6,	[sp, fp]

    movz	fp,	#2244
    str	x6,	[sp, fp]

    movz	fp,	#2244
    ldr	x7,	[sp, fp]

    str	w16,	[x7]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#44
    ble	main_413

main_203:
    movz	w14,	#44
    movz	fp,	#564
    mov	w16,	w14
    ldr	x3,	[sp, fp]

    movz	fp,	#2052
    str	x3,	[sp, fp]

    movz	fp,	#2052
    ldr	x4,	[sp, fp]

    str	w16,	[x4]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#45
    ble	main_413

main_205:
    movz	w14,	#45
    movz	fp,	#572
    mov	w16,	w14
    ldr	x0,	[sp, fp]

    movz	fp,	#2044
    str	x0,	[sp, fp]

    movz	fp,	#2044
    ldr	x1,	[sp, fp]

    str	w16,	[x1]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#46
    ble	main_413

main_207:
    movz	w14,	#46
    movz	fp,	#580
    ldr	x26,	[sp, fp]

    movz	fp,	#2036
    str	x26,	[sp, fp]

    movz	fp,	#2036
    ldr	x27,	[sp, fp]

    str	w14,	[x27]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#47
    ble	main_413

main_209:
    movz	w14,	#47
    movz	fp,	#588
    ldr	x23,	[sp, fp]

    movz	fp,	#2028
    str	x23,	[sp, fp]

    movz	fp,	#2028
    ldr	x24,	[sp, fp]

    str	w14,	[x24]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#48
    ble	main_413

main_211:
    movz	w14,	#48
    movz	fp,	#596
    ldr	x20,	[sp, fp]

    movz	fp,	#2020
    str	x20,	[sp, fp]

    movz	fp,	#2020
    ldr	x21,	[sp, fp]

    str	w14,	[x21]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#49
    ble	main_413

main_213:
    movz	w14,	#49
    movz	fp,	#604
    ldr	x17,	[sp, fp]

    movz	fp,	#2012
    str	x17,	[sp, fp]

    movz	fp,	#2012
    ldr	x18,	[sp, fp]

    str	w14,	[x18]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#50
    ble	main_413

main_215:
    movz	w14,	#50
    movz	fp,	#620
    mov	w16,	w14
    ldr	x14,	[sp, fp]

    movz	fp,	#2004
    str	x14,	[sp, fp]

    movz	fp,	#2004
    ldr	x15,	[sp, fp]

    str	w16,	[x15]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#51
    ble	main_413

main_217:
    movz	w14,	#51
    movz	fp,	#628
    mov	w16,	w14
    ldr	x11,	[sp, fp]

    movz	fp,	#1996
    str	x11,	[sp, fp]

    movz	fp,	#1996
    ldr	x12,	[sp, fp]

    str	w16,	[x12]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#52
    ble	main_413

main_219:
    movz	w14,	#52
    movz	fp,	#636
    mov	w16,	w14
    ldr	x8,	[sp, fp]

    movz	fp,	#1988
    str	x8,	[sp, fp]

    movz	fp,	#1988
    ldr	x9,	[sp, fp]

    str	w16,	[x9]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#53
    ble	main_413

main_221:
    movz	w14,	#53
    movz	fp,	#684
    mov	w16,	w14
    ldr	x5,	[sp, fp]

    movz	fp,	#1980
    str	x5,	[sp, fp]

    movz	fp,	#1980
    ldr	x6,	[sp, fp]

    str	w16,	[x6]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#54
    ble	main_413

main_223:
    movz	w14,	#54
    ldr	x2,	[sp, #416]

    movz	fp,	#1972
    mov	w16,	w14
    str	x2,	[sp, fp]

    movz	fp,	#1972
    ldr	x3,	[sp, fp]

    str	w16,	[x3]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#55
    ble	main_413

main_225:
    movz	w14,	#55
    ldr	x28,	[sp, #424]

    movz	fp,	#1964
    mov	w15,	w14
    str	x28,	[sp, fp]

    movz	fp,	#1964
    ldr	x0,	[sp, fp]

    str	w15,	[x0]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#56
    ble	main_413

main_227:
    movz	w14,	#56
    ldr	x25,	[sp, #432]

    movz	fp,	#1956
    str	x25,	[sp, fp]

    movz	fp,	#1956
    ldr	x26,	[sp, fp]

    str	w14,	[x26]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#57
    ble	main_413

main_229:
    movz	w14,	#57
    movz	fp,	#612
    ldr	x22,	[sp, fp]

    movz	fp,	#1948
    str	x22,	[sp, fp]

    movz	fp,	#1948
    ldr	x23,	[sp, fp]

    str	w14,	[x23]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#58
    ble	main_413

main_231:
    movz	w14,	#58
    movz	fp,	#692
    ldr	x19,	[sp, fp]

    movz	fp,	#1940
    str	x19,	[sp, fp]

    movz	fp,	#1940
    ldr	x20,	[sp, fp]

    str	w14,	[x20]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#59
    ble	main_413

main_233:
    movz	w14,	#59
    movz	fp,	#700
    ldr	x16,	[sp, fp]

    movz	fp,	#1932
    str	x16,	[sp, fp]

    movz	fp,	#1932
    ldr	x17,	[sp, fp]

    str	w14,	[x17]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#60
    ble	main_413

main_235:
    movz	w14,	#60
    movz	fp,	#708
    mov	w16,	w14
    ldr	x13,	[sp, fp]

    movz	fp,	#1924
    str	x13,	[sp, fp]

    movz	fp,	#1924
    ldr	x14,	[sp, fp]

    str	w16,	[x14]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#61
    ble	main_413

main_237:
    movz	w14,	#61
    movz	fp,	#716
    mov	w16,	w14
    ldr	x10,	[sp, fp]

    movz	fp,	#1916
    str	x10,	[sp, fp]

    movz	fp,	#1916
    ldr	x11,	[sp, fp]

    str	w16,	[x11]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#62
    ble	main_413

main_239:
    movz	w14,	#62
    movz	fp,	#724
    mov	w16,	w14
    ldr	x7,	[sp, fp]

    movz	fp,	#1908
    str	x7,	[sp, fp]

    movz	fp,	#1908
    ldr	x8,	[sp, fp]

    str	w16,	[x8]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#63
    ble	main_413

main_241:
    movz	w14,	#63
    movz	fp,	#732
    mov	w16,	w14
    ldr	x4,	[sp, fp]

    movz	fp,	#1900
    str	x4,	[sp, fp]

    movz	fp,	#1900
    ldr	x5,	[sp, fp]

    str	w16,	[x5]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#64
    ble	main_413

main_243:
    movz	w14,	#64
    movz	fp,	#740
    mov	w16,	w14
    ldr	x1,	[sp, fp]

    movz	fp,	#1892
    str	x1,	[sp, fp]

    movz	fp,	#1892
    ldr	x2,	[sp, fp]

    str	w16,	[x2]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#65
    ble	main_413

main_245:
    movz	w14,	#65
    movz	fp,	#748
    ldr	x27,	[sp, fp]

    movz	fp,	#1884
    str	x27,	[sp, fp]

    movz	fp,	#1884
    ldr	x28,	[sp, fp]

    str	w14,	[x28]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#66
    ble	main_413

main_247:
    movz	w14,	#66
    movz	fp,	#756
    ldr	x24,	[sp, fp]

    movz	fp,	#1876
    str	x24,	[sp, fp]

    movz	fp,	#1876
    ldr	x25,	[sp, fp]

    str	w14,	[x25]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#67
    ble	main_413

main_249:
    movz	w14,	#67
    movz	fp,	#764
    ldr	x21,	[sp, fp]

    movz	fp,	#1868
    str	x21,	[sp, fp]

    movz	fp,	#1868
    ldr	x22,	[sp, fp]

    str	w14,	[x22]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#68
    ble	main_413

main_251:
    movz	w14,	#68
    movz	fp,	#772
    ldr	x18,	[sp, fp]

    movz	fp,	#1860
    str	x18,	[sp, fp]

    movz	fp,	#1860
    ldr	x19,	[sp, fp]

    str	w14,	[x19]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#69
    ble	main_413

main_253:
    movz	w14,	#69
    movz	fp,	#780
    ldr	x15,	[sp, fp]

    movz	fp,	#1852
    str	x15,	[sp, fp]

    movz	fp,	#1852
    ldr	x16,	[sp, fp]

    str	w14,	[x16]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#70
    ble	main_413

main_255:
    movz	w14,	#70
    movz	fp,	#788
    mov	w16,	w14
    ldr	x12,	[sp, fp]

    movz	fp,	#1844
    str	x12,	[sp, fp]

    movz	fp,	#1844
    ldr	x13,	[sp, fp]

    str	w16,	[x13]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#71
    ble	main_413

main_257:
    movz	w14,	#71
    movz	fp,	#796
    mov	w16,	w14
    ldr	x9,	[sp, fp]

    movz	fp,	#1836
    str	x9,	[sp, fp]

    movz	fp,	#1836
    ldr	x10,	[sp, fp]

    str	w16,	[x10]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#72
    ble	main_413

main_259:
    movz	w14,	#72
    movz	fp,	#804
    mov	w16,	w14
    ldr	x6,	[sp, fp]

    movz	fp,	#2236
    str	x6,	[sp, fp]

    movz	fp,	#2236
    ldr	x7,	[sp, fp]

    str	w16,	[x7]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#73
    ble	main_413

main_261:
    movz	w14,	#73
    movz	fp,	#812
    mov	w16,	w14
    ldr	x3,	[sp, fp]

    movz	fp,	#2228
    str	x3,	[sp, fp]

    movz	fp,	#2228
    ldr	x4,	[sp, fp]

    str	w16,	[x4]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#74
    ble	main_413

main_263:
    movz	w14,	#74
    movz	fp,	#820
    mov	w16,	w14
    ldr	x0,	[sp, fp]

    movz	fp,	#2220
    str	x0,	[sp, fp]

    movz	fp,	#2220
    ldr	x1,	[sp, fp]

    str	w16,	[x1]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#75
    ble	main_413

main_265:
    movz	w14,	#75
    movz	fp,	#828
    ldr	x26,	[sp, fp]

    movz	fp,	#2212
    str	x26,	[sp, fp]

    movz	fp,	#2212
    ldr	x27,	[sp, fp]

    str	w14,	[x27]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#76
    ble	main_413

main_267:
    movz	w14,	#76
    movz	fp,	#836
    ldr	x23,	[sp, fp]

    movz	fp,	#2204
    str	x23,	[sp, fp]

    movz	fp,	#2204
    ldr	x24,	[sp, fp]

    str	w14,	[x24]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#77
    ble	main_413

main_269:
    movz	w14,	#77
    movz	fp,	#844
    ldr	x20,	[sp, fp]

    movz	fp,	#2196
    str	x20,	[sp, fp]

    movz	fp,	#2196
    ldr	x21,	[sp, fp]

    str	w14,	[x21]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#78
    ble	main_413

main_271:
    movz	w14,	#78
    movz	fp,	#852
    ldr	x17,	[sp, fp]

    movz	fp,	#2188
    str	x17,	[sp, fp]

    movz	fp,	#2188
    ldr	x18,	[sp, fp]

    str	w14,	[x18]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#79
    ble	main_413

main_273:
    movz	w14,	#79
    movz	fp,	#860
    mov	w16,	w14
    ldr	x14,	[sp, fp]

    movz	fp,	#2180
    str	x14,	[sp, fp]

    movz	fp,	#2180
    ldr	x15,	[sp, fp]

    str	w16,	[x15]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#80
    ble	main_413

main_275:
    movz	w14,	#80
    movz	fp,	#868
    mov	w16,	w14
    ldr	x11,	[sp, fp]

    movz	fp,	#2172
    str	x11,	[sp, fp]

    movz	fp,	#2172
    ldr	x12,	[sp, fp]

    str	w16,	[x12]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#81
    ble	main_413

main_277:
    movz	w14,	#81
    movz	fp,	#876
    mov	w16,	w14
    ldr	x8,	[sp, fp]

    movz	fp,	#2164
    str	x8,	[sp, fp]

    movz	fp,	#2164
    ldr	x9,	[sp, fp]

    str	w16,	[x9]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#82
    ble	main_413

main_279:
    movz	w14,	#82
    movz	fp,	#884
    mov	w16,	w14
    ldr	x5,	[sp, fp]

    movz	fp,	#2156
    str	x5,	[sp, fp]

    movz	fp,	#2156
    ldr	x6,	[sp, fp]

    str	w16,	[x6]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#83
    ble	main_413

main_281:
    movz	w14,	#83
    movz	fp,	#892
    mov	w16,	w14
    ldr	x2,	[sp, fp]

    movz	fp,	#2148
    str	x2,	[sp, fp]

    movz	fp,	#2148
    ldr	x3,	[sp, fp]

    str	w16,	[x3]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#84
    ble	main_413

main_283:
    movz	w14,	#84
    movz	fp,	#900
    mov	w15,	w14
    ldr	x28,	[sp, fp]

    movz	fp,	#2140
    str	x28,	[sp, fp]

    movz	fp,	#2140
    ldr	x0,	[sp, fp]

    str	w15,	[x0]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#85
    ble	main_413

main_285:
    movz	w14,	#85
    movz	fp,	#908
    ldr	x25,	[sp, fp]

    movz	fp,	#2132
    str	x25,	[sp, fp]

    movz	fp,	#2132
    ldr	x26,	[sp, fp]

    str	w14,	[x26]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#86
    ble	main_413

main_287:
    movz	w14,	#86
    movz	fp,	#916
    ldr	x22,	[sp, fp]

    movz	fp,	#2124
    str	x22,	[sp, fp]

    movz	fp,	#2124
    ldr	x23,	[sp, fp]

    str	w14,	[x23]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#87
    ble	main_413

main_289:
    movz	w14,	#87
    movz	fp,	#924
    ldr	x19,	[sp, fp]

    movz	fp,	#2116
    str	x19,	[sp, fp]

    movz	fp,	#2116
    ldr	x20,	[sp, fp]

    str	w14,	[x20]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#88
    ble	main_413

main_291:
    movz	w14,	#88
    movz	fp,	#932
    ldr	x16,	[sp, fp]

    movz	fp,	#2108
    str	x16,	[sp, fp]

    movz	fp,	#2108
    ldr	x17,	[sp, fp]

    str	w14,	[x17]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#89
    ble	main_413

main_293:
    movz	w14,	#89
    movz	fp,	#940
    mov	w16,	w14
    ldr	x13,	[sp, fp]

    movz	fp,	#2100
    str	x13,	[sp, fp]

    movz	fp,	#2100
    ldr	x14,	[sp, fp]

    str	w16,	[x14]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#90
    ble	main_413

main_295:
    movz	w14,	#90
    movz	fp,	#948
    mov	w16,	w14
    ldr	x10,	[sp, fp]

    movz	fp,	#2092
    str	x10,	[sp, fp]

    movz	fp,	#2092
    ldr	x11,	[sp, fp]

    str	w16,	[x11]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#91
    ble	main_413

main_297:
    movz	w14,	#91
    movz	fp,	#956
    mov	w16,	w14
    ldr	x7,	[sp, fp]

    movz	fp,	#2084
    str	x7,	[sp, fp]

    movz	fp,	#2084
    ldr	x8,	[sp, fp]

    str	w16,	[x8]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#92
    ble	main_413

main_299:
    movz	w14,	#92
    movz	fp,	#964
    mov	w16,	w14
    ldr	x4,	[sp, fp]

    movz	fp,	#2076
    str	x4,	[sp, fp]

    movz	fp,	#2076
    ldr	x5,	[sp, fp]

    str	w16,	[x5]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#93
    ble	main_413

main_301:
    movz	w14,	#93
    movz	fp,	#972
    mov	w16,	w14
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3240]

    ldr	x2,	[sp, #3240]

    str	w16,	[x2]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#94
    ble	main_413

main_303:
    movz	w14,	#94
    movz	fp,	#980
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3232]

    ldr	x28,	[sp, #3232]

    str	w14,	[x28]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#95
    ble	main_413

main_305:
    movz	w14,	#95
    movz	fp,	#988
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3224]

    ldr	x25,	[sp, #3224]

    str	w14,	[x25]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#96
    ble	main_413

main_307:
    movz	w14,	#96
    movz	fp,	#996
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3216]

    ldr	x22,	[sp, #3216]

    str	w14,	[x22]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#97
    ble	main_413

main_309:
    movz	w14,	#97
    movz	fp,	#1004
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #3208]

    ldr	x19,	[sp, #3208]

    str	w14,	[x19]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#98
    ble	main_413

main_311:
    movz	w14,	#98
    movz	fp,	#1012
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #480]

    ldr	x16,	[sp, #480]

    str	w14,	[x16]

    ldr	w14,	[sp, #1040]

    cmp	w14,	#99
    ble	main_413

main_313:
    movz	w14,	#99
    movz	fp,	#1020
    mov	w16,	w14
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #440]

    ldr	x13,	[sp, #440]

    str	w16,	[x13]


main_413:
    ldr	w14,	[sp, #1028]

    add	w14,	w14,	#1
    str	w14,	[sp, #528]

    ldr	w14,	[sp, #1032]

    str	w14,	[sp, #456]

    movz	w14,	#0
    str	w14,	[sp, #524]


main_415:
    ldr	w14,	[sp, #524]

    cmp	w14,	#100
    bge	main_424

main_419:
    ldr	w14,	[sp, #524]

    lsl	w14,	w14,	#2
    mov	x14,	x14
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w16,	[x14]

    ldr	w13,	[sp, #456]

    str	w13,	[sp, #2988]

    ldr	w14,	[sp, #2988]

    ldr	w10,	[sp, #524]

    add	w18,	w16,	w14
    str	w10,	[sp, #2984]

    mov	w14,	w18
    ldr	w11,	[sp, #2984]

    add	w4,	w11,	#1
    str	w4,	[sp, #2976]

    ldr	w5,	[sp, #2976]

    str	w5,	[sp, #520]

    str	w14,	[sp, #456]

    ldr	w14,	[sp, #520]

    str	w14,	[sp, #524]

    b	main_415

main_424:
    movz	w14,	#65535
    ldr	w16,	[sp, #456]

    str	w16,	[sp, #2992]

    ldr	w17,	[sp, #2992]

    sdiv	w14,	w17,	w14
    str	w14,	[sp, #476]

    ldr	w14,	[sp, #476]

    ldr	w7,	[sp, #476]

    lsl	w16,	w14,	#16
    str	w7,	[sp, #2980]

    ldr	w8,	[sp, #2980]

    ldr	w19,	[sp, #456]

    sub	w14,	w16,	w8,	lsl #0
    str	w19,	[sp, #2996]

    ldr	w20,	[sp, #2996]

    ldr	w7,	[sp, #528]

    sub	w17,	w20,	w14
    str	w7,	[sp, #2324]

    ldr	w22,	[sp, #1036]

    str	w22,	[sp, #3000]

    ldr	w8,	[sp, #2324]

    ldr	w0,	[sp, #3000]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w14,	w17
    str	w14,	[sp, #1032]

    ldr	w14,	[sp, #528]

    str	w14,	[sp, #1028]

    b	main_113

main_428:
    mov	w0,	w17
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


