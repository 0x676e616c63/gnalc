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
    str	w0,	[sp, #1396]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1400]

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
    ldr	w15,	[sp, #1396]

    mov	w28,	w27
    cmp	w28,	w15
    bge	main_427

main_12:
    add	x17,	sp,	#20
    movz	fp,	#1780
    add	x27,	sp,	#24
    add	x22,	sp,	#28
    add	x28,	sp,	#32
    add	x24,	sp,	#36
    add	x2,	sp,	#40
    add	x0,	sp,	#44
    add	x1,	sp,	#48
    add	x5,	sp,	#52
    add	x19,	sp,	#56
    add	x9,	sp,	#60
    add	x20,	sp,	#64
    add	x21,	sp,	#68
    add	x8,	sp,	#72
    add	x13,	sp,	#76
    add	x3,	sp,	#80
    add	x15,	sp,	#84
    add	x16,	sp,	#88
    add	x25,	sp,	#92
    add	x18,	sp,	#96
    add	x23,	sp,	#100
    add	x4,	sp,	#104
    add	x11,	sp,	#108
    add	x26,	sp,	#112
    add	x6,	sp,	#116
    add	x14,	sp,	#120
    add	x7,	sp,	#124
    add	x10,	sp,	#128
    str	x17,	[sp, fp]

    movz	fp,	#1692
    str	x27,	[sp, fp]

    movz	fp,	#1716
    str	x22,	[sp, fp]

    movz	fp,	#1732
    str	x28,	[sp, fp]

    add	x28,	sp,	#132
    movz	fp,	#1684
    str	x24,	[sp, fp]

    movz	fp,	#1740
    str	x2,	[sp, fp]

    movz	fp,	#1812
    str	x0,	[sp, fp]

    movz	fp,	#1700
    str	x1,	[sp, fp]

    movz	fp,	#1748
    str	x5,	[sp, fp]

    movz	fp,	#1708
    str	x19,	[sp, fp]

    movz	fp,	#1836
    str	x9,	[sp, fp]

    movz	fp,	#1788
    str	x20,	[sp, fp]

    movz	fp,	#1676
    str	x21,	[sp, fp]

    movz	fp,	#1756
    str	x8,	[sp, fp]

    movz	fp,	#1436
    str	x13,	[sp, fp]

    movz	fp,	#1820
    str	x3,	[sp, fp]

    movz	fp,	#1660
    str	x15,	[sp, fp]

    movz	fp,	#1444
    str	x16,	[sp, fp]

    movz	fp,	#1724
    str	x25,	[sp, fp]

    movz	fp,	#1668
    str	x18,	[sp, fp]

    movz	fp,	#1796
    str	x23,	[sp, fp]

    movz	fp,	#1412
    str	x4,	[sp, fp]

    movz	fp,	#1764
    str	x11,	[sp, fp]

    movz	fp,	#1804
    str	x26,	[sp, fp]

    movz	fp,	#1828
    str	x6,	[sp, fp]

    movz	fp,	#1772
    str	x14,	[sp, fp]

    movz	fp,	#1420
    str	x7,	[sp, fp]

    movz	fp,	#1428
    str	x10,	[sp, fp]

    movz	fp,	#476
    str	x28,	[sp, fp]

    movz	fp,	#772
    add	x28,	sp,	#136
    str	x28,	[sp, fp]

    movz	fp,	#468
    add	x28,	sp,	#140
    str	x28,	[sp, fp]

    movz	fp,	#676
    add	x28,	sp,	#144
    str	x28,	[sp, fp]

    movz	fp,	#684
    add	x28,	sp,	#148
    str	x28,	[sp, fp]

    movz	fp,	#1004
    add	x28,	sp,	#152
    str	x28,	[sp, fp]

    movz	fp,	#1012
    add	x28,	sp,	#156
    str	x28,	[sp, fp]

    movz	fp,	#1020
    add	x28,	sp,	#160
    str	x28,	[sp, fp]

    movz	fp,	#1028
    add	x28,	sp,	#164
    str	x28,	[sp, fp]

    movz	fp,	#628
    add	x28,	sp,	#168
    str	x28,	[sp, fp]

    movz	fp,	#636
    add	x28,	sp,	#172
    str	x28,	[sp, fp]

    movz	fp,	#644
    add	x28,	sp,	#176
    str	x28,	[sp, fp]

    movz	fp,	#652
    add	x28,	sp,	#180
    str	x28,	[sp, fp]

    movz	fp,	#660
    add	x28,	sp,	#184
    str	x28,	[sp, fp]

    movz	fp,	#668
    add	x28,	sp,	#188
    str	x28,	[sp, fp]

    movz	fp,	#692
    add	x28,	sp,	#192
    str	x28,	[sp, fp]

    movz	fp,	#700
    add	x28,	sp,	#196
    str	x28,	[sp, fp]

    movz	fp,	#708
    add	x28,	sp,	#200
    str	x28,	[sp, fp]

    movz	fp,	#716
    add	x28,	sp,	#204
    str	x28,	[sp, fp]

    movz	fp,	#724
    add	x28,	sp,	#208
    str	x28,	[sp, fp]

    movz	fp,	#732
    add	x28,	sp,	#212
    str	x28,	[sp, fp]

    movz	fp,	#740
    add	x28,	sp,	#216
    str	x28,	[sp, fp]

    movz	fp,	#756
    add	x28,	sp,	#220
    str	x28,	[sp, fp]

    movz	fp,	#764
    add	x28,	sp,	#224
    str	x28,	[sp, fp]

    movz	fp,	#1036
    add	x28,	sp,	#228
    str	x28,	[sp, fp]

    movz	fp,	#748
    add	x28,	sp,	#232
    str	x28,	[sp, fp]

    movz	fp,	#1044
    add	x28,	sp,	#236
    str	x28,	[sp, #416]

    add	x28,	sp,	#240
    str	x28,	[sp, #424]

    add	x28,	sp,	#244
    str	x28,	[sp, fp]

    movz	fp,	#1052
    add	x28,	sp,	#248
    str	x28,	[sp, fp]

    movz	fp,	#1060
    add	x28,	sp,	#252
    str	x28,	[sp, fp]

    movz	fp,	#1068
    add	x28,	sp,	#256
    str	x28,	[sp, fp]

    movz	fp,	#1076
    add	x28,	sp,	#260
    str	x28,	[sp, fp]

    movz	fp,	#1084
    add	x28,	sp,	#264
    str	x28,	[sp, fp]

    movz	fp,	#1092
    add	x28,	sp,	#268
    str	x28,	[sp, fp]

    movz	fp,	#1100
    add	x28,	sp,	#272
    str	x28,	[sp, fp]

    movz	fp,	#1108
    add	x28,	sp,	#276
    str	x28,	[sp, fp]

    movz	fp,	#1116
    add	x28,	sp,	#280
    str	x28,	[sp, fp]

    movz	fp,	#1124
    add	x28,	sp,	#284
    str	x28,	[sp, fp]

    movz	fp,	#1132
    add	x28,	sp,	#288
    str	x28,	[sp, fp]

    movz	fp,	#1140
    add	x28,	sp,	#292
    str	x28,	[sp, fp]

    movz	fp,	#1148
    add	x28,	sp,	#296
    str	x28,	[sp, fp]

    movz	fp,	#1156
    add	x28,	sp,	#300
    str	x28,	[sp, fp]

    movz	fp,	#1164
    add	x28,	sp,	#304
    str	x28,	[sp, fp]

    movz	fp,	#1172
    add	x28,	sp,	#308
    str	x28,	[sp, fp]

    movz	fp,	#1180
    add	x28,	sp,	#312
    str	x28,	[sp, fp]

    movz	fp,	#1188
    add	x28,	sp,	#316
    str	x28,	[sp, fp]

    movz	fp,	#1196
    add	x28,	sp,	#320
    str	x28,	[sp, fp]

    movz	fp,	#1204
    add	x28,	sp,	#324
    str	x28,	[sp, fp]

    movz	fp,	#1212
    add	x28,	sp,	#328
    str	x28,	[sp, fp]

    movz	fp,	#1220
    add	x28,	sp,	#332
    str	x28,	[sp, fp]

    movz	fp,	#1228
    add	x28,	sp,	#336
    str	x28,	[sp, fp]

    movz	fp,	#1236
    add	x28,	sp,	#340
    str	x28,	[sp, fp]

    movz	fp,	#1244
    add	x28,	sp,	#344
    str	x28,	[sp, fp]

    movz	fp,	#1252
    add	x28,	sp,	#348
    str	x28,	[sp, fp]

    movz	fp,	#1260
    add	x28,	sp,	#352
    str	x28,	[sp, fp]

    movz	fp,	#1268
    add	x28,	sp,	#356
    str	x28,	[sp, fp]

    movz	fp,	#1276
    add	x28,	sp,	#360
    str	x28,	[sp, fp]

    movz	fp,	#1284
    add	x28,	sp,	#364
    str	x28,	[sp, fp]

    movz	fp,	#1292
    add	x28,	sp,	#368
    str	x28,	[sp, fp]

    movz	fp,	#1300
    add	x28,	sp,	#372
    str	x28,	[sp, fp]

    movz	fp,	#1308
    add	x28,	sp,	#376
    str	x28,	[sp, fp]

    movz	fp,	#1316
    add	x28,	sp,	#380
    str	x28,	[sp, fp]

    movz	fp,	#1324
    add	x28,	sp,	#384
    str	x28,	[sp, fp]

    movz	fp,	#1332
    add	x28,	sp,	#388
    str	x28,	[sp, fp]

    movz	fp,	#1340
    add	x28,	sp,	#392
    str	x28,	[sp, fp]

    movz	fp,	#1348
    add	x28,	sp,	#396
    str	x28,	[sp, fp]

    movz	fp,	#1356
    add	x28,	sp,	#400
    str	x28,	[sp, fp]

    movz	fp,	#1364
    add	x28,	sp,	#404
    str	x28,	[sp, fp]

    movz	fp,	#1372
    add	x28,	sp,	#408
    str	x28,	[sp, fp]

    movz	fp,	#1380
    add	x28,	sp,	#412
    str	x28,	[sp, fp]

    movz	w28,	#0
    str	w28,	[sp, #1392]

    movz	w28,	#0
    str	w28,	[sp, #1388]


main_113:
    ldr	w28,	[sp, #1400]

    cmp	w28,	#1
    ble	main_413

main_117:
    movz	w28,	#1
    movz	fp,	#1780
    ldr	x12,	[sp, fp]

    str	w28,	[x12]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#2
    ble	main_413

main_119:
    movz	w28,	#2
    movz	fp,	#1692
    ldr	x20,	[sp, fp]

    str	w28,	[x20]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#3
    ble	main_413

main_121:
    movz	w28,	#3
    movz	fp,	#1716
    ldr	x16,	[sp, fp]

    str	w28,	[x16]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#4
    ble	main_413

main_123:
    movz	w28,	#4
    movz	fp,	#1732
    ldr	x22,	[sp, fp]

    str	w28,	[x22]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#5
    ble	main_413

main_125:
    movz	w28,	#5
    movz	fp,	#1684
    ldr	x17,	[sp, fp]

    str	w28,	[x17]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#6
    ble	main_413

main_127:
    movz	w28,	#6
    movz	fp,	#1740
    ldr	x25,	[sp, fp]

    str	w28,	[x25]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#7
    ble	main_413

main_129:
    movz	w28,	#7
    movz	fp,	#1812
    ldr	x24,	[sp, fp]

    str	w28,	[x24]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#8
    ble	main_413

main_131:
    movz	w28,	#8
    movz	fp,	#1700
    ldr	x23,	[sp, fp]

    str	w28,	[x23]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#9
    ble	main_413

main_133:
    movz	w28,	#9
    movz	fp,	#1748
    ldr	x0,	[sp, fp]

    str	w28,	[x0]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#10
    ble	main_413

main_135:
    movz	w28,	#10
    movz	fp,	#1708
    ldr	x13,	[sp, fp]

    str	w28,	[x13]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#11
    ble	main_413

main_137:
    movz	w28,	#11
    movz	fp,	#1836
    ldr	x5,	[sp, fp]

    str	w28,	[x5]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#12
    ble	main_413

main_139:
    movz	w28,	#12
    movz	fp,	#1788
    ldr	x15,	[sp, fp]

    str	w28,	[x15]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#13
    ble	main_413

main_141:
    movz	w28,	#13
    movz	fp,	#1676
    ldr	x14,	[sp, fp]

    str	w28,	[x14]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#14
    ble	main_413

main_143:
    movz	w28,	#14
    movz	fp,	#1756
    ldr	x3,	[sp, fp]

    str	w28,	[x3]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#15
    ble	main_413

main_145:
    movz	w28,	#15
    movz	fp,	#1436
    ldr	x7,	[sp, fp]

    str	w28,	[x7]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#16
    ble	main_413

main_147:
    movz	w28,	#16
    movz	fp,	#1820
    ldr	x27,	[sp, fp]

    str	w28,	[x27]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#17
    ble	main_413

main_149:
    movz	w28,	#17
    movz	fp,	#1660
    ldr	x8,	[sp, fp]

    str	w28,	[x8]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#18
    ble	main_413

main_151:
    movz	w28,	#18
    movz	fp,	#1444
    ldr	x10,	[sp, fp]

    str	w28,	[x10]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#19
    ble	main_413

main_153:
    movz	w28,	#19
    movz	fp,	#1724
    ldr	x19,	[sp, fp]

    str	w28,	[x19]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#20
    ble	main_413

main_155:
    movz	w28,	#20
    movz	fp,	#1668
    ldr	x11,	[sp, fp]

    str	w28,	[x11]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#21
    ble	main_413

main_157:
    movz	w28,	#21
    movz	fp,	#1796
    ldr	x18,	[sp, fp]

    str	w28,	[x18]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#22
    ble	main_413

main_159:
    movz	w28,	#22
    movz	fp,	#1412
    ldr	x26,	[sp, fp]

    str	w28,	[x26]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#23
    ble	main_413

main_161:
    movz	w28,	#23
    movz	fp,	#1764
    ldr	x6,	[sp, fp]

    str	w28,	[x6]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#24
    ble	main_413

main_163:
    movz	w28,	#24
    movz	fp,	#1804
    ldr	x21,	[sp, fp]

    str	w28,	[x21]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#25
    ble	main_413

main_165:
    movz	w28,	#25
    movz	fp,	#1828
    ldr	x2,	[sp, fp]

    str	w28,	[x2]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#26
    ble	main_413

main_167:
    movz	w28,	#26
    movz	fp,	#1772
    ldr	x9,	[sp, fp]

    str	w28,	[x9]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#27
    ble	main_413

main_169:
    movz	w28,	#27
    movz	fp,	#1420
    ldr	x1,	[sp, fp]

    str	w28,	[x1]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#28
    ble	main_413

main_171:
    movz	w28,	#28
    movz	fp,	#1428
    ldr	x4,	[sp, fp]

    str	w28,	[x4]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#29
    ble	main_413

main_173:
    movz	w28,	#29
    movz	fp,	#476
    mov	w1,	w28
    ldr	x21,	[sp, fp]

    movz	fp,	#1908
    str	x21,	[sp, fp]

    movz	fp,	#1908
    ldr	x22,	[sp, fp]

    str	w1,	[x22]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#30
    ble	main_413

main_175:
    movz	w28,	#30
    movz	fp,	#772
    mov	w1,	w28
    ldr	x24,	[sp, fp]

    movz	fp,	#1916
    str	x24,	[sp, fp]

    movz	fp,	#1916
    ldr	x25,	[sp, fp]

    str	w1,	[x25]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#31
    ble	main_413

main_177:
    movz	w28,	#31
    movz	fp,	#468
    mov	w1,	w28
    ldr	x27,	[sp, fp]

    movz	fp,	#1924
    str	x27,	[sp, fp]

    movz	fp,	#1924
    ldr	x28,	[sp, fp]

    str	w1,	[x28]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#32
    ble	main_413

main_179:
    movz	w28,	#32
    movz	fp,	#676
    mov	w3,	w28
    ldr	x1,	[sp, fp]

    movz	fp,	#1932
    str	x1,	[sp, fp]

    movz	fp,	#1932
    ldr	x2,	[sp, fp]

    str	w3,	[x2]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#33
    ble	main_413

main_181:
    movz	w28,	#33
    movz	fp,	#684
    mov	w1,	w28
    ldr	x4,	[sp, fp]

    movz	fp,	#2412
    str	x4,	[sp, fp]

    movz	fp,	#2412
    ldr	x5,	[sp, fp]

    str	w1,	[x5]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#34
    ble	main_413

main_183:
    movz	w28,	#34
    movz	fp,	#1004
    mov	w1,	w28
    ldr	x4,	[sp, fp]

    movz	fp,	#2428
    str	x4,	[sp, fp]

    movz	fp,	#2428
    ldr	x5,	[sp, fp]

    str	w1,	[x5]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#35
    ble	main_413

main_185:
    movz	w28,	#35
    movz	fp,	#1012
    mov	w3,	w28
    ldr	x1,	[sp, fp]

    movz	fp,	#2420
    str	x1,	[sp, fp]

    movz	fp,	#2420
    ldr	x2,	[sp, fp]

    str	w3,	[x2]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#36
    ble	main_413

main_187:
    movz	w28,	#36
    movz	fp,	#1020
    mov	w1,	w28
    ldr	x27,	[sp, fp]

    movz	fp,	#2404
    str	x27,	[sp, fp]

    movz	fp,	#2404
    ldr	x28,	[sp, fp]

    str	w1,	[x28]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#37
    ble	main_413

main_189:
    movz	w28,	#37
    movz	fp,	#1028
    mov	w1,	w28
    ldr	x24,	[sp, fp]

    movz	fp,	#2396
    str	x24,	[sp, fp]

    movz	fp,	#2396
    ldr	x25,	[sp, fp]

    str	w1,	[x25]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#38
    ble	main_413

main_191:
    movz	w28,	#38
    movz	fp,	#628
    mov	w1,	w28
    ldr	x21,	[sp, fp]

    movz	fp,	#2388
    str	x21,	[sp, fp]

    movz	fp,	#2388
    ldr	x22,	[sp, fp]

    str	w1,	[x22]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#39
    ble	main_413

main_193:
    movz	w28,	#39
    movz	fp,	#636
    mov	w1,	w28
    ldr	x18,	[sp, fp]

    movz	fp,	#2380
    str	x18,	[sp, fp]

    movz	fp,	#2380
    ldr	x19,	[sp, fp]

    str	w1,	[x19]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#40
    ble	main_413

main_195:
    movz	w28,	#40
    movz	fp,	#644
    mov	w1,	w28
    ldr	x15,	[sp, fp]

    movz	fp,	#2372
    str	x15,	[sp, fp]

    movz	fp,	#2372
    ldr	x16,	[sp, fp]

    str	w1,	[x16]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#41
    ble	main_413

main_197:
    movz	w28,	#41
    movz	fp,	#652
    mov	w1,	w28
    ldr	x12,	[sp, fp]

    movz	fp,	#2364
    str	x12,	[sp, fp]

    movz	fp,	#2364
    ldr	x13,	[sp, fp]

    str	w1,	[x13]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#42
    ble	main_413

main_199:
    movz	w28,	#42
    movz	fp,	#660
    mov	w1,	w28
    ldr	x9,	[sp, fp]

    movz	fp,	#2356
    str	x9,	[sp, fp]

    movz	fp,	#2356
    ldr	x10,	[sp, fp]

    str	w1,	[x10]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#43
    ble	main_413

main_201:
    movz	w28,	#43
    movz	fp,	#668
    mov	w1,	w28
    ldr	x6,	[sp, fp]

    movz	fp,	#2348
    str	x6,	[sp, fp]

    movz	fp,	#2348
    ldr	x7,	[sp, fp]

    str	w1,	[x7]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#44
    ble	main_413

main_203:
    movz	w28,	#44
    movz	fp,	#692
    mov	w1,	w28
    ldr	x3,	[sp, fp]

    movz	fp,	#2340
    str	x3,	[sp, fp]

    movz	fp,	#2340
    ldr	x4,	[sp, fp]

    str	w1,	[x4]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#45
    ble	main_413

main_205:
    movz	w28,	#45
    movz	fp,	#700
    mov	w3,	w28
    ldr	x0,	[sp, fp]

    movz	fp,	#2332
    str	x0,	[sp, fp]

    movz	fp,	#2332
    ldr	x1,	[sp, fp]

    str	w3,	[x1]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#46
    ble	main_413

main_207:
    movz	w28,	#46
    movz	fp,	#708
    mov	w1,	w28
    ldr	x26,	[sp, fp]

    movz	fp,	#2324
    str	x26,	[sp, fp]

    movz	fp,	#2324
    ldr	x27,	[sp, fp]

    str	w1,	[x27]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#47
    ble	main_413

main_209:
    movz	w28,	#47
    movz	fp,	#716
    mov	w1,	w28
    ldr	x23,	[sp, fp]

    movz	fp,	#2316
    str	x23,	[sp, fp]

    movz	fp,	#2316
    ldr	x24,	[sp, fp]

    str	w1,	[x24]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#48
    ble	main_413

main_211:
    movz	w28,	#48
    movz	fp,	#724
    mov	w1,	w28
    ldr	x20,	[sp, fp]

    movz	fp,	#2308
    str	x20,	[sp, fp]

    movz	fp,	#2308
    ldr	x21,	[sp, fp]

    str	w1,	[x21]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#49
    ble	main_413

main_213:
    movz	w28,	#49
    movz	fp,	#732
    mov	w1,	w28
    ldr	x17,	[sp, fp]

    movz	fp,	#2300
    str	x17,	[sp, fp]

    movz	fp,	#2300
    ldr	x18,	[sp, fp]

    str	w1,	[x18]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#50
    ble	main_413

main_215:
    movz	w28,	#50
    movz	fp,	#740
    mov	w1,	w28
    ldr	x14,	[sp, fp]

    movz	fp,	#2292
    str	x14,	[sp, fp]

    movz	fp,	#2292
    ldr	x15,	[sp, fp]

    str	w1,	[x15]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#51
    ble	main_413

main_217:
    movz	w28,	#51
    movz	fp,	#756
    mov	w1,	w28
    ldr	x11,	[sp, fp]

    movz	fp,	#2284
    str	x11,	[sp, fp]

    movz	fp,	#2284
    ldr	x12,	[sp, fp]

    str	w1,	[x12]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#52
    ble	main_413

main_219:
    movz	w28,	#52
    movz	fp,	#764
    mov	w1,	w28
    ldr	x8,	[sp, fp]

    movz	fp,	#2276
    str	x8,	[sp, fp]

    movz	fp,	#2276
    ldr	x9,	[sp, fp]

    str	w1,	[x9]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#53
    ble	main_413

main_221:
    movz	w28,	#53
    movz	fp,	#1036
    mov	w1,	w28
    ldr	x5,	[sp, fp]

    movz	fp,	#2268
    str	x5,	[sp, fp]

    movz	fp,	#2268
    ldr	x6,	[sp, fp]

    str	w1,	[x6]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#54
    ble	main_413

main_223:
    movz	w28,	#54
    movz	fp,	#748
    mov	w1,	w28
    ldr	x2,	[sp, fp]

    movz	fp,	#2260
    str	x2,	[sp, fp]

    movz	fp,	#2260
    ldr	x3,	[sp, fp]

    str	w1,	[x3]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#55
    ble	main_413

main_225:
    movz	w28,	#55
    movz	fp,	#2252
    mov	w2,	w28
    ldr	x28,	[sp, #416]

    str	x28,	[sp, fp]

    movz	fp,	#2252
    ldr	x0,	[sp, fp]

    str	w2,	[x0]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#56
    ble	main_413

main_227:
    movz	w28,	#56
    ldr	x25,	[sp, #424]

    movz	fp,	#2244
    mov	w1,	w28
    str	x25,	[sp, fp]

    movz	fp,	#2244
    ldr	x26,	[sp, fp]

    str	w1,	[x26]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#57
    ble	main_413

main_229:
    movz	w28,	#57
    movz	fp,	#1044
    mov	w1,	w28
    ldr	x22,	[sp, fp]

    movz	fp,	#2236
    str	x22,	[sp, fp]

    movz	fp,	#2236
    ldr	x23,	[sp, fp]

    str	w1,	[x23]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#58
    ble	main_413

main_231:
    movz	w28,	#58
    movz	fp,	#1052
    mov	w1,	w28
    ldr	x19,	[sp, fp]

    movz	fp,	#2228
    str	x19,	[sp, fp]

    movz	fp,	#2228
    ldr	x20,	[sp, fp]

    str	w1,	[x20]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#59
    ble	main_413

main_233:
    movz	w28,	#59
    movz	fp,	#1060
    mov	w1,	w28
    ldr	x16,	[sp, fp]

    movz	fp,	#2220
    str	x16,	[sp, fp]

    movz	fp,	#2220
    ldr	x17,	[sp, fp]

    str	w1,	[x17]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#60
    ble	main_413

main_235:
    movz	w28,	#60
    movz	fp,	#1068
    mov	w1,	w28
    ldr	x13,	[sp, fp]

    movz	fp,	#2212
    str	x13,	[sp, fp]

    movz	fp,	#2212
    ldr	x14,	[sp, fp]

    str	w1,	[x14]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#61
    ble	main_413

main_237:
    movz	w28,	#61
    movz	fp,	#1076
    mov	w1,	w28
    ldr	x10,	[sp, fp]

    movz	fp,	#2204
    str	x10,	[sp, fp]

    movz	fp,	#2204
    ldr	x11,	[sp, fp]

    str	w1,	[x11]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#62
    ble	main_413

main_239:
    movz	w28,	#62
    movz	fp,	#1084
    mov	w1,	w28
    ldr	x7,	[sp, fp]

    movz	fp,	#2196
    str	x7,	[sp, fp]

    movz	fp,	#2196
    ldr	x8,	[sp, fp]

    str	w1,	[x8]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#63
    ble	main_413

main_241:
    movz	w28,	#63
    movz	fp,	#1092
    mov	w1,	w28
    ldr	x4,	[sp, fp]

    movz	fp,	#2188
    str	x4,	[sp, fp]

    movz	fp,	#2188
    ldr	x5,	[sp, fp]

    str	w1,	[x5]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#64
    ble	main_413

main_243:
    movz	w28,	#64
    movz	fp,	#1100
    mov	w3,	w28
    ldr	x1,	[sp, fp]

    movz	fp,	#2180
    str	x1,	[sp, fp]

    movz	fp,	#2180
    ldr	x2,	[sp, fp]

    str	w3,	[x2]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#65
    ble	main_413

main_245:
    movz	w28,	#65
    movz	fp,	#1108
    mov	w1,	w28
    ldr	x27,	[sp, fp]

    movz	fp,	#2172
    str	x27,	[sp, fp]

    movz	fp,	#2172
    ldr	x28,	[sp, fp]

    str	w1,	[x28]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#66
    ble	main_413

main_247:
    movz	w28,	#66
    movz	fp,	#1116
    mov	w1,	w28
    ldr	x24,	[sp, fp]

    movz	fp,	#2164
    str	x24,	[sp, fp]

    movz	fp,	#2164
    ldr	x25,	[sp, fp]

    str	w1,	[x25]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#67
    ble	main_413

main_249:
    movz	w28,	#67
    movz	fp,	#1124
    mov	w1,	w28
    ldr	x21,	[sp, fp]

    movz	fp,	#2156
    str	x21,	[sp, fp]

    movz	fp,	#2156
    ldr	x22,	[sp, fp]

    str	w1,	[x22]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#68
    ble	main_413

main_251:
    movz	w28,	#68
    movz	fp,	#1132
    mov	w1,	w28
    ldr	x18,	[sp, fp]

    movz	fp,	#2148
    str	x18,	[sp, fp]

    movz	fp,	#2148
    ldr	x19,	[sp, fp]

    str	w1,	[x19]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#69
    ble	main_413

main_253:
    movz	w28,	#69
    movz	fp,	#1140
    mov	w1,	w28
    ldr	x15,	[sp, fp]

    movz	fp,	#2140
    str	x15,	[sp, fp]

    movz	fp,	#2140
    ldr	x16,	[sp, fp]

    str	w1,	[x16]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#70
    ble	main_413

main_255:
    movz	w28,	#70
    movz	fp,	#1148
    mov	w1,	w28
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #3400]

    ldr	x13,	[sp, #3400]

    str	w1,	[x13]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#71
    ble	main_413

main_257:
    movz	w28,	#71
    movz	fp,	#1156
    mov	w1,	w28
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #3392]

    ldr	x10,	[sp, #3392]

    str	w1,	[x10]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#72
    ble	main_413

main_259:
    movz	w28,	#72
    movz	fp,	#1164
    mov	w1,	w28
    ldr	x6,	[sp, fp]

    str	x6,	[sp, #3384]

    ldr	x7,	[sp, #3384]

    str	w1,	[x7]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#73
    ble	main_413

main_261:
    movz	w28,	#73
    movz	fp,	#1172
    mov	w1,	w28
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #3376]

    ldr	x4,	[sp, #3376]

    str	w1,	[x4]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#74
    ble	main_413

main_263:
    movz	w28,	#74
    movz	fp,	#1180
    mov	w3,	w28
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #3368]

    ldr	x1,	[sp, #3368]

    str	w3,	[x1]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#75
    ble	main_413

main_265:
    movz	w28,	#75
    movz	fp,	#1188
    mov	w1,	w28
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #3360]

    ldr	x27,	[sp, #3360]

    str	w1,	[x27]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#76
    ble	main_413

main_267:
    movz	w28,	#76
    movz	fp,	#1196
    mov	w1,	w28
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #3352]

    ldr	x24,	[sp, #3352]

    str	w1,	[x24]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#77
    ble	main_413

main_269:
    movz	w28,	#77
    movz	fp,	#1204
    mov	w1,	w28
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #3344]

    ldr	x21,	[sp, #3344]

    str	w1,	[x21]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#78
    ble	main_413

main_271:
    movz	w28,	#78
    movz	fp,	#1212
    mov	w1,	w28
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #3336]

    ldr	x18,	[sp, #3336]

    str	w1,	[x18]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#79
    ble	main_413

main_273:
    movz	w28,	#79
    movz	fp,	#1220
    mov	w1,	w28
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #3328]

    ldr	x15,	[sp, #3328]

    str	w1,	[x15]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#80
    ble	main_413

main_275:
    movz	w28,	#80
    movz	fp,	#1228
    mov	w1,	w28
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #3320]

    ldr	x12,	[sp, #3320]

    str	w1,	[x12]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#81
    ble	main_413

main_277:
    movz	w28,	#81
    movz	fp,	#1236
    mov	w1,	w28
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #3312]

    ldr	x9,	[sp, #3312]

    str	w1,	[x9]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#82
    ble	main_413

main_279:
    movz	w28,	#82
    movz	fp,	#1244
    mov	w1,	w28
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #3304]

    ldr	x6,	[sp, #3304]

    str	w1,	[x6]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#83
    ble	main_413

main_281:
    movz	w28,	#83
    movz	fp,	#1252
    mov	w1,	w28
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #3296]

    ldr	x3,	[sp, #3296]

    str	w1,	[x3]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#84
    ble	main_413

main_283:
    movz	w28,	#84
    movz	fp,	#1260
    mov	w2,	w28
    ldr	x28,	[sp, fp]

    str	x28,	[sp, #3288]

    ldr	x0,	[sp, #3288]

    str	w2,	[x0]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#85
    ble	main_413

main_285:
    movz	w28,	#85
    movz	fp,	#1268
    mov	w1,	w28
    ldr	x25,	[sp, fp]

    str	x25,	[sp, #3280]

    ldr	x26,	[sp, #3280]

    str	w1,	[x26]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#86
    ble	main_413

main_287:
    movz	w28,	#86
    movz	fp,	#1276
    mov	w1,	w28
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #3272]

    ldr	x23,	[sp, #3272]

    str	w1,	[x23]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#87
    ble	main_413

main_289:
    movz	w28,	#87
    movz	fp,	#1284
    mov	w1,	w28
    ldr	x19,	[sp, fp]

    movz	fp,	#2484
    str	x19,	[sp, fp]

    movz	fp,	#2484
    ldr	x20,	[sp, fp]

    str	w1,	[x20]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#88
    ble	main_413

main_291:
    movz	w28,	#88
    movz	fp,	#1292
    mov	w1,	w28
    ldr	x16,	[sp, fp]

    movz	fp,	#2476
    str	x16,	[sp, fp]

    movz	fp,	#2476
    ldr	x17,	[sp, fp]

    str	w1,	[x17]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#89
    ble	main_413

main_293:
    movz	w28,	#89
    movz	fp,	#1300
    mov	w1,	w28
    ldr	x13,	[sp, fp]

    movz	fp,	#2468
    str	x13,	[sp, fp]

    movz	fp,	#2468
    ldr	x14,	[sp, fp]

    str	w1,	[x14]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#90
    ble	main_413

main_295:
    movz	w28,	#90
    movz	fp,	#1308
    mov	w1,	w28
    ldr	x10,	[sp, fp]

    movz	fp,	#2460
    str	x10,	[sp, fp]

    movz	fp,	#2460
    ldr	x11,	[sp, fp]

    str	w1,	[x11]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#91
    ble	main_413

main_297:
    movz	w28,	#91
    movz	fp,	#1316
    mov	w1,	w28
    ldr	x7,	[sp, fp]

    movz	fp,	#2452
    str	x7,	[sp, fp]

    movz	fp,	#2452
    ldr	x8,	[sp, fp]

    str	w1,	[x8]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#92
    ble	main_413

main_299:
    movz	w28,	#92
    movz	fp,	#1324
    mov	w1,	w28
    ldr	x4,	[sp, fp]

    movz	fp,	#2444
    str	x4,	[sp, fp]

    movz	fp,	#2444
    ldr	x5,	[sp, fp]

    str	w1,	[x5]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#93
    ble	main_413

main_301:
    movz	w28,	#93
    movz	fp,	#1332
    mov	w3,	w28
    ldr	x1,	[sp, fp]

    movz	fp,	#2436
    str	x1,	[sp, fp]

    movz	fp,	#2436
    ldr	x2,	[sp, fp]

    str	w3,	[x2]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#94
    ble	main_413

main_303:
    movz	w28,	#94
    movz	fp,	#1340
    mov	w1,	w28
    ldr	x27,	[sp, fp]

    movz	fp,	#1972
    str	x27,	[sp, fp]

    movz	fp,	#1972
    ldr	x28,	[sp, fp]

    str	w1,	[x28]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#95
    ble	main_413

main_305:
    movz	w28,	#95
    movz	fp,	#1348
    mov	w1,	w28
    ldr	x24,	[sp, fp]

    movz	fp,	#1964
    str	x24,	[sp, fp]

    movz	fp,	#1964
    ldr	x25,	[sp, fp]

    str	w1,	[x25]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#96
    ble	main_413

main_307:
    movz	w28,	#96
    movz	fp,	#1356
    mov	w1,	w28
    ldr	x21,	[sp, fp]

    movz	fp,	#1956
    str	x21,	[sp, fp]

    movz	fp,	#1956
    ldr	x22,	[sp, fp]

    str	w1,	[x22]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#97
    ble	main_413

main_309:
    movz	w28,	#97
    movz	fp,	#1364
    mov	w1,	w28
    ldr	x18,	[sp, fp]

    movz	fp,	#1948
    str	x18,	[sp, fp]

    movz	fp,	#1948
    ldr	x19,	[sp, fp]

    str	w1,	[x19]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#98
    ble	main_413

main_311:
    movz	w28,	#98
    movz	fp,	#1372
    mov	w1,	w28
    ldr	x15,	[sp, fp]

    movz	fp,	#1980
    str	x15,	[sp, fp]

    movz	fp,	#1980
    ldr	x16,	[sp, fp]

    str	w1,	[x16]

    ldr	w28,	[sp, #1400]

    cmp	w28,	#99
    ble	main_413

main_313:
    movz	w28,	#99
    movz	fp,	#1380
    mov	w1,	w28
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #432]

    ldr	x13,	[sp, #432]

    str	w1,	[x13]


main_413:
    ldr	w28,	[sp, #1388]

    add	w28,	w28,	#1
    str	w28,	[sp, #456]

    ldr	w28,	[sp, #1392]

    str	w28,	[sp, #444]

    movz	w28,	#0
    str	w28,	[sp, #440]


main_415:
    ldr	w28,	[sp, #440]

    cmp	w28,	#100
    bge	main_424

main_419:
    ldr	w28,	[sp, #440]

    lsl	w28,	w28,	#2
    mov	x28,	x28
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    ldr	w1,	[x28]

    ldr	w13,	[sp, #444]

    str	w13,	[sp, #3156]

    ldr	w14,	[sp, #3156]

    ldr	w10,	[sp, #440]

    add	w3,	w1,	w14
    str	w10,	[sp, #3152]

    mov	w28,	w3
    ldr	w11,	[sp, #3152]

    add	w4,	w11,	#1
    str	w4,	[sp, #3144]

    ldr	w5,	[sp, #3144]

    str	w5,	[sp, #460]

    str	w28,	[sp, #444]

    ldr	w28,	[sp, #460]

    str	w28,	[sp, #440]

    b	main_415

main_424:
    movz	w28,	#65535
    ldr	w16,	[sp, #444]

    mov	w1,	w28
    str	w16,	[sp, #3160]

    ldr	w17,	[sp, #3160]

    sdiv	w28,	w17,	w1
    str	w28,	[sp, #464]

    ldr	w28,	[sp, #464]

    ldr	w7,	[sp, #464]

    lsl	w1,	w28,	#16
    str	w7,	[sp, #3148]

    ldr	w8,	[sp, #3148]

    ldr	w19,	[sp, #444]

    sub	w1,	w1,	w8,	lsl #0
    str	w19,	[sp, #3164]

    ldr	w20,	[sp, #3164]

    ldr	w7,	[sp, #456]

    sub	w4,	w20,	w1
    str	w7,	[sp, #2492]

    ldr	w22,	[sp, #1396]

    str	w22,	[sp, #3168]

    ldr	w8,	[sp, #2492]

    ldr	w0,	[sp, #3168]

    cmp	w8,	w0
    bge	main_428

main_112:
    mov	w28,	w4
    str	w28,	[sp, #1392]

    ldr	w28,	[sp, #456]

    str	w28,	[sp, #1388]

    b	main_113

main_428:
    mov	w0,	w4
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


