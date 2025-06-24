.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#4992
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1500]

    bl	getint
    str	w0,	[sp, #1504]

    bl	getint
    str	w0,	[sp, #1512]

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
    movz	w13,	#0
    add	x24,	sp,	#292
    add	x20,	sp,	#288
    add	x1,	sp,	#272
    add	x27,	sp,	#276
    add	x15,	sp,	#280
    str	w0,	[sp, #1520]

    add	x9,	sp,	#284
    add	x16,	sp,	#328
    add	x7,	sp,	#304
    movz	fp,	#2996
    add	x28,	sp,	#296
    str	x1,	[sp, #1472]

    ldr	x3,	[sp, #1472]

    ldr	w2,	[sp, #1500]

    str	w2,	[x3]

    add	x3,	sp,	#300
    ldr	w6,	[sp, #1504]

    str	w6,	[x27]

    ldr	w10,	[sp, #1512]

    str	w10,	[x15]

    ldr	w5,	[sp, #584]

    str	w5,	[x9]

    str	x20,	[sp, #4456]

    ldr	w11,	[sp, #588]

    ldr	x21,	[sp, #4456]

    str	w11,	[x21]

    add	x11,	sp,	#308
    str	x24,	[sp, #4464]

    add	x24,	sp,	#332
    ldr	w6,	[sp, #616]

    ldr	x25,	[sp, #4464]

    str	w6,	[x25]

    str	x28,	[sp, #3008]

    ldr	w22,	[sp, #816]

    ldr	x0,	[sp, #3008]

    str	w22,	[x0]

    str	x3,	[sp, #3016]

    add	x3,	sp,	#312
    ldr	w5,	[sp, #852]

    ldr	x4,	[sp, #3016]

    str	w5,	[x4]

    mov	w5,	w13
    str	x7,	[sp, #3024]

    ldr	w28,	[sp, #856]

    ldr	x8,	[sp, #3024]

    str	w28,	[x8]

    add	x28,	sp,	#324
    str	x11,	[sp, #3256]

    ldr	w22,	[sp, #892]

    ldr	x12,	[sp, #3256]

    str	w22,	[x12]

    add	x12,	sp,	#316
    str	x3,	[sp, fp]

    add	x3,	sp,	#320
    movz	fp,	#2996
    ldr	w10,	[sp, #896]

    ldr	x4,	[sp, fp]

    movz	fp,	#2988
    str	w10,	[x4]

    ldr	w0,	[sp, #932]

    str	w0,	[x12]

    str	x3,	[sp, fp]

    movz	fp,	#2988
    ldr	w3,	[sp, #936]

    ldr	x0,	[sp, fp]

    movz	fp,	#1628
    str	w3,	[x0]

    str	x28,	[sp, fp]

    movz	fp,	#1628
    ldr	w6,	[sp, #972]

    ldr	x1,	[sp, fp]

    movz	fp,	#1636
    str	w6,	[x1]

    ldr	w6,	[sp, #976]

    str	w6,	[x16]

    str	x24,	[sp, fp]

    movz	fp,	#1636
    ldr	w19,	[sp, #1520]

    ldr	x26,	[sp, fp]

    str	w19,	[x26]


main_36:
    add	w2,	w5,	#1
    str	w2,	[sp, #1496]

    ldr	w3,	[sp, #1496]

    cmp	w3,	#16
    bge	main_56

main_40:
    lsl	w8,	w5,	#2
    ldr	x3,	[sp, #1472]

    ldr	w1,	[sp, #1496]

    add	x18,	x3,	x8
    mov	w7,	w1

main_43:
    ldr	w0,	[x18]

    lsl	w17,	w7,	#2
    ldr	x4,	[sp, #1472]

    add	x20,	x4,	x17
    ldr	w24,	[x20]

    cmp	w0,	w24
    bge	main_51

main_49:
    str	w24,	[x18]

    str	w0,	[x20]


main_51:
    add	w22,	w7,	#1
    cmp	w22,	#16
    bge	main_56

main_42:
    mov	w7,	w22
    b	main_43

main_56:
    ldr	w3,	[sp, #1496]

    cmp	w3,	#15
    blt	main_35

main_58:
    ldr	x5,	[sp, #1472]

    movz	fp,	#2996
    ldr	w17,	[x5]

    str	w17,	[sp, #1372]

    ldr	w7,	[x27]

    str	w7,	[sp, #364]

    ldr	w11,	[x15]

    str	w11,	[sp, #1368]

    ldr	w24,	[x9]

    mov	w0,	w24
    ldr	x22,	[sp, #4456]

    ldr	w10,	[x22]

    ldr	x26,	[sp, #4464]

    ldr	w18,	[x26]

    ldr	x1,	[sp, #3008]

    ldr	w11,	[x1]

    mov	w28,	w11
    ldr	x5,	[sp, #3016]

    ldr	w6,	[x5]

    ldr	x9,	[sp, #3024]

    ldr	w17,	[x9]

    mov	w11,	w17
    ldr	x13,	[sp, #3256]

    ldr	w13,	[x13]

    ldr	x5,	[sp, fp]

    movz	fp,	#2988
    ldr	w15,	[x5]

    mov	w2,	w15
    ldr	w22,	[x12]

    ldr	x1,	[sp, fp]

    movz	fp,	#1628
    ldr	w27,	[x1]

    mov	w19,	w27
    ldr	x9,	[sp, fp]

    movz	fp,	#1636
    ldr	w12,	[x9]

    mov	w9,	w18
    ldr	w7,	[x16]

    mov	w4,	w7
    ldr	x5,	[sp, fp]

    ldr	w16,	[x5]

    ldr	w26,	[sp, #1372]

    mov	w3,	w26
    str	w3,	[sp, #1492]

    ldr	w14,	[sp, #364]

    mov	w3,	w14
    str	w3,	[sp, #684]

    ldr	w21,	[sp, #1368]

    mov	w20,	w21
    mov	w21,	w6
    str	w20,	[sp, #508]

    mov	w6,	w13
    mov	w20,	w10
    str	w0,	[sp, #1488]

    mov	w13,	w12
    str	w20,	[sp, #1484]

    mov	w20,	w22
    str	w9,	[sp, #1480]

    str	w28,	[sp, #492]

    str	w21,	[sp, #488]

    str	w11,	[sp, #476]

    str	w6,	[sp, #472]

    str	w2,	[sp, #468]

    str	w20,	[sp, #2812]

    str	w19,	[sp, #2664]

    str	w13,	[sp, #1552]

    str	w4,	[sp, #576]

    str	w16,	[sp, #580]

    ldr	w5,	[sp, #1500]

    mov	w15,	w5
    str	w15,	[sp, #3360]

    ldr	w9,	[sp, #1504]

    mov	w7,	w9
    str	w7,	[sp, #1624]

    ldr	w13,	[sp, #1512]

    mov	w21,	w13
    str	w21,	[sp, #2816]

    ldr	w6,	[sp, #584]

    mov	w4,	w6
    str	w4,	[sp, #3408]

    ldr	w27,	[sp, #588]

    mov	w19,	w27
    str	w19,	[sp, #3364]

    ldr	w11,	[sp, #616]

    mov	w23,	w11
    str	w23,	[sp, #3900]

    ldr	w11,	[sp, #816]

    mov	w25,	w11
    str	w25,	[sp, #2820]

    ldr	w7,	[sp, #852]

    mov	w11,	w7
    str	w11,	[sp, #3004]

    ldr	w16,	[sp, #856]

    ldr	w6,	[sp, #892]

    mov	w22,	w16
    mov	w0,	w6
    str	w0,	[sp, #2824]

    ldr	w6,	[sp, #896]

    mov	w26,	w6
    str	w26,	[sp, #1600]

    ldr	w16,	[sp, #932]

    mov	w4,	w16
    str	w4,	[sp, #1668]

    ldr	w15,	[sp, #936]

    mov	w21,	w15
    str	w21,	[sp, #1596]

    ldr	w5,	[sp, #972]

    mov	w0,	w5
    str	w0,	[sp, #1604]

    ldr	w17,	[sp, #976]

    mov	w27,	w17
    ldr	w17,	[sp, #1520]

    mov	w11,	w17

main_75:
    ldr	w21,	[sp, #1492]

    cmp	w21,	#0
    bne	main_109

main_113:
    add	x0,	sp,	#16
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    movz	w2,	#8848
    movz	fp,	#460
    add	x26,	sp,	#16
    add	x20,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#460
    ldr	w9,	[sp, #684]

    ldr	x1,	[sp, fp]

    str	w9,	[x1]

    movz	w9,	#1
    str	w2,	[x20]


main_118:
    cmp	w9,	#25
    bge	main_220

main_121:
    lsl	w28,	w9,	#3
    sub	w21,	w9,	#1
    add	w22,	w9,	#1
    mov	x27,	x28
    add	x27,	sp,	x27
    lsl	w23,	w21,	#3
    sub	w4,	w22,	#1
    add	w11,	w22,	#1
    lsl	w9,	w22,	#3
    add	x27,	x27,	#16
    mov	x16,	x23
    mov	x10,	x9
    lsl	w6,	w4,	#3
    sub	w22,	w11,	#1
    add	x7,	x27,	#4
    add	w23,	w11,	#1
    add	x16,	sp,	x16
    add	x10,	sp,	x10
    lsl	w24,	w22,	#3
    lsl	w8,	w23,	#3
    mov	x18,	x24
    add	x16,	x16,	#16
    add	x10,	x10,	#16
    add	x18,	sp,	x18
    mov	x17,	x16
    add	x26,	x16,	#4
    add	x18,	x18,	#16
    ldr	w12,	[x26]

    add	x28,	x18,	#4
    sub	w13,	w12,	#1
    str	w13,	[x27]

    add	x27,	x10,	#4
    ldr	w0,	[x17]

    sub	w1,	w0,	#2
    str	w1,	[x7]

    mov	x1,	x6
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    add	x9,	x1,	#4
    ldr	w4,	[x9]

    mov	x9,	x8
    sub	w5,	w4,	#1
    add	x9,	sp,	x9
    str	w5,	[x10]

    add	x9,	x9,	#16
    sub	w5,	w23,	#1
    ldr	w16,	[x1]

    sub	w17,	w16,	#2
    lsl	w8,	w5,	#3
    mov	x3,	x8
    str	w17,	[x27]

    add	x3,	sp,	x3
    ldr	w14,	[x28]

    lsl	w27,	w11,	#3
    sub	w17,	w14,	#1
    mov	x26,	x27
    add	x3,	x3,	#16
    add	x26,	sp,	x26
    add	x14,	x3,	#4
    add	x26,	x26,	#16
    add	x6,	x26,	#4
    str	w17,	[x26]

    add	x26,	x9,	#4
    ldr	w0,	[x18]

    sub	w1,	w0,	#2
    str	w1,	[x6]

    ldr	w0,	[x14]

    sub	w1,	w0,	#1
    str	w1,	[x9]

    add	w9,	w23,	#1
    ldr	w16,	[x3]

    sub	w17,	w16,	#2
    sub	w23,	w9,	#1
    str	w17,	[x26]

    lsl	w26,	w9,	#3
    lsl	w28,	w23,	#3
    mov	x25,	x26
    mov	x20,	x28
    add	x25,	sp,	x25
    add	x20,	sp,	x20
    add	x25,	x25,	#16
    add	x20,	x20,	#16
    add	x5,	x25,	#4
    add	x3,	x20,	#4
    ldr	w18,	[x3]

    sub	w19,	w18,	#1
    str	w19,	[x25]

    ldr	w0,	[x20]

    sub	w2,	w0,	#2
    str	w2,	[x5]

    add	w2,	w9,	#1
    add	w0,	w2,	#1
    sub	w11,	w2,	#1
    lsl	w9,	w2,	#3
    mov	x8,	x9
    sub	w27,	w0,	#1
    lsl	w14,	w11,	#3
    add	x8,	sp,	x8
    mov	x5,	x14
    add	x5,	sp,	x5
    lsl	w2,	w27,	#3
    add	x8,	x8,	#16
    mov	x23,	x2
    add	x5,	x5,	#16
    add	x23,	sp,	x23
    add	x25,	x8,	#4
    add	x19,	x5,	#4
    add	x23,	x23,	#16
    ldr	w4,	[x19]

    add	x2,	x23,	#4
    sub	w6,	w4,	#1
    str	w6,	[x8]

    ldr	w18,	[x5]

    sub	w20,	w18,	#2
    str	w20,	[x25]

    ldr	w20,	[x2]

    lsl	w25,	w0,	#3
    sub	w21,	w20,	#1
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    add	x2,	x24,	#4
    str	w21,	[x24]

    ldr	w3,	[x23]

    sub	w4,	w3,	#2
    str	w4,	[x2]

    add	w2,	w0,	#1
    add	w9,	w2,	#1
    sub	w13,	w2,	#1
    lsl	w8,	w2,	#3
    mov	x7,	x8
    lsl	w16,	w13,	#3
    add	x7,	sp,	x7
    mov	x11,	x16
    add	x11,	sp,	x11
    add	x7,	x7,	#16
    add	x11,	x11,	#16
    add	x24,	x7,	#4
    add	x20,	x11,	#4
    ldr	w6,	[x20]

    sub	w10,	w6,	#1
    str	w10,	[x7]

    ldr	w19,	[x11]

    sub	w20,	w19,	#2
    str	w20,	[x24]

    b	main_118

main_220:
    lsl	w24,	w9,	#3
    sub	w0,	w9,	#1
    mov	x23,	x24
    add	w9,	w9,	#1
    add	x23,	sp,	x23
    lsl	w2,	w0,	#3
    mov	x27,	x2
    add	x23,	x23,	#16
    add	x27,	sp,	x27
    add	x8,	x23,	#4
    add	x27,	x27,	#16
    mov	x28,	x27
    add	x1,	x27,	#4
    ldr	w26,	[x1]

    sub	w1,	w26,	#1
    str	w1,	[x23]

    ldr	w0,	[x28]

    sub	w1,	w0,	#2
    str	w1,	[x8]

    cmp	w9,	#32
    blt	main_220

main_235:
    add	x22,	sp,	#24
    add	x24,	sp,	#32
    add	x20,	sp,	#40
    movz	fp,	#412
    add	x0,	sp,	#48
    add	x19,	sp,	#56
    add	x23,	sp,	#72
    add	x27,	sp,	#80
    add	x25,	sp,	#96
    add	x18,	sp,	#104
    add	x21,	sp,	#112
    str	x20,	[sp, fp]

    movz	fp,	#372
    add	x20,	sp,	#64
    str	x0,	[sp, #1456]

    add	x0,	sp,	#88
    str	x19,	[sp, #1344]

    add	x19,	sp,	#144
    str	x20,	[sp, #1400]

    add	x20,	sp,	#200
    str	x23,	[sp, #1352]

    add	x23,	sp,	#176
    str	x27,	[sp, #1416]

    add	x27,	sp,	#120
    str	x0,	[sp, #1360]

    add	x0,	sp,	#128
    str	x25,	[sp, #1408]

    add	x25,	sp,	#152
    str	x18,	[sp, #1432]

    add	x18,	sp,	#168
    str	x21,	[sp, #1440]

    str	x27,	[sp, #1448]

    add	x27,	sp,	#136
    str	x0,	[sp, fp]

    add	x0,	sp,	#192
    movz	fp,	#380
    str	x27,	[sp, fp]

    add	x27,	sp,	#160
    movz	fp,	#388
    str	x19,	[sp, fp]

    add	x19,	sp,	#224
    movz	fp,	#396
    str	x25,	[sp, fp]

    add	x25,	sp,	#184
    movz	fp,	#404
    str	x27,	[sp, fp]

    add	x27,	sp,	#216
    movz	fp,	#420
    str	x18,	[sp, fp]

    add	x18,	sp,	#248
    movz	fp,	#428
    str	x23,	[sp, fp]

    add	x23,	sp,	#256
    movz	fp,	#436
    str	x25,	[sp, fp]

    add	x25,	sp,	#232
    movz	fp,	#444
    str	x0,	[sp, fp]

    add	x0,	sp,	#208
    movz	fp,	#340
    str	x20,	[sp, fp]

    movz	fp,	#348
    str	x0,	[sp, fp]

    movz	fp,	#356
    str	x27,	[sp, fp]

    movz	fp,	#644
    add	x27,	sp,	#240
    str	x19,	[sp, #520]

    str	x25,	[sp, #528]

    add	x25,	sp,	#264
    str	x27,	[sp, #536]

    str	x18,	[sp, #544]

    str	x23,	[sp, #552]

    mov	x23,	x22
    str	x25,	[sp, #560]

    str	x23,	[sp, #608]

    mov	x23,	x24
    str	x23,	[sp, fp]

    movz	fp,	#412
    ldr	x0,	[sp, fp]

    movz	fp,	#676
    str	x0,	[sp, fp]

    movz	fp,	#844
    ldr	x24,	[sp, #1456]

    str	x24,	[sp, #712]

    ldr	x28,	[sp, #1344]

    str	x28,	[sp, #744]

    ldr	x20,	[sp, #1400]

    str	x20,	[sp, #776]

    ldr	x24,	[sp, #1352]

    str	x24,	[sp, #808]

    ldr	x20,	[sp, #1416]

    str	x20,	[sp, fp]

    movz	fp,	#884
    ldr	x20,	[sp, #1360]

    str	x20,	[sp, fp]

    movz	fp,	#924
    ldr	x20,	[sp, #1408]

    str	x20,	[sp, fp]

    movz	fp,	#964
    ldr	x20,	[sp, #1432]

    str	x20,	[sp, fp]

    movz	fp,	#1004
    ldr	x20,	[sp, #1440]

    str	x20,	[sp, fp]

    movz	fp,	#1036
    ldr	x24,	[sp, #1448]

    str	x24,	[sp, fp]

    movz	fp,	#372
    ldr	x28,	[sp, fp]

    movz	fp,	#1068
    str	x28,	[sp, fp]

    movz	fp,	#380
    ldr	x20,	[sp, fp]

    movz	fp,	#1100
    str	x20,	[sp, fp]

    movz	fp,	#388
    ldr	x24,	[sp, fp]

    movz	fp,	#1132
    str	x24,	[sp, fp]

    movz	fp,	#396
    ldr	x28,	[sp, fp]

    movz	fp,	#1164
    str	x28,	[sp, fp]

    movz	fp,	#404
    ldr	x20,	[sp, fp]

    movz	fp,	#1196
    str	x20,	[sp, fp]

    movz	fp,	#420
    ldr	x24,	[sp, fp]

    movz	fp,	#428
    str	x24,	[sp, #1232]

    ldr	x28,	[sp, fp]

    movz	fp,	#1260
    str	x28,	[sp, fp]

    movz	fp,	#436
    ldr	x18,	[sp, fp]

    movz	fp,	#2684
    str	x18,	[sp, fp]

    movz	fp,	#444
    ldr	x25,	[sp, fp]

    movz	fp,	#2668
    str	x25,	[sp, fp]

    movz	fp,	#340
    ldr	x25,	[sp, fp]

    movz	fp,	#348
    mov	x21,	x25
    ldr	x22,	[sp, fp]

    movz	fp,	#356
    ldr	x27,	[sp, fp]

    movz	fp,	#1524
    ldr	x23,	[sp, #520]

    mov	x0,	x27
    mov	x18,	x23
    ldr	x23,	[sp, #528]

    ldr	x24,	[sp, #536]

    mov	x26,	x23
    str	x24,	[sp, fp]

    movz	fp,	#1532
    ldr	x28,	[sp, #544]

    str	x28,	[sp, fp]

    movz	fp,	#460
    ldr	x25,	[sp, #552]

    ldr	x24,	[sp, #560]

    mov	x19,	x25
    mov	x23,	x24
    ldr	x25,	[sp, fp]

    movz	fp,	#1540
    str	x25,	[sp, fp]

    movz	fp,	#1540
    ldr	x24,	[sp, fp]

    movz	fp,	#460
    ldr	w27,	[x24]

    str	w27,	[sp, #516]

    ldr	x27,	[sp, fp]

    movz	fp,	#620
    add	x20,	x27,	#4
    str	x20,	[sp, #592]

    ldr	x24,	[sp, #592]

    ldr	w20,	[x24]

    str	w20,	[sp, #600]

    ldr	w27,	[sp, #600]

    ldr	w20,	[sp, #516]

    add	w20,	w27,	w20
    str	w20,	[sp, #1548]

    ldr	x24,	[sp, #608]

    str	x24,	[sp, fp]

    movz	fp,	#620
    ldr	x20,	[sp, fp]

    movz	fp,	#628
    ldr	w20,	[x20]

    str	w20,	[sp, #604]

    ldr	w27,	[sp, #604]

    ldr	w24,	[sp, #1548]

    add	w24,	w24,	w27
    str	w24,	[sp, #512]

    ldr	x24,	[sp, #608]

    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#628
    ldr	x20,	[sp, fp]

    movz	fp,	#644
    ldr	w24,	[x20]

    str	w24,	[sp, #636]

    ldr	w20,	[sp, #636]

    ldr	w25,	[sp, #512]

    add	w24,	w25,	w20
    str	w24,	[sp, #1516]

    ldr	x20,	[sp, fp]

    movz	fp,	#652
    str	x20,	[sp, fp]

    movz	fp,	#652
    ldr	x24,	[sp, fp]

    movz	fp,	#644
    ldr	w24,	[x24]

    str	w24,	[sp, #640]

    ldr	w20,	[sp, #640]

    ldr	w27,	[sp, #1516]

    ldr	x24,	[sp, fp]

    add	w25,	w27,	w20
    movz	fp,	#660
    add	x27,	x24,	#4
    str	x27,	[sp, fp]

    movz	fp,	#660
    ldr	x24,	[sp, fp]

    movz	fp,	#676
    ldr	w24,	[x24]

    str	w24,	[sp, #668]

    ldr	w27,	[sp, #668]

    add	w27,	w25,	w27
    str	w27,	[sp, #1664]

    ldr	x20,	[sp, fp]

    movz	fp,	#676
    str	x20,	[sp, #688]

    ldr	x20,	[sp, #688]

    ldr	w24,	[x20]

    str	w24,	[sp, #672]

    ldr	w20,	[sp, #672]

    ldr	w27,	[sp, #1664]

    add	w25,	w27,	w20
    str	w25,	[sp, #2932]

    ldr	x20,	[sp, fp]

    movz	fp,	#820
    add	x20,	x20,	#4
    str	x20,	[sp, #696]

    ldr	x24,	[sp, #696]

    ldr	w24,	[x24]

    str	w24,	[sp, #704]

    ldr	w20,	[sp, #704]

    ldr	w25,	[sp, #2932]

    add	w24,	w25,	w20
    str	w24,	[sp, #1660]

    ldr	x24,	[sp, #712]

    str	x24,	[sp, #720]

    ldr	x24,	[sp, #720]

    ldr	w24,	[x24]

    str	w24,	[sp, #708]

    ldr	w24,	[sp, #708]

    ldr	w27,	[sp, #1660]

    add	w20,	w27,	w24
    str	w20,	[sp, #2936]

    ldr	x24,	[sp, #712]

    add	x24,	x24,	#4
    str	x24,	[sp, #728]

    ldr	x24,	[sp, #728]

    ldr	w24,	[x24]

    str	w24,	[sp, #736]

    ldr	w24,	[sp, #736]

    ldr	w20,	[sp, #2936]

    add	w25,	w20,	w24
    ldr	x24,	[sp, #744]

    str	x24,	[sp, #752]

    ldr	x24,	[sp, #752]

    ldr	w24,	[x24]

    str	w24,	[sp, #740]

    ldr	w27,	[sp, #740]

    add	w24,	w25,	w27
    str	w24,	[sp, #2940]

    ldr	x24,	[sp, #744]

    add	x24,	x24,	#4
    str	x24,	[sp, #760]

    ldr	x24,	[sp, #760]

    ldr	w24,	[x24]

    str	w24,	[sp, #768]

    ldr	w24,	[sp, #768]

    ldr	w27,	[sp, #2940]

    add	w24,	w27,	w24
    str	w24,	[sp, #1508]

    ldr	x20,	[sp, #776]

    str	x20,	[sp, #784]

    ldr	x20,	[sp, #784]

    ldr	w20,	[x20]

    str	w20,	[sp, #772]

    ldr	w24,	[sp, #772]

    ldr	w20,	[sp, #1508]

    add	w24,	w20,	w24
    str	w24,	[sp, #2944]

    ldr	x24,	[sp, #776]

    add	x24,	x24,	#4
    str	x24,	[sp, #792]

    ldr	x24,	[sp, #792]

    ldr	w24,	[x24]

    str	w24,	[sp, #800]

    ldr	w24,	[sp, #800]

    ldr	w27,	[sp, #2944]

    add	w20,	w27,	w24
    str	w20,	[sp, #1656]

    ldr	x24,	[sp, #808]

    str	x24,	[sp, fp]

    movz	fp,	#820
    ldr	x24,	[sp, fp]

    movz	fp,	#828
    ldr	w24,	[x24]

    str	w24,	[sp, #804]

    ldr	w24,	[sp, #804]

    ldr	w20,	[sp, #1656]

    add	w27,	w20,	w24
    str	w27,	[sp, #2948]

    ldr	x24,	[sp, #808]

    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#828
    ldr	x24,	[sp, fp]

    movz	fp,	#844
    ldr	w24,	[x24]

    str	w24,	[sp, #836]

    ldr	w24,	[sp, #836]

    ldr	w20,	[sp, #2948]

    add	w25,	w20,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#860
    str	x24,	[sp, fp]

    movz	fp,	#860
    ldr	x24,	[sp, fp]

    movz	fp,	#844
    ldr	w24,	[x24]

    str	w24,	[sp, #840]

    ldr	w27,	[sp, #840]

    add	w25,	w25,	w27
    str	w25,	[sp, #2952]

    ldr	x24,	[sp, fp]

    movz	fp,	#868
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#868
    ldr	x24,	[sp, fp]

    movz	fp,	#884
    ldr	w24,	[x24]

    str	w24,	[sp, #876]

    ldr	w24,	[sp, #876]

    ldr	w20,	[sp, #2952]

    add	w25,	w20,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#900
    str	x24,	[sp, fp]

    movz	fp,	#900
    ldr	x24,	[sp, fp]

    movz	fp,	#884
    ldr	w24,	[x24]

    str	w24,	[sp, #880]

    ldr	w27,	[sp, #880]

    add	w20,	w25,	w27
    str	w20,	[sp, #2956]

    ldr	x24,	[sp, fp]

    movz	fp,	#908
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#908
    ldr	x24,	[sp, fp]

    movz	fp,	#924
    ldr	w24,	[x24]

    str	w24,	[sp, #916]

    ldr	w24,	[sp, #916]

    ldr	w27,	[sp, #2956]

    add	w25,	w27,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#940
    str	x24,	[sp, fp]

    movz	fp,	#940
    ldr	x24,	[sp, fp]

    movz	fp,	#924
    ldr	w24,	[x24]

    str	w24,	[sp, #920]

    ldr	w27,	[sp, #920]

    add	w24,	w25,	w27
    str	w24,	[sp, #2960]

    ldr	x24,	[sp, fp]

    movz	fp,	#948
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#948
    ldr	x24,	[sp, fp]

    movz	fp,	#964
    ldr	w24,	[x24]

    str	w24,	[sp, #956]

    ldr	w24,	[sp, #956]

    ldr	w27,	[sp, #2960]

    add	w25,	w27,	w24
    str	w25,	[sp, #1616]

    ldr	x24,	[sp, fp]

    movz	fp,	#980
    str	x24,	[sp, fp]

    movz	fp,	#980
    ldr	x24,	[sp, fp]

    movz	fp,	#964
    ldr	w24,	[x24]

    str	w24,	[sp, #960]

    ldr	w24,	[sp, #960]

    ldr	w27,	[sp, #1616]

    add	w24,	w27,	w24
    str	w24,	[sp, #2964]

    ldr	x24,	[sp, fp]

    movz	fp,	#988
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#988
    ldr	x24,	[sp, fp]

    movz	fp,	#1004
    ldr	w24,	[x24]

    str	w24,	[sp, #996]

    ldr	w24,	[sp, #996]

    ldr	w20,	[sp, #2964]

    add	w27,	w20,	w24
    str	w27,	[sp, #1652]

    ldr	x20,	[sp, fp]

    movz	fp,	#1012
    str	x20,	[sp, fp]

    movz	fp,	#1012
    ldr	x20,	[sp, fp]

    movz	fp,	#1004
    ldr	w20,	[x20]

    str	w20,	[sp, #1000]

    ldr	w24,	[sp, #1000]

    ldr	w27,	[sp, #1652]

    add	w27,	w27,	w24
    str	w27,	[sp, #2968]

    ldr	x24,	[sp, fp]

    movz	fp,	#1020
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1020
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x24]

    str	w24,	[sp, #1028]

    ldr	w24,	[sp, #1028]

    ldr	w20,	[sp, #2968]

    add	w24,	w20,	w24
    str	w24,	[sp, #2984]

    ldr	x24,	[sp, fp]

    movz	fp,	#1044
    str	x24,	[sp, fp]

    movz	fp,	#1044
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x24]

    str	w24,	[sp, #1032]

    ldr	w24,	[sp, #1032]

    ldr	w20,	[sp, #2984]

    add	w25,	w20,	w24
    str	w25,	[sp, #2972]

    ldr	x24,	[sp, fp]

    movz	fp,	#1052
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1052
    ldr	x24,	[sp, fp]

    movz	fp,	#1068
    ldr	w24,	[x24]

    str	w24,	[sp, #1060]

    ldr	w24,	[sp, #1060]

    ldr	w27,	[sp, #2972]

    add	w25,	w27,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1076
    str	x24,	[sp, fp]

    movz	fp,	#1076
    ldr	x24,	[sp, fp]

    movz	fp,	#1068
    ldr	w24,	[x24]

    str	w24,	[sp, #1064]

    ldr	w27,	[sp, #1064]

    add	w20,	w25,	w27
    str	w20,	[sp, #2976]

    ldr	x24,	[sp, fp]

    movz	fp,	#1084
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1084
    ldr	x24,	[sp, fp]

    movz	fp,	#1100
    ldr	w24,	[x24]

    str	w24,	[sp, #1092]

    ldr	w24,	[sp, #1092]

    ldr	w27,	[sp, #2976]

    ldr	x20,	[sp, fp]

    add	w25,	w27,	w24
    movz	fp,	#1108
    str	x20,	[sp, fp]

    movz	fp,	#1108
    ldr	x20,	[sp, fp]

    movz	fp,	#1100
    ldr	w20,	[x20]

    str	w20,	[sp, #1096]

    ldr	w27,	[sp, #1096]

    add	w24,	w25,	w27
    str	w24,	[sp, #2980]

    ldr	x24,	[sp, fp]

    movz	fp,	#1116
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1116
    ldr	x24,	[sp, fp]

    movz	fp,	#1132
    ldr	w24,	[x24]

    str	w24,	[sp, #1124]

    ldr	w24,	[sp, #1124]

    ldr	w20,	[sp, #2980]

    add	w25,	w20,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1140
    str	x24,	[sp, fp]

    movz	fp,	#1140
    ldr	x24,	[sp, fp]

    movz	fp,	#1132
    ldr	w24,	[x24]

    str	w24,	[sp, #1128]

    ldr	w27,	[sp, #1128]

    add	w25,	w25,	w27
    ldr	x27,	[sp, fp]

    movz	fp,	#1148
    add	x24,	x27,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1148
    ldr	x27,	[sp, fp]

    movz	fp,	#1164
    ldr	w27,	[x27]

    str	w27,	[sp, #1156]

    ldr	w24,	[sp, #1156]

    add	w25,	w25,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1172
    str	x24,	[sp, fp]

    movz	fp,	#1172
    ldr	x24,	[sp, fp]

    movz	fp,	#1164
    ldr	w24,	[x24]

    str	w24,	[sp, #1160]

    ldr	w27,	[sp, #1160]

    add	w25,	w25,	w27
    ldr	x27,	[sp, fp]

    movz	fp,	#1180
    add	x24,	x27,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1180
    ldr	x27,	[sp, fp]

    movz	fp,	#1196
    ldr	w27,	[x27]

    str	w27,	[sp, #1188]

    ldr	w24,	[sp, #1188]

    ldr	x20,	[sp, fp]

    add	w25,	w25,	w24
    movz	fp,	#1204
    str	x20,	[sp, fp]

    movz	fp,	#1204
    ldr	x20,	[sp, fp]

    movz	fp,	#1196
    ldr	w20,	[x20]

    str	w20,	[sp, #1192]

    ldr	w27,	[sp, #1192]

    add	w27,	w25,	w27
    ldr	x25,	[sp, fp]

    movz	fp,	#1260
    add	x24,	x25,	#4
    str	x24,	[sp, #1216]

    ldr	x25,	[sp, #1216]

    ldr	w25,	[x25]

    str	w25,	[sp, #1224]

    ldr	w24,	[sp, #1224]

    add	w20,	w27,	w24
    ldr	x24,	[sp, #1232]

    str	x24,	[sp, #1240]

    ldr	x25,	[sp, #1240]

    ldr	w25,	[x25]

    str	w25,	[sp, #1228]

    ldr	w27,	[sp, #1228]

    add	w20,	w20,	w27
    ldr	x27,	[sp, #1232]

    add	x25,	x27,	#4
    str	x25,	[sp, #1248]

    ldr	x27,	[sp, #1248]

    ldr	w27,	[x27]

    str	w27,	[sp, #1212]

    ldr	w25,	[sp, #1212]

    ldr	x24,	[sp, fp]

    add	w20,	w20,	w25
    movz	fp,	#1268
    str	x24,	[sp, fp]

    movz	fp,	#1268
    ldr	x25,	[sp, fp]

    movz	fp,	#1260
    ldr	w25,	[x25]

    str	w25,	[sp, #1256]

    ldr	w27,	[sp, #1256]

    add	w20,	w20,	w27
    ldr	x27,	[sp, fp]

    movz	fp,	#2684
    add	x27,	x27,	#4
    str	x27,	[sp, #1288]

    ldr	x27,	[sp, #1288]

    ldr	w27,	[x27]

    str	w27,	[sp, #1284]

    ldr	w27,	[sp, #1284]

    add	w24,	w20,	w27
    str	w24,	[sp, #1276]

    ldr	x24,	[sp, fp]

    movz	fp,	#2684
    ldr	w24,	[x24]

    ldr	w27,	[sp, #1276]

    ldr	x25,	[sp, fp]

    add	w28,	w27,	w24
    movz	fp,	#2668
    add	x25,	x25,	#4
    ldr	w24,	[x25]

    ldr	x20,	[sp, fp]

    add	w27,	w28,	w24
    movz	fp,	#2668
    ldr	w25,	[x20]

    add	w24,	w27,	w25
    add	x25,	x21,	#4
    str	w24,	[sp, #1280]

    ldr	x24,	[sp, fp]

    movz	fp,	#1524
    add	x24,	x24,	#4
    ldr	w24,	[x24]

    ldr	w20,	[sp, #1280]

    add	w24,	w20,	w24
    ldr	w20,	[x21]

    mov	x21,	x0
    add	w24,	w24,	w20
    add	x0,	x0,	#4
    ldr	w20,	[x25]

    add	w24,	w24,	w20
    mov	x20,	x22
    ldr	w25,	[x20]

    add	w27,	w24,	w25
    add	x25,	x22,	#4
    ldr	w28,	[x25]

    ldr	w25,	[x21]

    add	w27,	w27,	w28
    ldr	w28,	[x0]

    add	w20,	w27,	w25
    ldr	w27,	[x18]

    add	w24,	w20,	w28
    add	w21,	w24,	w27
    add	x24,	x18,	#4
    add	x18,	x26,	#4
    ldr	w0,	[x24]

    add	w25,	w21,	w0
    mov	x0,	x26
    ldr	w0,	[x0]

    add	w27,	w25,	w0
    ldr	w0,	[x18]

    ldr	x26,	[sp, fp]

    add	w0,	w27,	w0
    movz	fp,	#1524
    ldr	w22,	[x26]

    ldr	x24,	[sp, fp]

    add	w20,	w0,	w22
    movz	fp,	#1532
    add	x25,	x24,	#4
    mov	x24,	x19
    ldr	w27,	[x25]

    add	w27,	w20,	w27
    ldr	x20,	[sp, fp]

    movz	fp,	#1532
    ldr	w0,	[x20]

    add	w20,	w27,	w0
    ldr	x0,	[sp, fp]

    add	x0,	x0,	#4
    ldr	w21,	[x0]

    ldr	w27,	[x24]

    add	w20,	w20,	w21
    add	x21,	x19,	#4
    add	w0,	w20,	w27
    ldr	w24,	[x21]

    add	w25,	w0,	w24
    mov	x0,	x23
    add	x23,	x23,	#4
    ldr	w0,	[x0]

    add	w20,	w25,	w0
    ldr	w24,	[x23]

    add	w0,	w20,	w24
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#4992
    add	sp, sp, fp
    ret


main_109:
    ldr	w23,	[sp, #1492]

    movz	w15,	#1
    ldr	w5,	[sp, #684]

    sub	w17,	w23,	#1
    movk	w15,	#15232,	lsl #16
    ldr	w3,	[sp, #508]

    mov	w25,	w17
    mov	w7,	w15
    add	w20,	w3,	w5
    mov	w15,	w7
    str	w20,	[sp, #572]

    ldr	w21,	[sp, #572]

    sdiv	w19,	w21,	w7
    str	w19,	[sp, #568]

    ldr	w6,	[sp, #568]

    ldr	w13,	[sp, #572]

    str	w25,	[sp, #1492]

    msub	w6,	w6,	w15,	w13

    str	w6,	[sp, #684]

    ldr	w17,	[sp, #1488]

    mov	w2,	w17
    str	w2,	[sp, #508]

    ldr	w14,	[sp, #1484]

    mov	w18,	w14
    str	w18,	[sp, #1488]

    ldr	w9,	[sp, #1480]

    mov	w15,	w9
    str	w15,	[sp, #1484]

    ldr	w21,	[sp, #492]

    mov	w10,	w21
    str	w10,	[sp, #1480]

    ldr	w17,	[sp, #488]

    mov	w23,	w17
    str	w23,	[sp, #492]

    ldr	w12,	[sp, #476]

    mov	w18,	w12
    str	w18,	[sp, #488]

    ldr	w7,	[sp, #472]

    mov	w13,	w7
    str	w13,	[sp, #476]

    mov	w13,	w22
    ldr	w2,	[sp, #468]

    mov	w8,	w2
    str	w8,	[sp, #472]

    ldr	w19,	[sp, #2812]

    mov	w3,	w19
    str	w3,	[sp, #468]

    ldr	w18,	[sp, #2664]

    mov	w20,	w18
    str	w20,	[sp, #2812]

    ldr	w14,	[sp, #1552]

    mov	w19,	w14
    str	w19,	[sp, #2664]

    ldr	w23,	[sp, #576]

    mov	w15,	w23
    str	w15,	[sp, #1552]

    ldr	w6,	[sp, #580]

    mov	w7,	w6
    str	w7,	[sp, #576]

    ldr	w16,	[sp, #3360]

    mov	w17,	w16
    str	w17,	[sp, #580]

    ldr	w8,	[sp, #1624]

    mov	w17,	w8
    str	w17,	[sp, #3360]

    ldr	w24,	[sp, #2816]

    mov	w9,	w24
    str	w9,	[sp, #1624]

    movz	w9,	#0
    ldr	w5,	[sp, #3408]

    mov	w25,	w5
    str	w25,	[sp, #2816]

    ldr	w20,	[sp, #3364]

    mov	w6,	w20
    str	w6,	[sp, #3408]

    ldr	w24,	[sp, #3900]

    mov	w21,	w24
    str	w21,	[sp, #3364]

    ldr	w0,	[sp, #2820]

    mov	w25,	w0
    str	w25,	[sp, #3900]

    ldr	w12,	[sp, #3004]

    mov	w1,	w12
    str	w1,	[sp, #2820]

    str	w13,	[sp, #3004]

    ldr	w1,	[sp, #2824]

    ldr	w0,	[sp, #1600]

    mov	w22,	w1
    mov	w2,	w0
    str	w2,	[sp, #2824]

    mov	w2,	w27
    ldr	w5,	[sp, #1668]

    mov	w27,	w11
    mov	w1,	w5
    mov	w11,	w9
    str	w1,	[sp, #1600]

    ldr	w24,	[sp, #1596]

    mov	w6,	w24
    str	w6,	[sp, #1668]

    ldr	w1,	[sp, #1604]

    mov	w25,	w1
    str	w25,	[sp, #1596]

    str	w2,	[sp, #1604]

    b	main_75

main_35:
    ldr	w3,	[sp, #1496]

    mov	w5,	w3
    b	main_36

