.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#5856
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #1480]

    bl	getint
    str	w0,	[sp, #1484]

    bl	getint
    str	w0,	[sp, #1492]

    bl	getint
    str	w0,	[sp, #1496]

    bl	getint
    str	w0,	[sp, #556]

    bl	getint
    str	w0,	[sp, #584]

    bl	getint
    str	w0,	[sp, #784]

    bl	getint
    str	w0,	[sp, #820]

    bl	getint
    str	w0,	[sp, #824]

    bl	getint
    str	w0,	[sp, #860]

    bl	getint
    str	w0,	[sp, #864]

    bl	getint
    str	w0,	[sp, #900]

    bl	getint
    str	w0,	[sp, #904]

    bl	getint
    str	w0,	[sp, #940]

    bl	getint
    str	w0,	[sp, #944]

    bl	getint
    add	x5,	sp,	#48
    movz	fp,	#3164
    add	x24,	sp,	#16
    str	w0,	[sp, #1488]

    add	x27,	sp,	#56
    add	x8,	sp,	#20
    add	x18,	sp,	#24
    add	x6,	sp,	#28
    movz	w17,	#0
    add	x9,	sp,	#44
    add	x19,	sp,	#32
    add	x13,	sp,	#52
    add	x23,	sp,	#60
    str	x24,	[sp, #1448]

    add	x24,	sp,	#36
    ldr	x25,	[sp, #1448]

    ldr	w0,	[sp, #1480]

    str	w0,	[x25]

    mov	w25,	w17
    ldr	w1,	[sp, #1484]

    str	w1,	[x8]

    add	x1,	sp,	#40
    ldr	w11,	[sp, #1492]

    str	w11,	[x18]

    str	x6,	[sp, fp]

    movz	fp,	#3164
    ldr	w16,	[sp, #1496]

    ldr	x7,	[sp, fp]

    str	w16,	[x7]

    add	x7,	sp,	#72
    str	x19,	[sp, #4168]

    add	x19,	sp,	#64
    ldr	w12,	[sp, #556]

    ldr	x21,	[sp, #4168]

    str	w12,	[x21]

    str	x24,	[sp, #4184]

    ldr	w3,	[sp, #584]

    ldr	x26,	[sp, #4184]

    str	w3,	[x26]

    str	x1,	[sp, #4288]

    ldr	w26,	[sp, #784]

    ldr	x2,	[sp, #4288]

    str	w26,	[x2]

    str	x9,	[sp, #4304]

    ldr	w14,	[sp, #820]

    ldr	x11,	[sp, #4304]

    str	w14,	[x11]

    str	x5,	[sp, #4296]

    ldr	w5,	[sp, #824]

    ldr	x6,	[sp, #4296]

    str	w5,	[x6]

    str	x13,	[sp, #4312]

    add	x13,	sp,	#68
    ldr	w16,	[sp, #860]

    ldr	x15,	[sp, #4312]

    str	w16,	[x15]

    str	x27,	[sp, #2936]

    ldr	w6,	[sp, #864]

    ldr	x28,	[sp, #2936]

    str	w6,	[x28]

    str	x23,	[sp, #2928]

    ldr	w0,	[sp, #900]

    ldr	x24,	[sp, #2928]

    str	w0,	[x24]

    str	x19,	[sp, #2920]

    ldr	w6,	[sp, #904]

    ldr	x20,	[sp, #2920]

    str	w6,	[x20]

    str	x13,	[sp, #2912]

    ldr	w3,	[sp, #940]

    ldr	x1,	[sp, #2912]

    str	w3,	[x1]

    str	x7,	[sp, #2904]

    ldr	w3,	[sp, #944]

    ldr	x26,	[sp, #2904]

    str	w3,	[x26]

    add	x3,	sp,	#76
    str	x3,	[sp, #2896]

    ldr	w4,	[sp, #1488]

    ldr	x22,	[sp, #2896]

    str	w4,	[x22]


main_36:
    add	w12,	w25,	#1
    str	w12,	[sp, #1476]

    ldr	w13,	[sp, #1476]

    cmp	w13,	#16
    bge	main_56

main_40:
    lsl	w4,	w25,	#2
    ldr	x0,	[sp, #1448]

    ldr	w3,	[sp, #1476]

    add	x2,	x0,	x4
    mov	w25,	w3

main_43:
    ldr	w24,	[x2]

    lsl	w7,	w25,	#2
    ldr	x3,	[sp, #1448]

    add	x1,	x3,	x7
    ldr	w0,	[x1]

    cmp	w24,	w0
    bge	main_51

main_49:
    str	w0,	[x2]

    str	w24,	[x1]


main_51:
    add	w0,	w25,	#1
    cmp	w0,	#16
    bge	main_56

main_42:
    mov	w25,	w0
    b	main_43

main_56:
    ldr	w19,	[sp, #1476]

    cmp	w19,	#15
    blt	main_35

main_58:
    ldr	x1,	[sp, #1448]

    movz	fp,	#3164
    ldr	w10,	[x1]

    str	w10,	[sp, #1316]

    ldr	w2,	[x8]

    str	w2,	[sp, #360]

    ldr	w5,	[x18]

    str	w5,	[sp, #1312]

    ldr	x8,	[sp, fp]

    ldr	w3,	[x8]

    ldr	x10,	[sp, #4168]

    ldr	w17,	[x10]

    mov	w2,	w17
    ldr	x13,	[sp, #4184]

    ldr	w24,	[x13]

    ldr	x18,	[sp, #4288]

    ldr	w27,	[x18]

    ldr	x1,	[sp, #4304]

    ldr	w0,	[x1]

    ldr	x26,	[sp, #4296]

    ldr	w13,	[x26]

    ldr	x4,	[sp, #4312]

    ldr	w21,	[x4]

    mov	w11,	w21
    ldr	x22,	[sp, #2936]

    ldr	w4,	[x22]

    ldr	x7,	[sp, #2928]

    ldr	w20,	[x7]

    mov	w7,	w3
    ldr	x23,	[sp, #2920]

    ldr	w6,	[x23]

    ldr	x26,	[sp, #2912]

    ldr	w1,	[x26]

    ldr	x26,	[sp, #2904]

    ldr	w5,	[x26]

    str	w5,	[sp, #5840]

    ldr	x14,	[sp, #2896]

    ldr	w15,	[x14]

    mov	w14,	w6
    ldr	w8,	[sp, #1316]

    str	w8,	[sp, #1472]

    ldr	w12,	[sp, #360]

    mov	w19,	w12
    mov	w12,	w24
    str	w19,	[sp, #652]

    mov	w19,	w27
    ldr	w9,	[sp, #1312]

    str	w9,	[sp, #444]

    mov	w9,	w1
    str	w7,	[sp, #2764]

    mov	w7,	w4
    str	w2,	[sp, #1468]

    mov	w4,	w15
    str	w12,	[sp, #1464]

    str	w19,	[sp, #1460]

    mov	w19,	w13
    str	w0,	[sp, #440]

    mov	w0,	w20
    str	w19,	[sp, #428]

    str	w11,	[sp, #424]

    str	w7,	[sp, #1308]

    str	w0,	[sp, #1304]

    str	w14,	[sp, #2768]

    str	w9,	[sp, #1536]

    ldr	w6,	[sp, #5840]

    mov	w2,	w6
    str	w2,	[sp, #548]

    str	w4,	[sp, #552]

    ldr	w9,	[sp, #1480]

    str	w9,	[sp, #4204]

    ldr	w3,	[sp, #1484]

    mov	w22,	w3
    str	w22,	[sp, #2772]

    ldr	w10,	[sp, #1492]

    mov	w26,	w10
    str	w26,	[sp, #4284]

    ldr	w14,	[sp, #1496]

    mov	w22,	w14
    str	w22,	[sp, #4280]

    ldr	w6,	[sp, #556]

    mov	w1,	w6
    str	w1,	[sp, #4196]

    ldr	w4,	[sp, #584]

    mov	w5,	w4
    str	w5,	[sp, #4200]

    ldr	w18,	[sp, #784]

    mov	w11,	w18
    str	w11,	[sp, #1540]

    ldr	w8,	[sp, #820]

    mov	w26,	w8
    str	w26,	[sp, #4192]

    ldr	w20,	[sp, #824]

    mov	w0,	w20
    str	w0,	[sp, #1532]

    ldr	w8,	[sp, #860]

    mov	w0,	w8
    str	w0,	[sp, #1596]

    ldr	w6,	[sp, #864]

    mov	w26,	w6
    str	w26,	[sp, #2776]

    ldr	w6,	[sp, #900]

    mov	w21,	w6
    str	w21,	[sp, #1588]

    ldr	w2,	[sp, #904]

    ldr	w6,	[sp, #940]

    mov	w13,	w2
    mov	w0,	w6
    str	w0,	[sp, #1592]

    ldr	w6,	[sp, #944]

    mov	w9,	w6
    str	w9,	[sp, #3284]

    ldr	w16,	[sp, #1488]

    mov	w19,	w16
    str	w19,	[sp, #2944]


main_75:
    ldr	w12,	[sp, #1472]

    cmp	w12,	#0
    bne	main_109

main_113:
    add	x0,	sp,	#80
    movz	w1,	#0
    movz	w2,	#256
    bl	memset
    movz	w10,	#8848
    movz	w4,	#1
    add	x21,	sp,	#80
    str	x21,	[sp, #1296]

    ldr	w5,	[sp, #652]

    ldr	x20,	[sp, #1296]

    str	w5,	[x20]

    add	x20,	x21,	#4
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

    add	w13,	w0,	#1
    sub	w8,	w0,	#1
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
    add	x27,	sp,	#88
    add	x22,	sp,	#96
    movz	fp,	#372
    add	x0,	sp,	#104
    add	x25,	sp,	#112
    add	x24,	sp,	#128
    add	x26,	sp,	#144
    add	x23,	sp,	#160
    add	x28,	sp,	#168
    add	x20,	sp,	#176
    add	x19,	sp,	#184
    mov	x21,	x27
    str	x22,	[sp, fp]

    movz	fp,	#364
    add	x22,	sp,	#136
    str	x25,	[sp, #1376]

    add	x25,	sp,	#120
    str	x25,	[sp, #1440]

    add	x25,	sp,	#192
    str	x24,	[sp, #1408]

    add	x24,	sp,	#240
    str	x22,	[sp, #1272]

    add	x22,	sp,	#208
    str	x26,	[sp, #1384]

    add	x26,	sp,	#152
    str	x26,	[sp, #1416]

    add	x26,	sp,	#224
    str	x23,	[sp, #1432]

    add	x23,	sp,	#264
    str	x28,	[sp, #1264]

    add	x28,	sp,	#200
    str	x20,	[sp, #1400]

    add	x20,	sp,	#232
    str	x19,	[sp, #1424]

    add	x19,	sp,	#256
    str	x25,	[sp, fp]

    add	x25,	sp,	#216
    movz	fp,	#388
    str	x28,	[sp, fp]

    add	x28,	sp,	#280
    movz	fp,	#380
    str	x22,	[sp, #400]

    add	x22,	sp,	#288
    str	x25,	[sp, #408]

    add	x25,	sp,	#272
    str	x26,	[sp, fp]

    movz	fp,	#460
    add	x26,	sp,	#248
    str	x20,	[sp, #336]

    add	x20,	sp,	#312
    str	x24,	[sp, #344]

    add	x24,	sp,	#320
    str	x26,	[sp, #352]

    add	x26,	sp,	#304
    str	x19,	[sp, fp]

    movz	fp,	#468
    str	x23,	[sp, fp]

    mov	x23,	x0
    movz	fp,	#476
    str	x25,	[sp, fp]

    add	x25,	sp,	#296
    movz	fp,	#484
    str	x28,	[sp, fp]

    movz	fp,	#492
    str	x22,	[sp, fp]

    movz	fp,	#500
    str	x25,	[sp, fp]

    movz	fp,	#508
    str	x26,	[sp, fp]

    add	x26,	sp,	#328
    movz	fp,	#516
    str	x20,	[sp, fp]

    movz	fp,	#524
    str	x24,	[sp, fp]

    movz	fp,	#532
    str	x26,	[sp, fp]

    movz	fp,	#372
    str	x21,	[sp, #576]

    ldr	x19,	[sp, fp]

    movz	fp,	#620
    str	x19,	[sp, fp]

    movz	fp,	#644
    str	x23,	[sp, fp]

    movz	fp,	#812
    ldr	x20,	[sp, #1376]

    str	x20,	[sp, #680]

    ldr	x24,	[sp, #1440]

    str	x24,	[sp, #712]

    ldr	x28,	[sp, #1408]

    str	x28,	[sp, #744]

    ldr	x20,	[sp, #1272]

    str	x20,	[sp, #776]

    ldr	x28,	[sp, #1384]

    str	x28,	[sp, fp]

    movz	fp,	#852
    ldr	x28,	[sp, #1416]

    str	x28,	[sp, fp]

    movz	fp,	#892
    ldr	x28,	[sp, #1432]

    str	x28,	[sp, fp]

    movz	fp,	#932
    ldr	x28,	[sp, #1264]

    str	x28,	[sp, fp]

    movz	fp,	#972
    ldr	x28,	[sp, #1400]

    str	x28,	[sp, fp]

    movz	fp,	#1004
    ldr	x20,	[sp, #1424]

    str	x20,	[sp, fp]

    movz	fp,	#364
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    str	x24,	[sp, fp]

    movz	fp,	#388
    ldr	x28,	[sp, fp]

    movz	fp,	#1068
    str	x28,	[sp, fp]

    movz	fp,	#1100
    ldr	x20,	[sp, #400]

    str	x20,	[sp, fp]

    movz	fp,	#1132
    ldr	x24,	[sp, #408]

    str	x24,	[sp, fp]

    movz	fp,	#380
    ldr	x28,	[sp, fp]

    movz	fp,	#1164
    str	x28,	[sp, fp]

    movz	fp,	#1196
    ldr	x20,	[sp, #336]

    str	x20,	[sp, fp]

    movz	fp,	#1228
    ldr	x24,	[sp, #344]

    str	x24,	[sp, fp]

    movz	fp,	#460
    ldr	x21,	[sp, #352]

    str	x21,	[sp, #2600]

    ldr	x0,	[sp, fp]

    movz	fp,	#468
    str	x0,	[sp, #2592]

    ldr	x0,	[sp, fp]

    movz	fp,	#476
    mov	x20,	x0
    ldr	x0,	[sp, fp]

    movz	fp,	#484
    mov	x21,	x0
    ldr	x28,	[sp, fp]

    movz	fp,	#492
    mov	x25,	x28
    ldr	x0,	[sp, fp]

    movz	fp,	#500
    mov	x19,	x0
    ldr	x26,	[sp, fp]

    movz	fp,	#508
    mov	x22,	x26
    ldr	x28,	[sp, fp]

    movz	fp,	#1500
    str	x28,	[sp, fp]

    movz	fp,	#516
    ldr	x0,	[sp, fp]

    movz	fp,	#1508
    str	x0,	[sp, fp]

    movz	fp,	#524
    ldr	x26,	[sp, fp]

    movz	fp,	#532
    mov	x0,	x26
    ldr	x26,	[sp, fp]

    movz	fp,	#1516
    mov	x18,	x26
    ldr	x26,	[sp, #1296]

    str	x26,	[sp, fp]

    movz	fp,	#1516
    ldr	x24,	[sp, fp]

    movz	fp,	#588
    ldr	w24,	[x24]

    str	w24,	[sp, #456]

    ldr	x24,	[sp, #1296]

    add	x23,	x24,	#4
    str	x23,	[sp, #560]

    ldr	x24,	[sp, #560]

    ldr	w26,	[x24]

    str	w26,	[sp, #568]

    ldr	w24,	[sp, #568]

    ldr	w28,	[sp, #456]

    add	w24,	w24,	w28
    str	w24,	[sp, #1524]

    ldr	x24,	[sp, #576]

    str	x24,	[sp, fp]

    movz	fp,	#588
    ldr	x26,	[sp, fp]

    movz	fp,	#596
    ldr	w24,	[x26]

    str	w24,	[sp, #572]

    ldr	w24,	[sp, #572]

    ldr	w26,	[sp, #1524]

    add	w24,	w26,	w24
    str	w24,	[sp, #1528]

    ldr	x24,	[sp, #576]

    add	x23,	x24,	#4
    str	x23,	[sp, fp]

    movz	fp,	#596
    ldr	x24,	[sp, fp]

    movz	fp,	#620
    ldr	w26,	[x24]

    str	w26,	[sp, #604]

    ldr	w24,	[sp, #604]

    ldr	w27,	[sp, #1528]

    add	w26,	w27,	w24
    str	w26,	[sp, #2892]

    ldr	x26,	[sp, fp]

    movz	fp,	#612
    str	x26,	[sp, fp]

    movz	fp,	#612
    ldr	x24,	[sp, fp]

    movz	fp,	#620
    ldr	w24,	[x24]

    str	w24,	[sp, #608]

    ldr	w26,	[sp, #608]

    ldr	w28,	[sp, #2892]

    add	w28,	w28,	w26
    str	w28,	[sp, #2780]

    ldr	x24,	[sp, fp]

    movz	fp,	#628
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#628
    ldr	x24,	[sp, fp]

    movz	fp,	#644
    ldr	w24,	[x24]

    str	w24,	[sp, #636]

    ldr	w27,	[sp, #636]

    ldr	w23,	[sp, #2780]

    add	w23,	w23,	w27
    str	w23,	[sp, #2888]

    ldr	x24,	[sp, fp]

    movz	fp,	#644
    str	x24,	[sp, #656]

    ldr	x23,	[sp, #656]

    ldr	w24,	[x23]

    str	w24,	[sp, #640]

    ldr	w28,	[sp, #640]

    ldr	w24,	[sp, #2888]

    add	w24,	w24,	w28
    str	w24,	[sp, #2784]

    ldr	x24,	[sp, fp]

    movz	fp,	#788
    add	x24,	x24,	#4
    str	x24,	[sp, #664]

    ldr	x26,	[sp, #664]

    ldr	w23,	[x26]

    str	w23,	[sp, #672]

    ldr	w28,	[sp, #672]

    ldr	w26,	[sp, #2784]

    add	w24,	w26,	w28
    str	w24,	[sp, #2884]

    ldr	x23,	[sp, #680]

    str	x23,	[sp, #688]

    ldr	x24,	[sp, #688]

    ldr	w26,	[x24]

    str	w26,	[sp, #676]

    ldr	w24,	[sp, #676]

    ldr	w26,	[sp, #2884]

    add	w23,	w26,	w24
    str	w23,	[sp, #2788]

    ldr	x26,	[sp, #680]

    add	x26,	x26,	#4
    str	x26,	[sp, #696]

    ldr	x24,	[sp, #696]

    ldr	w24,	[x24]

    str	w24,	[sp, #704]

    ldr	w27,	[sp, #704]

    ldr	w24,	[sp, #2788]

    add	w28,	w24,	w27
    str	w28,	[sp, #2880]

    ldr	x24,	[sp, #712]

    str	x24,	[sp, #720]

    ldr	x24,	[sp, #720]

    ldr	w24,	[x24]

    str	w24,	[sp, #708]

    ldr	w27,	[sp, #708]

    ldr	w23,	[sp, #2880]

    add	w26,	w23,	w27
    str	w26,	[sp, #2792]

    ldr	x24,	[sp, #712]

    add	x24,	x24,	#4
    str	x24,	[sp, #728]

    ldr	x23,	[sp, #728]

    ldr	w24,	[x23]

    str	w24,	[sp, #736]

    ldr	w27,	[sp, #736]

    ldr	w28,	[sp, #2792]

    add	w24,	w28,	w27
    str	w24,	[sp, #2876]

    ldr	x24,	[sp, #744]

    str	x24,	[sp, #752]

    ldr	x26,	[sp, #752]

    ldr	w23,	[x26]

    str	w23,	[sp, #740]

    ldr	w28,	[sp, #740]

    ldr	w24,	[sp, #2876]

    add	w24,	w24,	w28
    str	w24,	[sp, #2796]

    ldr	x23,	[sp, #744]

    add	x23,	x23,	#4
    str	x23,	[sp, #760]

    ldr	x24,	[sp, #760]

    ldr	w26,	[x24]

    str	w26,	[sp, #768]

    ldr	w26,	[sp, #768]

    ldr	w24,	[sp, #2796]

    add	w26,	w24,	w26
    str	w26,	[sp, #2872]

    ldr	x24,	[sp, #776]

    str	x24,	[sp, fp]

    movz	fp,	#788
    ldr	x26,	[sp, fp]

    movz	fp,	#796
    ldr	w24,	[x26]

    str	w24,	[sp, #772]

    ldr	w26,	[sp, #772]

    ldr	w28,	[sp, #2872]

    add	w28,	w28,	w26
    str	w28,	[sp, #2800]

    ldr	x24,	[sp, #776]

    add	x23,	x24,	#4
    str	x23,	[sp, fp]

    movz	fp,	#796
    ldr	x24,	[sp, fp]

    movz	fp,	#812
    ldr	w26,	[x24]

    str	w26,	[sp, #804]

    ldr	w27,	[sp, #804]

    ldr	w23,	[sp, #2800]

    add	w23,	w23,	w27
    str	w23,	[sp, #2868]

    ldr	x24,	[sp, fp]

    movz	fp,	#828
    str	x24,	[sp, fp]

    movz	fp,	#828
    ldr	x24,	[sp, fp]

    movz	fp,	#812
    ldr	w24,	[x24]

    str	w24,	[sp, #808]

    ldr	w27,	[sp, #808]

    ldr	w24,	[sp, #2868]

    add	w24,	w24,	w27
    str	w24,	[sp, #2804]

    ldr	x24,	[sp, fp]

    movz	fp,	#836
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#836
    ldr	x23,	[sp, fp]

    movz	fp,	#852
    ldr	w24,	[x23]

    str	w24,	[sp, #844]

    ldr	w27,	[sp, #844]

    ldr	w26,	[sp, #2804]

    add	w24,	w26,	w27
    str	w24,	[sp, #2864]

    ldr	x23,	[sp, fp]

    movz	fp,	#868
    str	x23,	[sp, fp]

    movz	fp,	#868
    ldr	x24,	[sp, fp]

    movz	fp,	#852
    ldr	w23,	[x24]

    str	w23,	[sp, #848]

    ldr	w28,	[sp, #848]

    ldr	w26,	[sp, #2864]

    add	w23,	w26,	w28
    str	w23,	[sp, #2808]

    ldr	x23,	[sp, fp]

    movz	fp,	#876
    add	x26,	x23,	#4
    str	x26,	[sp, fp]

    movz	fp,	#876
    ldr	x24,	[sp, fp]

    movz	fp,	#892
    ldr	w24,	[x24]

    str	w24,	[sp, #884]

    ldr	w27,	[sp, #884]

    ldr	w24,	[sp, #2808]

    add	w28,	w24,	w27
    str	w28,	[sp, #2860]

    ldr	x24,	[sp, fp]

    movz	fp,	#908
    str	x24,	[sp, fp]

    movz	fp,	#908
    ldr	x23,	[sp, fp]

    movz	fp,	#892
    ldr	w24,	[x23]

    str	w24,	[sp, #888]

    ldr	w27,	[sp, #888]

    ldr	w23,	[sp, #2860]

    add	w26,	w23,	w27
    str	w26,	[sp, #2812]

    ldr	x24,	[sp, fp]

    movz	fp,	#916
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#916
    ldr	x26,	[sp, fp]

    movz	fp,	#932
    ldr	w23,	[x26]

    str	w23,	[sp, #924]

    ldr	w23,	[sp, #924]

    ldr	w28,	[sp, #2812]

    add	w24,	w28,	w23
    str	w24,	[sp, #2856]

    ldr	x26,	[sp, fp]

    movz	fp,	#948
    str	x26,	[sp, fp]

    movz	fp,	#948
    ldr	x24,	[sp, fp]

    movz	fp,	#932
    ldr	w26,	[x24]

    str	w26,	[sp, #928]

    ldr	w26,	[sp, #928]

    ldr	w24,	[sp, #2856]

    add	w24,	w24,	w26
    str	w24,	[sp, #2816]

    ldr	x26,	[sp, fp]

    movz	fp,	#956
    add	x24,	x26,	#4
    str	x24,	[sp, fp]

    movz	fp,	#956
    ldr	x24,	[sp, fp]

    movz	fp,	#972
    ldr	w24,	[x24]

    str	w24,	[sp, #964]

    ldr	w26,	[sp, #964]

    ldr	w24,	[sp, #2816]

    add	w26,	w24,	w26
    str	w26,	[sp, #2852]

    ldr	x24,	[sp, fp]

    movz	fp,	#980
    str	x24,	[sp, fp]

    movz	fp,	#980
    ldr	x23,	[sp, fp]

    movz	fp,	#972
    ldr	w24,	[x23]

    str	w24,	[sp, #968]

    ldr	w27,	[sp, #968]

    ldr	w28,	[sp, #2852]

    add	w28,	w28,	w27
    str	w28,	[sp, #2820]

    ldr	x24,	[sp, fp]

    movz	fp,	#988
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#988
    ldr	x26,	[sp, fp]

    movz	fp,	#1004
    ldr	w23,	[x26]

    str	w23,	[sp, #996]

    ldr	w28,	[sp, #996]

    ldr	w23,	[sp, #2820]

    add	w23,	w23,	w28
    str	w23,	[sp, #2848]

    ldr	x23,	[sp, fp]

    movz	fp,	#1012
    str	x23,	[sp, fp]

    movz	fp,	#1012
    ldr	x24,	[sp, fp]

    movz	fp,	#1004
    ldr	w26,	[x24]

    str	w26,	[sp, #1000]

    ldr	w27,	[sp, #1000]

    ldr	w24,	[sp, #2848]

    add	w24,	w24,	w27
    str	w24,	[sp, #2824]

    ldr	x26,	[sp, fp]

    movz	fp,	#1020
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1020
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x24]

    str	w24,	[sp, #1028]

    ldr	w24,	[sp, #1028]

    ldr	w26,	[sp, #2824]

    add	w24,	w26,	w24
    str	w24,	[sp, #2844]

    ldr	x24,	[sp, fp]

    movz	fp,	#1044
    str	x24,	[sp, fp]

    movz	fp,	#1044
    ldr	x24,	[sp, fp]

    movz	fp,	#1036
    ldr	w24,	[x24]

    str	w24,	[sp, #1032]

    ldr	w24,	[sp, #1032]

    ldr	w26,	[sp, #2844]

    add	w23,	w26,	w24
    str	w23,	[sp, #2828]

    ldr	x24,	[sp, fp]

    movz	fp,	#1052
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1052
    ldr	x23,	[sp, fp]

    movz	fp,	#1068
    ldr	w24,	[x23]

    str	w24,	[sp, #1060]

    ldr	w28,	[sp, #1060]

    ldr	w24,	[sp, #2828]

    add	w28,	w24,	w28
    ldr	x24,	[sp, fp]

    movz	fp,	#1076
    str	x24,	[sp, fp]

    movz	fp,	#1076
    ldr	x26,	[sp, fp]

    movz	fp,	#1068
    ldr	w23,	[x26]

    str	w23,	[sp, #1064]

    ldr	w24,	[sp, #1064]

    add	w26,	w28,	w24
    str	w26,	[sp, #2832]

    ldr	x23,	[sp, fp]

    movz	fp,	#1084
    add	x23,	x23,	#4
    str	x23,	[sp, fp]

    movz	fp,	#1084
    ldr	x24,	[sp, fp]

    movz	fp,	#1100
    ldr	w26,	[x24]

    str	w26,	[sp, #1092]

    ldr	w26,	[sp, #1092]

    ldr	w28,	[sp, #2832]

    add	w28,	w28,	w26
    str	w28,	[sp, #2840]

    ldr	x26,	[sp, fp]

    movz	fp,	#1108
    str	x26,	[sp, fp]

    movz	fp,	#1108
    ldr	x24,	[sp, fp]

    movz	fp,	#1100
    ldr	w24,	[x24]

    str	w24,	[sp, #1096]

    ldr	w27,	[sp, #1096]

    ldr	w23,	[sp, #2840]

    ldr	x24,	[sp, fp]

    add	w27,	w23,	w27
    movz	fp,	#1116
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1116
    ldr	x24,	[sp, fp]

    movz	fp,	#1132
    ldr	w24,	[x24]

    str	w24,	[sp, #1124]

    ldr	w23,	[sp, #1124]

    add	w24,	w27,	w23
    str	w24,	[sp, #2836]

    ldr	x24,	[sp, fp]

    movz	fp,	#1140
    str	x24,	[sp, fp]

    movz	fp,	#1140
    ldr	x23,	[sp, fp]

    movz	fp,	#1132
    ldr	w24,	[x23]

    str	w24,	[sp, #1128]

    ldr	w28,	[sp, #1128]

    ldr	w24,	[sp, #2836]

    add	w28,	w24,	w28
    ldr	x24,	[sp, fp]

    movz	fp,	#1148
    add	x24,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#1148
    ldr	x26,	[sp, fp]

    movz	fp,	#1164
    ldr	w23,	[x26]

    str	w23,	[sp, #1156]

    ldr	w24,	[sp, #1156]

    ldr	x23,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1172
    str	x23,	[sp, fp]

    movz	fp,	#1172
    ldr	x24,	[sp, fp]

    movz	fp,	#1164
    ldr	w26,	[x24]

    str	w26,	[sp, #1160]

    ldr	w24,	[sp, #1160]

    ldr	x26,	[sp, fp]

    add	w28,	w28,	w24
    movz	fp,	#1180
    add	x26,	x26,	#4
    str	x26,	[sp, fp]

    movz	fp,	#1180
    ldr	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	w24,	[x24]

    str	w24,	[sp, #1188]

    ldr	w24,	[sp, #1188]

    add	w27,	w28,	w24
    ldr	x24,	[sp, fp]

    movz	fp,	#1204
    str	x24,	[sp, fp]

    movz	fp,	#1204
    ldr	x24,	[sp, fp]

    movz	fp,	#1196
    ldr	w24,	[x24]

    str	w24,	[sp, #1192]

    ldr	w23,	[sp, #1192]

    ldr	x24,	[sp, fp]

    add	w28,	w27,	w23
    movz	fp,	#1228
    add	x24,	x24,	#4
    str	x24,	[sp, #1216]

    ldr	x23,	[sp, #1216]

    ldr	w24,	[x23]

    str	w24,	[sp, #1212]

    ldr	w26,	[sp, #1212]

    ldr	x24,	[sp, fp]

    add	w28,	w28,	w26
    movz	fp,	#1236
    str	x24,	[sp, fp]

    movz	fp,	#1236
    ldr	x26,	[sp, fp]

    movz	fp,	#1228
    ldr	w23,	[x26]

    str	w23,	[sp, #1224]

    ldr	w24,	[sp, #1224]

    ldr	x23,	[sp, fp]

    add	w26,	w28,	w24
    movz	fp,	#1500
    add	x24,	x23,	#4
    str	x24,	[sp, #1256]

    ldr	x23,	[sp, #1256]

    ldr	w24,	[x23]

    str	w24,	[sp, #1252]

    ldr	w24,	[sp, #1252]

    add	w23,	w26,	w24
    str	w23,	[sp, #1244]

    mov	x23,	x20
    ldr	x26,	[sp, #2600]

    ldr	w28,	[x26]

    ldr	w24,	[sp, #1244]

    ldr	x26,	[sp, #2600]

    add	w27,	w24,	w28
    add	x24,	x26,	#4
    ldr	w24,	[x24]

    add	w26,	w27,	w24
    add	x27,	x21,	#4
    ldr	x24,	[sp, #2592]

    ldr	w24,	[x24]

    add	w26,	w26,	w24
    str	w26,	[sp, #1248]

    ldr	x28,	[sp, #2592]

    add	x24,	x28,	#4
    ldr	w28,	[x24]

    ldr	w24,	[sp, #1248]

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
    movz	fp,	#1500
    ldr	w22,	[x26]

    ldr	x19,	[sp, fp]

    add	w24,	w20,	w28
    movz	fp,	#1508
    add	x28,	x19,	#4
    add	w26,	w24,	w22
    ldr	w19,	[x28]

    ldr	x22,	[sp, fp]

    add	w24,	w26,	w19
    movz	fp,	#1508
    ldr	w25,	[x22]

    add	x22,	x0,	#4
    add	w19,	w24,	w25
    ldr	x24,	[sp, fp]

    add	x26,	x24,	#4
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
    
    movz	fp,	#5856
    add	sp, sp, fp
    ret


main_109:
    ldr	w14,	[sp, #1472]

    movz	w25,	#1
    ldr	w9,	[sp, #652]

    sub	w23,	w14,	#1
    movk	w25,	#15232,	lsl #16
    ldr	w1,	[sp, #444]

    mov	w18,	w23
    mov	w6,	w25
    add	w7,	w1,	w9
    mov	w23,	w13
    str	w7,	[sp, #544]

    ldr	w1,	[sp, #544]

    sdiv	w20,	w1,	w6
    str	w20,	[sp, #540]

    ldr	w5,	[sp, #540]

    ldr	w9,	[sp, #544]

    str	w18,	[sp, #1472]

    msub	w1,	w5,	w6,	w9

    mov	w25,	w1
    str	w25,	[sp, #652]

    ldr	w25,	[sp, #2764]

    mov	w27,	w25
    str	w27,	[sp, #444]

    ldr	w7,	[sp, #1468]

    mov	w26,	w7
    str	w26,	[sp, #2764]

    ldr	w15,	[sp, #1464]

    mov	w8,	w15
    str	w8,	[sp, #1468]

    ldr	w9,	[sp, #1460]

    mov	w2,	w9
    str	w2,	[sp, #1464]

    ldr	w10,	[sp, #440]

    str	w10,	[sp, #1460]

    ldr	w16,	[sp, #428]

    mov	w22,	w16
    str	w22,	[sp, #440]

    ldr	w10,	[sp, #424]

    mov	w17,	w10
    str	w17,	[sp, #428]

    ldr	w6,	[sp, #1308]

    mov	w12,	w6
    str	w12,	[sp, #424]

    ldr	w1,	[sp, #1304]

    mov	w7,	w1
    str	w7,	[sp, #1308]

    ldr	w0,	[sp, #2768]

    mov	w2,	w0
    str	w2,	[sp, #1304]

    ldr	w10,	[sp, #1536]

    mov	w0,	w10
    str	w0,	[sp, #2768]

    ldr	w4,	[sp, #548]

    mov	w12,	w4
    str	w12,	[sp, #1536]

    ldr	w28,	[sp, #552]

    mov	w6,	w28
    str	w6,	[sp, #548]

    ldr	w1,	[sp, #4204]

    str	w1,	[sp, #552]

    ldr	w3,	[sp, #2772]

    mov	w2,	w3
    str	w2,	[sp, #4204]

    ldr	w20,	[sp, #4284]

    mov	w4,	w20
    str	w4,	[sp, #2772]

    ldr	w21,	[sp, #4280]

    str	w21,	[sp, #4284]

    ldr	w17,	[sp, #4196]

    str	w17,	[sp, #4280]

    ldr	w24,	[sp, #4200]

    str	w24,	[sp, #4196]

    ldr	w16,	[sp, #1540]

    mov	w28,	w16
    str	w28,	[sp, #4200]

    movz	w28,	#0
    ldr	w19,	[sp, #4192]

    mov	w21,	w28
    mov	w17,	w19
    str	w17,	[sp, #1540]

    ldr	w20,	[sp, #1532]

    str	w20,	[sp, #4192]

    ldr	w4,	[sp, #1596]

    mov	w17,	w4
    str	w17,	[sp, #1532]

    ldr	w7,	[sp, #2776]

    mov	w5,	w7
    str	w5,	[sp, #1596]

    ldr	w26,	[sp, #1588]

    mov	w8,	w26
    str	w8,	[sp, #2776]

    str	w23,	[sp, #1588]

    ldr	w26,	[sp, #1592]

    ldr	w10,	[sp, #3284]

    mov	w13,	w26
    mov	w1,	w10
    str	w1,	[sp, #1592]

    ldr	w12,	[sp, #2944]

    str	w12,	[sp, #3284]

    str	w21,	[sp, #2944]

    b	main_75

main_35:
    ldr	w23,	[sp, #1476]

    mov	w25,	w23
    b	main_36

