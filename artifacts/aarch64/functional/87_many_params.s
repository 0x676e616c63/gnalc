.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#5888
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1692]

    bl	getint
    str	w0,	[sp, #1696]

    bl	getint
    str	w0,	[sp, #1716]

    bl	getint
    str	w0,	[sp, #1720]

    bl	getint
    str	w0,	[sp, #708]

    bl	getint
    str	w0,	[sp, #736]

    bl	getint
    str	w0,	[sp, #948]

    bl	getint
    str	w0,	[sp, #984]

    bl	getint
    str	w0,	[sp, #988]

    bl	getint
    str	w0,	[sp, #1024]

    bl	getint
    str	w0,	[sp, #1028]

    bl	getint
    str	w0,	[sp, #1064]

    bl	getint
    str	w0,	[sp, #1068]

    bl	getint
    str	w0,	[sp, #1104]

    bl	getint
    str	w0,	[sp, #1108]

    bl	getint
    movz	w17,	#0
    add	x3,	sp,	#76
    add	x26,	sp,	#72
    add	x9,	sp,	#36
    str	w0,	[sp, #1708]

    add	x2,	sp,	#40
    add	x5,	sp,	#20
    add	x12,	sp,	#16
    add	x15,	sp,	#24
    add	x1,	sp,	#28
    add	x22,	sp,	#52
    movz	fp,	#3004
    str	x12,	[sp, #1640]

    add	x12,	sp,	#56
    ldr	x13,	[sp, #1640]

    ldr	w18,	[sp, #1692]

    str	w18,	[x13]

    add	x18,	sp,	#48
    add	x13,	sp,	#44
    ldr	w21,	[sp, #1696]

    str	w21,	[x5]

    ldr	w0,	[sp, #1716]

    str	w0,	[x15]

    add	x0,	sp,	#32
    ldr	w4,	[sp, #1720]

    str	w4,	[x1]

    add	x4,	sp,	#68
    ldr	w11,	[sp, #708]

    str	w11,	[x0]

    ldr	w7,	[sp, #736]

    str	w7,	[x9]

    ldr	w11,	[sp, #948]

    str	w11,	[x2]

    str	x13,	[sp, #4328]

    ldr	w7,	[sp, #984]

    ldr	x16,	[sp, #4328]

    str	w7,	[x16]

    str	x18,	[sp, #4336]

    ldr	w7,	[sp, #988]

    ldr	x20,	[sp, #4336]

    str	w7,	[x20]

    str	x22,	[sp, #4344]

    ldr	w24,	[sp, #1024]

    ldr	x23,	[sp, #4344]

    str	w24,	[x23]

    mov	w24,	w17
    str	x12,	[sp, fp]

    add	x12,	sp,	#60
    movz	fp,	#3004
    ldr	w6,	[sp, #1028]

    ldr	x13,	[sp, fp]

    movz	fp,	#2996
    str	w6,	[x13]

    add	x6,	sp,	#64
    str	x12,	[sp, fp]

    movz	fp,	#2996
    ldr	w11,	[sp, #1064]

    ldr	x7,	[sp, fp]

    movz	fp,	#2988
    str	w11,	[x7]

    str	x6,	[sp, fp]

    movz	fp,	#2988
    ldr	w18,	[sp, #1068]

    ldr	x11,	[sp, fp]

    movz	fp,	#2980
    str	w18,	[x11]

    str	x4,	[sp, fp]

    movz	fp,	#2980
    ldr	w7,	[sp, #1104]

    ldr	x12,	[sp, fp]

    movz	fp,	#2972
    str	w7,	[x12]

    str	x26,	[sp, fp]

    movz	fp,	#2972
    ldr	w8,	[sp, #1108]

    ldr	x4,	[sp, fp]

    str	w8,	[x4]

    ldr	w27,	[sp, #1708]

    str	w27,	[x3]


main_36:
    add	w7,	w24,	#1
    str	w7,	[sp, #1680]

    ldr	w11,	[sp, #1680]

    cmp	w11,	#16
    bge	main_56

main_40:
    lsl	w12,	w24,	#2
    ldr	x25,	[sp, #1640]

    ldr	w16,	[sp, #1680]

    add	x13,	x25,	x12
    mov	w23,	w16

main_43:
    ldr	w26,	[x13]

    lsl	w6,	w23,	#2
    ldr	x27,	[sp, #1640]

    add	x11,	x27,	x6
    ldr	w7,	[x11]

    cmp	w26,	w7
    bge	main_51

main_49:
    str	w7,	[x13]

    str	w26,	[x11]


main_51:
    add	w6,	w23,	#1
    cmp	w6,	#16
    bge	main_56

main_42:
    mov	w23,	w6
    b	main_43

main_56:
    ldr	w12,	[sp, #1680]

    cmp	w12,	#15
    blt	main_35

main_58:
    ldr	x25,	[sp, #1640]

    movz	fp,	#3004
    ldr	w14,	[x25]

    ldr	w5,	[x5]

    mov	w20,	w5
    ldr	w15,	[x15]

    ldr	w12,	[x1]

    mov	w1,	w15
    ldr	w21,	[x0]

    ldr	w19,	[x9]

    ldr	w8,	[x2]

    ldr	x13,	[sp, #4328]

    ldr	w4,	[x13]

    mov	w5,	w4
    mov	w13,	w14
    ldr	x22,	[sp, #4336]

    mov	w14,	w19
    ldr	w23,	[x22]

    ldr	x27,	[sp, #4344]

    ldr	w6,	[x27]

    mov	w27,	w12
    ldr	x10,	[sp, fp]

    movz	fp,	#2996
    ldr	w24,	[x10]

    mov	w10,	w21
    ldr	x9,	[sp, fp]

    movz	fp,	#2988
    ldr	w0,	[x9]

    mov	w18,	w0
    ldr	x25,	[sp, fp]

    movz	fp,	#2980
    ldr	w16,	[x25]

    mov	w0,	w16
    ldr	x2,	[sp, fp]

    movz	fp,	#2972
    ldr	w22,	[x2]

    mov	w4,	w22
    ldr	x25,	[sp, fp]

    ldr	w2,	[x25]

    ldr	w11,	[x3]

    str	w13,	[sp, #1668]

    str	w20,	[sp, #808]

    str	w1,	[sp, #456]

    mov	w1,	w8
    str	w27,	[sp, #1664]

    mov	w8,	w23
    str	w10,	[sp, #608]

    str	w14,	[sp, #1660]

    str	w1,	[sp, #1656]

    mov	w1,	w6
    str	w5,	[sp, #452]

    mov	w5,	w2
    str	w8,	[sp, #440]

    str	w1,	[sp, #436]

    mov	w1,	w24
    str	w1,	[sp, #1496]

    str	w18,	[sp, #2748]

    str	w0,	[sp, #588]

    str	w4,	[sp, #4324]

    str	w5,	[sp, #700]

    str	w11,	[sp, #704]

    ldr	w16,	[sp, #1692]

    mov	w25,	w16
    str	w25,	[sp, #4288]

    ldr	w20,	[sp, #1696]

    mov	w21,	w20
    str	w21,	[sp, #4284]

    ldr	w7,	[sp, #1716]

    mov	w4,	w7
    str	w4,	[sp, #3796]

    ldr	w11,	[sp, #1720]

    mov	w8,	w11
    str	w8,	[sp, #3800]

    ldr	w26,	[sp, #708]

    mov	w12,	w26
    str	w12,	[sp, #3804]

    ldr	w4,	[sp, #736]

    mov	w26,	w4
    str	w26,	[sp, #1784]

    ldr	w23,	[sp, #948]

    mov	w16,	w23
    str	w16,	[sp, #2756]

    ldr	w2,	[sp, #984]

    mov	w24,	w2
    str	w24,	[sp, #3848]

    ldr	w5,	[sp, #988]

    ldr	w2,	[sp, #1024]

    mov	w0,	w5
    mov	w21,	w2
    str	w21,	[sp, #2752]

    ldr	w5,	[sp, #1028]

    mov	w17,	w5
    str	w17,	[sp, #2360]

    ldr	w14,	[sp, #1064]

    mov	w21,	w14
    str	w21,	[sp, #1712]

    ldr	w2,	[sp, #1068]

    ldr	w11,	[sp, #1104]

    mov	w21,	w2
    mov	w22,	w11
    str	w22,	[sp, #2308]

    ldr	w14,	[sp, #1108]

    mov	w16,	w14
    str	w16,	[sp, #1988]

    ldr	w3,	[sp, #1708]

    mov	w6,	w3

main_75:
    ldr	w2,	[sp, #1668]

    cmp	w2,	#0
    bne	main_109

main_113:
    add	x0,	sp,	#80
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    movz	w4,	#1
    movz	w10,	#8848
    add	x13,	sp,	#80
    add	x20,	x13,	#4
    str	x13,	[sp, #1488]

    ldr	w5,	[sp, #808]

    ldr	x12,	[sp, #1488]

    str	w5,	[x12]

    str	w10,	[x20]


main_118:
    cmp	w4,	#25
    bge	main_220

main_121:
    lsl	w23,	w4,	#3
    sub	w10,	w4,	#1
    mov	x22,	x23
    add	x22,	sp,	x22
    lsl	w12,	w10,	#3
    mov	x20,	x12
    add	x22,	x22,	#80
    add	x20,	sp,	x20
    add	x2,	x22,	#4
    add	x20,	x20,	#80
    add	x3,	x20,	#4
    ldr	w0,	[x3]

    sub	w1,	w0,	#1
    add	w0,	w4,	#1
    str	w1,	[x22]

    sub	w8,	w0,	#1
    add	w13,	w0,	#1
    lsl	w5,	w0,	#3
    ldr	w1,	[x20]

    mov	x5,	x5
    sub	w7,	w1,	#2
    lsl	w11,	w8,	#3
    add	x5,	sp,	x5
    mov	x15,	x11
    str	w7,	[x2]

    add	x15,	sp,	x15
    add	x5,	x5,	#80
    add	x15,	x15,	#80
    add	x9,	x5,	#4
    add	x2,	x15,	#4
    ldr	w3,	[x2]

    sub	w4,	w3,	#1
    str	w4,	[x5]

    ldr	w22,	[x15]

    sub	w23,	w22,	#2
    lsl	w22,	w13,	#3
    str	w23,	[x9]

    mov	x23,	x22
    sub	w22,	w13,	#1
    add	x23,	sp,	x23
    lsl	w28,	w22,	#3
    add	x23,	x23,	#80
    mov	x0,	x28
    add	x0,	sp,	x0
    add	x3,	x23,	#4
    add	x0,	x0,	#80
    add	x14,	x0,	#4
    ldr	w15,	[x14]

    add	w14,	w13,	#1
    sub	w20,	w15,	#1
    add	w12,	w14,	#1
    sub	w9,	w14,	#1
    lsl	w4,	w14,	#3
    str	w20,	[x23]

    mov	x5,	x4
    ldr	w0,	[x0]

    sub	w28,	w12,	#1
    lsl	w11,	w9,	#3
    add	x5,	sp,	x5
    sub	w1,	w0,	#2
    mov	x20,	x11
    add	x20,	sp,	x20
    add	x5,	x5,	#80
    str	w1,	[x3]

    add	x20,	x20,	#80
    add	x11,	x5,	#4
    add	x3,	x20,	#4
    ldr	w0,	[x3]

    sub	w1,	w0,	#1
    str	w1,	[x5]

    lsl	w1,	w28,	#3
    ldr	w22,	[x20]

    mov	x1,	x1
    sub	w23,	w22,	#2
    add	x1,	sp,	x1
    str	w23,	[x11]

    add	x1,	x1,	#80
    lsl	w23,	w12,	#3
    mov	x23,	x23
    add	x23,	sp,	x23
    add	x21,	x1,	#4
    add	x23,	x23,	#80
    ldr	w22,	[x21]

    sub	w24,	w22,	#1
    add	x5,	x23,	#4
    str	w24,	[x23]

    add	w23,	w12,	#1
    ldr	w0,	[x1]

    sub	w1,	w0,	#2
    add	w14,	w23,	#1
    sub	w10,	w23,	#1
    lsl	w4,	w23,	#3
    str	w1,	[x5]

    mov	x5,	x4
    sub	w0,	w14,	#1
    lsl	w12,	w10,	#3
    lsl	w23,	w14,	#3
    add	x5,	sp,	x5
    mov	x21,	x12
    mov	x23,	x23
    lsl	w0,	w0,	#3
    add	x21,	sp,	x21
    add	x5,	x5,	#80
    add	x23,	sp,	x23
    mov	x0,	x0
    add	x21,	x21,	#80
    add	x0,	sp,	x0
    add	x4,	x5,	#4
    add	x23,	x23,	#80
    add	x1,	x21,	#4
    add	x0,	x0,	#80
    ldr	w2,	[x1]

    add	x26,	x0,	#4
    sub	w3,	w2,	#1
    add	w2,	w14,	#1
    str	w3,	[x5]

    sub	w12,	w2,	#1
    lsl	w5,	w2,	#3
    ldr	w21,	[x21]

    mov	x5,	x5
    sub	w22,	w21,	#2
    add	x5,	sp,	x5
    lsl	w14,	w12,	#3
    str	w22,	[x4]

    add	x5,	x5,	#80
    mov	x22,	x14
    ldr	w28,	[x26]

    add	x22,	sp,	x22
    sub	w1,	w28,	#1
    add	x7,	x5,	#4
    add	x28,	x23,	#4
    str	w1,	[x23]

    add	x22,	x22,	#80
    ldr	w0,	[x0]

    sub	w1,	w0,	#2
    add	x4,	x22,	#4
    str	w1,	[x28]

    ldr	w8,	[x4]

    add	w4,	w2,	#1
    sub	w10,	w8,	#1
    str	w10,	[x5]

    ldr	w22,	[x22]

    sub	w23,	w22,	#2
    str	w23,	[x7]

    b	main_118

main_220:
    lsl	w27,	w4,	#3
    sub	w22,	w4,	#1
    mov	x25,	x27
    add	w4,	w4,	#1
    add	x25,	sp,	x25
    lsl	w24,	w22,	#3
    mov	x2,	x24
    add	x25,	x25,	#80
    add	x2,	sp,	x2
    add	x0,	x25,	#4
    add	x2,	x2,	#80
    add	x5,	x2,	#4
    ldr	w9,	[x5]

    sub	w10,	w9,	#1
    str	w10,	[x25]

    ldr	w3,	[x2]

    sub	w5,	w3,	#2
    str	w5,	[x0]

    cmp	w4,	#32
    blt	main_220

main_235:
    add	x28,	sp,	#88
    add	x0,	sp,	#96
    add	x25,	sp,	#104
    add	x23,	sp,	#112
    movz	fp,	#428
    add	x26,	sp,	#120
    add	x18,	sp,	#136
    add	x24,	sp,	#160
    add	x27,	sp,	#168
    add	x20,	sp,	#184
    mov	x19,	x0
    str	x25,	[sp, #1440]

    add	x25,	sp,	#128
    str	x23,	[sp, fp]

    movz	fp,	#460
    add	x23,	sp,	#152
    str	x26,	[sp, #1576]

    add	x26,	sp,	#144
    str	x25,	[sp, #1544]

    add	x25,	sp,	#216
    str	x18,	[sp, #1456]

    add	x18,	sp,	#232
    str	x26,	[sp, #1568]

    add	x26,	sp,	#176
    str	x23,	[sp, #1560]

    add	x23,	sp,	#264
    str	x24,	[sp, #1464]

    add	x24,	sp,	#240
    str	x27,	[sp, #1552]

    add	x27,	sp,	#256
    str	x26,	[sp, #1448]

    add	x26,	sp,	#192
    str	x20,	[sp, #1584]

    add	x20,	sp,	#208
    str	x26,	[sp, #352]

    add	x26,	sp,	#200
    str	x26,	[sp, #400]

    add	x26,	sp,	#224
    str	x20,	[sp, #408]

    add	x20,	sp,	#288
    str	x25,	[sp, fp]

    movz	fp,	#612
    add	x25,	sp,	#248
    str	x26,	[sp, #392]

    add	x26,	sp,	#272
    str	x18,	[sp, #360]

    add	x18,	sp,	#312
    str	x24,	[sp, #368]

    add	x24,	sp,	#320
    str	x25,	[sp, #376]

    add	x25,	sp,	#296
    str	x27,	[sp, fp]

    movz	fp,	#620
    str	x23,	[sp, fp]

    movz	fp,	#628
    str	x26,	[sp, fp]

    movz	fp,	#636
    add	x26,	sp,	#280
    str	x26,	[sp, fp]

    add	x26,	sp,	#304
    movz	fp,	#644
    str	x20,	[sp, fp]

    movz	fp,	#652
    str	x25,	[sp, fp]

    add	x25,	sp,	#328
    movz	fp,	#660
    str	x26,	[sp, fp]

    movz	fp,	#668
    str	x18,	[sp, fp]

    movz	fp,	#676
    str	x24,	[sp, fp]

    movz	fp,	#684
    str	x25,	[sp, fp]

    movz	fp,	#428
    mov	x25,	x28
    str	x25,	[sp, #728]

    str	x19,	[sp, #768]

    ldr	x23,	[sp, #1440]

    str	x23,	[sp, #800]

    ldr	x20,	[sp, fp]

    movz	fp,	#836
    str	x20,	[sp, fp]

    movz	fp,	#868
    ldr	x24,	[sp, #1576]

    str	x24,	[sp, fp]

    movz	fp,	#900
    ldr	x28,	[sp, #1544]

    str	x28,	[sp, fp]

    movz	fp,	#940
    ldr	x20,	[sp, #1456]

    str	x20,	[sp, fp]

    movz	fp,	#1276
    ldr	x28,	[sp, #1568]

    str	x28,	[sp, #976]

    ldr	x28,	[sp, #1560]

    str	x28,	[sp, #1016]

    ldr	x28,	[sp, #1464]

    str	x28,	[sp, #1056]

    ldr	x28,	[sp, #1552]

    str	x28,	[sp, #1096]

    ldr	x28,	[sp, #1448]

    str	x28,	[sp, #1136]

    ldr	x20,	[sp, #1584]

    str	x20,	[sp, #1168]

    ldr	x24,	[sp, #352]

    str	x24,	[sp, #1200]

    ldr	x28,	[sp, #400]

    str	x28,	[sp, #1240]

    ldr	x20,	[sp, #408]

    str	x20,	[sp, fp]

    movz	fp,	#460
    ldr	x24,	[sp, fp]

    movz	fp,	#1308
    str	x24,	[sp, fp]

    movz	fp,	#1340
    ldr	x28,	[sp, #392]

    str	x28,	[sp, fp]

    movz	fp,	#1372
    ldr	x20,	[sp, #360]

    str	x20,	[sp, fp]

    movz	fp,	#1404
    ldr	x24,	[sp, #368]

    str	x24,	[sp, fp]

    movz	fp,	#612
    ldr	x26,	[sp, #376]

    str	x26,	[sp, #600]

    ldr	x0,	[sp, fp]

    movz	fp,	#620
    str	x0,	[sp, #592]

    ldr	x0,	[sp, fp]

    movz	fp,	#628
    mov	x20,	x0
    ldr	x0,	[sp, fp]

    movz	fp,	#636
    mov	x21,	x0
    ldr	x28,	[sp, fp]

    movz	fp,	#644
    mov	x25,	x28
    ldr	x0,	[sp, fp]

    movz	fp,	#652
    mov	x19,	x0
    ldr	x26,	[sp, fp]

    movz	fp,	#660
    mov	x22,	x26
    ldr	x0,	[sp, fp]

    movz	fp,	#1724
    str	x0,	[sp, fp]

    movz	fp,	#668
    ldr	x28,	[sp, fp]

    movz	fp,	#1732
    str	x28,	[sp, fp]

    movz	fp,	#676
    ldr	x26,	[sp, fp]

    movz	fp,	#684
    mov	x0,	x26
    ldr	x26,	[sp, fp]

    movz	fp,	#1740
    ldr	x24,	[sp, #1488]

    mov	x18,	x26
    str	x24,	[sp, fp]

    movz	fp,	#1740
    ldr	x26,	[sp, fp]

    movz	fp,	#740
    ldr	w24,	[x26]

    str	w24,	[sp, #1772]

    ldr	x26,	[sp, #1488]

    add	x23,	x26,	#4
    str	x23,	[sp, #712]

    ldr	x24,	[sp, #712]

    ldr	w26,	[x24]

    str	w26,	[sp, #720]

    ldr	w24,	[sp, #720]

    ldr	w27,	[sp, #1772]

    add	w23,	w24,	w27
    str	w23,	[sp, #1748]

    ldr	x24,	[sp, #728]

    str	x24,	[sp, fp]

    movz	fp,	#740
    ldr	x26,	[sp, fp]

    movz	fp,	#748
    ldr	w24,	[x26]

    str	w24,	[sp, #724]

    ldr	w24,	[sp, #724]

    ldr	w26,	[sp, #1748]

    add	w26,	w26,	w24
    str	w26,	[sp, #1768]

    ldr	x24,	[sp, #728]

    add	x23,	x24,	#4
    str	x23,	[sp, fp]

    movz	fp,	#748
    ldr	x24,	[sp, fp]

    movz	fp,	#812
    ldr	w26,	[x24]

    str	w26,	[sp, #756]

    ldr	w24,	[sp, #756]

    ldr	w28,	[sp, #1768]

    add	w24,	w28,	w24
    str	w24,	[sp, #2968]

    ldr	x26,	[sp, #768]

    str	x26,	[sp, #776]

    ldr	x24,	[sp, #776]

    ldr	w24,	[x24]

    str	w24,	[sp, #760]

    ldr	w26,	[sp, #760]

    ldr	w24,	[sp, #2968]

    add	w24,	w24,	w26
    str	w24,	[sp, #2856]

    ldr	x24,	[sp, #768]

    add	x24,	x24,	#4
    str	x24,	[sp, #784]

    ldr	x24,	[sp, #784]

    ldr	w24,	[x24]

    str	w24,	[sp, #792]

    ldr	w24,	[sp, #792]

    ldr	w26,	[sp, #2856]

    add	w26,	w26,	w24
    str	w26,	[sp, #2964]

    ldr	x24,	[sp, #800]

    str	x24,	[sp, fp]

    movz	fp,	#812
    ldr	x23,	[sp, fp]

    movz	fp,	#820
    ldr	w24,	[x23]

    str	w24,	[sp, #796]

    ldr	w27,	[sp, #796]

    ldr	w28,	[sp, #2964]

    add	w23,	w28,	w27
    str	w23,	[sp, #2860]

    ldr	x24,	[sp, #800]

    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#820
    ldr	x26,	[sp, fp]

    movz	fp,	#836
    ldr	w23,	[x26]

    str	w23,	[sp, #828]

    ldr	w28,	[sp, #828]

    ldr	w24,	[sp, #2860]

    add	w23,	w24,	w28
    str	w23,	[sp, #2960]

    ldr	x23,	[sp, fp]

    movz	fp,	#844
    str	x23,	[sp, fp]

    movz	fp,	#844
    ldr	x24,	[sp, fp]

    movz	fp,	#836
    ldr	w26,	[x24]

    str	w26,	[sp, #832]

    ldr	w27,	[sp, #832]

    ldr	w24,	[sp, #2960]

    add	w26,	w24,	w27
    str	w26,	[sp, #2864]

    ldr	x26,	[sp, fp]

    movz	fp,	#852
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#852
    ldr	x24,	[sp, fp]

    movz	fp,	#868
    ldr	w24,	[x24]

    str	w24,	[sp, #860]

    ldr	w26,	[sp, #860]

    ldr	w28,	[sp, #2864]

    add	w24,	w28,	w26
    str	w24,	[sp, #2956]

    ldr	x24,	[sp, fp]

    movz	fp,	#876
    str	x24,	[sp, fp]

    movz	fp,	#876
    ldr	x24,	[sp, fp]

    movz	fp,	#868
    ldr	w24,	[x24]

    str	w24,	[sp, #864]

    ldr	w24,	[sp, #864]

    ldr	w26,	[sp, #2956]

    add	w24,	w26,	w24
    str	w24,	[sp, #2868]

    ldr	x24,	[sp, fp]

    movz	fp,	#884
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#884
    ldr	x23,	[sp, fp]

    movz	fp,	#900
    ldr	w24,	[x23]

    str	w24,	[sp, #892]

    ldr	w28,	[sp, #892]

    ldr	w24,	[sp, #2868]

    add	w28,	w24,	w28
    str	w28,	[sp, #2952]

    ldr	x24,	[sp, fp]

    movz	fp,	#908
    str	x24,	[sp, fp]

    movz	fp,	#908
    ldr	x26,	[sp, fp]

    movz	fp,	#900
    ldr	w23,	[x26]

    str	w23,	[sp, #896]

    ldr	w28,	[sp, #896]

    ldr	w23,	[sp, #2952]

    add	w28,	w23,	w28
    str	w28,	[sp, #2872]

    ldr	x23,	[sp, fp]

    movz	fp,	#916
    add	x23,	x23,	#4
    str	x23,	[sp, fp]

    movz	fp,	#916
    ldr	x24,	[sp, fp]

    movz	fp,	#940
    ldr	w26,	[x24]

    str	w26,	[sp, #924]

    ldr	w27,	[sp, #924]

    ldr	w23,	[sp, #2872]

    add	w24,	w23,	w27
    str	w24,	[sp, #2948]

    ldr	x24,	[sp, fp]

    movz	fp,	#940
    str	x24,	[sp, #952]

    ldr	x26,	[sp, #952]

    ldr	w24,	[x26]

    str	w24,	[sp, #928]

    ldr	w26,	[sp, #928]

    ldr	w24,	[sp, #2948]

    add	w24,	w24,	w26
    str	w24,	[sp, #2876]

    ldr	x24,	[sp, fp]

    movz	fp,	#1260
    add	x23,	x24,	#4
    str	x23,	[sp, #960]

    ldr	x24,	[sp, #960]

    ldr	w26,	[x24]

    str	w26,	[sp, #968]

    ldr	w24,	[sp, #968]

    ldr	w26,	[sp, #2876]

    add	w26,	w26,	w24
    str	w26,	[sp, #2944]

    ldr	x24,	[sp, #976]

    str	x24,	[sp, #992]

    ldr	x24,	[sp, #992]

    ldr	w24,	[x24]

    str	w24,	[sp, #972]

    ldr	w26,	[sp, #972]

    ldr	w28,	[sp, #2944]

    add	w23,	w28,	w26
    str	w23,	[sp, #2880]

    ldr	x24,	[sp, #976]

    add	x24,	x24,	#4
    str	x24,	[sp, #1000]

    ldr	x23,	[sp, #1000]

    ldr	w24,	[x23]

    str	w24,	[sp, #1008]

    ldr	w28,	[sp, #1008]

    ldr	w24,	[sp, #2880]

    add	w23,	w24,	w28
    str	w23,	[sp, #2940]

    ldr	x23,	[sp, #1016]

    str	x23,	[sp, #1032]

    ldr	x24,	[sp, #1032]

    ldr	w23,	[x24]

    str	w23,	[sp, #1012]

    ldr	w28,	[sp, #1012]

    ldr	w24,	[sp, #2940]

    add	w26,	w24,	w28
    str	w26,	[sp, #2884]

    ldr	x23,	[sp, #1016]

    add	x26,	x23,	#4
    str	x26,	[sp, #1040]

    ldr	x24,	[sp, #1040]

    ldr	w24,	[x24]

    str	w24,	[sp, #1048]

    ldr	w26,	[sp, #1048]

    ldr	w28,	[sp, #2884]

    add	w24,	w28,	w26
    str	w24,	[sp, #2936]

    ldr	x24,	[sp, #1056]

    str	x24,	[sp, #1072]

    ldr	x23,	[sp, #1072]

    ldr	w24,	[x23]

    str	w24,	[sp, #1052]

    ldr	w24,	[sp, #1052]

    ldr	w26,	[sp, #2936]

    add	w24,	w26,	w24
    str	w24,	[sp, #2888]

    ldr	x24,	[sp, #1056]

    add	x24,	x24,	#4
    str	x24,	[sp, #1080]

    ldr	x26,	[sp, #1080]

    ldr	w23,	[x26]

    str	w23,	[sp, #1088]

    ldr	w28,	[sp, #1088]

    ldr	w24,	[sp, #2888]

    add	w28,	w24,	w28
    str	w28,	[sp, #2932]

    ldr	x26,	[sp, #1096]

    str	x26,	[sp, #1112]

    ldr	x24,	[sp, #1112]

    ldr	w26,	[x24]

    str	w26,	[sp, #1092]

    ldr	w27,	[sp, #1092]

    ldr	w23,	[sp, #2932]

    add	w28,	w23,	w27
    str	w28,	[sp, #2892]

    ldr	x26,	[sp, #1096]

    add	x24,	x26,	#4
    str	x24,	[sp, #1120]

    ldr	x24,	[sp, #1120]

    ldr	w24,	[x24]

    str	w24,	[sp, #1128]

    ldr	w27,	[sp, #1128]

    ldr	w23,	[sp, #2892]

    add	w24,	w23,	w27
    str	w24,	[sp, #2928]

    ldr	x24,	[sp, #1136]

    str	x24,	[sp, #1144]

    ldr	x23,	[sp, #1144]

    ldr	w24,	[x23]

    str	w24,	[sp, #1132]

    ldr	w28,	[sp, #1132]

    ldr	w24,	[sp, #2928]

    add	w24,	w24,	w28
    str	w24,	[sp, #2896]

    ldr	x24,	[sp, #1136]

    add	x24,	x24,	#4
    str	x24,	[sp, #1152]

    ldr	x26,	[sp, #1152]

    ldr	w23,	[x26]

    str	w23,	[sp, #1160]

    ldr	w28,	[sp, #1160]

    ldr	w26,	[sp, #2896]

    add	w26,	w26,	w28
    str	w26,	[sp, #2924]

    ldr	x23,	[sp, #1168]

    str	x23,	[sp, #1176]

    ldr	x24,	[sp, #1176]

    ldr	w26,	[x24]

    str	w26,	[sp, #1164]

    ldr	w26,	[sp, #1164]

    ldr	w28,	[sp, #2924]

    add	w23,	w28,	w26
    str	w23,	[sp, #2900]

    ldr	x26,	[sp, #1168]

    add	x26,	x26,	#4
    str	x26,	[sp, #1184]

    ldr	x24,	[sp, #1184]

    ldr	w24,	[x24]

    str	w24,	[sp, #1192]

    ldr	w27,	[sp, #1192]

    ldr	w24,	[sp, #2900]

    add	w23,	w24,	w27
    str	w23,	[sp, #2920]

    ldr	x24,	[sp, #1200]

    str	x24,	[sp, #1208]

    ldr	x24,	[sp, #1208]

    ldr	w24,	[x24]

    str	w24,	[sp, #1196]

    ldr	w27,	[sp, #1196]

    ldr	w24,	[sp, #2920]

    add	w26,	w24,	w27
    str	w26,	[sp, #2904]

    ldr	x24,	[sp, #1200]

    add	x24,	x24,	#4
    str	x24,	[sp, #1216]

    ldr	x23,	[sp, #1216]

    ldr	w24,	[x23]

    str	w24,	[sp, #1232]

    ldr	w27,	[sp, #1232]

    ldr	w28,	[sp, #2904]

    ldr	x24,	[sp, #1240]

    add	w28,	w28,	w27
    str	x24,	[sp, #1248]

    ldr	x26,	[sp, #1248]

    ldr	w23,	[x26]

    str	w23,	[sp, #1236]

    ldr	w24,	[sp, #1236]

    add	w24,	w28,	w24
    str	w24,	[sp, #2908]

    ldr	x23,	[sp, #1240]

    add	x23,	x23,	#4
    str	x23,	[sp, fp]

    movz	fp,	#1260
    ldr	x24,	[sp, fp]

    movz	fp,	#1276
    ldr	w26,	[x24]

    str	w26,	[sp, #1268]

    ldr	w26,	[sp, #1268]

    ldr	w24,	[sp, #2908]

    add	w24,	w24,	w26
    str	w24,	[sp, #2916]

    ldr	x26,	[sp, fp]

    movz	fp,	#1284
    str	x26,	[sp, fp]

    movz	fp,	#1284
    ldr	x24,	[sp, fp]

    movz	fp,	#1276
    ldr	w24,	[x24]

    str	w24,	[sp, #1272]

    ldr	w24,	[sp, #1272]

    ldr	w26,	[sp, #2916]

    add	w27,	w26,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1292
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1292
    ldr	x24,	[sp, fp]

    movz	fp,	#1308
    ldr	w24,	[x24]

    str	w24,	[sp, #1300]

    ldr	w23,	[sp, #1300]

    add	w28,	w27,	w23
    str	w28,	[sp, #2912]

    ldr	x24,	[sp, fp]

    movz	fp,	#1316
    str	x24,	[sp, fp]

    movz	fp,	#1316
    ldr	x23,	[sp, fp]

    movz	fp,	#1308
    ldr	w24,	[x23]

    str	w24,	[sp, #1304]

    ldr	w28,	[sp, #1304]

    ldr	w23,	[sp, #2912]

    ldr	x24,	[sp, fp]

    add	w28,	w23,	w28
    movz	fp,	#1324
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1324
    ldr	x26,	[sp, fp]

    movz	fp,	#1340
    ldr	w23,	[x26]

    str	w23,	[sp, #1332]

    ldr	w24,	[sp, #1332]

    ldr	x23,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1348
    str	x23,	[sp, fp]

    movz	fp,	#1348
    ldr	x24,	[sp, fp]

    movz	fp,	#1340
    ldr	w26,	[x24]

    str	w26,	[sp, #1336]

    ldr	w24,	[sp, #1336]

    ldr	x26,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1356
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1356
    ldr	x24,	[sp, fp]

    movz	fp,	#1372
    ldr	w24,	[x24]

    str	w24,	[sp, #1364]

    ldr	w24,	[sp, #1364]

    add	w27,	w28,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1380
    str	x24,	[sp, fp]

    movz	fp,	#1380
    ldr	x24,	[sp, fp]

    movz	fp,	#1372
    ldr	w24,	[x24]

    str	w24,	[sp, #1368]

    ldr	w23,	[sp, #1368]

    ldr	x24,	[sp, fp]

    add	w28,	w27,	w23
    movz	fp,	#1388
    add	x24,	x24,	#4
    add	x27,	x21,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1388
    ldr	x23,	[sp, fp]

    movz	fp,	#1404
    ldr	w24,	[x23]

    str	w24,	[sp, #1396]

    ldr	w26,	[sp, #1396]

    ldr	x24,	[sp, fp]

    add	w28,	w28,	w26
    movz	fp,	#1412
    str	x24,	[sp, fp]

    movz	fp,	#1412
    ldr	x26,	[sp, fp]

    movz	fp,	#1404
    ldr	w23,	[x26]

    str	w23,	[sp, #1400]

    ldr	w24,	[sp, #1400]

    ldr	x23,	[sp, fp]

    add	w26,	w28,	w24
    movz	fp,	#1724
    add	x24,	x23,	#4
    str	x24,	[sp, #1432]

    ldr	x23,	[sp, #1432]

    ldr	w24,	[x23]

    str	w24,	[sp, #1428]

    ldr	w24,	[sp, #1428]

    add	w23,	w26,	w24
    str	w23,	[sp, #1420]

    mov	x23,	x20
    ldr	x26,	[sp, #600]

    ldr	w28,	[x26]

    ldr	w24,	[sp, #1420]

    add	w28,	w24,	w28
    ldr	x24,	[sp, #600]

    add	x24,	x24,	#4
    ldr	w24,	[x24]

    add	w26,	w28,	w24
    ldr	x24,	[sp, #592]

    ldr	w24,	[x24]

    add	w26,	w26,	w24
    str	w26,	[sp, #1424]

    ldr	x24,	[sp, #592]

    add	x24,	x24,	#4
    ldr	w28,	[x24]

    ldr	w24,	[sp, #1424]

    ldr	w26,	[x23]

    add	w28,	w24,	w28
    add	x24,	x20,	#4
    add	w26,	w28,	w26
    ldr	w23,	[x24]

    mov	x24,	x21
    add	w28,	w26,	w23
    ldr	w24,	[x24]

    ldr	w27,	[x27]

    add	w28,	w28,	w24
    add	w23,	w28,	w27
    ldr	w27,	[x25]

    add	w20,	w23,	w27
    add	x27,	x22,	#4
    add	x23,	x25,	#4
    ldr	w25,	[x23]

    add	w26,	w20,	w25
    mov	x25,	x22
    mov	x20,	x19
    ldr	w24,	[x20]

    add	x20,	x19,	#4
    add	w21,	w26,	w24
    ldr	w23,	[x20]

    ldr	w20,	[x25]

    add	w19,	w21,	w23
    ldr	w28,	[x27]

    ldr	x26,	[sp, fp]

    add	w20,	w19,	w20
    movz	fp,	#1724
    ldr	w22,	[x26]

    ldr	x19,	[sp, fp]

    add	w24,	w20,	w28
    movz	fp,	#1732
    add	x28,	x19,	#4
    add	w26,	w24,	w22
    ldr	w19,	[x28]

    ldr	x22,	[sp, fp]

    add	w24,	w26,	w19
    movz	fp,	#1732
    ldr	w25,	[x22]

    add	x22,	x0,	#4
    ldr	x21,	[sp, fp]

    add	w19,	w24,	w25
    add	x26,	x21,	#4
    ldr	w26,	[x26]

    add	w25,	w19,	w26
    mov	x19,	x0
    ldr	w28,	[x19]

    ldr	w0,	[x22]

    add	w20,	w25,	w28
    add	w25,	w20,	w0
    mov	x0,	x18
    add	x18,	x18,	#4
    ldr	w0,	[x0]

    add	w0,	w25,	w0
    ldr	w19,	[x18]

    add	w0,	w0,	w19
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#5888
    add	sp, sp, fp
    ret


main_109:
    ldr	w2,	[sp, #1668]

    movz	w5,	#1
    mov	w26,	w0
    mov	w19,	w6
    ldr	w10,	[sp, #808]

    sub	w2,	w2,	#1
    movk	w5,	#15232,	lsl #16
    ldr	w13,	[sp, #456]

    mov	w3,	w2
    mov	w16,	w5
    add	w15,	w13,	w10
    str	w15,	[sp, #696]

    ldr	w8,	[sp, #696]

    sdiv	w11,	w8,	w5
    str	w11,	[sp, #692]

    ldr	w8,	[sp, #692]

    ldr	w5,	[sp, #696]

    str	w3,	[sp, #1668]

    msub	w8,	w8,	w16,	w5

    mov	w13,	w8
    str	w13,	[sp, #808]

    ldr	w13,	[sp, #1664]

    str	w13,	[sp, #456]

    ldr	w16,	[sp, #608]

    mov	w9,	w16
    str	w9,	[sp, #1664]

    ldr	w1,	[sp, #1660]

    mov	w17,	w1
    str	w17,	[sp, #608]

    ldr	w2,	[sp, #1656]

    str	w2,	[sp, #1660]

    ldr	w1,	[sp, #452]

    str	w1,	[sp, #1656]

    ldr	w9,	[sp, #440]

    str	w9,	[sp, #452]

    ldr	w1,	[sp, #436]

    str	w1,	[sp, #440]

    ldr	w1,	[sp, #1496]

    str	w1,	[sp, #436]

    ldr	w14,	[sp, #2748]

    mov	w25,	w14
    str	w25,	[sp, #1496]

    ldr	w2,	[sp, #588]

    mov	w15,	w2
    str	w15,	[sp, #2748]

    ldr	w7,	[sp, #4324]

    mov	w3,	w7
    str	w3,	[sp, #588]

    mov	w3,	w21
    ldr	w4,	[sp, #700]

    mov	w8,	w4
    str	w8,	[sp, #4324]

    ldr	w8,	[sp, #704]

    str	w8,	[sp, #700]

    ldr	w28,	[sp, #4288]

    mov	w12,	w28
    str	w12,	[sp, #704]

    ldr	w24,	[sp, #4284]

    mov	w1,	w24
    str	w1,	[sp, #4288]

    ldr	w7,	[sp, #3796]

    mov	w25,	w7
    str	w25,	[sp, #4284]

    ldr	w11,	[sp, #3800]

    mov	w8,	w11
    str	w8,	[sp, #3796]

    movz	w8,	#0
    ldr	w15,	[sp, #3804]

    mov	w6,	w8
    mov	w12,	w15
    str	w12,	[sp, #3800]

    ldr	w11,	[sp, #1784]

    mov	w16,	w11
    str	w16,	[sp, #3804]

    ldr	w24,	[sp, #2756]

    mov	w12,	w24
    str	w12,	[sp, #1784]

    ldr	w27,	[sp, #3848]

    mov	w25,	w27
    str	w25,	[sp, #2756]

    str	w26,	[sp, #3848]

    ldr	w9,	[sp, #2752]

    ldr	w2,	[sp, #2360]

    mov	w0,	w9
    mov	w20,	w2
    str	w20,	[sp, #2752]

    ldr	w4,	[sp, #1712]

    mov	w1,	w4
    str	w1,	[sp, #2360]

    str	w3,	[sp, #1712]

    ldr	w23,	[sp, #2308]

    ldr	w22,	[sp, #1988]

    mov	w21,	w23
    mov	w27,	w22
    str	w27,	[sp, #2308]

    str	w19,	[sp, #1988]

    b	main_75

main_35:
    ldr	w6,	[sp, #1680]

    mov	w24,	w6
    b	main_36

