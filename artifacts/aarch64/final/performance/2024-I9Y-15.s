.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#16
    movk	fp,	#1,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w24,	w0
    movz	w0,	#22
    bl	_sysy_starttime
    fmov	s12,	#1.000000
    movi	v11.4s,	#0
    movz	w2,	#0
    movz	w6,	#0
    add	x14,	sp,	#16
    movi	v26.4s,	#0
    movz	fp,	#32784
    add	x21,	sp,	fp

main_7:
    movz	w17,	#10
    movz	w12,	#52429
    movk	w12,	#15820,	lsl #16
    sdiv	w5,	w6,	w17
    fmov	s21,	w12
    lsl	w3,	w5,	#1
    fadd	s23,	s26,	s21
    add	w15,	w3,	w5,	lsl #3
    sub	w26,	w6,	w15
    movz	w15,	#52429
    movk	w15,	#15948,	lsl #16
    fmov	s28,	w15
    fadd	s8,	s12,	s28
    cmp	w26,	#0
    fmov	s25,	#1.000000
    movi	v9.4s,	#0
    fcsel	s12,	s25,	s8,	ne
    fcsel	s26,	s9,	s23,	ne

main_19:
    cmp	w2,	w24
    bge	main_29

main_22:
    lsl	w9,	w2,	#2
    movz	fp,	#32784
    scvtf	s17,	w2
    lsl	w13,	w2,	#2
    mov	x8,	x9
    fadd	s28,	s12,	s17
    fadd	s24,	s26,	s17
    add	w2,	w2,	#1
    mov	x12,	x13
    add	x8,	sp,	x8
    add	x12,	sp,	x12
    add	x8,	x8,	fp
    add	x12,	x12,	#16
    str	s24,	[x8]

    str	s28,	[x12]

    b	main_19

main_29:
    movz	w26,	#0
    movi	v5.4s,	#0

main_30:
    cmp	w26,	w24
    bge	main_42

main_34:
    lsl	w9,	w26,	#2
    lsl	w12,	w26,	#2
    add	w26,	w26,	#1
    add	x11,	x14,	x12
    add	x8,	x21,	x9
    ldr	s13,	[x8]

    ldr	s31,	[x11]

    fmul	s1,	s13,	s31
    fadd	s5,	s5,	s1
    b	main_30

main_42:
    fadd	s11,	s11,	s5
    add	w6,	w6,	#1
    movz	w22,	#34464
    movk	w22,	#1,	lsl #16
    cmp	w6,	w22
    blt	main_7

main_46:
    movz	w0,	#39
    bl	_sysy_stoptime
    movz	w4,	#14269
    movz	w2,	#19627
    movk	w4,	#13702,	lsl #16
    movk	w2,	#23170,	lsl #16
    fmov	s6,	w4
    fmov	s21,	w2
    fsub	s22,	s11,	s21
    fcmp	s22,	s6
    bgt	main_54

main_49:
    movz	w6,	#14269
    movk	w6,	#46470,	lsl #16
    fmov	s9,	w6
    fcmp	s22,	s9
    blt	main_54

main_51:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0
    b	main_55

main_54:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1

main_55:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#16
    movk	fp,	#1,	lsl #16
    add	sp, sp, fp
    ret


