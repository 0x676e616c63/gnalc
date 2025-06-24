.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#10576
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w5,	#0
    str	w0,	[sp, #3304]

    mov	w28,	w5

main_10:
    cmp	w28,	#40
    bge	main_18

main_13:
    lsl	w19,	w28,	#2
    add	w26,	w19,	w28,	lsl #3
    mov	x0,	x26
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getfarray
    add	w3,	w28,	#1
    mov	w28,	w3
    b	main_10

main_18:
    movz	w6,	#0
    mov	w23,	w6

main_19:
    cmp	w23,	#24
    bge	main_27

main_22:
    lsl	w20,	w23,	#2
    add	w20,	w20,	w23,	lsl #3
    mov	x0,	x20
    add	x0,	sp,	x0
    add	x0,	x0,	#496
    bl	getarray
    add	w3,	w23,	#1
    mov	w23,	w3
    b	main_19

main_27:
    add	x1,	sp,	#16
    movz	fp,	#3212
    add	x23,	sp,	#28
    add	x8,	sp,	#52
    add	x4,	sp,	#64
    add	x10,	sp,	#172
    str	x1,	[sp, fp]

    movz	fp,	#3212
    ldr	w11,	[sp, #3304]

    lsl	w9,	w11,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3204
    add	x7,	x0,	x9
    add	x0,	sp,	#76
    ldr	s17,	[x7]

    add	x7,	sp,	#268
    str	s17,	[sp, #1292]

    str	x23,	[sp, fp]

    movz	fp,	#3204
    ldr	w12,	[sp, #3304]

    lsl	w13,	w12,	#2
    ldr	x2,	[sp, fp]

    add	x12,	sp,	#40
    movz	fp,	#3188
    add	x11,	x2,	x13
    ldr	s9,	[x11]

    add	x11,	sp,	#256
    str	s9,	[sp, #1232]

    str	x12,	[sp, fp]

    movz	fp,	#3188
    ldr	w13,	[sp, #3304]

    lsl	w16,	w13,	#2
    ldr	x18,	[sp, fp]

    add	x13,	sp,	#124
    movz	fp,	#3180
    add	x15,	x18,	x16
    ldr	s24,	[x15]

    str	s24,	[sp, #1296]

    str	x8,	[sp, fp]

    movz	fp,	#3180
    ldr	w14,	[sp, #3304]

    lsl	w28,	w14,	#2
    ldr	x12,	[sp, fp]

    add	x14,	sp,	#160
    movz	fp,	#3172
    add	x19,	x12,	x28
    add	x28,	sp,	#100
    ldr	s29,	[x19]

    str	s29,	[sp, #1300]

    str	x4,	[sp, fp]

    movz	fp,	#3172
    ldr	w15,	[sp, #3304]

    lsl	w3,	w15,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#3164
    add	x1,	x9,	x3
    ldr	s3,	[x1]

    str	s3,	[sp, #1304]

    str	x0,	[sp, fp]

    movz	fp,	#3164
    ldr	w16,	[sp, #3304]

    lsl	w1,	w16,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3156
    add	x0,	x2,	x1
    add	x2,	sp,	#88
    ldr	s17,	[x0]

    str	s17,	[sp, #1264]

    str	x2,	[sp, fp]

    add	x2,	sp,	#148
    movz	fp,	#3156
    ldr	w17,	[sp, #3304]

    ldr	x5,	[sp, fp]

    lsl	w0,	w17,	#2
    movz	fp,	#3148
    add	x17,	sp,	#112
    add	x4,	x5,	x0
    ldr	s22,	[x4]

    str	s22,	[sp, #1240]

    str	x28,	[sp, fp]

    movz	fp,	#3148
    ldr	w18,	[sp, #3304]

    lsl	w5,	w18,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3140
    add	x8,	x0,	x5
    add	x5,	sp,	#136
    ldr	s25,	[x8]

    str	s25,	[sp, #1216]

    str	x17,	[sp, fp]

    movz	fp,	#3140
    ldr	w19,	[sp, #3304]

    lsl	w8,	w19,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#3132
    add	x12,	x19,	x8
    ldr	s21,	[x12]

    str	s21,	[sp, #1212]

    str	x13,	[sp, fp]

    movz	fp,	#3132
    ldr	w23,	[sp, #3304]

    lsl	w12,	w23,	#2
    ldr	x15,	[sp, fp]

    movz	fp,	#3116
    add	x16,	x15,	x12
    add	x15,	sp,	#244
    ldr	s7,	[x16]

    str	s7,	[sp, #1308]

    str	x5,	[sp, fp]

    movz	fp,	#3116
    ldr	w28,	[sp, #3304]

    lsl	w18,	w28,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#3092
    add	x23,	x6,	x18
    add	x6,	sp,	#184
    ldr	s14,	[x23]

    str	s14,	[sp, #1312]

    str	x2,	[sp, fp]

    movz	fp,	#3092
    ldr	w23,	[sp, #3304]

    lsl	w4,	w23,	#2
    ldr	x1,	[sp, fp]

    add	x23,	sp,	#316
    movz	fp,	#3076
    add	x2,	x1,	x4
    add	x4,	sp,	#208
    ldr	s22,	[x2]

    str	s22,	[sp, #1316]

    str	x14,	[sp, fp]

    movz	fp,	#3076
    ldr	w28,	[sp, #3304]

    lsl	w3,	w28,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#3068
    add	x1,	x16,	x3
    ldr	s5,	[x1]

    str	s5,	[sp, #1228]

    str	x10,	[sp, fp]

    movz	fp,	#3068
    ldr	w2,	[sp, #3304]

    lsl	w2,	w2,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#3060
    add	x5,	x12,	x2
    add	x2,	sp,	#196
    ldr	s27,	[x5]

    add	x5,	sp,	#292
    str	s27,	[sp, #1320]

    str	x6,	[sp, fp]

    movz	fp,	#3060
    ldr	w0,	[sp, #3304]

    lsl	w6,	w0,	#2
    ldr	x8,	[sp, fp]

    add	x0,	sp,	#220
    movz	fp,	#3052
    add	x9,	x8,	x6
    ldr	s1,	[x9]

    str	s1,	[sp, #1324]

    str	x2,	[sp, fp]

    movz	fp,	#3052
    ldr	w1,	[sp, #3304]

    lsl	w12,	w1,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#3044
    add	x13,	x3,	x12
    add	x12,	sp,	#328
    ldr	s5,	[x13]

    str	s5,	[sp, #1328]

    str	x4,	[sp, fp]

    movz	fp,	#3044
    ldr	w2,	[sp, #3304]

    lsl	w19,	w2,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#3036
    add	x17,	x6,	x19
    ldr	s10,	[x17]

    str	s10,	[sp, #1260]

    str	x0,	[sp, fp]

    movz	fp,	#3036
    ldr	w3,	[sp, #3304]

    lsl	w19,	w3,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3028
    add	x28,	x2,	x19
    add	x19,	sp,	#232
    ldr	s7,	[x28]

    str	s7,	[sp, #1284]

    str	x19,	[sp, fp]

    movz	fp,	#3028
    ldr	w0,	[sp, #3304]

    lsl	w1,	w0,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#3020
    add	x3,	x28,	x1
    add	x28,	sp,	#364
    ldr	s10,	[x3]

    str	s10,	[sp, #1332]

    str	x15,	[sp, fp]

    movz	fp,	#3020
    ldr	w1,	[sp, #3304]

    lsl	w0,	w1,	#2
    ldr	x17,	[sp, fp]

    add	x1,	sp,	#304
    movz	fp,	#3012
    add	x2,	x17,	x0
    add	x17,	sp,	#376
    ldr	s20,	[x2]

    str	s20,	[sp, #1336]

    str	x11,	[sp, fp]

    movz	fp,	#3012
    ldr	w2,	[sp, #3304]

    lsl	w4,	w2,	#2
    ldr	x13,	[sp, fp]

    movz	fp,	#3004
    add	x6,	x13,	x4
    add	x13,	sp,	#388
    ldr	s26,	[x6]

    str	s26,	[sp, #1244]

    str	x7,	[sp, fp]

    movz	fp,	#3004
    ldr	w3,	[sp, #3304]

    lsl	w10,	w3,	#2
    ldr	x8,	[sp, fp]

    add	x3,	sp,	#280
    movz	fp,	#2996
    add	x10,	x8,	x10
    ldr	s6,	[x10]

    str	s6,	[sp, #1256]

    str	x3,	[sp, fp]

    movz	fp,	#2996
    ldr	w4,	[sp, #3304]

    lsl	w14,	w4,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#2988
    add	x14,	x4,	x14
    ldr	s25,	[x14]

    str	s25,	[sp, #1340]

    str	x5,	[sp, fp]

    movz	fp,	#2988
    ldr	w5,	[sp, #3304]

    lsl	w18,	w5,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#2980
    add	x18,	x0,	x18
    add	x0,	sp,	#352
    ldr	s30,	[x18]

    str	s30,	[sp, #1344]

    str	x1,	[sp, fp]

    movz	fp,	#2980
    ldr	w6,	[sp, #3304]

    lsl	w26,	w6,	#2
    ldr	x3,	[sp, fp]

    add	x6,	sp,	#484
    movz	fp,	#2972
    add	x2,	x3,	x26
    ldr	s4,	[x2]

    str	s4,	[sp, #1348]

    str	x23,	[sp, fp]

    movz	fp,	#2972
    ldr	w7,	[sp, #3304]

    lsl	w4,	w7,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#2956
    add	x4,	x2,	x4
    ldr	s8,	[x4]

    add	x4,	sp,	#340
    str	s8,	[sp, #1352]

    str	x12,	[sp, fp]

    movz	fp,	#2956
    ldr	w8,	[sp, #3304]

    lsl	w2,	w8,	#2
    ldr	x14,	[sp, fp]

    movz	fp,	#2940
    add	x3,	x14,	x2
    ldr	s31,	[x3]

    add	x3,	sp,	#436
    str	s31,	[sp, #1276]

    str	x4,	[sp, fp]

    movz	fp,	#2940
    ldr	w9,	[sp, #3304]

    lsl	w8,	w9,	#2
    ldr	x5,	[sp, fp]

    add	x9,	sp,	#400
    movz	fp,	#2932
    add	x7,	x5,	x8
    add	x5,	sp,	#412
    ldr	s16,	[x7]

    str	s16,	[sp, #1356]

    str	x0,	[sp, fp]

    movz	fp,	#2932
    ldr	w10,	[sp, #3304]

    lsl	w12,	w10,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#2916
    add	x11,	x1,	x12
    ldr	s23,	[x11]

    str	s23,	[sp, #1360]

    str	x28,	[sp, fp]

    movz	fp,	#2916
    ldr	w11,	[sp, #3304]

    lsl	w15,	w11,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#2908
    add	x15,	x0,	x15
    ldr	s27,	[x15]

    str	s27,	[sp, #1272]

    str	x17,	[sp, fp]

    movz	fp,	#2908
    ldr	w12,	[sp, #3304]

    lsl	w20,	w12,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#2900
    add	x19,	x18,	x20
    ldr	s2,	[x19]

    str	s2,	[sp, #1224]

    str	x13,	[sp, fp]

    movz	fp,	#2900
    ldr	w13,	[sp, #3304]

    lsl	w1,	w13,	#2
    ldr	x15,	[sp, fp]

    movz	fp,	#2892
    add	x1,	x15,	x1
    ldr	s28,	[x1]

    add	x1,	sp,	#424
    str	s28,	[sp, #1364]

    str	x9,	[sp, fp]

    movz	fp,	#2892
    ldr	w14,	[sp, #3304]

    lsl	w0,	w14,	#2
    ldr	x11,	[sp, fp]

    add	x14,	sp,	#472
    movz	fp,	#2884
    add	x0,	x11,	x0
    ldr	s2,	[x0]

    str	s2,	[sp, #1368]

    str	x5,	[sp, fp]

    movz	fp,	#2884
    ldr	w15,	[sp, #3304]

    lsl	w4,	w15,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#2876
    add	x4,	x7,	x4
    ldr	s30,	[x4]

    str	s30,	[sp, #1248]

    str	x1,	[sp, fp]

    movz	fp,	#2876
    ldr	w16,	[sp, #3304]

    lsl	w10,	w16,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#2868
    add	x8,	x2,	x10
    add	x2,	sp,	#448
    ldr	s23,	[x8]

    str	s23,	[sp, #1268]

    str	x3,	[sp, fp]

    movz	fp,	#2868
    ldr	w17,	[sp, #3304]

    lsl	w13,	w17,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#2860
    add	x12,	x5,	x13
    ldr	s6,	[x12]

    str	s6,	[sp, #1372]

    str	x2,	[sp, fp]

    movz	fp,	#2860
    ldr	w18,	[sp, #3304]

    lsl	w18,	w18,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#2852
    add	x16,	x1,	x18
    add	x18,	sp,	#460
    ldr	s4,	[x16]

    str	s4,	[sp, #1280]

    str	x18,	[sp, fp]

    movz	fp,	#2852
    ldr	w19,	[sp, #3304]

    lsl	w0,	w19,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#2844
    add	x23,	x19,	x0
    ldr	s29,	[x23]

    str	s29,	[sp, #1220]

    str	x14,	[sp, fp]

    movz	fp,	#2844
    ldr	w23,	[sp, #3304]

    lsl	w3,	w23,	#2
    ldr	x16,	[sp, fp]

    movz	fp,	#2828
    add	x2,	x16,	x3
    ldr	s16,	[x2]

    str	s16,	[sp, #1236]

    str	x6,	[sp, fp]

    movz	fp,	#2828
    ldr	w28,	[sp, #3304]

    lsl	w2,	w28,	#2
    ldr	x8,	[sp, fp]

    add	x1,	x8,	x2
    ldr	s3,	[x1]

    str	s3,	[sp, #1252]

    ldr	s22,	[sp, #1292]

    str	s22,	[sp, #1112]

    ldr	s18,	[sp, #1232]

    str	s18,	[sp, #1888]

    ldr	s13,	[sp, #1296]

    ldr	s5,	[sp, #1300]

    fmov	s27,	s13
    ldr	s8,	[sp, #1304]

    fmov	s23,	s5
    ldr	s28,	[sp, #1264]

    fmov	s29,	s8
    ldr	s7,	[sp, #1240]

    fmov	s2,	s28
    ldr	s1,	[sp, #1216]

    fmov	s24,	s7
    ldr	s14,	[sp, #1212]

    fmov	s12,	s1
    ldr	s17,	[sp, #1308]

    fmov	s10,	s14
    str	s17,	[sp, #1484]

    ldr	s22,	[sp, #1312]

    str	s22,	[sp, #1100]

    ldr	s26,	[sp, #1316]

    ldr	s13,	[sp, #1228]

    fmov	s21,	s26
    str	s13,	[sp, #1508]

    ldr	s18,	[sp, #1320]

    ldr	s30,	[sp, #1324]

    fmov	s1,	s18
    str	s30,	[sp, #1516]

    ldr	s7,	[sp, #1328]

    str	s7,	[sp, #1524]

    ldr	s20,	[sp, #1260]

    str	s20,	[sp, #1384]

    ldr	s15,	[sp, #1284]

    str	s15,	[sp, #1380]

    ldr	s30,	[sp, #1332]

    str	s30,	[sp, #1388]

    ldr	s6,	[sp, #1336]

    str	s6,	[sp, #1392]

    ldr	s19,	[sp, #1244]

    str	s19,	[sp, #1400]

    ldr	s14,	[sp, #1256]

    str	s14,	[sp, #1396]

    ldr	s30,	[sp, #1340]

    str	s30,	[sp, #1532]

    ldr	s6,	[sp, #1344]

    str	s6,	[sp, #1536]

    ldr	s19,	[sp, #1348]

    fmov	s14,	s19
    str	s14,	[sp, #1540]

    ldr	s6,	[sp, #1352]

    fmov	s19,	s6
    str	s19,	[sp, #1544]

    ldr	s16,	[sp, #1276]

    fmov	s19,	s16
    str	s19,	[sp, #1908]

    ldr	s26,	[sp, #1356]

    fmov	s3,	s26
    str	s3,	[sp, #1560]

    ldr	s3,	[sp, #1360]

    fmov	s8,	s3
    str	s8,	[sp, #1564]

    ldr	s6,	[sp, #1272]

    fmov	s28,	s6
    str	s28,	[sp, #1880]

    ldr	s22,	[sp, #1224]

    fmov	s5,	s22
    str	s5,	[sp, #1884]

    ldr	s31,	[sp, #1364]

    fmov	s15,	s31
    str	s15,	[sp, #1120]

    ldr	s18,	[sp, #1368]

    fmov	s5,	s18
    str	s5,	[sp, #1080]

    ldr	s25,	[sp, #1248]

    fmov	s31,	s25
    str	s31,	[sp, #1136]

    ldr	s25,	[sp, #1268]

    fmov	s5,	s25
    str	s5,	[sp, #1148]

    ldr	s19,	[sp, #1372]

    fmov	s31,	s19
    str	s31,	[sp, #1160]

    ldr	s25,	[sp, #1280]

    str	s25,	[sp, #1168]

    ldr	s15,	[sp, #1220]

    str	s15,	[sp, #1176]

    ldr	s26,	[sp, #1236]

    str	s26,	[sp, #1180]

    ldr	s14,	[sp, #1252]

    str	s14,	[sp, #1196]


main_148:
    movi	v19.4s,	#0
    ldr	s25,	[sp, #1196]

    fcmp	s25,	s19
    beq	main_305

main_190:
    ldr	s8,	[sp, #1112]

    add	x1,	sp,	#784
    add	x26,	sp,	#788
    add	x0,	sp,	#792
    add	x19,	sp,	#800
    add	x20,	sp,	#804
    ldr	s15,	[sp, #1888]

    fadd	s13,	s8,	s15
    str	s13,	[sp, #1708]

    ldr	s14,	[sp, #1708]

    fadd	s8,	s14,	s27
    fadd	s14,	s29,	s2
    str	s8,	[sp, #1712]

    ldr	s9,	[sp, #1712]

    fadd	s13,	s9,	s23
    str	s13,	[sp, #1204]

    str	s14,	[sp, #1716]

    ldr	s15,	[sp, #1716]

    fadd	s9,	s15,	s24
    str	s9,	[sp, #1720]

    ldr	s13,	[sp, #1720]

    fadd	s15,	s13,	s12
    str	s15,	[sp, #1192]

    ldr	s14,	[sp, #1484]

    fadd	s9,	s10,	s14
    str	s9,	[sp, #1724]

    ldr	s8,	[sp, #1724]

    ldr	s13,	[sp, #1100]

    fadd	s13,	s8,	s13
    str	s13,	[sp, #1728]

    ldr	s14,	[sp, #1728]

    fadd	s13,	s14,	s21
    str	s13,	[sp, #1608]

    ldr	s8,	[sp, #1508]

    fadd	s12,	s8,	s1
    str	s12,	[sp, #1692]

    ldr	s15,	[sp, #1516]

    ldr	s13,	[sp, #1692]

    fadd	s15,	s13,	s15
    str	s15,	[sp, #1696]

    ldr	s15,	[sp, #1524]

    ldr	s8,	[sp, #1696]

    fadd	s9,	s8,	s15
    str	s9,	[sp, #1604]

    ldr	s14,	[sp, #1380]

    ldr	s9,	[sp, #1384]

    fadd	s13,	s9,	s14
    str	s13,	[sp, #1656]

    ldr	s10,	[sp, #1388]

    ldr	s14,	[sp, #1656]

    fadd	s8,	s14,	s10
    str	s8,	[sp, #1660]

    ldr	s10,	[sp, #1392]

    ldr	s9,	[sp, #1660]

    fadd	s14,	s9,	s10
    str	s14,	[sp, #1600]

    ldr	s9,	[sp, #1396]

    ldr	s8,	[sp, #1400]

    fadd	s12,	s8,	s9
    str	s12,	[sp, #1640]

    ldr	s15,	[sp, #1532]

    ldr	s13,	[sp, #1640]

    fadd	s15,	s13,	s15
    str	s15,	[sp, #1644]

    ldr	s14,	[sp, #1536]

    ldr	s8,	[sp, #1644]

    fadd	s10,	s8,	s14
    str	s10,	[sp, #1596]

    ldr	s13,	[sp, #1540]

    ldr	s8,	[sp, #1544]

    fadd	s12,	s13,	s8
    str	s12,	[sp, #1628]

    ldr	s10,	[sp, #1628]

    ldr	s8,	[sp, #1908]

    fadd	s15,	s10,	s8
    str	s15,	[sp, #1632]

    ldr	s14,	[sp, #1560]

    ldr	s8,	[sp, #1632]

    fadd	s12,	s8,	s14
    str	s12,	[sp, #1588]

    ldr	s12,	[sp, #1564]

    ldr	s14,	[sp, #1880]

    fadd	s10,	s12,	s14
    ldr	s12,	[sp, #1884]

    fadd	s8,	s10,	s12
    str	s8,	[sp, #1612]

    ldr	s12,	[sp, #1120]

    ldr	s13,	[sp, #1612]

    fadd	s8,	s13,	s12
    str	s8,	[sp, #1584]

    ldr	s12,	[sp, #1080]

    ldr	s8,	[sp, #1136]

    fadd	s12,	s12,	s8
    ldr	s8,	[sp, #1148]

    fadd	s12,	s12,	s8
    str	s12,	[sp, #1616]

    ldr	s12,	[sp, #1160]

    ldr	s8,	[sp, #1616]

    fadd	s15,	s8,	s12
    str	s15,	[sp, #1592]

    ldr	s15,	[sp, #1168]

    ldr	s10,	[sp, #1176]

    fadd	s15,	s15,	s10
    str	s15,	[sp, #1620]

    ldr	s12,	[sp, #1180]

    ldr	s13,	[sp, #1620]

    ldr	s8,	[sp, #1196]

    fadd	s10,	s13,	s12
    fadd	s15,	s10,	s8
    str	s15,	[sp, #1376]

    ldr	s10,	[sp, #1204]

    str	s10,	[x1]

    ldr	s8,	[sp, #1192]

    str	s8,	[x26]

    add	x26,	sp,	#808
    ldr	s14,	[sp, #1608]

    str	s14,	[x0]

    ldr	s10,	[sp, #1604]

    add	x0,	sp,	#796
    str	s10,	[x0]

    add	x0,	sp,	#812
    ldr	s15,	[sp, #1600]

    str	s15,	[x19]

    add	x19,	sp,	#820
    ldr	s12,	[sp, #1596]

    str	s12,	[x20]

    ldr	s13,	[sp, #1588]

    str	s13,	[x26]

    ldr	s9,	[sp, #1584]

    str	s9,	[x0]

    ldr	s8,	[sp, #1592]

    add	x0,	sp,	#816
    str	s8,	[x0]

    movz	w0,	#10
    ldr	s8,	[sp, #1376]

    str	s8,	[x19]

    bl	putfarray
    add	x20,	sp,	#616
    add	x9,	sp,	#496
    add	x21,	sp,	#700
    add	x17,	sp,	#544
    add	x11,	sp,	#772
    ldr	w2,	[sp, #3304]

    movz	fp,	#3244
    add	x7,	sp,	#508
    lsl	w19,	w2,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#784
    ldr	s13,	[x18]

    str	s13,	[sp, #1288]

    str	x11,	[sp, fp]

    movz	fp,	#3244
    ldr	w0,	[sp, #3304]

    lsl	w4,	w0,	#2
    ldr	x13,	[sp, fp]

    add	x0,	sp,	#520
    movz	fp,	#3228
    add	x2,	x13,	x4
    ldr	w4,	[x2]

    str	w4,	[sp, #2360]

    ldr	w5,	[sp, #3304]

    lsl	w3,	w5,	#2
    add	x1,	x0,	x3
    add	x3,	sp,	#568
    ldr	w5,	[x1]

    str	w5,	[sp, #3300]

    str	x3,	[sp, fp]

    movz	fp,	#3228
    ldr	w2,	[sp, #3304]

    lsl	w5,	w2,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#3236
    add	x0,	x4,	x5
    add	x4,	sp,	#556
    add	x5,	sp,	#760
    ldr	w18,	[x0]

    str	w18,	[sp, #2304]

    str	x7,	[sp, fp]

    movz	fp,	#3236
    ldr	w3,	[sp, #3304]

    lsl	w15,	w3,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3220
    add	x2,	x8,	x15
    ldr	w6,	[x2]

    str	w6,	[sp, #3272]

    ldr	w6,	[sp, #3304]

    lsl	w1,	w6,	#2
    add	x16,	x17,	x1
    ldr	w18,	[x16]

    str	w18,	[sp, #3284]

    ldr	w8,	[sp, #3304]

    lsl	w16,	w8,	#2
    add	x3,	x4,	x16
    add	x16,	sp,	#724
    ldr	w10,	[x3]

    str	w10,	[sp, #3276]

    str	x5,	[sp, fp]

    movz	fp,	#3220
    ldr	w0,	[sp, #3304]

    lsl	w2,	w0,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3124
    add	x18,	x0,	x2
    ldr	w10,	[x18]

    str	w10,	[sp, #6156]

    str	x9,	[sp, fp]

    movz	fp,	#3124
    ldr	w1,	[sp, #3304]

    lsl	w1,	w1,	#2
    ldr	x14,	[sp, fp]

    movz	fp,	#3196
    add	x4,	x14,	x1
    ldr	w1,	[x4]

    str	w1,	[sp, #3296]

    str	x16,	[sp, fp]

    movz	fp,	#3196
    ldr	w2,	[sp, #3304]

    lsl	w12,	w2,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#3100
    add	x10,	x4,	x12
    add	x4,	sp,	#580
    ldr	w12,	[x10]

    str	w12,	[sp, #1976]

    str	x4,	[sp, fp]

    movz	fp,	#3100
    ldr	w3,	[sp, #3304]

    lsl	w10,	w3,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3084
    add	x8,	x0,	x10
    ldr	w3,	[x8]

    add	x8,	sp,	#592
    str	w3,	[sp, #2116]

    add	x3,	sp,	#736
    str	x20,	[sp, fp]

    movz	fp,	#3084
    ldr	w4,	[sp, #3304]

    lsl	w1,	w4,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#3108
    add	x6,	x5,	x1
    add	x1,	sp,	#652
    ldr	w7,	[x6]

    str	w7,	[sp, #6152]

    str	x1,	[sp, fp]

    movz	fp,	#3108
    ldr	w5,	[sp, #3304]

    lsl	w6,	w5,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#2964
    add	x4,	x4,	x6
    ldr	w4,	[x4]

    str	w4,	[sp, #6148]

    ldr	w19,	[sp, #3304]

    lsl	w6,	w19,	#2
    add	x8,	x8,	x6
    ldr	w6,	[x8]

    add	x8,	sp,	#688
    str	w6,	[sp, #3264]

    ldr	w20,	[sp, #3304]

    lsl	w15,	w20,	#2
    add	x20,	sp,	#640
    add	x21,	x21,	x15
    ldr	w1,	[x21]

    str	w1,	[sp, #3288]

    ldr	w23,	[sp, #3304]

    add	x1,	sp,	#712
    lsl	w4,	w23,	#2
    add	x28,	x1,	x4
    add	x4,	sp,	#628
    add	x1,	sp,	#604
    ldr	w16,	[x28]

    str	w16,	[sp, #3280]

    ldr	w0,	[sp, #3304]

    lsl	w16,	w0,	#2
    add	x2,	x1,	x16
    ldr	w1,	[x2]

    str	w1,	[sp, #3256]

    str	x20,	[sp, fp]

    movz	fp,	#2964
    ldr	w12,	[sp, #3304]

    lsl	w7,	w12,	#2
    ldr	x23,	[sp, fp]

    movz	fp,	#2924
    add	x6,	x23,	x7
    ldr	w2,	[x6]

    str	w2,	[sp, #5500]

    str	x4,	[sp, fp]

    movz	fp,	#2924
    ldr	w14,	[sp, #3304]

    lsl	w21,	w14,	#2
    ldr	x4,	[sp, fp]

    add	x14,	sp,	#532
    movz	fp,	#2948
    add	x16,	x4,	x21
    ldr	w12,	[x16]

    str	w12,	[sp, #5468]

    str	x8,	[sp, fp]

    movz	fp,	#2948
    ldr	w15,	[sp, #3304]

    lsl	w1,	w15,	#2
    ldr	x11,	[sp, fp]

    movz	fp,	#2836
    add	x6,	x11,	x1
    add	x1,	sp,	#748
    ldr	w19,	[x6]

    str	w19,	[sp, #7992]

    str	x14,	[sp, fp]

    movz	fp,	#2836
    ldr	w18,	[sp, #3304]

    lsl	w4,	w18,	#2
    ldr	x12,	[sp, fp]

    add	x18,	sp,	#664
    movz	fp,	#2820
    add	x2,	x12,	x4
    ldr	w7,	[x2]

    str	w7,	[sp, #3292]

    ldr	w4,	[sp, #3304]

    lsl	w23,	w4,	#2
    add	x11,	x1,	x23
    ldr	w2,	[x11]

    str	w2,	[sp, #3268]

    ldr	w5,	[sp, #3304]

    lsl	w2,	w5,	#2
    add	x3,	x3,	x2
    add	x2,	sp,	#676
    ldr	w4,	[x3]

    str	w4,	[sp, #3260]

    str	x2,	[sp, fp]

    movz	fp,	#2820
    ldr	w2,	[sp, #3304]

    lsl	w11,	w2,	#2
    ldr	x0,	[sp, fp]

    add	x7,	x0,	x11
    ldr	w2,	[x7]

    str	w2,	[sp, #9124]

    ldr	w7,	[sp, #3304]

    lsl	w1,	w7,	#2
    add	x19,	x18,	x1
    ldr	w23,	[x19]

    str	w23,	[sp, #3252]

    ldr	w6,	[sp, #2360]

    mov	w2,	w6
    str	w2,	[sp, #2324]

    ldr	w6,	[sp, #3300]

    mov	w2,	w6
    str	w2,	[sp, #8000]

    ldr	w5,	[sp, #2304]

    mov	w17,	w5
    str	w17,	[sp, #5472]

    ldr	s4,	[sp, #1304]

    ldr	w7,	[sp, #3272]

    fmov	s13,	s4
    mov	w28,	w7
    str	w28,	[sp, #5476]

    ldr	w14,	[sp, #3284]

    mov	w4,	w14
    str	w4,	[sp, #6560]

    ldr	w21,	[sp, #3276]

    mov	w9,	w21
    str	w9,	[sp, #6564]

    ldr	s29,	[sp, #1212]

    str	s29,	[sp, #1480]

    ldr	s7,	[sp, #1328]

    str	s7,	[sp, #1748]

    ldr	s28,	[sp, #1216]

    ldr	w14,	[sp, #6156]

    fmov	s25,	s28
    mov	w20,	w14
    str	w20,	[sp, #2276]

    ldr	s3,	[sp, #1300]

    ldr	s17,	[sp, #1360]

    fmov	s22,	s3
    str	s17,	[sp, #1772]

    ldr	w2,	[sp, #3296]

    mov	w23,	w2
    str	w23,	[sp, #7996]

    ldr	s29,	[sp, #1220]

    str	s29,	[sp, #1780]

    ldr	w4,	[sp, #1976]

    mov	w23,	w4
    str	w23,	[sp, #2232]

    ldr	s23,	[sp, #1224]

    str	s23,	[sp, #1776]

    ldr	s8,	[sp, #1228]

    fmov	s6,	s8
    str	s6,	[sp, #1704]

    ldr	s27,	[sp, #1232]

    ldr	s4,	[sp, #1316]

    fmov	s5,	s27
    str	s4,	[sp, #1740]

    ldr	s15,	[sp, #1236]

    str	s15,	[sp, #1420]

    ldr	s4,	[sp, #1240]

    ldr	w23,	[sp, #2116]

    fmov	s24,	s4
    mov	w19,	w23
    str	w19,	[sp, #6572]

    ldr	s9,	[sp, #1368]

    str	s9,	[sp, #1416]

    ldr	w28,	[sp, #6152]

    mov	w21,	w28
    str	w21,	[sp, #5492]

    ldr	w19,	[sp, #6148]

    mov	w10,	w19
    str	w10,	[sp, #5504]

    ldr	s3,	[sp, #1244]

    str	s3,	[sp, #1760]

    ldr	s31,	[sp, #1248]

    str	s31,	[sp, #1096]

    ldr	s9,	[sp, #1344]

    str	s9,	[sp, #1764]

    ldr	s12,	[sp, #1308]

    ldr	s26,	[sp, #1352]

    fmov	s23,	s12
    str	s26,	[sp, #1768]

    ldr	w6,	[sp, #3264]

    mov	w7,	w6
    str	w7,	[sp, #5460]

    ldr	s12,	[sp, #1252]

    str	s12,	[sp, #1132]

    ldr	w2,	[sp, #3288]

    mov	w0,	w2
    str	w0,	[sp, #2104]

    ldr	s12,	[sp, #1256]

    fmov	s4,	s12
    str	s4,	[sp, #1756]

    ldr	s12,	[sp, #1260]

    fmov	s30,	s12
    str	s30,	[sp, #1752]

    ldr	s21,	[sp, #1264]

    ldr	s31,	[sp, #1268]

    fmov	s6,	s21
    str	s31,	[sp, #1140]

    ldr	w0,	[sp, #3280]

    str	w0,	[sp, #1980]

    ldr	w18,	[sp, #3256]

    mov	w14,	w18
    str	w14,	[sp, #5464]

    ldr	s31,	[sp, #1324]

    fmov	s15,	s31
    str	s15,	[sp, #1744]

    ldr	s8,	[sp, #1312]

    ldr	s10,	[sp, #1292]

    fmov	s3,	s8
    ldr	w7,	[sp, #5500]

    fmov	s2,	s10
    mov	w10,	w7
    str	w10,	[sp, #5480]

    ldr	s14,	[sp, #1364]

    str	s14,	[sp, #1124]

    ldr	w21,	[sp, #5468]

    mov	w0,	w21
    str	w0,	[sp, #5456]

    ldr	w20,	[sp, #7992]

    mov	w10,	w20
    str	w10,	[sp, #5496]

    ldr	s16,	[sp, #1356]

    fmov	s27,	s16
    str	s27,	[sp, #1092]

    ldr	s20,	[sp, #1348]

    ldr	s17,	[sp, #1320]

    fmov	s21,	s20
    ldr	s28,	[sp, #1272]

    str	s28,	[sp, #1128]

    ldr	w28,	[sp, #3292]

    ldr	w10,	[sp, #3268]

    mov	w11,	w28
    mov	w0,	w10
    str	w0,	[sp, #6144]

    ldr	w0,	[sp, #3260]

    str	w0,	[sp, #5508]

    ldr	s30,	[sp, #1332]

    ldr	s12,	[sp, #1336]

    fmov	s10,	s30
    ldr	s31,	[sp, #1340]

    fmov	s14,	s12
    fmov	s16,	s31
    str	s16,	[sp, #1896]

    ldr	s1,	[sp, #1276]

    fmov	s7,	s1
    str	s7,	[sp, #1104]

    ldr	s16,	[sp, #1280]

    str	s16,	[sp, #1164]

    ldr	s31,	[sp, #1284]

    ldr	w3,	[sp, #9124]

    fmov	s7,	s31
    mov	w0,	w3
    str	w0,	[sp, #8016]

    ldr	s19,	[sp, #1296]

    str	s19,	[sp, #1108]

    ldr	w0,	[sp, #3252]

    mov	w15,	w0
    str	w15,	[sp, #6568]

    ldr	s8,	[sp, #1372]

    str	s8,	[sp, #1156]


main_309:
    ldr	w2,	[sp, #2324]

    cmp	w2,	#0
    beq	main_308

main_375:
    fadd	s9,	s2,	s5
    ldr	s11,	[sp, #1108]

    fadd	s13,	s13,	s6
    add	x0,	sp,	#944
    add	x27,	sp,	#956
    movz	fp,	#3996
    fadd	s12,	s9,	s11
    fadd	s15,	s13,	s24
    fadd	s12,	s12,	s22
    fadd	s9,	s15,	s25
    str	s12,	[sp, #1208]

    str	s9,	[sp, #1200]

    ldr	s15,	[sp, #1480]

    ldr	s13,	[sp, #1740]

    fadd	s15,	s15,	s23
    fadd	s9,	s15,	s3
    fadd	s11,	s9,	s13
    str	s11,	[sp, #1188]

    ldr	s8,	[sp, #1704]

    ldr	s9,	[sp, #1744]

    fadd	s8,	s8,	s17
    fadd	s13,	s8,	s9
    ldr	s8,	[sp, #1748]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1172]

    ldr	s15,	[sp, #1752]

    fadd	s9,	s15,	s7
    fadd	s13,	s9,	s10
    fadd	s10,	s13,	s14
    str	s10,	[sp, #1444]

    ldr	s12,	[sp, #1756]

    ldr	s8,	[sp, #1760]

    fadd	s15,	s8,	s12
    ldr	s8,	[sp, #1896]

    ldr	s14,	[sp, #1764]

    fadd	s13,	s15,	s8
    fadd	s14,	s13,	s14
    str	s14,	[sp, #1440]

    ldr	s11,	[sp, #1768]

    ldr	s10,	[sp, #1104]

    fadd	s13,	s21,	s11
    ldr	s15,	[sp, #1092]

    fadd	s14,	s13,	s10
    fadd	s12,	s14,	s15
    str	s12,	[sp, #1892]

    ldr	s11,	[sp, #1128]

    ldr	s8,	[sp, #1772]

    ldr	s13,	[sp, #1776]

    fadd	s15,	s8,	s11
    fadd	s15,	s15,	s13
    ldr	s13,	[sp, #1124]

    ldr	s10,	[sp, #1096]

    fadd	s13,	s15,	s13
    ldr	s15,	[sp, #1416]

    fadd	s9,	s15,	s10
    str	s9,	[sp, #1468]

    ldr	s9,	[sp, #1140]

    ldr	s10,	[sp, #1468]

    fadd	s14,	s10,	s9
    str	s14,	[sp, #1456]

    ldr	s11,	[sp, #1156]

    ldr	s15,	[sp, #1456]

    fadd	s11,	s15,	s11
    str	s11,	[sp, #1436]

    ldr	s9,	[sp, #1164]

    ldr	s10,	[sp, #1780]

    ldr	s12,	[sp, #1420]

    fadd	s8,	s9,	s10
    ldr	s11,	[sp, #1132]

    fadd	s15,	s8,	s12
    str	x0,	[sp, #1848]

    fadd	s8,	s15,	s11
    add	x0,	sp,	#948
    ldr	s11,	[sp, #1208]

    ldr	x28,	[sp, #1848]

    str	s11,	[x28]

    ldr	s9,	[sp, #1200]

    str	s9,	[x0]

    ldr	s11,	[sp, #1188]

    add	x0,	sp,	#952
    str	s11,	[x0]

    add	x0,	sp,	#960
    ldr	s12,	[sp, #1172]

    str	s12,	[x27]

    add	x27,	sp,	#968
    ldr	s11,	[sp, #1444]

    str	s11,	[x0]

    ldr	s15,	[sp, #1440]

    add	x0,	sp,	#964
    str	s15,	[x0]

    add	x0,	sp,	#972
    ldr	s15,	[sp, #1892]

    str	s15,	[x27]

    add	x27,	sp,	#980
    str	s13,	[x0]

    ldr	s12,	[sp, #1436]

    add	x0,	sp,	#976
    str	s12,	[x0]

    str	s8,	[x27]

    ldr	w28,	[sp, #5476]

    ldr	w25,	[sp, #8000]

    ldr	w0,	[sp, #7996]

    add	w28,	w28,	w25
    add	w25,	w28,	w0
    str	w25,	[sp, #5000]

    ldr	w0,	[sp, #6560]

    ldr	w23,	[sp, #6564]

    add	w1,	w23,	w0
    add	w20,	w1,	w11
    str	w20,	[sp, #2120]

    ldr	w1,	[sp, #5472]

    ldr	w21,	[sp, #6572]

    ldr	w0,	[sp, #5460]

    add	w1,	w21,	w1
    add	x21,	sp,	#988
    add	w1,	w1,	w0
    str	w1,	[sp, #2124]

    ldr	w18,	[sp, #5464]

    ldr	w27,	[sp, #5492]

    add	w0,	w18,	w27
    ldr	w18,	[sp, #5456]

    add	w0,	w0,	w18
    str	w0,	[sp, #5052]

    ldr	w25,	[sp, #5480]

    ldr	w0,	[sp, #5504]

    ldr	w28,	[sp, #6568]

    add	w1,	w25,	w0
    add	w19,	w1,	w28
    str	w19,	[sp, #1792]

    ldr	w26,	[sp, #2104]

    ldr	w23,	[sp, #5496]

    ldr	w1,	[sp, #8016]

    add	w0,	w23,	w26
    add	w0,	w0,	w1
    str	w0,	[sp, #1932]

    ldr	w1,	[sp, #1980]

    ldr	w27,	[sp, #2232]

    add	w26,	w1,	w27
    ldr	w27,	[sp, #5508]

    add	w1,	w26,	w27
    str	w1,	[sp, #2060]

    ldr	w0,	[sp, #2276]

    ldr	w18,	[sp, #2324]

    ldr	w27,	[sp, #6144]

    add	w1,	w0,	w18
    add	w0,	w1,	w27
    add	x27,	sp,	#996
    str	w0,	[sp, #2064]

    add	x0,	sp,	#984
    str	x0,	[sp, #4896]

    ldr	x1,	[sp, #4896]

    ldr	w23,	[sp, #5000]

    str	w23,	[x1]

    str	x21,	[sp, fp]

    movz	fp,	#3996
    ldr	w23,	[sp, #2120]

    ldr	x22,	[sp, fp]

    movz	fp,	#3508
    str	w23,	[x22]

    add	x22,	sp,	#992
    str	x22,	[sp, fp]

    add	x22,	sp,	#1004
    movz	fp,	#3508
    ldr	w28,	[sp, #2124]

    ldr	x25,	[sp, fp]

    movz	fp,	#3524
    str	w28,	[x25]

    str	x27,	[sp, fp]

    movz	fp,	#3524
    ldr	x27,	[sp, fp]

    ldr	w23,	[sp, #5052]

    str	w23,	[x27]

    add	x27,	sp,	#1000
    str	x27,	[sp, #4904]

    ldr	w24,	[sp, #1792]

    ldr	x1,	[sp, #4904]

    str	w24,	[x1]

    str	x22,	[sp, #2128]

    add	x22,	sp,	#1012
    ldr	w1,	[sp, #1932]

    ldr	x25,	[sp, #2128]

    str	w1,	[x25]

    add	x1,	sp,	#1008
    str	x1,	[sp, #2160]

    ldr	w18,	[sp, #2060]

    ldr	x21,	[sp, #2160]

    str	w18,	[x21]

    str	x22,	[sp, #2176]

    ldr	w0,	[sp, #2064]

    ldr	x25,	[sp, #2176]

    str	w0,	[x25]

    ldr	x1,	[sp, #1848]

    movz	w0,	#10
    bl	putfarray
    ldr	x1,	[sp, #4896]

    movz	w0,	#8
    bl	putarray
    ldr	w14,	[sp, #5000]

    movz	fp,	#3996
    ldr	s28,	[sp, #1208]

    scvtf	s6,	w14
    ldr	x15,	[sp, #4896]

    fsub	s6,	s6,	s28
    fcvtzs	w0,	s6
    str	w0,	[x15]

    ldr	w10,	[sp, #2120]

    ldr	s21,	[sp, #1200]

    scvtf	s8,	w10
    ldr	x27,	[sp, fp]

    fsub	s2,	s8,	s21
    movz	fp,	#3508
    fcvtzs	w3,	s2
    str	w3,	[x27]

    ldr	w14,	[sp, #2124]

    ldr	s5,	[sp, #1188]

    scvtf	s4,	w14
    ldr	x19,	[sp, fp]

    fsub	s20,	s4,	s5
    movz	fp,	#3524
    fcvtzs	w6,	s20
    str	w6,	[x19]

    ldr	w13,	[sp, #5052]

    ldr	s12,	[sp, #1172]

    scvtf	s22,	w13
    ldr	x5,	[sp, fp]

    fsub	s7,	s22,	s12
    movz	fp,	#3212
    fcvtzs	w11,	s7
    str	w11,	[x5]

    ldr	w18,	[sp, #1792]

    ldr	s12,	[sp, #1444]

    scvtf	s10,	w18
    ldr	x19,	[sp, #4904]

    fsub	s10,	s10,	s12
    fcvtzs	w12,	s10
    str	w12,	[x19]

    ldr	w28,	[sp, #1932]

    ldr	s8,	[sp, #1440]

    scvtf	s16,	w28
    ldr	x15,	[sp, #2128]

    fsub	s15,	s16,	s8
    fcvtzs	w16,	s15
    str	w16,	[x15]

    ldr	w1,	[sp, #2060]

    ldr	s21,	[sp, #1892]

    scvtf	s17,	w1
    ldr	x11,	[sp, #2160]

    fsub	s10,	s17,	s21
    fcvtzs	w20,	s10
    str	w20,	[x11]

    ldr	w5,	[sp, #2064]

    ldr	x22,	[sp, #2176]

    scvtf	s14,	w5
    fsub	s11,	s14,	s13
    fcvtzs	w2,	s11
    str	w2,	[x22]

    ldr	w18,	[sp, #3304]

    lsl	w4,	w18,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#984
    ldr	w5,	[x3]

    ldr	x3,	[sp, fp]

    scvtf	s11,	w5
    movz	fp,	#3204
    mov	x4,	x3
    str	x4,	[sp, #2192]

    ldr	x28,	[sp, fp]

    movz	fp,	#2700
    mov	x0,	x28
    str	x0,	[sp, fp]

    movz	fp,	#3188
    ldr	x14,	[sp, fp]

    movz	fp,	#3180
    mov	x17,	x14
    ldr	x10,	[sp, fp]

    movz	fp,	#3172
    mov	x26,	x10
    ldr	x6,	[sp, fp]

    movz	fp,	#3164
    mov	x12,	x6
    str	x12,	[sp, #4944]

    ldr	x2,	[sp, fp]

    movz	fp,	#2708
    mov	x4,	x2
    str	x4,	[sp, fp]

    movz	fp,	#3156
    ldr	x6,	[sp, fp]

    movz	fp,	#2716
    mov	x8,	x6
    str	x8,	[sp, fp]

    movz	fp,	#3148
    ldr	x2,	[sp, fp]

    movz	fp,	#2724
    mov	x12,	x2
    str	x12,	[sp, fp]

    movz	fp,	#3140
    ldr	x27,	[sp, fp]

    movz	fp,	#2732
    mov	x16,	x27
    str	x16,	[sp, fp]

    movz	fp,	#3132
    ldr	x15,	[sp, fp]

    movz	fp,	#3116
    str	x15,	[sp, #4952]

    ldr	x7,	[sp, fp]

    movz	fp,	#3092
    mov	x19,	x7
    str	x19,	[sp, #4960]

    ldr	x2,	[sp, fp]

    movz	fp,	#3076
    mov	x3,	x2
    str	x3,	[sp, #4976]

    ldr	x16,	[sp, fp]

    movz	fp,	#2740
    mov	x1,	x16
    str	x1,	[sp, fp]

    movz	fp,	#3068
    ldr	x12,	[sp, fp]

    movz	fp,	#3060
    mov	x11,	x12
    ldr	x8,	[sp, fp]

    movz	fp,	#3052
    mov	x6,	x8
    str	x6,	[sp, #4984]

    ldr	x4,	[sp, fp]

    movz	fp,	#3044
    mov	x9,	x4
    str	x9,	[sp, #4992]

    ldr	x0,	[sp, fp]

    movz	fp,	#2748
    mov	x4,	x0
    str	x4,	[sp, fp]

    movz	fp,	#3036
    ldr	x4,	[sp, fp]

    movz	fp,	#2756
    mov	x8,	x4
    str	x8,	[sp, fp]

    movz	fp,	#3028
    ldr	x1,	[sp, fp]

    movz	fp,	#5004
    mov	x18,	x1
    str	x18,	[sp, fp]

    movz	fp,	#3020
    ldr	x23,	[sp, fp]

    movz	fp,	#5012
    mov	x21,	x23
    add	x23,	sp,	#920
    str	x21,	[sp, fp]

    movz	fp,	#3012
    ldr	x16,	[sp, fp]

    movz	fp,	#2764
    mov	x4,	x16
    str	x4,	[sp, fp]

    movz	fp,	#3004
    ldr	x10,	[sp, fp]

    movz	fp,	#2772
    mov	x8,	x10
    str	x8,	[sp, fp]

    movz	fp,	#2996
    ldr	x6,	[sp, fp]

    movz	fp,	#5020
    mov	x1,	x6
    str	x1,	[sp, fp]

    movz	fp,	#2988
    ldr	x2,	[sp, fp]

    movz	fp,	#5028
    str	x2,	[sp, fp]

    add	x2,	sp,	#912
    movz	fp,	#2980
    ldr	x8,	[sp, fp]

    movz	fp,	#5036
    mov	x5,	x8
    str	x5,	[sp, fp]

    movz	fp,	#2972
    ldr	x4,	[sp, fp]

    movz	fp,	#5044
    mov	x8,	x4
    str	x8,	[sp, fp]

    add	x8,	sp,	#940
    movz	fp,	#2956
    ldr	x20,	[sp, fp]

    movz	fp,	#2780
    mov	x14,	x20
    str	x14,	[sp, fp]

    movz	fp,	#2940
    ldr	x7,	[sp, fp]

    movz	fp,	#2932
    mov	x16,	x7
    str	x16,	[sp, #5056]

    ldr	x3,	[sp, fp]

    movz	fp,	#2916
    mov	x20,	x3
    str	x20,	[sp, #5064]

    ldr	x10,	[sp, fp]

    movz	fp,	#2788
    mov	x4,	x10
    str	x4,	[sp, fp]

    movz	fp,	#2908
    ldr	x3,	[sp, fp]

    movz	fp,	#2796
    str	x3,	[sp, fp]

    movz	fp,	#2900
    ldr	x4,	[sp, fp]

    movz	fp,	#2892
    mov	x27,	x4
    str	x27,	[sp, #5072]

    add	x27,	sp,	#916
    ldr	x21,	[sp, fp]

    movz	fp,	#2884
    mov	x1,	x21
    str	x1,	[sp, #5080]

    ldr	x16,	[sp, fp]

    movz	fp,	#2804
    mov	x20,	x16
    str	x20,	[sp, fp]

    movz	fp,	#2876
    ldr	x9,	[sp, fp]

    movz	fp,	#2812
    mov	x0,	x9
    str	x0,	[sp, fp]

    movz	fp,	#2868
    ldr	x9,	[sp, fp]

    movz	fp,	#2860
    mov	x7,	x9
    str	x7,	[sp, #5096]

    ldr	x24,	[sp, fp]

    movz	fp,	#2852
    mov	x10,	x24
    add	x24,	sp,	#908
    str	x10,	[sp, #5104]

    ldr	x20,	[sp, fp]

    movz	fp,	#2844
    mov	x14,	x20
    mov	x20,	x26
    str	x14,	[sp, #5112]

    ldr	x19,	[sp, fp]

    movz	fp,	#2828
    mov	x18,	x19
    str	x18,	[sp, #5120]

    ldr	x28,	[sp, fp]

    movz	fp,	#2660
    mov	x1,	x28
    add	x28,	sp,	#904
    str	x1,	[sp, #5136]

    str	x28,	[sp, fp]

    add	x28,	sp,	#924
    movz	fp,	#2492
    str	x24,	[sp, fp]

    add	x24,	sp,	#932
    movz	fp,	#2500
    str	x2,	[sp, fp]

    add	x2,	sp,	#936
    movz	fp,	#2524
    str	x27,	[sp, #2512]

    str	x23,	[sp, fp]

    movz	fp,	#2532
    str	x28,	[sp, fp]

    movz	fp,	#1036
    add	x28,	sp,	#928
    str	x28,	[sp, #1016]

    str	x24,	[sp, #1024]

    str	x2,	[sp, fp]

    movz	fp,	#1044
    str	x8,	[sp, fp]

    movz	fp,	#5484
    ldr	x5,	[sp, #2192]

    mov	x8,	x5
    str	x8,	[sp, fp]

    mov	x8,	x17
    movz	fp,	#2700
    ldr	x16,	[sp, fp]

    movz	fp,	#2620
    mov	x14,	x16
    str	x14,	[sp, fp]

    movz	fp,	#2596
    str	x8,	[sp, fp]

    movz	fp,	#2580
    str	x20,	[sp, fp]

    movz	fp,	#1060
    ldr	x14,	[sp, #4944]

    mov	x20,	x14
    str	x20,	[sp, fp]

    movz	fp,	#2708
    ldr	x26,	[sp, fp]

    movz	fp,	#2716
    mov	x12,	x26
    str	x12,	[sp, #1072]

    ldr	x12,	[sp, fp]

    movz	fp,	#2724
    mov	x27,	x12
    str	x27,	[sp, #2552]

    mov	x27,	x11
    ldr	x8,	[sp, fp]

    movz	fp,	#2732
    mov	x23,	x8
    str	x23,	[sp, #2560]

    ldr	x24,	[sp, fp]

    movz	fp,	#1052
    mov	x8,	x24
    str	x8,	[sp, #2568]

    ldr	x17,	[sp, #4952]

    mov	x19,	x17
    str	x19,	[sp, fp]

    movz	fp,	#2476
    ldr	x20,	[sp, #4960]

    mov	x26,	x20
    str	x26,	[sp, fp]

    movz	fp,	#2740
    ldr	x4,	[sp, #4976]

    mov	x23,	x4
    str	x23,	[sp, #2456]

    ldr	x8,	[sp, fp]

    movz	fp,	#2468
    str	x8,	[sp, fp]

    movz	fp,	#2444
    str	x27,	[sp, fp]

    movz	fp,	#2428
    ldr	x7,	[sp, #4984]

    mov	x19,	x7
    str	x19,	[sp, fp]

    movz	fp,	#2404
    ldr	x10,	[sp, #4992]

    mov	x17,	x10
    str	x17,	[sp, fp]

    movz	fp,	#2748
    ldr	x15,	[sp, fp]

    movz	fp,	#2412
    mov	x18,	x15
    str	x18,	[sp, fp]

    movz	fp,	#2756
    ldr	x8,	[sp, fp]

    movz	fp,	#2420
    mov	x25,	x8
    str	x25,	[sp, fp]

    movz	fp,	#5004
    ldr	x17,	[sp, fp]

    movz	fp,	#2396
    mov	x25,	x17
    str	x25,	[sp, fp]

    movz	fp,	#5012
    ldr	x22,	[sp, fp]

    movz	fp,	#2764
    mov	x17,	x22
    str	x17,	[sp, #2344]

    ldr	x19,	[sp, fp]

    movz	fp,	#2364
    mov	x14,	x19
    str	x14,	[sp, fp]

    movz	fp,	#2772
    ldr	x25,	[sp, fp]

    movz	fp,	#2380
    mov	x28,	x25
    str	x28,	[sp, fp]

    movz	fp,	#5020
    ldr	x0,	[sp, fp]

    movz	fp,	#5028
    mov	x24,	x0
    str	x24,	[sp, #2328]

    ldr	x3,	[sp, fp]

    movz	fp,	#2308
    mov	x23,	x3
    str	x23,	[sp, fp]

    movz	fp,	#5036
    ldr	x6,	[sp, fp]

    movz	fp,	#5044
    mov	x18,	x6
    str	x18,	[sp, #2280]

    ldr	x9,	[sp, fp]

    movz	fp,	#2244
    mov	x24,	x9
    str	x24,	[sp, fp]

    movz	fp,	#2780
    ldr	x12,	[sp, fp]

    movz	fp,	#2252
    mov	x17,	x12
    str	x17,	[sp, fp]

    movz	fp,	#2020
    ldr	x16,	[sp, #5056]

    str	x16,	[sp, #2216]

    ldr	x19,	[sp, #5064]

    mov	x15,	x19
    str	x15,	[sp, fp]

    movz	fp,	#2788
    ldr	x14,	[sp, fp]

    movz	fp,	#2036
    mov	x25,	x14
    str	x25,	[sp, fp]

    movz	fp,	#2796
    ldr	x15,	[sp, fp]

    movz	fp,	#2052
    mov	x19,	x15
    str	x19,	[sp, fp]

    movz	fp,	#2804
    ldr	x27,	[sp, #5072]

    mov	x7,	x27
    str	x7,	[sp, #1960]

    ldr	x2,	[sp, #5080]

    mov	x12,	x2
    str	x12,	[sp, #1864]

    ldr	x12,	[sp, fp]

    movz	fp,	#2812
    mov	x18,	x12
    str	x18,	[sp, #1872]

    ldr	x17,	[sp, fp]

    movz	fp,	#2108
    mov	x3,	x17
    str	x3,	[sp, fp]

    movz	fp,	#2092
    ldr	x8,	[sp, #5096]

    mov	x2,	x8
    str	x2,	[sp, #1856]

    ldr	x11,	[sp, #5104]

    mov	x2,	x11
    str	x2,	[sp, fp]

    movz	fp,	#2084
    ldr	x14,	[sp, #5112]

    mov	x19,	x14
    str	x19,	[sp, fp]

    movz	fp,	#1988
    ldr	x17,	[sp, #5120]

    mov	x2,	x17
    str	x2,	[sp, fp]

    movz	fp,	#2076
    ldr	x0,	[sp, #5136]

    mov	x24,	x0
    str	x24,	[sp, fp]


main_518:
    ldr	w19,	[sp, #3304]

    movz	fp,	#5484
    lsl	w17,	w19,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#2620
    add	x15,	x9,	x17
    ldr	s12,	[x15]

    ldr	w23,	[sp, #3304]

    ldr	x9,	[sp, fp]

    lsl	w8,	w23,	#2
    movz	fp,	#2596
    add	x18,	x9,	x8
    ldr	s27,	[x18]

    ldr	w25,	[sp, #3304]

    fadd	s17,	s12,	s27
    ldr	x2,	[sp, fp]

    lsl	w15,	w25,	#2
    movz	fp,	#2580
    add	x2,	x2,	x15
    ldr	s31,	[x2]

    ldr	w28,	[sp, #3304]

    fadd	s21,	s17,	s31
    ldr	x16,	[sp, fp]

    lsl	w2,	w28,	#2
    movz	fp,	#1060
    add	x6,	x16,	x2
    ldr	s4,	[x6]

    ldr	w0,	[sp, #3304]

    fadd	s2,	s21,	s4
    lsl	w10,	w0,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#1052
    add	x10,	x0,	x10
    ldr	s30,	[x10]

    ldr	w1,	[sp, #3304]

    ldr	x10,	[sp, #1072]

    lsl	w14,	w1,	#2
    add	x13,	x10,	x14
    ldr	s12,	[x13]

    ldr	w2,	[sp, #3304]

    fadd	s4,	s30,	s12
    ldr	x23,	[sp, #2552]

    lsl	w12,	w2,	#2
    add	x17,	x23,	x12
    ldr	s17,	[x17]

    ldr	w3,	[sp, #3304]

    fadd	s6,	s4,	s17
    ldr	x2,	[sp, #2560]

    lsl	w19,	w3,	#2
    add	x1,	x2,	x19
    ldr	s23,	[x1]

    ldr	w4,	[sp, #3304]

    fadd	s7,	s6,	s23
    ldr	x1,	[sp, #2568]

    lsl	w10,	w4,	#2
    add	x5,	x1,	x10
    ldr	s16,	[x5]

    ldr	w5,	[sp, #3304]

    ldr	x1,	[sp, fp]

    lsl	w8,	w5,	#2
    movz	fp,	#2476
    add	x8,	x1,	x8
    ldr	s1,	[x8]

    ldr	w0,	[sp, #3304]

    fadd	s21,	s16,	s1
    ldr	x19,	[sp, fp]

    lsl	w11,	w0,	#2
    movz	fp,	#2468
    add	x12,	x19,	x11
    ldr	s6,	[x12]

    ldr	w1,	[sp, #3304]

    fadd	s25,	s21,	s6
    ldr	x4,	[sp, #2456]

    lsl	w18,	w1,	#2
    add	x16,	x4,	x18
    ldr	s12,	[x16]

    ldr	w2,	[sp, #3304]

    fadd	s3,	s25,	s12
    ldr	x14,	[sp, fp]

    lsl	w1,	w2,	#2
    movz	fp,	#2444
    add	x0,	x14,	x1
    ldr	s5,	[x0]

    ldr	w3,	[sp, #3304]

    ldr	x0,	[sp, fp]

    lsl	w7,	w3,	#2
    movz	fp,	#2428
    add	x3,	x0,	x7
    ldr	s18,	[x3]

    ldr	w4,	[sp, #3304]

    fadd	s10,	s5,	s18
    ldr	x13,	[sp, fp]

    lsl	w19,	w4,	#2
    movz	fp,	#2404
    add	x7,	x13,	x19
    ldr	s22,	[x7]

    ldr	w5,	[sp, #3304]

    fadd	s10,	s10,	s22
    ldr	x4,	[sp, fp]

    lsl	w17,	w5,	#2
    movz	fp,	#2412
    add	x11,	x4,	x17
    ldr	s28,	[x11]

    ldr	w6,	[sp, #3304]

    fadd	s24,	s10,	s28
    ldr	x3,	[sp, fp]

    lsl	w10,	w6,	#2
    movz	fp,	#2420
    add	x18,	x3,	x10
    ldr	s19,	[x18]

    ldr	w7,	[sp, #3304]

    ldr	x8,	[sp, fp]

    lsl	w14,	w7,	#2
    movz	fp,	#2396
    add	x2,	x8,	x14
    ldr	s9,	[x2]

    ldr	w8,	[sp, #3304]

    fadd	s25,	s19,	s9
    ldr	x28,	[sp, fp]

    lsl	w8,	w8,	#2
    movz	fp,	#2364
    add	x7,	x28,	x8
    ldr	s14,	[x7]

    ldr	w9,	[sp, #3304]

    fadd	s29,	s25,	s14
    ldr	x18,	[sp, #2344]

    lsl	w2,	w9,	#2
    add	x12,	x18,	x2
    ldr	s18,	[x12]

    ldr	w10,	[sp, #3304]

    fadd	s31,	s29,	s18
    ldr	x2,	[sp, fp]

    lsl	w10,	w10,	#2
    movz	fp,	#2380
    add	x17,	x2,	x10
    ldr	s10,	[x17]

    ldr	w11,	[sp, #3304]

    ldr	x12,	[sp, fp]

    lsl	w11,	w11,	#2
    movz	fp,	#2308
    add	x1,	x12,	x11
    ldr	s21,	[x1]

    ldr	w12,	[sp, #3304]

    fadd	s15,	s10,	s21
    ldr	x8,	[sp, #2328]

    lsl	w19,	w12,	#2
    add	x6,	x8,	x19
    ldr	s27,	[x6]

    ldr	w13,	[sp, #3304]

    fadd	s13,	s15,	s27
    ldr	x28,	[sp, fp]

    lsl	w12,	w13,	#2
    movz	fp,	#2244
    add	x11,	x28,	x12
    ldr	s4,	[x11]

    ldr	w14,	[sp, #3304]

    fadd	s6,	s13,	s4
    ldr	x4,	[sp, #2280]

    lsl	w19,	w14,	#2
    add	x16,	x4,	x19
    ldr	s22,	[x16]

    ldr	w15,	[sp, #3304]

    ldr	x8,	[sp, fp]

    lsl	w14,	w15,	#2
    movz	fp,	#2252
    add	x0,	x8,	x14
    ldr	s16,	[x0]

    ldr	w16,	[sp, #3304]

    fadd	s28,	s22,	s16
    ldr	x18,	[sp, fp]

    lsl	w16,	w16,	#2
    movz	fp,	#2020
    add	x5,	x18,	x16
    ldr	s20,	[x5]

    ldr	w17,	[sp, #3304]

    fadd	s4,	s28,	s20
    ldr	x19,	[sp, #2216]

    lsl	w11,	w17,	#2
    add	x10,	x19,	x11
    ldr	s17,	[x10]

    ldr	w18,	[sp, #3304]

    fadd	s13,	s4,	s17
    ldr	x25,	[sp, fp]

    lsl	w16,	w18,	#2
    movz	fp,	#2036
    add	x15,	x25,	x16
    ldr	s17,	[x15]

    ldr	w19,	[sp, #3304]

    ldr	x0,	[sp, fp]

    lsl	w14,	w19,	#2
    movz	fp,	#2052
    add	x18,	x0,	x14
    ldr	s27,	[x18]

    ldr	w23,	[sp, #3304]

    fadd	s21,	s17,	s27
    ldr	x8,	[sp, fp]

    lsl	w19,	w23,	#2
    movz	fp,	#2108
    add	x3,	x8,	x19
    ldr	s4,	[x3]

    ldr	w25,	[sp, #3304]

    fadd	s17,	s21,	s4
    ldr	x3,	[sp, #1960]

    lsl	w2,	w25,	#2
    add	x8,	x3,	x2
    ldr	s12,	[x8]

    ldr	w28,	[sp, #3304]

    fadd	s4,	s17,	s12
    ldr	x6,	[sp, #1864]

    lsl	w10,	w28,	#2
    add	x13,	x6,	x10
    ldr	s17,	[x13]

    ldr	w0,	[sp, #3304]

    ldr	x11,	[sp, #1872]

    lsl	w14,	w0,	#2
    add	x17,	x11,	x14
    ldr	s29,	[x17]

    ldr	w1,	[sp, #3304]

    fadd	s22,	s17,	s29
    ldr	x25,	[sp, fp]

    lsl	w3,	w1,	#2
    movz	fp,	#2092
    add	x2,	x25,	x3
    ldr	s5,	[x2]

    ldr	w2,	[sp, #3304]

    fadd	s27,	s22,	s5
    ldr	x1,	[sp, #1856]

    lsl	w5,	w2,	#2
    add	x7,	x1,	x5
    ldr	s12,	[x7]

    ldr	w3,	[sp, #3304]

    fadd	s22,	s27,	s12
    ldr	x25,	[sp, fp]

    lsl	w13,	w3,	#2
    movz	fp,	#2084
    add	x12,	x25,	x13
    ldr	s25,	[x12]

    ldr	w4,	[sp, #3304]

    ldr	x16,	[sp, fp]

    lsl	w11,	w4,	#2
    movz	fp,	#1988
    add	x16,	x16,	x11
    ldr	s20,	[x16]

    ldr	w5,	[sp, #3304]

    fadd	s29,	s25,	s20
    ldr	x1,	[sp, fp]

    lsl	w19,	w5,	#2
    movz	fp,	#2076
    add	x1,	x1,	x19
    ldr	s25,	[x1]

    ldr	w0,	[sp, #3304]

    fadd	s9,	s29,	s25
    ldr	x25,	[sp, fp]

    lsl	w7,	w0,	#2
    movz	fp,	#2660
    add	x3,	x25,	x7
    ldr	s20,	[x3]

    ldr	x7,	[sp, fp]

    fadd	s21,	s9,	s20
    movz	fp,	#2492
    str	s2,	[x7]

    ldr	x5,	[sp, fp]

    movz	fp,	#2500
    str	s7,	[x5]

    ldr	x8,	[sp, fp]

    movz	fp,	#2524
    str	s3,	[x8]

    ldr	x16,	[sp, #2512]

    str	s24,	[x16]

    ldr	x1,	[sp, fp]

    movz	fp,	#2532
    str	s31,	[x1]

    ldr	x4,	[sp, fp]

    movz	fp,	#1036
    str	s6,	[x4]

    ldr	x7,	[sp, #1016]

    str	s13,	[x7]

    ldr	x10,	[sp, #1024]

    str	s4,	[x10]

    movi	v4.4s,	#0
    ldr	x18,	[sp, fp]

    movz	fp,	#1044
    str	s22,	[x18]

    ldr	x25,	[sp, fp]

    str	s21,	[x25]

    ldr	s27,	[x3]

    fcmp	s27,	s4
    cset	w12,	ne
    mov	w13,	w12
    cmp	w13,	#0
    movi	v4.4s,	#0
    cset	w15,	ne
    mov	w16,	w15
    scvtf	s31,	w16
    fcmp	s31,	s4
    movi	v3.4s,	#0
    cset	w18,	ne
    mov	w0,	w18
    scvtf	s4,	w0
    fcmp	s4,	s3
    beq	main_517

main_679:
    movz	w0,	#10
    movz	fp,	#2660
    ldr	x1,	[sp, fp]

    bl	putfarray
    add	x27,	sp,	#884
    add	x24,	sp,	#844
    add	x28,	sp,	#840
    add	x9,	sp,	#900
    movz	fp,	#3124
    ldr	w1,	[sp, #3304]

    lsl	w0,	w1,	#2
    mov	x5,	x0
    add	x5,	sp,	x5
    add	x5,	x5,	#904
    ldr	s14,	[x5]

    ldr	x11,	[sp, fp]

    movz	fp,	#2836
    ldr	x13,	[sp, fp]

    movz	fp,	#3228
    mov	x21,	x13
    add	x13,	sp,	#832
    ldr	x5,	[sp, fp]

    movz	fp,	#3756
    mov	x15,	x5
    add	x5,	sp,	#828
    str	x15,	[sp, fp]

    movz	fp,	#3100
    ldr	x7,	[sp, fp]

    movz	fp,	#3084
    mov	x10,	x7
    ldr	x0,	[sp, fp]

    movz	fp,	#2924
    mov	x4,	x0
    add	x0,	sp,	#872
    str	x4,	[sp, #4488]

    add	x4,	sp,	#888
    ldr	x14,	[sp, fp]

    movz	fp,	#2964
    str	x14,	[sp, #1808]

    add	x14,	sp,	#836
    ldr	x26,	[sp, fp]

    movz	fp,	#3108
    mov	x1,	x26
    str	x1,	[sp, #3776]

    ldr	x25,	[sp, fp]

    movz	fp,	#2820
    mov	x22,	x25
    str	x22,	[sp, #3768]

    ldr	x8,	[sp, fp]

    movz	fp,	#2948
    mov	x12,	x8
    add	x8,	sp,	#856
    str	x12,	[sp, #4504]

    ldr	x19,	[sp, fp]

    movz	fp,	#3196
    mov	x6,	x19
    add	x19,	sp,	#860
    str	x6,	[sp, #9128]

    ldr	x2,	[sp, fp]

    movz	fp,	#3220
    mov	x7,	x2
    str	x7,	[sp, #4496]

    ldr	x1,	[sp, fp]

    movz	fp,	#3244
    mov	x3,	x1
    add	x1,	sp,	#824
    str	x3,	[sp, #1816]

    mov	x3,	x11
    ldr	x26,	[sp, fp]

    movz	fp,	#3236
    mov	x15,	x26
    str	x15,	[sp, #4512]

    ldr	x23,	[sp, fp]

    movz	fp,	#2436
    mov	x25,	x23
    str	x25,	[sp, #1800]

    str	x1,	[sp, fp]

    movz	fp,	#2028
    str	x5,	[sp, #5128]

    str	x13,	[sp, #5088]

    add	x13,	sp,	#848
    str	x14,	[sp, #5144]

    str	x28,	[sp, #1952]

    add	x28,	sp,	#852
    str	x24,	[sp, fp]

    movz	fp,	#2044
    str	x13,	[sp, fp]

    add	x13,	sp,	#868
    movz	fp,	#2692
    str	x28,	[sp, #2200]

    str	x8,	[sp, #2208]

    add	x8,	sp,	#896
    str	x19,	[sp, #2224]

    add	x19,	sp,	#864
    str	x19,	[sp, fp]

    add	x19,	sp,	#880
    movz	fp,	#2588
    str	x13,	[sp, fp]

    add	x13,	sp,	#876
    movz	fp,	#2604
    str	x0,	[sp, fp]

    movz	fp,	#2612
    str	x13,	[sp, fp]

    mov	x13,	x10
    movz	fp,	#2636
    str	x19,	[sp, fp]

    movz	fp,	#2644
    str	x27,	[sp, fp]

    add	x27,	sp,	#892
    movz	fp,	#2652
    str	x4,	[sp, fp]

    movz	fp,	#2668
    str	x27,	[sp, fp]

    movz	fp,	#2676
    str	x8,	[sp, fp]

    movz	fp,	#2684
    str	x9,	[sp, fp]

    movz	fp,	#4012
    ldr	s6,	[sp, #1292]

    fmov	s9,	s6
    str	x3,	[sp, fp]

    movz	fp,	#2700
    ldr	w0,	[sp, #3272]

    mov	w17,	w0
    str	w17,	[sp, #2628]

    mov	x17,	x21
    ldr	x4,	[sp, fp]

    movz	fp,	#2708
    mov	x14,	x4
    str	x14,	[sp, #6576]

    ldr	s4,	[sp, #1296]

    ldr	w4,	[sp, #3300]

    fmov	s21,	s4
    mov	w1,	w4
    str	w1,	[sp, #2632]

    ldr	s7,	[sp, #1300]

    ldr	s6,	[sp, #1304]

    fmov	s27,	s7
    ldr	x18,	[sp, fp]

    fmov	s22,	s6
    movz	fp,	#2388
    mov	x19,	x18
    str	x19,	[sp, fp]

    movz	fp,	#2716
    str	x17,	[sp, #2352]

    ldr	w11,	[sp, #3284]

    mov	w17,	w11
    str	w17,	[sp, #2548]

    ldr	w28,	[sp, #3276]

    mov	w25,	w28
    str	w25,	[sp, #2576]

    ldr	x25,	[sp, fp]

    movz	fp,	#2372
    mov	x18,	x25
    str	x18,	[sp, fp]

    movz	fp,	#3756
    ldr	x3,	[sp, fp]

    movz	fp,	#2268
    mov	x27,	x3
    str	x27,	[sp, #2336]

    str	x13,	[sp, fp]

    movz	fp,	#2724
    ldr	w1,	[sp, #3264]

    mov	w11,	w1
    str	w11,	[sp, #1068]

    ldr	x28,	[sp, fp]

    movz	fp,	#2732
    mov	x19,	x28
    str	x19,	[sp, #2288]

    ldr	x2,	[sp, fp]

    movz	fp,	#2740
    mov	x27,	x2
    str	x27,	[sp, #2296]

    ldr	s2,	[sp, #1308]

    ldr	s3,	[sp, #1312]

    fmov	s10,	s2
    ldr	s18,	[sp, #1316]

    fmov	s28,	s3
    ldr	x13,	[sp, fp]

    fmov	s26,	s18
    movz	fp,	#2316
    mov	x21,	x13
    str	x21,	[sp, fp]

    movz	fp,	#2236
    ldr	w11,	[sp, #3256]

    mov	w28,	w11
    str	w28,	[sp, #2544]

    ldr	s20,	[sp, #1320]

    ldr	s19,	[sp, #1324]

    fmov	s29,	s20
    ldr	s7,	[sp, #1328]

    fmov	s23,	s19
    ldr	x16,	[sp, #4488]

    fmov	s24,	s7
    mov	x5,	x16
    str	x5,	[sp, fp]

    movz	fp,	#2748
    ldr	x18,	[sp, fp]

    movz	fp,	#2260
    mov	x25,	x18
    str	x25,	[sp, fp]

    movz	fp,	#2756
    ldr	x13,	[sp, #1808]

    mov	x12,	x13
    str	x12,	[sp, #1968]

    ldr	x18,	[sp, #3776]

    str	x18,	[sp, #2136]

    ldr	x2,	[sp, fp]

    movz	fp,	#2764
    mov	x20,	x2
    str	x20,	[sp, #4968]

    ldr	s12,	[sp, #1332]

    ldr	s4,	[sp, #1336]

    fmov	s19,	s12
    ldr	x25,	[sp, #3768]

    fmov	s12,	s4
    str	x25,	[sp, #4912]

    ldr	w1,	[sp, #3252]

    mov	w24,	w1
    str	w24,	[sp, #1032]

    ldr	x8,	[sp, fp]

    movz	fp,	#2772
    mov	x4,	x8
    str	x4,	[sp, #4928]

    ldr	x19,	[sp, fp]

    movz	fp,	#2780
    mov	x20,	x19
    str	x20,	[sp, #2184]

    ldr	s2,	[sp, #1340]

    ldr	s1,	[sp, #1344]

    fmov	s15,	s2
    ldr	x5,	[sp, #4504]

    fmov	s17,	s1
    str	x5,	[sp, #2152]

    ldr	x7,	[sp, #9128]

    mov	x5,	x7
    str	x5,	[sp, #4936]

    ldr	w25,	[sp, #3288]

    str	w25,	[sp, #2508]

    ldr	w4,	[sp, #3280]

    mov	w8,	w4
    str	w8,	[sp, #2520]

    ldr	s20,	[sp, #1348]

    ldr	s25,	[sp, #1352]

    fmov	s18,	s20
    ldr	x14,	[sp, #4496]

    fmov	s3,	s25
    str	x14,	[sp, #2168]

    ldr	w10,	[sp, #3260]

    mov	w3,	w10
    str	w3,	[sp, #2484]

    ldr	x1,	[sp, fp]

    movz	fp,	#3516
    mov	x15,	x1
    str	x15,	[sp, fp]

    movz	fp,	#2788
    ldr	w8,	[sp, #3268]

    mov	w4,	w8
    str	w4,	[sp, #2488]

    ldr	x8,	[sp, #1816]

    str	x8,	[sp, #4888]

    ldr	x28,	[sp, #4512]

    str	x28,	[sp, #2144]

    ldr	s30,	[sp, #1356]

    ldr	s16,	[sp, #1360]

    fmov	s13,	s30
    ldr	x18,	[sp, fp]

    fmov	s8,	s16
    movz	fp,	#4020
    mov	x28,	x18
    str	x28,	[sp, fp]

    movz	fp,	#2796
    ldr	w12,	[sp, #3296]

    mov	w25,	w12
    str	w25,	[sp, #2464]

    ldr	x4,	[sp, #1800]

    str	x4,	[sp, #4920]

    ldr	x16,	[sp, fp]

    movz	fp,	#2068
    mov	x20,	x16
    str	x20,	[sp, fp]

    movz	fp,	#2804
    ldr	s16,	[sp, #1364]

    ldr	w7,	[sp, #3300]

    fmov	s2,	s16
    mov	w24,	w7
    str	w24,	[sp, #2452]

    ldr	s31,	[sp, #1368]

    ldr	x17,	[sp, fp]

    fmov	s20,	s31
    movz	fp,	#1996
    mov	x24,	x17
    str	x24,	[sp, fp]

    movz	fp,	#2812
    ldr	x1,	[sp, fp]

    movz	fp,	#2004
    mov	x16,	x1
    str	x16,	[sp, fp]

    ldr	s30,	[sp, #1372]

    ldr	w25,	[sp, #3292]

    mov	w1,	w25
    str	w1,	[sp, #2540]


main_717:
    ldr	w12,	[sp, #3304]

    movz	fp,	#2388
    ldr	x14,	[sp, #6576]

    lsl	w25,	w12,	#2
    add	x24,	x14,	x25
    ldr	s7,	[x24]

    fadd	s25,	s9,	s7
    fadd	s25,	s25,	s21
    fadd	s1,	s25,	s27
    str	s1,	[sp, #1476]

    ldr	w16,	[sp, #3304]

    ldr	x24,	[sp, fp]

    lsl	w20,	w16,	#2
    movz	fp,	#2372
    add	x24,	x24,	x20
    ldr	s4,	[x24]

    ldr	w18,	[sp, #3304]

    fadd	s6,	s22,	s4
    ldr	x28,	[sp, fp]

    lsl	w12,	w18,	#2
    movz	fp,	#2316
    add	x7,	x28,	x12
    ldr	s5,	[x7]

    ldr	w23,	[sp, #3304]

    fadd	s5,	s6,	s5
    ldr	x6,	[sp, #2288]

    lsl	w24,	w23,	#2
    add	x12,	x6,	x24
    ldr	s4,	[x12]

    fadd	s16,	s5,	s4
    str	s16,	[sp, #1464]

    ldr	w24,	[sp, #3304]

    ldr	x12,	[sp, #2296]

    lsl	w0,	w24,	#2
    add	x25,	x12,	x0
    ldr	s25,	[x25]

    fadd	s5,	s25,	s10
    fadd	s6,	s5,	s28
    fadd	s7,	s6,	s26
    str	s7,	[sp, #1472]

    ldr	w25,	[sp, #3304]

    ldr	x17,	[sp, fp]

    lsl	w12,	w25,	#2
    movz	fp,	#2260
    add	x0,	x17,	x12
    ldr	s7,	[x0]

    fadd	s25,	s7,	s29
    fadd	s25,	s25,	s23
    fadd	s25,	s25,	s24
    str	s25,	[sp, #1448]

    ldr	w0,	[sp, #3304]

    ldr	x1,	[sp, fp]

    lsl	w25,	w0,	#2
    movz	fp,	#3516
    add	x12,	x1,	x25
    ldr	s4,	[x12]

    ldr	w1,	[sp, #3304]

    ldr	x28,	[sp, #4968]

    lsl	w25,	w1,	#2
    add	x24,	x28,	x25
    ldr	s1,	[x24]

    fadd	s25,	s4,	s1
    fadd	s5,	s25,	s19
    fadd	s5,	s5,	s12
    str	s5,	[sp, #1452]

    ldr	w7,	[sp, #3304]

    ldr	x10,	[sp, #4928]

    lsl	w0,	w7,	#2
    add	x16,	x10,	x0
    ldr	s6,	[x16]

    ldr	w12,	[sp, #3304]

    ldr	x0,	[sp, #2184]

    lsl	w25,	w12,	#2
    add	x17,	x0,	x25
    ldr	s7,	[x17]

    fadd	s5,	s6,	s7
    fadd	s6,	s5,	s15
    fadd	s4,	s6,	s17
    str	s4,	[sp, #1460]

    ldr	w0,	[sp, #3304]

    fadd	s4,	s18,	s3
    ldr	x28,	[sp, fp]

    lsl	w16,	w0,	#2
    movz	fp,	#4020
    add	x10,	x28,	x16
    ldr	s7,	[x10]

    fadd	s25,	s4,	s7
    fadd	s5,	s25,	s13
    str	s5,	[sp, #1088]

    ldr	w1,	[sp, #3304]

    ldr	x9,	[sp, fp]

    lsl	w1,	w1,	#2
    movz	fp,	#2068
    add	x0,	x9,	x1
    ldr	s4,	[x0]

    ldr	w10,	[sp, #3304]

    fadd	s1,	s8,	s4
    ldr	x20,	[sp, fp]

    lsl	w12,	w10,	#2
    movz	fp,	#1996
    add	x25,	x20,	x12
    ldr	s25,	[x25]

    fadd	s5,	s1,	s25
    fadd	s4,	s5,	s2
    str	s4,	[sp, #1144]

    ldr	w16,	[sp, #3304]

    ldr	x25,	[sp, fp]

    lsl	w24,	w16,	#2
    movz	fp,	#2004
    add	x17,	x25,	x24
    ldr	s6,	[x17]

    ldr	w18,	[sp, #3304]

    fadd	s7,	s20,	s6
    ldr	x15,	[sp, fp]

    lsl	w20,	w18,	#2
    movz	fp,	#2436
    add	x16,	x15,	x20
    ldr	s5,	[x16]

    fadd	s6,	s7,	s5
    fadd	s25,	s6,	s30
    str	s25,	[sp, #1184]

    ldr	s4,	[sp, #1476]

    ldr	x24,	[sp, fp]

    movz	fp,	#2028
    str	s4,	[x24]

    ldr	s25,	[sp, #1464]

    ldr	x22,	[sp, #5128]

    str	s25,	[x22]

    ldr	s16,	[sp, #1472]

    ldr	x5,	[sp, #5088]

    str	s16,	[x5]

    ldr	s31,	[sp, #1448]

    ldr	x3,	[sp, #5144]

    str	s31,	[x3]

    ldr	s6,	[sp, #1452]

    ldr	x0,	[sp, #1952]

    str	s6,	[x0]

    ldr	s5,	[sp, #1460]

    ldr	x10,	[sp, fp]

    movz	fp,	#2044
    str	s5,	[x10]

    ldr	s6,	[sp, #1088]

    ldr	x23,	[sp, fp]

    movz	fp,	#4012
    str	s6,	[x23]

    ldr	s6,	[sp, #1144]

    ldr	x1,	[sp, #2200]

    str	s6,	[x1]

    ldr	s25,	[sp, #1184]

    ldr	x18,	[sp, #2208]

    str	s25,	[x18]

    ldr	x0,	[sp, #2224]

    movi	v25.4s,	#0
    str	s25,	[x0]

    ldr	w23,	[sp, #3304]

    ldr	x4,	[sp, fp]

    lsl	w7,	w23,	#2
    movz	fp,	#2268
    add	x23,	x4,	x7
    ldr	w14,	[x23]

    ldr	w1,	[sp, #2628]

    ldr	w0,	[sp, #2632]

    add	w0,	w0,	w1
    add	w10,	w0,	w14
    str	w10,	[sp, #2100]

    ldr	w17,	[sp, #3304]

    ldr	x6,	[sp, #2352]

    lsl	w0,	w17,	#2
    add	x23,	x6,	x0
    ldr	w16,	[x23]

    ldr	w23,	[sp, #2548]

    ldr	w14,	[sp, #2576]

    add	w0,	w14,	w23
    add	w10,	w0,	w16
    str	w10,	[sp, #1984]

    ldr	w20,	[sp, #3304]

    ldr	x0,	[sp, #2336]

    lsl	w1,	w20,	#2
    add	x12,	x0,	x1
    ldr	w20,	[x12]

    ldr	w24,	[sp, #3304]

    ldr	x1,	[sp, fp]

    lsl	w14,	w24,	#2
    movz	fp,	#2236
    add	x8,	x1,	x14
    ldr	w25,	[x8]

    ldr	w14,	[sp, #1068]

    add	w15,	w20,	w14
    add	w6,	w15,	w25
    str	w6,	[sp, #2016]

    ldr	w24,	[sp, #3304]

    ldr	x15,	[sp, fp]

    lsl	w1,	w24,	#2
    movz	fp,	#2692
    add	x23,	x15,	x1
    ldr	w14,	[x23]

    ldr	w10,	[sp, #2544]

    ldr	w28,	[sp, #3304]

    add	w25,	w14,	w10
    ldr	x15,	[sp, #1968]

    lsl	w12,	w28,	#2
    add	x10,	x15,	x12
    ldr	w15,	[x10]

    add	w23,	w25,	w15
    str	w23,	[sp, #2012]

    ldr	w0,	[sp, #3304]

    ldr	x18,	[sp, #2136]

    lsl	w20,	w0,	#2
    add	x12,	x18,	x20
    ldr	w28,	[x12]

    ldr	w6,	[sp, #3304]

    ldr	x27,	[sp, #4912]

    lsl	w16,	w6,	#2
    add	x8,	x27,	x16
    ldr	w1,	[x8]

    ldr	w0,	[sp, #1032]

    add	w14,	w28,	w0
    add	w6,	w14,	w1
    str	w6,	[sp, #1936]

    ldr	w10,	[sp, #3304]

    ldr	x5,	[sp, #2152]

    lsl	w25,	w10,	#2
    add	x15,	x5,	x25
    ldr	w14,	[x15]

    ldr	w0,	[sp, #3304]

    ldr	x8,	[sp, #4936]

    lsl	w17,	w0,	#2
    add	x17,	x8,	x17
    ldr	w0,	[x17]

    ldr	w8,	[sp, #2508]

    add	w17,	w14,	w8
    add	w15,	w17,	w0
    str	w15,	[sp, #1944]

    ldr	w1,	[sp, #3304]

    ldr	x14,	[sp, #2168]

    lsl	w8,	w1,	#2
    add	x23,	x14,	x8
    ldr	w17,	[x23]

    ldr	w0,	[sp, #2484]

    ldr	w25,	[sp, #2520]

    add	w10,	w0,	w25
    add	w0,	w10,	w17
    str	w0,	[sp, #1948]

    ldr	w10,	[sp, #3304]

    ldr	x8,	[sp, #4888]

    lsl	w20,	w10,	#2
    add	x12,	x8,	x20
    ldr	w0,	[x12]

    ldr	w18,	[sp, #2488]

    ldr	w10,	[sp, #3304]

    add	w28,	w0,	w18
    lsl	w14,	w10,	#2
    ldr	x0,	[sp, #2144]

    add	x7,	x0,	x14
    ldr	w12,	[x7]

    add	w16,	w28,	w12
    str	w16,	[sp, #1796]

    ldr	w1,	[sp, #3304]

    ldr	x4,	[sp, #4920]

    lsl	w25,	w1,	#2
    add	x18,	x4,	x25
    ldr	w8,	[x18]

    ldr	w14,	[sp, #2452]

    ldr	w15,	[sp, #2464]

    ldr	w23,	[sp, #2540]

    add	w16,	w14,	w15
    add	w16,	w16,	w23
    add	w17,	w16,	w8
    str	w17,	[sp, #3764]

    ldr	w18,	[sp, #2100]

    ldr	x7,	[sp, fp]

    movz	fp,	#2588
    str	w18,	[x7]

    ldr	w15,	[sp, #1984]

    ldr	x25,	[sp, fp]

    movz	fp,	#2604
    str	w15,	[x25]

    ldr	w28,	[sp, #2016]

    ldr	x1,	[sp, fp]

    movz	fp,	#2612
    str	w28,	[x1]

    ldr	w14,	[sp, #2012]

    ldr	x17,	[sp, fp]

    movz	fp,	#2636
    str	w14,	[x17]

    ldr	w12,	[sp, #1936]

    ldr	x7,	[sp, fp]

    movz	fp,	#2644
    str	w12,	[x7]

    ldr	w8,	[sp, #1944]

    ldr	x10,	[sp, fp]

    movz	fp,	#2652
    str	w8,	[x10]

    movz	w10,	#0
    ldr	w28,	[sp, #1948]

    mov	w15,	w10
    ldr	x14,	[sp, fp]

    movz	fp,	#2668
    str	w28,	[x14]

    fcvtzs	w28,	s30
    ldr	x0,	[sp, fp]

    movz	fp,	#2676
    ldr	w18,	[sp, #1796]

    str	w18,	[x0]

    ldr	x14,	[sp, fp]

    movz	fp,	#2684
    ldr	w19,	[sp, #3764]

    str	w19,	[x14]

    ldr	x14,	[sp, fp]

    str	w15,	[x14]

    ldr	w10,	[sp, #2540]

    ldr	w8,	[sp, #2540]

    scvtf	s4,	w10
    cmp	w8,	#0
    beq	main_716

main_889:
    movz	w0,	#10
    movz	fp,	#2436
    ldr	x1,	[sp, fp]

    bl	putfarray
    movz	w0,	#10
    movz	fp,	#2692
    ldr	x1,	[sp, fp]

    bl	putarray
    movz	fp,	#2692
    ldr	w27,	[sp, #2100]

    scvtf	s13,	w27
    str	s13,	[sp, #1084]

    ldr	s12,	[sp, #1084]

    ldr	s8,	[sp, #1476]

    ldr	x26,	[sp, fp]

    fsub	s15,	s12,	s8
    movz	fp,	#2588
    fcvtzs	w19,	s15
    str	w19,	[x26]

    ldr	w22,	[sp, #1984]

    scvtf	s12,	w22
    ldr	s9,	[sp, #1464]

    ldr	x24,	[sp, fp]

    fsub	s10,	s12,	s9
    movz	fp,	#2604
    fcvtzs	w21,	s10
    str	w21,	[x24]

    ldr	w28,	[sp, #2016]

    ldr	s10,	[sp, #1472]

    scvtf	s12,	w28
    ldr	x19,	[sp, fp]

    fsub	s15,	s12,	s10
    movz	fp,	#2612
    fcvtzs	w27,	s15
    str	w27,	[x19]

    ldr	w26,	[sp, #2012]

    ldr	s13,	[sp, #1448]

    scvtf	s15,	w26
    ldr	x27,	[sp, fp]

    fsub	s12,	s15,	s13
    movz	fp,	#2636
    fcvtzs	w19,	s12
    str	w19,	[x27]

    ldr	w25,	[sp, #1936]

    ldr	s10,	[sp, #1452]

    scvtf	s9,	w25
    ldr	x27,	[sp, fp]

    fsub	s8,	s9,	s10
    movz	fp,	#2644
    fcvtzs	w23,	s8
    str	w23,	[x27]

    ldr	w26,	[sp, #1944]

    scvtf	s8,	w26
    ldr	s12,	[sp, #1460]

    fsub	s15,	s8,	s12
    ldr	x18,	[sp, fp]

    fcvtzs	w28,	s15
    movz	fp,	#2652
    str	w28,	[x18]

    ldr	w23,	[sp, #1948]

    ldr	s15,	[sp, #1088]

    scvtf	s8,	w23
    ldr	x24,	[sp, fp]

    fsub	s10,	s8,	s15
    movz	fp,	#2668
    fcvtzs	w18,	s10
    str	w18,	[x24]

    ldr	w20,	[sp, #1796]

    scvtf	s15,	w20
    ldr	s9,	[sp, #1144]

    fsub	s15,	s15,	s9
    ldr	x26,	[sp, fp]

    fcvtzs	w27,	s15
    movz	fp,	#2676
    str	w27,	[x26]

    ldr	w20,	[sp, #3764]

    movz	w26,	#0
    ldr	s9,	[sp, #1184]

    scvtf	s10,	w20
    ldr	x22,	[sp, fp]

    fsub	s12,	s10,	s9
    movz	fp,	#2684
    fcvtzs	w18,	s12
    str	w18,	[x22]

    ldr	x24,	[sp, fp]

    str	w26,	[x24]

    ldr	w24,	[sp, #3304]

    lsl	w27,	w24,	#2
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#864
    ldr	w28,	[x26]

    ldr	s10,	[sp, #1184]

    scvtf	s12,	w28
    ldr	s0,	[sp, #1288]

    fmul	s12,	s12,	s10
    fcvtzs	w27,	s12
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s11
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s14
    bl	putfloat
    movz	w0,	#10
    bl	putch
    mov	w0,	w27
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#10576
    add	sp, sp, fp
    ret


main_716:
    movz	fp,	#2692
    fmov	s30,	s4
    mov	w20,	w28
    ldr	x1,	[sp, fp]

    movz	fp,	#4012
    mov	x5,	x1
    str	x5,	[sp, fp]

    movz	fp,	#2436
    ldr	x1,	[sp, fp]

    movz	fp,	#2388
    mov	x15,	x1
    str	x15,	[sp, #6576]

    str	w20,	[sp, #2540]

    ldr	w20,	[sp, #2628]

    ldr	w28,	[sp, #6332]

    ldr	w1,	[sp, #6332]

    mov	w20,	w28
    str	w1,	[sp, #2628]

    ldr	w10,	[sp, #2632]

    ldr	w3,	[sp, #6336]

    ldr	w4,	[sp, #6336]

    mov	w10,	w3
    str	w4,	[sp, #2632]

    ldr	x28,	[sp, fp]

    movz	fp,	#2388
    ldr	x8,	[sp, #6280]

    ldr	x9,	[sp, #6280]

    mov	x28,	x8
    str	x9,	[sp, fp]

    movz	fp,	#2372
    ldr	x12,	[sp, #2352]

    ldr	x2,	[sp, #6224]

    ldr	x3,	[sp, #6224]

    mov	x12,	x2
    str	x3,	[sp, #2352]

    ldr	w28,	[sp, #2548]

    ldr	w16,	[sp, #6324]

    ldr	w18,	[sp, #6324]

    mov	w28,	w16
    str	w18,	[sp, #2548]

    ldr	w6,	[sp, #2576]

    ldr	w20,	[sp, #6328]

    ldr	w23,	[sp, #6328]

    mov	w6,	w20
    str	w23,	[sp, #2576]

    ldr	x7,	[sp, fp]

    movz	fp,	#2372
    ldr	x5,	[sp, #6272]

    ldr	x6,	[sp, #6272]

    mov	x7,	x5
    str	x6,	[sp, fp]

    movz	fp,	#2268
    ldr	x17,	[sp, #2336]

    ldr	x25,	[sp, #6264]

    ldr	x28,	[sp, #6264]

    mov	x17,	x25
    str	x28,	[sp, #2336]

    ldr	x1,	[sp, fp]

    movz	fp,	#2268
    ldr	x9,	[sp, #6232]

    ldr	x10,	[sp, #6232]

    mov	x1,	x9
    str	x10,	[sp, fp]

    movz	fp,	#2316
    ldr	w25,	[sp, #1068]

    ldr	w10,	[sp, #6316]

    ldr	w11,	[sp, #6316]

    mov	w25,	w10
    str	w11,	[sp, #1068]

    ldr	x10,	[sp, #2288]

    ldr	x12,	[sp, #6240]

    ldr	x13,	[sp, #6240]

    mov	x10,	x12
    str	x13,	[sp, #2288]

    ldr	x17,	[sp, #2296]

    ldr	x15,	[sp, #6248]

    ldr	x16,	[sp, #6248]

    mov	x17,	x15
    str	x16,	[sp, #2296]

    ldr	x20,	[sp, fp]

    movz	fp,	#2316
    ldr	x19,	[sp, #6256]

    mov	x20,	x19
    ldr	x20,	[sp, #6256]

    str	x20,	[sp, fp]

    movz	fp,	#2236
    ldr	w24,	[sp, #2544]

    ldr	w13,	[sp, #6320]

    ldr	w14,	[sp, #6320]

    mov	w24,	w13
    str	w14,	[sp, #2544]

    ldr	x20,	[sp, fp]

    movz	fp,	#2236
    ldr	x3,	[sp, #6208]

    ldr	x4,	[sp, #6208]

    mov	x20,	x3
    str	x4,	[sp, fp]

    movz	fp,	#2260
    ldr	x12,	[sp, fp]

    movz	fp,	#2260
    ldr	x6,	[sp, #6216]

    ldr	x7,	[sp, #6216]

    mov	x12,	x6
    str	x7,	[sp, fp]

    movz	fp,	#6348
    ldr	x7,	[sp, #1968]

    ldr	x28,	[sp, #6200]

    ldr	x1,	[sp, #6200]

    mov	x7,	x28
    str	x1,	[sp, #1968]

    ldr	x20,	[sp, #2136]

    ldr	x19,	[sp, fp]

    movz	fp,	#6348
    mov	x20,	x19
    ldr	x11,	[sp, fp]

    movz	fp,	#6396
    str	x11,	[sp, #2136]

    ldr	x1,	[sp, #4968]

    ldr	x0,	[sp, fp]

    movz	fp,	#6396
    mov	x1,	x0
    ldr	x0,	[sp, fp]

    movz	fp,	#6340
    str	x0,	[sp, #4968]

    ldr	x1,	[sp, #4912]

    ldr	x0,	[sp, #7696]

    ldr	x2,	[sp, #7696]

    mov	x1,	x0
    str	x2,	[sp, #4912]

    ldr	w17,	[sp, #1032]

    ldr	w7,	[sp, #6312]

    ldr	w8,	[sp, #6312]

    mov	w17,	w7
    str	w8,	[sp, #1032]

    ldr	x11,	[sp, #4928]

    ldr	x10,	[sp, fp]

    movz	fp,	#6340
    mov	x11,	x10
    ldr	x8,	[sp, fp]

    movz	fp,	#6380
    str	x8,	[sp, #4928]

    ldr	x2,	[sp, #2184]

    ldr	x1,	[sp, fp]

    movz	fp,	#6380
    mov	x2,	x1
    ldr	x23,	[sp, fp]

    movz	fp,	#6364
    str	x23,	[sp, #2184]

    ldr	x7,	[sp, #2152]

    ldr	x6,	[sp, fp]

    movz	fp,	#6364
    mov	x7,	x6
    ldr	x17,	[sp, fp]

    movz	fp,	#6388
    str	x17,	[sp, #2152]

    ldr	x10,	[sp, #4936]

    ldr	x9,	[sp, fp]

    movz	fp,	#6388
    mov	x10,	x9
    ldr	x26,	[sp, fp]

    movz	fp,	#6372
    str	x26,	[sp, #4936]

    ldr	w6,	[sp, #2508]

    ldr	w1,	[sp, #6304]

    ldr	w2,	[sp, #6304]

    mov	w6,	w1
    str	w2,	[sp, #2508]

    ldr	w10,	[sp, #2520]

    ldr	w4,	[sp, #6308]

    ldr	w5,	[sp, #6308]

    mov	w10,	w4
    str	w5,	[sp, #2520]

    ldr	x16,	[sp, #2168]

    ldr	x15,	[sp, fp]

    movz	fp,	#6372
    mov	x16,	x15
    ldr	x20,	[sp, fp]

    movz	fp,	#3516
    str	x20,	[sp, #2168]

    ldr	w17,	[sp, #2484]

    ldr	w18,	[sp, #6296]

    ldr	w19,	[sp, #6296]

    mov	w17,	w18
    str	w19,	[sp, #2484]

    ldr	x1,	[sp, fp]

    movz	fp,	#3516
    ldr	x0,	[sp, #7680]

    ldr	x25,	[sp, #7680]

    mov	x1,	x0
    str	x25,	[sp, fp]

    movz	fp,	#6356
    ldr	w6,	[sp, #2488]

    ldr	w23,	[sp, #6300]

    ldr	w25,	[sp, #6300]

    mov	w6,	w23
    str	w25,	[sp, #2488]

    ldr	x10,	[sp, #4888]

    ldr	x9,	[sp, #7688]

    ldr	x28,	[sp, #7688]

    mov	x10,	x9
    str	x28,	[sp, #4888]

    ldr	x2,	[sp, #2144]

    ldr	x1,	[sp, fp]

    movz	fp,	#6356
    mov	x2,	x1
    ldr	x14,	[sp, fp]

    movz	fp,	#4020
    str	x14,	[sp, #2144]

    ldr	x10,	[sp, fp]

    movz	fp,	#4020
    ldr	x9,	[sp, #7672]

    ldr	x22,	[sp, #7672]

    mov	x10,	x9
    str	x22,	[sp, fp]

    movz	fp,	#2068
    ldr	w16,	[sp, #2464]

    ldr	w14,	[sp, #6292]

    ldr	w15,	[sp, #6292]

    mov	w16,	w14
    str	w15,	[sp, #2464]

    ldr	x6,	[sp, #4920]

    ldr	x5,	[sp, #7704]

    mov	x6,	x5
    ldr	x5,	[sp, #7704]

    str	x5,	[sp, #4920]

    ldr	x24,	[sp, fp]

    movz	fp,	#2068
    ldr	x13,	[sp, #6176]

    ldr	x14,	[sp, #6176]

    mov	x24,	x13
    str	x14,	[sp, fp]

    movz	fp,	#1996
    ldr	w1,	[sp, #2452]

    ldr	w11,	[sp, #6288]

    ldr	w12,	[sp, #6288]

    mov	w1,	w11
    str	w12,	[sp, #2452]

    ldr	x28,	[sp, fp]

    movz	fp,	#1996
    ldr	x16,	[sp, #6184]

    ldr	x18,	[sp, #6184]

    mov	x28,	x16
    str	x18,	[sp, fp]

    movz	fp,	#2004
    ldr	x1,	[sp, fp]

    movz	fp,	#2004
    ldr	x20,	[sp, #6192]

    ldr	x23,	[sp, #6192]

    mov	x1,	x20
    str	x23,	[sp, fp]

    b	main_717

main_517:
    movz	fp,	#2620
    ldr	x10,	[sp, fp]

    movz	fp,	#5484
    str	x10,	[sp, fp]

    movz	fp,	#2596
    ldr	x3,	[sp, fp]

    movz	fp,	#2620
    mov	x11,	x3
    str	x11,	[sp, fp]

    movz	fp,	#2580
    ldr	x17,	[sp, fp]

    movz	fp,	#2596
    mov	x4,	x17
    str	x4,	[sp, fp]

    movz	fp,	#1060
    ldr	x1,	[sp, fp]

    movz	fp,	#2580
    mov	x18,	x1
    str	x18,	[sp, fp]

    movz	fp,	#1060
    ldr	x11,	[sp, #1072]

    mov	x2,	x11
    str	x2,	[sp, fp]

    movz	fp,	#1052
    ldr	x26,	[sp, #2552]

    mov	x12,	x26
    str	x12,	[sp, #1072]

    ldr	x3,	[sp, #2560]

    mov	x0,	x3
    str	x0,	[sp, #2552]

    ldr	x2,	[sp, #2568]

    mov	x4,	x2
    str	x4,	[sp, #2560]

    ldr	x2,	[sp, fp]

    movz	fp,	#2476
    mov	x3,	x2
    str	x3,	[sp, #2568]

    ldr	x24,	[sp, fp]

    movz	fp,	#1052
    mov	x3,	x24
    str	x3,	[sp, fp]

    movz	fp,	#2476
    ldr	x5,	[sp, #2456]

    mov	x26,	x5
    str	x26,	[sp, fp]

    movz	fp,	#2468
    ldr	x15,	[sp, fp]

    movz	fp,	#2444
    mov	x6,	x15
    str	x6,	[sp, #2456]

    ldr	x1,	[sp, fp]

    movz	fp,	#2468
    mov	x16,	x1
    str	x16,	[sp, fp]

    movz	fp,	#2428
    ldr	x14,	[sp, fp]

    movz	fp,	#2444
    mov	x2,	x14
    str	x2,	[sp, fp]

    movz	fp,	#2404
    ldr	x5,	[sp, fp]

    movz	fp,	#2428
    mov	x15,	x5
    str	x15,	[sp, fp]

    movz	fp,	#2412
    ldr	x4,	[sp, fp]

    movz	fp,	#2404
    mov	x0,	x4
    str	x0,	[sp, fp]

    movz	fp,	#2420
    ldr	x9,	[sp, fp]

    movz	fp,	#2412
    mov	x5,	x9
    str	x5,	[sp, fp]

    movz	fp,	#2396
    ldr	x0,	[sp, fp]

    movz	fp,	#2420
    mov	x10,	x0
    str	x10,	[sp, fp]

    movz	fp,	#2396
    ldr	x19,	[sp, #2344]

    mov	x1,	x19
    str	x1,	[sp, fp]

    movz	fp,	#2364
    ldr	x3,	[sp, fp]

    movz	fp,	#2380
    mov	x24,	x3
    str	x24,	[sp, #2344]

    ldr	x13,	[sp, fp]

    movz	fp,	#2364
    mov	x4,	x13
    str	x4,	[sp, fp]

    movz	fp,	#2380
    ldr	x9,	[sp, #2328]

    mov	x14,	x9
    str	x14,	[sp, fp]

    movz	fp,	#2308
    ldr	x0,	[sp, fp]

    movz	fp,	#2308
    mov	x10,	x0
    str	x10,	[sp, #2328]

    ldr	x5,	[sp, #2280]

    mov	x1,	x5
    str	x1,	[sp, fp]

    movz	fp,	#2244
    ldr	x9,	[sp, fp]

    movz	fp,	#2252
    mov	x6,	x9
    str	x6,	[sp, #2280]

    ldr	x19,	[sp, fp]

    movz	fp,	#2244
    mov	x10,	x19
    str	x10,	[sp, fp]

    movz	fp,	#2252
    ldr	x24,	[sp, #2216]

    str	x24,	[sp, fp]

    movz	fp,	#2020
    ldr	x0,	[sp, fp]

    movz	fp,	#2036
    mov	x26,	x0
    str	x26,	[sp, #2216]

    ldr	x1,	[sp, fp]

    movz	fp,	#2020
    mov	x0,	x1
    str	x0,	[sp, fp]

    movz	fp,	#2052
    ldr	x9,	[sp, fp]

    movz	fp,	#2036
    mov	x2,	x9
    str	x2,	[sp, fp]

    movz	fp,	#2052
    ldr	x4,	[sp, #1960]

    mov	x10,	x4
    str	x10,	[sp, fp]

    movz	fp,	#2108
    ldr	x7,	[sp, #1864]

    mov	x5,	x7
    str	x5,	[sp, #1960]

    ldr	x12,	[sp, #1872]

    mov	x8,	x12
    str	x8,	[sp, #1864]

    ldr	x0,	[sp, fp]

    movz	fp,	#2108
    mov	x13,	x0
    str	x13,	[sp, #1872]

    ldr	x2,	[sp, #1856]

    mov	x0,	x2
    str	x0,	[sp, fp]

    movz	fp,	#2092
    ldr	x0,	[sp, fp]

    movz	fp,	#2084
    mov	x3,	x0
    str	x3,	[sp, #1856]

    ldr	x17,	[sp, fp]

    movz	fp,	#2092
    mov	x0,	x17
    str	x0,	[sp, fp]

    movz	fp,	#1988
    ldr	x2,	[sp, fp]

    movz	fp,	#2084
    mov	x18,	x2
    str	x18,	[sp, fp]

    movz	fp,	#2076
    ldr	x0,	[sp, fp]

    movz	fp,	#1988
    mov	x3,	x0
    str	x3,	[sp, fp]

    movz	fp,	#2660
    ldr	x9,	[sp, fp]

    movz	fp,	#2076
    mov	x0,	x9
    str	x0,	[sp, fp]

    b	main_518

main_308:
    ldr	w19,	[sp, #5476]

    mov	w10,	w19
    str	w10,	[sp, #2324]

    ldr	w1,	[sp, #8000]

    str	w25,	[sp, #8000]

    mov	w1,	w25
    ldr	w6,	[sp, #5472]

    str	w24,	[sp, #5472]

    mov	w6,	w24
    ldr	w19,	[sp, #5476]

    str	w27,	[sp, #5476]

    mov	w19,	w27
    ldr	w6,	[sp, #6560]

    str	w27,	[sp, #6560]

    mov	w6,	w27
    ldr	w12,	[sp, #6564]

    str	w22,	[sp, #6564]

    mov	w12,	w22
    ldr	s30,	[sp, #1480]

    str	s11,	[sp, #1480]

    fmov	s30,	s11
    ldr	s9,	[sp, #1748]

    str	s11,	[sp, #1748]

    fmov	s9,	s11
    ldr	w0,	[sp, #2276]

    ldr	w6,	[sp, #6172]

    ldr	w4,	[sp, #6172]

    mov	w0,	w6
    str	w4,	[sp, #2276]

    ldr	s4,	[sp, #1772]

    str	s11,	[sp, #1772]

    fmov	s4,	s11
    ldr	w0,	[sp, #7996]

    str	w27,	[sp, #7996]

    mov	w0,	w27
    ldr	s27,	[sp, #1780]

    str	s11,	[sp, #1780]

    fmov	s27,	s11
    ldr	w4,	[sp, #2232]

    ldr	w0,	[sp, #6168]

    ldr	w19,	[sp, #6168]

    mov	w4,	w0
    str	w19,	[sp, #2232]

    ldr	s16,	[sp, #1776]

    str	s11,	[sp, #1776]

    fmov	s16,	s11
    ldr	s20,	[sp, #1704]

    str	s11,	[sp, #1704]

    fmov	s20,	s11
    ldr	s20,	[sp, #1740]

    str	s11,	[sp, #1740]

    fmov	s20,	s11
    ldr	s15,	[sp, #1420]

    str	s11,	[sp, #1420]

    fmov	s15,	s11
    ldr	w23,	[sp, #6572]

    str	w25,	[sp, #6572]

    mov	w23,	w25
    ldr	s1,	[sp, #1416]

    str	s11,	[sp, #1416]

    fmov	s1,	s11
    ldr	w17,	[sp, #5492]

    str	w24,	[sp, #5492]

    mov	w17,	w24
    ldr	w14,	[sp, #5504]

    str	w25,	[sp, #5504]

    mov	w14,	w25
    ldr	s8,	[sp, #1760]

    str	s11,	[sp, #1760]

    fmov	s8,	s11
    ldr	s28,	[sp, #1096]

    str	s11,	[sp, #1096]

    fmov	s28,	s11
    ldr	s18,	[sp, #1764]

    str	s11,	[sp, #1764]

    fmov	s18,	s11
    ldr	s28,	[sp, #1768]

    str	s11,	[sp, #1768]

    fmov	s28,	s11
    ldr	w10,	[sp, #5460]

    str	w22,	[sp, #5460]

    mov	w10,	w22
    ldr	s26,	[sp, #1132]

    str	s11,	[sp, #1132]

    fmov	s26,	s11
    ldr	w4,	[sp, #2104]

    ldr	w21,	[sp, #6160]

    ldr	w6,	[sp, #6160]

    mov	w4,	w21
    str	w6,	[sp, #2104]

    ldr	s29,	[sp, #1756]

    str	s11,	[sp, #1756]

    fmov	s29,	s11
    ldr	s19,	[sp, #1752]

    str	s11,	[sp, #1752]

    fmov	s19,	s11
    ldr	s8,	[sp, #1140]

    str	s11,	[sp, #1140]

    fmov	s8,	s11
    ldr	w4,	[sp, #1980]

    ldr	w9,	[sp, #6164]

    ldr	w14,	[sp, #6164]

    mov	w4,	w9
    str	w14,	[sp, #1980]

    ldr	w21,	[sp, #5464]

    str	w24,	[sp, #5464]

    mov	w21,	w24
    ldr	s30,	[sp, #1744]

    str	s11,	[sp, #1744]

    fmov	s30,	s11
    ldr	w12,	[sp, #5480]

    str	w22,	[sp, #5480]

    mov	w12,	w22
    ldr	s20,	[sp, #1124]

    str	s11,	[sp, #1124]

    fmov	s20,	s11
    ldr	w15,	[sp, #5456]

    str	w27,	[sp, #5456]

    mov	w15,	w27
    ldr	w9,	[sp, #5496]

    str	w25,	[sp, #5496]

    mov	w9,	w25
    ldr	s8,	[sp, #1092]

    str	s11,	[sp, #1092]

    fmov	s8,	s11
    ldr	s18,	[sp, #1128]

    str	s11,	[sp, #1128]

    fmov	s18,	s11
    ldr	w10,	[sp, #6144]

    str	w27,	[sp, #6144]

    mov	w10,	w27
    ldr	w28,	[sp, #5508]

    str	w27,	[sp, #5508]

    mov	w28,	w27
    ldr	s8,	[sp, #1896]

    str	s11,	[sp, #1896]

    fmov	s8,	s11
    ldr	s29,	[sp, #1104]

    str	s11,	[sp, #1104]

    fmov	s29,	s11
    ldr	s19,	[sp, #1164]

    str	s11,	[sp, #1164]

    fmov	s19,	s11
    ldr	w2,	[sp, #8016]

    str	w27,	[sp, #8016]

    mov	w2,	w27
    ldr	s9,	[sp, #1108]

    str	s11,	[sp, #1108]

    fmov	s9,	s11
    ldr	w17,	[sp, #6568]

    str	w24,	[sp, #6568]

    mov	w17,	w24
    ldr	s18,	[sp, #1156]

    str	s11,	[sp, #1156]

    fmov	s18,	s11
    b	main_309

main_305:
    ldr	s5,	[sp, #1112]

    fmov	s17,	s27
    fmov	s31,	s21
    fmov	s25,	s1
    ldr	s15,	[sp, #1888]

    fadd	s19,	s5,	s15
    ldr	s15,	[sp, #1888]

    fadd	s19,	s19,	s27
    fmov	s4,	s15
    fmov	s27,	s23
    str	s4,	[sp, #1112]

    fmov	s23,	s29
    str	s17,	[sp, #1888]

    fmov	s29,	s2
    ldr	s20,	[sp, #1484]

    fmov	s2,	s24
    ldr	s18,	[sp, #1100]

    fmov	s24,	s12
    str	s18,	[sp, #1484]

    fmov	s12,	s10
    str	s31,	[sp, #1100]

    fmov	s10,	s20
    ldr	s22,	[sp, #1508]

    str	s25,	[sp, #1508]

    fmov	s21,	s22
    ldr	s1,	[sp, #1516]

    ldr	s16,	[sp, #1524]

    fmov	s8,	s16
    str	s8,	[sp, #1516]

    ldr	s3,	[sp, #1384]

    fmov	s17,	s3
    str	s17,	[sp, #1524]

    ldr	s25,	[sp, #1380]

    fmov	s4,	s25
    str	s4,	[sp, #1384]

    ldr	s8,	[sp, #1388]

    fmov	s26,	s8
    str	s26,	[sp, #1380]

    ldr	s16,	[sp, #1392]

    fmov	s9,	s16
    str	s9,	[sp, #1388]

    ldr	s3,	[sp, #1400]

    fmov	s17,	s3
    str	s17,	[sp, #1392]

    ldr	s25,	[sp, #1396]

    fmov	s4,	s25
    str	s4,	[sp, #1400]

    ldr	s9,	[sp, #1532]

    fmov	s26,	s9
    str	s26,	[sp, #1396]

    ldr	s17,	[sp, #1536]

    fmov	s13,	s17
    fmov	s17,	s19
    str	s13,	[sp, #1532]

    ldr	s26,	[sp, #1540]

    fmov	s18,	s26
    str	s18,	[sp, #1536]

    ldr	s4,	[sp, #1544]

    fmov	s28,	s4
    str	s28,	[sp, #1540]

    ldr	s20,	[sp, #1908]

    fmov	s5,	s20
    str	s5,	[sp, #1544]

    ldr	s15,	[sp, #1560]

    fmov	s22,	s15
    str	s22,	[sp, #1908]

    ldr	s22,	[sp, #1564]

    fmov	s16,	s22
    str	s16,	[sp, #1560]

    ldr	s30,	[sp, #1880]

    fmov	s25,	s30
    str	s25,	[sp, #1564]

    ldr	s31,	[sp, #1884]

    str	s31,	[sp, #1880]

    ldr	s25,	[sp, #1120]

    fmov	s7,	s25
    str	s7,	[sp, #1884]

    ldr	s25,	[sp, #1080]

    fmov	s3,	s25
    str	s3,	[sp, #1120]

    ldr	s22,	[sp, #1136]

    fmov	s31,	s22
    str	s31,	[sp, #1080]

    ldr	s3,	[sp, #1148]

    fmov	s25,	s3
    str	s25,	[sp, #1136]

    ldr	s31,	[sp, #1160]

    fmov	s22,	s31
    str	s22,	[sp, #1148]

    ldr	s25,	[sp, #1168]

    fmov	s3,	s25
    str	s3,	[sp, #1160]

    ldr	s6,	[sp, #1176]

    str	s6,	[sp, #1168]

    ldr	s30,	[sp, #1180]

    str	s30,	[sp, #1176]

    ldr	s26,	[sp, #1196]

    str	s26,	[sp, #1180]

    str	s17,	[sp, #1196]

    b	main_148

