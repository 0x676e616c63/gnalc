.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#5808
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1488]

    bl	getint
    str	w0,	[sp, #1492]

    bl	getint
    str	w0,	[sp, #1496]

    bl	getint
    str	w0,	[sp, #584]

    bl	getint
    str	w0,	[sp, #588]

    bl	getint
    str	w0,	[sp, #616]

    bl	getint
    str	w0,	[sp, #816]

    bl	getint
    str	w0,	[sp, #852]

    bl	getint
    str	w0,	[sp, #856]

    bl	getint
    str	w0,	[sp, #892]

    bl	getint
    str	w0,	[sp, #896]

    bl	getint
    str	w0,	[sp, #932]

    bl	getint
    str	w0,	[sp, #936]

    bl	getint
    str	w0,	[sp, #972]

    bl	getint
    str	w0,	[sp, #976]

    bl	getint
    add	x2,	sp,	#292
    add	x24,	sp,	#296
    movz	fp,	#4212
    add	x13,	sp,	#320
    str	w0,	[sp, #1500]

    add	x5,	sp,	#272
    add	x4,	sp,	#300
    add	x20,	sp,	#276
    add	x19,	sp,	#280
    add	x22,	sp,	#284
    add	x17,	sp,	#288
    add	x16,	sp,	#312
    add	x21,	sp,	#332
    str	x5,	[sp, #1464]

    ldr	x6,	[sp, #1464]

    ldr	w3,	[sp, #1488]

    str	w3,	[x6]

    ldr	w6,	[sp, #1492]

    str	w6,	[x20]

    ldr	w10,	[sp, #1496]

    str	w10,	[x19]

    ldr	w8,	[sp, #584]

    str	w8,	[x22]

    add	x8,	sp,	#304
    ldr	w12,	[sp, #588]

    str	w12,	[x17]

    add	x12,	sp,	#308
    ldr	w11,	[sp, #616]

    str	w11,	[x2]

    ldr	w9,	[sp, #816]

    str	w9,	[x24]

    str	x4,	[sp, fp]

    movz	fp,	#4212
    ldr	w25,	[sp, #852]

    ldr	x5,	[sp, fp]

    movz	fp,	#4220
    str	w25,	[x5]

    str	x8,	[sp, fp]

    movz	fp,	#4220
    ldr	w6,	[sp, #856]

    ldr	x10,	[sp, fp]

    movz	fp,	#4228
    str	w6,	[x10]

    add	x10,	sp,	#324
    str	x12,	[sp, fp]

    movz	fp,	#4228
    movz	w12,	#0
    ldr	w1,	[sp, #892]

    ldr	x14,	[sp, fp]

    movz	fp,	#4236
    str	w1,	[x14]

    str	x16,	[sp, fp]

    movz	fp,	#4236
    ldr	w11,	[sp, #896]

    ldr	x18,	[sp, fp]

    str	w11,	[x18]

    add	x11,	sp,	#328
    add	x18,	sp,	#316
    str	x18,	[sp, #2888]

    ldr	w16,	[sp, #932]

    ldr	x0,	[sp, #2888]

    str	w16,	[x0]

    str	x13,	[sp, #2880]

    ldr	w28,	[sp, #936]

    ldr	x15,	[sp, #2880]

    str	w28,	[x15]

    ldr	w6,	[sp, #972]

    str	w6,	[x10]

    str	x11,	[sp, #2872]

    ldr	w11,	[sp, #976]

    ldr	x4,	[sp, #2872]

    str	w11,	[x4]

    ldr	w27,	[sp, #1500]

    str	w27,	[x21]


main_36:
    add	w0,	w12,	#1
    str	w0,	[sp, #1484]

    ldr	w1,	[sp, #1484]

    cmp	w1,	#16
    bge	main_56

main_40:
    lsl	w9,	w12,	#2
    ldr	x7,	[sp, #1464]

    ldr	w12,	[sp, #1484]

    add	x3,	x7,	x9

main_43:
    ldr	w4,	[x3]

    lsl	w7,	w12,	#2
    ldr	x8,	[sp, #1464]

    add	x9,	x8,	x7
    ldr	w18,	[x9]

    cmp	w4,	w18
    bge	main_51

main_49:
    str	w18,	[x3]

    str	w4,	[x9]


main_51:
    add	w12,	w12,	#1
    cmp	w12,	#16
    blt	main_43

main_56:
    ldr	w6,	[sp, #1484]

    cmp	w6,	#15
    blt	main_35

main_58:
    ldr	x9,	[sp, #1464]

    movz	fp,	#4212
    ldr	w9,	[x9]

    str	w9,	[sp, #1296]

    ldr	w5,	[x20]

    mov	w0,	w5
    ldr	w8,	[x19]

    str	w8,	[sp, #428]

    ldr	w26,	[x22]

    mov	w5,	w26
    ldr	w18,	[x17]

    mov	w4,	w18
    ldr	w15,	[x2]

    ldr	w8,	[x24]

    ldr	x28,	[sp, fp]

    movz	fp,	#4220
    ldr	w19,	[x28]

    ldr	x16,	[sp, fp]

    movz	fp,	#4228
    ldr	w1,	[x16]

    ldr	x3,	[sp, fp]

    movz	fp,	#4236
    ldr	w22,	[x3]

    ldr	x12,	[sp, fp]

    ldr	w11,	[x12]

    ldr	x14,	[sp, #2888]

    ldr	w13,	[x14]

    mov	w25,	w13
    ldr	x2,	[sp, #2880]

    ldr	w2,	[x2]

    ldr	w20,	[x10]

    mov	w10,	w19
    ldr	x12,	[sp, #2872]

    mov	w19,	w22
    ldr	w7,	[x12]

    ldr	w6,	[x21]

    mov	w13,	w6
    mov	w21,	w8
    ldr	w12,	[sp, #1296]

    str	w12,	[sp, #1480]

    str	w0,	[sp, #684]

    ldr	w0,	[sp, #428]

    str	w0,	[sp, #496]

    mov	w0,	w1
    str	w5,	[sp, #1476]

    str	w4,	[sp, #1472]

    mov	w4,	w15
    str	w4,	[sp, #500]

    str	w21,	[sp, #2764]

    str	w10,	[sp, #480]

    str	w0,	[sp, #476]

    mov	w0,	w20
    str	w19,	[sp, #464]

    mov	w19,	w7
    str	w11,	[sp, #460]

    str	w25,	[sp, #2772]

    str	w2,	[sp, #456]

    str	w0,	[sp, #1460]

    str	w19,	[sp, #576]

    str	w13,	[sp, #580]

    ldr	w4,	[sp, #1488]

    str	w4,	[sp, #2768]

    ldr	w25,	[sp, #1492]

    str	w25,	[sp, #2596]

    ldr	w0,	[sp, #1496]

    str	w0,	[sp, #2592]

    ldr	w18,	[sp, #584]

    ldr	w23,	[sp, #588]

    str	w23,	[sp, #2896]

    ldr	w2,	[sp, #616]

    str	w2,	[sp, #2780]

    ldr	w5,	[sp, #816]

    mov	w6,	w5
    str	w6,	[sp, #2776]

    ldr	w7,	[sp, #852]

    str	w7,	[sp, #3024]

    ldr	w7,	[sp, #856]

    ldr	w26,	[sp, #892]

    mov	w1,	w7
    str	w26,	[sp, #1576]

    ldr	w15,	[sp, #896]

    str	w15,	[sp, #1560]

    ldr	w13,	[sp, #932]

    mov	w14,	w13
    str	w14,	[sp, #1584]

    ldr	w3,	[sp, #936]

    mov	w5,	w3
    str	w5,	[sp, #1564]

    ldr	w7,	[sp, #972]

    mov	w8,	w7
    str	w8,	[sp, #1568]

    ldr	w15,	[sp, #976]

    mov	w12,	w15
    str	w12,	[sp, #1572]

    ldr	w17,	[sp, #1500]

    mov	w22,	w17

main_75:
    ldr	w26,	[sp, #1480]

    cmp	w26,	#0
    bne	main_109

main_113:
    add	x0,	sp,	#16
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    movz	w8,	#1
    movz	w11,	#8848
    movz	fp,	#1452
    add	x24,	sp,	#16
    add	x18,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1452
    ldr	w10,	[sp, #684]

    ldr	x21,	[sp, fp]

    str	w10,	[x21]

    mov	w10,	w8
    str	w11,	[x18]


main_118:
    cmp	w10,	#25
    bge	main_218

main_121:
    lsl	w20,	w10,	#3
    sub	w12,	w10,	#1
    mov	x21,	x20
    add	x21,	sp,	x21
    lsl	w12,	w12,	#3
    mov	x19,	x12
    add	x21,	x21,	#16
    add	x19,	sp,	x19
    mov	x20,	x21
    add	x19,	x19,	#16
    add	x3,	x21,	#4
    mov	x18,	x19
    add	x5,	x19,	#4
    ldr	w0,	[x5]

    sub	w1,	w0,	#1
    add	w0,	w10,	#1
    str	w1,	[x20]

    sub	w9,	w0,	#1
    add	w14,	w0,	#1
    ldr	w1,	[x18]

    sub	w6,	w1,	#2
    lsl	w12,	w9,	#3
    mov	x18,	x12
    str	w6,	[x3]

    add	x18,	sp,	x18
    lsl	w6,	w0,	#3
    mov	x6,	x6
    add	x18,	x18,	#16
    add	x6,	sp,	x6
    add	x3,	x18,	#4
    add	x6,	x6,	#16
    ldr	w4,	[x3]

    add	x10,	x6,	#4
    sub	w5,	w4,	#1
    str	w5,	[x6]

    ldr	w20,	[x18]

    sub	w21,	w20,	#2
    lsl	w20,	w14,	#3
    mov	x22,	x20
    str	w21,	[x10]

    sub	w20,	w14,	#1
    add	x22,	sp,	x22
    add	w14,	w14,	#1
    lsl	w28,	w20,	#3
    add	x22,	x22,	#16
    add	w13,	w14,	#1
    sub	w10,	w14,	#1
    lsl	w5,	w14,	#3
    mov	x3,	x28
    mov	x6,	x5
    add	x0,	x22,	#4
    sub	w28,	w13,	#1
    lsl	w12,	w10,	#3
    add	x3,	sp,	x3
    add	x6,	sp,	x6
    mov	x20,	x12
    add	x20,	sp,	x20
    add	x3,	x3,	#16
    add	x6,	x6,	#16
    add	x20,	x20,	#16
    add	x15,	x3,	#4
    add	x12,	x6,	#4
    ldr	w16,	[x15]

    sub	w18,	w16,	#1
    str	w18,	[x22]

    lsl	w22,	w13,	#3
    ldr	w3,	[x3]

    mov	x22,	x22
    sub	w4,	w3,	#2
    add	x22,	sp,	x22
    str	w4,	[x0]

    add	x22,	x22,	#16
    add	x4,	x20,	#4
    ldr	w0,	[x4]

    add	x4,	x22,	#4
    sub	w1,	w0,	#1
    str	w1,	[x6]

    lsl	w1,	w28,	#3
    ldr	w20,	[x20]

    mov	x1,	x1
    sub	w21,	w20,	#2
    add	x1,	sp,	x1
    str	w21,	[x12]

    add	x1,	x1,	#16
    add	x19,	x1,	#4
    ldr	w20,	[x19]

    sub	w21,	w20,	#1
    str	w21,	[x22]

    add	w22,	w13,	#1
    ldr	w0,	[x1]

    sub	w1,	w0,	#2
    sub	w9,	w22,	#1
    lsl	w5,	w22,	#3
    str	w1,	[x4]

    mov	x15,	x5
    add	x15,	sp,	x15
    lsl	w11,	w9,	#3
    mov	x17,	x11
    add	x15,	x15,	#16
    add	x17,	sp,	x17
    add	x5,	x15,	#4
    add	x17,	x17,	#16
    add	x1,	x17,	#4
    ldr	w3,	[x1]

    sub	w4,	w3,	#1
    str	w4,	[x15]

    add	w15,	w22,	#1
    ldr	w19,	[x17]

    sub	w20,	w19,	#2
    sub	w27,	w15,	#1
    lsl	w22,	w15,	#3
    str	w20,	[x5]

    mov	x3,	x22
    add	x3,	sp,	x3
    lsl	w0,	w27,	#3
    mov	x0,	x0
    add	x3,	x3,	#16
    add	x0,	sp,	x0
    add	x28,	x3,	#4
    add	x0,	x0,	#16
    add	x22,	x0,	#4
    ldr	w26,	[x22]

    sub	w27,	w26,	#1
    str	w27,	[x3]

    add	w3,	w15,	#1
    ldr	w0,	[x0]

    sub	w1,	w0,	#2
    sub	w11,	w3,	#1
    lsl	w6,	w3,	#3
    str	w1,	[x28]

    mov	x16,	x6
    add	x16,	sp,	x16
    lsl	w13,	w11,	#3
    mov	x18,	x13
    add	x16,	x16,	#16
    add	x18,	sp,	x18
    add	x8,	x16,	#4
    add	x18,	x18,	#16
    add	x5,	x18,	#4
    ldr	w7,	[x5]

    sub	w9,	w7,	#1
    str	w9,	[x16]

    ldr	w20,	[x18]

    sub	w21,	w20,	#2
    str	w21,	[x8]

    add	w8,	w3,	#1
    mov	w10,	w8
    b	main_118

main_218:
    mov	w8,	w10

main_220:
    lsl	w26,	w8,	#3
    sub	w20,	w8,	#1
    mov	x26,	x26
    add	w8,	w8,	#1
    add	x26,	sp,	x26
    lsl	w21,	w20,	#3
    mov	x0,	x21
    add	x26,	x26,	#16
    add	x0,	sp,	x0
    mov	x25,	x26
    add	x0,	x0,	#16
    add	x27,	x26,	#4
    add	x6,	x0,	#4
    ldr	w11,	[x6]

    sub	w12,	w11,	#1
    str	w12,	[x25]

    ldr	w3,	[x0]

    sub	w4,	w3,	#2
    str	w4,	[x27]

    cmp	w8,	#32
    blt	main_220

main_235:
    add	x0,	sp,	#24
    add	x18,	sp,	#32
    add	x26,	sp,	#40
    movz	fp,	#1300
    add	x20,	sp,	#48
    add	x21,	sp,	#56
    add	x25,	sp,	#64
    add	x28,	sp,	#72
    add	x27,	sp,	#80
    add	x19,	sp,	#88
    add	x23,	sp,	#96
    add	x22,	sp,	#112
    str	x26,	[sp, fp]

    movz	fp,	#1420
    str	x20,	[sp, fp]

    add	x20,	sp,	#136
    movz	fp,	#1316
    str	x21,	[sp, fp]

    movz	fp,	#1308
    str	x25,	[sp, #448]

    add	x25,	sp,	#120
    str	x28,	[sp, fp]

    movz	fp,	#1380
    str	x27,	[sp, fp]

    add	x27,	sp,	#104
    movz	fp,	#1388
    str	x19,	[sp, fp]

    mov	x19,	x18
    movz	fp,	#1428
    str	x23,	[sp, fp]

    movz	fp,	#1412
    str	x27,	[sp, fp]

    add	x27,	sp,	#128
    movz	fp,	#1396
    str	x22,	[sp, fp]

    movz	fp,	#1404
    str	x25,	[sp, fp]

    add	x25,	sp,	#144
    movz	fp,	#412
    str	x27,	[sp, #336]

    add	x27,	sp,	#152
    str	x20,	[sp, fp]

    add	x20,	sp,	#160
    movz	fp,	#420
    str	x25,	[sp, fp]

    movz	fp,	#388
    add	x25,	sp,	#168
    str	x27,	[sp, #432]

    add	x27,	sp,	#176
    str	x20,	[sp, #440]

    add	x20,	sp,	#184
    str	x25,	[sp, fp]

    add	x25,	sp,	#192
    movz	fp,	#396
    str	x27,	[sp, fp]

    add	x27,	sp,	#200
    movz	fp,	#404
    str	x20,	[sp, fp]

    movz	fp,	#644
    add	x20,	sp,	#208
    str	x25,	[sp, #344]

    add	x25,	sp,	#216
    str	x27,	[sp, #352]

    add	x27,	sp,	#224
    str	x20,	[sp, #360]

    add	x20,	sp,	#232
    str	x25,	[sp, #368]

    add	x25,	sp,	#240
    str	x27,	[sp, #520]

    add	x27,	sp,	#248
    str	x20,	[sp, #528]

    add	x20,	sp,	#256
    str	x25,	[sp, #536]

    add	x25,	sp,	#264
    str	x27,	[sp, #544]

    str	x20,	[sp, #552]

    str	x25,	[sp, #560]

    str	x0,	[sp, #608]

    str	x19,	[sp, fp]

    movz	fp,	#1300
    ldr	x25,	[sp, fp]

    movz	fp,	#676
    str	x25,	[sp, fp]

    movz	fp,	#1420
    ldr	x24,	[sp, fp]

    movz	fp,	#1316
    str	x24,	[sp, #712]

    ldr	x0,	[sp, fp]

    movz	fp,	#1308
    str	x0,	[sp, #744]

    ldr	x23,	[sp, #448]

    str	x23,	[sp, #776]

    ldr	x0,	[sp, fp]

    movz	fp,	#1380
    str	x0,	[sp, #808]

    ldr	x26,	[sp, fp]

    movz	fp,	#844
    str	x26,	[sp, fp]

    movz	fp,	#1388
    ldr	x0,	[sp, fp]

    movz	fp,	#884
    str	x0,	[sp, fp]

    movz	fp,	#1428
    ldr	x18,	[sp, fp]

    movz	fp,	#924
    str	x18,	[sp, fp]

    movz	fp,	#1412
    ldr	x21,	[sp, fp]

    movz	fp,	#964
    str	x21,	[sp, fp]

    movz	fp,	#1396
    ldr	x23,	[sp, fp]

    movz	fp,	#1004
    str	x23,	[sp, fp]

    movz	fp,	#1404
    ldr	x0,	[sp, fp]

    movz	fp,	#1036
    str	x0,	[sp, fp]

    movz	fp,	#1068
    ldr	x0,	[sp, #336]

    str	x0,	[sp, fp]

    movz	fp,	#412
    ldr	x27,	[sp, fp]

    movz	fp,	#1100
    str	x27,	[sp, fp]

    movz	fp,	#420
    ldr	x21,	[sp, fp]

    movz	fp,	#1132
    str	x21,	[sp, fp]

    movz	fp,	#1164
    ldr	x26,	[sp, #432]

    str	x26,	[sp, fp]

    movz	fp,	#1196
    ldr	x19,	[sp, #440]

    str	x19,	[sp, fp]

    movz	fp,	#388
    ldr	x25,	[sp, fp]

    movz	fp,	#1228
    str	x25,	[sp, fp]

    movz	fp,	#396
    ldr	x18,	[sp, fp]

    movz	fp,	#1260
    str	x18,	[sp, fp]

    movz	fp,	#404
    ldr	x0,	[sp, fp]

    movz	fp,	#1452
    str	x0,	[sp, #2616]

    ldr	x0,	[sp, #344]

    str	x0,	[sp, #2600]

    ldr	x18,	[sp, #352]

    ldr	x23,	[sp, #360]

    mov	x27,	x23
    ldr	x23,	[sp, #368]

    ldr	x22,	[sp, #520]

    mov	x25,	x23
    mov	x19,	x22
    ldr	x22,	[sp, #528]

    ldr	x0,	[sp, #536]

    mov	x26,	x22
    str	x0,	[sp, #1504]

    ldr	x23,	[sp, #544]

    str	x23,	[sp, #1512]

    ldr	x28,	[sp, #552]

    ldr	x24,	[sp, #560]

    mov	x0,	x28
    ldr	x20,	[sp, fp]

    mov	x21,	x24
    movz	fp,	#1452
    str	x20,	[sp, #1520]

    ldr	x24,	[sp, #1520]

    ldr	w20,	[x24]

    str	w20,	[sp, #516]

    ldr	x24,	[sp, fp]

    movz	fp,	#620
    add	x20,	x24,	#4
    str	x20,	[sp, #592]

    ldr	x24,	[sp, #592]

    ldr	w24,	[x24]

    str	w24,	[sp, #600]

    ldr	w20,	[sp, #600]

    ldr	w28,	[sp, #516]

    add	w24,	w20,	w28
    str	w24,	[sp, #504]

    ldr	x20,	[sp, #608]

    str	x20,	[sp, fp]

    movz	fp,	#620
    ldr	x24,	[sp, fp]

    movz	fp,	#628
    ldr	w24,	[x24]

    str	w24,	[sp, #604]

    ldr	w20,	[sp, #604]

    ldr	w24,	[sp, #504]

    add	w20,	w24,	w20
    str	w20,	[sp, #512]

    ldr	x24,	[sp, #608]

    add	x20,	x24,	#4
    str	x20,	[sp, fp]

    movz	fp,	#628
    ldr	x24,	[sp, fp]

    movz	fp,	#644
    ldr	w24,	[x24]

    str	w24,	[sp, #636]

    ldr	w20,	[sp, #636]

    ldr	w24,	[sp, #512]

    add	w24,	w24,	w20
    str	w24,	[sp, #508]

    ldr	x24,	[sp, fp]

    movz	fp,	#652
    str	x24,	[sp, fp]

    movz	fp,	#652
    ldr	x20,	[sp, fp]

    movz	fp,	#644
    ldr	w24,	[x20]

    str	w24,	[sp, #640]

    ldr	w20,	[sp, #640]

    ldr	w24,	[sp, #508]

    add	w22,	w24,	w20
    ldr	x24,	[sp, fp]

    movz	fp,	#660
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#660
    ldr	x20,	[sp, fp]

    movz	fp,	#676
    ldr	w20,	[x20]

    str	w20,	[sp, #668]

    ldr	w20,	[sp, #668]

    add	w24,	w22,	w20
    str	w24,	[sp, #2868]

    ldr	x20,	[sp, fp]

    movz	fp,	#676
    str	x20,	[sp, #688]

    ldr	x20,	[sp, #688]

    ldr	w20,	[x20]

    str	w20,	[sp, #672]

    ldr	w24,	[sp, #672]

    ldr	w20,	[sp, #2868]

    add	w20,	w20,	w24
    str	w20,	[sp, #2792]

    ldr	x20,	[sp, fp]

    movz	fp,	#820
    add	x20,	x20,	#4
    str	x20,	[sp, #696]

    ldr	x24,	[sp, #696]

    ldr	w20,	[x24]

    str	w20,	[sp, #704]

    ldr	w20,	[sp, #704]

    ldr	w23,	[sp, #2792]

    add	w24,	w23,	w20
    str	w24,	[sp, #2864]

    ldr	x20,	[sp, #712]

    str	x20,	[sp, #720]

    ldr	x24,	[sp, #720]

    ldr	w24,	[x24]

    str	w24,	[sp, #708]

    ldr	w24,	[sp, #708]

    ldr	w20,	[sp, #2864]

    add	w20,	w20,	w24
    str	w20,	[sp, #2796]

    ldr	x24,	[sp, #712]

    add	x24,	x24,	#4
    str	x24,	[sp, #728]

    ldr	x20,	[sp, #728]

    ldr	w24,	[x20]

    str	w24,	[sp, #736]

    ldr	w28,	[sp, #736]

    ldr	w24,	[sp, #2796]

    add	w22,	w24,	w28
    ldr	x24,	[sp, #744]

    str	x24,	[sp, #752]

    ldr	x20,	[sp, #752]

    ldr	w20,	[x20]

    str	w20,	[sp, #740]

    ldr	w20,	[sp, #740]

    add	w23,	w22,	w20
    str	w23,	[sp, #2800]

    ldr	x20,	[sp, #744]

    add	x20,	x20,	#4
    str	x20,	[sp, #760]

    ldr	x20,	[sp, #760]

    ldr	w20,	[x20]

    str	w20,	[sp, #768]

    ldr	w23,	[sp, #768]

    ldr	w24,	[sp, #2800]

    add	w23,	w24,	w23
    str	w23,	[sp, #2860]

    ldr	x20,	[sp, #776]

    str	x20,	[sp, #784]

    ldr	x24,	[sp, #784]

    ldr	w20,	[x24]

    str	w20,	[sp, #772]

    ldr	w20,	[sp, #772]

    ldr	w24,	[sp, #2860]

    add	w24,	w24,	w20
    str	w24,	[sp, #2804]

    ldr	x20,	[sp, #776]

    add	x20,	x20,	#4
    str	x20,	[sp, #792]

    ldr	x24,	[sp, #792]

    ldr	w24,	[x24]

    str	w24,	[sp, #800]

    ldr	w24,	[sp, #800]

    ldr	w20,	[sp, #2804]

    add	w20,	w20,	w24
    str	w20,	[sp, #2856]

    ldr	x20,	[sp, #808]

    str	x20,	[sp, fp]

    movz	fp,	#820
    ldr	x24,	[sp, fp]

    movz	fp,	#828
    ldr	w24,	[x24]

    str	w24,	[sp, #804]

    ldr	w28,	[sp, #804]

    ldr	w24,	[sp, #2856]

    add	w24,	w24,	w28
    str	w24,	[sp, #2808]

    ldr	x24,	[sp, #808]

    add	x20,	x24,	#4
    str	x20,	[sp, fp]

    movz	fp,	#828
    ldr	x24,	[sp, fp]

    movz	fp,	#844
    ldr	w24,	[x24]

    str	w24,	[sp, #836]

    ldr	w22,	[sp, #836]

    ldr	w20,	[sp, #2808]

    ldr	x24,	[sp, fp]

    add	w22,	w20,	w22
    movz	fp,	#860
    str	x24,	[sp, fp]

    movz	fp,	#860
    ldr	x20,	[sp, fp]

    movz	fp,	#844
    ldr	w24,	[x20]

    str	w24,	[sp, #840]

    ldr	w20,	[sp, #840]

    add	w20,	w22,	w20
    str	w20,	[sp, #2812]

    ldr	x24,	[sp, fp]

    movz	fp,	#868
    add	x20,	x24,	#4
    str	x20,	[sp, fp]

    movz	fp,	#868
    ldr	x20,	[sp, fp]

    movz	fp,	#884
    ldr	w20,	[x20]

    str	w20,	[sp, #876]

    ldr	w24,	[sp, #876]

    ldr	w23,	[sp, #2812]

    ldr	x20,	[sp, fp]

    add	w28,	w23,	w24
    movz	fp,	#900
    str	x20,	[sp, fp]

    movz	fp,	#900
    ldr	x24,	[sp, fp]

    movz	fp,	#884
    ldr	w20,	[x24]

    str	w20,	[sp, #880]

    ldr	w24,	[sp, #880]

    add	w20,	w28,	w24
    str	w20,	[sp, #2816]

    ldr	x20,	[sp, fp]

    movz	fp,	#908
    add	x24,	x20,	#4
    str	x24,	[sp, fp]

    movz	fp,	#908
    ldr	x20,	[sp, fp]

    movz	fp,	#924
    ldr	w24,	[x20]

    str	w24,	[sp, #916]

    ldr	w28,	[sp, #916]

    ldr	w24,	[sp, #2816]

    ldr	x20,	[sp, fp]

    add	w22,	w24,	w28
    movz	fp,	#940
    str	x20,	[sp, fp]

    movz	fp,	#940
    ldr	x20,	[sp, fp]

    movz	fp,	#924
    ldr	w20,	[x20]

    str	w20,	[sp, #920]

    ldr	w20,	[sp, #920]

    add	w23,	w22,	w20
    str	w23,	[sp, #2820]

    ldr	x20,	[sp, fp]

    movz	fp,	#948
    add	x20,	x20,	#4
    str	x20,	[sp, fp]

    movz	fp,	#948
    ldr	x24,	[sp, fp]

    movz	fp,	#964
    ldr	w20,	[x24]

    str	w20,	[sp, #956]

    ldr	w20,	[sp, #956]

    ldr	w24,	[sp, #2820]

    add	w20,	w24,	w20
    str	w20,	[sp, #2852]

    ldr	x24,	[sp, fp]

    movz	fp,	#980
    str	x24,	[sp, fp]

    movz	fp,	#980
    ldr	x20,	[sp, fp]

    movz	fp,	#964
    ldr	w24,	[x20]

    str	w24,	[sp, #960]

    ldr	w20,	[sp, #960]

    ldr	w23,	[sp, #2852]

    add	w24,	w23,	w20
    str	w24,	[sp, #2824]

    ldr	x24,	[sp, fp]

    movz	fp,	#988
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#988
    ldr	x20,	[sp, fp]

    movz	fp,	#1004
    ldr	w20,	[x20]

    str	w20,	[sp, #996]

    ldr	w24,	[sp, #996]

    ldr	w20,	[sp, #2824]

    add	w24,	w20,	w24
    str	w24,	[sp, #2848]

    ldr	x20,	[sp, fp]

    movz	fp,	#1012
    str	x20,	[sp, fp]

    movz	fp,	#1012
    ldr	x20,	[sp, fp]

    movz	fp,	#1004
    ldr	w20,	[x20]

    str	w20,	[sp, #1000]

    ldr	w24,	[sp, #1000]

    ldr	w20,	[sp, #2848]

    add	w24,	w20,	w24
    str	w24,	[sp, #2828]

    ldr	x20,	[sp, fp]

    movz	fp,	#1020
    add	x20,	x20,	#4
    str	x20,	[sp, fp]

    movz	fp,	#1020
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w20,	[x24]

    str	w20,	[sp, #1028]

    ldr	w22,	[sp, #1028]

    ldr	w20,	[sp, #2828]

    add	w24,	w20,	w22
    str	w24,	[sp, #2844]

    ldr	x20,	[sp, fp]

    movz	fp,	#1044
    str	x20,	[sp, fp]

    movz	fp,	#1044
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x24]

    str	w24,	[sp, #1032]

    ldr	w24,	[sp, #1032]

    ldr	w20,	[sp, #2844]

    add	w20,	w20,	w24
    str	w20,	[sp, #2832]

    ldr	x24,	[sp, fp]

    movz	fp,	#1052
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1052
    ldr	x20,	[sp, fp]

    movz	fp,	#1068
    ldr	w24,	[x20]

    str	w24,	[sp, #1060]

    ldr	w28,	[sp, #1060]

    ldr	w23,	[sp, #2832]

    ldr	x24,	[sp, fp]

    add	w22,	w23,	w28
    movz	fp,	#1076
    str	x24,	[sp, fp]

    movz	fp,	#1076
    ldr	x20,	[sp, fp]

    movz	fp,	#1068
    ldr	w20,	[x20]

    str	w20,	[sp, #1064]

    ldr	w20,	[sp, #1064]

    add	w20,	w22,	w20
    str	w20,	[sp, #2836]

    ldr	x20,	[sp, fp]

    movz	fp,	#1084
    add	x20,	x20,	#4
    str	x20,	[sp, fp]

    movz	fp,	#1084
    ldr	x20,	[sp, fp]

    movz	fp,	#1100
    ldr	w20,	[x20]

    str	w20,	[sp, #1092]

    ldr	w20,	[sp, #1092]

    ldr	w24,	[sp, #2836]

    add	w23,	w24,	w20
    str	w23,	[sp, #4340]

    ldr	x20,	[sp, fp]

    movz	fp,	#1108
    str	x20,	[sp, fp]

    movz	fp,	#1108
    ldr	x24,	[sp, fp]

    movz	fp,	#1100
    ldr	w20,	[x24]

    str	w20,	[sp, #1096]

    ldr	w24,	[sp, #1096]

    ldr	w22,	[sp, #4340]

    add	w23,	w22,	w24
    str	w23,	[sp, #2840]

    ldr	x20,	[sp, fp]

    movz	fp,	#1116
    add	x20,	x20,	#4
    str	x20,	[sp, fp]

    movz	fp,	#1116
    ldr	x24,	[sp, fp]

    movz	fp,	#1132
    ldr	w24,	[x24]

    str	w24,	[sp, #1124]

    ldr	w20,	[sp, #1124]

    ldr	w24,	[sp, #2840]

    add	w22,	w24,	w20
    ldr	x24,	[sp, fp]

    movz	fp,	#1140
    str	x24,	[sp, fp]

    movz	fp,	#1140
    ldr	x20,	[sp, fp]

    movz	fp,	#1132
    ldr	w24,	[x20]

    str	w24,	[sp, #1128]

    ldr	w20,	[sp, #1128]

    ldr	x24,	[sp, fp]

    add	w22,	w22,	w20
    movz	fp,	#1148
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1148
    ldr	x20,	[sp, fp]

    movz	fp,	#1164
    ldr	w20,	[x20]

    str	w20,	[sp, #1156]

    ldr	w20,	[sp, #1156]

    add	w28,	w22,	w20
    ldr	x20,	[sp, fp]

    movz	fp,	#1172
    str	x20,	[sp, fp]

    movz	fp,	#1172
    ldr	x20,	[sp, fp]

    movz	fp,	#1164
    ldr	w20,	[x20]

    str	w20,	[sp, #1160]

    ldr	w24,	[sp, #1160]

    ldr	x20,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1180
    add	x20,	x20,	#4
    str	x20,	[sp, fp]

    movz	fp,	#1180
    ldr	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	w20,	[x24]

    str	w20,	[sp, #1188]

    ldr	w24,	[sp, #1188]

    ldr	x20,	[sp, fp]

    add	w23,	w28,	w24
    movz	fp,	#1204
    str	x20,	[sp, fp]

    movz	fp,	#1204
    ldr	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	w24,	[x24]

    str	w24,	[sp, #1192]

    ldr	w20,	[sp, #1192]

    ldr	x24,	[sp, fp]

    add	w23,	w23,	w20
    movz	fp,	#1212
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1212
    ldr	x20,	[sp, fp]

    movz	fp,	#1228
    ldr	w24,	[x20]

    str	w24,	[sp, #1220]

    ldr	w20,	[sp, #1220]

    ldr	x24,	[sp, fp]

    add	w23,	w23,	w20
    movz	fp,	#1236
    str	x24,	[sp, fp]

    movz	fp,	#1236
    ldr	x20,	[sp, fp]

    movz	fp,	#1228
    ldr	w20,	[x20]

    str	w20,	[sp, #1224]

    ldr	w20,	[sp, #1224]

    add	w28,	w23,	w20
    ldr	x20,	[sp, fp]

    movz	fp,	#1244
    add	x20,	x20,	#4
    str	x20,	[sp, fp]

    movz	fp,	#1244
    ldr	x20,	[sp, fp]

    movz	fp,	#1260
    ldr	w20,	[x20]

    str	w20,	[sp, #1252]

    ldr	w24,	[sp, #1252]

    ldr	x20,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1268
    str	x20,	[sp, fp]

    movz	fp,	#1268
    ldr	x24,	[sp, fp]

    movz	fp,	#1260
    ldr	w20,	[x24]

    str	w20,	[sp, #1256]

    ldr	w24,	[sp, #1256]

    ldr	x20,	[sp, fp]

    add	w23,	w28,	w24
    add	x20,	x20,	#4
    str	x20,	[sp, #1288]

    ldr	x20,	[sp, #1288]

    ldr	w24,	[x20]

    str	w24,	[sp, #1284]

    ldr	w20,	[sp, #1284]

    add	w20,	w23,	w20
    str	w20,	[sp, #1276]

    ldr	x20,	[sp, #2616]

    ldr	w23,	[x20]

    ldr	w24,	[sp, #1276]

    add	w20,	w24,	w23
    ldr	x23,	[sp, #2616]

    add	x24,	x23,	#4
    ldr	w24,	[x24]

    add	w20,	w20,	w24
    ldr	x24,	[sp, #2600]

    ldr	w24,	[x24]

    add	w24,	w20,	w24
    str	w24,	[sp, #1280]

    ldr	x23,	[sp, #2600]

    add	x24,	x23,	#4
    ldr	w24,	[x24]

    ldr	w20,	[sp, #1280]

    add	w28,	w20,	w24
    mov	x24,	x18
    add	x18,	x18,	#4
    ldr	w20,	[x24]

    add	w22,	w28,	w20
    mov	x28,	x19
    ldr	w24,	[x18]

    ldr	w18,	[x27]

    add	w23,	w22,	w24
    mov	x22,	x25
    add	x24,	x27,	#4
    add	w23,	w23,	w18
    ldr	w27,	[x24]

    add	x18,	x25,	#4
    ldr	w24,	[x22]

    add	w27,	w23,	w27
    ldr	w22,	[x18]

    add	w20,	w27,	w24
    ldr	w24,	[x28]

    add	w25,	w20,	w22
    add	x20,	x19,	#4
    add	w28,	w25,	w24
    ldr	w22,	[x20]

    mov	x24,	x26
    add	x20,	x0,	#4
    add	x26,	x26,	#4
    add	w19,	w28,	w22
    ldr	w28,	[x24]

    ldr	w27,	[x26]

    add	w24,	w19,	w28
    ldr	x25,	[sp, #1504]

    ldr	w22,	[x25]

    add	w19,	w24,	w27
    add	w25,	w19,	w22
    ldr	x19,	[sp, #1504]

    add	x27,	x19,	#4
    ldr	w28,	[x27]

    ldr	x22,	[sp, #1512]

    add	w25,	w25,	w28
    ldr	w24,	[x22]

    add	w18,	w25,	w24
    ldr	x24,	[sp, #1512]

    add	x25,	x24,	#4
    ldr	w25,	[x25]

    add	w25,	w18,	w25
    mov	x18,	x0
    mov	x0,	x21
    ldr	w27,	[x18]

    add	x18,	x21,	#4
    ldr	w23,	[x20]

    add	w25,	w25,	w27
    ldr	w0,	[x0]

    ldr	w19,	[x18]

    add	w24,	w25,	w23
    add	w0,	w24,	w0
    add	w0,	w0,	w19
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#5808
    add	sp, sp, fp
    ret


main_109:
    ldr	w27,	[sp, #1480]

    movz	w6,	#1
    mov	w17,	w18
    ldr	w16,	[sp, #684]

    sub	w13,	w27,	#1
    movk	w6,	#15232,	lsl #16
    ldr	w4,	[sp, #496]

    mov	w12,	w13
    mov	w5,	w6
    add	w2,	w4,	w16
    str	w2,	[sp, #572]

    ldr	w20,	[sp, #572]

    sdiv	w11,	w20,	w6
    str	w11,	[sp, #568]

    mov	w11,	w1
    ldr	w16,	[sp, #568]

    ldr	w27,	[sp, #572]

    str	w12,	[sp, #1480]

    msub	w3,	w16,	w5,	w27

    mov	w2,	w3
    str	w2,	[sp, #684]

    ldr	w4,	[sp, #1476]

    str	w4,	[sp, #496]

    ldr	w21,	[sp, #1472]

    str	w21,	[sp, #1476]

    ldr	w15,	[sp, #500]

    str	w15,	[sp, #1472]

    ldr	w5,	[sp, #2764]

    str	w5,	[sp, #500]

    ldr	w25,	[sp, #480]

    str	w25,	[sp, #2764]

    ldr	w27,	[sp, #476]

    str	w27,	[sp, #480]

    ldr	w21,	[sp, #464]

    str	w21,	[sp, #476]

    ldr	w14,	[sp, #460]

    str	w14,	[sp, #464]

    ldr	w10,	[sp, #2772]

    str	w10,	[sp, #460]

    ldr	w5,	[sp, #456]

    str	w5,	[sp, #2772]

    ldr	w6,	[sp, #1460]

    str	w6,	[sp, #456]

    ldr	w5,	[sp, #576]

    mov	w0,	w5
    movz	w5,	#0
    str	w0,	[sp, #1460]

    ldr	w7,	[sp, #580]

    mov	w13,	w7
    str	w13,	[sp, #576]

    ldr	w12,	[sp, #2768]

    mov	w14,	w12
    str	w14,	[sp, #580]

    mov	w14,	w22
    ldr	w13,	[sp, #2596]

    mov	w22,	w5
    str	w13,	[sp, #2768]

    ldr	w0,	[sp, #2592]

    str	w0,	[sp, #2596]

    str	w17,	[sp, #2592]

    ldr	w16,	[sp, #2896]

    ldr	w3,	[sp, #2780]

    mov	w18,	w16
    str	w3,	[sp, #2896]

    ldr	w0,	[sp, #2776]

    str	w0,	[sp, #2780]

    ldr	w25,	[sp, #3024]

    str	w25,	[sp, #2776]

    str	w11,	[sp, #3024]

    ldr	w15,	[sp, #1576]

    ldr	w24,	[sp, #1560]

    mov	w1,	w15
    str	w24,	[sp, #1576]

    ldr	w4,	[sp, #1584]

    str	w4,	[sp, #1560]

    ldr	w0,	[sp, #1564]

    str	w0,	[sp, #1584]

    ldr	w8,	[sp, #1568]

    str	w8,	[sp, #1564]

    ldr	w12,	[sp, #1572]

    str	w12,	[sp, #1568]

    str	w14,	[sp, #1572]

    b	main_75

main_35:
    ldr	w7,	[sp, #1484]

    mov	w12,	w7
    b	main_36

