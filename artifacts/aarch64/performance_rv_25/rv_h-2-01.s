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
    fmov	s11,	#1.000000
    movi	v10.4s,	#0
    movi	v25.4s,	#0
    movz	w6,	#0
    movz	fp,	#20016
    add	x21,	sp,	#16
    add	x12,	sp,	fp

main_6:
    movz	w13,	#10
    movz	w16,	#52429
    movz	w18,	#52429
    movk	w16,	#15820,	lsl #16
    sdiv	w27,	w6,	w13
    movk	w18,	#15948,	lsl #16
    fmov	s27,	w16
    lsl	w8,	w27,	#1
    fmov	s29,	w18
    fadd	s21,	s25,	s27
    add	w17,	w8,	w27,	lsl #3
    fadd	s7,	s11,	s29
    sub	w26,	w6,	w17
    cmp	w26,	#0
    movz	w1,	#0
    fmov	s27,	#1.000000
    movi	v6.4s,	#0
    fcsel	s11,	s27,	s7,	ne
    fcsel	s25,	s6,	s21,	ne

main_17:
    movz	w27,	#5000
    cmp	w1,	w27
    bge	main_69

main_20:
    lsl	w2,	w1,	#2
    scvtf	s15,	w1
    lsl	w7,	w1,	#2
    movz	fp,	#20016
    add	w15,	w1,	#1
    mov	x0,	x2
    fadd	s26,	s11,	s15
    fadd	s22,	s25,	s15
    mov	x5,	x7
    add	x0,	sp,	x0
    add	w24,	w15,	#1
    lsl	w10,	w15,	#2
    scvtf	s23,	w15
    add	x5,	sp,	x5
    add	x0,	x0,	#16
    mov	x9,	x10
    add	w3,	w24,	#1
    lsl	w19,	w24,	#2
    scvtf	s2,	w24
    fadd	s3,	s11,	s23
    fadd	s31,	s25,	s23
    add	x5,	x5,	fp
    str	s22,	[x0]

    add	x9,	sp,	x9
    add	w17,	w3,	#1
    lsl	w28,	w3,	#2
    scvtf	s12,	w3
    mov	x18,	x19
    fadd	s13,	s11,	s2
    fadd	s8,	s25,	s2
    movz	fp,	#20016
    str	s26,	[x5]

    lsl	w8,	w17,	#2
    add	w26,	w17,	#1
    scvtf	s20,	w17
    mov	x27,	x28
    fadd	s21,	s11,	s12
    fadd	s18,	s25,	s12
    add	x18,	sp,	x18
    add	x9,	x9,	fp
    lsl	w5,	w15,	#2
    mov	x7,	x8
    lsl	w13,	w26,	#2
    fadd	s30,	s11,	s20
    fadd	s27,	s25,	s20
    add	x27,	sp,	x27
    movz	fp,	#20016
    lsl	w15,	w24,	#2
    mov	x4,	x5
    add	x7,	sp,	x7
    mov	x11,	x13
    add	x18,	x18,	fp
    lsl	w24,	w3,	#2
    mov	x14,	x15
    add	w5,	w26,	#1
    add	x4,	sp,	x4
    add	x11,	sp,	x11
    movz	fp,	#20016
    lsl	w3,	w17,	#2
    mov	x23,	x24
    add	x14,	sp,	x14
    add	w19,	w5,	#1
    lsl	w22,	w5,	#2
    add	x4,	x4,	#16
    add	x11,	x11,	#16
    add	x27,	x27,	fp
    lsl	w17,	w26,	#2
    mov	x2,	x3
    add	x23,	sp,	x23
    add	x14,	x14,	#16
    lsl	w1,	w19,	#2
    mov	x20,	x22
    str	s31,	[x4]

    movz	fp,	#20016
    mov	x16,	x17
    add	x2,	sp,	x2
    add	x23,	x23,	#16
    mov	x0,	x1
    add	x20,	sp,	x20
    str	s3,	[x9]

    add	x7,	x7,	fp
    add	x16,	sp,	x16
    add	x2,	x2,	#16
    add	w1,	w19,	#1
    add	x0,	sp,	x0
    add	x20,	x20,	#16
    str	s8,	[x14]

    movz	fp,	#20016
    str	s13,	[x18]

    add	x0,	x0,	#16
    add	x16,	x16,	fp
    str	s18,	[x23]

    movz	fp,	#20016
    str	s21,	[x27]

    str	s27,	[x2]

    str	s30,	[x7]

    scvtf	s30,	w26
    fadd	s7,	s11,	s30
    lsl	w26,	w5,	#2
    fadd	s4,	s25,	s30
    mov	x25,	x26
    str	s4,	[x11]

    add	x25,	sp,	x25
    str	s7,	[x16]

    scvtf	s7,	w5
    add	x25,	x25,	fp
    lsl	w5,	w19,	#2
    fadd	s17,	s11,	s7
    fadd	s14,	s25,	s7
    movz	fp,	#20016
    mov	x4,	x5
    str	s14,	[x20]

    add	x4,	sp,	x4
    str	s17,	[x25]

    scvtf	s17,	w19
    add	x4,	x4,	fp
    fadd	s26,	s11,	s17
    fadd	s22,	s25,	s17
    str	s22,	[x0]

    str	s26,	[x4]

    b	main_17

main_69:
    movz	w2,	#0
    movi	v4.4s,	#0

main_70:
    movz	w17,	#5000
    cmp	w2,	w17
    bge	main_131

main_74:
    lsl	w19,	w2,	#2
    lsl	w23,	w2,	#2
    add	w10,	w2,	#1
    add	x18,	x21,	x19
    add	x22,	x12,	x23
    lsl	w25,	w10,	#2
    ldr	s15,	[x18]

    add	x24,	x12,	x25
    ldr	s31,	[x22]

    add	w25,	w10,	#1
    lsl	w22,	w10,	#2
    fmul	s1,	s15,	s31
    add	x20,	x21,	x22
    fadd	s29,	s4,	s1
    lsl	w5,	w25,	#2
    lsl	w2,	w25,	#2
    ldr	s6,	[x20]

    add	x4,	x12,	x5
    add	x1,	x21,	x2
    ldr	s14,	[x24]

    add	w5,	w25,	#1
    fmul	s15,	s6,	s14
    fadd	s7,	s29,	s15
    ldr	s17,	[x1]

    lsl	w16,	w5,	#2
    lsl	w13,	w5,	#2
    ldr	s23,	[x4]

    add	x15,	x12,	x16
    add	x11,	x21,	x13
    fmul	s24,	s17,	s23
    add	w16,	w5,	#1
    fadd	s20,	s7,	s24
    ldr	s28,	[x11]

    add	w1,	w16,	#1
    lsl	w26,	w16,	#2
    lsl	w23,	w16,	#2
    ldr	s2,	[x15]

    add	x25,	x12,	x26
    fmul	s3,	s28,	s2
    add	w11,	w1,	#1
    lsl	w7,	w1,	#2
    lsl	w3,	w1,	#2
    add	x22,	x21,	x23
    fadd	s31,	s20,	s3
    add	x5,	x12,	x7
    lsl	w17,	w11,	#2
    lsl	w14,	w11,	#2
    add	x2,	x21,	x3
    ldr	s6,	[x22]

    add	x16,	x12,	x17
    add	x13,	x21,	x14
    add	w22,	w11,	#1
    ldr	s13,	[x25]

    ldr	s17,	[x2]

    fmul	s14,	s6,	s13
    ldr	s22,	[x5]

    fadd	s9,	s31,	s14
    lsl	w27,	w22,	#2
    lsl	w24,	w22,	#2
    add	w2,	w22,	#1
    ldr	s28,	[x13]

    fmul	s23,	s17,	s22
    add	x26,	x12,	x27
    add	x23,	x21,	x24
    ldr	s1,	[x16]

    fadd	s22,	s9,	s23
    fmul	s2,	s28,	s1
    fadd	s2,	s22,	s2
    ldr	s6,	[x23]

    ldr	s12,	[x26]

    fmul	s13,	s6,	s12
    fadd	s4,	s2,	s13
    b	main_70

main_131:
    fadd	s10,	s10,	s4
    add	w6,	w6,	#1
    movz	w4,	#5000
    cmp	w6,	w4
    blt	main_6

main_135:
    movz	w0,	#40
    bl	_sysy_stoptime
    movz	w8,	#14269
    movz	w6,	#32140
    movk	w8,	#13702,	lsl #16
    movk	w6,	#22333,	lsl #16
    fmov	s29,	w8
    fmov	s18,	w6
    fsub	s22,	s10,	s18
    fcmp	s22,	s29
    bgt	main_143

main_138:
    movz	w10,	#14269
    movk	w10,	#46470,	lsl #16
    fmov	s1,	w10
    fcmp	s22,	s1
    blt	main_143

main_140:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0
    b	main_144

main_143:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1

main_144:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#40016
    add	sp, sp, fp
    ret


