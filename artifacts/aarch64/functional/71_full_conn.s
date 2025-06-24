.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #3520
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x18,	sp,	#16
    movz	fp,	#492
    mov	w24,	w0
    mov	x7,	x18
    add	x28,	x7,	#16
    add	x25,	x7,	#12
    add	x4,	x18,	#80
    add	x8,	x18,	#60
    add	x2,	x18,	#40
    add	x22,	x18,	#20
    add	x12,	x7,	#8
    add	x20,	x7,	#4
    mov	x19,	x7
    add	x21,	x4,	#16
    add	x15,	x4,	#8
    mov	x9,	x4
    add	x6,	x8,	#16
    add	x16,	x2,	#12
    add	x13,	x2,	#8
    add	x26,	x2,	#4
    mov	x23,	x2
    add	x18,	x4,	#12
    add	x17,	x22,	#12
    add	x14,	x22,	#8
    add	x11,	x22,	#4
    mov	x3,	x22
    str	x19,	[sp, #168]

    add	x19,	x2,	#16
    str	x20,	[sp, #128]

    add	x20,	x22,	#16
    str	x12,	[sp, #608]

    mov	x22,	x8
    add	x12,	x4,	#4
    str	x25,	[sp, fp]

    add	x25,	x8,	#4
    movz	fp,	#620
    str	x28,	[sp, fp]

    add	x28,	x8,	#8
    movz	fp,	#628
    str	x3,	[sp, fp]

    add	x3,	x8,	#12
    movz	fp,	#212
    str	x11,	[sp, fp]

    movz	fp,	#188
    str	x14,	[sp, #432]

    str	x17,	[sp, #440]

    str	x20,	[sp, fp]

    movz	fp,	#196
    str	x23,	[sp, fp]

    movz	fp,	#636
    str	x26,	[sp, fp]

    movz	fp,	#476
    str	x13,	[sp, fp]

    movz	fp,	#500
    str	x16,	[sp, #576]

    str	x19,	[sp, #584]

    str	x22,	[sp, #592]

    str	x25,	[sp, fp]

    movz	fp,	#540
    str	x28,	[sp, #512]

    str	x3,	[sp, #520]

    str	x6,	[sp, #448]

    str	x9,	[sp, #456]

    str	x12,	[sp, #464]

    str	x15,	[sp, fp]

    movz	fp,	#548
    str	x18,	[sp, fp]

    movz	fp,	#556
    str	x21,	[sp, fp]

    str	w24,	[sp, #716]


main_37:
    movz	w25,	#0
    mov	w20,	w25

main_40:
    lsl	w5,	w20,	#2
    movz	w24,	#0
    mov	w21,	w24
    add	w6,	w5,	w20,	lsl #4
    mov	x28,	x6
    add	x28,	sp,	x28
    add	x28,	x28,	#16

main_43:
    cmp	w21,	#5
    bge	main_50

main_46:
    lsl	w25,	w21,	#2
    add	x25,	x28,	x25
    bl	getint
    add	w27,	w21,	#1
    str	w0,	[x25]

    mov	w21,	w27
    b	main_43

main_50:
    add	w17,	w20,	#1
    cmp	w17,	#5
    blt	main_39

main_53:
    ldr	x12,	[sp, #168]

    movz	w0,	#85
    movz	w28,	#23
    movz	fp,	#492
    movz	w18,	#65477
    movz	w17,	#65425
    ldr	w5,	[x12]

    movk	w18,	#65535,	lsl #16
    movk	w17,	#65535,	lsl #16
    str	w5,	[sp, #796]

    mov	w3,	w18
    ldr	w24,	[sp, #796]

    mul	w1,	w24,	w0
    ldr	x15,	[sp, #128]

    mov	w0,	w28
    ldr	w11,	[x15]

    movz	w28,	#65454
    str	w11,	[sp, #528]

    movk	w28,	#65535,	lsl #16
    ldr	w12,	[sp, #528]

    ldr	x6,	[sp, #608]

    madd	w0,	w12,	w0,	w1

    ldr	w20,	[x6]

    mov	w1,	w28
    str	w20,	[sp, #748]

    movz	w28,	#65413
    ldr	w21,	[sp, #748]

    movk	w28,	#65535,	lsl #16
    madd	w20,	w21,	w1,	w0

    mov	w13,	w28
    str	w20,	[sp, #908]

    movz	w28,	#50
    ldr	x19,	[sp, fp]

    mov	w6,	w28
    ldr	w27,	[x19]

    movz	fp,	#620
    str	w27,	[sp, #772]

    movz	w27,	#65433
    movk	w27,	#65535,	lsl #16
    mov	w1,	w27
    str	w1,	[sp, #564]

    ldr	x22,	[sp, fp]

    ldr	w11,	[x22]

    movz	fp,	#628
    str	w11,	[sp, #776]

    str	w13,	[sp, #148]

    ldr	x25,	[sp, fp]

    movz	fp,	#212
    ldr	w14,	[x25]

    str	w14,	[sp, #488]

    mov	w14,	w17
    ldr	w15,	[sp, #488]

    lsl	w13,	w15,	#6
    str	w13,	[sp, #604]

    ldr	x4,	[sp, fp]

    ldr	w21,	[x4]

    movz	fp,	#188
    str	w21,	[sp, #788]

    ldr	w8,	[sp, #788]

    neg	w4,	w8
    lsl	w24,	w4,	#7
    sub	w0,	w24,	w4,	lsl #3
    str	w0,	[sp, #836]

    ldr	x7,	[sp, #432]

    movz	w0,	#65469
    ldr	w24,	[x7]

    movk	w0,	#65535,	lsl #16
    str	w24,	[sp, #780]

    movz	w7,	#65461
    mov	w27,	w0
    str	w6,	[sp, #740]

    movk	w7,	#65535,	lsl #16
    ldr	x10,	[sp, #440]

    ldr	w26,	[x10]

    str	w26,	[sp, #484]

    str	w3,	[sp, #184]

    ldr	x15,	[sp, fp]

    movz	fp,	#196
    ldr	w8,	[x15]

    str	w8,	[sp, #784]

    ldr	x18,	[sp, fp]

    ldr	w2,	[x18]

    movz	fp,	#636
    str	w2,	[sp, #804]

    str	w14,	[sp, #1896]

    ldr	x22,	[sp, fp]

    ldr	w16,	[x22]

    movz	fp,	#476
    str	w16,	[sp, #728]

    movz	w22,	#65497
    str	w27,	[sp, #1480]

    movk	w22,	#65535,	lsl #16
    ldr	x5,	[sp, fp]

    ldr	w24,	[x5]

    movz	fp,	#500
    str	w24,	[sp, #644]

    movz	w5,	#65430
    movk	w5,	#65535,	lsl #16
    mov	w24,	w5
    str	w24,	[sp, #124]

    ldr	x8,	[sp, #576]

    ldr	w28,	[x8]

    str	w28,	[sp, #736]

    mov	w8,	w7
    str	w8,	[sp, #120]

    ldr	x13,	[sp, #584]

    movz	w8,	#65434
    ldr	w19,	[x13]

    movk	w8,	#65535,	lsl #16
    str	w19,	[sp, #720]

    mov	w7,	w8
    str	w7,	[sp, #1488]

    mov	w7,	w22
    ldr	x17,	[sp, #592]

    ldr	w0,	[x17]

    str	w0,	[sp, #820]

    ldr	w1,	[sp, #820]

    lsl	w1,	w1,	#1
    ldr	w2,	[sp, #820]

    add	w0,	w1,	w2,	lsl #5
    str	w0,	[sp, #1400]

    ldr	x20,	[sp, fp]

    ldr	w19,	[x20]

    movz	fp,	#540
    str	w19,	[sp, #808]

    movz	w20,	#113
    str	w7,	[sp, #1452]

    mov	w18,	w20
    ldr	x23,	[sp, #512]

    ldr	w1,	[x23]

    str	w1,	[sp, #180]

    ldr	w0,	[sp, #180]

    ldr	w8,	[sp, #180]

    lsl	w27,	w0,	#0
    add	w21,	w27,	w8,	lsl #6
    str	w21,	[sp, #1428]

    ldr	x26,	[sp, #520]

    ldr	w8,	[x26]

    str	w8,	[sp, #744]

    ldr	x0,	[sp, #448]

    movz	w8,	#110
    ldr	w3,	[x0]

    mov	w2,	w8
    str	w3,	[sp, #752]

    str	w18,	[sp, #1424]

    ldr	x0,	[sp, #456]

    ldr	w1,	[x0]

    str	w1,	[sp, #812]

    str	w2,	[sp, #1404]

    ldr	x5,	[sp, #464]

    ldr	w20,	[x5]

    str	w20,	[sp, #816]

    ldr	x8,	[sp, fp]

    ldr	w4,	[x8]

    movz	fp,	#548
    str	w4,	[sp, #724]

    ldr	w0,	[sp, #724]

    neg	w4,	w0
    lsl	w19,	w4,	#2
    movz	w0,	#46
    str	w19,	[sp, #1348]

    ldr	x12,	[sp, fp]

    ldr	w23,	[x12]

    movz	fp,	#556
    str	w23,	[sp, #800]

    ldr	w24,	[sp, #800]

    lsl	w9,	w24,	#4
    ldr	w11,	[sp, #800]

    add	w22,	w9,	w11,	lsl #6
    mov	w11,	w0
    str	w22,	[sp, #672]

    ldr	x17,	[sp, fp]

    ldr	w20,	[x17]

    str	w20,	[sp, #764]

    movz	w20,	#47
    str	w11,	[sp, #1892]

    ldr	w12,	[sp, #744]

    ldr	w5,	[sp, #784]

    add	w6,	w12,	w5
    ldr	w7,	[sp, #816]

    add	w8,	w6,	w7
    str	w8,	[sp, #1888]

    ldr	w8,	[sp, #564]

    ldr	w5,	[sp, #772]

    ldr	w22,	[sp, #908]

    madd	w24,	w5,	w8,	w22

    ldr	w0,	[sp, #148]

    ldr	w8,	[sp, #776]

    madd	w13,	w8,	w0,	w24

    ldr	w0,	[sp, #604]

    add	w12,	w13,	w0
    ldr	w15,	[sp, #836]

    ldr	w5,	[sp, #780]

    ldr	w1,	[sp, #740]

    add	w0,	w12,	w15
    ldr	w4,	[sp, #484]

    ldr	w3,	[sp, #184]

    ldr	w16,	[sp, #804]

    madd	w15,	w5,	w1,	w0

    madd	w21,	w4,	w3,	w15

    ldr	w0,	[sp, #1896]

    madd	w3,	w16,	w0,	w21

    ldr	w16,	[sp, #728]

    ldr	w4,	[sp, #1480]

    madd	w0,	w16,	w4,	w3

    ldr	w9,	[sp, #124]

    ldr	w24,	[sp, #644]

    madd	w0,	w24,	w9,	w0

    ldr	w5,	[sp, #120]

    ldr	w14,	[sp, #736]

    madd	w3,	w14,	w5,	w0

    ldr	w18,	[sp, #720]

    ldr	w10,	[sp, #1488]

    madd	w6,	w18,	w10,	w3

    ldr	w14,	[sp, #1400]

    add	w21,	w6,	w14
    ldr	w0,	[sp, #808]

    ldr	w7,	[sp, #1452]

    ldr	w5,	[sp, #1428]

    madd	w22,	w0,	w7,	w21

    ldr	w8,	[sp, #752]

    add	w13,	w22,	w5
    ldr	w11,	[sp, #1424]

    ldr	w21,	[sp, #812]

    ldr	w26,	[sp, #1404]

    madd	w28,	w8,	w11,	w13

    ldr	w5,	[sp, #1888]

    madd	w8,	w21,	w26,	w28

    ldr	w19,	[sp, #1348]

    madd	w28,	w5,	w20,	w8

    ldr	w22,	[sp, #672]

    add	w4,	w28,	w19
    ldr	w16,	[sp, #764]

    ldr	w10,	[sp, #1892]

    add	w0,	w4,	w22
    madd	w3,	w16,	w10,	w0

    cmp	w3,	#0
    movz	w14,	#0
    csel	w0,	w14,	w3,	lt
    cmp	w3,	#127
    movz	w11,	#39
    movz	w28,	#127
    movz	w1,	#65436
    mov	w25,	w28
    movk	w1,	#65535,	lsl #16
    csel	w2,	w25,	w0,	gt
    mul	w8,	w2,	w11
    str	w8,	[sp, #1412]

    movz	w11,	#65442
    ldr	w13,	[sp, #528]

    movk	w11,	#65535,	lsl #16
    lsl	w17,	w13,	#7
    ldr	w14,	[sp, #528]

    mov	w5,	w11
    sub	w7,	w17,	w14,	lsl #1
    movz	w11,	#87
    movz	w17,	#47
    movz	w14,	#65415
    mov	w2,	w17
    movk	w14,	#65535,	lsl #16
    str	w7,	[sp, #1372]

    mov	w27,	w14
    ldr	w22,	[sp, #748]

    movz	w14,	#65426
    neg	w6,	w22
    movk	w14,	#65535,	lsl #16
    lsl	w10,	w6,	#1
    mov	w17,	w14
    add	w3,	w10,	w6,	lsl #4
    movz	w6,	#65494
    movk	w6,	#65535,	lsl #16
    str	w3,	[sp, #1012]

    mov	w16,	w6
    ldr	w13,	[sp, #776]

    movz	w3,	#65515
    mov	w6,	w11
    neg	w13,	w13
    movk	w3,	#65535,	lsl #16
    lsl	w24,	w13,	#3
    movz	w13,	#65411
    str	w24,	[sp, #964]

    movk	w13,	#65535,	lsl #16
    ldr	w12,	[sp, #788]

    neg	w0,	w12
    str	w27,	[sp, #572]

    lsl	w8,	w0,	#2
    ldr	w27,	[sp, #804]

    movz	w0,	#67
    ldr	w18,	[sp, #804]

    lsl	w4,	w27,	#3
    mov	w20,	w0
    mov	w0,	w3
    sub	w19,	w4,	w18,	lsl #0
    movz	w18,	#65493
    movk	w18,	#65535,	lsl #16
    str	w19,	[sp, #1180]

    str	w0,	[sp, #1472]

    ldr	w27,	[sp, #644]

    mov	w0,	w18
    neg	w3,	w27
    mov	w18,	w1
    str	w0,	[sp, #1152]

    lsl	w27,	w3,	#6
    movz	w0,	#105
    sub	w10,	w27,	w3,	lsl #2
    mov	w21,	w0
    str	w21,	[sp, #692]

    movz	w0,	#29
    str	w16,	[sp, #684]

    mov	w21,	w13
    mov	w27,	w0
    str	w6,	[sp, #668]

    movz	w16,	#65514
    str	w27,	[sp, #660]

    movk	w16,	#65535,	lsl #16
    str	w17,	[sp, #176]

    mov	w6,	w16
    str	w18,	[sp, #1176]

    str	w6,	[sp, #1192]

    ldr	w1,	[sp, #120]

    mov	w14,	w1
    str	w14,	[sp, #1160]

    str	w21,	[sp, #136]

    ldr	w17,	[sp, #752]

    ldr	w11,	[sp, #772]

    ldr	w28,	[sp, #744]

    add	w18,	w17,	w11
    neg	w15,	w18
    lsl	w11,	w15,	#5
    sub	w1,	w11,	w15,	lsl #0
    ldr	w15,	[sp, #796]

    ldr	w21,	[sp, #124]

    add	w25,	w28,	w15
    mov	w9,	w21
    ldr	w14,	[sp, #1012]

    ldr	w19,	[sp, #1372]

    add	w23,	w14,	w19
    ldr	w14,	[sp, #964]

    ldr	w16,	[sp, #488]

    add	w4,	w23,	w14
    madd	w22,	w16,	w2,	w4

    add	w17,	w22,	w8
    ldr	w16,	[sp, #780]

    ldr	w28,	[sp, #484]

    ldr	w7,	[sp, #572]

    madd	w20,	w16,	w20,	w17

    ldr	w14,	[sp, #784]

    madd	w20,	w28,	w5,	w20

    madd	w27,	w14,	w7,	w20

    ldr	w20,	[sp, #1180]

    add	w15,	w27,	w20
    ldr	w6,	[sp, #728]

    ldr	w3,	[sp, #1472]

    ldr	w18,	[sp, #736]

    madd	w7,	w6,	w3,	w15

    ldr	w0,	[sp, #1152]

    add	w14,	w7,	w10
    ldr	w8,	[sp, #720]

    madd	w6,	w18,	w0,	w14

    ldr	w14,	[sp, #692]

    madd	w3,	w8,	w14,	w6

    ldr	w16,	[sp, #820]

    ldr	w6,	[sp, #684]

    madd	w4,	w16,	w6,	w3

    ldr	w2,	[sp, #808]

    ldr	w26,	[sp, #668]

    ldr	w5,	[sp, #180]

    madd	w10,	w2,	w26,	w4

    ldr	w21,	[sp, #660]

    madd	w20,	w5,	w21,	w10

    ldr	w18,	[sp, #176]

    madd	w7,	w25,	w9,	w20

    ldr	w23,	[sp, #812]

    add	w26,	w7,	w1
    ldr	w17,	[sp, #816]

    madd	w25,	w23,	w18,	w26

    ldr	w23,	[sp, #1176]

    ldr	w1,	[sp, #724]

    madd	w26,	w17,	w23,	w25

    ldr	w7,	[sp, #1192]

    madd	w7,	w1,	w7,	w26

    ldr	w21,	[sp, #800]

    ldr	w8,	[sp, #1160]

    ldr	w18,	[sp, #136]

    madd	w13,	w21,	w8,	w7

    ldr	w1,	[sp, #764]

    madd	w8,	w1,	w18,	w13

    cmp	w8,	#0
    movz	w9,	#0
    csel	w16,	w9,	w8,	lt
    cmp	w8,	#127
    movz	w4,	#76
    movz	w6,	#26
    ldr	w26,	[sp, #1412]

    movz	w8,	#65441
    movz	w7,	#77
    movz	w9,	#127
    movz	w2,	#29
    movz	w20,	#65498
    movk	w8,	#65535,	lsl #16
    csel	w18,	w9,	w16,	gt
    movk	w20,	#65535,	lsl #16
    mov	w5,	w8
    madd	w23,	w18,	w7,	w26

    movz	w16,	#39
    str	w23,	[sp, #1432]

    ldr	w26,	[sp, #796]

    mul	w22,	w26,	w6
    ldr	w26,	[sp, #528]

    madd	w3,	w26,	w4,	w22

    movz	w4,	#65466
    movz	w22,	#102
    movk	w4,	#65535,	lsl #16
    mov	w25,	w4
    str	w25,	[sp, #616]

    ldr	w26,	[sp, #616]

    ldr	w6,	[sp, #748]

    madd	w1,	w6,	w26,	w3

    ldr	w17,	[sp, #772]

    str	w5,	[sp, #536]

    madd	w7,	w17,	w2,	w1

    ldr	w6,	[sp, #536]

    movz	w17,	#116
    ldr	w0,	[sp, #776]

    madd	w1,	w0,	w6,	w7

    ldr	w27,	[sp, #488]

    lsl	w24,	w27,	#5
    ldr	w28,	[sp, #488]

    ldr	w12,	[sp, #788]

    add	w0,	w24,	w28,	lsl #6
    ldr	w15,	[sp, #780]

    movz	w28,	#52
    add	w1,	w1,	w0
    madd	w6,	w12,	w28,	w1

    neg	w1,	w15
    ldr	w12,	[sp, #484]

    lsl	w25,	w1,	#2
    add	w4,	w25,	w1,	lsl #6
    neg	w1,	w12
    lsl	w28,	w1,	#0
    add	w9,	w6,	w4
    add	w8,	w28,	w1,	lsl #2
    ldr	w28,	[sp, #784]

    lsl	w1,	w28,	#1
    ldr	w0,	[sp, #784]

    add	w13,	w9,	w8
    ldr	w25,	[sp, #804]

    add	w10,	w1,	w0,	lsl #5
    neg	w0,	w25
    lsl	w1,	w0,	#1
    add	w15,	w13,	w10
    add	w14,	w1,	w0,	lsl #5
    ldr	w0,	[sp, #728]

    ldr	w1,	[sp, #644]

    add	w15,	w15,	w14
    lsl	w1,	w1,	#1
    ldr	w2,	[sp, #644]

    movz	w14,	#65437
    add	w18,	w1,	w2,	lsl #2
    ldr	w10,	[sp, #736]

    madd	w19,	w0,	w22,	w15

    movk	w14,	#65535,	lsl #16
    ldr	w0,	[sp, #720]

    add	w23,	w19,	w18
    movz	w18,	#110
    movz	w19,	#27
    madd	w26,	w10,	w20,	w23

    madd	w0,	w0,	w19,	w26

    movz	w23,	#94
    ldr	w26,	[sp, #820]

    ldr	w9,	[sp, #808]

    madd	w0,	w26,	w18,	w0

    ldr	w12,	[sp, #180]

    madd	w0,	w9,	w17,	w0

    ldr	w25,	[sp, #744]

    madd	w3,	w12,	w16,	w0

    neg	w7,	w25
    ldr	w21,	[sp, #752]

    lsl	w9,	w7,	#6
    ldr	w24,	[sp, #812]

    ldr	w25,	[sp, #812]

    sub	w7,	w9,	w7,	lsl #0
    add	w4,	w3,	w7
    ldr	w7,	[sp, #816]

    lsl	w6,	w7,	#7
    ldr	w8,	[sp, #816]

    madd	w9,	w21,	w14,	w4

    sub	w17,	w6,	w8,	lsl #3
    lsl	w4,	w24,	#0
    add	w13,	w4,	w25,	lsl #6
    add	w13,	w9,	w13
    add	w15,	w13,	w17
    ldr	w13,	[sp, #1452]

    mov	w9,	w13
    ldr	w12,	[sp, #724]

    madd	w1,	w12,	w9,	w15

    ldr	w12,	[sp, #800]

    ldr	w2,	[sp, #764]

    neg	w6,	w12
    lsl	w13,	w6,	#1
    add	w22,	w13,	w6,	lsl #2
    add	w22,	w1,	w22
    madd	w21,	w2,	w23,	w22

    cmp	w21,	#0
    movz	w22,	#0
    csel	w27,	w22,	w21,	lt
    cmp	w21,	#127
    movz	w15,	#122
    movz	w5,	#85
    movz	w9,	#49
    movz	w3,	#127
    ldr	w0,	[sp, #1432]

    csel	w16,	w3,	w27,	gt
    lsl	w3,	w16,	#7
    sub	w14,	w3,	w16,	lsl #0
    movz	w3,	#125
    add	w27,	w0,	w14
    mov	w0,	w9
    mov	w9,	w3
    str	w27,	[sp, #1232]

    ldr	w16,	[sp, #528]

    movz	w27,	#50
    neg	w20,	w16
    mov	w19,	w27
    lsl	w4,	w20,	#6
    sub	w1,	w4,	w20,	lsl #0
    mov	w4,	w5
    str	w1,	[sp, #1236]

    ldr	w25,	[sp, #776]

    ldr	w26,	[sp, #776]

    lsl	w23,	w25,	#3
    add	w26,	w23,	w26,	lsl #6
    movz	w23,	#65513
    movk	w23,	#65535,	lsl #16
    str	w26,	[sp, #1220]

    ldr	w28,	[sp, #788]

    neg	w2,	w28
    lsl	w20,	w2,	#5
    sub	w11,	w20,	w2,	lsl #1
    str	w11,	[sp, #1080]

    ldr	w28,	[sp, #780]

    lsl	w26,	w28,	#2
    ldr	w1,	[sp, #780]

    add	w14,	w26,	w1,	lsl #3
    str	w14,	[sp, #1200]

    str	w9,	[sp, #1384]

    mov	w14,	w15
    ldr	w3,	[sp, #804]

    movz	w15,	#95
    neg	w3,	w3
    lsl	w12,	w3,	#0
    add	w6,	w12,	w3,	lsl #6
    movz	w3,	#110
    mov	w25,	w3
    str	w6,	[sp, #1056]

    movz	w3,	#83
    str	w25,	[sp, #1140]

    mov	w17,	w3
    ldr	w13,	[sp, #720]

    movz	w3,	#11
    neg	w28,	w13
    mov	w25,	w3
    lsl	w12,	w28,	#5
    mov	w3,	w15
    sub	w2,	w12,	w28,	lsl #0
    str	w2,	[sp, #1104]

    ldr	w13,	[sp, #148]

    mov	w24,	w13
    str	w24,	[sp, #1092]

    movz	w13,	#65489
    str	w17,	[sp, #1088]

    movk	w13,	#65535,	lsl #16
    str	w14,	[sp, #1084]

    movz	w17,	#125
    mov	w10,	w13
    str	w10,	[sp, #652]

    movz	w13,	#65419
    ldr	w1,	[sp, #816]

    mov	w10,	w17
    movk	w13,	#65535,	lsl #16
    neg	w11,	w1
    lsl	w20,	w11,	#5
    str	w20,	[sp, #664]

    str	w3,	[sp, #992]

    movz	w20,	#118
    mov	w24,	w20
    str	w24,	[sp, #1364]

    ldr	w11,	[sp, #724]

    ldr	w16,	[sp, #784]

    add	w16,	w11,	w16
    str	w16,	[sp, #976]

    ldr	w14,	[sp, #644]

    ldr	w8,	[sp, #484]

    add	w11,	w14,	w8
    ldr	w14,	[sp, #752]

    ldr	w2,	[sp, #796]

    add	w20,	w14,	w2
    mov	w2,	w23
    str	w2,	[sp, #600]

    ldr	w24,	[sp, #748]

    ldr	w3,	[sp, #1236]

    ldr	w2,	[sp, #772]

    madd	w27,	w24,	w0,	w3

    ldr	w24,	[sp, #1220]

    madd	w12,	w2,	w19,	w27

    ldr	w18,	[sp, #488]

    add	w0,	w12,	w24
    ldr	w1,	[sp, #1080]

    madd	w22,	w18,	w4,	w0

    add	w22,	w22,	w1
    ldr	w4,	[sp, #1200]

    ldr	w26,	[sp, #1056]

    ldr	w23,	[sp, #728]

    add	w19,	w22,	w4
    ldr	w5,	[sp, #1480]

    ldr	w0,	[sp, #736]

    ldr	w22,	[sp, #1140]

    add	w1,	w19,	w26
    ldr	w3,	[sp, #1104]

    madd	w28,	w23,	w5,	w1

    madd	w14,	w11,	w10,	w28

    ldr	w1,	[sp, #820]

    madd	w6,	w0,	w22,	w14

    ldr	w17,	[sp, #1092]

    add	w12,	w6,	w3
    ldr	w6,	[sp, #808]

    madd	w4,	w1,	w17,	w12

    ldr	w17,	[sp, #1088]

    madd	w19,	w6,	w17,	w4

    ldr	w4,	[sp, #180]

    ldr	w11,	[sp, #1084]

    madd	w11,	w4,	w11,	w19

    ldr	w19,	[sp, #744]

    ldr	w2,	[sp, #600]

    madd	w1,	w19,	w25,	w11

    ldr	w8,	[sp, #812]

    madd	w4,	w20,	w2,	w1

    ldr	w9,	[sp, #652]

    madd	w1,	w8,	w9,	w4

    ldr	w15,	[sp, #664]

    ldr	w5,	[sp, #976]

    add	w3,	w1,	w15
    ldr	w16,	[sp, #800]

    ldr	w26,	[sp, #992]

    madd	w2,	w5,	w13,	w3

    ldr	w22,	[sp, #764]

    madd	w2,	w16,	w26,	w2

    ldr	w12,	[sp, #1364]

    madd	w3,	w22,	w12,	w2

    cmp	w3,	#0
    movz	w23,	#0
    csel	w1,	w23,	w3,	lt
    cmp	w3,	#127
    movz	w21,	#75
    ldr	w26,	[sp, #124]

    movz	w28,	#101
    movz	w4,	#127
    movz	w25,	#65420
    movz	w23,	#65422
    movz	w19,	#82
    mov	w2,	w4
    movk	w25,	#65535,	lsl #16
    movk	w23,	#65535,	lsl #16
    mov	w22,	w19
    csel	w15,	w2,	w1,	gt
    mov	w1,	w26
    ldr	w26,	[sp, #1232]

    madd	w26,	w15,	w1,	w26

    str	w26,	[sp, #508]

    movz	w1,	#65432
    ldr	w12,	[sp, #796]

    movk	w1,	#65535,	lsl #16
    lsl	w8,	w12,	#3
    ldr	w19,	[sp, #528]

    mov	w24,	w1
    mov	w12,	w25
    madd	w10,	w19,	w22,	w8

    str	w24,	[sp, #1468]

    ldr	w0,	[sp, #748]

    ldr	w7,	[sp, #1468]

    madd	w15,	w0,	w7,	w10

    ldr	w18,	[sp, #772]

    str	w12,	[sp, #904]

    madd	w19,	w18,	w28,	w15

    ldr	w2,	[sp, #776]

    movz	w18,	#65435
    ldr	w0,	[sp, #904]

    movk	w18,	#65535,	lsl #16
    madd	w28,	w2,	w0,	w19

    ldr	w0,	[sp, #488]

    neg	w0,	w0
    ldr	w14,	[sp, #788]

    lsl	w20,	w0,	#6
    neg	w1,	w14
    sub	w17,	w20,	w0,	lsl #0
    lsl	w20,	w1,	#4
    ldr	w0,	[sp, #616]

    mov	w15,	w0
    add	w24,	w28,	w17
    add	w2,	w24,	w20
    ldr	w20,	[sp, #780]

    madd	w0,	w20,	w15,	w2

    ldr	w2,	[sp, #484]

    ldr	w5,	[sp, #1384]

    madd	w3,	w2,	w5,	w0

    ldr	w0,	[sp, #784]

    madd	w26,	w0,	w21,	w3

    ldr	w24,	[sp, #804]

    lsl	w0,	w24,	#1
    ldr	w25,	[sp, #804]

    add	w1,	w0,	w25,	lsl #6
    ldr	w0,	[sp, #728]

    neg	w2,	w0
    add	w28,	w26,	w1
    lsl	w7,	w2,	#5
    mov	w1,	w23
    add	w4,	w7,	w2,	lsl #6
    add	w10,	w28,	w4
    ldr	w4,	[sp, #644]

    str	w1,	[sp, #472]

    madd	w10,	w4,	w18,	w10

    ldr	w2,	[sp, #472]

    ldr	w15,	[sp, #736]

    madd	w12,	w15,	w2,	w10

    ldr	w23,	[sp, #720]

    movz	w15,	#59
    ldr	w27,	[sp, #820]

    lsl	w4,	w27,	#2
    madd	w10,	w23,	w15,	w12

    ldr	w27,	[sp, #820]

    add	w20,	w4,	w27,	lsl #3
    ldr	w9,	[sp, #808]

    lsl	w7,	w9,	#0
    ldr	w5,	[sp, #808]

    add	w13,	w10,	w20
    add	w22,	w7,	w5,	lsl #2
    ldr	w10,	[sp, #536]

    movz	w7,	#79
    mov	w9,	w10
    ldr	w12,	[sp, #180]

    add	w15,	w13,	w22
    movz	w10,	#116
    ldr	w16,	[sp, #744]

    ldr	w13,	[sp, #752]

    madd	w25,	w12,	w9,	w15

    movz	w9,	#65443
    madd	w27,	w16,	w10,	w25

    movk	w9,	#65535,	lsl #16
    madd	w22,	w13,	w9,	w27

    ldr	w27,	[sp, #812]

    lsl	w8,	w27,	#4
    ldr	w25,	[sp, #812]

    ldr	w12,	[sp, #816]

    sub	w0,	w8,	w25,	lsl #0
    ldr	w14,	[sp, #724]

    lsl	w9,	w14,	#0
    ldr	w3,	[sp, #724]

    ldr	w8,	[sp, #800]

    add	w0,	w22,	w0
    add	w2,	w9,	w3,	lsl #1
    madd	w26,	w12,	w7,	w0

    add	w10,	w26,	w2
    ldr	w7,	[sp, #764]

    movz	w2,	#49
    neg	w16,	w7
    lsl	w18,	w16,	#7
    madd	w1,	w8,	w2,	w10

    sub	w13,	w18,	w16,	lsl #2
    add	w17,	w1,	w13
    cmp	w17,	#0
    movz	w0,	#0
    csel	w14,	w0,	w17,	lt
    cmp	w17,	#127
    movz	w6,	#121
    movz	w16,	#114
    ldr	w1,	[sp, #508]

    movz	w19,	#81
    movz	w0,	#127
    movz	w23,	#65462
    mov	w2,	w6
    mov	w4,	w19
    mov	w26,	w0
    movk	w23,	#65535,	lsl #16
    csel	w10,	w26,	w14,	gt
    mov	w15,	w23
    neg	w7,	w10
    lsl	w14,	w7,	#0
    add	w12,	w14,	w7,	lsl #1
    movz	w7,	#65486
    movk	w7,	#65535,	lsl #16
    add	w18,	w1,	w12
    str	w18,	[sp, #956]

    ldr	w18,	[sp, #528]

    lsl	w14,	w18,	#2
    ldr	w0,	[sp, #528]

    add	w20,	w14,	w0,	lsl #6
    ldr	w0,	[sp, #796]

    ldr	w14,	[sp, #1488]

    madd	w17,	w0,	w4,	w20

    mov	w1,	w14
    ldr	w9,	[sp, #748]

    madd	w19,	w9,	w1,	w17

    str	w15,	[sp, #1456]

    ldr	w17,	[sp, #772]

    ldr	w0,	[sp, #1456]

    madd	w12,	w17,	w0,	w19

    ldr	w18,	[sp, #488]

    movz	w19,	#55
    movz	w0,	#65523
    neg	w1,	w18
    mov	w27,	w19
    movk	w0,	#65535,	lsl #16
    lsl	w13,	w1,	#4
    mov	w10,	w0
    sub	w23,	w13,	w1,	lsl #0
    movz	w13,	#101
    str	w23,	[sp, #1448]

    mov	w23,	w13
    str	w10,	[sp, #1484]

    ldr	w1,	[sp, #784]

    neg	w18,	w1
    lsl	w4,	w18,	#6
    sub	w11,	w4,	w18,	lsl #1
    movz	w18,	#38
    mov	w14,	w18
    str	w11,	[sp, #116]

    ldr	w0,	[sp, #804]

    lsl	w25,	w0,	#6
    str	w14,	[sp, #1100]

    ldr	w17,	[sp, #1472]

    movz	w14,	#0
    mov	w21,	w17
    mov	w10,	w14
    str	w21,	[sp, #1108]

    movz	w14,	#65482
    ldr	w3,	[sp, #180]

    movk	w14,	#65535,	lsl #16
    ldr	w4,	[sp, #744]

    neg	w1,	w3
    lsl	w5,	w1,	#1
    add	w20,	w5,	w1,	lsl #3
    mov	w5,	w14
    neg	w1,	w4
    lsl	w1,	w1,	#4
    mov	w4,	w7
    str	w1,	[sp, #984]

    str	w4,	[sp, #1444]

    ldr	w7,	[sp, #812]

    movz	w4,	#82
    sub	w24,	w10,	w7
    ldr	w6,	[sp, #904]

    mov	w10,	w16
    mov	w11,	w6
    str	w11,	[sp, #1024]

    str	w5,	[sp, #648]

    mov	w11,	w4
    ldr	w13,	[sp, #764]

    neg	w4,	w13
    lsl	w3,	w4,	#3
    add	w28,	w3,	w4,	lsl #6
    str	w28,	[sp, #1004]

    ldr	w6,	[sp, #720]

    ldr	w26,	[sp, #808]

    add	w14,	w26,	w6
    ldr	w6,	[sp, #728]

    ldr	w18,	[sp, #820]

    add	w4,	w14,	w24
    ldr	w19,	[sp, #776]

    add	w24,	w18,	w6
    ldr	w1,	[sp, #1448]

    madd	w18,	w19,	w2,	w12

    ldr	w0,	[sp, #788]

    lsl	w9,	w4,	#7
    add	w1,	w18,	w1
    ldr	w12,	[sp, #780]

    sub	w3,	w9,	w4,	lsl #4
    ldr	w17,	[sp, #484]

    madd	w2,	w0,	w27,	w1

    madd	w12,	w12,	w23,	w2

    ldr	w1,	[sp, #1484]

    madd	w14,	w17,	w1,	w12

    ldr	w1,	[sp, #116]

    ldr	w2,	[sp, #644]

    add	w23,	w14,	w1
    ldr	w7,	[sp, #1100]

    ldr	w14,	[sp, #736]

    add	w1,	w23,	w25
    ldr	w9,	[sp, #1108]

    ldr	w19,	[sp, #984]

    ldr	w17,	[sp, #752]

    madd	w4,	w2,	w7,	w1

    ldr	w0,	[sp, #1444]

    madd	w1,	w14,	w9,	w4

    ldr	w16,	[sp, #816]

    madd	w4,	w24,	w10,	w1

    ldr	w25,	[sp, #1024]

    add	w10,	w4,	w20
    ldr	w20,	[sp, #724]

    ldr	w6,	[sp, #648]

    add	w23,	w10,	w19
    madd	w27,	w17,	w0,	w23

    add	w23,	w27,	w3
    madd	w2,	w16,	w25,	w23

    madd	w1,	w20,	w6,	w2

    ldr	w16,	[sp, #800]

    madd	w18,	w16,	w11,	w1

    ldr	w0,	[sp, #1004]

    add	w18,	w18,	w0
    cmp	w18,	#0
    movz	w23,	#0
    csel	w25,	w23,	w18,	lt
    cmp	w18,	#127
    movz	fp,	#1436
    movz	w22,	#52
    movz	w11,	#127
    ldr	w17,	[sp, #956]

    movz	w7,	#65446
    movz	w9,	#86
    csel	w23,	w11,	w25,	gt
    movk	w7,	#65535,	lsl #16
    mov	w2,	w9
    lsl	w25,	w23,	#5
    mov	w16,	w7
    movz	w23,	#65459
    add	w14,	w17,	w25
    movk	w23,	#65535,	lsl #16
    str	w14,	[sp, #944]

    str	x23,	[sp, fp]

    ldr	w0,	[sp, #528]

    movz	fp,	#1436
    ldr	x24,	[sp, fp]

    mul	w6,	w0,	w24
    str	w6,	[sp, #1188]

    str	w16,	[sp, #912]

    ldr	w21,	[sp, #776]

    neg	w11,	w21
    lsl	w8,	w11,	#1
    add	w24,	w8,	w11,	lsl #2
    movz	w11,	#67
    mov	w20,	w11
    str	w24,	[sp, #1132]

    movz	w11,	#0
    ldr	w26,	[sp, #488]

    movz	w24,	#55
    mov	w17,	w11
    neg	w13,	w26
    lsl	w1,	w13,	#5
    sub	w4,	w1,	w13,	lsl #1
    str	w4,	[sp, #1144]

    ldr	w1,	[sp, #788]

    neg	w7,	w1
    lsl	w21,	w7,	#3
    movz	w7,	#81
    str	w21,	[sp, #1128]

    str	w7,	[sp, #1148]

    ldr	w6,	[sp, #484]

    movz	w7,	#59
    lsl	w27,	w6,	#1
    mov	w5,	w7
    str	w27,	[sp, #1136]

    ldr	w21,	[sp, #176]

    mov	w19,	w21
    str	w19,	[sp, #1164]

    ldr	w10,	[sp, #536]

    mov	w19,	w24
    ldr	w18,	[sp, #820]

    mov	w12,	w10
    neg	w1,	w18
    ldr	w10,	[sp, #808]

    lsl	w24,	w1,	#0
    lsl	w0,	w10,	#4
    ldr	w16,	[sp, #808]

    movz	w10,	#65457
    add	w13,	w24,	w1,	lsl #5
    sub	w0,	w0,	w16,	lsl #1
    movk	w10,	#65535,	lsl #16
    movz	w24,	#58
    mov	w26,	w10
    str	w0,	[sp, #1312]

    mov	w0,	w24
    str	w0,	[sp, #568]

    str	w20,	[sp, #828]

    str	w2,	[sp, #1368]

    str	w26,	[sp, #1352]

    ldr	w24,	[sp, #816]

    lsl	w10,	w24,	#4
    ldr	w15,	[sp, #816]

    add	w2,	w10,	w15,	lsl #5
    str	w2,	[sp, #1336]

    ldr	w1,	[sp, #1484]

    mov	w26,	w1
    str	w26,	[sp, #832]

    ldr	w15,	[sp, #800]

    sub	w16,	w17,	w15
    ldr	w8,	[sp, #748]

    ldr	w14,	[sp, #764]

    add	w6,	w14,	w8
    lsl	w20,	w6,	#1
    add	w14,	w20,	w6,	lsl #6
    str	w14,	[sp, #996]

    ldr	w11,	[sp, #736]

    ldr	w21,	[sp, #796]

    add	w17,	w11,	w21
    add	w25,	w17,	w16
    lsl	w16,	w25,	#4
    sub	w4,	w16,	w25,	lsl #0
    str	w4,	[sp, #980]

    ldr	w21,	[sp, #772]

    ldr	w6,	[sp, #1188]

    ldr	w9,	[sp, #912]

    madd	w16,	w21,	w9,	w6

    ldr	w1,	[sp, #1132]

    add	w15,	w16,	w1
    ldr	w2,	[sp, #1144]

    ldr	w24,	[sp, #1128]

    ldr	w28,	[sp, #780]

    add	w16,	w15,	w2
    ldr	w10,	[sp, #1148]

    ldr	w0,	[sp, #1136]

    ldr	w20,	[sp, #784]

    add	w1,	w16,	w24
    madd	w21,	w28,	w10,	w1

    add	w7,	w21,	w0
    ldr	w0,	[sp, #1164]

    ldr	w6,	[sp, #804]

    madd	w7,	w20,	w0,	w7

    ldr	w25,	[sp, #728]

    madd	w27,	w6,	w12,	w7

    ldr	w17,	[sp, #644]

    madd	w28,	w25,	w5,	w27

    ldr	w12,	[sp, #720]

    madd	w27,	w17,	w22,	w28

    ldr	w16,	[sp, #1312]

    madd	w27,	w12,	w19,	w27

    ldr	w25,	[sp, #180]

    add	w17,	w27,	w13
    ldr	w26,	[sp, #568]

    ldr	w8,	[sp, #744]

    ldr	w7,	[sp, #828]

    add	w22,	w17,	w16
    ldr	w6,	[sp, #752]

    ldr	w15,	[sp, #1368]

    madd	w4,	w25,	w26,	w22

    madd	w17,	w8,	w7,	w4

    madd	w15,	w6,	w15,	w17

    ldr	w7,	[sp, #812]

    ldr	w2,	[sp, #1352]

    madd	w22,	w7,	w2,	w15

    ldr	w27,	[sp, #1336]

    add	w15,	w22,	w27
    ldr	w21,	[sp, #724]

    ldr	w8,	[sp, #832]

    ldr	w7,	[sp, #980]

    madd	w17,	w21,	w8,	w15

    ldr	w20,	[sp, #996]

    add	w0,	w17,	w7
    add	w6,	w0,	w20
    cmp	w6,	#0
    movz	w13,	#0
    mov	w12,	w13
    csel	w0,	w12,	w6,	lt
    cmp	w6,	#127
    movz	w20,	#104
    movz	w9,	#127
    movz	w6,	#65417
    ldr	w15,	[sp, #536]

    movz	w11,	#67
    mov	w7,	w9
    movk	w6,	#65535,	lsl #16
    ldr	w22,	[sp, #944]

    mov	w8,	w15
    csel	w0,	w7,	w0,	gt
    mov	w27,	w6
    madd	w19,	w0,	w8,	w22

    movz	w6,	#107
    str	w19,	[sp, #1388]

    mov	w5,	w6
    ldr	w13,	[sp, #796]

    ldr	w1,	[sp, #796]

    lsl	w8,	w13,	#0
    add	w18,	w8,	w1,	lsl #5
    str	w18,	[sp, #1036]

    str	w11,	[sp, #712]

    ldr	w7,	[sp, #772]

    ldr	w21,	[sp, #772]

    lsl	w22,	w7,	#5
    sub	w10,	w22,	w21,	lsl #1
    str	w10,	[sp, #1376]

    ldr	w21,	[sp, #776]

    neg	w16,	w21
    lsl	w9,	w16,	#1
    str	w9,	[sp, #1020]

    ldr	w0,	[sp, #788]

    ldr	w18,	[sp, #788]

    lsl	w4,	w0,	#7
    sub	w1,	w4,	w18,	lsl #3
    str	w1,	[sp, #972]

    ldr	w4,	[sp, #1484]

    ldr	w15,	[sp, #484]

    mov	w18,	w4
    ldr	w3,	[sp, #484]

    lsl	w11,	w15,	#1
    ldr	w2,	[sp, #784]

    movz	w15,	#46
    add	w0,	w11,	w3,	lsl #4
    ldr	w16,	[sp, #784]

    lsl	w13,	w2,	#0
    str	w27,	[sp, #1328]

    mov	w2,	w20
    movz	w27,	#71
    ldr	w8,	[sp, #644]

    add	w11,	w13,	w16,	lsl #2
    mov	w21,	w27
    neg	w19,	w8
    movz	w13,	#83
    lsl	w8,	w19,	#3
    sub	w3,	w8,	w19,	lsl #0
    str	w3,	[sp, #532]

    ldr	w26,	[sp, #820]

    ldr	w7,	[sp, #820]

    lsl	w26,	w26,	#3
    ldr	w19,	[sp, #180]

    add	w3,	w26,	w7,	lsl #4
    neg	w16,	w19
    lsl	w10,	w16,	#5
    add	w14,	w10,	w16,	lsl #6
    mov	w10,	w13
    movz	w13,	#82
    str	w14,	[sp, #856]

    mov	w23,	w13
    ldr	w7,	[sp, #1468]

    mov	w24,	w7
    movz	w7,	#97
    str	w24,	[sp, #1172]

    mov	w17,	w7
    ldr	w19,	[sp, #572]

    mov	w22,	w19
    str	w22,	[sp, #824]

    str	w17,	[sp, #1096]

    str	w10,	[sp, #1040]

    mov	w10,	w15
    movz	w15,	#65452
    str	w10,	[sp, #1184]

    movk	w15,	#65535,	lsl #16
    mov	w17,	w15
    str	w17,	[sp, #1168]

    ldr	w4,	[sp, #488]

    ldr	w16,	[sp, #812]

    add	w4,	w16,	w4
    lsl	w8,	w4,	#0
    add	w7,	w8,	w4,	lsl #6
    str	w7,	[sp, #792]

    ldr	w20,	[sp, #528]

    ldr	w16,	[sp, #808]

    add	w10,	w16,	w20
    str	w10,	[sp, #1116]

    str	w23,	[sp, #1032]

    ldr	w27,	[sp, #748]

    ldr	w7,	[sp, #1036]

    ldr	w13,	[sp, #712]

    ldr	w15,	[sp, #1376]

    madd	w20,	w27,	w13,	w7

    ldr	w10,	[sp, #1020]

    add	w27,	w20,	w15
    ldr	w8,	[sp, #972]

    ldr	w20,	[sp, #780]

    add	w19,	w27,	w10
    add	w8,	w19,	w8
    ldr	w19,	[sp, #804]

    ldr	w9,	[sp, #728]

    madd	w8,	w20,	w18,	w8

    ldr	w28,	[sp, #1328]

    add	w24,	w8,	w0
    add	w20,	w24,	w11
    madd	w6,	w19,	w2,	w20

    ldr	w2,	[sp, #532]

    madd	w6,	w9,	w28,	w6

    ldr	w16,	[sp, #736]

    add	w11,	w6,	w2
    ldr	w17,	[sp, #720]

    ldr	w10,	[sp, #1116]

    madd	w4,	w16,	w21,	w11

    ldr	w12,	[sp, #1032]

    madd	w6,	w17,	w5,	w4

    ldr	w1,	[sp, #856]

    add	w27,	w6,	w3
    madd	w7,	w10,	w12,	w27

    add	w18,	w7,	w1
    ldr	w1,	[sp, #744]

    ldr	w17,	[sp, #1172]

    ldr	w2,	[sp, #752]

    madd	w7,	w1,	w17,	w18

    ldr	w4,	[sp, #824]

    ldr	w17,	[sp, #792]

    madd	w7,	w2,	w4,	w7

    add	w13,	w7,	w17
    ldr	w17,	[sp, #816]

    ldr	w1,	[sp, #1096]

    ldr	w21,	[sp, #724]

    madd	w3,	w17,	w1,	w13

    ldr	w20,	[sp, #1040]

    ldr	w17,	[sp, #800]

    madd	w12,	w21,	w20,	w3

    ldr	w1,	[sp, #1184]

    ldr	w10,	[sp, #764]

    madd	w3,	w17,	w1,	w12

    ldr	w20,	[sp, #1168]

    madd	w9,	w10,	w20,	w3

    cmp	w9,	#0
    movz	w3,	#0
    csel	w11,	w3,	w9,	lt
    cmp	w9,	#127
    movz	w12,	#71
    movz	w21,	#65507
    ldr	w5,	[sp, #1444]

    movz	w8,	#38
    movz	w3,	#127
    movz	w28,	#65490
    movz	fp,	#1436
    mov	w7,	w12
    movk	w21,	#65535,	lsl #16
    mov	w0,	w5
    csel	w16,	w3,	w11,	gt
    movk	w28,	#65535,	lsl #16
    mov	w13,	w21
    ldr	w5,	[sp, #1388]

    madd	w5,	w16,	w0,	w5

    str	w5,	[sp, #1408]

    ldr	w2,	[sp, #528]

    ldr	w24,	[sp, #528]

    lsl	w3,	w2,	#3
    ldr	w2,	[sp, #796]

    sub	w22,	w3,	w24,	lsl #0
    ldr	w5,	[sp, #912]

    ldr	w1,	[sp, #788]

    mov	w19,	w5
    ldr	w23,	[sp, #484]

    neg	w1,	w1
    madd	w27,	w2,	w13,	w22

    lsl	w18,	w23,	#2
    lsl	w17,	w1,	#5
    ldr	w2,	[sp, #484]

    add	w10,	w18,	w2,	lsl #5
    str	w10,	[sp, #2708]

    mov	w10,	w28
    ldr	w9,	[sp, #136]

    movz	w28,	#65463
    mov	w1,	w9
    movk	w28,	#65535,	lsl #16
    str	w1,	[sp, #1028]

    mov	w24,	w28
    str	w10,	[sp, #1344]

    str	w24,	[sp, #1008]

    ldr	w3,	[sp, #820]

    neg	w6,	w3
    lsl	w1,	w6,	#1
    add	w4,	w1,	w6,	lsl #5
    movz	w1,	#65449
    movk	w1,	#65535,	lsl #16
    str	w4,	[sp, #960]

    mov	w3,	w1
    movz	w1,	#53
    str	w3,	[sp, #680]

    mov	w12,	w1
    ldr	w4,	[sp, #120]

    str	w4,	[sp, #1332]

    ldr	x23,	[sp, fp]

    mov	w6,	w23
    str	w6,	[sp, #1044]

    str	w12,	[sp, #656]

    ldr	w10,	[sp, #564]

    ldr	w25,	[sp, #1484]

    mov	w2,	w10
    mov	w10,	w25
    str	w10,	[sp, #1052]

    ldr	w9,	[sp, #472]

    mov	w1,	w9
    str	w1,	[sp, #1048]

    ldr	w14,	[sp, #736]

    ldr	w4,	[sp, #780]

    ldr	w11,	[sp, #816]

    add	w12,	w14,	w4
    add	w9,	w12,	w11
    movz	w11,	#37
    mov	w0,	w11
    str	w9,	[sp, #988]

    str	w0,	[sp, #1356]

    ldr	w0,	[sp, #644]

    ldr	w11,	[sp, #748]

    ldr	w6,	[sp, #616]

    add	w0,	w0,	w11
    ldr	w28,	[sp, #772]

    mov	w21,	w6
    ldr	w3,	[sp, #776]

    madd	w11,	w28,	w8,	w27

    ldr	w12,	[sp, #1448]

    madd	w16,	w3,	w19,	w11

    ldr	w11,	[sp, #2708]

    add	w10,	w16,	w12
    ldr	w27,	[sp, #116]

    ldr	w6,	[sp, #804]

    add	w3,	w10,	w17
    add	w16,	w3,	w11
    ldr	w11,	[sp, #1028]

    ldr	w1,	[sp, #728]

    add	w10,	w16,	w27
    ldr	w19,	[sp, #1344]

    ldr	w15,	[sp, #720]

    ldr	w20,	[sp, #1008]

    madd	w6,	w6,	w11,	w10

    madd	w8,	w1,	w19,	w6

    madd	w28,	w0,	w21,	w8

    ldr	w0,	[sp, #960]

    madd	w8,	w15,	w20,	w28

    ldr	w6,	[sp, #808]

    add	w19,	w8,	w0
    ldr	w9,	[sp, #680]

    ldr	w24,	[sp, #180]

    madd	w6,	w6,	w9,	w19

    ldr	w0,	[sp, #1332]

    ldr	w28,	[sp, #744]

    madd	w9,	w24,	w0,	w6

    ldr	w3,	[sp, #752]

    madd	w24,	w28,	w7,	w9

    ldr	w23,	[sp, #1044]

    ldr	w4,	[sp, #812]

    madd	w5,	w3,	w23,	w24

    ldr	w18,	[sp, #656]

    ldr	w27,	[sp, #988]

    madd	w13,	w4,	w18,	w5

    ldr	w12,	[sp, #1356]

    ldr	w22,	[sp, #724]

    madd	w12,	w27,	w12,	w13

    ldr	w28,	[sp, #800]

    madd	w21,	w22,	w2,	w12

    ldr	w25,	[sp, #1052]

    ldr	w24,	[sp, #764]

    madd	w27,	w28,	w25,	w21

    ldr	w22,	[sp, #1048]

    madd	w26,	w24,	w22,	w27

    cmp	w26,	#0
    movz	w14,	#0
    csel	w28,	w14,	w26,	lt
    cmp	w26,	#127
    movz	w26,	#65414
    movz	w11,	#42
    movz	w15,	#127
    ldr	w23,	[sp, #600]

    movz	w24,	#109
    movz	w5,	#115
    movz	w21,	#41
    movz	fp,	#1436
    movk	w26,	#65535,	lsl #16
    csel	w0,	w15,	w28,	gt
    ldr	w6,	[sp, #1408]

    mov	w16,	w23
    mov	w19,	w26
    madd	w9,	w0,	w16,	w6

    movz	w26,	#47
    mov	w6,	w21
    str	w9,	[sp, #1272]

    mov	w13,	w26
    movz	w9,	#65485
    ldr	w4,	[sp, #528]

    movk	w9,	#65535,	lsl #16
    mul	w8,	w4,	w11
    movz	w4,	#22
    movz	w11,	#65444
    str	w8,	[sp, #3092]

    movk	w11,	#65535,	lsl #16
    mov	w8,	w24
    ldr	w2,	[sp, #148]

    mov	w22,	w11
    mov	w24,	w5
    ldr	w0,	[sp, #488]

    mov	w27,	w2
    movz	w11,	#38
    ldr	w1,	[sp, #488]

    lsl	w17,	w0,	#1
    movz	w2,	#75
    mov	w10,	w2
    add	w28,	w17,	w1,	lsl #3
    mov	w1,	w9
    str	w28,	[sp, #3496]

    ldr	x0,	[sp, fp]

    mov	w15,	w0
    str	w15,	[sp, #1216]

    movz	w15,	#85
    ldr	w2,	[sp, #484]

    ldr	w3,	[sp, #484]

    lsl	w2,	w2,	#5
    add	w2,	w2,	w3,	lsl #6
    str	w2,	[sp, #3072]

    ldr	w25,	[sp, #1456]

    mov	w2,	w25
    str	w2,	[sp, #1212]

    ldr	w9,	[sp, #180]

    mov	w2,	w4
    neg	w17,	w9
    movz	w4,	#65487
    mov	w9,	w11
    str	w17,	[sp, #1000]

    movk	w4,	#65535,	lsl #16
    ldr	w20,	[sp, #1000]

    ldr	w21,	[sp, #1000]

    lsl	w20,	w20,	#2
    add	w18,	w20,	w21,	lsl #6
    str	w18,	[sp, #696]

    str	w9,	[sp, #1420]

    movz	w9,	#29
    mov	w0,	w9
    str	w0,	[sp, #1016]

    str	w24,	[sp, #1392]

    ldr	w14,	[sp, #572]

    mov	w28,	w14
    str	w28,	[sp, #1380]

    ldr	w3,	[sp, #724]

    ldr	w7,	[sp, #724]

    lsl	w25,	w3,	#2
    add	w17,	w25,	w7,	lsl #5
    mov	w7,	w4
    mov	w4,	w15
    str	w17,	[sp, #1360]

    str	w7,	[sp, #1396]

    str	w4,	[sp, #1416]

    movz	w4,	#67
    ldr	w23,	[sp, #720]

    mov	w17,	w4
    ldr	w7,	[sp, #796]

    add	w7,	w23,	w7
    str	w7,	[sp, #968]

    ldr	w7,	[sp, #748]

    ldr	w9,	[sp, #3092]

    ldr	w15,	[sp, #772]

    madd	w3,	w7,	w6,	w9

    madd	w3,	w15,	w27,	w3

    ldr	w15,	[sp, #776]

    ldr	w0,	[sp, #3496]

    madd	w27,	w15,	w22,	w3

    ldr	w22,	[sp, #788]

    add	w27,	w27,	w0
    ldr	w4,	[sp, #1216]

    madd	w16,	w22,	w4,	w27

    ldr	w27,	[sp, #780]

    ldr	w3,	[sp, #3072]

    madd	w27,	w27,	w10,	w16

    ldr	w20,	[sp, #784]

    add	w16,	w27,	w3
    ldr	w27,	[sp, #804]

    ldr	w24,	[sp, #728]

    madd	w1,	w20,	w1,	w16

    ldr	w20,	[sp, #1212]

    madd	w10,	w27,	w8,	w1

    ldr	w6,	[sp, #532]

    madd	w15,	w24,	w20,	w10

    add	w23,	w15,	w6
    ldr	w6,	[sp, #736]

    ldr	w9,	[sp, #968]

    madd	w25,	w6,	w19,	w23

    ldr	w4,	[sp, #820]

    madd	w1,	w9,	w17,	w25

    ldr	w23,	[sp, #808]

    madd	w28,	w4,	w13,	w1

    ldr	w7,	[sp, #696]

    madd	w1,	w23,	w2,	w28

    ldr	w3,	[sp, #744]

    add	w10,	w1,	w7
    ldr	w18,	[sp, #1420]

    ldr	w23,	[sp, #752]

    ldr	w7,	[sp, #1016]

    madd	w17,	w3,	w18,	w10

    ldr	w21,	[sp, #812]

    madd	w0,	w23,	w7,	w17

    ldr	w27,	[sp, #1392]

    ldr	w2,	[sp, #816]

    madd	w5,	w21,	w27,	w0

    ldr	w17,	[sp, #1380]

    ldr	w28,	[sp, #1360]

    madd	w2,	w2,	w17,	w5

    ldr	w0,	[sp, #800]

    add	w6,	w2,	w28
    ldr	w2,	[sp, #1396]

    ldr	w27,	[sp, #764]

    madd	w21,	w0,	w2,	w6

    ldr	w14,	[sp, #1416]

    madd	w16,	w27,	w14,	w21

    cmp	w16,	#0
    movz	w18,	#0
    csel	w25,	w18,	w16,	lt
    cmp	w16,	#127
    ldr	w10,	[sp, #1272]

    movz	w15,	#46
    movz	w4,	#127
    mov	w18,	w15
    csel	w2,	w4,	w25,	gt
    madd	w24,	w2,	w18,	w10

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
    ldr	w25,	[sp, #716]

    sub	w15,	w25,	#1
    cmp	w15,	#0
    ble	main_617

main_36:
    mov	w26,	w15
    str	w26,	[sp, #716]

    b	main_37

main_39:
    mov	w20,	w17
    b	main_40

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #3520
    ret


