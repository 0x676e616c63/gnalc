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
    movz	fp,	#48016
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#22
    bl	_sysy_starttime
    fmov	s1,	#1.000000
    movi	v9.4s,	#0
    movi	v10.4s,	#0
    movz	w20,	#0
    movz	fp,	#24016
    add	x12,	sp,	#16
    add	x23,	sp,	fp

main_6:
    movz	w14,	#10
    movz	w17,	#52429
    movz	w19,	#52429
    movk	w17,	#15820,	lsl #16
    sdiv	w0,	w20,	w14
    movk	w19,	#15948,	lsl #16
    fmov	s29,	w17
    lsl	w9,	w0,	#1
    fmov	s31,	w19
    fadd	s21,	s9,	s29
    add	w18,	w9,	w0,	lsl #3
    fadd	s6,	s1,	s31
    sub	w26,	w20,	w18
    cmp	w26,	#0
    movz	w10,	#0
    fmov	s29,	#1.000000
    movi	v8.4s,	#0
    fcsel	s1,	s29,	s6,	ne
    fcsel	s9,	s8,	s21,	ne

main_17:
    movz	w0,	#6000
    cmp	w10,	w0
    blt	main_20

main_69:
    movz	w11,	#0
    movi	v17.4s,	#0

main_70:
    movz	w1,	#6000
    cmp	w11,	w1
    blt	main_74

main_131:
    fadd	s10,	s10,	s17
    add	w20,	w20,	#1
    movz	w2,	#6000
    cmp	w20,	w2
    blt	main_6

main_135:
    movz	w0,	#40
    bl	_sysy_stoptime
    movz	w10,	#14269
    movz	w8,	#30497
    movk	w10,	#13702,	lsl #16
    movk	w8,	#22468,	lsl #16
    fmov	s30,	w10
    fmov	s31,	w8
    fsub	s3,	s10,	s31
    frintz	s4,	s3
    fcvtzs	w1,	s3
    fcmp	s4,	s30
    bgt	main_145

main_140:
    movz	w12,	#14269
    movk	w12,	#46470,	lsl #16
    fmov	s2,	w12
    fcmp	s4,	s2
    bge	main_142

main_145:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1
    b	main_146

main_142:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0

main_146:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#48016
    add	sp, sp, fp
    ret


main_74:
    lsl	w10,	w11,	#2
    lsl	w15,	w11,	#2
    add	w26,	w11,	#1
    add	x9,	x12,	x10
    add	x14,	x23,	x15
    add	w8,	w26,	#1
    lsl	w19,	w26,	#2
    lsl	w16,	w26,	#2
    ldr	s11,	[x9]

    add	x18,	x23,	x19
    ldr	s29,	[x14]

    add	w21,	w8,	#1
    lsl	w1,	w8,	#2
    lsl	w27,	w8,	#2
    add	x15,	x12,	x16
    fmul	s30,	s11,	s29
    add	x0,	x23,	x1
    add	w2,	w21,	#1
    lsl	w10,	w21,	#2
    lsl	w7,	w21,	#2
    add	x26,	x12,	x27
    ldr	s5,	[x15]

    fadd	s23,	s17,	s30
    add	w14,	w2,	#1
    lsl	w17,	w2,	#2
    add	x9,	x23,	x10
    lsl	w21,	w2,	#2
    add	x6,	x12,	x7
    ldr	s15,	[x18]

    lsl	w28,	w14,	#2
    add	x16,	x12,	x17
    lsl	w2,	w14,	#2
    add	x19,	x23,	x21
    fmul	s16,	s5,	s15
    add	x27,	x12,	x28
    add	x1,	x23,	x2
    fadd	s2,	s23,	s16
    ldr	s16,	[x26]

    ldr	s24,	[x0]

    ldr	s26,	[x6]

    fmul	s25,	s16,	s24
    ldr	s3,	[x9]

    fadd	s15,	s2,	s25
    ldr	s5,	[x16]

    fmul	s4,	s26,	s3
    ldr	s14,	[x19]

    fadd	s25,	s15,	s4
    ldr	s16,	[x27]

    fmul	s15,	s5,	s14
    add	w27,	w14,	#1
    ldr	s23,	[x1]

    fadd	s4,	s25,	s15
    fmul	s24,	s16,	s23
    fadd	s17,	s4,	s24
    lsl	w11,	w27,	#2
    lsl	w8,	w27,	#2
    add	x10,	x23,	x11
    add	x7,	x12,	x8
    ldr	s26,	[x7]

    add	w7,	w27,	#1
    ldr	s2,	[x10]

    fmul	s3,	s26,	s2
    fadd	s27,	s17,	s3
    add	w11,	w7,	#1
    lsl	w22,	w7,	#2
    lsl	w18,	w7,	#2
    add	x21,	x23,	x22
    add	x17,	x12,	x18
    ldr	s5,	[x17]

    ldr	s13,	[x21]

    fmul	s14,	s5,	s13
    fadd	s17,	s27,	s14
    b	main_70

main_20:
    lsl	w7,	w10,	#2
    scvtf	s16,	w10
    lsl	w13,	w10,	#2
    movz	fp,	#24016
    add	w2,	w10,	#1
    mov	x6,	x7
    fadd	s23,	s1,	s16
    fadd	s20,	s9,	s16
    mov	x11,	x13
    add	x6,	sp,	x6
    add	w10,	w2,	#1
    scvtf	s24,	w2
    lsl	w8,	w2,	#2
    lsl	w13,	w2,	#2
    add	x11,	sp,	x11
    add	x6,	x6,	#16
    lsl	w22,	w10,	#2
    scvtf	s3,	w10
    lsl	w17,	w10,	#2
    fadd	s31,	s1,	s24
    fadd	s28,	s9,	s24
    mov	x7,	x8
    add	x11,	x11,	fp
    str	s20,	[x6]

    mov	x21,	x22
    fadd	s11,	s1,	s3
    fadd	s6,	s9,	s3
    mov	x16,	x17
    add	x7,	sp,	x7
    movz	fp,	#24016
    str	s23,	[x11]

    add	w22,	w10,	#1
    add	x21,	sp,	x21
    add	x16,	sp,	x16
    add	x7,	x7,	#16
    mov	x11,	x13
    add	w4,	w22,	#1
    lsl	w2,	w22,	#2
    scvtf	s13,	w22
    lsl	w27,	w22,	#2
    add	x16,	x16,	#16
    str	s28,	[x7]

    add	x11,	sp,	x11
    add	w13,	w4,	#1
    lsl	w10,	w4,	#2
    scvtf	s21,	w4
    lsl	w6,	w4,	#2
    mov	x1,	x2
    fadd	s19,	s1,	s13
    fadd	s16,	s9,	s13
    mov	x26,	x27
    add	x11,	x11,	fp
    lsl	w19,	w13,	#2
    scvtf	s30,	w13
    lsl	w15,	w13,	#2
    mov	x9,	x10
    fadd	s27,	s1,	s21
    fadd	s24,	s9,	s21
    mov	x5,	x6
    add	x1,	sp,	x1
    add	x26,	sp,	x26
    movz	fp,	#24016
    str	s31,	[x11]

    mov	x18,	x19
    fadd	s5,	s1,	s30
    fadd	s2,	s9,	s30
    mov	x14,	x15
    add	x9,	sp,	x9
    add	x5,	sp,	x5
    add	x26,	x26,	#16
    add	x21,	x21,	fp
    str	s6,	[x16]

    add	x18,	sp,	x18
    add	x14,	sp,	x14
    add	x5,	x5,	#16
    movz	fp,	#24016
    str	s11,	[x21]

    add	x14,	x14,	#16
    add	x1,	x1,	fp
    str	s16,	[x26]

    movz	fp,	#24016
    add	w26,	w13,	#1
    str	s19,	[x1]

    add	x9,	x9,	fp
    str	s24,	[x5]

    movz	fp,	#24016
    add	w10,	w26,	#1
    lsl	w0,	w26,	#2
    scvtf	s8,	w26
    lsl	w25,	w26,	#2
    str	s27,	[x9]

    add	x18,	x18,	fp
    lsl	w8,	w10,	#2
    scvtf	s18,	w10
    lsl	w4,	w10,	#2
    mov	x28,	x0
    fadd	s15,	s1,	s8
    fadd	s12,	s9,	s8
    mov	x24,	x25
    str	s2,	[x14]

    movz	fp,	#24016
    mov	x7,	x8
    fadd	s23,	s1,	s18
    fadd	s20,	s9,	s18
    add	w10,	w10,	#1
    mov	x3,	x4
    add	x28,	sp,	x28
    add	x24,	sp,	x24
    str	s5,	[x18]

    add	x7,	sp,	x7
    add	x3,	sp,	x3
    add	x28,	x28,	fp
    add	x24,	x24,	#16
    movz	fp,	#24016
    add	x3,	x3,	#16
    str	s12,	[x24]

    add	x7,	x7,	fp
    str	s15,	[x28]

    str	s20,	[x3]

    str	s23,	[x7]

    b	main_17

