.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2816
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#324
    bl	_sysy_starttime
    bl	getint
    movz	w17,	#0
    str	w0,	[sp, #1324]

    mov	w6,	w17

main_3:
    cmp	w6,	#56
    bge	main_119

main_6:
    lsl	w22,	w6,	#2
    movz	w10,	#0
    add	w24,	w6,	#1
    movz	w11,	#0
    movz	w14,	#0
    movz	w16,	#0
    movz	w18,	#0
    movz	w19,	#0
    movz	w21,	#0
    movz	w27,	#0
    mov	x12,	x22
    mov	w13,	w10
    add	w1,	w24,	#1
    lsl	w25,	w24,	#2
    add	x12,	sp,	x12
    mov	w24,	w21
    mov	x17,	x25
    add	w6,	w1,	#1
    lsl	w28,	w1,	#2
    add	x12,	x12,	#16
    add	x17,	sp,	x17
    mov	w1,	w18
    mov	x20,	x28
    add	w3,	w6,	#1
    lsl	w2,	w6,	#2
    str	w13,	[x12]

    add	x17,	x17,	#16
    mov	w28,	w19
    add	x20,	sp,	x20
    add	w15,	w3,	#1
    lsl	w5,	w3,	#2
    mov	x23,	x2
    movz	w13,	#0
    movz	w12,	#0
    str	w11,	[x17]

    add	x20,	x20,	#16
    lsl	w8,	w15,	#2
    mov	w3,	w16
    mov	x26,	x5
    movz	w2,	#0
    add	x23,	sp,	x23
    mov	w7,	w13
    mov	w9,	w12
    mov	x0,	x8
    mov	w5,	w14
    add	x26,	sp,	x26
    add	x23,	x23,	#16
    mov	w12,	w27
    str	w9,	[x20]

    add	x0,	sp,	x0
    add	w20,	w15,	#1
    add	x26,	x26,	#16
    str	w7,	[x23]

    add	x0,	x0,	#16
    add	w22,	w20,	#1
    lsl	w11,	w20,	#2
    str	w5,	[x26]

    movz	w20,	#0
    mov	x4,	x11
    add	w25,	w22,	#1
    lsl	w14,	w22,	#2
    str	w3,	[x0]

    mov	w26,	w20
    add	x4,	sp,	x4
    mov	x5,	x14
    lsl	w17,	w25,	#2
    add	w22,	w25,	#1
    add	x5,	sp,	x5
    mov	x8,	x17
    add	x4,	x4,	#16
    add	x8,	sp,	x8
    add	w0,	w22,	#1
    lsl	w20,	w22,	#2
    add	x5,	x5,	#16
    movz	w22,	#0
    str	w1,	[x4]

    add	x8,	x8,	#16
    mov	x11,	x20
    add	w3,	w0,	#1
    lsl	w23,	w0,	#2
    str	w28,	[x5]

    add	x11,	sp,	x11
    mov	x14,	x23
    str	w26,	[x8]

    movz	w23,	#0
    add	x14,	sp,	x14
    add	w8,	w3,	#1
    add	x11,	x11,	#16
    lsl	w26,	w3,	#2
    mov	w20,	w23
    mov	x17,	x26
    add	x14,	x14,	#16
    lsl	w0,	w8,	#2
    str	w24,	[x11]

    movz	w23,	#0
    add	x17,	sp,	x17
    add	w11,	w8,	#1
    movz	w24,	#0
    str	w22,	[x14]

    mov	w16,	w23
    mov	w18,	w24
    add	x17,	x17,	#16
    add	w15,	w11,	#1
    lsl	w3,	w11,	#2
    mov	x22,	x0
    movz	w24,	#0
    movz	w11,	#0
    str	w20,	[x17]

    add	w21,	w15,	#1
    lsl	w6,	w15,	#2
    mov	x25,	x3
    movz	w0,	#0
    add	x22,	sp,	x22
    mov	w14,	w24
    mov	w17,	w11
    lsl	w9,	w21,	#2
    mov	x28,	x6
    add	x25,	sp,	x25
    mov	w8,	w0
    add	x22,	x22,	#16
    add	w24,	w21,	#1
    movz	w11,	#0
    mov	x1,	x9
    add	x28,	sp,	x28
    add	x25,	x25,	#16
    movz	w0,	#0
    str	w18,	[x22]

    movz	w9,	#0
    add	x1,	sp,	x1
    add	x28,	x28,	#16
    mov	w6,	w0
    str	w16,	[x25]

    add	x1,	x1,	#16
    str	w14,	[x28]

    movz	w14,	#0
    movz	w28,	#0
    str	w12,	[x1]

    mov	w10,	w28
    movz	w1,	#0
    lsl	w12,	w24,	#2
    add	w28,	w24,	#1
    mov	x4,	x12
    add	x4,	sp,	x4
    lsl	w15,	w28,	#2
    add	x4,	x4,	#16
    mov	x7,	x15
    add	x7,	sp,	x7
    str	w10,	[x4]

    add	x7,	x7,	#16
    add	w4,	w28,	#1
    str	w8,	[x7]

    add	w5,	w4,	#1
    lsl	w18,	w4,	#2
    movz	w8,	#0
    mov	w4,	w1
    mov	x12,	x18
    add	w3,	w5,	#1
    lsl	w21,	w5,	#2
    mov	w23,	w8
    add	x12,	sp,	x12
    movz	w5,	#0
    mov	x15,	x21
    lsl	w24,	w3,	#2
    mov	w25,	w5
    add	x12,	x12,	#16
    add	x15,	sp,	x15
    mov	x18,	x24
    add	x18,	sp,	x18
    str	w6,	[x12]

    add	x15,	x15,	#16
    add	w12,	w3,	#1
    add	x18,	x18,	#16
    movz	w3,	#0
    str	w4,	[x15]

    mov	w0,	w3
    lsl	w27,	w12,	#2
    movz	w4,	#0
    add	w15,	w12,	#1
    str	w2,	[x18]

    mov	x21,	x27
    mov	w27,	w4
    add	x21,	sp,	x21
    lsl	w1,	w15,	#2
    add	w18,	w15,	#1
    mov	x22,	x1
    add	x21,	x21,	#16
    add	x22,	sp,	x22
    add	w16,	w18,	#1
    lsl	w4,	w18,	#2
    movz	w18,	#0
    str	w0,	[x21]

    add	x22,	x22,	#16
    add	w28,	w16,	#1
    lsl	w7,	w16,	#2
    mov	w21,	w9
    mov	x0,	x7
    str	w27,	[x22]

    add	x0,	sp,	x0
    add	w2,	w28,	#1
    lsl	w10,	w28,	#2
    mov	x27,	x4
    mov	x3,	x10
    add	x0,	x0,	#16
    add	x27,	sp,	x27
    add	w1,	w2,	#1
    lsl	w13,	w2,	#2
    movz	w10,	#0
    add	x3,	sp,	x3
    add	x27,	x27,	#16
    mov	x6,	x13
    add	w4,	w1,	#1
    lsl	w16,	w1,	#2
    mov	w19,	w10
    add	x3,	x3,	#16
    str	w25,	[x27]

    mov	w13,	w11
    add	x6,	sp,	x6
    add	w7,	w4,	#1
    mov	x9,	x16
    movz	w10,	#0
    movz	w27,	#0
    str	w23,	[x0]

    add	x6,	x6,	#16
    lsl	w22,	w7,	#2
    movz	w16,	#0
    add	x9,	sp,	x9
    mov	w15,	w10
    str	w21,	[x3]

    add	w10,	w7,	#1
    movz	w21,	#0
    add	x9,	x9,	#16
    mov	w3,	w18
    str	w19,	[x6]

    mov	w7,	w14
    lsl	w25,	w10,	#2
    lsl	w19,	w4,	#2
    str	w17,	[x9]

    mov	x20,	x25
    mov	x12,	x19
    mov	x17,	x22
    add	x20,	sp,	x20
    movz	w19,	#0
    add	x12,	sp,	x12
    add	x17,	sp,	x17
    add	x20,	x20,	#16
    add	x12,	x12,	#16
    add	x17,	x17,	#16
    str	w15,	[x12]

    movz	w12,	#0
    str	w13,	[x17]

    mov	w11,	w12
    movz	w13,	#0
    add	w17,	w10,	#1
    str	w11,	[x20]

    mov	w9,	w13
    movz	w20,	#0
    add	w22,	w17,	#1
    lsl	w28,	w17,	#2
    mov	x23,	x28
    mov	w28,	w20
    add	x23,	sp,	x23
    add	w15,	w22,	#1
    lsl	w2,	w22,	#2
    movz	w22,	#0
    mov	x26,	x2
    add	x23,	x23,	#16
    mov	w24,	w22
    add	w1,	w15,	#1
    lsl	w5,	w15,	#2
    add	x26,	sp,	x26
    mov	x0,	x5
    str	w9,	[x23]

    mov	w5,	w16
    lsl	w8,	w1,	#2
    add	x0,	sp,	x0
    add	x26,	x26,	#16
    mov	x2,	x8
    add	x2,	sp,	x2
    add	x0,	x0,	#16
    str	w7,	[x26]

    add	x2,	x2,	#16
    mov	w26,	w21
    str	w5,	[x0]

    movz	w5,	#0
    add	w0,	w1,	#1
    str	w3,	[x2]

    mov	w1,	w19
    lsl	w11,	w0,	#2
    add	w3,	w0,	#1
    mov	x7,	x11
    add	x7,	sp,	x7
    add	w6,	w3,	#1
    lsl	w14,	w3,	#2
    mov	x8,	x14
    add	x7,	x7,	#16
    add	x8,	sp,	x8
    add	w9,	w6,	#1
    lsl	w17,	w6,	#2
    mov	x11,	x17
    str	w1,	[x7]

    add	x8,	x8,	#16
    add	w4,	w9,	#1
    lsl	w20,	w9,	#2
    add	x11,	sp,	x11
    mov	x14,	x20
    str	w28,	[x8]

    add	x14,	sp,	x14
    add	w15,	w4,	#1
    lsl	w23,	w4,	#2
    add	x11,	x11,	#16
    mov	x17,	x23
    add	x14,	x14,	#16
    movz	w23,	#0
    add	x17,	sp,	x17
    mov	w22,	w23
    str	w26,	[x11]

    movz	w23,	#0
    movz	w11,	#0
    lsl	w26,	w15,	#2
    add	x17,	x17,	#16
    str	w24,	[x14]

    mov	w18,	w23
    mov	w14,	w27
    movz	w24,	#0
    str	w22,	[x17]

    mov	w20,	w24
    mov	x22,	x26
    movz	w24,	#0
    add	x22,	sp,	x22
    mov	w16,	w24
    add	x22,	x22,	#16
    str	w20,	[x22]

    add	w22,	w15,	#1
    add	w26,	w22,	#1
    lsl	w0,	w22,	#2
    mov	x25,	x0
    movz	w0,	#0
    add	x25,	sp,	x25
    add	w4,	w26,	#1
    lsl	w3,	w26,	#2
    mov	w10,	w0
    mov	x28,	x3
    add	x25,	x25,	#16
    movz	w0,	#0
    add	w2,	w4,	#1
    lsl	w6,	w4,	#2
    movz	w3,	#0
    add	x28,	sp,	x28
    str	w18,	[x25]

    mov	w8,	w0
    lsl	w9,	w2,	#2
    mov	x1,	x6
    add	x28,	x28,	#16
    mov	x4,	x9
    add	w6,	w2,	#1
    add	x1,	sp,	x1
    movz	w9,	#0
    add	x4,	sp,	x4
    str	w16,	[x28]

    movz	w2,	#0
    add	w13,	w6,	#1
    add	x1,	x1,	#16
    mov	w23,	w9
    add	x4,	x4,	#16
    movz	w28,	#0
    add	w16,	w13,	#1
    lsl	w15,	w13,	#2
    str	w14,	[x1]

    mov	w12,	w28
    movz	w1,	#0
    str	w12,	[x4]

    add	w19,	w16,	#1
    lsl	w18,	w16,	#2
    mov	w4,	w2
    lsl	w12,	w6,	#2
    mov	w2,	w3
    mov	w6,	w1
    add	w22,	w19,	#1
    lsl	w21,	w19,	#2
    mov	x7,	x12
    mov	w19,	w11
    mov	x12,	x15
    add	x7,	sp,	x7
    add	w25,	w22,	#1
    lsl	w24,	w22,	#2
    mov	x15,	x18
    add	x12,	sp,	x12
    add	x7,	x7,	#16
    mov	x18,	x21
    lsl	w27,	w25,	#2
    add	x15,	sp,	x15
    add	x12,	x12,	#16
    mov	x21,	x24
    add	x18,	sp,	x18
    str	w10,	[x7]

    add	x15,	x15,	#16
    mov	x24,	x27
    add	x21,	sp,	x21
    str	w8,	[x12]

    add	x18,	x18,	#16
    mov	w27,	w5
    add	x24,	sp,	x24
    movz	w8,	#0
    str	w6,	[x15]

    add	x21,	x21,	#16
    str	w4,	[x18]

    add	x24,	x24,	#16
    movz	w4,	#0
    str	w2,	[x21]

    mov	w0,	w4
    add	w2,	w25,	#1
    str	w0,	[x24]

    add	w3,	w2,	#1
    lsl	w1,	w2,	#2
    mov	x25,	x1
    add	x25,	sp,	x25
    add	w6,	w3,	#1
    lsl	w4,	w3,	#2
    mov	x0,	x4
    add	x25,	x25,	#16
    add	x0,	sp,	x0
    add	w9,	w6,	#1
    lsl	w7,	w6,	#2
    mov	x3,	x7
    str	w27,	[x25]

    add	x0,	x0,	#16
    add	w15,	w9,	#1
    lsl	w10,	w9,	#2
    add	x3,	sp,	x3
    mov	w25,	w8
    mov	x6,	x10
    str	w25,	[x0]

    add	w14,	w15,	#1
    lsl	w13,	w15,	#2
    add	x3,	x3,	#16
    movz	w10,	#0
    add	x6,	sp,	x6
    mov	x9,	x13
    mov	w21,	w10
    add	x9,	sp,	x9
    str	w23,	[x3]

    add	x6,	x6,	#16
    add	x9,	x9,	#16
    str	w21,	[x6]

    mov	w6,	w14
    str	w19,	[x9]

    b	main_3

main_119:
    mov	w9,	w6

main_121:
    lsl	w16,	w9,	#2
    movz	w10,	#0
    add	w21,	w9,	#1
    movz	w11,	#0
    movz	w12,	#0
    movz	w13,	#0
    mov	x14,	x16
    mov	w0,	w10
    add	w24,	w21,	#1
    lsl	w19,	w21,	#2
    mov	w27,	w11
    mov	w25,	w12
    mov	w23,	w13
    movz	w16,	#0
    add	x14,	sp,	x14
    add	w1,	w24,	#1
    lsl	w22,	w24,	#2
    mov	x15,	x19
    mov	x18,	x22
    mov	w19,	w16
    add	x14,	x14,	#16
    add	x15,	sp,	x15
    add	x18,	sp,	x18
    str	w0,	[x14]

    add	x15,	x15,	#16
    add	x18,	x18,	#16
    movz	w14,	#0
    add	w0,	w1,	#1
    str	w27,	[x15]

    str	w25,	[x18]

    add	w6,	w0,	#1
    lsl	w28,	w0,	#2
    movz	w18,	#0
    lsl	w25,	w1,	#2
    mov	x26,	x28
    mov	w17,	w18
    lsl	w2,	w6,	#2
    mov	x21,	x25
    add	w28,	w6,	#1
    add	x26,	sp,	x26
    mov	x0,	x2
    add	x21,	sp,	x21
    add	x0,	sp,	x0
    add	w13,	w28,	#1
    lsl	w5,	w28,	#2
    add	x26,	x26,	#16
    add	x21,	x21,	#16
    add	x0,	x0,	#16
    mov	x2,	x5
    add	w9,	w13,	#1
    lsl	w8,	w13,	#2
    str	w23,	[x21]

    add	x2,	sp,	x2
    mov	x5,	x8
    mov	w21,	w14
    add	x5,	sp,	x5
    str	w21,	[x26]

    add	x2,	x2,	#16
    str	w19,	[x0]

    movz	w19,	#0
    add	x5,	x5,	#16
    mov	w15,	w19
    str	w17,	[x2]

    str	w15,	[x5]

    cmp	w9,	#96
    blt	main_121

main_140:
    mov	w10,	w9

main_142:
    lsl	w12,	w10,	#2
    movz	w20,	#0
    add	w13,	w10,	#1
    mov	x11,	x12
    mov	w2,	w20
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    str	w2,	[x11]

    cmp	w13,	#100
    blt	main_141

main_147:
    movz	w25,	#0
    ldr	w18,	[sp, #1324]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x10,	sp,	#20
    add	x23,	sp,	#24
    add	x14,	sp,	#28
    add	x16,	sp,	#32
    add	x3,	sp,	#36
    add	x13,	sp,	#40
    add	x7,	sp,	#44
    add	x1,	sp,	#48
    add	x26,	sp,	#52
    add	x0,	sp,	#56
    add	x2,	sp,	#60
    add	x11,	sp,	#64
    add	x27,	sp,	#68
    add	x21,	sp,	#72
    add	x8,	sp,	#76
    add	x22,	sp,	#80
    add	x20,	sp,	#84
    add	x17,	sp,	#88
    add	x24,	sp,	#92
    add	x4,	sp,	#96
    add	x19,	sp,	#100
    add	x25,	sp,	#104
    add	x5,	sp,	#108
    add	x18,	sp,	#112
    add	x28,	sp,	#116
    add	x15,	sp,	#120
    movz	fp,	#796
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x10,	[sp, #2040]

    add	x10,	sp,	#224
    str	x23,	[sp, #2264]

    add	x23,	sp,	#164
    str	x14,	[sp, #2208]

    add	x14,	sp,	#152
    str	x16,	[sp, #2080]

    add	x16,	sp,	#232
    str	x3,	[sp, #2320]

    add	x3,	sp,	#176
    str	x13,	[sp, #2064]

    add	x13,	sp,	#228
    str	x7,	[sp, #2032]

    add	x7,	sp,	#220
    str	x1,	[sp, #2008]

    add	x1,	sp,	#212
    str	x26,	[sp, #2288]

    add	x26,	sp,	#168
    str	x0,	[sp, #2312]

    add	x0,	sp,	#172
    str	x2,	[sp, #2160]

    add	x2,	sp,	#136
    str	x11,	[sp, #2200]

    add	x11,	sp,	#148
    str	x27,	[sp, #2000]

    add	x27,	sp,	#208
    str	x21,	[sp, #1984]

    add	x21,	sp,	#200
    str	x8,	[sp, #2192]

    add	x8,	sp,	#144
    str	x22,	[sp, #2112]

    add	x22,	sp,	#124
    str	x20,	[sp, #2240]

    add	x20,	sp,	#160
    str	x17,	[sp, #2224]

    add	x17,	sp,	#156
    str	x24,	[sp, #1992]

    add	x24,	sp,	#204
    str	x4,	[sp, #2024]

    add	x4,	sp,	#216
    str	x19,	[sp, #2096]

    add	x19,	sp,	#236
    str	x25,	[sp, #2128]

    add	x25,	sp,	#128
    str	x5,	[sp, #2176]

    add	x5,	sp,	#140
    str	x18,	[sp, #1976]

    add	x18,	sp,	#196
    str	x28,	[sp, #2136]

    add	x28,	sp,	#132
    str	x15,	[sp, #1968]

    add	x15,	sp,	#192
    str	x22,	[sp, fp]

    add	x22,	sp,	#240
    movz	fp,	#804
    str	x25,	[sp, fp]

    add	x25,	sp,	#244
    movz	fp,	#812
    str	x28,	[sp, fp]

    add	x28,	sp,	#248
    movz	fp,	#820
    str	x2,	[sp, fp]

    add	x2,	sp,	#252
    movz	fp,	#828
    str	x5,	[sp, fp]

    add	x5,	sp,	#256
    movz	fp,	#836
    str	x8,	[sp, fp]

    add	x8,	sp,	#260
    movz	fp,	#844
    str	x11,	[sp, fp]

    add	x11,	sp,	#264
    movz	fp,	#852
    str	x14,	[sp, fp]

    add	x14,	sp,	#268
    movz	fp,	#860
    str	x17,	[sp, fp]

    add	x17,	sp,	#272
    movz	fp,	#868
    str	x20,	[sp, fp]

    add	x20,	sp,	#276
    movz	fp,	#876
    str	x23,	[sp, fp]

    add	x23,	sp,	#280
    movz	fp,	#884
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#892
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#900
    str	x3,	[sp, fp]

    add	x3,	sp,	#292
    movz	fp,	#908
    str	x6,	[sp, fp]

    add	x6,	sp,	#296
    movz	fp,	#916
    str	x9,	[sp, fp]

    add	x9,	sp,	#300
    movz	fp,	#924
    str	x12,	[sp, fp]

    add	x12,	sp,	#304
    movz	fp,	#932
    str	x15,	[sp, fp]

    add	x15,	sp,	#308
    movz	fp,	#940
    str	x18,	[sp, fp]

    add	x18,	sp,	#312
    movz	fp,	#948
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#956
    str	x24,	[sp, fp]

    add	x24,	sp,	#320
    movz	fp,	#964
    str	x27,	[sp, fp]

    add	x27,	sp,	#324
    movz	fp,	#972
    str	x1,	[sp, fp]

    add	x1,	sp,	#328
    movz	fp,	#980
    str	x4,	[sp, fp]

    add	x4,	sp,	#332
    movz	fp,	#996
    str	x7,	[sp, fp]

    add	x7,	sp,	#336
    movz	fp,	#1004
    str	x10,	[sp, fp]

    add	x10,	sp,	#340
    movz	fp,	#1012
    str	x13,	[sp, fp]

    add	x13,	sp,	#344
    movz	fp,	#988
    str	x16,	[sp, fp]

    add	x16,	sp,	#348
    movz	fp,	#420
    str	x19,	[sp, fp]

    add	x19,	sp,	#352
    movz	fp,	#428
    str	x22,	[sp, fp]

    add	x22,	sp,	#356
    movz	fp,	#436
    str	x25,	[sp, fp]

    add	x25,	sp,	#360
    movz	fp,	#444
    str	x28,	[sp, fp]

    add	x28,	sp,	#364
    movz	fp,	#452
    str	x2,	[sp, fp]

    add	x2,	sp,	#368
    movz	fp,	#460
    str	x5,	[sp, fp]

    add	x5,	sp,	#372
    movz	fp,	#468
    str	x8,	[sp, fp]

    add	x8,	sp,	#376
    movz	fp,	#1020
    str	x11,	[sp, fp]

    add	x11,	sp,	#380
    movz	fp,	#1028
    str	x14,	[sp, fp]

    add	x14,	sp,	#384
    movz	fp,	#1036
    str	x17,	[sp, fp]

    add	x17,	sp,	#388
    movz	fp,	#1044
    str	x20,	[sp, fp]

    add	x20,	sp,	#392
    movz	fp,	#1052
    str	x23,	[sp, fp]

    add	x23,	sp,	#396
    movz	fp,	#1060
    str	x26,	[sp, fp]

    add	x26,	sp,	#400
    movz	fp,	#1068
    str	x0,	[sp, fp]

    add	x0,	sp,	#404
    movz	fp,	#1076
    str	x3,	[sp, fp]

    add	x3,	sp,	#408
    movz	fp,	#1084
    str	x6,	[sp, fp]

    add	x6,	sp,	#412
    movz	fp,	#1092
    str	x9,	[sp, fp]

    movz	fp,	#1100
    str	x12,	[sp, fp]

    movz	fp,	#1108
    str	x15,	[sp, fp]

    movz	w15,	#0
    movz	fp,	#1116
    str	x18,	[sp, fp]

    movz	fp,	#1124
    str	x21,	[sp, fp]

    movz	fp,	#1132
    str	x24,	[sp, fp]

    movz	fp,	#1140
    str	x27,	[sp, fp]

    movz	fp,	#1148
    str	x1,	[sp, fp]

    movz	fp,	#1156
    str	x4,	[sp, fp]

    movz	fp,	#1164
    str	x7,	[sp, fp]

    mov	w7,	w15
    movz	fp,	#1172
    str	x10,	[sp, fp]

    movz	fp,	#1180
    str	x13,	[sp, fp]

    movz	fp,	#1188
    str	x16,	[sp, fp]

    movz	fp,	#1196
    str	x19,	[sp, fp]

    movz	fp,	#1204
    str	x22,	[sp, fp]

    movz	fp,	#1212
    str	x25,	[sp, fp]

    movz	fp,	#1220
    str	x28,	[sp, fp]

    movz	fp,	#1228
    str	x2,	[sp, fp]

    movz	fp,	#1236
    str	x5,	[sp, fp]

    movz	fp,	#1244
    str	x8,	[sp, fp]

    movz	w8,	#0
    movz	fp,	#1252
    str	x11,	[sp, fp]

    mov	w11,	w8
    movz	fp,	#1260
    str	x14,	[sp, fp]

    movz	fp,	#1268
    str	x17,	[sp, fp]

    movz	fp,	#1276
    str	x20,	[sp, fp]

    movz	fp,	#1284
    str	x23,	[sp, fp]

    movz	fp,	#1292
    str	x26,	[sp, fp]

    movz	fp,	#1300
    str	x0,	[sp, fp]

    movz	fp,	#1308
    str	x3,	[sp, fp]

    movz	fp,	#1316
    str	x6,	[sp, fp]

    str	w11,	[sp, #1964]

    str	w7,	[sp, #1952]


main_250:
    movz	w0,	#1
    ldr	x11,	[sp, #2040]

    movz	w15,	#3
    movz	fp,	#796
    mov	w8,	w0
    mov	w16,	w15
    str	w8,	[x11]

    ldr	x24,	[sp, #2264]

    movz	w8,	#2
    mov	w0,	w8
    str	w0,	[x24]

    movz	w0,	#4
    ldr	x15,	[sp, #2208]

    mov	w8,	w0
    str	w16,	[x15]

    movz	w15,	#6
    ldr	x17,	[sp, #2080]

    mov	w16,	w15
    str	w8,	[x17]

    movz	w15,	#9
    ldr	x4,	[sp, #2320]

    movz	w8,	#5
    mov	w0,	w8
    str	w0,	[x4]

    movz	w0,	#7
    ldr	x14,	[sp, #2064]

    mov	w9,	w0
    str	w16,	[x14]

    ldr	x8,	[sp, #2032]

    str	w9,	[x8]

    ldr	x2,	[sp, #2008]

    movz	w8,	#8
    mov	w0,	w8
    movz	w8,	#11
    str	w0,	[x2]

    movz	w0,	#10
    ldr	x27,	[sp, #2288]

    mov	w9,	w0
    str	w15,	[x27]

    mov	w0,	w8
    movz	w15,	#12
    ldr	x1,	[sp, #2312]

    mov	w16,	w15
    str	w9,	[x1]

    movz	w15,	#15
    ldr	x3,	[sp, #2160]

    str	w0,	[x3]

    movz	w0,	#13
    ldr	x12,	[sp, #2200]

    mov	w8,	w0
    str	w16,	[x12]

    mov	w16,	w15
    ldr	x28,	[sp, #2000]

    movz	w15,	#18
    str	w8,	[x28]

    ldr	x22,	[sp, #1984]

    movz	w8,	#14
    mov	w0,	w8
    str	w0,	[x22]

    movz	w0,	#16
    ldr	x9,	[sp, #2192]

    mov	w8,	w0
    str	w16,	[x9]

    ldr	x23,	[sp, #2112]

    str	w8,	[x23]

    ldr	x21,	[sp, #2240]

    movz	w8,	#17
    mov	w0,	w8
    str	w0,	[x21]

    movz	w0,	#19
    ldr	x18,	[sp, #2224]

    mov	w8,	w0
    str	w15,	[x18]

    movz	w15,	#21
    ldr	x25,	[sp, #1992]

    str	w8,	[x25]

    ldr	x5,	[sp, #2024]

    movz	w8,	#20
    mov	w0,	w8
    str	w0,	[x5]

    movz	w0,	#22
    ldr	x20,	[sp, #2096]

    mov	w8,	w0
    str	w15,	[x20]

    movz	w15,	#24
    ldr	x26,	[sp, #2128]

    str	w8,	[x26]

    ldr	x6,	[sp, #2176]

    movz	w8,	#23
    mov	w0,	w8
    movz	w8,	#26
    str	w0,	[x6]

    movz	w0,	#25
    ldr	x19,	[sp, #1976]

    mov	w9,	w0
    str	w15,	[x19]

    movz	w15,	#27
    ldr	x0,	[sp, #2136]

    str	w9,	[x0]

    ldr	x16,	[sp, #1968]

    mov	w0,	w8
    str	w0,	[x16]

    movz	w0,	#28
    ldr	x22,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#804
    str	w15,	[x22]

    movz	w15,	#30
    ldr	x25,	[sp, fp]

    movz	fp,	#812
    str	w8,	[x25]

    movz	w8,	#29
    ldr	x28,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#820
    movz	w8,	#32
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, fp]

    mov	w9,	w0
    movz	fp,	#828
    str	w15,	[x2]

    mov	w0,	w8
    movz	w15,	#33
    ldr	x6,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#836
    str	w9,	[x6]

    ldr	x9,	[sp, fp]

    movz	fp,	#844
    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#852
    str	w16,	[x11]

    ldr	x15,	[sp, fp]

    movz	fp,	#860
    str	w8,	[x15]

    movz	w15,	#36
    movz	w8,	#35
    ldr	x18,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#868
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#876
    str	w15,	[x21]

    movz	w15,	#39
    ldr	x24,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#884
    str	w8,	[x24]

    movz	w15,	#42
    movz	w8,	#38
    ldr	x27,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#892
    movz	w8,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, fp]

    mov	w9,	w0
    movz	fp,	#900
    str	w16,	[x1]

    mov	w0,	w8
    mov	w16,	w15
    ldr	x4,	[sp, fp]

    movz	w15,	#45
    movz	fp,	#908
    str	w9,	[x4]

    ldr	x8,	[sp, fp]

    movz	fp,	#916
    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#924
    str	w16,	[x10]

    ldr	x14,	[sp, fp]

    movz	fp,	#932
    str	w8,	[x14]

    movz	w8,	#44
    ldr	x17,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#940
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#948
    str	w15,	[x20]

    movz	w15,	#48
    ldr	x23,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#956
    str	w8,	[x23]

    movz	w15,	#51
    movz	w8,	#47
    ldr	x26,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#964
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#972
    str	w16,	[x0]

    mov	w16,	w15
    movz	w0,	#49
    ldr	x3,	[sp, fp]

    movz	w15,	#54
    mov	w8,	w0
    movz	fp,	#980
    str	w8,	[x3]

    ldr	x7,	[sp, fp]

    movz	w8,	#50
    movz	fp,	#996
    mov	w0,	w8
    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1004
    str	w16,	[x9]

    ldr	x13,	[sp, fp]

    movz	fp,	#1012
    str	w8,	[x13]

    movz	w8,	#53
    ldr	x16,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#988
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#420
    str	w15,	[x19]

    movz	w15,	#57
    ldr	x22,	[sp, fp]

    movz	fp,	#428
    str	w8,	[x22]

    movz	w8,	#56
    ldr	x25,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#436
    str	w0,	[x25]

    movz	w0,	#58
    ldr	x28,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#444
    str	w15,	[x28]

    movz	w15,	#60
    ldr	x2,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#452
    str	w8,	[x2]

    movz	w15,	#63
    movz	w8,	#59
    ldr	x6,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#460
    str	w0,	[x6]

    movz	w0,	#61
    ldr	x8,	[sp, fp]

    movz	fp,	#468
    str	w16,	[x8]

    mov	w16,	w15
    mov	w8,	w0
    ldr	x9,	[sp, fp]

    movz	w0,	#64
    movz	fp,	#1020
    str	w8,	[x9]

    movz	w8,	#62
    ldr	x12,	[sp, fp]

    movz	fp,	#1028
    str	w8,	[x12]

    mov	w8,	w0
    ldr	x15,	[sp, fp]

    movz	fp,	#1036
    str	w16,	[x15]

    movz	w15,	#66
    ldr	x18,	[sp, fp]

    movz	fp,	#1044
    str	w8,	[x18]

    movz	w8,	#65
    ldr	x21,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1052
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1060
    str	w15,	[x24]

    movz	w15,	#69
    ldr	x27,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#1068
    str	w8,	[x27]

    movz	w15,	#72
    movz	w8,	#68
    ldr	x1,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1076
    movz	w8,	#71
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, fp]

    mov	w9,	w0
    movz	fp,	#1084
    str	w16,	[x4]

    mov	w0,	w8
    mov	w16,	w15
    ldr	x7,	[sp, fp]

    movz	w15,	#75
    movz	fp,	#1092
    str	w9,	[x7]

    ldr	x10,	[sp, fp]

    movz	fp,	#1100
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1108
    str	w16,	[x13]

    ldr	x16,	[sp, fp]

    movz	fp,	#1116
    str	w8,	[x16]

    movz	w8,	#74
    ldr	x19,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1124
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1132
    str	w15,	[x22]

    movz	w15,	#78
    ldr	x25,	[sp, fp]

    movz	fp,	#1140
    str	w8,	[x25]

    movz	w8,	#77
    ldr	x28,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1148
    movz	w8,	#80
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, fp]

    movz	fp,	#1156
    str	w15,	[x2]

    movz	w15,	#81
    ldr	x5,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#1164
    str	w0,	[x5]

    movz	w15,	#84
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    movz	fp,	#1172
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1180
    str	w16,	[x11]

    ldr	x14,	[sp, fp]

    movz	fp,	#1188
    str	w8,	[x14]

    movz	w8,	#83
    ldr	x17,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1196
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1204
    str	w15,	[x20]

    movz	w15,	#87
    ldr	x23,	[sp, fp]

    mov	w9,	w15
    movz	fp,	#1212
    str	w8,	[x23]

    movz	w15,	#90
    movz	w8,	#86
    ldr	x26,	[sp, fp]

    mov	w16,	w15
    mov	w0,	w8
    movz	fp,	#1220
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#1228
    str	w9,	[x0]

    movz	w0,	#88
    ldr	x3,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1236
    str	w8,	[x3]

    movz	w8,	#89
    ldr	x6,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1244
    movz	w8,	#92
    str	w0,	[x6]

    movz	w0,	#91
    ldr	x9,	[sp, fp]

    movz	fp,	#1252
    str	w16,	[x9]

    ldr	x12,	[sp, fp]

    movz	fp,	#1260
    str	w0,	[x12]

    mov	w0,	w8
    ldr	x15,	[sp, fp]

    movz	fp,	#1268
    str	w0,	[x15]

    movz	w0,	#94
    movz	w15,	#93
    ldr	x18,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1276
    str	w15,	[x18]

    movz	w15,	#96
    ldr	x21,	[sp, fp]

    movz	fp,	#1284
    str	w8,	[x21]

    movz	w8,	#95
    ldr	x24,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1292
    movz	w8,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, fp]

    mov	w9,	w0
    movz	fp,	#1300
    str	w15,	[x27]

    mov	w0,	w8
    movz	w15,	#99
    ldr	x1,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#1308
    str	w9,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#1316
    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, fp]

    str	w16,	[x7]

    ldr	w8,	[sp, #1952]

    add	w18,	w8,	#1
    str	w18,	[sp, #416]

    ldr	w12,	[sp, #1964]

    mov	w8,	w12
    str	w8,	[sp, #1620]

    str	w0,	[sp, #1948]


main_254:
    ldr	w1,	[sp, #1948]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #1948]

    lsl	w0,	w2,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w8,	[x16]

    ldr	w9,	[sp, #1620]

    ldr	w3,	[sp, #1948]

    add	w0,	w8,	w9
    add	w25,	w3,	#1
    str	w25,	[sp, #1340]

    ldr	w26,	[sp, #1340]

    lsl	w16,	w26,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w27,	[sp, #1340]

    add	w19,	w0,	w10
    add	w0,	w27,	#1
    str	w0,	[sp, #1352]

    ldr	w1,	[sp, #1352]

    lsl	w8,	w1,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w2,	[sp, #1352]

    add	w9,	w19,	w8
    add	w18,	w2,	#1
    str	w18,	[sp, #1424]

    ldr	w19,	[sp, #1424]

    lsl	w0,	w19,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w20,	[sp, #1424]

    add	w0,	w9,	w0
    add	w22,	w20,	#1
    str	w22,	[sp, #1428]

    ldr	w23,	[sp, #1428]

    lsl	w16,	w23,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w17,	[x8]

    ldr	w24,	[sp, #1428]

    add	w18,	w0,	w17
    add	w26,	w24,	#1
    str	w26,	[sp, #1872]

    ldr	w27,	[sp, #1872]

    lsl	w8,	w27,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w28,	[sp, #1872]

    add	w10,	w18,	w0
    add	w4,	w28,	#1
    str	w4,	[sp, #1364]

    ldr	w5,	[sp, #1364]

    lsl	w0,	w5,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w16,	[x15]

    ldr	w6,	[sp, #1364]

    add	w0,	w10,	w16
    add	w9,	w6,	#1
    str	w9,	[sp, #484]

    ldr	w10,	[sp, #484]

    lsl	w16,	w10,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w11,	[sp, #484]

    add	w18,	w0,	w10
    add	w1,	w11,	#1
    str	w1,	[sp, #1876]

    ldr	w2,	[sp, #1876]

    lsl	w8,	w2,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w3,	[sp, #1876]

    add	w10,	w8,	w18
    add	w13,	w3,	#1
    str	w13,	[sp, #488]

    ldr	w14,	[sp, #488]

    lsl	w0,	w14,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w15,	[sp, #488]

    add	w0,	w10,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #500]

    ldr	w18,	[sp, #500]

    lsl	w17,	w18,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w19,	[sp, #500]

    add	w16,	w0,	w17
    add	w21,	w19,	#1
    str	w21,	[sp, #512]

    ldr	w22,	[sp, #512]

    lsl	w8,	w22,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w23,	[sp, #512]

    add	w8,	w16,	w0
    add	w25,	w23,	#1
    str	w25,	[sp, #516]

    ldr	w26,	[sp, #516]

    lsl	w0,	w26,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w27,	[sp, #516]

    add	w4,	w8,	w16
    add	w0,	w27,	#1
    str	w0,	[sp, #520]

    ldr	w1,	[sp, #520]

    lsl	w17,	w1,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w2,	[sp, #520]

    add	w17,	w4,	w10
    add	w5,	w2,	#1
    str	w5,	[sp, #1880]

    ldr	w6,	[sp, #1880]

    lsl	w8,	w6,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w7,	[sp, #1880]

    add	w11,	w17,	w8
    add	w4,	w7,	#1
    str	w4,	[sp, #556]

    ldr	w5,	[sp, #556]

    lsl	w0,	w5,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w6,	[sp, #556]

    add	w0,	w11,	w0
    add	w9,	w6,	#1
    str	w9,	[sp, #1884]

    ldr	w10,	[sp, #1884]

    lsl	w17,	w10,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w11,	[sp, #1884]

    add	w19,	w17,	w0
    add	w13,	w11,	#1
    str	w13,	[sp, #1896]

    ldr	w14,	[sp, #1896]

    lsl	w8,	w14,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #1896]

    add	w8,	w19,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #1900]

    ldr	w18,	[sp, #1900]

    lsl	w0,	w18,	#2
    mov	x17,	x0
    add	x17,	sp,	x17
    add	x17,	x17,	#16
    ldr	w17,	[x17]

    ldr	w19,	[sp, #1900]

    add	w0,	w8,	w17
    add	w8,	w19,	#1
    str	w8,	[sp, #560]

    ldr	w9,	[sp, #560]

    lsl	w17,	w9,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    add	w17,	w0,	w10
    ldr	w10,	[sp, #560]

    add	w21,	w10,	#1
    str	w21,	[sp, #1904]

    ldr	w22,	[sp, #1904]

    lsl	w8,	w22,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w23,	[sp, #1904]

    add	w8,	w17,	w8
    add	w12,	w23,	#1
    str	w12,	[sp, #564]

    ldr	w13,	[sp, #564]

    lsl	w0,	w13,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w14,	[sp, #564]

    add	w0,	w8,	w0
    add	w16,	w14,	#1
    str	w16,	[sp, #568]

    ldr	w17,	[sp, #568]

    lsl	w17,	w17,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w18,	[sp, #568]

    add	w16,	w0,	w17
    add	w20,	w18,	#1
    str	w20,	[sp, #580]

    ldr	w21,	[sp, #580]

    lsl	w8,	w21,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w22,	[sp, #580]

    add	w8,	w16,	w0
    add	w24,	w22,	#1
    str	w24,	[sp, #584]

    ldr	w25,	[sp, #584]

    lsl	w0,	w25,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w26,	[sp, #584]

    add	w1,	w16,	w8
    add	w28,	w26,	#1
    str	w28,	[sp, #588]

    ldr	w0,	[sp, #588]

    lsl	w17,	w0,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    add	w18,	w1,	w10
    ldr	w1,	[sp, #588]

    add	w3,	w1,	#1
    str	w3,	[sp, #592]

    ldr	w4,	[sp, #592]

    lsl	w8,	w4,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w5,	[sp, #592]

    add	w8,	w18,	w8
    add	w25,	w5,	#1
    str	w25,	[sp, #1908]

    ldr	w26,	[sp, #1908]

    lsl	w0,	w26,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w27,	[sp, #1908]

    add	w0,	w8,	w0
    add	w7,	w27,	#1
    str	w7,	[sp, #596]

    ldr	w8,	[sp, #596]

    lsl	w17,	w8,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w9,	[sp, #596]

    add	w18,	w0,	w17
    add	w11,	w9,	#1
    str	w11,	[sp, #600]

    ldr	w12,	[sp, #600]

    lsl	w8,	w12,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w13,	[sp, #600]

    add	w8,	w18,	w0
    add	w15,	w13,	#1
    str	w15,	[sp, #1376]

    ldr	w16,	[sp, #1376]

    lsl	w0,	w16,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w17,	[sp, #1376]

    add	w0,	w8,	w16
    add	w19,	w17,	#1
    str	w19,	[sp, #1380]

    ldr	w20,	[sp, #1380]

    lsl	w17,	w20,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w21,	[sp, #1380]

    add	w18,	w0,	w10
    add	w0,	w21,	#1
    str	w0,	[sp, #1912]

    ldr	w1,	[sp, #1912]

    lsl	w8,	w1,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w2,	[sp, #1912]

    add	w10,	w8,	w18
    add	w4,	w2,	#1
    str	w4,	[sp, #1916]

    ldr	w5,	[sp, #1916]

    lsl	w0,	w5,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w6,	[sp, #1916]

    add	w0,	w10,	w0
    add	w8,	w6,	#1
    str	w8,	[sp, #1920]

    ldr	w9,	[sp, #1920]

    lsl	w17,	w9,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w10,	[sp, #1920]

    add	w17,	w0,	w17
    add	w23,	w10,	#1
    str	w23,	[sp, #1384]

    ldr	w24,	[sp, #1384]

    lsl	w8,	w24,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w25,	[sp, #1384]

    add	w8,	w17,	w0
    add	w27,	w25,	#1
    str	w27,	[sp, #1388]

    ldr	w28,	[sp, #1388]

    lsl	w0,	w28,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w0,	[sp, #1388]

    add	w1,	w8,	w16
    add	w12,	w0,	#1
    str	w12,	[sp, #1924]

    ldr	w13,	[sp, #1924]

    lsl	w16,	w13,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    ldr	w14,	[sp, #1924]

    add	w16,	w1,	w9
    add	w2,	w14,	#1
    str	w2,	[sp, #1392]

    ldr	w3,	[sp, #1392]

    lsl	w8,	w3,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w4,	[sp, #1392]

    add	w9,	w16,	w8
    add	w16,	w4,	#1
    str	w16,	[sp, #1928]

    ldr	w17,	[sp, #1928]

    lsl	w0,	w17,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w18,	[sp, #1928]

    add	w16,	w9,	w0
    mov	w10,	w16
    add	w0,	w18,	#1
    str	w10,	[sp, #1620]

    mov	w4,	w0
    str	w4,	[sp, #1948]

    b	main_254

main_419:
    ldr	w5,	[sp, #1948]

    mov	w20,	w5
    str	w20,	[sp, #1932]

    ldr	w11,	[sp, #1620]

    mov	w4,	w11
    str	w4,	[sp, #1616]


main_421:
    ldr	w21,	[sp, #1932]

    lsl	w16,	w21,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w0,	[x8]

    ldr	w5,	[sp, #1616]

    ldr	w22,	[sp, #1932]

    add	w20,	w0,	w5
    add	w6,	w22,	#1
    str	w6,	[sp, #1404]

    ldr	w7,	[sp, #1404]

    lsl	w8,	w7,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w8,	[sp, #1404]

    add	w13,	w20,	w0
    add	w10,	w8,	#1
    str	w10,	[sp, #1408]

    ldr	w11,	[sp, #1408]

    lsl	w0,	w11,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w17,	[x16]

    ldr	w12,	[sp, #1408]

    add	w0,	w13,	w17
    add	w13,	w12,	#1
    str	w13,	[sp, #1632]

    ldr	w14,	[sp, #1632]

    lsl	w16,	w14,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w15,	[sp, #1632]

    add	w20,	w0,	w10
    add	w14,	w15,	#1
    str	w14,	[sp, #1420]

    ldr	w15,	[sp, #1420]

    lsl	w8,	w15,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w16,	[sp, #1420]

    add	w10,	w20,	w8
    add	w17,	w16,	#1
    str	w17,	[sp, #1652]

    ldr	w18,	[sp, #1652]

    lsl	w0,	w18,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w19,	[sp, #1652]

    add	w0,	w10,	w0
    add	w21,	w19,	#1
    str	w21,	[sp, #1328]

    ldr	w22,	[sp, #1328]

    lsl	w16,	w22,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w17,	[x8]

    ldr	w23,	[sp, #1328]

    add	w18,	w0,	w17
    add	w25,	w23,	#1
    str	w25,	[sp, #1936]

    ldr	w26,	[sp, #1936]

    lsl	w8,	w26,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w27,	[sp, #1936]

    add	w17,	w18,	w0
    add	w0,	w27,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w23,	w0
    mov	w6,	w17
    str	w23,	[sp, #1932]

    str	w6,	[sp, #1616]

    b	main_421

main_457:
    mov	w15,	w17

main_459:
    lsl	w9,	w0,	#2
    add	w0,	w0,	#1
    mov	x9,	x9
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    add	w16,	w9,	w15
    cmp	w0,	#100
    blt	main_458

main_467:
    movz	w0,	#65535
    ldr	w20,	[sp, #416]

    ldr	w18,	[sp, #1324]

    sdiv	w0,	w16,	w0
    lsl	w8,	w0,	#16
    sub	w8,	w8,	w0,	lsl #0
    sub	w0,	w16,	w8
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #1964]

    ldr	w20,	[sp, #416]

    mov	w9,	w20
    str	w9,	[sp, #1952]

    b	main_250

main_458:
    mov	w15,	w16
    b	main_459

main_470:
    movz	w0,	#0

main_472:
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#328
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2816
    ret


main_141:
    mov	w10,	w13
    b	main_142

