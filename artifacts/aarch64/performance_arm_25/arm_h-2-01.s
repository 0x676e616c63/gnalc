.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#40016
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#22
    bl	_sysy_starttime
    fmov	s12,	#1.000000
    movi	v26.4s,	#0
    movz	w2,	#0
    movz	w6,	#0
    add	x12,	sp,	#16
    movi	v11.4s,	#0
    movz	fp,	#20016
    add	x19,	sp,	fp

main_6:
    movz	w0,	#10
    movz	w11,	#52429
    movz	w14,	#52429
    movk	w11,	#15820,	lsl #16
    sdiv	w5,	w6,	w0
    movk	w14,	#15948,	lsl #16
    fmov	s30,	w11
    lsl	w1,	w5,	#1
    fmov	s3,	w14
    fadd	s23,	s26,	s30
    add	w25,	w1,	w5,	lsl #3
    fadd	s8,	s12,	s3
    sub	w17,	w6,	w25
    cmp	w17,	#0
    fmov	s1,	#1.000000
    movi	v14.4s,	#0
    fcsel	s12,	s1,	s8,	ne
    fcsel	s26,	s14,	s23,	ne

main_18:
    movz	w28,	#5000
    cmp	w2,	w28
    bge	main_28

main_21:
    lsl	w3,	w2,	#2
    movz	fp,	#20016
    scvtf	s16,	w2
    lsl	w8,	w2,	#2
    mov	x1,	x3
    fadd	s27,	s12,	s16
    fadd	s23,	s26,	s16
    add	w2,	w2,	#1
    mov	x7,	x8
    add	x1,	sp,	x1
    add	x7,	sp,	x7
    add	x1,	x1,	fp
    add	x7,	x7,	#16
    str	s23,	[x1]

    str	s27,	[x7]

    b	main_18

main_28:
    movz	w26,	#0
    movi	v5.4s,	#0

main_29:
    movz	w20,	#5000
    cmp	w26,	w20
    bge	main_90

main_33:
    lsl	w18,	w26,	#2
    lsl	w22,	w26,	#2
    add	w16,	w26,	#1
    add	x17,	x19,	x18
    add	x21,	x12,	x22
    add	w1,	w16,	#1
    lsl	w27,	w16,	#2
    lsl	w24,	w16,	#2
    ldr	s10,	[x17]

    add	x26,	x12,	x27
    ldr	s30,	[x21]

    add	w13,	w1,	#1
    lsl	w9,	w1,	#2
    lsl	w5,	w1,	#2
    add	x23,	x19,	x24
    fmul	s31,	s10,	s30
    add	x8,	x12,	x9
    lsl	w20,	w13,	#2
    lsl	w16,	w13,	#2
    add	x4,	x19,	x5
    add	w24,	w13,	#1
    fadd	s23,	s5,	s31
    add	x18,	x12,	x20
    add	x15,	x19,	x16
    ldr	s5,	[x23]

    add	w14,	w24,	#1
    lsl	w0,	w24,	#2
    ldr	s15,	[x26]

    add	x28,	x12,	x0
    lsl	w26,	w24,	#2
    lsl	w11,	w14,	#2
    fmul	s16,	s5,	s15
    add	w24,	w14,	#1
    add	x25,	x19,	x26
    add	x10,	x12,	x11
    fadd	s2,	s23,	s16
    ldr	s16,	[x4]

    lsl	w22,	w24,	#2
    ldr	s24,	[x8]

    lsl	w8,	w14,	#2
    ldr	s27,	[x15]

    fmul	s25,	s16,	s24
    add	x21,	x12,	x22
    add	x7,	x19,	x8
    ldr	s3,	[x18]

    fadd	s15,	s2,	s25
    add	w8,	w24,	#1
    lsl	w18,	w24,	#2
    ldr	s5,	[x25]

    fmul	s4,	s27,	s3
    ldr	s14,	[x28]

    add	w26,	w8,	#1
    lsl	w3,	w8,	#2
    add	x17,	x19,	x18
    fadd	s25,	s15,	s4
    lsl	w28,	w8,	#2
    ldr	s16,	[x7]

    add	x1,	x12,	x3
    fmul	s15,	s5,	s14
    add	x27,	x19,	x28
    ldr	s23,	[x10]

    fadd	s4,	s25,	s15
    ldr	s27,	[x17]

    fmul	s24,	s16,	s23
    ldr	s2,	[x21]

    fadd	s17,	s4,	s24
    ldr	s5,	[x27]

    fmul	s3,	s27,	s2
    ldr	s13,	[x1]

    fadd	s28,	s17,	s3
    fmul	s14,	s5,	s13
    fadd	s5,	s28,	s14
    b	main_29

main_90:
    fadd	s11,	s11,	s5
    add	w6,	w6,	#1
    movz	w21,	#41248
    movk	w21,	#7,	lsl #16
    cmp	w6,	w21
    blt	main_6

main_94:
    movz	w0,	#39
    bl	_sysy_stoptime
    movz	w28,	#14269
    movz	w26,	#3406
    movk	w28,	#13702,	lsl #16
    movk	w26,	#23188,	lsl #16
    fmov	s24,	w28
    fmov	s10,	w26
    fsub	s22,	s11,	s10
    frintz	s28,	s22
    fcvtzs	w24,	s22
    fcmp	s28,	s24
    bgt	main_104

main_99:
    movz	w1,	#14269
    movk	w1,	#46470,	lsl #16
    fmov	s27,	w1
    fcmp	s28,	s27
    blt	main_104

main_101:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0
    b	main_105

main_104:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1

main_105:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#40016
    add	sp, sp, fp
    ret


