.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#5904
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1844]

    bl	getint
    str	w0,	[sp, #1848]

    bl	getint
    str	w0,	[sp, #1852]

    bl	getint
    str	w0,	[sp, #956]

    bl	getint
    str	w0,	[sp, #960]

    bl	getint
    str	w0,	[sp, #988]

    bl	getint
    str	w0,	[sp, #1184]

    bl	getint
    str	w0,	[sp, #1220]

    bl	getint
    str	w0,	[sp, #1224]

    bl	getint
    str	w0,	[sp, #1260]

    bl	getint
    str	w0,	[sp, #1264]

    bl	getint
    str	w0,	[sp, #1300]

    bl	getint
    str	w0,	[sp, #1304]

    bl	getint
    str	w0,	[sp, #1340]

    bl	getint
    str	w0,	[sp, #1344]

    bl	getint
    movz	w9,	#0
    add	x28,	sp,	#300
    add	x16,	sp,	#292
    add	x2,	sp,	#284
    str	w0,	[sp, #1856]

    add	x4,	sp,	#272
    add	x18,	sp,	#276
    add	x15,	sp,	#288
    movz	fp,	#1820
    add	x14,	sp,	#296
    add	x17,	sp,	#280
    str	x4,	[sp, fp]

    add	x4,	sp,	#304
    movz	fp,	#1820
    ldr	x5,	[sp, fp]

    movz	fp,	#2900
    ldr	w0,	[sp, #1844]

    str	w0,	[x5]

    ldr	w3,	[sp, #1848]

    str	w3,	[x18]

    add	x3,	sp,	#308
    ldr	w7,	[sp, #1852]

    str	w7,	[x17]

    ldr	w0,	[sp, #956]

    str	w0,	[x2]

    ldr	w0,	[sp, #960]

    str	w0,	[x15]

    ldr	w20,	[sp, #988]

    str	w20,	[x16]

    ldr	w6,	[sp, #1184]

    str	w6,	[x14]

    str	x28,	[sp, #4328]

    add	x28,	sp,	#324
    ldr	w1,	[sp, #1220]

    ldr	x21,	[sp, #4328]

    str	w1,	[x21]

    str	x4,	[sp, #4336]

    ldr	w7,	[sp, #1224]

    ldr	x5,	[sp, #4336]

    str	w7,	[x5]

    add	x5,	sp,	#316
    str	x3,	[sp, #4352]

    add	x3,	sp,	#312
    ldr	w1,	[sp, #1260]

    ldr	x4,	[sp, #4352]

    str	w1,	[x4]

    str	x3,	[sp, fp]

    movz	fp,	#2900
    ldr	w6,	[sp, #1264]

    ldr	x7,	[sp, fp]

    movz	fp,	#2892
    str	w6,	[x7]

    str	x5,	[sp, fp]

    movz	fp,	#2892
    ldr	w8,	[sp, #1300]

    ldr	x0,	[sp, fp]

    movz	fp,	#2884
    str	w8,	[x0]

    add	x0,	sp,	#320
    str	x0,	[sp, fp]

    movz	fp,	#2884
    ldr	w22,	[sp, #1304]

    ldr	x4,	[sp, fp]

    str	w22,	[x4]

    add	x22,	sp,	#332
    str	x28,	[sp, #5896]

    ldr	w8,	[sp, #1340]

    ldr	x0,	[sp, #5896]

    str	w8,	[x0]

    mov	w8,	w9
    ldr	w6,	[sp, #1344]

    add	x0,	sp,	#328
    str	w6,	[x0]

    ldr	w13,	[sp, #1856]

    str	w13,	[x22]


main_36:
    add	w23,	w8,	#1
    cmp	w23,	#16
    bge	main_56

main_40:
    lsl	w8,	w8,	#2
    movz	fp,	#1820
    ldr	x6,	[sp, fp]

    add	x7,	x6,	x8
    mov	w6,	w23

main_43:
    ldr	w10,	[x7]

    lsl	w21,	w6,	#2
    movz	fp,	#1820
    ldr	x11,	[sp, fp]

    add	x3,	x11,	x21
    ldr	w27,	[x3]

    cmp	w10,	w27
    bge	main_51

main_49:
    str	w27,	[x7]

    str	w10,	[x3]


main_51:
    add	w8,	w6,	#1
    cmp	w8,	#16
    bge	main_56

main_42:
    mov	w6,	w8
    b	main_43

main_56:
    cmp	w23,	#15
    blt	main_35

main_58:
    movz	fp,	#1820
    ldr	x8,	[sp, fp]

    movz	fp,	#2900
    ldr	w8,	[x8]

    str	w8,	[sp, #440]

    ldr	w10,	[x18]

    ldr	w3,	[x17]

    mov	w25,	w3
    ldr	w20,	[x2]

    ldr	w15,	[x15]

    ldr	w4,	[x16]

    ldr	w18,	[x14]

    ldr	x7,	[sp, #4328]

    ldr	w14,	[x7]

    mov	w8,	w14
    ldr	x5,	[sp, #4336]

    ldr	w6,	[x5]

    ldr	x7,	[sp, #4352]

    ldr	w16,	[x7]

    ldr	x5,	[sp, fp]

    movz	fp,	#2892
    ldr	w9,	[x5]

    ldr	x13,	[sp, fp]

    movz	fp,	#2884
    ldr	w7,	[x13]

    ldr	x17,	[sp, fp]

    ldr	w17,	[x17]

    ldr	x1,	[sp, #5896]

    ldr	w28,	[x1]

    mov	w1,	w20
    ldr	w5,	[x0]

    mov	w0,	w10
    ldr	w11,	[x22]

    mov	w10,	w15
    ldr	w27,	[sp, #440]

    mov	w15,	w28
    str	w27,	[sp, #1840]

    mov	w27,	w4
    str	w0,	[sp, #1052]

    mov	w0,	w18
    str	w25,	[sp, #1800]

    mov	w18,	w16
    mov	w25,	w6
    str	w1,	[sp, #1836]

    mov	w1,	w17
    str	w10,	[sp, #1832]

    mov	w10,	w9
    str	w27,	[sp, #1828]

    mov	w9,	w7
    str	w0,	[sp, #1816]

    str	w8,	[sp, #1796]

    mov	w8,	w5
    str	w25,	[sp, #1784]

    str	w18,	[sp, #516]

    str	w10,	[sp, #512]

    str	w9,	[sp, #2756]

    mov	w9,	w11
    str	w1,	[sp, #508]

    str	w15,	[sp, #336]

    str	w8,	[sp, #944]

    str	w9,	[sp, #952]

    ldr	w24,	[sp, #1844]

    str	w24,	[sp, #3884]

    ldr	w7,	[sp, #1848]

    str	w7,	[sp, #2916]

    ldr	w19,	[sp, #1852]

    str	w19,	[sp, #2928]

    ldr	w18,	[sp, #956]

    str	w18,	[sp, #2760]

    ldr	w18,	[sp, #960]

    str	w18,	[sp, #2912]

    ldr	w11,	[sp, #988]

    str	w11,	[sp, #2920]

    ldr	w16,	[sp, #1184]

    str	w16,	[sp, #2764]

    ldr	w20,	[sp, #1220]

    str	w20,	[sp, #2496]

    ldr	w18,	[sp, #1224]

    str	w18,	[sp, #2924]

    ldr	w16,	[sp, #1260]

    mov	w28,	w16
    str	w28,	[sp, #2908]

    ldr	w9,	[sp, #1264]

    mov	w16,	w9
    str	w16,	[sp, #2556]

    ldr	w8,	[sp, #1300]

    mov	w13,	w8
    str	w13,	[sp, #2768]

    ldr	w8,	[sp, #1304]

    mov	w5,	w8
    ldr	w8,	[sp, #1340]

    mov	w23,	w8
    str	w23,	[sp, #2560]

    ldr	w28,	[sp, #1344]

    ldr	w15,	[sp, #1856]

    mov	w7,	w28
    mov	w27,	w15

main_75:
    ldr	w0,	[sp, #1840]

    cmp	w0,	#0
    bne	main_109

main_113:
    add	x0,	sp,	#16
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    movz	w6,	#1
    movz	w10,	#8848
    movz	fp,	#500
    add	x27,	sp,	#16
    mov	w8,	w6
    add	x20,	x27,	#4
    str	x27,	[sp, fp]

    movz	fp,	#500
    ldr	w9,	[sp, #1052]

    ldr	x24,	[sp, fp]

    str	w9,	[x24]

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
    add	x0,	sp,	#24
    movz	fp,	#444
    add	x24,	sp,	#32
    add	x26,	sp,	#40
    add	x21,	sp,	#48
    add	x28,	sp,	#56
    add	x25,	sp,	#72
    add	x20,	sp,	#88
    add	x23,	sp,	#96
    add	x27,	sp,	#104
    add	x22,	sp,	#112
    str	x0,	[sp, fp]

    add	x0,	sp,	#64
    movz	fp,	#468
    str	x21,	[sp, fp]

    add	x21,	sp,	#200
    movz	fp,	#460
    str	x28,	[sp, fp]

    add	x28,	sp,	#192
    movz	fp,	#452
    str	x0,	[sp, #1720]

    add	x0,	sp,	#80
    str	x25,	[sp, fp]

    add	x25,	sp,	#184
    movz	fp,	#476
    str	x0,	[sp, fp]

    movz	fp,	#348
    add	x0,	sp,	#120
    str	x20,	[sp, #1728]

    add	x20,	sp,	#144
    str	x23,	[sp, #1744]

    add	x23,	sp,	#152
    str	x27,	[sp, #1752]

    add	x27,	sp,	#160
    str	x22,	[sp, #1768]

    add	x22,	sp,	#176
    str	x0,	[sp, #1760]

    add	x0,	sp,	#128
    str	x0,	[sp, #384]

    add	x0,	sp,	#136
    str	x0,	[sp, #424]

    add	x0,	sp,	#168
    str	x20,	[sp, #432]

    add	x20,	sp,	#224
    str	x23,	[sp, #392]

    add	x23,	sp,	#232
    str	x27,	[sp, #416]

    add	x27,	sp,	#240
    str	x0,	[sp, #400]

    add	x0,	sp,	#208
    str	x22,	[sp, #408]

    add	x22,	sp,	#256
    str	x25,	[sp, fp]

    add	x25,	sp,	#264
    movz	fp,	#356
    str	x28,	[sp, fp]

    movz	fp,	#364
    str	x21,	[sp, fp]

    mov	x21,	x24
    movz	fp,	#444
    str	x0,	[sp, #872]

    add	x0,	sp,	#216
    str	x0,	[sp, #880]

    add	x0,	sp,	#248
    str	x20,	[sp, #888]

    str	x23,	[sp, #896]

    str	x27,	[sp, #904]

    str	x0,	[sp, #912]

    mov	x0,	x26
    str	x22,	[sp, #920]

    str	x25,	[sp, #928]

    ldr	x22,	[sp, fp]

    movz	fp,	#980
    mov	x20,	x22
    str	x20,	[sp, fp]

    movz	fp,	#1012
    str	x21,	[sp, fp]

    movz	fp,	#1044
    str	x0,	[sp, fp]

    movz	fp,	#468
    ldr	x24,	[sp, fp]

    movz	fp,	#460
    str	x24,	[sp, #1080]

    ldr	x28,	[sp, fp]

    movz	fp,	#452
    str	x28,	[sp, #1112]

    ldr	x20,	[sp, #1720]

    str	x20,	[sp, #1144]

    ldr	x24,	[sp, fp]

    movz	fp,	#476
    str	x24,	[sp, #1176]

    ldr	x20,	[sp, fp]

    movz	fp,	#1212
    str	x20,	[sp, fp]

    movz	fp,	#1252
    ldr	x20,	[sp, #1728]

    str	x20,	[sp, fp]

    movz	fp,	#1292
    ldr	x20,	[sp, #1744]

    str	x20,	[sp, fp]

    movz	fp,	#1332
    ldr	x20,	[sp, #1752]

    str	x20,	[sp, fp]

    movz	fp,	#1372
    ldr	x20,	[sp, #1768]

    str	x20,	[sp, fp]

    movz	fp,	#1404
    ldr	x24,	[sp, #1760]

    str	x24,	[sp, fp]

    movz	fp,	#1436
    ldr	x28,	[sp, #384]

    str	x28,	[sp, fp]

    movz	fp,	#1468
    ldr	x20,	[sp, #424]

    str	x20,	[sp, fp]

    movz	fp,	#1596
    ldr	x24,	[sp, #432]

    str	x24,	[sp, #1504]

    ldr	x28,	[sp, #392]

    str	x28,	[sp, #1536]

    ldr	x20,	[sp, #416]

    str	x20,	[sp, #1568]

    ldr	x24,	[sp, #400]

    str	x24,	[sp, fp]

    movz	fp,	#1628
    ldr	x28,	[sp, #408]

    str	x28,	[sp, fp]

    movz	fp,	#348
    ldr	x24,	[sp, fp]

    movz	fp,	#356
    str	x24,	[sp, #2096]

    ldr	x20,	[sp, fp]

    movz	fp,	#364
    str	x20,	[sp, #2088]

    ldr	x0,	[sp, fp]

    movz	fp,	#1860
    mov	x20,	x0
    ldr	x0,	[sp, #872]

    ldr	x28,	[sp, #880]

    mov	x21,	x0
    mov	x25,	x28
    ldr	x0,	[sp, #888]

    ldr	x26,	[sp, #896]

    mov	x19,	x0
    mov	x22,	x26
    ldr	x26,	[sp, #904]

    str	x26,	[sp, fp]

    movz	fp,	#1868
    ldr	x27,	[sp, #912]

    str	x27,	[sp, fp]

    movz	fp,	#500
    ldr	x26,	[sp, #920]

    mov	x0,	x26
    ldr	x26,	[sp, #928]

    ldr	x24,	[sp, fp]

    mov	x18,	x26
    movz	fp,	#500
    str	x24,	[sp, #1880]

    ldr	x24,	[sp, #1880]

    ldr	w23,	[x24]

    str	w23,	[sp, #1876]

    ldr	x23,	[sp, fp]

    movz	fp,	#964
    add	x24,	x23,	#4
    str	x24,	[sp, fp]

    movz	fp,	#964
    ldr	x23,	[sp, fp]

    movz	fp,	#980
    ldr	w24,	[x23]

    str	w24,	[sp, #972]

    ldr	w26,	[sp, #972]

    ldr	w24,	[sp, #1876]

    add	w24,	w26,	w24
    str	w24,	[sp, #1888]

    ldr	x24,	[sp, fp]

    movz	fp,	#980
    str	x24,	[sp, #992]

    ldr	x24,	[sp, #992]

    ldr	w23,	[x24]

    str	w23,	[sp, #976]

    ldr	w24,	[sp, #976]

    ldr	w26,	[sp, #1888]

    add	w24,	w26,	w24
    str	w24,	[sp, #1892]

    ldr	x23,	[sp, fp]

    movz	fp,	#1012
    add	x24,	x23,	#4
    str	x24,	[sp, #1000]

    ldr	x23,	[sp, #1000]

    ldr	w24,	[x23]

    str	w24,	[sp, #948]

    ldr	w26,	[sp, #948]

    ldr	w24,	[sp, #1892]

    add	w23,	w24,	w26
    str	w23,	[sp, #2880]

    ldr	x24,	[sp, fp]

    movz	fp,	#1020
    str	x24,	[sp, fp]

    movz	fp,	#1020
    ldr	x26,	[sp, fp]

    movz	fp,	#1012
    ldr	w23,	[x26]

    str	w23,	[sp, #1008]

    ldr	w28,	[sp, #1008]

    ldr	w24,	[sp, #2880]

    add	w24,	w24,	w28
    str	w24,	[sp, #2776]

    ldr	x23,	[sp, fp]

    movz	fp,	#1028
    add	x23,	x23,	#4
    str	x23,	[sp, fp]

    movz	fp,	#1028
    ldr	x24,	[sp, fp]

    movz	fp,	#1044
    ldr	w26,	[x24]

    str	w26,	[sp, #1036]

    ldr	w24,	[sp, #1036]

    ldr	w26,	[sp, #2776]

    add	w24,	w26,	w24
    str	w24,	[sp, #2876]

    ldr	x26,	[sp, fp]

    movz	fp,	#1044
    str	x26,	[sp, #1056]

    ldr	x24,	[sp, #1056]

    ldr	w24,	[x24]

    str	w24,	[sp, #1040]

    ldr	w24,	[sp, #1040]

    ldr	w26,	[sp, #2876]

    add	w23,	w26,	w24
    str	w23,	[sp, #2780]

    ldr	x24,	[sp, fp]

    movz	fp,	#1188
    add	x24,	x24,	#4
    str	x24,	[sp, #1064]

    ldr	x24,	[sp, #1064]

    ldr	w24,	[x24]

    str	w24,	[sp, #1072]

    ldr	w27,	[sp, #1072]

    ldr	w24,	[sp, #2780]

    add	w28,	w24,	w27
    str	w28,	[sp, #2872]

    ldr	x24,	[sp, #1080]

    str	x24,	[sp, #1088]

    ldr	x23,	[sp, #1088]

    ldr	w24,	[x23]

    str	w24,	[sp, #1076]

    ldr	w28,	[sp, #1076]

    ldr	w23,	[sp, #2872]

    add	w26,	w23,	w28
    str	w26,	[sp, #2784]

    ldr	x24,	[sp, #1080]

    add	x24,	x24,	#4
    str	x24,	[sp, #1096]

    ldr	x26,	[sp, #1096]

    ldr	w23,	[x26]

    str	w23,	[sp, #1104]

    ldr	w23,	[sp, #1104]

    ldr	w28,	[sp, #2784]

    add	w24,	w28,	w23
    str	w24,	[sp, #2868]

    ldr	x23,	[sp, #1112]

    str	x23,	[sp, #1120]

    ldr	x24,	[sp, #1120]

    ldr	w26,	[x24]

    str	w26,	[sp, #1108]

    ldr	w26,	[sp, #1108]

    ldr	w24,	[sp, #2868]

    add	w24,	w24,	w26
    str	w24,	[sp, #2788]

    ldr	x26,	[sp, #1112]

    add	x26,	x26,	#4
    str	x26,	[sp, #1128]

    ldr	x24,	[sp, #1128]

    ldr	w24,	[x24]

    str	w24,	[sp, #1136]

    ldr	w26,	[sp, #1136]

    ldr	w24,	[sp, #2788]

    add	w26,	w24,	w26
    str	w26,	[sp, #2864]

    ldr	x24,	[sp, #1144]

    str	x24,	[sp, #1152]

    ldr	x24,	[sp, #1152]

    ldr	w24,	[x24]

    str	w24,	[sp, #1140]

    ldr	w26,	[sp, #1140]

    ldr	w28,	[sp, #2864]

    add	w28,	w28,	w26
    str	w28,	[sp, #2792]

    ldr	x24,	[sp, #1144]

    add	x24,	x24,	#4
    str	x24,	[sp, #1160]

    ldr	x23,	[sp, #1160]

    ldr	w24,	[x23]

    str	w24,	[sp, #1168]

    ldr	w28,	[sp, #1168]

    ldr	w23,	[sp, #2792]

    add	w23,	w23,	w28
    str	w23,	[sp, #2860]

    ldr	x24,	[sp, #1176]

    str	x24,	[sp, fp]

    movz	fp,	#1188
    ldr	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	w23,	[x24]

    str	w23,	[sp, #1172]

    ldr	w28,	[sp, #1172]

    ldr	w24,	[sp, #2860]

    add	w24,	w24,	w28
    str	w24,	[sp, #2796]

    ldr	x23,	[sp, #1176]

    add	x24,	x23,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	x23,	[sp, fp]

    movz	fp,	#1212
    ldr	w24,	[x23]

    str	w24,	[sp, #1204]

    ldr	w27,	[sp, #1204]

    ldr	w26,	[sp, #2796]

    add	w24,	w26,	w27
    str	w24,	[sp, #2856]

    ldr	x23,	[sp, fp]

    movz	fp,	#1228
    str	x23,	[sp, fp]

    movz	fp,	#1228
    ldr	x24,	[sp, fp]

    movz	fp,	#1212
    ldr	w23,	[x24]

    str	w23,	[sp, #1208]

    ldr	w28,	[sp, #1208]

    ldr	w26,	[sp, #2856]

    add	w23,	w26,	w28
    str	w23,	[sp, #2800]

    ldr	x23,	[sp, fp]

    movz	fp,	#1236
    add	x26,	x23,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1236
    ldr	x24,	[sp, fp]

    movz	fp,	#1252
    ldr	w24,	[x24]

    str	w24,	[sp, #1244]

    ldr	w27,	[sp, #1244]

    ldr	w24,	[sp, #2800]

    add	w28,	w24,	w27
    str	w28,	[sp, #2852]

    ldr	x24,	[sp, fp]

    movz	fp,	#1268
    str	x24,	[sp, fp]

    movz	fp,	#1268
    ldr	x23,	[sp, fp]

    movz	fp,	#1252
    ldr	w24,	[x23]

    str	w24,	[sp, #1248]

    ldr	w27,	[sp, #1248]

    ldr	w23,	[sp, #2852]

    add	w26,	w23,	w27
    str	w26,	[sp, #2804]

    ldr	x24,	[sp, fp]

    movz	fp,	#1276
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1276
    ldr	x26,	[sp, fp]

    movz	fp,	#1292
    ldr	w23,	[x26]

    str	w23,	[sp, #1284]

    ldr	w23,	[sp, #1284]

    ldr	w28,	[sp, #2804]

    add	w24,	w28,	w23
    str	w24,	[sp, #2848]

    ldr	x26,	[sp, fp]

    movz	fp,	#1308
    str	x26,	[sp, fp]

    movz	fp,	#1308
    ldr	x24,	[sp, fp]

    movz	fp,	#1292
    ldr	w26,	[x24]

    str	w26,	[sp, #1288]

    ldr	w26,	[sp, #1288]

    ldr	w24,	[sp, #2848]

    add	w24,	w24,	w26
    str	w24,	[sp, #2808]

    ldr	x26,	[sp, fp]

    movz	fp,	#1316
    add	x24,	x26,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1316
    ldr	x24,	[sp, fp]

    movz	fp,	#1332
    ldr	w24,	[x24]

    str	w24,	[sp, #1324]

    ldr	w26,	[sp, #1324]

    ldr	w24,	[sp, #2808]

    add	w26,	w24,	w26
    str	w26,	[sp, #2844]

    ldr	x24,	[sp, fp]

    movz	fp,	#1348
    str	x24,	[sp, fp]

    movz	fp,	#1348
    ldr	x26,	[sp, fp]

    movz	fp,	#1332
    ldr	w24,	[x26]

    str	w24,	[sp, #1328]

    ldr	w27,	[sp, #1328]

    ldr	w28,	[sp, #2844]

    add	w28,	w28,	w27
    str	w28,	[sp, #2812]

    ldr	x24,	[sp, fp]

    movz	fp,	#1356
    add	x23,	x24,	#4
    str	x23,	[sp, fp]

    movz	fp,	#1356
    ldr	x24,	[sp, fp]

    movz	fp,	#1372
    ldr	w26,	[x24]

    str	w26,	[sp, #1364]

    ldr	w27,	[sp, #1364]

    ldr	w23,	[sp, #2812]

    add	w23,	w23,	w27
    str	w23,	[sp, #2840]

    ldr	x26,	[sp, fp]

    movz	fp,	#1380
    str	x26,	[sp, fp]

    movz	fp,	#1380
    ldr	x24,	[sp, fp]

    movz	fp,	#1372
    ldr	w24,	[x24]

    str	w24,	[sp, #1368]

    ldr	w27,	[sp, #1368]

    ldr	w24,	[sp, #2840]

    add	w24,	w24,	w27
    str	w24,	[sp, #2816]

    ldr	x24,	[sp, fp]

    movz	fp,	#1388
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1388
    ldr	x24,	[sp, fp]

    movz	fp,	#1404
    ldr	w24,	[x24]

    str	w24,	[sp, #1396]

    ldr	w24,	[sp, #1396]

    ldr	w26,	[sp, #2816]

    add	w24,	w26,	w24
    str	w24,	[sp, #2836]

    ldr	x24,	[sp, fp]

    movz	fp,	#1412
    str	x24,	[sp, fp]

    movz	fp,	#1412
    ldr	x23,	[sp, fp]

    movz	fp,	#1404
    ldr	w24,	[x23]

    str	w24,	[sp, #1400]

    ldr	w27,	[sp, #1400]

    ldr	w26,	[sp, #2836]

    add	w23,	w26,	w27
    str	w23,	[sp, #2820]

    ldr	x24,	[sp, fp]

    movz	fp,	#1420
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1420
    ldr	x26,	[sp, fp]

    movz	fp,	#1436
    ldr	w23,	[x26]

    str	w23,	[sp, #1428]

    ldr	w28,	[sp, #1428]

    ldr	w24,	[sp, #2820]

    add	w28,	w24,	w28
    str	w28,	[sp, #2832]

    ldr	x23,	[sp, fp]

    movz	fp,	#1444
    str	x23,	[sp, fp]

    movz	fp,	#1444
    ldr	x24,	[sp, fp]

    movz	fp,	#1436
    ldr	w26,	[x24]

    str	w26,	[sp, #1432]

    ldr	w27,	[sp, #1432]

    ldr	w23,	[sp, #2832]

    add	w26,	w23,	w27
    str	w26,	[sp, #2824]

    ldr	x26,	[sp, fp]

    movz	fp,	#1452
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1452
    ldr	x24,	[sp, fp]

    movz	fp,	#1468
    ldr	w24,	[x24]

    str	w24,	[sp, #1460]

    ldr	w26,	[sp, #1460]

    ldr	w28,	[sp, #2824]

    ldr	x24,	[sp, fp]

    add	w27,	w28,	w26
    movz	fp,	#1476
    str	x24,	[sp, fp]

    movz	fp,	#1476
    ldr	x24,	[sp, fp]

    movz	fp,	#1468
    ldr	w24,	[x24]

    str	w24,	[sp, #1464]

    ldr	w23,	[sp, #1464]

    add	w24,	w27,	w23
    str	w24,	[sp, #2828]

    ldr	x24,	[sp, fp]

    movz	fp,	#1484
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1484
    ldr	x23,	[sp, fp]

    movz	fp,	#1596
    ldr	w24,	[x23]

    str	w24,	[sp, #1496]

    ldr	w28,	[sp, #1496]

    ldr	w24,	[sp, #2828]

    add	w28,	w24,	w28
    ldr	x24,	[sp, #1504]

    str	x24,	[sp, #1512]

    ldr	x26,	[sp, #1512]

    ldr	w23,	[x26]

    str	w23,	[sp, #1500]

    ldr	w24,	[sp, #1500]

    ldr	x23,	[sp, #1504]

    add	w28,	w28,	w24
    add	x23,	x23,	#4
    str	x23,	[sp, #1520]

    ldr	x24,	[sp, #1520]

    ldr	w26,	[x24]

    str	w26,	[sp, #1528]

    ldr	w24,	[sp, #1528]

    ldr	x26,	[sp, #1536]

    add	w28,	w28,	w24
    str	x26,	[sp, #1544]

    ldr	x24,	[sp, #1544]

    ldr	w24,	[x24]

    str	w24,	[sp, #1532]

    ldr	w24,	[sp, #1532]

    add	w27,	w28,	w24
    ldr	x24,	[sp, #1536]

    add	x24,	x24,	#4
    str	x24,	[sp, #1552]

    ldr	x24,	[sp, #1552]

    ldr	w24,	[x24]

    str	w24,	[sp, #1560]

    ldr	w23,	[sp, #1560]

    ldr	x24,	[sp, #1568]

    add	w28,	w27,	w23
    str	x24,	[sp, #1576]

    ldr	x23,	[sp, #1576]

    ldr	w24,	[x23]

    str	w24,	[sp, #1564]

    ldr	w26,	[sp, #1564]

    ldr	x24,	[sp, #1568]

    add	w28,	w28,	w26
    add	x24,	x24,	#4
    str	x24,	[sp, #1584]

    ldr	x26,	[sp, #1584]

    ldr	w23,	[x26]

    str	w23,	[sp, #1592]

    ldr	w24,	[sp, #1592]

    ldr	x23,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1604
    str	x23,	[sp, fp]

    movz	fp,	#1604
    ldr	x24,	[sp, fp]

    movz	fp,	#1596
    ldr	w26,	[x24]

    str	w26,	[sp, #1492]

    ldr	w24,	[sp, #1492]

    ldr	x26,	[sp, fp]

    add	w27,	w28,	w24
    movz	fp,	#1612
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1612
    ldr	x24,	[sp, fp]

    movz	fp,	#1628
    ldr	w24,	[x24]

    str	w24,	[sp, #1620]

    ldr	w24,	[sp, #1620]

    add	w26,	w27,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1636
    str	x24,	[sp, fp]

    movz	fp,	#1636
    ldr	x24,	[sp, fp]

    movz	fp,	#1628
    ldr	w24,	[x24]

    str	w24,	[sp, #1624]

    ldr	w23,	[sp, #1624]

    ldr	x24,	[sp, fp]

    add	w28,	w26,	w23
    movz	fp,	#1860
    add	x26,	x24,	#4
    str	x26,	[sp, #1656]

    ldr	x24,	[sp, #1656]

    ldr	w23,	[x24]

    str	w23,	[sp, #1652]

    ldr	w24,	[sp, #1652]

    add	w24,	w28,	w24
    str	w24,	[sp, #1644]

    ldr	x26,	[sp, #2096]

    ldr	w28,	[x26]

    ldr	w23,	[sp, #1644]

    add	w27,	w23,	w28
    ldr	x28,	[sp, #2096]

    add	x24,	x28,	#4
    ldr	w24,	[x24]

    add	w26,	w27,	w24
    add	x27,	x21,	#4
    ldr	x24,	[sp, #2088]

    ldr	w24,	[x24]

    add	w24,	w26,	w24
    str	w24,	[sp, #1648]

    ldr	x23,	[sp, #2088]

    add	x24,	x23,	#4
    mov	x23,	x20
    ldr	w24,	[x24]

    ldr	w26,	[sp, #1648]

    add	w28,	w26,	w24
    add	x24,	x20,	#4
    ldr	w26,	[x23]

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
    movz	fp,	#1860
    ldr	w22,	[x26]

    ldr	x19,	[sp, fp]

    add	w24,	w20,	w28
    movz	fp,	#1868
    add	x28,	x19,	#4
    add	w26,	w24,	w22
    ldr	w19,	[x28]

    ldr	x22,	[sp, fp]

    add	w24,	w26,	w19
    movz	fp,	#1868
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
    
    movz	fp,	#5904
    add	sp, sp, fp
    ret


main_109:
    ldr	w0,	[sp, #1840]

    mov	w11,	w5
    mov	w4,	w7
    ldr	w12,	[sp, #1052]

    sub	w18,	w0,	#1
    mov	w7,	w27
    ldr	w9,	[sp, #1800]

    add	w24,	w9,	w12
    mov	w9,	w18
    str	w24,	[sp, #940]

    ldr	w19,	[sp, #940]

    movz	w24,	#1
    movk	w24,	#15232,	lsl #16
    mov	w23,	w24
    sdiv	w3,	w19,	w24
    movz	w24,	#0
    str	w3,	[sp, #936]

    mov	w27,	w24
    ldr	w8,	[sp, #936]

    ldr	w12,	[sp, #940]

    str	w9,	[sp, #1840]

    msub	w6,	w8,	w23,	w12

    mov	w3,	w6
    str	w3,	[sp, #1052]

    ldr	w28,	[sp, #1836]

    str	w28,	[sp, #1800]

    ldr	w22,	[sp, #1832]

    str	w22,	[sp, #1836]

    ldr	w19,	[sp, #1828]

    str	w19,	[sp, #1832]

    ldr	w15,	[sp, #1816]

    str	w15,	[sp, #1828]

    ldr	w2,	[sp, #1796]

    str	w2,	[sp, #1816]

    ldr	w23,	[sp, #1784]

    str	w23,	[sp, #1796]

    ldr	w18,	[sp, #516]

    str	w18,	[sp, #1784]

    ldr	w14,	[sp, #512]

    str	w14,	[sp, #516]

    ldr	w10,	[sp, #2756]

    str	w10,	[sp, #512]

    ldr	w8,	[sp, #508]

    str	w8,	[sp, #2756]

    ldr	w3,	[sp, #336]

    str	w3,	[sp, #508]

    ldr	w10,	[sp, #944]

    mov	w16,	w10
    str	w16,	[sp, #336]

    ldr	w10,	[sp, #952]

    mov	w18,	w10
    str	w18,	[sp, #944]

    ldr	w13,	[sp, #3884]

    mov	w12,	w13
    str	w12,	[sp, #952]

    ldr	w14,	[sp, #2916]

    str	w14,	[sp, #3884]

    ldr	w26,	[sp, #2928]

    str	w26,	[sp, #2916]

    ldr	w12,	[sp, #2760]

    str	w12,	[sp, #2928]

    ldr	w12,	[sp, #2912]

    str	w12,	[sp, #2760]

    ldr	w22,	[sp, #2920]

    str	w22,	[sp, #2912]

    ldr	w1,	[sp, #2764]

    str	w1,	[sp, #2920]

    ldr	w16,	[sp, #2496]

    str	w16,	[sp, #2764]

    ldr	w21,	[sp, #2924]

    str	w21,	[sp, #2496]

    ldr	w8,	[sp, #2908]

    str	w8,	[sp, #2924]

    ldr	w18,	[sp, #2556]

    str	w18,	[sp, #2908]

    ldr	w2,	[sp, #2768]

    str	w2,	[sp, #2556]

    str	w11,	[sp, #2768]

    ldr	w3,	[sp, #2560]

    str	w4,	[sp, #2560]

    mov	w5,	w3
    b	main_75

main_35:
    mov	w8,	w23
    b	main_36

