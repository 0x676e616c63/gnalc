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
    movz	w0,	#12
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#12
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#255
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w10,	#0
    movz	w19,	#0
    add	x9,	sp,	#20
    add	x23,	sp,	#16
    mov	w21,	w19
    mov	x20,	x23
    add	x5,	x23,	#4
    str	x5,	[sp, #56]

    str	x9,	[sp, #64]


main_7:
    scvtf	s9,	w21
    fmov	s24,	#12.000000
    movz	w28,	#0
    fdiv	s30,	s9,	s24
    str	s30,	[sp, #32]

    str	w28,	[sp, #48]


main_13:
    ldr	w17,	[sp, #48]

    fmov	s25,	#12.000000
    movi	v10.4s,	#0
    movz	w27,	#0
    scvtf	s11,	w17
    fmov	s8,	s10
    fdiv	s2,	s11,	s25
    str	s2,	[sp, #36]


main_19:
    movz	w8,	#57186
    movz	w7,	#23333
    movz	w5,	#57607
    movk	w8,	#304,	lsl #16
    movk	w5,	#1525,	lsl #16
    madd	w2,	w10,	w8,	w7

    mul	w13,	w10,	w8
    sdiv	w8,	w2,	w5
    msub	w14,	w8,	w5,	w2

    mul	w6,	w8,	w5
    movz	w2,	#4059
    add	w15,	w14,	w5
    movk	w2,	#49353,	lsl #16
    mov	w24,	w2
    cmp	w14,	#0
    fmov	s11,	#24.000000
    cset	w7,	lt
    movz	w6,	#4059
    csel	w14,	w15,	w14,	lt
    movz	w2,	#48161
    scvtf	s10,	w27
    movk	w6,	#16585,	lsl #16
    str	w14,	[sp, #52]

    movk	w2,	#19646,	lsl #16
    ldr	w15,	[sp, #52]

    fmov	s19,	w6
    scvtf	s7,	w15
    fmov	s21,	w2
    fmov	s13,	s19
    movz	w2,	#4059
    fdiv	s22,	s7,	s21
    fmov	s15,	s13
    movk	w2,	#16329,	lsl #16
    fadd	s12,	s10,	s22
    fmov	s14,	w2
    fmul	s9,	s13,	s12
    fdiv	s11,	s9,	s11
    fadd	s16,	s11,	s14
    fcmp	s16,	s15
    bgt	main_41

main_37:
    fmov	s29,	w24
    fcmp	s16,	s29
    bge	main_48

main_41:
    fdiv	s7,	s16,	s13
    frintz	s10,	s7
    fcvtzs	w3,	s7
    fmul	s12,	s10,	s13
    fsub	s16,	s16,	s12

main_48:
    fsub	s15,	s16,	s13
    movz	w28,	#4059
    movk	w28,	#16457,	lsl #16
    fmov	s14,	w28
    fcmp	s16,	s14
    fcsel	s10,	s15,	s16,	gt
    cset	w28,	gt
    movz	w22,	#4059
    str	s10,	[sp, #24]

    movk	w22,	#49225,	lsl #16
    ldr	s12,	[sp, #24]

    fadd	s12,	s12,	s13
    fmov	s10,	w22
    str	s12,	[sp, #44]

    ldr	s12,	[sp, #24]

    fcmp	s12,	s10
    ldr	s9,	[sp, #24]

    cset	w18,	lt
    ldr	s15,	[sp, #44]

    fcsel	s0,	s15,	s9,	lt
    bl	my_sin_impl
    fmov	s9,	s0
    fcmp	s11,	s13
    bgt	main_62

main_58:
    fmov	s19,	w24
    fcmp	s11,	s19
    bge	main_69

main_62:
    fdiv	s26,	s11,	s13
    frintz	s31,	s26
    fcvtzs	w8,	s26
    fmul	s1,	s31,	s13
    fsub	s11,	s11,	s1

main_69:
    fmov	s15,	s13
    fsub	s12,	s11,	s15
    fcmp	s11,	s14
    fcsel	s15,	s12,	s11,	gt
    cset	w24,	gt
    fadd	s14,	s15,	s13
    fcmp	s15,	s10
    fcsel	s0,	s14,	s15,	lt
    cset	w19,	lt
    bl	my_sin_impl
    movz	w4,	#0
    movi	v4.4s,	#0

main_78:
    cmp	w4,	#10
    bge	main_184

main_82:
    fmov	s7,	#2.000000
    fcmp	s4,	s7
    bge	main_185

main_84:
    fmul	s15,	s9,	s4
    ldr	s1,	[sp, #36]

    fmul	s18,	s0,	s4
    movz	w12,	#52429
    fmov	s14,	#8.000000
    fmov	s13,	#0.500000
    fmov	s12,	#2.000000
    fmov	s10,	#4.000000
    movz	w6,	#52429
    movz	w8,	#39322
    movz	w1,	#52429
    ldr	s7,	[sp, #32]

    fadd	s23,	s1,	s15
    movk	w12,	#16076,	lsl #16
    movk	w6,	#15820,	lsl #16
    movk	w8,	#16153,	lsl #16
    movk	w1,	#15692,	lsl #16
    fadd	s18,	s7,	s18
    fmov	s15,	w12
    str	s18,	[sp, #40]

    fsub	s19,	s23,	s15
    ldr	s20,	[sp, #40]

    fmul	s22,	s19,	s19
    fsub	s20,	s20,	s15
    fmul	s24,	s20,	s20
    fadd	s16,	s22,	s24
    fdiv	s28,	s16,	s14
    fmul	s19,	s12,	s16
    fadd	s20,	s10,	s16
    fmov	s24,	#2.000000
    fadd	s17,	s28,	s13
    fmov	s10,	#2.000000
    fdiv	s1,	s19,	s20
    fmov	s13,	#2.000000
    fadd	s2,	s17,	s1
    fdiv	s3,	s16,	s2
    fadd	s5,	s2,	s3
    fmov	s2,	#2.000000
    fmov	s3,	#2.000000
    fdiv	s6,	s5,	s10
    fmov	s5,	#2.000000
    fmov	s10,	#2.000000
    fdiv	s7,	s16,	s6
    fadd	s7,	s6,	s7
    fmov	s6,	#2.000000
    fdiv	s11,	s7,	s13
    fmov	s7,	#2.000000
    fdiv	s12,	s16,	s11
    fadd	s13,	s11,	s12
    fmov	s12,	#2.000000
    fdiv	s15,	s13,	s12
    fdiv	s14,	s16,	s15
    fadd	s19,	s15,	s14
    fdiv	s13,	s19,	s10
    fdiv	s14,	s16,	s13
    fadd	s15,	s13,	s14
    fmov	s13,	#2.000000
    fdiv	s17,	s15,	s7
    fdiv	s18,	s16,	s17
    fadd	s19,	s17,	s18
    fdiv	s22,	s19,	s6
    fdiv	s21,	s16,	s22
    fadd	s25,	s22,	s21
    fmov	s21,	#2.000000
    fmov	s22,	#2.000000
    fdiv	s26,	s25,	s5
    fmov	s25,	#0.500000
    fdiv	s27,	s16,	s26
    fadd	s28,	s26,	s27
    fmov	s26,	#8.000000
    fdiv	s29,	s28,	s3
    fdiv	s30,	s16,	s29
    fadd	s31,	s29,	s30
    fmov	s29,	w8
    fdiv	s1,	s31,	s2
    fsub	s6,	s23,	s29
    fdiv	s31,	s16,	s1
    fmov	s23,	#4.000000
    fmul	s7,	s6,	s6
    fadd	s2,	s1,	s31
    fmov	s31,	w6
    fmov	s1,	#2.000000
    fdiv	s3,	s2,	s1
    fsub	s14,	s3,	s31
    str	s14,	[sp, #28]

    fmov	s14,	#2.000000
    ldr	s20,	[sp, #40]

    fsub	s5,	s20,	s29
    fmov	s20,	#2.000000
    fmul	s10,	s5,	s5
    fadd	s6,	s7,	s10
    fmul	s10,	s24,	s6
    fadd	s12,	s23,	s6
    fdiv	s15,	s6,	s26
    fadd	s5,	s15,	s25
    fdiv	s15,	s10,	s12
    fmov	s10,	w1
    fadd	s15,	s5,	s15
    fdiv	s18,	s6,	s15
    fadd	s17,	s15,	s18
    fmov	s15,	#2.000000
    fdiv	s19,	s17,	s22
    fmov	s17,	#2.000000
    fdiv	s23,	s6,	s19
    fadd	s23,	s19,	s23
    fmov	s19,	#2.000000
    fdiv	s23,	s23,	s21
    fdiv	s26,	s6,	s23
    fadd	s27,	s23,	s26
    fdiv	s26,	s27,	s20
    fdiv	s29,	s6,	s26
    fadd	s30,	s26,	s29
    fdiv	s29,	s30,	s19
    fdiv	s1,	s6,	s29
    fadd	s2,	s29,	s1
    fdiv	s1,	s2,	s17
    fdiv	s7,	s6,	s1
    fadd	s7,	s1,	s7
    fdiv	s5,	s7,	s15
    fdiv	s12,	s6,	s5
    fadd	s12,	s5,	s12
    ldr	s5,	[sp, #28]

    fdiv	s11,	s12,	s14
    fmov	s12,	#2.000000
    fdiv	s16,	s6,	s11
    fadd	s17,	s11,	s16
    fdiv	s11,	s17,	s13
    fdiv	s15,	s6,	s11
    fadd	s15,	s11,	s15
    fmov	s11,	#2.000000
    fdiv	s14,	s15,	s12
    fdiv	s16,	s6,	s14
    fadd	s17,	s14,	s16
    fdiv	s19,	s17,	s11
    fsub	s19,	s19,	s10
    fcmp	s5,	s19
    bge	main_175

main_174:
    ldr	s6,	[sp, #28]

    fmov	s17,	#3.000000
    str	s6,	[x20]

    ldr	x25,	[sp, #56]

    str	s17,	[x25]

    b	main_176

main_175:
    str	s19,	[x20]

    ldr	x26,	[sp, #56]

    movi	v19.4s,	#0
    str	s19,	[x26]


main_176:
    ldr	s23,	[x23]

    movz	w6,	#14269
    movk	w6,	#13702,	lsl #16
    fmov	s20,	w6
    fcmp	s23,	s20
    blt	main_179

main_181:
    fadd	s4,	s4,	s23
    add	w4,	w4,	#1
    b	main_78

main_179:
    ldr	x5,	[sp, #64]

    ldr	s4,	[x5]

    b	main_186

main_185:
    movi	v4.4s,	#0
    b	main_186

main_184:
    movi	v4.4s,	#0

main_186:
    fadd	s10,	s8,	s4
    add	w27,	w27,	#1
    cmp	w27,	#24
    blt	main_18

main_191:
    fmov	s14,	#24.000000
    movz	w22,	#0
    fdiv	s11,	s10,	s14
    movk	w22,	#17279,	lsl #16
    fmov	s8,	w22
    fmul	s14,	s11,	s8
    fcvtzs	w22,	s14
    cmp	w22,	#255
    movz	w0,	#255
    cset	w27,	gt
    csel	w0,	w0,	w22,	gt
    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w0,	[sp, #48]

    add	w2,	w0,	#1
    cmp	w2,	#12
    blt	main_12

main_199:
    movz	w0,	#10
    bl	putch
    add	w19,	w21,	#1
    cmp	w19,	#12
    blt	main_6

main_202:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #80
    ret


main_6:
    mov	w21,	w19
    ldr	w10,	[sp, #52]

    b	main_7

main_12:
    str	w2,	[sp, #48]

    ldr	w10,	[sp, #52]

    b	main_13

main_18:
    fmov	s8,	s10
    ldr	w10,	[sp, #52]

    b	main_19

