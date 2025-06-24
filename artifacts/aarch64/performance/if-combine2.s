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
    str	w0,	[sp, #1180]

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
    ldr	w18,	[sp, #1180]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x20,	sp,	#20
    add	x15,	sp,	#24
    add	x13,	sp,	#28
    add	x7,	sp,	#32
    add	x8,	sp,	#36
    add	x27,	sp,	#40
    add	x11,	sp,	#44
    add	x25,	sp,	#48
    add	x18,	sp,	#52
    add	x4,	sp,	#56
    add	x28,	sp,	#60
    add	x26,	sp,	#64
    add	x5,	sp,	#68
    add	x1,	sp,	#72
    add	x2,	sp,	#76
    add	x21,	sp,	#80
    add	x23,	sp,	#84
    add	x16,	sp,	#88
    add	x14,	sp,	#92
    add	x22,	sp,	#96
    add	x3,	sp,	#100
    add	x0,	sp,	#104
    add	x19,	sp,	#108
    add	x24,	sp,	#112
    add	x10,	sp,	#116
    add	x17,	sp,	#120
    movz	fp,	#652
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x20,	[sp, #2096]

    add	x20,	sp,	#160
    str	x15,	[sp, #1896]

    add	x15,	sp,	#192
    str	x13,	[sp, #1984]

    add	x13,	sp,	#228
    str	x7,	[sp, #1960]

    add	x7,	sp,	#220
    str	x8,	[sp, #2064]

    add	x8,	sp,	#144
    str	x27,	[sp, #1936]

    add	x27,	sp,	#208
    str	x11,	[sp, #2072]

    add	x11,	sp,	#148
    str	x25,	[sp, #2024]

    add	x25,	sp,	#128
    str	x18,	[sp, #1912]

    add	x18,	sp,	#196
    str	x4,	[sp, #1952]

    add	x4,	sp,	#216
    str	x28,	[sp, #2032]

    add	x28,	sp,	#132
    str	x26,	[sp, #2112]

    add	x26,	sp,	#168
    str	x5,	[sp, #2056]

    add	x5,	sp,	#140
    str	x1,	[sp, #1944]

    add	x1,	sp,	#212
    str	x2,	[sp, #2040]

    add	x2,	sp,	#136
    str	x21,	[sp, #1920]

    add	x21,	sp,	#200
    str	x23,	[sp, #2104]

    add	x23,	sp,	#164
    str	x16,	[sp, #1992]

    add	x16,	sp,	#232
    str	x14,	[sp, #2080]

    add	x14,	sp,	#152
    str	x22,	[sp, #2016]

    add	x22,	sp,	#124
    str	x3,	[sp, #2136]

    add	x3,	sp,	#176
    str	x0,	[sp, #2120]

    add	x0,	sp,	#172
    str	x19,	[sp, #2008]

    add	x19,	sp,	#236
    str	x24,	[sp, #1928]

    add	x24,	sp,	#204
    str	x10,	[sp, #1976]

    add	x10,	sp,	#224
    str	x17,	[sp, #2088]

    add	x17,	sp,	#156
    str	x22,	[sp, fp]

    add	x22,	sp,	#240
    movz	fp,	#660
    str	x25,	[sp, fp]

    add	x25,	sp,	#244
    movz	fp,	#668
    str	x28,	[sp, fp]

    add	x28,	sp,	#248
    movz	fp,	#676
    str	x2,	[sp, fp]

    add	x2,	sp,	#252
    movz	fp,	#684
    str	x5,	[sp, fp]

    add	x5,	sp,	#256
    movz	fp,	#692
    str	x8,	[sp, fp]

    add	x8,	sp,	#260
    movz	fp,	#700
    str	x11,	[sp, fp]

    add	x11,	sp,	#264
    movz	fp,	#708
    str	x14,	[sp, fp]

    add	x14,	sp,	#268
    movz	fp,	#716
    str	x17,	[sp, fp]

    add	x17,	sp,	#272
    movz	fp,	#724
    str	x20,	[sp, fp]

    add	x20,	sp,	#276
    movz	fp,	#732
    str	x23,	[sp, fp]

    add	x23,	sp,	#280
    movz	fp,	#740
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#748
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#756
    str	x3,	[sp, fp]

    add	x3,	sp,	#292
    movz	fp,	#764
    str	x6,	[sp, fp]

    add	x6,	sp,	#296
    movz	fp,	#772
    str	x9,	[sp, fp]

    add	x9,	sp,	#300
    movz	fp,	#780
    str	x12,	[sp, fp]

    add	x12,	sp,	#304
    movz	fp,	#788
    str	x15,	[sp, fp]

    add	x15,	sp,	#308
    movz	fp,	#804
    str	x18,	[sp, fp]

    add	x18,	sp,	#312
    movz	fp,	#812
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#820
    str	x24,	[sp, fp]

    add	x24,	sp,	#320
    movz	fp,	#828
    str	x27,	[sp, fp]

    add	x27,	sp,	#324
    movz	fp,	#836
    str	x1,	[sp, fp]

    add	x1,	sp,	#328
    movz	fp,	#844
    str	x4,	[sp, fp]

    add	x4,	sp,	#332
    movz	fp,	#852
    str	x7,	[sp, fp]

    add	x7,	sp,	#336
    movz	fp,	#860
    str	x10,	[sp, fp]

    add	x10,	sp,	#340
    movz	fp,	#868
    str	x13,	[sp, fp]

    add	x13,	sp,	#344
    movz	fp,	#796
    str	x16,	[sp, fp]

    add	x16,	sp,	#348
    movz	fp,	#876
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
    movz	fp,	#884
    str	x14,	[sp, fp]

    add	x14,	sp,	#384
    movz	fp,	#892
    str	x17,	[sp, fp]

    add	x17,	sp,	#388
    movz	fp,	#900
    str	x20,	[sp, fp]

    add	x20,	sp,	#392
    movz	fp,	#908
    str	x23,	[sp, fp]

    add	x23,	sp,	#396
    movz	fp,	#916
    str	x26,	[sp, fp]

    add	x26,	sp,	#400
    movz	fp,	#924
    str	x0,	[sp, fp]

    add	x0,	sp,	#404
    movz	fp,	#932
    str	x3,	[sp, fp]

    add	x3,	sp,	#408
    movz	fp,	#940
    str	x6,	[sp, fp]

    add	x6,	sp,	#412
    movz	fp,	#948
    str	x9,	[sp, fp]

    movz	fp,	#956
    str	x12,	[sp, fp]

    movz	fp,	#964
    str	x15,	[sp, fp]

    movz	fp,	#972
    str	x18,	[sp, fp]

    movz	fp,	#980
    str	x21,	[sp, fp]

    movz	fp,	#988
    str	x24,	[sp, fp]

    movz	fp,	#996
    str	x27,	[sp, fp]

    movz	fp,	#1004
    str	x1,	[sp, fp]

    movz	fp,	#1012
    str	x4,	[sp, fp]

    movz	fp,	#1020
    str	x7,	[sp, fp]

    movz	fp,	#1028
    str	x10,	[sp, fp]

    movz	fp,	#1036
    str	x13,	[sp, fp]

    movz	w13,	#0
    movz	fp,	#1044
    mov	w7,	w13
    str	x16,	[sp, fp]

    movz	fp,	#1052
    str	x19,	[sp, fp]

    movz	fp,	#1060
    str	x22,	[sp, fp]

    movz	fp,	#1068
    str	x25,	[sp, fp]

    movz	fp,	#1076
    str	x28,	[sp, fp]

    movz	fp,	#1084
    str	x2,	[sp, fp]

    movz	fp,	#1092
    str	x5,	[sp, fp]

    movz	fp,	#1100
    str	x8,	[sp, fp]

    movz	fp,	#1108
    str	x11,	[sp, fp]

    movz	fp,	#1116
    str	x14,	[sp, fp]

    movz	fp,	#1124
    str	x17,	[sp, fp]

    movz	fp,	#1132
    str	x20,	[sp, fp]

    movz	fp,	#1140
    str	x23,	[sp, fp]

    movz	fp,	#1148
    str	x26,	[sp, fp]

    movz	fp,	#1156
    str	x0,	[sp, fp]

    movz	fp,	#1164
    str	x3,	[sp, fp]

    movz	fp,	#1172
    str	x6,	[sp, fp]

    movz	w6,	#0
    mov	w11,	w6
    str	w11,	[sp, #1892]

    str	w7,	[sp, #1880]


main_250:
    movz	w0,	#1
    ldr	x21,	[sp, #2096]

    movz	w13,	#3
    movz	fp,	#652
    mov	w6,	w0
    str	w6,	[x21]

    ldr	x16,	[sp, #1896]

    movz	w6,	#2
    mov	w0,	w6
    str	w0,	[x16]

    movz	w0,	#4
    ldr	x14,	[sp, #1984]

    mov	w6,	w0
    str	w13,	[x14]

    movz	w13,	#6
    ldr	x8,	[sp, #1960]

    str	w6,	[x8]

    ldr	x9,	[sp, #2064]

    movz	w6,	#5
    mov	w0,	w6
    str	w0,	[x9]

    movz	w0,	#7
    ldr	x28,	[sp, #1936]

    mov	w6,	w0
    str	w13,	[x28]

    movz	w13,	#9
    ldr	x12,	[sp, #2072]

    str	w6,	[x12]

    ldr	x26,	[sp, #2024]

    movz	w6,	#8
    mov	w0,	w6
    movz	w6,	#11
    str	w0,	[x26]

    mov	w1,	w6
    movz	w0,	#10
    ldr	x19,	[sp, #1912]

    mov	w7,	w0
    str	w13,	[x19]

    movz	w13,	#12
    ldr	x5,	[sp, #1952]

    str	w7,	[x5]

    ldr	x0,	[sp, #2032]

    str	w1,	[x0]

    movz	w0,	#13
    ldr	x27,	[sp, #2112]

    mov	w7,	w0
    str	w13,	[x27]

    movz	w13,	#15
    ldr	x6,	[sp, #2056]

    mov	w14,	w13
    str	w7,	[x6]

    movz	w13,	#18
    ldr	x2,	[sp, #1944]

    movz	w6,	#14
    mov	w0,	w6
    str	w0,	[x2]

    movz	w0,	#16
    ldr	x3,	[sp, #2040]

    mov	w6,	w0
    str	w14,	[x3]

    ldr	x22,	[sp, #1920]

    str	w6,	[x22]

    ldr	x24,	[sp, #2104]

    movz	w6,	#17
    mov	w0,	w6
    str	w0,	[x24]

    movz	w0,	#19
    ldr	x17,	[sp, #1992]

    mov	w6,	w0
    str	w13,	[x17]

    movz	w13,	#21
    ldr	x15,	[sp, #2080]

    mov	w14,	w13
    str	w6,	[x15]

    movz	w13,	#24
    ldr	x23,	[sp, #2016]

    movz	w6,	#20
    mov	w0,	w6
    movz	w6,	#23
    str	w0,	[x23]

    movz	w0,	#22
    ldr	x4,	[sp, #2136]

    mov	w7,	w0
    str	w14,	[x4]

    mov	w0,	w6
    ldr	x1,	[sp, #2120]

    str	w7,	[x1]

    ldr	x20,	[sp, #2008]

    str	w0,	[x20]

    movz	w0,	#25
    ldr	x25,	[sp, #1928]

    mov	w6,	w0
    str	w13,	[x25]

    movz	w13,	#27
    ldr	x11,	[sp, #1976]

    str	w6,	[x11]

    ldr	x18,	[sp, #2088]

    movz	w6,	#26
    mov	w0,	w6
    str	w0,	[x18]

    movz	w0,	#28
    ldr	x22,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#660
    str	w13,	[x22]

    movz	w13,	#30
    ldr	x25,	[sp, fp]

    movz	fp,	#668
    str	w6,	[x25]

    movz	w6,	#29
    ldr	x28,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#676
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#684
    str	w13,	[x2]

    movz	w13,	#33
    ldr	x6,	[sp, fp]

    mov	w14,	w13
    movz	fp,	#692
    str	w7,	[x6]

    movz	w13,	#36
    movz	w6,	#32
    ldr	x9,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#700
    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#708
    str	w14,	[x11]

    ldr	x15,	[sp, fp]

    movz	fp,	#716
    str	w6,	[x15]

    movz	w6,	#35
    ldr	x18,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#724
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#732
    str	w13,	[x21]

    movz	w13,	#39
    ldr	x24,	[sp, fp]

    mov	w14,	w13
    movz	fp,	#740
    str	w6,	[x24]

    movz	w13,	#42
    movz	w6,	#38
    ldr	x27,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#748
    movz	w6,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#756
    str	w14,	[x1]

    mov	w0,	w6
    mov	w14,	w13
    ldr	x4,	[sp, fp]

    movz	w13,	#45
    movz	fp,	#764
    str	w7,	[x4]

    ldr	x8,	[sp, fp]

    movz	fp,	#772
    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#780
    str	w14,	[x10]

    ldr	x14,	[sp, fp]

    movz	fp,	#788
    str	w6,	[x14]

    movz	w6,	#44
    ldr	x17,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#804
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#812
    str	w13,	[x20]

    movz	w13,	#48
    ldr	x23,	[sp, fp]

    mov	w14,	w13
    movz	fp,	#820
    str	w6,	[x23]

    movz	w13,	#51
    movz	w6,	#47
    ldr	x26,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#828
    movz	w6,	#50
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#836
    str	w14,	[x0]

    mov	w14,	w13
    movz	w0,	#49
    ldr	x3,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#844
    mov	w0,	w6
    str	w7,	[x3]

    ldr	x7,	[sp, fp]

    movz	fp,	#852
    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#860
    str	w14,	[x9]

    ldr	x13,	[sp, fp]

    movz	fp,	#868
    str	w6,	[x13]

    movz	w13,	#54
    movz	w6,	#53
    ldr	x16,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#796
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#876
    str	w13,	[x19]

    movz	w13,	#57
    ldr	x22,	[sp, #416]

    str	w6,	[x22]

    ldr	x25,	[sp, #424]

    movz	w6,	#56
    mov	w0,	w6
    str	w0,	[x25]

    movz	w0,	#58
    ldr	x28,	[sp, #432]

    mov	w6,	w0
    str	w13,	[x28]

    movz	w13,	#60
    ldr	x2,	[sp, #440]

    mov	w14,	w13
    str	w6,	[x2]

    movz	w13,	#63
    movz	w6,	#59
    mov	w0,	w6
    ldr	x6,	[sp, #448]

    str	w0,	[x6]

    movz	w0,	#61
    ldr	x8,	[sp, #456]

    mov	w6,	w0
    str	w14,	[x8]

    movz	w0,	#64
    ldr	x9,	[sp, #464]

    str	w6,	[x9]

    ldr	x12,	[sp, fp]

    movz	w6,	#62
    movz	fp,	#884
    str	w6,	[x12]

    mov	w6,	w0
    ldr	x15,	[sp, fp]

    movz	fp,	#892
    str	w13,	[x15]

    movz	w13,	#66
    ldr	x18,	[sp, fp]

    movz	fp,	#900
    str	w6,	[x18]

    movz	w6,	#65
    ldr	x21,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#908
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#916
    str	w13,	[x24]

    movz	w13,	#69
    ldr	x27,	[sp, fp]

    mov	w14,	w13
    movz	fp,	#924
    str	w6,	[x27]

    movz	w13,	#72
    movz	w6,	#68
    ldr	x1,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#932
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#940
    str	w14,	[x4]

    mov	w14,	w13
    ldr	x7,	[sp, fp]

    movz	fp,	#948
    str	w6,	[x7]

    movz	w6,	#71
    ldr	x10,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#956
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#964
    str	w14,	[x13]

    movz	w13,	#75
    ldr	x16,	[sp, fp]

    movz	fp,	#972
    str	w6,	[x16]

    movz	w6,	#74
    ldr	x19,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#980
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#988
    str	w13,	[x22]

    movz	w13,	#78
    ldr	x25,	[sp, fp]

    movz	fp,	#996
    str	w6,	[x25]

    movz	w6,	#77
    ldr	x28,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#1004
    movz	w6,	#80
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, fp]

    movz	fp,	#1012
    str	w13,	[x2]

    movz	w13,	#81
    ldr	x5,	[sp, fp]

    mov	w14,	w13
    movz	fp,	#1020
    str	w0,	[x5]

    movz	w13,	#84
    mov	w0,	w6
    ldr	x8,	[sp, fp]

    movz	fp,	#1028
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1036
    str	w14,	[x11]

    ldr	x14,	[sp, fp]

    movz	fp,	#1044
    str	w6,	[x14]

    movz	w6,	#83
    ldr	x17,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#1052
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1060
    str	w13,	[x20]

    movz	w13,	#87
    ldr	x23,	[sp, fp]

    mov	w7,	w13
    movz	fp,	#1068
    str	w6,	[x23]

    movz	w13,	#90
    movz	w6,	#86
    ldr	x26,	[sp, fp]

    mov	w14,	w13
    mov	w0,	w6
    movz	fp,	#1076
    movz	w13,	#93
    movz	w6,	#89
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#1084
    str	w7,	[x0]

    movz	w0,	#88
    ldr	x3,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#1092
    mov	w0,	w6
    str	w7,	[x3]

    ldr	x6,	[sp, fp]

    movz	fp,	#1100
    str	w0,	[x6]

    movz	w6,	#92
    movz	w0,	#91
    ldr	x9,	[sp, fp]

    movz	fp,	#1108
    str	w14,	[x9]

    ldr	x12,	[sp, fp]

    movz	fp,	#1116
    str	w0,	[x12]

    mov	w0,	w6
    ldr	x15,	[sp, fp]

    movz	fp,	#1124
    str	w0,	[x15]

    movz	w0,	#94
    ldr	x18,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#1132
    str	w13,	[x18]

    movz	w13,	#96
    ldr	x21,	[sp, fp]

    movz	fp,	#1140
    str	w6,	[x21]

    movz	w6,	#95
    ldr	x24,	[sp, fp]

    mov	w0,	w6
    movz	fp,	#1148
    movz	w6,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, fp]

    mov	w7,	w0
    movz	fp,	#1156
    str	w13,	[x27]

    mov	w0,	w6
    movz	w13,	#99
    ldr	x1,	[sp, fp]

    mov	w14,	w13
    movz	fp,	#1164
    str	w7,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#1172
    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, fp]

    str	w14,	[x7]

    ldr	w8,	[sp, #1880]

    add	w18,	w8,	#1
    str	w18,	[sp, #504]

    ldr	w12,	[sp, #1892]

    mov	w8,	w12
    str	w8,	[sp, #1344]

    str	w0,	[sp, #1876]


main_254:
    ldr	w1,	[sp, #1876]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #1876]

    lsl	w0,	w2,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w6,	[x14]

    ldr	w9,	[sp, #1344]

    ldr	w3,	[sp, #1876]

    add	w0,	w6,	w9
    add	w25,	w3,	#1
    str	w25,	[sp, #1188]

    ldr	w26,	[sp, #1188]

    lsl	w14,	w26,	#2
    mov	x6,	x14
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w8,	[x6]

    ldr	w27,	[sp, #1188]

    add	w17,	w0,	w8
    add	w0,	w27,	#1
    str	w0,	[sp, #1208]

    ldr	w1,	[sp, #1208]

    lsl	w6,	w1,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w2,	[sp, #1208]

    add	w8,	w17,	w6
    add	w2,	w2,	#1
    str	w2,	[sp, #1256]

    ldr	w3,	[sp, #1256]

    lsl	w0,	w3,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w4,	[sp, #1256]

    add	w0,	w8,	w0
    add	w6,	w4,	#1
    str	w6,	[sp, #1268]

    ldr	w7,	[sp, #1268]

    lsl	w14,	w7,	#2
    mov	x6,	x14
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w15,	[x6]

    ldr	w8,	[sp, #1268]

    add	w19,	w0,	w15
    add	w4,	w8,	#1
    str	w4,	[sp, #1220]

    ldr	w5,	[sp, #1220]

    lsl	w6,	w5,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w6,	[sp, #1220]

    add	w9,	w19,	w0
    add	w10,	w6,	#1
    str	w10,	[sp, #1272]

    ldr	w11,	[sp, #1272]

    lsl	w0,	w11,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w15,	[x14]

    ldr	w12,	[sp, #1272]

    add	w0,	w9,	w15
    add	w9,	w12,	#1
    str	w9,	[sp, #524]

    ldr	w10,	[sp, #524]

    lsl	w14,	w10,	#2
    mov	x6,	x14
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w8,	[x6]

    ldr	w11,	[sp, #524]

    add	w17,	w0,	w8
    add	w14,	w11,	#1
    str	w14,	[sp, #1284]

    ldr	w15,	[sp, #1284]

    lsl	w6,	w15,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w16,	[sp, #1284]

    add	w8,	w6,	w17
    add	w13,	w16,	#1
    str	w13,	[sp, #528]

    ldr	w14,	[sp, #528]

    lsl	w0,	w14,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w15,	[sp, #528]

    add	w0,	w8,	w0
    add	w18,	w15,	#1
    str	w18,	[sp, #1288]

    ldr	w19,	[sp, #1288]

    lsl	w15,	w19,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w15,	[x8]

    ldr	w20,	[sp, #1288]

    add	w14,	w0,	w15
    add	w22,	w20,	#1
    str	w22,	[sp, #1292]

    ldr	w23,	[sp, #1292]

    lsl	w6,	w23,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w24,	[sp, #1292]

    add	w6,	w14,	w0
    add	w26,	w24,	#1
    str	w26,	[sp, #1712]

    ldr	w27,	[sp, #1712]

    lsl	w0,	w27,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w15,	[x15]

    ldr	w28,	[sp, #1712]

    add	w0,	w6,	w15
    add	w1,	w28,	#1
    str	w1,	[sp, #1716]

    ldr	w2,	[sp, #1716]

    lsl	w14,	w2,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w3,	[sp, #1716]

    add	w14,	w0,	w7
    add	w17,	w3,	#1
    str	w17,	[sp, #540]

    ldr	w18,	[sp, #540]

    lsl	w6,	w18,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w19,	[sp, #540]

    add	w6,	w14,	w6
    add	w21,	w19,	#1
    str	w21,	[sp, #552]

    ldr	w22,	[sp, #552]

    lsl	w0,	w22,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w23,	[sp, #552]

    add	w0,	w6,	w0
    add	w5,	w23,	#1
    str	w5,	[sp, #1728]

    ldr	w6,	[sp, #1728]

    lsl	w15,	w6,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w15,	[x8]

    ldr	w7,	[sp, #1728]

    add	w16,	w15,	w0
    add	w9,	w7,	#1
    str	w9,	[sp, #1740]

    ldr	w10,	[sp, #1740]

    lsl	w6,	w10,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w11,	[sp, #1740]

    add	w6,	w16,	w0
    add	w25,	w11,	#1
    str	w25,	[sp, #556]

    ldr	w26,	[sp, #556]

    lsl	w0,	w26,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w27,	[sp, #556]

    add	w0,	w6,	w14
    add	w13,	w27,	#1
    str	w13,	[sp, #1744]

    ldr	w14,	[sp, #1744]

    lsl	w14,	w14,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w15,	[sp, #1744]

    add	w14,	w0,	w7
    add	w17,	w15,	#1
    str	w17,	[sp, #1756]

    ldr	w18,	[sp, #1756]

    lsl	w6,	w18,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w19,	[sp, #1756]

    add	w6,	w14,	w6
    add	w21,	w19,	#1
    str	w21,	[sp, #1768]

    ldr	w22,	[sp, #1768]

    lsl	w0,	w22,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w23,	[sp, #1768]

    add	w3,	w6,	w0
    add	w0,	w23,	#1
    str	w0,	[sp, #560]

    ldr	w1,	[sp, #560]

    lsl	w15,	w1,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w15,	[x8]

    ldr	w2,	[sp, #560]

    add	w16,	w3,	w15
    add	w4,	w2,	#1
    str	w4,	[sp, #580]

    ldr	w5,	[sp, #580]

    lsl	w6,	w5,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w6,	[sp, #580]

    add	w7,	w16,	w0
    add	w8,	w6,	#1
    str	w8,	[sp, #584]

    ldr	w9,	[sp, #584]

    lsl	w0,	w9,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w10,	[sp, #584]

    add	w0,	w14,	w7
    add	w25,	w10,	#1
    str	w25,	[sp, #1780]

    ldr	w26,	[sp, #1780]

    lsl	w14,	w26,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w27,	[sp, #1780]

    add	w15,	w0,	w7
    add	w12,	w27,	#1
    str	w12,	[sp, #588]

    ldr	w13,	[sp, #588]

    lsl	w6,	w13,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w14,	[sp, #588]

    add	w8,	w15,	w6
    add	w0,	w14,	#1
    str	w0,	[sp, #1792]

    ldr	w1,	[sp, #1792]

    lsl	w0,	w1,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w2,	[sp, #1792]

    add	w0,	w8,	w0
    add	w16,	w2,	#1
    str	w16,	[sp, #592]

    ldr	w17,	[sp, #592]

    lsl	w15,	w17,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w15,	[x8]

    ldr	w18,	[sp, #592]

    add	w14,	w0,	w15
    add	w20,	w18,	#1
    str	w20,	[sp, #596]

    ldr	w21,	[sp, #596]

    lsl	w6,	w21,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w22,	[sp, #596]

    add	w6,	w14,	w0
    add	w24,	w22,	#1
    str	w24,	[sp, #600]

    ldr	w25,	[sp, #600]

    lsl	w0,	w25,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w26,	[sp, #600]

    add	w1,	w6,	w14
    add	w28,	w26,	#1
    str	w28,	[sp, #604]

    ldr	w0,	[sp, #604]

    lsl	w15,	w0,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w8,	[x8]

    add	w17,	w1,	w8
    ldr	w1,	[sp, #604]

    add	w3,	w1,	#1
    str	w3,	[sp, #616]

    ldr	w4,	[sp, #616]

    lsl	w6,	w4,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w5,	[sp, #616]

    add	w9,	w6,	w17
    add	w7,	w5,	#1
    str	w7,	[sp, #628]

    ldr	w8,	[sp, #628]

    lsl	w0,	w8,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    add	w0,	w9,	w0
    ldr	w9,	[sp, #628]

    add	w11,	w9,	#1
    str	w11,	[sp, #640]

    ldr	w12,	[sp, #640]

    lsl	w15,	w12,	#2
    mov	x8,	x15
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w15,	[x8]

    ldr	w13,	[sp, #640]

    add	w17,	w0,	w15
    add	w4,	w13,	#1
    str	w4,	[sp, #1804]

    ldr	w5,	[sp, #1804]

    lsl	w6,	w5,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w6,	[sp, #1804]

    add	w10,	w17,	w0
    add	w8,	w6,	#1
    str	w8,	[sp, #1808]

    ldr	w9,	[sp, #1808]

    lsl	w0,	w9,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w15,	[x15]

    add	w0,	w10,	w15
    ldr	w10,	[sp, #1808]

    add	w12,	w10,	#1
    str	w12,	[sp, #1828]

    ldr	w13,	[sp, #1828]

    lsl	w14,	w13,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w14,	[sp, #1828]

    add	w13,	w0,	w7
    add	w15,	w14,	#1
    str	w15,	[sp, #1224]

    ldr	w16,	[sp, #1224]

    lsl	w6,	w16,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w17,	[sp, #1224]

    add	w6,	w13,	w6
    add	w16,	w17,	#1
    str	w16,	[sp, #1840]

    ldr	w17,	[sp, #1840]

    lsl	w0,	w17,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w0,	[x14]

    ldr	w18,	[sp, #1840]

    add	w14,	w6,	w0
    mov	w10,	w14
    add	w0,	w18,	#1
    str	w10,	[sp, #1344]

    mov	w4,	w0
    str	w4,	[sp, #1876]

    b	main_254

main_419:
    ldr	w5,	[sp, #1876]

    mov	w20,	w5
    str	w20,	[sp, #1844]

    ldr	w11,	[sp, #1344]

    mov	w4,	w11
    str	w4,	[sp, #1700]


main_421:
    ldr	w21,	[sp, #1844]

    lsl	w14,	w21,	#2
    mov	x6,	x14
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w0,	[x6]

    ldr	w5,	[sp, #1700]

    ldr	w22,	[sp, #1844]

    add	w18,	w0,	w5
    add	w13,	w22,	#1
    str	w13,	[sp, #1356]

    ldr	w14,	[sp, #1356]

    lsl	w6,	w14,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #1356]

    add	w8,	w18,	w0
    add	w19,	w15,	#1
    str	w19,	[sp, #1236]

    ldr	w20,	[sp, #1236]

    lsl	w0,	w20,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w15,	[x14]

    ldr	w21,	[sp, #1236]

    add	w0,	w8,	w15
    add	w23,	w21,	#1
    str	w23,	[sp, #1240]

    ldr	w24,	[sp, #1240]

    lsl	w13,	w24,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w7,	[x6]

    ldr	w25,	[sp, #1240]

    add	w15,	w0,	w7
    add	w17,	w25,	#1
    str	w17,	[sp, #1360]

    ldr	w18,	[sp, #1360]

    lsl	w6,	w18,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w6,	[x0]

    ldr	w19,	[sp, #1360]

    add	w7,	w15,	w6
    add	w27,	w19,	#1
    str	w27,	[sp, #1252]

    ldr	w28,	[sp, #1252]

    lsl	w0,	w28,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    add	w1,	w7,	w0
    ldr	w0,	[sp, #1252]

    add	w21,	w0,	#1
    str	w21,	[sp, #1184]

    ldr	w22,	[sp, #1184]

    lsl	w14,	w22,	#2
    mov	x6,	x14
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w15,	[x6]

    ldr	w23,	[sp, #1184]

    add	w16,	w1,	w15
    add	w25,	w23,	#1
    str	w25,	[sp, #1864]

    ldr	w26,	[sp, #1864]

    lsl	w6,	w26,	#2
    mov	x0,	x6
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w27,	[sp, #1864]

    add	w15,	w16,	w0
    add	w0,	w27,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w23,	w0
    mov	w6,	w15
    str	w23,	[sp, #1844]

    str	w6,	[sp, #1700]

    b	main_421

main_457:
    mov	w13,	w15

main_459:
    lsl	w7,	w0,	#2
    add	w0,	w0,	#1
    mov	x7,	x7
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    add	w14,	w7,	w13
    cmp	w0,	#100
    blt	main_458

main_467:
    movz	w0,	#65535
    ldr	w20,	[sp, #504]

    ldr	w18,	[sp, #1180]

    sdiv	w0,	w14,	w0
    lsl	w6,	w0,	#16
    sub	w6,	w6,	w0,	lsl #0
    sub	w0,	w14,	w6
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #1892]

    ldr	w20,	[sp, #504]

    mov	w9,	w20
    str	w9,	[sp, #1880]

    b	main_250

main_458:
    mov	w13,	w14
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

