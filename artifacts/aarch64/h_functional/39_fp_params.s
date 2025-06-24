.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#10592
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w1,	#0
    str	w0,	[sp, #3632]

    mov	w24,	w1

main_10:
    cmp	w24,	#40
    bge	main_18

main_13:
    lsl	w0,	w24,	#2
    add	w26,	w0,	w24,	lsl #3
    mov	x0,	x26
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getfarray
    add	w3,	w24,	#1
    mov	w24,	w3
    b	main_10

main_18:
    movz	w2,	#0
    mov	w24,	w2

main_19:
    cmp	w24,	#24
    bge	main_27

main_22:
    lsl	w0,	w24,	#2
    add	w21,	w0,	w24,	lsl #3
    mov	x0,	x21
    add	x0,	sp,	x0
    add	x0,	x0,	#496
    bl	getarray
    add	w4,	w24,	#1
    mov	w24,	w4
    b	main_19

main_27:
    add	x24,	sp,	#16
    add	x16,	sp,	#28
    add	x12,	sp,	#40
    add	x4,	sp,	#52
    movz	fp,	#3588
    add	x8,	sp,	#124
    str	x24,	[sp, #3616]

    ldr	w10,	[sp, #3632]

    ldr	x0,	[sp, #3616]

    lsl	w7,	w10,	#2
    add	x6,	x0,	x7
    ldr	s9,	[x6]

    str	s9,	[sp, #1332]

    str	x16,	[sp, #3608]

    add	x16,	sp,	#64
    ldr	w11,	[sp, #3632]

    ldr	x0,	[sp, #3608]

    lsl	w11,	w11,	#2
    add	x10,	x0,	x11
    ldr	s5,	[x10]

    str	s5,	[sp, #1272]

    str	x12,	[sp, #3600]

    ldr	w12,	[sp, #3632]

    ldr	x19,	[sp, #3600]

    lsl	w15,	w12,	#2
    add	x12,	sp,	#76
    add	x14,	x19,	x15
    ldr	s20,	[x14]

    str	s20,	[sp, #1336]

    str	x4,	[sp, fp]

    movz	fp,	#3588
    ldr	w13,	[sp, #3632]

    lsl	w21,	w13,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#3572
    add	x18,	x7,	x21
    ldr	s22,	[x18]

    str	s22,	[sp, #1340]

    str	x16,	[sp, fp]

    movz	fp,	#3572
    ldr	w14,	[sp, #3632]

    lsl	w0,	w14,	#2
    ldr	x24,	[sp, fp]

    movz	fp,	#3564
    add	x26,	x24,	x0
    add	x0,	sp,	#148
    add	x24,	sp,	#88
    ldr	s30,	[x26]

    str	s30,	[sp, #1344]

    str	x12,	[sp, fp]

    add	x12,	sp,	#112
    movz	fp,	#3564
    ldr	w15,	[sp, #3632]

    ldr	x13,	[sp, fp]

    lsl	w4,	w15,	#2
    movz	fp,	#3460
    add	x2,	x13,	x4
    add	x4,	sp,	#136
    ldr	s9,	[x2]

    str	s9,	[sp, #1304]

    str	x24,	[sp, #3544]

    ldr	w16,	[sp, #3632]

    ldr	x25,	[sp, #3544]

    lsl	w2,	w16,	#2
    add	x16,	sp,	#100
    add	x1,	x25,	x2
    ldr	s17,	[x1]

    str	s17,	[sp, #1280]

    str	x16,	[sp, #3536]

    add	x16,	sp,	#172
    ldr	w17,	[sp, #3632]

    lsl	w6,	w17,	#2
    ldr	x17,	[sp, #3536]

    add	x5,	x17,	x6
    ldr	s22,	[x5]

    str	s22,	[sp, #1256]

    str	x12,	[sp, #3528]

    add	x12,	sp,	#184
    ldr	w18,	[sp, #3632]

    ldr	x13,	[sp, #3528]

    lsl	w10,	w18,	#2
    add	x9,	x13,	x10
    ldr	s16,	[x9]

    str	s16,	[sp, #1252]

    str	x8,	[sp, #3520]

    add	x8,	sp,	#196
    ldr	w21,	[sp, #3632]

    ldr	x9,	[sp, #3520]

    lsl	w18,	w21,	#2
    add	x13,	x9,	x18
    ldr	s1,	[x13]

    str	s1,	[sp, #1348]

    str	x4,	[sp, #3512]

    ldr	w24,	[sp, #3632]

    ldr	x5,	[sp, #3512]

    lsl	w25,	w24,	#2
    add	x24,	sp,	#160
    add	x17,	x5,	x25
    ldr	s10,	[x17]

    str	s10,	[sp, #1352]

    str	x0,	[sp, #3504]

    ldr	w25,	[sp, #3632]

    ldr	x1,	[sp, #3504]

    lsl	w4,	w25,	#2
    add	x25,	x1,	x4
    ldr	s17,	[x25]

    str	s17,	[sp, #1356]

    str	x24,	[sp, #3496]

    ldr	w26,	[sp, #3632]

    ldr	x25,	[sp, #3496]

    lsl	w3,	w26,	#2
    add	x1,	x25,	x3
    ldr	s29,	[x1]

    str	s29,	[sp, #1268]

    str	x16,	[sp, #3488]

    add	x16,	sp,	#220
    ldr	w0,	[sp, #3632]

    ldr	x17,	[sp, #3488]

    lsl	w1,	w0,	#2
    add	x0,	x17,	x1
    ldr	s19,	[x0]

    str	s19,	[sp, #1360]

    str	x12,	[sp, #3480]

    ldr	w0,	[sp, #3632]

    ldr	x13,	[sp, #3480]

    lsl	w5,	w0,	#2
    add	x0,	sp,	#208
    add	x4,	x13,	x5
    ldr	s27,	[x4]

    str	s27,	[sp, #1364]

    str	x8,	[sp, #3472]

    ldr	w1,	[sp, #3632]

    ldr	x9,	[sp, #3472]

    lsl	w13,	w1,	#2
    add	x8,	x9,	x13
    ldr	s29,	[x8]

    add	x8,	sp,	#244
    str	s29,	[sp, #1368]

    str	x0,	[sp, fp]

    movz	fp,	#3460
    ldr	w2,	[sp, #3632]

    lsl	w17,	w2,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3412
    add	x12,	x1,	x17
    ldr	s6,	[x12]

    add	x12,	sp,	#232
    str	s6,	[sp, #1300]

    str	x16,	[sp, #3448]

    ldr	w3,	[sp, #3632]

    ldr	x17,	[sp, #3448]

    lsl	w24,	w3,	#2
    add	x16,	x17,	x24
    ldr	s1,	[x16]

    str	s1,	[sp, #1324]

    str	x12,	[sp, #3440]

    add	x12,	sp,	#280
    ldr	w4,	[sp, #3632]

    ldr	x13,	[sp, #3440]

    lsl	w1,	w4,	#2
    add	x4,	sp,	#256
    add	x24,	x13,	x1
    ldr	s6,	[x24]

    add	x24,	sp,	#268
    str	s6,	[sp, #1372]

    str	x8,	[sp, #3432]

    ldr	w5,	[sp, #3632]

    ldr	x9,	[sp, #3432]

    lsl	w2,	w5,	#2
    add	x0,	x9,	x2
    ldr	s13,	[x0]

    str	s13,	[sp, #1376]

    str	x4,	[sp, #3424]

    ldr	w6,	[sp, #3632]

    ldr	x5,	[sp, #3424]

    lsl	w0,	w6,	#2
    add	x4,	x5,	x0
    add	x0,	sp,	#316
    ldr	s17,	[x4]

    str	s17,	[sp, #1284]

    str	x24,	[sp, fp]

    add	x24,	sp,	#328
    movz	fp,	#3412
    ldr	w7,	[sp, #3632]

    ldr	x25,	[sp, fp]

    lsl	w4,	w7,	#2
    movz	fp,	#3300
    add	x3,	x25,	x4
    add	x4,	sp,	#304
    ldr	s30,	[x3]

    str	s30,	[sp, #1296]

    str	x12,	[sp, #3400]

    ldr	w8,	[sp, #3632]

    ldr	x13,	[sp, #3400]

    lsl	w8,	w8,	#2
    add	x7,	x13,	x8
    add	x8,	sp,	#292
    ldr	s22,	[x7]

    str	s22,	[sp, #1380]

    str	x8,	[sp, #3392]

    add	x8,	sp,	#364
    ldr	w9,	[sp, #3632]

    lsl	w16,	w9,	#2
    ldr	x9,	[sp, #3392]

    add	x11,	x9,	x16
    add	x16,	sp,	#340
    ldr	s23,	[x11]

    str	s23,	[sp, #1384]

    str	x4,	[sp, #3384]

    add	x4,	sp,	#376
    ldr	w10,	[sp, #3632]

    ldr	x5,	[sp, #3384]

    lsl	w22,	w10,	#2
    add	x15,	x5,	x22
    ldr	s1,	[x15]

    str	s1,	[sp, #1388]

    str	x0,	[sp, #3376]

    ldr	w11,	[sp, #3632]

    ldr	x1,	[sp, #3376]

    lsl	w2,	w11,	#2
    add	x21,	x1,	x2
    ldr	s2,	[x21]

    str	s2,	[sp, #1392]

    str	x24,	[sp, #3368]

    add	x24,	sp,	#400
    ldr	w12,	[sp, #3632]

    ldr	x25,	[sp, #3368]

    lsl	w1,	w12,	#2
    add	x12,	sp,	#352
    add	x0,	x25,	x1
    ldr	s26,	[x0]

    add	x0,	sp,	#388
    str	s26,	[sp, #1316]

    str	x16,	[sp, #3360]

    ldr	w13,	[sp, #3632]

    ldr	x17,	[sp, #3360]

    lsl	w5,	w13,	#2
    add	x3,	x17,	x5
    ldr	s7,	[x3]

    str	s7,	[sp, #1396]

    str	x12,	[sp, #3352]

    add	x12,	sp,	#484
    ldr	w14,	[sp, #3632]

    ldr	x13,	[sp, #3352]

    lsl	w3,	w14,	#2
    add	x2,	x13,	x3
    ldr	s19,	[x2]

    str	s19,	[sp, #1400]

    str	x8,	[sp, #3344]

    add	x8,	sp,	#424
    ldr	w15,	[sp, #3632]

    ldr	x9,	[sp, #3344]

    lsl	w7,	w15,	#2
    add	x6,	x9,	x7
    ldr	s19,	[x6]

    str	s19,	[sp, #1312]

    str	x4,	[sp, #3336]

    ldr	w16,	[sp, #3632]

    ldr	x5,	[sp, #3336]

    lsl	w15,	w16,	#2
    add	x16,	sp,	#412
    add	x10,	x5,	x15
    ldr	s29,	[x10]

    str	s29,	[sp, #1264]

    str	x0,	[sp, #3328]

    ldr	w17,	[sp, #3632]

    ldr	x1,	[sp, #3328]

    lsl	w19,	w17,	#2
    add	x14,	x1,	x19
    ldr	s20,	[x14]

    str	s20,	[sp, #1404]

    str	x24,	[sp, #3320]

    ldr	w18,	[sp, #3632]

    ldr	x25,	[sp, #3320]

    lsl	w21,	w18,	#2
    add	x18,	x25,	x21
    ldr	s29,	[x18]

    str	s29,	[sp, #1408]

    str	x16,	[sp, #3312]

    add	x16,	sp,	#472
    ldr	w21,	[sp, #3632]

    ldr	x17,	[sp, #3312]

    lsl	w0,	w21,	#2
    add	x26,	x17,	x0
    add	x0,	sp,	#448
    ldr	s23,	[x26]

    str	s23,	[sp, #1288]

    str	x8,	[sp, fp]

    movz	fp,	#3300
    ldr	w23,	[sp, #3632]

    lsl	w4,	w23,	#2
    ldr	x9,	[sp, fp]

    movz	fp,	#3292
    add	x2,	x9,	x4
    add	x4,	sp,	#436
    ldr	s19,	[x2]

    str	s19,	[sp, #1308]

    str	x4,	[sp, fp]

    movz	fp,	#3292
    ldr	w24,	[sp, #3632]

    lsl	w2,	w24,	#2
    ldr	x5,	[sp, fp]

    add	x24,	sp,	#460
    movz	fp,	#3284
    add	x1,	x5,	x2
    ldr	s30,	[x1]

    str	s30,	[sp, #1412]

    str	x0,	[sp, fp]

    movz	fp,	#3284
    ldr	w25,	[sp, #3632]

    lsl	w10,	w25,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3276
    add	x5,	x1,	x10
    ldr	s1,	[x5]

    str	s1,	[sp, #1320]

    str	x24,	[sp, fp]

    movz	fp,	#3276
    ldr	w1,	[sp, #3632]

    lsl	w10,	w1,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3268
    add	x9,	x25,	x10
    ldr	s22,	[x9]

    str	s22,	[sp, #1260]

    str	x16,	[sp, fp]

    movz	fp,	#3268
    ldr	w0,	[sp, #3632]

    lsl	w14,	w0,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#3260
    add	x13,	x17,	x14
    ldr	s7,	[x13]

    str	s7,	[sp, #1276]

    str	x12,	[sp, fp]

    movz	fp,	#3260
    ldr	w1,	[sp, #3632]

    lsl	w25,	w1,	#2
    ldr	x13,	[sp, fp]

    add	x17,	x13,	x25
    ldr	s30,	[x17]

    str	s30,	[sp, #1292]

    ldr	s17,	[sp, #1332]

    str	s17,	[sp, #1116]

    ldr	s6,	[sp, #1272]

    fmov	s13,	s6
    ldr	s6,	[sp, #1336]

    str	s6,	[sp, #1824]

    ldr	s30,	[sp, #1340]

    str	s30,	[sp, #1820]

    ldr	s22,	[sp, #1344]

    str	s22,	[sp, #1132]

    ldr	s22,	[sp, #1304]

    str	s22,	[sp, #1128]

    ldr	s30,	[sp, #1280]

    ldr	s26,	[sp, #1256]

    fmov	s16,	s30
    ldr	s20,	[sp, #1252]

    ldr	s21,	[sp, #1348]

    fmov	s22,	s20
    str	s21,	[sp, #1120]

    ldr	s12,	[sp, #1352]

    ldr	s23,	[sp, #1356]

    fmov	s21,	s12
    ldr	s18,	[sp, #1268]

    fmov	s30,	s23
    str	s18,	[sp, #1444]

    ldr	s19,	[sp, #1360]

    ldr	s1,	[sp, #1364]

    fmov	s24,	s19
    str	s1,	[sp, #1448]

    ldr	s2,	[sp, #1368]

    str	s2,	[sp, #1172]

    ldr	s23,	[sp, #1300]

    str	s23,	[sp, #1180]

    ldr	s25,	[sp, #1324]

    str	s25,	[sp, #1176]

    ldr	s2,	[sp, #1372]

    str	s2,	[sp, #1452]

    ldr	s2,	[sp, #1376]

    str	s2,	[sp, #1456]

    ldr	s25,	[sp, #1284]

    str	s25,	[sp, #1468]

    ldr	s25,	[sp, #1296]

    str	s25,	[sp, #1460]

    ldr	s3,	[sp, #1380]

    str	s3,	[sp, #1472]

    ldr	s6,	[sp, #1384]

    str	s6,	[sp, #1476]

    ldr	s25,	[sp, #1388]

    str	s25,	[sp, #1484]

    ldr	s23,	[sp, #1392]

    fmov	s27,	s23
    str	s27,	[sp, #1480]

    ldr	s23,	[sp, #1316]

    ldr	s6,	[sp, #1396]

    fmov	s31,	s23
    fmov	s25,	s6
    str	s25,	[sp, #1500]

    ldr	s1,	[sp, #1400]

    fmov	s5,	s1
    str	s5,	[sp, #1504]

    ldr	s1,	[sp, #1312]

    fmov	s27,	s1
    str	s27,	[sp, #1856]

    ldr	s27,	[sp, #1264]

    fmov	s6,	s27
    str	s6,	[sp, #1860]

    ldr	s23,	[sp, #1404]

    fmov	s5,	s23
    str	s5,	[sp, #1092]

    ldr	s5,	[sp, #1408]

    fmov	s23,	s5
    str	s23,	[sp, #1156]

    ldr	s27,	[sp, #1288]

    fmov	s5,	s27
    str	s5,	[sp, #1136]

    ldr	s2,	[sp, #1308]

    fmov	s23,	s2
    str	s23,	[sp, #1184]

    ldr	s5,	[sp, #1412]

    fmov	s23,	s5
    str	s23,	[sp, #1192]

    ldr	s27,	[sp, #1320]

    str	s27,	[sp, #1204]

    ldr	s28,	[sp, #1260]

    str	s28,	[sp, #1212]

    ldr	s4,	[sp, #1276]

    str	s4,	[sp, #1216]

    ldr	s27,	[sp, #1292]

    str	s27,	[sp, #1232]


main_148:
    movi	v5.4s,	#0
    ldr	s17,	[sp, #1232]

    fcmp	s17,	s5
    beq	main_305

main_190:
    ldr	s12,	[sp, #1116]

    add	x1,	sp,	#784
    add	x23,	sp,	#788
    add	x0,	sp,	#792
    add	x22,	sp,	#808
    fadd	s12,	s12,	s13
    str	s12,	[sp, #1644]

    ldr	s12,	[sp, #1644]

    ldr	s13,	[sp, #1824]

    str	s13,	[sp, #1968]

    ldr	s9,	[sp, #1968]

    str	s9,	[sp, #2012]

    ldr	s9,	[sp, #2012]

    str	s9,	[sp, #1964]

    ldr	s10,	[sp, #1964]

    fadd	s10,	s12,	s10
    str	s10,	[sp, #1648]

    ldr	s9,	[sp, #1648]

    ldr	s10,	[sp, #1820]

    str	s10,	[sp, #1960]

    ldr	s12,	[sp, #1960]

    str	s12,	[sp, #2096]

    ldr	s12,	[sp, #2096]

    str	s12,	[sp, #1956]

    ldr	s13,	[sp, #1956]

    fadd	s10,	s9,	s13
    str	s10,	[sp, #1244]

    ldr	s10,	[sp, #1128]

    str	s10,	[sp, #2016]

    ldr	s10,	[sp, #1132]

    ldr	s13,	[sp, #2016]

    str	s13,	[sp, #1952]

    ldr	s9,	[sp, #1952]

    fadd	s9,	s10,	s9
    str	s9,	[sp, #1652]

    ldr	s10,	[sp, #1652]

    fadd	s12,	s10,	s16
    str	s12,	[sp, #1656]

    ldr	s9,	[sp, #1656]

    fadd	s9,	s9,	s26
    str	s9,	[sp, #1228]

    ldr	s9,	[sp, #1120]

    fadd	s12,	s22,	s9
    str	s12,	[sp, #1660]

    ldr	s12,	[sp, #1660]

    fadd	s10,	s12,	s21
    str	s10,	[sp, #1664]

    ldr	s12,	[sp, #1664]

    fadd	s12,	s12,	s30
    str	s12,	[sp, #1548]

    ldr	s10,	[sp, #1444]

    fadd	s12,	s10,	s24
    str	s12,	[sp, #1632]

    ldr	s13,	[sp, #1448]

    ldr	s9,	[sp, #1632]

    str	s9,	[sp, #1948]

    ldr	s10,	[sp, #1948]

    str	s10,	[sp, #2052]

    ldr	s10,	[sp, #2052]

    str	s10,	[sp, #1916]

    ldr	s12,	[sp, #1916]

    fadd	s12,	s12,	s13
    str	s12,	[sp, #1636]

    ldr	s10,	[sp, #1172]

    ldr	s12,	[sp, #1636]

    str	s12,	[sp, #1912]

    ldr	s13,	[sp, #1912]

    str	s13,	[sp, #1800]

    ldr	s13,	[sp, #1800]

    str	s13,	[sp, #1980]

    ldr	s9,	[sp, #1980]

    fadd	s12,	s9,	s10
    str	s12,	[sp, #1544]

    ldr	s13,	[sp, #1176]

    ldr	s9,	[sp, #1180]

    str	s9,	[sp, #1976]

    ldr	s10,	[sp, #1976]

    str	s10,	[sp, #1796]

    ldr	s10,	[sp, #1796]

    str	s10,	[sp, #1972]

    ldr	s12,	[sp, #1972]

    fadd	s12,	s12,	s13
    str	s12,	[sp, #1596]

    ldr	s10,	[sp, #1452]

    ldr	s12,	[sp, #1596]

    str	s12,	[sp, #2088]

    ldr	s13,	[sp, #2088]

    str	s13,	[sp, #1792]

    ldr	s13,	[sp, #1792]

    str	s13,	[sp, #2084]

    ldr	s9,	[sp, #2084]

    fadd	s10,	s9,	s10
    str	s10,	[sp, #1600]

    ldr	s13,	[sp, #1456]

    ldr	s9,	[sp, #1600]

    str	s9,	[sp, #2080]

    ldr	s10,	[sp, #2080]

    str	s10,	[sp, #2032]

    ldr	s10,	[sp, #2032]

    str	s10,	[sp, #2048]

    ldr	s12,	[sp, #2048]

    fadd	s9,	s12,	s13
    str	s9,	[sp, #1540]

    ldr	s10,	[sp, #1460]

    ldr	s12,	[sp, #1468]

    str	s12,	[sp, #2044]

    ldr	s13,	[sp, #2044]

    str	s13,	[sp, #1940]

    ldr	s13,	[sp, #1940]

    str	s13,	[sp, #2000]

    ldr	s9,	[sp, #2000]

    fadd	s12,	s9,	s10
    str	s12,	[sp, #1580]

    ldr	s13,	[sp, #1472]

    ldr	s9,	[sp, #1580]

    str	s9,	[sp, #1996]

    ldr	s10,	[sp, #1996]

    str	s10,	[sp, #1936]

    ldr	s10,	[sp, #1936]

    str	s10,	[sp, #1992]

    ldr	s12,	[sp, #1992]

    fadd	s10,	s12,	s13
    str	s10,	[sp, #1584]

    ldr	s10,	[sp, #1476]

    ldr	s12,	[sp, #1584]

    str	s12,	[sp, #2244]

    ldr	s13,	[sp, #2244]

    str	s13,	[sp, #1988]

    ldr	s13,	[sp, #1988]

    str	s13,	[sp, #2240]

    ldr	s9,	[sp, #2240]

    fadd	s10,	s9,	s10
    str	s10,	[sp, #1536]

    ldr	s13,	[sp, #1480]

    ldr	s9,	[sp, #1484]

    str	s9,	[sp, #2236]

    ldr	s10,	[sp, #2236]

    str	s10,	[sp, #1984]

    ldr	s10,	[sp, #1984]

    str	s10,	[sp, #2072]

    ldr	s12,	[sp, #2072]

    fadd	s12,	s12,	s13
    str	s12,	[sp, #1568]

    ldr	s9,	[sp, #1568]

    fadd	s12,	s9,	s31
    str	s12,	[sp, #1572]

    ldr	s10,	[sp, #1500]

    ldr	s12,	[sp, #1572]

    str	s12,	[sp, #2068]

    ldr	s13,	[sp, #2068]

    str	s13,	[sp, #1896]

    ldr	s13,	[sp, #1896]

    str	s13,	[sp, #2028]

    ldr	s9,	[sp, #2028]

    fadd	s12,	s9,	s10
    str	s12,	[sp, #1528]

    ldr	s13,	[sp, #1504]

    ldr	s9,	[sp, #1856]

    str	s9,	[sp, #2024]

    ldr	s10,	[sp, #2024]

    str	s10,	[sp, #2092]

    ldr	s10,	[sp, #2092]

    str	s10,	[sp, #2020]

    ldr	s12,	[sp, #2020]

    fadd	s10,	s13,	s12
    str	s10,	[sp, #2056]

    ldr	s9,	[sp, #1860]

    ldr	s12,	[sp, #2056]

    str	s12,	[sp, #2112]

    ldr	s13,	[sp, #2112]

    fadd	s10,	s13,	s9
    str	s10,	[sp, #1552]

    ldr	s9,	[sp, #1092]

    str	s9,	[sp, #1892]

    ldr	s10,	[sp, #1552]

    ldr	s13,	[sp, #1892]

    str	s13,	[sp, #2108]

    ldr	s9,	[sp, #2108]

    fadd	s9,	s10,	s9
    str	s9,	[sp, #1524]

    ldr	s10,	[sp, #1156]

    str	s10,	[sp, #1908]

    ldr	s13,	[sp, #1136]

    ldr	s9,	[sp, #1908]

    str	s9,	[sp, #2008]

    ldr	s10,	[sp, #2008]

    fadd	s10,	s10,	s13
    str	s10,	[sp, #1088]

    ldr	s13,	[sp, #1184]

    ldr	s10,	[sp, #1088]

    str	s10,	[sp, #2004]

    ldr	s12,	[sp, #2004]

    fadd	s9,	s12,	s13
    str	s9,	[sp, #1556]

    ldr	s10,	[sp, #1192]

    str	s10,	[sp, #1904]

    ldr	s10,	[sp, #1556]

    ldr	s12,	[sp, #1904]

    str	s12,	[sp, #1084]

    ldr	s13,	[sp, #1084]

    fadd	s12,	s10,	s13
    str	s12,	[sp, #1532]

    ldr	s12,	[sp, #1204]

    str	s12,	[sp, #1900]

    ldr	s12,	[sp, #1212]

    ldr	s13,	[sp, #1900]

    str	s13,	[sp, #1080]

    ldr	s9,	[sp, #1080]

    fadd	s12,	s9,	s12
    str	s12,	[sp, #1560]

    ldr	s9,	[sp, #1216]

    str	s9,	[sp, #1944]

    ldr	s12,	[sp, #1560]

    ldr	s9,	[sp, #1944]

    str	s9,	[sp, #2076]

    ldr	s10,	[sp, #2076]

    fadd	s9,	s12,	s10
    ldr	s10,	[sp, #1232]

    str	s10,	[sp, #2040]

    ldr	s12,	[sp, #2040]

    str	s12,	[sp, #1808]

    ldr	s12,	[sp, #1808]

    str	s12,	[sp, #1816]

    ldr	s13,	[sp, #1816]

    fadd	s9,	s9,	s13
    str	s9,	[sp, #1888]

    ldr	s12,	[sp, #1244]

    str	s12,	[x1]

    ldr	s10,	[sp, #1228]

    str	s10,	[x23]

    add	x23,	sp,	#812
    ldr	s12,	[sp, #1548]

    str	s12,	[x0]

    ldr	s9,	[sp, #1544]

    add	x0,	sp,	#796
    str	s9,	[x0]

    ldr	s10,	[sp, #1540]

    add	x0,	sp,	#800
    str	s10,	[x0]

    ldr	s12,	[sp, #1536]

    add	x0,	sp,	#804
    str	s12,	[x0]

    add	x0,	sp,	#816
    ldr	s9,	[sp, #1528]

    str	s9,	[x22]

    ldr	s10,	[sp, #1524]

    str	s10,	[x23]

    ldr	s12,	[sp, #1532]

    str	s12,	[x0]

    ldr	s10,	[sp, #1888]

    add	x0,	sp,	#820
    str	s10,	[x0]

    movz	w0,	#10
    bl	putfarray
    add	x13,	sp,	#724
    ldr	w2,	[sp, #3632]

    add	x8,	sp,	#772
    movz	fp,	#3252
    add	x26,	sp,	#544
    add	x10,	sp,	#520
    lsl	w4,	w2,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#784
    ldr	s9,	[x3]

    str	s9,	[sp, #1328]

    str	x8,	[sp, fp]

    movz	fp,	#3252
    ldr	w3,	[sp, #3632]

    lsl	w8,	w3,	#2
    ldr	x3,	[sp, fp]

    movz	fp,	#3236
    add	x7,	x3,	x8
    ldr	w18,	[x7]

    str	w18,	[sp, #2664]

    ldr	w9,	[sp, #3632]

    lsl	w0,	w9,	#2
    add	x11,	x10,	x0
    add	x0,	sp,	#568
    ldr	w4,	[x11]

    str	w4,	[sp, #3628]

    add	x4,	sp,	#508
    str	x0,	[sp, fp]

    movz	fp,	#3236
    ldr	w5,	[sp, #3632]

    lsl	w16,	w5,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3244
    add	x15,	x25,	x16
    add	x16,	sp,	#676
    ldr	w0,	[x15]

    str	w0,	[sp, #2600]

    str	x4,	[sp, fp]

    movz	fp,	#3244
    ldr	w6,	[sp, #3632]

    lsl	w24,	w6,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3228
    add	x21,	x1,	x24
    add	x1,	sp,	#580
    ldr	w0,	[x21]

    add	x21,	sp,	#532
    str	w0,	[sp, #3552]

    ldr	w12,	[sp, #3632]

    lsl	w2,	w12,	#2
    add	x12,	sp,	#592
    add	x0,	x26,	x2
    add	x2,	sp,	#556
    ldr	w24,	[x0]

    add	x0,	sp,	#700
    str	w24,	[sp, #3580]

    add	x24,	sp,	#760
    ldr	w17,	[sp, #3632]

    lsl	w10,	w17,	#2
    add	x3,	x2,	x10
    ldr	w4,	[x3]

    str	w4,	[sp, #3556]

    str	x24,	[sp, fp]

    movz	fp,	#3228
    ldr	w9,	[sp, #3632]

    lsl	w3,	w9,	#2
    ldr	x18,	[sp, fp]

    add	x9,	sp,	#496
    movz	fp,	#3212
    add	x2,	x18,	x3
    ldr	w22,	[x2]

    str	w22,	[sp, #5712]

    str	x9,	[sp, fp]

    movz	fp,	#3212
    ldr	w19,	[sp, #3632]

    lsl	w10,	w19,	#2
    ldr	x7,	[sp, fp]

    movz	fp,	#3220
    add	x9,	x7,	x10
    ldr	w7,	[x9]

    add	x9,	sp,	#640
    str	w7,	[sp, #3624]

    str	x13,	[sp, fp]

    movz	fp,	#3220
    ldr	w22,	[sp, #3632]

    lsl	w14,	w22,	#2
    ldr	x11,	[sp, fp]

    add	x22,	sp,	#616
    movz	fp,	#3196
    add	x13,	x11,	x14
    add	x14,	sp,	#652
    ldr	w10,	[x13]

    add	x13,	sp,	#712
    str	w10,	[sp, #2536]

    str	x1,	[sp, fp]

    movz	fp,	#3196
    ldr	w24,	[sp, #3632]

    lsl	w18,	w24,	#2
    ldr	x1,	[sp, fp]

    movz	fp,	#3188
    add	x17,	x1,	x18
    ldr	w11,	[x17]

    str	w11,	[sp, #2492]

    str	x22,	[sp, fp]

    movz	fp,	#3188
    ldr	w25,	[sp, #3632]

    lsl	w25,	w25,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#3204
    add	x24,	x17,	x25
    ldr	w17,	[x24]

    str	w17,	[sp, #5708]

    add	x17,	sp,	#604
    str	x14,	[sp, fp]

    movz	fp,	#3204
    ldr	w14,	[sp, #3632]

    lsl	w8,	w14,	#2
    ldr	x11,	[sp, fp]

    movz	fp,	#3180
    add	x8,	x11,	x8
    ldr	w14,	[x8]

    str	w14,	[sp, #5704]

    ldr	w22,	[sp, #3632]

    lsl	w18,	w22,	#2
    add	x12,	x12,	x18
    ldr	w12,	[x12]

    str	w12,	[sp, #3456]

    ldr	w25,	[sp, #3632]

    lsl	w25,	w25,	#2
    add	x10,	x0,	x25
    add	x25,	sp,	#628
    ldr	w26,	[x10]

    str	w26,	[sp, #3584]

    ldr	w0,	[sp, #3632]

    lsl	w6,	w0,	#2
    add	x14,	x13,	x6
    ldr	w7,	[x14]

    str	w7,	[sp, #3560]

    ldr	w4,	[sp, #3632]

    lsl	w7,	w4,	#2
    add	x18,	x17,	x7
    add	x17,	sp,	#736
    add	x7,	sp,	#688
    ldr	w0,	[x18]

    str	w0,	[sp, #3408]

    str	x9,	[sp, fp]

    movz	fp,	#3180
    ldr	w11,	[sp, #3632]

    lsl	w26,	w11,	#2
    ldr	x24,	[sp, fp]

    movz	fp,	#3164
    add	x24,	x24,	x26
    ldr	w27,	[x24]

    str	w27,	[sp, #5688]

    str	x25,	[sp, fp]

    movz	fp,	#3164
    ldr	w5,	[sp, #3632]

    lsl	w0,	w5,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#3172
    add	x8,	x18,	x0
    ldr	w23,	[x8]

    str	w23,	[sp, #5656]

    str	x7,	[sp, fp]

    movz	fp,	#3172
    ldr	w22,	[sp, #3632]

    lsl	w13,	w22,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#3156
    add	x0,	x25,	x13
    ldr	w8,	[x0]

    str	w8,	[sp, #5644]

    str	x21,	[sp, fp]

    movz	fp,	#3156
    ldr	w7,	[sp, #3632]

    lsl	w7,	w7,	#2
    ldr	x23,	[sp, fp]

    movz	fp,	#3148
    add	x22,	x23,	x7
    ldr	w15,	[x22]

    str	w15,	[sp, #3596]

    ldr	w0,	[sp, #3632]

    add	x15,	sp,	#748
    lsl	w6,	w0,	#2
    add	x0,	x15,	x6
    ldr	w7,	[x0]

    str	w7,	[sp, #3468]

    ldr	w13,	[sp, #3632]

    lsl	w12,	w13,	#2
    add	x18,	x17,	x12
    ldr	w0,	[x18]

    str	w0,	[sp, #3420]

    str	x16,	[sp, fp]

    movz	fp,	#3148
    ldr	w12,	[sp, #3632]

    lsl	w7,	w12,	#2
    ldr	x18,	[sp, fp]

    add	x12,	sp,	#664
    add	x0,	x18,	x7
    ldr	w24,	[x0]

    str	w24,	[sp, #10404]

    ldr	w22,	[sp, #3632]

    lsl	w22,	w22,	#2
    add	x12,	x12,	x22
    ldr	w21,	[x12]

    str	w21,	[sp, #3308]

    ldr	w17,	[sp, #2664]

    mov	w21,	w17
    str	w21,	[sp, #2620]

    ldr	w18,	[sp, #3628]

    mov	w6,	w18
    str	w6,	[sp, #8940]

    ldr	w17,	[sp, #2600]

    mov	w1,	w17
    str	w1,	[sp, #5660]

    ldr	s9,	[sp, #1344]

    str	s9,	[sp, #1832]

    ldr	w21,	[sp, #3552]

    mov	w11,	w21
    str	w11,	[sp, #5672]

    ldr	w22,	[sp, #3580]

    mov	w11,	w22
    str	w11,	[sp, #8944]

    ldr	w15,	[sp, #3556]

    mov	w16,	w15
    str	w16,	[sp, #8948]

    ldr	s30,	[sp, #1252]

    ldr	s24,	[sp, #1368]

    fmov	s9,	s30
    str	s24,	[sp, #1692]

    ldr	s25,	[sp, #1256]

    ldr	w0,	[sp, #5712]

    fmov	s24,	s25
    mov	w3,	w0
    str	w3,	[sp, #1076]

    ldr	s27,	[sp, #1340]

    str	s27,	[sp, #1828]

    ldr	s31,	[sp, #1400]

    str	s31,	[sp, #1716]

    ldr	w18,	[sp, #3624]

    mov	w1,	w18
    str	w1,	[sp, #7892]

    ldr	s19,	[sp, #1260]

    str	s19,	[sp, #1732]

    ldr	w6,	[sp, #2536]

    mov	w8,	w6
    str	w8,	[sp, #1032]

    ldr	s30,	[sp, #1264]

    str	s30,	[sp, #1720]

    ldr	s5,	[sp, #1268]

    str	s5,	[sp, #1680]

    ldr	s18,	[sp, #1272]

    ldr	s12,	[sp, #1356]

    fmov	s16,	s18
    str	s12,	[sp, #1676]

    ldr	s2,	[sp, #1276]

    str	s2,	[sp, #1728]

    ldr	s13,	[sp, #1280]

    ldr	w14,	[sp, #2492]

    fmov	s21,	s13
    mov	w23,	w14
    str	w23,	[sp, #8952]

    ldr	s27,	[sp, #1408]

    str	s27,	[sp, #1724]

    ldr	w2,	[sp, #5708]

    mov	w5,	w2
    str	w5,	[sp, #5680]

    ldr	w6,	[sp, #5704]

    mov	w8,	w6
    str	w8,	[sp, #5692]

    ldr	s27,	[sp, #1284]

    fmov	s22,	s27
    str	s22,	[sp, #1704]

    ldr	s3,	[sp, #1288]

    str	s3,	[sp, #1112]

    ldr	s6,	[sp, #1384]

    fmov	s3,	s6
    str	s3,	[sp, #1708]

    ldr	s27,	[sp, #1348]

    ldr	s5,	[sp, #1392]

    fmov	s6,	s27
    fmov	s25,	s5
    str	s25,	[sp, #1712]

    ldr	w21,	[sp, #3456]

    mov	w0,	w21
    str	w0,	[sp, #5648]

    ldr	s26,	[sp, #1292]

    str	s26,	[sp, #1164]

    ldr	w3,	[sp, #3584]

    mov	w18,	w3
    str	w18,	[sp, #2472]

    ldr	s10,	[sp, #1296]

    fmov	s25,	s10
    str	s25,	[sp, #1696]

    ldr	s28,	[sp, #1300]

    fmov	s13,	s28
    str	s13,	[sp, #1688]

    ldr	s27,	[sp, #1304]

    ldr	s20,	[sp, #1308]

    fmov	s5,	s27
    str	s20,	[sp, #1140]

    ldr	w21,	[sp, #3560]

    mov	w2,	w21
    str	w2,	[sp, #2540]

    ldr	w1,	[sp, #3408]

    mov	w5,	w1
    str	w5,	[sp, #5652]

    ldr	s18,	[sp, #1364]

    fmov	s25,	s18
    str	s25,	[sp, #1684]

    ldr	s18,	[sp, #1352]

    ldr	s26,	[sp, #1332]

    ldr	w4,	[sp, #5688]

    fmov	s10,	s26
    mov	w0,	w4
    str	w0,	[sp, #5676]

    ldr	s27,	[sp, #1404]

    str	s27,	[sp, #1152]

    ldr	w4,	[sp, #5656]

    mov	w28,	w4
    str	w28,	[sp, #8956]

    ldr	w0,	[sp, #5644]

    mov	w4,	w0
    str	w4,	[sp, #5684]

    ldr	s12,	[sp, #1396]

    fmov	s31,	s12
    str	s31,	[sp, #1124]

    ldr	s27,	[sp, #1388]

    ldr	s29,	[sp, #1360]

    fmov	s22,	s27
    fmov	s20,	s29
    str	s20,	[sp, #1844]

    ldr	s31,	[sp, #1312]

    str	s31,	[sp, #1096]

    ldr	w4,	[sp, #3596]

    mov	w8,	w4
    str	w8,	[sp, #9376]

    ldr	w0,	[sp, #3468]

    mov	w2,	w0
    str	w2,	[sp, #5700]

    ldr	w6,	[sp, #3420]

    mov	w28,	w6
    str	w28,	[sp, #5696]

    ldr	s19,	[sp, #1372]

    ldr	s31,	[sp, #1376]

    fmov	s26,	s19
    ldr	s13,	[sp, #1380]

    fmov	s25,	s31
    fmov	s2,	s13
    str	s2,	[sp, #1840]

    ldr	s17,	[sp, #1316]

    fmov	s3,	s17
    str	s3,	[sp, #1836]

    ldr	s2,	[sp, #1320]

    str	s2,	[sp, #1196]

    ldr	s4,	[sp, #1324]

    ldr	w25,	[sp, #10404]

    fmov	s2,	s4
    mov	w0,	w25
    str	w0,	[sp, #7040]

    ldr	s23,	[sp, #1336]

    str	s23,	[sp, #1148]

    ldr	w18,	[sp, #3308]

    mov	w13,	w18
    str	w13,	[sp, #3860]

    ldr	s23,	[sp, #1412]

    str	s23,	[sp, #1188]


main_309:
    ldr	w6,	[sp, #2620]

    cmp	w6,	#0
    beq	main_308

main_375:
    fadd	s12,	s10,	s16
    add	x24,	sp,	#944
    movz	fp,	#2060
    str	s12,	[sp, #1920]

    ldr	s13,	[sp, #1148]

    ldr	s14,	[sp, #1920]

    fadd	s10,	s14,	s13
    ldr	s14,	[sp, #1828]

    fadd	s10,	s10,	s14
    str	s10,	[sp, #1248]

    ldr	s10,	[sp, #1832]

    fadd	s10,	s10,	s5
    fadd	s10,	s10,	s21
    fadd	s10,	s10,	s24
    str	s10,	[sp, #1240]

    ldr	s8,	[sp, #1676]

    fadd	s10,	s9,	s6
    fadd	s15,	s10,	s18
    fadd	s8,	s15,	s8
    str	s8,	[sp, #1224]

    ldr	s15,	[sp, #1680]

    ldr	s10,	[sp, #1844]

    ldr	s14,	[sp, #1684]

    fadd	s15,	s15,	s10
    ldr	s8,	[sp, #1692]

    fadd	s15,	s15,	s14
    fadd	s12,	s15,	s8
    str	s12,	[sp, #1208]

    ldr	s12,	[sp, #1688]

    fadd	s9,	s12,	s2
    fadd	s9,	s9,	s26
    fadd	s14,	s9,	s25
    str	s14,	[sp, #1756]

    ldr	s15,	[sp, #1696]

    ldr	s11,	[sp, #1704]

    ldr	s12,	[sp, #1840]

    fadd	s15,	s11,	s15
    ldr	s10,	[sp, #1708]

    fadd	s9,	s15,	s12
    fadd	s10,	s9,	s10
    str	s10,	[sp, #1752]

    ldr	s14,	[sp, #1712]

    fadd	s10,	s22,	s14
    ldr	s14,	[sp, #1836]

    ldr	s15,	[sp, #1124]

    fadd	s9,	s10,	s14
    fadd	s11,	s9,	s15
    str	s11,	[sp, #1864]

    ldr	s14,	[sp, #1096]

    ldr	s13,	[sp, #1716]

    ldr	s10,	[sp, #1720]

    fadd	s15,	s13,	s14
    fadd	s9,	s15,	s10
    ldr	s10,	[sp, #1152]

    fadd	s12,	s9,	s10
    str	s12,	[sp, #2036]

    ldr	s13,	[sp, #1112]

    ldr	s15,	[sp, #1724]

    fadd	s10,	s15,	s13
    str	s10,	[sp, #1776]

    ldr	s14,	[sp, #1140]

    ldr	s11,	[sp, #1776]

    fadd	s11,	s11,	s14
    str	s11,	[sp, #1768]

    ldr	s15,	[sp, #1188]

    ldr	s12,	[sp, #1768]

    fadd	s8,	s12,	s15
    str	s8,	[sp, #1748]

    ldr	s14,	[sp, #1196]

    ldr	s9,	[sp, #1732]

    ldr	s12,	[sp, #1728]

    fadd	s13,	s14,	s9
    ldr	s15,	[sp, #1164]

    fadd	s14,	s13,	s12
    str	x24,	[sp, fp]

    fadd	s14,	s14,	s15
    add	x24,	sp,	#964
    movz	fp,	#2060
    ldr	s15,	[sp, #1248]

    ldr	x0,	[sp, fp]

    movz	fp,	#5020
    str	s15,	[x0]

    ldr	s11,	[sp, #1240]

    add	x0,	sp,	#948
    str	s11,	[x0]

    ldr	s15,	[sp, #1224]

    add	x0,	sp,	#952
    str	s15,	[x0]

    ldr	s8,	[sp, #1208]

    add	x0,	sp,	#956
    str	s8,	[x0]

    ldr	s8,	[sp, #1756]

    add	x0,	sp,	#960
    str	s8,	[x0]

    add	x0,	sp,	#968
    ldr	s12,	[sp, #1752]

    str	s12,	[x24]

    ldr	s13,	[sp, #1864]

    str	s13,	[x0]

    ldr	s13,	[sp, #2036]

    add	x0,	sp,	#972
    str	s13,	[x0]

    ldr	s9,	[sp, #1748]

    add	x0,	sp,	#976
    str	s9,	[x0]

    add	x0,	sp,	#980
    str	s14,	[x0]

    ldr	w0,	[sp, #5672]

    ldr	w20,	[sp, #8940]

    ldr	w27,	[sp, #7892]

    add	w18,	w0,	w20
    add	w0,	w18,	w27
    str	w0,	[sp, #5172]

    ldr	w0,	[sp, #8944]

    ldr	w27,	[sp, #8948]

    ldr	w25,	[sp, #9376]

    add	w24,	w27,	w0
    add	w26,	w24,	w25
    str	w26,	[sp, #2464]

    ldr	w19,	[sp, #5660]

    ldr	w23,	[sp, #8952]

    ldr	w18,	[sp, #5648]

    add	w0,	w23,	w19
    add	w25,	w0,	w18
    str	w25,	[sp, #2468]

    ldr	w25,	[sp, #5652]

    ldr	w26,	[sp, #5680]

    ldr	w28,	[sp, #8956]

    add	w1,	w25,	w26
    add	w22,	w1,	w28
    str	w22,	[sp, #5224]

    ldr	w19,	[sp, #5676]

    ldr	w21,	[sp, #5692]

    ldr	w1,	[sp, #3860]

    add	w18,	w19,	w21
    add	w23,	w18,	w1
    str	w23,	[sp, #1924]

    ldr	w1,	[sp, #2472]

    ldr	w20,	[sp, #5684]

    ldr	w18,	[sp, #7040]

    add	w0,	w20,	w1
    add	w21,	w0,	w18
    add	x18,	sp,	#996
    str	w21,	[sp, #1928]

    ldr	w23,	[sp, #2540]

    ldr	w0,	[sp, #1032]

    add	w21,	w23,	w0
    ldr	w0,	[sp, #5696]

    add	w21,	w21,	w0
    add	x0,	sp,	#984
    str	w21,	[sp, #2264]

    ldr	w1,	[sp, #1076]

    ldr	w19,	[sp, #2620]

    ldr	w25,	[sp, #5700]

    add	w1,	w1,	w19
    add	w24,	w1,	w25
    str	w24,	[sp, #2268]

    add	x24,	sp,	#1000
    str	x0,	[sp, #2432]

    ldr	x1,	[sp, #2432]

    ldr	w0,	[sp, #5172]

    str	w0,	[x1]

    add	x0,	sp,	#992
    add	x1,	sp,	#988
    str	x1,	[sp, #4832]

    ldr	w1,	[sp, #2464]

    ldr	x27,	[sp, #4832]

    str	w1,	[x27]

    str	x0,	[sp, #2392]

    ldr	w0,	[sp, #2468]

    ldr	x1,	[sp, #2392]

    str	w0,	[x1]

    add	x1,	sp,	#1004
    str	x18,	[sp, #2408]

    ldr	x0,	[sp, #2408]

    ldr	w20,	[sp, #5224]

    str	w20,	[x0]

    str	x24,	[sp, #2440]

    ldr	w18,	[sp, #1924]

    ldr	x0,	[sp, #2440]

    str	w18,	[x0]

    str	x1,	[sp, fp]

    add	x1,	sp,	#1008
    movz	fp,	#5020
    ldr	w0,	[sp, #1928]

    ldr	x18,	[sp, fp]

    movz	fp,	#5052
    str	w0,	[x18]

    add	x0,	sp,	#1012
    str	x1,	[sp, fp]

    movz	fp,	#5052
    ldr	w1,	[sp, #2264]

    ldr	x24,	[sp, fp]

    movz	fp,	#5076
    str	w1,	[x24]

    str	x0,	[sp, fp]

    movz	fp,	#5076
    ldr	w0,	[sp, #2268]

    ldr	x1,	[sp, fp]

    movz	fp,	#2060
    str	w0,	[x1]

    movz	w0,	#10
    ldr	x1,	[sp, fp]

    bl	putfarray
    ldr	x1,	[sp, #2432]

    movz	w0,	#8
    bl	putarray
    movz	fp,	#5020
    ldr	w28,	[sp, #5172]

    ldr	s3,	[sp, #1248]

    scvtf	s9,	w28
    ldr	x23,	[sp, #2432]

    fsub	s9,	s9,	s3
    fcvtzs	w0,	s9
    str	w0,	[x23]

    ldr	w8,	[sp, #2464]

    ldr	s27,	[sp, #1240]

    scvtf	s11,	w8
    ldr	x19,	[sp, #4832]

    fsub	s4,	s11,	s27
    fcvtzs	w4,	s4
    str	w4,	[x19]

    ldr	w12,	[sp, #2468]

    ldr	s11,	[sp, #1224]

    scvtf	s6,	w12
    ldr	x26,	[sp, #2392]

    fsub	s22,	s6,	s11
    fcvtzs	w1,	s22
    str	w1,	[x26]

    ldr	w21,	[sp, #5224]

    ldr	s17,	[sp, #1208]

    scvtf	s24,	w21
    ldr	x8,	[sp, #2408]

    fsub	s10,	s24,	s17
    fcvtzs	w4,	s10
    str	w4,	[x8]

    ldr	w16,	[sp, #1924]

    ldr	s21,	[sp, #1756]

    scvtf	s15,	w16
    ldr	x27,	[sp, #2440]

    fsub	s13,	s15,	s21
    fcvtzs	w7,	s13
    str	w7,	[x27]

    ldr	w24,	[sp, #1928]

    ldr	s17,	[sp, #1752]

    scvtf	s22,	w24
    ldr	x15,	[sp, fp]

    fsub	s17,	s22,	s17
    movz	fp,	#5052
    fcvtzs	w10,	s17
    str	w10,	[x15]

    ldr	w4,	[sp, #2264]

    ldr	s16,	[sp, #1864]

    scvtf	s19,	w4
    ldr	x4,	[sp, fp]

    fsub	s13,	s19,	s16
    movz	fp,	#5076
    fcvtzs	w17,	s13
    str	w17,	[x4]

    ldr	w8,	[sp, #2268]

    ldr	s4,	[sp, #2036]

    scvtf	s20,	w8
    ldr	x16,	[sp, fp]

    fsub	s15,	s20,	s4
    movz	fp,	#5084
    fcvtzs	w22,	s15
    str	w22,	[x16]

    ldr	w3,	[sp, #3632]

    lsl	w18,	w3,	#2
    mov	x17,	x18
    add	x17,	sp,	x17
    add	x17,	x17,	#984
    ldr	w21,	[x17]

    ldr	x25,	[sp, #3616]

    scvtf	s12,	w21
    mov	x18,	x25
    str	x18,	[sp, fp]

    movz	fp,	#3028
    ldr	x18,	[sp, #3608]

    mov	x16,	x18
    str	x16,	[sp, fp]

    movz	fp,	#5068
    ldr	x14,	[sp, #3600]

    mov	x11,	x14
    str	x11,	[sp, fp]

    movz	fp,	#3588
    ldr	x6,	[sp, fp]

    movz	fp,	#5092
    mov	x21,	x6
    str	x21,	[sp, fp]

    movz	fp,	#3572
    ldr	x18,	[sp, fp]

    movz	fp,	#5108
    mov	x0,	x18
    str	x0,	[sp, fp]

    movz	fp,	#3564
    ldr	x14,	[sp, fp]

    movz	fp,	#3036
    mov	x24,	x14
    str	x24,	[sp, fp]

    movz	fp,	#3044
    ldr	x26,	[sp, #3544]

    mov	x0,	x26
    str	x0,	[sp, fp]

    movz	fp,	#3052
    ldr	x18,	[sp, #3536]

    mov	x4,	x18
    str	x4,	[sp, fp]

    movz	fp,	#3060
    ldr	x14,	[sp, #3528]

    mov	x8,	x14
    str	x8,	[sp, fp]

    movz	fp,	#5116
    ldr	x10,	[sp, #3520]

    mov	x3,	x10
    str	x3,	[sp, fp]

    movz	fp,	#5132
    ldr	x6,	[sp, #3512]

    mov	x11,	x6
    str	x11,	[sp, fp]

    movz	fp,	#5140
    ldr	x2,	[sp, #3504]

    mov	x14,	x2
    str	x14,	[sp, fp]

    movz	fp,	#3068
    ldr	x4,	[sp, #3496]

    mov	x15,	x4
    str	x15,	[sp, fp]

    movz	fp,	#5148
    ldr	x26,	[sp, #3488]

    mov	x17,	x26
    str	x17,	[sp, fp]

    movz	fp,	#5156
    ldr	x19,	[sp, #3480]

    mov	x20,	x19
    str	x20,	[sp, fp]

    movz	fp,	#5164
    ldr	x15,	[sp, #3472]

    mov	x23,	x15
    str	x23,	[sp, fp]

    movz	fp,	#3460
    ldr	x3,	[sp, fp]

    movz	fp,	#3076
    mov	x6,	x3
    str	x6,	[sp, fp]

    movz	fp,	#3084
    ldr	x1,	[sp, #3448]

    mov	x0,	x1
    str	x0,	[sp, fp]

    movz	fp,	#3092
    ldr	x3,	[sp, #3440]

    mov	x1,	x3
    str	x1,	[sp, #5176]

    ldr	x23,	[sp, #3432]

    mov	x4,	x23
    str	x4,	[sp, #5184]

    ldr	x17,	[sp, #3424]

    mov	x0,	x17
    str	x0,	[sp, fp]

    movz	fp,	#3412
    ldr	x12,	[sp, fp]

    movz	fp,	#3100
    str	x12,	[sp, fp]

    movz	fp,	#3108
    ldr	x12,	[sp, #3400]

    mov	x7,	x12
    str	x7,	[sp, #5192]

    ldr	x9,	[sp, #3392]

    mov	x10,	x9
    str	x10,	[sp, #5200]

    ldr	x5,	[sp, #3384]

    mov	x13,	x5
    str	x13,	[sp, #5208]

    ldr	x15,	[sp, #3376]

    mov	x16,	x15
    str	x16,	[sp, #5216]

    ldr	x2,	[sp, #3368]

    str	x2,	[sp, fp]

    movz	fp,	#7876
    ldr	x2,	[sp, #3360]

    mov	x24,	x2
    str	x24,	[sp, fp]

    add	x24,	sp,	#916
    movz	fp,	#5228
    ldr	x15,	[sp, #3352]

    mov	x23,	x15
    str	x23,	[sp, fp]

    movz	fp,	#3116
    ldr	x17,	[sp, #3344]

    str	x17,	[sp, fp]

    movz	fp,	#3124
    ldr	x2,	[sp, #3336]

    mov	x1,	x2
    str	x1,	[sp, fp]

    add	x1,	sp,	#904
    movz	fp,	#5236
    ldr	x3,	[sp, #3328]

    mov	x26,	x3
    str	x26,	[sp, fp]

    movz	fp,	#5244
    ldr	x21,	[sp, #3320]

    mov	x0,	x21
    str	x0,	[sp, fp]

    movz	fp,	#3132
    ldr	x21,	[sp, #3312]

    str	x21,	[sp, fp]

    movz	fp,	#3300
    ldr	x6,	[sp, fp]

    movz	fp,	#3140
    mov	x21,	x6
    str	x21,	[sp, fp]

    movz	fp,	#3292
    ldr	x6,	[sp, fp]

    movz	fp,	#5252
    mov	x3,	x6
    str	x3,	[sp, fp]

    movz	fp,	#3284
    ldr	x2,	[sp, fp]

    movz	fp,	#7884
    mov	x27,	x2
    str	x27,	[sp, fp]

    movz	fp,	#3276
    ldr	x2,	[sp, fp]

    movz	fp,	#5260
    mov	x6,	x2
    str	x6,	[sp, fp]

    add	x6,	sp,	#908
    movz	fp,	#3268
    ldr	x3,	[sp, fp]

    movz	fp,	#5268
    mov	x9,	x3
    str	x9,	[sp, fp]

    movz	fp,	#3260
    ldr	x21,	[sp, fp]

    movz	fp,	#5284
    mov	x15,	x21
    str	x15,	[sp, fp]

    add	x15,	sp,	#920
    movz	fp,	#2988
    str	x1,	[sp, fp]

    add	x1,	sp,	#912
    movz	fp,	#2756
    str	x6,	[sp, fp]

    add	x6,	sp,	#924
    movz	fp,	#2764
    str	x1,	[sp, fp]

    add	x1,	sp,	#940
    movz	fp,	#2788
    str	x24,	[sp, #2776]

    str	x15,	[sp, fp]

    add	x15,	sp,	#928
    movz	fp,	#2796
    str	x6,	[sp, fp]

    movz	fp,	#2828
    add	x6,	sp,	#932
    str	x15,	[sp, #2808]

    str	x6,	[sp, #2816]

    add	x6,	sp,	#936
    str	x6,	[sp, fp]

    movz	fp,	#2836
    str	x1,	[sp, fp]

    movz	fp,	#5084
    ldr	x19,	[sp, fp]

    movz	fp,	#3028
    mov	x0,	x19
    str	x0,	[sp, #5664]

    ldr	x6,	[sp, fp]

    movz	fp,	#2948
    mov	x23,	x6
    str	x23,	[sp, fp]

    movz	fp,	#5068
    ldr	x12,	[sp, fp]

    movz	fp,	#2924
    mov	x21,	x12
    str	x21,	[sp, fp]

    movz	fp,	#5092
    ldr	x22,	[sp, fp]

    movz	fp,	#2908
    mov	x23,	x22
    str	x23,	[sp, fp]

    movz	fp,	#5108
    ldr	x1,	[sp, fp]

    movz	fp,	#2852
    mov	x23,	x1
    str	x23,	[sp, fp]

    movz	fp,	#3036
    ldr	x23,	[sp, fp]

    movz	fp,	#3044
    str	x23,	[sp, #2864]

    ldr	x6,	[sp, fp]

    movz	fp,	#2876
    mov	x23,	x6
    str	x23,	[sp, fp]

    movz	fp,	#3052
    ldr	x23,	[sp, fp]

    movz	fp,	#2884
    str	x23,	[sp, fp]

    movz	fp,	#3060
    ldr	x21,	[sp, fp]

    movz	fp,	#2892
    mov	x23,	x21
    str	x23,	[sp, fp]

    movz	fp,	#5116
    ldr	x4,	[sp, fp]

    movz	fp,	#2844
    mov	x23,	x4
    str	x23,	[sp, fp]

    movz	fp,	#5132
    ldr	x12,	[sp, fp]

    movz	fp,	#2740
    mov	x6,	x12
    str	x6,	[sp, fp]

    movz	fp,	#5140
    ldr	x15,	[sp, fp]

    movz	fp,	#3068
    mov	x23,	x15
    str	x23,	[sp, #2720]

    ldr	x16,	[sp, fp]

    movz	fp,	#2732
    mov	x23,	x16
    str	x23,	[sp, fp]

    movz	fp,	#5148
    ldr	x18,	[sp, fp]

    movz	fp,	#2708
    mov	x22,	x18
    str	x22,	[sp, fp]

    movz	fp,	#5156
    ldr	x21,	[sp, fp]

    movz	fp,	#2692
    mov	x22,	x21
    str	x22,	[sp, fp]

    movz	fp,	#5164
    ldr	x24,	[sp, fp]

    movz	fp,	#2668
    mov	x21,	x24
    str	x21,	[sp, fp]

    movz	fp,	#3076
    ldr	x21,	[sp, fp]

    movz	fp,	#2676
    mov	x11,	x21
    str	x11,	[sp, fp]

    movz	fp,	#3084
    ldr	x7,	[sp, fp]

    movz	fp,	#2684
    mov	x21,	x7
    str	x21,	[sp, fp]

    movz	fp,	#2604
    ldr	x2,	[sp, #5176]

    mov	x1,	x2
    str	x1,	[sp, #2656]

    ldr	x5,	[sp, #5184]

    mov	x25,	x5
    str	x25,	[sp, fp]

    movz	fp,	#3092
    ldr	x10,	[sp, fp]

    movz	fp,	#3100
    mov	x21,	x10
    str	x21,	[sp, #2624]

    ldr	x21,	[sp, fp]

    movz	fp,	#1060
    mov	x6,	x21
    str	x6,	[sp, #2640]

    ldr	x8,	[sp, #5192]

    mov	x21,	x8
    str	x21,	[sp, #2584]

    ldr	x11,	[sp, #5200]

    mov	x26,	x11
    str	x26,	[sp, fp]

    movz	fp,	#1036
    ldr	x14,	[sp, #5208]

    mov	x21,	x14
    str	x21,	[sp, fp]

    movz	fp,	#3108
    ldr	x17,	[sp, #5216]

    mov	x16,	x17
    str	x16,	[sp, #2568]

    ldr	x1,	[sp, fp]

    movz	fp,	#7876
    str	x1,	[sp, #1016]

    ldr	x25,	[sp, fp]

    movz	fp,	#5228
    mov	x1,	x25
    str	x1,	[sp, #2544]

    ldr	x24,	[sp, fp]

    movz	fp,	#2476
    mov	x7,	x24
    str	x7,	[sp, fp]

    movz	fp,	#3116
    ldr	x7,	[sp, fp]

    movz	fp,	#3124
    mov	x5,	x7
    str	x5,	[sp, #2496]

    ldr	x0,	[sp, fp]

    movz	fp,	#5236
    mov	x5,	x0
    str	x5,	[sp, #2512]

    ldr	x27,	[sp, fp]

    movz	fp,	#2300
    mov	x0,	x27
    str	x0,	[sp, fp]

    movz	fp,	#5244
    ldr	x1,	[sp, fp]

    movz	fp,	#3132
    mov	x9,	x1
    str	x9,	[sp, #2376]

    ldr	x0,	[sp, fp]

    movz	fp,	#3140
    mov	x4,	x0
    str	x4,	[sp, #2384]

    ldr	x5,	[sp, fp]

    movz	fp,	#2284
    mov	x0,	x5
    str	x0,	[sp, fp]

    movz	fp,	#5252
    ldr	x4,	[sp, fp]

    movz	fp,	#7884
    mov	x19,	x4
    str	x19,	[sp, #2368]

    ldr	x28,	[sp, fp]

    movz	fp,	#2348
    mov	x0,	x28
    str	x0,	[sp, fp]

    movz	fp,	#5260
    ldr	x7,	[sp, fp]

    movz	fp,	#2340
    mov	x5,	x7
    str	x5,	[sp, fp]

    movz	fp,	#5268
    ldr	x10,	[sp, fp]

    movz	fp,	#2316
    mov	x3,	x10
    str	x3,	[sp, fp]

    movz	fp,	#5284
    ldr	x16,	[sp, fp]

    mov	x19,	x16
    str	x19,	[sp, #2272]


main_518:
    ldr	w4,	[sp, #3632]

    movz	fp,	#2948
    ldr	x1,	[sp, #5664]

    lsl	w19,	w4,	#2
    add	x13,	x1,	x19
    ldr	s19,	[x13]

    ldr	w5,	[sp, #3632]

    ldr	x15,	[sp, fp]

    lsl	w1,	w5,	#2
    movz	fp,	#2924
    add	x16,	x15,	x1
    ldr	s6,	[x16]

    ldr	w6,	[sp, #3632]

    fadd	s25,	s19,	s6
    ldr	x3,	[sp, fp]

    lsl	w0,	w6,	#2
    movz	fp,	#2908
    add	x4,	x3,	x0
    ldr	s10,	[x4]

    ldr	w7,	[sp, #3632]

    fadd	s29,	s25,	s10
    ldr	x18,	[sp, fp]

    lsl	w2,	w7,	#2
    movi	v10.4s,	#0
    movz	fp,	#2852
    add	x0,	x18,	x2
    ldr	s13,	[x0]

    ldr	w8,	[sp, #3632]

    fadd	s8,	s29,	s13
    ldr	x25,	[sp, fp]

    lsl	w0,	w8,	#2
    movz	fp,	#2876
    add	x4,	x25,	x0
    ldr	s11,	[x4]

    ldr	w9,	[sp, #3632]

    ldr	x7,	[sp, #2864]

    lsl	w3,	w9,	#2
    add	x2,	x7,	x3
    ldr	s27,	[x2]

    ldr	w10,	[sp, #3632]

    fadd	s15,	s11,	s27
    ldr	x17,	[sp, fp]

    lsl	w7,	w10,	#2
    movz	fp,	#2884
    add	x6,	x17,	x7
    ldr	s2,	[x6]

    ldr	w11,	[sp, #3632]

    fadd	s17,	s15,	s2
    ldr	x26,	[sp, fp]

    lsl	w11,	w11,	#2
    movz	fp,	#2892
    add	x10,	x26,	x11
    ldr	s9,	[x10]

    ldr	w12,	[sp, #3632]

    fadd	s19,	s17,	s9
    ldr	x2,	[sp, fp]

    lsl	w19,	w12,	#2
    movz	fp,	#2844
    add	x14,	x2,	x19
    ldr	s1,	[x14]

    ldr	w13,	[sp, #3632]

    ldr	x15,	[sp, fp]

    lsl	w5,	w13,	#2
    movz	fp,	#2740
    add	x17,	x15,	x5
    ldr	s17,	[x17]

    ldr	w14,	[sp, #3632]

    fadd	s6,	s1,	s17
    ldr	x0,	[sp, fp]

    lsl	w5,	w14,	#2
    movz	fp,	#2732
    add	x0,	x0,	x5
    ldr	s25,	[x0]

    ldr	w15,	[sp, #3632]

    fadd	s7,	s6,	s25
    ldr	x10,	[sp, #2720]

    lsl	w3,	w15,	#2
    add	x1,	x10,	x3
    ldr	s31,	[x1]

    ldr	w16,	[sp, #3632]

    fadd	s2,	s7,	s31
    ldr	x23,	[sp, fp]

    lsl	w1,	w16,	#2
    movz	fp,	#2708
    add	x0,	x23,	x1
    ldr	s21,	[x0]

    ldr	w17,	[sp, #3632]

    ldr	x0,	[sp, fp]

    lsl	w6,	w17,	#2
    movz	fp,	#2692
    add	x3,	x0,	x6
    ldr	s14,	[x3]

    ldr	w18,	[sp, #3632]

    fadd	s28,	s21,	s14
    ldr	x14,	[sp, fp]

    lsl	w8,	w18,	#2
    movz	fp,	#2668
    add	x7,	x14,	x8
    ldr	s13,	[x7]

    ldr	w21,	[sp, #3632]

    fadd	s28,	s28,	s13
    ldr	x0,	[sp, fp]

    lsl	w14,	w21,	#2
    movz	fp,	#2676
    add	x11,	x0,	x14
    ldr	s21,	[x11]

    ldr	w24,	[sp, #3632]

    fadd	s21,	s28,	s21
    ldr	x3,	[sp, fp]

    lsl	w24,	w24,	#2
    movz	fp,	#2684
    add	x16,	x3,	x24
    ldr	s15,	[x16]

    ldr	w25,	[sp, #3632]

    ldr	x9,	[sp, fp]

    lsl	w3,	w25,	#2
    movz	fp,	#2604
    add	x22,	x9,	x3
    ldr	s4,	[x22]

    ldr	w26,	[sp, #3632]

    fadd	s16,	s15,	s4
    ldr	x15,	[sp, #2656]

    lsl	w0,	w26,	#2
    add	x5,	x15,	x0
    ldr	s13,	[x5]

    ldr	w0,	[sp, #3632]

    fadd	s22,	s16,	s13
    ldr	x3,	[sp, fp]

    lsl	w7,	w0,	#2
    movz	fp,	#1060
    add	x2,	x3,	x7
    ldr	s11,	[x2]

    ldr	w0,	[sp, #3632]

    fadd	s17,	s22,	s11
    ldr	x21,	[sp, #2624]

    lsl	w2,	w0,	#2
    add	x1,	x21,	x2
    ldr	s6,	[x1]

    ldr	w1,	[sp, #3632]

    ldr	x4,	[sp, #2640]

    lsl	w8,	w1,	#2
    add	x4,	x4,	x8
    ldr	s24,	[x4]

    ldr	w2,	[sp, #3632]

    fadd	s14,	s6,	s24
    ldr	x15,	[sp, #2584]

    lsl	w9,	w2,	#2
    add	x8,	x15,	x9
    ldr	s1,	[x8]

    ldr	w3,	[sp, #3632]

    fadd	s9,	s14,	s1
    ldr	x0,	[sp, fp]

    lsl	w16,	w3,	#2
    movz	fp,	#1036
    add	x13,	x0,	x16
    ldr	s3,	[x13]

    ldr	w4,	[sp, #3632]

    fadd	s5,	s9,	s3
    ldr	x8,	[sp, fp]

    lsl	w1,	w4,	#2
    movz	fp,	#2476
    add	x17,	x8,	x1
    ldr	s25,	[x17]

    ldr	w5,	[sp, #3632]

    ldr	x8,	[sp, #2568]

    lsl	w5,	w5,	#2
    add	x0,	x8,	x5
    ldr	s16,	[x0]

    ldr	w6,	[sp, #3632]

    fadd	s4,	s25,	s16
    ldr	x18,	[sp, #1016]

    lsl	w1,	w6,	#2
    add	x2,	x18,	x1
    ldr	s27,	[x2]

    ldr	w7,	[sp, #3632]

    fadd	s3,	s4,	s27
    ldr	x21,	[sp, #2544]

    lsl	w5,	w7,	#2
    add	x3,	x21,	x5
    ldr	s20,	[x3]

    ldr	w8,	[sp, #3632]

    fadd	s24,	s3,	s20
    ldr	x5,	[sp, fp]

    lsl	w3,	w8,	#2
    movz	fp,	#2300
    add	x2,	x5,	x3
    ldr	s16,	[x2]

    ldr	w9,	[sp, #3632]

    ldr	x16,	[sp, #2496]

    lsl	w6,	w9,	#2
    add	x5,	x16,	x6
    ldr	s20,	[x5]

    ldr	w10,	[sp, #3632]

    fadd	s28,	s16,	s20
    ldr	x0,	[sp, #2512]

    lsl	w12,	w10,	#2
    add	x9,	x0,	x12
    ldr	s15,	[x9]

    ldr	w11,	[sp, #3632]

    fadd	s16,	s28,	s15
    ldr	x13,	[sp, fp]

    lsl	w18,	w11,	#2
    movz	fp,	#2284
    add	x14,	x13,	x18
    ldr	s28,	[x14]

    ldr	w12,	[sp, #3632]

    fadd	s13,	s16,	s28
    ldr	x21,	[sp, #2376]

    lsl	w0,	w12,	#2
    add	x18,	x21,	x0
    ldr	s31,	[x18]

    ldr	w13,	[sp, #3632]

    ldr	x0,	[sp, #2384]

    lsl	w2,	w13,	#2
    add	x0,	x0,	x2
    ldr	s23,	[x0]

    ldr	w14,	[sp, #3632]

    fadd	s15,	s31,	s23
    ldr	x6,	[sp, fp]

    lsl	w2,	w14,	#2
    movz	fp,	#2348
    add	x0,	x6,	x2
    ldr	s18,	[x0]

    ldr	w15,	[sp, #3632]

    fadd	s27,	s15,	s18
    lsl	w0,	w15,	#2
    ldr	x15,	[sp, #2368]

    add	x4,	x15,	x0
    ldr	s28,	[x4]

    ldr	w16,	[sp, #3632]

    fadd	s9,	s27,	s28
    ldr	x6,	[sp, fp]

    lsl	w4,	w16,	#2
    movz	fp,	#2340
    add	x3,	x6,	x4
    ldr	s1,	[x3]

    ldr	w17,	[sp, #3632]

    ldr	x0,	[sp, fp]

    lsl	w10,	w17,	#2
    movz	fp,	#2316
    add	x6,	x0,	x10
    ldr	s11,	[x6]

    ldr	w18,	[sp, #3632]

    fadd	s26,	s1,	s11
    ldr	x9,	[sp, fp]

    lsl	w15,	w18,	#2
    movz	fp,	#2988
    add	x10,	x9,	x15
    ldr	s25,	[x10]

    ldr	w21,	[sp, #3632]

    fadd	s4,	s26,	s25
    ldr	x17,	[sp, #2272]

    lsl	w16,	w21,	#2
    add	x7,	x17,	x16
    ldr	s11,	[x7]

    ldr	x6,	[sp, fp]

    fadd	s15,	s4,	s11
    movz	fp,	#2756
    str	s8,	[x6]

    ldr	x25,	[sp, fp]

    movz	fp,	#2764
    str	s19,	[x25]

    ldr	x0,	[sp, fp]

    movz	fp,	#2788
    str	s2,	[x0]

    ldr	x8,	[sp, #2776]

    str	s21,	[x8]

    ldr	x17,	[sp, fp]

    movz	fp,	#2796
    str	s17,	[x17]

    ldr	x24,	[sp, fp]

    movz	fp,	#2828
    str	s5,	[x24]

    ldr	x5,	[sp, #2808]

    str	s24,	[x5]

    ldr	x8,	[sp, #2816]

    str	s13,	[x8]

    ldr	x17,	[sp, fp]

    movz	fp,	#2836
    str	s9,	[x17]

    ldr	x24,	[sp, fp]

    str	s15,	[x24]

    ldr	s6,	[x7]

    fcmp	s6,	s10
    cset	w22,	ne
    mov	w4,	w22
    cmp	w4,	#0
    movi	v10.4s,	#0
    cset	w0,	ne
    mov	w3,	w0
    scvtf	s11,	w3
    fcmp	s11,	s10
    movi	v9.4s,	#0
    cset	w0,	ne
    mov	w1,	w0
    scvtf	s15,	w1
    fcmp	s15,	s9
    beq	main_517

main_679:
    movz	w0,	#10
    movz	fp,	#2988
    ldr	x1,	[sp, fp]

    bl	putfarray
    add	x26,	sp,	#832
    movz	fp,	#3212
    ldr	w24,	[sp, #3632]

    lsl	w0,	w24,	#2
    mov	x4,	x0
    add	x4,	sp,	x4
    add	x4,	x4,	#904
    ldr	s15,	[x4]

    ldr	x1,	[sp, fp]

    movz	fp,	#3156
    mov	x14,	x1
    mov	x20,	x14
    ldr	x2,	[sp, fp]

    movz	fp,	#3236
    mov	x5,	x2
    mov	x25,	x5
    ldr	x18,	[sp, fp]

    movz	fp,	#3196
    mov	x15,	x18
    ldr	x7,	[sp, fp]

    movz	fp,	#3188
    mov	x6,	x7
    ldr	x4,	[sp, fp]

    movz	fp,	#3836
    mov	x3,	x4
    str	x3,	[sp, fp]

    add	x3,	sp,	#828
    movz	fp,	#3164
    ldr	x13,	[sp, fp]

    movz	fp,	#3180
    mov	x19,	x13
    str	x19,	[sp, #4872]

    ldr	x4,	[sp, fp]

    movz	fp,	#4276
    str	x4,	[sp, fp]

    add	x4,	sp,	#836
    movz	fp,	#3204
    ldr	x18,	[sp, fp]

    movz	fp,	#3148
    mov	x10,	x18
    ldr	x23,	[sp, fp]

    movz	fp,	#3844
    mov	x13,	x23
    add	x23,	sp,	#844
    str	x13,	[sp, fp]

    mov	x13,	x6
    movz	fp,	#3172
    ldr	x9,	[sp, fp]

    movz	fp,	#7396
    mov	x16,	x9
    str	x16,	[sp, fp]

    movz	fp,	#3220
    ldr	x9,	[sp, fp]

    movz	fp,	#3228
    mov	x19,	x9
    str	x19,	[sp, #7024]

    add	x19,	sp,	#852
    ldr	x21,	[sp, fp]

    movz	fp,	#3252
    mov	x27,	x21
    add	x21,	sp,	#824
    str	x27,	[sp, #4880]

    ldr	x9,	[sp, fp]

    movz	fp,	#3852
    mov	x0,	x9
    str	x0,	[sp, fp]

    movz	fp,	#3244
    ldr	x18,	[sp, fp]

    movz	fp,	#2700
    mov	x17,	x18
    add	x18,	sp,	#872
    str	x17,	[sp, #4864]

    add	x17,	sp,	#840
    str	x21,	[sp, fp]

    add	x21,	sp,	#888
    movz	fp,	#5300
    str	x3,	[sp, fp]

    movz	fp,	#5276
    str	x26,	[sp, fp]

    add	x26,	sp,	#884
    movz	fp,	#5292
    str	x4,	[sp, fp]

    movz	fp,	#2292
    str	x17,	[sp, fp]

    movz	fp,	#2484
    str	x23,	[sp, fp]

    movz	fp,	#3020
    add	x23,	sp,	#848
    str	x23,	[sp, #2504]

    add	x23,	sp,	#856
    str	x19,	[sp, #2520]

    add	x19,	sp,	#860
    str	x23,	[sp, #2528]

    add	x23,	sp,	#868
    str	x19,	[sp, #2552]

    add	x19,	sp,	#864
    str	x19,	[sp, fp]

    add	x19,	sp,	#876
    movz	fp,	#2916
    str	x23,	[sp, fp]

    add	x23,	sp,	#892
    movz	fp,	#2932
    str	x18,	[sp, fp]

    add	x18,	sp,	#896
    movz	fp,	#2940
    str	x19,	[sp, fp]

    movz	fp,	#2964
    add	x19,	sp,	#880
    str	x19,	[sp, fp]

    add	x19,	sp,	#900
    movz	fp,	#2972
    str	x26,	[sp, fp]

    movz	fp,	#2980
    str	x21,	[sp, fp]

    movz	fp,	#2996
    str	x23,	[sp, fp]

    mov	x23,	x10
    movz	fp,	#3004
    str	x18,	[sp, fp]

    movz	fp,	#3012
    str	x19,	[sp, fp]

    movz	fp,	#3028
    ldr	s17,	[sp, #1332]

    str	x20,	[sp, #4824]

    fmov	s16,	s17
    ldr	w9,	[sp, #3552]

    mov	w17,	w9
    str	w17,	[sp, #2956]

    ldr	x17,	[sp, fp]

    movz	fp,	#3036
    mov	x28,	x17
    str	x28,	[sp, #7032]

    ldr	s14,	[sp, #1336]

    ldr	w26,	[sp, #3628]

    fmov	s17,	s14
    mov	w21,	w26
    str	w21,	[sp, #2960]

    ldr	s29,	[sp, #1340]

    ldr	s31,	[sp, #1344]

    fmov	s14,	s29
    ldr	x4,	[sp, fp]

    fmov	s6,	s31
    movz	fp,	#2612
    mov	x21,	x4
    str	x21,	[sp, #2648]

    str	x25,	[sp, fp]

    movz	fp,	#3044
    ldr	w19,	[sp, #3580]

    mov	w25,	w19
    str	w25,	[sp, #2900]

    ldr	w25,	[sp, #3556]

    mov	w26,	w25
    str	w26,	[sp, #2904]

    ldr	x7,	[sp, fp]

    movz	fp,	#3052
    mov	x25,	x7
    str	x25,	[sp, #2632]

    mov	x25,	x15
    str	x25,	[sp, #2592]

    str	x13,	[sp, #1024]

    ldr	w17,	[sp, #3456]

    mov	w5,	w17
    str	w5,	[sp, #2860]

    ldr	x7,	[sp, fp]

    movz	fp,	#1044
    mov	x5,	x7
    str	x5,	[sp, fp]

    movz	fp,	#3060
    ldr	x17,	[sp, fp]

    movz	fp,	#1052
    mov	x13,	x17
    str	x13,	[sp, fp]

    movz	fp,	#3068
    ldr	s31,	[sp, #1348]

    ldr	s7,	[sp, #1352]

    fmov	s27,	s31
    ldr	s28,	[sp, #1356]

    fmov	s30,	s7
    ldr	x15,	[sp, fp]

    fmov	s2,	s28
    movz	fp,	#1068
    str	x15,	[sp, fp]

    movz	fp,	#3836
    ldr	w5,	[sp, #3408]

    mov	w15,	w5
    str	w15,	[sp, #2872]

    ldr	s9,	[sp, #1360]

    ldr	s19,	[sp, #1364]

    fmov	s25,	s9
    ldr	s31,	[sp, #1368]

    fmov	s23,	s19
    ldr	x1,	[sp, fp]

    fmov	s3,	s31
    movz	fp,	#3076
    mov	x14,	x1
    str	x14,	[sp, #2560]

    ldr	x7,	[sp, fp]

    movz	fp,	#2308
    mov	x14,	x7
    str	x14,	[sp, #2576]

    ldr	x13,	[sp, #4872]

    mov	x16,	x13
    str	x16,	[sp, fp]

    movz	fp,	#4276
    ldr	x27,	[sp, fp]

    movz	fp,	#5028
    mov	x20,	x27
    str	x20,	[sp, fp]

    movz	fp,	#3084
    ldr	x1,	[sp, fp]

    movz	fp,	#5124
    mov	x6,	x1
    str	x6,	[sp, fp]

    movz	fp,	#5036
    ldr	s1,	[sp, #1372]

    ldr	s29,	[sp, #1376]

    fmov	s24,	s1
    str	x23,	[sp, fp]

    fmov	s19,	s29
    movz	fp,	#3092
    ldr	w15,	[sp, #3308]

    mov	w19,	w15
    str	w19,	[sp, #2824]

    ldr	x22,	[sp, fp]

    movz	fp,	#3100
    mov	x0,	x22
    str	x0,	[sp, #2448]

    ldr	x19,	[sp, fp]

    movz	fp,	#5100
    mov	x27,	x19
    str	x27,	[sp, fp]

    movz	fp,	#3844
    ldr	s4,	[sp, #1380]

    ldr	s28,	[sp, #1384]

    fmov	s11,	s4
    ldr	x0,	[sp, fp]

    fmov	s21,	s28
    movz	fp,	#7396
    mov	x7,	x0
    str	x7,	[sp, #2416]

    ldr	x17,	[sp, fp]

    movz	fp,	#5060
    mov	x6,	x17
    str	x6,	[sp, fp]

    movz	fp,	#3108
    ldr	w2,	[sp, #3584]

    str	w2,	[sp, #2772]

    ldr	w15,	[sp, #3560]

    mov	w1,	w15
    str	w1,	[sp, #2784]

    ldr	s29,	[sp, #1388]

    ldr	s22,	[sp, #1392]

    fmov	s1,	s29
    ldr	x20,	[sp, #7024]

    fmov	s28,	s22
    mov	x13,	x20
    str	x13,	[sp, #2424]

    ldr	w15,	[sp, #3420]

    mov	w1,	w15
    str	w1,	[sp, #2748]

    ldr	x22,	[sp, fp]

    movz	fp,	#5044
    mov	x2,	x22
    str	x2,	[sp, #2456]

    ldr	w19,	[sp, #3468]

    str	w19,	[sp, #2752]

    ldr	x16,	[sp, #4880]

    mov	x0,	x16
    str	x0,	[sp, fp]

    movz	fp,	#3852
    ldr	x1,	[sp, fp]

    movz	fp,	#3116
    mov	x0,	x1
    str	x0,	[sp, #2400]

    ldr	s26,	[sp, #1396]

    ldr	s29,	[sp, #1400]

    fmov	s31,	s26
    ldr	x8,	[sp, fp]

    movz	fp,	#5012
    mov	x20,	x8
    str	x20,	[sp, #4840]

    ldr	w2,	[sp, #3624]

    mov	w5,	w2
    str	w5,	[sp, #2728]

    ldr	x8,	[sp, #4864]

    mov	x7,	x8
    str	x7,	[sp, fp]

    movz	fp,	#3124
    ldr	x8,	[sp, fp]

    movz	fp,	#2228
    str	x8,	[sp, fp]

    movz	fp,	#3132
    ldr	s18,	[sp, #1404]

    ldr	w0,	[sp, #3628]

    fmov	s5,	s18
    mov	w8,	w0
    str	w8,	[sp, #2716]

    ldr	s13,	[sp, #1408]

    ldr	x23,	[sp, fp]

    fmov	s4,	s13
    movz	fp,	#2324
    mov	x21,	x23
    str	x21,	[sp, fp]

    movz	fp,	#3140
    ldr	x23,	[sp, fp]

    movz	fp,	#2332
    str	x23,	[sp, fp]

    ldr	s9,	[sp, #1412]

    ldr	w0,	[sp, #3596]

    mov	w12,	w0
    str	w12,	[sp, #2804]


main_717:
    ldr	w21,	[sp, #3632]

    movz	fp,	#1044
    ldr	x26,	[sp, #7032]

    lsl	w0,	w21,	#2
    add	x15,	x26,	x0
    ldr	s18,	[x15]

    fadd	s10,	s16,	s18
    fadd	s18,	s10,	s17
    fadd	s18,	s18,	s14
    str	s18,	[sp, #1780]

    ldr	w19,	[sp, #3632]

    ldr	x16,	[sp, #2648]

    lsl	w15,	w19,	#2
    add	x16,	x16,	x15
    ldr	s18,	[x16]

    ldr	w21,	[sp, #3632]

    fadd	s18,	s6,	s18
    ldr	x9,	[sp, #2632]

    lsl	w15,	w21,	#2
    add	x16,	x9,	x15
    ldr	s10,	[x16]

    ldr	w0,	[sp, #3632]

    fadd	s18,	s18,	s10
    ldr	x21,	[sp, fp]

    lsl	w18,	w0,	#2
    movz	fp,	#1052
    add	x23,	x21,	x18
    ldr	s13,	[x23]

    fadd	s18,	s18,	s13
    str	s18,	[sp, #1760]

    ldr	w15,	[sp, #3632]

    ldr	x23,	[sp, fp]

    lsl	w15,	w15,	#2
    movz	fp,	#1068
    add	x16,	x23,	x15
    ldr	s18,	[x16]

    fadd	s18,	s18,	s27
    fadd	s10,	s18,	s30
    fadd	s8,	s10,	s2
    str	s8,	[sp, #1784]

    movi	v8.4s,	#0
    ldr	w21,	[sp, #3632]

    ldr	x15,	[sp, fp]

    lsl	w18,	w21,	#2
    movz	fp,	#5124
    add	x15,	x15,	x18
    ldr	s18,	[x15]

    fadd	s10,	s18,	s25
    fadd	s18,	s10,	s23
    fadd	s22,	s18,	s3
    str	s22,	[sp, #1772]

    ldr	w25,	[sp, #3632]

    ldr	x14,	[sp, #2576]

    lsl	w15,	w25,	#2
    add	x16,	x14,	x15
    ldr	s18,	[x16]

    ldr	w9,	[sp, #3632]

    ldr	x7,	[sp, fp]

    lsl	w0,	w9,	#2
    movz	fp,	#5100
    add	x21,	x7,	x0
    ldr	s13,	[x21]

    fadd	s18,	s18,	s13
    fadd	s18,	s18,	s24
    fadd	s10,	s18,	s19
    str	s10,	[sp, #1764]

    ldr	w12,	[sp, #3632]

    ldr	x27,	[sp, #2448]

    lsl	w0,	w12,	#2
    add	x15,	x27,	x0
    ldr	s18,	[x15]

    ldr	w13,	[sp, #3632]

    ldr	x25,	[sp, fp]

    lsl	w24,	w13,	#2
    movz	fp,	#2228
    add	x16,	x25,	x24
    ldr	s13,	[x16]

    fadd	s18,	s18,	s13
    fadd	s10,	s18,	s11
    fadd	s18,	s10,	s21
    str	s18,	[sp, #1788]

    ldr	w5,	[sp, #3632]

    fadd	s18,	s1,	s28
    ldr	x3,	[sp, #2456]

    lsl	w23,	w5,	#2
    add	x15,	x3,	x23
    ldr	s13,	[x15]

    fadd	s18,	s18,	s13
    fadd	s18,	s18,	s31
    str	s18,	[sp, #1108]

    ldr	w8,	[sp, #3632]

    ldr	x19,	[sp, #4840]

    lsl	w5,	w8,	#2
    add	x16,	x19,	x5
    ldr	s18,	[x16]

    ldr	w14,	[sp, #3632]

    fadd	s10,	s29,	s18
    ldr	x8,	[sp, fp]

    lsl	w15,	w14,	#2
    movz	fp,	#2324
    add	x16,	x8,	x15
    ldr	s18,	[x16]

    fadd	s18,	s10,	s18
    fadd	s18,	s18,	s5
    str	s18,	[sp, #1144]

    ldr	w25,	[sp, #3632]

    ldr	x0,	[sp, fp]

    lsl	w15,	w25,	#2
    movz	fp,	#2332
    add	x15,	x0,	x15
    ldr	s18,	[x15]

    ldr	w0,	[sp, #3632]

    fadd	s13,	s4,	s18
    lsl	w15,	w0,	#2
    ldr	x0,	[sp, fp]

    movz	fp,	#2700
    add	x24,	x0,	x15
    ldr	s18,	[x24]

    fadd	s10,	s13,	s18
    fadd	s10,	s10,	s9
    str	s10,	[sp, #1220]

    ldr	s22,	[sp, #1780]

    ldr	x21,	[sp, fp]

    movz	fp,	#5300
    str	s22,	[x21]

    ldr	s10,	[sp, #1760]

    ldr	x22,	[sp, fp]

    movz	fp,	#5276
    str	s10,	[x22]

    ldr	s18,	[sp, #1784]

    ldr	x13,	[sp, fp]

    movz	fp,	#5292
    str	s18,	[x13]

    ldr	s10,	[sp, #1772]

    ldr	x19,	[sp, fp]

    movz	fp,	#2292
    str	s10,	[x19]

    ldr	s10,	[sp, #1764]

    ldr	x25,	[sp, fp]

    movz	fp,	#2484
    str	s10,	[x25]

    ldr	s22,	[sp, #1788]

    ldr	x15,	[sp, fp]

    movz	fp,	#2612
    str	s22,	[x15]

    ldr	s10,	[sp, #1108]

    ldr	x8,	[sp, #2504]

    str	s10,	[x8]

    ldr	s18,	[sp, #1144]

    ldr	x9,	[sp, #2520]

    str	s18,	[x9]

    ldr	s18,	[sp, #1220]

    ldr	x5,	[sp, #2528]

    str	s18,	[x5]

    ldr	x5,	[sp, #2552]

    str	s8,	[x5]

    ldr	w8,	[sp, #3632]

    ldr	x12,	[sp, #4824]

    lsl	w15,	w8,	#2
    add	x18,	x12,	x15
    ldr	w15,	[x18]

    ldr	w16,	[sp, #2956]

    ldr	w19,	[sp, #2960]

    add	w21,	w19,	w16
    add	w15,	w21,	w15
    str	w15,	[sp, #2356]

    ldr	w18,	[sp, #3632]

    ldr	x14,	[sp, fp]

    lsl	w18,	w18,	#2
    movz	fp,	#2308
    add	x21,	x14,	x18
    ldr	w5,	[x21]

    ldr	w0,	[sp, #2900]

    ldr	w21,	[sp, #2904]

    add	w24,	w21,	w0
    add	w9,	w24,	w5
    str	w9,	[sp, #2280]

    ldr	w19,	[sp, #3632]

    ldr	x8,	[sp, #2592]

    lsl	w18,	w19,	#2
    add	x23,	x8,	x18
    ldr	w7,	[x23]

    ldr	w2,	[sp, #3632]

    ldr	x5,	[sp, #1024]

    lsl	w0,	w2,	#2
    add	x0,	x5,	x0
    ldr	w24,	[x0]

    ldr	w14,	[sp, #2860]

    add	w0,	w7,	w14
    add	w13,	w0,	w24
    str	w13,	[sp, #2224]

    ldr	w0,	[sp, #3632]

    lsl	w16,	w0,	#2
    ldr	x0,	[sp, #2560]

    add	x21,	x0,	x16
    ldr	w15,	[x21]

    ldr	w0,	[sp, #2872]

    add	w24,	w15,	w0
    ldr	w15,	[sp, #3632]

    ldr	x21,	[sp, fp]

    lsl	w12,	w15,	#2
    movz	fp,	#5028
    add	x6,	x21,	x12
    ldr	w18,	[x6]

    add	w21,	w24,	w18
    str	w21,	[sp, #2220]

    ldr	w21,	[sp, #3632]

    ldr	x17,	[sp, fp]

    lsl	w18,	w21,	#2
    movz	fp,	#5036
    add	x18,	x17,	x18
    ldr	w0,	[x18]

    ldr	w12,	[sp, #3632]

    ldr	x25,	[sp, fp]

    lsl	w23,	w12,	#2
    movz	fp,	#5060
    add	x18,	x25,	x23
    ldr	w13,	[x18]

    ldr	w6,	[sp, #2824]

    add	w25,	w0,	w6
    add	w13,	w25,	w13
    str	w13,	[sp, #1932]

    ldr	w9,	[sp, #3632]

    ldr	x8,	[sp, #2416]

    lsl	w23,	w9,	#2
    add	x15,	x8,	x23
    ldr	w15,	[x15]

    ldr	w16,	[sp, #3632]

    ldr	x7,	[sp, fp]

    lsl	w0,	w16,	#2
    movz	fp,	#5044
    add	x23,	x7,	x0
    ldr	w25,	[x23]

    ldr	w0,	[sp, #2772]

    add	w16,	w15,	w0
    add	w21,	w16,	w25
    str	w21,	[sp, #2364]

    ldr	w13,	[sp, #3632]

    lsl	w23,	w13,	#2
    ldr	x13,	[sp, #2424]

    add	x23,	x13,	x23
    ldr	w16,	[x23]

    ldr	w13,	[sp, #2748]

    ldr	w24,	[sp, #2784]

    add	w18,	w13,	w24
    add	w19,	w18,	w16
    str	w19,	[sp, #2360]

    ldr	w5,	[sp, #3632]

    ldr	x27,	[sp, fp]

    lsl	w16,	w5,	#2
    movz	fp,	#5012
    add	x16,	x27,	x16
    ldr	w15,	[x16]

    ldr	w0,	[sp, #2752]

    ldr	w8,	[sp, #3632]

    add	w23,	w15,	w0
    ldr	x28,	[sp, #2400]

    lsl	w7,	w8,	#2
    add	x21,	x28,	x7
    ldr	w18,	[x21]

    add	w3,	w23,	w18
    str	w3,	[sp, #4860]

    ldr	w14,	[sp, #3632]

    ldr	x8,	[sp, fp]

    lsl	w23,	w14,	#2
    movz	fp,	#3020
    add	x24,	x8,	x23
    ldr	w24,	[x24]

    ldr	w0,	[sp, #2716]

    ldr	w9,	[sp, #2728]

    ldr	w8,	[sp, #2804]

    add	w23,	w0,	w9
    add	w6,	w23,	w8
    movz	w23,	#0
    add	w20,	w6,	w24
    str	w20,	[sp, #10584]

    ldr	w2,	[sp, #2356]

    ldr	x21,	[sp, fp]

    movz	fp,	#2916
    str	w2,	[x21]

    ldr	w15,	[sp, #2280]

    ldr	x19,	[sp, fp]

    movz	fp,	#2932
    str	w15,	[x19]

    ldr	w12,	[sp, #2224]

    ldr	x8,	[sp, fp]

    movz	fp,	#2940
    str	w12,	[x8]

    ldr	w12,	[sp, #2220]

    ldr	x8,	[sp, fp]

    movz	fp,	#2964
    str	w12,	[x8]

    ldr	w15,	[sp, #1932]

    ldr	x0,	[sp, fp]

    movz	fp,	#2972
    str	w15,	[x0]

    mov	w15,	w23
    ldr	w0,	[sp, #2364]

    ldr	x12,	[sp, fp]

    movz	fp,	#2980
    str	w0,	[x12]

    ldr	w2,	[sp, #2360]

    ldr	x8,	[sp, fp]

    movz	fp,	#2996
    str	w2,	[x8]

    ldr	x5,	[sp, fp]

    movz	fp,	#3004
    ldr	w6,	[sp, #4860]

    str	w6,	[x5]

    ldr	x0,	[sp, fp]

    movz	fp,	#3012
    ldr	w21,	[sp, #10584]

    str	w21,	[x0]

    ldr	x0,	[sp, fp]

    str	w15,	[x0]

    fcvtzs	w0,	s9
    ldr	w14,	[sp, #2804]

    ldr	w12,	[sp, #2804]

    scvtf	s18,	w14
    cmp	w12,	#0
    beq	main_716

main_889:
    movz	w0,	#10
    movz	fp,	#2700
    ldr	x1,	[sp, fp]

    bl	putfarray
    movz	fp,	#3020
    movz	w0,	#10
    ldr	x1,	[sp, fp]

    bl	putarray
    ldr	w28,	[sp, #2356]

    movz	fp,	#3020
    scvtf	s13,	w28
    str	s13,	[sp, #1104]

    ldr	s13,	[sp, #1104]

    ldr	s11,	[sp, #1780]

    ldr	x20,	[sp, fp]

    fsub	s14,	s13,	s11
    movz	fp,	#2916
    fcvtzs	w23,	s14
    str	w23,	[x20]

    ldr	w18,	[sp, #2280]

    ldr	s11,	[sp, #1760]

    scvtf	s10,	w18
    ldr	x19,	[sp, fp]

    fsub	s14,	s10,	s11
    movz	fp,	#2932
    fcvtzs	w23,	s14
    str	w23,	[x19]

    ldr	w25,	[sp, #2224]

    ldr	s14,	[sp, #1784]

    scvtf	s8,	w25
    ldr	x18,	[sp, fp]

    fsub	s13,	s8,	s14
    movz	fp,	#2940
    fcvtzs	w24,	s13
    str	w24,	[x18]

    ldr	w19,	[sp, #2220]

    ldr	s13,	[sp, #1772]

    scvtf	s11,	w19
    ldr	x21,	[sp, fp]

    fsub	s13,	s11,	s13
    movz	fp,	#2964
    fcvtzs	w26,	s13
    str	w26,	[x21]

    ldr	w18,	[sp, #1932]

    scvtf	s8,	w18
    ldr	s14,	[sp, #1764]

    ldr	x20,	[sp, fp]

    fsub	s14,	s8,	s14
    movz	fp,	#2972
    fcvtzs	w21,	s14
    str	w21,	[x20]

    ldr	w18,	[sp, #2364]

    scvtf	s10,	w18
    ldr	s14,	[sp, #1788]

    ldr	x26,	[sp, fp]

    fsub	s14,	s10,	s14
    movz	fp,	#2980
    fcvtzs	w18,	s14
    str	w18,	[x26]

    ldr	w25,	[sp, #2360]

    ldr	s11,	[sp, #1108]

    scvtf	s14,	w25
    ldr	x19,	[sp, fp]

    fsub	s14,	s14,	s11
    movz	fp,	#2996
    fcvtzs	w23,	s14
    str	w23,	[x19]

    ldr	w26,	[sp, #4860]

    ldr	s8,	[sp, #1144]

    scvtf	s14,	w26
    ldr	x18,	[sp, fp]

    fsub	s13,	s14,	s8
    movz	fp,	#3004
    fcvtzs	w19,	s13
    str	w19,	[x18]

    ldr	w27,	[sp, #10584]

    scvtf	s14,	w27
    ldr	s11,	[sp, #1220]

    fsub	s13,	s14,	s11
    ldr	x25,	[sp, fp]

    fcvtzs	w27,	s13
    movz	fp,	#3012
    str	w27,	[x25]

    ldr	x20,	[sp, fp]

    movz	w25,	#0
    str	w25,	[x20]

    ldr	w19,	[sp, #3632]

    lsl	w19,	w19,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#864
    ldr	w20,	[x18]

    ldr	s11,	[sp, #1220]

    scvtf	s13,	w20
    ldr	s0,	[sp, #1328]

    fmul	s14,	s13,	s11
    fcvtzs	w25,	s14
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
    mov	w0,	w25
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#10592
    add	sp, sp, fp
    ret


main_716:
    movz	fp,	#3020
    fmov	s9,	s18
    mov	w8,	w0
    ldr	x9,	[sp, fp]

    movz	fp,	#2700
    mov	x15,	x9
    str	x15,	[sp, #4824]

    ldr	x15,	[sp, fp]

    movz	fp,	#6940
    mov	x27,	x15
    str	x27,	[sp, #7032]

    str	w8,	[sp, #2804]

    ldr	w23,	[sp, #2956]

    ldr	w18,	[sp, #6992]

    ldr	w19,	[sp, #6992]

    mov	w23,	w18
    str	w19,	[sp, #2956]

    ldr	w16,	[sp, #2960]

    ldr	w21,	[sp, #6996]

    ldr	w22,	[sp, #6996]

    mov	w16,	w21
    str	w22,	[sp, #2960]

    ldr	x5,	[sp, #2648]

    ldr	x10,	[sp, fp]

    movz	fp,	#6940
    mov	x5,	x10
    ldr	x11,	[sp, fp]

    movz	fp,	#2612
    str	x11,	[sp, #2648]

    ldr	x16,	[sp, fp]

    movz	fp,	#6924
    ldr	x3,	[sp, fp]

    movz	fp,	#6924
    mov	x16,	x3
    ldr	x4,	[sp, fp]

    movz	fp,	#2612
    str	x4,	[sp, fp]

    movz	fp,	#6932
    ldr	w15,	[sp, #2900]

    ldr	w11,	[sp, #6984]

    ldr	w12,	[sp, #6984]

    mov	w15,	w11
    str	w12,	[sp, #2900]

    ldr	w15,	[sp, #2904]

    ldr	w14,	[sp, #6988]

    ldr	w16,	[sp, #6988]

    mov	w15,	w14
    str	w16,	[sp, #2904]

    ldr	x0,	[sp, #2632]

    ldr	x6,	[sp, fp]

    movz	fp,	#6932
    mov	x0,	x6
    ldr	x7,	[sp, fp]

    movz	fp,	#6916
    str	x7,	[sp, #2632]

    ldr	x21,	[sp, #2592]

    ldr	x0,	[sp, fp]

    movz	fp,	#6916
    mov	x21,	x0
    ldr	x1,	[sp, fp]

    movz	fp,	#6884
    str	x1,	[sp, #2592]

    ldr	x0,	[sp, #1024]

    ldr	x19,	[sp, fp]

    movz	fp,	#6884
    mov	x0,	x19
    ldr	x20,	[sp, fp]

    movz	fp,	#1044
    str	x20,	[sp, #1024]

    ldr	w16,	[sp, #2860]

    ldr	w4,	[sp, #6976]

    ldr	w5,	[sp, #6976]

    mov	w16,	w4
    str	w5,	[sp, #2860]

    ldr	x23,	[sp, fp]

    movz	fp,	#6892
    ldr	x22,	[sp, fp]

    movz	fp,	#6892
    mov	x23,	x22
    ldr	x23,	[sp, fp]

    movz	fp,	#1044
    str	x23,	[sp, fp]

    movz	fp,	#1052
    ldr	x0,	[sp, fp]

    movz	fp,	#6900
    ldr	x26,	[sp, fp]

    movz	fp,	#6900
    mov	x0,	x26
    ldr	x27,	[sp, fp]

    movz	fp,	#1052
    str	x27,	[sp, fp]

    movz	fp,	#1068
    ldr	x21,	[sp, fp]

    movz	fp,	#6908
    ldr	x0,	[sp, fp]

    movz	fp,	#6908
    mov	x21,	x0
    ldr	x0,	[sp, fp]

    movz	fp,	#1068
    str	x0,	[sp, fp]

    movz	fp,	#6868
    ldr	w12,	[sp, #2872]

    ldr	w7,	[sp, #6980]

    ldr	w8,	[sp, #6980]

    mov	w12,	w7
    str	w8,	[sp, #2872]

    ldr	x8,	[sp, #2560]

    ldr	x12,	[sp, fp]

    movz	fp,	#6868
    mov	x8,	x12
    ldr	x13,	[sp, fp]

    movz	fp,	#6876
    str	x13,	[sp, #2560]

    ldr	x16,	[sp, #2576]

    ldr	x16,	[sp, fp]

    movz	fp,	#6876
    ldr	x17,	[sp, fp]

    movz	fp,	#2308
    str	x17,	[sp, #2576]

    ldr	x0,	[sp, fp]

    movz	fp,	#6860
    ldr	x8,	[sp, fp]

    movz	fp,	#6860
    mov	x0,	x8
    ldr	x10,	[sp, fp]

    movz	fp,	#2308
    str	x10,	[sp, fp]

    movz	fp,	#5028
    ldr	x20,	[sp, fp]

    movz	fp,	#8892
    ldr	x1,	[sp, fp]

    movz	fp,	#8892
    mov	x20,	x1
    ldr	x2,	[sp, fp]

    movz	fp,	#5028
    str	x2,	[sp, fp]

    movz	fp,	#5124
    ldr	x8,	[sp, fp]

    movz	fp,	#5124
    ldr	x16,	[sp, #8480]

    ldr	x17,	[sp, #8480]

    mov	x8,	x16
    str	x17,	[sp, fp]

    movz	fp,	#5036
    ldr	x26,	[sp, fp]

    movz	fp,	#8900
    ldr	x4,	[sp, fp]

    movz	fp,	#8900
    mov	x26,	x4
    ldr	x5,	[sp, fp]

    movz	fp,	#5036
    str	x5,	[sp, fp]

    movz	fp,	#8868
    ldr	w23,	[sp, #2824]

    ldr	w1,	[sp, #6972]

    ldr	w2,	[sp, #6972]

    mov	w23,	w1
    str	w2,	[sp, #2824]

    ldr	x0,	[sp, #2448]

    ldr	x21,	[sp, fp]

    movz	fp,	#8868
    mov	x0,	x21
    ldr	x22,	[sp, fp]

    movz	fp,	#5100
    str	x22,	[sp, #2448]

    ldr	x0,	[sp, fp]

    movz	fp,	#8924
    ldr	x13,	[sp, fp]

    movz	fp,	#8924
    mov	x0,	x13
    ldr	x14,	[sp, fp]

    movz	fp,	#5100
    str	x14,	[sp, fp]

    movz	fp,	#8852
    ldr	x10,	[sp, #2416]

    ldr	x15,	[sp, fp]

    movz	fp,	#8852
    mov	x10,	x15
    ldr	x16,	[sp, fp]

    movz	fp,	#5060
    str	x16,	[sp, #2416]

    ldr	x8,	[sp, fp]

    movz	fp,	#8916
    ldr	x10,	[sp, fp]

    movz	fp,	#8916
    mov	x8,	x10
    ldr	x11,	[sp, fp]

    movz	fp,	#5060
    str	x11,	[sp, fp]

    movz	fp,	#8860
    ldr	w0,	[sp, #2772]

    ldr	w27,	[sp, #6964]

    ldr	w28,	[sp, #6964]

    mov	w0,	w27
    str	w28,	[sp, #2772]

    ldr	w23,	[sp, #2784]

    ldr	w0,	[sp, #6968]

    mov	w23,	w0
    ldr	w0,	[sp, #6968]

    str	w0,	[sp, #2784]

    ldr	x16,	[sp, #2424]

    ldr	x18,	[sp, fp]

    movz	fp,	#8860
    mov	x16,	x18
    ldr	x19,	[sp, fp]

    movz	fp,	#8876
    str	x19,	[sp, #2424]

    ldr	w0,	[sp, #2748]

    ldr	w20,	[sp, #6956]

    ldr	w21,	[sp, #6956]

    mov	w0,	w20
    str	w21,	[sp, #2748]

    ldr	x4,	[sp, #2456]

    ldr	x24,	[sp, fp]

    movz	fp,	#8876
    mov	x4,	x24
    ldr	x25,	[sp, fp]

    movz	fp,	#5044
    str	x25,	[sp, #2456]

    ldr	w8,	[sp, #2752]

    ldr	w23,	[sp, #6960]

    ldr	w24,	[sp, #6960]

    mov	w8,	w23
    str	w24,	[sp, #2752]

    ldr	x0,	[sp, fp]

    movz	fp,	#8908
    ldr	x7,	[sp, fp]

    movz	fp,	#8908
    mov	x0,	x7
    ldr	x8,	[sp, fp]

    movz	fp,	#5044
    str	x8,	[sp, fp]

    movz	fp,	#5012
    ldr	x0,	[sp, #2400]

    ldr	x12,	[sp, #8464]

    ldr	x13,	[sp, #8464]

    mov	x0,	x12
    str	x13,	[sp, #2400]

    ldr	x22,	[sp, #4840]

    ldr	x9,	[sp, #8456]

    ldr	x10,	[sp, #8456]

    mov	x22,	x9
    str	x10,	[sp, #4840]

    ldr	w12,	[sp, #2728]

    ldr	w17,	[sp, #6952]

    ldr	w18,	[sp, #6952]

    mov	w12,	w17
    str	w18,	[sp, #2728]

    ldr	x10,	[sp, fp]

    movz	fp,	#8884
    ldr	x27,	[sp, fp]

    movz	fp,	#8884
    mov	x10,	x27
    ldr	x28,	[sp, fp]

    movz	fp,	#5012
    str	x28,	[sp, fp]

    movz	fp,	#2228
    ldr	x16,	[sp, fp]

    movz	fp,	#6836
    ldr	x0,	[sp, fp]

    movz	fp,	#6836
    mov	x16,	x0
    ldr	x0,	[sp, fp]

    movz	fp,	#2228
    str	x0,	[sp, fp]

    movz	fp,	#2324
    ldr	w21,	[sp, #2716]

    ldr	w13,	[sp, #6948]

    ldr	w14,	[sp, #6948]

    mov	w21,	w13
    str	w14,	[sp, #2716]

    ldr	x0,	[sp, fp]

    movz	fp,	#6844
    ldr	x2,	[sp, fp]

    movz	fp,	#6844
    mov	x0,	x2
    ldr	x3,	[sp, fp]

    movz	fp,	#2324
    str	x3,	[sp, fp]

    movz	fp,	#2332
    ldr	x15,	[sp, fp]

    movz	fp,	#6852
    ldr	x5,	[sp, fp]

    movz	fp,	#6852
    mov	x15,	x5
    ldr	x6,	[sp, fp]

    movz	fp,	#2332
    str	x6,	[sp, fp]

    b	main_717

main_517:
    movz	fp,	#2948
    ldr	x16,	[sp, fp]

    movz	fp,	#2924
    mov	x2,	x16
    str	x2,	[sp, #5664]

    ldr	x13,	[sp, fp]

    movz	fp,	#2948
    mov	x4,	x13
    str	x4,	[sp, fp]

    movz	fp,	#2908
    ldr	x4,	[sp, fp]

    movz	fp,	#2924
    mov	x18,	x4
    str	x18,	[sp, fp]

    movz	fp,	#2852
    ldr	x5,	[sp, fp]

    movz	fp,	#2908
    str	x5,	[sp, fp]

    movz	fp,	#2852
    ldr	x19,	[sp, #2864]

    mov	x6,	x19
    str	x6,	[sp, fp]

    movz	fp,	#2876
    ldr	x2,	[sp, fp]

    movz	fp,	#2884
    mov	x22,	x2
    str	x22,	[sp, #2864]

    ldr	x7,	[sp, fp]

    movz	fp,	#2876
    mov	x3,	x7
    str	x3,	[sp, fp]

    movz	fp,	#2892
    ldr	x12,	[sp, fp]

    movz	fp,	#2884
    mov	x8,	x12
    str	x8,	[sp, fp]

    movz	fp,	#2844
    ldr	x0,	[sp, fp]

    movz	fp,	#2892
    mov	x13,	x0
    str	x13,	[sp, fp]

    movz	fp,	#2740
    ldr	x6,	[sp, fp]

    movz	fp,	#2844
    mov	x1,	x6
    str	x1,	[sp, fp]

    movz	fp,	#2740
    ldr	x18,	[sp, #2720]

    mov	x7,	x18
    str	x7,	[sp, fp]

    movz	fp,	#2732
    ldr	x1,	[sp, fp]

    movz	fp,	#2708
    mov	x19,	x1
    str	x19,	[sp, #2720]

    ldr	x4,	[sp, fp]

    movz	fp,	#2732
    mov	x2,	x4
    str	x2,	[sp, fp]

    movz	fp,	#2692
    ldr	x24,	[sp, fp]

    movz	fp,	#2708
    mov	x5,	x24
    str	x5,	[sp, fp]

    movz	fp,	#2668
    ldr	x2,	[sp, fp]

    movz	fp,	#2692
    mov	x25,	x2
    str	x25,	[sp, fp]

    movz	fp,	#2676
    ldr	x7,	[sp, fp]

    movz	fp,	#2668
    mov	x3,	x7
    str	x3,	[sp, fp]

    movz	fp,	#2684
    ldr	x12,	[sp, fp]

    movz	fp,	#2676
    mov	x8,	x12
    str	x8,	[sp, fp]

    movz	fp,	#2684
    ldr	x24,	[sp, #2656]

    mov	x13,	x24
    str	x13,	[sp, fp]

    movz	fp,	#2604
    ldr	x5,	[sp, fp]

    movz	fp,	#2604
    mov	x25,	x5
    str	x25,	[sp, #2656]

    ldr	x1,	[sp, #2624]

    mov	x6,	x1
    str	x6,	[sp, fp]

    movz	fp,	#1060
    ldr	x7,	[sp, #2640]

    mov	x1,	x7
    str	x1,	[sp, #2624]

    ldr	x19,	[sp, #2584]

    mov	x8,	x19
    str	x8,	[sp, #2640]

    ldr	x0,	[sp, fp]

    movz	fp,	#1036
    mov	x22,	x0
    str	x22,	[sp, #2584]

    ldr	x8,	[sp, fp]

    movz	fp,	#1060
    mov	x1,	x8
    str	x1,	[sp, fp]

    movz	fp,	#1036
    ldr	x6,	[sp, #2568]

    mov	x9,	x6
    str	x9,	[sp, fp]

    movz	fp,	#2476
    ldr	x22,	[sp, #1016]

    mov	x7,	x22
    str	x7,	[sp, #2568]

    ldr	x22,	[sp, #2544]

    mov	x24,	x22
    str	x24,	[sp, #1016]

    ldr	x1,	[sp, fp]

    movz	fp,	#2476
    mov	x24,	x1
    str	x24,	[sp, #2544]

    ldr	x12,	[sp, #2496]

    mov	x2,	x12
    str	x2,	[sp, fp]

    movz	fp,	#2300
    ldr	x1,	[sp, #2512]

    mov	x13,	x1
    str	x13,	[sp, #2496]

    ldr	x9,	[sp, fp]

    movz	fp,	#2300
    mov	x1,	x9
    str	x1,	[sp, #2512]

    ldr	x18,	[sp, #2376]

    mov	x10,	x18
    str	x10,	[sp, fp]

    movz	fp,	#2284
    ldr	x0,	[sp, #2384]

    mov	x19,	x0
    str	x19,	[sp, #2376]

    ldr	x1,	[sp, fp]

    movz	fp,	#2284
    str	x1,	[sp, #2384]

    ldr	x9,	[sp, #2368]

    mov	x2,	x9
    str	x2,	[sp, fp]

    movz	fp,	#2348
    ldr	x0,	[sp, fp]

    movz	fp,	#2340
    mov	x10,	x0
    str	x10,	[sp, #2368]

    ldr	x25,	[sp, fp]

    movz	fp,	#2348
    mov	x1,	x25
    str	x1,	[sp, fp]

    movz	fp,	#2316
    ldr	x3,	[sp, fp]

    movz	fp,	#2340
    mov	x0,	x3
    str	x0,	[sp, fp]

    movz	fp,	#2316
    ldr	x24,	[sp, #2272]

    mov	x4,	x24
    str	x4,	[sp, fp]

    movz	fp,	#2988
    ldr	x8,	[sp, fp]

    mov	x25,	x8
    str	x25,	[sp, #2272]

    b	main_518

main_308:
    ldr	w11,	[sp, #5672]

    mov	w13,	w11
    str	w13,	[sp, #2620]

    ldr	w4,	[sp, #8940]

    ldr	w17,	[sp, #10280]

    ldr	w18,	[sp, #10280]

    mov	w4,	w17
    str	w18,	[sp, #8940]

    ldr	w11,	[sp, #5660]

    ldr	w27,	[sp, #9392]

    ldr	w28,	[sp, #9392]

    mov	w11,	w27
    str	w28,	[sp, #5660]

    ldr	s31,	[sp, #1832]

    str	s14,	[sp, #1832]

    fmov	s31,	s14
    ldr	w13,	[sp, #5672]

    ldr	w1,	[sp, #9396]

    ldr	w2,	[sp, #9396]

    mov	w13,	w1
    str	w2,	[sp, #5672]

    ldr	w9,	[sp, #8944]

    ldr	w22,	[sp, #10284]

    ldr	w23,	[sp, #10284]

    mov	w9,	w22
    str	w23,	[sp, #8944]

    ldr	w14,	[sp, #8948]

    ldr	w25,	[sp, #10288]

    ldr	w26,	[sp, #10288]

    mov	w14,	w25
    str	w26,	[sp, #8948]

    ldr	s20,	[sp, #1692]

    str	s14,	[sp, #1692]

    fmov	s20,	s14
    ldr	w18,	[sp, #1076]

    ldr	w9,	[sp, #6832]

    ldr	w11,	[sp, #6832]

    mov	w18,	w9
    str	w11,	[sp, #1076]

    ldr	s12,	[sp, #1828]

    str	s15,	[sp, #1828]

    fmov	s12,	s15
    ldr	s20,	[sp, #1716]

    str	s15,	[sp, #1716]

    fmov	s20,	s15
    ldr	w28,	[sp, #7892]

    ldr	w28,	[sp, #10292]

    ldr	w0,	[sp, #10292]

    str	w0,	[sp, #7892]

    ldr	s20,	[sp, #1732]

    str	s15,	[sp, #1732]

    fmov	s20,	s15
    ldr	w9,	[sp, #1032]

    ldr	w4,	[sp, #6828]

    ldr	w5,	[sp, #6828]

    mov	w9,	w4
    str	w5,	[sp, #1032]

    ldr	s20,	[sp, #1720]

    str	s8,	[sp, #1720]

    fmov	s20,	s8
    ldr	s20,	[sp, #1680]

    str	s15,	[sp, #1680]

    fmov	s20,	s15
    ldr	s20,	[sp, #1676]

    str	s14,	[sp, #1676]

    fmov	s20,	s14
    ldr	s20,	[sp, #1728]

    str	s14,	[sp, #1728]

    fmov	s20,	s14
    ldr	w20,	[sp, #8952]

    ldr	w2,	[sp, #10296]

    ldr	w3,	[sp, #10296]

    mov	w20,	w2
    str	w3,	[sp, #8952]

    ldr	s17,	[sp, #1724]

    str	s15,	[sp, #1724]

    fmov	s17,	s15
    ldr	w6,	[sp, #5680]

    ldr	w13,	[sp, #7012]

    ldr	w14,	[sp, #7012]

    mov	w6,	w13
    str	w14,	[sp, #5680]

    ldr	w1,	[sp, #5692]

    ldr	w24,	[sp, #9388]

    ldr	w25,	[sp, #9388]

    mov	w1,	w24
    str	w25,	[sp, #5692]

    ldr	s20,	[sp, #1704]

    str	s8,	[sp, #1704]

    fmov	s20,	s8
    ldr	s17,	[sp, #1112]

    str	s15,	[sp, #1112]

    fmov	s17,	s15
    ldr	s20,	[sp, #1708]

    str	s15,	[sp, #1708]

    fmov	s20,	s15
    ldr	s17,	[sp, #1712]

    str	s14,	[sp, #1712]

    fmov	s17,	s14
    ldr	w1,	[sp, #5648]

    ldr	w7,	[sp, #7004]

    ldr	w8,	[sp, #7004]

    mov	w1,	w7
    str	w8,	[sp, #5648]

    ldr	s28,	[sp, #1164]

    str	s8,	[sp, #1164]

    fmov	s28,	s8
    ldr	w0,	[sp, #2472]

    ldr	w5,	[sp, #6820]

    ldr	w6,	[sp, #6820]

    mov	w0,	w5
    str	w6,	[sp, #2472]

    ldr	s17,	[sp, #1696]

    str	s15,	[sp, #1696]

    fmov	s17,	s15
    ldr	s20,	[sp, #1688]

    str	s11,	[sp, #1688]

    fmov	s20,	s11
    ldr	s28,	[sp, #1140]

    str	s14,	[sp, #1140]

    fmov	s28,	s14
    ldr	w9,	[sp, #2540]

    ldr	w11,	[sp, #6824]

    ldr	w0,	[sp, #6824]

    mov	w9,	w11
    str	w0,	[sp, #2540]

    ldr	w9,	[sp, #5652]

    ldr	w16,	[sp, #9380]

    ldr	w17,	[sp, #9380]

    mov	w9,	w16
    str	w17,	[sp, #5652]

    ldr	s17,	[sp, #1684]

    str	s8,	[sp, #1684]

    fmov	s17,	s8
    ldr	w0,	[sp, #5676]

    ldr	w10,	[sp, #7008]

    ldr	w11,	[sp, #7008]

    mov	w0,	w10
    str	w11,	[sp, #5676]

    ldr	s28,	[sp, #1152]

    str	s14,	[sp, #1152]

    fmov	s28,	s14
    ldr	w25,	[sp, #8956]

    ldr	w5,	[sp, #10300]

    ldr	w6,	[sp, #10300]

    mov	w25,	w5
    str	w6,	[sp, #8956]

    ldr	w4,	[sp, #5684]

    ldr	w20,	[sp, #9384]

    ldr	w22,	[sp, #9384]

    mov	w4,	w20
    str	w22,	[sp, #5684]

    ldr	s17,	[sp, #1124]

    str	s15,	[sp, #1124]

    fmov	s17,	s15
    ldr	s31,	[sp, #1844]

    str	s15,	[sp, #1844]

    fmov	s31,	s15
    ldr	s28,	[sp, #1096]

    str	s14,	[sp, #1096]

    fmov	s28,	s14
    ldr	w10,	[sp, #9376]

    ldr	w28,	[sp, #9844]

    ldr	w0,	[sp, #9844]

    mov	w10,	w28
    str	w0,	[sp, #9376]

    ldr	w8,	[sp, #5700]

    ldr	w1,	[sp, #10304]

    ldr	w2,	[sp, #10304]

    mov	w8,	w1
    str	w2,	[sp, #5700]

    ldr	w11,	[sp, #5696]

    ldr	w4,	[sp, #7000]

    ldr	w5,	[sp, #7000]

    mov	w11,	w4
    str	w5,	[sp, #5696]

    ldr	s12,	[sp, #1840]

    str	s8,	[sp, #1840]

    fmov	s12,	s8
    ldr	s31,	[sp, #1836]

    str	s15,	[sp, #1836]

    fmov	s31,	s15
    ldr	s12,	[sp, #1196]

    str	s14,	[sp, #1196]

    fmov	s12,	s14
    ldr	w6,	[sp, #7040]

    ldr	w27,	[sp, #9456]

    ldr	w28,	[sp, #9456]

    mov	w6,	w27
    str	w28,	[sp, #7040]

    ldr	s28,	[sp, #1148]

    str	s8,	[sp, #1148]

    fmov	s28,	s8
    ldr	w15,	[sp, #3860]

    ldr	w25,	[sp, #10588]

    ldr	w26,	[sp, #10588]

    mov	w15,	w25
    str	w26,	[sp, #3860]

    ldr	s12,	[sp, #1188]

    str	s8,	[sp, #1188]

    fmov	s12,	s8
    b	main_309

main_305:
    ldr	s1,	[sp, #1116]

    fmov	s27,	s13
    fmov	s6,	s16
    fmov	s25,	s21
    fmov	s2,	s24
    ldr	s4,	[sp, #1824]

    fadd	s5,	s1,	s13
    fmov	s16,	s26
    fmov	s21,	s30
    str	s27,	[sp, #1116]

    fadd	s4,	s5,	s4
    fmov	s26,	s22
    ldr	s23,	[sp, #1824]

    ldr	s12,	[sp, #1820]

    fmov	s13,	s23
    str	s12,	[sp, #1824]

    ldr	s5,	[sp, #1132]

    str	s5,	[sp, #1820]

    fmov	s5,	s4
    ldr	s9,	[sp, #1128]

    str	s9,	[sp, #1132]

    str	s6,	[sp, #1128]

    ldr	s9,	[sp, #1120]

    str	s25,	[sp, #1120]

    fmov	s22,	s9
    ldr	s28,	[sp, #1444]

    str	s2,	[sp, #1444]

    fmov	s30,	s28
    ldr	s7,	[sp, #1448]

    ldr	s17,	[sp, #1172]

    fmov	s24,	s7
    str	s17,	[sp, #1448]

    ldr	s12,	[sp, #1180]

    fmov	s28,	s12
    str	s28,	[sp, #1172]

    ldr	s12,	[sp, #1176]

    fmov	s17,	s12
    str	s17,	[sp, #1180]

    ldr	s29,	[sp, #1452]

    fmov	s27,	s29
    str	s27,	[sp, #1176]

    ldr	s2,	[sp, #1456]

    fmov	s7,	s2
    fmov	s2,	s31
    str	s7,	[sp, #1452]

    ldr	s17,	[sp, #1468]

    fmov	s3,	s17
    str	s3,	[sp, #1456]

    ldr	s28,	[sp, #1460]

    fmov	s27,	s28
    str	s27,	[sp, #1468]

    ldr	s17,	[sp, #1472]

    fmov	s3,	s17
    str	s3,	[sp, #1460]

    ldr	s12,	[sp, #1476]

    fmov	s28,	s12
    str	s28,	[sp, #1472]

    ldr	s29,	[sp, #1484]

    fmov	s27,	s29
    str	s27,	[sp, #1476]

    ldr	s3,	[sp, #1480]

    fmov	s27,	s3
    str	s27,	[sp, #1484]

    str	s2,	[sp, #1480]

    ldr	s27,	[sp, #1500]

    fmov	s31,	s27
    ldr	s27,	[sp, #1504]

    fmov	s3,	s27
    str	s3,	[sp, #1500]

    ldr	s17,	[sp, #1856]

    fmov	s28,	s17
    str	s28,	[sp, #1504]

    ldr	s27,	[sp, #1860]

    str	s27,	[sp, #1856]

    ldr	s28,	[sp, #1092]

    fmov	s7,	s28
    str	s7,	[sp, #1860]

    ldr	s28,	[sp, #1156]

    fmov	s12,	s28
    str	s12,	[sp, #1092]

    ldr	s27,	[sp, #1136]

    fmov	s17,	s27
    str	s17,	[sp, #1156]

    ldr	s12,	[sp, #1184]

    fmov	s28,	s12
    str	s28,	[sp, #1136]

    ldr	s17,	[sp, #1192]

    fmov	s12,	s17
    str	s12,	[sp, #1184]

    ldr	s28,	[sp, #1204]

    fmov	s17,	s28
    str	s17,	[sp, #1192]

    ldr	s20,	[sp, #1212]

    str	s20,	[sp, #1204]

    ldr	s1,	[sp, #1216]

    str	s1,	[sp, #1212]

    ldr	s3,	[sp, #1232]

    str	s3,	[sp, #1216]

    str	s5,	[sp, #1232]

    b	main_148

