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
    movz	w21,	#65535
    movk	w21,	#65535,	lsl #16
    mov	w28,	w21
    cmp	w0,	#80
    bne	main_36

main_5:
    bl	getch
    cmp	w0,	#50
    bne	main_37

main_8:
    bl	getint
    mov	w22,	w0
    bl	getint
    mov	w23,	w0
    cmp	w22,	#1024
    bgt	main_38

main_12:
    cmp	w23,	#1024
    bgt	main_39

main_14:
    bl	getint
    cmp	w0,	#255
    bne	main_40

main_17:
    movz	w8,	#0
    cmp	w8,	w23
    blt	main_19

main_41:
    movz	w8,	#0
    mov	w20,	w23
    mov	w25,	w22
    str	w20,	[sp, #80]

    str	w25,	[sp, #76]

    b	main_43

main_19:
    movz	w2,	#0
    movz	w13,	#0
    mov	w21,	w2
    mov	w24,	w13

main_21:
    movz	w12,	#0
    mov	w26,	w12

main_24:
    cmp	w26,	w22
    bge	main_32

main_27:
    add	w27,	w26,	w24
    adrp	x18, :got:image
    ldr	x18, [x18, #:got_lo12:image]
    lsl	w19,	w27,	#2
    add	x25,	x18,	x19
    bl	getint
    add	w11,	w26,	#1
    str	w0,	[x25]

    mov	w26,	w11
    b	main_24

main_32:
    add	w12,	w21,	#1
    add	w24,	w24,	w22
    cmp	w12,	w23
    bge	main_42

main_20:
    mov	w21,	w12
    b	main_21

main_42:
    movz	w8,	#0
    mov	w20,	w23
    str	w20,	[sp, #80]

    str	w22,	[sp, #76]

    b	main_43

main_40:
    mov	w8,	w28
    mov	w21,	w23
    str	w21,	[sp, #80]

    str	w22,	[sp, #76]

    b	main_43

main_39:
    mov	w8,	w28
    str	w23,	[sp, #80]

    mov	w25,	w22
    str	w25,	[sp, #76]

    b	main_43

main_38:
    mov	w8,	w28
    mov	w24,	w23
    str	w24,	[sp, #80]

    str	w22,	[sp, #76]

    b	main_43

main_37:
    mov	w8,	w28
    movz	w22,	#0
    movz	w5,	#0
    str	w22,	[sp, #80]

    str	w5,	[sp, #76]

    b	main_43

main_36:
    mov	w8,	w28
    movz	w23,	#0
    movz	w6,	#0
    str	w23,	[sp, #80]

    str	w6,	[sp, #76]


main_43:
    cmp	w8,	#0
    blt	main_135

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
    ldr	w0,	[sp, #80]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#255
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w21,	[sp, #80]

    movz	w13,	#0
    cmp	w13,	w21
    bge	main_136

main_50:
    movz	w12,	#4059
    movz	w14,	#4059
    movk	w12,	#16585,	lsl #16
    movk	w14,	#16329,	lsl #16
    fmov	s19,	w12
    fmov	s3,	w14
    str	s19,	[sp, #20]

    ldr	s10,	[sp, #48]

    ldr	s28,	[sp, #20]

    fdiv	s18,	s10,	s28
    ldr	s10,	[sp, #20]

    frintz	s13,	s18
    fcvtzs	w11,	s18
    ldr	s11,	[sp, #48]

    fmul	s22,	s13,	s10
    fsub	s10,	s11,	s22
    str	s10,	[sp, #60]

    ldr	s13,	[sp, #48]

    fadd	s12,	s13,	s3
    str	s12,	[sp, #44]

    ldr	s8,	[sp, #20]

    ldr	s4,	[sp, #44]

    ldr	s7,	[sp, #20]

    fdiv	s17,	s4,	s8
    ldr	s4,	[sp, #44]

    fcvtzs	w17,	s17
    frintz	s17,	s17
    fmul	s22,	s17,	s7
    fsub	s17,	s4,	s22
    str	s17,	[sp, #64]

    ldr	w4,	[sp, #76]

    ldr	w5,	[sp, #76]

    asr	w15,	w4,	#31
    ldr	w20,	[sp, #80]

    lsr	w17,	w15,	#31
    ldr	w21,	[sp, #80]

    asr	w15,	w20,	#31
    add	w17,	w5,	w17
    lsr	w16,	w15,	#31
    movz	w15,	#0
    asr	w22,	w17,	#1
    mov	w27,	w15
    add	w17,	w21,	w16
    scvtf	s7,	w22
    str	s7,	[sp, #56]

    asr	w19,	w17,	#1
    scvtf	s14,	w19
    str	s14,	[sp, #68]


main_67:
    movz	w14,	#0
    ldr	w13,	[sp, #76]

    cmp	w14,	w13
    bge	main_132

main_70:
    sub	w3,	w27,	w19
    movz	w10,	#0
    mov	w23,	w10
    scvtf	s8,	w3
    str	s8,	[sp, #40]


main_74:
    movz	w28,	#4059
    movk	w28,	#49353,	lsl #16
    fmov	s10,	w28
    fmov	s12,	s10
    ldr	s10,	[sp, #48]

    fcmp	s10,	s12
    cset	w26,	lt
    ldr	s13,	[sp, #48]

    ldr	s11,	[sp, #60]

    ldr	s15,	[sp, #20]

    fcsel	s9,	s11,	s13,	lt
    ldr	s10,	[sp, #48]

    fcmp	s10,	s15
    cset	w18,	gt
    movz	w20,	#4059
    ldr	s13,	[sp, #60]

    movk	w20,	#16457,	lsl #16
    fcsel	s9,	s13,	s9,	gt
    fmov	s10,	w20
    ldr	s13,	[sp, #20]

    fmov	s11,	s10
    fsub	s15,	s9,	s13
    fcmp	s9,	s11
    cset	w28,	gt
    fcsel	s10,	s15,	s9,	gt
    movz	w26,	#4059
    ldr	s13,	[sp, #20]

    movk	w26,	#49225,	lsl #16
    fadd	s15,	s10,	s13
    str	s15,	[sp, #24]

    fmov	s15,	w26
    fcmp	s10,	s15
    ldr	s13,	[sp, #24]

    cset	w20,	lt
    fcsel	s0,	s13,	s10,	lt
    bl	my_sin_impl
    ldr	s14,	[sp, #44]

    fmov	s13,	s0
    fcmp	s14,	s12
    cset	w26,	lt
    ldr	s9,	[sp, #44]

    ldr	s10,	[sp, #64]

    ldr	s12,	[sp, #20]

    fcsel	s10,	s10,	s9,	lt
    str	s12,	[sp, #32]

    ldr	s12,	[sp, #32]

    ldr	s8,	[sp, #44]

    fcmp	s8,	s12
    cset	w18,	gt
    ldr	s12,	[sp, #64]

    fcsel	s8,	s12,	s10,	gt
    fmov	s10,	s11
    str	s8,	[sp, #72]

    ldr	s14,	[sp, #20]

    str	s14,	[sp, #36]

    ldr	s8,	[sp, #36]

    ldr	s14,	[sp, #72]

    fsub	s9,	s14,	s8
    str	s9,	[sp, #28]

    ldr	s11,	[sp, #72]

    fcmp	s11,	s10
    ldr	s8,	[sp, #28]

    cset	w28,	gt
    ldr	s12,	[sp, #72]

    ldr	s9,	[sp, #20]

    fcsel	s11,	s8,	s12,	gt
    fadd	s12,	s11,	s9
    fcmp	s11,	s15
    fcsel	s0,	s12,	s11,	lt
    cset	w26,	lt
    bl	my_sin_impl
    sub	w8,	w23,	w22
    ldr	s29,	[sp, #40]

    fmul	s29,	s29,	s13
    scvtf	s27,	w8
    fmul	s1,	s27,	s13
    fmul	s11,	s27,	s0
    fsub	s16,	s11,	s29
    ldr	s29,	[sp, #56]

    ldr	s2,	[sp, #40]

    fadd	s16,	s16,	s29
    ldr	s15,	[sp, #68]

    fmul	s2,	s2,	s0
    fcvtzs	w24,	s16
    fadd	s5,	s1,	s2
    fadd	s4,	s5,	s15
    fcvtzs	w4,	s4
    cmp	w24,	#0
    blt	main_122

main_111:
    ldr	w14,	[sp, #76]

    cmp	w24,	w14
    bge	main_123

main_113:
    cmp	w4,	#0
    blt	main_124

main_115:
    ldr	w0,	[sp, #80]

    cmp	w4,	w0
    bge	main_125

main_117:
    ldr	w15,	[sp, #76]

    ldr	w16,	[sp, #76]

    mul	w3,	w4,	w15
    madd	w0,	w4,	w16,	w24

    adrp	x3, :got:image
    lsl	w12,	w0,	#2
    ldr	x3, [x3, #:got_lo12:image]
    add	x1,	x3,	x12
    ldr	w0,	[x1]

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
    ldr	w17,	[sp, #76]

    add	w26,	w23,	#1
    cmp	w26,	w17
    bge	main_132

main_73:
    mov	w23,	w26
    b	main_74

main_132:
    movz	w0,	#10
    bl	putch
    ldr	w25,	[sp, #80]

    add	w9,	w27,	#1
    cmp	w9,	w25
    bge	main_137

main_66:
    mov	w27,	w9
    b	main_67

main_137:
    movz	w19,	#0
    b	main_138

main_136:
    movz	w19,	#0
    b	main_138

main_135:
    mov	w19,	w28

main_138:
    mov	w0,	w19
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #192
    ret


