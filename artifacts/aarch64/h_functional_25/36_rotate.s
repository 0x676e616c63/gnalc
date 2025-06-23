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
    sub	sp, sp, #176
    stp	fp, lr, [sp, #0]
    
    bl	getfloat
    str	s0,	[sp, #40]

    bl	getch
    bl	getch
    movz	w1,	#65535
    movk	w1,	#65535,	lsl #16
    mov	w23,	w1
    cmp	w0,	#80
    bne	main_36

main_5:
    bl	getch
    cmp	w0,	#50
    bne	main_37

main_8:
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w21,	w0
    cmp	w19,	#1024
    bgt	main_38

main_12:
    cmp	w21,	#1024
    bgt	main_39

main_14:
    bl	getint
    cmp	w0,	#255
    bne	main_40

main_17:
    movz	w8,	#0
    cmp	w8,	w21
    blt	main_19

main_41:
    movz	w7,	#0
    str	w21,	[sp, #68]

    str	w19,	[sp, #72]

    b	main_43

main_19:
    movz	w3,	#0
    movz	w24,	#0
    mov	w26,	w3

main_21:
    movz	w22,	#0
    mov	w28,	w22

main_24:
    cmp	w28,	w19
    bge	main_32

main_27:
    add	w22,	w28,	w24
    adrp	x25, :got:image
    ldr	x25, [x25, #:got_lo12:image]
    lsl	w27,	w22,	#2
    add	x25,	x25,	x27
    bl	getint
    add	w22,	w28,	#1
    str	w0,	[x25]

    mov	w28,	w22
    b	main_24

main_32:
    add	w4,	w26,	#1
    add	w24,	w24,	w19
    cmp	w4,	w21
    bge	main_42

main_20:
    mov	w26,	w4
    b	main_21

main_42:
    movz	w7,	#0
    mov	w25,	w21
    str	w25,	[sp, #68]

    str	w19,	[sp, #72]

    b	main_43

main_40:
    mov	w7,	w23
    mov	w25,	w21
    str	w25,	[sp, #68]

    str	w19,	[sp, #72]

    b	main_43

main_39:
    mov	w7,	w23
    mov	w25,	w21
    str	w25,	[sp, #68]

    str	w19,	[sp, #72]

    b	main_43

main_38:
    mov	w7,	w23
    mov	w25,	w21
    str	w25,	[sp, #68]

    str	w19,	[sp, #72]

    b	main_43

main_37:
    mov	w7,	w23
    movz	w17,	#0
    movz	w1,	#0
    str	w17,	[sp, #68]

    str	w1,	[sp, #72]

    b	main_43

main_36:
    mov	w7,	w23
    movz	w18,	#0
    movz	w0,	#0
    str	w18,	[sp, #68]

    str	w0,	[sp, #72]


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
    ldr	w0,	[sp, #72]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w0,	[sp, #68]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#255
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w16,	[sp, #68]

    movz	w8,	#0
    cmp	w8,	w16
    bge	main_136

main_50:
    movz	w11,	#4059
    movz	w13,	#4059
    movz	w23,	#0
    movk	w11,	#16585,	lsl #16
    movk	w13,	#16329,	lsl #16
    fmov	s17,	w11
    fmov	s3,	w13
    str	s17,	[sp, #16]

    ldr	s9,	[sp, #40]

    ldr	s27,	[sp, #16]

    ldr	s10,	[sp, #16]

    fdiv	s18,	s9,	s27
    frintz	s13,	s18
    fcvtzs	w0,	s18
    fmul	s22,	s13,	s10
    ldr	s10,	[sp, #40]

    fsub	s6,	s10,	s22
    str	s6,	[sp, #48]

    ldr	s12,	[sp, #40]

    fadd	s11,	s12,	s3
    str	s11,	[sp, #36]

    ldr	s8,	[sp, #16]

    ldr	s3,	[sp, #36]

    ldr	s7,	[sp, #16]

    fdiv	s17,	s3,	s8
    ldr	s4,	[sp, #36]

    fcvtzs	w6,	s17
    frintz	s17,	s17
    fmul	s22,	s17,	s7
    fsub	s13,	s4,	s22
    str	s13,	[sp, #56]

    ldr	w27,	[sp, #72]

    ldr	w1,	[sp, #72]

    asr	w12,	w27,	#31
    ldr	w15,	[sp, #68]

    mov	w27,	w23
    lsr	w13,	w12,	#31
    ldr	w24,	[sp, #68]

    asr	w7,	w15,	#31
    add	w14,	w1,	w13
    lsr	w8,	w7,	#31
    asr	w21,	w14,	#1
    add	w9,	w24,	w8
    scvtf	s10,	w21
    asr	w19,	w9,	#1
    str	w19,	[sp, #164]

    str	s10,	[sp, #52]

    ldr	w20,	[sp, #164]

    scvtf	s17,	w20
    str	s17,	[sp, #60]


main_67:
    movz	w14,	#0
    ldr	w22,	[sp, #72]

    cmp	w14,	w22
    bge	main_132

main_70:
    ldr	w28,	[sp, #164]

    movz	w24,	#0
    sub	w15,	w27,	w28
    mov	w22,	w24
    scvtf	s7,	w15
    str	s7,	[sp, #32]


main_74:
    movz	w19,	#4059
    ldr	s8,	[sp, #40]

    movk	w19,	#49353,	lsl #16
    fmov	s10,	w19
    fmov	s12,	s10
    fcmp	s8,	s12
    cset	w25,	lt
    ldr	s10,	[sp, #40]

    ldr	s15,	[sp, #48]

    fcsel	s10,	s15,	s10,	lt
    ldr	s9,	[sp, #16]

    ldr	s8,	[sp, #40]

    fcmp	s8,	s9
    cset	w25,	gt
    ldr	s8,	[sp, #48]

    movz	w25,	#4059
    fcsel	s9,	s8,	s10,	gt
    movk	w25,	#16457,	lsl #16
    ldr	s8,	[sp, #16]

    fsub	s15,	s9,	s8
    fmov	s10,	w25
    fcmp	s9,	s10
    cset	w24,	gt
    fcsel	s15,	s15,	s9,	gt
    ldr	s8,	[sp, #16]

    movz	w25,	#4059
    fadd	s14,	s15,	s8
    movk	w25,	#49225,	lsl #16
    str	s14,	[sp, #20]

    fmov	s9,	w25
    fcmp	s15,	s9
    ldr	s13,	[sp, #20]

    cset	w25,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    fmov	s15,	s12
    fmov	s13,	s0
    ldr	s12,	[sp, #36]

    fcmp	s12,	s15
    cset	w24,	lt
    ldr	s15,	[sp, #36]

    ldr	s14,	[sp, #56]

    fcsel	s12,	s14,	s15,	lt
    ldr	s14,	[sp, #16]

    str	s14,	[sp, #28]

    ldr	s15,	[sp, #28]

    ldr	s11,	[sp, #36]

    fcmp	s11,	s15
    cset	w23,	gt
    ldr	s15,	[sp, #56]

    fmov	s11,	s10
    fcsel	s12,	s15,	s12,	gt
    str	s12,	[sp, #24]

    ldr	s14,	[sp, #16]

    ldr	s15,	[sp, #24]

    fmov	s8,	s14
    ldr	s10,	[sp, #24]

    fsub	s15,	s15,	s8
    fcmp	s10,	s11
    ldr	s10,	[sp, #24]

    cset	w19,	gt
    fcsel	s12,	s15,	s10,	gt
    ldr	s10,	[sp, #16]

    fadd	s15,	s12,	s10
    fcmp	s12,	s9
    fcsel	s0,	s15,	s12,	lt
    cset	w23,	lt
    bl	my_sin_impl
    sub	w9,	w22,	w21
    ldr	s27,	[sp, #32]

    ldr	s1,	[sp, #52]

    fmul	s29,	s27,	s13
    ldr	s31,	[sp, #32]

    scvtf	s28,	w9
    ldr	s18,	[sp, #60]

    fmul	s2,	s31,	s0
    fmul	s11,	s28,	s0
    fsub	s17,	s11,	s29
    fadd	s16,	s17,	s1
    fmul	s1,	s28,	s13
    fcvtzs	w15,	s16
    fadd	s5,	s1,	s2
    fadd	s4,	s5,	s18
    fcvtzs	w8,	s4
    cmp	w15,	#0
    blt	main_122

main_111:
    ldr	w18,	[sp, #72]

    cmp	w15,	w18
    bge	main_123

main_113:
    cmp	w8,	#0
    blt	main_124

main_115:
    ldr	w0,	[sp, #68]

    cmp	w8,	w0
    bge	main_125

main_117:
    ldr	w19,	[sp, #72]

    ldr	w20,	[sp, #72]

    mul	w12,	w8,	w19
    madd	w3,	w8,	w20,	w15

    adrp	x19, :got:image
    lsl	w5,	w3,	#2
    ldr	x19, [x19, #:got_lo12:image]
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
    ldr	w0,	[sp, #72]

    add	w24,	w22,	#1
    cmp	w24,	w0
    bge	main_132

main_73:
    mov	w22,	w24
    b	main_74

main_132:
    movz	w0,	#10
    bl	putch
    ldr	w18,	[sp, #68]

    add	w23,	w27,	#1
    cmp	w23,	w18
    bge	main_137

main_66:
    mov	w27,	w23
    b	main_67

main_137:
    movz	w23,	#0
    b	main_138

main_136:
    movz	w23,	#0

main_138:
    mov	w0,	w23
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #176
    ret


