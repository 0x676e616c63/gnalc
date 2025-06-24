.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#4448
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x9,	sp,	#16
    movz	fp,	#148
    mov	w25,	w0
    mov	x26,	x9
    add	x2,	x26,	#16
    add	x28,	x26,	#12
    add	x10,	x9,	#80
    add	x4,	x9,	#20
    add	x27,	x9,	#60
    add	x14,	x26,	#8
    add	x23,	x26,	#4
    mov	x21,	x26
    add	x22,	x4,	#16
    add	x20,	x4,	#12
    add	x17,	x4,	#8
    add	x7,	x27,	#16
    add	x3,	x27,	#8
    str	x21,	[sp, #120]

    str	x23,	[sp, fp]

    mov	x23,	x27
    movz	fp,	#140
    str	x14,	[sp, #392]

    add	x14,	x4,	#4
    str	x28,	[sp, #432]

    add	x28,	x27,	#4
    str	x2,	[sp, fp]

    add	x2,	x9,	#40
    movz	fp,	#508
    mov	x24,	x2
    str	x4,	[sp, fp]

    add	x21,	x2,	#16
    add	x18,	x2,	#12
    add	x15,	x2,	#8
    add	x1,	x2,	#4
    add	x4,	x27,	#12
    movz	fp,	#364
    str	x14,	[sp, #520]

    add	x14,	x10,	#4
    str	x17,	[sp, #376]

    add	x17,	x10,	#8
    str	x20,	[sp, #384]

    add	x20,	x10,	#12
    str	x22,	[sp, #440]

    add	x22,	x10,	#16
    str	x24,	[sp, #448]

    str	x1,	[sp, #352]

    str	x15,	[sp, fp]

    movz	fp,	#484
    str	x18,	[sp, fp]

    movz	fp,	#460
    str	x21,	[sp, fp]

    movz	fp,	#468
    str	x23,	[sp, fp]

    movz	fp,	#476
    str	x28,	[sp, fp]

    movz	fp,	#164
    str	x3,	[sp, #400]

    str	x4,	[sp, #408]

    str	x7,	[sp, #416]

    str	x10,	[sp, #424]

    str	x14,	[sp, fp]

    movz	fp,	#172
    str	x17,	[sp, fp]

    movz	fp,	#180
    str	x20,	[sp, fp]

    str	x22,	[sp, #496]

    str	w25,	[sp, #604]


main_37:
    movz	w25,	#0
    mov	w24,	w25

main_40:
    lsl	w7,	w24,	#2
    movz	w3,	#0
    mov	w19,	w3
    add	w11,	w7,	w24,	lsl #4
    mov	x22,	x11
    add	x22,	sp,	x22
    add	x22,	x22,	#16

main_43:
    cmp	w19,	#5
    bge	main_50

main_46:
    lsl	w18,	w19,	#2
    add	x21,	x22,	x18
    bl	getint
    add	w11,	w19,	#1
    str	w0,	[x21]

    mov	w19,	w11
    b	main_43

main_50:
    add	w17,	w24,	#1
    cmp	w17,	#5
    blt	main_39

main_53:
    ldr	x12,	[sp, #120]

    movz	w21,	#85
    movz	fp,	#148
    movz	w18,	#23
    movz	w28,	#65454
    movz	w24,	#65433
    movz	w15,	#65413
    ldr	w5,	[x12]

    mov	w20,	w18
    movk	w28,	#65535,	lsl #16
    movk	w24,	#65535,	lsl #16
    movk	w15,	#65535,	lsl #16
    str	w5,	[sp, #660]

    mov	w8,	w28
    mov	w1,	w24
    ldr	w25,	[sp, #660]

    ldr	x16,	[sp, fp]

    mul	w0,	w25,	w21
    ldr	w12,	[x16]

    movz	fp,	#140
    str	w12,	[sp, #544]

    ldr	w13,	[sp, #544]

    ldr	x6,	[sp, #392]

    madd	w19,	w13,	w20,	w0

    ldr	w21,	[x6]

    mov	w13,	w15
    movz	w20,	#50
    str	w21,	[sp, #628]

    ldr	w23,	[sp, #628]

    madd	w16,	w23,	w8,	w19

    movz	w23,	#65425
    str	w16,	[sp, #1364]

    movk	w23,	#65535,	lsl #16
    ldr	x19,	[sp, #432]

    mov	w6,	w23
    ldr	w27,	[x19]

    str	w27,	[sp, #640]

    str	w1,	[sp, #536]

    ldr	x22,	[sp, fp]

    movz	w1,	#65461
    ldr	w11,	[x22]

    movz	fp,	#508
    movk	w1,	#65535,	lsl #16
    str	w11,	[sp, #644]

    str	w13,	[sp, #132]

    mov	w11,	w1
    ldr	x25,	[sp, fp]

    ldr	w14,	[x25]

    movz	fp,	#364
    str	w14,	[sp, #504]

    mov	w25,	w20
    ldr	w15,	[sp, #504]

    lsl	w13,	w15,	#6
    str	w13,	[sp, #1360]

    ldr	x4,	[sp, #520]

    ldr	w21,	[x4]

    str	w21,	[sp, #656]

    ldr	w22,	[sp, #656]

    movz	w21,	#65477
    neg	w4,	w22
    movk	w21,	#65535,	lsl #16
    lsl	w27,	w4,	#7
    movz	w22,	#65497
    movk	w22,	#65535,	lsl #16
    sub	w28,	w27,	w4,	lsl #3
    str	w28,	[sp, #1344]

    ldr	x7,	[sp, #376]

    movz	w28,	#65469
    ldr	w24,	[x7]

    movk	w28,	#65535,	lsl #16
    str	w24,	[sp, #648]

    mov	w0,	w28
    str	w25,	[sp, #1340]

    ldr	x10,	[sp, #384]

    ldr	w26,	[x10]

    mov	w10,	w21
    str	w26,	[sp, #548]

    str	w10,	[sp, #1356]

    ldr	x14,	[sp, #440]

    ldr	w9,	[x14]

    str	w9,	[sp, #652]

    ldr	x17,	[sp, #448]

    ldr	w2,	[x17]

    str	w2,	[sp, #668]

    str	w6,	[sp, #1948]

    ldr	x23,	[sp, #352]

    mov	w6,	w22
    ldr	w17,	[x23]

    movz	w22,	#46
    str	w17,	[sp, #616]

    str	w0,	[sp, #1412]

    ldr	x9,	[sp, fp]

    movz	w0,	#65430
    movz	fp,	#484
    ldr	w25,	[x9]

    movk	w0,	#65535,	lsl #16
    str	w25,	[sp, #360]

    mov	w24,	w0
    str	w24,	[sp, #116]

    ldr	x12,	[sp, fp]

    ldr	w0,	[x12]

    movz	fp,	#460
    str	w0,	[sp, #620]

    str	w11,	[sp, #128]

    movz	w0,	#65434
    ldr	x15,	[sp, fp]

    movk	w0,	#65535,	lsl #16
    ldr	w20,	[x15]

    movz	fp,	#468
    mov	w11,	w0
    str	w20,	[sp, #608]

    str	w11,	[sp, #1420]

    ldr	x18,	[sp, fp]

    movz	w11,	#113
    movz	fp,	#476
    ldr	w0,	[x18]

    str	w0,	[sp, #684]

    ldr	w1,	[sp, #684]

    lsl	w27,	w1,	#1
    ldr	w2,	[sp, #684]

    add	w9,	w27,	w2,	lsl #5
    str	w9,	[sp, #584]

    ldr	x21,	[sp, fp]

    ldr	w20,	[x21]

    movz	fp,	#164
    str	w20,	[sp, #672]

    mov	w21,	w11
    str	w6,	[sp, #1380]

    movz	w11,	#110
    ldr	x24,	[sp, #400]

    mov	w15,	w11
    ldr	w0,	[x24]

    str	w0,	[sp, #492]

    ldr	w1,	[sp, #492]

    lsl	w26,	w1,	#0
    ldr	w0,	[sp, #492]

    add	w28,	w26,	w0,	lsl #6
    str	w28,	[sp, #572]

    ldr	x27,	[sp, #408]

    ldr	w12,	[x27]

    str	w12,	[sp, #624]

    ldr	x0,	[sp, #416]

    mov	w12,	w22
    ldr	w7,	[x0]

    movz	w22,	#47
    str	w7,	[sp, #632]

    mov	w27,	w22
    str	w21,	[sp, #600]

    ldr	x0,	[sp, #424]

    ldr	w1,	[x0]

    str	w1,	[sp, #676]

    str	w15,	[sp, #592]

    ldr	x7,	[sp, fp]

    ldr	w20,	[x7]

    movz	fp,	#172
    str	w20,	[sp, #680]

    ldr	x10,	[sp, fp]

    ldr	w7,	[x10]

    movz	fp,	#180
    str	w7,	[sp, #612]

    ldr	w0,	[sp, #612]

    neg	w13,	w0
    lsl	w0,	w13,	#2
    str	w0,	[sp, #1172]

    ldr	x14,	[sp, fp]

    ldr	w23,	[x14]

    str	w23,	[sp, #664]

    ldr	w24,	[sp, #664]

    lsl	w25,	w24,	#4
    ldr	w11,	[sp, #664]

    add	w26,	w25,	w11,	lsl #6
    str	w26,	[sp, #1232]

    ldr	x17,	[sp, #496]

    ldr	w20,	[x17]

    str	w20,	[sp, #636]

    ldr	w16,	[sp, #624]

    ldr	w0,	[sp, #652]

    add	w25,	w16,	w0
    ldr	w9,	[sp, #680]

    ldr	w22,	[sp, #536]

    ldr	w28,	[sp, #640]

    add	w26,	w25,	w9
    ldr	w15,	[sp, #1364]

    madd	w22,	w28,	w22,	w15

    ldr	w8,	[sp, #132]

    ldr	w21,	[sp, #644]

    ldr	w10,	[sp, #1360]

    madd	w22,	w21,	w8,	w22

    ldr	w28,	[sp, #1344]

    add	w22,	w22,	w10
    ldr	w23,	[sp, #648]

    ldr	w21,	[sp, #1340]

    add	w28,	w22,	w28
    ldr	w10,	[sp, #548]

    ldr	w9,	[sp, #1356]

    ldr	w18,	[sp, #668]

    madd	w0,	w23,	w21,	w28

    ldr	w3,	[sp, #1948]

    madd	w21,	w10,	w9,	w0

    ldr	w17,	[sp, #616]

    madd	w1,	w18,	w3,	w21

    ldr	w15,	[sp, #1412]

    madd	w22,	w17,	w15,	w1

    ldr	w4,	[sp, #116]

    ldr	w20,	[sp, #360]

    madd	w24,	w20,	w4,	w22

    ldr	w2,	[sp, #128]

    ldr	w10,	[sp, #620]

    ldr	w17,	[sp, #608]

    madd	w1,	w10,	w2,	w24

    ldr	w0,	[sp, #1420]

    madd	w15,	w17,	w0,	w1

    ldr	w20,	[sp, #584]

    add	w18,	w15,	w20
    ldr	w0,	[sp, #672]

    ldr	w20,	[sp, #1380]

    ldr	w7,	[sp, #572]

    madd	w18,	w0,	w20,	w18

    add	w19,	w18,	w7
    ldr	w7,	[sp, #632]

    ldr	w1,	[sp, #600]

    madd	w14,	w7,	w1,	w19

    ldr	w16,	[sp, #676]

    ldr	w1,	[sp, #592]

    madd	w23,	w16,	w1,	w14

    ldr	w0,	[sp, #1172]

    madd	w8,	w26,	w27,	w23

    ldr	w1,	[sp, #1232]

    add	w9,	w8,	w0
    ldr	w19,	[sp, #636]

    add	w8,	w9,	w1
    madd	w26,	w19,	w12,	w8

    cmp	w26,	#0
    movz	w22,	#0
    mov	w25,	w22
    csel	w19,	w25,	w26,	lt
    cmp	w26,	#127
    movz	w25,	#39
    movz	w21,	#65515
    movz	w24,	#127
    movz	w8,	#47
    movz	w14,	#65415
    mov	w22,	w25
    movk	w21,	#65535,	lsl #16
    csel	w15,	w24,	w19,	gt
    mov	w23,	w8
    movk	w14,	#65535,	lsl #16
    mov	w18,	w21
    mul	w12,	w15,	w22
    mov	w24,	w14
    str	w12,	[sp, #556]

    movz	w14,	#105
    ldr	w13,	[sp, #544]

    ldr	w15,	[sp, #544]

    lsl	w10,	w13,	#7
    sub	w6,	w10,	w15,	lsl #1
    movz	w15,	#67
    mov	w4,	w15
    str	w6,	[sp, #1184]

    movz	w15,	#65494
    ldr	w22,	[sp, #628]

    movk	w15,	#65535,	lsl #16
    neg	w17,	w22
    lsl	w9,	w17,	#1
    add	w2,	w9,	w17,	lsl #4
    movz	w17,	#87
    str	w2,	[sp, #1140]

    ldr	w13,	[sp, #644]

    neg	w13,	w13
    lsl	w12,	w13,	#3
    movz	w13,	#65442
    str	w12,	[sp, #1132]

    movk	w13,	#65535,	lsl #16
    ldr	w9,	[sp, #656]

    mov	w12,	w15
    mov	w26,	w13
    neg	w16,	w9
    movz	w15,	#29
    str	w26,	[sp, #1224]

    lsl	w0,	w16,	#2
    str	w24,	[sp, #516]

    mov	w26,	w14
    mov	w16,	w15
    ldr	w9,	[sp, #668]

    movz	w15,	#65411
    lsl	w1,	w9,	#3
    ldr	w11,	[sp, #668]

    movk	w15,	#65535,	lsl #16
    movz	w9,	#65426
    str	w18,	[sp, #1396]

    sub	w5,	w1,	w11,	lsl #0
    movk	w9,	#65535,	lsl #16
    ldr	w28,	[sp, #360]

    movz	w1,	#65493
    mov	w11,	w9
    str	w26,	[sp, #1100]

    neg	w18,	w28
    movk	w1,	#65535,	lsl #16
    str	w12,	[sp, #1076]

    mov	w26,	w17
    lsl	w2,	w18,	#6
    mov	w27,	w1
    movz	w12,	#65514
    movz	w17,	#65436
    str	w26,	[sp, #732]

    sub	w24,	w2,	w18,	lsl #2
    movk	w12,	#65535,	lsl #16
    movk	w17,	#65535,	lsl #16
    str	w11,	[sp, #136]

    mov	w6,	w12
    mov	w13,	w17
    mov	w11,	w15
    str	w13,	[sp, #1324]

    str	w6,	[sp, #1304]

    ldr	w26,	[sp, #128]

    str	w26,	[sp, #1124]

    str	w11,	[sp, #160]

    ldr	w15,	[sp, #632]

    ldr	w22,	[sp, #640]

    add	w2,	w15,	w22
    ldr	w17,	[sp, #624]

    neg	w28,	w2
    lsl	w9,	w28,	#5
    sub	w21,	w9,	w28,	lsl #0
    ldr	w28,	[sp, #660]

    add	w13,	w17,	w28
    ldr	w22,	[sp, #116]

    str	w22,	[sp, #1272]

    ldr	w9,	[sp, #1140]

    ldr	w10,	[sp, #1184]

    add	w11,	w9,	w10
    ldr	w2,	[sp, #1132]

    ldr	w3,	[sp, #504]

    add	w17,	w11,	w2
    ldr	w11,	[sp, #648]

    ldr	w22,	[sp, #548]

    madd	w12,	w3,	w23,	w17

    add	w15,	w12,	w0
    ldr	w3,	[sp, #1224]

    ldr	w12,	[sp, #516]

    ldr	w7,	[sp, #652]

    madd	w2,	w11,	w4,	w15

    madd	w6,	w22,	w3,	w2

    ldr	w11,	[sp, #616]

    madd	w0,	w7,	w12,	w6

    add	w0,	w0,	w5
    ldr	w12,	[sp, #1396]

    ldr	w5,	[sp, #620]

    madd	w0,	w11,	w12,	w0

    add	w2,	w0,	w24
    madd	w8,	w5,	w27,	w2

    ldr	w5,	[sp, #608]

    ldr	w24,	[sp, #1100]

    madd	w18,	w5,	w24,	w8

    ldr	w9,	[sp, #684]

    ldr	w3,	[sp, #1076]

    madd	w24,	w9,	w3,	w18

    ldr	w7,	[sp, #672]

    ldr	w15,	[sp, #732]

    madd	w24,	w7,	w15,	w24

    ldr	w8,	[sp, #492]

    ldr	w22,	[sp, #1272]

    madd	w17,	w8,	w16,	w24

    ldr	w23,	[sp, #136]

    madd	w18,	w13,	w22,	w17

    ldr	w0,	[sp, #676]

    add	w16,	w18,	w21
    ldr	w22,	[sp, #680]

    ldr	w1,	[sp, #1324]

    madd	w3,	w0,	w23,	w16

    madd	w12,	w22,	w1,	w3

    ldr	w3,	[sp, #612]

    ldr	w15,	[sp, #1304]

    ldr	w25,	[sp, #664]

    madd	w22,	w3,	w15,	w12

    ldr	w7,	[sp, #1124]

    madd	w26,	w25,	w7,	w22

    ldr	w19,	[sp, #160]

    ldr	w1,	[sp, #636]

    madd	w0,	w1,	w19,	w26

    cmp	w0,	#0
    movz	w9,	#0
    csel	w12,	w9,	w0,	lt
    cmp	w0,	#127
    movz	w14,	#26
    ldr	w16,	[sp, #556]

    movz	w15,	#127
    movz	w13,	#77
    mov	w21,	w14
    mov	w8,	w15
    mov	w22,	w13
    csel	w10,	w8,	w12,	gt
    movz	w15,	#76
    madd	w19,	w10,	w22,	w16

    mov	w14,	w15
    str	w19,	[sp, #1332]

    movz	w16,	#65466
    movz	w22,	#102
    movz	w19,	#65441
    ldr	w27,	[sp, #660]

    movk	w16,	#65535,	lsl #16
    movk	w19,	#65535,	lsl #16
    mul	w26,	w27,	w21
    ldr	w18,	[sp, #544]

    mov	w25,	w16
    mov	w5,	w19
    madd	w24,	w18,	w14,	w26

    str	w25,	[sp, #456]

    movz	w18,	#29
    ldr	w28,	[sp, #456]

    mov	w16,	w18
    ldr	w6,	[sp, #628]

    madd	w0,	w6,	w28,	w24

    ldr	w1,	[sp, #640]

    madd	w4,	w1,	w16,	w0

    str	w5,	[sp, #528]

    ldr	w7,	[sp, #528]

    ldr	w0,	[sp, #644]

    ldr	w19,	[sp, #504]

    madd	w9,	w0,	w7,	w4

    lsl	w18,	w19,	#5
    ldr	w21,	[sp, #504]

    ldr	w1,	[sp, #656]

    add	w15,	w18,	w21,	lsl #6
    ldr	w12,	[sp, #648]

    movz	w21,	#52
    mov	w25,	w21
    add	w18,	w9,	w15
    neg	w21,	w12
    lsl	w9,	w21,	#2
    madd	w25,	w1,	w25,	w18

    add	w16,	w9,	w21,	lsl #6
    mov	w18,	w22
    ldr	w9,	[sp, #548]

    neg	w24,	w9
    add	w28,	w25,	w16
    lsl	w13,	w24,	#0
    add	w19,	w13,	w24,	lsl #2
    ldr	w13,	[sp, #652]

    movz	w24,	#65498
    lsl	w20,	w13,	#1
    ldr	w14,	[sp, #652]

    add	w8,	w28,	w19
    movk	w24,	#65535,	lsl #16
    ldr	w25,	[sp, #668]

    add	w26,	w20,	w14,	lsl #5
    ldr	w16,	[sp, #616]

    neg	w9,	w25
    movz	w25,	#27
    lsl	w21,	w9,	#1
    add	w12,	w8,	w26
    mov	w13,	w25
    add	w8,	w21,	w9,	lsl #5
    ldr	w26,	[sp, #360]

    mov	w21,	w24
    movz	w9,	#116
    ldr	w28,	[sp, #360]

    lsl	w10,	w26,	#1
    add	w27,	w12,	w8
    ldr	w1,	[sp, #620]

    add	w14,	w10,	w28,	lsl #2
    movz	w8,	#110
    ldr	w23,	[sp, #608]

    movz	w10,	#39
    madd	w17,	w16,	w18,	w27

    ldr	w4,	[sp, #684]

    mov	w15,	w10
    add	w18,	w17,	w14
    madd	w17,	w1,	w21,	w18

    madd	w14,	w23,	w13,	w17

    mov	w18,	w8
    ldr	w23,	[sp, #672]

    movz	w13,	#65437
    madd	w16,	w4,	w18,	w14

    ldr	w2,	[sp, #492]

    movk	w13,	#65535,	lsl #16
    madd	w24,	w23,	w9,	w16

    ldr	w25,	[sp, #624]

    madd	w16,	w2,	w15,	w24

    neg	w14,	w25
    ldr	w6,	[sp, #632]

    lsl	w25,	w14,	#6
    ldr	w4,	[sp, #676]

    ldr	w5,	[sp, #676]

    lsl	w0,	w4,	#0
    sub	w14,	w25,	w14,	lsl #0
    ldr	w20,	[sp, #680]

    add	w19,	w0,	w5,	lsl #6
    lsl	w20,	w20,	#7
    ldr	w22,	[sp, #680]

    add	w21,	w16,	w14
    sub	w26,	w20,	w22,	lsl #3
    ldr	w1,	[sp, #1380]

    movz	w14,	#94
    mov	w23,	w1
    ldr	w2,	[sp, #612]

    madd	w24,	w6,	w13,	w21

    add	w9,	w24,	w19
    add	w10,	w9,	w26
    ldr	w9,	[sp, #664]

    neg	w26,	w9
    ldr	w22,	[sp, #636]

    madd	w11,	w2,	w23,	w10

    lsl	w9,	w26,	#1
    add	w15,	w9,	w26,	lsl #2
    add	w13,	w11,	w15
    mov	w15,	w14
    madd	w25,	w22,	w15,	w13

    cmp	w25,	#0
    movz	w15,	#0
    mov	w10,	w15
    csel	w24,	w10,	w25,	lt
    cmp	w25,	#127
    ldr	w20,	[sp, #1332]

    movz	w18,	#127
    movz	w5,	#125
    mov	w9,	w18
    csel	w21,	w9,	w24,	gt
    movz	w24,	#50
    lsl	w26,	w21,	#7
    mov	w7,	w24
    sub	w25,	w26,	w21,	lsl #0
    movz	w24,	#118
    add	w15,	w20,	w25
    movz	w25,	#125
    movz	w20,	#85
    mov	w13,	w25
    mov	w4,	w20
    str	w15,	[sp, #992]

    ldr	w16,	[sp, #544]

    neg	w18,	w16
    lsl	w8,	w18,	#6
    sub	w18,	w8,	w18,	lsl #0
    str	w18,	[sp, #996]

    ldr	w21,	[sp, #644]

    movz	w18,	#49
    lsl	w16,	w21,	#3
    ldr	w23,	[sp, #644]

    mov	w14,	w18
    movz	w21,	#95
    add	w11,	w16,	w23,	lsl #6
    mov	w19,	w21
    str	w11,	[sp, #980]

    ldr	w2,	[sp, #656]

    neg	w27,	w2
    lsl	w23,	w27,	#5
    sub	w2,	w23,	w27,	lsl #1
    str	w2,	[sp, #964]

    ldr	w2,	[sp, #648]

    ldr	w0,	[sp, #648]

    lsl	w27,	w2,	#2
    add	w2,	w27,	w0,	lsl #3
    movz	w27,	#65489
    movk	w27,	#65535,	lsl #16
    str	w2,	[sp, #968]

    str	w13,	[sp, #552]

    ldr	w13,	[sp, #668]

    neg	w2,	w13
    lsl	w1,	w2,	#0
    add	w28,	w1,	w2,	lsl #6
    movz	w1,	#110
    mov	w11,	w1
    str	w28,	[sp, #940]

    movz	w1,	#11
    str	w11,	[sp, #716]

    mov	w20,	w1
    ldr	w3,	[sp, #608]

    neg	w8,	w3
    mov	w3,	w24
    lsl	w2,	w8,	#5
    sub	w0,	w2,	w8,	lsl #0
    movz	w2,	#83
    mov	w28,	w2
    str	w0,	[sp, #1204]

    ldr	w22,	[sp, #132]

    movz	w0,	#122
    str	w22,	[sp, #696]

    mov	w25,	w0
    str	w28,	[sp, #692]

    mov	w0,	w27
    str	w25,	[sp, #688]

    str	w0,	[sp, #1116]

    ldr	w1,	[sp, #680]

    neg	w6,	w1
    lsl	w13,	w6,	#5
    movz	w1,	#65513
    mov	w6,	w5
    movk	w1,	#65535,	lsl #16
    str	w13,	[sp, #1128]

    str	w19,	[sp, #1308]

    str	w3,	[sp, #1180]

    ldr	w0,	[sp, #612]

    ldr	w26,	[sp, #652]

    add	w3,	w0,	w26
    movz	w26,	#65419
    movk	w26,	#65535,	lsl #16
    str	w3,	[sp, #1276]

    mov	w3,	w26
    ldr	w26,	[sp, #360]

    ldr	w2,	[sp, #548]

    add	w13,	w26,	w2
    ldr	w2,	[sp, #632]

    ldr	w17,	[sp, #660]

    str	w1,	[sp, #156]

    add	w24,	w2,	w17
    ldr	w5,	[sp, #628]

    ldr	w21,	[sp, #996]

    madd	w25,	w5,	w14,	w21

    ldr	w28,	[sp, #640]

    madd	w19,	w28,	w7,	w25

    ldr	w5,	[sp, #980]

    ldr	w2,	[sp, #504]

    add	w22,	w19,	w5
    madd	w17,	w2,	w4,	w22

    ldr	w4,	[sp, #964]

    add	w15,	w17,	w4
    ldr	w1,	[sp, #968]

    ldr	w23,	[sp, #940]

    ldr	w10,	[sp, #616]

    add	w17,	w15,	w1
    ldr	w21,	[sp, #1412]

    ldr	w0,	[sp, #620]

    ldr	w5,	[sp, #716]

    add	w1,	w17,	w23
    madd	w1,	w10,	w21,	w1

    madd	w1,	w13,	w6,	w1

    madd	w1,	w0,	w5,	w1

    ldr	w0,	[sp, #1204]

    add	w7,	w1,	w0
    ldr	w2,	[sp, #684]

    ldr	w14,	[sp, #696]

    ldr	w4,	[sp, #672]

    madd	w11,	w2,	w14,	w7

    ldr	w9,	[sp, #692]

    madd	w15,	w4,	w9,	w11

    ldr	w10,	[sp, #492]

    ldr	w4,	[sp, #688]

    madd	w13,	w10,	w4,	w15

    ldr	w28,	[sp, #624]

    madd	w11,	w28,	w20,	w13

    ldr	w5,	[sp, #156]

    madd	w12,	w24,	w5,	w11

    ldr	w2,	[sp, #676]

    ldr	w0,	[sp, #1116]

    ldr	w8,	[sp, #1128]

    madd	w13,	w2,	w0,	w12

    ldr	w21,	[sp, #1276]

    add	w16,	w13,	w8
    ldr	w1,	[sp, #664]

    ldr	w15,	[sp, #1308]

    madd	w16,	w21,	w3,	w16

    ldr	w22,	[sp, #636]

    madd	w28,	w1,	w15,	w16

    ldr	w4,	[sp, #1180]

    madd	w4,	w22,	w4,	w28

    cmp	w4,	#0
    movz	w20,	#0
    mov	w14,	w20
    csel	w0,	w14,	w4,	lt
    cmp	w4,	#127
    movz	w1,	#127
    movz	w28,	#101
    movz	w16,	#65443
    movz	w25,	#82
    ldr	w27,	[sp, #116]

    mov	w13,	w1
    movk	w16,	#65535,	lsl #16
    mov	w18,	w25
    mov	w12,	w27
    ldr	w15,	[sp, #992]

    csel	w9,	w13,	w0,	gt
    movz	w13,	#65420
    madd	w22,	w9,	w12,	w15

    movk	w13,	#65535,	lsl #16
    mov	w15,	w28
    movz	w9,	#65432
    str	w22,	[sp, #1336]

    mov	w2,	w13
    movk	w9,	#65535,	lsl #16
    ldr	w10,	[sp, #660]

    mov	w7,	w9
    lsl	w10,	w10,	#3
    ldr	w20,	[sp, #544]

    str	w7,	[sp, #1388]

    madd	w20,	w20,	w18,	w10

    ldr	w1,	[sp, #628]

    ldr	w10,	[sp, #1388]

    madd	w25,	w1,	w10,	w20

    ldr	w3,	[sp, #640]

    movz	w10,	#65435
    str	w2,	[sp, #1348]

    madd	w21,	w3,	w15,	w25

    movk	w10,	#65535,	lsl #16
    ldr	w18,	[sp, #644]

    ldr	w3,	[sp, #1348]

    ldr	w0,	[sp, #504]

    madd	w26,	w18,	w3,	w21

    ldr	w12,	[sp, #656]

    neg	w8,	w0
    movz	w18,	#79
    neg	w15,	w12
    lsl	w14,	w8,	#6
    ldr	w0,	[sp, #456]

    lsl	w13,	w15,	#4
    ldr	w1,	[sp, #648]

    sub	w9,	w14,	w8,	lsl #0
    ldr	w2,	[sp, #548]

    ldr	w14,	[sp, #552]

    add	w28,	w26,	w9
    mov	w9,	w0
    add	w22,	w28,	w13
    madd	w11,	w1,	w9,	w22

    movz	w9,	#75
    madd	w1,	w2,	w14,	w11

    mov	w15,	w9
    ldr	w14,	[sp, #652]

    madd	w26,	w14,	w15,	w1

    ldr	w8,	[sp, #668]

    ldr	w9,	[sp, #668]

    lsl	w15,	w8,	#1
    ldr	w0,	[sp, #616]

    add	w24,	w15,	w9,	lsl #6
    neg	w14,	w0
    lsl	w22,	w14,	#5
    ldr	w0,	[sp, #360]

    add	w19,	w26,	w24
    add	w8,	w22,	w14,	lsl #6
    movz	w14,	#59
    mov	w22,	w10
    add	w13,	w19,	w8
    mov	w19,	w14
    madd	w24,	w0,	w22,	w13

    movz	w13,	#65422
    movk	w13,	#65535,	lsl #16
    mov	w1,	w13
    str	w1,	[sp, #540]

    mov	w13,	w16
    ldr	w2,	[sp, #540]

    ldr	w15,	[sp, #620]

    madd	w22,	w15,	w2,	w24

    ldr	w2,	[sp, #608]

    madd	w9,	w2,	w19,	w22

    ldr	w27,	[sp, #684]

    movz	w19,	#49
    ldr	w1,	[sp, #684]

    lsl	w24,	w27,	#2
    add	w23,	w24,	w1,	lsl #3
    add	w15,	w9,	w23
    ldr	w9,	[sp, #672]

    ldr	w10,	[sp, #672]

    lsl	w22,	w9,	#0
    ldr	w7,	[sp, #528]

    mov	w9,	w18
    add	w26,	w22,	w10,	lsl #2
    mov	w25,	w7
    ldr	w4,	[sp, #492]

    ldr	w1,	[sp, #624]

    add	w17,	w15,	w26
    movz	w15,	#116
    ldr	w26,	[sp, #632]

    mov	w14,	w15
    madd	w27,	w4,	w25,	w17

    madd	w1,	w1,	w14,	w27

    ldr	w25,	[sp, #676]

    madd	w27,	w26,	w13,	w1

    lsl	w25,	w25,	#4
    ldr	w1,	[sp, #676]

    sub	w16,	w25,	w1,	lsl #0
    ldr	w15,	[sp, #680]

    ldr	w17,	[sp, #612]

    ldr	w18,	[sp, #612]

    lsl	w25,	w17,	#0
    add	w0,	w27,	w16
    ldr	w13,	[sp, #664]

    add	w26,	w25,	w18,	lsl #1
    ldr	w4,	[sp, #636]

    mov	w25,	w19
    madd	w10,	w15,	w9,	w0

    neg	w0,	w4
    add	w9,	w10,	w26
    madd	w19,	w13,	w25,	w9

    lsl	w9,	w0,	#7
    sub	w10,	w9,	w0,	lsl #2
    add	w15,	w19,	w10
    cmp	w15,	#0
    movz	w21,	#0
    mov	w16,	w21
    csel	w20,	w16,	w15,	lt
    cmp	w15,	#127
    movz	w9,	#127
    movz	w24,	#81
    movz	w13,	#65462
    movz	w27,	#38
    mov	w15,	w9
    mov	w21,	w24
    movk	w13,	#65535,	lsl #16
    csel	w25,	w15,	w20,	gt
    mov	w17,	w13
    neg	w14,	w25
    lsl	w23,	w14,	#0
    ldr	w25,	[sp, #1336]

    add	w8,	w23,	w14,	lsl #1
    add	w12,	w25,	w8
    str	w12,	[sp, #920]

    ldr	w19,	[sp, #544]

    movz	w12,	#55
    ldr	w23,	[sp, #544]

    lsl	w16,	w19,	#2
    mov	w2,	w12
    ldr	w11,	[sp, #660]

    add	w15,	w16,	w23,	lsl #6
    ldr	w5,	[sp, #1420]

    movz	w16,	#121
    mov	w22,	w5
    ldr	w0,	[sp, #628]

    mov	w13,	w16
    madd	w15,	w11,	w21,	w15

    str	w17,	[sp, #1404]

    madd	w20,	w0,	w22,	w15

    ldr	w4,	[sp, #640]

    mov	w15,	w27
    ldr	w21,	[sp, #1404]

    madd	w9,	w4,	w21,	w20

    ldr	w18,	[sp, #504]

    movz	w20,	#82
    neg	w26,	w18
    lsl	w18,	w26,	#4
    sub	w8,	w18,	w26,	lsl #0
    movz	w26,	#101
    str	w8,	[sp, #1384]

    mov	w8,	w26
    movz	w26,	#65523
    movk	w26,	#65535,	lsl #16
    mov	w1,	w26
    str	w1,	[sp, #1416]

    movz	w26,	#0
    ldr	w1,	[sp, #652]

    mov	w16,	w26
    neg	w19,	w1
    lsl	w0,	w19,	#6
    sub	w14,	w0,	w19,	lsl #1
    str	w14,	[sp, #532]

    ldr	w0,	[sp, #668]

    lsl	w1,	w0,	#6
    str	w15,	[sp, #1200]

    ldr	w22,	[sp, #1396]

    str	w22,	[sp, #880]

    ldr	w0,	[sp, #492]

    neg	w3,	w0
    lsl	w23,	w3,	#1
    add	w3,	w23,	w3,	lsl #3
    str	w3,	[sp, #1160]

    ldr	w3,	[sp, #624]

    neg	w3,	w3
    lsl	w0,	w3,	#4
    movz	w3,	#65486
    str	w0,	[sp, #1316]

    movk	w3,	#65535,	lsl #16
    mov	w27,	w3
    str	w27,	[sp, #1368]

    ldr	w17,	[sp, #676]

    movz	w27,	#65482
    sub	w6,	w16,	w17
    ldr	w7,	[sp, #1348]

    movk	w27,	#65535,	lsl #16
    mov	w16,	w20
    str	w7,	[sp, #1296]

    mov	w3,	w27
    str	w3,	[sp, #1284]

    str	w16,	[sp, #1256]

    ldr	w16,	[sp, #636]

    neg	w4,	w16
    lsl	w25,	w4,	#3
    add	w23,	w25,	w4,	lsl #6
    str	w23,	[sp, #1096]

    ldr	w0,	[sp, #608]

    ldr	w10,	[sp, #672]

    add	w15,	w10,	w0
    add	w10,	w15,	w6
    ldr	w15,	[sp, #616]

    ldr	w6,	[sp, #684]

    lsl	w4,	w10,	#7
    add	w23,	w6,	w15
    sub	w20,	w4,	w10,	lsl #4
    ldr	w10,	[sp, #644]

    movz	w4,	#114
    ldr	w15,	[sp, #1384]

    madd	w9,	w10,	w13,	w9

    ldr	w0,	[sp, #656]

    add	w11,	w9,	w15
    ldr	w27,	[sp, #648]

    ldr	w16,	[sp, #548]

    madd	w10,	w0,	w2,	w11

    ldr	w5,	[sp, #1416]

    madd	w21,	w27,	w8,	w10

    madd	w21,	w16,	w5,	w21

    ldr	w16,	[sp, #532]

    add	w22,	w21,	w16
    ldr	w16,	[sp, #360]

    ldr	w5,	[sp, #1200]

    add	w1,	w22,	w1
    ldr	w0,	[sp, #620]

    ldr	w12,	[sp, #880]

    ldr	w22,	[sp, #1160]

    madd	w2,	w16,	w5,	w1

    ldr	w24,	[sp, #1316]

    madd	w2,	w0,	w12,	w2

    madd	w13,	w23,	w4,	w2

    add	w16,	w13,	w22
    ldr	w22,	[sp, #632]

    ldr	w26,	[sp, #1368]

    add	w17,	w16,	w24
    ldr	w18,	[sp, #680]

    ldr	w5,	[sp, #1296]

    ldr	w25,	[sp, #612]

    madd	w23,	w22,	w26,	w17

    ldr	w0,	[sp, #1284]

    add	w24,	w23,	w20
    madd	w22,	w18,	w5,	w24

    ldr	w18,	[sp, #664]

    madd	w25,	w25,	w0,	w22

    ldr	w9,	[sp, #1256]

    madd	w24,	w18,	w9,	w25

    ldr	w15,	[sp, #1096]

    add	w19,	w24,	w15
    cmp	w19,	#0
    movz	w24,	#0
    mov	w21,	w24
    csel	w1,	w21,	w19,	lt
    cmp	w19,	#127
    movz	w17,	#127
    movz	fp,	#1372
    ldr	w15,	[sp, #920]

    movz	w14,	#55
    movz	w21,	#65446
    mov	w20,	w17
    movk	w21,	#65535,	lsl #16
    csel	w11,	w20,	w1,	gt
    mov	w8,	w21
    lsl	w12,	w11,	#5
    movz	w1,	#65459
    add	w16,	w15,	w12
    movk	w1,	#65535,	lsl #16
    mov	w23,	w1
    str	w16,	[sp, #1312]

    str	x23,	[sp, fp]

    ldr	w26,	[sp, #544]

    movz	fp,	#1372
    movz	w23,	#81
    ldr	x24,	[sp, fp]

    mul	w2,	w26,	w24
    str	w8,	[sp, #1352]

    ldr	w10,	[sp, #644]

    neg	w20,	w10
    lsl	w22,	w20,	#1
    add	w6,	w22,	w20,	lsl #2
    str	w6,	[sp, #712]

    ldr	w1,	[sp, #504]

    neg	w24,	w1
    lsl	w7,	w24,	#5
    mov	w1,	w23
    movz	w23,	#52
    sub	w26,	w7,	w24,	lsl #1
    mov	w18,	w23
    str	w26,	[sp, #900]

    ldr	w21,	[sp, #656]

    neg	w28,	w21
    movz	w21,	#59
    lsl	w12,	w28,	#3
    mov	w19,	w21
    str	w12,	[sp, #720]

    str	w1,	[sp, #708]

    ldr	w20,	[sp, #548]

    lsl	w0,	w20,	#1
    str	w0,	[sp, #704]

    ldr	w11,	[sp, #136]

    movz	w0,	#67
    str	w11,	[sp, #724]

    ldr	w16,	[sp, #528]

    mov	w26,	w16
    str	w19,	[sp, #884]

    mov	w16,	w14
    str	w16,	[sp, #1156]

    mov	w16,	w0
    ldr	w7,	[sp, #684]

    movz	w0,	#65457
    neg	w8,	w7
    movk	w0,	#65535,	lsl #16
    movz	w7,	#0
    lsl	w17,	w8,	#0
    mov	w4,	w0
    mov	w13,	w7
    add	w10,	w17,	w8,	lsl #5
    str	w10,	[sp, #1252]

    movz	w10,	#86
    ldr	w12,	[sp, #672]

    mov	w21,	w10
    lsl	w1,	w12,	#4
    ldr	w27,	[sp, #672]

    sub	w8,	w1,	w27,	lsl #1
    str	w16,	[sp, #864]

    movz	w27,	#58
    str	w21,	[sp, #868]

    mov	w22,	w27
    str	w4,	[sp, #1192]

    ldr	w21,	[sp, #680]

    lsl	w1,	w21,	#4
    ldr	w11,	[sp, #680]

    add	w15,	w1,	w11,	lsl #5
    str	w15,	[sp, #700]

    ldr	w3,	[sp, #1416]

    str	w3,	[sp, #896]

    ldr	w11,	[sp, #664]

    sub	w25,	w13,	w11
    ldr	w7,	[sp, #628]

    ldr	w12,	[sp, #636]

    add	w20,	w12,	w7
    lsl	w9,	w20,	#1
    add	w13,	w9,	w20,	lsl #6
    str	w13,	[sp, #1328]

    ldr	w1,	[sp, #620]

    ldr	w10,	[sp, #660]

    add	w17,	w1,	w10
    add	w16,	w17,	w25
    lsl	w9,	w16,	#4
    sub	w6,	w9,	w16,	lsl #0
    str	w6,	[sp, #1280]

    ldr	w1,	[sp, #640]

    ldr	w6,	[sp, #1352]

    ldr	w4,	[sp, #712]

    madd	w27,	w1,	w6,	w2

    ldr	w14,	[sp, #900]

    add	w7,	w27,	w4
    ldr	w0,	[sp, #720]

    ldr	w16,	[sp, #648]

    add	w7,	w7,	w14
    ldr	w14,	[sp, #708]

    ldr	w19,	[sp, #704]

    add	w2,	w7,	w0
    madd	w2,	w16,	w14,	w2

    add	w10,	w2,	w19
    ldr	w16,	[sp, #652]

    ldr	w1,	[sp, #724]

    madd	w1,	w16,	w1,	w10

    ldr	w16,	[sp, #668]

    madd	w2,	w16,	w26,	w1

    ldr	w28,	[sp, #616]

    ldr	w6,	[sp, #884]

    madd	w7,	w28,	w6,	w2

    ldr	w15,	[sp, #360]

    madd	w11,	w15,	w18,	w7

    ldr	w12,	[sp, #608]

    ldr	w1,	[sp, #1156]

    madd	w15,	w12,	w1,	w11

    ldr	w4,	[sp, #1252]

    add	w21,	w15,	w4
    ldr	w0,	[sp, #492]

    ldr	w1,	[sp, #624]

    ldr	w15,	[sp, #864]

    add	w25,	w21,	w8
    madd	w19,	w0,	w22,	w25

    madd	w18,	w1,	w15,	w19

    ldr	w0,	[sp, #632]

    ldr	w20,	[sp, #868]

    ldr	w1,	[sp, #676]

    madd	w20,	w0,	w20,	w18

    ldr	w5,	[sp, #1192]

    ldr	w0,	[sp, #700]

    madd	w21,	w1,	w5,	w20

    add	w24,	w21,	w0
    ldr	w21,	[sp, #612]

    ldr	w26,	[sp, #896]

    madd	w24,	w21,	w26,	w24

    ldr	w23,	[sp, #1280]

    add	w27,	w24,	w23
    ldr	w0,	[sp, #1328]

    add	w13,	w27,	w0
    cmp	w13,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w19,	w25,	w13,	lt
    cmp	w13,	#127
    movz	w14,	#65417
    movz	w18,	#127
    movz	w27,	#67
    movz	w11,	#104
    movz	w17,	#71
    movz	w26,	#65452
    movk	w14,	#65535,	lsl #16
    mov	w24,	w18
    mov	w4,	w11
    movk	w26,	#65535,	lsl #16
    ldr	w18,	[sp, #528]

    csel	w13,	w24,	w19,	gt
    mov	w23,	w18
    ldr	w18,	[sp, #1312]

    madd	w18,	w13,	w23,	w18

    str	w18,	[sp, #564]

    ldr	w16,	[sp, #660]

    ldr	w1,	[sp, #660]

    lsl	w23,	w16,	#0
    add	w2,	w23,	w1,	lsl #5
    mov	w1,	w27
    str	w2,	[sp, #1248]

    ldr	w23,	[sp, #640]

    ldr	w15,	[sp, #640]

    lsl	w19,	w23,	#5
    movz	w23,	#46
    sub	w19,	w19,	w15,	lsl #1
    str	w19,	[sp, #936]

    ldr	w9,	[sp, #644]

    neg	w19,	w9
    lsl	w2,	w19,	#1
    str	w2,	[sp, #1176]

    ldr	w19,	[sp, #656]

    ldr	w13,	[sp, #656]

    lsl	w21,	w19,	#7
    sub	w13,	w21,	w13,	lsl #3
    movz	w21,	#97
    str	w13,	[sp, #928]

    ldr	w9,	[sp, #1416]

    str	w9,	[sp, #1148]

    movz	w9,	#82
    ldr	w19,	[sp, #548]

    ldr	w7,	[sp, #548]

    lsl	w0,	w19,	#1
    ldr	w2,	[sp, #652]

    add	w8,	w0,	w7,	lsl #4
    ldr	w20,	[sp, #652]

    lsl	w13,	w2,	#0
    mov	w7,	w14
    add	w19,	w13,	w20,	lsl #2
    mov	w20,	w17
    str	w19,	[sp, #3228]

    ldr	w11,	[sp, #360]

    neg	w2,	w11
    lsl	w18,	w2,	#3
    sub	w0,	w18,	w2,	lsl #0
    mov	w2,	w23
    mov	w23,	w9
    str	w0,	[sp, #372]

    str	w20,	[sp, #924]

    movz	w20,	#107
    mov	w0,	w20
    str	w0,	[sp, #744]

    ldr	w0,	[sp, #684]

    ldr	w13,	[sp, #684]

    lsl	w22,	w0,	#3
    add	w0,	w22,	w13,	lsl #4
    movz	w22,	#83
    mov	w10,	w22
    str	w0,	[sp, #1112]

    mov	w0,	w26
    ldr	w17,	[sp, #492]

    neg	w18,	w17
    lsl	w25,	w18,	#5
    add	w14,	w25,	w18,	lsl #6
    str	w14,	[sp, #736]

    ldr	w16,	[sp, #1388]

    str	w16,	[sp, #1092]

    ldr	w14,	[sp, #516]

    mov	w28,	w14
    mov	w14,	w21
    str	w14,	[sp, #860]

    str	w10,	[sp, #1196]

    str	w2,	[sp, #740]

    str	w0,	[sp, #904]

    ldr	w22,	[sp, #504]

    ldr	w18,	[sp, #676]

    add	w26,	w18,	w22
    lsl	w5,	w26,	#0
    add	w10,	w5,	w26,	lsl #6
    str	w10,	[sp, #852]

    ldr	w14,	[sp, #544]

    ldr	w0,	[sp, #672]

    str	w23,	[sp, #932]

    add	w12,	w0,	w14
    ldr	w11,	[sp, #628]

    ldr	w15,	[sp, #1248]

    ldr	w18,	[sp, #936]

    madd	w26,	w11,	w1,	w15

    ldr	w24,	[sp, #1176]

    add	w27,	w26,	w18
    ldr	w10,	[sp, #928]

    ldr	w13,	[sp, #648]

    add	w5,	w27,	w24
    add	w0,	w5,	w10
    ldr	w5,	[sp, #1148]

    ldr	w20,	[sp, #3228]

    madd	w6,	w13,	w5,	w0

    ldr	w15,	[sp, #668]

    add	w1,	w6,	w8
    ldr	w25,	[sp, #616]

    ldr	w9,	[sp, #372]

    add	w0,	w1,	w20
    madd	w0,	w15,	w4,	w0

    madd	w1,	w25,	w7,	w0

    add	w6,	w1,	w9
    ldr	w1,	[sp, #620]

    ldr	w10,	[sp, #924]

    madd	w15,	w1,	w10,	w6

    ldr	w6,	[sp, #608]

    ldr	w22,	[sp, #744]

    ldr	w2,	[sp, #1112]

    madd	w11,	w6,	w22,	w15

    add	w19,	w11,	w2
    ldr	w22,	[sp, #932]

    ldr	w16,	[sp, #736]

    ldr	w0,	[sp, #624]

    madd	w1,	w12,	w22,	w19

    ldr	w13,	[sp, #1092]

    add	w1,	w1,	w16
    ldr	w20,	[sp, #632]

    ldr	w7,	[sp, #852]

    ldr	w18,	[sp, #680]

    madd	w11,	w0,	w13,	w1

    ldr	w10,	[sp, #860]

    madd	w20,	w20,	w28,	w11

    ldr	w22,	[sp, #612]

    add	w23,	w20,	w7
    ldr	w6,	[sp, #1196]

    ldr	w17,	[sp, #664]

    ldr	w28,	[sp, #740]

    madd	w24,	w18,	w10,	w23

    ldr	w11,	[sp, #636]

    madd	w25,	w22,	w6,	w24

    ldr	w1,	[sp, #904]

    madd	w27,	w17,	w28,	w25

    madd	w13,	w11,	w1,	w27

    cmp	w13,	#0
    movz	w23,	#0
    mov	w27,	w23
    csel	w24,	w27,	w13,	lt
    cmp	w13,	#127
    ldr	w23,	[sp, #1368]

    movz	w16,	#127
    movz	fp,	#1372
    ldr	w25,	[sp, #564]

    mov	w17,	w23
    mov	w26,	w16
    csel	w13,	w26,	w24,	gt
    movz	w24,	#65507
    madd	w27,	w13,	w17,	w25

    movk	w24,	#65535,	lsl #16
    movz	w17,	#38
    str	w27,	[sp, #576]

    mov	w15,	w24
    ldr	w25,	[sp, #544]

    movz	w24,	#65449
    ldr	w3,	[sp, #544]

    lsl	w20,	w25,	#3
    movk	w24,	#65535,	lsl #16
    ldr	w2,	[sp, #660]

    movz	w25,	#53
    sub	w18,	w20,	w3,	lsl #0
    mov	w5,	w24
    ldr	w9,	[sp, #1352]

    movz	w24,	#71
    ldr	w1,	[sp, #656]

    madd	w4,	w2,	w15,	w18

    mov	w3,	w9
    mov	w28,	w24
    ldr	w23,	[sp, #548]

    neg	w0,	w1
    ldr	w26,	[sp, #548]

    lsl	w13,	w23,	#2
    lsl	w12,	w0,	#5
    add	w16,	w13,	w26,	lsl #5
    movz	w13,	#65490
    movk	w13,	#65535,	lsl #16
    str	w16,	[sp, #3224]

    mov	w9,	w13
    movz	w16,	#65463
    ldr	w8,	[sp, #160]

    movk	w16,	#65535,	lsl #16
    str	w9,	[sp, #1300]

    mov	w11,	w8
    mov	w6,	w16
    ldr	w0,	[sp, #684]

    neg	w0,	w0
    lsl	w21,	w0,	#1
    add	w2,	w21,	w0,	lsl #5
    mov	w21,	w25
    str	w2,	[sp, #1152]

    str	w5,	[sp, #1288]

    ldr	w0,	[sp, #128]

    str	w0,	[sp, #1120]

    str	w28,	[sp, #1104]

    movz	w28,	#37
    ldr	x5,	[sp, fp]

    str	w5,	[sp, #908]

    str	w21,	[sp, #1268]

    ldr	w19,	[sp, #536]

    ldr	w2,	[sp, #1416]

    mov	w16,	w19
    str	w2,	[sp, #916]

    ldr	w1,	[sp, #540]

    str	w1,	[sp, #912]

    ldr	w22,	[sp, #620]

    ldr	w0,	[sp, #648]

    ldr	w27,	[sp, #680]

    add	w21,	w22,	w0
    mov	w0,	w28
    add	w22,	w21,	w27
    str	w22,	[sp, #1320]

    str	w0,	[sp, #1164]

    ldr	w14,	[sp, #360]

    ldr	w27,	[sp, #628]

    ldr	w22,	[sp, #456]

    add	w0,	w14,	w27
    ldr	w1,	[sp, #640]

    ldr	w27,	[sp, #644]

    madd	w17,	w1,	w17,	w4

    ldr	w9,	[sp, #1384]

    madd	w3,	w27,	w3,	w17

    ldr	w17,	[sp, #3224]

    add	w3,	w3,	w9
    ldr	w14,	[sp, #532]

    add	w4,	w3,	w12
    add	w15,	w4,	w17
    add	w17,	w15,	w14
    ldr	w14,	[sp, #668]

    ldr	w5,	[sp, #616]

    madd	w4,	w14,	w11,	w17

    ldr	w7,	[sp, #1300]

    madd	w5,	w5,	w7,	w4

    ldr	w4,	[sp, #608]

    madd	w0,	w0,	w22,	w5

    ldr	w14,	[sp, #1152]

    madd	w3,	w4,	w6,	w0

    ldr	w26,	[sp, #672]

    add	w0,	w3,	w14
    ldr	w3,	[sp, #1288]

    ldr	w27,	[sp, #492]

    madd	w11,	w26,	w3,	w0

    ldr	w1,	[sp, #1120]

    ldr	w0,	[sp, #624]

    madd	w12,	w27,	w1,	w11

    ldr	w24,	[sp, #1104]

    ldr	w1,	[sp, #632]

    madd	w3,	w0,	w24,	w12

    ldr	w5,	[sp, #908]

    madd	w19,	w1,	w5,	w3

    ldr	w1,	[sp, #676]

    ldr	w13,	[sp, #1268]

    madd	w19,	w1,	w13,	w19

    ldr	w1,	[sp, #1320]

    ldr	w26,	[sp, #1164]

    ldr	w24,	[sp, #612]

    madd	w21,	w1,	w26,	w19

    ldr	w1,	[sp, #664]

    madd	w24,	w24,	w16,	w21

    ldr	w6,	[sp, #916]

    ldr	w26,	[sp, #636]

    madd	w22,	w1,	w6,	w24

    ldr	w1,	[sp, #912]

    madd	w13,	w26,	w1,	w22

    cmp	w13,	#0
    movz	w16,	#0
    mov	w8,	w16
    csel	w23,	w8,	w13,	lt
    cmp	w13,	#127
    movz	w14,	#22
    movz	w10,	#127
    movz	w15,	#41
    movz	fp,	#1372
    movz	w19,	#42
    movz	w21,	#109
    mov	w25,	w10
    mov	w0,	w15
    mov	w22,	w19
    csel	w8,	w25,	w23,	gt
    movz	w15,	#65485
    movz	w19,	#65444
    ldr	w23,	[sp, #156]

    movk	w15,	#65535,	lsl #16
    movk	w19,	#65535,	lsl #16
    ldr	w11,	[sp, #576]

    mov	w24,	w23
    mov	w1,	w15
    mov	w27,	w19
    madd	w24,	w8,	w24,	w11

    movz	w8,	#65414
    str	w24,	[sp, #1020]

    movk	w8,	#65535,	lsl #16
    movz	w24,	#75
    ldr	w4,	[sp, #544]

    mov	w12,	w8
    ldr	w20,	[sp, #132]

    mul	w17,	w4,	w22
    mov	w8,	w14
    mov	w6,	w20
    mov	w22,	w21
    ldr	w4,	[sp, #504]

    mov	w20,	w24
    ldr	w2,	[sp, #504]

    lsl	w23,	w4,	#1
    movz	w24,	#47
    add	w13,	w23,	w2,	lsl #3
    mov	w23,	w24
    movz	w24,	#38
    str	w13,	[sp, #3876]

    ldr	x3,	[sp, fp]

    ldr	w9,	[sp, #548]

    mov	w4,	w3
    ldr	w10,	[sp, #548]

    lsl	w5,	w9,	#5
    movz	w9,	#29
    add	w10,	w5,	w10,	lsl #6
    mov	w13,	w9
    str	w10,	[sp, #3872]

    ldr	w18,	[sp, #1404]

    str	w12,	[sp, #1228]

    mov	w10,	w18
    mov	w12,	w24
    str	w23,	[sp, #568]

    movz	w24,	#115
    movz	w23,	#85
    str	w8,	[sp, #1212]

    mov	w18,	w24
    ldr	w16,	[sp, #492]

    neg	w26,	w16
    lsl	w3,	w26,	#2
    add	w11,	w3,	w26,	lsl #6
    str	w11,	[sp, #1144]

    str	w12,	[sp, #1108]

    str	w13,	[sp, #596]

    str	w18,	[sp, #588]

    ldr	w11,	[sp, #516]

    str	w11,	[sp, #1168]

    ldr	w5,	[sp, #612]

    ldr	w28,	[sp, #612]

    lsl	w8,	w5,	#2
    add	w5,	w8,	w28,	lsl #5
    movz	w8,	#65487
    movk	w8,	#65535,	lsl #16
    str	w5,	[sp, #1292]

    mov	w12,	w8
    mov	w5,	w23
    str	w12,	[sp, #560]

    movz	w23,	#67
    str	w5,	[sp, #580]

    mov	w18,	w23
    ldr	w15,	[sp, #608]

    ldr	w2,	[sp, #660]

    ldr	w11,	[sp, #628]

    add	w5,	w15,	w2
    madd	w16,	w11,	w0,	w17

    ldr	w0,	[sp, #640]

    ldr	w2,	[sp, #644]

    madd	w28,	w0,	w6,	w16

    ldr	w14,	[sp, #3876]

    madd	w23,	w2,	w27,	w28

    ldr	w0,	[sp, #656]

    add	w2,	w23,	w14
    ldr	w7,	[sp, #648]

    ldr	w11,	[sp, #3872]

    madd	w14,	w0,	w4,	w2

    ldr	w28,	[sp, #652]

    madd	w3,	w7,	w20,	w14

    ldr	w15,	[sp, #668]

    add	w17,	w3,	w11
    madd	w6,	w28,	w1,	w17

    madd	w1,	w15,	w22,	w6

    ldr	w6,	[sp, #616]

    ldr	w7,	[sp, #372]

    madd	w0,	w6,	w10,	w1

    ldr	w11,	[sp, #620]

    add	w0,	w0,	w7
    ldr	w1,	[sp, #1228]

    madd	w3,	w11,	w1,	w0

    madd	w15,	w5,	w18,	w3

    ldr	w18,	[sp, #684]

    ldr	w26,	[sp, #568]

    ldr	w6,	[sp, #672]

    madd	w4,	w18,	w26,	w15

    ldr	w15,	[sp, #1212]

    madd	w22,	w6,	w15,	w4

    ldr	w6,	[sp, #1144]

    ldr	w23,	[sp, #624]

    add	w5,	w22,	w6
    ldr	w20,	[sp, #1108]

    ldr	w19,	[sp, #632]

    madd	w0,	w23,	w20,	w5

    ldr	w16,	[sp, #596]

    ldr	w18,	[sp, #676]

    madd	w3,	w19,	w16,	w0

    ldr	w10,	[sp, #588]

    ldr	w2,	[sp, #680]

    madd	w4,	w18,	w10,	w3

    ldr	w27,	[sp, #1168]

    ldr	w1,	[sp, #1292]

    madd	w21,	w2,	w27,	w4

    ldr	w0,	[sp, #664]

    add	w3,	w21,	w1
    ldr	w19,	[sp, #560]

    madd	w22,	w0,	w19,	w3

    ldr	w0,	[sp, #636]

    ldr	w5,	[sp, #580]

    madd	w0,	w0,	w5,	w22

    cmp	w0,	#0
    movz	w5,	#0
    csel	w5,	w5,	w0,	lt
    cmp	w0,	#127
    ldr	w24,	[sp, #1020]

    movz	w3,	#46
    movz	w4,	#127
    csel	w27,	w4,	w5,	gt
    madd	w24,	w27,	w3,	w24

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
    ldr	w26,	[sp, #604]

    sub	w27,	w26,	#1
    cmp	w27,	#0
    ble	main_617

main_36:
    str	w27,	[sp, #604]

    b	main_37

main_39:
    mov	w24,	w17
    b	main_40

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#4448
    add	sp, sp, fp
    ret


