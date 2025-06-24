.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#8848
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w5,	#0
    str	w0,	[sp, #3576]

    mov	w26,	w5

main_10:
    cmp	w26,	#40
    bge	main_18

main_13:
    lsl	w0,	w26,	#2
    add	w0,	w0,	w26,	lsl #3
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getfarray
    add	w2,	w26,	#1
    mov	w26,	w2
    b	main_10

main_18:
    movz	w6,	#0
    mov	w25,	w6

main_19:
    cmp	w25,	#24
    bge	main_27

main_22:
    lsl	w18,	w25,	#2
    add	w28,	w18,	w25,	lsl #3
    mov	x0,	x28
    add	x0,	sp,	x0
    add	x0,	x0,	#496
    bl	getarray
    add	w3,	w25,	#1
    mov	w25,	w3
    b	main_19

main_27:
    add	x5,	sp,	#16
    movz	fp,	#3484
    add	x1,	sp,	#28
    add	x26,	sp,	#40
    add	x18,	sp,	#52
    add	x6,	sp,	#88
    add	x2,	sp,	#100
    str	x5,	[sp, fp]

    movz	fp,	#3484
    ldr	w23,	[sp, #3576]

    lsl	w8,	w23,	#2
    ldr	x10,	[sp, fp]

    add	x23,	sp,	#124
    movz	fp,	#3468
    add	x7,	x10,	x8
    add	x10,	sp,	#76
    ldr	s4,	[x7]

    add	x7,	sp,	#136
    str	s4,	[sp, #1280]

    str	x1,	[sp, fp]

    movz	fp,	#3468
    ldr	w24,	[sp, #3576]

    lsl	w14,	w24,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3460
    add	x11,	x1,	x14
    add	x14,	sp,	#64
    ldr	s20,	[x11]

    str	s20,	[sp, #1216]

    str	x26,	[sp, fp]

    movz	fp,	#3460
    ldr	w25,	[sp, #3576]

    lsl	w16,	w25,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#3452
    add	x15,	x28,	x16
    ldr	s13,	[x15]

    str	s13,	[sp, #1284]

    str	x18,	[sp, fp]

    movz	fp,	#3452
    ldr	w26,	[sp, #3576]

    lsl	w27,	w26,	#2
    ldr	x24,	[sp, fp]

    movz	fp,	#3444
    add	x24,	x24,	x27
    ldr	s20,	[x24]

    add	x24,	sp,	#172
    str	s20,	[sp, #1288]

    str	x14,	[sp, fp]

    movz	fp,	#3444
    ldr	w27,	[sp, #3576]

    lsl	w3,	w27,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#3436
    add	x0,	x17,	x3
    ldr	s19,	[x0]

    str	s19,	[sp, #1292]

    str	x10,	[sp, fp]

    movz	fp,	#3436
    ldr	w28,	[sp, #3576]

    lsl	w1,	w28,	#2
    ldr	x11,	[sp, fp]

    add	x28,	sp,	#160
    movz	fp,	#3428
    add	x0,	x11,	x1
    ldr	s2,	[x0]

    str	s2,	[sp, #1252]

    str	x6,	[sp, fp]

    movz	fp,	#3428
    ldr	w0,	[sp, #3576]

    lsl	w0,	w0,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3420
    add	x4,	x8,	x0
    add	x0,	sp,	#112
    ldr	s3,	[x4]

    str	s3,	[sp, #1224]

    str	x2,	[sp, fp]

    movz	fp,	#3420
    ldr	w1,	[sp, #3576]

    lsl	w6,	w1,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#3412
    add	x8,	x3,	x6
    ldr	s4,	[x8]

    str	s4,	[sp, #1200]

    str	x0,	[sp, fp]

    movz	fp,	#3412
    ldr	w0,	[sp, #3576]

    lsl	w14,	w0,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3396
    add	x12,	x2,	x14
    ldr	s31,	[x12]

    str	s31,	[sp, #1196]

    str	x23,	[sp, fp]

    movz	fp,	#3396
    ldr	w1,	[sp, #3576]

    lsl	w12,	w1,	#2
    ldr	x25,	[sp, fp]

    add	x1,	sp,	#148
    movz	fp,	#3372
    add	x16,	x25,	x12
    add	x12,	sp,	#196
    ldr	s30,	[x16]

    add	x16,	sp,	#184
    str	s30,	[sp, #1296]

    str	x7,	[sp, fp]

    movz	fp,	#3372
    ldr	w2,	[sp, #3576]

    lsl	w18,	w2,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3356
    add	x25,	x8,	x18
    add	x8,	sp,	#208
    ldr	s4,	[x25]

    str	s4,	[sp, #1300]

    str	x1,	[sp, fp]

    movz	fp,	#3356
    ldr	w3,	[sp, #3576]

    lsl	w27,	w3,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3348
    add	x1,	x0,	x27
    ldr	s13,	[x1]

    str	s13,	[sp, #1304]

    str	x28,	[sp, fp]

    movz	fp,	#3348
    ldr	w4,	[sp, #3576]

    lsl	w4,	w4,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3340
    add	x1,	x0,	x4
    add	x0,	sp,	#232
    add	x4,	sp,	#220
    ldr	s16,	[x1]

    str	s16,	[sp, #1212]

    str	x24,	[sp, fp]

    movz	fp,	#3340
    ldr	w5,	[sp, #3576]

    lsl	w2,	w5,	#2
    ldr	x26,	[sp, fp]

    movz	fp,	#3332
    add	x5,	x26,	x2
    ldr	s20,	[x5]

    str	s20,	[sp, #1308]

    str	x16,	[sp, fp]

    movz	fp,	#3332
    ldr	w6,	[sp, #3576]

    lsl	w6,	w6,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#3324
    add	x9,	x18,	x6
    ldr	s19,	[x9]

    str	s19,	[sp, #1312]

    str	x12,	[sp, fp]

    movz	fp,	#3324
    ldr	w7,	[sp, #3576]

    lsl	w10,	w7,	#2
    ldr	x14,	[sp, fp]

    movz	fp,	#3316
    add	x13,	x14,	x10
    ldr	s30,	[x13]

    str	s30,	[sp, #1316]

    str	x8,	[sp, fp]

    movz	fp,	#3316
    ldr	w8,	[sp, #3576]

    lsl	w16,	w8,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#3308
    add	x17,	x9,	x16
    ldr	s27,	[x17]

    add	x17,	sp,	#268
    str	s27,	[sp, #1248]

    str	x4,	[sp, fp]

    movz	fp,	#3308
    ldr	w9,	[sp, #3576]

    lsl	w25,	w9,	#2
    ldr	x5,	[sp, fp]

    add	x9,	sp,	#292
    movz	fp,	#3300
    add	x26,	x5,	x25
    add	x5,	sp,	#304
    add	x25,	sp,	#256
    ldr	s22,	[x26]

    str	s22,	[sp, #1272]

    str	x0,	[sp, fp]

    add	x0,	sp,	#244
    movz	fp,	#3300
    ldr	w10,	[sp, #3576]

    ldr	x1,	[sp, fp]

    lsl	w2,	w10,	#2
    movz	fp,	#3292
    add	x2,	x1,	x2
    ldr	s4,	[x2]

    str	s4,	[sp, #1320]

    str	x0,	[sp, fp]

    movz	fp,	#3292
    ldr	w11,	[sp, #3576]

    lsl	w0,	w11,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3284
    add	x2,	x1,	x0
    add	x1,	sp,	#316
    ldr	s13,	[x2]

    str	s13,	[sp, #1324]

    str	x25,	[sp, fp]

    movz	fp,	#3284
    ldr	w12,	[sp, #3576]

    lsl	w4,	w12,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3276
    add	x6,	x27,	x4
    ldr	s7,	[x6]

    str	s7,	[sp, #1228]

    str	x17,	[sp, fp]

    movz	fp,	#3276
    ldr	w13,	[sp, #3576]

    lsl	w8,	w13,	#2
    ldr	x23,	[sp, fp]

    add	x13,	sp,	#280
    movz	fp,	#3268
    add	x10,	x23,	x8
    ldr	s19,	[x10]

    str	s19,	[sp, #1240]

    str	x13,	[sp, fp]

    movz	fp,	#3268
    ldr	w14,	[sp, #3576]

    lsl	w12,	w14,	#2
    ldr	x15,	[sp, fp]

    movz	fp,	#3260
    add	x14,	x15,	x12
    ldr	s20,	[x14]

    add	x14,	sp,	#340
    str	s20,	[sp, #1328]

    str	x9,	[sp, fp]

    movz	fp,	#3260
    ldr	w15,	[sp, #3576]

    lsl	w18,	w15,	#2
    ldr	x10,	[sp, fp]

    movz	fp,	#3252
    add	x18,	x10,	x18
    ldr	s19,	[x18]

    add	x18,	sp,	#328
    str	s19,	[sp, #1332]

    str	x5,	[sp, fp]

    movz	fp,	#3252
    ldr	w16,	[sp, #3576]

    lsl	w27,	w16,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#3236
    add	x27,	x6,	x27
    ldr	s30,	[x27]

    add	x27,	sp,	#388
    str	s30,	[sp, #1336]

    str	x1,	[sp, fp]

    movz	fp,	#3236
    ldr	w17,	[sp, #3576]

    lsl	w3,	w17,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3220
    add	x0,	x1,	x3
    ldr	s4,	[x0]

    add	x0,	sp,	#376
    str	s4,	[sp, #1340]

    str	x18,	[sp, fp]

    movz	fp,	#3220
    ldr	w18,	[sp, #3576]

    lsl	w2,	w18,	#2
    ldr	x24,	[sp, fp]

    movz	fp,	#3212
    add	x3,	x24,	x2
    add	x2,	sp,	#364
    ldr	s20,	[x3]

    str	s20,	[sp, #1264]

    str	x14,	[sp, fp]

    movz	fp,	#3212
    ldr	w23,	[sp, #3576]

    lsl	w6,	w23,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#3196
    add	x7,	x16,	x6
    add	x6,	sp,	#352
    ldr	s13,	[x7]

    str	s13,	[sp, #1344]

    str	x6,	[sp, fp]

    movz	fp,	#3196
    ldr	w22,	[sp, #3576]

    lsl	w12,	w22,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#3188
    add	x11,	x7,	x12
    add	x7,	sp,	#436
    ldr	s20,	[x11]

    add	x11,	sp,	#424
    str	s20,	[sp, #1356]

    str	x2,	[sp, fp]

    movz	fp,	#3188
    ldr	w23,	[sp, #3576]

    lsl	w16,	w23,	#2
    ldr	x3,	[sp, fp]

    add	x23,	sp,	#400
    movz	fp,	#3180
    add	x15,	x3,	x16
    add	x3,	sp,	#448
    ldr	s16,	[x15]

    add	x15,	sp,	#412
    str	s16,	[sp, #1260]

    str	x0,	[sp, fp]

    movz	fp,	#3180
    ldr	w24,	[sp, #3576]

    lsl	w26,	w24,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3172
    add	x24,	x2,	x26
    ldr	s18,	[x24]

    add	x24,	sp,	#472
    str	s18,	[sp, #1208]

    str	x27,	[sp, fp]

    movz	fp,	#3172
    ldr	w25,	[sp, #3576]

    lsl	w28,	w25,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3164
    add	x0,	x0,	x28
    ldr	s19,	[x0]

    str	s19,	[sp, #1360]

    str	x23,	[sp, fp]

    movz	fp,	#3164
    ldr	w26,	[sp, #3576]

    lsl	w0,	w26,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3156
    add	x0,	x25,	x0
    ldr	s30,	[x0]

    str	s30,	[sp, #1364]

    str	x15,	[sp, fp]

    movz	fp,	#3156
    ldr	w27,	[sp, #3576]

    lsl	w4,	w27,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#3148
    add	x4,	x17,	x4
    ldr	s17,	[x4]

    str	s17,	[sp, #1232]

    str	x11,	[sp, fp]

    movz	fp,	#3148
    ldr	w28,	[sp, #3576]

    lsl	w8,	w28,	#2
    ldr	x13,	[sp, fp]

    movz	fp,	#3140
    add	x8,	x13,	x8
    ldr	s6,	[x8]

    str	s6,	[sp, #1256]

    str	x7,	[sp, fp]

    movz	fp,	#3140
    ldr	w0,	[sp, #3576]

    lsl	w14,	w0,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3132
    add	x12,	x8,	x14
    ldr	s4,	[x12]

    add	x12,	sp,	#484
    str	s4,	[sp, #1372]

    str	x3,	[sp, fp]

    movz	fp,	#3132
    ldr	w1,	[sp, #3576]

    lsl	w18,	w1,	#2
    ldr	x4,	[sp, fp]

    add	x1,	sp,	#460
    movz	fp,	#3124
    add	x16,	x4,	x18
    ldr	s18,	[x16]

    str	s18,	[sp, #1268]

    str	x1,	[sp, fp]

    movz	fp,	#3124
    ldr	w0,	[sp, #3576]

    lsl	w27,	w0,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3108
    add	x25,	x0,	x27
    ldr	s8,	[x25]

    str	s8,	[sp, #1204]

    str	x24,	[sp, fp]

    movz	fp,	#3108
    ldr	w1,	[sp, #3576]

    lsl	w3,	w1,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3092
    add	x1,	x25,	x3
    ldr	s30,	[x1]

    str	s30,	[sp, #1220]

    str	x12,	[sp, fp]

    movz	fp,	#3092
    ldr	w2,	[sp, #3576]

    lsl	w2,	w2,	#2
    ldr	x14,	[sp, fp]

    add	x1,	x14,	x2
    ldr	s13,	[x1]

    str	s13,	[sp, #1236]

    ldr	s18,	[sp, #1280]

    str	s18,	[sp, #1076]

    ldr	s13,	[sp, #1216]

    str	s13,	[sp, #1772]

    ldr	s16,	[sp, #1284]

    fmov	s20,	s16
    ldr	s16,	[sp, #1288]

    ldr	s3,	[sp, #1292]

    fmov	s25,	s16
    ldr	s24,	[sp, #1252]

    fmov	s27,	s3
    ldr	s21,	[sp, #1224]

    fmov	s1,	s24
    ldr	s30,	[sp, #1200]

    fmov	s2,	s21
    fmov	s5,	s30
    ldr	s21,	[sp, #1196]

    ldr	s4,	[sp, #1296]

    fmov	s29,	s21
    ldr	s24,	[sp, #1300]

    ldr	s19,	[sp, #1304]

    fmov	s23,	s24
    ldr	s17,	[sp, #1212]

    fmov	s24,	s19
    str	s17,	[sp, #1396]

    ldr	s8,	[sp, #1308]

    ldr	s19,	[sp, #1312]

    fmov	s6,	s8
    str	s19,	[sp, #1404]

    ldr	s26,	[sp, #1316]

    str	s26,	[sp, #1408]

    ldr	s17,	[sp, #1248]

    str	s17,	[sp, #1420]

    ldr	s28,	[sp, #1272]

    str	s28,	[sp, #1416]

    ldr	s30,	[sp, #1320]

    str	s30,	[sp, #1424]

    ldr	s26,	[sp, #1324]

    fmov	s3,	s26
    str	s3,	[sp, #1428]

    ldr	s3,	[sp, #1228]

    fmov	s19,	s3
    str	s19,	[sp, #1440]

    ldr	s31,	[sp, #1240]

    fmov	s21,	s31
    str	s21,	[sp, #1432]

    ldr	s7,	[sp, #1328]

    str	s7,	[sp, #1444]

    ldr	s19,	[sp, #1332]

    str	s19,	[sp, #1448]

    ldr	s19,	[sp, #1336]

    str	s19,	[sp, #1524]

    ldr	s3,	[sp, #1340]

    str	s3,	[sp, #1520]

    ldr	s18,	[sp, #1264]

    fmov	s31,	s18
    str	s31,	[sp, #1760]

    ldr	s13,	[sp, #1344]

    str	s13,	[sp, #1540]

    ldr	s17,	[sp, #1356]

    fmov	s30,	s17
    str	s30,	[sp, #1544]

    ldr	s7,	[sp, #1260]

    fmov	s16,	s7
    str	s16,	[sp, #1764]

    ldr	s30,	[sp, #1208]

    fmov	s22,	s30
    str	s22,	[sp, #1768]

    ldr	s26,	[sp, #1360]

    fmov	s13,	s26
    str	s13,	[sp, #1084]

    ldr	s19,	[sp, #1364]

    fmov	s8,	s19
    str	s8,	[sp, #1096]

    ldr	s18,	[sp, #1232]

    fmov	s21,	s18
    str	s21,	[sp, #1104]

    ldr	s19,	[sp, #1256]

    fmov	s21,	s19
    str	s21,	[sp, #1132]

    ldr	s26,	[sp, #1372]

    str	s26,	[sp, #1140]

    ldr	s30,	[sp, #1268]

    fmov	s17,	s30
    str	s17,	[sp, #1148]

    ldr	s18,	[sp, #1204]

    fmov	s28,	s18
    str	s28,	[sp, #1156]

    ldr	s22,	[sp, #1220]

    fmov	s17,	s22
    str	s17,	[sp, #1160]

    ldr	s30,	[sp, #1236]

    fmov	s22,	s30
    str	s22,	[sp, #1176]


main_148:
    movi	v28.4s,	#0
    ldr	s17,	[sp, #1176]

    fcmp	s17,	s28
    beq	main_305

main_190:
    ldr	s8,	[sp, #1076]

    add	x1,	sp,	#784
    add	x0,	sp,	#788
    add	x22,	sp,	#792
    add	x25,	sp,	#796
    add	x26,	sp,	#800
    add	x27,	sp,	#804
    add	x28,	sp,	#808
    add	x18,	sp,	#820
    ldr	s13,	[sp, #1772]

    fadd	s13,	s8,	s13
    str	s13,	[sp, #1684]

    ldr	s8,	[sp, #1684]

    fadd	s8,	s8,	s20
    str	s8,	[sp, #1688]

    ldr	s13,	[sp, #1688]

    fadd	s13,	s13,	s25
    str	s13,	[sp, #1184]

    fadd	s13,	s27,	s1
    str	s13,	[sp, #1692]

    ldr	s8,	[sp, #1692]

    fadd	s8,	s8,	s2
    str	s8,	[sp, #1696]

    ldr	s13,	[sp, #1696]

    fadd	s8,	s13,	s5
    fadd	s13,	s29,	s4
    str	s8,	[sp, #1172]

    str	s13,	[sp, #1700]

    ldr	s8,	[sp, #1700]

    fadd	s8,	s8,	s23
    str	s8,	[sp, #1704]

    ldr	s13,	[sp, #1704]

    fadd	s8,	s13,	s24
    str	s8,	[sp, #1600]

    ldr	s8,	[sp, #1396]

    fadd	s8,	s8,	s6
    str	s8,	[sp, #1672]

    ldr	s8,	[sp, #1404]

    ldr	s13,	[sp, #1672]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1676]

    ldr	s13,	[sp, #1408]

    ldr	s8,	[sp, #1676]

    fadd	s13,	s8,	s13
    str	s13,	[sp, #1596]

    ldr	s8,	[sp, #1416]

    ldr	s13,	[sp, #1420]

    fadd	s8,	s13,	s8
    str	s8,	[sp, #1640]

    ldr	s8,	[sp, #1424]

    ldr	s13,	[sp, #1640]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1644]

    ldr	s13,	[sp, #1428]

    ldr	s8,	[sp, #1644]

    fadd	s8,	s8,	s13
    str	s8,	[sp, #1592]

    ldr	s8,	[sp, #1432]

    ldr	s13,	[sp, #1440]

    fadd	s8,	s13,	s8
    str	s8,	[sp, #1632]

    ldr	s13,	[sp, #1444]

    ldr	s8,	[sp, #1632]

    fadd	s13,	s8,	s13
    str	s13,	[sp, #1636]

    ldr	s8,	[sp, #1448]

    ldr	s13,	[sp, #1636]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1588]

    ldr	s13,	[sp, #1520]

    ldr	s8,	[sp, #1524]

    fadd	s13,	s8,	s13
    str	s13,	[sp, #1620]

    ldr	s8,	[sp, #1620]

    ldr	s13,	[sp, #1760]

    fadd	s8,	s8,	s13
    str	s8,	[sp, #1624]

    ldr	s8,	[sp, #1540]

    ldr	s13,	[sp, #1624]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1580]

    ldr	s13,	[sp, #1544]

    ldr	s8,	[sp, #1764]

    fadd	s8,	s13,	s8
    ldr	s13,	[sp, #1768]

    fadd	s13,	s8,	s13
    str	s13,	[sp, #1604]

    ldr	s13,	[sp, #1084]

    ldr	s8,	[sp, #1604]

    fadd	s8,	s8,	s13
    str	s8,	[sp, #1576]

    ldr	s8,	[sp, #1096]

    ldr	s13,	[sp, #1104]

    fadd	s8,	s8,	s13
    ldr	s13,	[sp, #1132]

    fadd	s8,	s8,	s13
    str	s8,	[sp, #1608]

    ldr	s8,	[sp, #1140]

    ldr	s13,	[sp, #1608]

    fadd	s8,	s13,	s8
    str	s8,	[sp, #1584]

    ldr	s13,	[sp, #1148]

    ldr	s8,	[sp, #1156]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1612]

    ldr	s13,	[sp, #1160]

    ldr	s8,	[sp, #1612]

    fadd	s8,	s8,	s13
    ldr	s13,	[sp, #1176]

    fadd	s13,	s8,	s13
    str	s13,	[sp, #2036]

    ldr	s8,	[sp, #1184]

    str	s8,	[x1]

    ldr	s13,	[sp, #1172]

    str	s13,	[x0]

    add	x0,	sp,	#812
    ldr	s13,	[sp, #1600]

    str	s13,	[x22]

    ldr	s8,	[sp, #1596]

    str	s8,	[x25]

    ldr	s13,	[sp, #1592]

    str	s13,	[x26]

    ldr	s8,	[sp, #1588]

    str	s8,	[x27]

    ldr	s8,	[sp, #1580]

    str	s8,	[x28]

    ldr	s13,	[sp, #1576]

    str	s13,	[x0]

    ldr	s13,	[sp, #1584]

    add	x0,	sp,	#816
    str	s13,	[x0]

    movz	w0,	#10
    ldr	s8,	[sp, #2036]

    str	s8,	[x18]

    bl	putfarray
    add	x13,	sp,	#568
    movz	fp,	#3516
    add	x9,	sp,	#760
    add	x25,	sp,	#772
    ldr	w3,	[sp, #3576]

    add	x26,	sp,	#664
    lsl	w24,	w3,	#2
    mov	x18,	x24
    add	x18,	sp,	x18
    add	x18,	x18,	#784
    ldr	s1,	[x18]

    add	x18,	sp,	#544
    str	s1,	[sp, #1276]

    str	x25,	[sp, fp]

    movz	fp,	#3516
    ldr	w4,	[sp, #3576]

    lsl	w0,	w4,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3500
    add	x27,	x27,	x0
    add	x0,	sp,	#520
    ldr	w17,	[x27]

    add	x27,	sp,	#496
    str	w17,	[sp, #2592]

    add	x17,	sp,	#508
    ldr	w14,	[sp, #3576]

    lsl	w4,	w14,	#2
    add	x1,	x0,	x4
    ldr	w15,	[x1]

    str	w15,	[sp, #3572]

    str	x13,	[sp, fp]

    movz	fp,	#3500
    ldr	w6,	[sp, #3576]

    lsl	w1,	w6,	#2
    ldr	x15,	[sp, fp]

    movz	fp,	#3508
    add	x0,	x15,	x1
    ldr	w3,	[x0]

    str	w3,	[sp, #2520]

    str	x17,	[sp, fp]

    movz	fp,	#3508
    ldr	w7,	[sp, #3576]

    lsl	w15,	w7,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#3492
    add	x3,	x19,	x15
    ldr	w16,	[x3]

    str	w16,	[sp, #3544]

    ldr	w16,	[sp, #3576]

    lsl	w3,	w16,	#2
    add	x18,	x18,	x3
    add	x3,	sp,	#556
    ldr	w1,	[x18]

    str	w1,	[sp, #3556]

    add	x1,	sp,	#724
    ldr	w17,	[sp, #3576]

    lsl	w18,	w17,	#2
    add	x17,	sp,	#652
    add	x2,	x3,	x18
    ldr	w24,	[x2]

    str	w24,	[sp, #3548]

    str	x9,	[sp, fp]

    movz	fp,	#3492
    ldr	w10,	[sp, #3576]

    lsl	w4,	w10,	#2
    ldr	x11,	[sp, fp]

    movz	fp,	#3404
    add	x25,	x11,	x4
    ldr	w3,	[x25]

    str	w3,	[sp, #6140]

    str	x27,	[sp, fp]

    add	x27,	sp,	#700
    movz	fp,	#3404
    ldr	w11,	[sp, #3576]

    ldr	x3,	[sp, fp]

    lsl	w2,	w11,	#2
    movz	fp,	#3476
    add	x2,	x3,	x2
    add	x3,	sp,	#616
    ldr	w11,	[x2]

    str	w11,	[sp, #3568]

    str	x1,	[sp, fp]

    add	x1,	sp,	#712
    movz	fp,	#3476
    ldr	w12,	[sp, #3576]

    ldr	x5,	[sp, fp]

    lsl	w15,	w12,	#2
    movz	fp,	#3380
    add	x11,	x5,	x15
    ldr	w4,	[x11]

    add	x11,	sp,	#580
    str	w4,	[sp, #1824]

    str	x11,	[sp, fp]

    movz	fp,	#3380
    ldr	w13,	[sp, #3576]

    lsl	w10,	w13,	#2
    ldr	x15,	[sp, fp]

    movz	fp,	#3364
    add	x9,	x15,	x10
    add	x10,	sp,	#748
    add	x15,	sp,	#592
    ldr	w24,	[x9]

    str	w24,	[sp, #1832]

    str	x3,	[sp, fp]

    movz	fp,	#3364
    ldr	w14,	[sp, #3576]

    lsl	w2,	w14,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#3388
    add	x4,	x7,	x2
    ldr	w0,	[x4]

    str	w0,	[sp, #6136]

    str	x17,	[sp, fp]

    movz	fp,	#3388
    ldr	w17,	[sp, #3576]

    lsl	w6,	w17,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3244
    add	x5,	x25,	x6
    add	x6,	sp,	#688
    ldr	w28,	[x5]

    str	w28,	[sp, #6132]

    ldr	w5,	[sp, #3576]

    lsl	w11,	w5,	#2
    add	x15,	x15,	x11
    ldr	w12,	[x15]

    str	w12,	[sp, #3536]

    ldr	w0,	[sp, #3576]

    lsl	w22,	w0,	#2
    add	x28,	x27,	x22
    ldr	w5,	[x28]

    str	w5,	[sp, #3560]

    ldr	w3,	[sp, #3576]

    lsl	w5,	w3,	#2
    add	x0,	x1,	x5
    add	x1,	sp,	#640
    add	x5,	sp,	#604
    ldr	w4,	[x0]

    str	w4,	[sp, #3552]

    ldr	w4,	[sp, #3576]

    lsl	w24,	w4,	#2
    add	x5,	x5,	x24
    ldr	w0,	[x5]

    str	w0,	[sp, #3528]

    str	x1,	[sp, fp]

    movz	fp,	#3244
    ldr	w28,	[sp, #3576]

    lsl	w15,	w28,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3204
    add	x11,	x1,	x15
    ldr	w14,	[x11]

    str	w14,	[sp, #5496]

    add	x14,	sp,	#628
    str	x14,	[sp, fp]

    movz	fp,	#3204
    ldr	w1,	[sp, #3576]

    lsl	w28,	w1,	#2
    ldr	x13,	[sp, fp]

    add	x1,	sp,	#532
    movz	fp,	#3228
    add	x22,	x13,	x28
    add	x28,	sp,	#676
    ldr	w8,	[x22]

    str	w8,	[sp, #5464]

    str	x6,	[sp, fp]

    movz	fp,	#3228
    ldr	w6,	[sp, #3576]

    lsl	w9,	w6,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3116
    add	x6,	x8,	x9
    ldr	w3,	[x6]

    add	x6,	sp,	#736
    str	x1,	[sp, fp]

    movz	fp,	#3116
    ldr	w0,	[sp, #3576]

    lsl	w9,	w0,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#3100
    add	x8,	x12,	x9
    ldr	w13,	[x8]

    str	w13,	[sp, #3564]

    ldr	w8,	[sp, #3576]

    lsl	w4,	w8,	#2
    add	x9,	x10,	x4
    ldr	w19,	[x9]

    str	w19,	[sp, #3540]

    ldr	w11,	[sp, #3576]

    lsl	w9,	w11,	#2
    add	x8,	x6,	x9
    ldr	w9,	[x8]

    str	w9,	[sp, #3532]

    mov	w9,	w3
    str	x28,	[sp, fp]

    movz	fp,	#3100
    ldr	w8,	[sp, #3576]

    lsl	w15,	w8,	#2
    ldr	x24,	[sp, fp]

    add	x13,	x24,	x15
    ldr	w16,	[x13]

    ldr	w12,	[sp, #3576]

    lsl	w4,	w12,	#2
    add	x1,	x26,	x4
    ldr	w8,	[x1]

    str	w8,	[sp, #3524]

    ldr	w0,	[sp, #2592]

    mov	w15,	w0
    str	w15,	[sp, #2532]

    ldr	w24,	[sp, #3572]

    mov	w26,	w24
    mov	w24,	w16
    str	w26,	[sp, #5444]

    ldr	w8,	[sp, #2520]

    mov	w28,	w8
    str	w28,	[sp, #5468]

    ldr	s21,	[sp, #1292]

    ldr	w1,	[sp, #3544]

    fmov	s6,	s21
    mov	w0,	w1
    str	w0,	[sp, #5472]

    ldr	w0,	[sp, #3556]

    mov	w2,	w0
    str	w2,	[sp, #5448]

    ldr	w11,	[sp, #3548]

    mov	w4,	w11
    str	w4,	[sp, #5452]

    ldr	s19,	[sp, #1196]

    ldr	s18,	[sp, #1316]

    fmov	s21,	s19
    str	s18,	[sp, #1724]

    ldr	s13,	[sp, #1200]

    ldr	w26,	[sp, #6140]

    fmov	s28,	s13
    mov	w19,	w26
    str	w19,	[sp, #2492]

    ldr	s18,	[sp, #1288]

    ldr	s17,	[sp, #1356]

    fmov	s3,	s18
    str	s17,	[sp, #1744]

    ldr	w19,	[sp, #3568]

    mov	w6,	w19
    str	w6,	[sp, #7756]

    ldr	s26,	[sp, #1204]

    str	s26,	[sp, #1460]

    ldr	w11,	[sp, #1824]

    mov	w17,	w11
    str	w17,	[sp, #2336]

    ldr	s24,	[sp, #1208]

    str	s24,	[sp, #1452]

    ldr	s26,	[sp, #1212]

    fmov	s31,	s26
    ldr	s26,	[sp, #1216]

    ldr	s1,	[sp, #1304]

    fmov	s4,	s26
    fmov	s29,	s1
    str	s29,	[sp, #1812]

    ldr	s29,	[sp, #1220]

    str	s29,	[sp, #1468]

    ldr	s2,	[sp, #1224]

    ldr	w15,	[sp, #1832]

    fmov	s26,	s2
    mov	w10,	w15
    str	w10,	[sp, #5456]

    ldr	s1,	[sp, #1364]

    str	s1,	[sp, #1456]

    ldr	w22,	[sp, #6136]

    mov	w13,	w22
    str	w13,	[sp, #5480]

    ldr	w15,	[sp, #6132]

    mov	w4,	w15
    str	w4,	[sp, #5500]

    ldr	s1,	[sp, #1228]

    fmov	s2,	s1
    str	s2,	[sp, #1732]

    ldr	s24,	[sp, #1232]

    str	s24,	[sp, #1116]

    ldr	s24,	[sp, #1332]

    str	s24,	[sp, #1736]

    ldr	s29,	[sp, #1296]

    ldr	s24,	[sp, #1340]

    fmov	s1,	s29
    fmov	s7,	s24
    str	s7,	[sp, #1740]

    ldr	w15,	[sp, #3536]

    str	w15,	[sp, #5460]

    ldr	s16,	[sp, #1236]

    str	s16,	[sp, #1100]

    ldr	w11,	[sp, #3560]

    mov	w27,	w11
    str	w27,	[sp, #2340]

    ldr	s2,	[sp, #1240]

    fmov	s13,	s2
    str	s13,	[sp, #1728]

    ldr	s17,	[sp, #1248]

    fmov	s16,	s17
    str	s16,	[sp, #1720]

    ldr	s16,	[sp, #1252]

    ldr	s27,	[sp, #1256]

    fmov	s20,	s16
    str	s27,	[sp, #1108]

    ldr	w11,	[sp, #3552]

    mov	w15,	w11
    str	w15,	[sp, #1828]

    ldr	w7,	[sp, #3528]

    mov	w11,	w7
    str	w11,	[sp, #7760]

    ldr	s27,	[sp, #1312]

    fmov	s5,	s27
    str	s5,	[sp, #1716]

    ldr	s27,	[sp, #1300]

    ldr	s2,	[sp, #1280]

    fmov	s24,	s27
    fmov	s17,	s2
    str	s17,	[sp, #1120]

    ldr	w17,	[sp, #5496]

    mov	w28,	w17
    str	w28,	[sp, #5476]

    ldr	s17,	[sp, #1360]

    str	s17,	[sp, #1088]

    ldr	w8,	[sp, #5464]

    str	w9,	[sp, #5492]

    mov	w28,	w8
    ldr	s17,	[sp, #1344]

    str	s17,	[sp, #1128]

    ldr	s16,	[sp, #1336]

    ldr	s7,	[sp, #1308]

    fmov	s5,	s16
    ldr	s17,	[sp, #1260]

    fmov	s23,	s7
    fmov	s22,	s17
    str	s22,	[sp, #1092]

    ldr	w19,	[sp, #3564]

    ldr	w14,	[sp, #3540]

    mov	w3,	w19
    mov	w2,	w14
    str	w2,	[sp, #6128]

    ldr	w12,	[sp, #3532]

    mov	w0,	w12
    str	w0,	[sp, #6992]

    ldr	s25,	[sp, #1320]

    ldr	s16,	[sp, #1324]

    fmov	s2,	s25
    ldr	s13,	[sp, #1328]

    fmov	s30,	s16
    ldr	s19,	[sp, #1264]

    fmov	s8,	s13
    fmov	s22,	s19
    str	s22,	[sp, #1124]

    ldr	s22,	[sp, #1268]

    fmov	s25,	s22
    str	s25,	[sp, #1144]

    ldr	s19,	[sp, #1272]

    str	w24,	[sp, #6988]

    fmov	s16,	s19
    ldr	s29,	[sp, #1284]

    fmov	s18,	s29
    str	s18,	[sp, #1072]

    ldr	w5,	[sp, #3524]

    ldr	s29,	[sp, #1372]

    mov	w11,	w5
    fmov	s27,	s29
    str	s27,	[sp, #1136]


main_309:
    ldr	w2,	[sp, #2532]

    cmp	w2,	#0
    beq	main_308

main_375:
    ldr	s11,	[sp, #1120]

    fadd	s13,	s31,	s23
    add	x26,	sp,	#944
    add	x20,	sp,	#948
    add	x19,	sp,	#956
    add	x24,	sp,	#984
    movz	fp,	#4916
    add	x21,	sp,	#992
    ldr	s15,	[sp, #1072]

    fadd	s14,	s11,	s4
    fadd	s12,	s14,	s15
    fadd	s15,	s6,	s20
    fadd	s11,	s12,	s3
    fadd	s14,	s15,	s26
    str	s11,	[sp, #1188]

    fadd	s12,	s14,	s28
    fadd	s14,	s21,	s1
    str	s12,	[sp, #1180]

    fadd	s15,	s14,	s24
    ldr	s14,	[sp, #1812]

    fadd	s14,	s15,	s14
    str	s14,	[sp, #1168]

    ldr	s10,	[sp, #1716]

    ldr	s15,	[sp, #1724]

    fadd	s14,	s13,	s10
    fadd	s12,	s14,	s15
    str	s12,	[sp, #1152]

    ldr	s12,	[sp, #1720]

    fadd	s15,	s12,	s16
    fadd	s12,	s15,	s2
    fadd	s10,	s12,	s30
    str	s10,	[sp, #1488]

    ldr	s13,	[sp, #1728]

    ldr	s11,	[sp, #1732]

    ldr	s14,	[sp, #1736]

    fadd	s13,	s11,	s13
    fadd	s12,	s13,	s8
    fadd	s15,	s12,	s14
    str	s15,	[sp, #1484]

    ldr	s14,	[sp, #1740]

    ldr	s13,	[sp, #1124]

    fadd	s8,	s5,	s14
    ldr	s11,	[sp, #1128]

    fadd	s14,	s8,	s13
    fadd	s15,	s14,	s11
    str	s15,	[sp, #1784]

    ldr	s12,	[sp, #1092]

    ldr	s9,	[sp, #1744]

    ldr	s15,	[sp, #1452]

    fadd	s12,	s9,	s12
    ldr	s8,	[sp, #1088]

    fadd	s15,	s12,	s15
    fadd	s11,	s15,	s8
    str	s11,	[sp, #1780]

    ldr	s9,	[sp, #1116]

    ldr	s14,	[sp, #1456]

    ldr	s12,	[sp, #1108]

    fadd	s15,	s14,	s9
    ldr	s10,	[sp, #1136]

    fadd	s12,	s15,	s12
    fadd	s15,	s12,	s10
    ldr	s12,	[sp, #1144]

    ldr	s11,	[sp, #1460]

    fadd	s10,	s12,	s11
    ldr	s12,	[sp, #1468]

    fadd	s13,	s10,	s12
    ldr	s10,	[sp, #1100]

    str	x26,	[sp, #1848]

    fadd	s10,	s13,	s10
    add	x26,	sp,	#1004
    ldr	s13,	[sp, #1188]

    ldr	x1,	[sp, #1848]

    str	s13,	[x1]

    ldr	s14,	[sp, #1180]

    str	s14,	[x20]

    ldr	s9,	[sp, #1168]

    add	x20,	sp,	#952
    str	s9,	[x20]

    add	x20,	sp,	#960
    ldr	s14,	[sp, #1152]

    str	s14,	[x19]

    add	x19,	sp,	#968
    ldr	s12,	[sp, #1488]

    str	s12,	[x20]

    ldr	s13,	[sp, #1484]

    add	x20,	sp,	#964
    str	s13,	[x20]

    add	x20,	sp,	#972
    ldr	s8,	[sp, #1784]

    str	s8,	[x19]

    add	x19,	sp,	#980
    ldr	s12,	[sp, #1780]

    str	s12,	[x20]

    add	x20,	sp,	#976
    str	s15,	[x20]

    str	s10,	[x19]

    ldr	w19,	[sp, #5444]

    ldr	w23,	[sp, #5472]

    ldr	w25,	[sp, #7756]

    add	w20,	w23,	w19
    add	w1,	w20,	w25
    str	w1,	[sp, #5028]

    ldr	w22,	[sp, #5448]

    ldr	w0,	[sp, #5452]

    add	w22,	w0,	w22
    add	w1,	w22,	w3
    str	w1,	[sp, #2040]

    ldr	w23,	[sp, #5456]

    ldr	w19,	[sp, #5468]

    ldr	w0,	[sp, #5460]

    add	w18,	w23,	w19
    add	w1,	w18,	w0
    str	w1,	[sp, #2060]

    ldr	w1,	[sp, #5480]

    ldr	w19,	[sp, #7760]

    add	w25,	w19,	w1
    add	w1,	w25,	w28
    str	w1,	[sp, #5080]

    ldr	w18,	[sp, #5476]

    ldr	w1,	[sp, #5500]

    add	w27,	w18,	w1
    add	w18,	w27,	w11
    str	w18,	[sp, #2064]

    ldr	w1,	[sp, #2340]

    ldr	w27,	[sp, #5492]

    ldr	w19,	[sp, #6988]

    add	w0,	w27,	w1
    add	w0,	w0,	w19
    str	w0,	[sp, #2252]

    ldr	w20,	[sp, #1828]

    ldr	w18,	[sp, #2336]

    ldr	w23,	[sp, #6992]

    add	w0,	w20,	w18
    add	w23,	w0,	w23
    str	w23,	[sp, #2308]

    ldr	w23,	[sp, #2492]

    ldr	w0,	[sp, #2532]

    ldr	w1,	[sp, #6128]

    add	w25,	w23,	w0
    add	w0,	w25,	w1
    str	w0,	[sp, #2232]

    str	x24,	[sp, fp]

    movz	fp,	#4916
    ldr	x0,	[sp, fp]

    movz	fp,	#4892
    ldr	w1,	[sp, #5028]

    str	w1,	[x0]

    add	x0,	sp,	#996
    add	x1,	sp,	#988
    str	x1,	[sp, #4528]

    ldr	w25,	[sp, #2040]

    ldr	x18,	[sp, #4528]

    str	w25,	[x18]

    str	x21,	[sp, #4536]

    add	x21,	sp,	#1000
    ldr	w25,	[sp, #2060]

    ldr	x24,	[sp, #4536]

    str	w25,	[x24]

    str	x0,	[sp, fp]

    movz	fp,	#4892
    ldr	x24,	[sp, fp]

    movz	fp,	#4932
    ldr	w0,	[sp, #5080]

    str	w0,	[x24]

    str	x21,	[sp, fp]

    add	x21,	sp,	#1008
    movz	fp,	#4932
    ldr	w19,	[sp, #2064]

    ldr	x24,	[sp, fp]

    movz	fp,	#2436
    str	w19,	[x24]

    str	x26,	[sp, fp]

    movz	fp,	#2436
    ldr	w1,	[sp, #2252]

    ldr	x27,	[sp, fp]

    movz	fp,	#2468
    str	w1,	[x27]

    add	x27,	sp,	#1012
    str	x21,	[sp, fp]

    movz	fp,	#2468
    ldr	w18,	[sp, #2308]

    ldr	x24,	[sp, fp]

    movz	fp,	#2476
    str	w18,	[x24]

    str	x27,	[sp, fp]

    movz	fp,	#2476
    ldr	w0,	[sp, #2232]

    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    ldr	x1,	[sp, #1848]

    movz	w0,	#10
    bl	putfarray
    movz	fp,	#4916
    movz	w0,	#8
    ldr	x1,	[sp, fp]

    bl	putarray
    ldr	w0,	[sp, #5028]

    movz	fp,	#4916
    ldr	s2,	[sp, #1188]

    scvtf	s1,	w0
    ldr	x22,	[sp, fp]

    fsub	s30,	s1,	s2
    movz	fp,	#4892
    fcvtzs	w0,	s30
    str	w0,	[x22]

    ldr	w23,	[sp, #2040]

    ldr	s26,	[sp, #1180]

    scvtf	s4,	w23
    ldr	x19,	[sp, #4528]

    fsub	s2,	s4,	s26
    fcvtzs	w3,	s2
    str	w3,	[x19]

    ldr	w27,	[sp, #2060]

    ldr	s13,	[sp, #1168]

    scvtf	s7,	w27
    ldr	x25,	[sp, #4536]

    fsub	s5,	s7,	s13
    fcvtzs	w6,	s5
    str	w6,	[x25]

    ldr	w24,	[sp, #5080]

    ldr	s25,	[sp, #1152]

    scvtf	s9,	w24
    ldr	x4,	[sp, fp]

    fsub	s8,	s9,	s25
    movz	fp,	#4932
    fcvtzs	w10,	s8
    str	w10,	[x4]

    ldr	w1,	[sp, #2064]

    ldr	s23,	[sp, #1488]

    scvtf	s10,	w1
    ldr	x1,	[sp, fp]

    fsub	s26,	s10,	s23
    movz	fp,	#2436
    fcvtzs	w13,	s26
    str	w13,	[x1]

    ldr	w3,	[sp, #2252]

    ldr	s17,	[sp, #1484]

    scvtf	s28,	w3
    ldr	x15,	[sp, fp]

    fsub	s15,	s28,	s17
    movz	fp,	#2468
    fcvtzs	w16,	s15
    str	w16,	[x15]

    ldr	w11,	[sp, #2308]

    ldr	s19,	[sp, #1784]

    scvtf	s20,	w11
    ldr	x7,	[sp, fp]

    fsub	s11,	s20,	s19
    movz	fp,	#2476
    fcvtzs	w24,	s11
    str	w24,	[x7]

    ldr	w15,	[sp, #2232]

    ldr	s15,	[sp, #1780]

    scvtf	s14,	w15
    ldr	x11,	[sp, fp]

    fsub	s13,	s14,	s15
    movz	fp,	#3484
    fcvtzs	w2,	s13
    str	w2,	[x11]

    ldr	w1,	[sp, #3576]

    lsl	w4,	w1,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#984
    ldr	w5,	[x3]

    ldr	x7,	[sp, fp]

    scvtf	s13,	w5
    movz	fp,	#4940
    mov	x13,	x7
    str	x13,	[sp, fp]

    movz	fp,	#3468
    ldr	x1,	[sp, fp]

    movz	fp,	#2972
    mov	x10,	x1
    str	x10,	[sp, fp]

    movz	fp,	#3460
    ldr	x28,	[sp, fp]

    movz	fp,	#3452
    mov	x2,	x28
    ldr	x24,	[sp, fp]

    movz	fp,	#4948
    mov	x17,	x24
    str	x17,	[sp, fp]

    movz	fp,	#3444
    ldr	x17,	[sp, fp]

    movz	fp,	#4956
    mov	x22,	x17
    str	x22,	[sp, fp]

    movz	fp,	#3436
    ldr	x13,	[sp, fp]

    movz	fp,	#2980
    mov	x15,	x13
    str	x15,	[sp, fp]

    movz	fp,	#3428
    ldr	x9,	[sp, fp]

    movz	fp,	#2988
    mov	x19,	x9
    str	x19,	[sp, fp]

    movz	fp,	#3420
    ldr	x5,	[sp, fp]

    movz	fp,	#2996
    mov	x27,	x5
    str	x27,	[sp, fp]

    movz	fp,	#3412
    ldr	x0,	[sp, fp]

    movz	fp,	#3004
    str	x0,	[sp, fp]

    movz	fp,	#3396
    ldr	x25,	[sp, fp]

    movz	fp,	#3372
    mov	x12,	x25
    ldr	x10,	[sp, fp]

    movz	fp,	#4988
    mov	x11,	x10
    str	x11,	[sp, fp]

    movz	fp,	#3356
    ldr	x1,	[sp, fp]

    movz	fp,	#4996
    mov	x15,	x1
    str	x15,	[sp, fp]

    movz	fp,	#3348
    ldr	x4,	[sp, fp]

    movz	fp,	#3012
    mov	x1,	x4
    str	x1,	[sp, fp]

    movz	fp,	#3340
    ldr	x28,	[sp, fp]

    movz	fp,	#5004
    mov	x18,	x28
    str	x18,	[sp, fp]

    movz	fp,	#3332
    ldr	x24,	[sp, fp]

    movz	fp,	#5012
    mov	x23,	x24
    str	x23,	[sp, fp]

    movz	fp,	#3324
    ldr	x17,	[sp, fp]

    movz	fp,	#5020
    mov	x26,	x17
    str	x26,	[sp, fp]

    mov	x26,	x2
    movz	fp,	#3316
    ldr	x14,	[sp, fp]

    movz	fp,	#3020
    mov	x8,	x14
    str	x8,	[sp, fp]

    movz	fp,	#3308
    ldr	x9,	[sp, fp]

    movz	fp,	#3028
    mov	x13,	x9
    str	x13,	[sp, fp]

    movz	fp,	#3300
    ldr	x5,	[sp, fp]

    movz	fp,	#3292
    mov	x3,	x5
    str	x3,	[sp, #5032]

    ldr	x7,	[sp, fp]

    movz	fp,	#3284
    mov	x6,	x7
    str	x6,	[sp, #5040]

    ldr	x8,	[sp, fp]

    movz	fp,	#3036
    mov	x19,	x8
    str	x19,	[sp, fp]

    movz	fp,	#3276
    ldr	x5,	[sp, fp]

    movz	fp,	#3044
    mov	x0,	x5
    str	x0,	[sp, fp]

    movz	fp,	#3268
    ldr	x23,	[sp, fp]

    movz	fp,	#3260
    mov	x9,	x23
    str	x9,	[sp, #5048]

    ldr	x16,	[sp, fp]

    movz	fp,	#3252
    mov	x13,	x16
    str	x13,	[sp, #5056]

    ldr	x10,	[sp, fp]

    movz	fp,	#3236
    mov	x16,	x10
    str	x16,	[sp, #5064]

    ldr	x16,	[sp, fp]

    movz	fp,	#3220
    mov	x19,	x16
    add	x16,	sp,	#912
    str	x19,	[sp, #5072]

    ldr	x5,	[sp, fp]

    movz	fp,	#3052
    mov	x6,	x5
    str	x6,	[sp, fp]

    movz	fp,	#3212
    ldr	x9,	[sp, fp]

    movz	fp,	#5084
    mov	x28,	x9
    str	x28,	[sp, fp]

    movz	fp,	#3196
    ldr	x18,	[sp, fp]

    movz	fp,	#5092
    mov	x0,	x18
    str	x0,	[sp, fp]

    movz	fp,	#3188
    ldr	x9,	[sp, fp]

    movz	fp,	#3060
    mov	x0,	x9
    str	x0,	[sp, fp]

    movz	fp,	#3180
    ldr	x0,	[sp, fp]

    movz	fp,	#3068
    str	x0,	[sp, fp]

    movz	fp,	#3172
    ldr	x0,	[sp, fp]

    movz	fp,	#5100
    mov	x4,	x0
    str	x4,	[sp, fp]

    movz	fp,	#3164
    ldr	x23,	[sp, fp]

    movz	fp,	#5108
    mov	x7,	x23
    add	x23,	sp,	#920
    str	x7,	[sp, fp]

    movz	fp,	#3156
    ldr	x14,	[sp, fp]

    movz	fp,	#3076
    mov	x20,	x14
    str	x20,	[sp, fp]

    movz	fp,	#3148
    ldr	x0,	[sp, fp]

    movz	fp,	#3084
    mov	x8,	x0
    str	x8,	[sp, fp]

    movz	fp,	#3140
    ldr	x8,	[sp, fp]

    movz	fp,	#7748
    mov	x1,	x8
    str	x1,	[sp, fp]

    movz	fp,	#3132
    ldr	x24,	[sp, fp]

    movz	fp,	#5124
    str	x24,	[sp, fp]

    movz	fp,	#3124
    ldr	x6,	[sp, fp]

    movz	fp,	#5132
    mov	x27,	x6
    add	x6,	sp,	#908
    str	x27,	[sp, fp]

    movz	fp,	#3108
    ldr	x0,	[sp, fp]

    movz	fp,	#5140
    mov	x1,	x0
    str	x1,	[sp, fp]

    movz	fp,	#3092
    ldr	x11,	[sp, fp]

    movz	fp,	#5148
    mov	x3,	x11
    add	x11,	sp,	#904
    str	x3,	[sp, fp]

    movz	fp,	#2932
    str	x11,	[sp, fp]

    add	x11,	sp,	#916
    movz	fp,	#2748
    str	x6,	[sp, fp]

    add	x6,	sp,	#932
    movz	fp,	#2756
    str	x16,	[sp, fp]

    add	x16,	sp,	#936
    movz	fp,	#2780
    str	x11,	[sp, #2768]

    add	x11,	sp,	#924
    str	x23,	[sp, fp]

    movz	fp,	#2788
    str	x11,	[sp, fp]

    movz	fp,	#2828
    add	x11,	sp,	#928
    str	x11,	[sp, #2808]

    str	x6,	[sp, #2816]

    add	x6,	sp,	#940
    str	x16,	[sp, fp]

    movz	fp,	#2836
    str	x6,	[sp, fp]

    movz	fp,	#4940
    ldr	x6,	[sp, fp]

    movz	fp,	#5484
    str	x6,	[sp, fp]

    movz	fp,	#2972
    ldr	x18,	[sp, fp]

    movz	fp,	#2900
    mov	x9,	x18
    str	x9,	[sp, fp]

    mov	x9,	x12
    movz	fp,	#2868
    str	x26,	[sp, fp]

    movz	fp,	#4948
    ldr	x25,	[sp, fp]

    movz	fp,	#2852
    mov	x8,	x25
    str	x8,	[sp, fp]

    movz	fp,	#4956
    ldr	x28,	[sp, fp]

    movz	fp,	#2980
    mov	x11,	x28
    str	x11,	[sp, #1016]

    ldr	x6,	[sp, fp]

    movz	fp,	#1028
    mov	x1,	x6
    str	x1,	[sp, fp]

    movz	fp,	#2988
    ldr	x1,	[sp, fp]

    movz	fp,	#2996
    mov	x11,	x1
    str	x11,	[sp, #1040]

    ldr	x26,	[sp, fp]

    movz	fp,	#3004
    str	x26,	[sp, #1048]

    ldr	x11,	[sp, fp]

    movz	fp,	#4988
    mov	x1,	x11
    str	x1,	[sp, #1056]

    str	x9,	[sp, #2800]

    ldr	x17,	[sp, fp]

    movz	fp,	#2732
    mov	x2,	x17
    str	x2,	[sp, fp]

    movz	fp,	#4996
    ldr	x22,	[sp, fp]

    movz	fp,	#3012
    mov	x2,	x22
    str	x2,	[sp, #2712]

    ldr	x1,	[sp, fp]

    movz	fp,	#2724
    mov	x2,	x1
    str	x2,	[sp, fp]

    movz	fp,	#5004
    ldr	x25,	[sp, fp]

    movz	fp,	#2700
    mov	x2,	x25
    str	x2,	[sp, fp]

    movz	fp,	#5012
    ldr	x28,	[sp, fp]

    movz	fp,	#2684
    mov	x1,	x28
    str	x1,	[sp, fp]

    movz	fp,	#5020
    ldr	x2,	[sp, fp]

    movz	fp,	#2660
    mov	x16,	x2
    str	x16,	[sp, fp]

    movz	fp,	#3020
    ldr	x9,	[sp, fp]

    movz	fp,	#2668
    str	x9,	[sp, fp]

    movz	fp,	#3028
    ldr	x2,	[sp, fp]

    movz	fp,	#2676
    mov	x9,	x2
    str	x9,	[sp, fp]

    movz	fp,	#2652
    ldr	x9,	[sp, #5032]

    mov	x22,	x9
    str	x22,	[sp, fp]

    movz	fp,	#2604
    ldr	x12,	[sp, #5040]

    mov	x9,	x12
    str	x9,	[sp, fp]

    movz	fp,	#3036
    ldr	x9,	[sp, fp]

    movz	fp,	#2620
    mov	x20,	x9
    str	x20,	[sp, fp]

    movz	fp,	#3044
    ldr	x1,	[sp, fp]

    movz	fp,	#2636
    mov	x11,	x1
    str	x11,	[sp, fp]

    movz	fp,	#3052
    ldr	x16,	[sp, #5048]

    mov	x1,	x16
    str	x1,	[sp, #2576]

    ldr	x21,	[sp, #5056]

    mov	x27,	x21
    str	x27,	[sp, #2568]

    ldr	x24,	[sp, #5064]

    mov	x20,	x24
    str	x20,	[sp, #2544]

    ldr	x27,	[sp, #5072]

    mov	x18,	x27
    str	x18,	[sp, #2504]

    ldr	x18,	[sp, fp]

    movz	fp,	#2524
    mov	x19,	x18
    str	x19,	[sp, fp]

    movz	fp,	#5084
    ldr	x5,	[sp, fp]

    movz	fp,	#2412
    mov	x17,	x5
    str	x17,	[sp, fp]

    movz	fp,	#5092
    ldr	x8,	[sp, fp]

    movz	fp,	#3060
    mov	x7,	x8
    str	x7,	[sp, #2320]

    ldr	x18,	[sp, fp]

    movz	fp,	#2372
    mov	x3,	x18
    str	x3,	[sp, fp]

    movz	fp,	#3068
    ldr	x7,	[sp, fp]

    movz	fp,	#2388
    mov	x11,	x7
    str	x11,	[sp, fp]

    movz	fp,	#5100
    ldr	x11,	[sp, fp]

    movz	fp,	#5108
    mov	x2,	x11
    str	x2,	[sp, #2280]

    ldr	x15,	[sp, fp]

    movz	fp,	#1836
    mov	x6,	x15
    str	x6,	[sp, fp]

    movz	fp,	#3076
    ldr	x9,	[sp, fp]

    movz	fp,	#3084
    mov	x12,	x9
    str	x12,	[sp, #1816]

    ldr	x16,	[sp, fp]

    movz	fp,	#7748
    mov	x20,	x16
    str	x20,	[sp, #2264]

    ldr	x0,	[sp, fp]

    movz	fp,	#5124
    mov	x23,	x0
    str	x23,	[sp, #2344]

    ldr	x13,	[sp, fp]

    movz	fp,	#2220
    mov	x3,	x13
    str	x3,	[sp, fp]

    movz	fp,	#5132
    ldr	x16,	[sp, fp]

    movz	fp,	#5140
    mov	x3,	x16
    str	x3,	[sp, #2296]

    ldr	x21,	[sp, fp]

    movz	fp,	#2364
    mov	x12,	x21
    str	x12,	[sp, fp]

    movz	fp,	#5148
    ldr	x24,	[sp, fp]

    mov	x1,	x24
    str	x1,	[sp, #2352]


main_518:
    ldr	w0,	[sp, #3576]

    movz	fp,	#5484
    movi	v7.4s,	#0
    lsl	w18,	w0,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#2900
    add	x16,	x6,	x18
    ldr	s30,	[x16]

    ldr	w1,	[sp, #3576]

    ldr	x23,	[sp, fp]

    lsl	w9,	w1,	#2
    movz	fp,	#2868
    add	x22,	x23,	x9
    ldr	s19,	[x22]

    ldr	w2,	[sp, #3576]

    fadd	s3,	s30,	s19
    ldr	x6,	[sp, fp]

    lsl	w22,	w2,	#2
    movz	fp,	#2852
    add	x2,	x6,	x22
    ldr	s24,	[x2]

    ldr	w3,	[sp, #3576]

    fadd	s5,	s3,	s24
    ldr	x1,	[sp, fp]

    lsl	w22,	w3,	#2
    movz	fp,	#1028
    add	x7,	x1,	x22
    ldr	s28,	[x7]

    ldr	w4,	[sp, #3576]

    fadd	s25,	s5,	s28
    ldr	x11,	[sp, #1016]

    lsl	w8,	w4,	#2
    add	x11,	x11,	x8
    ldr	s4,	[x11]

    ldr	w5,	[sp, #3576]

    ldr	x24,	[sp, fp]

    lsl	w8,	w5,	#2
    movz	fp,	#2732
    add	x14,	x24,	x8
    ldr	s14,	[x14]

    ldr	w6,	[sp, #3576]

    fadd	s8,	s4,	s14
    ldr	x1,	[sp, #1040]

    lsl	w22,	w6,	#2
    add	x18,	x1,	x22
    ldr	s19,	[x18]

    ldr	w7,	[sp, #3576]

    fadd	s9,	s8,	s19
    lsl	w2,	w7,	#2
    ldr	x7,	[sp, #1048]

    add	x1,	x7,	x2
    ldr	s24,	[x1]

    ldr	w8,	[sp, #3576]

    fadd	s1,	s9,	s24
    ldr	x12,	[sp, #1056]

    lsl	w8,	w8,	#2
    add	x6,	x12,	x8
    ldr	s12,	[x6]

    ldr	w9,	[sp, #3576]

    ldr	x5,	[sp, #2800]

    lsl	w13,	w9,	#2
    add	x9,	x5,	x13
    ldr	s21,	[x9]

    ldr	w10,	[sp, #3576]

    fadd	s18,	s12,	s21
    ldr	x0,	[sp, fp]

    lsl	w22,	w10,	#2
    movz	fp,	#2724
    add	x13,	x0,	x22
    ldr	s26,	[x13]

    ldr	w11,	[sp, #3576]

    fadd	s19,	s18,	s26
    ldr	x14,	[sp, #2712]

    lsl	w18,	w11,	#2
    add	x17,	x14,	x18
    ldr	s2,	[x17]

    ldr	w12,	[sp, #3576]

    fadd	s2,	s19,	s2
    ldr	x28,	[sp, fp]

    lsl	w1,	w12,	#2
    movz	fp,	#2700
    add	x0,	x28,	x1
    ldr	s19,	[x0]

    ldr	w13,	[sp, #3576]

    ldr	x4,	[sp, fp]

    lsl	w7,	w13,	#2
    movz	fp,	#2684
    add	x3,	x4,	x7
    ldr	s8,	[x3]

    ldr	w14,	[sp, #3576]

    fadd	s19,	s19,	s8
    ldr	x27,	[sp, fp]

    lsl	w11,	w14,	#2
    movz	fp,	#2660
    add	x8,	x27,	x11
    ldr	s12,	[x8]

    ldr	w15,	[sp, #3576]

    fadd	s26,	s19,	s12
    ldr	x9,	[sp, fp]

    lsl	w2,	w15,	#2
    movz	fp,	#2668
    add	x12,	x9,	x2
    ldr	s12,	[x12]

    ldr	w16,	[sp, #3576]

    fadd	s11,	s26,	s12
    ldr	x14,	[sp, fp]

    lsl	w8,	w16,	#2
    movz	fp,	#2676
    add	x22,	x14,	x8
    ldr	s20,	[x22]

    ldr	w17,	[sp, #3576]

    ldr	x19,	[sp, fp]

    lsl	w12,	w17,	#2
    movz	fp,	#2652
    add	x2,	x19,	x12
    ldr	s15,	[x2]

    ldr	w18,	[sp, #3576]

    fadd	s26,	s20,	s15
    ldr	x3,	[sp, fp]

    lsl	w22,	w18,	#2
    movz	fp,	#2604
    add	x8,	x3,	x22
    ldr	s16,	[x8]

    ldr	w22,	[sp, #3576]

    fadd	s24,	s26,	s16
    ldr	x2,	[sp, fp]

    lsl	w4,	w22,	#2
    movz	fp,	#2620
    add	x13,	x2,	x4
    ldr	s20,	[x13]

    ldr	w23,	[sp, #3576]

    fadd	s16,	s24,	s20
    ldr	x13,	[sp, fp]

    lsl	w8,	w23,	#2
    movz	fp,	#2636
    add	x18,	x13,	x8
    ldr	s26,	[x18]

    ldr	w24,	[sp, #3576]

    ldr	x26,	[sp, fp]

    lsl	w2,	w24,	#2
    movz	fp,	#2524
    add	x1,	x26,	x2
    ldr	s17,	[x1]

    ldr	w25,	[sp, #3576]

    fadd	s3,	s26,	s17
    lsl	w8,	w25,	#2
    ldr	x25,	[sp, #2576]

    add	x7,	x25,	x8
    ldr	s17,	[x7]

    ldr	w26,	[sp, #3576]

    fadd	s31,	s3,	s17
    ldr	x9,	[sp, #2568]

    lsl	w2,	w26,	#2
    add	x12,	x9,	x2
    ldr	s22,	[x12]

    ldr	w27,	[sp, #3576]

    fadd	s15,	s31,	s22
    ldr	x26,	[sp, #2544]

    lsl	w18,	w27,	#2
    add	x17,	x26,	x18
    ldr	s14,	[x17]

    ldr	w28,	[sp, #3576]

    ldr	x27,	[sp, #2504]

    lsl	w1,	w28,	#2
    add	x0,	x27,	x1
    ldr	s22,	[x0]

    ldr	w0,	[sp, #3576]

    fadd	s18,	s14,	s22
    ldr	x7,	[sp, fp]

    lsl	w22,	w0,	#2
    movz	fp,	#2412
    add	x6,	x7,	x22
    ldr	s23,	[x6]

    ldr	w0,	[sp, #3576]

    fadd	s27,	s18,	s23
    ldr	x6,	[sp, fp]

    lsl	w2,	w0,	#2
    movz	fp,	#2372
    add	x11,	x6,	x2
    ldr	s28,	[x11]

    ldr	w1,	[sp, #3576]

    fadd	s14,	s27,	s28
    ldr	x2,	[sp, #2320]

    lsl	w10,	w1,	#2
    add	x16,	x2,	x10
    ldr	s10,	[x16]

    ldr	w0,	[sp, #3576]

    ldr	x16,	[sp, fp]

    lsl	w12,	w0,	#2
    movz	fp,	#2388
    add	x22,	x16,	x12
    ldr	s5,	[x22]

    ldr	w1,	[sp, #3576]

    fadd	s24,	s10,	s5
    ldr	x27,	[sp, fp]

    lsl	w6,	w1,	#2
    movz	fp,	#1836
    add	x3,	x27,	x6
    ldr	s12,	[x3]

    ldr	w2,	[sp, #3576]

    fadd	s10,	s24,	s12
    ldr	x25,	[sp, #2280]

    lsl	w11,	w2,	#2
    add	x9,	x25,	x11
    ldr	s18,	[x9]

    ldr	w3,	[sp, #3576]

    fadd	s31,	s10,	s18
    ldr	x28,	[sp, fp]

    lsl	w16,	w3,	#2
    movz	fp,	#2220
    add	x14,	x28,	x16
    ldr	s24,	[x14]

    ldr	w4,	[sp, #3576]

    ldr	x0,	[sp, #1816]

    lsl	w14,	w4,	#2
    add	x18,	x0,	x14
    ldr	s3,	[x18]

    ldr	w5,	[sp, #3576]

    fadd	s6,	s24,	s3
    ldr	x13,	[sp, #2264]

    lsl	w22,	w5,	#2
    add	x2,	x13,	x22
    ldr	s22,	[x2]

    ldr	w6,	[sp, #3576]

    fadd	s10,	s6,	s22
    ldr	x17,	[sp, #2344]

    lsl	w2,	w6,	#2
    add	x8,	x17,	x2
    ldr	s22,	[x8]

    ldr	w7,	[sp, #3576]

    fadd	s19,	s10,	s22
    ldr	x2,	[sp, fp]

    lsl	w10,	w7,	#2
    movz	fp,	#2364
    add	x13,	x2,	x10
    ldr	s5,	[x13]

    ldr	w8,	[sp, #3576]

    ldr	x1,	[sp, #2296]

    lsl	w18,	w8,	#2
    add	x17,	x1,	x18
    ldr	s6,	[x17]

    ldr	w9,	[sp, #3576]

    fadd	s17,	s5,	s6
    ldr	x11,	[sp, fp]

    lsl	w22,	w9,	#2
    movz	fp,	#2932
    add	x1,	x11,	x22
    ldr	s30,	[x1]

    ldr	w10,	[sp, #3576]

    fadd	s29,	s17,	s30
    ldr	x2,	[sp, #2352]

    lsl	w4,	w10,	#2
    add	x2,	x2,	x4
    ldr	s5,	[x2]

    ldr	x18,	[sp, fp]

    fadd	s21,	s29,	s5
    movz	fp,	#2748
    str	s25,	[x18]

    ldr	x16,	[sp, fp]

    movz	fp,	#2756
    str	s1,	[x16]

    ldr	x22,	[sp, fp]

    movz	fp,	#2780
    str	s2,	[x22]

    ldr	x0,	[sp, #2768]

    str	s11,	[x0]

    ldr	x6,	[sp, fp]

    movz	fp,	#2788
    str	s16,	[x6]

    ldr	x9,	[sp, fp]

    movz	fp,	#2828
    str	s15,	[x9]

    ldr	x18,	[sp, #2808]

    str	s14,	[x18]

    ldr	x24,	[sp, #2816]

    str	s31,	[x24]

    ldr	x3,	[sp, fp]

    movz	fp,	#2836
    str	s19,	[x3]

    ldr	x3,	[sp, fp]

    str	s21,	[x3]

    ldr	s2,	[x2]

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
    movz	fp,	#2932
    ldr	x1,	[sp, fp]

    bl	putfarray
    add	x7,	sp,	#864
    add	x6,	sp,	#836
    ldr	w11,	[sp, #3576]

    movz	fp,	#3404
    add	x25,	sp,	#872
    add	x20,	sp,	#884
    add	x17,	sp,	#832
    add	x16,	sp,	#840
    lsl	w0,	w11,	#2
    mov	x1,	x0
    add	x1,	sp,	x1
    add	x1,	x1,	#904
    ldr	s12,	[x1]

    ldr	x28,	[sp, fp]

    movz	fp,	#3116
    mov	x9,	x28
    add	x28,	sp,	#888
    ldr	x0,	[sp, fp]

    movz	fp,	#3500
    mov	x15,	x0
    ldr	x19,	[sp, fp]

    movz	fp,	#3380
    mov	x14,	x19
    str	x14,	[sp, #4304]

    ldr	x18,	[sp, fp]

    movz	fp,	#3364
    mov	x10,	x18
    ldr	x5,	[sp, fp]

    movz	fp,	#3988
    mov	x27,	x5
    str	x27,	[sp, fp]

    movz	fp,	#3204
    ldr	x14,	[sp, fp]

    movz	fp,	#4876
    mov	x4,	x14
    str	x4,	[sp, fp]

    movz	fp,	#3244
    ldr	x3,	[sp, fp]

    movz	fp,	#3980
    mov	x24,	x3
    str	x24,	[sp, fp]

    movz	fp,	#3388
    ldr	x23,	[sp, fp]

    movz	fp,	#3100
    mov	x19,	x23
    str	x19,	[sp, #4312]

    add	x19,	sp,	#896
    ldr	x24,	[sp, fp]

    movz	fp,	#4868
    mov	x1,	x24
    add	x24,	sp,	#824
    str	x1,	[sp, fp]

    add	x1,	sp,	#900
    movz	fp,	#3228
    ldr	x5,	[sp, fp]

    movz	fp,	#3476
    mov	x13,	x5
    add	x5,	sp,	#876
    ldr	x3,	[sp, fp]

    movz	fp,	#3996
    mov	x2,	x3
    add	x3,	sp,	#828
    str	x2,	[sp, fp]

    movz	fp,	#3492
    ldr	x18,	[sp, fp]

    movz	fp,	#4740
    mov	x21,	x18
    str	x21,	[sp, fp]

    movz	fp,	#3516
    ldr	x8,	[sp, fp]

    movz	fp,	#4724
    mov	x14,	x8
    str	x14,	[sp, fp]

    movz	fp,	#3508
    ldr	x4,	[sp, fp]

    movz	fp,	#4732
    mov	x18,	x4
    add	x4,	sp,	#848
    str	x18,	[sp, fp]

    add	x18,	sp,	#844
    movz	fp,	#2692
    str	x24,	[sp, fp]

    add	x24,	sp,	#852
    movz	fp,	#5156
    str	x3,	[sp, fp]

    movz	fp,	#5116
    str	x17,	[sp, fp]

    mov	x17,	x13
    movz	fp,	#5164
    str	x6,	[sp, fp]

    add	x6,	sp,	#892
    movz	fp,	#2380
    str	x16,	[sp, #2272]

    str	x18,	[sp, #2328]

    str	x4,	[sp, fp]

    add	x4,	sp,	#856
    movz	fp,	#2396
    str	x24,	[sp, fp]

    add	x24,	sp,	#860
    movz	fp,	#2404
    str	x4,	[sp, fp]

    add	x4,	sp,	#868
    movz	fp,	#2484
    str	x24,	[sp, fp]

    movz	fp,	#2964
    str	x7,	[sp, fp]

    add	x7,	sp,	#880
    movz	fp,	#2860
    str	x4,	[sp, fp]

    mov	x4,	x9
    movz	fp,	#2876
    str	x25,	[sp, fp]

    movz	fp,	#2892
    str	x5,	[sp, fp]

    movz	fp,	#2884
    str	x7,	[sp, fp]

    movz	fp,	#2916
    str	x20,	[sp, fp]

    movz	fp,	#2924
    str	x28,	[sp, fp]

    movz	fp,	#2940
    str	x6,	[sp, fp]

    movz	fp,	#2948
    str	x19,	[sp, fp]

    movz	fp,	#2956
    str	x1,	[sp, fp]

    movz	fp,	#3948
    ldr	s6,	[sp, #1280]

    fmov	s21,	s6
    str	x4,	[sp, fp]

    movz	fp,	#2972
    ldr	w4,	[sp, #3544]

    mov	w5,	w4
    str	w5,	[sp, #2908]

    ldr	x25,	[sp, fp]

    movz	fp,	#4748
    str	x25,	[sp, fp]

    movz	fp,	#2980
    ldr	s4,	[sp, #1284]

    ldr	w5,	[sp, #3572]

    fmov	s15,	s4
    mov	w1,	w5
    str	w1,	[sp, #2912]

    ldr	s7,	[sp, #1288]

    ldr	s6,	[sp, #1292]

    fmov	s28,	s7
    ldr	x7,	[sp, fp]

    fmov	s17,	s6
    movz	fp,	#2644
    mov	x14,	x7
    str	x14,	[sp, fp]

    movz	fp,	#2612
    str	x15,	[sp, fp]

    movz	fp,	#2988
    ldr	w4,	[sp, #3556]

    mov	w5,	w4
    str	w5,	[sp, #2844]

    ldr	w4,	[sp, #3548]

    mov	w15,	w4
    mov	x4,	x10
    str	w15,	[sp, #2848]

    ldr	x15,	[sp, fp]

    movz	fp,	#2628
    mov	x6,	x15
    str	x6,	[sp, fp]

    movz	fp,	#2596
    ldr	x16,	[sp, #4304]

    mov	x7,	x16
    str	x7,	[sp, fp]

    movz	fp,	#2996
    str	x4,	[sp, #2536]

    ldr	w18,	[sp, #3536]

    mov	w26,	w18
    str	w26,	[sp, #1024]

    ldr	x6,	[sp, fp]

    movz	fp,	#3004
    mov	x10,	x6
    str	x10,	[sp, #2552]

    ldr	x15,	[sp, fp]

    movz	fp,	#3012
    mov	x5,	x15
    str	x5,	[sp, #2560]

    ldr	s2,	[sp, #1296]

    fmov	s29,	s2
    ldr	s2,	[sp, #1300]

    ldr	s19,	[sp, #1304]

    fmov	s5,	s2
    ldr	x6,	[sp, fp]

    fmov	s30,	s19
    movz	fp,	#3988
    mov	x22,	x6
    str	x22,	[sp, #2584]

    ldr	w5,	[sp, #3528]

    mov	w6,	w5
    str	w6,	[sp, #1036]

    ldr	s19,	[sp, #1308]

    ldr	s22,	[sp, #1312]

    fmov	s18,	s19
    ldr	s4,	[sp, #1316]

    fmov	s31,	s22
    ldr	x26,	[sp, fp]

    movz	fp,	#3020
    mov	x5,	x26
    str	x5,	[sp, #2496]

    ldr	x15,	[sp, fp]

    movz	fp,	#4876
    mov	x14,	x15
    str	x14,	[sp, #2512]

    ldr	x5,	[sp, fp]

    movz	fp,	#3980
    mov	x6,	x5
    str	x6,	[sp, #2312]

    ldr	x0,	[sp, fp]

    movz	fp,	#4972
    str	x0,	[sp, fp]

    movz	fp,	#3028
    ldr	x18,	[sp, fp]

    movz	fp,	#2428
    mov	x8,	x18
    str	x8,	[sp, fp]

    movz	fp,	#4980
    ldr	s8,	[sp, #1320]

    fmov	s9,	s8
    ldr	s8,	[sp, #1324]

    ldr	x5,	[sp, #4312]

    fmov	s11,	s8
    str	x5,	[sp, fp]

    movz	fp,	#3036
    ldr	w14,	[sp, #3524]

    mov	w5,	w14
    str	w5,	[sp, #2824]

    ldr	x4,	[sp, fp]

    movz	fp,	#4964
    mov	x25,	x4
    str	x25,	[sp, fp]

    movz	fp,	#3044
    ldr	x15,	[sp, fp]

    movz	fp,	#2452
    mov	x25,	x15
    str	x25,	[sp, fp]

    movz	fp,	#4868
    ldr	s3,	[sp, #1328]

    ldr	s19,	[sp, #1332]

    fmov	s14,	s3
    ldr	x24,	[sp, fp]

    fmov	s27,	s19
    movz	fp,	#4924
    str	x24,	[sp, fp]

    movz	fp,	#2444
    str	x17,	[sp, fp]

    movz	fp,	#3996
    ldr	w13,	[sp, #3560]

    mov	w8,	w13
    str	w8,	[sp, #2764]

    ldr	w17,	[sp, #3552]

    mov	w20,	w17
    str	w20,	[sp, #2776]

    ldr	s10,	[sp, #1336]

    ldr	s1,	[sp, #1340]

    fmov	s6,	s10
    ldr	x6,	[sp, fp]

    fmov	s24,	s1
    movz	fp,	#4900
    str	x6,	[sp, fp]

    movz	fp,	#3052
    ldr	w14,	[sp, #3532]

    mov	w12,	w14
    str	w12,	[sp, #2740]

    ldr	x13,	[sp, fp]

    movz	fp,	#4908
    mov	x11,	x13
    str	x11,	[sp, fp]

    movz	fp,	#4740
    ldr	w13,	[sp, #3540]

    mov	w20,	w13
    str	w20,	[sp, #2744]

    ldr	x11,	[sp, fp]

    movz	fp,	#4724
    str	x11,	[sp, #4520]

    ldr	x0,	[sp, fp]

    movz	fp,	#2460
    str	x0,	[sp, fp]

    movz	fp,	#3060
    ldr	s2,	[sp, #1344]

    ldr	s3,	[sp, #1356]

    fmov	s10,	s2
    ldr	x23,	[sp, fp]

    fmov	s2,	s3
    movz	fp,	#4732
    mov	x26,	x23
    str	x26,	[sp, #4544]

    ldr	w11,	[sp, #3568]

    mov	w5,	w11
    str	w5,	[sp, #2720]

    ldr	x3,	[sp, fp]

    movz	fp,	#2420
    str	x3,	[sp, fp]

    movz	fp,	#3068
    ldr	x10,	[sp, fp]

    movz	fp,	#2244
    mov	x20,	x10
    str	x20,	[sp, fp]

    movz	fp,	#3076
    ldr	s26,	[sp, #1360]

    ldr	w3,	[sp, #3572]

    fmov	s8,	s26
    mov	w20,	w3
    str	w20,	[sp, #2708]

    ldr	s16,	[sp, #1364]

    ldr	x17,	[sp, fp]

    movz	fp,	#3084
    mov	x14,	x17
    str	x14,	[sp, #2256]

    ldr	x23,	[sp, fp]

    mov	x13,	x23
    str	x13,	[sp, #2288]

    ldr	s23,	[sp, #1372]

    ldr	w22,	[sp, #3564]

    mov	w23,	w22
    str	w23,	[sp, #2796]


main_717:
    ldr	w28,	[sp, #3576]

    movz	fp,	#4748
    lsl	w15,	w28,	#2
    ldr	x23,	[sp, fp]

    movz	fp,	#2644
    add	x22,	x23,	x15
    ldr	s25,	[x22]

    fadd	s3,	s21,	s25
    fadd	s20,	s3,	s15
    fadd	s25,	s20,	s28
    str	s25,	[sp, #1492]

    ldr	w5,	[sp, #3576]

    ldr	x22,	[sp, fp]

    lsl	w15,	w5,	#2
    movz	fp,	#2628
    add	x14,	x22,	x15
    ldr	s22,	[x14]

    ldr	w9,	[sp, #3576]

    fadd	s26,	s17,	s22
    ldr	x18,	[sp, fp]

    lsl	w15,	w9,	#2
    movz	fp,	#2428
    add	x20,	x18,	x15
    ldr	s1,	[x20]

    ldr	w11,	[sp, #3576]

    fadd	s7,	s26,	s1
    ldr	x22,	[sp, #2552]

    lsl	w14,	w11,	#2
    add	x12,	x22,	x14
    ldr	s25,	[x12]

    fadd	s20,	s7,	s25
    str	s20,	[sp, #1512]

    ldr	w12,	[sp, #3576]

    ldr	x13,	[sp, #2560]

    lsl	w12,	w12,	#2
    add	x22,	x13,	x12
    ldr	s20,	[x22]

    fadd	s22,	s20,	s29
    fadd	s20,	s22,	s5
    fadd	s20,	s20,	s30
    str	s20,	[sp, #1496]

    ldr	w15,	[sp, #3576]

    ldr	x9,	[sp, #2584]

    lsl	w15,	w15,	#2
    add	x15,	x9,	x15
    ldr	s1,	[x15]

    fadd	s22,	s1,	s18
    fadd	s20,	s22,	s31
    fadd	s25,	s20,	s4
    str	s25,	[sp, #1500]

    ldr	w2,	[sp, #3576]

    ldr	x23,	[sp, #2512]

    lsl	w20,	w2,	#2
    add	x3,	x23,	x20
    ldr	s19,	[x3]

    ldr	w3,	[sp, #3576]

    ldr	x9,	[sp, fp]

    lsl	w15,	w3,	#2
    movz	fp,	#4964
    add	x14,	x9,	x15
    ldr	s22,	[x14]

    fadd	s20,	s19,	s22
    fadd	s19,	s6,	s24
    fadd	s20,	s20,	s9
    fadd	s20,	s20,	s11
    str	s20,	[sp, #1504]

    ldr	w9,	[sp, #3576]

    ldr	x26,	[sp, fp]

    lsl	w3,	w9,	#2
    movz	fp,	#2452
    add	x25,	x26,	x3
    ldr	s7,	[x25]

    ldr	w12,	[sp, #3576]

    ldr	x26,	[sp, fp]

    lsl	w15,	w12,	#2
    movz	fp,	#4908
    add	x13,	x26,	x15
    ldr	s20,	[x13]

    fadd	s1,	s7,	s20
    fadd	s22,	s1,	s14
    fadd	s25,	s22,	s27
    str	s25,	[sp, #1508]

    ldr	w13,	[sp, #3576]

    ldr	x12,	[sp, fp]

    lsl	w15,	w13,	#2
    movz	fp,	#2244
    add	x13,	x12,	x15
    ldr	s22,	[x13]

    fadd	s20,	s19,	s22
    fadd	s26,	s20,	s10
    str	s26,	[sp, #1064]

    ldr	w14,	[sp, #3576]

    ldr	x28,	[sp, #4544]

    lsl	w22,	w14,	#2
    add	x15,	x28,	x22
    ldr	s20,	[x15]

    ldr	w15,	[sp, #3576]

    fadd	s22,	s2,	s20
    ldr	x20,	[sp, fp]

    lsl	w14,	w15,	#2
    movz	fp,	#2692
    add	x15,	x20,	x14
    ldr	s19,	[x15]

    fadd	s22,	s22,	s19
    fadd	s22,	s22,	s8
    str	s22,	[sp, #1112]

    ldr	w17,	[sp, #3576]

    ldr	x13,	[sp, #2256]

    lsl	w15,	w17,	#2
    add	x13,	x13,	x15
    ldr	s22,	[x13]

    ldr	w18,	[sp, #3576]

    fadd	s20,	s16,	s22
    ldr	x12,	[sp, #2288]

    lsl	w13,	w18,	#2
    add	x14,	x12,	x13
    ldr	s7,	[x14]

    fadd	s20,	s20,	s7
    fadd	s20,	s20,	s23
    str	s20,	[sp, #1164]

    movi	v20.4s,	#0
    ldr	s22,	[sp, #1492]

    ldr	x22,	[sp, fp]

    movz	fp,	#5156
    str	s22,	[x22]

    ldr	s25,	[sp, #1512]

    ldr	x27,	[sp, fp]

    movz	fp,	#5116
    str	s25,	[x27]

    ldr	s25,	[sp, #1496]

    ldr	x10,	[sp, fp]

    movz	fp,	#5164
    str	s25,	[x10]

    ldr	s22,	[sp, #1500]

    ldr	x1,	[sp, fp]

    movz	fp,	#2380
    str	s22,	[x1]

    ldr	s25,	[sp, #1504]

    ldr	x2,	[sp, #2272]

    str	s25,	[x2]

    ldr	s22,	[sp, #1508]

    ldr	x17,	[sp, #2328]

    str	s22,	[x17]

    ldr	s1,	[sp, #1064]

    ldr	x9,	[sp, fp]

    movz	fp,	#2396
    str	s1,	[x9]

    ldr	s25,	[sp, #1112]

    ldr	x22,	[sp, fp]

    movz	fp,	#2404
    str	s25,	[x22]

    ldr	s25,	[sp, #1164]

    ldr	x9,	[sp, fp]

    movz	fp,	#2484
    str	s25,	[x9]

    ldr	x22,	[sp, fp]

    movz	fp,	#3948
    str	s20,	[x22]

    ldr	w20,	[sp, #3576]

    ldr	x5,	[sp, fp]

    lsl	w20,	w20,	#2
    movz	fp,	#2612
    add	x15,	x5,	x20
    ldr	w14,	[x15]

    ldr	w15,	[sp, #2908]

    ldr	w12,	[sp, #2912]

    add	w26,	w12,	w15
    add	w15,	w26,	w14
    str	w15,	[sp, #2228]

    ldr	w20,	[sp, #3576]

    ldr	x17,	[sp, fp]

    lsl	w22,	w20,	#2
    movz	fp,	#2596
    add	x15,	x17,	x22
    ldr	w14,	[x15]

    ldr	w11,	[sp, #2844]

    ldr	w27,	[sp, #2848]

    add	w3,	w27,	w11
    add	w15,	w3,	w14
    str	w15,	[sp, #2360]

    ldr	w2,	[sp, #3576]

    ldr	x18,	[sp, fp]

    lsl	w14,	w2,	#2
    movz	fp,	#4972
    add	x10,	x18,	x14
    ldr	w24,	[x10]

    ldr	w3,	[sp, #3576]

    ldr	x12,	[sp, #2536]

    lsl	w14,	w3,	#2
    add	x13,	x12,	x14
    ldr	w20,	[x13]

    ldr	w14,	[sp, #1024]

    add	w13,	w24,	w14
    add	w9,	w13,	w20
    str	w9,	[sp, #2240]

    ldr	w9,	[sp, #3576]

    ldr	x15,	[sp, #2496]

    lsl	w20,	w9,	#2
    add	x15,	x15,	x20
    ldr	w25,	[x15]

    ldr	w15,	[sp, #1036]

    ldr	w12,	[sp, #3576]

    add	w14,	w25,	w15
    lsl	w18,	w12,	#2
    ldr	x15,	[sp, #2312]

    add	x13,	x15,	x18
    ldr	w12,	[x13]

    add	w11,	w14,	w12
    str	w11,	[sp, #2236]

    ldr	w13,	[sp, #3576]

    ldr	x1,	[sp, fp]

    lsl	w15,	w13,	#2
    movz	fp,	#4980
    add	x3,	x1,	x15
    ldr	w28,	[x3]

    ldr	w14,	[sp, #3576]

    ldr	x6,	[sp, fp]

    lsl	w25,	w14,	#2
    movz	fp,	#4924
    add	x20,	x6,	x25
    ldr	w10,	[x20]

    ldr	w14,	[sp, #2824]

    add	w3,	w28,	w14
    add	w14,	w3,	w10
    str	w14,	[sp, #2304]

    ldr	w15,	[sp, #3576]

    ldr	x24,	[sp, fp]

    lsl	w22,	w15,	#2
    movz	fp,	#2444
    add	x12,	x24,	x22
    ldr	w3,	[x12]

    ldr	w17,	[sp, #3576]

    ldr	x18,	[sp, fp]

    lsl	w14,	w17,	#2
    movz	fp,	#4900
    add	x13,	x18,	x14
    ldr	w17,	[x13]

    ldr	w9,	[sp, #2764]

    add	w15,	w3,	w9
    add	w3,	w15,	w17
    str	w3,	[sp, #2068]

    ldr	w18,	[sp, #3576]

    ldr	x7,	[sp, fp]

    lsl	w22,	w18,	#2
    movz	fp,	#2460
    add	x15,	x7,	x22
    ldr	w3,	[x15]

    ldr	w12,	[sp, #2740]

    ldr	w11,	[sp, #2776]

    add	w26,	w12,	w11
    add	w22,	w26,	w3
    str	w22,	[sp, #1844]

    ldr	w20,	[sp, #3576]

    ldr	x12,	[sp, #4520]

    lsl	w17,	w20,	#2
    add	x10,	x12,	x17
    ldr	w3,	[x10]

    ldr	w18,	[sp, #2744]

    ldr	w9,	[sp, #3576]

    add	w20,	w3,	w18
    ldr	x1,	[sp, fp]

    lsl	w17,	w9,	#2
    movz	fp,	#2420
    add	x13,	x1,	x17
    ldr	w3,	[x13]

    add	w7,	w20,	w3
    fcvtzs	w3,	s23
    str	w7,	[sp, #4884]

    ldr	w23,	[sp, #3576]

    ldr	x4,	[sp, fp]

    lsl	w15,	w23,	#2
    movz	fp,	#2964
    add	x14,	x4,	x15
    ldr	w22,	[x14]

    ldr	w17,	[sp, #2708]

    ldr	w9,	[sp, #2720]

    ldr	w20,	[sp, #2796]

    add	w18,	w17,	w9
    add	w17,	w18,	w20
    add	w9,	w17,	w22
    str	w9,	[sp, #8740]

    ldr	w13,	[sp, #2228]

    ldr	x14,	[sp, fp]

    movz	fp,	#2860
    str	w13,	[x14]

    ldr	w13,	[sp, #2360]

    ldr	x9,	[sp, fp]

    movz	fp,	#2876
    str	w13,	[x9]

    ldr	w27,	[sp, #2240]

    ldr	x23,	[sp, fp]

    movz	fp,	#2892
    str	w27,	[x23]

    ldr	w18,	[sp, #2236]

    ldr	x11,	[sp, fp]

    movz	fp,	#2884
    str	w18,	[x11]

    ldr	w28,	[sp, #2304]

    ldr	x14,	[sp, fp]

    movz	fp,	#2916
    str	w28,	[x14]

    ldr	w12,	[sp, #2068]

    ldr	x20,	[sp, fp]

    movz	fp,	#2924
    str	w12,	[x20]

    ldr	w17,	[sp, #1844]

    ldr	x27,	[sp, fp]

    movz	fp,	#2940
    str	w17,	[x27]

    ldr	x15,	[sp, fp]

    movz	fp,	#2948
    ldr	w8,	[sp, #4884]

    str	w8,	[x15]

    movz	w15,	#0
    ldr	x20,	[sp, fp]

    mov	w26,	w15
    movz	fp,	#2956
    ldr	w10,	[sp, #8740]

    str	w10,	[x20]

    ldr	x17,	[sp, fp]

    str	w26,	[x17]

    ldr	w26,	[sp, #2796]

    ldr	w13,	[sp, #2796]

    scvtf	s22,	w26
    cmp	w13,	#0
    beq	main_716

main_889:
    movz	w0,	#10
    movz	fp,	#2692
    ldr	x1,	[sp, fp]

    bl	putfarray
    movz	w0,	#10
    movz	fp,	#2964
    ldr	x1,	[sp, fp]

    bl	putarray
    movz	fp,	#2964
    ldr	w27,	[sp, #2228]

    scvtf	s10,	w27
    str	s10,	[sp, #1080]

    ldr	s15,	[sp, #1080]

    ldr	s9,	[sp, #1492]

    ldr	x26,	[sp, fp]

    fsub	s14,	s15,	s9
    movz	fp,	#2860
    fcvtzs	w28,	s14
    str	w28,	[x26]

    ldr	w27,	[sp, #2360]

    scvtf	s14,	w27
    ldr	s10,	[sp, #1512]

    ldr	x27,	[sp, fp]

    fsub	s15,	s14,	s10
    movz	fp,	#2876
    fcvtzs	w19,	s15
    str	w19,	[x27]

    ldr	w24,	[sp, #2240]

    ldr	s8,	[sp, #1496]

    scvtf	s15,	w24
    ldr	x19,	[sp, fp]

    fsub	s15,	s15,	s8
    movz	fp,	#2892
    fcvtzs	w18,	s15
    str	w18,	[x19]

    ldr	w20,	[sp, #2236]

    ldr	s11,	[sp, #1500]

    scvtf	s8,	w20
    ldr	x18,	[sp, fp]

    fsub	s14,	s8,	s11
    movz	fp,	#2884
    fcvtzs	w19,	s14
    str	w19,	[x18]

    ldr	w27,	[sp, #2304]

    scvtf	s10,	w27
    ldr	s14,	[sp, #1504]

    ldr	x19,	[sp, fp]

    fsub	s15,	s10,	s14
    movz	fp,	#2916
    fcvtzs	w28,	s15
    str	w28,	[x19]

    ldr	w27,	[sp, #2068]

    scvtf	s15,	w27
    ldr	s11,	[sp, #1508]

    fsub	s10,	s15,	s11
    ldr	x28,	[sp, fp]

    fcvtzs	w18,	s10
    movz	fp,	#2924
    str	w18,	[x28]

    ldr	w24,	[sp, #1844]

    ldr	s9,	[sp, #1064]

    scvtf	s11,	w24
    ldr	x18,	[sp, fp]

    fsub	s15,	s11,	s9
    movz	fp,	#2940
    fcvtzs	w19,	s15
    str	w19,	[x18]

    ldr	w18,	[sp, #4884]

    scvtf	s10,	w18
    ldr	s8,	[sp, #1112]

    ldr	x26,	[sp, fp]

    fsub	s10,	s10,	s8
    movz	fp,	#2948
    fcvtzs	w21,	s10
    str	w21,	[x26]

    movz	w26,	#0
    ldr	w18,	[sp, #8740]

    ldr	s9,	[sp, #1164]

    scvtf	s11,	w18
    ldr	x23,	[sp, fp]

    fsub	s15,	s11,	s9
    movz	fp,	#2956
    fcvtzs	w19,	s15
    str	w19,	[x23]

    ldr	x27,	[sp, fp]

    str	w26,	[x27]

    ldr	w27,	[sp, #3576]

    lsl	w27,	w27,	#2
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#864
    ldr	w28,	[x26]

    ldr	s10,	[sp, #1164]

    scvtf	s11,	w28
    ldr	s0,	[sp, #1276]

    fmul	s15,	s11,	s10
    fcvtzs	w27,	s15
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s13
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s12
    bl	putfloat
    movz	w0,	#10
    bl	putch
    mov	w0,	w27
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#8848
    add	sp, sp, fp
    ret


main_716:
    movz	fp,	#2964
    fmov	s23,	s22
    mov	w13,	w3
    ldr	x18,	[sp, fp]

    movz	fp,	#3948
    mov	x7,	x18
    str	x7,	[sp, fp]

    movz	fp,	#2692
    ldr	x9,	[sp, fp]

    movz	fp,	#4748
    mov	x25,	x9
    str	x25,	[sp, fp]

    movz	fp,	#2644
    str	w13,	[sp, #2796]

    ldr	w20,	[sp, #2908]

    ldr	w12,	[sp, #6316]

    ldr	w13,	[sp, #6316]

    mov	w20,	w12
    str	w13,	[sp, #2908]

    ldr	w3,	[sp, #2912]

    ldr	w15,	[sp, #6320]

    ldr	w16,	[sp, #6320]

    mov	w3,	w15
    str	w16,	[sp, #2912]

    ldr	x27,	[sp, fp]

    movz	fp,	#2644
    ldr	x3,	[sp, #6264]

    ldr	x4,	[sp, #6264]

    mov	x27,	x3
    str	x4,	[sp, fp]

    movz	fp,	#2612
    ldr	x20,	[sp, fp]

    movz	fp,	#2612
    ldr	x26,	[sp, #6248]

    ldr	x27,	[sp, #6248]

    mov	x20,	x26
    str	x27,	[sp, fp]

    movz	fp,	#2628
    ldr	w2,	[sp, #2844]

    ldr	w6,	[sp, #6308]

    ldr	w7,	[sp, #6308]

    mov	w2,	w6
    str	w7,	[sp, #2844]

    ldr	w15,	[sp, #2848]

    ldr	w9,	[sp, #6312]

    ldr	w10,	[sp, #6312]

    mov	w15,	w9
    str	w10,	[sp, #2848]

    ldr	x3,	[sp, fp]

    movz	fp,	#2628
    ldr	x0,	[sp, #6256]

    ldr	x1,	[sp, #6256]

    mov	x3,	x0
    str	x1,	[sp, fp]

    movz	fp,	#2596
    ldr	x23,	[sp, fp]

    movz	fp,	#2596
    ldr	x23,	[sp, #6240]

    ldr	x24,	[sp, #6240]

    str	x24,	[sp, fp]

    movz	fp,	#4972
    ldr	x3,	[sp, #2536]

    ldr	x9,	[sp, #6208]

    ldr	x10,	[sp, #6208]

    mov	x3,	x9
    str	x10,	[sp, #2536]

    ldr	w18,	[sp, #1024]

    ldr	w0,	[sp, #6300]

    ldr	w1,	[sp, #6300]

    mov	w18,	w0
    str	w1,	[sp, #1024]

    ldr	x27,	[sp, #2552]

    ldr	x12,	[sp, #6216]

    ldr	x13,	[sp, #6216]

    mov	x27,	x12
    str	x13,	[sp, #2552]

    ldr	x14,	[sp, #2560]

    ldr	x15,	[sp, #6224]

    ldr	x16,	[sp, #6224]

    mov	x14,	x15
    str	x16,	[sp, #2560]

    ldr	x13,	[sp, #2584]

    ldr	x18,	[sp, #6232]

    ldr	x21,	[sp, #6232]

    mov	x13,	x18
    str	x21,	[sp, #2584]

    ldr	w22,	[sp, #1036]

    ldr	w3,	[sp, #6304]

    ldr	w4,	[sp, #6304]

    mov	w22,	w3
    str	w4,	[sp, #1036]

    ldr	x10,	[sp, #2496]

    ldr	x3,	[sp, #6192]

    ldr	x4,	[sp, #6192]

    mov	x10,	x3
    str	x4,	[sp, #2496]

    ldr	x2,	[sp, #2512]

    ldr	x6,	[sp, #6200]

    ldr	x7,	[sp, #6200]

    mov	x2,	x6
    str	x7,	[sp, #2512]

    ldr	x23,	[sp, #2312]

    ldr	x0,	[sp, #6184]

    ldr	x1,	[sp, #6184]

    mov	x23,	x0
    str	x1,	[sp, #2312]

    ldr	x2,	[sp, fp]

    movz	fp,	#6364
    ldr	x2,	[sp, fp]

    movz	fp,	#6364
    ldr	x25,	[sp, fp]

    movz	fp,	#4972
    str	x25,	[sp, fp]

    movz	fp,	#2428
    ldr	x10,	[sp, fp]

    movz	fp,	#6324
    ldr	x10,	[sp, fp]

    movz	fp,	#6324
    ldr	x10,	[sp, fp]

    movz	fp,	#2428
    str	x10,	[sp, fp]

    movz	fp,	#4980
    ldr	x7,	[sp, fp]

    movz	fp,	#6372
    ldr	x7,	[sp, fp]

    movz	fp,	#6372
    ldr	x28,	[sp, fp]

    movz	fp,	#4980
    str	x28,	[sp, fp]

    movz	fp,	#4964
    ldr	w18,	[sp, #2824]

    ldr	w26,	[sp, #6296]

    ldr	w27,	[sp, #6296]

    mov	w18,	w26
    str	w27,	[sp, #2824]

    ldr	x26,	[sp, fp]

    movz	fp,	#6356
    ldr	x26,	[sp, fp]

    movz	fp,	#6356
    ldr	x22,	[sp, fp]

    movz	fp,	#4964
    str	x22,	[sp, fp]

    movz	fp,	#2452
    ldr	x26,	[sp, fp]

    movz	fp,	#6340
    ldr	x26,	[sp, fp]

    movz	fp,	#6340
    ldr	x16,	[sp, fp]

    movz	fp,	#2452
    str	x16,	[sp, fp]

    movz	fp,	#4924
    ldr	x25,	[sp, fp]

    movz	fp,	#7028
    ldr	x25,	[sp, fp]

    movz	fp,	#7028
    ldr	x4,	[sp, fp]

    movz	fp,	#4924
    str	x4,	[sp, fp]

    movz	fp,	#2444
    ldr	x21,	[sp, fp]

    movz	fp,	#6332
    ldr	x21,	[sp, fp]

    movz	fp,	#6332
    ldr	x13,	[sp, fp]

    movz	fp,	#2444
    str	x13,	[sp, fp]

    movz	fp,	#4900
    ldr	w15,	[sp, #2764]

    ldr	w18,	[sp, #6288]

    ldr	w21,	[sp, #6288]

    mov	w15,	w18
    str	w21,	[sp, #2764]

    ldr	w3,	[sp, #2776]

    ldr	w23,	[sp, #6292]

    ldr	w24,	[sp, #6292]

    mov	w3,	w23
    str	w24,	[sp, #2776]

    ldr	x8,	[sp, fp]

    movz	fp,	#7012
    ldr	x8,	[sp, fp]

    movz	fp,	#7012
    ldr	x27,	[sp, fp]

    movz	fp,	#4900
    str	x27,	[sp, fp]

    movz	fp,	#4908
    ldr	w17,	[sp, #2740]

    ldr	w12,	[sp, #6280]

    ldr	w13,	[sp, #6280]

    mov	w17,	w12
    str	w13,	[sp, #2740]

    ldr	x13,	[sp, fp]

    movz	fp,	#7020
    ldr	x13,	[sp, fp]

    movz	fp,	#7020
    ldr	x1,	[sp, fp]

    movz	fp,	#4908
    str	x1,	[sp, fp]

    movz	fp,	#6996
    ldr	w27,	[sp, #2744]

    ldr	w15,	[sp, #6284]

    ldr	w16,	[sp, #6284]

    mov	w27,	w15
    str	w16,	[sp, #2744]

    ldr	x13,	[sp, #4520]

    ldr	x13,	[sp, fp]

    movz	fp,	#6996
    ldr	x21,	[sp, fp]

    movz	fp,	#2460
    str	x21,	[sp, #4520]

    ldr	x2,	[sp, fp]

    movz	fp,	#6348
    ldr	x2,	[sp, fp]

    movz	fp,	#6348
    ldr	x19,	[sp, fp]

    movz	fp,	#2460
    str	x19,	[sp, fp]

    movz	fp,	#7004
    ldr	x28,	[sp, #4544]

    ldr	x28,	[sp, fp]

    movz	fp,	#7004
    ldr	x24,	[sp, fp]

    movz	fp,	#2420
    str	x24,	[sp, #4544]

    ldr	w13,	[sp, #2720]

    ldr	w9,	[sp, #6276]

    ldr	w10,	[sp, #6276]

    mov	w13,	w9
    str	w10,	[sp, #2720]

    ldr	x5,	[sp, fp]

    movz	fp,	#7036
    ldr	x5,	[sp, fp]

    movz	fp,	#7036
    ldr	x7,	[sp, fp]

    movz	fp,	#2420
    str	x7,	[sp, fp]

    movz	fp,	#2244
    ldr	x23,	[sp, fp]

    movz	fp,	#2244
    ldr	x18,	[sp, #6160]

    ldr	x21,	[sp, #6160]

    mov	x23,	x18
    str	x21,	[sp, fp]

    ldr	w23,	[sp, #2708]

    ldr	w6,	[sp, #6272]

    ldr	w7,	[sp, #6272]

    mov	w23,	w6
    str	w7,	[sp, #2708]

    ldr	x2,	[sp, #2256]

    ldr	x23,	[sp, #6168]

    ldr	x24,	[sp, #6168]

    mov	x2,	x23
    str	x24,	[sp, #2256]

    ldr	x15,	[sp, #2288]

    ldr	x26,	[sp, #6176]

    ldr	x27,	[sp, #6176]

    mov	x15,	x26
    str	x27,	[sp, #2288]

    b	main_717

main_517:
    movz	fp,	#2900
    ldr	x23,	[sp, fp]

    movz	fp,	#5484
    mov	x7,	x23
    str	x7,	[sp, fp]

    movz	fp,	#2868
    ldr	x7,	[sp, fp]

    movz	fp,	#2900
    mov	x26,	x7
    str	x26,	[sp, fp]

    movz	fp,	#2852
    ldr	x1,	[sp, fp]

    movz	fp,	#2868
    mov	x8,	x1
    str	x8,	[sp, fp]

    movz	fp,	#2852
    ldr	x11,	[sp, #1016]

    mov	x2,	x11
    str	x2,	[sp, fp]

    movz	fp,	#1028
    ldr	x26,	[sp, fp]

    movz	fp,	#1028
    mov	x12,	x26
    str	x12,	[sp, #1016]

    ldr	x2,	[sp, #1040]

    mov	x27,	x2
    str	x27,	[sp, fp]

    movz	fp,	#2732
    ldr	x7,	[sp, #1048]

    mov	x3,	x7
    str	x3,	[sp, #1040]

    ldr	x12,	[sp, #1056]

    mov	x8,	x12
    str	x8,	[sp, #1048]

    ldr	x6,	[sp, #2800]

    mov	x13,	x6
    str	x13,	[sp, #1056]

    ldr	x1,	[sp, fp]

    movz	fp,	#2732
    mov	x7,	x1
    str	x7,	[sp, #2800]

    ldr	x15,	[sp, #2712]

    mov	x2,	x15
    str	x2,	[sp, fp]

    movz	fp,	#2724
    ldr	x1,	[sp, fp]

    movz	fp,	#2700
    mov	x16,	x1
    str	x16,	[sp, #2712]

    ldr	x5,	[sp, fp]

    movz	fp,	#2724
    mov	x0,	x5
    str	x0,	[sp, fp]

    movz	fp,	#2684
    ldr	x0,	[sp, fp]

    movz	fp,	#2700
    mov	x6,	x0
    str	x6,	[sp, fp]

    movz	fp,	#2660
    ldr	x9,	[sp, fp]

    movz	fp,	#2684
    mov	x1,	x9
    str	x1,	[sp, fp]

    movz	fp,	#2668
    ldr	x14,	[sp, fp]

    movz	fp,	#2660
    mov	x10,	x14
    str	x10,	[sp, fp]

    movz	fp,	#2676
    ldr	x22,	[sp, fp]

    movz	fp,	#2668
    mov	x15,	x22
    str	x15,	[sp, fp]

    movz	fp,	#2652
    ldr	x4,	[sp, fp]

    movz	fp,	#2676
    mov	x25,	x4
    str	x25,	[sp, fp]

    movz	fp,	#2604
    ldr	x3,	[sp, fp]

    movz	fp,	#2652
    mov	x5,	x3
    str	x5,	[sp, fp]

    movz	fp,	#2620
    ldr	x13,	[sp, fp]

    movz	fp,	#2604
    mov	x4,	x13
    str	x4,	[sp, fp]

    movz	fp,	#2636
    ldr	x28,	[sp, fp]

    movz	fp,	#2620
    mov	x14,	x28
    str	x14,	[sp, fp]

    movz	fp,	#2636
    ldr	x27,	[sp, #2576]

    mov	x0,	x27
    str	x0,	[sp, fp]

    movz	fp,	#2524
    ldr	x9,	[sp, #2568]

    mov	x28,	x9
    str	x28,	[sp, #2576]

    ldr	x28,	[sp, #2544]

    mov	x10,	x28
    str	x10,	[sp, #2568]

    ldr	x0,	[sp, #2504]

    str	x0,	[sp, #2544]

    ldr	x8,	[sp, fp]

    movz	fp,	#2412
    mov	x1,	x8
    str	x1,	[sp, #2504]

    ldr	x6,	[sp, fp]

    movz	fp,	#2524
    mov	x9,	x6
    str	x9,	[sp, fp]

    movz	fp,	#2412
    ldr	x3,	[sp, #2320]

    mov	x7,	x3
    str	x7,	[sp, fp]

    movz	fp,	#2372
    ldr	x16,	[sp, fp]

    movz	fp,	#2388
    mov	x4,	x16
    str	x4,	[sp, #2320]

    ldr	x0,	[sp, fp]

    movz	fp,	#2372
    mov	x17,	x0
    str	x17,	[sp, fp]

    movz	fp,	#2388
    ldr	x27,	[sp, #2280]

    mov	x1,	x27
    str	x1,	[sp, fp]

    movz	fp,	#1836
    ldr	x1,	[sp, fp]

    movz	fp,	#1836
    mov	x28,	x1
    str	x28,	[sp, #2280]

    ldr	x1,	[sp, #1816]

    mov	x0,	x1
    str	x0,	[sp, fp]

    movz	fp,	#2220
    ldr	x14,	[sp, #2264]

    mov	x2,	x14
    str	x2,	[sp, #1816]

    ldr	x17,	[sp, #2344]

    mov	x15,	x17
    str	x15,	[sp, #2264]

    ldr	x3,	[sp, fp]

    movz	fp,	#2220
    mov	x18,	x3
    str	x18,	[sp, #2344]

    ldr	x1,	[sp, #2296]

    mov	x4,	x1
    str	x4,	[sp, fp]

    movz	fp,	#2364
    ldr	x12,	[sp, fp]

    movz	fp,	#2364
    mov	x2,	x12
    str	x2,	[sp, #2296]

    ldr	x3,	[sp, #2352]

    mov	x13,	x3
    str	x13,	[sp, fp]

    movz	fp,	#2932
    ldr	x22,	[sp, fp]

    mov	x4,	x22
    str	x4,	[sp, #2352]

    b	main_518

main_308:
    ldr	w10,	[sp, #5472]

    mov	w22,	w10
    str	w22,	[sp, #2532]

    ldr	w23,	[sp, #5444]

    str	w20,	[sp, #5444]

    mov	w23,	w20
    ldr	w9,	[sp, #5468]

    str	w20,	[sp, #5468]

    mov	w9,	w20
    ldr	w12,	[sp, #5472]

    str	w20,	[sp, #5472]

    mov	w12,	w20
    ldr	w5,	[sp, #5448]

    str	w21,	[sp, #5448]

    mov	w5,	w21
    ldr	w4,	[sp, #5452]

    str	w20,	[sp, #5452]

    mov	w4,	w20
    ldr	s7,	[sp, #1724]

    str	s12,	[sp, #1724]

    fmov	s7,	s12
    ldr	w26,	[sp, #2492]

    ldr	w5,	[sp, #6156]

    ldr	w8,	[sp, #6156]

    mov	w26,	w5
    str	w8,	[sp, #2492]

    ldr	s7,	[sp, #1744]

    str	s11,	[sp, #1744]

    fmov	s7,	s11
    ldr	w8,	[sp, #7756]

    str	w20,	[sp, #7756]

    mov	w8,	w20
    ldr	s7,	[sp, #1460]

    str	s15,	[sp, #1460]

    fmov	s7,	s15
    ldr	w19,	[sp, #2336]

    ldr	w1,	[sp, #6152]

    ldr	w4,	[sp, #6152]

    mov	w19,	w1
    str	w4,	[sp, #2336]

    ldr	s29,	[sp, #1452]

    str	s10,	[sp, #1452]

    fmov	s29,	s10
    ldr	s18,	[sp, #1812]

    str	s10,	[sp, #1812]

    fmov	s18,	s10
    ldr	s19,	[sp, #1468]

    str	s15,	[sp, #1468]

    fmov	s19,	s15
    ldr	w14,	[sp, #5456]

    str	w21,	[sp, #5456]

    mov	w14,	w21
    ldr	s18,	[sp, #1456]

    str	s9,	[sp, #1456]

    fmov	s18,	s9
    ldr	w4,	[sp, #5480]

    str	w20,	[sp, #5480]

    mov	w4,	w20
    ldr	w24,	[sp, #5500]

    str	w21,	[sp, #5500]

    mov	w24,	w21
    ldr	s19,	[sp, #1732]

    str	s14,	[sp, #1732]

    fmov	s19,	s14
    ldr	s29,	[sp, #1116]

    str	s15,	[sp, #1116]

    fmov	s29,	s15
    ldr	s29,	[sp, #1736]

    str	s11,	[sp, #1736]

    fmov	s29,	s11
    ldr	s18,	[sp, #1740]

    str	s14,	[sp, #1740]

    fmov	s18,	s14
    ldr	w23,	[sp, #5460]

    str	w20,	[sp, #5460]

    mov	w23,	w20
    ldr	s7,	[sp, #1100]

    str	s9,	[sp, #1100]

    fmov	s7,	s9
    ldr	w23,	[sp, #2340]

    ldr	w15,	[sp, #6144]

    ldr	w18,	[sp, #6144]

    mov	w23,	w15
    str	w18,	[sp, #2340]

    ldr	s27,	[sp, #1728]

    str	s9,	[sp, #1728]

    fmov	s27,	s9
    ldr	s7,	[sp, #1720]

    str	s15,	[sp, #1720]

    fmov	s7,	s15
    ldr	s27,	[sp, #1108]

    str	s14,	[sp, #1108]

    fmov	s27,	s14
    ldr	w16,	[sp, #1828]

    ldr	w22,	[sp, #6148]

    ldr	w24,	[sp, #6148]

    mov	w16,	w22
    str	w24,	[sp, #1828]

    ldr	w13,	[sp, #7760]

    str	w21,	[sp, #7760]

    mov	w13,	w21
    ldr	s18,	[sp, #1716]

    str	s10,	[sp, #1716]

    fmov	s18,	s10
    ldr	s29,	[sp, #1120]

    str	s9,	[sp, #1120]

    fmov	s29,	s9
    ldr	w22,	[sp, #5476]

    str	w21,	[sp, #5476]

    mov	w22,	w21
    ldr	s29,	[sp, #1088]

    str	s11,	[sp, #1088]

    fmov	s29,	s11
    ldr	w10,	[sp, #5492]

    str	w21,	[sp, #5492]

    mov	w10,	w21
    ldr	s27,	[sp, #1128]

    str	s10,	[sp, #1128]

    fmov	s27,	s10
    ldr	s19,	[sp, #1092]

    str	s9,	[sp, #1092]

    fmov	s19,	s9
    ldr	w4,	[sp, #6128]

    str	w21,	[sp, #6128]

    mov	w4,	w21
    ldr	w2,	[sp, #6992]

    str	w21,	[sp, #6992]

    mov	w2,	w21
    ldr	s19,	[sp, #1124]

    str	s15,	[sp, #1124]

    fmov	s19,	s15
    ldr	s18,	[sp, #1144]

    str	s14,	[sp, #1144]

    fmov	s18,	s14
    ldr	w26,	[sp, #6988]

    str	w20,	[sp, #6988]

    mov	w26,	w20
    ldr	s7,	[sp, #1072]

    str	s11,	[sp, #1072]

    fmov	s7,	s11
    ldr	s19,	[sp, #1136]

    str	s9,	[sp, #1136]

    fmov	s19,	s9
    b	main_309

main_305:
    ldr	s19,	[sp, #1076]

    fmov	s22,	s6
    ldr	s18,	[sp, #1772]

    fadd	s8,	s19,	s18
    fmov	s19,	s20
    fadd	s18,	s8,	s20
    fmov	s20,	s25
    str	s18,	[sp, #1776]

    fmov	s25,	s27
    ldr	s13,	[sp, #1772]

    fmov	s27,	s1
    fmov	s28,	s13
    fmov	s1,	s2
    str	s28,	[sp, #1076]

    fmov	s2,	s5
    str	s19,	[sp, #1772]

    fmov	s5,	s29
    ldr	s19,	[sp, #1396]

    fmov	s29,	s4
    str	s22,	[sp, #1396]

    fmov	s4,	s23
    ldr	s26,	[sp, #1404]

    fmov	s23,	s24
    ldr	s21,	[sp, #1408]

    fmov	s6,	s26
    fmov	s24,	s19
    str	s21,	[sp, #1404]

    ldr	s19,	[sp, #1420]

    str	s19,	[sp, #1408]

    ldr	s22,	[sp, #1416]

    str	s22,	[sp, #1420]

    ldr	s8,	[sp, #1424]

    str	s8,	[sp, #1416]

    ldr	s21,	[sp, #1428]

    str	s21,	[sp, #1424]

    ldr	s19,	[sp, #1440]

    str	s19,	[sp, #1428]

    ldr	s3,	[sp, #1432]

    str	s3,	[sp, #1440]

    ldr	s26,	[sp, #1444]

    str	s26,	[sp, #1432]

    ldr	s18,	[sp, #1448]

    str	s18,	[sp, #1444]

    ldr	s13,	[sp, #1524]

    str	s13,	[sp, #1448]

    ldr	s21,	[sp, #1520]

    str	s21,	[sp, #1524]

    ldr	s7,	[sp, #1760]

    str	s7,	[sp, #1520]

    ldr	s28,	[sp, #1540]

    fmov	s8,	s28
    str	s8,	[sp, #1760]

    ldr	s3,	[sp, #1544]

    str	s3,	[sp, #1540]

    ldr	s18,	[sp, #1764]

    str	s18,	[sp, #1544]

    ldr	s28,	[sp, #1768]

    fmov	s19,	s28
    str	s19,	[sp, #1764]

    ldr	s26,	[sp, #1084]

    fmov	s30,	s26
    str	s30,	[sp, #1768]

    ldr	s17,	[sp, #1096]

    fmov	s30,	s17
    str	s30,	[sp, #1084]

    ldr	s3,	[sp, #1104]

    fmov	s18,	s3
    str	s18,	[sp, #1096]

    ldr	s7,	[sp, #1132]

    str	s7,	[sp, #1104]

    ldr	s13,	[sp, #1140]

    fmov	s7,	s13
    str	s7,	[sp, #1132]

    ldr	s21,	[sp, #1148]

    fmov	s19,	s21
    str	s19,	[sp, #1140]

    ldr	s21,	[sp, #1156]

    fmov	s19,	s21
    str	s19,	[sp, #1148]

    ldr	s19,	[sp, #1160]

    fmov	s22,	s19
    str	s22,	[sp, #1156]

    ldr	s19,	[sp, #1176]

    fmov	s21,	s19
    str	s21,	[sp, #1160]

    ldr	s19,	[sp, #1776]

    fmov	s17,	s19
    str	s17,	[sp, #1176]

    b	main_148

