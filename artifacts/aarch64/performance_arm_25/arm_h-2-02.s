.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#39216
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#22
    bl	_sysy_starttime
    fmov	s2,	#1.000000
    movz	w24,	#0
    movi	v11.4s,	#0
    movz	w26,	#0
    add	x25,	sp,	#16
    movi	v10.4s,	#0
    movz	fp,	#19616
    add	x13,	sp,	fp

main_6:
    movz	w15,	#10
    movz	w28,	#52429
    movz	w1,	#52429
    movk	w28,	#15820,	lsl #16
    sdiv	w16,	w26,	w15
    movk	w1,	#15948,	lsl #16
    fmov	s14,	w28
    lsl	w17,	w16,	#1
    fmov	s17,	w1
    fadd	s24,	s10,	s14
    add	w8,	w17,	w16,	lsl #3
    fadd	s9,	s2,	s17
    sub	w16,	w26,	w8
    cmp	w16,	#0
    fmov	s15,	#1.000000
    movi	v26.4s,	#0
    fcsel	s2,	s15,	s9,	ne
    fcsel	s10,	s26,	s24,	ne

main_18:
    movz	w11,	#4900
    cmp	w24,	w11
    bge	main_28

main_21:
    lsl	w4,	w24,	#2
    movz	fp,	#19616
    scvtf	s19,	w24
    lsl	w8,	w24,	#2
    mov	x3,	x4
    fadd	s29,	s2,	s19
    fadd	s26,	s10,	s19
    add	w24,	w24,	#1
    mov	x7,	x8
    add	x3,	sp,	x3
    add	x7,	sp,	x7
    add	x3,	x3,	fp
    add	x7,	x7,	#16
    str	s26,	[x3]

    str	s29,	[x7]

    b	main_18

main_28:
    movz	w15,	#0
    movi	v19.4s,	#0

main_29:
    movz	w4,	#4896
    cmp	w15,	w4
    bge	main_92

main_33:
    lsl	w19,	w15,	#2
    lsl	w22,	w15,	#2
    add	w17,	w15,	#1
    add	x18,	x13,	x19
    add	x21,	x25,	x22
    add	w3,	w17,	#1
    lsl	w0,	w17,	#2
    lsl	w23,	w17,	#2
    ldr	s15,	[x18]

    add	x28,	x25,	x0
    ldr	s1,	[x21]

    add	w12,	w3,	#1
    lsl	w9,	w3,	#2
    lsl	w6,	w3,	#2
    add	x22,	x13,	x23
    fmul	s3,	s15,	s1
    add	x8,	x25,	x9
    add	w0,	w12,	#1
    lsl	w19,	w12,	#2
    lsl	w16,	w12,	#2
    add	x5,	x13,	x6
    ldr	s8,	[x22]

    fadd	s26,	s19,	s3
    add	w14,	w0,	#1
    lsl	w2,	w0,	#2
    add	x18,	x25,	x19
    add	x15,	x13,	x16
    ldr	s18,	[x28]

    add	x1,	x25,	x2
    add	w23,	w14,	#1
    lsl	w11,	w14,	#2
    lsl	w28,	w0,	#2
    fmul	s19,	s8,	s18
    add	x10,	x25,	x11
    fadd	s5,	s26,	s19
    lsl	w21,	w23,	#2
    add	x27,	x13,	x28
    ldr	s19,	[x5]

    add	x20,	x25,	x21
    ldr	s27,	[x8]

    lsl	w8,	w14,	#2
    ldr	s29,	[x15]

    fmul	s28,	s19,	s27
    ldr	s6,	[x18]

    add	x7,	x13,	x8
    fadd	s18,	s5,	s28
    lsl	w18,	w23,	#2
    ldr	s8,	[x27]

    fmul	s7,	s29,	s6
    ldr	s17,	[x1]

    add	x17,	x13,	x18
    fadd	s28,	s18,	s7
    ldr	s19,	[x7]

    fmul	s18,	s8,	s17
    ldr	s26,	[x10]

    fadd	s7,	s28,	s18
    add	w10,	w23,	#1
    ldr	s29,	[x17]

    fmul	s27,	s19,	s26
    ldr	s5,	[x20]

    fadd	s20,	s7,	s27
    fmul	s6,	s29,	s5
    add	w15,	w10,	#1
    lsl	w4,	w10,	#2
    lsl	w1,	w10,	#2
    fadd	s30,	s20,	s6
    add	x3,	x25,	x4
    add	x0,	x13,	x1
    ldr	s8,	[x0]

    ldr	s16,	[x3]

    fmul	s17,	s8,	s16
    fadd	s19,	s30,	s17
    b	main_29

main_92:
    lsl	w19,	w15,	#2
    lsl	w22,	w15,	#2
    add	w15,	w15,	#1
    add	x21,	x25,	x22
    add	x18,	x13,	x19
    movz	w22,	#4900
    ldr	s6,	[x18]

    ldr	s23,	[x21]

    fmul	s24,	s6,	s23
    fadd	s19,	s19,	s24
    cmp	w15,	w22
    blt	main_92

main_103:
    fadd	s11,	s11,	s19
    add	w26,	w26,	#1
    movz	w7,	#41248
    movk	w7,	#7,	lsl #16
    cmp	w26,	w7
    blt	main_6

main_107:
    movz	w0,	#39
    bl	_sysy_stoptime
    movz	w15,	#14269
    movz	w13,	#61523
    movk	w15,	#13702,	lsl #16
    movk	w13,	#23179,	lsl #16
    fmov	s8,	w15
    fmov	s26,	w13
    fsub	s3,	s11,	s26
    frintz	s10,	s3
    fcvtzs	w7,	s3
    fcmp	s10,	s8
    bgt	main_117

main_112:
    movz	w17,	#14269
    movk	w17,	#46470,	lsl #16
    fmov	s11,	w17
    fcmp	s10,	s11
    blt	main_117

main_114:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0
    b	main_118

main_117:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1

main_118:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#39216
    add	sp, sp, fp
    ret


