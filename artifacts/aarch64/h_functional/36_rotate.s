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
    sub	sp, sp, #192
    stp	fp, lr, [sp, #0]
    
    bl	getfloat
    str	s0,	[sp, #44]

    bl	getch
    bl	getch
    movz	w27,	#65535
    movk	w27,	#65535,	lsl #16
    mov	w21,	w27
    cmp	w0,	#80
    beq	main_5

main_36:
    mov	w7,	w21
    movz	w14,	#0
    movz	w26,	#0
    str	w14,	[sp, #20]

    str	w26,	[sp, #72]

    b	main_43

main_5:
    bl	getch
    cmp	w0,	#50
    beq	main_8

main_37:
    mov	w7,	w21
    movz	w15,	#0
    movz	w27,	#0
    str	w15,	[sp, #20]

    str	w27,	[sp, #72]

    b	main_43

main_8:
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w27,	w0
    cmp	w19,	#1024
    ble	main_12

main_38:
    mov	w7,	w21
    str	w27,	[sp, #20]

    str	w19,	[sp, #72]

    b	main_43

main_12:
    cmp	w27,	#1024
    ble	main_14

main_39:
    mov	w7,	w21
    str	w27,	[sp, #20]

    str	w19,	[sp, #72]

    b	main_43

main_14:
    bl	getint
    cmp	w0,	#255
    beq	main_17

main_40:
    mov	w7,	w21
    mov	w28,	w27
    str	w28,	[sp, #20]

    str	w19,	[sp, #72]

    b	main_43

main_17:
    movz	w8,	#0
    cmp	w8,	w27
    bge	main_41

main_19:
    movz	w23,	#0
    movz	w4,	#0
    mov	w25,	w4

main_21:
    movz	w4,	#0
    mov	w24,	w4

main_24:
    cmp	w24,	w19
    blt	main_27

main_32:
    add	w24,	w23,	#1
    add	w4,	w25,	w19
    cmp	w24,	w27
    blt	main_20

main_42:
    movz	w7,	#0
    str	w27,	[sp, #20]

    str	w19,	[sp, #72]

    b	main_43

main_20:
    mov	w23,	w24
    mov	w25,	w4
    b	main_21

main_27:
    add	w26,	w24,	w25
    adrp	x28, :got:image
    ldr	x28, [x28, #:got_lo12:image]
    lsl	w22,	w26,	#2
    add	x26,	x28,	x22
    bl	getint
    add	w4,	w24,	#1
    str	w0,	[x26]

    mov	w24,	w4
    b	main_24

main_41:
    movz	w7,	#0
    mov	w24,	w27
    mov	w22,	w19
    str	w24,	[sp, #20]

    str	w22,	[sp, #72]


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
    ldr	w0,	[sp, #20]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#255
    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w18,	[sp, #20]

    movz	w8,	#0
    cmp	w8,	w18
    blt	main_50

main_136:
    movz	w21,	#0
    b	main_138

main_50:
    movz	w12,	#4059
    movz	w14,	#4059
    movz	w23,	#0
    movk	w12,	#16585,	lsl #16
    movk	w14,	#16329,	lsl #16
    mov	w27,	w23
    fmov	s20,	w12
    fmov	s3,	w14
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
    fsub	s15,	s5,	s22
    str	s15,	[sp, #60]

    ldr	w0,	[sp, #72]

    ldr	w3,	[sp, #72]

    asr	w12,	w0,	#31
    lsr	w13,	w12,	#31
    add	w14,	w3,	w13
    asr	w8,	w14,	#1
    str	w8,	[sp, #76]

    ldr	w16,	[sp, #20]

    ldr	w20,	[sp, #20]

    asr	w15,	w16,	#31
    ldr	w9,	[sp, #76]

    lsr	w16,	w15,	#31
    scvtf	s19,	w9
    str	s19,	[sp, #64]

    add	w17,	w20,	w16
    asr	w19,	w17,	#1
    scvtf	s12,	w19
    str	s12,	[sp, #56]


main_67:
    movz	w14,	#0
    ldr	w6,	[sp, #72]

    cmp	w14,	w6
    bge	main_132

main_70:
    sub	w9,	w27,	w19
    movz	w24,	#0
    mov	w22,	w24
    scvtf	s9,	w9
    str	s9,	[sp, #36]


main_74:
    movz	w21,	#4059
    ldr	s12,	[sp, #44]

    movk	w21,	#49353,	lsl #16
    fmov	s10,	w21
    fmov	s11,	s10
    fcmp	s12,	s11
    cset	w23,	lt
    ldr	s14,	[sp, #44]

    ldr	s9,	[sp, #52]

    ldr	s15,	[sp, #16]

    fcsel	s9,	s9,	s14,	lt
    ldr	s12,	[sp, #44]

    fcmp	s12,	s15
    cset	w21,	gt
    ldr	s10,	[sp, #52]

    movz	w18,	#4059
    ldr	s13,	[sp, #16]

    fcsel	s9,	s10,	s9,	gt
    movk	w18,	#16457,	lsl #16
    fsub	s13,	s9,	s13
    fmov	s15,	w18
    fmov	s10,	s15
    fcmp	s9,	s10
    cset	w21,	gt
    fcsel	s14,	s13,	s9,	gt
    movz	w23,	#4059
    str	s14,	[sp, #24]

    movk	w23,	#49225,	lsl #16
    ldr	s12,	[sp, #16]

    ldr	s9,	[sp, #24]

    ldr	s14,	[sp, #24]

    fadd	s13,	s9,	s12
    fmov	s9,	w23
    fcmp	s14,	s9
    ldr	s15,	[sp, #24]

    cset	w21,	lt
    fcsel	s0,	s13,	s15,	lt
    bl	my_sin_impl
    ldr	s14,	[sp, #40]

    fmov	s13,	s0
    fcmp	s14,	s11
    ldr	s14,	[sp, #40]

    cset	w21,	lt
    ldr	s8,	[sp, #60]

    ldr	s11,	[sp, #16]

    fcsel	s15,	s8,	s14,	lt
    str	s11,	[sp, #32]

    ldr	s12,	[sp, #32]

    ldr	s11,	[sp, #40]

    fcmp	s11,	s12
    ldr	s11,	[sp, #60]

    cset	w18,	gt
    fcsel	s8,	s11,	s15,	gt
    str	s8,	[sp, #28]

    ldr	s11,	[sp, #16]

    ldr	s14,	[sp, #28]

    ldr	s15,	[sp, #28]

    fsub	s12,	s14,	s11
    fcmp	s15,	s10
    fmov	s15,	s9
    ldr	s10,	[sp, #28]

    cset	w24,	gt
    fcsel	s12,	s12,	s10,	gt
    ldr	s10,	[sp, #16]

    fadd	s11,	s12,	s10
    fcmp	s12,	s15
    fcsel	s0,	s11,	s12,	lt
    cset	w18,	lt
    bl	my_sin_impl
    ldr	w17,	[sp, #76]

    ldr	s30,	[sp, #36]

    sub	w15,	w22,	w17
    ldr	s10,	[sp, #64]

    fmul	s29,	s30,	s13
    ldr	s3,	[sp, #36]

    scvtf	s28,	w15
    fmul	s2,	s3,	s0
    fmul	s1,	s28,	s13
    fmul	s11,	s28,	s0
    ldr	s13,	[sp, #56]

    fadd	s5,	s1,	s2
    fsub	s17,	s11,	s29
    fadd	s4,	s5,	s13
    fadd	s16,	s17,	s10
    fcvtzs	w23,	s4
    fcvtzs	w24,	s16
    cmp	w24,	#0
    bge	main_111

main_122:
    movz	w0,	#0
    b	main_126

main_111:
    ldr	w13,	[sp, #72]

    cmp	w24,	w13
    blt	main_113

main_123:
    movz	w0,	#0
    b	main_126

main_113:
    cmp	w23,	#0
    bge	main_115

main_124:
    movz	w0,	#0
    b	main_126

main_115:
    ldr	w3,	[sp, #20]

    cmp	w23,	w3
    blt	main_117

main_125:
    movz	w0,	#0
    b	main_126

main_117:
    ldr	w14,	[sp, #72]

    adrp	x6, :got:image
    ldr	w15,	[sp, #72]

    mul	w13,	w23,	w14
    ldr	x6, [x6, #:got_lo12:image]
    madd	w8,	w23,	w15,	w24

    lsl	w10,	w8,	#2
    add	x9,	x6,	x10
    ldr	w0,	[x9]


main_126:
    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w10,	[sp, #72]

    add	w24,	w22,	#1
    cmp	w24,	w10
    blt	main_73

main_132:
    movz	w0,	#10
    bl	putch
    add	w23,	w27,	#1
    ldr	w27,	[sp, #20]

    cmp	w23,	w27
    blt	main_66

main_137:
    movz	w21,	#0

main_138:
    mov	w0,	w21
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #192
    ret


main_66:
    mov	w27,	w23
    b	main_67

main_73:
    mov	w22,	w24
    b	main_74

