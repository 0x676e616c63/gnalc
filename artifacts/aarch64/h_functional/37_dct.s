.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl p
.align 2
.p2align 4,,11
.type p, %function
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
.align 2
.p2align 4,,11
.type my_sin_impl, %function
my_sin_impl:
my_sin_impl_1:
    sub	sp, sp, #96
    stp	x22, fp, [sp, #0]
    str	lr, [sp, 16]
    stp	q10, q11, [sp, #32]
    stp	q14, q15, [sp, #64]

    movi	v23.4s,	#0
    fneg	s1,	s0
    fcmp	s0,	s23
    movz	w14,	#14269
    fcsel	s3,	s0,	s1,	gt
    cset	w16,	gt
    movk	w14,	#13702,	lsl #16
    fmov	s11,	w14
    fcmp	s3,	s11
    ble	my_sin_impl_26

my_sin_impl_6:
    fmov	s27,	#3.000000
    fneg	s14,	s0
    fmov	s16,	#3.000000
    movi	v15.4s,	#0
    fdiv	s4,	s0,	s27
    fdiv	s16,	s14,	s16
    fcmp	s4,	s15
    fcsel	s26,	s4,	s16,	gt
    cset	w22,	gt
    fcmp	s26,	s11
    ble	my_sin_impl_18

my_sin_impl_13:
    fmov	s10,	#3.000000
    fdiv	s0,	s4,	s10
    bl	my_sin_impl
    bl	p
    fmov	s4,	s0

my_sin_impl_18:
    fmov	s30,	#3.000000
    fmov	s29,	#4.000000
    fmul	s31,	s30,	s4
    fmul	s16,	s29,	s4
    fmul	s17,	s16,	s4
    fmul	s5,	s17,	s4
    fsub	s0,	s31,	s5

my_sin_impl_26:
    ldp	x22, fp, [sp, #0]
    ldr	lr, [sp, 16]
    ldp	q10, q11, [sp, #32]
    ldp	q14, q15, [sp, #64]

    add	sp, sp, #96
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #1792
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#528
    bl	memset
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w1,	#0
    movz	w2,	#256
    add	x0,	sp,	#272
    bl	memset
    bl	getint
    str	w0,	[sp, #1012]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #1008]

    ldr	w10,	[sp, #1012]

    cmp	w22,	w10
    bge	main_24

main_7:
    movz	w6,	#0
    mov	w19,	w6

main_9:
    lsl	w0,	w19,	#5
    movz	w7,	#0
    mov	x27,	x0
    mov	w26,	w7
    add	x27,	sp,	x27
    add	x27,	x27,	#272

main_12:
    ldr	w11,	[sp, #1008]

    cmp	w26,	w11
    blt	main_15

main_19:
    add	w2,	w19,	#1
    ldr	w13,	[sp, #1012]

    cmp	w2,	w13
    bge	main_24

main_8:
    mov	w19,	w2
    b	main_9

main_15:
    lsl	w25,	w26,	#2
    add	x23,	x27,	x25
    bl	getfloat
    add	w7,	w26,	#1
    str	s0,	[x23]

    mov	w26,	w7
    b	main_12

main_24:
    add	x8,	sp,	#16
    movz	fp,	#972
    add	x5,	sp,	#16
    add	x25,	sp,	#272
    movz	w2,	#0
    movz	w10,	#4059
    movz	w17,	#4059
    movz	w4,	#4059
    movz	w18,	#4059
    str	x8,	[sp, fp]

    movk	w10,	#16457,	lsl #16
    movk	w17,	#16329,	lsl #16
    movk	w4,	#16585,	lsl #16
    movk	w18,	#49353,	lsl #16
    movz	w8,	#4059
    str	x5,	[sp, #784]

    movk	w8,	#49225,	lsl #16
    str	x25,	[sp, #1328]

    str	w8,	[sp, #964]

    str	w10,	[sp, #1004]

    str	w17,	[sp, #960]

    str	w4,	[sp, #1016]

    str	w18,	[sp, #792]

    ldr	w1,	[sp, #1012]

    cmp	w2,	w1
    bge	main_121

main_29:
    ldr	w13,	[sp, #1012]

    movz	w4,	#0
    scvtf	s4,	w13
    ldr	w13,	[sp, #1004]

    fmov	s24,	w13
    fdiv	s1,	s24,	s4
    str	s1,	[sp, #868]

    ldr	w24,	[sp, #1008]

    ldr	w14,	[sp, #1004]

    scvtf	s25,	w24
    str	w4,	[sp, #988]

    fmov	s13,	w14
    fdiv	s9,	s13,	s25

main_35:
    movz	w5,	#0
    ldr	w15,	[sp, #1008]

    cmp	w5,	w15
    bge	main_116

main_38:
    ldr	w11,	[sp, #988]

    movz	w13,	#0
    ldr	x4,	[sp, #784]

    lsl	w18,	w11,	#5
    add	x1,	x4,	x18
    str	x1,	[sp, #1312]

    ldr	w28,	[sp, #988]

    str	w13,	[sp, #928]

    scvtf	s8,	w28

main_42:
    ldr	w8,	[sp, #928]

    movi	v22.4s,	#0
    movz	w17,	#0
    ldr	x3,	[sp, #1312]

    lsl	w0,	w8,	#2
    add	x4,	x3,	x0
    str	x4,	[sp, #1320]

    ldr	x5,	[sp, #1320]

    str	s22,	[x5]

    ldr	w9,	[sp, #928]

    scvtf	s3,	w9
    str	s3,	[sp, #908]

    str	w17,	[sp, #1000]


main_47:
    ldr	w20,	[sp, #1000]

    movz	fp,	#1292
    fmov	s3,	#0.500000
    movz	w11,	#0
    ldr	x27,	[sp, #1328]

    lsl	w3,	w20,	#5
    add	x13,	x27,	x3
    str	x13,	[sp, fp]

    ldr	w21,	[sp, #1000]

    ldr	s20,	[sp, #868]

    scvtf	s16,	w21
    ldr	w26,	[sp, #960]

    fadd	s1,	s16,	s3
    fmul	s2,	s20,	s1
    fmul	s21,	s2,	s8
    fmov	s2,	w26
    fadd	s30,	s21,	s2
    str	s30,	[sp, #860]

    ldr	w0,	[sp, #1016]

    ldr	s31,	[sp, #860]

    fmov	s5,	w0
    ldr	w1,	[sp, #1016]

    fdiv	s5,	s31,	s5
    ldr	s1,	[sp, #860]

    frintz	s26,	s5
    fmov	s31,	w1
    fcvtzs	w2,	s5
    fmul	s12,	s26,	s31
    fsub	s6,	s1,	s12
    str	s6,	[sp, #836]

    str	w11,	[sp, #1308]


main_61:
    ldr	x18,	[sp, #1320]

    movz	fp,	#1292
    ldr	s15,	[x18]

    str	s15,	[sp, #872]

    ldr	w22,	[sp, #1308]

    ldr	x21,	[sp, fp]

    lsl	w22,	w22,	#2
    add	x22,	x21,	x22
    ldr	s15,	[x22]

    str	s15,	[sp, #920]

    ldr	w24,	[sp, #792]

    ldr	s15,	[sp, #860]

    fmov	s10,	w24
    fcmp	s15,	s10
    ldr	s15,	[sp, #836]

    cset	w22,	lt
    ldr	s11,	[sp, #860]

    ldr	w22,	[sp, #1016]

    fcsel	s12,	s15,	s11,	lt
    fmov	s10,	w22
    ldr	s11,	[sp, #860]

    fcmp	s11,	s10
    cset	w22,	gt
    ldr	s14,	[sp, #836]

    ldr	w24,	[sp, #1016]

    fcsel	s13,	s14,	s12,	gt
    ldr	w28,	[sp, #1004]

    fmov	s12,	w24
    fmov	s14,	w28
    fsub	s10,	s13,	s12
    str	s14,	[sp, #828]

    ldr	s15,	[sp, #828]

    fcmp	s13,	s15
    ldr	w25,	[sp, #1016]

    fcsel	s10,	s10,	s13,	gt
    cset	w22,	gt
    ldr	w28,	[sp, #964]

    fmov	s14,	w25
    fmov	s11,	w28
    fadd	s13,	s10,	s14
    str	s11,	[sp, #832]

    ldr	s12,	[sp, #832]

    fcmp	s10,	s12
    fcsel	s0,	s13,	s10,	lt
    cset	w22,	lt
    bl	my_sin_impl
    fmov	s19,	#0.500000
    ldr	s12,	[sp, #920]

    fmul	s12,	s12,	s0
    str	s12,	[sp, #876]

    ldr	w11,	[sp, #1308]

    ldr	s14,	[sp, #908]

    scvtf	s6,	w11
    ldr	w28,	[sp, #960]

    fadd	s29,	s6,	s19
    ldr	w8,	[sp, #1016]

    fmov	s18,	w28
    fmul	s30,	s9,	s29
    fmul	s11,	s30,	s14
    fadd	s30,	s11,	s18
    fmov	s11,	w8
    fcmp	s30,	s11
    bgt	main_88

main_84:
    ldr	w18,	[sp, #792]

    fmov	s20,	w18
    fcmp	s30,	s20
    bge	main_95

main_88:
    ldr	w9,	[sp, #1016]

    ldr	w10,	[sp, #1016]

    fmov	s26,	w9
    fmov	s21,	w10
    fdiv	s15,	s30,	s26
    fcvtzs	w1,	s15
    frintz	s15,	s15
    fmul	s15,	s15,	s21
    fsub	s30,	s30,	s15

main_95:
    ldr	w18,	[sp, #1016]

    fmov	s13,	w18
    ldr	w18,	[sp, #1004]

    fsub	s12,	s30,	s13
    fmov	s10,	w18
    fcmp	s30,	s10
    ldr	w21,	[sp, #1016]

    fcsel	s10,	s12,	s30,	gt
    cset	w22,	gt
    ldr	w18,	[sp, #964]

    fmov	s14,	w21
    fmov	s11,	w18
    fadd	s13,	s10,	s14
    str	s11,	[sp, #824]

    ldr	s12,	[sp, #824]

    fcmp	s10,	s12
    fcsel	s0,	s13,	s10,	lt
    cset	w22,	lt
    bl	my_sin_impl
    ldr	s13,	[sp, #876]

    ldr	s24,	[sp, #872]

    fmul	s6,	s13,	s0
    ldr	x7,	[sp, #1320]

    fadd	s19,	s24,	s6
    str	s19,	[x7]

    ldr	w12,	[sp, #1308]

    ldr	w28,	[sp, #1008]

    add	w11,	w12,	#1
    cmp	w11,	w28
    bge	main_108

main_60:
    str	w11,	[sp, #1308]

    b	main_61

main_108:
    ldr	w22,	[sp, #1000]

    ldr	w14,	[sp, #1012]

    add	w5,	w22,	#1
    cmp	w5,	w14
    bge	main_111

main_46:
    str	w5,	[sp, #1000]

    b	main_47

main_111:
    ldr	w10,	[sp, #928]

    ldr	w26,	[sp, #1008]

    add	w17,	w10,	#1
    cmp	w17,	w26
    blt	main_41

main_116:
    ldr	w13,	[sp, #988]

    ldr	w4,	[sp, #1012]

    add	w8,	w13,	#1
    cmp	w8,	w4
    blt	main_34

main_121:
    movz	w2,	#0
    ldr	w18,	[sp, #1012]

    cmp	w2,	w18
    bge	main_142

main_123:
    movz	w13,	#0
    str	w13,	[sp, #1180]


main_125:
    ldr	w28,	[sp, #1180]

    movz	fp,	#972
    lsl	w24,	w28,	#5
    ldr	x25,	[sp, fp]

    add	x24,	x25,	x24
    mov	x27,	x24
    ldr	s0,	[x27]

    bl	putfloat
    movz	w8,	#1
    mov	w21,	w8

main_130:
    ldr	w1,	[sp, #1008]

    cmp	w21,	w1
    blt	main_133

main_137:
    movz	w0,	#10
    bl	putch
    ldr	w24,	[sp, #1180]

    ldr	w19,	[sp, #1012]

    add	w16,	w24,	#1
    cmp	w16,	w19
    bge	main_142

main_124:
    str	w16,	[sp, #1180]

    b	main_125

main_133:
    movz	w0,	#32
    bl	putch
    lsl	w22,	w21,	#2
    add	x26,	x24,	x22
    ldr	s0,	[x26]

    bl	putfloat
    add	w3,	w21,	#1
    mov	w21,	w3
    b	main_130

main_142:
    movz	w0,	#10
    bl	putch
    movz	fp,	#1172
    add	x14,	sp,	#528
    add	x27,	sp,	#528
    str	x14,	[sp, fp]

    ldr	w7,	[sp, #1012]

    movz	w14,	#0
    cmp	w14,	w7
    bge	main_278

main_146:
    ldr	x3,	[sp, #784]

    fmov	s29,	#0.250000
    movz	w12,	#0
    str	x3,	[sp, #992]

    ldr	x4,	[sp, #992]

    ldr	s27,	[x4]

    fmul	s23,	s29,	s27
    str	s23,	[sp, #900]

    ldr	w8,	[sp, #1012]

    scvtf	s15,	w8
    str	s15,	[sp, #848]

    ldr	w5,	[sp, #1004]

    ldr	s16,	[sp, #848]

    fmov	s24,	w5
    fdiv	s17,	s24,	s16
    str	s17,	[sp, #892]

    ldr	w17,	[sp, #1008]

    scvtf	s19,	w17
    str	s19,	[sp, #852]

    ldr	w6,	[sp, #1004]

    ldr	s20,	[sp, #852]

    fmov	s19,	w6
    fdiv	s20,	s19,	s20
    str	s20,	[sp, #896]

    str	w12,	[sp, #1336]


main_156:
    movz	w6,	#0
    ldr	w2,	[sp, #1008]

    cmp	w6,	w2
    bge	main_273

main_159:
    ldr	w17,	[sp, #1336]

    movz	fp,	#1172
    fmov	s25,	#0.500000
    movz	w16,	#0
    lsl	w13,	w17,	#5
    ldr	x15,	[sp, fp]

    movz	fp,	#1300
    add	x3,	x15,	x13
    str	x3,	[sp, fp]

    ldr	w18,	[sp, #1336]

    ldr	s16,	[sp, #892]

    scvtf	s28,	w18
    fadd	s26,	s28,	s25
    fmul	s26,	s16,	s26
    str	s26,	[sp, #904]

    str	w16,	[sp, #936]


main_165:
    ldr	w19,	[sp, #936]

    movz	fp,	#1300
    movz	w14,	#1
    lsl	w3,	w19,	#2
    ldr	x4,	[sp, fp]

    movz	fp,	#980
    add	x19,	x4,	x3
    str	x19,	[sp, fp]

    movz	fp,	#980
    ldr	s24,	[sp, #900]

    ldr	x20,	[sp, fp]

    str	s24,	[x20]


main_168:
    ldr	w25,	[sp, #1012]

    cmp	w14,	w25
    blt	main_171

main_179:
    movz	w0,	#1

main_180:
    ldr	w5,	[sp, #1008]

    cmp	w0,	w5
    blt	main_183

main_190:
    movz	w2,	#1
    ldr	w28,	[sp, #1012]

    cmp	w2,	w28
    bge	main_263

main_192:
    ldr	w20,	[sp, #936]

    fmov	s4,	#0.500000
    movz	w1,	#1
    ldr	s20,	[sp, #896]

    scvtf	s27,	w20
    fadd	s3,	s27,	s4
    fmul	s13,	s20,	s3
    str	s13,	[sp, #884]

    str	w1,	[sp, #968]


main_197:
    movz	w4,	#1
    ldr	w6,	[sp, #1008]

    cmp	w4,	w6
    bge	main_258

main_200:
    ldr	w1,	[sp, #968]

    movz	fp,	#1188
    movz	w3,	#1
    ldr	x13,	[sp, #784]

    lsl	w12,	w1,	#5
    add	x6,	x13,	x12
    str	x6,	[sp, fp]

    ldr	w1,	[sp, #968]

    ldr	s25,	[sp, #904]

    scvtf	s31,	w1
    ldr	w0,	[sp, #960]

    fmul	s15,	s25,	s31
    fmov	s5,	w0
    fadd	s3,	s15,	s5
    str	s3,	[sp, #864]

    ldr	w13,	[sp, #1016]

    ldr	s4,	[sp, #864]

    fmov	s12,	w13
    fdiv	s5,	s4,	s12
    frintz	s23,	s5
    fcvtzs	w14,	s5
    ldr	w14,	[sp, #1016]

    ldr	s5,	[sp, #864]

    fmov	s6,	w14
    fmul	s13,	s23,	s6
    fsub	s23,	s5,	s13
    str	s23,	[sp, #856]

    str	w3,	[sp, #932]


main_211:
    movz	fp,	#980
    ldr	x21,	[sp, fp]

    movz	fp,	#1188
    ldr	s14,	[x21]

    str	s14,	[sp, #880]

    ldr	w21,	[sp, #932]

    ldr	x20,	[sp, fp]

    lsl	w18,	w21,	#2
    add	x21,	x20,	x18
    ldr	s10,	[x21]

    str	s10,	[sp, #916]

    ldr	w18,	[sp, #792]

    ldr	s10,	[sp, #864]

    fmov	s9,	w18
    fcmp	s10,	s9
    cset	w18,	lt
    ldr	s13,	[sp, #856]

    ldr	s10,	[sp, #864]

    ldr	w20,	[sp, #1016]

    fcsel	s11,	s13,	s10,	lt
    fmov	s9,	w20
    str	s9,	[sp, #844]

    ldr	s14,	[sp, #844]

    ldr	s13,	[sp, #864]

    fcmp	s13,	s14
    cset	w18,	gt
    ldr	s14,	[sp, #856]

    fcsel	s12,	s14,	s11,	gt
    str	s12,	[sp, #796]

    ldr	w21,	[sp, #1016]

    ldr	s13,	[sp, #796]

    fmov	s9,	w21
    ldr	w20,	[sp, #1004]

    fsub	s14,	s13,	s9
    fmov	s9,	w20
    str	s9,	[sp, #804]

    ldr	s8,	[sp, #804]

    ldr	s13,	[sp, #796]

    fcmp	s13,	s8
    cset	w21,	gt
    ldr	s15,	[sp, #796]

    fcsel	s12,	s14,	s15,	gt
    str	s12,	[sp, #812]

    ldr	w20,	[sp, #1016]

    ldr	s13,	[sp, #812]

    fmov	s9,	w20
    ldr	w23,	[sp, #964]

    fadd	s11,	s13,	s9
    fmov	s9,	w23
    str	s9,	[sp, #808]

    ldr	s13,	[sp, #808]

    ldr	s14,	[sp, #812]

    fcmp	s14,	s13
    ldr	s15,	[sp, #812]

    cset	w18,	lt
    fcsel	s0,	s11,	s15,	lt
    bl	my_sin_impl
    ldr	s14,	[sp, #916]

    fmul	s16,	s14,	s0
    str	s16,	[sp, #912]

    ldr	w5,	[sp, #932]

    ldr	s15,	[sp, #884]

    scvtf	s31,	w5
    ldr	w1,	[sp, #960]

    fmul	s4,	s15,	s31
    ldr	w18,	[sp, #1016]

    fmov	s28,	w1
    fmov	s3,	w18
    fadd	s6,	s4,	s28
    fcmp	s6,	s3
    bgt	main_236

main_232:
    ldr	w20,	[sp, #792]

    fmov	s13,	w20
    fcmp	s6,	s13
    bge	main_243

main_236:
    ldr	w19,	[sp, #1016]

    ldr	w20,	[sp, #1016]

    fmov	s14,	w19
    fmov	s13,	w20
    fdiv	s7,	s6,	s14
    frintz	s5,	s7
    fcvtzs	w17,	s7
    fmul	s9,	s5,	s13
    fsub	s6,	s6,	s9

main_243:
    ldr	w18,	[sp, #1016]

    ldr	w21,	[sp, #1004]

    fmov	s11,	w18
    fmov	s9,	w21
    fsub	s14,	s6,	s11
    str	s9,	[sp, #840]

    ldr	s11,	[sp, #840]

    fcmp	s6,	s11
    cset	w18,	gt
    fcsel	s12,	s14,	s6,	gt
    str	s12,	[sp, #820]

    ldr	w20,	[sp, #1016]

    ldr	s13,	[sp, #820]

    fmov	s9,	w20
    ldr	w26,	[sp, #964]

    fadd	s11,	s13,	s9
    fmov	s9,	w26
    str	s9,	[sp, #816]

    ldr	s9,	[sp, #816]

    ldr	s13,	[sp, #820]

    fcmp	s13,	s9
    ldr	s15,	[sp, #820]

    cset	w21,	lt
    fcsel	s0,	s11,	s15,	lt
    bl	my_sin_impl
    movz	fp,	#980
    ldr	s17,	[sp, #912]

    ldr	s10,	[sp, #880]

    fmul	s5,	s17,	s0
    ldr	x23,	[sp, fp]

    fadd	s24,	s10,	s5
    str	s24,	[x23]

    ldr	w6,	[sp, #932]

    ldr	w11,	[sp, #1008]

    add	w7,	w6,	#1
    cmp	w7,	w11
    blt	main_210

main_258:
    ldr	w1,	[sp, #968]

    ldr	w0,	[sp, #1012]

    add	w1,	w1,	#1
    cmp	w1,	w0
    blt	main_196

main_263:
    movz	fp,	#980
    fmov	s31,	#2.000000
    fmov	s30,	#2.000000
    ldr	x28,	[sp, fp]

    movz	fp,	#980
    ldr	s27,	[x28]

    ldr	s17,	[sp, #848]

    fmul	s6,	s27,	s31
    ldr	s21,	[sp, #852]

    fdiv	s29,	s6,	s17
    ldr	x0,	[sp, fp]

    fmul	s6,	s29,	s30
    fdiv	s4,	s6,	s21
    str	s4,	[x0]

    ldr	w23,	[sp, #936]

    ldr	w6,	[sp, #1008]

    add	w26,	w23,	#1
    cmp	w26,	w6
    blt	main_164

main_273:
    ldr	w19,	[sp, #1336]

    ldr	w25,	[sp, #1012]

    add	w16,	w19,	#1
    cmp	w16,	w25
    blt	main_155

main_278:
    movz	w15,	#0
    ldr	w13,	[sp, #1012]

    cmp	w15,	w13
    bge	main_299

main_280:
    movz	w20,	#0

main_282:
    lsl	w28,	w20,	#5
    add	x25,	x27,	x28
    ldr	s0,	[x25]

    bl	putfloat
    movz	w24,	#1

main_287:
    ldr	w7,	[sp, #1008]

    cmp	w24,	w7
    blt	main_290

main_294:
    movz	w0,	#10
    bl	putch
    ldr	w14,	[sp, #1012]

    add	w20,	w20,	#1
    cmp	w20,	w14
    blt	main_282
    b	main_299

main_290:
    movz	w0,	#32
    bl	putch
    lsl	w18,	w24,	#2
    add	x23,	x25,	x18
    ldr	s0,	[x23]

    bl	putfloat
    add	w24,	w24,	#1
    b	main_287

main_299:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1792
    ret


main_155:
    str	w16,	[sp, #1336]

    b	main_156

main_164:
    str	w26,	[sp, #936]

    b	main_165

main_196:
    str	w1,	[sp, #968]

    b	main_197

main_210:
    str	w7,	[sp, #932]

    b	main_211

main_183:
    movz	fp,	#980
    lsl	w14,	w0,	#2
    fmov	s7,	#0.500000
    add	w0,	w0,	#1
    ldr	x3,	[sp, fp]

    movz	fp,	#980
    ldr	s29,	[x3]

    ldr	x28,	[sp, #992]

    add	x13,	x28,	x14
    ldr	s28,	[x13]

    ldr	x2,	[sp, fp]

    fmul	s30,	s7,	s28
    fadd	s31,	s29,	s30
    str	s31,	[x2]

    b	main_180

main_171:
    movz	fp,	#980
    lsl	w6,	w14,	#5
    fmov	s10,	#0.500000
    add	w14,	w14,	#1
    ldr	x1,	[sp, fp]

    movz	fp,	#980
    ldr	s14,	[x1]

    ldr	x16,	[sp, #784]

    add	x26,	x16,	x6
    ldr	s5,	[x26]

    ldr	x2,	[sp, fp]

    fmul	s6,	s10,	s5
    fadd	s7,	s14,	s6
    str	s7,	[x2]

    b	main_168

main_34:
    str	w8,	[sp, #988]

    b	main_35

main_41:
    str	w17,	[sp, #928]

    b	main_42

