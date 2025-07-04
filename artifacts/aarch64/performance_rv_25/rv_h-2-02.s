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
    movi	v9.4s,	#0
    movi	v10.4s,	#0
    fmov	s1,	#1.000000
    add	x19,	sp,	#16
    movz	w20,	#0
    movz	fp,	#19616
    add	x5,	sp,	fp

main_6:
    movz	w12,	#10
    movz	w17,	#52429
    movz	w21,	#52429
    movk	w17,	#15820,	lsl #16
    sdiv	w24,	w20,	w12
    movk	w21,	#15948,	lsl #16
    fmov	s21,	w17
    lsl	w10,	w24,	#1
    fmov	s22,	w21
    fadd	s24,	s9,	s21
    add	w12,	w10,	w24,	lsl #3
    fadd	s11,	s1,	s22
    sub	w0,	w20,	w12
    cmp	w0,	#0
    movz	w11,	#0
    fmov	s20,	#1.000000
    movi	v29.4s,	#0
    fcsel	s1,	s20,	s11,	ne
    fcsel	s9,	s29,	s24,	ne

main_17:
    movz	w22,	#4896
    cmp	w11,	w22
    blt	main_20

main_71:
    lsl	w4,	w11,	#2
    movz	fp,	#19616
    scvtf	s19,	w11
    lsl	w9,	w11,	#2
    movz	w23,	#4900
    mov	x3,	x4
    fadd	s29,	s1,	s19
    fadd	s26,	s9,	s19
    add	w11,	w11,	#1
    mov	x8,	x9
    add	x3,	sp,	x3
    add	x8,	sp,	x8
    add	x3,	x3,	fp
    add	x8,	x8,	#16
    str	s26,	[x3]

    str	s29,	[x8]

    cmp	w11,	w23
    blt	main_71

main_80:
    movz	w15,	#0
    movi	v19.4s,	#0

main_81:
    movz	w26,	#4896
    cmp	w15,	w26
    blt	main_85

main_144:
    lsl	w16,	w15,	#2
    lsl	w21,	w15,	#2
    movz	w27,	#4900
    add	w15,	w15,	#1
    add	x18,	x19,	x21
    add	x14,	x5,	x16
    ldr	s16,	[x14]

    ldr	s3,	[x18]

    fmul	s4,	s16,	s3
    fadd	s19,	s19,	s4
    cmp	w15,	w27
    blt	main_144

main_155:
    fadd	s10,	s10,	s19
    add	w20,	w20,	#1
    movz	w0,	#5000
    cmp	w20,	w0
    blt	main_6

main_159:
    movz	w0,	#40
    bl	_sysy_stoptime
    movz	w9,	#14269
    movz	w7,	#21563
    movk	w9,	#13702,	lsl #16
    movk	w7,	#22322,	lsl #16
    fmov	s25,	w9
    fmov	s26,	w7
    fsub	s23,	s10,	s26
    fcmp	s23,	s25
    bgt	main_167

main_162:
    movz	w11,	#14269
    movk	w11,	#46470,	lsl #16
    fmov	s28,	w11
    fcmp	s23,	s28
    bge	main_164

main_167:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1
    b	main_168

main_164:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0

main_168:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#39216
    add	sp, sp, fp
    ret


main_85:
    lsl	w6,	w15,	#2
    lsl	w9,	w15,	#2
    add	w24,	w15,	#1
    add	x4,	x5,	x6
    add	x8,	x19,	x9
    lsl	w13,	w24,	#2
    lsl	w10,	w24,	#2
    ldr	s3,	[x4]

    add	x12,	x19,	x13
    add	x9,	x5,	x10
    add	w4,	w24,	#1
    ldr	s22,	[x8]

    fmul	s23,	s3,	s22
    ldr	s28,	[x9]

    fadd	s17,	s19,	s23
    lsl	w24,	w4,	#2
    lsl	w21,	w4,	#2
    ldr	s5,	[x12]

    add	x23,	x19,	x24
    add	x18,	x5,	x21
    fmul	s6,	s28,	s5
    fadd	s27,	s17,	s6
    ldr	s7,	[x18]

    add	w18,	w4,	#1
    ldr	s16,	[x23]

    fmul	s17,	s7,	s16
    fadd	s6,	s27,	s17
    lsl	w4,	w18,	#2
    lsl	w1,	w18,	#2
    add	x3,	x19,	x4
    add	x0,	x5,	x1
    ldr	s18,	[x0]

    add	w0,	w18,	#1
    ldr	s25,	[x3]

    fmul	s26,	s18,	s25
    fadd	s19,	s6,	s26
    lsl	w14,	w0,	#2
    lsl	w11,	w0,	#2
    add	x13,	x19,	x14
    add	x10,	x5,	x11
    ldr	s28,	[x10]

    add	w10,	w0,	#1
    ldr	s4,	[x13]

    fmul	s5,	s28,	s4
    fadd	s29,	s19,	s5
    lsl	w25,	w10,	#2
    lsl	w22,	w10,	#2
    add	x24,	x19,	x25
    add	x21,	x5,	x22
    add	w25,	w10,	#1
    ldr	s7,	[x21]

    lsl	w6,	w25,	#2
    lsl	w2,	w25,	#2
    ldr	s15,	[x24]

    add	x4,	x19,	x6
    add	x1,	x5,	x2
    fmul	s16,	s7,	s15
    add	w6,	w25,	#1
    fadd	s8,	s29,	s16
    ldr	s18,	[x1]

    lsl	w15,	w6,	#2
    lsl	w12,	w6,	#2
    ldr	s24,	[x4]

    add	x14,	x19,	x15
    add	x11,	x5,	x12
    fmul	s25,	s18,	s24
    add	w15,	w6,	#1
    fadd	s21,	s8,	s25
    ldr	s28,	[x11]

    ldr	s3,	[x14]

    fmul	s4,	s28,	s3
    fadd	s19,	s21,	s4
    b	main_81

main_20:
    lsl	w2,	w11,	#2
    movz	fp,	#19616
    scvtf	s7,	w11
    lsl	w7,	w11,	#2
    add	w0,	w11,	#1
    mov	x1,	x2
    fadd	s15,	s1,	s7
    fadd	s12,	s9,	s7
    mov	x6,	x7
    add	x1,	sp,	x1
    add	w9,	w0,	#1
    scvtf	s17,	w0
    lsl	w2,	w0,	#2
    lsl	w7,	w0,	#2
    add	x6,	sp,	x6
    add	x1,	x1,	fp
    add	w17,	w9,	#1
    lsl	w15,	w9,	#2
    scvtf	s25,	w9
    lsl	w11,	w9,	#2
    fadd	s23,	s1,	s17
    fadd	s20,	s9,	s17
    add	x6,	x6,	#16
    movz	fp,	#19616
    str	s12,	[x1]

    lsl	w25,	w17,	#2
    scvtf	s4,	w17
    lsl	w21,	w17,	#2
    mov	x14,	x15
    fadd	s31,	s1,	s25
    fadd	s28,	s9,	s25
    mov	x10,	x11
    mov	x1,	x2
    str	s15,	[x6]

    mov	x24,	x25
    fadd	s11,	s1,	s4
    fadd	s6,	s9,	s4
    mov	x18,	x21
    add	x14,	sp,	x14
    add	x10,	sp,	x10
    add	x1,	sp,	x1
    mov	x6,	x7
    add	x24,	sp,	x24
    add	x18,	sp,	x18
    add	x14,	x14,	#16
    add	x6,	sp,	x6
    add	x1,	x1,	fp
    add	x24,	x24,	#16
    movz	fp,	#19616
    add	x6,	x6,	#16
    str	s20,	[x1]

    add	x10,	x10,	fp
    movz	fp,	#19616
    str	s23,	[x6]

    add	x18,	x18,	fp
    add	w6,	w17,	#1
    str	s28,	[x10]

    movz	fp,	#19616
    str	s31,	[x14]

    add	w15,	w6,	#1
    lsl	w4,	w6,	#2
    scvtf	s14,	w6
    lsl	w0,	w6,	#2
    str	s6,	[x18]

    mov	x3,	x4
    add	w25,	w15,	#1
    lsl	w13,	w15,	#2
    scvtf	s22,	w15
    lsl	w9,	w15,	#2
    fadd	s19,	s1,	s14
    fadd	s16,	s9,	s14
    mov	x28,	x0
    str	s11,	[x24]

    add	x3,	sp,	x3
    add	w7,	w25,	#1
    lsl	w23,	w25,	#2
    scvtf	s31,	w25
    lsl	w17,	w25,	#2
    mov	x12,	x13
    fadd	s27,	s1,	s22
    fadd	s24,	s9,	s22
    mov	x8,	x9
    add	x28,	sp,	x28
    add	x3,	x3,	#16
    add	w11,	w7,	#1
    lsl	w2,	w7,	#2
    scvtf	s11,	w7
    lsl	w27,	w7,	#2
    mov	x22,	x23
    fadd	s5,	s1,	s31
    fadd	s2,	s9,	s31
    mov	x16,	x17
    add	x12,	sp,	x12
    add	x8,	sp,	x8
    add	x28,	x28,	fp
    mov	x1,	x2
    fadd	s15,	s1,	s11
    fadd	s12,	s9,	s11
    mov	x26,	x27
    add	x22,	sp,	x22
    add	x16,	sp,	x16
    add	x12,	x12,	#16
    movz	fp,	#19616
    str	s16,	[x28]

    add	x1,	sp,	x1
    add	x26,	sp,	x26
    add	x22,	x22,	#16
    add	x8,	x8,	fp
    str	s19,	[x3]

    add	x1,	x1,	#16
    movz	fp,	#19616
    str	s24,	[x8]

    add	x16,	x16,	fp
    str	s27,	[x12]

    movz	fp,	#19616
    str	s2,	[x16]

    add	x26,	x26,	fp
    str	s5,	[x22]

    str	s12,	[x26]

    str	s15,	[x1]

    b	main_17

