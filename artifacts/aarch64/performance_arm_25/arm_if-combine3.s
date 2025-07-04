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
    sub	sp, sp, #3168
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
    blt	main_7

main_10:
    movz	w25,	#0
    ldr	w15,	[sp, #1196]

    cmp	w25,	w15
    blt	main_12

main_427:
    movz	w0,	#0
    b	main_429

main_12:
    add	x18,	sp,	#20
    movz	fp,	#1292
    add	x13,	sp,	#24
    add	x28,	sp,	#28
    add	x26,	sp,	#32
    add	x7,	sp,	#36
    add	x17,	sp,	#40
    add	x16,	sp,	#44
    add	x27,	sp,	#48
    add	x21,	sp,	#52
    add	x6,	sp,	#56
    add	x19,	sp,	#60
    add	x11,	sp,	#64
    add	x4,	sp,	#68
    add	x25,	sp,	#72
    add	x23,	sp,	#76
    add	x9,	sp,	#80
    add	x10,	sp,	#84
    add	x24,	sp,	#88
    add	x0,	sp,	#92
    add	x14,	sp,	#96
    add	x20,	sp,	#100
    add	x15,	sp,	#104
    add	x1,	sp,	#108
    add	x8,	sp,	#112
    add	x3,	sp,	#116
    add	x5,	sp,	#120
    add	x22,	sp,	#124
    add	x2,	sp,	#128
    str	x18,	[sp, fp]

    movz	fp,	#1228
    str	x13,	[sp, fp]

    movz	fp,	#1580
    str	x28,	[sp, fp]

    movz	fp,	#1652
    str	x26,	[sp, fp]

    movz	fp,	#1212
    str	x7,	[sp, fp]

    movz	fp,	#1628
    str	x17,	[sp, fp]

    movz	fp,	#1236
    str	x16,	[sp, fp]

    movz	fp,	#1316
    str	x27,	[sp, fp]

    add	x27,	sp,	#136
    movz	fp,	#1300
    str	x21,	[sp, fp]

    movz	fp,	#1676
    str	x6,	[sp, fp]

    movz	fp,	#1556
    str	x19,	[sp, fp]

    movz	fp,	#1612
    str	x11,	[sp, fp]

    movz	fp,	#1204
    str	x4,	[sp, fp]

    movz	fp,	#1572
    str	x25,	[sp, fp]

    movz	fp,	#1644
    str	x23,	[sp, fp]

    movz	fp,	#1684
    str	x9,	[sp, fp]

    movz	fp,	#1220
    str	x10,	[sp, fp]

    movz	fp,	#1308
    str	x24,	[sp, fp]

    movz	fp,	#1660
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#1620
    str	x14,	[sp, fp]

    movz	fp,	#1636
    str	x20,	[sp, fp]

    movz	fp,	#1548
    str	x15,	[sp, fp]

    movz	fp,	#1324
    str	x1,	[sp, fp]

    movz	fp,	#1604
    str	x8,	[sp, fp]

    movz	fp,	#1668
    str	x3,	[sp, fp]

    movz	fp,	#1596
    str	x5,	[sp, fp]

    movz	fp,	#1564
    str	x22,	[sp, fp]

    movz	fp,	#1588
    str	x2,	[sp, fp]

    movz	fp,	#484
    str	x0,	[sp, fp]

    movz	fp,	#764
    add	x0,	sp,	#140
    str	x27,	[sp, #504]

    add	x27,	sp,	#144
    str	x0,	[sp, #432]

    add	x0,	sp,	#148
    str	x27,	[sp, fp]

    add	x27,	sp,	#152
    movz	fp,	#772
    str	x0,	[sp, fp]

    add	x0,	sp,	#156
    movz	fp,	#444
    str	x27,	[sp, fp]

    add	x27,	sp,	#164
    movz	fp,	#452
    str	x0,	[sp, fp]

    movz	fp,	#460
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#468
    str	x27,	[sp, fp]

    add	x27,	sp,	#172
    movz	fp,	#780
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#788
    str	x27,	[sp, fp]

    add	x27,	sp,	#180
    movz	fp,	#796
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#804
    str	x27,	[sp, fp]

    add	x27,	sp,	#188
    movz	fp,	#812
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#828
    str	x27,	[sp, fp]

    add	x27,	sp,	#200
    movz	fp,	#516
    str	x0,	[sp, fp]

    movz	fp,	#524
    add	x0,	sp,	#196
    str	x0,	[sp, fp]

    add	x0,	sp,	#204
    movz	fp,	#532
    str	x27,	[sp, fp]

    add	x27,	sp,	#208
    movz	fp,	#540
    str	x0,	[sp, fp]

    add	x0,	sp,	#212
    movz	fp,	#548
    str	x27,	[sp, fp]

    add	x27,	sp,	#216
    movz	fp,	#556
    str	x0,	[sp, fp]

    add	x0,	sp,	#220
    movz	fp,	#564
    str	x27,	[sp, fp]

    add	x27,	sp,	#224
    movz	fp,	#572
    str	x0,	[sp, fp]

    add	x0,	sp,	#228
    movz	fp,	#580
    str	x27,	[sp, fp]

    add	x27,	sp,	#232
    movz	fp,	#836
    str	x0,	[sp, fp]

    add	x0,	sp,	#240
    movz	fp,	#820
    str	x27,	[sp, fp]

    movz	fp,	#844
    add	x27,	sp,	#236
    str	x27,	[sp, #416]

    add	x27,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x27,	[sp, fp]

    add	x27,	sp,	#252
    movz	fp,	#852
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#860
    str	x27,	[sp, fp]

    add	x27,	sp,	#260
    movz	fp,	#868
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#876
    str	x27,	[sp, fp]

    add	x27,	sp,	#268
    movz	fp,	#884
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#892
    str	x27,	[sp, fp]

    add	x27,	sp,	#280
    movz	fp,	#900
    str	x0,	[sp, fp]

    movz	fp,	#908
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#916
    str	x27,	[sp, fp]

    add	x27,	sp,	#288
    movz	fp,	#924
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#932
    str	x27,	[sp, fp]

    add	x27,	sp,	#296
    movz	fp,	#940
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#948
    str	x27,	[sp, fp]

    add	x27,	sp,	#304
    movz	fp,	#956
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#964
    str	x27,	[sp, fp]

    add	x27,	sp,	#316
    movz	fp,	#972
    str	x0,	[sp, fp]

    movz	fp,	#980
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#988
    str	x27,	[sp, fp]

    add	x27,	sp,	#324
    movz	fp,	#996
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#1004
    str	x27,	[sp, fp]

    add	x27,	sp,	#332
    movz	fp,	#1012
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#1020
    str	x27,	[sp, fp]

    add	x27,	sp,	#340
    movz	fp,	#1028
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1036
    str	x27,	[sp, fp]

    add	x27,	sp,	#348
    movz	fp,	#1044
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#1052
    str	x27,	[sp, fp]

    movz	fp,	#1060
    add	x27,	sp,	#352
    str	x27,	[sp, fp]

    add	x27,	sp,	#360
    movz	fp,	#1068
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#1076
    str	x27,	[sp, fp]

    add	x27,	sp,	#368
    movz	fp,	#1084
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#1092
    str	x27,	[sp, fp]

    add	x27,	sp,	#376
    movz	fp,	#1100
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#1108
    str	x27,	[sp, fp]

    add	x27,	sp,	#384
    movz	fp,	#1116
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#1124
    str	x27,	[sp, fp]

    add	x27,	sp,	#396
    movz	fp,	#1132
    str	x0,	[sp, fp]

    movz	fp,	#1140
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1148
    str	x27,	[sp, fp]

    add	x27,	sp,	#404
    movz	fp,	#1156
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1164
    str	x27,	[sp, fp]

    add	x27,	sp,	#412
    movz	fp,	#1172
    str	x0,	[sp, fp]

    movz	fp,	#1180
    str	x27,	[sp, fp]

    movz	w27,	#0
    mov	w0,	w27
    movz	w27,	#0
    str	w0,	[sp, #1192]

    mov	w0,	w27
    str	w0,	[sp, #1188]


main_113:
    ldr	w0,	[sp, #1200]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w0,	#1
    movz	fp,	#1292
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#2
    ble	main_413

main_119:
    movz	w0,	#2
    movz	fp,	#1228
    mov	w27,	w0
    ldr	x7,	[sp, fp]

    str	w27,	[x7]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w27,	#3
    movz	fp,	#1580
    mov	w0,	w27
    ldr	x24,	[sp, fp]

    str	w0,	[x24]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1652
    mov	w27,	w0
    ldr	x21,	[sp, fp]

    str	w27,	[x21]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w27,	#5
    movz	fp,	#1212
    mov	w0,	w27
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    movz	fp,	#1628
    mov	w27,	w0
    ldr	x12,	[sp, fp]

    str	w27,	[x12]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w27,	#7
    movz	fp,	#1236
    mov	w0,	w27
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    movz	fp,	#1316
    mov	w27,	w0
    ldr	x20,	[sp, fp]

    str	w27,	[x20]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w27,	#9
    movz	fp,	#1300
    mov	w0,	w27
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#10
    ble	main_413

main_135:
    movz	w0,	#10
    movz	fp,	#1676
    ldr	x4,	[sp, fp]

    str	w0,	[x4]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w0,	#11
    movz	fp,	#1556
    mov	w27,	w0
    ldr	x13,	[sp, fp]

    str	w27,	[x13]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#12
    ble	main_413

main_139:
    movz	w27,	#12
    movz	fp,	#1612
    mov	w0,	w27
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1204
    mov	w27,	w0
    ldr	x28,	[sp, fp]

    str	w27,	[x28]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#14
    ble	main_413

main_143:
    movz	w27,	#14
    movz	fp,	#1572
    mov	w0,	w27
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    movz	fp,	#1644
    mov	w27,	w0
    ldr	x18,	[sp, fp]

    str	w27,	[x18]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#16
    ble	main_413

main_147:
    movz	w27,	#16
    movz	fp,	#1684
    mov	w0,	w27
    ldr	x7,	[sp, fp]

    str	w0,	[x7]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    movz	fp,	#1220
    mov	w27,	w0
    ldr	x4,	[sp, fp]

    str	w27,	[x4]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#18
    ble	main_413

main_151:
    movz	w27,	#18
    movz	fp,	#1308
    mov	w0,	w27
    ldr	x19,	[sp, fp]

    str	w0,	[x19]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w0,	#19
    movz	fp,	#1660
    ldr	x26,	[sp, fp]

    str	w0,	[x26]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#20
    ble	main_413

main_155:
    movz	w0,	#20
    movz	fp,	#1620
    mov	w27,	w0
    ldr	x9,	[sp, fp]

    str	w27,	[x9]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w27,	#21
    movz	fp,	#1636
    mov	w0,	w27
    ldr	x17,	[sp, fp]

    str	w0,	[x17]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1548
    mov	w27,	w0
    ldr	x8,	[sp, fp]

    str	w27,	[x8]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w27,	#23
    movz	fp,	#1324
    mov	w0,	w27
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1604
    mov	w27,	w0
    ldr	x3,	[sp, fp]

    str	w27,	[x3]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w27,	#25
    movz	fp,	#1668
    mov	w0,	w27
    ldr	x1,	[sp, fp]

    str	w0,	[x1]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    movz	fp,	#1596
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#27
    ble	main_413

main_169:
    movz	w27,	#27
    movz	fp,	#1564
    mov	w0,	w27
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w0,	#28
    movz	fp,	#1588
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#29
    ble	main_413

main_173:
    movz	w0,	#29
    movz	fp,	#484
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w27,	#30
    mov	w0,	w27
    ldr	x27,	[sp, #504]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    mov	w27,	w0
    ldr	x0,	[sp, #432]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w27,	#32
    movz	fp,	#764
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    movz	fp,	#772
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w27,	#34
    movz	fp,	#444
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    movz	fp,	#452
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w27,	#36
    movz	fp,	#460
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#37
    ble	main_413

main_189:
    movz	w0,	#37
    movz	fp,	#468
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w0,	#38
    movz	fp,	#780
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#39
    ble	main_413

main_193:
    movz	w27,	#39
    movz	fp,	#788
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#796
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#41
    ble	main_413

main_197:
    movz	w27,	#41
    movz	fp,	#804
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    movz	fp,	#812
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#43
    ble	main_413

main_201:
    movz	w27,	#43
    movz	fp,	#828
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    movz	fp,	#516
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#45
    ble	main_413

main_205:
    movz	w27,	#45
    movz	fp,	#524
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w0,	#46
    movz	fp,	#532
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#47
    ble	main_413

main_209:
    movz	w0,	#47
    movz	fp,	#540
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w27,	#48
    movz	fp,	#548
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    movz	fp,	#556
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w27,	#50
    movz	fp,	#564
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    movz	fp,	#572
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w27,	#52
    movz	fp,	#580
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    movz	fp,	#836
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w27,	#54
    movz	fp,	#820
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w0,	#55
    ldr	x27,	[sp, #416]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#56
    ble	main_413

main_227:
    movz	w0,	#56
    mov	w27,	w0
    ldr	x0,	[sp, #424]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w27,	#57
    movz	fp,	#844
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#852
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w27,	#59
    movz	fp,	#860
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#868
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w27,	#61
    movz	fp,	#876
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    movz	fp,	#884
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w27,	#63
    movz	fp,	#892
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#64
    ble	main_413

main_243:
    movz	w0,	#64
    movz	fp,	#900
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w0,	#65
    movz	fp,	#908
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#66
    ble	main_413

main_247:
    movz	w27,	#66
    movz	fp,	#916
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#924
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#68
    ble	main_413

main_251:
    movz	w27,	#68
    movz	fp,	#932
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#940
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#70
    ble	main_413

main_255:
    movz	w27,	#70
    movz	fp,	#948
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    movz	fp,	#956
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#72
    ble	main_413

main_259:
    movz	w27,	#72
    movz	fp,	#964
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w0,	#73
    movz	fp,	#972
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#74
    ble	main_413

main_263:
    movz	w0,	#74
    movz	fp,	#980
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w27,	#75
    movz	fp,	#988
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#996
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w27,	#77
    movz	fp,	#1004
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#1012
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w27,	#79
    movz	fp,	#1020
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    movz	fp,	#1028
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w27,	#81
    movz	fp,	#1036
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#82
    ble	main_413

main_279:
    movz	w0,	#82
    movz	fp,	#1044
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w0,	#83
    movz	fp,	#1052
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w27,	#84
    movz	fp,	#1060
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1068
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w27,	#86
    movz	fp,	#1076
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#1084
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w27,	#88
    movz	fp,	#1092
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    movz	fp,	#1100
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w27,	#90
    movz	fp,	#1108
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#91
    ble	main_413

main_297:
    movz	w0,	#91
    movz	fp,	#1116
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w0,	#92
    movz	fp,	#1124
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#93
    ble	main_413

main_301:
    movz	w27,	#93
    movz	fp,	#1132
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1140
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#95
    ble	main_413

main_305:
    movz	w27,	#95
    movz	fp,	#1148
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#1156
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#97
    ble	main_413

main_309:
    movz	w27,	#97
    movz	fp,	#1164
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    movz	fp,	#1172
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1200]

    cmp	w27,	#99
    ble	main_413

main_313:
    movz	w27,	#99
    movz	fp,	#1180
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]


main_413:
    ldr	w27,	[sp, #1188]

    add	w0,	w27,	#1
    movz	w27,	#0
    str	w0,	[sp, #476]

    ldr	w0,	[sp, #1192]

    str	w0,	[sp, #480]

    str	w27,	[sp, #512]


main_415:
    ldr	w0,	[sp, #512]

    cmp	w0,	#100
    blt	main_419

main_424:
    movz	w0,	#65535
    ldr	w27,	[sp, #480]

    sdiv	w27,	w27,	w0
    str	w27,	[sp, #440]

    ldr	w0,	[sp, #440]

    lsl	w27,	w0,	#16
    ldr	w0,	[sp, #440]

    sub	w0,	w27,	w0,	lsl #0
    ldr	w27,	[sp, #480]

    sub	w0,	w27,	w0
    ldr	w27,	[sp, #476]

    str	w27,	[sp, #2984]

    ldr	w7,	[sp, #1196]

    str	w7,	[sp, #2012]

    ldr	w8,	[sp, #2012]

    ldr	w28,	[sp, #2984]

    cmp	w28,	w8
    blt	main_112

main_429:
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#402
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #3168
    ret


main_112:
    str	w0,	[sp, #1192]

    ldr	w0,	[sp, #476]

    str	w0,	[sp, #1188]

    b	main_113

main_419:
    ldr	w27,	[sp, #512]

    lsl	w0,	w27,	#2
    mov	x27,	x0
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    ldr	w0,	[x27]

    ldr	w27,	[sp, #480]

    add	w27,	w0,	w27
    ldr	w0,	[sp, #512]

    add	w0,	w0,	#1
    str	w0,	[sp, #492]

    mov	w0,	w27
    str	w0,	[sp, #480]

    ldr	w27,	[sp, #492]

    str	w27,	[sp, #512]

    b	main_415

main_7:
    lsl	w24,	w0,	#2
    movz	w23,	#0
    add	w0,	w0,	#1
    mov	x16,	x24
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    str	w23,	[x16]

    b	main_4

