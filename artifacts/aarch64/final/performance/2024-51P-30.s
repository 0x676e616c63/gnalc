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
    str	w0,	[sp, #1196]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1200]

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
    ldr	w15,	[sp, #1196]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x0,	sp,	#20
    movz	fp,	#1660
    add	x28,	sp,	#24
    add	x25,	sp,	#28
    add	x19,	sp,	#32
    add	x17,	sp,	#36
    add	x22,	sp,	#40
    add	x6,	sp,	#44
    add	x8,	sp,	#48
    add	x18,	sp,	#52
    add	x11,	sp,	#56
    add	x10,	sp,	#60
    add	x15,	sp,	#64
    add	x1,	sp,	#68
    add	x20,	sp,	#72
    add	x23,	sp,	#76
    add	x3,	sp,	#80
    add	x24,	sp,	#84
    add	x5,	sp,	#88
    add	x2,	sp,	#92
    add	x27,	sp,	#96
    add	x13,	sp,	#100
    add	x4,	sp,	#104
    add	x7,	sp,	#108
    add	x16,	sp,	#112
    add	x26,	sp,	#116
    add	x21,	sp,	#120
    add	x9,	sp,	#124
    add	x14,	sp,	#128
    str	x0,	[sp, fp]

    movz	fp,	#1580
    str	x28,	[sp, fp]

    movz	fp,	#1572
    str	x25,	[sp, fp]

    movz	fp,	#1548
    str	x19,	[sp, fp]

    movz	fp,	#1628
    str	x17,	[sp, fp]

    movz	fp,	#1556
    str	x22,	[sp, fp]

    movz	fp,	#1676
    str	x6,	[sp, fp]

    movz	fp,	#1604
    str	x8,	[sp, fp]

    movz	fp,	#1508
    str	x18,	[sp, fp]

    movz	fp,	#1612
    str	x11,	[sp, fp]

    movz	fp,	#1524
    str	x10,	[sp, fp]

    movz	fp,	#1500
    str	x15,	[sp, fp]

    movz	fp,	#1236
    str	x1,	[sp, fp]

    movz	fp,	#1636
    str	x20,	[sp, fp]

    movz	fp,	#1644
    str	x23,	[sp, fp]

    movz	fp,	#1668
    str	x3,	[sp, fp]

    movz	fp,	#1220
    str	x24,	[sp, fp]

    movz	fp,	#1596
    str	x5,	[sp, fp]

    movz	fp,	#1588
    str	x2,	[sp, fp]

    movz	fp,	#1228
    str	x27,	[sp, fp]

    movz	fp,	#1532
    str	x13,	[sp, fp]

    movz	fp,	#1244
    str	x4,	[sp, fp]

    movz	fp,	#1516
    str	x7,	[sp, fp]

    movz	fp,	#1540
    str	x16,	[sp, fp]

    movz	fp,	#1652
    str	x26,	[sp, fp]

    movz	fp,	#1212
    str	x21,	[sp, fp]

    add	x21,	sp,	#132
    movz	fp,	#1684
    str	x9,	[sp, fp]

    movz	fp,	#1620
    str	x14,	[sp, fp]

    movz	fp,	#508
    str	x21,	[sp, fp]

    movz	fp,	#500
    add	x21,	sp,	#136
    str	x21,	[sp, fp]

    movz	fp,	#516
    add	x21,	sp,	#140
    str	x21,	[sp, #760]

    add	x21,	sp,	#144
    str	x21,	[sp, #440]

    add	x21,	sp,	#148
    str	x21,	[sp, #448]

    add	x21,	sp,	#152
    str	x21,	[sp, #456]

    add	x21,	sp,	#156
    str	x21,	[sp, #464]

    add	x21,	sp,	#160
    str	x21,	[sp, #720]

    add	x21,	sp,	#164
    str	x21,	[sp, #728]

    add	x21,	sp,	#168
    str	x21,	[sp, #736]

    add	x21,	sp,	#172
    str	x21,	[sp, #744]

    add	x21,	sp,	#176
    str	x21,	[sp, #752]

    add	x21,	sp,	#180
    str	x21,	[sp, fp]

    movz	fp,	#524
    add	x21,	sp,	#184
    str	x21,	[sp, fp]

    movz	fp,	#532
    add	x21,	sp,	#188
    str	x21,	[sp, fp]

    movz	fp,	#540
    add	x21,	sp,	#192
    str	x21,	[sp, fp]

    movz	fp,	#548
    add	x21,	sp,	#196
    str	x21,	[sp, fp]

    movz	fp,	#772
    add	x21,	sp,	#200
    str	x21,	[sp, fp]

    movz	fp,	#780
    add	x21,	sp,	#204
    str	x21,	[sp, fp]

    movz	fp,	#788
    add	x21,	sp,	#208
    str	x21,	[sp, fp]

    movz	fp,	#796
    add	x21,	sp,	#212
    str	x21,	[sp, fp]

    movz	fp,	#804
    add	x21,	sp,	#216
    str	x21,	[sp, fp]

    movz	fp,	#820
    add	x21,	sp,	#220
    str	x21,	[sp, fp]

    movz	fp,	#828
    add	x21,	sp,	#224
    str	x21,	[sp, fp]

    movz	fp,	#836
    add	x21,	sp,	#228
    str	x21,	[sp, fp]

    movz	fp,	#812
    add	x21,	sp,	#232
    str	x21,	[sp, fp]

    movz	fp,	#844
    add	x21,	sp,	#236
    str	x21,	[sp, #416]

    add	x21,	sp,	#240
    str	x21,	[sp, #424]

    add	x21,	sp,	#244
    str	x21,	[sp, fp]

    movz	fp,	#852
    add	x21,	sp,	#248
    str	x21,	[sp, fp]

    movz	fp,	#860
    add	x21,	sp,	#252
    str	x21,	[sp, fp]

    movz	fp,	#868
    add	x21,	sp,	#256
    str	x21,	[sp, fp]

    movz	fp,	#876
    add	x21,	sp,	#260
    str	x21,	[sp, fp]

    movz	fp,	#884
    add	x21,	sp,	#264
    str	x21,	[sp, fp]

    movz	fp,	#892
    add	x21,	sp,	#268
    str	x21,	[sp, fp]

    movz	fp,	#900
    add	x21,	sp,	#272
    str	x21,	[sp, fp]

    movz	fp,	#908
    add	x21,	sp,	#276
    str	x21,	[sp, fp]

    movz	fp,	#916
    add	x21,	sp,	#280
    str	x21,	[sp, fp]

    movz	fp,	#924
    add	x21,	sp,	#284
    str	x21,	[sp, fp]

    movz	fp,	#932
    add	x21,	sp,	#288
    str	x21,	[sp, fp]

    movz	fp,	#940
    add	x21,	sp,	#292
    str	x21,	[sp, fp]

    movz	fp,	#948
    add	x21,	sp,	#296
    str	x21,	[sp, fp]

    movz	fp,	#956
    add	x21,	sp,	#300
    str	x21,	[sp, fp]

    movz	fp,	#964
    add	x21,	sp,	#304
    str	x21,	[sp, fp]

    movz	fp,	#972
    add	x21,	sp,	#308
    str	x21,	[sp, fp]

    movz	fp,	#980
    add	x21,	sp,	#312
    str	x21,	[sp, fp]

    movz	fp,	#988
    add	x21,	sp,	#316
    str	x21,	[sp, fp]

    movz	fp,	#996
    add	x21,	sp,	#320
    str	x21,	[sp, fp]

    movz	fp,	#1004
    add	x21,	sp,	#324
    str	x21,	[sp, fp]

    movz	fp,	#1012
    add	x21,	sp,	#328
    str	x21,	[sp, fp]

    movz	fp,	#1020
    add	x21,	sp,	#332
    str	x21,	[sp, fp]

    movz	fp,	#1028
    add	x21,	sp,	#336
    str	x21,	[sp, fp]

    movz	fp,	#1036
    add	x21,	sp,	#340
    str	x21,	[sp, fp]

    movz	fp,	#1044
    add	x21,	sp,	#344
    str	x21,	[sp, fp]

    movz	fp,	#1052
    add	x21,	sp,	#348
    str	x21,	[sp, fp]

    movz	fp,	#1060
    add	x21,	sp,	#352
    str	x21,	[sp, fp]

    movz	fp,	#1068
    add	x21,	sp,	#356
    str	x21,	[sp, fp]

    movz	fp,	#1076
    add	x21,	sp,	#360
    str	x21,	[sp, fp]

    movz	fp,	#1084
    add	x21,	sp,	#364
    str	x21,	[sp, fp]

    movz	fp,	#1092
    add	x21,	sp,	#368
    str	x21,	[sp, fp]

    movz	fp,	#1100
    add	x21,	sp,	#372
    str	x21,	[sp, fp]

    movz	fp,	#1108
    add	x21,	sp,	#376
    str	x21,	[sp, fp]

    movz	fp,	#1116
    add	x21,	sp,	#380
    str	x21,	[sp, fp]

    movz	fp,	#1124
    add	x21,	sp,	#384
    str	x21,	[sp, fp]

    movz	fp,	#1132
    add	x21,	sp,	#388
    str	x21,	[sp, fp]

    movz	fp,	#1140
    add	x21,	sp,	#392
    str	x21,	[sp, fp]

    movz	fp,	#1148
    add	x21,	sp,	#396
    str	x21,	[sp, fp]

    movz	fp,	#1156
    add	x21,	sp,	#400
    str	x21,	[sp, fp]

    movz	fp,	#1164
    add	x21,	sp,	#404
    str	x21,	[sp, fp]

    movz	fp,	#1172
    add	x21,	sp,	#408
    str	x21,	[sp, fp]

    movz	fp,	#1180
    add	x21,	sp,	#412
    str	x21,	[sp, fp]

    movz	w21,	#0
    str	w21,	[sp, #1192]

    movz	w21,	#0
    str	w21,	[sp, #1188]


main_113:
    ldr	w21,	[sp, #1200]

    cmp	w21,	#1
    ble	main_413

main_117:
    movz	w21,	#1
    movz	fp,	#1660
    ldr	x26,	[sp, fp]

    str	w21,	[x26]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#2
    ble	main_413

main_119:
    movz	w21,	#2
    movz	fp,	#1580
    ldr	x24,	[sp, fp]

    str	w21,	[x24]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#3
    ble	main_413

main_121:
    movz	w21,	#3
    movz	fp,	#1572
    ldr	x19,	[sp, fp]

    str	w21,	[x19]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#4
    ble	main_413

main_123:
    movz	w21,	#4
    movz	fp,	#1548
    ldr	x13,	[sp, fp]

    str	w21,	[x13]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#5
    ble	main_413

main_125:
    movz	w21,	#5
    movz	fp,	#1628
    ldr	x12,	[sp, fp]

    str	w21,	[x12]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#6
    ble	main_413

main_127:
    movz	w21,	#6
    movz	fp,	#1556
    ldr	x16,	[sp, fp]

    str	w21,	[x16]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#7
    ble	main_413

main_129:
    movz	w21,	#7
    movz	fp,	#1676
    ldr	x2,	[sp, fp]

    str	w21,	[x2]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#8
    ble	main_413

main_131:
    movz	w21,	#8
    movz	fp,	#1604
    ldr	x3,	[sp, fp]

    str	w21,	[x3]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#9
    ble	main_413

main_133:
    movz	w21,	#9
    movz	fp,	#1508
    ldr	x11,	[sp, fp]

    str	w21,	[x11]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#10
    ble	main_413

main_135:
    movz	w21,	#10
    movz	fp,	#1612
    ldr	x6,	[sp, fp]

    str	w21,	[x6]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#11
    ble	main_413

main_137:
    movz	w21,	#11
    movz	fp,	#1524
    ldr	x4,	[sp, fp]

    str	w21,	[x4]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#12
    ble	main_413

main_139:
    movz	w21,	#12
    movz	fp,	#1500
    ldr	x8,	[sp, fp]

    str	w21,	[x8]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#13
    ble	main_413

main_141:
    movz	w21,	#13
    movz	fp,	#1236
    ldr	x25,	[sp, fp]

    str	w21,	[x25]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#14
    ble	main_413

main_143:
    movz	w21,	#14
    movz	fp,	#1636
    ldr	x15,	[sp, fp]

    str	w21,	[x15]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#15
    ble	main_413

main_145:
    movz	w21,	#15
    movz	fp,	#1644
    ldr	x18,	[sp, fp]

    str	w21,	[x18]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#16
    ble	main_413

main_147:
    movz	w21,	#16
    movz	fp,	#1668
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#17
    ble	main_413

main_149:
    movz	w21,	#17
    movz	fp,	#1220
    ldr	x17,	[sp, fp]

    str	w21,	[x17]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#18
    ble	main_413

main_151:
    movz	w21,	#18
    movz	fp,	#1596
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#19
    ble	main_413

main_153:
    movz	w21,	#19
    movz	fp,	#1588
    ldr	x27,	[sp, fp]

    str	w21,	[x27]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#20
    ble	main_413

main_155:
    movz	w21,	#20
    movz	fp,	#1228
    ldr	x20,	[sp, fp]

    str	w21,	[x20]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#21
    ble	main_413

main_157:
    movz	w21,	#21
    movz	fp,	#1532
    ldr	x7,	[sp, fp]

    str	w21,	[x7]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#22
    ble	main_413

main_159:
    movz	w21,	#22
    movz	fp,	#1244
    ldr	x28,	[sp, fp]

    str	w21,	[x28]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#23
    ble	main_413

main_161:
    movz	w21,	#23
    movz	fp,	#1516
    ldr	x1,	[sp, fp]

    str	w21,	[x1]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#24
    ble	main_413

main_163:
    movz	w21,	#24
    movz	fp,	#1540
    ldr	x10,	[sp, fp]

    str	w21,	[x10]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#25
    ble	main_413

main_165:
    movz	w21,	#25
    movz	fp,	#1652
    ldr	x23,	[sp, fp]

    str	w21,	[x23]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#26
    ble	main_413

main_167:
    movz	w21,	#26
    movz	fp,	#1212
    ldr	x14,	[sp, fp]

    str	w21,	[x14]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#27
    ble	main_413

main_169:
    movz	w21,	#27
    movz	fp,	#1684
    ldr	x5,	[sp, fp]

    str	w21,	[x5]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#28
    ble	main_413

main_171:
    movz	w21,	#28
    movz	fp,	#1620
    ldr	x9,	[sp, fp]

    str	w21,	[x9]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#29
    ble	main_413

main_173:
    movz	w21,	#29
    movz	fp,	#508
    mov	w23,	w21
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2976]

    ldr	x22,	[sp, #2976]

    str	w23,	[x22]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#30
    ble	main_413

main_175:
    movz	w21,	#30
    movz	fp,	#500
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2984]

    ldr	x25,	[sp, #2984]

    str	w21,	[x25]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#31
    ble	main_413

main_177:
    movz	w21,	#31
    ldr	x27,	[sp, #760]

    str	x27,	[sp, #2992]

    ldr	x28,	[sp, #2992]

    str	w21,	[x28]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#32
    ble	main_413

main_179:
    movz	w21,	#32
    ldr	x1,	[sp, #440]

    mov	w23,	w21
    str	x1,	[sp, #3008]

    ldr	x2,	[sp, #3008]

    str	w23,	[x2]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#33
    ble	main_413

main_181:
    movz	w21,	#33
    ldr	x4,	[sp, #448]

    mov	w23,	w21
    str	x4,	[sp, #3000]

    ldr	x5,	[sp, #3000]

    str	w23,	[x5]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#34
    ble	main_413

main_183:
    movz	w21,	#34
    ldr	x4,	[sp, #456]

    movz	fp,	#2124
    mov	w23,	w21
    str	x4,	[sp, fp]

    movz	fp,	#2124
    ldr	x5,	[sp, fp]

    str	w23,	[x5]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#35
    ble	main_413

main_185:
    movz	w21,	#35
    ldr	x1,	[sp, #464]

    movz	fp,	#2116
    mov	w23,	w21
    str	x1,	[sp, fp]

    movz	fp,	#2116
    ldr	x2,	[sp, fp]

    str	w23,	[x2]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#36
    ble	main_413

main_187:
    movz	w21,	#36
    ldr	x27,	[sp, #720]

    movz	fp,	#2108
    str	x27,	[sp, fp]

    movz	fp,	#2108
    ldr	x28,	[sp, fp]

    str	w21,	[x28]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#37
    ble	main_413

main_189:
    movz	w21,	#37
    ldr	x24,	[sp, #728]

    movz	fp,	#2100
    str	x24,	[sp, fp]

    movz	fp,	#2100
    ldr	x25,	[sp, fp]

    str	w21,	[x25]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#38
    ble	main_413

main_191:
    movz	w21,	#38
    movz	fp,	#2092
    mov	w23,	w21
    ldr	x21,	[sp, #736]

    str	x21,	[sp, fp]

    movz	fp,	#2092
    ldr	x22,	[sp, fp]

    str	w23,	[x22]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#39
    ble	main_413

main_193:
    movz	w21,	#39
    ldr	x18,	[sp, #744]

    movz	fp,	#2084
    mov	w23,	w21
    str	x18,	[sp, fp]

    movz	fp,	#2084
    ldr	x19,	[sp, fp]

    str	w23,	[x19]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#40
    ble	main_413

main_195:
    movz	w21,	#40
    ldr	x15,	[sp, #752]

    movz	fp,	#2076
    mov	w23,	w21
    str	x15,	[sp, fp]

    movz	fp,	#2076
    ldr	x16,	[sp, fp]

    str	w23,	[x16]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#41
    ble	main_413

main_197:
    movz	w21,	#41
    movz	fp,	#516
    mov	w23,	w21
    ldr	x12,	[sp, fp]

    movz	fp,	#2068
    str	x12,	[sp, fp]

    movz	fp,	#2068
    ldr	x13,	[sp, fp]

    str	w23,	[x13]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#42
    ble	main_413

main_199:
    movz	w21,	#42
    movz	fp,	#524
    mov	w23,	w21
    ldr	x9,	[sp, fp]

    movz	fp,	#2060
    str	x9,	[sp, fp]

    movz	fp,	#2060
    ldr	x10,	[sp, fp]

    str	w23,	[x10]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#43
    ble	main_413

main_201:
    movz	w21,	#43
    movz	fp,	#532
    mov	w23,	w21
    ldr	x6,	[sp, fp]

    movz	fp,	#2052
    str	x6,	[sp, fp]

    movz	fp,	#2052
    ldr	x7,	[sp, fp]

    str	w23,	[x7]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#44
    ble	main_413

main_203:
    movz	w21,	#44
    movz	fp,	#540
    mov	w23,	w21
    ldr	x3,	[sp, fp]

    movz	fp,	#2044
    str	x3,	[sp, fp]

    movz	fp,	#2044
    ldr	x4,	[sp, fp]

    str	w23,	[x4]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#45
    ble	main_413

main_205:
    movz	w21,	#45
    movz	fp,	#548
    mov	w23,	w21
    ldr	x0,	[sp, fp]

    movz	fp,	#2036
    str	x0,	[sp, fp]

    movz	fp,	#2036
    ldr	x1,	[sp, fp]

    str	w23,	[x1]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#46
    ble	main_413

main_207:
    movz	w21,	#46
    movz	fp,	#772
    ldr	x26,	[sp, fp]

    movz	fp,	#2028
    str	x26,	[sp, fp]

    movz	fp,	#2028
    ldr	x27,	[sp, fp]

    str	w21,	[x27]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#47
    ble	main_413

main_209:
    movz	w21,	#47
    movz	fp,	#780
    ldr	x23,	[sp, fp]

    movz	fp,	#2020
    str	x23,	[sp, fp]

    movz	fp,	#2020
    ldr	x24,	[sp, fp]

    str	w21,	[x24]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#48
    ble	main_413

main_211:
    movz	w21,	#48
    movz	fp,	#788
    mov	w23,	w21
    ldr	x20,	[sp, fp]

    movz	fp,	#2012
    str	x20,	[sp, fp]

    movz	fp,	#2012
    ldr	x21,	[sp, fp]

    str	w23,	[x21]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#49
    ble	main_413

main_213:
    movz	w21,	#49
    movz	fp,	#796
    mov	w23,	w21
    ldr	x17,	[sp, fp]

    movz	fp,	#2004
    str	x17,	[sp, fp]

    movz	fp,	#2004
    ldr	x18,	[sp, fp]

    str	w23,	[x18]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#50
    ble	main_413

main_215:
    movz	w21,	#50
    movz	fp,	#804
    mov	w23,	w21
    ldr	x14,	[sp, fp]

    movz	fp,	#1996
    str	x14,	[sp, fp]

    movz	fp,	#1996
    ldr	x15,	[sp, fp]

    str	w23,	[x15]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#51
    ble	main_413

main_217:
    movz	w21,	#51
    movz	fp,	#820
    mov	w23,	w21
    ldr	x11,	[sp, fp]

    movz	fp,	#1988
    str	x11,	[sp, fp]

    movz	fp,	#1988
    ldr	x12,	[sp, fp]

    str	w23,	[x12]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#52
    ble	main_413

main_219:
    movz	w21,	#52
    movz	fp,	#828
    mov	w23,	w21
    ldr	x8,	[sp, fp]

    movz	fp,	#1980
    str	x8,	[sp, fp]

    movz	fp,	#1980
    ldr	x9,	[sp, fp]

    str	w23,	[x9]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#53
    ble	main_413

main_221:
    movz	w21,	#53
    movz	fp,	#836
    mov	w23,	w21
    ldr	x5,	[sp, fp]

    movz	fp,	#1972
    str	x5,	[sp, fp]

    movz	fp,	#1972
    ldr	x6,	[sp, fp]

    str	w23,	[x6]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#54
    ble	main_413

main_223:
    movz	w21,	#54
    movz	fp,	#812
    mov	w23,	w21
    ldr	x2,	[sp, fp]

    movz	fp,	#1964
    str	x2,	[sp, fp]

    movz	fp,	#1964
    ldr	x3,	[sp, fp]

    str	w23,	[x3]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#55
    ble	main_413

main_225:
    movz	w21,	#55
    ldr	x28,	[sp, #416]

    movz	fp,	#1956
    mov	w22,	w21
    str	x28,	[sp, fp]

    movz	fp,	#1956
    ldr	x0,	[sp, fp]

    str	w22,	[x0]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#56
    ble	main_413

main_227:
    movz	w21,	#56
    ldr	x25,	[sp, #424]

    movz	fp,	#1948
    str	x25,	[sp, fp]

    movz	fp,	#1948
    ldr	x26,	[sp, fp]

    str	w21,	[x26]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#57
    ble	main_413

main_229:
    movz	w21,	#57
    movz	fp,	#844
    ldr	x22,	[sp, fp]

    movz	fp,	#1940
    str	x22,	[sp, fp]

    movz	fp,	#1940
    ldr	x23,	[sp, fp]

    str	w21,	[x23]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#58
    ble	main_413

main_231:
    movz	w21,	#58
    movz	fp,	#852
    mov	w23,	w21
    ldr	x19,	[sp, fp]

    movz	fp,	#1932
    str	x19,	[sp, fp]

    movz	fp,	#1932
    ldr	x20,	[sp, fp]

    str	w23,	[x20]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#59
    ble	main_413

main_233:
    movz	w21,	#59
    movz	fp,	#860
    mov	w23,	w21
    ldr	x16,	[sp, fp]

    movz	fp,	#1780
    str	x16,	[sp, fp]

    movz	fp,	#1780
    ldr	x17,	[sp, fp]

    str	w23,	[x17]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#60
    ble	main_413

main_235:
    movz	w21,	#60
    movz	fp,	#868
    mov	w23,	w21
    ldr	x13,	[sp, fp]

    movz	fp,	#1868
    str	x13,	[sp, fp]

    movz	fp,	#1868
    ldr	x14,	[sp, fp]

    str	w23,	[x14]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#61
    ble	main_413

main_237:
    movz	w21,	#61
    movz	fp,	#876
    mov	w23,	w21
    ldr	x10,	[sp, fp]

    movz	fp,	#1860
    str	x10,	[sp, fp]

    movz	fp,	#1860
    ldr	x11,	[sp, fp]

    str	w23,	[x11]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#62
    ble	main_413

main_239:
    movz	w21,	#62
    movz	fp,	#884
    mov	w23,	w21
    ldr	x7,	[sp, fp]

    movz	fp,	#1852
    str	x7,	[sp, fp]

    movz	fp,	#1852
    ldr	x8,	[sp, fp]

    str	w23,	[x8]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#63
    ble	main_413

main_241:
    movz	w21,	#63
    movz	fp,	#892
    mov	w23,	w21
    ldr	x4,	[sp, fp]

    movz	fp,	#1844
    str	x4,	[sp, fp]

    movz	fp,	#1844
    ldr	x5,	[sp, fp]

    str	w23,	[x5]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#64
    ble	main_413

main_243:
    movz	w21,	#64
    movz	fp,	#900
    mov	w23,	w21
    ldr	x1,	[sp, fp]

    movz	fp,	#1836
    str	x1,	[sp, fp]

    movz	fp,	#1836
    ldr	x2,	[sp, fp]

    str	w23,	[x2]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#65
    ble	main_413

main_245:
    movz	w21,	#65
    movz	fp,	#908
    ldr	x27,	[sp, fp]

    movz	fp,	#1828
    str	x27,	[sp, fp]

    movz	fp,	#1828
    ldr	x28,	[sp, fp]

    str	w21,	[x28]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#66
    ble	main_413

main_247:
    movz	w21,	#66
    movz	fp,	#916
    ldr	x24,	[sp, fp]

    movz	fp,	#1820
    str	x24,	[sp, fp]

    movz	fp,	#1820
    ldr	x25,	[sp, fp]

    str	w21,	[x25]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#67
    ble	main_413

main_249:
    movz	w21,	#67
    movz	fp,	#924
    mov	w23,	w21
    ldr	x21,	[sp, fp]

    movz	fp,	#1812
    str	x21,	[sp, fp]

    movz	fp,	#1812
    ldr	x22,	[sp, fp]

    str	w23,	[x22]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#68
    ble	main_413

main_251:
    movz	w21,	#68
    movz	fp,	#932
    mov	w23,	w21
    ldr	x18,	[sp, fp]

    movz	fp,	#1804
    str	x18,	[sp, fp]

    movz	fp,	#1804
    ldr	x19,	[sp, fp]

    str	w23,	[x19]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#69
    ble	main_413

main_253:
    movz	w21,	#69
    movz	fp,	#940
    mov	w23,	w21
    ldr	x15,	[sp, fp]

    movz	fp,	#1796
    str	x15,	[sp, fp]

    movz	fp,	#1796
    ldr	x16,	[sp, fp]

    str	w23,	[x16]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#70
    ble	main_413

main_255:
    movz	w21,	#70
    movz	fp,	#948
    mov	w23,	w21
    ldr	x12,	[sp, fp]

    movz	fp,	#1788
    str	x12,	[sp, fp]

    movz	fp,	#1788
    ldr	x13,	[sp, fp]

    str	w23,	[x13]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#71
    ble	main_413

main_257:
    movz	w21,	#71
    movz	fp,	#956
    mov	w23,	w21
    ldr	x9,	[sp, fp]

    movz	fp,	#1772
    str	x9,	[sp, fp]

    movz	fp,	#1772
    ldr	x10,	[sp, fp]

    str	w23,	[x10]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#72
    ble	main_413

main_259:
    movz	w21,	#72
    movz	fp,	#964
    mov	w23,	w21
    ldr	x6,	[sp, fp]

    movz	fp,	#1764
    str	x6,	[sp, fp]

    movz	fp,	#1764
    ldr	x7,	[sp, fp]

    str	w23,	[x7]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#73
    ble	main_413

main_261:
    movz	w21,	#73
    movz	fp,	#972
    mov	w23,	w21
    ldr	x3,	[sp, fp]

    movz	fp,	#1756
    str	x3,	[sp, fp]

    movz	fp,	#1756
    ldr	x4,	[sp, fp]

    str	w23,	[x4]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#74
    ble	main_413

main_263:
    movz	w21,	#74
    movz	fp,	#980
    mov	w23,	w21
    ldr	x0,	[sp, fp]

    movz	fp,	#1748
    str	x0,	[sp, fp]

    movz	fp,	#1748
    ldr	x1,	[sp, fp]

    str	w23,	[x1]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#75
    ble	main_413

main_265:
    movz	w21,	#75
    movz	fp,	#988
    ldr	x26,	[sp, fp]

    movz	fp,	#1740
    str	x26,	[sp, fp]

    movz	fp,	#1740
    ldr	x27,	[sp, fp]

    str	w21,	[x27]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#76
    ble	main_413

main_267:
    movz	w21,	#76
    movz	fp,	#996
    ldr	x23,	[sp, fp]

    movz	fp,	#1732
    str	x23,	[sp, fp]

    movz	fp,	#1732
    ldr	x24,	[sp, fp]

    str	w21,	[x24]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#77
    ble	main_413

main_269:
    movz	w21,	#77
    movz	fp,	#1004
    mov	w23,	w21
    ldr	x20,	[sp, fp]

    movz	fp,	#1724
    str	x20,	[sp, fp]

    movz	fp,	#1724
    ldr	x21,	[sp, fp]

    str	w23,	[x21]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#78
    ble	main_413

main_271:
    movz	w21,	#78
    movz	fp,	#1012
    mov	w23,	w21
    ldr	x17,	[sp, fp]

    movz	fp,	#1716
    str	x17,	[sp, fp]

    movz	fp,	#1716
    ldr	x18,	[sp, fp]

    str	w23,	[x18]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#79
    ble	main_413

main_273:
    movz	w21,	#79
    movz	fp,	#1020
    mov	w23,	w21
    ldr	x14,	[sp, fp]

    movz	fp,	#1708
    str	x14,	[sp, fp]

    movz	fp,	#1708
    ldr	x15,	[sp, fp]

    str	w23,	[x15]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#80
    ble	main_413

main_275:
    movz	w21,	#80
    movz	fp,	#1028
    mov	w23,	w21
    ldr	x11,	[sp, fp]

    movz	fp,	#1700
    str	x11,	[sp, fp]

    movz	fp,	#1700
    ldr	x12,	[sp, fp]

    str	w23,	[x12]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#81
    ble	main_413

main_277:
    movz	w21,	#81
    movz	fp,	#1036
    mov	w23,	w21
    ldr	x8,	[sp, fp]

    movz	fp,	#1692
    str	x8,	[sp, fp]

    movz	fp,	#1692
    ldr	x9,	[sp, fp]

    str	w23,	[x9]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#82
    ble	main_413

main_279:
    movz	w21,	#82
    movz	fp,	#1044
    mov	w23,	w21
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #3104]

    ldr	x6,	[sp, #3104]

    str	w23,	[x6]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#83
    ble	main_413

main_281:
    movz	w21,	#83
    movz	fp,	#1052
    mov	w23,	w21
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #3096]

    ldr	x3,	[sp, #3096]

    str	w23,	[x3]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#84
    ble	main_413

main_283:
    movz	w21,	#84
    movz	fp,	#1060
    mov	w22,	w21
    ldr	x28,	[sp, fp]

    str	x28,	[sp, #3088]

    ldr	x0,	[sp, #3088]

    str	w22,	[x0]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#85
    ble	main_413

main_285:
    movz	w21,	#85
    movz	fp,	#1068
    ldr	x25,	[sp, fp]

    str	x25,	[sp, #3080]

    ldr	x26,	[sp, #3080]

    str	w21,	[x26]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#86
    ble	main_413

main_287:
    movz	w21,	#86
    movz	fp,	#1076
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #3072]

    ldr	x23,	[sp, #3072]

    str	w21,	[x23]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#87
    ble	main_413

main_289:
    movz	w21,	#87
    movz	fp,	#1084
    mov	w23,	w21
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3064]

    ldr	x20,	[sp, #3064]

    str	w23,	[x20]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#88
    ble	main_413

main_291:
    movz	w21,	#88
    movz	fp,	#1092
    mov	w23,	w21
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3056]

    ldr	x17,	[sp, #3056]

    str	w23,	[x17]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#89
    ble	main_413

main_293:
    movz	w21,	#89
    movz	fp,	#1100
    mov	w23,	w21
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3048]

    ldr	x14,	[sp, #3048]

    str	w23,	[x14]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#90
    ble	main_413

main_295:
    movz	w21,	#90
    movz	fp,	#1108
    mov	w23,	w21
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #3040]

    ldr	x11,	[sp, #3040]

    str	w23,	[x11]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#91
    ble	main_413

main_297:
    movz	w21,	#91
    movz	fp,	#1116
    mov	w23,	w21
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #3032]

    ldr	x8,	[sp, #3032]

    str	w23,	[x8]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#92
    ble	main_413

main_299:
    movz	w21,	#92
    movz	fp,	#1124
    mov	w23,	w21
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3024]

    ldr	x5,	[sp, #3024]

    str	w23,	[x5]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#93
    ble	main_413

main_301:
    movz	w21,	#93
    movz	fp,	#1132
    mov	w23,	w21
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3016]

    ldr	x2,	[sp, #3016]

    str	w23,	[x2]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#94
    ble	main_413

main_303:
    movz	w21,	#94
    movz	fp,	#1140
    ldr	x27,	[sp, fp]

    movz	fp,	#1924
    str	x27,	[sp, fp]

    movz	fp,	#1924
    ldr	x28,	[sp, fp]

    str	w21,	[x28]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#95
    ble	main_413

main_305:
    movz	w21,	#95
    movz	fp,	#1148
    ldr	x24,	[sp, fp]

    movz	fp,	#1916
    str	x24,	[sp, fp]

    movz	fp,	#1916
    ldr	x25,	[sp, fp]

    str	w21,	[x25]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#96
    ble	main_413

main_307:
    movz	w21,	#96
    movz	fp,	#1156
    mov	w23,	w21
    ldr	x21,	[sp, fp]

    movz	fp,	#1908
    str	x21,	[sp, fp]

    movz	fp,	#1908
    ldr	x22,	[sp, fp]

    str	w23,	[x22]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#97
    ble	main_413

main_309:
    movz	w21,	#97
    movz	fp,	#1164
    mov	w23,	w21
    ldr	x18,	[sp, fp]

    movz	fp,	#1900
    str	x18,	[sp, fp]

    movz	fp,	#1900
    ldr	x19,	[sp, fp]

    str	w23,	[x19]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#98
    ble	main_413

main_311:
    movz	w21,	#98
    movz	fp,	#1172
    mov	w23,	w21
    ldr	x15,	[sp, fp]

    movz	fp,	#1876
    str	x15,	[sp, fp]

    movz	fp,	#1876
    ldr	x16,	[sp, fp]

    str	w23,	[x16]

    ldr	w21,	[sp, #1200]

    cmp	w21,	#99
    ble	main_413

main_313:
    movz	w21,	#99
    movz	fp,	#1180
    mov	w23,	w21
    ldr	x12,	[sp, fp]

    movz	fp,	#1884
    str	x12,	[sp, fp]

    movz	fp,	#1884
    ldr	x13,	[sp, fp]

    str	w23,	[x13]


main_413:
    ldr	w21,	[sp, #1188]

    add	w21,	w21,	#1
    str	w21,	[sp, #496]

    ldr	w21,	[sp, #1192]

    str	w21,	[sp, #716]

    movz	w21,	#0
    str	w21,	[sp, #432]


main_415:
    ldr	w21,	[sp, #432]

    cmp	w21,	#100
    bge	main_424

main_419:
    ldr	w21,	[sp, #432]

    lsl	w21,	w21,	#2
    mov	x21,	x21
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    ldr	w23,	[x21]

    ldr	w13,	[sp, #716]

    str	w13,	[sp, #2796]

    ldr	w14,	[sp, #2796]

    ldr	w10,	[sp, #432]

    add	w25,	w23,	w14
    str	w10,	[sp, #2792]

    mov	w21,	w25
    ldr	w11,	[sp, #2792]

    add	w4,	w11,	#1
    str	w4,	[sp, #2784]

    ldr	w5,	[sp, #2784]

    str	w5,	[sp, #768]

    str	w21,	[sp, #716]

    ldr	w21,	[sp, #768]

    str	w21,	[sp, #432]

    b	main_415

main_424:
    movz	w21,	#65535
    ldr	w16,	[sp, #716]

    mov	w23,	w21
    str	w16,	[sp, #2800]

    ldr	w17,	[sp, #2800]

    sdiv	w21,	w17,	w23
    str	w21,	[sp, #436]

    ldr	w21,	[sp, #436]

    ldr	w7,	[sp, #436]

    lsl	w23,	w21,	#16
    str	w7,	[sp, #2788]

    ldr	w8,	[sp, #2788]

    ldr	w19,	[sp, #716]

    sub	w23,	w23,	w8,	lsl #0
    str	w19,	[sp, #2804]

    ldr	w20,	[sp, #2804]

    ldr	w7,	[sp, #496]

    sub	w25,	w20,	w23
    str	w7,	[sp, #2132]

    ldr	w22,	[sp, #1196]

    str	w22,	[sp, #2808]

    ldr	w8,	[sp, #2132]

    ldr	w0,	[sp, #2808]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w21,	w25
    str	w21,	[sp, #1192]

    ldr	w21,	[sp, #496]

    str	w21,	[sp, #1188]

    b	main_113

main_428:
    mov	w0,	w25
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


