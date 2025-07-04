.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#4208
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1276]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1280]

    mov	w0,	w26

main_4:
    cmp	w0,	#100
    blt	main_7

main_10:
    movz	w25,	#0
    ldr	w15,	[sp, #1276]

    mov	w26,	w25
    cmp	w26,	w15
    blt	main_12

main_427:
    movz	w0,	#0
    b	main_429

main_12:
    add	x22,	sp,	#20
    movz	fp,	#1316
    add	x15,	sp,	#24
    add	x1,	sp,	#28
    add	x7,	sp,	#32
    add	x10,	sp,	#36
    add	x28,	sp,	#40
    add	x9,	sp,	#44
    add	x19,	sp,	#48
    add	x6,	sp,	#52
    add	x24,	sp,	#56
    add	x27,	sp,	#60
    add	x26,	sp,	#64
    add	x25,	sp,	#68
    add	x21,	sp,	#72
    add	x0,	sp,	#76
    add	x17,	sp,	#80
    add	x18,	sp,	#84
    add	x23,	sp,	#88
    add	x5,	sp,	#92
    add	x3,	sp,	#96
    add	x8,	sp,	#100
    add	x16,	sp,	#104
    add	x2,	sp,	#108
    add	x4,	sp,	#112
    add	x14,	sp,	#116
    add	x13,	sp,	#120
    add	x11,	sp,	#124
    add	x20,	sp,	#128
    add	x12,	sp,	#132
    str	x22,	[sp, fp]

    movz	fp,	#740
    str	x15,	[sp, fp]

    movz	fp,	#1724
    str	x1,	[sp, fp]

    movz	fp,	#1740
    str	x7,	[sp, fp]

    movz	fp,	#1284
    str	x10,	[sp, fp]

    movz	fp,	#1460
    str	x28,	[sp, fp]

    movz	fp,	#1804
    str	x9,	[sp, fp]

    movz	fp,	#1308
    str	x19,	[sp, fp]

    movz	fp,	#1796
    str	x6,	[sp, fp]

    movz	fp,	#1708
    str	x24,	[sp, fp]

    movz	fp,	#1716
    str	x27,	[sp, fp]

    movz	fp,	#1772
    str	x26,	[sp, fp]

    movz	fp,	#1324
    str	x25,	[sp, fp]

    movz	fp,	#756
    str	x21,	[sp, fp]

    movz	fp,	#1780
    str	x0,	[sp, fp]

    movz	fp,	#1748
    str	x17,	[sp, fp]

    movz	fp,	#748
    str	x18,	[sp, fp]

    movz	fp,	#1764
    str	x23,	[sp, fp]

    movz	fp,	#1476
    str	x5,	[sp, fp]

    movz	fp,	#1788
    str	x3,	[sp, fp]

    movz	fp,	#1484
    str	x8,	[sp, fp]

    movz	fp,	#1300
    str	x16,	[sp, fp]

    movz	fp,	#1468
    str	x2,	[sp, fp]

    movz	fp,	#1732
    str	x4,	[sp, fp]

    movz	fp,	#1500
    str	x14,	[sp, fp]

    movz	fp,	#1292
    str	x13,	[sp, fp]

    movz	fp,	#1492
    str	x11,	[sp, fp]

    movz	fp,	#1756
    str	x20,	[sp, fp]

    movz	fp,	#796
    str	x12,	[sp, #432]

    add	x12,	sp,	#136
    str	x12,	[sp, fp]

    movz	fp,	#476
    add	x12,	sp,	#140
    str	x12,	[sp, fp]

    movz	fp,	#764
    add	x12,	sp,	#144
    str	x12,	[sp, fp]

    movz	fp,	#772
    add	x12,	sp,	#148
    str	x12,	[sp, fp]

    movz	fp,	#780
    add	x12,	sp,	#152
    str	x12,	[sp, fp]

    movz	fp,	#788
    add	x12,	sp,	#156
    str	x12,	[sp, fp]

    movz	fp,	#444
    add	x12,	sp,	#160
    str	x12,	[sp, fp]

    movz	fp,	#452
    add	x12,	sp,	#164
    str	x12,	[sp, fp]

    movz	fp,	#460
    add	x12,	sp,	#168
    str	x12,	[sp, fp]

    movz	fp,	#468
    add	x12,	sp,	#172
    str	x12,	[sp, fp]

    movz	fp,	#804
    add	x12,	sp,	#176
    str	x12,	[sp, fp]

    movz	fp,	#812
    add	x12,	sp,	#180
    str	x12,	[sp, fp]

    movz	fp,	#820
    add	x12,	sp,	#184
    str	x12,	[sp, fp]

    movz	fp,	#828
    add	x12,	sp,	#188
    str	x12,	[sp, fp]

    movz	fp,	#836
    add	x12,	sp,	#192
    str	x12,	[sp, fp]

    movz	fp,	#844
    add	x12,	sp,	#196
    str	x12,	[sp, fp]

    movz	fp,	#852
    add	x12,	sp,	#200
    str	x12,	[sp, fp]

    movz	fp,	#860
    add	x12,	sp,	#204
    str	x12,	[sp, fp]

    movz	fp,	#868
    add	x12,	sp,	#208
    str	x12,	[sp, fp]

    movz	fp,	#884
    add	x12,	sp,	#212
    str	x12,	[sp, fp]

    movz	fp,	#892
    add	x12,	sp,	#216
    str	x12,	[sp, fp]

    movz	fp,	#900
    add	x12,	sp,	#220
    str	x12,	[sp, fp]

    movz	fp,	#908
    add	x12,	sp,	#224
    str	x12,	[sp, fp]

    movz	fp,	#916
    add	x12,	sp,	#228
    str	x12,	[sp, fp]

    movz	fp,	#876
    add	x12,	sp,	#232
    str	x12,	[sp, fp]

    movz	fp,	#924
    add	x12,	sp,	#236
    str	x12,	[sp, #416]

    add	x12,	sp,	#240
    str	x12,	[sp, #424]

    add	x12,	sp,	#244
    str	x12,	[sp, fp]

    movz	fp,	#932
    add	x12,	sp,	#248
    str	x12,	[sp, fp]

    movz	fp,	#940
    add	x12,	sp,	#252
    str	x12,	[sp, fp]

    movz	fp,	#948
    add	x12,	sp,	#256
    str	x12,	[sp, fp]

    movz	fp,	#956
    add	x12,	sp,	#260
    str	x12,	[sp, fp]

    movz	fp,	#964
    add	x12,	sp,	#264
    str	x12,	[sp, fp]

    movz	fp,	#972
    add	x12,	sp,	#268
    str	x12,	[sp, fp]

    movz	fp,	#980
    add	x12,	sp,	#272
    str	x12,	[sp, fp]

    movz	fp,	#988
    add	x12,	sp,	#276
    str	x12,	[sp, fp]

    movz	fp,	#996
    add	x12,	sp,	#280
    str	x12,	[sp, fp]

    movz	fp,	#1004
    add	x12,	sp,	#284
    str	x12,	[sp, fp]

    movz	fp,	#1012
    add	x12,	sp,	#288
    str	x12,	[sp, fp]

    movz	fp,	#1020
    add	x12,	sp,	#292
    str	x12,	[sp, fp]

    movz	fp,	#1028
    add	x12,	sp,	#296
    str	x12,	[sp, fp]

    movz	fp,	#1036
    add	x12,	sp,	#300
    str	x12,	[sp, fp]

    movz	fp,	#1044
    add	x12,	sp,	#304
    str	x12,	[sp, fp]

    movz	fp,	#1052
    add	x12,	sp,	#308
    str	x12,	[sp, fp]

    movz	fp,	#1060
    add	x12,	sp,	#312
    str	x12,	[sp, fp]

    movz	fp,	#1068
    add	x12,	sp,	#316
    str	x12,	[sp, fp]

    movz	fp,	#1076
    add	x12,	sp,	#320
    str	x12,	[sp, fp]

    movz	fp,	#1084
    add	x12,	sp,	#324
    str	x12,	[sp, fp]

    movz	fp,	#1092
    add	x12,	sp,	#328
    str	x12,	[sp, fp]

    movz	fp,	#1100
    add	x12,	sp,	#332
    str	x12,	[sp, fp]

    movz	fp,	#1108
    add	x12,	sp,	#336
    str	x12,	[sp, fp]

    movz	fp,	#1116
    add	x12,	sp,	#340
    str	x12,	[sp, fp]

    movz	fp,	#1124
    add	x12,	sp,	#344
    str	x12,	[sp, fp]

    movz	fp,	#1132
    add	x12,	sp,	#348
    str	x12,	[sp, fp]

    movz	fp,	#1140
    add	x12,	sp,	#352
    str	x12,	[sp, fp]

    movz	fp,	#1148
    add	x12,	sp,	#356
    str	x12,	[sp, fp]

    movz	fp,	#1156
    add	x12,	sp,	#360
    str	x12,	[sp, fp]

    movz	fp,	#1164
    add	x12,	sp,	#364
    str	x12,	[sp, fp]

    movz	fp,	#1172
    add	x12,	sp,	#368
    str	x12,	[sp, fp]

    movz	fp,	#1180
    add	x12,	sp,	#372
    str	x12,	[sp, fp]

    movz	fp,	#1188
    add	x12,	sp,	#376
    str	x12,	[sp, fp]

    movz	fp,	#1196
    add	x12,	sp,	#380
    str	x12,	[sp, fp]

    movz	fp,	#1204
    add	x12,	sp,	#384
    str	x12,	[sp, fp]

    movz	fp,	#1212
    add	x12,	sp,	#388
    str	x12,	[sp, fp]

    movz	fp,	#1220
    add	x12,	sp,	#392
    str	x12,	[sp, fp]

    movz	fp,	#1228
    add	x12,	sp,	#396
    str	x12,	[sp, fp]

    movz	fp,	#1236
    add	x12,	sp,	#400
    str	x12,	[sp, fp]

    movz	fp,	#1244
    add	x12,	sp,	#404
    str	x12,	[sp, fp]

    movz	fp,	#1252
    add	x12,	sp,	#408
    str	x12,	[sp, fp]

    movz	fp,	#1260
    add	x12,	sp,	#412
    str	x12,	[sp, fp]

    movz	w12,	#0
    str	w12,	[sp, #1272]

    movz	w12,	#0
    str	w12,	[sp, #1268]


main_113:
    ldr	w12,	[sp, #1280]

    cmp	w12,	#1
    ble	main_413

main_117:
    movz	w12,	#1
    movz	fp,	#1316
    ldr	x18,	[sp, fp]

    str	w12,	[x18]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#2
    ble	main_413

main_119:
    movz	w12,	#2
    movz	fp,	#740
    ldr	x8,	[sp, fp]

    str	w12,	[x8]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#3
    ble	main_413

main_121:
    movz	w12,	#3
    movz	fp,	#1724
    ldr	x25,	[sp, fp]

    str	w12,	[x25]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#4
    ble	main_413

main_123:
    movz	w12,	#4
    movz	fp,	#1740
    ldr	x1,	[sp, fp]

    str	w12,	[x1]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#5
    ble	main_413

main_125:
    movz	w12,	#5
    movz	fp,	#1284
    ldr	x4,	[sp, fp]

    str	w12,	[x4]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#6
    ble	main_413

main_127:
    movz	w12,	#6
    movz	fp,	#1460
    ldr	x24,	[sp, fp]

    str	w12,	[x24]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#7
    ble	main_413

main_129:
    movz	w12,	#7
    movz	fp,	#1804
    ldr	x5,	[sp, fp]

    str	w12,	[x5]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#8
    ble	main_413

main_131:
    movz	w12,	#8
    movz	fp,	#1308
    ldr	x15,	[sp, fp]

    str	w12,	[x15]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#9
    ble	main_413

main_133:
    movz	w12,	#9
    movz	fp,	#1796
    ldr	x2,	[sp, fp]

    str	w12,	[x2]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#10
    ble	main_413

main_135:
    movz	w12,	#10
    movz	fp,	#1708
    ldr	x19,	[sp, fp]

    str	w12,	[x19]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#11
    ble	main_413

main_137:
    movz	w12,	#11
    movz	fp,	#1716
    ldr	x22,	[sp, fp]

    str	w12,	[x22]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#12
    ble	main_413

main_139:
    movz	w12,	#12
    movz	fp,	#1772
    ldr	x23,	[sp, fp]

    str	w12,	[x23]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#13
    ble	main_413

main_141:
    movz	w12,	#13
    movz	fp,	#1324
    ldr	x21,	[sp, fp]

    str	w12,	[x21]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#14
    ble	main_413

main_143:
    movz	w12,	#14
    movz	fp,	#756
    ldr	x16,	[sp, fp]

    str	w12,	[x16]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#15
    ble	main_413

main_145:
    movz	w12,	#15
    movz	fp,	#1780
    ldr	x26,	[sp, fp]

    str	w12,	[x26]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#16
    ble	main_413

main_147:
    movz	w12,	#16
    movz	fp,	#1748
    ldr	x14,	[sp, fp]

    str	w12,	[x14]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#17
    ble	main_413

main_149:
    movz	w12,	#17
    movz	fp,	#748
    ldr	x11,	[sp, fp]

    str	w12,	[x11]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#18
    ble	main_413

main_151:
    movz	w12,	#18
    movz	fp,	#1764
    ldr	x20,	[sp, fp]

    str	w12,	[x20]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#19
    ble	main_413

main_153:
    movz	w12,	#19
    movz	fp,	#1476
    ldr	x0,	[sp, fp]

    str	w12,	[x0]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#20
    ble	main_413

main_155:
    movz	w12,	#20
    movz	fp,	#1788
    ldr	x0,	[sp, fp]

    str	w12,	[x0]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#21
    ble	main_413

main_157:
    movz	w12,	#21
    movz	fp,	#1484
    ldr	x3,	[sp, fp]

    str	w12,	[x3]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#22
    ble	main_413

main_159:
    movz	w12,	#22
    movz	fp,	#1300
    ldr	x10,	[sp, fp]

    str	w12,	[x10]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#23
    ble	main_413

main_161:
    movz	w12,	#23
    movz	fp,	#1468
    ldr	x27,	[sp, fp]

    str	w12,	[x27]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#24
    ble	main_413

main_163:
    movz	w12,	#24
    movz	fp,	#1732
    ldr	x28,	[sp, fp]

    str	w12,	[x28]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#25
    ble	main_413

main_165:
    movz	w12,	#25
    movz	fp,	#1500
    ldr	x9,	[sp, fp]

    str	w12,	[x9]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#26
    ble	main_413

main_167:
    movz	w12,	#26
    movz	fp,	#1292
    ldr	x7,	[sp, fp]

    str	w12,	[x7]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#27
    ble	main_413

main_169:
    movz	w12,	#27
    movz	fp,	#1492
    ldr	x6,	[sp, fp]

    str	w12,	[x6]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#28
    ble	main_413

main_171:
    movz	w12,	#28
    movz	fp,	#1756
    ldr	x17,	[sp, fp]

    str	w12,	[x17]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#29
    ble	main_413

main_173:
    movz	w12,	#29
    ldr	x21,	[sp, #432]

    movz	fp,	#1996
    str	x21,	[sp, fp]

    movz	fp,	#1996
    ldr	x22,	[sp, fp]

    str	w12,	[x22]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#30
    ble	main_413

main_175:
    movz	w12,	#30
    movz	fp,	#796
    ldr	x24,	[sp, fp]

    movz	fp,	#2004
    str	x24,	[sp, fp]

    movz	fp,	#2004
    ldr	x25,	[sp, fp]

    str	w12,	[x25]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#31
    ble	main_413

main_177:
    movz	w12,	#31
    movz	fp,	#476
    ldr	x27,	[sp, fp]

    movz	fp,	#2020
    str	x27,	[sp, fp]

    movz	fp,	#2020
    ldr	x28,	[sp, fp]

    str	w12,	[x28]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#32
    ble	main_413

main_179:
    movz	w12,	#32
    movz	fp,	#764
    mov	w14,	w12
    ldr	x1,	[sp, fp]

    movz	fp,	#2028
    str	x1,	[sp, fp]

    movz	fp,	#2028
    ldr	x2,	[sp, fp]

    str	w14,	[x2]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#33
    ble	main_413

main_181:
    movz	w12,	#33
    movz	fp,	#772
    mov	w14,	w12
    ldr	x4,	[sp, fp]

    movz	fp,	#2012
    str	x4,	[sp, fp]

    movz	fp,	#2012
    ldr	x5,	[sp, fp]

    str	w14,	[x5]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#34
    ble	main_413

main_183:
    movz	w12,	#34
    movz	fp,	#780
    mov	w14,	w12
    ldr	x4,	[sp, fp]

    movz	fp,	#2444
    str	x4,	[sp, fp]

    movz	fp,	#2444
    ldr	x5,	[sp, fp]

    str	w14,	[x5]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#35
    ble	main_413

main_185:
    movz	w12,	#35
    movz	fp,	#788
    mov	w14,	w12
    ldr	x1,	[sp, fp]

    movz	fp,	#2436
    str	x1,	[sp, fp]

    movz	fp,	#2436
    ldr	x2,	[sp, fp]

    str	w14,	[x2]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#36
    ble	main_413

main_187:
    movz	w12,	#36
    movz	fp,	#444
    ldr	x27,	[sp, fp]

    movz	fp,	#2428
    str	x27,	[sp, fp]

    movz	fp,	#2428
    ldr	x28,	[sp, fp]

    str	w12,	[x28]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#37
    ble	main_413

main_189:
    movz	w12,	#37
    movz	fp,	#452
    ldr	x24,	[sp, fp]

    movz	fp,	#2420
    str	x24,	[sp, fp]

    movz	fp,	#2420
    ldr	x25,	[sp, fp]

    str	w12,	[x25]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#38
    ble	main_413

main_191:
    movz	w12,	#38
    movz	fp,	#460
    ldr	x21,	[sp, fp]

    movz	fp,	#2412
    str	x21,	[sp, fp]

    movz	fp,	#2412
    ldr	x22,	[sp, fp]

    str	w12,	[x22]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#39
    ble	main_413

main_193:
    movz	w12,	#39
    movz	fp,	#468
    ldr	x18,	[sp, fp]

    movz	fp,	#2404
    str	x18,	[sp, fp]

    movz	fp,	#2404
    ldr	x19,	[sp, fp]

    str	w12,	[x19]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#40
    ble	main_413

main_195:
    movz	w12,	#40
    movz	fp,	#804
    ldr	x15,	[sp, fp]

    movz	fp,	#2396
    str	x15,	[sp, fp]

    movz	fp,	#2396
    ldr	x16,	[sp, fp]

    str	w12,	[x16]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#41
    ble	main_413

main_197:
    movz	w12,	#41
    movz	fp,	#812
    mov	w14,	w12
    ldr	x12,	[sp, fp]

    movz	fp,	#2388
    str	x12,	[sp, fp]

    movz	fp,	#2388
    ldr	x13,	[sp, fp]

    str	w14,	[x13]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#42
    ble	main_413

main_199:
    movz	w12,	#42
    movz	fp,	#820
    mov	w14,	w12
    ldr	x9,	[sp, fp]

    movz	fp,	#2380
    str	x9,	[sp, fp]

    movz	fp,	#2380
    ldr	x10,	[sp, fp]

    str	w14,	[x10]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#43
    ble	main_413

main_201:
    movz	w12,	#43
    movz	fp,	#828
    mov	w14,	w12
    ldr	x6,	[sp, fp]

    movz	fp,	#2372
    str	x6,	[sp, fp]

    movz	fp,	#2372
    ldr	x7,	[sp, fp]

    str	w14,	[x7]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#44
    ble	main_413

main_203:
    movz	w12,	#44
    movz	fp,	#836
    mov	w14,	w12
    ldr	x3,	[sp, fp]

    movz	fp,	#2364
    str	x3,	[sp, fp]

    movz	fp,	#2364
    ldr	x4,	[sp, fp]

    str	w14,	[x4]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#45
    ble	main_413

main_205:
    movz	w12,	#45
    movz	fp,	#844
    mov	w14,	w12
    ldr	x0,	[sp, fp]

    movz	fp,	#2356
    str	x0,	[sp, fp]

    movz	fp,	#2356
    ldr	x1,	[sp, fp]

    str	w14,	[x1]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#46
    ble	main_413

main_207:
    movz	w12,	#46
    movz	fp,	#852
    ldr	x26,	[sp, fp]

    movz	fp,	#2348
    str	x26,	[sp, fp]

    movz	fp,	#2348
    ldr	x27,	[sp, fp]

    str	w12,	[x27]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#47
    ble	main_413

main_209:
    movz	w12,	#47
    movz	fp,	#860
    ldr	x23,	[sp, fp]

    movz	fp,	#2340
    str	x23,	[sp, fp]

    movz	fp,	#2340
    ldr	x24,	[sp, fp]

    str	w12,	[x24]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#48
    ble	main_413

main_211:
    movz	w12,	#48
    movz	fp,	#868
    ldr	x20,	[sp, fp]

    movz	fp,	#2332
    str	x20,	[sp, fp]

    movz	fp,	#2332
    ldr	x21,	[sp, fp]

    str	w12,	[x21]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#49
    ble	main_413

main_213:
    movz	w12,	#49
    movz	fp,	#884
    ldr	x17,	[sp, fp]

    movz	fp,	#2324
    str	x17,	[sp, fp]

    movz	fp,	#2324
    ldr	x18,	[sp, fp]

    str	w12,	[x18]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#50
    ble	main_413

main_215:
    movz	w12,	#50
    movz	fp,	#892
    ldr	x14,	[sp, fp]

    movz	fp,	#2316
    str	x14,	[sp, fp]

    movz	fp,	#2316
    ldr	x15,	[sp, fp]

    str	w12,	[x15]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#51
    ble	main_413

main_217:
    movz	w12,	#51
    movz	fp,	#900
    mov	w14,	w12
    ldr	x11,	[sp, fp]

    movz	fp,	#2308
    str	x11,	[sp, fp]

    movz	fp,	#2308
    ldr	x12,	[sp, fp]

    str	w14,	[x12]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#52
    ble	main_413

main_219:
    movz	w12,	#52
    movz	fp,	#908
    mov	w14,	w12
    ldr	x8,	[sp, fp]

    movz	fp,	#2300
    str	x8,	[sp, fp]

    movz	fp,	#2300
    ldr	x9,	[sp, fp]

    str	w14,	[x9]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#53
    ble	main_413

main_221:
    movz	w12,	#53
    movz	fp,	#916
    mov	w14,	w12
    ldr	x5,	[sp, fp]

    movz	fp,	#2292
    str	x5,	[sp, fp]

    movz	fp,	#2292
    ldr	x6,	[sp, fp]

    str	w14,	[x6]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#54
    ble	main_413

main_223:
    movz	w12,	#54
    movz	fp,	#876
    mov	w14,	w12
    ldr	x2,	[sp, fp]

    movz	fp,	#2284
    str	x2,	[sp, fp]

    movz	fp,	#2284
    ldr	x3,	[sp, fp]

    str	w14,	[x3]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#55
    ble	main_413

main_225:
    movz	w12,	#55
    ldr	x28,	[sp, #416]

    movz	fp,	#2276
    mov	w13,	w12
    str	x28,	[sp, fp]

    movz	fp,	#2276
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#56
    ble	main_413

main_227:
    movz	w12,	#56
    ldr	x25,	[sp, #424]

    movz	fp,	#2268
    str	x25,	[sp, fp]

    movz	fp,	#2268
    ldr	x26,	[sp, fp]

    str	w12,	[x26]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#57
    ble	main_413

main_229:
    movz	w12,	#57
    movz	fp,	#924
    ldr	x22,	[sp, fp]

    movz	fp,	#2260
    str	x22,	[sp, fp]

    movz	fp,	#2260
    ldr	x23,	[sp, fp]

    str	w12,	[x23]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#58
    ble	main_413

main_231:
    movz	w12,	#58
    movz	fp,	#932
    ldr	x19,	[sp, fp]

    movz	fp,	#2252
    str	x19,	[sp, fp]

    movz	fp,	#2252
    ldr	x20,	[sp, fp]

    str	w12,	[x20]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#59
    ble	main_413

main_233:
    movz	w12,	#59
    movz	fp,	#940
    ldr	x16,	[sp, fp]

    movz	fp,	#2244
    str	x16,	[sp, fp]

    movz	fp,	#2244
    ldr	x17,	[sp, fp]

    str	w12,	[x17]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#60
    ble	main_413

main_235:
    movz	w12,	#60
    movz	fp,	#948
    ldr	x13,	[sp, fp]

    movz	fp,	#2236
    str	x13,	[sp, fp]

    movz	fp,	#2236
    ldr	x14,	[sp, fp]

    str	w12,	[x14]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#61
    ble	main_413

main_237:
    movz	w12,	#61
    movz	fp,	#956
    mov	w14,	w12
    ldr	x10,	[sp, fp]

    movz	fp,	#2228
    str	x10,	[sp, fp]

    movz	fp,	#2228
    ldr	x11,	[sp, fp]

    str	w14,	[x11]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#62
    ble	main_413

main_239:
    movz	w12,	#62
    movz	fp,	#964
    mov	w14,	w12
    ldr	x7,	[sp, fp]

    movz	fp,	#2220
    str	x7,	[sp, fp]

    movz	fp,	#2220
    ldr	x8,	[sp, fp]

    str	w14,	[x8]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#63
    ble	main_413

main_241:
    movz	w12,	#63
    movz	fp,	#972
    mov	w14,	w12
    ldr	x4,	[sp, fp]

    movz	fp,	#2212
    str	x4,	[sp, fp]

    movz	fp,	#2212
    ldr	x5,	[sp, fp]

    str	w14,	[x5]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#64
    ble	main_413

main_243:
    movz	w12,	#64
    movz	fp,	#980
    mov	w14,	w12
    ldr	x1,	[sp, fp]

    movz	fp,	#2204
    str	x1,	[sp, fp]

    movz	fp,	#2204
    ldr	x2,	[sp, fp]

    str	w14,	[x2]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#65
    ble	main_413

main_245:
    movz	w12,	#65
    movz	fp,	#988
    ldr	x27,	[sp, fp]

    movz	fp,	#2196
    str	x27,	[sp, fp]

    movz	fp,	#2196
    ldr	x28,	[sp, fp]

    str	w12,	[x28]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#66
    ble	main_413

main_247:
    movz	w12,	#66
    movz	fp,	#996
    ldr	x24,	[sp, fp]

    movz	fp,	#2188
    str	x24,	[sp, fp]

    movz	fp,	#2188
    ldr	x25,	[sp, fp]

    str	w12,	[x25]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#67
    ble	main_413

main_249:
    movz	w12,	#67
    movz	fp,	#1004
    ldr	x21,	[sp, fp]

    movz	fp,	#2180
    str	x21,	[sp, fp]

    movz	fp,	#2180
    ldr	x22,	[sp, fp]

    str	w12,	[x22]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#68
    ble	main_413

main_251:
    movz	w12,	#68
    movz	fp,	#1012
    ldr	x18,	[sp, fp]

    movz	fp,	#2172
    str	x18,	[sp, fp]

    movz	fp,	#2172
    ldr	x19,	[sp, fp]

    str	w12,	[x19]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#69
    ble	main_413

main_253:
    movz	w12,	#69
    movz	fp,	#1020
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #3208]

    ldr	x16,	[sp, #3208]

    str	w12,	[x16]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#70
    ble	main_413

main_255:
    movz	w12,	#70
    movz	fp,	#1028
    mov	w14,	w12
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #3200]

    ldr	x13,	[sp, #3200]

    str	w14,	[x13]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#71
    ble	main_413

main_257:
    movz	w12,	#71
    movz	fp,	#1036
    mov	w14,	w12
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #3192]

    ldr	x10,	[sp, #3192]

    str	w14,	[x10]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#72
    ble	main_413

main_259:
    movz	w12,	#72
    movz	fp,	#1044
    mov	w14,	w12
    ldr	x6,	[sp, fp]

    str	x6,	[sp, #3184]

    ldr	x7,	[sp, #3184]

    str	w14,	[x7]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#73
    ble	main_413

main_261:
    movz	w12,	#73
    movz	fp,	#1052
    mov	w14,	w12
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #3176]

    ldr	x4,	[sp, #3176]

    str	w14,	[x4]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#74
    ble	main_413

main_263:
    movz	w12,	#74
    movz	fp,	#1060
    mov	w14,	w12
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #3168]

    ldr	x1,	[sp, #3168]

    str	w14,	[x1]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#75
    ble	main_413

main_265:
    movz	w12,	#75
    movz	fp,	#1068
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #3160]

    ldr	x27,	[sp, #3160]

    str	w12,	[x27]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#76
    ble	main_413

main_267:
    movz	w12,	#76
    movz	fp,	#1076
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #3152]

    ldr	x24,	[sp, #3152]

    str	w12,	[x24]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#77
    ble	main_413

main_269:
    movz	w12,	#77
    movz	fp,	#1084
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #3144]

    ldr	x21,	[sp, #3144]

    str	w12,	[x21]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#78
    ble	main_413

main_271:
    movz	w12,	#78
    movz	fp,	#1092
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #3136]

    ldr	x18,	[sp, #3136]

    str	w12,	[x18]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#79
    ble	main_413

main_273:
    movz	w12,	#79
    movz	fp,	#1100
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #3128]

    ldr	x15,	[sp, #3128]

    str	w12,	[x15]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#80
    ble	main_413

main_275:
    movz	w12,	#80
    movz	fp,	#1108
    mov	w14,	w12
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #3120]

    ldr	x12,	[sp, #3120]

    str	w14,	[x12]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#81
    ble	main_413

main_277:
    movz	w12,	#81
    movz	fp,	#1116
    mov	w14,	w12
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #3112]

    ldr	x9,	[sp, #3112]

    str	w14,	[x9]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#82
    ble	main_413

main_279:
    movz	w12,	#82
    movz	fp,	#1124
    mov	w14,	w12
    ldr	x5,	[sp, fp]

    movz	fp,	#2100
    str	x5,	[sp, fp]

    movz	fp,	#2100
    ldr	x6,	[sp, fp]

    str	w14,	[x6]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#83
    ble	main_413

main_281:
    movz	w12,	#83
    movz	fp,	#1132
    mov	w14,	w12
    ldr	x2,	[sp, fp]

    movz	fp,	#2092
    str	x2,	[sp, fp]

    movz	fp,	#2092
    ldr	x3,	[sp, fp]

    str	w14,	[x3]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#84
    ble	main_413

main_283:
    movz	w12,	#84
    movz	fp,	#1140
    mov	w13,	w12
    ldr	x28,	[sp, fp]

    movz	fp,	#2084
    str	x28,	[sp, fp]

    movz	fp,	#2084
    ldr	x0,	[sp, fp]

    str	w13,	[x0]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#85
    ble	main_413

main_285:
    movz	w12,	#85
    movz	fp,	#1148
    ldr	x25,	[sp, fp]

    movz	fp,	#2076
    str	x25,	[sp, fp]

    movz	fp,	#2076
    ldr	x26,	[sp, fp]

    str	w12,	[x26]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#86
    ble	main_413

main_287:
    movz	w12,	#86
    movz	fp,	#1156
    ldr	x22,	[sp, fp]

    movz	fp,	#2068
    str	x22,	[sp, fp]

    movz	fp,	#2068
    ldr	x23,	[sp, fp]

    str	w12,	[x23]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#87
    ble	main_413

main_289:
    movz	w12,	#87
    movz	fp,	#1164
    ldr	x19,	[sp, fp]

    movz	fp,	#2060
    str	x19,	[sp, fp]

    movz	fp,	#2060
    ldr	x20,	[sp, fp]

    str	w12,	[x20]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#88
    ble	main_413

main_291:
    movz	w12,	#88
    movz	fp,	#1172
    ldr	x16,	[sp, fp]

    movz	fp,	#2052
    str	x16,	[sp, fp]

    movz	fp,	#2052
    ldr	x17,	[sp, fp]

    str	w12,	[x17]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#89
    ble	main_413

main_293:
    movz	w12,	#89
    movz	fp,	#1180
    ldr	x13,	[sp, fp]

    movz	fp,	#2044
    str	x13,	[sp, fp]

    movz	fp,	#2044
    ldr	x14,	[sp, fp]

    str	w12,	[x14]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#90
    ble	main_413

main_295:
    movz	w12,	#90
    movz	fp,	#1188
    mov	w14,	w12
    ldr	x10,	[sp, fp]

    movz	fp,	#2148
    str	x10,	[sp, fp]

    movz	fp,	#2148
    ldr	x11,	[sp, fp]

    str	w14,	[x11]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#91
    ble	main_413

main_297:
    movz	w12,	#91
    movz	fp,	#1196
    mov	w14,	w12
    ldr	x7,	[sp, fp]

    movz	fp,	#2140
    str	x7,	[sp, fp]

    movz	fp,	#2140
    ldr	x8,	[sp, fp]

    str	w14,	[x8]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#92
    ble	main_413

main_299:
    movz	w12,	#92
    movz	fp,	#1204
    mov	w14,	w12
    ldr	x4,	[sp, fp]

    movz	fp,	#2132
    str	x4,	[sp, fp]

    movz	fp,	#2132
    ldr	x5,	[sp, fp]

    str	w14,	[x5]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#93
    ble	main_413

main_301:
    movz	w12,	#93
    movz	fp,	#1212
    mov	w14,	w12
    ldr	x1,	[sp, fp]

    movz	fp,	#2124
    str	x1,	[sp, fp]

    movz	fp,	#2124
    ldr	x2,	[sp, fp]

    str	w14,	[x2]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#94
    ble	main_413

main_303:
    movz	w12,	#94
    movz	fp,	#1220
    ldr	x27,	[sp, fp]

    movz	fp,	#2116
    str	x27,	[sp, fp]

    movz	fp,	#2116
    ldr	x28,	[sp, fp]

    str	w12,	[x28]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#95
    ble	main_413

main_305:
    movz	w12,	#95
    movz	fp,	#1228
    ldr	x24,	[sp, fp]

    movz	fp,	#2108
    str	x24,	[sp, fp]

    movz	fp,	#2108
    ldr	x25,	[sp, fp]

    str	w12,	[x25]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#96
    ble	main_413

main_307:
    movz	w12,	#96
    movz	fp,	#1236
    ldr	x21,	[sp, fp]

    movz	fp,	#2164
    str	x21,	[sp, fp]

    movz	fp,	#2164
    ldr	x22,	[sp, fp]

    str	w12,	[x22]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#97
    ble	main_413

main_309:
    movz	w12,	#97
    movz	fp,	#1244
    ldr	x18,	[sp, fp]

    movz	fp,	#2156
    str	x18,	[sp, fp]

    movz	fp,	#2156
    ldr	x19,	[sp, fp]

    str	w12,	[x19]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#98
    ble	main_413

main_311:
    movz	w12,	#98
    movz	fp,	#1252
    ldr	x15,	[sp, fp]

    movz	fp,	#2036
    str	x15,	[sp, fp]

    movz	fp,	#2036
    ldr	x16,	[sp, fp]

    str	w12,	[x16]

    ldr	w12,	[sp, #1280]

    cmp	w12,	#99
    ble	main_413

main_313:
    movz	w12,	#99
    movz	fp,	#1260
    mov	w14,	w12
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #608]

    ldr	x13,	[sp, #608]

    str	w14,	[x13]


main_413:
    ldr	w12,	[sp, #1268]

    add	w12,	w12,	#1
    str	w12,	[sp, #620]

    ldr	w12,	[sp, #1272]

    str	w12,	[sp, #616]

    movz	w12,	#0
    str	w12,	[sp, #624]


main_415:
    ldr	w12,	[sp, #624]

    cmp	w12,	#100
    blt	main_419

main_424:
    movz	w12,	#65535
    ldr	w13,	[sp, #616]

    str	w13,	[sp, #1816]

    ldr	w14,	[sp, #1816]

    sdiv	w12,	w14,	w12
    str	w12,	[sp, #440]

    ldr	w12,	[sp, #440]

    ldr	w7,	[sp, #440]

    lsl	w14,	w12,	#16
    str	w7,	[sp, #3108]

    ldr	w8,	[sp, #3108]

    ldr	w16,	[sp, #616]

    sub	w12,	w14,	w8,	lsl #0
    str	w16,	[sp, #1820]

    ldr	w17,	[sp, #1820]

    ldr	w7,	[sp, #620]

    sub	w15,	w17,	w12
    str	w7,	[sp, #2452]

    ldr	w22,	[sp, #1276]

    str	w22,	[sp, #1828]

    ldr	w8,	[sp, #2452]

    ldr	w0,	[sp, #1828]

    cmp	w8,	w0
    blt	main_112

main_428:
    mov	w0,	w15

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


main_112:
    mov	w12,	w15
    str	w12,	[sp, #1272]

    ldr	w12,	[sp, #620]

    str	w12,	[sp, #1268]

    b	main_113

main_419:
    ldr	w12,	[sp, #624]

    lsl	w12,	w12,	#2
    mov	x12,	x12
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w12,	[x12]

    ldr	w19,	[sp, #616]

    str	w19,	[sp, #1824]

    ldr	w20,	[sp, #1824]

    ldr	w10,	[sp, #624]

    add	w16,	w12,	w20
    str	w10,	[sp, #1812]

    mov	w12,	w16
    ldr	w11,	[sp, #1812]

    add	w4,	w11,	#1
    str	w4,	[sp, #3104]

    ldr	w5,	[sp, #3104]

    str	w5,	[sp, #596]

    str	w12,	[sp, #616]

    ldr	w12,	[sp, #596]

    str	w12,	[sp, #624]

    b	main_415

main_7:
    lsl	w21,	w0,	#2
    movz	w16,	#0
    add	w26,	w0,	#1
    mov	x24,	x21
    mov	w0,	w26
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    str	w16,	[x24]

    b	main_4

