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
    movz	w1,	#0
    movz	w2,	#256
    add	x0,	sp,	#528
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#272
    bl	memset
    bl	getint
    str	w0,	[sp, #992]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #988]

    ldr	w6,	[sp, #992]

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
    add	x22,	x22,	#272

main_12:
    ldr	w15,	[sp, #988]

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
    ldr	w9,	[sp, #992]

    cmp	w6,	w9
    bge	main_24

main_8:
    mov	w19,	w6
    b	main_9

main_24:
    add	x4,	sp,	#528
    movz	fp,	#956
    add	x1,	sp,	#528
    add	x12,	sp,	#272
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
    str	x1,	[sp, #784]

    movk	w4,	#49225,	lsl #16
    str	x12,	[sp, #1048]

    str	w4,	[sp, #980]

    str	w10,	[sp, #984]

    str	w27,	[sp, #976]

    str	w26,	[sp, #996]

    str	w20,	[sp, #792]

    ldr	w26,	[sp, #992]

    cmp	w2,	w26
    bge	main_121

main_29:
    ldr	w9,	[sp, #992]

    movz	w25,	#0
    scvtf	s17,	w9
    ldr	w9,	[sp, #984]

    ldr	w20,	[sp, #988]

    fmov	s12,	w9
    ldr	w10,	[sp, #984]

    scvtf	s2,	w20
    fdiv	s14,	s12,	s17
    fmov	s9,	w10
    fdiv	s28,	s9,	s2
    str	s28,	[sp, #908]

    str	w25,	[sp, #972]


main_35:
    movz	w5,	#0
    ldr	w11,	[sp, #988]

    cmp	w5,	w11
    bge	main_116

main_38:
    ldr	w7,	[sp, #972]

    ldr	x0,	[sp, #784]

    lsl	w18,	w7,	#5
    ldr	w23,	[sp, #972]

    movz	w7,	#0
    add	x22,	x0,	x18
    scvtf	s13,	w23
    str	w7,	[sp, #952]


main_42:
    ldr	w4,	[sp, #952]

    movz	fp,	#1284
    movi	v29.4s,	#0
    movz	w14,	#0
    lsl	w23,	w4,	#2
    add	x7,	x22,	x23
    str	x7,	[sp, fp]

    movz	fp,	#1284
    ldr	x8,	[sp, fp]

    str	s29,	[x8]

    ldr	w11,	[sp, #952]

    scvtf	s28,	w11
    str	s28,	[sp, #904]

    str	w14,	[sp, #968]


main_47:
    ldr	w24,	[sp, #968]

    fmov	s3,	#0.500000
    movz	w8,	#0
    ldr	x1,	[sp, #1048]

    lsl	w4,	w24,	#5
    add	x26,	x1,	x4
    str	x26,	[sp, #1352]

    ldr	w25,	[sp, #968]

    ldr	w20,	[sp, #976]

    scvtf	s29,	w25
    fmov	s23,	w20
    fadd	s4,	s29,	s3
    fmul	s5,	s14,	s4
    fmul	s6,	s5,	s13
    fadd	s30,	s6,	s23
    str	s30,	[sp, #860]

    ldr	w1,	[sp, #996]

    ldr	s7,	[sp, #860]

    fmov	s21,	w1
    ldr	w0,	[sp, #996]

    fdiv	s2,	s7,	s21
    ldr	s9,	[sp, #860]

    fmov	s26,	w0
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s9,	s5
    str	s6,	[sp, #836]

    str	w8,	[sp, #964]


main_61:
    movz	fp,	#1284
    ldr	x19,	[sp, fp]

    ldr	s15,	[x19]

    str	s15,	[sp, #868]

    ldr	w28,	[sp, #964]

    ldr	x21,	[sp, #1352]

    lsl	w27,	w28,	#2
    add	x28,	x21,	x27
    ldr	s15,	[x28]

    str	s15,	[sp, #924]

    ldr	w28,	[sp, #792]

    ldr	s11,	[sp, #860]

    fmov	s10,	w28
    fcmp	s11,	s10
    ldr	s8,	[sp, #836]

    cset	w28,	lt
    ldr	s15,	[sp, #860]

    ldr	w21,	[sp, #996]

    fcsel	s8,	s8,	s15,	lt
    ldr	s10,	[sp, #860]

    fmov	s9,	w21
    fcmp	s10,	s9
    cset	w28,	gt
    ldr	s10,	[sp, #836]

    ldr	w24,	[sp, #996]

    fcsel	s15,	s10,	s8,	gt
    fmov	s10,	w24
    ldr	w24,	[sp, #984]

    fsub	s11,	s15,	s10
    fmov	s8,	w24
    str	s8,	[sp, #828]

    ldr	s12,	[sp, #828]

    fcmp	s15,	s12
    ldr	w27,	[sp, #996]

    fcsel	s12,	s11,	s15,	gt
    cset	w28,	gt
    fmov	s11,	w27
    ldr	w28,	[sp, #980]

    fadd	s11,	s12,	s11
    fmov	s8,	w28
    str	s8,	[sp, #832]

    ldr	s15,	[sp, #832]

    fcmp	s12,	s15
    fcsel	s0,	s11,	s12,	lt
    cset	w27,	lt
    bl	my_sin_impl
    ldr	s10,	[sp, #924]

    fmov	s5,	#0.500000
    fmul	s6,	s10,	s0
    str	s6,	[sp, #872]

    ldr	w18,	[sp, #964]

    ldr	s1,	[sp, #908]

    scvtf	s10,	w18
    ldr	s29,	[sp, #904]

    fadd	s27,	s10,	s5
    ldr	w27,	[sp, #976]

    fmul	s27,	s1,	s27
    ldr	w9,	[sp, #996]

    fmov	s30,	w27
    fmul	s27,	s27,	s29
    fmov	s29,	w9
    fadd	s19,	s27,	s30
    fcmp	s19,	s29
    bgt	main_88

main_84:
    ldr	w16,	[sp, #792]

    fmov	s8,	w16
    fcmp	s19,	s8
    bge	main_95

main_88:
    ldr	w10,	[sp, #996]

    ldr	w11,	[sp, #996]

    fmov	s7,	w10
    fmov	s1,	w11
    fdiv	s20,	s19,	s7
    frintz	s25,	s20
    fcvtzs	w1,	s20
    fmul	s26,	s25,	s1
    fsub	s19,	s19,	s26

main_95:
    ldr	w21,	[sp, #996]

    fmov	s10,	w21
    ldr	w21,	[sp, #984]

    fsub	s11,	s19,	s10
    fmov	s9,	w21
    fcmp	s19,	s9
    ldr	w24,	[sp, #996]

    fcsel	s12,	s11,	s19,	gt
    cset	w28,	gt
    ldr	w18,	[sp, #980]

    fmov	s9,	w24
    fmov	s15,	w18
    fadd	s11,	s12,	s9
    str	s15,	[sp, #824]

    ldr	s8,	[sp, #824]

    fcmp	s12,	s8
    fcsel	s0,	s11,	s12,	lt
    cset	w27,	lt
    bl	my_sin_impl
    movz	fp,	#1284
    ldr	s7,	[sp, #872]

    ldr	s4,	[sp, #868]

    fmul	s12,	s7,	s0
    ldr	x10,	[sp, fp]

    fadd	s11,	s4,	s12
    str	s11,	[x10]

    ldr	w19,	[sp, #964]

    ldr	w28,	[sp, #988]

    add	w12,	w19,	#1
    cmp	w12,	w28
    blt	main_60

main_108:
    ldr	w26,	[sp, #968]

    ldr	w12,	[sp, #992]

    add	w10,	w26,	#1
    cmp	w10,	w12
    blt	main_46

main_111:
    ldr	w6,	[sp, #952]

    ldr	w21,	[sp, #988]

    add	w11,	w6,	#1
    cmp	w11,	w21
    bge	main_116

main_41:
    str	w11,	[sp, #952]

    b	main_42

main_46:
    str	w10,	[sp, #968]

    b	main_47

main_60:
    str	w12,	[sp, #964]

    b	main_61

main_116:
    ldr	w9,	[sp, #972]

    ldr	w1,	[sp, #992]

    add	w0,	w9,	#1
    cmp	w0,	w1
    bge	main_121

main_34:
    str	w0,	[sp, #972]

    b	main_35

main_121:
    movz	w2,	#0
    ldr	w14,	[sp, #992]

    cmp	w2,	w14
    bge	main_142

main_123:
    movz	w24,	#0
    mov	w28,	w24

main_125:
    lsl	w18,	w28,	#5
    movz	fp,	#956
    ldr	x20,	[sp, fp]

    add	x20,	x20,	x18
    mov	x24,	x20
    ldr	s0,	[x24]

    bl	putfloat
    movz	w8,	#1
    mov	w27,	w8

main_130:
    ldr	w22,	[sp, #988]

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
    ldr	w15,	[sp, #992]

    add	w3,	w28,	#1
    cmp	w3,	w15
    bge	main_142

main_124:
    mov	w28,	w3
    b	main_125

main_142:
    movz	w0,	#10
    bl	putch
    add	x17,	sp,	#16
    movz	fp,	#1236
    movz	w14,	#0
    add	x11,	sp,	#16
    str	x11,	[sp, fp]

    movz	fp,	#1276
    str	x17,	[sp, fp]

    ldr	w16,	[sp, #992]

    cmp	w14,	w16
    bge	main_278

main_146:
    ldr	x25,	[sp, #784]

    fmov	s27,	#0.250000
    str	x25,	[sp, #1040]

    ldr	x4,	[sp, #1040]

    ldr	s24,	[x4]

    fmul	s24,	s27,	s24
    str	s24,	[sp, #900]

    ldr	w15,	[sp, #992]

    scvtf	s15,	w15
    str	s15,	[sp, #848]

    ldr	w25,	[sp, #988]

    scvtf	s19,	w25
    movz	w25,	#0
    str	s19,	[sp, #852]

    ldr	w13,	[sp, #984]

    ldr	s13,	[sp, #848]

    fmov	s20,	w13
    fdiv	s21,	s20,	s13
    str	s21,	[sp, #896]

    ldr	w14,	[sp, #984]

    ldr	s17,	[sp, #852]

    fmov	s19,	w14
    fdiv	s15,	s19,	s17
    str	s15,	[sp, #888]

    str	w25,	[sp, #1056]


main_156:
    movz	w6,	#0
    ldr	w25,	[sp, #988]

    cmp	w6,	w25
    bge	main_273

main_159:
    ldr	w16,	[sp, #1056]

    movz	fp,	#1276
    fmov	s31,	#0.500000
    movz	w15,	#0
    lsl	w13,	w16,	#5
    ldr	x18,	[sp, fp]

    movz	fp,	#1308
    add	x14,	x18,	x13
    str	x14,	[sp, fp]

    ldr	w17,	[sp, #1056]

    ldr	s22,	[sp, #896]

    scvtf	s26,	w17
    fadd	s5,	s26,	s31
    fmul	s18,	s22,	s5
    str	s18,	[sp, #892]

    str	w15,	[sp, #936]


main_165:
    ldr	w10,	[sp, #936]

    movz	fp,	#1308
    movz	w16,	#1
    lsl	w3,	w10,	#2
    ldr	x15,	[sp, fp]

    mov	w17,	w16
    movz	fp,	#940
    add	x9,	x15,	x3
    str	x9,	[sp, fp]

    movz	fp,	#940
    ldr	s25,	[sp, #900]

    ldr	x10,	[sp, fp]

    str	s25,	[x10]


main_168:
    ldr	w14,	[sp, #992]

    cmp	w17,	w14
    bge	main_179

main_171:
    movz	fp,	#940
    lsl	w4,	w17,	#5
    fmov	s3,	#0.500000
    add	w16,	w17,	#1
    ldr	x20,	[sp, fp]

    mov	w17,	w16
    movz	fp,	#940
    ldr	s2,	[x20]

    ldr	x9,	[sp, #784]

    add	x8,	x9,	x4
    ldr	s7,	[x8]

    ldr	x21,	[sp, fp]

    fmul	s7,	s3,	s7
    fadd	s16,	s2,	s7
    str	s16,	[x21]

    b	main_168

main_179:
    movz	w0,	#1

main_180:
    ldr	w27,	[sp, #988]

    cmp	w0,	w27
    bge	main_190

main_183:
    movz	fp,	#940
    lsl	w18,	w0,	#2
    fmov	s4,	#0.500000
    add	w0,	w0,	#1
    ldr	x22,	[sp, fp]

    movz	fp,	#940
    ldr	s12,	[x22]

    ldr	x16,	[sp, #1040]

    add	x15,	x16,	x18
    ldr	s16,	[x15]

    ldr	x23,	[sp, fp]

    fmul	s17,	s4,	s16
    fadd	s25,	s12,	s17
    str	s25,	[x23]

    b	main_180

main_190:
    movz	w6,	#1
    ldr	w17,	[sp, #992]

    cmp	w6,	w17
    bge	main_263

main_192:
    ldr	w11,	[sp, #936]

    fmov	s7,	#0.500000
    movz	w24,	#1
    ldr	s16,	[sp, #888]

    scvtf	s22,	w11
    fadd	s31,	s22,	s7
    fmul	s12,	s16,	s31
    str	s12,	[sp, #884]

    str	w24,	[sp, #948]


main_197:
    movz	w8,	#1
    ldr	w1,	[sp, #988]

    cmp	w8,	w1
    bge	main_258

main_200:
    ldr	w16,	[sp, #948]

    movz	fp,	#1228
    ldr	x3,	[sp, #784]

    lsl	w5,	w16,	#5
    add	x8,	x3,	x5
    movz	w3,	#1
    str	x8,	[sp, fp]

    ldr	w23,	[sp, #948]

    ldr	s19,	[sp, #892]

    scvtf	s5,	w23
    ldr	w22,	[sp, #976]

    fmul	s4,	s19,	s5
    fmov	s2,	w22
    fadd	s3,	s4,	s2
    str	s3,	[sp, #864]

    ldr	w6,	[sp, #996]

    ldr	s3,	[sp, #864]

    fmov	s31,	w6
    ldr	w7,	[sp, #996]

    fdiv	s29,	s3,	s31
    ldr	s5,	[sp, #864]

    fmov	s4,	w7
    frintz	s31,	s29
    fcvtzs	w6,	s29
    fmul	s1,	s31,	s4
    fsub	s23,	s5,	s1
    str	s23,	[sp, #856]

    str	w3,	[sp, #932]


main_211:
    movz	fp,	#940
    ldr	x24,	[sp, fp]

    movz	fp,	#1228
    ldr	s15,	[x24]

    str	s15,	[sp, #880]

    ldr	w20,	[sp, #932]

    ldr	x25,	[sp, fp]

    lsl	w22,	w20,	#2
    add	x27,	x25,	x22
    ldr	s9,	[x27]

    ldr	w20,	[sp, #792]

    ldr	s8,	[sp, #864]

    fmov	s13,	w20
    fcmp	s8,	s13
    cset	w22,	lt
    ldr	s15,	[sp, #856]

    ldr	s12,	[sp, #864]

    ldr	w18,	[sp, #996]

    fcsel	s8,	s15,	s12,	lt
    fmov	s15,	w18
    str	s15,	[sp, #844]

    ldr	s10,	[sp, #844]

    ldr	s13,	[sp, #864]

    fcmp	s13,	s10
    cset	w27,	gt
    ldr	s14,	[sp, #856]

    fcsel	s12,	s14,	s8,	gt
    str	s12,	[sp, #800]

    ldr	w20,	[sp, #996]

    ldr	s15,	[sp, #800]

    fmov	s8,	w20
    ldr	w18,	[sp, #984]

    fsub	s8,	s15,	s8
    fmov	s11,	w18
    str	s11,	[sp, #804]

    ldr	s10,	[sp, #804]

    ldr	s14,	[sp, #800]

    fcmp	s14,	s10
    ldr	s11,	[sp, #800]

    cset	w25,	gt
    fcsel	s13,	s8,	s11,	gt
    str	s13,	[sp, #812]

    ldr	w21,	[sp, #996]

    ldr	s10,	[sp, #812]

    fmov	s11,	w21
    ldr	w24,	[sp, #980]

    fadd	s12,	s10,	s11
    fmov	s11,	w24
    str	s11,	[sp, #808]

    ldr	s10,	[sp, #808]

    ldr	s14,	[sp, #812]

    fcmp	s14,	s10
    ldr	s11,	[sp, #812]

    cset	w25,	lt
    fcsel	s0,	s12,	s11,	lt
    bl	my_sin_impl
    ldr	w2,	[sp, #932]

    fmul	s12,	s9,	s0
    ldr	s13,	[sp, #884]

    scvtf	s26,	w2
    ldr	w23,	[sp, #976]

    fmul	s25,	s13,	s26
    ldr	w11,	[sp, #996]

    fmov	s13,	w23
    fmov	s11,	w11
    fadd	s26,	s25,	s13
    fcmp	s26,	s11
    bgt	main_236

main_232:
    ldr	w16,	[sp, #792]

    fmov	s27,	w16
    fcmp	s26,	s27
    bge	main_243

main_236:
    ldr	w12,	[sp, #996]

    ldr	w13,	[sp, #996]

    fmov	s29,	w12
    fmov	s15,	w13
    fdiv	s23,	s26,	s29
    frintz	s25,	s23
    fcvtzs	w9,	s23
    fmul	s27,	s25,	s15
    fsub	s26,	s26,	s27

main_243:
    ldr	w26,	[sp, #996]

    ldr	w18,	[sp, #984]

    fmov	s13,	w26
    fmov	s14,	w18
    fsub	s8,	s26,	s13
    str	s14,	[sp, #840]

    ldr	s15,	[sp, #840]

    fcmp	s26,	s15
    cset	w27,	gt
    fcsel	s14,	s8,	s26,	gt
    str	s14,	[sp, #820]

    ldr	w18,	[sp, #996]

    ldr	s13,	[sp, #820]

    fmov	s10,	w18
    ldr	w26,	[sp, #980]

    fadd	s8,	s13,	s10
    fmov	s15,	w26
    str	s15,	[sp, #816]

    ldr	s10,	[sp, #816]

    ldr	s15,	[sp, #820]

    fcmp	s15,	s10
    ldr	s15,	[sp, #820]

    cset	w25,	lt
    fcsel	s0,	s8,	s15,	lt
    bl	my_sin_impl
    movz	fp,	#940
    ldr	s10,	[sp, #880]

    fmul	s6,	s12,	s0
    ldr	x23,	[sp, fp]

    fadd	s6,	s10,	s6
    str	s6,	[x23]

    ldr	w3,	[sp, #932]

    ldr	w1,	[sp, #988]

    add	w2,	w3,	#1
    cmp	w2,	w1
    bge	main_258

main_210:
    str	w2,	[sp, #932]

    b	main_211

main_258:
    ldr	w18,	[sp, #948]

    ldr	w17,	[sp, #992]

    add	w0,	w18,	#1
    cmp	w0,	w17
    bge	main_263

main_196:
    str	w0,	[sp, #948]

    b	main_197

main_263:
    movz	fp,	#940
    fmov	s31,	#2.000000
    fmov	s30,	#2.000000
    ldr	x17,	[sp, fp]

    movz	fp,	#940
    ldr	s13,	[x17]

    ldr	s14,	[sp, #848]

    fmul	s22,	s13,	s31
    ldr	s18,	[sp, #852]

    fdiv	s16,	s22,	s14
    ldr	x18,	[sp, fp]

    fmul	s24,	s16,	s30
    fdiv	s25,	s24,	s18
    str	s25,	[x18]

    ldr	w12,	[sp, #936]

    ldr	w0,	[sp, #988]

    add	w20,	w12,	#1
    cmp	w20,	w0
    bge	main_273

main_164:
    str	w20,	[sp, #936]

    b	main_165

main_273:
    ldr	w18,	[sp, #1056]

    ldr	w10,	[sp, #992]

    add	w0,	w18,	#1
    cmp	w0,	w10
    bge	main_278

main_155:
    str	w0,	[sp, #1056]

    b	main_156

main_278:
    movz	w19,	#0
    ldr	w22,	[sp, #992]

    cmp	w19,	w22
    bge	main_299

main_280:
    movz	w25,	#0

main_282:
    lsl	w28,	w25,	#5
    movz	fp,	#1236
    ldr	x18,	[sp, fp]

    add	x26,	x18,	x28
    ldr	s0,	[x26]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w1,	[sp, #988]

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
    ldr	w21,	[sp, #992]

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


