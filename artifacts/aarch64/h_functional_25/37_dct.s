.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl p
p:
p_1:
    sub	sp, sp, #64
    str	lr, [sp, 0]
    stp	q13, q14, [sp, #16]
    str	q15, [sp, 48]

    fmov	s18,	#4.000000
    fmov	s19,	#3.000000
    fmul	s13,	s18,	s0
    fmul	s24,	s19,	s0
    fmul	s14,	s13,	s0
    fmul	s15,	s14,	s0
    fsub	s0,	s24,	s15
    ldr	lr, [sp, 0]
    ldp	q13, q14, [sp, #16]
    ldr	q15, [sp, 48]

    add	sp, sp, #64
    ret


.globl my_sin_impl
my_sin_impl:
my_sin_impl_1:
    sub	sp, sp, #96
    stp	x22, fp, [sp, #0]
    str	lr, [sp, 16]
    stp	q10, q13, [sp, #32]
    stp	q14, q15, [sp, #64]

    movi	v23.4s,	#0
    fneg	s1,	s0
    fcmp	s0,	s23
    movz	w14,	#14269
    fcsel	s3,	s0,	s1,	gt
    cset	w16,	gt
    movk	w14,	#13702,	lsl #16
    fmov	s10,	w14
    fcmp	s3,	s10
    ble	my_sin_impl_26

my_sin_impl_6:
    fmov	s27,	#3.000000
    fneg	s13,	s0
    fmov	s15,	#3.000000
    movi	v14.4s,	#0
    fdiv	s24,	s0,	s27
    fdiv	s15,	s13,	s15
    fcmp	s24,	s14
    fcsel	s26,	s24,	s15,	gt
    cset	w22,	gt
    fcmp	s26,	s10
    ble	my_sin_impl_17

my_sin_impl_13:
    fmov	s10,	#3.000000
    fdiv	s0,	s24,	s10
    bl	my_sin_impl
    bl	p
    b	my_sin_impl_18

my_sin_impl_17:
    fmov	s0,	s24

my_sin_impl_18:
    fmov	s30,	#3.000000
    fmov	s29,	#4.000000
    fmul	s17,	s30,	s0
    fmul	s3,	s29,	s0
    fmul	s4,	s3,	s0
    fmul	s5,	s4,	s0
    fsub	s0,	s17,	s5

my_sin_impl_26:
    ldp	x22, fp, [sp, #0]
    ldr	lr, [sp, 16]
    ldp	q10, q13, [sp, #32]
    ldp	q14, q15, [sp, #64]

    add	sp, sp, #96
    ret


.globl main
main:
main_0:
    sub	sp, sp, #1856
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#256
    add	x0,	sp,	#272
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#528
    bl	memset
    bl	getint
    str	w0,	[sp, #996]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #992]

    ldr	w8,	[sp, #996]

    cmp	w22,	w8
    bge	main_24

main_7:
    movz	w6,	#0
    mov	w19,	w6

main_9:
    lsl	w0,	w19,	#5
    movz	w7,	#0
    mov	x21,	x0
    mov	w27,	w7
    add	x21,	sp,	x21
    add	x21,	x21,	#528

main_12:
    ldr	w9,	[sp, #992]

    cmp	w27,	w9
    bge	main_19

main_15:
    lsl	w24,	w27,	#2
    add	x22,	x21,	x24
    bl	getfloat
    add	w5,	w27,	#1
    str	s0,	[x22]

    mov	w27,	w5
    b	main_12

main_19:
    add	w6,	w19,	#1
    ldr	w11,	[sp, #996]

    cmp	w6,	w11
    bge	main_24

main_8:
    mov	w19,	w6
    b	main_9

main_24:
    add	x6,	sp,	#16
    add	x3,	sp,	#16
    movz	fp,	#940
    add	x18,	sp,	#528
    movz	w2,	#0
    movz	w0,	#4059
    movz	w23,	#4059
    movz	w7,	#4059
    movz	w16,	#4059
    str	x6,	[sp, #928]

    movk	w0,	#16457,	lsl #16
    movk	w23,	#16329,	lsl #16
    movk	w7,	#16585,	lsl #16
    movk	w16,	#49353,	lsl #16
    movz	w6,	#4059
    str	x3,	[sp, fp]

    movk	w6,	#49225,	lsl #16
    str	x18,	[sp, #1320]

    str	w6,	[sp, #980]

    str	w0,	[sp, #984]

    str	w23,	[sp, #784]

    str	w7,	[sp, #1000]

    str	w16,	[sp, #948]

    ldr	w0,	[sp, #996]

    cmp	w2,	w0
    bge	main_121

main_29:
    ldr	w11,	[sp, #996]

    movz	w2,	#0
    scvtf	s17,	w11
    ldr	w11,	[sp, #984]

    fmov	s12,	w11
    fdiv	s3,	s12,	s17
    str	s3,	[sp, #860]

    ldr	w23,	[sp, #992]

    ldr	w12,	[sp, #984]

    scvtf	s17,	w23
    str	w2,	[sp, #972]

    fmov	s12,	w12
    fdiv	s13,	s12,	s17

main_35:
    movz	w5,	#0
    ldr	w13,	[sp, #992]

    cmp	w5,	w13
    bge	main_116

main_38:
    ldr	w9,	[sp, #972]

    movz	fp,	#940
    movz	w10,	#0
    lsl	w18,	w9,	#5
    ldr	x2,	[sp, fp]

    add	x23,	x2,	x18
    str	x23,	[sp, #1200]

    ldr	w26,	[sp, #972]

    str	w10,	[sp, #936]

    scvtf	s14,	w26

main_42:
    ldr	w6,	[sp, #936]

    movi	v29.4s,	#0
    movz	w10,	#0
    ldr	x25,	[sp, #1200]

    lsl	w1,	w6,	#2
    add	x26,	x25,	x1
    str	x26,	[sp, #1208]

    ldr	x27,	[sp, #1208]

    str	s29,	[x27]

    ldr	w7,	[sp, #936]

    scvtf	s29,	w7
    str	s29,	[sp, #904]

    str	w10,	[sp, #960]


main_47:
    ldr	w13,	[sp, #960]

    movz	fp,	#1348
    fmov	s3,	#0.500000
    ldr	x20,	[sp, #1320]

    lsl	w4,	w13,	#5
    add	x0,	x20,	x4
    movz	w4,	#0
    str	x0,	[sp, fp]

    ldr	w14,	[sp, #960]

    ldr	s5,	[sp, #860]

    scvtf	s29,	w14
    ldr	w24,	[sp, #784]

    fadd	s7,	s29,	s3
    fmov	s23,	w24
    fmul	s5,	s5,	s7
    fmul	s6,	s5,	s14
    fadd	s30,	s6,	s23
    str	s30,	[sp, #852]

    ldr	w28,	[sp, #1000]

    ldr	s7,	[sp, #852]

    fmov	s21,	w28
    ldr	w0,	[sp, #1000]

    fdiv	s2,	s7,	s21
    ldr	s9,	[sp, #852]

    fmov	s26,	w0
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s9,	s5
    str	s6,	[sp, #828]

    str	w4,	[sp, #1316]


main_61:
    ldr	x22,	[sp, #1208]

    movz	fp,	#1348
    ldr	s11,	[x22]

    str	s11,	[sp, #908]

    ldr	w26,	[sp, #1316]

    ldr	x24,	[sp, fp]

    lsl	w18,	w26,	#2
    add	x26,	x24,	x18
    ldr	s8,	[x26]

    str	s8,	[sp, #916]

    ldr	w18,	[sp, #948]

    ldr	s10,	[sp, #852]

    fmov	s12,	w18
    fcmp	s10,	s12
    cset	w18,	lt
    ldr	s8,	[sp, #828]

    ldr	s15,	[sp, #852]

    ldr	w18,	[sp, #1000]

    fcsel	s9,	s8,	s15,	lt
    fmov	s11,	w18
    ldr	s8,	[sp, #852]

    fcmp	s8,	s11
    cset	w18,	gt
    ldr	s10,	[sp, #828]

    ldr	w19,	[sp, #1000]

    fcsel	s10,	s10,	s9,	gt
    fmov	s12,	w19
    ldr	w19,	[sp, #984]

    fsub	s8,	s10,	s12
    fmov	s9,	w19
    str	s9,	[sp, #820]

    ldr	s15,	[sp, #820]

    fcmp	s10,	s15
    ldr	w23,	[sp, #1000]

    fcsel	s12,	s8,	s10,	gt
    cset	w18,	gt
    fmov	s8,	w23
    ldr	w18,	[sp, #980]

    fadd	s8,	s12,	s8
    fmov	s9,	w18
    str	s9,	[sp, #824]

    ldr	s15,	[sp, #824]

    fcmp	s12,	s15
    fcsel	s0,	s8,	s12,	lt
    cset	w18,	lt
    bl	my_sin_impl
    fmov	s5,	#0.500000
    ldr	s11,	[sp, #916]

    fmul	s7,	s11,	s0
    str	s7,	[sp, #864]

    ldr	w4,	[sp, #1316]

    ldr	s30,	[sp, #904]

    scvtf	s11,	w4
    ldr	w27,	[sp, #784]

    fadd	s27,	s11,	s5
    ldr	w6,	[sp, #1000]

    fmov	s1,	w27
    fmul	s29,	s13,	s27
    fmov	s31,	w6
    fmul	s29,	s29,	s30
    fadd	s19,	s29,	s1
    fcmp	s19,	s31
    bgt	main_88

main_84:
    ldr	w16,	[sp, #948]

    fmov	s10,	w16
    fcmp	s19,	s10
    bge	main_95

main_88:
    ldr	w7,	[sp, #1000]

    ldr	w8,	[sp, #1000]

    fmov	s8,	w7
    fmov	s3,	w8
    fdiv	s22,	s19,	s8
    frintz	s27,	s22
    fcvtzs	w1,	s22
    fmul	s28,	s27,	s3
    fsub	s19,	s19,	s28

main_95:
    ldr	w19,	[sp, #1000]

    ldr	w18,	[sp, #984]

    fmov	s12,	w19
    fmov	s11,	w18
    fsub	s10,	s19,	s12
    fcmp	s19,	s11
    fcsel	s9,	s10,	s19,	gt
    cset	w18,	gt
    ldr	w18,	[sp, #1000]

    ldr	w19,	[sp, #980]

    fmov	s11,	w18
    fmov	s15,	w19
    fadd	s8,	s9,	s11
    str	s15,	[sp, #816]

    ldr	s10,	[sp, #816]

    fcmp	s9,	s10
    fcsel	s0,	s8,	s9,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	s8,	[sp, #864]

    ldr	s2,	[sp, #908]

    fmul	s16,	s8,	s0
    ldr	x0,	[sp, #1208]

    fadd	s12,	s2,	s16
    str	s12,	[x0]

    ldr	w5,	[sp, #1316]

    ldr	w27,	[sp, #992]

    add	w8,	w5,	#1
    cmp	w8,	w27
    blt	main_60

main_108:
    ldr	w15,	[sp, #960]

    ldr	w10,	[sp, #996]

    add	w14,	w15,	#1
    cmp	w14,	w10
    blt	main_46

main_111:
    ldr	w8,	[sp, #936]

    ldr	w25,	[sp, #992]

    add	w14,	w8,	#1
    cmp	w14,	w25
    bge	main_116

main_41:
    str	w14,	[sp, #936]

    b	main_42

main_46:
    str	w14,	[sp, #960]

    b	main_47

main_60:
    str	w8,	[sp, #1316]

    b	main_61

main_116:
    ldr	w11,	[sp, #972]

    ldr	w2,	[sp, #996]

    add	w6,	w11,	#1
    cmp	w6,	w2
    bge	main_121

main_34:
    str	w6,	[sp, #972]

    b	main_35

main_121:
    movz	w2,	#0
    ldr	w16,	[sp, #996]

    cmp	w2,	w16
    bge	main_142

main_123:
    movz	w28,	#0
    mov	w27,	w28

main_125:
    lsl	w22,	w27,	#5
    ldr	x23,	[sp, #928]

    add	x22,	x23,	x22
    mov	x18,	x22
    ldr	s0,	[x18]

    bl	putfloat
    movz	w8,	#1
    mov	w21,	w8

main_130:
    ldr	w26,	[sp, #992]

    cmp	w21,	w26
    bge	main_137

main_133:
    movz	w0,	#32
    bl	putch
    lsl	w18,	w21,	#2
    add	x26,	x22,	x18
    ldr	s0,	[x26]

    bl	putfloat
    add	w1,	w21,	#1
    mov	w21,	w1
    b	main_130

main_137:
    movz	w0,	#10
    bl	putch
    ldr	w17,	[sp, #996]

    add	w3,	w27,	#1
    cmp	w3,	w17
    bge	main_142

main_124:
    mov	w27,	w3
    b	main_125

main_142:
    movz	w0,	#10
    bl	putch
    movz	fp,	#1308
    add	x20,	sp,	#272
    movz	w14,	#0
    add	x8,	sp,	#272
    str	x8,	[sp, #1192]

    str	x20,	[sp, fp]

    ldr	w18,	[sp, #996]

    cmp	w14,	w18
    bge	main_278

main_146:
    movz	fp,	#940
    fmov	s27,	#0.250000
    movz	w5,	#0
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #952]

    ldr	x4,	[sp, #952]

    ldr	s24,	[x4]

    fmul	s25,	s27,	s24
    str	s25,	[sp, #900]

    ldr	w17,	[sp, #996]

    scvtf	s15,	w17
    str	s15,	[sp, #840]

    ldr	w0,	[sp, #992]

    scvtf	s19,	w0
    str	s19,	[sp, #844]

    ldr	w15,	[sp, #984]

    ldr	s13,	[sp, #840]

    fmov	s26,	w15
    fdiv	s19,	s26,	s13
    str	s19,	[sp, #892]

    ldr	w16,	[sp, #984]

    ldr	s17,	[sp, #844]

    fmov	s25,	w16
    fdiv	s22,	s25,	s17
    str	s22,	[sp, #896]

    str	w5,	[sp, #1328]


main_156:
    movz	w6,	#0
    ldr	w1,	[sp, #992]

    cmp	w6,	w1
    bge	main_273

main_159:
    ldr	w22,	[sp, #1328]

    movz	fp,	#1308
    fmov	s29,	#0.500000
    movz	w14,	#0
    lsl	w13,	w22,	#5
    ldr	x21,	[sp, fp]

    movz	fp,	#1300
    add	x17,	x21,	x13
    str	x17,	[sp, fp]

    ldr	w23,	[sp, #1328]

    ldr	s20,	[sp, #892]

    scvtf	s4,	w23
    fadd	s18,	s4,	s29
    fmul	s16,	s20,	s18
    str	s16,	[sp, #888]

    str	w14,	[sp, #976]


main_165:
    ldr	w12,	[sp, #976]

    movz	fp,	#1300
    movz	w16,	#1
    lsl	w3,	w12,	#2
    ldr	x18,	[sp, fp]

    mov	w17,	w16
    movz	fp,	#964
    add	x11,	x18,	x3
    str	x11,	[sp, fp]

    movz	fp,	#964
    ldr	s26,	[sp, #900]

    ldr	x12,	[sp, fp]

    str	s26,	[x12]


main_168:
    ldr	w18,	[sp, #996]

    cmp	w17,	w18
    bge	main_179

main_171:
    movz	fp,	#964
    lsl	w4,	w17,	#5
    fmov	s1,	#0.500000
    add	w16,	w17,	#1
    ldr	x22,	[sp, fp]

    mov	w17,	w16
    movz	fp,	#940
    ldr	s10,	[x22]

    ldr	x11,	[sp, fp]

    movz	fp,	#964
    add	x8,	x11,	x4
    ldr	s6,	[x8]

    ldr	x25,	[sp, fp]

    fmul	s16,	s1,	s6
    fadd	s28,	s10,	s16
    str	s28,	[x25]

    b	main_168

main_179:
    movz	w0,	#1

main_180:
    ldr	w3,	[sp, #992]

    cmp	w0,	w3
    bge	main_190

main_183:
    movz	fp,	#964
    lsl	w16,	w0,	#2
    fmov	s3,	#0.500000
    add	w0,	w0,	#1
    ldr	x27,	[sp, fp]

    movz	fp,	#964
    ldr	s20,	[x27]

    ldr	x28,	[sp, #952]

    add	x15,	x28,	x16
    ldr	s15,	[x15]

    ldr	x28,	[sp, fp]

    fmul	s24,	s3,	s15
    fadd	s5,	s20,	s24
    str	s5,	[x28]

    b	main_180

main_190:
    movz	w6,	#1
    ldr	w19,	[sp, #996]

    cmp	w6,	w19
    bge	main_263

main_192:
    ldr	w13,	[sp, #976]

    fmov	s6,	#0.500000
    movz	w27,	#1
    ldr	s23,	[sp, #896]

    scvtf	s28,	w13
    fadd	s10,	s28,	s6
    fmul	s13,	s23,	s10
    str	s13,	[sp, #884]

    str	w27,	[sp, #920]


main_197:
    movz	w8,	#1
    ldr	w0,	[sp, #992]

    cmp	w8,	w0
    bge	main_258

main_200:
    ldr	w18,	[sp, #920]

    movz	fp,	#940
    movz	w1,	#1
    lsl	w3,	w18,	#5
    ldr	x5,	[sp, fp]

    movz	fp,	#1292
    add	x14,	x5,	x3
    str	x14,	[sp, fp]

    ldr	w0,	[sp, #920]

    ldr	s17,	[sp, #888]

    scvtf	s15,	w0
    ldr	w28,	[sp, #784]

    fmul	s15,	s17,	s15
    fmov	s4,	w28
    fadd	s3,	s15,	s4
    str	s3,	[sp, #856]

    ldr	w8,	[sp, #1000]

    ldr	s2,	[sp, #856]

    fmov	s3,	w8
    ldr	w9,	[sp, #1000]

    fdiv	s5,	s2,	s3
    ldr	s4,	[sp, #856]

    fmov	s1,	w9
    frintz	s7,	s5
    fcvtzs	w6,	s5
    fmul	s8,	s7,	s1
    fsub	s23,	s4,	s8
    str	s23,	[sp, #848]

    str	w1,	[sp, #924]


main_211:
    movz	fp,	#964
    ldr	x19,	[sp, fp]

    movz	fp,	#1292
    ldr	s8,	[x19]

    str	s8,	[sp, #872]

    ldr	w25,	[sp, #924]

    ldr	x20,	[sp, fp]

    lsl	w18,	w25,	#2
    add	x18,	x20,	x18
    ldr	s10,	[x18]

    str	s10,	[sp, #788]

    ldr	w25,	[sp, #948]

    ldr	s14,	[sp, #856]

    fmov	s11,	w25
    fcmp	s14,	s11
    cset	w18,	lt
    ldr	s13,	[sp, #848]

    ldr	s12,	[sp, #856]

    ldr	w23,	[sp, #1000]

    fcsel	s9,	s13,	s12,	lt
    fmov	s13,	w23
    str	s13,	[sp, #836]

    ldr	s8,	[sp, #836]

    ldr	s10,	[sp, #856]

    fcmp	s10,	s8
    cset	w18,	gt
    ldr	s14,	[sp, #848]

    fcsel	s12,	s14,	s9,	gt
    str	s12,	[sp, #796]

    ldr	w25,	[sp, #1000]

    ldr	s13,	[sp, #796]

    fmov	s8,	w25
    ldr	w19,	[sp, #984]

    fsub	s15,	s13,	s8
    fmov	s8,	w19
    str	s8,	[sp, #792]

    ldr	s10,	[sp, #792]

    ldr	s14,	[sp, #796]

    fcmp	s14,	s10
    cset	w18,	gt
    ldr	s8,	[sp, #796]

    fcsel	s13,	s15,	s8,	gt
    str	s13,	[sp, #804]

    ldr	w27,	[sp, #1000]

    ldr	s8,	[sp, #804]

    fmov	s14,	w27
    ldr	w19,	[sp, #980]

    fadd	s12,	s8,	s14
    fmov	s9,	w19
    str	s9,	[sp, #800]

    ldr	s11,	[sp, #800]

    ldr	s8,	[sp, #804]

    fcmp	s8,	s11
    ldr	s9,	[sp, #804]

    cset	w18,	lt
    fcsel	s0,	s12,	s9,	lt
    bl	my_sin_impl
    ldr	s14,	[sp, #788]

    ldr	w4,	[sp, #924]

    fmul	s12,	s14,	s0
    scvtf	s24,	w4
    ldr	s14,	[sp, #884]

    ldr	w0,	[sp, #784]

    fmul	s23,	s14,	s24
    ldr	w13,	[sp, #1000]

    fmov	s16,	w0
    fmov	s15,	w13
    fadd	s24,	s23,	s16
    fcmp	s24,	s15
    bgt	main_236

main_232:
    ldr	w18,	[sp, #948]

    fmov	s28,	w18
    fcmp	s24,	s28
    bge	main_243

main_236:
    ldr	w14,	[sp, #1000]

    ldr	w15,	[sp, #1000]

    fmov	s31,	w14
    fmov	s29,	w15
    fdiv	s31,	s24,	s31
    frintz	s2,	s31
    fcvtzs	w9,	s31
    fmul	s3,	s2,	s29
    fsub	s24,	s24,	s3

main_243:
    ldr	w18,	[sp, #1000]

    ldr	w23,	[sp, #984]

    fmov	s15,	w18
    fmov	s14,	w23
    fsub	s8,	s24,	s15
    str	s14,	[sp, #832]

    ldr	s15,	[sp, #832]

    fcmp	s24,	s15
    cset	w18,	gt
    fcsel	s14,	s8,	s24,	gt
    str	s14,	[sp, #812]

    ldr	w19,	[sp, #1000]

    ldr	s13,	[sp, #812]

    fmov	s11,	w19
    ldr	w18,	[sp, #980]

    fadd	s13,	s13,	s11
    fmov	s15,	w18
    str	s15,	[sp, #808]

    ldr	s10,	[sp, #808]

    ldr	s15,	[sp, #812]

    fcmp	s15,	s10
    ldr	s15,	[sp, #812]

    cset	w18,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    movz	fp,	#964
    ldr	s11,	[sp, #872]

    fmul	s7,	s12,	s0
    ldr	x0,	[sp, fp]

    fadd	s7,	s11,	s7
    str	s7,	[x0]

    ldr	w5,	[sp, #924]

    ldr	w3,	[sp, #992]

    add	w5,	w5,	#1
    cmp	w5,	w3
    bge	main_258

main_210:
    str	w5,	[sp, #924]

    b	main_211

main_258:
    ldr	w21,	[sp, #920]

    ldr	w19,	[sp, #996]

    add	w2,	w21,	#1
    cmp	w2,	w19
    bge	main_263

main_196:
    str	w2,	[sp, #920]

    b	main_197

main_263:
    movz	fp,	#964
    fmov	s29,	#2.000000
    fmov	s28,	#2.000000
    ldr	x19,	[sp, fp]

    movz	fp,	#964
    ldr	s19,	[x19]

    ldr	s14,	[sp, #840]

    fmul	s31,	s19,	s29
    ldr	s19,	[sp, #844]

    fdiv	s21,	s31,	s14
    ldr	x21,	[sp, fp]

    fmul	s2,	s21,	s28
    fdiv	s3,	s2,	s19
    str	s3,	[x21]

    ldr	w14,	[sp, #976]

    ldr	w2,	[sp, #992]

    add	w18,	w14,	#1
    cmp	w18,	w2
    bge	main_273

main_164:
    str	w18,	[sp, #976]

    b	main_165

main_273:
    ldr	w24,	[sp, #1328]

    ldr	w12,	[sp, #996]

    add	w9,	w24,	#1
    cmp	w9,	w12
    bge	main_278

main_155:
    str	w9,	[sp, #1328]

    b	main_156

main_278:
    movz	w20,	#0
    ldr	w24,	[sp, #996]

    cmp	w20,	w24
    bge	main_299

main_280:
    movz	w25,	#0

main_282:
    lsl	w28,	w25,	#5
    ldr	x23,	[sp, #1192]

    add	x26,	x23,	x28
    ldr	s0,	[x26]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w3,	[sp, #992]

    cmp	w19,	w3
    bge	main_294

main_290:
    movz	w0,	#32
    bl	putch
    lsl	w18,	w19,	#2
    add	x28,	x26,	x18
    ldr	s0,	[x28]

    bl	putfloat
    add	w19,	w19,	#1
    b	main_287

main_294:
    movz	w0,	#10
    bl	putch
    ldr	w23,	[sp, #996]

    add	w25,	w25,	#1
    cmp	w25,	w23
    blt	main_282

main_299:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1856
    ret


