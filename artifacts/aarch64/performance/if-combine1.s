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
    str	w0,	[sp, #1560]

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
    ldr	w18,	[sp, #1560]

    mov	w4,	w25
    cmp	w4,	w18
    bge	main_470

main_149:
    add	x2,	sp,	#20
    movz	fp,	#2364
    add	x23,	sp,	#24
    add	x20,	sp,	#28
    add	x18,	sp,	#32
    add	x10,	sp,	#36
    add	x15,	sp,	#40
    add	x1,	sp,	#44
    add	x25,	sp,	#48
    add	x22,	sp,	#52
    add	x3,	sp,	#56
    add	x24,	sp,	#60
    add	x7,	sp,	#64
    add	x0,	sp,	#68
    add	x16,	sp,	#72
    add	x4,	sp,	#76
    add	x8,	sp,	#80
    add	x5,	sp,	#84
    add	x27,	sp,	#88
    add	x28,	sp,	#92
    add	x13,	sp,	#96
    add	x11,	sp,	#100
    add	x21,	sp,	#104
    add	x26,	sp,	#108
    add	x17,	sp,	#112
    add	x19,	sp,	#116
    add	x14,	sp,	#120
    add	x6,	sp,	#180
    add	x9,	sp,	#184
    add	x12,	sp,	#188
    str	x2,	[sp, fp]

    add	x2,	sp,	#136
    movz	fp,	#2428
    str	x23,	[sp, fp]

    add	x23,	sp,	#164
    movz	fp,	#2420
    str	x20,	[sp, fp]

    add	x20,	sp,	#160
    movz	fp,	#2188
    str	x18,	[sp, fp]

    add	x18,	sp,	#196
    movz	fp,	#2268
    str	x10,	[sp, fp]

    add	x10,	sp,	#224
    movz	fp,	#2172
    str	x15,	[sp, fp]

    add	x15,	sp,	#192
    movz	fp,	#2228
    str	x1,	[sp, fp]

    add	x1,	sp,	#212
    movz	fp,	#2332
    str	x25,	[sp, fp]

    add	x25,	sp,	#128
    movz	fp,	#2316
    str	x22,	[sp, fp]

    add	x22,	sp,	#124
    movz	fp,	#2452
    str	x3,	[sp, fp]

    add	x3,	sp,	#176
    movz	fp,	#2204
    str	x24,	[sp, fp]

    add	x24,	sp,	#204
    movz	fp,	#2252
    str	x7,	[sp, fp]

    add	x7,	sp,	#220
    movz	fp,	#2444
    str	x0,	[sp, fp]

    add	x0,	sp,	#172
    movz	fp,	#2292
    str	x16,	[sp, fp]

    add	x16,	sp,	#232
    movz	fp,	#2244
    str	x4,	[sp, fp]

    add	x4,	sp,	#216
    movz	fp,	#2380
    str	x8,	[sp, fp]

    add	x8,	sp,	#144
    movz	fp,	#2372
    str	x5,	[sp, fp]

    add	x5,	sp,	#140
    movz	fp,	#2220
    str	x27,	[sp, fp]

    add	x27,	sp,	#208
    movz	fp,	#2340
    str	x28,	[sp, fp]

    add	x28,	sp,	#132
    movz	fp,	#2284
    str	x13,	[sp, fp]

    add	x13,	sp,	#228
    movz	fp,	#2396
    str	x11,	[sp, fp]

    add	x11,	sp,	#148
    movz	fp,	#2196
    str	x21,	[sp, fp]

    add	x21,	sp,	#200
    movz	fp,	#2436
    str	x26,	[sp, fp]

    add	x26,	sp,	#168
    movz	fp,	#2412
    str	x17,	[sp, fp]

    add	x17,	sp,	#156
    movz	fp,	#2300
    str	x19,	[sp, fp]

    add	x19,	sp,	#236
    movz	fp,	#2404
    str	x14,	[sp, fp]

    movz	fp,	#420
    add	x14,	sp,	#152
    str	x22,	[sp, #1032]

    add	x22,	sp,	#240
    str	x25,	[sp, #1040]

    add	x25,	sp,	#244
    str	x28,	[sp, #1048]

    add	x28,	sp,	#248
    str	x2,	[sp, #1056]

    add	x2,	sp,	#252
    str	x5,	[sp, #1064]

    add	x5,	sp,	#256
    str	x8,	[sp, #1072]

    add	x8,	sp,	#260
    str	x11,	[sp, #1080]

    add	x11,	sp,	#264
    str	x14,	[sp, #1088]

    add	x14,	sp,	#268
    str	x17,	[sp, #1096]

    add	x17,	sp,	#272
    str	x20,	[sp, #1104]

    add	x20,	sp,	#276
    str	x23,	[sp, #1112]

    add	x23,	sp,	#280
    str	x26,	[sp, #1120]

    add	x26,	sp,	#284
    str	x0,	[sp, #1128]

    add	x0,	sp,	#288
    str	x3,	[sp, #1136]

    add	x3,	sp,	#292
    str	x6,	[sp, #1144]

    add	x6,	sp,	#296
    str	x9,	[sp, #1152]

    add	x9,	sp,	#300
    str	x12,	[sp, #1160]

    add	x12,	sp,	#304
    str	x15,	[sp, #1168]

    add	x15,	sp,	#308
    str	x18,	[sp, #1176]

    add	x18,	sp,	#312
    str	x21,	[sp, #1184]

    add	x21,	sp,	#316
    str	x24,	[sp, #1192]

    add	x24,	sp,	#320
    str	x27,	[sp, #1200]

    add	x27,	sp,	#324
    str	x1,	[sp, #1208]

    add	x1,	sp,	#328
    str	x4,	[sp, #1216]

    add	x4,	sp,	#332
    str	x7,	[sp, #1232]

    add	x7,	sp,	#336
    str	x10,	[sp, #1240]

    add	x10,	sp,	#340
    str	x13,	[sp, #1248]

    add	x13,	sp,	#344
    str	x16,	[sp, #1224]

    add	x16,	sp,	#348
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
    str	x11,	[sp, #1256]

    add	x11,	sp,	#380
    str	x14,	[sp, #1264]

    add	x14,	sp,	#384
    str	x17,	[sp, #1272]

    add	x17,	sp,	#388
    str	x20,	[sp, #1280]

    add	x20,	sp,	#392
    str	x23,	[sp, #1288]

    add	x23,	sp,	#396
    str	x26,	[sp, #1296]

    add	x26,	sp,	#400
    str	x0,	[sp, #1304]

    add	x0,	sp,	#404
    str	x3,	[sp, #1312]

    add	x3,	sp,	#408
    str	x6,	[sp, #1320]

    add	x6,	sp,	#412
    str	x9,	[sp, #1328]

    str	x12,	[sp, #1336]

    movz	w12,	#0
    str	x15,	[sp, #1344]

    str	x18,	[sp, #1352]

    str	x21,	[sp, #1360]

    str	x24,	[sp, #1368]

    str	x27,	[sp, #1376]

    str	x1,	[sp, #1384]

    str	x4,	[sp, #1392]

    str	x7,	[sp, #1400]

    mov	w7,	w12
    str	x10,	[sp, #1408]

    str	x13,	[sp, #1416]

    str	x16,	[sp, #1424]

    str	x19,	[sp, #1432]

    str	x22,	[sp, #1440]

    str	x25,	[sp, #1448]

    str	x28,	[sp, #1456]

    str	x2,	[sp, #1464]

    str	x5,	[sp, #1472]

    movz	w5,	#0
    str	x8,	[sp, #1480]

    str	x11,	[sp, #1488]

    mov	w11,	w5
    str	x14,	[sp, #1496]

    str	x17,	[sp, #1504]

    str	x20,	[sp, #1512]

    str	x23,	[sp, #1520]

    str	x26,	[sp, #1528]

    str	x0,	[sp, #1536]

    str	x3,	[sp, #1544]

    str	x6,	[sp, #1552]

    str	w11,	[sp, #2152]

    str	w7,	[sp, #2136]


main_250:
    movz	w0,	#1
    movz	fp,	#2364
    movz	w5,	#2
    movz	w12,	#3
    mov	w6,	w0
    ldr	x3,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2428
    str	w6,	[x3]

    ldr	x24,	[sp, fp]

    movz	fp,	#2420
    str	w0,	[x24]

    movz	w0,	#4
    ldr	x21,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2188
    str	w12,	[x21]

    movz	w12,	#6
    ldr	x19,	[sp, fp]

    movz	fp,	#2268
    str	w5,	[x19]

    movz	w5,	#5
    ldr	x11,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2172
    movz	w5,	#8
    str	w0,	[x11]

    movz	w0,	#7
    ldr	x16,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#2228
    str	w12,	[x16]

    mov	w0,	w5
    movz	w12,	#9
    ldr	x2,	[sp, fp]

    movz	w5,	#11
    movz	fp,	#2332
    str	w6,	[x2]

    ldr	x26,	[sp, fp]

    movz	fp,	#2316
    str	w0,	[x26]

    movz	w0,	#10
    ldr	x23,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#2452
    str	w12,	[x23]

    mov	w0,	w5
    movz	w12,	#12
    ldr	x4,	[sp, fp]

    movz	w5,	#14
    mov	w13,	w12
    movz	fp,	#2204
    str	w6,	[x4]

    movz	w12,	#15
    ldr	x25,	[sp, fp]

    movz	fp,	#2252
    str	w0,	[x25]

    movz	w0,	#13
    ldr	x8,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#2444
    str	w13,	[x8]

    mov	w0,	w5
    mov	w13,	w12
    ldr	x1,	[sp, fp]

    movz	w12,	#18
    movz	fp,	#2292
    str	w6,	[x1]

    ldr	x17,	[sp, fp]

    movz	fp,	#2244
    str	w0,	[x17]

    movz	w0,	#16
    ldr	x5,	[sp, fp]

    movz	fp,	#2380
    str	w13,	[x5]

    mov	w5,	w0
    ldr	x9,	[sp, fp]

    movz	fp,	#2372
    str	w5,	[x9]

    movz	w5,	#17
    ldr	x6,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2220
    movz	w5,	#20
    str	w0,	[x6]

    movz	w0,	#19
    ldr	x28,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#2340
    str	w12,	[x28]

    movz	w12,	#21
    ldr	x0,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#2284
    str	w6,	[x0]

    ldr	x14,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2396
    str	w0,	[x14]

    movz	w0,	#22
    ldr	x12,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2196
    str	w13,	[x12]

    movz	w12,	#24
    ldr	x22,	[sp, fp]

    movz	fp,	#2436
    str	w5,	[x22]

    movz	w5,	#23
    ldr	x27,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#2412
    str	w0,	[x27]

    movz	w0,	#25
    ldr	x18,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#2300
    str	w12,	[x18]

    movz	w12,	#27
    ldr	x20,	[sp, fp]

    movz	fp,	#2404
    str	w5,	[x20]

    movz	w5,	#26
    ldr	x15,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#420
    str	w0,	[x15]

    movz	w0,	#28
    ldr	x22,	[sp, #1032]

    mov	w5,	w0
    str	w12,	[x22]

    movz	w12,	#30
    ldr	x25,	[sp, #1040]

    mov	w13,	w12
    str	w5,	[x25]

    movz	w12,	#33
    ldr	x28,	[sp, #1048]

    movz	w5,	#29
    mov	w0,	w5
    str	w0,	[x28]

    movz	w0,	#31
    ldr	x2,	[sp, #1056]

    mov	w5,	w0
    str	w13,	[x2]

    mov	w13,	w12
    ldr	x6,	[sp, #1064]

    movz	w12,	#36
    str	w5,	[x6]

    ldr	x9,	[sp, #1072]

    movz	w5,	#32
    mov	w0,	w5
    str	w0,	[x9]

    movz	w0,	#34
    ldr	x11,	[sp, #1080]

    mov	w5,	w0
    str	w13,	[x11]

    ldr	x15,	[sp, #1088]

    str	w5,	[x15]

    ldr	x18,	[sp, #1096]

    movz	w5,	#35
    mov	w0,	w5
    str	w0,	[x18]

    movz	w0,	#37
    ldr	x21,	[sp, #1104]

    mov	w5,	w0
    str	w12,	[x21]

    movz	w12,	#39
    ldr	x24,	[sp, #1112]

    mov	w13,	w12
    str	w5,	[x24]

    movz	w12,	#42
    ldr	x27,	[sp, #1120]

    movz	w5,	#38
    mov	w0,	w5
    movz	w5,	#41
    str	w0,	[x27]

    movz	w0,	#40
    ldr	x1,	[sp, #1128]

    mov	w6,	w0
    str	w13,	[x1]

    mov	w0,	w5
    mov	w13,	w12
    ldr	x4,	[sp, #1136]

    movz	w12,	#45
    str	w6,	[x4]

    ldr	x8,	[sp, #1144]

    str	w0,	[x8]

    movz	w0,	#43
    ldr	x10,	[sp, #1152]

    mov	w5,	w0
    str	w13,	[x10]

    ldr	x14,	[sp, #1160]

    str	w5,	[x14]

    ldr	x17,	[sp, #1168]

    movz	w5,	#44
    mov	w0,	w5
    str	w0,	[x17]

    movz	w0,	#46
    ldr	x20,	[sp, #1176]

    mov	w5,	w0
    str	w12,	[x20]

    movz	w12,	#48
    ldr	x23,	[sp, #1184]

    mov	w13,	w12
    str	w5,	[x23]

    movz	w12,	#51
    ldr	x26,	[sp, #1192]

    movz	w5,	#47
    mov	w0,	w5
    movz	w5,	#50
    str	w0,	[x26]

    ldr	x0,	[sp, #1200]

    str	w13,	[x0]

    mov	w13,	w12
    ldr	x3,	[sp, #1208]

    movz	w0,	#49
    movz	w12,	#54
    mov	w6,	w0
    mov	w0,	w5
    str	w6,	[x3]

    ldr	x7,	[sp, #1216]

    str	w0,	[x7]

    movz	w0,	#52
    ldr	x9,	[sp, #1232]

    mov	w5,	w0
    str	w13,	[x9]

    ldr	x13,	[sp, #1240]

    str	w5,	[x13]

    ldr	x16,	[sp, #1248]

    movz	w5,	#53
    mov	w0,	w5
    str	w0,	[x16]

    movz	w0,	#55
    ldr	x19,	[sp, #1224]

    mov	w5,	w0
    str	w12,	[x19]

    movz	w12,	#57
    ldr	x22,	[sp, fp]

    movz	fp,	#428
    str	w5,	[x22]

    movz	w5,	#56
    ldr	x25,	[sp, fp]

    mov	w0,	w5
    movz	fp,	#436
    movz	w5,	#59
    str	w0,	[x25]

    movz	w0,	#58
    ldr	x28,	[sp, fp]

    mov	w6,	w0
    movz	fp,	#444
    str	w12,	[x28]

    mov	w0,	w5
    movz	w12,	#60
    ldr	x2,	[sp, fp]

    mov	w13,	w12
    movz	fp,	#452
    str	w6,	[x2]

    ldr	x6,	[sp, fp]

    movz	fp,	#460
    str	w0,	[x6]

    movz	w0,	#61
    ldr	x8,	[sp, fp]

    mov	w5,	w0
    movz	fp,	#468
    str	w13,	[x8]

    movz	w0,	#64
    ldr	x9,	[sp, fp]

    str	w5,	[x9]

    ldr	x12,	[sp, #1256]

    movz	w5,	#62
    str	w5,	[x12]

    mov	w5,	w0
    ldr	x15,	[sp, #1264]

    movz	w12,	#63
    str	w12,	[x15]

    movz	w12,	#66
    ldr	x18,	[sp, #1272]

    str	w5,	[x18]

    ldr	x21,	[sp, #1280]

    movz	w5,	#65
    mov	w0,	w5
    str	w0,	[x21]

    movz	w0,	#67
    ldr	x24,	[sp, #1288]

    mov	w5,	w0
    str	w12,	[x24]

    movz	w12,	#69
    ldr	x27,	[sp, #1296]

    mov	w13,	w12
    str	w5,	[x27]

    movz	w12,	#72
    ldr	x1,	[sp, #1304]

    movz	w5,	#68
    mov	w0,	w5
    str	w0,	[x1]

    movz	w0,	#70
    ldr	x4,	[sp, #1312]

    mov	w5,	w0
    str	w13,	[x4]

    ldr	x7,	[sp, #1320]

    str	w5,	[x7]

    ldr	x10,	[sp, #1328]

    movz	w5,	#71
    mov	w0,	w5
    str	w0,	[x10]

    movz	w0,	#73
    ldr	x13,	[sp, #1336]

    mov	w5,	w0
    str	w12,	[x13]

    movz	w12,	#75
    ldr	x16,	[sp, #1344]

    str	w5,	[x16]

    ldr	x19,	[sp, #1352]

    movz	w5,	#74
    mov	w0,	w5
    str	w0,	[x19]

    movz	w0,	#76
    ldr	x22,	[sp, #1360]

    mov	w5,	w0
    str	w12,	[x22]

    movz	w12,	#78
    ldr	x25,	[sp, #1368]

    mov	w13,	w12
    str	w5,	[x25]

    movz	w12,	#81
    ldr	x28,	[sp, #1376]

    movz	w5,	#77
    mov	w0,	w5
    str	w0,	[x28]

    movz	w0,	#79
    ldr	x2,	[sp, #1384]

    str	w13,	[x2]

    mov	w13,	w12
    ldr	x5,	[sp, #1392]

    movz	w12,	#84
    str	w0,	[x5]

    ldr	x8,	[sp, #1400]

    movz	w5,	#80
    mov	w0,	w5
    str	w0,	[x8]

    movz	w0,	#82
    ldr	x11,	[sp, #1408]

    mov	w5,	w0
    str	w13,	[x11]

    ldr	x14,	[sp, #1416]

    str	w5,	[x14]

    ldr	x17,	[sp, #1424]

    movz	w5,	#83
    mov	w0,	w5
    str	w0,	[x17]

    movz	w0,	#85
    ldr	x20,	[sp, #1432]

    mov	w5,	w0
    str	w12,	[x20]

    movz	w12,	#87
    ldr	x23,	[sp, #1440]

    mov	w6,	w12
    str	w5,	[x23]

    movz	w12,	#90
    ldr	x26,	[sp, #1448]

    movz	w5,	#86
    mov	w13,	w12
    mov	w0,	w5
    movz	w5,	#89
    str	w0,	[x26]

    ldr	x0,	[sp, #1456]

    str	w6,	[x0]

    ldr	x3,	[sp, #1464]

    movz	w0,	#88
    mov	w6,	w0
    mov	w0,	w5
    str	w6,	[x3]

    movz	w5,	#92
    ldr	x6,	[sp, #1472]

    str	w0,	[x6]

    movz	w0,	#91
    ldr	x9,	[sp, #1480]

    str	w13,	[x9]

    ldr	x12,	[sp, #1488]

    str	w0,	[x12]

    movz	w12,	#93
    ldr	x15,	[sp, #1496]

    mov	w0,	w5
    str	w0,	[x15]

    movz	w0,	#94
    ldr	x18,	[sp, #1504]

    mov	w5,	w0
    str	w12,	[x18]

    movz	w12,	#96
    ldr	x21,	[sp, #1512]

    str	w5,	[x21]

    ldr	x24,	[sp, #1520]

    movz	w5,	#95
    mov	w0,	w5
    movz	w5,	#98
    str	w0,	[x24]

    movz	w0,	#97
    ldr	x27,	[sp, #1528]

    mov	w6,	w0
    str	w12,	[x27]

    mov	w0,	w5
    movz	w12,	#99
    ldr	x1,	[sp, #1536]

    mov	w13,	w12
    str	w6,	[x1]

    ldr	x4,	[sp, #1544]

    str	w0,	[x4]

    movz	w0,	#0
    ldr	x7,	[sp, #1552]

    str	w13,	[x7]

    ldr	w8,	[sp, #2136]

    add	w18,	w8,	#1
    str	w18,	[sp, #416]

    ldr	w12,	[sp, #2152]

    mov	w8,	w12
    str	w8,	[sp, #1888]

    str	w0,	[sp, #2132]


main_254:
    ldr	w1,	[sp, #2132]

    cmp	w1,	#80
    bge	main_419

main_258:
    ldr	w2,	[sp, #2132]

    lsl	w0,	w2,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w5,	[x13]

    ldr	w9,	[sp, #1888]

    ldr	w3,	[sp, #2132]

    add	w2,	w5,	w9
    add	w0,	w3,	#1
    str	w0,	[sp, #556]

    ldr	w1,	[sp, #556]

    lsl	w13,	w1,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    add	w18,	w2,	w7
    ldr	w2,	[sp, #556]

    add	w4,	w2,	#1
    str	w4,	[sp, #1984]

    ldr	w5,	[sp, #1984]

    lsl	w5,	w5,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w6,	[sp, #1984]

    add	w7,	w18,	w5
    add	w9,	w6,	#1
    str	w9,	[sp, #1996]

    ldr	w10,	[sp, #1996]

    lsl	w0,	w10,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    ldr	w11,	[sp, #1996]

    add	w0,	w7,	w0
    add	w13,	w11,	#1
    str	w13,	[sp, #2000]

    ldr	w14,	[sp, #2000]

    lsl	w13,	w14,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w14,	[x5]

    ldr	w15,	[sp, #2000]

    add	w16,	w0,	w14
    add	w17,	w15,	#1
    str	w17,	[sp, #2012]

    ldr	w18,	[sp, #2012]

    lsl	w5,	w18,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w19,	[sp, #2012]

    add	w7,	w16,	w0
    add	w14,	w19,	#1
    str	w14,	[sp, #1932]

    ldr	w15,	[sp, #1932]

    lsl	w0,	w15,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w14,	[x13]

    ldr	w16,	[sp, #1932]

    add	w0,	w7,	w14
    add	w21,	w16,	#1
    str	w21,	[sp, #2024]

    ldr	w22,	[sp, #2024]

    lsl	w13,	w22,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w23,	[sp, #2024]

    add	w15,	w0,	w7
    add	w25,	w23,	#1
    str	w25,	[sp, #2028]

    ldr	w26,	[sp, #2028]

    lsl	w5,	w26,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w27,	[sp, #2028]

    add	w7,	w5,	w15
    add	w0,	w27,	#1
    str	w0,	[sp, #608]

    ldr	w1,	[sp, #608]

    lsl	w0,	w1,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    ldr	w2,	[sp, #608]

    add	w0,	w7,	w0
    add	w4,	w2,	#1
    str	w4,	[sp, #612]

    ldr	w5,	[sp, #612]

    lsl	w14,	w5,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w6,	[sp, #612]

    add	w15,	w0,	w14
    add	w8,	w6,	#1
    str	w8,	[sp, #616]

    ldr	w9,	[sp, #616]

    lsl	w5,	w9,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w10,	[sp, #616]

    add	w5,	w15,	w0
    add	w12,	w10,	#1
    str	w12,	[sp, #620]

    ldr	w13,	[sp, #620]

    lsl	w0,	w13,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w14,	[sp, #620]

    add	w0,	w5,	w13
    add	w16,	w14,	#1
    str	w16,	[sp, #624]

    ldr	w17,	[sp, #624]

    lsl	w14,	w17,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w7,	[x7]

    ldr	w18,	[sp, #624]

    add	w13,	w0,	w7
    add	w18,	w18,	#1
    str	w18,	[sp, #1936]

    ldr	w19,	[sp, #1936]

    lsl	w5,	w19,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w20,	[sp, #1936]

    add	w5,	w13,	w5
    add	w20,	w20,	#1
    str	w20,	[sp, #628]

    ldr	w21,	[sp, #628]

    lsl	w0,	w21,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w22,	[sp, #628]

    add	w0,	w5,	w0
    add	w22,	w22,	#1
    str	w22,	[sp, #1940]

    ldr	w23,	[sp, #1940]

    lsl	w14,	w23,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w24,	[sp, #1940]

    add	w13,	w14,	w0
    add	w26,	w24,	#1
    str	w26,	[sp, #2040]

    ldr	w27,	[sp, #2040]

    lsl	w5,	w27,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w28,	[sp, #2040]

    add	w5,	w13,	w0
    add	w24,	w28,	#1
    str	w24,	[sp, #632]

    ldr	w25,	[sp, #632]

    lsl	w0,	w25,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w26,	[sp, #632]

    add	w0,	w5,	w13
    add	w1,	w26,	#1
    str	w1,	[sp, #2044]

    ldr	w2,	[sp, #2044]

    lsl	w13,	w2,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w3,	[sp, #2044]

    add	w15,	w0,	w6
    add	w5,	w3,	#1
    str	w5,	[sp, #2048]

    ldr	w6,	[sp, #2048]

    lsl	w5,	w6,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w7,	[sp, #2048]

    add	w8,	w15,	w5
    add	w28,	w7,	#1
    str	w28,	[sp, #636]

    ldr	w0,	[sp, #636]

    lsl	w0,	w0,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w1,	[sp, #636]

    add	w0,	w8,	w0
    add	w3,	w1,	#1
    str	w3,	[sp, #640]

    ldr	w4,	[sp, #640]

    lsl	w14,	w4,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w5,	[sp, #640]

    add	w16,	w0,	w14
    add	w9,	w5,	#1
    str	w9,	[sp, #2052]

    ldr	w10,	[sp, #2052]

    lsl	w5,	w10,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w11,	[sp, #2052]

    add	w5,	w16,	w0
    add	w7,	w11,	#1
    str	w7,	[sp, #644]

    ldr	w8,	[sp, #644]

    lsl	w0,	w8,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w9,	[sp, #644]

    add	w0,	w13,	w5
    add	w13,	w9,	#1
    str	w13,	[sp, #2056]

    ldr	w14,	[sp, #2056]

    lsl	w13,	w14,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w15,	[sp, #2056]

    add	w13,	w0,	w6
    add	w17,	w15,	#1
    str	w17,	[sp, #2060]

    ldr	w18,	[sp, #2060]

    lsl	w5,	w18,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w19,	[sp, #2060]

    add	w5,	w13,	w5
    add	w11,	w19,	#1
    str	w11,	[sp, #1900]

    ldr	w12,	[sp, #1900]

    lsl	w0,	w12,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w13,	[sp, #1900]

    add	w0,	w5,	w0
    add	w15,	w13,	#1
    str	w15,	[sp, #1904]

    ldr	w16,	[sp, #1904]

    lsl	w14,	w16,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w17,	[sp, #1904]

    add	w13,	w0,	w14
    add	w19,	w17,	#1
    str	w19,	[sp, #1908]

    ldr	w20,	[sp, #1908]

    lsl	w5,	w20,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w21,	[sp, #1908]

    add	w5,	w13,	w0
    add	w21,	w21,	#1
    str	w21,	[sp, #2064]

    ldr	w22,	[sp, #2064]

    lsl	w0,	w22,	#2
    mov	x14,	x0
    add	x14,	sp,	x14
    add	x14,	x14,	#16
    ldr	w14,	[x14]

    ldr	w23,	[sp, #2064]

    add	w0,	w5,	w14
    add	w25,	w23,	#1
    str	w25,	[sp, #2076]

    ldr	w26,	[sp, #2076]

    lsl	w13,	w26,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w27,	[sp, #2076]

    add	w15,	w0,	w6
    add	w0,	w27,	#1
    str	w0,	[sp, #2088]

    ldr	w1,	[sp, #2088]

    lsl	w5,	w1,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w2,	[sp, #2088]

    add	w7,	w5,	w15
    add	w23,	w2,	#1
    str	w23,	[sp, #1912]

    ldr	w24,	[sp, #1912]

    lsl	w0,	w24,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w25,	[sp, #1912]

    add	w0,	w7,	w0
    add	w4,	w25,	#1
    str	w4,	[sp, #2092]

    ldr	w5,	[sp, #2092]

    lsl	w14,	w5,	#2
    mov	x7,	x14
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w14,	[x7]

    ldr	w6,	[sp, #2092]

    add	w13,	w0,	w14
    add	w27,	w6,	#1
    str	w27,	[sp, #1916]

    ldr	w28,	[sp, #1916]

    lsl	w5,	w28,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    add	w8,	w13,	w0
    ldr	w0,	[sp, #1916]

    add	w2,	w0,	#1
    str	w2,	[sp, #1920]

    ldr	w3,	[sp, #1920]

    lsl	w0,	w3,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w13,	[x13]

    ldr	w4,	[sp, #1920]

    add	w0,	w8,	w13
    add	w8,	w4,	#1
    str	w8,	[sp, #2096]

    ldr	w9,	[sp, #2096]

    lsl	w13,	w9,	#2
    mov	x6,	x13
    add	x6,	sp,	x6
    add	x6,	x6,	#16
    ldr	w6,	[x6]

    ldr	w10,	[sp, #2096]

    add	w16,	w0,	w6
    add	w12,	w10,	#1
    str	w12,	[sp, #2116]

    ldr	w13,	[sp, #2116]

    lsl	w5,	w13,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w14,	[sp, #2116]

    add	w5,	w16,	w5
    add	w16,	w14,	#1
    str	w16,	[sp, #2120]

    ldr	w17,	[sp, #2120]

    lsl	w0,	w17,	#2
    mov	x13,	x0
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w0,	[x13]

    ldr	w18,	[sp, #2120]

    add	w13,	w5,	w0
    mov	w10,	w13
    add	w0,	w18,	#1
    str	w10,	[sp, #1888]

    mov	w4,	w0
    str	w4,	[sp, #2132]

    b	main_254

main_419:
    ldr	w5,	[sp, #2132]

    mov	w20,	w5
    str	w20,	[sp, #2124]

    ldr	w11,	[sp, #1888]

    mov	w4,	w11
    str	w4,	[sp, #1884]


main_421:
    ldr	w21,	[sp, #2124]

    lsl	w13,	w21,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w0,	[x5]

    ldr	w5,	[sp, #1884]

    ldr	w22,	[sp, #2124]

    add	w16,	w0,	w5
    add	w6,	w22,	#1
    str	w6,	[sp, #1924]

    ldr	w7,	[sp, #1924]

    lsl	w5,	w7,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w8,	[sp, #1924]

    add	w6,	w16,	w0
    add	w13,	w8,	#1
    str	w13,	[sp, #500]

    ldr	w14,	[sp, #500]

    lsl	w0,	w14,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w13,	[x12]

    ldr	w15,	[sp, #500]

    add	w0,	w6,	w13
    add	w17,	w15,	#1
    str	w17,	[sp, #512]

    ldr	w18,	[sp, #512]

    lsl	w13,	w18,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w7,	[x5]

    ldr	w19,	[sp, #512]

    add	w17,	w0,	w7
    add	w10,	w19,	#1
    str	w10,	[sp, #1928]

    ldr	w11,	[sp, #1928]

    lsl	w5,	w11,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w5,	[x0]

    ldr	w12,	[sp, #1928]

    add	w7,	w17,	w5
    add	w21,	w12,	#1
    str	w21,	[sp, #516]

    ldr	w22,	[sp, #516]

    lsl	w0,	w22,	#2
    mov	x12,	x0
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    ldr	w0,	[x12]

    ldr	w23,	[sp, #516]

    add	w0,	w7,	w0
    add	w25,	w23,	#1
    str	w25,	[sp, #544]

    ldr	w26,	[sp, #544]

    lsl	w13,	w26,	#2
    mov	x5,	x13
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w14,	[x5]

    ldr	w27,	[sp, #544]

    add	w15,	w0,	w14
    add	w25,	w27,	#1
    str	w25,	[sp, #2128]

    ldr	w26,	[sp, #2128]

    lsl	w5,	w26,	#2
    mov	x0,	x5
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    ldr	w27,	[sp, #2128]

    add	w14,	w15,	w0
    add	w0,	w27,	#1
    cmp	w0,	#96
    bge	main_457

main_420:
    mov	w23,	w0
    mov	w6,	w14
    str	w23,	[sp, #2124]

    str	w6,	[sp, #1884]

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
    ldr	w20,	[sp, #416]

    ldr	w18,	[sp, #1560]

    sdiv	w0,	w13,	w0
    lsl	w5,	w0,	#16
    sub	w5,	w5,	w0,	lsl #0
    sub	w0,	w13,	w5
    cmp	w20,	w18
    bge	main_472

main_249:
    mov	w13,	w0
    str	w13,	[sp, #2152]

    ldr	w20,	[sp, #416]

    mov	w9,	w20
    str	w9,	[sp, #2136]

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

