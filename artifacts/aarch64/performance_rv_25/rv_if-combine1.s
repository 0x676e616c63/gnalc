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
    str	w0,	[sp, #1132]

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
    ldr	w18,	[sp, #1132]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x13,	sp,	#20
    add	x11,	sp,	#24
    add	x3,	sp,	#28
    add	x8,	sp,	#32
    add	x4,	sp,	#36
    add	x14,	sp,	#40
    add	x20,	sp,	#44
    add	x19,	sp,	#48
    add	x23,	sp,	#52
    add	x17,	sp,	#56
    add	x1,	sp,	#60
    add	x24,	sp,	#64
    add	x2,	sp,	#68
    add	x7,	sp,	#72
    add	x25,	sp,	#76
    add	x5,	sp,	#80
    add	x10,	sp,	#84
    add	x26,	sp,	#88
    add	x15,	sp,	#92
    add	x22,	sp,	#96
    add	x27,	sp,	#100
    add	x16,	sp,	#104
    add	x0,	sp,	#108
    add	x18,	sp,	#112
    add	x21,	sp,	#116
    add	x28,	sp,	#120
    movz	fp,	#660
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x13,	[sp, #1888]

    add	x13,	sp,	#228
    str	x11,	[sp, #1976]

    add	x11,	sp,	#148
    str	x3,	[sp, #2072]

    add	x3,	sp,	#176
    str	x8,	[sp, #1968]

    add	x8,	sp,	#144
    str	x4,	[sp, #1840]

    add	x4,	sp,	#216
    str	x14,	[sp, #1984]

    add	x14,	sp,	#152
    str	x20,	[sp, #2000]

    add	x20,	sp,	#160
    str	x19,	[sp, #1904]

    add	x19,	sp,	#236
    str	x23,	[sp, #2024]

    add	x23,	sp,	#164
    str	x17,	[sp, #1992]

    add	x17,	sp,	#156
    str	x1,	[sp, #1832]

    add	x1,	sp,	#212
    str	x24,	[sp, #1808]

    add	x24,	sp,	#204
    str	x2,	[sp, #1944]

    add	x2,	sp,	#136
    str	x7,	[sp, #1856]

    add	x7,	sp,	#220
    str	x25,	[sp, #1928]

    add	x25,	sp,	#128
    str	x5,	[sp, #1960]

    add	x5,	sp,	#140
    str	x10,	[sp, #1872]

    add	x10,	sp,	#224
    str	x26,	[sp, #2040]

    add	x26,	sp,	#168
    str	x15,	[sp, #1768]

    add	x15,	sp,	#192
    str	x22,	[sp, #1920]

    add	x22,	sp,	#124
    str	x27,	[sp, #1824]

    add	x27,	sp,	#208
    str	x16,	[sp, #1896]

    add	x16,	sp,	#232
    str	x0,	[sp, #2056]

    add	x0,	sp,	#172
    str	x18,	[sp, #1792]

    add	x18,	sp,	#196
    str	x21,	[sp, #1800]

    add	x21,	sp,	#200
    str	x28,	[sp, #1936]

    add	x28,	sp,	#132
    str	x22,	[sp, #552]

    add	x22,	sp,	#240
    str	x25,	[sp, #560]

    add	x25,	sp,	#244
    str	x28,	[sp, #568]

    add	x28,	sp,	#248
    str	x2,	[sp, #576]

    add	x2,	sp,	#252
    str	x5,	[sp, #584]

    add	x5,	sp,	#256
    str	x8,	[sp, #592]

    add	x8,	sp,	#260
    str	x11,	[sp, #600]

    add	x11,	sp,	#264
    str	x14,	[sp, fp]

    add	x14,	sp,	#268
    movz	fp,	#668
    str	x17,	[sp, fp]

    add	x17,	sp,	#272
    movz	fp,	#676
    str	x20,	[sp, fp]

    add	x20,	sp,	#276
    movz	fp,	#684
    str	x23,	[sp, fp]

    add	x23,	sp,	#280
    movz	fp,	#692
    str	x26,	[sp, fp]

    add	x26,	sp,	#284
    movz	fp,	#700
    str	x0,	[sp, fp]

    add	x0,	sp,	#288
    movz	fp,	#708
    str	x3,	[sp, fp]

    add	x3,	sp,	#292
    movz	fp,	#716
    str	x6,	[sp, fp]

    add	x6,	sp,	#296
    movz	fp,	#724
    str	x9,	[sp, fp]

    add	x9,	sp,	#300
    movz	fp,	#732
    str	x12,	[sp, fp]

    add	x12,	sp,	#304
    movz	fp,	#748
    str	x15,	[sp, fp]

    add	x15,	sp,	#308
    movz	fp,	#756
    str	x18,	[sp, fp]

    add	x18,	sp,	#312
    movz	fp,	#764
    str	x21,	[sp, fp]

    add	x21,	sp,	#316
    movz	fp,	#772
    str	x24,	[sp, fp]

    add	x24,	sp,	#320
    movz	fp,	#780
    str	x27,	[sp, fp]

    add	x27,	sp,	#324
    movz	fp,	#788
    str	x1,	[sp, fp]

    add	x1,	sp,	#328
    movz	fp,	#796
    str	x4,	[sp, fp]

    add	x4,	sp,	#332
    movz	fp,	#804
    str	x7,	[sp, fp]

    add	x7,	sp,	#336
    movz	fp,	#812
    str	x10,	[sp, fp]

    add	x10,	sp,	#340
    movz	fp,	#820
    str	x13,	[sp, fp]

    add	x13,	sp,	#344
    movz	fp,	#740
    str	x16,	[sp, fp]

    add	x16,	sp,	#348
    movz	fp,	#828
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
    movz	fp,	#836
    str	x14,	[sp, fp]

    add	x14,	sp,	#384
    movz	fp,	#844
    str	x17,	[sp, fp]

    add	x17,	sp,	#388
    movz	fp,	#852
    str	x20,	[sp, fp]

    add	x20,	sp,	#392
    movz	fp,	#860
    str	x23,	[sp, fp]

    add	x23,	sp,	#396
    movz	fp,	#868
    str	x26,	[sp, fp]

    add	x26,	sp,	#400
    movz	fp,	#876
    str	x0,	[sp, fp]

    add	x0,	sp,	#404
    movz	fp,	#884
    str	x3,	[sp, fp]

    add	x3,	sp,	#408
    movz	fp,	#892
    str	x6,	[sp, fp]

    add	x6,	sp,	#412
    movz	fp,	#900
    str	x9,	[sp, fp]

    movz	fp,	#908
    str	x12,	[sp, fp]

    movz	fp,	#916
    str	x15,	[sp, fp]

    movz	w15,	#0
    movz	fp,	#932
    str	x18,	[sp, fp]

    movz	fp,	#940
    str	x21,	[sp, fp]

    movz	fp,	#948
    str	x24,	[sp, fp]

    movz	fp,	#956
    str	x27,	[sp, fp]

    movz	fp,	#964
    str	x1,	[sp, fp]

    movz	fp,	#972
    str	x4,	[sp, fp]

    movz	fp,	#980
    str	x7,	[sp, fp]

    mov	w7,	w15
    movz	fp,	#988
    str	x10,	[sp, fp]

    movz	fp,	#996
    str	x13,	[sp, fp]

    movz	fp,	#1004
    str	x16,	[sp, fp]

    movz	fp,	#924
    str	x19,	[sp, fp]

    movz	fp,	#1012
    str	x22,	[sp, fp]

    movz	fp,	#1020
    str	x25,	[sp, fp]

    movz	fp,	#1028
    str	x28,	[sp, fp]

    movz	fp,	#1036
    str	x2,	[sp, fp]

    movz	fp,	#1044
    str	x5,	[sp, fp]

    movz	fp,	#1052
    str	x8,	[sp, fp]

    movz	w8,	#0
    movz	fp,	#1060
    str	x11,	[sp, fp]

    mov	w11,	w8
    movz	fp,	#1068
    str	x14,	[sp, fp]

    movz	fp,	#1076
    str	x17,	[sp, fp]

    movz	fp,	#1084
    str	x20,	[sp, fp]

    movz	fp,	#1092
    str	x23,	[sp, fp]

    movz	fp,	#1100
    str	x26,	[sp, fp]

    movz	fp,	#1108
    str	x0,	[sp, fp]

    movz	fp,	#1116
    str	x3,	[sp, fp]

    movz	fp,	#1124
    str	x6,	[sp, fp]

    str	w11,	[sp, #1756]

    str	w7,	[sp, #1752]


main_250:
    movz	w0,	#1
    ldr	x14,	[sp, #1888]

    movz	w15,	#3
    movz	fp,	#660
    mov	w8,	w0
    mov	w16,	w15
    str	w8,	[x14]

    movz	w15,	#6
    ldr	x12,	[sp, #1976]

    movz	w8,	#2
    mov	w0,	w8
    str	w0,	[x12]

    movz	w0,	#4
    ldr	x4,	[sp, #2072]

    mov	w8,	w0
    str	w16,	[x4]

    mov	w16,	w15
    ldr	x9,	[sp, #1968]

    str	w8,	[x9]

    ldr	x5,	[sp, #1840]

    movz	w8,	#5
    mov	w0,	w8
    str	w0,	[x5]

    movz	w0,	#7
    ldr	x15,	[sp, #1984]

    mov	w8,	w0
    str	w16,	[x15]

    movz	w15,	#9
    ldr	x21,	[sp, #2000]

    str	w8,	[x21]

    ldr	x20,	[sp, #1904]

    movz	w8,	#8
    mov	w0,	w8
    str	w0,	[x20]

    movz	w0,	#10
    ldr	x24,	[sp, #2024]

    mov	w8,	w0
    str	w15,	[x24]

    movz	w15,	#12
    ldr	x18,	[sp, #1992]

    str	w8,	[x18]

    ldr	x2,	[sp, #1832]

    movz	w8,	#11
    mov	w0,	w8
    str	w0,	[x2]

    movz	w0,	#13
    ldr	x25,	[sp, #1808]

    mov	w8,	w0
    str	w15,	[x25]

    movz	w15,	#15
    ldr	x3,	[sp, #1944]

    str	w8,	[x3]

    movz	w8,	#14
    mov	w0,	w8
    ldr	x8,	[sp, #1856]

    str	w0,	[x8]

    movz	w8,	#17
    movz	w0,	#16
    ldr	x26,	[sp, #1928]

    mov	w9,	w0
    str	w15,	[x26]

    mov	w0,	w8
    movz	w15,	#18
    ldr	x6,	[sp, #1960]

    str	w9,	[x6]

    ldr	x11,	[sp, #1872]

    str	w0,	[x11]

    movz	w0,	#19
    ldr	x27,	[sp, #2040]

    mov	w8,	w0
    str	w15,	[x27]

    movz	w15,	#21
    ldr	x16,	[sp, #1768]

    str	w8,	[x16]

    ldr	x23,	[sp, #1920]

    movz	w8,	#20
    mov	w0,	w8
    str	w0,	[x23]

    movz	w0,	#22
    ldr	x28,	[sp, #1824]

    mov	w8,	w0
    str	w15,	[x28]

    movz	w15,	#24
    ldr	x17,	[sp, #1896]

    str	w8,	[x17]

    ldr	x1,	[sp, #2056]

    movz	w8,	#23
    mov	w0,	w8
    str	w0,	[x1]

    movz	w0,	#25
    ldr	x19,	[sp, #1792]

    mov	w8,	w0
    str	w15,	[x19]

    movz	w15,	#27
    ldr	x22,	[sp, #1800]

    str	w8,	[x22]

    ldr	x0,	[sp, #1936]

    movz	w8,	#26
    mov	w1,	w8
    str	w1,	[x0]

    movz	w0,	#28
    ldr	x22,	[sp, #552]

    mov	w8,	w0
    str	w15,	[x22]

    movz	w15,	#30
    ldr	x25,	[sp, #560]

    str	w8,	[x25]

    ldr	x28,	[sp, #568]

    movz	w8,	#29
    mov	w0,	w8
    movz	w8,	#32
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, #576]

    mov	w9,	w0
    str	w15,	[x2]

    mov	w0,	w8
    movz	w15,	#33
    ldr	x6,	[sp, #584]

    mov	w16,	w15
    str	w9,	[x6]

    ldr	x9,	[sp, #592]

    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, #600]

    mov	w8,	w0
    str	w16,	[x11]

    ldr	x15,	[sp, fp]

    movz	fp,	#668
    str	w8,	[x15]

    movz	w15,	#36
    movz	w8,	#35
    ldr	x18,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#676
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#684
    str	w15,	[x21]

    movz	w15,	#39
    ldr	x24,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#692
    str	w8,	[x24]

    movz	w15,	#42
    movz	w8,	#38
    ldr	x27,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#700
    movz	w8,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, fp]

    mov	w9,	w0
    movz	fp,	#708
    str	w16,	[x1]

    mov	w0,	w8
    mov	w16,	w15
    ldr	x4,	[sp, fp]

    movz	w15,	#45
    movz	fp,	#716
    str	w9,	[x4]

    ldr	x8,	[sp, fp]

    movz	fp,	#724
    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#732
    str	w16,	[x10]

    ldr	x14,	[sp, fp]

    movz	fp,	#748
    str	w8,	[x14]

    movz	w8,	#44
    ldr	x17,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#756
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#764
    str	w15,	[x20]

    movz	w15,	#48
    ldr	x23,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#772
    str	w8,	[x23]

    movz	w15,	#51
    movz	w8,	#47
    ldr	x26,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#780
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#788
    str	w16,	[x0]

    mov	w16,	w15
    movz	w0,	#49
    ldr	x3,	[sp, fp]

    movz	w15,	#54
    mov	w8,	w0
    movz	fp,	#796
    str	w8,	[x3]

    ldr	x7,	[sp, fp]

    movz	w8,	#50
    movz	fp,	#804
    mov	w0,	w8
    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#812
    str	w16,	[x9]

    ldr	x13,	[sp, fp]

    movz	fp,	#820
    str	w8,	[x13]

    movz	w8,	#53
    ldr	x16,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#740
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#828
    str	w15,	[x19]

    movz	w15,	#57
    ldr	x22,	[sp, #416]

    str	w8,	[x22]

    ldr	x25,	[sp, #424]

    movz	w8,	#56
    mov	w0,	w8
    str	w0,	[x25]

    movz	w0,	#58
    ldr	x28,	[sp, #432]

    mov	w8,	w0
    str	w15,	[x28]

    movz	w15,	#60
    ldr	x2,	[sp, #440]

    mov	w16,	w15
    str	w8,	[x2]

    movz	w15,	#63
    ldr	x6,	[sp, #448]

    movz	w8,	#59
    mov	w0,	w8
    str	w0,	[x6]

    movz	w0,	#61
    ldr	x8,	[sp, #456]

    str	w16,	[x8]

    mov	w16,	w15
    ldr	x9,	[sp, #464]

    mov	w8,	w0
    movz	w0,	#64
    str	w8,	[x9]

    ldr	x12,	[sp, fp]

    movz	w8,	#62
    movz	fp,	#836
    str	w8,	[x12]

    mov	w8,	w0
    ldr	x15,	[sp, fp]

    movz	fp,	#844
    str	w16,	[x15]

    movz	w15,	#66
    ldr	x18,	[sp, fp]

    movz	fp,	#852
    str	w8,	[x18]

    movz	w8,	#65
    ldr	x21,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#860
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#868
    str	w15,	[x24]

    movz	w15,	#69
    ldr	x27,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#876
    str	w8,	[x27]

    movz	w15,	#72
    movz	w8,	#68
    ldr	x1,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#884
    movz	w8,	#71
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, fp]

    mov	w9,	w0
    movz	fp,	#892
    str	w16,	[x4]

    mov	w0,	w8
    mov	w16,	w15
    ldr	x7,	[sp, fp]

    movz	w15,	#75
    movz	fp,	#900
    str	w9,	[x7]

    ldr	x10,	[sp, fp]

    movz	fp,	#908
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#916
    str	w16,	[x13]

    ldr	x16,	[sp, fp]

    movz	fp,	#932
    str	w8,	[x16]

    movz	w8,	#74
    ldr	x19,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#940
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#948
    str	w15,	[x22]

    movz	w15,	#78
    ldr	x25,	[sp, fp]

    movz	fp,	#956
    str	w8,	[x25]

    movz	w8,	#77
    ldr	x28,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#964
    movz	w8,	#80
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, fp]

    movz	fp,	#972
    str	w15,	[x2]

    movz	w15,	#81
    ldr	x5,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#980
    str	w0,	[x5]

    movz	w15,	#84
    mov	w0,	w8
    ldr	x8,	[sp, fp]

    movz	fp,	#988
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#996
    str	w16,	[x11]

    ldr	x14,	[sp, fp]

    movz	fp,	#1004
    str	w8,	[x14]

    movz	w8,	#83
    ldr	x17,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#924
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1012
    str	w15,	[x20]

    movz	w15,	#87
    ldr	x23,	[sp, fp]

    mov	w9,	w15
    movz	fp,	#1020
    str	w8,	[x23]

    movz	w15,	#90
    movz	w8,	#86
    ldr	x26,	[sp, fp]

    mov	w16,	w15
    mov	w0,	w8
    movz	fp,	#1028
    str	w0,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#1036
    str	w9,	[x0]

    movz	w0,	#88
    ldr	x3,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1044
    str	w8,	[x3]

    movz	w8,	#89
    ldr	x6,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1052
    movz	w8,	#92
    str	w0,	[x6]

    movz	w0,	#91
    ldr	x9,	[sp, fp]

    movz	fp,	#1060
    str	w16,	[x9]

    ldr	x12,	[sp, fp]

    movz	fp,	#1068
    str	w0,	[x12]

    mov	w0,	w8
    ldr	x15,	[sp, fp]

    movz	fp,	#1076
    str	w0,	[x15]

    movz	w0,	#94
    movz	w15,	#93
    ldr	x18,	[sp, fp]

    mov	w8,	w0
    movz	fp,	#1084
    str	w15,	[x18]

    movz	w15,	#96
    ldr	x21,	[sp, fp]

    movz	fp,	#1092
    str	w8,	[x21]

    movz	w8,	#95
    ldr	x24,	[sp, fp]

    mov	w0,	w8
    movz	fp,	#1100
    movz	w8,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, fp]

    mov	w9,	w0
    movz	fp,	#1108
    str	w15,	[x27]

    mov	w0,	w8
    movz	w15,	#99
    ldr	x1,	[sp, fp]

    mov	w16,	w15
    movz	fp,	#1116
    str	w9,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#1124
    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, fp]

    str	w16,	[x7]

    ldr	w8,	[sp, #1752]

    add	w18,	w8,	#1
    str	w18,	[sp, #608]

    ldr	w12,	[sp, #1756]

    mov	w8,	w12
    str	w8,	[sp, #492]

    str	w0,	[sp, #1732]


main_254:
    ldr	w1,	[sp, #1732]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #1732]

    lsl	w0,	w2,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w8,	[x16]

    ldr	w9,	[sp, #492]

    ldr	w3,	[sp, #1732]

    add	w0,	w8,	w9
    add	w9,	w3,	#1
    str	w9,	[sp, #1160]

    ldr	w10,	[sp, #1160]

    lsl	w16,	w10,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w11,	[sp, #1160]

    add	w21,	w0,	w10
    add	w13,	w11,	#1
    str	w13,	[sp, #1164]

    ldr	w14,	[sp, #1164]

    lsl	w8,	w14,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w15,	[sp, #1164]

    add	w9,	w21,	w8
    add	w14,	w15,	#1
    str	w14,	[sp, #1220]

    ldr	w15,	[sp, #1220]

    lsl	w0,	w15,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w16,	[sp, #1220]

    add	w0,	w9,	w0
    add	w17,	w16,	#1
    str	w17,	[sp, #1168]

    ldr	w18,	[sp, #1168]

    lsl	w16,	w18,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w17,	[x8]

    ldr	w19,	[sp, #1168]

    add	w18,	w0,	w17
    add	w21,	w19,	#1
    str	w21,	[sp, #1180]

    ldr	w22,	[sp, #1180]

    lsl	w8,	w22,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w23,	[sp, #1180]

    add	w9,	w18,	w0
    add	w25,	w23,	#1
    str	w25,	[sp, #620]

    ldr	w26,	[sp, #620]

    lsl	w0,	w26,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w16,	[x15]

    ldr	w27,	[sp, #620]

    add	w0,	w9,	w16
    add	w18,	w27,	#1
    str	w18,	[sp, #1224]

    ldr	w19,	[sp, #1224]

    lsl	w15,	w19,	#2
    mov	x9,	x15
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    ldr	w20,	[sp, #1224]

    add	w16,	w0,	w9
    add	w22,	w20,	#1
    str	w22,	[sp, #1612]

    ldr	w23,	[sp, #1612]

    lsl	w8,	w23,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w24,	[sp, #1612]

    add	w8,	w8,	w16
    add	w26,	w24,	#1
    str	w26,	[sp, #1616]

    ldr	w27,	[sp, #1616]

    lsl	w0,	w27,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w28,	[sp, #1616]

    add	w0,	w8,	w0
    add	w1,	w28,	#1
    str	w1,	[sp, #1620]

    ldr	w2,	[sp, #1620]

    lsl	w17,	w2,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w3,	[sp, #1620]

    add	w18,	w0,	w17
    add	w0,	w3,	#1
    str	w0,	[sp, #624]

    ldr	w1,	[sp, #624]

    lsl	w8,	w1,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w2,	[sp, #624]

    add	w9,	w18,	w0
    add	w4,	w2,	#1
    str	w4,	[sp, #628]

    ldr	w5,	[sp, #628]

    lsl	w0,	w5,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w6,	[sp, #628]

    add	w0,	w9,	w16
    add	w8,	w6,	#1
    str	w8,	[sp, #632]

    ldr	w9,	[sp, #632]

    lsl	w17,	w9,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    add	w19,	w0,	w10
    ldr	w10,	[sp, #632]

    add	w12,	w10,	#1
    str	w12,	[sp, #636]

    ldr	w13,	[sp, #636]

    lsl	w8,	w13,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w14,	[sp, #636]

    add	w9,	w19,	w8
    add	w5,	w14,	#1
    str	w5,	[sp, #1624]

    ldr	w6,	[sp, #1624]

    lsl	w0,	w6,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w7,	[sp, #1624]

    add	w0,	w9,	w0
    add	w16,	w7,	#1
    str	w16,	[sp, #640]

    ldr	w17,	[sp, #640]

    lsl	w17,	w17,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w18,	[sp, #640]

    add	w16,	w17,	w0
    add	w20,	w18,	#1
    str	w20,	[sp, #644]

    ldr	w21,	[sp, #644]

    lsl	w8,	w21,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w22,	[sp, #644]

    add	w8,	w16,	w0
    add	w9,	w22,	#1
    str	w9,	[sp, #1628]

    ldr	w10,	[sp, #1628]

    lsl	w0,	w10,	#2
    mov	x17,	x0
    add	x17,	sp,	x17
    add	x17,	x17,	#16
    ldr	w17,	[x17]

    ldr	w11,	[sp, #1628]

    add	w0,	w8,	w17
    add	w24,	w11,	#1
    str	w24,	[sp, #648]

    ldr	w25,	[sp, #648]

    lsl	w17,	w25,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w26,	[sp, #648]

    add	w17,	w0,	w10
    add	w28,	w26,	#1
    str	w28,	[sp, #652]

    ldr	w0,	[sp, #652]

    lsl	w8,	w0,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w1,	[sp, #652]

    add	w10,	w17,	w8
    add	w3,	w1,	#1
    str	w3,	[sp, #656]

    ldr	w4,	[sp, #656]

    lsl	w0,	w4,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w5,	[sp, #656]

    add	w0,	w10,	w0
    add	w13,	w5,	#1
    str	w13,	[sp, #1632]

    ldr	w14,	[sp, #1632]

    lsl	w17,	w14,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w15,	[sp, #1632]

    add	w19,	w0,	w17
    add	w7,	w15,	#1
    str	w7,	[sp, #1184]

    ldr	w8,	[sp, #1184]

    lsl	w8,	w8,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w9,	[sp, #1184]

    add	w8,	w19,	w0
    add	w17,	w9,	#1
    str	w17,	[sp, #1636]

    ldr	w18,	[sp, #1636]

    lsl	w0,	w18,	#2
    mov	x17,	x0
    add	x17,	sp,	x17
    add	x17,	x17,	#16
    ldr	w17,	[x17]

    ldr	w19,	[sp, #1636]

    add	w0,	w17,	w8
    add	w11,	w19,	#1
    str	w11,	[sp, #1188]

    ldr	w12,	[sp, #1188]

    lsl	w17,	w12,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w13,	[sp, #1188]

    add	w19,	w0,	w10
    add	w15,	w13,	#1
    str	w15,	[sp, #1192]

    ldr	w16,	[sp, #1192]

    lsl	w8,	w16,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w17,	[sp, #1192]

    add	w8,	w19,	w8
    add	w21,	w17,	#1
    str	w21,	[sp, #1640]

    ldr	w22,	[sp, #1640]

    lsl	w0,	w22,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w23,	[sp, #1640]

    add	w0,	w8,	w0
    add	w25,	w23,	#1
    str	w25,	[sp, #1652]

    ldr	w26,	[sp, #1652]

    lsl	w17,	w26,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    ldr	w27,	[sp, #1652]

    add	w18,	w0,	w17
    add	w0,	w27,	#1
    str	w0,	[sp, #1664]

    ldr	w1,	[sp, #1664]

    lsl	w8,	w1,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w2,	[sp, #1664]

    add	w8,	w18,	w0
    add	w19,	w2,	#1
    str	w19,	[sp, #1196]

    ldr	w20,	[sp, #1196]

    lsl	w0,	w20,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w21,	[sp, #1196]

    add	w0,	w8,	w16
    add	w4,	w21,	#1
    str	w4,	[sp, #1668]

    ldr	w5,	[sp, #1668]

    lsl	w16,	w5,	#2
    mov	x9,	x16
    add	x9,	sp,	x9
    add	x9,	x9,	#16
    ldr	w9,	[x9]

    ldr	w6,	[sp, #1668]

    add	w16,	w0,	w9
    add	w23,	w6,	#1
    str	w23,	[sp, #1200]

    ldr	w24,	[sp, #1200]

    lsl	w8,	w24,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w25,	[sp, #1200]

    add	w10,	w8,	w16
    add	w8,	w25,	#1
    str	w8,	[sp, #1680]

    ldr	w9,	[sp, #1680]

    lsl	w0,	w9,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    add	w0,	w10,	w0
    ldr	w10,	[sp, #1680]

    add	w27,	w10,	#1
    str	w27,	[sp, #1204]

    ldr	w28,	[sp, #1204]

    lsl	w17,	w28,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w17,	[x10]

    add	w19,	w0,	w17
    ldr	w0,	[sp, #1204]

    add	w12,	w0,	#1
    str	w12,	[sp, #1684]

    ldr	w13,	[sp, #1684]

    lsl	w8,	w13,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w14,	[sp, #1684]

    add	w8,	w19,	w0
    add	w2,	w14,	#1
    str	w2,	[sp, #1208]

    ldr	w3,	[sp, #1208]

    lsl	w0,	w3,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w16,	[x16]

    ldr	w4,	[sp, #1208]

    add	w0,	w8,	w16
    add	w6,	w4,	#1
    str	w6,	[sp, #1212]

    ldr	w7,	[sp, #1212]

    lsl	w17,	w7,	#2
    mov	x10,	x17
    add	x10,	sp,	x10
    add	x10,	x10,	#16
    ldr	w10,	[x10]

    ldr	w8,	[sp, #1212]

    add	w19,	w0,	w10
    add	w16,	w8,	#1
    str	w16,	[sp, #1696]

    ldr	w17,	[sp, #1696]

    lsl	w8,	w17,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w18,	[sp, #1696]

    add	w8,	w19,	w8
    add	w25,	w18,	#1
    str	w25,	[sp, #1712]

    ldr	w26,	[sp, #1712]

    lsl	w0,	w26,	#2
    mov	x16,	x0
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w0,	[x16]

    ldr	w27,	[sp, #1712]

    add	w16,	w8,	w0
    mov	w10,	w16
    add	w0,	w27,	#1
    str	w10,	[sp, #492]

    mov	w4,	w0
    str	w4,	[sp, #1732]

    b	main_254

main_419:
    ldr	w5,	[sp, #1732]

    mov	w20,	w5
    str	w20,	[sp, #1708]

    ldr	w11,	[sp, #492]

    mov	w4,	w11
    str	w4,	[sp, #488]


main_421:
    ldr	w21,	[sp, #1708]

    lsl	w16,	w21,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w0,	[x8]

    ldr	w5,	[sp, #488]

    ldr	w22,	[sp, #1708]

    add	w20,	w0,	w5
    add	w13,	w22,	#1
    str	w13,	[sp, #496]

    ldr	w14,	[sp, #496]

    lsl	w8,	w14,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w15,	[sp, #496]

    add	w9,	w20,	w0
    add	w17,	w15,	#1
    str	w17,	[sp, #508]

    ldr	w18,	[sp, #508]

    lsl	w0,	w18,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w16,	[x15]

    ldr	w19,	[sp, #508]

    add	w0,	w9,	w16
    add	w21,	w19,	#1
    str	w21,	[sp, #512]

    ldr	w22,	[sp, #512]

    lsl	w16,	w22,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w10,	[x8]

    ldr	w23,	[sp, #512]

    add	w18,	w0,	w10
    add	w25,	w23,	#1
    str	w25,	[sp, #532]

    ldr	w26,	[sp, #532]

    lsl	w8,	w26,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w8,	[x0]

    ldr	w27,	[sp, #532]

    add	w10,	w18,	w8
    add	w0,	w27,	#1
    str	w0,	[sp, #1136]

    ldr	w1,	[sp, #1136]

    lsl	w0,	w1,	#2
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#16
    ldr	w0,	[x15]

    ldr	w2,	[sp, #1136]

    add	w0,	w10,	w0
    add	w4,	w2,	#1
    str	w4,	[sp, #1140]

    ldr	w5,	[sp, #1140]

    lsl	w16,	w5,	#2
    mov	x8,	x16
    add	x8,	sp,	x8
    add	x8,	x8,	#16
    ldr	w17,	[x8]

    ldr	w6,	[sp, #1140]

    add	w21,	w0,	w17
    add	w10,	w6,	#1
    str	w10,	[sp, #1216]

    ldr	w11,	[sp, #1216]

    lsl	w8,	w11,	#2
    mov	x0,	x8
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w12,	[sp, #1216]

    add	w18,	w21,	w0
    add	w0,	w12,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w23,	w0
    mov	w6,	w18
    str	w23,	[sp, #1708]

    str	w6,	[sp, #488]

    b	main_421

main_457:
    mov	w15,	w18

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
    ldr	w20,	[sp, #608]

    ldr	w18,	[sp, #1132]

    sdiv	w0,	w16,	w0
    lsl	w8,	w0,	#16
    sub	w8,	w8,	w0,	lsl #0
    sub	w0,	w16,	w8
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #1756]

    ldr	w20,	[sp, #608]

    mov	w9,	w20
    str	w9,	[sp, #1752]

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

