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
    str	w0,	[sp, #1180]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1184]

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
    ldr	w15,	[sp, #1180]

    cmp	w27,	w15
    bge	main_427

main_12:
    add	x25,	sp,	#20
    add	x8,	sp,	#24
    add	x26,	sp,	#28
    add	x6,	sp,	#32
    add	x11,	sp,	#36
    add	x13,	sp,	#40
    add	x5,	sp,	#44
    add	x24,	sp,	#48
    movz	fp,	#804
    add	x7,	sp,	#52
    add	x22,	sp,	#56
    add	x10,	sp,	#60
    add	x17,	sp,	#64
    add	x21,	sp,	#68
    add	x0,	sp,	#72
    add	x23,	sp,	#76
    add	x20,	sp,	#80
    add	x27,	sp,	#84
    add	x4,	sp,	#88
    add	x1,	sp,	#92
    add	x16,	sp,	#96
    add	x9,	sp,	#100
    add	x18,	sp,	#104
    add	x15,	sp,	#108
    add	x3,	sp,	#112
    add	x2,	sp,	#116
    add	x19,	sp,	#120
    add	x14,	sp,	#124
    add	x28,	sp,	#128
    str	x25,	[sp, #1736]

    str	x8,	[sp, #1768]

    str	x26,	[sp, #1816]

    str	x6,	[sp, #1840]

    str	x11,	[sp, #1776]

    str	x13,	[sp, #1704]

    str	x5,	[sp, #1760]

    str	x24,	[sp, fp]

    movz	fp,	#796
    str	x7,	[sp, #1680]

    str	x22,	[sp, #1728]

    str	x10,	[sp, #1696]

    str	x17,	[sp, #1792]

    str	x21,	[sp, fp]

    movz	fp,	#788
    str	x0,	[sp, #1824]

    add	x0,	sp,	#132
    str	x23,	[sp, #1808]

    str	x20,	[sp, #1800]

    str	x27,	[sp, #1656]

    str	x4,	[sp, #1672]

    str	x1,	[sp, #1664]

    str	x16,	[sp, #1712]

    str	x9,	[sp, #1848]

    str	x18,	[sp, fp]

    movz	w18,	#0
    movz	fp,	#780
    str	x15,	[sp, fp]

    movz	fp,	#812
    str	x3,	[sp, #1832]

    str	x2,	[sp, #1752]

    str	x19,	[sp, #1720]

    str	x14,	[sp, #1784]

    str	x28,	[sp, #1744]

    str	x0,	[sp, #472]

    add	x0,	sp,	#136
    str	x0,	[sp, #456]

    add	x0,	sp,	#140
    str	x0,	[sp, fp]

    movz	fp,	#484
    add	x0,	sp,	#144
    str	x0,	[sp, fp]

    movz	fp,	#492
    add	x0,	sp,	#148
    str	x0,	[sp, fp]

    movz	fp,	#500
    add	x0,	sp,	#152
    str	x0,	[sp, fp]

    movz	fp,	#508
    add	x0,	sp,	#156
    str	x0,	[sp, fp]

    movz	fp,	#516
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    movz	fp,	#524
    add	x0,	sp,	#164
    str	x0,	[sp, fp]

    movz	fp,	#532
    add	x0,	sp,	#168
    str	x0,	[sp, fp]

    movz	fp,	#540
    add	x0,	sp,	#172
    str	x0,	[sp, fp]

    movz	fp,	#548
    add	x0,	sp,	#176
    str	x0,	[sp, fp]

    movz	fp,	#556
    add	x0,	sp,	#180
    str	x0,	[sp, fp]

    movz	fp,	#564
    add	x0,	sp,	#184
    str	x0,	[sp, fp]

    movz	fp,	#572
    add	x0,	sp,	#188
    str	x0,	[sp, fp]

    movz	fp,	#580
    add	x0,	sp,	#192
    str	x0,	[sp, fp]

    movz	fp,	#588
    add	x0,	sp,	#196
    str	x0,	[sp, fp]

    movz	fp,	#596
    add	x0,	sp,	#200
    str	x0,	[sp, fp]

    movz	fp,	#604
    add	x0,	sp,	#204
    str	x0,	[sp, fp]

    movz	fp,	#612
    add	x0,	sp,	#208
    str	x0,	[sp, fp]

    movz	fp,	#620
    add	x0,	sp,	#212
    str	x0,	[sp, fp]

    movz	fp,	#628
    add	x0,	sp,	#216
    str	x0,	[sp, fp]

    movz	fp,	#636
    add	x0,	sp,	#220
    str	x0,	[sp, fp]

    movz	fp,	#652
    add	x0,	sp,	#224
    str	x0,	[sp, fp]

    movz	fp,	#820
    add	x0,	sp,	#228
    str	x0,	[sp, fp]

    movz	fp,	#644
    add	x0,	sp,	#232
    str	x0,	[sp, fp]

    movz	fp,	#828
    add	x0,	sp,	#236
    str	x0,	[sp, #416]

    add	x0,	sp,	#240
    str	x0,	[sp, #424]

    add	x0,	sp,	#244
    str	x0,	[sp, fp]

    movz	fp,	#836
    add	x0,	sp,	#248
    str	x0,	[sp, fp]

    movz	fp,	#844
    add	x0,	sp,	#252
    str	x0,	[sp, fp]

    movz	fp,	#852
    add	x0,	sp,	#256
    str	x0,	[sp, fp]

    movz	fp,	#860
    add	x0,	sp,	#260
    str	x0,	[sp, fp]

    movz	fp,	#868
    add	x0,	sp,	#264
    str	x0,	[sp, fp]

    movz	fp,	#876
    add	x0,	sp,	#268
    str	x0,	[sp, fp]

    movz	fp,	#884
    add	x0,	sp,	#272
    str	x0,	[sp, fp]

    movz	fp,	#892
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    movz	fp,	#900
    add	x0,	sp,	#280
    str	x0,	[sp, fp]

    movz	fp,	#908
    add	x0,	sp,	#284
    str	x0,	[sp, fp]

    movz	fp,	#916
    add	x0,	sp,	#288
    str	x0,	[sp, fp]

    movz	fp,	#924
    add	x0,	sp,	#292
    str	x0,	[sp, fp]

    movz	fp,	#932
    add	x0,	sp,	#296
    str	x0,	[sp, fp]

    movz	fp,	#940
    add	x0,	sp,	#300
    str	x0,	[sp, fp]

    movz	fp,	#948
    add	x0,	sp,	#304
    str	x0,	[sp, fp]

    movz	fp,	#956
    add	x0,	sp,	#308
    str	x0,	[sp, fp]

    movz	fp,	#964
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    movz	fp,	#972
    add	x0,	sp,	#316
    str	x0,	[sp, fp]

    movz	fp,	#980
    add	x0,	sp,	#320
    str	x0,	[sp, fp]

    movz	fp,	#988
    add	x0,	sp,	#324
    str	x0,	[sp, fp]

    movz	fp,	#996
    add	x0,	sp,	#328
    str	x0,	[sp, fp]

    movz	fp,	#1004
    add	x0,	sp,	#332
    str	x0,	[sp, fp]

    movz	fp,	#1012
    add	x0,	sp,	#336
    str	x0,	[sp, fp]

    movz	fp,	#1020
    add	x0,	sp,	#340
    str	x0,	[sp, fp]

    movz	fp,	#1028
    add	x0,	sp,	#344
    str	x0,	[sp, fp]

    movz	fp,	#1036
    add	x0,	sp,	#348
    str	x0,	[sp, fp]

    movz	fp,	#1044
    add	x0,	sp,	#352
    str	x0,	[sp, fp]

    movz	fp,	#1052
    add	x0,	sp,	#356
    str	x0,	[sp, fp]

    movz	fp,	#1060
    add	x0,	sp,	#360
    str	x0,	[sp, fp]

    movz	fp,	#1068
    add	x0,	sp,	#364
    str	x0,	[sp, fp]

    movz	fp,	#1076
    add	x0,	sp,	#368
    str	x0,	[sp, fp]

    movz	fp,	#1084
    add	x0,	sp,	#372
    str	x0,	[sp, fp]

    movz	fp,	#1092
    add	x0,	sp,	#376
    str	x0,	[sp, fp]

    movz	fp,	#1100
    add	x0,	sp,	#380
    str	x0,	[sp, fp]

    movz	fp,	#1108
    add	x0,	sp,	#384
    str	x0,	[sp, fp]

    movz	fp,	#1116
    add	x0,	sp,	#388
    str	x0,	[sp, fp]

    movz	fp,	#1124
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    movz	fp,	#1132
    add	x0,	sp,	#396
    str	x0,	[sp, fp]

    movz	fp,	#1140
    add	x0,	sp,	#400
    str	x0,	[sp, fp]

    movz	fp,	#1148
    add	x0,	sp,	#404
    str	x0,	[sp, fp]

    movz	fp,	#1156
    add	x0,	sp,	#408
    str	x0,	[sp, fp]

    movz	fp,	#1164
    add	x0,	sp,	#412
    str	x0,	[sp, fp]

    mov	w0,	w18
    movz	w18,	#0
    str	w0,	[sp, #1176]

    mov	w0,	w18
    str	w0,	[sp, #1172]


main_113:
    ldr	w0,	[sp, #1184]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w18,	#1
    ldr	x22,	[sp, #1736]

    str	w18,	[x22]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#2
    ble	main_413

main_119:
    movz	w18,	#2
    ldr	x4,	[sp, #1768]

    str	w18,	[x4]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w18,	#3
    ldr	x24,	[sp, #1816]

    str	w18,	[x24]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#4
    ble	main_413

main_123:
    movz	w18,	#4
    ldr	x2,	[sp, #1840]

    str	w18,	[x2]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w18,	#5
    ldr	x7,	[sp, #1776]

    str	w18,	[x7]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#6
    ble	main_413

main_127:
    movz	w18,	#6
    ldr	x8,	[sp, #1704]

    str	w18,	[x8]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w18,	#7
    ldr	x0,	[sp, #1760]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#8
    ble	main_413

main_131:
    movz	w18,	#8
    movz	fp,	#804
    ldr	x20,	[sp, fp]

    str	w18,	[x20]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w18,	#9
    ldr	x1,	[sp, #1680]

    str	w18,	[x1]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#10
    ble	main_413

main_135:
    movz	w18,	#10
    ldr	x19,	[sp, #1728]

    str	w18,	[x19]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w18,	#11
    ldr	x5,	[sp, #1696]

    str	w18,	[x5]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#12
    ble	main_413

main_139:
    movz	w18,	#12
    ldr	x13,	[sp, #1792]

    str	w18,	[x13]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w18,	#13
    movz	fp,	#796
    ldr	x16,	[sp, fp]

    str	w18,	[x16]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#14
    ble	main_413

main_143:
    movz	w18,	#14
    ldr	x27,	[sp, #1824]

    str	w18,	[x27]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w18,	#15
    ldr	x21,	[sp, #1808]

    str	w18,	[x21]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#16
    ble	main_413

main_147:
    movz	w18,	#16
    ldr	x17,	[sp, #1800]

    str	w18,	[x17]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w18,	#17
    ldr	x23,	[sp, #1656]

    str	w18,	[x23]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#18
    ble	main_413

main_151:
    movz	w18,	#18
    ldr	x0,	[sp, #1672]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w18,	#19
    ldr	x26,	[sp, #1664]

    str	w18,	[x26]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#20
    ble	main_413

main_155:
    movz	w18,	#20
    ldr	x11,	[sp, #1712]

    str	w18,	[x11]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w18,	#21
    ldr	x6,	[sp, #1848]

    str	w18,	[x6]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#22
    ble	main_413

main_159:
    movz	w18,	#22
    movz	fp,	#788
    ldr	x12,	[sp, fp]

    str	w18,	[x12]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w18,	#23
    movz	fp,	#780
    ldr	x9,	[sp, fp]

    str	w18,	[x9]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#24
    ble	main_413

main_163:
    movz	w18,	#24
    ldr	x0,	[sp, #1832]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w18,	#25
    ldr	x28,	[sp, #1752]

    str	w18,	[x28]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w18,	#26
    ldr	x14,	[sp, #1720]

    str	w18,	[x14]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#27
    ble	main_413

main_169:
    movz	w18,	#27
    ldr	x10,	[sp, #1784]

    str	w18,	[x10]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w18,	#28
    ldr	x25,	[sp, #1744]

    str	w18,	[x25]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#29
    ble	main_413

main_173:
    movz	w18,	#29
    ldr	x0,	[sp, #472]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w18,	#30
    ldr	x0,	[sp, #456]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#31
    ble	main_413

main_177:
    movz	w18,	#31
    movz	fp,	#812
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w18,	#32
    movz	fp,	#484
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#33
    ble	main_413

main_181:
    movz	w18,	#33
    movz	fp,	#492
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w18,	#34
    movz	fp,	#500
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#35
    ble	main_413

main_185:
    movz	w18,	#35
    movz	fp,	#508
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w18,	#36
    movz	fp,	#516
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#37
    ble	main_413

main_189:
    movz	w18,	#37
    movz	fp,	#524
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w18,	#38
    movz	fp,	#532
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#39
    ble	main_413

main_193:
    movz	w18,	#39
    movz	fp,	#540
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w18,	#40
    movz	fp,	#548
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#41
    ble	main_413

main_197:
    movz	w18,	#41
    movz	fp,	#556
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w18,	#42
    movz	fp,	#564
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#43
    ble	main_413

main_201:
    movz	w18,	#43
    movz	fp,	#572
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w18,	#44
    movz	fp,	#580
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#45
    ble	main_413

main_205:
    movz	w18,	#45
    movz	fp,	#588
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w18,	#46
    movz	fp,	#596
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#47
    ble	main_413

main_209:
    movz	w18,	#47
    movz	fp,	#604
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w18,	#48
    movz	fp,	#612
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#49
    ble	main_413

main_213:
    movz	w18,	#49
    movz	fp,	#620
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w18,	#50
    movz	fp,	#628
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#51
    ble	main_413

main_217:
    movz	w18,	#51
    movz	fp,	#636
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w18,	#52
    movz	fp,	#652
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#53
    ble	main_413

main_221:
    movz	w18,	#53
    movz	fp,	#820
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w18,	#54
    movz	fp,	#644
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w18,	#55
    ldr	x0,	[sp, #416]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#56
    ble	main_413

main_227:
    movz	w18,	#56
    ldr	x0,	[sp, #424]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w18,	#57
    movz	fp,	#828
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#58
    ble	main_413

main_231:
    movz	w18,	#58
    movz	fp,	#836
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w18,	#59
    movz	fp,	#844
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#60
    ble	main_413

main_235:
    movz	w18,	#60
    movz	fp,	#852
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w18,	#61
    movz	fp,	#860
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#62
    ble	main_413

main_239:
    movz	w18,	#62
    movz	fp,	#868
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w18,	#63
    movz	fp,	#876
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#64
    ble	main_413

main_243:
    movz	w18,	#64
    movz	fp,	#884
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w18,	#65
    movz	fp,	#892
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#66
    ble	main_413

main_247:
    movz	w18,	#66
    movz	fp,	#900
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w18,	#67
    movz	fp,	#908
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#68
    ble	main_413

main_251:
    movz	w18,	#68
    movz	fp,	#916
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w18,	#69
    movz	fp,	#924
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#70
    ble	main_413

main_255:
    movz	w18,	#70
    movz	fp,	#932
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#71
    ble	main_413

main_257:
    movz	w18,	#71
    movz	fp,	#940
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#72
    ble	main_413

main_259:
    movz	w18,	#72
    movz	fp,	#948
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#73
    ble	main_413

main_261:
    movz	w18,	#73
    movz	fp,	#956
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#74
    ble	main_413

main_263:
    movz	w18,	#74
    movz	fp,	#964
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#75
    ble	main_413

main_265:
    movz	w18,	#75
    movz	fp,	#972
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#76
    ble	main_413

main_267:
    movz	w18,	#76
    movz	fp,	#980
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#77
    ble	main_413

main_269:
    movz	w18,	#77
    movz	fp,	#988
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#78
    ble	main_413

main_271:
    movz	w18,	#78
    movz	fp,	#996
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#79
    ble	main_413

main_273:
    movz	w18,	#79
    movz	fp,	#1004
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#80
    ble	main_413

main_275:
    movz	w18,	#80
    movz	fp,	#1012
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#81
    ble	main_413

main_277:
    movz	w18,	#81
    movz	fp,	#1020
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#82
    ble	main_413

main_279:
    movz	w18,	#82
    movz	fp,	#1028
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#83
    ble	main_413

main_281:
    movz	w18,	#83
    movz	fp,	#1036
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w18,	#84
    movz	fp,	#1044
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#85
    ble	main_413

main_285:
    movz	w18,	#85
    movz	fp,	#1052
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w18,	#86
    movz	fp,	#1060
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#87
    ble	main_413

main_289:
    movz	w18,	#87
    movz	fp,	#1068
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w18,	#88
    movz	fp,	#1076
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#89
    ble	main_413

main_293:
    movz	w18,	#89
    movz	fp,	#1084
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w18,	#90
    movz	fp,	#1092
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#91
    ble	main_413

main_297:
    movz	w18,	#91
    movz	fp,	#1100
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w18,	#92
    movz	fp,	#1108
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#93
    ble	main_413

main_301:
    movz	w18,	#93
    movz	fp,	#1116
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w18,	#94
    movz	fp,	#1124
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#95
    ble	main_413

main_305:
    movz	w18,	#95
    movz	fp,	#1132
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w18,	#96
    movz	fp,	#1140
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#97
    ble	main_413

main_309:
    movz	w18,	#97
    movz	fp,	#1148
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1184]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w18,	#98
    movz	fp,	#1156
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1184]

    cmp	w18,	#99
    ble	main_413

main_313:
    movz	w18,	#99
    movz	fp,	#1164
    ldr	x0,	[sp, fp]

    str	w18,	[x0]


main_413:
    ldr	w0,	[sp, #1172]

    add	w0,	w0,	#1
    str	w0,	[sp, #480]

    ldr	w18,	[sp, #1176]

    str	w18,	[sp, #448]

    movz	w18,	#0
    str	w18,	[sp, #464]


main_415:
    ldr	w0,	[sp, #464]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w0,	[sp, #464]

    lsl	w18,	w0,	#2
    mov	x18,	x18
    add	x18,	sp,	x18
    add	x18,	x18,	#16
    ldr	w0,	[x18]

    str	w0,	[sp, #3364]

    ldr	w0,	[sp, #448]

    ldr	w1,	[sp, #3364]

    add	w18,	w1,	w0
    ldr	w0,	[sp, #464]

    add	w0,	w0,	#1
    str	w0,	[sp, #468]

    str	w18,	[sp, #448]

    ldr	w18,	[sp, #468]

    str	w18,	[sp, #464]

    b	main_415

main_424:
    movz	w18,	#65535
    ldr	w0,	[sp, #448]

    sdiv	w0,	w0,	w18
    str	w0,	[sp, #452]

    ldr	w0,	[sp, #452]

    lsl	w18,	w0,	#16
    ldr	w0,	[sp, #452]

    sub	w18,	w18,	w0,	lsl #0
    ldr	w0,	[sp, #448]

    ldr	w25,	[sp, #480]

    sub	w0,	w0,	w18
    str	w25,	[sp, #2748]

    ldr	w7,	[sp, #1180]

    str	w7,	[sp, #2136]

    ldr	w11,	[sp, #2136]

    ldr	w26,	[sp, #2748]

    cmp	w26,	w11
    bge	main_429

main_112:
    str	w0,	[sp, #1176]

    ldr	w18,	[sp, #480]

    mov	w0,	w18
    str	w0,	[sp, #1172]

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


