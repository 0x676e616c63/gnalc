.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global input
.align	2
input:
    .zero	4000000

.global conv_output
.align	2
conv_output:
    .zero	4000000


.text

.globl main
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
    add	x26,	sp,	#16
    adrp	x4, :got:conv_output
    adrp	x22, :got:input
    movk	fp,	#3,	lsl #16
    ldr	x22, [x22, #:got_lo12:input]
    add	x20,	sp,	fp
    ldr	x4, [x4, #:got_lo12:conv_output]

main_12:
    movz	w8,	#4000
    movz	w27,	#0
    madd	x5,	x6,	x8,	x4


main_16:
    movz	w8,	#0
    movi	v14.4s,	#0

main_19:
    add	w15,	w8,	w6
    movz	w28,	#4000
    lsl	w12,	w27,	#2
    add	w19,	w27,	#1
    add	w3,	w27,	#2
    add	w0,	w27,	#4
    madd	x16,	x15,	x28,	x22

    lsl	w23,	w19,	#2
    add	x11,	x16,	x12
    lsl	w9,	w3,	#2
    lsl	w2,	w0,	#2
    lsl	w15,	w8,	#6
    add	w12,	w27,	#5
    ldr	s17,	[x11]

    add	x7,	x16,	x9
    add	x1,	x16,	x2
    sub	w21,	w15,	w8,	lsl #2
    lsl	w14,	w12,	#2
    add	w9,	w27,	#7
    add	w2,	w27,	#9
    add	w8,	w8,	#1
    add	w15,	w27,	#3
    add	x28,	x20,	x21
    add	x13,	x16,	x14
    add	x21,	x16,	x23
    add	w14,	w27,	#10
    add	w23,	w27,	#6
    add	x25,	x28,	#4
    add	x11,	x28,	#8
    lsl	w18,	w15,	#2
    ldr	s1,	[x28]

    ldr	s7,	[x21]

    fmul	s2,	s17,	s1
    add	x17,	x16,	x18
    add	x21,	x28,	#12
    ldr	s27,	[x25]

    fadd	s12,	s14,	s2
    add	w18,	w27,	#8
    lsl	w25,	w23,	#2
    ldr	s16,	[x7]

    fmul	s28,	s7,	s27
    add	x24,	x16,	x25
    add	x7,	x28,	#16
    ldr	s4,	[x11]

    fadd	s22,	s12,	s28
    add	w25,	w27,	#11
    lsl	w11,	w9,	#2
    ldr	s24,	[x17]

    fmul	s5,	s16,	s4
    add	x10,	x16,	x11
    add	x17,	x28,	#20
    ldr	s12,	[x21]

    fadd	s30,	s22,	s5
    add	w11,	w27,	#12
    lsl	w21,	w18,	#2
    ldr	s1,	[x1]

    fmul	s13,	s24,	s12
    add	x19,	x16,	x21
    add	x1,	x28,	#24
    ldr	s20,	[x7]

    fadd	s8,	s30,	s13
    add	w21,	w27,	#13
    lsl	w7,	w2,	#2
    ldr	s9,	[x13]

    fmul	s21,	s1,	s20
    add	x3,	x16,	x7
    add	x13,	x28,	#28
    ldr	s28,	[x17]

    fadd	s16,	s8,	s21
    add	w7,	w27,	#14
    lsl	w17,	w14,	#2
    ldr	s18,	[x24]

    fmul	s29,	s9,	s28
    add	x15,	x16,	x17
    add	x24,	x28,	#32
    ldr	s5,	[x1]

    fadd	s26,	s16,	s29
    lsl	w1,	w25,	#2
    fmul	s6,	s18,	s5
    fadd	s3,	s26,	s6
    add	x0,	x16,	x1
    ldr	s26,	[x10]

    add	x10,	x28,	#36
    ldr	s13,	[x13]

    lsl	w13,	w11,	#2
    fmul	s14,	s26,	s13
    fadd	s12,	s3,	s14
    add	x12,	x16,	x13
    ldr	s3,	[x19]

    add	x19,	x28,	#40
    ldr	s21,	[x24]

    lsl	w24,	w21,	#2
    ldr	s11,	[x3]

    fmul	s22,	s3,	s21
    add	x3,	x28,	#44
    ldr	s29,	[x10]

    add	x23,	x16,	x24
    fadd	s20,	s12,	s22
    lsl	w10,	w7,	#2
    fmul	s30,	s11,	s29
    fadd	s30,	s20,	s30
    ldr	s20,	[x15]

    add	x15,	x28,	#48
    ldr	s6,	[x19]

    ldr	s28,	[x0]

    fmul	s7,	s20,	s6
    add	x0,	x28,	#52
    ldr	s14,	[x3]

    fadd	s7,	s30,	s7
    ldr	s5,	[x12]

    fmul	s15,	s28,	s14
    add	x12,	x16,	x10
    ldr	s22,	[x15]

    fadd	s16,	s7,	s15
    ldr	s13,	[x23]

    fmul	s23,	s5,	s22
    ldr	s30,	[x0]

    fadd	s24,	s16,	s23
    add	x0,	x28,	#56
    ldr	s22,	[x12]

    fmul	s31,	s13,	s30
    fadd	s3,	s24,	s31
    ldr	s7,	[x0]

    fmul	s8,	s22,	s7
    fadd	s14,	s3,	s8
    cmp	w8,	#15
    blt	main_19

main_131:
    lsl	w11,	w27,	#2
    add	w27,	w27,	#1
    add	x10,	x5,	x11
    str	s14,	[x10]

    cmp	w27,	#36
    blt	main_16

main_135:
    add	w6,	w6,	#1
    cmp	w6,	#36
    blt	main_12

main_138:
    movz	w11,	#0

main_140:
    movz	w9,	#4000
    movz	w2,	#0
    madd	x5,	x11,	x9,	x22


main_144:
    movz	w12,	#0
    movi	v18.4s,	#0

main_147:
    add	w8,	w12,	w11
    movz	w21,	#4000
    lsl	w18,	w12,	#6
    add	w24,	w2,	#1
    add	w7,	w2,	#2
    add	w19,	w2,	#3
    add	w1,	w2,	#4
    madd	x9,	x8,	x21,	x4

    sub	w15,	w18,	w12,	lsl #2
    lsl	w27,	w24,	#2
    lsl	w10,	w7,	#2
    lsl	w23,	w19,	#2
    lsl	w6,	w1,	#2
    add	w12,	w12,	#1
    add	x16,	x20,	x15
    add	x25,	x9,	x27
    add	x8,	x9,	x10
    add	x21,	x9,	x23
    add	x3,	x9,	x6
    lsl	w15,	w2,	#2
    add	x0,	x16,	#4
    add	w27,	w2,	#6
    add	w10,	w2,	#7
    add	w23,	w2,	#8
    add	w6,	w2,	#9
    add	x14,	x9,	x15
    add	w15,	w2,	#5
    ldr	s4,	[x14]

    lsl	w18,	w15,	#2
    add	x14,	x16,	#8
    ldr	s15,	[x16]

    add	x17,	x9,	x18
    ldr	s22,	[x25]

    fmul	s16,	s4,	s15
    add	w18,	w2,	#10
    add	x25,	x16,	#12
    ldr	s6,	[x0]

    fadd	s5,	s18,	s16
    lsl	w0,	w27,	#2
    ldr	s30,	[x8]

    fmul	s7,	s22,	s6
    add	x28,	x9,	x0
    add	x8,	x16,	#16
    ldr	s14,	[x14]

    fadd	s13,	s5,	s7
    add	w0,	w2,	#11
    lsl	w14,	w10,	#2
    fmul	s15,	s30,	s14
    ldr	s7,	[x21]

    add	x13,	x9,	x14
    fadd	s24,	s13,	s15
    add	x21,	x16,	#20
    ldr	s22,	[x25]

    add	w14,	w2,	#12
    lsl	w25,	w23,	#2
    ldr	s15,	[x3]

    fmul	s23,	s7,	s22
    add	x24,	x9,	x25
    add	x3,	x16,	#24
    ldr	s30,	[x8]

    fadd	s1,	s24,	s23
    add	w25,	w2,	#13
    lsl	w8,	w6,	#2
    fmul	s31,	s15,	s30
    ldr	s24,	[x17]

    add	x7,	x9,	x8
    fadd	s11,	s1,	s31
    add	x17,	x16,	#28
    ldr	s7,	[x21]

    add	w8,	w2,	#14
    lsl	w21,	w18,	#2
    ldr	s1,	[x28]

    fmul	s8,	s24,	s7
    add	x19,	x9,	x21
    add	x28,	x16,	#32
    ldr	s15,	[x3]

    fadd	s20,	s11,	s8
    lsl	w3,	w0,	#2
    ldr	s9,	[x13]

    fmul	s16,	s1,	s15
    add	x13,	x16,	#36
    ldr	s23,	[x17]

    add	x1,	x9,	x3
    fadd	s28,	s20,	s16
    lsl	w17,	w14,	#2
    ldr	s17,	[x24]

    fmul	s24,	s9,	s23
    add	x15,	x9,	x17
    add	x24,	x16,	#40
    ldr	s31,	[x28]

    fadd	s6,	s28,	s24
    lsl	w28,	w25,	#2
    ldr	s26,	[x7]

    fmul	s1,	s17,	s31
    add	x7,	x16,	#44
    ldr	s8,	[x13]

    add	x27,	x9,	x28
    fadd	s15,	s6,	s1
    lsl	w13,	w8,	#2
    ldr	s3,	[x19]

    fmul	s9,	s26,	s8
    add	x3,	x9,	x13
    add	x19,	x16,	#48
    ldr	s16,	[x24]

    fadd	s24,	s15,	s9
    add	x13,	x16,	#56
    ldr	s11,	[x1]

    fmul	s17,	s3,	s16
    add	x1,	x16,	#52
    fadd	s1,	s24,	s17
    ldr	s24,	[x7]

    ldr	s20,	[x15]

    fmul	s25,	s11,	s24
    fadd	s11,	s1,	s25
    ldr	s1,	[x19]

    ldr	s28,	[x27]

    fmul	s2,	s20,	s1
    ldr	s9,	[x1]

    fadd	s19,	s11,	s2
    ldr	s5,	[x3]

    fmul	s10,	s28,	s9
    ldr	s17,	[x13]

    fadd	s28,	s19,	s10
    fmul	s18,	s5,	s17
    fadd	s18,	s28,	s18
    cmp	w12,	#15
    blt	main_147

main_259:
    lsl	w14,	w2,	#2
    add	w2,	w2,	#1
    add	x13,	x5,	x14
    str	s18,	[x13]

    cmp	w2,	#22
    blt	main_144

main_263:
    add	w11,	w11,	#1
    cmp	w11,	#22
    blt	main_140

main_266:
    movz	w13,	#0
    movz	w19,	#0

main_268:
    movz	w3,	#4000
    movz	w2,	#972
    movz	w7,	#0
    madd	x28,	x19,	x3,	x22

    madd	x27,	x13,	x2,	x26

    movz	w2,	#0

main_274:
    lsl	w5,	w2,	#2
    movz	w18,	#0
    add	x4,	x28,	x5
    ldr	s24,	[x4]


main_280:
    add	w12,	w18,	w19
    movz	w4,	#4000
    lsl	w10,	w2,	#2
    madd	x12,	x12,	x4,	x22

    add	x9,	x12,	x10
    ldr	s31,	[x9]

    fcmp	s24,	s31
    add	w15,	w2,	#1
    fcsel	s2,	s24,	s31,	gt
    lsl	w17,	w15,	#2
    add	x16,	x12,	x17
    ldr	s15,	[x16]

    fcmp	s2,	s15
    add	w24,	w2,	#2
    fcsel	s8,	s2,	s15,	gt
    lsl	w0,	w24,	#2
    add	x25,	x12,	x0
    ldr	s21,	[x25]

    fcmp	s8,	s21
    add	w5,	w2,	#3
    fcsel	s14,	s8,	s21,	gt
    lsl	w8,	w5,	#2
    add	x6,	x12,	x8
    ldr	s27,	[x6]

    fcmp	s14,	s27
    add	w18,	w18,	#1
    fcsel	s24,	s14,	s27,	gt
    cmp	w18,	#4
    blt	main_280

main_306:
    lsl	w17,	w7,	#2
    add	w2,	w2,	#4
    add	w7,	w7,	#1
    add	x16,	x27,	x17
    str	s24,	[x16]

    cmp	w7,	#5
    blt	main_274

main_311:
    add	w13,	w13,	#1
    add	w19,	w19,	#4
    cmp	w13,	#5
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
    madd	x2,	x20,	x28,	x26

    add	w20,	w20,	#1
    add	x18,	x2,	#16
    add	x13,	x2,	#8
    add	x24,	x2,	#4
    add	x3,	x2,	#12
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
    fmov	s22,	#1.000000
    fmov	s12,	#6.000000
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


