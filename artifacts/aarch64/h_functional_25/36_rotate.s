.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global image
.align	2
image:
.type image, %object
    .zero	4194304

.data

.text

.globl p
.align 2
.p2align 4,,11
.type p, %function
p:
p_1:
    sub	sp, sp, #64
    str	lr, [sp, 0]
    stp	q13, q14, [sp, #16]
    str	q15, [sp, 48]

    fmov	s15,	#4.000000
    fmov	s16,	#3.000000
    fmul	s13,	s15,	s0
    fmul	s30,	s16,	s0
    fmul	s14,	s13,	s0
    fmul	s15,	s14,	s0
    fsub	s0,	s30,	s15
    ldr	lr, [sp, 0]
    ldp	q13, q14, [sp, #16]
    ldr	q15, [sp, 48]

    add	sp, sp, #64
    ret


.globl my_sin_impl
.align 2
.p2align 4,,11
.type my_sin_impl, %function
my_sin_impl:
my_sin_impl_1:
    sub	sp, sp, #112
    stp	x22, fp, [sp, #0]
    str	lr, [sp, 16]
    stp	q8, q9, [sp, #32]
    stp	q11, q14, [sp, #64]
    str	q15, [sp, 96]

    movi	v20.4s,	#0
    fneg	s1,	s0
    fcmp	s0,	s20
    movz	w3,	#14269
    fcsel	s3,	s0,	s1,	gt
    cset	w16,	gt
    movk	w3,	#13702,	lsl #16
    fmov	s21,	w3
    fcmp	s3,	s21
    ble	my_sin_impl_26

my_sin_impl_6:
    fmov	s24,	#3.000000
    fneg	s14,	s0
    fmov	s9,	#3.000000
    movi	v8.4s,	#0
    fdiv	s4,	s0,	s24
    fdiv	s15,	s14,	s9
    fcmp	s4,	s8
    fcsel	s26,	s4,	s15,	gt
    cset	w22,	gt
    fcmp	s26,	s21
    ble	my_sin_impl_18

my_sin_impl_13:
    fmov	s11,	#3.000000
    fdiv	s0,	s4,	s11
    bl	my_sin_impl
    bl	p
    fmov	s4,	s0

my_sin_impl_18:
    fmov	s27,	#3.000000
    fmov	s26,	#4.000000
    fmul	s31,	s27,	s4
    fmul	s16,	s26,	s4
    fmul	s17,	s16,	s4
    fmul	s5,	s17,	s4
    fsub	s0,	s31,	s5

my_sin_impl_26:
    ldp	x22, fp, [sp, #0]
    ldr	lr, [sp, 16]
    ldp	q8, q9, [sp, #32]
    ldp	q11, q14, [sp, #64]
    ldr	q15, [sp, 96]

    add	sp, sp, #112
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #208
    stp	fp, lr, [sp, #0]
    
    bl	getfloat
    str	s0,	[sp, #40]

    bl	getch
    bl	getch
    movz	w22,	#65535
    movk	w22,	#65535,	lsl #16
    mov	w26,	w22
    cmp	w0,	#80
    beq	main_5

main_36:
    mov	w13,	w26
    movz	w10,	#0
    movz	w25,	#0
    str	w10,	[sp, #72]

    str	w25,	[sp, #68]

    b	main_43

main_5:
    bl	getch
    cmp	w0,	#50
    beq	main_8

main_37:
    mov	w13,	w26
    movz	w11,	#0
    movz	w27,	#0
    str	w11,	[sp, #72]

    str	w27,	[sp, #68]

    b	main_43

main_8:
    bl	getint
    mov	w24,	w0
    bl	getint
    mov	w25,	w0
    cmp	w24,	#1024
    ble	main_12

main_38:
    mov	w13,	w26
    str	w25,	[sp, #72]

    mov	w23,	w24
    str	w23,	[sp, #68]

    b	main_43

main_12:
    cmp	w25,	#1024
    ble	main_14

main_39:
    mov	w13,	w26
    mov	w19,	w25
    mov	w21,	w24
    str	w19,	[sp, #72]

    str	w21,	[sp, #68]

    b	main_43

main_14:
    bl	getint
    cmp	w0,	#255
    beq	main_17

main_40:
    mov	w13,	w26
    mov	w19,	w25
    mov	w22,	w24
    str	w19,	[sp, #72]

    str	w22,	[sp, #68]

    b	main_43

main_17:
    movz	w9,	#0
    cmp	w9,	w25
    bge	main_41

main_19:
    movz	w5,	#0
    movz	w17,	#0
    mov	w27,	w5
    mov	w28,	w17

main_21:
    movz	w16,	#0
    mov	w20,	w16

main_24:
    cmp	w20,	w24
    blt	main_27

main_32:
    add	w7,	w27,	#1
    add	w17,	w28,	w24
    cmp	w7,	w25
    blt	main_20

main_42:
    movz	w13,	#0
    str	w25,	[sp, #72]

    mov	w21,	w24
    str	w21,	[sp, #68]

    b	main_43

main_20:
    mov	w27,	w7
    mov	w28,	w17
    b	main_21

main_27:
    add	w19,	w20,	w28
    adrp	x22, :got:image
    ldr	x22, [x22, #:got_lo12:image]
    lsl	w19,	w19,	#2
    add	x19,	x22,	x19
    bl	getint
    add	w15,	w20,	#1
    str	w0,	[x19]

    mov	w20,	w15
    b	main_24

main_41:
    movz	w13,	#0
    str	w25,	[sp, #72]

    mov	w28,	w24
    str	w28,	[sp, #68]


main_43:
    cmp	w13,	#0
    bge	main_48

main_135:
    mov	w23,	w26
    b	main_138

main_48:
    movz	w0,	#80
    bl	putch
    movz	w0,	#50
    bl	putch
    movz	w0,	#10
    bl	putch
    ldr	w0,	[sp, #68]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w0,	[sp, #72]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#255
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w16,	[sp, #72]

    movz	w13,	#0
    cmp	w13,	w16
    blt	main_50

main_136:
    movz	w23,	#0
    b	main_138

main_50:
    movz	w13,	#4059
    movz	w15,	#4059
    movk	w13,	#16585,	lsl #16
    movk	w15,	#16329,	lsl #16
    fmov	s17,	w13
    fmov	s3,	w15
    str	s17,	[sp, #20]

    ldr	s9,	[sp, #40]

    ldr	s27,	[sp, #20]

    ldr	s10,	[sp, #20]

    fdiv	s18,	s9,	s27
    frintz	s13,	s18
    fcvtzs	w11,	s18
    fmul	s22,	s13,	s10
    ldr	s10,	[sp, #40]

    fsub	s9,	s10,	s22
    str	s9,	[sp, #52]

    ldr	s12,	[sp, #40]

    fadd	s11,	s12,	s3
    str	s11,	[sp, #36]

    ldr	s8,	[sp, #20]

    ldr	s3,	[sp, #36]

    ldr	s7,	[sp, #20]

    fdiv	s17,	s3,	s8
    ldr	s4,	[sp, #36]

    fcvtzs	w17,	s17
    frintz	s17,	s17
    fmul	s22,	s17,	s7
    fsub	s13,	s4,	s22
    str	s13,	[sp, #56]

    ldr	w27,	[sp, #68]

    ldr	w28,	[sp, #68]

    asr	w15,	w27,	#31
    lsr	w16,	w15,	#31
    add	w17,	w28,	w16
    movz	w16,	#0
    mov	w28,	w16
    asr	w6,	w17,	#1
    str	w6,	[sp, #76]

    ldr	w14,	[sp, #72]

    asr	w15,	w14,	#31
    lsr	w18,	w15,	#31
    ldr	w15,	[sp, #72]

    add	w17,	w15,	w18
    asr	w23,	w17,	#1
    str	w23,	[sp, #192]

    ldr	w7,	[sp, #76]

    scvtf	s6,	w7
    str	s6,	[sp, #48]

    ldr	w24,	[sp, #192]

    scvtf	s17,	w24
    str	s17,	[sp, #60]


main_67:
    movz	w14,	#0
    ldr	w7,	[sp, #68]

    cmp	w14,	w7
    bge	main_132

main_70:
    ldr	w27,	[sp, #192]

    movz	w11,	#0
    sub	w3,	w28,	w27
    mov	w25,	w11
    scvtf	s7,	w3
    str	s7,	[sp, #32]


main_74:
    movz	w18,	#4059
    ldr	s8,	[sp, #40]

    movk	w18,	#49353,	lsl #16
    fmov	s10,	w18
    fmov	s11,	s10
    fcmp	s8,	s11
    cset	w26,	lt
    ldr	s12,	[sp, #40]

    ldr	s10,	[sp, #52]

    ldr	s15,	[sp, #20]

    fcsel	s10,	s10,	s12,	lt
    ldr	s8,	[sp, #40]

    fcmp	s8,	s15
    cset	w23,	gt
    ldr	s12,	[sp, #52]

    movz	w26,	#4059
    ldr	s13,	[sp, #20]

    fcsel	s9,	s12,	s10,	gt
    movk	w26,	#16457,	lsl #16
    fsub	s12,	s9,	s13
    fmov	s15,	w26
    fmov	s10,	s15
    fcmp	s9,	s10
    cset	w18,	gt
    movz	w22,	#4059
    fcsel	s15,	s12,	s9,	gt
    movk	w22,	#49225,	lsl #16
    ldr	s12,	[sp, #20]

    fmov	s9,	w22
    fadd	s14,	s15,	s12
    str	s14,	[sp, #16]

    fcmp	s15,	s9
    ldr	s13,	[sp, #16]

    cset	w19,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    ldr	s14,	[sp, #36]

    fmov	s13,	s0
    fcmp	s14,	s11
    cset	w26,	lt
    ldr	s15,	[sp, #36]

    ldr	s14,	[sp, #56]

    ldr	s12,	[sp, #20]

    fcsel	s11,	s14,	s15,	lt
    str	s12,	[sp, #28]

    ldr	s15,	[sp, #28]

    ldr	s12,	[sp, #36]

    fcmp	s12,	s15
    ldr	s15,	[sp, #56]

    cset	w23,	gt
    fcsel	s12,	s15,	s11,	gt
    str	s12,	[sp, #24]

    ldr	s11,	[sp, #20]

    ldr	s15,	[sp, #24]

    fsub	s12,	s15,	s11
    ldr	s11,	[sp, #24]

    fcmp	s11,	s10
    fmov	s15,	s9
    ldr	s10,	[sp, #24]

    cset	w18,	gt
    fcsel	s11,	s12,	s10,	gt
    ldr	s10,	[sp, #20]

    fadd	s12,	s11,	s10
    fcmp	s11,	s15
    fcsel	s0,	s12,	s11,	lt
    cset	w19,	lt
    bl	my_sin_impl
    ldr	w15,	[sp, #76]

    ldr	s28,	[sp, #32]

    sub	w8,	w25,	w15
    fmul	s29,	s28,	s13
    ldr	s28,	[sp, #48]

    scvtf	s27,	w8
    ldr	s31,	[sp, #32]

    fmul	s1,	s27,	s13
    fmul	s11,	s27,	s0
    ldr	s18,	[sp, #60]

    fmul	s2,	s31,	s0
    fsub	s16,	s11,	s29
    fadd	s5,	s1,	s2
    fadd	s16,	s16,	s28
    fadd	s4,	s5,	s18
    fcvtzs	w12,	s16
    fcvtzs	w2,	s4
    cmp	w12,	#0
    bge	main_111

main_122:
    movz	w0,	#0
    b	main_126

main_111:
    ldr	w8,	[sp, #68]

    cmp	w12,	w8
    blt	main_113

main_123:
    movz	w0,	#0
    b	main_126

main_113:
    cmp	w2,	#0
    bge	main_115

main_124:
    movz	w0,	#0
    b	main_126

main_115:
    ldr	w22,	[sp, #72]

    cmp	w2,	w22
    blt	main_117

main_125:
    movz	w0,	#0
    b	main_126

main_117:
    ldr	w9,	[sp, #68]

    ldr	w10,	[sp, #68]

    mul	w3,	w2,	w9
    madd	w0,	w2,	w10,	w12

    adrp	x3, :got:image
    lsl	w13,	w0,	#2
    ldr	x3, [x3, #:got_lo12:image]
    add	x1,	x3,	x13
    ldr	w0,	[x1]


main_126:
    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w12,	[sp, #68]

    add	w1,	w25,	#1
    cmp	w1,	w12
    blt	main_73

main_132:
    movz	w0,	#10
    bl	putch
    ldr	w20,	[sp, #72]

    add	w9,	w28,	#1
    cmp	w9,	w20
    blt	main_66

main_137:
    movz	w23,	#0

main_138:
    mov	w0,	w23
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #208
    ret


main_66:
    mov	w28,	w9
    b	main_67

main_73:
    mov	w25,	w1
    b	main_74

