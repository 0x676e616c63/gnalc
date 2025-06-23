.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#6032
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1512]

    bl	getint
    str	w0,	[sp, #1516]

    bl	getint
    str	w0,	[sp, #1524]

    bl	getint
    str	w0,	[sp, #1528]

    bl	getint
    str	w0,	[sp, #700]

    bl	getint
    str	w0,	[sp, #728]

    bl	getint
    str	w0,	[sp, #928]

    bl	getint
    str	w0,	[sp, #964]

    bl	getint
    str	w0,	[sp, #968]

    bl	getint
    str	w0,	[sp, #1004]

    bl	getint
    str	w0,	[sp, #1008]

    bl	getint
    str	w0,	[sp, #1044]

    bl	getint
    str	w0,	[sp, #1048]

    bl	getint
    str	w0,	[sp, #1084]

    bl	getint
    str	w0,	[sp, #1088]

    bl	getint
    add	x4,	sp,	#304
    add	x20,	sp,	#288
    add	x18,	sp,	#272
    add	x17,	sp,	#296
    add	x10,	sp,	#276
    add	x12,	sp,	#280
    add	x15,	sp,	#284
    str	w0,	[sp, #1520]

    movz	fp,	#1868
    add	x14,	sp,	#324
    add	x0,	sp,	#292
    ldr	w5,	[sp, #1512]

    str	w5,	[x18]

    ldr	w9,	[sp, #1516]

    str	w9,	[x10]

    ldr	w21,	[sp, #1524]

    str	w21,	[x12]

    add	x21,	sp,	#332
    ldr	w27,	[sp, #1528]

    str	w27,	[x15]

    add	x27,	sp,	#300
    ldr	w5,	[sp, #700]

    str	w5,	[x20]

    ldr	w7,	[sp, #728]

    str	w7,	[x0]

    ldr	w3,	[sp, #928]

    str	w3,	[x17]

    ldr	w7,	[sp, #964]

    str	w7,	[x27]

    add	x7,	sp,	#308
    str	x4,	[sp, #4304]

    ldr	w2,	[sp, #968]

    ldr	x13,	[sp, #4304]

    str	w2,	[x13]

    add	x2,	sp,	#320
    str	x7,	[sp, fp]

    movz	fp,	#1868
    ldr	w6,	[sp, #1004]

    ldr	x5,	[sp, fp]

    str	w6,	[x5]

    add	x5,	sp,	#312
    str	x5,	[sp, #2984]

    ldr	w1,	[sp, #1008]

    ldr	x13,	[sp, #2984]

    str	w1,	[x13]

    add	x1,	sp,	#316
    str	x1,	[sp, #2976]

    ldr	w4,	[sp, #1044]

    ldr	x7,	[sp, #2976]

    str	w4,	[x7]

    add	x7,	sp,	#328
    str	x2,	[sp, #2968]

    ldr	w9,	[sp, #1048]

    ldr	x1,	[sp, #2968]

    str	w9,	[x1]

    str	x14,	[sp, #2960]

    ldr	w8,	[sp, #1084]

    ldr	x2,	[sp, #2960]

    str	w8,	[x2]

    str	x7,	[sp, #2952]

    ldr	w8,	[sp, #1088]

    ldr	x7,	[sp, #2952]

    str	w8,	[x7]

    ldr	w7,	[sp, #1520]

    str	w7,	[x21]

    movz	w7,	#0
    mov	w1,	w7

main_36:
    add	w2,	w1,	#1
    cmp	w2,	#16
    bge	main_56

main_40:
    lsl	w4,	w1,	#2
    mov	w13,	w2
    add	x5,	x18,	x4

main_43:
    ldr	w16,	[x5]

    lsl	w6,	w13,	#2
    add	x1,	x18,	x6
    ldr	w4,	[x1]

    cmp	w16,	w4
    bge	main_51

main_49:
    str	w4,	[x5]

    str	w16,	[x1]


main_51:
    add	w3,	w13,	#1
    cmp	w3,	#16
    bge	main_56

main_42:
    mov	w13,	w3
    b	main_43

main_56:
    cmp	w2,	#15
    blt	main_35

main_58:
    ldr	w5,	[x18]

    movz	fp,	#1868
    str	w5,	[sp, #532]

    ldr	w18,	[x10]

    mov	w2,	w18
    ldr	w16,	[x12]

    ldr	w1,	[x15]

    mov	w19,	w1
    ldr	w28,	[x20]

    ldr	w26,	[x0]

    mov	w20,	w26
    ldr	w6,	[x17]

    ldr	w3,	[x27]

    ldr	x7,	[sp, #4304]

    ldr	w13,	[x7]

    ldr	x15,	[sp, fp]

    ldr	w27,	[x15]

    ldr	x4,	[sp, #2984]

    ldr	w11,	[x4]

    ldr	x5,	[sp, #2976]

    ldr	w8,	[x5]

    ldr	x25,	[sp, #2968]

    ldr	w24,	[x25]

    mov	w26,	w24
    mov	w25,	w3
    ldr	x9,	[sp, #2960]

    mov	w3,	w8
    ldr	w7,	[x9]

    ldr	x4,	[sp, #2952]

    ldr	w9,	[x4]

    mov	w14,	w9
    mov	w4,	w28
    ldr	w17,	[x21]

    mov	w18,	w17
    mov	w21,	w16
    ldr	w10,	[sp, #532]

    mov	w15,	w10
    str	w15,	[sp, #1508]

    str	w2,	[sp, #796]

    str	w21,	[sp, #2868]

    str	w19,	[sp, #1480]

    str	w4,	[sp, #568]

    mov	w4,	w6
    str	w20,	[sp, #564]

    mov	w6,	w13
    str	w4,	[sp, #560]

    mov	w4,	w11
    str	w25,	[sp, #548]

    mov	w11,	w7
    str	w6,	[sp, #536]

    str	w27,	[sp, #1772]

    str	w4,	[sp, #1448]

    str	w3,	[sp, #1444]

    str	w26,	[sp, #1440]

    str	w11,	[sp, #3784]

    str	w14,	[sp, #692]

    str	w18,	[sp, #696]

    ldr	w25,	[sp, #1512]

    mov	w26,	w25
    str	w26,	[sp, #1460]

    ldr	w16,	[sp, #1516]

    mov	w17,	w16
    str	w17,	[sp, #4300]

    ldr	w12,	[sp, #1524]

    str	w12,	[sp, #4296]

    ldr	w7,	[sp, #1528]

    str	w7,	[sp, #4292]

    ldr	w1,	[sp, #700]

    mov	w12,	w1
    str	w12,	[sp, #4280]

    ldr	w19,	[sp, #728]

    mov	w4,	w19
    str	w4,	[sp, #3716]

    ldr	w26,	[sp, #928]

    mov	w16,	w26
    str	w16,	[sp, #3664]

    ldr	w7,	[sp, #964]

    mov	w0,	w7
    str	w0,	[sp, #3712]

    ldr	w7,	[sp, #968]

    mov	w20,	w7
    str	w20,	[sp, #3668]

    ldr	w7,	[sp, #1004]

    mov	w21,	w7
    str	w21,	[sp, #1672]

    ldr	w18,	[sp, #1008]

    mov	w22,	w18
    str	w22,	[sp, #1864]

    ldr	w19,	[sp, #1044]

    mov	w0,	w19
    str	w0,	[sp, #1704]

    ldr	w7,	[sp, #1048]

    ldr	w23,	[sp, #1084]

    mov	w19,	w7
    mov	w16,	w23
    str	w16,	[sp, #3780]

    ldr	w20,	[sp, #1088]

    ldr	w25,	[sp, #1520]

    mov	w13,	w20
    mov	w16,	w25
    str	w16,	[sp, #3788]


main_75:
    ldr	w25,	[sp, #1508]

    cmp	w25,	#0
    bne	main_109

main_113:
    add	x0,	sp,	#16
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    movz	w10,	#8848
    movz	w6,	#1
    add	x19,	sp,	#16
    mov	w8,	w6
    add	x20,	x19,	#4
    str	x19,	[sp, #1432]

    ldr	w5,	[sp, #796]

    ldr	x16,	[sp, #1432]

    str	w5,	[x16]

    str	w10,	[x20]


main_118:
    cmp	w8,	#25
    bge	main_218

main_121:
    lsl	w22,	w8,	#3
    sub	w11,	w8,	#1
    mov	x23,	x22
    add	x23,	sp,	x23
    lsl	w11,	w11,	#3
    mov	x20,	x11
    add	x23,	x23,	#16
    add	x20,	sp,	x20
    mov	x22,	x23
    add	x20,	x20,	#16
    add	x2,	x23,	#4
    add	x3,	x20,	#4
    ldr	w0,	[x3]

    sub	w1,	w0,	#1
    add	w0,	w8,	#1
    str	w1,	[x22]

    sub	w8,	w0,	#1
    add	w13,	w0,	#1
    ldr	w1,	[x20]

    sub	w5,	w1,	#2
    lsl	w11,	w8,	#3
    mov	x15,	x11
    str	w5,	[x2]

    add	x15,	sp,	x15
    lsl	w5,	w0,	#3
    mov	x5,	x5
    add	x15,	x15,	#16
    add	x5,	sp,	x5
    add	x2,	x15,	#4
    add	x5,	x5,	#16
    ldr	w3,	[x2]

    add	x9,	x5,	#4
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
    add	x23,	x23,	#16
    mov	x0,	x28
    add	x0,	sp,	x0
    add	x3,	x23,	#4
    add	x0,	x0,	#16
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
    add	x5,	x5,	#16
    str	w1,	[x3]

    add	x20,	x20,	#16
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

    add	x1,	x1,	#16
    lsl	w23,	w12,	#3
    mov	x23,	x23
    add	x23,	sp,	x23
    add	x21,	x1,	#4
    add	x23,	x23,	#16
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
    add	x5,	x5,	#16
    add	x23,	sp,	x23
    mov	x0,	x0
    add	x21,	x21,	#16
    add	x0,	sp,	x0
    add	x4,	x5,	#4
    add	x23,	x23,	#16
    add	x1,	x21,	#4
    add	x0,	x0,	#16
    ldr	w2,	[x1]

    add	x26,	x0,	#4
    sub	w3,	w2,	#1
    add	w2,	w14,	#1
    str	w3,	[x5]

    add	w6,	w2,	#1
    sub	w12,	w2,	#1
    lsl	w5,	w2,	#3
    ldr	w21,	[x21]

    mov	x5,	x5
    sub	w22,	w21,	#2
    lsl	w14,	w12,	#3
    add	x5,	sp,	x5
    str	w22,	[x4]

    add	x5,	x5,	#16
    mov	x22,	x14
    ldr	w28,	[x26]

    add	x22,	sp,	x22
    sub	w1,	w28,	#1
    add	x7,	x5,	#4
    add	x28,	x23,	#4
    add	x22,	x22,	#16
    str	w1,	[x23]

    ldr	w0,	[x0]

    add	x4,	x22,	#4
    sub	w1,	w0,	#2
    str	w1,	[x28]

    ldr	w8,	[x4]

    sub	w10,	w8,	#1
    mov	w8,	w6
    str	w10,	[x5]

    ldr	w22,	[x22]

    sub	w23,	w22,	#2
    str	w23,	[x7]

    b	main_118

main_218:
    mov	w6,	w8

main_220:
    lsl	w26,	w6,	#3
    sub	w22,	w6,	#1
    mov	x26,	x26
    add	w6,	w6,	#1
    add	x26,	sp,	x26
    lsl	w23,	w22,	#3
    mov	x3,	x23
    add	x26,	x26,	#16
    add	x3,	sp,	x3
    mov	x25,	x26
    add	x3,	x3,	#16
    add	x28,	x26,	#4
    add	x4,	x3,	#4
    ldr	w9,	[x4]

    sub	w10,	w9,	#1
    str	w10,	[x25]

    ldr	w2,	[x3]

    sub	w3,	w2,	#2
    str	w3,	[x28]

    cmp	w6,	#32
    blt	main_220

main_235:
    add	x28,	sp,	#24
    add	x22,	sp,	#32
    movz	fp,	#412
    add	x18,	sp,	#40
    add	x0,	sp,	#48
    add	x24,	sp,	#56
    add	x25,	sp,	#72
    add	x20,	sp,	#80
    add	x26,	sp,	#88
    add	x27,	sp,	#112
    add	x21,	sp,	#120
    str	x22,	[sp, fp]

    mov	x23,	x18
    movz	fp,	#460
    str	x0,	[sp, #392]

    add	x0,	sp,	#64
    str	x24,	[sp, #400]

    add	x24,	sp,	#176
    str	x0,	[sp, fp]

    add	x0,	sp,	#128
    movz	fp,	#1484
    str	x25,	[sp, fp]

    add	x25,	sp,	#104
    movz	fp,	#476
    str	x20,	[sp, fp]

    add	x20,	sp,	#144
    movz	fp,	#468
    str	x26,	[sp, fp]

    movz	fp,	#484
    add	x26,	sp,	#96
    str	x26,	[sp, #1408]

    add	x26,	sp,	#136
    str	x25,	[sp, fp]

    add	x25,	sp,	#152
    movz	fp,	#1492
    str	x27,	[sp, fp]

    add	x27,	sp,	#192
    movz	fp,	#1500
    str	x21,	[sp, fp]

    add	x21,	sp,	#200
    movz	fp,	#500
    str	x0,	[sp, #448]

    add	x0,	sp,	#168
    str	x26,	[sp, fp]

    add	x26,	sp,	#160
    movz	fp,	#508
    str	x20,	[sp, fp]

    add	x20,	sp,	#224
    movz	fp,	#516
    str	x25,	[sp, fp]

    add	x25,	sp,	#184
    movz	fp,	#524
    str	x26,	[sp, fp]

    add	x26,	sp,	#216
    movz	fp,	#604
    str	x0,	[sp, #424]

    add	x0,	sp,	#208
    str	x24,	[sp, #432]

    add	x24,	sp,	#256
    str	x25,	[sp, #440]

    add	x25,	sp,	#232
    str	x27,	[sp, fp]

    movz	fp,	#612
    str	x21,	[sp, fp]

    movz	fp,	#620
    str	x0,	[sp, fp]

    add	x0,	sp,	#248
    movz	fp,	#628
    str	x26,	[sp, fp]

    add	x26,	sp,	#240
    movz	fp,	#636
    str	x20,	[sp, fp]

    movz	fp,	#644
    str	x25,	[sp, fp]

    add	x25,	sp,	#264
    movz	fp,	#652
    str	x26,	[sp, fp]

    movz	fp,	#660
    str	x0,	[sp, fp]

    mov	x0,	x28
    movz	fp,	#668
    str	x24,	[sp, fp]

    movz	fp,	#676
    str	x25,	[sp, fp]

    movz	fp,	#412
    str	x0,	[sp, #720]

    ldr	x0,	[sp, fp]

    movz	fp,	#732
    str	x0,	[sp, fp]

    movz	fp,	#788
    str	x23,	[sp, fp]

    movz	fp,	#460
    ldr	x20,	[sp, #392]

    str	x20,	[sp, #824]

    ldr	x24,	[sp, #400]

    str	x24,	[sp, #856]

    ldr	x28,	[sp, fp]

    movz	fp,	#1484
    str	x28,	[sp, #888]

    ldr	x20,	[sp, fp]

    movz	fp,	#476
    str	x20,	[sp, #920]

    ldr	x28,	[sp, fp]

    movz	fp,	#956
    str	x28,	[sp, fp]

    movz	fp,	#468
    ldr	x28,	[sp, fp]

    movz	fp,	#996
    str	x28,	[sp, fp]

    movz	fp,	#1036
    ldr	x28,	[sp, #1408]

    str	x28,	[sp, fp]

    movz	fp,	#484
    ldr	x28,	[sp, fp]

    movz	fp,	#1076
    str	x28,	[sp, fp]

    movz	fp,	#1492
    ldr	x28,	[sp, fp]

    movz	fp,	#1116
    str	x28,	[sp, fp]

    movz	fp,	#1500
    ldr	x20,	[sp, fp]

    movz	fp,	#1148
    str	x20,	[sp, fp]

    movz	fp,	#1180
    ldr	x24,	[sp, #448]

    str	x24,	[sp, fp]

    movz	fp,	#500
    ldr	x28,	[sp, fp]

    movz	fp,	#1212
    str	x28,	[sp, fp]

    movz	fp,	#508
    ldr	x20,	[sp, fp]

    movz	fp,	#1244
    str	x20,	[sp, fp]

    movz	fp,	#516
    ldr	x24,	[sp, fp]

    movz	fp,	#1276
    str	x24,	[sp, fp]

    movz	fp,	#524
    ldr	x28,	[sp, fp]

    movz	fp,	#1308
    str	x28,	[sp, fp]

    movz	fp,	#1340
    ldr	x20,	[sp, #424]

    str	x20,	[sp, fp]

    movz	fp,	#1372
    ldr	x24,	[sp, #432]

    str	x24,	[sp, fp]

    movz	fp,	#1756
    ldr	x0,	[sp, #440]

    str	x0,	[sp, fp]

    movz	fp,	#604
    ldr	x25,	[sp, fp]

    movz	fp,	#612
    str	x25,	[sp, #2872]

    ldr	x0,	[sp, fp]

    movz	fp,	#620
    mov	x20,	x0
    ldr	x0,	[sp, fp]

    movz	fp,	#628
    mov	x21,	x0
    ldr	x28,	[sp, fp]

    movz	fp,	#636
    mov	x25,	x28
    ldr	x0,	[sp, fp]

    movz	fp,	#644
    mov	x19,	x0
    ldr	x26,	[sp, fp]

    movz	fp,	#652
    mov	x22,	x26
    ldr	x28,	[sp, fp]

    movz	fp,	#1532
    str	x28,	[sp, fp]

    movz	fp,	#660
    ldr	x0,	[sp, fp]

    movz	fp,	#1540
    str	x0,	[sp, fp]

    movz	fp,	#668
    ldr	x26,	[sp, fp]

    movz	fp,	#676
    mov	x0,	x26
    ldr	x26,	[sp, fp]

    movz	fp,	#1548
    ldr	x24,	[sp, #1432]

    mov	x18,	x26
    str	x24,	[sp, fp]

    movz	fp,	#1548
    ldr	x26,	[sp, fp]

    movz	fp,	#740
    ldr	w24,	[x26]

    str	w24,	[sp, #1564]

    ldr	x24,	[sp, #1432]

    add	x23,	x24,	#4
    str	x23,	[sp, #704]

    ldr	x24,	[sp, #704]

    ldr	w26,	[x24]

    str	w26,	[sp, #712]

    ldr	w24,	[sp, #712]

    ldr	w27,	[sp, #1564]

    add	w23,	w24,	w27
    str	w23,	[sp, #1556]

    ldr	x24,	[sp, #720]

    str	x24,	[sp, fp]

    movz	fp,	#740
    ldr	x26,	[sp, fp]

    movz	fp,	#748
    ldr	w24,	[x26]

    str	w24,	[sp, #716]

    ldr	w24,	[sp, #716]

    ldr	w28,	[sp, #1556]

    add	w26,	w28,	w24
    str	w26,	[sp, #1560]

    ldr	x24,	[sp, #720]

    add	x23,	x24,	#4
    str	x23,	[sp, fp]

    movz	fp,	#748
    ldr	x24,	[sp, fp]

    movz	fp,	#732
    ldr	w26,	[x24]

    str	w26,	[sp, #756]

    ldr	w24,	[sp, #756]

    ldr	w28,	[sp, #1560]

    add	w24,	w28,	w24
    str	w24,	[sp, #2948]

    ldr	x26,	[sp, fp]

    movz	fp,	#764
    str	x26,	[sp, fp]

    movz	fp,	#764
    ldr	x24,	[sp, fp]

    movz	fp,	#732
    ldr	w24,	[x24]

    str	w24,	[sp, #760]

    ldr	w24,	[sp, #760]

    ldr	w26,	[sp, #2948]

    add	w26,	w26,	w24
    str	w26,	[sp, #1804]

    ldr	x24,	[sp, fp]

    movz	fp,	#772
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#772
    ldr	x24,	[sp, fp]

    movz	fp,	#788
    ldr	w24,	[x24]

    str	w24,	[sp, #780]

    ldr	w26,	[sp, #780]

    ldr	w28,	[sp, #1804]

    add	w28,	w28,	w26
    str	w28,	[sp, #2944]

    ldr	x24,	[sp, fp]

    movz	fp,	#788
    str	x24,	[sp, #800]

    ldr	x23,	[sp, #800]

    ldr	w24,	[x23]

    str	w24,	[sp, #784]

    ldr	w28,	[sp, #784]

    ldr	w23,	[sp, #2944]

    add	w24,	w23,	w28
    str	w24,	[sp, #1584]

    ldr	x24,	[sp, fp]

    movz	fp,	#932
    add	x24,	x24,	#4
    str	x24,	[sp, #808]

    ldr	x26,	[sp, #808]

    ldr	w23,	[x26]

    str	w23,	[sp, #816]

    ldr	w28,	[sp, #816]

    ldr	w24,	[sp, #1584]

    add	w24,	w24,	w28
    str	w24,	[sp, #2940]

    ldr	x23,	[sp, #824]

    str	x23,	[sp, #832]

    ldr	x24,	[sp, #832]

    ldr	w26,	[x24]

    str	w26,	[sp, #820]

    ldr	w26,	[sp, #820]

    ldr	w24,	[sp, #2940]

    add	w28,	w24,	w26
    str	w28,	[sp, #1784]

    ldr	x26,	[sp, #824]

    add	x26,	x26,	#4
    str	x26,	[sp, #840]

    ldr	x24,	[sp, #840]

    ldr	w24,	[x24]

    str	w24,	[sp, #848]

    ldr	w27,	[sp, #848]

    ldr	w23,	[sp, #1784]

    add	w26,	w23,	w27
    str	w26,	[sp, #2936]

    ldr	x24,	[sp, #856]

    str	x24,	[sp, #864]

    ldr	x24,	[sp, #864]

    ldr	w24,	[x24]

    str	w24,	[sp, #852]

    ldr	w26,	[sp, #852]

    ldr	w28,	[sp, #2936]

    add	w24,	w28,	w26
    str	w24,	[sp, #572]

    ldr	x24,	[sp, #856]

    add	x24,	x24,	#4
    str	x24,	[sp, #872]

    ldr	x23,	[sp, #872]

    ldr	w24,	[x23]

    str	w24,	[sp, #880]

    ldr	w27,	[sp, #880]

    ldr	w26,	[sp, #572]

    add	w23,	w26,	w27
    str	w23,	[sp, #2932]

    ldr	x24,	[sp, #888]

    str	x24,	[sp, #896]

    ldr	x26,	[sp, #896]

    ldr	w23,	[x26]

    str	w23,	[sp, #884]

    ldr	w28,	[sp, #884]

    ldr	w24,	[sp, #2932]

    add	w23,	w24,	w28
    str	w23,	[sp, #576]

    ldr	x23,	[sp, #888]

    add	x23,	x23,	#4
    str	x23,	[sp, #904]

    ldr	x24,	[sp, #904]

    ldr	w26,	[x24]

    str	w26,	[sp, #912]

    ldr	w27,	[sp, #912]

    ldr	w24,	[sp, #576]

    add	w24,	w24,	w27
    str	w24,	[sp, #2928]

    ldr	x24,	[sp, #920]

    str	x24,	[sp, fp]

    movz	fp,	#932
    ldr	x26,	[sp, fp]

    movz	fp,	#940
    ldr	w24,	[x26]

    str	w24,	[sp, #916]

    ldr	w24,	[sp, #916]

    ldr	w26,	[sp, #2928]

    add	w26,	w26,	w24
    str	w26,	[sp, #580]

    ldr	x24,	[sp, #920]

    add	x23,	x24,	#4
    str	x23,	[sp, fp]

    movz	fp,	#940
    ldr	x24,	[sp, fp]

    movz	fp,	#956
    ldr	w26,	[x24]

    str	w26,	[sp, #948]

    ldr	w26,	[sp, #948]

    ldr	w28,	[sp, #580]

    add	w28,	w28,	w26
    str	w28,	[sp, #2924]

    ldr	x24,	[sp, fp]

    movz	fp,	#972
    str	x24,	[sp, fp]

    movz	fp,	#972
    ldr	x24,	[sp, fp]

    movz	fp,	#956
    ldr	w24,	[x24]

    str	w24,	[sp, #952]

    ldr	w27,	[sp, #952]

    ldr	w23,	[sp, #2924]

    add	w24,	w23,	w27
    str	w24,	[sp, #584]

    ldr	x24,	[sp, fp]

    movz	fp,	#980
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#980
    ldr	x23,	[sp, fp]

    movz	fp,	#996
    ldr	w24,	[x23]

    str	w24,	[sp, #988]

    ldr	w28,	[sp, #988]

    ldr	w24,	[sp, #584]

    add	w24,	w24,	w28
    str	w24,	[sp, #2920]

    ldr	x23,	[sp, fp]

    movz	fp,	#1012
    str	x23,	[sp, fp]

    movz	fp,	#1012
    ldr	x24,	[sp, fp]

    movz	fp,	#996
    ldr	w23,	[x24]

    str	w23,	[sp, #992]

    ldr	w28,	[sp, #992]

    ldr	w24,	[sp, #2920]

    add	w28,	w24,	w28
    str	w28,	[sp, #588]

    ldr	x23,	[sp, fp]

    movz	fp,	#1020
    add	x26,	x23,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1020
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x24]

    str	w24,	[sp, #1028]

    ldr	w27,	[sp, #1028]

    ldr	w23,	[sp, #588]

    add	w26,	w23,	w27
    str	w26,	[sp, #2916]

    ldr	x24,	[sp, fp]

    movz	fp,	#1052
    str	x24,	[sp, fp]

    movz	fp,	#1052
    ldr	x23,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x23]

    str	w24,	[sp, #1032]

    ldr	w26,	[sp, #1032]

    ldr	w28,	[sp, #2916]

    add	w24,	w28,	w26
    str	w24,	[sp, #592]

    ldr	x24,	[sp, fp]

    movz	fp,	#1060
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1060
    ldr	x26,	[sp, fp]

    movz	fp,	#1076
    ldr	w23,	[x26]

    str	w23,	[sp, #1068]

    ldr	w28,	[sp, #1068]

    ldr	w26,	[sp, #592]

    add	w23,	w26,	w28
    str	w23,	[sp, #2912]

    ldr	x26,	[sp, fp]

    movz	fp,	#1092
    str	x26,	[sp, fp]

    movz	fp,	#1092
    ldr	x24,	[sp, fp]

    movz	fp,	#1076
    ldr	w26,	[x24]

    str	w26,	[sp, #1072]

    ldr	w27,	[sp, #1072]

    ldr	w24,	[sp, #2912]

    add	w23,	w24,	w27
    str	w23,	[sp, #596]

    ldr	x26,	[sp, fp]

    movz	fp,	#1100
    add	x24,	x26,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1100
    ldr	x24,	[sp, fp]

    movz	fp,	#1116
    ldr	w24,	[x24]

    str	w24,	[sp, #1108]

    ldr	w27,	[sp, #1108]

    ldr	w24,	[sp, #596]

    add	w24,	w24,	w27
    str	w24,	[sp, #2908]

    ldr	x24,	[sp, fp]

    movz	fp,	#1124
    str	x24,	[sp, fp]

    movz	fp,	#1124
    ldr	x23,	[sp, fp]

    movz	fp,	#1116
    ldr	w24,	[x23]

    str	w24,	[sp, #1112]

    ldr	w27,	[sp, #1112]

    ldr	w26,	[sp, #2908]

    add	w26,	w26,	w27
    str	w26,	[sp, #600]

    ldr	x24,	[sp, fp]

    movz	fp,	#1132
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1132
    ldr	x26,	[sp, fp]

    movz	fp,	#1148
    ldr	w23,	[x26]

    str	w23,	[sp, #1140]

    ldr	w23,	[sp, #1140]

    ldr	w28,	[sp, #600]

    add	w28,	w28,	w23
    str	w28,	[sp, #2904]

    ldr	x23,	[sp, fp]

    movz	fp,	#1156
    str	x23,	[sp, fp]

    movz	fp,	#1156
    ldr	x24,	[sp, fp]

    movz	fp,	#1148
    ldr	w26,	[x24]

    str	w26,	[sp, #1144]

    ldr	w27,	[sp, #1144]

    ldr	w23,	[sp, #2904]

    add	w24,	w23,	w27
    str	w24,	[sp, #2880]

    ldr	x26,	[sp, fp]

    movz	fp,	#1164
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1164
    ldr	x24,	[sp, fp]

    movz	fp,	#1180
    ldr	w24,	[x24]

    str	w24,	[sp, #1172]

    ldr	w26,	[sp, #1172]

    ldr	w24,	[sp, #2880]

    add	w24,	w24,	w26
    str	w24,	[sp, #2900]

    ldr	x24,	[sp, fp]

    movz	fp,	#1188
    str	x24,	[sp, fp]

    movz	fp,	#1188
    ldr	x24,	[sp, fp]

    movz	fp,	#1180
    ldr	w24,	[x24]

    str	w24,	[sp, #1176]

    ldr	w26,	[sp, #1176]

    ldr	w24,	[sp, #2900]

    add	w28,	w24,	w26
    str	w28,	[sp, #2884]

    ldr	x24,	[sp, fp]

    movz	fp,	#1196
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	x23,	[sp, fp]

    movz	fp,	#1212
    ldr	w24,	[x23]

    str	w24,	[sp, #1204]

    ldr	w28,	[sp, #1204]

    ldr	w23,	[sp, #2884]

    ldr	x24,	[sp, fp]

    add	w27,	w23,	w28
    movz	fp,	#1220
    str	x24,	[sp, fp]

    movz	fp,	#1220
    ldr	x26,	[sp, fp]

    movz	fp,	#1212
    ldr	w23,	[x26]

    str	w23,	[sp, #1208]

    ldr	w24,	[sp, #1208]

    add	w24,	w27,	w24
    str	w24,	[sp, #2888]

    ldr	x23,	[sp, fp]

    movz	fp,	#1228
    add	x23,	x23,	#4
    str	x23,	[sp, fp]

    movz	fp,	#1228
    ldr	x24,	[sp, fp]

    movz	fp,	#1244
    ldr	w26,	[x24]

    str	w26,	[sp, #1236]

    ldr	w24,	[sp, #1236]

    ldr	w26,	[sp, #2888]

    add	w26,	w26,	w24
    str	w26,	[sp, #2896]

    ldr	x26,	[sp, fp]

    movz	fp,	#1252
    str	x26,	[sp, fp]

    movz	fp,	#1252
    ldr	x24,	[sp, fp]

    movz	fp,	#1244
    ldr	w24,	[x24]

    str	w24,	[sp, #1240]

    ldr	w26,	[sp, #1240]

    ldr	w28,	[sp, #2896]

    ldr	x24,	[sp, fp]

    add	w27,	w28,	w26
    movz	fp,	#1260
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1260
    ldr	x24,	[sp, fp]

    movz	fp,	#1276
    ldr	w24,	[x24]

    str	w24,	[sp, #1268]

    ldr	w23,	[sp, #1268]

    add	w23,	w27,	w23
    str	w23,	[sp, #2892]

    ldr	x24,	[sp, fp]

    movz	fp,	#1284
    str	x24,	[sp, fp]

    movz	fp,	#1284
    ldr	x23,	[sp, fp]

    movz	fp,	#1276
    ldr	w24,	[x23]

    str	w24,	[sp, #1272]

    ldr	w28,	[sp, #1272]

    ldr	w24,	[sp, #2892]

    add	w27,	w24,	w28
    ldr	x24,	[sp, fp]

    movz	fp,	#1292
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1292
    ldr	x26,	[sp, fp]

    movz	fp,	#1308
    ldr	w23,	[x26]

    str	w23,	[sp, #1300]

    ldr	w24,	[sp, #1300]

    ldr	x23,	[sp, fp]

    add	w27,	w27,	w24
    movz	fp,	#1316
    str	x23,	[sp, fp]

    movz	fp,	#1316
    ldr	x24,	[sp, fp]

    movz	fp,	#1308
    ldr	w26,	[x24]

    str	w26,	[sp, #1304]

    ldr	w24,	[sp, #1304]

    ldr	x26,	[sp, fp]

    add	w27,	w27,	w24
    movz	fp,	#1324
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1324
    ldr	x24,	[sp, fp]

    movz	fp,	#1340
    ldr	w24,	[x24]

    str	w24,	[sp, #1332]

    ldr	w24,	[sp, #1332]

    add	w28,	w27,	w24
    add	x27,	x21,	#4
    ldr	x24,	[sp, fp]

    movz	fp,	#1348
    str	x24,	[sp, fp]

    movz	fp,	#1348
    ldr	x24,	[sp, fp]

    movz	fp,	#1340
    ldr	w24,	[x24]

    str	w24,	[sp, #1336]

    ldr	w23,	[sp, #1336]

    ldr	x24,	[sp, fp]

    add	w28,	w28,	w23
    movz	fp,	#1356
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1356
    ldr	x23,	[sp, fp]

    movz	fp,	#1372
    ldr	w24,	[x23]

    str	w24,	[sp, #1364]

    ldr	w26,	[sp, #1364]

    ldr	x24,	[sp, fp]

    add	w28,	w28,	w26
    movz	fp,	#1380
    str	x24,	[sp, fp]

    movz	fp,	#1380
    ldr	x26,	[sp, fp]

    movz	fp,	#1372
    ldr	w23,	[x26]

    str	w23,	[sp, #1368]

    ldr	w24,	[sp, #1368]

    ldr	x23,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1756
    add	x24,	x23,	#4
    str	x24,	[sp, #1400]

    ldr	x23,	[sp, #1400]

    ldr	w24,	[x23]

    str	w24,	[sp, #1396]

    ldr	w24,	[sp, #1396]

    add	w23,	w28,	w24
    str	w23,	[sp, #1388]

    ldr	x26,	[sp, fp]

    movz	fp,	#1756
    ldr	w28,	[x26]

    ldr	w24,	[sp, #1388]

    ldr	x23,	[sp, fp]

    add	w28,	w24,	w28
    movz	fp,	#1532
    add	x24,	x23,	#4
    mov	x23,	x20
    ldr	w24,	[x24]

    add	w26,	w28,	w24
    ldr	x24,	[sp, #2872]

    ldr	w24,	[x24]

    add	w26,	w26,	w24
    str	w26,	[sp, #1392]

    ldr	x24,	[sp, #2872]

    add	x24,	x24,	#4
    ldr	w28,	[x24]

    ldr	w24,	[sp, #1392]

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
    movz	fp,	#1532
    ldr	w22,	[x26]

    add	w24,	w20,	w28
    ldr	x28,	[sp, fp]

    movz	fp,	#1540
    add	x28,	x28,	#4
    add	w26,	w24,	w22
    ldr	w19,	[x28]

    ldr	x22,	[sp, fp]

    add	w24,	w26,	w19
    movz	fp,	#1540
    ldr	w25,	[x22]

    ldr	x22,	[sp, fp]

    add	w19,	w24,	w25
    add	x26,	x22,	#4
    add	x22,	x0,	#4
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
    
    movz	fp,	#6032
    add	sp, sp, fp
    ret


main_109:
    ldr	w27,	[sp, #1508]

    ldr	w26,	[sp, #796]

    sub	w22,	w27,	#1
    ldr	w7,	[sp, #2868]

    mov	w5,	w22
    add	w15,	w7,	w26
    movz	w26,	#1
    movk	w26,	#15232,	lsl #16
    str	w15,	[sp, #688]

    mov	w14,	w26
    ldr	w1,	[sp, #688]

    mov	w11,	w14
    sdiv	w6,	w1,	w14
    str	w6,	[sp, #684]

    ldr	w18,	[sp, #684]

    ldr	w26,	[sp, #688]

    str	w5,	[sp, #1508]

    msub	w16,	w18,	w11,	w26

    mov	w18,	w13
    mov	w15,	w16
    str	w15,	[sp, #796]

    ldr	w1,	[sp, #1480]

    str	w1,	[sp, #2868]

    ldr	w0,	[sp, #568]

    mov	w15,	w0
    str	w15,	[sp, #1480]

    ldr	w1,	[sp, #564]

    str	w1,	[sp, #568]

    ldr	w1,	[sp, #560]

    str	w1,	[sp, #564]

    ldr	w26,	[sp, #548]

    str	w26,	[sp, #560]

    ldr	w17,	[sp, #536]

    str	w17,	[sp, #548]

    ldr	w6,	[sp, #1772]

    mov	w10,	w6
    str	w10,	[sp, #536]

    ldr	w5,	[sp, #1448]

    mov	w7,	w5
    str	w7,	[sp, #1772]

    ldr	w6,	[sp, #1444]

    str	w6,	[sp, #1448]

    ldr	w0,	[sp, #1440]

    str	w0,	[sp, #1444]

    ldr	w11,	[sp, #3784]

    mov	w0,	w11
    str	w0,	[sp, #1440]

    ldr	w22,	[sp, #692]

    mov	w14,	w22
    str	w14,	[sp, #3784]

    ldr	w17,	[sp, #696]

    mov	w23,	w17
    str	w23,	[sp, #692]

    ldr	w10,	[sp, #1460]

    mov	w21,	w10
    str	w21,	[sp, #696]

    movz	w21,	#0
    ldr	w11,	[sp, #4300]

    str	w11,	[sp, #1460]

    ldr	w16,	[sp, #4296]

    str	w16,	[sp, #4300]

    mov	w16,	w19
    ldr	w10,	[sp, #4292]

    str	w10,	[sp, #4296]

    ldr	w6,	[sp, #4280]

    str	w6,	[sp, #4292]

    ldr	w1,	[sp, #3716]

    str	w1,	[sp, #4280]

    ldr	w10,	[sp, #3664]

    str	w10,	[sp, #3716]

    ldr	w24,	[sp, #3712]

    str	w24,	[sp, #3664]

    ldr	w6,	[sp, #3668]

    str	w6,	[sp, #3712]

    ldr	w28,	[sp, #1672]

    str	w28,	[sp, #3668]

    ldr	w17,	[sp, #1864]

    str	w17,	[sp, #1672]

    ldr	w4,	[sp, #1704]

    str	w4,	[sp, #1864]

    str	w16,	[sp, #1704]

    ldr	w19,	[sp, #3780]

    str	w18,	[sp, #3780]

    mov	w18,	w21
    ldr	w27,	[sp, #3788]

    str	w18,	[sp, #3788]

    mov	w13,	w27
    b	main_75

main_35:
    mov	w1,	w2
    b	main_36

