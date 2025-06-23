.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global input
.align	2
input:
    .zero	9000000

.global conv_output
.align	2
conv_output:
    .zero	9000000


.text

.globl main
main:
main_0:
    movz	fp,	#18336
    movk	fp,	#8,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#17408
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#8,	lsl #16
    bl	memset
    movz	w2,	#900
    movz	w1,	#0
    movz	fp,	#17424
    movk	fp,	#8,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    adrp	x0, :got:input
    ldr	x0, [x0, #:got_lo12:input]
    bl	getfarray
    movz	fp,	#17424
    movk	fp,	#8,	lsl #16
    add	x0,	sp,	fp
    bl	getfarray
    movz	w0,	#106
    bl	_sysy_starttime
    movz	w6,	#0
    movz	fp,	#17424
    add	x28,	sp,	#16
    adrp	x18, :got:conv_output
    adrp	x22, :got:input
    movk	fp,	#8,	lsl #16
    ldr	x22, [x22, #:got_lo12:input]
    add	x7,	sp,	fp
    ldr	x18, [x18, #:got_lo12:conv_output]

main_12:
    movz	w0,	#6000
    movz	w27,	#0
    madd	x14,	x6,	x0,	x18


main_16:
    movz	w8,	#0
    movi	v14.4s,	#0

main_19:
    add	w16,	w8,	w6
    movz	w19,	#6000
    lsl	w3,	w8,	#6
    lsl	w13,	w27,	#2
    add	w5,	w27,	#2
    add	w17,	w27,	#3
    add	w2,	w27,	#4
    madd	x19,	x16,	x19,	x22

    sub	w23,	w3,	w8,	lsl #2
    add	x12,	x19,	x13
    lsl	w10,	w5,	#2
    lsl	w21,	w17,	#2
    lsl	w4,	w2,	#2
    add	w8,	w8,	#1
    add	x0,	x7,	x23
    add	w13,	w27,	#5
    ldr	s18,	[x12]

    add	x9,	x19,	x10
    add	x20,	x19,	x21
    add	x3,	x19,	x4
    add	w23,	w27,	#1
    add	x1,	x0,	#4
    lsl	w16,	w13,	#2
    add	x12,	x0,	#8
    ldr	s2,	[x0]

    add	w10,	w27,	#7
    add	w21,	w27,	#8
    add	w4,	w27,	#9
    lsl	w25,	w23,	#2
    add	x15,	x19,	x16
    fmul	s3,	s18,	s2
    add	w16,	w27,	#10
    add	x24,	x19,	x25
    fadd	s13,	s14,	s3
    add	w25,	w27,	#6
    ldr	s8,	[x24]

    add	x24,	x0,	#12
    ldr	s28,	[x1]

    lsl	w1,	w25,	#2
    ldr	s17,	[x9]

    fmul	s29,	s8,	s28
    add	x9,	x0,	#16
    ldr	s5,	[x12]

    add	x26,	x19,	x1
    fadd	s23,	s13,	s29
    lsl	w12,	w10,	#2
    ldr	s25,	[x20]

    fmul	s6,	s17,	s5
    add	w1,	w27,	#11
    add	x11,	x19,	x12
    add	x20,	x0,	#20
    ldr	s13,	[x24]

    fadd	s31,	s23,	s6
    add	w12,	w27,	#12
    lsl	w24,	w21,	#2
    ldr	s2,	[x3]

    fmul	s14,	s25,	s13
    add	x3,	x0,	#24
    ldr	s21,	[x9]

    add	x23,	x19,	x24
    fadd	s9,	s31,	s14
    lsl	w9,	w4,	#2
    ldr	s10,	[x15]

    fmul	s22,	s2,	s21
    add	w24,	w27,	#13
    add	x5,	x19,	x9
    add	x15,	x0,	#28
    ldr	s29,	[x20]

    fadd	s17,	s9,	s22
    add	w9,	w27,	#14
    lsl	w20,	w16,	#2
    ldr	s19,	[x26]

    fmul	s30,	s10,	s29
    add	x26,	x0,	#32
    ldr	s6,	[x3]

    add	x17,	x19,	x20
    fadd	s27,	s17,	s30
    lsl	w3,	w1,	#2
    fmul	s7,	s19,	s6
    add	x1,	x0,	#56
    add	x2,	x19,	x3
    fadd	s4,	s27,	s7
    ldr	s27,	[x11]

    add	x11,	x0,	#36
    ldr	s14,	[x15]

    lsl	w15,	w12,	#2
    fmul	s15,	s27,	s14
    fadd	s13,	s4,	s15
    add	x13,	x19,	x15
    ldr	s4,	[x23]

    add	x23,	x0,	#40
    ldr	s22,	[x26]

    lsl	w26,	w24,	#2
    ldr	s12,	[x5]

    fmul	s23,	s4,	s22
    add	x5,	x0,	#44
    ldr	s30,	[x11]

    add	x25,	x19,	x26
    fadd	s21,	s13,	s23
    lsl	w11,	w9,	#2
    fmul	s31,	s12,	s30
    fadd	s31,	s21,	s31
    ldr	s21,	[x17]

    add	x17,	x0,	#48
    ldr	s7,	[x23]

    ldr	s29,	[x2]

    fmul	s8,	s21,	s7
    add	x2,	x0,	#52
    ldr	s15,	[x5]

    fadd	s8,	s31,	s8
    ldr	s6,	[x13]

    fmul	s16,	s29,	s15
    add	x13,	x19,	x11
    ldr	s23,	[x17]

    fadd	s17,	s8,	s16
    ldr	s14,	[x25]

    fmul	s24,	s6,	s23
    ldr	s31,	[x2]

    fadd	s26,	s17,	s24
    ldr	s23,	[x13]

    fmul	s1,	s14,	s31
    ldr	s8,	[x1]

    fadd	s4,	s26,	s1
    fmul	s9,	s23,	s8
    fadd	s14,	s4,	s9
    cmp	w8,	#15
    blt	main_19

main_131:
    lsl	w11,	w27,	#2
    add	w27,	w27,	#1
    add	x10,	x14,	x11
    str	s14,	[x10]

    cmp	w27,	#1486
    blt	main_16

main_135:
    add	w6,	w6,	#1
    cmp	w6,	#1486
    blt	main_12

main_138:
    movz	w11,	#0

main_140:
    movz	w25,	#6000
    movz	w2,	#0
    madd	x5,	x11,	x25,	x22


main_144:
    movz	w12,	#0
    movi	v18.4s,	#0

main_147:
    add	w9,	w12,	w11
    movz	w15,	#6000
    lsl	w6,	w12,	#6
    add	w25,	w2,	#1
    add	w8,	w2,	#2
    add	w21,	w2,	#3
    add	w3,	w2,	#4
    madd	x10,	x9,	x15,	x18

    sub	w16,	w6,	w12,	lsl #2
    lsl	w27,	w25,	#2
    lsl	w13,	w8,	#2
    lsl	w24,	w21,	#2
    add	w12,	w12,	#1
    lsl	w6,	w3,	#2
    add	x17,	x7,	x16
    add	x26,	x10,	x27
    add	x9,	x10,	x13
    add	x23,	x10,	x24
    add	x4,	x10,	x6
    lsl	w16,	w2,	#2
    add	x1,	x17,	#4
    add	w27,	w2,	#6
    add	w13,	w2,	#7
    add	w24,	w2,	#8
    add	w6,	w2,	#9
    add	x15,	x10,	x16
    add	w16,	w2,	#5
    ldr	s5,	[x15]

    lsl	w20,	w16,	#2
    add	x15,	x17,	#8
    ldr	s16,	[x17]

    add	x19,	x10,	x20
    ldr	s23,	[x26]

    fmul	s17,	s5,	s16
    add	w20,	w2,	#10
    add	x26,	x17,	#12
    ldr	s7,	[x1]

    fadd	s6,	s18,	s17
    lsl	w1,	w27,	#2
    ldr	s31,	[x9]

    fmul	s8,	s23,	s7
    add	x0,	x10,	x1
    add	x9,	x17,	#16
    ldr	s15,	[x15]

    fadd	s14,	s6,	s8
    add	w1,	w2,	#11
    lsl	w15,	w13,	#2
    fmul	s16,	s31,	s15
    ldr	s8,	[x23]

    add	x14,	x10,	x15
    fadd	s25,	s14,	s16
    add	x23,	x17,	#20
    ldr	s23,	[x26]

    add	w15,	w2,	#12
    lsl	w26,	w24,	#2
    ldr	s16,	[x4]

    fmul	s24,	s8,	s23
    add	x25,	x10,	x26
    add	x4,	x17,	#24
    ldr	s31,	[x9]

    fadd	s3,	s25,	s24
    add	w26,	w2,	#13
    lsl	w9,	w6,	#2
    fmul	s1,	s16,	s31
    ldr	s25,	[x19]

    add	x8,	x10,	x9
    fadd	s12,	s3,	s1
    add	x19,	x17,	#28
    ldr	s8,	[x23]

    add	w9,	w2,	#14
    lsl	w23,	w20,	#2
    ldr	s2,	[x0]

    fmul	s9,	s25,	s8
    add	x21,	x10,	x23
    add	x0,	x17,	#32
    ldr	s16,	[x4]

    fadd	s21,	s12,	s9
    lsl	w4,	w1,	#2
    ldr	s10,	[x14]

    fmul	s17,	s2,	s16
    add	x14,	x17,	#36
    ldr	s24,	[x19]

    add	x3,	x10,	x4
    fadd	s29,	s21,	s17
    lsl	w19,	w15,	#2
    ldr	s19,	[x25]

    fmul	s25,	s10,	s24
    add	x16,	x10,	x19
    add	x25,	x17,	#40
    ldr	s1,	[x0]

    fadd	s8,	s29,	s25
    lsl	w0,	w26,	#2
    ldr	s27,	[x8]

    fmul	s2,	s19,	s1
    add	x8,	x17,	#44
    ldr	s9,	[x14]

    add	x27,	x10,	x0
    fadd	s16,	s8,	s2
    lsl	w14,	w9,	#2
    ldr	s4,	[x21]

    fmul	s10,	s27,	s9
    add	x4,	x10,	x14
    add	x21,	x17,	#48
    ldr	s17,	[x25]

    fadd	s25,	s16,	s10
    add	x14,	x17,	#56
    ldr	s12,	[x3]

    fmul	s18,	s4,	s17
    add	x3,	x17,	#52
    fadd	s2,	s25,	s18
    ldr	s25,	[x8]

    ldr	s21,	[x16]

    fmul	s26,	s12,	s25
    fadd	s12,	s2,	s26
    ldr	s2,	[x21]

    ldr	s29,	[x27]

    fmul	s3,	s21,	s2
    ldr	s10,	[x3]

    fadd	s20,	s12,	s3
    ldr	s6,	[x4]

    fmul	s11,	s29,	s10
    ldr	s18,	[x14]

    fadd	s29,	s20,	s11
    fmul	s19,	s6,	s18
    fadd	s18,	s29,	s19
    cmp	w12,	#15
    blt	main_147

main_259:
    lsl	w15,	w2,	#2
    add	w2,	w2,	#1
    add	x14,	x5,	x15
    str	s18,	[x14]

    cmp	w2,	#1472
    blt	main_144

main_263:
    add	w11,	w11,	#1
    cmp	w11,	#1472
    blt	main_140

main_266:
    movz	w13,	#0
    movz	w19,	#0

main_268:
    movz	w18,	#6000
    movz	w17,	#1472
    movz	w7,	#0
    movz	w2,	#0
    madd	x25,	x19,	x18,	x22

    madd	x0,	x13,	x17,	x28


main_274:
    lsl	w8,	w2,	#2
    movz	w18,	#0
    add	x6,	x25,	x8
    ldr	s24,	[x6]


main_280:
    add	w14,	w18,	w19
    movz	w26,	#6000
    lsl	w12,	w2,	#2
    madd	x16,	x14,	x26,	x22

    add	x11,	x16,	x12
    ldr	s1,	[x11]

    fcmp	s24,	s1
    add	w17,	w2,	#1
    fcsel	s3,	s24,	s1,	gt
    lsl	w21,	w17,	#2
    add	x20,	x16,	x21
    ldr	s16,	[x20]

    fcmp	s3,	s16
    add	w27,	w2,	#2
    fcsel	s9,	s3,	s16,	gt
    lsl	w3,	w27,	#2
    add	x1,	x16,	x3
    ldr	s22,	[x1]

    fcmp	s9,	s22
    add	w8,	w2,	#3
    fcsel	s15,	s9,	s22,	gt
    lsl	w10,	w8,	#2
    add	x9,	x16,	x10
    ldr	s28,	[x9]

    fcmp	s15,	s28
    add	w18,	w18,	#1
    fcsel	s24,	s15,	s28,	gt
    cmp	w18,	#4
    blt	main_280

main_306:
    lsl	w20,	w7,	#2
    add	w2,	w2,	#4
    add	w7,	w7,	#1
    add	x18,	x0,	x20
    str	s24,	[x18]

    cmp	w7,	#368
    blt	main_274

main_311:
    add	w13,	w13,	#1
    add	w19,	w19,	#4
    cmp	w13,	#368
    blt	main_268

main_315:
    movz	w20,	#0

main_317:
    movz	w7,	#1472
    movz	w12,	#0
    madd	x14,	x20,	x7,	x28


main_320:
    cmp	w12,	#368
    bge	main_460

main_323:
    lsl	w9,	w12,	#2
    fmov	s19,	#1.000000
    fmov	s18,	#2.000000
    fmov	s17,	#6.000000
    fmov	s16,	#24.000000
    fmov	s14,	#1.000000
    add	w18,	w12,	#1
    fmov	s11,	#2.000000
    fmov	s8,	#1.000000
    fmov	s7,	#1.000000
    fmov	s5,	#1.000000
    fmov	s1,	#1.000000
    fmov	s26,	#24.000000
    add	x8,	x14,	x9
    lsl	w2,	w18,	#2
    add	w9,	w18,	#1
    ldr	s23,	[x8]

    add	x1,	x14,	x2
    lsl	w21,	w9,	#2
    fneg	s31,	s23
    add	w2,	w9,	#1
    fmul	s10,	s31,	s31
    fadd	s9,	s19,	s31
    add	x19,	x14,	x21
    fmul	s13,	s10,	s31
    fdiv	s19,	s10,	s18
    add	w23,	w2,	#1
    lsl	w11,	w2,	#2
    fdiv	s22,	s13,	s17
    fmov	s10,	#6.000000
    fadd	s12,	s9,	s19
    add	x10,	x14,	x11
    add	w13,	w23,	#1
    lsl	w2,	w23,	#2
    fmul	s17,	s13,	s31
    fadd	s15,	s12,	s22
    fdiv	s25,	s17,	s16
    fmov	s12,	#1.000000
    add	w6,	w13,	#1
    lsl	w21,	w13,	#2
    fadd	s19,	s15,	s25
    fmov	s15,	#1.000000
    add	w27,	w6,	#1
    lsl	w11,	w6,	#2
    fadd	s20,	s15,	s19
    fdiv	s28,	s14,	s20
    add	w12,	w27,	#1
    fmul	s29,	s23,	s28
    str	s29,	[x8]

    ldr	s13,	[x1]

    fneg	s25,	s13
    fmul	s31,	s25,	s25
    fadd	s29,	s12,	s25
    fmul	s3,	s31,	s25
    fdiv	s6,	s31,	s11
    fmul	s4,	s3,	s25
    fdiv	s9,	s3,	s10
    fmov	s31,	#1.000000
    fadd	s2,	s29,	s6
    fmov	s3,	#6.000000
    fmov	s29,	#1.000000
    fadd	s6,	s2,	s9
    fmov	s9,	#24.000000
    fdiv	s12,	s4,	s9
    fmov	s4,	#2.000000
    fadd	s6,	s6,	s12
    fadd	s8,	s8,	s6
    fdiv	s15,	s7,	s8
    fmul	s16,	s13,	s15
    fmov	s15,	#1.000000
    str	s16,	[x1]

    add	x1,	x14,	x2
    ldr	s28,	[x19]

    lsl	w2,	w27,	#2
    fneg	s2,	s28
    fmul	s19,	s2,	s2
    fadd	s18,	s5,	s2
    fmul	s22,	s19,	s2
    fdiv	s24,	s19,	s4
    fmov	s5,	#24.000000
    fmul	s23,	s22,	s2
    fdiv	s27,	s22,	s3
    fmov	s19,	#24.000000
    fadd	s21,	s18,	s24
    fmov	s2,	#24.000000
    fmov	s22,	#1.000000
    fmov	s18,	#1.000000
    fmov	s24,	#1.000000
    fadd	s25,	s21,	s27
    fdiv	s30,	s23,	s2
    fmov	s27,	#6.000000
    fadd	s25,	s25,	s30
    fmov	s30,	#6.000000
    fadd	s25,	s1,	s25
    fdiv	s2,	s31,	s25
    fmov	s25,	#1.000000
    fmul	s3,	s28,	s2
    fmov	s28,	#2.000000
    str	s3,	[x19]

    add	x19,	x14,	x21
    ldr	s1,	[x10]

    fneg	s13,	s1
    fmul	s3,	s13,	s13
    fadd	s8,	s29,	s13
    fmul	s6,	s3,	s13
    fdiv	s11,	s3,	s28
    fmul	s10,	s6,	s13
    fdiv	s14,	s6,	s27
    fmov	s28,	#1.000000
    fadd	s11,	s8,	s11
    fdiv	s17,	s10,	s26
    fadd	s14,	s11,	s14
    fmov	s10,	#1.000000
    fmov	s11,	#1.000000
    fadd	s12,	s14,	s17
    fmov	s14,	#2.000000
    fmov	s17,	#1.000000
    fadd	s13,	s25,	s12
    fmov	s12,	#24.000000
    fdiv	s20,	s24,	s13
    fmov	s13,	#6.000000
    fmul	s21,	s1,	s20
    fmov	s20,	#6.000000
    str	s21,	[x10]

    add	x10,	x14,	x11
    fmov	s21,	#2.000000
    ldr	s9,	[x1]

    fneg	s23,	s9
    fmul	s27,	s23,	s23
    fadd	s26,	s22,	s23
    fmul	s2,	s27,	s23
    fdiv	s29,	s27,	s21
    fdiv	s1,	s2,	s20
    fadd	s31,	s26,	s29
    fmul	s29,	s2,	s23
    fadd	s3,	s31,	s1
    fdiv	s4,	s29,	s19
    fadd	s31,	s3,	s4
    fadd	s1,	s18,	s31
    fmov	s31,	#2.000000
    fdiv	s7,	s17,	s1
    fmul	s8,	s9,	s7
    str	s8,	[x1]

    add	x1,	x14,	x2
    fmov	s8,	#1.000000
    ldr	s7,	[x19]

    fneg	s23,	s7
    fmul	s18,	s23,	s23
    fadd	s17,	s15,	s23
    fmul	s21,	s18,	s23
    fdiv	s16,	s18,	s14
    fdiv	s19,	s21,	s13
    fadd	s20,	s17,	s16
    fmul	s17,	s21,	s23
    fadd	s24,	s20,	s19
    fdiv	s22,	s17,	s12
    fadd	s19,	s24,	s22
    fadd	s20,	s11,	s19
    fdiv	s25,	s10,	s20
    fmul	s26,	s7,	s25
    fmov	s7,	#2.000000
    str	s26,	[x19]

    ldr	s19,	[x10]

    fneg	s25,	s19
    fmul	s9,	s25,	s25
    fadd	s6,	s8,	s25
    fmul	s2,	s9,	s25
    fdiv	s3,	s9,	s7
    fmul	s4,	s2,	s25
    fadd	s1,	s6,	s3
    fdiv	s9,	s4,	s5
    fmov	s3,	#1.000000
    fmov	s6,	#6.000000
    fmov	s4,	#1.000000
    fdiv	s6,	s2,	s6
    fadd	s14,	s1,	s6
    fmov	s1,	#1.000000
    fadd	s7,	s14,	s9
    fadd	s8,	s4,	s7
    fdiv	s12,	s3,	s8
    fmul	s13,	s19,	s12
    str	s13,	[x10]

    ldr	s15,	[x1]

    fneg	s13,	s15
    fmul	s25,	s13,	s13
    fadd	s24,	s1,	s13
    fmul	s29,	s25,	s13
    fdiv	s21,	s25,	s31
    fmul	s22,	s29,	s13
    fadd	s27,	s24,	s21
    fdiv	s24,	s29,	s30
    fmov	s29,	#24.000000
    fadd	s1,	s27,	s24
    fdiv	s27,	s22,	s29
    fadd	s24,	s1,	s27
    fmov	s27,	#1.000000
    fadd	s25,	s28,	s24
    fdiv	s30,	s27,	s25
    fmul	s31,	s15,	s30
    str	s31,	[x1]

    b	main_320

main_460:
    add	w20,	w20,	#1
    cmp	w20,	#368
    blt	main_317

main_463:
    movz	w0,	#108
    bl	_sysy_stoptime
    movz	w0,	#4352
    add	x1,	sp,	#16
    movk	w0,	#2,	lsl #16
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#18336
    movk	fp,	#8,	lsl #16
    add	sp, sp, fp
    ret


