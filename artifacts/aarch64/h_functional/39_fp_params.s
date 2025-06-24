.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#10128
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w1,	#0
    str	w0,	[sp, #3424]

    mov	w26,	w1

main_10:
    cmp	w26,	#40
    bge	main_18

main_13:
    lsl	w0,	w26,	#2
    add	w28,	w0,	w26,	lsl #3
    mov	x0,	x28
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getfarray
    add	w3,	w26,	#1
    mov	w26,	w3
    b	main_10

main_18:
    movz	w2,	#0
    mov	w27,	w2

main_19:
    cmp	w27,	#24
    bge	main_27

main_22:
    lsl	w0,	w27,	#2
    add	w26,	w0,	w27,	lsl #3
    mov	x0,	x26
    add	x0,	sp,	x0
    add	x0,	x0,	#496
    bl	getarray
    add	w4,	w27,	#1
    mov	w27,	w4
    b	main_19

main_27:
    add	x7,	sp,	#16
    movz	fp,	#3332
    add	x3,	sp,	#28
    add	x20,	sp,	#52
    str	x7,	[sp, fp]

    movz	fp,	#3332
    ldr	w9,	[sp, #3424]

    lsl	w7,	w9,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3324
    add	x6,	x0,	x7
    add	x7,	sp,	#76
    ldr	s26,	[x6]

    str	s26,	[sp, #1292]

    str	x3,	[sp, fp]

    movz	fp,	#3324
    ldr	w10,	[sp, #3424]

    lsl	w11,	w10,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#3316
    add	x10,	x3,	x11
    add	x3,	sp,	#40
    ldr	s17,	[x10]

    str	s17,	[sp, #1228]

    str	x3,	[sp, fp]

    movz	fp,	#3316
    ldr	w11,	[sp, #3424]

    lsl	w15,	w11,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#3308
    add	x14,	x18,	x15
    add	x15,	sp,	#64
    ldr	s31,	[x14]

    str	s31,	[sp, #1296]

    str	x20,	[sp, fp]

    movz	fp,	#3308
    ldr	w12,	[sp, #3424]

    lsl	w20,	w12,	#2
    ldr	x11,	[sp, fp]

    movz	fp,	#3300
    add	x18,	x11,	x20
    add	x11,	sp,	#136
    add	x20,	sp,	#112
    ldr	s5,	[x18]

    str	s5,	[sp, #1300]

    str	x15,	[sp, fp]

    movz	fp,	#3300
    ldr	w13,	[sp, #3424]

    lsl	w3,	w13,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#3284
    add	x1,	x9,	x3
    add	x3,	sp,	#88
    ldr	s10,	[x1]

    str	s10,	[sp, #1304]

    str	x7,	[sp, fp]

    movz	fp,	#3284
    add	x7,	sp,	#148
    ldr	w14,	[sp, #3424]

    ldr	x8,	[sp, fp]

    lsl	w4,	w14,	#2
    movz	fp,	#3276
    add	x2,	x8,	x4
    ldr	s26,	[x2]

    str	s26,	[sp, #1264]

    str	x3,	[sp, fp]

    add	x3,	sp,	#100
    movz	fp,	#3276
    ldr	w15,	[sp, #3424]

    ldr	x4,	[sp, fp]

    lsl	w2,	w15,	#2
    movz	fp,	#3268
    add	x15,	sp,	#124
    add	x1,	x4,	x2
    ldr	s29,	[x1]

    str	s29,	[sp, #1236]

    str	x3,	[sp, fp]

    add	x3,	sp,	#160
    movz	fp,	#3268
    ldr	w16,	[sp, #3424]

    ldr	x0,	[sp, fp]

    lsl	w9,	w16,	#2
    movz	fp,	#3260
    add	x5,	x0,	x9
    ldr	s1,	[x5]

    str	s1,	[sp, #1212]

    str	x20,	[sp, fp]

    movz	fp,	#3260
    ldr	w17,	[sp, #3424]

    lsl	w10,	w17,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3252
    add	x9,	x27,	x10
    ldr	s28,	[x9]

    str	s28,	[sp, #1208]

    str	x15,	[sp, fp]

    add	x15,	sp,	#220
    movz	fp,	#3252
    ldr	w18,	[sp, #3424]

    ldr	x16,	[sp, fp]

    lsl	w14,	w18,	#2
    movz	fp,	#3244
    add	x13,	x16,	x14
    ldr	s15,	[x13]

    str	s15,	[sp, #1308]

    str	x11,	[sp, fp]

    add	x11,	sp,	#232
    movz	fp,	#3244
    ldr	w20,	[sp, #3424]

    ldr	x12,	[sp, fp]

    lsl	w26,	w20,	#2
    movz	fp,	#3236
    add	x20,	sp,	#172
    add	x17,	x12,	x26
    ldr	s23,	[x17]

    str	s23,	[sp, #1312]

    str	x7,	[sp, fp]

    add	x7,	sp,	#184
    movz	fp,	#3236
    ldr	w27,	[sp, #3424]

    ldr	x8,	[sp, fp]

    lsl	w4,	w27,	#2
    movz	fp,	#3228
    add	x2,	x8,	x4
    ldr	s29,	[x2]

    str	s29,	[sp, #1316]

    str	x3,	[sp, fp]

    movz	fp,	#3228
    ldr	w2,	[sp, #3424]

    lsl	w3,	w2,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#3212
    add	x1,	x4,	x3
    ldr	s9,	[x1]

    str	s9,	[sp, #1224]

    str	x20,	[sp, fp]

    add	x20,	sp,	#208
    movz	fp,	#3212
    ldr	w1,	[sp, #3424]

    ldr	x27,	[sp, fp]

    lsl	w1,	w1,	#2
    movz	fp,	#3188
    add	x0,	x27,	x1
    ldr	s3,	[x0]

    str	s3,	[sp, #1320]

    str	x7,	[sp, fp]

    add	x7,	sp,	#244
    movz	fp,	#3188
    ldr	w3,	[sp, #3424]

    ldr	x8,	[sp, fp]

    lsl	w5,	w3,	#2
    movz	fp,	#3172
    add	x3,	sp,	#196
    add	x4,	x8,	x5
    ldr	s8,	[x4]

    str	s8,	[sp, #1324]

    str	x3,	[sp, fp]

    movz	fp,	#3172
    ldr	w0,	[sp, #3424]

    lsl	w12,	w0,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3164
    add	x8,	x0,	x12
    ldr	s9,	[x8]

    str	s9,	[sp, #1328]

    str	x20,	[sp, fp]

    add	x20,	sp,	#280
    movz	fp,	#3164
    ldr	w1,	[sp, #3424]

    ldr	x27,	[sp, fp]

    lsl	w13,	w1,	#2
    movz	fp,	#3156
    add	x12,	x27,	x13
    ldr	s20,	[x12]

    str	s20,	[sp, #1260]

    str	x15,	[sp, fp]

    add	x15,	sp,	#292
    movz	fp,	#3156
    ldr	w2,	[sp, #3424]

    ldr	x16,	[sp, fp]

    lsl	w21,	w2,	#2
    movz	fp,	#3148
    add	x16,	x16,	x21
    ldr	s15,	[x16]

    str	s15,	[sp, #1284]

    str	x11,	[sp, fp]

    movz	fp,	#3148
    ldr	w3,	[sp, #3424]

    lsl	w2,	w3,	#2
    ldr	x12,	[sp, fp]

    add	x3,	sp,	#256
    movz	fp,	#3140
    add	x27,	x12,	x2
    ldr	s20,	[x27]

    str	s20,	[sp, #1332]

    str	x7,	[sp, fp]

    movz	fp,	#3140
    ldr	w4,	[sp, #3424]

    lsl	w2,	w4,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3132
    add	x0,	x8,	x2
    ldr	s27,	[x0]

    str	s27,	[sp, #1336]

    str	x3,	[sp, fp]

    add	x3,	sp,	#268
    movz	fp,	#3132
    ldr	w5,	[sp, #3424]

    ldr	x4,	[sp, fp]

    lsl	w0,	w5,	#2
    movz	fp,	#3124
    add	x4,	x4,	x0
    ldr	s2,	[x4]

    str	s2,	[sp, #1240]

    str	x3,	[sp, fp]

    movz	fp,	#3124
    ldr	w6,	[sp, #3424]

    lsl	w7,	w6,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3116
    add	x3,	x0,	x7
    ldr	s10,	[x3]

    add	x3,	sp,	#328
    str	s10,	[sp, #1256]

    str	x20,	[sp, fp]

    movz	fp,	#3116
    ldr	w7,	[sp, #3424]

    lsl	w8,	w7,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3108
    add	x7,	x27,	x8
    ldr	s1,	[x7]

    add	x7,	sp,	#316
    str	s1,	[sp, #1340]

    str	x15,	[sp, fp]

    movz	fp,	#3108
    ldr	w8,	[sp, #3424]

    lsl	w12,	w8,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#3100
    add	x11,	x16,	x12
    ldr	s6,	[x11]

    add	x11,	sp,	#304
    str	s6,	[sp, #1344]

    str	x11,	[sp, fp]

    movz	fp,	#3100
    ldr	w9,	[sp, #3424]

    lsl	w20,	w9,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#3092
    add	x15,	x12,	x20
    ldr	s7,	[x15]

    str	s7,	[sp, #1348]

    str	x7,	[sp, fp]

    movz	fp,	#3092
    ldr	w10,	[sp, #3424]

    lsl	w4,	w10,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3084
    add	x20,	x8,	x4
    ldr	s16,	[x20]

    add	x20,	sp,	#352
    str	s16,	[sp, #1352]

    str	x3,	[sp, fp]

    movz	fp,	#3084
    ldr	w11,	[sp, #3424]

    lsl	w1,	w11,	#2
    ldr	x4,	[sp, fp]

    add	x11,	sp,	#364
    movz	fp,	#3076
    add	x3,	x4,	x1
    ldr	s7,	[x3]

    add	x3,	sp,	#340
    str	s7,	[sp, #1276]

    str	x3,	[sp, fp]

    movz	fp,	#3076
    ldr	w12,	[sp, #3424]

    lsl	w8,	w12,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3068
    add	x3,	x0,	x8
    ldr	s24,	[x3]

    str	s24,	[sp, #1356]

    str	x20,	[sp, fp]

    movz	fp,	#3068
    ldr	w13,	[sp, #3424]

    lsl	w3,	w13,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3052
    add	x2,	x27,	x3
    add	x3,	sp,	#376
    ldr	s30,	[x2]

    str	s30,	[sp, #1360]

    str	x11,	[sp, fp]

    add	x11,	sp,	#412
    movz	fp,	#3052
    ldr	w14,	[sp, #3424]

    ldr	x12,	[sp, fp]

    lsl	w7,	w14,	#2
    movz	fp,	#3036
    add	x6,	x12,	x7
    add	x7,	sp,	#424
    ldr	s3,	[x6]

    str	s3,	[sp, #1272]

    str	x3,	[sp, fp]

    add	x3,	sp,	#388
    movz	fp,	#3036
    ldr	w15,	[sp, #3424]

    ldr	x4,	[sp, fp]

    lsl	w14,	w15,	#2
    movz	fp,	#3028
    add	x15,	sp,	#400
    add	x10,	x4,	x14
    ldr	s9,	[x10]

    str	s9,	[sp, #1220]

    str	x3,	[sp, fp]

    movz	fp,	#3028
    ldr	w16,	[sp, #3424]

    lsl	w18,	w16,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3012
    add	x14,	x0,	x18
    ldr	s4,	[x14]

    str	s4,	[sp, #1364]

    str	x15,	[sp, fp]

    add	x15,	sp,	#472
    movz	fp,	#3012
    ldr	w17,	[sp, #3424]

    ldr	x16,	[sp, fp]

    lsl	w3,	w17,	#2
    movz	fp,	#3004
    add	x18,	x16,	x3
    add	x3,	sp,	#436
    ldr	s9,	[x18]

    str	s9,	[sp, #1372]

    str	x11,	[sp, fp]

    add	x11,	sp,	#484
    movz	fp,	#3004
    ldr	w18,	[sp, #3424]

    ldr	x12,	[sp, fp]

    lsl	w0,	w18,	#2
    movz	fp,	#2996
    add	x1,	x12,	x0
    ldr	s6,	[x1]

    str	s6,	[sp, #1248]

    str	x7,	[sp, fp]

    movz	fp,	#2996
    ldr	w20,	[sp, #3424]

    lsl	w4,	w20,	#2
    ldr	x8,	[sp, fp]

    add	x20,	sp,	#460
    movz	fp,	#2988
    add	x2,	x8,	x4
    ldr	s30,	[x2]

    str	s30,	[sp, #1268]

    str	x3,	[sp, fp]

    add	x3,	sp,	#448
    movz	fp,	#2988
    ldr	w26,	[sp, #3424]

    ldr	x4,	[sp, fp]

    lsl	w2,	w26,	#2
    movz	fp,	#2980
    add	x1,	x4,	x2
    ldr	s10,	[x1]

    str	s10,	[sp, #1376]

    str	x3,	[sp, fp]

    movz	fp,	#2980
    ldr	w27,	[sp, #3424]

    lsl	w9,	w27,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#2972
    add	x5,	x0,	x9
    ldr	s7,	[x5]

    str	s7,	[sp, #1280]

    str	x20,	[sp, fp]

    movz	fp,	#2972
    ldr	w2,	[sp, #3424]

    lsl	w10,	w2,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#2964
    add	x9,	x27,	x10
    ldr	s5,	[x9]

    str	s5,	[sp, #1216]

    str	x15,	[sp, fp]

    movz	fp,	#2964
    ldr	w0,	[sp, #3424]

    lsl	w14,	w0,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#2956
    add	x13,	x16,	x14
    ldr	s24,	[x13]

    str	s24,	[sp, #1232]

    str	x11,	[sp, fp]

    movz	fp,	#2956
    ldr	w0,	[sp, #3424]

    lsl	w26,	w0,	#2
    ldr	x12,	[sp, fp]

    add	x17,	x12,	x26
    ldr	s10,	[x17]

    str	s10,	[sp, #1252]

    ldr	s15,	[sp, #1292]

    str	s15,	[sp, #1156]

    ldr	s8,	[sp, #1228]

    str	s8,	[sp, #1080]

    ldr	s23,	[sp, #1296]

    ldr	s15,	[sp, #1300]

    fmov	s8,	s23
    ldr	s10,	[sp, #1304]

    fmov	s31,	s15
    ldr	s6,	[sp, #1264]

    fmov	s26,	s10
    ldr	s19,	[sp, #1236]

    fmov	s3,	s6
    ldr	s15,	[sp, #1212]

    fmov	s1,	s19
    ldr	s24,	[sp, #1208]

    fmov	s4,	s15
    ldr	s18,	[sp, #1308]

    fmov	s23,	s24
    str	s18,	[sp, #1436]

    ldr	s24,	[sp, #1312]

    str	s24,	[sp, #1556]

    ldr	s7,	[sp, #1316]

    ldr	s21,	[sp, #1224]

    fmov	s24,	s7
    str	s21,	[sp, #1392]

    ldr	s5,	[sp, #1320]

    ldr	s27,	[sp, #1324]

    fmov	s18,	s5
    str	s27,	[sp, #1396]

    ldr	s6,	[sp, #1328]

    str	s6,	[sp, #1404]

    ldr	s25,	[sp, #1260]

    str	s25,	[sp, #1572]

    ldr	s17,	[sp, #1284]

    str	s17,	[sp, #1568]

    ldr	s2,	[sp, #1332]

    str	s2,	[sp, #1576]

    ldr	s10,	[sp, #1336]

    str	s10,	[sp, #1580]

    ldr	s28,	[sp, #1240]

    str	s28,	[sp, #1588]

    ldr	s20,	[sp, #1256]

    str	s20,	[sp, #1584]

    ldr	s19,	[sp, #1340]

    fmov	s6,	s19
    str	s6,	[sp, #1592]

    ldr	s7,	[sp, #1344]

    fmov	s17,	s7
    str	s17,	[sp, #1600]

    ldr	s2,	[sp, #1348]

    fmov	s25,	s2
    str	s25,	[sp, #1604]

    ldr	s19,	[sp, #1352]

    fmov	s2,	s19
    str	s2,	[sp, #1608]

    ldr	s5,	[sp, #1276]

    fmov	s15,	s5
    str	s15,	[sp, #1424]

    ldr	s19,	[sp, #1356]

    str	s19,	[sp, #1628]

    ldr	s16,	[sp, #1360]

    fmov	s27,	s16
    str	s27,	[sp, #1632]

    ldr	s6,	[sp, #1272]

    fmov	s21,	s6
    str	s21,	[sp, #1428]

    ldr	s29,	[sp, #1220]

    str	s29,	[sp, #1828]

    ldr	s15,	[sp, #1364]

    fmov	s27,	s15
    str	s27,	[sp, #1084]

    ldr	s7,	[sp, #1372]

    fmov	s19,	s7
    str	s19,	[sp, #1124]

    ldr	s7,	[sp, #1248]

    fmov	s15,	s7
    str	s15,	[sp, #1116]

    ldr	s16,	[sp, #1268]

    fmov	s19,	s16
    str	s19,	[sp, #1120]

    ldr	s2,	[sp, #1376]

    fmov	s15,	s2
    str	s15,	[sp, #1112]

    ldr	s20,	[sp, #1280]

    str	s20,	[sp, #1164]

    ldr	s9,	[sp, #1216]

    str	s9,	[sp, #1172]

    ldr	s19,	[sp, #1232]

    str	s19,	[sp, #1176]

    ldr	s9,	[sp, #1252]

    str	s9,	[sp, #1192]


main_148:
    movi	v15.4s,	#0
    ldr	s17,	[sp, #1192]

    fcmp	s17,	s15
    beq	main_305

main_190:
    ldr	s15,	[sp, #1080]

    add	x1,	sp,	#784
    add	x21,	sp,	#788
    add	x27,	sp,	#792
    add	x0,	sp,	#796
    add	x22,	sp,	#808
    ldr	s9,	[sp, #1156]

    fadd	s9,	s9,	s15
    str	s9,	[sp, #1792]

    ldr	s10,	[sp, #1792]

    fadd	s15,	s10,	s8
    fadd	s10,	s26,	s3
    str	s15,	[sp, #1796]

    ldr	s8,	[sp, #1796]

    fadd	s9,	s8,	s31
    str	s9,	[sp, #1200]

    str	s10,	[sp, #1800]

    ldr	s15,	[sp, #1800]

    fadd	s9,	s15,	s1
    str	s9,	[sp, #1444]

    ldr	s10,	[sp, #1444]

    fadd	s15,	s10,	s4
    str	s15,	[sp, #1188]

    ldr	s10,	[sp, #1436]

    fadd	s8,	s23,	s10
    str	s8,	[sp, #1448]

    ldr	s9,	[sp, #1448]

    ldr	s15,	[sp, #1556]

    fadd	s15,	s9,	s15
    str	s15,	[sp, #1452]

    ldr	s8,	[sp, #1452]

    fadd	s8,	s8,	s24
    str	s8,	[sp, #1680]

    ldr	s8,	[sp, #1392]

    fadd	s9,	s8,	s18
    str	s9,	[sp, #1780]

    ldr	s8,	[sp, #1396]

    ldr	s10,	[sp, #1780]

    fadd	s8,	s10,	s8
    str	s8,	[sp, #1784]

    ldr	s8,	[sp, #1404]

    ldr	s9,	[sp, #1784]

    fadd	s9,	s9,	s8
    str	s9,	[sp, #1676]

    ldr	s8,	[sp, #1568]

    ldr	s10,	[sp, #1572]

    fadd	s8,	s10,	s8
    str	s8,	[sp, #1744]

    ldr	s10,	[sp, #1576]

    ldr	s9,	[sp, #1744]

    fadd	s15,	s9,	s10
    str	s15,	[sp, #1748]

    ldr	s9,	[sp, #1580]

    ldr	s8,	[sp, #1748]

    fadd	s10,	s8,	s9
    str	s10,	[sp, #1672]

    ldr	s15,	[sp, #1584]

    ldr	s10,	[sp, #1588]

    fadd	s8,	s10,	s15
    str	s8,	[sp, #1728]

    ldr	s8,	[sp, #1592]

    ldr	s9,	[sp, #1728]

    fadd	s15,	s9,	s8
    str	s15,	[sp, #1732]

    ldr	s9,	[sp, #1600]

    ldr	s8,	[sp, #1732]

    fadd	s15,	s8,	s9
    str	s15,	[sp, #1668]

    ldr	s10,	[sp, #1604]

    ldr	s15,	[sp, #1608]

    fadd	s9,	s10,	s15
    str	s9,	[sp, #1716]

    ldr	s15,	[sp, #1716]

    ldr	s9,	[sp, #1424]

    fadd	s8,	s15,	s9
    str	s8,	[sp, #1720]

    ldr	s10,	[sp, #1628]

    ldr	s9,	[sp, #1720]

    fadd	s9,	s9,	s10
    str	s9,	[sp, #1660]

    ldr	s8,	[sp, #1632]

    ldr	s10,	[sp, #1428]

    fadd	s9,	s8,	s10
    str	s9,	[sp, #1708]

    ldr	s9,	[sp, #1708]

    ldr	s15,	[sp, #1828]

    fadd	s10,	s9,	s15
    str	s10,	[sp, #1688]

    ldr	s10,	[sp, #1084]

    ldr	s9,	[sp, #1688]

    fadd	s10,	s9,	s10
    str	s10,	[sp, #1656]

    ldr	s10,	[sp, #1124]

    ldr	s9,	[sp, #1116]

    fadd	s9,	s10,	s9
    str	s9,	[sp, #1692]

    ldr	s9,	[sp, #1120]

    ldr	s10,	[sp, #1692]

    fadd	s8,	s10,	s9
    str	s8,	[sp, #1696]

    ldr	s10,	[sp, #1112]

    ldr	s9,	[sp, #1696]

    fadd	s8,	s9,	s10
    str	s8,	[sp, #1664]

    ldr	s10,	[sp, #1164]

    ldr	s8,	[sp, #1172]

    fadd	s15,	s10,	s8
    str	s15,	[sp, #1700]

    ldr	s10,	[sp, #1176]

    ldr	s9,	[sp, #1700]

    fadd	s10,	s9,	s10
    str	s10,	[sp, #1704]

    ldr	s9,	[sp, #1192]

    ldr	s10,	[sp, #1704]

    fadd	s15,	s10,	s9
    str	s15,	[sp, #1684]

    ldr	s10,	[sp, #1200]

    str	s10,	[x1]

    ldr	s9,	[sp, #1188]

    str	s9,	[x21]

    add	x21,	sp,	#804
    ldr	s9,	[sp, #1680]

    str	s9,	[x27]

    add	x27,	sp,	#816
    ldr	s10,	[sp, #1676]

    str	s10,	[x0]

    ldr	s15,	[sp, #1672]

    add	x0,	sp,	#800
    str	s15,	[x0]

    add	x0,	sp,	#820
    ldr	s8,	[sp, #1668]

    str	s8,	[x21]

    add	x21,	sp,	#812
    ldr	s10,	[sp, #1660]

    str	s10,	[x22]

    ldr	s15,	[sp, #1656]

    str	s15,	[x21]

    ldr	s9,	[sp, #1664]

    str	s9,	[x27]

    ldr	s8,	[sp, #1684]

    str	s8,	[x0]

    movz	w0,	#10
    bl	putfarray
    movz	fp,	#3364
    add	x17,	sp,	#652
    add	x10,	sp,	#520
    ldr	w1,	[sp, #3424]

    add	x15,	sp,	#568
    lsl	w4,	w1,	#2
    add	x1,	sp,	#544
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#784
    ldr	s21,	[x3]

    add	x3,	sp,	#772
    str	s21,	[sp, #1288]

    str	x3,	[sp, fp]

    movz	fp,	#3364
    ldr	w2,	[sp, #3424]

    lsl	w8,	w2,	#2
    ldr	x20,	[sp, fp]

    add	x2,	sp,	#556
    movz	fp,	#3348
    add	x7,	x20,	x8
    add	x20,	sp,	#508
    ldr	w6,	[x7]

    str	w6,	[sp, #2460]

    ldr	w0,	[sp, #3424]

    lsl	w3,	w0,	#2
    add	x0,	sp,	#700
    add	x11,	x10,	x3
    ldr	w3,	[x11]

    str	w3,	[sp, #3420]

    str	x15,	[sp, fp]

    movz	fp,	#3348
    ldr	w4,	[sp, #3424]

    lsl	w16,	w4,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3356
    add	x15,	x8,	x16
    ldr	w11,	[x15]

    str	w11,	[sp, #2396]

    str	x20,	[sp, fp]

    movz	fp,	#3356
    ldr	w5,	[sp, #3424]

    lsl	w27,	w5,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#3340
    add	x20,	x12,	x27
    ldr	w3,	[x20]

    str	w3,	[sp, #3392]

    ldr	w5,	[sp, #3424]

    lsl	w4,	w5,	#2
    add	x3,	x1,	x4
    ldr	w11,	[x3]

    str	w11,	[sp, #3404]

    add	x11,	sp,	#760
    ldr	w7,	[sp, #3424]

    lsl	w9,	w7,	#2
    add	x3,	x2,	x9
    ldr	w3,	[x3]

    str	w3,	[sp, #3396]

    str	x11,	[sp, fp]

    add	x11,	sp,	#724
    movz	fp,	#3340
    ldr	w8,	[sp, #3424]

    ldr	x7,	[sp, fp]

    lsl	w3,	w8,	#2
    movz	fp,	#3220
    add	x2,	x7,	x3
    add	x3,	sp,	#496
    ldr	w7,	[x2]

    str	w7,	[sp, #6192]

    str	x3,	[sp, fp]

    movz	fp,	#3220
    ldr	w9,	[sp, #3424]

    lsl	w7,	w9,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#3292
    add	x6,	x16,	x7
    ldr	w3,	[x6]

    str	w3,	[sp, #3416]

    str	x11,	[sp, fp]

    movz	fp,	#3292
    ldr	w10,	[sp, #3424]

    lsl	w11,	w10,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#3196
    add	x10,	x3,	x11
    add	x11,	sp,	#580
    ldr	w20,	[x10]

    str	w20,	[sp, #2172]

    str	x11,	[sp, fp]

    movz	fp,	#3196
    ldr	w11,	[sp, #3424]

    lsl	w15,	w11,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3180
    add	x14,	x1,	x15
    ldr	w3,	[x14]

    str	w3,	[sp, #2100]

    add	x3,	sp,	#616
    str	x3,	[sp, fp]

    movz	fp,	#3180
    ldr	w12,	[sp, #3424]

    lsl	w20,	w12,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#3204
    add	x18,	x16,	x20
    add	x20,	sp,	#640
    ldr	w4,	[x18]

    str	w4,	[sp, #6188]

    str	x17,	[sp, fp]

    movz	fp,	#3204
    ldr	w13,	[sp, #3424]

    lsl	w4,	w13,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#3060
    add	x2,	x7,	x4
    add	x4,	sp,	#712
    ldr	w1,	[x2]

    str	w1,	[sp, #6184]

    ldr	w21,	[sp, #3424]

    add	x1,	sp,	#592
    lsl	w12,	w21,	#2
    add	x2,	x1,	x12
    ldr	w5,	[x2]

    str	w5,	[sp, #3384]

    ldr	w22,	[sp, #3424]

    lsl	w18,	w22,	#2
    add	x1,	x0,	x18
    ldr	w11,	[x1]

    str	w11,	[sp, #3408]

    add	x11,	sp,	#604
    ldr	w26,	[sp, #3424]

    lsl	w26,	w26,	#2
    add	x5,	x4,	x26
    ldr	w5,	[x5]

    str	w5,	[sp, #3400]

    ldr	w28,	[sp, #3424]

    lsl	w0,	w28,	#2
    add	x13,	x11,	x0
    add	x11,	sp,	#688
    ldr	w0,	[x13]

    str	w0,	[sp, #3376]

    str	x20,	[sp, fp]

    movz	fp,	#3060
    ldr	w27,	[sp, #3424]

    lsl	w18,	w27,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3020
    add	x17,	x2,	x18
    add	x2,	sp,	#628
    ldr	w17,	[x17]

    str	w17,	[sp, #5512]

    str	x2,	[sp, fp]

    movz	fp,	#3020
    ldr	w2,	[sp, #3424]

    lsl	w1,	w2,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3044
    add	x28,	x8,	x1
    ldr	w8,	[x28]

    str	w8,	[sp, #5476]

    str	x11,	[sp, fp]

    add	x11,	sp,	#532
    movz	fp,	#3044
    ldr	w1,	[sp, #3424]

    ldr	x4,	[sp, fp]

    lsl	w3,	w1,	#2
    movz	fp,	#2948
    add	x2,	x4,	x3
    add	x4,	sp,	#676
    add	x3,	sp,	#748
    ldr	w5,	[x2]

    str	w5,	[sp, #5168]

    add	x5,	sp,	#736
    str	x11,	[sp, fp]

    movz	fp,	#2948
    ldr	w7,	[sp, #3424]

    lsl	w1,	w7,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#2940
    add	x12,	x2,	x1
    ldr	w12,	[x12]

    str	w12,	[sp, #3412]

    ldr	w9,	[sp, #3424]

    lsl	w18,	w9,	#2
    add	x1,	x3,	x18
    ldr	w3,	[x1]

    str	w3,	[sp, #3388]

    ldr	w12,	[sp, #3424]

    lsl	w2,	w12,	#2
    add	x5,	x5,	x2
    add	x2,	sp,	#664
    ldr	w3,	[x5]

    str	w3,	[sp, #3380]

    str	x4,	[sp, fp]

    movz	fp,	#2940
    ldr	w14,	[sp, #3424]

    lsl	w17,	w14,	#2
    ldr	x20,	[sp, fp]

    add	x13,	x20,	x17
    ldr	w8,	[x13]

    str	w8,	[sp, #8952]

    ldr	w12,	[sp, #3424]

    lsl	w13,	w12,	#2
    add	x28,	x2,	x13
    ldr	w20,	[x28]

    str	w20,	[sp, #3372]

    ldr	w2,	[sp, #2460]

    mov	w11,	w2
    str	w11,	[sp, #2416]

    ldr	w5,	[sp, #3420]

    mov	w28,	w5
    str	w28,	[sp, #6936]

    ldr	w11,	[sp, #2396]

    str	w11,	[sp, #5480]

    ldr	s8,	[sp, #1304]

    ldr	w27,	[sp, #3392]

    fmov	s6,	s8
    mov	w18,	w27
    str	w18,	[sp, #5484]

    ldr	w1,	[sp, #3404]

    mov	w3,	w1
    str	w3,	[sp, #6940]

    ldr	w14,	[sp, #3396]

    mov	w8,	w14
    str	w8,	[sp, #6944]

    ldr	s22,	[sp, #1208]

    str	s22,	[sp, #1432]

    ldr	s7,	[sp, #1328]

    str	s7,	[sp, #1476]

    ldr	s5,	[sp, #1212]

    ldr	w20,	[sp, #6192]

    fmov	s31,	s5
    mov	w8,	w20
    str	w8,	[sp, #2376]

    ldr	s16,	[sp, #1300]

    ldr	s18,	[sp, #1360]

    fmov	s29,	s16
    str	s18,	[sp, #1496]

    ldr	w12,	[sp, #3416]

    ldr	s4,	[sp, #1216]

    mov	w3,	w12
    str	s4,	[sp, #1508]

    ldr	w2,	[sp, #2172]

    mov	w16,	w2
    str	w16,	[sp, #2324]

    ldr	s23,	[sp, #1220]

    str	s23,	[sp, #1500]

    ldr	s18,	[sp, #1224]

    fmov	s30,	s18
    str	s30,	[sp, #1804]

    ldr	s2,	[sp, #1228]

    ldr	s25,	[sp, #1316]

    fmov	s7,	s2
    str	s25,	[sp, #1464]

    ldr	s16,	[sp, #1232]

    str	s16,	[sp, #1512]

    ldr	s16,	[sp, #1236]

    ldr	w8,	[sp, #2100]

    fmov	s2,	s16
    mov	w27,	w8
    str	w27,	[sp, #6948]

    ldr	s1,	[sp, #1372]

    str	s1,	[sp, #1504]

    ldr	w16,	[sp, #6188]

    mov	w9,	w16
    str	w9,	[sp, #5492]

    ldr	w12,	[sp, #6184]

    mov	w6,	w12
    str	w6,	[sp, #5516]

    ldr	s27,	[sp, #1240]

    str	s27,	[sp, #1484]

    ldr	s4,	[sp, #1248]

    str	s4,	[sp, #1132]

    ldr	s4,	[sp, #1344]

    str	s4,	[sp, #1488]

    ldr	s23,	[sp, #1308]

    ldr	s3,	[sp, #1352]

    fmov	s5,	s23
    str	s3,	[sp, #1492]

    ldr	w12,	[sp, #3384]

    mov	w8,	w12
    str	w8,	[sp, #7824]

    ldr	s25,	[sp, #1252]

    str	s25,	[sp, #1128]

    ldr	w22,	[sp, #3408]

    mov	w14,	w22
    str	w14,	[sp, #2088]

    ldr	s25,	[sp, #1256]

    fmov	s16,	s25
    str	s16,	[sp, #1480]

    ldr	s23,	[sp, #1260]

    fmov	s27,	s23
    str	s27,	[sp, #1472]

    ldr	s1,	[sp, #1264]

    ldr	s15,	[sp, #1268]

    fmov	s21,	s1
    str	s15,	[sp, #1136]

    ldr	w12,	[sp, #3400]

    mov	w21,	w12
    str	w21,	[sp, #2176]

    ldr	w6,	[sp, #3376]

    mov	w13,	w6
    str	w13,	[sp, #7828]

    ldr	s15,	[sp, #1324]

    fmov	s10,	s15
    str	s10,	[sp, #1468]

    ldr	s19,	[sp, #1312]

    ldr	s20,	[sp, #1292]

    fmov	s24,	s19
    ldr	w8,	[sp, #5512]

    fmov	s15,	s20
    mov	w0,	w8
    str	w0,	[sp, #5488]

    ldr	s23,	[sp, #1364]

    str	s23,	[sp, #1088]

    ldr	w18,	[sp, #5476]

    mov	w1,	w18
    str	w1,	[sp, #6952]

    ldr	w12,	[sp, #5168]

    mov	w28,	w12
    str	w28,	[sp, #5508]

    ldr	s26,	[sp, #1356]

    fmov	s18,	s26
    str	s18,	[sp, #1100]

    ldr	s30,	[sp, #1348]

    fmov	s1,	s30
    ldr	s30,	[sp, #1320]

    ldr	s9,	[sp, #1272]

    fmov	s28,	s30
    str	s9,	[sp, #1104]

    ldr	w21,	[sp, #3412]

    ldr	w0,	[sp, #3388]

    mov	w15,	w21
    str	w0,	[sp, #6180]

    ldr	w12,	[sp, #3380]

    mov	w21,	w12
    str	w21,	[sp, #5520]

    ldr	s18,	[sp, #1332]

    ldr	s26,	[sp, #1336]

    ldr	s19,	[sp, #1340]

    fmov	s22,	s26
    fmov	s17,	s19
    str	s17,	[sp, #1144]

    ldr	s20,	[sp, #1276]

    fmov	s4,	s20
    str	s4,	[sp, #1560]

    ldr	s8,	[sp, #1280]

    str	s8,	[sp, #1160]

    ldr	s16,	[sp, #1284]

    ldr	w9,	[sp, #8952]

    fmov	s17,	s16
    mov	w23,	w9
    str	w23,	[sp, #5504]

    ldr	s9,	[sp, #1296]

    str	s9,	[sp, #1076]

    ldr	w21,	[sp, #3372]

    ldr	s20,	[sp, #1376]

    mov	w12,	w21
    str	s20,	[sp, #1108]


main_309:
    ldr	w6,	[sp, #2416]

    cmp	w6,	#0
    beq	main_308

main_375:
    fadd	s9,	s15,	s7
    add	x26,	sp,	#944
    movz	fp,	#1820
    add	x25,	sp,	#956
    ldr	s15,	[sp, #1076]

    fadd	s13,	s9,	s15
    fadd	s15,	s6,	s21
    fadd	s12,	s13,	s29
    fadd	s13,	s15,	s2
    str	s12,	[sp, #1204]

    fadd	s12,	s13,	s31
    str	s12,	[sp, #1196]

    ldr	s13,	[sp, #1432]

    ldr	s10,	[sp, #1464]

    fadd	s15,	s13,	s5
    fadd	s13,	s15,	s24
    fadd	s13,	s13,	s10
    str	s13,	[sp, #1184]

    ldr	s8,	[sp, #1804]

    ldr	s10,	[sp, #1468]

    fadd	s13,	s8,	s28
    ldr	s12,	[sp, #1476]

    fadd	s15,	s13,	s10
    fadd	s15,	s15,	s12
    str	s15,	[sp, #1168]

    ldr	s15,	[sp, #1472]

    fadd	s15,	s15,	s17
    fadd	s13,	s15,	s18
    fadd	s11,	s13,	s22
    str	s11,	[sp, #1528]

    ldr	s9,	[sp, #1480]

    ldr	s15,	[sp, #1484]

    ldr	s8,	[sp, #1144]

    fadd	s13,	s15,	s9
    ldr	s11,	[sp, #1488]

    fadd	s15,	s13,	s8
    fadd	s15,	s15,	s11
    str	s15,	[sp, #1524]

    ldr	s8,	[sp, #1492]

    ldr	s10,	[sp, #1560]

    fadd	s13,	s1,	s8
    ldr	s15,	[sp, #1100]

    fadd	s9,	s13,	s10
    fadd	s15,	s9,	s15
    str	s15,	[sp, #1836]

    ldr	s10,	[sp, #1104]

    ldr	s13,	[sp, #1496]

    fadd	s15,	s13,	s10
    ldr	s10,	[sp, #1500]

    ldr	s14,	[sp, #1088]

    fadd	s15,	s15,	s10
    fadd	s11,	s15,	s14
    str	s11,	[sp, #1832]

    ldr	s11,	[sp, #1132]

    ldr	s15,	[sp, #1504]

    ldr	s14,	[sp, #1136]

    fadd	s11,	s15,	s11
    ldr	s12,	[sp, #1108]

    fadd	s15,	s11,	s14
    ldr	s13,	[sp, #1160]

    fadd	s15,	s15,	s12
    ldr	s12,	[sp, #1508]

    ldr	s9,	[sp, #1512]

    fadd	s13,	s13,	s12
    ldr	s11,	[sp, #1128]

    fadd	s12,	s13,	s9
    str	x26,	[sp, fp]

    fadd	s14,	s12,	s11
    add	x26,	sp,	#968
    movz	fp,	#1820
    ldr	s10,	[sp, #1204]

    ldr	x21,	[sp, fp]

    movz	fp,	#4332
    str	s10,	[x21]

    ldr	s11,	[sp, #1196]

    add	x21,	sp,	#948
    str	s11,	[x21]

    ldr	s10,	[sp, #1184]

    add	x21,	sp,	#952
    str	s10,	[x21]

    add	x21,	sp,	#960
    ldr	s11,	[sp, #1168]

    str	s11,	[x25]

    add	x25,	sp,	#976
    ldr	s12,	[sp, #1528]

    str	s12,	[x21]

    ldr	s8,	[sp, #1524]

    add	x21,	sp,	#964
    str	s8,	[x21]

    add	x21,	sp,	#972
    ldr	s10,	[sp, #1836]

    str	s10,	[x26]

    ldr	s12,	[sp, #1832]

    str	s12,	[x21]

    add	x21,	sp,	#980
    str	s15,	[x25]

    str	s14,	[x21]

    ldr	w27,	[sp, #5484]

    ldr	w22,	[sp, #6936]

    add	w26,	w27,	w22
    add	w24,	w26,	w3
    add	x26,	sp,	#988
    str	w24,	[sp, #5048]

    add	x24,	sp,	#1000
    ldr	w28,	[sp, #6940]

    ldr	w18,	[sp, #6944]

    add	w21,	w18,	w28
    add	w25,	w21,	w15
    str	w25,	[sp, #2220]

    ldr	w1,	[sp, #5480]

    ldr	w25,	[sp, #6948]

    add	w21,	w25,	w1
    ldr	w1,	[sp, #7824]

    add	w20,	w21,	w1
    str	w20,	[sp, #2036]

    ldr	w23,	[sp, #5492]

    ldr	w27,	[sp, #7828]

    ldr	w1,	[sp, #6952]

    add	w25,	w27,	w23
    add	w28,	w25,	w1
    str	w28,	[sp, #5100]

    ldr	w27,	[sp, #5488]

    ldr	w28,	[sp, #5516]

    add	w21,	w27,	w28
    add	w25,	w21,	w12
    str	w25,	[sp, #2040]

    ldr	w27,	[sp, #2088]

    ldr	w22,	[sp, #5508]

    ldr	w19,	[sp, #5504]

    add	w1,	w22,	w27
    add	x27,	sp,	#984
    add	w1,	w1,	w19
    str	w1,	[sp, #2060]

    ldr	w18,	[sp, #2176]

    ldr	w21,	[sp, #2324]

    ldr	w22,	[sp, #5520]

    add	w28,	w18,	w21
    add	w25,	w28,	w22
    str	w25,	[sp, #2048]

    ldr	w18,	[sp, #2376]

    ldr	w21,	[sp, #2416]

    ldr	w28,	[sp, #6180]

    add	w1,	w18,	w21
    add	w1,	w1,	w28
    str	w1,	[sp, #2052]

    str	x27,	[sp, #4928]

    ldr	x28,	[sp, #4928]

    ldr	w1,	[sp, #5048]

    str	w1,	[x28]

    add	x1,	sp,	#992
    str	x26,	[sp, fp]

    movz	fp,	#4332
    ldr	w0,	[sp, #2220]

    ldr	x27,	[sp, fp]

    movz	fp,	#2228
    str	w0,	[x27]

    str	x1,	[sp, #4072]

    add	x1,	sp,	#1004
    ldr	w21,	[sp, #2036]

    ldr	x18,	[sp, #4072]

    str	w21,	[x18]

    add	x18,	sp,	#996
    str	x18,	[sp, #4912]

    ldr	x0,	[sp, #4912]

    ldr	w26,	[sp, #5100]

    str	w26,	[x0]

    add	x26,	sp,	#1008
    str	x24,	[sp, fp]

    movz	fp,	#2228
    ldr	w18,	[sp, #2040]

    ldr	x25,	[sp, fp]

    movz	fp,	#2260
    str	w18,	[x25]

    add	x25,	sp,	#1012
    str	x1,	[sp, fp]

    movz	fp,	#2260
    ldr	w0,	[sp, #2060]

    ldr	x18,	[sp, fp]

    movz	fp,	#2276
    str	w0,	[x18]

    str	x26,	[sp, fp]

    movz	fp,	#2276
    ldr	w0,	[sp, #2048]

    ldr	x27,	[sp, fp]

    movz	fp,	#1820
    str	w0,	[x27]

    str	x25,	[sp, #4944]

    ldr	w0,	[sp, #2052]

    ldr	x26,	[sp, #4944]

    str	w0,	[x26]

    ldr	x1,	[sp, fp]

    movz	w0,	#10
    bl	putfarray
    ldr	x1,	[sp, #4928]

    movz	w0,	#8
    bl	putarray
    movz	fp,	#4332
    ldr	w2,	[sp, #5048]

    ldr	s27,	[sp, #1204]

    scvtf	s5,	w2
    ldr	x23,	[sp, #4928]

    fsub	s5,	s5,	s27
    fcvtzs	w2,	s5
    str	w2,	[x23]

    ldr	w13,	[sp, #2220]

    ldr	s20,	[sp, #1196]

    scvtf	s7,	w13
    ldr	x14,	[sp, fp]

    fsub	s31,	s7,	s20
    movz	fp,	#2228
    fcvtzs	w5,	s31
    str	w5,	[x14]

    ldr	w17,	[sp, #2036]

    ldr	s4,	[sp, #1184]

    scvtf	s2,	w17
    ldr	x28,	[sp, #4072]

    fsub	s18,	s2,	s4
    fcvtzs	w1,	s18
    str	w1,	[x28]

    ldr	w24,	[sp, #5100]

    ldr	s12,	[sp, #1168]

    scvtf	s20,	w24
    ldr	x13,	[sp, #4912]

    fsub	s6,	s20,	s12
    fcvtzs	w4,	s6
    str	w4,	[x13]

    ldr	w26,	[sp, #2040]

    ldr	s21,	[sp, #1528]

    scvtf	s9,	w26
    ldr	x3,	[sp, fp]

    fsub	s9,	s9,	s21
    movz	fp,	#2260
    fcvtzs	w10,	s9
    str	w10,	[x3]

    ldr	w2,	[sp, #2060]

    ldr	s17,	[sp, #1524]

    scvtf	s12,	w2
    ldr	x23,	[sp, fp]

    fsub	s14,	s12,	s17
    movz	fp,	#2276
    fcvtzs	w10,	s14
    str	w10,	[x23]

    ldr	w7,	[sp, #2048]

    ldr	s29,	[sp, #1836]

    scvtf	s16,	w7
    ldr	x2,	[sp, fp]

    fsub	s9,	s16,	s29
    movz	fp,	#3332
    fcvtzs	w16,	s9
    str	w16,	[x2]

    ldr	w11,	[sp, #2052]

    ldr	s25,	[sp, #1832]

    scvtf	s11,	w11
    ldr	x14,	[sp, #4944]

    fsub	s11,	s11,	s25
    fcvtzs	w20,	s11
    str	w20,	[x14]

    ldr	w10,	[sp, #3424]

    lsl	w18,	w10,	#2
    mov	x17,	x18
    add	x17,	sp,	x17
    add	x17,	x17,	#984
    ldr	w20,	[x17]

    ldr	x1,	[sp, fp]

    scvtf	s12,	w20
    movz	fp,	#3324
    mov	x16,	x1
    str	x16,	[sp, #4952]

    ldr	x1,	[sp, fp]

    movz	fp,	#2820
    mov	x7,	x1
    str	x7,	[sp, fp]

    movz	fp,	#3316
    ldr	x1,	[sp, fp]

    movz	fp,	#2292
    mov	x9,	x1
    str	x9,	[sp, fp]

    movz	fp,	#3308
    ldr	x21,	[sp, fp]

    movz	fp,	#3300
    mov	x19,	x21
    str	x19,	[sp, #4960]

    ldr	x16,	[sp, fp]

    movz	fp,	#3284
    mov	x3,	x16
    str	x3,	[sp, #4984]

    ldr	x7,	[sp, fp]

    movz	fp,	#2828
    mov	x11,	x7
    str	x11,	[sp, fp]

    movz	fp,	#3276
    ldr	x2,	[sp, fp]

    movz	fp,	#2836
    mov	x16,	x2
    str	x16,	[sp, fp]

    movz	fp,	#3268
    ldr	x2,	[sp, fp]

    movz	fp,	#2844
    mov	x25,	x2
    str	x25,	[sp, fp]

    movz	fp,	#3260
    ldr	x2,	[sp, fp]

    movz	fp,	#2852
    mov	x1,	x2
    str	x1,	[sp, fp]

    movz	fp,	#3252
    ldr	x25,	[sp, fp]

    movz	fp,	#3244
    mov	x11,	x25
    str	x11,	[sp, #5000]

    ldr	x17,	[sp, fp]

    movz	fp,	#3236
    mov	x14,	x17
    str	x14,	[sp, #5008]

    ldr	x8,	[sp, fp]

    movz	fp,	#3228
    mov	x17,	x8
    str	x17,	[sp, #5016]

    ldr	x3,	[sp, fp]

    movz	fp,	#2860
    mov	x1,	x3
    str	x1,	[sp, fp]

    movz	fp,	#3212
    ldr	x1,	[sp, fp]

    movz	fp,	#3188
    mov	x20,	x1
    str	x20,	[sp, #5024]

    ldr	x10,	[sp, fp]

    movz	fp,	#3172
    mov	x23,	x10
    str	x23,	[sp, #5032]

    ldr	x1,	[sp, fp]

    movz	fp,	#3164
    mov	x26,	x1
    str	x26,	[sp, #5040]

    ldr	x3,	[sp, fp]

    movz	fp,	#2868
    str	x3,	[sp, fp]

    movz	fp,	#3156
    ldr	x28,	[sp, fp]

    movz	fp,	#2876
    mov	x1,	x28
    str	x1,	[sp, fp]

    movz	fp,	#3148
    ldr	x20,	[sp, fp]

    movz	fp,	#5052
    mov	x4,	x20
    str	x4,	[sp, fp]

    movz	fp,	#3140
    ldr	x17,	[sp, fp]

    movz	fp,	#5060
    mov	x7,	x17
    str	x7,	[sp, fp]

    movz	fp,	#3132
    ldr	x14,	[sp, fp]

    movz	fp,	#2884
    mov	x4,	x14
    str	x4,	[sp, fp]

    movz	fp,	#3124
    ldr	x6,	[sp, fp]

    movz	fp,	#2892
    mov	x27,	x6
    str	x27,	[sp, fp]

    movz	fp,	#3116
    ldr	x10,	[sp, fp]

    movz	fp,	#5068
    str	x10,	[sp, fp]

    movz	fp,	#3108
    ldr	x6,	[sp, fp]

    movz	fp,	#5076
    mov	x13,	x6
    str	x13,	[sp, fp]

    movz	fp,	#3100
    ldr	x7,	[sp, fp]

    movz	fp,	#5084
    mov	x16,	x7
    str	x16,	[sp, fp]

    movz	fp,	#3092
    ldr	x3,	[sp, fp]

    movz	fp,	#5092
    mov	x19,	x3
    str	x19,	[sp, fp]

    movz	fp,	#3084
    ldr	x28,	[sp, fp]

    movz	fp,	#2900
    mov	x9,	x28
    str	x9,	[sp, fp]

    movz	fp,	#3076
    ldr	x4,	[sp, fp]

    movz	fp,	#3068
    mov	x21,	x4
    str	x21,	[sp, #6920]

    ldr	x7,	[sp, fp]

    movz	fp,	#3052
    mov	x26,	x7
    str	x26,	[sp, #5104]

    ldr	x12,	[sp, fp]

    movz	fp,	#2908
    mov	x6,	x12
    str	x6,	[sp, fp]

    movz	fp,	#3036
    ldr	x7,	[sp, fp]

    movz	fp,	#2916
    str	x7,	[sp, fp]

    movz	fp,	#3028
    ldr	x28,	[sp, fp]

    movz	fp,	#3012
    mov	x0,	x28
    add	x28,	sp,	#908
    str	x0,	[sp, #5112]

    ldr	x15,	[sp, fp]

    movz	fp,	#3004
    mov	x3,	x15
    str	x3,	[sp, #5120]

    ldr	x6,	[sp, fp]

    movz	fp,	#2924
    mov	x16,	x6
    str	x16,	[sp, fp]

    movz	fp,	#2996
    ldr	x12,	[sp, fp]

    movz	fp,	#2932
    mov	x11,	x12
    str	x11,	[sp, fp]

    movz	fp,	#2988
    ldr	x16,	[sp, fp]

    movz	fp,	#2980
    mov	x24,	x16
    str	x24,	[sp, #6928]

    ldr	x11,	[sp, fp]

    movz	fp,	#2972
    mov	x6,	x11
    str	x6,	[sp, #5128]

    ldr	x27,	[sp, fp]

    movz	fp,	#2964
    mov	x9,	x27
    str	x9,	[sp, #5136]

    ldr	x9,	[sp, fp]

    movz	fp,	#2956
    mov	x12,	x9
    str	x12,	[sp, #5144]

    add	x12,	sp,	#904
    ldr	x1,	[sp, fp]

    movz	fp,	#2780
    mov	x15,	x1
    str	x15,	[sp, #5152]

    add	x15,	sp,	#916
    str	x12,	[sp, fp]

    movz	fp,	#2636
    add	x12,	sp,	#912
    str	x28,	[sp, #2608]

    add	x28,	sp,	#924
    str	x12,	[sp, #2624]

    add	x12,	sp,	#920
    str	x15,	[sp, fp]

    movz	fp,	#1020
    add	x15,	sp,	#928
    str	x12,	[sp, #2648]

    add	x12,	sp,	#932
    str	x28,	[sp, #2616]

    add	x28,	sp,	#936
    str	x15,	[sp, fp]

    movz	fp,	#1028
    str	x12,	[sp, fp]

    movz	fp,	#2820
    str	x28,	[sp, #1040]

    add	x28,	sp,	#940
    str	x28,	[sp, #1048]

    ldr	x17,	[sp, #4952]

    mov	x3,	x17
    str	x3,	[sp, #5496]

    ldr	x6,	[sp, fp]

    movz	fp,	#2740
    mov	x28,	x6
    str	x28,	[sp, fp]

    movz	fp,	#2292
    ldr	x10,	[sp, fp]

    movz	fp,	#2716
    mov	x11,	x10
    str	x11,	[sp, fp]

    movz	fp,	#2700
    ldr	x20,	[sp, #4960]

    mov	x14,	x20
    str	x14,	[sp, fp]

    movz	fp,	#2828
    ldr	x4,	[sp, #4984]

    mov	x11,	x4
    str	x11,	[sp, #1064]

    ldr	x28,	[sp, fp]

    movz	fp,	#2836
    mov	x11,	x28
    str	x11,	[sp, #2656]

    ldr	x11,	[sp, fp]

    movz	fp,	#2668
    str	x11,	[sp, fp]

    movz	fp,	#2844
    ldr	x11,	[sp, fp]

    movz	fp,	#2676
    mov	x14,	x11
    str	x14,	[sp, fp]

    movz	fp,	#2852
    ldr	x11,	[sp, fp]

    movz	fp,	#2684
    str	x11,	[sp, fp]

    movz	fp,	#2572
    ldr	x12,	[sp, #5000]

    mov	x14,	x12
    str	x14,	[sp, #1056]

    ldr	x15,	[sp, #5008]

    mov	x28,	x15
    str	x28,	[sp, #2592]

    ldr	x18,	[sp, #5016]

    mov	x28,	x18
    str	x28,	[sp, fp]

    movz	fp,	#2860
    ldr	x6,	[sp, fp]

    movz	fp,	#2868
    mov	x28,	x6
    str	x28,	[sp, #2584]

    ldr	x21,	[sp, #5024]

    mov	x28,	x21
    str	x28,	[sp, #2560]

    ldr	x24,	[sp, #5032]

    mov	x17,	x24
    str	x17,	[sp, #2544]

    ldr	x27,	[sp, #5040]

    mov	x11,	x27
    str	x11,	[sp, #2480]

    ldr	x11,	[sp, fp]

    movz	fp,	#2876
    mov	x20,	x11
    str	x20,	[sp, #2528]

    ldr	x11,	[sp, fp]

    movz	fp,	#5052
    mov	x28,	x11
    str	x28,	[sp, #2536]

    ldr	x5,	[sp, fp]

    movz	fp,	#5060
    mov	x2,	x5
    str	x2,	[sp, #2520]

    ldr	x8,	[sp, fp]

    movz	fp,	#2884
    mov	x17,	x8
    str	x17,	[sp, #2464]

    ldr	x18,	[sp, fp]

    movz	fp,	#2892
    mov	x21,	x18
    str	x21,	[sp, #2488]

    ldr	x17,	[sp, fp]

    movz	fp,	#5068
    mov	x4,	x17
    str	x4,	[sp, #2504]

    ldr	x11,	[sp, fp]

    movz	fp,	#2444
    mov	x13,	x11
    str	x13,	[sp, fp]

    movz	fp,	#5076
    ldr	x14,	[sp, fp]

    movz	fp,	#2428
    mov	x6,	x14
    str	x6,	[sp, fp]

    movz	fp,	#5084
    ldr	x17,	[sp, fp]

    movz	fp,	#5092
    mov	x20,	x17
    str	x20,	[sp, #2400]

    ldr	x20,	[sp, fp]

    movz	fp,	#2900
    mov	x5,	x20
    str	x5,	[sp, #2360]

    ldr	x0,	[sp, fp]

    movz	fp,	#2380
    mov	x2,	x0
    str	x2,	[sp, fp]

    movz	fp,	#2196
    ldr	x22,	[sp, #6920]

    mov	x20,	x22
    str	x20,	[sp, #2336]

    ldr	x27,	[sp, #5104]

    mov	x14,	x27
    str	x14,	[sp, fp]

    movz	fp,	#2908
    ldr	x18,	[sp, fp]

    movz	fp,	#2212
    mov	x5,	x18
    str	x5,	[sp, fp]

    movz	fp,	#2916
    ldr	x11,	[sp, fp]

    movz	fp,	#2308
    mov	x6,	x11
    str	x6,	[sp, fp]

    movz	fp,	#2180
    ldr	x1,	[sp, #5112]

    mov	x11,	x1
    str	x11,	[sp, fp]

    movz	fp,	#2092
    ldr	x4,	[sp, #5120]

    mov	x2,	x4
    str	x2,	[sp, fp]

    movz	fp,	#2924
    ldr	x10,	[sp, fp]

    movz	fp,	#2932
    mov	x15,	x10
    str	x15,	[sp, #2104]

    ldr	x15,	[sp, fp]

    movz	fp,	#2140
    mov	x25,	x15
    str	x25,	[sp, #2112]

    ldr	x25,	[sp, #6928]

    mov	x20,	x25
    str	x20,	[sp, #2080]

    ldr	x7,	[sp, #5128]

    str	x7,	[sp, fp]

    movz	fp,	#2132
    ldr	x10,	[sp, #5136]

    mov	x8,	x10
    str	x8,	[sp, fp]

    movz	fp,	#2068
    ldr	x13,	[sp, #5144]

    mov	x8,	x13
    str	x8,	[sp, fp]

    ldr	x16,	[sp, #5152]

    mov	x8,	x16
    str	x8,	[sp, #2120]


main_518:
    ldr	w11,	[sp, #3424]

    movz	fp,	#2740
    ldr	x4,	[sp, #5496]

    lsl	w15,	w11,	#2
    add	x13,	x4,	x15
    ldr	s11,	[x13]

    ldr	w12,	[sp, #3424]

    ldr	x7,	[sp, fp]

    lsl	w17,	w12,	#2
    movz	fp,	#2716
    add	x16,	x7,	x17
    ldr	s27,	[x16]

    ldr	w13,	[sp, #3424]

    fadd	s17,	s11,	s27
    ldr	x20,	[sp, fp]

    lsl	w26,	w13,	#2
    movz	fp,	#2700
    add	x22,	x20,	x26
    ldr	s31,	[x22]

    ldr	w14,	[sp, #3424]

    fadd	s21,	s17,	s31
    ldr	x12,	[sp, fp]

    lsl	w2,	w14,	#2
    movz	fp,	#2668
    add	x1,	x12,	x2
    ldr	s4,	[x1]

    ldr	w15,	[sp, #3424]

    fadd	s2,	s21,	s4
    ldr	x18,	[sp, #1064]

    lsl	w0,	w15,	#2
    add	x2,	x18,	x0
    ldr	s30,	[x2]

    ldr	w16,	[sp, #3424]

    ldr	x0,	[sp, #2656]

    lsl	w3,	w16,	#2
    add	x2,	x0,	x3
    ldr	s11,	[x2]

    ldr	w17,	[sp, #3424]

    fadd	s4,	s30,	s11
    ldr	x13,	[sp, fp]

    lsl	w7,	w17,	#2
    movz	fp,	#2676
    add	x6,	x13,	x7
    ldr	s17,	[x6]

    ldr	w18,	[sp, #3424]

    fadd	s6,	s4,	s17
    lsl	w11,	w18,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#2684
    add	x10,	x18,	x11
    ldr	s23,	[x10]

    ldr	w20,	[sp, #3424]

    fadd	s7,	s6,	s23
    ldr	x1,	[sp, fp]

    lsl	w15,	w20,	#2
    movz	fp,	#2572
    add	x14,	x1,	x15
    ldr	s16,	[x14]

    ldr	w22,	[sp, #3424]

    ldr	x10,	[sp, #1056]

    lsl	w18,	w22,	#2
    add	x17,	x10,	x18
    ldr	s1,	[x17]

    ldr	w26,	[sp, #3424]

    fadd	s21,	s16,	s1
    ldr	x2,	[sp, #2592]

    lsl	w0,	w26,	#2
    add	x26,	x2,	x0
    ldr	s6,	[x26]

    ldr	w0,	[sp, #3424]

    fadd	s25,	s21,	s6
    ldr	x10,	[sp, fp]

    lsl	w0,	w0,	#2
    movz	fp,	#2444
    add	x2,	x10,	x0
    ldr	s11,	[x2]

    ldr	w0,	[sp, #3424]

    fadd	s3,	s25,	s11
    ldr	x21,	[sp, #2584]

    lsl	w1,	w0,	#2
    add	x0,	x21,	x1
    ldr	s5,	[x0]

    ldr	w1,	[sp, #3424]

    lsl	w4,	w1,	#2
    ldr	x1,	[sp, #2560]

    add	x3,	x1,	x4
    ldr	s18,	[x3]

    ldr	w2,	[sp, #3424]

    fadd	s10,	s5,	s18
    ldr	x15,	[sp, #2544]

    lsl	w8,	w2,	#2
    add	x7,	x15,	x8
    ldr	s22,	[x7]

    ldr	w0,	[sp, #3424]

    fadd	s10,	s10,	s22
    ldr	x1,	[sp, #2480]

    lsl	w12,	w0,	#2
    add	x11,	x1,	x12
    ldr	s28,	[x11]

    ldr	w1,	[sp, #3424]

    fadd	s19,	s10,	s28
    ldr	x2,	[sp, #2528]

    lsl	w16,	w1,	#2
    add	x15,	x2,	x16
    ldr	s20,	[x15]

    ldr	w2,	[sp, #3424]

    ldr	x7,	[sp, #2536]

    lsl	w20,	w2,	#2
    add	x18,	x7,	x20
    ldr	s9,	[x18]

    ldr	w3,	[sp, #3424]

    fadd	s25,	s20,	s9
    ldr	x20,	[sp, #2520]

    lsl	w0,	w3,	#2
    add	x0,	x20,	x0
    ldr	s14,	[x0]

    ldr	w4,	[sp, #3424]

    fadd	s29,	s25,	s14
    ldr	x15,	[sp, #2464]

    lsl	w1,	w4,	#2
    add	x0,	x15,	x1
    ldr	s18,	[x0]

    ldr	w5,	[sp, #3424]

    fadd	s27,	s29,	s18
    ldr	x1,	[sp, #2488]

    lsl	w2,	w5,	#2
    add	x1,	x1,	x2
    ldr	s10,	[x1]

    ldr	w6,	[sp, #3424]

    ldr	x10,	[sp, #2504]

    lsl	w5,	w6,	#2
    add	x4,	x10,	x5
    ldr	s22,	[x4]

    ldr	w7,	[sp, #3424]

    fadd	s15,	s10,	s22
    ldr	x3,	[sp, fp]

    lsl	w9,	w7,	#2
    movz	fp,	#2428
    add	x8,	x3,	x9
    ldr	s26,	[x8]

    ldr	w8,	[sp, #3424]

    fadd	s13,	s15,	s26
    ldr	x17,	[sp, fp]

    lsl	w13,	w8,	#2
    movz	fp,	#2380
    add	x12,	x17,	x13
    ldr	s4,	[x12]

    ldr	w9,	[sp, #3424]

    fadd	s4,	s13,	s4
    ldr	x26,	[sp, #2400]

    lsl	w17,	w9,	#2
    add	x16,	x26,	x17
    ldr	s23,	[x16]

    ldr	w10,	[sp, #3424]

    ldr	x16,	[sp, #2360]

    lsl	w22,	w10,	#2
    add	x20,	x16,	x22
    ldr	s16,	[x20]

    ldr	w11,	[sp, #3424]

    fadd	s29,	s23,	s16
    ldr	x8,	[sp, fp]

    lsl	w1,	w11,	#2
    movz	fp,	#2196
    add	x0,	x8,	x1
    ldr	s21,	[x0]

    ldr	w12,	[sp, #3424]

    fadd	s5,	s29,	s21
    ldr	x6,	[sp, #2336]

    lsl	w2,	w12,	#2
    add	x1,	x6,	x2
    ldr	s17,	[x1]

    ldr	w13,	[sp, #3424]

    fadd	s13,	s5,	s17
    ldr	x2,	[sp, fp]

    lsl	w3,	w13,	#2
    movz	fp,	#2212
    add	x2,	x2,	x3
    ldr	s17,	[x2]

    ldr	w14,	[sp, #3424]

    ldr	x4,	[sp, fp]

    lsl	w6,	w14,	#2
    movz	fp,	#2308
    add	x5,	x4,	x6
    ldr	s28,	[x5]

    ldr	w15,	[sp, #3424]

    fadd	s22,	s17,	s28
    lsl	w10,	w15,	#2
    ldr	x15,	[sp, fp]

    movz	fp,	#2180
    add	x9,	x15,	x10
    ldr	s5,	[x9]

    ldr	w16,	[sp, #3424]

    fadd	s17,	s22,	s5
    ldr	x11,	[sp, fp]

    lsl	w14,	w16,	#2
    movz	fp,	#2092
    add	x13,	x11,	x14
    ldr	s11,	[x13]

    ldr	w17,	[sp, #3424]

    fadd	s10,	s17,	s11
    ldr	x7,	[sp, fp]

    lsl	w18,	w17,	#2
    movz	fp,	#2140
    add	x17,	x7,	x18
    ldr	s17,	[x17]

    ldr	w18,	[sp, #3424]

    ldr	x15,	[sp, #2104]

    lsl	w26,	w18,	#2
    add	x22,	x15,	x26
    ldr	s29,	[x22]

    ldr	w20,	[sp, #3424]

    fadd	s23,	s17,	s29
    ldr	x26,	[sp, #2112]

    lsl	w2,	w20,	#2
    add	x1,	x26,	x2
    ldr	s6,	[x1]

    ldr	w22,	[sp, #3424]

    fadd	s28,	s23,	s6
    ldr	x3,	[sp, #2080]

    lsl	w0,	w22,	#2
    add	x2,	x3,	x0
    ldr	s11,	[x2]

    ldr	w26,	[sp, #3424]

    fadd	s23,	s28,	s11
    ldr	x16,	[sp, fp]

    lsl	w4,	w26,	#2
    movz	fp,	#2132
    add	x3,	x16,	x4
    ldr	s25,	[x3]

    ldr	w0,	[sp, #3424]

    ldr	x11,	[sp, fp]

    lsl	w7,	w0,	#2
    movz	fp,	#2068
    add	x6,	x11,	x7
    ldr	s21,	[x6]

    ldr	w0,	[sp, #3424]

    fadd	s30,	s25,	s21
    ldr	x25,	[sp, fp]

    lsl	w11,	w0,	#2
    movz	fp,	#2780
    add	x10,	x25,	x11
    ldr	s25,	[x10]

    ldr	w1,	[sp, #3424]

    fadd	s9,	s30,	s25
    ldr	x9,	[sp, #2120]

    lsl	w15,	w1,	#2
    add	x13,	x9,	x15
    ldr	s21,	[x13]

    ldr	x9,	[sp, fp]

    fadd	s22,	s9,	s21
    movz	fp,	#2636
    str	s2,	[x9]

    ldr	x12,	[sp, #2608]

    str	s7,	[x12]

    ldr	x16,	[sp, #2624]

    str	s3,	[x16]

    ldr	x1,	[sp, fp]

    movz	fp,	#1020
    str	s19,	[x1]

    ldr	x6,	[sp, #2648]

    str	s27,	[x6]

    ldr	x9,	[sp, #2616]

    str	s4,	[x9]

    movi	v4.4s,	#0
    ldr	x20,	[sp, fp]

    movz	fp,	#1028
    str	s13,	[x20]

    ldr	x0,	[sp, fp]

    str	s10,	[x0]

    ldr	x4,	[sp, #1040]

    str	s23,	[x4]

    ldr	x7,	[sp, #1048]

    str	s22,	[x7]

    ldr	s27,	[x13]

    fcmp	s27,	s4
    cset	w20,	ne
    mov	w22,	w20
    cmp	w22,	#0
    movi	v4.4s,	#0
    cset	w26,	ne
    mov	w0,	w26
    scvtf	s31,	w0
    fcmp	s31,	s4
    movi	v3.4s,	#0
    cset	w1,	ne
    mov	w2,	w1
    scvtf	s4,	w2
    fcmp	s4,	s3
    beq	main_517

main_679:
    movz	w0,	#10
    movz	fp,	#2780
    ldr	x1,	[sp, fp]

    bl	putfarray
    ldr	w2,	[sp, #3424]

    add	x22,	sp,	#836
    movz	fp,	#3220
    add	x16,	sp,	#856
    add	x26,	sp,	#828
    lsl	w0,	w2,	#2
    mov	x2,	x0
    add	x2,	sp,	x2
    add	x2,	x2,	#904
    ldr	s15,	[x2]

    ldr	x3,	[sp, fp]

    movz	fp,	#2948
    mov	x1,	x3
    ldr	x13,	[sp, fp]

    movz	fp,	#3348
    mov	x7,	x13
    ldr	x11,	[sp, fp]

    movz	fp,	#4220
    mov	x2,	x11
    str	x2,	[sp, fp]

    movz	fp,	#3196
    ldr	x27,	[sp, fp]

    movz	fp,	#3180
    mov	x15,	x27
    ldr	x14,	[sp, fp]

    movz	fp,	#4548
    mov	x13,	x14
    add	x14,	sp,	#860
    str	x13,	[sp, fp]

    movz	fp,	#3020
    ldr	x4,	[sp, fp]

    movz	fp,	#3836
    mov	x25,	x4
    str	x25,	[sp, fp]

    add	x25,	sp,	#824
    movz	fp,	#3060
    ldr	x4,	[sp, fp]

    movz	fp,	#4540
    mov	x10,	x4
    add	x4,	sp,	#892
    str	x10,	[sp, fp]

    movz	fp,	#3204
    ldr	x2,	[sp, fp]

    movz	fp,	#4532
    mov	x6,	x2
    str	x6,	[sp, fp]

    movz	fp,	#2940
    ldr	x17,	[sp, fp]

    movz	fp,	#3828
    mov	x21,	x17
    str	x21,	[sp, fp]

    mov	x21,	x1
    movz	fp,	#3044
    ldr	x9,	[sp, fp]

    movz	fp,	#4228
    mov	x3,	x9
    add	x9,	sp,	#840
    str	x3,	[sp, fp]

    movz	fp,	#3292
    ldr	x3,	[sp, fp]

    movz	fp,	#4556
    mov	x18,	x3
    add	x3,	sp,	#848
    str	x18,	[sp, fp]

    movz	fp,	#3340
    ldr	x6,	[sp, fp]

    movz	fp,	#3764
    mov	x5,	x6
    str	x5,	[sp, fp]

    add	x5,	sp,	#868
    movz	fp,	#3364
    ldr	x0,	[sp, fp]

    movz	fp,	#3356
    mov	x2,	x0
    add	x0,	sp,	#832
    str	x2,	[sp, #3848]

    ldr	x27,	[sp, fp]

    movz	fp,	#3756
    mov	x2,	x27
    str	x2,	[sp, fp]

    movz	fp,	#5172
    str	x25,	[sp, #2552]

    add	x25,	sp,	#864
    str	x26,	[sp, fp]

    movz	fp,	#5180
    str	x0,	[sp, fp]

    add	x0,	sp,	#844
    movz	fp,	#2164
    str	x22,	[sp, #5160]

    str	x9,	[sp, fp]

    add	x9,	sp,	#888
    movz	fp,	#2204
    str	x0,	[sp, fp]

    add	x0,	sp,	#852
    movz	fp,	#2300
    str	x3,	[sp, fp]

    add	x3,	sp,	#884
    movz	fp,	#2316
    str	x0,	[sp, fp]

    add	x0,	sp,	#872
    movz	fp,	#2812
    str	x16,	[sp, #2328]

    str	x14,	[sp, #2344]

    add	x14,	sp,	#876
    str	x25,	[sp, fp]

    movz	fp,	#2708
    str	x5,	[sp, fp]

    add	x5,	sp,	#900
    movz	fp,	#2724
    str	x0,	[sp, fp]

    add	x0,	sp,	#896
    movz	fp,	#2732
    str	x14,	[sp, fp]

    movz	fp,	#2756
    add	x14,	sp,	#880
    str	x14,	[sp, fp]

    movz	fp,	#2764
    str	x3,	[sp, fp]

    movz	fp,	#2772
    str	x9,	[sp, fp]

    movz	fp,	#2788
    str	x4,	[sp, fp]

    movz	fp,	#2796
    str	x0,	[sp, fp]

    movz	fp,	#2804
    str	x5,	[sp, fp]

    movz	fp,	#4348
    ldr	s7,	[sp, #1292]

    fmov	s11,	s7
    str	x21,	[sp, fp]

    movz	fp,	#2820
    ldr	w27,	[sp, #3392]

    mov	w13,	w27
    str	w13,	[sp, #2748]

    ldr	x13,	[sp, fp]

    movz	fp,	#3772
    mov	x8,	x13
    str	x8,	[sp, fp]

    movz	fp,	#2828
    ldr	s5,	[sp, #1296]

    ldr	w13,	[sp, #3420]

    fmov	s24,	s5
    mov	w8,	w13
    str	w8,	[sp, #2752]

    ldr	s8,	[sp, #1300]

    ldr	s7,	[sp, #1304]

    fmov	s28,	s8
    ldr	x2,	[sp, fp]

    fmov	s13,	s7
    movz	fp,	#2836
    mov	x4,	x2
    mov	x2,	x7
    str	x4,	[sp, #2512]

    str	x2,	[sp, #2472]

    ldr	w1,	[sp, #3404]

    mov	w28,	w1
    str	w28,	[sp, #2692]

    ldr	w6,	[sp, #3396]

    mov	w7,	w6
    str	w7,	[sp, #2696]

    ldr	x1,	[sp, fp]

    movz	fp,	#4220
    mov	x0,	x1
    str	x0,	[sp, #2496]

    ldr	x0,	[sp, fp]

    movz	fp,	#2452
    mov	x6,	x0
    str	x6,	[sp, fp]

    movz	fp,	#2388
    str	x15,	[sp, fp]

    movz	fp,	#2844
    ldr	w1,	[sp, #3384]

    mov	w6,	w1
    str	w6,	[sp, #1072]

    ldr	x7,	[sp, fp]

    movz	fp,	#2852
    mov	x6,	x7
    str	x6,	[sp, #2408]

    ldr	x7,	[sp, fp]

    movz	fp,	#2420
    mov	x10,	x7
    str	x10,	[sp, fp]

    movz	fp,	#2860
    ldr	s3,	[sp, #1308]

    ldr	s4,	[sp, #1312]

    fmov	s16,	s3
    ldr	s21,	[sp, #1316]

    fmov	s31,	s4
    ldr	x3,	[sp, fp]

    fmov	s9,	s21
    movz	fp,	#2436
    mov	x5,	x3
    str	x5,	[sp, fp]

    movz	fp,	#4548
    ldr	w5,	[sp, #3376]

    mov	w18,	w5
    str	w18,	[sp, #2664]

    ldr	s23,	[sp, #1320]

    ldr	s25,	[sp, #1324]

    fmov	s1,	s23
    ldr	s7,	[sp, #1328]

    fmov	s30,	s25
    ldr	x12,	[sp, fp]

    fmov	s22,	s7
    movz	fp,	#2868
    mov	x7,	x12
    str	x7,	[sp, #2352]

    ldr	x7,	[sp, fp]

    movz	fp,	#3836
    str	x7,	[sp, #2368]

    ldr	x21,	[sp, fp]

    movz	fp,	#2188
    mov	x10,	x21
    str	x10,	[sp, fp]

    movz	fp,	#4540
    ldr	x9,	[sp, fp]

    movz	fp,	#2876
    mov	x22,	x9
    str	x22,	[sp, #4968]

    ldr	x18,	[sp, fp]

    movz	fp,	#2236
    mov	x5,	x18
    str	x5,	[sp, fp]

    movz	fp,	#4532
    ldr	s7,	[sp, #1332]

    ldr	s8,	[sp, #1336]

    fmov	s25,	s7
    ldr	x6,	[sp, fp]

    fmov	s14,	s8
    movz	fp,	#2884
    str	x6,	[sp, #4992]

    ldr	w26,	[sp, #3372]

    mov	w13,	w26
    str	w13,	[sp, #1036]

    ldr	x26,	[sp, fp]

    movz	fp,	#2244
    mov	x10,	x26
    str	x10,	[sp, fp]

    movz	fp,	#2892
    ldr	x7,	[sp, fp]

    movz	fp,	#2268
    mov	x24,	x7
    str	x24,	[sp, fp]

    movz	fp,	#3828
    ldr	s5,	[sp, #1340]

    ldr	s17,	[sp, #1344]

    fmov	s19,	s5
    ldr	x18,	[sp, fp]

    fmov	s23,	s17
    movz	fp,	#4228
    mov	x25,	x18
    str	x25,	[sp, #4936]

    ldr	x3,	[sp, fp]

    movz	fp,	#4556
    mov	x27,	x3
    str	x27,	[sp, #4976]

    ldr	w15,	[sp, #3408]

    mov	w7,	w15
    str	w7,	[sp, #2632]

    ldr	w4,	[sp, #3400]

    mov	w2,	w4
    str	w2,	[sp, #2644]

    ldr	s18,	[sp, #1348]

    ldr	s6,	[sp, #1352]

    fmov	s8,	s18
    ldr	x15,	[sp, fp]

    fmov	s18,	s6
    movz	fp,	#2284
    mov	x4,	x15
    str	x4,	[sp, fp]

    movz	fp,	#2900
    ldr	w6,	[sp, #3380]

    mov	w8,	w6
    str	w8,	[sp, #2600]

    ldr	x8,	[sp, fp]

    movz	fp,	#3764
    mov	x6,	x8
    str	x6,	[sp, #4904]

    ldr	w7,	[sp, #3388]

    mov	w2,	w7
    str	w2,	[sp, #2604]

    ldr	x5,	[sp, fp]

    movz	fp,	#2908
    mov	x1,	x5
    str	x1,	[sp, #4896]

    ldr	x28,	[sp, #3848]

    mov	x15,	x28
    str	x15,	[sp, #4920]

    ldr	s17,	[sp, #1356]

    fmov	s20,	s17
    ldr	s17,	[sp, #1360]

    ldr	x4,	[sp, fp]

    fmov	s4,	s17
    movz	fp,	#4356
    mov	x22,	x4
    str	x22,	[sp, fp]

    movz	fp,	#3756
    ldr	w16,	[sp, #3416]

    mov	w20,	w16
    str	w20,	[sp, #2580]

    ldr	x2,	[sp, fp]

    movz	fp,	#2252
    mov	x15,	x2
    str	x15,	[sp, fp]

    movz	fp,	#2916
    ldr	x8,	[sp, fp]

    movz	fp,	#1812
    mov	x12,	x8
    str	x12,	[sp, fp]

    movz	fp,	#2924
    ldr	s10,	[sp, #1364]

    ldr	w6,	[sp, #3420]

    fmov	s5,	s10
    mov	w16,	w6
    str	w16,	[sp, #2568]

    ldr	s7,	[sp, #1372]

    ldr	x16,	[sp, fp]

    movz	fp,	#2148
    mov	x14,	x16
    str	x14,	[sp, fp]

    movz	fp,	#2932
    ldr	x2,	[sp, fp]

    movz	fp,	#2156
    mov	x7,	x2
    str	x7,	[sp, fp]

    ldr	s29,	[sp, #1376]

    ldr	w4,	[sp, #3412]

    mov	w16,	w4
    str	w16,	[sp, #1016]


main_717:
    ldr	w4,	[sp, #3424]

    movz	fp,	#3772
    lsl	w5,	w4,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#2420
    add	x7,	x8,	x5
    ldr	s6,	[x7]

    fadd	s10,	s11,	s6
    fadd	s21,	s10,	s24
    fadd	s27,	s21,	s28
    str	s27,	[sp, #1540]

    ldr	w5,	[sp, #3424]

    lsl	w6,	w5,	#2
    ldr	x5,	[sp, #2512]

    add	x16,	x5,	x6
    ldr	s17,	[x16]

    ldr	w14,	[sp, #3424]

    fadd	s21,	s13,	s17
    ldr	x15,	[sp, #2496]

    lsl	w18,	w14,	#2
    add	x7,	x15,	x18
    ldr	s10,	[x7]

    ldr	w15,	[sp, #3424]

    fadd	s6,	s21,	s10
    ldr	x5,	[sp, #2408]

    lsl	w6,	w15,	#2
    add	x5,	x5,	x6
    ldr	s2,	[x5]

    fadd	s27,	s6,	s2
    str	s27,	[sp, #1532]

    ldr	w16,	[sp, #3424]

    ldr	x26,	[sp, fp]

    lsl	w6,	w16,	#2
    movz	fp,	#2436
    add	x16,	x26,	x6
    ldr	s21,	[x16]

    fadd	s6,	s21,	s16
    fadd	s10,	s6,	s31
    fadd	s10,	s10,	s9
    str	s10,	[sp, #1544]

    ldr	w7,	[sp, #3424]

    ldr	x16,	[sp, fp]

    lsl	w21,	w7,	#2
    movz	fp,	#2236
    add	x7,	x16,	x21
    ldr	s6,	[x7]

    fadd	s10,	s6,	s1
    fadd	s21,	s10,	s30
    fadd	s27,	s21,	s22
    str	s27,	[sp, #1548]

    ldr	w12,	[sp, #3424]

    ldr	x10,	[sp, #2368]

    lsl	w6,	w12,	#2
    add	x16,	x10,	x6
    ldr	s17,	[x16]

    ldr	w15,	[sp, #3424]

    ldr	x6,	[sp, fp]

    lsl	w7,	w15,	#2
    movz	fp,	#2244
    add	x21,	x6,	x7
    ldr	s6,	[x21]

    fadd	s21,	s17,	s6
    fadd	s17,	s8,	s18
    fadd	s6,	s21,	s25
    fadd	s10,	s6,	s14
    str	s10,	[sp, #1552]

    ldr	w2,	[sp, #3424]

    ldr	x13,	[sp, fp]

    lsl	w7,	w2,	#2
    movz	fp,	#2268
    add	x5,	x13,	x7
    ldr	s21,	[x5]

    ldr	w6,	[sp, #3424]

    ldr	x26,	[sp, fp]

    lsl	w21,	w6,	#2
    movz	fp,	#4356
    add	x16,	x26,	x21
    ldr	s3,	[x16]

    fadd	s6,	s21,	s3
    fadd	s10,	s6,	s19
    fadd	s10,	s10,	s23
    str	s10,	[sp, #1536]

    ldr	w7,	[sp, #3424]

    ldr	x9,	[sp, #4904]

    lsl	w5,	w7,	#2
    add	x21,	x9,	x5
    ldr	s3,	[x21]

    fadd	s21,	s17,	s3
    fadd	s6,	s21,	s20
    str	s6,	[sp, #1096]

    ldr	w8,	[sp, #3424]

    ldr	x25,	[sp, fp]

    lsl	w5,	w8,	#2
    movz	fp,	#1812
    add	x16,	x25,	x5
    ldr	s17,	[x16]

    ldr	w10,	[sp, #3424]

    fadd	s6,	s4,	s17
    ldr	x5,	[sp, fp]

    lsl	w18,	w10,	#2
    movz	fp,	#2148
    add	x7,	x5,	x18
    ldr	s21,	[x7]

    fadd	s6,	s6,	s21
    fadd	s21,	s6,	s5
    str	s21,	[sp, #1140]

    ldr	w16,	[sp, #3424]

    ldr	x18,	[sp, fp]

    lsl	w7,	w16,	#2
    movz	fp,	#2156
    add	x5,	x18,	x7
    ldr	s6,	[x5]

    ldr	w21,	[sp, #3424]

    fadd	s6,	s7,	s6
    ldr	x8,	[sp, fp]

    lsl	w10,	w21,	#2
    movz	fp,	#5172
    add	x21,	x8,	x10
    ldr	s26,	[x21]

    fadd	s17,	s6,	s26
    fadd	s21,	s17,	s29
    str	s21,	[sp, #1180]

    ldr	s2,	[sp, #1540]

    ldr	x10,	[sp, #2552]

    str	s2,	[x10]

    ldr	s2,	[sp, #1532]

    ldr	x22,	[sp, fp]

    movz	fp,	#5180
    str	s2,	[x22]

    ldr	s17,	[sp, #1544]

    ldr	x25,	[sp, fp]

    movz	fp,	#2164
    str	s17,	[x25]

    ldr	s2,	[sp, #1548]

    ldr	x19,	[sp, #5160]

    str	s2,	[x19]

    ldr	s17,	[sp, #1552]

    ldr	x15,	[sp, fp]

    movz	fp,	#2204
    str	s17,	[x15]

    ldr	s17,	[sp, #1536]

    ldr	x2,	[sp, fp]

    movz	fp,	#2300
    str	s17,	[x2]

    ldr	s10,	[sp, #1096]

    ldr	x15,	[sp, fp]

    movz	fp,	#2316
    str	s10,	[x15]

    movi	v10.4s,	#0
    ldr	s6,	[sp, #1140]

    ldr	x25,	[sp, fp]

    movz	fp,	#4348
    str	s6,	[x25]

    ldr	s6,	[sp, #1180]

    ldr	x12,	[sp, #2328]

    str	s6,	[x12]

    ldr	x21,	[sp, #2344]

    str	s10,	[x21]

    ldr	w25,	[sp, #3424]

    ldr	x21,	[sp, fp]

    lsl	w5,	w25,	#2
    movz	fp,	#2452
    add	x7,	x21,	x5
    ldr	w6,	[x7]

    ldr	w18,	[sp, #2748]

    ldr	w8,	[sp, #2752]

    add	w18,	w8,	w18
    add	w10,	w18,	w6
    str	w10,	[sp, #2076]

    ldr	w18,	[sp, #3424]

    ldr	x4,	[sp, #2472]

    lsl	w6,	w18,	#2
    add	x5,	x4,	x6
    ldr	w5,	[x5]

    ldr	w8,	[sp, #2692]

    ldr	w7,	[sp, #2696]

    add	w11,	w7,	w8
    add	w10,	w11,	w5
    str	w10,	[sp, #2064]

    ldr	w25,	[sp, #3424]

    ldr	x12,	[sp, fp]

    lsl	w16,	w25,	#2
    movz	fp,	#2388
    add	x17,	x12,	x16
    ldr	w15,	[x17]

    ldr	w4,	[sp, #3424]

    ldr	x26,	[sp, fp]

    lsl	w5,	w4,	#2
    movz	fp,	#2188
    add	x10,	x26,	x5
    ldr	w7,	[x10]

    ldr	w6,	[sp, #1072]

    add	w5,	w15,	w6
    add	w25,	w5,	w7
    str	w25,	[sp, #1808]

    ldr	w2,	[sp, #3424]

    ldr	x6,	[sp, #2352]

    lsl	w16,	w2,	#2
    add	x5,	x6,	x16
    ldr	w5,	[x5]

    ldr	w15,	[sp, #2664]

    ldr	w4,	[sp, #3424]

    add	w8,	w5,	w15
    ldr	x2,	[sp, fp]

    lsl	w18,	w4,	#2
    movz	fp,	#2284
    add	x5,	x2,	x18
    ldr	w17,	[x5]

    add	w10,	w8,	w17
    str	w10,	[sp, #2128]

    ldr	w12,	[sp, #3424]

    ldr	x23,	[sp, #4968]

    lsl	w16,	w12,	#2
    add	x7,	x23,	x16
    ldr	w4,	[x7]

    ldr	w14,	[sp, #3424]

    ldr	x7,	[sp, #4992]

    lsl	w12,	w14,	#2
    add	x7,	x7,	x12
    ldr	w17,	[x7]

    ldr	w15,	[sp, #1036]

    add	w8,	w4,	w15
    add	w2,	w8,	w17
    str	w2,	[sp, #2224]

    ldr	w6,	[sp, #3424]

    ldr	x26,	[sp, #4936]

    lsl	w16,	w6,	#2
    add	x6,	x26,	x16
    ldr	w6,	[x6]

    ldr	w10,	[sp, #3424]

    ldr	x28,	[sp, #4976]

    lsl	w7,	w10,	#2
    add	x16,	x28,	x7
    ldr	w7,	[x16]

    ldr	w11,	[sp, #2632]

    add	w6,	w6,	w11
    add	w25,	w6,	w7
    str	w25,	[sp, #2044]

    ldr	w12,	[sp, #3424]

    ldr	x5,	[sp, fp]

    lsl	w21,	w12,	#2
    movz	fp,	#2252
    add	x8,	x5,	x21
    ldr	w7,	[x8]

    ldr	w17,	[sp, #2600]

    ldr	w4,	[sp, #2644]

    add	w17,	w17,	w4
    add	w10,	w17,	w7
    str	w10,	[sp, #2056]

    ldr	w17,	[sp, #3424]

    ldr	x2,	[sp, #4896]

    lsl	w6,	w17,	#2
    add	x6,	x2,	x6
    ldr	w18,	[x6]

    ldr	w2,	[sp, #2604]

    ldr	w22,	[sp, #3424]

    add	w11,	w18,	w2
    ldr	x16,	[sp, #4920]

    lsl	w7,	w22,	#2
    add	x18,	x16,	x7
    ldr	w7,	[x18]

    add	w23,	w11,	w7
    str	w23,	[sp, #3844]

    ldr	w6,	[sp, #3424]

    ldr	x16,	[sp, fp]

    lsl	w8,	w6,	#2
    movz	fp,	#2812
    add	x10,	x16,	x8
    ldr	w6,	[x10]

    ldr	w12,	[sp, #2568]

    ldr	w4,	[sp, #2580]

    ldr	w10,	[sp, #1016]

    add	w5,	w12,	w4
    add	w5,	w5,	w10
    add	w23,	w5,	w6
    str	w23,	[sp, #10084]

    ldr	w17,	[sp, #2076]

    ldr	x2,	[sp, fp]

    movz	fp,	#2708
    str	w17,	[x2]

    ldr	w16,	[sp, #2064]

    ldr	x18,	[sp, fp]

    movz	fp,	#2724
    str	w16,	[x18]

    movz	w18,	#0
    ldr	w5,	[sp, #1808]

    mov	w7,	w18
    ldr	x26,	[sp, fp]

    fcvtzs	w18,	s29
    movz	fp,	#2732
    str	w5,	[x26]

    ldr	w17,	[sp, #2128]

    ldr	x16,	[sp, fp]

    movz	fp,	#2756
    str	w17,	[x16]

    ldr	w16,	[sp, #2224]

    ldr	x12,	[sp, fp]

    movz	fp,	#2764
    str	w16,	[x12]

    ldr	w5,	[sp, #2044]

    ldr	x6,	[sp, fp]

    movz	fp,	#2772
    str	w5,	[x6]

    ldr	w16,	[sp, #2056]

    ldr	x17,	[sp, fp]

    movz	fp,	#2788
    str	w16,	[x17]

    ldr	x16,	[sp, fp]

    movz	fp,	#2796
    ldr	w26,	[sp, #3844]

    str	w26,	[x16]

    ldr	x2,	[sp, fp]

    movz	fp,	#2804
    ldr	w24,	[sp, #10084]

    str	w24,	[x2]

    ldr	x5,	[sp, fp]

    str	w7,	[x5]

    ldr	w16,	[sp, #1016]

    ldr	w21,	[sp, #1016]

    scvtf	s26,	w16
    cmp	w21,	#0
    beq	main_716

main_889:
    movz	w0,	#10
    ldr	x1,	[sp, #2552]

    bl	putfarray
    movz	fp,	#2812
    movz	w0,	#10
    ldr	x1,	[sp, fp]

    bl	putarray
    ldr	w23,	[sp, #2076]

    movz	fp,	#2812
    scvtf	s13,	w23
    str	s13,	[sp, #1092]

    ldr	s10,	[sp, #1092]

    ldr	s11,	[sp, #1540]

    ldr	x25,	[sp, fp]

    fsub	s11,	s10,	s11
    movz	fp,	#2708
    fcvtzs	w18,	s11
    str	w18,	[x25]

    ldr	w20,	[sp, #2064]

    scvtf	s11,	w20
    ldr	s9,	[sp, #1532]

    fsub	s13,	s11,	s9
    ldr	x27,	[sp, fp]

    fcvtzs	w21,	s13
    movz	fp,	#2724
    str	w21,	[x27]

    ldr	w25,	[sp, #1808]

    ldr	s9,	[sp, #1544]

    scvtf	s10,	w25
    ldr	x27,	[sp, fp]

    fsub	s14,	s10,	s9
    movz	fp,	#2732
    fcvtzs	w28,	s14
    str	w28,	[x27]

    ldr	w20,	[sp, #2128]

    ldr	s14,	[sp, #1548]

    scvtf	s8,	w20
    ldr	x20,	[sp, fp]

    fsub	s13,	s8,	s14
    movz	fp,	#2756
    fcvtzs	w28,	s13
    str	w28,	[x20]

    ldr	w28,	[sp, #2224]

    scvtf	s8,	w28
    ldr	s11,	[sp, #1552]

    ldr	x21,	[sp, fp]

    fsub	s11,	s8,	s11
    movz	fp,	#2764
    fcvtzs	w27,	s11
    str	w27,	[x21]

    ldr	w25,	[sp, #2044]

    scvtf	s10,	w25
    ldr	s14,	[sp, #1536]

    fsub	s13,	s10,	s14
    ldr	x27,	[sp, fp]

    fcvtzs	w28,	s13
    movz	fp,	#2772
    str	w28,	[x27]

    movz	w27,	#0
    ldr	w20,	[sp, #2056]

    ldr	s10,	[sp, #1096]

    scvtf	s13,	w20
    ldr	x20,	[sp, fp]

    fsub	s14,	s13,	s10
    movz	fp,	#2788
    fcvtzs	w28,	s14
    str	w28,	[x20]

    ldr	w23,	[sp, #3844]

    scvtf	s11,	w23
    ldr	s10,	[sp, #1140]

    fsub	s13,	s11,	s10
    ldr	x26,	[sp, fp]

    fcvtzs	w25,	s13
    movz	fp,	#2796
    str	w25,	[x26]

    ldr	w26,	[sp, #10084]

    scvtf	s11,	w26
    ldr	s10,	[sp, #1180]

    ldr	x23,	[sp, fp]

    fsub	s13,	s11,	s10
    movz	fp,	#2804
    fcvtzs	w26,	s13
    str	w26,	[x23]

    ldr	x19,	[sp, fp]

    str	w27,	[x19]

    ldr	w28,	[sp, #3424]

    lsl	w23,	w28,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	#864
    ldr	w24,	[x22]

    ldr	s8,	[sp, #1180]

    scvtf	s13,	w24
    ldr	s0,	[sp, #1288]

    fmul	s11,	s13,	s8
    fcvtzs	w26,	s11
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s12
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s15
    bl	putfloat
    movz	w0,	#10
    bl	putch
    mov	w0,	w26
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#10128
    add	sp, sp, fp
    ret


main_716:
    movz	fp,	#2812
    fmov	s29,	s26
    mov	w4,	w18
    ldr	x7,	[sp, fp]

    movz	fp,	#4348
    mov	x22,	x7
    str	x22,	[sp, fp]

    movz	fp,	#3772
    ldr	x6,	[sp, #2552]

    mov	x9,	x6
    str	x9,	[sp, fp]

    movz	fp,	#6316
    str	w4,	[sp, #1016]

    ldr	w16,	[sp, #2748]

    ldr	w10,	[sp, #6368]

    ldr	w11,	[sp, #6368]

    mov	w16,	w10
    str	w11,	[sp, #2748]

    ldr	w5,	[sp, #2752]

    ldr	w13,	[sp, #6372]

    ldr	w14,	[sp, #6372]

    mov	w5,	w13
    str	w14,	[sp, #2752]

    ldr	x15,	[sp, #2512]

    ldr	x3,	[sp, fp]

    movz	fp,	#6316
    mov	x15,	x3
    ldr	x4,	[sp, fp]

    movz	fp,	#6300
    str	x4,	[sp, #2512]

    ldr	x7,	[sp, #2472]

    ldr	x26,	[sp, fp]

    movz	fp,	#6300
    mov	x7,	x26
    ldr	x27,	[sp, fp]

    movz	fp,	#6308
    str	x27,	[sp, #2472]

    ldr	w7,	[sp, #2692]

    ldr	w4,	[sp, #6360]

    ldr	w5,	[sp, #6360]

    mov	w7,	w4
    str	w5,	[sp, #2692]

    ldr	w25,	[sp, #2696]

    ldr	w7,	[sp, #6364]

    ldr	w8,	[sp, #6364]

    mov	w25,	w7
    str	w8,	[sp, #2696]

    ldr	x4,	[sp, #2496]

    ldr	x0,	[sp, fp]

    movz	fp,	#6308
    mov	x4,	x0
    ldr	x1,	[sp, fp]

    movz	fp,	#2452
    str	x1,	[sp, #2496]

    ldr	x15,	[sp, fp]

    movz	fp,	#6292
    ldr	x23,	[sp, fp]

    movz	fp,	#6292
    mov	x15,	x23
    ldr	x24,	[sp, fp]

    movz	fp,	#2452
    str	x24,	[sp, fp]

    movz	fp,	#2388
    ldr	x6,	[sp, fp]

    movz	fp,	#6260
    ldr	x11,	[sp, fp]

    movz	fp,	#6260
    mov	x6,	x11
    ldr	x12,	[sp, fp]

    movz	fp,	#2388
    str	x12,	[sp, fp]

    movz	fp,	#6268
    ldr	w2,	[sp, #1072]

    ldr	w27,	[sp, #6352]

    ldr	w28,	[sp, #6352]

    mov	w2,	w27
    str	w28,	[sp, #1072]

    ldr	x7,	[sp, #2408]

    ldr	x14,	[sp, fp]

    movz	fp,	#6268
    mov	x7,	x14
    ldr	x15,	[sp, fp]

    movz	fp,	#2420
    str	x15,	[sp, #2408]

    ldr	x25,	[sp, fp]

    movz	fp,	#6276
    ldr	x17,	[sp, fp]

    movz	fp,	#6276
    mov	x25,	x17
    ldr	x18,	[sp, fp]

    movz	fp,	#2420
    str	x18,	[sp, fp]

    movz	fp,	#2436
    ldr	x2,	[sp, fp]

    movz	fp,	#6284
    ldr	x20,	[sp, fp]

    movz	fp,	#6284
    mov	x2,	x20
    ldr	x21,	[sp, fp]

    movz	fp,	#2436
    str	x21,	[sp, fp]

    movz	fp,	#6244
    ldr	w15,	[sp, #2664]

    ldr	w1,	[sp, #6356]

    ldr	w2,	[sp, #6356]

    mov	w15,	w1
    str	w2,	[sp, #2664]

    ldr	x5,	[sp, #2352]

    ldr	x5,	[sp, fp]

    movz	fp,	#6244
    ldr	x6,	[sp, fp]

    movz	fp,	#6252
    str	x6,	[sp, #2352]

    ldr	x8,	[sp, #2368]

    ldr	x8,	[sp, fp]

    movz	fp,	#6252
    ldr	x9,	[sp, fp]

    movz	fp,	#2188
    str	x9,	[sp, #2368]

    ldr	x15,	[sp, fp]

    movz	fp,	#6236
    ldr	x2,	[sp, fp]

    movz	fp,	#6236
    mov	x15,	x2
    ldr	x3,	[sp, fp]

    movz	fp,	#2188
    str	x3,	[sp, fp]

    movz	fp,	#7212
    ldr	x24,	[sp, #4968]

    ldr	x4,	[sp, fp]

    movz	fp,	#7212
    mov	x24,	x4
    ldr	x5,	[sp, fp]

    movz	fp,	#2236
    str	x5,	[sp, #4968]

    ldr	x7,	[sp, fp]

    movz	fp,	#2236
    ldr	x18,	[sp, #6864]

    ldr	x19,	[sp, #6864]

    mov	x7,	x18
    str	x19,	[sp, fp]

    movz	fp,	#7228
    ldr	x8,	[sp, #4992]

    ldr	x10,	[sp, fp]

    movz	fp,	#7228
    mov	x8,	x10
    ldr	x11,	[sp, fp]

    movz	fp,	#2244
    str	x11,	[sp, #4992]

    ldr	w7,	[sp, #1036]

    ldr	w24,	[sp, #6348]

    ldr	w25,	[sp, #6348]

    mov	w7,	w24
    str	w25,	[sp, #1036]

    ldr	x12,	[sp, fp]

    movz	fp,	#2244
    ldr	x21,	[sp, #6872]

    ldr	x22,	[sp, #6872]

    mov	x12,	x21
    str	x22,	[sp, fp]

    movz	fp,	#2268
    ldr	x26,	[sp, fp]

    movz	fp,	#7196
    ldr	x27,	[sp, fp]

    movz	fp,	#7196
    mov	x26,	x27
    ldr	x28,	[sp, fp]

    movz	fp,	#2268
    str	x28,	[sp, fp]

    movz	fp,	#7220
    ldr	x27,	[sp, #4936]

    ldr	x15,	[sp, #6856]

    ldr	x16,	[sp, #6856]

    mov	x27,	x15
    str	x16,	[sp, #4936]

    ldr	x0,	[sp, #4976]

    ldr	x7,	[sp, fp]

    movz	fp,	#7220
    mov	x0,	x7
    ldr	x8,	[sp, fp]

    movz	fp,	#2284
    str	x8,	[sp, #4976]

    ldr	w16,	[sp, #2632]

    ldr	w18,	[sp, #6340]

    ldr	w19,	[sp, #6340]

    mov	w16,	w18
    str	w19,	[sp, #2632]

    ldr	w16,	[sp, #2644]

    ldr	w21,	[sp, #6344]

    ldr	w22,	[sp, #6344]

    mov	w16,	w21
    str	w22,	[sp, #2644]

    ldr	x6,	[sp, fp]

    movz	fp,	#7204
    ldr	x1,	[sp, fp]

    movz	fp,	#7204
    mov	x6,	x1
    ldr	x2,	[sp, fp]

    movz	fp,	#2284
    str	x2,	[sp, fp]

    movz	fp,	#4356
    ldr	w21,	[sp, #2600]

    ldr	w12,	[sp, #6332]

    ldr	w13,	[sp, #6332]

    mov	w21,	w12
    str	w13,	[sp, #2600]

    ldr	x8,	[sp, #4904]

    ldr	x9,	[sp, #6840]

    ldr	x10,	[sp, #6840]

    mov	x8,	x9
    str	x10,	[sp, #4904]

    ldr	w14,	[sp, #2604]

    ldr	w15,	[sp, #6336]

    ldr	w16,	[sp, #6336]

    mov	w14,	w15
    str	w16,	[sp, #2604]

    ldr	x3,	[sp, #4896]

    ldr	x6,	[sp, #6832]

    ldr	x7,	[sp, #6832]

    mov	x3,	x6
    str	x7,	[sp, #4896]

    ldr	x17,	[sp, #4920]

    ldr	x12,	[sp, #6848]

    ldr	x13,	[sp, #6848]

    mov	x17,	x12
    str	x13,	[sp, #4920]

    ldr	x24,	[sp, fp]

    movz	fp,	#4356
    ldr	x3,	[sp, #6824]

    ldr	x4,	[sp, #6824]

    mov	x24,	x3
    str	x4,	[sp, fp]

    movz	fp,	#2252
    ldr	w2,	[sp, #2580]

    ldr	w9,	[sp, #6328]

    ldr	w10,	[sp, #6328]

    mov	w2,	w9
    str	w10,	[sp, #2580]

    ldr	x17,	[sp, fp]

    movz	fp,	#2252
    ldr	x24,	[sp, #6880]

    ldr	x25,	[sp, #6880]

    mov	x17,	x24
    str	x25,	[sp, fp]

    movz	fp,	#1812
    ldr	x7,	[sp, fp]

    movz	fp,	#6212
    ldr	x22,	[sp, fp]

    movz	fp,	#6212
    mov	x7,	x22
    ldr	x23,	[sp, fp]

    movz	fp,	#1812
    str	x23,	[sp, fp]

    movz	fp,	#2148
    ldr	w12,	[sp, #2568]

    ldr	w6,	[sp, #6324]

    ldr	w7,	[sp, #6324]

    mov	w12,	w6
    str	w7,	[sp, #2568]

    ldr	x15,	[sp, fp]

    movz	fp,	#6220
    ldr	x25,	[sp, fp]

    movz	fp,	#6220
    mov	x15,	x25
    ldr	x26,	[sp, fp]

    movz	fp,	#2148
    str	x26,	[sp, fp]

    movz	fp,	#2156
    ldr	x10,	[sp, fp]

    movz	fp,	#6228
    ldr	x28,	[sp, fp]

    movz	fp,	#6228
    mov	x10,	x28
    ldr	x0,	[sp, fp]

    movz	fp,	#2156
    str	x0,	[sp, fp]

    b	main_717

main_517:
    movz	fp,	#2740
    ldr	x9,	[sp, fp]

    movz	fp,	#2716
    mov	x5,	x9
    str	x5,	[sp, #5496]

    ldr	x1,	[sp, fp]

    movz	fp,	#2740
    mov	x9,	x1
    str	x9,	[sp, fp]

    movz	fp,	#2700
    ldr	x11,	[sp, fp]

    movz	fp,	#2716
    mov	x2,	x11
    str	x2,	[sp, fp]

    movz	fp,	#2700
    ldr	x20,	[sp, #1064]

    mov	x12,	x20
    str	x12,	[sp, fp]

    movz	fp,	#2668
    ldr	x1,	[sp, #2656]

    mov	x21,	x1
    str	x21,	[sp, #1064]

    ldr	x11,	[sp, fp]

    movz	fp,	#2676
    mov	x2,	x11
    str	x2,	[sp, #2656]

    ldr	x20,	[sp, fp]

    movz	fp,	#2668
    mov	x12,	x20
    str	x12,	[sp, fp]

    movz	fp,	#2684
    ldr	x2,	[sp, fp]

    movz	fp,	#2676
    mov	x21,	x2
    str	x21,	[sp, fp]

    movz	fp,	#2684
    ldr	x11,	[sp, #1056]

    mov	x1,	x11
    str	x1,	[sp, fp]

    movz	fp,	#2572
    ldr	x2,	[sp, #2592]

    mov	x12,	x2
    str	x12,	[sp, #1056]

    ldr	x8,	[sp, fp]

    movz	fp,	#2572
    mov	x3,	x8
    str	x3,	[sp, #2592]

    ldr	x25,	[sp, #2584]

    mov	x9,	x25
    str	x9,	[sp, fp]

    movz	fp,	#2444
    ldr	x2,	[sp, #2560]

    mov	x26,	x2
    str	x26,	[sp, #2584]

    ldr	x13,	[sp, #2544]

    mov	x3,	x13
    str	x3,	[sp, #2560]

    ldr	x2,	[sp, #2480]

    mov	x14,	x2
    str	x14,	[sp, #2544]

    ldr	x3,	[sp, #2528]

    str	x3,	[sp, #2480]

    ldr	x8,	[sp, #2536]

    mov	x4,	x8
    str	x4,	[sp, #2528]

    ldr	x25,	[sp, #2520]

    mov	x9,	x25
    str	x9,	[sp, #2536]

    ldr	x13,	[sp, #2464]

    mov	x26,	x13
    str	x26,	[sp, #2520]

    ldr	x2,	[sp, #2488]

    mov	x14,	x2
    str	x14,	[sp, #2464]

    ldr	x8,	[sp, #2504]

    mov	x3,	x8
    str	x3,	[sp, #2488]

    ldr	x0,	[sp, fp]

    movz	fp,	#2428
    mov	x9,	x0
    str	x9,	[sp, #2504]

    ldr	x15,	[sp, fp]

    movz	fp,	#2444
    mov	x1,	x15
    str	x1,	[sp, fp]

    movz	fp,	#2428
    ldr	x1,	[sp, #2400]

    mov	x20,	x1
    str	x20,	[sp, fp]

    movz	fp,	#2380
    ldr	x21,	[sp, #2360]

    mov	x2,	x21
    str	x2,	[sp, #2400]

    ldr	x7,	[sp, fp]

    movz	fp,	#2380
    mov	x25,	x7
    str	x25,	[sp, #2360]

    ldr	x4,	[sp, #2336]

    mov	x8,	x4
    str	x8,	[sp, fp]

    movz	fp,	#2196
    ldr	x1,	[sp, fp]

    movz	fp,	#2212
    mov	x5,	x1
    str	x5,	[sp, #2336]

    ldr	x5,	[sp, fp]

    movz	fp,	#2196
    mov	x2,	x5
    str	x2,	[sp, fp]

    movz	fp,	#2308
    ldr	x13,	[sp, fp]

    movz	fp,	#2212
    mov	x6,	x13
    str	x6,	[sp, fp]

    movz	fp,	#2180
    ldr	x12,	[sp, fp]

    movz	fp,	#2308
    mov	x14,	x12
    str	x14,	[sp, fp]

    movz	fp,	#2092
    ldr	x8,	[sp, fp]

    movz	fp,	#2180
    mov	x13,	x8
    str	x13,	[sp, fp]

    movz	fp,	#2092
    ldr	x20,	[sp, #2104]

    mov	x9,	x20
    str	x9,	[sp, fp]

    movz	fp,	#2140
    ldr	x2,	[sp, #2112]

    mov	x21,	x2
    str	x21,	[sp, #2104]

    ldr	x2,	[sp, #2080]

    mov	x1,	x2
    str	x1,	[sp, #2112]

    ldr	x14,	[sp, fp]

    movz	fp,	#2132
    mov	x3,	x14
    str	x3,	[sp, #2080]

    ldr	x9,	[sp, fp]

    movz	fp,	#2140
    mov	x15,	x9
    str	x15,	[sp, fp]

    movz	fp,	#2068
    ldr	x26,	[sp, fp]

    movz	fp,	#2132
    mov	x10,	x26
    str	x10,	[sp, fp]

    movz	fp,	#2068
    ldr	x10,	[sp, #2120]

    mov	x1,	x10
    str	x1,	[sp, fp]

    movz	fp,	#2780
    ldr	x11,	[sp, fp]

    str	x11,	[sp, #2120]

    b	main_518

main_308:
    ldr	w18,	[sp, #5484]

    mov	w5,	w18
    str	w5,	[sp, #2416]

    ldr	w5,	[sp, #6936]

    str	w19,	[sp, #6936]

    mov	w5,	w19
    ldr	w7,	[sp, #5480]

    str	w19,	[sp, #5480]

    mov	w7,	w19
    ldr	w0,	[sp, #5484]

    str	w19,	[sp, #5484]

    mov	w0,	w19
    ldr	w13,	[sp, #6940]

    str	w19,	[sp, #6940]

    mov	w13,	w19
    ldr	w20,	[sp, #6944]

    str	w19,	[sp, #6944]

    mov	w20,	w19
    ldr	s16,	[sp, #1432]

    str	s11,	[sp, #1432]

    fmov	s16,	s11
    ldr	s20,	[sp, #1476]

    str	s13,	[sp, #1476]

    fmov	s20,	s13
    ldr	w6,	[sp, #2376]

    ldr	w0,	[sp, #6208]

    ldr	w5,	[sp, #6208]

    mov	w6,	w0
    str	w5,	[sp, #2376]

    ldr	s19,	[sp, #1496]

    str	s14,	[sp, #1496]

    fmov	s19,	s14
    ldr	s23,	[sp, #1508]

    str	s13,	[sp, #1508]

    fmov	s23,	s13
    ldr	w5,	[sp, #2324]

    ldr	w13,	[sp, #6204]

    ldr	w14,	[sp, #6204]

    mov	w5,	w13
    str	w14,	[sp, #2324]

    ldr	s27,	[sp, #1500]

    str	s11,	[sp, #1500]

    fmov	s27,	s11
    ldr	s3,	[sp, #1804]

    str	s12,	[sp, #1804]

    fmov	s3,	s12
    ldr	s16,	[sp, #1464]

    str	s14,	[sp, #1464]

    fmov	s16,	s14
    ldr	s3,	[sp, #1512]

    str	s14,	[sp, #1512]

    fmov	s3,	s14
    ldr	w26,	[sp, #6948]

    str	w19,	[sp, #6948]

    mov	w26,	w19
    ldr	s9,	[sp, #1504]

    str	s12,	[sp, #1504]

    fmov	s9,	s12
    ldr	w0,	[sp, #5492]

    str	w19,	[sp, #5492]

    mov	w0,	w19
    ldr	w13,	[sp, #5516]

    str	w19,	[sp, #5516]

    mov	w13,	w19
    ldr	s10,	[sp, #1484]

    str	s11,	[sp, #1484]

    fmov	s10,	s11
    ldr	s30,	[sp, #1132]

    str	s14,	[sp, #1132]

    fmov	s30,	s14
    ldr	s25,	[sp, #1488]

    str	s12,	[sp, #1488]

    fmov	s25,	s12
    ldr	s4,	[sp, #1492]

    str	s13,	[sp, #1492]

    fmov	s4,	s13
    ldr	w5,	[sp, #7824]

    str	w19,	[sp, #7824]

    mov	w5,	w19
    ldr	s25,	[sp, #1128]

    str	s12,	[sp, #1128]

    fmov	s25,	s12
    ldr	w14,	[sp, #2088]

    ldr	w0,	[sp, #6196]

    ldr	w2,	[sp, #6196]

    mov	w14,	w0
    str	w2,	[sp, #2088]

    ldr	s30,	[sp, #1480]

    str	s14,	[sp, #1480]

    fmov	s30,	s14
    ldr	s8,	[sp, #1472]

    str	s12,	[sp, #1472]

    fmov	s8,	s12
    ldr	s30,	[sp, #1136]

    str	s14,	[sp, #1136]

    fmov	s30,	s14
    ldr	w2,	[sp, #2176]

    ldr	w7,	[sp, #6200]

    ldr	w9,	[sp, #6200]

    mov	w2,	w7
    str	w9,	[sp, #2176]

    ldr	w13,	[sp, #7828]

    str	w19,	[sp, #7828]

    mov	w13,	w19
    ldr	s26,	[sp, #1468]

    str	s11,	[sp, #1468]

    fmov	s26,	s11
    ldr	w23,	[sp, #5488]

    str	w19,	[sp, #5488]

    mov	w23,	w19
    ldr	s19,	[sp, #1088]

    str	s14,	[sp, #1088]

    fmov	s19,	s14
    ldr	w2,	[sp, #6952]

    str	w19,	[sp, #6952]

    mov	w2,	w19
    ldr	w9,	[sp, #5508]

    str	w19,	[sp, #5508]

    mov	w9,	w19
    ldr	s25,	[sp, #1100]

    str	s12,	[sp, #1100]

    fmov	s25,	s12
    ldr	s26,	[sp, #1104]

    str	s11,	[sp, #1104]

    fmov	s26,	s11
    ldr	w27,	[sp, #6180]

    str	w19,	[sp, #6180]

    mov	w27,	w19
    ldr	w27,	[sp, #5520]

    str	w19,	[sp, #5520]

    mov	w27,	w19
    ldr	s30,	[sp, #1144]

    str	s13,	[sp, #1144]

    fmov	s30,	s13
    ldr	s20,	[sp, #1560]

    str	s14,	[sp, #1560]

    fmov	s20,	s14
    ldr	s9,	[sp, #1160]

    str	s14,	[sp, #1160]

    fmov	s9,	s14
    ldr	w28,	[sp, #5504]

    str	w19,	[sp, #5504]

    mov	w28,	w19
    ldr	s20,	[sp, #1076]

    str	s11,	[sp, #1076]

    fmov	s20,	s11
    ldr	s27,	[sp, #1108]

    str	s12,	[sp, #1108]

    fmov	s27,	s12
    b	main_309

main_305:
    ldr	s19,	[sp, #1080]

    fmov	s27,	s8
    fmov	s20,	s24
    ldr	s7,	[sp, #1156]

    ldr	s6,	[sp, #1080]

    fadd	s15,	s7,	s19
    fmov	s2,	s6
    fadd	s15,	s15,	s8
    str	s2,	[sp, #1156]

    fmov	s8,	s31
    str	s27,	[sp, #1080]

    fmov	s31,	s26
    ldr	s9,	[sp, #1436]

    fmov	s26,	s3
    ldr	s25,	[sp, #1556]

    fmov	s3,	s1
    str	s25,	[sp, #1436]

    fmov	s1,	s4
    str	s20,	[sp, #1556]

    fmov	s4,	s23
    ldr	s22,	[sp, #1392]

    fmov	s23,	s9
    fmov	s24,	s22
    fmov	s22,	s18
    str	s22,	[sp, #1392]

    ldr	s29,	[sp, #1396]

    ldr	s9,	[sp, #1404]

    fmov	s18,	s29
    fmov	s30,	s9
    str	s30,	[sp, #1396]

    ldr	s28,	[sp, #1572]

    fmov	s10,	s28
    str	s10,	[sp, #1404]

    ldr	s20,	[sp, #1568]

    fmov	s29,	s20
    str	s29,	[sp, #1572]

    ldr	s6,	[sp, #1576]

    fmov	s21,	s6
    str	s21,	[sp, #1568]

    ldr	s16,	[sp, #1580]

    fmov	s7,	s16
    str	s7,	[sp, #1576]

    ldr	s30,	[sp, #1588]

    fmov	s17,	s30
    str	s17,	[sp, #1580]

    ldr	s22,	[sp, #1584]

    fmov	s2,	s22
    str	s2,	[sp, #1588]

    ldr	s9,	[sp, #1592]

    fmov	s25,	s9
    str	s25,	[sp, #1584]

    ldr	s20,	[sp, #1600]

    fmov	s10,	s20
    str	s10,	[sp, #1592]

    ldr	s28,	[sp, #1604]

    fmov	s21,	s28
    str	s21,	[sp, #1600]

    ldr	s6,	[sp, #1608]

    fmov	s29,	s6
    str	s29,	[sp, #1604]

    ldr	s17,	[sp, #1424]

    fmov	s7,	s17
    str	s7,	[sp, #1608]

    fmov	s7,	s15
    ldr	s21,	[sp, #1628]

    fmov	s19,	s21
    str	s19,	[sp, #1424]

    ldr	s29,	[sp, #1632]

    fmov	s22,	s29
    str	s22,	[sp, #1628]

    ldr	s25,	[sp, #1428]

    fmov	s30,	s25
    str	s30,	[sp, #1632]

    ldr	s21,	[sp, #1828]

    str	s21,	[sp, #1428]

    ldr	s17,	[sp, #1084]

    fmov	s29,	s17
    str	s29,	[sp, #1828]

    ldr	s21,	[sp, #1124]

    fmov	s30,	s21
    str	s30,	[sp, #1084]

    ldr	s17,	[sp, #1116]

    fmov	s25,	s17
    str	s25,	[sp, #1124]

    ldr	s30,	[sp, #1120]

    fmov	s21,	s30
    str	s21,	[sp, #1116]

    ldr	s25,	[sp, #1112]

    fmov	s6,	s25
    str	s6,	[sp, #1120]

    ldr	s21,	[sp, #1164]

    fmov	s30,	s21
    str	s30,	[sp, #1112]

    ldr	s6,	[sp, #1172]

    str	s6,	[sp, #1164]

    ldr	s28,	[sp, #1176]

    str	s28,	[sp, #1172]

    ldr	s21,	[sp, #1192]

    str	s21,	[sp, #1176]

    str	s7,	[sp, #1192]

    b	main_148

