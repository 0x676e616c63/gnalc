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
    movi	v9.4s,	#0
    movi	v10.4s,	#0
    movz	w26,	#0
    fmov	s1,	#1.000000
    add	x8,	sp,	#16
    movz	fp,	#19616
    add	x22,	sp,	fp

main_6:
    movz	w12,	#10
    movz	w17,	#52429
    movz	w19,	#52429
    movk	w17,	#15820,	lsl #16
    sdiv	w23,	w26,	w12
    movk	w19,	#15948,	lsl #16
    fmov	s21,	w17
    lsl	w10,	w23,	#1
    fmov	s22,	w19
    fadd	s24,	s9,	s21
    add	w12,	w10,	w23,	lsl #3
    fadd	s11,	s1,	s22
    sub	w0,	w26,	w12
    cmp	w0,	#0
    movz	w2,	#0
    fmov	s20,	#1.000000
    movi	v29.4s,	#0
    fcsel	s1,	s20,	s11,	ne
    fcsel	s9,	s29,	s24,	ne

main_17:
    movz	w21,	#4896
    cmp	w2,	w21
    bge	main_71

main_20:
    lsl	w5,	w2,	#2
    movz	fp,	#19616
    scvtf	s19,	w2
    lsl	w10,	w2,	#2
    add	w17,	w2,	#1
    mov	x4,	x5
    fadd	s29,	s1,	s19
    fadd	s26,	s9,	s19
    mov	x9,	x10
    add	x4,	sp,	x4
    add	w27,	w17,	#1
    lsl	w13,	w17,	#2
    scvtf	s28,	w17
    add	x9,	sp,	x9
    add	x4,	x4,	fp
    mov	x12,	x13
    lsl	w21,	w27,	#2
    scvtf	s6,	w27
    fadd	s7,	s1,	s28
    fadd	s4,	s9,	s28
    add	x9,	x9,	#16
    movz	fp,	#19616
    str	s26,	[x4]

    add	x12,	sp,	x12
    mov	x20,	x21
    fadd	s17,	s1,	s6
    fadd	s14,	s9,	s6
    str	s29,	[x9]

    add	x12,	x12,	#16
    add	x20,	sp,	x20
    lsl	w9,	w17,	#2
    lsl	w17,	w27,	#2
    mov	x7,	x9
    add	x20,	x20,	#16
    mov	x16,	x17
    add	w9,	w27,	#1
    add	x7,	sp,	x7
    add	x16,	sp,	x16
    add	w19,	w9,	#1
    lsl	w2,	w9,	#2
    scvtf	s16,	w9
    lsl	w27,	w9,	#2
    add	x7,	x7,	fp
    mov	x1,	x2
    add	w0,	w19,	#1
    lsl	w11,	w19,	#2
    scvtf	s24,	w19
    lsl	w6,	w19,	#2
    fadd	s25,	s1,	s16
    fadd	s22,	s9,	s16
    mov	x25,	x27
    movz	fp,	#19616
    str	s4,	[x7]

    add	x1,	sp,	x1
    lsl	w15,	w0,	#2
    mov	x10,	x11
    fadd	s3,	s1,	s24
    fadd	s30,	s9,	s24
    lsl	w19,	w0,	#2
    mov	x5,	x6
    add	x25,	sp,	x25
    add	x16,	x16,	fp
    str	s7,	[x12]

    add	x1,	x1,	#16
    mov	x14,	x15
    add	x10,	sp,	x10
    mov	x18,	x19
    add	x5,	sp,	x5
    movz	fp,	#19616
    str	s14,	[x16]

    add	x14,	sp,	x14
    add	x10,	x10,	#16
    add	x18,	sp,	x18
    add	x25,	x25,	fp
    str	s17,	[x20]

    movz	fp,	#19616
    add	x18,	x18,	#16
    str	s22,	[x25]

    add	x5,	x5,	fp
    str	s25,	[x1]

    movz	fp,	#19616
    str	s30,	[x5]

    add	x14,	x14,	fp
    str	s3,	[x10]

    movz	fp,	#19616
    add	w10,	w0,	#1
    scvtf	s3,	w0
    fadd	s13,	s1,	s3
    fadd	s8,	s9,	s3
    str	s8,	[x14]

    add	w21,	w10,	#1
    lsl	w24,	w10,	#2
    lsl	w0,	w10,	#2
    str	s13,	[x18]

    mov	x23,	x24
    mov	x28,	x0
    add	w2,	w21,	#1
    lsl	w9,	w21,	#2
    lsl	w4,	w21,	#2
    scvtf	s13,	w10
    add	x23,	sp,	x23
    add	x28,	sp,	x28
    mov	x7,	x9
    mov	x3,	x4
    fadd	s21,	s1,	s13
    fadd	s18,	s9,	s13
    add	x23,	x23,	fp
    add	x28,	x28,	#16
    add	x7,	sp,	x7
    add	x3,	sp,	x3
    movz	fp,	#19616
    str	s18,	[x23]

    add	x7,	x7,	#16
    add	x3,	x3,	fp
    str	s21,	[x28]

    scvtf	s21,	w21
    fadd	s29,	s1,	s21
    fadd	s26,	s9,	s21
    str	s26,	[x3]

    str	s29,	[x7]

    b	main_17

main_71:
    lsl	w20,	w2,	#2
    movz	fp,	#19616
    scvtf	s30,	w2
    lsl	w25,	w2,	#2
    movz	w11,	#4900
    mov	x19,	x20
    fadd	s7,	s1,	s30
    fadd	s4,	s9,	s30
    add	w2,	w2,	#1
    mov	x24,	x25
    add	x19,	sp,	x19
    add	x24,	sp,	x24
    add	x19,	x19,	fp
    add	x24,	x24,	#16
    str	s4,	[x19]

    str	s7,	[x24]

    cmp	w2,	w11
    blt	main_71

main_80:
    movz	w15,	#0
    movi	v19.4s,	#0

main_81:
    movz	w13,	#4896
    cmp	w15,	w13
    bge	main_144

main_85:
    lsl	w3,	w15,	#2
    lsl	w6,	w15,	#2
    add	w28,	w15,	#1
    add	x2,	x22,	x3
    add	x5,	x8,	x6
    lsl	w9,	w28,	#2
    ldr	s29,	[x2]

    add	x7,	x8,	x9
    ldr	s15,	[x5]

    add	w9,	w28,	#1
    lsl	w5,	w28,	#2
    fmul	s16,	s29,	s15
    add	x4,	x22,	x5
    fadd	s13,	s19,	s16
    add	w19,	w9,	#1
    lsl	w18,	w9,	#2
    lsl	w15,	w9,	#2
    ldr	s21,	[x4]

    add	x17,	x8,	x18
    lsl	w0,	w19,	#2
    lsl	w25,	w19,	#2
    add	x14,	x22,	x15
    add	w4,	w19,	#1
    ldr	s27,	[x7]

    add	x28,	x8,	x0
    add	x24,	x22,	x25
    fmul	s28,	s21,	s27
    lsl	w10,	w4,	#2
    lsl	w6,	w4,	#2
    ldr	s31,	[x14]

    fadd	s24,	s13,	s28
    add	x9,	x8,	x10
    add	x5,	x22,	x6
    add	w14,	w4,	#1
    ldr	s6,	[x17]

    ldr	s12,	[x24]

    fmul	s7,	s31,	s6
    ldr	s17,	[x28]

    fadd	s4,	s24,	s7
    add	w2,	w14,	#1
    lsl	w19,	w14,	#2
    lsl	w16,	w14,	#2
    ldr	s21,	[x5]

    fmul	s18,	s12,	s17
    add	x18,	x8,	x19
    lsl	w1,	w2,	#2
    lsl	w27,	w2,	#2
    add	w14,	w2,	#1
    add	x15,	x22,	x16
    ldr	s26,	[x9]

    fadd	s15,	s4,	s18
    add	x0,	x8,	x1
    add	x25,	x22,	x27
    lsl	w11,	w14,	#2
    lsl	w7,	w14,	#2
    ldr	s31,	[x15]

    fmul	s27,	s21,	s26
    add	x10,	x8,	x11
    add	x6,	x22,	x7
    add	w15,	w14,	#1
    ldr	s5,	[x18]

    fadd	s26,	s15,	s27
    ldr	s12,	[x25]

    fmul	s6,	s31,	s5
    ldr	s16,	[x0]

    fadd	s6,	s26,	s6
    ldr	s21,	[x6]

    fmul	s17,	s12,	s16
    ldr	s25,	[x10]

    fadd	s17,	s6,	s17
    fmul	s26,	s21,	s25
    fadd	s19,	s17,	s26
    b	main_81

main_144:
    lsl	w0,	w15,	#2
    lsl	w3,	w15,	#2
    add	w15,	w15,	#1
    add	x2,	x8,	x3
    add	x28,	x22,	x0
    movz	w3,	#4900
    ldr	s23,	[x28]

    ldr	s4,	[x2]

    fmul	s5,	s23,	s4
    fadd	s19,	s19,	s5
    cmp	w15,	w3
    blt	main_144

main_155:
    fadd	s10,	s10,	s19
    add	w26,	w26,	#1
    movz	w4,	#5000
    cmp	w26,	w4
    blt	main_6

main_159:
    movz	w0,	#40
    bl	_sysy_stoptime
    movz	w9,	#14269
    movz	w7,	#21563
    movk	w9,	#13702,	lsl #16
    movk	w7,	#22322,	lsl #16
    fmov	s26,	w9
    fmov	s16,	w7
    fsub	s14,	s10,	s16
    fcmp	s14,	s26
    bgt	main_167

main_162:
    movz	w11,	#14269
    movk	w11,	#46470,	lsl #16
    fmov	s29,	w11
    fcmp	s14,	s29
    blt	main_167

main_164:
    movz	w0,	#10
    bl	putint
    movz	w0,	#0
    b	main_168

main_167:
    movz	w0,	#1
    bl	putint
    movz	w0,	#1

main_168:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#39216
    add	sp, sp, fp
    ret


