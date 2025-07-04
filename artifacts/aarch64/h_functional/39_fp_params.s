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
    movz	fp,	#12480
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #3220]

    movz	w0,	#0
    mov	w26,	w0

main_10:
    cmp	w26,	#40
    blt	main_13

main_18:
    movz	w1,	#0
    mov	w19,	w1

main_19:
    cmp	w19,	#24
    blt	main_22

main_27:
    add	x13,	sp,	#304
    add	x6,	sp,	#364
    add	x27,	sp,	#376
    add	x15,	sp,	#400
    add	x11,	sp,	#412
    str	x13,	[sp, #3120]

    ldr	w16,	[sp, #3220]

    ldr	x9,	[sp, #3120]

    lsl	w1,	w16,	#2
    add	x0,	x9,	x1
    add	x9,	sp,	#316
    ldr	s28,	[x0]

    str	s28,	[sp, #1292]

    str	x9,	[sp, #3112]

    ldr	w17,	[sp, #3220]

    ldr	x5,	[sp, #3112]

    lsl	w1,	w17,	#2
    add	x0,	x5,	x1
    add	x1,	sp,	#340
    add	x5,	sp,	#328
    ldr	s25,	[x0]

    str	s25,	[sp, #1224]

    str	x5,	[sp, #3104]

    ldr	w18,	[sp, #3220]

    ldr	x0,	[sp, #3104]

    lsl	w5,	w18,	#2
    add	x18,	sp,	#352
    add	x4,	x0,	x5
    ldr	s2,	[x4]

    str	s2,	[sp, #1296]

    str	x1,	[sp, #3096]

    ldr	w19,	[sp, #3220]

    ldr	x21,	[sp, #3096]

    lsl	w9,	w19,	#2
    add	x19,	sp,	#388
    add	x8,	x21,	x9
    ldr	s7,	[x8]

    str	s7,	[sp, #1300]

    str	x18,	[sp, #3080]

    ldr	w20,	[sp, #3220]

    ldr	x10,	[sp, #3080]

    lsl	w13,	w20,	#2
    add	x12,	x10,	x13
    ldr	s10,	[x12]

    str	s10,	[sp, #1304]

    str	x6,	[sp, #3056]

    ldr	w23,	[sp, #3220]

    ldr	x7,	[sp, #3056]

    lsl	w20,	w23,	#2
    add	x16,	x7,	x20
    add	x7,	sp,	#424
    ldr	s29,	[x16]

    str	s29,	[sp, #1260]

    str	x27,	[sp, #3040]

    ldr	w26,	[sp, #3220]

    ldr	x28,	[sp, #3040]

    lsl	w24,	w26,	#2
    add	x21,	x28,	x24
    ldr	s2,	[x21]

    str	s2,	[sp, #1232]

    str	x19,	[sp, #3032]

    ldr	w27,	[sp, #3220]

    ldr	x20,	[sp, #3032]

    lsl	w1,	w27,	#2
    add	x0,	x20,	x1
    add	x20,	sp,	#460
    ldr	s6,	[x0]

    str	s6,	[sp, #1208]

    str	x15,	[sp, #3024]

    ldr	w28,	[sp, #3220]

    ldr	x16,	[sp, #3024]

    lsl	w0,	w28,	#2
    add	x28,	sp,	#448
    add	x3,	x16,	x0
    add	x16,	sp,	#472
    ldr	s2,	[x3]

    str	s2,	[sp, #1204]

    str	x11,	[sp, #3016]

    ldr	w0,	[sp, #3220]

    ldr	x12,	[sp, #3016]

    lsl	w4,	w0,	#2
    add	x3,	x12,	x4
    add	x12,	sp,	#484
    ldr	s18,	[x3]

    add	x3,	sp,	#436
    str	s18,	[sp, #1308]

    str	x7,	[sp, #3008]

    ldr	w1,	[sp, #3220]

    ldr	x8,	[sp, #3008]

    lsl	w11,	w1,	#2
    add	x7,	x8,	x11
    add	x8,	sp,	#496
    ldr	s25,	[x7]

    str	s25,	[sp, #1312]

    str	x3,	[sp, #3000]

    ldr	w2,	[sp, #3220]

    ldr	x4,	[sp, #3000]

    lsl	w15,	w2,	#2
    add	x11,	x4,	x15
    ldr	s30,	[x11]

    str	s30,	[sp, #1316]

    str	x28,	[sp, #2992]

    ldr	w3,	[sp, #3220]

    ldr	x0,	[sp, #2992]

    lsl	w19,	w3,	#2
    add	x15,	x0,	x19
    ldr	s20,	[x15]

    str	s20,	[sp, #1220]

    str	x20,	[sp, #2984]

    ldr	w4,	[sp, #3220]

    ldr	x23,	[sp, #2984]

    lsl	w21,	w4,	#2
    add	x19,	x23,	x21
    add	x23,	sp,	#532
    ldr	s4,	[x19]

    str	s4,	[sp, #1320]

    str	x16,	[sp, #2976]

    ldr	w5,	[sp, #3220]

    ldr	x17,	[sp, #2976]

    lsl	w0,	w5,	#2
    add	x0,	x17,	x0
    ldr	s6,	[x0]

    add	x0,	sp,	#520
    str	s6,	[sp, #1328]

    str	x12,	[sp, #2968]

    ldr	w6,	[sp, #3220]

    ldr	x13,	[sp, #2968]

    lsl	w4,	w6,	#2
    add	x2,	x13,	x4
    add	x4,	sp,	#508
    add	x13,	sp,	#544
    ldr	s13,	[x2]

    str	s13,	[sp, #1332]

    str	x8,	[sp, #2960]

    ldr	w7,	[sp, #3220]

    ldr	x9,	[sp, #2960]

    lsl	w3,	w7,	#2
    add	x2,	x9,	x3
    ldr	s25,	[x2]

    str	s25,	[sp, #1256]

    str	x4,	[sp, #2952]

    ldr	w8,	[sp, #3220]

    ldr	x5,	[sp, #2952]

    lsl	w10,	w8,	#2
    add	x6,	x5,	x10
    add	x5,	sp,	#556
    ldr	s20,	[x6]

    str	s20,	[sp, #1280]

    str	x0,	[sp, #2944]

    ldr	w9,	[sp, #3220]

    ldr	x1,	[sp, #2944]

    lsl	w14,	w9,	#2
    add	x10,	x1,	x14
    ldr	s21,	[x10]

    str	s21,	[sp, #1336]

    str	x23,	[sp, #2936]

    ldr	w10,	[sp, #3220]

    ldr	x26,	[sp, #2936]

    lsl	w15,	w10,	#2
    add	x10,	sp,	#604
    add	x14,	x26,	x15
    ldr	s27,	[x14]

    str	s27,	[sp, #1340]

    str	x13,	[sp, #2920]

    ldr	w11,	[sp, #3220]

    ldr	x14,	[sp, #2920]

    lsl	w23,	w11,	#2
    add	x18,	x14,	x23
    ldr	s6,	[x18]

    add	x18,	sp,	#580
    str	s6,	[sp, #1236]

    str	x5,	[sp, #2904]

    ldr	w12,	[sp, #3220]

    ldr	x6,	[sp, #2904]

    lsl	w1,	w12,	#2
    add	x27,	x6,	x1
    add	x1,	sp,	#568
    ldr	s20,	[x27]

    add	x27,	sp,	#640
    str	s20,	[sp, #1252]

    str	x1,	[sp, #2896]

    ldr	w13,	[sp, #3220]

    ldr	x2,	[sp, #2896]

    lsl	w6,	w13,	#2
    add	x1,	x2,	x6
    ldr	s1,	[x1]

    str	s1,	[sp, #1344]

    str	x18,	[sp, #2880]

    ldr	w14,	[sp, #3220]

    ldr	x19,	[sp, #2880]

    lsl	w2,	w14,	#2
    add	x14,	sp,	#592
    add	x1,	x19,	x2
    add	x2,	sp,	#628
    ldr	s6,	[x1]

    str	s6,	[sp, #1348]

    str	x14,	[sp, #2872]

    ldr	w15,	[sp, #3220]

    lsl	w6,	w15,	#2
    ldr	x15,	[sp, #2872]

    add	x5,	x15,	x6
    add	x15,	sp,	#664
    add	x6,	sp,	#616
    ldr	s9,	[x5]

    str	s9,	[sp, #1352]

    str	x10,	[sp, #2864]

    ldr	w16,	[sp, #3220]

    ldr	x11,	[sp, #2864]

    lsl	w10,	w16,	#2
    add	x9,	x11,	x10
    add	x11,	sp,	#676
    ldr	s17,	[x9]

    str	s17,	[sp, #1356]

    str	x6,	[sp, #2856]

    ldr	w17,	[sp, #3220]

    ldr	x7,	[sp, #2856]

    lsl	w17,	w17,	#2
    add	x13,	x7,	x17
    add	x7,	sp,	#688
    ldr	s7,	[x13]

    str	s7,	[sp, #1272]

    str	x2,	[sp, #2848]

    ldr	w18,	[sp, #3220]

    ldr	x3,	[sp, #2848]

    lsl	w22,	w18,	#2
    add	x17,	x3,	x22
    ldr	s24,	[x17]

    str	s24,	[sp, #1360]

    str	x27,	[sp, #2840]

    ldr	w19,	[sp, #3220]

    ldr	x28,	[sp, #2840]

    lsl	w27,	w19,	#2
    add	x19,	sp,	#652
    add	x24,	x28,	x27
    add	x28,	sp,	#700
    ldr	s29,	[x24]

    str	s29,	[sp, #1364]

    str	x19,	[sp, #2832]

    ldr	w20,	[sp, #3220]

    lsl	w2,	w20,	#2
    ldr	x20,	[sp, #2832]

    add	x0,	x20,	x2
    ldr	s6,	[x0]

    str	s6,	[sp, #1268]

    str	x15,	[sp, #2824]

    ldr	w23,	[sp, #3220]

    ldr	x16,	[sp, #2824]

    lsl	w1,	w23,	#2
    add	x23,	sp,	#772
    add	x0,	x16,	x1
    ldr	s13,	[x0]

    str	s13,	[sp, #1216]

    str	x11,	[sp, #2816]

    ldr	w26,	[sp, #3220]

    ldr	x12,	[sp, #2816]

    lsl	w5,	w26,	#2
    add	x4,	x12,	x5
    ldr	s3,	[x4]

    add	x4,	sp,	#748
    str	s3,	[sp, #1368]

    str	x7,	[sp, #2808]

    ldr	w27,	[sp, #3220]

    ldr	x8,	[sp, #2808]

    lsl	w12,	w27,	#2
    add	x8,	x8,	x12
    ldr	s9,	[x8]

    add	x8,	sp,	#736
    str	s9,	[sp, #1376]

    str	x28,	[sp, #2792]

    ldr	w28,	[sp, #3220]

    ldr	x0,	[sp, #2792]

    lsl	w16,	w28,	#2
    add	x12,	x0,	x16
    add	x16,	sp,	#712
    ldr	s7,	[x12]

    add	x12,	sp,	#724
    str	s7,	[sp, #1240]

    str	x16,	[sp, #2776]

    ldr	w0,	[sp, #3220]

    ldr	x17,	[sp, #2776]

    lsl	w20,	w0,	#2
    add	x16,	x17,	x20
    ldr	s2,	[x16]

    str	s2,	[sp, #1264]

    str	x12,	[sp, #2768]

    ldr	w1,	[sp, #3220]

    ldr	x13,	[sp, #2768]

    lsl	w1,	w1,	#2
    add	x21,	x13,	x1
    ldr	s12,	[x21]

    str	s12,	[sp, #1380]

    str	x8,	[sp, #2760]

    ldr	w2,	[sp, #3220]

    ldr	x9,	[sp, #2760]

    lsl	w1,	w2,	#2
    add	x0,	x9,	x1
    ldr	s13,	[x0]

    str	s13,	[sp, #1276]

    str	x4,	[sp, #2752]

    ldr	w3,	[sp, #3220]

    ldr	x5,	[sp, #2752]

    lsl	w0,	w3,	#2
    add	x3,	x5,	x0
    add	x0,	sp,	#760
    ldr	s7,	[x3]

    str	s7,	[sp, #1212]

    str	x0,	[sp, #2744]

    ldr	w4,	[sp, #3220]

    ldr	x1,	[sp, #2744]

    lsl	w7,	w4,	#2
    add	x3,	x1,	x7
    ldr	s29,	[x3]

    str	s29,	[sp, #1228]

    str	x23,	[sp, #2736]

    ldr	w5,	[sp, #3220]

    ldr	x26,	[sp, #2736]

    lsl	w8,	w5,	#2
    add	x7,	x26,	x8
    ldr	s13,	[x7]

    str	s13,	[sp, #1244]

    ldr	s29,	[sp, #1292]

    ldr	s28,	[sp, #1224]

    fmov	s27,	s29
    str	s28,	[sp, #1108]

    ldr	s5,	[sp, #1296]

    ldr	s9,	[sp, #1300]

    fmov	s12,	s5
    ldr	s7,	[sp, #1304]

    ldr	s5,	[sp, #1260]

    fmov	s16,	s7
    ldr	s26,	[sp, #1232]

    fmov	s22,	s5
    ldr	s7,	[sp, #1208]

    fmov	s13,	s26
    ldr	s19,	[sp, #1204]

    fmov	s17,	s7
    ldr	s26,	[sp, #1308]

    fmov	s21,	s19
    ldr	s5,	[sp, #1312]

    fmov	s24,	s26
    fmov	s25,	s5
    ldr	s5,	[sp, #1316]

    str	s5,	[sp, #1416]

    ldr	s7,	[sp, #1220]

    str	s7,	[sp, #1424]

    ldr	s30,	[sp, #1320]

    str	s30,	[sp, #1420]

    ldr	s30,	[sp, #1328]

    str	s30,	[sp, #1428]

    ldr	s7,	[sp, #1332]

    str	s7,	[sp, #1632]

    ldr	s18,	[sp, #1256]

    str	s18,	[sp, #1640]

    ldr	s3,	[sp, #1280]

    str	s3,	[sp, #1636]

    ldr	s3,	[sp, #1336]

    str	s3,	[sp, #1644]

    ldr	s30,	[sp, #1340]

    str	s30,	[sp, #1652]

    ldr	s30,	[sp, #1236]

    str	s30,	[sp, #1660]

    ldr	s7,	[sp, #1252]

    str	s7,	[sp, #1656]

    ldr	s7,	[sp, #1344]

    str	s7,	[sp, #1664]

    ldr	s30,	[sp, #1348]

    fmov	s3,	s30
    str	s3,	[sp, #1668]

    ldr	s7,	[sp, #1352]

    fmov	s3,	s7
    str	s3,	[sp, #1676]

    ldr	s10,	[sp, #1356]

    str	s10,	[sp, #1672]

    ldr	s7,	[sp, #1272]

    ldr	s2,	[sp, #1360]

    fmov	s26,	s7
    str	s2,	[sp, #1688]

    ldr	s31,	[sp, #1364]

    str	s31,	[sp, #1692]

    ldr	s19,	[sp, #1268]

    fmov	s29,	s19
    str	s29,	[sp, #1752]

    ldr	s31,	[sp, #1216]

    fmov	s3,	s31
    str	s3,	[sp, #1756]

    ldr	s15,	[sp, #1368]

    fmov	s1,	s15
    str	s1,	[sp, #1080]

    ldr	s31,	[sp, #1376]

    str	s31,	[sp, #1096]

    ldr	s2,	[sp, #1240]

    str	s2,	[sp, #1128]

    ldr	s10,	[sp, #1264]

    fmov	s15,	s10
    str	s15,	[sp, #1140]

    ldr	s19,	[sp, #1380]

    str	s19,	[sp, #1152]

    ldr	s31,	[sp, #1276]

    str	s31,	[sp, #1160]

    ldr	s28,	[sp, #1212]

    str	s28,	[sp, #1168]

    ldr	s15,	[sp, #1228]

    str	s15,	[sp, #1172]

    ldr	s15,	[sp, #1244]

    str	s15,	[sp, #1188]


main_148:
    movi	v29.4s,	#0
    ldr	s3,	[sp, #1188]

    fcmp	s3,	s29
    bne	main_190

main_305:
    ldr	s28,	[sp, #1108]

    fmov	s20,	s12
    ldr	s3,	[sp, #1108]

    fadd	s15,	s27,	s28
    str	s20,	[sp, #1108]

    fmov	s27,	s3
    fadd	s15,	s15,	s12
    ldr	s31,	[sp, #1416]

    fmov	s12,	s9
    ldr	s4,	[sp, #1424]

    fmov	s9,	s16
    str	s4,	[sp, #1416]

    fmov	s16,	s22
    ldr	s18,	[sp, #1420]

    fmov	s22,	s13
    str	s18,	[sp, #1424]

    fmov	s13,	s17
    ldr	s28,	[sp, #1428]

    fmov	s17,	s21
    str	s28,	[sp, #1420]

    fmov	s21,	s24
    fmov	s28,	s26
    ldr	s3,	[sp, #1632]

    fmov	s24,	s25
    str	s3,	[sp, #1428]

    fmov	s25,	s31
    ldr	s20,	[sp, #1640]

    str	s20,	[sp, #1632]

    ldr	s2,	[sp, #1636]

    str	s2,	[sp, #1640]

    ldr	s6,	[sp, #1644]

    str	s6,	[sp, #1636]

    ldr	s19,	[sp, #1652]

    str	s19,	[sp, #1644]

    ldr	s6,	[sp, #1660]

    str	s6,	[sp, #1652]

    ldr	s19,	[sp, #1656]

    str	s19,	[sp, #1660]

    ldr	s2,	[sp, #1664]

    str	s2,	[sp, #1656]

    ldr	s3,	[sp, #1668]

    str	s3,	[sp, #1664]

    ldr	s29,	[sp, #1676]

    str	s29,	[sp, #1668]

    ldr	s31,	[sp, #1672]

    str	s31,	[sp, #1676]

    str	s28,	[sp, #1672]

    ldr	s5,	[sp, #1688]

    ldr	s2,	[sp, #1692]

    fmov	s26,	s5
    str	s2,	[sp, #1688]

    ldr	s6,	[sp, #1752]

    fmov	s19,	s6
    str	s19,	[sp, #1692]

    ldr	s7,	[sp, #1756]

    str	s7,	[sp, #1752]

    ldr	s28,	[sp, #1080]

    fmov	s23,	s28
    str	s23,	[sp, #1756]

    ldr	s3,	[sp, #1096]

    fmov	s7,	s3
    str	s7,	[sp, #1080]

    ldr	s28,	[sp, #1128]

    fmov	s6,	s28
    str	s6,	[sp, #1096]

    ldr	s29,	[sp, #1140]

    fmov	s10,	s29
    str	s10,	[sp, #1128]

    ldr	s18,	[sp, #1152]

    fmov	s29,	s18
    fmov	s18,	s15
    str	s29,	[sp, #1140]

    ldr	s19,	[sp, #1160]

    str	s19,	[sp, #1152]

    ldr	s2,	[sp, #1168]

    str	s2,	[sp, #1160]

    ldr	s31,	[sp, #1172]

    str	s31,	[sp, #1168]

    ldr	s31,	[sp, #1188]

    str	s31,	[sp, #1172]

    str	s18,	[sp, #1188]

    b	main_148

main_190:
    ldr	s10,	[sp, #1108]

    add	x1,	sp,	#784
    add	x21,	sp,	#788
    add	x22,	sp,	#792
    add	x24,	sp,	#796
    add	x0,	sp,	#800
    add	x18,	sp,	#804
    add	x19,	sp,	#808
    add	x20,	sp,	#816
    fadd	s10,	s27,	s10
    str	s10,	[sp, #1560]

    ldr	s10,	[sp, #1560]

    fadd	s15,	s10,	s12
    str	s15,	[sp, #1564]

    ldr	s15,	[sp, #1564]

    fadd	s15,	s15,	s9
    fadd	s9,	s16,	s22
    str	s15,	[sp, #1196]

    str	s9,	[sp, #1568]

    fadd	s9,	s21,	s24
    ldr	s10,	[sp, #1568]

    fadd	s10,	s10,	s13
    str	s10,	[sp, #1572]

    ldr	s12,	[sp, #1572]

    fadd	s12,	s12,	s17
    str	s12,	[sp, #1184]

    str	s9,	[sp, #1576]

    ldr	s12,	[sp, #1576]

    fadd	s12,	s12,	s25
    str	s12,	[sp, #1580]

    ldr	s9,	[sp, #1416]

    ldr	s15,	[sp, #1580]

    fadd	s12,	s15,	s9
    str	s12,	[sp, #1444]

    ldr	s9,	[sp, #1420]

    ldr	s13,	[sp, #1424]

    fadd	s9,	s13,	s9
    str	s9,	[sp, #1492]

    ldr	s9,	[sp, #1428]

    ldr	s15,	[sp, #1492]

    fadd	s12,	s15,	s9
    str	s12,	[sp, #1496]

    ldr	s9,	[sp, #1632]

    ldr	s10,	[sp, #1496]

    fadd	s12,	s10,	s9
    str	s12,	[sp, #1440]

    ldr	s9,	[sp, #1636]

    ldr	s13,	[sp, #1640]

    fadd	s12,	s13,	s9
    str	s12,	[sp, #1480]

    ldr	s9,	[sp, #1644]

    ldr	s12,	[sp, #1480]

    fadd	s12,	s12,	s9
    str	s12,	[sp, #1484]

    ldr	s12,	[sp, #1652]

    ldr	s10,	[sp, #1484]

    fadd	s9,	s10,	s12
    str	s9,	[sp, #1436]

    ldr	s12,	[sp, #1656]

    ldr	s9,	[sp, #1660]

    fadd	s12,	s9,	s12
    str	s12,	[sp, #1468]

    ldr	s12,	[sp, #1664]

    ldr	s13,	[sp, #1468]

    fadd	s15,	s13,	s12
    str	s15,	[sp, #1472]

    ldr	s12,	[sp, #1668]

    ldr	s10,	[sp, #1472]

    fadd	s10,	s10,	s12
    str	s10,	[sp, #1740]

    ldr	s12,	[sp, #1672]

    ldr	s9,	[sp, #1676]

    fadd	s10,	s9,	s12
    str	s10,	[sp, #1460]

    ldr	s12,	[sp, #1460]

    ldr	s13,	[sp, #1688]

    fadd	s12,	s12,	s26
    fadd	s12,	s12,	s13
    str	s12,	[sp, #1732]

    ldr	s12,	[sp, #1692]

    ldr	s15,	[sp, #1752]

    ldr	s9,	[sp, #1756]

    fadd	s13,	s12,	s15
    fadd	s12,	s13,	s9
    ldr	s9,	[sp, #1080]

    fadd	s12,	s12,	s9
    str	s12,	[sp, #1728]

    ldr	s10,	[sp, #1096]

    ldr	s15,	[sp, #1128]

    ldr	s13,	[sp, #1140]

    fadd	s12,	s10,	s15
    fadd	s12,	s12,	s13
    ldr	s13,	[sp, #1152]

    fadd	s15,	s12,	s13
    str	s15,	[sp, #1736]

    ldr	s13,	[sp, #1160]

    ldr	s10,	[sp, #1168]

    fadd	s13,	s13,	s10
    ldr	s10,	[sp, #1172]

    fadd	s12,	s13,	s10
    ldr	s10,	[sp, #1188]

    fadd	s9,	s12,	s10
    str	s9,	[sp, #1628]

    ldr	s10,	[sp, #1196]

    str	s10,	[x1]

    ldr	s15,	[sp, #1184]

    str	s15,	[x21]

    add	x21,	sp,	#820
    ldr	s10,	[sp, #1444]

    str	s10,	[x22]

    ldr	s15,	[sp, #1440]

    str	s15,	[x24]

    ldr	s12,	[sp, #1436]

    str	s12,	[x0]

    add	x0,	sp,	#812
    ldr	s12,	[sp, #1740]

    str	s12,	[x18]

    ldr	s10,	[sp, #1732]

    str	s10,	[x19]

    ldr	s15,	[sp, #1728]

    str	s15,	[x0]

    movz	w0,	#10
    ldr	s9,	[sp, #1736]

    str	s9,	[x20]

    ldr	s10,	[sp, #1628]

    str	s10,	[x21]

    bl	putfarray
    add	x24,	sp,	#172
    add	x12,	sp,	#244
    add	x26,	sp,	#136
    ldr	w6,	[sp, #3220]

    add	x28,	sp,	#28
    add	x17,	sp,	#64
    add	x8,	sp,	#292
    add	x20,	sp,	#76
    add	x2,	sp,	#40
    lsl	w0,	w6,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#784
    ldr	s25,	[x0]

    str	s25,	[sp, #1288]

    str	x8,	[sp, #3160]

    ldr	w7,	[sp, #3220]

    ldr	x5,	[sp, #3160]

    lsl	w0,	w7,	#2
    add	x3,	x5,	x0
    add	x0,	sp,	#88
    ldr	w27,	[x3]

    str	w27,	[sp, #2188]

    ldr	w8,	[sp, #3220]

    lsl	w14,	w8,	#2
    add	x3,	x2,	x14
    ldr	w10,	[x3]

    str	w10,	[sp, #3216]

    str	x0,	[sp, #3144]

    ldr	w9,	[sp, #3220]

    ldr	x21,	[sp, #3144]

    lsl	w8,	w9,	#2
    add	x7,	x21,	x8
    ldr	w15,	[x7]

    str	w15,	[sp, #6004]

    str	x28,	[sp, #3152]

    ldr	w7,	[sp, #3220]

    ldr	x14,	[sp, #3152]

    lsl	w15,	w7,	#2
    add	x14,	x14,	x15
    ldr	w1,	[x14]

    str	w1,	[sp, #3188]

    ldr	w2,	[sp, #3220]

    lsl	w0,	w2,	#2
    add	x18,	x17,	x0
    ldr	w16,	[x18]

    str	w16,	[sp, #3200]

    add	x16,	sp,	#280
    ldr	w3,	[sp, #3220]

    lsl	w4,	w3,	#2
    add	x23,	x20,	x4
    ldr	w5,	[x23]

    str	w5,	[sp, #3192]

    str	x16,	[sp, #3136]

    add	x16,	sp,	#16
    ldr	w13,	[sp, #3220]

    ldr	x6,	[sp, #3136]

    lsl	w0,	w13,	#2
    add	x1,	x6,	x0
    add	x0,	sp,	#112
    ldr	w28,	[x1]

    str	w28,	[sp, #1884]

    str	x16,	[sp, #3088]

    ldr	w14,	[sp, #3220]

    ldr	x2,	[sp, #3088]

    lsl	w3,	w14,	#2
    add	x3,	x2,	x3
    ldr	w1,	[x3]

    str	w1,	[sp, #3212]

    str	x12,	[sp, #3128]

    ldr	w15,	[sp, #3220]

    ldr	x1,	[sp, #3128]

    lsl	w3,	w15,	#2
    add	x15,	sp,	#100
    add	x2,	x1,	x3
    ldr	w12,	[x2]

    str	w12,	[sp, #6000]

    str	x15,	[sp, #3064]

    ldr	w7,	[sp, #3220]

    ldr	x4,	[sp, #3064]

    lsl	w7,	w7,	#2
    add	x6,	x4,	x7
    ldr	w9,	[x6]

    str	w9,	[sp, #5996]

    str	x26,	[sp, #3048]

    ldr	w6,	[sp, #3220]

    lsl	w13,	w6,	#2
    ldr	x6,	[sp, #3048]

    add	x12,	x6,	x13
    ldr	w6,	[x12]

    str	w6,	[sp, #5992]

    str	x24,	[sp, #3072]

    ldr	w3,	[sp, #3220]

    ldr	x2,	[sp, #3072]

    lsl	w19,	w3,	#2
    add	x18,	x2,	x19
    ldr	w3,	[x18]

    str	w3,	[sp, #5988]

    ldr	w5,	[sp, #3220]

    lsl	w4,	w5,	#2
    add	x5,	sp,	#232
    add	x1,	x0,	x4
    add	x0,	sp,	#220
    ldr	w18,	[x1]

    str	w18,	[sp, #3180]

    ldr	w7,	[sp, #3220]

    lsl	w4,	w7,	#2
    add	x7,	sp,	#268
    add	x3,	x0,	x4
    add	x0,	sp,	#124
    ldr	w26,	[x3]

    str	w26,	[sp, #3204]

    ldr	w9,	[sp, #3220]

    lsl	w9,	w9,	#2
    add	x1,	x5,	x9
    ldr	w5,	[x1]

    str	w5,	[sp, #3196]

    ldr	w17,	[sp, #3220]

    lsl	w21,	w17,	#2
    add	x17,	sp,	#148
    add	x1,	x0,	x21
    add	x21,	sp,	#160
    ldr	w1,	[x1]

    str	w1,	[sp, #3172]

    str	x21,	[sp, #2928]

    ldr	w14,	[sp, #3220]

    ldr	x2,	[sp, #2928]

    lsl	w6,	w14,	#2
    add	x5,	x2,	x6
    ldr	w3,	[x5]

    str	w3,	[sp, #7852]

    add	x3,	sp,	#184
    str	x17,	[sp, #2888]

    ldr	w21,	[sp, #3220]

    ldr	x5,	[sp, #2888]

    lsl	w17,	w21,	#2
    add	x15,	x5,	x17
    add	x5,	sp,	#208
    ldr	w9,	[x15]

    str	w9,	[sp, #7832]

    str	x5,	[sp, #2912]

    ldr	w24,	[sp, #3220]

    ldr	x9,	[sp, #2912]

    lsl	w0,	w24,	#2
    add	x24,	x9,	x0
    add	x0,	sp,	#52
    ldr	w6,	[x24]

    str	w6,	[sp, #7828]

    str	x0,	[sp, #2800]

    ldr	w0,	[sp, #3220]

    ldr	x2,	[sp, #2800]

    lsl	w1,	w0,	#2
    add	x6,	x2,	x1
    ldr	w6,	[x6]

    str	w6,	[sp, #3208]

    ldr	w2,	[sp, #3220]

    lsl	w2,	w2,	#2
    add	x6,	x7,	x2
    ldr	w4,	[x6]

    add	x6,	sp,	#256
    str	w4,	[sp, #3184]

    ldr	w4,	[sp, #3220]

    lsl	w10,	w4,	#2
    add	x26,	x6,	x10
    ldr	w6,	[x26]

    str	w6,	[sp, #3176]

    add	x6,	sp,	#196
    str	x6,	[sp, #2784]

    ldr	w5,	[sp, #3220]

    ldr	x28,	[sp, #2784]

    lsl	w1,	w5,	#2
    add	x0,	x28,	x1
    ldr	w6,	[x0]

    ldr	w5,	[sp, #3220]

    lsl	w19,	w5,	#2
    add	x5,	x3,	x19
    ldr	w4,	[x5]

    str	w4,	[sp, #3168]

    ldr	w7,	[sp, #2188]

    mov	w15,	w7
    str	w15,	[sp, #2136]

    ldr	w3,	[sp, #3216]

    mov	w27,	w3
    str	w27,	[sp, #7840]

    ldr	w26,	[sp, #6004]

    mov	w25,	w26
    str	w25,	[sp, #5356]

    ldr	s13,	[sp, #1304]

    ldr	w14,	[sp, #3188]

    fmov	s24,	s13
    mov	w3,	w14
    str	w3,	[sp, #5360]

    ldr	w4,	[sp, #3200]

    mov	w2,	w4
    str	w2,	[sp, #7844]

    ldr	w3,	[sp, #3192]

    mov	w9,	w3
    str	w9,	[sp, #7848]

    ldr	s30,	[sp, #1204]

    ldr	s12,	[sp, #1332]

    fmov	s26,	s30
    ldr	s7,	[sp, #1208]

    fmov	s29,	s12
    ldr	w13,	[sp, #1884]

    fmov	s9,	s7
    mov	w15,	w13
    str	w15,	[sp, #2020]

    ldr	s17,	[sp, #1300]

    fmov	s27,	s17
    ldr	s17,	[sp, #1364]

    str	s17,	[sp, #1532]

    ldr	w14,	[sp, #3212]

    mov	w22,	w14
    str	w22,	[sp, #7836]

    ldr	s16,	[sp, #1212]

    str	s16,	[sp, #1556]

    ldr	w2,	[sp, #6000]

    mov	w19,	w2
    str	w19,	[sp, #1896]

    ldr	s5,	[sp, #1216]

    str	s5,	[sp, #1540]

    ldr	s17,	[sp, #1220]

    ldr	s7,	[sp, #1224]

    fmov	s22,	s17
    ldr	s19,	[sp, #1316]

    fmov	s16,	s7
    ldr	s21,	[sp, #1228]

    fmov	s6,	s19
    str	s21,	[sp, #1552]

    ldr	s21,	[sp, #1232]

    ldr	w26,	[sp, #5996]

    fmov	s17,	s21
    ldr	s4,	[sp, #1376]

    mov	w10,	w26
    str	s4,	[sp, #1536]

    ldr	w24,	[sp, #5992]

    mov	w26,	w24
    str	w26,	[sp, #5372]

    ldr	w15,	[sp, #5988]

    mov	w13,	w15
    str	w13,	[sp, #5400]

    ldr	s1,	[sp, #1236]

    str	s1,	[sp, #1516]

    ldr	s23,	[sp, #1240]

    str	s23,	[sp, #1104]

    ldr	s10,	[sp, #1348]

    str	s10,	[sp, #1520]

    ldr	s2,	[sp, #1308]

    fmov	s31,	s2
    str	s31,	[sp, #1744]

    ldr	s4,	[sp, #1356]

    str	s4,	[sp, #1524]

    ldr	w3,	[sp, #3180]

    mov	w23,	w3
    str	w23,	[sp, #5364]

    ldr	s5,	[sp, #1244]

    str	s5,	[sp, #1116]

    ldr	w18,	[sp, #3204]

    mov	w23,	w18
    str	w23,	[sp, #5984]

    ldr	s5,	[sp, #1252]

    ldr	s31,	[sp, #1256]

    fmov	s21,	s5
    ldr	s20,	[sp, #1260]

    fmov	s1,	s31
    ldr	s25,	[sp, #1264]

    fmov	s7,	s20
    str	s25,	[sp, #1132]

    ldr	w16,	[sp, #3196]

    mov	w8,	w16
    str	w8,	[sp, #1944]

    ldr	w18,	[sp, #3172]

    mov	w17,	w18
    str	w17,	[sp, #7296]

    ldr	s13,	[sp, #1328]

    ldr	s20,	[sp, #1312]

    fmov	s10,	s13
    fmov	s5,	s20
    str	s5,	[sp, #1120]

    ldr	s20,	[sp, #1292]

    ldr	w9,	[sp, #7852]

    fmov	s25,	s20
    mov	w4,	w9
    str	w4,	[sp, #5376]

    ldr	s2,	[sp, #1368]

    str	s2,	[sp, #1112]

    ldr	w14,	[sp, #7832]

    mov	w12,	w14
    mov	w14,	w6
    str	w12,	[sp, #7292]

    ldr	w11,	[sp, #7828]

    mov	w12,	w11
    str	w12,	[sp, #5380]

    ldr	s12,	[sp, #1360]

    str	s12,	[sp, #1100]

    ldr	s4,	[sp, #1352]

    ldr	s23,	[sp, #1320]

    fmov	s15,	s4
    ldr	s20,	[sp, #1268]

    str	s20,	[sp, #1088]

    ldr	w18,	[sp, #3208]

    ldr	w20,	[sp, #3184]

    mov	w7,	w18
    mov	w17,	w20
    str	w17,	[sp, #1956]

    ldr	w4,	[sp, #3176]

    mov	w13,	w4
    str	w13,	[sp, #5980]

    ldr	s31,	[sp, #1336]

    ldr	s19,	[sp, #1340]

    fmov	s4,	s31
    ldr	s28,	[sp, #1344]

    fmov	s30,	s19
    ldr	s31,	[sp, #1272]

    fmov	s5,	s28
    ldr	s13,	[sp, #1276]

    fmov	s12,	s31
    str	s13,	[sp, #1156]

    ldr	s2,	[sp, #1280]

    str	w14,	[sp, #5368]

    fmov	s28,	s2
    ldr	s31,	[sp, #1296]

    str	s31,	[sp, #1092]

    ldr	w28,	[sp, #3168]

    ldr	s13,	[sp, #1380]

    mov	w11,	w28
    str	s13,	[sp, #1144]


main_309:
    ldr	w23,	[sp, #2136]

    cmp	w23,	#0
    bne	main_375

main_308:
    ldr	w14,	[sp, #5360]

    mov	w16,	w14
    str	w16,	[sp, #2136]

    ldr	w17,	[sp, #7840]

    ldr	w20,	[sp, #11648]

    ldr	w21,	[sp, #11648]

    mov	w17,	w20
    str	w21,	[sp, #7840]

    ldr	w3,	[sp, #5356]

    ldr	w1,	[sp, #8844]

    ldr	w2,	[sp, #8844]

    mov	w3,	w1
    str	w2,	[sp, #5356]

    ldr	w15,	[sp, #5360]

    ldr	w1,	[sp, #8848]

    ldr	w2,	[sp, #8848]

    mov	w15,	w1
    str	w2,	[sp, #5360]

    ldr	w22,	[sp, #7844]

    ldr	w23,	[sp, #9884]

    ldr	w24,	[sp, #9884]

    mov	w22,	w23
    str	w24,	[sp, #7844]

    ldr	w27,	[sp, #7848]

    ldr	w26,	[sp, #9888]

    mov	w27,	w26
    ldr	w27,	[sp, #9888]

    str	w27,	[sp, #7848]

    ldr	w18,	[sp, #2020]

    ldr	w15,	[sp, #6020]

    ldr	w16,	[sp, #6020]

    mov	w18,	w15
    str	w16,	[sp, #2020]

    ldr	s13,	[sp, #1532]

    str	s14,	[sp, #1532]

    fmov	s13,	s14
    ldr	w9,	[sp, #7836]

    ldr	w17,	[sp, #11652]

    ldr	w18,	[sp, #11652]

    mov	w9,	w17
    str	w18,	[sp, #7836]

    ldr	s18,	[sp, #1556]

    str	s11,	[sp, #1556]

    fmov	s18,	s11
    ldr	w16,	[sp, #1896]

    ldr	w12,	[sp, #6016]

    ldr	w13,	[sp, #6016]

    mov	w16,	w12
    str	w13,	[sp, #1896]

    ldr	s13,	[sp, #1540]

    str	s8,	[sp, #1540]

    fmov	s13,	s8
    ldr	s13,	[sp, #1552]

    str	s14,	[sp, #1552]

    fmov	s13,	s14
    ldr	s31,	[sp, #1536]

    str	s11,	[sp, #1536]

    fmov	s31,	s11
    ldr	w1,	[sp, #5372]

    ldr	w15,	[sp, #8860]

    ldr	w16,	[sp, #8860]

    mov	w1,	w15
    str	w16,	[sp, #5372]

    ldr	w6,	[sp, #5400]

    ldr	w27,	[sp, #8876]

    ldr	w0,	[sp, #8876]

    mov	w6,	w27
    str	w0,	[sp, #5400]

    ldr	s31,	[sp, #1516]

    str	s14,	[sp, #1516]

    fmov	s31,	s14
    ldr	s13,	[sp, #1104]

    str	s11,	[sp, #1104]

    fmov	s13,	s11
    ldr	s13,	[sp, #1520]

    str	s11,	[sp, #1520]

    fmov	s13,	s11
    ldr	s2,	[sp, #1744]

    str	s8,	[sp, #1744]

    fmov	s2,	s8
    ldr	s18,	[sp, #1524]

    str	s8,	[sp, #1524]

    fmov	s18,	s8
    ldr	w6,	[sp, #5364]

    ldr	w4,	[sp, #8852]

    mov	w6,	w4
    ldr	w6,	[sp, #8852]

    str	w6,	[sp, #5364]

    ldr	s31,	[sp, #1116]

    str	s8,	[sp, #1116]

    fmov	s31,	s8
    ldr	w16,	[sp, #5984]

    ldr	w2,	[sp, #8880]

    ldr	w0,	[sp, #8880]

    mov	w16,	w2
    str	w0,	[sp, #5984]

    ldr	s18,	[sp, #1132]

    str	s11,	[sp, #1132]

    fmov	s18,	s11
    ldr	w23,	[sp, #1944]

    ldr	w13,	[sp, #6008]

    ldr	w14,	[sp, #6008]

    mov	w23,	w13
    str	w14,	[sp, #1944]

    ldr	w13,	[sp, #7296]

    ldr	w3,	[sp, #9896]

    ldr	w4,	[sp, #9896]

    mov	w13,	w3
    str	w4,	[sp, #7296]

    ldr	s20,	[sp, #1120]

    str	s14,	[sp, #1120]

    fmov	s20,	s14
    ldr	w13,	[sp, #5376]

    ldr	w18,	[sp, #8864]

    ldr	w19,	[sp, #8864]

    mov	w13,	w18
    str	w19,	[sp, #5376]

    ldr	s2,	[sp, #1112]

    str	s14,	[sp, #1112]

    fmov	s2,	s14
    ldr	w4,	[sp, #7292]

    ldr	w0,	[sp, #9892]

    ldr	w1,	[sp, #9892]

    mov	w4,	w0
    str	w1,	[sp, #7292]

    ldr	w6,	[sp, #5380]

    ldr	w21,	[sp, #8868]

    ldr	w22,	[sp, #8868]

    mov	w6,	w21
    str	w22,	[sp, #5380]

    ldr	s20,	[sp, #1100]

    str	s8,	[sp, #1100]

    fmov	s20,	s8
    ldr	s2,	[sp, #1088]

    str	s14,	[sp, #1088]

    fmov	s2,	s14
    ldr	w19,	[sp, #1956]

    ldr	w3,	[sp, #6012]

    ldr	w4,	[sp, #6012]

    mov	w19,	w3
    str	w4,	[sp, #1956]

    ldr	w13,	[sp, #5980]

    ldr	w24,	[sp, #8872]

    ldr	w25,	[sp, #8872]

    mov	w13,	w24
    str	w25,	[sp, #5980]

    ldr	s20,	[sp, #1156]

    str	s11,	[sp, #1156]

    fmov	s20,	s11
    ldr	w16,	[sp, #5368]

    ldr	w9,	[sp, #8856]

    ldr	w12,	[sp, #8856]

    mov	w16,	w9
    str	w12,	[sp, #5368]

    ldr	s2,	[sp, #1092]

    str	s11,	[sp, #1092]

    fmov	s2,	s11
    ldr	s18,	[sp, #1144]

    str	s8,	[sp, #1144]

    fmov	s18,	s8
    b	main_309

main_375:
    fadd	s13,	s25,	s16
    ldr	s14,	[sp, #1092]

    add	x27,	sp,	#944
    add	x23,	sp,	#964
    movz	fp,	#4260
    fadd	s14,	s13,	s14
    fadd	s14,	s14,	s27
    str	s14,	[sp, #1200]

    fadd	s14,	s24,	s7
    fadd	s8,	s14,	s17
    fadd	s13,	s8,	s9
    str	s13,	[sp, #1192]

    ldr	s9,	[sp, #1744]

    ldr	s8,	[sp, #1120]

    fadd	s13,	s26,	s9
    fadd	s14,	s13,	s8
    fadd	s8,	s14,	s6
    str	s8,	[sp, #1180]

    fadd	s8,	s22,	s23
    str	s8,	[sp, #1624]

    ldr	s11,	[sp, #1624]

    fadd	s11,	s11,	s10
    fadd	s10,	s1,	s28
    str	s11,	[sp, #1620]

    fadd	s10,	s10,	s4
    ldr	s13,	[sp, #1620]

    fadd	s9,	s10,	s30
    fadd	s14,	s13,	s29
    str	s14,	[sp, #1164]

    str	s9,	[sp, #1592]

    ldr	s14,	[sp, #1516]

    fadd	s8,	s14,	s21
    fadd	s9,	s8,	s5
    ldr	s8,	[sp, #1520]

    ldr	s14,	[sp, #1524]

    fadd	s9,	s9,	s8
    fadd	s10,	s15,	s14
    ldr	s8,	[sp, #1100]

    fadd	s13,	s10,	s12
    fadd	s13,	s13,	s8
    str	s13,	[sp, #1764]

    ldr	s12,	[sp, #1088]

    ldr	s8,	[sp, #1532]

    ldr	s15,	[sp, #1540]

    fadd	s8,	s8,	s12
    ldr	s10,	[sp, #1112]

    fadd	s13,	s8,	s15
    fadd	s8,	s13,	s10
    str	s8,	[sp, #1760]

    ldr	s10,	[sp, #1104]

    ldr	s14,	[sp, #1536]

    fadd	s8,	s14,	s10
    ldr	s14,	[sp, #1132]

    ldr	s12,	[sp, #1144]

    fadd	s13,	s8,	s14
    ldr	s14,	[sp, #1156]

    fadd	s15,	s13,	s12
    ldr	s10,	[sp, #1556]

    ldr	s12,	[sp, #1552]

    fadd	s11,	s14,	s10
    fadd	s14,	s11,	s12
    ldr	s12,	[sp, #1116]

    str	x27,	[sp, #1824]

    fadd	s12,	s14,	s12
    ldr	s13,	[sp, #1200]

    ldr	x27,	[sp, #1824]

    str	s13,	[x27]

    ldr	s14,	[sp, #1192]

    add	x27,	sp,	#948
    str	s14,	[x27]

    ldr	s8,	[sp, #1180]

    add	x27,	sp,	#952
    str	s8,	[x27]

    ldr	s14,	[sp, #1164]

    add	x27,	sp,	#956
    str	s14,	[x27]

    ldr	s8,	[sp, #1592]

    add	x27,	sp,	#960
    str	s8,	[x27]

    add	x27,	sp,	#968
    str	s9,	[x23]

    add	x23,	sp,	#980
    ldr	s14,	[sp, #1764]

    str	s14,	[x27]

    ldr	s10,	[sp, #1760]

    add	x27,	sp,	#972
    str	s10,	[x27]

    add	x27,	sp,	#976
    str	s15,	[x27]

    str	s12,	[x23]

    ldr	w18,	[sp, #5360]

    ldr	w20,	[sp, #7840]

    ldr	w25,	[sp, #7836]

    add	w19,	w18,	w20
    add	w1,	w19,	w25
    str	w1,	[sp, #4980]

    ldr	w23,	[sp, #7844]

    ldr	w25,	[sp, #7848]

    add	w20,	w25,	w23
    add	w23,	w20,	w7
    str	w23,	[sp, #1832]

    ldr	w20,	[sp, #5356]

    ldr	w28,	[sp, #5364]

    add	w0,	w10,	w20
    add	w1,	w0,	w28
    str	w1,	[sp, #5008]

    ldr	w27,	[sp, #5372]

    ldr	w20,	[sp, #7296]

    add	w1,	w20,	w27
    ldr	w27,	[sp, #7292]

    add	w25,	w1,	w27
    str	w25,	[sp, #1900]

    ldr	w1,	[sp, #5376]

    ldr	w21,	[sp, #5400]

    add	w1,	w1,	w21
    add	w1,	w1,	w11
    str	w1,	[sp, #1804]

    ldr	w25,	[sp, #5380]

    ldr	w24,	[sp, #5984]

    ldr	w18,	[sp, #5368]

    add	w1,	w25,	w24
    add	w18,	w1,	w18
    str	w18,	[sp, #1808]

    ldr	w18,	[sp, #1944]

    ldr	w27,	[sp, #1896]

    ldr	w19,	[sp, #5980]

    add	w18,	w18,	w27
    add	w25,	w18,	w19
    str	w25,	[sp, #1792]

    ldr	w26,	[sp, #2020]

    ldr	w20,	[sp, #2136]

    ldr	w28,	[sp, #1956]

    add	w20,	w26,	w20
    add	w0,	w20,	w28
    add	x20,	sp,	#1012
    str	w0,	[sp, #1796]

    add	x0,	sp,	#984
    str	x0,	[sp, #2032]

    add	x0,	sp,	#988
    ldr	x1,	[sp, #2032]

    ldr	w21,	[sp, #4980]

    str	w21,	[x1]

    str	x0,	[sp, #4016]

    add	x0,	sp,	#992
    ldr	w19,	[sp, #1832]

    ldr	x1,	[sp, #4016]

    str	w19,	[x1]

    str	x0,	[sp, fp]

    add	x0,	sp,	#1000
    movz	fp,	#4260
    ldr	x1,	[sp, fp]

    movz	fp,	#4284
    ldr	w23,	[sp, #5008]

    str	w23,	[x1]

    add	x1,	sp,	#996
    str	x1,	[sp, fp]

    movz	fp,	#4284
    ldr	w25,	[sp, #1900]

    ldr	x24,	[sp, fp]

    str	w25,	[x24]

    add	x25,	sp,	#1004
    str	x0,	[sp, #2048]

    ldr	w18,	[sp, #1804]

    ldr	x1,	[sp, #2048]

    str	w18,	[x1]

    str	x25,	[sp, #2064]

    ldr	w24,	[sp, #1808]

    ldr	x26,	[sp, #2064]

    str	w24,	[x26]

    add	x26,	sp,	#1008
    str	x26,	[sp, #2088]

    ldr	w21,	[sp, #1792]

    ldr	x27,	[sp, #2088]

    str	w21,	[x27]

    str	x20,	[sp, #1816]

    ldr	x0,	[sp, #1816]

    ldr	w19,	[sp, #1796]

    str	w19,	[x0]

    ldr	x1,	[sp, #1824]

    movz	w0,	#10
    bl	putfarray
    ldr	x1,	[sp, #2032]

    movz	w0,	#8
    bl	putarray
    movz	fp,	#4260
    ldr	w23,	[sp, #4980]

    ldr	s4,	[sp, #1200]

    scvtf	s27,	w23
    ldr	x27,	[sp, #2032]

    fsub	s24,	s27,	s4
    fcvtzs	w16,	s24
    str	w16,	[x27]

    ldr	w1,	[sp, #1832]

    ldr	s29,	[sp, #1192]

    scvtf	s28,	w1
    ldr	x9,	[sp, #4016]

    fsub	s27,	s28,	s29
    fcvtzs	w19,	s27
    str	w19,	[x9]

    ldr	w7,	[sp, #5008]

    ldr	s16,	[sp, #1180]

    scvtf	s2,	w7
    ldr	x10,	[sp, fp]

    fsub	s30,	s2,	s16
    movz	fp,	#4284
    fcvtzs	w1,	s30
    str	w1,	[x10]

    ldr	w5,	[sp, #1900]

    ldr	s28,	[sp, #1164]

    scvtf	s5,	w5
    ldr	x24,	[sp, fp]

    fsub	s2,	s5,	s28
    movz	fp,	#4884
    fcvtzs	w0,	s2
    str	w0,	[x24]

    ldr	w9,	[sp, #1804]

    ldr	s21,	[sp, #1592]

    scvtf	s4,	w9
    ldr	x14,	[sp, #2048]

    fsub	s18,	s4,	s21
    fcvtzs	w3,	s18
    str	w3,	[x14]

    ldr	w13,	[sp, #1808]

    ldr	x23,	[sp, #2064]

    scvtf	s22,	w13
    fsub	s6,	s22,	s9
    fcvtzs	w2,	s6
    str	w2,	[x23]

    ldr	w23,	[sp, #1792]

    ldr	s13,	[sp, #1764]

    scvtf	s9,	w23
    ldr	x8,	[sp, #2088]

    add	x23,	sp,	#904
    fsub	s3,	s9,	s13
    fcvtzs	w5,	s3
    str	w5,	[x8]

    ldr	w28,	[sp, #1796]

    ldr	s9,	[sp, #1760]

    scvtf	s6,	w28
    ldr	x28,	[sp, #1816]

    fsub	s5,	s6,	s9
    fcvtzs	w8,	s5
    str	w8,	[x28]

    ldr	w18,	[sp, #3220]

    lsl	w10,	w18,	#2
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#984
    ldr	w11,	[x9]

    ldr	x14,	[sp, #3120]

    scvtf	s8,	w11
    mov	x10,	x14
    str	x10,	[sp, fp]

    movz	fp,	#4900
    ldr	x10,	[sp, #3112]

    mov	x13,	x10
    str	x13,	[sp, #2616]

    ldr	x6,	[sp, #3104]

    ldr	x2,	[sp, #3096]

    mov	x16,	x6
    mov	x20,	x2
    str	x20,	[sp, fp]

    movz	fp,	#4916
    ldr	x25,	[sp, #3080]

    mov	x28,	x25
    add	x25,	sp,	#936
    str	x28,	[sp, fp]

    movz	fp,	#4924
    ldr	x11,	[sp, #3056]

    mov	x18,	x11
    str	x18,	[sp, #2624]

    ldr	x3,	[sp, #3040]

    mov	x22,	x3
    str	x22,	[sp, #2632]

    ldr	x0,	[sp, #3032]

    str	x0,	[sp, #2640]

    ldr	x26,	[sp, #3024]

    mov	x2,	x26
    str	x2,	[sp, #2648]

    ldr	x22,	[sp, #3016]

    mov	x0,	x22
    str	x0,	[sp, fp]

    movz	fp,	#4932
    ldr	x18,	[sp, #3008]

    mov	x3,	x18
    str	x3,	[sp, fp]

    movz	fp,	#4940
    ldr	x12,	[sp, #3000]

    mov	x6,	x12
    str	x6,	[sp, fp]

    movz	fp,	#4948
    ldr	x8,	[sp, #2992]

    mov	x6,	x8
    str	x6,	[sp, #2656]

    ldr	x4,	[sp, #2984]

    mov	x9,	x4
    str	x9,	[sp, fp]

    movz	fp,	#4956
    ldr	x13,	[sp, #2976]

    mov	x12,	x13
    add	x13,	sp,	#940
    str	x12,	[sp, fp]

    movz	fp,	#4964
    ldr	x17,	[sp, #2968]

    str	x17,	[sp, fp]

    movz	fp,	#4972
    ldr	x10,	[sp, #2960]

    str	x10,	[sp, #2664]

    ldr	x6,	[sp, #2952]

    mov	x17,	x6
    str	x17,	[sp, #2672]

    ldr	x2,	[sp, #2944]

    mov	x20,	x2
    str	x20,	[sp, fp]

    movz	fp,	#7820
    ldr	x0,	[sp, #2936]

    mov	x27,	x0
    str	x27,	[sp, #4984]

    add	x27,	sp,	#916
    ldr	x3,	[sp, #2920]

    mov	x1,	x3
    str	x1,	[sp, #2680]

    ldr	x26,	[sp, #2904]

    mov	x5,	x26
    str	x5,	[sp, #2688]

    ldr	x3,	[sp, #2896]

    mov	x0,	x3
    str	x0,	[sp, #4992]

    ldr	x28,	[sp, #2880]

    mov	x2,	x28
    str	x2,	[sp, #5000]

    ldr	x3,	[sp, #2872]

    mov	x11,	x3
    str	x11,	[sp, fp]

    movz	fp,	#5012
    ldr	x15,	[sp, #2864]

    mov	x9,	x15
    str	x9,	[sp, fp]

    movz	fp,	#5020
    ldr	x5,	[sp, #2856]

    str	x5,	[sp, #2696]

    ldr	x8,	[sp, #2848]

    mov	x12,	x8
    str	x12,	[sp, fp]

    movz	fp,	#5028
    ldr	x2,	[sp, #2840]

    mov	x17,	x2
    str	x17,	[sp, fp]

    movz	fp,	#5036
    ldr	x5,	[sp, #2832]

    mov	x9,	x5
    str	x9,	[sp, #2704]

    ldr	x3,	[sp, #2824]

    mov	x14,	x3
    str	x14,	[sp, #2712]

    ldr	x22,	[sp, #2816]

    mov	x12,	x22
    str	x12,	[sp, fp]

    movz	fp,	#5052
    ldr	x17,	[sp, #2808]

    mov	x21,	x17
    str	x21,	[sp, fp]

    movz	fp,	#5060
    ldr	x7,	[sp, #2792]

    mov	x28,	x7
    str	x28,	[sp, #2720]

    add	x28,	sp,	#908
    ldr	x11,	[sp, #2776]

    mov	x10,	x11
    str	x10,	[sp, #2728]

    ldr	x4,	[sp, #2768]

    mov	x24,	x4
    str	x24,	[sp, fp]

    movz	fp,	#5076
    ldr	x26,	[sp, #2760]

    mov	x0,	x26
    str	x0,	[sp, fp]

    movz	fp,	#5084
    ldr	x21,	[sp, #2752]

    mov	x2,	x21
    add	x21,	sp,	#924
    str	x2,	[sp, fp]

    movz	fp,	#5092
    ldr	x10,	[sp, #2744]

    mov	x5,	x10
    str	x5,	[sp, fp]

    movz	fp,	#5100
    ldr	x11,	[sp, #2736]

    mov	x8,	x11
    str	x8,	[sp, fp]

    movz	fp,	#2420
    str	x23,	[sp, #2576]

    add	x23,	sp,	#912
    str	x28,	[sp, #2400]

    mov	x28,	x16
    str	x23,	[sp, #2408]

    str	x27,	[sp, fp]

    movz	fp,	#2452
    add	x27,	sp,	#920
    str	x27,	[sp, #2432]

    add	x27,	sp,	#928
    str	x21,	[sp, #2440]

    add	x21,	sp,	#932
    str	x27,	[sp, fp]

    movz	fp,	#2460
    str	x21,	[sp, fp]

    movz	fp,	#4884
    str	x25,	[sp, #2472]

    str	x13,	[sp, #2480]

    ldr	x11,	[sp, fp]

    movz	fp,	#4900
    mov	x27,	x11
    str	x27,	[sp, #5384]

    ldr	x18,	[sp, #2616]

    mov	x22,	x18
    str	x22,	[sp, #1048]

    str	x28,	[sp, #1024]

    ldr	x19,	[sp, fp]

    movz	fp,	#4916
    mov	x22,	x19
    str	x22,	[sp, #2552]

    ldr	x27,	[sp, fp]

    movz	fp,	#2508
    mov	x10,	x27
    str	x10,	[sp, #2496]

    ldr	x27,	[sp, #2624]

    mov	x23,	x27
    str	x23,	[sp, fp]

    movz	fp,	#4924
    ldr	x28,	[sp, #2632]

    mov	x13,	x28
    str	x13,	[sp, #2520]

    ldr	x23,	[sp, #2640]

    mov	x25,	x23
    str	x25,	[sp, #2528]

    ldr	x27,	[sp, #2648]

    mov	x28,	x27
    str	x28,	[sp, #2536]

    ldr	x1,	[sp, fp]

    movz	fp,	#4932
    mov	x2,	x1
    str	x2,	[sp, #2488]

    ldr	x4,	[sp, fp]

    movz	fp,	#4940
    mov	x16,	x4
    str	x16,	[sp, #2384]

    ldr	x7,	[sp, fp]

    movz	fp,	#2364
    mov	x25,	x7
    str	x25,	[sp, fp]

    movz	fp,	#4948
    ldr	x28,	[sp, #2656]

    mov	x27,	x28
    str	x27,	[sp, #2376]

    ldr	x10,	[sp, fp]

    movz	fp,	#4956
    mov	x22,	x10
    str	x22,	[sp, #2352]

    ldr	x13,	[sp, fp]

    movz	fp,	#4964
    mov	x22,	x13
    str	x22,	[sp, #2336]

    ldr	x16,	[sp, fp]

    movz	fp,	#4972
    mov	x27,	x16
    str	x27,	[sp, #2312]

    ldr	x23,	[sp, #2664]

    mov	x2,	x23
    str	x2,	[sp, #2320]

    ldr	x27,	[sp, #2672]

    mov	x10,	x27
    str	x10,	[sp, #2328]

    ldr	x19,	[sp, fp]

    movz	fp,	#7820
    mov	x22,	x19
    str	x22,	[sp, #2304]

    ldr	x26,	[sp, #4984]

    mov	x28,	x26
    str	x28,	[sp, #2256]

    ldr	x22,	[sp, #2680]

    mov	x13,	x22
    str	x13,	[sp, #2272]

    ldr	x23,	[sp, #2688]

    mov	x21,	x23
    str	x21,	[sp, #2288]

    ldr	x0,	[sp, #4992]

    mov	x4,	x0
    str	x4,	[sp, #2240]

    ldr	x3,	[sp, #5000]

    mov	x4,	x3
    str	x4,	[sp, #2224]

    ldr	x4,	[sp, fp]

    movz	fp,	#5012
    str	x4,	[sp, #2200]

    ldr	x10,	[sp, fp]

    movz	fp,	#2164
    str	x10,	[sp, fp]

    movz	fp,	#2180
    ldr	x28,	[sp, #2696]

    mov	x23,	x28
    str	x23,	[sp, fp]

    movz	fp,	#5020
    ldr	x13,	[sp, fp]

    movz	fp,	#2140
    mov	x9,	x13
    str	x9,	[sp, fp]

    movz	fp,	#5028
    ldr	x16,	[sp, fp]

    movz	fp,	#2004
    mov	x26,	x16
    str	x26,	[sp, fp]

    movz	fp,	#5036
    ldr	x21,	[sp, #2704]

    mov	x4,	x21
    str	x4,	[sp, #2096]

    ldr	x25,	[sp, #2712]

    mov	x0,	x25
    str	x0,	[sp, #2112]

    ldr	x19,	[sp, fp]

    movz	fp,	#1988
    mov	x2,	x19
    str	x2,	[sp, fp]

    movz	fp,	#5052
    ldr	x25,	[sp, fp]

    movz	fp,	#1876
    mov	x22,	x25
    str	x22,	[sp, #1960]

    ldr	x27,	[sp, #2720]

    str	x27,	[sp, fp]

    movz	fp,	#5060
    ldr	x3,	[sp, #2728]

    mov	x0,	x3
    str	x0,	[sp, #1888]

    ldr	x28,	[sp, fp]

    movz	fp,	#1948
    str	x28,	[sp, fp]

    movz	fp,	#5076
    ldr	x5,	[sp, fp]

    movz	fp,	#5084
    mov	x2,	x5
    str	x2,	[sp, #1864]

    ldr	x8,	[sp, fp]

    movz	fp,	#5092
    mov	x19,	x8
    str	x19,	[sp, #1856]

    ldr	x11,	[sp, fp]

    movz	fp,	#5100
    mov	x19,	x11
    str	x19,	[sp, #1920]

    ldr	x14,	[sp, fp]

    mov	x22,	x14
    str	x22,	[sp, #1968]


main_518:
    ldr	w21,	[sp, #3220]

    movz	fp,	#2508
    ldr	x28,	[sp, #5384]

    lsl	w6,	w21,	#2
    add	x5,	x28,	x6
    ldr	s22,	[x5]

    ldr	w20,	[sp, #3220]

    ldr	x16,	[sp, #1048]

    lsl	w9,	w20,	#2
    add	x8,	x16,	x9
    ldr	s10,	[x8]

    ldr	w23,	[sp, #3220]

    fadd	s26,	s22,	s10
    ldr	x3,	[sp, #1024]

    lsl	w17,	w23,	#2
    add	x12,	x3,	x17
    ldr	s15,	[x12]

    ldr	w24,	[sp, #3220]

    fadd	s30,	s26,	s15
    ldr	x20,	[sp, #2552]

    lsl	w18,	w24,	#2
    add	x17,	x20,	x18
    ldr	s20,	[x17]

    ldr	w26,	[sp, #3220]

    fadd	s29,	s30,	s20
    ldr	x1,	[sp, #2496]

    lsl	w4,	w26,	#2
    add	x23,	x1,	x4
    ldr	s25,	[x23]

    ldr	w27,	[sp, #3220]

    ldr	x11,	[sp, fp]

    lsl	w3,	w27,	#2
    movz	fp,	#2364
    add	x0,	x11,	x3
    ldr	s7,	[x0]

    ldr	w28,	[sp, #3220]

    fadd	s31,	s25,	s7
    ldr	x23,	[sp, #2520]

    lsl	w3,	w28,	#2
    add	x1,	x23,	x3
    ldr	s10,	[x1]

    ldr	w0,	[sp, #3220]

    fadd	s5,	s31,	s10
    lsl	w6,	w0,	#2
    ldr	x0,	[sp, #2528]

    add	x2,	x0,	x6
    ldr	s16,	[x2]

    ldr	w1,	[sp, #3220]

    fadd	s17,	s5,	s16
    ldr	x5,	[sp, #2536]

    lsl	w10,	w1,	#2
    add	x6,	x5,	x10
    ldr	s7,	[x6]

    ldr	w2,	[sp, #3220]

    ldr	x24,	[sp, #2488]

    lsl	w10,	w2,	#2
    add	x9,	x24,	x10
    ldr	s13,	[x9]

    ldr	w3,	[sp, #3220]

    fadd	s9,	s7,	s13
    ldr	x11,	[sp, #2384]

    lsl	w18,	w3,	#2
    add	x14,	x11,	x18
    ldr	s15,	[x14]

    ldr	w4,	[sp, #3220]

    fadd	s13,	s9,	s15
    ldr	x24,	[sp, fp]

    lsl	w19,	w4,	#2
    movz	fp,	#2164
    add	x18,	x24,	x19
    ldr	s24,	[x18]

    ldr	w5,	[sp, #3220]

    fadd	s20,	s13,	s24
    ldr	x6,	[sp, #2376]

    lsl	w1,	w5,	#2
    add	x0,	x6,	x1
    ldr	s13,	[x0]

    ldr	w6,	[sp, #3220]

    ldr	x12,	[sp, #2352]

    lsl	w0,	w6,	#2
    add	x1,	x12,	x0
    ldr	s27,	[x1]

    ldr	w7,	[sp, #3220]

    fadd	s13,	s13,	s27
    ldr	x2,	[sp, #2336]

    lsl	w0,	w7,	#2
    add	x2,	x2,	x0
    ldr	s1,	[x2]

    ldr	w8,	[sp, #3220]

    fadd	s19,	s13,	s1
    ldr	x13,	[sp, #2312]

    lsl	w4,	w8,	#2
    add	x3,	x13,	x4
    ldr	s6,	[x3]

    ldr	w9,	[sp, #3220]

    fadd	s11,	s19,	s6
    ldr	x18,	[sp, #2320]

    lsl	w8,	w9,	#2
    add	x7,	x18,	x8
    ldr	s14,	[x7]

    ldr	w10,	[sp, #3220]

    ldr	x26,	[sp, #2328]

    lsl	w11,	w10,	#2
    add	x10,	x26,	x11
    ldr	s2,	[x10]

    ldr	w11,	[sp, #3220]

    fadd	s13,	s14,	s2
    ldr	x8,	[sp, #2304]

    lsl	w19,	w11,	#2
    add	x15,	x8,	x19
    ldr	s7,	[x15]

    ldr	w12,	[sp, #3220]

    fadd	s19,	s13,	s7
    ldr	x4,	[sp, #2256]

    lsl	w25,	w12,	#2
    add	x19,	x4,	x25
    ldr	s14,	[x19]

    ldr	w13,	[sp, #3220]

    fadd	s1,	s19,	s14
    ldr	x14,	[sp, #2272]

    lsl	w2,	w13,	#2
    add	x1,	x14,	x2
    ldr	s19,	[x1]

    ldr	w14,	[sp, #3220]

    ldr	x27,	[sp, #2288]

    lsl	w1,	w14,	#2
    add	x2,	x27,	x1
    ldr	s28,	[x2]

    ldr	w15,	[sp, #3220]

    fadd	s19,	s19,	s28
    ldr	x20,	[sp, #2240]

    lsl	w1,	w15,	#2
    add	x0,	x20,	x1
    ldr	s7,	[x0]

    ldr	w16,	[sp, #3220]

    fadd	s25,	s19,	s7
    ldr	x10,	[sp, #2224]

    lsl	w5,	w16,	#2
    add	x4,	x10,	x5
    ldr	s15,	[x4]

    ldr	w17,	[sp, #3220]

    fadd	s30,	s25,	s15
    ldr	x23,	[sp, #2200]

    lsl	w9,	w17,	#2
    add	x8,	x23,	x9
    ldr	s14,	[x8]

    ldr	w18,	[sp, #3220]

    ldr	x27,	[sp, fp]

    lsl	w12,	w18,	#2
    movz	fp,	#2180
    add	x11,	x27,	x12
    ldr	s3,	[x11]

    ldr	w19,	[sp, #3220]

    fadd	s6,	s14,	s3
    ldr	x8,	[sp, fp]

    lsl	w20,	w19,	#2
    movz	fp,	#2140
    add	x16,	x8,	x20
    ldr	s14,	[x16]

    ldr	w20,	[sp, #3220]

    fadd	s18,	s6,	s14
    ldr	x11,	[sp, fp]

    lsl	w2,	w20,	#2
    movz	fp,	#2004
    add	x22,	x11,	x2
    ldr	s21,	[x22]

    ldr	w23,	[sp, #3220]

    fadd	s31,	s18,	s21
    ldr	x0,	[sp, fp]

    lsl	w5,	w23,	#2
    movz	fp,	#1988
    add	x0,	x0,	x5
    ldr	s19,	[x0]

    ldr	w24,	[sp, #3220]

    ldr	x13,	[sp, #2096]

    lsl	w2,	w24,	#2
    add	x0,	x13,	x2
    ldr	s2,	[x0]

    ldr	w26,	[sp, #3220]

    fadd	s27,	s19,	s2
    ldr	x23,	[sp, #2112]

    lsl	w2,	w26,	#2
    add	x1,	x23,	x2
    ldr	s12,	[x1]

    ldr	w27,	[sp, #3220]

    fadd	s14,	s27,	s12
    ldr	x16,	[sp, fp]

    lsl	w6,	w27,	#2
    movz	fp,	#1876
    add	x5,	x16,	x6
    ldr	s7,	[x5]

    ldr	w28,	[sp, #3220]

    fadd	s14,	s14,	s7
    ldr	x16,	[sp, #1960]

    lsl	w10,	w28,	#2
    add	x9,	x16,	x10
    ldr	s15,	[x9]

    ldr	w0,	[sp, #3220]

    ldr	x23,	[sp, fp]

    lsl	w14,	w0,	#2
    movz	fp,	#1948
    add	x12,	x23,	x14
    ldr	s10,	[x12]

    ldr	w1,	[sp, #3220]

    fadd	s25,	s15,	s10
    ldr	x3,	[sp, #1888]

    lsl	w23,	w1,	#2
    add	x17,	x3,	x23
    ldr	s18,	[x17]

    ldr	w2,	[sp, #3220]

    fadd	s23,	s25,	s18
    ldr	x6,	[sp, fp]

    lsl	w3,	w2,	#2
    movz	fp,	#2420
    add	x23,	x6,	x3
    ldr	s28,	[x23]

    ldr	w3,	[sp, #3220]

    fadd	s27,	s23,	s28
    ldr	x18,	[sp, #1864]

    lsl	w0,	w3,	#2
    add	x1,	x18,	x0
    ldr	s23,	[x1]

    ldr	w4,	[sp, #3220]

    ldr	x13,	[sp, #1856]

    lsl	w3,	w4,	#2
    add	x1,	x13,	x3
    ldr	s5,	[x1]

    ldr	w5,	[sp, #3220]

    fadd	s21,	s23,	s5
    ldr	x27,	[sp, #1920]

    lsl	w3,	w5,	#2
    add	x2,	x27,	x3
    ldr	s22,	[x2]

    ldr	w6,	[sp, #3220]

    fadd	s6,	s21,	s22
    ldr	x25,	[sp, #1968]

    lsl	w7,	w6,	#2
    add	x6,	x25,	x7
    ldr	s28,	[x6]

    ldr	x17,	[sp, #2576]

    fadd	s16,	s6,	s28
    str	s29,	[x17]

    movi	v6.4s,	#0
    ldr	x20,	[sp, #2400]

    str	s17,	[x20]

    ldr	x25,	[sp, #2408]

    str	s20,	[x25]

    ldr	x3,	[sp, fp]

    movz	fp,	#2452
    str	s11,	[x3]

    ldr	x14,	[sp, #2432]

    str	s1,	[x14]

    ldr	x17,	[sp, #2440]

    str	s30,	[x17]

    ldr	x0,	[sp, fp]

    movz	fp,	#2460
    str	s31,	[x0]

    ldr	x1,	[sp, fp]

    str	s14,	[x1]

    ldr	x12,	[sp, #2472]

    str	s27,	[x12]

    ldr	x15,	[sp, #2480]

    str	s16,	[x15]

    ldr	s24,	[x6]

    fcmp	s24,	s6
    cset	w11,	ne
    mov	w12,	w11
    cmp	w12,	#0
    movi	v5.4s,	#0
    cset	w14,	ne
    mov	w15,	w14
    scvtf	s29,	w15
    fcmp	s29,	s5
    movi	v4.4s,	#0
    cset	w17,	ne
    mov	w18,	w17
    scvtf	s1,	w18
    fcmp	s1,	s4
    bne	main_679

main_517:
    ldr	x17,	[sp, #1048]

    movz	fp,	#2508
    mov	x0,	x17
    str	x0,	[sp, #5384]

    ldr	x0,	[sp, #1024]

    mov	x17,	x0
    str	x17,	[sp, #1048]

    ldr	x19,	[sp, #2552]

    mov	x1,	x19
    str	x1,	[sp, #1024]

    ldr	x26,	[sp, #2496]

    mov	x20,	x26
    str	x20,	[sp, #2552]

    ldr	x6,	[sp, fp]

    movz	fp,	#2508
    mov	x28,	x6
    str	x28,	[sp, #2496]

    ldr	x19,	[sp, #2520]

    mov	x7,	x19
    str	x7,	[sp, fp]

    movz	fp,	#2364
    ldr	x26,	[sp, #2528]

    mov	x20,	x26
    str	x20,	[sp, #2520]

    ldr	x1,	[sp, #2536]

    mov	x28,	x1
    str	x28,	[sp, #2528]

    ldr	x19,	[sp, #2488]

    mov	x2,	x19
    str	x2,	[sp, #2536]

    ldr	x3,	[sp, #2384]

    mov	x20,	x3
    str	x20,	[sp, #2488]

    ldr	x16,	[sp, fp]

    movz	fp,	#2364
    mov	x4,	x16
    str	x4,	[sp, #2384]

    ldr	x0,	[sp, #2376]

    mov	x17,	x0
    str	x17,	[sp, fp]

    movz	fp,	#2164
    ldr	x3,	[sp, #2352]

    mov	x0,	x3
    str	x0,	[sp, #2376]

    ldr	x21,	[sp, #2336]

    mov	x4,	x21
    str	x4,	[sp, #2352]

    ldr	x3,	[sp, #2312]

    mov	x22,	x3
    str	x22,	[sp, #2336]

    ldr	x11,	[sp, #2320]

    mov	x4,	x11
    str	x4,	[sp, #2312]

    ldr	x16,	[sp, #2328]

    mov	x12,	x16
    str	x12,	[sp, #2320]

    ldr	x0,	[sp, #2304]

    mov	x17,	x0
    str	x17,	[sp, #2328]

    ldr	x21,	[sp, #2256]

    mov	x0,	x21
    str	x0,	[sp, #2304]

    ldr	x3,	[sp, #2272]

    mov	x22,	x3
    str	x22,	[sp, #2256]

    ldr	x16,	[sp, #2288]

    mov	x4,	x16
    str	x4,	[sp, #2272]

    ldr	x11,	[sp, #2240]

    mov	x17,	x11
    str	x17,	[sp, #2288]

    ldr	x0,	[sp, #2224]

    mov	x12,	x0
    str	x12,	[sp, #2240]

    ldr	x11,	[sp, #2200]

    mov	x0,	x11
    str	x0,	[sp, #2224]

    ldr	x13,	[sp, fp]

    movz	fp,	#2180
    mov	x12,	x13
    str	x12,	[sp, #2200]

    ldr	x25,	[sp, fp]

    movz	fp,	#2164
    mov	x14,	x25
    str	x14,	[sp, fp]

    movz	fp,	#2140
    ldr	x28,	[sp, fp]

    movz	fp,	#2180
    mov	x26,	x28
    str	x26,	[sp, fp]

    movz	fp,	#2004
    ldr	x13,	[sp, fp]

    movz	fp,	#2140
    mov	x0,	x13
    str	x0,	[sp, fp]

    movz	fp,	#2004
    ldr	x0,	[sp, #2096]

    mov	x14,	x0
    str	x14,	[sp, fp]

    movz	fp,	#1988
    ldr	x6,	[sp, #2112]

    mov	x0,	x6
    str	x0,	[sp, #2096]

    ldr	x0,	[sp, fp]

    movz	fp,	#1988
    mov	x7,	x0
    str	x7,	[sp, #2112]

    ldr	x0,	[sp, #1960]

    mov	x1,	x0
    str	x1,	[sp, fp]

    movz	fp,	#1876
    ldr	x4,	[sp, fp]

    movz	fp,	#1876
    mov	x0,	x4
    str	x0,	[sp, #1960]

    ldr	x15,	[sp, #1888]

    mov	x5,	x15
    str	x5,	[sp, fp]

    movz	fp,	#1948
    ldr	x17,	[sp, fp]

    movz	fp,	#1948
    mov	x16,	x17
    str	x16,	[sp, #1888]

    ldr	x0,	[sp, #1864]

    mov	x18,	x0
    str	x18,	[sp, fp]

    ldr	x25,	[sp, #1856]

    mov	x1,	x25
    str	x1,	[sp, #1864]

    ldr	x5,	[sp, #1920]

    mov	x26,	x5
    str	x26,	[sp, #1856]

    ldr	x26,	[sp, #1968]

    mov	x6,	x26
    str	x6,	[sp, #1920]

    ldr	x18,	[sp, #2576]

    mov	x28,	x18
    str	x28,	[sp, #1968]

    b	main_518

main_679:
    movz	w0,	#10
    ldr	x1,	[sp, #2576]

    bl	putfarray
    add	x4,	sp,	#888
    add	x17,	sp,	#876
    add	x5,	sp,	#856
    movz	fp,	#4692
    ldr	w7,	[sp, #3220]

    lsl	w24,	w7,	#2
    mov	x21,	x24
    add	x21,	sp,	x21
    add	x21,	x21,	#904
    ldr	s13,	[x21]

    ldr	x27,	[sp, #3088]

    ldr	x0,	[sp, #2800]

    mov	x2,	x27
    ldr	x1,	[sp, #3144]

    mov	x9,	x0
    mov	x14,	x2
    add	x27,	sp,	#860
    ldr	x21,	[sp, #3064]

    mov	x15,	x1
    ldr	x13,	[sp, #3048]

    mov	x6,	x21
    mov	x18,	x13
    str	x18,	[sp, #4056]

    ldr	x22,	[sp, #2888]

    mov	x28,	x22
    str	x28,	[sp, fp]

    add	x28,	sp,	#844
    movz	fp,	#4708
    ldr	x11,	[sp, #2928]

    mov	x24,	x11
    str	x24,	[sp, #4072]

    add	x24,	sp,	#828
    ldr	x1,	[sp, #3072]

    mov	x0,	x1
    str	x0,	[sp, #4672]

    ldr	x0,	[sp, #2784]

    mov	x1,	x0
    add	x0,	sp,	#836
    str	x1,	[sp, fp]

    add	x1,	sp,	#832
    movz	fp,	#4700
    ldr	x25,	[sp, #2912]

    mov	x21,	x25
    str	x21,	[sp, #4064]

    ldr	x25,	[sp, #3128]

    mov	x3,	x25
    add	x25,	sp,	#824
    str	x3,	[sp, fp]

    movz	fp,	#5108
    ldr	x13,	[sp, #3136]

    mov	x19,	x13
    str	x19,	[sp, #4856]

    ldr	x26,	[sp, #3160]

    mov	x10,	x26
    str	x10,	[sp, #1840]

    ldr	x11,	[sp, #3152]

    mov	x13,	x11
    mov	x11,	x9
    str	x13,	[sp, #1848]

    add	x13,	sp,	#848
    str	x25,	[sp, #2344]

    add	x25,	sp,	#896
    str	x24,	[sp, fp]

    movz	fp,	#5068
    str	x1,	[sp, fp]

    add	x1,	sp,	#852
    movz	fp,	#5044
    str	x0,	[sp, fp]

    movz	fp,	#1980
    add	x0,	sp,	#840
    str	x0,	[sp, fp]

    add	x0,	sp,	#872
    movz	fp,	#2012
    str	x28,	[sp, fp]

    add	x28,	sp,	#884
    movz	fp,	#2148
    str	x13,	[sp, #2104]

    add	x13,	sp,	#864
    str	x1,	[sp, #2120]

    add	x1,	sp,	#868
    str	x5,	[sp, #2128]

    str	x27,	[sp, fp]

    movz	fp,	#4868
    str	x13,	[sp, #2608]

    add	x13,	sp,	#892
    str	x1,	[sp, #1016]

    add	x1,	sp,	#900
    str	x0,	[sp, #1032]

    str	x17,	[sp, #1040]

    add	x17,	sp,	#880
    str	x17,	[sp, #1064]

    str	x28,	[sp, #2560]

    str	x4,	[sp, #2568]

    str	x13,	[sp, #2584]

    str	x25,	[sp, #2592]

    str	x1,	[sp, #2600]

    ldr	s7,	[sp, #1292]

    str	x14,	[sp, #4000]

    fmov	s21,	s7
    ldr	w4,	[sp, #3188]

    mov	w3,	w4
    str	w3,	[sp, #1056]

    ldr	x1,	[sp, #2616]

    mov	x24,	x1
    str	x24,	[sp, fp]

    movz	fp,	#2156
    ldr	s5,	[sp, #1296]

    ldr	w26,	[sp, #3216]

    fmov	s9,	s5
    mov	w1,	w26
    str	w1,	[sp, #1060]

    mov	x1,	x6
    ldr	s10,	[sp, #1300]

    ldr	s6,	[sp, #1304]

    fmov	s12,	s10
    ldr	x16,	[sp, #2624]

    fmov	s4,	s6
    mov	x0,	x16
    str	x0,	[sp, #2296]

    str	x11,	[sp, #2264]

    ldr	w24,	[sp, #3200]

    mov	w11,	w24
    str	w11,	[sp, #2544]

    mov	x11,	x15
    ldr	w19,	[sp, #3192]

    mov	w0,	w19
    str	w0,	[sp, #2548]

    ldr	x10,	[sp, #2632]

    mov	x5,	x10
    str	x5,	[sp, #2280]

    str	x11,	[sp, #2248]

    str	x1,	[sp, #2192]

    ldr	w1,	[sp, #3180]

    mov	w9,	w1
    str	w9,	[sp, #2504]

    ldr	x0,	[sp, #2640]

    mov	x21,	x0
    str	x21,	[sp, #2208]

    ldr	x6,	[sp, #2648]

    mov	x27,	x6
    str	x27,	[sp, #2216]

    ldr	s1,	[sp, #1308]

    ldr	s3,	[sp, #1312]

    fmov	s2,	s1
    ldr	s25,	[sp, #1316]

    fmov	s18,	s3
    ldr	x15,	[sp, #2656]

    fmov	s22,	s25
    mov	x1,	x15
    str	x1,	[sp, #2232]

    ldr	w16,	[sp, #3172]

    mov	w3,	w16
    str	w3,	[sp, #2516]

    ldr	s24,	[sp, #1320]

    ldr	s28,	[sp, #1328]

    fmov	s15,	s24
    ldr	s7,	[sp, #1332]

    fmov	s14,	s28
    ldr	x11,	[sp, #4056]

    fmov	s26,	s7
    mov	x3,	x11
    str	x3,	[sp, fp]

    movz	fp,	#2172
    ldr	x24,	[sp, #2664]

    mov	x3,	x24
    str	x3,	[sp, fp]

    movz	fp,	#4692
    ldr	x21,	[sp, fp]

    movz	fp,	#1996
    mov	x1,	x21
    str	x1,	[sp, fp]

    movz	fp,	#4892
    ldr	x17,	[sp, #4072]

    mov	x16,	x17
    str	x16,	[sp, #2056]

    ldr	x28,	[sp, #2672]

    mov	x25,	x28
    str	x25,	[sp, #2072]

    ldr	s11,	[sp, #1336]

    ldr	s16,	[sp, #1340]

    fmov	s23,	s11
    ldr	x1,	[sp, #4672]

    fmov	s30,	s16
    mov	x7,	x1
    str	x7,	[sp, #2040]

    ldr	w15,	[sp, #3168]

    mov	w18,	w15
    str	w18,	[sp, #2468]

    ldr	x3,	[sp, #2680]

    mov	x13,	x3
    str	x13,	[sp, fp]

    movz	fp,	#4708
    ldr	x20,	[sp, #2688]

    mov	x1,	x20
    str	x1,	[sp, #2080]

    ldr	s10,	[sp, #1344]

    ldr	s24,	[sp, #1348]

    fmov	s1,	s10
    ldr	x27,	[sp, fp]

    fmov	s5,	s24
    movz	fp,	#4244
    str	x27,	[sp, fp]

    movz	fp,	#4908
    ldr	x14,	[sp, #4064]

    mov	x21,	x14
    str	x21,	[sp, fp]

    movz	fp,	#4700
    ldr	w0,	[sp, #3204]

    mov	w11,	w0
    str	w11,	[sp, #2416]

    ldr	w18,	[sp, #3196]

    mov	w7,	w18
    str	w7,	[sp, #2428]

    ldr	s24,	[sp, #1352]

    ldr	s6,	[sp, #1356]

    fmov	s19,	s24
    ldr	x24,	[sp, fp]

    fmov	s31,	s6
    movz	fp,	#4252
    mov	x3,	x24
    str	x3,	[sp, fp]

    movz	fp,	#4268
    ldr	w11,	[sp, #3176]

    mov	w18,	w11
    str	w18,	[sp, #2392]

    ldr	x7,	[sp, #2696]

    mov	x13,	x7
    str	x13,	[sp, #4008]

    ldr	w20,	[sp, #3184]

    mov	w21,	w20
    str	w21,	[sp, #2396]

    ldr	x12,	[sp, #4856]

    str	x12,	[sp, fp]

    movz	fp,	#4276
    ldr	x5,	[sp, #1840]

    mov	x22,	x5
    str	x22,	[sp, #4024]

    ldr	s29,	[sp, #1360]

    ldr	s28,	[sp, #1364]

    fmov	s7,	s29
    ldr	x18,	[sp, #2704]

    fmov	s29,	s28
    mov	x17,	x18
    str	x17,	[sp, fp]

    ldr	w7,	[sp, #3212]

    mov	w15,	w7
    str	w15,	[sp, #2372]

    ldr	x8,	[sp, #1848]

    mov	x26,	x8
    str	x26,	[sp, #2024]

    ldr	x26,	[sp, #2712]

    mov	x22,	x26
    str	x22,	[sp, #1912]

    ldr	s6,	[sp, #1368]

    ldr	w20,	[sp, #3216]

    fmov	s24,	s6
    mov	w9,	w20
    str	w9,	[sp, #2360]

    ldr	s27,	[sp, #1376]

    ldr	x9,	[sp, #2720]

    fmov	s17,	s27
    str	x9,	[sp, #1928]

    ldr	x14,	[sp, #2728]

    mov	x20,	x14
    str	x20,	[sp, #1936]

    ldr	s28,	[sp, #1380]

    ldr	w22,	[sp, #3208]

    mov	w12,	w22
    str	w12,	[sp, #2448]


main_717:
    ldr	w22,	[sp, #3220]

    movz	fp,	#4868
    lsl	w0,	w22,	#2
    ldr	x19,	[sp, fp]

    movz	fp,	#2172
    add	x12,	x19,	x0
    ldr	s27,	[x12]

    fadd	s6,	s21,	s27
    fadd	s11,	s6,	s9
    fadd	s27,	s11,	s12
    str	s27,	[sp, #1608]

    ldr	w4,	[sp, #3220]

    ldr	x12,	[sp, #2296]

    lsl	w23,	w4,	#2
    add	x20,	x12,	x23
    ldr	s20,	[x20]

    ldr	w9,	[sp, #3220]

    fadd	s25,	s4,	s20
    ldr	x12,	[sp, #2280]

    lsl	w21,	w9,	#2
    add	x8,	x12,	x21
    ldr	s11,	[x8]

    ldr	w10,	[sp, #3220]

    fadd	s3,	s25,	s11
    ldr	x12,	[sp, #2208]

    lsl	w10,	w10,	#2
    add	x27,	x12,	x10
    ldr	s11,	[x27]

    fadd	s6,	s3,	s11
    str	s6,	[sp, #1596]

    ldr	w11,	[sp, #3220]

    ldr	x20,	[sp, #2216]

    lsl	w23,	w11,	#2
    add	x20,	x20,	x23
    ldr	s11,	[x20]

    fadd	s25,	s11,	s2
    fadd	s20,	s25,	s18
    fadd	s6,	s20,	s22
    str	s6,	[sp, #1612]

    ldr	w8,	[sp, #3220]

    ldr	x0,	[sp, #2232]

    lsl	w7,	w8,	#2
    add	x12,	x0,	x7
    ldr	s11,	[x12]

    fadd	s27,	s11,	s15
    fadd	s11,	s27,	s14
    fadd	s27,	s11,	s26
    str	s27,	[sp, #1616]

    ldr	w17,	[sp, #3220]

    ldr	x26,	[sp, fp]

    lsl	w23,	w17,	#2
    movz	fp,	#4892
    add	x20,	x26,	x23
    ldr	s10,	[x20]

    ldr	w18,	[sp, #3220]

    ldr	x28,	[sp, #2072]

    lsl	w8,	w18,	#2
    add	x7,	x28,	x8
    ldr	s25,	[x7]

    fadd	s11,	s10,	s25
    fadd	s27,	s11,	s23
    fadd	s27,	s27,	s30
    str	s27,	[sp, #1600]

    ldr	w0,	[sp, #3220]

    ldr	x16,	[sp, fp]

    lsl	w0,	w0,	#2
    movz	fp,	#4276
    add	x7,	x16,	x0
    ldr	s25,	[x7]

    ldr	w8,	[sp, #3220]

    ldr	x2,	[sp, #2080]

    lsl	w23,	w8,	#2
    add	x20,	x2,	x23
    ldr	s11,	[x20]

    fadd	s25,	s25,	s11
    fadd	s27,	s25,	s1
    fadd	s6,	s27,	s5
    str	s6,	[sp, #1604]

    ldr	w11,	[sp, #3220]

    fadd	s6,	s19,	s31
    ldr	x15,	[sp, #4008]

    lsl	w7,	w11,	#2
    add	x23,	x15,	x7
    ldr	s25,	[x23]

    fadd	s11,	s6,	s25
    fadd	s11,	s11,	s7
    str	s11,	[sp, #1076]

    ldr	w12,	[sp, #3220]

    ldr	x19,	[sp, fp]

    lsl	w23,	w12,	#2
    movz	fp,	#5108
    add	x21,	x19,	x23
    ldr	s11,	[x21]

    ldr	w18,	[sp, #3220]

    fadd	s25,	s29,	s11
    ldr	x11,	[sp, #1912]

    lsl	w21,	w18,	#2
    add	x8,	x11,	x21
    ldr	s6,	[x8]

    fadd	s25,	s25,	s6
    fadd	s20,	s25,	s24
    str	s20,	[sp, #1136]

    ldr	w20,	[sp, #3220]

    ldr	x17,	[sp, #1928]

    lsl	w0,	w20,	#2
    add	x8,	x17,	x0
    ldr	s25,	[x8]

    ldr	w21,	[sp, #3220]

    fadd	s11,	s17,	s25
    ldr	x0,	[sp, #1936]

    lsl	w7,	w21,	#2
    add	x23,	x0,	x7
    ldr	s25,	[x23]

    fadd	s11,	s11,	s25
    fadd	s6,	s11,	s28
    str	s6,	[sp, #1176]

    ldr	s6,	[sp, #1608]

    ldr	x22,	[sp, #2344]

    str	s6,	[x22]

    ldr	s11,	[sp, #1596]

    ldr	x17,	[sp, fp]

    movz	fp,	#5068
    str	s11,	[x17]

    ldr	s11,	[sp, #1612]

    ldr	x2,	[sp, fp]

    movz	fp,	#5044
    str	s11,	[x2]

    ldr	s6,	[sp, #1616]

    ldr	x22,	[sp, fp]

    movz	fp,	#1980
    str	s6,	[x22]

    ldr	s6,	[sp, #1600]

    ldr	x4,	[sp, fp]

    movz	fp,	#2012
    str	s6,	[x4]

    ldr	s11,	[sp, #1604]

    ldr	x4,	[sp, fp]

    movz	fp,	#2148
    str	s11,	[x4]

    ldr	s25,	[sp, #1076]

    ldr	x21,	[sp, #2104]

    str	s25,	[x21]

    ldr	s11,	[sp, #1136]

    ldr	x11,	[sp, #2120]

    str	s11,	[x11]

    ldr	s11,	[sp, #1176]

    ldr	x18,	[sp, #2128]

    str	s11,	[x18]

    ldr	x9,	[sp, fp]

    movi	v11.4s,	#0
    movz	fp,	#2156
    str	s11,	[x9]

    ldr	w22,	[sp, #3220]

    ldr	x11,	[sp, #4000]

    lsl	w8,	w22,	#2
    add	x17,	x11,	x8
    ldr	w4,	[x17]

    ldr	w18,	[sp, #1056]

    ldr	w0,	[sp, #1060]

    add	w11,	w0,	w18
    add	w17,	w11,	w4
    str	w17,	[sp, #1872]

    ldr	w13,	[sp, #3220]

    ldr	x14,	[sp, #2264]

    lsl	w11,	w13,	#2
    add	x0,	x14,	x11
    ldr	w20,	[x0]

    ldr	w13,	[sp, #2544]

    ldr	w8,	[sp, #2548]

    add	w8,	w8,	w13
    add	w9,	w8,	w20
    str	w9,	[sp, #1976]

    ldr	w14,	[sp, #3220]

    ldr	x10,	[sp, #2248]

    lsl	w0,	w14,	#2
    add	x26,	x10,	x0
    ldr	w23,	[x26]

    ldr	w0,	[sp, #3220]

    ldr	x9,	[sp, #2192]

    lsl	w8,	w0,	#2
    add	x26,	x9,	x8
    ldr	w8,	[x26]

    ldr	w18,	[sp, #2504]

    add	w0,	w23,	w18
    add	w0,	w0,	w8
    str	w0,	[sp, #1908]

    ldr	w8,	[sp, #3220]

    ldr	x4,	[sp, fp]

    lsl	w11,	w8,	#2
    movz	fp,	#1996
    add	x0,	x4,	x11
    ldr	w12,	[x0]

    ldr	w11,	[sp, #2516]

    add	w7,	w12,	w11
    ldr	w12,	[sp, #3220]

    ldr	x14,	[sp, fp]

    lsl	w12,	w12,	#2
    movz	fp,	#4244
    add	x14,	x14,	x12
    ldr	w12,	[x14]

    add	w7,	w7,	w12
    str	w7,	[sp, #1800]

    ldr	w12,	[sp, #3220]

    ldr	x17,	[sp, #2056]

    lsl	w23,	w12,	#2
    add	x17,	x17,	x23
    ldr	w9,	[x17]

    ldr	w17,	[sp, #3220]

    ldr	x8,	[sp, #2040]

    lsl	w23,	w17,	#2
    add	x13,	x8,	x23
    ldr	w23,	[x13]

    ldr	w12,	[sp, #2468]

    add	w7,	w9,	w12
    add	w12,	w7,	w23
    str	w12,	[sp, #1904]

    ldr	w17,	[sp, #3220]

    ldr	x28,	[sp, fp]

    lsl	w27,	w17,	#2
    movz	fp,	#4908
    add	x22,	x28,	x27
    ldr	w13,	[x22]

    ldr	w20,	[sp, #3220]

    ldr	x23,	[sp, fp]

    lsl	w27,	w20,	#2
    movz	fp,	#4252
    add	x12,	x23,	x27
    ldr	w9,	[x12]

    ldr	w26,	[sp, #2416]

    add	w0,	w13,	w26
    add	w6,	w0,	w9
    str	w6,	[sp, #4628]

    ldr	w20,	[sp, #3220]

    ldr	x4,	[sp, fp]

    lsl	w2,	w20,	#2
    movz	fp,	#4268
    add	x17,	x4,	x2
    ldr	w12,	[x17]

    ldr	w23,	[sp, #2392]

    ldr	w18,	[sp, #2428]

    add	w7,	w23,	w18
    add	w14,	w7,	w12
    str	w14,	[sp, #4864]

    ldr	w21,	[sp, #3220]

    ldr	x13,	[sp, fp]

    lsl	w11,	w21,	#2
    add	x8,	x13,	x11
    ldr	w12,	[x8]

    ldr	w18,	[sp, #2396]

    ldr	w23,	[sp, #3220]

    add	w0,	w12,	w18
    lsl	w22,	w23,	#2
    ldr	x23,	[sp, #4024]

    add	x15,	x23,	x22
    ldr	w22,	[x15]

    add	w0,	w0,	w22
    str	w0,	[sp, #1836]

    ldr	w2,	[sp, #3220]

    ldr	x27,	[sp, #2024]

    lsl	w2,	w2,	#2
    add	x22,	x27,	x2
    ldr	w20,	[x22]

    fcvtzs	w22,	s28
    ldr	w17,	[sp, #2360]

    ldr	w15,	[sp, #2372]

    ldr	w23,	[sp, #2448]

    add	w17,	w17,	w15
    add	w8,	w17,	w23
    add	w3,	w8,	w20
    str	w3,	[sp, #4680]

    ldr	w21,	[sp, #1872]

    ldr	x0,	[sp, #2608]

    str	w21,	[x0]

    ldr	w13,	[sp, #1976]

    ldr	x4,	[sp, #1016]

    str	w13,	[x4]

    ldr	w8,	[sp, #1908]

    ldr	x12,	[sp, #1032]

    str	w8,	[x12]

    ldr	w15,	[sp, #1800]

    ldr	x18,	[sp, #1040]

    str	w15,	[x18]

    ldr	w15,	[sp, #1904]

    ldr	x21,	[sp, #1064]

    str	w15,	[x21]

    ldr	x10,	[sp, #2560]

    ldr	w7,	[sp, #4628]

    str	w7,	[x10]

    movz	w7,	#0
    ldr	x14,	[sp, #2568]

    ldr	w17,	[sp, #4864]

    str	w17,	[x14]

    ldr	x12,	[sp, #2584]

    ldr	w1,	[sp, #1836]

    str	w1,	[x12]

    ldr	x4,	[sp, #2592]

    ldr	w5,	[sp, #4680]

    str	w5,	[x4]

    ldr	x9,	[sp, #2600]

    str	w7,	[x9]

    ldr	w2,	[sp, #2448]

    ldr	w8,	[sp, #2448]

    scvtf	s25,	w2
    cmp	w8,	#0
    bne	main_889

main_716:
    ldr	x12,	[sp, #2608]

    movz	fp,	#4868
    fmov	s28,	s25
    mov	x11,	x12
    str	x11,	[sp, #4000]

    ldr	x17,	[sp, #2344]

    mov	x21,	x17
    str	x21,	[sp, fp]

    movz	fp,	#2156
    str	w22,	[sp, #2448]

    ldr	w12,	[sp, #1056]

    ldr	w18,	[sp, #6180]

    ldr	w19,	[sp, #6180]

    mov	w12,	w18
    str	w19,	[sp, #1056]

    ldr	w23,	[sp, #1060]

    ldr	w21,	[sp, #6184]

    ldr	w22,	[sp, #6184]

    mov	w23,	w21
    str	w22,	[sp, #1060]

    ldr	x14,	[sp, #2296]

    ldr	x11,	[sp, #6128]

    ldr	x12,	[sp, #6128]

    mov	x14,	x11
    str	x12,	[sp, #2296]

    ldr	x23,	[sp, #2264]

    ldr	x5,	[sp, #6112]

    ldr	x6,	[sp, #6112]

    mov	x23,	x5
    str	x6,	[sp, #2264]

    ldr	w26,	[sp, #2544]

    ldr	w12,	[sp, #6172]

    ldr	w13,	[sp, #6172]

    mov	w26,	w12
    str	w13,	[sp, #2544]

    ldr	w20,	[sp, #2548]

    ldr	w15,	[sp, #6176]

    ldr	w16,	[sp, #6176]

    mov	w20,	w15
    str	w16,	[sp, #2548]

    ldr	x0,	[sp, #2280]

    ldr	x8,	[sp, #6120]

    ldr	x9,	[sp, #6120]

    mov	x0,	x8
    str	x9,	[sp, #2280]

    ldr	x0,	[sp, #2248]

    ldr	x2,	[sp, #6104]

    ldr	x3,	[sp, #6104]

    mov	x0,	x2
    str	x3,	[sp, #2248]

    ldr	x8,	[sp, #2192]

    ldr	x19,	[sp, #6072]

    ldr	x20,	[sp, #6072]

    mov	x8,	x19
    str	x20,	[sp, #2192]

    ldr	w20,	[sp, #2504]

    ldr	w6,	[sp, #6164]

    ldr	w7,	[sp, #6164]

    mov	w20,	w6
    str	w7,	[sp, #2504]

    ldr	x12,	[sp, #2208]

    ldr	x22,	[sp, #6080]

    ldr	x23,	[sp, #6080]

    mov	x12,	x22
    str	x23,	[sp, #2208]

    ldr	x23,	[sp, #2216]

    ldr	x25,	[sp, #6088]

    ldr	x26,	[sp, #6088]

    mov	x23,	x25
    str	x26,	[sp, #2216]

    ldr	x0,	[sp, #2232]

    ldr	x28,	[sp, #6096]

    mov	x0,	x28
    ldr	x0,	[sp, #6096]

    str	x0,	[sp, #2232]

    ldr	w0,	[sp, #2516]

    ldr	w9,	[sp, #6168]

    ldr	w10,	[sp, #6168]

    mov	w0,	w9
    str	w10,	[sp, #2516]

    ldr	x14,	[sp, fp]

    movz	fp,	#2156
    ldr	x13,	[sp, #6056]

    mov	x14,	x13
    ldr	x14,	[sp, #6056]

    str	x14,	[sp, fp]

    movz	fp,	#2172
    ldr	x0,	[sp, fp]

    movz	fp,	#2172
    ldr	x16,	[sp, #6064]

    ldr	x17,	[sp, #6064]

    mov	x0,	x16
    str	x17,	[sp, fp]

    movz	fp,	#1996
    ldr	x20,	[sp, fp]

    movz	fp,	#1996
    ldr	x10,	[sp, #6048]

    ldr	x11,	[sp, #6048]

    mov	x20,	x10
    str	x11,	[sp, fp]

    movz	fp,	#4892
    ldr	x18,	[sp, #2056]

    ldr	x6,	[sp, #7928]

    ldr	x7,	[sp, #7928]

    mov	x18,	x6
    str	x7,	[sp, #2056]

    ldr	x27,	[sp, #2072]

    ldr	x9,	[sp, #7936]

    ldr	x10,	[sp, #7936]

    mov	x27,	x9
    str	x10,	[sp, #2072]

    ldr	x9,	[sp, #2040]

    ldr	x3,	[sp, #7920]

    ldr	x4,	[sp, #7920]

    mov	x9,	x3
    str	x4,	[sp, #2040]

    ldr	w21,	[sp, #2468]

    ldr	w3,	[sp, #6160]

    ldr	w4,	[sp, #6160]

    mov	w21,	w3
    str	w4,	[sp, #2468]

    ldr	x15,	[sp, fp]

    movz	fp,	#4892
    ldr	x15,	[sp, #7952]

    ldr	x16,	[sp, #7952]

    str	x16,	[sp, fp]

    movz	fp,	#4244
    ldr	x3,	[sp, #2080]

    ldr	x12,	[sp, #7944]

    ldr	x13,	[sp, #7944]

    mov	x3,	x12
    str	x13,	[sp, #2080]

    ldr	x0,	[sp, fp]

    movz	fp,	#4244
    ldr	x17,	[sp, #7880]

    ldr	x18,	[sp, #7880]

    mov	x0,	x17
    str	x18,	[sp, fp]

    movz	fp,	#4908
    ldr	x23,	[sp, fp]

    movz	fp,	#4908
    ldr	x18,	[sp, #7960]

    ldr	x19,	[sp, #7960]

    mov	x23,	x18
    str	x19,	[sp, fp]

    movz	fp,	#4252
    ldr	w12,	[sp, #2416]

    ldr	w26,	[sp, #6152]

    ldr	w27,	[sp, #6152]

    mov	w12,	w26
    str	w27,	[sp, #2416]

    ldr	w9,	[sp, #2428]

    ldr	w0,	[sp, #6156]

    ldr	w1,	[sp, #6156]

    mov	w9,	w0
    str	w1,	[sp, #2428]

    ldr	x5,	[sp, fp]

    movz	fp,	#4252
    ldr	x20,	[sp, #7888]

    ldr	x21,	[sp, #7888]

    mov	x5,	x20
    str	x21,	[sp, fp]

    movz	fp,	#9124
    ldr	w14,	[sp, #2392]

    ldr	w20,	[sp, #6144]

    ldr	w21,	[sp, #6144]

    mov	w14,	w20
    str	w21,	[sp, #2392]

    ldr	x15,	[sp, #4008]

    ldr	x11,	[sp, fp]

    movz	fp,	#9124
    mov	x15,	x11
    ldr	x12,	[sp, fp]

    movz	fp,	#4268
    str	x12,	[sp, #4008]

    ldr	w26,	[sp, #2396]

    ldr	w23,	[sp, #6148]

    ldr	w24,	[sp, #6148]

    mov	w26,	w23
    str	w24,	[sp, #2396]

    ldr	x14,	[sp, fp]

    movz	fp,	#4268
    ldr	x23,	[sp, #7896]

    ldr	x24,	[sp, #7896]

    mov	x14,	x23
    str	x24,	[sp, fp]

    movz	fp,	#9132
    ldr	x24,	[sp, #4024]

    ldr	x14,	[sp, fp]

    movz	fp,	#9132
    mov	x24,	x14
    ldr	x15,	[sp, fp]

    movz	fp,	#4276
    str	x15,	[sp, #4024]

    ldr	x19,	[sp, fp]

    movz	fp,	#4276
    ldr	x26,	[sp, #7904]

    ldr	x27,	[sp, #7904]

    mov	x19,	x26
    str	x27,	[sp, fp]

    ldr	w21,	[sp, #2372]

    ldr	w17,	[sp, #6140]

    ldr	w18,	[sp, #6140]

    mov	w21,	w17
    str	w18,	[sp, #2372]

    ldr	x28,	[sp, #2024]

    ldr	x0,	[sp, #7912]

    ldr	x1,	[sp, #7912]

    mov	x28,	x0
    str	x1,	[sp, #2024]

    ldr	x0,	[sp, #1912]

    ldr	x1,	[sp, #6024]

    ldr	x2,	[sp, #6024]

    mov	x0,	x1
    str	x2,	[sp, #1912]

    ldr	w14,	[sp, #2360]

    ldr	w14,	[sp, #6136]

    ldr	w15,	[sp, #6136]

    str	w15,	[sp, #2360]

    ldr	x12,	[sp, #1928]

    ldr	x4,	[sp, #6032]

    ldr	x5,	[sp, #6032]

    mov	x12,	x4
    str	x5,	[sp, #1928]

    ldr	x23,	[sp, #1936]

    ldr	x7,	[sp, #6040]

    ldr	x8,	[sp, #6040]

    mov	x23,	x7
    str	x8,	[sp, #1936]

    b	main_717

main_889:
    movz	w0,	#10
    ldr	x1,	[sp, #2344]

    bl	putfarray
    ldr	x1,	[sp, #2608]

    movz	w0,	#10
    bl	putarray
    ldr	w21,	[sp, #1872]

    scvtf	s12,	w21
    str	s12,	[sp, #1084]

    ldr	s15,	[sp, #1084]

    ldr	s9,	[sp, #1608]

    fsub	s12,	s15,	s9
    ldr	x18,	[sp, #2608]

    fcvtzs	w21,	s12
    str	w21,	[x18]

    ldr	w25,	[sp, #1976]

    ldr	s14,	[sp, #1596]

    scvtf	s12,	w25
    ldr	x18,	[sp, #1016]

    fsub	s10,	s12,	s14
    fcvtzs	w24,	s10
    str	w24,	[x18]

    ldr	w18,	[sp, #1908]

    scvtf	s10,	w18
    ldr	s9,	[sp, #1612]

    ldr	x19,	[sp, #1032]

    fsub	s10,	s10,	s9
    fcvtzs	w21,	s10
    str	w21,	[x19]

    ldr	w22,	[sp, #1800]

    scvtf	s15,	w22
    ldr	s12,	[sp, #1616]

    fsub	s11,	s15,	s12
    ldr	x25,	[sp, #1040]

    fcvtzs	w18,	s11
    str	w18,	[x25]

    movz	w25,	#0
    ldr	w18,	[sp, #1904]

    scvtf	s15,	w18
    ldr	s11,	[sp, #1600]

    ldr	x18,	[sp, #1064]

    fsub	s11,	s15,	s11
    fcvtzs	w19,	s11
    str	w19,	[x18]

    ldr	w18,	[sp, #4628]

    scvtf	s15,	w18
    ldr	s10,	[sp, #1604]

    ldr	x28,	[sp, #2560]

    fsub	s11,	s15,	s10
    fcvtzs	w18,	s11
    str	w18,	[x28]

    ldr	w23,	[sp, #4864]

    ldr	s11,	[sp, #1076]

    scvtf	s12,	w23
    ldr	x21,	[sp, #2568]

    fsub	s15,	s12,	s11
    fcvtzs	w22,	s15
    str	w22,	[x21]

    ldr	w20,	[sp, #1836]

    scvtf	s12,	w20
    ldr	s11,	[sp, #1136]

    ldr	x26,	[sp, #2584]

    fsub	s11,	s12,	s11
    fcvtzs	w19,	s11
    str	w19,	[x26]

    ldr	w27,	[sp, #4680]

    scvtf	s11,	w27
    ldr	s12,	[sp, #1176]

    ldr	x19,	[sp, #2592]

    fsub	s15,	s11,	s12
    fcvtzs	w20,	s15
    str	w20,	[x19]

    ldr	x18,	[sp, #2600]

    str	w25,	[x18]

    ldr	w24,	[sp, #3220]

    lsl	w26,	w24,	#2
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#864
    ldr	w27,	[x25]

    ldr	s15,	[sp, #1176]

    scvtf	s11,	w27
    ldr	s0,	[sp, #1288]

    fmul	s15,	s11,	s15
    fcvtzs	w28,	s15
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s8
    bl	putfloat
    movz	w0,	#10
    bl	putch
    fmov	s0,	s13
    bl	putfloat
    movz	w0,	#10
    bl	putch
    mov	w0,	w28
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#12480
    add	sp, sp, fp
    ret


main_22:
    lsl	w21,	w19,	#2
    add	w0,	w21,	w19,	lsl #3
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    bl	getarray
    add	w2,	w19,	#1
    mov	w19,	w2
    b	main_19

main_13:
    lsl	w0,	w26,	#2
    add	w18,	w0,	w26,	lsl #3
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#304
    bl	getfarray
    add	w3,	w26,	#1
    mov	w26,	w3
    b	main_10

