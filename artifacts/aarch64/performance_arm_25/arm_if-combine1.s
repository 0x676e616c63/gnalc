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
    sub	sp, sp, #2752
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#324
    bl	_sysy_starttime
    bl	getint
    movz	w17,	#0
    str	w0,	[sp, #1212]

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
    ldr	w18,	[sp, #1212]

    mov	w8,	w27
    cmp	w8,	w18
    blt	main_149

main_470:
    movz	w0,	#0
    b	main_472

main_149:
    add	x20,	sp,	#20
    add	x26,	sp,	#24
    add	x22,	sp,	#28
    add	x15,	sp,	#32
    add	x12,	sp,	#36
    add	x28,	sp,	#40
    add	x16,	sp,	#44
    add	x18,	sp,	#48
    add	x11,	sp,	#52
    add	x17,	sp,	#56
    add	x3,	sp,	#60
    add	x21,	sp,	#64
    add	x27,	sp,	#68
    add	x5,	sp,	#72
    add	x2,	sp,	#76
    add	x25,	sp,	#80
    add	x19,	sp,	#84
    add	x0,	sp,	#88
    add	x24,	sp,	#92
    add	x6,	sp,	#96
    add	x9,	sp,	#100
    add	x14,	sp,	#104
    add	x13,	sp,	#108
    add	x10,	sp,	#112
    add	x8,	sp,	#116
    add	x23,	sp,	#120
    movz	fp,	#716
    add	x1,	sp,	#212
    add	x4,	sp,	#216
    add	x7,	sp,	#220
    str	x20,	[sp, #1936]

    add	x20,	sp,	#160
    str	x26,	[sp, #1968]

    add	x26,	sp,	#168
    str	x22,	[sp, #1808]

    add	x22,	sp,	#124
    str	x15,	[sp, #2032]

    add	x15,	sp,	#192
    str	x12,	[sp, #2016]

    add	x12,	sp,	#188
    str	x28,	[sp, #1832]

    add	x28,	sp,	#132
    str	x16,	[sp, #1784]

    add	x16,	sp,	#232
    str	x18,	[sp, #2048]

    add	x18,	sp,	#196
    str	x11,	[sp, #1880]

    add	x11,	sp,	#148
    str	x17,	[sp, #1920]

    add	x17,	sp,	#156
    str	x3,	[sp, #1984]

    add	x3,	sp,	#176
    str	x21,	[sp, #2056]

    add	x21,	sp,	#200
    str	x27,	[sp, #2080]

    add	x27,	sp,	#208
    str	x5,	[sp, #1864]

    add	x5,	sp,	#140
    str	x2,	[sp, #1848]

    add	x2,	sp,	#136
    str	x25,	[sp, #1816]

    add	x25,	sp,	#128
    str	x19,	[sp, #1800]

    add	x19,	sp,	#236
    str	x0,	[sp, #1976]

    add	x0,	sp,	#172
    str	x24,	[sp, #2072]

    add	x24,	sp,	#204
    str	x6,	[sp, #2000]

    add	x6,	sp,	#180
    str	x9,	[sp, #2008]

    add	x9,	sp,	#184
    str	x14,	[sp, #1896]

    add	x14,	sp,	#152
    str	x13,	[sp, #1768]

    add	x13,	sp,	#228
    str	x10,	[sp, #1760]

    add	x10,	sp,	#224
    str	x8,	[sp, #1872]

    add	x8,	sp,	#144
    str	x23,	[sp, #1952]

    add	x23,	sp,	#164
    str	x22,	[sp, #560]

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
    movz	fp,	#724
    str	x11,	[sp, fp]

    add	x11,	sp,	#264
    movz	fp,	#732
    str	x14,	[sp, fp]

    add	x14,	sp,	#268
    movz	fp,	#740
    str	x17,	[sp, fp]

    add	x17,	sp,	#272
    movz	fp,	#748
    str	x20,	[sp, fp]

    add	x20,	sp,	#276
    movz	fp,	#756
    str	x23,	[sp, fp]

    add	x23,	sp,	#280
    movz	fp,	#764
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#772
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#780
    str	x3,	[sp, fp]

    add	x3,	sp,	#292
    movz	fp,	#788
    str	x6,	[sp, fp]

    add	x6,	sp,	#296
    movz	fp,	#796
    str	x9,	[sp, fp]

    add	x9,	sp,	#300
    movz	fp,	#804
    str	x12,	[sp, fp]

    add	x12,	sp,	#304
    movz	fp,	#812
    str	x15,	[sp, fp]

    add	x15,	sp,	#308
    movz	fp,	#820
    str	x18,	[sp, fp]

    add	x18,	sp,	#312
    movz	fp,	#828
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#836
    str	x24,	[sp, fp]

    add	x24,	sp,	#320
    movz	fp,	#844
    str	x27,	[sp, fp]

    add	x27,	sp,	#324
    movz	fp,	#852
    str	x1,	[sp, fp]

    add	x1,	sp,	#328
    movz	fp,	#876
    str	x4,	[sp, fp]

    add	x4,	sp,	#332
    movz	fp,	#884
    str	x7,	[sp, fp]

    add	x7,	sp,	#336
    movz	fp,	#892
    str	x10,	[sp, fp]

    add	x10,	sp,	#340
    movz	fp,	#900
    str	x13,	[sp, fp]

    add	x13,	sp,	#344
    movz	fp,	#860
    str	x16,	[sp, fp]

    movz	fp,	#908
    add	x16,	sp,	#348
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
    movz	fp,	#916
    str	x14,	[sp, fp]

    add	x14,	sp,	#384
    movz	fp,	#924
    str	x17,	[sp, fp]

    add	x17,	sp,	#388
    movz	fp,	#932
    str	x20,	[sp, fp]

    add	x20,	sp,	#392
    movz	fp,	#940
    str	x23,	[sp, fp]

    add	x23,	sp,	#396
    movz	fp,	#948
    str	x26,	[sp, fp]

    add	x26,	sp,	#400
    movz	fp,	#956
    str	x0,	[sp, fp]

    add	x0,	sp,	#404
    movz	fp,	#964
    str	x3,	[sp, fp]

    add	x3,	sp,	#408
    movz	fp,	#972
    str	x6,	[sp, fp]

    add	x6,	sp,	#412
    movz	fp,	#980
    str	x9,	[sp, fp]

    movz	fp,	#988
    str	x12,	[sp, fp]

    movz	fp,	#996
    str	x15,	[sp, fp]

    movz	fp,	#1004
    str	x18,	[sp, fp]

    movz	fp,	#1012
    str	x21,	[sp, fp]

    movz	fp,	#1020
    str	x24,	[sp, fp]

    movz	fp,	#1028
    str	x27,	[sp, fp]

    movz	fp,	#1036
    str	x1,	[sp, fp]

    movz	fp,	#1044
    str	x4,	[sp, fp]

    movz	fp,	#1052
    str	x7,	[sp, fp]

    movz	fp,	#1060
    str	x10,	[sp, fp]

    movz	w10,	#0
    movz	fp,	#1068
    str	x13,	[sp, fp]

    movz	fp,	#1076
    str	x16,	[sp, fp]

    movz	fp,	#1084
    str	x19,	[sp, fp]

    movz	fp,	#1092
    str	x22,	[sp, fp]

    movz	fp,	#1100
    str	x25,	[sp, fp]

    movz	fp,	#1108
    str	x28,	[sp, fp]

    movz	fp,	#1116
    str	x2,	[sp, fp]

    movz	fp,	#1124
    str	x5,	[sp, fp]

    movz	fp,	#1132
    str	x8,	[sp, fp]

    movz	fp,	#1140
    str	x11,	[sp, fp]

    movz	fp,	#1148
    str	x14,	[sp, fp]

    movz	fp,	#1156
    str	x17,	[sp, fp]

    movz	fp,	#1164
    str	x20,	[sp, fp]

    movz	w20,	#0
    movz	fp,	#1172
    mov	w2,	w20
    str	x23,	[sp, fp]

    movz	fp,	#1180
    str	x26,	[sp, fp]

    movz	fp,	#1188
    str	x0,	[sp, fp]

    movz	fp,	#1196
    str	x3,	[sp, fp]

    movz	fp,	#1204
    str	x6,	[sp, fp]

    mov	w6,	w10
    str	w6,	[sp, #1756]

    str	w2,	[sp, #1744]


main_250:
    movz	w23,	#1
    ldr	x21,	[sp, #1936]

    movz	w9,	#2
    movz	fp,	#716
    mov	w20,	w23
    mov	w10,	w9
    str	w20,	[x21]

    movz	w20,	#4
    ldr	x27,	[sp, #1968]

    mov	w24,	w20
    str	w10,	[x27]

    movz	w20,	#8
    ldr	x23,	[sp, #1808]

    movz	w10,	#3
    mov	w9,	w10
    movz	w10,	#7
    str	w9,	[x23]

    movz	w9,	#6
    movz	w23,	#5
    ldr	x16,	[sp, #2032]

    mov	w11,	w9
    mov	w22,	w23
    str	w24,	[x16]

    mov	w9,	w10
    movz	w23,	#9
    mov	w24,	w20
    ldr	x13,	[sp, #2016]

    movz	w20,	#12
    str	w22,	[x13]

    mov	w22,	w23
    ldr	x0,	[sp, #1832]

    movz	w23,	#13
    str	w11,	[x0]

    ldr	x17,	[sp, #1784]

    str	w9,	[x17]

    movz	w9,	#10
    ldr	x19,	[sp, #2048]

    mov	w10,	w9
    str	w24,	[x19]

    mov	w24,	w20
    ldr	x12,	[sp, #1880]

    mov	w20,	w23
    str	w22,	[x12]

    ldr	x18,	[sp, #1920]

    str	w10,	[x18]

    ldr	x4,	[sp, #1984]

    movz	w10,	#11
    mov	w9,	w10
    movz	w10,	#15
    str	w9,	[x4]

    movz	w9,	#14
    ldr	x22,	[sp, #2056]

    mov	w11,	w9
    str	w24,	[x22]

    movz	w9,	#18
    ldr	x28,	[sp, #2080]

    str	w20,	[x28]

    movz	w20,	#16
    ldr	x6,	[sp, #1864]

    mov	w23,	w20
    str	w11,	[x6]

    mov	w11,	w9
    ldr	x3,	[sp, #1848]

    str	w10,	[x3]

    movz	w10,	#19
    ldr	x26,	[sp, #1816]

    mov	w9,	w10
    str	w23,	[x26]

    ldr	x20,	[sp, #1800]

    movz	w23,	#17
    mov	w22,	w23
    movz	w23,	#21
    str	w22,	[x20]

    mov	w22,	w23
    movz	w20,	#20
    ldr	x1,	[sp, #1976]

    movz	w23,	#25
    mov	w24,	w20
    str	w11,	[x1]

    movz	w20,	#24
    ldr	x25,	[sp, #2072]

    str	w9,	[x25]

    movz	w9,	#22
    ldr	x7,	[sp, #2000]

    str	w24,	[x7]

    mov	w24,	w20
    ldr	x10,	[sp, #2008]

    movz	w20,	#28
    str	w22,	[x10]

    mov	w22,	w23
    ldr	x15,	[sp, #1896]

    mov	w10,	w9
    mov	w23,	w20
    str	w10,	[x15]

    ldr	x14,	[sp, #1768]

    movz	w10,	#23
    mov	w9,	w10
    str	w9,	[x14]

    ldr	x11,	[sp, #1760]

    str	w24,	[x11]

    ldr	x9,	[sp, #1872]

    str	w22,	[x9]

    ldr	x24,	[sp, #1952]

    movz	w9,	#26
    mov	w10,	w9
    str	w10,	[x24]

    ldr	x22,	[sp, #560]

    movz	w10,	#27
    mov	w9,	w10
    str	w9,	[x22]

    movz	w9,	#30
    ldr	x25,	[sp, #568]

    mov	w10,	w9
    str	w23,	[x25]

    ldr	x28,	[sp, #576]

    movz	w23,	#29
    mov	w20,	w23
    movz	w23,	#33
    str	w20,	[x28]

    mov	w22,	w23
    movz	w20,	#32
    ldr	x2,	[sp, #584]

    mov	w24,	w20
    str	w10,	[x2]

    movz	w20,	#36
    ldr	x5,	[sp, #592]

    movz	w10,	#31
    mov	w23,	w20
    mov	w9,	w10
    str	w9,	[x5]

    movz	w9,	#34
    ldr	x8,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#724
    str	w24,	[x8]

    ldr	x11,	[sp, fp]

    movz	fp,	#732
    str	w22,	[x11]

    ldr	x15,	[sp, fp]

    movz	fp,	#740
    str	w10,	[x15]

    movz	w10,	#35
    ldr	x18,	[sp, fp]

    mov	w9,	w10
    movz	fp,	#748
    str	w9,	[x18]

    movz	w9,	#38
    ldr	x21,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#756
    str	w23,	[x21]

    movz	w9,	#42
    movz	w23,	#37
    ldr	x24,	[sp, fp]

    mov	w20,	w23
    movz	fp,	#764
    str	w20,	[x24]

    movz	w20,	#40
    ldr	x27,	[sp, fp]

    mov	w23,	w20
    movz	fp,	#772
    str	w10,	[x27]

    movz	w20,	#44
    movz	w10,	#39
    ldr	x1,	[sp, fp]

    mov	w24,	w20
    movz	fp,	#780
    str	w10,	[x1]

    mov	w10,	w9
    ldr	x4,	[sp, fp]

    movz	fp,	#788
    str	w23,	[x4]

    movz	w23,	#41
    ldr	x7,	[sp, fp]

    mov	w22,	w23
    movz	fp,	#796
    movz	w23,	#45
    str	w22,	[x7]

    mov	w22,	w23
    ldr	x11,	[sp, fp]

    movz	fp,	#804
    str	w10,	[x11]

    movz	w10,	#43
    ldr	x14,	[sp, fp]

    mov	w9,	w10
    movz	fp,	#812
    str	w9,	[x14]

    movz	w9,	#46
    ldr	x16,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#820
    str	w24,	[x16]

    ldr	x20,	[sp, fp]

    movz	fp,	#828
    str	w22,	[x20]

    movz	w20,	#48
    ldr	x23,	[sp, fp]

    mov	w24,	w20
    movz	fp,	#836
    str	w10,	[x23]

    movz	w20,	#52
    movz	w23,	#49
    ldr	x26,	[sp, fp]

    movz	w10,	#47
    mov	w22,	w23
    movz	fp,	#844
    mov	w9,	w10
    movz	w23,	#53
    movz	w10,	#51
    str	w9,	[x26]

    movz	w9,	#50
    ldr	x0,	[sp, fp]

    mov	w11,	w9
    movz	fp,	#852
    str	w24,	[x0]

    mov	w9,	w10
    mov	w24,	w20
    ldr	x3,	[sp, fp]

    movz	w20,	#56
    movz	fp,	#876
    str	w22,	[x3]

    mov	w22,	w23
    ldr	x6,	[sp, fp]

    mov	w23,	w20
    movz	fp,	#884
    str	w11,	[x6]

    ldr	x10,	[sp, fp]

    movz	fp,	#892
    str	w9,	[x10]

    movz	w9,	#54
    ldr	x12,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#900
    str	w24,	[x12]

    ldr	x15,	[sp, fp]

    movz	fp,	#860
    str	w22,	[x15]

    ldr	x19,	[sp, fp]

    movz	fp,	#908
    str	w10,	[x19]

    ldr	x22,	[sp, #416]

    movz	w10,	#55
    mov	w9,	w10
    movz	w10,	#59
    str	w9,	[x22]

    movz	w9,	#58
    ldr	x25,	[sp, #424]

    mov	w11,	w9
    str	w23,	[x25]

    ldr	x28,	[sp, #432]

    movz	w23,	#57
    mov	w20,	w23
    movz	w23,	#61
    str	w20,	[x28]

    movz	w20,	#60
    ldr	x0,	[sp, #440]

    mov	w22,	w20
    str	w11,	[x0]

    movz	w20,	#64
    ldr	x3,	[sp, #448]

    mov	w24,	w20
    str	w10,	[x3]

    ldr	x6,	[sp, #456]

    str	w22,	[x6]

    ldr	x9,	[sp, #464]

    mov	w22,	w23
    movz	w23,	#65
    str	w22,	[x9]

    mov	w20,	w23
    ldr	x12,	[sp, fp]

    movz	w9,	#62
    movz	w23,	#69
    movz	fp,	#916
    mov	w10,	w9
    str	w10,	[x12]

    ldr	x15,	[sp, fp]

    movz	w10,	#63
    movz	fp,	#924
    mov	w9,	w10
    str	w9,	[x15]

    movz	w9,	#66
    ldr	x18,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#932
    str	w24,	[x18]

    ldr	x21,	[sp, fp]

    movz	fp,	#940
    str	w20,	[x21]

    movz	w20,	#68
    ldr	x24,	[sp, fp]

    movz	fp,	#948
    str	w10,	[x24]

    mov	w24,	w20
    movz	w10,	#67
    ldr	x27,	[sp, fp]

    mov	w20,	w23
    mov	w9,	w10
    movz	fp,	#956
    movz	w23,	#73
    str	w9,	[x27]

    mov	w22,	w23
    movz	w9,	#70
    ldr	x1,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#964
    str	w24,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#972
    str	w20,	[x4]

    movz	w20,	#72
    ldr	x7,	[sp, fp]

    mov	w24,	w20
    movz	fp,	#980
    str	w10,	[x7]

    movz	w20,	#76
    movz	w10,	#71
    mov	w23,	w20
    mov	w9,	w10
    ldr	x10,	[sp, fp]

    movz	fp,	#988
    str	w9,	[x10]

    movz	w10,	#75
    movz	w9,	#74
    ldr	x13,	[sp, fp]

    movz	fp,	#996
    str	w24,	[x13]

    ldr	x16,	[sp, fp]

    movz	fp,	#1004
    str	w22,	[x16]

    mov	w22,	w9
    ldr	x19,	[sp, fp]

    mov	w9,	w10
    movz	fp,	#1012
    str	w22,	[x19]

    ldr	x22,	[sp, fp]

    movz	fp,	#1020
    str	w9,	[x22]

    movz	w9,	#78
    ldr	x25,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#1028
    str	w23,	[x25]

    movz	w23,	#77
    ldr	x28,	[sp, fp]

    mov	w20,	w23
    movz	fp,	#1036
    movz	w23,	#81
    str	w20,	[x28]

    mov	w22,	w23
    movz	w20,	#80
    ldr	x2,	[sp, fp]

    movz	w23,	#85
    mov	w24,	w20
    movz	fp,	#1044
    str	w10,	[x2]

    movz	w20,	#84
    movz	w10,	#79
    ldr	x5,	[sp, fp]

    mov	w9,	w10
    movz	fp,	#1052
    str	w9,	[x5]

    movz	w9,	#82
    ldr	x8,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#1060
    str	w24,	[x8]

    movz	w9,	#86
    ldr	x11,	[sp, fp]

    movz	fp,	#1068
    str	w22,	[x11]

    ldr	x14,	[sp, fp]

    movz	fp,	#1076
    str	w10,	[x14]

    movz	w10,	#83
    ldr	x17,	[sp, fp]

    mov	w24,	w10
    movz	fp,	#1084
    mov	w10,	w9
    str	w24,	[x17]

    movz	w9,	#90
    mov	w24,	w20
    mov	w11,	w9
    ldr	x20,	[sp, fp]

    movz	fp,	#1092
    str	w24,	[x20]

    mov	w20,	w23
    ldr	x23,	[sp, fp]

    movz	fp,	#1100
    str	w20,	[x23]

    movz	w23,	#89
    movz	w20,	#88
    ldr	x26,	[sp, fp]

    mov	w24,	w20
    movz	fp,	#1108
    str	w10,	[x26]

    movz	w20,	#92
    movz	w10,	#87
    ldr	x0,	[sp, fp]

    movz	fp,	#1116
    str	w10,	[x0]

    movz	w10,	#91
    ldr	x3,	[sp, fp]

    movz	fp,	#1124
    str	w24,	[x3]

    mov	w24,	w23
    ldr	x6,	[sp, fp]

    movz	w23,	#93
    movz	fp,	#1132
    str	w24,	[x6]

    mov	w22,	w23
    mov	w24,	w20
    ldr	x9,	[sp, fp]

    movz	w20,	#96
    movz	fp,	#1140
    str	w11,	[x9]

    mov	w23,	w20
    mov	w9,	w10
    ldr	x12,	[sp, fp]

    movz	fp,	#1148
    str	w9,	[x12]

    movz	w9,	#94
    ldr	x15,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#1156
    str	w24,	[x15]

    ldr	x18,	[sp, fp]

    movz	fp,	#1164
    str	w22,	[x18]

    ldr	x21,	[sp, fp]

    movz	fp,	#1172
    str	w10,	[x21]

    movz	w10,	#95
    ldr	x24,	[sp, fp]

    mov	w9,	w10
    movz	fp,	#1180
    str	w9,	[x24]

    movz	w9,	#98
    ldr	x27,	[sp, fp]

    mov	w10,	w9
    movz	fp,	#1188
    str	w23,	[x27]

    movz	w23,	#97
    ldr	x1,	[sp, fp]

    mov	w22,	w23
    movz	fp,	#1196
    str	w22,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#1204
    str	w10,	[x4]

    movz	w10,	#99
    ldr	x7,	[sp, fp]

    mov	w22,	w10
    str	w22,	[x7]

    movz	w22,	#0
    ldr	w3,	[sp, #1744]

    mov	w24,	w22
    add	w18,	w3,	#1
    str	w18,	[sp, #556]

    ldr	w7,	[sp, #1756]

    str	w24,	[sp, #1616]

    mov	w6,	w7

main_254:
    ldr	w25,	[sp, #1616]

    cmp	w25,	#80
    blt	main_258

main_419:
    ldr	w26,	[sp, #1616]

    mov	w23,	w6
    mov	w10,	w26

main_421:
    lsl	w9,	w10,	#2
    add	w20,	w10,	#1
    mov	x25,	x9
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w25,	[x25]

    str	w20,	[sp, #608]

    add	w25,	w25,	w23
    ldr	w21,	[sp, #608]

    lsl	w11,	w21,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w22,	[sp, #608]

    add	w28,	w25,	w10
    add	w24,	w22,	#1
    str	w24,	[sp, #612]

    ldr	w25,	[sp, #612]

    lsl	w22,	w25,	#2
    mov	x11,	x22
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w22,	[x11]

    ldr	w26,	[sp, #612]

    add	w11,	w28,	w22
    add	w7,	w26,	#1
    lsl	w25,	w7,	#2
    add	w7,	w7,	#1
    mov	x23,	x25
    add	x23,	sp,	x23
    lsl	w10,	w7,	#2
    add	x23,	x23,	#16
    add	w7,	w7,	#1
    mov	x25,	x10
    add	x25,	sp,	x25
    ldr	w23,	[x23]

    add	w22,	w11,	w23
    add	x25,	x25,	#16
    ldr	w10,	[x25]

    str	w7,	[sp, #1576]

    add	w24,	w22,	w10
    ldr	w8,	[sp, #1576]

    lsl	w11,	w8,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w25,	[x10]

    ldr	w9,	[sp, #1576]

    add	w28,	w24,	w25
    add	w11,	w9,	#1
    str	w11,	[sp, #1580]

    ldr	w12,	[sp, #1580]

    lsl	w22,	w12,	#2
    mov	x11,	x22
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w11,	[x11]

    ldr	w13,	[sp, #1580]

    add	w11,	w28,	w11
    add	w15,	w13,	#1
    str	w15,	[sp, #1600]

    ldr	w16,	[sp, #1600]

    lsl	w25,	w16,	#2
    mov	x23,	x25
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w12,	[x23]

    ldr	w17,	[sp, #1600]

    add	w26,	w11,	w12
    add	w19,	w17,	#1
    cmp	w19,	#96
    blt	main_420

main_457:
    mov	w28,	w19
    mov	w23,	w26
    str	w28,	[sp, #616]


main_459:
    ldr	w0,	[sp, #616]

    lsl	w25,	w0,	#2
    mov	x11,	x25
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w10,	[x11]

    add	w19,	w10,	w23
    str	w19,	[sp, #1604]

    ldr	w1,	[sp, #616]

    add	w9,	w1,	#1
    cmp	w9,	#100
    bge	main_467

main_458:
    mov	w2,	w9
    str	w2,	[sp, #616]

    ldr	w20,	[sp, #1604]

    mov	w23,	w20
    b	main_459

main_467:
    movz	w24,	#65535
    ldr	w21,	[sp, #1604]

    mov	w22,	w24
    sdiv	w10,	w21,	w22
    ldr	w22,	[sp, #1604]

    lsl	w24,	w10,	#16
    ldr	w20,	[sp, #556]

    sub	w10,	w24,	w10,	lsl #0
    ldr	w18,	[sp, #1212]

    sub	w6,	w22,	w10
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
    
    add	sp, sp, #2752
    ret


main_249:
    mov	w8,	w6
    str	w8,	[sp, #1756]

    ldr	w20,	[sp, #556]

    mov	w4,	w20
    str	w4,	[sp, #1744]

    b	main_250

main_420:
    mov	w10,	w19
    mov	w23,	w26
    b	main_421

main_258:
    ldr	w27,	[sp, #1616]

    lsl	w10,	w27,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w23,	[x9]

    ldr	w28,	[sp, #1616]

    add	w0,	w23,	w6
    add	w5,	w28,	#1
    str	w5,	[sp, #1544]

    ldr	w6,	[sp, #1544]

    lsl	w20,	w6,	#2
    mov	x10,	x20
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w11,	[x10]

    ldr	w7,	[sp, #1544]

    add	w12,	w0,	w11
    add	w9,	w7,	#1
    str	w9,	[sp, #1548]

    ldr	w10,	[sp, #1548]

    lsl	w23,	w10,	#2
    mov	x20,	x23
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w11,	[x20]

    add	w25,	w12,	w11
    ldr	w11,	[sp, #1548]

    add	w11,	w11,	#1
    add	w13,	w11,	#1
    lsl	w9,	w11,	#2
    mov	x23,	x9
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w24,	[x23]

    str	w13,	[sp, #512]

    add	w26,	w25,	w24
    ldr	w14,	[sp, #512]

    lsl	w10,	w14,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w10,	[x9]

    ldr	w15,	[sp, #512]

    add	w1,	w26,	w10
    add	w17,	w15,	#1
    str	w17,	[sp, #516]

    ldr	w18,	[sp, #516]

    lsl	w20,	w18,	#2
    mov	x10,	x20
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w11,	[x10]

    ldr	w19,	[sp, #516]

    add	w10,	w1,	w11
    add	w11,	w19,	#1
    add	w21,	w11,	#1
    lsl	w23,	w11,	#2
    mov	x20,	x23
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w25,	[x20]

    str	w21,	[sp, #528]

    add	w25,	w10,	w25
    ldr	w22,	[sp, #528]

    lsl	w9,	w22,	#2
    mov	x23,	x9
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w10,	[x23]

    ldr	w23,	[sp, #528]

    add	w28,	w25,	w10
    add	w25,	w23,	#1
    str	w25,	[sp, #532]

    ldr	w26,	[sp, #532]

    lsl	w10,	w26,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w10,	[x9]

    ldr	w27,	[sp, #532]

    add	w8,	w10,	w28
    add	w0,	w27,	#1
    str	w0,	[sp, #536]

    ldr	w1,	[sp, #536]

    lsl	w20,	w1,	#2
    mov	x10,	x20
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w23,	[x10]

    ldr	w2,	[sp, #536]

    add	w10,	w8,	w23
    add	w11,	w2,	#1
    lsl	w23,	w11,	#2
    add	w11,	w11,	#1
    mov	x20,	x23
    add	x20,	sp,	x20
    add	w5,	w11,	#1
    lsl	w9,	w11,	#2
    add	x20,	x20,	#16
    ldr	w23,	[x20]

    add	w22,	w10,	w23
    mov	x23,	x9
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w9,	[x23]

    str	w5,	[sp, #1676]

    add	w24,	w22,	w9
    ldr	w6,	[sp, #1676]

    lsl	w10,	w6,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w25,	[x9]

    ldr	w7,	[sp, #1676]

    add	w27,	w24,	w25
    add	w4,	w7,	#1
    str	w4,	[sp, #628]

    ldr	w5,	[sp, #628]

    lsl	w20,	w5,	#2
    mov	x11,	x20
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w11,	[x11]

    ldr	w6,	[sp, #628]

    add	w13,	w27,	w11
    add	w9,	w6,	#1
    str	w9,	[sp, #1680]

    ldr	w10,	[sp, #1680]

    lsl	w24,	w10,	#2
    mov	x22,	x24
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    ldr	w11,	[x22]

    add	w24,	w13,	w11
    ldr	w11,	[sp, #1680]

    add	w8,	w11,	#1
    add	w13,	w8,	#1
    lsl	w10,	w8,	#2
    mov	x25,	x10
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w25,	[x25]

    str	w13,	[sp, #1684]

    add	w27,	w24,	w25
    ldr	w14,	[sp, #1684]

    lsl	w10,	w14,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w10,	[x9]

    ldr	w15,	[sp, #1684]

    add	w28,	w10,	w27
    add	w8,	w15,	#1
    str	w8,	[sp, #632]

    ldr	w9,	[sp, #632]

    lsl	w22,	w9,	#2
    mov	x11,	x22
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w10,	[x11]

    add	w11,	w28,	w10
    ldr	w10,	[sp, #632]

    add	w10,	w10,	#1
    add	w12,	w10,	#1
    lsl	w24,	w10,	#2
    mov	x22,	x24
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    ldr	w24,	[x22]

    str	w12,	[sp, #636]

    add	w24,	w11,	w24
    ldr	w13,	[sp, #636]

    lsl	w10,	w13,	#2
    mov	x25,	x10
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w11,	[x25]

    ldr	w14,	[sp, #636]

    add	w25,	w24,	w11
    add	w17,	w14,	#1
    str	w17,	[sp, #1704]

    ldr	w18,	[sp, #1704]

    lsl	w11,	w18,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w19,	[sp, #1704]

    add	w27,	w25,	w10
    add	w21,	w19,	#1
    str	w21,	[sp, #1708]

    ldr	w22,	[sp, #1708]

    lsl	w22,	w22,	#2
    mov	x11,	x22
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w22,	[x11]

    ldr	w23,	[sp, #1708]

    add	w10,	w27,	w22
    add	w11,	w23,	#1
    lsl	w24,	w11,	#2
    add	w11,	w11,	#1
    mov	x22,	x24
    add	x22,	sp,	x22
    add	w25,	w11,	#1
    lsl	w9,	w11,	#2
    add	x22,	x22,	#16
    mov	x23,	x9
    add	x23,	sp,	x23
    ldr	w22,	[x22]

    add	x23,	x23,	#16
    add	w22,	w10,	w22
    ldr	w9,	[x23]

    str	w25,	[sp, #1720]

    add	w24,	w22,	w9
    ldr	w26,	[sp, #1720]

    lsl	w11,	w26,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w25,	[x10]

    ldr	w27,	[sp, #1720]

    add	w26,	w25,	w24
    add	w0,	w27,	#1
    str	w0,	[sp, #1724]

    ldr	w1,	[sp, #1724]

    lsl	w22,	w1,	#2
    mov	x10,	x22
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w2,	[sp, #1724]

    add	w10,	w26,	w10
    add	w4,	w2,	#1
    str	w4,	[sp, #1728]

    ldr	w5,	[sp, #1728]

    lsl	w25,	w5,	#2
    mov	x23,	x25
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w12,	[x23]

    ldr	w6,	[sp, #1728]

    add	w23,	w10,	w12
    add	w7,	w6,	#1
    add	w8,	w7,	#1
    lsl	w10,	w7,	#2
    mov	x25,	x10
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w25,	[x25]

    str	w8,	[sp, #1740]

    add	w25,	w23,	w25
    ldr	w9,	[sp, #1740]

    lsl	w10,	w9,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w10,	[x9]

    add	w28,	w25,	w10
    ldr	w10,	[sp, #1740]

    add	w16,	w10,	#1
    str	w16,	[sp, #640]

    ldr	w17,	[sp, #640]

    lsl	w22,	w17,	#2
    mov	x11,	x22
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w10,	[x11]

    ldr	w18,	[sp, #640]

    add	w10,	w28,	w10
    add	w11,	w18,	#1
    add	w12,	w11,	#1
    lsl	w24,	w11,	#2
    mov	x22,	x24
    add	x22,	sp,	x22
    add	x22,	x22,	#16
    ldr	w24,	[x22]

    str	w12,	[sp, #600]

    add	w26,	w10,	w24
    ldr	w13,	[sp, #600]

    lsl	w9,	w13,	#2
    mov	x24,	x9
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w10,	[x24]

    ldr	w14,	[sp, #600]

    add	w25,	w26,	w10
    add	w20,	w14,	#1
    str	w20,	[sp, #1552]

    ldr	w21,	[sp, #1552]

    lsl	w11,	w21,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w22,	[sp, #1552]

    add	w27,	w10,	w25
    add	w16,	w22,	#1
    str	w16,	[sp, #604]

    ldr	w17,	[sp, #604]

    lsl	w22,	w17,	#2
    mov	x11,	x22
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w22,	[x11]

    ldr	w18,	[sp, #604]

    add	w10,	w27,	w22
    add	w11,	w18,	#1
    add	w7,	w11,	#1
    lsl	w24,	w11,	#2
    mov	x22,	x24
    add	x22,	sp,	x22
    add	w24,	w7,	#1
    add	x22,	x22,	#16
    ldr	w22,	[x22]

    add	w22,	w10,	w22
    lsl	w10,	w7,	#2
    mov	x25,	x10
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w10,	[x25]

    str	w24,	[sp, #1564]

    add	w23,	w22,	w10
    ldr	w25,	[sp, #1564]

    lsl	w11,	w25,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w25,	[x10]

    ldr	w26,	[sp, #1564]

    add	w27,	w23,	w25
    add	w28,	w26,	#1
    str	w28,	[sp, #1568]

    ldr	w0,	[sp, #1568]

    lsl	w22,	w0,	#2
    mov	x11,	x22
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    ldr	w11,	[x11]

    ldr	w1,	[sp, #1568]

    add	w12,	w27,	w11
    add	w3,	w1,	#1
    str	w3,	[sp, #1572]

    ldr	w4,	[sp, #1572]

    lsl	w25,	w4,	#2
    mov	x23,	x25
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w11,	[x23]

    ldr	w5,	[sp, #1572]

    add	w22,	w12,	w11
    add	w11,	w5,	#1
    lsl	w9,	w11,	#2
    add	w11,	w11,	#1
    mov	x24,	x9
    mov	w0,	w11
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w24,	[x24]

    str	w0,	[sp, #1616]

    add	w20,	w22,	w24
    mov	w6,	w20
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
    movz	w11,	#0
    movz	w14,	#0
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

