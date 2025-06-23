.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#12320
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w5,	#0
    str	w0,	[sp, #3392]

    mov	w27,	w5

main_10:
    cmp	w27,	#40
    bge	main_18

main_13:
    lsl	w0,	w27,	#2
    add	w25,	w0,	w27,	lsl #3
    mov	x0,	x25
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getfarray
    add	w0,	w27,	#1
    mov	w27,	w0
    b	main_10

main_18:
    movz	w6,	#0
    mov	w28,	w6

main_19:
    cmp	w28,	#24
    bge	main_27

main_22:
    lsl	w26,	w28,	#2
    add	w22,	w26,	w28,	lsl #3
    mov	x0,	x22
    add	x0,	sp,	x0
    add	x0,	x0,	#496
    bl	getarray
    add	w3,	w28,	#1
    mov	w28,	w3
    b	main_19

main_27:
    add	x13,	sp,	#16
    movz	fp,	#3300
    add	x9,	sp,	#28
    add	x27,	sp,	#52
    add	x23,	sp,	#64
    add	x18,	sp,	#76
    add	x14,	sp,	#88
    add	x10,	sp,	#100
    add	x25,	sp,	#184
    add	x21,	sp,	#196
    str	x13,	[sp, fp]

    movz	fp,	#3300
    ldr	w0,	[sp, #3392]

    lsl	w8,	w0,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#3292
    add	x7,	x19,	x8
    ldr	s27,	[x7]

    str	s27,	[sp, #1272]

    str	x9,	[sp, fp]

    movz	fp,	#3292
    ldr	w1,	[sp, #3392]

    lsl	w12,	w1,	#2
    ldr	x15,	[sp, fp]

    add	x1,	sp,	#40
    movz	fp,	#3276
    add	x11,	x15,	x12
    ldr	s24,	[x11]

    str	s24,	[sp, #1212]

    str	x1,	[sp, fp]

    movz	fp,	#3276
    ldr	w2,	[sp, #3392]

    lsl	w17,	w2,	#2
    ldr	x4,	[sp, fp]

    add	x2,	sp,	#124
    movz	fp,	#3268
    add	x15,	x4,	x17
    ldr	s1,	[x15]

    str	s1,	[sp, #1276]

    str	x27,	[sp, fp]

    movz	fp,	#3268
    ldr	w3,	[sp, #3392]

    lsl	w24,	w3,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3260
    add	x19,	x0,	x24
    add	x24,	sp,	#136
    ldr	s5,	[x19]

    str	s5,	[sp, #1280]

    str	x23,	[sp, fp]

    movz	fp,	#3260
    ldr	w4,	[sp, #3392]

    lsl	w0,	w4,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3252
    add	x28,	x27,	x0
    ldr	s9,	[x28]

    str	s9,	[sp, #1284]

    str	x18,	[sp, fp]

    movz	fp,	#3252
    ldr	w5,	[sp, #3392]

    lsl	w1,	w5,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#3244
    add	x0,	x19,	x1
    ldr	s28,	[x0]

    str	s28,	[sp, #1244]

    str	x14,	[sp, fp]

    movz	fp,	#3244
    ldr	w6,	[sp, #3392]

    lsl	w0,	w6,	#2
    ldr	x16,	[sp, fp]

    add	x6,	sp,	#112
    movz	fp,	#3236
    add	x4,	x16,	x0
    ldr	s1,	[x4]

    str	s1,	[sp, #1220]

    str	x10,	[sp, fp]

    movz	fp,	#3236
    ldr	w7,	[sp, #3392]

    lsl	w4,	w7,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#3228
    add	x8,	x12,	x4
    ldr	s4,	[x8]

    str	s4,	[sp, #1192]

    str	x6,	[sp, fp]

    movz	fp,	#3228
    ldr	w8,	[sp, #3392]

    lsl	w11,	w8,	#2
    ldr	x7,	[sp, fp]

    add	x8,	sp,	#232
    movz	fp,	#3220
    add	x12,	x7,	x11
    add	x11,	sp,	#148
    ldr	s1,	[x12]

    str	s1,	[sp, #1188]

    str	x2,	[sp, fp]

    movz	fp,	#3220
    ldr	w9,	[sp, #3392]

    lsl	w15,	w9,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#3204
    add	x16,	x3,	x15
    add	x3,	sp,	#160
    ldr	s16,	[x16]

    str	s16,	[sp, #1288]

    str	x24,	[sp, fp]

    movz	fp,	#3204
    ldr	w10,	[sp, #3392]

    lsl	w16,	w10,	#2
    ldr	x26,	[sp, fp]

    movz	fp,	#3180
    add	x23,	x26,	x16
    add	x16,	sp,	#208
    ldr	s24,	[x23]

    str	s24,	[sp, #1292]

    str	x11,	[sp, fp]

    movz	fp,	#3180
    ldr	w11,	[sp, #3392]

    lsl	w26,	w11,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#3164
    add	x0,	x12,	x26
    add	x26,	sp,	#268
    ldr	s29,	[x0]

    add	x0,	sp,	#172
    str	s29,	[sp, #1296]

    str	x3,	[sp, fp]

    movz	fp,	#3164
    ldr	w12,	[sp, #3392]

    lsl	w1,	w12,	#2
    ldr	x4,	[sp, fp]

    add	x12,	sp,	#220
    movz	fp,	#3156
    add	x1,	x4,	x1
    add	x4,	sp,	#244
    ldr	s17,	[x1]

    str	s17,	[sp, #1208]

    str	x0,	[sp, fp]

    movz	fp,	#3156
    ldr	w13,	[sp, #3392]

    lsl	w5,	w13,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3148
    add	x5,	x0,	x5
    ldr	s3,	[x5]

    str	s3,	[sp, #1300]

    str	x25,	[sp, fp]

    movz	fp,	#3148
    ldr	w14,	[sp, #3392]

    lsl	w6,	w14,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3140
    add	x9,	x27,	x6
    ldr	s7,	[x9]

    str	s7,	[sp, #1304]

    str	x21,	[sp, fp]

    movz	fp,	#3140
    ldr	w15,	[sp, #3392]

    lsl	w10,	w15,	#2
    ldr	x23,	[sp, fp]

    movz	fp,	#3132
    add	x13,	x23,	x10
    ldr	s11,	[x13]

    str	s11,	[sp, #1308]

    str	x16,	[sp, fp]

    movz	fp,	#3132
    ldr	w16,	[sp, #3392]

    lsl	w14,	w16,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#3124
    add	x17,	x18,	x14
    ldr	s24,	[x17]

    str	s24,	[sp, #1240]

    str	x12,	[sp, fp]

    movz	fp,	#3124
    ldr	w17,	[sp, #3392]

    lsl	w24,	w17,	#2
    ldr	x13,	[sp, fp]

    add	x17,	sp,	#292
    movz	fp,	#3116
    add	x24,	x13,	x24
    add	x13,	sp,	#304
    ldr	s17,	[x24]

    str	s17,	[sp, #1264]

    str	x8,	[sp, fp]

    movz	fp,	#3116
    ldr	w18,	[sp, #3392]

    lsl	w1,	w18,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#3108
    add	x0,	x9,	x1
    add	x9,	sp,	#316
    ldr	s20,	[x0]

    str	s20,	[sp, #1312]

    str	x4,	[sp, fp]

    movz	fp,	#3108
    ldr	w19,	[sp, #3392]

    lsl	w0,	w19,	#2
    ldr	x6,	[sp, fp]

    movz	fp,	#3100
    add	x2,	x6,	x0
    add	x0,	sp,	#256
    ldr	s26,	[x2]

    str	s26,	[sp, #1316]

    str	x0,	[sp, fp]

    movz	fp,	#3100
    ldr	w21,	[sp, #3392]

    lsl	w7,	w21,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3092
    add	x6,	x1,	x7
    ldr	s4,	[x6]

    add	x6,	sp,	#376
    str	s4,	[sp, #1224]

    str	x26,	[sp, fp]

    movz	fp,	#3092
    ldr	w22,	[sp, #3392]

    lsl	w8,	w22,	#2
    ldr	x28,	[sp, fp]

    add	x22,	sp,	#280
    movz	fp,	#3084
    add	x10,	x28,	x8
    ldr	s17,	[x10]

    str	s17,	[sp, #1236]

    str	x22,	[sp, fp]

    movz	fp,	#3084
    ldr	w23,	[sp, #3392]

    lsl	w12,	w23,	#2
    ldr	x24,	[sp, fp]

    add	x23,	sp,	#340
    movz	fp,	#3076
    add	x14,	x24,	x12
    ldr	s31,	[x14]

    str	s31,	[sp, #1320]

    str	x17,	[sp, fp]

    movz	fp,	#3076
    ldr	w24,	[sp, #3392]

    lsl	w16,	w24,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#3068
    add	x18,	x19,	x16
    ldr	s4,	[x18]

    add	x18,	sp,	#352
    str	s4,	[sp, #1328]

    str	x13,	[sp, fp]

    movz	fp,	#3068
    ldr	w25,	[sp, #3392]

    lsl	w26,	w25,	#2
    ldr	x14,	[sp, fp]

    movz	fp,	#3060
    add	x26,	x14,	x26
    ldr	s8,	[x26]

    str	s8,	[sp, #1332]

    str	x9,	[sp, fp]

    movz	fp,	#3060
    ldr	w26,	[sp, #3392]

    lsl	w1,	w26,	#2
    ldr	x10,	[sp, fp]

    movz	fp,	#3044
    add	x1,	x10,	x1
    ldr	s13,	[x1]

    add	x1,	sp,	#328
    str	s13,	[sp, #1336]

    str	x1,	[sp, fp]

    movz	fp,	#3044
    ldr	w27,	[sp, #3392]

    lsl	w5,	w27,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#3028
    add	x3,	x2,	x5
    add	x2,	sp,	#388
    ldr	s7,	[x3]

    str	s7,	[sp, #1256]

    str	x23,	[sp, fp]

    movz	fp,	#3028
    ldr	w28,	[sp, #3392]

    lsl	w8,	w28,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3020
    add	x7,	x25,	x8
    add	x25,	sp,	#484
    ldr	s22,	[x7]

    str	s22,	[sp, #1340]

    str	x18,	[sp, fp]

    movz	fp,	#3020
    ldr	w0,	[sp, #3392]

    lsl	w10,	w0,	#2
    ldr	x21,	[sp, fp]

    movz	fp,	#3004
    add	x11,	x21,	x10
    add	x10,	sp,	#364
    ldr	s28,	[x11]

    str	s28,	[sp, #1344]

    str	x10,	[sp, fp]

    movz	fp,	#3004
    ldr	w0,	[sp, #3392]

    lsl	w17,	w0,	#2
    ldr	x11,	[sp, fp]

    movz	fp,	#2996
    add	x15,	x11,	x17
    add	x11,	sp,	#448
    ldr	s4,	[x15]

    add	x15,	sp,	#436
    str	s4,	[sp, #1252]

    str	x6,	[sp, fp]

    movz	fp,	#2996
    ldr	w1,	[sp, #3392]

    lsl	w24,	w1,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#2988
    add	x19,	x7,	x24
    add	x24,	sp,	#412
    ldr	s11,	[x19]

    add	x19,	sp,	#424
    str	s11,	[sp, #1200]

    str	x2,	[sp, fp]

    movz	fp,	#2988
    ldr	w2,	[sp, #3392]

    lsl	w1,	w2,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#2980
    add	x28,	x3,	x1
    ldr	s2,	[x28]

    add	x28,	sp,	#400
    str	s2,	[sp, #1348]

    str	x28,	[sp, fp]

    movz	fp,	#2980
    ldr	w3,	[sp, #3392]

    lsl	w3,	w3,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#2972
    add	x0,	x0,	x3
    add	x3,	sp,	#472
    ldr	s6,	[x0]

    str	s6,	[sp, #1352]

    str	x24,	[sp, fp]

    movz	fp,	#2972
    ldr	w4,	[sp, #3392]

    lsl	w4,	w4,	#2
    ldr	x26,	[sp, fp]

    movz	fp,	#2964
    add	x4,	x26,	x4
    ldr	s7,	[x4]

    str	s7,	[sp, #1228]

    str	x19,	[sp, fp]

    movz	fp,	#2964
    ldr	w5,	[sp, #3392]

    lsl	w8,	w5,	#2
    ldr	x22,	[sp, fp]

    movz	fp,	#2956
    add	x8,	x22,	x8
    ldr	s1,	[x8]

    str	s1,	[sp, #1248]

    str	x15,	[sp, fp]

    movz	fp,	#2956
    ldr	w6,	[sp, #3392]

    lsl	w12,	w6,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#2948
    add	x12,	x17,	x12
    ldr	s10,	[x12]

    str	s10,	[sp, #1356]

    str	x11,	[sp, fp]

    movz	fp,	#2948
    ldr	w7,	[sp, #3392]

    lsl	w19,	w7,	#2
    ldr	x12,	[sp, fp]

    add	x7,	sp,	#460
    movz	fp,	#2940
    add	x16,	x12,	x19
    ldr	s11,	[x16]

    str	s11,	[sp, #1260]

    str	x7,	[sp, fp]

    movz	fp,	#2940
    ldr	w8,	[sp, #3392]

    lsl	w26,	w8,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#2932
    add	x23,	x8,	x26
    ldr	s7,	[x23]

    str	s7,	[sp, #1196]

    str	x3,	[sp, fp]

    movz	fp,	#2932
    ldr	w9,	[sp, #3392]

    lsl	w1,	w9,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#2916
    add	x0,	x4,	x1
    ldr	s28,	[x0]

    str	s28,	[sp, #1216]

    str	x25,	[sp, fp]

    movz	fp,	#2916
    ldr	w10,	[sp, #3392]

    lsl	w2,	w10,	#2
    ldr	x27,	[sp, fp]

    add	x1,	x27,	x2
    ldr	s11,	[x1]

    str	s11,	[sp, #1232]

    ldr	s5,	[sp, #1272]

    str	s5,	[sp, #1072]

    ldr	s25,	[sp, #1212]

    ldr	s2,	[sp, #1276]

    fmov	s7,	s25
    ldr	s3,	[sp, #1280]

    fmov	s1,	s2
    ldr	s25,	[sp, #1284]

    fmov	s30,	s3
    ldr	s28,	[sp, #1244]

    fmov	s17,	s25
    ldr	s12,	[sp, #1220]

    fmov	s6,	s28
    ldr	s27,	[sp, #1192]

    fmov	s16,	s12
    ldr	s23,	[sp, #1188]

    fmov	s24,	s27
    ldr	s12,	[sp, #1288]

    fmov	s20,	s23
    fmov	s31,	s12
    ldr	s23,	[sp, #1292]

    str	s23,	[sp, #1380]

    ldr	s29,	[sp, #1296]

    str	s29,	[sp, #1384]

    ldr	s10,	[sp, #1208]

    str	s10,	[sp, #1708]

    ldr	s29,	[sp, #1300]

    str	s29,	[sp, #1388]

    ldr	s22,	[sp, #1304]

    str	s22,	[sp, #1712]

    ldr	s28,	[sp, #1308]

    str	s28,	[sp, #1716]

    ldr	s8,	[sp, #1240]

    str	s8,	[sp, #1724]

    ldr	s25,	[sp, #1264]

    str	s25,	[sp, #1720]

    ldr	s22,	[sp, #1312]

    str	s22,	[sp, #1732]

    ldr	s28,	[sp, #1316]

    str	s28,	[sp, #1736]

    ldr	s8,	[sp, #1224]

    str	s8,	[sp, #1744]

    ldr	s25,	[sp, #1236]

    str	s25,	[sp, #1740]

    ldr	s21,	[sp, #1320]

    str	s21,	[sp, #1748]

    ldr	s27,	[sp, #1328]

    str	s27,	[sp, #1752]

    ldr	s2,	[sp, #1332]

    fmov	s4,	s2
    str	s4,	[sp, #1412]

    ldr	s8,	[sp, #1336]

    fmov	s22,	s8
    str	s22,	[sp, #1408]

    ldr	s26,	[sp, #1256]

    ldr	s22,	[sp, #1340]

    fmov	s14,	s26
    fmov	s23,	s22
    str	s23,	[sp, #1424]

    ldr	s4,	[sp, #1344]

    fmov	s8,	s4
    str	s8,	[sp, #1428]

    ldr	s25,	[sp, #1252]

    ldr	s26,	[sp, #1200]

    fmov	s10,	s25
    ldr	s28,	[sp, #1348]

    fmov	s13,	s26
    str	s28,	[sp, #1076]

    ldr	s29,	[sp, #1352]

    fmov	s11,	s29
    str	s11,	[sp, #1100]

    ldr	s18,	[sp, #1228]

    fmov	s28,	s18
    str	s28,	[sp, #1120]

    ldr	s12,	[sp, #1248]

    str	s12,	[sp, #1128]

    ldr	s19,	[sp, #1356]

    str	s19,	[sp, #1136]

    ldr	s12,	[sp, #1260]

    str	s12,	[sp, #1144]

    ldr	s3,	[sp, #1196]

    str	s3,	[sp, #1152]

    ldr	s19,	[sp, #1216]

    str	s19,	[sp, #1156]

    ldr	s28,	[sp, #1232]

    str	s28,	[sp, #1172]


main_148:
    movi	v4.4s,	#0
    ldr	s18,	[sp, #1172]

    fmov	s28,	s4
    fcmp	s18,	s28
    beq	main_305

main_190:
    ldr	s8,	[sp, #1072]

    fadd	s9,	s20,	s31
    add	x1,	sp,	#784
    add	x23,	sp,	#788
    add	x0,	sp,	#792
    add	x24,	sp,	#796
    add	x25,	sp,	#804
    add	x19,	sp,	#816
    add	x21,	sp,	#820
    fadd	s11,	s8,	s7
    fadd	s8,	s17,	s6
    str	s11,	[sp, #1632]

    ldr	s12,	[sp, #1632]

    fadd	s11,	s12,	s1
    str	s11,	[sp, #1636]

    ldr	s11,	[sp, #1636]

    fadd	s12,	s11,	s30
    str	s12,	[sp, #1180]

    str	s8,	[sp, #1640]

    ldr	s11,	[sp, #1640]

    fadd	s12,	s11,	s16
    str	s12,	[sp, #1644]

    ldr	s8,	[sp, #1644]

    fadd	s11,	s8,	s24
    str	s11,	[sp, #1168]

    str	s9,	[sp, #1648]

    ldr	s12,	[sp, #1380]

    ldr	s11,	[sp, #1648]

    fadd	s11,	s11,	s12
    str	s11,	[sp, #1652]

    ldr	s8,	[sp, #1384]

    ldr	s12,	[sp, #1652]

    fadd	s11,	s12,	s8
    str	s11,	[sp, #1516]

    ldr	s9,	[sp, #1388]

    ldr	s8,	[sp, #1708]

    fadd	s9,	s8,	s9
    str	s9,	[sp, #1568]

    ldr	s12,	[sp, #1712]

    ldr	s11,	[sp, #1568]

    fadd	s11,	s11,	s12
    str	s11,	[sp, #1572]

    ldr	s8,	[sp, #1716]

    ldr	s12,	[sp, #1572]

    fadd	s11,	s12,	s8
    str	s11,	[sp, #1508]

    ldr	s12,	[sp, #1720]

    ldr	s11,	[sp, #1724]

    fadd	s8,	s11,	s12
    str	s8,	[sp, #1556]

    ldr	s11,	[sp, #1732]

    ldr	s9,	[sp, #1556]

    fadd	s8,	s9,	s11
    str	s8,	[sp, #1560]

    ldr	s9,	[sp, #1736]

    ldr	s11,	[sp, #1560]

    fadd	s9,	s11,	s9
    str	s9,	[sp, #1480]

    ldr	s9,	[sp, #1740]

    ldr	s12,	[sp, #1744]

    fadd	s12,	s12,	s9
    str	s12,	[sp, #1544]

    ldr	s11,	[sp, #1748]

    ldr	s8,	[sp, #1544]

    fadd	s11,	s8,	s11
    str	s11,	[sp, #1548]

    ldr	s11,	[sp, #1752]

    ldr	s8,	[sp, #1548]

    fadd	s11,	s8,	s11
    str	s11,	[sp, #1476]

    ldr	s11,	[sp, #1408]

    ldr	s9,	[sp, #1412]

    fadd	s11,	s9,	s11
    str	s11,	[sp, #1532]

    ldr	s12,	[sp, #1532]

    fadd	s11,	s12,	s14
    str	s11,	[sp, #1536]

    ldr	s11,	[sp, #1424]

    ldr	s12,	[sp, #1536]

    fadd	s9,	s12,	s11
    str	s9,	[sp, #1468]

    ldr	s8,	[sp, #1428]

    fadd	s10,	s8,	s10
    str	s10,	[sp, #1512]

    ldr	s11,	[sp, #1512]

    fadd	s13,	s11,	s13
    str	s13,	[sp, #1488]

    ldr	s10,	[sp, #1076]

    ldr	s13,	[sp, #1488]

    fadd	s9,	s13,	s10
    str	s9,	[sp, #1464]

    ldr	s9,	[sp, #1100]

    ldr	s13,	[sp, #1120]

    fadd	s9,	s9,	s13
    str	s9,	[sp, #1492]

    ldr	s9,	[sp, #1128]

    ldr	s8,	[sp, #1492]

    fadd	s12,	s8,	s9
    str	s12,	[sp, #1496]

    ldr	s9,	[sp, #1136]

    ldr	s13,	[sp, #1496]

    fadd	s8,	s13,	s9
    str	s8,	[sp, #1472]

    ldr	s12,	[sp, #1144]

    ldr	s8,	[sp, #1152]

    fadd	s8,	s12,	s8
    str	s8,	[sp, #1500]

    ldr	s8,	[sp, #1156]

    ldr	s10,	[sp, #1500]

    fadd	s11,	s10,	s8
    str	s11,	[sp, #1504]

    ldr	s12,	[sp, #1172]

    ldr	s11,	[sp, #1504]

    fadd	s10,	s11,	s12
    str	s10,	[sp, #1484]

    ldr	s10,	[sp, #1180]

    str	s10,	[x1]

    ldr	s13,	[sp, #1168]

    str	s13,	[x23]

    ldr	s14,	[sp, #1516]

    str	s14,	[x0]

    add	x0,	sp,	#800
    ldr	s8,	[sp, #1508]

    str	s8,	[x24]

    ldr	s8,	[sp, #1480]

    str	s8,	[x0]

    add	x0,	sp,	#808
    ldr	s12,	[sp, #1476]

    str	s12,	[x25]

    ldr	s13,	[sp, #1468]

    str	s13,	[x0]

    ldr	s10,	[sp, #1464]

    add	x0,	sp,	#812
    str	s10,	[x0]

    movz	w0,	#10
    ldr	s9,	[sp, #1472]

    str	s9,	[x19]

    ldr	s11,	[sp, #1484]

    str	s11,	[x21]

    bl	putfarray
    add	x10,	sp,	#700
    add	x22,	sp,	#568
    add	x28,	sp,	#496
    add	x0,	sp,	#772
    ldr	w11,	[sp, #3392]

    add	x17,	sp,	#760
    movz	fp,	#3332
    lsl	w19,	w11,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#784
    ldr	s24,	[x18]

    str	s24,	[sp, #1268]

    str	x0,	[sp, fp]

    add	x0,	sp,	#520
    movz	fp,	#3332
    ldr	w12,	[sp, #3392]

    ldr	x1,	[sp, fp]

    lsl	w4,	w12,	#2
    movz	fp,	#3316
    add	x26,	x1,	x4
    ldr	w25,	[x26]

    add	x26,	sp,	#508
    str	w25,	[sp, #2352]

    ldr	w21,	[sp, #3392]

    lsl	w4,	w21,	#2
    add	x21,	sp,	#544
    add	x1,	x0,	x4
    add	x4,	sp,	#556
    ldr	w24,	[x1]

    str	w24,	[sp, #3388]

    str	x22,	[sp, fp]

    movz	fp,	#3316
    ldr	w14,	[sp, #3392]

    lsl	w2,	w14,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3324
    add	x0,	x25,	x2
    ldr	w14,	[x0]

    str	w14,	[sp, #2288]

    str	x26,	[sp, fp]

    movz	fp,	#3324
    ldr	w15,	[sp, #3392]

    lsl	w18,	w15,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3308
    add	x5,	x0,	x18
    ldr	w25,	[x5]

    str	w25,	[sp, #3360]

    ldr	w24,	[sp, #3392]

    lsl	w5,	w24,	#2
    add	x25,	x21,	x5
    add	x5,	sp,	#724
    ldr	w7,	[x25]

    str	w7,	[sp, #3372]

    add	x7,	sp,	#616
    ldr	w24,	[sp, #3392]

    lsl	w26,	w24,	#2
    add	x24,	sp,	#628
    add	x3,	x4,	x26
    ldr	w0,	[x3]

    str	w0,	[sp, #3364]

    str	x17,	[sp, fp]

    movz	fp,	#3308
    ldr	w18,	[sp, #3392]

    lsl	w6,	w18,	#2
    ldr	x20,	[sp, fp]

    movz	fp,	#3212
    add	x27,	x20,	x6
    ldr	w15,	[x27]

    str	w15,	[sp, #6100]

    add	x15,	sp,	#580
    str	x28,	[sp, fp]

    movz	fp,	#3212
    ldr	w19,	[sp, #3392]

    lsl	w4,	w19,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#3284
    add	x3,	x0,	x4
    ldr	w19,	[x3]

    str	w19,	[sp, #3384]

    str	x5,	[sp, fp]

    movz	fp,	#3284
    ldr	w21,	[sp, #3392]

    lsl	w18,	w21,	#2
    ldr	x8,	[sp, fp]

    movz	fp,	#3188
    add	x13,	x8,	x18
    add	x8,	sp,	#592
    ldr	w27,	[x13]

    str	w27,	[sp, #2040]

    str	x15,	[sp, fp]

    movz	fp,	#3188
    ldr	w22,	[sp, #3392]

    lsl	w13,	w22,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#3172
    add	x12,	x19,	x13
    ldr	w14,	[x12]

    str	w14,	[sp, #1776]

    str	x7,	[sp, fp]

    movz	fp,	#3172
    ldr	w23,	[sp, #3392]

    lsl	w4,	w23,	#2
    ldr	x11,	[sp, fp]

    add	x23,	sp,	#652
    movz	fp,	#3196
    add	x5,	x11,	x4
    add	x11,	sp,	#640
    ldr	w12,	[x5]

    str	w12,	[sp, #6096]

    str	x23,	[sp, fp]

    movz	fp,	#3196
    ldr	w27,	[sp, #3392]

    lsl	w13,	w27,	#2
    ldr	x27,	[sp, fp]

    movz	fp,	#3052
    add	x9,	x27,	x13
    ldr	w9,	[x9]

    str	w9,	[sp, #6092]

    ldr	w2,	[sp, #3392]

    lsl	w17,	w2,	#2
    add	x25,	x8,	x17
    ldr	w23,	[x25]

    str	w23,	[sp, #3352]

    ldr	w3,	[sp, #3392]

    lsl	w7,	w3,	#2
    add	x2,	x10,	x7
    ldr	w17,	[x2]

    str	w17,	[sp, #3376]

    ldr	w9,	[sp, #3392]

    add	x17,	sp,	#712
    lsl	w3,	w9,	#2
    add	x4,	x17,	x3
    ldr	w3,	[x4]

    add	x4,	sp,	#604
    str	w3,	[sp, #3368]

    ldr	w12,	[sp, #3392]

    lsl	w7,	w12,	#2
    add	x8,	x4,	x7
    ldr	w14,	[x8]

    str	w14,	[sp, #3344]

    str	x11,	[sp, fp]

    movz	fp,	#3052
    ldr	w1,	[sp, #3392]

    lsl	w2,	w1,	#2
    ldr	x9,	[sp, fp]

    add	x1,	sp,	#688
    movz	fp,	#3012
    add	x17,	x9,	x2
    add	x9,	sp,	#532
    ldr	w25,	[x17]

    str	w25,	[sp, #5436]

    add	x25,	sp,	#748
    str	x24,	[sp, fp]

    movz	fp,	#3012
    ldr	w0,	[sp, #3392]

    lsl	w4,	w0,	#2
    ldr	x21,	[sp, fp]

    movz	fp,	#3036
    add	x10,	x21,	x4
    add	x4,	sp,	#736
    ldr	w19,	[x10]

    str	w19,	[sp, #5408]

    str	x1,	[sp, fp]

    movz	fp,	#3036
    ldr	w1,	[sp, #3392]

    lsl	w18,	w1,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#2924
    add	x16,	x0,	x18
    ldr	w6,	[x16]

    str	w6,	[sp, #7476]

    str	x9,	[sp, fp]

    movz	fp,	#2924
    ldr	w2,	[sp, #3392]

    lsl	w24,	w2,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#2908
    add	x8,	x1,	x24
    ldr	w1,	[x8]

    str	w1,	[sp, #3380]

    ldr	w21,	[sp, #3392]

    lsl	w12,	w21,	#2
    add	x16,	x25,	x12
    ldr	w1,	[x16]

    str	w1,	[sp, #3356]

    add	x1,	sp,	#676
    ldr	w24,	[sp, #3392]

    lsl	w13,	w24,	#2
    add	x8,	x4,	x13
    add	x4,	sp,	#664
    ldr	w24,	[x8]

    str	w24,	[sp, #3348]

    str	x1,	[sp, fp]

    movz	fp,	#2908
    ldr	w12,	[sp, #3392]

    lsl	w12,	w12,	#2
    ldr	x3,	[sp, fp]

    add	x27,	x3,	x12
    ldr	w1,	[x27]

    ldr	w2,	[sp, #3392]

    lsl	w18,	w2,	#2
    add	x9,	x4,	x18
    ldr	w11,	[x9]

    str	w11,	[sp, #3340]

    ldr	w4,	[sp, #2352]

    str	w4,	[sp, #2300]

    ldr	w3,	[sp, #3388]

    mov	w18,	w3
    str	w18,	[sp, #6632]

    ldr	w28,	[sp, #2288]

    str	w28,	[sp, #5412]

    ldr	s11,	[sp, #1284]

    ldr	w15,	[sp, #3360]

    fmov	s28,	s11
    mov	w3,	w15
    str	w3,	[sp, #5416]

    ldr	w23,	[sp, #3372]

    mov	w24,	w23
    str	w24,	[sp, #6636]

    ldr	w7,	[sp, #3364]

    mov	w20,	w7
    str	w20,	[sp, #5404]

    ldr	s30,	[sp, #1188]

    ldr	s10,	[sp, #1308]

    fmov	s22,	s30
    fmov	s18,	s10
    ldr	s10,	[sp, #1192]

    ldr	w22,	[sp, #6100]

    mov	w26,	w22
    str	w26,	[sp, #2156]

    ldr	s13,	[sp, #1280]

    ldr	s11,	[sp, #1344]

    fmov	s6,	s13
    str	s11,	[sp, #1608]

    ldr	w24,	[sp, #3384]

    mov	w13,	w24
    str	w13,	[sp, #7488]

    ldr	s25,	[sp, #1196]

    str	s25,	[sp, #1620]

    ldr	w25,	[sp, #2040]

    mov	w21,	w25
    str	w21,	[sp, #2188]

    ldr	s17,	[sp, #1200]

    str	s17,	[sp, #1612]

    ldr	s23,	[sp, #1208]

    ldr	s19,	[sp, #1212]

    fmov	s29,	s23
    ldr	s23,	[sp, #1296]

    ldr	s14,	[sp, #1216]

    fmov	s31,	s23
    str	s14,	[sp, #1656]

    ldr	s23,	[sp, #1220]

    ldr	w21,	[sp, #1776]

    fmov	s27,	s23
    mov	w0,	w21
    str	w0,	[sp, #6640]

    ldr	s16,	[sp, #1352]

    str	s16,	[sp, #1628]

    ldr	w21,	[sp, #6096]

    mov	w16,	w21
    str	w16,	[sp, #5424]

    ldr	w18,	[sp, #6092]

    mov	w9,	w18
    str	w9,	[sp, #5448]

    ldr	s21,	[sp, #1224]

    ldr	s7,	[sp, #1228]

    fmov	s1,	s21
    str	s7,	[sp, #1112]

    ldr	s4,	[sp, #1328]

    str	s4,	[sp, #1596]

    ldr	s30,	[sp, #1288]

    ldr	s24,	[sp, #1336]

    fmov	s7,	s30
    str	s24,	[sp, #1600]

    ldr	w28,	[sp, #3352]

    mov	w9,	w28
    str	w9,	[sp, #6648]

    ldr	s30,	[sp, #1232]

    str	s30,	[sp, #1116]

    ldr	w12,	[sp, #3376]

    mov	w2,	w12
    str	w2,	[sp, #2016]

    ldr	s26,	[sp, #1236]

    str	s26,	[sp, #1592]

    ldr	s4,	[sp, #1240]

    ldr	s14,	[sp, #1244]

    fmov	s11,	s4
    ldr	s2,	[sp, #1248]

    fmov	s30,	s14
    str	s2,	[sp, #1092]

    ldr	w2,	[sp, #3368]

    mov	w8,	w2
    str	w8,	[sp, #2044]

    ldr	w22,	[sp, #3344]

    mov	w14,	w22
    str	w14,	[sp, #6688]

    ldr	s8,	[sp, #1304]

    ldr	s25,	[sp, #1292]

    fmov	s21,	s8
    str	s25,	[sp, #1936]

    ldr	s9,	[sp, #1272]

    ldr	w14,	[sp, #5436]

    fmov	s16,	s9
    mov	w11,	w14
    str	w11,	[sp, #5420]

    ldr	s20,	[sp, #1348]

    str	s20,	[sp, #1064]

    ldr	w6,	[sp, #5408]

    mov	w4,	w6
    str	w4,	[sp, #6644]

    ldr	w8,	[sp, #7476]

    mov	w9,	w8
    str	w9,	[sp, #5432]

    ldr	s5,	[sp, #1340]

    fmov	s2,	s5
    str	s2,	[sp, #1104]

    ldr	s25,	[sp, #1332]

    ldr	s20,	[sp, #1300]

    fmov	s12,	s25
    ldr	s23,	[sp, #1252]

    fmov	s24,	s20
    str	s23,	[sp, #1088]

    ldr	w22,	[sp, #3380]

    mov	w2,	w22
    str	w2,	[sp, #7472]

    mov	w2,	w1
    ldr	w8,	[sp, #3356]

    mov	w12,	w8
    str	w12,	[sp, #6088]

    ldr	w11,	[sp, #3348]

    mov	w19,	w11
    str	w19,	[sp, #5452]

    ldr	s5,	[sp, #1312]

    ldr	s2,	[sp, #1316]

    fmov	s17,	s5
    ldr	s25,	[sp, #1320]

    fmov	s3,	s2
    ldr	s9,	[sp, #1256]

    fmov	s4,	s25
    ldr	s8,	[sp, #1260]

    fmov	s2,	s9
    str	s8,	[sp, #1140]

    ldr	s5,	[sp, #1264]

    str	w2,	[sp, #5428]

    ldr	s14,	[sp, #1276]

    str	s14,	[sp, #1080]

    ldr	w12,	[sp, #3340]

    mov	w23,	w12
    str	w23,	[sp, #12304]

    ldr	s23,	[sp, #1356]

    str	s23,	[sp, #1132]


main_309:
    ldr	w12,	[sp, #2300]

    cmp	w12,	#0
    beq	main_308

main_375:
    fadd	s8,	s16,	s19
    add	x20,	sp,	#944
    movz	fp,	#1964
    add	x19,	sp,	#948
    add	x25,	sp,	#988
    str	s8,	[sp, #1124]

    fadd	s8,	s28,	s30
    ldr	s15,	[sp, #1080]

    fadd	s8,	s8,	s27
    ldr	s9,	[sp, #1124]

    fadd	s13,	s9,	s15
    fadd	s15,	s8,	s10
    str	s13,	[sp, #1912]

    fadd	s10,	s22,	s7
    ldr	s14,	[sp, #1912]

    fadd	s13,	s14,	s6
    str	s13,	[sp, #1184]

    str	s15,	[sp, #1176]

    ldr	s9,	[sp, #1936]

    fadd	s13,	s10,	s9
    fadd	s15,	s13,	s31
    fadd	s13,	s29,	s24
    str	s15,	[sp, #1164]

    fadd	s10,	s13,	s21
    fadd	s15,	s11,	s5
    fadd	s14,	s10,	s18
    fadd	s15,	s15,	s17
    str	s14,	[sp, #1148]

    fadd	s9,	s15,	s3
    str	s9,	[sp, #1680]

    ldr	s14,	[sp, #1592]

    ldr	s10,	[sp, #1596]

    fadd	s11,	s1,	s14
    fadd	s11,	s11,	s4
    fadd	s14,	s11,	s10
    str	s14,	[sp, #1676]

    ldr	s15,	[sp, #1600]

    fadd	s8,	s12,	s15
    ldr	s15,	[sp, #1104]

    fadd	s8,	s8,	s2
    fadd	s11,	s8,	s15
    str	s11,	[sp, #1916]

    ldr	s8,	[sp, #1088]

    ldr	s15,	[sp, #1608]

    ldr	s12,	[sp, #1612]

    fadd	s10,	s15,	s8
    ldr	s13,	[sp, #1064]

    fadd	s12,	s10,	s12
    fadd	s15,	s12,	s13
    str	s15,	[sp, #1952]

    ldr	s10,	[sp, #1112]

    ldr	s8,	[sp, #1628]

    ldr	s13,	[sp, #1092]

    fadd	s12,	s8,	s10
    ldr	s11,	[sp, #1132]

    fadd	s8,	s12,	s13
    ldr	s12,	[sp, #1140]

    fadd	s11,	s8,	s11
    ldr	s10,	[sp, #1620]

    ldr	s15,	[sp, #1656]

    fadd	s12,	s12,	s10
    fadd	s8,	s12,	s15
    ldr	s12,	[sp, #1116]

    str	x20,	[sp, fp]

    fadd	s13,	s8,	s12
    movz	fp,	#1964
    ldr	s14,	[sp, #1184]

    ldr	x20,	[sp, fp]

    movz	fp,	#4916
    str	s14,	[x20]

    ldr	s8,	[sp, #1176]

    str	s8,	[x19]

    ldr	s14,	[sp, #1164]

    add	x19,	sp,	#952
    str	s14,	[x19]

    ldr	s8,	[sp, #1148]

    add	x19,	sp,	#956
    str	s8,	[x19]

    ldr	s12,	[sp, #1680]

    add	x19,	sp,	#960
    str	s12,	[x19]

    ldr	s8,	[sp, #1676]

    add	x19,	sp,	#964
    str	s8,	[x19]

    ldr	s12,	[sp, #1916]

    add	x19,	sp,	#968
    str	s12,	[x19]

    ldr	s14,	[sp, #1952]

    add	x19,	sp,	#972
    str	s14,	[x19]

    add	x19,	sp,	#976
    str	s11,	[x19]

    add	x19,	sp,	#980
    str	s13,	[x19]

    ldr	w28,	[sp, #5416]

    ldr	w24,	[sp, #6632]

    ldr	w23,	[sp, #7488]

    add	w19,	w28,	w24
    add	w27,	w19,	w23
    str	w27,	[sp, #5020]

    ldr	w27,	[sp, #5404]

    ldr	w0,	[sp, #6636]

    ldr	w26,	[sp, #7472]

    add	w0,	w27,	w0
    add	w0,	w0,	w26
    str	w0,	[sp, #2012]

    ldr	w0,	[sp, #5412]

    ldr	w21,	[sp, #6640]

    ldr	w23,	[sp, #6648]

    add	w0,	w21,	w0
    add	w19,	w0,	w23
    str	w19,	[sp, #2036]

    ldr	w26,	[sp, #5424]

    ldr	w1,	[sp, #6688]

    ldr	w18,	[sp, #6644]

    add	w0,	w1,	w26
    add	w21,	w0,	w18
    str	w21,	[sp, #5072]

    ldr	w28,	[sp, #5420]

    ldr	w18,	[sp, #5448]

    ldr	w26,	[sp, #12304]

    add	w0,	w28,	w18
    add	w26,	w0,	w26
    str	w26,	[sp, #1976]

    ldr	w28,	[sp, #2016]

    ldr	w0,	[sp, #5432]

    ldr	w19,	[sp, #5428]

    add	w0,	w0,	w28
    add	w23,	w0,	w19
    str	w23,	[sp, #1972]

    ldr	w1,	[sp, #2044]

    ldr	w23,	[sp, #2188]

    add	w0,	w1,	w23
    ldr	w23,	[sp, #5452]

    add	w0,	w0,	w23
    str	w0,	[sp, #2000]

    ldr	w24,	[sp, #2156]

    ldr	w26,	[sp, #2300]

    ldr	w21,	[sp, #6088]

    add	w1,	w24,	w26
    add	x26,	sp,	#984
    add	w0,	w1,	w21
    str	w0,	[sp, #2004]

    add	x0,	sp,	#992
    str	x26,	[sp, fp]

    movz	fp,	#4916
    ldr	x22,	[sp, fp]

    movz	fp,	#3764
    ldr	w26,	[sp, #5020]

    str	w26,	[x22]

    str	x25,	[sp, fp]

    movz	fp,	#3764
    ldr	w1,	[sp, #2012]

    ldr	x26,	[sp, fp]

    movz	fp,	#4876
    str	w1,	[x26]

    str	x0,	[sp, fp]

    movz	fp,	#4876
    ldr	w0,	[sp, #2036]

    ldr	x1,	[sp, fp]

    movz	fp,	#4900
    str	w0,	[x1]

    add	x1,	sp,	#996
    str	x1,	[sp, fp]

    add	x1,	sp,	#1000
    movz	fp,	#4900
    ldr	x23,	[sp, fp]

    movz	fp,	#1964
    ldr	w0,	[sp, #5072]

    str	w0,	[x23]

    add	x0,	sp,	#1004
    str	x1,	[sp, #2192]

    ldr	w18,	[sp, #1976]

    ldr	x24,	[sp, #2192]

    str	w18,	[x24]

    add	x24,	sp,	#1012
    str	x0,	[sp, #2224]

    ldr	w0,	[sp, #1972]

    ldr	x1,	[sp, #2224]

    str	w0,	[x1]

    movz	w0,	#10
    add	x1,	sp,	#1008
    str	x1,	[sp, #2232]

    ldr	w1,	[sp, #2000]

    ldr	x21,	[sp, #2232]

    str	w1,	[x21]

    str	x24,	[sp, #2240]

    ldr	w27,	[sp, #2004]

    ldr	x25,	[sp, #2240]

    str	w27,	[x25]

    ldr	x1,	[sp, fp]

    bl	putfarray
    movz	fp,	#4916
    movz	w0,	#8
    ldr	x1,	[sp, fp]

    bl	putarray
    add	x17,	sp,	#924
    ldr	w14,	[sp, #5020]

    movz	fp,	#4916
    ldr	s30,	[sp, #1184]

    scvtf	s8,	w14
    ldr	x14,	[sp, fp]

    fsub	s8,	s8,	s30
    movz	fp,	#3764
    fcvtzs	w0,	s8
    str	w0,	[x14]

    ldr	w0,	[sp, #2012]

    ldr	s23,	[sp, #1176]

    scvtf	s10,	w0
    ldr	x15,	[sp, fp]

    fsub	s4,	s10,	s23
    movz	fp,	#4876
    fcvtzs	w3,	s4
    str	w3,	[x15]

    ldr	w3,	[sp, #2036]

    ldr	s5,	[sp, #1164]

    scvtf	s6,	w3
    ldr	x19,	[sp, fp]

    fsub	s22,	s6,	s5
    movz	fp,	#4900
    fcvtzs	w6,	s22
    str	w6,	[x19]

    ldr	w7,	[sp, #5072]

    ldr	s14,	[sp, #1148]

    scvtf	s24,	w7
    ldr	x2,	[sp, fp]

    fsub	s8,	s24,	s14
    movz	fp,	#3300
    fcvtzs	w10,	s8
    str	w10,	[x2]

    ldr	w7,	[sp, #1976]

    ldr	s15,	[sp, #1680]

    scvtf	s12,	w7
    ldr	x23,	[sp, #2192]

    fsub	s11,	s12,	s15
    fcvtzs	w12,	s11
    str	w12,	[x23]

    ldr	w11,	[sp, #1972]

    ldr	s11,	[sp, #1676]

    scvtf	s17,	w11
    ldr	x11,	[sp, #2224]

    fsub	s15,	s17,	s11
    fcvtzs	w16,	s15
    str	w16,	[x11]

    ldr	w19,	[sp, #2000]

    ldr	s9,	[sp, #1916]

    scvtf	s17,	w19
    ldr	x15,	[sp, #2232]

    fsub	s11,	s17,	s9
    fcvtzs	w22,	s11
    str	w22,	[x15]

    ldr	w23,	[sp, #2004]

    ldr	s5,	[sp, #1952]

    scvtf	s13,	w23
    ldr	x19,	[sp, #2240]

    fsub	s13,	s13,	s5
    fcvtzs	w2,	s13
    str	w2,	[x19]

    ldr	w7,	[sp, #3392]

    lsl	w4,	w7,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#984
    ldr	w5,	[x3]

    ldr	x15,	[sp, fp]

    scvtf	s14,	w5
    movz	fp,	#4924
    mov	x26,	x15
    str	x26,	[sp, fp]

    movz	fp,	#3292
    ldr	x11,	[sp, fp]

    movz	fp,	#2788
    mov	x18,	x11
    str	x18,	[sp, fp]

    movz	fp,	#3276
    ldr	x3,	[sp, fp]

    movz	fp,	#3268
    mov	x14,	x3
    ldr	x0,	[sp, fp]

    movz	fp,	#4940
    mov	x5,	x0
    str	x5,	[sp, fp]

    movz	fp,	#3260
    ldr	x27,	[sp, fp]

    movz	fp,	#4956
    mov	x13,	x27
    str	x13,	[sp, fp]

    movz	fp,	#3252
    ldr	x23,	[sp, fp]

    movz	fp,	#2796
    mov	x25,	x23
    str	x25,	[sp, fp]

    movz	fp,	#3244
    ldr	x19,	[sp, fp]

    movz	fp,	#2804
    mov	x0,	x19
    str	x0,	[sp, fp]

    movz	fp,	#3236
    ldr	x12,	[sp, fp]

    movz	fp,	#2812
    mov	x1,	x12
    str	x1,	[sp, fp]

    movz	fp,	#3228
    ldr	x8,	[sp, fp]

    movz	fp,	#2820
    mov	x5,	x8
    str	x5,	[sp, fp]

    movz	fp,	#3220
    ldr	x4,	[sp, fp]

    movz	fp,	#4972
    mov	x23,	x4
    str	x23,	[sp, fp]

    movz	fp,	#3204
    ldr	x28,	[sp, fp]

    movz	fp,	#4988
    mov	x0,	x28
    add	x28,	sp,	#904
    str	x0,	[sp, fp]

    movz	fp,	#3180
    ldr	x13,	[sp, fp]

    movz	fp,	#4996
    mov	x3,	x13
    str	x3,	[sp, fp]

    movz	fp,	#3164
    ldr	x5,	[sp, fp]

    movz	fp,	#2828
    mov	x9,	x5
    str	x9,	[sp, fp]

    movz	fp,	#3156
    ldr	x1,	[sp, fp]

    movz	fp,	#3148
    mov	x13,	x1
    mov	x15,	x13
    ldr	x0,	[sp, fp]

    movz	fp,	#5004
    mov	x6,	x0
    str	x6,	[sp, fp]

    movz	fp,	#3140
    ldr	x27,	[sp, fp]

    movz	fp,	#5012
    mov	x9,	x27
    str	x9,	[sp, fp]

    movz	fp,	#3132
    ldr	x23,	[sp, fp]

    movz	fp,	#2836
    mov	x19,	x23
    str	x19,	[sp, fp]

    movz	fp,	#3124
    ldr	x19,	[sp, fp]

    movz	fp,	#2844
    mov	x23,	x19
    str	x23,	[sp, fp]

    movz	fp,	#3116
    ldr	x10,	[sp, fp]

    movz	fp,	#3108
    mov	x20,	x10
    str	x20,	[sp, #5024]

    ldr	x6,	[sp, fp]

    movz	fp,	#3100
    mov	x23,	x6
    str	x23,	[sp, #5032]

    ldr	x2,	[sp, fp]

    movz	fp,	#2852
    mov	x0,	x2
    str	x0,	[sp, fp]

    movz	fp,	#3092
    ldr	x2,	[sp, fp]

    movz	fp,	#2860
    mov	x0,	x2
    str	x0,	[sp, fp]

    movz	fp,	#3084
    ldr	x2,	[sp, fp]

    movz	fp,	#3076
    mov	x26,	x2
    str	x26,	[sp, #5040]

    ldr	x0,	[sp, fp]

    movz	fp,	#3068
    str	x0,	[sp, #5048]

    ldr	x26,	[sp, fp]

    movz	fp,	#3060
    mov	x1,	x26
    str	x1,	[sp, #5056]

    ldr	x21,	[sp, fp]

    movz	fp,	#3044
    mov	x2,	x21
    str	x2,	[sp, #5064]

    ldr	x4,	[sp, fp]

    movz	fp,	#2868
    mov	x0,	x4
    add	x4,	sp,	#912
    str	x0,	[sp, fp]

    movz	fp,	#3028
    ldr	x3,	[sp, fp]

    movz	fp,	#5076
    mov	x9,	x3
    str	x9,	[sp, fp]

    movz	fp,	#3020
    ldr	x12,	[sp, fp]

    movz	fp,	#5084
    str	x12,	[sp, fp]

    movz	fp,	#3004
    ldr	x0,	[sp, fp]

    movz	fp,	#2876
    mov	x12,	x0
    str	x12,	[sp, fp]

    movz	fp,	#2996
    ldr	x24,	[sp, fp]

    movz	fp,	#2884
    str	x24,	[sp, fp]

    movz	fp,	#2988
    ldr	x12,	[sp, fp]

    movz	fp,	#5092
    mov	x19,	x12
    add	x12,	sp,	#936
    str	x19,	[sp, fp]

    movz	fp,	#2980
    ldr	x0,	[sp, fp]

    movz	fp,	#5100
    mov	x22,	x0
    str	x22,	[sp, fp]

    movz	fp,	#2972
    ldr	x7,	[sp, fp]

    movz	fp,	#2892
    str	x7,	[sp, fp]

    mov	x7,	x14
    movz	fp,	#2964
    ldr	x5,	[sp, fp]

    movz	fp,	#2900
    mov	x26,	x5
    str	x26,	[sp, fp]

    movz	fp,	#2956
    ldr	x26,	[sp, fp]

    movz	fp,	#2948
    mov	x23,	x26
    add	x26,	sp,	#932
    str	x23,	[sp, #7480]

    add	x23,	sp,	#908
    ldr	x18,	[sp, fp]

    movz	fp,	#5116
    mov	x24,	x18
    str	x24,	[sp, fp]

    add	x24,	sp,	#916
    movz	fp,	#2940
    ldr	x16,	[sp, fp]

    movz	fp,	#5124
    mov	x27,	x16
    str	x27,	[sp, fp]

    movz	fp,	#2932
    ldr	x2,	[sp, fp]

    movz	fp,	#5132
    mov	x1,	x2
    str	x1,	[sp, fp]

    movz	fp,	#2916
    ldr	x19,	[sp, fp]

    movz	fp,	#5148
    mov	x0,	x19
    str	x0,	[sp, fp]

    movz	fp,	#2748
    str	x28,	[sp, fp]

    add	x28,	sp,	#928
    movz	fp,	#2564
    str	x23,	[sp, fp]

    add	x23,	sp,	#940
    movz	fp,	#2572
    str	x4,	[sp, fp]

    movz	fp,	#2596
    add	x4,	sp,	#920
    str	x24,	[sp, #2584]

    str	x4,	[sp, fp]

    movz	fp,	#2604
    str	x17,	[sp, fp]

    movz	fp,	#2636
    str	x28,	[sp, #2616]

    str	x26,	[sp, #2624]

    str	x12,	[sp, fp]

    movz	fp,	#2644
    str	x23,	[sp, fp]

    movz	fp,	#4924
    ldr	x0,	[sp, fp]

    movz	fp,	#2788
    str	x0,	[sp, #5440]

    ldr	x26,	[sp, fp]

    movz	fp,	#2708
    mov	x19,	x26
    str	x19,	[sp, fp]

    movz	fp,	#4940
    str	x7,	[sp, #1056]

    ldr	x0,	[sp, fp]

    movz	fp,	#4956
    mov	x20,	x0
    str	x20,	[sp, #1040]

    ldr	x8,	[sp, fp]

    movz	fp,	#2660
    mov	x20,	x8
    str	x20,	[sp, fp]

    movz	fp,	#2796
    ldr	x26,	[sp, fp]

    movz	fp,	#2804
    str	x26,	[sp, #2672]

    ldr	x26,	[sp, fp]

    movz	fp,	#2684
    mov	x14,	x26
    str	x14,	[sp, fp]

    movz	fp,	#2812
    ldr	x4,	[sp, fp]

    movz	fp,	#2820
    mov	x7,	x4
    str	x7,	[sp, #1016]

    ldr	x4,	[sp, fp]

    movz	fp,	#4972
    mov	x24,	x4
    str	x24,	[sp, #1024]

    ldr	x18,	[sp, fp]

    movz	fp,	#2652
    mov	x4,	x18
    str	x4,	[sp, fp]

    movz	fp,	#4988
    ldr	x26,	[sp, fp]

    movz	fp,	#2548
    mov	x12,	x26
    str	x12,	[sp, fp]

    movz	fp,	#4996
    ldr	x0,	[sp, fp]

    movz	fp,	#2516
    mov	x14,	x0
    str	x14,	[sp, fp]

    movz	fp,	#2828
    ldr	x26,	[sp, fp]

    movz	fp,	#2540
    mov	x4,	x26
    str	x4,	[sp, fp]

    movz	fp,	#2524
    str	x15,	[sp, fp]

    movz	fp,	#5004
    ldr	x1,	[sp, fp]

    movz	fp,	#2500
    mov	x18,	x1
    str	x18,	[sp, fp]

    movz	fp,	#5012
    ldr	x5,	[sp, fp]

    movz	fp,	#2476
    mov	x18,	x5
    str	x18,	[sp, fp]

    movz	fp,	#2836
    ldr	x2,	[sp, fp]

    movz	fp,	#2484
    mov	x19,	x2
    str	x19,	[sp, fp]

    movz	fp,	#2844
    ldr	x4,	[sp, fp]

    movz	fp,	#2492
    mov	x15,	x4
    str	x15,	[sp, fp]

    movz	fp,	#2468
    ldr	x12,	[sp, #5024]

    mov	x2,	x12
    str	x2,	[sp, fp]

    movz	fp,	#2420
    ldr	x15,	[sp, #5032]

    mov	x25,	x15
    str	x25,	[sp, fp]

    movz	fp,	#2852
    ldr	x4,	[sp, fp]

    movz	fp,	#2436
    mov	x18,	x4
    str	x18,	[sp, fp]

    movz	fp,	#2860
    ldr	x26,	[sp, fp]

    movz	fp,	#2452
    mov	x27,	x26
    str	x27,	[sp, fp]

    movz	fp,	#2404
    ldr	x18,	[sp, #5040]

    mov	x28,	x18
    str	x28,	[sp, fp]

    movz	fp,	#2388
    ldr	x21,	[sp, #5048]

    mov	x7,	x21
    str	x7,	[sp, fp]

    movz	fp,	#2364
    ldr	x24,	[sp, #5056]

    mov	x4,	x24
    str	x4,	[sp, fp]

    movz	fp,	#2868
    ldr	x27,	[sp, #5064]

    mov	x12,	x27
    str	x12,	[sp, #2328]

    ldr	x26,	[sp, fp]

    movz	fp,	#5076
    mov	x24,	x26
    str	x24,	[sp, #2344]

    ldr	x6,	[sp, fp]

    movz	fp,	#5084
    mov	x28,	x6
    str	x28,	[sp, #2304]

    ldr	x9,	[sp, fp]

    movz	fp,	#2140
    mov	x2,	x9
    str	x2,	[sp, fp]

    movz	fp,	#2876
    ldr	x25,	[sp, fp]

    movz	fp,	#2884
    mov	x26,	x25
    str	x26,	[sp, #2256]

    ldr	x2,	[sp, fp]

    movz	fp,	#5092
    mov	x26,	x2
    str	x26,	[sp, #2272]

    ldr	x12,	[sp, fp]

    movz	fp,	#2124
    mov	x20,	x12
    str	x20,	[sp, fp]

    movz	fp,	#5100
    ldr	x15,	[sp, fp]

    movz	fp,	#2164
    mov	x24,	x15
    str	x24,	[sp, fp]

    movz	fp,	#2892
    ldr	x28,	[sp, fp]

    movz	fp,	#2172
    mov	x2,	x28
    str	x2,	[sp, fp]

    movz	fp,	#2900
    ldr	x7,	[sp, fp]

    movz	fp,	#2180
    mov	x8,	x7
    str	x8,	[sp, fp]

    movz	fp,	#5116
    ldr	x10,	[sp, #7480]

    mov	x17,	x10
    str	x17,	[sp, #2048]

    ldr	x25,	[sp, fp]

    movz	fp,	#1780
    mov	x28,	x25
    str	x28,	[sp, fp]

    movz	fp,	#5124
    ldr	x28,	[sp, fp]

    movz	fp,	#2020
    mov	x15,	x28
    str	x15,	[sp, fp]

    movz	fp,	#5132
    ldr	x2,	[sp, fp]

    movz	fp,	#1892
    mov	x21,	x2
    str	x21,	[sp, fp]

    movz	fp,	#5148
    ldr	x5,	[sp, fp]

    mov	x9,	x5
    str	x9,	[sp, #1992]


main_518:
    ldr	w8,	[sp, #3392]

    movz	fp,	#2708
    movi	v7.4s,	#0
    ldr	x0,	[sp, #5440]

    lsl	w18,	w8,	#2
    add	x17,	x0,	x18
    ldr	s15,	[x17]

    ldr	w9,	[sp, #3392]

    ldr	x0,	[sp, fp]

    lsl	w9,	w9,	#2
    movz	fp,	#2660
    add	x21,	x0,	x9
    ldr	s2,	[x21]

    ldr	w10,	[sp, #3392]

    fadd	s20,	s15,	s2
    ldr	x14,	[sp, #1056]

    lsl	w15,	w10,	#2
    add	x2,	x14,	x15
    ldr	s6,	[x2]

    ldr	w11,	[sp, #3392]

    fadd	s25,	s20,	s6
    ldr	x7,	[sp, #1040]

    lsl	w2,	w11,	#2
    add	x6,	x7,	x2
    ldr	s8,	[x6]

    ldr	w12,	[sp, #3392]

    fadd	s5,	s25,	s8
    ldr	x20,	[sp, fp]

    lsl	w8,	w12,	#2
    movz	fp,	#2684
    add	x11,	x20,	x8
    ldr	s6,	[x11]

    ldr	w13,	[sp, #3392]

    ldr	x0,	[sp, #2672]

    lsl	w8,	w13,	#2
    add	x15,	x0,	x8
    ldr	s19,	[x15]

    ldr	w14,	[sp, #3392]

    fadd	s9,	s6,	s19
    ldr	x9,	[sp, fp]

    lsl	w15,	w14,	#2
    movz	fp,	#2652
    add	x19,	x9,	x15
    ldr	s25,	[x19]

    ldr	w15,	[sp, #3392]

    fadd	s11,	s9,	s25
    ldr	x14,	[sp, #1016]

    lsl	w19,	w15,	#2
    add	x1,	x14,	x19
    ldr	s31,	[x1]

    ldr	w16,	[sp, #3392]

    fadd	s13,	s11,	s31
    ldr	x21,	[sp, #1024]

    lsl	w2,	w16,	#2
    add	x5,	x21,	x2
    ldr	s24,	[x5]

    ldr	w17,	[sp, #3392]

    ldr	x15,	[sp, fp]

    lsl	w12,	w17,	#2
    movz	fp,	#2548
    add	x9,	x15,	x12
    ldr	s8,	[x9]

    ldr	w18,	[sp, #3392]

    fadd	s28,	s24,	s8
    ldr	x8,	[sp, fp]

    lsl	w21,	w18,	#2
    movz	fp,	#2516
    add	x13,	x8,	x21
    ldr	s15,	[x13]

    ldr	w19,	[sp, #3392]

    fadd	s2,	s28,	s15
    ldr	x24,	[sp, fp]

    lsl	w18,	w19,	#2
    movz	fp,	#2540
    add	x18,	x24,	x18
    ldr	s21,	[x18]

    ldr	w20,	[sp, #3392]

    fadd	s9,	s2,	s21
    ldr	x3,	[sp, fp]

    lsl	w10,	w20,	#2
    movz	fp,	#2524
    add	x0,	x3,	x10
    ldr	s15,	[x0]

    ldr	w21,	[sp, #3392]

    ldr	x12,	[sp, fp]

    lsl	w13,	w21,	#2
    movz	fp,	#2500
    add	x3,	x12,	x13
    ldr	s30,	[x3]

    ldr	w22,	[sp, #3392]

    fadd	s20,	s15,	s30
    ldr	x2,	[sp, fp]

    lsl	w21,	w22,	#2
    movz	fp,	#2476
    add	x8,	x2,	x21
    ldr	s3,	[x8]

    ldr	w23,	[sp, #3392]

    fadd	s20,	s20,	s3
    ldr	x18,	[sp, fp]

    lsl	w2,	w23,	#2
    movz	fp,	#2484
    add	x12,	x18,	x2
    ldr	s11,	[x12]

    ldr	w24,	[sp, #3392]

    fadd	s29,	s20,	s11
    ldr	x23,	[sp, fp]

    lsl	w0,	w24,	#2
    movz	fp,	#2492
    add	x21,	x23,	x0
    ldr	s1,	[x21]

    ldr	w25,	[sp, #3392]

    ldr	x28,	[sp, fp]

    lsl	w3,	w25,	#2
    movz	fp,	#2468
    add	x2,	x28,	x3
    ldr	s22,	[x2]

    ldr	w26,	[sp, #3392]

    fadd	s6,	s1,	s22
    ldr	x11,	[sp, fp]

    lsl	w21,	w26,	#2
    movz	fp,	#2420
    add	x8,	x11,	x21
    ldr	s26,	[x8]

    ldr	w27,	[sp, #3392]

    fadd	s12,	s6,	s26
    ldr	x12,	[sp, fp]

    lsl	w2,	w27,	#2
    movz	fp,	#2436
    add	x13,	x12,	x2
    ldr	s1,	[x13]

    ldr	w28,	[sp, #3392]

    fadd	s10,	s12,	s1
    ldr	x20,	[sp, fp]

    lsl	w23,	w28,	#2
    movz	fp,	#2452
    add	x19,	x20,	x23
    ldr	s23,	[x19]

    ldr	w0,	[sp, #3392]

    ldr	x1,	[sp, fp]

    lsl	w15,	w0,	#2
    movz	fp,	#2404
    add	x1,	x1,	x15
    ldr	s8,	[x1]

    ldr	w1,	[sp, #3392]

    fadd	s28,	s23,	s8
    ldr	x0,	[sp, fp]

    lsl	w21,	w1,	#2
    movz	fp,	#2388
    add	x6,	x0,	x21
    ldr	s16,	[x6]

    ldr	w2,	[sp, #3392]

    fadd	s25,	s28,	s16
    ldr	x21,	[sp, fp]

    lsl	w13,	w2,	#2
    movz	fp,	#2364
    add	x12,	x21,	x13
    ldr	s18,	[x12]

    ldr	w3,	[sp, #3392]

    fadd	s17,	s25,	s18
    ldr	x4,	[sp, fp]

    lsl	w21,	w3,	#2
    movz	fp,	#2140
    add	x18,	x4,	x21
    ldr	s11,	[x18]

    ldr	w4,	[sp, #3392]

    ldr	x10,	[sp, #2328]

    lsl	w15,	w4,	#2
    add	x0,	x10,	x15
    ldr	s3,	[x0]

    ldr	w5,	[sp, #3392]

    fadd	s19,	s11,	s3
    ldr	x22,	[sp, #2344]

    lsl	w6,	w5,	#2
    add	x5,	x22,	x6
    ldr	s11,	[x5]

    ldr	w6,	[sp, #3392]

    fadd	s20,	s19,	s11
    ldr	x28,	[sp, #2304]

    lsl	w12,	w6,	#2
    add	x11,	x28,	x12
    ldr	s4,	[x11]

    ldr	w7,	[sp, #3392]

    fadd	s25,	s20,	s4
    ldr	x17,	[sp, fp]

    lsl	w8,	w7,	#2
    movz	fp,	#2124
    add	x17,	x17,	x8
    ldr	s4,	[x17]

    ldr	w8,	[sp, #3392]

    ldr	x2,	[sp, #2256]

    lsl	w0,	w8,	#2
    add	x21,	x2,	x0
    ldr	s24,	[x21]

    ldr	w9,	[sp, #3392]

    fadd	s12,	s4,	s24
    ldr	x7,	[sp, #2272]

    lsl	w19,	w9,	#2
    add	x3,	x7,	x19
    ldr	s19,	[x3]

    ldr	w10,	[sp, #3392]

    fadd	s4,	s12,	s19
    ldr	x7,	[sp, fp]

    lsl	w2,	w10,	#2
    movz	fp,	#2164
    add	x9,	x7,	x2
    ldr	s1,	[x9]

    ldr	w11,	[sp, #3392]

    fadd	s21,	s4,	s1
    ldr	x13,	[sp, fp]

    lsl	w8,	w11,	#2
    movz	fp,	#2172
    add	x15,	x13,	x8
    ldr	s11,	[x15]

    ldr	w12,	[sp, #3392]

    ldr	x18,	[sp, fp]

    lsl	w12,	w12,	#2
    movz	fp,	#2180
    add	x19,	x18,	x12
    ldr	s26,	[x19]

    ldr	w13,	[sp, #3392]

    fadd	s20,	s11,	s26
    ldr	x23,	[sp, fp]

    lsl	w3,	w13,	#2
    movz	fp,	#1780
    add	x2,	x23,	x3
    ldr	s24,	[x2]

    ldr	w14,	[sp, #3392]

    fadd	s28,	s20,	s24
    ldr	x8,	[sp, #2048]

    lsl	w2,	w14,	#2
    add	x8,	x8,	x2
    ldr	s1,	[x8]

    ldr	w15,	[sp, #3392]

    fadd	s26,	s28,	s1
    ldr	x20,	[sp, fp]

    lsl	w8,	w15,	#2
    movz	fp,	#2020
    add	x13,	x20,	x8
    ldr	s24,	[x13]

    ldr	w16,	[sp, #3392]

    ldr	x10,	[sp, fp]

    lsl	w15,	w16,	#2
    movz	fp,	#1892
    add	x18,	x10,	x15
    ldr	s15,	[x18]

    ldr	w17,	[sp, #3392]

    fadd	s31,	s24,	s15
    ldr	x21,	[sp, fp]

    lsl	w2,	w17,	#2
    movz	fp,	#2748
    add	x1,	x21,	x2
    ldr	s20,	[x1]

    ldr	w18,	[sp, #3392]

    fadd	s31,	s31,	s20
    ldr	x12,	[sp, #1992]

    lsl	w2,	w18,	#2
    add	x0,	x12,	x2
    ldr	s15,	[x0]

    ldr	x26,	[sp, fp]

    fadd	s16,	s31,	s15
    movz	fp,	#2564
    str	s5,	[x26]

    ldr	x24,	[sp, fp]

    movz	fp,	#2572
    str	s13,	[x24]

    ldr	x27,	[sp, fp]

    movz	fp,	#2596
    str	s9,	[x27]

    ldr	x6,	[sp, #2584]

    str	s29,	[x6]

    ldr	x14,	[sp, fp]

    movz	fp,	#2604
    str	s10,	[x14]

    ldr	x17,	[sp, fp]

    movz	fp,	#2636
    str	s17,	[x17]

    ldr	x26,	[sp, #2616]

    str	s25,	[x26]

    ldr	x1,	[sp, #2624]

    str	s21,	[x1]

    ldr	x8,	[sp, fp]

    movz	fp,	#2644
    str	s26,	[x8]

    ldr	x11,	[sp, fp]

    str	s16,	[x11]

    ldr	s2,	[x0]

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
    movz	fp,	#2748
    ldr	x1,	[sp, fp]

    bl	putfarray
    add	x18,	sp,	#856
    add	x10,	sp,	#864
    movz	fp,	#3212
    add	x9,	sp,	#852
    ldr	w19,	[sp, #3392]

    add	x21,	sp,	#824
    lsl	w0,	w19,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#904
    ldr	s13,	[x0]

    ldr	x0,	[sp, fp]

    movz	fp,	#2924
    mov	x23,	x0
    ldr	x1,	[sp, fp]

    movz	fp,	#3316
    mov	x14,	x1
    mov	x13,	x14
    ldr	x28,	[sp, fp]

    movz	fp,	#3188
    mov	x17,	x28
    ldr	x25,	[sp, fp]

    movz	fp,	#3172
    mov	x15,	x25
    str	x15,	[sp, #3936]

    add	x15,	sp,	#848
    ldr	x11,	[sp, fp]

    movz	fp,	#3804
    mov	x5,	x11
    str	x5,	[sp, fp]

    movz	fp,	#3012
    ldr	x0,	[sp, fp]

    movz	fp,	#4556
    mov	x20,	x0
    str	x20,	[sp, fp]

    movz	fp,	#3052
    ldr	x12,	[sp, fp]

    movz	fp,	#3948
    mov	x2,	x12
    str	x2,	[sp, fp]

    movz	fp,	#3196
    ldr	x4,	[sp, fp]

    movz	fp,	#4604
    mov	x28,	x4
    add	x4,	sp,	#868
    str	x28,	[sp, fp]

    add	x28,	sp,	#836
    movz	fp,	#2908
    ldr	x5,	[sp, fp]

    movz	fp,	#3796
    mov	x2,	x5
    str	x2,	[sp, fp]

    movz	fp,	#3036
    ldr	x5,	[sp, fp]

    movz	fp,	#4596
    mov	x25,	x5
    str	x25,	[sp, fp]

    add	x25,	sp,	#832
    movz	fp,	#3284
    ldr	x19,	[sp, fp]

    movz	fp,	#3788
    mov	x2,	x19
    str	x2,	[sp, fp]

    add	x2,	sp,	#828
    movz	fp,	#3308
    ldr	x1,	[sp, fp]

    movz	fp,	#4572
    mov	x27,	x1
    add	x1,	sp,	#844
    str	x27,	[sp, fp]

    movz	fp,	#3332
    ldr	x7,	[sp, fp]

    movz	fp,	#3812
    mov	x8,	x7
    str	x8,	[sp, fp]

    movz	fp,	#3324
    ldr	x5,	[sp, fp]

    movz	fp,	#4564
    mov	x24,	x5
    add	x5,	sp,	#840
    str	x24,	[sp, fp]

    movz	fp,	#2508
    str	x21,	[sp, fp]

    add	x21,	sp,	#872
    movz	fp,	#5108
    str	x2,	[sp, fp]

    add	x2,	sp,	#900
    movz	fp,	#5156
    str	x25,	[sp, fp]

    movz	fp,	#5164
    str	x28,	[sp, fp]

    movz	fp,	#2116
    str	x5,	[sp, fp]

    add	x5,	sp,	#860
    movz	fp,	#2148
    str	x1,	[sp, fp]

    add	x1,	sp,	#892
    movz	fp,	#2292
    str	x15,	[sp, #2264]

    add	x15,	sp,	#876
    str	x9,	[sp, #2280]

    str	x18,	[sp, fp]

    add	x18,	sp,	#896
    movz	fp,	#2780
    str	x5,	[sp, #2312]

    add	x5,	sp,	#888
    str	x10,	[sp, fp]

    add	x10,	sp,	#880
    movz	fp,	#2692
    str	x4,	[sp, #1048]

    str	x21,	[sp, fp]

    movz	fp,	#2700
    str	x15,	[sp, fp]

    add	x15,	sp,	#884
    movz	fp,	#2724
    str	x10,	[sp, fp]

    movz	fp,	#2732
    str	x15,	[sp, fp]

    movz	fp,	#2740
    str	x5,	[sp, fp]

    movz	fp,	#2756
    str	x1,	[sp, fp]

    mov	x1,	x23
    movz	fp,	#2764
    str	x18,	[sp, fp]

    movz	fp,	#2772
    str	x2,	[sp, fp]

    movz	fp,	#3532
    ldr	s10,	[sp, #1272]

    fmov	s31,	s10
    str	x1,	[sp, fp]

    movz	fp,	#2788
    ldr	w6,	[sp, #3360]

    mov	w22,	w6
    str	w22,	[sp, #2716]

    ldr	x18,	[sp, fp]

    movz	fp,	#4580
    mov	x28,	x18
    mov	x18,	x17
    str	x28,	[sp, fp]

    movz	fp,	#2796
    ldr	s9,	[sp, #1276]

    ldr	w6,	[sp, #3388]

    fmov	s16,	s9
    mov	w23,	w6
    str	w23,	[sp, #2720]

    ldr	s15,	[sp, #1280]

    ldr	s18,	[sp, #1284]

    fmov	s17,	s15
    ldr	x6,	[sp, fp]

    fmov	s15,	s18
    movz	fp,	#2460
    mov	x23,	x6
    str	x23,	[sp, fp]

    movz	fp,	#2428
    str	x13,	[sp, fp]

    movz	fp,	#2804
    ldr	w27,	[sp, #3372]

    mov	w2,	w27
    str	w2,	[sp, #1032]

    ldr	w6,	[sp, #3364]

    mov	w21,	w6
    str	w21,	[sp, #1036]

    ldr	x21,	[sp, fp]

    movz	fp,	#2444
    mov	x6,	x21
    str	x6,	[sp, fp]

    movz	fp,	#2412
    str	x18,	[sp, fp]

    movz	fp,	#2356
    ldr	x13,	[sp, #3936]

    mov	x18,	x13
    str	x18,	[sp, fp]

    movz	fp,	#2812
    ldr	w6,	[sp, #3352]

    mov	w18,	w6
    str	w18,	[sp, #2668]

    ldr	x17,	[sp, fp]

    movz	fp,	#2372
    mov	x22,	x17
    str	x22,	[sp, fp]

    movz	fp,	#2820
    ldr	x21,	[sp, fp]

    movz	fp,	#2380
    mov	x6,	x21
    str	x6,	[sp, fp]

    movz	fp,	#2828
    ldr	s18,	[sp, #1288]

    ldr	s22,	[sp, #1292]

    fmov	s11,	s18
    ldr	s8,	[sp, #1296]

    fmov	s18,	s22
    ldr	x2,	[sp, fp]

    fmov	s12,	s8
    movz	fp,	#2396
    str	x2,	[sp, fp]

    movz	fp,	#3804
    ldr	w27,	[sp, #3344]

    mov	w17,	w27
    str	w17,	[sp, #2680]

    ldr	s9,	[sp, #1300]

    ldr	s24,	[sp, #1304]

    fmov	s4,	s9
    ldr	s25,	[sp, #1308]

    fmov	s20,	s24
    ldr	x6,	[sp, fp]

    fmov	s1,	s25
    movz	fp,	#2836
    mov	x14,	x6
    str	x14,	[sp, #2320]

    ldr	x4,	[sp, fp]

    movz	fp,	#4556
    mov	x2,	x4
    str	x2,	[sp, #2336]

    ldr	x16,	[sp, fp]

    movz	fp,	#2132
    mov	x19,	x16
    str	x19,	[sp, fp]

    movz	fp,	#3948
    ldr	x8,	[sp, fp]

    movz	fp,	#4948
    str	x8,	[sp, fp]

    movz	fp,	#2844
    ldr	x4,	[sp, fp]

    movz	fp,	#4980
    mov	x24,	x4
    str	x24,	[sp, fp]

    movz	fp,	#4604
    ldr	s29,	[sp, #1312]

    ldr	s10,	[sp, #1316]

    fmov	s19,	s29
    ldr	x16,	[sp, fp]

    fmov	s5,	s10
    movz	fp,	#4964
    str	x16,	[sp, fp]

    movz	fp,	#2852
    ldr	w17,	[sp, #3340]

    mov	w3,	w17
    str	w3,	[sp, #2632]

    ldr	x11,	[sp, fp]

    movz	fp,	#2860
    mov	x23,	x11
    str	x23,	[sp, #2200]

    ldr	x14,	[sp, fp]

    movz	fp,	#3796
    mov	x21,	x14
    str	x21,	[sp, #2248]

    ldr	s6,	[sp, #1320]

    fmov	s30,	s6
    ldr	s6,	[sp, #1328]

    ldr	x0,	[sp, fp]

    fmov	s28,	s6
    movz	fp,	#4932
    str	x0,	[sp, fp]

    movz	fp,	#4596
    ldr	x14,	[sp, fp]

    movz	fp,	#3772
    str	x14,	[sp, fp]

    movz	fp,	#3788
    ldr	w15,	[sp, #3376]

    mov	w5,	w15
    str	w5,	[sp, #2580]

    ldr	w21,	[sp, #3368]

    mov	w26,	w21
    str	w26,	[sp, #2592]

    ldr	s7,	[sp, #1332]

    ldr	s3,	[sp, #1336]

    fmov	s27,	s7
    ldr	x28,	[sp, fp]

    fmov	s9,	s3
    movz	fp,	#2868
    str	x28,	[sp, #2208]

    ldr	w16,	[sp, #3348]

    mov	w18,	w16
    str	w18,	[sp, #2556]

    ldr	x19,	[sp, fp]

    movz	fp,	#4892
    mov	x24,	x19
    str	x24,	[sp, fp]

    movz	fp,	#4572
    ldr	w22,	[sp, #3356]

    mov	w23,	w22
    str	w23,	[sp, #2560]

    ldr	x19,	[sp, fp]

    movz	fp,	#4884
    str	x19,	[sp, fp]

    movz	fp,	#3812
    ldr	x4,	[sp, fp]

    movz	fp,	#4908
    str	x4,	[sp, fp]

    movz	fp,	#2876
    ldr	s24,	[sp, #1340]

    ldr	s26,	[sp, #1344]

    fmov	s21,	s24
    ldr	x7,	[sp, fp]

    fmov	s10,	s26
    movz	fp,	#3756
    mov	x6,	x7
    str	x6,	[sp, fp]

    movz	fp,	#4564
    ldr	w22,	[sp, #3384]

    mov	w13,	w22
    str	w13,	[sp, #2536]

    ldr	x4,	[sp, fp]

    movz	fp,	#2884
    str	x4,	[sp, #2216]

    ldr	x7,	[sp, fp]

    movz	fp,	#2892
    mov	x28,	x7
    str	x28,	[sp, #1984]

    ldr	s29,	[sp, #1348]

    ldr	w20,	[sp, #3388]

    fmov	s8,	s29
    mov	w25,	w20
    str	w25,	[sp, #2532]

    ldr	s22,	[sp, #1352]

    ldr	x23,	[sp, fp]

    fmov	s3,	s22
    movz	fp,	#1900
    mov	x7,	x23
    str	x7,	[sp, fp]

    movz	fp,	#2900
    ldr	x4,	[sp, fp]

    movz	fp,	#2028
    mov	x7,	x4
    str	x7,	[sp, fp]

    ldr	s29,	[sp, #1356]

    ldr	w4,	[sp, #3380]

    fmov	s7,	s29
    str	w4,	[sp, #2612]


main_717:
    ldr	w24,	[sp, #3392]

    movz	fp,	#4580
    lsl	w15,	w24,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#2460
    add	x28,	x25,	x15
    ldr	s22,	[x28]

    fadd	s24,	s31,	s22
    fadd	s6,	s24,	s16
    fadd	s22,	s6,	s17
    str	s22,	[sp, #1684]

    ldr	w19,	[sp, #3392]

    ldr	x7,	[sp, fp]

    lsl	w22,	w19,	#2
    movz	fp,	#2444
    add	x23,	x7,	x22
    ldr	s23,	[x23]

    ldr	w22,	[sp, #3392]

    fadd	s6,	s15,	s23
    ldr	x8,	[sp, fp]

    lsl	w6,	w22,	#2
    movz	fp,	#2372
    add	x26,	x8,	x6
    ldr	s26,	[x26]

    ldr	w23,	[sp, #3392]

    fadd	s22,	s6,	s26
    ldr	x19,	[sp, fp]

    lsl	w23,	w23,	#2
    movz	fp,	#2380
    add	x28,	x19,	x23
    ldr	s2,	[x28]

    fadd	s22,	s22,	s2
    str	s22,	[sp, #1700]

    ldr	w24,	[sp, #3392]

    ldr	x22,	[sp, fp]

    lsl	w10,	w24,	#2
    movz	fp,	#2396
    add	x7,	x22,	x10
    ldr	s6,	[x7]

    fadd	s22,	s6,	s11
    fadd	s6,	s22,	s18
    fadd	s24,	s6,	s12
    str	s24,	[sp, #1688]

    ldr	w28,	[sp, #3392]

    lsl	w6,	w28,	#2
    ldr	x28,	[sp, fp]

    movz	fp,	#4980
    add	x26,	x28,	x6
    ldr	s22,	[x26]

    fadd	s24,	s22,	s4
    fadd	s6,	s24,	s20
    fadd	s22,	s6,	s1
    str	s22,	[sp, #1692]

    ldr	w7,	[sp, #3392]

    ldr	x22,	[sp, #2336]

    lsl	w26,	w7,	#2
    add	x26,	x22,	x26
    ldr	s23,	[x26]

    ldr	w8,	[sp, #3392]

    ldr	x19,	[sp, fp]

    lsl	w23,	w8,	#2
    movz	fp,	#4892
    add	x23,	x19,	x23
    ldr	s6,	[x23]

    fadd	s6,	s23,	s6
    fadd	s23,	s27,	s9
    fadd	s22,	s6,	s19
    fadd	s24,	s22,	s5
    str	s24,	[sp, #1696]

    ldr	w16,	[sp, #3392]

    lsl	w26,	w16,	#2
    ldr	x16,	[sp, #2200]

    add	x23,	x16,	x26
    ldr	s6,	[x23]

    ldr	w4,	[sp, #3392]

    ldr	x14,	[sp, #2248]

    lsl	w24,	w4,	#2
    add	x10,	x14,	x24
    ldr	s22,	[x10]

    fadd	s22,	s6,	s22
    fadd	s6,	s22,	s30
    fadd	s24,	s6,	s28
    str	s24,	[sp, #1704]

    ldr	w10,	[sp, #3392]

    ldr	x18,	[sp, fp]

    lsl	w7,	w10,	#2
    movz	fp,	#3756
    add	x6,	x18,	x7
    ldr	s6,	[x6]

    fadd	s6,	s23,	s6
    fadd	s22,	s6,	s21
    str	s22,	[sp, #1068]

    ldr	w19,	[sp, #3392]

    ldr	x7,	[sp, fp]

    lsl	w22,	w19,	#2
    movz	fp,	#1900
    add	x26,	x7,	x22
    ldr	s23,	[x26]

    ldr	w22,	[sp, #3392]

    fadd	s22,	s10,	s23
    ldr	x28,	[sp, #1984]

    lsl	w6,	w22,	#2
    add	x26,	x28,	x6
    ldr	s6,	[x26]

    fadd	s22,	s22,	s6
    fadd	s23,	s22,	s8
    str	s23,	[sp, #1096]

    ldr	w23,	[sp, #3392]

    ldr	x28,	[sp, fp]

    lsl	w26,	w23,	#2
    movz	fp,	#2028
    add	x10,	x28,	x26
    ldr	s6,	[x10]

    ldr	w24,	[sp, #3392]

    fadd	s6,	s3,	s6
    ldr	x4,	[sp, fp]

    lsl	w26,	w24,	#2
    movz	fp,	#2508
    add	x10,	x4,	x26
    ldr	s22,	[x10]

    fadd	s6,	s6,	s22
    fadd	s24,	s6,	s7
    str	s24,	[sp, #1160]

    ldr	s6,	[sp, #1684]

    ldr	x7,	[sp, fp]

    movz	fp,	#5108
    str	s6,	[x7]

    ldr	s6,	[sp, #1700]

    ldr	x22,	[sp, fp]

    movz	fp,	#5156
    str	s6,	[x22]

    ldr	s6,	[sp, #1688]

    ldr	x8,	[sp, fp]

    movz	fp,	#5164
    str	s6,	[x8]

    ldr	s6,	[sp, #1692]

    ldr	x11,	[sp, fp]

    movz	fp,	#2116
    str	s6,	[x11]

    ldr	s6,	[sp, #1696]

    ldr	x19,	[sp, fp]

    movz	fp,	#2148
    str	s6,	[x19]

    ldr	s6,	[sp, #1704]

    ldr	x10,	[sp, fp]

    movz	fp,	#2292
    str	s6,	[x10]

    ldr	s6,	[sp, #1068]

    ldr	x23,	[sp, #2264]

    str	s6,	[x23]

    ldr	s6,	[sp, #1096]

    ldr	x7,	[sp, #2280]

    str	s6,	[x7]

    ldr	s6,	[sp, #1160]

    ldr	x24,	[sp, fp]

    movz	fp,	#3532
    str	s6,	[x24]

    ldr	x19,	[sp, #2312]

    movi	v6.4s,	#0
    str	s6,	[x19]

    ldr	w28,	[sp, #3392]

    ldr	x2,	[sp, fp]

    lsl	w26,	w28,	#2
    movz	fp,	#2428
    add	x22,	x2,	x26
    ldr	w22,	[x22]

    ldr	w24,	[sp, #2716]

    ldr	w1,	[sp, #2720]

    add	w15,	w1,	w24
    add	w18,	w15,	w22
    str	w18,	[sp, #1788]

    ldr	w28,	[sp, #3392]

    ldr	x15,	[sp, fp]

    lsl	w26,	w28,	#2
    movz	fp,	#2412
    add	x22,	x15,	x26
    ldr	w23,	[x22]

    ldr	w28,	[sp, #1032]

    ldr	w1,	[sp, #1036]

    add	w24,	w1,	w28
    add	w7,	w24,	w23
    str	w7,	[sp, #2008]

    ldr	w4,	[sp, #3392]

    ldr	x24,	[sp, fp]

    lsl	w7,	w4,	#2
    movz	fp,	#2356
    add	x22,	x24,	x7
    ldr	w16,	[x22]

    ldr	w7,	[sp, #3392]

    ldr	x5,	[sp, fp]

    lsl	w26,	w7,	#2
    movz	fp,	#2132
    add	x25,	x5,	x26
    ldr	w24,	[x25]

    ldr	w6,	[sp, #2668]

    add	w8,	w16,	w6
    add	w1,	w8,	w24
    str	w1,	[sp, #1908]

    ldr	w10,	[sp, #3392]

    ldr	x26,	[sp, #2320]

    lsl	w23,	w10,	#2
    add	x22,	x26,	x23
    ldr	w25,	[x22]

    ldr	w23,	[sp, #2680]

    ldr	w13,	[sp, #3392]

    add	w22,	w25,	w23
    ldr	x20,	[sp, fp]

    lsl	w6,	w13,	#2
    movz	fp,	#4948
    add	x1,	x20,	x6
    ldr	w25,	[x1]

    add	w23,	w22,	w25
    str	w23,	[sp, #1960]

    ldr	w15,	[sp, #3392]

    ldr	x9,	[sp, fp]

    lsl	w22,	w15,	#2
    movz	fp,	#4964
    add	x25,	x9,	x22
    ldr	w10,	[x25]

    ldr	w1,	[sp, #3392]

    ldr	x17,	[sp, fp]

    lsl	w16,	w1,	#2
    movz	fp,	#4932
    add	x15,	x17,	x16
    ldr	w22,	[x15]

    ldr	w18,	[sp, #2632]

    add	w26,	w10,	w18
    add	w1,	w26,	w22
    str	w1,	[sp, #2160]

    ldr	w7,	[sp, #3392]

    ldr	x1,	[sp, fp]

    lsl	w26,	w7,	#2
    movz	fp,	#3772
    add	x25,	x1,	x26
    ldr	w22,	[x25]

    ldr	w8,	[sp, #3392]

    ldr	x15,	[sp, fp]

    lsl	w6,	w8,	#2
    movz	fp,	#4884
    add	x8,	x15,	x6
    ldr	w25,	[x8]

    ldr	w1,	[sp, #2580]

    add	w19,	w22,	w1
    add	w18,	w19,	w25
    str	w18,	[sp, #1956]

    ldr	w15,	[sp, #3392]

    ldr	x0,	[sp, #2208]

    lsl	w26,	w15,	#2
    add	x22,	x0,	x26
    ldr	w8,	[x22]

    ldr	w1,	[sp, #2556]

    ldr	w24,	[sp, #2592]

    add	w25,	w1,	w24
    add	w20,	w25,	w8
    str	w20,	[sp, #1980]

    ldr	w18,	[sp, #3392]

    ldr	x20,	[sp, fp]

    lsl	w19,	w18,	#2
    movz	fp,	#4908
    add	x22,	x20,	x19
    ldr	w10,	[x22]

    ldr	w24,	[sp, #2560]

    ldr	w4,	[sp, #3392]

    add	w26,	w10,	w24
    ldr	x5,	[sp, fp]

    lsl	w28,	w4,	#2
    movz	fp,	#2780
    add	x24,	x5,	x28
    ldr	w1,	[x24]

    add	w11,	w26,	w1
    str	w11,	[sp, #4552]

    ldr	w22,	[sp, #3392]

    ldr	x5,	[sp, #2216]

    lsl	w25,	w22,	#2
    add	x10,	x5,	x25
    movz	w25,	#0
    ldr	w8,	[x10]

    ldr	w22,	[sp, #2532]

    ldr	w13,	[sp, #2536]

    add	w23,	w22,	w13
    ldr	w22,	[sp, #2612]

    add	w15,	w23,	w22
    add	w15,	w15,	w8
    str	w15,	[sp, #3944]

    ldr	w16,	[sp, #1788]

    ldr	x1,	[sp, fp]

    movz	fp,	#2692
    str	w16,	[x1]

    ldr	w19,	[sp, #2008]

    ldr	x10,	[sp, #1048]

    str	w19,	[x10]

    ldr	w1,	[sp, #1908]

    ldr	x22,	[sp, fp]

    movz	fp,	#2700
    str	w1,	[x22]

    ldr	w18,	[sp, #1960]

    ldr	x21,	[sp, fp]

    movz	fp,	#2724
    str	w18,	[x21]

    ldr	w7,	[sp, #2160]

    ldr	x1,	[sp, fp]

    movz	fp,	#2732
    str	w7,	[x1]

    mov	w7,	w25
    ldr	w6,	[sp, #1956]

    ldr	x18,	[sp, fp]

    movz	fp,	#2740
    str	w6,	[x18]

    ldr	w26,	[sp, #1980]

    ldr	x8,	[sp, fp]

    movz	fp,	#2756
    str	w26,	[x8]

    ldr	x8,	[sp, fp]

    movz	fp,	#2764
    ldr	w14,	[sp, #4552]

    str	w14,	[x8]

    ldr	x23,	[sp, fp]

    movz	fp,	#2772
    ldr	w17,	[sp, #3944]

    str	w17,	[x23]

    ldr	x19,	[sp, fp]

    str	w7,	[x19]

    fcvtzs	w19,	s7
    ldr	w1,	[sp, #2612]

    ldr	w7,	[sp, #2612]

    scvtf	s23,	w1
    cmp	w7,	#0
    beq	main_716

main_889:
    movz	w0,	#10
    movz	fp,	#2508
    ldr	x1,	[sp, fp]

    bl	putfarray
    movz	fp,	#2780
    movz	w0,	#10
    ldr	x1,	[sp, fp]

    bl	putarray
    movz	fp,	#2780
    ldr	w20,	[sp, #1788]

    scvtf	s10,	w20
    str	s10,	[sp, #1084]

    ldr	s11,	[sp, #1084]

    ldr	s15,	[sp, #1684]

    ldr	x18,	[sp, fp]

    fsub	s15,	s11,	s15
    movz	fp,	#2692
    fcvtzs	w25,	s15
    str	w25,	[x18]

    ldr	w27,	[sp, #2008]

    scvtf	s11,	w27
    ldr	s10,	[sp, #1700]

    ldr	x26,	[sp, #1048]

    fsub	s9,	s11,	s10
    fcvtzs	w21,	s9
    str	w21,	[x26]

    ldr	w24,	[sp, #1908]

    scvtf	s12,	w24
    ldr	s10,	[sp, #1688]

    fsub	s11,	s12,	s10
    ldr	x26,	[sp, fp]

    fcvtzs	w24,	s11
    movz	fp,	#2700
    str	w24,	[x26]

    ldr	w20,	[sp, #1960]

    ldr	s8,	[sp, #1692]

    scvtf	s11,	w20
    ldr	x28,	[sp, fp]

    fsub	s10,	s11,	s8
    movz	fp,	#2724
    fcvtzs	w25,	s10
    str	w25,	[x28]

    ldr	w19,	[sp, #2160]

    movz	w25,	#0
    ldr	s15,	[sp, #1696]

    scvtf	s9,	w19
    ldr	x18,	[sp, fp]

    fsub	s15,	s9,	s15
    movz	fp,	#2732
    fcvtzs	w26,	s15
    str	w26,	[x18]

    ldr	w21,	[sp, #1956]

    scvtf	s10,	w21
    ldr	s8,	[sp, #1704]

    ldr	x24,	[sp, fp]

    fsub	s15,	s10,	s8
    movz	fp,	#2740
    fcvtzs	w21,	s15
    str	w21,	[x24]

    ldr	w28,	[sp, #1980]

    ldr	s12,	[sp, #1068]

    scvtf	s15,	w28
    ldr	x26,	[sp, fp]

    fsub	s9,	s15,	s12
    movz	fp,	#2756
    fcvtzs	w24,	s9
    str	w24,	[x26]

    ldr	w23,	[sp, #4552]

    scvtf	s15,	w23
    ldr	s9,	[sp, #1096]

    fsub	s11,	s15,	s9
    ldr	x24,	[sp, fp]

    fcvtzs	w26,	s11
    movz	fp,	#2764
    str	w26,	[x24]

    ldr	w20,	[sp, #3944]

    scvtf	s9,	w20
    ldr	s10,	[sp, #1160]

    ldr	x20,	[sp, fp]

    fsub	s10,	s9,	s10
    movz	fp,	#2772
    fcvtzs	w27,	s10
    str	w27,	[x20]

    ldr	x22,	[sp, fp]

    str	w25,	[x22]

    ldr	w24,	[sp, #3392]

    lsl	w23,	w24,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	#864
    ldr	w24,	[x22]

    ldr	s12,	[sp, #1160]

    scvtf	s10,	w24
    ldr	s0,	[sp, #1268]

    fmul	s9,	s10,	s12
    fcvtzs	w26,	s9
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s14
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s13
    bl	putfloat
    movz	w0,	#10
    bl	putch
    mov	w0,	w26
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#12320
    add	sp, sp, fp
    ret


main_716:
    movz	fp,	#2780
    fmov	s7,	s23
    ldr	x15,	[sp, fp]

    movz	fp,	#3532
    mov	x3,	x15
    str	x3,	[sp, fp]

    movz	fp,	#2508
    ldr	x16,	[sp, fp]

    movz	fp,	#4580
    mov	x28,	x16
    str	x28,	[sp, fp]

    movz	fp,	#2460
    mov	w28,	w19
    str	w28,	[sp, #2612]

    ldr	w28,	[sp, #2716]

    ldr	w18,	[sp, #6276]

    ldr	w19,	[sp, #6276]

    mov	w28,	w18
    str	w19,	[sp, #2716]

    ldr	w4,	[sp, #2720]

    ldr	w21,	[sp, #6280]

    ldr	w22,	[sp, #6280]

    mov	w4,	w21
    str	w22,	[sp, #2720]

    ldr	x15,	[sp, fp]

    movz	fp,	#2460
    ldr	x11,	[sp, #6224]

    ldr	x12,	[sp, #6224]

    mov	x15,	x11
    str	x12,	[sp, fp]

    movz	fp,	#2428
    ldr	x25,	[sp, fp]

    movz	fp,	#2428
    ldr	x5,	[sp, #6208]

    ldr	x6,	[sp, #6208]

    mov	x25,	x5
    str	x6,	[sp, fp]

    movz	fp,	#2444
    ldr	w15,	[sp, #1032]

    ldr	w12,	[sp, #6268]

    ldr	w13,	[sp, #6268]

    mov	w15,	w12
    str	w13,	[sp, #1032]

    ldr	w22,	[sp, #1036]

    ldr	w15,	[sp, #6272]

    ldr	w16,	[sp, #6272]

    mov	w22,	w15
    str	w16,	[sp, #1036]

    ldr	x20,	[sp, fp]

    movz	fp,	#2444
    ldr	x8,	[sp, #6216]

    ldr	x9,	[sp, #6216]

    mov	x20,	x8
    str	x9,	[sp, fp]

    movz	fp,	#2412
    ldr	x13,	[sp, fp]

    movz	fp,	#2412
    ldr	x2,	[sp, #6200]

    ldr	x3,	[sp, #6200]

    mov	x13,	x2
    str	x3,	[sp, fp]

    movz	fp,	#2356
    ldr	x4,	[sp, fp]

    movz	fp,	#2356
    ldr	x19,	[sp, #6168]

    ldr	x20,	[sp, #6168]

    mov	x4,	x19
    str	x20,	[sp, fp]

    movz	fp,	#2372
    ldr	w13,	[sp, #2668]

    ldr	w6,	[sp, #6260]

    ldr	w7,	[sp, #6260]

    mov	w13,	w6
    str	w7,	[sp, #2668]

    ldr	x7,	[sp, fp]

    movz	fp,	#2372
    ldr	x22,	[sp, #6176]

    ldr	x23,	[sp, #6176]

    mov	x7,	x22
    str	x23,	[sp, fp]

    movz	fp,	#2380
    ldr	x24,	[sp, fp]

    movz	fp,	#2380
    ldr	x25,	[sp, #6184]

    ldr	x26,	[sp, #6184]

    mov	x24,	x25
    str	x26,	[sp, fp]

    movz	fp,	#2396
    ldr	x15,	[sp, fp]

    movz	fp,	#2396
    ldr	x28,	[sp, #6192]

    ldr	x0,	[sp, #6192]

    mov	x15,	x28
    str	x0,	[sp, fp]

    movz	fp,	#2132
    ldr	w7,	[sp, #2680]

    ldr	w9,	[sp, #6264]

    ldr	w10,	[sp, #6264]

    mov	w7,	w9
    str	w10,	[sp, #2680]

    ldr	x13,	[sp, #2320]

    ldr	x13,	[sp, #6152]

    ldr	x14,	[sp, #6152]

    str	x14,	[sp, #2320]

    ldr	x25,	[sp, #2336]

    ldr	x16,	[sp, #6160]

    ldr	x17,	[sp, #6160]

    mov	x25,	x16
    str	x17,	[sp, #2336]

    ldr	x8,	[sp, fp]

    movz	fp,	#2132
    ldr	x10,	[sp, #6144]

    ldr	x11,	[sp, #6144]

    mov	x8,	x10
    str	x11,	[sp, fp]

    movz	fp,	#4948
    ldr	x10,	[sp, fp]

    movz	fp,	#8132
    ldr	x10,	[sp, fp]

    movz	fp,	#8132
    ldr	x18,	[sp, fp]

    movz	fp,	#4948
    str	x18,	[sp, fp]

    movz	fp,	#4980
    ldr	x26,	[sp, fp]

    movz	fp,	#8148
    ldr	x26,	[sp, fp]

    movz	fp,	#8148
    ldr	x24,	[sp, fp]

    movz	fp,	#4980
    str	x24,	[sp, fp]

    movz	fp,	#4964
    ldr	x18,	[sp, fp]

    movz	fp,	#8140
    ldr	x18,	[sp, fp]

    movz	fp,	#8140
    ldr	x21,	[sp, fp]

    movz	fp,	#4964
    str	x21,	[sp, fp]

    movz	fp,	#8756
    ldr	w25,	[sp, #2632]

    ldr	w3,	[sp, #6256]

    ldr	w4,	[sp, #6256]

    mov	w25,	w3
    str	w4,	[sp, #2632]

    ldr	x25,	[sp, #2200]

    ldr	x25,	[sp, fp]

    movz	fp,	#8756
    ldr	x3,	[sp, fp]

    movz	fp,	#8116
    str	x3,	[sp, #2200]

    ldr	x23,	[sp, #2248]

    ldr	x23,	[sp, fp]

    movz	fp,	#8116
    ldr	x12,	[sp, fp]

    movz	fp,	#4932
    str	x12,	[sp, #2248]

    ldr	x2,	[sp, fp]

    movz	fp,	#8124
    ldr	x2,	[sp, fp]

    movz	fp,	#8124
    ldr	x15,	[sp, fp]

    movz	fp,	#4932
    str	x15,	[sp, fp]

    movz	fp,	#3772
    ldr	x16,	[sp, fp]

    movz	fp,	#8748
    ldr	x16,	[sp, fp]

    movz	fp,	#8748
    ldr	x0,	[sp, fp]

    movz	fp,	#3772
    str	x0,	[sp, fp]

    movz	fp,	#8100
    ldr	w22,	[sp, #2580]

    ldr	w26,	[sp, #6248]

    ldr	w27,	[sp, #6248]

    mov	w22,	w26
    str	w27,	[sp, #2580]

    ldr	w4,	[sp, #2592]

    ldr	w0,	[sp, #6252]

    ldr	w1,	[sp, #6252]

    mov	w4,	w0
    str	w1,	[sp, #2592]

    ldr	x1,	[sp, #2208]

    ldr	x1,	[sp, fp]

    movz	fp,	#8100
    ldr	x6,	[sp, fp]

    movz	fp,	#4892
    str	x6,	[sp, #2208]

    ldr	w23,	[sp, #2556]

    ldr	w20,	[sp, #6240]

    ldr	w21,	[sp, #6240]

    mov	w23,	w20
    str	w21,	[sp, #2556]

    ldr	x26,	[sp, fp]

    movz	fp,	#8732
    ldr	x26,	[sp, fp]

    movz	fp,	#8732
    ldr	x23,	[sp, fp]

    movz	fp,	#4892
    str	x23,	[sp, fp]

    movz	fp,	#4884
    ldr	w22,	[sp, #2560]

    ldr	w23,	[sp, #6244]

    ldr	w24,	[sp, #6244]

    mov	w22,	w23
    str	w24,	[sp, #2560]

    ldr	x21,	[sp, fp]

    movz	fp,	#8724
    ldr	x21,	[sp, fp]

    movz	fp,	#8724
    ldr	x20,	[sp, fp]

    movz	fp,	#4884
    str	x20,	[sp, fp]

    movz	fp,	#4908
    ldr	x6,	[sp, fp]

    movz	fp,	#8740
    ldr	x6,	[sp, fp]

    movz	fp,	#8740
    ldr	x26,	[sp, fp]

    movz	fp,	#4908
    str	x26,	[sp, fp]

    movz	fp,	#3756
    ldr	x8,	[sp, fp]

    movz	fp,	#8716
    ldr	x8,	[sp, fp]

    movz	fp,	#8716
    ldr	x17,	[sp, fp]

    movz	fp,	#3756
    str	x17,	[sp, fp]

    movz	fp,	#8108
    ldr	w7,	[sp, #2536]

    ldr	w17,	[sp, #6236]

    ldr	w18,	[sp, #6236]

    mov	w7,	w17
    str	w18,	[sp, #2536]

    ldr	x6,	[sp, #2216]

    ldr	x6,	[sp, fp]

    movz	fp,	#8108
    ldr	x9,	[sp, fp]

    movz	fp,	#1900
    str	x9,	[sp, #2216]

    ldr	x13,	[sp, #1984]

    ldr	x1,	[sp, #6120]

    ldr	x2,	[sp, #6120]

    mov	x13,	x1
    str	x2,	[sp, #1984]

    ldr	w4,	[sp, #2532]

    ldr	w14,	[sp, #6232]

    ldr	w15,	[sp, #6232]

    mov	w4,	w14
    str	w15,	[sp, #2532]

    ldr	x15,	[sp, fp]

    movz	fp,	#1900
    ldr	x4,	[sp, #6128]

    ldr	x5,	[sp, #6128]

    mov	x15,	x4
    str	x5,	[sp, fp]

    movz	fp,	#2028
    ldr	x22,	[sp, fp]

    movz	fp,	#2028
    ldr	x7,	[sp, #6136]

    ldr	x8,	[sp, #6136]

    mov	x22,	x7
    str	x8,	[sp, fp]

    b	main_717

main_517:
    movz	fp,	#2708
    ldr	x28,	[sp, fp]

    movz	fp,	#2708
    mov	x0,	x28
    str	x0,	[sp, #5440]

    ldr	x15,	[sp, #1056]

    mov	x0,	x15
    str	x0,	[sp, fp]

    movz	fp,	#2660
    ldr	x6,	[sp, #1040]

    mov	x16,	x6
    str	x16,	[sp, #1056]

    ldr	x19,	[sp, fp]

    movz	fp,	#2660
    mov	x7,	x19
    str	x7,	[sp, #1040]

    ldr	x0,	[sp, #2672]

    mov	x20,	x0
    str	x20,	[sp, fp]

    movz	fp,	#2684
    ldr	x10,	[sp, fp]

    movz	fp,	#2684
    mov	x1,	x10
    str	x1,	[sp, #2672]

    ldr	x15,	[sp, #1016]

    mov	x11,	x15
    str	x11,	[sp, fp]

    movz	fp,	#2652
    ldr	x20,	[sp, #1024]

    mov	x16,	x20
    str	x16,	[sp, #1016]

    ldr	x14,	[sp, fp]

    movz	fp,	#2548
    mov	x24,	x14
    str	x24,	[sp, #1024]

    ldr	x9,	[sp, fp]

    movz	fp,	#2652
    mov	x15,	x9
    str	x15,	[sp, fp]

    movz	fp,	#2516
    ldr	x26,	[sp, fp]

    movz	fp,	#2548
    mov	x10,	x26
    str	x10,	[sp, fp]

    movz	fp,	#2540
    ldr	x4,	[sp, fp]

    movz	fp,	#2516
    mov	x27,	x4
    str	x27,	[sp, fp]

    movz	fp,	#2524
    ldr	x13,	[sp, fp]

    movz	fp,	#2540
    mov	x5,	x13
    str	x5,	[sp, fp]

    movz	fp,	#2500
    ldr	x3,	[sp, fp]

    movz	fp,	#2524
    mov	x14,	x3
    str	x14,	[sp, fp]

    movz	fp,	#2476
    ldr	x17,	[sp, fp]

    movz	fp,	#2500
    mov	x4,	x17
    str	x4,	[sp, fp]

    movz	fp,	#2484
    ldr	x25,	[sp, fp]

    movz	fp,	#2476
    mov	x18,	x25
    str	x18,	[sp, fp]

    movz	fp,	#2492
    ldr	x0,	[sp, fp]

    movz	fp,	#2484
    mov	x26,	x0
    str	x26,	[sp, fp]

    movz	fp,	#2468
    ldr	x12,	[sp, fp]

    movz	fp,	#2492
    mov	x0,	x12
    str	x0,	[sp, fp]

    movz	fp,	#2420
    ldr	x11,	[sp, fp]

    movz	fp,	#2468
    mov	x13,	x11
    str	x13,	[sp, fp]

    movz	fp,	#2436
    ldr	x24,	[sp, fp]

    movz	fp,	#2420
    mov	x12,	x24
    str	x12,	[sp, fp]

    movz	fp,	#2452
    ldr	x2,	[sp, fp]

    movz	fp,	#2436
    mov	x25,	x2
    str	x25,	[sp, fp]

    movz	fp,	#2404
    ldr	x1,	[sp, fp]

    movz	fp,	#2452
    mov	x3,	x1
    str	x3,	[sp, fp]

    movz	fp,	#2388
    ldr	x20,	[sp, fp]

    movz	fp,	#2404
    mov	x2,	x20
    str	x2,	[sp, fp]

    movz	fp,	#2364
    ldr	x5,	[sp, fp]

    movz	fp,	#2388
    mov	x24,	x5
    str	x24,	[sp, fp]

    movz	fp,	#2364
    ldr	x11,	[sp, #2328]

    mov	x6,	x11
    str	x6,	[sp, fp]

    movz	fp,	#2140
    ldr	x24,	[sp, #2344]

    mov	x12,	x24
    str	x12,	[sp, #2328]

    ldr	x0,	[sp, #2304]

    mov	x25,	x0
    str	x25,	[sp, #2344]

    ldr	x16,	[sp, fp]

    movz	fp,	#2140
    mov	x0,	x16
    str	x0,	[sp, #2304]

    ldr	x0,	[sp, #2256]

    mov	x17,	x0
    str	x17,	[sp, fp]

    movz	fp,	#2124
    ldr	x8,	[sp, #2272]

    mov	x1,	x8
    str	x1,	[sp, #2256]

    ldr	x6,	[sp, fp]

    movz	fp,	#2164
    mov	x9,	x6
    str	x9,	[sp, #2272]

    ldr	x12,	[sp, fp]

    movz	fp,	#2124
    mov	x7,	x12
    str	x7,	[sp, fp]

    movz	fp,	#2172
    ldr	x17,	[sp, fp]

    movz	fp,	#2164
    mov	x13,	x17
    str	x13,	[sp, fp]

    movz	fp,	#2180
    ldr	x25,	[sp, fp]

    movz	fp,	#2172
    mov	x18,	x25
    str	x18,	[sp, fp]

    movz	fp,	#2180
    ldr	x7,	[sp, #2048]

    mov	x26,	x7
    str	x26,	[sp, fp]

    movz	fp,	#1780
    ldr	x19,	[sp, fp]

    movz	fp,	#2020
    mov	x8,	x19
    str	x8,	[sp, #2048]

    ldr	x11,	[sp, fp]

    movz	fp,	#1780
    mov	x20,	x11
    str	x20,	[sp, fp]

    movz	fp,	#1892
    ldr	x20,	[sp, fp]

    movz	fp,	#2020
    mov	x12,	x20
    str	x12,	[sp, fp]

    movz	fp,	#1892
    ldr	x11,	[sp, #1992]

    mov	x24,	x11
    str	x24,	[sp, fp]

    movz	fp,	#2748
    ldr	x0,	[sp, fp]

    mov	x12,	x0
    str	x12,	[sp, #1992]

    b	main_518

main_308:
    ldr	w7,	[sp, #5416]

    mov	w6,	w7
    str	w6,	[sp, #2300]

    ldr	w19,	[sp, #6632]

    ldr	w14,	[sp, #8776]

    ldr	w15,	[sp, #8776]

    mov	w19,	w14
    str	w15,	[sp, #6632]

    ldr	w8,	[sp, #5412]

    ldr	w27,	[sp, #9900]

    ldr	w28,	[sp, #9900]

    mov	w8,	w27
    str	w28,	[sp, #5412]

    ldr	w22,	[sp, #5416]

    ldr	w24,	[sp, #9896]

    ldr	w25,	[sp, #9896]

    mov	w22,	w24
    str	w25,	[sp, #5416]

    ldr	w25,	[sp, #6636]

    ldr	w17,	[sp, #8780]

    ldr	w18,	[sp, #8780]

    mov	w25,	w17
    str	w18,	[sp, #6636]

    ldr	w5,	[sp, #5404]

    ldr	w21,	[sp, #12276]

    ldr	w22,	[sp, #12276]

    mov	w5,	w21
    str	w22,	[sp, #5404]

    ldr	w22,	[sp, #2156]

    ldr	w19,	[sp, #6116]

    ldr	w6,	[sp, #6116]

    mov	w22,	w19
    str	w6,	[sp, #2156]

    ldr	s9,	[sp, #1608]

    str	s15,	[sp, #1608]

    fmov	s9,	s15
    ldr	w14,	[sp, #7488]

    ldr	w11,	[sp, #8772]

    ldr	w12,	[sp, #8772]

    mov	w14,	w11
    str	w12,	[sp, #7488]

    ldr	s14,	[sp, #1620]

    str	s15,	[sp, #1620]

    fmov	s14,	s15
    ldr	w12,	[sp, #2188]

    ldr	w11,	[sp, #6112]

    ldr	w22,	[sp, #6112]

    mov	w12,	w11
    str	w22,	[sp, #2188]

    ldr	s26,	[sp, #1612]

    str	s15,	[sp, #1612]

    fmov	s26,	s15
    ldr	s9,	[sp, #1656]

    str	s15,	[sp, #1656]

    fmov	s9,	s15
    ldr	w0,	[sp, #6640]

    ldr	w21,	[sp, #8784]

    ldr	w22,	[sp, #8784]

    mov	w0,	w21
    str	w22,	[sp, #6640]

    ldr	s20,	[sp, #1628]

    str	s15,	[sp, #1628]

    fmov	s20,	s15
    ldr	w14,	[sp, #5424]

    ldr	w1,	[sp, #9904]

    ldr	w2,	[sp, #9904]

    mov	w14,	w1
    str	w2,	[sp, #5424]

    ldr	w19,	[sp, #5448]

    ldr	w28,	[sp, #9916]

    ldr	w0,	[sp, #9916]

    mov	w19,	w28
    str	w0,	[sp, #5448]

    ldr	s20,	[sp, #1112]

    str	s15,	[sp, #1112]

    fmov	s20,	s15
    ldr	s26,	[sp, #1596]

    str	s15,	[sp, #1596]

    fmov	s26,	s15
    ldr	s23,	[sp, #1600]

    str	s15,	[sp, #1600]

    fmov	s23,	s15
    ldr	w10,	[sp, #6648]

    ldr	w27,	[sp, #8792]

    ldr	w28,	[sp, #8792]

    mov	w10,	w27
    str	w28,	[sp, #6648]

    ldr	s20,	[sp, #1116]

    str	s15,	[sp, #1116]

    fmov	s20,	s15
    ldr	w17,	[sp, #2016]

    ldr	w7,	[sp, #6104]

    ldr	w8,	[sp, #6104]

    mov	w17,	w7
    str	w8,	[sp, #2016]

    ldr	s9,	[sp, #1592]

    str	s15,	[sp, #1592]

    fmov	s9,	s15
    ldr	s20,	[sp, #1092]

    str	s15,	[sp, #1092]

    fmov	s20,	s15
    ldr	w8,	[sp, #2044]

    ldr	w5,	[sp, #6108]

    ldr	w18,	[sp, #6108]

    mov	w8,	w5
    str	w18,	[sp, #2044]

    ldr	w15,	[sp, #6688]

    ldr	w1,	[sp, #11996]

    ldr	w2,	[sp, #11996]

    mov	w15,	w1
    str	w2,	[sp, #6688]

    ldr	s20,	[sp, #1936]

    str	s15,	[sp, #1936]

    fmov	s20,	s15
    ldr	w11,	[sp, #5420]

    ldr	w22,	[sp, #9908]

    ldr	w23,	[sp, #9908]

    mov	w11,	w22
    str	w23,	[sp, #5420]

    ldr	s20,	[sp, #1064]

    str	s15,	[sp, #1064]

    fmov	s20,	s15
    ldr	w5,	[sp, #6644]

    ldr	w24,	[sp, #8788]

    ldr	w25,	[sp, #8788]

    mov	w5,	w24
    str	w25,	[sp, #6644]

    ldr	w22,	[sp, #5432]

    ldr	w18,	[sp, #8796]

    ldr	w19,	[sp, #8796]

    mov	w22,	w18
    str	w19,	[sp, #5432]

    ldr	s20,	[sp, #1104]

    str	s15,	[sp, #1104]

    fmov	s20,	s15
    ldr	s20,	[sp, #1088]

    str	s15,	[sp, #1088]

    fmov	s20,	s15
    ldr	w3,	[sp, #7472]

    ldr	w8,	[sp, #8768]

    ldr	w9,	[sp, #8768]

    mov	w3,	w8
    str	w9,	[sp, #7472]

    ldr	w27,	[sp, #6088]

    ldr	w5,	[sp, #8764]

    ldr	w6,	[sp, #8764]

    mov	w27,	w5
    str	w6,	[sp, #6088]

    ldr	w18,	[sp, #5452]

    ldr	w2,	[sp, #9920]

    ldr	w3,	[sp, #9920]

    mov	w18,	w2
    str	w3,	[sp, #5452]

    ldr	s23,	[sp, #1140]

    str	s15,	[sp, #1140]

    fmov	s23,	s15
    ldr	w11,	[sp, #5428]

    ldr	w25,	[sp, #9912]

    ldr	w26,	[sp, #9912]

    mov	w11,	w25
    str	w26,	[sp, #5428]

    ldr	s20,	[sp, #1080]

    str	s15,	[sp, #1080]

    fmov	s20,	s15
    ldr	w25,	[sp, #12304]

    ldr	w21,	[sp, #3780]

    ldr	w22,	[sp, #3780]

    mov	w25,	w21
    str	w22,	[sp, #12304]

    ldr	s23,	[sp, #1132]

    str	s15,	[sp, #1132]

    fmov	s23,	s15
    b	main_309

main_305:
    ldr	s28,	[sp, #1072]

    fmov	s23,	s7
    fadd	s4,	s28,	s7
    str	s23,	[sp, #1072]

    fmov	s7,	s1
    fadd	s28,	s4,	s1
    ldr	s9,	[sp, #1380]

    fmov	s1,	s30
    ldr	s8,	[sp, #1384]

    fmov	s30,	s17
    str	s8,	[sp, #1380]

    fmov	s17,	s6
    ldr	s21,	[sp, #1708]

    fmov	s6,	s16
    str	s21,	[sp, #1384]

    fmov	s16,	s24
    ldr	s3,	[sp, #1388]

    fmov	s24,	s20
    str	s3,	[sp, #1708]

    fmov	s20,	s31
    ldr	s19,	[sp, #1712]

    fmov	s31,	s9
    str	s19,	[sp, #1388]

    ldr	s18,	[sp, #1716]

    str	s18,	[sp, #1712]

    ldr	s5,	[sp, #1724]

    str	s5,	[sp, #1716]

    ldr	s9,	[sp, #1720]

    str	s9,	[sp, #1724]

    fmov	s9,	s14
    ldr	s26,	[sp, #1732]

    str	s26,	[sp, #1720]

    ldr	s23,	[sp, #1736]

    str	s23,	[sp, #1732]

    ldr	s23,	[sp, #1744]

    str	s23,	[sp, #1736]

    ldr	s21,	[sp, #1740]

    str	s21,	[sp, #1744]

    ldr	s8,	[sp, #1748]

    str	s8,	[sp, #1740]

    ldr	s19,	[sp, #1752]

    str	s19,	[sp, #1748]

    ldr	s3,	[sp, #1412]

    str	s3,	[sp, #1752]

    ldr	s5,	[sp, #1408]

    str	s5,	[sp, #1412]

    fmov	s5,	s10
    str	s9,	[sp, #1408]

    fmov	s10,	s13
    ldr	s22,	[sp, #1424]

    ldr	s3,	[sp, #1428]

    fmov	s14,	s22
    str	s3,	[sp, #1424]

    str	s5,	[sp, #1428]

    ldr	s25,	[sp, #1076]

    ldr	s23,	[sp, #1100]

    fmov	s13,	s25
    fmov	s11,	s23
    str	s11,	[sp, #1076]

    ldr	s19,	[sp, #1120]

    fmov	s18,	s19
    str	s18,	[sp, #1100]

    fmov	s18,	s28
    ldr	s23,	[sp, #1128]

    fmov	s26,	s23
    str	s26,	[sp, #1120]

    ldr	s22,	[sp, #1136]

    str	s22,	[sp, #1128]

    ldr	s9,	[sp, #1144]

    str	s9,	[sp, #1136]

    ldr	s11,	[sp, #1152]

    str	s11,	[sp, #1144]

    ldr	s26,	[sp, #1156]

    str	s26,	[sp, #1152]

    ldr	s11,	[sp, #1172]

    str	s11,	[sp, #1156]

    str	s18,	[sp, #1172]

    b	main_148

