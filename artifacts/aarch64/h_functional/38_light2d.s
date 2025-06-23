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

    fmov	s22,	#4.000000
    fmov	s23,	#3.000000
    fmul	s13,	s22,	s0
    fmul	s24,	s23,	s0
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
    sub	sp, sp, #80
    stp	x22, fp, [sp, #0]
    str	lr, [sp, 16]
    stp	q8, q13, [sp, #32]
    str	q14, [sp, 64]

    movi	v27.4s,	#0
    fneg	s1,	s0
    fcmp	s0,	s27
    movz	w14,	#14269
    fcsel	s3,	s0,	s1,	gt
    cset	w16,	gt
    movk	w14,	#13702,	lsl #16
    fmov	s6,	w14
    fcmp	s3,	s6
    ble	my_sin_impl_26

my_sin_impl_6:
    fmov	s31,	#3.000000
    fneg	s13,	s0
    fmov	s17,	#3.000000
    movi	v16.4s,	#0
    fdiv	s24,	s0,	s31
    fdiv	s14,	s13,	s17
    fcmp	s24,	s16
    fcsel	s26,	s24,	s14,	gt
    cset	w22,	gt
    fcmp	s26,	s6
    ble	my_sin_impl_17

my_sin_impl_13:
    fmov	s8,	#3.000000
    fdiv	s0,	s24,	s8
    bl	my_sin_impl
    bl	p
    b	my_sin_impl_18

my_sin_impl_17:
    fmov	s0,	s24

my_sin_impl_18:
    fmov	s3,	#3.000000
    fmov	s2,	#4.000000
    fmul	s18,	s3,	s0
    fmul	s3,	s2,	s0
    fmul	s4,	s3,	s0
    fmul	s5,	s4,	s0
    fsub	s0,	s18,	s5

my_sin_impl_26:
    ldp	x22, fp, [sp, #0]
    ldr	lr, [sp, 16]
    ldp	q8, q13, [sp, #32]
    ldr	q14, [sp, 64]

    add	sp, sp, #80
    ret


.globl main
main:
main_0:
    sub	sp, sp, #80
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#80
    bl	putch
    movz	w0,	#50
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#192
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#192
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#255
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w26,	#0
    movz	w13,	#0
    add	x19,	sp,	#20
    add	x21,	sp,	#16
    str	w13,	[sp, #56]

    add	x20,	x21,	#4

main_7:
    ldr	w18,	[sp, #56]

    movz	w10,	#0
    movz	w2,	#0
    scvtf	s10,	w18
    movk	w10,	#17216,	lsl #16
    fmov	s11,	w10
    fmov	s15,	s11
    fdiv	s9,	s10,	s15
    str	s9,	[sp, #44]

    str	w2,	[sp, #60]


main_13:
    ldr	w27,	[sp, #60]

    movz	w25,	#0
    scvtf	s11,	w27
    fdiv	s6,	s11,	s15
    movi	v11.4s,	#0
    str	s6,	[sp, #52]

    fmov	s8,	s11

main_19:
    movz	w8,	#57186
    movz	w7,	#23333
    movz	w5,	#57607
    movz	w23,	#4059
    movk	w8,	#304,	lsl #16
    movk	w5,	#1525,	lsl #16
    movk	w23,	#49353,	lsl #16
    madd	w11,	w26,	w8,	w7

    mul	w3,	w26,	w8
    sdiv	w2,	w11,	w5
    msub	w6,	w2,	w5,	w11

    mul	w27,	w2,	w5
    add	w7,	w6,	w5
    cmp	w6,	#0
    movz	w9,	#4059
    fmov	s13,	#24.000000
    cset	w15,	lt
    csel	w28,	w7,	w6,	lt
    movz	w4,	#48161
    scvtf	s6,	w25
    movk	w9,	#16329,	lsl #16
    movz	w6,	#4059
    str	w28,	[sp, #64]

    movk	w4,	#19646,	lsl #16
    movk	w6,	#16585,	lsl #16
    ldr	w0,	[sp, #64]

    fmov	s17,	w4
    scvtf	s4,	w0
    fmov	s29,	w6
    fdiv	s9,	s4,	s17
    str	s29,	[sp, #28]

    fmov	s17,	w9
    fadd	s5,	s6,	s9
    ldr	s7,	[sp, #28]

    ldr	s16,	[sp, #28]

    fmul	s6,	s7,	s5
    fdiv	s9,	s6,	s13
    fadd	s2,	s9,	s17
    fcmp	s2,	s16
    bgt	main_41

main_37:
    fmov	s24,	w23
    fcmp	s2,	s24
    bge	main_48

main_41:
    ldr	s27,	[sp, #28]

    ldr	s26,	[sp, #28]

    fdiv	s1,	s2,	s27
    frintz	s16,	s1
    fcvtzs	w26,	s1
    fmul	s5,	s16,	s26
    fsub	s2,	s2,	s5

main_48:
    ldr	s11,	[sp, #28]

    movz	w28,	#4059
    fsub	s12,	s2,	s11
    movk	w28,	#16457,	lsl #16
    fmov	s14,	w28
    fcmp	s2,	s14
    fcsel	s13,	s12,	s2,	gt
    cset	w18,	gt
    movz	w26,	#4059
    str	s13,	[sp, #24]

    movk	w26,	#49225,	lsl #16
    ldr	s12,	[sp, #28]

    ldr	s10,	[sp, #24]

    fmov	s13,	w26
    fadd	s12,	s10,	s12
    fmov	s10,	s13
    str	s12,	[sp, #40]

    ldr	s13,	[sp, #24]

    fcmp	s13,	s10
    ldr	s12,	[sp, #24]

    cset	w18,	lt
    ldr	s13,	[sp, #40]

    fcsel	s0,	s13,	s12,	lt
    bl	my_sin_impl
    ldr	s20,	[sp, #28]

    fmov	s13,	s0
    fcmp	s9,	s20
    bgt	main_62

main_58:
    fmov	s17,	w23
    fcmp	s9,	s17
    blt	main_62

main_68:
    fmov	s12,	s9
    b	main_69

main_62:
    ldr	s23,	[sp, #28]

    ldr	s22,	[sp, #28]

    fdiv	s7,	s9,	s23
    frintz	s5,	s7
    fcvtzs	w17,	s7
    fmul	s17,	s5,	s22
    fsub	s27,	s9,	s17
    fmov	s12,	s27

main_69:
    ldr	s11,	[sp, #28]

    fsub	s9,	s12,	s11
    fcmp	s12,	s14
    fcsel	s14,	s9,	s12,	gt
    cset	w18,	gt
    fmov	s9,	s10
    ldr	s12,	[sp, #28]

    fadd	s12,	s14,	s12
    fcmp	s14,	s9
    fcsel	s0,	s12,	s14,	lt
    cset	w28,	lt
    bl	my_sin_impl
    movz	w26,	#0
    movi	v6.4s,	#0

main_78:
    cmp	w26,	#10
    bge	main_184

main_82:
    fmov	s12,	#2.000000
    fcmp	s6,	s12
    bge	main_185

main_84:
    fmul	s11,	s13,	s6
    ldr	s23,	[sp, #52]

    fmul	s17,	s0,	s6
    movz	w18,	#52429
    fmov	s19,	#2.000000
    fmov	s18,	#4.000000
    fmov	s10,	#2.000000
    movz	w13,	#52429
    movz	w15,	#39322
    fmov	s1,	#8.000000
    movz	w10,	#52429
    ldr	s27,	[sp, #44]

    fadd	s3,	s23,	s11
    movk	w18,	#16076,	lsl #16
    movk	w13,	#15820,	lsl #16
    movk	w15,	#16153,	lsl #16
    movk	w10,	#15692,	lsl #16
    fadd	s22,	s27,	s17
    fmov	s23,	#8.000000
    fmov	s24,	w18
    str	s22,	[sp, #36]

    fsub	s14,	s3,	s24
    fmov	s22,	#0.500000
    ldr	s17,	[sp, #36]

    fmul	s16,	s14,	s14
    fsub	s12,	s17,	s24
    fmov	s14,	#2.000000
    fmul	s17,	s12,	s12
    fadd	s4,	s16,	s17
    fdiv	s23,	s4,	s23
    fmul	s31,	s19,	s4
    fadd	s2,	s18,	s4
    fmov	s17,	#2.000000
    fmov	s16,	#2.000000
    fadd	s30,	s23,	s22
    fdiv	s19,	s31,	s2
    fadd	s2,	s30,	s19
    fdiv	s22,	s4,	s2
    fadd	s26,	s2,	s22
    fdiv	s9,	s26,	s17
    fdiv	s27,	s4,	s9
    fadd	s29,	s9,	s27
    fdiv	s12,	s29,	s16
    fdiv	s31,	s4,	s12
    fadd	s2,	s12,	s31
    fmov	s31,	#0.500000
    fmov	s12,	#2.000000
    fdiv	s17,	s2,	s14
    fdiv	s5,	s4,	s17
    fadd	s9,	s17,	s5
    fmov	s5,	w15
    fmov	s17,	#2.000000
    fdiv	s14,	s9,	s12
    fsub	s27,	s3,	s5
    fmov	s9,	w13
    fmov	s12,	#2.000000
    fdiv	s11,	s4,	s14
    fmul	s29,	s27,	s27
    fadd	s14,	s14,	s11
    fmov	s27,	#2.000000
    fmov	s11,	#2.000000
    fdiv	s18,	s14,	s11
    fmov	s11,	#2.000000
    fdiv	s16,	s4,	s18
    fadd	s16,	s18,	s16
    fdiv	s21,	s16,	s17
    fmov	s16,	#2.000000
    fdiv	s19,	s4,	s21
    fadd	s20,	s21,	s19
    fdiv	s26,	s20,	s16
    fmov	s20,	#2.000000
    fdiv	s16,	s4,	s26
    fadd	s18,	s26,	s16
    fmov	s26,	#2.000000
    fdiv	s30,	s18,	s12
    fdiv	s19,	s4,	s30
    fadd	s21,	s30,	s19
    fdiv	s2,	s21,	s11
    fdiv	s21,	s4,	s2
    fadd	s24,	s2,	s21
    fdiv	s25,	s24,	s10
    fsub	s18,	s25,	s9
    fmov	s25,	#2.000000
    str	s18,	[sp, #32]

    ldr	s24,	[sp, #36]

    fsub	s28,	s24,	s5
    fmul	s30,	s28,	s28
    fadd	s28,	s29,	s30
    fmov	s29,	#4.000000
    str	s28,	[sp, #48]

    fmov	s28,	#2.000000
    ldr	s30,	[sp, #48]

    fdiv	s30,	s30,	s1
    fadd	s23,	s30,	s31
    ldr	s31,	[sp, #48]

    fmov	s30,	#2.000000
    ldr	s1,	[sp, #48]

    fmul	s14,	s30,	s31
    fadd	s16,	s29,	s1
    ldr	s1,	[sp, #48]

    fdiv	s4,	s14,	s16
    ldr	s2,	[sp, #48]

    fadd	s16,	s23,	s4
    ldr	s3,	[sp, #48]

    fmov	s23,	#2.000000
    fdiv	s9,	s1,	s16
    ldr	s4,	[sp, #48]

    fadd	s10,	s16,	s9
    ldr	s5,	[sp, #48]

    fdiv	s19,	s10,	s28
    ldr	s7,	[sp, #48]

    fdiv	s14,	s2,	s19
    ldr	s9,	[sp, #48]

    fadd	s16,	s19,	s14
    ldr	s10,	[sp, #48]

    fmov	s14,	w10
    fdiv	s24,	s16,	s27
    fdiv	s11,	s3,	s24
    fadd	s12,	s24,	s11
    ldr	s11,	[sp, #48]

    fdiv	s28,	s12,	s26
    fdiv	s16,	s4,	s28
    fadd	s17,	s28,	s16
    fdiv	s31,	s17,	s25
    fmov	s17,	#2.000000
    fdiv	s21,	s5,	s31
    fadd	s22,	s31,	s21
    fmov	s21,	#2.000000
    fdiv	s3,	s22,	s23
    fmov	s22,	#2.000000
    fdiv	s25,	s7,	s3
    fadd	s28,	s3,	s25
    fdiv	s7,	s28,	s22
    fdiv	s29,	s9,	s7
    fadd	s31,	s7,	s29
    fdiv	s12,	s31,	s21
    fdiv	s1,	s10,	s12
    fadd	s3,	s12,	s1
    ldr	s12,	[sp, #48]

    fdiv	s10,	s3,	s20
    fdiv	s5,	s11,	s10
    fadd	s7,	s10,	s5
    fdiv	s16,	s7,	s17
    ldr	s17,	[sp, #32]

    fdiv	s10,	s12,	s16
    fadd	s11,	s16,	s10
    fmov	s16,	#2.000000
    fdiv	s16,	s11,	s16
    fsub	s22,	s16,	s14
    fcmp	s17,	s22
    bge	main_175

main_174:
    ldr	s18,	[sp, #32]

    fmov	s25,	#3.000000
    str	s18,	[x21]

    str	s25,	[x20]

    b	main_176

main_175:
    str	s22,	[x21]

    movi	v26.4s,	#0
    str	s26,	[x20]


main_176:
    ldr	s11,	[x21]

    movz	w14,	#14269
    movk	w14,	#13702,	lsl #16
    fmov	s27,	w14
    fcmp	s11,	s27
    blt	main_179

main_181:
    fadd	s6,	s6,	s11
    add	w26,	w26,	#1
    b	main_78

main_179:
    ldr	s24,	[x19]

    b	main_186

main_185:
    movi	v24.4s,	#0
    b	main_186

main_184:
    movi	v24.4s,	#0

main_186:
    fadd	s11,	s8,	s24
    add	w25,	w25,	#1
    cmp	w25,	#24
    blt	main_18

main_191:
    fmov	s14,	#24.000000
    movz	w23,	#0
    fdiv	s14,	s11,	s14
    movk	w23,	#17279,	lsl #16
    fmov	s12,	w23
    fmul	s11,	s14,	s12
    fcvtzs	w25,	s11
    cmp	w25,	#255
    cset	w28,	gt
    movz	w28,	#255
    csel	w0,	w28,	w25,	gt
    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w4,	[sp, #60]

    add	w5,	w4,	#1
    cmp	w5,	#192
    blt	main_12

main_199:
    movz	w0,	#10
    bl	putch
    ldr	w28,	[sp, #56]

    add	w26,	w28,	#1
    cmp	w26,	#192
    blt	main_6

main_202:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #80
    ret


main_6:
    str	w26,	[sp, #56]

    ldr	w26,	[sp, #64]

    b	main_7

main_12:
    str	w5,	[sp, #60]

    ldr	w26,	[sp, #64]

    b	main_13

main_18:
    fmov	s8,	s11
    ldr	w26,	[sp, #64]

    b	main_19

