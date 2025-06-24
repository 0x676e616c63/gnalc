.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #3408
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1196]

    bl	getint
    str	w0,	[sp, #1200]

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
    ldr	w15,	[sp, #1196]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x16,	sp,	#20
    movz	fp,	#1220
    add	x11,	sp,	#24
    add	x15,	sp,	#28
    add	x17,	sp,	#32
    add	x0,	sp,	#36
    add	x13,	sp,	#40
    add	x26,	sp,	#44
    add	x21,	sp,	#48
    add	x24,	sp,	#52
    add	x23,	sp,	#56
    add	x25,	sp,	#60
    add	x9,	sp,	#64
    add	x19,	sp,	#68
    add	x28,	sp,	#72
    add	x8,	sp,	#76
    add	x22,	sp,	#80
    add	x14,	sp,	#84
    add	x20,	sp,	#88
    add	x10,	sp,	#92
    add	x7,	sp,	#96
    add	x1,	sp,	#100
    add	x18,	sp,	#104
    add	x5,	sp,	#108
    add	x2,	sp,	#112
    add	x27,	sp,	#116
    add	x3,	sp,	#120
    add	x6,	sp,	#124
    add	x4,	sp,	#128
    str	x16,	[sp, fp]

    movz	fp,	#1772
    str	x11,	[sp, fp]

    movz	fp,	#1412
    str	x15,	[sp, fp]

    movz	fp,	#1788
    str	x17,	[sp, fp]

    movz	fp,	#1820
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#1212
    str	x13,	[sp, fp]

    movz	fp,	#1812
    str	x26,	[sp, fp]

    movz	fp,	#1428
    str	x21,	[sp, fp]

    movz	fp,	#1684
    str	x24,	[sp, fp]

    movz	fp,	#1804
    str	x23,	[sp, fp]

    movz	fp,	#1732
    str	x25,	[sp, fp]

    movz	fp,	#1844
    str	x9,	[sp, fp]

    movz	fp,	#1228
    str	x19,	[sp, fp]

    movz	fp,	#1740
    str	x28,	[sp, fp]

    movz	fp,	#1764
    str	x8,	[sp, fp]

    movz	fp,	#1236
    str	x22,	[sp, fp]

    movz	fp,	#1780
    str	x14,	[sp, fp]

    movz	fp,	#1796
    str	x20,	[sp, fp]

    movz	fp,	#1204
    str	x10,	[sp, fp]

    movz	fp,	#1716
    str	x7,	[sp, fp]

    movz	fp,	#1700
    str	x1,	[sp, fp]

    movz	fp,	#1420
    str	x18,	[sp, fp]

    add	x18,	sp,	#136
    movz	fp,	#1756
    str	x5,	[sp, fp]

    movz	fp,	#1748
    str	x2,	[sp, fp]

    movz	fp,	#1692
    str	x27,	[sp, fp]

    movz	fp,	#1828
    str	x3,	[sp, fp]

    movz	fp,	#1836
    str	x6,	[sp, fp]

    movz	fp,	#1708
    str	x4,	[sp, fp]

    movz	fp,	#588
    str	x0,	[sp, fp]

    add	x0,	sp,	#140
    movz	fp,	#628
    str	x18,	[sp, fp]

    movz	fp,	#652
    add	x18,	sp,	#144
    str	x0,	[sp, #608]

    add	x0,	sp,	#148
    str	x18,	[sp, fp]

    add	x18,	sp,	#152
    movz	fp,	#660
    str	x0,	[sp, fp]

    add	x0,	sp,	#156
    movz	fp,	#668
    str	x18,	[sp, fp]

    add	x18,	sp,	#164
    movz	fp,	#780
    str	x0,	[sp, fp]

    movz	fp,	#788
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#796
    str	x18,	[sp, fp]

    add	x18,	sp,	#172
    movz	fp,	#804
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#812
    str	x18,	[sp, fp]

    add	x18,	sp,	#180
    movz	fp,	#820
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#828
    str	x18,	[sp, fp]

    movz	fp,	#836
    add	x18,	sp,	#188
    str	x0,	[sp, #680]

    add	x0,	sp,	#192
    str	x18,	[sp, #696]

    add	x18,	sp,	#200
    str	x0,	[sp, #704]

    add	x0,	sp,	#196
    str	x0,	[sp, #712]

    add	x0,	sp,	#204
    str	x18,	[sp, #720]

    add	x18,	sp,	#208
    str	x0,	[sp, #728]

    add	x0,	sp,	#212
    str	x18,	[sp, #736]

    add	x18,	sp,	#216
    str	x0,	[sp, #744]

    add	x0,	sp,	#220
    str	x18,	[sp, #752]

    add	x18,	sp,	#224
    str	x0,	[sp, #760]

    add	x0,	sp,	#228
    str	x18,	[sp, #768]

    add	x18,	sp,	#232
    str	x0,	[sp, fp]

    movz	fp,	#844
    add	x0,	sp,	#240
    str	x18,	[sp, #688]

    add	x18,	sp,	#236
    str	x18,	[sp, #416]

    add	x18,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x18,	[sp, fp]

    add	x18,	sp,	#252
    movz	fp,	#852
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#860
    str	x18,	[sp, fp]

    add	x18,	sp,	#260
    movz	fp,	#868
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#876
    str	x18,	[sp, fp]

    add	x18,	sp,	#268
    movz	fp,	#884
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#892
    str	x18,	[sp, fp]

    add	x18,	sp,	#280
    movz	fp,	#900
    str	x0,	[sp, fp]

    movz	fp,	#908
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#916
    str	x18,	[sp, fp]

    add	x18,	sp,	#288
    movz	fp,	#924
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#932
    str	x18,	[sp, fp]

    add	x18,	sp,	#296
    movz	fp,	#940
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#948
    str	x18,	[sp, fp]

    add	x18,	sp,	#304
    movz	fp,	#956
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#964
    str	x18,	[sp, fp]

    add	x18,	sp,	#316
    movz	fp,	#972
    str	x0,	[sp, fp]

    movz	fp,	#980
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#988
    str	x18,	[sp, fp]

    add	x18,	sp,	#324
    movz	fp,	#996
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#1004
    str	x18,	[sp, fp]

    add	x18,	sp,	#332
    movz	fp,	#1012
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#1020
    str	x18,	[sp, fp]

    add	x18,	sp,	#340
    movz	fp,	#1028
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1036
    str	x18,	[sp, fp]

    add	x18,	sp,	#348
    movz	fp,	#1044
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#1052
    str	x18,	[sp, fp]

    movz	fp,	#1060
    add	x18,	sp,	#352
    str	x18,	[sp, fp]

    add	x18,	sp,	#360
    movz	fp,	#1068
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#1076
    str	x18,	[sp, fp]

    add	x18,	sp,	#368
    movz	fp,	#1084
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#1092
    str	x18,	[sp, fp]

    add	x18,	sp,	#376
    movz	fp,	#1100
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#1108
    str	x18,	[sp, fp]

    add	x18,	sp,	#384
    movz	fp,	#1116
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#1124
    str	x18,	[sp, fp]

    add	x18,	sp,	#396
    movz	fp,	#1132
    str	x0,	[sp, fp]

    movz	fp,	#1140
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1148
    str	x18,	[sp, fp]

    add	x18,	sp,	#404
    movz	fp,	#1156
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1164
    str	x18,	[sp, fp]

    add	x18,	sp,	#412
    movz	fp,	#1172
    str	x0,	[sp, fp]

    movz	fp,	#1180
    str	x18,	[sp, fp]

    movz	w18,	#0
    mov	w0,	w18
    movz	w18,	#0
    str	w0,	[sp, #1192]

    mov	w0,	w18
    str	w0,	[sp, #1188]


main_113:
    ldr	w0,	[sp, #1200]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w18,	#1
    movz	fp,	#1220
    mov	w0,	w18
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#2
    ble	main_413

main_119:
    movz	w18,	#2
    movz	fp,	#1772
    ldr	x6,	[sp, fp]

    str	w18,	[x6]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w18,	#3
    movz	fp,	#1412
    mov	w0,	w18
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1788
    ldr	x14,	[sp, fp]

    str	w0,	[x14]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w18,	#5
    movz	fp,	#1820
    ldr	x26,	[sp, fp]

    str	w18,	[x26]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    movz	fp,	#1212
    ldr	x9,	[sp, fp]

    str	w0,	[x9]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    movz	fp,	#1812
    mov	w18,	w0
    ldr	x23,	[sp, fp]

    str	w18,	[x23]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#8
    ble	main_413

main_131:
    movz	w18,	#8
    movz	fp,	#1428
    ldr	x14,	[sp, fp]

    str	w18,	[x14]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    movz	fp,	#1684
    mov	w18,	w0
    ldr	x17,	[sp, fp]

    str	w18,	[x17]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#10
    ble	main_413

main_135:
    movz	w18,	#10
    movz	fp,	#1804
    mov	w0,	w18
    ldr	x20,	[sp, fp]

    str	w0,	[x20]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w18,	#11
    movz	fp,	#1732
    ldr	x21,	[sp, fp]

    str	w18,	[x21]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#12
    ble	main_413

main_139:
    movz	w18,	#12
    movz	fp,	#1844
    mov	w0,	w18
    ldr	x7,	[sp, fp]

    str	w0,	[x7]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1228
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#14
    ble	main_413

main_143:
    movz	w18,	#14
    movz	fp,	#1740
    ldr	x24,	[sp, fp]

    str	w18,	[x24]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    movz	fp,	#1764
    ldr	x5,	[sp, fp]

    str	w0,	[x5]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    movz	fp,	#1236
    mov	w18,	w0
    ldr	x16,	[sp, fp]

    str	w18,	[x16]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w18,	#17
    movz	fp,	#1780
    ldr	x9,	[sp, fp]

    str	w18,	[x9]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1796
    mov	w18,	w0
    ldr	x15,	[sp, fp]

    str	w18,	[x15]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w18,	#19
    movz	fp,	#1204
    mov	w0,	w18
    ldr	x6,	[sp, fp]

    str	w0,	[x6]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#20
    ble	main_413

main_155:
    movz	w18,	#20
    movz	fp,	#1716
    ldr	x1,	[sp, fp]

    str	w18,	[x1]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w18,	#21
    movz	fp,	#1700
    mov	w0,	w18
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1420
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w18,	#23
    movz	fp,	#1756
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1748
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    movz	fp,	#1692
    mov	w18,	w0
    ldr	x22,	[sp, fp]

    str	w18,	[x22]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w18,	#26
    movz	fp,	#1828
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1836
    mov	w18,	w0
    ldr	x2,	[sp, fp]

    str	w18,	[x2]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w18,	#28
    movz	fp,	#1708
    mov	w0,	w18
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#29
    ble	main_413

main_173:
    movz	w18,	#29
    movz	fp,	#588
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w18,	#30
    movz	fp,	#628
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    ldr	x18,	[sp, #608]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w18,	#32
    movz	fp,	#652
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    movz	fp,	#660
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    movz	fp,	#668
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#35
    ble	main_413

main_185:
    movz	w18,	#35
    movz	fp,	#780
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    movz	fp,	#788
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#37
    ble	main_413

main_189:
    movz	w18,	#37
    movz	fp,	#796
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w18,	#38
    movz	fp,	#804
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#39
    ble	main_413

main_193:
    movz	w18,	#39
    movz	fp,	#812
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#820
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#41
    ble	main_413

main_197:
    movz	w18,	#41
    movz	fp,	#828
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    ldr	x18,	[sp, #680]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    mov	w18,	w0
    ldr	x0,	[sp, #696]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w18,	#44
    ldr	x0,	[sp, #704]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    mov	w18,	w0
    ldr	x0,	[sp, #712]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w18,	#46
    ldr	x0,	[sp, #720]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#47
    ble	main_413

main_209:
    movz	w18,	#47
    mov	w0,	w18
    ldr	x18,	[sp, #728]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w18,	#48
    mov	w0,	w18
    ldr	x18,	[sp, #736]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    ldr	x18,	[sp, #744]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w18,	#50
    mov	w0,	w18
    ldr	x18,	[sp, #752]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    mov	w18,	w0
    ldr	x0,	[sp, #760]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    mov	w18,	w0
    ldr	x0,	[sp, #768]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#53
    ble	main_413

main_221:
    movz	w18,	#53
    movz	fp,	#836
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    mov	w18,	w0
    ldr	x0,	[sp, #688]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w18,	#55
    mov	w0,	w18
    ldr	x18,	[sp, #416]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#56
    ble	main_413

main_227:
    movz	w18,	#56
    ldr	x0,	[sp, #424]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w18,	#57
    movz	fp,	#844
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#852
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w18,	#59
    movz	fp,	#860
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#868
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    movz	fp,	#876
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#62
    ble	main_413

main_239:
    movz	w18,	#62
    movz	fp,	#884
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#892
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#64
    ble	main_413

main_243:
    movz	w18,	#64
    movz	fp,	#900
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w18,	#65
    movz	fp,	#908
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#66
    ble	main_413

main_247:
    movz	w18,	#66
    movz	fp,	#916
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#924
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#68
    ble	main_413

main_251:
    movz	w18,	#68
    movz	fp,	#932
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#940
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    movz	fp,	#948
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w18,	#71
    movz	fp,	#956
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#964
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w18,	#73
    movz	fp,	#972
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#74
    ble	main_413

main_263:
    movz	w18,	#74
    movz	fp,	#980
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w18,	#75
    movz	fp,	#988
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#996
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w18,	#77
    movz	fp,	#1004
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#1012
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    movz	fp,	#1020
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#80
    ble	main_413

main_275:
    movz	w18,	#80
    movz	fp,	#1028
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#1036
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#82
    ble	main_413

main_279:
    movz	w18,	#82
    movz	fp,	#1044
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w18,	#83
    movz	fp,	#1052
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w18,	#84
    movz	fp,	#1060
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1068
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w18,	#86
    movz	fp,	#1076
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#1084
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    movz	fp,	#1092
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#89
    ble	main_413

main_293:
    movz	w18,	#89
    movz	fp,	#1100
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#1108
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#91
    ble	main_413

main_297:
    movz	w18,	#91
    movz	fp,	#1116
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w18,	#92
    movz	fp,	#1124
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#93
    ble	main_413

main_301:
    movz	w18,	#93
    movz	fp,	#1132
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1140
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#95
    ble	main_413

main_305:
    movz	w18,	#95
    movz	fp,	#1148
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#1156
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    movz	fp,	#1164
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w18,	#98
    movz	fp,	#1172
    mov	w0,	w18
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#1180
    mov	w18,	w0
    ldr	x0,	[sp, fp]

    str	w18,	[x0]


main_413:
    ldr	w18,	[sp, #1188]

    add	w0,	w18,	#1
    str	w0,	[sp, #676]

    ldr	w0,	[sp, #1192]

    str	w0,	[sp, #776]

    movz	w0,	#0
    mov	w18,	w0
    str	w18,	[sp, #584]


main_415:
    ldr	w0,	[sp, #584]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w18,	[sp, #584]

    lsl	w0,	w18,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w18,	[sp, #776]

    add	w3,	w0,	w18
    str	w3,	[sp, #3288]

    ldr	w0,	[sp, #584]

    add	w18,	w0,	#1
    str	w18,	[sp, #616]

    ldr	w4,	[sp, #3288]

    mov	w0,	w4
    str	w0,	[sp, #776]

    ldr	w18,	[sp, #616]

    str	w18,	[sp, #584]

    b	main_415

main_424:
    movz	w18,	#65535
    ldr	w0,	[sp, #776]

    sdiv	w18,	w0,	w18
    str	w18,	[sp, #596]

    ldr	w0,	[sp, #596]

    lsl	w28,	w0,	#16
    str	w28,	[sp, #2992]

    ldr	w18,	[sp, #596]

    ldr	w0,	[sp, #2992]

    sub	w18,	w0,	w18,	lsl #0
    ldr	w0,	[sp, #776]

    ldr	w2,	[sp, #676]

    sub	w18,	w0,	w18
    str	w2,	[sp, #3188]

    ldr	w5,	[sp, #1196]

    str	w5,	[sp, #2116]

    ldr	w7,	[sp, #2116]

    ldr	w3,	[sp, #3188]

    cmp	w3,	w7
    bge	main_428

main_112:
    mov	w0,	w18
    str	w0,	[sp, #1192]

    ldr	w0,	[sp, #676]

    str	w0,	[sp, #1188]

    b	main_113

main_428:
    mov	w0,	w18
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
    
    add	sp, sp, #3408
    ret


