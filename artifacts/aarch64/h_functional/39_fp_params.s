.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#12880
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w5,	#0
    str	w0,	[sp, #3560]

    mov	w26,	w5

main_10:
    cmp	w26,	#40
    bge	main_18

main_13:
    lsl	w0,	w26,	#2
    add	w23,	w0,	w26,	lsl #3
    mov	x0,	x23
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getfarray
    add	w25,	w26,	#1
    mov	w26,	w25
    b	main_10

main_18:
    movz	w6,	#0
    mov	w19,	w6

main_19:
    cmp	w19,	#24
    bge	main_27

main_22:
    lsl	w25,	w19,	#2
    add	w18,	w25,	w19,	lsl #3
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#496
    bl	getarray
    add	w3,	w19,	#1
    mov	w19,	w3
    b	main_19

main_27:
    add	x11,	sp,	#16
    movz	fp,	#3468
    add	x24,	sp,	#52
    add	x12,	sp,	#88
    add	x21,	sp,	#136
    add	x9,	sp,	#148
    add	x18,	sp,	#196
    str	x11,	[sp, fp]

    movz	fp,	#3468
    ldr	w27,	[sp, #3560]

    lsl	w8,	w27,	#2
    ldr	x16,	[sp, fp]

    add	x27,	sp,	#256
    movz	fp,	#3460
    add	x7,	x16,	x8
    add	x8,	sp,	#100
    add	x16,	sp,	#76
    ldr	s27,	[x7]

    add	x7,	sp,	#28
    str	s27,	[sp, #1280]

    str	x7,	[sp, fp]

    movz	fp,	#3460
    ldr	w28,	[sp, #3560]

    lsl	w13,	w28,	#2
    ldr	x10,	[sp, fp]

    add	x28,	sp,	#40
    movz	fp,	#3444
    add	x11,	x10,	x13
    ldr	s24,	[x11]

    str	s24,	[sp, #1224]

    str	x28,	[sp, fp]

    movz	fp,	#3444
    ldr	w0,	[sp, #3560]

    lsl	w17,	w0,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3436
    add	x15,	x2,	x17
    ldr	s1,	[x15]

    str	s1,	[sp, #1284]

    str	x24,	[sp, fp]

    movz	fp,	#3436
    ldr	w1,	[sp, #3560]

    lsl	w20,	w1,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#3428
    add	x19,	x28,	x20
    add	x20,	sp,	#64
    ldr	s5,	[x19]

    str	s5,	[sp, #1288]

    str	x20,	[sp, fp]

    movz	fp,	#3428
    ldr	w2,	[sp, #3560]

    lsl	w25,	w2,	#2
    ldr	x22,	[sp, fp]

    movz	fp,	#3420
    add	x23,	x22,	x25
    ldr	s9,	[x23]

    str	s9,	[sp, #1292]

    str	x16,	[sp, fp]

    movz	fp,	#3420
    ldr	w3,	[sp, #3560]

    lsl	w24,	w3,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#3412
    add	x0,	x17,	x24
    ldr	s28,	[x0]

    str	s28,	[sp, #1252]

    str	x12,	[sp, fp]

    movz	fp,	#3412
    ldr	w4,	[sp, #3560]

    lsl	w0,	w4,	#2
    ldr	x14,	[sp, fp]

    movz	fp,	#3404
    add	x4,	x14,	x0
    add	x0,	sp,	#124
    ldr	s1,	[x4]

    str	s1,	[sp, #1180]

    str	x8,	[sp, fp]

    movz	fp,	#3404
    ldr	w5,	[sp, #3560]

    lsl	w4,	w5,	#2
    ldr	x10,	[sp, fp]

    movz	fp,	#3396
    add	x8,	x10,	x4
    add	x4,	sp,	#112
    ldr	s4,	[x8]

    str	s4,	[sp, #1208]

    str	x4,	[sp, fp]

    movz	fp,	#3396
    ldr	w6,	[sp, #3560]

    lsl	w10,	w6,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#3388
    add	x12,	x5,	x10
    ldr	s1,	[x12]

    str	s1,	[sp, #1204]

    str	x0,	[sp, fp]

    movz	fp,	#3388
    ldr	w7,	[sp, #3560]

    lsl	w14,	w7,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3372
    add	x16,	x1,	x14
    add	x14,	sp,	#208
    add	x1,	sp,	#160
    ldr	s17,	[x16]

    str	s17,	[sp, #1296]

    str	x21,	[sp, fp]

    movz	fp,	#3372
    ldr	w8,	[sp, #3560]

    lsl	w16,	w8,	#2
    ldr	x23,	[sp, fp]

    movz	fp,	#3348
    add	x20,	x23,	x16
    add	x23,	sp,	#268
    ldr	s24,	[x20]

    str	s24,	[sp, #1300]

    str	x9,	[sp, fp]

    movz	fp,	#3348
    ldr	w9,	[sp, #3560]

    lsl	w22,	w9,	#2
    ldr	x10,	[sp, fp]

    movz	fp,	#3332
    add	x24,	x10,	x22
    add	x22,	sp,	#184
    ldr	s29,	[x24]

    str	s29,	[sp, #1304]

    str	x1,	[sp, fp]

    movz	fp,	#3332
    ldr	w10,	[sp, #3560]

    lsl	w26,	w10,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3324
    add	x1,	x2,	x26
    add	x26,	sp,	#172
    ldr	s18,	[x1]

    str	s18,	[sp, #1220]

    str	x26,	[sp, fp]

    movz	fp,	#3324
    ldr	w11,	[sp, #3560]

    lsl	w2,	w11,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#3316
    add	x5,	x28,	x2
    add	x28,	sp,	#328
    add	x2,	sp,	#244
    ldr	s3,	[x5]

    str	s3,	[sp, #1312]

    str	x22,	[sp, fp]

    movz	fp,	#3316
    ldr	w12,	[sp, #3560]

    lsl	w6,	w12,	#2
    ldr	x24,	[sp, fp]

    movz	fp,	#3308
    add	x9,	x24,	x6
    add	x6,	sp,	#232
    ldr	s7,	[x9]

    str	s7,	[sp, #1316]

    str	x18,	[sp, fp]

    movz	fp,	#3308
    ldr	w13,	[sp, #3560]

    lsl	w10,	w13,	#2
    ldr	x20,	[sp, fp]

    movz	fp,	#3300
    add	x13,	x20,	x10
    add	x10,	sp,	#220
    ldr	s12,	[x13]

    add	x13,	sp,	#436
    str	s12,	[sp, #1320]

    str	x14,	[sp, fp]

    movz	fp,	#3300
    ldr	w14,	[sp, #3560]

    lsl	w14,	w14,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#3292
    add	x17,	x16,	x14
    ldr	s24,	[x17]

    str	s24,	[sp, #1248]

    str	x10,	[sp, fp]

    movz	fp,	#3292
    ldr	w15,	[sp, #3560]

    lsl	w20,	w15,	#2
    ldr	x11,	[sp, fp]

    add	x15,	sp,	#292
    movz	fp,	#3284
    add	x21,	x11,	x20
    add	x11,	sp,	#304
    ldr	s18,	[x21]

    str	s18,	[sp, #1272]

    str	x6,	[sp, fp]

    movz	fp,	#3284
    ldr	w16,	[sp, #3560]

    lsl	w24,	w16,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#3276
    add	x25,	x7,	x24
    add	x7,	sp,	#316
    ldr	s20,	[x25]

    str	s20,	[sp, #1324]

    str	x2,	[sp, fp]

    movz	fp,	#3276
    ldr	w17,	[sp, #3560]

    lsl	w0,	w17,	#2
    ldr	x4,	[sp, fp]

    add	x17,	sp,	#424
    movz	fp,	#3268
    add	x2,	x4,	x0
    ldr	s26,	[x2]

    str	s26,	[sp, #1328]

    str	x27,	[sp, fp]

    movz	fp,	#3268
    ldr	w18,	[sp, #3560]

    lsl	w8,	w18,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3260
    add	x6,	x0,	x8
    ldr	s4,	[x6]

    str	s4,	[sp, #1232]

    str	x23,	[sp, fp]

    movz	fp,	#3260
    ldr	w19,	[sp, #3560]

    lsl	w8,	w19,	#2
    ldr	x25,	[sp, fp]

    add	x19,	sp,	#280
    movz	fp,	#3252
    add	x10,	x25,	x8
    ldr	s18,	[x10]

    str	s18,	[sp, #1244]

    str	x19,	[sp, fp]

    movz	fp,	#3252
    ldr	w20,	[sp, #3560]

    lsl	w12,	w20,	#2
    ldr	x21,	[sp, fp]

    add	x20,	sp,	#340
    movz	fp,	#3244
    add	x14,	x21,	x12
    ldr	s31,	[x14]

    str	s31,	[sp, #1336]

    str	x15,	[sp, fp]

    movz	fp,	#3244
    ldr	w21,	[sp, #3560]

    lsl	w18,	w21,	#2
    ldr	x16,	[sp, fp]

    add	x21,	sp,	#412
    movz	fp,	#3236
    add	x18,	x16,	x18
    add	x16,	sp,	#352
    ldr	s4,	[x18]

    str	s4,	[sp, #1340]

    str	x11,	[sp, fp]

    movz	fp,	#3236
    ldr	w22,	[sp, #3560]

    lsl	w22,	w22,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#3228
    add	x22,	x12,	x22
    ldr	s8,	[x22]

    str	s8,	[sp, #1344]

    str	x7,	[sp, fp]

    movz	fp,	#3228
    ldr	w23,	[sp, #3560]

    lsl	w26,	w23,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3212
    add	x27,	x8,	x26
    add	x8,	sp,	#364
    ldr	s14,	[x27]

    str	s14,	[sp, #1348]

    str	x28,	[sp, fp]

    movz	fp,	#3212
    ldr	w24,	[sp, #3560]

    lsl	w4,	w24,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3196
    add	x3,	x0,	x4
    add	x0,	sp,	#388
    add	x4,	sp,	#376
    ldr	s7,	[x3]

    str	s7,	[sp, #1264]

    str	x20,	[sp, fp]

    movz	fp,	#3196
    ldr	w25,	[sp, #3560]

    lsl	w6,	w25,	#2
    ldr	x22,	[sp, fp]

    add	x25,	sp,	#400
    movz	fp,	#3188
    add	x7,	x22,	x6
    ldr	s22,	[x7]

    str	s22,	[sp, #1352]

    str	x16,	[sp, fp]

    movz	fp,	#3188
    ldr	w26,	[sp, #3560]

    lsl	w10,	w26,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#3172
    add	x11,	x18,	x10
    ldr	s28,	[x11]

    str	s28,	[sp, #1356]

    str	x8,	[sp, fp]

    movz	fp,	#3172
    ldr	w27,	[sp, #3560]

    lsl	w16,	w27,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#3164
    add	x15,	x9,	x16
    add	x9,	sp,	#448
    ldr	s4,	[x15]

    str	s4,	[sp, #1260]

    str	x4,	[sp, fp]

    movz	fp,	#3164
    ldr	w28,	[sp, #3560]

    lsl	w20,	w28,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#3156
    add	x19,	x5,	x20
    ldr	s12,	[x19]

    str	s12,	[sp, #1216]

    str	x0,	[sp, fp]

    movz	fp,	#3156
    ldr	w0,	[sp, #3560]

    lsl	w24,	w0,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3148
    add	x23,	x1,	x24
    ldr	s2,	[x23]

    str	s2,	[sp, #1360]

    str	x25,	[sp, fp]

    movz	fp,	#3148
    ldr	w1,	[sp, #3560]

    lsl	w1,	w1,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3140
    add	x0,	x27,	x1
    add	x1,	sp,	#472
    ldr	s6,	[x0]

    str	s6,	[sp, #1364]

    str	x21,	[sp, fp]

    movz	fp,	#3140
    ldr	w2,	[sp, #3560]

    lsl	w4,	w2,	#2
    ldr	x23,	[sp, fp]

    movz	fp,	#3132
    add	x4,	x23,	x4
    ldr	s7,	[x4]

    str	s7,	[sp, #1236]

    str	x17,	[sp, fp]

    movz	fp,	#3132
    ldr	w3,	[sp, #3560]

    lsl	w8,	w3,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#3124
    add	x8,	x19,	x8
    ldr	s1,	[x8]

    str	s1,	[sp, #1256]

    str	x13,	[sp, fp]

    movz	fp,	#3124
    ldr	w4,	[sp, #3560]

    lsl	w12,	w4,	#2
    ldr	x15,	[sp, fp]

    movz	fp,	#3116
    add	x12,	x15,	x12
    ldr	s10,	[x12]

    str	s10,	[sp, #1368]

    str	x9,	[sp, fp]

    movz	fp,	#3116
    ldr	w5,	[sp, #3560]

    lsl	w18,	w5,	#2
    ldr	x10,	[sp, fp]

    add	x5,	sp,	#460
    movz	fp,	#3108
    add	x16,	x10,	x18
    ldr	s12,	[x16]

    str	s12,	[sp, #1268]

    str	x5,	[sp, fp]

    movz	fp,	#3108
    ldr	w6,	[sp, #3560]

    lsl	w22,	w6,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#3100
    add	x20,	x6,	x22
    add	x22,	sp,	#484
    ldr	s7,	[x20]

    str	s7,	[sp, #1212]

    str	x1,	[sp, fp]

    movz	fp,	#3100
    ldr	w7,	[sp, #3560]

    lsl	w26,	w7,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3084
    add	x24,	x2,	x26
    ldr	s28,	[x24]

    str	s28,	[sp, #1228]

    str	x22,	[sp, fp]

    movz	fp,	#3084
    ldr	w8,	[sp, #3560]

    lsl	w2,	w8,	#2
    ldr	x24,	[sp, fp]

    add	x1,	x24,	x2
    ldr	s12,	[x1]

    str	s12,	[sp, #1240]

    ldr	s5,	[sp, #1280]

    str	s5,	[sp, #1092]

    ldr	s25,	[sp, #1224]

    ldr	s2,	[sp, #1284]

    fmov	s7,	s25
    fmov	s4,	s2
    ldr	s2,	[sp, #1288]

    ldr	s26,	[sp, #1292]

    fmov	s1,	s2
    ldr	s30,	[sp, #1252]

    fmov	s8,	s26
    ldr	s14,	[sp, #1180]

    fmov	s31,	s30
    ldr	s28,	[sp, #1208]

    fmov	s18,	s14
    ldr	s23,	[sp, #1204]

    fmov	s25,	s28
    ldr	s13,	[sp, #1296]

    fmov	s26,	s23
    ldr	s22,	[sp, #1300]

    fmov	s21,	s13
    str	s22,	[sp, #1428]

    ldr	s30,	[sp, #1304]

    str	s30,	[sp, #1432]

    ldr	s13,	[sp, #1220]

    str	s13,	[sp, #1440]

    ldr	s29,	[sp, #1312]

    str	s29,	[sp, #1436]

    ldr	s20,	[sp, #1316]

    str	s20,	[sp, #1372]

    ldr	s29,	[sp, #1320]

    str	s29,	[sp, #1376]

    ldr	s10,	[sp, #1248]

    str	s10,	[sp, #1384]

    ldr	s27,	[sp, #1272]

    str	s27,	[sp, #1380]

    ldr	s20,	[sp, #1324]

    str	s20,	[sp, #1392]

    ldr	s29,	[sp, #1328]

    str	s29,	[sp, #1444]

    ldr	s10,	[sp, #1232]

    str	s10,	[sp, #1452]

    ldr	s27,	[sp, #1244]

    str	s27,	[sp, #1448]

    ldr	s17,	[sp, #1336]

    str	s17,	[sp, #1456]

    ldr	s28,	[sp, #1340]

    str	s28,	[sp, #1460]

    ldr	s2,	[sp, #1344]

    fmov	s9,	s2
    str	s9,	[sp, #1468]

    ldr	s10,	[sp, #1348]

    fmov	s24,	s10
    str	s24,	[sp, #1464]

    ldr	s24,	[sp, #1264]

    ldr	s20,	[sp, #1352]

    fmov	s15,	s24
    fmov	s24,	s20
    str	s24,	[sp, #1480]

    ldr	s5,	[sp, #1356]

    fmov	s12,	s5
    str	s12,	[sp, #1484]

    ldr	s2,	[sp, #1260]

    ldr	s3,	[sp, #1216]

    fmov	s9,	s2
    ldr	s5,	[sp, #1360]

    str	s5,	[sp, #1096]

    ldr	s30,	[sp, #1364]

    fmov	s14,	s30
    str	s14,	[sp, #1120]

    ldr	s20,	[sp, #1236]

    fmov	s29,	s20
    str	s29,	[sp, #1128]

    ldr	s14,	[sp, #1256]

    str	s14,	[sp, #1140]

    ldr	s19,	[sp, #1368]

    str	s19,	[sp, #1148]

    ldr	s16,	[sp, #1268]

    str	s16,	[sp, #1156]

    ldr	s5,	[sp, #1212]

    str	s5,	[sp, #1164]

    ldr	s19,	[sp, #1228]

    str	s19,	[sp, #1168]

    ldr	s29,	[sp, #1240]

    str	s29,	[sp, #1188]


main_148:
    movi	v2.4s,	#0
    ldr	s16,	[sp, #1188]

    fmov	s22,	s2
    fcmp	s16,	s22
    beq	main_305

main_190:
    ldr	s13,	[sp, #1092]

    add	x1,	sp,	#784
    add	x19,	sp,	#788
    add	x20,	sp,	#792
    add	x21,	sp,	#796
    add	x0,	sp,	#800
    add	x23,	sp,	#804
    add	x25,	sp,	#808
    add	x28,	sp,	#816
    fadd	s10,	s13,	s7
    str	s10,	[sp, #1688]

    ldr	s13,	[sp, #1688]

    fadd	s14,	s13,	s4
    str	s14,	[sp, #1692]

    ldr	s10,	[sp, #1692]

    fadd	s13,	s10,	s1
    fadd	s10,	s8,	s31
    str	s13,	[sp, #1196]

    str	s10,	[sp, #1696]

    ldr	s12,	[sp, #1696]

    fadd	s12,	s12,	s18
    str	s12,	[sp, #1700]

    ldr	s10,	[sp, #1700]

    fadd	s12,	s10,	s25
    fadd	s10,	s26,	s21
    str	s12,	[sp, #1184]

    str	s10,	[sp, #1704]

    ldr	s10,	[sp, #1428]

    ldr	s12,	[sp, #1704]

    fadd	s12,	s12,	s10
    str	s12,	[sp, #1708]

    ldr	s12,	[sp, #1432]

    ldr	s14,	[sp, #1708]

    fadd	s12,	s14,	s12
    str	s12,	[sp, #1572]

    ldr	s13,	[sp, #1436]

    ldr	s8,	[sp, #1440]

    fadd	s10,	s8,	s13
    str	s10,	[sp, #1624]

    ldr	s10,	[sp, #1372]

    ldr	s12,	[sp, #1624]

    fadd	s12,	s12,	s10
    str	s12,	[sp, #1628]

    ldr	s12,	[sp, #1376]

    ldr	s14,	[sp, #1628]

    fadd	s12,	s14,	s12
    str	s12,	[sp, #1564]

    ldr	s10,	[sp, #1380]

    ldr	s12,	[sp, #1384]

    fadd	s8,	s12,	s10
    str	s8,	[sp, #1612]

    ldr	s14,	[sp, #1392]

    ldr	s10,	[sp, #1612]

    fadd	s8,	s10,	s14
    str	s8,	[sp, #1616]

    ldr	s14,	[sp, #1444]

    ldr	s12,	[sp, #1616]

    fadd	s10,	s12,	s14
    str	s10,	[sp, #1536]

    ldr	s13,	[sp, #1448]

    ldr	s14,	[sp, #1452]

    fadd	s14,	s14,	s13
    str	s14,	[sp, #1600]

    ldr	s14,	[sp, #1456]

    ldr	s8,	[sp, #1600]

    fadd	s12,	s8,	s14
    str	s12,	[sp, #1604]

    ldr	s14,	[sp, #1460]

    ldr	s8,	[sp, #1604]

    fadd	s12,	s8,	s14
    str	s12,	[sp, #1532]

    ldr	s14,	[sp, #1464]

    ldr	s10,	[sp, #1468]

    fadd	s12,	s10,	s14
    str	s12,	[sp, #1588]

    ldr	s14,	[sp, #1588]

    fadd	s8,	s14,	s15
    str	s8,	[sp, #1592]

    ldr	s13,	[sp, #1480]

    ldr	s12,	[sp, #1592]

    fadd	s15,	s12,	s13
    str	s15,	[sp, #1524]

    ldr	s14,	[sp, #1484]

    fadd	s12,	s14,	s9
    str	s12,	[sp, #1568]

    ldr	s13,	[sp, #1568]

    fadd	s14,	s13,	s3
    str	s14,	[sp, #1544]

    ldr	s12,	[sp, #1096]

    ldr	s15,	[sp, #1544]

    fadd	s10,	s15,	s12
    str	s10,	[sp, #1520]

    ldr	s10,	[sp, #1120]

    ldr	s14,	[sp, #1128]

    fadd	s10,	s10,	s14
    str	s10,	[sp, #1548]

    ldr	s10,	[sp, #1140]

    ldr	s8,	[sp, #1548]

    fadd	s14,	s8,	s10
    str	s14,	[sp, #1552]

    ldr	s10,	[sp, #1148]

    ldr	s15,	[sp, #1552]

    fadd	s8,	s15,	s10
    str	s8,	[sp, #1528]

    ldr	s14,	[sp, #1156]

    ldr	s8,	[sp, #1164]

    fadd	s8,	s14,	s8
    str	s8,	[sp, #1556]

    ldr	s8,	[sp, #1168]

    ldr	s12,	[sp, #1556]

    fadd	s13,	s12,	s8
    str	s13,	[sp, #1560]

    ldr	s14,	[sp, #1188]

    ldr	s13,	[sp, #1560]

    fadd	s12,	s13,	s14
    str	s12,	[sp, #1540]

    ldr	s12,	[sp, #1196]

    str	s12,	[x1]

    ldr	s14,	[sp, #1184]

    str	s14,	[x19]

    ldr	s15,	[sp, #1572]

    str	s15,	[x20]

    ldr	s8,	[sp, #1564]

    str	s8,	[x21]

    ldr	s8,	[sp, #1536]

    str	s8,	[x0]

    add	x0,	sp,	#812
    ldr	s14,	[sp, #1532]

    str	s14,	[x23]

    ldr	s14,	[sp, #1524]

    str	s14,	[x25]

    ldr	s12,	[sp, #1520]

    str	s12,	[x0]

    add	x0,	sp,	#820
    ldr	s10,	[sp, #1528]

    str	s10,	[x28]

    ldr	s13,	[sp, #1540]

    str	s13,	[x0]

    movz	w0,	#10
    bl	putfarray
    movz	fp,	#3500
    ldr	w9,	[sp, #3560]

    add	x27,	sp,	#772
    add	x28,	sp,	#556
    add	x14,	sp,	#628
    lsl	w19,	w9,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#784
    ldr	s24,	[x18]

    str	s24,	[sp, #1276]

    str	x27,	[sp, fp]

    movz	fp,	#3500
    ldr	w10,	[sp, #3560]

    lsl	w23,	w10,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3484
    add	x22,	x0,	x23
    add	x23,	sp,	#508
    add	x0,	sp,	#520
    ldr	w17,	[x22]

    str	w17,	[sp, #2520]

    add	x17,	sp,	#544
    ldr	w19,	[sp, #3560]

    lsl	w26,	w19,	#2
    add	x19,	sp,	#568
    add	x1,	x0,	x26
    ldr	w21,	[x1]

    str	w21,	[sp, #3556]

    str	x19,	[sp, fp]

    movz	fp,	#3484
    ldr	w12,	[sp, #3560]

    lsl	w1,	w12,	#2
    ldr	x21,	[sp, fp]

    movz	fp,	#3492
    add	x0,	x21,	x1
    ldr	w4,	[x0]

    str	w4,	[sp, #2432]

    str	x23,	[sp, fp]

    movz	fp,	#3492
    ldr	w13,	[sp, #3560]

    lsl	w15,	w13,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3476
    add	x3,	x25,	x15
    add	x15,	sp,	#760
    ldr	w22,	[x3]

    add	x3,	sp,	#724
    str	w22,	[sp, #3528]

    ldr	w22,	[sp, #3560]

    lsl	w26,	w22,	#2
    add	x18,	x17,	x26
    ldr	w5,	[x18]

    str	w5,	[sp, #3540]

    add	x5,	sp,	#616
    ldr	w21,	[sp, #3560]

    lsl	w17,	w21,	#2
    add	x27,	x28,	x17
    add	x28,	sp,	#700
    ldr	w26,	[x27]

    add	x27,	sp,	#496
    str	w26,	[sp, #3532]

    str	x15,	[sp, fp]

    movz	fp,	#3476
    ldr	w16,	[sp, #3560]

    lsl	w4,	w16,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#3380
    add	x20,	x17,	x4
    ldr	w13,	[x20]

    add	x20,	sp,	#652
    str	w13,	[sp, #6116]

    add	x13,	sp,	#580
    str	x27,	[sp, fp]

    movz	fp,	#3380
    ldr	w17,	[sp, #3560]

    lsl	w2,	w17,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3452
    add	x0,	x1,	x2
    ldr	w17,	[x0]

    str	w17,	[sp, #3552]

    str	x3,	[sp, fp]

    add	x3,	sp,	#604
    movz	fp,	#3452
    ldr	w18,	[sp, #3560]

    ldr	x6,	[sp, fp]

    lsl	w15,	w18,	#2
    movz	fp,	#3356
    add	x11,	x6,	x15
    add	x6,	sp,	#712
    ldr	w22,	[x11]

    str	w22,	[sp, #2256]

    str	x13,	[sp, fp]

    movz	fp,	#3356
    ldr	w21,	[sp, #3560]

    lsl	w10,	w21,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#3340
    add	x9,	x16,	x10
    add	x16,	sp,	#592
    ldr	w7,	[x9]

    str	w7,	[sp, #2188]

    str	x5,	[sp, fp]

    movz	fp,	#3340
    ldr	w22,	[sp, #3560]

    lsl	w2,	w22,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3364
    add	x2,	x8,	x2
    ldr	w10,	[x2]

    str	w10,	[sp, #6112]

    str	x20,	[sp, fp]

    movz	fp,	#3364
    ldr	w25,	[sp, #3560]

    lsl	w8,	w25,	#2
    ldr	x24,	[sp, fp]

    movz	fp,	#3220
    add	x7,	x24,	x8
    ldr	w7,	[x7]

    str	w7,	[sp, #6108]

    ldr	w0,	[sp, #3560]

    lsl	w9,	w0,	#2
    add	x12,	x16,	x9
    ldr	w16,	[x12]

    str	w16,	[sp, #3520]

    ldr	w1,	[sp, #3560]

    lsl	w18,	w1,	#2
    add	x23,	x28,	x18
    ldr	w11,	[x23]

    str	w11,	[sp, #3544]

    ldr	w2,	[sp, #3560]

    lsl	w0,	w2,	#2
    add	x28,	x6,	x0
    ldr	w1,	[x28]

    str	w1,	[sp, #3536]

    ldr	w6,	[sp, #3560]

    lsl	w21,	w6,	#2
    add	x6,	x3,	x21
    add	x3,	sp,	#640
    ldr	w8,	[x6]

    str	w8,	[sp, #3512]

    add	x8,	sp,	#748
    str	x3,	[sp, fp]

    add	x3,	sp,	#688
    movz	fp,	#3220
    ldr	w1,	[sp, #3560]

    ldr	x2,	[sp, fp]

    lsl	w15,	w1,	#2
    movz	fp,	#3180
    add	x11,	x2,	x15
    ldr	w27,	[x11]

    str	w27,	[sp, #5456]

    str	x14,	[sp, fp]

    movz	fp,	#3180
    ldr	w1,	[sp, #3560]

    lsl	w0,	w1,	#2
    ldr	x12,	[sp, fp]

    add	x1,	sp,	#532
    movz	fp,	#3204
    add	x23,	x12,	x0
    ldr	w27,	[x23]

    str	w27,	[sp, #5432]

    str	x3,	[sp, fp]

    movz	fp,	#3204
    ldr	w3,	[sp, #3560]

    lsl	w10,	w3,	#2
    ldr	x2,	[sp, fp]

    add	x3,	sp,	#736
    movz	fp,	#3092
    add	x7,	x2,	x10
    ldr	w9,	[x7]

    str	w9,	[sp, #5416]

    str	x1,	[sp, fp]

    movz	fp,	#3092
    ldr	w0,	[sp, #3560]

    lsl	w9,	w0,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3076
    add	x6,	x2,	x9
    ldr	w17,	[x6]

    str	w17,	[sp, #3548]

    ldr	w10,	[sp, #3560]

    lsl	w2,	w10,	#2
    add	x6,	x8,	x2
    ldr	w26,	[x6]

    str	w26,	[sp, #3524]

    add	x26,	sp,	#676
    ldr	w12,	[sp, #3560]

    lsl	w7,	w12,	#2
    add	x6,	x3,	x7
    ldr	w12,	[x6]

    str	w12,	[sp, #3516]

    str	x26,	[sp, fp]

    movz	fp,	#3076
    ldr	w3,	[sp, #3560]

    lsl	w12,	w3,	#2
    ldr	x21,	[sp, fp]

    add	x11,	x21,	x12
    add	x21,	sp,	#664
    ldr	w22,	[x11]

    ldr	w14,	[sp, #3560]

    lsl	w3,	w14,	#2
    add	x2,	x21,	x3
    ldr	w2,	[x2]

    str	w2,	[sp, #3508]

    ldr	w21,	[sp, #2520]

    mov	w17,	w21
    str	w17,	[sp, #2468]

    ldr	w27,	[sp, #3556]

    mov	w11,	w27
    str	w11,	[sp, #9576]

    ldr	w6,	[sp, #2432]

    mov	w1,	w6
    str	w1,	[sp, #5436]

    ldr	s12,	[sp, #1292]

    ldr	w3,	[sp, #3528]

    fmov	s31,	s12
    mov	w6,	w3
    str	w6,	[sp, #5440]

    ldr	w7,	[sp, #3540]

    mov	w16,	w7
    str	w16,	[sp, #9580]

    ldr	w2,	[sp, #3532]

    mov	w21,	w2
    str	w21,	[sp, #6596]

    ldr	s29,	[sp, #1204]

    ldr	s10,	[sp, #1320]

    fmov	s18,	s29
    ldr	s7,	[sp, #1208]

    fmov	s24,	s10
    ldr	w15,	[sp, #6116]

    fmov	s8,	s7
    mov	w17,	w15
    str	w17,	[sp, #2328]

    ldr	s17,	[sp, #1288]

    fmov	s10,	s17
    ldr	s17,	[sp, #1356]

    str	s17,	[sp, #1668]

    ldr	w2,	[sp, #3552]

    mov	w6,	w2
    str	w6,	[sp, #9572]

    ldr	s1,	[sp, #1212]

    str	s1,	[sp, #1712]

    ldr	w11,	[sp, #2256]

    mov	w7,	w11
    str	w7,	[sp, #2292]

    ldr	s12,	[sp, #1216]

    str	s12,	[sp, #1664]

    ldr	s25,	[sp, #1220]

    ldr	s15,	[sp, #1224]

    fmov	s23,	s25
    ldr	s22,	[sp, #1304]

    fmov	s19,	s15
    ldr	s26,	[sp, #1228]

    fmov	s9,	s22
    str	s26,	[sp, #1684]

    ldr	s26,	[sp, #1180]

    ldr	w13,	[sp, #2188]

    fmov	s15,	s26
    mov	w27,	w13
    str	w27,	[sp, #6600]

    ldr	s1,	[sp, #1364]

    str	s1,	[sp, #1680]

    ldr	w13,	[sp, #6112]

    mov	w21,	w13
    str	w21,	[sp, #5448]

    ldr	w10,	[sp, #6108]

    mov	w7,	w10
    str	w7,	[sp, #5468]

    ldr	s22,	[sp, #1232]

    str	s22,	[sp, #1648]

    ldr	s29,	[sp, #1236]

    str	s29,	[sp, #1112]

    ldr	s29,	[sp, #1340]

    str	s29,	[sp, #1652]

    ldr	s6,	[sp, #1296]

    ldr	s28,	[sp, #1348]

    fmov	s1,	s6
    str	s28,	[sp, #1656]

    ldr	w4,	[sp, #3520]

    mov	w21,	w4
    str	w21,	[sp, #5424]

    ldr	s2,	[sp, #1240]

    str	s2,	[sp, #1124]

    ldr	w24,	[sp, #3544]

    mov	w11,	w24
    str	w11,	[sp, #2224]

    ldr	s26,	[sp, #1244]

    fmov	s20,	s26
    str	s20,	[sp, #1104]

    ldr	s20,	[sp, #1248]

    fmov	s6,	s20
    str	s6,	[sp, #2140]

    ldr	s22,	[sp, #1252]

    ldr	s29,	[sp, #1256]

    fmov	s30,	s22
    str	s29,	[sp, #1132]

    ldr	w7,	[sp, #3536]

    str	w7,	[sp, #2260]

    ldr	w14,	[sp, #3512]

    mov	w27,	w14
    str	w27,	[sp, #5428]

    ldr	s6,	[sp, #1316]

    ldr	s26,	[sp, #1300]

    fmov	s29,	s6
    ldr	s22,	[sp, #1280]

    fmov	s3,	s26
    ldr	w7,	[sp, #5456]

    fmov	s20,	s22
    mov	w14,	w7
    str	w14,	[sp, #5444]

    ldr	s28,	[sp, #1360]

    str	s28,	[sp, #1116]

    ldr	w7,	[sp, #5432]

    mov	w14,	w7
    str	w14,	[sp, #5420]

    ldr	w12,	[sp, #5416]

    mov	w27,	w12
    str	w27,	[sp, #5452]

    ldr	s21,	[sp, #1352]

    fmov	s14,	s21
    str	s14,	[sp, #1080]

    ldr	s14,	[sp, #1344]

    ldr	s22,	[sp, #1312]

    fmov	s13,	s14
    fmov	s7,	s22
    ldr	s22,	[sp, #1260]

    str	s22,	[sp, #1084]

    ldr	w15,	[sp, #3548]

    ldr	w5,	[sp, #3524]

    mov	w23,	w15
    str	w5,	[sp, #6104]

    ldr	w14,	[sp, #3516]

    mov	w0,	w14
    str	w0,	[sp, #7556]

    ldr	s12,	[sp, #1324]

    ldr	s17,	[sp, #1328]

    fmov	s5,	s12
    ldr	s4,	[sp, #1336]

    fmov	s12,	s17
    ldr	s16,	[sp, #1264]

    fmov	s25,	s4
    fmov	s2,	s16
    ldr	s4,	[sp, #1268]

    str	s4,	[sp, #1152]

    ldr	s28,	[sp, #1272]

    ldr	s16,	[sp, #1284]

    fmov	s4,	s28
    str	s16,	[sp, #1088]

    ldr	w11,	[sp, #3508]

    ldr	s27,	[sp, #1368]

    mov	w26,	w11
    str	s27,	[sp, #1144]


main_309:
    ldr	w18,	[sp, #2468]

    cmp	w18,	#0
    beq	main_308

main_375:
    fadd	s14,	s20,	s19
    ldr	s11,	[sp, #1088]

    add	x18,	sp,	#944
    movz	fp,	#2156
    add	x24,	sp,	#948
    fadd	s14,	s14,	s11
    fadd	s11,	s14,	s10
    fadd	s14,	s31,	s30
    str	s11,	[sp, #1200]

    fadd	s14,	s14,	s15
    fadd	s10,	s14,	s8
    fadd	s8,	s18,	s1
    str	s10,	[sp, #1192]

    fadd	s14,	s8,	s3
    fadd	s8,	s23,	s7
    fadd	s10,	s14,	s9
    fadd	s8,	s8,	s29
    str	s10,	[sp, #1176]

    fadd	s11,	s8,	s24
    str	s11,	[sp, #1160]

    ldr	s8,	[sp, #2140]

    fadd	s14,	s8,	s4
    fadd	s14,	s14,	s5
    fadd	s15,	s14,	s12
    str	s15,	[sp, #1728]

    ldr	s14,	[sp, #1648]

    ldr	s11,	[sp, #1104]

    ldr	s10,	[sp, #1652]

    fadd	s14,	s14,	s11
    fadd	s9,	s14,	s25
    fadd	s11,	s9,	s10
    str	s11,	[sp, #1724]

    ldr	s15,	[sp, #1656]

    fadd	s13,	s13,	s15
    ldr	s15,	[sp, #1080]

    fadd	s8,	s13,	s2
    fadd	s14,	s8,	s15
    str	s14,	[sp, #2116]

    ldr	s8,	[sp, #1084]

    ldr	s12,	[sp, #1668]

    ldr	s15,	[sp, #1664]

    fadd	s9,	s12,	s8
    ldr	s13,	[sp, #1116]

    fadd	s9,	s9,	s15
    fadd	s10,	s9,	s13
    str	s10,	[sp, #2112]

    ldr	s8,	[sp, #1112]

    ldr	s11,	[sp, #1680]

    ldr	s13,	[sp, #1132]

    fadd	s8,	s11,	s8
    ldr	s9,	[sp, #1144]

    fadd	s13,	s8,	s13
    fadd	s11,	s13,	s9
    ldr	s9,	[sp, #1152]

    ldr	s15,	[sp, #1712]

    ldr	s8,	[sp, #1684]

    fadd	s14,	s9,	s15
    ldr	s9,	[sp, #1124]

    fadd	s13,	s14,	s8
    str	x18,	[sp, fp]

    fadd	s15,	s13,	s9
    movz	fp,	#2156
    ldr	s13,	[sp, #1200]

    ldr	x18,	[sp, fp]

    movz	fp,	#3796
    str	s13,	[x18]

    ldr	s9,	[sp, #1192]

    str	s9,	[x24]

    ldr	s13,	[sp, #1176]

    add	x24,	sp,	#952
    str	s13,	[x24]

    ldr	s9,	[sp, #1160]

    add	x24,	sp,	#956
    str	s9,	[x24]

    ldr	s10,	[sp, #1728]

    add	x24,	sp,	#960
    str	s10,	[x24]

    ldr	s14,	[sp, #1724]

    add	x24,	sp,	#964
    str	s14,	[x24]

    ldr	s8,	[sp, #2116]

    add	x24,	sp,	#968
    str	s8,	[x24]

    ldr	s10,	[sp, #2112]

    add	x24,	sp,	#972
    str	s10,	[x24]

    add	x24,	sp,	#976
    str	s11,	[x24]

    add	x24,	sp,	#980
    str	s15,	[x24]

    ldr	w18,	[sp, #5440]

    ldr	w21,	[sp, #9576]

    add	w21,	w18,	w21
    ldr	w18,	[sp, #9572]

    add	w21,	w21,	w18
    str	w21,	[sp, #5032]

    ldr	w18,	[sp, #9580]

    ldr	w0,	[sp, #6596]

    add	w24,	w0,	w18
    add	w24,	w24,	w23
    str	w24,	[sp, #2228]

    ldr	w23,	[sp, #5436]

    ldr	w21,	[sp, #6600]

    ldr	w27,	[sp, #5424]

    add	w21,	w21,	w23
    add	x23,	sp,	#1000
    add	w21,	w21,	w27
    str	w21,	[sp, #2232]

    ldr	w1,	[sp, #5428]

    ldr	w28,	[sp, #5448]

    ldr	w20,	[sp, #5420]

    add	w0,	w1,	w28
    add	w0,	w0,	w20
    str	w0,	[sp, #5084]

    ldr	w25,	[sp, #5444]

    ldr	w20,	[sp, #5468]

    add	w19,	w25,	w20
    add	x25,	sp,	#988
    add	w27,	w19,	w26
    add	x26,	sp,	#984
    str	w27,	[sp, #2344]

    ldr	w19,	[sp, #2224]

    ldr	w0,	[sp, #5452]

    add	w0,	w0,	w19
    add	w27,	w0,	w22
    str	w27,	[sp, #2348]

    ldr	w0,	[sp, #2260]

    ldr	w1,	[sp, #2292]

    add	w22,	w0,	w1
    ldr	w0,	[sp, #7556]

    add	w1,	w22,	w0
    str	w1,	[sp, #2240]

    ldr	w0,	[sp, #2328]

    ldr	w1,	[sp, #2468]

    ldr	w24,	[sp, #6104]

    add	w1,	w0,	w1
    add	w24,	w1,	w24
    str	w24,	[sp, #2080]

    str	x26,	[sp, #4920]

    ldr	x21,	[sp, #4920]

    ldr	w0,	[sp, #5032]

    str	w0,	[x21]

    add	x21,	sp,	#992
    str	x25,	[sp, fp]

    add	x25,	sp,	#996
    movz	fp,	#3796
    ldr	w22,	[sp, #2228]

    ldr	x26,	[sp, fp]

    movz	fp,	#3812
    str	w22,	[x26]

    str	x21,	[sp, fp]

    movz	fp,	#3812
    ldr	w27,	[sp, #2232]

    ldr	x22,	[sp, fp]

    movz	fp,	#3820
    str	w27,	[x22]

    str	x25,	[sp, fp]

    movz	fp,	#3820
    ldr	x18,	[sp, fp]

    movz	fp,	#2156
    ldr	w25,	[sp, #5084]

    str	w25,	[x18]

    add	x25,	sp,	#1008
    str	x23,	[sp, #4936]

    ldr	w0,	[sp, #2344]

    ldr	x24,	[sp, #4936]

    str	w0,	[x24]

    add	x0,	sp,	#1004
    str	x0,	[sp, #2360]

    add	x0,	sp,	#1012
    ldr	w27,	[sp, #2348]

    ldr	x1,	[sp, #2360]

    str	w27,	[x1]

    str	x25,	[sp, #2376]

    ldr	w22,	[sp, #2240]

    ldr	x26,	[sp, #2376]

    str	w22,	[x26]

    str	x0,	[sp, #2384]

    movz	w0,	#10
    ldr	w26,	[sp, #2080]

    ldr	x1,	[sp, #2384]

    str	w26,	[x1]

    ldr	x1,	[sp, fp]

    bl	putfarray
    ldr	x1,	[sp, #4920]

    movz	w0,	#8
    bl	putarray
    ldr	w7,	[sp, #5032]

    movz	fp,	#3796
    ldr	s30,	[sp, #1200]

    scvtf	s9,	w7
    ldr	x3,	[sp, #4920]

    fsub	s9,	s9,	s30
    fcvtzs	w0,	s9
    str	w0,	[x3]

    ldr	w27,	[sp, #2228]

    ldr	s23,	[sp, #1192]

    scvtf	s12,	w27
    ldr	x3,	[sp, fp]

    fsub	s6,	s12,	s23
    movz	fp,	#3812
    fcvtzs	w4,	s6
    str	w4,	[x3]

    ldr	w1,	[sp, #2232]

    ldr	s5,	[sp, #1176]

    scvtf	s8,	w1
    ldr	x13,	[sp, fp]

    fsub	s22,	s8,	s5
    movz	fp,	#3820
    fcvtzs	w6,	s22
    str	w6,	[x13]

    ldr	w0,	[sp, #5084]

    ldr	s14,	[sp, #1160]

    scvtf	s24,	w0
    ldr	x17,	[sp, fp]

    fsub	s8,	s24,	s14
    movz	fp,	#3468
    fcvtzs	w9,	s8
    str	w9,	[x17]

    ldr	w5,	[sp, #2344]

    ldr	s13,	[sp, #1728]

    scvtf	s12,	w5
    ldr	x11,	[sp, #4936]

    fsub	s11,	s12,	s13
    fcvtzs	w13,	s11
    str	w13,	[x11]

    ldr	w9,	[sp, #2348]

    ldr	s9,	[sp, #1724]

    scvtf	s17,	w9
    ldr	x1,	[sp, #2360]

    fsub	s15,	s17,	s9
    fcvtzs	w16,	s15
    str	w16,	[x1]

    ldr	w17,	[sp, #2240]

    ldr	s12,	[sp, #2116]

    scvtf	s17,	w17
    ldr	x10,	[sp, #2376]

    fsub	s11,	s17,	s12
    fcvtzs	w19,	s11
    str	w19,	[x10]

    ldr	w21,	[sp, #2080]

    ldr	s8,	[sp, #2112]

    scvtf	s13,	w21
    ldr	x15,	[sp, #2384]

    fsub	s13,	s13,	s8
    fcvtzs	w2,	s13
    str	w2,	[x15]

    ldr	w5,	[sp, #3560]

    lsl	w4,	w5,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#984
    ldr	w5,	[x3]

    ldr	x13,	[sp, fp]

    scvtf	s12,	w5
    movz	fp,	#3460
    mov	x21,	x13
    str	x21,	[sp, #2400]

    ldr	x9,	[sp, fp]

    movz	fp,	#2956
    mov	x16,	x9
    str	x16,	[sp, fp]

    movz	fp,	#3444
    ldr	x1,	[sp, fp]

    movz	fp,	#3436
    mov	x28,	x1
    ldr	x26,	[sp, fp]

    movz	fp,	#3428
    mov	x24,	x26
    str	x24,	[sp, #2408]

    ldr	x22,	[sp, fp]

    movz	fp,	#3420
    mov	x3,	x22
    str	x3,	[sp, #4960]

    ldr	x18,	[sp, fp]

    movz	fp,	#2964
    mov	x20,	x18
    str	x20,	[sp, fp]

    movz	fp,	#3412
    ldr	x14,	[sp, fp]

    movz	fp,	#2972
    mov	x24,	x14
    str	x24,	[sp, fp]

    movz	fp,	#3404
    ldr	x10,	[sp, fp]

    movz	fp,	#2980
    mov	x0,	x10
    str	x0,	[sp, fp]

    movz	fp,	#3396
    ldr	x6,	[sp, fp]

    movz	fp,	#2988
    mov	x3,	x6
    str	x3,	[sp, fp]

    movz	fp,	#3388
    ldr	x2,	[sp, fp]

    movz	fp,	#3372
    mov	x11,	x2
    str	x11,	[sp, #4976]

    ldr	x23,	[sp, fp]

    movz	fp,	#3348
    mov	x19,	x23
    str	x19,	[sp, #4992]

    ldr	x11,	[sp, fp]

    movz	fp,	#3332
    mov	x22,	x11
    str	x22,	[sp, #5000]

    ldr	x3,	[sp, fp]

    movz	fp,	#2996
    mov	x7,	x3
    str	x7,	[sp, fp]

    movz	fp,	#3324
    ldr	x0,	[sp, fp]

    movz	fp,	#3316
    mov	x25,	x0
    str	x25,	[sp, #5008]

    ldr	x24,	[sp, fp]

    movz	fp,	#3308
    mov	x0,	x24
    str	x0,	[sp, #5016]

    ldr	x20,	[sp, fp]

    movz	fp,	#3300
    mov	x2,	x20
    str	x2,	[sp, #5024]

    ldr	x16,	[sp, fp]

    movz	fp,	#3004
    mov	x11,	x16
    str	x11,	[sp, fp]

    movz	fp,	#3292
    ldr	x12,	[sp, fp]

    movz	fp,	#3012
    mov	x15,	x12
    str	x15,	[sp, fp]

    movz	fp,	#3284
    ldr	x8,	[sp, fp]

    movz	fp,	#5036
    mov	x9,	x8
    str	x9,	[sp, fp]

    movz	fp,	#3276
    ldr	x4,	[sp, fp]

    movz	fp,	#5044
    mov	x12,	x4
    add	x4,	sp,	#904
    str	x12,	[sp, fp]

    movz	fp,	#3268
    ldr	x0,	[sp, fp]

    movz	fp,	#3020
    mov	x20,	x0
    str	x20,	[sp, fp]

    movz	fp,	#3260
    ldr	x27,	[sp, fp]

    movz	fp,	#3028
    mov	x25,	x27
    str	x25,	[sp, fp]

    movz	fp,	#3252
    ldr	x23,	[sp, fp]

    movz	fp,	#5052
    mov	x15,	x23
    add	x23,	sp,	#936
    str	x15,	[sp, fp]

    movz	fp,	#3244
    ldr	x18,	[sp, fp]

    movz	fp,	#5060
    str	x18,	[sp, fp]

    movz	fp,	#3236
    ldr	x16,	[sp, fp]

    movz	fp,	#5068
    mov	x21,	x16
    str	x21,	[sp, fp]

    movz	fp,	#3228
    ldr	x11,	[sp, fp]

    movz	fp,	#5076
    mov	x24,	x11
    str	x24,	[sp, fp]

    add	x24,	sp,	#908
    movz	fp,	#3212
    ldr	x1,	[sp, fp]

    movz	fp,	#3036
    mov	x3,	x1
    str	x3,	[sp, fp]

    movz	fp,	#3196
    ldr	x2,	[sp, fp]

    movz	fp,	#3188
    str	x2,	[sp, #5088]

    ldr	x0,	[sp, fp]

    movz	fp,	#3172
    mov	x5,	x0
    str	x5,	[sp, #5096]

    ldr	x19,	[sp, fp]

    movz	fp,	#3044
    mov	x2,	x19
    add	x19,	sp,	#924
    str	x2,	[sp, fp]

    movz	fp,	#3164
    ldr	x11,	[sp, fp]

    movz	fp,	#3052
    str	x11,	[sp, fp]

    movz	fp,	#3156
    ldr	x2,	[sp, fp]

    movz	fp,	#3148
    mov	x8,	x2
    str	x8,	[sp, #5104]

    ldr	x16,	[sp, fp]

    movz	fp,	#3140
    mov	x11,	x16
    add	x16,	sp,	#920
    str	x11,	[sp, #5112]

    ldr	x13,	[sp, fp]

    movz	fp,	#3060
    mov	x26,	x13
    str	x26,	[sp, fp]

    movz	fp,	#3132
    ldr	x11,	[sp, fp]

    movz	fp,	#3068
    mov	x2,	x11
    add	x11,	sp,	#912
    str	x2,	[sp, fp]

    movz	fp,	#3124
    ldr	x3,	[sp, fp]

    movz	fp,	#3116
    mov	x14,	x3
    str	x14,	[sp, #5120]

    ldr	x1,	[sp, fp]

    movz	fp,	#3108
    mov	x17,	x1
    str	x17,	[sp, #5128]

    ldr	x20,	[sp, fp]

    movz	fp,	#3100
    str	x20,	[sp, #5136]

    add	x20,	sp,	#916
    ldr	x18,	[sp, fp]

    movz	fp,	#3084
    mov	x26,	x18
    str	x26,	[sp, #5152]

    ldr	x7,	[sp, fp]

    movz	fp,	#2916
    mov	x3,	x7
    str	x3,	[sp, #5168]

    str	x4,	[sp, fp]

    add	x4,	sp,	#928
    movz	fp,	#2740
    str	x24,	[sp, fp]

    movz	fp,	#2748
    str	x11,	[sp, fp]

    movz	fp,	#2772
    str	x20,	[sp, #2760]

    str	x16,	[sp, fp]

    add	x16,	sp,	#932
    movz	fp,	#2780
    str	x19,	[sp, fp]

    movz	fp,	#2812
    str	x4,	[sp, #2792]

    add	x4,	sp,	#940
    str	x16,	[sp, #2800]

    str	x23,	[sp, fp]

    movz	fp,	#2820
    str	x4,	[sp, fp]

    movz	fp,	#5460
    ldr	x1,	[sp, #2400]

    str	x1,	[sp, fp]

    movz	fp,	#2956
    ldr	x23,	[sp, fp]

    movz	fp,	#2876
    mov	x18,	x23
    str	x18,	[sp, fp]

    movz	fp,	#2836
    mov	x18,	x28
    str	x18,	[sp, #1056]

    ldr	x25,	[sp, #2408]

    mov	x20,	x25
    str	x20,	[sp, #1040]

    ldr	x4,	[sp, #4960]

    mov	x0,	x4
    str	x0,	[sp, fp]

    movz	fp,	#2964
    ldr	x0,	[sp, fp]

    movz	fp,	#2972
    mov	x17,	x0
    str	x17,	[sp, #2848]

    ldr	x17,	[sp, fp]

    movz	fp,	#2980
    mov	x0,	x17
    str	x0,	[sp, #2856]

    ldr	x0,	[sp, fp]

    movz	fp,	#2988
    mov	x18,	x0
    str	x18,	[sp, #1016]

    ldr	x24,	[sp, fp]

    movz	fp,	#2828
    mov	x19,	x24
    str	x19,	[sp, #1024]

    ldr	x12,	[sp, #4976]

    mov	x17,	x12
    str	x17,	[sp, fp]

    movz	fp,	#2724
    ldr	x20,	[sp, #4992]

    mov	x27,	x20
    str	x27,	[sp, fp]

    movz	fp,	#2996
    ldr	x23,	[sp, #5000]

    mov	x24,	x23
    str	x24,	[sp, #2704]

    ldr	x11,	[sp, fp]

    movz	fp,	#2716
    mov	x0,	x11
    str	x0,	[sp, fp]

    movz	fp,	#2692
    ldr	x26,	[sp, #5008]

    mov	x13,	x26
    str	x13,	[sp, fp]

    movz	fp,	#2676
    ldr	x0,	[sp, #5016]

    mov	x23,	x0
    str	x23,	[sp, fp]

    movz	fp,	#2652
    ldr	x3,	[sp, #5024]

    mov	x23,	x3
    str	x23,	[sp, fp]

    movz	fp,	#3004
    ldr	x19,	[sp, fp]

    movz	fp,	#2660
    mov	x23,	x19
    str	x23,	[sp, fp]

    movz	fp,	#3012
    ldr	x19,	[sp, fp]

    movz	fp,	#2668
    mov	x11,	x19
    str	x11,	[sp, fp]

    movz	fp,	#5036
    ldr	x10,	[sp, fp]

    movz	fp,	#2644
    mov	x11,	x10
    str	x11,	[sp, fp]

    movz	fp,	#5044
    ldr	x13,	[sp, fp]

    movz	fp,	#2596
    mov	x28,	x13
    str	x28,	[sp, fp]

    movz	fp,	#3020
    ldr	x23,	[sp, fp]

    movz	fp,	#2612
    mov	x19,	x23
    str	x19,	[sp, fp]

    movz	fp,	#3028
    ldr	x0,	[sp, fp]

    movz	fp,	#2628
    mov	x16,	x0
    str	x16,	[sp, fp]

    movz	fp,	#5052
    ldr	x16,	[sp, fp]

    movz	fp,	#2580
    mov	x11,	x16
    str	x11,	[sp, fp]

    movz	fp,	#5060
    ldr	x19,	[sp, fp]

    movz	fp,	#2564
    str	x19,	[sp, fp]

    movz	fp,	#5068
    ldr	x22,	[sp, fp]

    movz	fp,	#2540
    mov	x12,	x22
    str	x12,	[sp, fp]

    movz	fp,	#5076
    ldr	x25,	[sp, fp]

    movz	fp,	#3036
    mov	x19,	x25
    str	x19,	[sp, #2504]

    ldr	x22,	[sp, fp]

    movz	fp,	#2524
    mov	x12,	x22
    str	x12,	[sp, fp]

    movz	fp,	#2332
    ldr	x3,	[sp, #5088]

    mov	x15,	x3
    str	x15,	[sp, #2480]

    ldr	x6,	[sp, #5096]

    str	x6,	[sp, fp]

    movz	fp,	#3044
    ldr	x13,	[sp, fp]

    movz	fp,	#2436
    mov	x14,	x13
    str	x14,	[sp, fp]

    movz	fp,	#3052
    ldr	x17,	[sp, fp]

    movz	fp,	#2452
    str	x17,	[sp, fp]

    movz	fp,	#2276
    ldr	x9,	[sp, #5104]

    mov	x6,	x9
    str	x6,	[sp, #2312]

    ldr	x12,	[sp, #5112]

    mov	x14,	x12
    str	x14,	[sp, fp]

    movz	fp,	#3060
    ldr	x17,	[sp, fp]

    movz	fp,	#2284
    mov	x19,	x17
    str	x19,	[sp, fp]

    movz	fp,	#3068
    ldr	x22,	[sp, fp]

    movz	fp,	#2268
    mov	x0,	x22
    str	x0,	[sp, #2296]

    ldr	x15,	[sp, #5120]

    mov	x7,	x15
    str	x7,	[sp, fp]

    ldr	x18,	[sp, #5128]

    mov	x20,	x18
    str	x20,	[sp, #2200]

    ldr	x21,	[sp, #5136]

    mov	x13,	x21
    str	x13,	[sp, #2192]

    ldr	x27,	[sp, #5152]

    mov	x17,	x27
    str	x17,	[sp, #2208]

    ldr	x4,	[sp, #5168]

    mov	x7,	x4
    str	x7,	[sp, #2168]


main_518:
    ldr	w6,	[sp, #3560]

    movz	fp,	#5460
    lsl	w19,	w6,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#2876
    add	x17,	x2,	x19
    ldr	s15,	[x17]

    ldr	w7,	[sp, #3560]

    ldr	x25,	[sp, fp]

    lsl	w8,	w7,	#2
    movz	fp,	#2836
    add	x21,	x25,	x8
    ldr	s2,	[x21]

    ldr	w8,	[sp, #3560]

    fadd	s21,	s15,	s2
    ldr	x12,	[sp, #1056]

    lsl	w22,	w8,	#2
    add	x2,	x12,	x22
    ldr	s6,	[x2]

    ldr	w9,	[sp, #3560]

    fadd	s25,	s21,	s6
    ldr	x3,	[sp, #1040]

    lsl	w2,	w9,	#2
    add	x6,	x3,	x2
    ldr	s8,	[x6]

    ldr	w10,	[sp, #3560]

    fadd	s5,	s25,	s8
    ldr	x16,	[sp, fp]

    lsl	w7,	w10,	#2
    movz	fp,	#2828
    add	x12,	x16,	x7
    ldr	s6,	[x12]

    ldr	w11,	[sp, #3560]

    ldr	x26,	[sp, #2848]

    lsl	w7,	w11,	#2
    add	x15,	x26,	x7
    ldr	s19,	[x15]

    ldr	w12,	[sp, #3560]

    fadd	s9,	s6,	s19
    ldr	x7,	[sp, #2856]

    lsl	w22,	w12,	#2
    add	x19,	x7,	x22
    ldr	s25,	[x19]

    ldr	w13,	[sp, #3560]

    fadd	s11,	s9,	s25
    ldr	x12,	[sp, #1016]

    lsl	w2,	w13,	#2
    add	x1,	x12,	x2
    ldr	s31,	[x1]

    ldr	w14,	[sp, #3560]

    fadd	s26,	s11,	s31
    ldr	x17,	[sp, #1024]

    lsl	w7,	w14,	#2
    add	x5,	x17,	x7
    ldr	s22,	[x5]

    ldr	w15,	[sp, #3560]

    ldr	x11,	[sp, fp]

    lsl	w15,	w15,	#2
    movz	fp,	#2724
    add	x8,	x11,	x15
    ldr	s8,	[x8]

    ldr	w16,	[sp, #3560]

    fadd	s29,	s22,	s8
    ldr	x6,	[sp, fp]

    lsl	w22,	w16,	#2
    movz	fp,	#2716
    add	x14,	x6,	x22
    ldr	s14,	[x14]

    ldr	w17,	[sp, #3560]

    fadd	s2,	s29,	s14
    ldr	x20,	[sp, #2704]

    lsl	w18,	w17,	#2
    add	x18,	x20,	x18
    ldr	s19,	[x18]

    ldr	w18,	[sp, #3560]

    fadd	s31,	s2,	s19
    ldr	x1,	[sp, fp]

    lsl	w10,	w18,	#2
    movz	fp,	#2692
    add	x0,	x1,	x10
    ldr	s11,	[x0]

    ldr	w19,	[sp, #3560]

    ldr	x10,	[sp, fp]

    lsl	w15,	w19,	#2
    movz	fp,	#2676
    add	x3,	x10,	x15
    ldr	s27,	[x3]

    ldr	w20,	[sp, #3560]

    fadd	s16,	s11,	s27
    ldr	x0,	[sp, fp]

    lsl	w22,	w20,	#2
    movz	fp,	#2652
    add	x7,	x0,	x22
    ldr	s2,	[x7]

    ldr	w21,	[sp, #3560]

    fadd	s16,	s16,	s2
    ldr	x14,	[sp, fp]

    lsl	w19,	w21,	#2
    movz	fp,	#2660
    add	x13,	x14,	x19
    ldr	s10,	[x13]

    ldr	w22,	[sp, #3560]

    fadd	s9,	s16,	s10
    ldr	x19,	[sp, fp]

    lsl	w0,	w22,	#2
    movz	fp,	#2668
    add	x21,	x19,	x0
    ldr	s28,	[x21]

    ldr	w23,	[sp, #3560]

    ldr	x24,	[sp, fp]

    lsl	w3,	w23,	#2
    movz	fp,	#2644
    add	x2,	x24,	x3
    ldr	s18,	[x2]

    ldr	w24,	[sp, #3560]

    fadd	s6,	s28,	s18
    ldr	x9,	[sp, fp]

    lsl	w8,	w24,	#2
    movz	fp,	#2596
    add	x7,	x9,	x8
    ldr	s23,	[x7]

    ldr	w25,	[sp, #3560]

    fadd	s11,	s6,	s23
    ldr	x8,	[sp, fp]

    lsl	w2,	w25,	#2
    movz	fp,	#2612
    add	x14,	x8,	x2
    ldr	s29,	[x14]

    ldr	w26,	[sp, #3560]

    fadd	s21,	s11,	s29
    ldr	x18,	[sp, fp]

    lsl	w7,	w26,	#2
    movz	fp,	#2628
    add	x19,	x18,	x7
    ldr	s19,	[x19]

    ldr	w27,	[sp, #3560]

    ldr	x28,	[sp, fp]

    lsl	w2,	w27,	#2
    movz	fp,	#2580
    add	x1,	x28,	x2
    ldr	s7,	[x1]

    ldr	w28,	[sp, #3560]

    fadd	s27,	s19,	s7
    ldr	x27,	[sp, fp]

    lsl	w7,	w28,	#2
    movz	fp,	#2564
    add	x6,	x27,	x7
    ldr	s14,	[x6]

    ldr	w0,	[sp, #3560]

    fadd	s22,	s27,	s14
    ldr	x17,	[sp, fp]

    lsl	w2,	w0,	#2
    movz	fp,	#2540
    add	x13,	x17,	x2
    ldr	s15,	[x13]

    ldr	w1,	[sp, #3560]

    fadd	s1,	s22,	s15
    ldr	x2,	[sp, fp]

    lsl	w10,	w1,	#2
    movz	fp,	#2524
    add	x18,	x2,	x10
    ldr	s10,	[x18]

    ldr	w2,	[sp, #3560]

    ldr	x8,	[sp, #2504]

    lsl	w16,	w2,	#2
    add	x0,	x8,	x16
    ldr	s2,	[x0]

    ldr	w3,	[sp, #3560]

    fadd	s17,	s10,	s2
    ldr	x21,	[sp, fp]

    lsl	w6,	w3,	#2
    movz	fp,	#2332
    add	x5,	x21,	x6
    ldr	s8,	[x5]

    ldr	w4,	[sp, #3560]

    fadd	s16,	s17,	s8
    ldr	x24,	[sp, #2480]

    lsl	w13,	w4,	#2
    add	x12,	x24,	x13
    ldr	s3,	[x12]

    ldr	w5,	[sp, #3560]

    fadd	s22,	s16,	s3
    ldr	x18,	[sp, fp]

    lsl	w7,	w5,	#2
    movz	fp,	#2436
    add	x17,	x18,	x7
    ldr	s27,	[x17]

    ldr	w6,	[sp, #3560]

    ldr	x26,	[sp, fp]

    lsl	w0,	w6,	#2
    movz	fp,	#2452
    add	x21,	x26,	x0
    ldr	s18,	[x21]

    ldr	w7,	[sp, #3560]

    fadd	s4,	s27,	s18
    ldr	x8,	[sp, fp]

    lsl	w22,	w7,	#2
    movz	fp,	#2276
    add	x3,	x8,	x22
    ldr	s28,	[x3]

    ldr	w8,	[sp, #3560]

    fadd	s30,	s4,	s28
    ldr	x3,	[sp, #2312]

    lsl	w2,	w8,	#2
    add	x8,	x3,	x2
    ldr	s23,	[x8]

    ldr	w9,	[sp, #3560]

    fadd	s19,	s30,	s23
    lsl	w19,	w9,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#2284
    add	x15,	x9,	x19
    ldr	s2,	[x15]

    ldr	w10,	[sp, #3560]

    ldr	x14,	[sp, fp]

    lsl	w24,	w10,	#2
    movz	fp,	#2268
    add	x19,	x14,	x24
    ldr	s20,	[x19]

    ldr	w11,	[sp, #3560]

    fadd	s11,	s2,	s20
    ldr	x24,	[sp, #2296]

    lsl	w3,	w11,	#2
    add	x2,	x24,	x3
    ldr	s16,	[x2]

    ldr	w12,	[sp, #3560]

    fadd	s20,	s11,	s16
    ldr	x4,	[sp, fp]

    lsl	w10,	w12,	#2
    movz	fp,	#2916
    add	x7,	x4,	x10
    ldr	s24,	[x7]

    ldr	w13,	[sp, #3560]

    fadd	s20,	s20,	s24
    ldr	x16,	[sp, #2200]

    lsl	w7,	w13,	#2
    add	x14,	x16,	x7
    ldr	s18,	[x14]

    ldr	w14,	[sp, #3560]

    ldr	x11,	[sp, #2192]

    lsl	w15,	w14,	#2
    add	x18,	x11,	x15
    ldr	s6,	[x18]

    ldr	w15,	[sp, #3560]

    fadd	s27,	s18,	s6
    ldr	x17,	[sp, #2208]

    lsl	w21,	w15,	#2
    add	x1,	x17,	x21
    ldr	s14,	[x1]

    ldr	w16,	[sp, #3560]

    fadd	s24,	s27,	s14
    ldr	x9,	[sp, #2168]

    lsl	w2,	w16,	#2
    add	x1,	x9,	x2
    ldr	s7,	[x1]

    ldr	x23,	[sp, fp]

    fadd	s8,	s24,	s7
    movz	fp,	#2740
    str	s5,	[x23]

    movi	v7.4s,	#0
    ldr	x21,	[sp, fp]

    movz	fp,	#2748
    str	s26,	[x21]

    ldr	x24,	[sp, fp]

    movz	fp,	#2772
    str	s31,	[x24]

    ldr	x3,	[sp, #2760]

    str	s9,	[x3]

    ldr	x11,	[sp, fp]

    movz	fp,	#2780
    str	s21,	[x11]

    ldr	x14,	[sp, fp]

    movz	fp,	#2812
    str	s1,	[x14]

    ldr	x23,	[sp, #2792]

    str	s22,	[x23]

    ldr	x26,	[sp, #2800]

    str	s19,	[x26]

    ldr	x5,	[sp, fp]

    movz	fp,	#2820
    str	s20,	[x5]

    ldr	x8,	[sp, fp]

    str	s8,	[x8]

    ldr	s2,	[x1]

    fcmp	s2,	s7
    cset	w12,	ne
    mov	w13,	w12
    cmp	w13,	#0
    movi	v7.4s,	#0
    cset	w15,	ne
    mov	w16,	w15
    scvtf	s6,	w16
    fcmp	s6,	s7
    movi	v6.4s,	#0
    cset	w18,	ne
    mov	w0,	w18
    scvtf	s9,	w0
    fcmp	s9,	s6
    beq	main_517

main_679:
    movz	w0,	#10
    movz	fp,	#2916
    ldr	x1,	[sp, fp]

    bl	putfarray
    add	x13,	sp,	#888
    add	x21,	sp,	#864
    add	x2,	sp,	#852
    ldr	w17,	[sp, #3560]

    movz	fp,	#3380
    add	x5,	sp,	#896
    lsl	w0,	w17,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	#904
    ldr	s13,	[x28]

    ldr	x27,	[sp, fp]

    movz	fp,	#3092
    mov	x20,	x27
    ldr	x0,	[sp, fp]

    movz	fp,	#3484
    mov	x1,	x0
    mov	x23,	x1
    ldr	x25,	[sp, fp]

    movz	fp,	#3356
    ldr	x19,	[sp, fp]

    movz	fp,	#3340
    mov	x14,	x19
    add	x19,	sp,	#840
    ldr	x8,	[sp, fp]

    movz	fp,	#3788
    mov	x22,	x8
    add	x8,	sp,	#844
    str	x22,	[sp, fp]

    mov	x22,	x20
    movz	fp,	#3180
    ldr	x16,	[sp, fp]

    movz	fp,	#4860
    mov	x6,	x16
    add	x16,	sp,	#832
    str	x6,	[sp, fp]

    movz	fp,	#3220
    ldr	x6,	[sp, fp]

    movz	fp,	#3364
    mov	x26,	x6
    str	x26,	[sp, #4688]

    ldr	x24,	[sp, fp]

    movz	fp,	#3780
    mov	x18,	x24
    str	x18,	[sp, fp]

    add	x18,	sp,	#892
    movz	fp,	#3076
    ldr	x26,	[sp, fp]

    movz	fp,	#3204
    mov	x4,	x26
    add	x26,	sp,	#828
    str	x4,	[sp, #4704]

    add	x4,	sp,	#836
    ldr	x0,	[sp, fp]

    movz	fp,	#3772
    mov	x15,	x0
    str	x15,	[sp, fp]

    movz	fp,	#3452
    ldr	x7,	[sp, fp]

    movz	fp,	#3476
    mov	x0,	x7
    str	x0,	[sp, #4696]

    ldr	x24,	[sp, fp]

    movz	fp,	#4876
    mov	x12,	x24
    str	x12,	[sp, fp]

    movz	fp,	#3500
    ldr	x0,	[sp, fp]

    movz	fp,	#4852
    mov	x3,	x0
    str	x3,	[sp, fp]

    add	x3,	sp,	#848
    movz	fp,	#3492
    ldr	x0,	[sp, fp]

    movz	fp,	#4868
    mov	x9,	x0
    str	x9,	[sp, fp]

    movz	fp,	#2684
    add	x9,	sp,	#824
    str	x9,	[sp, fp]

    movz	fp,	#2444
    str	x26,	[sp, #5160]

    str	x16,	[sp, #5144]

    add	x16,	sp,	#868
    str	x4,	[sp, #5176]

    add	x4,	sp,	#884
    str	x19,	[sp, #2304]

    add	x19,	sp,	#860
    str	x8,	[sp, #2424]

    add	x8,	sp,	#872
    str	x3,	[sp, fp]

    add	x3,	sp,	#856
    movz	fp,	#2460
    str	x2,	[sp, fp]

    mov	x2,	x25
    movz	fp,	#2948
    str	x3,	[sp, #2472]

    add	x3,	sp,	#876
    str	x19,	[sp, #2488]

    str	x21,	[sp, fp]

    add	x21,	sp,	#880
    movz	fp,	#2868
    str	x16,	[sp, #1048]

    str	x8,	[sp, #1064]

    str	x3,	[sp, fp]

    movz	fp,	#2892
    str	x21,	[sp, fp]

    movz	fp,	#2900
    str	x4,	[sp, fp]

    mov	x4,	x14
    movz	fp,	#2908
    str	x13,	[sp, fp]

    add	x13,	sp,	#900
    movz	fp,	#2924
    str	x18,	[sp, fp]

    movz	fp,	#2932
    str	x5,	[sp, fp]

    movz	fp,	#2940
    str	x13,	[sp, fp]

    movz	fp,	#4052
    ldr	s10,	[sp, #1280]

    fmov	s17,	s10
    str	x22,	[sp, fp]

    movz	fp,	#2956
    ldr	w9,	[sp, #3528]

    mov	w11,	w9
    str	w11,	[sp, #2884]

    ldr	x7,	[sp, fp]

    movz	fp,	#4892
    mov	x17,	x7
    str	x17,	[sp, fp]

    movz	fp,	#2964
    ldr	s9,	[sp, #1284]

    ldr	w11,	[sp, #3556]

    fmov	s2,	s9
    mov	w8,	w11
    str	w8,	[sp, #2888]

    ldr	s16,	[sp, #1288]

    ldr	s19,	[sp, #1292]

    fmov	s14,	s16
    ldr	x0,	[sp, fp]

    fmov	s11,	s19
    movz	fp,	#2636
    mov	x5,	x0
    str	x5,	[sp, fp]

    movz	fp,	#2604
    str	x23,	[sp, fp]

    movz	fp,	#2972
    ldr	w11,	[sp, #3540]

    str	w11,	[sp, #1032]

    ldr	w9,	[sp, #3532]

    mov	w7,	w9
    str	w7,	[sp, #1036]

    ldr	x7,	[sp, fp]

    movz	fp,	#2620
    mov	x0,	x7
    str	x0,	[sp, fp]

    movz	fp,	#2588
    str	x2,	[sp, fp]

    movz	fp,	#2532
    str	x4,	[sp, fp]

    movz	fp,	#2980
    ldr	w1,	[sp, #3520]

    mov	w7,	w1
    str	w7,	[sp, #2844]

    ldr	x1,	[sp, fp]

    movz	fp,	#2548
    mov	x9,	x1
    str	x9,	[sp, fp]

    movz	fp,	#2988
    ldr	x8,	[sp, fp]

    movz	fp,	#2556
    mov	x19,	x8
    str	x19,	[sp, fp]

    movz	fp,	#2996
    ldr	s19,	[sp, #1296]

    ldr	s16,	[sp, #1300]

    fmov	s15,	s19
    ldr	s7,	[sp, #1304]

    fmov	s20,	s16
    ldr	x15,	[sp, fp]

    fmov	s18,	s7
    movz	fp,	#2572
    mov	x8,	x15
    str	x8,	[sp, fp]

    movz	fp,	#3788
    ldr	w13,	[sp, #3512]

    mov	w1,	w13
    str	w1,	[sp, #2864]

    ldr	s8,	[sp, #1312]

    ldr	s21,	[sp, #1316]

    fmov	s22,	s8
    ldr	s30,	[sp, #1320]

    fmov	s28,	s21
    ldr	x20,	[sp, fp]

    fmov	s8,	s30
    movz	fp,	#3004
    mov	x2,	x20
    str	x2,	[sp, #2496]

    ldr	x23,	[sp, fp]

    movz	fp,	#4860
    mov	x20,	x23
    str	x20,	[sp, #2512]

    ldr	x6,	[sp, fp]

    movz	fp,	#3012
    mov	x11,	x6
    str	x11,	[sp, #2320]

    ldr	x3,	[sp, #4688]

    str	x3,	[sp, #2368]

    ldr	x0,	[sp, fp]

    movz	fp,	#3780
    mov	x6,	x0
    str	x6,	[sp, #4968]

    ldr	s5,	[sp, #1324]

    ldr	s21,	[sp, #1328]

    ldr	x18,	[sp, fp]

    fmov	s27,	s21
    movz	fp,	#3020
    str	x18,	[sp, #4952]

    ldr	w11,	[sp, #3508]

    mov	w18,	w11
    str	w18,	[sp, #2808]

    ldr	x0,	[sp, fp]

    movz	fp,	#3028
    mov	x14,	x0
    str	x14,	[sp, #4984]

    ldr	x16,	[sp, fp]

    movz	fp,	#3772
    mov	x27,	x16
    str	x27,	[sp, #2416]

    ldr	s7,	[sp, #1336]

    ldr	s6,	[sp, #1340]

    fmov	s9,	s7
    ldr	x16,	[sp, #4704]

    fmov	s30,	s6
    str	x16,	[sp, #2392]

    ldr	x18,	[sp, fp]

    movz	fp,	#3828
    str	x18,	[sp, fp]

    movz	fp,	#3036
    ldr	w2,	[sp, #3544]

    mov	w23,	w2
    str	w23,	[sp, #2756]

    ldr	w11,	[sp, #3536]

    mov	w15,	w11
    str	w15,	[sp, #2768]

    ldr	s10,	[sp, #1344]

    fmov	s21,	s10
    ldr	s10,	[sp, #1348]

    ldr	x13,	[sp, #4696]

    fmov	s19,	s10
    str	x13,	[sp, #4944]

    ldr	w11,	[sp, #3516]

    mov	w1,	w11
    str	w1,	[sp, #2732]

    ldr	x1,	[sp, fp]

    movz	fp,	#4876
    mov	x4,	x1
    str	x4,	[sp, #4928]

    ldr	w18,	[sp, #3524]

    mov	w26,	w18
    str	w26,	[sp, #2736]

    ldr	x25,	[sp, fp]

    movz	fp,	#4276
    str	x25,	[sp, fp]

    movz	fp,	#4852
    ldr	x5,	[sp, fp]

    movz	fp,	#3804
    str	x5,	[sp, fp]

    movz	fp,	#3044
    ldr	s29,	[sp, #1352]

    ldr	s3,	[sp, #1356]

    fmov	s16,	s29
    ldr	x16,	[sp, fp]

    fmov	s7,	s3
    movz	fp,	#4868
    mov	x23,	x16
    str	x23,	[sp, #4912]

    ldr	w16,	[sp, #3552]

    mov	w28,	w16
    str	w28,	[sp, #2712]

    ldr	x23,	[sp, fp]

    movz	fp,	#3052
    str	x23,	[sp, #2352]

    ldr	x28,	[sp, fp]

    movz	fp,	#3060
    mov	x11,	x28
    str	x11,	[sp, #2248]

    ldr	s3,	[sp, #1360]

    ldr	w28,	[sp, #3556]

    fmov	s10,	s3
    mov	w20,	w28
    str	w20,	[sp, #2700]

    ldr	s29,	[sp, #1364]

    ldr	x13,	[sp, fp]

    movz	fp,	#3068
    mov	x20,	x13
    str	x20,	[sp, #2216]

    ldr	x7,	[sp, fp]

    movz	fp,	#2180
    mov	x11,	x7
    str	x11,	[sp, fp]

    ldr	s4,	[sp, #1368]

    ldr	w22,	[sp, #3548]

    mov	w7,	w22
    str	w7,	[sp, #2788]


main_717:
    ldr	w11,	[sp, #3560]

    movz	fp,	#4892
    lsl	w20,	w11,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#2636
    add	x20,	x16,	x20
    ldr	s31,	[x20]

    fadd	s23,	s17,	s31
    fadd	s3,	s23,	s2
    fadd	s31,	s3,	s14
    str	s31,	[sp, #1732]

    ldr	w11,	[sp, #3560]

    ldr	x18,	[sp, fp]

    lsl	w12,	w11,	#2
    movz	fp,	#2620
    add	x26,	x18,	x12
    ldr	s23,	[x26]

    ldr	w13,	[sp, #3560]

    fadd	s6,	s11,	s23
    ldr	x22,	[sp, fp]

    lsl	w13,	w13,	#2
    movz	fp,	#2548
    add	x11,	x22,	x13
    ldr	s26,	[x11]

    ldr	w17,	[sp, #3560]

    fadd	s23,	s6,	s26
    ldr	x23,	[sp, fp]

    lsl	w7,	w17,	#2
    movz	fp,	#2556
    add	x27,	x23,	x7
    ldr	s1,	[x27]

    fadd	s31,	s23,	s1
    str	s31,	[sp, #1748]

    ldr	w20,	[sp, #3560]

    ldr	x11,	[sp, fp]

    lsl	w27,	w20,	#2
    movz	fp,	#2572
    add	x20,	x11,	x27
    ldr	s3,	[x20]

    fadd	s23,	s3,	s15
    fadd	s25,	s23,	s20
    fadd	s31,	s25,	s18
    str	s31,	[sp, #1752]

    ldr	w21,	[sp, #3560]

    lsl	w13,	w21,	#2
    ldr	x21,	[sp, fp]

    movz	fp,	#2180
    add	x11,	x21,	x13
    ldr	s31,	[x11]

    fadd	s23,	s31,	s22
    fadd	s3,	s23,	s28
    fadd	s31,	s3,	s8
    str	s31,	[sp, #1736]

    ldr	w22,	[sp, #3560]

    ldr	x14,	[sp, #2512]

    lsl	w11,	w22,	#2
    add	x12,	x14,	x11
    ldr	s23,	[x12]

    ldr	w23,	[sp, #3560]

    ldr	x7,	[sp, #4968]

    lsl	w27,	w23,	#2
    add	x26,	x7,	x27
    ldr	s25,	[x26]

    fadd	s3,	s23,	s25
    fadd	s23,	s3,	s5
    fadd	s31,	s23,	s27
    str	s31,	[sp, #1740]

    ldr	w27,	[sp, #3560]

    ldr	x15,	[sp, #4984]

    lsl	w27,	w27,	#2
    add	x14,	x15,	x27
    ldr	s6,	[x14]

    ldr	w28,	[sp, #3560]

    ldr	x0,	[sp, #2416]

    lsl	w7,	w28,	#2
    add	x28,	x0,	x7
    ldr	s26,	[x28]

    fadd	s23,	s6,	s26
    fadd	s25,	s23,	s9
    fadd	s23,	s21,	s19
    fadd	s31,	s25,	s30
    str	s31,	[sp, #1744]

    ldr	w7,	[sp, #3560]

    ldr	x5,	[sp, #4928]

    lsl	w7,	w7,	#2
    add	x28,	x5,	x7
    ldr	s24,	[x28]

    fadd	s3,	s23,	s24
    fadd	s23,	s3,	s16
    str	s23,	[sp, #1076]

    ldr	w7,	[sp, #3560]

    ldr	x24,	[sp, #4912]

    lsl	w27,	w7,	#2
    add	x26,	x24,	x27
    ldr	s23,	[x26]

    ldr	w10,	[sp, #3560]

    fadd	s25,	s7,	s23
    ldr	x13,	[sp, #2248]

    lsl	w27,	w10,	#2
    add	x20,	x13,	x27
    ldr	s23,	[x20]

    fadd	s25,	s25,	s23
    fadd	s23,	s25,	s10
    str	s23,	[sp, #1136]

    ldr	w11,	[sp, #3560]

    ldr	x21,	[sp, #2216]

    lsl	w12,	w11,	#2
    add	x28,	x21,	x12
    ldr	s23,	[x28]

    ldr	w13,	[sp, #3560]

    fadd	s26,	s29,	s23
    ldr	x14,	[sp, fp]

    lsl	w12,	w13,	#2
    movz	fp,	#2684
    add	x20,	x14,	x12
    ldr	s6,	[x20]

    fadd	s3,	s26,	s6
    fadd	s23,	s3,	s4
    str	s23,	[sp, #1172]

    ldr	s23,	[sp, #1732]

    ldr	x20,	[sp, fp]

    movz	fp,	#2444
    str	s23,	[x20]

    ldr	s23,	[sp, #1748]

    ldr	x1,	[sp, #5160]

    str	s23,	[x1]

    ldr	s3,	[sp, #1752]

    ldr	x24,	[sp, #5144]

    str	s3,	[x24]

    ldr	s3,	[sp, #1736]

    ldr	x7,	[sp, #5176]

    str	s3,	[x7]

    ldr	s23,	[sp, #1740]

    ldr	x7,	[sp, #2304]

    str	s23,	[x7]

    ldr	s3,	[sp, #1744]

    ldr	x21,	[sp, #2424]

    str	s3,	[x21]

    ldr	s25,	[sp, #1076]

    ldr	x11,	[sp, fp]

    movz	fp,	#2460
    str	s25,	[x11]

    movi	v25.4s,	#0
    ldr	s6,	[sp, #1136]

    ldr	x12,	[sp, fp]

    movz	fp,	#4052
    str	s6,	[x12]

    ldr	s3,	[sp, #1172]

    ldr	x17,	[sp, #2472]

    str	s3,	[x17]

    ldr	x7,	[sp, #2488]

    str	s25,	[x7]

    ldr	w17,	[sp, #3560]

    ldr	x22,	[sp, fp]

    lsl	w20,	w17,	#2
    movz	fp,	#2604
    add	x12,	x22,	x20
    ldr	w18,	[x12]

    ldr	w10,	[sp, #2884]

    ldr	w6,	[sp, #2888]

    add	w28,	w6,	w10
    add	w26,	w28,	w18
    str	w26,	[sp, #2264]

    ldr	w20,	[sp, #3560]

    ldr	x10,	[sp, fp]

    lsl	w20,	w20,	#2
    movz	fp,	#2588
    add	x12,	x10,	x20
    ldr	w26,	[x12]

    ldr	w17,	[sp, #1032]

    ldr	w7,	[sp, #1036]

    add	w11,	w7,	w17
    add	w6,	w11,	w26
    str	w6,	[sp, #2176]

    ldr	w21,	[sp, #3560]

    ldr	x14,	[sp, fp]

    lsl	w12,	w21,	#2
    movz	fp,	#2532
    add	x12,	x14,	x12
    ldr	w13,	[x12]

    ldr	w23,	[sp, #3560]

    ldr	x24,	[sp, fp]

    lsl	w7,	w23,	#2
    movz	fp,	#3828
    add	x27,	x24,	x7
    ldr	w27,	[x27]

    ldr	w6,	[sp, #2844]

    add	w14,	w13,	w6
    add	w24,	w14,	w27
    str	w24,	[sp, #2244]

    ldr	w23,	[sp, #3560]

    ldr	x13,	[sp, #2496]

    lsl	w26,	w23,	#2
    add	x24,	x13,	x26
    ldr	w22,	[x24]

    ldr	w11,	[sp, #2864]

    ldr	w24,	[sp, #3560]

    add	w26,	w22,	w11
    ldr	x17,	[sp, #2320]

    lsl	w14,	w24,	#2
    add	x7,	x17,	x14
    ldr	w7,	[x7]

    add	w20,	w26,	w7
    str	w20,	[sp, #2084]

    ldr	w26,	[sp, #3560]

    ldr	x4,	[sp, #2368]

    lsl	w24,	w26,	#2
    add	x12,	x4,	x24
    ldr	w26,	[x12]

    ldr	w28,	[sp, #3560]

    ldr	x19,	[sp, #4952]

    lsl	w13,	w28,	#2
    add	x7,	x19,	x13
    ldr	w28,	[x7]

    ldr	w7,	[sp, #2808]

    add	w26,	w26,	w7
    add	w27,	w26,	w28
    str	w27,	[sp, #2236]

    ldr	w6,	[sp, #3560]

    ldr	x17,	[sp, #2392]

    lsl	w12,	w6,	#2
    add	x26,	x17,	x12
    ldr	w24,	[x26]

    ldr	w10,	[sp, #3560]

    ldr	x19,	[sp, fp]

    lsl	w11,	w10,	#2
    movz	fp,	#4276
    add	x6,	x19,	x11
    ldr	w7,	[x6]

    ldr	w27,	[sp, #2756]

    add	w21,	w24,	w27
    add	w11,	w21,	w7
    str	w11,	[sp, #2164]

    ldr	w11,	[sp, #3560]

    ldr	x14,	[sp, #4944]

    lsl	w27,	w11,	#2
    add	x24,	x14,	x27
    ldr	w12,	[x24]

    ldr	w26,	[sp, #2732]

    ldr	w11,	[sp, #2768]

    add	w21,	w26,	w11
    add	w17,	w21,	w12
    str	w17,	[sp, #2340]

    ldr	w12,	[sp, #3560]

    ldr	x26,	[sp, fp]

    lsl	w28,	w12,	#2
    movz	fp,	#3804
    add	x18,	x26,	x28
    ldr	w26,	[x18]

    ldr	w13,	[sp, #2736]

    ldr	w23,	[sp, #3560]

    add	w22,	w26,	w13
    ldr	x6,	[sp, fp]

    lsl	w28,	w23,	#2
    movz	fp,	#2948
    add	x26,	x6,	x28
    ldr	w12,	[x26]

    add	w14,	w22,	w12
    str	w14,	[sp, #8432]

    ldr	w18,	[sp, #3560]

    ldr	x24,	[sp, #2352]

    lsl	w12,	w18,	#2
    add	x12,	x24,	x12
    ldr	w7,	[x12]

    ldr	w10,	[sp, #2700]

    ldr	w26,	[sp, #2712]

    ldr	w11,	[sp, #2788]

    add	w21,	w10,	w26
    add	w18,	w21,	w11
    add	w19,	w18,	w7
    str	w19,	[sp, #8440]

    ldr	w23,	[sp, #2264]

    ldr	x6,	[sp, fp]

    movz	fp,	#2868
    str	w23,	[x6]

    ldr	w10,	[sp, #2176]

    ldr	x24,	[sp, #1048]

    str	w10,	[x24]

    ldr	w18,	[sp, #2244]

    ldr	x7,	[sp, #1064]

    str	w18,	[x7]

    movz	w18,	#0
    ldr	w7,	[sp, #2084]

    ldr	x20,	[sp, fp]

    movz	fp,	#2892
    str	w7,	[x20]

    ldr	w20,	[sp, #2236]

    ldr	x27,	[sp, fp]

    movz	fp,	#2900
    str	w20,	[x27]

    ldr	w23,	[sp, #2164]

    ldr	x17,	[sp, fp]

    movz	fp,	#2908
    str	w23,	[x17]

    ldr	w14,	[sp, #2340]

    ldr	x11,	[sp, fp]

    movz	fp,	#2924
    str	w14,	[x11]

    ldr	x6,	[sp, fp]

    movz	fp,	#2932
    ldr	w16,	[sp, #8432]

    str	w16,	[x6]

    mov	w6,	w18
    ldr	x13,	[sp, fp]

    movz	fp,	#2940
    ldr	w21,	[sp, #8440]

    str	w21,	[x13]

    ldr	x10,	[sp, fp]

    str	w6,	[x10]

    fcvtzs	w6,	s4
    ldr	w7,	[sp, #2788]

    ldr	w24,	[sp, #2788]

    scvtf	s25,	w7
    cmp	w24,	#0
    beq	main_716

main_889:
    movz	w0,	#10
    movz	fp,	#2684
    ldr	x1,	[sp, fp]

    bl	putfarray
    movz	w0,	#10
    movz	fp,	#2948
    ldr	x1,	[sp, fp]

    bl	putarray
    movz	fp,	#2948
    ldr	w27,	[sp, #2264]

    scvtf	s11,	w27
    str	s11,	[sp, #1100]

    ldr	s11,	[sp, #1100]

    ldr	s9,	[sp, #1732]

    fsub	s15,	s11,	s9
    ldr	x25,	[sp, fp]

    fcvtzs	w22,	s15
    movz	fp,	#2868
    str	w22,	[x25]

    ldr	w27,	[sp, #2176]

    scvtf	s11,	w27
    ldr	s15,	[sp, #1748]

    ldr	x25,	[sp, #1048]

    fsub	s15,	s11,	s15
    fcvtzs	w28,	s15
    str	w28,	[x25]

    ldr	w20,	[sp, #2244]

    ldr	s15,	[sp, #1752]

    scvtf	s10,	w20
    ldr	x28,	[sp, #1064]

    fsub	s15,	s10,	s15
    fcvtzs	w21,	s15
    str	w21,	[x28]

    ldr	w27,	[sp, #2084]

    ldr	s15,	[sp, #1736]

    scvtf	s11,	w27
    ldr	x23,	[sp, fp]

    fsub	s15,	s11,	s15
    movz	fp,	#2892
    fcvtzs	w26,	s15
    str	w26,	[x23]

    ldr	w22,	[sp, #2236]

    scvtf	s10,	w22
    ldr	s15,	[sp, #1740]

    ldr	x26,	[sp, fp]

    fsub	s15,	s10,	s15
    movz	fp,	#2900
    fcvtzs	w19,	s15
    str	w19,	[x26]

    ldr	w20,	[sp, #2164]

    ldr	s9,	[sp, #1744]

    scvtf	s11,	w20
    ldr	x21,	[sp, fp]

    fsub	s15,	s11,	s9
    movz	fp,	#2908
    fcvtzs	w22,	s15
    str	w22,	[x21]

    ldr	w27,	[sp, #2340]

    ldr	s10,	[sp, #1076]

    scvtf	s15,	w27
    ldr	x25,	[sp, fp]

    fsub	s15,	s15,	s10
    movz	fp,	#2924
    fcvtzs	w27,	s15
    str	w27,	[x25]

    ldr	w27,	[sp, #8432]

    scvtf	s14,	w27
    ldr	s10,	[sp, #1136]

    ldr	x21,	[sp, fp]

    fsub	s15,	s14,	s10
    movz	fp,	#2932
    fcvtzs	w26,	s15
    str	w26,	[x21]

    ldr	w21,	[sp, #8440]

    scvtf	s9,	w21
    ldr	s10,	[sp, #1172]

    movz	w21,	#0
    fsub	s11,	s9,	s10
    ldr	x18,	[sp, fp]

    fcvtzs	w25,	s11
    movz	fp,	#2940
    str	w25,	[x18]

    ldr	x23,	[sp, fp]

    str	w21,	[x23]

    ldr	w26,	[sp, #3560]

    lsl	w27,	w26,	#2
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#864
    ldr	w28,	[x26]

    ldr	s10,	[sp, #1172]

    scvtf	s11,	w28
    ldr	s0,	[sp, #1276]

    fmul	s9,	s11,	s10
    fcvtzs	w27,	s9
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s12
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s13
    bl	putfloat
    movz	w0,	#10
    bl	putch
    mov	w0,	w27
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#12880
    add	sp, sp, fp
    ret


main_716:
    movz	fp,	#2948
    fmov	s4,	s25
    mov	w17,	w6
    ldr	x11,	[sp, fp]

    movz	fp,	#4052
    mov	x23,	x11
    str	x23,	[sp, fp]

    movz	fp,	#2684
    ldr	x23,	[sp, fp]

    movz	fp,	#4892
    mov	x18,	x23
    str	x18,	[sp, fp]

    movz	fp,	#2636
    str	w17,	[sp, #2788]

    ldr	w11,	[sp, #2884]

    ldr	w16,	[sp, #6292]

    ldr	w17,	[sp, #6292]

    mov	w11,	w16
    str	w17,	[sp, #2884]

    ldr	w26,	[sp, #2888]

    ldr	w19,	[sp, #6296]

    ldr	w20,	[sp, #6296]

    mov	w26,	w19
    str	w20,	[sp, #2888]

    ldr	x20,	[sp, fp]

    movz	fp,	#2636
    ldr	x9,	[sp, #6232]

    ldr	x10,	[sp, #6232]

    mov	x20,	x9
    str	x10,	[sp, fp]

    movz	fp,	#2604
    ldr	x20,	[sp, fp]

    movz	fp,	#2604
    ldr	x3,	[sp, #6224]

    ldr	x4,	[sp, #6224]

    mov	x20,	x3
    str	x4,	[sp, fp]

    movz	fp,	#2620
    ldr	w26,	[sp, #1032]

    ldr	w10,	[sp, #6284]

    ldr	w11,	[sp, #6284]

    mov	w26,	w10
    str	w11,	[sp, #1032]

    ldr	w13,	[sp, #1036]

    ldr	w13,	[sp, #6288]

    ldr	w14,	[sp, #6288]

    str	w14,	[sp, #1036]

    ldr	x28,	[sp, fp]

    movz	fp,	#2620
    ldr	x6,	[sp, #6240]

    ldr	x7,	[sp, #6240]

    mov	x28,	x6
    str	x7,	[sp, fp]

    movz	fp,	#2588
    ldr	x17,	[sp, fp]

    movz	fp,	#2588
    ldr	x0,	[sp, #6216]

    ldr	x1,	[sp, #6216]

    mov	x17,	x0
    str	x1,	[sp, fp]

    movz	fp,	#2532
    ldr	x11,	[sp, fp]

    movz	fp,	#2532
    ldr	x17,	[sp, #6184]

    ldr	x18,	[sp, #6184]

    mov	x11,	x17
    str	x18,	[sp, fp]

    movz	fp,	#2548
    ldr	w23,	[sp, #2844]

    ldr	w4,	[sp, #6276]

    ldr	w5,	[sp, #6276]

    mov	w23,	w4
    str	w5,	[sp, #2844]

    ldr	x28,	[sp, fp]

    movz	fp,	#2548
    ldr	x20,	[sp, #6192]

    ldr	x21,	[sp, #6192]

    mov	x28,	x20
    str	x21,	[sp, fp]

    movz	fp,	#2556
    ldr	x14,	[sp, fp]

    movz	fp,	#2556
    ldr	x23,	[sp, #6200]

    ldr	x24,	[sp, #6200]

    mov	x14,	x23
    str	x24,	[sp, fp]

    movz	fp,	#2572
    ldr	x26,	[sp, fp]

    movz	fp,	#2572
    ldr	x26,	[sp, #6208]

    ldr	x27,	[sp, #6208]

    str	x27,	[sp, fp]

    movz	fp,	#3828
    ldr	w13,	[sp, #2864]

    ldr	w7,	[sp, #6280]

    ldr	w8,	[sp, #6280]

    mov	w13,	w7
    str	w8,	[sp, #2864]

    ldr	x17,	[sp, #2496]

    ldr	x11,	[sp, #6168]

    ldr	x12,	[sp, #6168]

    mov	x17,	x11
    str	x12,	[sp, #2496]

    ldr	x20,	[sp, #2512]

    ldr	x14,	[sp, #6176]

    ldr	x15,	[sp, #6176]

    mov	x20,	x14
    str	x15,	[sp, #2512]

    ldr	x6,	[sp, #2320]

    ldr	x8,	[sp, #6160]

    ldr	x9,	[sp, #6160]

    mov	x6,	x8
    str	x9,	[sp, #2320]

    ldr	x5,	[sp, #2368]

    ldr	x24,	[sp, #8312]

    ldr	x25,	[sp, #8312]

    mov	x5,	x24
    str	x25,	[sp, #2368]

    ldr	x8,	[sp, #4968]

    ldr	x8,	[sp, #9600]

    ldr	x5,	[sp, #9600]

    str	x5,	[sp, #4968]

    ldr	x20,	[sp, #4952]

    ldr	x18,	[sp, #8296]

    ldr	x19,	[sp, #8296]

    mov	x20,	x18
    str	x19,	[sp, #4952]

    ldr	w10,	[sp, #2808]

    ldr	w1,	[sp, #6272]

    ldr	w2,	[sp, #6272]

    mov	w10,	w1
    str	w2,	[sp, #2808]

    ldr	x16,	[sp, #4984]

    ldr	x16,	[sp, #9608]

    ldr	x8,	[sp, #9608]

    str	x8,	[sp, #4984]

    ldr	x0,	[sp, #2416]

    ldr	x0,	[sp, #9592]

    ldr	x2,	[sp, #9592]

    str	x2,	[sp, #2416]

    ldr	x18,	[sp, #2392]

    ldr	x27,	[sp, #9584]

    ldr	x28,	[sp, #9584]

    mov	x18,	x27
    str	x28,	[sp, #2392]

    ldr	x20,	[sp, fp]

    movz	fp,	#3828
    ldr	x6,	[sp, #8264]

    ldr	x7,	[sp, #8264]

    mov	x20,	x6
    str	x7,	[sp, fp]

    movz	fp,	#4276
    ldr	w13,	[sp, #2756]

    ldr	w24,	[sp, #6264]

    ldr	w25,	[sp, #6264]

    mov	w13,	w24
    str	w25,	[sp, #2756]

    ldr	w26,	[sp, #2768]

    ldr	w27,	[sp, #6268]

    ldr	w28,	[sp, #6268]

    mov	w26,	w27
    str	w28,	[sp, #2768]

    ldr	x15,	[sp, #4944]

    ldr	x15,	[sp, #8288]

    ldr	x16,	[sp, #8288]

    str	x16,	[sp, #4944]

    ldr	w13,	[sp, #2732]

    ldr	w18,	[sp, #6256]

    ldr	w19,	[sp, #6256]

    mov	w13,	w18
    str	w19,	[sp, #2732]

    ldr	x6,	[sp, #4928]

    ldr	x12,	[sp, #8280]

    ldr	x13,	[sp, #8280]

    mov	x6,	x12
    str	x13,	[sp, #4928]

    ldr	w10,	[sp, #2736]

    ldr	w21,	[sp, #6260]

    ldr	w22,	[sp, #6260]

    mov	w10,	w21
    str	w22,	[sp, #2736]

    ldr	x27,	[sp, fp]

    movz	fp,	#4276
    ldr	x0,	[sp, #8248]

    ldr	x1,	[sp, #8248]

    mov	x27,	x0
    str	x1,	[sp, fp]

    movz	fp,	#3804
    ldr	x7,	[sp, fp]

    movz	fp,	#3804
    ldr	x3,	[sp, #8256]

    ldr	x4,	[sp, #8256]

    mov	x7,	x3
    str	x4,	[sp, fp]

    movz	fp,	#2180
    ldr	x25,	[sp, #4912]

    ldr	x9,	[sp, #8272]

    ldr	x10,	[sp, #8272]

    mov	x25,	x9
    str	x10,	[sp, #4912]

    ldr	w10,	[sp, #2712]

    ldr	w15,	[sp, #6252]

    ldr	w16,	[sp, #6252]

    mov	w10,	w15
    str	w16,	[sp, #2712]

    ldr	x25,	[sp, #2352]

    ldr	x21,	[sp, #8304]

    ldr	x22,	[sp, #8304]

    mov	x25,	x21
    str	x22,	[sp, #2352]

    ldr	x17,	[sp, #2248]

    ldr	x28,	[sp, #6136]

    ldr	x0,	[sp, #6136]

    mov	x17,	x28
    str	x0,	[sp, #2248]

    ldr	w7,	[sp, #2700]

    ldr	w12,	[sp, #6248]

    ldr	w13,	[sp, #6248]

    mov	w7,	w12
    str	w13,	[sp, #2700]

    ldr	x26,	[sp, #2216]

    ldr	x2,	[sp, #6144]

    ldr	x3,	[sp, #6144]

    mov	x26,	x2
    str	x3,	[sp, #2216]

    ldr	x17,	[sp, fp]

    movz	fp,	#2180
    ldr	x5,	[sp, #6152]

    ldr	x6,	[sp, #6152]

    mov	x17,	x5
    str	x6,	[sp, fp]

    b	main_717

main_517:
    movz	fp,	#2876
    ldr	x26,	[sp, fp]

    movz	fp,	#5460
    mov	x3,	x26
    str	x3,	[sp, fp]

    movz	fp,	#2876
    ldr	x13,	[sp, #1056]

    mov	x0,	x13
    str	x0,	[sp, fp]

    movz	fp,	#2836
    ldr	x4,	[sp, #1040]

    mov	x14,	x4
    str	x14,	[sp, #1056]

    ldr	x17,	[sp, fp]

    movz	fp,	#2836
    mov	x5,	x17
    str	x5,	[sp, #1040]

    ldr	x0,	[sp, #2848]

    mov	x18,	x0
    str	x18,	[sp, fp]

    movz	fp,	#2828
    ldr	x8,	[sp, #2856]

    mov	x0,	x8
    str	x0,	[sp, #2848]

    ldr	x13,	[sp, #1016]

    mov	x9,	x13
    str	x9,	[sp, #2856]

    ldr	x18,	[sp, #1024]

    mov	x14,	x18
    str	x14,	[sp, #1016]

    ldr	x12,	[sp, fp]

    movz	fp,	#2724
    mov	x19,	x12
    str	x19,	[sp, #1024]

    ldr	x7,	[sp, fp]

    movz	fp,	#2828
    mov	x13,	x7
    str	x13,	[sp, fp]

    movz	fp,	#2724
    ldr	x23,	[sp, #2704]

    mov	x8,	x23
    str	x8,	[sp, fp]

    movz	fp,	#2716
    ldr	x2,	[sp, fp]

    movz	fp,	#2692
    mov	x24,	x2
    str	x24,	[sp, #2704]

    ldr	x11,	[sp, fp]

    movz	fp,	#2716
    mov	x3,	x11
    str	x3,	[sp, fp]

    movz	fp,	#2676
    ldr	x1,	[sp, fp]

    movz	fp,	#2692
    mov	x12,	x1
    str	x12,	[sp, fp]

    movz	fp,	#2652
    ldr	x15,	[sp, fp]

    movz	fp,	#2676
    mov	x2,	x15
    str	x2,	[sp, fp]

    movz	fp,	#2660
    ldr	x20,	[sp, fp]

    movz	fp,	#2652
    mov	x16,	x20
    str	x16,	[sp, fp]

    movz	fp,	#2668
    ldr	x27,	[sp, fp]

    movz	fp,	#2660
    mov	x23,	x27
    str	x23,	[sp, fp]

    movz	fp,	#2644
    ldr	x10,	[sp, fp]

    movz	fp,	#2668
    mov	x28,	x10
    str	x28,	[sp, fp]

    movz	fp,	#2596
    ldr	x9,	[sp, fp]

    movz	fp,	#2644
    mov	x11,	x9
    str	x11,	[sp, fp]

    movz	fp,	#2612
    ldr	x19,	[sp, fp]

    movz	fp,	#2596
    mov	x10,	x19
    str	x10,	[sp, fp]

    movz	fp,	#2628
    ldr	x0,	[sp, fp]

    movz	fp,	#2612
    mov	x20,	x0
    str	x20,	[sp, fp]

    movz	fp,	#2580
    ldr	x0,	[sp, fp]

    movz	fp,	#2628
    mov	x1,	x0
    str	x1,	[sp, fp]

    movz	fp,	#2564
    ldr	x18,	[sp, fp]

    movz	fp,	#2580
    mov	x0,	x18
    str	x0,	[sp, fp]

    movz	fp,	#2540
    ldr	x3,	[sp, fp]

    movz	fp,	#2564
    mov	x19,	x3
    str	x19,	[sp, fp]

    movz	fp,	#2540
    ldr	x9,	[sp, #2504]

    mov	x4,	x9
    str	x4,	[sp, fp]

    movz	fp,	#2524
    ldr	x24,	[sp, fp]

    movz	fp,	#2524
    mov	x10,	x24
    str	x10,	[sp, #2504]

    ldr	x27,	[sp, #2480]

    mov	x25,	x27
    str	x25,	[sp, fp]

    movz	fp,	#2332
    ldr	x19,	[sp, fp]

    movz	fp,	#2436
    mov	x28,	x19
    str	x28,	[sp, #2480]

    ldr	x0,	[sp, fp]

    movz	fp,	#2332
    mov	x20,	x0
    str	x20,	[sp, fp]

    movz	fp,	#2452
    ldr	x9,	[sp, fp]

    movz	fp,	#2436
    mov	x0,	x9
    str	x0,	[sp, fp]

    movz	fp,	#2452
    ldr	x4,	[sp, #2312]

    mov	x10,	x4
    str	x10,	[sp, fp]

    movz	fp,	#2276
    ldr	x10,	[sp, fp]

    movz	fp,	#2284
    mov	x5,	x10
    str	x5,	[sp, #2312]

    ldr	x15,	[sp, fp]

    movz	fp,	#2276
    mov	x11,	x15
    str	x11,	[sp, fp]

    movz	fp,	#2284
    ldr	x27,	[sp, #2296]

    mov	x16,	x27
    str	x16,	[sp, fp]

    movz	fp,	#2268
    ldr	x5,	[sp, fp]

    movz	fp,	#2268
    mov	x28,	x5
    str	x28,	[sp, #2296]

    ldr	x17,	[sp, #2200]

    mov	x6,	x17
    str	x6,	[sp, fp]

    movz	fp,	#2916
    ldr	x12,	[sp, #2192]

    mov	x18,	x12
    str	x18,	[sp, #2200]

    ldr	x18,	[sp, #2208]

    mov	x13,	x18
    str	x13,	[sp, #2192]

    ldr	x9,	[sp, #2168]

    mov	x19,	x9
    str	x19,	[sp, #2208]

    ldr	x27,	[sp, fp]

    mov	x10,	x27
    str	x10,	[sp, #2168]

    b	main_518

main_308:
    ldr	w10,	[sp, #5440]

    mov	w8,	w10
    str	w8,	[sp, #2468]

    ldr	w13,	[sp, #9576]

    ldr	w5,	[sp, #9708]

    ldr	w6,	[sp, #9708]

    mov	w13,	w5
    str	w6,	[sp, #9576]

    ldr	w15,	[sp, #5436]

    ldr	w8,	[sp, #7988]

    ldr	w9,	[sp, #7988]

    mov	w15,	w8
    str	w9,	[sp, #5436]

    ldr	w1,	[sp, #5440]

    ldr	w11,	[sp, #7992]

    ldr	w12,	[sp, #7992]

    mov	w1,	w11
    str	w12,	[sp, #5440]

    ldr	w18,	[sp, #9580]

    ldr	w8,	[sp, #12644]

    ldr	w9,	[sp, #12644]

    mov	w18,	w8
    str	w9,	[sp, #9580]

    ldr	w25,	[sp, #6596]

    ldr	w11,	[sp, #12648]

    ldr	w12,	[sp, #12648]

    mov	w25,	w11
    str	w12,	[sp, #6596]

    ldr	w13,	[sp, #2328]

    ldr	w4,	[sp, #6132]

    ldr	w15,	[sp, #6132]

    mov	w13,	w4
    str	w15,	[sp, #2328]

    ldr	s28,	[sp, #1668]

    str	s11,	[sp, #1668]

    fmov	s28,	s11
    ldr	w8,	[sp, #9572]

    ldr	w2,	[sp, #10160]

    ldr	w3,	[sp, #10160]

    mov	w8,	w2
    str	w3,	[sp, #9572]

    ldr	s22,	[sp, #1712]

    str	s11,	[sp, #1712]

    fmov	s22,	s11
    ldr	w5,	[sp, #2292]

    ldr	w0,	[sp, #6128]

    ldr	w10,	[sp, #6128]

    mov	w5,	w0
    str	w10,	[sp, #2292]

    ldr	s27,	[sp, #1664]

    str	s11,	[sp, #1664]

    fmov	s27,	s11
    ldr	s21,	[sp, #1684]

    str	s11,	[sp, #1684]

    fmov	s21,	s11
    ldr	w2,	[sp, #6600]

    ldr	w14,	[sp, #12652]

    ldr	w15,	[sp, #12652]

    mov	w2,	w14
    str	w15,	[sp, #6600]

    ldr	s21,	[sp, #1680]

    str	s11,	[sp, #1680]

    fmov	s21,	s11
    ldr	w10,	[sp, #5448]

    ldr	w17,	[sp, #8000]

    ldr	w18,	[sp, #8000]

    mov	w10,	w17
    str	w18,	[sp, #5448]

    ldr	w4,	[sp, #5468]

    ldr	w25,	[sp, #8008]

    ldr	w27,	[sp, #8008]

    mov	w4,	w25
    str	w27,	[sp, #5468]

    ldr	s14,	[sp, #1648]

    str	s11,	[sp, #1648]

    fmov	s14,	s11
    ldr	s21,	[sp, #1112]

    str	s11,	[sp, #1112]

    fmov	s21,	s11
    ldr	s16,	[sp, #1652]

    str	s11,	[sp, #1652]

    fmov	s16,	s11
    ldr	s21,	[sp, #1656]

    str	s11,	[sp, #1656]

    fmov	s21,	s11
    ldr	w3,	[sp, #5424]

    ldr	w2,	[sp, #7980]

    mov	w3,	w2
    ldr	w3,	[sp, #7980]

    str	w3,	[sp, #5424]

    ldr	s21,	[sp, #1124]

    str	s11,	[sp, #1124]

    fmov	s21,	s11
    ldr	w11,	[sp, #2224]

    ldr	w16,	[sp, #6120]

    ldr	w10,	[sp, #6120]

    mov	w11,	w16
    str	w10,	[sp, #2224]

    ldr	s21,	[sp, #1104]

    str	s11,	[sp, #1104]

    fmov	s21,	s11
    ldr	s16,	[sp, #2140]

    str	s11,	[sp, #2140]

    fmov	s16,	s11
    ldr	s21,	[sp, #1132]

    str	s11,	[sp, #1132]

    fmov	s21,	s11
    ldr	w3,	[sp, #2260]

    ldr	w21,	[sp, #6124]

    ldr	w4,	[sp, #6124]

    mov	w3,	w21
    str	w4,	[sp, #2260]

    ldr	w1,	[sp, #5428]

    ldr	w5,	[sp, #7984]

    ldr	w6,	[sp, #7984]

    mov	w1,	w5
    str	w6,	[sp, #5428]

    ldr	w0,	[sp, #5444]

    ldr	w14,	[sp, #7996]

    ldr	w15,	[sp, #7996]

    mov	w0,	w14
    str	w15,	[sp, #5444]

    ldr	s21,	[sp, #1116]

    str	s11,	[sp, #1116]

    fmov	s21,	s11
    ldr	w19,	[sp, #5420]

    ldr	w2,	[sp, #7976]

    ldr	w0,	[sp, #7976]

    mov	w19,	w2
    str	w0,	[sp, #5420]

    ldr	w16,	[sp, #5452]

    ldr	w20,	[sp, #8004]

    ldr	w21,	[sp, #8004]

    mov	w16,	w20
    str	w21,	[sp, #5452]

    ldr	s21,	[sp, #1080]

    str	s11,	[sp, #1080]

    fmov	s21,	s11
    ldr	s21,	[sp, #1084]

    str	s11,	[sp, #1084]

    fmov	s21,	s11
    ldr	w11,	[sp, #6104]

    ldr	w0,	[sp, #8012]

    ldr	w1,	[sp, #8012]

    mov	w11,	w0
    str	w1,	[sp, #6104]

    ldr	w2,	[sp, #7556]

    ldr	w17,	[sp, #12656]

    ldr	w18,	[sp, #12656]

    mov	w2,	w17
    str	w18,	[sp, #7556]

    ldr	s21,	[sp, #1152]

    str	s11,	[sp, #1152]

    fmov	s21,	s11
    ldr	s21,	[sp, #1088]

    str	s11,	[sp, #1088]

    fmov	s21,	s11
    ldr	s21,	[sp, #1144]

    str	s11,	[sp, #1144]

    fmov	s21,	s11
    b	main_309

main_305:
    ldr	s29,	[sp, #1092]

    fmov	s30,	s7
    fmov	s10,	s9
    fadd	s2,	s29,	s7
    str	s30,	[sp, #1092]

    fmov	s9,	s3
    fmov	s7,	s4
    fadd	s5,	s2,	s4
    ldr	s13,	[sp, #1428]

    fmov	s29,	s5
    fmov	s4,	s1
    fmov	s1,	s8
    fmov	s8,	s31
    fmov	s31,	s18
    fmov	s18,	s25
    fmov	s25,	s26
    fmov	s26,	s21
    fmov	s21,	s13
    ldr	s13,	[sp, #1432]

    str	s13,	[sp, #1428]

    ldr	s22,	[sp, #1440]

    str	s22,	[sp, #1432]

    ldr	s6,	[sp, #1436]

    str	s6,	[sp, #1440]

    ldr	s19,	[sp, #1372]

    str	s19,	[sp, #1436]

    ldr	s17,	[sp, #1376]

    str	s17,	[sp, #1372]

    ldr	s13,	[sp, #1384]

    str	s13,	[sp, #1376]

    ldr	s14,	[sp, #1380]

    str	s14,	[sp, #1384]

    ldr	s30,	[sp, #1392]

    str	s30,	[sp, #1380]

    ldr	s24,	[sp, #1444]

    str	s24,	[sp, #1392]

    ldr	s27,	[sp, #1452]

    str	s27,	[sp, #1444]

    ldr	s22,	[sp, #1448]

    str	s22,	[sp, #1452]

    ldr	s13,	[sp, #1456]

    str	s13,	[sp, #1448]

    ldr	s19,	[sp, #1460]

    str	s19,	[sp, #1456]

    ldr	s6,	[sp, #1468]

    str	s6,	[sp, #1460]

    ldr	s13,	[sp, #1464]

    str	s13,	[sp, #1468]

    fmov	s13,	s15
    str	s13,	[sp, #1464]

    ldr	s27,	[sp, #1480]

    ldr	s6,	[sp, #1484]

    fmov	s15,	s27
    str	s6,	[sp, #1480]

    str	s10,	[sp, #1484]

    ldr	s27,	[sp, #1096]

    ldr	s24,	[sp, #1120]

    fmov	s3,	s27
    fmov	s16,	s24
    str	s16,	[sp, #1096]

    ldr	s19,	[sp, #1128]

    fmov	s16,	s19
    str	s16,	[sp, #1120]

    ldr	s24,	[sp, #1140]

    fmov	s2,	s24
    str	s2,	[sp, #1128]

    ldr	s23,	[sp, #1148]

    str	s23,	[sp, #1140]

    ldr	s14,	[sp, #1156]

    str	s14,	[sp, #1148]

    ldr	s16,	[sp, #1164]

    str	s16,	[sp, #1156]

    ldr	s2,	[sp, #1168]

    str	s2,	[sp, #1164]

    ldr	s16,	[sp, #1188]

    str	s16,	[sp, #1168]

    str	s29,	[sp, #1188]

    b	main_148

