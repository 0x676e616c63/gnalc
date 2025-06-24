.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#5984
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1548]

    bl	getint
    str	w0,	[sp, #1552]

    bl	getint
    str	w0,	[sp, #1556]

    bl	getint
    str	w0,	[sp, #616]

    bl	getint
    str	w0,	[sp, #620]

    bl	getint
    str	w0,	[sp, #648]

    bl	getint
    str	w0,	[sp, #848]

    bl	getint
    str	w0,	[sp, #884]

    bl	getint
    str	w0,	[sp, #888]

    bl	getint
    str	w0,	[sp, #924]

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
    add	x14,	sp,	#36
    add	x7,	sp,	#16
    add	x20,	sp,	#28
    str	w0,	[sp, #1560]

    add	x22,	sp,	#20
    add	x11,	sp,	#44
    add	x16,	sp,	#24
    add	x25,	sp,	#32
    add	x17,	sp,	#48
    str	x7,	[sp, #1520]

    add	x7,	sp,	#40
    ldr	x10,	[sp, #1520]

    ldr	w4,	[sp, #1548]

    str	w4,	[x10]

    ldr	w9,	[sp, #1552]

    str	w9,	[x22]

    ldr	w23,	[sp, #1556]

    str	w23,	[x16]

    add	x23,	sp,	#52
    ldr	w6,	[sp, #616]

    str	w6,	[x20]

    ldr	w13,	[sp, #620]

    str	w13,	[x25]

    add	x13,	sp,	#56
    ldr	w9,	[sp, #648]

    str	w9,	[x14]

    str	x7,	[sp, #3568]

    ldr	w3,	[sp, #848]

    ldr	x26,	[sp, #3568]

    str	w3,	[x26]

    add	x26,	sp,	#72
    str	x11,	[sp, #3016]

    ldr	w5,	[sp, #884]

    ldr	x1,	[sp, #3016]

    str	w5,	[x1]

    add	x1,	sp,	#68
    str	x17,	[sp, #3024]

    ldr	w0,	[sp, #888]

    ldr	x6,	[sp, #3024]

    str	w0,	[x6]

    str	x23,	[sp, #3032]

    ldr	w27,	[sp, #924]

    ldr	x9,	[sp, #3032]

    str	w27,	[x9]

    add	x9,	sp,	#60
    str	x13,	[sp, #3008]

    movz	w13,	#0
    ldr	w7,	[sp, #928]

    mov	w4,	w13
    ldr	x17,	[sp, #3008]

    str	w7,	[x17]

    str	x9,	[sp, #3000]

    ldr	w5,	[sp, #964]

    ldr	x11,	[sp, #3000]

    str	w5,	[x11]

    add	x5,	sp,	#64
    str	x5,	[sp, #2992]

    ldr	w10,	[sp, #968]

    ldr	x6,	[sp, #2992]

    str	w10,	[x6]

    str	x1,	[sp, #2984]

    ldr	w9,	[sp, #1004]

    ldr	x2,	[sp, #2984]

    str	w9,	[x2]

    str	x26,	[sp, #2976]

    ldr	w6,	[sp, #1008]

    ldr	x27,	[sp, #2976]

    str	w6,	[x27]

    ldr	w19,	[sp, #1560]

    add	x6,	sp,	#76
    str	w19,	[x6]


main_36:
    add	w7,	w4,	#1
    str	w7,	[sp, #1544]

    ldr	w8,	[sp, #1544]

    cmp	w8,	#16
    bge	main_56

main_40:
    lsl	w5,	w4,	#2
    ldr	x4,	[sp, #1520]

    ldr	w28,	[sp, #1544]

    add	x4,	x4,	x5
    mov	w5,	w28

main_43:
    ldr	w0,	[x4]

    lsl	w23,	w5,	#2
    ldr	x12,	[sp, #1520]

    add	x21,	x12,	x23
    ldr	w17,	[x21]

    cmp	w0,	w17
    bge	main_51

main_49:
    str	w17,	[x4]

    str	w0,	[x21]


main_51:
    add	w21,	w5,	#1
    cmp	w21,	#16
    bge	main_56

main_42:
    mov	w5,	w21
    b	main_43

main_56:
    ldr	w0,	[sp, #1544]

    cmp	w0,	#15
    blt	main_35

main_58:
    ldr	x11,	[sp, #1520]

    ldr	w7,	[x11]

    str	w7,	[sp, #336]

    ldr	w1,	[x22]

    ldr	w10,	[x16]

    mov	w21,	w10
    ldr	w24,	[x20]

    ldr	w5,	[x25]

    ldr	w15,	[x14]

    ldr	x27,	[sp, #3568]

    ldr	w20,	[x27]

    mov	w2,	w20
    ldr	x18,	[sp, #3016]

    ldr	w4,	[x18]

    ldr	x28,	[sp, #3024]

    ldr	w3,	[x28]

    ldr	x11,	[sp, #3032]

    ldr	w0,	[x11]

    ldr	x23,	[sp, #3008]

    ldr	w17,	[x23]

    ldr	x19,	[sp, #3000]

    ldr	w7,	[x19]

    ldr	x14,	[sp, #2992]

    ldr	w27,	[x14]

    mov	w8,	w27
    ldr	x9,	[sp, #2984]

    ldr	w23,	[x9]

    mov	w9,	w0
    ldr	x22,	[sp, #2976]

    mov	w0,	w23
    ldr	w25,	[x22]

    mov	w22,	w4
    ldr	w12,	[x6]

    mov	w4,	w17
    mov	w23,	w12
    mov	w6,	w15
    ldr	w18,	[sp, #336]

    mov	w15,	w3
    mov	w16,	w18
    str	w16,	[sp, #1536]

    str	w1,	[sp, #716]

    mov	w1,	w24
    str	w21,	[sp, #1512]

    mov	w21,	w5
    str	w1,	[sp, #1532]

    str	w21,	[sp, #1528]

    str	w6,	[sp, #1516]

    str	w2,	[sp, #512]

    str	w22,	[sp, #508]

    str	w15,	[sp, #496]

    str	w9,	[sp, #492]

    str	w4,	[sp, #488]

    mov	w4,	w7
    str	w4,	[sp, #1964]

    mov	w4,	w25
    str	w8,	[sp, #2172]

    str	w0,	[sp, #484]

    str	w4,	[sp, #608]

    str	w23,	[sp, #612]

    ldr	w5,	[sp, #1548]

    mov	w12,	w5
    str	w12,	[sp, #3960]

    ldr	w9,	[sp, #1552]

    mov	w12,	w9
    str	w12,	[sp, #2200]

    ldr	w13,	[sp, #1556]

    mov	w10,	w13
    str	w10,	[sp, #1496]

    ldr	w28,	[sp, #616]

    mov	w4,	w28
    str	w4,	[sp, #3604]

    ldr	w19,	[sp, #620]

    mov	w27,	w19
    str	w27,	[sp, #3600]

    ldr	w10,	[sp, #648]

    mov	w23,	w10
    str	w23,	[sp, #3596]

    ldr	w26,	[sp, #848]

    mov	w28,	w26
    str	w28,	[sp, #2196]

    ldr	w12,	[sp, #884]

    mov	w8,	w12
    str	w8,	[sp, #3956]

    ldr	w1,	[sp, #888]

    mov	w0,	w1
    str	w0,	[sp, #3920]

    ldr	w19,	[sp, #924]

    mov	w17,	w19
    str	w17,	[sp, #3592]

    ldr	w19,	[sp, #928]

    mov	w20,	w19
    str	w20,	[sp, #1968]

    ldr	w19,	[sp, #964]

    mov	w16,	w19
    str	w16,	[sp, #1988]

    ldr	w4,	[sp, #968]

    ldr	w7,	[sp, #1004]

    mov	w19,	w4
    mov	w5,	w7
    str	w5,	[sp, #3136]

    ldr	w1,	[sp, #1008]

    ldr	w18,	[sp, #1560]

    mov	w4,	w1
    mov	w0,	w18
    str	w0,	[sp, #3140]


main_75:
    ldr	w24,	[sp, #1536]

    cmp	w24,	#0
    bne	main_109

main_113:
    add	x0,	sp,	#80
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    movz	w4,	#1
    movz	fp,	#476
    add	x19,	sp,	#80
    movz	w12,	#8848
    mov	w10,	w4
    mov	x25,	x19
    mov	w2,	w12
    str	x25,	[sp, fp]

    add	x21,	x19,	#4
    movz	fp,	#476
    ldr	w9,	[sp, #716]

    ldr	x24,	[sp, fp]

    str	w9,	[x24]

    str	w2,	[x21]


main_118:
    cmp	w10,	#25
    bge	main_218

main_121:
    lsl	w28,	w10,	#3
    sub	w25,	w10,	#1
    add	w14,	w10,	#1
    mov	x0,	x28
    add	x0,	sp,	x0
    lsl	w26,	w25,	#3
    sub	w4,	w14,	#1
    lsl	w9,	w14,	#3
    add	x0,	x0,	#80
    mov	x20,	x26
    mov	x10,	x9
    mov	x1,	x0
    lsl	w6,	w4,	#3
    add	x20,	sp,	x20
    add	x5,	x0,	#4
    add	x10,	sp,	x10
    add	x20,	x20,	#80
    add	x10,	x10,	#80
    mov	x19,	x20
    mov	x12,	x10
    add	x3,	x20,	#4
    add	x26,	x10,	#4
    ldr	w17,	[x3]

    mov	x3,	x6
    sub	w18,	w17,	#1
    add	x3,	sp,	x3
    str	w18,	[x1]

    add	x3,	x3,	#80
    ldr	w0,	[x19]

    sub	w1,	w0,	#2
    add	x11,	x3,	#4
    str	w1,	[x5]

    mov	x1,	x3
    ldr	w6,	[x11]

    sub	w7,	w6,	#1
    str	w7,	[x12]

    ldr	w16,	[x1]

    sub	w17,	w16,	#2
    str	w17,	[x26]

    add	w17,	w14,	#1
    add	w14,	w17,	#1
    sub	w21,	w17,	#1
    lsl	w26,	w17,	#3
    mov	x26,	x26
    add	w12,	w14,	#1
    sub	w5,	w14,	#1
    lsl	w8,	w14,	#3
    lsl	w23,	w21,	#3
    add	x26,	sp,	x26
    mov	x9,	x8
    add	w10,	w12,	#1
    sub	w22,	w12,	#1
    lsl	w25,	w12,	#3
    mov	x20,	x23
    add	x26,	x26,	#80
    lsl	w8,	w5,	#3
    add	x9,	sp,	x9
    sub	w12,	w10,	#1
    mov	x25,	x25
    add	x20,	sp,	x20
    add	x4,	x26,	#4
    mov	x28,	x26
    mov	x6,	x8
    add	x9,	x9,	#80
    add	x25,	sp,	x25
    add	x20,	x20,	#80
    lsl	w8,	w10,	#3
    add	x6,	sp,	x6
    add	x24,	x9,	#4
    mov	x11,	x9
    add	x25,	x25,	#80
    mov	x18,	x20
    add	x0,	x20,	#4
    mov	x7,	x8
    add	x6,	x6,	#80
    mov	x27,	x25
    add	x7,	sp,	x7
    mov	x3,	x6
    ldr	w13,	[x0]

    sub	w16,	w13,	#1
    add	x7,	x7,	#80
    mov	x9,	x7
    str	w16,	[x28]

    lsl	w28,	w22,	#3
    ldr	w0,	[x18]

    add	x18,	x6,	#4
    sub	w1,	w0,	#2
    add	w6,	w10,	#1
    str	w1,	[x4]

    ldr	w0,	[x18]

    sub	w1,	w0,	#1
    str	w1,	[x11]

    ldr	w16,	[x3]

    add	x3,	x25,	#4
    sub	w17,	w16,	#2
    lsl	w16,	w12,	#3
    mov	x14,	x16
    str	w17,	[x24]

    add	x14,	sp,	x14
    mov	x24,	x28
    sub	w28,	w6,	#1
    add	x24,	sp,	x24
    add	x14,	x14,	#80
    mov	x5,	x14
    add	x24,	x24,	#80
    add	x21,	x14,	#4
    mov	x20,	x24
    add	x0,	x24,	#4
    add	x24,	x7,	#4
    ldr	w17,	[x0]

    sub	w18,	w17,	#1
    str	w18,	[x27]

    ldr	w0,	[x20]

    sub	w2,	w0,	#2
    str	w2,	[x3]

    ldr	w2,	[x21]

    sub	w3,	w2,	#1
    lsl	w2,	w28,	#3
    mov	x2,	x2
    str	w3,	[x9]

    add	x2,	sp,	x2
    ldr	w17,	[x5]

    sub	w19,	w17,	#2
    add	x2,	x2,	#80
    str	w19,	[x24]

    add	x1,	x2,	#4
    lsl	w24,	w6,	#3
    mov	x22,	x24
    mov	x24,	x2
    add	x22,	sp,	x22
    ldr	w20,	[x1]

    sub	w21,	w20,	#1
    add	x22,	x22,	#80
    mov	x25,	x22
    str	w21,	[x25]

    add	x0,	x22,	#4
    ldr	w2,	[x24]

    sub	w4,	w2,	#2
    add	w2,	w6,	#1
    str	w4,	[x0]

    sub	w14,	w2,	#1
    lsl	w7,	w2,	#3
    mov	x5,	x7
    add	x5,	sp,	x5
    lsl	w18,	w14,	#3
    mov	x20,	x18
    add	x5,	x5,	#80
    add	x20,	sp,	x20
    mov	x7,	x5
    add	x20,	x20,	#80
    add	x22,	x5,	#4
    mov	x11,	x20
    add	x21,	x20,	#4
    add	w20,	w2,	#1
    mov	w10,	w20
    ldr	w8,	[x21]

    sub	w12,	w8,	#1
    str	w12,	[x7]

    ldr	w18,	[x11]

    sub	w19,	w18,	#2
    str	w19,	[x22]

    b	main_118

main_218:
    mov	w12,	w10

main_220:
    lsl	w24,	w12,	#3
    sub	w2,	w12,	#1
    add	w3,	w12,	#1
    mov	x23,	x24
    add	x23,	sp,	x23
    lsl	w0,	w2,	#3
    mov	x1,	x0
    add	x23,	x23,	#80
    add	x1,	sp,	x1
    mov	x26,	x23
    add	x1,	x1,	#80
    add	x7,	x23,	#4
    mov	x28,	x1
    add	x4,	x1,	#4
    ldr	w2,	[x4]

    sub	w5,	w2,	#1
    str	w5,	[x26]

    ldr	w0,	[x28]

    sub	w1,	w0,	#2
    str	w1,	[x7]

    cmp	w3,	#32
    blt	main_219

main_235:
    add	x0,	sp,	#88
    add	x24,	sp,	#96
    add	x20,	sp,	#104
    add	x25,	sp,	#112
    add	x28,	sp,	#120
    add	x19,	sp,	#128
    add	x23,	sp,	#136
    add	x21,	sp,	#144
    add	x27,	sp,	#160
    add	x22,	sp,	#168
    add	x18,	sp,	#184
    movz	fp,	#340
    str	x0,	[sp, #384]

    add	x0,	sp,	#152
    str	x25,	[sp, #1376]

    add	x25,	sp,	#224
    str	x28,	[sp, #1464]

    str	x19,	[sp, #1472]

    add	x19,	sp,	#208
    str	x23,	[sp, #1480]

    add	x23,	sp,	#216
    str	x21,	[sp, #1368]

    add	x21,	sp,	#264
    str	x0,	[sp, #1360]

    add	x0,	sp,	#176
    str	x27,	[sp, #1328]

    str	x22,	[sp, #1344]

    add	x22,	sp,	#240
    str	x0,	[sp, #1352]

    add	x0,	sp,	#192
    str	x18,	[sp, #1336]

    add	x18,	sp,	#232
    str	x0,	[sp, fp]

    movz	fp,	#444
    add	x0,	sp,	#200
    str	x0,	[sp, fp]

    add	x0,	sp,	#256
    movz	fp,	#452
    str	x19,	[sp, fp]

    add	x19,	sp,	#288
    movz	fp,	#348
    str	x23,	[sp, #424]

    add	x23,	sp,	#248
    str	x25,	[sp, #408]

    add	x25,	sp,	#304
    str	x18,	[sp, #432]

    add	x18,	sp,	#312
    str	x22,	[sp, fp]

    add	x22,	sp,	#320
    movz	fp,	#356
    str	x23,	[sp, fp]

    add	x23,	sp,	#296
    movz	fp,	#364
    str	x0,	[sp, fp]

    add	x0,	sp,	#272
    movz	fp,	#372
    str	x21,	[sp, fp]

    movz	fp,	#684
    mov	x21,	x24
    str	x0,	[sp, #536]

    add	x0,	sp,	#280
    str	x0,	[sp, #544]

    str	x19,	[sp, #552]

    str	x23,	[sp, #560]

    add	x23,	sp,	#328
    str	x25,	[sp, #568]

    str	x18,	[sp, #576]

    str	x22,	[sp, #584]

    str	x23,	[sp, #592]

    ldr	x0,	[sp, #384]

    str	x0,	[sp, #640]

    mov	x0,	x20
    str	x21,	[sp, fp]

    movz	fp,	#708
    str	x0,	[sp, fp]

    movz	fp,	#876
    ldr	x24,	[sp, #1376]

    str	x24,	[sp, #744]

    ldr	x28,	[sp, #1464]

    str	x28,	[sp, #776]

    ldr	x20,	[sp, #1472]

    str	x20,	[sp, #808]

    ldr	x24,	[sp, #1480]

    str	x24,	[sp, #840]

    ldr	x20,	[sp, #1368]

    str	x20,	[sp, fp]

    movz	fp,	#916
    ldr	x20,	[sp, #1360]

    str	x20,	[sp, fp]

    movz	fp,	#956
    ldr	x20,	[sp, #1328]

    str	x20,	[sp, fp]

    movz	fp,	#996
    ldr	x20,	[sp, #1344]

    str	x20,	[sp, fp]

    movz	fp,	#1036
    ldr	x20,	[sp, #1352]

    str	x20,	[sp, fp]

    movz	fp,	#1068
    ldr	x24,	[sp, #1336]

    str	x24,	[sp, fp]

    movz	fp,	#340
    ldr	x28,	[sp, fp]

    movz	fp,	#1100
    str	x28,	[sp, fp]

    movz	fp,	#444
    ldr	x20,	[sp, fp]

    movz	fp,	#1132
    str	x20,	[sp, fp]

    movz	fp,	#452
    ldr	x24,	[sp, fp]

    movz	fp,	#1164
    str	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	x28,	[sp, #424]

    str	x28,	[sp, fp]

    movz	fp,	#348
    ldr	x20,	[sp, #408]

    str	x20,	[sp, #1232]

    ldr	x24,	[sp, #432]

    str	x24,	[sp, #1264]

    ldr	x28,	[sp, fp]

    movz	fp,	#1292
    str	x28,	[sp, fp]

    movz	fp,	#356
    ldr	x24,	[sp, fp]

    movz	fp,	#364
    str	x24,	[sp, #1992]

    ldr	x20,	[sp, fp]

    movz	fp,	#2100
    str	x20,	[sp, fp]

    movz	fp,	#372
    ldr	x25,	[sp, fp]

    movz	fp,	#1564
    ldr	x21,	[sp, #536]

    mov	x28,	x25
    ldr	x27,	[sp, #544]

    mov	x25,	x21
    ldr	x22,	[sp, #552]

    mov	x18,	x27
    mov	x0,	x22
    ldr	x22,	[sp, #560]

    ldr	x19,	[sp, #568]

    mov	x26,	x22
    str	x19,	[sp, fp]

    movz	fp,	#476
    ldr	x20,	[sp, #576]

    str	x20,	[sp, #1576]

    ldr	x24,	[sp, #584]

    ldr	x21,	[sp, #592]

    mov	x19,	x24
    ldr	x23,	[sp, fp]

    mov	x24,	x21
    movz	fp,	#476
    str	x23,	[sp, #1584]

    ldr	x20,	[sp, #1584]

    ldr	w21,	[x20]

    str	w21,	[sp, #520]

    ldr	x22,	[sp, fp]

    movz	fp,	#652
    add	x21,	x22,	#4
    str	x21,	[sp, #624]

    ldr	x22,	[sp, #624]

    ldr	w21,	[x22]

    str	w21,	[sp, #632]

    ldr	w22,	[sp, #632]

    ldr	w23,	[sp, #520]

    add	w22,	w22,	w23
    str	w22,	[sp, #1540]

    ldr	x23,	[sp, #640]

    str	x23,	[sp, fp]

    movz	fp,	#652
    ldr	x21,	[sp, fp]

    movz	fp,	#660
    ldr	w21,	[x21]

    str	w21,	[sp, #636]

    ldr	w23,	[sp, #636]

    ldr	w21,	[sp, #1540]

    add	w20,	w21,	w23
    str	w20,	[sp, #516]

    ldr	x23,	[sp, #640]

    add	x23,	x23,	#4
    str	x23,	[sp, fp]

    movz	fp,	#660
    ldr	x21,	[sp, fp]

    movz	fp,	#684
    ldr	w23,	[x21]

    str	w23,	[sp, #668]

    ldr	w23,	[sp, #668]

    ldr	w21,	[sp, #516]

    add	w20,	w21,	w23
    str	w20,	[sp, #2972]

    ldr	x21,	[sp, fp]

    movz	fp,	#676
    str	x21,	[sp, fp]

    movz	fp,	#676
    ldr	x22,	[sp, fp]

    movz	fp,	#684
    ldr	w22,	[x22]

    str	w22,	[sp, #672]

    ldr	w21,	[sp, #672]

    ldr	w20,	[sp, #2972]

    add	w22,	w20,	w21
    str	w22,	[sp, #2868]

    ldr	x21,	[sp, fp]

    movz	fp,	#692
    add	x22,	x21,	#4
    str	x22,	[sp, fp]

    movz	fp,	#692
    ldr	x21,	[sp, fp]

    movz	fp,	#708
    ldr	w21,	[x21]

    str	w21,	[sp, #700]

    ldr	w22,	[sp, #700]

    ldr	w21,	[sp, #2868]

    add	w22,	w21,	w22
    str	w22,	[sp, #2968]

    ldr	x21,	[sp, fp]

    movz	fp,	#708
    str	x21,	[sp, #720]

    ldr	x21,	[sp, #720]

    ldr	w22,	[x21]

    str	w22,	[sp, #704]

    ldr	w21,	[sp, #704]

    ldr	w20,	[sp, #2968]

    add	w20,	w20,	w21
    str	w20,	[sp, #2872]

    ldr	x21,	[sp, fp]

    movz	fp,	#852
    add	x21,	x21,	#4
    str	x21,	[sp, #728]

    ldr	x22,	[sp, #728]

    ldr	w22,	[x22]

    str	w22,	[sp, #736]

    ldr	w21,	[sp, #736]

    ldr	w20,	[sp, #2872]

    add	w23,	w20,	w21
    str	w23,	[sp, #2964]

    ldr	x22,	[sp, #744]

    str	x22,	[sp, #752]

    ldr	x22,	[sp, #752]

    ldr	w22,	[x22]

    str	w22,	[sp, #740]

    ldr	w23,	[sp, #740]

    ldr	w21,	[sp, #2964]

    add	w21,	w21,	w23
    str	w21,	[sp, #2876]

    ldr	x23,	[sp, #744]

    add	x22,	x23,	#4
    str	x22,	[sp, #760]

    ldr	x23,	[sp, #760]

    ldr	w23,	[x23]

    str	w23,	[sp, #768]

    ldr	w22,	[sp, #768]

    ldr	w20,	[sp, #2876]

    add	w21,	w20,	w22
    str	w21,	[sp, #2960]

    ldr	x23,	[sp, #776]

    str	x23,	[sp, #784]

    ldr	x22,	[sp, #784]

    ldr	w22,	[x22]

    str	w22,	[sp, #772]

    ldr	w23,	[sp, #772]

    ldr	w22,	[sp, #2960]

    add	w21,	w22,	w23
    str	w21,	[sp, #2880]

    ldr	x23,	[sp, #776]

    add	x22,	x23,	#4
    str	x22,	[sp, #792]

    ldr	x23,	[sp, #792]

    ldr	w23,	[x23]

    str	w23,	[sp, #800]

    ldr	w22,	[sp, #800]

    ldr	w23,	[sp, #2880]

    add	w21,	w23,	w22
    str	w21,	[sp, #2956]

    ldr	x21,	[sp, #808]

    str	x21,	[sp, #816]

    ldr	x21,	[sp, #816]

    ldr	w21,	[x21]

    str	w21,	[sp, #804]

    ldr	w23,	[sp, #804]

    ldr	w22,	[sp, #2956]

    add	w23,	w22,	w23
    str	w23,	[sp, #2884]

    ldr	x23,	[sp, #808]

    add	x22,	x23,	#4
    str	x22,	[sp, #824]

    ldr	x23,	[sp, #824]

    ldr	w23,	[x23]

    str	w23,	[sp, #832]

    ldr	w22,	[sp, #832]

    ldr	w21,	[sp, #2884]

    add	w20,	w21,	w22
    str	w20,	[sp, #2952]

    ldr	x23,	[sp, #840]

    str	x23,	[sp, fp]

    movz	fp,	#852
    ldr	x22,	[sp, fp]

    movz	fp,	#860
    ldr	w22,	[x22]

    str	w22,	[sp, #836]

    ldr	w23,	[sp, #836]

    ldr	w20,	[sp, #2952]

    add	w22,	w20,	w23
    str	w22,	[sp, #2888]

    ldr	x23,	[sp, #840]

    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#860
    ldr	x23,	[sp, fp]

    movz	fp,	#876
    ldr	w23,	[x23]

    str	w23,	[sp, #868]

    ldr	w22,	[sp, #868]

    ldr	w20,	[sp, #2888]

    add	w22,	w20,	w22
    str	w22,	[sp, #2948]

    ldr	x23,	[sp, fp]

    movz	fp,	#892
    str	x23,	[sp, fp]

    movz	fp,	#892
    ldr	x22,	[sp, fp]

    movz	fp,	#876
    ldr	w22,	[x22]

    str	w22,	[sp, #872]

    ldr	w23,	[sp, #872]

    ldr	w21,	[sp, #2948]

    add	w20,	w21,	w23
    str	w20,	[sp, #2892]

    ldr	x23,	[sp, fp]

    movz	fp,	#900
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#900
    ldr	x23,	[sp, fp]

    movz	fp,	#916
    ldr	w23,	[x23]

    str	w23,	[sp, #908]

    ldr	w22,	[sp, #908]

    ldr	w20,	[sp, #2892]

    add	w23,	w20,	w22
    str	w23,	[sp, #2944]

    ldr	x23,	[sp, fp]

    movz	fp,	#932
    str	x23,	[sp, fp]

    movz	fp,	#932
    ldr	x22,	[sp, fp]

    movz	fp,	#916
    ldr	w22,	[x22]

    str	w22,	[sp, #912]

    ldr	w23,	[sp, #912]

    ldr	w22,	[sp, #2944]

    add	w21,	w22,	w23
    str	w21,	[sp, #2896]

    ldr	x23,	[sp, fp]

    movz	fp,	#940
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#940
    ldr	x23,	[sp, fp]

    movz	fp,	#956
    ldr	w23,	[x23]

    str	w23,	[sp, #948]

    ldr	w22,	[sp, #948]

    ldr	w23,	[sp, #2896]

    add	w21,	w23,	w22
    str	w21,	[sp, #2940]

    ldr	x23,	[sp, fp]

    movz	fp,	#972
    str	x23,	[sp, fp]

    movz	fp,	#972
    ldr	x22,	[sp, fp]

    movz	fp,	#956
    ldr	w22,	[x22]

    str	w22,	[sp, #952]

    ldr	w23,	[sp, #952]

    ldr	w22,	[sp, #2940]

    add	w21,	w22,	w23
    str	w21,	[sp, #2900]

    ldr	x23,	[sp, fp]

    movz	fp,	#980
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#980
    ldr	x23,	[sp, fp]

    movz	fp,	#996
    ldr	w23,	[x23]

    str	w23,	[sp, #988]

    ldr	w22,	[sp, #988]

    ldr	w21,	[sp, #2900]

    add	w21,	w21,	w22
    str	w21,	[sp, #2936]

    ldr	x23,	[sp, fp]

    movz	fp,	#1012
    str	x23,	[sp, fp]

    movz	fp,	#1012
    ldr	x22,	[sp, fp]

    movz	fp,	#996
    ldr	w22,	[x22]

    str	w22,	[sp, #992]

    ldr	w23,	[sp, #992]

    ldr	w20,	[sp, #2936]

    add	w23,	w20,	w23
    str	w23,	[sp, #2904]

    ldr	x23,	[sp, fp]

    movz	fp,	#1020
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1020
    ldr	x23,	[sp, fp]

    movz	fp,	#1036
    ldr	w23,	[x23]

    str	w23,	[sp, #1028]

    ldr	w22,	[sp, #1028]

    ldr	w20,	[sp, #2904]

    add	w20,	w20,	w22
    str	w20,	[sp, #2932]

    ldr	x21,	[sp, fp]

    movz	fp,	#1044
    str	x21,	[sp, fp]

    movz	fp,	#1044
    ldr	x21,	[sp, fp]

    movz	fp,	#1036
    ldr	w21,	[x21]

    str	w21,	[sp, #1032]

    ldr	w23,	[sp, #1032]

    ldr	w21,	[sp, #2932]

    add	w22,	w21,	w23
    str	w22,	[sp, #2908]

    ldr	x23,	[sp, fp]

    movz	fp,	#1052
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1052
    ldr	x23,	[sp, fp]

    movz	fp,	#1068
    ldr	w23,	[x23]

    str	w23,	[sp, #1060]

    ldr	w22,	[sp, #1060]

    ldr	w20,	[sp, #2908]

    add	w22,	w20,	w22
    str	w22,	[sp, #2928]

    ldr	x22,	[sp, fp]

    movz	fp,	#1076
    str	x22,	[sp, fp]

    movz	fp,	#1076
    ldr	x22,	[sp, fp]

    movz	fp,	#1068
    ldr	w22,	[x22]

    str	w22,	[sp, #1064]

    ldr	w23,	[sp, #1064]

    ldr	w22,	[sp, #2928]

    add	w20,	w22,	w23
    str	w20,	[sp, #2912]

    ldr	x23,	[sp, fp]

    movz	fp,	#1084
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1084
    ldr	x23,	[sp, fp]

    movz	fp,	#1100
    ldr	w23,	[x23]

    str	w23,	[sp, #1092]

    ldr	w22,	[sp, #1092]

    ldr	w23,	[sp, #2912]

    add	w23,	w23,	w22
    str	w23,	[sp, #2924]

    ldr	x23,	[sp, fp]

    movz	fp,	#1108
    str	x23,	[sp, fp]

    movz	fp,	#1108
    ldr	x22,	[sp, fp]

    movz	fp,	#1100
    ldr	w22,	[x22]

    str	w22,	[sp, #1096]

    ldr	w23,	[sp, #1096]

    ldr	w22,	[sp, #2924]

    add	w21,	w22,	w23
    str	w21,	[sp, #2916]

    ldr	x23,	[sp, fp]

    movz	fp,	#1116
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1116
    ldr	x23,	[sp, fp]

    movz	fp,	#1132
    ldr	w23,	[x23]

    str	w23,	[sp, #1124]

    ldr	w22,	[sp, #1124]

    ldr	w21,	[sp, #2916]

    add	w27,	w21,	w22
    ldr	x21,	[sp, fp]

    movz	fp,	#1140
    str	x21,	[sp, fp]

    movz	fp,	#1140
    ldr	x22,	[sp, fp]

    movz	fp,	#1132
    ldr	w22,	[x22]

    str	w22,	[sp, #1128]

    ldr	w21,	[sp, #1128]

    add	w21,	w27,	w21
    str	w21,	[sp, #2920]

    ldr	x23,	[sp, fp]

    movz	fp,	#1148
    add	x22,	x23,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1148
    ldr	x23,	[sp, fp]

    movz	fp,	#1164
    ldr	w23,	[x23]

    str	w23,	[sp, #1156]

    ldr	w22,	[sp, #1156]

    ldr	w20,	[sp, #2920]

    add	w23,	w20,	w22
    ldr	x22,	[sp, fp]

    movz	fp,	#1172
    str	x22,	[sp, fp]

    movz	fp,	#1172
    ldr	x22,	[sp, fp]

    movz	fp,	#1164
    ldr	w22,	[x22]

    str	w22,	[sp, #1160]

    ldr	w20,	[sp, #1160]

    add	w21,	w23,	w20
    ldr	x20,	[sp, fp]

    movz	fp,	#1180
    add	x23,	x20,	#4
    str	x23,	[sp, fp]

    movz	fp,	#1180
    ldr	x20,	[sp, fp]

    movz	fp,	#1196
    ldr	w20,	[x20]

    str	w20,	[sp, #1188]

    ldr	w23,	[sp, #1188]

    add	w27,	w21,	w23
    ldr	x23,	[sp, fp]

    movz	fp,	#1204
    str	x23,	[sp, fp]

    movz	fp,	#1204
    ldr	x22,	[sp, fp]

    movz	fp,	#1196
    ldr	w22,	[x22]

    str	w22,	[sp, #1192]

    ldr	w21,	[sp, #1192]

    ldr	x20,	[sp, fp]

    add	w21,	w27,	w21
    movz	fp,	#1212
    add	x23,	x20,	#4
    str	x23,	[sp, fp]

    movz	fp,	#1212
    ldr	x20,	[sp, fp]

    movz	fp,	#1292
    ldr	w20,	[x20]

    str	w20,	[sp, #1220]

    ldr	w23,	[sp, #1220]

    add	w27,	w21,	w23
    ldr	x21,	[sp, #1232]

    str	x21,	[sp, #1240]

    ldr	x22,	[sp, #1240]

    ldr	w22,	[x22]

    str	w22,	[sp, #1224]

    ldr	w21,	[sp, #1224]

    ldr	x20,	[sp, #1232]

    add	w21,	w27,	w21
    add	x23,	x20,	#4
    str	x23,	[sp, #1248]

    ldr	x20,	[sp, #1248]

    ldr	w20,	[x20]

    str	w20,	[sp, #1256]

    ldr	w23,	[sp, #1256]

    ldr	x22,	[sp, #1264]

    add	w20,	w21,	w23
    str	x22,	[sp, #1272]

    ldr	x23,	[sp, #1272]

    ldr	w23,	[x23]

    str	w23,	[sp, #1260]

    ldr	w22,	[sp, #1260]

    add	w20,	w20,	w22
    ldr	x22,	[sp, #1264]

    add	x23,	x22,	#4
    str	x23,	[sp, #1280]

    ldr	x22,	[sp, #1280]

    ldr	w22,	[x22]

    str	w22,	[sp, #1228]

    ldr	w23,	[sp, #1228]

    add	w20,	w20,	w23
    ldr	x23,	[sp, fp]

    movz	fp,	#1300
    str	x23,	[sp, fp]

    movz	fp,	#1300
    ldr	x23,	[sp, fp]

    movz	fp,	#1292
    ldr	w23,	[x23]

    str	w23,	[sp, #1288]

    ldr	w22,	[sp, #1288]

    add	w21,	w20,	w22
    ldr	x20,	[sp, fp]

    movz	fp,	#2100
    add	x20,	x20,	#4
    str	x20,	[sp, #1320]

    ldr	x23,	[sp, #1320]

    ldr	w23,	[x23]

    str	w23,	[sp, #1316]

    ldr	w20,	[sp, #1316]

    add	w23,	w21,	w20
    str	w23,	[sp, #1308]

    ldr	x23,	[sp, #1992]

    ldr	w23,	[x23]

    ldr	w22,	[sp, #1308]

    ldr	x21,	[sp, #1992]

    add	w27,	w22,	w23
    add	x22,	x21,	#4
    ldr	w23,	[x22]

    ldr	x20,	[sp, fp]

    add	w23,	w27,	w23
    movz	fp,	#2100
    ldr	w20,	[x20]

    add	w23,	w23,	w20
    str	w23,	[sp, #1312]

    ldr	x21,	[sp, fp]

    movz	fp,	#1564
    add	x21,	x21,	#4
    ldr	w23,	[x21]

    ldr	w20,	[sp, #1312]

    add	w21,	w20,	w23
    add	x23,	x28,	#4
    ldr	w20,	[x28]

    add	w21,	w21,	w20
    ldr	w20,	[x23]

    add	x23,	x25,	#4
    add	w22,	w21,	w20
    mov	x21,	x18
    mov	x20,	x25
    add	x18,	x18,	#4
    ldr	w27,	[x20]

    ldr	w28,	[x23]

    add	w27,	w22,	w27
    ldr	w25,	[x21]

    add	w27,	w27,	w28
    ldr	w28,	[x18]

    add	w20,	w27,	w25
    add	w27,	w20,	w28
    mov	x28,	x0
    ldr	w23,	[x28]

    add	w21,	w27,	w23
    add	x23,	x0,	#4
    ldr	w0,	[x23]

    mov	x23,	x19
    add	w21,	w21,	w0
    mov	x0,	x26
    ldr	w0,	[x0]

    add	w27,	w21,	w0
    add	x0,	x26,	#4
    ldr	w0,	[x0]

    ldr	x26,	[sp, fp]

    add	w0,	w27,	w0
    movz	fp,	#1564
    ldr	w22,	[x26]

    ldr	x26,	[sp, fp]

    add	w20,	w0,	w22
    add	x25,	x26,	#4
    ldr	w27,	[x25]

    add	w27,	w20,	w27
    ldr	x20,	[sp, #1576]

    ldr	w0,	[x20]

    add	w18,	w27,	w0
    ldr	x0,	[sp, #1576]

    add	x0,	x0,	#4
    ldr	w21,	[x0]

    ldr	w27,	[x23]

    add	w20,	w18,	w21
    add	x23,	x24,	#4
    add	x21,	x19,	#4
    add	w0,	w20,	w27
    ldr	w22,	[x21]

    add	w25,	w0,	w22
    mov	x0,	x24
    ldr	w0,	[x0]

    ldr	w24,	[x23]

    add	w20,	w25,	w0
    add	w0,	w20,	w24
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#5984
    add	sp, sp, fp
    ret


main_219:
    mov	w12,	w3
    b	main_220

main_109:
    ldr	w25,	[sp, #1536]

    ldr	w18,	[sp, #716]

    sub	w14,	w25,	#1
    ldr	w0,	[sp, #1512]

    add	w0,	w0,	w18
    str	w0,	[sp, #604]

    movz	w0,	#1
    movk	w0,	#15232,	lsl #16
    mov	w7,	w0
    mov	w10,	w7
    ldr	w0,	[sp, #604]

    sdiv	w26,	w0,	w7
    str	w26,	[sp, #600]

    mov	w26,	w14
    ldr	w25,	[sp, #600]

    ldr	w18,	[sp, #604]

    str	w26,	[sp, #1536]

    msub	w27,	w25,	w10,	w18

    mov	w8,	w27
    str	w8,	[sp, #716]

    ldr	w20,	[sp, #1532]

    mov	w1,	w20
    str	w1,	[sp, #1512]

    ldr	w15,	[sp, #1528]

    mov	w21,	w15
    str	w21,	[sp, #1532]

    ldr	w5,	[sp, #1516]

    mov	w16,	w5
    str	w16,	[sp, #1528]

    ldr	w24,	[sp, #512]

    mov	w6,	w24
    str	w6,	[sp, #1516]

    ldr	w20,	[sp, #508]

    mov	w25,	w20
    str	w25,	[sp, #512]

    ldr	w14,	[sp, #496]

    mov	w21,	w14
    str	w21,	[sp, #508]

    ldr	w10,	[sp, #492]

    mov	w15,	w10
    str	w15,	[sp, #496]

    ldr	w6,	[sp, #488]

    mov	w11,	w6
    str	w11,	[sp, #492]

    ldr	w6,	[sp, #1964]

    mov	w7,	w6
    str	w7,	[sp, #488]

    ldr	w10,	[sp, #2172]

    mov	w7,	w10
    str	w7,	[sp, #1964]

    ldr	w1,	[sp, #484]

    mov	w11,	w1
    str	w11,	[sp, #2172]

    ldr	w0,	[sp, #608]

    mov	w2,	w0
    str	w2,	[sp, #484]

    ldr	w1,	[sp, #612]

    mov	w17,	w1
    str	w17,	[sp, #608]

    ldr	w18,	[sp, #3960]

    mov	w8,	w18
    str	w8,	[sp, #612]

    movz	w8,	#0
    ldr	w14,	[sp, #2200]

    mov	w20,	w14
    str	w20,	[sp, #3960]

    ldr	w12,	[sp, #1496]

    mov	w15,	w12
    str	w15,	[sp, #2200]

    ldr	w2,	[sp, #3604]

    mov	w13,	w2
    mov	w2,	w8
    str	w13,	[sp, #1496]

    ldr	w27,	[sp, #3600]

    mov	w3,	w27
    str	w3,	[sp, #3604]

    ldr	w23,	[sp, #3596]

    mov	w28,	w23
    str	w28,	[sp, #3600]

    ldr	w18,	[sp, #2196]

    mov	w24,	w18
    str	w24,	[sp, #3596]

    ldr	w14,	[sp, #3956]

    mov	w20,	w14
    str	w20,	[sp, #2196]

    ldr	w6,	[sp, #3920]

    mov	w15,	w6
    str	w15,	[sp, #3956]

    ldr	w22,	[sp, #3592]

    mov	w7,	w22
    str	w7,	[sp, #3920]

    ldr	w23,	[sp, #1968]

    str	w23,	[sp, #3592]

    ldr	w18,	[sp, #1988]

    mov	w24,	w18
    str	w24,	[sp, #1968]

    str	w19,	[sp, #1988]

    ldr	w7,	[sp, #3136]

    mov	w19,	w7
    mov	w7,	w4
    str	w7,	[sp, #3136]

    ldr	w10,	[sp, #3140]

    str	w2,	[sp, #3140]

    mov	w4,	w10
    b	main_75

main_35:
    ldr	w1,	[sp, #1544]

    mov	w4,	w1
    b	main_36

