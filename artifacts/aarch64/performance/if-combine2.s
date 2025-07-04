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
    sub	sp, sp, #2736
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#324
    bl	_sysy_starttime
    bl	getint
    movz	w17,	#0
    str	w0,	[sp, #1300]

    mov	w8,	w17

main_3:
    cmp	w8,	#56
    blt	main_6

main_119:
    mov	w0,	w8

main_121:
    lsl	w22,	w0,	#2
    movz	w10,	#0
    add	w3,	w0,	#1
    movz	w11,	#0
    movz	w12,	#0
    movz	w13,	#0
    movz	w16,	#0
    movz	w18,	#0
    movz	w19,	#0
    mov	x14,	x22
    mov	w4,	w10
    lsl	w25,	w3,	#2
    mov	w2,	w11
    mov	w0,	w12
    mov	w27,	w13
    mov	w23,	w16
    add	x14,	sp,	x14
    add	w3,	w3,	#1
    mov	x17,	x25
    add	x17,	sp,	x17
    add	x14,	x14,	#16
    add	w6,	w3,	#1
    lsl	w28,	w3,	#2
    add	x17,	x17,	#16
    mov	x20,	x28
    str	w4,	[x14]

    add	w9,	w6,	#1
    add	x20,	sp,	x20
    movz	w14,	#0
    str	w2,	[x17]

    mov	w25,	w14
    add	w13,	w9,	#1
    lsl	w5,	w9,	#2
    add	x20,	x20,	#16
    lsl	w2,	w6,	#2
    mov	x24,	x5
    mov	x21,	x2
    add	w17,	w13,	#1
    lsl	w8,	w13,	#2
    str	w0,	[x20]

    add	x24,	sp,	x24
    add	x21,	sp,	x21
    mov	x0,	x8
    lsl	w11,	w17,	#2
    add	x0,	sp,	x0
    add	x24,	x24,	#16
    mov	x2,	x11
    add	x21,	x21,	#16
    add	x2,	sp,	x2
    add	x0,	x0,	#16
    str	w27,	[x21]

    add	x2,	x2,	#16
    mov	w21,	w18
    str	w25,	[x24]

    str	w23,	[x0]

    add	w23,	w17,	#1
    str	w21,	[x2]

    add	w15,	w23,	#1
    lsl	w14,	w23,	#2
    mov	x5,	x14
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    str	w19,	[x5]

    cmp	w15,	#96
    blt	main_120

main_140:
    mov	w10,	w15

main_142:
    lsl	w18,	w10,	#2
    movz	w20,	#0
    add	w19,	w10,	#1
    mov	x11,	x18
    mov	w6,	w20
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    str	w6,	[x11]

    cmp	w19,	#100
    bge	main_147

main_141:
    mov	w10,	w19
    b	main_142

main_147:
    movz	w27,	#0
    ldr	w18,	[sp, #1300]

    mov	w8,	w27
    cmp	w8,	w18
    blt	main_149

main_470:
    movz	w0,	#0
    b	main_472

main_149:
    add	x15,	sp,	#20
    add	x24,	sp,	#24
    add	x13,	sp,	#28
    add	x14,	sp,	#32
    add	x23,	sp,	#36
    add	x2,	sp,	#40
    add	x20,	sp,	#44
    add	x17,	sp,	#48
    add	x19,	sp,	#52
    add	x25,	sp,	#56
    add	x10,	sp,	#60
    add	x9,	sp,	#64
    add	x8,	sp,	#68
    add	x6,	sp,	#72
    add	x12,	sp,	#76
    add	x3,	sp,	#80
    add	x11,	sp,	#84
    add	x0,	sp,	#88
    add	x22,	sp,	#92
    add	x26,	sp,	#96
    add	x28,	sp,	#100
    add	x27,	sp,	#104
    add	x21,	sp,	#108
    add	x16,	sp,	#112
    add	x5,	sp,	#116
    add	x18,	sp,	#120
    movz	fp,	#812
    add	x1,	sp,	#212
    add	x4,	sp,	#216
    add	x7,	sp,	#220
    str	x15,	[sp, #2104]

    add	x15,	sp,	#192
    str	x24,	[sp, #2128]

    add	x24,	sp,	#204
    str	x13,	[sp, #1848]

    add	x13,	sp,	#228
    str	x14,	[sp, #1968]

    add	x14,	sp,	#152
    str	x23,	[sp, #1992]

    add	x23,	sp,	#164
    str	x2,	[sp, #1920]

    add	x2,	sp,	#136
    str	x20,	[sp, #1984]

    add	x20,	sp,	#160
    str	x17,	[sp, #1976]

    add	x17,	sp,	#156
    str	x19,	[sp, #1872]

    add	x19,	sp,	#236
    str	x25,	[sp, #1896]

    add	x25,	sp,	#128
    str	x10,	[sp, #1840]

    add	x10,	sp,	#224
    str	x9,	[sp, #2064]

    add	x9,	sp,	#184
    str	x8,	[sp, #1952]

    add	x8,	sp,	#144
    str	x6,	[sp, #2040]

    add	x6,	sp,	#180
    str	x12,	[sp, #2080]

    add	x12,	sp,	#188
    str	x3,	[sp, #2032]

    add	x3,	sp,	#176
    str	x11,	[sp, #1960]

    add	x11,	sp,	#148
    str	x0,	[sp, #2016]

    add	x0,	sp,	#172
    str	x22,	[sp, #1880]

    add	x22,	sp,	#124
    str	x26,	[sp, #2000]

    add	x26,	sp,	#168
    str	x28,	[sp, #1912]

    add	x28,	sp,	#132
    str	x27,	[sp, #2136]

    add	x27,	sp,	#208
    str	x21,	[sp, #2120]

    add	x21,	sp,	#200
    str	x16,	[sp, #1856]

    add	x16,	sp,	#232
    str	x5,	[sp, #1936]

    add	x5,	sp,	#140
    str	x18,	[sp, #2112]

    add	x18,	sp,	#196
    str	x22,	[sp, #488]

    add	x22,	sp,	#240
    str	x25,	[sp, #568]

    add	x25,	sp,	#244
    str	x28,	[sp, #576]

    add	x28,	sp,	#248
    str	x2,	[sp, #584]

    add	x2,	sp,	#252
    str	x5,	[sp, #592]

    add	x5,	sp,	#256
    str	x8,	[sp, fp]

    add	x8,	sp,	#260
    movz	fp,	#820
    str	x11,	[sp, fp]

    add	x11,	sp,	#264
    movz	fp,	#828
    str	x14,	[sp, fp]

    add	x14,	sp,	#268
    movz	fp,	#836
    str	x17,	[sp, fp]

    add	x17,	sp,	#272
    movz	fp,	#844
    str	x20,	[sp, fp]

    add	x20,	sp,	#276
    movz	fp,	#852
    str	x23,	[sp, fp]

    add	x23,	sp,	#280
    movz	fp,	#860
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#868
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#876
    str	x3,	[sp, fp]

    add	x3,	sp,	#292
    movz	fp,	#884
    str	x6,	[sp, fp]

    add	x6,	sp,	#296
    movz	fp,	#892
    str	x9,	[sp, fp]

    add	x9,	sp,	#300
    movz	fp,	#900
    str	x12,	[sp, fp]

    add	x12,	sp,	#304
    movz	fp,	#908
    str	x15,	[sp, fp]

    add	x15,	sp,	#308
    movz	fp,	#916
    str	x18,	[sp, fp]

    add	x18,	sp,	#312
    movz	fp,	#924
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#932
    str	x24,	[sp, fp]

    add	x24,	sp,	#320
    movz	fp,	#940
    str	x27,	[sp, fp]

    add	x27,	sp,	#324
    movz	fp,	#948
    str	x1,	[sp, fp]

    add	x1,	sp,	#328
    movz	fp,	#964
    str	x4,	[sp, fp]

    add	x4,	sp,	#332
    movz	fp,	#972
    str	x7,	[sp, fp]

    add	x7,	sp,	#336
    movz	fp,	#980
    str	x10,	[sp, fp]

    add	x10,	sp,	#340
    movz	fp,	#988
    str	x13,	[sp, fp]

    add	x13,	sp,	#344
    movz	fp,	#956
    str	x16,	[sp, fp]

    add	x16,	sp,	#348
    movz	fp,	#996
    str	x19,	[sp, #416]

    add	x19,	sp,	#352
    str	x22,	[sp, #424]

    add	x22,	sp,	#356
    str	x25,	[sp, #432]

    add	x25,	sp,	#360
    str	x28,	[sp, #440]

    add	x28,	sp,	#364
    str	x2,	[sp, #448]

    add	x2,	sp,	#368
    str	x5,	[sp, #456]

    add	x5,	sp,	#372
    str	x8,	[sp, #464]

    add	x8,	sp,	#376
    str	x11,	[sp, fp]

    add	x11,	sp,	#380
    movz	fp,	#1004
    str	x14,	[sp, fp]

    add	x14,	sp,	#384
    movz	fp,	#1012
    str	x17,	[sp, fp]

    add	x17,	sp,	#388
    movz	fp,	#1020
    str	x20,	[sp, fp]

    add	x20,	sp,	#392
    movz	fp,	#1028
    str	x23,	[sp, fp]

    add	x23,	sp,	#396
    movz	fp,	#1036
    str	x26,	[sp, fp]

    add	x26,	sp,	#400
    movz	fp,	#1044
    str	x0,	[sp, fp]

    add	x0,	sp,	#404
    movz	fp,	#1052
    str	x3,	[sp, fp]

    add	x3,	sp,	#408
    movz	fp,	#1060
    str	x6,	[sp, fp]

    add	x6,	sp,	#412
    movz	fp,	#1068
    str	x9,	[sp, fp]

    movz	fp,	#1076
    str	x12,	[sp, fp]

    movz	w12,	#0
    movz	fp,	#1084
    str	x15,	[sp, fp]

    movz	fp,	#1092
    str	x18,	[sp, fp]

    movz	fp,	#1100
    str	x21,	[sp, fp]

    movz	fp,	#1108
    str	x24,	[sp, fp]

    movz	fp,	#1116
    str	x27,	[sp, fp]

    movz	fp,	#1124
    str	x1,	[sp, fp]

    movz	fp,	#1132
    str	x4,	[sp, fp]

    movz	fp,	#1140
    str	x7,	[sp, fp]

    movz	fp,	#1148
    str	x10,	[sp, fp]

    movz	fp,	#1156
    str	x13,	[sp, fp]

    movz	fp,	#1164
    str	x16,	[sp, fp]

    movz	fp,	#1172
    str	x19,	[sp, fp]

    movz	fp,	#1180
    str	x22,	[sp, fp]

    movz	fp,	#1188
    str	x25,	[sp, fp]

    movz	fp,	#1196
    str	x28,	[sp, fp]

    movz	fp,	#1204
    str	x2,	[sp, fp]

    movz	fp,	#1212
    str	x5,	[sp, fp]

    movz	fp,	#1220
    str	x8,	[sp, fp]

    movz	fp,	#1228
    str	x11,	[sp, fp]

    movz	fp,	#1236
    str	x14,	[sp, fp]

    movz	fp,	#1244
    str	x17,	[sp, fp]

    movz	fp,	#1252
    str	x20,	[sp, fp]

    movz	fp,	#1260
    str	x23,	[sp, fp]

    movz	w23,	#0
    movz	fp,	#1268
    mov	w2,	w23
    str	x26,	[sp, fp]

    movz	fp,	#1276
    str	x0,	[sp, fp]

    movz	fp,	#1284
    str	x3,	[sp, fp]

    movz	fp,	#1292
    str	x6,	[sp, fp]

    mov	w6,	w12
    str	w6,	[sp, #1836]

    str	w2,	[sp, #1832]


main_250:
    movz	w25,	#1
    ldr	x16,	[sp, #2104]

    movz	w11,	#2
    movz	w23,	#4
    movz	fp,	#812
    mov	w24,	w25
    mov	w12,	w11
    mov	w26,	w23
    str	w24,	[x16]

    ldr	x25,	[sp, #2128]

    str	w12,	[x25]

    movz	w25,	#5
    ldr	x14,	[sp, #1848]

    movz	w12,	#3
    mov	w23,	w25
    mov	w11,	w12
    movz	w25,	#9
    movz	w12,	#7
    str	w11,	[x14]

    movz	w11,	#6
    ldr	x15,	[sp, #1968]

    mov	w13,	w11
    str	w26,	[x15]

    mov	w11,	w12
    ldr	x24,	[sp, #1992]

    str	w23,	[x24]

    movz	w23,	#8
    ldr	x3,	[sp, #1920]

    mov	w26,	w23
    str	w13,	[x3]

    mov	w23,	w25
    ldr	x21,	[sp, #1984]

    movz	w25,	#13
    str	w11,	[x21]

    mov	w24,	w25
    movz	w11,	#10
    ldr	x18,	[sp, #1976]

    mov	w12,	w11
    str	w26,	[x18]

    ldr	x20,	[sp, #1872]

    str	w23,	[x20]

    movz	w23,	#12
    ldr	x26,	[sp, #1896]

    str	w12,	[x26]

    mov	w26,	w23
    ldr	x11,	[sp, #1840]

    movz	w12,	#11
    movz	w23,	#16
    mov	w25,	w23
    str	w12,	[x11]

    movz	w12,	#15
    movz	w11,	#14
    ldr	x10,	[sp, #2064]

    mov	w13,	w11
    str	w26,	[x10]

    mov	w11,	w12
    ldr	x9,	[sp, #1952]

    str	w24,	[x9]

    ldr	x7,	[sp, #2040]

    str	w13,	[x7]

    ldr	x13,	[sp, #2080]

    str	w11,	[x13]

    movz	w11,	#18
    ldr	x4,	[sp, #2032]

    str	w25,	[x4]

    ldr	x12,	[sp, #1960]

    movz	w25,	#17
    mov	w24,	w25
    str	w24,	[x12]

    ldr	x1,	[sp, #2016]

    mov	w12,	w11
    str	w12,	[x1]

    ldr	x23,	[sp, #1880]

    movz	w12,	#19
    mov	w11,	w12
    str	w11,	[x23]

    movz	w11,	#22
    ldr	x27,	[sp, #2000]

    movz	w23,	#20
    mov	w12,	w11
    mov	w25,	w23
    str	w25,	[x27]

    ldr	x0,	[sp, #1912]

    movz	w25,	#21
    mov	w23,	w25
    movz	w25,	#25
    str	w23,	[x0]

    mov	w24,	w25
    movz	w23,	#24
    ldr	x28,	[sp, #2136]

    mov	w26,	w23
    str	w12,	[x28]

    movz	w23,	#28
    ldr	x22,	[sp, #2120]

    movz	w12,	#23
    mov	w11,	w12
    str	w11,	[x22]

    movz	w11,	#26
    ldr	x17,	[sp, #1856]

    mov	w12,	w11
    str	w26,	[x17]

    mov	w26,	w23
    ldr	x6,	[sp, #1936]

    str	w24,	[x6]

    ldr	x19,	[sp, #2112]

    str	w12,	[x19]

    ldr	x22,	[sp, #488]

    movz	w12,	#27
    mov	w11,	w12
    str	w11,	[x22]

    movz	w11,	#30
    ldr	x25,	[sp, #568]

    mov	w12,	w11
    str	w26,	[x25]

    ldr	x28,	[sp, #576]

    movz	w25,	#29
    mov	w23,	w25
    str	w23,	[x28]

    movz	w23,	#32
    ldr	x2,	[sp, #584]

    mov	w25,	w23
    str	w12,	[x2]

    movz	w23,	#36
    ldr	x5,	[sp, #592]

    movz	w12,	#31
    mov	w26,	w23
    str	w12,	[x5]

    ldr	x8,	[sp, fp]

    movz	fp,	#820
    str	w25,	[x8]

    movz	w25,	#33
    ldr	x11,	[sp, fp]

    mov	w24,	w25
    movz	fp,	#828
    movz	w25,	#37
    str	w24,	[x11]

    mov	w23,	w25
    ldr	x15,	[sp, fp]

    movz	w11,	#34
    movz	fp,	#836
    mov	w12,	w11
    str	w12,	[x15]

    ldr	x18,	[sp, fp]

    movz	w12,	#35
    movz	fp,	#844
    mov	w11,	w12
    str	w11,	[x18]

    movz	w11,	#38
    ldr	x21,	[sp, fp]

    mov	w12,	w11
    movz	fp,	#852
    str	w26,	[x21]

    ldr	x24,	[sp, fp]

    movz	fp,	#860
    str	w23,	[x24]

    movz	w23,	#40
    ldr	x27,	[sp, fp]

    mov	w25,	w23
    movz	fp,	#868
    str	w12,	[x27]

    movz	w23,	#44
    movz	w12,	#39
    ldr	x1,	[sp, fp]

    mov	w26,	w23
    mov	w11,	w12
    movz	fp,	#876
    movz	w12,	#43
    str	w11,	[x1]

    movz	w11,	#42
    ldr	x4,	[sp, fp]

    mov	w13,	w11
    movz	fp,	#884
    str	w25,	[x4]

    ldr	x7,	[sp, fp]

    movz	w25,	#41
    movz	fp,	#892
    mov	w24,	w25
    movz	w25,	#45
    str	w24,	[x7]

    mov	w23,	w25
    ldr	x11,	[sp, fp]

    movz	fp,	#900
    str	w13,	[x11]

    mov	w11,	w12
    ldr	x14,	[sp, fp]

    movz	fp,	#908
    str	w11,	[x14]

    movz	w11,	#46
    ldr	x16,	[sp, fp]

    mov	w12,	w11
    movz	fp,	#916
    str	w26,	[x16]

    ldr	x20,	[sp, fp]

    movz	fp,	#924
    str	w23,	[x20]

    ldr	x23,	[sp, fp]

    movz	fp,	#932
    str	w12,	[x23]

    movz	w23,	#48
    movz	w12,	#47
    ldr	x26,	[sp, fp]

    mov	w25,	w23
    mov	w11,	w12
    movz	fp,	#940
    movz	w23,	#52
    movz	w12,	#51
    str	w11,	[x26]

    mov	w26,	w23
    movz	w11,	#50
    ldr	x0,	[sp, fp]

    movz	w23,	#56
    mov	w13,	w11
    movz	fp,	#948
    str	w25,	[x0]

    movz	w11,	#54
    ldr	x3,	[sp, fp]

    movz	w25,	#49
    movz	fp,	#964
    mov	w24,	w25
    movz	w25,	#53
    str	w24,	[x3]

    mov	w24,	w25
    ldr	x6,	[sp, fp]

    movz	fp,	#972
    str	w13,	[x6]

    ldr	x10,	[sp, fp]

    movz	fp,	#980
    str	w12,	[x10]

    ldr	x12,	[sp, fp]

    movz	fp,	#988
    str	w26,	[x12]

    mov	w26,	w23
    mov	w12,	w11
    ldr	x15,	[sp, fp]

    movz	fp,	#956
    str	w24,	[x15]

    ldr	x19,	[sp, fp]

    movz	fp,	#996
    str	w12,	[x19]

    ldr	x22,	[sp, #416]

    movz	w12,	#55
    mov	w11,	w12
    str	w11,	[x22]

    movz	w11,	#58
    ldr	x25,	[sp, #424]

    mov	w12,	w11
    str	w26,	[x25]

    movz	w11,	#62
    ldr	x28,	[sp, #432]

    movz	w25,	#57
    mov	w13,	w11
    mov	w23,	w25
    movz	w25,	#61
    str	w23,	[x28]

    movz	w23,	#60
    ldr	x0,	[sp, #440]

    mov	w24,	w23
    str	w12,	[x0]

    movz	w23,	#64
    ldr	x3,	[sp, #448]

    movz	w12,	#59
    mov	w26,	w23
    movz	w23,	#68
    str	w12,	[x3]

    ldr	x6,	[sp, #456]

    str	w24,	[x6]

    ldr	x9,	[sp, #464]

    mov	w24,	w25
    movz	w25,	#65
    str	w24,	[x9]

    mov	w24,	w25
    ldr	x12,	[sp, fp]

    mov	w25,	w23
    movz	fp,	#1004
    str	w13,	[x12]

    ldr	x15,	[sp, fp]

    movz	w12,	#63
    movz	fp,	#1012
    mov	w11,	w12
    str	w11,	[x15]

    movz	w11,	#66
    ldr	x18,	[sp, fp]

    mov	w12,	w11
    movz	fp,	#1020
    str	w26,	[x18]

    ldr	x21,	[sp, fp]

    movz	fp,	#1028
    str	w24,	[x21]

    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    str	w12,	[x24]

    movz	w12,	#67
    ldr	x27,	[sp, fp]

    mov	w11,	w12
    movz	fp,	#1044
    str	w11,	[x27]

    movz	w11,	#70
    ldr	x1,	[sp, fp]

    mov	w12,	w11
    movz	fp,	#1052
    str	w25,	[x1]

    movz	w11,	#74
    movz	w25,	#69
    ldr	x4,	[sp, fp]

    mov	w23,	w25
    movz	fp,	#1060
    movz	w25,	#73
    str	w23,	[x4]

    mov	w24,	w25
    movz	w23,	#72
    ldr	x7,	[sp, fp]

    mov	w26,	w23
    movz	fp,	#1068
    str	w12,	[x7]

    movz	w23,	#76
    ldr	x10,	[sp, fp]

    movz	w12,	#71
    movz	fp,	#1076
    str	w12,	[x10]

    movz	w12,	#75
    ldr	x13,	[sp, fp]

    movz	fp,	#1084
    str	w26,	[x13]

    mov	w26,	w23
    ldr	x16,	[sp, fp]

    movz	fp,	#1092
    str	w24,	[x16]

    mov	w24,	w11
    ldr	x19,	[sp, fp]

    mov	w11,	w12
    movz	fp,	#1100
    str	w24,	[x19]

    ldr	x22,	[sp, fp]

    movz	fp,	#1108
    str	w11,	[x22]

    movz	w11,	#78
    ldr	x25,	[sp, fp]

    mov	w12,	w11
    movz	fp,	#1116
    str	w26,	[x25]

    movz	w25,	#77
    ldr	x28,	[sp, fp]

    mov	w23,	w25
    movz	fp,	#1124
    str	w23,	[x28]

    movz	w23,	#80
    ldr	x2,	[sp, fp]

    mov	w25,	w23
    movz	fp,	#1132
    str	w12,	[x2]

    movz	w23,	#84
    movz	w12,	#79
    ldr	x5,	[sp, fp]

    movz	fp,	#1140
    str	w12,	[x5]

    ldr	x8,	[sp, fp]

    movz	fp,	#1148
    str	w25,	[x8]

    movz	w25,	#81
    ldr	x11,	[sp, fp]

    mov	w24,	w25
    movz	fp,	#1156
    mov	w25,	w23
    str	w24,	[x11]

    ldr	x14,	[sp, fp]

    movz	w11,	#82
    movz	fp,	#1164
    mov	w12,	w11
    movz	w11,	#86
    str	w12,	[x14]

    ldr	x17,	[sp, fp]

    movz	w12,	#83
    movz	fp,	#1172
    mov	w26,	w12
    mov	w12,	w11
    str	w26,	[x17]

    ldr	x20,	[sp, fp]

    movz	fp,	#1180
    str	w25,	[x20]

    movz	w25,	#85
    ldr	x23,	[sp, fp]

    mov	w24,	w25
    movz	fp,	#1188
    movz	w25,	#89
    str	w24,	[x23]

    movz	w23,	#88
    ldr	x26,	[sp, fp]

    movz	fp,	#1196
    str	w12,	[x26]

    mov	w26,	w23
    movz	w12,	#87
    ldr	x0,	[sp, fp]

    movz	w23,	#92
    mov	w11,	w12
    movz	fp,	#1204
    movz	w12,	#91
    str	w11,	[x0]

    movz	w11,	#90
    ldr	x3,	[sp, fp]

    mov	w13,	w11
    movz	fp,	#1212
    str	w26,	[x3]

    mov	w11,	w12
    ldr	x6,	[sp, fp]

    mov	w26,	w25
    movz	fp,	#1220
    movz	w25,	#93
    str	w26,	[x6]

    mov	w24,	w25
    mov	w26,	w23
    ldr	x9,	[sp, fp]

    movz	w23,	#96
    movz	fp,	#1228
    str	w13,	[x9]

    mov	w25,	w23
    ldr	x12,	[sp, fp]

    movz	fp,	#1236
    str	w11,	[x12]

    movz	w11,	#94
    ldr	x15,	[sp, fp]

    mov	w12,	w11
    movz	fp,	#1244
    str	w26,	[x15]

    ldr	x18,	[sp, fp]

    movz	fp,	#1252
    str	w24,	[x18]

    ldr	x21,	[sp, fp]

    movz	fp,	#1260
    str	w12,	[x21]

    movz	w12,	#95
    ldr	x24,	[sp, fp]

    mov	w11,	w12
    movz	fp,	#1268
    str	w11,	[x24]

    movz	w11,	#98
    ldr	x27,	[sp, fp]

    mov	w12,	w11
    movz	fp,	#1276
    str	w25,	[x27]

    movz	w25,	#97
    ldr	x1,	[sp, fp]

    mov	w23,	w25
    movz	fp,	#1284
    str	w23,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#1292
    str	w12,	[x4]

    movz	w12,	#99
    ldr	x7,	[sp, fp]

    mov	w24,	w12
    str	w24,	[x7]

    movz	w24,	#0
    ldr	w3,	[sp, #1832]

    add	w18,	w3,	#1
    str	w18,	[sp, #608]

    ldr	w7,	[sp, #1836]

    str	w24,	[sp, #720]


main_254:
    ldr	w25,	[sp, #720]

    cmp	w25,	#80
    blt	main_258

main_419:
    ldr	w26,	[sp, #720]

    mov	w25,	w7
    mov	w12,	w26

main_421:
    lsl	w11,	w12,	#2
    add	w28,	w12,	#1
    mov	x27,	x11
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    ldr	w27,	[x27]

    str	w28,	[sp, #1352]

    add	w26,	w27,	w25
    ldr	w0,	[sp, #1352]

    lsl	w13,	w0,	#2
    mov	x12,	x13
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w12,	[x12]

    ldr	w1,	[sp, #1352]

    add	w27,	w26,	w12
    add	w3,	w1,	#1
    str	w3,	[sp, #1356]

    ldr	w4,	[sp, #1356]

    lsl	w23,	w4,	#2
    mov	x12,	x23
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w23,	[x12]

    ldr	w5,	[sp, #1356]

    add	w13,	w27,	w23
    add	w9,	w5,	#1
    lsl	w27,	w9,	#2
    mov	x25,	x27
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w25,	[x25]

    add	w24,	w13,	w25
    add	w13,	w9,	#1
    add	w7,	w13,	#1
    lsl	w11,	w13,	#2
    mov	x26,	x11
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w11,	[x26]

    str	w7,	[sp, #1360]

    add	w26,	w24,	w11
    ldr	w8,	[sp, #1360]

    lsl	w12,	w8,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w25,	[x11]

    ldr	w9,	[sp, #1360]

    add	w5,	w26,	w25
    add	w11,	w9,	#1
    str	w11,	[sp, #1372]

    ldr	w12,	[sp, #1372]

    lsl	w25,	w12,	#2
    mov	x13,	x25
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    add	w11,	w5,	w13
    ldr	w13,	[sp, #1372]

    add	w15,	w13,	#1
    str	w15,	[sp, #688]

    ldr	w16,	[sp, #688]

    lsl	w26,	w16,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w13,	[x24]

    ldr	w17,	[sp, #688]

    add	w3,	w11,	w13
    add	w19,	w17,	#1
    cmp	w19,	#96
    blt	main_420

main_457:
    mov	w15,	w19
    mov	w25,	w3
    str	w15,	[sp, #1376]


main_459:
    ldr	w16,	[sp, #1376]

    lsl	w27,	w16,	#2
    mov	x13,	x27
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w12,	[x13]

    add	w19,	w12,	w25
    str	w19,	[sp, #700]

    ldr	w17,	[sp, #1376]

    add	w11,	w17,	#1
    cmp	w11,	#100
    bge	main_467

main_458:
    mov	w18,	w11
    str	w18,	[sp, #1376]

    ldr	w20,	[sp, #700]

    mov	w25,	w20
    b	main_459

main_467:
    movz	w26,	#65535
    ldr	w21,	[sp, #700]

    mov	w25,	w26
    ldr	w22,	[sp, #700]

    sdiv	w12,	w21,	w25
    ldr	w20,	[sp, #608]

    lsl	w26,	w12,	#16
    ldr	w18,	[sp, #1300]

    sub	w12,	w26,	w12,	lsl #0
    sub	w6,	w22,	w12
    cmp	w20,	w18
    blt	main_249

main_471:
    mov	w0,	w6

main_472:
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#328
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2736
    ret


main_249:
    mov	w8,	w6
    str	w8,	[sp, #1836]

    ldr	w20,	[sp, #608]

    mov	w4,	w20
    str	w4,	[sp, #1832]

    b	main_250

main_420:
    mov	w12,	w19
    mov	w25,	w3
    b	main_421

main_258:
    ldr	w27,	[sp, #720]

    lsl	w12,	w27,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w25,	[x11]

    ldr	w28,	[sp, #720]

    add	w11,	w25,	w7
    add	w5,	w28,	#1
    str	w5,	[sp, #1796]

    ldr	w6,	[sp, #1796]

    lsl	w23,	w6,	#2
    mov	x12,	x23
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w13,	[x12]

    ldr	w7,	[sp, #1796]

    add	w14,	w11,	w13
    add	w9,	w7,	#1
    str	w9,	[sp, #1528]

    ldr	w10,	[sp, #1528]

    lsl	w25,	w10,	#2
    mov	x23,	x25
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w13,	[x23]

    ldr	w11,	[sp, #1528]

    add	w26,	w14,	w13
    add	w13,	w11,	#1
    lsl	w11,	w13,	#2
    add	w13,	w13,	#1
    mov	x25,	x11
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w27,	[x25]

    str	w13,	[sp, #1540]

    add	w28,	w26,	w27
    ldr	w14,	[sp, #1540]

    lsl	w12,	w14,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w12,	[x11]

    ldr	w15,	[sp, #1540]

    add	w6,	w28,	w12
    add	w20,	w15,	#1
    str	w20,	[sp, #1388]

    ldr	w21,	[sp, #1388]

    lsl	w23,	w21,	#2
    mov	x12,	x23
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w13,	[x12]

    ldr	w22,	[sp, #1388]

    add	w12,	w6,	w13
    add	w13,	w22,	#1
    add	w24,	w13,	#1
    lsl	w25,	w13,	#2
    mov	x23,	x25
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w27,	[x23]

    str	w24,	[sp, #620]

    add	w27,	w12,	w27
    ldr	w25,	[sp, #620]

    lsl	w11,	w25,	#2
    mov	x25,	x11
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w13,	[x25]

    ldr	w26,	[sp, #620]

    add	w3,	w27,	w13
    add	w17,	w26,	#1
    str	w17,	[sp, #1544]

    ldr	w18,	[sp, #1544]

    lsl	w12,	w18,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w13,	[x11]

    ldr	w19,	[sp, #1544]

    add	w10,	w13,	w3
    add	w21,	w19,	#1
    str	w21,	[sp, #520]

    ldr	w22,	[sp, #520]

    lsl	w23,	w22,	#2
    mov	x12,	x23
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w25,	[x12]

    ldr	w23,	[sp, #520]

    add	w12,	w10,	w25
    add	w13,	w23,	#1
    lsl	w25,	w13,	#2
    add	w13,	w13,	#1
    mov	x23,	x25
    add	x23,	sp,	x23
    lsl	w11,	w13,	#2
    add	x23,	x23,	#16
    ldr	w25,	[x23]

    add	w24,	w12,	w25
    mov	x25,	x11
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w11,	[x25]

    add	w25,	w13,	#1
    add	w28,	w24,	w11
    str	w25,	[sp, #524]

    ldr	w26,	[sp, #524]

    lsl	w12,	w26,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w26,	[x11]

    ldr	w27,	[sp, #524]

    add	w6,	w28,	w26
    add	w1,	w27,	#1
    str	w1,	[sp, #536]

    ldr	w2,	[sp, #536]

    lsl	w23,	w2,	#2
    mov	x12,	x23
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w13,	[x12]

    ldr	w3,	[sp, #536]

    add	w15,	w6,	w13
    add	w5,	w3,	#1
    str	w5,	[sp, #548]

    ldr	w6,	[sp, #548]

    lsl	w26,	w6,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w13,	[x24]

    ldr	w7,	[sp, #548]

    add	w27,	w15,	w13
    add	w13,	w7,	#1
    add	w9,	w13,	#1
    lsl	w11,	w13,	#2
    mov	x25,	x11
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w25,	[x25]

    str	w9,	[sp, #552]

    add	w28,	w27,	w25
    ldr	w10,	[sp, #552]

    lsl	w12,	w10,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w12,	[x11]

    ldr	w11,	[sp, #552]

    add	w3,	w12,	w28
    add	w28,	w11,	#1
    str	w28,	[sp, #632]

    ldr	w0,	[sp, #632]

    lsl	w25,	w0,	#2
    mov	x14,	x25
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w13,	[x14]

    ldr	w1,	[sp, #632]

    add	w12,	w3,	w13
    add	w9,	w1,	#1
    add	w13,	w9,	#1
    lsl	w27,	w9,	#2
    mov	x25,	x27
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w27,	[x25]

    str	w13,	[sp, #564]

    add	w27,	w12,	w27
    ldr	w14,	[sp, #564]

    lsl	w11,	w14,	#2
    mov	x26,	x11
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w12,	[x26]

    ldr	w15,	[sp, #564]

    add	w28,	w27,	w12
    add	w17,	w15,	#1
    str	w17,	[sp, #1304]

    ldr	w18,	[sp, #1304]

    lsl	w13,	w18,	#2
    mov	x12,	x13
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w12,	[x12]

    ldr	w19,	[sp, #1304]

    add	w28,	w28,	w12
    add	w3,	w19,	#1
    str	w3,	[sp, #644]

    ldr	w4,	[sp, #644]

    lsl	w24,	w4,	#2
    mov	x13,	x24
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w24,	[x13]

    ldr	w5,	[sp, #644]

    add	w13,	w28,	w24
    add	w12,	w5,	#1
    add	w9,	w12,	#1
    lsl	w26,	w12,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	w21,	w9,	#1
    lsl	w12,	w9,	#2
    mov	x27,	x12
    add	x24,	x24,	#16
    add	x27,	sp,	x27
    ldr	w24,	[x24]

    add	x27,	x27,	#16
    add	w24,	w13,	w24
    ldr	w12,	[x27]

    str	w21,	[sp, #1308]

    add	w26,	w24,	w12
    ldr	w22,	[sp, #1308]

    lsl	w12,	w22,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w25,	[x11]

    ldr	w23,	[sp, #1308]

    add	w5,	w25,	w26
    add	w25,	w23,	#1
    str	w25,	[sp, #1312]

    ldr	w26,	[sp, #1312]

    lsl	w25,	w26,	#2
    mov	x13,	x25
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w27,	[sp, #1312]

    add	w12,	w5,	w13
    add	w0,	w27,	#1
    str	w0,	[sp, #1316]

    ldr	w1,	[sp, #1316]

    lsl	w27,	w1,	#2
    mov	x25,	x27
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w14,	[x25]

    ldr	w2,	[sp, #1316]

    add	w24,	w12,	w14
    add	w13,	w2,	#1
    add	w4,	w13,	#1
    lsl	w11,	w13,	#2
    mov	x26,	x11
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w26,	[x26]

    str	w4,	[sp, #1320]

    add	w27,	w24,	w26
    ldr	w5,	[sp, #1320]

    lsl	w12,	w5,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w12,	[x11]

    ldr	w6,	[sp, #1320]

    add	w3,	w27,	w12
    add	w7,	w6,	#1
    str	w7,	[sp, #648]

    ldr	w8,	[sp, #648]

    lsl	w25,	w8,	#2
    mov	x14,	x25
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w13,	[x14]

    ldr	w9,	[sp, #648]

    add	w12,	w3,	w13
    add	w13,	w9,	#1
    add	w8,	w13,	#1
    lsl	w26,	w13,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w26,	[x24]

    str	w8,	[sp, #1324]

    add	w27,	w12,	w26
    ldr	w9,	[sp, #1324]

    lsl	w11,	w9,	#2
    mov	x26,	x11
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w12,	[x26]

    ldr	w10,	[sp, #1324]

    add	w28,	w27,	w12
    add	w12,	w10,	#1
    str	w12,	[sp, #1328]

    ldr	w13,	[sp, #1328]

    lsl	w13,	w13,	#2
    mov	x12,	x13
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w12,	[x12]

    ldr	w14,	[sp, #1328]

    add	w3,	w12,	w28
    add	w11,	w14,	#1
    str	w11,	[sp, #668]

    ldr	w12,	[sp, #668]

    lsl	w25,	w12,	#2
    mov	x14,	x25
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w25,	[x14]

    ldr	w13,	[sp, #668]

    add	w12,	w3,	w25
    add	w13,	w13,	#1
    lsl	w26,	w13,	#2
    add	w13,	w13,	#1
    mov	x24,	x26
    add	x24,	sp,	x24
    add	w16,	w13,	#1
    lsl	w11,	w13,	#2
    add	x24,	x24,	#16
    mov	x25,	x11
    add	x25,	sp,	x25
    ldr	w24,	[x24]

    add	x25,	x25,	#16
    add	w24,	w12,	w24
    ldr	w11,	[x25]

    str	w16,	[sp, #1332]

    add	w27,	w24,	w11
    ldr	w17,	[sp, #1332]

    lsl	w12,	w17,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w25,	[x11]

    ldr	w18,	[sp, #1332]

    add	w3,	w27,	w25
    add	w20,	w18,	#1
    str	w20,	[sp, #1336]

    ldr	w21,	[sp, #1336]

    lsl	w25,	w21,	#2
    mov	x13,	x25
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w22,	[sp, #1336]

    add	w12,	w3,	w13
    add	w24,	w22,	#1
    str	w24,	[sp, #1348]

    ldr	w25,	[sp, #1348]

    lsl	w27,	w25,	#2
    mov	x25,	x27
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w14,	[x25]

    ldr	w26,	[sp, #1348]

    add	w24,	w12,	w14
    add	w9,	w26,	#1
    add	w13,	w9,	#1
    lsl	w12,	w9,	#2
    mov	w0,	w13
    mov	x27,	x12
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    ldr	w27,	[x27]

    str	w0,	[sp, #720]

    add	w24,	w24,	w27
    mov	w7,	w24
    b	main_254

main_120:
    mov	w0,	w15
    b	main_121

main_6:
    lsl	w25,	w8,	#2
    movz	w17,	#0
    add	w5,	w8,	#1
    movz	w18,	#0
    movz	w19,	#0
    movz	w20,	#0
    movz	w22,	#0
    movz	w23,	#0
    movz	w24,	#0
    movz	w27,	#0
    movz	w4,	#0
    mov	x0,	x25
    mov	w11,	w17
    add	w12,	w5,	#1
    lsl	w28,	w5,	#2
    mov	w9,	w18
    mov	w7,	w19
    mov	w1,	w22
    mov	w26,	w24
    movz	w25,	#0
    add	x0,	sp,	x0
    add	w21,	w12,	#1
    lsl	w2,	w12,	#2
    mov	x3,	x28
    mov	x6,	x2
    mov	w28,	w23
    add	x0,	x0,	#16
    add	w18,	w21,	#1
    lsl	w5,	w21,	#2
    add	x3,	sp,	x3
    add	x6,	sp,	x6
    movz	w23,	#0
    str	w11,	[x0]

    lsl	w8,	w18,	#2
    movz	w21,	#0
    add	x3,	x3,	#16
    add	x6,	x6,	#16
    mov	w24,	w23
    mov	x11,	x5
    mov	x14,	x8
    str	w9,	[x3]

    mov	w5,	w20
    add	x11,	sp,	x11
    add	x14,	sp,	x14
    mov	w3,	w21
    str	w7,	[x6]

    add	w21,	w18,	#1
    add	x11,	x11,	#16
    add	x14,	x14,	#16
    add	w22,	w21,	#1
    str	w5,	[x11]

    lsl	w11,	w21,	#2
    str	w3,	[x14]

    mov	x17,	x11
    lsl	w14,	w22,	#2
    add	x17,	sp,	x17
    mov	x18,	x14
    add	x18,	sp,	x18
    add	x17,	x17,	#16
    add	x18,	x18,	#16
    str	w1,	[x17]

    movz	w1,	#0
    str	w28,	[x18]

    add	w28,	w22,	#1
    mov	w22,	w25
    add	w3,	w28,	#1
    lsl	w17,	w28,	#2
    movz	w28,	#0
    mov	x21,	x17
    mov	w18,	w28
    add	x21,	sp,	x21
    lsl	w20,	w3,	#2
    add	w3,	w3,	#1
    add	x21,	x21,	#16
    add	w13,	w3,	#1
    lsl	w23,	w3,	#2
    str	w26,	[x21]

    mov	x0,	x23
    mov	x26,	x20
    add	x0,	sp,	x0
    add	w12,	w13,	#1
    mov	w20,	w27
    add	x26,	sp,	x26
    add	x0,	x0,	#16
    add	w17,	w12,	#1
    add	x26,	x26,	#16
    lsl	w3,	w17,	#2
    str	w24,	[x26]

    mov	x8,	x3
    lsl	w26,	w13,	#2
    str	w22,	[x0]

    movz	w3,	#0
    add	x8,	sp,	x8
    mov	x2,	x26
    add	w22,	w17,	#1
    lsl	w0,	w12,	#2
    add	x2,	sp,	x2
    add	x8,	x8,	#16
    mov	w12,	w1
    add	w25,	w22,	#1
    lsl	w6,	w22,	#2
    mov	x5,	x0
    add	x2,	x2,	#16
    mov	x11,	x6
    movz	w0,	#0
    add	w28,	w25,	#1
    lsl	w9,	w25,	#2
    add	x5,	sp,	x5
    str	w20,	[x2]

    mov	w6,	w4
    add	x11,	sp,	x11
    mov	w16,	w0
    movz	w2,	#0
    add	x5,	x5,	#16
    movz	w0,	#0
    add	x11,	x11,	#16
    mov	w10,	w2
    mov	w14,	w0
    add	w2,	w28,	#1
    str	w18,	[x5]

    movz	w5,	#0
    str	w16,	[x8]

    add	w1,	w2,	#1
    lsl	w15,	w2,	#2
    mov	w4,	w5
    mov	w8,	w3
    mov	x16,	x9
    str	w14,	[x11]

    lsl	w18,	w1,	#2
    mov	x22,	x15
    movz	w9,	#0
    add	x16,	sp,	x16
    movz	w14,	#0
    movz	w11,	#0
    mov	x25,	x18
    add	x22,	sp,	x22
    mov	w0,	w9
    add	x16,	x16,	#16
    mov	w15,	w14
    movz	w18,	#0
    add	x25,	sp,	x25
    add	x22,	x22,	#16
    movz	w9,	#0
    str	w12,	[x16]

    lsl	w12,	w28,	#2
    add	x25,	x25,	#16
    mov	x19,	x12
    movz	w12,	#0
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    str	w10,	[x19]

    movz	w10,	#0
    str	w8,	[x22]

    add	w8,	w1,	#1
    str	w6,	[x25]

    mov	w25,	w9
    add	w13,	w8,	#1
    lsl	w21,	w8,	#2
    movz	w8,	#0
    mov	x28,	x21
    mov	w2,	w8
    mov	w21,	w11
    add	w16,	w13,	#1
    lsl	w24,	w13,	#2
    add	x28,	sp,	x28
    mov	x1,	x24
    add	x1,	sp,	x1
    add	w19,	w16,	#1
    lsl	w27,	w16,	#2
    add	x28,	x28,	#16
    mov	x6,	x27
    add	x1,	x1,	#16
    mov	w27,	w10
    add	w22,	w19,	#1
    add	x6,	sp,	x6
    str	w4,	[x28]

    str	w2,	[x1]

    add	w26,	w22,	#1
    add	x6,	x6,	#16
    lsl	w4,	w22,	#2
    lsl	w1,	w19,	#2
    mov	x10,	x4
    mov	w19,	w12
    str	w0,	[x6]

    mov	x7,	x1
    add	x10,	sp,	x10
    add	w1,	w26,	#1
    add	x7,	sp,	x7
    add	x10,	x10,	#16
    add	w0,	w1,	#1
    add	x7,	x7,	#16
    add	w3,	w0,	#1
    str	w27,	[x7]

    lsl	w7,	w26,	#2
    str	w25,	[x10]

    add	w6,	w3,	#1
    mov	x13,	x7
    movz	w10,	#0
    add	x13,	sp,	x13
    mov	w23,	w10
    add	w11,	w6,	#1
    lsl	w10,	w1,	#2
    add	x13,	x13,	#16
    mov	x16,	x10
    add	x16,	sp,	x16
    lsl	w22,	w11,	#2
    str	w23,	[x13]

    add	x16,	x16,	#16
    movz	w23,	#0
    lsl	w13,	w0,	#2
    mov	w1,	w23
    mov	x0,	x22
    movz	w23,	#0
    str	w21,	[x16]

    movz	w22,	#0
    add	x0,	sp,	x0
    lsl	w16,	w3,	#2
    mov	x21,	x13
    mov	x24,	x16
    movz	w13,	#0
    add	x21,	sp,	x21
    add	x0,	x0,	#16
    add	w16,	w11,	#1
    add	x24,	sp,	x24
    mov	w17,	w13
    add	x21,	x21,	#16
    mov	w11,	w18
    lsl	w25,	w16,	#2
    add	w20,	w16,	#1
    add	x24,	x24,	#16
    mov	x3,	x25
    str	w19,	[x21]

    movz	w25,	#0
    add	w26,	w20,	#1
    lsl	w28,	w20,	#2
    add	x3,	sp,	x3
    movz	w21,	#0
    lsl	w19,	w6,	#2
    str	w17,	[x24]

    lsl	w2,	w26,	#2
    movz	w20,	#0
    add	x3,	x3,	#16
    mov	x6,	x28
    mov	x27,	x19
    movz	w24,	#0
    movz	w17,	#0
    mov	w7,	w20
    add	x6,	sp,	x6
    movz	w19,	#0
    add	x27,	sp,	x27
    mov	w28,	w24
    mov	w13,	w17
    mov	w9,	w19
    add	x6,	x6,	#16
    add	x27,	x27,	#16
    str	w15,	[x27]

    movz	w27,	#0
    str	w13,	[x0]

    str	w11,	[x3]

    mov	w3,	w22
    mov	x11,	x2
    str	w9,	[x6]

    mov	w22,	w27
    add	w2,	w26,	#1
    add	x11,	sp,	x11
    mov	w26,	w23
    add	w4,	w2,	#1
    lsl	w5,	w2,	#2
    add	x11,	x11,	#16
    mov	x14,	x5
    mov	w5,	w21
    add	x14,	sp,	x14
    lsl	w8,	w4,	#2
    str	w7,	[x11]

    add	w4,	w4,	#1
    add	x14,	x14,	#16
    mov	x17,	x8
    add	x17,	sp,	x17
    lsl	w11,	w4,	#2
    str	w5,	[x14]

    mov	x20,	x11
    add	x17,	x17,	#16
    add	w5,	w4,	#1
    add	x20,	sp,	x20
    str	w3,	[x17]

    add	w8,	w5,	#1
    lsl	w14,	w5,	#2
    add	x20,	x20,	#16
    mov	x21,	x14
    add	w15,	w8,	#1
    lsl	w17,	w8,	#2
    str	w1,	[x20]

    add	x21,	sp,	x21
    mov	x24,	x17
    movz	w1,	#0
    add	w16,	w15,	#1
    lsl	w20,	w15,	#2
    add	x21,	x21,	#16
    add	x24,	sp,	x24
    mov	w14,	w1
    mov	x0,	x20
    add	w19,	w16,	#1
    lsl	w23,	w16,	#2
    str	w28,	[x21]

    add	x24,	x24,	#16
    add	x0,	sp,	x0
    mov	x2,	x23
    movz	w28,	#0
    add	x2,	sp,	x2
    str	w26,	[x24]

    mov	w20,	w28
    add	x0,	x0,	#16
    lsl	w26,	w19,	#2
    add	x2,	x2,	#16
    mov	w24,	w25
    mov	x5,	x26
    str	w24,	[x0]

    add	w26,	w19,	#1
    add	x5,	sp,	x5
    str	w22,	[x2]

    movz	w2,	#0
    add	w4,	w26,	#1
    lsl	w0,	w26,	#2
    add	x5,	x5,	#16
    mov	w12,	w2
    mov	x8,	x0
    lsl	w3,	w4,	#2
    movz	w0,	#0
    str	w20,	[x5]

    add	x8,	sp,	x8
    mov	x11,	x3
    mov	w18,	w0
    movz	w5,	#0
    add	w3,	w4,	#1
    add	x8,	x8,	#16
    add	x11,	sp,	x11
    movz	w0,	#0
    movz	w4,	#0
    lsl	w6,	w3,	#2
    mov	w16,	w0
    str	w18,	[x8]

    add	x11,	x11,	#16
    mov	w8,	w4
    str	w16,	[x11]

    movz	w11,	#0
    mov	x16,	x6
    add	w6,	w3,	#1
    add	x16,	sp,	x16
    movz	w3,	#0
    mov	w10,	w3
    lsl	w9,	w6,	#2
    add	x16,	x16,	#16
    mov	x19,	x9
    add	w9,	w6,	#1
    add	x19,	sp,	x19
    str	w14,	[x16]

    mov	w6,	w5
    add	x19,	x19,	#16
    add	w14,	w9,	#1
    str	w12,	[x19]

    add	w17,	w14,	#1
    lsl	w15,	w14,	#2
    lsl	w12,	w9,	#2
    movz	w14,	#0
    mov	x25,	x15
    add	w23,	w17,	#1
    lsl	w18,	w17,	#2
    movz	w9,	#0
    mov	x22,	x12
    add	x25,	sp,	x25
    mov	w17,	w14
    mov	x28,	x18
    add	w26,	w23,	#1
    lsl	w21,	w23,	#2
    mov	w2,	w9
    movz	w12,	#0
    add	x22,	sp,	x22
    add	x25,	x25,	#16
    add	x28,	sp,	x28
    lsl	w24,	w26,	#2
    mov	w23,	w11
    mov	x1,	x21
    add	x22,	x22,	#16
    add	x28,	x28,	#16
    mov	w21,	w12
    add	x1,	sp,	x1
    str	w10,	[x22]

    movz	w10,	#0
    str	w8,	[x25]

    add	x1,	x1,	#16
    mov	w0,	w10
    movz	w8,	#0
    str	w6,	[x28]

    mov	w4,	w8
    mov	x6,	x24
    str	w4,	[x1]

    add	x6,	sp,	x6
    add	w1,	w26,	#1
    add	x6,	x6,	#16
    lsl	w27,	w1,	#2
    mov	x9,	x27
    str	w2,	[x6]

    add	x9,	sp,	x9
    add	x9,	x9,	#16
    str	w0,	[x9]

    movz	w9,	#0
    add	w0,	w1,	#1
    mov	w27,	w9
    add	w3,	w0,	#1
    lsl	w1,	w0,	#2
    mov	x10,	x1
    add	x10,	sp,	x10
    add	w6,	w3,	#1
    lsl	w4,	w3,	#2
    mov	x13,	x4
    add	x10,	x10,	#16
    add	x13,	sp,	x13
    add	w9,	w6,	#1
    lsl	w7,	w6,	#2
    mov	x16,	x7
    str	w27,	[x10]

    add	x13,	x13,	#16
    add	w15,	w9,	#1
    add	x16,	sp,	x16
    movz	w10,	#0
    mov	w25,	w10
    add	x16,	x16,	#16
    lsl	w10,	w9,	#2
    str	w25,	[x13]

    mov	x19,	x10
    lsl	w13,	w15,	#2
    add	x19,	sp,	x19
    str	w23,	[x16]

    mov	x24,	x13
    movz	w13,	#0
    add	x24,	sp,	x24
    add	x19,	x19,	#16
    add	x24,	x24,	#16
    str	w21,	[x19]

    add	w21,	w15,	#1
    mov	w19,	w13
    str	w19,	[x24]

    lsl	w16,	w21,	#2
    mov	x27,	x16
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    str	w17,	[x27]

    add	w17,	w21,	#1
    mov	w8,	w17
    b	main_3

