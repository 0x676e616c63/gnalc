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
    str	s0,	[sp, #24]

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
    mov	w24,	w0
    bl	getint
    mov	w28,	w0
    cmp	w24,	#1024
    bgt	main_38

main_12:
    cmp	w28,	#1024
    bgt	main_39

main_14:
    bl	getint
    cmp	w0,	#255
    bne	main_40

main_17:
    movz	w8,	#0
    cmp	w8,	w28
    blt	main_19

main_41:
    movz	w7,	#0
    str	w28,	[sp, #76]

    mov	w20,	w24
    str	w20,	[sp, #80]

    b	main_43

main_19:
    movz	w26,	#0
    movz	w23,	#0
    mov	w25,	w26
    mov	w19,	w23

main_21:
    movz	w22,	#0
    mov	w26,	w22

main_24:
    cmp	w26,	w24
    bge	main_32

main_27:
    add	w27,	w26,	w19
    adrp	x23, :got:image
    ldr	x23, [x23, #:got_lo12:image]
    lsl	w27,	w27,	#2
    add	x20,	x23,	x27
    bl	getint
    add	w22,	w26,	#1
    str	w0,	[x20]

    mov	w26,	w22
    b	main_24

main_32:
    add	w1,	w25,	#1
    add	w23,	w19,	w24
    cmp	w1,	w28
    bge	main_42

main_20:
    mov	w25,	w1
    mov	w19,	w23
    b	main_21

main_42:
    movz	w7,	#0
    str	w28,	[sp, #76]

    mov	w20,	w24
    str	w20,	[sp, #80]

    b	main_43

main_40:
    mov	w7,	w21
    str	w28,	[sp, #76]

    mov	w20,	w24
    str	w20,	[sp, #80]

    b	main_43

main_39:
    mov	w7,	w21
    str	w28,	[sp, #76]

    mov	w20,	w24
    str	w20,	[sp, #80]

    b	main_43

main_38:
    mov	w7,	w21
    str	w28,	[sp, #76]

    mov	w20,	w24
    str	w20,	[sp, #80]

    b	main_43

main_37:
    mov	w7,	w21
    movz	w26,	#0
    movz	w9,	#0
    str	w26,	[sp, #76]

    str	w9,	[sp, #80]

    b	main_43

main_36:
    mov	w7,	w21
    movz	w27,	#0
    movz	w10,	#0
    str	w27,	[sp, #76]

    str	w10,	[sp, #80]


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
    ldr	w0,	[sp, #80]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w0,	[sp, #76]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#255
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w24,	[sp, #76]

    movz	w8,	#0
    cmp	w8,	w24
    bge	main_136

main_50:
    movz	w11,	#4059
    movz	w13,	#4059
    movz	w23,	#0
    movk	w11,	#16585,	lsl #16
    movk	w13,	#16329,	lsl #16
    fmov	s21,	w11
    fmov	s3,	w13
    str	s21,	[sp, #16]

    ldr	s12,	[sp, #24]

    ldr	s30,	[sp, #16]

    ldr	s10,	[sp, #16]

    fdiv	s18,	s12,	s30
    frintz	s13,	s18
    fcvtzs	w0,	s18
    fmul	s22,	s13,	s10
    ldr	s13,	[sp, #24]

    fsub	s16,	s13,	s22
    str	s16,	[sp, #60]

    ldr	s15,	[sp, #24]

    fadd	s14,	s15,	s3
    str	s14,	[sp, #44]

    ldr	s8,	[sp, #16]

    ldr	s5,	[sp, #44]

    ldr	s7,	[sp, #16]

    fdiv	s17,	s5,	s8
    ldr	s6,	[sp, #44]

    fcvtzs	w6,	s17
    frintz	s17,	s17
    fmul	s22,	s17,	s7
    fsub	s12,	s6,	s22
    str	s12,	[sp, #52]

    ldr	w6,	[sp, #80]

    ldr	w9,	[sp, #80]

    asr	w12,	w6,	#31
    lsr	w13,	w12,	#31
    add	w14,	w9,	w13
    asr	w27,	w14,	#1
    str	w27,	[sp, #188]

    mov	w27,	w23
    ldr	w24,	[sp, #76]

    ldr	w1,	[sp, #76]

    asr	w7,	w24,	#31
    ldr	w2,	[sp, #188]

    lsr	w8,	w7,	#31
    scvtf	s20,	w2
    str	s20,	[sp, #64]

    add	w9,	w1,	w8
    asr	w20,	w9,	#1
    scvtf	s9,	w20
    str	s9,	[sp, #48]


main_67:
    movz	w14,	#0
    ldr	w2,	[sp, #80]

    cmp	w14,	w2
    bge	main_132

main_70:
    sub	w15,	w27,	w20
    movz	w24,	#0
    mov	w22,	w24
    scvtf	s10,	w15
    str	s10,	[sp, #40]


main_74:
    movz	w19,	#4059
    ldr	s13,	[sp, #24]

    movk	w19,	#49353,	lsl #16
    fmov	s10,	w19
    fmov	s12,	s10
    fcmp	s13,	s12
    ldr	s15,	[sp, #24]

    cset	w21,	lt
    ldr	s10,	[sp, #60]

    fcsel	s9,	s10,	s15,	lt
    ldr	s15,	[sp, #16]

    ldr	s13,	[sp, #24]

    fcmp	s13,	s15
    cset	w21,	gt
    ldr	s11,	[sp, #60]

    movz	w25,	#4059
    ldr	s13,	[sp, #16]

    fcsel	s9,	s11,	s9,	gt
    movk	w25,	#16457,	lsl #16
    fsub	s15,	s9,	s13
    fmov	s10,	w25
    fmov	s11,	s10
    fcmp	s9,	s11
    cset	w21,	gt
    fcsel	s14,	s15,	s9,	gt
    movz	w23,	#4059
    str	s14,	[sp, #20]

    movk	w23,	#49225,	lsl #16
    ldr	s13,	[sp, #16]

    ldr	s9,	[sp, #20]

    fmov	s15,	w23
    ldr	s14,	[sp, #20]

    fadd	s10,	s9,	s13
    fmov	s9,	s15
    fcmp	s14,	s9
    ldr	s15,	[sp, #20]

    cset	w23,	lt
    fcsel	s0,	s10,	s15,	lt
    bl	my_sin_impl
    ldr	s10,	[sp, #44]

    fmov	s13,	s0
    fcmp	s10,	s12
    cset	w24,	lt
    ldr	s15,	[sp, #44]

    ldr	s12,	[sp, #52]

    ldr	s8,	[sp, #16]

    fcsel	s15,	s12,	s15,	lt
    str	s8,	[sp, #32]

    ldr	s14,	[sp, #32]

    ldr	s10,	[sp, #44]

    fcmp	s10,	s14
    cset	w23,	gt
    ldr	s14,	[sp, #52]

    fcsel	s12,	s14,	s15,	gt
    str	s12,	[sp, #72]

    ldr	s12,	[sp, #16]

    str	s12,	[sp, #36]

    ldr	s12,	[sp, #36]

    ldr	s10,	[sp, #72]

    fsub	s14,	s10,	s12
    fmov	s10,	s11
    str	s14,	[sp, #28]

    ldr	s15,	[sp, #72]

    fcmp	s15,	s10
    fmov	s15,	s9
    ldr	s12,	[sp, #28]

    cset	w24,	gt
    ldr	s8,	[sp, #72]

    ldr	s10,	[sp, #16]

    fcsel	s12,	s12,	s8,	gt
    fadd	s11,	s12,	s10
    fcmp	s12,	s15
    fcsel	s0,	s11,	s12,	lt
    cset	w25,	lt
    bl	my_sin_impl
    ldr	w7,	[sp, #188]

    ldr	s31,	[sp, #40]

    sub	w9,	w22,	w7
    fmul	s29,	s31,	s13
    scvtf	s28,	w9
    fmul	s1,	s28,	s13
    fmul	s11,	s28,	s0
    fsub	s17,	s11,	s29
    ldr	s11,	[sp, #64]

    ldr	s4,	[sp, #40]

    fadd	s16,	s17,	s11
    ldr	s10,	[sp, #48]

    fmul	s2,	s4,	s0
    fcvtzs	w15,	s16
    fadd	s5,	s1,	s2
    fadd	s4,	s5,	s10
    fcvtzs	w8,	s4
    cmp	w15,	#0
    blt	main_122

main_111:
    ldr	w3,	[sp, #80]

    cmp	w15,	w3
    bge	main_123

main_113:
    cmp	w8,	#0
    blt	main_124

main_115:
    ldr	w10,	[sp, #76]

    cmp	w8,	w10
    bge	main_125

main_117:
    ldr	w0,	[sp, #80]

    adrp	x19, :got:image
    ldr	w1,	[sp, #80]

    mul	w12,	w8,	w0
    ldr	x19, [x19, #:got_lo12:image]
    madd	w3,	w8,	w1,	w15

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
    ldr	w6,	[sp, #80]

    add	w24,	w22,	#1
    cmp	w24,	w6
    bge	main_132

main_73:
    mov	w22,	w24
    b	main_74

main_132:
    movz	w0,	#10
    bl	putch
    ldr	w0,	[sp, #76]

    add	w23,	w27,	#1
    cmp	w23,	w0
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


