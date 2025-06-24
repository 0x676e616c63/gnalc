.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global image
.align	2
image:
    .zero	4194304


.text

.globl p
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
my_sin_impl:
my_sin_impl_1:
    sub	sp, sp, #96
    stp	x22, fp, [sp, #0]
    str	lr, [sp, 16]
    stp	q8, q11, [sp, #32]
    stp	q13, q14, [sp, #64]

    movi	v20.4s,	#0
    fneg	s1,	s0
    fcmp	s0,	s20
    movz	w3,	#14269
    fcsel	s3,	s0,	s1,	gt
    cset	w16,	gt
    movk	w3,	#13702,	lsl #16
    fmov	s22,	w3
    fcmp	s3,	s22
    ble	my_sin_impl_26

my_sin_impl_6:
    fmov	s24,	#3.000000
    fneg	s13,	s0
    fmov	s8,	#3.000000
    movi	v7.4s,	#0
    fdiv	s24,	s0,	s24
    fdiv	s14,	s13,	s8
    fcmp	s24,	s7
    fcsel	s26,	s24,	s14,	gt
    cset	w22,	gt
    fcmp	s26,	s22
    ble	my_sin_impl_17

my_sin_impl_13:
    fmov	s11,	#3.000000
    fdiv	s0,	s24,	s11
    bl	my_sin_impl
    bl	p
    b	my_sin_impl_18

my_sin_impl_17:
    fmov	s0,	s24

my_sin_impl_18:
    fmov	s27,	#3.000000
    fmov	s26,	#4.000000
    fmul	s17,	s27,	s0
    fmul	s3,	s26,	s0
    fmul	s4,	s3,	s0
    fmul	s5,	s4,	s0
    fsub	s0,	s17,	s5

my_sin_impl_26:
    ldp	x22, fp, [sp, #0]
    ldr	lr, [sp, 16]
    ldp	q8, q11, [sp, #32]
    ldp	q13, q14, [sp, #64]

    add	sp, sp, #96
    ret


.globl main
main:
main_0:
    sub	sp, sp, #192
    stp	fp, lr, [sp, #0]
    
    bl	getfloat
    str	s0,	[sp, #48]

    bl	getch
    bl	getch
    movz	w27,	#65535
    movk	w27,	#65535,	lsl #16
    mov	w21,	w27
    cmp	w0,	#80
    bne	main_36

main_5:
    bl	getch
    cmp	w0,	#50
    bne	main_37

main_8:
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w24,	w0
    cmp	w25,	#1024
    bgt	main_38

main_12:
    cmp	w24,	#1024
    bgt	main_39

main_14:
    bl	getint
    cmp	w0,	#255
    bne	main_40

main_17:
    movz	w8,	#0
    cmp	w8,	w24
    blt	main_19

main_41:
    movz	w7,	#0
    str	w24,	[sp, #72]

    mov	w26,	w25
    str	w26,	[sp, #76]

    b	main_43

main_19:
    movz	w1,	#0
    movz	w23,	#0
    mov	w19,	w1
    mov	w22,	w23

main_21:
    movz	w20,	#0
    mov	w27,	w20

main_24:
    cmp	w27,	w25
    bge	main_32

main_27:
    add	w18,	w27,	w22
    adrp	x26, :got:image
    ldr	x26, [x26, #:got_lo12:image]
    lsl	w28,	w18,	#2
    add	x23,	x26,	x28
    bl	getint
    add	w20,	w27,	#1
    str	w0,	[x23]

    mov	w27,	w20
    b	main_24

main_32:
    add	w3,	w19,	#1
    add	w23,	w22,	w25
    cmp	w3,	w24
    bge	main_42

main_20:
    mov	w19,	w3
    mov	w22,	w23
    b	main_21

main_42:
    movz	w7,	#0
    mov	w28,	w24
    mov	w20,	w25
    str	w28,	[sp, #72]

    str	w20,	[sp, #76]

    b	main_43

main_40:
    mov	w7,	w21
    mov	w28,	w24
    mov	w26,	w25
    str	w28,	[sp, #72]

    str	w26,	[sp, #76]

    b	main_43

main_39:
    mov	w7,	w21
    mov	w28,	w24
    mov	w26,	w25
    str	w28,	[sp, #72]

    str	w26,	[sp, #76]

    b	main_43

main_38:
    mov	w7,	w21
    mov	w28,	w24
    mov	w26,	w25
    str	w28,	[sp, #72]

    str	w26,	[sp, #76]

    b	main_43

main_37:
    mov	w7,	w21
    movz	w23,	#0
    movz	w4,	#0
    str	w23,	[sp, #72]

    str	w4,	[sp, #76]

    b	main_43

main_36:
    mov	w7,	w21
    movz	w24,	#0
    movz	w5,	#0
    str	w24,	[sp, #72]

    str	w5,	[sp, #76]


main_43:
    cmp	w7,	#0
    blt	main_138

main_48:
    movz	w0,	#80
    bl	putch
    movz	w0,	#50
    bl	putch
    movz	w0,	#10
    bl	putch
    ldr	w0,	[sp, #76]

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
    ldr	w21,	[sp, #72]

    movz	w8,	#0
    cmp	w8,	w21
    bge	main_136

main_50:
    movz	w11,	#4059
    movz	w13,	#4059
    movk	w11,	#16585,	lsl #16
    movk	w13,	#16329,	lsl #16
    fmov	s17,	w11
    fmov	s3,	w13
    str	s17,	[sp, #16]

    ldr	s9,	[sp, #48]

    ldr	s27,	[sp, #16]

    ldr	s10,	[sp, #16]

    fdiv	s18,	s9,	s27
    frintz	s13,	s18
    fcvtzs	w0,	s18
    fmul	s22,	s13,	s10
    ldr	s10,	[sp, #48]

    fsub	s6,	s10,	s22
    str	s6,	[sp, #56]

    ldr	s12,	[sp, #48]

    fadd	s11,	s12,	s3
    str	s11,	[sp, #44]

    ldr	s8,	[sp, #16]

    ldr	s3,	[sp, #44]

    ldr	s7,	[sp, #16]

    fdiv	s17,	s3,	s8
    ldr	s4,	[sp, #44]

    fcvtzs	w6,	s17
    frintz	s17,	s17
    fmul	s22,	s17,	s7
    fsub	s10,	s4,	s22
    str	s10,	[sp, #60]

    ldr	w3,	[sp, #76]

    ldr	w6,	[sp, #76]

    asr	w12,	w3,	#31
    lsr	w13,	w12,	#31
    add	w14,	w6,	w13
    asr	w23,	w14,	#1
    str	w23,	[sp, #176]

    movz	w23,	#0
    ldr	w20,	[sp, #72]

    ldr	w28,	[sp, #72]

    asr	w7,	w20,	#31
    ldr	w27,	[sp, #176]

    lsr	w8,	w7,	#31
    scvtf	s14,	w27
    mov	w27,	w23
    str	s14,	[sp, #64]

    add	w9,	w28,	w8
    asr	w20,	w9,	#1
    scvtf	s17,	w20
    str	s17,	[sp, #68]


main_67:
    movz	w14,	#0
    ldr	w1,	[sp, #76]

    cmp	w14,	w1
    bge	main_132

main_70:
    sub	w15,	w27,	w20
    movz	w24,	#0
    mov	w22,	w24
    scvtf	s7,	w15
    str	s7,	[sp, #40]


main_74:
    movz	w19,	#4059
    ldr	s8,	[sp, #48]

    movk	w19,	#49353,	lsl #16
    fmov	s10,	w19
    fmov	s11,	s10
    fcmp	s8,	s11
    ldr	s10,	[sp, #48]

    cset	w21,	lt
    ldr	s15,	[sp, #56]

    fcsel	s9,	s15,	s10,	lt
    ldr	s15,	[sp, #16]

    ldr	s8,	[sp, #48]

    fcmp	s8,	s15
    cset	w21,	gt
    ldr	s8,	[sp, #56]

    movz	w25,	#4059
    ldr	s13,	[sp, #16]

    fcsel	s9,	s8,	s9,	gt
    movk	w25,	#16457,	lsl #16
    fsub	s12,	s9,	s13
    fmov	s15,	w25
    fmov	s10,	s15
    fcmp	s9,	s10
    fcsel	s13,	s12,	s9,	gt
    cset	w21,	gt
    movz	w23,	#4059
    str	s13,	[sp, #24]

    movk	w23,	#49225,	lsl #16
    ldr	s12,	[sp, #16]

    ldr	s8,	[sp, #24]

    fmov	s9,	w23
    fadd	s12,	s8,	s12
    fmov	s15,	s9
    str	s12,	[sp, #28]

    ldr	s9,	[sp, #24]

    fcmp	s9,	s15
    ldr	s12,	[sp, #28]

    cset	w23,	lt
    ldr	s8,	[sp, #24]

    fcsel	s0,	s12,	s8,	lt
    bl	my_sin_impl
    ldr	s12,	[sp, #44]

    fmov	s13,	s0
    fcmp	s12,	s11
    ldr	s14,	[sp, #44]

    cset	w24,	lt
    ldr	s8,	[sp, #60]

    ldr	s11,	[sp, #16]

    fcsel	s12,	s8,	s14,	lt
    str	s11,	[sp, #36]

    ldr	s14,	[sp, #36]

    ldr	s9,	[sp, #44]

    fcmp	s9,	s14
    ldr	s9,	[sp, #60]

    cset	w23,	gt
    fcsel	s11,	s9,	s12,	gt
    str	s11,	[sp, #32]

    ldr	s11,	[sp, #16]

    ldr	s14,	[sp, #32]

    ldr	s9,	[sp, #32]

    fsub	s11,	s14,	s11
    fcmp	s9,	s10
    ldr	s9,	[sp, #32]

    cset	w24,	gt
    fcsel	s11,	s11,	s9,	gt
    ldr	s9,	[sp, #16]

    fadd	s12,	s11,	s9
    fcmp	s11,	s15
    fcsel	s0,	s12,	s11,	lt
    cset	w25,	lt
    bl	my_sin_impl
    ldr	w3,	[sp, #176]

    ldr	s27,	[sp, #40]

    sub	w9,	w22,	w3
    ldr	s5,	[sp, #64]

    fmul	s29,	s27,	s13
    ldr	s31,	[sp, #40]

    scvtf	s28,	w9
    ldr	s18,	[sp, #68]

    fmul	s2,	s31,	s0
    fmul	s1,	s28,	s13
    fmul	s11,	s28,	s0
    fsub	s17,	s11,	s29
    fadd	s16,	s17,	s5
    fadd	s5,	s1,	s2
    fcvtzs	w15,	s16
    fadd	s4,	s5,	s18
    fcvtzs	w8,	s4
    cmp	w15,	#0
    blt	main_122

main_111:
    ldr	w26,	[sp, #76]

    cmp	w15,	w26
    bge	main_123

main_113:
    cmp	w8,	#0
    blt	main_124

main_115:
    ldr	w5,	[sp, #72]

    cmp	w8,	w5
    bge	main_125

main_117:
    ldr	w1,	[sp, #76]

    adrp	x19, :got:image
    ldr	w2,	[sp, #76]

    mul	w12,	w8,	w1
    ldr	x19, [x19, #:got_lo12:image]
    madd	w3,	w8,	w2,	w15

    lsl	w5,	w3,	#2
    add	x4,	x19,	x5
    ldr	w0,	[x4]

    b	main_126

main_125:
    movz	w0,	#0
    b	main_126

main_124:
    movz	w0,	#0
    b	main_126

main_123:
    movz	w0,	#0
    b	main_126

main_122:
    movz	w0,	#0

main_126:
    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w3,	[sp, #76]

    add	w24,	w22,	#1
    cmp	w24,	w3
    bge	main_132

main_73:
    mov	w22,	w24
    b	main_74

main_132:
    movz	w0,	#10
    bl	putch
    add	w23,	w27,	#1
    ldr	w27,	[sp, #72]

    cmp	w23,	w27
    bge	main_137

main_66:
    mov	w27,	w23
    b	main_67

main_137:
    movz	w21,	#0
    b	main_138

main_136:
    movz	w21,	#0

main_138:
    mov	w0,	w21
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #192
    ret


