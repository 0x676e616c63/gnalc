.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#16400
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w22,	w0
    movz	w0,	#22
    bl	_sysy_starttime
    movi	v11.4s,	#0
    movz	w20,	#0
    fmov	s2,	#1.000000
    movi	v10.4s,	#0
    movz	w11,	#0
    add	x14,	sp,	#16
    movz	fp,	#8208
    add	x24,	sp,	fp

main_7:
    movz	w16,	#10
    movz	w10,	#52429
    movk	w10,	#15820,	lsl #16
    sdiv	w4,	w20,	w16
    fmov	s22,	w10
    lsl	w2,	w4,	#1
    fadd	s23,	s10,	s22
    add	w13,	w2,	w4,	lsl #3
    sub	w26,	w20,	w13
    movz	w13,	#52429
    movk	w13,	#15948,	lsl #16
    fmov	s28,	w13
    fadd	s8,	s2,	s28
    cmp	w26,	#0
    fmov	s26,	#1.000000
    movi	v9.4s,	#0
    fcsel	s2,	s26,	s8,	ne
    fcsel	s10,	s9,	s23,	ne

main_19:
    cmp	w11,	w22
    blt	main_22

main_29:
    movz	w3,	#0
    movi	v18.4s,	#0

main_30:
    cmp	w3,	w22
    blt	main_34

main_42:
    fadd	s11,	s11,	s18
    add	w20,	w20,	#1
    movz	w17,	#41248
    movk	w17,	#7,	lsl #16
    cmp	w20,	w17
    blt	main_7

main_46:
    movz	w0,	#39
    bl	_sysy_stoptime
    movz	w4,	#14269
    movz	w2,	#39872
    movk	w4,	#13702,	lsl #16
    movk	w2,	#22690,	lsl #16
    fmov	s2,	w4
    fmov	s3,	w2
    fsub	s4,	s11,	s3
    fcmp	s4,	s2
    bgt	main_54

main_49:
    movz	w6,	#14269
    movk	w6,	#46470,	lsl #16
    fmov	s5,	w6
    fcmp	s4,	s5
    bge	main_51

main_54:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1
    b	main_55

main_51:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0

main_55:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#16400
    add	sp, sp, fp
    ret


main_34:
    lsl	w6,	w3,	#2
    lsl	w9,	w3,	#2
    add	w3,	w3,	#1
    add	x8,	x14,	x9
    add	x5,	x24,	x6
    ldr	s9,	[x5]

    ldr	s29,	[x8]

    fmul	s30,	s9,	s29
    fadd	s18,	s18,	s30
    b	main_30

main_22:
    lsl	w28,	w11,	#2
    movz	fp,	#8208
    scvtf	s5,	w11
    lsl	w3,	w11,	#2
    mov	x27,	x28
    fadd	s16,	s2,	s5
    fadd	s13,	s10,	s5
    add	w11,	w11,	#1
    mov	x2,	x3
    add	x27,	sp,	x27
    add	x2,	sp,	x2
    add	x27,	x27,	fp
    add	x2,	x2,	#16
    str	s13,	[x27]

    str	s16,	[x2]

    b	main_19

