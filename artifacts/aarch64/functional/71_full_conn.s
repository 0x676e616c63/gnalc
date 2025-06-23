.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#4464
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x16,	sp,	#16
    movz	fp,	#124
    mov	w2,	w0
    mov	x7,	x16
    add	x6,	x7,	#16
    add	x3,	x7,	#12
    add	x15,	x16,	#80
    add	x5,	x16,	#40
    add	x9,	x16,	#20
    add	x18,	x7,	#8
    add	x28,	x7,	#4
    mov	x26,	x7
    add	x22,	x15,	#8
    add	x23,	x5,	#12
    add	x19,	x5,	#8
    add	x4,	x5,	#4
    mov	x1,	x5
    add	x27,	x9,	#16
    add	x25,	x9,	#12
    add	x21,	x9,	#8
    str	x26,	[sp, fp]

    add	x26,	x5,	#16
    movz	fp,	#508
    str	x28,	[sp, #160]

    str	x18,	[sp, fp]

    add	x18,	x9,	#4
    movz	fp,	#308
    str	x3,	[sp, #416]

    str	x6,	[sp, fp]

    movz	fp,	#316
    str	x9,	[sp, fp]

    movz	fp,	#348
    str	x18,	[sp, fp]

    movz	fp,	#388
    str	x21,	[sp, #424]

    str	x25,	[sp, #432]

    add	x25,	x15,	#12
    str	x27,	[sp, #440]

    add	x27,	x15,	#16
    str	x1,	[sp, #328]

    str	x4,	[sp, #336]

    add	x4,	x16,	#60
    str	x19,	[sp, fp]

    mov	x28,	x4
    add	x19,	x15,	#4
    str	x23,	[sp, #400]

    add	x12,	x4,	#16
    add	x9,	x4,	#12
    add	x6,	x4,	#8
    add	x3,	x4,	#4
    str	x26,	[sp, #464]

    str	x28,	[sp, #472]

    str	x3,	[sp, #488]

    str	x6,	[sp, #184]

    str	x9,	[sp, #192]

    str	x12,	[sp, #200]

    str	x15,	[sp, #208]

    str	x19,	[sp, #256]

    str	x22,	[sp, #264]

    str	x25,	[sp, #280]

    str	x27,	[sp, #288]

    str	w2,	[sp, #496]


main_37:
    movz	w24,	#0
    mov	w19,	w24

main_40:
    lsl	w6,	w19,	#2
    movz	w28,	#0
    add	w10,	w6,	w19,	lsl #4
    mov	x23,	x10
    add	x23,	sp,	x23
    add	x23,	x23,	#16

main_43:
    cmp	w28,	#5
    bge	main_50

main_46:
    lsl	w20,	w28,	#2
    add	x20,	x23,	x20
    bl	getint
    add	w10,	w28,	#1
    str	w0,	[x20]

    mov	w28,	w10
    b	main_43

main_50:
    add	w16,	w19,	#1
    cmp	w16,	#5
    blt	main_39

main_53:
    movz	fp,	#124
    movz	w21,	#85
    movz	w17,	#23
    movz	w28,	#65454
    movz	w15,	#65413
    ldr	x18,	[sp, fp]

    movk	w28,	#65535,	lsl #16
    movk	w15,	#65535,	lsl #16
    ldr	w11,	[x18]

    movz	fp,	#508
    mov	w9,	w28
    mov	w19,	w15
    str	w11,	[sp, #956]

    ldr	w0,	[sp, #956]

    mul	w8,	w0,	w21
    ldr	x22,	[sp, #160]

    ldr	w18,	[x22]

    str	w18,	[sp, #300]

    movz	w22,	#65477
    ldr	w20,	[sp, #300]

    movk	w22,	#65535,	lsl #16
    madd	w18,	w20,	w17,	w8

    ldr	x12,	[sp, fp]

    ldr	w27,	[x12]

    movz	fp,	#308
    str	w27,	[sp, #888]

    ldr	w0,	[sp, #888]

    madd	w20,	w0,	w9,	w18

    str	w20,	[sp, #1508]

    mov	w9,	w22
    ldr	x25,	[sp, #416]

    ldr	w4,	[x25]

    str	w4,	[sp, #900]

    movz	w25,	#65433
    movk	w25,	#65535,	lsl #16
    mov	w7,	w25
    str	w7,	[sp, #180]

    movz	w25,	#65425
    ldr	x28,	[sp, fp]

    movk	w25,	#65535,	lsl #16
    ldr	w17,	[x28]

    movz	fp,	#316
    mov	w6,	w25
    str	w17,	[sp, #904]

    str	w19,	[sp, #412]

    ldr	x2,	[sp, fp]

    ldr	w20,	[x2]

    movz	fp,	#348
    str	w20,	[sp, #456]

    ldr	w21,	[sp, #456]

    lsl	w26,	w21,	#6
    movz	w21,	#50
    str	w26,	[sp, #1516]

    mov	w3,	w21
    ldr	x10,	[sp, fp]

    ldr	w27,	[x10]

    movz	fp,	#388
    str	w27,	[sp, #948]

    ldr	w28,	[sp, #948]

    neg	w4,	w28
    lsl	w27,	w4,	#7
    movz	w28,	#65430
    movk	w28,	#65535,	lsl #16
    sub	w23,	w27,	w4,	lsl #3
    str	w23,	[sp, #1512]

    ldr	x13,	[sp, #424]

    ldr	w1,	[x13]

    str	w1,	[sp, #920]

    str	w3,	[sp, #296]

    ldr	x16,	[sp, #432]

    ldr	w3,	[x16]

    str	w3,	[sp, #448]

    str	w9,	[sp, #1084]

    ldr	x20,	[sp, #440]

    ldr	w14,	[x20]

    str	w14,	[sp, #928]

    ldr	x23,	[sp, #328]

    ldr	w8,	[x23]

    str	w8,	[sp, #964]

    str	w6,	[sp, #1052]

    ldr	x27,	[sp, #336]

    ldr	w21,	[x27]

    str	w21,	[sp, #868]

    movz	w27,	#65469
    mov	w21,	w28
    movk	w27,	#65535,	lsl #16
    mov	w3,	w27
    str	w3,	[sp, #1568]

    ldr	x11,	[sp, fp]

    ldr	w0,	[x11]

    str	w0,	[sp, #344]

    movz	w0,	#65461
    str	w21,	[sp, #136]

    movk	w0,	#65535,	lsl #16
    movz	w21,	#47
    ldr	x15,	[sp, #400]

    mov	w14,	w0
    ldr	w2,	[x15]

    str	w2,	[sp, #872]

    str	w14,	[sp, #304]

    movz	w2,	#65434
    ldr	x19,	[sp, #464]

    movk	w2,	#65535,	lsl #16
    ldr	w24,	[x19]

    mov	w7,	w2
    movz	w19,	#65497
    str	w24,	[sp, #500]

    movk	w19,	#65535,	lsl #16
    str	w7,	[sp, #1556]

    mov	w9,	w19
    ldr	x22,	[sp, #472]

    ldr	w6,	[x22]

    str	w6,	[sp, #996]

    ldr	w7,	[sp, #996]

    lsl	w3,	w7,	#1
    ldr	w8,	[sp, #996]

    add	w20,	w3,	w8,	lsl #5
    str	w20,	[sp, #1332]

    ldr	x25,	[sp, #488]

    ldr	w24,	[x25]

    str	w24,	[sp, #980]

    str	w9,	[sp, #1532]

    ldr	x28,	[sp, #184]

    ldr	w4,	[x28]

    str	w4,	[sp, #460]

    ldr	w5,	[sp, #460]

    lsl	w25,	w5,	#0
    ldr	w6,	[sp, #460]

    add	w23,	w25,	w6,	lsl #6
    str	w23,	[sp, #952]

    ldr	x0,	[sp, #192]

    ldr	w15,	[x0]

    str	w15,	[sp, #876]

    ldr	x3,	[sp, #200]

    ldr	w9,	[x3]

    str	w9,	[sp, #892]

    movz	w9,	#113
    mov	w12,	w9
    str	w12,	[sp, #2020]

    movz	w9,	#110
    ldr	x6,	[sp, #208]

    mov	w27,	w9
    ldr	w7,	[x6]

    str	w7,	[sp, #988]

    str	w27,	[sp, #1300]

    ldr	x9,	[sp, #256]

    ldr	w25,	[x9]

    str	w25,	[sp, #992]

    ldr	x12,	[sp, #264]

    ldr	w5,	[x12]

    str	w5,	[sp, #864]

    ldr	w6,	[sp, #864]

    neg	w9,	w6
    lsl	w26,	w9,	#2
    str	w26,	[sp, #1464]

    ldr	x19,	[sp, #280]

    ldr	w28,	[x19]

    str	w28,	[sp, #960]

    ldr	w0,	[sp, #960]

    lsl	w26,	w0,	#4
    ldr	w15,	[sp, #960]

    add	w23,	w26,	w15,	lsl #6
    str	w23,	[sp, #564]

    ldr	x22,	[sp, #288]

    ldr	w25,	[x22]

    str	w25,	[sp, #896]

    movz	w22,	#46
    ldr	w4,	[sp, #876]

    mov	w15,	w22
    ldr	w0,	[sp, #928]

    add	w0,	w4,	w0
    ldr	w8,	[sp, #992]

    ldr	w7,	[sp, #180]

    ldr	w6,	[sp, #900]

    add	w23,	w0,	w8
    ldr	w18,	[sp, #1508]

    mov	w0,	w21
    madd	w5,	w6,	w7,	w18

    ldr	w12,	[sp, #412]

    ldr	w9,	[sp, #904]

    madd	w10,	w9,	w12,	w5

    ldr	w26,	[sp, #1516]

    ldr	w22,	[sp, #1512]

    add	w11,	w10,	w26
    ldr	w7,	[sp, #920]

    ldr	w2,	[sp, #296]

    add	w21,	w11,	w22
    ldr	w11,	[sp, #448]

    ldr	w4,	[sp, #1084]

    madd	w26,	w7,	w2,	w21

    madd	w27,	w11,	w4,	w26

    ldr	w11,	[sp, #964]

    ldr	w1,	[sp, #1052]

    madd	w26,	w11,	w1,	w27

    ldr	w3,	[sp, #868]

    ldr	w5,	[sp, #1568]

    madd	w26,	w3,	w5,	w26

    ldr	w7,	[sp, #136]

    ldr	w4,	[sp, #344]

    madd	w2,	w4,	w7,	w26

    ldr	w7,	[sp, #304]

    ldr	w4,	[sp, #872]

    madd	w2,	w4,	w7,	w2

    ldr	w4,	[sp, #500]

    ldr	w10,	[sp, #1556]

    madd	w2,	w4,	w10,	w2

    ldr	w13,	[sp, #1332]

    add	w13,	w2,	w13
    ldr	w2,	[sp, #980]

    ldr	w8,	[sp, #1532]

    ldr	w17,	[sp, #952]

    madd	w11,	w2,	w8,	w13

    ldr	w5,	[sp, #892]

    add	w18,	w11,	w17
    ldr	w11,	[sp, #2020]

    ldr	w13,	[sp, #988]

    madd	w20,	w5,	w11,	w18

    ldr	w9,	[sp, #1300]

    madd	w19,	w13,	w9,	w20

    ldr	w5,	[sp, #1464]

    madd	w14,	w23,	w0,	w19

    add	w19,	w14,	w5
    ldr	w0,	[sp, #564]

    ldr	w6,	[sp, #896]

    add	w21,	w19,	w0
    madd	w23,	w6,	w15,	w21

    cmp	w23,	#0
    movz	w24,	#0
    mov	w26,	w24
    csel	w21,	w26,	w23,	lt
    cmp	w23,	#127
    movz	w20,	#65493
    movz	w18,	#65515
    movz	w25,	#127
    movz	w26,	#39
    movz	w3,	#65514
    movz	w11,	#65411
    movk	w20,	#65535,	lsl #16
    movk	w18,	#65535,	lsl #16
    csel	w16,	w25,	w21,	gt
    mov	w24,	w26
    movk	w3,	#65535,	lsl #16
    movk	w11,	#65535,	lsl #16
    mul	w14,	w16,	w24
    movz	w26,	#65494
    str	w14,	[sp, #1324]

    movk	w26,	#65535,	lsl #16
    ldr	w19,	[sp, #300]

    lsl	w9,	w19,	#7
    ldr	w21,	[sp, #300]

    sub	w1,	w9,	w21,	lsl #1
    movz	w9,	#47
    mov	w6,	w9
    str	w1,	[sp, #1372]

    ldr	w28,	[sp, #888]

    movz	w1,	#87
    neg	w17,	w28
    lsl	w10,	w17,	#1
    add	w24,	w10,	w17,	lsl #4
    movz	w10,	#67
    mov	w28,	w10
    str	w24,	[sp, #1500]

    movz	w10,	#65442
    movz	w24,	#105
    ldr	w19,	[sp, #904]

    movk	w10,	#65535,	lsl #16
    neg	w14,	w19
    mov	w9,	w10
    lsl	w27,	w14,	#3
    movz	w19,	#65415
    str	w27,	[sp, #1368]

    movk	w19,	#65535,	lsl #16
    str	w6,	[sp, #1476]

    mov	w22,	w19
    ldr	w0,	[sp, #948]

    neg	w16,	w0
    lsl	w12,	w16,	#2
    str	w12,	[sp, #1404]

    str	w22,	[sp, #324]

    ldr	w25,	[sp, #964]

    ldr	w0,	[sp, #964]

    lsl	w12,	w25,	#3
    mov	w25,	w18
    sub	w15,	w12,	w0,	lsl #0
    mov	w18,	w26
    str	w25,	[sp, #1552]

    ldr	w2,	[sp, #344]

    neg	w27,	w2
    mov	w2,	w20
    lsl	w0,	w27,	#6
    sub	w13,	w0,	w27,	lsl #2
    movz	w0,	#29
    mov	w27,	w3
    mov	w23,	w0
    str	w13,	[sp, #1392]

    movz	w0,	#65426
    str	w2,	[sp, #1048]

    mov	w13,	w11
    movk	w0,	#65535,	lsl #16
    str	w24,	[sp, #560]

    str	w18,	[sp, #552]

    str	w1,	[sp, #532]

    str	w23,	[sp, #520]

    mov	w1,	w0
    str	w1,	[sp, #372]

    movz	w1,	#65436
    ldr	w8,	[sp, #304]

    movk	w1,	#65535,	lsl #16
    str	w8,	[sp, #1360]

    mov	w24,	w1
    str	w13,	[sp, #356]

    ldr	w11,	[sp, #892]

    ldr	w0,	[sp, #900]

    ldr	w20,	[sp, #876]

    add	w25,	w11,	w0
    ldr	w3,	[sp, #956]

    neg	w10,	w25
    add	w1,	w20,	w3
    ldr	w5,	[sp, #136]

    lsl	w4,	w10,	#5
    str	w5,	[sp, #1440]

    ldr	w22,	[sp, #1372]

    sub	w26,	w4,	w10,	lsl #0
    ldr	w13,	[sp, #1500]

    ldr	w19,	[sp, #1368]

    add	w7,	w13,	w22
    ldr	w16,	[sp, #456]

    ldr	w22,	[sp, #1476]

    add	w10,	w7,	w19
    ldr	w20,	[sp, #1404]

    ldr	w5,	[sp, #920]

    ldr	w6,	[sp, #448]

    madd	w8,	w16,	w22,	w10

    add	w12,	w8,	w20
    madd	w12,	w5,	w28,	w12

    madd	w13,	w6,	w9,	w12

    ldr	w9,	[sp, #324]

    ldr	w8,	[sp, #928]

    madd	w0,	w8,	w9,	w13

    ldr	w7,	[sp, #868]

    add	w4,	w0,	w15
    ldr	w15,	[sp, #1552]

    ldr	w14,	[sp, #1392]

    madd	w4,	w7,	w15,	w4

    ldr	w11,	[sp, #872]

    add	w5,	w4,	w14
    ldr	w4,	[sp, #1048]

    ldr	w0,	[sp, #500]

    madd	w4,	w11,	w4,	w5

    ldr	w5,	[sp, #560]

    madd	w4,	w0,	w5,	w4

    ldr	w8,	[sp, #996]

    ldr	w21,	[sp, #552]

    madd	w5,	w8,	w21,	w4

    ldr	w14,	[sp, #980]

    ldr	w4,	[sp, #532]

    madd	w4,	w14,	w4,	w5

    ldr	w14,	[sp, #460]

    ldr	w25,	[sp, #520]

    madd	w10,	w14,	w25,	w4

    ldr	w13,	[sp, #1440]

    madd	w19,	w1,	w13,	w10

    ldr	w0,	[sp, #372]

    add	w23,	w19,	w26
    ldr	w14,	[sp, #988]

    ldr	w8,	[sp, #992]

    ldr	w18,	[sp, #864]

    madd	w20,	w14,	w0,	w23

    madd	w22,	w8,	w24,	w20

    ldr	w0,	[sp, #960]

    madd	w11,	w18,	w27,	w22

    ldr	w18,	[sp, #1360]

    ldr	w26,	[sp, #356]

    madd	w23,	w0,	w18,	w11

    ldr	w7,	[sp, #896]

    madd	w0,	w7,	w26,	w23

    cmp	w0,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w9,	w9,	w0,	lt
    cmp	w0,	#127
    movz	w21,	#65441
    movz	w16,	#76
    movz	w19,	#29
    ldr	w18,	[sp, #1324]

    movz	w14,	#77
    movz	w15,	#127
    movk	w21,	#65535,	lsl #16
    mov	w24,	w14
    mov	w25,	w15
    mov	w5,	w21
    csel	w13,	w25,	w9,	gt
    movz	w15,	#26
    madd	w26,	w13,	w24,	w18

    mov	w22,	w15
    str	w26,	[sp, #924]

    movz	w18,	#65466
    movz	w13,	#39
    mov	w15,	w16
    ldr	w1,	[sp, #956]

    movk	w18,	#65535,	lsl #16
    mul	w0,	w1,	w22
    ldr	w23,	[sp, #300]

    mov	w2,	w18
    movz	w22,	#52
    madd	w28,	w23,	w15,	w0

    str	w2,	[sp, #152]

    mov	w18,	w19
    ldr	w3,	[sp, #152]

    ldr	w14,	[sp, #888]

    madd	w1,	w14,	w3,	w28

    ldr	w7,	[sp, #900]

    mov	w14,	w22
    madd	w2,	w7,	w18,	w1

    str	w5,	[sp, #156]

    ldr	w7,	[sp, #156]

    ldr	w5,	[sp, #904]

    madd	w10,	w5,	w7,	w2

    ldr	w24,	[sp, #456]

    ldr	w26,	[sp, #456]

    lsl	w19,	w24,	#5
    ldr	w1,	[sp, #948]

    movz	w24,	#102
    add	w15,	w19,	w26,	lsl #6
    add	w18,	w10,	w15
    madd	w25,	w1,	w14,	w18

    ldr	w18,	[sp, #920]

    ldr	w16,	[sp, #448]

    neg	w22,	w18
    ldr	w17,	[sp, #928]

    neg	w26,	w16
    lsl	w10,	w22,	#2
    lsl	w27,	w17,	#1
    lsl	w15,	w26,	#0
    add	w18,	w10,	w22,	lsl #6
    add	w22,	w15,	w26,	lsl #2
    add	w0,	w25,	w18
    ldr	w18,	[sp, #928]

    add	w25,	w27,	w18,	lsl #5
    add	w28,	w0,	w22
    mov	w18,	w24
    ldr	w0,	[sp, #964]

    ldr	w26,	[sp, #868]

    neg	w10,	w0
    add	w16,	w28,	w25
    ldr	w1,	[sp, #344]

    lsl	w21,	w10,	#1
    movz	w25,	#65498
    lsl	w24,	w1,	#1
    ldr	w2,	[sp, #344]

    add	w9,	w21,	w10,	lsl #5
    movk	w25,	#65535,	lsl #16
    ldr	w5,	[sp, #872]

    add	w15,	w24,	w2,	lsl #2
    mov	w22,	w25
    ldr	w0,	[sp, #500]

    add	w23,	w16,	w9
    ldr	w10,	[sp, #996]

    movz	w9,	#110
    madd	w21,	w26,	w18,	w23

    movz	w26,	#27
    add	w19,	w21,	w15
    mov	w14,	w26
    madd	w17,	w5,	w22,	w19

    madd	w25,	w0,	w14,	w17

    mov	w14,	w9
    ldr	w0,	[sp, #980]

    madd	w16,	w10,	w14,	w25

    ldr	w8,	[sp, #460]

    movz	w10,	#116
    movz	w14,	#65437
    movk	w14,	#65535,	lsl #16
    madd	w23,	w0,	w10,	w16

    mov	w16,	w13
    ldr	w0,	[sp, #876]

    madd	w18,	w8,	w16,	w23

    ldr	w12,	[sp, #892]

    neg	w15,	w0
    ldr	w10,	[sp, #988]

    lsl	w26,	w15,	#6
    lsl	w28,	w10,	#0
    ldr	w11,	[sp, #988]

    sub	w15,	w26,	w15,	lsl #0
    add	w22,	w28,	w11,	lsl #6
    ldr	w25,	[sp, #992]

    lsl	w20,	w25,	#7
    ldr	w27,	[sp, #992]

    add	w21,	w18,	w15
    sub	w26,	w20,	w27,	lsl #3
    madd	w24,	w12,	w14,	w21

    ldr	w12,	[sp, #1532]

    add	w10,	w24,	w22
    mov	w23,	w12
    ldr	w8,	[sp, #864]

    ldr	w17,	[sp, #960]

    add	w10,	w10,	w26
    ldr	w27,	[sp, #896]

    neg	w26,	w17
    madd	w15,	w8,	w23,	w10

    lsl	w10,	w26,	#1
    add	w14,	w10,	w26,	lsl #2
    add	w14,	w15,	w14
    movz	w15,	#94
    mov	w16,	w15
    madd	w23,	w27,	w16,	w14

    cmp	w23,	#0
    movz	w16,	#0
    mov	w10,	w16
    csel	w25,	w10,	w23,	lt
    cmp	w23,	#127
    movz	w16,	#110
    movz	w15,	#50
    movz	w19,	#127
    ldr	w28,	[sp, #924]

    movz	w21,	#49
    movz	w18,	#122
    mov	w3,	w15
    mov	w9,	w19
    csel	w22,	w9,	w25,	gt
    lsl	w27,	w22,	#7
    sub	w25,	w27,	w22,	lsl #0
    add	w27,	w28,	w25
    movz	w28,	#125
    movz	w25,	#65419
    movk	w25,	#65535,	lsl #16
    str	w27,	[sp, #1220]

    ldr	w22,	[sp, #300]

    mov	w27,	w21
    neg	w19,	w22
    ldr	w24,	[sp, #904]

    mov	w21,	w16
    lsl	w9,	w19,	#6
    ldr	w26,	[sp, #904]

    lsl	w15,	w24,	#3
    sub	w5,	w9,	w19,	lsl #0
    add	w23,	w15,	w26,	lsl #6
    movz	w19,	#85
    mov	w12,	w19
    str	w23,	[sp, #1208]

    ldr	w2,	[sp, #948]

    neg	w19,	w2
    lsl	w20,	w19,	#5
    sub	w10,	w20,	w19,	lsl #1
    movz	w19,	#95
    mov	w14,	w19
    str	w10,	[sp, #1188]

    ldr	w7,	[sp, #920]

    lsl	w23,	w7,	#2
    ldr	w8,	[sp, #920]

    mov	w7,	w18
    add	w15,	w23,	w8,	lsl #3
    movz	w18,	#65489
    movk	w18,	#65535,	lsl #16
    mov	w9,	w18
    str	w15,	[sp, #1192]

    mov	w15,	w28
    str	w15,	[sp, #1284]

    ldr	w0,	[sp, #964]

    neg	w26,	w0
    lsl	w28,	w26,	#0
    add	w2,	w28,	w26,	lsl #6
    str	w2,	[sp, #1164]

    str	w21,	[sp, #1116]

    ldr	w17,	[sp, #500]

    neg	w4,	w17
    movz	w17,	#83
    lsl	w2,	w4,	#5
    mov	w0,	w17
    sub	w22,	w2,	w4,	lsl #0
    movz	w2,	#11
    movz	w4,	#65513
    mov	w16,	w2
    movk	w4,	#65535,	lsl #16
    str	w22,	[sp, #1092]

    ldr	w21,	[sp, #412]

    mov	w20,	w21
    movz	w21,	#118
    str	w20,	[sp, #1156]

    str	w0,	[sp, #1088]

    mov	w0,	w25
    str	w9,	[sp, #540]

    ldr	w11,	[sp, #992]

    neg	w2,	w11
    lsl	w1,	w2,	#5
    str	w1,	[sp, #556]

    str	w14,	[sp, #1448]

    mov	w1,	w21
    str	w1,	[sp, #1268]

    ldr	w26,	[sp, #864]

    ldr	w1,	[sp, #928]

    add	w1,	w26,	w1
    str	w1,	[sp, #1420]

    str	w0,	[sp, #1468]

    ldr	w2,	[sp, #344]

    ldr	w1,	[sp, #448]

    add	w22,	w2,	w1
    ldr	w2,	[sp, #892]

    movz	w1,	#125
    ldr	w18,	[sp, #956]

    mov	w26,	w1
    add	w18,	w2,	w18
    mov	w2,	w4
    str	w2,	[sp, #360]

    ldr	w0,	[sp, #888]

    madd	w2,	w0,	w27,	w5

    ldr	w27,	[sp, #900]

    madd	w25,	w27,	w3,	w2

    ldr	w14,	[sp, #1208]

    ldr	w23,	[sp, #456]

    add	w27,	w25,	w14
    ldr	w8,	[sp, #1188]

    madd	w28,	w23,	w12,	w27

    add	w2,	w28,	w8
    ldr	w12,	[sp, #1192]

    ldr	w4,	[sp, #1164]

    ldr	w25,	[sp, #868]

    add	w28,	w2,	w12
    ldr	w6,	[sp, #1568]

    ldr	w17,	[sp, #872]

    ldr	w3,	[sp, #1116]

    add	w2,	w28,	w4
    madd	w2,	w25,	w6,	w2

    madd	w1,	w22,	w26,	w2

    ldr	w25,	[sp, #1092]

    madd	w2,	w17,	w3,	w1

    ldr	w3,	[sp, #996]

    add	w1,	w2,	w25
    ldr	w19,	[sp, #1156]

    ldr	w0,	[sp, #980]

    madd	w9,	w3,	w19,	w1

    ldr	w23,	[sp, #1088]

    madd	w11,	w0,	w23,	w9

    ldr	w23,	[sp, #460]

    madd	w22,	w23,	w7,	w11

    ldr	w1,	[sp, #876]

    madd	w15,	w1,	w16,	w22

    ldr	w3,	[sp, #360]

    madd	w16,	w18,	w3,	w15

    ldr	w1,	[sp, #988]

    ldr	w9,	[sp, #540]

    ldr	w21,	[sp, #556]

    madd	w16,	w1,	w9,	w16

    add	w18,	w16,	w21
    ldr	w21,	[sp, #1420]

    ldr	w1,	[sp, #1468]

    madd	w20,	w21,	w1,	w18

    ldr	w0,	[sp, #960]

    ldr	w13,	[sp, #1448]

    madd	w26,	w0,	w13,	w20

    ldr	w0,	[sp, #896]

    ldr	w3,	[sp, #1268]

    madd	w0,	w0,	w3,	w26

    cmp	w0,	#0
    movz	w22,	#0
    mov	w14,	w22
    csel	w1,	w14,	w0,	lt
    cmp	w0,	#127
    ldr	w26,	[sp, #136]

    movz	w28,	#127
    mov	w14,	w26
    ldr	w25,	[sp, #1220]

    mov	w13,	w28
    movz	w26,	#82
    csel	w10,	w13,	w1,	gt
    movz	w28,	#101
    mov	w20,	w26
    madd	w0,	w10,	w14,	w25

    mov	w26,	w28
    str	w0,	[sp, #976]

    movz	w10,	#65432
    ldr	w16,	[sp, #956]

    movk	w10,	#65535,	lsl #16
    ldr	w27,	[sp, #300]

    lsl	w13,	w16,	#3
    madd	w14,	w27,	w20,	w13

    mov	w20,	w10
    str	w20,	[sp, #1548]

    ldr	w2,	[sp, #888]

    ldr	w22,	[sp, #1548]

    madd	w25,	w2,	w22,	w14

    ldr	w9,	[sp, #900]

    movz	w14,	#65420
    madd	w22,	w9,	w26,	w25

    movk	w14,	#65535,	lsl #16
    mov	w12,	w14
    str	w12,	[sp, #984]

    ldr	w27,	[sp, #904]

    ldr	w13,	[sp, #984]

    madd	w27,	w27,	w13,	w22

    ldr	w5,	[sp, #456]

    neg	w9,	w5
    ldr	w19,	[sp, #948]

    lsl	w15,	w9,	#6
    ldr	w4,	[sp, #152]

    neg	w17,	w19
    ldr	w7,	[sp, #920]

    sub	w10,	w15,	w9,	lsl #0
    ldr	w8,	[sp, #448]

    lsl	w15,	w17,	#4
    ldr	w16,	[sp, #1284]

    ldr	w22,	[sp, #928]

    add	w0,	w27,	w10
    ldr	w14,	[sp, #964]

    mov	w10,	w4
    lsl	w13,	w14,	#1
    movz	w14,	#65422
    add	w21,	w0,	w15
    movk	w14,	#65535,	lsl #16
    mov	w1,	w14
    madd	w11,	w7,	w10,	w21

    madd	w26,	w8,	w16,	w11

    movz	w10,	#75
    ldr	w16,	[sp, #964]

    mov	w9,	w10
    add	w25,	w13,	w16,	lsl #6
    ldr	w6,	[sp, #868]

    madd	w28,	w22,	w9,	w26

    movz	w13,	#65435
    movz	w16,	#116
    ldr	w4,	[sp, #344]

    neg	w15,	w6
    add	w21,	w28,	w25
    movk	w13,	#65535,	lsl #16
    str	w1,	[sp, #408]

    lsl	w23,	w15,	#5
    mov	w24,	w13
    ldr	w2,	[sp, #408]

    add	w9,	w23,	w15,	lsl #6
    movz	w15,	#59
    add	w11,	w21,	w9
    ldr	w21,	[sp, #872]

    ldr	w8,	[sp, #500]

    madd	w20,	w4,	w24,	w11

    madd	w22,	w21,	w2,	w20

    mov	w21,	w15
    ldr	w2,	[sp, #996]

    madd	w12,	w8,	w21,	w22

    mov	w15,	w16
    ldr	w3,	[sp, #996]

    lsl	w26,	w2,	#2
    movz	w21,	#49
    ldr	w17,	[sp, #980]

    add	w23,	w26,	w3,	lsl #3
    lsl	w27,	w17,	#0
    ldr	w18,	[sp, #980]

    add	w26,	w27,	w18,	lsl #2
    ldr	w8,	[sp, #156]

    add	w14,	w12,	w23
    movz	w18,	#65443
    mov	w10,	w8
    ldr	w12,	[sp, #460]

    movk	w18,	#65535,	lsl #16
    ldr	w2,	[sp, #876]

    add	w0,	w14,	w26
    ldr	w1,	[sp, #892]

    ldr	w3,	[sp, #988]

    lsl	w28,	w3,	#4
    ldr	w4,	[sp, #988]

    madd	w14,	w12,	w10,	w0

    ldr	w20,	[sp, #992]

    madd	w19,	w2,	w15,	w14

    ldr	w22,	[sp, #864]

    mov	w14,	w18
    lsl	w26,	w22,	#0
    ldr	w23,	[sp, #864]

    madd	w0,	w1,	w14,	w19

    add	w26,	w26,	w23,	lsl #1
    ldr	w18,	[sp, #960]

    sub	w19,	w28,	w4,	lsl #0
    add	w0,	w0,	w19
    movz	w19,	#79
    mov	w10,	w19
    madd	w13,	w20,	w10,	w0

    add	w10,	w13,	w26
    mov	w26,	w21
    madd	w20,	w18,	w26,	w10

    ldr	w10,	[sp, #896]

    neg	w28,	w10
    lsl	w10,	w28,	#7
    sub	w13,	w10,	w28,	lsl #2
    add	w10,	w20,	w13
    cmp	w10,	#0
    movz	w22,	#0
    mov	w16,	w22
    csel	w21,	w16,	w10,	lt
    cmp	w10,	#127
    ldr	w1,	[sp, #976]

    movz	w10,	#127
    movz	w5,	#65482
    mov	w15,	w10
    movk	w5,	#65535,	lsl #16
    csel	w26,	w15,	w21,	gt
    neg	w15,	w26
    movz	w21,	#0
    lsl	w25,	w15,	#0
    movz	w26,	#38
    mov	w6,	w26
    add	w10,	w25,	w15,	lsl #1
    movz	w25,	#81
    movz	w15,	#65462
    mov	w16,	w25
    movk	w15,	#65535,	lsl #16
    add	w9,	w1,	w10
    mov	w28,	w15
    movz	w15,	#55
    str	w9,	[sp, #1480]

    ldr	w25,	[sp, #300]

    lsl	w17,	w25,	#2
    ldr	w27,	[sp, #300]

    ldr	w19,	[sp, #956]

    add	w14,	w17,	w27,	lsl #6
    ldr	w9,	[sp, #1556]

    mov	w23,	w9
    ldr	w3,	[sp, #888]

    str	w28,	[sp, #1560]

    madd	w17,	w19,	w16,	w14

    ldr	w10,	[sp, #900]

    madd	w16,	w3,	w23,	w17

    ldr	w1,	[sp, #1560]

    madd	w11,	w10,	w1,	w16

    ldr	w24,	[sp, #456]

    movz	w16,	#121
    neg	w25,	w24
    mov	w9,	w16
    lsl	w17,	w25,	#4
    sub	w20,	w17,	w25,	lsl #0
    movz	w25,	#101
    mov	w17,	w15
    mov	w24,	w25
    movz	w15,	#82
    str	w20,	[sp, #1536]

    movz	w25,	#65523
    movk	w25,	#65535,	lsl #16
    mov	w0,	w25
    str	w0,	[sp, #516]

    ldr	w0,	[sp, #928]

    neg	w19,	w0
    lsl	w1,	w19,	#6
    sub	w7,	w1,	w19,	lsl #1
    movz	w19,	#65486
    movk	w19,	#65535,	lsl #16
    str	w7,	[sp, #504]

    mov	w0,	w19
    ldr	w3,	[sp, #964]

    lsl	w2,	w3,	#6
    str	w2,	[sp, #1100]

    str	w6,	[sp, #1096]

    ldr	w14,	[sp, #1552]

    str	w14,	[sp, #1104]

    ldr	w26,	[sp, #460]

    ldr	w2,	[sp, #876]

    neg	w28,	w26
    str	w0,	[sp, #1520]

    neg	w1,	w2
    lsl	w18,	w28,	#1
    mov	w0,	w21
    ldr	w7,	[sp, #988]

    lsl	w10,	w1,	#4
    add	w6,	w18,	w28,	lsl #3
    sub	w21,	w0,	w7
    ldr	w18,	[sp, #984]

    mov	w7,	w15
    str	w18,	[sp, #548]

    str	w5,	[sp, #1452]

    str	w7,	[sp, #1292]

    ldr	w0,	[sp, #896]

    neg	w8,	w0
    lsl	w18,	w8,	#3
    add	w26,	w18,	w8,	lsl #6
    str	w26,	[sp, #1272]

    ldr	w15,	[sp, #500]

    ldr	w7,	[sp, #980]

    add	w2,	w7,	w15
    ldr	w1,	[sp, #868]

    ldr	w14,	[sp, #996]

    add	w7,	w14,	w1
    add	w5,	w2,	w21
    movz	w1,	#114
    mov	w26,	w1
    lsl	w0,	w5,	#7
    sub	w23,	w0,	w5,	lsl #4
    ldr	w0,	[sp, #904]

    madd	w25,	w0,	w9,	w11

    ldr	w13,	[sp, #1536]

    ldr	w16,	[sp, #948]

    add	w0,	w25,	w13
    madd	w1,	w16,	w17,	w0

    ldr	w17,	[sp, #920]

    ldr	w8,	[sp, #516]

    madd	w15,	w17,	w24,	w1

    ldr	w2,	[sp, #448]

    ldr	w18,	[sp, #504]

    madd	w15,	w2,	w8,	w15

    ldr	w3,	[sp, #1100]

    add	w17,	w15,	w18
    ldr	w16,	[sp, #344]

    ldr	w0,	[sp, #1096]

    add	w24,	w17,	w3
    ldr	w18,	[sp, #872]

    ldr	w9,	[sp, #1104]

    ldr	w25,	[sp, #892]

    madd	w0,	w16,	w0,	w24

    ldr	w1,	[sp, #1520]

    madd	w28,	w18,	w9,	w0

    ldr	w22,	[sp, #992]

    madd	w27,	w7,	w26,	w28

    ldr	w14,	[sp, #548]

    add	w26,	w27,	w6
    ldr	w27,	[sp, #864]

    ldr	w18,	[sp, #1452]

    add	w16,	w26,	w10
    madd	w17,	w25,	w1,	w16

    add	w19,	w17,	w23
    madd	w20,	w22,	w14,	w19

    madd	w21,	w27,	w18,	w20

    ldr	w18,	[sp, #960]

    ldr	w22,	[sp, #1292]

    madd	w22,	w18,	w22,	w21

    ldr	w5,	[sp, #1272]

    add	w16,	w22,	w5
    cmp	w16,	#0
    movz	w24,	#0
    mov	w19,	w24
    csel	w0,	w19,	w16,	lt
    cmp	w16,	#127
    movz	w28,	#65459
    movz	fp,	#1524
    movz	w17,	#55
    ldr	w10,	[sp, #1480]

    movz	w15,	#127
    movk	w28,	#65535,	lsl #16
    mov	w19,	w17
    mov	w18,	w15
    mov	w4,	w28
    csel	w9,	w18,	w0,	gt
    lsl	w11,	w9,	#5
    movz	w9,	#65446
    add	w24,	w10,	w11
    movk	w9,	#65535,	lsl #16
    mov	w16,	w9
    str	w24,	[sp, #524]

    movz	w24,	#67
    str	x4,	[sp, fp]

    mov	w17,	w24
    movz	fp,	#1524
    ldr	w1,	[sp, #300]

    ldr	x5,	[sp, fp]

    mul	w26,	w1,	w5
    str	w26,	[sp, #1128]

    movz	w1,	#65457
    str	w16,	[sp, #1504]

    movk	w1,	#65535,	lsl #16
    ldr	w27,	[sp, #904]

    mov	w25,	w1
    neg	w16,	w27
    lsl	w27,	w16,	#1
    add	w11,	w27,	w16,	lsl #2
    movz	w16,	#52
    mov	w23,	w16
    str	w11,	[sp, #1028]

    ldr	w0,	[sp, #456]

    neg	w21,	w0
    lsl	w0,	w21,	#5
    sub	w22,	w0,	w21,	lsl #1
    str	w22,	[sp, #1120]

    movz	w22,	#59
    ldr	w5,	[sp, #948]

    mov	w3,	w22
    neg	w10,	w5
    lsl	w28,	w10,	#3
    movz	w10,	#81
    str	w28,	[sp, #244]

    mov	w0,	w10
    ldr	w21,	[sp, #448]

    lsl	w26,	w21,	#1
    movz	w21,	#58
    str	w26,	[sp, #1020]

    mov	w13,	w21
    ldr	w10,	[sp, #372]

    str	w10,	[sp, #1080]

    ldr	w14,	[sp, #156]

    str	w14,	[sp, #144]

    str	w3,	[sp, #1436]

    str	w23,	[sp, #1424]

    str	w19,	[sp, #224]

    ldr	w7,	[sp, #996]

    neg	w27,	w7
    lsl	w15,	w27,	#0
    add	w8,	w15,	w27,	lsl #5
    str	w8,	[sp, #544]

    ldr	w27,	[sp, #980]

    ldr	w22,	[sp, #980]

    lsl	w20,	w27,	#4
    movz	w27,	#86
    sub	w9,	w20,	w22,	lsl #1
    mov	w28,	w27
    str	w28,	[sp, #232]

    str	w25,	[sp, #228]

    ldr	w2,	[sp, #992]

    ldr	w5,	[sp, #992]

    lsl	w26,	w2,	#4
    movz	w2,	#0
    add	w26,	w26,	w5,	lsl #5
    mov	w10,	w2
    str	w26,	[sp, #1024]

    ldr	w5,	[sp, #516]

    str	w5,	[sp, #1016]

    ldr	w16,	[sp, #960]

    ldr	w2,	[sp, #888]

    sub	w15,	w10,	w16
    ldr	w6,	[sp, #896]

    add	w27,	w6,	w2
    lsl	w2,	w27,	#1
    add	w3,	w2,	w27,	lsl #6
    str	w3,	[sp, #1492]

    ldr	w5,	[sp, #872]

    ldr	w2,	[sp, #956]

    add	w14,	w5,	w2
    add	w7,	w14,	w15
    lsl	w2,	w7,	#4
    sub	w10,	w2,	w7,	lsl #0
    ldr	w2,	[sp, #900]

    ldr	w3,	[sp, #1128]

    ldr	w1,	[sp, #1504]

    madd	w24,	w2,	w1,	w3

    ldr	w22,	[sp, #1028]

    add	w27,	w24,	w22
    ldr	w6,	[sp, #1120]

    ldr	w4,	[sp, #244]

    ldr	w7,	[sp, #920]

    add	w27,	w27,	w6
    ldr	w25,	[sp, #1020]

    ldr	w1,	[sp, #928]

    ldr	w3,	[sp, #1080]

    add	w2,	w27,	w4
    ldr	w14,	[sp, #964]

    madd	w2,	w7,	w0,	w2

    ldr	w0,	[sp, #144]

    add	w4,	w2,	w25
    ldr	w2,	[sp, #868]

    ldr	w11,	[sp, #1436]

    madd	w5,	w1,	w3,	w4

    madd	w5,	w14,	w0,	w5

    madd	w7,	w2,	w11,	w5

    ldr	w5,	[sp, #344]

    ldr	w0,	[sp, #1424]

    madd	w3,	w5,	w0,	w7

    ldr	w0,	[sp, #500]

    ldr	w26,	[sp, #224]

    madd	w3,	w0,	w26,	w3

    ldr	w18,	[sp, #544]

    add	w3,	w3,	w18
    ldr	w21,	[sp, #460]

    ldr	w0,	[sp, #876]

    add	w23,	w3,	w9
    madd	w23,	w21,	w13,	w23

    madd	w19,	w0,	w17,	w23

    ldr	w0,	[sp, #892]

    ldr	w18,	[sp, #232]

    ldr	w5,	[sp, #988]

    madd	w20,	w0,	w18,	w19

    ldr	w15,	[sp, #228]

    madd	w21,	w5,	w15,	w20

    ldr	w1,	[sp, #1024]

    ldr	w0,	[sp, #864]

    add	w21,	w21,	w1
    ldr	w26,	[sp, #1016]

    ldr	w19,	[sp, #1492]

    madd	w23,	w0,	w26,	w21

    add	w24,	w23,	w10
    add	w27,	w24,	w19
    cmp	w27,	#0
    movz	w26,	#0
    mov	w22,	w26
    csel	w14,	w22,	w27,	lt
    cmp	w27,	#127
    movz	w26,	#67
    movz	w17,	#127
    mov	w28,	w26
    mov	w21,	w17
    csel	w10,	w21,	w14,	gt
    ldr	w14,	[sp, #156]

    ldr	w24,	[sp, #524]

    mov	w21,	w14
    madd	w4,	w10,	w21,	w24

    movz	w21,	#97
    str	w4,	[sp, #1160]

    ldr	w19,	[sp, #956]

    ldr	w20,	[sp, #956]

    lsl	w22,	w19,	#0
    mov	w19,	w21
    add	w5,	w22,	w20,	lsl #5
    movz	w20,	#107
    str	w5,	[sp, #1312]

    str	w28,	[sp, #1304]

    ldr	w13,	[sp, #900]

    ldr	w0,	[sp, #900]

    lsl	w23,	w13,	#5
    ldr	w13,	[sp, #904]

    sub	w2,	w23,	w0,	lsl #1
    neg	w18,	w13
    movz	w13,	#104
    lsl	w16,	w18,	#1
    movz	w18,	#71
    str	w16,	[sp, #1488]

    mov	w12,	w18
    ldr	w23,	[sp, #948]

    ldr	w17,	[sp, #948]

    lsl	w28,	w23,	#7
    ldr	w1,	[sp, #516]

    movz	w23,	#83
    sub	w7,	w28,	w17,	lsl #3
    str	w1,	[sp, #1432]

    ldr	w10,	[sp, #448]

    ldr	w22,	[sp, #448]

    lsl	w0,	w10,	#1
    add	w5,	w0,	w22,	lsl #4
    str	w5,	[sp, #536]

    ldr	w4,	[sp, #928]

    ldr	w25,	[sp, #928]

    lsl	w14,	w4,	#0
    mov	w4,	w13
    add	w8,	w14,	w25,	lsl #2
    str	w4,	[sp, #1136]

    movz	w14,	#65417
    ldr	w10,	[sp, #344]

    movk	w14,	#65535,	lsl #16
    neg	w22,	w10
    mov	w0,	w14
    lsl	w17,	w22,	#3
    sub	w26,	w17,	w22,	lsl #0
    mov	w22,	w20
    str	w26,	[sp, #384]

    ldr	w10,	[sp, #996]

    ldr	w14,	[sp, #996]

    lsl	w25,	w10,	#3
    add	w5,	w25,	w14,	lsl #4
    movz	w25,	#46
    mov	w3,	w25
    str	w5,	[sp, #1144]

    ldr	w1,	[sp, #460]

    neg	w24,	w1
    lsl	w26,	w24,	#5
    add	w28,	w26,	w24,	lsl #6
    mov	w26,	w23
    str	w28,	[sp, #1000]

    ldr	w1,	[sp, #1548]

    str	w1,	[sp, #1152]

    ldr	w5,	[sp, #324]

    mov	w1,	w5
    str	w1,	[sp, #1132]

    str	w19,	[sp, #1140]

    str	w26,	[sp, #1148]

    movz	w26,	#65452
    str	w3,	[sp, #1364]

    movk	w26,	#65535,	lsl #16
    movz	w3,	#82
    mov	w14,	w26
    str	w14,	[sp, #1344]

    ldr	w27,	[sp, #456]

    ldr	w13,	[sp, #988]

    add	w10,	w13,	w27
    lsl	w1,	w10,	#0
    add	w4,	w1,	w10,	lsl #6
    mov	w1,	w3
    str	w4,	[sp, #1004]

    ldr	w5,	[sp, #300]

    ldr	w15,	[sp, #980]

    str	w1,	[sp, #1340]

    add	w13,	w15,	w5
    ldr	w16,	[sp, #888]

    ldr	w6,	[sp, #1304]

    ldr	w14,	[sp, #1312]

    madd	w25,	w16,	w6,	w14

    add	w26,	w25,	w2
    ldr	w2,	[sp, #1488]

    ldr	w25,	[sp, #920]

    add	w26,	w26,	w2
    ldr	w16,	[sp, #1432]

    ldr	w5,	[sp, #536]

    ldr	w3,	[sp, #964]

    add	w2,	w26,	w7
    ldr	w21,	[sp, #1136]

    madd	w1,	w25,	w16,	w2

    add	w1,	w1,	w5
    add	w4,	w1,	w8
    madd	w1,	w3,	w21,	w4

    ldr	w3,	[sp, #868]

    ldr	w2,	[sp, #384]

    madd	w0,	w3,	w0,	w1

    ldr	w3,	[sp, #872]

    add	w1,	w0,	w2
    madd	w9,	w3,	w12,	w1

    ldr	w12,	[sp, #500]

    ldr	w10,	[sp, #1144]

    madd	w11,	w12,	w22,	w9

    ldr	w1,	[sp, #1340]

    add	w27,	w11,	w10
    ldr	w12,	[sp, #1000]

    ldr	w5,	[sp, #876]

    madd	w15,	w13,	w1,	w27

    ldr	w18,	[sp, #1152]

    add	w16,	w15,	w12
    ldr	w1,	[sp, #892]

    ldr	w25,	[sp, #1132]

    ldr	w15,	[sp, #1004]

    madd	w17,	w5,	w18,	w16

    ldr	w23,	[sp, #992]

    madd	w19,	w1,	w25,	w17

    add	w20,	w19,	w15
    ldr	w15,	[sp, #1140]

    ldr	w27,	[sp, #864]

    madd	w22,	w23,	w15,	w20

    ldr	w21,	[sp, #1148]

    ldr	w20,	[sp, #960]

    madd	w23,	w27,	w21,	w22

    ldr	w27,	[sp, #1364]

    ldr	w0,	[sp, #896]

    madd	w26,	w20,	w27,	w23

    ldr	w11,	[sp, #1344]

    madd	w9,	w0,	w11,	w26

    cmp	w9,	#0
    movz	w22,	#0
    mov	w25,	w22
    csel	w23,	w25,	w9,	lt
    cmp	w9,	#127
    ldr	w2,	[sp, #1520]

    movz	fp,	#1524
    movz	w28,	#65490
    movz	w15,	#127
    movz	w25,	#65507
    movz	w18,	#38
    movz	w12,	#65463
    movz	w22,	#37
    ldr	w0,	[sp, #1160]

    mov	w17,	w2
    movk	w28,	#65535,	lsl #16
    mov	w24,	w15
    movk	w25,	#65535,	lsl #16
    mov	w6,	w18
    movk	w12,	#65535,	lsl #16
    csel	w15,	w24,	w23,	gt
    mov	w2,	w12
    mov	w23,	w25
    madd	w11,	w15,	w17,	w0

    str	w11,	[sp, #1320]

    ldr	w0,	[sp, #300]

    ldr	w9,	[sp, #300]

    lsl	w20,	w0,	#3
    ldr	w8,	[sp, #956]

    sub	w19,	w20,	w9,	lsl #0
    madd	w15,	w8,	w23,	w19

    mov	w8,	w28
    str	w15,	[sp, #2716]

    ldr	w19,	[sp, #1504]

    ldr	w7,	[sp, #948]

    mov	w21,	w19
    neg	w0,	w7
    movz	w19,	#65449
    lsl	w26,	w0,	#5
    movk	w19,	#65535,	lsl #16
    mov	w23,	w19
    str	w26,	[sp, #1584]

    movz	w26,	#53
    ldr	w1,	[sp, #448]

    mov	w19,	w26
    ldr	w0,	[sp, #448]

    lsl	w24,	w1,	#2
    add	w18,	w24,	w0,	lsl #5
    movz	w24,	#71
    mov	w20,	w24
    str	w18,	[sp, #2720]

    ldr	w13,	[sp, #356]

    str	w13,	[sp, #1348]

    str	w8,	[sp, #1276]

    ldr	w0,	[sp, #996]

    neg	w25,	w0
    mov	w0,	w22
    lsl	w15,	w25,	#1
    add	w17,	w15,	w25,	lsl #5
    str	w17,	[sp, #1472]

    str	w23,	[sp, #1456]

    ldr	w3,	[sp, #304]

    str	w3,	[sp, #528]

    str	w20,	[sp, #148]

    ldr	x8,	[sp, fp]

    str	w19,	[sp, #1288]

    mov	w25,	w8
    ldr	w9,	[sp, #180]

    str	w9,	[sp, #1496]

    ldr	w9,	[sp, #516]

    mov	w8,	w9
    str	w8,	[sp, #1356]

    ldr	w3,	[sp, #408]

    str	w3,	[sp, #1352]

    ldr	w15,	[sp, #872]

    ldr	w1,	[sp, #920]

    ldr	w3,	[sp, #992]

    add	w16,	w15,	w1
    add	w11,	w16,	w3
    str	w11,	[sp, #1388]

    str	w0,	[sp, #1428]

    ldr	w3,	[sp, #344]

    ldr	w16,	[sp, #888]

    ldr	w20,	[sp, #152]

    add	w0,	w3,	w16
    ldr	w22,	[sp, #900]

    mov	w11,	w20
    ldr	w16,	[sp, #2716]

    madd	w15,	w22,	w6,	w16

    ldr	w6,	[sp, #904]

    ldr	w22,	[sp, #1536]

    madd	w16,	w6,	w21,	w15

    ldr	w27,	[sp, #1584]

    add	w6,	w16,	w22
    ldr	w19,	[sp, #2720]

    add	w9,	w6,	w27
    ldr	w6,	[sp, #504]

    add	w4,	w9,	w19
    add	w4,	w4,	w6
    ldr	w6,	[sp, #964]

    ldr	w7,	[sp, #1348]

    ldr	w13,	[sp, #868]

    madd	w14,	w6,	w7,	w4

    ldr	w9,	[sp, #1276]

    ldr	w4,	[sp, #500]

    madd	w7,	w13,	w9,	w14

    madd	w1,	w0,	w11,	w7

    madd	w7,	w4,	w2,	w1

    ldr	w4,	[sp, #1472]

    ldr	w2,	[sp, #980]

    add	w4,	w7,	w4
    ldr	w22,	[sp, #1456]

    ldr	w1,	[sp, #460]

    madd	w12,	w2,	w22,	w4

    ldr	w28,	[sp, #528]

    ldr	w7,	[sp, #876]

    madd	w13,	w1,	w28,	w12

    ldr	w17,	[sp, #148]

    ldr	w2,	[sp, #892]

    madd	w15,	w7,	w17,	w13

    ldr	w23,	[sp, #988]

    madd	w15,	w2,	w25,	w15

    ldr	w18,	[sp, #1288]

    ldr	w4,	[sp, #1388]

    madd	w17,	w23,	w18,	w15

    ldr	w27,	[sp, #1428]

    ldr	w15,	[sp, #864]

    madd	w19,	w4,	w27,	w17

    ldr	w24,	[sp, #1496]

    ldr	w5,	[sp, #960]

    madd	w21,	w15,	w24,	w19

    ldr	w14,	[sp, #1356]

    ldr	w1,	[sp, #896]

    madd	w23,	w5,	w14,	w21

    ldr	w11,	[sp, #1352]

    madd	w12,	w1,	w11,	w23

    cmp	w12,	#0
    movz	w18,	#0
    mov	w9,	w18
    csel	w28,	w9,	w12,	lt
    cmp	w12,	#127
    movz	w15,	#41
    movz	w17,	#65444
    ldr	w0,	[sp, #360]

    movz	w19,	#75
    movz	fp,	#1524
    movz	w22,	#65485
    movz	w13,	#127
    movz	w21,	#42
    movk	w17,	#65535,	lsl #16
    ldr	w24,	[sp, #1320]

    mov	w25,	w0
    mov	w2,	w19
    movk	w22,	#65535,	lsl #16
    mov	w26,	w13
    mov	w9,	w22
    csel	w11,	w26,	w28,	gt
    movz	w26,	#22
    madd	w6,	w11,	w25,	w24

    movz	w25,	#29
    mov	w24,	w21
    str	w6,	[sp, #1256]

    mov	w6,	w15
    ldr	w10,	[sp, #300]

    ldr	w23,	[sp, #412]

    mul	w27,	w10,	w24
    ldr	w3,	[sp, #456]

    mov	w1,	w23
    mov	w10,	w17
    ldr	w7,	[sp, #456]

    lsl	w0,	w3,	#1
    ldr	x24,	[sp, fp]

    str	w24,	[sp, #1204]

    add	w11,	w0,	w7,	lsl #3
    movz	w24,	#109
    ldr	w17,	[sp, #448]

    mov	w22,	w24
    ldr	w19,	[sp, #448]

    lsl	w5,	w17,	#5
    movz	w24,	#47
    ldr	w12,	[sp, #1560]

    movz	w17,	#65414
    add	w19,	w5,	w19,	lsl #6
    mov	w15,	w24
    mov	w7,	w12
    movk	w17,	#65535,	lsl #16
    mov	w12,	w26
    mov	w23,	w17
    movz	w26,	#65487
    str	w23,	[sp, #1316]

    movk	w26,	#65535,	lsl #16
    str	w15,	[sp, #1264]

    str	w12,	[sp, #1296]

    ldr	w16,	[sp, #460]

    neg	w18,	w16
    movz	w16,	#67
    lsl	w5,	w18,	#2
    add	w12,	w5,	w18,	lsl #6
    movz	w18,	#38
    mov	w13,	w18
    mov	w18,	w25
    str	w13,	[sp, #1308]

    str	w18,	[sp, #1280]

    movz	w18,	#115
    mov	w25,	w18
    movz	w18,	#85
    str	w25,	[sp, #1408]

    mov	w21,	w18
    mov	w25,	w16
    ldr	w23,	[sp, #324]

    str	w23,	[sp, #1444]

    ldr	w14,	[sp, #864]

    ldr	w3,	[sp, #864]

    lsl	w4,	w14,	#2
    mov	w14,	w26
    add	w24,	w4,	w3,	lsl #5
    str	w24,	[sp, #1460]

    str	w14,	[sp, #1328]

    str	w21,	[sp, #1484]

    ldr	w5,	[sp, #500]

    ldr	w18,	[sp, #956]

    add	w13,	w5,	w18
    ldr	w18,	[sp, #888]

    madd	w3,	w18,	w6,	w27

    ldr	w6,	[sp, #900]

    ldr	w26,	[sp, #904]

    madd	w5,	w6,	w1,	w3

    ldr	w15,	[sp, #948]

    madd	w4,	w26,	w10,	w5

    ldr	w23,	[sp, #1204]

    add	w5,	w4,	w11
    ldr	w18,	[sp, #920]

    ldr	w3,	[sp, #928]

    madd	w15,	w15,	w23,	w5

    ldr	w14,	[sp, #964]

    madd	w1,	w18,	w2,	w15

    ldr	w23,	[sp, #868]

    add	w0,	w1,	w19
    ldr	w6,	[sp, #384]

    madd	w0,	w3,	w9,	w0

    madd	w2,	w14,	w22,	w0

    madd	w1,	w23,	w7,	w2

    ldr	w7,	[sp, #872]

    add	w2,	w1,	w6
    ldr	w26,	[sp, #1316]

    ldr	w27,	[sp, #996]

    madd	w0,	w7,	w26,	w2

    madd	w7,	w13,	w25,	w0

    ldr	w0,	[sp, #1264]

    ldr	w5,	[sp, #980]

    madd	w4,	w27,	w0,	w7

    ldr	w26,	[sp, #1296]

    ldr	w1,	[sp, #876]

    madd	w3,	w5,	w26,	w4

    ldr	w6,	[sp, #1308]

    add	w5,	w3,	w12
    ldr	w24,	[sp, #892]

    ldr	w12,	[sp, #1280]

    madd	w18,	w1,	w6,	w5

    ldr	w22,	[sp, #988]

    madd	w1,	w24,	w12,	w18

    ldr	w14,	[sp, #1408]

    ldr	w4,	[sp, #992]

    madd	w27,	w22,	w14,	w1

    ldr	w9,	[sp, #1444]

    ldr	w24,	[sp, #1460]

    madd	w16,	w4,	w9,	w27

    ldr	w6,	[sp, #960]

    add	w1,	w16,	w24
    ldr	w21,	[sp, #1328]

    ldr	w2,	[sp, #896]

    madd	w20,	w6,	w21,	w1

    ldr	w14,	[sp, #1484]

    madd	w28,	w2,	w14,	w20

    cmp	w28,	#0
    movz	w5,	#0
    csel	w3,	w5,	w28,	lt
    cmp	w28,	#127
    ldr	w7,	[sp, #1256]

    movz	w4,	#127
    csel	w25,	w4,	w3,	gt
    movz	w3,	#46
    madd	w24,	w25,	w3,	w7

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
    ldr	w3,	[sp, #496]

    sub	w4,	w3,	#1
    cmp	w4,	#0
    ble	main_617

main_36:
    str	w4,	[sp, #496]

    b	main_37

main_39:
    mov	w19,	w16
    b	main_40

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#4464
    add	sp, sp, fp
    ret


