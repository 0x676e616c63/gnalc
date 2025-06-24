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
    movz	w2,	#0
    add	x22,	sp,	#20
    add	x26,	sp,	#16
    mov	w25,	w2
    mov	x20,	x26
    add	x23,	x26,	#4
    str	x23,	[sp, #48]


main_7:
    scvtf	s9,	w25
    fmov	s24,	#12.000000
    movz	w13,	#0
    fdiv	s31,	s9,	s24
    mov	w23,	w13
    str	s31,	[sp, #40]


main_13:
    scvtf	s30,	w23
    fmov	s14,	#12.000000
    movi	v6.4s,	#0
    movz	w19,	#0
    fdiv	s28,	s30,	s14
    fmov	s8,	s6
    mov	w21,	w19
    str	s28,	[sp, #28]


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
    csel	w11,	w7,	w5,	lt
    scvtf	s2,	w21
    movz	w27,	#48161
    movk	w2,	#16329,	lsl #16
    movz	w7,	#4059
    str	w11,	[sp, #44]

    movk	w27,	#19646,	lsl #16
    fmov	s6,	w2
    movk	w7,	#16585,	lsl #16
    ldr	w12,	[sp, #44]

    fmov	s15,	w27
    scvtf	s29,	w12
    fmov	s22,	w7
    fdiv	s29,	s29,	s15
    fmov	s11,	s22
    fmov	s15,	#24.000000
    fadd	s19,	s2,	s29
    fmul	s22,	s11,	s19
    fdiv	s12,	s22,	s15
    fadd	s6,	s12,	s6
    fcmp	s6,	s11
    bgt	main_41

main_37:
    fmov	s9,	w28
    fcmp	s6,	s9
    bge	main_48

main_41:
    fdiv	s4,	s6,	s11
    frintz	s13,	s4
    fcvtzs	w3,	s4
    fmul	s10,	s13,	s11
    fsub	s6,	s6,	s10

main_48:
    fsub	s13,	s6,	s11
    movz	w18,	#4059
    movk	w18,	#16457,	lsl #16
    fmov	s14,	w18
    fcmp	s6,	s14
    movz	w27,	#4059
    fcsel	s13,	s13,	s6,	gt
    cset	w18,	gt
    movk	w27,	#49225,	lsl #16
    fadd	s15,	s13,	s11
    fmov	s9,	w27
    str	s15,	[sp, #24]

    fcmp	s13,	s9
    ldr	s10,	[sp, #24]

    cset	w19,	lt
    fcsel	s0,	s10,	s13,	lt
    bl	my_sin_impl
    fmov	s13,	s0
    fcmp	s12,	s11
    bgt	main_62

main_58:
    fmov	s15,	w28
    fcmp	s12,	s15
    bge	main_69

main_62:
    fdiv	s30,	s12,	s11
    frintz	s1,	s30
    fcvtzs	w8,	s30
    fmul	s2,	s1,	s11
    fsub	s12,	s12,	s2

main_69:
    fsub	s15,	s12,	s11
    fcmp	s12,	s14
    fcsel	s12,	s15,	s12,	gt
    cset	w18,	gt
    fadd	s15,	s12,	s11
    fcmp	s12,	s9
    fcsel	s0,	s15,	s12,	lt
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
    ldr	s4,	[sp, #28]

    fmul	s12,	s0,	s5
    movz	w11,	#52429
    fmov	s14,	#8.000000
    fmov	s11,	#2.000000
    fmov	s6,	#2.000000
    movz	w5,	#52429
    movz	w7,	#39322
    fmov	s21,	#2.000000
    movz	w1,	#52429
    ldr	s9,	[sp, #40]

    fadd	s29,	s4,	s30
    movk	w11,	#16076,	lsl #16
    movk	w5,	#15820,	lsl #16
    movk	w7,	#16153,	lsl #16
    movk	w1,	#15692,	lsl #16
    fadd	s16,	s9,	s12
    fmov	s15,	w11
    fmov	s9,	#2.000000
    fmov	s12,	#0.500000
    str	s16,	[sp, #32]

    fsub	s3,	s29,	s15
    ldr	s10,	[sp, #32]

    fmul	s16,	s3,	s3
    fsub	s15,	s10,	s15
    fmov	s3,	#2.000000
    fmov	s10,	#4.000000
    fmul	s27,	s15,	s15
    fadd	s15,	s16,	s27
    fdiv	s14,	s15,	s14
    fadd	s28,	s10,	s15
    fmul	s16,	s11,	s15
    fmov	s27,	#8.000000
    fadd	s25,	s14,	s12
    fmov	s10,	#2.000000
    fdiv	s30,	s16,	s28
    fadd	s14,	s25,	s30
    fmov	s25,	#2.000000
    fdiv	s2,	s15,	s14
    fadd	s18,	s14,	s2
    fdiv	s18,	s18,	s9
    fmov	s9,	#2.000000
    fdiv	s7,	s15,	s18
    fadd	s20,	s18,	s7
    fmov	s7,	#2.000000
    fdiv	s24,	s20,	s10
    fdiv	s11,	s15,	s24
    fadd	s26,	s24,	s11
    fdiv	s28,	s26,	s9
    fmov	s26,	#0.500000
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
    fdiv	s24,	s15,	s14
    fadd	s18,	s14,	s24
    fmov	s24,	#4.000000
    fdiv	s18,	s18,	s3
    fdiv	s30,	s15,	s18
    fadd	s16,	s18,	s30
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
    fsub	s11,	s12,	s3
    str	s11,	[sp, #36]

    ldr	s19,	[sp, #32]

    fsub	s14,	s19,	s1
    fmov	s19,	#2.000000
    fmul	s6,	s14,	s14
    fadd	s4,	s16,	s6
    fdiv	s17,	s4,	s27
    fmul	s14,	s25,	s4
    fadd	s27,	s24,	s4
    fadd	s23,	s17,	s26
    fdiv	s28,	s14,	s27
    fadd	s26,	s23,	s28
    fmov	s23,	#2.000000
    fdiv	s30,	s4,	s26
    fadd	s30,	s26,	s30
    fdiv	s30,	s30,	s23
    fdiv	s3,	s4,	s30
    fadd	s2,	s30,	s3
    fmov	s30,	#2.000000
    fdiv	s2,	s2,	s21
    fdiv	s9,	s4,	s2
    fadd	s9,	s2,	s9
    fdiv	s9,	s9,	s20
    fdiv	s12,	s4,	s9
    fadd	s12,	s9,	s12
    fdiv	s15,	s12,	s19
    fdiv	s14,	s4,	s15
    fadd	s17,	s15,	s14
    fmov	s14,	#2.000000
    fmov	s15,	#2.000000
    fdiv	s12,	s17,	s15
    fdiv	s17,	s4,	s12
    fadd	s17,	s12,	s17
    ldr	s12,	[sp, #36]

    fdiv	s17,	s17,	s14
    fmov	s14,	#2.000000
    fdiv	s23,	s4,	s17
    fadd	s22,	s17,	s23
    fdiv	s23,	s22,	s30
    fdiv	s27,	s4,	s23
    fadd	s26,	s23,	s27
    fdiv	s27,	s26,	s29
    fmov	s26,	w1
    fdiv	s30,	s4,	s27
    fadd	s31,	s27,	s30
    fmov	s27,	#2.000000
    fdiv	s1,	s31,	s14
    fdiv	s19,	s4,	s1
    fadd	s4,	s1,	s19
    fdiv	s6,	s4,	s27
    fsub	s23,	s6,	s26
    fcmp	s12,	s23
    bge	main_175

main_174:
    ldr	s3,	[sp, #36]

    fmov	s20,	#3.000000
    str	s3,	[x20]

    ldr	x24,	[sp, #48]

    str	s20,	[x24]

    b	main_176

main_175:
    str	s23,	[x20]

    movi	v21.4s,	#0
    ldr	x27,	[sp, #48]

    str	s21,	[x27]


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
    ldr	s15,	[x22]

    b	main_186

main_185:
    movi	v15.4s,	#0
    b	main_186

main_184:
    movi	v15.4s,	#0

main_186:
    fadd	s10,	s8,	s15
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

