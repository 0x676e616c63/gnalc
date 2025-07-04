.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global input
.align	2
input:
.type input, %object
    .zero	4000000

.global conv_output
.align	2
conv_output:
.type conv_output, %object
    .zero	4000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#40512
    movk	fp,	#3,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#39588
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#3,	lsl #16
    bl	memset
    movz	w2,	#900
    movz	w1,	#0
    movz	fp,	#39604
    movk	fp,	#3,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    adrp	x0, :got:input
    ldr	x0, [x0, #:got_lo12:input]
    bl	getfarray
    movz	fp,	#39604
    movk	fp,	#3,	lsl #16
    add	x0,	sp,	fp
    bl	getfarray
    movz	w0,	#106
    bl	_sysy_starttime
    movz	w6,	#0
    movz	fp,	#39604
    add	x27,	sp,	#16
    adrp	x23, :got:conv_output
    adrp	x20, :got:input
    movk	fp,	#3,	lsl #16
    ldr	x20, [x20, #:got_lo12:input]
    add	x8,	sp,	fp
    ldr	x23, [x23, #:got_lo12:conv_output]

main_12:
    movz	w7,	#4000
    movz	w4,	#0
    madd	x5,	x6,	x7,	x23


main_16:
    movz	w10,	#0
    movi	v14.4s,	#0

main_19:
    add	w16,	w10,	w6
    movz	w28,	#4000
    lsl	w13,	w4,	#2
    add	w21,	w4,	#1
    add	w3,	w4,	#2
    add	w0,	w4,	#4
    madd	x17,	x16,	x28,	x20

    lsl	w24,	w21,	#2
    lsl	w16,	w10,	#6
    lsl	w9,	w3,	#2
    lsl	w2,	w0,	#2
    add	x12,	x17,	x13
    sub	w22,	w16,	w10,	lsl #2
    add	x7,	x17,	x9
    add	x1,	x17,	x2
    add	w13,	w4,	#5
    add	w10,	w10,	#1
    add	w16,	w4,	#3
    add	x28,	x8,	x22
    ldr	s17,	[x12]

    add	w9,	w4,	#7
    add	w2,	w4,	#9
    lsl	w15,	w13,	#2
    lsl	w19,	w16,	#2
    add	x22,	x17,	x24
    add	x26,	x28,	#4
    add	x12,	x28,	#8
    ldr	s1,	[x28]

    add	x14,	x17,	x15
    add	x18,	x17,	x19
    add	w24,	w4,	#6
    ldr	s7,	[x22]

    fmul	s2,	s17,	s1
    add	w15,	w4,	#10
    add	w19,	w4,	#8
    add	x22,	x28,	#12
    ldr	s27,	[x26]

    fadd	s12,	s14,	s2
    lsl	w26,	w24,	#2
    ldr	s16,	[x7]

    fmul	s28,	s7,	s27
    add	x25,	x17,	x26
    add	x7,	x28,	#16
    ldr	s4,	[x12]

    fadd	s22,	s12,	s28
    add	w26,	w4,	#11
    lsl	w12,	w9,	#2
    ldr	s24,	[x18]

    fmul	s5,	s16,	s4
    add	x11,	x17,	x12
    add	x18,	x28,	#20
    ldr	s12,	[x22]

    fadd	s30,	s22,	s5
    add	w12,	w4,	#12
    lsl	w22,	w19,	#2
    ldr	s1,	[x1]

    fmul	s13,	s24,	s12
    add	x21,	x17,	x22
    add	x1,	x28,	#24
    ldr	s20,	[x7]

    fadd	s8,	s30,	s13
    add	w22,	w4,	#13
    lsl	w7,	w2,	#2
    ldr	s9,	[x14]

    fmul	s21,	s1,	s20
    add	x3,	x17,	x7
    add	x14,	x28,	#28
    ldr	s28,	[x18]

    fadd	s16,	s8,	s21
    add	w7,	w4,	#14
    ldr	s18,	[x25]

    lsl	w18,	w15,	#2
    fmul	s29,	s9,	s28
    add	x25,	x28,	#32
    ldr	s5,	[x1]

    add	x16,	x17,	x18
    fadd	s26,	s16,	s29
    lsl	w1,	w26,	#2
    fmul	s6,	s18,	s5
    fadd	s3,	s26,	s6
    add	x0,	x17,	x1
    ldr	s26,	[x11]

    add	x11,	x28,	#36
    ldr	s13,	[x14]

    lsl	w14,	w12,	#2
    fmul	s14,	s26,	s13
    fadd	s12,	s3,	s14
    add	x13,	x17,	x14
    ldr	s3,	[x21]

    add	x21,	x28,	#40
    ldr	s21,	[x25]

    lsl	w25,	w22,	#2
    ldr	s11,	[x3]

    fmul	s22,	s3,	s21
    add	x3,	x28,	#44
    ldr	s29,	[x11]

    add	x24,	x17,	x25
    fadd	s20,	s12,	s22
    lsl	w11,	w7,	#2
    fmul	s30,	s11,	s29
    fadd	s30,	s20,	s30
    ldr	s20,	[x16]

    add	x16,	x28,	#48
    ldr	s6,	[x21]

    ldr	s28,	[x0]

    fmul	s7,	s20,	s6
    add	x0,	x28,	#52
    ldr	s14,	[x3]

    fadd	s7,	s30,	s7
    ldr	s5,	[x13]

    fmul	s15,	s28,	s14
    add	x13,	x17,	x11
    ldr	s22,	[x16]

    fadd	s16,	s7,	s15
    ldr	s13,	[x24]

    fmul	s23,	s5,	s22
    ldr	s30,	[x0]

    fadd	s24,	s16,	s23
    add	x0,	x28,	#56
    ldr	s22,	[x13]

    fmul	s31,	s13,	s30
    fadd	s3,	s24,	s31
    ldr	s7,	[x0]

    fmul	s8,	s22,	s7
    fadd	s14,	s3,	s8
    cmp	w10,	#15
    blt	main_19

main_131:
    lsl	w12,	w4,	#2
    add	w4,	w4,	#1
    add	x11,	x5,	x12
    str	s14,	[x11]

    cmp	w4,	#36
    blt	main_16

main_135:
    add	w6,	w6,	#1
    cmp	w6,	#36
    blt	main_12

main_138:
    movz	w10,	#0

main_140:
    movz	w9,	#4000
    movz	w24,	#0
    madd	x3,	x10,	x9,	x20


main_144:
    movz	w13,	#0
    movi	v18.4s,	#0

main_147:
    add	w6,	w13,	w10
    movz	w21,	#4000
    lsl	w17,	w13,	#6
    add	w22,	w24,	#1
    add	w5,	w24,	#2
    add	w18,	w24,	#3
    add	w1,	w24,	#4
    madd	x7,	x6,	x21,	x23

    sub	w14,	w17,	w13,	lsl #2
    lsl	w26,	w22,	#2
    lsl	w9,	w5,	#2
    lsl	w21,	w18,	#2
    lsl	w4,	w1,	#2
    add	w13,	w13,	#1
    add	x15,	x8,	x14
    add	x25,	x7,	x26
    add	x6,	x7,	x9
    add	x19,	x7,	x21
    add	x2,	x7,	x4
    lsl	w14,	w24,	#2
    add	x0,	x15,	#4
    add	w26,	w24,	#6
    add	w9,	w24,	#7
    add	w21,	w24,	#8
    add	w4,	w24,	#9
    add	x12,	x7,	x14
    add	w14,	w24,	#5
    ldr	s4,	[x12]

    lsl	w17,	w14,	#2
    add	x12,	x15,	#8
    ldr	s15,	[x15]

    add	x16,	x7,	x17
    ldr	s22,	[x25]

    fmul	s16,	s4,	s15
    add	w17,	w24,	#10
    add	x25,	x15,	#12
    ldr	s6,	[x0]

    fadd	s5,	s18,	s16
    lsl	w0,	w26,	#2
    ldr	s30,	[x6]

    fmul	s7,	s22,	s6
    add	x28,	x7,	x0
    add	x6,	x15,	#16
    ldr	s14,	[x12]

    fadd	s13,	s5,	s7
    add	w0,	w24,	#11
    lsl	w12,	w9,	#2
    fmul	s15,	s30,	s14
    ldr	s7,	[x19]

    add	x11,	x7,	x12
    fadd	s24,	s13,	s15
    add	x19,	x15,	#20
    ldr	s22,	[x25]

    add	w12,	w24,	#12
    lsl	w25,	w21,	#2
    ldr	s15,	[x2]

    fmul	s23,	s7,	s22
    add	x22,	x7,	x25
    add	x2,	x15,	#24
    ldr	s30,	[x6]

    fadd	s1,	s24,	s23
    add	w25,	w24,	#13
    lsl	w6,	w4,	#2
    fmul	s31,	s15,	s30
    ldr	s24,	[x16]

    add	x5,	x7,	x6
    fadd	s11,	s1,	s31
    add	x16,	x15,	#28
    ldr	s7,	[x19]

    add	w6,	w24,	#14
    lsl	w19,	w17,	#2
    ldr	s1,	[x28]

    fmul	s8,	s24,	s7
    add	x18,	x7,	x19
    add	x28,	x15,	#32
    ldr	s15,	[x2]

    fadd	s20,	s11,	s8
    lsl	w2,	w0,	#2
    ldr	s9,	[x11]

    fmul	s16,	s1,	s15
    add	x11,	x15,	#36
    ldr	s23,	[x16]

    add	x1,	x7,	x2
    fadd	s28,	s20,	s16
    lsl	w16,	w12,	#2
    ldr	s17,	[x22]

    fmul	s24,	s9,	s23
    add	x14,	x7,	x16
    add	x22,	x15,	#40
    ldr	s31,	[x28]

    fadd	s6,	s28,	s24
    lsl	w28,	w25,	#2
    ldr	s26,	[x5]

    fmul	s1,	s17,	s31
    add	x5,	x15,	#44
    ldr	s8,	[x11]

    add	x26,	x7,	x28
    fadd	s15,	s6,	s1
    lsl	w11,	w6,	#2
    ldr	s3,	[x18]

    fmul	s9,	s26,	s8
    add	x2,	x7,	x11
    add	x18,	x15,	#48
    ldr	s16,	[x22]

    fadd	s24,	s15,	s9
    add	x11,	x15,	#56
    ldr	s11,	[x1]

    fmul	s17,	s3,	s16
    add	x1,	x15,	#52
    fadd	s1,	s24,	s17
    ldr	s24,	[x5]

    ldr	s20,	[x14]

    fmul	s25,	s11,	s24
    fadd	s11,	s1,	s25
    ldr	s1,	[x18]

    ldr	s28,	[x26]

    fmul	s2,	s20,	s1
    ldr	s9,	[x1]

    fadd	s19,	s11,	s2
    ldr	s5,	[x2]

    fmul	s10,	s28,	s9
    ldr	s17,	[x11]

    fadd	s28,	s19,	s10
    fmul	s18,	s5,	s17
    fadd	s18,	s28,	s18
    cmp	w13,	#15
    blt	main_147

main_259:
    lsl	w13,	w24,	#2
    add	w24,	w24,	#1
    add	x12,	x3,	x13
    str	s18,	[x12]

    cmp	w24,	#22
    blt	main_144

main_263:
    add	w10,	w10,	#1
    cmp	w10,	#22
    blt	main_140

main_266:
    movz	w14,	#0
    movz	w6,	#0

main_268:
    movz	w0,	#4000
    movz	w28,	#972
    movz	w1,	#0
    movz	w17,	#0
    madd	x24,	x6,	x0,	x20

    madd	x28,	x14,	x28,	x27


main_274:
    lsl	w5,	w17,	#2
    movz	w22,	#0
    add	x4,	x24,	x5
    ldr	s24,	[x4]


main_280:
    add	w12,	w22,	w6
    movz	w4,	#4000
    lsl	w10,	w17,	#2
    madd	x12,	x12,	x4,	x20

    add	x9,	x12,	x10
    ldr	s31,	[x9]

    fcmp	s24,	s31
    add	w15,	w17,	#1
    fcsel	s2,	s24,	s31,	gt
    lsl	w18,	w15,	#2
    add	x16,	x12,	x18
    ldr	s15,	[x16]

    fcmp	s2,	s15
    add	w25,	w17,	#2
    fcsel	s8,	s2,	s15,	gt
    lsl	w0,	w25,	#2
    add	x26,	x12,	x0
    ldr	s21,	[x26]

    fcmp	s8,	s21
    add	w5,	w17,	#3
    fcsel	s14,	s8,	s21,	gt
    lsl	w8,	w5,	#2
    add	x7,	x12,	x8
    ldr	s27,	[x7]

    fcmp	s14,	s27
    add	w22,	w22,	#1
    fcsel	s24,	s14,	s27,	gt
    cmp	w22,	#4
    blt	main_280

main_306:
    lsl	w18,	w1,	#2
    add	w17,	w17,	#4
    add	w1,	w1,	#1
    add	x16,	x28,	x18
    str	s24,	[x16]

    cmp	w1,	#5
    blt	main_274

main_311:
    add	w14,	w14,	#1
    add	w6,	w6,	#4
    cmp	w14,	#5
    blt	main_268

main_315:
    movz	w20,	#0

main_317:
    movz	w28,	#972
    fmov	s20,	#1.000000
    fmov	s19,	#2.000000
    fmov	s18,	#6.000000
    fmov	s17,	#24.000000
    fmov	s11,	#24.000000
    fmov	s8,	#1.000000
    fmov	s5,	#24.000000
    fmov	s3,	#1.000000
    madd	x2,	x20,	x28,	x27

    add	w20,	w20,	#1
    add	x3,	x2,	#12
    add	x13,	x2,	#8
    add	x24,	x2,	#4
    add	x18,	x2,	#16
    ldr	s14,	[x2]

    fneg	s28,	s14
    fmul	s7,	s28,	s28
    fadd	s6,	s20,	s28
    fmul	s10,	s7,	s28
    fdiv	s16,	s7,	s19
    fmul	s13,	s10,	s28
    fdiv	s19,	s10,	s18
    fadd	s9,	s6,	s16
    fdiv	s22,	s13,	s17
    fmov	s10,	#1.000000
    fmov	s6,	#6.000000
    fmov	s16,	#1.000000
    fadd	s12,	s9,	s19
    fmov	s13,	#2.000000
    fmov	s9,	#1.000000
    fadd	s15,	s12,	s22
    fmov	s12,	#6.000000
    fmov	s22,	#1.000000
    fadd	s17,	s16,	s15
    fmov	s15,	#1.000000
    fdiv	s25,	s15,	s17
    fmul	s26,	s14,	s25
    fmov	s14,	#1.000000
    str	s26,	[x2]

    ldr	s15,	[x24]

    fneg	s30,	s15
    fmul	s25,	s30,	s30
    fadd	s24,	s14,	s30
    fmul	s28,	s25,	s30
    fdiv	s1,	s25,	s13
    fmul	s30,	s28,	s30
    fdiv	s4,	s28,	s12
    fadd	s27,	s24,	s1
    fdiv	s7,	s30,	s11
    fmov	s28,	#1.000000
    fadd	s31,	s27,	s4
    fmov	s30,	#24.000000
    fmov	s4,	#1.000000
    fadd	s1,	s31,	s7
    fmov	s31,	#6.000000
    fmov	s7,	#2.000000
    fadd	s2,	s10,	s1
    fmov	s1,	#2.000000
    fdiv	s10,	s9,	s2
    fmov	s2,	#1.000000
    fmul	s11,	s15,	s10
    str	s11,	[x24]

    ldr	s24,	[x13]

    fneg	s26,	s24
    fmul	s12,	s26,	s26
    fadd	s11,	s8,	s26
    fmul	s15,	s12,	s26
    fdiv	s17,	s12,	s7
    fmul	s16,	s15,	s26
    fdiv	s20,	s15,	s6
    fadd	s14,	s11,	s17
    fdiv	s23,	s16,	s5
    fadd	s18,	s14,	s20
    fadd	s18,	s18,	s23
    fadd	s19,	s4,	s18
    fdiv	s26,	s3,	s19
    fmul	s27,	s24,	s26
    fmov	s24,	#24.000000
    fmov	s26,	#2.000000
    str	s27,	[x13]

    ldr	s21,	[x3]

    fneg	s20,	s21
    fmul	s25,	s20,	s20
    fadd	s29,	s2,	s20
    fmul	s27,	s25,	s20
    fdiv	s2,	s25,	s1
    fdiv	s5,	s27,	s31
    fmov	s25,	#6.000000
    fadd	s1,	s29,	s2
    fmov	s29,	#1.000000
    fadd	s5,	s1,	s5
    fmul	s1,	s27,	s20
    fmov	s27,	#1.000000
    fdiv	s8,	s1,	s30
    fadd	s3,	s5,	s8
    fadd	s4,	s29,	s3
    fdiv	s11,	s28,	s4
    fmul	s12,	s21,	s11
    str	s12,	[x3]

    ldr	s2,	[x18]

    fneg	s23,	s2
    fmul	s15,	s23,	s23
    fadd	s14,	s27,	s23
    fmul	s19,	s15,	s23
    fdiv	s18,	s15,	s26
    fdiv	s21,	s19,	s25
    fadd	s17,	s14,	s18
    fadd	s15,	s17,	s21
    fmul	s17,	s19,	s23
    fmov	s23,	#1.000000
    fdiv	s24,	s17,	s24
    fadd	s19,	s15,	s24
    fadd	s20,	s23,	s19
    fdiv	s27,	s22,	s20
    fmul	s28,	s2,	s27
    str	s28,	[x18]

    cmp	w20,	#5
    blt	main_317

main_402:
    movz	w0,	#108
    bl	_sysy_stoptime
    movz	w0,	#25
    add	x1,	sp,	#16
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#40512
    movk	fp,	#3,	lsl #16
    add	sp, sp, fp
    ret


