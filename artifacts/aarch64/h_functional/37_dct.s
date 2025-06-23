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
    sub	sp, sp, #1760
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#272
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#528
    bl	memset
    movz	w1,	#0
    movz	w2,	#256
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    str	w0,	[sp, #996]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #992]

    ldr	w5,	[sp, #996]

    cmp	w22,	w5
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
    add	x22,	x22,	#16

main_12:
    ldr	w14,	[sp, #992]

    cmp	w27,	w14
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
    ldr	w8,	[sp, #996]

    cmp	w6,	w8
    bge	main_24

main_8:
    mov	w19,	w6
    b	main_9

main_24:
    add	x3,	sp,	#528
    add	x0,	sp,	#528
    movz	fp,	#972
    add	x13,	sp,	#16
    movz	w2,	#0
    movz	w1,	#4059
    movz	w9,	#4059
    movz	w26,	#4059
    movz	w25,	#4059
    movz	w19,	#4059
    str	x3,	[sp, #944]

    movk	w1,	#49225,	lsl #16
    movk	w9,	#16457,	lsl #16
    movk	w26,	#16329,	lsl #16
    movk	w25,	#16585,	lsl #16
    movk	w19,	#49353,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#1004
    str	x13,	[sp, fp]

    str	w1,	[sp, #984]

    str	w9,	[sp, #988]

    str	w26,	[sp, #980]

    str	w25,	[sp, #1000]

    str	w19,	[sp, #784]

    ldr	w25,	[sp, #996]

    cmp	w2,	w25
    bge	main_121

main_29:
    ldr	w8,	[sp, #996]

    movz	w24,	#0
    scvtf	s17,	w8
    ldr	w8,	[sp, #988]

    ldr	w19,	[sp, #992]

    fmov	s12,	w8
    ldr	w9,	[sp, #988]

    scvtf	s2,	w19
    fdiv	s8,	s12,	s17
    fmov	s10,	w9
    fdiv	s26,	s10,	s2
    str	s26,	[sp, #896]

    str	w24,	[sp, #936]


main_35:
    movz	w5,	#0
    ldr	w10,	[sp, #992]

    cmp	w5,	w10
    bge	main_116

main_38:
    ldr	w6,	[sp, #936]

    movz	fp,	#972
    lsl	w18,	w6,	#5
    ldr	x0,	[sp, fp]

    movz	w6,	#0
    add	x15,	x0,	x18
    str	x15,	[sp, #1248]

    ldr	w22,	[sp, #936]

    scvtf	s29,	w22
    str	s29,	[sp, #900]

    str	w6,	[sp, #916]


main_42:
    ldr	w3,	[sp, #916]

    movi	v27.4s,	#0
    movz	w7,	#0
    ldr	x16,	[sp, #1248]

    lsl	w0,	w3,	#2
    add	x21,	x16,	x0
    str	x21,	[sp, #952]

    ldr	x22,	[sp, #952]

    str	s27,	[x22]

    ldr	w10,	[sp, #916]

    str	w7,	[sp, #1016]

    scvtf	s13,	w10

main_47:
    ldr	w8,	[sp, #1016]

    movz	fp,	#1004
    fmov	s3,	#0.500000
    lsl	w3,	w8,	#5
    ldr	x15,	[sp, fp]

    add	x27,	x15,	x3
    str	x27,	[sp, #1328]

    ldr	w9,	[sp, #1016]

    ldr	s2,	[sp, #900]

    scvtf	s29,	w9
    ldr	w18,	[sp, #980]

    movz	w9,	#0
    fadd	s4,	s29,	s3
    fmov	s23,	w18
    fmul	s9,	s8,	s4
    fmul	s6,	s9,	s2
    fadd	s30,	s6,	s23
    str	s30,	[sp, #856]

    ldr	w28,	[sp, #1000]

    ldr	s7,	[sp, #856]

    fmov	s21,	w28
    ldr	w0,	[sp, #1000]

    fdiv	s2,	s7,	s21
    ldr	s10,	[sp, #856]

    fmov	s26,	w0
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s10,	s5
    str	s6,	[sp, #832]

    str	w9,	[sp, #968]


main_61:
    ldr	x28,	[sp, #952]

    ldr	s9,	[x28]

    str	s9,	[sp, #904]

    ldr	w25,	[sp, #968]

    ldr	x22,	[sp, #1328]

    lsl	w18,	w25,	#2
    add	x26,	x22,	x18
    ldr	s9,	[x26]

    str	s9,	[sp, #792]

    ldr	w25,	[sp, #784]

    ldr	s11,	[sp, #856]

    fmov	s14,	w25
    fcmp	s11,	s14
    cset	w26,	lt
    ldr	s9,	[sp, #832]

    ldr	s15,	[sp, #856]

    ldr	w20,	[sp, #1000]

    fcsel	s10,	s9,	s15,	lt
    fmov	s12,	w20
    ldr	s9,	[sp, #856]

    fcmp	s9,	s12
    cset	w26,	gt
    ldr	s11,	[sp, #832]

    ldr	w18,	[sp, #1000]

    fcsel	s11,	s11,	s10,	gt
    fmov	s14,	w18
    ldr	w18,	[sp, #988]

    fsub	s9,	s11,	s14
    fmov	s10,	w18
    str	s10,	[sp, #824]

    ldr	s15,	[sp, #824]

    fcmp	s11,	s15
    ldr	w24,	[sp, #1000]

    fcsel	s14,	s9,	s11,	gt
    cset	w26,	gt
    ldr	w25,	[sp, #984]

    fmov	s9,	w24
    fmov	s10,	w25
    fadd	s9,	s14,	s9
    str	s10,	[sp, #828]

    ldr	s15,	[sp, #828]

    fcmp	s14,	s15
    fcsel	s0,	s9,	s14,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	s12,	[sp, #792]

    fmov	s5,	#0.500000
    fmul	s7,	s12,	s0
    str	s7,	[sp, #908]

    ldr	w3,	[sp, #968]

    ldr	s30,	[sp, #896]

    scvtf	s12,	w3
    ldr	w26,	[sp, #980]

    fadd	s28,	s12,	s5
    ldr	w8,	[sp, #1000]

    fmov	s1,	w26
    fmul	s28,	s30,	s28
    fmov	s31,	w8
    fmul	s29,	s28,	s13
    fadd	s19,	s29,	s1
    fcmp	s19,	s31
    bgt	main_88

main_84:
    ldr	w15,	[sp, #784]

    fmov	s11,	w15
    fcmp	s19,	s11
    bge	main_95

main_88:
    ldr	w9,	[sp, #1000]

    ldr	w10,	[sp, #1000]

    fmov	s9,	w9
    fmov	s3,	w10
    fdiv	s22,	s19,	s9
    frintz	s27,	s22
    fcvtzs	w1,	s22
    fmul	s28,	s27,	s3
    fsub	s19,	s19,	s28

main_95:
    ldr	w20,	[sp, #1000]

    fmov	s14,	w20
    ldr	w20,	[sp, #988]

    fsub	s11,	s19,	s14
    fmov	s12,	w20
    fcmp	s19,	s12
    fcsel	s10,	s11,	s19,	gt
    ldr	w18,	[sp, #1000]

    cset	w26,	gt
    fmov	s12,	w18
    ldr	w26,	[sp, #984]

    fadd	s9,	s10,	s12
    fmov	s15,	w26
    str	s15,	[sp, #820]

    ldr	s11,	[sp, #820]

    fcmp	s10,	s11
    fcsel	s0,	s9,	s10,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	s9,	[sp, #908]

    ldr	s5,	[sp, #904]

    fmul	s16,	s9,	s0
    ldr	x24,	[sp, #952]

    fadd	s14,	s5,	s16
    str	s14,	[x24]

    ldr	w4,	[sp, #968]

    ldr	w27,	[sp, #992]

    add	w13,	w4,	#1
    cmp	w13,	w27
    blt	main_60

main_108:
    ldr	w10,	[sp, #1016]

    ldr	w9,	[sp, #996]

    add	w11,	w10,	#1
    cmp	w11,	w9
    blt	main_46

main_111:
    ldr	w5,	[sp, #916]

    ldr	w21,	[sp, #992]

    add	w10,	w5,	#1
    cmp	w10,	w21
    bge	main_116

main_41:
    str	w10,	[sp, #916]

    b	main_42

main_46:
    str	w11,	[sp, #1016]

    b	main_47

main_60:
    str	w13,	[sp, #968]

    b	main_61

main_116:
    ldr	w8,	[sp, #936]

    ldr	w0,	[sp, #996]

    add	w28,	w8,	#1
    cmp	w28,	w0
    bge	main_121

main_34:
    str	w28,	[sp, #936]

    b	main_35

main_121:
    movz	w2,	#0
    ldr	w13,	[sp, #996]

    cmp	w2,	w13
    bge	main_142

main_123:
    movz	w24,	#0
    mov	w28,	w24

main_125:
    lsl	w18,	w28,	#5
    ldr	x19,	[sp, #944]

    add	x20,	x19,	x18
    mov	x24,	x20
    ldr	s0,	[x24]

    bl	putfloat
    movz	w8,	#1
    mov	w27,	w8

main_130:
    ldr	w19,	[sp, #992]

    cmp	w27,	w19
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
    ldr	w14,	[sp, #996]

    add	w3,	w28,	#1
    cmp	w3,	w14
    bge	main_142

main_124:
    mov	w28,	w3
    b	main_125

main_142:
    movz	w0,	#10
    bl	putch
    movz	w14,	#0
    add	x18,	sp,	#272
    add	x9,	sp,	#272
    str	x9,	[sp, #1168]

    str	x18,	[sp, #1256]

    ldr	w13,	[sp, #996]

    cmp	w14,	w13
    bge	main_278

main_146:
    movz	fp,	#972
    fmov	s27,	#0.250000
    movz	w28,	#0
    ldr	x26,	[sp, fp]

    str	x26,	[sp, #960]

    ldr	x4,	[sp, #960]

    ldr	s24,	[x4]

    fmul	s22,	s27,	s24
    str	s22,	[sp, #876]

    ldr	w14,	[sp, #996]

    scvtf	s15,	w14
    str	s15,	[sp, #844]

    ldr	w26,	[sp, #992]

    scvtf	s19,	w26
    str	s19,	[sp, #848]

    ldr	w12,	[sp, #988]

    ldr	s13,	[sp, #844]

    fmov	s26,	w12
    fdiv	s16,	s26,	s13
    str	s16,	[sp, #868]

    ldr	w13,	[sp, #988]

    ldr	s17,	[sp, #848]

    fmov	s25,	w13
    fdiv	s19,	s25,	s17
    str	s19,	[sp, #872]

    str	w28,	[sp, #1012]


main_156:
    movz	w6,	#0
    ldr	w26,	[sp, #992]

    cmp	w6,	w26
    bge	main_273

main_159:
    ldr	w17,	[sp, #1012]

    fmov	s29,	#0.500000
    movz	w14,	#0
    ldr	x19,	[sp, #1256]

    lsl	w13,	w17,	#5
    add	x12,	x19,	x13
    str	x12,	[sp, #1176]

    ldr	w18,	[sp, #1012]

    ldr	s17,	[sp, #868]

    scvtf	s4,	w18
    fadd	s19,	s4,	s29
    fmul	s25,	s17,	s19
    str	s25,	[sp, #892]

    str	w14,	[sp, #940]


main_165:
    ldr	w14,	[sp, #940]

    movz	w16,	#1
    ldr	x13,	[sp, #1176]

    lsl	w3,	w14,	#2
    mov	w17,	w16
    add	x14,	x13,	x3
    str	x14,	[sp, #928]

    ldr	s23,	[sp, #876]

    ldr	x15,	[sp, #928]

    str	s23,	[x15]


main_168:
    ldr	w15,	[sp, #996]

    cmp	w17,	w15
    bge	main_179

main_171:
    ldr	x15,	[sp, #928]

    lsl	w4,	w17,	#5
    movz	fp,	#972
    fmov	s1,	#0.500000
    add	w16,	w17,	#1
    ldr	s10,	[x15]

    mov	w17,	w16
    ldr	x8,	[sp, fp]

    add	x8,	x8,	x4
    ldr	s6,	[x8]

    ldr	x18,	[sp, #928]

    fmul	s16,	s1,	s6
    fadd	s28,	s10,	s16
    str	s28,	[x18]

    b	main_168

main_179:
    movz	w0,	#1

main_180:
    ldr	w1,	[sp, #992]

    cmp	w0,	w1
    bge	main_190

main_183:
    ldr	x19,	[sp, #928]

    lsl	w16,	w0,	#2
    fmov	s3,	#0.500000
    ldr	s20,	[x19]

    add	w0,	w0,	#1
    ldr	x17,	[sp, #960]

    add	x15,	x17,	x16
    ldr	s15,	[x15]

    ldr	x22,	[sp, #928]

    fmul	s24,	s3,	s15
    fadd	s5,	s20,	s24
    str	s5,	[x22]

    b	main_180

main_190:
    movz	w6,	#1
    ldr	w18,	[sp, #996]

    cmp	w6,	w18
    bge	main_263

main_192:
    ldr	w15,	[sp, #940]

    fmov	s6,	#0.500000
    movz	w22,	#1
    ldr	s20,	[sp, #872]

    scvtf	s28,	w15
    fadd	s10,	s28,	s6
    fmul	s13,	s20,	s10
    str	s13,	[sp, #864]

    str	w22,	[sp, #920]


main_197:
    movz	w8,	#1
    ldr	w2,	[sp, #992]

    cmp	w8,	w2
    bge	main_258

main_200:
    ldr	w22,	[sp, #920]

    movz	fp,	#972
    movz	w2,	#1
    lsl	w3,	w22,	#5
    ldr	x9,	[sp, fp]

    add	x6,	x9,	x3
    str	x6,	[sp, #1304]

    ldr	w21,	[sp, #920]

    ldr	s26,	[sp, #892]

    scvtf	s15,	w21
    ldr	w22,	[sp, #980]

    fmul	s15,	s26,	s15
    fmov	s4,	w22
    fadd	s3,	s15,	s4
    str	s3,	[sp, #860]

    ldr	w8,	[sp, #1000]

    ldr	s2,	[sp, #860]

    fmov	s3,	w8
    ldr	w9,	[sp, #1000]

    fdiv	s5,	s2,	s3
    ldr	s4,	[sp, #860]

    fmov	s1,	w9
    frintz	s7,	s5
    fcvtzs	w6,	s5
    fmul	s8,	s7,	s1
    fsub	s23,	s4,	s8
    str	s23,	[sp, #852]

    str	w2,	[sp, #924]


main_211:
    ldr	x18,	[sp, #928]

    ldr	s8,	[x18]

    str	s8,	[sp, #880]

    ldr	w21,	[sp, #924]

    ldr	x23,	[sp, #1304]

    lsl	w18,	w21,	#2
    add	x23,	x23,	x18
    ldr	s15,	[x23]

    ldr	w28,	[sp, #784]

    ldr	s13,	[sp, #860]

    fmov	s10,	w28
    fcmp	s13,	s10
    cset	w23,	lt
    ldr	s13,	[sp, #852]

    ldr	s10,	[sp, #860]

    ldr	w18,	[sp, #1000]

    fcsel	s11,	s13,	s10,	lt
    fmov	s13,	w18
    str	s13,	[sp, #840]

    ldr	s13,	[sp, #840]

    ldr	s9,	[sp, #860]

    fcmp	s9,	s13
    cset	w23,	gt
    ldr	s13,	[sp, #852]

    fcsel	s10,	s13,	s11,	gt
    str	s10,	[sp, #796]

    ldr	w21,	[sp, #1000]

    ldr	s13,	[sp, #796]

    fmov	s11,	w21
    ldr	w18,	[sp, #988]

    fsub	s10,	s13,	s11
    fmov	s8,	w18
    str	s8,	[sp, #800]

    ldr	s8,	[sp, #800]

    ldr	s13,	[sp, #796]

    fcmp	s13,	s8
    cset	w23,	gt
    ldr	s8,	[sp, #796]

    fcsel	s11,	s10,	s8,	gt
    str	s11,	[sp, #808]

    ldr	w22,	[sp, #1000]

    ldr	s9,	[sp, #808]

    fmov	s8,	w22
    ldr	w26,	[sp, #984]

    fadd	s14,	s9,	s8
    fmov	s9,	w26
    str	s9,	[sp, #804]

    ldr	s9,	[sp, #804]

    ldr	s8,	[sp, #808]

    fcmp	s8,	s9
    ldr	s9,	[sp, #808]

    cset	w18,	lt
    fcsel	s0,	s14,	s9,	lt
    bl	my_sin_impl
    ldr	w0,	[sp, #924]

    fmul	s9,	s15,	s0
    ldr	s14,	[sp, #864]

    scvtf	s24,	w0
    ldr	w23,	[sp, #980]

    fmul	s23,	s14,	s24
    ldr	w13,	[sp, #1000]

    fmov	s16,	w23
    fmov	s15,	w13
    fadd	s24,	s23,	s16
    fcmp	s24,	s15
    bgt	main_236

main_232:
    ldr	w15,	[sp, #784]

    fmov	s28,	w15
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
    ldr	w28,	[sp, #1000]

    ldr	w21,	[sp, #988]

    fmov	s15,	w28
    fmov	s14,	w21
    fsub	s8,	s24,	s15
    str	s14,	[sp, #836]

    ldr	s15,	[sp, #836]

    fcmp	s24,	s15
    cset	w23,	gt
    fcsel	s14,	s8,	s24,	gt
    str	s14,	[sp, #816]

    ldr	w18,	[sp, #1000]

    ldr	s13,	[sp, #816]

    fmov	s11,	w18
    ldr	w27,	[sp, #984]

    fadd	s13,	s13,	s11
    fmov	s15,	w27
    str	s15,	[sp, #812]

    ldr	s10,	[sp, #812]

    ldr	s15,	[sp, #816]

    fcmp	s15,	s10
    ldr	s15,	[sp, #816]

    cset	w23,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    ldr	s11,	[sp, #880]

    fmul	s7,	s9,	s0
    ldr	x22,	[sp, #928]

    fadd	s7,	s11,	s7
    str	s7,	[x22]

    ldr	w1,	[sp, #924]

    ldr	w6,	[sp, #992]

    add	w1,	w1,	#1
    cmp	w1,	w6
    bge	main_258

main_210:
    str	w1,	[sp, #924]

    b	main_211

main_258:
    ldr	w26,	[sp, #920]

    ldr	w17,	[sp, #996]

    add	w28,	w26,	#1
    cmp	w28,	w17
    bge	main_263

main_196:
    str	w28,	[sp, #920]

    b	main_197

main_263:
    ldr	x26,	[sp, #928]

    fmov	s29,	#2.000000
    fmov	s28,	#2.000000
    ldr	s19,	[x26]

    ldr	s14,	[sp, #844]

    fmul	s31,	s19,	s29
    ldr	s19,	[sp, #848]

    fdiv	s21,	s31,	s14
    ldr	x27,	[sp, #928]

    fmul	s2,	s21,	s28
    fdiv	s3,	s2,	s19
    str	s3,	[x27]

    ldr	w16,	[sp, #940]

    ldr	w1,	[sp, #992]

    add	w18,	w16,	#1
    cmp	w18,	w1
    bge	main_273

main_164:
    str	w18,	[sp, #940]

    b	main_165

main_273:
    ldr	w19,	[sp, #1012]

    ldr	w9,	[sp, #996]

    add	w1,	w19,	#1
    cmp	w1,	w9
    bge	main_278

main_155:
    str	w1,	[sp, #1012]

    b	main_156

main_278:
    movz	w19,	#0
    ldr	w21,	[sp, #996]

    cmp	w19,	w21
    bge	main_299

main_280:
    movz	w25,	#0

main_282:
    lsl	w28,	w25,	#5
    ldr	x18,	[sp, #1168]

    add	x26,	x18,	x28
    ldr	s0,	[x26]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w0,	[sp, #992]

    cmp	w19,	w0
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
    ldr	w20,	[sp, #996]

    add	w25,	w25,	#1
    cmp	w25,	w20
    blt	main_282

main_299:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1760
    ret


