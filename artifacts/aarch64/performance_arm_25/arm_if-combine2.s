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
    str	w0,	[sp, #1140]

    bl	getint
    str	w0,	[sp, #1144]

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
    ldr	w15,	[sp, #1140]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x10,	sp,	#20
    movz	fp,	#1548
    add	x5,	sp,	#24
    add	x20,	sp,	#28
    add	x9,	sp,	#32
    add	x19,	sp,	#36
    add	x21,	sp,	#40
    add	x11,	sp,	#44
    add	x6,	sp,	#48
    add	x22,	sp,	#52
    add	x28,	sp,	#56
    add	x7,	sp,	#60
    add	x0,	sp,	#64
    add	x1,	sp,	#68
    add	x23,	sp,	#72
    add	x26,	sp,	#76
    add	x24,	sp,	#80
    add	x8,	sp,	#84
    add	x15,	sp,	#88
    add	x18,	sp,	#92
    add	x17,	sp,	#96
    add	x13,	sp,	#100
    add	x27,	sp,	#104
    add	x4,	sp,	#108
    add	x14,	sp,	#112
    add	x16,	sp,	#116
    add	x2,	sp,	#120
    add	x25,	sp,	#124
    add	x3,	sp,	#128
    str	x10,	[sp, fp]

    movz	fp,	#1612
    str	x5,	[sp, fp]

    movz	fp,	#1652
    str	x20,	[sp, fp]

    movz	fp,	#1700
    str	x9,	[sp, fp]

    movz	fp,	#1572
    str	x19,	[sp, fp]

    movz	fp,	#1180
    str	x21,	[sp, fp]

    add	x21,	sp,	#136
    movz	fp,	#1628
    str	x11,	[sp, fp]

    movz	fp,	#1692
    str	x6,	[sp, fp]

    movz	fp,	#1580
    str	x22,	[sp, fp]

    movz	fp,	#1596
    str	x28,	[sp, fp]

    movz	fp,	#1540
    str	x7,	[sp, fp]

    movz	fp,	#1676
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#1204
    str	x1,	[sp, fp]

    movz	fp,	#1660
    str	x23,	[sp, fp]

    movz	fp,	#1668
    str	x26,	[sp, fp]

    movz	fp,	#1188
    str	x24,	[sp, fp]

    movz	fp,	#1620
    str	x8,	[sp, fp]

    movz	fp,	#1164
    str	x15,	[sp, fp]

    movz	fp,	#1172
    str	x18,	[sp, fp]

    movz	fp,	#1644
    str	x17,	[sp, fp]

    movz	fp,	#1556
    str	x13,	[sp, fp]

    movz	fp,	#1196
    str	x27,	[sp, fp]

    movz	fp,	#1532
    str	x4,	[sp, fp]

    movz	fp,	#1636
    str	x14,	[sp, fp]

    movz	fp,	#1564
    str	x16,	[sp, fp]

    movz	fp,	#1604
    str	x2,	[sp, fp]

    movz	fp,	#1588
    str	x25,	[sp, fp]

    movz	fp,	#1684
    str	x3,	[sp, fp]

    movz	fp,	#684
    str	x0,	[sp, #464]

    add	x0,	sp,	#140
    str	x21,	[sp, #440]

    add	x21,	sp,	#144
    str	x0,	[sp, #448]

    add	x0,	sp,	#148
    str	x21,	[sp, fp]

    add	x21,	sp,	#152
    movz	fp,	#692
    str	x0,	[sp, fp]

    add	x0,	sp,	#156
    movz	fp,	#540
    str	x21,	[sp, fp]

    add	x21,	sp,	#164
    movz	fp,	#548
    str	x0,	[sp, fp]

    movz	fp,	#556
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    movz	fp,	#700
    add	x0,	sp,	#168
    str	x21,	[sp, #480]

    add	x21,	sp,	#172
    str	x0,	[sp, #488]

    add	x0,	sp,	#176
    str	x21,	[sp, #496]

    add	x21,	sp,	#180
    str	x0,	[sp, #504]

    add	x0,	sp,	#184
    str	x21,	[sp, #512]

    add	x21,	sp,	#188
    str	x0,	[sp, #520]

    add	x0,	sp,	#192
    str	x21,	[sp, #528]

    add	x21,	sp,	#200
    str	x0,	[sp, fp]

    movz	fp,	#708
    add	x0,	sp,	#196
    str	x0,	[sp, fp]

    add	x0,	sp,	#204
    movz	fp,	#716
    str	x21,	[sp, fp]

    add	x21,	sp,	#208
    movz	fp,	#724
    str	x0,	[sp, fp]

    add	x0,	sp,	#212
    movz	fp,	#732
    str	x21,	[sp, fp]

    add	x21,	sp,	#216
    movz	fp,	#740
    str	x0,	[sp, fp]

    add	x0,	sp,	#220
    movz	fp,	#748
    str	x21,	[sp, fp]

    add	x21,	sp,	#224
    movz	fp,	#756
    str	x0,	[sp, fp]

    add	x0,	sp,	#228
    movz	fp,	#764
    str	x21,	[sp, fp]

    add	x21,	sp,	#232
    movz	fp,	#772
    str	x0,	[sp, fp]

    add	x0,	sp,	#240
    movz	fp,	#780
    str	x21,	[sp, fp]

    movz	fp,	#788
    add	x21,	sp,	#236
    str	x21,	[sp, #416]

    add	x21,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x21,	[sp, fp]

    add	x21,	sp,	#252
    movz	fp,	#796
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#804
    str	x21,	[sp, fp]

    add	x21,	sp,	#260
    movz	fp,	#812
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#820
    str	x21,	[sp, fp]

    add	x21,	sp,	#268
    movz	fp,	#828
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#836
    str	x21,	[sp, fp]

    add	x21,	sp,	#280
    movz	fp,	#844
    str	x0,	[sp, fp]

    movz	fp,	#852
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#860
    str	x21,	[sp, fp]

    add	x21,	sp,	#288
    movz	fp,	#868
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#876
    str	x21,	[sp, fp]

    add	x21,	sp,	#296
    movz	fp,	#884
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#892
    str	x21,	[sp, fp]

    add	x21,	sp,	#304
    movz	fp,	#900
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#908
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#916
    str	x0,	[sp, fp]

    movz	fp,	#924
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#932
    str	x21,	[sp, fp]

    add	x21,	sp,	#324
    movz	fp,	#940
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#948
    str	x21,	[sp, fp]

    add	x21,	sp,	#332
    movz	fp,	#956
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#964
    str	x21,	[sp, fp]

    add	x21,	sp,	#340
    movz	fp,	#972
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#980
    str	x21,	[sp, fp]

    add	x21,	sp,	#348
    movz	fp,	#988
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#996
    str	x21,	[sp, fp]

    movz	fp,	#1004
    add	x21,	sp,	#352
    str	x21,	[sp, fp]

    add	x21,	sp,	#360
    movz	fp,	#1012
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#1020
    str	x21,	[sp, fp]

    add	x21,	sp,	#368
    movz	fp,	#1028
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#1036
    str	x21,	[sp, fp]

    add	x21,	sp,	#376
    movz	fp,	#1044
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#1052
    str	x21,	[sp, fp]

    add	x21,	sp,	#384
    movz	fp,	#1060
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#1068
    str	x21,	[sp, fp]

    add	x21,	sp,	#396
    movz	fp,	#1076
    str	x0,	[sp, fp]

    movz	fp,	#1084
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1092
    str	x21,	[sp, fp]

    add	x21,	sp,	#404
    movz	fp,	#1100
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1108
    str	x21,	[sp, fp]

    add	x21,	sp,	#412
    movz	fp,	#1116
    str	x0,	[sp, fp]

    movz	w0,	#0
    movz	fp,	#1124
    str	x21,	[sp, fp]

    str	w0,	[sp, #1136]

    movz	w0,	#0
    str	w0,	[sp, #1132]


main_113:
    ldr	w0,	[sp, #1144]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w0,	#1
    movz	fp,	#1548
    ldr	x6,	[sp, fp]

    str	w0,	[x6]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#2
    ble	main_413

main_119:
    movz	w21,	#2
    movz	fp,	#1612
    mov	w0,	w21
    ldr	x2,	[sp, fp]

    str	w0,	[x2]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w0,	#3
    movz	fp,	#1652
    mov	w21,	w0
    ldr	x15,	[sp, fp]

    str	w21,	[x15]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1700
    mov	w21,	w0
    ldr	x5,	[sp, fp]

    str	w21,	[x5]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w0,	#5
    movz	fp,	#1572
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#6
    ble	main_413

main_127:
    movz	w21,	#6
    movz	fp,	#1180
    ldr	x14,	[sp, fp]

    str	w21,	[x14]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w21,	#7
    movz	fp,	#1628
    mov	w0,	w21
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    movz	fp,	#1692
    mov	w21,	w0
    ldr	x2,	[sp, fp]

    str	w21,	[x2]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w21,	#9
    movz	fp,	#1580
    mov	w0,	w21
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#10
    ble	main_413

main_135:
    movz	w0,	#10
    movz	fp,	#1596
    ldr	x24,	[sp, fp]

    str	w0,	[x24]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w21,	#11
    movz	fp,	#1540
    mov	w0,	w21
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#12
    ble	main_413

main_139:
    movz	w0,	#12
    movz	fp,	#1676
    mov	w21,	w0
    ldr	x26,	[sp, fp]

    str	w21,	[x26]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1204
    mov	w21,	w0
    ldr	x25,	[sp, fp]

    str	w21,	[x25]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#14
    ble	main_413

main_143:
    movz	w0,	#14
    movz	fp,	#1660
    ldr	x20,	[sp, fp]

    str	w0,	[x20]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w21,	#15
    movz	fp,	#1668
    ldr	x23,	[sp, fp]

    str	w21,	[x23]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#16
    ble	main_413

main_147:
    movz	w21,	#16
    movz	fp,	#1188
    mov	w0,	w21
    ldr	x19,	[sp, fp]

    str	w0,	[x19]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    movz	fp,	#1620
    mov	w21,	w0
    ldr	x3,	[sp, fp]

    str	w21,	[x3]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#18
    ble	main_413

main_151:
    movz	w21,	#18
    movz	fp,	#1164
    mov	w0,	w21
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w0,	#19
    movz	fp,	#1172
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#20
    ble	main_413

main_155:
    movz	w21,	#20
    movz	fp,	#1644
    mov	w0,	w21
    ldr	x14,	[sp, fp]

    str	w0,	[x14]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w0,	#21
    movz	fp,	#1556
    mov	w21,	w0
    ldr	x7,	[sp, fp]

    str	w21,	[x7]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1196
    mov	w21,	w0
    ldr	x22,	[sp, fp]

    str	w21,	[x22]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w0,	#23
    movz	fp,	#1532
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#24
    ble	main_413

main_163:
    movz	w21,	#24
    movz	fp,	#1636
    ldr	x9,	[sp, fp]

    str	w21,	[x9]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w21,	#25
    movz	fp,	#1564
    mov	w0,	w21
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    movz	fp,	#1604
    mov	w21,	w0
    ldr	x27,	[sp, fp]

    str	w21,	[x27]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#27
    ble	main_413

main_169:
    movz	w21,	#27
    movz	fp,	#1588
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w0,	#28
    movz	fp,	#1684
    ldr	x1,	[sp, fp]

    str	w0,	[x1]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#29
    ble	main_413

main_173:
    movz	w21,	#29
    mov	w0,	w21
    ldr	x21,	[sp, #464]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w0,	#30
    ldr	x21,	[sp, #440]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    mov	w21,	w0
    ldr	x0,	[sp, #448]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w0,	#32
    movz	fp,	#684
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#33
    ble	main_413

main_181:
    movz	w21,	#33
    movz	fp,	#692
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w21,	#34
    movz	fp,	#540
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    movz	fp,	#548
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w21,	#36
    movz	fp,	#556
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#37
    ble	main_413

main_189:
    movz	w0,	#37
    mov	w21,	w0
    ldr	x0,	[sp, #480]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w21,	#38
    mov	w0,	w21
    ldr	x21,	[sp, #488]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#39
    ble	main_413

main_193:
    movz	w0,	#39
    mov	w21,	w0
    ldr	x0,	[sp, #496]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    ldr	x21,	[sp, #504]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#41
    ble	main_413

main_197:
    movz	w0,	#41
    ldr	x21,	[sp, #512]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w21,	#42
    ldr	x0,	[sp, #520]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#43
    ble	main_413

main_201:
    movz	w21,	#43
    mov	w0,	w21
    ldr	x21,	[sp, #528]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    movz	fp,	#700
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#45
    ble	main_413

main_205:
    movz	w21,	#45
    movz	fp,	#708
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w0,	#46
    movz	fp,	#716
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#47
    ble	main_413

main_209:
    movz	w21,	#47
    movz	fp,	#724
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w0,	#48
    movz	fp,	#732
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    movz	fp,	#740
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w0,	#50
    movz	fp,	#748
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#51
    ble	main_413

main_217:
    movz	w21,	#51
    movz	fp,	#756
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w21,	#52
    movz	fp,	#764
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    movz	fp,	#772
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w21,	#54
    movz	fp,	#780
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w0,	#55
    ldr	x21,	[sp, #416]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#56
    ble	main_413

main_227:
    movz	w21,	#56
    mov	w0,	w21
    ldr	x21,	[sp, #424]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w0,	#57
    movz	fp,	#788
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#796
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w0,	#59
    movz	fp,	#804
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#60
    ble	main_413

main_235:
    movz	w21,	#60
    movz	fp,	#812
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w21,	#61
    movz	fp,	#820
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    movz	fp,	#828
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w21,	#63
    movz	fp,	#836
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#64
    ble	main_413

main_243:
    movz	w0,	#64
    movz	fp,	#844
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w21,	#65
    movz	fp,	#852
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#66
    ble	main_413

main_247:
    movz	w0,	#66
    movz	fp,	#860
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#868
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#68
    ble	main_413

main_251:
    movz	w0,	#68
    movz	fp,	#876
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w21,	#69
    movz	fp,	#884
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#70
    ble	main_413

main_255:
    movz	w21,	#70
    movz	fp,	#892
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    movz	fp,	#900
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#72
    ble	main_413

main_259:
    movz	w21,	#72
    movz	fp,	#908
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w0,	#73
    movz	fp,	#916
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#74
    ble	main_413

main_263:
    movz	w21,	#74
    movz	fp,	#924
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w0,	#75
    movz	fp,	#932
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#940
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w0,	#77
    movz	fp,	#948
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#78
    ble	main_413

main_271:
    movz	w21,	#78
    movz	fp,	#956
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w21,	#79
    movz	fp,	#964
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    movz	fp,	#972
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w21,	#81
    movz	fp,	#980
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#82
    ble	main_413

main_279:
    movz	w0,	#82
    movz	fp,	#988
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w21,	#83
    movz	fp,	#996
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w0,	#84
    movz	fp,	#1004
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1012
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w0,	#86
    movz	fp,	#1020
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#87
    ble	main_413

main_289:
    movz	w21,	#87
    movz	fp,	#1028
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w21,	#88
    movz	fp,	#1036
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    movz	fp,	#1044
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w21,	#90
    movz	fp,	#1052
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#91
    ble	main_413

main_297:
    movz	w0,	#91
    movz	fp,	#1060
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w21,	#92
    movz	fp,	#1068
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#93
    ble	main_413

main_301:
    movz	w0,	#93
    movz	fp,	#1076
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1084
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#95
    ble	main_413

main_305:
    movz	w0,	#95
    movz	fp,	#1092
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w21,	#96
    movz	fp,	#1100
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#97
    ble	main_413

main_309:
    movz	w21,	#97
    movz	fp,	#1108
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1144]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    movz	fp,	#1116
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1144]

    cmp	w21,	#99
    ble	main_413

main_313:
    movz	w21,	#99
    movz	fp,	#1124
    mov	w0,	w21
    ldr	x21,	[sp, fp]

    str	w0,	[x21]


main_413:
    ldr	w21,	[sp, #1132]

    add	w0,	w21,	#1
    movz	w21,	#0
    str	w0,	[sp, #460]

    ldr	w0,	[sp, #1136]

    str	w0,	[sp, #476]

    str	w21,	[sp, #456]


main_415:
    ldr	w0,	[sp, #456]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w21,	[sp, #456]

    lsl	w0,	w21,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w21,	[sp, #476]

    add	w21,	w0,	w21
    ldr	w0,	[sp, #456]

    add	w0,	w0,	#1
    str	w0,	[sp, #536]

    mov	w0,	w21
    str	w0,	[sp, #476]

    ldr	w21,	[sp, #536]

    str	w21,	[sp, #456]

    b	main_415

main_424:
    movz	w0,	#65535
    ldr	w21,	[sp, #476]

    sdiv	w21,	w21,	w0
    str	w21,	[sp, #472]

    ldr	w0,	[sp, #472]

    lsl	w21,	w0,	#16
    ldr	w0,	[sp, #472]

    sub	w21,	w21,	w0,	lsl #0
    ldr	w0,	[sp, #476]

    ldr	w26,	[sp, #460]

    sub	w0,	w0,	w21
    str	w26,	[sp, #3120]

    ldr	w7,	[sp, #1140]

    str	w7,	[sp, #1964]

    ldr	w8,	[sp, #1964]

    ldr	w27,	[sp, #3120]

    cmp	w27,	w8
    bge	main_429

main_112:
    str	w0,	[sp, #1136]

    ldr	w0,	[sp, #460]

    str	w0,	[sp, #1132]

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


