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
    sub	sp, sp, #1792
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#272
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#528
    bl	memset
    bl	getint
    str	w0,	[sp, #1000]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #996]

    ldr	w6,	[sp, #1000]

    cmp	w22,	w6
    bge	main_24

main_7:
    movz	w6,	#0
    mov	w19,	w6

main_9:
    lsl	w0,	w19,	#5
    movz	w7,	#0
    mov	x22,	x0
    mov	w27,	w7
    add	x22,	sp,	x22
    add	x22,	x22,	#528

main_12:
    ldr	w15,	[sp, #996]

    cmp	w27,	w15
    bge	main_19

main_15:
    lsl	w24,	w27,	#2
    add	x20,	x22,	x24
    bl	getfloat
    add	w5,	w27,	#1
    str	s0,	[x20]

    mov	w27,	w5
    b	main_12

main_19:
    add	w6,	w19,	#1
    ldr	w9,	[sp, #1000]

    cmp	w6,	w9
    bge	main_24

main_8:
    mov	w19,	w6
    b	main_9

main_24:
    add	x4,	sp,	#272
    movz	fp,	#948
    add	x1,	sp,	#272
    add	x12,	sp,	#528
    movz	w2,	#0
    movz	w10,	#4059
    movz	w27,	#4059
    movz	w26,	#4059
    movz	w20,	#4059
    str	x4,	[sp, fp]

    movk	w10,	#16457,	lsl #16
    movk	w27,	#16329,	lsl #16
    movk	w26,	#16585,	lsl #16
    movk	w20,	#49353,	lsl #16
    movz	w4,	#4059
    movz	fp,	#940
    movk	w4,	#49225,	lsl #16
    str	x1,	[sp, fp]

    str	x12,	[sp, #968]

    str	w4,	[sp, #988]

    str	w10,	[sp, #992]

    str	w27,	[sp, #788]

    str	w26,	[sp, #1036]

    str	w20,	[sp, #784]

    ldr	w26,	[sp, #1000]

    cmp	w2,	w26
    bge	main_121

main_29:
    ldr	w9,	[sp, #1000]

    movz	w25,	#0
    scvtf	s17,	w9
    ldr	w9,	[sp, #992]

    ldr	w20,	[sp, #996]

    fmov	s12,	w9
    ldr	w10,	[sp, #992]

    scvtf	s2,	w20
    fdiv	s8,	s12,	s17
    fmov	s10,	w10
    fdiv	s29,	s10,	s2
    str	s29,	[sp, #864]

    str	w25,	[sp, #980]


main_35:
    movz	w5,	#0
    ldr	w11,	[sp, #996]

    cmp	w5,	w11
    bge	main_116

main_38:
    ldr	w7,	[sp, #980]

    movz	fp,	#940
    lsl	w18,	w7,	#5
    ldr	x0,	[sp, fp]

    movz	w7,	#0
    ldr	w23,	[sp, #980]

    add	x22,	x0,	x18
    str	w7,	[sp, #984]

    scvtf	s13,	w23

main_42:
    ldr	w4,	[sp, #984]

    movi	v29.4s,	#0
    movz	w14,	#0
    lsl	w23,	w4,	#2
    add	x7,	x22,	x23
    str	x7,	[sp, #1280]

    ldr	x8,	[sp, #1280]

    str	s29,	[x8]

    ldr	w11,	[sp, #984]

    scvtf	s29,	w11
    str	s29,	[sp, #908]

    str	w14,	[sp, #1056]


main_47:
    ldr	w24,	[sp, #1056]

    movz	fp,	#1340
    fmov	s3,	#0.500000
    movz	w8,	#0
    ldr	x1,	[sp, #968]

    lsl	w4,	w24,	#5
    add	x26,	x1,	x4
    str	x26,	[sp, fp]

    ldr	w25,	[sp, #1056]

    ldr	w20,	[sp, #788]

    scvtf	s29,	w25
    fmov	s23,	w20
    fadd	s4,	s29,	s3
    fmul	s5,	s8,	s4
    fmul	s6,	s5,	s13
    fadd	s30,	s6,	s23
    str	s30,	[sp, #856]

    ldr	w1,	[sp, #1036]

    ldr	s7,	[sp, #856]

    fmov	s21,	w1
    ldr	w0,	[sp, #1036]

    fdiv	s2,	s7,	s21
    ldr	s10,	[sp, #856]

    fmov	s26,	w0
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s10,	s5
    str	s6,	[sp, #832]

    str	w8,	[sp, #1244]


main_61:
    ldr	x19,	[sp, #1280]

    movz	fp,	#1340
    ldr	s9,	[x19]

    str	s9,	[sp, #868]

    ldr	w28,	[sp, #1244]

    ldr	x21,	[sp, fp]

    lsl	w27,	w28,	#2
    add	x28,	x21,	x27
    ldr	s9,	[x28]

    str	s9,	[sp, #912]

    ldr	w28,	[sp, #784]

    ldr	s12,	[sp, #856]

    fmov	s11,	w28
    fcmp	s12,	s11
    cset	w28,	lt
    ldr	s9,	[sp, #832]

    ldr	s15,	[sp, #856]

    ldr	w21,	[sp, #1036]

    fcsel	s9,	s9,	s15,	lt
    ldr	s11,	[sp, #856]

    fmov	s10,	w21
    fcmp	s11,	s10
    cset	w28,	gt
    ldr	s11,	[sp, #832]

    ldr	w24,	[sp, #1036]

    fcsel	s15,	s11,	s9,	gt
    fmov	s11,	w24
    ldr	w24,	[sp, #992]

    fsub	s12,	s15,	s11
    fmov	s9,	w24
    str	s9,	[sp, #824]

    ldr	s14,	[sp, #824]

    fcmp	s15,	s14
    ldr	w27,	[sp, #1036]

    fcsel	s14,	s12,	s15,	gt
    cset	w28,	gt
    fmov	s12,	w27
    ldr	w28,	[sp, #988]

    fadd	s12,	s14,	s12
    fmov	s9,	w28
    str	s9,	[sp, #828]

    ldr	s15,	[sp, #828]

    fcmp	s14,	s15
    fcsel	s0,	s12,	s14,	lt
    cset	w27,	lt
    bl	my_sin_impl
    ldr	s12,	[sp, #912]

    fmov	s5,	#0.500000
    fmul	s7,	s12,	s0
    str	s7,	[sp, #872]

    ldr	w18,	[sp, #1244]

    ldr	s2,	[sp, #864]

    scvtf	s11,	w18
    ldr	s30,	[sp, #908]

    fadd	s27,	s11,	s5
    ldr	w27,	[sp, #788]

    fmul	s27,	s2,	s27
    ldr	w9,	[sp, #1036]

    fmul	s27,	s27,	s30
    fmov	s29,	w9
    fmov	s30,	w27
    fadd	s19,	s27,	s30
    fcmp	s19,	s29
    bgt	main_88

main_84:
    ldr	w16,	[sp, #784]

    fmov	s9,	w16
    fcmp	s19,	s9
    bge	main_95

main_88:
    ldr	w10,	[sp, #1036]

    ldr	w11,	[sp, #1036]

    fmov	s7,	w10
    fmov	s1,	w11
    fdiv	s20,	s19,	s7
    frintz	s25,	s20
    fcvtzs	w1,	s20
    fmul	s26,	s25,	s1
    fsub	s19,	s19,	s26

main_95:
    ldr	w21,	[sp, #1036]

    fmov	s11,	w21
    ldr	w21,	[sp, #992]

    fsub	s12,	s19,	s11
    fmov	s10,	w21
    fcmp	s19,	s10
    ldr	w24,	[sp, #1036]

    fcsel	s14,	s12,	s19,	gt
    cset	w28,	gt
    ldr	w18,	[sp, #988]

    fmov	s10,	w24
    fmov	s15,	w18
    fadd	s12,	s14,	s10
    str	s15,	[sp, #820]

    ldr	s9,	[sp, #820]

    fcmp	s14,	s9
    fcsel	s0,	s12,	s14,	lt
    cset	w27,	lt
    bl	my_sin_impl
    ldr	s9,	[sp, #872]

    ldr	s5,	[sp, #868]

    fmul	s14,	s9,	s0
    ldr	x10,	[sp, #1280]

    fadd	s12,	s5,	s14
    str	s12,	[x10]

    ldr	w19,	[sp, #1244]

    ldr	w28,	[sp, #996]

    add	w12,	w19,	#1
    cmp	w12,	w28
    blt	main_60

main_108:
    ldr	w26,	[sp, #1056]

    ldr	w12,	[sp, #1000]

    add	w10,	w26,	#1
    cmp	w10,	w12
    blt	main_46

main_111:
    ldr	w6,	[sp, #984]

    ldr	w21,	[sp, #996]

    add	w11,	w6,	#1
    cmp	w11,	w21
    bge	main_116

main_41:
    str	w11,	[sp, #984]

    b	main_42

main_46:
    str	w10,	[sp, #1056]

    b	main_47

main_60:
    str	w12,	[sp, #1244]

    b	main_61

main_116:
    ldr	w9,	[sp, #980]

    ldr	w1,	[sp, #1000]

    add	w0,	w9,	#1
    cmp	w0,	w1
    bge	main_121

main_34:
    str	w0,	[sp, #980]

    b	main_35

main_121:
    movz	w2,	#0
    ldr	w14,	[sp, #1000]

    cmp	w2,	w14
    bge	main_142

main_123:
    movz	w24,	#0
    mov	w28,	w24

main_125:
    lsl	w18,	w28,	#5
    movz	fp,	#948
    ldr	x20,	[sp, fp]

    add	x20,	x20,	x18
    mov	x24,	x20
    ldr	s0,	[x24]

    bl	putfloat
    movz	w8,	#1
    mov	w27,	w8

main_130:
    ldr	w22,	[sp, #996]

    cmp	w27,	w22
    bge	main_137

main_133:
    movz	w0,	#32
    bl	putch
    lsl	w24,	w27,	#2
    add	x23,	x20,	x24
    ldr	s0,	[x23]

    bl	putfloat
    add	w0,	w27,	#1
    mov	w27,	w0
    b	main_130

main_137:
    movz	w0,	#10
    bl	putch
    ldr	w15,	[sp, #1000]

    add	w3,	w28,	#1
    cmp	w3,	w15
    bge	main_142

main_124:
    mov	w28,	w3
    b	main_125

main_142:
    movz	w0,	#10
    bl	putch
    movz	w14,	#0
    movz	fp,	#1172
    add	x17,	sp,	#16
    add	x11,	sp,	#16
    str	x11,	[sp, fp]

    str	x17,	[sp, #1040]

    ldr	w16,	[sp, #1000]

    cmp	w14,	w16
    bge	main_278

main_146:
    movz	fp,	#940
    fmov	s27,	#0.250000
    ldr	x25,	[sp, fp]

    movz	fp,	#932
    str	x25,	[sp, fp]

    movz	fp,	#932
    ldr	x4,	[sp, fp]

    ldr	s24,	[x4]

    fmul	s16,	s27,	s24
    str	s16,	[sp, #892]

    ldr	w15,	[sp, #1000]

    scvtf	s15,	w15
    str	s15,	[sp, #844]

    ldr	w25,	[sp, #996]

    scvtf	s19,	w25
    movz	w25,	#0
    str	s19,	[sp, #848]

    ldr	w13,	[sp, #992]

    ldr	s13,	[sp, #844]

    fmov	s26,	w13
    fdiv	s19,	s26,	s13
    str	s19,	[sp, #896]

    ldr	w14,	[sp, #992]

    ldr	s17,	[sp, #848]

    fmov	s25,	w14
    fdiv	s22,	s25,	s17
    str	s22,	[sp, #900]

    str	w25,	[sp, #976]


main_156:
    movz	w6,	#0
    ldr	w25,	[sp, #996]

    cmp	w6,	w25
    bge	main_273

main_159:
    ldr	w16,	[sp, #976]

    fmov	s29,	#0.500000
    movz	w15,	#0
    ldr	x18,	[sp, #1040]

    lsl	w13,	w16,	#5
    add	x14,	x18,	x13
    str	x14,	[sp, #1048]

    ldr	w17,	[sp, #976]

    ldr	s20,	[sp, #896]

    scvtf	s4,	w17
    fadd	s18,	s4,	s29
    fmul	s25,	s20,	s18
    str	s25,	[sp, #904]

    str	w15,	[sp, #956]


main_165:
    ldr	w10,	[sp, #956]

    movz	w16,	#1
    ldr	x15,	[sp, #1048]

    lsl	w3,	w10,	#2
    mov	w17,	w16
    add	x9,	x15,	x3
    str	x9,	[sp, #960]

    ldr	s17,	[sp, #892]

    ldr	x10,	[sp, #960]

    str	s17,	[x10]


main_168:
    ldr	w14,	[sp, #1000]

    cmp	w17,	w14
    bge	main_179

main_171:
    ldr	x20,	[sp, #960]

    lsl	w4,	w17,	#5
    movz	fp,	#940
    fmov	s1,	#0.500000
    add	w16,	w17,	#1
    ldr	s10,	[x20]

    mov	w17,	w16
    ldr	x9,	[sp, fp]

    add	x8,	x9,	x4
    ldr	s6,	[x8]

    ldr	x21,	[sp, #960]

    fmul	s16,	s1,	s6
    fadd	s28,	s10,	s16
    str	s28,	[x21]

    b	main_168

main_179:
    movz	w0,	#1

main_180:
    ldr	w27,	[sp, #996]

    cmp	w0,	w27
    bge	main_190

main_183:
    ldr	x22,	[sp, #960]

    lsl	w18,	w0,	#2
    movz	fp,	#932
    fmov	s3,	#0.500000
    ldr	s20,	[x22]

    add	w0,	w0,	#1
    ldr	x16,	[sp, fp]

    add	x15,	x16,	x18
    ldr	s15,	[x15]

    ldr	x23,	[sp, #960]

    fmul	s24,	s3,	s15
    fadd	s5,	s20,	s24
    str	s5,	[x23]

    b	main_180

main_190:
    movz	w6,	#1
    ldr	w17,	[sp, #1000]

    cmp	w6,	w17
    bge	main_263

main_192:
    ldr	w11,	[sp, #956]

    fmov	s6,	#0.500000
    movz	w24,	#1
    ldr	s23,	[sp, #900]

    scvtf	s28,	w11
    fadd	s10,	s28,	s6
    fmul	s10,	s23,	s10
    str	s10,	[sp, #880]

    str	w24,	[sp, #924]


main_197:
    movz	w8,	#1
    ldr	w1,	[sp, #996]

    cmp	w8,	w1
    bge	main_258

main_200:
    ldr	w16,	[sp, #924]

    movz	fp,	#940
    lsl	w5,	w16,	#5
    ldr	x3,	[sp, fp]

    movz	fp,	#1164
    add	x8,	x3,	x5
    movz	w3,	#1
    str	x8,	[sp, fp]

    ldr	w23,	[sp, #924]

    ldr	s26,	[sp, #904]

    scvtf	s15,	w23
    ldr	w22,	[sp, #788]

    fmul	s15,	s26,	s15
    fmov	s4,	w22
    fadd	s3,	s15,	s4
    str	s3,	[sp, #860]

    ldr	w6,	[sp, #1036]

    ldr	s2,	[sp, #860]

    fmov	s3,	w6
    ldr	w7,	[sp, #1036]

    fdiv	s5,	s2,	s3
    ldr	s4,	[sp, #860]

    fmov	s1,	w7
    frintz	s7,	s5
    fcvtzs	w6,	s5
    fmul	s8,	s7,	s1
    fsub	s23,	s4,	s8
    str	s23,	[sp, #852]

    str	w3,	[sp, #928]


main_211:
    ldr	x24,	[sp, #960]

    movz	fp,	#1164
    ldr	s11,	[x24]

    str	s11,	[sp, #888]

    ldr	w20,	[sp, #928]

    ldr	x25,	[sp, fp]

    lsl	w22,	w20,	#2
    add	x27,	x25,	x22
    ldr	s15,	[x27]

    ldr	w20,	[sp, #784]

    ldr	s13,	[sp, #860]

    fmov	s10,	w20
    fcmp	s13,	s10
    cset	w22,	lt
    ldr	s13,	[sp, #852]

    ldr	s10,	[sp, #860]

    ldr	w18,	[sp, #1036]

    fcsel	s11,	s13,	s10,	lt
    fmov	s13,	w18
    str	s13,	[sp, #840]

    ldr	s13,	[sp, #840]

    ldr	s9,	[sp, #860]

    fcmp	s9,	s13
    cset	w27,	gt
    ldr	s13,	[sp, #852]

    fcsel	s10,	s13,	s11,	gt
    str	s10,	[sp, #796]

    ldr	w20,	[sp, #1036]

    ldr	s13,	[sp, #796]

    fmov	s11,	w20
    ldr	w18,	[sp, #992]

    fsub	s10,	s13,	s11
    fmov	s8,	w18
    str	s8,	[sp, #800]

    ldr	s8,	[sp, #800]

    ldr	s13,	[sp, #796]

    fcmp	s13,	s8
    ldr	s8,	[sp, #796]

    cset	w25,	gt
    fcsel	s11,	s10,	s8,	gt
    str	s11,	[sp, #808]

    ldr	w21,	[sp, #1036]

    ldr	s9,	[sp, #808]

    fmov	s8,	w21
    ldr	w24,	[sp, #988]

    fadd	s14,	s9,	s8
    fmov	s9,	w24
    str	s9,	[sp, #804]

    ldr	s9,	[sp, #804]

    ldr	s8,	[sp, #808]

    fcmp	s8,	s9
    ldr	s9,	[sp, #808]

    cset	w25,	lt
    fcsel	s0,	s14,	s9,	lt
    bl	my_sin_impl
    ldr	w2,	[sp, #928]

    fmul	s9,	s15,	s0
    ldr	s11,	[sp, #880]

    scvtf	s24,	w2
    ldr	w23,	[sp, #788]

    fmul	s23,	s11,	s24
    ldr	w11,	[sp, #1036]

    fmov	s16,	w23
    fmov	s15,	w11
    fadd	s24,	s23,	s16
    fcmp	s24,	s15
    bgt	main_236

main_232:
    ldr	w16,	[sp, #784]

    fmov	s28,	w16
    fcmp	s24,	s28
    bge	main_243

main_236:
    ldr	w12,	[sp, #1036]

    ldr	w13,	[sp, #1036]

    fmov	s31,	w12
    fmov	s29,	w13
    fdiv	s31,	s24,	s31
    frintz	s2,	s31
    fcvtzs	w9,	s31
    fmul	s3,	s2,	s29
    fsub	s24,	s24,	s3

main_243:
    ldr	w26,	[sp, #1036]

    ldr	w18,	[sp, #992]

    fmov	s15,	w26
    fmov	s14,	w18
    fsub	s8,	s24,	s15
    str	s14,	[sp, #836]

    ldr	s15,	[sp, #836]

    fcmp	s24,	s15
    fcsel	s14,	s8,	s24,	gt
    cset	w27,	gt
    str	s14,	[sp, #816]

    ldr	w18,	[sp, #1036]

    ldr	s13,	[sp, #816]

    fmov	s11,	w18
    ldr	w26,	[sp, #988]

    fadd	s13,	s13,	s11
    fmov	s15,	w26
    str	s15,	[sp, #812]

    ldr	s10,	[sp, #812]

    ldr	s15,	[sp, #816]

    fcmp	s15,	s10
    ldr	s15,	[sp, #816]

    cset	w25,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    ldr	s14,	[sp, #888]

    fmul	s7,	s9,	s0
    ldr	x23,	[sp, #960]

    fadd	s7,	s14,	s7
    str	s7,	[x23]

    ldr	w3,	[sp, #928]

    ldr	w1,	[sp, #996]

    add	w2,	w3,	#1
    cmp	w2,	w1
    bge	main_258

main_210:
    str	w2,	[sp, #928]

    b	main_211

main_258:
    ldr	w18,	[sp, #924]

    ldr	w17,	[sp, #1000]

    add	w0,	w18,	#1
    cmp	w0,	w17
    bge	main_263

main_196:
    str	w0,	[sp, #924]

    b	main_197

main_263:
    ldr	x17,	[sp, #960]

    fmov	s29,	#2.000000
    fmov	s28,	#2.000000
    ldr	s19,	[x17]

    ldr	s14,	[sp, #844]

    fmul	s31,	s19,	s29
    ldr	s19,	[sp, #848]

    fdiv	s21,	s31,	s14
    ldr	x18,	[sp, #960]

    fmul	s2,	s21,	s28
    fdiv	s3,	s2,	s19
    str	s3,	[x18]

    ldr	w12,	[sp, #956]

    ldr	w0,	[sp, #996]

    add	w20,	w12,	#1
    cmp	w20,	w0
    bge	main_273

main_164:
    str	w20,	[sp, #956]

    b	main_165

main_273:
    ldr	w18,	[sp, #976]

    ldr	w10,	[sp, #1000]

    add	w0,	w18,	#1
    cmp	w0,	w10
    bge	main_278

main_155:
    str	w0,	[sp, #976]

    b	main_156

main_278:
    movz	w19,	#0
    ldr	w22,	[sp, #1000]

    cmp	w19,	w22
    bge	main_299

main_280:
    movz	w25,	#0

main_282:
    lsl	w28,	w25,	#5
    movz	fp,	#1172
    ldr	x18,	[sp, fp]

    add	x26,	x18,	x28
    ldr	s0,	[x26]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w1,	[sp, #996]

    cmp	w19,	w1
    bge	main_294

main_290:
    movz	w0,	#32
    bl	putch
    lsl	w18,	w19,	#2
    add	x27,	x26,	x18
    ldr	s0,	[x27]

    bl	putfloat
    add	w19,	w19,	#1
    b	main_287

main_294:
    movz	w0,	#10
    bl	putch
    ldr	w21,	[sp, #1000]

    add	w25,	w25,	#1
    cmp	w25,	w21
    blt	main_282

main_299:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1792
    ret


