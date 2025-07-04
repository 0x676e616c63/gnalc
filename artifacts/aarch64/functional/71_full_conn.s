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
    sub	sp, sp, #3568
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    ble	main_617

main_4:
    add	x11,	sp,	#16
    movz	fp,	#228
    mov	w3,	w0
    mov	x14,	x11
    add	x7,	x14,	#16
    add	x19,	x14,	#8
    add	x6,	x11,	#60
    add	x10,	x11,	#20
    add	x16,	x11,	#80
    add	x1,	x14,	#4
    mov	x4,	x14
    add	x13,	x6,	#16
    add	x28,	x10,	#16
    add	x22,	x10,	#8
    add	x26,	x10,	#12
    add	x23,	x16,	#8
    str	x4,	[sp, fp]

    movz	fp,	#388
    add	x4,	x14,	#12
    str	x1,	[sp, #296]

    mov	x1,	x6
    str	x19,	[sp, #264]

    add	x19,	x10,	#4
    str	x4,	[sp, #240]

    add	x4,	x6,	#4
    str	x7,	[sp, #152]

    add	x7,	x11,	#40
    str	x10,	[sp, #160]

    mov	x2,	x7
    add	x10,	x6,	#12
    str	x19,	[sp, #416]

    add	x27,	x7,	#16
    add	x24,	x7,	#12
    add	x20,	x7,	#8
    add	x5,	x7,	#4
    str	x22,	[sp, #424]

    add	x7,	x6,	#8
    str	x26,	[sp, #432]

    add	x26,	x16,	#12
    str	x28,	[sp, #280]

    add	x28,	x16,	#16
    str	x2,	[sp, #288]

    str	x5,	[sp, #304]

    str	x20,	[sp, #248]

    add	x20,	x16,	#4
    str	x24,	[sp, fp]

    movz	fp,	#404
    str	x27,	[sp, fp]

    movz	fp,	#316
    str	x1,	[sp, #352]

    str	x4,	[sp, #360]

    str	x7,	[sp, #368]

    str	x10,	[sp, #376]

    str	x13,	[sp, fp]

    movz	fp,	#324
    str	x16,	[sp, fp]

    movz	fp,	#332
    str	x20,	[sp, fp]

    movz	fp,	#340
    str	x23,	[sp, fp]

    str	x26,	[sp, #176]

    str	x28,	[sp, #184]

    str	w3,	[sp, #508]


main_37:
    movz	w25,	#0
    mov	w22,	w25

main_40:
    lsl	w7,	w22,	#2
    movz	w2,	#0
    mov	w26,	w2
    add	w11,	w7,	w22,	lsl #4
    mov	x23,	x11
    add	x23,	sp,	x23
    add	x23,	x23,	#16

main_43:
    cmp	w26,	#5
    blt	main_46

main_50:
    add	w13,	w22,	#1
    cmp	w13,	#5
    bge	main_53

main_39:
    mov	w22,	w13
    b	main_40

main_53:
    movz	fp,	#228
    movz	w21,	#85
    movz	w17,	#23
    movz	w28,	#65454
    movz	w23,	#65477
    ldr	x18,	[sp, fp]

    movk	w28,	#65535,	lsl #16
    movk	w23,	#65535,	lsl #16
    ldr	w11,	[x18]

    movz	fp,	#388
    mov	w10,	w28
    mov	w9,	w23
    str	w11,	[sp, #592]

    ldr	w0,	[sp, #592]

    ldr	x22,	[sp, #296]

    mul	w4,	w0,	w21
    ldr	w18,	[x22]

    str	w18,	[sp, #348]

    ldr	w20,	[sp, #348]

    madd	w17,	w20,	w17,	w4

    ldr	x13,	[sp, #264]

    ldr	w27,	[x13]

    str	w27,	[sp, #540]

    ldr	w0,	[sp, #540]

    madd	w6,	w0,	w10,	w17

    str	w6,	[sp, #1224]

    ldr	x25,	[sp, #240]

    ldr	w4,	[x25]

    movz	w25,	#65433
    str	w4,	[sp, #552]

    movk	w25,	#65535,	lsl #16
    mov	w7,	w25
    str	w7,	[sp, #116]

    ldr	x28,	[sp, #152]

    ldr	w17,	[x28]

    str	w17,	[sp, #560]

    movz	w17,	#65413
    movk	w17,	#65535,	lsl #16
    mov	w19,	w17
    str	w19,	[sp, #272]

    ldr	x2,	[sp, #160]

    ldr	w20,	[x2]

    str	w20,	[sp, #192]

    movz	w2,	#65461
    ldr	w21,	[sp, #192]

    movz	w20,	#50
    movk	w2,	#65535,	lsl #16
    lsl	w28,	w21,	#6
    mov	w25,	w20
    str	w28,	[sp, #1216]

    ldr	x10,	[sp, #416]

    ldr	w27,	[x10]

    str	w27,	[sp, #580]

    ldr	w28,	[sp, #580]

    neg	w1,	w28
    lsl	w27,	w1,	#7
    sub	w19,	w27,	w1,	lsl #3
    str	w19,	[sp, #1204]

    ldr	x13,	[sp, #424]

    ldr	w1,	[x13]

    str	w1,	[sp, #564]

    str	w25,	[sp, #1212]

    movz	w1,	#65430
    ldr	x19,	[sp, #432]

    movk	w1,	#65535,	lsl #16
    ldr	w3,	[x19]

    mov	w27,	w1
    str	w3,	[sp, #504]

    str	w9,	[sp, #1228]

    ldr	x25,	[sp, #280]

    ldr	w20,	[x25]

    str	w20,	[sp, #568]

    movz	w25,	#65425
    ldr	x28,	[sp, #288]

    movk	w25,	#65535,	lsl #16
    ldr	w14,	[x28]

    mov	w22,	w25
    str	w14,	[sp, #608]

    movz	w25,	#65497
    str	w22,	[sp, #1208]

    movk	w25,	#65535,	lsl #16
    ldr	x5,	[sp, #304]

    mov	w0,	w25
    ldr	w28,	[x5]

    str	w28,	[sp, #528]

    movz	w28,	#65469
    movk	w28,	#65535,	lsl #16
    mov	w19,	w28
    str	w19,	[sp, #1280]

    ldr	x20,	[sp, #248]

    ldr	w5,	[x20]

    str	w5,	[sp, #312]

    mov	w20,	w2
    str	w27,	[sp, #168]

    ldr	x23,	[sp, fp]

    ldr	w7,	[x23]

    movz	fp,	#404
    str	w7,	[sp, #532]

    str	w20,	[sp, #412]

    ldr	x26,	[sp, fp]

    movz	fp,	#316
    ldr	w3,	[x26]

    str	w3,	[sp, #520]

    movz	w3,	#65434
    movk	w3,	#65535,	lsl #16
    mov	w23,	w3
    str	w23,	[sp, #1284]

    ldr	x1,	[sp, #352]

    ldr	w12,	[x1]

    str	w12,	[sp, #636]

    ldr	w16,	[sp, #636]

    lsl	w3,	w16,	#1
    ldr	w17,	[sp, #636]

    add	w1,	w3,	w17,	lsl #5
    str	w1,	[sp, #452]

    ldr	x2,	[sp, #360]

    ldr	w3,	[x2]

    str	w3,	[sp, #620]

    str	w0,	[sp, #1252]

    ldr	x3,	[sp, #368]

    ldr	w10,	[x3]

    str	w10,	[sp, #448]

    ldr	w11,	[sp, #448]

    ldr	w13,	[sp, #448]

    lsl	w3,	w11,	#0
    movz	w11,	#113
    add	w10,	w3,	w13,	lsl #6
    mov	w7,	w11
    movz	w13,	#110
    mov	w21,	w13
    str	w10,	[sp, #220]

    ldr	x3,	[sp, #376]

    ldr	w23,	[x3]

    str	w23,	[sp, #536]

    ldr	x9,	[sp, fp]

    ldr	w18,	[x9]

    movz	fp,	#324
    str	w18,	[sp, #544]

    str	w7,	[sp, #140]

    ldr	x18,	[sp, fp]

    ldr	w19,	[x18]

    movz	fp,	#332
    str	w19,	[sp, #624]

    str	w21,	[sp, #672]

    ldr	x21,	[sp, fp]

    ldr	w5,	[x21]

    movz	fp,	#340
    str	w5,	[sp, #628]

    ldr	x24,	[sp, fp]

    ldr	w14,	[x24]

    str	w14,	[sp, #524]

    ldr	w18,	[sp, #524]

    neg	w19,	w18
    lsl	w28,	w19,	#2
    str	w28,	[sp, #956]

    ldr	x2,	[sp, #176]

    ldr	w3,	[x2]

    movz	w2,	#46
    str	w3,	[sp, #604]

    mov	w8,	w2
    ldr	w5,	[sp, #604]

    lsl	w5,	w5,	#4
    ldr	w27,	[sp, #604]

    add	w7,	w5,	w27,	lsl #6
    str	w7,	[sp, #852]

    ldr	x6,	[sp, #184]

    ldr	w5,	[x6]

    str	w5,	[sp, #548]

    ldr	w20,	[sp, #536]

    movz	w5,	#47
    ldr	w14,	[sp, #568]

    mov	w27,	w5
    add	w9,	w20,	w14
    ldr	w23,	[sp, #628]

    add	w7,	w9,	w23
    str	w7,	[sp, #1864]

    ldr	w14,	[sp, #116]

    ldr	w22,	[sp, #552]

    ldr	w3,	[sp, #1224]

    madd	w26,	w22,	w14,	w3

    ldr	w11,	[sp, #272]

    ldr	w3,	[sp, #560]

    madd	w3,	w3,	w11,	w26

    ldr	w1,	[sp, #1216]

    ldr	w18,	[sp, #1204]

    add	w10,	w3,	w1
    ldr	w23,	[sp, #564]

    ldr	w28,	[sp, #1212]

    add	w3,	w10,	w18
    ldr	w5,	[sp, #504]

    ldr	w13,	[sp, #1228]

    ldr	w4,	[sp, #608]

    madd	w2,	w23,	w28,	w3

    ldr	w24,	[sp, #1208]

    madd	w19,	w5,	w13,	w2

    ldr	w0,	[sp, #528]

    madd	w2,	w4,	w24,	w19

    ldr	w26,	[sp, #1280]

    ldr	w9,	[sp, #168]

    madd	w21,	w0,	w26,	w2

    ldr	w6,	[sp, #312]

    madd	w3,	w6,	w9,	w21

    ldr	w1,	[sp, #412]

    ldr	w4,	[sp, #532]

    madd	w22,	w4,	w1,	w3

    ldr	w0,	[sp, #520]

    ldr	w3,	[sp, #1284]

    madd	w2,	w0,	w3,	w22

    ldr	w28,	[sp, #452]

    ldr	w14,	[sp, #620]

    add	w18,	w2,	w28
    ldr	w0,	[sp, #1252]

    ldr	w4,	[sp, #220]

    madd	w20,	w14,	w0,	w18

    ldr	w24,	[sp, #544]

    add	w0,	w20,	w4
    ldr	w3,	[sp, #140]

    ldr	w1,	[sp, #624]

    ldr	w20,	[sp, #672]

    madd	w3,	w24,	w3,	w0

    madd	w19,	w1,	w20,	w3

    ldr	w0,	[sp, #1864]

    madd	w28,	w0,	w27,	w19

    ldr	w12,	[sp, #956]

    ldr	w15,	[sp, #852]

    add	w12,	w28,	w12
    ldr	w6,	[sp, #548]

    add	w17,	w12,	w15
    madd	w17,	w6,	w8,	w17

    cmp	w17,	#0
    movz	w23,	#0
    mov	w24,	w23
    csel	w14,	w24,	w17,	lt
    cmp	w17,	#127
    movz	w10,	#65494
    movz	w6,	#65515
    movz	w26,	#65415
    movz	w25,	#127
    movz	w18,	#67
    movz	w0,	#87
    movz	w11,	#65514
    movk	w10,	#65535,	lsl #16
    movk	w6,	#65535,	lsl #16
    movk	w26,	#65535,	lsl #16
    mov	w23,	w25
    movk	w11,	#65535,	lsl #16
    csel	w9,	w23,	w14,	gt
    movz	w25,	#39
    mov	w14,	w6
    mov	w21,	w25
    mul	w9,	w9,	w21
    str	w9,	[sp, #1008]

    ldr	w19,	[sp, #348]

    lsl	w12,	w19,	#7
    ldr	w21,	[sp, #348]

    ldr	w13,	[sp, #540]

    sub	w8,	w12,	w21,	lsl #1
    neg	w27,	w13
    lsl	w15,	w27,	#1
    add	w5,	w15,	w27,	lsl #4
    movz	w27,	#47
    mov	w2,	w27
    str	w5,	[sp, #964]

    ldr	w4,	[sp, #560]

    neg	w19,	w4
    lsl	w16,	w19,	#3
    str	w16,	[sp, #944]

    str	w2,	[sp, #928]

    mov	w2,	w26
    ldr	w19,	[sp, #580]

    neg	w22,	w19
    movz	w19,	#65442
    lsl	w5,	w22,	#2
    movk	w19,	#65535,	lsl #16
    mov	w22,	w18
    mov	w15,	w19
    str	w22,	[sp, #872]

    mov	w19,	w10
    str	w15,	[sp, #692]

    str	w2,	[sp, #384]

    ldr	w4,	[sp, #608]

    lsl	w2,	w4,	#3
    ldr	w1,	[sp, #608]

    sub	w26,	w2,	w1,	lsl #0
    movz	w2,	#65493
    movz	w1,	#65426
    movk	w2,	#65535,	lsl #16
    movk	w1,	#65535,	lsl #16
    str	w26,	[sp, #828]

    mov	w12,	w2
    mov	w20,	w1
    str	w14,	[sp, #1268]

    movz	w2,	#105
    ldr	w4,	[sp, #312]

    neg	w9,	w4
    str	w12,	[sp, #1184]

    lsl	w17,	w9,	#6
    str	w2,	[sp, #1056]

    mov	w2,	w0
    sub	w4,	w17,	w9,	lsl #2
    str	w2,	[sp, #1172]

    movz	w2,	#29
    mov	w3,	w2
    str	w3,	[sp, #1168]

    movz	w2,	#65436
    str	w20,	[sp, #128]

    movk	w2,	#65535,	lsl #16
    mov	w20,	w11
    mov	w27,	w2
    movz	w11,	#65411
    ldr	w2,	[sp, #412]

    movk	w11,	#65535,	lsl #16
    mov	w15,	w2
    mov	w0,	w11
    str	w0,	[sp, #120]

    ldr	w1,	[sp, #544]

    ldr	w0,	[sp, #552]

    add	w11,	w1,	w0
    neg	w17,	w11
    ldr	w0,	[sp, #536]

    lsl	w11,	w17,	#5
    ldr	w28,	[sp, #592]

    add	w1,	w0,	w28
    ldr	w16,	[sp, #168]

    sub	w2,	w11,	w17,	lsl #0
    str	w16,	[sp, #472]

    ldr	w12,	[sp, #964]

    add	w10,	w12,	w8
    ldr	w14,	[sp, #944]

    ldr	w0,	[sp, #192]

    ldr	w11,	[sp, #928]

    add	w10,	w10,	w14
    ldr	w24,	[sp, #564]

    ldr	w13,	[sp, #872]

    ldr	w25,	[sp, #504]

    madd	w0,	w0,	w11,	w10

    add	w8,	w0,	w5
    madd	w16,	w24,	w13,	w8

    ldr	w24,	[sp, #692]

    madd	w10,	w25,	w24,	w16

    ldr	w22,	[sp, #384]

    ldr	w11,	[sp, #568]

    ldr	w9,	[sp, #828]

    madd	w11,	w11,	w22,	w10

    ldr	w16,	[sp, #528]

    add	w0,	w11,	w9
    ldr	w9,	[sp, #1268]

    ldr	w8,	[sp, #532]

    madd	w0,	w16,	w9,	w0

    ldr	w11,	[sp, #1184]

    add	w21,	w0,	w4
    ldr	w28,	[sp, #520]

    ldr	w9,	[sp, #1056]

    ldr	w5,	[sp, #636]

    madd	w16,	w8,	w11,	w21

    ldr	w14,	[sp, #620]

    madd	w13,	w28,	w9,	w16

    ldr	w0,	[sp, #1172]

    madd	w12,	w5,	w19,	w13

    ldr	w11,	[sp, #448]

    madd	w17,	w14,	w0,	w12

    ldr	w8,	[sp, #1168]

    ldr	w21,	[sp, #472]

    madd	w8,	w11,	w8,	w17

    ldr	w3,	[sp, #128]

    madd	w1,	w1,	w21,	w8

    ldr	w0,	[sp, #624]

    add	w19,	w1,	w2
    madd	w18,	w0,	w3,	w19

    ldr	w0,	[sp, #628]

    madd	w16,	w0,	w27,	w18

    ldr	w5,	[sp, #524]

    ldr	w18,	[sp, #604]

    madd	w13,	w5,	w20,	w16

    ldr	w26,	[sp, #120]

    madd	w17,	w18,	w15,	w13

    ldr	w7,	[sp, #548]

    madd	w0,	w7,	w26,	w17

    cmp	w0,	#0
    movz	w9,	#0
    mov	w8,	w9
    csel	w21,	w8,	w0,	lt
    cmp	w0,	#127
    movz	w17,	#65466
    movz	w12,	#127
    ldr	w14,	[sp, #1008]

    movz	w15,	#76
    movz	w13,	#77
    movz	w18,	#29
    movz	w24,	#65498
    movk	w17,	#65535,	lsl #16
    mov	w23,	w12
    movk	w24,	#65535,	lsl #16
    mov	w2,	w17
    csel	w0,	w23,	w21,	gt
    mov	w21,	w13
    madd	w13,	w0,	w21,	w14

    movz	w14,	#26
    movz	w21,	#52
    str	w13,	[sp, #1196]

    mov	w20,	w14
    mov	w12,	w21
    ldr	w1,	[sp, #592]

    mov	w13,	w15
    mul	w20,	w1,	w20
    ldr	w25,	[sp, #348]

    str	w2,	[sp, #260]

    madd	w23,	w25,	w13,	w20

    ldr	w3,	[sp, #260]

    movz	w20,	#65441
    ldr	w15,	[sp, #540]

    movk	w20,	#65535,	lsl #16
    madd	w25,	w15,	w3,	w23

    ldr	w7,	[sp, #552]

    mov	w5,	w20
    mov	w15,	w18
    movz	w23,	#102
    str	w5,	[sp, #224]

    madd	w25,	w7,	w15,	w25

    ldr	w7,	[sp, #224]

    ldr	w5,	[sp, #560]

    madd	w22,	w5,	w7,	w25

    ldr	w25,	[sp, #192]

    lsl	w15,	w25,	#5
    ldr	w27,	[sp, #192]

    ldr	w1,	[sp, #580]

    add	w26,	w15,	w27,	lsl #6
    ldr	w21,	[sp, #564]

    ldr	w15,	[sp, #504]

    neg	w25,	w21
    neg	w28,	w15
    lsl	w9,	w25,	#2
    add	w8,	w22,	w26
    lsl	w13,	w28,	#0
    add	w14,	w13,	w28,	lsl #2
    madd	w17,	w1,	w12,	w8

    add	w12,	w9,	w25,	lsl #6
    add	w21,	w17,	w12
    ldr	w17,	[sp, #568]

    lsl	w0,	w17,	#1
    ldr	w18,	[sp, #568]

    add	w22,	w21,	w14
    add	w17,	w0,	w18,	lsl #5
    ldr	w0,	[sp, #608]

    neg	w9,	w0
    add	w28,	w22,	w17
    lsl	w18,	w9,	#1
    add	w20,	w18,	w9,	lsl #5
    movz	w9,	#116
    add	w21,	w28,	w20
    ldr	w28,	[sp, #528]

    mov	w20,	w24
    ldr	w1,	[sp, #312]

    madd	w15,	w28,	w23,	w21

    lsl	w25,	w1,	#1
    ldr	w2,	[sp, #312]

    ldr	w5,	[sp, #532]

    add	w8,	w25,	w2,	lsl #2
    ldr	w0,	[sp, #520]

    movz	w25,	#27
    ldr	w10,	[sp, #636]

    mov	w12,	w25
    add	w13,	w15,	w8
    movz	w8,	#110
    mov	w17,	w8
    madd	w20,	w5,	w20,	w13

    mov	w8,	w9
    madd	w27,	w0,	w12,	w20

    movz	w13,	#65437
    ldr	w0,	[sp, #620]

    madd	w21,	w10,	w17,	w27

    movz	w12,	#39
    movk	w13,	#65535,	lsl #16
    madd	w23,	w0,	w8,	w21

    mov	w25,	w12
    ldr	w8,	[sp, #448]

    madd	w11,	w8,	w25,	w23

    ldr	w0,	[sp, #536]

    mov	w23,	w13
    neg	w17,	w0
    ldr	w12,	[sp, #544]

    lsl	w26,	w17,	#6
    ldr	w10,	[sp, #624]

    sub	w8,	w26,	w17,	lsl #0
    lsl	w0,	w10,	#0
    add	w1,	w11,	w8
    ldr	w11,	[sp, #624]

    add	w14,	w0,	w11,	lsl #6
    ldr	w26,	[sp, #628]

    madd	w18,	w12,	w23,	w1

    lsl	w17,	w26,	#7
    ldr	w28,	[sp, #628]

    add	w21,	w18,	w14
    sub	w17,	w17,	w28,	lsl #3
    ldr	w2,	[sp, #1252]

    movz	w14,	#94
    mov	w15,	w2
    ldr	w8,	[sp, #524]

    add	w23,	w21,	w17
    madd	w28,	w8,	w15,	w23

    ldr	w15,	[sp, #604]

    neg	w23,	w15
    lsl	w9,	w23,	#1
    add	w23,	w9,	w23,	lsl #2
    add	w13,	w28,	w23
    ldr	w28,	[sp, #548]

    madd	w16,	w28,	w14,	w13

    cmp	w16,	#0
    movz	w15,	#0
    mov	w9,	w15
    csel	w18,	w9,	w16,	lt
    cmp	w16,	#127
    ldr	w14,	[sp, #1196]

    movz	w25,	#50
    movz	w4,	#11
    movz	w3,	#118
    movz	w22,	#127
    mov	w13,	w25
    mov	w8,	w22
    csel	w15,	w8,	w18,	gt
    lsl	w26,	w15,	#7
    sub	w19,	w26,	w15,	lsl #0
    movz	w26,	#85
    mov	w2,	w26
    add	w18,	w14,	w19
    movz	w26,	#95
    str	w18,	[sp, #744]

    movz	w18,	#49
    ldr	w22,	[sp, #348]

    mov	w5,	w18
    neg	w19,	w22
    lsl	w8,	w19,	#6
    movz	w22,	#65513
    movk	w22,	#65535,	lsl #16
    sub	w21,	w8,	w19,	lsl #0
    str	w21,	[sp, #748]

    str	w13,	[sp, #728]

    ldr	w23,	[sp, #560]

    movz	w13,	#110
    ldr	w25,	[sp, #560]

    lsl	w19,	w23,	#3
    add	w11,	w19,	w25,	lsl #6
    movz	w19,	#125
    str	w11,	[sp, #732]

    ldr	w7,	[sp, #580]

    ldr	w10,	[sp, #564]

    neg	w20,	w7
    ldr	w11,	[sp, #564]

    mov	w7,	w19
    lsl	w17,	w20,	#5
    sub	w14,	w17,	w20,	lsl #1
    lsl	w20,	w10,	#2
    mov	w17,	w13
    add	w9,	w20,	w11,	lsl #3
    movz	w11,	#65419
    movk	w11,	#65535,	lsl #16
    str	w9,	[sp, #716]

    str	w7,	[sp, #1000]

    ldr	w21,	[sp, #608]

    neg	w28,	w21
    str	w17,	[sp, #196]

    lsl	w21,	w28,	#0
    movz	w17,	#83
    ldr	w19,	[sp, #520]

    mov	w18,	w17
    add	w15,	w21,	w28,	lsl #6
    mov	w17,	w3
    neg	w28,	w19
    movz	w21,	#65489
    lsl	w27,	w28,	#5
    movk	w21,	#65535,	lsl #16
    mov	w1,	w21
    sub	w13,	w27,	w28,	lsl #0
    mov	w28,	w4
    mov	w27,	w26
    str	w13,	[sp, #784]

    ldr	w7,	[sp, #272]

    str	w7,	[sp, #816]

    str	w18,	[sp, #780]

    str	w1,	[sp, #1176]

    movz	w18,	#122
    ldr	w12,	[sp, #628]

    mov	w10,	w18
    neg	w0,	w12
    lsl	w19,	w0,	#5
    str	w19,	[sp, #1192]

    str	w27,	[sp, #460]

    str	w17,	[sp, #972]

    ldr	w13,	[sp, #524]

    ldr	w17,	[sp, #568]

    add	w1,	w13,	w17
    mov	w13,	w11
    str	w1,	[sp, #908]

    str	w13,	[sp, #480]

    ldr	w18,	[sp, #312]

    movz	w13,	#125
    ldr	w12,	[sp, #504]

    mov	w9,	w13
    add	w17,	w18,	w12
    ldr	w27,	[sp, #544]

    ldr	w13,	[sp, #592]

    add	w8,	w27,	w13
    str	w8,	[sp, #840]

    str	w22,	[sp, #256]

    ldr	w24,	[sp, #540]

    ldr	w1,	[sp, #748]

    madd	w3,	w24,	w5,	w1

    ldr	w11,	[sp, #552]

    ldr	w8,	[sp, #728]

    madd	w22,	w11,	w8,	w3

    ldr	w11,	[sp, #732]

    add	w5,	w22,	w11
    ldr	w27,	[sp, #192]

    ldr	w4,	[sp, #716]

    ldr	w13,	[sp, #528]

    madd	w26,	w27,	w2,	w5

    ldr	w23,	[sp, #1280]

    add	w1,	w26,	w14
    add	w26,	w1,	w4
    add	w3,	w26,	w15
    madd	w2,	w13,	w23,	w3

    madd	w7,	w17,	w9,	w2

    ldr	w2,	[sp, #532]

    ldr	w3,	[sp, #196]

    madd	w11,	w2,	w3,	w7

    ldr	w13,	[sp, #784]

    add	w3,	w11,	w13
    ldr	w7,	[sp, #636]

    ldr	w6,	[sp, #816]

    madd	w15,	w7,	w6,	w3

    ldr	w3,	[sp, #620]

    ldr	w8,	[sp, #780]

    madd	w15,	w3,	w8,	w15

    ldr	w9,	[sp, #448]

    ldr	w13,	[sp, #536]

    madd	w11,	w9,	w10,	w15

    ldr	w15,	[sp, #256]

    madd	w6,	w13,	w28,	w11

    ldr	w1,	[sp, #840]

    ldr	w9,	[sp, #624]

    madd	w12,	w1,	w15,	w6

    ldr	w2,	[sp, #1176]

    madd	w4,	w9,	w2,	w12

    ldr	w16,	[sp, #1192]

    add	w2,	w4,	w16
    ldr	w25,	[sp, #908]

    ldr	w10,	[sp, #480]

    ldr	w0,	[sp, #604]

    madd	w12,	w25,	w10,	w2

    ldr	w26,	[sp, #460]

    madd	w23,	w0,	w26,	w12

    ldr	w0,	[sp, #548]

    ldr	w14,	[sp, #972]

    madd	w12,	w0,	w14,	w23

    cmp	w12,	#0
    movz	w23,	#0
    mov	w13,	w23
    csel	w26,	w13,	w12,	lt
    cmp	w12,	#127
    ldr	w27,	[sp, #168]

    movz	w1,	#127
    movz	w11,	#65432
    movz	w13,	#65420
    mov	w8,	w27
    ldr	w15,	[sp, #744]

    mov	w12,	w1
    movk	w11,	#65535,	lsl #16
    movk	w13,	#65535,	lsl #16
    csel	w26,	w12,	w26,	gt
    mov	w2,	w13
    madd	w16,	w26,	w8,	w15

    movz	w26,	#82
    mov	w8,	w11
    str	w16,	[sp, #1200]

    mov	w27,	w26
    ldr	w19,	[sp, #592]

    lsl	w24,	w19,	#3
    ldr	w28,	[sp, #348]

    str	w8,	[sp, #1264]

    madd	w0,	w28,	w27,	w24

    ldr	w4,	[sp, #540]

    movz	w28,	#101
    ldr	w11,	[sp, #1264]

    mov	w24,	w28
    madd	w19,	w4,	w11,	w0

    ldr	w9,	[sp, #552]

    madd	w23,	w9,	w24,	w19

    str	w2,	[sp, #1220]

    ldr	w0,	[sp, #560]

    ldr	w4,	[sp, #1220]

    madd	w20,	w0,	w4,	w23

    ldr	w5,	[sp, #192]

    ldr	w24,	[sp, #580]

    neg	w8,	w5
    ldr	w4,	[sp, #260]

    neg	w15,	w24
    lsl	w14,	w8,	#6
    ldr	w7,	[sp, #564]

    lsl	w1,	w15,	#4
    ldr	w9,	[sp, #504]

    sub	w28,	w14,	w8,	lsl #0
    movz	w15,	#116
    mov	w8,	w4
    ldr	w4,	[sp, #1000]

    add	w21,	w20,	w28
    ldr	w24,	[sp, #568]

    ldr	w14,	[sp, #608]

    ldr	w16,	[sp, #608]

    lsl	w12,	w14,	#1
    add	w18,	w21,	w1
    ldr	w6,	[sp, #528]

    movz	w14,	#59
    madd	w17,	w7,	w8,	w18

    madd	w25,	w9,	w4,	w17

    add	w18,	w12,	w16,	lsl #6
    ldr	w4,	[sp, #312]

    movz	w9,	#75
    neg	w17,	w6
    movz	w12,	#65435
    mov	w13,	w9
    lsl	w23,	w17,	#5
    movk	w12,	#65535,	lsl #16
    madd	w21,	w24,	w13,	w25

    add	w23,	w23,	w17,	lsl #6
    add	w13,	w21,	w18
    mov	w21,	w12
    mov	w18,	w14
    add	w2,	w13,	w23
    movz	w13,	#65422
    movk	w13,	#65535,	lsl #16
    madd	w6,	w4,	w21,	w2

    mov	w1,	w13
    str	w1,	[sp, #172]

    mov	w13,	w15
    ldr	w2,	[sp, #172]

    ldr	w21,	[sp, #532]

    madd	w27,	w21,	w2,	w6

    ldr	w8,	[sp, #520]

    madd	w27,	w8,	w18,	w27

    ldr	w2,	[sp, #636]

    lsl	w22,	w2,	#2
    ldr	w3,	[sp, #636]

    ldr	w17,	[sp, #620]

    add	w14,	w22,	w3,	lsl #3
    ldr	w18,	[sp, #620]

    lsl	w26,	w17,	#0
    ldr	w7,	[sp, #224]

    movz	w17,	#65443
    mov	w24,	w7
    add	w0,	w27,	w14
    ldr	w10,	[sp, #448]

    add	w19,	w26,	w18,	lsl #2
    movk	w17,	#65535,	lsl #16
    ldr	w4,	[sp, #536]

    movz	w18,	#79
    mov	w12,	w17
    ldr	w1,	[sp, #544]

    add	w11,	w0,	w19
    ldr	w2,	[sp, #624]

    lsl	w28,	w2,	#4
    ldr	w3,	[sp, #624]

    ldr	w22,	[sp, #628]

    madd	w0,	w10,	w24,	w11

    ldr	w20,	[sp, #524]

    madd	w8,	w4,	w13,	w0

    ldr	w23,	[sp, #524]

    lsl	w20,	w20,	#0
    madd	w21,	w1,	w12,	w8

    ldr	w19,	[sp, #604]

    mov	w8,	w18
    sub	w12,	w28,	w3,	lsl #0
    add	w17,	w20,	w23,	lsl #1
    ldr	w10,	[sp, #548]

    movz	w20,	#49
    mov	w24,	w20
    add	w0,	w21,	w12
    madd	w27,	w22,	w8,	w0

    neg	w0,	w10
    add	w13,	w27,	w17
    lsl	w9,	w0,	#7
    madd	w14,	w19,	w24,	w13

    sub	w26,	w9,	w0,	lsl #2
    add	w2,	w14,	w26
    cmp	w2,	#0
    movz	w21,	#0
    mov	w15,	w21
    csel	w9,	w15,	w2,	lt
    cmp	w2,	#127
    movz	w15,	#121
    ldr	w17,	[sp, #1200]

    movz	w21,	#65523
    movz	w14,	#127
    movz	w23,	#101
    movk	w21,	#65535,	lsl #16
    csel	w20,	w14,	w9,	gt
    neg	w14,	w20
    lsl	w24,	w14,	#0
    add	w22,	w24,	w14,	lsl #1
    movz	w24,	#81
    mov	w14,	w24
    add	w13,	w17,	w22
    mov	w17,	w15
    str	w13,	[sp, #488]

    ldr	w25,	[sp, #348]

    lsl	w16,	w25,	#2
    ldr	w28,	[sp, #348]

    ldr	w18,	[sp, #592]

    add	w22,	w16,	w28,	lsl #6
    ldr	w27,	[sp, #1284]

    movz	w16,	#65462
    ldr	w3,	[sp, #540]

    movk	w16,	#65535,	lsl #16
    madd	w9,	w18,	w14,	w22

    str	w16,	[sp, #1272]

    mov	w22,	w27
    movz	w14,	#55
    ldr	w10,	[sp, #552]

    madd	w13,	w3,	w22,	w9

    mov	w4,	w14
    ldr	w19,	[sp, #1272]

    movz	w14,	#82
    madd	w27,	w10,	w19,	w13

    ldr	w24,	[sp, #192]

    movz	w10,	#65486
    neg	w25,	w24
    movk	w10,	#65535,	lsl #16
    lsl	w18,	w25,	#4
    mov	w19,	w10
    sub	w1,	w18,	w25,	lsl #0
    movz	w25,	#38
    mov	w28,	w25
    str	w1,	[sp, #1248]

    mov	w1,	w21
    str	w1,	[sp, #136]

    ldr	w0,	[sp, #568]

    neg	w12,	w0
    lsl	w0,	w12,	#6
    sub	w8,	w0,	w12,	lsl #1
    str	w8,	[sp, #132]

    ldr	w3,	[sp, #608]

    lsl	w9,	w3,	#6
    str	w28,	[sp, #792]

    ldr	w0,	[sp, #1268]

    str	w0,	[sp, #752]

    ldr	w2,	[sp, #448]

    movz	w0,	#0
    neg	w2,	w2
    mov	w1,	w0
    lsl	w15,	w2,	#1
    add	w7,	w15,	w2,	lsl #3
    str	w7,	[sp, #500]

    ldr	w2,	[sp, #536]

    neg	w28,	w2
    str	w19,	[sp, #1236]

    lsl	w15,	w28,	#4
    ldr	w6,	[sp, #624]

    sub	w8,	w1,	w6
    ldr	w1,	[sp, #1220]

    mov	w10,	w1
    movz	w1,	#65482
    movk	w1,	#65535,	lsl #16
    mov	w19,	w1
    mov	w1,	w14
    str	w19,	[sp, #988]

    str	w1,	[sp, #976]

    ldr	w0,	[sp, #548]

    neg	w1,	w0
    lsl	w25,	w1,	#3
    add	w26,	w25,	w1,	lsl #6
    str	w26,	[sp, #936]

    ldr	w13,	[sp, #520]

    ldr	w1,	[sp, #620]

    add	w5,	w1,	w13
    ldr	w0,	[sp, #528]

    movz	w1,	#114
    mov	w28,	w1
    add	w6,	w5,	w8
    lsl	w8,	w6,	#7
    sub	w18,	w8,	w6,	lsl #4
    ldr	w8,	[sp, #636]

    add	w19,	w8,	w0
    str	w19,	[sp, #1104]

    ldr	w13,	[sp, #560]

    madd	w24,	w13,	w17,	w27

    ldr	w21,	[sp, #1248]

    add	w1,	w24,	w21
    ldr	w6,	[sp, #580]

    ldr	w3,	[sp, #564]

    ldr	w7,	[sp, #136]

    madd	w1,	w6,	w4,	w1

    ldr	w0,	[sp, #504]

    madd	w3,	w3,	w23,	w1

    ldr	w1,	[sp, #132]

    madd	w5,	w0,	w7,	w3

    ldr	w25,	[sp, #312]

    add	w0,	w5,	w1
    ldr	w2,	[sp, #792]

    ldr	w4,	[sp, #532]

    add	w9,	w0,	w9
    ldr	w17,	[sp, #752]

    madd	w22,	w25,	w2,	w9

    madd	w27,	w4,	w17,	w22

    ldr	w17,	[sp, #1104]

    madd	w25,	w17,	w28,	w27

    ldr	w3,	[sp, #500]

    add	w25,	w25,	w3
    ldr	w7,	[sp, #544]

    ldr	w8,	[sp, #1236]

    ldr	w26,	[sp, #628]

    add	w0,	w25,	w15
    madd	w0,	w7,	w8,	w0

    add	w18,	w0,	w18
    ldr	w0,	[sp, #524]

    ldr	w28,	[sp, #988]

    madd	w18,	w26,	w10,	w18

    ldr	w25,	[sp, #604]

    madd	w16,	w0,	w28,	w18

    ldr	w17,	[sp, #976]

    madd	w15,	w25,	w17,	w16

    ldr	w9,	[sp, #936]

    add	w1,	w15,	w9
    cmp	w1,	#0
    movz	w23,	#0
    mov	w18,	w23
    csel	w22,	w18,	w1,	lt
    cmp	w1,	#127
    movz	w26,	#65459
    ldr	w14,	[sp, #488]

    movz	w13,	#127
    movz	w15,	#0
    movz	w9,	#65446
    movk	w26,	#65535,	lsl #16
    mov	w17,	w13
    movk	w9,	#65535,	lsl #16
    mov	w20,	w26
    csel	w21,	w17,	w22,	gt
    mov	w12,	w9
    lsl	w24,	w21,	#5
    movz	w9,	#86
    add	w4,	w14,	w24
    str	w4,	[sp, #1180]

    str	x20,	[sp, #1240]

    ldr	w2,	[sp, #348]

    ldr	x21,	[sp, #1240]

    mul	w26,	w2,	w21
    str	w26,	[sp, #216]

    str	w12,	[sp, #1232]

    movz	w12,	#81
    ldr	w1,	[sp, #560]

    neg	w19,	w1
    ldr	w11,	[sp, #192]

    lsl	w28,	w19,	#1
    neg	w25,	w11
    lsl	w5,	w25,	#5
    add	w18,	w28,	w19,	lsl #2
    sub	w22,	w5,	w25,	lsl #1
    movz	w25,	#59
    str	w22,	[sp, #208]

    ldr	w27,	[sp, #580]

    mov	w22,	w12
    neg	w27,	w27
    lsl	w0,	w27,	#3
    str	w0,	[sp, #756]

    str	w22,	[sp, #788]

    ldr	w26,	[sp, #504]

    mov	w22,	w9
    lsl	w19,	w26,	#1
    mov	w9,	w15
    str	w19,	[sp, #204]

    movz	w19,	#52
    ldr	w21,	[sp, #128]

    mov	w10,	w19
    str	w21,	[sp, #212]

    ldr	w23,	[sp, #224]

    mov	w21,	w25
    str	w23,	[sp, #680]

    str	w21,	[sp, #496]

    movz	w21,	#55
    str	w10,	[sp, #484]

    mov	w26,	w21
    str	w26,	[sp, #464]

    ldr	w10,	[sp, #636]

    ldr	w3,	[sp, #620]

    neg	w8,	w10
    ldr	w12,	[sp, #620]

    lsl	w5,	w3,	#4
    lsl	w23,	w8,	#0
    movz	w3,	#58
    sub	w17,	w5,	w12,	lsl #1
    mov	w13,	w3
    add	w10,	w23,	w8,	lsl #5
    movz	w8,	#67
    str	w17,	[sp, #640]

    mov	w2,	w8
    str	w2,	[sp, #804]

    movz	w8,	#65457
    str	w22,	[sp, #820]

    movk	w8,	#65535,	lsl #16
    mov	w17,	w8
    str	w17,	[sp, #1100]

    ldr	w20,	[sp, #628]

    lsl	w8,	w20,	#4
    ldr	w17,	[sp, #628]

    add	w0,	w8,	w17,	lsl #5
    str	w0,	[sp, #812]

    ldr	w8,	[sp, #136]

    str	w8,	[sp, #808]

    ldr	w12,	[sp, #604]

    ldr	w1,	[sp, #540]

    sub	w12,	w9,	w12
    ldr	w8,	[sp, #548]

    add	w14,	w8,	w1
    lsl	w17,	w14,	#1
    add	w3,	w17,	w14,	lsl #6
    str	w3,	[sp, #960]

    ldr	w5,	[sp, #532]

    ldr	w3,	[sp, #592]

    add	w1,	w5,	w3
    add	w12,	w1,	w12
    lsl	w15,	w12,	#4
    sub	w1,	w15,	w12,	lsl #0
    str	w1,	[sp, #920]

    ldr	w14,	[sp, #552]

    ldr	w27,	[sp, #216]

    ldr	w1,	[sp, #1232]

    madd	w15,	w14,	w1,	w27

    ldr	w19,	[sp, #208]

    add	w27,	w15,	w18
    ldr	w0,	[sp, #756]

    ldr	w17,	[sp, #564]

    ldr	w20,	[sp, #788]

    add	w28,	w27,	w19
    ldr	w18,	[sp, #204]

    ldr	w26,	[sp, #568]

    ldr	w24,	[sp, #212]

    add	w1,	w28,	w0
    ldr	w28,	[sp, #608]

    madd	w1,	w17,	w20,	w1

    add	w3,	w1,	w18
    madd	w6,	w26,	w24,	w3

    ldr	w24,	[sp, #680]

    madd	w12,	w28,	w24,	w6

    ldr	w14,	[sp, #528]

    ldr	w0,	[sp, #496]

    madd	w12,	w14,	w0,	w12

    ldr	w11,	[sp, #312]

    ldr	w26,	[sp, #484]

    ldr	w6,	[sp, #520]

    madd	w14,	w11,	w26,	w12

    ldr	w3,	[sp, #464]

    madd	w5,	w6,	w3,	w14

    ldr	w6,	[sp, #640]

    add	w19,	w5,	w10
    ldr	w14,	[sp, #448]

    add	w20,	w19,	w6
    madd	w10,	w14,	w13,	w20

    ldr	w14,	[sp, #536]

    ldr	w3,	[sp, #804]

    madd	w16,	w14,	w3,	w10

    ldr	w1,	[sp, #544]

    ldr	w21,	[sp, #820]

    madd	w14,	w1,	w21,	w16

    ldr	w9,	[sp, #624]

    ldr	w17,	[sp, #1100]

    madd	w17,	w9,	w17,	w14

    ldr	w9,	[sp, #812]

    ldr	w1,	[sp, #524]

    add	w18,	w17,	w9
    ldr	w8,	[sp, #808]

    ldr	w28,	[sp, #920]

    madd	w18,	w1,	w8,	w18

    ldr	w3,	[sp, #960]

    add	w20,	w18,	w28
    add	w19,	w20,	w3
    cmp	w19,	#0
    movz	w26,	#0
    mov	w24,	w26
    csel	w1,	w24,	w19,	lt
    cmp	w19,	#127
    ldr	w16,	[sp, #224]

    movz	w27,	#67
    movz	w19,	#127
    movz	w22,	#107
    ldr	w3,	[sp, #1180]

    mov	w23,	w19
    mov	w13,	w22
    mov	w19,	w16
    csel	w1,	w23,	w1,	gt
    madd	w6,	w1,	w19,	w3

    str	w6,	[sp, #1004]

    ldr	w23,	[sp, #592]

    ldr	w11,	[sp, #592]

    lsl	w24,	w23,	#0
    add	w15,	w24,	w11,	lsl #5
    str	w15,	[sp, #1016]

    str	w27,	[sp, #884]

    ldr	w16,	[sp, #552]

    ldr	w1,	[sp, #552]

    lsl	w24,	w16,	#5
    sub	w20,	w24,	w1,	lsl #1
    movz	w24,	#104
    str	w20,	[sp, #984]

    ldr	w1,	[sp, #560]

    neg	w26,	w1
    lsl	w16,	w26,	#1
    movz	w26,	#83
    str	w16,	[sp, #492]

    ldr	w9,	[sp, #580]

    ldr	w25,	[sp, #580]

    lsl	w28,	w9,	#7
    sub	w18,	w28,	w25,	lsl #3
    movz	w25,	#65417
    movk	w25,	#65535,	lsl #16
    str	w18,	[sp, #904]

    mov	w23,	w25
    ldr	w12,	[sp, #136]

    movz	w25,	#97
    str	w12,	[sp, #1188]

    ldr	w17,	[sp, #504]

    ldr	w0,	[sp, #504]

    lsl	w1,	w17,	#1
    add	w3,	w1,	w0,	lsl #4
    mov	w1,	w24
    str	w3,	[sp, #1112]

    movz	w3,	#82
    ldr	w0,	[sp, #568]

    ldr	w19,	[sp, #568]

    lsl	w14,	w0,	#0
    str	w1,	[sp, #888]

    add	w10,	w14,	w19,	lsl #2
    str	w23,	[sp, #876]

    movz	w19,	#71
    ldr	w21,	[sp, #312]

    mov	w16,	w19
    neg	w1,	w21
    lsl	w17,	w1,	#3
    sub	w23,	w17,	w1,	lsl #0
    str	w23,	[sp, #276]

    ldr	w0,	[sp, #636]

    ldr	w14,	[sp, #636]

    lsl	w28,	w0,	#3
    add	w0,	w28,	w14,	lsl #4
    movz	w28,	#46
    mov	w12,	w28
    str	w0,	[sp, #124]

    ldr	w17,	[sp, #448]

    neg	w24,	w17
    lsl	w0,	w24,	#5
    add	w0,	w0,	w24,	lsl #6
    str	w0,	[sp, #772]

    mov	w0,	w25
    ldr	w23,	[sp, #1264]

    str	w23,	[sp, #1128]

    ldr	w4,	[sp, #384]

    mov	w23,	w4
    mov	w4,	w26
    str	w23,	[sp, #1140]

    str	w0,	[sp, #1108]

    movz	w0,	#65452
    str	w4,	[sp, #768]

    movk	w0,	#65535,	lsl #16
    str	w12,	[sp, #776]

    mov	w11,	w0
    str	w11,	[sp, #1120]

    ldr	w14,	[sp, #192]

    ldr	w4,	[sp, #624]

    add	w24,	w4,	w14
    lsl	w4,	w24,	#0
    add	w21,	w4,	w24,	lsl #6
    str	w21,	[sp, #1144]

    ldr	w21,	[sp, #348]

    ldr	w14,	[sp, #620]

    add	w1,	w14,	w21
    str	w1,	[sp, #1116]

    mov	w1,	w3
    str	w1,	[sp, #880]

    ldr	w14,	[sp, #540]

    ldr	w25,	[sp, #884]

    ldr	w6,	[sp, #1016]

    ldr	w5,	[sp, #984]

    madd	w1,	w14,	w25,	w6

    add	w20,	w1,	w5
    ldr	w1,	[sp, #492]

    ldr	w3,	[sp, #904]

    add	w23,	w20,	w1
    ldr	w9,	[sp, #564]

    ldr	w20,	[sp, #1188]

    add	w27,	w23,	w3
    ldr	w3,	[sp, #1112]

    ldr	w7,	[sp, #608]

    madd	w24,	w9,	w20,	w27

    ldr	w0,	[sp, #888]

    add	w25,	w24,	w3
    ldr	w17,	[sp, #528]

    ldr	w21,	[sp, #876]

    ldr	w1,	[sp, #276]

    add	w24,	w25,	w10
    ldr	w3,	[sp, #532]

    madd	w28,	w7,	w0,	w24

    madd	w28,	w17,	w21,	w28

    add	w0,	w28,	w1
    ldr	w1,	[sp, #520]

    ldr	w12,	[sp, #124]

    madd	w28,	w3,	w16,	w0

    ldr	w2,	[sp, #1116]

    madd	w27,	w1,	w13,	w28

    ldr	w26,	[sp, #880]

    add	w0,	w27,	w12
    ldr	w9,	[sp, #772]

    ldr	w11,	[sp, #536]

    ldr	w10,	[sp, #1128]

    madd	w0,	w2,	w26,	w0

    ldr	w1,	[sp, #544]

    add	w13,	w0,	w9
    ldr	w16,	[sp, #1140]

    ldr	w27,	[sp, #1144]

    ldr	w28,	[sp, #628]

    madd	w13,	w11,	w10,	w13

    madd	w15,	w1,	w16,	w13

    add	w17,	w15,	w27
    ldr	w1,	[sp, #1108]

    ldr	w0,	[sp, #524]

    ldr	w7,	[sp, #768]

    madd	w18,	w28,	w1,	w17

    madd	w19,	w0,	w7,	w18

    ldr	w28,	[sp, #604]

    ldr	w11,	[sp, #776]

    ldr	w18,	[sp, #548]

    madd	w22,	w28,	w11,	w19

    ldr	w10,	[sp, #1120]

    madd	w28,	w18,	w10,	w22

    cmp	w28,	#0
    movz	w23,	#0
    mov	w26,	w23
    csel	w18,	w26,	w28,	lt
    cmp	w28,	#127
    movz	w17,	#127
    movz	w19,	#38
    movz	w26,	#65507
    movz	w10,	#65490
    ldr	w20,	[sp, #1236]

    movz	w13,	#37
    movz	w23,	#65463
    mov	w25,	w17
    movk	w26,	#65535,	lsl #16
    movk	w10,	#65535,	lsl #16
    ldr	w11,	[sp, #1004]

    movk	w23,	#65535,	lsl #16
    mov	w17,	w20
    csel	w0,	w25,	w18,	gt
    madd	w27,	w0,	w17,	w11

    str	w27,	[sp, #632]

    ldr	w1,	[sp, #348]

    mov	w27,	w26
    ldr	w12,	[sp, #348]

    lsl	w22,	w1,	#3
    ldr	w11,	[sp, #592]

    sub	w16,	w22,	w12,	lsl #0
    ldr	w15,	[sp, #1232]

    ldr	w5,	[sp, #580]

    mov	w18,	w15
    neg	w1,	w5
    madd	w9,	w11,	w27,	w16

    lsl	w17,	w1,	#5
    mov	w16,	w19
    str	w17,	[sp, #2628]

    ldr	w1,	[sp, #504]

    ldr	w0,	[sp, #504]

    lsl	w27,	w1,	#2
    ldr	w17,	[sp, #120]

    add	w12,	w27,	w0,	lsl #5
    mov	w6,	w17
    mov	w0,	w10
    str	w0,	[sp, #992]

    movz	w0,	#65449
    str	w23,	[sp, #980]

    movk	w0,	#65535,	lsl #16
    ldr	w1,	[sp, #636]

    mov	w3,	w0
    neg	w2,	w1
    lsl	w22,	w2,	#1
    add	w27,	w22,	w2,	lsl #5
    movz	w2,	#71
    mov	w7,	w2
    str	w27,	[sp, #940]

    ldr	w23,	[sp, #412]

    str	w23,	[sp, #924]

    str	w7,	[sp, #848]

    movz	w7,	#53
    ldr	x0,	[sp, #1240]

    mov	w4,	w7
    str	w4,	[sp, #952]

    ldr	w8,	[sp, #116]

    str	w8,	[sp, #1164]

    ldr	w14,	[sp, #136]

    str	w14,	[sp, #868]

    ldr	w27,	[sp, #172]

    str	w27,	[sp, #1124]

    ldr	w20,	[sp, #532]

    ldr	w8,	[sp, #564]

    ldr	w14,	[sp, #628]

    add	w15,	w20,	w8
    mov	w20,	w13
    add	w4,	w15,	w14
    str	w4,	[sp, #824]

    str	w20,	[sp, #468]

    ldr	w13,	[sp, #312]

    ldr	w5,	[sp, #540]

    ldr	w24,	[sp, #260]

    add	w23,	w13,	w5
    ldr	w8,	[sp, #552]

    mov	w10,	w24
    ldr	w13,	[sp, #560]

    madd	w24,	w8,	w16,	w9

    ldr	w28,	[sp, #1248]

    madd	w21,	w13,	w18,	w24

    ldr	w18,	[sp, #2628]

    add	w8,	w21,	w28
    ldr	w1,	[sp, #132]

    ldr	w15,	[sp, #608]

    add	w27,	w8,	w18
    ldr	w24,	[sp, #528]

    ldr	w4,	[sp, #992]

    add	w9,	w27,	w12
    add	w8,	w9,	w1
    ldr	w9,	[sp, #520]

    madd	w8,	w15,	w6,	w8

    madd	w7,	w24,	w4,	w8

    ldr	w4,	[sp, #980]

    madd	w6,	w23,	w10,	w7

    ldr	w22,	[sp, #940]

    madd	w5,	w9,	w4,	w6

    ldr	w8,	[sp, #620]

    add	w9,	w5,	w22
    ldr	w7,	[sp, #448]

    ldr	w4,	[sp, #924]

    madd	w8,	w8,	w3,	w9

    ldr	w16,	[sp, #536]

    madd	w6,	w7,	w4,	w8

    ldr	w8,	[sp, #848]

    madd	w6,	w16,	w8,	w6

    ldr	w8,	[sp, #544]

    ldr	w26,	[sp, #624]

    madd	w0,	w8,	w0,	w6

    ldr	w2,	[sp, #952]

    ldr	w21,	[sp, #824]

    madd	w11,	w26,	w2,	w0

    ldr	w0,	[sp, #468]

    ldr	w16,	[sp, #524]

    madd	w9,	w21,	w0,	w11

    ldr	w21,	[sp, #1164]

    ldr	w5,	[sp, #604]

    madd	w17,	w16,	w21,	w9

    ldr	w12,	[sp, #868]

    ldr	w1,	[sp, #548]

    madd	w18,	w5,	w12,	w17

    ldr	w9,	[sp, #1124]

    madd	w9,	w1,	w9,	w18

    cmp	w9,	#0
    movz	w17,	#0
    mov	w25,	w17
    csel	w19,	w25,	w9,	lt
    cmp	w9,	#127
    movz	w15,	#47
    ldr	w0,	[sp, #256]

    movz	w3,	#75
    movz	w14,	#41
    movz	w20,	#42
    movz	w9,	#65485
    movz	w12,	#127
    mov	w6,	w15
    mov	w23,	w0
    mov	w25,	w3
    mov	w21,	w20
    movk	w9,	#65535,	lsl #16
    mov	w24,	w12
    movz	w15,	#22
    movz	w20,	#65487
    ldr	w12,	[sp, #632]

    csel	w27,	w24,	w19,	gt
    movk	w20,	#65535,	lsl #16
    movz	w19,	#65444
    madd	w28,	w27,	w23,	w12

    movk	w19,	#65535,	lsl #16
    mov	w12,	w15
    movz	w23,	#85
    str	w28,	[sp, #1052]

    mov	w17,	w19
    movz	w15,	#38
    ldr	w10,	[sp, #348]

    mul	w18,	w10,	w21
    movz	w10,	#109
    str	w18,	[sp, #3300]

    mov	w3,	w10
    ldr	w24,	[sp, #272]

    mov	w18,	w14
    ldr	w1,	[sp, #192]

    mov	w26,	w24
    ldr	w2,	[sp, #192]

    lsl	w5,	w1,	#1
    ldr	x0,	[sp, #1240]

    ldr	w7,	[sp, #504]

    add	w28,	w5,	w2,	lsl #3
    ldr	w8,	[sp, #504]

    lsl	w4,	w7,	#5
    mov	w2,	w0
    add	w13,	w4,	w8,	lsl #6
    str	w13,	[sp, #2632]

    ldr	w8,	[sp, #1272]

    str	w6,	[sp, #236]

    mov	w0,	w8
    str	w12,	[sp, #932]

    movz	w8,	#65414
    movk	w8,	#65535,	lsl #16
    mov	w1,	w8
    ldr	w8,	[sp, #448]

    neg	w16,	w8
    str	w16,	[sp, #456]

    ldr	w27,	[sp, #456]

    ldr	w8,	[sp, #456]

    lsl	w16,	w27,	#2
    mov	w27,	w20
    add	w12,	w16,	w8,	lsl #6
    movz	w20,	#67
    str	w12,	[sp, #476]

    str	w15,	[sp, #968]

    movz	w15,	#29
    mov	w4,	w15
    movz	w15,	#115
    str	w4,	[sp, #896]

    mov	w13,	w15
    str	w13,	[sp, #1012]

    ldr	w10,	[sp, #384]

    str	w10,	[sp, #832]

    ldr	w16,	[sp, #524]

    ldr	w12,	[sp, #524]

    lsl	w8,	w16,	#2
    mov	w16,	w20
    add	w13,	w8,	w12,	lsl #5
    mov	w8,	w23
    str	w13,	[sp, #996]

    str	w27,	[sp, #1020]

    str	w8,	[sp, #556]

    ldr	w12,	[sp, #520]

    ldr	w7,	[sp, #592]

    ldr	w27,	[sp, #540]

    add	w23,	w12,	w7
    ldr	w19,	[sp, #3300]

    ldr	w12,	[sp, #552]

    madd	w21,	w27,	w18,	w19

    ldr	w6,	[sp, #560]

    madd	w8,	w12,	w26,	w21

    madd	w5,	w6,	w17,	w8

    ldr	w17,	[sp, #580]

    add	w6,	w5,	w28
    madd	w27,	w17,	w2,	w6

    ldr	w2,	[sp, #564]

    ldr	w14,	[sp, #2632]

    madd	w6,	w2,	w25,	w27

    ldr	w10,	[sp, #568]

    add	w7,	w6,	w14
    ldr	w8,	[sp, #608]

    ldr	w4,	[sp, #528]

    madd	w25,	w10,	w9,	w7

    ldr	w17,	[sp, #276]

    madd	w10,	w8,	w3,	w25

    ldr	w6,	[sp, #532]

    madd	w5,	w4,	w0,	w10

    ldr	w4,	[sp, #636]

    add	w15,	w5,	w17
    ldr	w0,	[sp, #236]

    ldr	w9,	[sp, #620]

    madd	w3,	w6,	w1,	w15

    ldr	w5,	[sp, #932]

    madd	w1,	w23,	w16,	w3

    madd	w1,	w4,	w0,	w1

    madd	w12,	w9,	w5,	w1

    ldr	w5,	[sp, #476]

    ldr	w0,	[sp, #536]

    add	w5,	w12,	w5
    ldr	w12,	[sp, #968]

    ldr	w2,	[sp, #544]

    madd	w3,	w0,	w12,	w5

    ldr	w14,	[sp, #896]

    madd	w3,	w2,	w14,	w3

    ldr	w2,	[sp, #624]

    ldr	w16,	[sp, #1012]

    ldr	w4,	[sp, #628]

    madd	w2,	w2,	w16,	w3

    ldr	w26,	[sp, #832]

    ldr	w3,	[sp, #996]

    madd	w17,	w4,	w26,	w2

    ldr	w7,	[sp, #604]

    add	w1,	w17,	w3
    ldr	w23,	[sp, #1020]

    ldr	w2,	[sp, #548]

    madd	w19,	w7,	w23,	w1

    ldr	w10,	[sp, #556]

    madd	w24,	w2,	w10,	w19

    cmp	w24,	#0
    movz	w4,	#0
    csel	w1,	w4,	w24,	lt
    cmp	w24,	#127
    ldr	w28,	[sp, #1052]

    movz	w2,	#46
    movz	w3,	#127
    csel	w1,	w3,	w1,	gt
    madd	w20,	w1,	w2,	w28

    cmp	w20,	#0
    cset	w22,	gt
    cmp	w22,	#0
    bne	main_610

main_611:
    movz	w0,	#100
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#103
    bl	putch
    movz	w0,	#10
    bl	putch
    b	main_612

main_610:
    movz	w0,	#99
    bl	putch
    movz	w0,	#97
    bl	putch
    movz	w0,	#116
    bl	putch
    movz	w0,	#10
    bl	putch

main_612:
    ldr	w4,	[sp, #508]

    sub	w5,	w4,	#1
    cmp	w5,	#0
    bgt	main_36

main_617:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #3568
    ret


main_36:
    str	w5,	[sp, #508]

    b	main_37

main_46:
    lsl	w18,	w26,	#2
    add	x25,	x23,	x18
    bl	getint
    add	w4,	w26,	#1
    str	w0,	[x25]

    mov	w26,	w4
    b	main_43

