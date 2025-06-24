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
    add	x16,	sp,	#20
    movz	fp,	#1244
    add	x3,	sp,	#24
    add	x18,	sp,	#28
    add	x15,	sp,	#32
    add	x6,	sp,	#36
    add	x2,	sp,	#40
    add	x28,	sp,	#44
    add	x11,	sp,	#48
    add	x14,	sp,	#52
    add	x7,	sp,	#56
    add	x13,	sp,	#60
    add	x1,	sp,	#64
    add	x27,	sp,	#68
    add	x22,	sp,	#72
    add	x20,	sp,	#76
    add	x21,	sp,	#80
    add	x24,	sp,	#84
    add	x8,	sp,	#88
    add	x25,	sp,	#92
    add	x10,	sp,	#96
    add	x19,	sp,	#100
    add	x9,	sp,	#104
    add	x0,	sp,	#108
    add	x23,	sp,	#112
    add	x26,	sp,	#116
    add	x4,	sp,	#120
    add	x17,	sp,	#124
    add	x5,	sp,	#128
    str	x16,	[sp, fp]

    movz	fp,	#1884
    str	x3,	[sp, fp]

    movz	fp,	#604
    str	x18,	[sp, fp]

    add	x18,	sp,	#132
    movz	fp,	#596
    str	x15,	[sp, fp]

    movz	fp,	#1892
    str	x6,	[sp, fp]

    movz	fp,	#1804
    str	x2,	[sp, fp]

    movz	fp,	#1796
    str	x28,	[sp, fp]

    movz	fp,	#1828
    str	x11,	[sp, fp]

    movz	fp,	#1836
    str	x14,	[sp, fp]

    movz	fp,	#1220
    str	x7,	[sp, fp]

    movz	fp,	#1236
    str	x13,	[sp, fp]

    movz	fp,	#636
    str	x1,	[sp, fp]

    movz	fp,	#628
    str	x27,	[sp, fp]

    movz	fp,	#1780
    str	x22,	[sp, fp]

    movz	fp,	#1852
    str	x20,	[sp, fp]

    movz	fp,	#612
    str	x21,	[sp, fp]

    movz	fp,	#620
    str	x24,	[sp, fp]

    movz	fp,	#1820
    str	x8,	[sp, fp]

    movz	fp,	#1788
    str	x25,	[sp, fp]

    movz	fp,	#1228
    str	x10,	[sp, fp]

    movz	fp,	#1252
    str	x19,	[sp, fp]

    movz	fp,	#1900
    str	x9,	[sp, fp]

    movz	fp,	#1876
    str	x0,	[sp, fp]

    movz	fp,	#1860
    str	x23,	[sp, fp]

    movz	fp,	#1868
    str	x26,	[sp, fp]

    movz	fp,	#1212
    str	x4,	[sp, fp]

    movz	fp,	#1844
    str	x17,	[sp, fp]

    movz	fp,	#1812
    str	x5,	[sp, fp]

    movz	fp,	#580
    str	x18,	[sp, fp]

    movz	fp,	#588
    add	x18,	sp,	#136
    str	x18,	[sp, fp]

    movz	fp,	#644
    add	x18,	sp,	#140
    str	x18,	[sp, fp]

    movz	fp,	#652
    add	x18,	sp,	#144
    str	x18,	[sp, fp]

    movz	fp,	#660
    add	x18,	sp,	#148
    str	x18,	[sp, fp]

    movz	fp,	#780
    add	x18,	sp,	#152
    str	x18,	[sp, #752]

    add	x18,	sp,	#156
    str	x18,	[sp, #760]

    add	x18,	sp,	#160
    str	x18,	[sp, #768]

    add	x18,	sp,	#164
    str	x18,	[sp, fp]

    movz	fp,	#788
    add	x18,	sp,	#168
    str	x18,	[sp, fp]

    movz	fp,	#796
    add	x18,	sp,	#172
    str	x18,	[sp, fp]

    movz	fp,	#804
    add	x18,	sp,	#176
    str	x18,	[sp, fp]

    movz	fp,	#812
    add	x18,	sp,	#180
    str	x18,	[sp, fp]

    movz	fp,	#820
    add	x18,	sp,	#184
    str	x18,	[sp, fp]

    movz	fp,	#828
    add	x18,	sp,	#188
    str	x18,	[sp, #672]

    add	x18,	sp,	#192
    str	x18,	[sp, #680]

    add	x18,	sp,	#196
    str	x18,	[sp, #688]

    add	x18,	sp,	#200
    str	x18,	[sp, #696]

    add	x18,	sp,	#204
    str	x18,	[sp, #704]

    add	x18,	sp,	#208
    str	x18,	[sp, #712]

    add	x18,	sp,	#212
    str	x18,	[sp, #720]

    add	x18,	sp,	#216
    str	x18,	[sp, #728]

    add	x18,	sp,	#220
    str	x18,	[sp, #744]

    add	x18,	sp,	#224
    str	x18,	[sp, fp]

    movz	fp,	#836
    add	x18,	sp,	#228
    str	x18,	[sp, fp]

    movz	fp,	#844
    add	x18,	sp,	#232
    str	x18,	[sp, #736]

    add	x18,	sp,	#236
    str	x18,	[sp, #416]

    add	x18,	sp,	#240
    str	x18,	[sp, #424]

    add	x18,	sp,	#244
    str	x18,	[sp, fp]

    movz	fp,	#852
    add	x18,	sp,	#248
    str	x18,	[sp, fp]

    movz	fp,	#860
    add	x18,	sp,	#252
    str	x18,	[sp, fp]

    movz	fp,	#868
    add	x18,	sp,	#256
    str	x18,	[sp, fp]

    movz	fp,	#876
    add	x18,	sp,	#260
    str	x18,	[sp, fp]

    movz	fp,	#884
    add	x18,	sp,	#264
    str	x18,	[sp, fp]

    movz	fp,	#892
    add	x18,	sp,	#268
    str	x18,	[sp, fp]

    movz	fp,	#900
    add	x18,	sp,	#272
    str	x18,	[sp, fp]

    movz	fp,	#908
    add	x18,	sp,	#276
    str	x18,	[sp, fp]

    movz	fp,	#916
    add	x18,	sp,	#280
    str	x18,	[sp, fp]

    movz	fp,	#924
    add	x18,	sp,	#284
    str	x18,	[sp, fp]

    movz	fp,	#932
    add	x18,	sp,	#288
    str	x18,	[sp, fp]

    movz	fp,	#940
    add	x18,	sp,	#292
    str	x18,	[sp, fp]

    movz	fp,	#948
    add	x18,	sp,	#296
    str	x18,	[sp, fp]

    movz	fp,	#956
    add	x18,	sp,	#300
    str	x18,	[sp, fp]

    movz	fp,	#964
    add	x18,	sp,	#304
    str	x18,	[sp, fp]

    movz	fp,	#972
    add	x18,	sp,	#308
    str	x18,	[sp, fp]

    movz	fp,	#980
    add	x18,	sp,	#312
    str	x18,	[sp, fp]

    movz	fp,	#988
    add	x18,	sp,	#316
    str	x18,	[sp, fp]

    movz	fp,	#996
    add	x18,	sp,	#320
    str	x18,	[sp, fp]

    movz	fp,	#1004
    add	x18,	sp,	#324
    str	x18,	[sp, fp]

    movz	fp,	#1012
    add	x18,	sp,	#328
    str	x18,	[sp, fp]

    movz	fp,	#1020
    add	x18,	sp,	#332
    str	x18,	[sp, fp]

    movz	fp,	#1028
    add	x18,	sp,	#336
    str	x18,	[sp, fp]

    movz	fp,	#1036
    add	x18,	sp,	#340
    str	x18,	[sp, fp]

    movz	fp,	#1044
    add	x18,	sp,	#344
    str	x18,	[sp, fp]

    movz	fp,	#1052
    add	x18,	sp,	#348
    str	x18,	[sp, fp]

    movz	fp,	#1060
    add	x18,	sp,	#352
    str	x18,	[sp, fp]

    movz	fp,	#1068
    add	x18,	sp,	#356
    str	x18,	[sp, fp]

    movz	fp,	#1076
    add	x18,	sp,	#360
    str	x18,	[sp, fp]

    movz	fp,	#1084
    add	x18,	sp,	#364
    str	x18,	[sp, fp]

    movz	fp,	#1092
    add	x18,	sp,	#368
    str	x18,	[sp, fp]

    movz	fp,	#1100
    add	x18,	sp,	#372
    str	x18,	[sp, fp]

    movz	fp,	#1108
    add	x18,	sp,	#376
    str	x18,	[sp, fp]

    movz	fp,	#1116
    add	x18,	sp,	#380
    str	x18,	[sp, fp]

    movz	fp,	#1124
    add	x18,	sp,	#384
    str	x18,	[sp, fp]

    movz	fp,	#1132
    add	x18,	sp,	#388
    str	x18,	[sp, fp]

    movz	fp,	#1140
    add	x18,	sp,	#392
    str	x18,	[sp, fp]

    movz	fp,	#1148
    add	x18,	sp,	#396
    str	x18,	[sp, fp]

    movz	fp,	#1156
    add	x18,	sp,	#400
    str	x18,	[sp, fp]

    movz	fp,	#1164
    add	x18,	sp,	#404
    str	x18,	[sp, fp]

    movz	fp,	#1172
    add	x18,	sp,	#408
    str	x18,	[sp, fp]

    movz	fp,	#1180
    add	x18,	sp,	#412
    str	x18,	[sp, fp]

    movz	w18,	#0
    str	w18,	[sp, #1192]

    movz	w18,	#0
    str	w18,	[sp, #1188]


main_113:
    ldr	w18,	[sp, #1200]

    cmp	w18,	#1
    ble	main_413

main_117:
    movz	w18,	#1
    movz	fp,	#1244
    ldr	x10,	[sp, fp]

    str	w18,	[x10]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#2
    ble	main_413

main_119:
    movz	w18,	#2
    movz	fp,	#1884
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#3
    ble	main_413

main_121:
    movz	w18,	#3
    movz	fp,	#604
    ldr	x11,	[sp, fp]

    str	w18,	[x11]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#4
    ble	main_413

main_123:
    movz	w18,	#4
    movz	fp,	#596
    ldr	x8,	[sp, fp]

    str	w18,	[x8]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#5
    ble	main_413

main_125:
    movz	w18,	#5
    movz	fp,	#1892
    ldr	x2,	[sp, fp]

    str	w18,	[x2]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#6
    ble	main_413

main_127:
    movz	w18,	#6
    movz	fp,	#1804
    ldr	x27,	[sp, fp]

    str	w18,	[x27]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#7
    ble	main_413

main_129:
    movz	w18,	#7
    movz	fp,	#1796
    ldr	x24,	[sp, fp]

    str	w18,	[x24]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#8
    ble	main_413

main_131:
    movz	w18,	#8
    movz	fp,	#1828
    ldr	x6,	[sp, fp]

    str	w18,	[x6]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#9
    ble	main_413

main_133:
    movz	w18,	#9
    movz	fp,	#1836
    ldr	x9,	[sp, fp]

    str	w18,	[x9]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#10
    ble	main_413

main_135:
    movz	w18,	#10
    movz	fp,	#1220
    ldr	x1,	[sp, fp]

    str	w18,	[x1]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#11
    ble	main_413

main_137:
    movz	w18,	#11
    movz	fp,	#1236
    ldr	x7,	[sp, fp]

    str	w18,	[x7]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#12
    ble	main_413

main_139:
    movz	w18,	#12
    movz	fp,	#636
    ldr	x25,	[sp, fp]

    str	w18,	[x25]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#13
    ble	main_413

main_141:
    movz	w18,	#13
    movz	fp,	#628
    ldr	x22,	[sp, fp]

    str	w18,	[x22]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#14
    ble	main_413

main_143:
    movz	w18,	#14
    movz	fp,	#1780
    ldr	x16,	[sp, fp]

    str	w18,	[x16]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#15
    ble	main_413

main_145:
    movz	w18,	#15
    movz	fp,	#1852
    ldr	x15,	[sp, fp]

    str	w18,	[x15]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#16
    ble	main_413

main_147:
    movz	w18,	#16
    movz	fp,	#612
    ldr	x14,	[sp, fp]

    str	w18,	[x14]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#17
    ble	main_413

main_149:
    movz	w18,	#17
    movz	fp,	#620
    ldr	x17,	[sp, fp]

    str	w18,	[x17]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#18
    ble	main_413

main_151:
    movz	w18,	#18
    movz	fp,	#1820
    ldr	x3,	[sp, fp]

    str	w18,	[x3]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#19
    ble	main_413

main_153:
    movz	w18,	#19
    movz	fp,	#1788
    ldr	x21,	[sp, fp]

    str	w18,	[x21]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#20
    ble	main_413

main_155:
    movz	w18,	#20
    movz	fp,	#1228
    ldr	x4,	[sp, fp]

    str	w18,	[x4]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#21
    ble	main_413

main_157:
    movz	w18,	#21
    movz	fp,	#1252
    ldr	x13,	[sp, fp]

    str	w18,	[x13]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#22
    ble	main_413

main_159:
    movz	w18,	#22
    movz	fp,	#1900
    ldr	x5,	[sp, fp]

    str	w18,	[x5]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#23
    ble	main_413

main_161:
    movz	w18,	#23
    movz	fp,	#1876
    ldr	x26,	[sp, fp]

    str	w18,	[x26]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#24
    ble	main_413

main_163:
    movz	w18,	#24
    movz	fp,	#1860
    ldr	x20,	[sp, fp]

    str	w18,	[x20]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#25
    ble	main_413

main_165:
    movz	w18,	#25
    movz	fp,	#1868
    ldr	x23,	[sp, fp]

    str	w18,	[x23]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#26
    ble	main_413

main_167:
    movz	w18,	#26
    movz	fp,	#1212
    ldr	x28,	[sp, fp]

    str	w18,	[x28]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#27
    ble	main_413

main_169:
    movz	w18,	#27
    movz	fp,	#1844
    ldr	x12,	[sp, fp]

    str	w18,	[x12]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#28
    ble	main_413

main_171:
    movz	w18,	#28
    movz	fp,	#1812
    ldr	x0,	[sp, fp]

    str	w18,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#29
    ble	main_413

main_173:
    movz	w18,	#29
    movz	fp,	#580
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3360]

    ldr	x22,	[sp, #3360]

    str	w18,	[x22]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#30
    ble	main_413

main_175:
    movz	w18,	#30
    movz	fp,	#588
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3368]

    ldr	x25,	[sp, #3368]

    str	w18,	[x25]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#31
    ble	main_413

main_177:
    movz	w18,	#31
    movz	fp,	#644
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3376]

    ldr	x28,	[sp, #3376]

    str	w18,	[x28]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#32
    ble	main_413

main_179:
    movz	w18,	#32
    movz	fp,	#652
    mov	w20,	w18
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3392]

    ldr	x2,	[sp, #3392]

    str	w20,	[x2]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#33
    ble	main_413

main_181:
    movz	w18,	#33
    movz	fp,	#660
    mov	w20,	w18
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3384]

    ldr	x5,	[sp, #3384]

    str	w20,	[x5]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#34
    ble	main_413

main_183:
    movz	w18,	#34
    ldr	x4,	[sp, #752]

    movz	fp,	#2508
    mov	w20,	w18
    str	x4,	[sp, fp]

    movz	fp,	#2508
    ldr	x5,	[sp, fp]

    str	w20,	[x5]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#35
    ble	main_413

main_185:
    movz	w18,	#35
    ldr	x1,	[sp, #760]

    movz	fp,	#2500
    mov	w20,	w18
    str	x1,	[sp, fp]

    movz	fp,	#2500
    ldr	x2,	[sp, fp]

    str	w20,	[x2]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#36
    ble	main_413

main_187:
    movz	w18,	#36
    ldr	x27,	[sp, #768]

    movz	fp,	#2492
    str	x27,	[sp, fp]

    movz	fp,	#2492
    ldr	x28,	[sp, fp]

    str	w18,	[x28]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#37
    ble	main_413

main_189:
    movz	w18,	#37
    movz	fp,	#780
    ldr	x24,	[sp, fp]

    movz	fp,	#2484
    str	x24,	[sp, fp]

    movz	fp,	#2484
    ldr	x25,	[sp, fp]

    str	w18,	[x25]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#38
    ble	main_413

main_191:
    movz	w18,	#38
    movz	fp,	#788
    ldr	x21,	[sp, fp]

    movz	fp,	#2476
    str	x21,	[sp, fp]

    movz	fp,	#2476
    ldr	x22,	[sp, fp]

    str	w18,	[x22]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#39
    ble	main_413

main_193:
    movz	w18,	#39
    movz	fp,	#796
    mov	w20,	w18
    ldr	x18,	[sp, fp]

    movz	fp,	#2468
    str	x18,	[sp, fp]

    movz	fp,	#2468
    ldr	x19,	[sp, fp]

    str	w20,	[x19]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#40
    ble	main_413

main_195:
    movz	w18,	#40
    movz	fp,	#804
    mov	w20,	w18
    ldr	x15,	[sp, fp]

    movz	fp,	#2460
    str	x15,	[sp, fp]

    movz	fp,	#2460
    ldr	x16,	[sp, fp]

    str	w20,	[x16]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#41
    ble	main_413

main_197:
    movz	w18,	#41
    movz	fp,	#812
    mov	w20,	w18
    ldr	x12,	[sp, fp]

    movz	fp,	#2452
    str	x12,	[sp, fp]

    movz	fp,	#2452
    ldr	x13,	[sp, fp]

    str	w20,	[x13]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#42
    ble	main_413

main_199:
    movz	w18,	#42
    movz	fp,	#820
    mov	w20,	w18
    ldr	x9,	[sp, fp]

    movz	fp,	#2444
    str	x9,	[sp, fp]

    movz	fp,	#2444
    ldr	x10,	[sp, fp]

    str	w20,	[x10]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#43
    ble	main_413

main_201:
    movz	w18,	#43
    ldr	x6,	[sp, #672]

    movz	fp,	#2436
    mov	w20,	w18
    str	x6,	[sp, fp]

    movz	fp,	#2436
    ldr	x7,	[sp, fp]

    str	w20,	[x7]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#44
    ble	main_413

main_203:
    movz	w18,	#44
    ldr	x3,	[sp, #680]

    movz	fp,	#2428
    mov	w20,	w18
    str	x3,	[sp, fp]

    movz	fp,	#2428
    ldr	x4,	[sp, fp]

    str	w20,	[x4]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#45
    ble	main_413

main_205:
    movz	w18,	#45
    ldr	x0,	[sp, #688]

    movz	fp,	#2244
    mov	w20,	w18
    str	x0,	[sp, fp]

    movz	fp,	#2244
    ldr	x1,	[sp, fp]

    str	w20,	[x1]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#46
    ble	main_413

main_207:
    movz	w18,	#46
    ldr	x26,	[sp, #696]

    movz	fp,	#2236
    str	x26,	[sp, fp]

    movz	fp,	#2236
    ldr	x27,	[sp, fp]

    str	w18,	[x27]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#47
    ble	main_413

main_209:
    movz	w18,	#47
    ldr	x23,	[sp, #704]

    movz	fp,	#2228
    str	x23,	[sp, fp]

    movz	fp,	#2228
    ldr	x24,	[sp, fp]

    str	w18,	[x24]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#48
    ble	main_413

main_211:
    movz	w18,	#48
    ldr	x20,	[sp, #712]

    movz	fp,	#2220
    str	x20,	[sp, fp]

    movz	fp,	#2220
    ldr	x21,	[sp, fp]

    str	w18,	[x21]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#49
    ble	main_413

main_213:
    movz	w18,	#49
    ldr	x17,	[sp, #720]

    movz	fp,	#2212
    mov	w20,	w18
    str	x17,	[sp, fp]

    movz	fp,	#2212
    ldr	x18,	[sp, fp]

    str	w20,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#50
    ble	main_413

main_215:
    movz	w18,	#50
    ldr	x14,	[sp, #728]

    movz	fp,	#2204
    mov	w20,	w18
    str	x14,	[sp, fp]

    movz	fp,	#2204
    ldr	x15,	[sp, fp]

    str	w20,	[x15]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#51
    ble	main_413

main_217:
    movz	w18,	#51
    ldr	x11,	[sp, #744]

    movz	fp,	#2196
    mov	w20,	w18
    str	x11,	[sp, fp]

    movz	fp,	#2196
    ldr	x12,	[sp, fp]

    str	w20,	[x12]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#52
    ble	main_413

main_219:
    movz	w18,	#52
    movz	fp,	#828
    mov	w20,	w18
    ldr	x8,	[sp, fp]

    movz	fp,	#2188
    str	x8,	[sp, fp]

    movz	fp,	#2188
    ldr	x9,	[sp, fp]

    str	w20,	[x9]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#53
    ble	main_413

main_221:
    movz	w18,	#53
    movz	fp,	#836
    mov	w20,	w18
    ldr	x5,	[sp, fp]

    movz	fp,	#2180
    str	x5,	[sp, fp]

    movz	fp,	#2180
    ldr	x6,	[sp, fp]

    str	w20,	[x6]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#54
    ble	main_413

main_223:
    movz	w18,	#54
    ldr	x2,	[sp, #736]

    movz	fp,	#2172
    mov	w20,	w18
    str	x2,	[sp, fp]

    movz	fp,	#2172
    ldr	x3,	[sp, fp]

    str	w20,	[x3]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#55
    ble	main_413

main_225:
    movz	w18,	#55
    ldr	x28,	[sp, #416]

    movz	fp,	#2164
    mov	w19,	w18
    str	x28,	[sp, fp]

    movz	fp,	#2164
    ldr	x0,	[sp, fp]

    str	w19,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#56
    ble	main_413

main_227:
    movz	w18,	#56
    ldr	x25,	[sp, #424]

    movz	fp,	#2156
    str	x25,	[sp, fp]

    movz	fp,	#2156
    ldr	x26,	[sp, fp]

    str	w18,	[x26]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#57
    ble	main_413

main_229:
    movz	w18,	#57
    movz	fp,	#844
    ldr	x22,	[sp, fp]

    movz	fp,	#2148
    str	x22,	[sp, fp]

    movz	fp,	#2148
    ldr	x23,	[sp, fp]

    str	w18,	[x23]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#58
    ble	main_413

main_231:
    movz	w18,	#58
    movz	fp,	#852
    ldr	x19,	[sp, fp]

    movz	fp,	#2140
    str	x19,	[sp, fp]

    movz	fp,	#2140
    ldr	x20,	[sp, fp]

    str	w18,	[x20]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#59
    ble	main_413

main_233:
    movz	w18,	#59
    movz	fp,	#860
    mov	w20,	w18
    ldr	x16,	[sp, fp]

    movz	fp,	#2132
    str	x16,	[sp, fp]

    movz	fp,	#2132
    ldr	x17,	[sp, fp]

    str	w20,	[x17]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#60
    ble	main_413

main_235:
    movz	w18,	#60
    movz	fp,	#868
    mov	w20,	w18
    ldr	x13,	[sp, fp]

    movz	fp,	#2124
    str	x13,	[sp, fp]

    movz	fp,	#2124
    ldr	x14,	[sp, fp]

    str	w20,	[x14]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#61
    ble	main_413

main_237:
    movz	w18,	#61
    movz	fp,	#876
    mov	w20,	w18
    ldr	x10,	[sp, fp]

    movz	fp,	#2116
    str	x10,	[sp, fp]

    movz	fp,	#2116
    ldr	x11,	[sp, fp]

    str	w20,	[x11]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#62
    ble	main_413

main_239:
    movz	w18,	#62
    movz	fp,	#884
    mov	w20,	w18
    ldr	x7,	[sp, fp]

    movz	fp,	#2108
    str	x7,	[sp, fp]

    movz	fp,	#2108
    ldr	x8,	[sp, fp]

    str	w20,	[x8]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#63
    ble	main_413

main_241:
    movz	w18,	#63
    movz	fp,	#892
    mov	w20,	w18
    ldr	x4,	[sp, fp]

    movz	fp,	#2100
    str	x4,	[sp, fp]

    movz	fp,	#2100
    ldr	x5,	[sp, fp]

    str	w20,	[x5]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#64
    ble	main_413

main_243:
    movz	w18,	#64
    movz	fp,	#900
    mov	w20,	w18
    ldr	x1,	[sp, fp]

    movz	fp,	#2092
    str	x1,	[sp, fp]

    movz	fp,	#2092
    ldr	x2,	[sp, fp]

    str	w20,	[x2]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#65
    ble	main_413

main_245:
    movz	w18,	#65
    movz	fp,	#908
    ldr	x27,	[sp, fp]

    movz	fp,	#2084
    str	x27,	[sp, fp]

    movz	fp,	#2084
    ldr	x28,	[sp, fp]

    str	w18,	[x28]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#66
    ble	main_413

main_247:
    movz	w18,	#66
    movz	fp,	#916
    ldr	x24,	[sp, fp]

    movz	fp,	#2076
    str	x24,	[sp, fp]

    movz	fp,	#2076
    ldr	x25,	[sp, fp]

    str	w18,	[x25]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#67
    ble	main_413

main_249:
    movz	w18,	#67
    movz	fp,	#924
    ldr	x21,	[sp, fp]

    movz	fp,	#2068
    str	x21,	[sp, fp]

    movz	fp,	#2068
    ldr	x22,	[sp, fp]

    str	w18,	[x22]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#68
    ble	main_413

main_251:
    movz	w18,	#68
    movz	fp,	#932
    mov	w20,	w18
    ldr	x18,	[sp, fp]

    movz	fp,	#2060
    str	x18,	[sp, fp]

    movz	fp,	#2060
    ldr	x19,	[sp, fp]

    str	w20,	[x19]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#69
    ble	main_413

main_253:
    movz	w18,	#69
    movz	fp,	#940
    mov	w20,	w18
    ldr	x15,	[sp, fp]

    movz	fp,	#2052
    str	x15,	[sp, fp]

    movz	fp,	#2052
    ldr	x16,	[sp, fp]

    str	w20,	[x16]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#70
    ble	main_413

main_255:
    movz	w18,	#70
    movz	fp,	#948
    mov	w20,	w18
    ldr	x12,	[sp, fp]

    movz	fp,	#2044
    str	x12,	[sp, fp]

    movz	fp,	#2044
    ldr	x13,	[sp, fp]

    str	w20,	[x13]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#71
    ble	main_413

main_257:
    movz	w18,	#71
    movz	fp,	#956
    mov	w20,	w18
    ldr	x9,	[sp, fp]

    movz	fp,	#2036
    str	x9,	[sp, fp]

    movz	fp,	#2036
    ldr	x10,	[sp, fp]

    str	w20,	[x10]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#72
    ble	main_413

main_259:
    movz	w18,	#72
    movz	fp,	#964
    mov	w20,	w18
    ldr	x6,	[sp, fp]

    movz	fp,	#2340
    str	x6,	[sp, fp]

    movz	fp,	#2340
    ldr	x7,	[sp, fp]

    str	w20,	[x7]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#73
    ble	main_413

main_261:
    movz	w18,	#73
    movz	fp,	#972
    mov	w20,	w18
    ldr	x3,	[sp, fp]

    movz	fp,	#2332
    str	x3,	[sp, fp]

    movz	fp,	#2332
    ldr	x4,	[sp, fp]

    str	w20,	[x4]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#74
    ble	main_413

main_263:
    movz	w18,	#74
    movz	fp,	#980
    mov	w20,	w18
    ldr	x0,	[sp, fp]

    movz	fp,	#2324
    str	x0,	[sp, fp]

    movz	fp,	#2324
    ldr	x1,	[sp, fp]

    str	w20,	[x1]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#75
    ble	main_413

main_265:
    movz	w18,	#75
    movz	fp,	#988
    ldr	x26,	[sp, fp]

    movz	fp,	#2316
    str	x26,	[sp, fp]

    movz	fp,	#2316
    ldr	x27,	[sp, fp]

    str	w18,	[x27]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#76
    ble	main_413

main_267:
    movz	w18,	#76
    movz	fp,	#996
    ldr	x23,	[sp, fp]

    movz	fp,	#2308
    str	x23,	[sp, fp]

    movz	fp,	#2308
    ldr	x24,	[sp, fp]

    str	w18,	[x24]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#77
    ble	main_413

main_269:
    movz	w18,	#77
    movz	fp,	#1004
    ldr	x20,	[sp, fp]

    movz	fp,	#2300
    str	x20,	[sp, fp]

    movz	fp,	#2300
    ldr	x21,	[sp, fp]

    str	w18,	[x21]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#78
    ble	main_413

main_271:
    movz	w18,	#78
    movz	fp,	#1012
    mov	w20,	w18
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #3448]

    ldr	x18,	[sp, #3448]

    str	w20,	[x18]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#79
    ble	main_413

main_273:
    movz	w18,	#79
    movz	fp,	#1020
    mov	w20,	w18
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #3440]

    ldr	x15,	[sp, #3440]

    str	w20,	[x15]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#80
    ble	main_413

main_275:
    movz	w18,	#80
    movz	fp,	#1028
    mov	w20,	w18
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #3432]

    ldr	x12,	[sp, #3432]

    str	w20,	[x12]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#81
    ble	main_413

main_277:
    movz	w18,	#81
    movz	fp,	#1036
    mov	w20,	w18
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #3424]

    ldr	x9,	[sp, #3424]

    str	w20,	[x9]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#82
    ble	main_413

main_279:
    movz	w18,	#82
    movz	fp,	#1044
    mov	w20,	w18
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #3416]

    ldr	x6,	[sp, #3416]

    str	w20,	[x6]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#83
    ble	main_413

main_281:
    movz	w18,	#83
    movz	fp,	#1052
    mov	w20,	w18
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #3408]

    ldr	x3,	[sp, #3408]

    str	w20,	[x3]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#84
    ble	main_413

main_283:
    movz	w18,	#84
    movz	fp,	#1060
    mov	w19,	w18
    ldr	x28,	[sp, fp]

    movz	fp,	#2420
    str	x28,	[sp, fp]

    movz	fp,	#2420
    ldr	x0,	[sp, fp]

    str	w19,	[x0]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#85
    ble	main_413

main_285:
    movz	w18,	#85
    movz	fp,	#1068
    ldr	x25,	[sp, fp]

    movz	fp,	#2412
    str	x25,	[sp, fp]

    movz	fp,	#2412
    ldr	x26,	[sp, fp]

    str	w18,	[x26]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#86
    ble	main_413

main_287:
    movz	w18,	#86
    movz	fp,	#1076
    ldr	x22,	[sp, fp]

    movz	fp,	#2404
    str	x22,	[sp, fp]

    movz	fp,	#2404
    ldr	x23,	[sp, fp]

    str	w18,	[x23]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#87
    ble	main_413

main_289:
    movz	w18,	#87
    movz	fp,	#1084
    ldr	x19,	[sp, fp]

    movz	fp,	#2396
    str	x19,	[sp, fp]

    movz	fp,	#2396
    ldr	x20,	[sp, fp]

    str	w18,	[x20]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#88
    ble	main_413

main_291:
    movz	w18,	#88
    movz	fp,	#1092
    mov	w20,	w18
    ldr	x16,	[sp, fp]

    movz	fp,	#2388
    str	x16,	[sp, fp]

    movz	fp,	#2388
    ldr	x17,	[sp, fp]

    str	w20,	[x17]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#89
    ble	main_413

main_293:
    movz	w18,	#89
    movz	fp,	#1100
    mov	w20,	w18
    ldr	x13,	[sp, fp]

    movz	fp,	#2284
    str	x13,	[sp, fp]

    movz	fp,	#2284
    ldr	x14,	[sp, fp]

    str	w20,	[x14]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#90
    ble	main_413

main_295:
    movz	w18,	#90
    movz	fp,	#1108
    mov	w20,	w18
    ldr	x10,	[sp, fp]

    movz	fp,	#2276
    str	x10,	[sp, fp]

    movz	fp,	#2276
    ldr	x11,	[sp, fp]

    str	w20,	[x11]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#91
    ble	main_413

main_297:
    movz	w18,	#91
    movz	fp,	#1116
    mov	w20,	w18
    ldr	x7,	[sp, fp]

    movz	fp,	#2268
    str	x7,	[sp, fp]

    movz	fp,	#2268
    ldr	x8,	[sp, fp]

    str	w20,	[x8]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#92
    ble	main_413

main_299:
    movz	w18,	#92
    movz	fp,	#1124
    mov	w20,	w18
    ldr	x4,	[sp, fp]

    movz	fp,	#2260
    str	x4,	[sp, fp]

    movz	fp,	#2260
    ldr	x5,	[sp, fp]

    str	w20,	[x5]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#93
    ble	main_413

main_301:
    movz	w18,	#93
    movz	fp,	#1132
    mov	w20,	w18
    ldr	x1,	[sp, fp]

    movz	fp,	#2380
    str	x1,	[sp, fp]

    movz	fp,	#2380
    ldr	x2,	[sp, fp]

    str	w20,	[x2]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#94
    ble	main_413

main_303:
    movz	w18,	#94
    movz	fp,	#1140
    ldr	x27,	[sp, fp]

    movz	fp,	#2372
    str	x27,	[sp, fp]

    movz	fp,	#2372
    ldr	x28,	[sp, fp]

    str	w18,	[x28]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#95
    ble	main_413

main_305:
    movz	w18,	#95
    movz	fp,	#1148
    ldr	x24,	[sp, fp]

    movz	fp,	#2364
    str	x24,	[sp, fp]

    movz	fp,	#2364
    ldr	x25,	[sp, fp]

    str	w18,	[x25]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#96
    ble	main_413

main_307:
    movz	w18,	#96
    movz	fp,	#1156
    ldr	x21,	[sp, fp]

    movz	fp,	#2356
    str	x21,	[sp, fp]

    movz	fp,	#2356
    ldr	x22,	[sp, fp]

    str	w18,	[x22]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#97
    ble	main_413

main_309:
    movz	w18,	#97
    movz	fp,	#1164
    mov	w20,	w18
    ldr	x18,	[sp, fp]

    movz	fp,	#2348
    str	x18,	[sp, fp]

    movz	fp,	#2348
    ldr	x19,	[sp, fp]

    str	w20,	[x19]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#98
    ble	main_413

main_311:
    movz	w18,	#98
    movz	fp,	#1172
    mov	w20,	w18
    ldr	x15,	[sp, fp]

    movz	fp,	#2252
    str	x15,	[sp, fp]

    movz	fp,	#2252
    ldr	x16,	[sp, fp]

    str	w20,	[x16]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#99
    ble	main_413

main_313:
    movz	w18,	#99
    movz	fp,	#1180
    mov	w20,	w18
    ldr	x12,	[sp, fp]

    movz	fp,	#2292
    str	x12,	[sp, fp]

    movz	fp,	#2292
    ldr	x13,	[sp, fp]

    str	w20,	[x13]


main_413:
    ldr	w18,	[sp, #1188]

    add	w18,	w18,	#1
    str	w18,	[sp, #440]

    ldr	w18,	[sp, #1192]

    str	w18,	[sp, #776]

    movz	w18,	#0
    str	w18,	[sp, #668]


main_415:
    ldr	w18,	[sp, #668]

    cmp	w18,	#100
    bge	main_424

main_419:
    ldr	w18,	[sp, #668]

    lsl	w18,	w18,	#2
    mov	x18,	x18
    add	x18,	sp,	x18
    add	x18,	x18,	#16
    ldr	w20,	[x18]

    ldr	w13,	[sp, #776]

    str	w13,	[sp, #3180]

    ldr	w14,	[sp, #3180]

    ldr	w10,	[sp, #668]

    add	w22,	w20,	w14
    str	w10,	[sp, #3176]

    mov	w18,	w22
    ldr	w11,	[sp, #3176]

    add	w4,	w11,	#1
    str	w4,	[sp, #3168]

    ldr	w5,	[sp, #3168]

    str	w5,	[sp, #432]

    str	w18,	[sp, #776]

    ldr	w18,	[sp, #432]

    str	w18,	[sp, #668]

    b	main_415

main_424:
    movz	w18,	#65535
    ldr	w16,	[sp, #776]

    mov	w20,	w18
    str	w16,	[sp, #3184]

    ldr	w17,	[sp, #3184]

    sdiv	w18,	w17,	w20
    str	w18,	[sp, #436]

    ldr	w18,	[sp, #436]

    ldr	w7,	[sp, #436]

    lsl	w20,	w18,	#16
    str	w7,	[sp, #3172]

    ldr	w8,	[sp, #3172]

    ldr	w19,	[sp, #776]

    sub	w18,	w20,	w8,	lsl #0
    str	w19,	[sp, #3188]

    ldr	w20,	[sp, #3188]

    ldr	w7,	[sp, #440]

    sub	w21,	w20,	w18
    str	w7,	[sp, #2516]

    ldr	w22,	[sp, #1196]

    str	w22,	[sp, #3192]

    ldr	w8,	[sp, #2516]

    ldr	w0,	[sp, #3192]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w18,	w21
    str	w18,	[sp, #1192]

    ldr	w18,	[sp, #440]

    str	w18,	[sp, #1188]

    b	main_113

main_428:
    mov	w0,	w21
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


