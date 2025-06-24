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
    sub	sp, sp, #1664
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
    str	w0,	[sp, #1004]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #1000]

    ldr	w10,	[sp, #1004]

    cmp	w22,	w10
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
    ldr	w11,	[sp, #1000]

    cmp	w27,	w11
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
    ldr	w13,	[sp, #1004]

    cmp	w6,	w13
    bge	main_24

main_8:
    mov	w19,	w6
    b	main_9

main_24:
    add	x8,	sp,	#16
    movz	fp,	#932
    add	x5,	sp,	#16
    add	x10,	sp,	#528
    movz	w2,	#0
    movz	w0,	#4059
    movz	w26,	#4059
    movz	w9,	#4059
    movz	w18,	#4059
    str	x8,	[sp, fp]

    movk	w0,	#16457,	lsl #16
    movk	w26,	#16329,	lsl #16
    movk	w9,	#16585,	lsl #16
    movk	w18,	#49353,	lsl #16
    movz	w8,	#4059
    movz	fp,	#964
    movk	w8,	#49225,	lsl #16
    str	x5,	[sp, fp]

    str	x10,	[sp, #1088]

    str	w8,	[sp, #788]

    str	w0,	[sp, #996]

    str	w26,	[sp, #784]

    str	w9,	[sp, #1008]

    str	w18,	[sp, #976]

    ldr	w1,	[sp, #1004]

    cmp	w2,	w1
    bge	main_121

main_29:
    ldr	w13,	[sp, #1004]

    movz	w4,	#0
    scvtf	s17,	w13
    ldr	w13,	[sp, #996]

    fmov	s12,	w13
    fdiv	s3,	s12,	s17
    str	s3,	[sp, #904]

    ldr	w25,	[sp, #1000]

    ldr	w14,	[sp, #996]

    scvtf	s17,	w25
    str	w4,	[sp, #960]

    fmov	s12,	w14
    fdiv	s13,	s12,	s17

main_35:
    movz	w5,	#0
    ldr	w15,	[sp, #1000]

    cmp	w5,	w15
    bge	main_116

main_38:
    ldr	w11,	[sp, #960]

    movz	fp,	#964
    movz	w12,	#0
    lsl	w18,	w11,	#5
    ldr	x4,	[sp, fp]

    movz	fp,	#1044
    add	x15,	x4,	x18
    str	x15,	[sp, fp]

    ldr	w28,	[sp, #960]

    str	w12,	[sp, #940]

    scvtf	s8,	w28

main_42:
    ldr	w8,	[sp, #940]

    movz	fp,	#1044
    movi	v29.4s,	#0
    movz	w2,	#0
    lsl	w1,	w8,	#2
    ldr	x17,	[sp, fp]

    movz	fp,	#1052
    add	x18,	x17,	x1
    str	x18,	[sp, fp]

    movz	fp,	#1052
    ldr	x19,	[sp, fp]

    str	s29,	[x19]

    ldr	w9,	[sp, #940]

    scvtf	s1,	w9
    str	s1,	[sp, #900]

    str	w2,	[sp, #1084]


main_47:
    ldr	w5,	[sp, #1084]

    fmov	s3,	#0.500000
    movz	w17,	#0
    ldr	x12,	[sp, #1088]

    lsl	w5,	w5,	#5
    add	x21,	x12,	x5
    str	x21,	[sp, #1272]

    ldr	w6,	[sp, #1084]

    ldr	s5,	[sp, #904]

    scvtf	s29,	w6
    ldr	w27,	[sp, #784]

    fadd	s7,	s29,	s3
    fmov	s23,	w27
    fmul	s5,	s5,	s7
    fmul	s6,	s5,	s8
    fadd	s30,	s6,	s23
    str	s30,	[sp, #852]

    ldr	w0,	[sp, #1008]

    ldr	s7,	[sp, #852]

    fmov	s21,	w0
    ldr	w1,	[sp, #1008]

    fdiv	s2,	s7,	s21
    ldr	s10,	[sp, #852]

    fmov	s26,	w1
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s10,	s5
    str	s6,	[sp, #828]

    str	w17,	[sp, #984]


main_61:
    movz	fp,	#1052
    ldr	x25,	[sp, fp]

    ldr	s12,	[x25]

    str	s12,	[sp, #908]

    ldr	w18,	[sp, #984]

    ldr	x27,	[sp, #1272]

    lsl	w26,	w18,	#2
    add	x26,	x27,	x26
    ldr	s12,	[x26]

    str	s12,	[sp, #916]

    ldr	w23,	[sp, #976]

    ldr	s12,	[sp, #852]

    fmov	s11,	w23
    fcmp	s12,	s11
    cset	w18,	lt
    ldr	s9,	[sp, #828]

    ldr	s15,	[sp, #852]

    ldr	w23,	[sp, #1008]

    fcsel	s9,	s9,	s15,	lt
    ldr	s11,	[sp, #852]

    fmov	s10,	w23
    fcmp	s11,	s10
    cset	w18,	gt
    ldr	s11,	[sp, #828]

    ldr	w26,	[sp, #1008]

    fcsel	s15,	s11,	s9,	gt
    ldr	w19,	[sp, #996]

    fmov	s11,	w26
    fmov	s9,	w19
    fsub	s12,	s15,	s11
    str	s9,	[sp, #820]

    ldr	s14,	[sp, #820]

    fcmp	s15,	s14
    ldr	w27,	[sp, #1008]

    fcsel	s14,	s12,	s15,	gt
    cset	w18,	gt
    fmov	s12,	w27
    ldr	w18,	[sp, #788]

    fadd	s12,	s14,	s12
    fmov	s9,	w18
    str	s9,	[sp, #824]

    ldr	s15,	[sp, #824]

    fcmp	s14,	s15
    fcsel	s0,	s12,	s14,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	s16,	[sp, #916]

    fmov	s5,	#0.500000
    fmul	s11,	s16,	s0
    str	s11,	[sp, #912]

    ldr	w25,	[sp, #984]

    ldr	s2,	[sp, #900]

    scvtf	s11,	w25
    ldr	w1,	[sp, #784]

    fadd	s25,	s11,	s5
    ldr	w8,	[sp, #1008]

    fmov	s30,	w1
    fmul	s28,	s13,	s25
    fmov	s29,	w8
    fmul	s27,	s28,	s2
    fadd	s19,	s27,	s30
    fcmp	s19,	s29
    bgt	main_88

main_84:
    ldr	w18,	[sp, #976]

    fmov	s9,	w18
    fcmp	s19,	s9
    bge	main_95

main_88:
    ldr	w9,	[sp, #1008]

    ldr	w10,	[sp, #1008]

    fmov	s7,	w9
    fmov	s1,	w10
    fdiv	s20,	s19,	s7
    frintz	s25,	s20
    fcvtzs	w1,	s20
    fmul	s26,	s25,	s1
    fsub	s19,	s19,	s26

main_95:
    ldr	w19,	[sp, #1008]

    ldr	w23,	[sp, #996]

    fmov	s11,	w19
    fmov	s10,	w23
    fsub	s12,	s19,	s11
    fcmp	s19,	s10
    fcsel	s14,	s12,	s19,	gt
    ldr	w23,	[sp, #1008]

    cset	w18,	gt
    ldr	w19,	[sp, #788]

    fmov	s10,	w23
    fmov	s15,	w19
    fadd	s12,	s14,	s10
    str	s15,	[sp, #816]

    ldr	s9,	[sp, #816]

    fcmp	s14,	s9
    fcsel	s0,	s12,	s14,	lt
    cset	w18,	lt
    bl	my_sin_impl
    movz	fp,	#1052
    ldr	s12,	[sp, #912]

    ldr	s9,	[sp, #908]

    fmul	s14,	s12,	s0
    ldr	x21,	[sp, fp]

    fadd	s12,	s9,	s14
    str	s12,	[x21]

    ldr	w26,	[sp, #984]

    ldr	w1,	[sp, #1000]

    add	w0,	w26,	#1
    cmp	w0,	w1
    blt	main_60

main_108:
    ldr	w7,	[sp, #1084]

    ldr	w14,	[sp, #1004]

    add	w6,	w7,	#1
    cmp	w6,	w14
    blt	main_46

main_111:
    ldr	w10,	[sp, #940]

    ldr	w27,	[sp, #1000]

    add	w16,	w10,	#1
    cmp	w16,	w27
    bge	main_116

main_41:
    str	w16,	[sp, #940]

    b	main_42

main_46:
    str	w6,	[sp, #1084]

    b	main_47

main_60:
    str	w0,	[sp, #984]

    b	main_61

main_116:
    ldr	w13,	[sp, #960]

    ldr	w4,	[sp, #1004]

    add	w8,	w13,	#1
    cmp	w8,	w4
    bge	main_121

main_34:
    str	w8,	[sp, #960]

    b	main_35

main_121:
    movz	w2,	#0
    ldr	w18,	[sp, #1004]

    cmp	w2,	w18
    bge	main_142

main_123:
    movz	w28,	#0
    mov	w27,	w28

main_125:
    lsl	w22,	w27,	#5
    movz	fp,	#932
    ldr	x26,	[sp, fp]

    add	x22,	x26,	x22
    mov	x18,	x22
    ldr	s0,	[x18]

    bl	putfloat
    movz	w8,	#1
    mov	w21,	w8

main_130:
    ldr	w1,	[sp, #1000]

    cmp	w21,	w1
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
    ldr	w19,	[sp, #1004]

    add	w3,	w27,	#1
    cmp	w3,	w19
    bge	main_142

main_124:
    mov	w27,	w3
    b	main_125

main_142:
    movz	w0,	#10
    bl	putch
    movz	w14,	#0
    add	x12,	sp,	#272
    movz	fp,	#1020
    add	x10,	sp,	#272
    str	x10,	[sp, fp]

    movz	fp,	#1036
    str	x12,	[sp, fp]

    ldr	w20,	[sp, #1004]

    cmp	w14,	w20
    bge	main_278

main_146:
    movz	fp,	#964
    fmov	s27,	#0.250000
    movz	w28,	#0
    ldr	x0,	[sp, fp]

    movz	fp,	#988
    str	x0,	[sp, fp]

    movz	fp,	#988
    ldr	x4,	[sp, fp]

    ldr	s24,	[x4]

    fmul	s28,	s27,	s24
    str	s28,	[sp, #880]

    ldr	w19,	[sp, #1004]

    scvtf	s15,	w19
    str	s15,	[sp, #840]

    ldr	w1,	[sp, #1000]

    scvtf	s19,	w1
    str	s19,	[sp, #844]

    ldr	w17,	[sp, #996]

    ldr	s13,	[sp, #840]

    fmov	s26,	w17
    fdiv	s19,	s26,	s13
    str	s19,	[sp, #868]

    ldr	w18,	[sp, #996]

    ldr	s17,	[sp, #844]

    fmov	s25,	w18
    fdiv	s22,	s25,	s17
    str	s22,	[sp, #872]

    str	w28,	[sp, #1096]


main_156:
    movz	w6,	#0
    ldr	w0,	[sp, #1000]

    cmp	w6,	w0
    bge	main_273

main_159:
    ldr	w14,	[sp, #1096]

    movz	fp,	#1036
    fmov	s29,	#0.500000
    movz	w16,	#0
    lsl	w15,	w14,	#5
    ldr	x13,	[sp, fp]

    movz	fp,	#1028
    add	x9,	x13,	x15
    str	x9,	[sp, fp]

    ldr	w15,	[sp, #1096]

    ldr	s20,	[sp, #868]

    scvtf	s4,	w15
    fadd	s18,	s4,	s29
    fmul	s25,	s20,	s18
    str	s25,	[sp, #876]

    str	w16,	[sp, #944]


main_165:
    ldr	w14,	[sp, #944]

    movz	fp,	#1028
    movz	w16,	#1
    lsl	w3,	w14,	#2
    ldr	x10,	[sp, fp]

    mov	w17,	w16
    movz	fp,	#948
    add	x13,	x10,	x3
    str	x13,	[sp, fp]

    movz	fp,	#948
    ldr	s29,	[sp, #880]

    ldr	x14,	[sp, fp]

    str	s29,	[x14]


main_168:
    ldr	w20,	[sp, #1004]

    cmp	w17,	w20
    bge	main_179

main_171:
    movz	fp,	#948
    lsl	w4,	w17,	#5
    fmov	s1,	#0.500000
    add	w16,	w17,	#1
    ldr	x27,	[sp, fp]

    mov	w17,	w16
    movz	fp,	#964
    ldr	s10,	[x27]

    ldr	x13,	[sp, fp]

    movz	fp,	#948
    add	x8,	x13,	x4
    ldr	s6,	[x8]

    ldr	x28,	[sp, fp]

    fmul	s16,	s1,	s6
    fadd	s28,	s10,	s16
    str	s28,	[x28]

    b	main_168

main_179:
    movz	w0,	#1

main_180:
    ldr	w3,	[sp, #1000]

    cmp	w0,	w3
    bge	main_190

main_183:
    movz	fp,	#948
    lsl	w16,	w0,	#2
    fmov	s3,	#0.500000
    add	w0,	w0,	#1
    ldr	x1,	[sp, fp]

    movz	fp,	#988
    ldr	s20,	[x1]

    ldr	x20,	[sp, fp]

    movz	fp,	#948
    add	x15,	x20,	x16
    ldr	s15,	[x15]

    ldr	x2,	[sp, fp]

    fmul	s24,	s3,	s15
    fadd	s5,	s20,	s24
    str	s5,	[x2]

    b	main_180

main_190:
    movz	w6,	#1
    ldr	w22,	[sp, #1004]

    cmp	w6,	w22
    bge	main_263

main_192:
    ldr	w15,	[sp, #944]

    fmov	s6,	#0.500000
    movz	w0,	#1
    ldr	s23,	[sp, #872]

    scvtf	s28,	w15
    fadd	s10,	s28,	s6
    fmul	s16,	s23,	s10
    str	s16,	[sp, #864]

    str	w0,	[sp, #972]


main_197:
    movz	w8,	#1
    ldr	w2,	[sp, #1000]

    cmp	w8,	w2
    bge	main_258

main_200:
    ldr	w21,	[sp, #972]

    movz	fp,	#964
    lsl	w3,	w21,	#5
    ldr	x7,	[sp, fp]

    movz	fp,	#1180
    add	x6,	x7,	x3
    movz	w3,	#1
    str	x6,	[sp, fp]

    ldr	w0,	[sp, #972]

    ldr	s26,	[sp, #876]

    scvtf	s15,	w0
    ldr	w1,	[sp, #784]

    fmul	s15,	s26,	s15
    fmov	s4,	w1
    fadd	s3,	s15,	s4
    str	s3,	[sp, #856]

    ldr	w10,	[sp, #1008]

    ldr	s3,	[sp, #856]

    fmov	s1,	w10
    ldr	w11,	[sp, #1008]

    fdiv	s4,	s3,	s1
    fmov	s30,	w11
    frintz	s6,	s4
    fcvtzs	w6,	s4
    fmul	s7,	s6,	s30
    ldr	s4,	[sp, #856]

    fsub	s23,	s4,	s7
    str	s23,	[sp, #848]

    str	w3,	[sp, #956]


main_211:
    movz	fp,	#948
    ldr	x19,	[sp, fp]

    movz	fp,	#1180
    ldr	s11,	[x19]

    str	s11,	[sp, #860]

    ldr	w28,	[sp, #956]

    ldr	x23,	[sp, fp]

    lsl	w18,	w28,	#2
    add	x18,	x23,	x18
    ldr	s14,	[x18]

    str	s14,	[sp, #884]

    ldr	w28,	[sp, #976]

    ldr	s11,	[sp, #856]

    fmov	s10,	w28
    fcmp	s11,	s10
    ldr	s12,	[sp, #848]

    cset	w18,	lt
    ldr	s11,	[sp, #856]

    ldr	w27,	[sp, #1008]

    fcsel	s15,	s12,	s11,	lt
    fmov	s13,	w27
    str	s13,	[sp, #836]

    ldr	s10,	[sp, #836]

    ldr	s13,	[sp, #856]

    fcmp	s13,	s10
    cset	w18,	gt
    ldr	s12,	[sp, #848]

    fcsel	s12,	s12,	s15,	gt
    str	s12,	[sp, #792]

    ldr	w28,	[sp, #1008]

    ldr	s12,	[sp, #792]

    fmov	s15,	w28
    ldr	w25,	[sp, #996]

    fsub	s13,	s12,	s15
    fmov	s15,	w25
    str	s15,	[sp, #796]

    ldr	s10,	[sp, #796]

    ldr	s14,	[sp, #792]

    fcmp	s14,	s10
    cset	w18,	gt
    ldr	s14,	[sp, #792]

    fcsel	s12,	s13,	s14,	gt
    str	s12,	[sp, #804]

    ldr	w18,	[sp, #1008]

    ldr	s12,	[sp, #804]

    fmov	s13,	w18
    ldr	w19,	[sp, #788]

    fadd	s12,	s12,	s13
    fmov	s8,	w19
    str	s8,	[sp, #800]

    ldr	s10,	[sp, #800]

    ldr	s14,	[sp, #804]

    fcmp	s14,	s10
    ldr	s15,	[sp, #804]

    cset	w18,	lt
    fcsel	s0,	s12,	s15,	lt
    bl	my_sin_impl
    ldr	s9,	[sp, #884]

    ldr	w6,	[sp, #956]

    fmul	s9,	s9,	s0
    ldr	s17,	[sp, #864]

    scvtf	s22,	w6
    ldr	w0,	[sp, #784]

    fmul	s21,	s17,	s22
    ldr	w15,	[sp, #1008]

    fmov	s14,	w0
    fmov	s13,	w15
    fadd	s24,	s21,	s14
    fcmp	s24,	s13
    bgt	main_236

main_232:
    ldr	w23,	[sp, #976]

    fmov	s26,	w23
    fcmp	s24,	s26
    bge	main_243

main_236:
    ldr	w16,	[sp, #1008]

    ldr	w17,	[sp, #1008]

    fmov	s29,	w16
    fmov	s26,	w17
    fdiv	s29,	s24,	s29
    frintz	s31,	s29
    fcvtzs	w9,	s29
    fmul	s1,	s31,	s26
    fsub	s24,	s24,	s1

main_243:
    ldr	w23,	[sp, #1008]

    ldr	w27,	[sp, #996]

    fmov	s15,	w23
    fmov	s14,	w27
    fsub	s8,	s24,	s15
    str	s14,	[sp, #832]

    ldr	s15,	[sp, #832]

    fcmp	s24,	s15
    cset	w18,	gt
    fcsel	s14,	s8,	s24,	gt
    str	s14,	[sp, #812]

    ldr	w25,	[sp, #1008]

    ldr	s12,	[sp, #812]

    fmov	s8,	w25
    ldr	w23,	[sp, #788]

    fadd	s13,	s12,	s8
    fmov	s15,	w23
    str	s15,	[sp, #808]

    ldr	s10,	[sp, #808]

    ldr	s15,	[sp, #812]

    fcmp	s15,	s10
    ldr	s15,	[sp, #812]

    cset	w18,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    movz	fp,	#948
    ldr	s14,	[sp, #860]

    fmul	s6,	s9,	s0
    ldr	x0,	[sp, fp]

    fadd	s6,	s14,	s6
    str	s6,	[x0]

    ldr	w7,	[sp, #956]

    ldr	w5,	[sp, #1000]

    add	w7,	w7,	#1
    cmp	w7,	w5
    bge	main_258

main_210:
    str	w7,	[sp, #956]

    b	main_211

main_258:
    ldr	w25,	[sp, #972]

    add	w1,	w25,	#1
    ldr	w25,	[sp, #1004]

    cmp	w1,	w25
    bge	main_263

main_196:
    str	w1,	[sp, #972]

    b	main_197

main_263:
    movz	fp,	#948
    fmov	s29,	#2.000000
    fmov	s28,	#2.000000
    ldr	x23,	[sp, fp]

    movz	fp,	#948
    ldr	s19,	[x23]

    ldr	s14,	[sp, #840]

    fmul	s31,	s19,	s29
    ldr	s19,	[sp, #844]

    fdiv	s21,	s31,	s14
    ldr	x25,	[sp, fp]

    fmul	s2,	s21,	s28
    fdiv	s3,	s2,	s19
    str	s3,	[x25]

    ldr	w16,	[sp, #944]

    ldr	w4,	[sp, #1000]

    add	w27,	w16,	#1
    cmp	w27,	w4
    bge	main_273

main_164:
    str	w27,	[sp, #944]

    b	main_165

main_273:
    ldr	w16,	[sp, #1096]

    ldr	w14,	[sp, #1004]

    add	w1,	w16,	#1
    cmp	w1,	w14
    bge	main_278

main_155:
    str	w1,	[sp, #1096]

    b	main_156

main_278:
    movz	w20,	#0
    ldr	w26,	[sp, #1004]

    cmp	w20,	w26
    bge	main_299

main_280:
    movz	w25,	#0

main_282:
    lsl	w28,	w25,	#5
    movz	fp,	#1020
    ldr	x26,	[sp, fp]

    add	x26,	x26,	x28
    ldr	s0,	[x26]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w5,	[sp, #1000]

    cmp	w19,	w5
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
    ldr	w26,	[sp, #1004]

    add	w25,	w25,	#1
    cmp	w25,	w26
    blt	main_282

main_299:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1664
    ret


