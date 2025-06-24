.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2832
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#324
    bl	_sysy_starttime
    bl	getint
    movz	w17,	#0
    str	w0,	[sp, #1368]

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
    mov	w3,	w18
    add	x9,	x9,	#16
    movz	w21,	#0
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
    add	w17,	w10,	#1
    movz	w13,	#0
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
    ldr	w18,	[sp, #1368]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x16,	sp,	#20
    movz	fp,	#2020
    add	x3,	sp,	#24
    add	x24,	sp,	#28
    add	x21,	sp,	#32
    add	x19,	sp,	#36
    add	x14,	sp,	#40
    add	x5,	sp,	#44
    add	x13,	sp,	#48
    add	x2,	sp,	#52
    add	x26,	sp,	#56
    add	x15,	sp,	#60
    add	x10,	sp,	#64
    add	x28,	sp,	#68
    add	x0,	sp,	#72
    add	x20,	sp,	#76
    add	x8,	sp,	#80
    add	x7,	sp,	#84
    add	x18,	sp,	#88
    add	x22,	sp,	#92
    add	x23,	sp,	#96
    add	x11,	sp,	#100
    add	x17,	sp,	#104
    add	x27,	sp,	#108
    add	x25,	sp,	#112
    add	x1,	sp,	#116
    add	x4,	sp,	#120
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x16,	[sp, fp]

    add	x16,	sp,	#232
    movz	fp,	#2156
    str	x3,	[sp, fp]

    add	x3,	sp,	#176
    movz	fp,	#1940
    str	x24,	[sp, fp]

    add	x24,	sp,	#204
    movz	fp,	#1932
    str	x21,	[sp, fp]

    add	x21,	sp,	#200
    movz	fp,	#2028
    str	x19,	[sp, fp]

    add	x19,	sp,	#236
    movz	fp,	#2108
    str	x14,	[sp, fp]

    add	x14,	sp,	#152
    movz	fp,	#2084
    str	x5,	[sp, fp]

    add	x5,	sp,	#140
    movz	fp,	#2004
    str	x13,	[sp, fp]

    add	x13,	sp,	#228
    movz	fp,	#2068
    str	x2,	[sp, fp]

    add	x2,	sp,	#136
    movz	fp,	#2140
    str	x26,	[sp, fp]

    add	x26,	sp,	#168
    movz	fp,	#1908
    str	x15,	[sp, fp]

    add	x15,	sp,	#192
    movz	fp,	#1988
    str	x10,	[sp, fp]

    add	x10,	sp,	#224
    movz	fp,	#2060
    str	x28,	[sp, fp]

    add	x28,	sp,	#132
    movz	fp,	#2148
    str	x0,	[sp, fp]

    add	x0,	sp,	#172
    movz	fp,	#2124
    str	x20,	[sp, fp]

    add	x20,	sp,	#160
    movz	fp,	#2092
    str	x8,	[sp, fp]

    add	x8,	sp,	#144
    movz	fp,	#1980
    str	x7,	[sp, fp]

    add	x7,	sp,	#220
    movz	fp,	#1924
    str	x18,	[sp, fp]

    add	x18,	sp,	#196
    movz	fp,	#2044
    str	x22,	[sp, fp]

    add	x22,	sp,	#124
    movz	fp,	#2132
    str	x23,	[sp, fp]

    add	x23,	sp,	#164
    movz	fp,	#2100
    str	x11,	[sp, fp]

    add	x11,	sp,	#148
    movz	fp,	#2116
    str	x17,	[sp, fp]

    add	x17,	sp,	#156
    movz	fp,	#1948
    str	x27,	[sp, fp]

    add	x27,	sp,	#208
    movz	fp,	#2052
    str	x25,	[sp, fp]

    add	x25,	sp,	#128
    movz	fp,	#1964
    str	x1,	[sp, fp]

    add	x1,	sp,	#212
    movz	fp,	#1972
    str	x4,	[sp, fp]

    add	x4,	sp,	#216
    movz	fp,	#724
    str	x22,	[sp, fp]

    add	x22,	sp,	#240
    movz	fp,	#732
    str	x25,	[sp, fp]

    add	x25,	sp,	#244
    movz	fp,	#740
    str	x28,	[sp, fp]

    add	x28,	sp,	#248
    movz	fp,	#748
    str	x2,	[sp, fp]

    add	x2,	sp,	#252
    movz	fp,	#756
    str	x5,	[sp, fp]

    add	x5,	sp,	#256
    movz	fp,	#764
    str	x8,	[sp, fp]

    add	x8,	sp,	#260
    movz	fp,	#780
    str	x11,	[sp, fp]

    add	x11,	sp,	#264
    movz	fp,	#788
    str	x14,	[sp, fp]

    add	x14,	sp,	#268
    movz	fp,	#796
    str	x17,	[sp, fp]

    add	x17,	sp,	#272
    movz	fp,	#804
    str	x20,	[sp, fp]

    add	x20,	sp,	#276
    movz	fp,	#812
    str	x23,	[sp, fp]

    add	x23,	sp,	#280
    movz	fp,	#820
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#828
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#836
    str	x3,	[sp, fp]

    add	x3,	sp,	#292
    movz	fp,	#844
    str	x6,	[sp, fp]

    add	x6,	sp,	#296
    movz	fp,	#852
    str	x9,	[sp, fp]

    add	x9,	sp,	#300
    movz	fp,	#868
    str	x12,	[sp, fp]

    add	x12,	sp,	#304
    movz	fp,	#1020
    str	x15,	[sp, #880]

    add	x15,	sp,	#308
    str	x18,	[sp, #896]

    add	x18,	sp,	#312
    str	x21,	[sp, #904]

    add	x21,	sp,	#316
    str	x24,	[sp, #912]

    add	x24,	sp,	#320
    str	x27,	[sp, #920]

    add	x27,	sp,	#324
    str	x1,	[sp, #936]

    add	x1,	sp,	#328
    str	x4,	[sp, #944]

    add	x4,	sp,	#332
    str	x7,	[sp, #952]

    add	x7,	sp,	#336
    str	x10,	[sp, #960]

    add	x10,	sp,	#340
    str	x13,	[sp, #984]

    add	x13,	sp,	#344
    str	x16,	[sp, #416]

    add	x16,	sp,	#348
    str	x19,	[sp, #432]

    add	x19,	sp,	#352
    str	x22,	[sp, #440]

    add	x22,	sp,	#356
    str	x25,	[sp, #448]

    add	x25,	sp,	#360
    str	x28,	[sp, #456]

    add	x28,	sp,	#364
    str	x2,	[sp, #464]

    add	x2,	sp,	#368
    str	x5,	[sp, #480]

    add	x5,	sp,	#372
    str	x8,	[sp, #968]

    add	x8,	sp,	#376
    str	x11,	[sp, #992]

    add	x11,	sp,	#380
    str	x14,	[sp, #1000]

    add	x14,	sp,	#384
    str	x17,	[sp, #1008]

    add	x17,	sp,	#388
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
    str	x9,	[sp, #1072]

    str	x12,	[sp, #1080]

    str	x15,	[sp, #1088]

    str	x18,	[sp, #1096]

    str	x21,	[sp, #1104]

    str	x24,	[sp, #1112]

    str	x27,	[sp, #1120]

    str	x1,	[sp, #1136]

    str	x4,	[sp, #1144]

    str	x7,	[sp, #1152]

    movz	w7,	#0
    str	x10,	[sp, #1168]

    str	x13,	[sp, #1176]

    str	x16,	[sp, #1184]

    str	x19,	[sp, #1192]

    str	x22,	[sp, #1200]

    str	x25,	[sp, #1208]

    str	x28,	[sp, #1224]

    str	x2,	[sp, #1232]

    str	x5,	[sp, #1248]

    str	x8,	[sp, #1256]

    str	x11,	[sp, #1272]

    mov	w11,	w7
    str	x14,	[sp, #1280]

    movz	w14,	#0
    str	x17,	[sp, #1288]

    mov	w7,	w14
    str	x20,	[sp, #1304]

    str	x23,	[sp, #1312]

    str	x26,	[sp, #1320]

    str	x0,	[sp, #1336]

    str	x3,	[sp, #1344]

    str	x6,	[sp, #1360]

    str	w11,	[sp, #1904]

    str	w7,	[sp, #1816]


main_250:
    movz	w0,	#1
    movz	fp,	#2020
    movz	w14,	#3
    mov	w7,	w0
    ldr	x17,	[sp, fp]

    movz	fp,	#2156
    str	w7,	[x17]

    movz	w7,	#2
    ldr	x4,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#1940
    str	w0,	[x4]

    movz	w0,	#4
    ldr	x25,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#1932
    str	w14,	[x25]

    movz	w14,	#6
    ldr	x22,	[sp, fp]

    movz	fp,	#2028
    str	w7,	[x22]

    movz	w7,	#5
    ldr	x20,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#2108
    movz	w7,	#8
    str	w0,	[x20]

    movz	w0,	#7
    ldr	x15,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#2084
    str	w14,	[x15]

    mov	w0,	w7
    ldr	x6,	[sp, fp]

    movz	fp,	#2004
    str	w8,	[x6]

    ldr	x14,	[sp, fp]

    movz	fp,	#2068
    str	w0,	[x14]

    movz	w0,	#10
    movz	w14,	#9
    ldr	x3,	[sp, fp]

    mov	w7,	w0
    mov	w15,	w14
    movz	fp,	#2140
    movz	w14,	#12
    str	w15,	[x3]

    mov	w15,	w14
    ldr	x27,	[sp, fp]

    movz	w14,	#15
    movz	fp,	#1908
    str	w7,	[x27]

    ldr	x16,	[sp, fp]

    movz	w7,	#11
    movz	fp,	#1988
    mov	w0,	w7
    movz	w7,	#14
    str	w0,	[x16]

    movz	w0,	#13
    ldr	x11,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#2060
    str	w15,	[x11]

    ldr	x0,	[sp, fp]

    movz	fp,	#2148
    str	w8,	[x0]

    mov	w0,	w7
    ldr	x1,	[sp, fp]

    movz	fp,	#2124
    str	w0,	[x1]

    movz	w0,	#16
    ldr	x21,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#2092
    str	w14,	[x21]

    movz	w14,	#18
    ldr	x9,	[sp, fp]

    movz	fp,	#1980
    str	w7,	[x9]

    movz	w7,	#17
    ldr	x8,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#1924
    str	w0,	[x8]

    movz	w0,	#19
    ldr	x19,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#2044
    str	w14,	[x19]

    movz	w14,	#21
    ldr	x23,	[sp, fp]

    mov	w15,	w14
    movz	fp,	#2132
    str	w7,	[x23]

    movz	w14,	#24
    movz	w7,	#20
    ldr	x24,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#2100
    str	w0,	[x24]

    movz	w0,	#22
    ldr	x12,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#2116
    str	w15,	[x12]

    ldr	x18,	[sp, fp]

    movz	fp,	#1948
    str	w7,	[x18]

    movz	w7,	#23
    ldr	x28,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#2052
    str	w0,	[x28]

    movz	w0,	#25
    ldr	x26,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#1964
    str	w14,	[x26]

    movz	w14,	#27
    ldr	x2,	[sp, fp]

    movz	fp,	#1972
    str	w7,	[x2]

    movz	w7,	#26
    ldr	x5,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#724
    str	w0,	[x5]

    movz	w0,	#28
    ldr	x22,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#732
    str	w14,	[x22]

    movz	w14,	#30
    ldr	x25,	[sp, fp]

    movz	fp,	#740
    str	w7,	[x25]

    movz	w7,	#29
    ldr	x28,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#748
    movz	w7,	#32
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#756
    str	w14,	[x2]

    mov	w0,	w7
    movz	w14,	#33
    ldr	x6,	[sp, fp]

    mov	w15,	w14
    movz	fp,	#764
    str	w8,	[x6]

    movz	w14,	#36
    ldr	x9,	[sp, fp]

    movz	fp,	#780
    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#788
    str	w15,	[x11]

    ldr	x15,	[sp, fp]

    movz	fp,	#796
    str	w7,	[x15]

    movz	w7,	#35
    ldr	x18,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#804
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#812
    str	w14,	[x21]

    movz	w14,	#39
    ldr	x24,	[sp, fp]

    mov	w15,	w14
    movz	fp,	#820
    str	w7,	[x24]

    movz	w14,	#42
    movz	w7,	#38
    ldr	x27,	[sp, fp]

    mov	w0,	w7
    movz	fp,	#828
    movz	w7,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#836
    str	w15,	[x1]

    mov	w0,	w7
    mov	w15,	w14
    ldr	x4,	[sp, fp]

    movz	fp,	#844
    str	w8,	[x4]

    ldr	x8,	[sp, fp]

    movz	fp,	#852
    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#868
    str	w15,	[x10]

    ldr	x14,	[sp, fp]

    movz	fp,	#1020
    str	w7,	[x14]

    movz	w14,	#45
    ldr	x17,	[sp, #880]

    movz	w7,	#44
    mov	w0,	w7
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, #896]

    mov	w7,	w0
    str	w14,	[x20]

    movz	w14,	#48
    ldr	x23,	[sp, #904]

    mov	w15,	w14
    str	w7,	[x23]

    movz	w14,	#51
    ldr	x26,	[sp, #912]

    movz	w7,	#47
    mov	w0,	w7
    movz	w7,	#50
    str	w0,	[x26]

    ldr	x0,	[sp, #920]

    str	w15,	[x0]

    ldr	x3,	[sp, #936]

    mov	w15,	w14
    movz	w0,	#49
    movz	w14,	#54
    mov	w8,	w0
    mov	w0,	w7
    str	w8,	[x3]

    ldr	x7,	[sp, #944]

    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, #952]

    mov	w7,	w0
    str	w15,	[x9]

    ldr	x13,	[sp, #960]

    str	w7,	[x13]

    ldr	x16,	[sp, #984]

    movz	w7,	#53
    mov	w0,	w7
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, #416]

    mov	w7,	w0
    str	w14,	[x19]

    movz	w14,	#57
    ldr	x22,	[sp, #432]

    str	w7,	[x22]

    ldr	x25,	[sp, #440]

    movz	w7,	#56
    mov	w0,	w7
    str	w0,	[x25]

    movz	w0,	#58
    ldr	x28,	[sp, #448]

    mov	w7,	w0
    str	w14,	[x28]

    movz	w14,	#60
    ldr	x2,	[sp, #456]

    mov	w15,	w14
    str	w7,	[x2]

    movz	w14,	#63
    ldr	x6,	[sp, #464]

    movz	w7,	#59
    mov	w0,	w7
    str	w0,	[x6]

    movz	w0,	#61
    ldr	x8,	[sp, #480]

    mov	w7,	w0
    str	w15,	[x8]

    movz	w0,	#64
    ldr	x9,	[sp, #968]

    str	w7,	[x9]

    ldr	x12,	[sp, #992]

    movz	w7,	#62
    str	w7,	[x12]

    mov	w7,	w0
    ldr	x15,	[sp, #1000]

    str	w14,	[x15]

    movz	w14,	#66
    ldr	x18,	[sp, #1008]

    str	w7,	[x18]

    ldr	x21,	[sp, fp]

    movz	w7,	#65
    movz	fp,	#1028
    mov	w0,	w7
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#1036
    str	w14,	[x24]

    movz	w14,	#69
    ldr	x27,	[sp, fp]

    mov	w15,	w14
    movz	fp,	#1044
    str	w7,	[x27]

    movz	w14,	#72
    ldr	x1,	[sp, fp]

    movz	w7,	#68
    movz	fp,	#1052
    mov	w0,	w7
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1060
    str	w15,	[x4]

    mov	w15,	w14
    ldr	x7,	[sp, fp]

    movz	w14,	#75
    str	w8,	[x7]

    ldr	x10,	[sp, #1072]

    movz	w7,	#71
    mov	w0,	w7
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, #1080]

    mov	w7,	w0
    str	w15,	[x13]

    ldr	x16,	[sp, #1088]

    str	w7,	[x16]

    ldr	x19,	[sp, #1096]

    movz	w7,	#74
    mov	w0,	w7
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, #1104]

    mov	w7,	w0
    str	w14,	[x22]

    movz	w14,	#78
    ldr	x25,	[sp, #1112]

    str	w7,	[x25]

    ldr	x28,	[sp, #1120]

    movz	w7,	#77
    mov	w0,	w7
    movz	w7,	#80
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, #1136]

    str	w14,	[x2]

    movz	w14,	#81
    ldr	x5,	[sp, #1144]

    mov	w15,	w14
    str	w0,	[x5]

    ldr	x8,	[sp, #1152]

    mov	w0,	w7
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, #1168]

    mov	w7,	w0
    str	w15,	[x11]

    ldr	x14,	[sp, #1176]

    str	w7,	[x14]

    movz	w14,	#84
    ldr	x17,	[sp, #1184]

    movz	w7,	#83
    mov	w0,	w7
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, #1192]

    mov	w7,	w0
    str	w14,	[x20]

    movz	w14,	#87
    ldr	x23,	[sp, #1200]

    mov	w8,	w14
    str	w7,	[x23]

    movz	w14,	#90
    ldr	x26,	[sp, #1208]

    movz	w7,	#86
    mov	w15,	w14
    mov	w0,	w7
    movz	w14,	#93
    movz	w7,	#89
    str	w0,	[x26]

    ldr	x0,	[sp, #1224]

    str	w8,	[x0]

    ldr	x3,	[sp, #1232]

    movz	w0,	#88
    mov	w8,	w0
    mov	w0,	w7
    str	w8,	[x3]

    movz	w7,	#92
    ldr	x6,	[sp, #1248]

    str	w0,	[x6]

    movz	w0,	#91
    ldr	x9,	[sp, #1256]

    str	w15,	[x9]

    ldr	x12,	[sp, #1272]

    str	w0,	[x12]

    ldr	x15,	[sp, #1280]

    mov	w0,	w7
    str	w0,	[x15]

    movz	w0,	#94
    ldr	x18,	[sp, #1288]

    mov	w7,	w0
    str	w14,	[x18]

    movz	w14,	#96
    ldr	x21,	[sp, #1304]

    str	w7,	[x21]

    ldr	x24,	[sp, #1312]

    movz	w7,	#95
    mov	w0,	w7
    movz	w7,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, #1320]

    mov	w8,	w0
    str	w14,	[x27]

    mov	w0,	w7
    movz	w14,	#99
    ldr	x1,	[sp, #1336]

    mov	w15,	w14
    str	w8,	[x1]

    ldr	x4,	[sp, #1344]

    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, #1360]

    str	w15,	[x7]

    ldr	w8,	[sp, #1816]

    add	w18,	w8,	#1
    str	w18,	[sp, #512]

    ldr	w12,	[sp, #1904]

    mov	w8,	w12
    str	w8,	[sp, #1068]

    str	w0,	[sp, #1812]


main_254:
    ldr	w1,	[sp, #1812]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #1812]

    lsl	w0,	w2,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w8,	[x15]

    ldr	w9,	[sp, #1068]

    ldr	w3,	[sp, #1812]

    add	w4,	w8,	w9
    add	w0,	w3,	#1
    str	w0,	[sp, #524]

    ldr	w1,	[sp, #524]

    lsl	w15,	w1,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w9,	[x8]

    ldr	w2,	[sp, #524]

    add	w17,	w4,	w9
    add	w26,	w2,	#1
    str	w26,	[sp, #1500]

    ldr	w27,	[sp, #1500]

    lsl	w8,	w27,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w28,	[sp, #1500]

    add	w10,	w17,	w8
    add	w1,	w28,	#1
    str	w1,	[sp, #1692]

    ldr	w2,	[sp, #1692]

    lsl	w0,	w2,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w3,	[sp, #1692]

    add	w0,	w10,	w0
    add	w4,	w3,	#1
    str	w4,	[sp, #528]

    ldr	w5,	[sp, #528]

    lsl	w15,	w5,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w16,	[x8]

    ldr	w6,	[sp, #528]

    add	w19,	w0,	w16
    add	w5,	w6,	#1
    str	w5,	[sp, #1704]

    ldr	w6,	[sp, #1704]

    lsl	w7,	w6,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w7,	[sp, #1704]

    add	w12,	w19,	w0
    add	w9,	w7,	#1
    str	w9,	[sp, #1708]

    ldr	w10,	[sp, #1708]

    lsl	w0,	w10,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w16,	[x15]

    ldr	w11,	[sp, #1708]

    add	w0,	w12,	w16
    add	w9,	w11,	#1
    str	w9,	[sp, #1852]

    ldr	w10,	[sp, #1852]

    lsl	w15,	w10,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w9,	[x8]

    ldr	w11,	[sp, #1852]

    add	w21,	w0,	w9
    add	w13,	w11,	#1
    str	w13,	[sp, #1856]

    ldr	w14,	[sp, #1856]

    lsl	w7,	w14,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w7,	[x0]

    ldr	w15,	[sp, #1856]

    add	w9,	w7,	w21
    add	w17,	w15,	#1
    str	w17,	[sp, #1876]

    ldr	w18,	[sp, #1876]

    lsl	w0,	w18,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w19,	[sp, #1876]

    add	w0,	w9,	w0
    add	w21,	w19,	#1
    str	w21,	[sp, #1880]

    ldr	w22,	[sp, #1880]

    lsl	w16,	w22,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w16,	[x9]

    ldr	w23,	[sp, #1880]

    add	w17,	w0,	w16
    add	w13,	w23,	#1
    str	w13,	[sp, #1720]

    ldr	w14,	[sp, #1720]

    lsl	w7,	w14,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #1720]

    add	w8,	w17,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #1732]

    ldr	w18,	[sp, #1732]

    lsl	w0,	w18,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w19,	[sp, #1732]

    add	w0,	w8,	w16
    add	w21,	w19,	#1
    str	w21,	[sp, #1744]

    ldr	w22,	[sp, #1744]

    lsl	w15,	w22,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w8,	[x8]

    ldr	w23,	[sp, #1744]

    add	w15,	w0,	w8
    add	w25,	w23,	#1
    str	w25,	[sp, #1756]

    ldr	w26,	[sp, #1756]

    lsl	w8,	w26,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w27,	[sp, #1756]

    add	w10,	w15,	w8
    add	w0,	w27,	#1
    str	w0,	[sp, #1760]

    ldr	w1,	[sp, #1760]

    lsl	w0,	w1,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w2,	[sp, #1760]

    add	w0,	w10,	w0
    add	w25,	w2,	#1
    str	w25,	[sp, #1888]

    ldr	w26,	[sp, #1888]

    lsl	w16,	w26,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w16,	[x9]

    ldr	w27,	[sp, #1888]

    add	w17,	w16,	w0
    add	w0,	w27,	#1
    str	w0,	[sp, #1892]

    ldr	w1,	[sp, #1892]

    lsl	w7,	w1,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w2,	[sp, #1892]

    add	w9,	w17,	w0
    add	w4,	w2,	#1
    str	w4,	[sp, #548]

    ldr	w5,	[sp, #548]

    lsl	w0,	w5,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w6,	[sp, #548]

    add	w0,	w9,	w16
    add	w8,	w6,	#1
    str	w8,	[sp, #560]

    ldr	w9,	[sp, #560]

    lsl	w16,	w9,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    ldr	w10,	[sp, #560]

    add	w19,	w0,	w9
    add	w12,	w10,	#1
    str	w12,	[sp, #580]

    ldr	w13,	[sp, #580]

    lsl	w7,	w13,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w7,	[x0]

    ldr	w14,	[sp, #580]

    add	w7,	w19,	w7
    add	w16,	w14,	#1
    str	w16,	[sp, #584]

    ldr	w17,	[sp, #584]

    lsl	w0,	w17,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w18,	[sp, #584]

    add	w0,	w7,	w0
    add	w20,	w18,	#1
    str	w20,	[sp, #588]

    ldr	w21,	[sp, #588]

    lsl	w16,	w21,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w16,	[x9]

    ldr	w22,	[sp, #588]

    add	w15,	w0,	w16
    add	w24,	w22,	#1
    str	w24,	[sp, #592]

    ldr	w25,	[sp, #592]

    lsl	w7,	w25,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w26,	[sp, #592]

    add	w9,	w15,	w0
    add	w4,	w26,	#1
    str	w4,	[sp, #1764]

    ldr	w5,	[sp, #1764]

    lsl	w0,	w5,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w6,	[sp, #1764]

    add	w1,	w16,	w9
    add	w28,	w6,	#1
    str	w28,	[sp, #604]

    ldr	w0,	[sp, #604]

    lsl	w16,	w0,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    add	w17,	w1,	w9
    ldr	w1,	[sp, #604]

    add	w3,	w1,	#1
    str	w3,	[sp, #608]

    ldr	w4,	[sp, #608]

    lsl	w7,	w4,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w7,	[x0]

    ldr	w5,	[sp, #608]

    add	w9,	w17,	w7
    add	w7,	w5,	#1
    str	w7,	[sp, #620]

    ldr	w8,	[sp, #620]

    lsl	w0,	w8,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    add	w0,	w9,	w0
    ldr	w9,	[sp, #620]

    add	w8,	w9,	#1
    str	w8,	[sp, #1768]

    ldr	w9,	[sp, #1768]

    lsl	w16,	w9,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w16,	[x9]

    ldr	w10,	[sp, #1768]

    add	w19,	w0,	w16
    add	w12,	w10,	#1
    str	w12,	[sp, #1780]

    ldr	w13,	[sp, #1780]

    lsl	w7,	w13,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w14,	[sp, #1780]

    add	w7,	w19,	w0
    add	w11,	w14,	#1
    str	w11,	[sp, #632]

    ldr	w12,	[sp, #632]

    lsl	w0,	w12,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w13,	[sp, #632]

    add	w0,	w7,	w16
    add	w15,	w13,	#1
    str	w15,	[sp, #1396]

    ldr	w16,	[sp, #1396]

    lsl	w16,	w16,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    ldr	w17,	[sp, #1396]

    add	w15,	w0,	w9
    add	w19,	w17,	#1
    str	w19,	[sp, #1400]

    ldr	w20,	[sp, #1400]

    lsl	w7,	w20,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w7,	[x0]

    ldr	w21,	[sp, #1400]

    add	w7,	w7,	w15
    add	w16,	w21,	#1
    str	w16,	[sp, #1792]

    ldr	w17,	[sp, #1792]

    lsl	w0,	w17,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w18,	[sp, #1792]

    add	w0,	w7,	w0
    add	w23,	w18,	#1
    str	w23,	[sp, #1404]

    ldr	w24,	[sp, #1404]

    lsl	w16,	w24,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w16,	[x9]

    ldr	w25,	[sp, #1404]

    add	w15,	w0,	w16
    add	w27,	w25,	#1
    str	w27,	[sp, #1416]

    ldr	w28,	[sp, #1416]

    lsl	w7,	w28,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    add	w10,	w15,	w0
    ldr	w0,	[sp, #1416]

    add	w2,	w0,	#1
    str	w2,	[sp, #1428]

    ldr	w3,	[sp, #1428]

    lsl	w0,	w3,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w4,	[sp, #1428]

    add	w0,	w10,	w16
    add	w6,	w4,	#1
    str	w6,	[sp, #1440]

    ldr	w7,	[sp, #1440]

    lsl	w16,	w7,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    ldr	w8,	[sp, #1440]

    add	w19,	w0,	w9
    add	w10,	w8,	#1
    str	w10,	[sp, #1452]

    ldr	w11,	[sp, #1452]

    lsl	w7,	w11,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w7,	[x0]

    ldr	w12,	[sp, #1452]

    add	w7,	w19,	w7
    add	w25,	w12,	#1
    str	w25,	[sp, #1808]

    ldr	w26,	[sp, #1808]

    lsl	w0,	w26,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w27,	[sp, #1808]

    add	w16,	w7,	w0
    mov	w10,	w16
    add	w0,	w27,	#1
    str	w10,	[sp, #1068]

    mov	w4,	w0
    str	w4,	[sp, #1812]

    b	main_254

main_419:
    ldr	w5,	[sp, #1812]

    mov	w20,	w5
    str	w20,	[sp, #1796]

    ldr	w11,	[sp, #1068]

    mov	w4,	w11
    str	w4,	[sp, #876]


main_421:
    ldr	w21,	[sp, #1796]

    lsl	w15,	w21,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w0,	[x8]

    ldr	w5,	[sp, #876]

    ldr	w22,	[sp, #1796]

    add	w20,	w0,	w5
    add	w13,	w22,	#1
    str	w13,	[sp, #1504]

    ldr	w14,	[sp, #1504]

    lsl	w7,	w14,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #1504]

    add	w9,	w20,	w0
    add	w14,	w15,	#1
    str	w14,	[sp, #1464]

    ldr	w15,	[sp, #1464]

    lsl	w0,	w15,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w16,	[x15]

    add	w0,	w9,	w16
    ldr	w16,	[sp, #1464]

    add	w17,	w16,	#1
    str	w17,	[sp, #1372]

    ldr	w18,	[sp, #1372]

    lsl	w15,	w18,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w9,	[x8]

    ldr	w19,	[sp, #1372]

    add	w17,	w0,	w9
    add	w21,	w19,	#1
    str	w21,	[sp, #516]

    ldr	w22,	[sp, #516]

    lsl	w7,	w22,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w7,	[x0]

    ldr	w23,	[sp, #516]

    add	w8,	w17,	w7
    add	w18,	w23,	#1
    str	w18,	[sp, #1476]

    ldr	w19,	[sp, #1476]

    lsl	w0,	w19,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w20,	[sp, #1476]

    add	w0,	w8,	w0
    add	w25,	w20,	#1
    str	w25,	[sp, #520]

    ldr	w26,	[sp, #520]

    lsl	w15,	w26,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w16,	[x8]

    ldr	w27,	[sp, #520]

    add	w18,	w0,	w16
    add	w22,	w27,	#1
    str	w22,	[sp, #1488]

    ldr	w23,	[sp, #1488]

    lsl	w7,	w23,	#2
    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w24,	[sp, #1488]

    add	w17,	w18,	w0
    add	w0,	w24,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w23,	w0
    mov	w6,	w17
    str	w23,	[sp, #1796]

    str	w6,	[sp, #876]

    b	main_421

main_457:
    mov	w14,	w17

main_459:
    lsl	w8,	w0,	#2
    add	w0,	w0,	#1
    mov	x8,	x8
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w8,	[x8]

    add	w15,	w8,	w14
    cmp	w0,	#100
    blt	main_458

main_467:
    movz	w0,	#65535
    ldr	w20,	[sp, #512]

    ldr	w18,	[sp, #1368]

    sdiv	w0,	w15,	w0
    lsl	w7,	w0,	#16
    sub	w7,	w7,	w0,	lsl #0
    sub	w0,	w15,	w7
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #1904]

    ldr	w20,	[sp, #512]

    mov	w9,	w20
    str	w9,	[sp, #1816]

    b	main_250

main_458:
    mov	w14,	w15
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
    
    add	sp, sp, #2832
    ret


main_141:
    mov	w10,	w13
    b	main_142

