.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#12384
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w5,	#0
    str	w0,	[sp, #3260]

    mov	w25,	w5

main_10:
    cmp	w25,	#40
    bge	main_18

main_13:
    lsl	w0,	w25,	#2
    add	w28,	w0,	w25,	lsl #3
    mov	x0,	x28
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getfarray
    add	w26,	w25,	#1
    mov	w25,	w26
    b	main_10

main_18:
    movz	w6,	#0
    mov	w20,	w6

main_19:
    cmp	w20,	#24
    bge	main_27

main_22:
    lsl	w18,	w20,	#2
    add	w21,	w18,	w20,	lsl #3
    mov	x0,	x21
    add	x0,	sp,	x0
    add	x0,	x0,	#496
    bl	getarray
    add	w3,	w20,	#1
    mov	w20,	w3
    b	main_19

main_27:
    add	x7,	sp,	#16
    add	x3,	sp,	#28
    add	x20,	sp,	#52
    add	x17,	sp,	#136
    add	x5,	sp,	#148
    add	x14,	sp,	#196
    str	x7,	[sp, #3168]

    ldr	w23,	[sp, #3260]

    ldr	x12,	[sp, #3168]

    lsl	w8,	w23,	#2
    add	x23,	sp,	#256
    add	x7,	x12,	x8
    add	x8,	sp,	#88
    add	x12,	sp,	#76
    ldr	s4,	[x7]

    str	s4,	[sp, #1304]

    str	x3,	[sp, #3160]

    ldr	w24,	[sp, #3260]

    ldr	x6,	[sp, #3160]

    lsl	w13,	w24,	#2
    add	x24,	sp,	#40
    add	x11,	x6,	x13
    ldr	s1,	[x11]

    str	s1,	[sp, #1244]

    str	x24,	[sp, #3144]

    ldr	w25,	[sp, #3260]

    ldr	x0,	[sp, #3144]

    lsl	w16,	w25,	#2
    add	x15,	x0,	x16
    add	x16,	sp,	#64
    ldr	s6,	[x15]

    str	s6,	[sp, #1308]

    str	x20,	[sp, #3136]

    ldr	w26,	[sp, #3260]

    ldr	x24,	[sp, #3136]

    lsl	w20,	w26,	#2
    add	x19,	x24,	x20
    ldr	s13,	[x19]

    str	s13,	[sp, #1312]

    str	x16,	[sp, #3128]

    ldr	w28,	[sp, #3260]

    ldr	x18,	[sp, #3128]

    lsl	w26,	w28,	#2
    add	x24,	x18,	x26
    add	x18,	sp,	#184
    add	x26,	sp,	#160
    ldr	s16,	[x24]

    str	s16,	[sp, #1316]

    str	x12,	[sp, #3120]

    ldr	w0,	[sp, #3260]

    ldr	x13,	[sp, #3120]

    lsl	w25,	w0,	#2
    add	x0,	x13,	x25
    add	x25,	sp,	#124
    ldr	s5,	[x0]

    str	s5,	[sp, #1276]

    str	x8,	[sp, #3112]

    ldr	w0,	[sp, #3260]

    ldr	x10,	[sp, #3112]

    lsl	w0,	w0,	#2
    add	x4,	x10,	x0
    add	x0,	sp,	#112
    ldr	s6,	[x4]

    add	x4,	sp,	#100
    str	s6,	[sp, #1252]

    str	x4,	[sp, #3104]

    ldr	w1,	[sp, #3260]

    ldr	x6,	[sp, #3104]

    lsl	w4,	w1,	#2
    add	x8,	x6,	x4
    ldr	s12,	[x8]

    str	s12,	[sp, #1228]

    str	x0,	[sp, #3096]

    ldr	w2,	[sp, #3260]

    ldr	x1,	[sp, #3096]

    lsl	w10,	w2,	#2
    add	x2,	sp,	#232
    add	x12,	x1,	x10
    ldr	s6,	[x12]

    str	s6,	[sp, #1224]

    str	x25,	[sp, #3088]

    ldr	w3,	[sp, #3260]

    ldr	x28,	[sp, #3088]

    lsl	w12,	w3,	#2
    add	x16,	x28,	x12
    add	x28,	sp,	#244
    ldr	s24,	[x16]

    str	s24,	[sp, #1320]

    str	x17,	[sp, #3072]

    ldr	w4,	[sp, #3260]

    ldr	x19,	[sp, #3072]

    lsl	w16,	w4,	#2
    add	x20,	x19,	x16
    add	x19,	sp,	#268
    ldr	s1,	[x20]

    str	s1,	[sp, #1324]

    str	x5,	[sp, #3048]

    ldr	w5,	[sp, #3260]

    ldr	x6,	[sp, #3048]

    lsl	w22,	w5,	#2
    add	x25,	x6,	x22
    add	x22,	sp,	#172
    ldr	s6,	[x25]

    str	s6,	[sp, #1328]

    str	x26,	[sp, #3032]

    ldr	w6,	[sp, #3260]

    ldr	x0,	[sp, #3032]

    lsl	w26,	w6,	#2
    add	x1,	x0,	x26
    add	x0,	sp,	#376
    ldr	s26,	[x1]

    str	s26,	[sp, #1240]

    str	x22,	[sp, #3024]

    ldr	w7,	[sp, #3260]

    ldr	x24,	[sp, #3024]

    lsl	w6,	w7,	#2
    add	x5,	x24,	x6
    add	x24,	sp,	#328
    ldr	s8,	[x5]

    str	s8,	[sp, #1332]

    str	x18,	[sp, #3016]

    ldr	w8,	[sp, #3260]

    ldr	x20,	[sp, #3016]

    lsl	w6,	w8,	#2
    add	x9,	x20,	x6
    add	x6,	sp,	#220
    ldr	s16,	[x9]

    str	s16,	[sp, #1336]

    str	x14,	[sp, #3008]

    ldr	w9,	[sp, #3260]

    ldr	x16,	[sp, #3008]

    lsl	w10,	w9,	#2
    add	x9,	sp,	#436
    add	x13,	x16,	x10
    add	x10,	sp,	#208
    ldr	s20,	[x13]

    str	s20,	[sp, #1340]

    str	x10,	[sp, #3000]

    ldr	w10,	[sp, #3260]

    ldr	x11,	[sp, #3000]

    lsl	w16,	w10,	#2
    add	x17,	x11,	x16
    ldr	s1,	[x17]

    str	s1,	[sp, #1272]

    str	x6,	[sp, #2992]

    ldr	w11,	[sp, #3260]

    ldr	x7,	[sp, #2992]

    lsl	w20,	w11,	#2
    add	x11,	sp,	#292
    add	x21,	x7,	x20
    add	x7,	sp,	#304
    ldr	s26,	[x21]

    str	s26,	[sp, #1296]

    str	x2,	[sp, #2984]

    ldr	w12,	[sp, #3260]

    ldr	x3,	[sp, #2984]

    lsl	w25,	w12,	#2
    add	x26,	x3,	x25
    add	x3,	sp,	#316
    ldr	s28,	[x26]

    str	s28,	[sp, #1344]

    str	x28,	[sp, #2976]

    ldr	w13,	[sp, #3260]

    ldr	x1,	[sp, #2976]

    lsl	w4,	w13,	#2
    add	x13,	sp,	#424
    add	x2,	x1,	x4
    ldr	s3,	[x2]

    str	s3,	[sp, #1348]

    str	x23,	[sp, #2968]

    ldr	w14,	[sp, #3260]

    ldr	x25,	[sp, #2968]

    lsl	w4,	w14,	#2
    add	x6,	x25,	x4
    add	x25,	sp,	#388
    ldr	s12,	[x6]

    str	s12,	[sp, #1256]

    str	x19,	[sp, #2960]

    ldr	w15,	[sp, #3260]

    ldr	x21,	[sp, #2960]

    lsl	w8,	w15,	#2
    add	x15,	sp,	#280
    add	x10,	x21,	x8
    ldr	s26,	[x10]

    str	s26,	[sp, #1268]

    str	x15,	[sp, #2952]

    ldr	w16,	[sp, #3260]

    ldr	x17,	[sp, #2952]

    lsl	w12,	w16,	#2
    add	x16,	sp,	#340
    add	x14,	x17,	x12
    ldr	s8,	[x14]

    str	s8,	[sp, #1352]

    str	x11,	[sp, #2944]

    ldr	w17,	[sp, #3260]

    ldr	x12,	[sp, #2944]

    lsl	w18,	w17,	#2
    add	x17,	sp,	#412
    add	x18,	x12,	x18
    add	x12,	sp,	#352
    ldr	s12,	[x18]

    str	s12,	[sp, #1356]

    str	x7,	[sp, #2936]

    ldr	w18,	[sp, #3260]

    ldr	x8,	[sp, #2936]

    lsl	w22,	w18,	#2
    add	x22,	x8,	x22
    ldr	s15,	[x22]

    str	s15,	[sp, #1360]

    str	x3,	[sp, #2928]

    ldr	w19,	[sp, #3260]

    ldr	x4,	[sp, #2928]

    lsl	w28,	w19,	#2
    add	x28,	x4,	x28
    add	x4,	sp,	#364
    ldr	s23,	[x28]

    str	s23,	[sp, #1364]

    str	x24,	[sp, #2912]

    ldr	w20,	[sp, #3260]

    ldr	x26,	[sp, #2912]

    lsl	w2,	w20,	#2
    add	x3,	x26,	x2
    ldr	s13,	[x3]

    str	s13,	[sp, #1288]

    str	x16,	[sp, #2896]

    ldr	w21,	[sp, #3260]

    ldr	x18,	[sp, #2896]

    lsl	w6,	w21,	#2
    add	x21,	sp,	#400
    add	x7,	x18,	x6
    ldr	s31,	[x7]

    str	s31,	[sp, #1372]

    str	x12,	[sp, #2888]

    ldr	w22,	[sp, #3260]

    ldr	x14,	[sp, #2888]

    lsl	w10,	w22,	#2
    add	x11,	x14,	x10
    ldr	s5,	[x11]

    str	s5,	[sp, #1376]

    str	x4,	[sp, #2872]

    ldr	w23,	[sp, #3260]

    ldr	x5,	[sp, #2872]

    lsl	w16,	w23,	#2
    add	x15,	x5,	x16
    add	x5,	sp,	#448
    ldr	s12,	[x15]

    str	s12,	[sp, #1284]

    str	x0,	[sp, #2864]

    ldr	w24,	[sp, #3260]

    ldr	x1,	[sp, #2864]

    lsl	w20,	w24,	#2
    add	x19,	x1,	x20
    ldr	s20,	[x19]

    str	s20,	[sp, #1236]

    str	x25,	[sp, #2856]

    ldr	w25,	[sp, #3260]

    ldr	x28,	[sp, #2856]

    lsl	w22,	w25,	#2
    add	x24,	x28,	x22
    ldr	s7,	[x24]

    str	s7,	[sp, #1380]

    str	x21,	[sp, #2848]

    ldr	w26,	[sp, #3260]

    ldr	x23,	[sp, #2848]

    lsl	w0,	w26,	#2
    add	x26,	sp,	#472
    add	x0,	x23,	x0
    ldr	s15,	[x0]

    str	s15,	[sp, #1388]

    str	x17,	[sp, #2840]

    ldr	w28,	[sp, #3260]

    ldr	x19,	[sp, #2840]

    lsl	w4,	w28,	#2
    add	x4,	x19,	x4
    ldr	s13,	[x4]

    str	s13,	[sp, #1260]

    str	x13,	[sp, #2832]

    ldr	w0,	[sp, #3260]

    ldr	x15,	[sp, #2832]

    lsl	w8,	w0,	#2
    add	x8,	x15,	x8
    ldr	s6,	[x8]

    str	s6,	[sp, #1280]

    str	x9,	[sp, #2824]

    ldr	w0,	[sp, #3260]

    ldr	x10,	[sp, #2824]

    lsl	w14,	w0,	#2
    add	x12,	x10,	x14
    ldr	s18,	[x12]

    str	s18,	[sp, #1392]

    str	x5,	[sp, #2816]

    ldr	w1,	[sp, #3260]

    ldr	x6,	[sp, #2816]

    lsl	w18,	w1,	#2
    add	x1,	sp,	#460
    add	x16,	x6,	x18
    add	x18,	sp,	#484
    ldr	s20,	[x16]

    str	s20,	[sp, #1292]

    str	x1,	[sp, #2808]

    ldr	w2,	[sp, #3260]

    lsl	w22,	w2,	#2
    ldr	x2,	[sp, #2808]

    add	x20,	x2,	x22
    ldr	s13,	[x20]

    str	s13,	[sp, #1232]

    str	x26,	[sp, #2800]

    ldr	w3,	[sp, #3260]

    ldr	x0,	[sp, #2800]

    lsl	w26,	w3,	#2
    add	x25,	x0,	x26
    ldr	s5,	[x25]

    str	s5,	[sp, #1248]

    str	x18,	[sp, #2784]

    ldr	w4,	[sp, #3260]

    ldr	x20,	[sp, #2784]

    lsl	w2,	w4,	#2
    add	x1,	x20,	x2
    ldr	s20,	[x1]

    str	s20,	[sp, #1264]

    ldr	s13,	[sp, #1304]

    str	s13,	[sp, #1080]

    ldr	s2,	[sp, #1244]

    ldr	s12,	[sp, #1308]

    fmov	s16,	s2
    ldr	s13,	[sp, #1312]

    fmov	s8,	s12
    ldr	s2,	[sp, #1316]

    fmov	s4,	s13
    ldr	s7,	[sp, #1276]

    fmov	s24,	s2
    ldr	s21,	[sp, #1252]

    fmov	s22,	s7
    ldr	s2,	[sp, #1228]

    fmov	s5,	s21
    ldr	s23,	[sp, #1224]

    fmov	s30,	s2
    fmov	s27,	s23
    ldr	s23,	[sp, #1320]

    ldr	s6,	[sp, #1324]

    fmov	s3,	s23
    str	s6,	[sp, #1752]

    ldr	s2,	[sp, #1328]

    str	s2,	[sp, #1756]

    ldr	s26,	[sp, #1240]

    str	s26,	[sp, #1764]

    ldr	s28,	[sp, #1332]

    str	s28,	[sp, #1760]

    ldr	s12,	[sp, #1336]

    str	s12,	[sp, #1768]

    ldr	s6,	[sp, #1340]

    str	s6,	[sp, #1772]

    ldr	s25,	[sp, #1272]

    fmov	s28,	s25
    str	s28,	[sp, #1780]

    ldr	s25,	[sp, #1296]

    fmov	s31,	s25
    str	s31,	[sp, #1776]

    ldr	s31,	[sp, #1344]

    str	s31,	[sp, #1788]

    ldr	s12,	[sp, #1348]

    str	s12,	[sp, #1404]

    ldr	s2,	[sp, #1256]

    str	s2,	[sp, #1412]

    ldr	s15,	[sp, #1268]

    str	s15,	[sp, #1408]

    ldr	s10,	[sp, #1352]

    str	s10,	[sp, #1416]

    ldr	s10,	[sp, #1356]

    str	s10,	[sp, #1420]

    ldr	s28,	[sp, #1360]

    str	s28,	[sp, #1428]

    ldr	s1,	[sp, #1364]

    str	s1,	[sp, #1424]

    ldr	s12,	[sp, #1288]

    ldr	s1,	[sp, #1372]

    fmov	s23,	s12
    str	s1,	[sp, #1440]

    ldr	s20,	[sp, #1376]

    str	s20,	[sp, #1444]

    ldr	s15,	[sp, #1284]

    ldr	s20,	[sp, #1236]

    fmov	s10,	s15
    ldr	s18,	[sp, #1380]

    fmov	s12,	s20
    str	s18,	[sp, #1104]

    ldr	s15,	[sp, #1388]

    str	s15,	[sp, #1152]

    ldr	s25,	[sp, #1260]

    str	s25,	[sp, #1160]

    ldr	s2,	[sp, #1280]

    str	s2,	[sp, #1164]

    ldr	s25,	[sp, #1392]

    str	s25,	[sp, #1172]

    ldr	s29,	[sp, #1292]

    str	s29,	[sp, #1180]

    ldr	s7,	[sp, #1232]

    str	s7,	[sp, #1188]

    ldr	s25,	[sp, #1248]

    str	s25,	[sp, #1192]

    ldr	s26,	[sp, #1264]

    str	s26,	[sp, #1208]


main_148:
    movi	v18.4s,	#0
    ldr	s13,	[sp, #1208]

    fcmp	s13,	s18
    beq	main_305

main_190:
    ldr	s15,	[sp, #1080]

    add	x1,	sp,	#784
    add	x22,	sp,	#788
    add	x0,	sp,	#792
    add	x25,	sp,	#796
    add	x26,	sp,	#800
    add	x28,	sp,	#804
    add	x19,	sp,	#816
    add	x20,	sp,	#820
    fadd	s15,	s15,	s16
    str	s15,	[sp, #1652]

    ldr	s13,	[sp, #1652]

    fadd	s8,	s13,	s8
    str	s8,	[sp, #1656]

    ldr	s13,	[sp, #1656]

    fadd	s13,	s13,	s4
    str	s13,	[sp, #1216]

    fadd	s13,	s24,	s22
    str	s13,	[sp, #1660]

    ldr	s15,	[sp, #1660]

    fadd	s13,	s15,	s5
    str	s13,	[sp, #1664]

    ldr	s15,	[sp, #1664]

    fadd	s8,	s15,	s30
    fadd	s15,	s27,	s3
    str	s8,	[sp, #1204]

    str	s15,	[sp, #1668]

    ldr	s8,	[sp, #1752]

    ldr	s15,	[sp, #1668]

    fadd	s13,	s15,	s8
    str	s13,	[sp, #1672]

    ldr	s8,	[sp, #1756]

    ldr	s13,	[sp, #1672]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1532]

    ldr	s8,	[sp, #1760]

    ldr	s13,	[sp, #1764]

    fadd	s15,	s13,	s8
    str	s15,	[sp, #1584]

    ldr	s8,	[sp, #1768]

    ldr	s13,	[sp, #1584]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1588]

    ldr	s8,	[sp, #1772]

    ldr	s13,	[sp, #1588]

    fadd	s15,	s13,	s8
    str	s15,	[sp, #1524]

    ldr	s8,	[sp, #1776]

    ldr	s13,	[sp, #1780]

    fadd	s13,	s13,	s8
    str	s13,	[sp, #1572]

    ldr	s15,	[sp, #1788]

    ldr	s8,	[sp, #1572]

    fadd	s13,	s8,	s15
    str	s13,	[sp, #1576]

    ldr	s15,	[sp, #1404]

    ldr	s8,	[sp, #1576]

    fadd	s13,	s8,	s15
    str	s13,	[sp, #1496]

    ldr	s15,	[sp, #1408]

    ldr	s8,	[sp, #1412]

    fadd	s13,	s8,	s15
    str	s13,	[sp, #1560]

    ldr	s15,	[sp, #1416]

    ldr	s8,	[sp, #1560]

    fadd	s8,	s8,	s15
    str	s8,	[sp, #1564]

    ldr	s15,	[sp, #1420]

    ldr	s8,	[sp, #1564]

    fadd	s13,	s8,	s15
    str	s13,	[sp, #1492]

    ldr	s15,	[sp, #1424]

    ldr	s8,	[sp, #1428]

    fadd	s8,	s8,	s15
    str	s8,	[sp, #1548]

    ldr	s15,	[sp, #1548]

    fadd	s15,	s15,	s23
    str	s15,	[sp, #1552]

    ldr	s15,	[sp, #1440]

    ldr	s13,	[sp, #1552]

    fadd	s15,	s13,	s15
    str	s15,	[sp, #1484]

    ldr	s15,	[sp, #1444]

    fadd	s8,	s15,	s10
    str	s8,	[sp, #1528]

    ldr	s8,	[sp, #1528]

    fadd	s15,	s8,	s12
    str	s15,	[sp, #1504]

    ldr	s10,	[sp, #1104]

    ldr	s12,	[sp, #1504]

    fadd	s8,	s12,	s10
    str	s8,	[sp, #1480]

    ldr	s10,	[sp, #1152]

    ldr	s15,	[sp, #1160]

    fadd	s15,	s10,	s15
    str	s15,	[sp, #1508]

    ldr	s13,	[sp, #1164]

    ldr	s8,	[sp, #1508]

    fadd	s12,	s8,	s13
    str	s12,	[sp, #1512]

    ldr	s15,	[sp, #1172]

    ldr	s8,	[sp, #1512]

    fadd	s15,	s8,	s15
    str	s15,	[sp, #1488]

    ldr	s8,	[sp, #1180]

    ldr	s12,	[sp, #1188]

    fadd	s8,	s8,	s12
    str	s8,	[sp, #1516]

    ldr	s13,	[sp, #1192]

    ldr	s15,	[sp, #1516]

    fadd	s8,	s15,	s13
    str	s8,	[sp, #1520]

    ldr	s10,	[sp, #1208]

    ldr	s15,	[sp, #1520]

    fadd	s8,	s15,	s10
    str	s8,	[sp, #1500]

    ldr	s15,	[sp, #1216]

    str	s15,	[x1]

    ldr	s15,	[sp, #1204]

    str	s15,	[x22]

    ldr	s8,	[sp, #1532]

    str	s8,	[x0]

    add	x0,	sp,	#808
    ldr	s12,	[sp, #1524]

    str	s12,	[x25]

    ldr	s15,	[sp, #1496]

    str	s15,	[x26]

    ldr	s8,	[sp, #1492]

    str	s8,	[x28]

    ldr	s12,	[sp, #1484]

    str	s12,	[x0]

    ldr	s15,	[sp, #1480]

    add	x0,	sp,	#812
    str	s15,	[x0]

    movz	w0,	#10
    ldr	s8,	[sp, #1488]

    str	s8,	[x19]

    ldr	s15,	[sp, #1500]

    str	s15,	[x20]

    bl	putfarray
    add	x0,	sp,	#520
    add	x23,	sp,	#772
    add	x11,	sp,	#760
    ldr	w5,	[sp, #3260]

    lsl	w19,	w5,	#2
    mov	x18,	x19
    add	x19,	sp,	#508
    add	x18,	sp,	x18
    add	x18,	x18,	#784
    ldr	s1,	[x18]

    str	s1,	[sp, #1300]

    str	x23,	[sp, #3200]

    ldr	w6,	[sp, #3260]

    ldr	x24,	[sp, #3200]

    lsl	w28,	w6,	#2
    add	x22,	x24,	x28
    ldr	w3,	[x22]

    str	w3,	[sp, #2204]

    ldr	w15,	[sp, #3260]

    lsl	w28,	w15,	#2
    add	x15,	sp,	#568
    add	x1,	x0,	x28
    ldr	w17,	[x1]

    str	w17,	[sp, #3256]

    str	x15,	[sp, #3184]

    ldr	w8,	[sp, #3260]

    ldr	x17,	[sp, #3184]

    lsl	w0,	w8,	#2
    add	x0,	x17,	x0
    ldr	w21,	[x0]

    add	x0,	sp,	#724
    str	w21,	[sp, #2132]

    str	x19,	[sp, #3192]

    ldr	w9,	[sp, #3260]

    ldr	x21,	[sp, #3192]

    lsl	w4,	w9,	#2
    add	x9,	sp,	#580
    add	x3,	x21,	x4
    ldr	w18,	[x3]

    str	w18,	[sp, #3228]

    ldr	w17,	[sp, #3260]

    add	x18,	sp,	#544
    lsl	w28,	w17,	#2
    add	x18,	x18,	x28
    ldr	w1,	[x18]

    str	w1,	[sp, #3240]

    ldr	w18,	[sp, #3260]

    add	x1,	sp,	#556
    lsl	w18,	w18,	#2
    add	x1,	x1,	x18
    ldr	w22,	[x1]

    str	w22,	[sp, #3232]

    add	x22,	sp,	#712
    str	x11,	[sp, #3176]

    ldr	w12,	[sp, #3260]

    ldr	x13,	[sp, #3176]

    lsl	w4,	w12,	#2
    add	x20,	x13,	x4
    ldr	w21,	[x20]

    add	x20,	sp,	#700
    str	w21,	[sp, #6416]

    add	x21,	sp,	#496
    str	x21,	[sp, #3080]

    ldr	w13,	[sp, #3260]

    ldr	x24,	[sp, #3080]

    lsl	w2,	w13,	#2
    add	x1,	x24,	x2
    ldr	w13,	[x1]

    add	x1,	sp,	#616
    str	w13,	[sp, #3252]

    add	x13,	sp,	#652
    str	x0,	[sp, #3152]

    ldr	w14,	[sp, #3260]

    ldr	x2,	[sp, #3152]

    lsl	w15,	w14,	#2
    add	x11,	x2,	x15
    ldr	w11,	[x11]

    str	w11,	[sp, #1916]

    str	x9,	[sp, #3056]

    ldr	w15,	[sp, #3260]

    ldr	x12,	[sp, #3056]

    lsl	w10,	w15,	#2
    add	x9,	x12,	x10
    ldr	w28,	[x9]

    add	x9,	sp,	#592
    str	w28,	[sp, #2048]

    add	x28,	sp,	#688
    str	x1,	[sp, #3040]

    ldr	w16,	[sp, #3260]

    ldr	x4,	[sp, #3040]

    lsl	w2,	w16,	#2
    add	x3,	x4,	x2
    ldr	w18,	[x3]

    add	x3,	sp,	#604
    str	w18,	[sp, #6412]

    str	x13,	[sp, #3064]

    ldr	w19,	[sp, #3260]

    ldr	x18,	[sp, #3064]

    lsl	w6,	w19,	#2
    add	x5,	x18,	x6
    ldr	w15,	[x5]

    str	w15,	[sp, #6408]

    ldr	w2,	[sp, #3260]

    lsl	w7,	w2,	#2
    add	x9,	x9,	x7
    ldr	w10,	[x9]

    str	w10,	[sp, #3220]

    ldr	w0,	[sp, #3260]

    lsl	w17,	w0,	#2
    add	x21,	x20,	x17
    add	x17,	sp,	#748
    ldr	w5,	[x21]

    str	w5,	[sp, #3244]

    ldr	w1,	[sp, #3260]

    lsl	w1,	w1,	#2
    add	x22,	x22,	x1
    ldr	w0,	[x22]

    str	w0,	[sp, #3236]

    ldr	w2,	[sp, #3260]

    lsl	w18,	w2,	#2
    add	x3,	x3,	x18
    ldr	w2,	[x3]

    str	w2,	[sp, #3212]

    add	x2,	sp,	#640
    str	x2,	[sp, #2920]

    ldr	w26,	[sp, #3260]

    ldr	x1,	[sp, #2920]

    lsl	w9,	w26,	#2
    add	x7,	x1,	x9
    add	x9,	sp,	#628
    ldr	w26,	[x7]

    str	w26,	[sp, #5752]

    str	x9,	[sp, #2880]

    ldr	w2,	[sp, #3260]

    ldr	x7,	[sp, #2880]

    lsl	w21,	w2,	#2
    add	x18,	x7,	x21
    add	x7,	sp,	#532
    ldr	w25,	[x18]

    str	w25,	[sp, #5728]

    add	x25,	sp,	#664
    str	x28,	[sp, #2904]

    ldr	w0,	[sp, #3260]

    ldr	x26,	[sp, #2904]

    lsl	w4,	w0,	#2
    add	x2,	x26,	x4
    ldr	w4,	[x2]

    str	x7,	[sp, #2792]

    ldr	w3,	[sp, #3260]

    ldr	x26,	[sp, #2792]

    lsl	w8,	w3,	#2
    add	x6,	x26,	x8
    ldr	w13,	[x6]

    str	w13,	[sp, #3248]

    ldr	w7,	[sp, #3260]

    lsl	w23,	w7,	#2
    add	x7,	sp,	#736
    add	x8,	x17,	x23
    ldr	w20,	[x8]

    str	w20,	[sp, #3224]

    add	x20,	sp,	#676
    ldr	w10,	[sp, #3260]

    lsl	w6,	w10,	#2
    add	x7,	x7,	x6
    ldr	w10,	[x7]

    str	w10,	[sp, #3216]

    str	x20,	[sp, #2776]

    ldr	w9,	[sp, #3260]

    ldr	x16,	[sp, #2776]

    lsl	w17,	w9,	#2
    add	x13,	x16,	x17
    ldr	w28,	[x13]

    ldr	w11,	[sp, #3260]

    lsl	w2,	w11,	#2
    add	x2,	x25,	x2
    ldr	w9,	[x2]

    str	w9,	[sp, #3208]

    ldr	w7,	[sp, #2204]

    mov	w6,	w7
    str	w6,	[sp, #2152]

    ldr	w23,	[sp, #3256]

    mov	w9,	w23
    str	w9,	[sp, #5708]

    ldr	w2,	[sp, #2132]

    mov	w10,	w2
    str	w10,	[sp, #5732]

    ldr	s20,	[sp, #1316]

    ldr	w0,	[sp, #3228]

    fmov	s10,	s20
    mov	w15,	w0
    str	w15,	[sp, #5736]

    ldr	w3,	[sp, #3240]

    mov	w14,	w3
    mov	w3,	w4
    str	w14,	[sp, #5712]

    ldr	w8,	[sp, #3232]

    mov	w19,	w8
    str	w19,	[sp, #5716]

    ldr	s8,	[sp, #1224]

    ldr	s25,	[sp, #1340]

    fmov	s17,	s8
    ldr	s20,	[sp, #1228]

    fmov	s16,	s25
    ldr	w9,	[sp, #6416]

    fmov	s1,	s20
    mov	w12,	w9
    str	w12,	[sp, #1948]

    ldr	s5,	[sp, #1312]

    ldr	s21,	[sp, #1376]

    str	s21,	[sp, #1624]

    ldr	w21,	[sp, #3252]

    mov	w25,	w21
    str	w25,	[sp, #8980]

    ldr	s20,	[sp, #1232]

    str	s20,	[sp, #1648]

    ldr	w20,	[sp, #1916]

    mov	w16,	w20
    str	w16,	[sp, #1988]

    ldr	s22,	[sp, #1236]

    str	s22,	[sp, #1628]

    ldr	s15,	[sp, #1240]

    ldr	s3,	[sp, #1244]

    fmov	s23,	s15
    ldr	s21,	[sp, #1328]

    fmov	s4,	s3
    ldr	s15,	[sp, #1248]

    fmov	s28,	s21
    str	s15,	[sp, #1644]

    ldr	s26,	[sp, #1252]

    ldr	w7,	[sp, #2048]

    fmov	s29,	s26
    mov	w0,	w7
    str	w0,	[sp, #8984]

    ldr	s7,	[sp, #1388]

    str	s7,	[sp, #1640]

    ldr	w6,	[sp, #6412]

    mov	w1,	w6
    str	w1,	[sp, #5744]

    ldr	w2,	[sp, #6408]

    mov	w18,	w2
    str	w18,	[sp, #5764]

    ldr	s13,	[sp, #1256]

    str	s13,	[sp, #1608]

    ldr	s30,	[sp, #1260]

    fmov	s6,	s30
    str	s6,	[sp, #1076]

    ldr	s19,	[sp, #1356]

    fmov	s24,	s19
    str	s24,	[sp, #1612]

    ldr	s25,	[sp, #1320]

    ldr	s19,	[sp, #1364]

    fmov	s27,	s25
    str	s19,	[sp, #1616]

    ldr	w22,	[sp, #3220]

    mov	w26,	w22
    str	w26,	[sp, #5720]

    ldr	s22,	[sp, #1264]

    str	s22,	[sp, #1156]

    ldr	w18,	[sp, #3244]

    mov	w26,	w18
    str	w26,	[sp, #2016]

    ldr	s26,	[sp, #1268]

    fmov	s12,	s26
    str	s12,	[sp, #1724]

    ldr	s19,	[sp, #1272]

    ldr	s7,	[sp, #1276]

    fmov	s26,	s19
    ldr	s18,	[sp, #1280]

    fmov	s12,	s7
    str	s18,	[sp, #1116]

    ldr	w17,	[sp, #3236]

    mov	w2,	w17
    str	w2,	[sp, #1920]

    ldr	w6,	[sp, #3212]

    mov	w1,	w6
    str	w1,	[sp, #5724]

    ldr	s24,	[sp, #1336]

    ldr	s20,	[sp, #1324]

    fmov	s19,	s24
    ldr	s7,	[sp, #1304]

    fmov	s22,	s20
    ldr	w11,	[sp, #5752]

    fmov	s20,	s7
    mov	w23,	w11
    str	w23,	[sp, #5740]

    ldr	s15,	[sp, #1380]

    str	s15,	[sp, #1148]

    ldr	w8,	[sp, #5728]

    mov	w6,	w8
    mov	w8,	w28
    str	w6,	[sp, #8988]

    str	w3,	[sp, #5748]

    ldr	s21,	[sp, #1372]

    str	s21,	[sp, #1112]

    ldr	s21,	[sp, #1360]

    ldr	s3,	[sp, #1332]

    fmov	s31,	s21
    fmov	s30,	s3
    ldr	s21,	[sp, #1284]

    str	s21,	[sp, #1092]

    ldr	w23,	[sp, #3248]

    mov	w19,	w23
    str	w19,	[sp, #8976]

    ldr	w6,	[sp, #3224]

    mov	w0,	w6
    str	w0,	[sp, #6404]

    ldr	w18,	[sp, #3216]

    mov	w25,	w18
    str	w25,	[sp, #5768]

    ldr	s21,	[sp, #1344]

    ldr	s3,	[sp, #1348]

    fmov	s8,	s21
    fmov	s6,	s3
    ldr	s21,	[sp, #1352]

    ldr	s3,	[sp, #1288]

    fmov	s13,	s21
    ldr	s2,	[sp, #1292]

    fmov	s18,	s3
    str	s2,	[sp, #1176]

    ldr	s15,	[sp, #1296]

    str	w8,	[sp, #8288]

    fmov	s2,	s15
    ldr	s21,	[sp, #1308]

    str	s21,	[sp, #1072]

    ldr	w28,	[sp, #3208]

    ldr	s15,	[sp, #1392]

    mov	w18,	w28
    str	s15,	[sp, #1168]


main_309:
    ldr	w20,	[sp, #2152]

    cmp	w20,	#0
    beq	main_308

main_375:
    fadd	s9,	s20,	s4
    ldr	s14,	[sp, #1072]

    fadd	s11,	s10,	s12
    add	x0,	sp,	#944
    add	x1,	sp,	#948
    movz	fp,	#5220
    add	x21,	sp,	#992
    fadd	s9,	s9,	s14
    fadd	s10,	s17,	s27
    fadd	s11,	s11,	s29
    fadd	s14,	s9,	s5
    fadd	s10,	s10,	s22
    fadd	s9,	s11,	s1
    str	s14,	[sp, #1220]

    fadd	s15,	s10,	s28
    fadd	s11,	s23,	s30
    str	s9,	[sp, #1212]

    fadd	s11,	s11,	s19
    str	s15,	[sp, #1200]

    fadd	s15,	s11,	s16
    fadd	s11,	s26,	s2
    str	s15,	[sp, #1184]

    fadd	s9,	s11,	s8
    fadd	s14,	s9,	s6
    str	s14,	[sp, #1692]

    ldr	s8,	[sp, #1608]

    ldr	s9,	[sp, #1724]

    fadd	s9,	s8,	s9
    fadd	s11,	s9,	s13
    ldr	s13,	[sp, #1612]

    fadd	s12,	s11,	s13
    str	s12,	[sp, #1688]

    ldr	s14,	[sp, #1616]

    ldr	s9,	[sp, #1112]

    fadd	s8,	s31,	s14
    fadd	s13,	s8,	s18
    fadd	s10,	s13,	s9
    str	s10,	[sp, #1124]

    ldr	s12,	[sp, #1092]

    ldr	s11,	[sp, #1624]

    ldr	s15,	[sp, #1628]

    fadd	s13,	s11,	s12
    ldr	s8,	[sp, #1148]

    fadd	s12,	s13,	s15
    fadd	s14,	s12,	s8
    str	s14,	[sp, #1820]

    ldr	s9,	[sp, #1076]

    ldr	s10,	[sp, #1640]

    ldr	s12,	[sp, #1116]

    fadd	s13,	s10,	s9
    ldr	s10,	[sp, #1168]

    fadd	s13,	s13,	s12
    ldr	s11,	[sp, #1176]

    fadd	s8,	s13,	s10
    ldr	s14,	[sp, #1648]

    fadd	s11,	s11,	s14
    ldr	s14,	[sp, #1644]

    ldr	s9,	[sp, #1156]

    fadd	s12,	s11,	s14
    str	x0,	[sp, #1792]

    fadd	s9,	s12,	s9
    add	x0,	sp,	#952
    ldr	s12,	[sp, #1220]

    ldr	x28,	[sp, #1792]

    str	s12,	[x28]

    add	x28,	sp,	#956
    ldr	s13,	[sp, #1212]

    str	s13,	[x1]

    add	x1,	sp,	#960
    ldr	s15,	[sp, #1200]

    str	s15,	[x0]

    add	x0,	sp,	#964
    ldr	s13,	[sp, #1184]

    str	s13,	[x28]

    add	x28,	sp,	#968
    ldr	s14,	[sp, #1692]

    str	s14,	[x1]

    add	x1,	sp,	#972
    ldr	s15,	[sp, #1688]

    str	s15,	[x0]

    add	x0,	sp,	#976
    ldr	s10,	[sp, #1124]

    str	s10,	[x28]

    add	x28,	sp,	#980
    ldr	s14,	[sp, #1820]

    str	s14,	[x1]

    str	s8,	[x0]

    str	s9,	[x28]

    ldr	w20,	[sp, #5708]

    ldr	w0,	[sp, #5736]

    ldr	w1,	[sp, #8980]

    add	w22,	w0,	w20
    add	w1,	w22,	w1
    str	w1,	[sp, #5372]

    ldr	w24,	[sp, #5712]

    ldr	w28,	[sp, #5716]

    ldr	w27,	[sp, #8976]

    add	w1,	w28,	w24
    add	w0,	w1,	w27
    str	w0,	[sp, #1876]

    ldr	w23,	[sp, #5732]

    ldr	w1,	[sp, #8984]

    ldr	w24,	[sp, #5720]

    add	w0,	w1,	w23
    add	w28,	w0,	w24
    str	w28,	[sp, #1880]

    ldr	w1,	[sp, #5724]

    ldr	w27,	[sp, #5744]

    ldr	w0,	[sp, #8988]

    add	w22,	w1,	w27
    add	w25,	w22,	w0
    add	x22,	sp,	#984
    str	w25,	[sp, #5392]

    ldr	w0,	[sp, #5740]

    ldr	w20,	[sp, #5764]

    add	w28,	w0,	w20
    add	w25,	w28,	w18
    str	w25,	[sp, #2008]

    ldr	w19,	[sp, #2016]

    ldr	w18,	[sp, #5748]

    ldr	w1,	[sp, #8288]

    add	w0,	w18,	w19
    add	w1,	w0,	w1
    str	w1,	[sp, #1868]

    ldr	w0,	[sp, #1920]

    ldr	w26,	[sp, #1988]

    ldr	w24,	[sp, #5768]

    add	w0,	w0,	w26
    add	w1,	w0,	w24
    str	w1,	[sp, #1884]

    ldr	w19,	[sp, #1948]

    ldr	w25,	[sp, #2152]

    ldr	w24,	[sp, #6404]

    add	w1,	w19,	w25
    add	w23,	w1,	w24
    add	x24,	sp,	#988
    str	w23,	[sp, #2028]

    str	x22,	[sp, fp]

    movz	fp,	#5220
    ldr	x26,	[sp, fp]

    movz	fp,	#3396
    ldr	w27,	[sp, #5372]

    str	w27,	[x26]

    add	x27,	sp,	#1004
    str	x24,	[sp, fp]

    movz	fp,	#3396
    add	x24,	sp,	#1008
    ldr	w1,	[sp, #1876]

    ldr	x25,	[sp, fp]

    movz	fp,	#3412
    str	w1,	[x25]

    add	x1,	sp,	#996
    str	x21,	[sp, fp]

    movz	fp,	#3412
    ldr	w21,	[sp, #1880]

    ldr	x22,	[sp, fp]

    movz	fp,	#5212
    str	w21,	[x22]

    str	x1,	[sp, fp]

    add	x1,	sp,	#1000
    movz	fp,	#5212
    ldr	x21,	[sp, fp]

    movz	fp,	#5236
    ldr	w25,	[sp, #5392]

    str	w25,	[x21]

    str	x1,	[sp, fp]

    movz	fp,	#5236
    ldr	w26,	[sp, #2008]

    ldr	x21,	[sp, fp]

    movz	fp,	#2060
    str	w26,	[x21]

    add	x26,	sp,	#1012
    str	x27,	[sp, fp]

    movz	fp,	#2060
    ldr	w0,	[sp, #1868]

    ldr	x28,	[sp, fp]

    movz	fp,	#2076
    str	w0,	[x28]

    movz	w0,	#10
    str	x24,	[sp, fp]

    movz	fp,	#2076
    ldr	w20,	[sp, #1884]

    ldr	x25,	[sp, fp]

    movz	fp,	#2100
    str	w20,	[x25]

    str	x26,	[sp, fp]

    movz	fp,	#2100
    ldr	w26,	[sp, #2028]

    ldr	x27,	[sp, fp]

    str	w26,	[x27]

    ldr	x1,	[sp, #1792]

    bl	putfarray
    movz	fp,	#5220
    movz	w0,	#8
    ldr	x1,	[sp, fp]

    bl	putarray
    ldr	w11,	[sp, #5372]

    movz	fp,	#5220
    ldr	s4,	[sp, #1220]

    scvtf	s5,	w11
    ldr	x14,	[sp, fp]

    fsub	s1,	s5,	s4
    movz	fp,	#3396
    fcvtzs	w0,	s1
    str	w0,	[x14]

    ldr	w22,	[sp, #1876]

    ldr	s28,	[sp, #1212]

    scvtf	s7,	w22
    ldr	x19,	[sp, fp]

    fsub	s4,	s7,	s28
    movz	fp,	#3412
    fcvtzs	w3,	s4
    str	w3,	[x19]

    ldr	w26,	[sp, #1880]

    ldr	s15,	[sp, #1200]

    scvtf	s10,	w26
    ldr	x0,	[sp, fp]

    fsub	s7,	s10,	s15
    movz	fp,	#5212
    fcvtzs	w7,	s7
    str	w7,	[x0]

    ldr	w21,	[sp, #5392]

    ldr	s27,	[sp, #1184]

    scvtf	s12,	w21
    ldr	x9,	[sp, fp]

    fsub	s10,	s12,	s27
    movz	fp,	#5236
    fcvtzs	w10,	s10
    str	w10,	[x9]

    ldr	w1,	[sp, #2008]

    ldr	s3,	[sp, #1692]

    scvtf	s12,	w1
    ldr	x24,	[sp, fp]

    fsub	s28,	s12,	s3
    movz	fp,	#2060
    fcvtzs	w12,	s28
    str	w12,	[x24]

    ldr	w5,	[sp, #1868]

    ldr	s27,	[sp, #1688]

    scvtf	s30,	w5
    ldr	x14,	[sp, fp]

    fsub	s17,	s30,	s27
    movz	fp,	#2076
    fcvtzs	w16,	s17
    str	w16,	[x14]

    ldr	w9,	[sp, #1884]

    ldr	s23,	[sp, #1124]

    scvtf	s22,	w9
    ldr	x23,	[sp, fp]

    fsub	s13,	s22,	s23
    movz	fp,	#2100
    fcvtzs	w18,	s13
    str	w18,	[x23]

    ldr	w17,	[sp, #2028]

    ldr	s19,	[sp, #1820]

    scvtf	s17,	w17
    ldr	x9,	[sp, fp]

    fsub	s15,	s17,	s19
    movz	fp,	#2108
    fcvtzs	w2,	s15
    str	w2,	[x9]

    ldr	w1,	[sp, #3260]

    lsl	w4,	w1,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#984
    ldr	w5,	[x3]

    ldr	x9,	[sp, #3168]

    scvtf	s10,	w5
    mov	x11,	x9
    str	x11,	[sp, fp]

    movz	fp,	#5260
    ldr	x5,	[sp, #3160]

    mov	x12,	x5
    str	x12,	[sp, #2656]

    add	x12,	sp,	#924
    ldr	x26,	[sp, #3144]

    ldr	x24,	[sp, #3136]

    mov	x11,	x26
    mov	x20,	x24
    str	x20,	[sp, fp]

    movz	fp,	#5268
    ldr	x20,	[sp, #3128]

    mov	x23,	x20
    str	x23,	[sp, fp]

    movz	fp,	#5276
    ldr	x16,	[sp, #3120]

    mov	x18,	x16
    add	x16,	sp,	#916
    str	x18,	[sp, #2664]

    ldr	x10,	[sp, #3112]

    mov	x22,	x10
    str	x22,	[sp, #2672]

    ldr	x6,	[sp, #3104]

    mov	x26,	x6
    str	x26,	[sp, #2680]

    ldr	x2,	[sp, #3096]

    mov	x1,	x2
    str	x1,	[sp, #2688]

    ldr	x0,	[sp, #3088]

    mov	x26,	x0
    str	x26,	[sp, fp]

    movz	fp,	#5284
    ldr	x20,	[sp, #3072]

    mov	x0,	x20
    str	x0,	[sp, fp]

    movz	fp,	#5300
    ldr	x7,	[sp, #3048]

    mov	x8,	x7
    str	x8,	[sp, fp]

    movz	fp,	#5316
    ldr	x0,	[sp, #3032]

    mov	x3,	x0
    str	x3,	[sp, #2696]

    ldr	x26,	[sp, #3024]

    mov	x17,	x26
    str	x17,	[sp, fp]

    movz	fp,	#5324
    ldr	x22,	[sp, #3016]

    mov	x20,	x22
    str	x20,	[sp, fp]

    movz	fp,	#5332
    ldr	x18,	[sp, #3008]

    mov	x23,	x18
    str	x23,	[sp, fp]

    movz	fp,	#5340
    ldr	x13,	[sp, #3000]

    mov	x7,	x13
    str	x7,	[sp, #2704]

    ldr	x8,	[sp, #2992]

    mov	x13,	x8
    str	x13,	[sp, #2712]

    ldr	x4,	[sp, #2984]

    mov	x26,	x4
    str	x26,	[sp, fp]

    movz	fp,	#5348
    ldr	x0,	[sp, #2976]

    str	x0,	[sp, fp]

    movz	fp,	#5356
    ldr	x0,	[sp, #2968]

    mov	x18,	x0
    str	x18,	[sp, #2720]

    ldr	x25,	[sp, #2960]

    mov	x22,	x25
    str	x22,	[sp, #2728]

    ldr	x20,	[sp, #2952]

    mov	x3,	x20
    str	x3,	[sp, fp]

    movz	fp,	#5364
    ldr	x15,	[sp, #2944]

    mov	x6,	x15
    str	x6,	[sp, fp]

    movz	fp,	#5396
    ldr	x9,	[sp, #2936]

    mov	x14,	x9
    str	x14,	[sp, #5376]

    ldr	x5,	[sp, #2928]

    mov	x17,	x5
    str	x17,	[sp, #5384]

    ldr	x2,	[sp, #2912]

    mov	x3,	x2
    str	x3,	[sp, #2736]

    ldr	x26,	[sp, #2896]

    mov	x24,	x26
    str	x24,	[sp, fp]

    movz	fp,	#5404
    ldr	x22,	[sp, #2888]

    mov	x27,	x22
    add	x22,	sp,	#904
    str	x27,	[sp, fp]

    movz	fp,	#5412
    ldr	x7,	[sp, #2872]

    mov	x6,	x7
    str	x6,	[sp, #2744]

    ldr	x2,	[sp, #2864]

    str	x2,	[sp, #2752]

    ldr	x6,	[sp, #2856]

    mov	x1,	x6
    str	x1,	[sp, fp]

    add	x1,	sp,	#920
    movz	fp,	#5420
    ldr	x4,	[sp, #2848]

    str	x4,	[sp, fp]

    movz	fp,	#5428
    ldr	x9,	[sp, #2840]

    mov	x17,	x9
    str	x17,	[sp, #2760]

    ldr	x4,	[sp, #2832]

    mov	x26,	x4
    str	x26,	[sp, #2768]

    ldr	x26,	[sp, #2824]

    mov	x17,	x26
    str	x17,	[sp, #8968]

    ldr	x19,	[sp, #2816]

    mov	x14,	x19
    str	x14,	[sp, fp]

    movz	fp,	#5436
    add	x14,	sp,	#908
    ldr	x9,	[sp, #2808]

    mov	x17,	x9
    str	x17,	[sp, fp]

    movz	fp,	#5452
    ldr	x2,	[sp, #2800]

    mov	x23,	x2
    add	x2,	sp,	#936
    str	x23,	[sp, fp]

    add	x23,	sp,	#912
    movz	fp,	#5460
    ldr	x21,	[sp, #2784]

    mov	x27,	x21
    str	x27,	[sp, fp]

    movz	fp,	#2460
    str	x22,	[sp, #2616]

    add	x22,	sp,	#928
    str	x14,	[sp, #2440]

    str	x23,	[sp, #2448]

    str	x16,	[sp, fp]

    movz	fp,	#2492
    str	x1,	[sp, #2472]

    add	x1,	sp,	#932
    str	x12,	[sp, #2480]

    str	x22,	[sp, fp]

    add	x22,	sp,	#940
    movz	fp,	#2500
    str	x1,	[sp, fp]

    movz	fp,	#2108
    str	x2,	[sp, #2512]

    str	x22,	[sp, #2520]

    ldr	x1,	[sp, fp]

    movz	fp,	#5756
    str	x1,	[sp, fp]

    movz	fp,	#5260
    mov	x1,	x11
    ldr	x23,	[sp, #2656]

    mov	x2,	x23
    str	x2,	[sp, #2576]

    str	x1,	[sp, #1048]

    ldr	x23,	[sp, fp]

    movz	fp,	#5268
    mov	x14,	x23
    str	x14,	[sp, #1032]

    ldr	x27,	[sp, fp]

    movz	fp,	#2548
    mov	x13,	x27
    str	x13,	[sp, #2536]

    ldr	x19,	[sp, #2664]

    mov	x26,	x19
    str	x26,	[sp, fp]

    movz	fp,	#2556
    ldr	x26,	[sp, #2672]

    mov	x19,	x26
    str	x19,	[sp, #2568]

    ldr	x11,	[sp, #2680]

    mov	x1,	x11
    str	x1,	[sp, fp]

    movz	fp,	#5276
    ldr	x2,	[sp, #2688]

    mov	x14,	x2
    str	x14,	[sp, #1016]

    ldr	x2,	[sp, fp]

    movz	fp,	#5284
    mov	x26,	x2
    str	x26,	[sp, #2528]

    ldr	x5,	[sp, fp]

    movz	fp,	#5300
    mov	x13,	x5
    str	x13,	[sp, #2424]

    ldr	x13,	[sp, fp]

    movz	fp,	#2404
    mov	x2,	x13
    str	x2,	[sp, fp]

    movz	fp,	#5316
    ldr	x22,	[sp, #2696]

    mov	x11,	x22
    str	x11,	[sp, #2416]

    ldr	x21,	[sp, fp]

    movz	fp,	#5324
    mov	x23,	x21
    str	x23,	[sp, #2392]

    ldr	x24,	[sp, fp]

    movz	fp,	#5332
    mov	x8,	x24
    str	x8,	[sp, #2376]

    ldr	x0,	[sp, fp]

    movz	fp,	#5340
    mov	x8,	x0
    str	x8,	[sp, #2352]

    ldr	x6,	[sp, #2704]

    mov	x20,	x6
    str	x20,	[sp, #2360]

    ldr	x14,	[sp, #2712]

    mov	x22,	x14
    str	x22,	[sp, #2368]

    ldr	x3,	[sp, fp]

    movz	fp,	#5348
    mov	x22,	x3
    str	x22,	[sp, #2344]

    ldr	x6,	[sp, fp]

    movz	fp,	#5356
    mov	x20,	x6
    str	x20,	[sp, #2296]

    ldr	x2,	[sp, #2720]

    mov	x13,	x2
    str	x13,	[sp, #2312]

    ldr	x22,	[sp, #2728]

    mov	x26,	x22
    str	x26,	[sp, #2328]

    ldr	x9,	[sp, fp]

    movz	fp,	#5364
    mov	x24,	x9
    str	x24,	[sp, #2280]

    ldr	x12,	[sp, fp]

    movz	fp,	#5396
    str	x12,	[sp, #2264]

    ldr	x19,	[sp, #5376]

    mov	x26,	x19
    str	x26,	[sp, #2240]

    ldr	x22,	[sp, #5384]

    mov	x19,	x22
    str	x19,	[sp, #2208]

    ldr	x19,	[sp, #2736]

    mov	x12,	x19
    str	x12,	[sp, #2224]

    ldr	x2,	[sp, fp]

    movz	fp,	#2180
    str	x2,	[sp, fp]

    movz	fp,	#5404
    ldr	x5,	[sp, fp]

    movz	fp,	#2156
    mov	x25,	x5
    str	x25,	[sp, #1952]

    ldr	x19,	[sp, #2744]

    mov	x15,	x19
    str	x15,	[sp, #2136]

    ldr	x14,	[sp, #2752]

    mov	x19,	x14
    str	x19,	[sp, fp]

    movz	fp,	#5412
    ldr	x8,	[sp, fp]

    movz	fp,	#1932
    mov	x15,	x8
    str	x15,	[sp, fp]

    movz	fp,	#5420
    ldr	x11,	[sp, fp]

    movz	fp,	#1980
    mov	x10,	x11
    str	x10,	[sp, fp]

    movz	fp,	#1972
    ldr	x14,	[sp, #2760]

    mov	x22,	x14
    str	x22,	[sp, #1992]

    ldr	x18,	[sp, #2768]

    mov	x1,	x18
    str	x1,	[sp, #2000]

    ldr	x17,	[sp, #8968]

    mov	x12,	x17
    str	x12,	[sp, fp]

    movz	fp,	#5428
    ldr	x8,	[sp, fp]

    movz	fp,	#5436
    mov	x28,	x8
    str	x28,	[sp, #1960]

    ldr	x11,	[sp, fp]

    movz	fp,	#1908
    mov	x10,	x11
    str	x10,	[sp, fp]

    movz	fp,	#5452
    ldr	x17,	[sp, fp]

    movz	fp,	#5460
    mov	x19,	x17
    str	x19,	[sp, #2032]

    ldr	x20,	[sp, fp]

    movz	fp,	#1852
    mov	x3,	x20
    str	x3,	[sp, fp]


main_518:
    ldr	w2,	[sp, #3260]

    movz	fp,	#5756
    lsl	w26,	w2,	#2
    ldr	x2,	[sp, fp]

    movz	fp,	#2548
    add	x20,	x2,	x26
    ldr	s5,	[x20]

    ldr	w3,	[sp, #3260]

    ldr	x21,	[sp, #2576]

    lsl	w9,	w3,	#2
    add	x25,	x21,	x9
    ldr	s24,	[x25]

    ldr	w4,	[sp, #3260]

    fadd	s7,	s5,	s24
    ldr	x8,	[sp, #1048]

    lsl	w26,	w4,	#2
    add	x2,	x8,	x26
    ldr	s28,	[x2]

    ldr	w5,	[sp, #3260]

    fadd	s11,	s7,	s28
    ldr	x0,	[sp, #1032]

    lsl	w1,	w5,	#2
    add	x7,	x0,	x1
    ldr	s1,	[x7]

    ldr	w6,	[sp, #3260]

    fadd	s11,	s11,	s1
    ldr	x12,	[sp, #2536]

    lsl	w8,	w6,	#2
    add	x12,	x12,	x8
    ldr	s12,	[x12]

    ldr	w7,	[sp, #3260]

    ldr	x22,	[sp, fp]

    lsl	w8,	w7,	#2
    movz	fp,	#2556
    add	x18,	x22,	x8
    ldr	s23,	[x18]

    ldr	w8,	[sp, #3260]

    fadd	s13,	s12,	s23
    ldr	x3,	[sp, #2568]

    lsl	w26,	w8,	#2
    add	x24,	x3,	x26
    ldr	s27,	[x24]

    ldr	w9,	[sp, #3260]

    fadd	s21,	s13,	s27
    ldr	x8,	[sp, fp]

    lsl	w2,	w9,	#2
    movz	fp,	#2404
    add	x1,	x8,	x2
    ldr	s2,	[x1]

    ldr	w10,	[sp, #3260]

    fadd	s12,	s21,	s2
    ldr	x13,	[sp, #1016]

    lsl	w8,	w10,	#2
    add	x5,	x13,	x8
    ldr	s26,	[x5]

    ldr	w11,	[sp, #3260]

    ldr	x7,	[sp, #2528]

    lsl	w19,	w11,	#2
    add	x9,	x7,	x19
    ldr	s31,	[x9]

    ldr	w12,	[sp, #3260]

    fadd	s1,	s26,	s31
    ldr	x2,	[sp, #2424]

    lsl	w26,	w12,	#2
    add	x17,	x2,	x26
    ldr	s5,	[x17]

    ldr	w13,	[sp, #3260]

    fadd	s2,	s1,	s5
    ldr	x16,	[sp, fp]

    lsl	w2,	w13,	#2
    movz	fp,	#2180
    add	x21,	x16,	x2
    ldr	s8,	[x21]

    ldr	w14,	[sp, #3260]

    fadd	s5,	s2,	s8
    ldr	x26,	[sp, #2416]

    lsl	w1,	w14,	#2
    add	x0,	x26,	x1
    ldr	s4,	[x0]

    ldr	w15,	[sp, #3260]

    ldr	x6,	[sp, #2392]

    lsl	w18,	w15,	#2
    add	x3,	x6,	x18
    ldr	s19,	[x3]

    ldr	w16,	[sp, #3260]

    fadd	s4,	s4,	s19
    ldr	x25,	[sp, #2376]

    lsl	w12,	w16,	#2
    add	x8,	x25,	x12
    ldr	s19,	[x8]

    ldr	w17,	[sp, #3260]

    fadd	s9,	s4,	s19
    ldr	x10,	[sp, #2352]

    lsl	w2,	w17,	#2
    add	x15,	x10,	x2
    ldr	s26,	[x15]

    ldr	w18,	[sp, #3260]

    fadd	s21,	s9,	s26
    ldr	x15,	[sp, #2360]

    lsl	w8,	w18,	#2
    add	x25,	x15,	x8
    ldr	s8,	[x25]

    ldr	w19,	[sp, #3260]

    ldr	x20,	[sp, #2368]

    lsl	w3,	w19,	#2
    add	x2,	x20,	x3
    ldr	s24,	[x2]

    ldr	w20,	[sp, #3260]

    fadd	s16,	s8,	s24
    ldr	x5,	[sp, #2344]

    lsl	w26,	w20,	#2
    add	x8,	x5,	x26
    ldr	s30,	[x8]

    ldr	w21,	[sp, #3260]

    fadd	s14,	s16,	s30
    ldr	x4,	[sp, #2296]

    lsl	w20,	w21,	#2
    add	x17,	x4,	x20
    ldr	s4,	[x17]

    ldr	w22,	[sp, #3260]

    fadd	s3,	s14,	s4
    ldr	x14,	[sp, #2312]

    lsl	w28,	w22,	#2
    add	x24,	x14,	x28
    ldr	s17,	[x24]

    ldr	w23,	[sp, #3260]

    ldr	x24,	[sp, #2328]

    lsl	w2,	w23,	#2
    add	x1,	x24,	x2
    ldr	s27,	[x1]

    ldr	w24,	[sp, #3260]

    fadd	s16,	s17,	s27
    ldr	x23,	[sp, #2280]

    lsl	w8,	w24,	#2
    add	x7,	x23,	x8
    ldr	s31,	[x7]

    ldr	w25,	[sp, #3260]

    fadd	s23,	s16,	s31
    ldr	x13,	[sp, #2264]

    lsl	w2,	w25,	#2
    add	x15,	x13,	x2
    ldr	s6,	[x15]

    ldr	w26,	[sp, #3260]

    fadd	s6,	s23,	s6
    ldr	x28,	[sp, #2240]

    lsl	w24,	w26,	#2
    add	x21,	x28,	x24
    ldr	s1,	[x21]

    ldr	w28,	[sp, #3260]

    ldr	x7,	[sp, #2208]

    lsl	w19,	w28,	#2
    add	x0,	x7,	x19
    ldr	s2,	[x0]

    ldr	w0,	[sp, #3260]

    fadd	s19,	s1,	s2
    ldr	x17,	[sp, #2224]

    lsl	w25,	w0,	#2
    add	x5,	x17,	x25
    ldr	s8,	[x5]

    ldr	w0,	[sp, #3260]

    fadd	s24,	s19,	s8
    ldr	x20,	[sp, fp]

    lsl	w15,	w0,	#2
    movz	fp,	#2156
    add	x12,	x20,	x15
    ldr	s22,	[x12]

    ldr	w1,	[sp, #3260]

    fadd	s8,	s24,	s22
    ldr	x14,	[sp, #1952]

    lsl	w24,	w1,	#2
    add	x20,	x14,	x24
    ldr	s2,	[x20]

    ldr	w2,	[sp, #3260]

    ldr	x25,	[sp, #2136]

    lsl	w0,	w2,	#2
    add	x25,	x25,	x0
    ldr	s22,	[x25]

    ldr	w3,	[sp, #3260]

    fadd	s15,	s2,	s22
    ldr	x9,	[sp, fp]

    lsl	w5,	w3,	#2
    movz	fp,	#1932
    add	x3,	x9,	x5
    ldr	s31,	[x3]

    ldr	w4,	[sp, #3260]

    fadd	s1,	s15,	s31
    ldr	x0,	[sp, fp]

    lsl	w17,	w4,	#2
    movz	fp,	#1980
    add	x9,	x0,	x17
    ldr	s13,	[x9]

    ldr	w5,	[sp, #3260]

    fadd	s7,	s1,	s13
    lsl	w12,	w5,	#2
    ldr	x5,	[sp, fp]

    movz	fp,	#1972
    add	x18,	x5,	x12
    ldr	s13,	[x18]

    ldr	w6,	[sp, #3260]

    ldr	x15,	[sp, #1992]

    lsl	w17,	w6,	#2
    add	x24,	x15,	x17
    ldr	s30,	[x24]

    ldr	w7,	[sp, #3260]

    fadd	s23,	s13,	s30
    ldr	x20,	[sp, #2000]

    lsl	w3,	w7,	#2
    add	x2,	x20,	x3
    ldr	s18,	[x2]

    ldr	w8,	[sp, #3260]

    fadd	s1,	s23,	s18
    ldr	x0,	[sp, fp]

    lsl	w5,	w8,	#2
    movz	fp,	#1908
    add	x8,	x0,	x5
    ldr	s28,	[x8]

    ldr	w9,	[sp, #3260]

    fadd	s13,	s1,	s28
    ldr	x20,	[sp, #1960]

    lsl	w18,	w9,	#2
    add	x17,	x20,	x18
    ldr	s28,	[x17]

    ldr	w10,	[sp, #3260]

    ldr	x7,	[sp, fp]

    lsl	w19,	w10,	#2
    movz	fp,	#1852
    add	x21,	x7,	x19
    ldr	s9,	[x21]

    ldr	w11,	[sp, #3260]

    fadd	s9,	s28,	s9
    ldr	x18,	[sp, #2032]

    lsl	w25,	w11,	#2
    add	x1,	x18,	x25
    ldr	s4,	[x1]

    ldr	w12,	[sp, #3260]

    fadd	s27,	s9,	s4
    ldr	x4,	[sp, fp]

    lsl	w10,	w12,	#2
    movz	fp,	#2460
    add	x9,	x4,	x10
    ldr	s31,	[x9]

    ldr	x19,	[sp, #2616]

    fadd	s14,	s27,	s31
    str	s11,	[x19]

    movi	v11.4s,	#0
    ldr	x17,	[sp, #2440]

    str	s12,	[x17]

    ldr	x20,	[sp, #2448]

    str	s5,	[x20]

    ldr	x0,	[sp, fp]

    movz	fp,	#2492
    str	s21,	[x0]

    ldr	x7,	[sp, #2472]

    str	s3,	[x7]

    ldr	x10,	[sp, #2480]

    str	s6,	[x10]

    ldr	x19,	[sp, fp]

    movz	fp,	#2500
    str	s8,	[x19]

    ldr	x22,	[sp, fp]

    str	s7,	[x22]

    ldr	x1,	[sp, #2512]

    str	s13,	[x1]

    ldr	x4,	[sp, #2520]

    str	s14,	[x4]

    ldr	s6,	[x9]

    fcmp	s6,	s11
    cset	w12,	ne
    mov	w15,	w12
    cmp	w15,	#0
    movi	v11.4s,	#0
    cset	w18,	ne
    mov	w19,	w18
    scvtf	s12,	w19
    fcmp	s12,	s11
    movi	v9.4s,	#0
    cset	w21,	ne
    mov	w0,	w21
    scvtf	s15,	w0
    fcmp	s15,	s9
    beq	main_517

main_679:
    movz	w0,	#10
    ldr	x1,	[sp, #2616]

    bl	putfarray
    add	x5,	sp,	#868
    add	x21,	sp,	#852
    movz	fp,	#4524
    ldr	w13,	[sp, #3260]

    add	x10,	sp,	#840
    lsl	w0,	w13,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#904
    ldr	s14,	[x0]

    ldr	x23,	[sp, #3080]

    ldr	x25,	[sp, #2792]

    mov	x28,	x23
    ldr	x19,	[sp, #3184]

    mov	x8,	x25
    mov	x6,	x28
    ldr	x14,	[sp, #3056]

    mov	x9,	x19
    add	x25,	sp,	#828
    ldr	x3,	[sp, #3040]

    mov	x18,	x14
    ldr	x13,	[sp, #2880]

    mov	x22,	x3
    mov	x20,	x13
    add	x3,	sp,	#832
    add	x13,	sp,	#896
    str	x20,	[sp, #5056]

    ldr	x2,	[sp, #2920]

    mov	x1,	x2
    str	x1,	[sp, #4440]

    ldr	x19,	[sp, #3064]

    mov	x2,	x19
    str	x2,	[sp, #4432]

    ldr	x20,	[sp, #2776]

    mov	x7,	x20
    add	x20,	sp,	#872
    str	x7,	[sp, #1824]

    ldr	x0,	[sp, #2904]

    mov	x27,	x0
    add	x0,	sp,	#824
    str	x27,	[sp, fp]

    movz	fp,	#5444
    ldr	x2,	[sp, #3152]

    mov	x4,	x2
    str	x4,	[sp, #4448]

    ldr	x16,	[sp, #3176]

    mov	x27,	x16
    add	x16,	sp,	#884
    str	x27,	[sp, #5072]

    ldr	x7,	[sp, #3200]

    mov	x12,	x7
    add	x7,	sp,	#836
    str	x12,	[sp, #1832]

    add	x12,	sp,	#864
    ldr	x2,	[sp, #3192]

    mov	x24,	x2
    str	x24,	[sp, #5064]

    str	x0,	[sp, #2384]

    add	x0,	sp,	#848
    str	x25,	[sp, fp]

    movz	fp,	#5468
    str	x3,	[sp, fp]

    add	x3,	sp,	#856
    movz	fp,	#5476
    str	x7,	[sp, fp]

    movz	fp,	#1924
    str	x10,	[sp, fp]

    movz	fp,	#2124
    add	x10,	sp,	#844
    str	x10,	[sp, fp]

    add	x10,	sp,	#860
    movz	fp,	#2164
    str	x0,	[sp, #2144]

    add	x0,	sp,	#888
    str	x21,	[sp, fp]

    movz	fp,	#2172
    str	x3,	[sp, fp]

    add	x3,	sp,	#876
    movz	fp,	#2188
    str	x10,	[sp, fp]

    movz	fp,	#2196
    mov	x10,	x9
    str	x12,	[sp, #2648]

    add	x12,	sp,	#880
    str	x5,	[sp, #1040]

    add	x5,	sp,	#892
    str	x20,	[sp, #1056]

    str	x3,	[sp, #1064]

    add	x3,	sp,	#900
    str	x12,	[sp, #2592]

    str	x16,	[sp, #2600]

    str	x0,	[sp, #2608]

    str	x5,	[sp, #2624]

    str	x13,	[sp, #2632]

    str	x3,	[sp, #2640]

    ldr	s11,	[sp, #1304]

    str	x6,	[sp, #4264]

    fmov	s13,	s11
    ldr	w0,	[sp, #3228]

    mov	w28,	w0
    str	w28,	[sp, #2584]

    ldr	x21,	[sp, #2656]

    mov	x1,	x21
    str	x1,	[sp, #4648]

    ldr	s9,	[sp, #1308]

    ldr	w3,	[sp, #3256]

    fmov	s7,	s9
    mov	w13,	w3
    str	w13,	[sp, #2588]

    ldr	s17,	[sp, #1312]

    ldr	s18,	[sp, #1316]

    ldr	x11,	[sp, #2664]

    fmov	s31,	s18
    mov	x15,	x11
    str	x15,	[sp, #2336]

    mov	x15,	x8
    str	x15,	[sp, #2304]

    ldr	w6,	[sp, #3240]

    mov	w0,	w6
    str	w0,	[sp, #1024]

    ldr	w3,	[sp, #3232]

    mov	w11,	w3
    str	w11,	[sp, #1028]

    ldr	x3,	[sp, #2672]

    mov	x8,	x3
    str	x8,	[sp, #2320]

    mov	x8,	x18
    str	x10,	[sp, #2288]

    str	x8,	[sp, #2232]

    ldr	w18,	[sp, #3220]

    mov	w25,	w18
    str	w25,	[sp, #2544]

    ldr	x8,	[sp, #2680]

    mov	x4,	x8
    str	x4,	[sp, #2248]

    ldr	x3,	[sp, #2688]

    mov	x12,	x3
    str	x12,	[sp, #2256]

    ldr	s19,	[sp, #1320]

    ldr	s12,	[sp, #1324]

    fmov	s18,	s19
    fmov	s19,	s12
    ldr	s12,	[sp, #1328]

    ldr	x9,	[sp, #2696]

    fmov	s22,	s12
    mov	x0,	x9
    str	x0,	[sp, #2272]

    ldr	w8,	[sp, #3212]

    mov	w6,	w8
    mov	x8,	x22
    str	w6,	[sp, #2564]

    ldr	s20,	[sp, #1332]

    ldr	s24,	[sp, #1336]

    fmov	s26,	s20
    ldr	s8,	[sp, #1340]

    fmov	s9,	s24
    str	x8,	[sp, fp]

    fmov	s1,	s8
    movz	fp,	#1940
    ldr	x15,	[sp, #2704]

    mov	x17,	x15
    str	x17,	[sp, #2216]

    ldr	x18,	[sp, #5056]

    mov	x5,	x18
    str	x5,	[sp, fp]

    movz	fp,	#5308
    ldr	x11,	[sp, #4440]

    str	x11,	[sp, fp]

    movz	fp,	#2092
    ldr	x18,	[sp, #2712]

    mov	x2,	x18
    str	x2,	[sp, fp]

    movz	fp,	#5292
    ldr	s23,	[sp, #1344]

    ldr	s29,	[sp, #1348]

    fmov	s4,	s23
    ldr	x3,	[sp, #4432]

    fmov	s30,	s29
    str	x3,	[sp, fp]

    movz	fp,	#5228
    ldr	w0,	[sp, #3208]

    mov	w1,	w0
    str	w1,	[sp, #2508]

    ldr	x28,	[sp, #2720]

    mov	x16,	x28
    str	x16,	[sp, fp]

    movz	fp,	#2116
    ldr	x4,	[sp, #2728]

    mov	x14,	x4
    str	x14,	[sp, fp]

    movz	fp,	#2084
    ldr	s24,	[sp, #1352]

    ldr	s11,	[sp, #1356]

    fmov	s5,	s24
    ldr	x25,	[sp, #1824]

    fmov	s28,	s11
    str	x25,	[sp, fp]

    movz	fp,	#4524
    ldr	x25,	[sp, fp]

    movz	fp,	#5244
    str	x25,	[sp, fp]

    movz	fp,	#3404
    ldr	w18,	[sp, #3244]

    mov	w8,	w18
    str	w8,	[sp, #2456]

    ldr	w19,	[sp, #3236]

    mov	w4,	w19
    str	w4,	[sp, #2468]

    ldr	s16,	[sp, #1360]

    fmov	s15,	s16
    ldr	s16,	[sp, #1364]

    ldr	x21,	[sp, #4448]

    fmov	s24,	s16
    str	x21,	[sp, fp]

    movz	fp,	#2068
    ldr	w19,	[sp, #3216]

    mov	w16,	w19
    str	w16,	[sp, #2432]

    ldr	x15,	[sp, #2736]

    mov	x16,	x15
    str	x16,	[sp, fp]

    movz	fp,	#5252
    ldr	w12,	[sp, #3224]

    mov	w24,	w12
    str	w24,	[sp, #2436]

    ldr	x2,	[sp, #5072]

    str	x2,	[sp, fp]

    movz	fp,	#3388
    ldr	x12,	[sp, #1832]

    str	x12,	[sp, fp]

    movz	fp,	#3420
    ldr	s11,	[sp, #1372]

    ldr	s8,	[sp, #1376]

    fmov	s29,	s11
    ldr	x4,	[sp, #2744]

    fmov	s6,	s8
    mov	x2,	x4
    str	x2,	[sp, fp]

    movz	fp,	#2052
    ldr	w9,	[sp, #3252]

    mov	w5,	w9
    str	w5,	[sp, #2412]

    ldr	x7,	[sp, #5064]

    str	x7,	[sp, fp]

    movz	fp,	#1844
    ldr	x13,	[sp, #2752]

    mov	x21,	x13
    str	x21,	[sp, fp]

    movz	fp,	#1900
    ldr	s25,	[sp, #1380]

    ldr	w5,	[sp, #3256]

    fmov	s21,	s25
    mov	w24,	w5
    str	w24,	[sp, #2400]

    ldr	s27,	[sp, #1388]

    ldr	x21,	[sp, #2760]

    fmov	s16,	s27
    mov	x9,	x21
    str	x9,	[sp, #2040]

    ldr	x3,	[sp, #2768]

    mov	x5,	x3
    str	x5,	[sp, fp]

    ldr	s2,	[sp, #1392]

    ldr	w25,	[sp, #3248]

    mov	w3,	w25
    str	w3,	[sp, #2488]


main_717:
    ldr	w7,	[sp, #3260]

    movz	fp,	#2092
    ldr	x27,	[sp, #4648]

    lsl	w19,	w7,	#2
    add	x10,	x27,	x19
    ldr	s3,	[x10]

    fadd	s23,	s13,	s3
    fadd	s23,	s23,	s7
    fadd	s23,	s23,	s17
    str	s23,	[sp, #1696]

    ldr	w5,	[sp, #3260]

    ldr	x4,	[sp, #2336]

    lsl	w17,	w5,	#2
    add	x17,	x4,	x17
    ldr	s8,	[x17]

    ldr	w7,	[sp, #3260]

    fadd	s12,	s31,	s8
    ldr	x13,	[sp, #2320]

    lsl	w25,	w7,	#2
    add	x26,	x13,	x25
    ldr	s23,	[x26]

    ldr	w10,	[sp, #3260]

    fadd	s23,	s12,	s23
    ldr	x9,	[sp, #2248]

    lsl	w18,	w10,	#2
    add	x15,	x9,	x18
    ldr	s3,	[x15]

    fadd	s27,	s23,	s3
    str	s27,	[sp, #1700]

    ldr	w12,	[sp, #3260]

    ldr	x18,	[sp, #2256]

    lsl	w17,	w12,	#2
    add	x7,	x18,	x17
    ldr	s27,	[x7]

    fadd	s8,	s27,	s18
    fadd	s3,	s8,	s19
    fadd	s23,	s3,	s22
    str	s23,	[sp, #1704]

    ldr	w13,	[sp, #3260]

    ldr	x12,	[sp, #2272]

    lsl	w25,	w13,	#2
    add	x24,	x12,	x25
    ldr	s8,	[x24]

    fadd	s23,	s8,	s26
    fadd	s27,	s23,	s9
    fadd	s27,	s27,	s1
    str	s27,	[sp, #1708]

    ldr	w4,	[sp, #3260]

    ldr	x24,	[sp, #2216]

    lsl	w12,	w4,	#2
    add	x12,	x24,	x12
    ldr	s3,	[x12]

    ldr	w5,	[sp, #3260]

    ldr	x6,	[sp, fp]

    lsl	w16,	w5,	#2
    movz	fp,	#5228
    add	x17,	x6,	x16
    ldr	s23,	[x17]

    fadd	s27,	s3,	s23
    fadd	s3,	s15,	s24
    fadd	s8,	s27,	s4
    fadd	s27,	s8,	s30
    str	s27,	[sp, #1716]

    ldr	w7,	[sp, #3260]

    ldr	x19,	[sp, fp]

    lsl	w26,	w7,	#2
    movz	fp,	#2116
    add	x10,	x19,	x26
    ldr	s12,	[x10]

    ldr	w9,	[sp, #3260]

    ldr	x19,	[sp, fp]

    lsl	w12,	w9,	#2
    movz	fp,	#2068
    add	x17,	x19,	x12
    ldr	s27,	[x17]

    fadd	s8,	s12,	s27
    fadd	s8,	s8,	s5
    fadd	s23,	s8,	s28
    str	s23,	[sp, #1712]

    ldr	w13,	[sp, #3260]

    ldr	x21,	[sp, fp]

    lsl	w7,	w13,	#2
    movz	fp,	#3420
    add	x17,	x21,	x7
    ldr	s8,	[x17]

    fadd	s27,	s3,	s8
    fadd	s8,	s27,	s29
    str	s8,	[sp, #1084]

    ldr	w14,	[sp, #3260]

    ldr	x3,	[sp, fp]

    lsl	w13,	w14,	#2
    movz	fp,	#1844
    add	x24,	x3,	x13
    ldr	s27,	[x24]

    ldr	w15,	[sp, #3260]

    fadd	s8,	s6,	s27
    ldr	x18,	[sp, fp]

    lsl	w3,	w15,	#2
    movz	fp,	#1900
    add	x18,	x18,	x3
    ldr	s3,	[x18]

    fadd	s8,	s8,	s3
    fadd	s3,	s8,	s21
    str	s3,	[sp, #1120]

    ldr	w16,	[sp, #3260]

    ldr	x9,	[sp, #2040]

    lsl	w19,	w16,	#2
    add	x17,	x9,	x19
    ldr	s8,	[x17]

    ldr	w18,	[sp, #3260]

    fadd	s27,	s16,	s8
    ldr	x7,	[sp, fp]

    lsl	w25,	w18,	#2
    movz	fp,	#5444
    add	x18,	x7,	x25
    ldr	s23,	[x18]

    fadd	s27,	s27,	s23
    fadd	s8,	s27,	s2
    str	s8,	[sp, #1196]

    ldr	s27,	[sp, #1696]

    ldr	x5,	[sp, #2384]

    str	s27,	[x5]

    ldr	s8,	[sp, #1700]

    ldr	x14,	[sp, fp]

    movz	fp,	#5468
    str	s8,	[x14]

    ldr	s27,	[sp, #1704]

    ldr	x23,	[sp, fp]

    movz	fp,	#5476
    str	s27,	[x23]

    ldr	s8,	[sp, #1708]

    ldr	x26,	[sp, fp]

    movz	fp,	#1924
    str	s8,	[x26]

    ldr	s8,	[sp, #1716]

    ldr	x14,	[sp, fp]

    movz	fp,	#2124
    str	s8,	[x14]

    ldr	s27,	[sp, #1712]

    ldr	x13,	[sp, fp]

    movz	fp,	#2164
    str	s27,	[x13]

    movi	v27.4s,	#0
    ldr	s23,	[sp, #1084]

    ldr	x5,	[sp, #2144]

    str	s23,	[x5]

    ldr	s23,	[sp, #1120]

    ldr	x3,	[sp, fp]

    movz	fp,	#2172
    str	s23,	[x3]

    ldr	s23,	[sp, #1196]

    ldr	x10,	[sp, fp]

    movz	fp,	#2188
    str	s23,	[x10]

    ldr	x14,	[sp, fp]

    movz	fp,	#2196
    str	s27,	[x14]

    ldr	w4,	[sp, #3260]

    ldr	x7,	[sp, #4264]

    lsl	w5,	w4,	#2
    add	x17,	x7,	x5
    ldr	w14,	[x17]

    ldr	w13,	[sp, #2584]

    ldr	w5,	[sp, #2588]

    add	w12,	w5,	w13
    add	w7,	w12,	w14
    str	w7,	[sp, #1968]

    ldr	w4,	[sp, #3260]

    ldr	x18,	[sp, #2304]

    lsl	w2,	w4,	#2
    add	x17,	x18,	x2
    ldr	w24,	[x17]

    ldr	w7,	[sp, #1024]

    ldr	w28,	[sp, #1028]

    add	w12,	w28,	w7
    add	w17,	w12,	w24
    str	w17,	[sp, #2012]

    ldr	w5,	[sp, #3260]

    ldr	x15,	[sp, #2288]

    lsl	w18,	w5,	#2
    add	x13,	x15,	x18
    ldr	w17,	[x13]

    ldr	w7,	[sp, #3260]

    ldr	x4,	[sp, #2232]

    lsl	w13,	w7,	#2
    add	x18,	x4,	x13
    ldr	w12,	[x18]

    ldr	w14,	[sp, #2544]

    add	w15,	w17,	w14
    add	w5,	w15,	w12
    str	w5,	[sp, #1896]

    ldr	w12,	[sp, #3260]

    ldr	x15,	[sp, fp]

    lsl	w2,	w12,	#2
    movz	fp,	#1940
    add	x17,	x15,	x2
    ldr	w10,	[x17]

    ldr	w14,	[sp, #2564]

    ldr	w13,	[sp, #3260]

    add	w26,	w10,	w14
    ldr	x23,	[sp, fp]

    lsl	w24,	w13,	#2
    movz	fp,	#5308
    add	x16,	x23,	x24
    movz	w24,	#0
    ldr	w15,	[x16]

    add	w9,	w26,	w15
    str	w9,	[sp, #1892]

    ldr	w14,	[sp, #3260]

    ldr	x12,	[sp, fp]

    lsl	w17,	w14,	#2
    movz	fp,	#5292
    add	x10,	x12,	x17
    ldr	w5,	[x10]

    ldr	w15,	[sp, #3260]

    ldr	x4,	[sp, fp]

    lsl	w14,	w15,	#2
    movz	fp,	#2084
    add	x3,	x4,	x14
    ldr	w18,	[x3]

    ldr	w12,	[sp, #2508]

    add	w10,	w5,	w12
    add	w21,	w10,	w18
    str	w21,	[sp, #2024]

    ldr	w17,	[sp, #3260]

    ldr	x26,	[sp, fp]

    lsl	w10,	w17,	#2
    movz	fp,	#5244
    add	x16,	x26,	x10
    ldr	w13,	[x16]

    ldr	w18,	[sp, #3260]

    ldr	x26,	[sp, fp]

    lsl	w5,	w18,	#2
    movz	fp,	#3404
    add	x26,	x26,	x5
    ldr	w12,	[x26]

    ldr	w5,	[sp, #2456]

    add	w23,	w13,	w5
    add	w3,	w23,	w12
    str	w3,	[sp, #2020]

    ldr	w19,	[sp, #3260]

    ldr	x22,	[sp, fp]

    lsl	w26,	w19,	#2
    movz	fp,	#5252
    add	x17,	x22,	x26
    ldr	w13,	[x17]

    ldr	w5,	[sp, #2432]

    ldr	w4,	[sp, #2468]

    add	w7,	w5,	w4
    add	w23,	w7,	w13
    str	w23,	[sp, #1888]

    ldr	w21,	[sp, #3260]

    ldr	x3,	[sp, fp]

    lsl	w18,	w21,	#2
    movz	fp,	#3388
    add	x14,	x3,	x18
    ldr	w13,	[x14]

    ldr	w15,	[sp, #2436]

    ldr	w4,	[sp, #3260]

    add	w26,	w13,	w15
    lsl	w2,	w4,	#2
    ldr	x13,	[sp, fp]

    movz	fp,	#2052
    add	x17,	x13,	x2
    ldr	w10,	[x17]

    add	w13,	w26,	w10
    str	w13,	[sp, #5052]

    ldr	w2,	[sp, #3260]

    ldr	x8,	[sp, fp]

    lsl	w25,	w2,	#2
    add	x16,	x8,	x25
    ldr	w7,	[x16]

    ldr	w14,	[sp, #2400]

    ldr	w5,	[sp, #2412]

    ldr	w15,	[sp, #2488]

    add	w2,	w14,	w5
    add	w25,	w2,	w15
    add	w19,	w25,	w7
    str	w19,	[sp, #4520]

    ldr	w7,	[sp, #1968]

    ldr	x15,	[sp, #2648]

    str	w7,	[x15]

    ldr	w7,	[sp, #2012]

    ldr	x12,	[sp, #1040]

    str	w7,	[x12]

    ldr	w4,	[sp, #1896]

    ldr	x2,	[sp, #1056]

    str	w4,	[x2]

    ldr	w15,	[sp, #1892]

    ldr	x9,	[sp, #1064]

    str	w15,	[x9]

    ldr	w12,	[sp, #2024]

    ldr	x15,	[sp, #2592]

    str	w12,	[x15]

    mov	w12,	w24
    ldr	w5,	[sp, #2020]

    fcvtzs	w24,	s2
    ldr	x21,	[sp, #2600]

    str	w5,	[x21]

    ldr	w13,	[sp, #1888]

    ldr	x4,	[sp, #2608]

    str	w13,	[x4]

    ldr	x13,	[sp, #2624]

    ldr	w14,	[sp, #5052]

    str	w14,	[x13]

    ldr	x18,	[sp, #2632]

    ldr	w20,	[sp, #4520]

    str	w20,	[x18]

    ldr	x15,	[sp, #2640]

    str	w12,	[x15]

    ldr	w3,	[sp, #2488]

    ldr	w7,	[sp, #2488]

    scvtf	s8,	w3
    cmp	w7,	#0
    beq	main_716

main_889:
    movz	w0,	#10
    ldr	x1,	[sp, #2384]

    bl	putfarray
    ldr	x1,	[sp, #2648]

    movz	w0,	#10
    bl	putarray
    ldr	w20,	[sp, #1968]

    scvtf	s12,	w20
    str	s12,	[sp, #1108]

    ldr	s13,	[sp, #1108]

    ldr	s8,	[sp, #1696]

    ldr	x20,	[sp, #2648]

    fsub	s9,	s13,	s8
    fcvtzs	w25,	s9
    str	w25,	[x20]

    ldr	w19,	[sp, #2012]

    ldr	s8,	[sp, #1700]

    scvtf	s9,	w19
    ldr	x18,	[sp, #1040]

    fsub	s9,	s9,	s8
    fcvtzs	w21,	s9
    str	w21,	[x18]

    ldr	w27,	[sp, #1896]

    ldr	s8,	[sp, #1704]

    scvtf	s9,	w27
    ldr	x27,	[sp, #1056]

    fsub	s12,	s9,	s8
    fcvtzs	w26,	s12
    str	w26,	[x27]

    ldr	w24,	[sp, #1892]

    ldr	s8,	[sp, #1708]

    scvtf	s13,	w24
    ldr	x18,	[sp, #1064]

    movz	w24,	#0
    fsub	s9,	s13,	s8
    fcvtzs	w20,	s9
    str	w20,	[x18]

    ldr	w26,	[sp, #2024]

    scvtf	s12,	w26
    ldr	s8,	[sp, #1716]

    fsub	s13,	s12,	s8
    ldr	x18,	[sp, #2592]

    fcvtzs	w21,	s13
    str	w21,	[x18]

    ldr	w25,	[sp, #2020]

    scvtf	s12,	w25
    ldr	s13,	[sp, #1712]

    fsub	s12,	s12,	s13
    ldr	x21,	[sp, #2600]

    fcvtzs	w26,	s12
    str	w26,	[x21]

    ldr	w20,	[sp, #1888]

    ldr	s11,	[sp, #1084]

    scvtf	s13,	w20
    ldr	x28,	[sp, #2608]

    fsub	s11,	s13,	s11
    fcvtzs	w18,	s11
    str	w18,	[x28]

    ldr	w26,	[sp, #5052]

    scvtf	s8,	w26
    ldr	s9,	[sp, #1120]

    ldr	x20,	[sp, #2624]

    fsub	s12,	s8,	s9
    fcvtzs	w25,	s12
    str	w25,	[x20]

    ldr	w26,	[sp, #4520]

    scvtf	s13,	w26
    ldr	s11,	[sp, #1196]

    ldr	x26,	[sp, #2632]

    fsub	s11,	s13,	s11
    fcvtzs	w18,	s11
    str	w18,	[x26]

    ldr	x18,	[sp, #2640]

    str	w24,	[x18]

    ldr	w22,	[sp, #3260]

    lsl	w27,	w22,	#2
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#864
    ldr	w28,	[x26]

    ldr	s12,	[sp, #1196]

    scvtf	s13,	w28
    ldr	s0,	[sp, #1300]

    fmul	s11,	s13,	s12
    fcvtzs	w27,	s11
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s10
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
    
    movz	fp,	#12384
    add	sp, sp, fp
    ret


main_716:
    ldr	x19,	[sp, #2648]

    fmov	s2,	s8
    mov	w12,	w24
    movz	fp,	#6540
    mov	x8,	x19
    str	x8,	[sp, #4264]

    ldr	x9,	[sp, #2384]

    mov	x0,	x9
    str	x0,	[sp, #4648]

    str	w12,	[sp, #2488]

    ldr	w21,	[sp, #2584]

    ldr	w27,	[sp, #6592]

    ldr	w0,	[sp, #6592]

    mov	w21,	w27
    str	w0,	[sp, #2584]

    ldr	w9,	[sp, #2588]

    ldr	w2,	[sp, #6596]

    ldr	w3,	[sp, #6596]

    mov	w9,	w2
    str	w3,	[sp, #2588]

    ldr	x5,	[sp, #2336]

    ldr	x19,	[sp, fp]

    movz	fp,	#6540
    mov	x5,	x19
    ldr	x20,	[sp, fp]

    movz	fp,	#6524
    str	x20,	[sp, #2336]

    ldr	x24,	[sp, #2304]

    ldr	x13,	[sp, fp]

    movz	fp,	#6524
    mov	x24,	x13
    ldr	x14,	[sp, fp]

    movz	fp,	#6532
    str	x14,	[sp, #2304]

    ldr	w4,	[sp, #1024]

    ldr	w21,	[sp, #6584]

    ldr	w22,	[sp, #6584]

    mov	w4,	w21
    str	w22,	[sp, #1024]

    ldr	w16,	[sp, #1028]

    ldr	w24,	[sp, #6588]

    ldr	w25,	[sp, #6588]

    mov	w16,	w24
    str	w25,	[sp, #1028]

    ldr	x5,	[sp, #2320]

    ldr	x16,	[sp, fp]

    movz	fp,	#6532
    mov	x5,	x16
    ldr	x17,	[sp, fp]

    movz	fp,	#6516
    str	x17,	[sp, #2320]

    ldr	x4,	[sp, #2288]

    ldr	x10,	[sp, fp]

    movz	fp,	#6516
    mov	x4,	x10
    ldr	x11,	[sp, fp]

    movz	fp,	#6484
    str	x11,	[sp, #2288]

    ldr	x13,	[sp, #2232]

    ldr	x26,	[sp, fp]

    movz	fp,	#6484
    mov	x13,	x26
    ldr	x27,	[sp, fp]

    movz	fp,	#6492
    str	x27,	[sp, #2232]

    ldr	w15,	[sp, #2544]

    ldr	w15,	[sp, #6576]

    ldr	w16,	[sp, #6576]

    str	w16,	[sp, #2544]

    ldr	x13,	[sp, #2248]

    ldr	x1,	[sp, fp]

    movz	fp,	#6492
    mov	x13,	x1
    ldr	x2,	[sp, fp]

    movz	fp,	#6500
    str	x2,	[sp, #2248]

    ldr	x23,	[sp, #2256]

    ldr	x4,	[sp, fp]

    movz	fp,	#6500
    mov	x23,	x4
    ldr	x5,	[sp, fp]

    movz	fp,	#6508
    str	x5,	[sp, #2256]

    ldr	x4,	[sp, #2272]

    ldr	x7,	[sp, fp]

    movz	fp,	#6508
    mov	x4,	x7
    ldr	x8,	[sp, fp]

    movz	fp,	#2196
    str	x8,	[sp, #2272]

    ldr	w23,	[sp, #2564]

    ldr	w18,	[sp, #6580]

    ldr	w19,	[sp, #6580]

    mov	w23,	w18
    str	w19,	[sp, #2564]

    ldr	x4,	[sp, fp]

    movz	fp,	#6468
    ldr	x20,	[sp, fp]

    movz	fp,	#6468
    mov	x4,	x20
    ldr	x21,	[sp, fp]

    movz	fp,	#2196
    str	x21,	[sp, fp]

    movz	fp,	#6476
    ldr	x4,	[sp, #2216]

    ldr	x23,	[sp, fp]

    movz	fp,	#6476
    mov	x4,	x23
    ldr	x24,	[sp, fp]

    movz	fp,	#1940
    str	x24,	[sp, #2216]

    ldr	x16,	[sp, fp]

    movz	fp,	#6460
    ldr	x17,	[sp, fp]

    movz	fp,	#6460
    mov	x16,	x17
    ldr	x18,	[sp, fp]

    movz	fp,	#1940
    str	x18,	[sp, fp]

    movz	fp,	#5308
    ldr	x13,	[sp, fp]

    movz	fp,	#5308
    ldr	x13,	[sp, #6816]

    ldr	x24,	[sp, #6816]

    str	x24,	[sp, fp]

    movz	fp,	#2092
    ldr	x4,	[sp, fp]

    movz	fp,	#2092
    ldr	x14,	[sp, #6792]

    ldr	x15,	[sp, #6792]

    mov	x4,	x14
    str	x15,	[sp, fp]

    movz	fp,	#5292
    ldr	x5,	[sp, fp]

    movz	fp,	#5292
    ldr	x5,	[sp, #6808]

    ldr	x21,	[sp, #6808]

    str	x21,	[sp, fp]

    movz	fp,	#5228
    ldr	w19,	[sp, #2508]

    ldr	w12,	[sp, #6572]

    ldr	w13,	[sp, #6572]

    mov	w19,	w12
    str	w13,	[sp, #2508]

    ldr	x18,	[sp, fp]

    movz	fp,	#5228
    ldr	x18,	[sp, #6744]

    ldr	x26,	[sp, #6744]

    str	x26,	[sp, fp]

    movz	fp,	#2116
    ldr	x16,	[sp, fp]

    movz	fp,	#2116
    ldr	x16,	[sp, #6800]

    ldr	x18,	[sp, #6800]

    str	x18,	[sp, fp]

    movz	fp,	#2084
    ldr	x27,	[sp, fp]

    movz	fp,	#2084
    ldr	x27,	[sp, #6784]

    ldr	x12,	[sp, #6784]

    str	x12,	[sp, fp]

    movz	fp,	#5244
    ldr	x27,	[sp, fp]

    movz	fp,	#5244
    ldr	x27,	[sp, #6752]

    ldr	x0,	[sp, #6752]

    str	x0,	[sp, fp]

    movz	fp,	#3404
    ldr	w16,	[sp, #2456]

    ldr	w6,	[sp, #6564]

    ldr	w7,	[sp, #6564]

    mov	w16,	w6
    str	w7,	[sp, #2456]

    ldr	w9,	[sp, #2468]

    ldr	w9,	[sp, #6568]

    ldr	w10,	[sp, #6568]

    str	w10,	[sp, #2468]

    ldr	x23,	[sp, fp]

    movz	fp,	#3404
    ldr	x23,	[sp, #6728]

    ldr	x20,	[sp, #6728]

    str	x20,	[sp, fp]

    movz	fp,	#2068
    ldr	w21,	[sp, #2432]

    ldr	w0,	[sp, #6556]

    ldr	w1,	[sp, #6556]

    mov	w21,	w0
    str	w1,	[sp, #2432]

    ldr	x18,	[sp, fp]

    movz	fp,	#2068
    ldr	x18,	[sp, #6776]

    ldr	x9,	[sp, #6776]

    str	x9,	[sp, fp]

    movz	fp,	#5252
    ldr	w4,	[sp, #2436]

    ldr	w3,	[sp, #6560]

    mov	w4,	w3
    ldr	w4,	[sp, #6560]

    str	w4,	[sp, #2436]

    ldr	x4,	[sp, fp]

    movz	fp,	#5252
    ldr	x4,	[sp, #6760]

    ldr	x3,	[sp, #6760]

    str	x3,	[sp, fp]

    movz	fp,	#3388
    ldr	x14,	[sp, fp]

    movz	fp,	#3388
    ldr	x14,	[sp, #6720]

    ldr	x17,	[sp, #6720]

    str	x17,	[sp, fp]

    movz	fp,	#3420
    ldr	x4,	[sp, fp]

    movz	fp,	#3420
    ldr	x4,	[sp, #6736]

    ldr	x23,	[sp, #6736]

    str	x23,	[sp, fp]

    movz	fp,	#2052
    ldr	w9,	[sp, #2412]

    ldr	w25,	[sp, #6552]

    ldr	w26,	[sp, #6552]

    mov	w9,	w25
    str	w26,	[sp, #2412]

    ldr	x9,	[sp, fp]

    movz	fp,	#2052
    ldr	x9,	[sp, #6768]

    ldr	x6,	[sp, #6768]

    str	x6,	[sp, fp]

    movz	fp,	#1844
    ldr	x4,	[sp, fp]

    movz	fp,	#6436
    ldr	x8,	[sp, fp]

    movz	fp,	#6436
    mov	x4,	x8
    ldr	x9,	[sp, fp]

    movz	fp,	#1844
    str	x9,	[sp, fp]

    movz	fp,	#6444
    ldr	w3,	[sp, #2400]

    ldr	w22,	[sp, #6548]

    ldr	w23,	[sp, #6548]

    mov	w3,	w22
    str	w23,	[sp, #2400]

    ldr	x16,	[sp, #2040]

    ldr	x11,	[sp, fp]

    movz	fp,	#6444
    mov	x16,	x11
    ldr	x12,	[sp, fp]

    movz	fp,	#1900
    str	x12,	[sp, #2040]

    ldr	x9,	[sp, fp]

    movz	fp,	#6452
    ldr	x14,	[sp, fp]

    movz	fp,	#6452
    mov	x9,	x14
    ldr	x15,	[sp, fp]

    movz	fp,	#1900
    str	x15,	[sp, fp]

    b	main_717

main_517:
    ldr	x22,	[sp, #2576]

    movz	fp,	#5756
    mov	x3,	x22
    str	x3,	[sp, fp]

    movz	fp,	#2548
    ldr	x9,	[sp, #1048]

    mov	x25,	x9
    str	x25,	[sp, #2576]

    ldr	x0,	[sp, #1032]

    mov	x10,	x0
    str	x10,	[sp, #1048]

    ldr	x13,	[sp, #2536]

    mov	x1,	x13
    str	x1,	[sp, #1032]

    ldr	x25,	[sp, fp]

    movz	fp,	#2548
    mov	x14,	x25
    str	x14,	[sp, #2536]

    ldr	x4,	[sp, #2568]

    mov	x26,	x4
    str	x26,	[sp, fp]

    movz	fp,	#2556
    ldr	x9,	[sp, fp]

    movz	fp,	#2556
    mov	x5,	x9
    str	x5,	[sp, #2568]

    ldr	x14,	[sp, #1016]

    mov	x10,	x14
    str	x10,	[sp, fp]

    movz	fp,	#2404
    ldr	x8,	[sp, #2528]

    mov	x15,	x8
    str	x15,	[sp, #1016]

    ldr	x3,	[sp, #2424]

    mov	x9,	x3
    str	x9,	[sp, #2528]

    ldr	x17,	[sp, fp]

    movz	fp,	#2404
    mov	x4,	x17
    str	x4,	[sp, #2424]

    ldr	x0,	[sp, #2416]

    mov	x18,	x0
    str	x18,	[sp, fp]

    movz	fp,	#2180
    ldr	x7,	[sp, #2392]

    mov	x1,	x7
    str	x1,	[sp, #2416]

    ldr	x0,	[sp, #2376]

    mov	x8,	x0
    str	x8,	[sp, #2392]

    ldr	x11,	[sp, #2352]

    mov	x0,	x11
    str	x0,	[sp, #2376]

    ldr	x16,	[sp, #2360]

    mov	x12,	x16
    str	x12,	[sp, #2352]

    ldr	x23,	[sp, #2368]

    mov	x17,	x23
    str	x17,	[sp, #2360]

    ldr	x6,	[sp, #2344]

    mov	x24,	x6
    str	x24,	[sp, #2368]

    ldr	x5,	[sp, #2296]

    mov	x7,	x5
    str	x7,	[sp, #2344]

    ldr	x15,	[sp, #2312]

    mov	x6,	x15
    str	x6,	[sp, #2296]

    ldr	x28,	[sp, #2328]

    mov	x16,	x28
    str	x16,	[sp, #2312]

    ldr	x26,	[sp, #2280]

    mov	x0,	x26
    str	x0,	[sp, #2328]

    ldr	x14,	[sp, #2264]

    mov	x28,	x14
    str	x28,	[sp, #2280]

    ldr	x1,	[sp, #2240]

    mov	x15,	x1
    str	x15,	[sp, #2264]

    ldr	x8,	[sp, #2208]

    mov	x0,	x8
    str	x0,	[sp, #2240]

    ldr	x18,	[sp, #2224]

    mov	x9,	x18
    str	x9,	[sp, #2208]

    ldr	x23,	[sp, fp]

    movz	fp,	#2180
    mov	x19,	x23
    str	x19,	[sp, #2224]

    ldr	x15,	[sp, #1952]

    mov	x24,	x15
    str	x24,	[sp, fp]

    movz	fp,	#2156
    ldr	x0,	[sp, #2136]

    mov	x16,	x0
    str	x16,	[sp, #1952]

    ldr	x10,	[sp, fp]

    movz	fp,	#1932
    mov	x0,	x10
    str	x0,	[sp, #2136]

    ldr	x0,	[sp, fp]

    movz	fp,	#2156
    mov	x11,	x0
    str	x11,	[sp, fp]

    movz	fp,	#1980
    ldr	x6,	[sp, fp]

    movz	fp,	#1932
    mov	x1,	x6
    str	x1,	[sp, fp]

    movz	fp,	#1980
    ldr	x16,	[sp, #1992]

    mov	x7,	x16
    str	x7,	[sp, fp]

    movz	fp,	#1972
    ldr	x23,	[sp, #2000]

    mov	x17,	x23
    str	x17,	[sp, #1992]

    ldr	x1,	[sp, fp]

    movz	fp,	#1972
    mov	x24,	x1
    str	x24,	[sp, #2000]

    ldr	x23,	[sp, #1960]

    mov	x2,	x23
    str	x2,	[sp, fp]

    movz	fp,	#1908
    ldr	x8,	[sp, fp]

    movz	fp,	#1908
    mov	x24,	x8
    str	x24,	[sp, #1960]

    ldr	x19,	[sp, #2032]

    mov	x9,	x19
    str	x9,	[sp, fp]

    movz	fp,	#1852
    ldr	x5,	[sp, fp]

    movz	fp,	#1852
    mov	x20,	x5
    str	x20,	[sp, #2032]

    ldr	x23,	[sp, #2616]

    mov	x6,	x23
    str	x6,	[sp, fp]

    b	main_518

main_308:
    ldr	w8,	[sp, #5736]

    mov	w16,	w8
    str	w16,	[sp, #2152]

    ldr	w26,	[sp, #5708]

    ldr	w13,	[sp, #8292]

    ldr	w14,	[sp, #8292]

    mov	w26,	w13
    str	w14,	[sp, #5708]

    ldr	w0,	[sp, #5732]

    ldr	w0,	[sp, #8376]

    ldr	w0,	[sp, #8376]

    str	w0,	[sp, #5732]

    ldr	w7,	[sp, #5736]

    ldr	w2,	[sp, #8380]

    ldr	w3,	[sp, #8380]

    mov	w7,	w2
    str	w3,	[sp, #5736]

    ldr	w3,	[sp, #5712]

    ldr	w16,	[sp, #8296]

    ldr	w17,	[sp, #8296]

    mov	w3,	w16
    str	w17,	[sp, #5712]

    ldr	w4,	[sp, #5716]

    ldr	w20,	[sp, #8364]

    ldr	w21,	[sp, #8364]

    mov	w4,	w20
    str	w21,	[sp, #5716]

    ldr	w0,	[sp, #1948]

    ldr	w1,	[sp, #6432]

    ldr	w20,	[sp, #6432]

    mov	w0,	w1
    str	w20,	[sp, #1948]

    ldr	s21,	[sp, #1624]

    str	s9,	[sp, #1624]

    fmov	s21,	s9
    ldr	w27,	[sp, #8980]

    ldr	w19,	[sp, #12356]

    ldr	w20,	[sp, #12356]

    mov	w27,	w19
    str	w20,	[sp, #8980]

    ldr	s7,	[sp, #1648]

    str	s11,	[sp, #1648]

    fmov	s7,	s11
    ldr	w1,	[sp, #1988]

    ldr	w3,	[sp, #6428]

    ldr	w14,	[sp, #6428]

    mov	w1,	w3
    str	w14,	[sp, #1988]

    ldr	s15,	[sp, #1628]

    str	s14,	[sp, #1628]

    fmov	s15,	s14
    ldr	s21,	[sp, #1644]

    str	s14,	[sp, #1644]

    fmov	s21,	s14
    ldr	w2,	[sp, #8984]

    ldr	w22,	[sp, #12324]

    ldr	w23,	[sp, #12324]

    mov	w2,	w22
    str	w23,	[sp, #8984]

    ldr	s15,	[sp, #1640]

    str	s9,	[sp, #1640]

    fmov	s15,	s9
    ldr	w26,	[sp, #5744]

    ldr	w8,	[sp, #8388]

    ldr	w9,	[sp, #8388]

    mov	w26,	w8
    str	w9,	[sp, #5744]

    ldr	w16,	[sp, #5764]

    ldr	w14,	[sp, #8396]

    ldr	w15,	[sp, #8396]

    mov	w16,	w14
    str	w15,	[sp, #5764]

    ldr	s15,	[sp, #1608]

    str	s9,	[sp, #1608]

    fmov	s15,	s9
    ldr	s24,	[sp, #1076]

    str	s14,	[sp, #1076]

    fmov	s24,	s14
    ldr	s21,	[sp, #1612]

    str	s14,	[sp, #1612]

    fmov	s21,	s14
    ldr	s7,	[sp, #1616]

    str	s11,	[sp, #1616]

    fmov	s7,	s11
    ldr	w13,	[sp, #5720]

    ldr	w23,	[sp, #8368]

    ldr	w24,	[sp, #8368]

    mov	w13,	w23
    str	w24,	[sp, #5720]

    ldr	s21,	[sp, #1156]

    str	s9,	[sp, #1156]

    fmov	s21,	s9
    ldr	w4,	[sp, #2016]

    ldr	w25,	[sp, #6420]

    ldr	w3,	[sp, #6420]

    mov	w4,	w25
    str	w3,	[sp, #2016]

    ldr	s3,	[sp, #1724]

    str	s14,	[sp, #1724]

    fmov	s3,	s14
    ldr	s15,	[sp, #1116]

    str	s11,	[sp, #1116]

    fmov	s15,	s11
    ldr	w8,	[sp, #1920]

    ldr	w28,	[sp, #6424]

    mov	w8,	w28
    ldr	w8,	[sp, #6424]

    str	w8,	[sp, #1920]

    ldr	w24,	[sp, #5724]

    ldr	w26,	[sp, #8372]

    ldr	w27,	[sp, #8372]

    mov	w24,	w26
    str	w27,	[sp, #5724]

    ldr	w16,	[sp, #5740]

    ldr	w5,	[sp, #8384]

    ldr	w6,	[sp, #8384]

    mov	w16,	w5
    str	w6,	[sp, #5740]

    ldr	s21,	[sp, #1148]

    str	s14,	[sp, #1148]

    fmov	s21,	s14
    ldr	w7,	[sp, #8988]

    ldr	w25,	[sp, #12328]

    ldr	w26,	[sp, #12328]

    mov	w7,	w25
    str	w26,	[sp, #8988]

    ldr	w3,	[sp, #5748]

    ldr	w11,	[sp, #8392]

    ldr	w12,	[sp, #8392]

    mov	w3,	w11
    str	w12,	[sp, #5748]

    ldr	s7,	[sp, #1112]

    str	s11,	[sp, #1112]

    fmov	s7,	s11
    ldr	s21,	[sp, #1092]

    str	s9,	[sp, #1092]

    fmov	s21,	s9
    ldr	w22,	[sp, #8976]

    ldr	w16,	[sp, #9680]

    ldr	w17,	[sp, #9680]

    mov	w22,	w16
    str	w17,	[sp, #8976]

    ldr	w17,	[sp, #6404]

    ldr	w21,	[sp, #8404]

    ldr	w22,	[sp, #8404]

    mov	w17,	w21
    str	w22,	[sp, #6404]

    ldr	w26,	[sp, #5768]

    ldr	w17,	[sp, #8400]

    ldr	w19,	[sp, #8400]

    mov	w26,	w17
    str	w19,	[sp, #5768]

    ldr	s15,	[sp, #1176]

    str	s11,	[sp, #1176]

    fmov	s15,	s11
    ldr	w10,	[sp, #8288]

    ldr	w28,	[sp, #12332]

    ldr	w0,	[sp, #12332]

    mov	w10,	w28
    str	w0,	[sp, #8288]

    ldr	s21,	[sp, #1072]

    str	s14,	[sp, #1072]

    fmov	s21,	s14
    ldr	s21,	[sp, #1168]

    str	s9,	[sp, #1168]

    fmov	s21,	s9
    b	main_309

main_305:
    ldr	s26,	[sp, #1080]

    fmov	s29,	s10
    fadd	s18,	s26,	s16
    fmov	s10,	s12
    fadd	s26,	s18,	s8
    fmov	s21,	s26
    fmov	s18,	s16
    fmov	s16,	s8
    str	s18,	[sp, #1080]

    fmov	s8,	s4
    ldr	s19,	[sp, #1752]

    fmov	s4,	s24
    ldr	s31,	[sp, #1756]

    fmov	s24,	s22
    str	s31,	[sp, #1752]

    fmov	s22,	s5
    ldr	s20,	[sp, #1764]

    fmov	s5,	s30
    str	s20,	[sp, #1756]

    fmov	s30,	s27
    ldr	s31,	[sp, #1760]

    fmov	s27,	s3
    str	s31,	[sp, #1764]

    fmov	s3,	s19
    ldr	s17,	[sp, #1768]

    str	s17,	[sp, #1760]

    ldr	s20,	[sp, #1772]

    str	s20,	[sp, #1768]

    ldr	s17,	[sp, #1780]

    str	s17,	[sp, #1772]

    ldr	s20,	[sp, #1776]

    str	s20,	[sp, #1780]

    fmov	s20,	s23
    ldr	s31,	[sp, #1788]

    str	s31,	[sp, #1776]

    ldr	s18,	[sp, #1404]

    str	s18,	[sp, #1788]

    ldr	s6,	[sp, #1412]

    str	s6,	[sp, #1404]

    ldr	s18,	[sp, #1408]

    str	s18,	[sp, #1412]

    ldr	s28,	[sp, #1416]

    str	s28,	[sp, #1408]

    ldr	s6,	[sp, #1420]

    str	s6,	[sp, #1416]

    ldr	s28,	[sp, #1428]

    str	s28,	[sp, #1420]

    ldr	s6,	[sp, #1424]

    str	s6,	[sp, #1428]

    str	s20,	[sp, #1424]

    ldr	s15,	[sp, #1440]

    ldr	s28,	[sp, #1444]

    fmov	s23,	s15
    str	s28,	[sp, #1440]

    str	s29,	[sp, #1444]

    ldr	s17,	[sp, #1104]

    ldr	s20,	[sp, #1152]

    fmov	s12,	s17
    fmov	s6,	s20
    str	s6,	[sp, #1104]

    ldr	s7,	[sp, #1160]

    fmov	s6,	s7
    str	s6,	[sp, #1152]

    ldr	s7,	[sp, #1164]

    fmov	s18,	s7
    str	s18,	[sp, #1160]

    ldr	s19,	[sp, #1172]

    fmov	s20,	s19
    str	s20,	[sp, #1164]

    ldr	s7,	[sp, #1180]

    fmov	s31,	s7
    str	s31,	[sp, #1172]

    ldr	s17,	[sp, #1188]

    str	s17,	[sp, #1180]

    ldr	s18,	[sp, #1192]

    str	s18,	[sp, #1188]

    ldr	s7,	[sp, #1208]

    str	s7,	[sp, #1192]

    str	s21,	[sp, #1208]

    b	main_148

