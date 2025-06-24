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
    fcsel	s3,	s0,	s1,	gt
    movz	w14,	#14269
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
    
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#272
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#528
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    str	w0,	[sp, #992]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #988]

    ldr	w8,	[sp, #992]

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
    add	x21,	x21,	#16

main_12:
    ldr	w9,	[sp, #988]

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
    ldr	w11,	[sp, #992]

    cmp	w6,	w11
    bge	main_24

main_8:
    mov	w19,	w6
    b	main_9

main_24:
    add	x6,	sp,	#528
    add	x3,	sp,	#528
    movz	fp,	#948
    add	x18,	sp,	#16
    movz	w2,	#0
    movz	w0,	#4059
    movz	w23,	#4059
    movz	w7,	#4059
    movz	w16,	#4059
    str	x6,	[sp, #920]

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

    str	w23,	[sp, #976]

    str	w7,	[sp, #996]

    str	w16,	[sp, #784]

    ldr	w0,	[sp, #992]

    cmp	w2,	w0
    bge	main_121

main_29:
    ldr	w11,	[sp, #992]

    movz	w2,	#0
    scvtf	s17,	w11
    ldr	w11,	[sp, #984]

    fmov	s12,	w11
    fdiv	s3,	s12,	s17
    str	s3,	[sp, #900]

    ldr	w23,	[sp, #988]

    ldr	w12,	[sp, #984]

    scvtf	s17,	w23
    str	w2,	[sp, #972]

    fmov	s12,	w12
    fdiv	s13,	s12,	s17

main_35:
    movz	w5,	#0
    ldr	w13,	[sp, #988]

    cmp	w5,	w13
    bge	main_116

main_38:
    ldr	w9,	[sp, #972]

    movz	fp,	#948
    movz	w10,	#0
    lsl	w18,	w9,	#5
    ldr	x2,	[sp, fp]

    movz	fp,	#1036
    add	x23,	x2,	x18
    str	x23,	[sp, fp]

    ldr	w26,	[sp, #972]

    str	w10,	[sp, #940]

    scvtf	s8,	w26

main_42:
    ldr	w6,	[sp, #940]

    movz	fp,	#1036
    movi	v29.4s,	#0
    movz	w10,	#0
    lsl	w1,	w6,	#2
    ldr	x25,	[sp, fp]

    movz	fp,	#1308
    add	x26,	x25,	x1
    str	x26,	[sp, fp]

    movz	fp,	#1308
    ldr	x27,	[sp, fp]

    str	s29,	[x27]

    ldr	w7,	[sp, #940]

    scvtf	s1,	w7
    str	s1,	[sp, #896]

    str	w10,	[sp, #968]


main_47:
    ldr	w13,	[sp, #968]

    fmov	s3,	#0.500000
    ldr	x20,	[sp, #1320]

    lsl	w4,	w13,	#5
    add	x0,	x20,	x4
    movz	w4,	#0
    str	x0,	[sp, #1352]

    ldr	w14,	[sp, #968]

    ldr	s5,	[sp, #900]

    scvtf	s29,	w14
    ldr	w24,	[sp, #976]

    fadd	s7,	s29,	s3
    fmov	s23,	w24
    fmul	s5,	s5,	s7
    fmul	s6,	s5,	s8
    fadd	s30,	s6,	s23
    str	s30,	[sp, #848]

    ldr	w28,	[sp, #996]

    ldr	s7,	[sp, #848]

    fmov	s21,	w28
    ldr	w0,	[sp, #996]

    fdiv	s2,	s7,	s21
    ldr	s10,	[sp, #848]

    fmov	s26,	w0
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s10,	s5
    str	s6,	[sp, #824]

    str	w4,	[sp, #1316]


main_61:
    movz	fp,	#1308
    ldr	x22,	[sp, fp]

    ldr	s12,	[x22]

    str	s12,	[sp, #904]

    ldr	w26,	[sp, #1316]

    ldr	x24,	[sp, #1352]

    lsl	w18,	w26,	#2
    add	x26,	x24,	x18
    ldr	s12,	[x26]

    str	s12,	[sp, #916]

    ldr	w18,	[sp, #784]

    ldr	s11,	[sp, #848]

    fmov	s14,	w18
    fcmp	s11,	s14
    cset	w18,	lt
    ldr	s9,	[sp, #824]

    ldr	s15,	[sp, #848]

    ldr	w18,	[sp, #996]

    fcsel	s10,	s9,	s15,	lt
    fmov	s12,	w18
    ldr	s9,	[sp, #848]

    fcmp	s9,	s12
    cset	w18,	gt
    ldr	s11,	[sp, #824]

    ldr	w19,	[sp, #996]

    fcsel	s11,	s11,	s10,	gt
    fmov	s14,	w19
    ldr	w19,	[sp, #984]

    fsub	s9,	s11,	s14
    fmov	s10,	w19
    str	s10,	[sp, #816]

    ldr	s15,	[sp, #816]

    fcmp	s11,	s15
    cset	w18,	gt
    fcsel	s14,	s9,	s11,	gt
    ldr	w23,	[sp, #996]

    ldr	w18,	[sp, #980]

    fmov	s9,	w23
    fmov	s10,	w18
    fadd	s9,	s14,	s9
    str	s10,	[sp, #820]

    ldr	s15,	[sp, #820]

    fcmp	s14,	s15
    fcsel	s0,	s9,	s14,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	s16,	[sp, #916]

    fmov	s5,	#0.500000
    fmul	s11,	s16,	s0
    str	s11,	[sp, #908]

    ldr	w4,	[sp, #1316]

    ldr	s2,	[sp, #896]

    scvtf	s12,	w4
    ldr	w27,	[sp, #976]

    fadd	s27,	s12,	s5
    ldr	w6,	[sp, #996]

    fmov	s1,	w27
    fmul	s30,	s13,	s27
    fmov	s31,	w6
    fmul	s29,	s30,	s2
    fadd	s19,	s29,	s1
    fcmp	s19,	s31
    bgt	main_88

main_84:
    ldr	w16,	[sp, #784]

    fmov	s11,	w16
    fcmp	s19,	s11
    bge	main_95

main_88:
    ldr	w7,	[sp, #996]

    ldr	w8,	[sp, #996]

    fmov	s9,	w7
    fmov	s3,	w8
    fdiv	s22,	s19,	s9
    frintz	s27,	s22
    fcvtzs	w1,	s22
    fmul	s28,	s27,	s3
    fsub	s19,	s19,	s28

main_95:
    ldr	w19,	[sp, #996]

    ldr	w18,	[sp, #984]

    fmov	s14,	w19
    fmov	s12,	w18
    fsub	s11,	s19,	s14
    fcmp	s19,	s12
    fcsel	s10,	s11,	s19,	gt
    cset	w18,	gt
    ldr	w18,	[sp, #996]

    ldr	w19,	[sp, #980]

    fmov	s12,	w18
    fmov	s15,	w19
    fadd	s9,	s10,	s12
    str	s15,	[sp, #812]

    ldr	s11,	[sp, #812]

    fcmp	s10,	s11
    fcsel	s0,	s9,	s10,	lt
    cset	w18,	lt
    bl	my_sin_impl
    movz	fp,	#1308
    ldr	s12,	[sp, #908]

    ldr	s9,	[sp, #904]

    fmul	s16,	s12,	s0
    ldr	x0,	[sp, fp]

    fadd	s14,	s9,	s16
    str	s14,	[x0]

    ldr	w5,	[sp, #1316]

    ldr	w27,	[sp, #988]

    add	w8,	w5,	#1
    cmp	w8,	w27
    blt	main_60

main_108:
    ldr	w15,	[sp, #968]

    ldr	w10,	[sp, #992]

    add	w14,	w15,	#1
    cmp	w14,	w10
    blt	main_46

main_111:
    ldr	w8,	[sp, #940]

    ldr	w25,	[sp, #988]

    add	w14,	w8,	#1
    cmp	w14,	w25
    bge	main_116

main_41:
    str	w14,	[sp, #940]

    b	main_42

main_46:
    str	w14,	[sp, #968]

    b	main_47

main_60:
    str	w8,	[sp, #1316]

    b	main_61

main_116:
    ldr	w11,	[sp, #972]

    ldr	w2,	[sp, #992]

    add	w6,	w11,	#1
    cmp	w6,	w2
    bge	main_121

main_34:
    str	w6,	[sp, #972]

    b	main_35

main_121:
    movz	w2,	#0
    ldr	w16,	[sp, #992]

    cmp	w2,	w16
    bge	main_142

main_123:
    movz	w28,	#0
    mov	w27,	w28

main_125:
    lsl	w22,	w27,	#5
    ldr	x23,	[sp, #920]

    add	x22,	x23,	x22
    mov	x18,	x22
    ldr	s0,	[x18]

    bl	putfloat
    movz	w8,	#1
    mov	w21,	w8

main_130:
    ldr	w26,	[sp, #988]

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
    ldr	w17,	[sp, #992]

    add	w3,	w27,	#1
    cmp	w3,	w17
    bge	main_142

main_124:
    mov	w27,	w3
    b	main_125

main_142:
    movz	w0,	#10
    bl	putch
    movz	w14,	#0
    add	x20,	sp,	#272
    movz	fp,	#1044
    add	x8,	sp,	#272
    str	x8,	[sp, fp]

    movz	fp,	#1028
    str	x20,	[sp, fp]

    ldr	w18,	[sp, #992]

    cmp	w14,	w18
    bge	main_278

main_146:
    movz	fp,	#948
    fmov	s27,	#0.250000
    movz	w5,	#0
    ldr	x8,	[sp, fp]

    str	x8,	[sp, #960]

    ldr	x4,	[sp, #960]

    ldr	s24,	[x4]

    fmul	s19,	s27,	s24
    str	s19,	[sp, #864]

    ldr	w17,	[sp, #992]

    scvtf	s15,	w17
    str	s15,	[sp, #836]

    ldr	w0,	[sp, #988]

    scvtf	s19,	w0
    str	s19,	[sp, #840]

    ldr	w15,	[sp, #984]

    ldr	s13,	[sp, #836]

    fmov	s26,	w15
    fdiv	s22,	s26,	s13
    str	s22,	[sp, #868]

    ldr	w16,	[sp, #984]

    ldr	s17,	[sp, #840]

    fmov	s25,	w16
    fdiv	s28,	s25,	s17
    str	s28,	[sp, #892]

    str	w5,	[sp, #1328]


main_156:
    movz	w6,	#0
    ldr	w1,	[sp, #988]

    cmp	w6,	w1
    bge	main_273

main_159:
    ldr	w22,	[sp, #1328]

    movz	fp,	#1028
    fmov	s29,	#0.500000
    movz	w14,	#0
    lsl	w13,	w22,	#5
    ldr	x21,	[sp, fp]

    movz	fp,	#1020
    add	x17,	x21,	x13
    str	x17,	[sp, fp]

    ldr	w23,	[sp, #1328]

    ldr	s23,	[sp, #868]

    scvtf	s4,	w23
    fadd	s18,	s4,	s29
    fmul	s25,	s23,	s18
    str	s25,	[sp, #872]

    str	w14,	[sp, #956]


main_165:
    ldr	w12,	[sp, #956]

    movz	fp,	#1020
    movz	w16,	#1
    lsl	w3,	w12,	#2
    ldr	x18,	[sp, fp]

    mov	w17,	w16
    add	x11,	x18,	x3
    str	x11,	[sp, #928]

    ldr	s20,	[sp, #864]

    ldr	x12,	[sp, #928]

    str	s20,	[x12]


main_168:
    ldr	w18,	[sp, #992]

    cmp	w17,	w18
    bge	main_179

main_171:
    ldr	x22,	[sp, #928]

    lsl	w4,	w17,	#5
    movz	fp,	#948
    fmov	s1,	#0.500000
    add	w16,	w17,	#1
    ldr	s10,	[x22]

    mov	w17,	w16
    ldr	x11,	[sp, fp]

    add	x8,	x11,	x4
    ldr	s6,	[x8]

    ldr	x25,	[sp, #928]

    fmul	s16,	s1,	s6
    fadd	s28,	s10,	s16
    str	s28,	[x25]

    b	main_168

main_179:
    movz	w0,	#1

main_180:
    ldr	w3,	[sp, #988]

    cmp	w0,	w3
    bge	main_190

main_183:
    ldr	x27,	[sp, #928]

    lsl	w16,	w0,	#2
    fmov	s3,	#0.500000
    ldr	s20,	[x27]

    add	w0,	w0,	#1
    ldr	x28,	[sp, #960]

    add	x15,	x28,	x16
    ldr	s15,	[x15]

    ldr	x28,	[sp, #928]

    fmul	s24,	s3,	s15
    fadd	s5,	s20,	s24
    str	s5,	[x28]

    b	main_180

main_190:
    movz	w6,	#1
    ldr	w19,	[sp, #992]

    cmp	w6,	w19
    bge	main_263

main_192:
    ldr	w13,	[sp, #956]

    fmov	s6,	#0.500000
    movz	w27,	#1
    ldr	s29,	[sp, #892]

    scvtf	s28,	w13
    fadd	s10,	s28,	s6
    fmul	s16,	s29,	s10
    str	s16,	[sp, #860]

    str	w27,	[sp, #944]


main_197:
    movz	w8,	#1
    ldr	w0,	[sp, #988]

    cmp	w8,	w0
    bge	main_258

main_200:
    ldr	w18,	[sp, #944]

    movz	fp,	#948
    movz	w1,	#1
    lsl	w3,	w18,	#5
    ldr	x5,	[sp, fp]

    movz	fp,	#1012
    add	x14,	x5,	x3
    str	x14,	[sp, fp]

    ldr	w0,	[sp, #944]

    ldr	s26,	[sp, #872]

    scvtf	s15,	w0
    ldr	w28,	[sp, #976]

    fmul	s15,	s26,	s15
    fmov	s4,	w28
    fadd	s3,	s15,	s4
    str	s3,	[sp, #852]

    ldr	w8,	[sp, #996]

    ldr	s2,	[sp, #852]

    fmov	s3,	w8
    ldr	w9,	[sp, #996]

    fdiv	s5,	s2,	s3
    ldr	s4,	[sp, #852]

    fmov	s1,	w9
    frintz	s7,	s5
    fcvtzs	w6,	s5
    fmul	s8,	s7,	s1
    fsub	s23,	s4,	s8
    str	s23,	[sp, #844]

    str	w1,	[sp, #936]


main_211:
    ldr	x19,	[sp, #928]

    movz	fp,	#1012
    ldr	s11,	[x19]

    str	s11,	[sp, #856]

    ldr	w25,	[sp, #936]

    ldr	x20,	[sp, fp]

    lsl	w18,	w25,	#2
    add	x18,	x20,	x18
    ldr	s14,	[x18]

    str	s14,	[sp, #876]

    ldr	w25,	[sp, #784]

    ldr	s11,	[sp, #852]

    fmov	s8,	w25
    fcmp	s11,	s8
    cset	w18,	lt
    ldr	s12,	[sp, #844]

    ldr	s11,	[sp, #852]

    ldr	w23,	[sp, #996]

    fcsel	s15,	s12,	s11,	lt
    fmov	s13,	w23
    str	s13,	[sp, #832]

    ldr	s10,	[sp, #832]

    ldr	s13,	[sp, #852]

    fcmp	s13,	s10
    cset	w18,	gt
    ldr	s12,	[sp, #844]

    fcsel	s12,	s12,	s15,	gt
    str	s12,	[sp, #788]

    ldr	w25,	[sp, #996]

    ldr	s12,	[sp, #788]

    fmov	s15,	w25
    ldr	w19,	[sp, #984]

    fsub	s13,	s12,	s15
    fmov	s15,	w19
    str	s15,	[sp, #792]

    ldr	s10,	[sp, #792]

    ldr	s14,	[sp, #788]

    fcmp	s14,	s10
    ldr	s14,	[sp, #788]

    cset	w18,	gt
    fcsel	s12,	s13,	s14,	gt
    str	s12,	[sp, #800]

    ldr	w27,	[sp, #996]

    ldr	s12,	[sp, #800]

    fmov	s14,	w27
    ldr	w19,	[sp, #980]

    fadd	s12,	s12,	s14
    fmov	s8,	w19
    str	s8,	[sp, #796]

    ldr	s10,	[sp, #796]

    ldr	s14,	[sp, #800]

    fcmp	s14,	s10
    ldr	s15,	[sp, #800]

    cset	w18,	lt
    fcsel	s0,	s12,	s15,	lt
    bl	my_sin_impl
    ldr	s9,	[sp, #876]

    ldr	w4,	[sp, #936]

    fmul	s12,	s9,	s0
    ldr	s17,	[sp, #860]

    scvtf	s24,	w4
    ldr	w0,	[sp, #976]

    fmul	s23,	s17,	s24
    ldr	w13,	[sp, #996]

    fmov	s16,	w0
    fmov	s15,	w13
    fadd	s24,	s23,	s16
    fcmp	s24,	s15
    bgt	main_236

main_232:
    ldr	w18,	[sp, #784]

    fmov	s28,	w18
    fcmp	s24,	s28
    bge	main_243

main_236:
    ldr	w14,	[sp, #996]

    ldr	w15,	[sp, #996]

    fmov	s31,	w14
    fmov	s29,	w15
    fdiv	s31,	s24,	s31
    frintz	s2,	s31
    fcvtzs	w9,	s31
    fmul	s3,	s2,	s29
    fsub	s24,	s24,	s3

main_243:
    ldr	w18,	[sp, #996]

    ldr	w23,	[sp, #984]

    fmov	s15,	w18
    fmov	s14,	w23
    fsub	s8,	s24,	s15
    str	s14,	[sp, #828]

    ldr	s15,	[sp, #828]

    fcmp	s24,	s15
    cset	w18,	gt
    fcsel	s14,	s8,	s24,	gt
    str	s14,	[sp, #808]

    ldr	w19,	[sp, #996]

    ldr	s10,	[sp, #808]

    fmov	s11,	w19
    ldr	w18,	[sp, #980]

    fadd	s13,	s10,	s11
    fmov	s15,	w18
    str	s15,	[sp, #804]

    ldr	s10,	[sp, #804]

    ldr	s15,	[sp, #808]

    fcmp	s15,	s10
    ldr	s15,	[sp, #808]

    cset	w18,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    ldr	s14,	[sp, #856]

    fmul	s7,	s12,	s0
    ldr	x0,	[sp, #928]

    fadd	s7,	s14,	s7
    str	s7,	[x0]

    ldr	w5,	[sp, #936]

    ldr	w3,	[sp, #988]

    add	w5,	w5,	#1
    cmp	w5,	w3
    bge	main_258

main_210:
    str	w5,	[sp, #936]

    b	main_211

main_258:
    ldr	w21,	[sp, #944]

    ldr	w19,	[sp, #992]

    add	w2,	w21,	#1
    cmp	w2,	w19
    bge	main_263

main_196:
    str	w2,	[sp, #944]

    b	main_197

main_263:
    ldr	x19,	[sp, #928]

    fmov	s29,	#2.000000
    fmov	s28,	#2.000000
    ldr	s19,	[x19]

    ldr	s14,	[sp, #836]

    fmul	s31,	s19,	s29
    ldr	s19,	[sp, #840]

    fdiv	s21,	s31,	s14
    ldr	x21,	[sp, #928]

    fmul	s2,	s21,	s28
    fdiv	s3,	s2,	s19
    str	s3,	[x21]

    ldr	w14,	[sp, #956]

    ldr	w2,	[sp, #988]

    add	w18,	w14,	#1
    cmp	w18,	w2
    bge	main_273

main_164:
    str	w18,	[sp, #956]

    b	main_165

main_273:
    ldr	w24,	[sp, #1328]

    ldr	w12,	[sp, #992]

    add	w9,	w24,	#1
    cmp	w9,	w12
    bge	main_278

main_155:
    str	w9,	[sp, #1328]

    b	main_156

main_278:
    movz	w20,	#0
    ldr	w24,	[sp, #992]

    cmp	w20,	w24
    bge	main_299

main_280:
    movz	w25,	#0

main_282:
    lsl	w28,	w25,	#5
    movz	fp,	#1044
    ldr	x23,	[sp, fp]

    add	x26,	x23,	x28
    ldr	s0,	[x26]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w3,	[sp, #988]

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
    ldr	w23,	[sp, #992]

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


