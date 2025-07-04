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
    movz	fp,	#39216
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#22
    bl	_sysy_starttime
    fmov	s2,	#1.000000
    movi	v10.4s,	#0
    movz	w11,	#0
    movz	w20,	#0
    add	x24,	sp,	#16
    movi	v11.4s,	#0
    movz	fp,	#19616
    add	x15,	sp,	fp

main_6:
    movz	w16,	#10
    movz	w28,	#52429
    movz	w1,	#52429
    movk	w28,	#15820,	lsl #16
    sdiv	w17,	w20,	w16
    movk	w1,	#15948,	lsl #16
    fmov	s14,	w28
    lsl	w18,	w17,	#1
    fmov	s17,	w1
    fadd	s24,	s10,	s14
    add	w8,	w18,	w17,	lsl #3
    fadd	s9,	s2,	s17
    sub	w17,	w20,	w8
    cmp	w17,	#0
    fmov	s15,	#1.000000
    movi	v26.4s,	#0
    fcsel	s2,	s15,	s9,	ne
    fcsel	s10,	s26,	s24,	ne

main_18:
    movz	w12,	#4900
    cmp	w11,	w12
    blt	main_21

main_28:
    movz	w6,	#0
    movi	v19.4s,	#0

main_29:
    movz	w2,	#4896
    cmp	w6,	w2
    blt	main_33

main_92:
    lsl	w10,	w6,	#2
    lsl	w14,	w6,	#2
    movz	w3,	#4900
    add	w6,	w6,	#1
    add	x13,	x24,	x14
    add	x9,	x15,	x10
    ldr	s4,	[x9]

    ldr	s24,	[x13]

    fmul	s25,	s4,	s24
    fadd	s19,	s19,	s25
    cmp	w6,	w3
    blt	main_92

main_103:
    fadd	s11,	s11,	s19
    add	w20,	w20,	#1
    movz	w17,	#41248
    movk	w17,	#7,	lsl #16
    cmp	w20,	w17
    blt	main_6

main_107:
    movz	w0,	#39
    bl	_sysy_stoptime
    movz	w15,	#14269
    movz	w13,	#61523
    movk	w15,	#13702,	lsl #16
    movk	w13,	#23179,	lsl #16
    fmov	s21,	w15
    fmov	s22,	w13
    fsub	s16,	s11,	s22
    fcvtzs	w14,	s16
    frintz	s16,	s16
    fcmp	s16,	s21
    bgt	main_117

main_112:
    movz	w17,	#14269
    movk	w17,	#46470,	lsl #16
    fmov	s24,	w17
    fcmp	s16,	s24
    bge	main_114

main_117:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1
    b	main_118

main_114:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0

main_118:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#39216
    add	sp, sp, fp
    ret


main_33:
    lsl	w3,	w6,	#2
    lsl	w7,	w6,	#2
    add	w4,	w6,	#1
    add	x2,	x15,	x3
    add	x5,	x24,	x7
    add	w14,	w4,	#1
    lsl	w10,	w4,	#2
    ldr	s26,	[x2]

    lsl	w7,	w4,	#2
    add	x9,	x24,	x10
    ldr	s14,	[x5]

    lsl	w22,	w14,	#2
    lsl	w18,	w14,	#2
    add	w4,	w14,	#1
    add	x6,	x15,	x7
    fmul	s15,	s26,	s14
    add	x21,	x24,	x22
    add	x17,	x15,	x18
    fadd	s6,	s19,	s15
    add	w16,	w4,	#1
    lsl	w3,	w4,	#2
    lsl	w0,	w4,	#2
    ldr	s20,	[x6]

    add	x2,	x24,	x3
    ldr	s28,	[x9]

    lsl	w13,	w16,	#2
    add	w27,	w16,	#1
    add	x28,	x15,	x0
    lsl	w9,	w16,	#2
    ldr	s30,	[x17]

    fmul	s29,	s20,	s28
    add	x12,	x24,	x13
    lsl	w25,	w27,	#2
    add	x8,	x15,	x9
    ldr	s7,	[x21]

    fadd	s19,	s6,	s29
    add	x23,	x24,	x25
    ldr	s9,	[x28]

    lsl	w21,	w27,	#2
    fmul	s8,	s30,	s7
    ldr	s18,	[x2]

    add	x19,	x15,	x21
    fadd	s29,	s19,	s8
    ldr	s20,	[x8]

    fmul	s19,	s9,	s18
    ldr	s27,	[x12]

    fadd	s8,	s29,	s19
    add	w12,	w27,	#1
    ldr	s30,	[x19]

    fmul	s28,	s20,	s27
    ldr	s6,	[x23]

    fadd	s21,	s8,	s28
    fmul	s7,	s30,	s6
    lsl	w5,	w12,	#2
    lsl	w2,	w12,	#2
    add	w23,	w12,	#1
    fadd	s31,	s21,	s7
    add	x4,	x24,	x5
    add	x1,	x15,	x2
    add	w6,	w23,	#1
    lsl	w16,	w23,	#2
    lsl	w12,	w23,	#2
    ldr	s9,	[x1]

    add	x14,	x24,	x16
    ldr	s17,	[x4]

    add	x10,	x15,	x12
    fmul	s18,	s9,	s17
    fadd	s12,	s31,	s18
    ldr	s20,	[x10]

    ldr	s26,	[x14]

    fmul	s27,	s20,	s26
    fadd	s19,	s12,	s27
    b	main_29

main_21:
    lsl	w23,	w11,	#2
    movz	fp,	#19616
    scvtf	s30,	w11
    lsl	w28,	w11,	#2
    mov	x22,	x23
    fadd	s6,	s2,	s30
    fadd	s3,	s10,	s30
    add	w11,	w11,	#1
    mov	x27,	x28
    add	x22,	sp,	x22
    add	x27,	sp,	x27
    add	x22,	x22,	fp
    add	x27,	x27,	#16
    str	s3,	[x22]

    str	s6,	[x27]

    b	main_18

