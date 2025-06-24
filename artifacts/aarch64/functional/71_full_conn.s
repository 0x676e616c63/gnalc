.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2464
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x9,	sp,	#16
    movz	fp,	#164
    mov	w6,	w0
    mov	x25,	x9
    add	x10,	x25,	#16
    add	x7,	x25,	#12
    add	x19,	x9,	#80
    add	x3,	x9,	#60
    add	x2,	x25,	#4
    add	x22,	x25,	#8
    mov	x27,	x25
    mov	x4,	x3
    add	x28,	x19,	#12
    add	x16,	x3,	#16
    add	x25,	x19,	#8
    str	x27,	[sp, fp]

    movz	fp,	#124
    str	x2,	[sp, fp]

    movz	fp,	#244
    str	x22,	[sp, #272]

    add	x22,	x19,	#4
    str	x7,	[sp, #416]

    add	x7,	x9,	#20
    str	x10,	[sp, fp]

    mov	x13,	x7
    add	x10,	x3,	#8
    movz	fp,	#252
    add	x2,	x7,	#16
    add	x27,	x7,	#12
    add	x24,	x7,	#8
    add	x21,	x7,	#4
    str	x13,	[sp, fp]

    add	x7,	x9,	#40
    add	x13,	x3,	#12
    movz	fp,	#284
    str	x21,	[sp, #320]

    mov	x5,	x7
    add	x1,	x7,	#16
    add	x26,	x7,	#12
    add	x23,	x7,	#8
    add	x8,	x7,	#4
    str	x24,	[sp, #368]

    add	x7,	x3,	#4
    str	x27,	[sp, fp]

    add	x3,	x19,	#16
    movz	fp,	#292
    str	x2,	[sp, fp]

    movz	fp,	#300
    str	x5,	[sp, fp]

    movz	fp,	#260
    str	x8,	[sp, #384]

    str	x23,	[sp, fp]

    movz	fp,	#188
    str	x26,	[sp, #328]

    str	x1,	[sp, #336]

    str	x4,	[sp, #344]

    str	x7,	[sp, #352]

    str	x10,	[sp, #360]

    str	x13,	[sp, fp]

    movz	fp,	#196
    str	x16,	[sp, fp]

    movz	fp,	#204
    str	x19,	[sp, fp]

    movz	fp,	#212
    str	x22,	[sp, fp]

    str	x25,	[sp, #432]

    str	x28,	[sp, #440]

    str	x3,	[sp, #448]

    str	w6,	[sp, #404]


main_37:
    movz	w28,	#0
    mov	w24,	w28

main_40:
    lsl	w10,	w24,	#2
    movz	w4,	#0
    mov	w21,	w4
    add	w14,	w10,	w24,	lsl #4
    mov	x22,	x14
    add	x22,	sp,	x22
    add	x22,	x22,	#16

main_43:
    cmp	w21,	#5
    bge	main_50

main_46:
    lsl	w20,	w21,	#2
    add	x20,	x22,	x20
    bl	getint
    add	w14,	w21,	#1
    str	w0,	[x20]

    mov	w21,	w14
    b	main_43

main_50:
    add	w20,	w24,	#1
    cmp	w20,	#5
    blt	main_39

main_53:
    movz	fp,	#164
    movz	w24,	#85
    movz	w25,	#23
    movz	w28,	#65454
    movz	w15,	#65413
    movz	w22,	#65477
    ldr	x18,	[sp, fp]

    mov	w21,	w24
    movk	w28,	#65535,	lsl #16
    movk	w15,	#65535,	lsl #16
    movk	w22,	#65535,	lsl #16
    ldr	w11,	[x18]

    movz	fp,	#124
    movz	w24,	#65425
    mov	w19,	w15
    str	w11,	[sp, #1084]

    movk	w24,	#65535,	lsl #16
    ldr	w0,	[sp, #1084]

    mul	w8,	w0,	w21
    ldr	x21,	[sp, fp]

    ldr	w17,	[x21]

    movz	fp,	#244
    str	w17,	[sp, #460]

    mov	w17,	w25
    ldr	w18,	[sp, #460]

    madd	w0,	w18,	w17,	w8

    ldr	x12,	[sp, #272]

    mov	w8,	w28
    ldr	w26,	[x12]

    str	w26,	[sp, #1024]

    ldr	w27,	[sp, #1024]

    movz	w26,	#65430
    madd	w17,	w27,	w8,	w0

    movk	w26,	#65535,	lsl #16
    str	w17,	[sp, #1212]

    ldr	x25,	[sp, #416]

    ldr	w4,	[x25]

    str	w4,	[sp, #1040]

    movz	w25,	#65433
    movk	w25,	#65535,	lsl #16
    mov	w7,	w25
    str	w7,	[sp, #280]

    ldr	x28,	[sp, fp]

    movz	fp,	#252
    ldr	w17,	[x28]

    str	w17,	[sp, #1060]

    str	w19,	[sp, #148]

    ldr	x2,	[sp, fp]

    ldr	w20,	[x2]

    movz	fp,	#284
    str	w20,	[sp, #456]

    ldr	w21,	[sp, #456]

    lsl	w7,	w21,	#6
    movz	w21,	#50
    str	w7,	[sp, #1080]

    mov	w20,	w21
    ldr	x10,	[sp, #320]

    mov	w21,	w26
    ldr	w27,	[x10]

    str	w27,	[sp, #1076]

    mov	w10,	w22
    ldr	w28,	[sp, #1076]

    neg	w4,	w28
    movz	w28,	#65434
    lsl	w25,	w4,	#7
    movk	w28,	#65535,	lsl #16
    sub	w23,	w25,	w4,	lsl #3
    mov	w4,	w24
    str	w23,	[sp, #1188]

    ldr	x13,	[sp, #368]

    ldr	w1,	[x13]

    str	w1,	[sp, #1068]

    str	w20,	[sp, #1228]

    ldr	x16,	[sp, fp]

    movz	fp,	#292
    ldr	w3,	[x16]

    str	w3,	[sp, #468]

    str	w10,	[sp, #1196]

    ldr	x19,	[sp, fp]

    ldr	w14,	[x19]

    movz	fp,	#300
    str	w14,	[sp, #1072]

    ldr	x22,	[sp, fp]

    ldr	w8,	[x22]

    movz	fp,	#260
    str	w8,	[sp, #1100]

    mov	w8,	w28
    str	w4,	[sp, #1216]

    ldr	x25,	[sp, #384]

    ldr	w19,	[x25]

    str	w19,	[sp, #412]

    movz	w25,	#65469
    movz	w19,	#65497
    movk	w25,	#65535,	lsl #16
    movk	w19,	#65535,	lsl #16
    mov	w4,	w25
    mov	w10,	w19
    str	w4,	[sp, #1780]

    movz	w19,	#46
    ldr	x11,	[sp, fp]

    ldr	w27,	[x11]

    movz	fp,	#188
    str	w27,	[sp, #392]

    mov	w11,	w19
    str	w21,	[sp, #136]

    movz	w27,	#65461
    ldr	x14,	[sp, #328]

    movk	w27,	#65535,	lsl #16
    ldr	w2,	[x14]

    str	w2,	[sp, #1012]

    mov	w14,	w27
    str	w14,	[sp, #144]

    ldr	x17,	[sp, #336]

    ldr	w22,	[x17]

    str	w22,	[sp, #408]

    str	w8,	[sp, #1784]

    ldr	x20,	[sp, #344]

    ldr	w6,	[x20]

    str	w6,	[sp, #1136]

    ldr	w7,	[sp, #1136]

    lsl	w0,	w7,	#1
    ldr	w8,	[sp, #1136]

    add	w21,	w0,	w8,	lsl #5
    str	w21,	[sp, #1368]

    ldr	x23,	[sp, #352]

    ldr	w22,	[x23]

    str	w22,	[sp, #1104]

    str	w10,	[sp, #1748]

    ldr	x26,	[sp, #360]

    ldr	w4,	[x26]

    str	w4,	[sp, #308]

    ldr	w5,	[sp, #308]

    lsl	w22,	w5,	#0
    ldr	w6,	[sp, #308]

    add	w24,	w22,	w6,	lsl #6
    str	w24,	[sp, #1372]

    ldr	x0,	[sp, fp]

    ldr	w14,	[x0]

    movz	fp,	#196
    str	w14,	[sp, #1016]

    ldr	x3,	[sp, fp]

    ldr	w9,	[x3]

    movz	fp,	#204
    str	w9,	[sp, #1028]

    movz	w9,	#113
    str	w9,	[sp, #1352]

    ldr	x6,	[sp, fp]

    movz	w9,	#110
    ldr	w7,	[x6]

    movz	fp,	#212
    mov	w0,	w9
    str	w7,	[sp, #1112]

    str	w0,	[sp, #1340]

    ldr	x9,	[sp, fp]

    ldr	w21,	[x9]

    str	w21,	[sp, #1124]

    ldr	x12,	[sp, #432]

    ldr	w5,	[x12]

    str	w5,	[sp, #472]

    ldr	w6,	[sp, #472]

    neg	w9,	w6
    lsl	w14,	w9,	#2
    str	w14,	[sp, #1456]

    ldr	x15,	[sp, #440]

    ldr	w24,	[x15]

    str	w24,	[sp, #1088]

    ldr	w25,	[sp, #1088]

    lsl	w24,	w25,	#4
    ldr	w13,	[sp, #1088]

    add	w20,	w24,	w13,	lsl #6
    str	w20,	[sp, #2400]

    ldr	x18,	[sp, #448]

    ldr	w5,	[x18]

    str	w5,	[sp, #1032]

    ldr	w21,	[sp, #1016]

    ldr	w10,	[sp, #1072]

    add	w26,	w21,	w10
    ldr	w0,	[sp, #1124]

    ldr	w13,	[sp, #280]

    add	w27,	w26,	w0
    movz	w0,	#47
    mov	w5,	w0
    ldr	w0,	[sp, #1040]

    ldr	w4,	[sp, #1212]

    madd	w14,	w0,	w13,	w4

    ldr	w20,	[sp, #148]

    ldr	w23,	[sp, #1060]

    ldr	w13,	[sp, #1080]

    madd	w24,	w23,	w20,	w14

    ldr	w0,	[sp, #1188]

    add	w6,	w24,	w13
    ldr	w10,	[sp, #1068]

    ldr	w7,	[sp, #1228]

    add	w12,	w6,	w0
    ldr	w24,	[sp, #468]

    ldr	w0,	[sp, #1196]

    ldr	w6,	[sp, #1100]

    madd	w15,	w10,	w7,	w12

    ldr	w21,	[sp, #1216]

    madd	w24,	w24,	w0,	w15

    ldr	w12,	[sp, #412]

    madd	w9,	w6,	w21,	w24

    ldr	w1,	[sp, #1780]

    madd	w8,	w12,	w1,	w9

    ldr	w7,	[sp, #136]

    ldr	w1,	[sp, #392]

    madd	w8,	w1,	w7,	w8

    ldr	w7,	[sp, #144]

    ldr	w12,	[sp, #1012]

    ldr	w10,	[sp, #408]

    madd	w9,	w12,	w7,	w8

    ldr	w1,	[sp, #1784]

    madd	w15,	w10,	w1,	w9

    ldr	w28,	[sp, #1368]

    add	w19,	w15,	w28
    ldr	w13,	[sp, #1104]

    ldr	w1,	[sp, #1748]

    ldr	w0,	[sp, #1372]

    madd	w16,	w13,	w1,	w19

    ldr	w10,	[sp, #1028]

    add	w23,	w16,	w0
    ldr	w0,	[sp, #1352]

    ldr	w28,	[sp, #1112]

    madd	w19,	w10,	w0,	w23

    ldr	w12,	[sp, #1340]

    madd	w22,	w28,	w12,	w19

    ldr	w15,	[sp, #1456]

    madd	w0,	w27,	w5,	w22

    add	w26,	w0,	w15
    ldr	w5,	[sp, #2400]

    ldr	w6,	[sp, #1032]

    add	w24,	w26,	w5
    madd	w2,	w6,	w11,	w24

    cmp	w2,	#0
    movz	w24,	#0
    mov	w26,	w24
    csel	w21,	w26,	w2,	lt
    cmp	w2,	#127
    movz	w15,	#65415
    movz	w26,	#39
    movz	w0,	#127
    movz	w3,	#65494
    movk	w15,	#65535,	lsl #16
    mov	w24,	w26
    mov	w25,	w0
    movk	w3,	#65535,	lsl #16
    csel	w16,	w25,	w21,	gt
    movz	w25,	#65493
    mul	w26,	w16,	w24
    movk	w25,	#65535,	lsl #16
    str	w26,	[sp, #1336]

    mov	w21,	w25
    ldr	w19,	[sp, #460]

    movz	w26,	#47
    movz	w25,	#65436
    lsl	w9,	w19,	#7
    ldr	w20,	[sp, #460]

    movk	w25,	#65535,	lsl #16
    mov	w19,	w26
    sub	w5,	w9,	w20,	lsl #1
    mov	w26,	w15
    str	w5,	[sp, #1732]

    ldr	w28,	[sp, #1024]

    neg	w22,	w28
    lsl	w10,	w22,	#1
    add	w2,	w10,	w22,	lsl #4
    movz	w22,	#65411
    movk	w22,	#65535,	lsl #16
    str	w2,	[sp, #1920]

    ldr	w4,	[sp, #1060]

    neg	w18,	w4
    lsl	w28,	w18,	#3
    movz	w4,	#65514
    movz	w18,	#65442
    movk	w4,	#65535,	lsl #16
    str	w28,	[sp, #1436]

    movk	w18,	#65535,	lsl #16
    mov	w27,	w4
    str	w19,	[sp, #1424]

    mov	w13,	w18
    ldr	w16,	[sp, #1076]

    neg	w19,	w16
    lsl	w11,	w19,	#2
    movz	w16,	#67
    mov	w19,	w16
    str	w11,	[sp, #2076]

    str	w19,	[sp, #512]

    str	w26,	[sp, #316]

    movz	w19,	#65515
    ldr	w11,	[sp, #1100]

    movk	w19,	#65535,	lsl #16
    lsl	w0,	w11,	#3
    ldr	w12,	[sp, #1100]

    mov	w28,	w19
    mov	w11,	w25
    sub	w14,	w0,	w12,	lsl #0
    str	w14,	[sp, #2080]

    str	w28,	[sp, #1772]

    mov	w14,	w3
    ldr	w26,	[sp, #392]

    neg	w15,	w26
    lsl	w6,	w15,	#6
    sub	w8,	w6,	w15,	lsl #2
    movz	w6,	#105
    mov	w12,	w6
    str	w8,	[sp, #1252]

    str	w21,	[sp, #476]

    str	w12,	[sp, #1620]

    str	w14,	[sp, #2108]

    movz	w12,	#87
    mov	w21,	w12
    movz	w12,	#29
    mov	w3,	w12
    str	w3,	[sp, #1396]

    movz	w3,	#65426
    movk	w3,	#65535,	lsl #16
    mov	w0,	w3
    str	w0,	[sp, #312]

    mov	w3,	w22
    str	w11,	[sp, #1256]

    str	w27,	[sp, #528]

    ldr	w2,	[sp, #144]

    mov	w10,	w2
    str	w10,	[sp, #500]

    str	w3,	[sp, #132]

    ldr	w2,	[sp, #1028]

    ldr	w3,	[sp, #1040]

    add	w22,	w2,	w3
    ldr	w28,	[sp, #1016]

    neg	w10,	w22
    ldr	w0,	[sp, #1084]

    lsl	w22,	w10,	#5
    add	w15,	w28,	w0
    ldr	w17,	[sp, #136]

    sub	w3,	w22,	w10,	lsl #0
    mov	w11,	w17
    str	w11,	[sp, #1452]

    ldr	w6,	[sp, #1732]

    ldr	w19,	[sp, #1920]

    ldr	w28,	[sp, #1436]

    add	w24,	w19,	w6
    ldr	w8,	[sp, #456]

    ldr	w0,	[sp, #1424]

    add	w6,	w24,	w28
    ldr	w22,	[sp, #2076]

    ldr	w7,	[sp, #1068]

    ldr	w17,	[sp, #512]

    madd	w18,	w8,	w0,	w6

    ldr	w24,	[sp, #468]

    add	w2,	w18,	w22
    ldr	w19,	[sp, #316]

    ldr	w0,	[sp, #1072]

    ldr	w26,	[sp, #2080]

    madd	w5,	w7,	w17,	w2

    madd	w18,	w24,	w13,	w5

    madd	w0,	w0,	w19,	w18

    add	w16,	w0,	w26
    ldr	w0,	[sp, #412]

    ldr	w5,	[sp, #1772]

    madd	w23,	w0,	w5,	w16

    ldr	w2,	[sp, #1252]

    add	w26,	w23,	w2
    ldr	w18,	[sp, #1012]

    ldr	w27,	[sp, #476]

    ldr	w6,	[sp, #408]

    madd	w5,	w18,	w27,	w26

    ldr	w12,	[sp, #1620]

    ldr	w0,	[sp, #1136]

    madd	w12,	w6,	w12,	w5

    ldr	w17,	[sp, #2108]

    madd	w24,	w0,	w17,	w12

    ldr	w12,	[sp, #1104]

    madd	w24,	w12,	w21,	w24

    ldr	w10,	[sp, #308]

    ldr	w7,	[sp, #1396]

    ldr	w11,	[sp, #1452]

    madd	w14,	w10,	w7,	w24

    ldr	w18,	[sp, #312]

    madd	w16,	w15,	w11,	w14

    ldr	w0,	[sp, #1112]

    add	w25,	w16,	w3
    ldr	w23,	[sp, #1124]

    ldr	w5,	[sp, #1256]

    madd	w26,	w0,	w18,	w25

    ldr	w7,	[sp, #472]

    madd	w9,	w23,	w5,	w26

    ldr	w2,	[sp, #528]

    madd	w10,	w7,	w2,	w9

    ldr	w27,	[sp, #1088]

    ldr	w18,	[sp, #500]

    ldr	w24,	[sp, #132]

    madd	w0,	w27,	w18,	w10

    ldr	w7,	[sp, #1032]

    madd	w0,	w7,	w24,	w0

    cmp	w0,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w9,	w9,	w0,	lt
    cmp	w0,	#127
    movz	w20,	#127
    movz	w16,	#76
    movz	w15,	#26
    movz	w14,	#77
    movz	w18,	#65466
    movz	w21,	#65441
    mov	w25,	w20
    mov	w22,	w15
    mov	w24,	w14
    movk	w18,	#65535,	lsl #16
    movk	w21,	#65535,	lsl #16
    csel	w13,	w25,	w9,	gt
    mov	w15,	w16
    mov	w2,	w18
    mov	w5,	w21
    ldr	w9,	[sp, #1336]

    movz	w25,	#65498
    madd	w27,	w13,	w24,	w9

    movk	w25,	#65535,	lsl #16
    str	w27,	[sp, #1376]

    movz	w13,	#39
    ldr	w1,	[sp, #1084]

    mov	w16,	w13
    mul	w1,	w1,	w22
    ldr	w27,	[sp, #460]

    movz	w22,	#52
    madd	w1,	w27,	w15,	w1

    str	w2,	[sp, #268]

    mov	w14,	w22
    ldr	w3,	[sp, #268]

    mov	w22,	w25
    ldr	w19,	[sp, #1024]

    madd	w2,	w19,	w3,	w1

    ldr	w7,	[sp, #1040]

    movz	w19,	#29
    str	w5,	[sp, #424]

    mov	w18,	w19
    ldr	w6,	[sp, #424]

    madd	w0,	w7,	w18,	w2

    ldr	w5,	[sp, #1060]

    madd	w10,	w5,	w6,	w0

    ldr	w0,	[sp, #456]

    lsl	w26,	w0,	#5
    ldr	w0,	[sp, #456]

    add	w20,	w26,	w0,	lsl #6
    ldr	w1,	[sp, #1076]

    movz	w26,	#27
    ldr	w18,	[sp, #1068]

    ldr	w15,	[sp, #468]

    add	w0,	w10,	w20
    ldr	w17,	[sp, #1072]

    madd	w24,	w1,	w14,	w0

    neg	w0,	w18
    neg	w1,	w15
    lsl	w10,	w0,	#2
    lsl	w14,	w1,	#0
    add	w18,	w10,	w0,	lsl #6
    add	w21,	w14,	w1,	lsl #2
    mov	w14,	w26
    lsl	w1,	w17,	#1
    add	w28,	w24,	w18
    ldr	w18,	[sp, #1072]

    add	w0,	w1,	w18,	lsl #5
    add	w24,	w28,	w21
    add	w15,	w24,	w0
    ldr	w0,	[sp, #1100]

    neg	w10,	w0
    ldr	w28,	[sp, #412]

    lsl	w24,	w10,	#1
    ldr	w1,	[sp, #392]

    lsl	w1,	w1,	#1
    ldr	w2,	[sp, #392]

    add	w9,	w24,	w10,	lsl #5
    ldr	w5,	[sp, #1012]

    movz	w24,	#102
    mov	w18,	w24
    add	w0,	w15,	w9
    add	w15,	w1,	w2,	lsl #2
    movz	w9,	#110
    madd	w18,	w28,	w18,	w0

    add	w0,	w18,	w15
    madd	w24,	w5,	w22,	w0

    ldr	w0,	[sp, #408]

    madd	w1,	w0,	w14,	w24

    ldr	w10,	[sp, #1136]

    mov	w14,	w9
    ldr	w0,	[sp, #1104]

    madd	w23,	w10,	w14,	w1

    ldr	w8,	[sp, #308]

    movz	w10,	#116
    movz	w14,	#65437
    movk	w14,	#65535,	lsl #16
    madd	w1,	w0,	w10,	w23

    madd	w18,	w8,	w16,	w1

    ldr	w0,	[sp, #1016]

    neg	w19,	w0
    ldr	w12,	[sp, #1028]

    lsl	w0,	w19,	#6
    ldr	w10,	[sp, #1112]

    ldr	w11,	[sp, #1112]

    sub	w15,	w0,	w19,	lsl #0
    ldr	w0,	[sp, #1124]

    add	w1,	w18,	w15
    movz	w15,	#94
    mov	w16,	w15
    madd	w21,	w12,	w14,	w1

    lsl	w1,	w10,	#0
    add	w28,	w1,	w11,	lsl #6
    add	w10,	w21,	w28
    lsl	w28,	w0,	#7
    ldr	w0,	[sp, #1124]

    sub	w0,	w28,	w0,	lsl #3
    ldr	w22,	[sp, #1748]

    ldr	w8,	[sp, #472]

    ldr	w21,	[sp, #1088]

    add	w9,	w10,	w0
    neg	w1,	w21
    mov	w0,	w22
    lsl	w10,	w1,	#1
    madd	w14,	w8,	w0,	w9

    add	w20,	w10,	w1,	lsl #2
    ldr	w0,	[sp, #1032]

    add	w20,	w14,	w20
    madd	w0,	w0,	w16,	w20

    cmp	w0,	#0
    movz	w16,	#0
    mov	w13,	w16
    csel	w25,	w13,	w0,	lt
    cmp	w0,	#127
    movz	w15,	#50
    ldr	w2,	[sp, #1376]

    movz	w19,	#127
    movz	w16,	#122
    movz	w21,	#49
    mov	w9,	w19
    mov	w23,	w16
    mov	w28,	w21
    csel	w22,	w9,	w25,	gt
    lsl	w26,	w22,	#7
    sub	w25,	w26,	w22,	lsl #0
    mov	w26,	w15
    add	w18,	w2,	w25
    movz	w25,	#125
    mov	w11,	w25
    str	w18,	[sp, #1536]

    movz	w25,	#11
    ldr	w22,	[sp, #460]

    movz	w18,	#85
    mov	w20,	w25
    neg	w24,	w22
    lsl	w9,	w24,	#6
    sub	w17,	w9,	w24,	lsl #0
    str	w17,	[sp, #2396]

    ldr	w21,	[sp, #1060]

    mov	w17,	w18
    lsl	w13,	w21,	#3
    ldr	w22,	[sp, #1060]

    add	w14,	w13,	w22,	lsl #6
    str	w14,	[sp, #1524]

    ldr	w2,	[sp, #1076]

    neg	w14,	w2
    lsl	w15,	w14,	#5
    sub	w4,	w15,	w14,	lsl #1
    movz	w14,	#110
    movz	w15,	#83
    mov	w1,	w14
    str	w4,	[sp, #1504]

    movz	w14,	#65489
    ldr	w5,	[sp, #1068]

    movk	w14,	#65535,	lsl #16
    lsl	w24,	w5,	#2
    ldr	w6,	[sp, #1068]

    mov	w5,	w15
    add	w7,	w24,	w6,	lsl #3
    str	w7,	[sp, #1508]

    str	w11,	[sp, #1316]

    ldr	w0,	[sp, #1100]

    neg	w18,	w0
    lsl	w19,	w18,	#0
    movz	w0,	#118
    mov	w25,	w0
    add	w24,	w19,	w18,	lsl #6
    movz	w0,	#65419
    movk	w0,	#65535,	lsl #16
    str	w24,	[sp, #1476]

    str	w1,	[sp, #1668]

    ldr	w12,	[sp, #408]

    mov	w1,	w14
    neg	w21,	w12
    lsl	w22,	w21,	#5
    sub	w8,	w22,	w21,	lsl #0
    mov	w21,	w0
    str	w8,	[sp, #220]

    ldr	w12,	[sp, #148]

    mov	w2,	w12
    str	w2,	[sp, #1160]

    str	w5,	[sp, #1164]

    str	w23,	[sp, #2120]

    str	w20,	[sp, #2116]

    str	w1,	[sp, #488]

    ldr	w27,	[sp, #1124]

    neg	w2,	w27
    movz	w27,	#95
    lsl	w16,	w2,	#5
    mov	w5,	w27
    movz	w2,	#125
    str	w16,	[sp, #508]

    mov	w13,	w2
    str	w5,	[sp, #1444]

    str	w25,	[sp, #1720]

    ldr	w8,	[sp, #472]

    ldr	w1,	[sp, #1072]

    add	w10,	w8,	w1
    str	w10,	[sp, #1412]

    str	w21,	[sp, #1676]

    ldr	w1,	[sp, #392]

    ldr	w0,	[sp, #468]

    add	w4,	w1,	w0
    ldr	w23,	[sp, #1028]

    ldr	w0,	[sp, #1084]

    add	w25,	w23,	w0
    movz	w0,	#65513
    movk	w0,	#65535,	lsl #16
    mov	w2,	w0
    str	w2,	[sp, #176]

    ldr	w6,	[sp, #1024]

    ldr	w27,	[sp, #2396]

    madd	w11,	w6,	w28,	w27

    ldr	w5,	[sp, #1040]

    madd	w3,	w5,	w26,	w11

    ldr	w12,	[sp, #1524]

    add	w5,	w3,	w12
    ldr	w6,	[sp, #456]

    ldr	w0,	[sp, #1504]

    ldr	w3,	[sp, #1508]

    madd	w10,	w6,	w17,	w5

    ldr	w22,	[sp, #1476]

    add	w2,	w10,	w0
    add	w5,	w2,	w3
    ldr	w2,	[sp, #412]

    ldr	w12,	[sp, #1780]

    add	w8,	w5,	w22
    ldr	w19,	[sp, #1012]

    ldr	w26,	[sp, #1668]

    madd	w1,	w2,	w12,	w8

    madd	w4,	w4,	w13,	w1

    ldr	w1,	[sp, #220]

    madd	w6,	w19,	w26,	w4

    ldr	w22,	[sp, #1136]

    add	w4,	w6,	w1
    ldr	w0,	[sp, #1160]

    madd	w3,	w22,	w0,	w4

    ldr	w0,	[sp, #1104]

    ldr	w5,	[sp, #1164]

    madd	w2,	w0,	w5,	w3

    ldr	w12,	[sp, #308]

    ldr	w14,	[sp, #2120]

    ldr	w28,	[sp, #1016]

    madd	w23,	w12,	w14,	w2

    ldr	w6,	[sp, #2116]

    ldr	w3,	[sp, #176]

    madd	w16,	w28,	w6,	w23

    ldr	w1,	[sp, #1112]

    madd	w23,	w25,	w3,	w16

    ldr	w8,	[sp, #488]

    madd	w13,	w1,	w8,	w23

    ldr	w19,	[sp, #508]

    add	w16,	w13,	w19
    ldr	w9,	[sp, #1412]

    ldr	w0,	[sp, #1676]

    madd	w15,	w9,	w0,	w16

    ldr	w0,	[sp, #1088]

    ldr	w20,	[sp, #1444]

    ldr	w25,	[sp, #1032]

    madd	w21,	w0,	w20,	w15

    ldr	w6,	[sp, #1720]

    madd	w4,	w25,	w6,	w21

    cmp	w4,	#0
    movz	w21,	#0
    mov	w14,	w21
    csel	w0,	w14,	w4,	lt
    cmp	w4,	#127
    movz	w14,	#65420
    ldr	w24,	[sp, #136]

    movz	w26,	#101
    movz	w1,	#127
    movk	w14,	#65535,	lsl #16
    ldr	w19,	[sp, #1536]

    mov	w20,	w24
    mov	w13,	w1
    movz	w24,	#82
    csel	w10,	w13,	w0,	gt
    madd	w1,	w10,	w20,	w19

    str	w1,	[sp, #1380]

    mov	w19,	w24
    movz	w10,	#65432
    ldr	w16,	[sp, #1084]

    mov	w24,	w26
    movk	w10,	#65535,	lsl #16
    ldr	w23,	[sp, #460]

    lsl	w13,	w16,	#3
    mov	w0,	w10
    mov	w16,	w14
    madd	w15,	w23,	w19,	w13

    str	w0,	[sp, #1768]

    movz	w19,	#79
    ldr	w2,	[sp, #1024]

    ldr	w25,	[sp, #1768]

    ldr	w9,	[sp, #1040]

    madd	w2,	w2,	w25,	w15

    str	w16,	[sp, #1108]

    madd	w18,	w9,	w24,	w2

    ldr	w0,	[sp, #1060]

    ldr	w1,	[sp, #1108]

    madd	w22,	w0,	w1,	w18

    ldr	w5,	[sp, #456]

    ldr	w18,	[sp, #1076]

    neg	w9,	w5
    neg	w16,	w18
    ldr	w4,	[sp, #268]

    lsl	w14,	w9,	#6
    ldr	w7,	[sp, #1068]

    ldr	w8,	[sp, #468]

    sub	w10,	w14,	w9,	lsl #0
    ldr	w0,	[sp, #1316]

    lsl	w14,	w16,	#4
    ldr	w26,	[sp, #1072]

    add	w24,	w22,	w10
    mov	w10,	w4
    add	w2,	w24,	w14
    ldr	w14,	[sp, #1100]

    lsl	w13,	w14,	#1
    ldr	w15,	[sp, #1100]

    madd	w16,	w7,	w10,	w2

    movz	w14,	#65422
    ldr	w6,	[sp, #412]

    madd	w1,	w8,	w0,	w16

    movz	w10,	#75
    movk	w14,	#65535,	lsl #16
    ldr	w4,	[sp, #392]

    add	w0,	w13,	w15,	lsl #6
    movz	w16,	#116
    mov	w9,	w10
    neg	w15,	w6
    movz	w13,	#65435
    madd	w24,	w26,	w9,	w1

    lsl	w27,	w15,	#5
    movk	w13,	#65535,	lsl #16
    add	w18,	w24,	w0
    mov	w1,	w14
    add	w9,	w27,	w15,	lsl #6
    mov	w24,	w13
    str	w1,	[sp, #172]

    movz	w15,	#59
    ldr	w2,	[sp, #172]

    add	w20,	w18,	w9
    mov	w21,	w15
    ldr	w25,	[sp, #1012]

    movz	w18,	#65443
    mov	w15,	w16
    ldr	w8,	[sp, #408]

    madd	w7,	w4,	w24,	w20

    movk	w18,	#65535,	lsl #16
    madd	w28,	w25,	w2,	w7

    madd	w10,	w8,	w21,	w28

    ldr	w2,	[sp, #1136]

    movz	w21,	#49
    lsl	w0,	w2,	#2
    ldr	w5,	[sp, #1136]

    add	w28,	w0,	w5,	lsl #3
    ldr	w22,	[sp, #1104]

    lsl	w0,	w22,	#0
    ldr	w26,	[sp, #1104]

    ldr	w7,	[sp, #424]

    add	w14,	w10,	w28
    add	w0,	w0,	w26,	lsl #2
    mov	w9,	w7
    ldr	w10,	[sp, #308]

    ldr	w2,	[sp, #1016]

    add	w26,	w14,	w0
    ldr	w0,	[sp, #1028]

    mov	w14,	w18
    madd	w13,	w10,	w9,	w26

    mov	w10,	w19
    mov	w26,	w21
    madd	w27,	w2,	w15,	w13

    ldr	w2,	[sp, #1112]

    madd	w25,	w0,	w14,	w27

    ldr	w7,	[sp, #1112]

    lsl	w0,	w2,	#4
    ldr	w27,	[sp, #1124]

    sub	w18,	w0,	w7,	lsl #0
    add	w1,	w25,	w18
    madd	w13,	w27,	w10,	w1

    ldr	w27,	[sp, #472]

    ldr	w2,	[sp, #472]

    lsl	w0,	w27,	#0
    ldr	w23,	[sp, #1088]

    add	w0,	w0,	w2,	lsl #1
    add	w10,	w13,	w0
    madd	w18,	w23,	w26,	w10

    ldr	w10,	[sp, #1032]

    neg	w1,	w10
    lsl	w10,	w1,	#7
    sub	w13,	w10,	w1,	lsl #2
    add	w10,	w18,	w13
    cmp	w10,	#0
    movz	w22,	#0
    mov	w19,	w22
    csel	w22,	w19,	w10,	lt
    cmp	w10,	#127
    ldr	w5,	[sp, #1380]

    movz	w13,	#55
    movz	w25,	#81
    movz	w10,	#127
    movz	w2,	#0
    movz	w11,	#65486
    mov	w6,	w25
    mov	w15,	w10
    movk	w11,	#65535,	lsl #16
    csel	w26,	w15,	w22,	gt
    neg	w15,	w26
    movz	w22,	#101
    lsl	w24,	w15,	#0
    add	w9,	w24,	w15,	lsl #1
    add	w16,	w5,	w9
    mov	w5,	w22
    movz	w22,	#38
    str	w16,	[sp, #1708]

    mov	w17,	w22
    ldr	w24,	[sp, #460]

    ldr	w0,	[sp, #460]

    lsl	w16,	w24,	#2
    ldr	w23,	[sp, #1084]

    add	w14,	w16,	w0,	lsl #6
    ldr	w21,	[sp, #1784]

    mov	w0,	w21
    ldr	w3,	[sp, #1024]

    movz	w21,	#65462
    madd	w15,	w23,	w6,	w14

    movk	w21,	#65535,	lsl #16
    madd	w14,	w3,	w0,	w15

    movz	w6,	#65482
    mov	w0,	w21
    movz	w15,	#121
    movk	w6,	#65535,	lsl #16
    str	w0,	[sp, #1764]

    mov	w4,	w15
    ldr	w10,	[sp, #1040]

    ldr	w9,	[sp, #1764]

    madd	w12,	w10,	w9,	w14

    str	w12,	[sp, #1892]

    ldr	w21,	[sp, #456]

    mov	w12,	w13
    neg	w27,	w21
    movz	w13,	#114
    lsl	w14,	w27,	#4
    movz	w21,	#65523
    movk	w21,	#65535,	lsl #16
    sub	w14,	w14,	w27,	lsl #0
    mov	w25,	w21
    str	w14,	[sp, #1752]

    str	w25,	[sp, #152]

    ldr	w0,	[sp, #1072]

    mov	w25,	w6
    neg	w10,	w0
    lsl	w0,	w10,	#6
    sub	w7,	w0,	w10,	lsl #1
    str	w7,	[sp, #464]

    ldr	w3,	[sp, #1100]

    lsl	w21,	w3,	#6
    str	w21,	[sp, #1280]

    str	w17,	[sp, #2112]

    ldr	w1,	[sp, #1772]

    mov	w20,	w1
    str	w20,	[sp, #1648]

    mov	w1,	w11
    ldr	w28,	[sp, #308]

    neg	w0,	w28
    lsl	w18,	w0,	#1
    add	w7,	w18,	w0,	lsl #3
    mov	w18,	w13
    mov	w0,	w2
    str	w7,	[sp, #496]

    ldr	w28,	[sp, #1016]

    neg	w22,	w28
    movz	w28,	#82
    lsl	w17,	w22,	#4
    mov	w16,	w28
    str	w17,	[sp, #2084]

    str	w1,	[sp, #1736]

    ldr	w23,	[sp, #1112]

    sub	w1,	w0,	w23
    ldr	w19,	[sp, #1108]

    mov	w27,	w19
    str	w27,	[sp, #1684]

    str	w25,	[sp, #1432]

    str	w16,	[sp, #1320]

    ldr	w23,	[sp, #1032]

    neg	w22,	w23
    lsl	w6,	w22,	#3
    add	w24,	w6,	w22,	lsl #6
    str	w24,	[sp, #480]

    ldr	w26,	[sp, #408]

    ldr	w3,	[sp, #1104]

    add	w7,	w3,	w26
    add	w0,	w7,	w1
    ldr	w1,	[sp, #412]

    lsl	w8,	w0,	#7
    sub	w25,	w8,	w0,	lsl #4
    ldr	w8,	[sp, #1136]

    ldr	w24,	[sp, #1060]

    add	w3,	w8,	w1
    ldr	w28,	[sp, #1892]

    madd	w21,	w24,	w4,	w28

    ldr	w24,	[sp, #1752]

    add	w22,	w21,	w24
    ldr	w24,	[sp, #1076]

    ldr	w19,	[sp, #1068]

    madd	w2,	w24,	w12,	w22

    ldr	w0,	[sp, #152]

    madd	w8,	w19,	w5,	w2

    ldr	w11,	[sp, #468]

    madd	w9,	w11,	w0,	w8

    ldr	w15,	[sp, #464]

    add	w11,	w9,	w15
    ldr	w14,	[sp, #1280]

    ldr	w15,	[sp, #392]

    ldr	w6,	[sp, #2112]

    add	w1,	w11,	w14
    ldr	w0,	[sp, #1012]

    ldr	w17,	[sp, #1648]

    ldr	w7,	[sp, #496]

    madd	w19,	w15,	w6,	w1

    madd	w2,	w0,	w17,	w19

    madd	w24,	w3,	w18,	w2

    add	w16,	w24,	w7
    ldr	w24,	[sp, #2084]

    ldr	w0,	[sp, #1028]

    add	w26,	w16,	w24
    ldr	w28,	[sp, #1736]

    ldr	w22,	[sp, #1124]

    ldr	w6,	[sp, #1684]

    madd	w18,	w0,	w28,	w26

    add	w23,	w18,	w25
    ldr	w28,	[sp, #472]

    ldr	w2,	[sp, #1432]

    madd	w18,	w22,	w6,	w23

    madd	w19,	w28,	w2,	w18

    ldr	w18,	[sp, #1088]

    ldr	w1,	[sp, #1320]

    ldr	w27,	[sp, #480]

    madd	w21,	w18,	w1,	w19

    add	w18,	w21,	w27
    cmp	w18,	#0
    movz	w24,	#0
    mov	w22,	w24
    csel	w0,	w22,	w18,	lt
    cmp	w18,	#127
    movz	w18,	#81
    movz	fp,	#1740
    movz	w26,	#65459
    ldr	w23,	[sp, #1708]

    movz	w3,	#67
    movz	w17,	#127
    movk	w26,	#65535,	lsl #16
    mov	w20,	w17
    mov	w5,	w26
    csel	w9,	w20,	w0,	gt
    lsl	w10,	w9,	#5
    movz	w9,	#65446
    add	w4,	w23,	w10
    movk	w9,	#65535,	lsl #16
    mov	w26,	w9
    str	w4,	[sp, #492]

    str	x5,	[sp, fp]

    ldr	w0,	[sp, #460]

    movz	fp,	#1740
    ldr	x6,	[sp, fp]

    mul	w5,	w0,	w6
    str	w5,	[sp, #1232]

    mov	w5,	w18
    str	w26,	[sp, #1020]

    ldr	w25,	[sp, #1060]

    neg	w16,	w25
    lsl	w24,	w16,	#1
    add	w25,	w24,	w16,	lsl #2
    str	w25,	[sp, #1912]

    ldr	w7,	[sp, #456]

    neg	w16,	w7
    lsl	w26,	w16,	#5
    sub	w14,	w26,	w16,	lsl #1
    movz	w16,	#59
    mov	w8,	w16
    str	w14,	[sp, #228]

    movz	w16,	#52
    ldr	w20,	[sp, #1076]

    mov	w14,	w16
    neg	w21,	w20
    lsl	w24,	w21,	#3
    movz	w21,	#55
    str	w24,	[sp, #1660]

    mov	w28,	w21
    str	w5,	[sp, #1916]

    ldr	w6,	[sp, #468]

    lsl	w11,	w6,	#1
    str	w11,	[sp, #224]

    ldr	w1,	[sp, #312]

    movz	w11,	#65457
    mov	w27,	w1
    movk	w11,	#65535,	lsl #16
    str	w27,	[sp, #1664]

    mov	w18,	w11
    ldr	w19,	[sp, #424]

    mov	w24,	w19
    str	w24,	[sp, #1680]

    mov	w19,	w3
    str	w8,	[sp, #1448]

    str	w28,	[sp, #1724]

    ldr	w21,	[sp, #1136]

    neg	w2,	w21
    lsl	w22,	w2,	#0
    add	w15,	w22,	w2,	lsl #5
    str	w15,	[sp, #1140]

    ldr	w4,	[sp, #1104]

    lsl	w2,	w4,	#4
    ldr	w21,	[sp, #1104]

    movz	w4,	#58
    sub	w6,	w2,	w21,	lsl #1
    mov	w5,	w4
    movz	w4,	#86
    mov	w12,	w4
    str	w6,	[sp, #1612]

    str	w12,	[sp, #1236]

    str	w18,	[sp, #1276]

    ldr	w16,	[sp, #1124]

    ldr	w2,	[sp, #1124]

    lsl	w11,	w16,	#4
    add	w25,	w11,	w2,	lsl #5
    movz	w11,	#0
    mov	w13,	w11
    str	w25,	[sp, #1152]

    ldr	w0,	[sp, #152]

    mov	w28,	w0
    str	w28,	[sp, #1156]

    ldr	w18,	[sp, #1088]

    sub	w25,	w13,	w18
    ldr	w17,	[sp, #1024]

    ldr	w0,	[sp, #1032]

    add	w0,	w0,	w17
    lsl	w3,	w0,	#1
    add	w10,	w3,	w0,	lsl #6
    str	w10,	[sp, #1700]

    ldr	w16,	[sp, #1012]

    ldr	w7,	[sp, #1084]

    add	w7,	w16,	w7
    add	w4,	w7,	w25
    lsl	w3,	w4,	#4
    sub	w13,	w3,	w4,	lsl #0
    str	w13,	[sp, #1416]

    ldr	w0,	[sp, #1040]

    ldr	w6,	[sp, #1232]

    ldr	w2,	[sp, #1020]

    madd	w1,	w0,	w2,	w6

    ldr	w26,	[sp, #1912]

    add	w11,	w1,	w26
    ldr	w7,	[sp, #228]

    ldr	w18,	[sp, #1660]

    ldr	w3,	[sp, #1068]

    add	w10,	w11,	w7
    ldr	w21,	[sp, #1916]

    ldr	w4,	[sp, #224]

    add	w1,	w10,	w18
    madd	w1,	w3,	w21,	w1

    add	w11,	w1,	w4
    ldr	w1,	[sp, #1072]

    ldr	w20,	[sp, #1664]

    madd	w28,	w1,	w20,	w11

    ldr	w4,	[sp, #1100]

    ldr	w25,	[sp, #1680]

    madd	w17,	w4,	w25,	w28

    ldr	w22,	[sp, #412]

    ldr	w8,	[sp, #1448]

    ldr	w3,	[sp, #392]

    madd	w18,	w22,	w8,	w17

    madd	w26,	w3,	w14,	w18

    ldr	w14,	[sp, #408]

    ldr	w1,	[sp, #1724]

    madd	w26,	w14,	w1,	w26

    ldr	w7,	[sp, #1140]

    ldr	w3,	[sp, #1612]

    add	w7,	w26,	w7
    ldr	w16,	[sp, #308]

    ldr	w28,	[sp, #1016]

    add	w1,	w7,	w3
    ldr	w0,	[sp, #1028]

    ldr	w8,	[sp, #1236]

    madd	w21,	w16,	w5,	w1

    ldr	w5,	[sp, #1112]

    madd	w18,	w28,	w19,	w21

    ldr	w14,	[sp, #1276]

    madd	w19,	w0,	w8,	w18

    ldr	w17,	[sp, #1152]

    madd	w18,	w5,	w14,	w19

    ldr	w0,	[sp, #472]

    add	w22,	w18,	w17
    ldr	w21,	[sp, #1156]

    ldr	w12,	[sp, #1416]

    madd	w21,	w0,	w21,	w22

    ldr	w11,	[sp, #1700]

    add	w22,	w21,	w12
    add	w0,	w22,	w11
    cmp	w0,	#0
    movz	w24,	#0
    mov	w3,	w24
    csel	w14,	w3,	w0,	lt
    cmp	w0,	#127
    movz	w28,	#71
    ldr	w19,	[sp, #424]

    movz	w16,	#65417
    movz	w22,	#127
    movz	w5,	#97
    movz	w26,	#67
    ldr	w6,	[sp, #492]

    mov	w25,	w19
    movk	w16,	#65535,	lsl #16
    mov	w0,	w22
    mov	w23,	w26
    csel	w10,	w0,	w14,	gt
    mov	w14,	w5
    madd	w18,	w10,	w25,	w6

    movz	w5,	#65452
    str	w18,	[sp, #1364]

    movk	w5,	#65535,	lsl #16
    ldr	w19,	[sp, #1084]

    ldr	w7,	[sp, #1084]

    lsl	w21,	w19,	#0
    add	w3,	w21,	w7,	lsl #5
    str	w3,	[sp, #1292]

    str	w23,	[sp, #1272]

    ldr	w12,	[sp, #1040]

    ldr	w0,	[sp, #1040]

    lsl	w22,	w12,	#5
    sub	w20,	w22,	w0,	lsl #1
    mov	w0,	w28
    str	w20,	[sp, #1328]

    ldr	w26,	[sp, #1060]

    ldr	w21,	[sp, #1076]

    neg	w24,	w26
    ldr	w15,	[sp, #1076]

    lsl	w25,	w21,	#7
    lsl	w11,	w24,	#1
    sub	w7,	w25,	w15,	lsl #3
    str	w7,	[sp, #1696]

    mov	w7,	w16
    ldr	w17,	[sp, #152]

    mov	w2,	w17
    str	w2,	[sp, #1440]

    movz	w2,	#107
    ldr	w20,	[sp, #468]

    mov	w27,	w2
    ldr	w8,	[sp, #468]

    lsl	w1,	w20,	#1
    add	w13,	w1,	w8,	lsl #4
    str	w13,	[sp, #504]

    ldr	w9,	[sp, #1072]

    ldr	w3,	[sp, #1072]

    lsl	w17,	w9,	#0
    movz	w9,	#104
    add	w20,	w17,	w3,	lsl #2
    mov	w22,	w9
    str	w20,	[sp, #2088]

    str	w7,	[sp, #140]

    ldr	w4,	[sp, #392]

    neg	w3,	w4
    lsl	w17,	w3,	#3
    sub	w20,	w17,	w3,	lsl #0
    str	w20,	[sp, #428]

    mov	w20,	w5
    str	w0,	[sp, #1288]

    movz	w0,	#83
    str	w27,	[sp, #484]

    mov	w17,	w0
    ldr	w13,	[sp, #1136]

    ldr	w7,	[sp, #1136]

    lsl	w6,	w13,	#3
    ldr	w1,	[sp, #308]

    add	w4,	w6,	w7,	lsl #4
    ldr	w26,	[sp, #1768]

    neg	w8,	w1
    mov	w12,	w26
    lsl	w2,	w8,	#5
    str	w12,	[sp, #1304]

    ldr	w27,	[sp, #316]

    add	w13,	w2,	w8,	lsl #6
    mov	w9,	w27
    movz	w2,	#46
    str	w9,	[sp, #1300]

    mov	w26,	w2
    str	w14,	[sp, #1260]

    str	w17,	[sp, #1264]

    str	w26,	[sp, #1284]

    str	w20,	[sp, #1268]

    ldr	w12,	[sp, #456]

    ldr	w0,	[sp, #1112]

    add	w3,	w0,	w12
    movz	w0,	#82
    mov	w15,	w0
    lsl	w6,	w3,	#0
    add	w17,	w6,	w3,	lsl #6
    str	w17,	[sp, #240]

    ldr	w17,	[sp, #460]

    ldr	w6,	[sp, #1104]

    add	w6,	w6,	w17
    str	w6,	[sp, #1296]

    str	w15,	[sp, #1308]

    ldr	w23,	[sp, #1024]

    ldr	w24,	[sp, #1272]

    ldr	w0,	[sp, #1292]

    madd	w8,	w23,	w24,	w0

    ldr	w23,	[sp, #1328]

    add	w5,	w8,	w23
    ldr	w8,	[sp, #1696]

    ldr	w18,	[sp, #1068]

    add	w5,	w5,	w11
    ldr	w2,	[sp, #1440]

    ldr	w11,	[sp, #504]

    ldr	w3,	[sp, #2088]

    add	w1,	w5,	w8
    ldr	w0,	[sp, #1100]

    ldr	w17,	[sp, #412]

    ldr	w10,	[sp, #140]

    madd	w2,	w18,	w2,	w1

    add	w2,	w2,	w11
    add	w8,	w2,	w3
    madd	w0,	w0,	w22,	w8

    madd	w3,	w17,	w10,	w0

    ldr	w0,	[sp, #428]

    add	w2,	w3,	w0
    ldr	w0,	[sp, #1012]

    ldr	w23,	[sp, #1288]

    ldr	w14,	[sp, #408]

    madd	w12,	w0,	w23,	w2

    ldr	w27,	[sp, #484]

    ldr	w1,	[sp, #1296]

    madd	w9,	w14,	w27,	w12

    ldr	w17,	[sp, #1308]

    add	w24,	w9,	w4
    ldr	w5,	[sp, #1016]

    ldr	w7,	[sp, #1304]

    madd	w25,	w1,	w17,	w24

    add	w15,	w25,	w13
    ldr	w1,	[sp, #1028]

    ldr	w4,	[sp, #1300]

    ldr	w10,	[sp, #240]

    madd	w16,	w5,	w7,	w15

    ldr	w27,	[sp, #1124]

    madd	w18,	w1,	w4,	w16

    ldr	w8,	[sp, #1260]

    add	w19,	w18,	w10
    ldr	w0,	[sp, #472]

    ldr	w14,	[sp, #1264]

    ldr	w20,	[sp, #1088]

    madd	w21,	w27,	w8,	w19

    madd	w22,	w0,	w14,	w21

    ldr	w0,	[sp, #1284]

    ldr	w13,	[sp, #1032]

    madd	w24,	w20,	w0,	w22

    ldr	w20,	[sp, #1268]

    madd	w9,	w13,	w20,	w24

    cmp	w9,	#0
    movz	w22,	#0
    mov	w0,	w22
    csel	w21,	w0,	w9,	lt
    cmp	w9,	#127
    movz	w24,	#53
    movz	w9,	#65490
    movz	w25,	#65507
    movz	w15,	#127
    movz	fp,	#1740
    ldr	w7,	[sp, #1736]

    movz	w16,	#65463
    mov	w17,	w24
    movk	w9,	#65535,	lsl #16
    movk	w25,	#65535,	lsl #16
    mov	w27,	w15
    ldr	w3,	[sp, #1364]

    mov	w22,	w7
    movk	w16,	#65535,	lsl #16
    mov	w0,	w25
    csel	w13,	w27,	w21,	gt
    movz	w7,	#71
    madd	w12,	w13,	w22,	w3

    mov	w13,	w7
    str	w12,	[sp, #1356]

    ldr	w3,	[sp, #460]

    ldr	w12,	[sp, #460]

    lsl	w19,	w3,	#3
    ldr	w11,	[sp, #1084]

    sub	w18,	w19,	w12,	lsl #0
    madd	w2,	w11,	w0,	w18

    movz	w18,	#38
    str	w2,	[sp, #2136]

    mov	w8,	w18
    str	w8,	[sp, #1928]

    ldr	w28,	[sp, #1020]

    ldr	w5,	[sp, #1076]

    mov	w27,	w28
    neg	w25,	w5
    lsl	w5,	w25,	#5
    str	w5,	[sp, #2140]

    ldr	w26,	[sp, #468]

    ldr	w0,	[sp, #468]

    lsl	w18,	w26,	#2
    add	w8,	w18,	w0,	lsl #5
    mov	w18,	w16
    mov	w0,	w9
    str	w8,	[sp, #2072]

    ldr	w12,	[sp, #132]

    mov	w11,	w12
    str	w11,	[sp, #2104]

    str	w18,	[sp, #1640]

    movz	w18,	#65449
    ldr	w6,	[sp, #1136]

    movk	w18,	#65535,	lsl #16
    neg	w22,	w6
    mov	w19,	w18
    lsl	w10,	w22,	#1
    add	w2,	w10,	w22,	lsl #5
    str	w2,	[sp, #1728]

    str	w19,	[sp, #1712]

    ldr	w23,	[sp, #144]

    mov	w9,	w23
    str	w9,	[sp, #1616]

    str	w13,	[sp, #1704]

    ldr	x7,	[sp, fp]

    mov	w8,	w7
    str	w8,	[sp, #2100]

    str	w17,	[sp, #1324]

    ldr	w17,	[sp, #280]

    mov	w1,	w17
    str	w1,	[sp, #1688]

    ldr	w12,	[sp, #152]

    mov	w21,	w12
    movz	w12,	#37
    str	w21,	[sp, #1472]

    mov	w16,	w12
    ldr	w28,	[sp, #172]

    mov	w18,	w28
    str	w18,	[sp, #1468]

    ldr	w8,	[sp, #1012]

    ldr	w5,	[sp, #1068]

    ldr	w17,	[sp, #1124]

    add	w10,	w8,	w5
    add	w22,	w10,	w17
    str	w22,	[sp, #516]

    str	w16,	[sp, #1420]

    ldr	w7,	[sp, #392]

    ldr	w2,	[sp, #1024]

    ldr	w10,	[sp, #268]

    add	w12,	w7,	w2
    ldr	w5,	[sp, #1040]

    mov	w1,	w10
    ldr	w18,	[sp, #2136]

    ldr	w17,	[sp, #1928]

    madd	w18,	w5,	w17,	w18

    ldr	w17,	[sp, #1060]

    ldr	w22,	[sp, #1752]

    madd	w26,	w17,	w27,	w18

    ldr	w16,	[sp, #2140]

    add	w7,	w26,	w22
    ldr	w20,	[sp, #2072]

    ldr	w2,	[sp, #464]

    add	w26,	w7,	w16
    ldr	w8,	[sp, #1100]

    ldr	w15,	[sp, #2104]

    add	w4,	w26,	w20
    add	w10,	w4,	w2
    madd	w27,	w8,	w15,	w10

    ldr	w8,	[sp, #412]

    madd	w16,	w8,	w0,	w27

    ldr	w0,	[sp, #408]

    madd	w16,	w12,	w1,	w16

    ldr	w23,	[sp, #1640]

    ldr	w4,	[sp, #1728]

    madd	w5,	w0,	w23,	w16

    ldr	w27,	[sp, #1104]

    add	w25,	w5,	w4
    ldr	w0,	[sp, #1712]

    madd	w9,	w27,	w0,	w25

    ldr	w0,	[sp, #308]

    ldr	w16,	[sp, #1616]

    ldr	w6,	[sp, #1016]

    madd	w10,	w0,	w16,	w9

    ldr	w0,	[sp, #1704]

    ldr	w2,	[sp, #1028]

    madd	w20,	w6,	w0,	w10

    ldr	w12,	[sp, #2100]

    ldr	w18,	[sp, #1112]

    madd	w14,	w2,	w12,	w20

    ldr	w0,	[sp, #1324]

    ldr	w26,	[sp, #516]

    madd	w16,	w18,	w0,	w14

    ldr	w1,	[sp, #1420]

    ldr	w15,	[sp, #472]

    madd	w1,	w26,	w1,	w16

    ldr	w2,	[sp, #1688]

    ldr	w5,	[sp, #1088]

    madd	w0,	w15,	w2,	w1

    ldr	w22,	[sp, #1472]

    ldr	w1,	[sp, #1032]

    madd	w0,	w5,	w22,	w0

    ldr	w19,	[sp, #1468]

    madd	w16,	w1,	w19,	w0

    cmp	w16,	#0
    movz	w18,	#0
    mov	w9,	w18
    csel	w24,	w9,	w16,	lt
    cmp	w16,	#127
    movz	w21,	#42
    movz	w13,	#127
    movz	w15,	#41
    ldr	w0,	[sp, #176]

    movz	fp,	#1740
    movz	w16,	#115
    mov	w26,	w13
    mov	w14,	w15
    ldr	w13,	[sp, #1356]

    csel	w18,	w26,	w24,	gt
    movz	w15,	#65444
    mov	w24,	w21
    madd	w25,	w18,	w0,	w13

    movk	w15,	#65535,	lsl #16
    str	w25,	[sp, #1568]

    mov	w26,	w15
    ldr	w10,	[sp, #460]

    movz	w15,	#75
    ldr	w22,	[sp, #148]

    mul	w7,	w10,	w24
    mov	w0,	w22
    str	w0,	[sp, #2152]

    str	w26,	[sp, #2144]

    ldr	w1,	[sp, #456]

    ldr	w4,	[sp, #456]

    lsl	w0,	w1,	#1
    add	w23,	w0,	w4,	lsl #3
    movz	w0,	#85
    str	w23,	[sp, #2436]

    mov	w23,	w15
    ldr	x8,	[sp, fp]

    movz	w15,	#109
    mov	w10,	w8
    mov	w3,	w15
    str	w10,	[sp, #1512]

    movz	w15,	#65414
    movz	w10,	#65485
    str	w23,	[sp, #2148]

    movk	w15,	#65535,	lsl #16
    movk	w10,	#65535,	lsl #16
    mov	w23,	w0
    ldr	w8,	[sp, #468]

    mov	w21,	w10
    ldr	w9,	[sp, #468]

    lsl	w28,	w8,	#5
    mov	w10,	w15
    add	w27,	w28,	w9,	lsl #6
    movz	w15,	#47
    str	w27,	[sp, #2128]

    str	w3,	[sp, #1796]

    mov	w3,	w16
    ldr	w22,	[sp, #1764]

    mov	w1,	w22
    movz	w22,	#22
    str	w1,	[sp, #1500]

    mov	w4,	w22
    str	w15,	[sp, #2412]

    str	w4,	[sp, #2160]

    ldr	w1,	[sp, #308]

    neg	w17,	w1
    str	w17,	[sp, #1460]

    movz	w17,	#67
    ldr	w18,	[sp, #1460]

    mov	w16,	w17
    ldr	w24,	[sp, #1460]

    lsl	w15,	w18,	#2
    add	w22,	w15,	w24,	lsl #6
    movz	w15,	#38
    mov	w6,	w15
    str	w22,	[sp, #1716]

    movz	w15,	#29
    str	w6,	[sp, #1400]

    mov	w4,	w15
    str	w4,	[sp, #1692]

    str	w3,	[sp, #1344]

    movz	w3,	#65487
    ldr	w8,	[sp, #316]

    movk	w3,	#65535,	lsl #16
    str	w8,	[sp, #1312]

    mov	w6,	w3
    ldr	w11,	[sp, #472]

    ldr	w12,	[sp, #472]

    lsl	w25,	w11,	#2
    add	w15,	w25,	w12,	lsl #5
    str	w15,	[sp, #1360]

    str	w6,	[sp, #1348]

    str	w23,	[sp, #1332]

    ldr	w20,	[sp, #408]

    ldr	w5,	[sp, #1084]

    add	w22,	w20,	w5
    str	w22,	[sp, #1428]

    ldr	w28,	[sp, #1024]

    ldr	w12,	[sp, #1040]

    madd	w18,	w28,	w14,	w7

    ldr	w3,	[sp, #2152]

    ldr	w5,	[sp, #1060]

    madd	w22,	w12,	w3,	w18

    ldr	w0,	[sp, #2144]

    ldr	w24,	[sp, #2436]

    madd	w7,	w5,	w0,	w22

    ldr	w25,	[sp, #1076]

    add	w18,	w7,	w24
    ldr	w8,	[sp, #1512]

    ldr	w14,	[sp, #1068]

    madd	w7,	w25,	w8,	w18

    ldr	w0,	[sp, #2148]

    ldr	w9,	[sp, #2128]

    madd	w3,	w14,	w0,	w7

    add	w0,	w3,	w9
    ldr	w9,	[sp, #1072]

    madd	w7,	w9,	w21,	w0

    ldr	w0,	[sp, #1100]

    ldr	w6,	[sp, #1796]

    ldr	w3,	[sp, #412]

    madd	w6,	w0,	w6,	w7

    ldr	w28,	[sp, #1500]

    ldr	w0,	[sp, #428]

    madd	w7,	w3,	w28,	w6

    ldr	w12,	[sp, #1012]

    add	w27,	w7,	w0
    ldr	w23,	[sp, #1428]

    ldr	w24,	[sp, #1136]

    madd	w0,	w12,	w10,	w27

    ldr	w25,	[sp, #2412]

    madd	w0,	w23,	w16,	w0

    ldr	w6,	[sp, #1104]

    madd	w24,	w24,	w25,	w0

    ldr	w10,	[sp, #2160]

    ldr	w23,	[sp, #1716]

    madd	w10,	w6,	w10,	w24

    ldr	w24,	[sp, #1016]

    add	w0,	w10,	w23
    ldr	w5,	[sp, #1400]

    ldr	w19,	[sp, #1028]

    madd	w20,	w24,	w5,	w0

    ldr	w5,	[sp, #1692]

    madd	w1,	w19,	w5,	w20

    ldr	w19,	[sp, #1112]

    ldr	w6,	[sp, #1344]

    ldr	w4,	[sp, #1124]

    madd	w1,	w19,	w6,	w1

    ldr	w16,	[sp, #1312]

    madd	w14,	w4,	w16,	w1

    ldr	w16,	[sp, #1360]

    ldr	w6,	[sp, #1088]

    add	w1,	w14,	w16
    ldr	w15,	[sp, #1348]

    ldr	w2,	[sp, #1032]

    madd	w26,	w6,	w15,	w1

    ldr	w0,	[sp, #1332]

    madd	w13,	w2,	w0,	w26

    cmp	w13,	#0
    movz	w0,	#0
    mov	w5,	w0
    csel	w3,	w5,	w13,	lt
    cmp	w13,	#127
    ldr	w26,	[sp, #1568]

    movz	w2,	#46
    movz	w10,	#127
    mov	w4,	w10
    csel	w1,	w4,	w3,	gt
    mov	w3,	w2
    madd	w24,	w1,	w3,	w26

    cmp	w24,	#0
    cset	w25,	gt
    mov	w26,	w25
    cmp	w26,	#0
    beq	main_611

main_610:
    movz	w0,	#99
    bl	putch
    movz	w0,	#97
    bl	putch
    movz	w0,	#116
    bl	putch
    movz	w0,	#10
    bl	putch
    b	main_612

main_611:
    movz	w0,	#100
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#103
    bl	putch
    movz	w0,	#10
    bl	putch

main_612:
    ldr	w7,	[sp, #404]

    sub	w18,	w7,	#1
    cmp	w18,	#0
    ble	main_617

main_36:
    mov	w8,	w18
    str	w8,	[sp, #404]

    b	main_37

main_39:
    mov	w24,	w20
    b	main_40

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2464
    ret


