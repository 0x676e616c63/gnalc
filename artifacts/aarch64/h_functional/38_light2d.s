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
    movz	w2,	#0
    add	x26,	sp,	#24
    movz	w18,	#0
    movz	fp,	#60
    add	x20,	sp,	#20
    mov	w21,	w2
    add	x22,	x20,	#4
    str	x22,	[sp, fp]


main_7:
    scvtf	s30,	w21
    movz	w10,	#0
    movz	w23,	#0
    movk	w10,	#17216,	lsl #16
    fmov	s17,	w10
    fmov	s11,	s17
    fdiv	s6,	s30,	s11
    str	s6,	[sp, #32]

    str	w23,	[sp, #52]


main_13:
    ldr	w24,	[sp, #52]

    movz	w14,	#0
    scvtf	s30,	w24
    mov	w25,	w14
    fdiv	s9,	s30,	s11
    str	s9,	[sp, #48]

    movi	v9.4s,	#0
    fmov	s8,	s9

main_19:
    movz	w8,	#57186
    movz	w1,	#23333
    movz	w24,	#57607
    movk	w8,	#304,	lsl #16
    movk	w24,	#1525,	lsl #16
    madd	w4,	w18,	w8,	w1

    mul	w11,	w18,	w8
    sdiv	w5,	w4,	w24
    movz	w18,	#4059
    msub	w3,	w5,	w24,	w4

    mul	w6,	w5,	w24
    movk	w18,	#49353,	lsl #16
    add	w8,	w3,	w24
    mov	w24,	w18
    cmp	w3,	#0
    fmov	s18,	#24.000000
    csel	w19,	w8,	w3,	lt
    movz	w1,	#4059
    cset	w5,	lt
    scvtf	s31,	w25
    movz	w4,	#4059
    str	w19,	[sp, #56]

    movk	w1,	#16585,	lsl #16
    movz	w5,	#48161
    movk	w4,	#16329,	lsl #16
    ldr	w22,	[sp, #56]

    fmov	s23,	w1
    movk	w5,	#19646,	lsl #16
    fmov	s7,	w4
    scvtf	s13,	w22
    str	s23,	[sp, #28]

    fmov	s20,	w5
    ldr	s24,	[sp, #28]

    fdiv	s14,	s13,	s20
    ldr	s13,	[sp, #28]

    fadd	s25,	s31,	s14
    fmul	s25,	s24,	s25
    fdiv	s10,	s25,	s18
    fadd	s19,	s10,	s7
    fcmp	s19,	s13
    bgt	main_41

main_37:
    fmov	s12,	w24
    fcmp	s19,	s12
    bge	main_48

main_41:
    ldr	s23,	[sp, #28]

    ldr	s22,	[sp, #28]

    fdiv	s6,	s19,	s23
    frintz	s15,	s6
    fcvtzs	w17,	s6
    fmul	s13,	s15,	s22
    fsub	s19,	s19,	s13

main_48:
    ldr	s12,	[sp, #28]

    movz	w18,	#4059
    fsub	s15,	s19,	s12
    movk	w18,	#16457,	lsl #16
    fmov	s9,	w18
    fcmp	s19,	s9
    cset	w23,	gt
    fcsel	s15,	s15,	s19,	gt
    movz	w23,	#4059
    str	s15,	[sp, #16]

    movk	w23,	#49225,	lsl #16
    ldr	s14,	[sp, #28]

    ldr	s12,	[sp, #16]

    fmov	s15,	w23
    ldr	s13,	[sp, #16]

    fadd	s12,	s12,	s14
    fcmp	s13,	s15
    ldr	s14,	[sp, #16]

    cset	w22,	lt
    fcsel	s0,	s12,	s14,	lt
    bl	my_sin_impl
    ldr	s4,	[sp, #28]

    fmov	s13,	s0
    fcmp	s10,	s4
    bgt	main_62

main_58:
    fmov	s18,	w24
    fcmp	s10,	s18
    bge	main_69

main_62:
    ldr	s17,	[sp, #28]

    ldr	s16,	[sp, #28]

    fdiv	s1,	s10,	s17
    frintz	s23,	s1
    fcvtzs	w15,	s1
    fmul	s4,	s23,	s16
    fsub	s10,	s10,	s4

main_69:
    ldr	s12,	[sp, #28]

    fsub	s12,	s10,	s12
    fcmp	s10,	s9
    fcsel	s10,	s12,	s10,	gt
    cset	w24,	gt
    ldr	s12,	[sp, #28]

    fadd	s12,	s10,	s12
    fcmp	s10,	s15
    fcsel	s0,	s12,	s10,	lt
    cset	w24,	lt
    bl	my_sin_impl
    movz	w2,	#0
    movi	v27.4s,	#0

main_78:
    cmp	w2,	#10
    bge	main_184

main_82:
    fmov	s26,	#2.000000
    fcmp	s27,	s26
    bge	main_185

main_84:
    fmul	s9,	s13,	s27
    ldr	s26,	[sp, #48]

    fmul	s20,	s0,	s27
    movz	w14,	#52429
    fmov	s4,	#8.000000
    fmov	s3,	#0.500000
    fmov	s2,	#2.000000
    fmov	s1,	#4.000000
    fmov	s31,	#2.000000
    fmov	s28,	#2.000000
    fmov	s25,	#2.000000
    fmov	s24,	#2.000000
    movz	w7,	#52429
    movz	w9,	#39322
    movz	w1,	#52429
    ldr	s15,	[sp, #32]

    fadd	s23,	s26,	s9
    movk	w14,	#16076,	lsl #16
    movk	w7,	#15820,	lsl #16
    movk	w9,	#16153,	lsl #16
    movk	w1,	#15692,	lsl #16
    fadd	s20,	s15,	s20
    fmov	s9,	#2.000000
    fmov	s26,	#2.000000
    fmov	s5,	w14
    str	s20,	[sp, #36]

    fsub	s30,	s23,	s5
    ldr	s10,	[sp, #36]

    fmul	s7,	s30,	s30
    fsub	s5,	s10,	s5
    fmov	s30,	#2.000000
    fmul	s17,	s5,	s5
    fmov	s5,	#2.000000
    fadd	s19,	s7,	s17
    fdiv	s10,	s19,	s4
    fmul	s22,	s2,	s19
    fadd	s16,	s1,	s19
    fadd	s29,	s10,	s3
    fdiv	s17,	s22,	s16
    fadd	s18,	s29,	s17
    fdiv	s14,	s19,	s18
    fadd	s20,	s18,	s14
    fdiv	s12,	s20,	s31
    fdiv	s18,	s19,	s12
    fadd	s16,	s12,	s18
    fdiv	s18,	s16,	s30
    fdiv	s30,	s19,	s18
    fadd	s29,	s18,	s30
    fdiv	s31,	s29,	s28
    fdiv	s3,	s19,	s31
    fadd	s3,	s31,	s3
    fdiv	s3,	s3,	s26
    fdiv	s6,	s19,	s3
    fadd	s7,	s3,	s6
    fmov	s6,	#2.000000
    fdiv	s7,	s7,	s25
    fdiv	s10,	s19,	s7
    fadd	s12,	s7,	s10
    fmov	s7,	#2.000000
    fdiv	s12,	s12,	s24
    fdiv	s15,	s19,	s12
    fadd	s17,	s12,	s15
    fdiv	s18,	s17,	s7
    fdiv	s10,	s19,	s18
    fadd	s21,	s18,	s10
    fmov	s10,	#4.000000
    fdiv	s12,	s21,	s6
    fdiv	s17,	s19,	s12
    fadd	s17,	s12,	s17
    fmov	s12,	#2.000000
    fdiv	s20,	s17,	s5
    fmov	s5,	w9
    fdiv	s7,	s19,	s20
    fadd	s29,	s20,	s7
    fmov	s7,	w7
    fdiv	s30,	s29,	s9
    fsub	s29,	s23,	s5
    fsub	s16,	s30,	s7
    fmul	s9,	s29,	s29
    fmov	s7,	#0.500000
    str	s16,	[sp, #44]

    ldr	s17,	[sp, #36]

    fsub	s16,	s17,	s5
    fmul	s15,	s16,	s16
    fadd	s28,	s9,	s15
    fmov	s9,	#8.000000
    str	s28,	[sp, #40]

    ldr	s30,	[sp, #40]

    ldr	s24,	[sp, #40]

    fdiv	s6,	s30,	s9
    ldr	s21,	[sp, #40]

    fmul	s9,	s12,	s24
    fadd	s6,	s6,	s7
    ldr	s2,	[sp, #40]

    fadd	s16,	s10,	s21
    fmov	s7,	#2.000000
    ldr	s3,	[sp, #40]

    fdiv	s19,	s9,	s16
    ldr	s4,	[sp, #40]

    fmov	s9,	#2.000000
    fadd	s14,	s6,	s19
    ldr	s5,	[sp, #40]

    fmov	s6,	#2.000000
    fdiv	s24,	s2,	s14
    fadd	s10,	s14,	s24
    fdiv	s10,	s10,	s9
    fdiv	s31,	s3,	s10
    fadd	s15,	s10,	s31
    fdiv	s16,	s15,	s7
    fmov	s15,	#2.000000
    fdiv	s3,	s4,	s16
    fmov	s4,	#2.000000
    fadd	s18,	s16,	s3
    fmov	s3,	#2.000000
    fdiv	s21,	s18,	s6
    fdiv	s6,	s5,	s21
    fmov	s5,	#2.000000
    fadd	s26,	s21,	s6
    ldr	s6,	[sp, #40]

    fdiv	s29,	s26,	s5
    ldr	s9,	[sp, #40]

    fdiv	s10,	s6,	s29
    fadd	s2,	s29,	s10
    ldr	s10,	[sp, #40]

    fdiv	s4,	s2,	s4
    fdiv	s9,	s9,	s4
    fadd	s7,	s4,	s9
    fdiv	s7,	s7,	s3
    fdiv	s14,	s10,	s7
    fadd	s10,	s7,	s14
    fmov	s14,	#2.000000
    fdiv	s12,	s10,	s15
    ldr	s10,	[sp, #40]

    fdiv	s19,	s10,	s12
    fmov	s10,	#2.000000
    fadd	s16,	s12,	s19
    fdiv	s9,	s16,	s14
    ldr	s14,	[sp, #40]

    fdiv	s26,	s14,	s9
    fmov	s14,	#2.000000
    fadd	s12,	s9,	s26
    fmov	s9,	w1
    fdiv	s15,	s12,	s14
    ldr	s14,	[sp, #40]

    ldr	s18,	[sp, #44]

    fdiv	s3,	s14,	s15
    fadd	s4,	s15,	s3
    fdiv	s5,	s4,	s10
    fsub	s6,	s5,	s9
    fcmp	s18,	s6
    bge	main_175

main_174:
    ldr	s17,	[sp, #44]

    fmov	s7,	#3.000000
    movz	fp,	#60
    str	s17,	[x20]

    ldr	x27,	[sp, fp]

    str	s7,	[x27]

    b	main_176

main_175:
    str	s6,	[x20]

    movi	v9.4s,	#0
    movz	fp,	#60
    ldr	x28,	[sp, fp]

    str	s9,	[x28]


main_176:
    ldr	s12,	[x20]

    movz	w6,	#14269
    movk	w6,	#13702,	lsl #16
    fmov	s10,	w6
    fcmp	s12,	s10
    blt	main_179

main_181:
    fadd	s27,	s27,	s12
    add	w2,	w2,	#1
    b	main_78

main_179:
    ldr	s7,	[x26]

    b	main_186

main_185:
    movi	v7.4s,	#0
    b	main_186

main_184:
    movi	v7.4s,	#0

main_186:
    fadd	s22,	s8,	s7
    add	w17,	w25,	#1
    cmp	w17,	#24
    blt	main_18

main_191:
    fmov	s14,	#24.000000
    movz	w19,	#0
    fdiv	s15,	s22,	s14
    movk	w19,	#17279,	lsl #16
    fmov	s13,	w19
    fmul	s14,	s15,	s13
    fcvtzs	w24,	s14
    cmp	w24,	#255
    movz	w18,	#255
    cset	w0,	gt
    csel	w0,	w18,	w24,	gt
    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w23,	[sp, #52]

    add	w25,	w23,	#1
    cmp	w25,	#192
    blt	main_12

main_199:
    movz	w0,	#10
    bl	putch
    add	w16,	w21,	#1
    cmp	w16,	#192
    blt	main_6

main_202:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #80
    ret


main_6:
    mov	w21,	w16
    ldr	w18,	[sp, #56]

    b	main_7

main_12:
    str	w25,	[sp, #52]

    ldr	w18,	[sp, #56]

    b	main_13

main_18:
    fmov	s8,	s22
    mov	w25,	w17
    ldr	w18,	[sp, #56]

    b	main_19

