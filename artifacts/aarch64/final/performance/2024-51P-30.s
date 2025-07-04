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
    sub	sp, sp, #3392
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1164]

    bl	getint
    str	w0,	[sp, #1168]

    movz	w0,	#0

main_4:
    cmp	w0,	#100
    blt	main_7

main_10:
    movz	w25,	#0
    ldr	w15,	[sp, #1164]

    cmp	w25,	w15
    blt	main_12

main_427:
    movz	w0,	#0
    b	main_429

main_12:
    add	x21,	sp,	#20
    movz	fp,	#1692
    add	x9,	sp,	#24
    add	x27,	sp,	#28
    add	x8,	sp,	#32
    add	x4,	sp,	#36
    add	x24,	sp,	#40
    add	x16,	sp,	#44
    add	x25,	sp,	#48
    add	x10,	sp,	#52
    add	x17,	sp,	#56
    add	x13,	sp,	#60
    add	x28,	sp,	#64
    add	x23,	sp,	#68
    add	x11,	sp,	#72
    add	x0,	sp,	#76
    add	x2,	sp,	#80
    add	x19,	sp,	#84
    add	x22,	sp,	#88
    add	x7,	sp,	#92
    add	x20,	sp,	#96
    add	x1,	sp,	#100
    add	x3,	sp,	#104
    add	x14,	sp,	#108
    add	x5,	sp,	#112
    add	x26,	sp,	#116
    add	x18,	sp,	#120
    add	x6,	sp,	#124
    add	x15,	sp,	#128
    str	x21,	[sp, fp]

    movz	fp,	#1836
    str	x9,	[sp, fp]

    movz	fp,	#1708
    str	x27,	[sp, fp]

    movz	fp,	#1756
    str	x8,	[sp, fp]

    add	x8,	sp,	#136
    movz	fp,	#1524
    str	x4,	[sp, fp]

    movz	fp,	#1700
    str	x24,	[sp, fp]

    movz	fp,	#1556
    str	x16,	[sp, fp]

    movz	fp,	#1724
    str	x25,	[sp, fp]

    movz	fp,	#1540
    str	x10,	[sp, fp]

    movz	fp,	#1780
    str	x17,	[sp, fp]

    movz	fp,	#1548
    str	x13,	[sp, fp]

    movz	fp,	#1732
    str	x28,	[sp, fp]

    movz	fp,	#1796
    str	x23,	[sp, fp]

    movz	fp,	#1764
    str	x11,	[sp, fp]

    movz	fp,	#1812
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#1740
    str	x2,	[sp, fp]

    movz	fp,	#1564
    str	x19,	[sp, fp]

    movz	fp,	#1572
    str	x22,	[sp, fp]

    movz	fp,	#1532
    str	x7,	[sp, fp]

    movz	fp,	#1788
    str	x20,	[sp, fp]

    movz	fp,	#1716
    str	x1,	[sp, fp]

    movz	fp,	#1820
    str	x3,	[sp, fp]

    movz	fp,	#1772
    str	x14,	[sp, fp]

    movz	fp,	#1748
    str	x5,	[sp, fp]

    movz	fp,	#1804
    str	x26,	[sp, fp]

    movz	fp,	#1684
    str	x18,	[sp, fp]

    movz	fp,	#1828
    str	x6,	[sp, fp]

    movz	fp,	#1676
    str	x15,	[sp, fp]

    movz	fp,	#436
    str	x0,	[sp, #616]

    add	x0,	sp,	#140
    str	x8,	[sp, fp]

    add	x8,	sp,	#144
    movz	fp,	#588
    str	x0,	[sp, fp]

    add	x0,	sp,	#148
    movz	fp,	#756
    str	x8,	[sp, fp]

    add	x8,	sp,	#152
    movz	fp,	#764
    str	x0,	[sp, fp]

    add	x0,	sp,	#156
    movz	fp,	#772
    str	x8,	[sp, fp]

    add	x8,	sp,	#164
    movz	fp,	#780
    str	x0,	[sp, fp]

    movz	fp,	#788
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    add	x0,	sp,	#168
    movz	fp,	#796
    str	x8,	[sp, fp]

    add	x8,	sp,	#172
    movz	fp,	#628
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#636
    str	x8,	[sp, fp]

    add	x8,	sp,	#180
    movz	fp,	#644
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#652
    str	x8,	[sp, fp]

    add	x8,	sp,	#188
    movz	fp,	#660
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#676
    str	x8,	[sp, fp]

    add	x8,	sp,	#200
    movz	fp,	#684
    str	x0,	[sp, fp]

    movz	fp,	#692
    add	x0,	sp,	#196
    str	x0,	[sp, fp]

    add	x0,	sp,	#204
    movz	fp,	#700
    str	x8,	[sp, fp]

    add	x8,	sp,	#208
    movz	fp,	#708
    str	x0,	[sp, fp]

    add	x0,	sp,	#212
    movz	fp,	#716
    str	x8,	[sp, fp]

    add	x8,	sp,	#216
    movz	fp,	#724
    str	x0,	[sp, fp]

    add	x0,	sp,	#220
    movz	fp,	#732
    str	x8,	[sp, fp]

    add	x8,	sp,	#224
    movz	fp,	#740
    str	x0,	[sp, fp]

    add	x0,	sp,	#228
    movz	fp,	#748
    str	x8,	[sp, fp]

    add	x8,	sp,	#232
    movz	fp,	#804
    str	x0,	[sp, fp]

    add	x0,	sp,	#240
    movz	fp,	#668
    str	x8,	[sp, fp]

    movz	fp,	#812
    add	x8,	sp,	#236
    str	x8,	[sp, #416]

    add	x8,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x8,	[sp, fp]

    add	x8,	sp,	#252
    movz	fp,	#820
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#828
    str	x8,	[sp, fp]

    add	x8,	sp,	#260
    movz	fp,	#836
    str	x0,	[sp, fp]

    add	x0,	sp,	#264
    movz	fp,	#844
    str	x8,	[sp, fp]

    add	x8,	sp,	#268
    movz	fp,	#852
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#860
    str	x8,	[sp, fp]

    add	x8,	sp,	#280
    movz	fp,	#868
    str	x0,	[sp, fp]

    movz	fp,	#876
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    add	x0,	sp,	#284
    movz	fp,	#884
    str	x8,	[sp, fp]

    add	x8,	sp,	#288
    movz	fp,	#892
    str	x0,	[sp, fp]

    add	x0,	sp,	#292
    movz	fp,	#900
    str	x8,	[sp, fp]

    add	x8,	sp,	#296
    movz	fp,	#908
    str	x0,	[sp, fp]

    add	x0,	sp,	#300
    movz	fp,	#916
    str	x8,	[sp, fp]

    add	x8,	sp,	#304
    movz	fp,	#924
    str	x0,	[sp, fp]

    add	x0,	sp,	#308
    movz	fp,	#932
    str	x8,	[sp, fp]

    add	x8,	sp,	#316
    movz	fp,	#940
    str	x0,	[sp, fp]

    movz	fp,	#948
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    add	x0,	sp,	#320
    movz	fp,	#956
    str	x8,	[sp, fp]

    add	x8,	sp,	#324
    movz	fp,	#964
    str	x0,	[sp, fp]

    add	x0,	sp,	#328
    movz	fp,	#972
    str	x8,	[sp, fp]

    add	x8,	sp,	#332
    movz	fp,	#980
    str	x0,	[sp, fp]

    add	x0,	sp,	#336
    movz	fp,	#988
    str	x8,	[sp, fp]

    add	x8,	sp,	#340
    movz	fp,	#996
    str	x0,	[sp, fp]

    add	x0,	sp,	#344
    movz	fp,	#1004
    str	x8,	[sp, fp]

    add	x8,	sp,	#348
    movz	fp,	#1012
    str	x0,	[sp, fp]

    add	x0,	sp,	#356
    movz	fp,	#1020
    str	x8,	[sp, fp]

    movz	fp,	#1028
    add	x8,	sp,	#352
    str	x8,	[sp, fp]

    add	x8,	sp,	#360
    movz	fp,	#1036
    str	x0,	[sp, fp]

    add	x0,	sp,	#364
    movz	fp,	#1044
    str	x8,	[sp, fp]

    add	x8,	sp,	#368
    movz	fp,	#1052
    str	x0,	[sp, fp]

    add	x0,	sp,	#372
    movz	fp,	#1060
    str	x8,	[sp, fp]

    add	x8,	sp,	#376
    movz	fp,	#1068
    str	x0,	[sp, fp]

    add	x0,	sp,	#380
    movz	fp,	#1076
    str	x8,	[sp, fp]

    add	x8,	sp,	#384
    movz	fp,	#1084
    str	x0,	[sp, fp]

    add	x0,	sp,	#388
    movz	fp,	#1092
    str	x8,	[sp, fp]

    add	x8,	sp,	#396
    movz	fp,	#1100
    str	x0,	[sp, fp]

    movz	fp,	#1108
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    add	x0,	sp,	#400
    movz	fp,	#1116
    str	x8,	[sp, fp]

    add	x8,	sp,	#404
    movz	fp,	#1124
    str	x0,	[sp, fp]

    add	x0,	sp,	#408
    movz	fp,	#1132
    str	x8,	[sp, fp]

    add	x8,	sp,	#412
    movz	fp,	#1140
    str	x0,	[sp, fp]

    movz	fp,	#1148
    str	x8,	[sp, fp]

    movz	w8,	#0
    mov	w0,	w8
    movz	w8,	#0
    str	w0,	[sp, #1160]

    mov	w0,	w8
    str	w0,	[sp, #1156]


main_113:
    ldr	w0,	[sp, #1168]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w8,	#1
    movz	fp,	#1692
    mov	w0,	w8
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#2
    ble	main_413

main_119:
    movz	w0,	#2
    movz	fp,	#1836
    mov	w8,	w0
    ldr	x5,	[sp, fp]

    str	w8,	[x5]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w8,	#3
    movz	fp,	#1708
    mov	w0,	w8
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1756
    mov	w8,	w0
    ldr	x3,	[sp, fp]

    str	w8,	[x3]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w8,	#5
    movz	fp,	#1524
    ldr	x28,	[sp, fp]

    str	w8,	[x28]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#6
    ble	main_413

main_127:
    movz	w8,	#6
    movz	fp,	#1700
    ldr	x19,	[sp, fp]

    str	w8,	[x19]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w8,	#7
    movz	fp,	#1556
    mov	w0,	w8
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    movz	fp,	#1724
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    movz	fp,	#1540
    mov	w8,	w0
    ldr	x4,	[sp, fp]

    str	w8,	[x4]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#10
    ble	main_413

main_135:
    movz	w8,	#10
    movz	fp,	#1780
    mov	w0,	w8
    ldr	x14,	[sp, fp]

    str	w0,	[x14]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w0,	#11
    movz	fp,	#1548
    mov	w8,	w0
    ldr	x7,	[sp, fp]

    str	w8,	[x7]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#12
    ble	main_413

main_139:
    movz	w8,	#12
    movz	fp,	#1732
    mov	w0,	w8
    ldr	x24,	[sp, fp]

    str	w0,	[x24]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#1796
    mov	w8,	w0
    ldr	x20,	[sp, fp]

    str	w8,	[x20]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#14
    ble	main_413

main_143:
    movz	w8,	#14
    movz	fp,	#1764
    ldr	x6,	[sp, fp]

    str	w8,	[x6]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w8,	#15
    movz	fp,	#1812
    ldr	x26,	[sp, fp]

    str	w8,	[x26]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#16
    ble	main_413

main_147:
    movz	w8,	#16
    movz	fp,	#1740
    mov	w0,	w8
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    movz	fp,	#1564
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1572
    mov	w8,	w0
    ldr	x18,	[sp, fp]

    str	w8,	[x18]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w8,	#19
    movz	fp,	#1532
    mov	w0,	w8
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#20
    ble	main_413

main_155:
    movz	w0,	#20
    movz	fp,	#1788
    mov	w8,	w0
    ldr	x17,	[sp, fp]

    str	w8,	[x17]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w8,	#21
    movz	fp,	#1716
    mov	w0,	w8
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1820
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w8,	#23
    movz	fp,	#1772
    ldr	x11,	[sp, fp]

    str	w8,	[x11]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#24
    ble	main_413

main_163:
    movz	w8,	#24
    movz	fp,	#1748
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w8,	#25
    movz	fp,	#1804
    mov	w0,	w8
    ldr	x23,	[sp, fp]

    str	w0,	[x23]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    movz	fp,	#1684
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1828
    mov	w8,	w0
    ldr	x2,	[sp, fp]

    str	w8,	[x2]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w8,	#28
    movz	fp,	#1676
    mov	w0,	w8
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#29
    ble	main_413

main_173:
    movz	w0,	#29
    ldr	x8,	[sp, #616]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w8,	#30
    movz	fp,	#436
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    movz	fp,	#588
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w8,	#32
    movz	fp,	#756
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#33
    ble	main_413

main_181:
    movz	w8,	#33
    movz	fp,	#764
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w8,	#34
    movz	fp,	#772
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    movz	fp,	#780
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    movz	fp,	#788
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#37
    ble	main_413

main_189:
    movz	w8,	#37
    movz	fp,	#796
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w0,	#38
    movz	fp,	#628
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#39
    ble	main_413

main_193:
    movz	w8,	#39
    movz	fp,	#636
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#644
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#41
    ble	main_413

main_197:
    movz	w8,	#41
    movz	fp,	#652
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w8,	#42
    movz	fp,	#660
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#43
    ble	main_413

main_201:
    movz	w8,	#43
    movz	fp,	#676
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    movz	fp,	#684
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    movz	fp,	#692
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w8,	#46
    movz	fp,	#700
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#47
    ble	main_413

main_209:
    movz	w0,	#47
    movz	fp,	#708
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w8,	#48
    movz	fp,	#716
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    movz	fp,	#724
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w8,	#50
    movz	fp,	#732
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#51
    ble	main_413

main_217:
    movz	w8,	#51
    movz	fp,	#740
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w8,	#52
    movz	fp,	#748
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    movz	fp,	#804
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    movz	fp,	#668
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w8,	#55
    mov	w0,	w8
    ldr	x8,	[sp, #416]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#56
    ble	main_413

main_227:
    movz	w0,	#56
    mov	w8,	w0
    ldr	x0,	[sp, #424]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w8,	#57
    movz	fp,	#812
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#820
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w8,	#59
    movz	fp,	#828
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#60
    ble	main_413

main_235:
    movz	w8,	#60
    movz	fp,	#836
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w8,	#61
    movz	fp,	#844
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    movz	fp,	#852
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#860
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#64
    ble	main_413

main_243:
    movz	w8,	#64
    movz	fp,	#868
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w0,	#65
    movz	fp,	#876
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#66
    ble	main_413

main_247:
    movz	w8,	#66
    movz	fp,	#884
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#892
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#68
    ble	main_413

main_251:
    movz	w8,	#68
    movz	fp,	#900
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w8,	#69
    movz	fp,	#908
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#70
    ble	main_413

main_255:
    movz	w8,	#70
    movz	fp,	#916
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    movz	fp,	#924
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#932
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w8,	#73
    movz	fp,	#940
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#74
    ble	main_413

main_263:
    movz	w0,	#74
    movz	fp,	#948
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w8,	#75
    movz	fp,	#956
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#964
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w8,	#77
    movz	fp,	#972
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#78
    ble	main_413

main_271:
    movz	w8,	#78
    movz	fp,	#980
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w8,	#79
    movz	fp,	#988
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    movz	fp,	#996
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#1004
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#82
    ble	main_413

main_279:
    movz	w8,	#82
    movz	fp,	#1012
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w0,	#83
    movz	fp,	#1020
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w8,	#84
    movz	fp,	#1028
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#1036
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w8,	#86
    movz	fp,	#1044
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#87
    ble	main_413

main_289:
    movz	w8,	#87
    movz	fp,	#1052
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w8,	#88
    movz	fp,	#1060
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    movz	fp,	#1068
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#1076
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#91
    ble	main_413

main_297:
    movz	w8,	#91
    movz	fp,	#1084
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w0,	#92
    movz	fp,	#1092
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#93
    ble	main_413

main_301:
    movz	w8,	#93
    movz	fp,	#1100
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1108
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#95
    ble	main_413

main_305:
    movz	w8,	#95
    movz	fp,	#1116
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w8,	#96
    movz	fp,	#1124
    ldr	x0,	[sp, fp]

    str	w8,	[x0]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#97
    ble	main_413

main_309:
    movz	w8,	#97
    movz	fp,	#1132
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1168]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    movz	fp,	#1140
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w8,	[sp, #1168]

    cmp	w8,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#1148
    mov	w8,	w0
    ldr	x0,	[sp, fp]

    str	w8,	[x0]


main_413:
    ldr	w8,	[sp, #1156]

    add	w0,	w8,	#1
    movz	w8,	#0
    str	w0,	[sp, #624]

    ldr	w0,	[sp, #1160]

    str	w0,	[sp, #612]

    str	w8,	[sp, #608]


main_415:
    ldr	w0,	[sp, #608]

    cmp	w0,	#100
    blt	main_419

main_424:
    movz	w0,	#65535
    mov	w8,	w0
    ldr	w0,	[sp, #612]

    sdiv	w8,	w0,	w8
    str	w8,	[sp, #432]

    ldr	w0,	[sp, #432]

    lsl	w8,	w0,	#16
    ldr	w0,	[sp, #432]

    sub	w0,	w8,	w0,	lsl #0
    ldr	w8,	[sp, #612]

    ldr	w26,	[sp, #624]

    sub	w8,	w8,	w0
    str	w26,	[sp, #2884]

    ldr	w5,	[sp, #1164]

    str	w5,	[sp, #1860]

    ldr	w6,	[sp, #1860]

    ldr	w27,	[sp, #2884]

    cmp	w27,	w6
    blt	main_112

main_428:
    mov	w0,	w8

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


main_112:
    mov	w0,	w8
    str	w0,	[sp, #1160]

    ldr	w0,	[sp, #624]

    str	w0,	[sp, #1156]

    b	main_113

main_419:
    ldr	w8,	[sp, #608]

    lsl	w0,	w8,	#2
    mov	x8,	x0
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w0,	[x8]

    ldr	w8,	[sp, #612]

    add	w0,	w0,	w8
    ldr	w8,	[sp, #608]

    add	w8,	w8,	#1
    str	w8,	[sp, #596]

    str	w0,	[sp, #612]

    ldr	w8,	[sp, #596]

    str	w8,	[sp, #608]

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

