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
    fmov	s17,	w10
    fmov	s15,	s17
    fdiv	s9,	s10,	s15
    str	s9,	[sp, #28]

    str	w2,	[sp, #60]


main_13:
    ldr	w27,	[sp, #60]

    movi	v9.4s,	#0
    movz	w25,	#0
    scvtf	s23,	w27
    fdiv	s12,	s23,	s15
    str	s12,	[sp, #44]


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
    cset	w15,	lt
    movz	w4,	#48161
    scvtf	s31,	w25
    csel	w28,	w7,	w6,	lt
    movk	w9,	#16329,	lsl #16
    movk	w4,	#19646,	lsl #16
    movz	w6,	#4059
    str	w28,	[sp, #64]

    fmov	s7,	w9
    fmov	s19,	w4
    movk	w6,	#16585,	lsl #16
    ldr	w0,	[sp, #64]

    fmov	s23,	w6
    scvtf	s12,	w0
    str	s23,	[sp, #32]

    fdiv	s13,	s12,	s19
    ldr	s24,	[sp, #32]

    fmov	s19,	#24.000000
    fadd	s22,	s31,	s13
    ldr	s11,	[sp, #32]

    fmul	s24,	s24,	s22
    fdiv	s12,	s24,	s19
    fadd	s19,	s12,	s7
    fcmp	s19,	s11
    bgt	main_41

main_37:
    fmov	s10,	w23
    fcmp	s19,	s10
    bge	main_48

main_41:
    ldr	s23,	[sp, #32]

    ldr	s22,	[sp, #32]

    fdiv	s6,	s19,	s23
    frintz	s14,	s6
    fcvtzs	w26,	s6
    fmul	s11,	s14,	s22
    fsub	s19,	s19,	s11

main_48:
    ldr	s14,	[sp, #32]

    movz	w28,	#4059
    fsub	s14,	s19,	s14
    movk	w28,	#16457,	lsl #16
    fmov	s11,	w28
    fcmp	s19,	s11
    fcsel	s14,	s14,	s19,	gt
    movz	w26,	#4059
    cset	w18,	gt
    str	s14,	[sp, #24]

    movk	w26,	#49225,	lsl #16
    ldr	s14,	[sp, #32]

    ldr	s8,	[sp, #24]

    ldr	s10,	[sp, #24]

    fadd	s8,	s8,	s14
    fmov	s14,	w26
    fcmp	s10,	s14
    ldr	s13,	[sp, #24]

    cset	w18,	lt
    fcsel	s0,	s8,	s13,	lt
    bl	my_sin_impl
    ldr	s4,	[sp, #32]

    fmov	s10,	s0
    fcmp	s12,	s4
    bgt	main_62

main_58:
    fmov	s18,	w23
    fcmp	s12,	s18
    blt	main_62

main_68:
    fmov	s8,	s12
    b	main_69

main_62:
    ldr	s20,	[sp, #32]

    ldr	s19,	[sp, #32]

    fdiv	s1,	s12,	s20
    frintz	s23,	s1
    fcvtzs	w17,	s1
    fmul	s4,	s23,	s19
    fsub	s8,	s12,	s4

main_69:
    ldr	s13,	[sp, #32]

    fsub	s12,	s8,	s13
    fcmp	s8,	s11
    ldr	s11,	[sp, #32]

    fcsel	s8,	s12,	s8,	gt
    cset	w18,	gt
    fmov	s12,	s14
    fadd	s11,	s8,	s11
    str	s11,	[sp, #36]

    fcmp	s8,	s12
    ldr	s11,	[sp, #36]

    cset	w28,	lt
    fcsel	s0,	s11,	s8,	lt
    bl	my_sin_impl
    movz	w26,	#0
    movi	v27.4s,	#0

main_78:
    cmp	w26,	#10
    bge	main_184

main_82:
    fmov	s26,	#2.000000
    fcmp	s27,	s26
    bge	main_185

main_84:
    fmul	s8,	s10,	s27
    ldr	s30,	[sp, #44]

    fmul	s21,	s0,	s27
    movz	w18,	#52429
    fmov	s4,	#8.000000
    fmov	s3,	#0.500000
    fmov	s2,	#2.000000
    fmov	s1,	#4.000000
    fmov	s31,	#2.000000
    fmov	s28,	#2.000000
    fmov	s25,	#2.000000
    fmov	s23,	#2.000000
    movz	w13,	#52429
    movz	w15,	#39322
    movz	w10,	#52429
    fadd	s22,	s30,	s8
    movk	w18,	#16076,	lsl #16
    movk	w13,	#15820,	lsl #16
    movk	w15,	#16153,	lsl #16
    movk	w10,	#15692,	lsl #16
    fmov	s8,	#2.000000
    str	s22,	[sp, #40]

    fmov	s5,	w18
    ldr	s26,	[sp, #28]

    ldr	s20,	[sp, #40]

    fadd	s17,	s26,	s21
    fsub	s30,	s20,	s5
    fmov	s26,	#2.000000
    fmul	s7,	s30,	s30
    fsub	s5,	s17,	s5
    fmov	s30,	#2.000000
    fmul	s18,	s5,	s5
    fmov	s5,	#2.000000
    fadd	s20,	s7,	s18
    fmul	s22,	s2,	s20
    fadd	s16,	s1,	s20
    fdiv	s11,	s20,	s4
    fdiv	s18,	s22,	s16
    fmov	s4,	#2.000000
    fadd	s29,	s11,	s3
    fadd	s19,	s29,	s18
    fdiv	s13,	s20,	s19
    fadd	s21,	s19,	s13
    fdiv	s12,	s21,	s31
    fdiv	s19,	s20,	s12
    fadd	s16,	s12,	s19
    fdiv	s18,	s16,	s30
    fdiv	s30,	s20,	s18
    fadd	s29,	s18,	s30
    fdiv	s30,	s29,	s28
    fdiv	s3,	s20,	s30
    fadd	s3,	s30,	s3
    fdiv	s3,	s3,	s26
    fdiv	s6,	s20,	s3
    fadd	s7,	s3,	s6
    fmov	s6,	#2.000000
    fdiv	s7,	s7,	s25
    fdiv	s11,	s20,	s7
    fadd	s12,	s7,	s11
    fmov	s7,	#2.000000
    fdiv	s12,	s12,	s23
    fdiv	s14,	s20,	s12
    fadd	s18,	s12,	s14
    fdiv	s19,	s18,	s7
    fdiv	s11,	s20,	s19
    fadd	s22,	s19,	s11
    fmov	s11,	#4.000000
    fdiv	s12,	s22,	s6
    fdiv	s16,	s20,	s12
    fadd	s18,	s12,	s16
    fmov	s12,	#2.000000
    fdiv	s19,	s18,	s5
    fmov	s5,	w15
    fdiv	s7,	s20,	s19
    fsub	s16,	s17,	s5
    fadd	s28,	s19,	s7
    fmul	s14,	s16,	s16
    fmov	s7,	w13
    fdiv	s30,	s28,	s8
    fsub	s20,	s30,	s7
    fmov	s7,	#0.500000
    str	s20,	[sp, #48]

    ldr	s21,	[sp, #40]

    fsub	s30,	s21,	s5
    fmul	s8,	s30,	s30
    fadd	s31,	s8,	s14
    fmov	s8,	#8.000000
    str	s31,	[sp, #52]

    ldr	s2,	[sp, #52]

    ldr	s28,	[sp, #52]

    fdiv	s6,	s2,	s8
    ldr	s24,	[sp, #52]

    fmul	s8,	s12,	s28
    fadd	s6,	s6,	s7
    ldr	s5,	[sp, #52]

    fadd	s16,	s11,	s24
    fmov	s7,	#2.000000
    fdiv	s21,	s8,	s16
    fmov	s8,	#2.000000
    fadd	s13,	s6,	s21
    ldr	s6,	[sp, #52]

    fdiv	s23,	s5,	s13
    fmov	s5,	#2.000000
    fadd	s11,	s13,	s23
    fdiv	s11,	s11,	s8
    fdiv	s31,	s6,	s11
    fmov	s6,	#2.000000
    fadd	s14,	s11,	s31
    fdiv	s16,	s14,	s7
    ldr	s7,	[sp, #52]

    ldr	s8,	[sp, #52]

    fdiv	s3,	s7,	s16
    ldr	s11,	[sp, #52]

    fadd	s18,	s16,	s3
    ldr	s13,	[sp, #52]

    fmov	s3,	#2.000000
    fdiv	s23,	s18,	s6
    ldr	s14,	[sp, #52]

    fdiv	s6,	s8,	s23
    ldr	s16,	[sp, #52]

    fadd	s25,	s23,	s6
    ldr	s17,	[sp, #52]

    fdiv	s29,	s25,	s5
    ldr	s18,	[sp, #52]

    fdiv	s11,	s11,	s29
    fadd	s2,	s29,	s11
    fdiv	s4,	s2,	s4
    fdiv	s8,	s13,	s4
    fadd	s7,	s4,	s8
    fdiv	s7,	s7,	s3
    fdiv	s13,	s14,	s7
    fmov	s14,	#2.000000
    fadd	s11,	s7,	s13
    fmov	s13,	#2.000000
    fdiv	s12,	s11,	s14
    fmov	s11,	#2.000000
    fdiv	s21,	s16,	s12
    fadd	s16,	s12,	s21
    ldr	s21,	[sp, #48]

    fdiv	s8,	s16,	s13
    fmov	s13,	#2.000000
    fdiv	s26,	s17,	s8
    fadd	s12,	s8,	s26
    fmov	s8,	w10
    fdiv	s14,	s12,	s13
    fdiv	s3,	s18,	s14
    fadd	s4,	s14,	s3
    fdiv	s5,	s4,	s11
    fsub	s6,	s5,	s8
    fcmp	s21,	s6
    bge	main_175

main_174:
    ldr	s20,	[sp, #48]

    fmov	s7,	#3.000000
    str	s20,	[x21]

    str	s7,	[x20]

    b	main_176

main_175:
    str	s6,	[x21]

    movi	v8.4s,	#0
    str	s8,	[x20]


main_176:
    ldr	s12,	[x21]

    movz	w14,	#14269
    movk	w14,	#13702,	lsl #16
    fmov	s11,	w14
    fcmp	s12,	s11
    blt	main_179

main_181:
    fadd	s27,	s27,	s12
    add	w26,	w26,	#1
    b	main_78

main_179:
    ldr	s7,	[x19]

    b	main_186

main_185:
    movi	v7.4s,	#0
    b	main_186

main_184:
    movi	v7.4s,	#0

main_186:
    fadd	s22,	s9,	s7
    add	w25,	w25,	#1
    cmp	w25,	#24
    blt	main_18

main_191:
    fmov	s12,	#24.000000
    movz	w23,	#0
    fdiv	s13,	s22,	s12
    movk	w23,	#17279,	lsl #16
    fmov	s11,	w23
    fmul	s13,	s13,	s11
    fcvtzs	w25,	s13
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
    fmov	s9,	s22
    ldr	w26,	[sp, #64]

    b	main_19

