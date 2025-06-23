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
    str	w0,	[sp, #1372]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1376]

    mov	w0,	w26

main_4:
    cmp	w0,	#100
    bge	main_10

main_7:
    lsl	w9,	w0,	#2
    movz	w26,	#0
    mov	x2,	x9
    mov	w25,	w26
    add	x2,	sp,	x2
    add	w26,	w0,	#1
    mov	w0,	w26
    add	x2,	x2,	#16
    str	w25,	[x2]

    b	main_4

main_10:
    movz	w27,	#0
    ldr	w15,	[sp, #1372]

    cmp	w27,	w15
    bge	main_427

main_12:
    add	x13,	sp,	#20
    movz	fp,	#1436
    add	x16,	sp,	#24
    add	x3,	sp,	#28
    add	x27,	sp,	#32
    add	x8,	sp,	#36
    add	x19,	sp,	#40
    add	x24,	sp,	#44
    add	x20,	sp,	#48
    add	x21,	sp,	#52
    add	x18,	sp,	#56
    add	x26,	sp,	#60
    add	x10,	sp,	#64
    add	x9,	sp,	#68
    add	x6,	sp,	#72
    add	x23,	sp,	#76
    add	x14,	sp,	#80
    add	x22,	sp,	#84
    add	x28,	sp,	#88
    add	x15,	sp,	#92
    add	x11,	sp,	#96
    add	x4,	sp,	#100
    add	x7,	sp,	#104
    add	x5,	sp,	#108
    add	x17,	sp,	#112
    add	x1,	sp,	#116
    add	x25,	sp,	#120
    add	x2,	sp,	#124
    add	x0,	sp,	#128
    str	x13,	[sp, fp]

    movz	fp,	#1444
    str	x16,	[sp, fp]

    movz	fp,	#1396
    str	x3,	[sp, #1984]

    str	x27,	[sp, fp]

    movz	fp,	#1452
    str	x8,	[sp, #1920]

    str	x19,	[sp, fp]

    movz	fp,	#1388
    str	x24,	[sp, fp]

    movz	fp,	#1380
    str	x20,	[sp, #1952]

    str	x21,	[sp, fp]

    movz	fp,	#940
    str	x18,	[sp, fp]

    movz	fp,	#1428
    str	x26,	[sp, #1968]

    add	x26,	sp,	#132
    str	x10,	[sp, fp]

    movz	fp,	#1460
    str	x9,	[sp, #2000]

    str	x6,	[sp, #1992]

    str	x23,	[sp, #1960]

    str	x14,	[sp, #1936]

    str	x22,	[sp, fp]

    movz	fp,	#932
    str	x28,	[sp, #1896]

    str	x15,	[sp, fp]

    movz	fp,	#1412
    str	x11,	[sp, #1928]

    str	x4,	[sp, fp]

    movz	fp,	#1420
    str	x7,	[sp, fp]

    movz	fp,	#1404
    str	x5,	[sp, #1912]

    str	x17,	[sp, #1944]

    str	x1,	[sp, fp]

    movz	fp,	#724
    str	x25,	[sp, #1888]

    str	x2,	[sp, #1904]

    str	x0,	[sp, #1976]

    add	x0,	sp,	#136
    str	x26,	[sp, #640]

    add	x26,	sp,	#140
    str	x0,	[sp, #648]

    add	x0,	sp,	#144
    str	x26,	[sp, #456]

    add	x26,	sp,	#148
    str	x0,	[sp, #472]

    add	x0,	sp,	#152
    str	x26,	[sp, fp]

    add	x26,	sp,	#156
    movz	fp,	#732
    str	x0,	[sp, fp]

    add	x0,	sp,	#160
    movz	fp,	#740
    str	x26,	[sp, fp]

    add	x26,	sp,	#164
    movz	fp,	#748
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#756
    str	x26,	[sp, fp]

    add	x26,	sp,	#172
    movz	fp,	#764
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#956
    str	x26,	[sp, fp]

    add	x26,	sp,	#180
    movz	fp,	#964
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#972
    str	x26,	[sp, fp]

    add	x26,	sp,	#188
    movz	fp,	#980
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#988
    str	x26,	[sp, fp]

    add	x26,	sp,	#196
    movz	fp,	#996
    str	x0,	[sp, fp]

    add	x0,	sp,	#200
    movz	fp,	#1004
    str	x26,	[sp, fp]

    add	x26,	sp,	#204
    movz	fp,	#660
    str	x0,	[sp, fp]

    add	x0,	sp,	#208
    movz	fp,	#668
    str	x26,	[sp, fp]

    add	x26,	sp,	#212
    movz	fp,	#676
    str	x0,	[sp, fp]

    add	x0,	sp,	#216
    movz	fp,	#684
    str	x26,	[sp, fp]

    add	x26,	sp,	#220
    movz	fp,	#692
    str	x0,	[sp, fp]

    add	x0,	sp,	#224
    movz	fp,	#700
    str	x26,	[sp, fp]

    add	x26,	sp,	#228
    movz	fp,	#708
    str	x0,	[sp, fp]

    add	x0,	sp,	#232
    movz	fp,	#1012
    str	x26,	[sp, fp]

    add	x26,	sp,	#236
    movz	fp,	#716
    str	x0,	[sp, fp]

    movz	fp,	#1020
    add	x0,	sp,	#240
    str	x26,	[sp, #416]

    add	x26,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x26,	[sp, fp]

    add	x26,	sp,	#252
    movz	fp,	#1028
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#1036
    str	x26,	[sp, fp]

    add	x26,	sp,	#260
    movz	fp,	#1044
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#1052
    str	x26,	[sp, fp]

    add	x26,	sp,	#268
    movz	fp,	#1060
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#1068
    str	x26,	[sp, fp]

    add	x26,	sp,	#276
    movz	fp,	#1076
    str	x0,	[sp, fp]

    add	x0,	sp,	#280
    movz	fp,	#1084
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#1092
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#1100
    str	x26,	[sp, fp]

    add	x26,	sp,	#292
    movz	fp,	#1108
    str	x0,	[sp, fp]

    add	x0,	sp,	#296
    movz	fp,	#1116
    str	x26,	[sp, fp]

    add	x26,	sp,	#300
    movz	fp,	#1124
    str	x0,	[sp, fp]

    add	x0,	sp,	#304
    movz	fp,	#1132
    str	x26,	[sp, fp]

    add	x26,	sp,	#308
    movz	fp,	#1140
    str	x0,	[sp, fp]

    add	x0,	sp,	#312
    movz	fp,	#1148
    str	x26,	[sp, fp]

    add	x26,	sp,	#316
    movz	fp,	#1156
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#1164
    str	x26,	[sp, fp]

    add	x26,	sp,	#324
    movz	fp,	#1172
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#1180
    str	x26,	[sp, fp]

    add	x26,	sp,	#332
    movz	fp,	#1188
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#1196
    str	x26,	[sp, fp]

    add	x26,	sp,	#340
    movz	fp,	#1204
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1212
    str	x26,	[sp, fp]

    add	x26,	sp,	#348
    movz	fp,	#1220
    str	x0,	[sp, fp]

    add	x0,	sp,	#352
    movz	fp,	#1228
    str	x26,	[sp, fp]

    add	x26,	sp,	#356
    movz	fp,	#1236
    str	x0,	[sp, fp]

    add	x0,	sp,	#360
    movz	fp,	#1244
    str	x26,	[sp, fp]

    add	x26,	sp,	#364
    movz	fp,	#1252
    str	x0,	[sp, fp]

    add	x0,	sp,	#368
    movz	fp,	#1260
    str	x26,	[sp, fp]

    add	x26,	sp,	#372
    movz	fp,	#1268
    str	x0,	[sp, fp]

    add	x0,	sp,	#376
    movz	fp,	#1276
    str	x26,	[sp, fp]

    add	x26,	sp,	#380
    movz	fp,	#1284
    str	x0,	[sp, fp]

    add	x0,	sp,	#384
    movz	fp,	#1292
    str	x26,	[sp, fp]

    add	x26,	sp,	#388
    movz	fp,	#1300
    str	x0,	[sp, fp]

    add	x0,	sp,	#392
    movz	fp,	#1308
    str	x26,	[sp, fp]

    add	x26,	sp,	#396
    movz	fp,	#1316
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1324
    str	x26,	[sp, fp]

    add	x26,	sp,	#404
    movz	fp,	#1332
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1340
    str	x26,	[sp, fp]

    add	x26,	sp,	#412
    movz	fp,	#1348
    str	x0,	[sp, fp]

    movz	fp,	#1356
    str	x26,	[sp, fp]

    movz	w26,	#0
    mov	w0,	w26
    movz	w26,	#0
    str	w0,	[sp, #1368]

    mov	w0,	w26
    str	w0,	[sp, #1364]


main_113:
    ldr	w26,	[sp, #1376]

    cmp	w26,	#1
    ble	main_413

main_117:
    movz	w26,	#1
    movz	fp,	#1436
    ldr	x8,	[sp, fp]

    str	w26,	[x8]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#2
    ble	main_413

main_119:
    movz	w26,	#2
    movz	fp,	#1444
    ldr	x11,	[sp, fp]

    str	w26,	[x11]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#3
    ble	main_413

main_121:
    movz	w26,	#3
    ldr	x0,	[sp, #1984]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#4
    ble	main_413

main_123:
    movz	w26,	#4
    movz	fp,	#1396
    ldr	x21,	[sp, fp]

    str	w26,	[x21]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#5
    ble	main_413

main_125:
    movz	w26,	#5
    ldr	x3,	[sp, #1920]

    str	w26,	[x3]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#6
    ble	main_413

main_127:
    movz	w26,	#6
    movz	fp,	#1452
    ldr	x14,	[sp, fp]

    str	w26,	[x14]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#7
    ble	main_413

main_129:
    movz	w26,	#7
    movz	fp,	#1388
    ldr	x18,	[sp, fp]

    str	w26,	[x18]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#8
    ble	main_413

main_131:
    movz	w26,	#8
    ldr	x16,	[sp, #1952]

    str	w26,	[x16]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#9
    ble	main_413

main_133:
    movz	w26,	#9
    movz	fp,	#1380
    ldr	x15,	[sp, fp]

    str	w26,	[x15]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#10
    ble	main_413

main_135:
    movz	w26,	#10
    movz	fp,	#940
    ldr	x12,	[sp, fp]

    str	w26,	[x12]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#11
    ble	main_413

main_137:
    movz	w26,	#11
    ldr	x22,	[sp, #1968]

    str	w26,	[x22]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#12
    ble	main_413

main_139:
    movz	w26,	#12
    movz	fp,	#1428
    ldr	x4,	[sp, fp]

    str	w26,	[x4]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#13
    ble	main_413

main_141:
    movz	w26,	#13
    ldr	x6,	[sp, #2000]

    str	w26,	[x6]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#14
    ble	main_413

main_143:
    movz	w26,	#14
    ldr	x2,	[sp, #1992]

    str	w26,	[x2]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#15
    ble	main_413

main_145:
    movz	w26,	#15
    ldr	x19,	[sp, #1960]

    str	w26,	[x19]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#16
    ble	main_413

main_147:
    movz	w26,	#16
    ldr	x10,	[sp, #1936]

    str	w26,	[x10]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#17
    ble	main_413

main_149:
    movz	w26,	#17
    movz	fp,	#1460
    ldr	x17,	[sp, fp]

    str	w26,	[x17]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#18
    ble	main_413

main_151:
    movz	w26,	#18
    ldr	x24,	[sp, #1896]

    str	w26,	[x24]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#19
    ble	main_413

main_153:
    movz	w26,	#19
    movz	fp,	#932
    ldr	x9,	[sp, fp]

    str	w26,	[x9]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#20
    ble	main_413

main_155:
    movz	w26,	#20
    ldr	x7,	[sp, #1928]

    str	w26,	[x7]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#21
    ble	main_413

main_157:
    movz	w26,	#21
    movz	fp,	#1412
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#22
    ble	main_413

main_159:
    movz	w26,	#22
    movz	fp,	#1420
    ldr	x1,	[sp, fp]

    str	w26,	[x1]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#23
    ble	main_413

main_161:
    movz	w26,	#23
    ldr	x0,	[sp, #1912]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#24
    ble	main_413

main_163:
    movz	w26,	#24
    ldr	x13,	[sp, #1944]

    str	w26,	[x13]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#25
    ble	main_413

main_165:
    movz	w26,	#25
    movz	fp,	#1404
    ldr	x25,	[sp, fp]

    str	w26,	[x25]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w26,	#26
    ldr	x20,	[sp, #1888]

    str	w26,	[x20]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#27
    ble	main_413

main_169:
    movz	w26,	#27
    ldr	x28,	[sp, #1904]

    str	w26,	[x28]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w26,	#28
    ldr	x27,	[sp, #1976]

    str	w26,	[x27]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#29
    ble	main_413

main_173:
    movz	w26,	#29
    ldr	x0,	[sp, #640]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w26,	#30
    ldr	x0,	[sp, #648]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#31
    ble	main_413

main_177:
    movz	w26,	#31
    ldr	x0,	[sp, #456]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w26,	#32
    ldr	x0,	[sp, #472]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#33
    ble	main_413

main_181:
    movz	w26,	#33
    movz	fp,	#724
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w26,	#34
    movz	fp,	#732
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#35
    ble	main_413

main_185:
    movz	w26,	#35
    movz	fp,	#740
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w26,	#36
    movz	fp,	#748
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#37
    ble	main_413

main_189:
    movz	w26,	#37
    movz	fp,	#756
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w26,	#38
    movz	fp,	#764
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#39
    ble	main_413

main_193:
    movz	w26,	#39
    movz	fp,	#956
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w26,	#40
    movz	fp,	#964
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#41
    ble	main_413

main_197:
    movz	w26,	#41
    movz	fp,	#972
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w26,	#42
    movz	fp,	#980
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#43
    ble	main_413

main_201:
    movz	w26,	#43
    movz	fp,	#988
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w26,	#44
    movz	fp,	#996
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#45
    ble	main_413

main_205:
    movz	w26,	#45
    movz	fp,	#1004
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w26,	#46
    movz	fp,	#660
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#47
    ble	main_413

main_209:
    movz	w26,	#47
    movz	fp,	#668
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w26,	#48
    movz	fp,	#676
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#49
    ble	main_413

main_213:
    movz	w26,	#49
    movz	fp,	#684
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w26,	#50
    movz	fp,	#692
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#51
    ble	main_413

main_217:
    movz	w26,	#51
    movz	fp,	#700
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w26,	#52
    movz	fp,	#708
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#53
    ble	main_413

main_221:
    movz	w26,	#53
    movz	fp,	#1012
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w26,	#54
    movz	fp,	#716
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#55
    ble	main_413

main_225:
    movz	w26,	#55
    ldr	x0,	[sp, #416]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#56
    ble	main_413

main_227:
    movz	w26,	#56
    ldr	x0,	[sp, #424]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#57
    ble	main_413

main_229:
    movz	w26,	#57
    movz	fp,	#1020
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#58
    ble	main_413

main_231:
    movz	w26,	#58
    movz	fp,	#1028
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#59
    ble	main_413

main_233:
    movz	w26,	#59
    movz	fp,	#1036
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#60
    ble	main_413

main_235:
    movz	w26,	#60
    movz	fp,	#1044
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#61
    ble	main_413

main_237:
    movz	w26,	#61
    movz	fp,	#1052
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#62
    ble	main_413

main_239:
    movz	w26,	#62
    movz	fp,	#1060
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#63
    ble	main_413

main_241:
    movz	w26,	#63
    movz	fp,	#1068
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#64
    ble	main_413

main_243:
    movz	w26,	#64
    movz	fp,	#1076
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#65
    ble	main_413

main_245:
    movz	w26,	#65
    movz	fp,	#1084
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#66
    ble	main_413

main_247:
    movz	w26,	#66
    movz	fp,	#1092
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#67
    ble	main_413

main_249:
    movz	w26,	#67
    movz	fp,	#1100
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#68
    ble	main_413

main_251:
    movz	w26,	#68
    movz	fp,	#1108
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#69
    ble	main_413

main_253:
    movz	w26,	#69
    movz	fp,	#1116
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#70
    ble	main_413

main_255:
    movz	w26,	#70
    movz	fp,	#1124
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#71
    ble	main_413

main_257:
    movz	w26,	#71
    movz	fp,	#1132
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#72
    ble	main_413

main_259:
    movz	w26,	#72
    movz	fp,	#1140
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#73
    ble	main_413

main_261:
    movz	w26,	#73
    movz	fp,	#1148
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#74
    ble	main_413

main_263:
    movz	w26,	#74
    movz	fp,	#1156
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#75
    ble	main_413

main_265:
    movz	w26,	#75
    movz	fp,	#1164
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#76
    ble	main_413

main_267:
    movz	w26,	#76
    movz	fp,	#1172
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#77
    ble	main_413

main_269:
    movz	w26,	#77
    movz	fp,	#1180
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#78
    ble	main_413

main_271:
    movz	w26,	#78
    movz	fp,	#1188
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#79
    ble	main_413

main_273:
    movz	w26,	#79
    movz	fp,	#1196
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#80
    ble	main_413

main_275:
    movz	w26,	#80
    movz	fp,	#1204
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#81
    ble	main_413

main_277:
    movz	w26,	#81
    movz	fp,	#1212
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#82
    ble	main_413

main_279:
    movz	w26,	#82
    movz	fp,	#1220
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#83
    ble	main_413

main_281:
    movz	w26,	#83
    movz	fp,	#1228
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w26,	#84
    movz	fp,	#1236
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#85
    ble	main_413

main_285:
    movz	w26,	#85
    movz	fp,	#1244
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w26,	#86
    movz	fp,	#1252
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#87
    ble	main_413

main_289:
    movz	w26,	#87
    movz	fp,	#1260
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w26,	#88
    movz	fp,	#1268
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#89
    ble	main_413

main_293:
    movz	w26,	#89
    movz	fp,	#1276
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w26,	#90
    movz	fp,	#1284
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#91
    ble	main_413

main_297:
    movz	w26,	#91
    movz	fp,	#1292
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w26,	#92
    movz	fp,	#1300
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#93
    ble	main_413

main_301:
    movz	w26,	#93
    movz	fp,	#1308
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w26,	#94
    movz	fp,	#1316
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#95
    ble	main_413

main_305:
    movz	w26,	#95
    movz	fp,	#1324
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w26,	#96
    movz	fp,	#1332
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#97
    ble	main_413

main_309:
    movz	w26,	#97
    movz	fp,	#1340
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w0,	[sp, #1376]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w26,	#98
    movz	fp,	#1348
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w26,	[sp, #1376]

    cmp	w26,	#99
    ble	main_413

main_313:
    movz	w26,	#99
    movz	fp,	#1356
    ldr	x0,	[sp, fp]

    str	w26,	[x0]


main_413:
    ldr	w26,	[sp, #1364]

    add	w26,	w26,	#1
    str	w26,	[sp, #656]

    ldr	w26,	[sp, #1368]

    str	w26,	[sp, #948]

    movz	w26,	#0
    str	w26,	[sp, #464]


main_415:
    ldr	w0,	[sp, #464]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w26,	[sp, #464]

    lsl	w26,	w26,	#2
    mov	x26,	x26
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w7,	[x26]

    str	w7,	[sp, #3396]

    ldr	w0,	[sp, #948]

    ldr	w8,	[sp, #3396]

    add	w26,	w8,	w0
    ldr	w0,	[sp, #464]

    add	w0,	w0,	#1
    str	w0,	[sp, #952]

    str	w26,	[sp, #948]

    ldr	w26,	[sp, #952]

    str	w26,	[sp, #464]

    b	main_415

main_424:
    movz	w26,	#65535
    ldr	w0,	[sp, #948]

    sdiv	w26,	w0,	w26
    str	w26,	[sp, #468]

    ldr	w0,	[sp, #468]

    lsl	w25,	w0,	#16
    str	w25,	[sp, #3180]

    ldr	w0,	[sp, #468]

    ldr	w26,	[sp, #3180]

    sub	w26,	w26,	w0,	lsl #0
    ldr	w0,	[sp, #948]

    sub	w3,	w0,	w26
    str	w3,	[sp, #3384]

    ldr	w28,	[sp, #656]

    str	w28,	[sp, #2596]

    ldr	w5,	[sp, #1372]

    str	w5,	[sp, #2488]

    ldr	w11,	[sp, #2488]

    ldr	w0,	[sp, #2596]

    cmp	w0,	w11
    bge	main_428

main_112:
    ldr	w4,	[sp, #3384]

    mov	w0,	w4
    str	w0,	[sp, #1368]

    ldr	w26,	[sp, #656]

    mov	w0,	w26
    str	w0,	[sp, #1364]

    b	main_113

main_428:
    ldr	w0,	[sp, #3384]

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


