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
    sub	sp, sp, #96
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
    movz	w1,	#0
    add	x2,	sp,	#24
    add	x22,	sp,	#20
    mov	x20,	x22
    add	x27,	x22,	#4
    str	x27,	[sp, #80]

    str	x2,	[sp, #88]

    movz	w2,	#0
    str	w1,	[sp, #76]


main_7:
    ldr	w14,	[sp, #76]

    movz	w23,	#0
    movz	w18,	#0
    scvtf	s10,	w14
    movk	w23,	#17216,	lsl #16
    fmov	s11,	w23
    fmov	s15,	s11
    fdiv	s10,	s10,	s15
    str	s10,	[sp, #40]

    str	w18,	[sp, #64]


main_13:
    ldr	w19,	[sp, #64]

    movz	w1,	#0
    scvtf	s11,	w19
    fdiv	s7,	s11,	s15
    movi	v11.4s,	#0
    str	s7,	[sp, #36]

    fmov	s8,	s11
    str	w1,	[sp, #72]


main_19:
    movz	w10,	#57186
    movz	w9,	#23333
    movz	w5,	#57607
    movz	w26,	#4059
    movk	w10,	#304,	lsl #16
    movk	w5,	#1525,	lsl #16
    movk	w26,	#49353,	lsl #16
    mul	w13,	w2,	w10
    mov	w23,	w26
    madd	w2,	w2,	w10,	w9

    sdiv	w8,	w2,	w5
    msub	w13,	w8,	w5,	w2

    mul	w6,	w8,	w5
    add	w14,	w13,	w5
    cmp	w13,	#0
    cset	w7,	lt
    csel	w26,	w14,	w13,	lt
    fmov	s13,	#24.000000
    movz	w2,	#4059
    movz	w19,	#48161
    str	w26,	[sp, #68]

    movk	w2,	#16585,	lsl #16
    movk	w19,	#19646,	lsl #16
    ldr	w27,	[sp, #68]

    fmov	s27,	w2
    fmov	s17,	w19
    ldr	w7,	[sp, #72]

    scvtf	s4,	w27
    movz	w2,	#4059
    str	s27,	[sp, #28]

    scvtf	s6,	w7
    fdiv	s9,	s4,	s17
    movk	w2,	#16329,	lsl #16
    ldr	s4,	[sp, #28]

    fadd	s5,	s6,	s9
    ldr	s16,	[sp, #28]

    fmov	s17,	w2
    fmul	s6,	s4,	s5
    fdiv	s10,	s6,	s13
    fadd	s2,	s10,	s17
    fcmp	s2,	s16
    bgt	main_41

main_37:
    fmov	s25,	w23
    fcmp	s2,	s25
    bge	main_48

main_41:
    ldr	s27,	[sp, #28]

    ldr	s26,	[sp, #28]

    fdiv	s1,	s2,	s27
    frintz	s16,	s1
    fcvtzs	w3,	s1
    fmul	s5,	s16,	s26
    fsub	s2,	s2,	s5

main_48:
    ldr	s11,	[sp, #28]

    movz	w18,	#4059
    fsub	s13,	s2,	s11
    movk	w18,	#16457,	lsl #16
    fmov	s9,	w18
    fcmp	s2,	s9
    cset	w18,	gt
    fcsel	s12,	s13,	s2,	gt
    movz	w18,	#4059
    str	s12,	[sp, #60]

    movk	w18,	#49225,	lsl #16
    ldr	s13,	[sp, #28]

    ldr	s11,	[sp, #60]

    fadd	s14,	s11,	s13
    fmov	s13,	w18
    str	s14,	[sp, #16]

    ldr	s12,	[sp, #60]

    fmov	s14,	s13
    fcmp	s12,	s14
    ldr	s12,	[sp, #16]

    cset	w28,	lt
    ldr	s11,	[sp, #60]

    fcsel	s0,	s12,	s11,	lt
    bl	my_sin_impl
    ldr	s20,	[sp, #28]

    fmov	s13,	s0
    fcmp	s10,	s20
    bgt	main_62

main_58:
    fmov	s17,	w23
    fcmp	s10,	s17
    blt	main_62

main_68:
    fmov	s27,	s10
    str	s27,	[sp, #56]

    b	main_69

main_62:
    ldr	s21,	[sp, #28]

    ldr	s20,	[sp, #28]

    fdiv	s7,	s10,	s21
    frintz	s5,	s7
    fcvtzs	w8,	s7
    fmul	s17,	s5,	s20
    fsub	s23,	s10,	s17
    str	s23,	[sp, #56]


main_69:
    ldr	s11,	[sp, #28]

    ldr	s12,	[sp, #56]

    ldr	s10,	[sp, #56]

    fsub	s12,	s12,	s11
    fcmp	s10,	s9
    ldr	s9,	[sp, #56]

    cset	w28,	gt
    ldr	s11,	[sp, #28]

    fcsel	s10,	s12,	s9,	gt
    fmov	s12,	s14
    fadd	s9,	s10,	s11
    str	s9,	[sp, #32]

    fcmp	s10,	s12
    ldr	s12,	[sp, #32]

    cset	w18,	lt
    fcsel	s0,	s12,	s10,	lt
    bl	my_sin_impl
    movz	w1,	#0
    movi	v6.4s,	#0

main_78:
    cmp	w1,	#10
    bge	main_184

main_82:
    fmov	s12,	#2.000000
    fcmp	s6,	s12
    bge	main_185

main_84:
    fmul	s11,	s13,	s6
    ldr	s24,	[sp, #36]

    fmul	s17,	s0,	s6
    movz	w12,	#52429
    fmov	s22,	#0.500000
    fmov	s19,	#2.000000
    fmov	s10,	#2.000000
    movz	w6,	#52429
    movz	w8,	#39322
    fmov	s1,	#8.000000
    movz	w2,	#52429
    ldr	s28,	[sp, #40]

    fadd	s3,	s24,	s11
    movk	w12,	#16076,	lsl #16
    movk	w6,	#15820,	lsl #16
    movk	w8,	#16153,	lsl #16
    movk	w2,	#15692,	lsl #16
    fadd	s23,	s28,	s17
    fmov	s24,	w12
    str	s23,	[sp, #44]

    fsub	s14,	s3,	s24
    fmov	s23,	#8.000000
    ldr	s18,	[sp, #44]

    fmul	s16,	s14,	s14
    fsub	s12,	s18,	s24
    fmov	s14,	#2.000000
    fmov	s18,	#4.000000
    fmul	s17,	s12,	s12
    fadd	s4,	s16,	s17
    fdiv	s23,	s4,	s23
    fmov	s17,	#2.000000
    fadd	s2,	s18,	s4
    fmov	s16,	#2.000000
    fmul	s31,	s19,	s4
    fadd	s30,	s23,	s22
    fdiv	s19,	s31,	s2
    fmov	s23,	#2.000000
    fadd	s2,	s30,	s19
    fdiv	s22,	s4,	s2
    fadd	s26,	s2,	s22
    fdiv	s9,	s26,	s17
    fdiv	s27,	s4,	s9
    fadd	s29,	s9,	s27
    fdiv	s12,	s29,	s16
    fdiv	s31,	s4,	s12
    fadd	s2,	s12,	s31
    fmov	s12,	#2.000000
    fdiv	s17,	s2,	s14
    fdiv	s5,	s4,	s17
    fadd	s9,	s17,	s5
    fmov	s5,	w8
    fmov	s17,	#2.000000
    fdiv	s14,	s9,	s12
    fsub	s27,	s3,	s5
    fmov	s9,	w6
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
    fsub	s19,	s25,	s9
    str	s19,	[sp, #48]

    ldr	s25,	[sp, #44]

    fsub	s28,	s25,	s5
    fmov	s25,	#2.000000
    fmul	s30,	s28,	s28
    fmov	s28,	#2.000000
    fadd	s29,	s29,	s30
    str	s29,	[sp, #52]

    fmov	s29,	#4.000000
    ldr	s31,	[sp, #52]

    fdiv	s30,	s31,	s1
    ldr	s1,	[sp, #52]

    fmov	s31,	#0.500000
    ldr	s2,	[sp, #52]

    fadd	s24,	s30,	s31
    fadd	s16,	s29,	s2
    fmov	s30,	#2.000000
    ldr	s2,	[sp, #52]

    fmul	s14,	s30,	s1
    ldr	s3,	[sp, #52]

    fdiv	s4,	s14,	s16
    fadd	s16,	s24,	s4
    ldr	s4,	[sp, #52]

    fdiv	s9,	s2,	s16
    ldr	s5,	[sp, #52]

    fadd	s10,	s16,	s9
    ldr	s7,	[sp, #52]

    fdiv	s19,	s10,	s28
    ldr	s9,	[sp, #52]

    fdiv	s14,	s3,	s19
    ldr	s10,	[sp, #52]

    fadd	s16,	s19,	s14
    fdiv	s24,	s16,	s27
    fdiv	s11,	s4,	s24
    fadd	s12,	s24,	s11
    ldr	s11,	[sp, #52]

    fdiv	s28,	s12,	s26
    fdiv	s16,	s5,	s28
    fadd	s17,	s28,	s16
    fdiv	s31,	s17,	s25
    fmov	s17,	#2.000000
    fdiv	s21,	s7,	s31
    fadd	s22,	s31,	s21
    fmov	s21,	#2.000000
    fdiv	s3,	s22,	s23
    fmov	s22,	#2.000000
    fdiv	s25,	s9,	s3
    fadd	s28,	s3,	s25
    fdiv	s7,	s28,	s22
    fdiv	s29,	s10,	s7
    fadd	s31,	s7,	s29
    fdiv	s12,	s31,	s21
    fdiv	s1,	s11,	s12
    fadd	s3,	s12,	s1
    ldr	s12,	[sp, #52]

    fdiv	s10,	s3,	s20
    ldr	s14,	[sp, #52]

    fdiv	s5,	s12,	s10
    ldr	s18,	[sp, #48]

    fadd	s7,	s10,	s5
    fdiv	s16,	s7,	s17
    fdiv	s10,	s14,	s16
    fmov	s14,	w2
    fadd	s11,	s16,	s10
    fmov	s16,	#2.000000
    fdiv	s16,	s11,	s16
    fsub	s22,	s16,	s14
    fcmp	s18,	s22
    bge	main_175

main_174:
    ldr	s19,	[sp, #48]

    fmov	s25,	#3.000000
    str	s19,	[x20]

    ldr	x3,	[sp, #80]

    str	s25,	[x3]

    b	main_176

main_175:
    str	s22,	[x20]

    movi	v26.4s,	#0
    ldr	x4,	[sp, #80]

    str	s26,	[x4]


main_176:
    ldr	s11,	[x22]

    movz	w6,	#14269
    movk	w6,	#13702,	lsl #16
    fmov	s27,	w6
    fcmp	s11,	s27
    blt	main_179

main_181:
    fadd	s6,	s6,	s11
    add	w1,	w1,	#1
    b	main_78

main_179:
    ldr	x3,	[sp, #88]

    ldr	s24,	[x3]

    b	main_186

main_185:
    movi	v24.4s,	#0
    b	main_186

main_184:
    movi	v24.4s,	#0

main_186:
    fadd	s11,	s8,	s24
    ldr	w6,	[sp, #72]

    add	w4,	w6,	#1
    cmp	w4,	#24
    blt	main_18

main_191:
    fmov	s14,	#24.000000
    movz	w21,	#0
    fdiv	s14,	s11,	s14
    movk	w21,	#17279,	lsl #16
    fmov	s12,	w21
    fmul	s11,	s14,	s12
    fcvtzs	w0,	s11
    cmp	w0,	#255
    movz	w28,	#255
    cset	w19,	gt
    csel	w0,	w28,	w0,	gt
    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w16,	[sp, #64]

    add	w19,	w16,	#1
    cmp	w19,	#192
    blt	main_12

main_199:
    movz	w0,	#10
    bl	putch
    ldr	w11,	[sp, #76]

    add	w12,	w11,	#1
    cmp	w12,	#192
    blt	main_6

main_202:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


main_6:
    str	w12,	[sp, #76]

    ldr	w2,	[sp, #68]

    b	main_7

main_12:
    str	w19,	[sp, #64]

    ldr	w2,	[sp, #68]

    b	main_13

main_18:
    fmov	s8,	s11
    str	w4,	[sp, #72]

    ldr	w2,	[sp, #68]

    b	main_19

