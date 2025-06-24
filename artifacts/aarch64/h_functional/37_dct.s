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
    sub	sp, sp, #1840
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
    str	w0,	[sp, #1016]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #1012]

    ldr	w9,	[sp, #1016]

    cmp	w22,	w9
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
    ldr	w10,	[sp, #1012]

    cmp	w27,	w10
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
    ldr	w12,	[sp, #1016]

    cmp	w6,	w12
    bge	main_24

main_8:
    mov	w19,	w6
    b	main_9

main_24:
    add	x7,	sp,	#272
    movz	fp,	#980
    add	x4,	sp,	#272
    add	x19,	sp,	#528
    movz	w2,	#0
    movz	w1,	#4059
    movz	w24,	#4059
    movz	w8,	#4059
    movz	w17,	#4059
    str	x7,	[sp, fp]

    movk	w1,	#16457,	lsl #16
    movk	w24,	#16329,	lsl #16
    movk	w8,	#16585,	lsl #16
    movk	w17,	#49353,	lsl #16
    movz	w7,	#4059
    movz	fp,	#988
    movk	w7,	#49225,	lsl #16
    str	x4,	[sp, fp]

    movz	fp,	#1332
    str	x19,	[sp, fp]

    str	w7,	[sp, #1004]

    str	w1,	[sp, #1008]

    str	w24,	[sp, #1000]

    str	w8,	[sp, #1020]

    str	w17,	[sp, #784]

    ldr	w0,	[sp, #1016]

    cmp	w2,	w0
    bge	main_121

main_29:
    ldr	w12,	[sp, #1016]

    movz	w3,	#0
    scvtf	s17,	w12
    ldr	w12,	[sp, #1008]

    ldr	w24,	[sp, #1012]

    fmov	s12,	w12
    ldr	w13,	[sp, #1008]

    scvtf	s2,	w24
    fdiv	s14,	s12,	s17
    fmov	s9,	w13
    fdiv	s26,	s9,	s2
    str	s26,	[sp, #888]

    str	w3,	[sp, #996]


main_35:
    movz	w5,	#0
    ldr	w14,	[sp, #1012]

    cmp	w5,	w14
    bge	main_116

main_38:
    ldr	w10,	[sp, #996]

    movz	fp,	#988
    movz	w11,	#0
    lsl	w18,	w10,	#5
    ldr	x3,	[sp, fp]

    add	x24,	x3,	x18
    str	x24,	[sp, #1032]

    ldr	w27,	[sp, #996]

    str	w11,	[sp, #924]

    scvtf	s13,	w27

main_42:
    ldr	w7,	[sp, #924]

    movi	v29.4s,	#0
    movz	w11,	#0
    ldr	x26,	[sp, #1032]

    lsl	w0,	w7,	#2
    add	x27,	x26,	x0
    str	x27,	[sp, #968]

    ldr	x28,	[sp, #968]

    str	s29,	[x28]

    ldr	w8,	[sp, #924]

    scvtf	s1,	w8
    str	s1,	[sp, #892]

    str	w11,	[sp, #1048]


main_47:
    ldr	w14,	[sp, #1048]

    movz	fp,	#1332
    fmov	s3,	#0.500000
    movz	w5,	#0
    lsl	w4,	w14,	#5
    ldr	x21,	[sp, fp]

    add	x1,	x21,	x4
    str	x1,	[sp, #1352]

    ldr	w15,	[sp, #1048]

    ldr	w26,	[sp, #1000]

    scvtf	s29,	w15
    fmov	s23,	w26
    fadd	s4,	s29,	s3
    fmul	s5,	s14,	s4
    fmul	s6,	s5,	s13
    fadd	s30,	s6,	s23
    str	s30,	[sp, #852]

    ldr	w0,	[sp, #1020]

    ldr	s7,	[sp, #852]

    fmov	s21,	w0
    ldr	w0,	[sp, #1020]

    fdiv	s2,	s7,	s21
    ldr	s9,	[sp, #852]

    fmov	s26,	w0
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s9,	s5
    str	s6,	[sp, #828]

    str	w5,	[sp, #976]


main_61:
    ldr	x23,	[sp, #968]

    ldr	s8,	[x23]

    str	s8,	[sp, #860]

    ldr	w27,	[sp, #976]

    ldr	x25,	[sp, #1352]

    lsl	w26,	w27,	#2
    add	x26,	x25,	x26
    ldr	s8,	[x26]

    str	s8,	[sp, #920]

    ldr	w19,	[sp, #784]

    ldr	s11,	[sp, #852]

    fmov	s10,	w19
    fcmp	s11,	s10
    cset	w18,	lt
    ldr	s8,	[sp, #828]

    ldr	s15,	[sp, #852]

    ldr	w19,	[sp, #1020]

    fcsel	s8,	s8,	s15,	lt
    ldr	s10,	[sp, #852]

    fmov	s9,	w19
    fcmp	s10,	s9
    ldr	s10,	[sp, #828]

    cset	w18,	gt
    ldr	w23,	[sp, #1020]

    fcsel	s15,	s10,	s8,	gt
    ldr	w18,	[sp, #1008]

    fmov	s10,	w23
    fmov	s8,	w18
    fsub	s11,	s15,	s10
    str	s8,	[sp, #820]

    ldr	s12,	[sp, #820]

    fcmp	s15,	s12
    ldr	w26,	[sp, #1020]

    fcsel	s12,	s11,	s15,	gt
    cset	w18,	gt
    ldr	w19,	[sp, #1004]

    fmov	s11,	w26
    fmov	s8,	w19
    fadd	s11,	s12,	s11
    str	s8,	[sp, #824]

    ldr	s15,	[sp, #824]

    fcmp	s12,	s15
    fcsel	s0,	s11,	s12,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	s11,	[sp, #920]

    fmov	s5,	#0.500000
    fmul	s7,	s11,	s0
    str	s7,	[sp, #864]

    ldr	w5,	[sp, #976]

    ldr	s30,	[sp, #888]

    scvtf	s10,	w5
    ldr	s2,	[sp, #892]

    fadd	s26,	s10,	s5
    ldr	w0,	[sp, #1000]

    fmul	s28,	s30,	s26
    ldr	w7,	[sp, #1020]

    fmov	s30,	w0
    fmul	s27,	s28,	s2
    fmov	s29,	w7
    fadd	s19,	s27,	s30
    fcmp	s19,	s29
    bgt	main_88

main_84:
    ldr	w17,	[sp, #784]

    fmov	s8,	w17
    fcmp	s19,	s8
    bge	main_95

main_88:
    ldr	w8,	[sp, #1020]

    ldr	w9,	[sp, #1020]

    fmov	s7,	w8
    fmov	s1,	w9
    fdiv	s20,	s19,	s7
    frintz	s25,	s20
    fcvtzs	w1,	s20
    fmul	s26,	s25,	s1
    fsub	s19,	s19,	s26

main_95:
    ldr	w18,	[sp, #1020]

    ldr	w19,	[sp, #1008]

    fmov	s10,	w18
    fmov	s9,	w19
    fsub	s11,	s19,	s10
    fcmp	s19,	s9
    ldr	w19,	[sp, #1020]

    fcsel	s12,	s11,	s19,	gt
    cset	w18,	gt
    fmov	s9,	w19
    ldr	w18,	[sp, #1004]

    fadd	s11,	s12,	s9
    fmov	s15,	w18
    str	s15,	[sp, #816]

    ldr	s8,	[sp, #816]

    fcmp	s12,	s8
    fcsel	s0,	s11,	s12,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	s8,	[sp, #864]

    ldr	s5,	[sp, #860]

    fmul	s12,	s8,	s0
    ldr	x1,	[sp, #968]

    fadd	s11,	s5,	s12
    str	s11,	[x1]

    ldr	w6,	[sp, #976]

    ldr	w28,	[sp, #1012]

    add	w9,	w6,	#1
    cmp	w9,	w28
    blt	main_60

main_108:
    ldr	w16,	[sp, #1048]

    ldr	w11,	[sp, #1016]

    add	w15,	w16,	#1
    cmp	w15,	w11
    blt	main_46

main_111:
    ldr	w9,	[sp, #924]

    ldr	w26,	[sp, #1012]

    add	w15,	w9,	#1
    cmp	w15,	w26
    bge	main_116

main_41:
    str	w15,	[sp, #924]

    b	main_42

main_46:
    str	w15,	[sp, #1048]

    b	main_47

main_60:
    str	w9,	[sp, #976]

    b	main_61

main_116:
    ldr	w12,	[sp, #996]

    ldr	w3,	[sp, #1016]

    add	w7,	w12,	#1
    cmp	w7,	w3
    bge	main_121

main_34:
    str	w7,	[sp, #996]

    b	main_35

main_121:
    movz	w2,	#0
    ldr	w17,	[sp, #1016]

    cmp	w2,	w17
    bge	main_142

main_123:
    movz	w28,	#0
    mov	w27,	w28

main_125:
    lsl	w22,	w27,	#5
    movz	fp,	#980
    ldr	x25,	[sp, fp]

    add	x22,	x25,	x22
    mov	x18,	x22
    ldr	s0,	[x18]

    bl	putfloat
    movz	w8,	#1
    mov	w21,	w8

main_130:
    ldr	w0,	[sp, #1012]

    cmp	w21,	w0
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
    ldr	w18,	[sp, #1016]

    add	w3,	w27,	#1
    cmp	w3,	w18
    bge	main_142

main_124:
    mov	w27,	w3
    b	main_125

main_142:
    movz	w0,	#10
    bl	putch
    movz	w14,	#0
    movz	fp,	#1236
    add	x21,	sp,	#16
    add	x9,	sp,	#16
    str	x9,	[sp, fp]

    str	x21,	[sp, #1024]

    ldr	w19,	[sp, #1016]

    cmp	w14,	w19
    bge	main_278

main_146:
    movz	fp,	#988
    fmov	s27,	#0.250000
    movz	w6,	#0
    ldr	x9,	[sp, fp]

    str	x9,	[sp, #1040]

    ldr	x4,	[sp, #1040]

    ldr	s24,	[x4]

    fmul	s19,	s27,	s24
    str	s19,	[sp, #904]

    ldr	w18,	[sp, #1016]

    scvtf	s15,	w18
    str	s15,	[sp, #840]

    ldr	w0,	[sp, #1012]

    scvtf	s19,	w0
    str	s19,	[sp, #844]

    ldr	w16,	[sp, #1008]

    ldr	s13,	[sp, #840]

    fmov	s26,	w16
    fdiv	s25,	s26,	s13
    str	s25,	[sp, #884]

    ldr	w17,	[sp, #1008]

    ldr	s17,	[sp, #844]

    fmov	s25,	w17
    fdiv	s16,	s25,	s17
    str	s16,	[sp, #900]

    str	w6,	[sp, #1340]


main_156:
    movz	w6,	#0
    ldr	w2,	[sp, #1012]

    cmp	w6,	w2
    bge	main_273

main_159:
    ldr	w23,	[sp, #1340]

    fmov	s29,	#0.500000
    movz	w15,	#0
    ldr	x22,	[sp, #1024]

    lsl	w13,	w23,	#5
    add	x18,	x22,	x13
    str	x18,	[sp, #1152]

    ldr	w24,	[sp, #1340]

    ldr	s26,	[sp, #884]

    scvtf	s4,	w24
    fadd	s18,	s4,	s29
    fmul	s22,	s26,	s18
    str	s22,	[sp, #880]

    str	w15,	[sp, #948]


main_165:
    ldr	w13,	[sp, #948]

    movz	w16,	#1
    ldr	x19,	[sp, #1152]

    lsl	w3,	w13,	#2
    mov	w17,	w16
    add	x12,	x19,	x3
    str	x12,	[sp, #960]

    ldr	s20,	[sp, #904]

    ldr	x13,	[sp, #960]

    str	s20,	[x13]


main_168:
    ldr	w19,	[sp, #1016]

    cmp	w17,	w19
    bge	main_179

main_171:
    ldr	x23,	[sp, #960]

    lsl	w4,	w17,	#5
    movz	fp,	#988
    fmov	s1,	#0.500000
    add	w16,	w17,	#1
    ldr	s10,	[x23]

    mov	w17,	w16
    ldr	x12,	[sp, fp]

    add	x8,	x12,	x4
    ldr	s6,	[x8]

    ldr	x25,	[sp, #960]

    fmul	s16,	s1,	s6
    fadd	s28,	s10,	s16
    str	s28,	[x25]

    b	main_168

main_179:
    movz	w0,	#1

main_180:
    ldr	w2,	[sp, #1012]

    cmp	w0,	w2
    bge	main_190

main_183:
    ldr	x28,	[sp, #960]

    lsl	w17,	w0,	#2
    fmov	s3,	#0.500000
    ldr	s20,	[x28]

    add	w0,	w0,	#1
    ldr	x1,	[sp, #1040]

    add	x15,	x1,	x17
    ldr	s15,	[x15]

    ldr	x1,	[sp, #960]

    fmul	s24,	s3,	s15
    fadd	s5,	s20,	s24
    str	s5,	[x1]

    b	main_180

main_190:
    movz	w6,	#1
    ldr	w20,	[sp, #1016]

    cmp	w6,	w20
    bge	main_263

main_192:
    ldr	w14,	[sp, #948]

    fmov	s6,	#0.500000
    movz	w28,	#1
    ldr	s17,	[sp, #900]

    scvtf	s28,	w14
    fadd	s10,	s28,	s6
    fmul	s13,	s17,	s10
    str	s13,	[sp, #896]

    str	w28,	[sp, #928]


main_197:
    movz	w8,	#1
    ldr	w1,	[sp, #1012]

    cmp	w8,	w1
    bge	main_258

main_200:
    ldr	w19,	[sp, #928]

    movz	fp,	#988
    movz	w2,	#1
    lsl	w3,	w19,	#5
    ldr	x6,	[sp, fp]

    add	x15,	x6,	x3
    str	x15,	[sp, #1144]

    ldr	w1,	[sp, #928]

    ldr	s23,	[sp, #880]

    scvtf	s15,	w1
    ldr	w0,	[sp, #1000]

    fmul	s15,	s23,	s15
    fmov	s4,	w0
    fadd	s3,	s15,	s4
    str	s3,	[sp, #856]

    ldr	w9,	[sp, #1020]

    ldr	s2,	[sp, #856]

    fmov	s3,	w9
    ldr	w10,	[sp, #1020]

    fdiv	s5,	s2,	s3
    ldr	s4,	[sp, #856]

    fmov	s1,	w10
    frintz	s7,	s5
    fcvtzs	w6,	s5
    fmul	s8,	s7,	s1
    fsub	s23,	s4,	s8
    str	s23,	[sp, #848]

    str	w2,	[sp, #932]


main_211:
    ldr	x18,	[sp, #960]

    ldr	s8,	[x18]

    str	s8,	[sp, #868]

    ldr	w25,	[sp, #932]

    ldr	x21,	[sp, #1144]

    lsl	w18,	w25,	#2
    add	x18,	x21,	x18
    ldr	s11,	[x18]

    str	s11,	[sp, #912]

    ldr	w25,	[sp, #784]

    ldr	s14,	[sp, #856]

    fmov	s11,	w25
    fcmp	s14,	s11
    cset	w18,	lt
    ldr	s13,	[sp, #848]

    ldr	s12,	[sp, #856]

    ldr	w24,	[sp, #1020]

    fcsel	s9,	s13,	s12,	lt
    fmov	s13,	w24
    str	s13,	[sp, #836]

    ldr	s8,	[sp, #836]

    ldr	s10,	[sp, #856]

    fcmp	s10,	s8
    cset	w18,	gt
    ldr	s14,	[sp, #848]

    fcsel	s12,	s14,	s9,	gt
    str	s12,	[sp, #792]

    ldr	w25,	[sp, #1020]

    ldr	s13,	[sp, #792]

    fmov	s8,	w25
    ldr	w22,	[sp, #1008]

    fsub	s15,	s13,	s8
    fmov	s8,	w22
    str	s8,	[sp, #796]

    ldr	s10,	[sp, #796]

    ldr	s14,	[sp, #792]

    fcmp	s14,	s10
    cset	w18,	gt
    ldr	s8,	[sp, #792]

    fcsel	s13,	s15,	s8,	gt
    str	s13,	[sp, #804]

    ldr	w28,	[sp, #1020]

    ldr	s8,	[sp, #804]

    fmov	s14,	w28
    ldr	w18,	[sp, #1004]

    fadd	s12,	s8,	s14
    fmov	s9,	w18
    str	s9,	[sp, #800]

    ldr	s11,	[sp, #800]

    ldr	s8,	[sp, #804]

    fcmp	s8,	s11
    ldr	s9,	[sp, #804]

    cset	w18,	lt
    fcsel	s0,	s12,	s9,	lt
    bl	my_sin_impl
    ldr	s15,	[sp, #912]

    ldr	w5,	[sp, #932]

    fmul	s12,	s15,	s0
    ldr	s14,	[sp, #896]

    scvtf	s24,	w5
    ldr	w1,	[sp, #1000]

    fmul	s23,	s14,	s24
    ldr	w14,	[sp, #1020]

    fmov	s16,	w1
    fmov	s15,	w14
    fadd	s24,	s23,	s16
    fcmp	s24,	s15
    bgt	main_236

main_232:
    ldr	w19,	[sp, #784]

    fmov	s28,	w19
    fcmp	s24,	s28
    bge	main_243

main_236:
    ldr	w15,	[sp, #1020]

    ldr	w16,	[sp, #1020]

    fmov	s31,	w15
    fmov	s29,	w16
    fdiv	s31,	s24,	s31
    frintz	s2,	s31
    fcvtzs	w9,	s31
    fmul	s3,	s2,	s29
    fsub	s24,	s24,	s3

main_243:
    ldr	w19,	[sp, #1020]

    ldr	w24,	[sp, #1008]

    fmov	s15,	w19
    fmov	s14,	w24
    fsub	s8,	s24,	s15
    str	s14,	[sp, #832]

    ldr	s15,	[sp, #832]

    fcmp	s24,	s15
    cset	w18,	gt
    fcsel	s14,	s8,	s24,	gt
    str	s14,	[sp, #812]

    ldr	w22,	[sp, #1020]

    ldr	s13,	[sp, #812]

    fmov	s11,	w22
    ldr	w19,	[sp, #1004]

    fadd	s13,	s13,	s11
    fmov	s15,	w19
    str	s15,	[sp, #808]

    ldr	s10,	[sp, #808]

    ldr	s15,	[sp, #812]

    fcmp	s15,	s10
    ldr	s15,	[sp, #812]

    cset	w18,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    ldr	s11,	[sp, #868]

    fmul	s7,	s12,	s0
    ldr	x1,	[sp, #960]

    fadd	s7,	s11,	s7
    str	s7,	[x1]

    ldr	w6,	[sp, #932]

    ldr	w4,	[sp, #1012]

    add	w6,	w6,	#1
    cmp	w6,	w4
    bge	main_258

main_210:
    str	w6,	[sp, #932]

    b	main_211

main_258:
    ldr	w22,	[sp, #928]

    ldr	w21,	[sp, #1016]

    add	w0,	w22,	#1
    cmp	w0,	w21
    bge	main_263

main_196:
    str	w0,	[sp, #928]

    b	main_197

main_263:
    ldr	x20,	[sp, #960]

    fmov	s29,	#2.000000
    fmov	s28,	#2.000000
    ldr	s19,	[x20]

    ldr	s14,	[sp, #840]

    fmul	s31,	s19,	s29
    ldr	s19,	[sp, #844]

    fdiv	s21,	s31,	s14
    ldr	x22,	[sp, #960]

    fmul	s2,	s21,	s28
    fdiv	s3,	s2,	s19
    str	s3,	[x22]

    ldr	w15,	[sp, #948]

    ldr	w3,	[sp, #1012]

    add	w22,	w15,	#1
    cmp	w22,	w3
    bge	main_273

main_164:
    str	w22,	[sp, #948]

    b	main_165

main_273:
    ldr	w25,	[sp, #1340]

    ldr	w13,	[sp, #1016]

    add	w10,	w25,	#1
    cmp	w10,	w13
    bge	main_278

main_155:
    str	w10,	[sp, #1340]

    b	main_156

main_278:
    movz	w20,	#0
    ldr	w25,	[sp, #1016]

    cmp	w20,	w25
    bge	main_299

main_280:
    movz	w25,	#0

main_282:
    lsl	w28,	w25,	#5
    movz	fp,	#1236
    ldr	x24,	[sp, fp]

    add	x26,	x24,	x28
    ldr	s0,	[x26]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w4,	[sp, #1012]

    cmp	w19,	w4
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
    ldr	w24,	[sp, #1016]

    add	w25,	w25,	#1
    cmp	w25,	w24
    blt	main_282

main_299:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1840
    ret


