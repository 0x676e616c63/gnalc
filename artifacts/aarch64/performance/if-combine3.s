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
    str	w0,	[sp, #1416]

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
    lsl	w26,	w15,	#2
    movz	w11,	#0
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
    ldr	w18,	[sp, #1416]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x25,	sp,	#20
    movz	fp,	#1980
    add	x20,	sp,	#24
    add	x0,	sp,	#28
    add	x14,	sp,	#32
    add	x2,	sp,	#36
    add	x17,	sp,	#40
    add	x28,	sp,	#44
    add	x5,	sp,	#48
    add	x1,	sp,	#52
    add	x13,	sp,	#56
    add	x7,	sp,	#60
    add	x19,	sp,	#64
    add	x4,	sp,	#68
    add	x22,	sp,	#72
    add	x11,	sp,	#76
    add	x8,	sp,	#80
    add	x23,	sp,	#84
    add	x24,	sp,	#88
    add	x27,	sp,	#92
    add	x3,	sp,	#96
    add	x18,	sp,	#100
    add	x16,	sp,	#104
    add	x21,	sp,	#108
    add	x15,	sp,	#112
    add	x26,	sp,	#116
    add	x10,	sp,	#120
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x25,	[sp, fp]

    add	x25,	sp,	#128
    movz	fp,	#2076
    str	x20,	[sp, fp]

    add	x20,	sp,	#160
    movz	fp,	#2108
    str	x0,	[sp, fp]

    add	x0,	sp,	#172
    movz	fp,	#2060
    str	x14,	[sp, fp]

    add	x14,	sp,	#152
    movz	fp,	#2012
    str	x2,	[sp, fp]

    add	x2,	sp,	#136
    movz	fp,	#2068
    str	x17,	[sp, fp]

    add	x17,	sp,	#156
    movz	fp,	#1996
    str	x28,	[sp, fp]

    add	x28,	sp,	#132
    movz	fp,	#2020
    str	x5,	[sp, fp]

    add	x5,	sp,	#140
    movz	fp,	#1852
    str	x1,	[sp, fp]

    add	x1,	sp,	#212
    movz	fp,	#1908
    str	x13,	[sp, fp]

    add	x13,	sp,	#228
    movz	fp,	#1876
    str	x7,	[sp, fp]

    add	x7,	sp,	#220
    movz	fp,	#1948
    str	x19,	[sp, fp]

    add	x19,	sp,	#236
    movz	fp,	#1860
    str	x4,	[sp, fp]

    add	x4,	sp,	#216
    movz	fp,	#1964
    str	x22,	[sp, fp]

    add	x22,	sp,	#124
    movz	fp,	#2044
    str	x11,	[sp, fp]

    add	x11,	sp,	#148
    movz	fp,	#2036
    str	x8,	[sp, fp]

    add	x8,	sp,	#144
    movz	fp,	#2084
    str	x23,	[sp, fp]

    add	x23,	sp,	#164
    movz	fp,	#1828
    str	x24,	[sp, fp]

    add	x24,	sp,	#204
    movz	fp,	#1836
    str	x27,	[sp, fp]

    add	x27,	sp,	#208
    movz	fp,	#2116
    str	x3,	[sp, fp]

    add	x3,	sp,	#176
    movz	fp,	#1796
    str	x18,	[sp, fp]

    add	x18,	sp,	#196
    movz	fp,	#1924
    str	x16,	[sp, fp]

    add	x16,	sp,	#232
    movz	fp,	#1812
    str	x21,	[sp, fp]

    add	x21,	sp,	#200
    movz	fp,	#1788
    str	x15,	[sp, fp]

    add	x15,	sp,	#192
    movz	fp,	#2100
    str	x26,	[sp, fp]

    add	x26,	sp,	#168
    movz	fp,	#1884
    str	x10,	[sp, fp]

    add	x10,	sp,	#224
    str	x22,	[sp, #880]

    add	x22,	sp,	#240
    str	x25,	[sp, #888]

    add	x25,	sp,	#244
    str	x28,	[sp, #896]

    add	x28,	sp,	#248
    str	x2,	[sp, #904]

    add	x2,	sp,	#252
    str	x5,	[sp, #912]

    add	x5,	sp,	#256
    str	x8,	[sp, #920]

    add	x8,	sp,	#260
    str	x11,	[sp, #928]

    add	x11,	sp,	#264
    str	x14,	[sp, #936]

    add	x14,	sp,	#268
    str	x17,	[sp, #944]

    add	x17,	sp,	#272
    str	x20,	[sp, #952]

    add	x20,	sp,	#276
    str	x23,	[sp, #960]

    add	x23,	sp,	#280
    str	x26,	[sp, #968]

    add	x26,	sp,	#284
    str	x0,	[sp, #976]

    add	x0,	sp,	#288
    str	x3,	[sp, #984]

    add	x3,	sp,	#292
    str	x6,	[sp, #992]

    add	x6,	sp,	#296
    str	x9,	[sp, #1000]

    add	x9,	sp,	#300
    str	x12,	[sp, #1008]

    add	x12,	sp,	#304
    str	x15,	[sp, #1016]

    add	x15,	sp,	#308
    str	x18,	[sp, #1024]

    add	x18,	sp,	#312
    str	x21,	[sp, #1032]

    add	x21,	sp,	#316
    str	x24,	[sp, #1040]

    add	x24,	sp,	#320
    str	x27,	[sp, #1048]

    add	x27,	sp,	#324
    str	x1,	[sp, #1056]

    add	x1,	sp,	#328
    str	x4,	[sp, #1064]

    add	x4,	sp,	#332
    str	x7,	[sp, #1072]

    add	x7,	sp,	#336
    str	x10,	[sp, #1080]

    add	x10,	sp,	#340
    str	x13,	[sp, #1088]

    add	x13,	sp,	#344
    str	x16,	[sp, #1096]

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
    str	x11,	[sp, #1104]

    add	x11,	sp,	#380
    str	x14,	[sp, #1112]

    add	x14,	sp,	#384
    str	x17,	[sp, #1120]

    add	x17,	sp,	#388
    str	x20,	[sp, #1128]

    add	x20,	sp,	#392
    str	x23,	[sp, #1136]

    add	x23,	sp,	#396
    str	x26,	[sp, #1152]

    add	x26,	sp,	#400
    str	x0,	[sp, #1160]

    add	x0,	sp,	#404
    str	x3,	[sp, #1168]

    add	x3,	sp,	#408
    str	x6,	[sp, #1176]

    add	x6,	sp,	#412
    str	x9,	[sp, #1184]

    str	x12,	[sp, #1192]

    movz	w12,	#0
    str	x15,	[sp, #1200]

    str	x18,	[sp, #1208]

    str	x21,	[sp, #1216]

    str	x24,	[sp, #1224]

    str	x27,	[sp, #1232]

    str	x1,	[sp, #1240]

    str	x4,	[sp, #1248]

    str	x7,	[sp, #1256]

    mov	w7,	w12
    str	x10,	[sp, #1264]

    str	x13,	[sp, #1280]

    str	x16,	[sp, #1288]

    str	x19,	[sp, #1296]

    str	x22,	[sp, #1304]

    str	x25,	[sp, #1312]

    str	x28,	[sp, #1272]

    str	x2,	[sp, #1320]

    str	x5,	[sp, #1328]

    movz	w5,	#0
    str	x8,	[sp, #1336]

    str	x11,	[sp, #1344]

    mov	w11,	w5
    str	x14,	[sp, #1352]

    str	x17,	[sp, #1360]

    str	x20,	[sp, #1368]

    str	x23,	[sp, #1376]

    str	x26,	[sp, #1384]

    str	x0,	[sp, #1392]

    str	x3,	[sp, #1400]

    str	x6,	[sp, #1408]

    str	w11,	[sp, #1776]

    str	w7,	[sp, #1764]


main_250:
    movz	w0,	#1
    movz	fp,	#1980
    movz	w12,	#3
    mov	w5,	w0
    ldr	x26,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#2076
    str	w5,	[x26]

    movz	w12,	#6
    movz	w5,	#2
    ldr	x21,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2108
    str	w0,	[x21]

    movz	w0,	#4
    ldr	x1,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2060
    str	w13,	[x1]

    ldr	x15,	[sp, fp]

    movz	fp,	#2012
    str	w5,	[x15]

    movz	w5,	#5
    ldr	x3,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2068
    movz	w5,	#8
    str	w0,	[x3]

    movz	w0,	#7
    ldr	x18,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1996
    str	w12,	[x18]

    movz	w12,	#9
    ldr	x0,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#2020
    str	w6,	[x0]

    movz	w12,	#12
    ldr	x6,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1852
    str	w0,	[x6]

    movz	w0,	#10
    ldr	x2,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1908
    str	w13,	[x2]

    ldr	x14,	[sp, fp]

    movz	fp,	#1876
    str	w5,	[x14]

    movz	w5,	#11
    ldr	x8,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1948
    str	w0,	[x8]

    movz	w0,	#13
    ldr	x20,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1860
    str	w12,	[x20]

    movz	w12,	#15
    ldr	x5,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#1964
    str	w6,	[x5]

    movz	w5,	#14
    ldr	x23,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2044
    str	w0,	[x23]

    movz	w0,	#16
    ldr	x12,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2036
    str	w13,	[x12]

    movz	w12,	#18
    ldr	x9,	[sp, fp]

    movz	fp,	#2084
    str	w5,	[x9]

    movz	w5,	#17
    ldr	x24,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1828
    str	w0,	[x24]

    movz	w0,	#19
    ldr	x25,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1836
    str	w12,	[x25]

    movz	w12,	#21
    ldr	x28,	[sp, fp]

    movz	fp,	#2116
    str	w5,	[x28]

    movz	w5,	#20
    ldr	x4,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1796
    str	w0,	[x4]

    movz	w0,	#22
    ldr	x19,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1924
    str	w12,	[x19]

    movz	w12,	#24
    ldr	x17,	[sp, fp]

    movz	fp,	#1812
    str	w5,	[x17]

    movz	w5,	#23
    ldr	x22,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1788
    str	w0,	[x22]

    movz	w0,	#25
    ldr	x16,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2100
    str	w12,	[x16]

    movz	w12,	#27
    ldr	x27,	[sp, fp]

    movz	fp,	#1884
    str	w5,	[x27]

    movz	w5,	#26
    ldr	x11,	[sp, fp]

    mov	w0,	w5
    str	w0,	[x11]

    movz	w0,	#28
    ldr	x22,	[sp, #880]

    mov	w5,	w0
    str	w12,	[x22]

    movz	w12,	#30
    ldr	x25,	[sp, #888]

    mov	w13,	w12
    str	w5,	[x25]

    movz	w12,	#33
    ldr	x28,	[sp, #896]

    movz	w5,	#29
    mov	w0,	w5
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, #904]

    mov	w5,	w0
    str	w13,	[x2]

    mov	w13,	w12
    ldr	x6,	[sp, #912]

    movz	w12,	#36
    str	w5,	[x6]

    ldr	x9,	[sp, #920]

    movz	w5,	#32
    mov	w0,	w5
    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, #928]

    mov	w5,	w0
    str	w13,	[x11]

    ldr	x15,	[sp, #936]

    str	w5,	[x15]

    ldr	x18,	[sp, #944]

    movz	w5,	#35
    mov	w0,	w5
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, #952]

    mov	w5,	w0
    str	w12,	[x21]

    movz	w12,	#39
    ldr	x24,	[sp, #960]

    mov	w13,	w12
    str	w5,	[x24]

    movz	w12,	#42
    ldr	x27,	[sp, #968]

    movz	w5,	#38
    mov	w0,	w5
    movz	w5,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, #976]

    mov	w6,	w0
    str	w13,	[x1]

    mov	w0,	w5
    mov	w13,	w12
    ldr	x4,	[sp, #984]

    movz	w12,	#45
    str	w6,	[x4]

    ldr	x8,	[sp, #992]

    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, #1000]

    mov	w5,	w0
    str	w13,	[x10]

    ldr	x14,	[sp, #1008]

    str	w5,	[x14]

    ldr	x17,	[sp, #1016]

    movz	w5,	#44
    mov	w0,	w5
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, #1024]

    mov	w5,	w0
    str	w12,	[x20]

    movz	w12,	#48
    ldr	x23,	[sp, #1032]

    mov	w13,	w12
    str	w5,	[x23]

    movz	w12,	#51
    ldr	x26,	[sp, #1040]

    movz	w5,	#47
    mov	w0,	w5
    movz	w5,	#50
    str	w0,	[x26]

    ldr	x0,	[sp, #1048]

    str	w13,	[x0]

    mov	w13,	w12
    ldr	x3,	[sp, #1056]

    movz	w0,	#49
    movz	w12,	#54
    mov	w6,	w0
    mov	w0,	w5
    str	w6,	[x3]

    ldr	x7,	[sp, #1064]

    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, #1072]

    mov	w5,	w0
    str	w13,	[x9]

    ldr	x13,	[sp, #1080]

    str	w5,	[x13]

    ldr	x16,	[sp, #1088]

    movz	w5,	#53
    mov	w0,	w5
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, #1096]

    mov	w5,	w0
    str	w12,	[x19]

    movz	w12,	#57
    ldr	x22,	[sp, #416]

    str	w5,	[x22]

    ldr	x25,	[sp, #424]

    movz	w5,	#56
    mov	w0,	w5
    movz	w5,	#59
    str	w0,	[x25]

    movz	w0,	#58
    ldr	x28,	[sp, #432]

    mov	w6,	w0
    str	w12,	[x28]

    mov	w0,	w5
    movz	w12,	#60
    ldr	x2,	[sp, #440]

    mov	w13,	w12
    str	w6,	[x2]

    ldr	x6,	[sp, #448]

    str	w0,	[x6]

    movz	w0,	#61
    ldr	x8,	[sp, #456]

    mov	w5,	w0
    str	w13,	[x8]

    movz	w0,	#64
    ldr	x9,	[sp, #464]

    str	w5,	[x9]

    ldr	x12,	[sp, #1104]

    movz	w5,	#62
    str	w5,	[x12]

    mov	w5,	w0
    ldr	x15,	[sp, #1112]

    movz	w12,	#63
    str	w12,	[x15]

    movz	w12,	#66
    ldr	x18,	[sp, #1120]

    str	w5,	[x18]

    ldr	x21,	[sp, #1128]

    movz	w5,	#65
    mov	w0,	w5
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, #1136]

    mov	w5,	w0
    str	w12,	[x24]

    movz	w12,	#69
    ldr	x27,	[sp, #1152]

    mov	w13,	w12
    str	w5,	[x27]

    movz	w12,	#72
    ldr	x1,	[sp, #1160]

    movz	w5,	#68
    mov	w0,	w5
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, #1168]

    mov	w5,	w0
    str	w13,	[x4]

    ldr	x7,	[sp, #1176]

    str	w5,	[x7]

    ldr	x10,	[sp, #1184]

    movz	w5,	#71
    mov	w0,	w5
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, #1192]

    mov	w5,	w0
    str	w12,	[x13]

    movz	w12,	#75
    ldr	x16,	[sp, #1200]

    str	w5,	[x16]

    ldr	x19,	[sp, #1208]

    movz	w5,	#74
    mov	w0,	w5
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, #1216]

    mov	w5,	w0
    str	w12,	[x22]

    movz	w12,	#78
    ldr	x25,	[sp, #1224]

    mov	w13,	w12
    str	w5,	[x25]

    movz	w12,	#81
    ldr	x28,	[sp, #1232]

    movz	w5,	#77
    mov	w0,	w5
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, #1240]

    str	w13,	[x2]

    mov	w13,	w12
    ldr	x5,	[sp, #1248]

    movz	w12,	#84
    str	w0,	[x5]

    ldr	x8,	[sp, #1256]

    movz	w5,	#80
    mov	w0,	w5
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, #1264]

    mov	w5,	w0
    str	w13,	[x11]

    ldr	x14,	[sp, #1280]

    str	w5,	[x14]

    ldr	x17,	[sp, #1288]

    movz	w5,	#83
    mov	w0,	w5
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, #1296]

    mov	w5,	w0
    str	w12,	[x20]

    movz	w12,	#87
    ldr	x23,	[sp, #1304]

    mov	w6,	w12
    str	w5,	[x23]

    movz	w12,	#90
    ldr	x26,	[sp, #1312]

    movz	w5,	#86
    mov	w13,	w12
    mov	w0,	w5
    movz	w5,	#89
    str	w0,	[x26]

    ldr	x0,	[sp, #1272]

    str	w6,	[x0]

    ldr	x3,	[sp, #1320]

    movz	w0,	#88
    mov	w6,	w0
    mov	w0,	w5
    str	w6,	[x3]

    movz	w5,	#92
    ldr	x6,	[sp, #1328]

    str	w0,	[x6]

    movz	w0,	#91
    ldr	x9,	[sp, #1336]

    str	w13,	[x9]

    ldr	x12,	[sp, #1344]

    str	w0,	[x12]

    movz	w12,	#93
    ldr	x15,	[sp, #1352]

    mov	w0,	w5
    str	w0,	[x15]

    movz	w0,	#94
    ldr	x18,	[sp, #1360]

    mov	w5,	w0
    str	w12,	[x18]

    movz	w12,	#96
    ldr	x21,	[sp, #1368]

    str	w5,	[x21]

    ldr	x24,	[sp, #1376]

    movz	w5,	#95
    mov	w0,	w5
    movz	w5,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, #1384]

    mov	w6,	w0
    str	w12,	[x27]

    mov	w0,	w5
    movz	w12,	#99
    ldr	x1,	[sp, #1392]

    mov	w13,	w12
    str	w6,	[x1]

    ldr	x4,	[sp, #1400]

    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, #1408]

    str	w13,	[x7]

    ldr	w8,	[sp, #1764]

    add	w18,	w8,	#1
    str	w18,	[sp, #472]

    ldr	w12,	[sp, #1776]

    mov	w8,	w12
    str	w8,	[sp, #808]

    str	w0,	[sp, #1760]


main_254:
    ldr	w1,	[sp, #1760]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #1760]

    lsl	w0,	w2,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w5,	[x13]

    ldr	w9,	[sp, #808]

    ldr	w3,	[sp, #1760]

    add	w0,	w5,	w9
    add	w4,	w3,	#1
    str	w4,	[sp, #1440]

    ldr	w5,	[sp, #1440]

    lsl	w13,	w5,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w6,	[sp, #1440]

    add	w17,	w0,	w7
    add	w15,	w6,	#1
    str	w15,	[sp, #876]

    ldr	w16,	[sp, #876]

    lsl	w5,	w16,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    add	w7,	w17,	w5
    ldr	w17,	[sp, #876]

    add	w19,	w17,	#1
    str	w19,	[sp, #1452]

    ldr	w20,	[sp, #1452]

    lsl	w0,	w20,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    ldr	w21,	[sp, #1452]

    add	w0,	w7,	w0
    add	w9,	w21,	#1
    str	w9,	[sp, #1604]

    ldr	w10,	[sp, #1604]

    lsl	w13,	w10,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w14,	[x5]

    ldr	w11,	[sp, #1604]

    add	w17,	w0,	w14
    add	w23,	w11,	#1
    str	w23,	[sp, #1456]

    ldr	w24,	[sp, #1456]

    lsl	w5,	w24,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w25,	[sp, #1456]

    add	w7,	w17,	w0
    add	w27,	w25,	#1
    str	w27,	[sp, #1460]

    ldr	w28,	[sp, #1460]

    lsl	w0,	w28,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w14,	[x13]

    ldr	w0,	[sp, #1460]

    add	w1,	w7,	w14
    add	w2,	w0,	#1
    str	w2,	[sp, #1472]

    ldr	w3,	[sp, #1472]

    lsl	w12,	w3,	#2
    mov	x6,	x12
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w4,	[sp, #1472]

    add	w18,	w1,	w6
    add	w13,	w4,	#1
    str	w13,	[sp, #1608]

    ldr	w14,	[sp, #1608]

    lsl	w5,	w14,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w15,	[sp, #1608]

    add	w5,	w5,	w18
    add	w6,	w15,	#1
    str	w6,	[sp, #1476]

    ldr	w7,	[sp, #1476]

    lsl	w0,	w7,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w8,	[sp, #1476]

    add	w0,	w5,	w0
    add	w17,	w8,	#1
    str	w17,	[sp, #1612]

    ldr	w18,	[sp, #1612]

    lsl	w14,	w18,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w19,	[sp, #1612]

    add	w15,	w0,	w14
    add	w10,	w19,	#1
    str	w10,	[sp, #1480]

    ldr	w11,	[sp, #1480]

    lsl	w5,	w11,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w12,	[sp, #1480]

    add	w5,	w15,	w0
    add	w21,	w12,	#1
    str	w21,	[sp, #1616]

    ldr	w22,	[sp, #1616]

    lsl	w0,	w22,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w23,	[sp, #1616]

    add	w0,	w5,	w13
    add	w14,	w23,	#1
    str	w14,	[sp, #1484]

    ldr	w15,	[sp, #1484]

    lsl	w13,	w15,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w16,	[sp, #1484]

    add	w12,	w0,	w6
    add	w25,	w16,	#1
    str	w25,	[sp, #1620]

    ldr	w26,	[sp, #1620]

    lsl	w5,	w26,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w27,	[sp, #1620]

    add	w5,	w12,	w5
    add	w18,	w27,	#1
    str	w18,	[sp, #1504]

    ldr	w19,	[sp, #1504]

    lsl	w0,	w19,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w20,	[sp, #1504]

    add	w0,	w5,	w0
    add	w22,	w20,	#1
    str	w22,	[sp, #1508]

    ldr	w23,	[sp, #1508]

    lsl	w14,	w23,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w24,	[sp, #1508]

    add	w13,	w14,	w0
    add	w26,	w24,	#1
    str	w26,	[sp, #1512]

    ldr	w27,	[sp, #1512]

    lsl	w5,	w27,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w28,	[sp, #1512]

    add	w7,	w13,	w0
    add	w0,	w28,	#1
    str	w0,	[sp, #1632]

    ldr	w1,	[sp, #1632]

    lsl	w0,	w1,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w2,	[sp, #1632]

    add	w0,	w7,	w13
    add	w4,	w2,	#1
    str	w4,	[sp, #1644]

    ldr	w5,	[sp, #1644]

    lsl	w14,	w5,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w6,	[sp, #1644]

    add	w15,	w0,	w7
    add	w8,	w6,	#1
    str	w8,	[sp, #836]

    ldr	w9,	[sp, #836]

    lsl	w5,	w9,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w10,	[sp, #836]

    add	w7,	w15,	w5
    add	w1,	w10,	#1
    str	w1,	[sp, #1656]

    ldr	w2,	[sp, #1656]

    lsl	w0,	w2,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w3,	[sp, #1656]

    add	w0,	w7,	w0
    add	w5,	w3,	#1
    str	w5,	[sp, #1660]

    ldr	w6,	[sp, #1660]

    lsl	w14,	w6,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w7,	[sp, #1660]

    add	w17,	w0,	w14
    add	w9,	w7,	#1
    str	w9,	[sp, #1672]

    ldr	w10,	[sp, #1672]

    lsl	w5,	w10,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w11,	[sp, #1672]

    add	w5,	w17,	w0
    add	w13,	w11,	#1
    str	w13,	[sp, #1676]

    ldr	w14,	[sp, #1676]

    lsl	w0,	w14,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w15,	[sp, #1676]

    add	w0,	w14,	w5
    add	w17,	w15,	#1
    str	w17,	[sp, #1696]

    ldr	w18,	[sp, #1696]

    lsl	w13,	w18,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w19,	[sp, #1696]

    add	w13,	w0,	w6
    add	w21,	w19,	#1
    str	w21,	[sp, #1700]

    ldr	w22,	[sp, #1700]

    lsl	w5,	w22,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w23,	[sp, #1700]

    add	w5,	w13,	w5
    add	w12,	w23,	#1
    str	w12,	[sp, #840]

    ldr	w13,	[sp, #840]

    lsl	w0,	w13,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w14,	[sp, #840]

    add	w0,	w5,	w0
    add	w16,	w14,	#1
    str	w16,	[sp, #848]

    ldr	w17,	[sp, #848]

    lsl	w14,	w17,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w18,	[sp, #848]

    add	w13,	w0,	w14
    add	w20,	w18,	#1
    str	w20,	[sp, #852]

    ldr	w21,	[sp, #852]

    lsl	w5,	w21,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w22,	[sp, #852]

    add	w5,	w13,	w0
    add	w25,	w22,	#1
    str	w25,	[sp, #1712]

    ldr	w26,	[sp, #1712]

    lsl	w0,	w26,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w27,	[sp, #1712]

    add	w2,	w5,	w14
    add	w0,	w27,	#1
    str	w0,	[sp, #1716]

    ldr	w1,	[sp, #1716]

    lsl	w13,	w1,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    add	w13,	w2,	w6
    ldr	w2,	[sp, #1716]

    add	w24,	w2,	#1
    str	w24,	[sp, #856]

    ldr	w25,	[sp, #856]

    lsl	w5,	w25,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w26,	[sp, #856]

    add	w7,	w5,	w13
    add	w4,	w26,	#1
    str	w4,	[sp, #1720]

    ldr	w5,	[sp, #1720]

    lsl	w0,	w5,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w6,	[sp, #1720]

    add	w1,	w7,	w0
    add	w28,	w6,	#1
    str	w28,	[sp, #860]

    ldr	w0,	[sp, #860]

    lsl	w14,	w0,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    add	w17,	w1,	w14
    ldr	w1,	[sp, #860]

    add	w3,	w1,	#1
    str	w3,	[sp, #864]

    ldr	w4,	[sp, #864]

    lsl	w5,	w4,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w5,	[sp, #864]

    add	w7,	w17,	w0
    add	w8,	w5,	#1
    str	w8,	[sp, #1724]

    ldr	w9,	[sp, #1724]

    lsl	w0,	w9,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w10,	[sp, #1724]

    add	w0,	w7,	w14
    add	w12,	w10,	#1
    str	w12,	[sp, #1736]

    ldr	w13,	[sp, #1736]

    lsl	w13,	w13,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w14,	[sp, #1736]

    add	w15,	w0,	w6
    add	w7,	w14,	#1
    str	w7,	[sp, #868]

    ldr	w8,	[sp, #868]

    lsl	w5,	w8,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w9,	[sp, #868]

    add	w5,	w15,	w5
    add	w16,	w9,	#1
    str	w16,	[sp, #1748]

    ldr	w17,	[sp, #1748]

    lsl	w0,	w17,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w18,	[sp, #1748]

    add	w13,	w5,	w0
    mov	w10,	w13
    add	w0,	w18,	#1
    str	w10,	[sp, #808]

    mov	w4,	w0
    str	w4,	[sp, #1760]

    b	main_254

main_419:
    ldr	w5,	[sp, #1760]

    mov	w20,	w5
    str	w20,	[sp, #1752]

    ldr	w11,	[sp, #808]

    mov	w4,	w11
    str	w4,	[sp, #796]


main_421:
    ldr	w21,	[sp, #1752]

    lsl	w13,	w21,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w0,	[x5]

    ldr	w5,	[sp, #796]

    ldr	w22,	[sp, #1752]

    add	w18,	w0,	w5
    add	w13,	w22,	#1
    str	w13,	[sp, #1420]

    ldr	w14,	[sp, #1420]

    lsl	w5,	w14,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #1420]

    add	w6,	w18,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #1424]

    ldr	w18,	[sp, #1424]

    lsl	w0,	w18,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w13,	[x12]

    ldr	w19,	[sp, #1424]

    add	w0,	w6,	w13
    add	w21,	w19,	#1
    str	w21,	[sp, #1428]

    ldr	w22,	[sp, #1428]

    lsl	w13,	w22,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w23,	[sp, #1428]

    add	w15,	w0,	w7
    add	w25,	w23,	#1
    str	w25,	[sp, #1432]

    ldr	w26,	[sp, #1432]

    lsl	w5,	w26,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w27,	[sp, #1432]

    add	w6,	w15,	w5
    add	w11,	w27,	#1
    str	w11,	[sp, #872]

    ldr	w12,	[sp, #872]

    lsl	w0,	w12,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    ldr	w13,	[sp, #872]

    add	w2,	w6,	w0
    add	w0,	w13,	#1
    str	w0,	[sp, #1436]

    ldr	w1,	[sp, #1436]

    lsl	w13,	w1,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w14,	[x5]

    add	w16,	w2,	w14
    ldr	w2,	[sp, #1436]

    add	w25,	w2,	#1
    str	w25,	[sp, #1756]

    ldr	w26,	[sp, #1756]

    lsl	w5,	w26,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w27,	[sp, #1756]

    add	w14,	w16,	w0
    add	w0,	w27,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w23,	w0
    mov	w6,	w14
    str	w23,	[sp, #1752]

    str	w6,	[sp, #796]

    b	main_421

main_457:
    mov	w12,	w14

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
    ldr	w20,	[sp, #472]

    ldr	w18,	[sp, #1416]

    sdiv	w0,	w13,	w0
    lsl	w5,	w0,	#16
    sub	w5,	w5,	w0,	lsl #0
    sub	w0,	w13,	w5
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #1776]

    ldr	w20,	[sp, #472]

    mov	w9,	w20
    str	w9,	[sp, #1764]

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

