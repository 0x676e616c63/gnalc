.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2432
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x1,	sp,	#16
    movz	fp,	#132
    mov	w7,	w0
    mov	x26,	x1
    add	x11,	x26,	#16
    add	x8,	x26,	#12
    add	x10,	x1,	#80
    add	x6,	x1,	#40
    add	x19,	x1,	#20
    add	x23,	x26,	#8
    add	x3,	x26,	#4
    mov	x28,	x26
    add	x4,	x10,	#16
    mov	x20,	x10
    add	x2,	x6,	#16
    add	x27,	x6,	#12
    add	x24,	x6,	#8
    add	x9,	x6,	#4
    add	x25,	x19,	#8
    add	x22,	x19,	#4
    mov	x14,	x19
    add	x26,	x10,	#8
    str	x28,	[sp, fp]

    add	x28,	x19,	#12
    movz	fp,	#156
    str	x3,	[sp, fp]

    add	x3,	x19,	#16
    movz	fp,	#340
    str	x23,	[sp, fp]

    add	x23,	x10,	#4
    movz	fp,	#236
    str	x8,	[sp, #288]

    str	x11,	[sp, #368]

    str	x14,	[sp, #376]

    str	x22,	[sp, fp]

    movz	fp,	#324
    str	x25,	[sp, #216]

    str	x28,	[sp, #224]

    str	x3,	[sp, fp]

    movz	fp,	#332
    str	x6,	[sp, fp]

    movz	fp,	#180
    str	x9,	[sp, #432]

    str	x24,	[sp, #248]

    str	x27,	[sp, #392]

    add	x27,	x1,	#60
    str	x2,	[sp, #400]

    add	x1,	x10,	#12
    mov	x5,	x27
    str	x5,	[sp, #408]

    add	x17,	x27,	#16
    add	x14,	x27,	#12
    add	x11,	x27,	#8
    add	x8,	x27,	#4
    str	x8,	[sp, #256]

    str	x11,	[sp, #264]

    str	x14,	[sp, #272]

    str	x17,	[sp, #280]

    str	x20,	[sp, fp]

    movz	fp,	#188
    str	x23,	[sp, fp]

    movz	fp,	#196
    str	x26,	[sp, fp]

    movz	fp,	#204
    str	x1,	[sp, fp]

    movz	fp,	#300
    str	x4,	[sp, fp]

    str	w7,	[sp, #428]


main_37:
    movz	w2,	#0
    mov	w19,	w2

main_40:
    lsl	w10,	w19,	#2
    movz	w3,	#0
    mov	w26,	w3
    add	w11,	w10,	w19,	lsl #4
    mov	x27,	x11
    add	x27,	sp,	x27
    add	x27,	x27,	#16

main_43:
    cmp	w26,	#5
    bge	main_50

main_46:
    lsl	w22,	w26,	#2
    add	x28,	x27,	x22
    bl	getint
    add	w5,	w26,	#1
    str	w0,	[x28]

    mov	w26,	w5
    b	main_43

main_50:
    add	w22,	w19,	#1
    cmp	w22,	#5
    blt	main_39

main_53:
    movz	fp,	#132
    movz	w0,	#85
    movz	w28,	#23
    movz	w27,	#65454
    movz	w14,	#65425
    movz	w5,	#65430
    ldr	x18,	[sp, fp]

    movk	w27,	#65535,	lsl #16
    movk	w14,	#65535,	lsl #16
    movk	w5,	#65535,	lsl #16
    ldr	w11,	[x18]

    movz	fp,	#156
    str	w11,	[sp, #1084]

    ldr	w7,	[sp, #1084]

    mul	w8,	w7,	w0
    ldr	x21,	[sp, fp]

    mov	w0,	w28
    ldr	w17,	[x21]

    movz	fp,	#340
    movz	w28,	#65433
    str	w17,	[sp, #444]

    movk	w28,	#65535,	lsl #16
    ldr	w18,	[sp, #444]

    mov	w11,	w28
    madd	w7,	w18,	w0,	w8

    ldr	x12,	[sp, fp]

    mov	w0,	w27
    movz	w18,	#65477
    ldr	w26,	[x12]

    movz	fp,	#236
    movk	w18,	#65535,	lsl #16
    str	w26,	[sp, #1028]

    ldr	w27,	[sp, #1028]

    madd	w27,	w27,	w0,	w7

    str	w27,	[sp, #1708]

    movz	w0,	#65413
    ldr	x25,	[sp, #288]

    movk	w0,	#65535,	lsl #16
    ldr	w17,	[x25]

    mov	w23,	w0
    str	w17,	[sp, #1044]

    str	w11,	[sp, #320]

    ldr	x28,	[sp, #368]

    ldr	w2,	[x28]

    str	w2,	[sp, #1048]

    str	w23,	[sp, #296]

    ldr	x2,	[sp, #376]

    ldr	w28,	[x2]

    str	w28,	[sp, #308]

    ldr	w0,	[sp, #308]

    lsl	w20,	w0,	#6
    movz	w0,	#50
    str	w20,	[sp, #1700]

    mov	w17,	w0
    ldr	x10,	[sp, fp]

    movz	w0,	#65469
    ldr	w7,	[x10]

    movz	fp,	#324
    movk	w0,	#65535,	lsl #16
    str	w7,	[sp, #1068]

    mov	w10,	w14
    ldr	w8,	[sp, #1068]

    mov	w7,	w18
    neg	w4,	w8
    lsl	w24,	w4,	#7
    sub	w4,	w24,	w4,	lsl #3
    str	w4,	[sp, #1244]

    ldr	x13,	[sp, #216]

    mov	w4,	w0
    ldr	w8,	[x13]

    str	w8,	[sp, #1052]

    str	w17,	[sp, #1696]

    ldr	x16,	[sp, #224]

    ldr	w9,	[x16]

    str	w9,	[sp, #424]

    movz	w16,	#113
    str	w7,	[sp, #1264]

    ldr	x19,	[sp, fp]

    movz	w7,	#65461
    ldr	w20,	[x19]

    movz	fp,	#332
    movk	w7,	#65535,	lsl #16
    str	w20,	[sp, #1056]

    ldr	x22,	[sp, fp]

    ldr	w22,	[x22]

    movz	fp,	#180
    str	w22,	[sp, #1092]

    str	w10,	[sp, #1216]

    ldr	x25,	[sp, #432]

    ldr	w8,	[x25]

    str	w8,	[sp, #1016]

    str	w4,	[sp, #1756]

    movz	w8,	#65434
    ldr	x11,	[sp, #248]

    movk	w8,	#65535,	lsl #16
    ldr	w21,	[x11]

    str	w21,	[sp, #440]

    mov	w21,	w5
    str	w21,	[sp, #360]

    ldr	x14,	[sp, #392]

    ldr	w21,	[x14]

    str	w21,	[sp, #1020]

    mov	w14,	w7
    mov	w21,	w16
    str	w14,	[sp, #384]

    ldr	x17,	[sp, #400]

    ldr	w1,	[x17]

    str	w1,	[sp, #416]

    movz	w17,	#65497
    str	w8,	[sp, #1760]

    movk	w17,	#65535,	lsl #16
    ldr	x20,	[sp, #408]

    mov	w14,	w17
    ldr	w6,	[x20]

    str	w6,	[sp, #1120]

    ldr	w7,	[sp, #1120]

    lsl	w0,	w7,	#1
    ldr	w8,	[sp, #1120]

    add	w6,	w0,	w8,	lsl #5
    str	w6,	[sp, #1668]

    ldr	x23,	[sp, #256]

    ldr	w22,	[x23]

    str	w22,	[sp, #1100]

    str	w14,	[sp, #1728]

    ldr	x26,	[sp, #264]

    ldr	w4,	[x26]

    str	w4,	[sp, #364]

    ldr	w5,	[sp, #364]

    movz	w4,	#110
    lsl	w22,	w5,	#0
    ldr	w14,	[sp, #364]

    mov	w12,	w4
    add	w11,	w22,	w14,	lsl #6
    str	w11,	[sp, #1636]

    ldr	x0,	[sp, #272]

    ldr	w14,	[x0]

    str	w14,	[sp, #1024]

    ldr	x3,	[sp, #280]

    ldr	w9,	[x3]

    str	w9,	[sp, #1032]

    str	w21,	[sp, #1688]

    ldr	x6,	[sp, fp]

    ldr	w7,	[x6]

    movz	fp,	#188
    str	w7,	[sp, #1104]

    str	w12,	[sp, #1676]

    ldr	x9,	[sp, fp]

    ldr	w21,	[x9]

    movz	fp,	#196
    str	w21,	[sp, #1108]

    ldr	x12,	[sp, fp]

    ldr	w5,	[x12]

    movz	fp,	#204
    str	w5,	[sp, #420]

    ldr	w6,	[sp, #420]

    neg	w0,	w6
    lsl	w18,	w0,	#2
    str	w18,	[sp, #1568]

    ldr	x15,	[sp, fp]

    ldr	w24,	[x15]

    movz	fp,	#300
    str	w24,	[sp, #1088]

    ldr	w25,	[sp, #1088]

    lsl	w4,	w25,	#4
    ldr	w18,	[sp, #1088]

    movz	w25,	#46
    add	w1,	w4,	w18,	lsl #6
    mov	w12,	w25
    str	w1,	[sp, #2244]

    ldr	x18,	[sp, fp]

    ldr	w21,	[x18]

    str	w21,	[sp, #1036]

    ldr	w26,	[sp, #1024]

    ldr	w1,	[sp, #1056]

    add	w0,	w26,	w1
    ldr	w21,	[sp, #1108]

    movz	w1,	#47
    ldr	w23,	[sp, #320]

    mov	w3,	w1
    ldr	w16,	[sp, #1044]

    add	w19,	w0,	w21
    ldr	w22,	[sp, #1708]

    madd	w26,	w16,	w23,	w22

    ldr	w8,	[sp, #296]

    ldr	w2,	[sp, #1048]

    madd	w7,	w2,	w8,	w26

    ldr	w9,	[sp, #1700]

    add	w9,	w7,	w9
    ldr	w14,	[sp, #1244]

    ldr	w1,	[sp, #1052]

    ldr	w10,	[sp, #1696]

    add	w16,	w9,	w14
    ldr	w0,	[sp, #424]

    ldr	w24,	[sp, #1264]

    ldr	w4,	[sp, #1092]

    madd	w18,	w1,	w10,	w16

    madd	w7,	w0,	w24,	w18

    ldr	w0,	[sp, #1216]

    madd	w7,	w4,	w0,	w7

    ldr	w4,	[sp, #1016]

    ldr	w5,	[sp, #1756]

    madd	w7,	w4,	w5,	w7

    ldr	w18,	[sp, #360]

    ldr	w1,	[sp, #440]

    madd	w2,	w1,	w18,	w7

    ldr	w22,	[sp, #384]

    ldr	w28,	[sp, #1020]

    ldr	w0,	[sp, #416]

    madd	w6,	w28,	w22,	w2

    ldr	w16,	[sp, #1760]

    madd	w5,	w0,	w16,	w6

    ldr	w16,	[sp, #1668]

    add	w5,	w5,	w16
    ldr	w6,	[sp, #1100]

    ldr	w17,	[sp, #1728]

    ldr	w11,	[sp, #1636]

    madd	w2,	w6,	w17,	w5

    ldr	w14,	[sp, #1032]

    add	w26,	w2,	w11
    ldr	w4,	[sp, #1688]

    ldr	w5,	[sp, #1104]

    ldr	w20,	[sp, #1676]

    madd	w22,	w14,	w4,	w26

    madd	w9,	w5,	w20,	w22

    ldr	w26,	[sp, #1568]

    madd	w2,	w19,	w3,	w9

    ldr	w19,	[sp, #2244]

    add	w7,	w2,	w26
    add	w1,	w7,	w19
    ldr	w7,	[sp, #1036]

    madd	w8,	w7,	w12,	w1

    cmp	w8,	#0
    movz	w14,	#0
    csel	w0,	w14,	w8,	lt
    cmp	w8,	#127
    movz	w23,	#65493
    movz	w7,	#65415
    movz	w12,	#39
    movz	w11,	#65442
    movz	w8,	#105
    movz	w18,	#47
    movz	w5,	#127
    movz	w22,	#65514
    movk	w23,	#65535,	lsl #16
    movk	w7,	#65535,	lsl #16
    movk	w11,	#65535,	lsl #16
    mov	w25,	w5
    movk	w22,	#65535,	lsl #16
    mov	w24,	w11
    csel	w2,	w25,	w0,	gt
    movz	w5,	#65494
    mul	w9,	w2,	w12
    movk	w5,	#65535,	lsl #16
    str	w9,	[sp, #1672]

    mov	w2,	w18
    ldr	w19,	[sp, #444]

    movz	w9,	#65515
    lsl	w15,	w19,	#7
    ldr	w20,	[sp, #444]

    movk	w9,	#65535,	lsl #16
    sub	w28,	w15,	w20,	lsl #1
    mov	w13,	w9
    movz	w15,	#65411
    mov	w9,	w8
    movk	w15,	#65535,	lsl #16
    str	w28,	[sp, #1620]

    mov	w18,	w15
    ldr	w28,	[sp, #1028]

    neg	w6,	w28
    lsl	w12,	w6,	#1
    add	w4,	w12,	w6,	lsl #4
    mov	w6,	w7
    str	w4,	[sp, #1588]

    ldr	w19,	[sp, #1048]

    neg	w14,	w19
    lsl	w16,	w14,	#3
    str	w16,	[sp, #1304]

    ldr	w16,	[sp, #1068]

    neg	w1,	w16
    lsl	w14,	w1,	#2
    movz	w1,	#67
    str	w14,	[sp, #2332]

    mov	w12,	w1
    str	w12,	[sp, #1524]

    str	w24,	[sp, #1504]

    movz	w12,	#87
    str	w6,	[sp, #232]

    ldr	w7,	[sp, #1092]

    ldr	w26,	[sp, #1092]

    lsl	w6,	w7,	#3
    mov	w7,	w23
    sub	w17,	w6,	w26,	lsl #0
    str	w17,	[sp, #1544]

    str	w13,	[sp, #1744]

    ldr	w4,	[sp, #440]

    mov	w13,	w22
    neg	w14,	w4
    lsl	w4,	w14,	#6
    sub	w24,	w4,	w14,	lsl #2
    str	w24,	[sp, #2128]

    str	w9,	[sp, #1548]

    mov	w24,	w5
    mov	w9,	w12
    str	w24,	[sp, #1368]

    str	w9,	[sp, #1344]

    movz	w9,	#29
    mov	w0,	w9
    movz	w9,	#65426
    str	w0,	[sp, #1324]

    movk	w9,	#65535,	lsl #16
    mov	w17,	w9
    str	w17,	[sp, #152]

    movz	w9,	#65436
    str	w13,	[sp, #484]

    movk	w9,	#65535,	lsl #16
    ldr	w23,	[sp, #384]

    mov	w4,	w9
    mov	w13,	w23
    str	w13,	[sp, #2088]

    str	w18,	[sp, #176]

    ldr	w12,	[sp, #1032]

    ldr	w22,	[sp, #1044]

    add	w22,	w12,	w22
    neg	w9,	w22
    lsl	w15,	w9,	#5
    sub	w0,	w15,	w9,	lsl #0
    str	w0,	[sp, #1976]

    ldr	w17,	[sp, #1024]

    ldr	w12,	[sp, #1084]

    add	w13,	w17,	w12
    ldr	w12,	[sp, #360]

    mov	w26,	w12
    str	w26,	[sp, #1380]

    ldr	w18,	[sp, #1588]

    ldr	w15,	[sp, #1620]

    add	w17,	w18,	w15
    ldr	w18,	[sp, #1304]

    ldr	w0,	[sp, #308]

    add	w17,	w17,	w18
    ldr	w15,	[sp, #2332]

    madd	w12,	w0,	w2,	w17

    add	w25,	w12,	w15
    ldr	w15,	[sp, #1052]

    ldr	w5,	[sp, #1524]

    madd	w27,	w15,	w5,	w25

    ldr	w15,	[sp, #424]

    ldr	w18,	[sp, #1504]

    madd	w22,	w15,	w18,	w27

    ldr	w12,	[sp, #232]

    ldr	w3,	[sp, #1056]

    madd	w0,	w3,	w12,	w22

    ldr	w19,	[sp, #1544]

    ldr	w12,	[sp, #1016]

    add	w14,	w0,	w19
    ldr	w2,	[sp, #1744]

    ldr	w9,	[sp, #2128]

    madd	w0,	w12,	w2,	w14

    ldr	w24,	[sp, #1020]

    add	w5,	w0,	w9
    ldr	w12,	[sp, #416]

    ldr	w0,	[sp, #1548]

    ldr	w11,	[sp, #1120]

    madd	w20,	w24,	w7,	w5

    ldr	w8,	[sp, #1368]

    madd	w0,	w12,	w0,	w20

    madd	w8,	w11,	w8,	w0

    ldr	w20,	[sp, #1100]

    ldr	w24,	[sp, #1344]

    madd	w25,	w20,	w24,	w8

    ldr	w0,	[sp, #364]

    ldr	w3,	[sp, #1324]

    madd	w19,	w0,	w3,	w25

    ldr	w15,	[sp, #1380]

    madd	w12,	w13,	w15,	w19

    ldr	w18,	[sp, #1976]

    add	w6,	w12,	w18
    ldr	w0,	[sp, #152]

    ldr	w22,	[sp, #1104]

    ldr	w10,	[sp, #1108]

    madd	w0,	w22,	w0,	w6

    ldr	w7,	[sp, #420]

    madd	w1,	w10,	w4,	w0

    ldr	w0,	[sp, #484]

    madd	w7,	w7,	w0,	w1

    ldr	w27,	[sp, #1088]

    ldr	w20,	[sp, #2088]

    madd	w21,	w27,	w20,	w7

    ldr	w24,	[sp, #176]

    ldr	w7,	[sp, #1036]

    madd	w11,	w7,	w24,	w21

    cmp	w11,	#0
    movz	w12,	#0
    mov	w15,	w12
    csel	w22,	w15,	w11,	lt
    cmp	w11,	#127
    ldr	w0,	[sp, #1672]

    movz	w4,	#76
    movz	w5,	#26
    movz	w12,	#127
    movz	w19,	#27
    movz	w7,	#77
    csel	w24,	w12,	w22,	gt
    madd	w27,	w24,	w7,	w0

    movz	w22,	#102
    str	w27,	[sp, #448]

    movz	w7,	#65441
    ldr	w1,	[sp, #1084]

    movk	w7,	#65535,	lsl #16
    mul	w0,	w1,	w5
    ldr	w1,	[sp, #444]

    mov	w5,	w7
    madd	w0,	w1,	w4,	w0

    movz	w4,	#65466
    movk	w4,	#65535,	lsl #16
    mov	w2,	w4
    str	w2,	[sp, #172]

    ldr	w3,	[sp, #172]

    movz	w2,	#29
    ldr	w20,	[sp, #1028]

    madd	w1,	w20,	w3,	w0

    ldr	w28,	[sp, #1044]

    movz	w20,	#65498
    str	w5,	[sp, #348]

    madd	w2,	w28,	w2,	w1

    movk	w20,	#65535,	lsl #16
    ldr	w6,	[sp, #348]

    movz	w28,	#52
    ldr	w5,	[sp, #1048]

    ldr	w9,	[sp, #308]

    madd	w2,	w5,	w6,	w2

    lsl	w0,	w9,	#5
    ldr	w10,	[sp, #308]

    ldr	w16,	[sp, #1068]

    add	w0,	w0,	w10,	lsl #6
    ldr	w24,	[sp, #1052]

    ldr	w21,	[sp, #424]

    ldr	w3,	[sp, #1056]

    neg	w5,	w21
    add	w1,	w2,	w0
    neg	w0,	w24
    madd	w9,	w16,	w28,	w1

    lsl	w28,	w0,	#2
    add	w4,	w28,	w0,	lsl #6
    lsl	w0,	w5,	#0
    add	w17,	w9,	w4
    add	w7,	w0,	w5,	lsl #2
    ldr	w4,	[sp, #1056]

    lsl	w0,	w3,	#1
    add	w17,	w17,	w7
    add	w12,	w0,	w4,	lsl #5
    ldr	w0,	[sp, #1092]

    neg	w0,	w0
    ldr	w4,	[sp, #1016]

    add	w21,	w17,	w12
    lsl	w1,	w0,	#1
    ldr	w7,	[sp, #440]

    movz	w17,	#116
    add	w14,	w1,	w0,	lsl #5
    ldr	w8,	[sp, #440]

    lsl	w1,	w7,	#1
    ldr	w16,	[sp, #1020]

    ldr	w6,	[sp, #416]

    add	w25,	w21,	w14
    add	w18,	w1,	w8,	lsl #2
    movz	w14,	#65437
    movk	w14,	#65535,	lsl #16
    madd	w23,	w4,	w22,	w25

    add	w0,	w23,	w18
    movz	w18,	#110
    movz	w23,	#94
    madd	w1,	w16,	w20,	w0

    madd	w7,	w6,	w19,	w1

    ldr	w0,	[sp, #1120]

    movz	w16,	#39
    madd	w0,	w0,	w18,	w7

    ldr	w13,	[sp, #1100]

    ldr	w24,	[sp, #364]

    madd	w0,	w13,	w17,	w0

    madd	w5,	w24,	w16,	w0

    ldr	w0,	[sp, #1024]

    neg	w10,	w0
    lsl	w11,	w10,	#6
    ldr	w0,	[sp, #1032]

    sub	w10,	w11,	w10,	lsl #0
    add	w8,	w5,	w10
    madd	w12,	w0,	w14,	w8

    ldr	w0,	[sp, #1104]

    lsl	w14,	w0,	#0
    ldr	w0,	[sp, #1104]

    ldr	w20,	[sp, #1108]

    add	w19,	w14,	w0,	lsl #6
    lsl	w5,	w20,	#7
    ldr	w21,	[sp, #1108]

    ldr	w28,	[sp, #1728]

    add	w13,	w12,	w19
    sub	w21,	w5,	w21,	lsl #3
    mov	w11,	w28
    ldr	w26,	[sp, #420]

    ldr	w22,	[sp, #1088]

    add	w15,	w13,	w21
    neg	w10,	w22
    ldr	w8,	[sp, #1036]

    lsl	w18,	w10,	#1
    madd	w1,	w26,	w11,	w15

    add	w26,	w18,	w10,	lsl #2
    add	w1,	w1,	w26
    madd	w0,	w8,	w23,	w1

    cmp	w0,	#0
    movz	w22,	#0
    mov	w25,	w22
    csel	w28,	w25,	w0,	lt
    cmp	w0,	#127
    movz	w6,	#122
    movz	w23,	#110
    ldr	w2,	[sp, #448]

    movz	w11,	#49
    movz	w3,	#127
    mov	w10,	w6
    mov	w20,	w23
    mov	w17,	w11
    csel	w22,	w3,	w28,	gt
    movz	w6,	#65419
    lsl	w3,	w22,	#7
    movk	w6,	#65535,	lsl #16
    sub	w14,	w3,	w22,	lsl #0
    movz	w3,	#85
    add	w21,	w2,	w14
    str	w21,	[sp, #1396]

    ldr	w22,	[sp, #444]

    neg	w25,	w22
    lsl	w4,	w25,	#6
    mov	w22,	w3
    movz	w3,	#125
    sub	w26,	w4,	w25,	lsl #0
    mov	w5,	w3
    str	w26,	[sp, #1972]

    str	w17,	[sp, #2420]

    movz	w26,	#50
    ldr	w13,	[sp, #1048]

    mov	w2,	w26
    ldr	w14,	[sp, #1048]

    lsl	w27,	w13,	#3
    add	w13,	w27,	w14,	lsl #6
    str	w13,	[sp, #536]

    ldr	w12,	[sp, #1068]

    neg	w0,	w12
    lsl	w15,	w0,	#5
    sub	w26,	w15,	w0,	lsl #1
    str	w26,	[sp, #516]

    ldr	w11,	[sp, #1052]

    movz	w26,	#11
    lsl	w27,	w11,	#2
    ldr	w12,	[sp, #1052]

    mov	w7,	w26
    add	w1,	w27,	w12,	lsl #3
    movz	w27,	#83
    mov	w23,	w27
    str	w1,	[sp, #520]

    str	w5,	[sp, #1640]

    ldr	w21,	[sp, #1092]

    neg	w28,	w21
    lsl	w5,	w28,	#0
    add	w19,	w5,	w28,	lsl #6
    str	w19,	[sp, #492]

    str	w20,	[sp, #1172]

    ldr	w24,	[sp, #416]

    neg	w25,	w24
    lsl	w5,	w25,	#5
    sub	w3,	w5,	w25,	lsl #0
    movz	w5,	#65489
    movk	w5,	#65535,	lsl #16
    str	w3,	[sp, #116]

    mov	w26,	w5
    ldr	w17,	[sp, #296]

    movz	w5,	#118
    mov	w20,	w17
    mov	w18,	w5
    str	w20,	[sp, #1136]

    movz	w17,	#125
    str	w23,	[sp, #1140]

    movz	w20,	#95
    mov	w9,	w17
    str	w10,	[sp, #2096]

    mov	w19,	w20
    str	w7,	[sp, #2092]

    mov	w10,	w6
    movz	w20,	#65513
    str	w26,	[sp, #1512]

    movk	w20,	#65535,	lsl #16
    ldr	w13,	[sp, #1108]

    mov	w5,	w20
    neg	w1,	w13
    lsl	w13,	w1,	#5
    str	w13,	[sp, #1300]

    str	w19,	[sp, #1552]

    str	w18,	[sp, #1612]

    ldr	w12,	[sp, #420]

    ldr	w25,	[sp, #1056]

    add	w16,	w12,	w25
    str	w16,	[sp, #1356]

    str	w10,	[sp, #1572]

    ldr	w25,	[sp, #440]

    ldr	w12,	[sp, #424]

    add	w13,	w25,	w12
    ldr	w4,	[sp, #1032]

    ldr	w0,	[sp, #1084]

    add	w21,	w4,	w0
    str	w5,	[sp, #168]

    ldr	w0,	[sp, #1028]

    ldr	w4,	[sp, #1972]

    ldr	w3,	[sp, #2420]

    madd	w4,	w0,	w3,	w4

    ldr	w5,	[sp, #1044]

    madd	w17,	w5,	w2,	w4

    ldr	w4,	[sp, #536]

    add	w0,	w17,	w4
    ldr	w2,	[sp, #308]

    madd	w28,	w2,	w22,	w0

    ldr	w0,	[sp, #516]

    add	w0,	w28,	w0
    ldr	w2,	[sp, #520]

    ldr	w19,	[sp, #492]

    add	w18,	w0,	w2
    add	w22,	w18,	w19
    ldr	w18,	[sp, #1016]

    ldr	w0,	[sp, #1756]

    madd	w0,	w18,	w0,	w22

    ldr	w7,	[sp, #1020]

    madd	w17,	w13,	w9,	w0

    ldr	w0,	[sp, #1172]

    madd	w6,	w7,	w0,	w17

    ldr	w12,	[sp, #116]

    add	w9,	w6,	w12
    ldr	w4,	[sp, #1120]

    ldr	w25,	[sp, #1136]

    ldr	w0,	[sp, #1100]

    madd	w27,	w4,	w25,	w9

    ldr	w3,	[sp, #1140]

    madd	w17,	w0,	w3,	w27

    ldr	w7,	[sp, #364]

    ldr	w0,	[sp, #2096]

    madd	w4,	w7,	w0,	w17

    ldr	w6,	[sp, #1024]

    ldr	w28,	[sp, #2092]

    madd	w3,	w6,	w28,	w4

    ldr	w6,	[sp, #168]

    madd	w13,	w21,	w6,	w3

    ldr	w2,	[sp, #1104]

    ldr	w8,	[sp, #1512]

    madd	w4,	w2,	w8,	w13

    ldr	w11,	[sp, #1300]

    add	w5,	w4,	w11
    ldr	w9,	[sp, #1356]

    ldr	w0,	[sp, #1572]

    ldr	w16,	[sp, #1088]

    madd	w25,	w9,	w0,	w5

    ldr	w12,	[sp, #1552]

    madd	w24,	w16,	w12,	w25

    ldr	w25,	[sp, #1036]

    ldr	w3,	[sp, #1612]

    madd	w7,	w25,	w3,	w24

    cmp	w7,	#0
    movz	w21,	#0
    mov	w23,	w21
    csel	w0,	w23,	w7,	lt
    cmp	w7,	#127
    movz	w26,	#101
    movz	w17,	#82
    movz	w20,	#75
    movz	w9,	#127
    mov	w3,	w9
    movz	w9,	#116
    csel	w13,	w3,	w0,	gt
    ldr	w0,	[sp, #360]

    ldr	w25,	[sp, #1396]

    mov	w1,	w0
    madd	w1,	w13,	w1,	w25

    str	w1,	[sp, #452]

    ldr	w16,	[sp, #1084]

    movz	w1,	#65432
    lsl	w5,	w16,	#3
    ldr	w23,	[sp, #444]

    movk	w1,	#65535,	lsl #16
    madd	w8,	w23,	w17,	w5

    mov	w0,	w1
    str	w0,	[sp, #1740]

    ldr	w2,	[sp, #1028]

    ldr	w25,	[sp, #1740]

    madd	w13,	w2,	w25,	w8

    ldr	w22,	[sp, #1044]

    movz	w25,	#65420
    madd	w18,	w22,	w26,	w13

    movk	w25,	#65535,	lsl #16
    movz	w22,	#65422
    mov	w23,	w25
    movk	w22,	#65535,	lsl #16
    str	w23,	[sp, #1072]

    ldr	w8,	[sp, #1048]

    ldr	w0,	[sp, #1072]

    madd	w27,	w8,	w0,	w18

    ldr	w5,	[sp, #308]

    ldr	w18,	[sp, #1068]

    neg	w0,	w5
    ldr	w4,	[sp, #172]

    neg	w1,	w18
    lsl	w17,	w0,	#6
    mov	w12,	w4
    sub	w14,	w17,	w0,	lsl #0
    lsl	w17,	w1,	#4
    ldr	w0,	[sp, #1052]

    ldr	w8,	[sp, #424]

    add	w25,	w27,	w14
    ldr	w6,	[sp, #1640]

    movz	w14,	#59
    add	w2,	w25,	w17
    movz	w17,	#65435
    movk	w17,	#65535,	lsl #16
    madd	w0,	w0,	w12,	w2

    madd	w0,	w8,	w6,	w0

    ldr	w6,	[sp, #1056]

    madd	w6,	w6,	w20,	w0

    ldr	w2,	[sp, #1092]

    lsl	w0,	w2,	#1
    ldr	w3,	[sp, #1092]

    add	w1,	w0,	w3,	lsl #6
    add	w11,	w6,	w1
    ldr	w6,	[sp, #1016]

    mov	w1,	w22
    neg	w2,	w6
    ldr	w10,	[sp, #440]

    lsl	w5,	w2,	#5
    str	w1,	[sp, #388]

    add	w4,	w5,	w2,	lsl #6
    ldr	w2,	[sp, #388]

    ldr	w26,	[sp, #1020]

    add	w5,	w11,	w4
    ldr	w0,	[sp, #416]

    madd	w20,	w10,	w17,	w5

    madd	w11,	w26,	w2,	w20

    ldr	w2,	[sp, #1120]

    madd	w15,	w0,	w14,	w11

    lsl	w4,	w2,	#2
    ldr	w0,	[sp, #1120]

    add	w21,	w4,	w0,	lsl #3
    add	w14,	w15,	w21
    ldr	w21,	[sp, #1100]

    lsl	w5,	w21,	#0
    ldr	w25,	[sp, #1100]

    ldr	w10,	[sp, #348]

    add	w24,	w5,	w25,	lsl #2
    ldr	w26,	[sp, #364]

    mov	w7,	w10
    movz	w5,	#79
    ldr	w28,	[sp, #1024]

    add	w14,	w14,	w24
    madd	w0,	w26,	w7,	w14

    movz	w7,	#65443
    madd	w0,	w28,	w9,	w0

    movk	w7,	#65535,	lsl #16
    ldr	w28,	[sp, #1032]

    ldr	w2,	[sp, #1104]

    madd	w3,	w28,	w7,	w0

    ldr	w1,	[sp, #1104]

    lsl	w6,	w2,	#4
    ldr	w28,	[sp, #1108]

    ldr	w20,	[sp, #420]

    sub	w0,	w6,	w1,	lsl #0
    ldr	w17,	[sp, #420]

    lsl	w7,	w20,	#0
    ldr	w27,	[sp, #1088]

    ldr	w16,	[sp, #1036]

    add	w0,	w3,	w0
    add	w2,	w7,	w17,	lsl #1
    neg	w18,	w16
    lsl	w20,	w18,	#7
    madd	w1,	w28,	w5,	w0

    sub	w15,	w20,	w18,	lsl #2
    add	w13,	w1,	w2
    movz	w2,	#49
    madd	w1,	w27,	w2,	w13

    add	w26,	w1,	w15
    cmp	w26,	#0
    movz	w0,	#0
    csel	w13,	w0,	w26,	lt
    cmp	w26,	#127
    movz	w22,	#38
    movz	w12,	#55
    movz	w16,	#65523
    movz	w0,	#127
    movz	w27,	#65462
    movz	w18,	#81
    movk	w16,	#65535,	lsl #16
    csel	w9,	w0,	w13,	gt
    movk	w27,	#65535,	lsl #16
    mov	w2,	w18
    neg	w5,	w9
    lsl	w13,	w5,	#0
    add	w11,	w13,	w5,	lsl #1
    ldr	w5,	[sp, #452]

    add	w5,	w5,	w11
    str	w5,	[sp, #1628]

    ldr	w24,	[sp, #444]

    lsl	w13,	w24,	#2
    ldr	w5,	[sp, #444]

    ldr	w4,	[sp, #1084]

    add	w19,	w13,	w5,	lsl #6
    ldr	w23,	[sp, #1760]

    mov	w1,	w23
    ldr	w23,	[sp, #1028]

    madd	w15,	w4,	w2,	w19

    madd	w17,	w23,	w1,	w15

    mov	w4,	w27
    mov	w23,	w16
    str	w4,	[sp, #1748]

    ldr	w0,	[sp, #1044]

    movz	w4,	#121
    ldr	w28,	[sp, #1748]

    mov	w9,	w4
    madd	w10,	w0,	w28,	w17

    str	w10,	[sp, #2408]

    ldr	w19,	[sp, #308]

    movz	w10,	#82
    neg	w26,	w19
    lsl	w6,	w26,	#4
    sub	w25,	w6,	w26,	lsl #0
    mov	w26,	w12
    movz	w6,	#101
    mov	w12,	w22
    mov	w24,	w6
    str	w25,	[sp, #1724]

    str	w23,	[sp, #120]

    ldr	w0,	[sp, #1056]

    neg	w27,	w0
    lsl	w11,	w27,	#6
    movz	w0,	#0
    sub	w7,	w11,	w27,	lsl #1
    str	w7,	[sp, #164]

    movz	w7,	#114
    ldr	w3,	[sp, #1092]

    mov	w22,	w7
    lsl	w4,	w3,	#6
    str	w4,	[sp, #2248]

    str	w12,	[sp, #1132]

    ldr	w16,	[sp, #1744]

    mov	w23,	w16
    str	w23,	[sp, #1144]

    ldr	w28,	[sp, #364]

    neg	w6,	w28
    lsl	w20,	w6,	#1
    add	w28,	w20,	w6,	lsl #3
    str	w28,	[sp, #2328]

    ldr	w4,	[sp, #1024]

    neg	w25,	w4
    lsl	w23,	w25,	#4
    str	w23,	[sp, #1968]

    movz	w23,	#65486
    movk	w23,	#65535,	lsl #16
    mov	w28,	w23
    str	w28,	[sp, #1712]

    ldr	w21,	[sp, #1104]

    sub	w1,	w0,	w21
    ldr	w8,	[sp, #1072]

    movz	w0,	#65482
    mov	w5,	w8
    movk	w0,	#65535,	lsl #16
    str	w5,	[sp, #1604]

    mov	w8,	w10
    mov	w23,	w0
    str	w23,	[sp, #1596]

    str	w8,	[sp, #1580]

    ldr	w16,	[sp, #1036]

    neg	w18,	w16
    lsl	w5,	w18,	#3
    add	w15,	w5,	w18,	lsl #6
    str	w15,	[sp, #1520]

    ldr	w23,	[sp, #416]

    ldr	w11,	[sp, #1100]

    add	w8,	w11,	w23
    ldr	w15,	[sp, #1016]

    ldr	w14,	[sp, #1120]

    ldr	w13,	[sp, #1048]

    add	w19,	w8,	w1
    ldr	w25,	[sp, #2408]

    madd	w0,	w13,	w9,	w25

    ldr	w12,	[sp, #1724]

    ldr	w9,	[sp, #1068]

    add	w0,	w0,	w12
    lsl	w5,	w19,	#7
    ldr	w28,	[sp, #1052]

    madd	w6,	w9,	w26,	w0

    sub	w16,	w5,	w19,	lsl #4
    madd	w6,	w28,	w24,	w6

    add	w5,	w14,	w15
    ldr	w14,	[sp, #120]

    ldr	w15,	[sp, #424]

    madd	w4,	w15,	w14,	w6

    ldr	w6,	[sp, #164]

    add	w1,	w4,	w6
    ldr	w18,	[sp, #2248]

    add	w15,	w1,	w18
    ldr	w1,	[sp, #440]

    ldr	w2,	[sp, #1132]

    madd	w15,	w1,	w2,	w15

    ldr	w0,	[sp, #1020]

    ldr	w21,	[sp, #1144]

    madd	w8,	w0,	w21,	w15

    ldr	w0,	[sp, #2328]

    madd	w8,	w5,	w22,	w8

    ldr	w27,	[sp, #1968]

    add	w26,	w8,	w0
    ldr	w0,	[sp, #1032]

    add	w28,	w26,	w27
    ldr	w27,	[sp, #1712]

    ldr	w26,	[sp, #1108]

    madd	w23,	w0,	w27,	w28

    ldr	w4,	[sp, #1604]

    add	w0,	w23,	w16
    ldr	w22,	[sp, #420]

    ldr	w18,	[sp, #1596]

    ldr	w25,	[sp, #1088]

    madd	w3,	w26,	w4,	w0

    ldr	w6,	[sp, #1580]

    madd	w18,	w22,	w18,	w3

    ldr	w5,	[sp, #1520]

    madd	w15,	w25,	w6,	w18

    add	w15,	w15,	w5
    cmp	w15,	#0
    movz	w24,	#0
    mov	w28,	w24
    csel	w18,	w28,	w15,	lt
    cmp	w15,	#127
    movz	w4,	#65459
    movz	w8,	#81
    ldr	w7,	[sp, #1628]

    movz	w3,	#65446
    movz	fp,	#1716
    movz	w2,	#58
    movz	w27,	#127
    movk	w4,	#65535,	lsl #16
    mov	w21,	w8
    movk	w3,	#65535,	lsl #16
    mov	w23,	w27
    mov	w5,	w4
    csel	w12,	w23,	w18,	gt
    lsl	w13,	w12,	#5
    mov	w23,	w3
    movz	w12,	#67
    add	w18,	w7,	w13
    mov	w22,	w12
    movz	w12,	#86
    str	w18,	[sp, #1496]

    str	x5,	[sp, fp]

    ldr	w14,	[sp, #444]

    movz	fp,	#1716
    ldr	x6,	[sp, fp]

    mul	w20,	w14,	w6
    str	w20,	[sp, #1540]

    str	w23,	[sp, #1704]

    ldr	w25,	[sp, #1048]

    neg	w28,	w25
    lsl	w5,	w28,	#1
    add	w7,	w5,	w28,	lsl #2
    str	w7,	[sp, #1168]

    ldr	w28,	[sp, #308]

    neg	w17,	w28
    lsl	w7,	w17,	#5
    sub	w1,	w7,	w17,	lsl #1
    movz	w17,	#55
    str	w1,	[sp, #2136]

    ldr	w20,	[sp, #1068]

    neg	w9,	w20
    movz	w20,	#59
    lsl	w18,	w9,	#3
    mov	w3,	w20
    str	w18,	[sp, #1148]

    str	w21,	[sp, #1152]

    ldr	w19,	[sp, #424]

    lsl	w6,	w19,	#1
    str	w6,	[sp, #1528]

    ldr	w21,	[sp, #152]

    movz	w6,	#52
    mov	w10,	w21
    mov	w14,	w6
    str	w10,	[sp, #1536]

    mov	w6,	w17
    ldr	w11,	[sp, #348]

    mov	w10,	w11
    str	w3,	[sp, #1576]

    mov	w3,	w2
    str	w14,	[sp, #1128]

    mov	w2,	w12
    str	w6,	[sp, #1616]

    movz	w12,	#65457
    ldr	w11,	[sp, #1120]

    movk	w12,	#65535,	lsl #16
    neg	w17,	w11
    lsl	w0,	w17,	#0
    ldr	w11,	[sp, #1100]

    lsl	w7,	w11,	#4
    add	w27,	w0,	w17,	lsl #5
    ldr	w0,	[sp, #1100]

    mov	w17,	w12
    sub	w7,	w7,	w0,	lsl #1
    movz	w0,	#0
    mov	w5,	w0
    str	w7,	[sp, #2196]

    str	w3,	[sp, #1516]

    str	w22,	[sp, #1124]

    str	w2,	[sp, #1276]

    str	w17,	[sp, #1556]

    ldr	w14,	[sp, #1108]

    lsl	w2,	w14,	#4
    ldr	w17,	[sp, #1108]

    add	w9,	w2,	w17,	lsl #5
    str	w9,	[sp, #1292]

    ldr	w11,	[sp, #120]

    mov	w4,	w11
    str	w4,	[sp, #1472]

    ldr	w7,	[sp, #1088]

    ldr	w6,	[sp, #1028]

    sub	w18,	w5,	w7
    ldr	w26,	[sp, #1036]

    add	w17,	w26,	w6
    lsl	w7,	w17,	#1
    add	w0,	w7,	w17,	lsl #6
    str	w0,	[sp, #1592]

    ldr	w0,	[sp, #1020]

    ldr	w13,	[sp, #1084]

    add	w22,	w0,	w13
    add	w20,	w22,	w18
    lsl	w22,	w20,	#4
    sub	w17,	w22,	w20,	lsl #0
    str	w17,	[sp, #1360]

    ldr	w0,	[sp, #1044]

    ldr	w4,	[sp, #1540]

    ldr	w17,	[sp, #1704]

    madd	w12,	w0,	w17,	w4

    ldr	w15,	[sp, #1168]

    add	w8,	w12,	w15
    ldr	w2,	[sp, #2136]

    ldr	w6,	[sp, #1148]

    ldr	w0,	[sp, #1052]

    add	w8,	w8,	w2
    ldr	w12,	[sp, #1152]

    ldr	w25,	[sp, #1528]

    ldr	w24,	[sp, #1056]

    add	w6,	w8,	w6
    madd	w0,	w0,	w12,	w6

    add	w22,	w0,	w25
    ldr	w0,	[sp, #1536]

    ldr	w13,	[sp, #1092]

    madd	w12,	w24,	w0,	w22

    ldr	w15,	[sp, #1016]

    madd	w0,	w13,	w10,	w12

    ldr	w8,	[sp, #1576]

    madd	w0,	w15,	w8,	w0

    ldr	w17,	[sp, #440]

    ldr	w1,	[sp, #1128]

    ldr	w22,	[sp, #416]

    madd	w6,	w17,	w1,	w0

    ldr	w19,	[sp, #1616]

    madd	w28,	w22,	w19,	w6

    ldr	w21,	[sp, #2196]

    add	w16,	w28,	w27
    ldr	w8,	[sp, #364]

    ldr	w6,	[sp, #1516]

    ldr	w9,	[sp, #1024]

    add	w1,	w16,	w21
    ldr	w22,	[sp, #1124]

    ldr	w0,	[sp, #1032]

    ldr	w24,	[sp, #1276]

    madd	w8,	w8,	w6,	w1

    ldr	w6,	[sp, #1104]

    madd	w16,	w9,	w22,	w8

    ldr	w26,	[sp, #1556]

    madd	w18,	w0,	w24,	w16

    madd	w18,	w6,	w26,	w18

    ldr	w0,	[sp, #1292]

    add	w13,	w18,	w0
    ldr	w28,	[sp, #420]

    ldr	w14,	[sp, #1472]

    ldr	w12,	[sp, #1360]

    madd	w20,	w28,	w14,	w13

    ldr	w8,	[sp, #1592]

    add	w15,	w20,	w12
    add	w0,	w15,	w8
    cmp	w0,	#0
    movz	w7,	#0
    mov	w8,	w7
    csel	w20,	w8,	w0,	lt
    cmp	w0,	#127
    movz	w2,	#107
    movz	w8,	#127
    csel	w6,	w8,	w20,	gt
    ldr	w20,	[sp, #348]

    ldr	w1,	[sp, #1496]

    mov	w16,	w20
    movz	w20,	#71
    madd	w27,	w6,	w16,	w1

    str	w27,	[sp, #488]

    movz	w16,	#67
    movz	w27,	#83
    ldr	w19,	[sp, #1084]

    mov	w26,	w16
    ldr	w7,	[sp, #1084]

    lsl	w14,	w19,	#0
    add	w3,	w14,	w7,	lsl #5
    str	w3,	[sp, #1664]

    str	w26,	[sp, #1656]

    ldr	w12,	[sp, #1044]

    ldr	w0,	[sp, #1044]

    lsl	w21,	w12,	#5
    sub	w4,	w21,	w0,	lsl #1
    str	w4,	[sp, #2140]

    mov	w4,	w2
    ldr	w12,	[sp, #1048]

    neg	w23,	w12
    lsl	w14,	w23,	#1
    str	w14,	[sp, #1600]

    ldr	w22,	[sp, #1068]

    ldr	w16,	[sp, #1068]

    lsl	w17,	w22,	#7
    sub	w24,	w17,	w16,	lsl #3
    mov	w17,	w27
    mov	w16,	w20
    movz	w27,	#46
    str	w24,	[sp, #1376]

    mov	w26,	w27
    ldr	w18,	[sp, #120]

    movz	w27,	#65452
    mov	w1,	w18
    movk	w27,	#65535,	lsl #16
    str	w1,	[sp, #1340]

    ldr	w21,	[sp, #424]

    ldr	w8,	[sp, #424]

    lsl	w7,	w21,	#1
    add	w12,	w7,	w8,	lsl #4
    movz	w8,	#65417
    movk	w8,	#65535,	lsl #16
    str	w12,	[sp, #1492]

    mov	w13,	w8
    ldr	w10,	[sp, #1056]

    ldr	w5,	[sp, #1056]

    lsl	w3,	w10,	#0
    add	w25,	w3,	w5,	lsl #2
    movz	w3,	#104
    mov	w1,	w3
    str	w1,	[sp, #460]

    ldr	w6,	[sp, #440]

    neg	w8,	w6
    lsl	w24,	w8,	#3
    sub	w7,	w24,	w8,	lsl #0
    str	w7,	[sp, #244]

    ldr	w0,	[sp, #1120]

    ldr	w7,	[sp, #1120]

    lsl	w11,	w0,	#3
    add	w10,	w11,	w7,	lsl #4
    str	w10,	[sp, #1156]

    ldr	w11,	[sp, #364]

    neg	w28,	w11
    lsl	w11,	w28,	#5
    add	w21,	w11,	w28,	lsl #6
    str	w21,	[sp, #2200]

    mov	w21,	w27
    ldr	w18,	[sp, #1740]

    mov	w23,	w18
    str	w23,	[sp, #1248]

    ldr	w11,	[sp, #232]

    mov	w28,	w11
    movz	w11,	#97
    str	w28,	[sp, #1268]

    mov	w6,	w11
    str	w6,	[sp, #456]

    str	w17,	[sp, #468]

    str	w26,	[sp, #1296]

    str	w21,	[sp, #472]

    ldr	w6,	[sp, #308]

    ldr	w27,	[sp, #1104]

    add	w12,	w27,	w6
    movz	w27,	#82
    mov	w14,	w27
    lsl	w2,	w12,	#0
    add	w17,	w2,	w12,	lsl #6
    str	w17,	[sp, #1280]

    ldr	w22,	[sp, #444]

    ldr	w0,	[sp, #1100]

    add	w2,	w0,	w22
    str	w2,	[sp, #1252]

    str	w14,	[sp, #464]

    ldr	w15,	[sp, #1028]

    ldr	w2,	[sp, #1656]

    ldr	w21,	[sp, #1664]

    ldr	w5,	[sp, #2140]

    madd	w6,	w15,	w2,	w21

    ldr	w7,	[sp, #1600]

    add	w24,	w6,	w5
    add	w14,	w24,	w7
    ldr	w7,	[sp, #1376]

    ldr	w6,	[sp, #1052]

    add	w9,	w14,	w7
    ldr	w8,	[sp, #1340]

    ldr	w10,	[sp, #1492]

    madd	w5,	w6,	w8,	w9

    add	w11,	w5,	w10
    ldr	w10,	[sp, #1092]

    ldr	w22,	[sp, #460]

    add	w17,	w11,	w25
    ldr	w1,	[sp, #1016]

    ldr	w27,	[sp, #244]

    ldr	w2,	[sp, #1020]

    madd	w3,	w10,	w22,	w17

    ldr	w9,	[sp, #416]

    madd	w17,	w1,	w13,	w3

    ldr	w0,	[sp, #1156]

    add	w20,	w17,	w27
    madd	w23,	w2,	w16,	w20

    madd	w14,	w9,	w4,	w23

    ldr	w16,	[sp, #1252]

    add	w6,	w14,	w0
    ldr	w2,	[sp, #464]

    ldr	w28,	[sp, #2200]

    ldr	w1,	[sp, #1024]

    madd	w12,	w16,	w2,	w6

    ldr	w4,	[sp, #1248]

    add	w7,	w12,	w28
    ldr	w0,	[sp, #1032]

    ldr	w15,	[sp, #1268]

    madd	w7,	w1,	w4,	w7

    madd	w10,	w0,	w15,	w7

    ldr	w0,	[sp, #1280]

    ldr	w28,	[sp, #1108]

    add	w3,	w10,	w0
    ldr	w1,	[sp, #456]

    ldr	w0,	[sp, #420]

    madd	w9,	w28,	w1,	w3

    ldr	w16,	[sp, #468]

    ldr	w28,	[sp, #1088]

    madd	w3,	w0,	w16,	w9

    ldr	w0,	[sp, #1296]

    ldr	w21,	[sp, #1036]

    madd	w10,	w28,	w0,	w3

    ldr	w19,	[sp, #472]

    madd	w11,	w21,	w19,	w10

    cmp	w11,	#0
    movz	w13,	#0
    mov	w17,	w13
    csel	w19,	w17,	w11,	lt
    cmp	w11,	#127
    movz	w1,	#127
    ldr	w7,	[sp, #1712]

    movz	w24,	#38
    movz	w22,	#53
    movz	w6,	#65507
    movz	fp,	#1716
    csel	w10,	w1,	w19,	gt
    ldr	w0,	[sp, #488]

    mov	w20,	w7
    mov	w5,	w24
    movk	w6,	#65535,	lsl #16
    madd	w18,	w10,	w20,	w0

    mov	w23,	w6
    str	w18,	[sp, #1684]

    movz	w18,	#65490
    ldr	w8,	[sp, #444]

    movk	w18,	#65535,	lsl #16
    ldr	w1,	[sp, #444]

    lsl	w0,	w8,	#3
    mov	w20,	w18
    ldr	w2,	[sp, #1084]

    sub	w14,	w0,	w1,	lsl #0
    movz	w0,	#37
    madd	w7,	w2,	w23,	w14

    str	w7,	[sp, #2396]

    ldr	w12,	[sp, #1704]

    ldr	w6,	[sp, #1068]

    mov	w25,	w12
    neg	w6,	w6
    lsl	w21,	w6,	#5
    str	w21,	[sp, #2124]

    ldr	w26,	[sp, #424]

    ldr	w17,	[sp, #424]

    lsl	w3,	w26,	#2
    add	w27,	w3,	w17,	lsl #5
    mov	w3,	w22
    str	w27,	[sp, #2132]

    movz	w27,	#65463
    ldr	w15,	[sp, #176]

    movk	w27,	#65535,	lsl #16
    mov	w12,	w15
    mov	w19,	w27
    str	w12,	[sp, #1208]

    str	w20,	[sp, #2160]

    str	w19,	[sp, #1644]

    ldr	w24,	[sp, #1120]

    neg	w1,	w24
    lsl	w24,	w1,	#1
    add	w20,	w24,	w1,	lsl #5
    movz	w1,	#65449
    movk	w1,	#65535,	lsl #16
    str	w20,	[sp, #1584]

    mov	w27,	w1
    movz	w1,	#71
    str	w27,	[sp, #1560]

    mov	w21,	w1
    ldr	w4,	[sp, #384]

    mov	w15,	w4
    str	w15,	[sp, #1500]

    ldr	x6,	[sp, fp]

    mov	w17,	w6
    str	w17,	[sp, #2156]

    str	w3,	[sp, #1632]

    ldr	w27,	[sp, #320]

    mov	w7,	w27
    str	w7,	[sp, #1608]

    ldr	w9,	[sp, #120]

    mov	w1,	w9
    str	w1,	[sp, #480]

    ldr	w11,	[sp, #388]

    mov	w27,	w11
    str	w27,	[sp, #476]

    ldr	w16,	[sp, #1020]

    ldr	w10,	[sp, #1052]

    ldr	w19,	[sp, #1108]

    add	w22,	w16,	w10
    mov	w10,	w0
    add	w3,	w22,	w19
    str	w3,	[sp, #1308]

    str	w10,	[sp, #1364]

    ldr	w12,	[sp, #440]

    ldr	w0,	[sp, #1028]

    ldr	w22,	[sp, #172]

    add	w0,	w12,	w0
    ldr	w17,	[sp, #1044]

    mov	w20,	w22
    ldr	w22,	[sp, #2396]

    ldr	w9,	[sp, #1048]

    madd	w2,	w17,	w5,	w22

    ldr	w15,	[sp, #1724]

    madd	w9,	w9,	w25,	w2

    ldr	w3,	[sp, #2124]

    add	w4,	w9,	w15
    ldr	w10,	[sp, #2132]

    ldr	w9,	[sp, #164]

    add	w27,	w4,	w3
    ldr	w2,	[sp, #1092]

    add	w4,	w27,	w10
    add	w7,	w4,	w9
    ldr	w4,	[sp, #1208]

    ldr	w5,	[sp, #1016]

    madd	w12,	w2,	w4,	w7

    ldr	w24,	[sp, #2160]

    ldr	w1,	[sp, #416]

    madd	w4,	w5,	w24,	w12

    ldr	w8,	[sp, #1644]

    madd	w22,	w0,	w20,	w4

    ldr	w14,	[sp, #1584]

    madd	w5,	w1,	w8,	w22

    ldr	w28,	[sp, #1100]

    add	w3,	w5,	w14
    ldr	w0,	[sp, #1560]

    madd	w5,	w28,	w0,	w3

    ldr	w3,	[sp, #364]

    ldr	w0,	[sp, #1500]

    ldr	w16,	[sp, #1024]

    madd	w4,	w3,	w0,	w5

    ldr	w3,	[sp, #1032]

    madd	w24,	w16,	w21,	w4

    ldr	w23,	[sp, #2156]

    ldr	w21,	[sp, #1104]

    madd	w28,	w3,	w23,	w24

    ldr	w25,	[sp, #1632]

    madd	w8,	w21,	w25,	w28

    ldr	w25,	[sp, #1308]

    ldr	w1,	[sp, #1364]

    ldr	w15,	[sp, #420]

    madd	w6,	w25,	w1,	w8

    ldr	w28,	[sp, #1608]

    ldr	w5,	[sp, #1088]

    madd	w0,	w15,	w28,	w6

    ldr	w24,	[sp, #480]

    ldr	w1,	[sp, #1036]

    madd	w6,	w5,	w24,	w0

    ldr	w21,	[sp, #476]

    madd	w6,	w1,	w21,	w6

    cmp	w6,	#0
    movz	w13,	#0
    csel	w0,	w13,	w6,	lt
    cmp	w6,	#127
    movz	w21,	#41
    movz	w11,	#42
    movz	fp,	#1716
    movz	w1,	#75
    movz	w20,	#127
    movz	w12,	#65444
    movz	w6,	#65487
    movz	w5,	#115
    mov	w23,	w21
    mov	w7,	w1
    mov	w14,	w20
    movk	w12,	#65535,	lsl #16
    movk	w6,	#65535,	lsl #16
    csel	w8,	w14,	w0,	gt
    mov	w2,	w12
    ldr	w0,	[sp, #168]

    ldr	w19,	[sp, #1684]

    mov	w14,	w0
    madd	w28,	w8,	w14,	w19

    movz	w14,	#47
    movz	w19,	#109
    str	w28,	[sp, #1428]

    mov	w26,	w19
    ldr	w10,	[sp, #444]

    movz	w19,	#22
    mul	w16,	w10,	w11
    str	w16,	[sp, #2292]

    str	w23,	[sp, #2356]

    ldr	w22,	[sp, #296]

    ldr	w8,	[sp, #308]

    mov	w27,	w22
    ldr	w9,	[sp, #308]

    lsl	w21,	w8,	#1
    mov	w22,	w14
    add	w20,	w21,	w9,	lsl #3
    movz	w21,	#65414
    movz	w9,	#65485
    movk	w21,	#65535,	lsl #16
    movk	w9,	#65535,	lsl #16
    str	w20,	[sp, #2300]

    movz	w20,	#38
    ldr	x8,	[sp, fp]

    str	w8,	[sp, #532]

    mov	w8,	w9
    ldr	w11,	[sp, #424]

    mov	w9,	w5
    ldr	w12,	[sp, #424]

    lsl	w0,	w11,	#5
    add	w16,	w0,	w12,	lsl #6
    mov	w0,	w19
    str	w16,	[sp, #2112]

    str	w8,	[sp, #2344]

    str	w26,	[sp, #1824]

    ldr	w11,	[sp, #1748]

    mov	w3,	w11
    str	w3,	[sp, #1200]

    str	w22,	[sp, #1652]

    mov	w3,	w21
    str	w0,	[sp, #1816]

    ldr	w10,	[sp, #364]

    neg	w21,	w10
    mov	w10,	w20
    str	w21,	[sp, #1384]

    mov	w21,	w6
    ldr	w22,	[sp, #1384]

    ldr	w0,	[sp, #1384]

    lsl	w13,	w22,	#2
    add	w16,	w13,	w0,	lsl #6
    str	w16,	[sp, #1312]

    movz	w16,	#29
    str	w10,	[sp, #1372]

    mov	w19,	w16
    str	w19,	[sp, #1680]

    movz	w19,	#85
    str	w9,	[sp, #1692]

    mov	w10,	w19
    ldr	w24,	[sp, #232]

    mov	w9,	w24
    str	w9,	[sp, #1624]

    ldr	w24,	[sp, #420]

    ldr	w12,	[sp, #420]

    lsl	w11,	w24,	#2
    add	w16,	w11,	w12,	lsl #5
    str	w16,	[sp, #1564]

    str	w21,	[sp, #1660]

    str	w10,	[sp, #1648]

    ldr	w16,	[sp, #416]

    ldr	w26,	[sp, #1084]

    add	w6,	w16,	w26
    movz	w16,	#67
    mov	w26,	w16
    str	w6,	[sp, #1508]

    ldr	w14,	[sp, #1028]

    ldr	w1,	[sp, #2292]

    ldr	w6,	[sp, #2356]

    ldr	w10,	[sp, #1044]

    madd	w6,	w14,	w6,	w1

    ldr	w20,	[sp, #1048]

    madd	w6,	w10,	w27,	w6

    ldr	w21,	[sp, #2300]

    madd	w20,	w20,	w2,	w6

    add	w14,	w20,	w21
    ldr	w20,	[sp, #1068]

    ldr	w22,	[sp, #532]

    madd	w8,	w20,	w22,	w14

    ldr	w14,	[sp, #1052]

    ldr	w0,	[sp, #2112]

    madd	w12,	w14,	w7,	w8

    ldr	w9,	[sp, #1056]

    add	w20,	w12,	w0
    ldr	w14,	[sp, #2344]

    madd	w2,	w9,	w14,	w20

    ldr	w9,	[sp, #1092]

    ldr	w0,	[sp, #1824]

    ldr	w10,	[sp, #1016]

    madd	w8,	w9,	w0,	w2

    ldr	w2,	[sp, #1200]

    ldr	w16,	[sp, #244]

    madd	w7,	w10,	w2,	w8

    ldr	w6,	[sp, #1020]

    add	w4,	w7,	w16
    ldr	w0,	[sp, #1508]

    ldr	w8,	[sp, #1120]

    madd	w2,	w6,	w3,	w4

    ldr	w6,	[sp, #1652]

    madd	w4,	w0,	w26,	w2

    madd	w19,	w8,	w6,	w4

    ldr	w8,	[sp, #1100]

    ldr	w1,	[sp, #1816]

    ldr	w23,	[sp, #1312]

    madd	w11,	w8,	w1,	w19

    ldr	w8,	[sp, #1024]

    add	w0,	w11,	w23
    ldr	w21,	[sp, #1372]

    ldr	w28,	[sp, #1032]

    madd	w3,	w8,	w21,	w0

    ldr	w18,	[sp, #1680]

    ldr	w19,	[sp, #1104]

    madd	w4,	w28,	w18,	w3

    ldr	w0,	[sp, #1692]

    madd	w1,	w19,	w0,	w4

    ldr	w4,	[sp, #1108]

    ldr	w12,	[sp, #1624]

    ldr	w16,	[sp, #1564]

    madd	w0,	w4,	w12,	w1

    ldr	w6,	[sp, #1088]

    add	w1,	w0,	w16
    ldr	w3,	[sp, #1660]

    ldr	w2,	[sp, #1036]

    madd	w28,	w6,	w3,	w1

    ldr	w0,	[sp, #1648]

    madd	w17,	w2,	w0,	w28

    cmp	w17,	#0
    movz	w18,	#0
    csel	w28,	w18,	w17,	lt
    cmp	w17,	#127
    ldr	w0,	[sp, #1428]

    movz	w16,	#46
    movz	w5,	#127
    mov	w24,	w16
    csel	w8,	w5,	w28,	gt
    madd	w24,	w8,	w24,	w0

    cmp	w24,	#0
    cset	w26,	gt
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
    ldr	w8,	[sp, #428]

    sub	w20,	w8,	#1
    cmp	w20,	#0
    ble	main_617

main_36:
    mov	w9,	w20
    str	w9,	[sp, #428]

    b	main_37

main_39:
    mov	w19,	w22
    b	main_40

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2432
    ret


