.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #2336
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x13,	sp,	#16
    movz	fp,	#164
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
    add	x24,	x18,	#8
    add	x27,	x18,	#12
    add	x15,	x2,	#16
    str	x26,	[sp, fp]

    movz	fp,	#172
    str	x1,	[sp, fp]

    movz	fp,	#228
    str	x21,	[sp, #320]

    add	x21,	x18,	#4
    str	x6,	[sp, fp]

    add	x6,	x13,	#20
    movz	fp,	#236
    mov	x12,	x6
    str	x9,	[sp, fp]

    add	x1,	x6,	#16
    add	x26,	x6,	#12
    add	x23,	x6,	#8
    add	x20,	x6,	#4
    add	x9,	x2,	#8
    movz	fp,	#244
    add	x6,	x13,	#40
    str	x12,	[sp, fp]

    mov	x4,	x6
    movz	fp,	#188
    add	x12,	x2,	#12
    add	x28,	x6,	#16
    add	x25,	x6,	#12
    add	x22,	x6,	#8
    add	x7,	x6,	#4
    str	x20,	[sp, #384]

    add	x6,	x2,	#4
    str	x23,	[sp, #336]

    add	x2,	x18,	#16
    str	x26,	[sp, #352]

    str	x1,	[sp, #360]

    str	x4,	[sp, #368]

    str	x7,	[sp, fp]

    movz	fp,	#404
    str	x22,	[sp, fp]

    movz	fp,	#412
    str	x25,	[sp, fp]

    str	x28,	[sp, #440]

    str	x3,	[sp, #456]

    str	x6,	[sp, #464]

    str	x9,	[sp, #472]

    str	x12,	[sp, #480]

    str	x15,	[sp, #256]

    str	x18,	[sp, #264]

    str	x21,	[sp, #280]

    str	x24,	[sp, #288]

    str	x27,	[sp, #296]

    str	x2,	[sp, #304]

    str	w5,	[sp, #496]


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

    movz	fp,	#172
    mov	w19,	w15
    mov	w6,	w22
    str	w11,	[sp, #688]

    ldr	w0,	[sp, #688]

    mul	w8,	w0,	w21
    ldr	x21,	[sp, fp]

    ldr	w17,	[x21]

    movz	fp,	#228
    str	w17,	[sp, #204]

    mov	w17,	w25
    ldr	w18,	[sp, #204]

    madd	w24,	w18,	w17,	w8

    ldr	x12,	[sp, #320]

    mov	w8,	w28
    ldr	w26,	[x12]

    str	w26,	[sp, #640]

    ldr	w27,	[sp, #640]

    madd	w26,	w27,	w8,	w24

    str	w26,	[sp, #1312]

    movz	w24,	#65425
    ldr	x25,	[sp, fp]

    movz	w26,	#65430
    movk	w24,	#65535,	lsl #16
    ldr	w4,	[x25]

    movz	fp,	#236
    movk	w26,	#65535,	lsl #16
    mov	w15,	w24
    movz	w25,	#65433
    str	w4,	[sp, #652]

    movk	w25,	#65535,	lsl #16
    mov	w7,	w25
    str	w7,	[sp, #116]

    ldr	x28,	[sp, fp]

    ldr	w17,	[x28]

    movz	fp,	#244
    str	w17,	[sp, #656]

    str	w19,	[sp, #252]

    ldr	x2,	[sp, fp]

    ldr	w20,	[x2]

    movz	fp,	#188
    str	w20,	[sp, #424]

    ldr	w21,	[sp, #424]

    lsl	w12,	w21,	#6
    movz	w21,	#50
    str	w12,	[sp, #676]

    mov	w0,	w21
    ldr	x10,	[sp, #384]

    mov	w21,	w26
    ldr	w27,	[x10]

    str	w27,	[sp, #684]

    ldr	w28,	[sp, #684]

    neg	w4,	w28
    lsl	w25,	w4,	#7
    movz	w28,	#65434
    movk	w28,	#65535,	lsl #16
    sub	w9,	w25,	w4,	lsl #3
    mov	w10,	w28
    str	w9,	[sp, #156]

    ldr	x13,	[sp, #336]

    ldr	w1,	[x13]

    str	w1,	[sp, #668]

    str	w0,	[sp, #1316]

    ldr	x16,	[sp, #352]

    ldr	w3,	[x16]

    str	w3,	[sp, #488]

    str	w6,	[sp, #824]

    ldr	x19,	[sp, #360]

    ldr	w14,	[x19]

    str	w14,	[sp, #680]

    ldr	x22,	[sp, #368]

    ldr	w8,	[x22]

    str	w8,	[sp, #704]

    str	w15,	[sp, #200]

    ldr	x25,	[sp, fp]

    ldr	w19,	[x25]

    movz	fp,	#404
    str	w19,	[sp, #220]

    movz	w25,	#65469
    movz	w19,	#65497
    movk	w25,	#65535,	lsl #16
    movk	w19,	#65535,	lsl #16
    mov	w6,	w25
    mov	w16,	w19
    str	w6,	[sp, #1368]

    ldr	x11,	[sp, fp]

    ldr	w27,	[x11]

    movz	fp,	#412
    str	w27,	[sp, #196]

    movz	w27,	#65461
    str	w21,	[sp, #392]

    movk	w27,	#65535,	lsl #16
    ldr	x14,	[sp, fp]

    ldr	w2,	[x14]

    str	w2,	[sp, #632]

    mov	w14,	w27
    str	w14,	[sp, #328]

    ldr	x17,	[sp, #440]

    ldr	w22,	[x17]

    str	w22,	[sp, #508]

    str	w10,	[sp, #1372]

    ldr	x20,	[sp, #456]

    ldr	w6,	[x20]

    str	w6,	[sp, #740]

    ldr	w7,	[sp, #740]

    lsl	w0,	w7,	#1
    ldr	w8,	[sp, #740]

    add	w14,	w0,	w8,	lsl #5
    str	w14,	[sp, #1080]

    ldr	x23,	[sp, #464]

    ldr	w22,	[x23]

    str	w22,	[sp, #708]

    str	w16,	[sp, #1340]

    ldr	x26,	[sp, #472]

    ldr	w4,	[x26]

    str	w4,	[sp, #428]

    ldr	w5,	[sp, #428]

    movz	w4,	#47
    lsl	w22,	w5,	#0
    ldr	w6,	[sp, #428]

    mov	w8,	w4
    add	w26,	w22,	w6,	lsl #6
    str	w26,	[sp, #1096]

    ldr	x0,	[sp, #480]

    ldr	w14,	[x0]

    str	w14,	[sp, #636]

    ldr	x3,	[sp, #256]

    ldr	w9,	[x3]

    str	w9,	[sp, #644]

    movz	w9,	#113
    mov	w20,	w9
    str	w20,	[sp, #1088]

    movz	w9,	#110
    ldr	x6,	[sp, #264]

    mov	w2,	w9
    ldr	w7,	[x6]

    str	w7,	[sp, #712]

    str	w2,	[sp, #1064]

    ldr	x9,	[sp, #280]

    ldr	w21,	[x9]

    str	w21,	[sp, #728]

    ldr	x12,	[sp, #288]

    ldr	w5,	[x12]

    str	w5,	[sp, #208]

    ldr	w6,	[sp, #208]

    neg	w9,	w6
    lsl	w15,	w9,	#2
    str	w15,	[sp, #1276]

    ldr	x15,	[sp, #296]

    ldr	w24,	[x15]

    str	w24,	[sp, #700]

    ldr	w25,	[sp, #700]

    ldr	w13,	[sp, #700]

    lsl	w21,	w25,	#4
    add	w27,	w21,	w13,	lsl #6
    str	w27,	[sp, #1172]

    ldr	x18,	[sp, #304]

    ldr	w21,	[x18]

    str	w21,	[sp, #648]

    movz	w21,	#46
    ldr	w27,	[sp, #636]

    mov	w9,	w21
    ldr	w22,	[sp, #680]

    add	w2,	w27,	w22
    ldr	w7,	[sp, #728]

    ldr	w0,	[sp, #116]

    ldr	w6,	[sp, #652]

    add	w24,	w2,	w7
    ldr	w17,	[sp, #1312]

    madd	w5,	w6,	w0,	w17

    ldr	w14,	[sp, #252]

    ldr	w7,	[sp, #656]

    ldr	w19,	[sp, #676]

    madd	w16,	w7,	w14,	w5

    add	w25,	w16,	w19
    ldr	w16,	[sp, #156]

    ldr	w6,	[sp, #668]

    add	w28,	w25,	w16
    ldr	w22,	[sp, #1316]

    ldr	w13,	[sp, #488]

    ldr	w27,	[sp, #824]

    madd	w0,	w6,	w22,	w28

    ldr	w14,	[sp, #704]

    madd	w4,	w13,	w27,	w0

    ldr	w2,	[sp, #200]

    madd	w27,	w14,	w2,	w4

    ldr	w2,	[sp, #220]

    ldr	w1,	[sp, #1368]

    madd	w26,	w2,	w1,	w27

    ldr	w6,	[sp, #392]

    ldr	w1,	[sp, #196]

    madd	w1,	w1,	w6,	w26

    ldr	w5,	[sp, #328]

    ldr	w0,	[sp, #632]

    ldr	w2,	[sp, #508]

    madd	w6,	w0,	w5,	w1

    ldr	w1,	[sp, #1372]

    madd	w1,	w2,	w1,	w6

    ldr	w17,	[sp, #1080]

    ldr	w0,	[sp, #708]

    add	w15,	w1,	w17
    ldr	w7,	[sp, #1340]

    ldr	w1,	[sp, #1096]

    madd	w13,	w0,	w7,	w15

    ldr	w27,	[sp, #644]

    add	w14,	w13,	w1
    ldr	w5,	[sp, #1088]

    ldr	w12,	[sp, #712]

    ldr	w19,	[sp, #1064]

    madd	w20,	w27,	w5,	w14

    madd	w16,	w12,	w19,	w20

    madd	w15,	w24,	w8,	w16

    ldr	w16,	[sp, #1276]

    add	w16,	w15,	w16
    ldr	w28,	[sp, #1172]

    ldr	w6,	[sp, #648]

    add	w23,	w16,	w28
    madd	w2,	w6,	w9,	w23

    cmp	w2,	#0
    movz	w24,	#0
    mov	w26,	w24
    csel	w21,	w26,	w2,	lt
    cmp	w2,	#127
    movz	w8,	#65436
    movz	w0,	#127
    movz	w26,	#39
    movz	w6,	#65426
    movk	w8,	#65535,	lsl #16
    mov	w25,	w0
    mov	w24,	w26
    movk	w6,	#65535,	lsl #16
    csel	w16,	w25,	w21,	gt
    movz	w0,	#87
    mul	w11,	w16,	w24
    str	w11,	[sp, #1076]

    movz	w16,	#65442
    ldr	w19,	[sp, #204]

    movk	w16,	#65535,	lsl #16
    lsl	w9,	w19,	#7
    ldr	w20,	[sp, #204]

    mov	w23,	w16
    sub	w4,	w9,	w20,	lsl #1
    str	w4,	[sp, #1300]

    ldr	w28,	[sp, #640]

    mov	w4,	w0
    neg	w21,	w28
    movz	w0,	#65411
    lsl	w10,	w21,	#1
    mov	w28,	w8
    movk	w0,	#65535,	lsl #16
    add	w9,	w10,	w21,	lsl #4
    str	w9,	[sp, #976]

    movz	w9,	#47
    ldr	w19,	[sp, #656]

    mov	w25,	w9
    neg	w14,	w19
    lsl	w5,	w14,	#3
    movz	w14,	#65415
    str	w5,	[sp, #544]

    movk	w14,	#65535,	lsl #16
    str	w25,	[sp, #2152]

    mov	w26,	w14
    ldr	w15,	[sp, #684]

    neg	w18,	w15
    lsl	w21,	w18,	#2
    movz	w15,	#67
    movz	w18,	#65493
    mov	w22,	w15
    str	w21,	[sp, #120]

    movk	w18,	#65535,	lsl #16
    movz	w15,	#65515
    str	w22,	[sp, #528]

    movk	w15,	#65535,	lsl #16
    str	w26,	[sp, #380]

    mov	w26,	w15
    ldr	w11,	[sp, #704]

    movz	w15,	#29
    lsl	w24,	w11,	#3
    ldr	w12,	[sp, #704]

    mov	w14,	w15
    mov	w11,	w18
    sub	w16,	w24,	w12,	lsl #0
    str	w16,	[sp, #1152]

    str	w26,	[sp, #1356]

    ldr	w25,	[sp, #196]

    movz	w26,	#65494
    neg	w22,	w25
    movk	w26,	#65535,	lsl #16
    lsl	w25,	w22,	#6
    mov	w10,	w26
    sub	w16,	w25,	w22,	lsl #2
    movz	w25,	#105
    mov	w22,	w0
    str	w16,	[sp, #940]

    str	w11,	[sp, #920]

    mov	w16,	w25
    movz	w11,	#65514
    str	w16,	[sp, #2128]

    movk	w11,	#65535,	lsl #16
    str	w10,	[sp, #1144]

    str	w4,	[sp, #1240]

    mov	w10,	w6
    str	w14,	[sp, #1212]

    mov	w6,	w11
    str	w10,	[sp, #420]

    str	w28,	[sp, #2156]

    str	w6,	[sp, #1192]

    ldr	w12,	[sp, #328]

    mov	w11,	w12
    str	w11,	[sp, #1208]

    str	w22,	[sp, #144]

    ldr	w13,	[sp, #644]

    ldr	w0,	[sp, #652]

    add	w15,	w13,	w0
    neg	w19,	w15
    lsl	w22,	w19,	#5
    sub	w10,	w22,	w19,	lsl #0
    str	w10,	[sp, #1376]

    ldr	w25,	[sp, #636]

    ldr	w2,	[sp, #688]

    add	w18,	w25,	w2
    ldr	w9,	[sp, #392]

    mov	w20,	w9
    str	w20,	[sp, #564]

    ldr	w10,	[sp, #976]

    ldr	w6,	[sp, #1300]

    add	w12,	w10,	w6
    ldr	w5,	[sp, #544]

    ldr	w8,	[sp, #424]

    add	w0,	w12,	w5
    ldr	w12,	[sp, #2152]

    ldr	w22,	[sp, #120]

    madd	w12,	w8,	w12,	w0

    ldr	w9,	[sp, #668]

    add	w8,	w12,	w22
    ldr	w1,	[sp, #528]

    ldr	w0,	[sp, #488]

    ldr	w2,	[sp, #380]

    madd	w25,	w9,	w1,	w8

    ldr	w12,	[sp, #680]

    madd	w26,	w0,	w23,	w25

    ldr	w14,	[sp, #1152]

    madd	w1,	w12,	w2,	w26

    ldr	w9,	[sp, #220]

    add	w4,	w1,	w14
    ldr	w15,	[sp, #1356]

    ldr	w12,	[sp, #940]

    ldr	w11,	[sp, #632]

    madd	w2,	w9,	w15,	w4

    ldr	w13,	[sp, #920]

    add	w15,	w2,	w12
    ldr	w21,	[sp, #508]

    ldr	w17,	[sp, #2128]

    ldr	w4,	[sp, #740]

    madd	w5,	w11,	w13,	w15

    ldr	w19,	[sp, #1144]

    madd	w16,	w21,	w17,	w5

    ldr	w15,	[sp, #708]

    madd	w14,	w4,	w19,	w16

    ldr	w6,	[sp, #1240]

    madd	w16,	w15,	w6,	w14

    ldr	w12,	[sp, #428]

    ldr	w23,	[sp, #1212]

    madd	w16,	w12,	w23,	w16

    ldr	w25,	[sp, #564]

    madd	w15,	w18,	w25,	w16

    ldr	w25,	[sp, #1376]

    add	w16,	w15,	w25
    ldr	w26,	[sp, #420]

    ldr	w0,	[sp, #712]

    ldr	w12,	[sp, #728]

    madd	w19,	w0,	w26,	w16

    ldr	w2,	[sp, #2156]

    ldr	w7,	[sp, #208]

    madd	w9,	w12,	w2,	w19

    ldr	w20,	[sp, #1192]

    ldr	w27,	[sp, #700]

    madd	w10,	w7,	w20,	w9

    ldr	w16,	[sp, #1208]

    madd	w0,	w27,	w16,	w10

    ldr	w24,	[sp, #144]

    ldr	w7,	[sp, #648]

    madd	w0,	w7,	w24,	w0

    cmp	w0,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w9,	w9,	w0,	lt
    cmp	w0,	#127
    movz	w14,	#77
    movz	w16,	#76
    movz	w15,	#26
    movz	w19,	#127
    movz	w18,	#65466
    movz	w21,	#65441
    ldr	w0,	[sp, #1076]

    mov	w24,	w14
    mov	w22,	w15
    mov	w25,	w19
    movk	w18,	#65535,	lsl #16
    movk	w21,	#65535,	lsl #16
    mov	w15,	w16
    csel	w13,	w25,	w9,	gt
    movz	w19,	#29
    mov	w2,	w18
    mov	w5,	w21
    madd	w0,	w13,	w24,	w0

    str	w0,	[sp, #1100]

    ldr	w1,	[sp, #688]

    mul	w1,	w1,	w22
    ldr	w26,	[sp, #204]

    movz	w22,	#52
    madd	w1,	w26,	w15,	w1

    str	w2,	[sp, #184]

    mov	w14,	w22
    movz	w26,	#27
    ldr	w3,	[sp, #184]

    ldr	w18,	[sp, #640]

    madd	w2,	w18,	w3,	w1

    ldr	w7,	[sp, #652]

    mov	w18,	w19
    str	w5,	[sp, #376]

    madd	w0,	w7,	w18,	w2

    ldr	w6,	[sp, #376]

    ldr	w5,	[sp, #656]

    madd	w10,	w5,	w6,	w0

    ldr	w28,	[sp, #424]

    lsl	w24,	w28,	#5
    ldr	w0,	[sp, #424]

    ldr	w1,	[sp, #684]

    add	w19,	w24,	w0,	lsl #6
    ldr	w18,	[sp, #668]

    ldr	w15,	[sp, #488]

    ldr	w17,	[sp, #680]

    add	w0,	w10,	w19
    madd	w22,	w1,	w14,	w0

    neg	w1,	w15
    neg	w0,	w18
    lsl	w14,	w1,	#0
    lsl	w10,	w0,	#2
    add	w21,	w14,	w1,	lsl #2
    add	w18,	w10,	w0,	lsl #6
    lsl	w1,	w17,	#1
    mov	w14,	w26
    add	w25,	w22,	w18
    ldr	w18,	[sp, #680]

    add	w0,	w1,	w18,	lsl #5
    add	w24,	w25,	w21
    movz	w25,	#65498
    movk	w25,	#65535,	lsl #16
    add	w13,	w24,	w0
    mov	w22,	w25
    ldr	w0,	[sp, #704]

    neg	w10,	w0
    ldr	w27,	[sp, #220]

    lsl	w24,	w10,	#1
    ldr	w1,	[sp, #196]

    lsl	w1,	w1,	#1
    ldr	w2,	[sp, #196]

    add	w9,	w24,	w10,	lsl #5
    ldr	w5,	[sp, #632]

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

    ldr	w0,	[sp, #508]

    madd	w1,	w0,	w14,	w22

    ldr	w10,	[sp, #740]

    mov	w14,	w9
    ldr	w0,	[sp, #708]

    madd	w21,	w10,	w14,	w1

    ldr	w8,	[sp, #428]

    movz	w10,	#116
    movz	w14,	#65437
    movk	w14,	#65535,	lsl #16
    madd	w1,	w0,	w10,	w21

    ldr	w0,	[sp, #636]

    madd	w16,	w8,	w16,	w1

    neg	w17,	w0
    ldr	w12,	[sp, #644]

    lsl	w0,	w17,	#6
    ldr	w10,	[sp, #712]

    ldr	w11,	[sp, #712]

    lsl	w1,	w10,	#0
    sub	w15,	w0,	w17,	lsl #0
    add	w27,	w1,	w11,	lsl #6
    ldr	w0,	[sp, #728]

    lsl	w26,	w0,	#7
    add	w28,	w16,	w15
    ldr	w0,	[sp, #728]

    movz	w15,	#94
    sub	w0,	w26,	w0,	lsl #3
    mov	w16,	w15
    madd	w21,	w12,	w14,	w28

    add	w10,	w21,	w27
    ldr	w27,	[sp, #1340]

    ldr	w8,	[sp, #208]

    add	w9,	w10,	w0
    ldr	w21,	[sp, #700]

    mov	w0,	w27
    neg	w1,	w21
    lsl	w10,	w1,	#1
    madd	w13,	w8,	w0,	w9

    add	w19,	w10,	w1,	lsl #2
    ldr	w0,	[sp, #648]

    add	w17,	w13,	w19
    madd	w1,	w0,	w16,	w17

    cmp	w1,	#0
    movz	w16,	#0
    mov	w10,	w16
    csel	w26,	w10,	w1,	lt
    cmp	w1,	#127
    movz	w25,	#125
    movz	w15,	#50
    ldr	w1,	[sp, #1100]

    movz	w19,	#127
    movz	w18,	#85
    movz	w21,	#49
    movz	w3,	#65419
    mov	w16,	w25
    mov	w17,	w15
    mov	w9,	w19
    mov	w10,	w21
    movk	w3,	#65535,	lsl #16
    movz	w25,	#11
    csel	w22,	w9,	w26,	gt
    lsl	w26,	w22,	#7
    sub	w0,	w26,	w22,	lsl #0
    add	w6,	w1,	w0
    str	w6,	[sp, #904]

    ldr	w22,	[sp, #204]

    neg	w23,	w22
    lsl	w9,	w23,	#6
    sub	w28,	w9,	w23,	lsl #0
    mov	w9,	w25
    str	w28,	[sp, #2324]

    ldr	w21,	[sp, #656]

    movz	w28,	#118
    lsl	w13,	w21,	#3
    ldr	w22,	[sp, #656]

    add	w2,	w13,	w22,	lsl #6
    mov	w13,	w18
    str	w2,	[sp, #892]

    ldr	w2,	[sp, #684]

    neg	w14,	w2
    lsl	w15,	w14,	#5
    sub	w21,	w15,	w14,	lsl #1
    movz	w14,	#110
    mov	w1,	w14
    str	w21,	[sp, #872]

    movz	w14,	#65489
    ldr	w5,	[sp, #668]

    movk	w14,	#65535,	lsl #16
    lsl	w23,	w5,	#2
    ldr	w6,	[sp, #668]

    add	w24,	w23,	w6,	lsl #3
    str	w24,	[sp, #876]

    str	w16,	[sp, #1044]

    ldr	w0,	[sp, #704]

    movz	w16,	#122
    neg	w18,	w0
    lsl	w19,	w18,	#0
    mov	w0,	w3
    add	w15,	w19,	w18,	lsl #6
    movz	w19,	#125
    str	w15,	[sp, #984]

    str	w1,	[sp, #1116]

    movz	w15,	#83
    ldr	w12,	[sp, #508]

    mov	w5,	w15
    neg	w21,	w12
    mov	w15,	w19
    lsl	w22,	w21,	#5
    sub	w8,	w22,	w21,	lsl #0
    mov	w21,	w14
    movz	w22,	#95
    str	w8,	[sp, #1000]

    mov	w8,	w22
    ldr	w12,	[sp, #252]

    mov	w2,	w12
    str	w2,	[sp, #768]

    mov	w12,	w16
    str	w5,	[sp, #772]

    str	w12,	[sp, #2200]

    str	w9,	[sp, #332]

    str	w21,	[sp, #1224]

    ldr	w27,	[sp, #728]

    neg	w27,	w27
    lsl	w7,	w27,	#5
    mov	w27,	w28
    str	w7,	[sp, #1140]

    str	w8,	[sp, #548]

    str	w27,	[sp, #1292]

    ldr	w8,	[sp, #208]

    ldr	w1,	[sp, #680]

    add	w9,	w8,	w1
    str	w9,	[sp, #1196]

    str	w0,	[sp, #1256]

    ldr	w1,	[sp, #196]

    ldr	w0,	[sp, #488]

    add	w4,	w1,	w0
    ldr	w23,	[sp, #644]

    movz	w1,	#65513
    ldr	w0,	[sp, #688]

    movk	w1,	#65535,	lsl #16
    add	w21,	w23,	w0
    mov	w3,	w1
    str	w3,	[sp, #180]

    ldr	w7,	[sp, #640]

    ldr	w14,	[sp, #2324]

    ldr	w6,	[sp, #652]

    madd	w18,	w7,	w10,	w14

    ldr	w0,	[sp, #892]

    madd	w11,	w6,	w17,	w18

    ldr	w7,	[sp, #424]

    add	w1,	w11,	w0
    ldr	w19,	[sp, #872]

    ldr	w22,	[sp, #876]

    madd	w9,	w7,	w13,	w1

    ldr	w11,	[sp, #984]

    add	w10,	w9,	w19
    ldr	w3,	[sp, #220]

    ldr	w14,	[sp, #1368]

    ldr	w18,	[sp, #632]

    add	w5,	w10,	w22
    ldr	w26,	[sp, #1116]

    add	w17,	w5,	w11
    madd	w1,	w3,	w14,	w17

    madd	w9,	w4,	w15,	w1

    ldr	w1,	[sp, #1000]

    madd	w28,	w18,	w26,	w9

    ldr	w17,	[sp, #740]

    add	w4,	w28,	w1
    ldr	w0,	[sp, #768]

    madd	w3,	w17,	w0,	w4

    ldr	w0,	[sp, #708]

    ldr	w6,	[sp, #772]

    madd	w5,	w0,	w6,	w3

    ldr	w11,	[sp, #428]

    ldr	w1,	[sp, #2200]

    madd	w18,	w11,	w1,	w5

    ldr	w22,	[sp, #636]

    ldr	w0,	[sp, #332]

    madd	w15,	w22,	w0,	w18

    ldr	w3,	[sp, #180]

    madd	w16,	w21,	w3,	w15

    ldr	w1,	[sp, #712]

    ldr	w0,	[sp, #1224]

    ldr	w5,	[sp, #1140]

    madd	w13,	w1,	w0,	w16

    ldr	w8,	[sp, #1196]

    add	w14,	w13,	w5
    ldr	w13,	[sp, #1256]

    ldr	w0,	[sp, #700]

    madd	w15,	w8,	w13,	w14

    ldr	w24,	[sp, #548]

    ldr	w25,	[sp, #648]

    madd	w21,	w0,	w24,	w15

    ldr	w8,	[sp, #1292]

    madd	w3,	w25,	w8,	w21

    cmp	w3,	#0
    movz	w21,	#0
    mov	w14,	w21
    csel	w0,	w14,	w3,	lt
    cmp	w3,	#127
    ldr	w24,	[sp, #392]

    movz	w28,	#127
    movz	w10,	#65432
    movz	w26,	#101
    mov	w23,	w24
    ldr	w7,	[sp, #904]

    mov	w13,	w28
    movk	w10,	#65535,	lsl #16
    movz	w24,	#82
    csel	w15,	w13,	w0,	gt
    mov	w19,	w24
    mov	w0,	w10
    madd	w3,	w15,	w23,	w7

    mov	w24,	w26
    str	w3,	[sp, #1104]

    ldr	w16,	[sp, #688]

    lsl	w13,	w16,	#3
    ldr	w23,	[sp, #204]

    str	w0,	[sp, #1352]

    madd	w14,	w23,	w19,	w13

    ldr	w2,	[sp, #640]

    ldr	w19,	[sp, #1352]

    ldr	w9,	[sp, #652]

    madd	w2,	w2,	w19,	w14

    movz	w14,	#65420
    movz	w19,	#79
    madd	w18,	w9,	w24,	w2

    movk	w14,	#65535,	lsl #16
    mov	w26,	w14
    str	w26,	[sp, #848]

    ldr	w28,	[sp, #656]

    ldr	w5,	[sp, #848]

    madd	w21,	w28,	w5,	w18

    ldr	w5,	[sp, #424]

    ldr	w18,	[sp, #684]

    neg	w9,	w5
    neg	w16,	w18
    ldr	w4,	[sp, #184]

    lsl	w14,	w9,	#6
    ldr	w7,	[sp, #668]

    ldr	w8,	[sp, #488]

    sub	w10,	w14,	w9,	lsl #0
    ldr	w1,	[sp, #1044]

    lsl	w14,	w16,	#4
    ldr	w25,	[sp, #680]

    movz	w16,	#116
    add	w24,	w21,	w10
    mov	w10,	w4
    add	w2,	w24,	w14
    ldr	w14,	[sp, #704]

    lsl	w13,	w14,	#1
    madd	w15,	w7,	w10,	w2

    movz	w14,	#65422
    madd	w1,	w8,	w1,	w15

    movz	w10,	#75
    movk	w14,	#65535,	lsl #16
    ldr	w15,	[sp, #704]

    mov	w9,	w10
    add	w0,	w13,	w15,	lsl #6
    ldr	w6,	[sp, #220]

    madd	w24,	w25,	w9,	w1

    movz	w13,	#65435
    neg	w15,	w6
    ldr	w4,	[sp, #196]

    mov	w1,	w14
    add	w18,	w24,	w0
    movk	w13,	#65535,	lsl #16
    lsl	w26,	w15,	#5
    str	w1,	[sp, #132]

    mov	w24,	w13
    ldr	w2,	[sp, #132]

    add	w9,	w26,	w15,	lsl #6
    movz	w15,	#59
    mov	w21,	w15
    add	w18,	w18,	w9
    mov	w15,	w16
    madd	w5,	w4,	w24,	w18

    ldr	w24,	[sp, #632]

    movz	w18,	#65443
    madd	w26,	w24,	w2,	w5

    ldr	w8,	[sp, #508]

    movk	w18,	#65535,	lsl #16
    madd	w10,	w8,	w21,	w26

    ldr	w2,	[sp, #740]

    ldr	w4,	[sp, #740]

    lsl	w0,	w2,	#2
    ldr	w21,	[sp, #708]

    add	w27,	w0,	w4,	lsl #3
    ldr	w24,	[sp, #708]

    lsl	w0,	w21,	#0
    ldr	w7,	[sp, #376]

    movz	w21,	#49
    mov	w9,	w7
    add	w14,	w10,	w27
    add	w0,	w0,	w24,	lsl #2
    ldr	w10,	[sp, #428]

    ldr	w2,	[sp, #636]

    add	w26,	w14,	w0
    mov	w14,	w18
    ldr	w0,	[sp, #644]

    madd	w13,	w10,	w9,	w26

    madd	w25,	w2,	w15,	w13

    mov	w10,	w19
    ldr	w2,	[sp, #712]

    madd	w25,	w0,	w14,	w25

    ldr	w6,	[sp, #712]

    lsl	w0,	w2,	#4
    sub	w18,	w0,	w6,	lsl #0
    add	w1,	w25,	w18
    ldr	w25,	[sp, #728]

    ldr	w26,	[sp, #208]

    madd	w13,	w25,	w10,	w1

    lsl	w0,	w26,	#0
    ldr	w28,	[sp, #208]

    mov	w26,	w21
    ldr	w22,	[sp, #700]

    add	w0,	w0,	w28,	lsl #1
    add	w10,	w13,	w0
    madd	w18,	w22,	w26,	w10

    ldr	w10,	[sp, #648]

    neg	w1,	w10
    lsl	w10,	w1,	#7
    sub	w13,	w10,	w1,	lsl #2
    add	w10,	w18,	w13
    cmp	w10,	#0
    movz	w22,	#0
    mov	w16,	w22
    csel	w23,	w16,	w10,	lt
    cmp	w10,	#127
    movz	w25,	#81
    ldr	w7,	[sp, #1104]

    movz	w20,	#65462
    movz	w10,	#127
    movz	w1,	#65482
    mov	w5,	w25
    movk	w20,	#65535,	lsl #16
    mov	w15,	w10
    movk	w1,	#65535,	lsl #16
    mov	w6,	w20
    csel	w26,	w15,	w23,	gt
    neg	w15,	w26
    lsl	w24,	w15,	#0
    add	w9,	w24,	w15,	lsl #1
    add	w7,	w7,	w9
    str	w7,	[sp, #1304]

    ldr	w24,	[sp, #204]

    ldr	w0,	[sp, #204]

    lsl	w16,	w24,	#2
    ldr	w22,	[sp, #688]

    add	w14,	w16,	w0,	lsl #6
    movz	w16,	#121
    mov	w2,	w16
    madd	w15,	w22,	w5,	w14

    ldr	w22,	[sp, #1372]

    mov	w0,	w22
    ldr	w3,	[sp, #640]

    movz	w22,	#101
    madd	w14,	w3,	w0,	w15

    str	w6,	[sp, #1360]

    mov	w19,	w22
    ldr	w10,	[sp, #652]

    movz	w22,	#38
    ldr	w0,	[sp, #1360]

    mov	w18,	w22
    ldr	w21,	[sp, #424]

    madd	w13,	w10,	w0,	w14

    neg	w26,	w21
    movz	w14,	#55
    lsl	w16,	w26,	#4
    movz	w21,	#65523
    movk	w21,	#65535,	lsl #16
    sub	w12,	w16,	w26,	lsl #0
    mov	w25,	w21
    str	w12,	[sp, #1336]

    mov	w12,	w14
    str	w19,	[sp, #2144]

    mov	w14,	w1
    str	w25,	[sp, #316]

    ldr	w0,	[sp, #680]

    neg	w10,	w0
    lsl	w26,	w10,	#6
    sub	w7,	w26,	w10,	lsl #1
    movz	w10,	#65486
    movk	w10,	#65535,	lsl #16
    str	w7,	[sp, #128]

    ldr	w3,	[sp, #704]

    str	w18,	[sp, #1020]

    lsl	w19,	w3,	#6
    ldr	w28,	[sp, #1356]

    mov	w3,	w10
    mov	w21,	w28
    str	w21,	[sp, #1024]

    ldr	w28,	[sp, #428]

    neg	w0,	w28
    lsl	w16,	w0,	#1
    add	w18,	w16,	w0,	lsl #3
    movz	w16,	#0
    mov	w0,	w16
    str	w18,	[sp, #1280]

    ldr	w28,	[sp, #636]

    neg	w22,	w28
    lsl	w21,	w22,	#4
    str	w21,	[sp, #2220]

    str	w3,	[sp, #1320]

    ldr	w23,	[sp, #712]

    ldr	w24,	[sp, #848]

    sub	w5,	w0,	w23
    mov	w4,	w24
    str	w4,	[sp, #1260]

    str	w14,	[sp, #556]

    movz	w14,	#82
    mov	w27,	w14
    str	w27,	[sp, #1232]

    ldr	w23,	[sp, #648]

    neg	w17,	w23
    lsl	w6,	w17,	#3
    add	w16,	w6,	w17,	lsl #6
    str	w16,	[sp, #520]

    ldr	w26,	[sp, #508]

    ldr	w3,	[sp, #708]

    add	w28,	w3,	w26
    ldr	w1,	[sp, #220]

    ldr	w8,	[sp, #740]

    add	w3,	w8,	w1
    ldr	w22,	[sp, #656]

    add	w18,	w28,	w5
    movz	w1,	#114
    madd	w22,	w22,	w2,	w13

    mov	w27,	w1
    ldr	w1,	[sp, #1336]

    lsl	w11,	w18,	#7
    add	w21,	w22,	w1
    ldr	w22,	[sp, #684]

    sub	w16,	w11,	w18,	lsl #4
    ldr	w8,	[sp, #668]

    madd	w0,	w22,	w12,	w21

    ldr	w25,	[sp, #2144]

    madd	w18,	w8,	w25,	w0

    ldr	w1,	[sp, #316]

    ldr	w6,	[sp, #488]

    madd	w0,	w6,	w1,	w18

    ldr	w11,	[sp, #128]

    add	w10,	w0,	w11
    ldr	w2,	[sp, #196]

    ldr	w9,	[sp, #1020]

    ldr	w0,	[sp, #632]

    add	w6,	w10,	w19
    ldr	w12,	[sp, #1024]

    madd	w6,	w2,	w9,	w6

    madd	w28,	w0,	w12,	w6

    ldr	w0,	[sp, #1280]

    madd	w13,	w3,	w27,	w28

    ldr	w3,	[sp, #2220]

    add	w10,	w13,	w0
    ldr	w1,	[sp, #644]

    ldr	w0,	[sp, #1320]

    add	w19,	w10,	w3
    ldr	w22,	[sp, #728]

    ldr	w11,	[sp, #1260]

    ldr	w28,	[sp, #208]

    madd	w15,	w1,	w0,	w19

    ldr	w25,	[sp, #556]

    add	w16,	w15,	w16
    madd	w18,	w22,	w11,	w16

    madd	w19,	w28,	w25,	w18

    ldr	w18,	[sp, #700]

    ldr	w0,	[sp, #1232]

    madd	w21,	w18,	w0,	w19

    ldr	w15,	[sp, #520]

    add	w17,	w21,	w15
    cmp	w17,	#0
    movz	w24,	#0
    mov	w19,	w24
    csel	w0,	w19,	w17,	lt
    cmp	w17,	#127
    movz	w26,	#65459
    movz	w3,	#67
    movz	w13,	#65457
    movz	fp,	#1324
    movz	w16,	#127
    movk	w26,	#65535,	lsl #16
    movk	w13,	#65535,	lsl #16
    mov	w18,	w16
    mov	w7,	w26
    csel	w9,	w18,	w0,	gt
    lsl	w10,	w9,	#5
    ldr	w9,	[sp, #1304]

    add	w12,	w9,	w10
    movz	w9,	#65446
    movk	w9,	#65535,	lsl #16
    str	w12,	[sp, #980]

    mov	w22,	w9
    str	x7,	[sp, fp]

    movz	w9,	#52
    ldr	w0,	[sp, #204]

    movz	fp,	#1324
    mov	w15,	w9
    ldr	x8,	[sp, fp]

    mul	w17,	w0,	w8
    str	w17,	[sp, #224]

    str	w22,	[sp, #1308]

    ldr	w25,	[sp, #656]

    neg	w16,	w25
    lsl	w24,	w16,	#1
    add	w11,	w24,	w16,	lsl #2
    movz	w16,	#59
    mov	w25,	w16
    str	w11,	[sp, #1132]

    ldr	w28,	[sp, #424]

    neg	w19,	w28
    lsl	w26,	w19,	#5
    sub	w14,	w26,	w19,	lsl #1
    str	w14,	[sp, #1136]

    ldr	w5,	[sp, #684]

    neg	w10,	w5
    lsl	w26,	w10,	#3
    movz	w5,	#86
    movz	w10,	#81
    mov	w24,	w10
    str	w24,	[sp, #1028]

    movz	w10,	#55
    ldr	w19,	[sp, #488]

    mov	w24,	w5
    lsl	w4,	w19,	#1
    mov	w5,	w13
    mov	w19,	w10
    str	w4,	[sp, #1120]

    movz	w4,	#0
    ldr	w21,	[sp, #420]

    mov	w13,	w4
    mov	w20,	w21
    str	w20,	[sp, #952]

    ldr	w11,	[sp, #376]

    str	w15,	[sp, #124]

    mov	w1,	w11
    str	w19,	[sp, #1048]

    ldr	w21,	[sp, #740]

    neg	w20,	w21
    lsl	w14,	w20,	#0
    add	w27,	w14,	w20,	lsl #5
    str	w27,	[sp, #2100]

    ldr	w18,	[sp, #708]

    lsl	w17,	w18,	#4
    ldr	w11,	[sp, #708]

    movz	w18,	#58
    sub	w28,	w17,	w11,	lsl #1
    mov	w12,	w18
    str	w28,	[sp, #536]

    str	w12,	[sp, #788]

    str	w3,	[sp, #1188]

    str	w24,	[sp, #1228]

    str	w5,	[sp, #1200]

    ldr	w21,	[sp, #728]

    lsl	w12,	w21,	#4
    ldr	w19,	[sp, #728]

    add	w24,	w12,	w19,	lsl #5
    str	w24,	[sp, #2096]

    ldr	w0,	[sp, #316]

    mov	w18,	w0
    str	w18,	[sp, #744]

    ldr	w18,	[sp, #700]

    sub	w0,	w13,	w18
    ldr	w17,	[sp, #640]

    ldr	w27,	[sp, #648]

    add	w16,	w27,	w17
    lsl	w8,	w16,	#1
    add	w12,	w8,	w16,	lsl #6
    str	w12,	[sp, #1272]

    ldr	w16,	[sp, #632]

    ldr	w7,	[sp, #688]

    add	w8,	w16,	w7
    add	w24,	w8,	w0
    lsl	w18,	w24,	#4
    sub	w11,	w18,	w24,	lsl #0
    str	w11,	[sp, #552]

    ldr	w3,	[sp, #652]

    ldr	w18,	[sp, #224]

    ldr	w0,	[sp, #1308]

    ldr	w5,	[sp, #1132]

    madd	w6,	w3,	w0,	w18

    ldr	w8,	[sp, #1136]

    add	w4,	w6,	w5
    ldr	w3,	[sp, #668]

    ldr	w17,	[sp, #1028]

    add	w5,	w4,	w8
    ldr	w27,	[sp, #1120]

    ldr	w23,	[sp, #680]

    ldr	w14,	[sp, #952]

    add	w19,	w5,	w26
    ldr	w26,	[sp, #704]

    ldr	w16,	[sp, #220]

    madd	w24,	w3,	w17,	w19

    add	w7,	w24,	w27
    ldr	w3,	[sp, #196]

    ldr	w9,	[sp, #124]

    ldr	w11,	[sp, #508]

    madd	w19,	w23,	w14,	w7

    ldr	w2,	[sp, #1048]

    madd	w19,	w26,	w1,	w19

    ldr	w10,	[sp, #2100]

    madd	w24,	w16,	w25,	w19

    ldr	w0,	[sp, #536]

    madd	w26,	w3,	w9,	w24

    ldr	w6,	[sp, #428]

    madd	w21,	w11,	w2,	w26

    ldr	w23,	[sp, #788]

    add	w1,	w21,	w10
    ldr	w26,	[sp, #636]

    ldr	w7,	[sp, #1188]

    ldr	w19,	[sp, #644]

    add	w3,	w1,	w0
    ldr	w1,	[sp, #1228]

    madd	w24,	w6,	w23,	w3

    madd	w24,	w26,	w7,	w24

    madd	w22,	w19,	w1,	w24

    ldr	w1,	[sp, #712]

    ldr	w10,	[sp, #1200]

    madd	w24,	w1,	w10,	w22

    ldr	w6,	[sp, #2096]

    add	w19,	w24,	w6
    ldr	w0,	[sp, #208]

    ldr	w9,	[sp, #744]

    ldr	w11,	[sp, #552]

    madd	w21,	w0,	w9,	w19

    ldr	w13,	[sp, #1272]

    add	w22,	w21,	w11
    add	w0,	w22,	w13
    cmp	w0,	#0
    movz	w24,	#0
    mov	w25,	w24
    csel	w14,	w25,	w0,	lt
    cmp	w0,	#127
    ldr	w18,	[sp, #376]

    movz	w20,	#104
    movz	w21,	#127
    ldr	w8,	[sp, #980]

    mov	w24,	w18
    mov	w26,	w21
    csel	w10,	w26,	w14,	gt
    movz	w26,	#67
    madd	w2,	w10,	w24,	w8

    mov	w25,	w26
    str	w2,	[sp, #808]

    movz	w2,	#71
    ldr	w19,	[sp, #688]

    mov	w10,	w2
    ldr	w7,	[sp, #688]

    lsl	w21,	w19,	#0
    add	w5,	w21,	w7,	lsl #5
    str	w5,	[sp, #1068]

    str	w25,	[sp, #1056]

    ldr	w12,	[sp, #652]

    ldr	w0,	[sp, #652]

    lsl	w22,	w12,	#5
    sub	w24,	w22,	w0,	lsl #1
    str	w24,	[sp, #1288]

    ldr	w26,	[sp, #656]

    neg	w24,	w26
    lsl	w26,	w24,	#1
    str	w26,	[sp, #1252]

    ldr	w6,	[sp, #684]

    ldr	w22,	[sp, #684]

    lsl	w25,	w6,	#7
    sub	w24,	w25,	w22,	lsl #3
    str	w24,	[sp, #1168]

    movz	w24,	#65417
    ldr	w14,	[sp, #316]

    movk	w24,	#65535,	lsl #16
    mov	w18,	w14
    mov	w7,	w24
    movz	w14,	#46
    str	w18,	[sp, #1220]

    mov	w8,	w14
    ldr	w11,	[sp, #488]

    ldr	w21,	[sp, #488]

    lsl	w0,	w11,	#1
    add	w1,	w0,	w21,	lsl #4
    str	w1,	[sp, #2104]

    ldr	w9,	[sp, #680]

    ldr	w3,	[sp, #680]

    lsl	w0,	w9,	#0
    add	w4,	w0,	w3,	lsl #2
    movz	w0,	#107
    mov	w13,	w0
    str	w4,	[sp, #2108]

    ldr	w4,	[sp, #196]

    neg	w25,	w4
    lsl	w4,	w25,	#3
    sub	w19,	w4,	w25,	lsl #0
    str	w19,	[sp, #312]

    movz	w19,	#97
    ldr	w27,	[sp, #740]

    ldr	w5,	[sp, #740]

    lsl	w21,	w27,	#3
    add	w11,	w21,	w5,	lsl #4
    str	w11,	[sp, #828]

    mov	w11,	w19
    ldr	w0,	[sp, #428]

    movz	w19,	#65452
    neg	w9,	w0
    movk	w19,	#65535,	lsl #16
    lsl	w22,	w9,	#5
    mov	w6,	w19
    add	w21,	w22,	w9,	lsl #6
    str	w21,	[sp, #748]

    movz	w21,	#83
    ldr	w24,	[sp, #1352]

    str	w24,	[sp, #752]

    ldr	w27,	[sp, #380]

    mov	w23,	w27
    mov	w27,	w21
    str	w23,	[sp, #956]

    str	w11,	[sp, #1004]

    str	w27,	[sp, #1112]

    str	w8,	[sp, #1128]

    str	w6,	[sp, #972]

    ldr	w11,	[sp, #424]

    ldr	w0,	[sp, #712]

    add	w19,	w0,	w11
    movz	w0,	#82
    mov	w3,	w0
    lsl	w6,	w19,	#0
    add	w27,	w6,	w19,	lsl #6
    str	w27,	[sp, #756]

    ldr	w16,	[sp, #204]

    ldr	w6,	[sp, #708]

    add	w14,	w6,	w16
    str	w14,	[sp, #1008]

    str	w3,	[sp, #968]

    ldr	w19,	[sp, #640]

    ldr	w26,	[sp, #1056]

    ldr	w8,	[sp, #1068]

    ldr	w27,	[sp, #1288]

    madd	w3,	w19,	w26,	w8

    ldr	w28,	[sp, #1252]

    add	w4,	w3,	w27
    ldr	w24,	[sp, #1168]

    ldr	w22,	[sp, #668]

    add	w4,	w4,	w28
    ldr	w15,	[sp, #1220]

    ldr	w12,	[sp, #2104]

    add	w6,	w4,	w24
    madd	w3,	w22,	w15,	w6

    ldr	w15,	[sp, #2108]

    add	w3,	w3,	w12
    ldr	w0,	[sp, #704]

    ldr	w17,	[sp, #220]

    add	w2,	w3,	w15
    madd	w28,	w0,	w20,	w2

    madd	w25,	w17,	w7,	w28

    ldr	w0,	[sp, #312]

    ldr	w23,	[sp, #632]

    add	w26,	w25,	w0
    ldr	w0,	[sp, #508]

    ldr	w3,	[sp, #828]

    madd	w9,	w23,	w10,	w26

    ldr	w7,	[sp, #1008]

    madd	w10,	w0,	w13,	w9

    ldr	w1,	[sp, #968]

    add	w13,	w10,	w3
    madd	w14,	w7,	w1,	w13

    ldr	w13,	[sp, #748]

    ldr	w5,	[sp, #636]

    add	w15,	w14,	w13
    ldr	w21,	[sp, #752]

    ldr	w1,	[sp, #644]

    madd	w16,	w5,	w21,	w15

    ldr	w22,	[sp, #956]

    ldr	w24,	[sp, #756]

    madd	w18,	w1,	w22,	w16

    ldr	w26,	[sp, #728]

    add	w19,	w18,	w24
    ldr	w3,	[sp, #1004]

    ldr	w0,	[sp, #208]

    madd	w21,	w26,	w3,	w19

    ldr	w22,	[sp, #1112]

    ldr	w20,	[sp, #700]

    madd	w22,	w0,	w22,	w21

    ldr	w2,	[sp, #1128]

    ldr	w13,	[sp, #648]

    madd	w24,	w20,	w2,	w22

    ldr	w2,	[sp, #972]

    madd	w9,	w13,	w2,	w24

    cmp	w9,	#0
    movz	w22,	#0
    mov	w0,	w22
    csel	w21,	w0,	w9,	lt
    cmp	w9,	#127
    movz	w23,	#71
    movz	fp,	#1324
    movz	w3,	#37
    movz	w25,	#65507
    ldr	w9,	[sp, #1320]

    movz	w15,	#127
    mov	w6,	w3
    movk	w25,	#65535,	lsl #16
    ldr	w2,	[sp, #808]

    mov	w24,	w15
    mov	w0,	w25
    csel	w13,	w24,	w21,	gt
    mov	w21,	w9
    madd	w17,	w13,	w21,	w2

    str	w17,	[sp, #1084]

    ldr	w2,	[sp, #204]

    ldr	w11,	[sp, #204]

    lsl	w19,	w2,	#3
    ldr	w10,	[sp, #688]

    sub	w18,	w19,	w11,	lsl #0
    ldr	w24,	[sp, #1308]

    ldr	w5,	[sp, #684]

    mov	w22,	w24
    neg	w25,	w5
    madd	w16,	w10,	w0,	w18

    movz	w18,	#38
    mov	w4,	w18
    lsl	w18,	w25,	#5
    str	w18,	[sp, #1400]

    ldr	w26,	[sp, #488]

    ldr	w0,	[sp, #488]

    lsl	w21,	w26,	#2
    add	w18,	w21,	w0,	lsl #5
    str	w18,	[sp, #2216]

    ldr	w13,	[sp, #144]

    mov	w26,	w13
    str	w26,	[sp, #960]

    movz	w26,	#65490
    movk	w26,	#65535,	lsl #16
    mov	w10,	w26
    str	w10,	[sp, #1036]

    movz	w10,	#65463
    movk	w10,	#65535,	lsl #16
    mov	w1,	w10
    str	w1,	[sp, #1296]

    ldr	w8,	[sp, #740]

    neg	w13,	w8
    mov	w8,	w23
    lsl	w15,	w13,	#1
    add	w17,	w15,	w13,	lsl #5
    movz	w13,	#65449
    movk	w13,	#65535,	lsl #16
    str	w17,	[sp, #560]

    mov	w2,	w13
    str	w2,	[sp, #540]

    ldr	w10,	[sp, #328]

    mov	w1,	w10
    str	w1,	[sp, #1236]

    str	w8,	[sp, #1204]

    movz	w8,	#53
    ldr	x9,	[sp, fp]

    mov	w19,	w8
    mov	w7,	w9
    str	w7,	[sp, #1404]

    str	w19,	[sp, #524]

    ldr	w5,	[sp, #116]

    mov	w10,	w5
    str	w10,	[sp, #2112]

    ldr	w8,	[sp, #316]

    mov	w0,	w8
    str	w0,	[sp, #964]

    ldr	w25,	[sp, #132]

    mov	w13,	w25
    str	w13,	[sp, #2124]

    ldr	w8,	[sp, #632]

    ldr	w5,	[sp, #668]

    ldr	w17,	[sp, #728]

    add	w26,	w8,	w5
    add	w13,	w26,	w17
    str	w13,	[sp, #1148]

    str	w6,	[sp, #1264]

    ldr	w7,	[sp, #196]

    ldr	w2,	[sp, #640]

    ldr	w10,	[sp, #184]

    add	w26,	w7,	w2
    ldr	w5,	[sp, #652]

    mov	w3,	w10
    madd	w21,	w5,	w4,	w16

    ldr	w16,	[sp, #656]

    ldr	w18,	[sp, #1336]

    madd	w19,	w16,	w22,	w21

    add	w4,	w19,	w18
    ldr	w19,	[sp, #1400]

    ldr	w0,	[sp, #2216]

    add	w4,	w4,	w19
    ldr	w2,	[sp, #128]

    ldr	w8,	[sp, #704]

    ldr	w20,	[sp, #960]

    add	w17,	w4,	w0
    ldr	w4,	[sp, #220]

    ldr	w12,	[sp, #1036]

    add	w23,	w17,	w2
    ldr	w10,	[sp, #508]

    ldr	w15,	[sp, #1296]

    ldr	w22,	[sp, #560]

    madd	w6,	w8,	w20,	w23

    ldr	w7,	[sp, #708]

    madd	w18,	w4,	w12,	w6

    ldr	w17,	[sp, #540]

    madd	w6,	w26,	w3,	w18

    ldr	w23,	[sp, #428]

    madd	w9,	w10,	w15,	w6

    ldr	w3,	[sp, #1236]

    add	w10,	w9,	w22
    ldr	w8,	[sp, #636]

    ldr	w13,	[sp, #1204]

    ldr	w6,	[sp, #644]

    madd	w9,	w7,	w17,	w10

    ldr	w12,	[sp, #1404]

    madd	w16,	w23,	w3,	w9

    ldr	w3,	[sp, #712]

    madd	w23,	w8,	w13,	w16

    ldr	w0,	[sp, #524]

    madd	w14,	w6,	w12,	w23

    ldr	w16,	[sp, #1148]

    madd	w10,	w3,	w0,	w14

    ldr	w24,	[sp, #1264]

    ldr	w14,	[sp, #208]

    madd	w0,	w16,	w24,	w10

    ldr	w25,	[sp, #2112]

    ldr	w22,	[sp, #700]

    madd	w14,	w14,	w25,	w0

    ldr	w28,	[sp, #964]

    madd	w23,	w22,	w28,	w14

    ldr	w14,	[sp, #648]

    ldr	w28,	[sp, #2124]

    madd	w15,	w14,	w28,	w23

    cmp	w15,	#0
    movz	w18,	#0
    mov	w9,	w18
    csel	w24,	w9,	w15,	lt
    cmp	w15,	#127
    ldr	w0,	[sp, #180]

    movz	w13,	#127
    movz	w21,	#42
    movz	w27,	#85
    movz	fp,	#1324
    movz	w16,	#41
    ldr	w18,	[sp, #1084]

    mov	w26,	w13
    mov	w17,	w16
    mov	w13,	w27
    csel	w14,	w26,	w24,	gt
    movz	w16,	#65444
    mov	w24,	w21
    madd	w19,	w14,	w0,	w18

    movk	w16,	#65535,	lsl #16
    str	w19,	[sp, #944]

    mov	w5,	w16
    ldr	w10,	[sp, #204]

    movz	w16,	#75
    mul	w24,	w10,	w24
    str	w24,	[sp, #2224]

    ldr	w22,	[sp, #252]

    str	w5,	[sp, #2164]

    mov	w14,	w22
    ldr	w1,	[sp, #424]

    ldr	w2,	[sp, #424]

    lsl	w0,	w1,	#1
    ldr	x10,	[sp, fp]

    add	w0,	w0,	w2,	lsl #3
    mov	w28,	w10
    mov	w2,	w16
    str	w28,	[sp, #888]

    movz	w16,	#65485
    str	w2,	[sp, #2160]

    movk	w16,	#65535,	lsl #16
    ldr	w8,	[sp, #488]

    mov	w6,	w16
    ldr	w10,	[sp, #488]

    lsl	w26,	w8,	#5
    movz	w16,	#109
    mov	w5,	w16
    add	w15,	w26,	w10,	lsl #6
    movz	w16,	#47
    movz	w10,	#65414
    mov	w22,	w16
    movk	w10,	#65535,	lsl #16
    movz	w16,	#22
    str	w15,	[sp, #1396]

    mov	w9,	w10
    mov	w28,	w16
    movz	w15,	#115
    str	w5,	[sp, #1332]

    movz	w16,	#29
    mov	w19,	w15
    ldr	w3,	[sp, #1360]

    mov	w23,	w16
    mov	w2,	w3
    str	w2,	[sp, #2140]

    str	w9,	[sp, #1268]

    str	w22,	[sp, #2148]

    str	w28,	[sp, #1060]

    movz	w28,	#65487
    ldr	w10,	[sp, #428]

    movk	w28,	#65535,	lsl #16
    neg	w21,	w10
    lsl	w10,	w21,	#2
    add	w8,	w10,	w21,	lsl #6
    movz	w10,	#38
    mov	w21,	w10
    str	w8,	[sp, #1072]

    movz	w10,	#67
    str	w21,	[sp, #1284]

    str	w23,	[sp, #1092]

    mov	w23,	w28
    str	w19,	[sp, #1156]

    ldr	w4,	[sp, #380]

    mov	w25,	w4
    str	w25,	[sp, #532]

    ldr	w20,	[sp, #208]

    ldr	w26,	[sp, #208]

    lsl	w18,	w20,	#2
    mov	w20,	w10
    add	w22,	w18,	w26,	lsl #5
    str	w22,	[sp, #1052]

    str	w23,	[sp, #1248]

    str	w13,	[sp, #1040]

    ldr	w1,	[sp, #508]

    ldr	w13,	[sp, #688]

    ldr	w28,	[sp, #640]

    add	w15,	w1,	w13
    ldr	w9,	[sp, #2224]

    ldr	w12,	[sp, #652]

    madd	w25,	w28,	w17,	w9

    ldr	w5,	[sp, #656]

    madd	w3,	w12,	w14,	w25

    ldr	w12,	[sp, #2164]

    ldr	w25,	[sp, #684]

    madd	w14,	w5,	w12,	w3

    add	w10,	w14,	w0
    ldr	w0,	[sp, #888]

    ldr	w13,	[sp, #668]

    madd	w10,	w25,	w0,	w10

    ldr	w5,	[sp, #2160]

    ldr	w16,	[sp, #1396]

    madd	w5,	w13,	w5,	w10

    ldr	w3,	[sp, #680]

    add	w26,	w5,	w16
    ldr	w12,	[sp, #704]

    ldr	w8,	[sp, #1332]

    madd	w0,	w3,	w6,	w26

    madd	w16,	w12,	w8,	w0

    ldr	w0,	[sp, #220]

    ldr	w4,	[sp, #2140]

    ldr	w6,	[sp, #312]

    madd	w23,	w0,	w4,	w16

    ldr	w22,	[sp, #632]

    add	w0,	w23,	w6
    ldr	w10,	[sp, #1268]

    ldr	w19,	[sp, #740]

    madd	w23,	w22,	w10,	w0

    ldr	w0,	[sp, #2148]

    madd	w6,	w15,	w20,	w23

    ldr	w5,	[sp, #708]

    madd	w1,	w19,	w0,	w6

    ldr	w2,	[sp, #1060]

    ldr	w9,	[sp, #1072]

    madd	w15,	w5,	w2,	w1

    ldr	w24,	[sp, #636]

    add	w0,	w15,	w9
    ldr	w22,	[sp, #1284]

    ldr	w19,	[sp, #644]

    madd	w16,	w24,	w22,	w0

    ldr	w0,	[sp, #1092]

    madd	w1,	w19,	w0,	w16

    ldr	w19,	[sp, #712]

    ldr	w17,	[sp, #1156]

    ldr	w4,	[sp, #728]

    madd	w28,	w19,	w17,	w1

    ldr	w0,	[sp, #532]

    ldr	w23,	[sp, #1052]

    madd	w14,	w4,	w0,	w28

    ldr	w6,	[sp, #700]

    add	w1,	w14,	w23
    ldr	w28,	[sp, #1248]

    ldr	w2,	[sp, #648]

    madd	w27,	w6,	w28,	w1

    ldr	w20,	[sp, #1040]

    madd	w10,	w2,	w20,	w27

    cmp	w10,	#0
    movz	w0,	#0
    mov	w5,	w0
    csel	w3,	w5,	w10,	lt
    cmp	w10,	#127
    ldr	w20,	[sp, #944]

    movz	w2,	#46
    movz	w9,	#127
    mov	w4,	w9
    csel	w8,	w4,	w3,	gt
    mov	w3,	w2
    madd	w24,	w8,	w3,	w20

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
    ldr	w6,	[sp, #496]

    sub	w17,	w6,	#1
    cmp	w17,	#0
    ble	main_617

main_36:
    mov	w7,	w17
    str	w7,	[sp, #496]

    b	main_37

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #2336
    ret


