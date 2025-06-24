.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2224
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x13,	sp,	#16
    movz	fp,	#260
    mov	w5,	w0
    mov	x20,	x13
    add	x9,	x20,	#16
    add	x6,	x20,	#12
    add	x18,	x13,	#80
    add	x2,	x13,	#60
    add	x21,	x20,	#8
    add	x1,	x20,	#4
    mov	x26,	x20
    mov	x3,	x2
    add	x27,	x18,	#12
    add	x24,	x18,	#8
    add	x15,	x2,	#16
    str	x26,	[sp, fp]

    movz	fp,	#212
    str	x1,	[sp, #344]

    str	x21,	[sp, #424]

    add	x21,	x18,	#4
    str	x6,	[sp, #352]

    add	x6,	x13,	#20
    str	x9,	[sp, fp]

    mov	x12,	x6
    add	x9,	x2,	#8
    movz	fp,	#276
    add	x1,	x6,	#16
    add	x26,	x6,	#12
    add	x23,	x6,	#8
    add	x20,	x6,	#4
    str	x12,	[sp, fp]

    add	x6,	x13,	#40
    add	x12,	x2,	#12
    movz	fp,	#268
    mov	x4,	x6
    add	x28,	x6,	#16
    add	x25,	x6,	#12
    add	x22,	x6,	#8
    add	x7,	x6,	#4
    str	x20,	[sp, fp]

    add	x6,	x2,	#4
    movz	fp,	#228
    str	x23,	[sp, #400]

    add	x2,	x18,	#16
    str	x26,	[sp, #408]

    str	x1,	[sp, #432]

    str	x4,	[sp, #440]

    str	x7,	[sp, #448]

    str	x22,	[sp, #416]

    str	x25,	[sp, #464]

    str	x28,	[sp, #472]

    str	x3,	[sp, #384]

    str	x6,	[sp, #392]

    str	x9,	[sp, fp]

    movz	fp,	#236
    str	x12,	[sp, fp]

    movz	fp,	#244
    str	x15,	[sp, fp]

    movz	fp,	#252
    str	x18,	[sp, fp]

    movz	fp,	#196
    str	x21,	[sp, #360]

    str	x24,	[sp, #368]

    str	x27,	[sp, #376]

    str	x2,	[sp, fp]

    str	w5,	[sp, #648]


main_37:
    movz	w27,	#0
    mov	w19,	w27

main_40:
    lsl	w9,	w19,	#2
    movz	w3,	#0
    mov	w28,	w3
    add	w13,	w9,	w19,	lsl #4
    mov	x22,	x13
    add	x22,	sp,	x22
    add	x22,	x22,	#16

main_43:
    cmp	w28,	#5
    bge	main_50

main_46:
    lsl	w24,	w28,	#2
    add	x21,	x22,	x24
    bl	getint
    add	w13,	w28,	#1
    str	w0,	[x21]

    mov	w28,	w13
    b	main_43

main_50:
    add	w19,	w19,	#1
    cmp	w19,	#5
    blt	main_40

main_53:
    movz	fp,	#260
    movz	w24,	#85
    movz	w25,	#23
    movz	w28,	#65454
    movz	w16,	#65413
    ldr	x18,	[sp, fp]

    mov	w22,	w24
    movk	w28,	#65535,	lsl #16
    movk	w16,	#65535,	lsl #16
    ldr	w11,	[x18]

    movz	fp,	#212
    mov	w24,	w25
    mov	w9,	w28
    mov	w19,	w16
    str	w11,	[sp, #712]

    ldr	w0,	[sp, #712]

    mul	w0,	w0,	w22
    ldr	x21,	[sp, #344]

    movz	w22,	#65477
    ldr	w17,	[x21]

    movk	w22,	#65535,	lsl #16
    str	w17,	[sp, #224]

    ldr	w18,	[sp, #224]

    madd	w25,	w18,	w24,	w0

    ldr	x12,	[sp, #424]

    movz	w24,	#65425
    ldr	w26,	[x12]

    movk	w24,	#65535,	lsl #16
    str	w26,	[sp, #676]

    ldr	w27,	[sp, #676]

    madd	w4,	w27,	w9,	w25

    str	w4,	[sp, #1276]

    ldr	x25,	[sp, #352]

    ldr	w4,	[x25]

    str	w4,	[sp, #688]

    movz	w25,	#65433
    movk	w25,	#65535,	lsl #16
    mov	w7,	w25
    str	w7,	[sp, #332]

    ldr	x28,	[sp, fp]

    ldr	w17,	[x28]

    movz	fp,	#276
    str	w17,	[sp, #692]

    str	w19,	[sp, #176]

    ldr	x2,	[sp, fp]

    movz	fp,	#268
    ldr	w20,	[x2]

    str	w20,	[sp, #204]

    ldr	w21,	[sp, #204]

    lsl	w26,	w21,	#6
    movz	w21,	#50
    str	w26,	[sp, #1268]

    ldr	x10,	[sp, fp]

    movz	w26,	#65430
    ldr	w27,	[x10]

    movz	fp,	#228
    movk	w26,	#65535,	lsl #16
    str	w27,	[sp, #708]

    mov	w10,	w21
    ldr	w28,	[sp, #708]

    mov	w21,	w26
    neg	w4,	w28
    lsl	w25,	w4,	#7
    movz	w28,	#65434
    movk	w28,	#65535,	lsl #16
    sub	w23,	w25,	w4,	lsl #3
    str	w23,	[sp, #1264]

    ldr	x13,	[sp, #400]

    ldr	w1,	[x13]

    mov	w13,	w24
    str	w1,	[sp, #696]

    str	w10,	[sp, #672]

    ldr	x16,	[sp, #408]

    ldr	w3,	[x16]

    str	w3,	[sp, #644]

    mov	w16,	w22
    str	w16,	[sp, #1256]

    ldr	x19,	[sp, #432]

    ldr	w14,	[x19]

    str	w14,	[sp, #704]

    ldr	x22,	[sp, #440]

    ldr	w8,	[x22]

    str	w8,	[sp, #720]

    str	w13,	[sp, #144]

    ldr	x25,	[sp, #448]

    ldr	w19,	[x25]

    str	w19,	[sp, #660]

    movz	w25,	#65469
    movk	w25,	#65535,	lsl #16
    mov	w10,	w25
    str	w10,	[sp, #1324]

    ldr	x11,	[sp, #416]

    ldr	w27,	[x11]

    str	w27,	[sp, #456]

    str	w21,	[sp, #120]

    movz	w27,	#65461
    ldr	x14,	[sp, #464]

    movk	w27,	#65535,	lsl #16
    ldr	w2,	[x14]

    str	w2,	[sp, #664]

    mov	w14,	w27
    str	w14,	[sp, #172]

    mov	w14,	w28
    ldr	x17,	[sp, #472]

    ldr	w22,	[x17]

    str	w22,	[sp, #652]

    str	w14,	[sp, #1328]

    ldr	x20,	[sp, #384]

    ldr	w6,	[x20]

    str	w6,	[sp, #740]

    movz	w20,	#65497
    ldr	w7,	[sp, #740]

    movk	w20,	#65535,	lsl #16
    lsl	w0,	w7,	#1
    ldr	w8,	[sp, #740]

    mov	w16,	w20
    add	w18,	w0,	w8,	lsl #5
    str	w18,	[sp, #1244]

    ldr	x23,	[sp, #392]

    ldr	w22,	[x23]

    str	w22,	[sp, #724]

    str	w16,	[sp, #1292]

    ldr	x26,	[sp, fp]

    ldr	w4,	[x26]

    movz	fp,	#236
    str	w4,	[sp, #220]

    ldr	w5,	[sp, #220]

    lsl	w22,	w5,	#0
    ldr	w6,	[sp, #220]

    add	w1,	w22,	w6,	lsl #6
    str	w1,	[sp, #732]

    ldr	x0,	[sp, fp]

    ldr	w14,	[x0]

    movz	fp,	#244
    str	w14,	[sp, #668]

    ldr	x3,	[sp, fp]

    movz	fp,	#252
    ldr	w9,	[x3]

    str	w9,	[sp, #680]

    movz	w9,	#113
    mov	w12,	w9
    str	w12,	[sp, #1236]

    movz	w9,	#110
    ldr	x6,	[sp, fp]

    mov	w17,	w9
    movz	fp,	#196
    ldr	w7,	[x6]

    str	w7,	[sp, #728]

    str	w17,	[sp, #1204]

    ldr	x9,	[sp, #360]

    ldr	w21,	[x9]

    str	w21,	[sp, #736]

    ldr	x12,	[sp, #368]

    ldr	w5,	[x12]

    str	w5,	[sp, #656]

    ldr	w6,	[sp, #656]

    neg	w9,	w6
    lsl	w19,	w9,	#2
    str	w19,	[sp, #784]

    ldr	x15,	[sp, #376]

    ldr	w24,	[x15]

    str	w24,	[sp, #716]

    ldr	w25,	[sp, #716]

    lsl	w21,	w25,	#4
    ldr	w13,	[sp, #716]

    movz	w25,	#47
    add	w22,	w21,	w13,	lsl #6
    mov	w12,	w25
    str	w22,	[sp, #1108]

    ldr	x18,	[sp, fp]

    ldr	w21,	[x18]

    str	w21,	[sp, #684]

    movz	w21,	#46
    ldr	w27,	[sp, #668]

    mov	w4,	w21
    ldr	w22,	[sp, #704]

    add	w22,	w27,	w22
    ldr	w7,	[sp, #736]

    ldr	w27,	[sp, #332]

    ldr	w5,	[sp, #688]

    add	w20,	w22,	w7
    ldr	w25,	[sp, #1276]

    ldr	w11,	[sp, #176]

    madd	w13,	w5,	w27,	w25

    ldr	w7,	[sp, #692]

    ldr	w2,	[sp, #1268]

    madd	w18,	w7,	w11,	w13

    ldr	w0,	[sp, #1264]

    add	w18,	w18,	w2
    ldr	w6,	[sp, #696]

    ldr	w1,	[sp, #672]

    add	w21,	w18,	w0
    ldr	w11,	[sp, #644]

    ldr	w3,	[sp, #1256]

    madd	w22,	w6,	w1,	w21

    madd	w18,	w11,	w3,	w22

    ldr	w11,	[sp, #720]

    ldr	w0,	[sp, #144]

    madd	w19,	w11,	w0,	w18

    ldr	w2,	[sp, #660]

    ldr	w1,	[sp, #1324]

    madd	w22,	w2,	w1,	w19

    ldr	w6,	[sp, #120]

    ldr	w0,	[sp, #456]

    madd	w25,	w0,	w6,	w22

    ldr	w5,	[sp, #172]

    ldr	w1,	[sp, #664]

    ldr	w2,	[sp, #652]

    madd	w25,	w1,	w5,	w25

    ldr	w10,	[sp, #1328]

    madd	w26,	w2,	w10,	w25

    ldr	w21,	[sp, #1244]

    add	w14,	w26,	w21
    ldr	w0,	[sp, #724]

    ldr	w8,	[sp, #1292]

    ldr	w5,	[sp, #732]

    madd	w14,	w0,	w8,	w14

    ldr	w27,	[sp, #680]

    add	w15,	w14,	w5
    ldr	w1,	[sp, #1236]

    ldr	w13,	[sp, #728]

    ldr	w0,	[sp, #1204]

    madd	w24,	w27,	w1,	w15

    madd	w18,	w13,	w0,	w24

    madd	w15,	w20,	w12,	w18

    ldr	w24,	[sp, #784]

    add	w16,	w15,	w24
    ldr	w23,	[sp, #1108]

    ldr	w6,	[sp, #684]

    add	w23,	w16,	w23
    madd	w2,	w6,	w4,	w23

    cmp	w2,	#0
    movz	w24,	#0
    mov	w26,	w24
    csel	w21,	w26,	w2,	lt
    cmp	w2,	#127
    movz	w26,	#39
    movz	w0,	#127
    movz	w3,	#65436
    movz	w13,	#65415
    mov	w24,	w26
    mov	w25,	w0
    movk	w3,	#65535,	lsl #16
    movk	w13,	#65535,	lsl #16
    movz	w26,	#47
    csel	w16,	w25,	w21,	gt
    mul	w21,	w16,	w24
    movz	w25,	#65494
    str	w21,	[sp, #1248]

    movk	w25,	#65535,	lsl #16
    ldr	w19,	[sp, #224]

    mov	w27,	w25
    lsl	w9,	w19,	#7
    ldr	w20,	[sp, #224]

    sub	w7,	w9,	w20,	lsl #1
    movz	w9,	#65411
    movk	w9,	#65535,	lsl #16
    str	w7,	[sp, #2092]

    ldr	w11,	[sp, #676]

    neg	w0,	w11
    lsl	w14,	w0,	#1
    add	w2,	w14,	w0,	lsl #4
    movz	w14,	#67
    mov	w0,	w14
    str	w2,	[sp, #1184]

    movz	w14,	#65515
    ldr	w4,	[sp, #692]

    mov	w2,	w26
    movk	w14,	#65535,	lsl #16
    neg	w16,	w4
    mov	w26,	w13
    mov	w1,	w14
    lsl	w8,	w16,	#3
    str	w8,	[sp, #1012]

    movz	w8,	#29
    str	w2,	[sp, #1004]

    mov	w4,	w8
    ldr	w15,	[sp, #708]

    neg	w18,	w15
    lsl	w19,	w18,	#2
    movz	w15,	#65442
    movk	w15,	#65535,	lsl #16
    str	w19,	[sp, #2164]

    mov	w18,	w15
    str	w0,	[sp, #932]

    movz	w15,	#65493
    str	w26,	[sp, #284]

    movk	w15,	#65535,	lsl #16
    ldr	w10,	[sp, #720]

    mov	w7,	w15
    lsl	w24,	w10,	#3
    ldr	w11,	[sp, #720]

    sub	w13,	w24,	w11,	lsl #0
    movz	w24,	#105
    mov	w12,	w24
    str	w13,	[sp, #2100]

    str	w1,	[sp, #1312]

    movz	w13,	#65426
    ldr	w26,	[sp, #456]

    movk	w13,	#65535,	lsl #16
    neg	w10,	w26
    mov	w28,	w13
    movz	w26,	#87
    lsl	w21,	w10,	#6
    mov	w13,	w3
    mov	w19,	w26
    sub	w11,	w21,	w10,	lsl #2
    str	w11,	[sp, #624]

    str	w12,	[sp, #1148]

    mov	w11,	w9
    str	w27,	[sp, #1120]

    str	w19,	[sp, #1104]

    str	w4,	[sp, #896]

    str	w28,	[sp, #164]

    str	w13,	[sp, #1096]

    movz	w13,	#65514
    movk	w13,	#65535,	lsl #16
    mov	w4,	w13
    str	w4,	[sp, #1084]

    ldr	w10,	[sp, #172]

    mov	w3,	w10
    str	w3,	[sp, #936]

    str	w11,	[sp, #168]

    ldr	w10,	[sp, #680]

    ldr	w0,	[sp, #688]

    add	w23,	w10,	w0
    neg	w28,	w23
    lsl	w16,	w28,	#5
    sub	w22,	w16,	w28,	lsl #0
    str	w22,	[sp, #2168]

    ldr	w27,	[sp, #668]

    ldr	w2,	[sp, #712]

    add	w28,	w27,	w2
    str	w28,	[sp, #2176]

    ldr	w9,	[sp, #120]

    mov	w24,	w9
    str	w24,	[sp, #1032]

    ldr	w3,	[sp, #1184]

    ldr	w22,	[sp, #2092]

    add	w21,	w3,	w22
    ldr	w8,	[sp, #1012]

    ldr	w0,	[sp, #204]

    ldr	w13,	[sp, #1004]

    add	w3,	w21,	w8
    ldr	w20,	[sp, #2164]

    madd	w0,	w0,	w13,	w3

    add	w16,	w0,	w20
    ldr	w3,	[sp, #696]

    ldr	w23,	[sp, #932]

    ldr	w0,	[sp, #644]

    madd	w21,	w3,	w23,	w16

    ldr	w2,	[sp, #284]

    madd	w16,	w0,	w18,	w21

    ldr	w0,	[sp, #704]

    ldr	w26,	[sp, #2100]

    madd	w2,	w0,	w2,	w16

    ldr	w9,	[sp, #660]

    add	w3,	w2,	w26
    ldr	w26,	[sp, #1312]

    ldr	w8,	[sp, #624]

    madd	w3,	w9,	w26,	w3

    ldr	w24,	[sp, #664]

    add	w0,	w3,	w8
    ldr	w3,	[sp, #652]

    ldr	w21,	[sp, #1148]

    madd	w28,	w24,	w7,	w0

    ldr	w17,	[sp, #740]

    madd	w26,	w3,	w21,	w28

    ldr	w2,	[sp, #1120]

    madd	w9,	w17,	w2,	w26

    ldr	w0,	[sp, #724]

    ldr	w2,	[sp, #1104]

    madd	w10,	w0,	w2,	w9

    ldr	w1,	[sp, #220]

    ldr	w0,	[sp, #896]

    madd	w15,	w1,	w0,	w10

    ldr	w0,	[sp, #1032]

    ldr	w5,	[sp, #2176]

    ldr	w6,	[sp, #2168]

    madd	w16,	w5,	w0,	w15

    ldr	w18,	[sp, #164]

    add	w23,	w16,	w6
    ldr	w0,	[sp, #728]

    madd	w26,	w0,	w18,	w23

    ldr	w23,	[sp, #736]

    ldr	w15,	[sp, #1096]

    madd	w14,	w23,	w15,	w26

    ldr	w7,	[sp, #656]

    ldr	w6,	[sp, #1084]

    madd	w10,	w7,	w6,	w14

    ldr	w27,	[sp, #716]

    ldr	w26,	[sp, #936]

    madd	w0,	w27,	w26,	w10

    ldr	w24,	[sp, #168]

    ldr	w7,	[sp, #684]

    madd	w0,	w7,	w24,	w0

    cmp	w0,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w9,	w9,	w0,	lt
    cmp	w0,	#127
    movz	w16,	#76
    ldr	w6,	[sp, #1248]

    movz	w15,	#26
    movz	w14,	#77
    movz	w21,	#65441
    movz	w18,	#65466
    movz	w19,	#127
    mov	w22,	w15
    mov	w24,	w14
    movk	w21,	#65535,	lsl #16
    movk	w18,	#65535,	lsl #16
    mov	w25,	w19
    mov	w15,	w16
    mov	w5,	w21
    mov	w2,	w18
    csel	w13,	w25,	w9,	gt
    movz	w19,	#29
    madd	w4,	w13,	w24,	w6

    str	w4,	[sp, #864]

    ldr	w1,	[sp, #712]

    ldr	w26,	[sp, #224]

    mul	w1,	w1,	w22
    str	w2,	[sp, #124]

    madd	w1,	w26,	w15,	w1

    movz	w22,	#52
    ldr	w3,	[sp, #124]

    movz	w26,	#27
    mov	w14,	w22
    ldr	w18,	[sp, #676]

    madd	w2,	w18,	w3,	w1

    ldr	w7,	[sp, #688]

    mov	w18,	w19
    str	w5,	[sp, #148]

    madd	w0,	w7,	w18,	w2

    ldr	w6,	[sp, #148]

    ldr	w5,	[sp, #692]

    ldr	w28,	[sp, #204]

    madd	w10,	w5,	w6,	w0

    lsl	w24,	w28,	#5
    ldr	w0,	[sp, #204]

    ldr	w1,	[sp, #708]

    add	w19,	w24,	w0,	lsl #6
    ldr	w18,	[sp, #696]

    ldr	w15,	[sp, #644]

    ldr	w17,	[sp, #704]

    add	w0,	w10,	w19
    madd	w22,	w1,	w14,	w0

    neg	w0,	w18
    neg	w1,	w15
    lsl	w10,	w0,	#2
    lsl	w14,	w1,	#0
    add	w18,	w10,	w0,	lsl #6
    add	w21,	w14,	w1,	lsl #2
    lsl	w1,	w17,	#1
    mov	w14,	w26
    add	w25,	w22,	w18
    ldr	w18,	[sp, #704]

    add	w0,	w1,	w18,	lsl #5
    add	w24,	w25,	w21
    movz	w25,	#65498
    movk	w25,	#65535,	lsl #16
    add	w13,	w24,	w0
    mov	w22,	w25
    ldr	w0,	[sp, #720]

    neg	w10,	w0
    ldr	w27,	[sp, #660]

    lsl	w24,	w10,	#1
    ldr	w1,	[sp, #456]

    lsl	w1,	w1,	#1
    ldr	w2,	[sp, #456]

    add	w9,	w24,	w10,	lsl #5
    ldr	w5,	[sp, #664]

    add	w15,	w1,	w2,	lsl #2
    movz	w24,	#102
    mov	w18,	w24
    add	w0,	w13,	w9
    movz	w13,	#39
    movz	w9,	#110
    mov	w16,	w13
    madd	w18,	w27,	w18,	w0

    add	w0,	w18,	w15
    madd	w22,	w5,	w22,	w0

    ldr	w0,	[sp, #652]

    madd	w1,	w0,	w14,	w22

    ldr	w10,	[sp, #740]

    mov	w14,	w9
    ldr	w0,	[sp, #724]

    madd	w21,	w10,	w14,	w1

    ldr	w8,	[sp, #220]

    movz	w14,	#65437
    movz	w10,	#116
    movk	w14,	#65535,	lsl #16
    madd	w1,	w0,	w10,	w21

    madd	w16,	w8,	w16,	w1

    ldr	w0,	[sp, #668]

    neg	w17,	w0
    ldr	w12,	[sp, #680]

    lsl	w0,	w17,	#6
    ldr	w10,	[sp, #728]

    lsl	w1,	w10,	#0
    ldr	w11,	[sp, #728]

    sub	w15,	w0,	w17,	lsl #0
    add	w27,	w1,	w11,	lsl #6
    ldr	w0,	[sp, #736]

    lsl	w26,	w0,	#7
    add	w28,	w16,	w15
    ldr	w0,	[sp, #736]

    movz	w15,	#94
    sub	w0,	w26,	w0,	lsl #3
    mov	w16,	w15
    madd	w21,	w12,	w14,	w28

    add	w10,	w21,	w27
    ldr	w27,	[sp, #1292]

    ldr	w8,	[sp, #656]

    add	w9,	w10,	w0
    ldr	w21,	[sp, #716]

    mov	w0,	w27
    neg	w1,	w21
    lsl	w10,	w1,	#1
    madd	w13,	w8,	w0,	w9

    add	w19,	w10,	w1,	lsl #2
    ldr	w0,	[sp, #684]

    add	w17,	w13,	w19
    madd	w1,	w0,	w16,	w17

    cmp	w1,	#0
    movz	w16,	#0
    mov	w10,	w16
    csel	w26,	w10,	w1,	lt
    cmp	w1,	#127
    movz	w16,	#122
    movz	w17,	#118
    movz	w21,	#49
    ldr	w8,	[sp, #864]

    movz	w15,	#50
    movz	w19,	#127
    movz	w20,	#65419
    mov	w3,	w21
    mov	w4,	w15
    mov	w9,	w19
    movk	w20,	#65535,	lsl #16
    csel	w22,	w9,	w26,	gt
    lsl	w26,	w22,	#7
    sub	w25,	w26,	w22,	lsl #0
    add	w18,	w8,	w25
    movz	w25,	#125
    mov	w26,	w25
    str	w18,	[sp, #532]

    movz	w25,	#11
    ldr	w22,	[sp, #224]

    movz	w18,	#85
    mov	w24,	w25
    str	w4,	[sp, #700]

    neg	w23,	w22
    mov	w12,	w18
    ldr	w21,	[sp, #692]

    lsl	w9,	w23,	#6
    ldr	w22,	[sp, #692]

    lsl	w13,	w21,	#3
    sub	w28,	w9,	w23,	lsl #0
    add	w14,	w13,	w22,	lsl #6
    str	w14,	[sp, #520]

    str	w12,	[sp, #1384]

    ldr	w2,	[sp, #708]

    neg	w14,	w2
    lsl	w15,	w14,	#5
    sub	w4,	w15,	w14,	lsl #1
    movz	w14,	#110
    movz	w15,	#83
    mov	w11,	w15
    str	w4,	[sp, #500]

    ldr	w5,	[sp, #696]

    mov	w4,	w20
    lsl	w23,	w5,	#2
    ldr	w6,	[sp, #696]

    add	w7,	w23,	w6,	lsl #3
    str	w7,	[sp, #504]

    str	w26,	[sp, #1216]

    mov	w7,	w14
    ldr	w0,	[sp, #720]

    neg	w18,	w0
    lsl	w19,	w18,	#0
    add	w27,	w19,	w18,	lsl #6
    str	w27,	[sp, #852]

    mov	w27,	w16
    str	w7,	[sp, #900]

    ldr	w12,	[sp, #652]

    neg	w21,	w12
    lsl	w22,	w21,	#5
    sub	w14,	w22,	w21,	lsl #0
    str	w14,	[sp, #976]

    ldr	w12,	[sp, #176]

    movz	w14,	#65489
    mov	w8,	w12
    movk	w14,	#65535,	lsl #16
    str	w8,	[sp, #968]

    str	w11,	[sp, #972]

    mov	w8,	w17
    str	w27,	[sp, #2072]

    str	w24,	[sp, #2068]

    mov	w27,	w14
    movz	w14,	#95
    str	w27,	[sp, #1076]

    mov	w15,	w14
    ldr	w27,	[sp, #736]

    neg	w24,	w27
    lsl	w10,	w24,	#5
    str	w10,	[sp, #1092]

    str	w15,	[sp, #1020]

    str	w8,	[sp, #1192]

    ldr	w8,	[sp, #656]

    ldr	w1,	[sp, #704]

    add	w22,	w8,	w1
    str	w22,	[sp, #992]

    str	w4,	[sp, #1044]

    ldr	w1,	[sp, #456]

    ldr	w0,	[sp, #644]

    add	w25,	w1,	w0
    ldr	w23,	[sp, #680]

    movz	w0,	#125
    movz	w1,	#65513
    mov	w4,	w0
    movk	w1,	#65535,	lsl #16
    ldr	w0,	[sp, #712]

    mov	w2,	w1
    add	w14,	w23,	w0
    str	w2,	[sp, #116]

    ldr	w6,	[sp, #676]

    madd	w24,	w6,	w3,	w28

    ldr	w5,	[sp, #688]

    ldr	w10,	[sp, #700]

    madd	w22,	w5,	w10,	w24

    ldr	w12,	[sp, #520]

    ldr	w6,	[sp, #204]

    add	w1,	w22,	w12
    ldr	w17,	[sp, #1384]

    ldr	w0,	[sp, #500]

    madd	w6,	w6,	w17,	w1

    ldr	w3,	[sp, #504]

    add	w26,	w6,	w0
    add	w22,	w26,	w3
    ldr	w26,	[sp, #852]

    ldr	w2,	[sp, #660]

    add	w26,	w22,	w26
    ldr	w21,	[sp, #1324]

    ldr	w28,	[sp, #664]

    ldr	w1,	[sp, #900]

    madd	w19,	w2,	w21,	w26

    ldr	w7,	[sp, #976]

    madd	w24,	w25,	w4,	w19

    ldr	w17,	[sp, #740]

    madd	w18,	w28,	w1,	w24

    ldr	w0,	[sp, #968]

    add	w19,	w18,	w7
    madd	w22,	w17,	w0,	w19

    ldr	w0,	[sp, #724]

    ldr	w8,	[sp, #972]

    ldr	w11,	[sp, #220]

    madd	w24,	w0,	w8,	w22

    ldr	w19,	[sp, #2072]

    madd	w13,	w11,	w19,	w24

    ldr	w25,	[sp, #668]

    ldr	w11,	[sp, #2068]

    madd	w9,	w25,	w11,	w13

    ldr	w3,	[sp, #116]

    madd	w10,	w14,	w3,	w9

    ldr	w1,	[sp, #728]

    ldr	w0,	[sp, #1076]

    ldr	w8,	[sp, #1092]

    madd	w13,	w1,	w0,	w10

    ldr	w26,	[sp, #992]

    add	w14,	w13,	w8
    ldr	w12,	[sp, #1044]

    ldr	w0,	[sp, #716]

    madd	w15,	w26,	w12,	w14

    ldr	w2,	[sp, #1020]

    madd	w21,	w0,	w2,	w15

    ldr	w25,	[sp, #684]

    ldr	w18,	[sp, #1192]

    madd	w3,	w25,	w18,	w21

    cmp	w3,	#0
    movz	w21,	#0
    mov	w14,	w21
    csel	w0,	w14,	w3,	lt
    cmp	w3,	#127
    movz	w24,	#82
    movz	w28,	#127
    ldr	w27,	[sp, #120]

    movz	w26,	#101
    mov	w13,	w28
    mov	w18,	w27
    ldr	w19,	[sp, #532]

    csel	w10,	w13,	w0,	gt
    madd	w7,	w10,	w18,	w19

    str	w7,	[sp, #848]

    mov	w19,	w24
    movz	w10,	#65432
    ldr	w16,	[sp, #712]

    mov	w24,	w26
    movk	w10,	#65535,	lsl #16
    lsl	w13,	w16,	#3
    ldr	w23,	[sp, #224]

    mov	w2,	w10
    madd	w14,	w23,	w19,	w13

    str	w2,	[sp, #1308]

    movz	w19,	#79
    ldr	w2,	[sp, #676]

    ldr	w25,	[sp, #1308]

    madd	w2,	w2,	w25,	w14

    ldr	w9,	[sp, #688]

    movz	w14,	#65420
    madd	w18,	w9,	w24,	w2

    movk	w14,	#65535,	lsl #16
    mov	w27,	w14
    str	w27,	[sp, #1260]

    ldr	w28,	[sp, #692]

    ldr	w6,	[sp, #1260]

    madd	w21,	w28,	w6,	w18

    ldr	w5,	[sp, #204]

    neg	w9,	w5
    ldr	w18,	[sp, #708]

    lsl	w14,	w9,	#6
    neg	w16,	w18
    ldr	w4,	[sp, #124]

    sub	w10,	w14,	w9,	lsl #0
    ldr	w7,	[sp, #696]

    lsl	w14,	w16,	#4
    ldr	w8,	[sp, #644]

    movz	w16,	#116
    add	w24,	w21,	w10
    mov	w10,	w4
    add	w2,	w24,	w14
    ldr	w14,	[sp, #1216]

    ldr	w25,	[sp, #704]

    madd	w15,	w7,	w10,	w2

    madd	w1,	w8,	w14,	w15

    movz	w10,	#75
    ldr	w14,	[sp, #720]

    mov	w9,	w10
    lsl	w13,	w14,	#1
    ldr	w15,	[sp, #720]

    madd	w24,	w25,	w9,	w1

    movz	w14,	#65422
    ldr	w6,	[sp, #660]

    add	w0,	w13,	w15,	lsl #6
    movk	w14,	#65535,	lsl #16
    ldr	w4,	[sp, #456]

    movz	w13,	#65435
    neg	w15,	w6
    add	w18,	w24,	w0
    mov	w1,	w14
    movk	w13,	#65535,	lsl #16
    lsl	w26,	w15,	#5
    str	w1,	[sp, #180]

    mov	w24,	w13
    add	w9,	w26,	w15,	lsl #6
    ldr	w2,	[sp, #180]

    movz	w15,	#59
    mov	w21,	w15
    add	w18,	w18,	w9
    mov	w15,	w16
    madd	w5,	w4,	w24,	w18

    ldr	w24,	[sp, #664]

    movz	w18,	#65443
    madd	w26,	w24,	w2,	w5

    ldr	w8,	[sp, #652]

    movk	w18,	#65535,	lsl #16
    ldr	w2,	[sp, #740]

    madd	w10,	w8,	w21,	w26

    lsl	w0,	w2,	#2
    ldr	w4,	[sp, #740]

    ldr	w21,	[sp, #724]

    add	w27,	w0,	w4,	lsl #3
    ldr	w24,	[sp, #724]

    lsl	w0,	w21,	#0
    ldr	w7,	[sp, #148]

    movz	w21,	#49
    add	w14,	w10,	w27
    add	w0,	w0,	w24,	lsl #2
    mov	w9,	w7
    ldr	w10,	[sp, #220]

    ldr	w2,	[sp, #668]

    add	w26,	w14,	w0
    mov	w14,	w18
    ldr	w0,	[sp, #680]

    madd	w13,	w10,	w9,	w26

    madd	w25,	w2,	w15,	w13

    mov	w10,	w19
    madd	w25,	w0,	w14,	w25

    ldr	w2,	[sp, #728]

    ldr	w6,	[sp, #728]

    lsl	w0,	w2,	#4
    sub	w18,	w0,	w6,	lsl #0
    add	w1,	w25,	w18
    ldr	w25,	[sp, #736]

    ldr	w26,	[sp, #656]

    madd	w13,	w25,	w10,	w1

    lsl	w0,	w26,	#0
    ldr	w28,	[sp, #656]

    mov	w26,	w21
    add	w0,	w0,	w28,	lsl #1
    ldr	w22,	[sp, #716]

    add	w10,	w13,	w0
    madd	w18,	w22,	w26,	w10

    ldr	w10,	[sp, #684]

    neg	w1,	w10
    lsl	w10,	w1,	#7
    sub	w13,	w10,	w1,	lsl #2
    add	w10,	w18,	w13
    cmp	w10,	#0
    movz	w22,	#0
    mov	w16,	w22
    csel	w23,	w16,	w10,	lt
    cmp	w10,	#127
    movz	w4,	#114
    movz	w13,	#55
    movz	w11,	#82
    movz	w20,	#65462
    movz	w25,	#81
    movz	w10,	#127
    ldr	w16,	[sp, #848]

    movk	w20,	#65535,	lsl #16
    mov	w5,	w25
    mov	w15,	w10
    movz	w25,	#38
    csel	w26,	w15,	w23,	gt
    neg	w15,	w26
    lsl	w24,	w15,	#0
    add	w9,	w24,	w15,	lsl #1
    add	w10,	w16,	w9
    str	w10,	[sp, #1052]

    ldr	w24,	[sp, #224]

    mov	w10,	w20
    lsl	w16,	w24,	#2
    ldr	w0,	[sp, #224]

    movz	w24,	#65523
    ldr	w22,	[sp, #712]

    add	w14,	w16,	w0,	lsl #6
    movk	w24,	#65535,	lsl #16
    ldr	w26,	[sp, #1328]

    movz	w16,	#121
    mov	w27,	w24
    ldr	w3,	[sp, #676]

    madd	w15,	w22,	w5,	w14

    mov	w0,	w26
    str	w10,	[sp, #1316]

    madd	w14,	w3,	w0,	w15

    ldr	w10,	[sp, #688]

    mov	w15,	w16
    ldr	w0,	[sp, #1316]

    mov	w16,	w11
    madd	w26,	w10,	w0,	w14

    str	w26,	[sp, #2208]

    mov	w10,	w13
    ldr	w21,	[sp, #204]

    neg	w26,	w21
    lsl	w14,	w26,	#4
    sub	w20,	w14,	w26,	lsl #0
    movz	w14,	#101
    mov	w8,	w14
    str	w20,	[sp, #1296]

    str	w10,	[sp, #904]

    str	w27,	[sp, #152]

    ldr	w18,	[sp, #704]

    neg	w9,	w18
    lsl	w22,	w9,	#6
    mov	w18,	w25
    sub	w10,	w22,	w9,	lsl #1
    str	w10,	[sp, #460]

    ldr	w19,	[sp, #720]

    lsl	w21,	w19,	#6
    str	w21,	[sp, #752]

    ldr	w3,	[sp, #1312]

    mov	w20,	w3
    str	w20,	[sp, #984]

    ldr	w20,	[sp, #220]

    neg	w26,	w20
    lsl	w10,	w26,	#1
    add	w22,	w10,	w26,	lsl #3
    movz	w10,	#65486
    movk	w10,	#65535,	lsl #16
    str	w22,	[sp, #2112]

    mov	w7,	w10
    ldr	w28,	[sp, #668]

    neg	w22,	w28
    lsl	w19,	w22,	#4
    str	w19,	[sp, #2108]

    str	w7,	[sp, #1280]

    movz	w19,	#0
    ldr	w23,	[sp, #728]

    mov	w0,	w19
    ldr	w25,	[sp, #1260]

    sub	w20,	w0,	w23
    mov	w26,	w25
    str	w26,	[sp, #1176]

    movz	w26,	#65482
    movk	w26,	#65535,	lsl #16
    mov	w5,	w26
    str	w5,	[sp, #1224]

    str	w16,	[sp, #1060]

    ldr	w23,	[sp, #684]

    neg	w26,	w23
    lsl	w23,	w26,	#3
    add	w7,	w23,	w26,	lsl #6
    str	w7,	[sp, #1144]

    ldr	w26,	[sp, #652]

    ldr	w3,	[sp, #724]

    add	w21,	w3,	w26
    ldr	w2,	[sp, #660]

    mov	w3,	w4
    ldr	w9,	[sp, #740]

    add	w16,	w9,	w2
    ldr	w24,	[sp, #692]

    add	w1,	w21,	w20
    ldr	w11,	[sp, #2208]

    madd	w2,	w24,	w15,	w11

    ldr	w10,	[sp, #1296]

    add	w7,	w2,	w10
    ldr	w24,	[sp, #708]

    lsl	w13,	w1,	#7
    sub	w26,	w13,	w1,	lsl #4
    ldr	w1,	[sp, #904]

    madd	w11,	w24,	w1,	w7

    ldr	w19,	[sp, #696]

    madd	w23,	w19,	w8,	w11

    ldr	w24,	[sp, #152]

    ldr	w1,	[sp, #644]

    ldr	w2,	[sp, #460]

    madd	w23,	w1,	w24,	w23

    ldr	w12,	[sp, #752]

    add	w2,	w23,	w2
    ldr	w4,	[sp, #456]

    ldr	w13,	[sp, #664]

    add	w7,	w2,	w12
    ldr	w8,	[sp, #984]

    ldr	w5,	[sp, #2112]

    ldr	w2,	[sp, #2108]

    madd	w28,	w4,	w18,	w7

    madd	w22,	w13,	w8,	w28

    madd	w20,	w16,	w3,	w22

    add	w11,	w20,	w5
    add	w15,	w11,	w2
    ldr	w2,	[sp, #680]

    ldr	w10,	[sp, #1280]

    ldr	w23,	[sp, #736]

    madd	w16,	w2,	w10,	w15

    ldr	w6,	[sp, #1176]

    add	w16,	w16,	w26
    ldr	w28,	[sp, #656]

    ldr	w15,	[sp, #1224]

    madd	w18,	w23,	w6,	w16

    madd	w19,	w28,	w15,	w18

    ldr	w18,	[sp, #716]

    ldr	w1,	[sp, #1060]

    ldr	w8,	[sp, #1144]

    madd	w21,	w18,	w1,	w19

    add	w17,	w21,	w8
    cmp	w17,	#0
    movz	w24,	#0
    mov	w19,	w24
    csel	w0,	w19,	w17,	lt
    cmp	w17,	#127
    movz	w15,	#55
    movz	w16,	#127
    movz	fp,	#1284
    movz	w26,	#65459
    mov	w18,	w16
    movk	w26,	#65535,	lsl #16
    ldr	w16,	[sp, #1052]

    csel	w9,	w18,	w0,	gt
    mov	w11,	w26
    lsl	w10,	w9,	#5
    movz	w9,	#65446
    add	w18,	w16,	w10
    movk	w9,	#65535,	lsl #16
    str	w18,	[sp, #956]

    mov	w18,	w15
    str	x11,	[sp, fp]

    ldr	w0,	[sp, #224]

    movz	fp,	#1284
    ldr	x12,	[sp, fp]

    mul	w26,	w0,	w12
    mov	w0,	w9
    str	w26,	[sp, #928]

    str	w0,	[sp, #1272]

    ldr	w25,	[sp, #692]

    neg	w16,	w25
    lsl	w24,	w16,	#1
    add	w23,	w24,	w16,	lsl #2
    movz	w24,	#59
    mov	w13,	w24
    str	w23,	[sp, #876]

    ldr	w28,	[sp, #204]

    neg	w19,	w28
    lsl	w26,	w19,	#5
    sub	w27,	w26,	w19,	lsl #1
    str	w27,	[sp, #888]

    ldr	w5,	[sp, #708]

    neg	w10,	w5
    lsl	w17,	w10,	#3
    movz	w10,	#81
    str	w17,	[sp, #980]

    mov	w9,	w10
    ldr	w20,	[sp, #644]

    lsl	w25,	w20,	#1
    str	w25,	[sp, #2116]

    ldr	w1,	[sp, #164]

    mov	w14,	w1
    str	w14,	[sp, #912]

    ldr	w20,	[sp, #148]

    movz	w14,	#52
    mov	w0,	w20
    str	w13,	[sp, #1056]

    mov	w7,	w14
    str	w7,	[sp, #1048]

    str	w18,	[sp, #1024]

    ldr	w22,	[sp, #740]

    movz	w18,	#58
    neg	w23,	w22
    mov	w25,	w18
    movz	w22,	#67
    lsl	w13,	w23,	#0
    mov	w5,	w22
    add	w1,	w13,	w23,	lsl #5
    str	w1,	[sp, #1080]

    ldr	w4,	[sp, #724]

    ldr	w24,	[sp, #724]

    lsl	w17,	w4,	#4
    movz	w4,	#65457
    sub	w11,	w17,	w24,	lsl #1
    movk	w4,	#65535,	lsl #16
    mov	w6,	w4
    str	w11,	[sp, #1372]

    str	w25,	[sp, #764]

    movz	w25,	#86
    str	w5,	[sp, #776]

    mov	w18,	w25
    str	w18,	[sp, #636]

    str	w6,	[sp, #608]

    ldr	w22,	[sp, #736]

    movz	w6,	#0
    lsl	w10,	w22,	#4
    ldr	w20,	[sp, #736]

    mov	w19,	w6
    add	w28,	w10,	w20,	lsl #5
    str	w28,	[sp, #768]

    ldr	w27,	[sp, #152]

    mov	w2,	w27
    str	w2,	[sp, #772]

    ldr	w7,	[sp, #716]

    ldr	w14,	[sp, #676]

    sub	w10,	w19,	w7
    ldr	w24,	[sp, #684]

    add	w23,	w24,	w14
    lsl	w20,	w23,	#1
    add	w22,	w20,	w23,	lsl #6
    str	w22,	[sp, #1172]

    ldr	w14,	[sp, #664]

    ldr	w1,	[sp, #712]

    add	w11,	w14,	w1
    add	w7,	w11,	w10
    lsl	w4,	w7,	#4
    sub	w25,	w4,	w7,	lsl #0
    str	w25,	[sp, #996]

    ldr	w17,	[sp, #688]

    ldr	w27,	[sp, #928]

    ldr	w5,	[sp, #1272]

    madd	w13,	w17,	w5,	w27

    ldr	w18,	[sp, #876]

    add	w10,	w13,	w18
    ldr	w21,	[sp, #888]

    add	w12,	w10,	w21
    ldr	w10,	[sp, #980]

    ldr	w3,	[sp, #696]

    add	w20,	w12,	w10
    ldr	w8,	[sp, #2116]

    ldr	w22,	[sp, #704]

    madd	w1,	w3,	w9,	w20

    add	w6,	w1,	w8
    ldr	w8,	[sp, #912]

    ldr	w18,	[sp, #720]

    madd	w4,	w22,	w8,	w6

    ldr	w1,	[sp, #660]

    madd	w17,	w18,	w0,	w4

    ldr	w14,	[sp, #1056]

    madd	w11,	w1,	w14,	w17

    ldr	w1,	[sp, #456]

    ldr	w8,	[sp, #1048]

    ldr	w0,	[sp, #652]

    madd	w4,	w1,	w8,	w11

    ldr	w18,	[sp, #1024]

    madd	w9,	w0,	w18,	w4

    ldr	w0,	[sp, #1080]

    add	w10,	w9,	w0
    ldr	w26,	[sp, #1372]

    add	w13,	w10,	w26
    ldr	w26,	[sp, #220]

    ldr	w20,	[sp, #764]

    ldr	w4,	[sp, #668]

    madd	w14,	w26,	w20,	w13

    ldr	w1,	[sp, #776]

    madd	w15,	w4,	w1,	w14

    ldr	w0,	[sp, #680]

    ldr	w28,	[sp, #636]

    madd	w16,	w0,	w28,	w15

    ldr	w5,	[sp, #728]

    ldr	w11,	[sp, #608]

    madd	w18,	w5,	w11,	w16

    ldr	w25,	[sp, #768]

    ldr	w0,	[sp, #656]

    add	w19,	w18,	w25
    ldr	w27,	[sp, #772]

    madd	w21,	w0,	w27,	w19

    ldr	w0,	[sp, #996]

    add	w22,	w21,	w0
    ldr	w28,	[sp, #1172]

    add	w0,	w22,	w28
    cmp	w0,	#0
    movz	w24,	#0
    mov	w25,	w24
    csel	w14,	w25,	w0,	lt
    cmp	w0,	#127
    movz	w21,	#127
    ldr	w18,	[sp, #148]

    mov	w26,	w21
    ldr	w19,	[sp, #956]

    mov	w24,	w18
    csel	w10,	w26,	w14,	gt
    movz	w26,	#67
    madd	w5,	w10,	w24,	w19

    movz	w10,	#65417
    str	w5,	[sp, #1008]

    movk	w10,	#65535,	lsl #16
    ldr	w19,	[sp, #712]

    mov	w24,	w10
    ldr	w7,	[sp, #712]

    lsl	w21,	w19,	#0
    add	w1,	w21,	w7,	lsl #5
    mov	w21,	w26
    str	w1,	[sp, #1040]

    str	w21,	[sp, #2064]

    movz	w21,	#107
    ldr	w26,	[sp, #688]

    mov	w22,	w21
    ldr	w23,	[sp, #688]

    lsl	w15,	w26,	#5
    sub	w16,	w15,	w23,	lsl #1
    str	w16,	[sp, #2104]

    ldr	w3,	[sp, #692]

    neg	w16,	w3
    lsl	w5,	w16,	#1
    movz	w16,	#71
    str	w5,	[sp, #1188]

    mov	w19,	w16
    ldr	w14,	[sp, #708]

    ldr	w4,	[sp, #708]

    lsl	w25,	w14,	#7
    sub	w15,	w25,	w4,	lsl #3
    str	w15,	[sp, #632]

    ldr	w27,	[sp, #152]

    mov	w20,	w27
    str	w20,	[sp, #1208]

    ldr	w7,	[sp, #644]

    ldr	w17,	[sp, #644]

    lsl	w26,	w7,	#1
    add	w1,	w26,	w17,	lsl #4
    str	w1,	[sp, #744]

    ldr	w17,	[sp, #704]

    ldr	w3,	[sp, #704]

    lsl	w9,	w17,	#0
    add	w12,	w9,	w3,	lsl #2
    movz	w9,	#104
    mov	w6,	w9
    str	w12,	[sp, #948]

    movz	w9,	#97
    str	w6,	[sp, #1140]

    mov	w20,	w9
    str	w24,	[sp, #184]

    ldr	w3,	[sp, #456]

    neg	w17,	w3
    movz	w3,	#65452
    lsl	w14,	w17,	#3
    movk	w3,	#65535,	lsl #16
    sub	w26,	w14,	w17,	lsl #0
    mov	w23,	w3
    str	w26,	[sp, #296]

    ldr	w6,	[sp, #740]

    ldr	w24,	[sp, #740]

    lsl	w27,	w6,	#3
    add	w25,	w27,	w24,	lsl #4
    str	w25,	[sp, #2172]

    ldr	w0,	[sp, #220]

    neg	w10,	w0
    movz	w0,	#46
    lsl	w7,	w10,	#5
    mov	w17,	w0
    add	w12,	w7,	w10,	lsl #6
    movz	w10,	#83
    mov	w1,	w10
    str	w12,	[sp, #868]

    ldr	w28,	[sp, #1308]

    mov	w15,	w28
    str	w15,	[sp, #872]

    ldr	w27,	[sp, #284]

    mov	w18,	w27
    str	w18,	[sp, #748]

    str	w20,	[sp, #920]

    str	w1,	[sp, #892]

    str	w17,	[sp, #916]

    str	w23,	[sp, #924]

    ldr	w12,	[sp, #204]

    ldr	w0,	[sp, #728]

    add	w9,	w0,	w12
    lsl	w0,	w9,	#0
    add	w15,	w0,	w9,	lsl #6
    movz	w9,	#82
    str	w15,	[sp, #952]

    ldr	w17,	[sp, #224]

    ldr	w6,	[sp, #724]

    add	w6,	w6,	w17
    str	w6,	[sp, #940]

    str	w9,	[sp, #944]

    ldr	w24,	[sp, #676]

    ldr	w2,	[sp, #1040]

    ldr	w28,	[sp, #2064]

    madd	w3,	w24,	w28,	w2

    ldr	w28,	[sp, #2104]

    ldr	w7,	[sp, #1188]

    add	w0,	w3,	w28
    ldr	w12,	[sp, #632]

    ldr	w4,	[sp, #696]

    add	w0,	w0,	w7
    ldr	w25,	[sp, #1208]

    ldr	w13,	[sp, #744]

    ldr	w7,	[sp, #948]

    add	w2,	w0,	w12
    ldr	w10,	[sp, #720]

    ldr	w5,	[sp, #1140]

    ldr	w18,	[sp, #660]

    madd	w0,	w4,	w25,	w2

    ldr	w21,	[sp, #184]

    add	w2,	w0,	w13
    ldr	w23,	[sp, #296]

    add	w27,	w2,	w7
    ldr	w2,	[sp, #664]

    ldr	w16,	[sp, #652]

    madd	w24,	w10,	w5,	w27

    madd	w25,	w18,	w21,	w24

    add	w26,	w25,	w23
    madd	w9,	w2,	w19,	w26

    madd	w10,	w16,	w22,	w9

    ldr	w9,	[sp, #2172]

    ldr	w1,	[sp, #940]

    add	w13,	w10,	w9
    ldr	w10,	[sp, #944]

    ldr	w4,	[sp, #868]

    madd	w14,	w1,	w10,	w13

    ldr	w5,	[sp, #668]

    add	w15,	w14,	w4
    ldr	w7,	[sp, #872]

    ldr	w1,	[sp, #680]

    ldr	w10,	[sp, #748]

    madd	w16,	w5,	w7,	w15

    madd	w18,	w1,	w10,	w16

    ldr	w10,	[sp, #952]

    ldr	w26,	[sp, #736]

    add	w19,	w18,	w10
    ldr	w14,	[sp, #920]

    ldr	w0,	[sp, #656]

    madd	w21,	w26,	w14,	w19

    ldr	w1,	[sp, #892]

    ldr	w20,	[sp, #716]

    madd	w22,	w0,	w1,	w21

    ldr	w11,	[sp, #916]

    ldr	w13,	[sp, #684]

    madd	w24,	w20,	w11,	w22

    ldr	w22,	[sp, #924]

    madd	w9,	w13,	w22,	w24

    cmp	w9,	#0
    movz	w22,	#0
    mov	w0,	w22
    csel	w21,	w0,	w9,	lt
    cmp	w9,	#127
    movz	w16,	#71
    movz	fp,	#1284
    movz	w25,	#65507
    ldr	w18,	[sp, #1280]

    movz	w15,	#127
    movz	w3,	#53
    movk	w25,	#65535,	lsl #16
    ldr	w11,	[sp, #1008]

    mov	w24,	w15
    mov	w0,	w25
    csel	w13,	w24,	w21,	gt
    mov	w21,	w18
    madd	w24,	w13,	w21,	w11

    str	w24,	[sp, #1252]

    movz	w24,	#65449
    ldr	w2,	[sp, #224]

    movk	w24,	#65535,	lsl #16
    ldr	w11,	[sp, #224]

    lsl	w19,	w2,	#3
    mov	w28,	w24
    ldr	w10,	[sp, #712]

    sub	w18,	w19,	w11,	lsl #0
    madd	w23,	w10,	w0,	w18

    movz	w18,	#38
    str	w23,	[sp, #2204]

    mov	w20,	w18
    ldr	w2,	[sp, #1272]

    ldr	w5,	[sp, #708]

    mov	w9,	w2
    ldr	w26,	[sp, #644]

    neg	w25,	w5
    ldr	w0,	[sp, #644]

    lsl	w19,	w26,	#2
    lsl	w7,	w25,	#5
    add	w10,	w19,	w0,	lsl #5
    mov	w0,	w3
    mov	w19,	w16
    str	w10,	[sp, #2096]

    movz	w10,	#65490
    ldr	w13,	[sp, #168]

    movk	w10,	#65535,	lsl #16
    mov	w22,	w13
    mov	w11,	w10
    movz	w13,	#65463
    str	w11,	[sp, #1196]

    movk	w13,	#65535,	lsl #16
    ldr	w6,	[sp, #740]

    mov	w4,	w13
    neg	w23,	w6
    lsl	w10,	w23,	#1
    add	w21,	w10,	w23,	lsl #5
    str	w21,	[sp, #640]

    str	w28,	[sp, #1180]

    ldr	w24,	[sp, #172]

    mov	w18,	w24
    str	w18,	[sp, #2060]

    str	w19,	[sp, #1168]

    ldr	x13,	[sp, fp]

    mov	w15,	w13
    str	w15,	[sp, #2128]

    str	w0,	[sp, #1220]

    movz	w0,	#37
    ldr	w17,	[sp, #332]

    mov	w28,	w0
    mov	w21,	w17
    str	w21,	[sp, #1028]

    ldr	w11,	[sp, #152]

    mov	w24,	w11
    str	w24,	[sp, #964]

    ldr	w27,	[sp, #180]

    mov	w21,	w27
    str	w21,	[sp, #960]

    ldr	w27,	[sp, #664]

    ldr	w16,	[sp, #696]

    ldr	w6,	[sp, #736]

    add	w27,	w27,	w16
    add	w16,	w27,	w6
    str	w16,	[sp, #1100]

    str	w28,	[sp, #1000]

    ldr	w11,	[sp, #456]

    ldr	w6,	[sp, #676]

    ldr	w1,	[sp, #124]

    add	w24,	w11,	w6
    mov	w18,	w1
    ldr	w11,	[sp, #688]

    ldr	w8,	[sp, #2204]

    ldr	w0,	[sp, #692]

    madd	w6,	w11,	w20,	w8

    madd	w28,	w0,	w9,	w6

    ldr	w0,	[sp, #1296]

    ldr	w21,	[sp, #2096]

    add	w8,	w28,	w0
    ldr	w20,	[sp, #460]

    add	w0,	w8,	w7
    ldr	w8,	[sp, #720]

    ldr	w2,	[sp, #660]

    add	w3,	w0,	w21
    ldr	w13,	[sp, #1196]

    ldr	w10,	[sp, #652]

    add	w1,	w3,	w20
    madd	w7,	w8,	w22,	w1

    madd	w9,	w2,	w13,	w7

    madd	w22,	w24,	w18,	w9

    ldr	w18,	[sp, #640]

    madd	w19,	w10,	w4,	w22

    ldr	w21,	[sp, #724]

    add	w10,	w19,	w18
    ldr	w9,	[sp, #1180]

    ldr	w8,	[sp, #220]

    madd	w22,	w21,	w9,	w10

    ldr	w21,	[sp, #2060]

    ldr	w6,	[sp, #668]

    madd	w10,	w8,	w21,	w22

    ldr	w0,	[sp, #1168]

    ldr	w2,	[sp, #680]

    madd	w18,	w6,	w0,	w10

    ldr	w22,	[sp, #2128]

    madd	w14,	w2,	w22,	w18

    ldr	w18,	[sp, #728]

    ldr	w12,	[sp, #1220]

    madd	w16,	w18,	w12,	w14

    ldr	w14,	[sp, #1100]

    ldr	w5,	[sp, #1000]

    ldr	w15,	[sp, #656]

    madd	w23,	w14,	w5,	w16

    ldr	w26,	[sp, #1028]

    ldr	w5,	[sp, #716]

    madd	w0,	w15,	w26,	w23

    ldr	w24,	[sp, #964]

    ldr	w1,	[sp, #684]

    madd	w0,	w5,	w24,	w0

    ldr	w21,	[sp, #960]

    madd	w15,	w1,	w21,	w0

    cmp	w15,	#0
    movz	w18,	#0
    mov	w9,	w18
    csel	w24,	w9,	w15,	lt
    cmp	w15,	#127
    movz	w21,	#42
    ldr	w0,	[sp, #116]

    movz	w15,	#41
    movz	fp,	#1284
    movz	w13,	#127
    movz	w16,	#47
    ldr	w25,	[sp, #1252]

    mov	w26,	w13
    csel	w14,	w26,	w24,	gt
    mov	w24,	w21
    madd	w25,	w14,	w0,	w25

    str	w25,	[sp, #564]

    ldr	w10,	[sp, #224]

    mul	w2,	w10,	w24
    mov	w24,	w15
    str	w2,	[sp, #1388]

    movz	w15,	#65444
    ldr	w22,	[sp, #176]

    movk	w15,	#65535,	lsl #16
    mov	w17,	w22
    mov	w5,	w15
    movz	w22,	#22
    movz	w15,	#75
    str	w5,	[sp, #208]

    mov	w6,	w22
    mov	w21,	w15
    ldr	w1,	[sp, #204]

    ldr	w2,	[sp, #204]

    lsl	w0,	w1,	#1
    ldr	x14,	[sp, fp]

    add	w0,	w0,	w2,	lsl #3
    mov	w11,	w14
    movz	w14,	#65485
    str	w11,	[sp, #516]

    movk	w14,	#65535,	lsl #16
    ldr	w8,	[sp, #644]

    mov	w9,	w14
    ldr	w10,	[sp, #644]

    lsl	w23,	w8,	#5
    movz	w14,	#109
    mov	w12,	w14
    add	w4,	w23,	w10,	lsl #6
    movz	w14,	#65414
    movk	w14,	#65535,	lsl #16
    str	w4,	[sp, #2088]

    str	w9,	[sp, #1332]

    mov	w9,	w14
    str	w12,	[sp, #780]

    ldr	w7,	[sp, #1316]

    mov	w15,	w7
    mov	w7,	w16
    str	w15,	[sp, #328]

    str	w9,	[sp, #1232]

    str	w7,	[sp, #2052]

    str	w6,	[sp, #1408]

    ldr	w1,	[sp, #220]

    neg	w11,	w1
    str	w11,	[sp, #1016]

    ldr	w12,	[sp, #1016]

    lsl	w14,	w12,	#2
    ldr	w12,	[sp, #1016]

    add	w16,	w14,	w12,	lsl #6
    movz	w14,	#38
    mov	w27,	w14
    str	w16,	[sp, #1160]

    movz	w14,	#29
    str	w27,	[sp, #1036]

    mov	w15,	w14
    movz	w14,	#115
    str	w15,	[sp, #1240]

    movz	w15,	#65487
    str	w14,	[sp, #1200]

    movk	w15,	#65535,	lsl #16
    ldr	w8,	[sp, #284]

    mov	w23,	w15
    mov	w27,	w8
    movz	w15,	#85
    str	w27,	[sp, #808]

    mov	w6,	w15
    ldr	w11,	[sp, #656]

    ldr	w12,	[sp, #656]

    lsl	w14,	w11,	#2
    add	w1,	w14,	w12,	lsl #5
    str	w1,	[sp, #1124]

    str	w23,	[sp, #1212]

    str	w6,	[sp, #1228]

    ldr	w20,	[sp, #652]

    ldr	w5,	[sp, #712]

    add	w7,	w20,	w5
    movz	w5,	#67
    mov	w10,	w5
    str	w7,	[sp, #1088]

    ldr	w28,	[sp, #676]

    ldr	w15,	[sp, #1388]

    ldr	w12,	[sp, #688]

    madd	w1,	w28,	w24,	w15

    ldr	w5,	[sp, #692]

    madd	w8,	w12,	w17,	w1

    ldr	w20,	[sp, #208]

    madd	w1,	w5,	w20,	w8

    add	w5,	w1,	w0
    ldr	w0,	[sp, #708]

    ldr	w11,	[sp, #516]

    ldr	w13,	[sp, #696]

    madd	w1,	w0,	w11,	w5

    ldr	w15,	[sp, #2088]

    madd	w21,	w13,	w21,	w1

    ldr	w2,	[sp, #704]

    add	w24,	w21,	w15
    ldr	w12,	[sp, #1332]

    ldr	w7,	[sp, #720]

    madd	w0,	w2,	w12,	w24

    ldr	w19,	[sp, #780]

    ldr	w11,	[sp, #660]

    madd	w6,	w7,	w19,	w0

    ldr	w22,	[sp, #328]

    ldr	w18,	[sp, #296]

    madd	w0,	w11,	w22,	w6

    ldr	w24,	[sp, #664]

    add	w0,	w0,	w18
    ldr	w12,	[sp, #1232]

    ldr	w8,	[sp, #1088]

    madd	w28,	w24,	w12,	w0

    ldr	w19,	[sp, #740]

    madd	w0,	w8,	w10,	w28

    ldr	w11,	[sp, #2052]

    ldr	w5,	[sp, #724]

    madd	w23,	w19,	w11,	w0

    ldr	w9,	[sp, #1408]

    ldr	w17,	[sp, #1160]

    madd	w10,	w5,	w9,	w23

    ldr	w24,	[sp, #668]

    add	w2,	w10,	w17
    ldr	w0,	[sp, #1036]

    ldr	w19,	[sp, #680]

    madd	w13,	w24,	w0,	w2

    ldr	w18,	[sp, #1240]

    madd	w1,	w19,	w18,	w13

    ldr	w19,	[sp, #728]

    ldr	w16,	[sp, #1200]

    ldr	w4,	[sp, #736]

    madd	w1,	w19,	w16,	w1

    ldr	w2,	[sp, #808]

    madd	w19,	w4,	w2,	w1

    ldr	w2,	[sp, #1124]

    ldr	w6,	[sp, #716]

    add	w2,	w19,	w2
    ldr	w0,	[sp, #1212]

    madd	w27,	w6,	w0,	w2

    ldr	w2,	[sp, #684]

    ldr	w14,	[sp, #1228]

    madd	w10,	w2,	w14,	w27

    cmp	w10,	#0
    movz	w0,	#0
    mov	w5,	w0
    csel	w3,	w5,	w10,	lt
    cmp	w10,	#127
    ldr	w26,	[sp, #564]

    movz	w2,	#46
    movz	w9,	#127
    mov	w4,	w9
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
    ldr	w6,	[sp, #648]

    sub	w17,	w6,	#1
    cmp	w17,	#0
    ble	main_617

main_36:
    mov	w7,	w17
    str	w7,	[sp, #648]

    b	main_37

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2224
    ret


