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
    str	w0,	[sp, #1136]

    bl	getint
    str	w0,	[sp, #1140]

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
    ldr	w15,	[sp, #1136]

    cmp	w28,	w15
    bge	main_427

main_12:
    add	x7,	sp,	#20
    add	x26,	sp,	#24
    add	x10,	sp,	#28
    add	x25,	sp,	#32
    add	x11,	sp,	#36
    add	x24,	sp,	#40
    add	x4,	sp,	#44
    add	x9,	sp,	#48
    add	x1,	sp,	#52
    add	x5,	sp,	#56
    add	x16,	sp,	#60
    add	x23,	sp,	#64
    add	x3,	sp,	#68
    add	x15,	sp,	#72
    add	x13,	sp,	#76
    add	x14,	sp,	#80
    add	x6,	sp,	#84
    add	x19,	sp,	#88
    add	x8,	sp,	#92
    add	x22,	sp,	#96
    add	x20,	sp,	#100
    add	x2,	sp,	#104
    add	x18,	sp,	#108
    add	x0,	sp,	#112
    add	x17,	sp,	#116
    add	x27,	sp,	#120
    add	x28,	sp,	#124
    add	x21,	sp,	#128
    movz	fp,	#652
    str	x7,	[sp, #1648]

    str	x26,	[sp, #1776]

    str	x10,	[sp, #1656]

    str	x25,	[sp, #1696]

    str	x11,	[sp, #1736]

    str	x24,	[sp, #1616]

    str	x4,	[sp, #1640]

    str	x9,	[sp, #1808]

    str	x1,	[sp, #1632]

    str	x5,	[sp, #1720]

    str	x16,	[sp, #1672]

    str	x23,	[sp, #1768]

    str	x3,	[sp, #1792]

    str	x15,	[sp, #1400]

    str	x13,	[sp, #1664]

    str	x14,	[sp, #1744]

    str	x6,	[sp, #1800]

    str	x19,	[sp, #1680]

    str	x8,	[sp, #1728]

    str	x22,	[sp, #1688]

    str	x20,	[sp, #1760]

    str	x2,	[sp, #1712]

    str	x18,	[sp, #1408]

    str	x0,	[sp, #1784]

    add	x0,	sp,	#132
    str	x17,	[sp, #1752]

    str	x27,	[sp, #1624]

    add	x27,	sp,	#136
    str	x28,	[sp, #1704]

    str	x21,	[sp, #1608]

    str	x0,	[sp, fp]

    movz	fp,	#596
    add	x0,	sp,	#140
    str	x27,	[sp, #568]

    add	x27,	sp,	#144
    str	x0,	[sp, #584]

    add	x0,	sp,	#148
    str	x27,	[sp, #576]

    add	x27,	sp,	#152
    str	x0,	[sp, #752]

    add	x0,	sp,	#156
    str	x27,	[sp, #760]

    add	x27,	sp,	#164
    str	x0,	[sp, #768]

    add	x0,	sp,	#160
    str	x0,	[sp, #776]

    add	x0,	sp,	#168
    str	x27,	[sp, fp]

    add	x27,	sp,	#172
    movz	fp,	#604
    str	x0,	[sp, fp]

    add	x0,	sp,	#176
    movz	fp,	#612
    str	x27,	[sp, fp]

    add	x27,	sp,	#180
    movz	fp,	#620
    str	x0,	[sp, fp]

    add	x0,	sp,	#184
    movz	fp,	#628
    str	x27,	[sp, fp]

    add	x27,	sp,	#188
    movz	fp,	#636
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#644
    str	x27,	[sp, fp]

    add	x27,	sp,	#200
    str	x0,	[sp, #664]

    add	x0,	sp,	#196
    str	x0,	[sp, #672]

    add	x0,	sp,	#204
    str	x27,	[sp, #680]

    add	x27,	sp,	#208
    str	x0,	[sp, #688]

    add	x0,	sp,	#212
    str	x27,	[sp, #696]

    add	x27,	sp,	#216
    str	x0,	[sp, #712]

    add	x0,	sp,	#220
    str	x27,	[sp, #720]

    add	x27,	sp,	#224
    str	x0,	[sp, #728]

    add	x0,	sp,	#228
    str	x27,	[sp, #736]

    add	x27,	sp,	#232
    str	x0,	[sp, #784]

    add	x0,	sp,	#240
    str	x27,	[sp, #704]

    add	x27,	sp,	#236
    str	x27,	[sp, #416]

    add	x27,	sp,	#244
    str	x0,	[sp, #424]

    add	x0,	sp,	#248
    str	x27,	[sp, #432]

    add	x27,	sp,	#252
    str	x0,	[sp, #792]

    add	x0,	sp,	#256
    str	x27,	[sp, #800]

    add	x27,	sp,	#260
    str	x0,	[sp, #808]

    add	x0,	sp,	#264
    str	x27,	[sp, #816]

    add	x27,	sp,	#268
    str	x0,	[sp, #824]

    add	x0,	sp,	#272
    str	x27,	[sp, #832]

    add	x27,	sp,	#280
    str	x0,	[sp, #840]

    add	x0,	sp,	#276
    str	x0,	[sp, #848]

    add	x0,	sp,	#284
    str	x27,	[sp, #856]

    add	x27,	sp,	#288
    str	x0,	[sp, #864]

    add	x0,	sp,	#292
    str	x27,	[sp, #872]

    add	x27,	sp,	#296
    str	x0,	[sp, #880]

    add	x0,	sp,	#300
    str	x27,	[sp, #888]

    add	x27,	sp,	#304
    str	x0,	[sp, #896]

    add	x0,	sp,	#308
    str	x27,	[sp, #904]

    add	x27,	sp,	#316
    str	x0,	[sp, #912]

    add	x0,	sp,	#312
    str	x0,	[sp, #920]

    add	x0,	sp,	#320
    str	x27,	[sp, #928]

    add	x27,	sp,	#324
    str	x0,	[sp, #936]

    add	x0,	sp,	#328
    str	x27,	[sp, #944]

    add	x27,	sp,	#332
    str	x0,	[sp, #952]

    add	x0,	sp,	#336
    str	x27,	[sp, #960]

    add	x27,	sp,	#340
    str	x0,	[sp, #968]

    add	x0,	sp,	#344
    str	x27,	[sp, #976]

    add	x27,	sp,	#348
    str	x0,	[sp, #984]

    add	x0,	sp,	#356
    str	x27,	[sp, #992]

    add	x27,	sp,	#352
    str	x27,	[sp, #1000]

    add	x27,	sp,	#360
    str	x0,	[sp, #1008]

    add	x0,	sp,	#364
    str	x27,	[sp, #1016]

    add	x27,	sp,	#368
    str	x0,	[sp, #1024]

    add	x0,	sp,	#372
    str	x27,	[sp, #1032]

    add	x27,	sp,	#376
    str	x0,	[sp, #1040]

    add	x0,	sp,	#380
    str	x27,	[sp, #1048]

    add	x27,	sp,	#384
    str	x0,	[sp, #1056]

    add	x0,	sp,	#388
    str	x27,	[sp, #1064]

    add	x27,	sp,	#396
    str	x0,	[sp, #1072]

    add	x0,	sp,	#392
    str	x0,	[sp, #1080]

    add	x0,	sp,	#400
    str	x27,	[sp, #1088]

    add	x27,	sp,	#404
    str	x0,	[sp, #1096]

    add	x0,	sp,	#408
    str	x27,	[sp, #1104]

    add	x27,	sp,	#412
    str	x0,	[sp, #1112]

    str	x27,	[sp, #1120]

    movz	w27,	#0
    mov	w0,	w27
    movz	w27,	#0
    str	w0,	[sp, #1132]

    mov	w0,	w27
    str	w0,	[sp, #1128]


main_113:
    ldr	w0,	[sp, #1140]

    cmp	w0,	#1
    ble	main_413

main_117:
    movz	w27,	#1
    ldr	x3,	[sp, #1648]

    mov	w0,	w27
    str	w0,	[x3]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#2
    ble	main_413

main_119:
    movz	w27,	#2
    ldr	x21,	[sp, #1776]

    str	w27,	[x21]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#3
    ble	main_413

main_121:
    movz	w27,	#3
    ldr	x6,	[sp, #1656]

    mov	w0,	w27
    str	w0,	[x6]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#4
    ble	main_413

main_123:
    movz	w0,	#4
    ldr	x21,	[sp, #1696]

    str	w0,	[x21]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#5
    ble	main_413

main_125:
    movz	w27,	#5
    ldr	x6,	[sp, #1736]

    str	w27,	[x6]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#6
    ble	main_413

main_127:
    movz	w0,	#6
    ldr	x19,	[sp, #1616]

    str	w0,	[x19]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#7
    ble	main_413

main_129:
    movz	w0,	#7
    ldr	x26,	[sp, #1640]

    mov	w27,	w0
    str	w27,	[x26]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#8
    ble	main_413

main_131:
    movz	w27,	#8
    ldr	x5,	[sp, #1808]

    str	w27,	[x5]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#9
    ble	main_413

main_133:
    movz	w0,	#9
    ldr	x23,	[sp, #1632]

    mov	w27,	w0
    str	w27,	[x23]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#10
    ble	main_413

main_135:
    movz	w27,	#10
    ldr	x2,	[sp, #1720]

    mov	w0,	w27
    str	w0,	[x2]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#11
    ble	main_413

main_137:
    movz	w27,	#11
    ldr	x10,	[sp, #1672]

    str	w27,	[x10]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#12
    ble	main_413

main_139:
    movz	w27,	#12
    ldr	x20,	[sp, #1768]

    mov	w0,	w27
    str	w0,	[x20]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#13
    ble	main_413

main_141:
    movz	w0,	#13
    ldr	x1,	[sp, #1792]

    str	w0,	[x1]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#14
    ble	main_413

main_143:
    movz	w27,	#14
    ldr	x8,	[sp, #1400]

    str	w27,	[x8]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#15
    ble	main_413

main_145:
    movz	w0,	#15
    ldr	x9,	[sp, #1664]

    str	w0,	[x9]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#16
    ble	main_413

main_147:
    movz	w0,	#16
    ldr	x9,	[sp, #1744]

    mov	w27,	w0
    str	w27,	[x9]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#17
    ble	main_413

main_149:
    movz	w27,	#17
    ldr	x2,	[sp, #1800]

    str	w27,	[x2]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#18
    ble	main_413

main_151:
    movz	w0,	#18
    ldr	x13,	[sp, #1680]

    mov	w27,	w0
    str	w27,	[x13]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#19
    ble	main_413

main_153:
    movz	w27,	#19
    ldr	x5,	[sp, #1728]

    mov	w0,	w27
    str	w0,	[x5]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#20
    ble	main_413

main_155:
    movz	w27,	#20
    ldr	x16,	[sp, #1688]

    str	w27,	[x16]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#21
    ble	main_413

main_157:
    movz	w27,	#21
    ldr	x17,	[sp, #1760]

    mov	w0,	w27
    str	w0,	[x17]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#22
    ble	main_413

main_159:
    movz	w0,	#22
    ldr	x27,	[sp, #1712]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#23
    ble	main_413

main_161:
    movz	w27,	#23
    ldr	x11,	[sp, #1408]

    str	w27,	[x11]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#24
    ble	main_413

main_163:
    movz	w0,	#24
    ldr	x26,	[sp, #1784]

    str	w0,	[x26]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#25
    ble	main_413

main_165:
    movz	w0,	#25
    ldr	x12,	[sp, #1752]

    mov	w27,	w0
    str	w27,	[x12]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#26
    ble	main_413

main_167:
    movz	w27,	#26
    ldr	x20,	[sp, #1624]

    str	w27,	[x20]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#27
    ble	main_413

main_169:
    movz	w0,	#27
    ldr	x22,	[sp, #1704]

    mov	w27,	w0
    str	w27,	[x22]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#28
    ble	main_413

main_171:
    movz	w27,	#28
    ldr	x16,	[sp, #1608]

    mov	w0,	w27
    str	w0,	[x16]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#29
    ble	main_413

main_173:
    movz	w27,	#29
    movz	fp,	#652
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#30
    ble	main_413

main_175:
    movz	w27,	#30
    mov	w0,	w27
    ldr	x27,	[sp, #568]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#31
    ble	main_413

main_177:
    movz	w0,	#31
    ldr	x27,	[sp, #584]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#32
    ble	main_413

main_179:
    movz	w27,	#32
    ldr	x0,	[sp, #576]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#33
    ble	main_413

main_181:
    movz	w0,	#33
    ldr	x27,	[sp, #752]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#34
    ble	main_413

main_183:
    movz	w0,	#34
    mov	w27,	w0
    ldr	x0,	[sp, #760]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#35
    ble	main_413

main_185:
    movz	w27,	#35
    ldr	x0,	[sp, #768]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#36
    ble	main_413

main_187:
    movz	w0,	#36
    mov	w27,	w0
    ldr	x0,	[sp, #776]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#37
    ble	main_413

main_189:
    movz	w27,	#37
    movz	fp,	#596
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#38
    ble	main_413

main_191:
    movz	w27,	#38
    movz	fp,	#604
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#39
    ble	main_413

main_193:
    movz	w27,	#39
    movz	fp,	#612
    mov	w0,	w27
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#40
    ble	main_413

main_195:
    movz	w0,	#40
    movz	fp,	#620
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#41
    ble	main_413

main_197:
    movz	w27,	#41
    movz	fp,	#628
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#42
    ble	main_413

main_199:
    movz	w0,	#42
    movz	fp,	#636
    ldr	x27,	[sp, fp]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#43
    ble	main_413

main_201:
    movz	w0,	#43
    movz	fp,	#644
    mov	w27,	w0
    ldr	x0,	[sp, fp]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#44
    ble	main_413

main_203:
    movz	w27,	#44
    ldr	x0,	[sp, #664]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#45
    ble	main_413

main_205:
    movz	w0,	#45
    mov	w27,	w0
    ldr	x0,	[sp, #672]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#46
    ble	main_413

main_207:
    movz	w27,	#46
    ldr	x0,	[sp, #680]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#47
    ble	main_413

main_209:
    movz	w27,	#47
    mov	w0,	w27
    ldr	x27,	[sp, #688]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#48
    ble	main_413

main_211:
    movz	w27,	#48
    mov	w0,	w27
    ldr	x27,	[sp, #696]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#49
    ble	main_413

main_213:
    movz	w0,	#49
    ldr	x27,	[sp, #712]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#50
    ble	main_413

main_215:
    movz	w27,	#50
    mov	w0,	w27
    ldr	x27,	[sp, #720]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#51
    ble	main_413

main_217:
    movz	w0,	#51
    mov	w27,	w0
    ldr	x0,	[sp, #728]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#52
    ble	main_413

main_219:
    movz	w0,	#52
    mov	w27,	w0
    ldr	x0,	[sp, #736]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#53
    ble	main_413

main_221:
    movz	w27,	#53
    ldr	x0,	[sp, #784]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#54
    ble	main_413

main_223:
    movz	w0,	#54
    mov	w27,	w0
    ldr	x0,	[sp, #704]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#55
    ble	main_413

main_225:
    movz	w27,	#55
    mov	w0,	w27
    ldr	x27,	[sp, #416]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#56
    ble	main_413

main_227:
    movz	w27,	#56
    ldr	x0,	[sp, #424]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#57
    ble	main_413

main_229:
    movz	w27,	#57
    mov	w0,	w27
    ldr	x27,	[sp, #432]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#58
    ble	main_413

main_231:
    movz	w0,	#58
    ldr	x27,	[sp, #792]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#59
    ble	main_413

main_233:
    movz	w27,	#59
    ldr	x0,	[sp, #800]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#60
    ble	main_413

main_235:
    movz	w0,	#60
    ldr	x27,	[sp, #808]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#61
    ble	main_413

main_237:
    movz	w0,	#61
    mov	w27,	w0
    ldr	x0,	[sp, #816]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#62
    ble	main_413

main_239:
    movz	w27,	#62
    ldr	x0,	[sp, #824]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#63
    ble	main_413

main_241:
    movz	w0,	#63
    mov	w27,	w0
    ldr	x0,	[sp, #832]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#64
    ble	main_413

main_243:
    movz	w27,	#64
    mov	w0,	w27
    ldr	x27,	[sp, #840]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#65
    ble	main_413

main_245:
    movz	w27,	#65
    ldr	x0,	[sp, #848]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#66
    ble	main_413

main_247:
    movz	w27,	#66
    mov	w0,	w27
    ldr	x27,	[sp, #856]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#67
    ble	main_413

main_249:
    movz	w0,	#67
    ldr	x27,	[sp, #864]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#68
    ble	main_413

main_251:
    movz	w27,	#68
    ldr	x0,	[sp, #872]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#69
    ble	main_413

main_253:
    movz	w0,	#69
    mov	w27,	w0
    ldr	x0,	[sp, #880]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#70
    ble	main_413

main_255:
    movz	w0,	#70
    mov	w27,	w0
    ldr	x0,	[sp, #888]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#71
    ble	main_413

main_257:
    movz	w27,	#71
    mov	w0,	w27
    ldr	x27,	[sp, #896]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#72
    ble	main_413

main_259:
    movz	w0,	#72
    mov	w27,	w0
    ldr	x0,	[sp, #904]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#73
    ble	main_413

main_261:
    movz	w27,	#73
    mov	w0,	w27
    ldr	x27,	[sp, #912]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#74
    ble	main_413

main_263:
    movz	w27,	#74
    ldr	x0,	[sp, #920]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#75
    ble	main_413

main_265:
    movz	w27,	#75
    mov	w0,	w27
    ldr	x27,	[sp, #928]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#76
    ble	main_413

main_267:
    movz	w0,	#76
    mov	w27,	w0
    ldr	x0,	[sp, #936]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#77
    ble	main_413

main_269:
    movz	w27,	#77
    ldr	x0,	[sp, #944]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#78
    ble	main_413

main_271:
    movz	w0,	#78
    ldr	x27,	[sp, #952]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#79
    ble	main_413

main_273:
    movz	w0,	#79
    ldr	x27,	[sp, #960]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#80
    ble	main_413

main_275:
    movz	w27,	#80
    ldr	x0,	[sp, #968]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#81
    ble	main_413

main_277:
    movz	w0,	#81
    mov	w27,	w0
    ldr	x0,	[sp, #976]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#82
    ble	main_413

main_279:
    movz	w27,	#82
    mov	w0,	w27
    ldr	x27,	[sp, #984]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#83
    ble	main_413

main_281:
    movz	w27,	#83
    ldr	x0,	[sp, #992]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#84
    ble	main_413

main_283:
    movz	w27,	#84
    mov	w0,	w27
    ldr	x27,	[sp, #1000]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#85
    ble	main_413

main_285:
    movz	w0,	#85
    ldr	x27,	[sp, #1008]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#86
    ble	main_413

main_287:
    movz	w27,	#86
    ldr	x0,	[sp, #1016]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#87
    ble	main_413

main_289:
    movz	w0,	#87
    ldr	x27,	[sp, #1024]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#88
    ble	main_413

main_291:
    movz	w0,	#88
    mov	w27,	w0
    ldr	x0,	[sp, #1032]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#89
    ble	main_413

main_293:
    movz	w27,	#89
    ldr	x0,	[sp, #1040]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#90
    ble	main_413

main_295:
    movz	w0,	#90
    mov	w27,	w0
    ldr	x0,	[sp, #1048]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#91
    ble	main_413

main_297:
    movz	w27,	#91
    ldr	x0,	[sp, #1056]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#92
    ble	main_413

main_299:
    movz	w27,	#92
    ldr	x0,	[sp, #1064]

    str	w27,	[x0]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#93
    ble	main_413

main_301:
    movz	w27,	#93
    mov	w0,	w27
    ldr	x27,	[sp, #1072]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#94
    ble	main_413

main_303:
    movz	w0,	#94
    ldr	x27,	[sp, #1080]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#95
    ble	main_413

main_305:
    movz	w27,	#95
    ldr	x0,	[sp, #1088]

    str	w27,	[x0]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#96
    ble	main_413

main_307:
    movz	w0,	#96
    ldr	x27,	[sp, #1096]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#97
    ble	main_413

main_309:
    movz	w0,	#97
    ldr	x27,	[sp, #1104]

    str	w0,	[x27]

    ldr	w0,	[sp, #1140]

    cmp	w0,	#98
    ble	main_413

main_311:
    movz	w27,	#98
    mov	w0,	w27
    ldr	x27,	[sp, #1112]

    str	w0,	[x27]

    ldr	w27,	[sp, #1140]

    cmp	w27,	#99
    ble	main_413

main_313:
    movz	w0,	#99
    mov	w27,	w0
    ldr	x0,	[sp, #1120]

    str	w27,	[x0]


main_413:
    ldr	w27,	[sp, #1128]

    add	w0,	w27,	#1
    str	w0,	[sp, #440]

    ldr	w0,	[sp, #1132]

    str	w0,	[sp, #748]

    movz	w0,	#0
    mov	w27,	w0
    str	w27,	[sp, #744]


main_415:
    ldr	w0,	[sp, #744]

    cmp	w0,	#100
    bge	main_424

main_419:
    ldr	w27,	[sp, #744]

    lsl	w0,	w27,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w27,	[sp, #748]

    add	w3,	w0,	w27
    str	w3,	[sp, #3168]

    ldr	w0,	[sp, #744]

    add	w27,	w0,	#1
    str	w27,	[sp, #660]

    ldr	w4,	[sp, #3168]

    mov	w0,	w4
    str	w0,	[sp, #748]

    ldr	w27,	[sp, #660]

    str	w27,	[sp, #744]

    b	main_415

main_424:
    movz	w27,	#65535
    ldr	w0,	[sp, #748]

    sdiv	w27,	w0,	w27
    str	w27,	[sp, #592]

    ldr	w0,	[sp, #592]

    lsl	w0,	w0,	#16
    str	w0,	[sp, #3128]

    ldr	w0,	[sp, #592]

    ldr	w1,	[sp, #3128]

    sub	w27,	w1,	w0,	lsl #0
    ldr	w0,	[sp, #748]

    ldr	w3,	[sp, #440]

    sub	w27,	w0,	w27
    str	w3,	[sp, #3132]

    ldr	w5,	[sp, #1136]

    str	w5,	[sp, #564]

    ldr	w7,	[sp, #564]

    ldr	w4,	[sp, #3132]

    cmp	w4,	w7
    bge	main_428

main_112:
    mov	w0,	w27
    str	w0,	[sp, #1132]

    ldr	w0,	[sp, #440]

    str	w0,	[sp, #1128]

    b	main_113

main_428:
    mov	w0,	w27
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


