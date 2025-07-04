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
    fmov	s1,	#1.000000
    movi	v9.4s,	#0
    movi	v10.4s,	#0
    movz	w20,	#0
    movz	fp,	#20016
    add	x8,	sp,	#16
    add	x21,	sp,	fp

main_6:
    movz	w12,	#10
    movz	w15,	#52429
    movz	w17,	#52429
    movk	w15,	#15820,	lsl #16
    sdiv	w27,	w20,	w12
    movk	w17,	#15948,	lsl #16
    fmov	s27,	w15
    lsl	w7,	w27,	#1
    fmov	s29,	w17
    fadd	s21,	s9,	s27
    add	w16,	w7,	w27,	lsl #3
    fadd	s7,	s1,	s29
    sub	w26,	w20,	w16
    cmp	w26,	#0
    movz	w10,	#0
    fmov	s27,	#1.000000
    movi	v6.4s,	#0
    fcsel	s1,	s27,	s7,	ne
    fcsel	s9,	s6,	s21,	ne

main_17:
    movz	w27,	#5000
    cmp	w10,	w27
    blt	main_20

main_69:
    movz	w11,	#0
    movi	v17.4s,	#0

main_70:
    movz	w28,	#5000
    cmp	w11,	w28
    blt	main_74

main_131:
    fadd	s10,	s10,	s17
    add	w20,	w20,	#1
    movz	w0,	#5000
    cmp	w20,	w0
    blt	main_6

main_135:
    movz	w0,	#40
    bl	_sysy_stoptime
    movz	w8,	#14269
    movz	w6,	#32140
    movk	w8,	#13702,	lsl #16
    movk	w6,	#22333,	lsl #16
    fmov	s28,	w8
    fmov	s29,	w6
    fsub	s1,	s10,	s29
    fcmp	s1,	s28
    bgt	main_143

main_138:
    movz	w10,	#14269
    movk	w10,	#46470,	lsl #16
    fmov	s31,	w10
    fcmp	s1,	s31
    bge	main_140

main_143:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1
    b	main_144

main_140:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0

main_144:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#40016
    add	sp, sp, fp
    ret


main_74:
    lsl	w9,	w11,	#2
    lsl	w13,	w11,	#2
    add	w24,	w11,	#1
    add	x7,	x8,	x9
    add	x12,	x21,	x13
    add	w4,	w24,	#1
    lsl	w17,	w24,	#2
    lsl	w14,	w24,	#2
    ldr	s7,	[x7]

    add	x16,	x21,	x17
    ldr	s27,	[x12]

    add	w18,	w4,	#1
    lsl	w28,	w4,	#2
    lsl	w25,	w4,	#2
    add	x13,	x8,	x14
    fmul	s28,	s7,	s27
    add	x27,	x21,	x28
    add	w0,	w18,	#1
    lsl	w9,	w18,	#2
    lsl	w5,	w18,	#2
    add	x24,	x8,	x25
    ldr	s3,	[x13]

    fadd	s21,	s17,	s28
    add	w11,	w0,	#1
    lsl	w15,	w0,	#2
    add	x7,	x21,	x9
    lsl	w18,	w0,	#2
    add	x4,	x8,	x5
    ldr	s13,	[x16]

    lsl	w26,	w11,	#2
    add	x14,	x8,	x15
    lsl	w0,	w11,	#2
    add	x17,	x21,	x18
    fmul	s14,	s3,	s13
    add	x25,	x8,	x26
    add	x28,	x21,	x0
    fadd	s30,	s21,	s14
    ldr	s14,	[x24]

    ldr	s22,	[x27]

    fmul	s23,	s14,	s22
    fadd	s12,	s30,	s23
    ldr	s23,	[x4]

    ldr	s31,	[x7]

    ldr	s3,	[x14]

    fmul	s2,	s23,	s31
    fadd	s23,	s12,	s2
    ldr	s12,	[x17]

    ldr	s14,	[x25]

    fmul	s13,	s3,	s12
    add	w25,	w11,	#1
    ldr	s21,	[x28]

    fadd	s2,	s23,	s13
    fmul	s22,	s14,	s21
    fadd	s13,	s2,	s22
    lsl	w10,	w25,	#2
    lsl	w6,	w25,	#2
    add	x9,	x21,	x10
    add	x5,	x8,	x6
    ldr	s23,	[x5]

    add	w5,	w25,	#1
    ldr	s30,	[x9]

    fmul	s31,	s23,	s30
    fadd	s25,	s13,	s31
    add	w11,	w5,	#1
    lsl	w19,	w5,	#2
    lsl	w16,	w5,	#2
    add	x18,	x21,	x19
    add	x15,	x8,	x16
    ldr	s3,	[x15]

    ldr	s11,	[x18]

    fmul	s12,	s3,	s11
    fadd	s17,	s25,	s12
    b	main_70

main_20:
    lsl	w5,	w10,	#2
    scvtf	s14,	w10
    lsl	w11,	w10,	#2
    movz	fp,	#20016
    add	w0,	w10,	#1
    mov	x4,	x5
    fadd	s21,	s1,	s14
    fadd	s18,	s9,	s14
    mov	x9,	x11
    add	x4,	sp,	x4
    scvtf	s22,	w0
    lsl	w6,	w0,	#2
    lsl	w11,	w0,	#2
    add	x9,	sp,	x9
    add	x4,	x4,	#16
    fadd	s29,	s1,	s22
    fadd	s26,	s9,	s22
    mov	x5,	x6
    mov	x10,	x11
    add	x9,	x9,	fp
    str	s18,	[x4]

    add	x5,	sp,	x5
    add	x10,	sp,	x10
    movz	fp,	#20016
    str	s21,	[x9]

    add	x5,	x5,	#16
    add	w9,	w0,	#1
    add	x10,	x10,	fp
    movz	fp,	#20016
    str	s26,	[x5]

    lsl	w19,	w9,	#2
    scvtf	s31,	w9
    lsl	w15,	w9,	#2
    str	s29,	[x10]

    mov	x18,	x19
    fadd	s7,	s1,	s31
    fadd	s4,	s9,	s31
    mov	x14,	x15
    add	x18,	sp,	x18
    add	x14,	sp,	x14
    add	x18,	x18,	fp
    add	x14,	x14,	#16
    movz	fp,	#20016
    str	s4,	[x14]

    str	s7,	[x18]

    add	w18,	w9,	#1
    add	w2,	w18,	#1
    lsl	w0,	w18,	#2
    scvtf	s11,	w18
    lsl	w25,	w18,	#2
    mov	x28,	x0
    fadd	s17,	s1,	s11
    add	w11,	w2,	#1
    lsl	w9,	w2,	#2
    scvtf	s19,	w2
    lsl	w4,	w2,	#2
    fadd	s14,	s9,	s11
    mov	x24,	x25
    add	x28,	sp,	x28
    add	w19,	w11,	#1
    lsl	w17,	w11,	#2
    scvtf	s27,	w11
    lsl	w13,	w11,	#2
    mov	x7,	x9
    fadd	s25,	s1,	s19
    fadd	s22,	s9,	s19
    mov	x3,	x4
    add	x24,	sp,	x24
    add	x28,	x28,	fp
    lsl	w27,	w19,	#2
    scvtf	s6,	w19
    lsl	w23,	w19,	#2
    mov	x16,	x17
    fadd	s3,	s1,	s27
    fadd	s30,	s9,	s27
    mov	x12,	x13
    add	w9,	w19,	#1
    add	x7,	sp,	x7
    add	x3,	sp,	x3
    add	x24,	x24,	#16
    movz	fp,	#20016
    mov	x26,	x27
    fadd	s13,	s1,	s6
    fadd	s8,	s9,	s6
    mov	x22,	x23
    add	x16,	sp,	x16
    add	x12,	sp,	x12
    add	w10,	w9,	#1
    lsl	w6,	w9,	#2
    scvtf	s16,	w9
    lsl	w2,	w9,	#2
    add	x3,	x3,	#16
    str	s14,	[x24]

    add	x7,	x7,	fp
    add	x26,	sp,	x26
    add	x22,	sp,	x22
    add	x12,	x12,	#16
    mov	x5,	x6
    fadd	s21,	s1,	s16
    fadd	s18,	s9,	s16
    mov	x1,	x2
    str	s17,	[x28]

    movz	fp,	#20016
    add	x22,	x22,	#16
    add	x5,	sp,	x5
    add	x1,	sp,	x1
    str	s22,	[x3]

    add	x16,	x16,	fp
    str	s25,	[x7]

    movz	fp,	#20016
    add	x1,	x1,	#16
    str	s30,	[x12]

    add	x26,	x26,	fp
    str	s3,	[x16]

    movz	fp,	#20016
    str	s8,	[x22]

    add	x5,	x5,	fp
    str	s13,	[x26]

    str	s18,	[x1]

    str	s21,	[x5]

    b	main_17

