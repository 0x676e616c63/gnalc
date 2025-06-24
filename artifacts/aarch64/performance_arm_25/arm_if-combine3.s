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
    str	w0,	[sp, #1020]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1024]

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
    ldr	w15,	[sp, #1020]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x20,	sp,	#20
    movz	fp,	#1652
    add	x4,	sp,	#24
    add	x14,	sp,	#28
    add	x28,	sp,	#32
    add	x11,	sp,	#36
    add	x16,	sp,	#40
    add	x1,	sp,	#44
    add	x2,	sp,	#48
    add	x7,	sp,	#52
    add	x6,	sp,	#56
    add	x5,	sp,	#60
    add	x19,	sp,	#64
    add	x15,	sp,	#68
    add	x10,	sp,	#72
    add	x8,	sp,	#76
    add	x24,	sp,	#80
    add	x0,	sp,	#84
    add	x3,	sp,	#88
    add	x9,	sp,	#92
    add	x25,	sp,	#96
    add	x22,	sp,	#100
    add	x21,	sp,	#104
    add	x13,	sp,	#108
    add	x17,	sp,	#112
    add	x27,	sp,	#116
    add	x23,	sp,	#120
    add	x18,	sp,	#124
    add	x26,	sp,	#128
    str	x20,	[sp, fp]

    movz	fp,	#1036
    str	x4,	[sp, fp]

    movz	fp,	#1636
    str	x14,	[sp, fp]

    movz	fp,	#1596
    str	x28,	[sp, fp]

    movz	fp,	#1628
    str	x11,	[sp, fp]

    movz	fp,	#1068
    str	x16,	[sp, fp]

    movz	fp,	#1204
    str	x1,	[sp, fp]

    movz	fp,	#1604
    str	x2,	[sp, fp]

    movz	fp,	#1044
    str	x7,	[sp, fp]

    movz	fp,	#1692
    str	x6,	[sp, fp]

    movz	fp,	#1612
    str	x5,	[sp, fp]

    movz	fp,	#1572
    str	x19,	[sp, fp]

    add	x19,	sp,	#132
    movz	fp,	#1164
    str	x15,	[sp, fp]

    movz	fp,	#1052
    str	x10,	[sp, fp]

    movz	fp,	#1620
    str	x8,	[sp, fp]

    movz	fp,	#1188
    str	x24,	[sp, fp]

    movz	fp,	#1676
    str	x0,	[sp, fp]

    movz	fp,	#1684
    str	x3,	[sp, fp]

    movz	fp,	#1700
    str	x9,	[sp, fp]

    movz	fp,	#1588
    str	x25,	[sp, fp]

    movz	fp,	#1580
    str	x22,	[sp, fp]

    movz	fp,	#1180
    str	x21,	[sp, fp]

    movz	fp,	#1060
    str	x13,	[sp, fp]

    movz	fp,	#1644
    str	x17,	[sp, fp]

    movz	fp,	#1196
    str	x27,	[sp, fp]

    movz	fp,	#1660
    str	x23,	[sp, fp]

    movz	fp,	#1172
    str	x18,	[sp, fp]

    movz	fp,	#1668
    str	x26,	[sp, fp]

    movz	fp,	#460
    str	x19,	[sp, fp]

    movz	fp,	#604
    add	x19,	sp,	#136
    str	x19,	[sp, #440]

    add	x19,	sp,	#140
    str	x19,	[sp, #448]

    add	x19,	sp,	#144
    str	x19,	[sp, #480]

    add	x19,	sp,	#148
    str	x19,	[sp, #488]

    add	x19,	sp,	#152
    str	x19,	[sp, #496]

    add	x19,	sp,	#156
    str	x19,	[sp, #504]

    add	x19,	sp,	#160
    str	x19,	[sp, #512]

    add	x19,	sp,	#164
    str	x19,	[sp, #520]

    add	x19,	sp,	#168
    str	x19,	[sp, fp]

    movz	fp,	#612
    add	x19,	sp,	#172
    str	x19,	[sp, fp]

    movz	fp,	#620
    add	x19,	sp,	#176
    str	x19,	[sp, fp]

    movz	fp,	#628
    add	x19,	sp,	#180
    str	x19,	[sp, fp]

    movz	fp,	#636
    add	x19,	sp,	#184
    str	x19,	[sp, fp]

    movz	fp,	#644
    add	x19,	sp,	#188
    str	x19,	[sp, fp]

    movz	fp,	#652
    add	x19,	sp,	#192
    str	x19,	[sp, fp]

    movz	fp,	#532
    add	x19,	sp,	#196
    str	x19,	[sp, fp]

    movz	fp,	#540
    add	x19,	sp,	#200
    str	x19,	[sp, fp]

    movz	fp,	#548
    add	x19,	sp,	#204
    str	x19,	[sp, fp]

    movz	fp,	#556
    add	x19,	sp,	#208
    str	x19,	[sp, fp]

    movz	fp,	#564
    add	x19,	sp,	#212
    str	x19,	[sp, fp]

    movz	fp,	#572
    add	x19,	sp,	#216
    str	x19,	[sp, fp]

    movz	fp,	#580
    add	x19,	sp,	#220
    str	x19,	[sp, fp]

    movz	fp,	#596
    add	x19,	sp,	#224
    str	x19,	[sp, fp]

    movz	fp,	#660
    add	x19,	sp,	#228
    str	x19,	[sp, fp]

    movz	fp,	#588
    add	x19,	sp,	#232
    str	x19,	[sp, fp]

    movz	fp,	#668
    add	x19,	sp,	#236
    str	x19,	[sp, #416]

    add	x19,	sp,	#240
    str	x19,	[sp, #424]

    add	x19,	sp,	#244
    str	x19,	[sp, fp]

    movz	fp,	#676
    add	x19,	sp,	#248
    str	x19,	[sp, fp]

    movz	fp,	#684
    add	x19,	sp,	#252
    str	x19,	[sp, fp]

    movz	fp,	#692
    add	x19,	sp,	#256
    str	x19,	[sp, fp]

    movz	fp,	#700
    add	x19,	sp,	#260
    str	x19,	[sp, fp]

    movz	fp,	#708
    add	x19,	sp,	#264
    str	x19,	[sp, fp]

    movz	fp,	#716
    add	x19,	sp,	#268
    str	x19,	[sp, fp]

    movz	fp,	#724
    add	x19,	sp,	#272
    str	x19,	[sp, fp]

    movz	fp,	#732
    add	x19,	sp,	#276
    str	x19,	[sp, fp]

    movz	fp,	#740
    add	x19,	sp,	#280
    str	x19,	[sp, fp]

    movz	fp,	#748
    add	x19,	sp,	#284
    str	x19,	[sp, fp]

    movz	fp,	#756
    add	x19,	sp,	#288
    str	x19,	[sp, fp]

    movz	fp,	#764
    add	x19,	sp,	#292
    str	x19,	[sp, fp]

    movz	fp,	#772
    add	x19,	sp,	#296
    str	x19,	[sp, fp]

    movz	fp,	#780
    add	x19,	sp,	#300
    str	x19,	[sp, fp]

    movz	fp,	#788
    add	x19,	sp,	#304
    str	x19,	[sp, fp]

    movz	fp,	#796
    add	x19,	sp,	#308
    str	x19,	[sp, fp]

    movz	fp,	#804
    add	x19,	sp,	#312
    str	x19,	[sp, fp]

    movz	fp,	#812
    add	x19,	sp,	#316
    str	x19,	[sp, fp]

    movz	fp,	#820
    add	x19,	sp,	#320
    str	x19,	[sp, fp]

    movz	fp,	#828
    add	x19,	sp,	#324
    str	x19,	[sp, fp]

    movz	fp,	#836
    add	x19,	sp,	#328
    str	x19,	[sp, fp]

    movz	fp,	#844
    add	x19,	sp,	#332
    str	x19,	[sp, fp]

    movz	fp,	#852
    add	x19,	sp,	#336
    str	x19,	[sp, fp]

    movz	fp,	#860
    add	x19,	sp,	#340
    str	x19,	[sp, fp]

    movz	fp,	#868
    add	x19,	sp,	#344
    str	x19,	[sp, fp]

    movz	fp,	#876
    add	x19,	sp,	#348
    str	x19,	[sp, fp]

    movz	fp,	#884
    add	x19,	sp,	#352
    str	x19,	[sp, fp]

    movz	fp,	#892
    add	x19,	sp,	#356
    str	x19,	[sp, fp]

    movz	fp,	#900
    add	x19,	sp,	#360
    str	x19,	[sp, fp]

    movz	fp,	#908
    add	x19,	sp,	#364
    str	x19,	[sp, fp]

    movz	fp,	#916
    add	x19,	sp,	#368
    str	x19,	[sp, fp]

    movz	fp,	#924
    add	x19,	sp,	#372
    str	x19,	[sp, fp]

    movz	fp,	#932
    add	x19,	sp,	#376
    str	x19,	[sp, fp]

    movz	fp,	#940
    add	x19,	sp,	#380
    str	x19,	[sp, fp]

    movz	fp,	#948
    add	x19,	sp,	#384
    str	x19,	[sp, fp]

    movz	fp,	#956
    add	x19,	sp,	#388
    str	x19,	[sp, fp]

    movz	fp,	#964
    add	x19,	sp,	#392
    str	x19,	[sp, fp]

    movz	fp,	#972
    add	x19,	sp,	#396
    str	x19,	[sp, fp]

    movz	fp,	#980
    add	x19,	sp,	#400
    str	x19,	[sp, fp]

    movz	fp,	#988
    add	x19,	sp,	#404
    str	x19,	[sp, fp]

    movz	fp,	#996
    add	x19,	sp,	#408
    str	x19,	[sp, fp]

    movz	fp,	#1004
    add	x19,	sp,	#412
    str	x19,	[sp, fp]

    movz	w19,	#0
    str	w19,	[sp, #1016]

    movz	w19,	#0
    str	w19,	[sp, #1012]


main_113:
    ldr	w19,	[sp, #1024]

    cmp	w19,	#1
    ble	main_413

main_117:
    movz	w19,	#1
    movz	fp,	#1652
    ldr	x15,	[sp, fp]

    str	w19,	[x15]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#2
    ble	main_413

main_119:
    movz	w19,	#2
    movz	fp,	#1036
    ldr	x28,	[sp, fp]

    str	w19,	[x28]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#3
    ble	main_413

main_121:
    movz	w19,	#3
    movz	fp,	#1636
    ldr	x9,	[sp, fp]

    str	w19,	[x9]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#4
    ble	main_413

main_123:
    movz	w19,	#4
    movz	fp,	#1596
    ldr	x24,	[sp, fp]

    str	w19,	[x24]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#5
    ble	main_413

main_125:
    movz	w19,	#5
    movz	fp,	#1628
    ldr	x6,	[sp, fp]

    str	w19,	[x6]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#6
    ble	main_413

main_127:
    movz	w19,	#6
    movz	fp,	#1068
    ldr	x10,	[sp, fp]

    str	w19,	[x10]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#7
    ble	main_413

main_129:
    movz	w19,	#7
    movz	fp,	#1204
    ldr	x25,	[sp, fp]

    str	w19,	[x25]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#8
    ble	main_413

main_131:
    movz	w19,	#8
    movz	fp,	#1604
    ldr	x27,	[sp, fp]

    str	w19,	[x27]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#9
    ble	main_413

main_133:
    movz	w19,	#9
    movz	fp,	#1044
    ldr	x1,	[sp, fp]

    str	w19,	[x1]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#10
    ble	main_413

main_135:
    movz	w19,	#10
    movz	fp,	#1692
    ldr	x2,	[sp, fp]

    str	w19,	[x2]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#11
    ble	main_413

main_137:
    movz	w19,	#11
    movz	fp,	#1612
    ldr	x0,	[sp, fp]

    str	w19,	[x0]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#12
    ble	main_413

main_139:
    movz	w19,	#12
    movz	fp,	#1572
    ldr	x13,	[sp, fp]

    str	w19,	[x13]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#13
    ble	main_413

main_141:
    movz	w19,	#13
    movz	fp,	#1164
    ldr	x8,	[sp, fp]

    str	w19,	[x8]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#14
    ble	main_413

main_143:
    movz	w19,	#14
    movz	fp,	#1052
    ldr	x4,	[sp, fp]

    str	w19,	[x4]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#15
    ble	main_413

main_145:
    movz	w19,	#15
    movz	fp,	#1620
    ldr	x3,	[sp, fp]

    str	w19,	[x3]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#16
    ble	main_413

main_147:
    movz	w19,	#16
    movz	fp,	#1188
    ldr	x17,	[sp, fp]

    str	w19,	[x17]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#17
    ble	main_413

main_149:
    movz	w19,	#17
    movz	fp,	#1676
    ldr	x26,	[sp, fp]

    str	w19,	[x26]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#18
    ble	main_413

main_151:
    movz	w19,	#18
    movz	fp,	#1684
    ldr	x0,	[sp, fp]

    str	w19,	[x0]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#19
    ble	main_413

main_153:
    movz	w19,	#19
    movz	fp,	#1700
    ldr	x5,	[sp, fp]

    str	w19,	[x5]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#20
    ble	main_413

main_155:
    movz	w19,	#20
    movz	fp,	#1588
    ldr	x21,	[sp, fp]

    str	w19,	[x21]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#21
    ble	main_413

main_157:
    movz	w19,	#21
    movz	fp,	#1580
    ldr	x16,	[sp, fp]

    str	w19,	[x16]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#22
    ble	main_413

main_159:
    movz	w19,	#22
    movz	fp,	#1180
    ldr	x14,	[sp, fp]

    str	w19,	[x14]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#23
    ble	main_413

main_161:
    movz	w19,	#23
    movz	fp,	#1060
    ldr	x7,	[sp, fp]

    str	w19,	[x7]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#24
    ble	main_413

main_163:
    movz	w19,	#24
    movz	fp,	#1644
    ldr	x12,	[sp, fp]

    str	w19,	[x12]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#25
    ble	main_413

main_165:
    movz	w19,	#25
    movz	fp,	#1196
    ldr	x22,	[sp, fp]

    str	w19,	[x22]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#26
    ble	main_413

main_167:
    movz	w19,	#26
    movz	fp,	#1660
    ldr	x18,	[sp, fp]

    str	w19,	[x18]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#27
    ble	main_413

main_169:
    movz	w19,	#27
    movz	fp,	#1172
    ldr	x11,	[sp, fp]

    str	w19,	[x11]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#28
    ble	main_413

main_171:
    movz	w19,	#28
    movz	fp,	#1668
    ldr	x23,	[sp, fp]

    str	w19,	[x23]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#29
    ble	main_413

main_173:
    movz	w19,	#29
    movz	fp,	#460
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2944]

    ldr	x22,	[sp, #2944]

    str	w19,	[x22]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#30
    ble	main_413

main_175:
    movz	w19,	#30
    ldr	x24,	[sp, #440]

    str	x24,	[sp, #2952]

    ldr	x25,	[sp, #2952]

    str	w19,	[x25]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#31
    ble	main_413

main_177:
    movz	w19,	#31
    ldr	x27,	[sp, #448]

    str	x27,	[sp, #2960]

    ldr	x28,	[sp, #2960]

    str	w19,	[x28]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#32
    ble	main_413

main_179:
    movz	w19,	#32
    ldr	x1,	[sp, #480]

    mov	w21,	w19
    str	x1,	[sp, #2968]

    ldr	x2,	[sp, #2968]

    str	w21,	[x2]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#33
    ble	main_413

main_181:
    movz	w19,	#33
    ldr	x4,	[sp, #488]

    movz	fp,	#2772
    mov	w21,	w19
    str	x4,	[sp, fp]

    movz	fp,	#2772
    ldr	x5,	[sp, fp]

    str	w21,	[x5]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#34
    ble	main_413

main_183:
    movz	w19,	#34
    ldr	x4,	[sp, #496]

    movz	fp,	#1812
    mov	w21,	w19
    str	x4,	[sp, fp]

    movz	fp,	#1812
    ldr	x5,	[sp, fp]

    str	w21,	[x5]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#35
    ble	main_413

main_185:
    movz	w19,	#35
    ldr	x1,	[sp, #504]

    movz	fp,	#1804
    mov	w21,	w19
    str	x1,	[sp, fp]

    movz	fp,	#1804
    ldr	x2,	[sp, fp]

    str	w21,	[x2]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#36
    ble	main_413

main_187:
    movz	w19,	#36
    ldr	x27,	[sp, #512]

    movz	fp,	#1796
    str	x27,	[sp, fp]

    movz	fp,	#1796
    ldr	x28,	[sp, fp]

    str	w19,	[x28]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#37
    ble	main_413

main_189:
    movz	w19,	#37
    ldr	x24,	[sp, #520]

    movz	fp,	#1788
    str	x24,	[sp, fp]

    movz	fp,	#1788
    ldr	x25,	[sp, fp]

    str	w19,	[x25]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#38
    ble	main_413

main_191:
    movz	w19,	#38
    movz	fp,	#604
    ldr	x21,	[sp, fp]

    movz	fp,	#1780
    str	x21,	[sp, fp]

    movz	fp,	#1780
    ldr	x22,	[sp, fp]

    str	w19,	[x22]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#39
    ble	main_413

main_193:
    movz	w19,	#39
    movz	fp,	#612
    mov	w21,	w19
    ldr	x18,	[sp, fp]

    movz	fp,	#1772
    str	x18,	[sp, fp]

    movz	fp,	#1772
    ldr	x19,	[sp, fp]

    str	w21,	[x19]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#40
    ble	main_413

main_195:
    movz	w19,	#40
    movz	fp,	#620
    mov	w21,	w19
    ldr	x15,	[sp, fp]

    movz	fp,	#1764
    str	x15,	[sp, fp]

    movz	fp,	#1764
    ldr	x16,	[sp, fp]

    str	w21,	[x16]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#41
    ble	main_413

main_197:
    movz	w19,	#41
    movz	fp,	#628
    mov	w21,	w19
    ldr	x12,	[sp, fp]

    movz	fp,	#1756
    str	x12,	[sp, fp]

    movz	fp,	#1756
    ldr	x13,	[sp, fp]

    str	w21,	[x13]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#42
    ble	main_413

main_199:
    movz	w19,	#42
    movz	fp,	#636
    mov	w21,	w19
    ldr	x9,	[sp, fp]

    movz	fp,	#1748
    str	x9,	[sp, fp]

    movz	fp,	#1748
    ldr	x10,	[sp, fp]

    str	w21,	[x10]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#43
    ble	main_413

main_201:
    movz	w19,	#43
    movz	fp,	#644
    mov	w21,	w19
    ldr	x6,	[sp, fp]

    movz	fp,	#1732
    str	x6,	[sp, fp]

    movz	fp,	#1732
    ldr	x7,	[sp, fp]

    str	w21,	[x7]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#44
    ble	main_413

main_203:
    movz	w19,	#44
    movz	fp,	#652
    mov	w21,	w19
    ldr	x3,	[sp, fp]

    movz	fp,	#1724
    str	x3,	[sp, fp]

    movz	fp,	#1724
    ldr	x4,	[sp, fp]

    str	w21,	[x4]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#45
    ble	main_413

main_205:
    movz	w19,	#45
    movz	fp,	#532
    mov	w21,	w19
    ldr	x0,	[sp, fp]

    movz	fp,	#1716
    str	x0,	[sp, fp]

    movz	fp,	#1716
    ldr	x1,	[sp, fp]

    str	w21,	[x1]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#46
    ble	main_413

main_207:
    movz	w19,	#46
    movz	fp,	#540
    ldr	x26,	[sp, fp]

    movz	fp,	#1708
    str	x26,	[sp, fp]

    movz	fp,	#1708
    ldr	x27,	[sp, fp]

    str	w19,	[x27]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#47
    ble	main_413

main_209:
    movz	w19,	#47
    movz	fp,	#548
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #3136]

    ldr	x24,	[sp, #3136]

    str	w19,	[x24]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#48
    ble	main_413

main_211:
    movz	w19,	#48
    movz	fp,	#556
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #3128]

    ldr	x21,	[sp, #3128]

    str	w19,	[x21]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#49
    ble	main_413

main_213:
    movz	w19,	#49
    movz	fp,	#564
    mov	w21,	w19
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #3120]

    ldr	x18,	[sp, #3120]

    str	w21,	[x18]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#50
    ble	main_413

main_215:
    movz	w19,	#50
    movz	fp,	#572
    mov	w21,	w19
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #3112]

    ldr	x15,	[sp, #3112]

    str	w21,	[x15]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#51
    ble	main_413

main_217:
    movz	w19,	#51
    movz	fp,	#580
    mov	w21,	w19
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #3104]

    ldr	x12,	[sp, #3104]

    str	w21,	[x12]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#52
    ble	main_413

main_219:
    movz	w19,	#52
    movz	fp,	#596
    mov	w21,	w19
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #3096]

    ldr	x9,	[sp, #3096]

    str	w21,	[x9]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#53
    ble	main_413

main_221:
    movz	w19,	#53
    movz	fp,	#660
    mov	w21,	w19
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #3088]

    ldr	x6,	[sp, #3088]

    str	w21,	[x6]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#54
    ble	main_413

main_223:
    movz	w19,	#54
    movz	fp,	#588
    mov	w21,	w19
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #3080]

    ldr	x3,	[sp, #3080]

    str	w21,	[x3]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#55
    ble	main_413

main_225:
    movz	w19,	#55
    ldr	x28,	[sp, #416]

    mov	w20,	w19
    str	x28,	[sp, #3072]

    ldr	x0,	[sp, #3072]

    str	w20,	[x0]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#56
    ble	main_413

main_227:
    movz	w19,	#56
    ldr	x25,	[sp, #424]

    str	x25,	[sp, #3064]

    ldr	x26,	[sp, #3064]

    str	w19,	[x26]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#57
    ble	main_413

main_229:
    movz	w19,	#57
    movz	fp,	#668
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #3056]

    ldr	x23,	[sp, #3056]

    str	w19,	[x23]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#58
    ble	main_413

main_231:
    movz	w19,	#58
    movz	fp,	#676
    mov	w21,	w19
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3048]

    ldr	x20,	[sp, #3048]

    str	w21,	[x20]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#59
    ble	main_413

main_233:
    movz	w19,	#59
    movz	fp,	#684
    mov	w21,	w19
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3040]

    ldr	x17,	[sp, #3040]

    str	w21,	[x17]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#60
    ble	main_413

main_235:
    movz	w19,	#60
    movz	fp,	#692
    mov	w21,	w19
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3032]

    ldr	x14,	[sp, #3032]

    str	w21,	[x14]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#61
    ble	main_413

main_237:
    movz	w19,	#61
    movz	fp,	#700
    mov	w21,	w19
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #3024]

    ldr	x11,	[sp, #3024]

    str	w21,	[x11]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#62
    ble	main_413

main_239:
    movz	w19,	#62
    movz	fp,	#708
    mov	w21,	w19
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #3016]

    ldr	x8,	[sp, #3016]

    str	w21,	[x8]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#63
    ble	main_413

main_241:
    movz	w19,	#63
    movz	fp,	#716
    mov	w21,	w19
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3008]

    ldr	x5,	[sp, #3008]

    str	w21,	[x5]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#64
    ble	main_413

main_243:
    movz	w19,	#64
    movz	fp,	#724
    mov	w21,	w19
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3000]

    ldr	x2,	[sp, #3000]

    str	w21,	[x2]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#65
    ble	main_413

main_245:
    movz	w19,	#65
    movz	fp,	#732
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2992]

    ldr	x28,	[sp, #2992]

    str	w19,	[x28]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#66
    ble	main_413

main_247:
    movz	w19,	#66
    movz	fp,	#740
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2984]

    ldr	x25,	[sp, #2984]

    str	w19,	[x25]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#67
    ble	main_413

main_249:
    movz	w19,	#67
    movz	fp,	#748
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3280]

    ldr	x22,	[sp, #3280]

    str	w19,	[x22]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#68
    ble	main_413

main_251:
    movz	w19,	#68
    movz	fp,	#756
    mov	w21,	w19
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #3272]

    ldr	x19,	[sp, #3272]

    str	w21,	[x19]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#69
    ble	main_413

main_253:
    movz	w19,	#69
    movz	fp,	#764
    mov	w21,	w19
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #3256]

    ldr	x16,	[sp, #3256]

    str	w21,	[x16]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#70
    ble	main_413

main_255:
    movz	w19,	#70
    movz	fp,	#772
    mov	w21,	w19
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #3248]

    ldr	x13,	[sp, #3248]

    str	w21,	[x13]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#71
    ble	main_413

main_257:
    movz	w19,	#71
    movz	fp,	#780
    mov	w21,	w19
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #3240]

    ldr	x10,	[sp, #3240]

    str	w21,	[x10]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#72
    ble	main_413

main_259:
    movz	w19,	#72
    movz	fp,	#788
    mov	w21,	w19
    ldr	x6,	[sp, fp]

    str	x6,	[sp, #3232]

    ldr	x7,	[sp, #3232]

    str	w21,	[x7]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#73
    ble	main_413

main_261:
    movz	w19,	#73
    movz	fp,	#796
    mov	w21,	w19
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #3224]

    ldr	x4,	[sp, #3224]

    str	w21,	[x4]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#74
    ble	main_413

main_263:
    movz	w19,	#74
    movz	fp,	#804
    mov	w21,	w19
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #3216]

    ldr	x1,	[sp, #3216]

    str	w21,	[x1]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#75
    ble	main_413

main_265:
    movz	w19,	#75
    movz	fp,	#812
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #3208]

    ldr	x27,	[sp, #3208]

    str	w19,	[x27]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#76
    ble	main_413

main_267:
    movz	w19,	#76
    movz	fp,	#820
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #3200]

    ldr	x24,	[sp, #3200]

    str	w19,	[x24]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#77
    ble	main_413

main_269:
    movz	w19,	#77
    movz	fp,	#828
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #3192]

    ldr	x21,	[sp, #3192]

    str	w19,	[x21]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#78
    ble	main_413

main_271:
    movz	w19,	#78
    movz	fp,	#836
    mov	w21,	w19
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #3184]

    ldr	x18,	[sp, #3184]

    str	w21,	[x18]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#79
    ble	main_413

main_273:
    movz	w19,	#79
    movz	fp,	#844
    mov	w21,	w19
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #3176]

    ldr	x15,	[sp, #3176]

    str	w21,	[x15]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#80
    ble	main_413

main_275:
    movz	w19,	#80
    movz	fp,	#852
    mov	w21,	w19
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #3168]

    ldr	x12,	[sp, #3168]

    str	w21,	[x12]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#81
    ble	main_413

main_277:
    movz	w19,	#81
    movz	fp,	#860
    mov	w21,	w19
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #3160]

    ldr	x9,	[sp, #3160]

    str	w21,	[x9]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#82
    ble	main_413

main_279:
    movz	w19,	#82
    movz	fp,	#868
    mov	w21,	w19
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #3152]

    ldr	x6,	[sp, #3152]

    str	w21,	[x6]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#83
    ble	main_413

main_281:
    movz	w19,	#83
    movz	fp,	#876
    mov	w21,	w19
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #3144]

    ldr	x3,	[sp, #3144]

    str	w21,	[x3]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#84
    ble	main_413

main_283:
    movz	w19,	#84
    movz	fp,	#884
    mov	w20,	w19
    ldr	x28,	[sp, fp]

    str	x28,	[sp, #2744]

    ldr	x0,	[sp, #2744]

    str	w20,	[x0]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#85
    ble	main_413

main_285:
    movz	w19,	#85
    movz	fp,	#892
    ldr	x25,	[sp, fp]

    str	x25,	[sp, #2736]

    ldr	x26,	[sp, #2736]

    str	w19,	[x26]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#86
    ble	main_413

main_287:
    movz	w19,	#86
    movz	fp,	#900
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #2728]

    ldr	x23,	[sp, #2728]

    str	w19,	[x23]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#87
    ble	main_413

main_289:
    movz	w19,	#87
    movz	fp,	#908
    mov	w21,	w19
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #2720]

    ldr	x20,	[sp, #2720]

    str	w21,	[x20]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#88
    ble	main_413

main_291:
    movz	w19,	#88
    movz	fp,	#916
    mov	w21,	w19
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #2712]

    ldr	x17,	[sp, #2712]

    str	w21,	[x17]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#89
    ble	main_413

main_293:
    movz	w19,	#89
    movz	fp,	#924
    mov	w21,	w19
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #2704]

    ldr	x14,	[sp, #2704]

    str	w21,	[x14]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#90
    ble	main_413

main_295:
    movz	w19,	#90
    movz	fp,	#932
    mov	w21,	w19
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #2696]

    ldr	x11,	[sp, #2696]

    str	w21,	[x11]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#91
    ble	main_413

main_297:
    movz	w19,	#91
    movz	fp,	#940
    mov	w21,	w19
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #2688]

    ldr	x8,	[sp, #2688]

    str	w21,	[x8]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#92
    ble	main_413

main_299:
    movz	w19,	#92
    movz	fp,	#948
    mov	w21,	w19
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #2680]

    ldr	x5,	[sp, #2680]

    str	w21,	[x5]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#93
    ble	main_413

main_301:
    movz	w19,	#93
    movz	fp,	#956
    mov	w21,	w19
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #2520]

    ldr	x2,	[sp, #2520]

    str	w21,	[x2]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#94
    ble	main_413

main_303:
    movz	w19,	#94
    movz	fp,	#964
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2512]

    ldr	x28,	[sp, #2512]

    str	w19,	[x28]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#95
    ble	main_413

main_305:
    movz	w19,	#95
    movz	fp,	#972
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2504]

    ldr	x25,	[sp, #2504]

    str	w19,	[x25]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#96
    ble	main_413

main_307:
    movz	w19,	#96
    movz	fp,	#980
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2496]

    ldr	x22,	[sp, #2496]

    str	w19,	[x22]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#97
    ble	main_413

main_309:
    movz	w19,	#97
    movz	fp,	#988
    mov	w21,	w19
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #2488]

    ldr	x19,	[sp, #2488]

    str	w21,	[x19]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#98
    ble	main_413

main_311:
    movz	w19,	#98
    movz	fp,	#996
    mov	w21,	w19
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #2480]

    ldr	x16,	[sp, #2480]

    str	w21,	[x16]

    ldr	w19,	[sp, #1024]

    cmp	w19,	#99
    ble	main_413

main_313:
    movz	w19,	#99
    movz	fp,	#1004
    mov	w21,	w19
    ldr	x12,	[sp, fp]

    movz	fp,	#468
    str	x12,	[sp, fp]

    movz	fp,	#468
    ldr	x13,	[sp, fp]

    str	w21,	[x13]


main_413:
    ldr	w19,	[sp, #1012]

    add	w19,	w19,	#1
    str	w19,	[sp, #476]

    ldr	w19,	[sp, #1016]

    str	w19,	[sp, #436]

    movz	w19,	#0
    str	w19,	[sp, #528]


main_415:
    ldr	w19,	[sp, #528]

    cmp	w19,	#100
    bge	main_424

main_419:
    ldr	w19,	[sp, #528]

    lsl	w19,	w19,	#2
    mov	x19,	x19
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    ldr	w21,	[x19]

    ldr	w13,	[sp, #436]

    str	w13,	[sp, #2756]

    ldr	w14,	[sp, #2756]

    ldr	w10,	[sp, #528]

    add	w23,	w21,	w14
    str	w10,	[sp, #2752]

    mov	w19,	w23
    ldr	w11,	[sp, #2752]

    add	w4,	w11,	#1
    str	w4,	[sp, #2472]

    ldr	w5,	[sp, #2472]

    str	w5,	[sp, #432]

    str	w19,	[sp, #436]

    ldr	w19,	[sp, #432]

    str	w19,	[sp, #528]

    b	main_415

main_424:
    movz	w19,	#65535
    ldr	w16,	[sp, #436]

    mov	w21,	w19
    str	w16,	[sp, #2760]

    ldr	w17,	[sp, #2760]

    sdiv	w19,	w17,	w21
    str	w19,	[sp, #456]

    ldr	w19,	[sp, #456]

    ldr	w7,	[sp, #456]

    lsl	w21,	w19,	#16
    str	w7,	[sp, #2476]

    ldr	w8,	[sp, #2476]

    ldr	w19,	[sp, #436]

    sub	w21,	w21,	w8,	lsl #0
    str	w19,	[sp, #2764]

    ldr	w20,	[sp, #2764]

    ldr	w7,	[sp, #476]

    sub	w23,	w20,	w21
    str	w7,	[sp, #1820]

    ldr	w22,	[sp, #1020]

    str	w22,	[sp, #2768]

    ldr	w8,	[sp, #1820]

    ldr	w0,	[sp, #2768]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w19,	w23
    str	w19,	[sp, #1016]

    ldr	w19,	[sp, #476]

    str	w19,	[sp, #1012]

    b	main_113

main_428:
    mov	w0,	w23
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


