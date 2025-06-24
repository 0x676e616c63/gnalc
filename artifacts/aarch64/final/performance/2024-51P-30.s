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
    str	w0,	[sp, #1204]

    bl	getint
    str	w0,	[sp, #1208]

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
    ldr	w15,	[sp, #1204]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x11,	sp,	#20
    movz	fp,	#1892
    add	x6,	sp,	#24
    add	x26,	sp,	#28
    add	x9,	sp,	#32
    add	x13,	sp,	#36
    add	x16,	sp,	#40
    add	x21,	sp,	#44
    add	x17,	sp,	#48
    add	x18,	sp,	#52
    add	x1,	sp,	#56
    add	x20,	sp,	#60
    add	x15,	sp,	#64
    add	x8,	sp,	#68
    add	x0,	sp,	#72
    add	x14,	sp,	#76
    add	x5,	sp,	#80
    add	x4,	sp,	#84
    add	x10,	sp,	#88
    add	x25,	sp,	#92
    add	x27,	sp,	#96
    add	x19,	sp,	#100
    add	x22,	sp,	#104
    add	x2,	sp,	#108
    add	x3,	sp,	#112
    add	x23,	sp,	#116
    add	x7,	sp,	#120
    add	x28,	sp,	#124
    add	x24,	sp,	#128
    str	x11,	[sp, fp]

    movz	fp,	#1956
    str	x6,	[sp, fp]

    movz	fp,	#1932
    str	x26,	[sp, fp]

    movz	fp,	#1964
    str	x9,	[sp, fp]

    movz	fp,	#1356
    str	x13,	[sp, fp]

    movz	fp,	#1364
    str	x16,	[sp, fp]

    add	x16,	sp,	#136
    movz	fp,	#444
    str	x21,	[sp, fp]

    movz	fp,	#1908
    str	x17,	[sp, fp]

    movz	fp,	#1564
    str	x18,	[sp, fp]

    movz	fp,	#1324
    str	x1,	[sp, fp]

    movz	fp,	#1916
    str	x20,	[sp, fp]

    movz	fp,	#1556
    str	x15,	[sp, fp]

    movz	fp,	#1884
    str	x8,	[sp, fp]

    movz	fp,	#1940
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#1900
    str	x14,	[sp, fp]

    movz	fp,	#1876
    str	x5,	[sp, fp]

    movz	fp,	#1332
    str	x4,	[sp, fp]

    movz	fp,	#1348
    str	x10,	[sp, fp]

    movz	fp,	#1844
    str	x25,	[sp, fp]

    movz	fp,	#460
    str	x27,	[sp, fp]

    movz	fp,	#1828
    str	x19,	[sp, fp]

    movz	fp,	#1836
    str	x22,	[sp, fp]

    movz	fp,	#1868
    str	x2,	[sp, fp]

    movz	fp,	#1948
    str	x3,	[sp, fp]

    movz	fp,	#1924
    str	x23,	[sp, fp]

    movz	fp,	#1340
    str	x7,	[sp, fp]

    movz	fp,	#1860
    str	x28,	[sp, fp]

    movz	fp,	#452
    str	x24,	[sp, fp]

    movz	fp,	#828
    str	x0,	[sp, #656]

    add	x0,	sp,	#140
    str	x16,	[sp, #632]

    add	x16,	sp,	#144
    str	x0,	[sp, fp]

    add	x0,	sp,	#148
    movz	fp,	#836
    str	x16,	[sp, fp]

    add	x16,	sp,	#152
    movz	fp,	#844
    str	x0,	[sp, fp]

    movz	fp,	#852
    add	x0,	sp,	#156
    str	x16,	[sp, #720]

    add	x16,	sp,	#164
    str	x0,	[sp, #728]

    add	x0,	sp,	#160
    str	x0,	[sp, #744]

    add	x0,	sp,	#168
    str	x16,	[sp, #752]

    add	x16,	sp,	#172
    str	x0,	[sp, #760]

    add	x0,	sp,	#176
    str	x16,	[sp, #768]

    add	x16,	sp,	#180
    str	x0,	[sp, #776]

    add	x0,	sp,	#184
    str	x16,	[sp, #784]

    add	x16,	sp,	#188
    str	x0,	[sp, #792]

    add	x0,	sp,	#192
    str	x16,	[sp, #800]

    add	x16,	sp,	#200
    str	x0,	[sp, #808]

    add	x0,	sp,	#196
    str	x0,	[sp, #816]

    add	x0,	sp,	#204
    str	x16,	[sp, #664]

    add	x16,	sp,	#208
    str	x0,	[sp, #672]

    add	x0,	sp,	#212
    str	x16,	[sp, #680]

    add	x16,	sp,	#216
    str	x0,	[sp, #688]

    add	x0,	sp,	#220
    str	x16,	[sp, #696]

    add	x16,	sp,	#224
    str	x0,	[sp, #704]

    add	x0,	sp,	#228
    str	x16,	[sp, #712]

    add	x16,	sp,	#232
    str	x0,	[sp, fp]

    movz	fp,	#860
    add	x0,	sp,	#240
    str	x16,	[sp, #736]

    add	x16,	sp,	#236
    str	x16,	[sp, #416]

    add	x16,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x16,	[sp, #432]

    add	x16,	sp,	#252
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#868
    str	x16,	[sp, fp]

    add	x16,	sp,	#260
    movz	fp,	#876
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#884
    str	x16,	[sp, fp]

    add	x16,	sp,	#268
    movz	fp,	#892
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#900
    str	x16,	[sp, fp]

    add	x16,	sp,	#280
    movz	fp,	#908
    str	x0,	[sp, fp]

    movz	fp,	#916
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#924
    str	x16,	[sp, fp]

    add	x16,	sp,	#288
    movz	fp,	#932
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#940
    str	x16,	[sp, fp]

    add	x16,	sp,	#296
    movz	fp,	#948
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#956
    str	x16,	[sp, fp]

    add	x16,	sp,	#304
    movz	fp,	#964
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#972
    str	x16,	[sp, fp]

    add	x16,	sp,	#316
    movz	fp,	#980
    str	x0,	[sp, fp]

    movz	fp,	#988
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#996
    str	x16,	[sp, fp]

    add	x16,	sp,	#324
    movz	fp,	#1004
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#1012
    str	x16,	[sp, fp]

    add	x16,	sp,	#332
    movz	fp,	#1020
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#1028
    str	x16,	[sp, fp]

    add	x16,	sp,	#340
    movz	fp,	#1036
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1044
    str	x16,	[sp, fp]

    add	x16,	sp,	#348
    movz	fp,	#1052
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#1060
    str	x16,	[sp, fp]

    movz	fp,	#1068
    add	x16,	sp,	#352
    str	x16,	[sp, fp]

    add	x16,	sp,	#360
    movz	fp,	#1076
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#1084
    str	x16,	[sp, fp]

    add	x16,	sp,	#368
    movz	fp,	#1092
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#1100
    str	x16,	[sp, fp]

    add	x16,	sp,	#376
    movz	fp,	#1108
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#1116
    str	x16,	[sp, fp]

    add	x16,	sp,	#384
    movz	fp,	#1124
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#1132
    str	x16,	[sp, fp]

    add	x16,	sp,	#396
    movz	fp,	#1140
    str	x0,	[sp, fp]

    movz	fp,	#1148
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1156
    str	x16,	[sp, fp]

    add	x16,	sp,	#404
    movz	fp,	#1164
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1172
    str	x16,	[sp, fp]

    add	x16,	sp,	#412
    movz	fp,	#1180
    str	x0,	[sp, fp]

    movz	fp,	#1188
    str	x16,	[sp, fp]

    movz	w16,	#0
    mov	w0,	w16
    movz	w16,	#0
    str	w0,	[sp, #1200]

    mov	w0,	w16
    str	w0,	[sp, #1196]


main_113:
    ldr	w0,	[sp, #1208]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w16,	#1
    movz	fp,	#1892
    mov	w0,	w16
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#2
    ble	main_413

main_119:
    movz	w16,	#2
    movz	fp,	#1956
    ldr	x2,	[sp, fp]

    str	w16,	[x2]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w16,	#3
    movz	fp,	#1932
    mov	w0,	w16
    ldr	x23,	[sp, fp]

    str	w0,	[x23]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1964
    ldr	x7,	[sp, fp]

    str	w0,	[x7]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w16,	#5
    movz	fp,	#1356
    ldr	x7,	[sp, fp]

    str	w16,	[x7]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    movz	fp,	#1364
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    movz	fp,	#444
    mov	w16,	w0
    ldr	x14,	[sp, fp]

    str	w16,	[x14]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#8
    ble	main_413

main_131:
    movz	w16,	#8
    movz	fp,	#1908
    ldr	x12,	[sp, fp]

    str	w16,	[x12]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    movz	fp,	#1564
    mov	w16,	w0
    ldr	x11,	[sp, fp]

    str	w16,	[x11]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#10
    ble	main_413

main_135:
    movz	w16,	#10
    movz	fp,	#1324
    mov	w0,	w16
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w16,	#11
    movz	fp,	#1916
    ldr	x15,	[sp, fp]

    str	w16,	[x15]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#12
    ble	main_413

main_139:
    movz	w16,	#12
    movz	fp,	#1556
    mov	w0,	w16
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1884
    ldr	x5,	[sp, fp]

    str	w0,	[x5]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#14
    ble	main_413

main_143:
    movz	w16,	#14
    movz	fp,	#1940
    ldr	x26,	[sp, fp]

    str	w16,	[x26]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    movz	fp,	#1900
    ldr	x11,	[sp, fp]

    str	w0,	[x11]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    movz	fp,	#1876
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w16,	#17
    movz	fp,	#1332
    ldr	x28,	[sp, fp]

    str	w16,	[x28]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1348
    mov	w16,	w0
    ldr	x4,	[sp, fp]

    str	w16,	[x4]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w16,	#19
    movz	fp,	#1844
    mov	w0,	w16
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#20
    ble	main_413

main_155:
    movz	w16,	#20
    movz	fp,	#460
    ldr	x22,	[sp, fp]

    str	w16,	[x22]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w16,	#21
    movz	fp,	#1828
    mov	w0,	w16
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1836
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w16,	#23
    movz	fp,	#1868
    ldr	x27,	[sp, fp]

    str	w16,	[x27]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1948
    ldr	x1,	[sp, fp]

    str	w0,	[x1]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    movz	fp,	#1924
    mov	w16,	w0
    ldr	x19,	[sp, fp]

    str	w16,	[x19]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w16,	#26
    movz	fp,	#1340
    ldr	x1,	[sp, fp]

    str	w16,	[x1]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1860
    mov	w16,	w0
    ldr	x24,	[sp, fp]

    str	w16,	[x24]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w16,	#28
    movz	fp,	#452
    mov	w0,	w16
    ldr	x19,	[sp, fp]

    str	w0,	[x19]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#29
    ble	main_413

main_173:
    movz	w16,	#29
    ldr	x0,	[sp, #656]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w16,	#30
    mov	w0,	w16
    ldr	x16,	[sp, #632]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    movz	fp,	#828
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w16,	#32
    movz	fp,	#836
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    movz	fp,	#844
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    mov	w16,	w0
    ldr	x0,	[sp, #720]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#35
    ble	main_413

main_185:
    movz	w16,	#35
    ldr	x0,	[sp, #728]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    mov	w16,	w0
    ldr	x0,	[sp, #744]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#37
    ble	main_413

main_189:
    movz	w16,	#37
    mov	w0,	w16
    ldr	x16,	[sp, #752]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w16,	#38
    ldr	x0,	[sp, #760]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#39
    ble	main_413

main_193:
    movz	w16,	#39
    mov	w0,	w16
    ldr	x16,	[sp, #768]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    mov	w16,	w0
    ldr	x0,	[sp, #776]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#41
    ble	main_413

main_197:
    movz	w16,	#41
    ldr	x0,	[sp, #784]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    ldr	x16,	[sp, #792]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    mov	w16,	w0
    ldr	x0,	[sp, #800]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w16,	#44
    ldr	x0,	[sp, #808]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    mov	w16,	w0
    ldr	x0,	[sp, #816]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w16,	#46
    ldr	x0,	[sp, #664]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#47
    ble	main_413

main_209:
    movz	w16,	#47
    mov	w0,	w16
    ldr	x16,	[sp, #672]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w16,	#48
    mov	w0,	w16
    ldr	x16,	[sp, #680]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    ldr	x16,	[sp, #688]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w16,	#50
    mov	w0,	w16
    ldr	x16,	[sp, #696]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    mov	w16,	w0
    ldr	x0,	[sp, #704]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    mov	w16,	w0
    ldr	x0,	[sp, #712]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#53
    ble	main_413

main_221:
    movz	w16,	#53
    movz	fp,	#852
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    mov	w16,	w0
    ldr	x0,	[sp, #736]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w16,	#55
    mov	w0,	w16
    ldr	x16,	[sp, #416]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#56
    ble	main_413

main_227:
    movz	w16,	#56
    ldr	x0,	[sp, #424]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w16,	#57
    mov	w0,	w16
    ldr	x16,	[sp, #432]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#860
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w16,	#59
    movz	fp,	#868
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#876
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    movz	fp,	#884
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#62
    ble	main_413

main_239:
    movz	w16,	#62
    movz	fp,	#892
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#900
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#64
    ble	main_413

main_243:
    movz	w16,	#64
    movz	fp,	#908
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w16,	#65
    movz	fp,	#916
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#66
    ble	main_413

main_247:
    movz	w16,	#66
    movz	fp,	#924
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#932
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#68
    ble	main_413

main_251:
    movz	w16,	#68
    movz	fp,	#940
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#948
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    movz	fp,	#956
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w16,	#71
    movz	fp,	#964
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#972
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w16,	#73
    movz	fp,	#980
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#74
    ble	main_413

main_263:
    movz	w16,	#74
    movz	fp,	#988
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w16,	#75
    movz	fp,	#996
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#1004
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w16,	#77
    movz	fp,	#1012
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#1020
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    movz	fp,	#1028
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#80
    ble	main_413

main_275:
    movz	w16,	#80
    movz	fp,	#1036
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#1044
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#82
    ble	main_413

main_279:
    movz	w16,	#82
    movz	fp,	#1052
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w16,	#83
    movz	fp,	#1060
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w16,	#84
    movz	fp,	#1068
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1076
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w16,	#86
    movz	fp,	#1084
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#1092
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    movz	fp,	#1100
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#89
    ble	main_413

main_293:
    movz	w16,	#89
    movz	fp,	#1108
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#1116
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#91
    ble	main_413

main_297:
    movz	w16,	#91
    movz	fp,	#1124
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w16,	#92
    movz	fp,	#1132
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#93
    ble	main_413

main_301:
    movz	w16,	#93
    movz	fp,	#1140
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1148
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#95
    ble	main_413

main_305:
    movz	w16,	#95
    movz	fp,	#1156
    ldr	x0,	[sp, fp]

    str	w16,	[x0]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#1164
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    movz	fp,	#1172
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1208]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w16,	#98
    movz	fp,	#1180
    mov	w0,	w16
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w16,	[sp, #1208]

    cmp	w16,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#1188
    mov	w16,	w0
    ldr	x0,	[sp, fp]

    str	w16,	[x0]


main_413:
    ldr	w16,	[sp, #1196]

    add	w0,	w16,	#1
    str	w0,	[sp, #468]

    ldr	w0,	[sp, #1200]

    str	w0,	[sp, #824]

    movz	w0,	#0
    mov	w16,	w0
    str	w16,	[sp, #640]


main_415:
    ldr	w0,	[sp, #640]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w16,	[sp, #640]

    lsl	w0,	w16,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w16,	[sp, #824]

    add	w0,	w0,	w16
    ldr	w16,	[sp, #640]

    add	w16,	w16,	#1
    str	w16,	[sp, #440]

    str	w0,	[sp, #824]

    ldr	w16,	[sp, #440]

    str	w16,	[sp, #640]

    b	main_415

main_424:
    movz	w16,	#65535
    ldr	w0,	[sp, #824]

    sdiv	w16,	w0,	w16
    str	w16,	[sp, #644]

    ldr	w0,	[sp, #644]

    lsl	w25,	w0,	#16
    str	w25,	[sp, #3268]

    ldr	w0,	[sp, #644]

    ldr	w26,	[sp, #3268]

    sub	w16,	w26,	w0,	lsl #0
    ldr	w0,	[sp, #824]

    ldr	w28,	[sp, #468]

    sub	w16,	w0,	w16
    str	w28,	[sp, #3088]

    ldr	w5,	[sp, #1204]

    str	w5,	[sp, #2420]

    ldr	w7,	[sp, #2420]

    ldr	w0,	[sp, #3088]

    cmp	w0,	w7
    bge	main_428

main_112:
    mov	w0,	w16
    str	w0,	[sp, #1200]

    ldr	w0,	[sp, #468]

    str	w0,	[sp, #1196]

    b	main_113

main_428:
    mov	w0,	w16
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
    
    add	sp, sp, #3392
    ret


