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
    sub	sp, sp, #64
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
    movz	w9,	#0
    add	x22,	sp,	#20
    movz	w2,	#0
    add	x26,	sp,	#16
    mov	x20,	x26
    add	x25,	x26,	#4
    str	x25,	[sp, #48]

    mov	w25,	w2

main_7:
    scvtf	s9,	w25
    fmov	s24,	#12.000000
    movz	w13,	#0
    fdiv	s30,	s9,	s24
    mov	w23,	w13
    str	s30,	[sp, #32]


main_13:
    scvtf	s30,	w23
    fmov	s14,	#12.000000
    movi	v6.4s,	#0
    movz	w19,	#0
    fdiv	s2,	s30,	s14
    fmov	s8,	s6
    mov	w21,	w19
    str	s2,	[sp, #28]


main_19:
    movz	w2,	#57186
    movz	w6,	#23333
    movz	w4,	#57607
    movk	w2,	#304,	lsl #16
    movk	w4,	#1525,	lsl #16
    madd	w15,	w9,	w2,	w6

    mul	w5,	w9,	w2
    sdiv	w5,	w15,	w4
    mul	w0,	w5,	w4
    movz	w0,	#4059
    msub	w5,	w5,	w4,	w15

    movk	w0,	#49353,	lsl #16
    add	w7,	w5,	w4
    mov	w28,	w0
    cmp	w5,	#0
    movz	w2,	#4059
    cset	w13,	lt
    scvtf	s2,	w21
    movz	w27,	#48161
    movk	w2,	#16329,	lsl #16
    csel	w13,	w7,	w5,	lt
    movk	w27,	#19646,	lsl #16
    movz	w7,	#4059
    str	w13,	[sp, #44]

    fmov	s6,	w2
    fmov	s13,	w27
    movk	w7,	#16585,	lsl #16
    ldr	w14,	[sp, #44]

    fmov	s22,	w7
    scvtf	s29,	w14
    fmov	s15,	s22
    fdiv	s29,	s29,	s13
    fmov	s13,	#24.000000
    fadd	s17,	s2,	s29
    fmul	s22,	s15,	s17
    fdiv	s11,	s22,	s13
    fadd	s9,	s11,	s6
    fcmp	s9,	s15
    bgt	main_41

main_37:
    fmov	s7,	w28
    fcmp	s9,	s7
    bge	main_48

main_41:
    fdiv	s4,	s9,	s15
    frintz	s12,	s4
    fcvtzs	w3,	s4
    fmul	s10,	s12,	s15
    fsub	s9,	s9,	s10

main_48:
    fsub	s12,	s9,	s15
    movz	w18,	#4059
    movk	w18,	#16457,	lsl #16
    fmov	s10,	w18
    fmov	s14,	s10
    fcmp	s9,	s14
    movz	w27,	#4059
    fcsel	s13,	s12,	s9,	gt
    cset	w18,	gt
    movk	w27,	#49225,	lsl #16
    str	s13,	[sp, #24]

    ldr	s9,	[sp, #24]

    ldr	s12,	[sp, #24]

    fadd	s10,	s9,	s15
    fmov	s9,	w27
    fcmp	s12,	s9
    ldr	s13,	[sp, #24]

    cset	w19,	lt
    fcsel	s0,	s10,	s13,	lt
    bl	my_sin_impl
    fmov	s13,	s0
    fcmp	s11,	s15
    bgt	main_62

main_58:
    fmov	s12,	w28
    fcmp	s11,	s12
    bge	main_69

main_62:
    fdiv	s30,	s11,	s15
    frintz	s1,	s30
    fcvtzs	w8,	s30
    fmul	s2,	s1,	s15
    fsub	s11,	s11,	s2

main_69:
    fsub	s10,	s11,	s15
    fcmp	s11,	s14
    fcsel	s12,	s10,	s11,	gt
    cset	w18,	gt
    fadd	s11,	s12,	s15
    fcmp	s12,	s9
    fcsel	s0,	s11,	s12,	lt
    cset	w18,	lt
    bl	my_sin_impl
    movz	w13,	#0
    movi	v5.4s,	#0

main_78:
    cmp	w13,	#10
    bge	main_184

main_82:
    fmov	s9,	#2.000000
    fcmp	s5,	s9
    bge	main_185

main_84:
    fmul	s30,	s13,	s5
    ldr	s11,	[sp, #28]

    fmul	s12,	s0,	s5
    movz	w11,	#52429
    fmov	s14,	#8.000000
    fmov	s10,	#4.000000
    fmov	s9,	#2.000000
    fmov	s6,	#2.000000
    movz	w5,	#52429
    movz	w7,	#39322
    fmov	s26,	#0.500000
    fmov	s24,	#4.000000
    movz	w1,	#52429
    ldr	s7,	[sp, #32]

    fadd	s29,	s11,	s30
    movk	w11,	#16076,	lsl #16
    movk	w5,	#15820,	lsl #16
    movk	w7,	#16153,	lsl #16
    movk	w1,	#15692,	lsl #16
    fadd	s18,	s7,	s12
    fmov	s11,	#2.000000
    fmov	s15,	w11
    str	s18,	[sp, #36]

    fsub	s3,	s29,	s15
    ldr	s12,	[sp, #36]

    fmul	s16,	s3,	s3
    fsub	s15,	s12,	s15
    fmov	s3,	#2.000000
    fmov	s12,	#0.500000
    fmul	s27,	s15,	s15
    fadd	s15,	s16,	s27
    fmov	s27,	#8.000000
    fdiv	s14,	s15,	s14
    fmul	s16,	s11,	s15
    fadd	s28,	s10,	s15
    fadd	s25,	s14,	s12
    fmov	s10,	#2.000000
    fdiv	s30,	s16,	s28
    fadd	s14,	s25,	s30
    fdiv	s2,	s15,	s14
    fadd	s18,	s14,	s2
    fdiv	s18,	s18,	s9
    fmov	s9,	#2.000000
    fdiv	s7,	s15,	s18
    fadd	s20,	s18,	s7
    fmov	s7,	#2.000000
    fdiv	s22,	s20,	s10
    fdiv	s11,	s15,	s22
    fadd	s25,	s22,	s11
    fdiv	s28,	s25,	s9
    fmov	s25,	#2.000000
    fmov	s9,	#2.000000
    fdiv	s16,	s15,	s28
    fadd	s1,	s28,	s16
    fdiv	s4,	s1,	s7
    fmov	s1,	w7
    fdiv	s14,	s15,	s4
    fsub	s29,	s29,	s1
    fadd	s7,	s4,	s14
    fmov	s4,	#2.000000
    fdiv	s10,	s7,	s6
    fmov	s7,	#2.000000
    fdiv	s18,	s15,	s10
    fadd	s12,	s10,	s18
    fdiv	s14,	s12,	s4
    fmov	s4,	#2.000000
    fdiv	s23,	s15,	s14
    fadd	s18,	s14,	s23
    fdiv	s18,	s18,	s3
    fdiv	s30,	s15,	s18
    fadd	s16,	s18,	s30
    fmov	s18,	#2.000000
    fdiv	s17,	s16,	s7
    fmul	s16,	s29,	s29
    fdiv	s3,	s15,	s17
    fmov	s29,	#2.000000
    fadd	s19,	s17,	s3
    fmov	s3,	w5
    fdiv	s20,	s19,	s9
    fdiv	s11,	s15,	s20
    fadd	s10,	s20,	s11
    fmov	s20,	#2.000000
    fdiv	s12,	s10,	s4
    fsub	s14,	s12,	s3
    str	s14,	[sp, #40]

    ldr	s21,	[sp, #36]

    fsub	s14,	s21,	s1
    fmul	s6,	s14,	s14
    fadd	s4,	s16,	s6
    fdiv	s17,	s4,	s27
    fmul	s14,	s25,	s4
    fadd	s27,	s24,	s4
    fadd	s23,	s17,	s26
    fdiv	s28,	s14,	s27
    fmov	s17,	#2.000000
    fadd	s26,	s23,	s28
    fmov	s23,	#2.000000
    fdiv	s30,	s4,	s26
    fadd	s30,	s26,	s30
    fdiv	s30,	s30,	s23
    fdiv	s3,	s4,	s30
    fadd	s2,	s30,	s3
    fmov	s30,	#2.000000
    fdiv	s2,	s2,	s20
    fdiv	s9,	s4,	s2
    fadd	s9,	s2,	s9
    fdiv	s9,	s9,	s18
    fdiv	s12,	s4,	s9
    fadd	s12,	s9,	s12
    fdiv	s15,	s12,	s17
    fdiv	s14,	s4,	s15
    fadd	s17,	s15,	s14
    fmov	s14,	#2.000000
    fmov	s15,	#2.000000
    fdiv	s12,	s17,	s15
    ldr	s15,	[sp, #40]

    fdiv	s17,	s4,	s12
    fadd	s17,	s12,	s17
    fdiv	s17,	s17,	s14
    fmov	s14,	#2.000000
    fdiv	s22,	s4,	s17
    fadd	s20,	s17,	s22
    fdiv	s21,	s20,	s30
    fdiv	s27,	s4,	s21
    fadd	s26,	s21,	s27
    fdiv	s27,	s26,	s29
    fmov	s26,	w1
    fdiv	s30,	s4,	s27
    fadd	s31,	s27,	s30
    fmov	s27,	#2.000000
    fdiv	s1,	s31,	s14
    fdiv	s17,	s4,	s1
    fadd	s4,	s1,	s17
    fdiv	s6,	s4,	s27
    fsub	s23,	s6,	s26
    fcmp	s15,	s23
    bge	main_175

main_174:
    ldr	s6,	[sp, #40]

    fmov	s18,	#3.000000
    str	s6,	[x20]

    ldr	x28,	[sp, #48]

    str	s18,	[x28]

    b	main_176

main_175:
    str	s23,	[x20]

    movi	v20.4s,	#0
    ldr	x0,	[sp, #48]

    str	s20,	[x0]


main_176:
    ldr	s28,	[x26]

    movz	w5,	#14269
    movk	w5,	#13702,	lsl #16
    fmov	s23,	w5
    fcmp	s28,	s23
    blt	main_179

main_181:
    fadd	s5,	s5,	s28
    add	w13,	w13,	#1
    b	main_78

main_179:
    ldr	s13,	[x22]

    b	main_186

main_185:
    movi	v13.4s,	#0
    b	main_186

main_184:
    movi	v13.4s,	#0

main_186:
    fadd	s10,	s8,	s13
    add	w3,	w21,	#1
    cmp	w3,	#24
    blt	main_18

main_191:
    fmov	s14,	#24.000000
    movz	w0,	#0
    fdiv	s13,	s10,	s14
    movk	w0,	#17279,	lsl #16
    fmov	s14,	w0
    fmul	s13,	s13,	s14
    fcvtzs	w27,	s13
    cmp	w27,	#255
    movz	w18,	#255
    cset	w19,	gt
    csel	w0,	w18,	w27,	gt
    bl	putint
    movz	w0,	#32
    bl	putch
    add	w3,	w23,	#1
    cmp	w3,	#12
    blt	main_12

main_199:
    movz	w0,	#10
    bl	putch
    add	w16,	w25,	#1
    cmp	w16,	#12
    blt	main_6

main_202:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


main_6:
    mov	w25,	w16
    ldr	w9,	[sp, #44]

    b	main_7

main_12:
    mov	w23,	w3
    ldr	w9,	[sp, #44]

    b	main_13

main_18:
    fmov	s8,	s10
    mov	w21,	w3
    ldr	w9,	[sp, #44]

    b	main_19

