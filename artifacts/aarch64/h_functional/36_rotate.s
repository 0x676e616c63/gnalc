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
    str	s0,	[sp, #44]

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
    mov	w22,	w0
    bl	getint
    mov	w28,	w0
    cmp	w22,	#1024
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
    mov	w21,	w28
    mov	w20,	w22
    str	w21,	[sp, #68]

    str	w20,	[sp, #72]

    b	main_43

main_19:
    movz	w3,	#0
    movz	w25,	#0
    mov	w26,	w3

main_21:
    movz	w24,	#0
    mov	w19,	w24

main_24:
    cmp	w19,	w22
    bge	main_32

main_27:
    add	w24,	w19,	w25
    lsl	w18,	w24,	#2
    adrp	x24, :got:image
    ldr	x24, [x24, #:got_lo12:image]
    add	x27,	x24,	x18
    bl	getint
    add	w24,	w19,	#1
    str	w0,	[x27]

    mov	w19,	w24
    b	main_24

main_32:
    add	w4,	w26,	#1
    add	w25,	w25,	w22
    cmp	w4,	w28
    bge	main_42

main_20:
    mov	w26,	w4
    b	main_21

main_42:
    movz	w7,	#0
    mov	w27,	w28
    mov	w20,	w22
    str	w27,	[sp, #68]

    str	w20,	[sp, #72]

    b	main_43

main_40:
    mov	w7,	w23
    mov	w27,	w28
    mov	w20,	w22
    str	w27,	[sp, #68]

    str	w20,	[sp, #72]

    b	main_43

main_39:
    mov	w7,	w23
    mov	w27,	w28
    mov	w20,	w22
    str	w27,	[sp, #68]

    str	w20,	[sp, #72]

    b	main_43

main_38:
    mov	w7,	w23
    mov	w27,	w28
    mov	w20,	w22
    str	w27,	[sp, #68]

    str	w20,	[sp, #72]

    b	main_43

main_37:
    mov	w7,	w23
    movz	w19,	#0
    movz	w1,	#0
    str	w19,	[sp, #68]

    str	w1,	[sp, #72]

    b	main_43

main_36:
    mov	w7,	w23
    movz	w20,	#0
    movz	w2,	#0
    str	w20,	[sp, #68]

    str	w2,	[sp, #72]


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
    ldr	w18,	[sp, #68]

    movz	w8,	#0
    cmp	w8,	w18
    bge	main_136

main_50:
    movz	w11,	#4059
    movz	w13,	#4059
    movk	w11,	#16585,	lsl #16
    movk	w13,	#16329,	lsl #16
    fmov	s20,	w11
    fmov	s3,	w13
    str	s20,	[sp, #16]

    ldr	s11,	[sp, #44]

    ldr	s29,	[sp, #16]

    ldr	s10,	[sp, #16]

    fdiv	s18,	s11,	s29
    ldr	s12,	[sp, #44]

    frintz	s13,	s18
    fcvtzs	w0,	s18
    fmul	s22,	s13,	s10
    fsub	s8,	s12,	s22
    str	s8,	[sp, #52]

    ldr	s14,	[sp, #44]

    fadd	s13,	s14,	s3
    str	s13,	[sp, #40]

    ldr	s8,	[sp, #16]

    ldr	s4,	[sp, #40]

    ldr	s7,	[sp, #16]

    fdiv	s17,	s4,	s8
    ldr	s5,	[sp, #40]

    fcvtzs	w6,	s17
    frintz	s17,	s17
    fmul	s22,	s17,	s7
    fsub	s12,	s5,	s22
    str	s12,	[sp, #56]

    ldr	w0,	[sp, #72]

    ldr	w3,	[sp, #72]

    asr	w12,	w0,	#31
    ldr	w17,	[sp, #68]

    lsr	w13,	w12,	#31
    ldr	w26,	[sp, #68]

    asr	w7,	w17,	#31
    add	w14,	w3,	w13
    lsr	w8,	w7,	#31
    asr	w21,	w14,	#1
    add	w9,	w26,	w8
    scvtf	s16,	w21
    asr	w22,	w9,	#1
    str	w22,	[sp, #164]

    str	s16,	[sp, #60]

    ldr	w23,	[sp, #164]

    scvtf	s19,	w23
    movz	w23,	#0
    str	s19,	[sp, #64]

    mov	w27,	w23

main_67:
    movz	w14,	#0
    ldr	w26,	[sp, #72]

    cmp	w14,	w26
    bge	main_132

main_70:
    ldr	w1,	[sp, #164]

    movz	w24,	#0
    sub	w15,	w27,	w1
    mov	w22,	w24
    scvtf	s9,	w15
    str	s9,	[sp, #36]


main_74:
    movz	w19,	#4059
    ldr	s11,	[sp, #44]

    movk	w19,	#49353,	lsl #16
    fmov	s10,	w19
    fmov	s15,	s10
    fcmp	s11,	s15
    ldr	s13,	[sp, #44]

    cset	w25,	lt
    ldr	s9,	[sp, #52]

    fcsel	s9,	s9,	s13,	lt
    ldr	s13,	[sp, #16]

    ldr	s11,	[sp, #44]

    fcmp	s11,	s13
    cset	w25,	gt
    ldr	s10,	[sp, #52]

    movz	w25,	#4059
    ldr	s12,	[sp, #16]

    fcsel	s13,	s10,	s9,	gt
    movk	w25,	#16457,	lsl #16
    fsub	s12,	s13,	s12
    fmov	s10,	w25
    fcmp	s13,	s10
    cset	w24,	gt
    fcsel	s13,	s12,	s13,	gt
    movz	w25,	#4059
    str	s13,	[sp, #24]

    movk	w25,	#49225,	lsl #16
    ldr	s11,	[sp, #16]

    ldr	s9,	[sp, #24]

    ldr	s13,	[sp, #24]

    fadd	s11,	s9,	s11
    fmov	s9,	w25
    fmov	s12,	s9
    fcmp	s13,	s12
    ldr	s14,	[sp, #24]

    cset	w25,	lt
    fcsel	s0,	s11,	s14,	lt
    bl	my_sin_impl
    ldr	s11,	[sp, #40]

    fmov	s13,	s0
    fcmp	s11,	s15
    ldr	s14,	[sp, #40]

    cset	w24,	lt
    ldr	s11,	[sp, #56]

    ldr	s8,	[sp, #16]

    fcsel	s15,	s11,	s14,	lt
    str	s8,	[sp, #32]

    ldr	s11,	[sp, #32]

    ldr	s9,	[sp, #40]

    fcmp	s9,	s11
    cset	w23,	gt
    ldr	s14,	[sp, #56]

    fcsel	s8,	s14,	s15,	gt
    str	s8,	[sp, #28]

    ldr	s11,	[sp, #16]

    ldr	s14,	[sp, #28]

    ldr	s15,	[sp, #28]

    fsub	s11,	s14,	s11
    fcmp	s15,	s10
    ldr	s9,	[sp, #28]

    cset	w19,	gt
    fcsel	s11,	s11,	s9,	gt
    ldr	s9,	[sp, #16]

    fadd	s15,	s11,	s9
    fcmp	s11,	s12
    fcsel	s0,	s15,	s11,	lt
    cset	w23,	lt
    bl	my_sin_impl
    sub	w9,	w22,	w21
    ldr	s30,	[sp, #36]

    ldr	s7,	[sp, #60]

    fmul	s29,	s30,	s13
    ldr	s3,	[sp, #36]

    scvtf	s28,	w9
    ldr	s20,	[sp, #64]

    fmul	s2,	s3,	s0
    fmul	s1,	s28,	s13
    fmul	s11,	s28,	s0
    fadd	s5,	s1,	s2
    fsub	s17,	s11,	s29
    fadd	s4,	s5,	s20
    fadd	s16,	s17,	s7
    fcvtzs	w8,	s4
    fcvtzs	w15,	s16
    cmp	w15,	#0
    blt	main_122

main_111:
    ldr	w20,	[sp, #72]

    cmp	w15,	w20
    bge	main_123

main_113:
    cmp	w8,	#0
    blt	main_124

main_115:
    ldr	w2,	[sp, #68]

    cmp	w8,	w2
    bge	main_125

main_117:
    ldr	w23,	[sp, #72]

    adrp	x19, :got:image
    ldr	w24,	[sp, #72]

    mul	w12,	w8,	w23
    ldr	x19, [x19, #:got_lo12:image]
    madd	w3,	w8,	w24,	w15

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
    ldr	w20,	[sp, #68]

    add	w23,	w27,	#1
    cmp	w23,	w20
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


