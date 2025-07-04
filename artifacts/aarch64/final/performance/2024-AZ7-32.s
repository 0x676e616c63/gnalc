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
    str	w0,	[sp, #1036]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1040]

    mov	w0,	w26

main_4:
    cmp	w0,	#100
    blt	main_7

main_10:
    movz	w25,	#0
    ldr	w15,	[sp, #1036]

    mov	w26,	w25
    cmp	w26,	w15
    blt	main_12

main_427:
    movz	w0,	#0
    b	main_429

main_12:
    add	x5,	sp,	#20
    movz	fp,	#1612
    add	x23,	sp,	#24
    add	x14,	sp,	#28
    add	x19,	sp,	#32
    add	x21,	sp,	#36
    add	x17,	sp,	#40
    add	x16,	sp,	#44
    add	x28,	sp,	#48
    add	x18,	sp,	#52
    add	x24,	sp,	#56
    add	x27,	sp,	#60
    add	x10,	sp,	#64
    add	x8,	sp,	#68
    add	x15,	sp,	#72
    add	x3,	sp,	#76
    add	x13,	sp,	#80
    add	x1,	sp,	#84
    add	x20,	sp,	#88
    add	x4,	sp,	#92
    add	x25,	sp,	#96
    add	x0,	sp,	#100
    add	x11,	sp,	#104
    add	x6,	sp,	#108
    add	x26,	sp,	#112
    add	x2,	sp,	#116
    add	x22,	sp,	#120
    add	x7,	sp,	#124
    add	x9,	sp,	#128
    str	x5,	[sp, fp]

    movz	fp,	#1660
    str	x23,	[sp, fp]

    movz	fp,	#1636
    str	x14,	[sp, fp]

    movz	fp,	#1572
    str	x19,	[sp, fp]

    movz	fp,	#1092
    str	x21,	[sp, fp]

    movz	fp,	#1644
    str	x17,	[sp, fp]

    movz	fp,	#1156
    str	x16,	[sp, fp]

    movz	fp,	#1596
    str	x28,	[sp, fp]

    movz	fp,	#1084
    str	x18,	[sp, fp]

    movz	fp,	#1100
    str	x24,	[sp, fp]

    movz	fp,	#1108
    str	x27,	[sp, fp]

    movz	fp,	#1140
    str	x10,	[sp, fp]

    movz	fp,	#1620
    str	x8,	[sp, fp]

    movz	fp,	#1076
    str	x15,	[sp, fp]

    movz	fp,	#1684
    str	x3,	[sp, fp]

    movz	fp,	#1148
    str	x13,	[sp, fp]

    movz	fp,	#1116
    str	x1,	[sp, fp]

    movz	fp,	#1652
    str	x20,	[sp, fp]

    movz	fp,	#1124
    str	x4,	[sp, fp]

    movz	fp,	#1588
    str	x25,	[sp, fp]

    add	x25,	sp,	#132
    movz	fp,	#1676
    str	x0,	[sp, fp]

    movz	fp,	#1628
    str	x11,	[sp, fp]

    movz	fp,	#1692
    str	x6,	[sp, fp]

    movz	fp,	#1668
    str	x26,	[sp, fp]

    movz	fp,	#1604
    str	x2,	[sp, fp]

    movz	fp,	#1580
    str	x22,	[sp, fp]

    movz	fp,	#1132
    str	x7,	[sp, fp]

    movz	fp,	#1164
    str	x9,	[sp, fp]

    movz	fp,	#452
    str	x25,	[sp, fp]

    movz	fp,	#476
    add	x25,	sp,	#136
    str	x25,	[sp, fp]

    movz	fp,	#444
    add	x25,	sp,	#140
    str	x25,	[sp, fp]

    movz	fp,	#564
    add	x25,	sp,	#144
    str	x25,	[sp, fp]

    movz	fp,	#572
    add	x25,	sp,	#148
    str	x25,	[sp, fp]

    movz	fp,	#580
    add	x25,	sp,	#152
    str	x25,	[sp, fp]

    movz	fp,	#588
    add	x25,	sp,	#156
    str	x25,	[sp, #656]

    add	x25,	sp,	#160
    str	x25,	[sp, #664]

    add	x25,	sp,	#164
    str	x25,	[sp, fp]

    movz	fp,	#596
    add	x25,	sp,	#168
    str	x25,	[sp, fp]

    movz	fp,	#604
    add	x25,	sp,	#172
    str	x25,	[sp, fp]

    movz	fp,	#612
    add	x25,	sp,	#176
    str	x25,	[sp, fp]

    movz	fp,	#620
    add	x25,	sp,	#180
    str	x25,	[sp, fp]

    movz	fp,	#628
    add	x25,	sp,	#184
    str	x25,	[sp, fp]

    movz	fp,	#636
    add	x25,	sp,	#188
    str	x25,	[sp, fp]

    movz	fp,	#484
    add	x25,	sp,	#192
    str	x25,	[sp, fp]

    movz	fp,	#492
    add	x25,	sp,	#196
    str	x25,	[sp, fp]

    movz	fp,	#500
    add	x25,	sp,	#200
    str	x25,	[sp, fp]

    movz	fp,	#508
    add	x25,	sp,	#204
    str	x25,	[sp, fp]

    movz	fp,	#516
    add	x25,	sp,	#208
    str	x25,	[sp, fp]

    movz	fp,	#532
    add	x25,	sp,	#212
    str	x25,	[sp, fp]

    movz	fp,	#540
    add	x25,	sp,	#216
    str	x25,	[sp, fp]

    movz	fp,	#548
    add	x25,	sp,	#220
    str	x25,	[sp, fp]

    movz	fp,	#556
    add	x25,	sp,	#224
    str	x25,	[sp, fp]

    movz	fp,	#676
    add	x25,	sp,	#228
    str	x25,	[sp, fp]

    movz	fp,	#524
    add	x25,	sp,	#232
    str	x25,	[sp, fp]

    movz	fp,	#684
    add	x25,	sp,	#236
    str	x25,	[sp, #416]

    add	x25,	sp,	#240
    str	x25,	[sp, #424]

    add	x25,	sp,	#244
    str	x25,	[sp, fp]

    movz	fp,	#692
    add	x25,	sp,	#248
    str	x25,	[sp, fp]

    movz	fp,	#700
    add	x25,	sp,	#252
    str	x25,	[sp, fp]

    movz	fp,	#708
    add	x25,	sp,	#256
    str	x25,	[sp, fp]

    movz	fp,	#716
    add	x25,	sp,	#260
    str	x25,	[sp, fp]

    movz	fp,	#724
    add	x25,	sp,	#264
    str	x25,	[sp, fp]

    movz	fp,	#732
    add	x25,	sp,	#268
    str	x25,	[sp, fp]

    movz	fp,	#740
    add	x25,	sp,	#272
    str	x25,	[sp, fp]

    movz	fp,	#748
    add	x25,	sp,	#276
    str	x25,	[sp, fp]

    movz	fp,	#756
    add	x25,	sp,	#280
    str	x25,	[sp, fp]

    movz	fp,	#764
    add	x25,	sp,	#284
    str	x25,	[sp, fp]

    movz	fp,	#772
    add	x25,	sp,	#288
    str	x25,	[sp, fp]

    movz	fp,	#780
    add	x25,	sp,	#292
    str	x25,	[sp, fp]

    movz	fp,	#788
    add	x25,	sp,	#296
    str	x25,	[sp, fp]

    movz	fp,	#796
    add	x25,	sp,	#300
    str	x25,	[sp, fp]

    movz	fp,	#804
    add	x25,	sp,	#304
    str	x25,	[sp, fp]

    movz	fp,	#812
    add	x25,	sp,	#308
    str	x25,	[sp, fp]

    movz	fp,	#820
    add	x25,	sp,	#312
    str	x25,	[sp, fp]

    movz	fp,	#828
    add	x25,	sp,	#316
    str	x25,	[sp, fp]

    movz	fp,	#836
    add	x25,	sp,	#320
    str	x25,	[sp, fp]

    movz	fp,	#844
    add	x25,	sp,	#324
    str	x25,	[sp, fp]

    movz	fp,	#852
    add	x25,	sp,	#328
    str	x25,	[sp, fp]

    movz	fp,	#860
    add	x25,	sp,	#332
    str	x25,	[sp, fp]

    movz	fp,	#868
    add	x25,	sp,	#336
    str	x25,	[sp, fp]

    movz	fp,	#876
    add	x25,	sp,	#340
    str	x25,	[sp, fp]

    movz	fp,	#884
    add	x25,	sp,	#344
    str	x25,	[sp, fp]

    movz	fp,	#892
    add	x25,	sp,	#348
    str	x25,	[sp, fp]

    movz	fp,	#900
    add	x25,	sp,	#352
    str	x25,	[sp, fp]

    movz	fp,	#908
    add	x25,	sp,	#356
    str	x25,	[sp, fp]

    movz	fp,	#916
    add	x25,	sp,	#360
    str	x25,	[sp, fp]

    movz	fp,	#924
    add	x25,	sp,	#364
    str	x25,	[sp, fp]

    movz	fp,	#932
    add	x25,	sp,	#368
    str	x25,	[sp, fp]

    movz	fp,	#940
    add	x25,	sp,	#372
    str	x25,	[sp, fp]

    movz	fp,	#948
    add	x25,	sp,	#376
    str	x25,	[sp, fp]

    movz	fp,	#956
    add	x25,	sp,	#380
    str	x25,	[sp, fp]

    movz	fp,	#964
    add	x25,	sp,	#384
    str	x25,	[sp, fp]

    movz	fp,	#972
    add	x25,	sp,	#388
    str	x25,	[sp, fp]

    movz	fp,	#980
    add	x25,	sp,	#392
    str	x25,	[sp, fp]

    movz	fp,	#988
    add	x25,	sp,	#396
    str	x25,	[sp, fp]

    movz	fp,	#996
    add	x25,	sp,	#400
    str	x25,	[sp, fp]

    movz	fp,	#1004
    add	x25,	sp,	#404
    str	x25,	[sp, fp]

    movz	fp,	#1012
    add	x25,	sp,	#408
    str	x25,	[sp, fp]

    movz	fp,	#1020
    add	x25,	sp,	#412
    str	x25,	[sp, fp]

    movz	w25,	#0
    str	w25,	[sp, #1032]

    movz	w25,	#0
    str	w25,	[sp, #1028]


main_113:
    ldr	w25,	[sp, #1040]

    cmp	w25,	#1
    ble	main_413

main_117:
    movz	w25,	#1
    movz	fp,	#1612
    ldr	x0,	[sp, fp]

    str	w25,	[x0]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#2
    ble	main_413

main_119:
    movz	w25,	#2
    movz	fp,	#1660
    ldr	x18,	[sp, fp]

    str	w25,	[x18]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#3
    ble	main_413

main_121:
    movz	w25,	#3
    movz	fp,	#1636
    ldr	x9,	[sp, fp]

    str	w25,	[x9]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#4
    ble	main_413

main_123:
    movz	w25,	#4
    movz	fp,	#1572
    ldr	x13,	[sp, fp]

    str	w25,	[x13]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#5
    ble	main_413

main_125:
    movz	w25,	#5
    movz	fp,	#1092
    ldr	x14,	[sp, fp]

    str	w25,	[x14]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#6
    ble	main_413

main_127:
    movz	w25,	#6
    movz	fp,	#1644
    ldr	x12,	[sp, fp]

    str	w25,	[x12]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#7
    ble	main_413

main_129:
    movz	w25,	#7
    movz	fp,	#1156
    ldr	x10,	[sp, fp]

    str	w25,	[x10]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#8
    ble	main_413

main_131:
    movz	w25,	#8
    movz	fp,	#1596
    ldr	x22,	[sp, fp]

    str	w25,	[x22]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#9
    ble	main_413

main_133:
    movz	w25,	#9
    movz	fp,	#1084
    ldr	x11,	[sp, fp]

    str	w25,	[x11]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#10
    ble	main_413

main_135:
    movz	w25,	#10
    movz	fp,	#1100
    ldr	x17,	[sp, fp]

    str	w25,	[x17]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#11
    ble	main_413

main_137:
    movz	w25,	#11
    movz	fp,	#1108
    ldr	x20,	[sp, fp]

    str	w25,	[x20]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#12
    ble	main_413

main_139:
    movz	w25,	#12
    movz	fp,	#1140
    ldr	x4,	[sp, fp]

    str	w25,	[x4]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#13
    ble	main_413

main_141:
    movz	w25,	#13
    movz	fp,	#1620
    ldr	x3,	[sp, fp]

    str	w25,	[x3]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#14
    ble	main_413

main_143:
    movz	w25,	#14
    movz	fp,	#1076
    ldr	x8,	[sp, fp]

    str	w25,	[x8]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#15
    ble	main_413

main_145:
    movz	w25,	#15
    movz	fp,	#1684
    ldr	x0,	[sp, fp]

    str	w25,	[x0]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#16
    ble	main_413

main_147:
    movz	w25,	#16
    movz	fp,	#1148
    ldr	x7,	[sp, fp]

    str	w25,	[x7]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#17
    ble	main_413

main_149:
    movz	w25,	#17
    movz	fp,	#1116
    ldr	x23,	[sp, fp]

    str	w25,	[x23]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#18
    ble	main_413

main_151:
    movz	w25,	#18
    movz	fp,	#1652
    ldr	x15,	[sp, fp]

    str	w25,	[x15]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#19
    ble	main_413

main_153:
    movz	w25,	#19
    movz	fp,	#1124
    ldr	x28,	[sp, fp]

    str	w25,	[x28]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#20
    ble	main_413

main_155:
    movz	w25,	#20
    movz	fp,	#1588
    ldr	x19,	[sp, fp]

    str	w25,	[x19]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#21
    ble	main_413

main_157:
    movz	w25,	#21
    movz	fp,	#1676
    ldr	x24,	[sp, fp]

    str	w25,	[x24]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#22
    ble	main_413

main_159:
    movz	w25,	#22
    movz	fp,	#1628
    ldr	x6,	[sp, fp]

    str	w25,	[x6]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#23
    ble	main_413

main_161:
    movz	w25,	#23
    movz	fp,	#1692
    ldr	x2,	[sp, fp]

    str	w25,	[x2]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#24
    ble	main_413

main_163:
    movz	w25,	#24
    movz	fp,	#1668
    ldr	x21,	[sp, fp]

    str	w25,	[x21]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#25
    ble	main_413

main_165:
    movz	w25,	#25
    movz	fp,	#1604
    ldr	x27,	[sp, fp]

    str	w25,	[x27]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#26
    ble	main_413

main_167:
    movz	w25,	#26
    movz	fp,	#1580
    ldr	x16,	[sp, fp]

    str	w25,	[x16]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#27
    ble	main_413

main_169:
    movz	w25,	#27
    movz	fp,	#1132
    ldr	x1,	[sp, fp]

    str	w25,	[x1]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#28
    ble	main_413

main_171:
    movz	w25,	#28
    movz	fp,	#1164
    ldr	x5,	[sp, fp]

    str	w25,	[x5]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#29
    ble	main_413

main_173:
    movz	w25,	#29
    movz	fp,	#452
    mov	w27,	w25
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3008]

    ldr	x22,	[sp, #3008]

    str	w27,	[x22]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#30
    ble	main_413

main_175:
    movz	w25,	#30
    movz	fp,	#476
    mov	w27,	w25
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3016]

    ldr	x25,	[sp, #3016]

    str	w27,	[x25]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#31
    ble	main_413

main_177:
    movz	w25,	#31
    movz	fp,	#444
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3024]

    ldr	x28,	[sp, #3024]

    str	w25,	[x28]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#32
    ble	main_413

main_179:
    movz	w25,	#32
    movz	fp,	#564
    mov	w27,	w25
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3032]

    ldr	x2,	[sp, #3032]

    str	w27,	[x2]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#33
    ble	main_413

main_181:
    movz	w25,	#33
    movz	fp,	#572
    mov	w27,	w25
    ldr	x4,	[sp, fp]

    movz	fp,	#2844
    str	x4,	[sp, fp]

    movz	fp,	#2844
    ldr	x5,	[sp, fp]

    str	w27,	[x5]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#34
    ble	main_413

main_183:
    movz	w25,	#34
    movz	fp,	#580
    mov	w27,	w25
    ldr	x4,	[sp, fp]

    movz	fp,	#1876
    str	x4,	[sp, fp]

    movz	fp,	#1876
    ldr	x5,	[sp, fp]

    str	w27,	[x5]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#35
    ble	main_413

main_185:
    movz	w25,	#35
    ldr	x1,	[sp, #656]

    movz	fp,	#1868
    mov	w27,	w25
    str	x1,	[sp, fp]

    movz	fp,	#1868
    ldr	x2,	[sp, fp]

    str	w27,	[x2]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#36
    ble	main_413

main_187:
    movz	w25,	#36
    ldr	x27,	[sp, #664]

    movz	fp,	#1860
    str	x27,	[sp, fp]

    movz	fp,	#1860
    ldr	x28,	[sp, fp]

    str	w25,	[x28]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#37
    ble	main_413

main_189:
    movz	w25,	#37
    movz	fp,	#588
    mov	w27,	w25
    ldr	x24,	[sp, fp]

    movz	fp,	#1852
    str	x24,	[sp, fp]

    movz	fp,	#1852
    ldr	x25,	[sp, fp]

    str	w27,	[x25]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#38
    ble	main_413

main_191:
    movz	w25,	#38
    movz	fp,	#596
    mov	w27,	w25
    ldr	x21,	[sp, fp]

    movz	fp,	#1844
    str	x21,	[sp, fp]

    movz	fp,	#1844
    ldr	x22,	[sp, fp]

    str	w27,	[x22]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#39
    ble	main_413

main_193:
    movz	w25,	#39
    movz	fp,	#604
    mov	w27,	w25
    ldr	x18,	[sp, fp]

    movz	fp,	#1836
    str	x18,	[sp, fp]

    movz	fp,	#1836
    ldr	x19,	[sp, fp]

    str	w27,	[x19]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#40
    ble	main_413

main_195:
    movz	w25,	#40
    movz	fp,	#612
    mov	w27,	w25
    ldr	x15,	[sp, fp]

    movz	fp,	#1828
    str	x15,	[sp, fp]

    movz	fp,	#1828
    ldr	x16,	[sp, fp]

    str	w27,	[x16]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#41
    ble	main_413

main_197:
    movz	w25,	#41
    movz	fp,	#620
    mov	w27,	w25
    ldr	x12,	[sp, fp]

    movz	fp,	#1820
    str	x12,	[sp, fp]

    movz	fp,	#1820
    ldr	x13,	[sp, fp]

    str	w27,	[x13]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#42
    ble	main_413

main_199:
    movz	w25,	#42
    movz	fp,	#628
    mov	w27,	w25
    ldr	x9,	[sp, fp]

    movz	fp,	#1812
    str	x9,	[sp, fp]

    movz	fp,	#1812
    ldr	x10,	[sp, fp]

    str	w27,	[x10]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#43
    ble	main_413

main_201:
    movz	w25,	#43
    movz	fp,	#636
    mov	w27,	w25
    ldr	x6,	[sp, fp]

    movz	fp,	#1804
    str	x6,	[sp, fp]

    movz	fp,	#1804
    ldr	x7,	[sp, fp]

    str	w27,	[x7]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#44
    ble	main_413

main_203:
    movz	w25,	#44
    movz	fp,	#484
    mov	w27,	w25
    ldr	x3,	[sp, fp]

    movz	fp,	#1796
    str	x3,	[sp, fp]

    movz	fp,	#1796
    ldr	x4,	[sp, fp]

    str	w27,	[x4]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#45
    ble	main_413

main_205:
    movz	w25,	#45
    movz	fp,	#492
    mov	w27,	w25
    ldr	x0,	[sp, fp]

    movz	fp,	#1788
    str	x0,	[sp, fp]

    movz	fp,	#1788
    ldr	x1,	[sp, fp]

    str	w27,	[x1]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#46
    ble	main_413

main_207:
    movz	w25,	#46
    movz	fp,	#500
    ldr	x26,	[sp, fp]

    movz	fp,	#1780
    str	x26,	[sp, fp]

    movz	fp,	#1780
    ldr	x27,	[sp, fp]

    str	w25,	[x27]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#47
    ble	main_413

main_209:
    movz	w25,	#47
    movz	fp,	#508
    mov	w27,	w25
    ldr	x23,	[sp, fp]

    movz	fp,	#1772
    str	x23,	[sp, fp]

    movz	fp,	#1772
    ldr	x24,	[sp, fp]

    str	w27,	[x24]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#48
    ble	main_413

main_211:
    movz	w25,	#48
    movz	fp,	#516
    mov	w27,	w25
    ldr	x20,	[sp, fp]

    movz	fp,	#1764
    str	x20,	[sp, fp]

    movz	fp,	#1764
    ldr	x21,	[sp, fp]

    str	w27,	[x21]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#49
    ble	main_413

main_213:
    movz	w25,	#49
    movz	fp,	#532
    mov	w27,	w25
    ldr	x17,	[sp, fp]

    movz	fp,	#1756
    str	x17,	[sp, fp]

    movz	fp,	#1756
    ldr	x18,	[sp, fp]

    str	w27,	[x18]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#50
    ble	main_413

main_215:
    movz	w25,	#50
    movz	fp,	#540
    mov	w27,	w25
    ldr	x14,	[sp, fp]

    movz	fp,	#1748
    str	x14,	[sp, fp]

    movz	fp,	#1748
    ldr	x15,	[sp, fp]

    str	w27,	[x15]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#51
    ble	main_413

main_217:
    movz	w25,	#51
    movz	fp,	#548
    mov	w27,	w25
    ldr	x11,	[sp, fp]

    movz	fp,	#1740
    str	x11,	[sp, fp]

    movz	fp,	#1740
    ldr	x12,	[sp, fp]

    str	w27,	[x12]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#52
    ble	main_413

main_219:
    movz	w25,	#52
    movz	fp,	#556
    mov	w27,	w25
    ldr	x8,	[sp, fp]

    movz	fp,	#1732
    str	x8,	[sp, fp]

    movz	fp,	#1732
    ldr	x9,	[sp, fp]

    str	w27,	[x9]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#53
    ble	main_413

main_221:
    movz	w25,	#53
    movz	fp,	#676
    mov	w27,	w25
    ldr	x5,	[sp, fp]

    movz	fp,	#1724
    str	x5,	[sp, fp]

    movz	fp,	#1724
    ldr	x6,	[sp, fp]

    str	w27,	[x6]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#54
    ble	main_413

main_223:
    movz	w25,	#54
    movz	fp,	#524
    mov	w27,	w25
    ldr	x2,	[sp, fp]

    movz	fp,	#1716
    str	x2,	[sp, fp]

    movz	fp,	#1716
    ldr	x3,	[sp, fp]

    str	w27,	[x3]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#55
    ble	main_413

main_225:
    movz	w25,	#55
    ldr	x28,	[sp, #416]

    movz	fp,	#1708
    mov	w26,	w25
    str	x28,	[sp, fp]

    movz	fp,	#1708
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#56
    ble	main_413

main_227:
    movz	w25,	#56
    movz	fp,	#1700
    mov	w27,	w25
    ldr	x25,	[sp, #424]

    str	x25,	[sp, fp]

    movz	fp,	#1700
    ldr	x26,	[sp, fp]

    str	w27,	[x26]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#57
    ble	main_413

main_229:
    movz	w25,	#57
    movz	fp,	#684
    mov	w27,	w25
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #3128]

    ldr	x23,	[sp, #3128]

    str	w27,	[x23]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#58
    ble	main_413

main_231:
    movz	w25,	#58
    movz	fp,	#692
    mov	w27,	w25
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3120]

    ldr	x20,	[sp, #3120]

    str	w27,	[x20]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#59
    ble	main_413

main_233:
    movz	w25,	#59
    movz	fp,	#700
    mov	w27,	w25
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3112]

    ldr	x17,	[sp, #3112]

    str	w27,	[x17]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#60
    ble	main_413

main_235:
    movz	w25,	#60
    movz	fp,	#708
    mov	w27,	w25
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3104]

    ldr	x14,	[sp, #3104]

    str	w27,	[x14]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#61
    ble	main_413

main_237:
    movz	w25,	#61
    movz	fp,	#716
    mov	w27,	w25
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #3096]

    ldr	x11,	[sp, #3096]

    str	w27,	[x11]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#62
    ble	main_413

main_239:
    movz	w25,	#62
    movz	fp,	#724
    mov	w27,	w25
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #3088]

    ldr	x8,	[sp, #3088]

    str	w27,	[x8]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#63
    ble	main_413

main_241:
    movz	w25,	#63
    movz	fp,	#732
    mov	w27,	w25
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3080]

    ldr	x5,	[sp, #3080]

    str	w27,	[x5]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#64
    ble	main_413

main_243:
    movz	w25,	#64
    movz	fp,	#740
    mov	w27,	w25
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3072]

    ldr	x2,	[sp, #3072]

    str	w27,	[x2]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#65
    ble	main_413

main_245:
    movz	w25,	#65
    movz	fp,	#748
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #3064]

    ldr	x28,	[sp, #3064]

    str	w25,	[x28]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#66
    ble	main_413

main_247:
    movz	w25,	#66
    movz	fp,	#756
    mov	w27,	w25
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #3056]

    ldr	x25,	[sp, #3056]

    str	w27,	[x25]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#67
    ble	main_413

main_249:
    movz	w25,	#67
    movz	fp,	#764
    mov	w27,	w25
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #3048]

    ldr	x22,	[sp, #3048]

    str	w27,	[x22]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#68
    ble	main_413

main_251:
    movz	w25,	#68
    movz	fp,	#772
    mov	w27,	w25
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #3040]

    ldr	x19,	[sp, #3040]

    str	w27,	[x19]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#69
    ble	main_413

main_253:
    movz	w25,	#69
    movz	fp,	#780
    mov	w27,	w25
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #3264]

    ldr	x16,	[sp, #3264]

    str	w27,	[x16]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#70
    ble	main_413

main_255:
    movz	w25,	#70
    movz	fp,	#788
    mov	w27,	w25
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #3256]

    ldr	x13,	[sp, #3256]

    str	w27,	[x13]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#71
    ble	main_413

main_257:
    movz	w25,	#71
    movz	fp,	#796
    mov	w27,	w25
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #3248]

    ldr	x10,	[sp, #3248]

    str	w27,	[x10]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#72
    ble	main_413

main_259:
    movz	w25,	#72
    movz	fp,	#804
    mov	w27,	w25
    ldr	x6,	[sp, fp]

    str	x6,	[sp, #3240]

    ldr	x7,	[sp, #3240]

    str	w27,	[x7]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#73
    ble	main_413

main_261:
    movz	w25,	#73
    movz	fp,	#812
    mov	w27,	w25
    ldr	x3,	[sp, fp]

    str	x3,	[sp, #3232]

    ldr	x4,	[sp, #3232]

    str	w27,	[x4]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#74
    ble	main_413

main_263:
    movz	w25,	#74
    movz	fp,	#820
    mov	w27,	w25
    ldr	x0,	[sp, fp]

    str	x0,	[sp, #3224]

    ldr	x1,	[sp, #3224]

    str	w27,	[x1]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#75
    ble	main_413

main_265:
    movz	w25,	#75
    movz	fp,	#828
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #3216]

    ldr	x27,	[sp, #3216]

    str	w25,	[x27]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#76
    ble	main_413

main_267:
    movz	w25,	#76
    movz	fp,	#836
    mov	w27,	w25
    ldr	x23,	[sp, fp]

    str	x23,	[sp, #3208]

    ldr	x24,	[sp, #3208]

    str	w27,	[x24]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#77
    ble	main_413

main_269:
    movz	w25,	#77
    movz	fp,	#844
    mov	w27,	w25
    ldr	x20,	[sp, fp]

    str	x20,	[sp, #3200]

    ldr	x21,	[sp, #3200]

    str	w27,	[x21]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#78
    ble	main_413

main_271:
    movz	w25,	#78
    movz	fp,	#852
    mov	w27,	w25
    ldr	x17,	[sp, fp]

    str	x17,	[sp, #3192]

    ldr	x18,	[sp, #3192]

    str	w27,	[x18]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#79
    ble	main_413

main_273:
    movz	w25,	#79
    movz	fp,	#860
    mov	w27,	w25
    ldr	x14,	[sp, fp]

    str	x14,	[sp, #2576]

    ldr	x15,	[sp, #2576]

    str	w27,	[x15]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#80
    ble	main_413

main_275:
    movz	w25,	#80
    movz	fp,	#868
    mov	w27,	w25
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #2568]

    ldr	x12,	[sp, #2568]

    str	w27,	[x12]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#81
    ble	main_413

main_277:
    movz	w25,	#81
    movz	fp,	#876
    mov	w27,	w25
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #2560]

    ldr	x9,	[sp, #2560]

    str	w27,	[x9]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#82
    ble	main_413

main_279:
    movz	w25,	#82
    movz	fp,	#884
    mov	w27,	w25
    ldr	x5,	[sp, fp]

    str	x5,	[sp, #2552]

    ldr	x6,	[sp, #2552]

    str	w27,	[x6]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#83
    ble	main_413

main_281:
    movz	w25,	#83
    movz	fp,	#892
    mov	w27,	w25
    ldr	x2,	[sp, fp]

    str	x2,	[sp, #2544]

    ldr	x3,	[sp, #2544]

    str	w27,	[x3]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#84
    ble	main_413

main_283:
    movz	w25,	#84
    movz	fp,	#900
    mov	w26,	w25
    ldr	x28,	[sp, fp]

    str	x28,	[sp, #2536]

    ldr	x0,	[sp, #2536]

    str	w26,	[x0]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#85
    ble	main_413

main_285:
    movz	w25,	#85
    movz	fp,	#908
    mov	w27,	w25
    ldr	x25,	[sp, fp]

    str	x25,	[sp, #2528]

    ldr	x26,	[sp, #2528]

    str	w27,	[x26]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#86
    ble	main_413

main_287:
    movz	w25,	#86
    movz	fp,	#916
    mov	w27,	w25
    ldr	x22,	[sp, fp]

    str	x22,	[sp, #2520]

    ldr	x23,	[sp, #2520]

    str	w27,	[x23]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#87
    ble	main_413

main_289:
    movz	w25,	#87
    movz	fp,	#924
    mov	w27,	w25
    ldr	x19,	[sp, fp]

    str	x19,	[sp, #3184]

    ldr	x20,	[sp, #3184]

    str	w27,	[x20]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#88
    ble	main_413

main_291:
    movz	w25,	#88
    movz	fp,	#932
    mov	w27,	w25
    ldr	x16,	[sp, fp]

    str	x16,	[sp, #3176]

    ldr	x17,	[sp, #3176]

    str	w27,	[x17]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#89
    ble	main_413

main_293:
    movz	w25,	#89
    movz	fp,	#940
    mov	w27,	w25
    ldr	x13,	[sp, fp]

    str	x13,	[sp, #3168]

    ldr	x14,	[sp, #3168]

    str	w27,	[x14]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#90
    ble	main_413

main_295:
    movz	w25,	#90
    movz	fp,	#948
    mov	w27,	w25
    ldr	x10,	[sp, fp]

    str	x10,	[sp, #3160]

    ldr	x11,	[sp, #3160]

    str	w27,	[x11]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#91
    ble	main_413

main_297:
    movz	w25,	#91
    movz	fp,	#956
    mov	w27,	w25
    ldr	x7,	[sp, fp]

    str	x7,	[sp, #3152]

    ldr	x8,	[sp, #3152]

    str	w27,	[x8]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#92
    ble	main_413

main_299:
    movz	w25,	#92
    movz	fp,	#964
    mov	w27,	w25
    ldr	x4,	[sp, fp]

    str	x4,	[sp, #3144]

    ldr	x5,	[sp, #3144]

    str	w27,	[x5]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#93
    ble	main_413

main_301:
    movz	w25,	#93
    movz	fp,	#972
    mov	w27,	w25
    ldr	x1,	[sp, fp]

    str	x1,	[sp, #3136]

    ldr	x2,	[sp, #3136]

    str	w27,	[x2]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#94
    ble	main_413

main_303:
    movz	w25,	#94
    movz	fp,	#980
    ldr	x27,	[sp, fp]

    str	x27,	[sp, #2512]

    ldr	x28,	[sp, #2512]

    str	w25,	[x28]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#95
    ble	main_413

main_305:
    movz	w25,	#95
    movz	fp,	#988
    mov	w27,	w25
    ldr	x24,	[sp, fp]

    str	x24,	[sp, #2504]

    ldr	x25,	[sp, #2504]

    str	w27,	[x25]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#96
    ble	main_413

main_307:
    movz	w25,	#96
    movz	fp,	#996
    mov	w27,	w25
    ldr	x21,	[sp, fp]

    str	x21,	[sp, #2496]

    ldr	x22,	[sp, #2496]

    str	w27,	[x22]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#97
    ble	main_413

main_309:
    movz	w25,	#97
    movz	fp,	#1004
    mov	w27,	w25
    ldr	x18,	[sp, fp]

    str	x18,	[sp, #2488]

    ldr	x19,	[sp, #2488]

    str	w27,	[x19]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#98
    ble	main_413

main_311:
    movz	w25,	#98
    movz	fp,	#1012
    mov	w27,	w25
    ldr	x15,	[sp, fp]

    str	x15,	[sp, #2480]

    ldr	x16,	[sp, #2480]

    str	w27,	[x16]

    ldr	w25,	[sp, #1040]

    cmp	w25,	#99
    ble	main_413

main_313:
    movz	w25,	#99
    movz	fp,	#1020
    mov	w27,	w25
    ldr	x12,	[sp, fp]

    str	x12,	[sp, #432]

    ldr	x13,	[sp, #432]

    str	w27,	[x13]


main_413:
    ldr	w25,	[sp, #1028]

    add	w25,	w25,	#1
    str	w25,	[sp, #644]

    ldr	w25,	[sp, #1032]

    str	w25,	[sp, #652]

    movz	w25,	#0
    str	w25,	[sp, #648]


main_415:
    ldr	w25,	[sp, #648]

    cmp	w25,	#100
    blt	main_419

main_424:
    movz	w25,	#65535
    ldr	w13,	[sp, #652]

    mov	w27,	w25
    str	w13,	[sp, #2820]

    ldr	w14,	[sp, #2820]

    sdiv	w25,	w14,	w27
    str	w25,	[sp, #440]

    ldr	w25,	[sp, #440]

    ldr	w7,	[sp, #440]

    lsl	w27,	w25,	#16
    str	w7,	[sp, #2812]

    ldr	w8,	[sp, #2812]

    ldr	w16,	[sp, #652]

    sub	w27,	w27,	w8,	lsl #0
    str	w16,	[sp, #2824]

    ldr	w17,	[sp, #2824]

    ldr	w7,	[sp, #644]

    sub	w1,	w17,	w27
    str	w7,	[sp, #1884]

    ldr	w22,	[sp, #1036]

    str	w22,	[sp, #2832]

    ldr	w8,	[sp, #1884]

    ldr	w0,	[sp, #2832]

    cmp	w8,	w0
    blt	main_112

main_428:
    mov	w0,	w1

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
    mov	w25,	w1
    str	w25,	[sp, #1032]

    ldr	w25,	[sp, #644]

    str	w25,	[sp, #1028]

    b	main_113

main_419:
    ldr	w25,	[sp, #648]

    lsl	w25,	w25,	#2
    mov	x25,	x25
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w27,	[x25]

    ldr	w19,	[sp, #652]

    str	w19,	[sp, #2828]

    ldr	w20,	[sp, #2828]

    ldr	w10,	[sp, #648]

    add	w0,	w27,	w20
    str	w10,	[sp, #2816]

    mov	w25,	w0
    ldr	w11,	[sp, #2816]

    add	w4,	w11,	#1
    str	w4,	[sp, #2808]

    ldr	w5,	[sp, #2808]

    str	w5,	[sp, #672]

    str	w25,	[sp, #652]

    ldr	w25,	[sp, #672]

    str	w25,	[sp, #648]

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

