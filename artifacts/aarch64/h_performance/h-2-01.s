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
    movz	fp,	#40016
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#22
    bl	_sysy_starttime
    fmov	s2,	#1.000000
    movi	v10.4s,	#0
    movi	v11.4s,	#0
    movz	w11,	#0
    add	x13,	sp,	#16
    movz	w20,	#0
    movz	fp,	#20016
    add	x22,	sp,	fp

main_6:
    movz	w0,	#10
    movz	w9,	#52429
    movz	w12,	#52429
    movk	w9,	#15820,	lsl #16
    sdiv	w4,	w20,	w0
    movk	w12,	#15948,	lsl #16
    fmov	s30,	w9
    lsl	w1,	w4,	#1
    fmov	s4,	w12
    fadd	s23,	s10,	s30
    add	w25,	w1,	w4,	lsl #3
    fadd	s8,	s2,	s4
    sub	w16,	w20,	w25
    cmp	w16,	#0
    fmov	s1,	#1.000000
    movi	v14.4s,	#0
    fcsel	s2,	s1,	s8,	ne
    fcsel	s10,	s14,	s23,	ne

main_18:
    movz	w28,	#5000
    cmp	w11,	w28
    blt	main_21

main_28:
    movz	w3,	#0
    movi	v18.4s,	#0

main_29:
    movz	w18,	#5000
    cmp	w3,	w18
    blt	main_33

main_90:
    fadd	s11,	s11,	s18
    add	w20,	w20,	#1
    movz	w1,	#41248
    movk	w1,	#7,	lsl #16
    cmp	w20,	w1
    blt	main_6

main_94:
    movz	w0,	#39
    bl	_sysy_stoptime
    movz	w28,	#14269
    movz	w26,	#3406
    movk	w28,	#13702,	lsl #16
    movk	w26,	#23188,	lsl #16
    fmov	s6,	w28
    fmov	s7,	w26
    fsub	s4,	s11,	s7
    fcvtzs	w2,	s4
    frintz	s4,	s4
    fcmp	s4,	s6
    bgt	main_104

main_99:
    movz	w1,	#14269
    movk	w1,	#46470,	lsl #16
    fmov	s9,	w1
    fcmp	s4,	s9
    bge	main_101

main_104:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1
    b	main_105

main_101:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0

main_105:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#40016
    add	sp, sp, fp
    ret


main_33:
    lsl	w18,	w3,	#2
    lsl	w23,	w3,	#2
    add	w15,	w3,	#1
    add	x17,	x22,	x18
    add	x21,	x13,	x23
    add	w1,	w15,	#1
    lsl	w27,	w15,	#2
    lsl	w24,	w15,	#2
    ldr	s12,	[x17]

    add	x26,	x13,	x27
    ldr	s30,	[x21]

    add	w10,	w1,	#1
    lsl	w7,	w1,	#2
    lsl	w4,	w1,	#2
    add	x23,	x22,	x24
    fmul	s31,	s12,	s30
    add	x6,	x13,	x7
    lsl	w18,	w10,	#2
    lsl	w15,	w10,	#2
    add	x3,	x22,	x4
    add	w24,	w10,	#1
    ldr	s6,	[x23]

    fadd	s24,	s18,	s31
    add	x17,	x13,	x18
    add	x14,	x22,	x15
    add	w12,	w24,	#1
    lsl	w0,	w24,	#2
    ldr	s16,	[x26]

    add	x28,	x13,	x0
    lsl	w26,	w24,	#2
    lsl	w9,	w12,	#2
    fmul	s17,	s6,	s16
    add	w24,	w12,	#1
    add	x25,	x22,	x26
    add	x8,	x13,	x9
    fadd	s3,	s24,	s17
    ldr	s17,	[x3]

    lsl	w21,	w24,	#2
    ldr	s25,	[x6]

    lsl	w6,	w12,	#2
    ldr	s27,	[x14]

    fmul	s26,	s17,	s25
    add	x19,	x13,	x21
    add	x5,	x22,	x6
    ldr	s4,	[x17]

    fadd	s16,	s3,	s26
    add	w6,	w24,	#1
    ldr	s6,	[x25]

    lsl	w17,	w24,	#2
    fmul	s5,	s27,	s4
    ldr	s15,	[x28]

    lsl	w2,	w6,	#2
    add	w3,	w6,	#1
    add	x16,	x22,	x17
    fadd	s26,	s16,	s5
    lsl	w28,	w6,	#2
    ldr	s17,	[x5]

    add	x1,	x13,	x2
    fmul	s16,	s6,	s15
    add	x27,	x22,	x28
    ldr	s24,	[x8]

    fadd	s5,	s26,	s16
    ldr	s27,	[x16]

    fmul	s25,	s17,	s24
    ldr	s3,	[x19]

    fadd	s18,	s5,	s25
    ldr	s6,	[x27]

    fmul	s4,	s27,	s3
    ldr	s14,	[x1]

    fadd	s28,	s18,	s4
    fmul	s15,	s6,	s14
    fadd	s18,	s28,	s15
    b	main_29

main_21:
    lsl	w8,	w11,	#2
    movz	fp,	#20016
    scvtf	s17,	w11
    lsl	w14,	w11,	#2
    mov	x7,	x8
    fadd	s24,	s2,	s17
    fadd	s21,	s10,	s17
    add	w11,	w11,	#1
    mov	x12,	x14
    add	x7,	sp,	x7
    add	x12,	sp,	x12
    add	x7,	x7,	fp
    add	x12,	x12,	#16
    str	s21,	[x7]

    str	s24,	[x12]

    b	main_18

