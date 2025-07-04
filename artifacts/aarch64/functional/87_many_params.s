.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#5952
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1480]

    bl	getint
    str	w0,	[sp, #1484]

    bl	getint
    str	w0,	[sp, #1488]

    bl	getint
    str	w0,	[sp, #576]

    bl	getint
    str	w0,	[sp, #580]

    bl	getint
    str	w0,	[sp, #608]

    bl	getint
    str	w0,	[sp, #808]

    bl	getint
    str	w0,	[sp, #844]

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
    str	w0,	[sp, #972]

    bl	getint
    str	w0,	[sp, #976]

    bl	getint
    add	x21,	sp,	#36
    add	x24,	sp,	#28
    str	w0,	[sp, #1496]

    add	x17,	sp,	#60
    movz	fp,	#1452
    add	x15,	sp,	#20
    add	x10,	sp,	#44
    add	x14,	sp,	#48
    add	x27,	sp,	#76
    add	x9,	sp,	#52
    add	x0,	sp,	#16
    str	x0,	[sp, fp]

    movz	fp,	#1452
    ldr	x4,	[sp, fp]

    movz	fp,	#4340
    ldr	w1,	[sp, #1480]

    str	w1,	[x4]

    add	x4,	sp,	#24
    add	x1,	sp,	#32
    ldr	w5,	[sp, #1484]

    str	w5,	[x15]

    add	x5,	sp,	#40
    ldr	w11,	[sp, #1488]

    str	w11,	[x4]

    ldr	w7,	[sp, #576]

    str	w7,	[x24]

    ldr	w12,	[sp, #580]

    str	w12,	[x1]

    ldr	w8,	[sp, #608]

    str	w8,	[x21]

    str	x5,	[sp, fp]

    movz	fp,	#4340
    ldr	w26,	[sp, #808]

    ldr	x23,	[sp, fp]

    movz	fp,	#4348
    str	w26,	[x23]

    add	x26,	sp,	#56
    str	x10,	[sp, fp]

    movz	fp,	#4348
    ldr	w3,	[sp, #844]

    ldr	x2,	[sp, fp]

    movz	fp,	#4356
    str	w3,	[x2]

    str	x14,	[sp, fp]

    movz	fp,	#4356
    ldr	w7,	[sp, #848]

    ldr	x2,	[sp, fp]

    movz	fp,	#3004
    str	w7,	[x2]

    ldr	w8,	[sp, #884]

    str	w8,	[x9]

    str	x26,	[sp, fp]

    movz	fp,	#3004
    ldr	w12,	[sp, #888]

    ldr	x0,	[sp, fp]

    movz	fp,	#2996
    str	w12,	[x0]

    add	x0,	sp,	#72
    add	x12,	sp,	#64
    str	x17,	[sp, fp]

    movz	fp,	#2996
    ldr	w5,	[sp, #924]

    ldr	x25,	[sp, fp]

    movz	fp,	#2988
    str	w5,	[x25]

    str	x12,	[sp, fp]

    movz	fp,	#2988
    ldr	w7,	[sp, #928]

    ldr	x13,	[sp, fp]

    movz	fp,	#2980
    str	w7,	[x13]

    add	x7,	sp,	#68
    str	x7,	[sp, fp]

    movz	fp,	#2980
    ldr	w11,	[sp, #972]

    ldr	x8,	[sp, fp]

    movz	fp,	#2972
    str	w11,	[x8]

    str	x0,	[sp, fp]

    movz	fp,	#2972
    ldr	w13,	[sp, #976]

    ldr	x2,	[sp, fp]

    str	w13,	[x2]

    movz	w13,	#0
    ldr	w23,	[sp, #1496]

    mov	w3,	w13
    str	w23,	[x27]


main_36:
    add	w8,	w3,	#1
    str	w8,	[sp, #1476]

    ldr	w10,	[sp, #1476]

    cmp	w10,	#16
    bge	main_56

main_40:
    lsl	w7,	w3,	#2
    movz	fp,	#1452
    ldr	x2,	[sp, fp]

    add	x10,	x2,	x7
    ldr	w2,	[sp, #1476]

    mov	w11,	w2

main_43:
    ldr	w0,	[x10]

    lsl	w13,	w11,	#2
    movz	fp,	#1452
    ldr	x3,	[sp, fp]

    add	x14,	x3,	x13
    ldr	w26,	[x14]

    cmp	w0,	w26
    bge	main_51

main_49:
    str	w26,	[x10]

    str	w0,	[x14]


main_51:
    add	w2,	w11,	#1
    cmp	w2,	#16
    blt	main_42

main_56:
    ldr	w7,	[sp, #1476]

    cmp	w7,	#15
    bge	main_58

main_35:
    ldr	w0,	[sp, #1476]

    mov	w3,	w0
    b	main_36

main_58:
    movz	fp,	#1452
    ldr	x6,	[sp, fp]

    movz	fp,	#4340
    ldr	w26,	[x6]

    ldr	w2,	[x15]

    ldr	w11,	[x4]

    ldr	w12,	[x24]

    ldr	w10,	[x1]

    ldr	w8,	[x21]

    mov	w21,	w26
    ldr	x20,	[sp, fp]

    mov	w26,	w10
    movz	fp,	#4348
    ldr	w4,	[x20]

    mov	w10,	w8
    ldr	x3,	[sp, fp]

    movz	fp,	#4356
    ldr	w3,	[x3]

    mov	w8,	w3
    ldr	x6,	[sp, fp]

    movz	fp,	#3004
    ldr	w6,	[x6]

    mov	w22,	w6
    ldr	w0,	[x9]

    ldr	x18,	[sp, fp]

    movz	fp,	#2996
    ldr	w16,	[x18]

    mov	w6,	w16
    ldr	x17,	[sp, fp]

    movz	fp,	#2988
    ldr	w9,	[x17]

    mov	w17,	w4
    ldr	x7,	[sp, fp]

    movz	fp,	#2980
    ldr	w24,	[x7]

    mov	w1,	w24
    ldr	x23,	[sp, fp]

    movz	fp,	#2972
    ldr	w13,	[x23]

    ldr	x14,	[sp, fp]

    ldr	w15,	[x14]

    mov	w14,	w2
    ldr	w7,	[x27]

    mov	w24,	w7
    str	w21,	[sp, #1472]

    str	w14,	[sp, #676]

    mov	w14,	w11
    str	w14,	[sp, #1432]

    mov	w14,	w0
    str	w12,	[sp, #1468]

    str	w26,	[sp, #1464]

    str	w10,	[sp, #2736]

    str	w17,	[sp, #1460]

    mov	w17,	w15
    str	w8,	[sp, #1448]

    mov	w8,	w9
    str	w22,	[sp, #1420]

    str	w14,	[sp, #472]

    str	w6,	[sp, #468]

    str	w8,	[sp, #2740]

    str	w1,	[sp, #464]

    mov	w1,	w13
    str	w1,	[sp, #460]

    str	w17,	[sp, #568]

    str	w24,	[sp, #572]

    ldr	w2,	[sp, #1480]

    mov	w7,	w2
    str	w7,	[sp, #1776]

    ldr	w6,	[sp, #1484]

    mov	w7,	w6
    str	w7,	[sp, #1300]

    ldr	w10,	[sp, #1488]

    mov	w20,	w10
    str	w20,	[sp, #3808]

    ldr	w9,	[sp, #576]

    mov	w20,	w9
    str	w20,	[sp, #3764]

    ldr	w3,	[sp, #580]

    mov	w7,	w3
    str	w7,	[sp, #3760]

    ldr	w14,	[sp, #608]

    mov	w0,	w14
    str	w0,	[sp, #3748]

    ldr	w9,	[sp, #808]

    mov	w4,	w9
    str	w4,	[sp, #2744]

    ldr	w20,	[sp, #844]

    mov	w15,	w20
    str	w15,	[sp, #3756]

    ldr	w3,	[sp, #848]

    mov	w9,	w3
    str	w9,	[sp, #3752]

    ldr	w19,	[sp, #884]

    mov	w14,	w19
    str	w14,	[sp, #2748]

    ldr	w0,	[sp, #888]

    mov	w18,	w0
    str	w18,	[sp, #1576]

    ldr	w0,	[sp, #924]

    mov	w22,	w0
    str	w22,	[sp, #1580]

    ldr	w14,	[sp, #928]

    ldr	w16,	[sp, #972]

    mov	w0,	w14
    ldr	w14,	[sp, #976]

    ldr	w19,	[sp, #1496]

    mov	w9,	w14
    mov	w11,	w19
    str	w11,	[sp, #2904]


main_75:
    ldr	w24,	[sp, #1472]

    cmp	w24,	#0
    beq	main_113

main_109:
    ldr	w25,	[sp, #1472]

    ldr	w15,	[sp, #676]

    sub	w3,	w25,	#1
    ldr	w28,	[sp, #1432]

    add	w13,	w28,	w15
    mov	w28,	w3
    str	w13,	[sp, #564]

    ldr	w19,	[sp, #564]

    movz	w13,	#1
    movk	w13,	#15232,	lsl #16
    mov	w17,	w13
    mov	w10,	w17
    sdiv	w25,	w19,	w17
    str	w25,	[sp, #560]

    ldr	w17,	[sp, #560]

    ldr	w25,	[sp, #564]

    str	w28,	[sp, #1472]

    msub	w15,	w17,	w10,	w25

    mov	w10,	w15
    str	w10,	[sp, #676]

    movz	w10,	#0
    ldr	w20,	[sp, #1468]

    mov	w25,	w20
    str	w25,	[sp, #1432]

    ldr	w14,	[sp, #1464]

    mov	w21,	w14
    str	w21,	[sp, #1468]

    ldr	w4,	[sp, #2736]

    mov	w15,	w4
    str	w15,	[sp, #1464]

    ldr	w8,	[sp, #1460]

    mov	w5,	w8
    str	w5,	[sp, #2736]

    ldr	w1,	[sp, #1448]

    mov	w11,	w1
    str	w11,	[sp, #1460]

    ldr	w20,	[sp, #1420]

    mov	w2,	w20
    str	w2,	[sp, #1448]

    ldr	w13,	[sp, #472]

    mov	w21,	w13
    mov	w13,	w10
    str	w21,	[sp, #1420]

    ldr	w7,	[sp, #468]

    mov	w14,	w7
    str	w14,	[sp, #472]

    ldr	w8,	[sp, #2740]

    str	w8,	[sp, #468]

    ldr	w3,	[sp, #464]

    mov	w11,	w3
    str	w11,	[sp, #2740]

    ldr	w2,	[sp, #460]

    mov	w4,	w2
    str	w4,	[sp, #464]

    ldr	w3,	[sp, #568]

    str	w3,	[sp, #460]

    ldr	w25,	[sp, #572]

    mov	w7,	w25
    str	w7,	[sp, #568]

    ldr	w11,	[sp, #1776]

    mov	w7,	w11
    str	w7,	[sp, #572]

    ldr	w11,	[sp, #1300]

    mov	w12,	w11
    str	w12,	[sp, #1776]

    ldr	w15,	[sp, #3808]

    mov	w12,	w15
    str	w12,	[sp, #1300]

    ldr	w4,	[sp, #3764]

    mov	w17,	w4
    str	w17,	[sp, #3808]

    ldr	w2,	[sp, #3760]

    mov	w5,	w2
    str	w5,	[sp, #3764]

    ldr	w17,	[sp, #3748]

    mov	w1,	w17
    str	w1,	[sp, #3760]

    ldr	w14,	[sp, #2744]

    mov	w19,	w14
    str	w19,	[sp, #3748]

    ldr	w26,	[sp, #3756]

    mov	w15,	w26
    str	w15,	[sp, #2744]

    ldr	w22,	[sp, #3752]

    mov	w27,	w22
    str	w27,	[sp, #3756]

    ldr	w20,	[sp, #2748]

    mov	w23,	w20
    str	w23,	[sp, #3752]

    ldr	w24,	[sp, #1576]

    mov	w21,	w24
    str	w21,	[sp, #2748]

    ldr	w28,	[sp, #1580]

    mov	w25,	w28
    mov	w28,	w0
    str	w25,	[sp, #1576]

    mov	w0,	w16
    str	w28,	[sp, #1580]

    mov	w16,	w9
    ldr	w26,	[sp, #2904]

    str	w13,	[sp, #2904]

    mov	w9,	w26
    b	main_75

main_113:
    add	x0,	sp,	#80
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    add	x24,	sp,	#80
    movz	w6,	#1
    movz	w14,	#8848
    movz	fp,	#452
    mov	x23,	x24
    mov	w21,	w6
    add	x25,	x24,	#4
    mov	w4,	w14
    str	x23,	[sp, fp]

    movz	fp,	#452
    ldr	w11,	[sp, #676]

    ldr	x20,	[sp, fp]

    str	w11,	[x20]

    str	w4,	[x25]


main_118:
    cmp	w21,	#25
    blt	main_121

main_218:
    mov	w19,	w21

main_220:
    lsl	w0,	w19,	#3
    sub	w5,	w19,	#1
    add	w10,	w19,	#1
    mov	x1,	x0
    add	x1,	sp,	x1
    lsl	w4,	w5,	#3
    mov	x26,	x4
    add	x1,	x1,	#80
    add	x26,	sp,	x26
    mov	x3,	x1
    add	x26,	x26,	#80
    add	x8,	x1,	#4
    mov	x25,	x26
    add	x9,	x26,	#4
    ldr	w20,	[x9]

    sub	w2,	w20,	#1
    str	w2,	[x3]

    ldr	w3,	[x25]

    sub	w4,	w3,	#2
    str	w4,	[x8]

    cmp	w10,	#32
    bge	main_235

main_219:
    mov	w19,	w10
    b	main_220

main_235:
    add	x0,	sp,	#88
    movz	fp,	#396
    add	x25,	sp,	#96
    add	x22,	sp,	#112
    add	x24,	sp,	#120
    add	x28,	sp,	#128
    add	x27,	sp,	#136
    add	x20,	sp,	#144
    add	x19,	sp,	#152
    add	x23,	sp,	#160
    add	x18,	sp,	#176
    add	x21,	sp,	#184
    add	x26,	sp,	#208
    str	x0,	[sp, fp]

    movz	fp,	#1412
    add	x0,	sp,	#104
    str	x22,	[sp, fp]

    movz	fp,	#412
    str	x24,	[sp, #1304]

    str	x28,	[sp, #1312]

    add	x28,	sp,	#264
    str	x27,	[sp, fp]

    add	x27,	sp,	#168
    movz	fp,	#1404
    str	x20,	[sp, #1320]

    str	x19,	[sp, fp]

    add	x19,	sp,	#192
    movz	fp,	#1396
    str	x23,	[sp, #1328]

    add	x23,	sp,	#232
    str	x27,	[sp, fp]

    movz	fp,	#420
    str	x18,	[sp, fp]

    add	x18,	sp,	#216
    movz	fp,	#428
    str	x21,	[sp, fp]

    add	x21,	sp,	#256
    movz	fp,	#404
    str	x19,	[sp, fp]

    movz	fp,	#364
    add	x19,	sp,	#200
    str	x19,	[sp, fp]

    add	x19,	sp,	#224
    movz	fp,	#372
    str	x26,	[sp, fp]

    add	x26,	sp,	#288
    movz	fp,	#380
    str	x18,	[sp, fp]

    add	x18,	sp,	#248
    movz	fp,	#388
    str	x19,	[sp, fp]

    movz	fp,	#396
    add	x19,	sp,	#240
    str	x23,	[sp, #336]

    add	x23,	sp,	#312
    str	x19,	[sp, #344]

    add	x19,	sp,	#272
    str	x18,	[sp, #352]

    add	x18,	sp,	#296
    str	x21,	[sp, #480]

    str	x28,	[sp, #488]

    str	x19,	[sp, #496]

    add	x19,	sp,	#280
    str	x19,	[sp, #504]

    add	x19,	sp,	#304
    str	x26,	[sp, #512]

    str	x18,	[sp, #520]

    add	x18,	sp,	#328
    str	x19,	[sp, #528]

    add	x19,	sp,	#320
    str	x23,	[sp, #536]

    mov	x23,	x25
    str	x19,	[sp, #544]

    str	x18,	[sp, #552]

    ldr	x19,	[sp, fp]

    movz	fp,	#636
    str	x19,	[sp, #600]

    str	x23,	[sp, fp]

    movz	fp,	#668
    str	x0,	[sp, fp]

    movz	fp,	#1412
    ldr	x21,	[sp, fp]

    movz	fp,	#412
    str	x21,	[sp, #704]

    ldr	x24,	[sp, #1304]

    str	x24,	[sp, #736]

    ldr	x18,	[sp, #1312]

    str	x18,	[sp, #768]

    ldr	x21,	[sp, fp]

    movz	fp,	#836
    str	x21,	[sp, #800]

    ldr	x18,	[sp, #1320]

    str	x18,	[sp, fp]

    movz	fp,	#1404
    ldr	x18,	[sp, fp]

    movz	fp,	#876
    str	x18,	[sp, fp]

    movz	fp,	#916
    ldr	x18,	[sp, #1328]

    str	x18,	[sp, fp]

    movz	fp,	#1396
    ldr	x18,	[sp, fp]

    movz	fp,	#964
    str	x18,	[sp, fp]

    movz	fp,	#420
    ldr	x18,	[sp, fp]

    movz	fp,	#1004
    str	x18,	[sp, fp]

    movz	fp,	#428
    ldr	x21,	[sp, fp]

    movz	fp,	#1036
    str	x21,	[sp, fp]

    movz	fp,	#404
    ldr	x24,	[sp, fp]

    movz	fp,	#1068
    str	x24,	[sp, fp]

    movz	fp,	#364
    ldr	x18,	[sp, fp]

    movz	fp,	#1108
    str	x18,	[sp, fp]

    movz	fp,	#372
    ldr	x21,	[sp, fp]

    movz	fp,	#1132
    str	x21,	[sp, fp]

    movz	fp,	#380
    ldr	x24,	[sp, fp]

    movz	fp,	#1164
    str	x24,	[sp, fp]

    movz	fp,	#388
    ldr	x18,	[sp, fp]

    movz	fp,	#1196
    str	x18,	[sp, fp]

    movz	fp,	#1228
    ldr	x21,	[sp, #336]

    str	x21,	[sp, fp]

    movz	fp,	#1260
    ldr	x24,	[sp, #344]

    str	x24,	[sp, fp]

    movz	fp,	#2596
    ldr	x23,	[sp, #352]

    str	x23,	[sp, fp]

    movz	fp,	#2588
    ldr	x0,	[sp, #480]

    str	x0,	[sp, fp]

    movz	fp,	#1500
    ldr	x21,	[sp, #488]

    ldr	x25,	[sp, #496]

    mov	x20,	x21
    ldr	x22,	[sp, #504]

    mov	x26,	x25
    ldr	x23,	[sp, #512]

    mov	x18,	x22
    ldr	x0,	[sp, #520]

    mov	x19,	x23
    mov	x25,	x0
    ldr	x0,	[sp, #528]

    str	x0,	[sp, fp]

    movz	fp,	#1508
    ldr	x24,	[sp, #536]

    str	x24,	[sp, fp]

    movz	fp,	#452
    ldr	x23,	[sp, #544]

    mov	x0,	x23
    ldr	x23,	[sp, #552]

    ldr	x24,	[sp, fp]

    mov	x21,	x23
    movz	fp,	#1516
    str	x24,	[sp, fp]

    movz	fp,	#1516
    ldr	x22,	[sp, fp]

    movz	fp,	#452
    ldr	w22,	[x22]

    str	w22,	[sp, #476]

    ldr	x27,	[sp, fp]

    movz	fp,	#612
    add	x22,	x27,	#4
    str	x22,	[sp, #584]

    ldr	x24,	[sp, #584]

    ldr	w22,	[x24]

    str	w22,	[sp, #592]

    ldr	w22,	[sp, #592]

    ldr	w24,	[sp, #476]

    add	w27,	w22,	w24
    str	w27,	[sp, #1524]

    ldr	x27,	[sp, #600]

    str	x27,	[sp, fp]

    movz	fp,	#612
    ldr	x22,	[sp, fp]

    movz	fp,	#620
    ldr	w22,	[x22]

    str	w22,	[sp, #596]

    ldr	w24,	[sp, #596]

    ldr	w22,	[sp, #1524]

    add	w22,	w22,	w24
    str	w22,	[sp, #1492]

    ldr	x27,	[sp, #600]

    add	x27,	x27,	#4
    str	x27,	[sp, fp]

    movz	fp,	#620
    ldr	x22,	[sp, fp]

    movz	fp,	#636
    ldr	w27,	[x22]

    str	w27,	[sp, #628]

    ldr	w23,	[sp, #628]

    ldr	w24,	[sp, #1492]

    add	w24,	w24,	w23
    str	w24,	[sp, #2968]

    ldr	x22,	[sp, fp]

    movz	fp,	#644
    str	x22,	[sp, fp]

    movz	fp,	#644
    ldr	x27,	[sp, fp]

    movz	fp,	#636
    ldr	w27,	[x27]

    str	w27,	[sp, #632]

    ldr	w22,	[sp, #632]

    ldr	w28,	[sp, #2968]

    add	w22,	w28,	w22
    str	w22,	[sp, #2856]

    ldr	x22,	[sp, fp]

    movz	fp,	#652
    add	x27,	x22,	#4
    str	x27,	[sp, fp]

    movz	fp,	#652
    ldr	x22,	[sp, fp]

    movz	fp,	#668
    ldr	w22,	[x22]

    str	w22,	[sp, #660]

    ldr	w27,	[sp, #660]

    ldr	w22,	[sp, #2856]

    add	w22,	w22,	w27
    str	w22,	[sp, #2964]

    ldr	x22,	[sp, fp]

    movz	fp,	#668
    str	x22,	[sp, #680]

    ldr	x22,	[sp, #680]

    ldr	w27,	[x22]

    str	w27,	[sp, #664]

    ldr	w22,	[sp, #664]

    ldr	w24,	[sp, #2964]

    add	w22,	w24,	w22
    str	w22,	[sp, #2860]

    ldr	x24,	[sp, fp]

    movz	fp,	#812
    add	x24,	x24,	#4
    str	x24,	[sp, #688]

    ldr	x27,	[sp, #688]

    ldr	w27,	[x27]

    str	w27,	[sp, #696]

    ldr	w24,	[sp, #696]

    ldr	w22,	[sp, #2860]

    add	w22,	w22,	w24
    str	w22,	[sp, #2960]

    ldr	x24,	[sp, #704]

    str	x24,	[sp, #712]

    ldr	x22,	[sp, #712]

    ldr	w22,	[x22]

    str	w22,	[sp, #700]

    ldr	w24,	[sp, #700]

    ldr	w22,	[sp, #2960]

    add	w24,	w22,	w24
    str	w24,	[sp, #2864]

    ldr	x24,	[sp, #704]

    add	x22,	x24,	#4
    str	x22,	[sp, #720]

    ldr	x24,	[sp, #720]

    ldr	w24,	[x24]

    str	w24,	[sp, #728]

    ldr	w22,	[sp, #728]

    ldr	w24,	[sp, #2864]

    add	w27,	w24,	w22
    str	w27,	[sp, #2956]

    ldr	x27,	[sp, #736]

    str	x27,	[sp, #744]

    ldr	x22,	[sp, #744]

    ldr	w22,	[x22]

    str	w22,	[sp, #732]

    ldr	w27,	[sp, #732]

    ldr	w22,	[sp, #2956]

    add	w24,	w22,	w27
    str	w24,	[sp, #2868]

    ldr	x24,	[sp, #736]

    add	x22,	x24,	#4
    str	x22,	[sp, #752]

    ldr	x24,	[sp, #752]

    ldr	w24,	[x24]

    str	w24,	[sp, #760]

    ldr	w22,	[sp, #760]

    ldr	w28,	[sp, #2868]

    add	w24,	w28,	w22
    str	w24,	[sp, #2952]

    ldr	x22,	[sp, #768]

    str	x22,	[sp, #776]

    ldr	x22,	[sp, #776]

    ldr	w22,	[x22]

    str	w22,	[sp, #764]

    ldr	w24,	[sp, #764]

    ldr	w23,	[sp, #2952]

    add	w27,	w23,	w24
    str	w27,	[sp, #2872]

    ldr	x24,	[sp, #768]

    add	x22,	x24,	#4
    str	x22,	[sp, #784]

    ldr	x24,	[sp, #784]

    ldr	w24,	[x24]

    str	w24,	[sp, #792]

    ldr	w22,	[sp, #792]

    ldr	w24,	[sp, #2872]

    add	w24,	w24,	w22
    str	w24,	[sp, #2948]

    ldr	x27,	[sp, #800]

    str	x27,	[sp, fp]

    movz	fp,	#812
    ldr	x22,	[sp, fp]

    movz	fp,	#820
    ldr	w22,	[x22]

    str	w22,	[sp, #796]

    ldr	w27,	[sp, #796]

    ldr	w28,	[sp, #2948]

    add	w22,	w28,	w27
    str	w22,	[sp, #2876]

    ldr	x24,	[sp, #800]

    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#820
    ldr	x24,	[sp, fp]

    movz	fp,	#836
    ldr	w24,	[x24]

    str	w24,	[sp, #828]

    ldr	w22,	[sp, #828]

    ldr	w24,	[sp, #2876]

    add	w22,	w24,	w22
    str	w22,	[sp, #2944]

    ldr	x27,	[sp, fp]

    movz	fp,	#852
    str	x27,	[sp, fp]

    movz	fp,	#852
    ldr	x22,	[sp, fp]

    movz	fp,	#836
    ldr	w22,	[x22]

    str	w22,	[sp, #832]

    ldr	w27,	[sp, #832]

    ldr	w22,	[sp, #2944]

    add	w22,	w22,	w27
    str	w22,	[sp, #2880]

    ldr	x24,	[sp, fp]

    movz	fp,	#860
    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#860
    ldr	x24,	[sp, fp]

    movz	fp,	#876
    ldr	w24,	[x24]

    str	w24,	[sp, #868]

    ldr	w22,	[sp, #868]

    ldr	w24,	[sp, #2880]

    add	w22,	w24,	w22
    str	w22,	[sp, #2940]

    ldr	x27,	[sp, fp]

    movz	fp,	#892
    str	x27,	[sp, fp]

    movz	fp,	#892
    ldr	x22,	[sp, fp]

    movz	fp,	#876
    ldr	w22,	[x22]

    str	w22,	[sp, #872]

    ldr	w27,	[sp, #872]

    ldr	w22,	[sp, #2940]

    add	w24,	w22,	w27
    str	w24,	[sp, #2884]

    ldr	x24,	[sp, fp]

    movz	fp,	#900
    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#900
    ldr	x24,	[sp, fp]

    movz	fp,	#916
    ldr	w24,	[x24]

    str	w24,	[sp, #908]

    ldr	w22,	[sp, #908]

    ldr	w28,	[sp, #2884]

    add	w27,	w28,	w22
    str	w27,	[sp, #2936]

    ldr	x27,	[sp, fp]

    movz	fp,	#932
    str	x27,	[sp, fp]

    movz	fp,	#932
    ldr	x22,	[sp, fp]

    movz	fp,	#916
    ldr	w22,	[x22]

    str	w22,	[sp, #912]

    ldr	w27,	[sp, #912]

    ldr	w23,	[sp, #2936]

    add	w24,	w23,	w27
    str	w24,	[sp, #2888]

    ldr	x24,	[sp, fp]

    movz	fp,	#940
    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#940
    ldr	x24,	[sp, fp]

    movz	fp,	#964
    ldr	w24,	[x24]

    str	w24,	[sp, #956]

    ldr	w22,	[sp, #956]

    ldr	w24,	[sp, #2888]

    add	w24,	w24,	w22
    str	w24,	[sp, #2932]

    ldr	x27,	[sp, fp]

    movz	fp,	#980
    str	x27,	[sp, fp]

    movz	fp,	#980
    ldr	x22,	[sp, fp]

    movz	fp,	#964
    ldr	w22,	[x22]

    str	w22,	[sp, #960]

    ldr	w27,	[sp, #960]

    ldr	w28,	[sp, #2932]

    add	w27,	w28,	w27
    str	w27,	[sp, #2892]

    ldr	x24,	[sp, fp]

    movz	fp,	#988
    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#988
    ldr	x24,	[sp, fp]

    movz	fp,	#1004
    ldr	w24,	[x24]

    str	w24,	[sp, #996]

    ldr	w22,	[sp, #996]

    ldr	w24,	[sp, #2892]

    add	w24,	w24,	w22
    str	w24,	[sp, #2928]

    ldr	x22,	[sp, fp]

    movz	fp,	#1012
    str	x22,	[sp, fp]

    movz	fp,	#1012
    ldr	x22,	[sp, fp]

    movz	fp,	#1004
    ldr	w22,	[x22]

    str	w22,	[sp, #1000]

    ldr	w24,	[sp, #1000]

    ldr	w22,	[sp, #2928]

    add	w22,	w22,	w24
    str	w22,	[sp, #2896]

    ldr	x24,	[sp, fp]

    movz	fp,	#1020
    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1020
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x24]

    str	w24,	[sp, #1028]

    ldr	w22,	[sp, #1028]

    ldr	w24,	[sp, #2896]

    add	w22,	w24,	w22
    str	w22,	[sp, #2924]

    ldr	x24,	[sp, fp]

    movz	fp,	#1044
    str	x24,	[sp, fp]

    movz	fp,	#1044
    ldr	x22,	[sp, fp]

    movz	fp,	#1036
    ldr	w22,	[x22]

    str	w22,	[sp, #1032]

    ldr	w24,	[sp, #1032]

    ldr	w22,	[sp, #2924]

    add	w22,	w22,	w24
    str	w22,	[sp, #2900]

    ldr	x24,	[sp, fp]

    movz	fp,	#1052
    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1052
    ldr	x24,	[sp, fp]

    movz	fp,	#1068
    ldr	w24,	[x24]

    str	w24,	[sp, #1060]

    ldr	w22,	[sp, #1060]

    ldr	w28,	[sp, #2900]

    add	w22,	w28,	w22
    str	w22,	[sp, #2920]

    ldr	x27,	[sp, fp]

    movz	fp,	#1076
    str	x27,	[sp, fp]

    movz	fp,	#1076
    ldr	x22,	[sp, fp]

    movz	fp,	#1068
    ldr	w22,	[x22]

    str	w22,	[sp, #1064]

    ldr	w27,	[sp, #1064]

    ldr	w23,	[sp, #2920]

    add	w24,	w23,	w27
    str	w24,	[sp, #2908]

    ldr	x24,	[sp, fp]

    movz	fp,	#1084
    add	x22,	x24,	#4
    str	x22,	[sp, fp]

    movz	fp,	#1084
    ldr	x24,	[sp, fp]

    movz	fp,	#1108
    ldr	w24,	[x24]

    str	w24,	[sp, #1092]

    ldr	w22,	[sp, #1092]

    ldr	w24,	[sp, #2908]

    add	w27,	w24,	w22
    str	w27,	[sp, #5912]

    ldr	x22,	[sp, fp]

    movz	fp,	#1116
    str	x22,	[sp, fp]

    movz	fp,	#1116
    ldr	x24,	[sp, fp]

    movz	fp,	#1108
    ldr	w24,	[x24]

    str	w24,	[sp, #1104]

    ldr	w27,	[sp, #1104]

    ldr	w28,	[sp, #5912]

    add	w24,	w28,	w27
    str	w24,	[sp, #2912]

    ldr	x24,	[sp, fp]

    movz	fp,	#1132
    add	x22,	x24,	#4
    str	x22,	[sp, #1096]

    ldr	x24,	[sp, #1096]

    ldr	w24,	[x24]

    str	w24,	[sp, #1124]

    ldr	w22,	[sp, #1124]

    ldr	w24,	[sp, #2912]

    add	w27,	w24,	w22
    ldr	x24,	[sp, fp]

    movz	fp,	#1140
    str	x24,	[sp, fp]

    movz	fp,	#1140
    ldr	x28,	[sp, fp]

    movz	fp,	#1132
    ldr	w28,	[x28]

    str	w28,	[sp, #1128]

    ldr	w22,	[sp, #1128]

    add	w27,	w27,	w22
    ldr	x22,	[sp, fp]

    movz	fp,	#1148
    add	x28,	x22,	#4
    str	x28,	[sp, fp]

    movz	fp,	#1148
    ldr	x22,	[sp, fp]

    movz	fp,	#1164
    ldr	w22,	[x22]

    str	w22,	[sp, #1156]

    ldr	w28,	[sp, #1156]

    add	w27,	w27,	w28
    str	w27,	[sp, #2916]

    ldr	x27,	[sp, fp]

    movz	fp,	#1172
    str	x27,	[sp, fp]

    movz	fp,	#1172
    ldr	x22,	[sp, fp]

    movz	fp,	#1164
    ldr	w22,	[x22]

    str	w22,	[sp, #1160]

    ldr	w27,	[sp, #1160]

    ldr	w28,	[sp, #2916]

    add	w22,	w28,	w27
    str	w22,	[sp, #5908]

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

    ldr	w22,	[sp, #5908]

    add	w23,	w22,	w24
    ldr	x22,	[sp, fp]

    movz	fp,	#1204
    str	x22,	[sp, fp]

    movz	fp,	#1204
    ldr	x28,	[sp, fp]

    movz	fp,	#1196
    ldr	w28,	[x28]

    str	w28,	[sp, #1192]

    ldr	w22,	[sp, #1192]

    add	w27,	w23,	w22
    ldr	x22,	[sp, fp]

    movz	fp,	#1212
    add	x28,	x22,	#4
    str	x28,	[sp, fp]

    movz	fp,	#1212
    ldr	x22,	[sp, fp]

    movz	fp,	#1228
    ldr	w22,	[x22]

    str	w22,	[sp, #1220]

    ldr	w28,	[sp, #1220]

    ldr	x24,	[sp, fp]

    add	w22,	w27,	w28
    movz	fp,	#1236
    str	x24,	[sp, fp]

    movz	fp,	#1236
    ldr	x28,	[sp, fp]

    movz	fp,	#1228
    ldr	w28,	[x28]

    str	w28,	[sp, #1224]

    ldr	w24,	[sp, #1224]

    add	w22,	w22,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1244
    add	x28,	x24,	#4
    str	x28,	[sp, fp]

    movz	fp,	#1244
    ldr	x24,	[sp, fp]

    movz	fp,	#1260
    ldr	w24,	[x24]

    str	w24,	[sp, #1252]

    ldr	w28,	[sp, #1252]

    ldr	x27,	[sp, fp]

    add	w28,	w22,	w28
    movz	fp,	#1268
    str	x27,	[sp, fp]

    movz	fp,	#1268
    ldr	x23,	[sp, fp]

    movz	fp,	#1260
    ldr	w23,	[x23]

    str	w23,	[sp, #1256]

    ldr	w22,	[sp, #1256]

    ldr	x24,	[sp, fp]

    add	w22,	w28,	w22
    movz	fp,	#2596
    add	x24,	x24,	#4
    str	x24,	[sp, #1288]

    ldr	x28,	[sp, #1288]

    ldr	w28,	[x28]

    str	w28,	[sp, #1284]

    ldr	w24,	[sp, #1284]

    ldr	x27,	[sp, fp]

    add	w28,	w22,	w24
    movz	fp,	#2596
    ldr	w22,	[x27]

    str	w22,	[sp, #1280]

    ldr	w23,	[sp, #1280]

    ldr	x27,	[sp, fp]

    add	w28,	w28,	w23
    movz	fp,	#2588
    add	x24,	x27,	#4
    ldr	w27,	[x24]

    add	w22,	w28,	w27
    mov	x28,	x26
    str	w22,	[sp, #1276]

    ldr	x22,	[sp, fp]

    movz	fp,	#2588
    ldr	w24,	[x22]

    ldr	w23,	[sp, #1276]

    add	w27,	w23,	w24
    ldr	x23,	[sp, fp]

    movz	fp,	#1500
    add	x22,	x23,	#4
    add	x23,	x19,	#4
    ldr	w22,	[x22]

    ldr	w24,	[x20]

    add	w22,	w27,	w22
    add	x27,	x20,	#4
    add	x20,	x26,	#4
    add	w24,	w22,	w24
    ldr	w27,	[x27]

    add	w22,	w24,	w27
    ldr	w27,	[x28]

    ldr	w24,	[x20]

    add	w27,	w22,	w27
    ldr	w28,	[x18]

    add	w26,	w27,	w24
    add	w22,	w26,	w28
    add	x26,	x18,	#4
    mov	x18,	x19
    add	x19,	x25,	#4
    ldr	w28,	[x26]

    mov	x26,	x21
    ldr	w24,	[x18]

    add	w28,	w22,	w28
    ldr	w22,	[x23]

    add	w18,	w28,	w24
    mov	x28,	x25
    ldr	w28,	[x28]

    add	w20,	w18,	w22
    add	w18,	w20,	w28
    ldr	w20,	[x19]

    ldr	x27,	[sp, fp]

    add	w20,	w18,	w20
    movz	fp,	#1500
    ldr	w18,	[x27]

    add	w23,	w20,	w18
    ldr	x20,	[sp, fp]

    movz	fp,	#1508
    add	x20,	x20,	#4
    ldr	w28,	[x20]

    add	x20,	x0,	#4
    ldr	x22,	[sp, fp]

    add	w27,	w23,	w28
    movz	fp,	#1508
    ldr	w19,	[x22]

    ldr	x25,	[sp, fp]

    add	w18,	w27,	w19
    add	x22,	x25,	#4
    mov	x19,	x0
    ldr	w23,	[x22]

    ldr	w28,	[x19]

    add	w22,	w18,	w23
    add	w28,	w22,	w28
    ldr	w22,	[x20]

    ldr	w25,	[x26]

    add	x20,	x21,	#4
    add	w22,	w28,	w22
    ldr	w18,	[x20]

    add	w0,	w22,	w25
    add	w0,	w0,	w18
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#5952
    add	sp, sp, fp
    ret


main_121:
    lsl	w5,	w21,	#3
    sub	w25,	w21,	#1
    add	w8,	w21,	#1
    mov	x12,	x5
    add	x12,	sp,	x12
    lsl	w28,	w25,	#3
    lsl	w22,	w8,	#3
    mov	x26,	x28
    add	x12,	x12,	#80
    mov	x22,	x22
    add	x26,	sp,	x26
    mov	x14,	x12
    add	x22,	sp,	x22
    add	x2,	x12,	#4
    add	x26,	x26,	#80
    add	x22,	x22,	#80
    mov	x0,	x26
    mov	x24,	x22
    add	x3,	x26,	#4
    add	x9,	x22,	#4
    ldr	w4,	[x3]

    sub	w5,	w4,	#1
    str	w5,	[x14]

    sub	w5,	w8,	#1
    ldr	w0,	[x0]

    sub	w1,	w0,	#2
    lsl	w7,	w5,	#3
    str	w1,	[x2]

    mov	x0,	x7
    add	x0,	sp,	x0
    add	x0,	x0,	#80
    mov	x12,	x0
    add	x11,	x0,	#4
    ldr	w13,	[x11]

    sub	w15,	w13,	#1
    add	w13,	w8,	#1
    str	w15,	[x24]

    sub	w2,	w13,	#1
    lsl	w4,	w13,	#3
    ldr	w5,	[x12]

    mov	x4,	x4
    sub	w6,	w5,	#2
    add	x4,	sp,	x4
    lsl	w1,	w2,	#3
    mov	x20,	x1
    str	w6,	[x9]

    add	x4,	x4,	#80
    add	x20,	sp,	x20
    mov	x6,	x4
    add	x15,	x4,	#4
    add	x20,	x20,	#80
    mov	x0,	x20
    add	x2,	x20,	#4
    ldr	w5,	[x2]

    sub	w8,	w5,	#1
    str	w8,	[x6]

    ldr	w25,	[x0]

    sub	w26,	w25,	#2
    str	w26,	[x15]

    add	w26,	w13,	#1
    add	w28,	w26,	#1
    sub	w6,	w26,	#1
    lsl	w21,	w26,	#3
    mov	x21,	x21
    sub	w0,	w28,	#1
    lsl	w3,	w28,	#3
    lsl	w9,	w6,	#3
    add	x21,	sp,	x21
    mov	x2,	x9
    lsl	w4,	w0,	#3
    add	x2,	sp,	x2
    add	x21,	x21,	#80
    mov	x25,	x4
    mov	x23,	x21
    add	x25,	sp,	x25
    add	x2,	x2,	#80
    add	x6,	x21,	#4
    mov	x14,	x2
    add	x25,	x25,	#80
    add	x13,	x2,	#4
    mov	x2,	x3
    add	x1,	x25,	#4
    add	x2,	sp,	x2
    ldr	w18,	[x13]

    sub	w19,	w18,	#1
    add	x2,	x2,	#80
    mov	x5,	x2
    str	w19,	[x23]

    add	x15,	x2,	#4
    ldr	w7,	[x14]

    sub	w8,	w7,	#2
    str	w8,	[x6]

    mov	x6,	x25
    ldr	w12,	[x1]

    sub	w0,	w12,	#1
    str	w0,	[x5]

    ldr	w25,	[x6]

    add	w6,	w28,	#1
    sub	w26,	w25,	#2
    sub	w8,	w6,	#1
    lsl	w19,	w6,	#3
    str	w26,	[x15]

    mov	x19,	x19
    add	x19,	sp,	x19
    lsl	w10,	w8,	#3
    mov	x5,	x10
    add	x19,	x19,	#80
    add	x5,	sp,	x5
    mov	x22,	x19
    add	x5,	x5,	#80
    add	x2,	x19,	#4
    mov	x18,	x5
    add	x14,	x5,	#4
    ldr	w20,	[x14]

    sub	w28,	w20,	#1
    str	w28,	[x22]

    add	w22,	w6,	#1
    ldr	w8,	[x18]

    sub	w9,	w8,	#2
    add	w20,	w22,	#1
    sub	w4,	w22,	#1
    str	w9,	[x2]

    lsl	w2,	w22,	#3
    sub	w8,	w20,	#1
    lsl	w18,	w20,	#3
    lsl	w0,	w4,	#3
    mov	x1,	x2
    mov	x16,	x18
    mov	x0,	x0
    add	x1,	sp,	x1
    add	x16,	sp,	x16
    add	x0,	sp,	x0
    add	x1,	x1,	#80
    add	x16,	x16,	#80
    add	x0,	x0,	#80
    mov	x3,	x1
    mov	x19,	x16
    mov	x10,	x0
    add	x14,	x1,	#4
    add	x9,	x0,	#4
    add	x1,	x16,	#4
    ldr	w9,	[x9]

    sub	w13,	w9,	#1
    str	w13,	[x3]

    ldr	w24,	[x10]

    lsl	w10,	w8,	#3
    sub	w26,	w24,	#2
    mov	x8,	x10
    add	x8,	sp,	x8
    str	w26,	[x14]

    add	x8,	x8,	#80
    mov	x26,	x8
    add	x14,	x8,	#4
    ldr	w4,	[x14]

    sub	w0,	w4,	#1
    str	w0,	[x19]

    add	w0,	w20,	#1
    ldr	w7,	[x26]

    mov	w21,	w0
    sub	w8,	w7,	#2
    str	w8,	[x1]

    b	main_118

main_42:
    mov	w11,	w2
    b	main_43

