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
    movz	w2,	#256
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    str	w0,	[sp, #1000]

    bl	getint
    movz	w22,	#0
    str	w0,	[sp, #996]

    ldr	w8,	[sp, #1000]

    cmp	w22,	w8
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
    add	x27,	x27,	#16

main_12:
    ldr	w9,	[sp, #996]

    cmp	w26,	w9
    blt	main_15

main_19:
    add	w2,	w19,	#1
    ldr	w11,	[sp, #1000]

    cmp	w2,	w11
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
    add	x6,	sp,	#528
    add	x3,	sp,	#528
    add	x26,	sp,	#16
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
    str	x3,	[sp, #960]

    movk	w6,	#49225,	lsl #16
    str	x26,	[sp, #1336]

    str	w6,	[sp, #788]

    str	w0,	[sp, #992]

    str	w23,	[sp, #784]

    str	w7,	[sp, #1004]

    str	w16,	[sp, #944]

    ldr	w0,	[sp, #1000]

    cmp	w2,	w0
    bge	main_121

main_29:
    ldr	w11,	[sp, #1000]

    movz	w2,	#0
    scvtf	s17,	w11
    ldr	w11,	[sp, #992]

    fmov	s12,	w11
    fdiv	s3,	s12,	s17
    str	s3,	[sp, #904]

    ldr	w23,	[sp, #996]

    ldr	w12,	[sp, #992]

    scvtf	s17,	w23
    str	w2,	[sp, #976]

    fmov	s12,	w12
    fdiv	s8,	s12,	s17

main_35:
    movz	w5,	#0
    ldr	w13,	[sp, #996]

    cmp	w5,	w13
    bge	main_116

main_38:
    ldr	w9,	[sp, #976]

    ldr	x2,	[sp, #960]

    lsl	w18,	w9,	#5
    add	x2,	x2,	x18
    str	x2,	[sp, #1016]

    ldr	w10,	[sp, #976]

    scvtf	s29,	w10
    movz	w10,	#0
    str	s29,	[sp, #900]

    str	w10,	[sp, #924]


main_42:
    ldr	w21,	[sp, #924]

    movz	fp,	#980
    movi	v27.4s,	#0
    movz	w18,	#0
    ldr	x4,	[sp, #1016]

    lsl	w0,	w21,	#2
    add	x5,	x4,	x0
    str	x5,	[sp, fp]

    movz	fp,	#980
    ldr	x6,	[sp, fp]

    str	s27,	[x6]

    ldr	w22,	[sp, #924]

    str	w18,	[sp, #1332]

    scvtf	s13,	w22

main_47:
    ldr	w21,	[sp, #1332]

    movz	fp,	#1212
    fmov	s3,	#0.500000
    movz	w12,	#0
    ldr	x28,	[sp, #1336]

    lsl	w3,	w21,	#5
    add	x13,	x28,	x3
    str	x13,	[sp, fp]

    ldr	w22,	[sp, #1332]

    ldr	s5,	[sp, #904]

    scvtf	s29,	w22
    ldr	s2,	[sp, #900]

    fadd	s7,	s29,	s3
    ldr	w14,	[sp, #784]

    fmul	s9,	s5,	s7
    fmov	s23,	w14
    fmul	s6,	s9,	s2
    fadd	s30,	s6,	s23
    str	s30,	[sp, #852]

    ldr	w15,	[sp, #1004]

    ldr	s7,	[sp, #852]

    fmov	s21,	w15
    ldr	w16,	[sp, #1004]

    fdiv	s2,	s7,	s21
    ldr	s10,	[sp, #852]

    fmov	s26,	w16
    frintz	s4,	s2
    fcvtzs	w2,	s2
    fmul	s5,	s4,	s26
    fsub	s6,	s10,	s5
    str	s6,	[sp, #828]

    str	w12,	[sp, #988]


main_61:
    movz	fp,	#980
    ldr	x19,	[sp, fp]

    movz	fp,	#1212
    ldr	s12,	[x19]

    str	s12,	[sp, #908]

    ldr	w23,	[sp, #988]

    ldr	x22,	[sp, fp]

    lsl	w18,	w23,	#2
    add	x18,	x22,	x18
    ldr	s12,	[x18]

    str	s12,	[sp, #920]

    ldr	w19,	[sp, #944]

    ldr	s12,	[sp, #852]

    fmov	s11,	w19
    fcmp	s12,	s11
    cset	w18,	lt
    ldr	s9,	[sp, #828]

    ldr	s15,	[sp, #852]

    ldr	w18,	[sp, #1004]

    fcsel	s9,	s9,	s15,	lt
    ldr	s11,	[sp, #852]

    fmov	s10,	w18
    fcmp	s11,	s10
    cset	w18,	gt
    ldr	s11,	[sp, #828]

    ldr	w19,	[sp, #1004]

    fcsel	s15,	s11,	s9,	gt
    ldr	w27,	[sp, #992]

    fmov	s11,	w19
    fmov	s9,	w27
    fsub	s12,	s15,	s11
    str	s9,	[sp, #820]

    ldr	s14,	[sp, #820]

    fcmp	s15,	s14
    ldr	w21,	[sp, #1004]

    fcsel	s14,	s12,	s15,	gt
    cset	w18,	gt
    ldr	w27,	[sp, #788]

    fmov	s12,	w21
    fmov	s9,	w27
    fadd	s12,	s14,	s12
    str	s9,	[sp, #824]

    ldr	s15,	[sp, #824]

    fcmp	s14,	s15
    fcsel	s0,	s12,	s14,	lt
    cset	w18,	lt
    bl	my_sin_impl
    fmov	s5,	#0.500000
    ldr	s16,	[sp, #920]

    fmul	s11,	s16,	s0
    str	s11,	[sp, #912]

    ldr	w12,	[sp, #988]

    ldr	w26,	[sp, #784]

    scvtf	s11,	w12
    ldr	w3,	[sp, #1004]

    fmov	s30,	w26
    fadd	s25,	s11,	s5
    fmov	s29,	w3
    fmul	s26,	s8,	s25
    fmul	s27,	s26,	s13
    fadd	s19,	s27,	s30
    fcmp	s19,	s29
    bgt	main_88

main_84:
    ldr	w16,	[sp, #944]

    fmov	s9,	w16
    fcmp	s19,	s9
    bge	main_95

main_88:
    ldr	w4,	[sp, #1004]

    ldr	w5,	[sp, #1004]

    fmov	s7,	w4
    fmov	s1,	w5
    fdiv	s20,	s19,	s7
    frintz	s25,	s20
    fcvtzs	w1,	s20
    fmul	s26,	s25,	s1
    fsub	s19,	s19,	s26

main_95:
    ldr	w18,	[sp, #1004]

    fmov	s11,	w18
    ldr	w18,	[sp, #992]

    fsub	s12,	s19,	s11
    fmov	s10,	w18
    fcmp	s19,	s10
    ldr	w19,	[sp, #1004]

    fcsel	s14,	s12,	s19,	gt
    cset	w18,	gt
    fmov	s10,	w19
    ldr	w18,	[sp, #788]

    fadd	s12,	s14,	s10
    fmov	s15,	w18
    str	s15,	[sp, #816]

    ldr	s9,	[sp, #816]

    fcmp	s14,	s9
    fcsel	s0,	s12,	s14,	lt
    cset	w18,	lt
    bl	my_sin_impl
    movz	fp,	#980
    ldr	s12,	[sp, #912]

    ldr	s9,	[sp, #908]

    fmul	s14,	s12,	s0
    ldr	x8,	[sp, fp]

    fadd	s12,	s9,	s14
    str	s12,	[x8]

    ldr	w13,	[sp, #988]

    ldr	w24,	[sp, #996]

    add	w16,	w13,	#1
    cmp	w16,	w24
    bge	main_108

main_60:
    str	w16,	[sp, #988]

    b	main_61

main_108:
    ldr	w23,	[sp, #1332]

    ldr	w3,	[sp, #1000]

    add	w0,	w23,	#1
    cmp	w0,	w3
    bge	main_111

main_46:
    str	w0,	[sp, #1332]

    b	main_47

main_111:
    ldr	w23,	[sp, #924]

    ldr	w13,	[sp, #996]

    add	w14,	w23,	#1
    cmp	w14,	w13
    blt	main_41

main_116:
    ldr	w11,	[sp, #976]

    ldr	w2,	[sp, #1000]

    add	w6,	w11,	#1
    cmp	w6,	w2
    blt	main_34

main_121:
    movz	w2,	#0
    ldr	w16,	[sp, #1000]

    cmp	w2,	w16
    bge	main_142

main_123:
    movz	w28,	#0
    mov	w22,	w28

main_125:
    lsl	w24,	w22,	#5
    ldr	x23,	[sp, #928]

    add	x21,	x23,	x24
    mov	x18,	x21
    ldr	s0,	[x18]

    bl	putfloat
    movz	w28,	#1
    str	w28,	[sp, #1308]


main_130:
    ldr	w3,	[sp, #996]

    ldr	w2,	[sp, #1308]

    cmp	w2,	w3
    blt	main_133

main_137:
    movz	w0,	#10
    bl	putch
    ldr	w17,	[sp, #1000]

    add	w3,	w22,	#1
    cmp	w3,	w17
    bge	main_142

main_124:
    mov	w22,	w3
    b	main_125

main_133:
    movz	w0,	#32
    bl	putch
    ldr	w23,	[sp, #1308]

    lsl	w18,	w23,	#2
    add	x26,	x21,	x18
    ldr	s0,	[x26]

    bl	putfloat
    ldr	w4,	[sp, #1308]

    add	w2,	w4,	#1
    str	w2,	[sp, #1308]

    b	main_130

main_142:
    movz	w0,	#10
    bl	putch
    add	x28,	sp,	#272
    movz	fp,	#1292
    movz	w14,	#0
    add	x6,	sp,	#272
    str	x6,	[sp, fp]

    str	x28,	[sp, #1008]

    ldr	w18,	[sp, #1000]

    cmp	w14,	w18
    bge	main_278

main_146:
    ldr	x16,	[sp, #960]

    movz	fp,	#1324
    fmov	s27,	#0.250000
    movz	w13,	#0
    str	x16,	[sp, fp]

    movz	fp,	#1324
    ldr	x4,	[sp, fp]

    ldr	s24,	[x4]

    fmul	s22,	s27,	s24
    str	s22,	[sp, #876]

    ldr	w17,	[sp, #1000]

    scvtf	s15,	w17
    str	s15,	[sp, #840]

    ldr	w15,	[sp, #992]

    ldr	s13,	[sp, #840]

    fmov	s26,	w15
    fdiv	s16,	s26,	s13
    str	s16,	[sp, #868]

    ldr	w0,	[sp, #996]

    scvtf	s19,	w0
    str	s19,	[sp, #844]

    ldr	w16,	[sp, #992]

    ldr	s17,	[sp, #844]

    fmov	s25,	w16
    fdiv	s25,	s25,	s17
    str	s25,	[sp, #892]

    str	w13,	[sp, #1344]


main_156:
    movz	w6,	#0
    ldr	w1,	[sp, #996]

    cmp	w6,	w1
    bge	main_273

main_159:
    ldr	w1,	[sp, #1344]

    movz	fp,	#1300
    fmov	s29,	#0.500000
    movz	w14,	#0
    ldr	x0,	[sp, #1008]

    lsl	w15,	w1,	#5
    add	x19,	x0,	x15
    str	x19,	[sp, fp]

    ldr	w2,	[sp, #1344]

    ldr	s17,	[sp, #868]

    scvtf	s4,	w2
    fadd	s19,	s4,	s29
    fmul	s19,	s17,	s19
    str	s19,	[sp, #872]

    str	w14,	[sp, #940]


main_165:
    ldr	w12,	[sp, #940]

    movz	fp,	#1300
    movz	w14,	#1
    lsl	w3,	w12,	#2
    ldr	x20,	[sp, fp]

    add	x11,	x20,	x3
    str	x11,	[sp, #968]

    ldr	s23,	[sp, #876]

    ldr	x12,	[sp, #968]

    str	s23,	[x12]


main_168:
    ldr	w18,	[sp, #1000]

    cmp	w14,	w18
    blt	main_171

main_179:
    movz	w0,	#1

main_180:
    ldr	w3,	[sp, #996]

    cmp	w0,	w3
    blt	main_183

main_190:
    movz	w2,	#1
    ldr	w19,	[sp, #1000]

    cmp	w2,	w19
    bge	main_263

main_192:
    ldr	w13,	[sp, #940]

    fmov	s2,	#0.500000
    movz	w27,	#1
    ldr	s26,	[sp, #892]

    scvtf	s12,	w13
    fadd	s27,	s12,	s2
    fmul	s11,	s26,	s27
    str	s11,	[sp, #888]

    str	w27,	[sp, #936]


main_197:
    movz	w4,	#1
    ldr	w0,	[sp, #996]

    cmp	w4,	w0
    bge	main_258

main_200:
    ldr	w18,	[sp, #936]

    movz	fp,	#1220
    movz	w1,	#1
    ldr	x4,	[sp, #960]

    lsl	w14,	w18,	#5
    add	x16,	x4,	x14
    str	x16,	[sp, fp]

    ldr	w0,	[sp, #936]

    ldr	s20,	[sp, #872]

    scvtf	s1,	w0
    ldr	w28,	[sp, #784]

    fmul	s31,	s20,	s1
    fmov	s29,	w28
    fadd	s3,	s31,	s29
    str	s3,	[sp, #856]

    ldr	w8,	[sp, #1004]

    ldr	s3,	[sp, #856]

    fmov	s30,	w8
    ldr	w9,	[sp, #1004]

    fdiv	s22,	s3,	s30
    ldr	s4,	[sp, #856]

    fmov	s28,	w9
    frintz	s24,	s22
    fcvtzs	w14,	s22
    fmul	s25,	s24,	s28
    fsub	s23,	s4,	s25
    str	s23,	[sp, #848]

    str	w1,	[sp, #948]


main_211:
    ldr	x23,	[sp, #968]

    movz	fp,	#1220
    ldr	s14,	[x23]

    str	s14,	[sp, #884]

    ldr	w23,	[sp, #948]

    ldr	x22,	[sp, fp]

    lsl	w18,	w23,	#2
    add	x18,	x22,	x18
    ldr	s10,	[x18]

    str	s10,	[sp, #896]

    ldr	w23,	[sp, #944]

    ldr	s9,	[sp, #856]

    fmov	s11,	w23
    fcmp	s9,	s11
    cset	w18,	lt
    ldr	s12,	[sp, #848]

    ldr	s11,	[sp, #856]

    ldr	w21,	[sp, #1004]

    fcsel	s9,	s12,	s11,	lt
    fmov	s14,	w21
    str	s14,	[sp, #836]

    ldr	s10,	[sp, #836]

    ldr	s13,	[sp, #856]

    fcmp	s13,	s10
    cset	w18,	gt
    ldr	s13,	[sp, #848]

    fcsel	s12,	s13,	s9,	gt
    str	s12,	[sp, #796]

    ldr	w23,	[sp, #1004]

    ldr	s13,	[sp, #796]

    fmov	s10,	w23
    ldr	w19,	[sp, #992]

    fsub	s9,	s13,	s10
    fmov	s15,	w19
    str	s15,	[sp, #792]

    ldr	s10,	[sp, #792]

    ldr	s14,	[sp, #796]

    fcmp	s14,	s10
    cset	w18,	gt
    ldr	s14,	[sp, #796]

    fcsel	s12,	s9,	s14,	gt
    str	s12,	[sp, #804]

    ldr	w27,	[sp, #1004]

    ldr	s14,	[sp, #804]

    fmov	s8,	w27
    ldr	w19,	[sp, #788]

    fadd	s8,	s14,	s8
    fmov	s9,	w19
    str	s9,	[sp, #800]

    ldr	s10,	[sp, #800]

    ldr	s14,	[sp, #804]

    fcmp	s14,	s10
    ldr	s15,	[sp, #804]

    cset	w18,	lt
    fcsel	s0,	s8,	s15,	lt
    bl	my_sin_impl
    ldr	s29,	[sp, #896]

    ldr	w4,	[sp, #948]

    fmul	s11,	s29,	s0
    ldr	s12,	[sp, #888]

    scvtf	s6,	w4
    ldr	w0,	[sp, #784]

    fmul	s7,	s12,	s6
    ldr	w13,	[sp, #1004]

    fmov	s14,	w0
    fmov	s10,	w13
    fadd	s24,	s7,	s14
    fcmp	s24,	s10
    bgt	main_236

main_232:
    ldr	w18,	[sp, #944]

    fmov	s26,	w18
    fcmp	s24,	s26
    bge	main_243

main_236:
    ldr	w14,	[sp, #1004]

    ldr	w15,	[sp, #1004]

    fmov	s28,	w14
    fdiv	s10,	s24,	s28
    fmov	s28,	w15
    frintz	s14,	s10
    fcvtzs	w17,	s10
    fmul	s16,	s14,	s28
    fsub	s24,	s24,	s16

main_243:
    ldr	w18,	[sp, #1004]

    ldr	w21,	[sp, #992]

    fmov	s10,	w18
    fmov	s14,	w21
    fsub	s10,	s24,	s10
    str	s14,	[sp, #832]

    ldr	s15,	[sp, #832]

    fcmp	s24,	s15
    cset	w18,	gt
    fcsel	s14,	s10,	s24,	gt
    str	s14,	[sp, #812]

    ldr	w19,	[sp, #1004]

    ldr	s12,	[sp, #812]

    fmov	s13,	w19
    ldr	w18,	[sp, #788]

    fadd	s8,	s12,	s13
    fmov	s15,	w18
    str	s15,	[sp, #808]

    ldr	s10,	[sp, #808]

    ldr	s15,	[sp, #812]

    fcmp	s15,	s10
    ldr	s15,	[sp, #812]

    cset	w18,	lt
    fcsel	s0,	s8,	s15,	lt
    bl	my_sin_impl
    ldr	s9,	[sp, #884]

    fmul	s27,	s11,	s0
    ldr	x21,	[sp, #968]

    fadd	s26,	s9,	s27
    str	s26,	[x21]

    ldr	w5,	[sp, #948]

    ldr	w3,	[sp, #996]

    add	w5,	w5,	#1
    cmp	w5,	w3
    blt	main_210

main_258:
    ldr	w21,	[sp, #936]

    ldr	w19,	[sp, #1000]

    add	w2,	w21,	#1
    cmp	w2,	w19
    blt	main_196

main_263:
    ldr	x15,	[sp, #968]

    fmov	s25,	#2.000000
    fmov	s24,	#2.000000
    ldr	s4,	[x15]

    ldr	s14,	[sp, #840]

    fmul	s16,	s4,	s25
    ldr	s19,	[sp, #844]

    fdiv	s6,	s16,	s14
    ldr	x16,	[sp, #968]

    fmul	s18,	s6,	s24
    fdiv	s19,	s18,	s19
    str	s19,	[x16]

    ldr	w14,	[sp, #940]

    ldr	w2,	[sp, #996]

    add	w18,	w14,	#1
    cmp	w18,	w2
    blt	main_164

main_273:
    ldr	w3,	[sp, #1344]

    ldr	w10,	[sp, #1000]

    add	w17,	w3,	#1
    cmp	w17,	w10
    blt	main_155

main_278:
    movz	w15,	#0
    ldr	w24,	[sp, #1000]

    cmp	w15,	w24
    bge	main_299

main_280:
    movz	w24,	#0

main_282:
    lsl	w21,	w24,	#5
    movz	fp,	#1292
    ldr	x20,	[sp, fp]

    add	x25,	x20,	x21
    ldr	s0,	[x25]

    bl	putfloat
    movz	w19,	#1

main_287:
    ldr	w3,	[sp, #996]

    cmp	w19,	w3
    blt	main_290

main_294:
    movz	w0,	#10
    bl	putch
    ldr	w23,	[sp, #1000]

    add	w24,	w24,	#1
    cmp	w24,	w23
    blt	main_282
    b	main_299

main_290:
    movz	w0,	#32
    bl	putch
    lsl	w21,	w19,	#2
    add	x18,	x25,	x21
    ldr	s0,	[x18]

    bl	putfloat
    add	w19,	w19,	#1
    b	main_287

main_299:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1760
    ret


main_155:
    str	w17,	[sp, #1344]

    b	main_156

main_164:
    str	w18,	[sp, #940]

    b	main_165

main_196:
    str	w2,	[sp, #936]

    b	main_197

main_210:
    str	w5,	[sp, #948]

    b	main_211

main_183:
    ldr	x1,	[sp, #968]

    lsl	w16,	w0,	#2
    movz	fp,	#1324
    fmov	s2,	#0.500000
    ldr	s26,	[x1]

    add	w0,	w0,	#1
    ldr	x8,	[sp, fp]

    add	x13,	x8,	x16
    ldr	s23,	[x13]

    ldr	x2,	[sp, #968]

    fmul	s31,	s2,	s23
    fadd	s10,	s26,	s31
    str	s10,	[x2]

    b	main_180

main_171:
    ldr	x2,	[sp, #968]

    lsl	w4,	w14,	#5
    fmov	s4,	#0.500000
    ldr	s3,	[x2]

    add	w14,	w14,	#1
    ldr	x12,	[sp, #960]

    add	x27,	x12,	x4
    ldr	s2,	[x27]

    ldr	x0,	[sp, #968]

    fmul	s8,	s4,	s2
    fadd	s18,	s3,	s8
    str	s18,	[x0]

    b	main_168

main_34:
    str	w6,	[sp, #976]

    b	main_35

main_41:
    str	w14,	[sp, #924]

    b	main_42

