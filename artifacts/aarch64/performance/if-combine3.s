.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2848
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#324
    bl	_sysy_starttime
    bl	getint
    movz	w17,	#0
    str	w0,	[sp, #1380]

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
    add	w15,	w12,	#1
    movz	w4,	#0
    str	w2,	[x18]

    mov	x21,	x27
    lsl	w1,	w15,	#2
    add	w18,	w15,	#1
    mov	w27,	w4
    add	x21,	sp,	x21
    mov	x22,	x1
    add	w16,	w18,	#1
    lsl	w4,	w18,	#2
    add	x21,	x21,	#16
    add	x22,	sp,	x22
    movz	w18,	#0
    add	w28,	w16,	#1
    lsl	w7,	w16,	#2
    str	w0,	[x21]

    add	x22,	x22,	#16
    mov	w21,	w9
    mov	x0,	x7
    add	w2,	w28,	#1
    lsl	w10,	w28,	#2
    str	w27,	[x22]

    add	x0,	sp,	x0
    mov	x3,	x10
    mov	x27,	x4
    add	w1,	w2,	#1
    lsl	w13,	w2,	#2
    add	x0,	x0,	#16
    movz	w10,	#0
    add	x3,	sp,	x3
    add	x27,	sp,	x27
    add	w4,	w1,	#1
    lsl	w16,	w1,	#2
    mov	x6,	x13
    mov	w19,	w10
    add	x3,	x3,	#16
    add	x27,	x27,	#16
    add	w7,	w4,	#1
    mov	x9,	x16
    mov	w13,	w11
    add	x6,	sp,	x6
    movz	w10,	#0
    str	w25,	[x27]

    lsl	w22,	w7,	#2
    movz	w16,	#0
    add	x9,	sp,	x9
    add	x6,	x6,	#16
    mov	w15,	w10
    movz	w27,	#0
    str	w23,	[x0]

    add	w10,	w7,	#1
    add	x9,	x9,	#16
    str	w21,	[x3]

    mov	w7,	w14
    movz	w21,	#0
    lsl	w25,	w10,	#2
    mov	w3,	w18
    str	w19,	[x6]

    mov	x20,	x25
    lsl	w19,	w4,	#2
    str	w17,	[x9]

    add	x20,	sp,	x20
    mov	x12,	x19
    mov	x17,	x22
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
    add	w0,	w1,	#1
    movz	w14,	#0
    str	w27,	[x15]

    add	w6,	w0,	#1
    lsl	w28,	w0,	#2
    str	w25,	[x18]

    mov	x26,	x28
    movz	w18,	#0
    lsl	w25,	w1,	#2
    lsl	w2,	w6,	#2
    add	w28,	w6,	#1
    add	x26,	sp,	x26
    mov	w17,	w18
    mov	x21,	x25
    mov	x0,	x2
    add	w13,	w28,	#1
    lsl	w5,	w28,	#2
    add	x26,	x26,	#16
    add	x21,	sp,	x21
    add	x0,	sp,	x0
    mov	x2,	x5
    add	w9,	w13,	#1
    lsl	w8,	w13,	#2
    add	x21,	x21,	#16
    add	x2,	sp,	x2
    add	x0,	x0,	#16
    mov	x5,	x8
    add	x5,	sp,	x5
    str	w23,	[x21]

    add	x2,	x2,	#16
    mov	w21,	w14
    add	x5,	x5,	#16
    str	w21,	[x26]

    str	w19,	[x0]

    movz	w19,	#0
    str	w17,	[x2]

    mov	w15,	w19
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
    ldr	w18,	[sp, #1380]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x18,	sp,	#20
    add	x8,	sp,	#24
    add	x5,	sp,	#28
    add	x11,	sp,	#32
    add	x17,	sp,	#36
    add	x3,	sp,	#40
    add	x7,	sp,	#44
    add	x16,	sp,	#48
    add	x25,	sp,	#52
    add	x19,	sp,	#56
    add	x2,	sp,	#60
    add	x27,	sp,	#64
    add	x10,	sp,	#68
    add	x26,	sp,	#72
    add	x20,	sp,	#76
    add	x28,	sp,	#80
    add	x15,	sp,	#84
    add	x24,	sp,	#88
    add	x0,	sp,	#92
    add	x22,	sp,	#96
    add	x23,	sp,	#100
    add	x21,	sp,	#104
    add	x1,	sp,	#108
    add	x13,	sp,	#112
    add	x4,	sp,	#116
    add	x14,	sp,	#120
    movz	fp,	#820
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x18,	[sp, #1912]

    add	x18,	sp,	#196
    str	x8,	[sp, #2112]

    add	x8,	sp,	#144
    str	x5,	[sp, #2096]

    add	x5,	sp,	#140
    str	x11,	[sp, #2128]

    add	x11,	sp,	#148
    str	x17,	[sp, #2152]

    add	x17,	sp,	#156
    str	x3,	[sp, #2224]

    add	x3,	sp,	#176
    str	x7,	[sp, #1992]

    add	x7,	sp,	#220
    str	x16,	[sp, #2024]

    add	x16,	sp,	#232
    str	x25,	[sp, #2064]

    add	x25,	sp,	#128
    str	x19,	[sp, #2040]

    add	x19,	sp,	#236
    str	x2,	[sp, #2088]

    add	x2,	sp,	#136
    str	x27,	[sp, #1960]

    add	x27,	sp,	#208
    str	x10,	[sp, #2000]

    add	x10,	sp,	#224
    str	x26,	[sp, #2192]

    add	x26,	sp,	#168
    str	x20,	[sp, #2168]

    add	x20,	sp,	#160
    str	x28,	[sp, #2072]

    add	x28,	sp,	#132
    str	x15,	[sp, #1904]

    add	x15,	sp,	#192
    str	x24,	[sp, #1944]

    add	x24,	sp,	#204
    str	x0,	[sp, #2200]

    add	x0,	sp,	#172
    str	x22,	[sp, #2056]

    add	x22,	sp,	#124
    str	x23,	[sp, #2176]

    add	x23,	sp,	#164
    str	x21,	[sp, #1928]

    add	x21,	sp,	#200
    str	x1,	[sp, #1968]

    add	x1,	sp,	#212
    str	x13,	[sp, #2008]

    add	x13,	sp,	#228
    str	x4,	[sp, #1984]

    add	x4,	sp,	#216
    str	x14,	[sp, #2144]

    add	x14,	sp,	#152
    str	x22,	[sp, fp]

    add	x22,	sp,	#240
    movz	fp,	#828
    str	x25,	[sp, fp]

    add	x25,	sp,	#244
    movz	fp,	#836
    str	x28,	[sp, fp]

    add	x28,	sp,	#248
    movz	fp,	#844
    str	x2,	[sp, fp]

    add	x2,	sp,	#252
    movz	fp,	#852
    str	x5,	[sp, fp]

    add	x5,	sp,	#256
    movz	fp,	#860
    str	x8,	[sp, fp]

    add	x8,	sp,	#260
    movz	fp,	#868
    str	x11,	[sp, fp]

    add	x11,	sp,	#264
    movz	fp,	#876
    str	x14,	[sp, fp]

    add	x14,	sp,	#268
    movz	fp,	#884
    str	x17,	[sp, fp]

    add	x17,	sp,	#272
    movz	fp,	#892
    str	x20,	[sp, fp]

    add	x20,	sp,	#276
    movz	fp,	#900
    str	x23,	[sp, fp]

    add	x23,	sp,	#280
    movz	fp,	#908
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#916
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#924
    str	x3,	[sp, fp]

    add	x3,	sp,	#292
    movz	fp,	#932
    str	x6,	[sp, fp]

    add	x6,	sp,	#296
    movz	fp,	#940
    str	x9,	[sp, fp]

    add	x9,	sp,	#300
    movz	fp,	#948
    str	x12,	[sp, fp]

    add	x12,	sp,	#304
    movz	fp,	#956
    str	x15,	[sp, fp]

    add	x15,	sp,	#308
    movz	fp,	#964
    str	x18,	[sp, fp]

    add	x18,	sp,	#312
    movz	fp,	#972
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#980
    str	x24,	[sp, fp]

    add	x24,	sp,	#320
    movz	fp,	#988
    str	x27,	[sp, fp]

    add	x27,	sp,	#324
    movz	fp,	#996
    str	x1,	[sp, fp]

    add	x1,	sp,	#328
    movz	fp,	#1004
    str	x4,	[sp, fp]

    add	x4,	sp,	#332
    movz	fp,	#1020
    str	x7,	[sp, fp]

    add	x7,	sp,	#336
    movz	fp,	#1028
    str	x10,	[sp, fp]

    add	x10,	sp,	#340
    movz	fp,	#1036
    str	x13,	[sp, fp]

    add	x13,	sp,	#344
    movz	fp,	#1052
    str	x16,	[sp, #584]

    add	x16,	sp,	#348
    str	x19,	[sp, #424]

    add	x19,	sp,	#352
    str	x22,	[sp, #432]

    add	x22,	sp,	#356
    str	x25,	[sp, #440]

    add	x25,	sp,	#360
    str	x28,	[sp, #448]

    add	x28,	sp,	#364
    str	x2,	[sp, #456]

    add	x2,	sp,	#368
    str	x5,	[sp, #464]

    add	x5,	sp,	#372
    str	x8,	[sp, #472]

    add	x8,	sp,	#376
    str	x11,	[sp, fp]

    add	x11,	sp,	#380
    movz	fp,	#1060
    str	x14,	[sp, fp]

    add	x14,	sp,	#384
    movz	fp,	#1068
    str	x17,	[sp, fp]

    add	x17,	sp,	#388
    movz	fp,	#1076
    str	x20,	[sp, fp]

    add	x20,	sp,	#392
    movz	fp,	#1084
    str	x23,	[sp, fp]

    add	x23,	sp,	#396
    movz	fp,	#1092
    str	x26,	[sp, fp]

    add	x26,	sp,	#400
    movz	fp,	#1100
    str	x0,	[sp, fp]

    add	x0,	sp,	#404
    movz	fp,	#1116
    str	x3,	[sp, fp]

    add	x3,	sp,	#408
    movz	fp,	#1124
    str	x6,	[sp, fp]

    add	x6,	sp,	#412
    movz	fp,	#1132
    str	x9,	[sp, fp]

    movz	fp,	#1140
    str	x12,	[sp, fp]

    movz	w12,	#0
    movz	fp,	#1148
    str	x15,	[sp, fp]

    movz	fp,	#1156
    str	x18,	[sp, fp]

    movz	fp,	#1164
    str	x21,	[sp, fp]

    movz	fp,	#1172
    str	x24,	[sp, fp]

    movz	fp,	#1180
    str	x27,	[sp, fp]

    movz	fp,	#1188
    str	x1,	[sp, fp]

    movz	fp,	#1196
    str	x4,	[sp, fp]

    movz	fp,	#1204
    str	x7,	[sp, fp]

    mov	w7,	w12
    movz	fp,	#1212
    str	x10,	[sp, fp]

    movz	fp,	#1220
    str	x13,	[sp, fp]

    movz	fp,	#1228
    str	x16,	[sp, fp]

    movz	fp,	#1236
    str	x19,	[sp, fp]

    movz	fp,	#1244
    str	x22,	[sp, fp]

    movz	fp,	#1252
    str	x25,	[sp, fp]

    movz	fp,	#1260
    str	x28,	[sp, fp]

    movz	fp,	#1268
    str	x2,	[sp, fp]

    movz	fp,	#1276
    str	x5,	[sp, fp]

    movz	w5,	#0
    movz	fp,	#1284
    str	x8,	[sp, fp]

    movz	fp,	#1292
    str	x11,	[sp, fp]

    mov	w11,	w5
    movz	fp,	#1300
    str	x14,	[sp, fp]

    movz	fp,	#1308
    str	x17,	[sp, fp]

    movz	fp,	#1316
    str	x20,	[sp, fp]

    movz	fp,	#1324
    str	x23,	[sp, fp]

    movz	fp,	#1332
    str	x26,	[sp, fp]

    movz	fp,	#1348
    str	x0,	[sp, fp]

    movz	fp,	#1356
    str	x3,	[sp, fp]

    movz	fp,	#1364
    str	x6,	[sp, fp]

    str	w11,	[sp, #1900]

    str	w7,	[sp, #1848]


main_250:
    movz	w0,	#1
    ldr	x19,	[sp, #1912]

    movz	w12,	#3
    movz	fp,	#820
    mov	w5,	w0
    mov	w13,	w12
    str	w5,	[x19]

    ldr	x9,	[sp, #2112]

    movz	w5,	#2
    mov	w0,	w5
    str	w0,	[x9]

    movz	w0,	#4
    ldr	x6,	[sp, #2096]

    mov	w5,	w0
    str	w13,	[x6]

    ldr	x12,	[sp, #2128]

    str	w5,	[x12]

    movz	w12,	#6
    ldr	x18,	[sp, #2152]

    movz	w5,	#5
    mov	w13,	w12
    mov	w0,	w5
    movz	w12,	#9
    str	w0,	[x18]

    movz	w0,	#7
    ldr	x4,	[sp, #2224]

    mov	w5,	w0
    str	w13,	[x4]

    ldr	x8,	[sp, #1992]

    str	w5,	[x8]

    ldr	x17,	[sp, #2024]

    movz	w5,	#8
    mov	w0,	w5
    str	w0,	[x17]

    movz	w0,	#10
    ldr	x26,	[sp, #2064]

    mov	w5,	w0
    str	w12,	[x26]

    movz	w12,	#12
    ldr	x20,	[sp, #2040]

    str	w5,	[x20]

    ldr	x3,	[sp, #2088]

    movz	w5,	#11
    mov	w0,	w5
    str	w0,	[x3]

    movz	w0,	#13
    ldr	x28,	[sp, #1960]

    mov	w5,	w0
    str	w12,	[x28]

    movz	w12,	#15
    ldr	x11,	[sp, #2000]

    str	w5,	[x11]

    ldr	x27,	[sp, #2192]

    movz	w5,	#14
    mov	w0,	w5
    movz	w5,	#17
    str	w0,	[x27]

    movz	w0,	#16
    ldr	x21,	[sp, #2168]

    mov	w6,	w0
    str	w12,	[x21]

    movz	w12,	#18
    ldr	x0,	[sp, #2072]

    str	w6,	[x0]

    ldr	x16,	[sp, #1904]

    mov	w0,	w5
    movz	w5,	#20
    str	w0,	[x16]

    movz	w0,	#19
    ldr	x25,	[sp, #1944]

    mov	w6,	w0
    str	w12,	[x25]

    mov	w0,	w5
    movz	w12,	#21
    ldr	x1,	[sp, #2200]

    str	w6,	[x1]

    ldr	x23,	[sp, #2056]

    str	w0,	[x23]

    movz	w0,	#22
    ldr	x24,	[sp, #2176]

    mov	w5,	w0
    str	w12,	[x24]

    movz	w12,	#24
    ldr	x22,	[sp, #1928]

    str	w5,	[x22]

    ldr	x2,	[sp, #1968]

    movz	w5,	#23
    mov	w0,	w5
    str	w0,	[x2]

    movz	w0,	#25
    ldr	x14,	[sp, #2008]

    mov	w6,	w0
    str	w12,	[x14]

    movz	w12,	#27
    ldr	x5,	[sp, #1984]

    str	w6,	[x5]

    ldr	x15,	[sp, #2144]

    movz	w5,	#26
    mov	w0,	w5
    str	w0,	[x15]

    movz	w0,	#28
    ldr	x22,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#828
    str	w12,	[x22]

    movz	w12,	#30
    ldr	x25,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#836
    str	w5,	[x25]

    movz	w12,	#33
    ldr	x28,	[sp, fp]

    movz	w5,	#29
    movz	fp,	#844
    mov	w0,	w5
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#852
    str	w13,	[x2]

    mov	w13,	w12
    ldr	x6,	[sp, fp]

    movz	w12,	#36
    movz	fp,	#860
    str	w5,	[x6]

    ldr	x9,	[sp, fp]

    movz	w5,	#32
    movz	fp,	#868
    mov	w0,	w5
    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#876
    str	w13,	[x11]

    ldr	x15,	[sp, fp]

    movz	fp,	#884
    str	w5,	[x15]

    movz	w5,	#35
    ldr	x18,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#892
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#900
    str	w12,	[x21]

    movz	w12,	#39
    ldr	x24,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#908
    str	w5,	[x24]

    movz	w12,	#42
    movz	w5,	#38
    ldr	x27,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#916
    movz	w5,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#924
    str	w13,	[x1]

    mov	w0,	w5
    mov	w13,	w12
    ldr	x4,	[sp, fp]

    movz	w12,	#45
    movz	fp,	#932
    str	w6,	[x4]

    ldr	x8,	[sp, fp]

    movz	fp,	#940
    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#948
    str	w13,	[x10]

    ldr	x14,	[sp, fp]

    movz	fp,	#956
    str	w5,	[x14]

    movz	w5,	#44
    ldr	x17,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#964
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#972
    str	w12,	[x20]

    movz	w12,	#48
    ldr	x23,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#980
    str	w5,	[x23]

    movz	w12,	#51
    movz	w5,	#47
    ldr	x26,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#988
    movz	w5,	#50
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#996
    str	w13,	[x0]

    mov	w13,	w12
    movz	w0,	#49
    ldr	x3,	[sp, fp]

    movz	w12,	#54
    mov	w6,	w0
    movz	fp,	#1004
    mov	w0,	w5
    str	w6,	[x3]

    ldr	x7,	[sp, fp]

    movz	fp,	#1020
    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1028
    str	w13,	[x9]

    ldr	x13,	[sp, fp]

    movz	fp,	#1036
    str	w5,	[x13]

    movz	w5,	#53
    ldr	x16,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1052
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, #584]

    mov	w5,	w0
    str	w12,	[x19]

    movz	w12,	#57
    ldr	x22,	[sp, #424]

    str	w5,	[x22]

    ldr	x25,	[sp, #432]

    movz	w5,	#56
    mov	w0,	w5
    movz	w5,	#59
    str	w0,	[x25]

    movz	w0,	#58
    ldr	x28,	[sp, #440]

    mov	w6,	w0
    str	w12,	[x28]

    mov	w0,	w5
    movz	w12,	#60
    ldr	x2,	[sp, #448]

    mov	w13,	w12
    str	w6,	[x2]

    ldr	x6,	[sp, #456]

    str	w0,	[x6]

    movz	w0,	#61
    ldr	x8,	[sp, #464]

    mov	w5,	w0
    str	w13,	[x8]

    movz	w0,	#64
    ldr	x9,	[sp, #472]

    str	w5,	[x9]

    ldr	x12,	[sp, fp]

    movz	w5,	#62
    movz	fp,	#1060
    str	w5,	[x12]

    mov	w5,	w0
    ldr	x15,	[sp, fp]

    movz	w12,	#63
    movz	fp,	#1068
    str	w12,	[x15]

    movz	w12,	#66
    ldr	x18,	[sp, fp]

    movz	fp,	#1076
    str	w5,	[x18]

    movz	w5,	#65
    ldr	x21,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1084
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1092
    str	w12,	[x24]

    movz	w12,	#69
    ldr	x27,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#1100
    str	w5,	[x27]

    movz	w12,	#72
    movz	w5,	#68
    ldr	x1,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1116
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1124
    str	w13,	[x4]

    ldr	x7,	[sp, fp]

    movz	fp,	#1132
    str	w5,	[x7]

    movz	w5,	#71
    ldr	x10,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1140
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1148
    str	w12,	[x13]

    movz	w12,	#75
    ldr	x16,	[sp, fp]

    movz	fp,	#1156
    str	w5,	[x16]

    movz	w5,	#74
    ldr	x19,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1164
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1172
    str	w12,	[x22]

    movz	w12,	#78
    ldr	x25,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#1180
    str	w5,	[x25]

    movz	w12,	#81
    movz	w5,	#77
    ldr	x28,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1188
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, fp]

    movz	fp,	#1196
    str	w13,	[x2]

    mov	w13,	w12
    ldr	x5,	[sp, fp]

    movz	w12,	#84
    movz	fp,	#1204
    str	w0,	[x5]

    movz	w5,	#80
    ldr	x8,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1212
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1220
    str	w13,	[x11]

    ldr	x14,	[sp, fp]

    movz	fp,	#1228
    str	w5,	[x14]

    movz	w5,	#83
    ldr	x17,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1236
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1244
    str	w12,	[x20]

    movz	w12,	#87
    ldr	x23,	[sp, fp]

    mov	w6,	w12
    movz	fp,	#1252
    str	w5,	[x23]

    movz	w12,	#90
    movz	w5,	#86
    ldr	x26,	[sp, fp]

    mov	w13,	w12
    mov	w0,	w5
    movz	fp,	#1260
    movz	w5,	#89
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#1268
    str	w6,	[x0]

    movz	w0,	#88
    ldr	x3,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1276
    mov	w0,	w5
    str	w6,	[x3]

    movz	w5,	#92
    ldr	x6,	[sp, fp]

    movz	fp,	#1284
    str	w0,	[x6]

    movz	w0,	#91
    ldr	x9,	[sp, fp]

    movz	fp,	#1292
    str	w13,	[x9]

    ldr	x12,	[sp, fp]

    movz	fp,	#1300
    str	w0,	[x12]

    movz	w12,	#93
    mov	w0,	w5
    ldr	x15,	[sp, fp]

    movz	fp,	#1308
    str	w0,	[x15]

    movz	w0,	#94
    ldr	x18,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1316
    str	w12,	[x18]

    movz	w12,	#96
    ldr	x21,	[sp, fp]

    movz	fp,	#1324
    str	w5,	[x21]

    movz	w5,	#95
    ldr	x24,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1332
    movz	w5,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1348
    str	w12,	[x27]

    mov	w0,	w5
    movz	w12,	#99
    ldr	x1,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#1356
    str	w6,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#1364
    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, fp]

    str	w13,	[x7]

    ldr	w8,	[sp, #1848]

    add	w18,	w8,	#1
    str	w18,	[sp, #504]

    ldr	w12,	[sp, #1900]

    mov	w8,	w12
    str	w8,	[sp, #1600]

    str	w0,	[sp, #1844]


main_254:
    ldr	w1,	[sp, #1844]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #1844]

    lsl	w0,	w2,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w5,	[x13]

    ldr	w9,	[sp, #1600]

    ldr	w3,	[sp, #1844]

    add	w0,	w5,	w9
    add	w25,	w3,	#1
    str	w25,	[sp, #1392]

    ldr	w26,	[sp, #1392]

    lsl	w13,	w26,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w27,	[sp, #1392]

    add	w17,	w0,	w7
    add	w0,	w27,	#1
    str	w0,	[sp, #508]

    ldr	w1,	[sp, #508]

    lsl	w5,	w1,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w2,	[sp, #508]

    add	w7,	w17,	w5
    add	w10,	w2,	#1
    str	w10,	[sp, #1884]

    ldr	w11,	[sp, #1884]

    lsl	w0,	w11,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    ldr	w12,	[sp, #1884]

    add	w0,	w7,	w0
    add	w14,	w12,	#1
    str	w14,	[sp, #1888]

    ldr	w15,	[sp, #1888]

    lsl	w13,	w15,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w14,	[x5]

    ldr	w16,	[sp, #1888]

    add	w17,	w0,	w14
    add	w4,	w16,	#1
    str	w4,	[sp, #512]

    ldr	w5,	[sp, #512]

    lsl	w5,	w5,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w6,	[sp, #512]

    add	w7,	w17,	w0
    add	w18,	w6,	#1
    str	w18,	[sp, #596]

    ldr	w19,	[sp, #596]

    lsl	w0,	w19,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w14,	[x13]

    ldr	w20,	[sp, #596]

    add	w0,	w7,	w14
    add	w22,	w20,	#1
    str	w22,	[sp, #600]

    ldr	w23,	[sp, #600]

    lsl	w12,	w23,	#2
    mov	x6,	x12
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w24,	[sp, #600]

    add	w17,	w0,	w6
    add	w9,	w24,	#1
    str	w9,	[sp, #524]

    ldr	w10,	[sp, #524]

    lsl	w5,	w10,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w11,	[sp, #524]

    add	w6,	w5,	w17
    add	w13,	w11,	#1
    str	w13,	[sp, #528]

    ldr	w14,	[sp, #528]

    lsl	w0,	w14,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w15,	[sp, #528]

    add	w0,	w6,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #1532]

    ldr	w18,	[sp, #1532]

    lsl	w14,	w18,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w19,	[sp, #1532]

    add	w13,	w0,	w14
    add	w21,	w19,	#1
    str	w21,	[sp, #1536]

    ldr	w22,	[sp, #1536]

    lsl	w5,	w22,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w23,	[sp, #1536]

    add	w5,	w13,	w0
    add	w25,	w23,	#1
    str	w25,	[sp, #1540]

    ldr	w26,	[sp, #1540]

    lsl	w0,	w26,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w27,	[sp, #1540]

    add	w2,	w5,	w14
    add	w0,	w27,	#1
    str	w0,	[sp, #1544]

    ldr	w1,	[sp, #1544]

    lsl	w14,	w1,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    add	w17,	w2,	w7
    ldr	w2,	[sp, #1544]

    add	w4,	w2,	#1
    str	w4,	[sp, #1548]

    ldr	w5,	[sp, #1548]

    lsl	w5,	w5,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w6,	[sp, #1548]

    add	w5,	w17,	w5
    add	w8,	w6,	#1
    str	w8,	[sp, #1552]

    ldr	w9,	[sp, #1552]

    lsl	w0,	w9,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w10,	[sp, #1552]

    add	w0,	w5,	w0
    add	w26,	w10,	#1
    str	w26,	[sp, #604]

    ldr	w27,	[sp, #604]

    lsl	w14,	w27,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w28,	[sp, #604]

    add	w15,	w14,	w0
    add	w1,	w28,	#1
    str	w1,	[sp, #608]

    ldr	w2,	[sp, #608]

    lsl	w5,	w2,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w3,	[sp, #608]

    add	w8,	w15,	w0
    add	w5,	w3,	#1
    str	w5,	[sp, #612]

    ldr	w6,	[sp, #612]

    lsl	w0,	w6,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w7,	[sp, #612]

    add	w0,	w8,	w14
    add	w12,	w7,	#1
    str	w12,	[sp, #1728]

    ldr	w13,	[sp, #1728]

    lsl	w14,	w13,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w14,	[sp, #1728]

    add	w16,	w0,	w7
    add	w9,	w14,	#1
    str	w9,	[sp, #624]

    ldr	w10,	[sp, #624]

    lsl	w5,	w10,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w11,	[sp, #624]

    add	w5,	w16,	w5
    add	w13,	w11,	#1
    str	w13,	[sp, #628]

    ldr	w14,	[sp, #628]

    lsl	w0,	w14,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w15,	[sp, #628]

    add	w0,	w5,	w0
    add	w16,	w15,	#1
    str	w16,	[sp, #1740]

    ldr	w17,	[sp, #1740]

    lsl	w14,	w17,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w18,	[sp, #1740]

    add	w13,	w0,	w14
    add	w20,	w18,	#1
    str	w20,	[sp, #1744]

    ldr	w21,	[sp, #1744]

    lsl	w5,	w21,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w22,	[sp, #1744]

    add	w5,	w13,	w0
    add	w24,	w22,	#1
    str	w24,	[sp, #1748]

    ldr	w25,	[sp, #1748]

    lsl	w0,	w25,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w26,	[sp, #1748]

    add	w1,	w14,	w5
    add	w28,	w26,	#1
    str	w28,	[sp, #1760]

    ldr	w0,	[sp, #1760]

    lsl	w14,	w0,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    add	w14,	w1,	w7
    ldr	w1,	[sp, #1760]

    add	w17,	w1,	#1
    str	w17,	[sp, #632]

    ldr	w18,	[sp, #632]

    lsl	w5,	w18,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w19,	[sp, #632]

    add	w5,	w14,	w5
    add	w21,	w19,	#1
    str	w21,	[sp, #636]

    ldr	w22,	[sp, #636]

    lsl	w0,	w22,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w23,	[sp, #636]

    add	w0,	w5,	w0
    add	w25,	w23,	#1
    str	w25,	[sp, #656]

    ldr	w26,	[sp, #656]

    lsl	w14,	w26,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w27,	[sp, #656]

    add	w15,	w0,	w14
    add	w3,	w27,	#1
    str	w3,	[sp, #1764]

    ldr	w4,	[sp, #1764]

    lsl	w5,	w4,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w5,	[sp, #1764]

    add	w6,	w15,	w0
    add	w7,	w5,	#1
    str	w7,	[sp, #1768]

    ldr	w8,	[sp, #1768]

    lsl	w0,	w8,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w9,	[sp, #1768]

    add	w2,	w6,	w14
    add	w0,	w9,	#1
    str	w0,	[sp, #1792]

    ldr	w1,	[sp, #1792]

    lsl	w13,	w1,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    add	w17,	w2,	w6
    ldr	w2,	[sp, #1792]

    add	w4,	w2,	#1
    str	w4,	[sp, #1796]

    ldr	w5,	[sp, #1796]

    lsl	w5,	w5,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w6,	[sp, #1796]

    add	w5,	w5,	w17
    add	w11,	w6,	#1
    str	w11,	[sp, #1772]

    ldr	w12,	[sp, #1772]

    lsl	w0,	w12,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w13,	[sp, #1772]

    add	w0,	w5,	w0
    add	w8,	w13,	#1
    str	w8,	[sp, #1808]

    ldr	w9,	[sp, #1808]

    lsl	w14,	w9,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w10,	[sp, #1808]

    add	w17,	w0,	w14
    add	w12,	w10,	#1
    str	w12,	[sp, #1812]

    ldr	w13,	[sp, #1812]

    lsl	w5,	w13,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w14,	[sp, #1812]

    add	w5,	w17,	w0
    add	w15,	w14,	#1
    str	w15,	[sp, #1860]

    ldr	w16,	[sp, #1860]

    lsl	w0,	w16,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w17,	[sp, #1860]

    add	w0,	w5,	w14
    add	w16,	w17,	#1
    str	w16,	[sp, #1824]

    ldr	w17,	[sp, #1824]

    lsl	w13,	w17,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w18,	[sp, #1824]

    add	w12,	w0,	w6
    add	w19,	w18,	#1
    str	w19,	[sp, #1864]

    ldr	w20,	[sp, #1864]

    lsl	w5,	w20,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w21,	[sp, #1864]

    add	w5,	w12,	w5
    add	w20,	w21,	#1
    str	w20,	[sp, #1828]

    ldr	w21,	[sp, #1828]

    lsl	w0,	w21,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w22,	[sp, #1828]

    add	w14,	w5,	w0
    mov	w10,	w14
    add	w0,	w22,	#1
    str	w10,	[sp, #1600]

    mov	w4,	w0
    str	w4,	[sp, #1844]

    b	main_254

main_419:
    ldr	w5,	[sp, #1844]

    mov	w24,	w5
    str	w24,	[sp, #1840]

    ldr	w11,	[sp, #1600]

    mov	w4,	w11
    str	w4,	[sp, #592]


main_421:
    ldr	w25,	[sp, #1840]

    lsl	w13,	w25,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w0,	[x5]

    ldr	w5,	[sp, #592]

    ldr	w26,	[sp, #1840]

    add	w18,	w0,	w5
    add	w13,	w26,	#1
    str	w13,	[sp, #1564]

    ldr	w14,	[sp, #1564]

    lsl	w5,	w14,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #1564]

    add	w6,	w18,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #1412]

    ldr	w18,	[sp, #1412]

    lsl	w0,	w18,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w14,	[x13]

    ldr	w19,	[sp, #1412]

    add	w0,	w6,	w14
    add	w23,	w19,	#1
    str	w23,	[sp, #1868]

    ldr	w24,	[sp, #1868]

    lsl	w12,	w24,	#2
    mov	x5,	x12
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w6,	[x5]

    ldr	w25,	[sp, #1868]

    add	w14,	w0,	w6
    add	w21,	w25,	#1
    str	w21,	[sp, #548]

    ldr	w22,	[sp, #548]

    lsl	w5,	w22,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w23,	[sp, #548]

    add	w6,	w14,	w5
    add	w27,	w23,	#1
    str	w27,	[sp, #1872]

    ldr	w28,	[sp, #1872]

    lsl	w0,	w28,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    add	w1,	w6,	w0
    ldr	w0,	[sp, #1872]

    add	w2,	w0,	#1
    str	w2,	[sp, #1876]

    ldr	w3,	[sp, #1876]

    lsl	w13,	w3,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w14,	[x5]

    ldr	w4,	[sp, #1876]

    add	w17,	w1,	w14
    add	w6,	w4,	#1
    str	w6,	[sp, #1880]

    ldr	w7,	[sp, #1880]

    lsl	w5,	w7,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w8,	[sp, #1880]

    add	w16,	w17,	w0
    add	w0,	w8,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w27,	w0
    mov	w6,	w16
    str	w27,	[sp, #1840]

    str	w6,	[sp, #592]

    b	main_421

main_457:
    mov	w12,	w16

main_459:
    lsl	w6,	w0,	#2
    add	w0,	w0,	#1
    mov	x6,	x6
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    add	w13,	w6,	w12
    cmp	w0,	#100
    blt	main_458

main_467:
    movz	w0,	#65535
    ldr	w20,	[sp, #504]

    ldr	w18,	[sp, #1380]

    sdiv	w0,	w13,	w0
    lsl	w5,	w0,	#16
    sub	w5,	w5,	w0,	lsl #0
    sub	w0,	w13,	w5
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #1900]

    ldr	w20,	[sp, #504]

    mov	w9,	w20
    str	w9,	[sp, #1848]

    b	main_250

main_458:
    mov	w12,	w13
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
    
    add	sp, sp, #2848
    ret


main_141:
    mov	w10,	w13
    b	main_142

