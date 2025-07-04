.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global input
.align	2
input:
.type input, %object
    .zero	9000000

.global conv_output
.align	2
conv_output:
.type conv_output, %object
    .zero	9000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
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
    movz	w1,	#0
    movz	w2,	#900
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
    adrp	x19, :got:conv_output
    add	x9,	sp,	#16
    adrp	x23, :got:input
    movk	fp,	#8,	lsl #16
    ldr	x23, [x23, #:got_lo12:input]
    add	x7,	sp,	fp
    ldr	x19, [x19, #:got_lo12:conv_output]

main_12:
    movz	w0,	#6000
    movz	w4,	#0
    madd	x16,	x6,	x0,	x19


main_16:
    movz	w11,	#0
    movi	v14.4s,	#0

main_19:
    add	w18,	w11,	w6
    movz	w21,	#6000
    lsl	w3,	w11,	#6
    lsl	w15,	w4,	#2
    add	w8,	w4,	#2
    add	w20,	w4,	#3
    add	w2,	w4,	#4
    madd	x21,	x18,	x21,	x23

    sub	w25,	w3,	w11,	lsl #2
    add	x14,	x21,	x15
    lsl	w12,	w8,	#2
    lsl	w24,	w20,	#2
    lsl	w5,	w2,	#2
    add	w11,	w11,	#1
    add	x0,	x7,	x25
    add	w15,	w4,	#5
    ldr	s18,	[x14]

    add	x10,	x21,	x12
    add	x22,	x21,	x24
    add	x3,	x21,	x5
    add	w25,	w4,	#1
    add	x1,	x0,	#4
    lsl	w18,	w15,	#2
    add	x14,	x0,	#8
    ldr	s2,	[x0]

    add	w12,	w4,	#7
    add	w24,	w4,	#8
    add	w5,	w4,	#9
    lsl	w27,	w25,	#2
    add	x17,	x21,	x18
    fmul	s3,	s18,	s2
    add	w18,	w4,	#10
    add	x26,	x21,	x27
    fadd	s13,	s14,	s3
    add	w27,	w4,	#6
    ldr	s8,	[x26]

    add	x26,	x0,	#12
    ldr	s28,	[x1]

    lsl	w1,	w27,	#2
    ldr	s17,	[x10]

    fmul	s29,	s8,	s28
    add	x10,	x0,	#16
    ldr	s5,	[x14]

    add	x28,	x21,	x1
    fadd	s23,	s13,	s29
    lsl	w14,	w12,	#2
    ldr	s25,	[x22]

    fmul	s6,	s17,	s5
    add	w1,	w4,	#11
    add	x13,	x21,	x14
    add	x22,	x0,	#20
    ldr	s13,	[x26]

    fadd	s31,	s23,	s6
    add	w14,	w4,	#12
    lsl	w26,	w24,	#2
    ldr	s2,	[x3]

    fmul	s14,	s25,	s13
    add	x3,	x0,	#24
    ldr	s21,	[x10]

    add	x25,	x21,	x26
    fadd	s9,	s31,	s14
    ldr	s10,	[x17]

    lsl	w10,	w5,	#2
    fmul	s22,	s2,	s21
    add	w26,	w4,	#13
    add	x17,	x0,	#28
    ldr	s29,	[x22]

    add	x8,	x21,	x10
    fadd	s17,	s9,	s22
    lsl	w22,	w18,	#2
    ldr	s19,	[x28]

    fmul	s30,	s10,	s29
    add	w10,	w4,	#14
    add	x20,	x21,	x22
    add	x28,	x0,	#32
    ldr	s6,	[x3]

    fadd	s27,	s17,	s30
    lsl	w3,	w1,	#2
    fmul	s7,	s19,	s6
    add	x1,	x0,	#56
    add	x2,	x21,	x3
    fadd	s4,	s27,	s7
    ldr	s27,	[x13]

    add	x13,	x0,	#36
    ldr	s14,	[x17]

    lsl	w17,	w14,	#2
    fmul	s15,	s27,	s14
    fadd	s13,	s4,	s15
    add	x15,	x21,	x17
    ldr	s4,	[x25]

    add	x25,	x0,	#40
    ldr	s22,	[x28]

    lsl	w28,	w26,	#2
    ldr	s12,	[x8]

    fmul	s23,	s4,	s22
    add	x8,	x0,	#44
    ldr	s30,	[x13]

    add	x27,	x21,	x28
    fadd	s21,	s13,	s23
    lsl	w13,	w10,	#2
    fmul	s31,	s12,	s30
    fadd	s31,	s21,	s31
    ldr	s21,	[x20]

    add	x20,	x0,	#48
    ldr	s7,	[x25]

    ldr	s29,	[x2]

    fmul	s8,	s21,	s7
    add	x2,	x0,	#52
    ldr	s15,	[x8]

    fadd	s8,	s31,	s8
    ldr	s6,	[x15]

    fmul	s16,	s29,	s15
    add	x15,	x21,	x13
    ldr	s23,	[x20]

    fadd	s17,	s8,	s16
    ldr	s14,	[x27]

    fmul	s24,	s6,	s23
    ldr	s31,	[x2]

    fadd	s26,	s17,	s24
    ldr	s23,	[x15]

    fmul	s1,	s14,	s31
    ldr	s8,	[x1]

    fadd	s4,	s26,	s1
    fmul	s9,	s23,	s8
    fadd	s14,	s4,	s9
    cmp	w11,	#15
    blt	main_19

main_131:
    lsl	w13,	w4,	#2
    add	w4,	w4,	#1
    add	x12,	x16,	x13
    str	s14,	[x12]

    cmp	w4,	#1486
    blt	main_16

main_135:
    add	w6,	w6,	#1
    cmp	w6,	#1486
    blt	main_12

main_138:
    movz	w10,	#0

main_140:
    movz	w26,	#6000
    movz	w25,	#0
    madd	x4,	x10,	x26,	x23


main_144:
    movz	w14,	#0
    movi	v18.4s,	#0

main_147:
    add	w8,	w14,	w10
    movz	w15,	#6000
    lsl	w5,	w14,	#6
    add	w26,	w25,	#1
    add	w6,	w25,	#2
    add	w21,	w25,	#3
    add	w2,	w25,	#4
    madd	x11,	x8,	x15,	x19

    sub	w16,	w5,	w14,	lsl #2
    lsl	w28,	w26,	#2
    lsl	w12,	w6,	#2
    lsl	w24,	w21,	#2
    add	w14,	w14,	#1
    lsl	w5,	w2,	#2
    add	x17,	x7,	x16
    add	x27,	x11,	x28
    add	x8,	x11,	x12
    add	x22,	x11,	x24
    add	x3,	x11,	x5
    lsl	w16,	w25,	#2
    add	x1,	x17,	#4
    add	w28,	w25,	#6
    add	w12,	w25,	#7
    add	w24,	w25,	#8
    add	w5,	w25,	#9
    add	x15,	x11,	x16
    add	w16,	w25,	#5
    ldr	s5,	[x15]

    lsl	w20,	w16,	#2
    add	x15,	x17,	#8
    ldr	s16,	[x17]

    add	x18,	x11,	x20
    ldr	s23,	[x27]

    fmul	s17,	s5,	s16
    add	w20,	w25,	#10
    add	x27,	x17,	#12
    ldr	s7,	[x1]

    fadd	s6,	s18,	s17
    lsl	w1,	w28,	#2
    ldr	s31,	[x8]

    fmul	s8,	s23,	s7
    add	x0,	x11,	x1
    add	x8,	x17,	#16
    ldr	s15,	[x15]

    fadd	s14,	s6,	s8
    add	w1,	w25,	#11
    lsl	w15,	w12,	#2
    fmul	s16,	s31,	s15
    ldr	s8,	[x22]

    add	x13,	x11,	x15
    fadd	s25,	s14,	s16
    add	x22,	x17,	#20
    ldr	s23,	[x27]

    add	w15,	w25,	#12
    lsl	w27,	w24,	#2
    ldr	s16,	[x3]

    fmul	s24,	s8,	s23
    add	x26,	x11,	x27
    add	x3,	x17,	#24
    ldr	s31,	[x8]

    fadd	s3,	s25,	s24
    add	w27,	w25,	#13
    lsl	w8,	w5,	#2
    fmul	s1,	s16,	s31
    ldr	s25,	[x18]

    add	x6,	x11,	x8
    fadd	s12,	s3,	s1
    add	x18,	x17,	#28
    ldr	s8,	[x22]

    add	w8,	w25,	#14
    lsl	w22,	w20,	#2
    ldr	s2,	[x0]

    fmul	s9,	s25,	s8
    add	x21,	x11,	x22
    add	x0,	x17,	#32
    ldr	s16,	[x3]

    fadd	s21,	s12,	s9
    lsl	w3,	w1,	#2
    ldr	s10,	[x13]

    fmul	s17,	s2,	s16
    add	x13,	x17,	#36
    ldr	s24,	[x18]

    add	x2,	x11,	x3
    fadd	s29,	s21,	s17
    ldr	s19,	[x26]

    lsl	w18,	w15,	#2
    fmul	s25,	s10,	s24
    add	x26,	x17,	#40
    ldr	s1,	[x0]

    add	x16,	x11,	x18
    fadd	s8,	s29,	s25
    lsl	w0,	w27,	#2
    ldr	s27,	[x6]

    fmul	s2,	s19,	s1
    add	x6,	x17,	#44
    ldr	s9,	[x13]

    add	x28,	x11,	x0
    fadd	s16,	s8,	s2
    lsl	w13,	w8,	#2
    ldr	s4,	[x21]

    fmul	s10,	s27,	s9
    add	x3,	x11,	x13
    add	x21,	x17,	#48
    ldr	s17,	[x26]

    fadd	s25,	s16,	s10
    add	x13,	x17,	#56
    ldr	s12,	[x2]

    fmul	s18,	s4,	s17
    add	x2,	x17,	#52
    fadd	s2,	s25,	s18
    ldr	s25,	[x6]

    ldr	s21,	[x16]

    fmul	s26,	s12,	s25
    fadd	s12,	s2,	s26
    ldr	s2,	[x21]

    ldr	s29,	[x28]

    fmul	s3,	s21,	s2
    ldr	s10,	[x2]

    fadd	s20,	s12,	s3
    ldr	s6,	[x3]

    fmul	s11,	s29,	s10
    ldr	s18,	[x13]

    fadd	s29,	s20,	s11
    fmul	s19,	s6,	s18
    fadd	s18,	s29,	s19
    cmp	w14,	#15
    blt	main_147

main_259:
    lsl	w15,	w25,	#2
    add	w25,	w25,	#1
    add	x14,	x4,	x15
    str	s18,	[x14]

    cmp	w25,	#1472
    blt	main_144

main_263:
    add	w10,	w10,	#1
    cmp	w10,	#1472
    blt	main_140

main_266:
    movz	w14,	#0
    movz	w6,	#0

main_268:
    movz	w13,	#6000
    movz	w12,	#1472
    movz	w1,	#0
    movz	w17,	#0
    madd	x27,	x6,	x13,	x23

    madd	x0,	x14,	x12,	x9


main_274:
    lsl	w8,	w17,	#2
    movz	w22,	#0
    add	x7,	x27,	x8
    ldr	s24,	[x7]


main_280:
    add	w15,	w22,	w6
    movz	w26,	#6000
    lsl	w13,	w17,	#2
    madd	x18,	x15,	x26,	x23

    add	x12,	x18,	x13
    ldr	s1,	[x12]

    fcmp	s24,	s1
    add	w19,	w17,	#1
    fcsel	s3,	s24,	s1,	gt
    lsl	w21,	w19,	#2
    add	x20,	x18,	x21
    ldr	s16,	[x20]

    fcmp	s3,	s16
    add	w28,	w17,	#2
    fcsel	s9,	s3,	s16,	gt
    lsl	w3,	w28,	#2
    add	x2,	x18,	x3
    ldr	s22,	[x2]

    fcmp	s9,	s22
    add	w8,	w17,	#3
    fcsel	s15,	s9,	s22,	gt
    lsl	w11,	w8,	#2
    add	x10,	x18,	x11
    ldr	s28,	[x10]

    fcmp	s15,	s28
    add	w22,	w22,	#1
    fcsel	s24,	s15,	s28,	gt
    cmp	w22,	#4
    blt	main_280

main_306:
    lsl	w21,	w1,	#2
    add	w17,	w17,	#4
    add	w1,	w1,	#1
    add	x20,	x0,	x21
    str	s24,	[x20]

    cmp	w1,	#368
    blt	main_274

main_311:
    add	w14,	w14,	#1
    add	w6,	w6,	#4
    cmp	w14,	#368
    blt	main_268

main_315:
    movz	w11,	#0

main_317:
    movz	w7,	#1472
    movz	w21,	#0
    madd	x8,	x11,	x7,	x9


main_320:
    cmp	w21,	#368
    blt	main_323

main_460:
    add	w11,	w11,	#1
    cmp	w11,	#368
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


main_323:
    lsl	w14,	w21,	#2
    fmov	s22,	#1.000000
    fmov	s21,	#2.000000
    fmov	s20,	#6.000000
    fmov	s19,	#24.000000
    fmov	s17,	#1.000000
    add	w23,	w21,	#1
    fmov	s14,	#2.000000
    fmov	s11,	#1.000000
    fmov	s10,	#1.000000
    fmov	s8,	#1.000000
    fmov	s4,	#1.000000
    add	x13,	x8,	x14
    lsl	w5,	w23,	#2
    add	w14,	w23,	#1
    add	x4,	x8,	x5
    ldr	s27,	[x13]

    lsl	w25,	w14,	#2
    add	w5,	w14,	#1
    fneg	s3,	s27
    add	x24,	x8,	x25
    fmul	s13,	s3,	s3
    add	w27,	w5,	#1
    lsl	w16,	w5,	#2
    fadd	s12,	s22,	s3
    fmul	s16,	s13,	s3
    add	x15,	x8,	x16
    fdiv	s22,	s13,	s21
    add	w18,	w27,	#1
    lsl	w5,	w27,	#2
    fdiv	s25,	s16,	s20
    fmov	s13,	#6.000000
    fadd	s15,	s12,	s22
    fmul	s20,	s16,	s3
    add	w10,	w18,	#1
    lsl	w25,	w18,	#2
    fadd	s18,	s15,	s25
    fdiv	s28,	s20,	s19
    fmov	s15,	#1.000000
    fadd	s22,	s18,	s28
    add	w2,	w10,	#1
    lsl	w16,	w10,	#2
    fmov	s18,	#1.000000
    fadd	s23,	s18,	s22
    add	w21,	w2,	#1
    fdiv	s31,	s17,	s23
    fmul	s1,	s27,	s31
    fmov	s31,	#2.000000
    str	s1,	[x13]

    ldr	s19,	[x4]

    fneg	s30,	s19
    fmul	s3,	s30,	s30
    fadd	s2,	s15,	s30
    fmul	s6,	s3,	s30
    fdiv	s9,	s3,	s14
    fmul	s7,	s6,	s30
    fdiv	s12,	s6,	s13
    fmov	s3,	#1.000000
    fadd	s5,	s2,	s9
    fmov	s6,	#6.000000
    fadd	s9,	s5,	s12
    fmov	s12,	#24.000000
    fdiv	s15,	s7,	s12
    fmov	s7,	#2.000000
    fadd	s9,	s9,	s15
    fadd	s11,	s11,	s9
    fdiv	s18,	s10,	s11
    fmul	s19,	s19,	s18
    str	s19,	[x4]

    add	x4,	x8,	x5
    ldr	s1,	[x24]

    lsl	w5,	w2,	#2
    fneg	s5,	s1
    fmul	s22,	s5,	s5
    fadd	s21,	s8,	s5
    fmul	s25,	s22,	s5
    fdiv	s27,	s22,	s7
    fmul	s26,	s25,	s5
    fdiv	s30,	s25,	s6
    fmov	s22,	#24.000000
    fadd	s24,	s21,	s27
    fmov	s5,	#24.000000
    fmov	s25,	#1.000000
    fmov	s21,	#1.000000
    fmov	s27,	#1.000000
    fadd	s29,	s24,	s30
    fdiv	s2,	s26,	s5
    fmov	s30,	#6.000000
    fadd	s28,	s29,	s2
    fadd	s29,	s4,	s28
    fmov	s28,	#1.000000
    fdiv	s5,	s3,	s29
    fmov	s29,	#24.000000
    fmul	s6,	s1,	s5
    fmov	s1,	#1.000000
    str	s6,	[x24]

    add	x24,	x8,	x25
    ldr	s12,	[x15]

    fneg	s18,	s12
    fmul	s6,	s18,	s18
    fadd	s11,	s1,	s18
    fmul	s9,	s6,	s18
    fdiv	s14,	s6,	s31
    fmul	s13,	s9,	s18
    fdiv	s17,	s9,	s30
    fadd	s14,	s11,	s14
    fmov	s18,	#1.000000
    fdiv	s20,	s13,	s29
    fadd	s17,	s14,	s17
    fmov	s13,	#1.000000
    fmov	s14,	#1.000000
    fadd	s15,	s17,	s20
    fmov	s17,	#2.000000
    fmov	s20,	#1.000000
    fadd	s16,	s28,	s15
    fdiv	s23,	s27,	s16
    fmov	s16,	#6.000000
    fmul	s24,	s12,	s23
    fmov	s23,	#6.000000
    str	s24,	[x15]

    add	x15,	x8,	x16
    fmov	s24,	#2.000000
    ldr	s15,	[x4]

    fneg	s29,	s15
    fmul	s2,	s29,	s29
    fadd	s31,	s25,	s29
    fmul	s5,	s2,	s29
    fdiv	s1,	s2,	s24
    fdiv	s4,	s5,	s23
    fmov	s2,	#6.000000
    fadd	s3,	s31,	s1
    fmov	s31,	#1.000000
    fmul	s1,	s5,	s29
    fadd	s8,	s3,	s4
    fdiv	s7,	s1,	s22
    fadd	s3,	s8,	s7
    fmov	s8,	#24.000000
    fadd	s4,	s21,	s3
    fmov	s3,	#2.000000
    fdiv	s10,	s20,	s4
    fmul	s11,	s15,	s10
    fmov	s15,	#24.000000
    str	s11,	[x4]

    add	x4,	x8,	x5
    fmov	s11,	#1.000000
    ldr	s10,	[x24]

    fneg	s26,	s10
    fmul	s21,	s26,	s26
    fadd	s20,	s18,	s26
    fmul	s24,	s21,	s26
    fdiv	s19,	s21,	s17
    fdiv	s22,	s24,	s16
    fadd	s23,	s20,	s19
    fmul	s20,	s24,	s26
    fadd	s27,	s23,	s22
    fdiv	s25,	s20,	s15
    fadd	s22,	s27,	s25
    fadd	s23,	s14,	s22
    fdiv	s28,	s13,	s23
    fmul	s29,	s10,	s28
    fmov	s10,	#2.000000
    str	s29,	[x24]

    ldr	s22,	[x15]

    fneg	s28,	s22
    fmul	s12,	s28,	s28
    fadd	s9,	s11,	s28
    fmul	s5,	s12,	s28
    fdiv	s6,	s12,	s10
    fmul	s7,	s5,	s28
    fadd	s4,	s9,	s6
    fdiv	s12,	s7,	s8
    fmov	s6,	#1.000000
    fmov	s9,	#6.000000
    fmov	s7,	#1.000000
    fdiv	s9,	s5,	s9
    fadd	s17,	s4,	s9
    fmov	s4,	#1.000000
    fadd	s10,	s17,	s12
    fadd	s11,	s7,	s10
    fdiv	s15,	s6,	s11
    fmul	s16,	s22,	s15
    str	s16,	[x15]

    ldr	s15,	[x4]

    fneg	s25,	s15
    fmul	s30,	s25,	s25
    fadd	s28,	s4,	s25
    fdiv	s24,	s30,	s3
    fmul	s3,	s30,	s25
    fadd	s1,	s28,	s24
    fmul	s26,	s3,	s25
    fdiv	s27,	s3,	s2
    fadd	s5,	s1,	s27
    fmov	s1,	#24.000000
    fdiv	s30,	s26,	s1
    fadd	s27,	s5,	s30
    fmov	s30,	#1.000000
    fadd	s28,	s31,	s27
    fdiv	s2,	s30,	s28
    fmul	s3,	s15,	s2
    str	s3,	[x4]

    b	main_320

