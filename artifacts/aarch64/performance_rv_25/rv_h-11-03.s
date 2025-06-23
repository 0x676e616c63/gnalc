.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global input
.align	2
input:
    .zero	16000000

.global conv_output
.align	2
conv_output:
    .zero	16000000


.text

.globl main
main:
main_0:
    movz	fp,	#55616
    movk	fp,	#14,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#54692
    movz	w1,	#0
    add	x0,	sp,	#916
    movk	w2,	#14,	lsl #16
    bl	memset
    movz	w2,	#900
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    adrp	x0, :got:input
    ldr	x0, [x0, #:got_lo12:input]
    bl	getfarray
    add	x0,	sp,	#16
    bl	getfarray
    movz	w0,	#106
    bl	_sysy_starttime
    movz	w7,	#0
    add	x15,	sp,	#16
    add	x1,	sp,	#916
    adrp	x28, :got:conv_output
    adrp	x25, :got:input
    ldr	x25, [x25, #:got_lo12:input]
    ldr	x28, [x28, #:got_lo12:conv_output]

main_12:
    movz	w23,	#8000
    movz	w27,	#0
    madd	x17,	x7,	x23,	x28


main_16:
    movz	w8,	#0
    movi	v14.4s,	#0

main_19:
    add	w19,	w8,	w7
    movz	w16,	#8000
    lsl	w13,	w8,	#6
    lsl	w14,	w27,	#2
    add	w9,	w27,	#2
    add	w4,	w27,	#4
    madd	x20,	x19,	x16,	x25

    sub	w23,	w13,	w8,	lsl #2
    add	w19,	w27,	#3
    add	w8,	w8,	#1
    lsl	w11,	w9,	#2
    lsl	w6,	w4,	#2
    add	x13,	x20,	x14
    add	x2,	x15,	x23
    lsl	w22,	w19,	#2
    add	x10,	x20,	x11
    add	x5,	x20,	x6
    add	w14,	w27,	#5
    ldr	s19,	[x13]

    add	x3,	x2,	#4
    add	w23,	w27,	#1
    add	x21,	x20,	x22
    add	w11,	w27,	#7
    add	w6,	w27,	#9
    lsl	w18,	w14,	#2
    add	x13,	x2,	#8
    ldr	s3,	[x2]

    lsl	w26,	w23,	#2
    add	w22,	w27,	#8
    add	x16,	x20,	x18
    fmul	s4,	s19,	s3
    add	x24,	x20,	x26
    add	w18,	w27,	#10
    fadd	s14,	s14,	s4
    add	w26,	w27,	#6
    ldr	s9,	[x24]

    add	x24,	x2,	#12
    ldr	s29,	[x3]

    lsl	w3,	w26,	#2
    ldr	s18,	[x10]

    fmul	s30,	s9,	s29
    add	x10,	x2,	#16
    ldr	s6,	[x13]

    add	x0,	x20,	x3
    fadd	s24,	s14,	s30
    lsl	w13,	w11,	#2
    ldr	s26,	[x21]

    fmul	s7,	s18,	s6
    add	w3,	w27,	#11
    add	x12,	x20,	x13
    add	x21,	x2,	#20
    ldr	s14,	[x24]

    fadd	s1,	s24,	s7
    add	w13,	w27,	#12
    lsl	w24,	w22,	#2
    ldr	s3,	[x5]

    fmul	s15,	s26,	s14
    add	x5,	x2,	#24
    ldr	s22,	[x10]

    add	x23,	x20,	x24
    fadd	s10,	s1,	s15
    lsl	w10,	w6,	#2
    ldr	s11,	[x16]

    fmul	s23,	s3,	s22
    add	w24,	w27,	#13
    add	x9,	x20,	x10
    add	x16,	x2,	#28
    ldr	s30,	[x21]

    fadd	s18,	s10,	s23
    add	w10,	w27,	#14
    lsl	w21,	w18,	#2
    ldr	s20,	[x0]

    fmul	s31,	s11,	s30
    add	x0,	x2,	#32
    ldr	s7,	[x5]

    add	x19,	x20,	x21
    fadd	s28,	s18,	s31
    lsl	w5,	w3,	#2
    fmul	s8,	s20,	s7
    add	x3,	x2,	#56
    add	x4,	x20,	x5
    fadd	s5,	s28,	s8
    ldr	s28,	[x12]

    add	x12,	x2,	#36
    ldr	s15,	[x16]

    lsl	w16,	w13,	#2
    fmul	s16,	s28,	s15
    fadd	s14,	s5,	s16
    add	x14,	x20,	x16
    ldr	s5,	[x23]

    add	x23,	x2,	#40
    ldr	s23,	[x0]

    lsl	w0,	w24,	#2
    ldr	s13,	[x9]

    fmul	s24,	s5,	s23
    add	x9,	x2,	#44
    ldr	s31,	[x12]

    add	x26,	x20,	x0
    fadd	s23,	s14,	s24
    lsl	w12,	w10,	#2
    ldr	s22,	[x19]

    fmul	s1,	s13,	s31
    add	x19,	x2,	#48
    ldr	s8,	[x23]

    fadd	s1,	s23,	s1
    ldr	s30,	[x4]

    fmul	s9,	s22,	s8
    add	x4,	x2,	#52
    ldr	s16,	[x9]

    fadd	s9,	s1,	s9
    ldr	s7,	[x14]

    fmul	s17,	s30,	s16
    add	x14,	x20,	x12
    ldr	s24,	[x19]

    fadd	s18,	s9,	s17
    ldr	s16,	[x26]

    fmul	s25,	s7,	s24
    ldr	s1,	[x4]

    fadd	s28,	s18,	s25
    ldr	s24,	[x14]

    fmul	s2,	s16,	s1
    ldr	s9,	[x3]

    fadd	s5,	s28,	s2
    fmul	s10,	s24,	s9
    fadd	s14,	s5,	s10
    cmp	w8,	#15
    blt	main_19

main_131:
    lsl	w12,	w27,	#2
    add	w27,	w27,	#1
    add	x11,	x17,	x12
    str	s14,	[x11]

    cmp	w27,	#86
    blt	main_16

main_135:
    add	w7,	w7,	#1
    cmp	w7,	#86
    blt	main_12

main_138:
    movz	w13,	#0

main_140:
    movz	w19,	#8000
    movz	w2,	#0
    madd	x7,	x13,	x19,	x25


main_144:
    movz	w12,	#0
    movi	v18.4s,	#0

main_147:
    add	w11,	w12,	w13
    movz	w10,	#8000
    lsl	w18,	w12,	#6
    add	w26,	w2,	#1
    add	w9,	w2,	#2
    add	w22,	w2,	#3
    add	w5,	w2,	#4
    madd	x11,	x11,	x10,	x28

    sub	w18,	w18,	w12,	lsl #2
    lsl	w0,	w26,	#2
    lsl	w14,	w9,	#2
    lsl	w24,	w22,	#2
    lsl	w8,	w5,	#2
    add	w12,	w12,	#1
    add	x19,	x15,	x18
    add	x27,	x11,	x0
    add	x10,	x11,	x14
    add	x23,	x11,	x24
    add	x6,	x11,	x8
    lsl	w18,	w2,	#2
    add	w0,	w2,	#6
    add	x4,	x19,	#4
    add	w14,	w2,	#7
    add	w24,	w2,	#8
    add	w8,	w2,	#9
    add	x17,	x11,	x18
    add	w18,	w2,	#5
    ldr	s6,	[x17]

    lsl	w21,	w18,	#2
    add	x17,	x19,	#8
    ldr	s17,	[x19]

    add	x20,	x11,	x21
    ldr	s24,	[x27]

    fmul	s19,	s6,	s17
    add	w21,	w2,	#10
    add	x27,	x19,	#12
    ldr	s8,	[x4]

    fadd	s7,	s18,	s19
    lsl	w4,	w0,	#2
    ldr	s1,	[x10]

    fmul	s9,	s24,	s8
    add	x3,	x11,	x4
    add	x10,	x19,	#16
    ldr	s16,	[x17]

    fadd	s18,	s7,	s9
    add	w4,	w2,	#11
    lsl	w17,	w14,	#2
    fmul	s17,	s1,	s16
    ldr	s9,	[x23]

    add	x16,	x11,	x17
    fadd	s26,	s18,	s17
    add	x23,	x19,	#20
    ldr	s24,	[x27]

    add	w17,	w2,	#12
    lsl	w27,	w24,	#2
    ldr	s18,	[x6]

    fmul	s25,	s9,	s24
    add	x26,	x11,	x27
    add	x6,	x19,	#24
    ldr	s1,	[x10]

    fadd	s5,	s26,	s25
    add	w27,	w2,	#13
    lsl	w10,	w8,	#2
    fmul	s2,	s18,	s1
    ldr	s26,	[x20]

    add	x9,	x11,	x10
    fadd	s13,	s5,	s2
    add	x20,	x19,	#28
    ldr	s9,	[x23]

    add	w10,	w2,	#14
    lsl	w23,	w21,	#2
    ldr	s3,	[x3]

    fmul	s10,	s26,	s9
    add	x22,	x11,	x23
    add	x3,	x19,	#32
    ldr	s17,	[x6]

    fadd	s22,	s13,	s10
    lsl	w6,	w4,	#2
    ldr	s11,	[x16]

    fmul	s18,	s3,	s17
    add	x16,	x19,	#36
    ldr	s25,	[x20]

    add	x5,	x11,	x6
    fadd	s30,	s22,	s18
    lsl	w20,	w17,	#2
    ldr	s20,	[x26]

    fmul	s26,	s11,	s25
    add	x18,	x11,	x20
    add	x26,	x19,	#40
    ldr	s2,	[x3]

    fadd	s9,	s30,	s26
    lsl	w3,	w27,	#2
    ldr	s28,	[x9]

    fmul	s3,	s20,	s2
    add	x9,	x19,	#44
    ldr	s10,	[x16]

    add	x0,	x11,	x3
    fadd	s17,	s9,	s3
    ldr	s5,	[x22]

    lsl	w16,	w10,	#2
    fmul	s11,	s28,	s10
    add	x22,	x19,	#48
    ldr	s18,	[x26]

    add	x6,	x11,	x16
    fadd	s26,	s17,	s11
    ldr	s13,	[x5]

    fmul	s19,	s5,	s18
    add	x16,	x19,	#56
    add	x5,	x19,	#52
    fadd	s3,	s26,	s19
    ldr	s26,	[x9]

    ldr	s22,	[x18]

    fmul	s27,	s13,	s26
    fadd	s13,	s3,	s27
    ldr	s3,	[x22]

    ldr	s30,	[x0]

    fmul	s4,	s22,	s3
    ldr	s11,	[x5]

    fadd	s21,	s13,	s4
    ldr	s7,	[x6]

    fmul	s12,	s30,	s11
    ldr	s19,	[x16]

    fadd	s30,	s21,	s12
    fmul	s20,	s7,	s19
    fadd	s18,	s30,	s20
    cmp	w12,	#15
    blt	main_147

main_259:
    lsl	w17,	w2,	#2
    add	w2,	w2,	#1
    add	x16,	x7,	x17
    str	s18,	[x16]

    cmp	w2,	#72
    blt	main_144

main_263:
    add	w13,	w13,	#1
    cmp	w13,	#72
    blt	main_140

main_266:
    movz	w13,	#0
    movz	w19,	#0

main_268:
    movz	w12,	#8000
    movz	w11,	#1972
    movz	w7,	#0
    movz	w2,	#0
    madd	x28,	x19,	x12,	x25

    madd	x3,	x13,	x11,	x1


main_274:
    lsl	w10,	w2,	#2
    movz	w18,	#0
    add	x9,	x28,	x10
    ldr	s24,	[x9]


main_280:
    add	w17,	w18,	w19
    movz	w10,	#8000
    lsl	w15,	w2,	#2
    madd	x24,	x17,	x10,	x25

    add	x14,	x24,	x15
    ldr	s2,	[x14]

    fcmp	s24,	s2
    add	w21,	w2,	#1
    fcsel	s4,	s24,	s2,	gt
    lsl	w23,	w21,	#2
    add	x22,	x24,	x23
    ldr	s17,	[x22]

    fcmp	s4,	s17
    add	w0,	w2,	#2
    fcsel	s10,	s4,	s17,	gt
    lsl	w5,	w0,	#2
    add	x4,	x24,	x5
    ldr	s23,	[x4]

    fcmp	s10,	s23
    add	w10,	w2,	#3
    fcsel	s16,	s10,	s23,	gt
    lsl	w12,	w10,	#2
    add	x11,	x24,	x12
    ldr	s29,	[x11]

    fcmp	s16,	s29
    add	w18,	w18,	#1
    fcsel	s24,	s16,	s29,	gt
    cmp	w18,	#4
    blt	main_280

main_306:
    lsl	w22,	w7,	#2
    add	w2,	w2,	#4
    add	w7,	w7,	#1
    add	x21,	x3,	x22
    str	s24,	[x21]

    cmp	w7,	#18
    blt	main_274

main_311:
    add	w13,	w13,	#1
    add	w19,	w19,	#4
    cmp	w13,	#18
    blt	main_268

main_315:
    movz	w11,	#0

main_317:
    movz	w28,	#1972
    movz	w22,	#0
    madd	x7,	x11,	x28,	x1


main_320:
    cmp	w22,	#16
    bge	main_462

main_323:
    lsl	w2,	w22,	#2
    fmov	s8,	#1.000000
    fmov	s7,	#2.000000
    fmov	s6,	#6.000000
    fmov	s5,	#24.000000
    fmov	s4,	#1.000000
    fmov	s3,	#1.000000
    add	w15,	w22,	#1
    fmov	s1,	#1.000000
    fmov	s31,	#2.000000
    fmov	s28,	#1.000000
    fmov	s27,	#1.000000
    fmov	s25,	#1.000000
    add	x0,	x7,	x2
    add	w5,	w15,	#1
    lsl	w3,	w15,	#2
    ldr	s30,	[x0]

    add	x2,	x7,	x3
    add	w27,	w5,	#1
    lsl	w23,	w5,	#2
    fneg	s16,	s30
    add	x22,	x7,	x23
    fmul	s12,	s16,	s16
    add	w21,	w27,	#1
    lsl	w15,	w27,	#2
    fadd	s11,	s8,	s16
    fmul	s15,	s12,	s16
    fdiv	s20,	s12,	s7
    add	x14,	x7,	x15
    add	w13,	w21,	#1
    lsl	w5,	w21,	#2
    fmul	s18,	s15,	s16
    fdiv	s23,	s15,	s6
    fadd	s14,	s11,	s20
    add	x4,	x7,	x5
    lsl	w25,	w13,	#2
    fdiv	s26,	s18,	s5
    fadd	s17,	s14,	s23
    add	w5,	w13,	#1
    add	x24,	x7,	x25
    fmov	s23,	#6.000000
    fadd	s20,	s17,	s26
    add	w27,	w5,	#1
    lsl	w17,	w5,	#2
    fadd	s21,	s4,	s20
    add	x16,	x7,	x17
    fdiv	s29,	s3,	s21
    lsl	w8,	w27,	#2
    fmul	s30,	s30,	s29
    fmov	s29,	#24.000000
    str	s30,	[x0]

    add	x6,	x7,	x8
    ldr	s24,	[x2]

    fneg	s20,	s24
    fadd	s30,	s1,	s20
    fmul	s1,	s20,	s20
    fmul	s4,	s1,	s20
    fdiv	s7,	s1,	s31
    fmul	s5,	s4,	s20
    fadd	s3,	s30,	s7
    fmov	s20,	#1.000000
    fdiv	s13,	s5,	s29
    fmov	s30,	#6.000000
    fdiv	s10,	s4,	s30
    fadd	s7,	s3,	s10
    fmov	s10,	#2.000000
    fadd	s7,	s7,	s13
    fadd	s8,	s28,	s7
    fdiv	s16,	s27,	s8
    fmov	s8,	#24.000000
    fmul	s17,	s24,	s16
    fmov	s16,	#6.000000
    fmov	s24,	#2.000000
    str	s17,	[x2]

    fmov	s17,	#2.000000
    ldr	s6,	[x22]

    fneg	s15,	s6
    fmul	s19,	s15,	s15
    fadd	s18,	s25,	s15
    fmul	s22,	s19,	s15
    fdiv	s25,	s19,	s24
    fdiv	s28,	s22,	s23
    fmul	s24,	s22,	s15
    fadd	s21,	s18,	s25
    fmov	s22,	#24.000000
    fmov	s18,	#1.000000
    fadd	s26,	s21,	s28
    fdiv	s31,	s24,	s22
    fmov	s28,	#1.000000
    fmov	s21,	#1.000000
    fadd	s26,	s26,	s31
    fmov	s31,	#1.000000
    fadd	s27,	s21,	s26
    fdiv	s3,	s20,	s27
    fmul	s4,	s6,	s3
    fmov	s6,	#1.000000
    str	s4,	[x22]

    add	w22,	w27,	#1
    ldr	s24,	[x14]

    fneg	s14,	s24
    fmul	s4,	s14,	s14
    fadd	s9,	s18,	s14
    fmul	s7,	s4,	s14
    fdiv	s12,	s4,	s17
    fmul	s11,	s7,	s14
    fdiv	s15,	s7,	s16
    fadd	s12,	s9,	s12
    fmov	s14,	#1.000000
    fmov	s7,	#1.000000
    fmov	s9,	#6.000000
    fadd	s16,	s12,	s15
    fmov	s15,	#24.000000
    fdiv	s18,	s11,	s15
    fmov	s11,	#1.000000
    fadd	s13,	s16,	s18
    fadd	s15,	s14,	s13
    fmov	s13,	#1.000000
    fdiv	s21,	s13,	s15
    fmul	s22,	s24,	s21
    str	s22,	[x14]

    ldr	s15,	[x4]

    fneg	s25,	s15
    fmul	s29,	s25,	s25
    fadd	s27,	s11,	s25
    fmul	s3,	s29,	s25
    fdiv	s30,	s29,	s10
    fdiv	s2,	s3,	s9
    fadd	s1,	s27,	s30
    fmul	s30,	s3,	s25
    fadd	s4,	s1,	s2
    fmov	s3,	#2.000000
    fdiv	s5,	s30,	s8
    fmov	s30,	#1.000000
    fadd	s1,	s4,	s5
    fmov	s4,	#1.000000
    fadd	s2,	s7,	s1
    fmov	s1,	#24.000000
    fdiv	s8,	s6,	s2
    fmov	s2,	#6.000000
    fmul	s9,	s15,	s8
    str	s9,	[x4]

    ldr	s12,	[x24]

    fneg	s24,	s12
    fmul	s19,	s24,	s24
    fadd	s18,	s4,	s24
    fmul	s22,	s19,	s24
    fdiv	s17,	s19,	s3
    fdiv	s20,	s22,	s2
    fadd	s21,	s18,	s17
    fmov	s17,	#1.000000
    fmul	s18,	s22,	s24
    fadd	s25,	s21,	s20
    fmov	s24,	#1.000000
    fdiv	s23,	s18,	s1
    fmov	s21,	#1.000000
    fmov	s18,	#24.000000
    fadd	s19,	s25,	s23
    fmov	s23,	#1.000000
    fmov	s25,	#24.000000
    fadd	s20,	s31,	s19
    fmov	s19,	#6.000000
    fdiv	s26,	s30,	s20
    fmov	s20,	#2.000000
    fmul	s27,	s12,	s26
    fmov	s26,	#6.000000
    str	s27,	[x24]

    fmov	s27,	#2.000000
    ldr	s16,	[x16]

    fneg	s30,	s16
    fmul	s8,	s30,	s30
    fadd	s7,	s28,	s30
    fmul	s11,	s8,	s30
    fdiv	s4,	s8,	s27
    fmul	s5,	s11,	s30
    fadd	s10,	s7,	s4
    fdiv	s7,	s11,	s26
    fadd	s14,	s10,	s7
    fdiv	s10,	s5,	s25
    fadd	s7,	s14,	s10
    fadd	s8,	s24,	s7
    fdiv	s13,	s23,	s8
    fmul	s14,	s16,	s13
    fmov	s16,	#1.000000
    str	s14,	[x16]

    ldr	s23,	[x6]

    fneg	s10,	s23
    fmul	s27,	s10,	s10
    fadd	s26,	s21,	s10
    fmul	s31,	s27,	s10
    fdiv	s22,	s27,	s20
    fmul	s24,	s31,	s10
    fdiv	s25,	s31,	s19
    fadd	s29,	s26,	s22
    fdiv	s28,	s24,	s18
    fadd	s2,	s29,	s25
    fadd	s26,	s2,	s28
    fadd	s27,	s17,	s26
    fdiv	s31,	s16,	s27
    fmul	s1,	s23,	s31
    str	s1,	[x6]

    b	main_320

main_462:
    lsl	w24,	w22,	#2
    fmov	s15,	#1.000000
    fmov	s14,	#2.000000
    fmov	s13,	#6.000000
    fmov	s10,	#1.000000
    add	w22,	w22,	#1
    add	x23,	x7,	x24
    ldr	s25,	[x23]

    fneg	s6,	s25
    fmul	s17,	s6,	s6
    fadd	s16,	s15,	s6
    fmul	s20,	s17,	s6
    fdiv	s9,	s17,	s14
    fmul	s11,	s20,	s6
    fdiv	s12,	s20,	s13
    fadd	s19,	s16,	s9
    fadd	s23,	s19,	s12
    fmov	s12,	#24.000000
    fdiv	s15,	s11,	s12
    fmov	s11,	#1.000000
    fadd	s14,	s23,	s15
    fadd	s15,	s11,	s14
    fdiv	s18,	s10,	s15
    fmul	s19,	s25,	s18
    str	s19,	[x23]

    cmp	w22,	#18
    blt	main_462

main_482:
    add	w11,	w11,	#1
    cmp	w11,	#18
    blt	main_317

main_485:
    movz	w0,	#108
    bl	_sysy_stoptime
    movz	w0,	#324
    add	x1,	sp,	#916
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#55616
    movk	fp,	#14,	lsl #16
    add	sp, sp, fp
    ret


