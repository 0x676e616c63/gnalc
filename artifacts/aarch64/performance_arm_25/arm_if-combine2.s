.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #3184
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#397
    bl	_sysy_starttime
    bl	getint
    str	w0,	[sp, #1116]

    bl	getint
    movz	w26,	#0
    str	w0,	[sp, #1120]

    mov	w0,	w26

main_4:
    cmp	w0,	#100
    bge	main_10

main_7:
    lsl	w10,	w0,	#2
    movz	w25,	#0
    add	w26,	w0,	#1
    mov	x3,	x10
    mov	w0,	w26
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    str	w25,	[x3]

    b	main_4

main_10:
    movz	w27,	#0
    ldr	w15,	[sp, #1116]

    cmp	w27,	w15
    bge	main_427

main_12:
    add	x8,	sp,	#20
    movz	fp,	#1692
    add	x22,	sp,	#24
    add	x23,	sp,	#28
    add	x26,	sp,	#32
    add	x2,	sp,	#36
    add	x17,	sp,	#40
    add	x14,	sp,	#44
    add	x18,	sp,	#48
    add	x1,	sp,	#52
    add	x20,	sp,	#56
    add	x21,	sp,	#60
    add	x9,	sp,	#64
    add	x4,	sp,	#68
    add	x7,	sp,	#72
    add	x5,	sp,	#76
    add	x24,	sp,	#80
    add	x28,	sp,	#84
    add	x25,	sp,	#88
    add	x10,	sp,	#92
    add	x16,	sp,	#96
    add	x6,	sp,	#100
    add	x3,	sp,	#104
    add	x13,	sp,	#108
    add	x0,	sp,	#112
    add	x27,	sp,	#116
    add	x19,	sp,	#120
    add	x15,	sp,	#124
    add	x11,	sp,	#128
    str	x8,	[sp, fp]

    movz	fp,	#1164
    str	x22,	[sp, fp]

    movz	fp,	#1732
    str	x23,	[sp, fp]

    movz	fp,	#1740
    str	x26,	[sp, fp]

    movz	fp,	#1676
    str	x2,	[sp, fp]

    movz	fp,	#1716
    str	x17,	[sp, fp]

    movz	fp,	#1708
    str	x14,	[sp, fp]

    movz	fp,	#1460
    str	x18,	[sp, fp]

    movz	fp,	#444
    str	x1,	[sp, fp]

    movz	fp,	#1724
    str	x20,	[sp, fp]

    movz	fp,	#1468
    str	x21,	[sp, fp]

    movz	fp,	#1772
    str	x9,	[sp, fp]

    movz	fp,	#452
    str	x4,	[sp, fp]

    movz	fp,	#460
    str	x7,	[sp, fp]

    movz	fp,	#1684
    str	x5,	[sp, fp]

    movz	fp,	#1476
    str	x24,	[sp, fp]

    movz	fp,	#1668
    str	x28,	[sp, fp]

    movz	fp,	#1180
    str	x25,	[sp, fp]

    movz	fp,	#1132
    str	x10,	[sp, fp]

    movz	fp,	#1148
    str	x16,	[sp, fp]

    movz	fp,	#1764
    str	x6,	[sp, fp]

    movz	fp,	#1756
    str	x3,	[sp, fp]

    movz	fp,	#1140
    str	x13,	[sp, fp]

    movz	fp,	#1748
    str	x0,	[sp, fp]

    add	x0,	sp,	#132
    movz	fp,	#436
    str	x27,	[sp, fp]

    movz	fp,	#1156
    str	x19,	[sp, fp]

    movz	fp,	#1636
    str	x15,	[sp, fp]

    movz	fp,	#1700
    str	x11,	[sp, fp]

    movz	fp,	#692
    str	x0,	[sp, fp]

    movz	fp,	#548
    add	x0,	sp,	#136
    str	x0,	[sp, fp]

    movz	fp,	#468
    add	x0,	sp,	#140
    str	x0,	[sp, fp]

    movz	fp,	#564
    add	x0,	sp,	#144
    str	x0,	[sp, fp]

    movz	fp,	#556
    add	x0,	sp,	#148
    str	x0,	[sp, fp]

    movz	fp,	#700
    add	x0,	sp,	#152
    str	x0,	[sp, fp]

    movz	fp,	#708
    add	x0,	sp,	#156
    str	x0,	[sp, fp]

    movz	fp,	#652
    add	x0,	sp,	#160
    str	x0,	[sp, fp]

    movz	fp,	#660
    add	x0,	sp,	#164
    str	x0,	[sp, fp]

    movz	fp,	#668
    add	x0,	sp,	#168
    str	x0,	[sp, fp]

    movz	fp,	#676
    add	x0,	sp,	#172
    str	x0,	[sp, fp]

    movz	fp,	#684
    add	x0,	sp,	#176
    str	x0,	[sp, fp]

    movz	fp,	#716
    add	x0,	sp,	#180
    str	x0,	[sp, fp]

    movz	fp,	#724
    add	x0,	sp,	#184
    str	x0,	[sp, fp]

    movz	fp,	#732
    add	x0,	sp,	#188
    str	x0,	[sp, fp]

    movz	fp,	#740
    add	x0,	sp,	#192
    str	x0,	[sp, fp]

    movz	fp,	#748
    add	x0,	sp,	#196
    str	x0,	[sp, fp]

    movz	fp,	#756
    add	x0,	sp,	#200
    str	x0,	[sp, #584]

    add	x0,	sp,	#204
    str	x0,	[sp, #592]

    add	x0,	sp,	#208
    str	x0,	[sp, #600]

    add	x0,	sp,	#212
    str	x0,	[sp, #608]

    add	x0,	sp,	#216
    str	x0,	[sp, #616]

    add	x0,	sp,	#220
    str	x0,	[sp, #624]

    add	x0,	sp,	#224
    str	x0,	[sp, #632]

    add	x0,	sp,	#228
    str	x0,	[sp, fp]

    movz	fp,	#764
    add	x0,	sp,	#232
    str	x0,	[sp, #640]

    add	x0,	sp,	#236
    str	x0,	[sp, #416]

    add	x0,	sp,	#240
    str	x0,	[sp, #424]

    add	x0,	sp,	#244
    str	x0,	[sp, fp]

    movz	fp,	#772
    add	x0,	sp,	#248
    str	x0,	[sp, fp]

    movz	fp,	#780
    add	x0,	sp,	#252
    str	x0,	[sp, fp]

    movz	fp,	#788
    add	x0,	sp,	#256
    str	x0,	[sp, fp]

    movz	fp,	#796
    add	x0,	sp,	#260
    str	x0,	[sp, fp]

    movz	fp,	#804
    add	x0,	sp,	#264
    str	x0,	[sp, fp]

    movz	fp,	#812
    add	x0,	sp,	#268
    str	x0,	[sp, fp]

    movz	fp,	#820
    add	x0,	sp,	#272
    str	x0,	[sp, fp]

    movz	fp,	#828
    add	x0,	sp,	#276
    str	x0,	[sp, fp]

    movz	fp,	#836
    add	x0,	sp,	#280
    str	x0,	[sp, fp]

    movz	fp,	#844
    add	x0,	sp,	#284
    str	x0,	[sp, fp]

    movz	fp,	#852
    add	x0,	sp,	#288
    str	x0,	[sp, fp]

    movz	fp,	#860
    add	x0,	sp,	#292
    str	x0,	[sp, fp]

    movz	fp,	#868
    add	x0,	sp,	#296
    str	x0,	[sp, fp]

    movz	fp,	#876
    add	x0,	sp,	#300
    str	x0,	[sp, fp]

    movz	fp,	#884
    add	x0,	sp,	#304
    str	x0,	[sp, fp]

    movz	fp,	#892
    add	x0,	sp,	#308
    str	x0,	[sp, fp]

    movz	fp,	#900
    add	x0,	sp,	#312
    str	x0,	[sp, fp]

    movz	fp,	#908
    add	x0,	sp,	#316
    str	x0,	[sp, fp]

    movz	fp,	#916
    add	x0,	sp,	#320
    str	x0,	[sp, fp]

    movz	fp,	#924
    add	x0,	sp,	#324
    str	x0,	[sp, fp]

    movz	fp,	#932
    add	x0,	sp,	#328
    str	x0,	[sp, fp]

    movz	fp,	#940
    add	x0,	sp,	#332
    str	x0,	[sp, fp]

    movz	fp,	#948
    add	x0,	sp,	#336
    str	x0,	[sp, fp]

    movz	fp,	#956
    add	x0,	sp,	#340
    str	x0,	[sp, fp]

    movz	fp,	#964
    add	x0,	sp,	#344
    str	x0,	[sp, fp]

    movz	fp,	#972
    add	x0,	sp,	#348
    str	x0,	[sp, fp]

    movz	fp,	#980
    add	x0,	sp,	#352
    str	x0,	[sp, fp]

    movz	fp,	#988
    add	x0,	sp,	#356
    str	x0,	[sp, fp]

    movz	fp,	#996
    add	x0,	sp,	#360
    str	x0,	[sp, fp]

    movz	fp,	#1004
    add	x0,	sp,	#364
    str	x0,	[sp, fp]

    movz	fp,	#1012
    add	x0,	sp,	#368
    str	x0,	[sp, fp]

    movz	fp,	#1020
    add	x0,	sp,	#372
    str	x0,	[sp, fp]

    movz	fp,	#1028
    add	x0,	sp,	#376
    str	x0,	[sp, fp]

    movz	fp,	#1036
    add	x0,	sp,	#380
    str	x0,	[sp, fp]

    movz	fp,	#1044
    add	x0,	sp,	#384
    str	x0,	[sp, fp]

    movz	fp,	#1052
    add	x0,	sp,	#388
    str	x0,	[sp, fp]

    movz	fp,	#1060
    add	x0,	sp,	#392
    str	x0,	[sp, fp]

    movz	fp,	#1068
    add	x0,	sp,	#396
    str	x0,	[sp, fp]

    movz	fp,	#1076
    add	x0,	sp,	#400
    str	x0,	[sp, fp]

    movz	fp,	#1084
    add	x0,	sp,	#404
    str	x0,	[sp, fp]

    movz	fp,	#1092
    add	x0,	sp,	#408
    str	x0,	[sp, fp]

    movz	fp,	#1100
    add	x0,	sp,	#412
    str	x0,	[sp, fp]

    movz	w0,	#0
    str	w0,	[sp, #1112]

    movz	w0,	#0
    str	w0,	[sp, #1108]


main_113:
    ldr	w0,	[sp, #1120]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w0,	#1
    movz	fp,	#1692
    ldr	x6,	[sp, fp]

    str	w0,	[x6]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#2
    ble	main_413

main_119:
    movz	w0,	#2
    movz	fp,	#1164
    ldr	x19,	[sp, fp]

    str	w0,	[x19]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w0,	#3
    movz	fp,	#1732
    ldr	x21,	[sp, fp]

    str	w0,	[x21]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    movz	fp,	#1740
    ldr	x24,	[sp, fp]

    str	w0,	[x24]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w0,	#5
    movz	fp,	#1676
    ldr	x1,	[sp, fp]

    str	w0,	[x1]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    movz	fp,	#1716
    ldr	x15,	[sp, fp]

    str	w0,	[x15]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    movz	fp,	#1708
    ldr	x12,	[sp, fp]

    str	w0,	[x12]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#8
    ble	main_413

main_131:
    movz	w0,	#8
    movz	fp,	#1460
    ldr	x14,	[sp, fp]

    str	w0,	[x14]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    movz	fp,	#444
    ldr	x26,	[sp, fp]

    str	w0,	[x26]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#10
    ble	main_413

main_135:
    movz	w0,	#10
    movz	fp,	#1724
    ldr	x18,	[sp, fp]

    str	w0,	[x18]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w0,	#11
    movz	fp,	#1468
    ldr	x17,	[sp, fp]

    str	w0,	[x17]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#12
    ble	main_413

main_139:
    movz	w0,	#12
    movz	fp,	#1772
    ldr	x8,	[sp, fp]

    str	w0,	[x8]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    movz	fp,	#452
    ldr	x2,	[sp, fp]

    str	w0,	[x2]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#14
    ble	main_413

main_143:
    movz	w0,	#14
    movz	fp,	#460
    ldr	x4,	[sp, fp]

    str	w0,	[x4]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    movz	fp,	#1684
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    movz	fp,	#1476
    ldr	x20,	[sp, fp]

    str	w0,	[x20]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w0,	#17
    movz	fp,	#1668
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    movz	fp,	#1180
    ldr	x22,	[sp, fp]

    str	w0,	[x22]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w0,	#19
    movz	fp,	#1132
    ldr	x7,	[sp, fp]

    str	w0,	[x7]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#20
    ble	main_413

main_155:
    movz	w0,	#20
    movz	fp,	#1148
    ldr	x13,	[sp, fp]

    str	w0,	[x13]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w0,	#21
    movz	fp,	#1764
    ldr	x5,	[sp, fp]

    str	w0,	[x5]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    movz	fp,	#1756
    ldr	x3,	[sp, fp]

    str	w0,	[x3]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w0,	#23
    movz	fp,	#1140
    ldr	x10,	[sp, fp]

    str	w0,	[x10]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    movz	fp,	#1748
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    movz	fp,	#436
    ldr	x23,	[sp, fp]

    str	w0,	[x23]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w0,	#26
    movz	fp,	#1156
    ldr	x16,	[sp, fp]

    str	w0,	[x16]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    movz	fp,	#1636
    ldr	x11,	[sp, fp]

    str	w0,	[x11]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w0,	#28
    movz	fp,	#1700
    ldr	x9,	[sp, fp]

    str	w0,	[x9]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#29
    ble	main_413

main_173:
    movz	w0,	#29
    movz	fp,	#692
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w0,	#30
    movz	fp,	#548
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    movz	fp,	#468
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w0,	#32
    movz	fp,	#564
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    movz	fp,	#556
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    movz	fp,	#700
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#35
    ble	main_413

main_185:
    movz	w0,	#35
    movz	fp,	#708
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    movz	fp,	#652
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#37
    ble	main_413

main_189:
    movz	w0,	#37
    movz	fp,	#660
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w0,	#38
    movz	fp,	#668
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#39
    ble	main_413

main_193:
    movz	w0,	#39
    movz	fp,	#676
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#684
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#41
    ble	main_413

main_197:
    movz	w0,	#41
    movz	fp,	#716
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    movz	fp,	#724
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    movz	fp,	#732
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w0,	#44
    movz	fp,	#740
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    movz	fp,	#748
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w0,	#46
    mov	w21,	w0
    ldr	x0,	[sp, #584]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#47
    ble	main_413

main_209:
    movz	w0,	#47
    mov	w21,	w0
    ldr	x0,	[sp, #592]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w0,	#48
    mov	w21,	w0
    ldr	x0,	[sp, #600]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    mov	w21,	w0
    ldr	x0,	[sp, #608]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w0,	#50
    mov	w21,	w0
    ldr	x0,	[sp, #616]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    mov	w21,	w0
    ldr	x0,	[sp, #624]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    mov	w21,	w0
    ldr	x0,	[sp, #632]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#53
    ble	main_413

main_221:
    movz	w0,	#53
    movz	fp,	#756
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    mov	w21,	w0
    ldr	x0,	[sp, #640]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w0,	#55
    mov	w21,	w0
    ldr	x0,	[sp, #416]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#56
    ble	main_413

main_227:
    movz	w0,	#56
    mov	w21,	w0
    ldr	x0,	[sp, #424]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w0,	#57
    movz	fp,	#764
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    movz	fp,	#772
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w0,	#59
    movz	fp,	#780
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    movz	fp,	#788
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    movz	fp,	#796
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#62
    ble	main_413

main_239:
    movz	w0,	#62
    movz	fp,	#804
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    movz	fp,	#812
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#64
    ble	main_413

main_243:
    movz	w0,	#64
    movz	fp,	#820
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w0,	#65
    movz	fp,	#828
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#66
    ble	main_413

main_247:
    movz	w0,	#66
    movz	fp,	#836
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    movz	fp,	#844
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#68
    ble	main_413

main_251:
    movz	w0,	#68
    movz	fp,	#852
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    movz	fp,	#860
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    movz	fp,	#868
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w0,	#71
    movz	fp,	#876
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    movz	fp,	#884
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w0,	#73
    movz	fp,	#892
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#74
    ble	main_413

main_263:
    movz	w0,	#74
    movz	fp,	#900
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w0,	#75
    movz	fp,	#908
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    movz	fp,	#916
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w0,	#77
    movz	fp,	#924
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    movz	fp,	#932
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    movz	fp,	#940
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#80
    ble	main_413

main_275:
    movz	w0,	#80
    movz	fp,	#948
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    movz	fp,	#956
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#82
    ble	main_413

main_279:
    movz	w0,	#82
    movz	fp,	#964
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w0,	#83
    movz	fp,	#972
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w0,	#84
    movz	fp,	#980
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    movz	fp,	#988
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w0,	#86
    movz	fp,	#996
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    movz	fp,	#1004
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    movz	fp,	#1012
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#89
    ble	main_413

main_293:
    movz	w0,	#89
    movz	fp,	#1020
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    movz	fp,	#1028
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#91
    ble	main_413

main_297:
    movz	w0,	#91
    movz	fp,	#1036
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w0,	#92
    movz	fp,	#1044
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#93
    ble	main_413

main_301:
    movz	w0,	#93
    movz	fp,	#1052
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    movz	fp,	#1060
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#95
    ble	main_413

main_305:
    movz	w0,	#95
    movz	fp,	#1068
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    movz	fp,	#1076
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    movz	fp,	#1084
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w0,	#98
    movz	fp,	#1092
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]

    ldr	w0,	[sp, #1120]

    cmp	w0,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    movz	fp,	#1100
    mov	w21,	w0
    ldr	x0,	[sp, fp]

    str	w21,	[x0]


main_413:
    ldr	w0,	[sp, #1108]

    add	w0,	w0,	#1
    str	w0,	[sp, #580]

    ldr	w0,	[sp, #1112]

    str	w0,	[sp, #576]

    movz	w0,	#0
    str	w0,	[sp, #572]


main_415:
    ldr	w0,	[sp, #572]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w0,	[sp, #572]

    lsl	w0,	w0,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w4,	[x0]

    str	w4,	[sp, #3176]

    ldr	w0,	[sp, #576]

    ldr	w5,	[sp, #3176]

    ldr	w21,	[sp, #572]

    add	w0,	w5,	w0
    add	w21,	w21,	#1
    str	w21,	[sp, #648]

    str	w0,	[sp, #576]

    ldr	w0,	[sp, #648]

    str	w0,	[sp, #572]

    b	main_415

main_424:
    movz	w0,	#65535
    ldr	w21,	[sp, #576]

    sdiv	w0,	w21,	w0
    str	w0,	[sp, #432]

    ldr	w0,	[sp, #432]

    lsl	w26,	w0,	#16
    str	w26,	[sp, #3120]

    ldr	w0,	[sp, #432]

    ldr	w27,	[sp, #3120]

    ldr	w21,	[sp, #576]

    sub	w0,	w27,	w0,	lsl #0
    sub	w7,	w21,	w0
    str	w7,	[sp, #3180]

    ldr	w0,	[sp, #580]

    str	w0,	[sp, #2280]

    ldr	w5,	[sp, #1116]

    str	w5,	[sp, #2276]

    ldr	w12,	[sp, #2276]

    ldr	w1,	[sp, #2280]

    cmp	w1,	w12
    bge	main_428

main_112:
    ldr	w8,	[sp, #3180]

    mov	w0,	w8
    str	w0,	[sp, #1112]

    ldr	w0,	[sp, #580]

    str	w0,	[sp, #1108]

    b	main_113

main_428:
    ldr	w0,	[sp, #3180]

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
    
    add	sp, sp, #3184
    ret


