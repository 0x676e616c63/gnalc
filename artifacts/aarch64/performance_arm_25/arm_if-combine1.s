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
    str	w0,	[sp, #1376]

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
    ldr	w18,	[sp, #1376]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x22,	sp,	#20
    movz	fp,	#2012
    add	x17,	sp,	#24
    add	x8,	sp,	#28
    add	x19,	sp,	#32
    add	x18,	sp,	#36
    add	x7,	sp,	#40
    add	x4,	sp,	#44
    add	x25,	sp,	#48
    add	x20,	sp,	#52
    add	x5,	sp,	#56
    add	x13,	sp,	#60
    add	x1,	sp,	#64
    add	x16,	sp,	#68
    add	x26,	sp,	#72
    add	x11,	sp,	#76
    add	x15,	sp,	#80
    add	x0,	sp,	#84
    add	x10,	sp,	#88
    add	x23,	sp,	#92
    add	x28,	sp,	#96
    add	x14,	sp,	#100
    add	x27,	sp,	#104
    add	x2,	sp,	#108
    add	x3,	sp,	#112
    add	x21,	sp,	#116
    add	x24,	sp,	#120
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x22,	[sp, fp]

    add	x22,	sp,	#124
    movz	fp,	#2100
    str	x17,	[sp, fp]

    add	x17,	sp,	#156
    movz	fp,	#2076
    str	x8,	[sp, fp]

    add	x8,	sp,	#144
    movz	fp,	#2004
    str	x19,	[sp, fp]

    add	x19,	sp,	#236
    movz	fp,	#1892
    str	x18,	[sp, fp]

    add	x18,	sp,	#196
    movz	fp,	#1972
    str	x7,	[sp, fp]

    add	x7,	sp,	#220
    movz	fp,	#1956
    str	x4,	[sp, fp]

    add	x4,	sp,	#216
    movz	fp,	#2028
    str	x25,	[sp, fp]

    add	x25,	sp,	#128
    movz	fp,	#2108
    str	x20,	[sp, fp]

    add	x20,	sp,	#160
    movz	fp,	#2060
    str	x5,	[sp, fp]

    add	x5,	sp,	#140
    movz	fp,	#1988
    str	x13,	[sp, fp]

    add	x13,	sp,	#228
    movz	fp,	#1940
    str	x1,	[sp, fp]

    add	x1,	sp,	#212
    movz	fp,	#1996
    str	x16,	[sp, fp]

    add	x16,	sp,	#232
    movz	fp,	#2140
    str	x26,	[sp, fp]

    add	x26,	sp,	#168
    movz	fp,	#2084
    str	x11,	[sp, fp]

    add	x11,	sp,	#148
    movz	fp,	#1884
    str	x15,	[sp, fp]

    add	x15,	sp,	#192
    movz	fp,	#2156
    str	x0,	[sp, fp]

    add	x0,	sp,	#172
    movz	fp,	#1980
    str	x10,	[sp, fp]

    add	x10,	sp,	#224
    movz	fp,	#2124
    str	x23,	[sp, fp]

    add	x23,	sp,	#164
    movz	fp,	#2044
    str	x28,	[sp, fp]

    add	x28,	sp,	#132
    movz	fp,	#2092
    str	x14,	[sp, fp]

    add	x14,	sp,	#152
    movz	fp,	#1924
    str	x27,	[sp, fp]

    add	x27,	sp,	#208
    movz	fp,	#2052
    str	x2,	[sp, fp]

    add	x2,	sp,	#136
    movz	fp,	#2164
    str	x3,	[sp, fp]

    add	x3,	sp,	#176
    movz	fp,	#1900
    str	x21,	[sp, fp]

    add	x21,	sp,	#200
    movz	fp,	#1908
    str	x24,	[sp, fp]

    add	x24,	sp,	#204
    movz	fp,	#524
    str	x22,	[sp, fp]

    add	x22,	sp,	#240
    str	x25,	[sp, #584]

    add	x25,	sp,	#244
    str	x28,	[sp, #592]

    add	x28,	sp,	#248
    str	x2,	[sp, #600]

    add	x2,	sp,	#252
    str	x5,	[sp, #608]

    add	x5,	sp,	#256
    str	x8,	[sp, #616]

    add	x8,	sp,	#260
    str	x11,	[sp, #624]

    add	x11,	sp,	#264
    str	x14,	[sp, #840]

    add	x14,	sp,	#268
    str	x17,	[sp, #848]

    add	x17,	sp,	#272
    str	x20,	[sp, #856]

    add	x20,	sp,	#276
    str	x23,	[sp, #864]

    add	x23,	sp,	#280
    str	x26,	[sp, #872]

    add	x26,	sp,	#284
    str	x0,	[sp, #880]

    add	x0,	sp,	#288
    str	x3,	[sp, #888]

    add	x3,	sp,	#292
    str	x6,	[sp, #896]

    add	x6,	sp,	#296
    str	x9,	[sp, #904]

    add	x9,	sp,	#300
    str	x12,	[sp, #912]

    add	x12,	sp,	#304
    str	x15,	[sp, #920]

    add	x15,	sp,	#308
    str	x18,	[sp, #928]

    add	x18,	sp,	#312
    str	x21,	[sp, #936]

    add	x21,	sp,	#316
    str	x24,	[sp, #944]

    add	x24,	sp,	#320
    str	x27,	[sp, #952]

    add	x27,	sp,	#324
    str	x1,	[sp, #968]

    add	x1,	sp,	#328
    str	x4,	[sp, #984]

    add	x4,	sp,	#332
    str	x7,	[sp, #992]

    add	x7,	sp,	#336
    str	x10,	[sp, #1000]

    add	x10,	sp,	#340
    str	x13,	[sp, #1024]

    add	x13,	sp,	#344
    str	x16,	[sp, #960]

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
    str	x11,	[sp, #1032]

    add	x11,	sp,	#380
    str	x14,	[sp, #1040]

    add	x14,	sp,	#384
    str	x17,	[sp, #1048]

    add	x17,	sp,	#388
    str	x20,	[sp, #1056]

    add	x20,	sp,	#392
    str	x23,	[sp, #1064]

    add	x23,	sp,	#396
    str	x26,	[sp, #1072]

    add	x26,	sp,	#400
    str	x0,	[sp, #1080]

    add	x0,	sp,	#404
    str	x3,	[sp, #1088]

    add	x3,	sp,	#408
    str	x6,	[sp, #1096]

    add	x6,	sp,	#412
    str	x9,	[sp, #1104]

    str	x12,	[sp, #1112]

    movz	w12,	#0
    str	x15,	[sp, #1120]

    str	x18,	[sp, #1128]

    str	x21,	[sp, #1136]

    str	x24,	[sp, #1144]

    str	x27,	[sp, #1152]

    str	x1,	[sp, #1160]

    str	x4,	[sp, #1168]

    str	x7,	[sp, #1176]

    mov	w7,	w12
    str	x10,	[sp, #1184]

    str	x13,	[sp, #1200]

    str	x16,	[sp, #1208]

    str	x19,	[sp, #1224]

    str	x22,	[sp, #1240]

    str	x25,	[sp, #1248]

    str	x28,	[sp, #1256]

    str	x2,	[sp, #1264]

    str	x5,	[sp, #1272]

    movz	w5,	#0
    str	x8,	[sp, #1280]

    str	x11,	[sp, #1288]

    mov	w11,	w5
    str	x14,	[sp, #1296]

    str	x17,	[sp, #1304]

    str	x20,	[sp, #1312]

    str	x23,	[sp, #1320]

    str	x26,	[sp, #1336]

    str	x0,	[sp, #1344]

    str	x3,	[sp, #1360]

    str	x6,	[sp, #1368]

    str	w11,	[sp, #1880]

    str	w7,	[sp, #1876]


main_250:
    movz	w0,	#1
    movz	fp,	#2012
    movz	w12,	#3
    mov	w5,	w0
    ldr	x23,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#2100
    str	w5,	[x23]

    movz	w12,	#6
    movz	w5,	#2
    ldr	x18,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2076
    str	w0,	[x18]

    movz	w0,	#4
    ldr	x9,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2004
    str	w13,	[x9]

    mov	w13,	w12
    ldr	x20,	[sp, fp]

    movz	w12,	#9
    movz	fp,	#1892
    str	w5,	[x20]

    movz	w5,	#5
    ldr	x19,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1972
    str	w0,	[x19]

    movz	w0,	#7
    ldr	x8,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1956
    str	w13,	[x8]

    ldr	x5,	[sp, fp]

    movz	fp,	#2028
    str	w6,	[x5]

    movz	w5,	#8
    ldr	x26,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2108
    str	w0,	[x26]

    movz	w0,	#10
    ldr	x21,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2060
    str	w12,	[x21]

    movz	w12,	#12
    ldr	x6,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#1988
    str	w5,	[x6]

    movz	w12,	#15
    movz	w5,	#11
    ldr	x14,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1940
    str	w0,	[x14]

    movz	w0,	#13
    ldr	x2,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1996
    str	w13,	[x2]

    mov	w13,	w12
    ldr	x17,	[sp, fp]

    movz	fp,	#2140
    str	w5,	[x17]

    movz	w5,	#14
    ldr	x27,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2084
    str	w0,	[x27]

    movz	w0,	#16
    ldr	x12,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1884
    str	w13,	[x12]

    movz	w12,	#18
    ldr	x16,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#2156
    str	w5,	[x16]

    movz	w12,	#21
    movz	w5,	#17
    ldr	x1,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#1980
    str	w0,	[x1]

    movz	w0,	#19
    ldr	x11,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2124
    str	w13,	[x11]

    ldr	x24,	[sp, fp]

    movz	fp,	#2044
    str	w5,	[x24]

    movz	w5,	#20
    ldr	x0,	[sp, fp]

    mov	w1,	w5
    movz	fp,	#2092
    str	w1,	[x0]

    movz	w0,	#22
    ldr	x15,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1924
    str	w12,	[x15]

    movz	w12,	#24
    ldr	x28,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#2052
    str	w5,	[x28]

    movz	w12,	#27
    movz	w5,	#23
    ldr	x3,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2164
    str	w0,	[x3]

    movz	w0,	#25
    ldr	x4,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#1900
    str	w13,	[x4]

    ldr	x22,	[sp, fp]

    movz	fp,	#1908
    str	w5,	[x22]

    movz	w5,	#26
    ldr	x25,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#524
    str	w0,	[x25]

    movz	w0,	#28
    ldr	x22,	[sp, fp]

    mov	w5,	w0
    str	w12,	[x22]

    movz	w12,	#30
    ldr	x25,	[sp, #584]

    mov	w13,	w12
    str	w5,	[x25]

    movz	w12,	#33
    ldr	x28,	[sp, #592]

    movz	w5,	#29
    mov	w0,	w5
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, #600]

    mov	w5,	w0
    str	w13,	[x2]

    mov	w13,	w12
    ldr	x6,	[sp, #608]

    movz	w12,	#36
    str	w5,	[x6]

    ldr	x9,	[sp, #616]

    movz	w5,	#32
    mov	w0,	w5
    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, #624]

    mov	w5,	w0
    str	w13,	[x11]

    ldr	x15,	[sp, #840]

    str	w5,	[x15]

    ldr	x18,	[sp, #848]

    movz	w5,	#35
    mov	w0,	w5
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, #856]

    mov	w5,	w0
    str	w12,	[x21]

    movz	w12,	#39
    ldr	x24,	[sp, #864]

    mov	w13,	w12
    str	w5,	[x24]

    movz	w12,	#42
    ldr	x27,	[sp, #872]

    movz	w5,	#38
    mov	w0,	w5
    movz	w5,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, #880]

    mov	w6,	w0
    str	w13,	[x1]

    mov	w0,	w5
    mov	w13,	w12
    ldr	x4,	[sp, #888]

    movz	w12,	#45
    str	w6,	[x4]

    ldr	x8,	[sp, #896]

    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, #904]

    mov	w5,	w0
    str	w13,	[x10]

    ldr	x14,	[sp, #912]

    str	w5,	[x14]

    ldr	x17,	[sp, #920]

    movz	w5,	#44
    mov	w0,	w5
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, #928]

    mov	w5,	w0
    str	w12,	[x20]

    movz	w12,	#48
    ldr	x23,	[sp, #936]

    mov	w13,	w12
    str	w5,	[x23]

    movz	w12,	#51
    ldr	x26,	[sp, #944]

    movz	w5,	#47
    mov	w0,	w5
    movz	w5,	#50
    str	w0,	[x26]

    ldr	x0,	[sp, #952]

    str	w13,	[x0]

    mov	w13,	w12
    ldr	x3,	[sp, #968]

    movz	w0,	#49
    movz	w12,	#54
    mov	w6,	w0
    mov	w0,	w5
    str	w6,	[x3]

    ldr	x7,	[sp, #984]

    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, #992]

    mov	w5,	w0
    str	w13,	[x9]

    ldr	x13,	[sp, #1000]

    str	w5,	[x13]

    ldr	x16,	[sp, #1024]

    movz	w5,	#53
    mov	w0,	w5
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, #960]

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

    ldr	x12,	[sp, #1032]

    movz	w5,	#62
    str	w5,	[x12]

    ldr	x15,	[sp, #1040]

    mov	w5,	w0
    movz	w12,	#63
    str	w12,	[x15]

    movz	w12,	#66
    ldr	x18,	[sp, #1048]

    str	w5,	[x18]

    ldr	x21,	[sp, #1056]

    movz	w5,	#65
    mov	w0,	w5
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, #1064]

    mov	w5,	w0
    str	w12,	[x24]

    movz	w12,	#69
    ldr	x27,	[sp, #1072]

    mov	w13,	w12
    str	w5,	[x27]

    movz	w12,	#72
    ldr	x1,	[sp, #1080]

    movz	w5,	#68
    mov	w0,	w5
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, #1088]

    mov	w5,	w0
    str	w13,	[x4]

    ldr	x7,	[sp, #1096]

    str	w5,	[x7]

    ldr	x10,	[sp, #1104]

    movz	w5,	#71
    mov	w0,	w5
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, #1112]

    mov	w5,	w0
    str	w12,	[x13]

    movz	w12,	#75
    ldr	x16,	[sp, #1120]

    str	w5,	[x16]

    ldr	x19,	[sp, #1128]

    movz	w5,	#74
    mov	w0,	w5
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, #1136]

    mov	w5,	w0
    str	w12,	[x22]

    movz	w12,	#78
    ldr	x25,	[sp, #1144]

    mov	w13,	w12
    str	w5,	[x25]

    movz	w12,	#81
    ldr	x28,	[sp, #1152]

    movz	w5,	#77
    mov	w0,	w5
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, #1160]

    str	w13,	[x2]

    mov	w13,	w12
    ldr	x5,	[sp, #1168]

    movz	w12,	#84
    str	w0,	[x5]

    ldr	x8,	[sp, #1176]

    movz	w5,	#80
    mov	w0,	w5
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, #1184]

    mov	w5,	w0
    str	w13,	[x11]

    ldr	x14,	[sp, #1200]

    str	w5,	[x14]

    ldr	x17,	[sp, #1208]

    movz	w5,	#83
    mov	w0,	w5
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, #1224]

    mov	w5,	w0
    str	w12,	[x20]

    movz	w12,	#87
    ldr	x23,	[sp, #1240]

    mov	w6,	w12
    str	w5,	[x23]

    movz	w12,	#90
    ldr	x26,	[sp, #1248]

    movz	w5,	#86
    mov	w13,	w12
    mov	w0,	w5
    movz	w5,	#89
    str	w0,	[x26]

    ldr	x0,	[sp, #1256]

    str	w6,	[x0]

    ldr	x3,	[sp, #1264]

    movz	w0,	#88
    mov	w6,	w0
    mov	w0,	w5
    str	w6,	[x3]

    movz	w5,	#92
    ldr	x6,	[sp, #1272]

    str	w0,	[x6]

    movz	w0,	#91
    ldr	x9,	[sp, #1280]

    str	w13,	[x9]

    ldr	x12,	[sp, #1288]

    str	w0,	[x12]

    movz	w12,	#93
    ldr	x15,	[sp, #1296]

    mov	w0,	w5
    str	w0,	[x15]

    movz	w0,	#94
    ldr	x18,	[sp, #1304]

    mov	w5,	w0
    str	w12,	[x18]

    movz	w12,	#96
    ldr	x21,	[sp, #1312]

    str	w5,	[x21]

    ldr	x24,	[sp, #1320]

    movz	w5,	#95
    mov	w0,	w5
    movz	w5,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, #1336]

    mov	w6,	w0
    str	w12,	[x27]

    mov	w0,	w5
    movz	w12,	#99
    ldr	x1,	[sp, #1344]

    mov	w13,	w12
    str	w6,	[x1]

    ldr	x4,	[sp, #1360]

    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, #1368]

    str	w13,	[x7]

    ldr	w8,	[sp, #1876]

    add	w18,	w8,	#1
    str	w18,	[sp, #496]

    ldr	w12,	[sp, #1880]

    mov	w8,	w12
    str	w8,	[sp, #1456]

    str	w0,	[sp, #1872]


main_254:
    ldr	w1,	[sp, #1872]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #1872]

    lsl	w0,	w2,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w6,	[x13]

    ldr	w9,	[sp, #1456]

    ldr	w3,	[sp, #1872]

    add	w0,	w6,	w9
    add	w10,	w3,	#1
    str	w10,	[sp, #1752]

    ldr	w11,	[sp, #1752]

    lsl	w12,	w11,	#2
    mov	x5,	x12
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w6,	[x5]

    ldr	w12,	[sp, #1752]

    add	w17,	w0,	w6
    add	w0,	w12,	#1
    str	w0,	[sp, #1392]

    ldr	w1,	[sp, #1392]

    lsl	w5,	w1,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w2,	[sp, #1392]

    add	w7,	w17,	w5
    add	w14,	w2,	#1
    str	w14,	[sp, #1760]

    ldr	w15,	[sp, #1760]

    lsl	w0,	w15,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    ldr	w16,	[sp, #1760]

    add	w0,	w7,	w0
    add	w4,	w16,	#1
    str	w4,	[sp, #532]

    ldr	w5,	[sp, #532]

    lsl	w13,	w5,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w14,	[x6]

    ldr	w6,	[sp, #532]

    add	w19,	w0,	w14
    add	w9,	w6,	#1
    str	w9,	[sp, #552]

    ldr	w10,	[sp, #552]

    lsl	w5,	w10,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w11,	[sp, #552]

    add	w7,	w19,	w0
    add	w13,	w11,	#1
    str	w13,	[sp, #556]

    ldr	w14,	[sp, #556]

    lsl	w0,	w14,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w14,	[x13]

    ldr	w15,	[sp, #556]

    add	w0,	w7,	w14
    add	w17,	w15,	#1
    str	w17,	[sp, #560]

    ldr	w18,	[sp, #560]

    lsl	w13,	w18,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w7,	[x6]

    ldr	w19,	[sp, #560]

    add	w13,	w0,	w7
    add	w18,	w19,	#1
    str	w18,	[sp, #1764]

    ldr	w19,	[sp, #1764]

    lsl	w6,	w19,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w20,	[sp, #1764]

    add	w8,	w6,	w13
    add	w21,	w20,	#1
    str	w21,	[sp, #572]

    ldr	w22,	[sp, #572]

    lsl	w0,	w22,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w23,	[sp, #572]

    add	w0,	w8,	w0
    add	w25,	w23,	#1
    str	w25,	[sp, #1468]

    ldr	w26,	[sp, #1468]

    lsl	w14,	w26,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w27,	[sp, #1468]

    add	w13,	w0,	w14
    add	w22,	w27,	#1
    str	w22,	[sp, #1768]

    ldr	w23,	[sp, #1768]

    lsl	w5,	w23,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w24,	[sp, #1768]

    add	w6,	w13,	w0
    add	w26,	w24,	#1
    str	w26,	[sp, #1772]

    ldr	w27,	[sp, #1772]

    lsl	w0,	w27,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w28,	[sp, #1772]

    add	w2,	w6,	w14
    add	w0,	w28,	#1
    str	w0,	[sp, #1472]

    ldr	w1,	[sp, #1472]

    lsl	w14,	w1,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    add	w17,	w2,	w7
    ldr	w2,	[sp, #1472]

    add	w4,	w2,	#1
    str	w4,	[sp, #1476]

    ldr	w5,	[sp, #1476]

    lsl	w5,	w5,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w6,	[sp, #1476]

    add	w5,	w17,	w5
    add	w8,	w6,	#1
    str	w8,	[sp, #1480]

    ldr	w9,	[sp, #1480]

    lsl	w0,	w9,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w10,	[sp, #1480]

    add	w0,	w5,	w0
    add	w12,	w10,	#1
    str	w12,	[sp, #1484]

    ldr	w13,	[sp, #1484]

    lsl	w14,	w13,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    add	w13,	w14,	w0
    ldr	w14,	[sp, #1484]

    add	w16,	w14,	#1
    str	w16,	[sp, #1488]

    ldr	w17,	[sp, #1488]

    lsl	w5,	w17,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w18,	[sp, #1488]

    add	w7,	w13,	w0
    add	w1,	w18,	#1
    str	w1,	[sp, #1784]

    ldr	w2,	[sp, #1784]

    lsl	w0,	w2,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w3,	[sp, #1784]

    add	w0,	w7,	w14
    add	w5,	w3,	#1
    str	w5,	[sp, #1788]

    ldr	w6,	[sp, #1788]

    lsl	w13,	w6,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w7,	[sp, #1788]

    add	w17,	w0,	w6
    add	w9,	w7,	#1
    str	w9,	[sp, #1792]

    ldr	w10,	[sp, #1792]

    lsl	w6,	w10,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w11,	[sp, #1792]

    add	w7,	w17,	w6
    add	w20,	w11,	#1
    str	w20,	[sp, #1492]

    ldr	w21,	[sp, #1492]

    lsl	w0,	w21,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w22,	[sp, #1492]

    add	w0,	w7,	w0
    add	w24,	w22,	#1
    str	w24,	[sp, #640]

    ldr	w25,	[sp, #640]

    lsl	w14,	w25,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w26,	[sp, #640]

    add	w14,	w0,	w14
    add	w28,	w26,	#1
    str	w28,	[sp, #652]

    ldr	w0,	[sp, #652]

    lsl	w5,	w0,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w1,	[sp, #652]

    add	w6,	w14,	w0
    add	w13,	w1,	#1
    str	w13,	[sp, #1804]

    ldr	w14,	[sp, #1804]

    lsl	w0,	w14,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w15,	[sp, #1804]

    add	w0,	w14,	w6
    add	w3,	w15,	#1
    str	w3,	[sp, #656]

    ldr	w4,	[sp, #656]

    lsl	w14,	w4,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w5,	[sp, #656]

    add	w17,	w0,	w7
    add	w7,	w5,	#1
    str	w7,	[sp, #660]

    ldr	w8,	[sp, #660]

    lsl	w5,	w8,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w9,	[sp, #660]

    add	w5,	w17,	w5
    add	w11,	w9,	#1
    str	w11,	[sp, #664]

    ldr	w12,	[sp, #664]

    lsl	w0,	w12,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w13,	[sp, #664]

    add	w0,	w5,	w0
    add	w15,	w13,	#1
    str	w15,	[sp, #668]

    ldr	w16,	[sp, #668]

    lsl	w14,	w16,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w17,	[sp, #668]

    add	w13,	w0,	w14
    add	w19,	w17,	#1
    str	w19,	[sp, #672]

    ldr	w20,	[sp, #672]

    lsl	w5,	w20,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w21,	[sp, #672]

    add	w5,	w13,	w0
    add	w23,	w21,	#1
    str	w23,	[sp, #676]

    ldr	w24,	[sp, #676]

    lsl	w0,	w24,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w25,	[sp, #676]

    add	w0,	w5,	w14
    add	w17,	w25,	#1
    str	w17,	[sp, #1808]

    ldr	w18,	[sp, #1808]

    lsl	w13,	w18,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w19,	[sp, #1808]

    add	w13,	w0,	w6
    add	w21,	w19,	#1
    str	w21,	[sp, #1812]

    ldr	w22,	[sp, #1812]

    lsl	w6,	w22,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w23,	[sp, #1812]

    add	w6,	w6,	w13
    add	w25,	w23,	#1
    str	w25,	[sp, #1816]

    ldr	w26,	[sp, #1816]

    lsl	w0,	w26,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w27,	[sp, #1816]

    add	w2,	w6,	w0
    add	w0,	w27,	#1
    str	w0,	[sp, #1820]

    ldr	w1,	[sp, #1820]

    lsl	w14,	w1,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    add	w17,	w2,	w14
    ldr	w2,	[sp, #1820]

    add	w4,	w2,	#1
    str	w4,	[sp, #1824]

    ldr	w5,	[sp, #1824]

    lsl	w5,	w5,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w6,	[sp, #1824]

    add	w7,	w17,	w0
    add	w8,	w6,	#1
    str	w8,	[sp, #1828]

    ldr	w9,	[sp, #1828]

    lsl	w0,	w9,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w10,	[sp, #1828]

    add	w0,	w7,	w14
    add	w27,	w10,	#1
    str	w27,	[sp, #688]

    ldr	w28,	[sp, #688]

    lsl	w14,	w28,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    add	w16,	w0,	w7
    ldr	w0,	[sp, #688]

    add	w12,	w0,	#1
    str	w12,	[sp, #1840]

    ldr	w13,	[sp, #1840]

    lsl	w6,	w13,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w14,	[sp, #1840]

    add	w6,	w16,	w6
    add	w25,	w14,	#1
    str	w25,	[sp, #1868]

    ldr	w26,	[sp, #1868]

    lsl	w0,	w26,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w27,	[sp, #1868]

    add	w13,	w6,	w0
    mov	w10,	w13
    add	w0,	w27,	#1
    str	w10,	[sp, #1456]

    mov	w4,	w0
    str	w4,	[sp, #1872]

    b	main_254

main_419:
    ldr	w5,	[sp, #1872]

    mov	w16,	w5
    str	w16,	[sp, #1860]

    ldr	w11,	[sp, #1456]

    mov	w4,	w11
    str	w4,	[sp, #1544]


main_421:
    ldr	w17,	[sp, #1860]

    lsl	w13,	w17,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w0,	[x6]

    ldr	w5,	[sp, #1544]

    ldr	w18,	[sp, #1860]

    add	w19,	w0,	w5
    add	w13,	w18,	#1
    str	w13,	[sp, #1508]

    ldr	w14,	[sp, #1508]

    lsl	w5,	w14,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #1508]

    add	w7,	w19,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #1396]

    ldr	w18,	[sp, #1396]

    lsl	w0,	w18,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w14,	[x13]

    ldr	w19,	[sp, #1396]

    add	w0,	w7,	w14
    add	w2,	w19,	#1
    str	w2,	[sp, #692]

    ldr	w3,	[sp, #692]

    lsl	w12,	w3,	#2
    mov	x5,	x12
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w6,	[x5]

    ldr	w4,	[sp, #692]

    add	w15,	w0,	w6
    add	w21,	w4,	#1
    str	w21,	[sp, #1504]

    ldr	w22,	[sp, #1504]

    lsl	w5,	w22,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w23,	[sp, #1504]

    add	w7,	w15,	w5
    add	w25,	w23,	#1
    str	w25,	[sp, #1380]

    ldr	w26,	[sp, #1380]

    lsl	w0,	w26,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w27,	[sp, #1380]

    add	w0,	w7,	w0
    add	w6,	w27,	#1
    str	w6,	[sp, #1748]

    ldr	w7,	[sp, #1748]

    lsl	w13,	w7,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w14,	[x6]

    ldr	w8,	[sp, #1748]

    add	w16,	w0,	w14
    add	w21,	w8,	#1
    str	w21,	[sp, #1864]

    ldr	w22,	[sp, #1864]

    lsl	w6,	w22,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w23,	[sp, #1864]

    add	w14,	w16,	w0
    add	w0,	w23,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w19,	w0
    mov	w6,	w14
    str	w19,	[sp, #1860]

    str	w6,	[sp, #1544]

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
    ldr	w20,	[sp, #496]

    ldr	w18,	[sp, #1376]

    sdiv	w0,	w13,	w0
    lsl	w5,	w0,	#16
    sub	w5,	w5,	w0,	lsl #0
    sub	w0,	w13,	w5
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #1880]

    ldr	w20,	[sp, #496]

    mov	w9,	w20
    str	w9,	[sp, #1876]

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

