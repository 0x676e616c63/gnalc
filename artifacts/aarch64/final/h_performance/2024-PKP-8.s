.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global input
.align	2
input:
.type input, %object
    .zero	16000000

.global conv_output
.align	2
conv_output:
.type conv_output, %object
    .zero	16000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
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
    movz	w6,	#0
    add	x27,	sp,	#16
    add	x0,	sp,	#916
    adrp	x4, :got:conv_output
    adrp	x26, :got:input
    ldr	x26, [x26, #:got_lo12:input]
    ldr	x4, [x4, #:got_lo12:conv_output]

main_12:
    movz	w23,	#8000
    movz	w5,	#0
    madd	x18,	x6,	x23,	x4


main_16:
    movz	w11,	#0
    movi	v14.4s,	#0

main_19:
    add	w20,	w11,	w6
    movz	w17,	#8000
    lsl	w15,	w11,	#6
    lsl	w16,	w5,	#2
    add	w10,	w5,	#2
    add	w7,	w5,	#4
    madd	x21,	x20,	x17,	x26

    sub	w24,	w15,	w11,	lsl #2
    add	w20,	w5,	#3
    add	w11,	w11,	#1
    lsl	w13,	w10,	#2
    lsl	w9,	w7,	#2
    add	x15,	x21,	x16
    add	x2,	x27,	x24
    lsl	w23,	w20,	#2
    add	x12,	x21,	x13
    add	x8,	x21,	x9
    add	w16,	w5,	#5
    ldr	s19,	[x15]

    add	w24,	w5,	#1
    add	x3,	x2,	#4
    add	x22,	x21,	x23
    add	w13,	w5,	#7
    add	w9,	w5,	#9
    lsl	w19,	w16,	#2
    add	x15,	x2,	#8
    ldr	s3,	[x2]

    lsl	w28,	w24,	#2
    add	w23,	w5,	#8
    add	x17,	x21,	x19
    fmul	s4,	s19,	s3
    add	x25,	x21,	x28
    add	w19,	w5,	#10
    fadd	s14,	s14,	s4
    add	w28,	w5,	#6
    ldr	s9,	[x25]

    add	x25,	x2,	#12
    ldr	s29,	[x3]

    lsl	w3,	w28,	#2
    ldr	s18,	[x12]

    fmul	s30,	s9,	s29
    add	x12,	x2,	#16
    ldr	s6,	[x15]

    add	x1,	x21,	x3
    fadd	s24,	s14,	s30
    lsl	w15,	w13,	#2
    ldr	s26,	[x22]

    fmul	s7,	s18,	s6
    add	w3,	w5,	#11
    add	x14,	x21,	x15
    add	x22,	x2,	#20
    ldr	s14,	[x25]

    fadd	s1,	s24,	s7
    add	w15,	w5,	#12
    lsl	w25,	w23,	#2
    ldr	s3,	[x8]

    fmul	s15,	s26,	s14
    add	x8,	x2,	#24
    ldr	s22,	[x12]

    add	x24,	x21,	x25
    fadd	s10,	s1,	s15
    lsl	w12,	w9,	#2
    ldr	s11,	[x17]

    fmul	s23,	s3,	s22
    add	w25,	w5,	#13
    add	x10,	x21,	x12
    add	x17,	x2,	#28
    ldr	s30,	[x22]

    fadd	s18,	s10,	s23
    add	w12,	w5,	#14
    lsl	w22,	w19,	#2
    ldr	s20,	[x1]

    fmul	s31,	s11,	s30
    add	x1,	x2,	#32
    ldr	s7,	[x8]

    add	x20,	x21,	x22
    fadd	s28,	s18,	s31
    lsl	w8,	w3,	#2
    fmul	s8,	s20,	s7
    add	x3,	x2,	#56
    add	x7,	x21,	x8
    fadd	s5,	s28,	s8
    ldr	s28,	[x14]

    add	x14,	x2,	#36
    ldr	s15,	[x17]

    lsl	w17,	w15,	#2
    fmul	s16,	s28,	s15
    fadd	s14,	s5,	s16
    add	x16,	x21,	x17
    ldr	s5,	[x24]

    add	x24,	x2,	#40
    ldr	s23,	[x1]

    lsl	w1,	w25,	#2
    ldr	s13,	[x10]

    fmul	s24,	s5,	s23
    add	x10,	x2,	#44
    ldr	s31,	[x14]

    add	x28,	x21,	x1
    fadd	s23,	s14,	s24
    lsl	w14,	w12,	#2
    ldr	s22,	[x20]

    fmul	s1,	s13,	s31
    add	x20,	x2,	#48
    ldr	s8,	[x24]

    fadd	s1,	s23,	s1
    ldr	s30,	[x7]

    fmul	s9,	s22,	s8
    add	x7,	x2,	#52
    ldr	s16,	[x10]

    fadd	s9,	s1,	s9
    ldr	s7,	[x16]

    fmul	s17,	s30,	s16
    add	x16,	x21,	x14
    ldr	s24,	[x20]

    fadd	s18,	s9,	s17
    ldr	s16,	[x28]

    fmul	s25,	s7,	s24
    ldr	s1,	[x7]

    fadd	s28,	s18,	s25
    ldr	s24,	[x16]

    fmul	s2,	s16,	s1
    ldr	s9,	[x3]

    fadd	s5,	s28,	s2
    fmul	s10,	s24,	s9
    fadd	s14,	s5,	s10
    cmp	w11,	#15
    blt	main_19

main_131:
    lsl	w14,	w5,	#2
    add	w5,	w5,	#1
    add	x13,	x18,	x14
    str	s14,	[x13]

    cmp	w5,	#1986
    blt	main_16

main_135:
    add	w6,	w6,	#1
    cmp	w6,	#1986
    blt	main_12

main_138:
    movz	w10,	#0

main_140:
    movz	w19,	#8000
    movz	w25,	#0
    madd	x7,	x10,	x19,	x26


main_144:
    movz	w14,	#0
    movi	v18.4s,	#0

main_147:
    add	w12,	w14,	w10
    movz	w9,	#8000
    lsl	w17,	w14,	#6
    add	w24,	w25,	#1
    add	w21,	w25,	#3
    add	w5,	w25,	#4
    madd	x12,	x12,	x9,	x4

    sub	w17,	w17,	w14,	lsl #2
    lsl	w1,	w24,	#2
    add	w9,	w25,	#2
    lsl	w23,	w21,	#2
    lsl	w8,	w5,	#2
    add	w14,	w14,	#1
    add	x18,	x27,	x17
    add	x28,	x12,	x1
    lsl	w13,	w9,	#2
    add	x22,	x12,	x23
    add	x6,	x12,	x8
    lsl	w17,	w25,	#2
    add	x3,	x18,	#4
    add	w1,	w25,	#6
    add	x11,	x12,	x13
    add	w23,	w25,	#8
    add	w8,	w25,	#9
    add	x16,	x12,	x17
    add	w13,	w25,	#7
    add	w17,	w25,	#5
    ldr	s6,	[x16]

    lsl	w20,	w17,	#2
    add	x16,	x18,	#8
    ldr	s17,	[x18]

    add	x19,	x12,	x20
    ldr	s24,	[x28]

    fmul	s19,	s6,	s17
    add	w20,	w25,	#10
    add	x28,	x18,	#12
    ldr	s8,	[x3]

    fadd	s7,	s18,	s19
    ldr	s1,	[x11]

    lsl	w3,	w1,	#2
    fmul	s9,	s24,	s8
    add	x11,	x18,	#16
    ldr	s16,	[x16]

    add	x2,	x12,	x3
    fadd	s18,	s7,	s9
    lsl	w16,	w13,	#2
    fmul	s17,	s1,	s16
    add	w3,	w25,	#11
    ldr	s9,	[x22]

    add	x15,	x12,	x16
    fadd	s26,	s18,	s17
    add	x22,	x18,	#20
    ldr	s24,	[x28]

    add	w16,	w25,	#12
    lsl	w28,	w23,	#2
    ldr	s18,	[x6]

    fmul	s25,	s9,	s24
    add	x24,	x12,	x28
    add	x6,	x18,	#24
    ldr	s1,	[x11]

    fadd	s5,	s26,	s25
    add	w28,	w25,	#13
    lsl	w11,	w8,	#2
    fmul	s2,	s18,	s1
    ldr	s26,	[x19]

    add	x9,	x12,	x11
    fadd	s13,	s5,	s2
    add	x19,	x18,	#28
    ldr	s9,	[x22]

    add	w11,	w25,	#14
    lsl	w22,	w20,	#2
    ldr	s3,	[x2]

    fmul	s10,	s26,	s9
    add	x21,	x12,	x22
    add	x2,	x18,	#32
    ldr	s17,	[x6]

    fadd	s22,	s13,	s10
    lsl	w6,	w3,	#2
    ldr	s11,	[x15]

    fmul	s18,	s3,	s17
    add	x15,	x18,	#36
    ldr	s25,	[x19]

    add	x5,	x12,	x6
    fadd	s30,	s22,	s18
    lsl	w19,	w16,	#2
    ldr	s20,	[x24]

    fmul	s26,	s11,	s25
    add	x17,	x12,	x19
    add	x24,	x18,	#40
    ldr	s2,	[x2]

    fadd	s9,	s30,	s26
    lsl	w2,	w28,	#2
    ldr	s28,	[x9]

    fmul	s3,	s20,	s2
    add	x9,	x18,	#44
    ldr	s10,	[x15]

    add	x1,	x12,	x2
    fadd	s17,	s9,	s3
    lsl	w15,	w11,	#2
    ldr	s5,	[x21]

    fmul	s11,	s28,	s10
    add	x6,	x12,	x15
    add	x21,	x18,	#48
    ldr	s18,	[x24]

    fadd	s26,	s17,	s11
    add	x15,	x18,	#56
    ldr	s13,	[x5]

    fmul	s19,	s5,	s18
    add	x5,	x18,	#52
    fadd	s3,	s26,	s19
    ldr	s26,	[x9]

    ldr	s22,	[x17]

    fmul	s27,	s13,	s26
    fadd	s13,	s3,	s27
    ldr	s3,	[x21]

    ldr	s30,	[x1]

    fmul	s4,	s22,	s3
    ldr	s11,	[x5]

    fadd	s21,	s13,	s4
    ldr	s7,	[x6]

    fmul	s12,	s30,	s11
    ldr	s19,	[x15]

    fadd	s30,	s21,	s12
    fmul	s20,	s7,	s19
    fadd	s18,	s30,	s20
    cmp	w14,	#15
    blt	main_147

main_259:
    lsl	w16,	w25,	#2
    add	w25,	w25,	#1
    add	x15,	x7,	x16
    str	s18,	[x15]

    cmp	w25,	#1972
    blt	main_144

main_263:
    add	w10,	w10,	#1
    cmp	w10,	#1972
    blt	main_140

main_266:
    movz	w14,	#0
    movz	w6,	#0

main_268:
    movz	w5,	#8000
    movz	w12,	#1972
    movz	w1,	#0
    movz	w17,	#0
    madd	x28,	x6,	x5,	x26

    madd	x3,	x14,	x12,	x0


main_274:
    lsl	w10,	w17,	#2
    movz	w22,	#0
    add	x9,	x28,	x10
    ldr	s24,	[x9]


main_280:
    add	w16,	w22,	w6
    movz	w21,	#8000
    lsl	w15,	w17,	#2
    madd	x24,	x16,	x21,	x26

    add	x13,	x24,	x15
    ldr	s2,	[x13]

    fcmp	s24,	s2
    add	w20,	w17,	#1
    fcsel	s4,	s24,	s2,	gt
    lsl	w23,	w20,	#2
    add	x21,	x24,	x23
    ldr	s17,	[x21]

    fcmp	s4,	s17
    add	w2,	w17,	#2
    fcsel	s10,	s4,	s17,	gt
    lsl	w5,	w2,	#2
    add	x4,	x24,	x5
    ldr	s23,	[x4]

    fcmp	s10,	s23
    add	w10,	w17,	#3
    fcsel	s16,	s10,	s23,	gt
    lsl	w12,	w10,	#2
    add	x11,	x24,	x12
    ldr	s29,	[x11]

    fcmp	s16,	s29
    add	w22,	w22,	#1
    fcsel	s24,	s16,	s29,	gt
    cmp	w22,	#4
    blt	main_280

main_306:
    lsl	w22,	w1,	#2
    add	w17,	w17,	#4
    add	w1,	w1,	#1
    add	x21,	x3,	x22
    str	s24,	[x21]

    cmp	w1,	#493
    blt	main_274

main_311:
    add	w14,	w14,	#1
    add	w6,	w6,	#4
    cmp	w14,	#493
    blt	main_268

main_315:
    movz	w11,	#0

main_317:
    movz	w28,	#1972
    movz	w22,	#0
    madd	x7,	x11,	x28,	x0


main_320:
    cmp	w22,	#488
    blt	main_323

main_462:
    lsl	w2,	w22,	#2
    fmov	s21,	#1.000000
    fmov	s20,	#2.000000
    fmov	s19,	#6.000000
    fmov	s18,	#24.000000
    add	w22,	w22,	#1
    add	x1,	x7,	x2
    ldr	s4,	[x1]

    fneg	s1,	s4
    fmul	s8,	s1,	s1
    fadd	s7,	s21,	s1
    fmul	s14,	s8,	s1
    fdiv	s20,	s8,	s20
    fmul	s17,	s14,	s1
    fdiv	s23,	s14,	s19
    fadd	s13,	s7,	s20
    fdiv	s26,	s17,	s18
    fadd	s16,	s13,	s23
    fmov	s17,	#1.000000
    fadd	s20,	s16,	s26
    fmov	s16,	#1.000000
    fadd	s21,	s17,	s20
    fdiv	s29,	s16,	s21
    fmul	s30,	s4,	s29
    str	s30,	[x1]

    cmp	w22,	#493
    blt	main_462

main_482:
    add	w11,	w11,	#1
    cmp	w11,	#493
    blt	main_317

main_485:
    movz	w0,	#108
    bl	_sysy_stoptime
    movz	w0,	#46441
    add	x1,	sp,	#916
    movk	w0,	#3,	lsl #16
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#55616
    movk	fp,	#14,	lsl #16
    add	sp, sp, fp
    ret


main_323:
    lsl	w27,	w22,	#2
    fmov	s18,	#1.000000
    fmov	s17,	#2.000000
    fmov	s16,	#6.000000
    fmov	s15,	#24.000000
    fmov	s13,	#1.000000
    add	w10,	w22,	#1
    fmov	s10,	#2.000000
    fmov	s6,	#1.000000
    fmov	s2,	#6.000000
    add	x26,	x7,	x27
    add	w3,	w10,	#1
    lsl	w27,	w10,	#2
    ldr	s3,	[x26]

    add	w25,	w3,	#1
    lsl	w19,	w3,	#2
    fneg	s1,	s3
    add	x18,	x7,	x19
    fmul	s5,	s1,	s1
    lsl	w10,	w25,	#2
    fadd	s4,	s18,	s1
    fmul	s8,	s5,	s1
    fdiv	s11,	s5,	s17
    add	x9,	x7,	x10
    fmul	s9,	s8,	s1
    fdiv	s14,	s8,	s16
    fadd	s7,	s4,	s11
    fdiv	s17,	s9,	s15
    fadd	s11,	s7,	s14
    fmov	s9,	#6.000000
    fmov	s7,	#1.000000
    fmov	s14,	#1.000000
    fadd	s11,	s11,	s17
    fadd	s12,	s14,	s11
    fmov	s11,	#1.000000
    fdiv	s20,	s13,	s12
    fmul	s21,	s3,	s20
    fmov	s3,	#2.000000
    str	s21,	[x26]

    fmov	s21,	#1.000000
    add	x26,	x7,	x27
    ldr	s12,	[x26]

    fneg	s8,	s12
    fmul	s24,	s8,	s8
    fadd	s23,	s11,	s8
    fmul	s28,	s24,	s8
    fdiv	s29,	s24,	s10
    fdiv	s1,	s28,	s9
    fadd	s27,	s23,	s29
    fmul	s28,	s28,	s8
    fmov	s23,	#1.000000
    fadd	s31,	s27,	s1
    fmov	s8,	#24.000000
    fmov	s27,	#2.000000
    fmov	s1,	#24.000000
    fdiv	s4,	s28,	s8
    fmov	s28,	#1.000000
    fadd	s30,	s31,	s4
    fmov	s4,	#1.000000
    fadd	s31,	s7,	s30
    fmov	s30,	#1.000000
    fdiv	s7,	s6,	s31
    fmov	s31,	#1.000000
    fmul	s8,	s12,	s7
    str	s8,	[x26]

    ldr	s11,	[x18]

    fneg	s24,	s11
    fmul	s9,	s24,	s24
    fadd	s14,	s4,	s24
    fmul	s17,	s9,	s24
    fdiv	s16,	s9,	s3
    fdiv	s19,	s17,	s2
    fadd	s16,	s14,	s16
    fmov	s14,	#1.000000
    fadd	s20,	s16,	s19
    fmul	s16,	s17,	s24
    fmov	s24,	#1.000000
    fdiv	s22,	s16,	s1
    fmov	s16,	#1.000000
    fadd	s17,	s20,	s22
    fmov	s20,	#2.000000
    fadd	s18,	s31,	s17
    fmov	s17,	#1.000000
    fdiv	s25,	s30,	s18
    fmov	s18,	#24.000000
    fmul	s26,	s11,	s25
    fmov	s25,	#24.000000
    str	s26,	[x18]

    add	w18,	w25,	#1
    fmov	s26,	#6.000000
    ldr	s19,	[x9]

    fneg	s1,	s19
    add	w10,	w18,	#1
    lsl	w1,	w18,	#2
    fmul	s4,	s1,	s1
    fadd	s2,	s28,	s1
    add	x28,	x7,	x1
    fmul	s7,	s4,	s1
    add	w3,	w10,	#1
    lsl	w21,	w10,	#2
    fdiv	s3,	s4,	s27
    fdiv	s6,	s7,	s26
    add	x20,	x7,	x21
    fadd	s5,	s2,	s3
    add	w25,	w3,	#1
    lsl	w13,	w3,	#2
    fmov	s2,	#1.000000
    fmul	s3,	s7,	s1
    fadd	s10,	s5,	s6
    add	x12,	x7,	x13
    add	w22,	w25,	#1
    lsl	w3,	w25,	#2
    fdiv	s9,	s3,	s25
    add	x2,	x7,	x3
    fadd	s5,	s10,	s9
    fmov	s10,	#1.000000
    fadd	s6,	s24,	s5
    fmov	s5,	#6.000000
    fdiv	s12,	s23,	s6
    fmov	s6,	#2.000000
    fmul	s13,	s19,	s12
    fmov	s19,	#6.000000
    str	s13,	[x9]

    fmov	s13,	#2.000000
    ldr	s11,	[x28]

    fneg	s7,	s11
    fmul	s23,	s7,	s7
    fadd	s22,	s21,	s7
    fmul	s26,	s23,	s7
    fdiv	s21,	s23,	s20
    fdiv	s24,	s26,	s19
    fadd	s25,	s22,	s21
    fmul	s22,	s26,	s7
    fadd	s29,	s25,	s24
    fmov	s7,	#1.000000
    fdiv	s27,	s22,	s18
    fadd	s24,	s29,	s27
    fmov	s27,	#1.000000
    fadd	s25,	s17,	s24
    fdiv	s30,	s16,	s25
    fmul	s31,	s11,	s30
    str	s31,	[x28]

    ldr	s24,	[x20]

    fneg	s30,	s24
    fmul	s12,	s30,	s30
    fadd	s11,	s14,	s30
    fmul	s16,	s12,	s30
    fdiv	s8,	s12,	s13
    fmul	s9,	s16,	s30
    fmov	s12,	#6.000000
    fadd	s15,	s11,	s8
    fdiv	s11,	s16,	s12
    fadd	s19,	s15,	s11
    fmov	s11,	#24.000000
    fdiv	s14,	s9,	s11
    fmov	s9,	#1.000000
    fadd	s12,	s19,	s14
    fadd	s13,	s10,	s12
    fdiv	s17,	s9,	s13
    fmul	s18,	s24,	s17
    str	s18,	[x20]

    ldr	s23,	[x12]

    fneg	s20,	s23
    fmul	s1,	s20,	s20
    fadd	s31,	s7,	s20
    fmul	s4,	s1,	s20
    fdiv	s26,	s1,	s6
    fmul	s28,	s4,	s20
    fdiv	s29,	s4,	s5
    fadd	s3,	s31,	s26
    fmov	s4,	#24.000000
    fadd	s8,	s3,	s29
    fdiv	s1,	s28,	s4
    fmov	s29,	#6.000000
    fmov	s3,	#1.000000
    fmov	s28,	#24.000000
    fadd	s30,	s8,	s1
    fadd	s31,	s3,	s30
    fmov	s30,	#2.000000
    fdiv	s4,	s2,	s31
    fmov	s31,	#1.000000
    fmul	s5,	s23,	s4
    str	s5,	[x12]

    ldr	s6,	[x2]

    fneg	s10,	s6
    fmul	s20,	s10,	s10
    fadd	s19,	s31,	s10
    fmul	s23,	s20,	s10
    fdiv	s13,	s20,	s30
    fmul	s15,	s23,	s10
    fdiv	s16,	s23,	s29
    fadd	s22,	s19,	s13
    fdiv	s19,	s15,	s28
    fadd	s26,	s22,	s16
    fadd	s17,	s26,	s19
    fmov	s26,	#1.000000
    fadd	s18,	s27,	s17
    fdiv	s22,	s26,	s18
    fmul	s23,	s6,	s22
    str	s23,	[x2]

    b	main_320

