.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global memo.lut.asr5
.align	2
memo.lut.asr5:
    .zero	1835008


.text

.globl my_pow
my_pow:
my_pow_2:
    sub	sp, sp, #112
    stp	x22, x23, [sp, #0]
    stp	x24, x25, [sp, #16]
    stp	x26, x27, [sp, #32]
    stp	x28, fp, [sp, #48]
    str	lr, [sp, 64]
    stp	q9, q13, [sp, #80]

    cmp	w0,	#0
    bge	my_pow_27

my_pow_4:
    movz	w10,	#0
    sub	w27,	w10,	w0
    cmp	w27,	#0
    bge	my_pow_10

my_pow_7:
    bl	my_pow
    fmov	s13,	#1.000000
    fdiv	s26,	s13,	s0
    b	my_pow_24

my_pow_10:
    fmov	s26,	#1.000000

my_pow_11:
    cmp	w27,	#0
    beq	my_pow_24

my_pow_16:
    asr	w22,	w27,	#31
    fmul	s9,	s26,	s0
    lsr	w23,	w22,	#31
    add	w24,	w27,	w23
    asr	w12,	w24,	#1
    lsl	w13,	w12,	#1
    sub	w13,	w27,	w13
    cmp	w13,	#0
    asr	w25,	w27,	#31
    fmul	s0,	s0,	s0
    fcsel	s26,	s9,	s26,	ne
    lsr	w26,	w25,	#31
    add	w22,	w27,	w26
    asr	w27,	w22,	#1
    b	my_pow_11

my_pow_24:
    fmov	s17,	#1.000000
    fdiv	s18,	s17,	s26
    b	my_pow_41

my_pow_27:
    fmov	s18,	#1.000000

my_pow_28:
    cmp	w0,	#0
    beq	my_pow_41

my_pow_33:
    asr	w1,	w0,	#31
    fmul	s17,	s18,	s0
    lsr	w2,	w1,	#31
    add	w3,	w0,	w2
    asr	w17,	w3,	#1
    lsl	w18,	w17,	#1
    sub	w22,	w0,	w18
    cmp	w22,	#0
    asr	w4,	w0,	#31
    fmul	s0,	s0,	s0
    fcsel	s18,	s17,	s18,	ne
    lsr	w5,	w4,	#31
    add	w28,	w0,	w5
    asr	w0,	w28,	#1
    b	my_pow_28

my_pow_41:
    fmov	s0,	s18
    ldp	x22, x23, [sp, #0]
    ldp	x24, x25, [sp, #16]
    ldp	x26, x27, [sp, #32]
    ldp	x28, fp, [sp, #48]
    ldr	lr, [sp, 64]
    ldp	q9, q13, [sp, #80]

    add	sp, sp, #112
    ret


.globl my_sqrt
my_sqrt:
my_sqrt_1:
    sub	sp, sp, #144
    stp	fp, lr, [sp, #0]
        stp	q8, q9, [sp, #16]
    stp	q10, q11, [sp, #48]
    stp	q12, q13, [sp, #80]
    stp	q14, q15, [sp, #112]

    movz	w10,	#0
    movk	w10,	#17096,	lsl #16
    fmov	s15,	w10
    fcmp	s0,	s15
    ble	my_sqrt_50

my_sqrt_3:
    fdiv	s14,	s0,	s15
    fcmp	s14,	s15
    ble	my_sqrt_10

my_sqrt_6:
    fdiv	s0,	s14,	s15
    bl	my_sqrt
    fmov	s14,	#10.000000
    fmul	s22,	s14,	s0
    b	my_sqrt_47

my_sqrt_10:
    fmov	s29,	#8.000000
    fmov	s28,	#0.500000
    fmov	s27,	#2.000000
    fmov	s26,	#4.000000
    fmov	s25,	#2.000000
    fmov	s23,	#2.000000
    fmov	s22,	#2.000000
    fmov	s21,	#2.000000
    fmov	s19,	#2.000000
    fmov	s16,	#2.000000
    fdiv	s18,	s14,	s29
    fmul	s12,	s27,	s14
    fadd	s4,	s26,	s14
    fadd	s28,	s18,	s28
    fdiv	s5,	s12,	s4
    fmov	s18,	#2.000000
    fadd	s24,	s28,	s5
    fdiv	s7,	s14,	s24
    fadd	s26,	s24,	s7
    fmov	s24,	#2.000000
    fdiv	s27,	s26,	s25
    fdiv	s10,	s14,	s27
    fadd	s29,	s27,	s10
    fdiv	s30,	s29,	s24
    fdiv	s13,	s14,	s30
    fadd	s1,	s30,	s13
    fdiv	s2,	s1,	s23
    fdiv	s17,	s14,	s2
    fadd	s4,	s2,	s17
    fdiv	s5,	s4,	s22
    fdiv	s20,	s14,	s5
    fadd	s7,	s5,	s20
    fmov	s20,	#2.000000
    fdiv	s8,	s7,	s21
    fdiv	s23,	s14,	s8
    fadd	s10,	s8,	s23
    fdiv	s11,	s10,	s20
    fdiv	s26,	s14,	s11
    fadd	s13,	s11,	s26
    fdiv	s15,	s13,	s19
    fdiv	s29,	s14,	s15
    fadd	s17,	s15,	s29
    fdiv	s19,	s17,	s18
    fmov	s17,	#2.000000
    fdiv	s1,	s14,	s19
    fadd	s21,	s19,	s1
    fdiv	s22,	s21,	s17
    fdiv	s21,	s14,	s22
    fadd	s5,	s22,	s21
    fdiv	s22,	s5,	s16

my_sqrt_47:
    fmov	s30,	#10.000000
    fmul	s0,	s30,	s22
    b	my_sqrt_87

my_sqrt_50:
    fmov	s13,	#8.000000
    fmov	s12,	#0.500000
    fmov	s11,	#2.000000
    fmov	s10,	#4.000000
    fmov	s9,	#2.000000
    fmov	s7,	#2.000000
    fmov	s5,	#2.000000
    fmov	s4,	#2.000000
    fmov	s2,	#2.000000
    fdiv	s8,	s0,	s13
    fmul	s29,	s11,	s0
    fadd	s28,	s10,	s0
    fadd	s17,	s8,	s12
    fdiv	s29,	s29,	s28
    fmov	s8,	#2.000000
    fadd	s13,	s17,	s29
    fdiv	s31,	s0,	s13
    fadd	s16,	s13,	s31
    fdiv	s17,	s16,	s9
    fdiv	s3,	s0,	s17
    fadd	s19,	s17,	s3
    fmov	s3,	#2.000000
    fdiv	s20,	s19,	s8
    fdiv	s6,	s0,	s20
    fadd	s22,	s20,	s6
    fmov	s6,	#2.000000
    fdiv	s23,	s22,	s7
    fdiv	s9,	s0,	s23
    fadd	s25,	s23,	s9
    fdiv	s26,	s25,	s6
    fdiv	s12,	s0,	s26
    fadd	s28,	s26,	s12
    fdiv	s29,	s28,	s5
    fdiv	s15,	s0,	s29
    fadd	s31,	s29,	s15
    fdiv	s1,	s31,	s4
    fmov	s31,	#2.000000
    fdiv	s18,	s0,	s1
    fadd	s4,	s1,	s18
    fmov	s1,	#2.000000
    fdiv	s4,	s4,	s3
    fdiv	s21,	s0,	s4
    fadd	s7,	s4,	s21
    fdiv	s7,	s7,	s2
    fdiv	s24,	s0,	s7
    fadd	s10,	s7,	s24
    fdiv	s10,	s10,	s1
    fdiv	s27,	s0,	s10
    fadd	s12,	s10,	s27
    fdiv	s0,	s12,	s31

my_sqrt_87:
    ldp	fp, lr, [sp, #0]
        ldp	q8, q9, [sp, #16]
    ldp	q10, q11, [sp, #48]
    ldp	q12, q13, [sp, #80]
    ldp	q14, q15, [sp, #112]

    add	sp, sp, #144
    ret


.globl asr5
asr5:
asr5_5:
    sub	sp, sp, #288
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
        stp	q8, q9, [sp, #96]
    stp	q10, q11, [sp, #128]
    stp	q12, q13, [sp, #160]
    stp	q14, q15, [sp, #192]

    adrp	x21, :got:memo.lut.asr5
    movz	x15,	#31482
    fmov	s8,	s3
    fmov	s10,	s0
    movz	x13,	#31161
    movz	x8,	#31161
    mov	w27,	w0
    fmov	s13,	s2
    movz	x14,	#5
    fmov	s9,	s1
    ldr	x21, [x21, #:got_lo12:memo.lut.asr5]
    movk	x15,	#40503,	lsl #16
    fmov	w16,	s8
    fmov	w11,	s10
    movk	x13,	#40503,	lsl #16
    movk	x8,	#40503,	lsl #16
    fmov	w3,	s13
    fmov	w12,	s9
    add	x28,	x11,	x15
    eor	x19,	x28,	x14
    lsr	x2,	x19,	#2
    lsl	x11,	x19,	#6
    add	x22,	x2,	x13
    add	x23,	x22,	x11
    add	x14,	x23,	x12
    movz	x23,	#31161
    movk	x23,	#40503,	lsl #16
    eor	x5,	x19,	x14
    movz	x14,	#31161
    lsr	x28,	x5,	#2
    lsl	x4,	x5,	#6
    movk	x14,	#40503,	lsl #16
    add	x19,	x28,	x14
    add	x20,	x19,	x4
    add	x2,	x20,	x3
    eor	x25,	x5,	x2
    lsr	x24,	x25,	#2
    lsl	x15,	x25,	#6
    add	x6,	x24,	x8
    add	x7,	x6,	x15
    add	x9,	x7,	x16
    movz	x7,	#65535
    eor	x4,	x25,	x9
    lsr	x11,	x4,	#2
    lsl	x10,	x4,	#6
    add	x13,	x11,	x23
    add	x14,	x13,	x10
    add	x15,	x14,	x27
    eor	x16,	x4,	x15
    and	x17,	x16,	x7
    lsl	w8,	w17,	#5
    sub	w18,	w8,	w17,	lsl #2
    lsl	x19,	x18,	#0
    add	x26,	x21,	x19
    add	x22,	x26,	#8
    ldr	w13,	[x26]

    cmp	w13,	#0
    beq	asr5_76

asr5_48:
    ldr	s6,	[x22]

    fcmp	s6,	s10
    add	x4,	x22,	#4
    cset	w14,	eq
    ldr	s16,	[x4]

    fcmp	s16,	s9
    add	x17,	x4,	#4
    cset	w7,	eq
    and	w15,	w7,	w14
    ldr	s14,	[x17]

    fcmp	s14,	s13
    add	x25,	x17,	#4
    cset	w24,	eq
    and	w12,	w15,	w24
    ldr	s20,	[x25]

    fcmp	s20,	s8
    add	x10,	x25,	#4
    cset	w0,	eq
    and	w8,	w12,	w0
    ldr	w21,	[x10]

    cmp	w21,	w27
    cset	w23,	eq
    and	w24,	w8,	w23
    cbnz	w24,	asr5_72
    b	asr5_86

asr5_72:
    add	x25,	x26,	#4
    ldr	s0,	[x25]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
        ldp	q8, q9, [sp, #96]
    ldp	q10, q11, [sp, #128]
    ldp	q12, q13, [sp, #160]
    ldp	q14, q15, [sp, #192]

    add	sp, sp, #288
    ret


asr5_86:
    mov	x23,	x22
    mov	x21,	x4
    mov	x19,	x17
    mov	x22,	x10
    b	asr5_87

asr5_76:
    add	x12,	x22,	#4
    mov	x23,	x22
    mov	x21,	x12
    add	x14,	x12,	#4
    mov	x19,	x14
    add	x16,	x14,	#4
    mov	x25,	x16
    add	x18,	x16,	#4
    mov	x22,	x18

asr5_87:
    fsub	s1,	s9,	s10
    fmov	s5,	#2.000000
    fmov	s4,	#2.000000
    fdiv	s14,	s1,	s5
    fadd	s20,	s10,	s14
    str	s20,	[sp, #240]

    ldr	s21,	[sp, #240]

    fsub	s12,	s21,	s10
    str	s12,	[sp, #264]

    ldr	s20,	[sp, #264]

    fdiv	s18,	s20,	s4
    fadd	s27,	s10,	s18
    str	s27,	[sp, #248]

    cmp	w27,	#1
    bne	asr5_109

asr5_100:
    fmov	s14,	#1.000000
    fmov	s12,	#1.000000
    ldr	s2,	[sp, #248]

    fmov	s11,	#4.000000
    fmov	s7,	#1.000000
    fmov	s6,	#6.000000
    fdiv	s21,	s14,	s10
    fdiv	s23,	s12,	s2
    ldr	s2,	[sp, #240]

    fmul	s12,	s11,	s23
    fdiv	s17,	s7,	s2
    ldr	s11,	[sp, #264]

    fadd	s16,	s21,	s12
    fadd	s31,	s16,	s17
    fmul	s19,	s31,	s11
    fdiv	s24,	s19,	s6
    fmov	s14,	s24
    b	asr5_130

asr5_109:
    cmp	w27,	#2
    bne	asr5_129

asr5_111:
    fmul	s12,	s10,	s10
    fmov	s14,	#1.000000
    fsub	s0,	s14,	s12
    bl	my_sqrt
    fmov	s14,	#1.000000
    fdiv	s12,	s14,	s0
    str	s12,	[sp, #268]

    ldr	s12,	[sp, #248]

    fmul	s11,	s12,	s11
    fmov	s12,	#1.000000
    fsub	s0,	s12,	s11
    bl	my_sqrt
    ldr	s11,	[sp, #268]

    fmov	s14,	#1.000000
    fdiv	s12,	s14,	s0
    fmov	s14,	#4.000000
    fmul	s14,	s14,	s12
    fadd	s12,	s11,	s14
    str	s12,	[sp, #244]

    ldr	s12,	[sp, #240]

    fmul	s11,	s12,	s15
    fmov	s12,	#1.000000
    fsub	s0,	s12,	s11
    bl	my_sqrt
    fmov	s16,	#6.000000
    ldr	s1,	[sp, #244]

    fmov	s17,	#1.000000
    ldr	s12,	[sp, #264]

    fdiv	s14,	s17,	s0
    fadd	s18,	s1,	s14
    fmul	s5,	s18,	s12
    fdiv	s24,	s5,	s16
    fmov	s14,	s24
    b	asr5_130

asr5_129:
    movi	v24.4s,	#0
    fmov	s14,	s24

asr5_130:
    ldr	s31,	[sp, #240]

    fmov	s19,	#2.000000
    fsub	s31,	s9,	s31
    str	s31,	[sp, #252]

    ldr	s5,	[sp, #252]

    ldr	s6,	[sp, #240]

    fdiv	s12,	s5,	s19
    fadd	s24,	s6,	s12
    str	s24,	[sp, #256]

    cmp	w27,	#1
    bne	asr5_145

asr5_136:
    fmov	s30,	#1.000000
    ldr	s2,	[sp, #240]

    fmov	s25,	#1.000000
    fmov	s23,	#4.000000
    fmov	s21,	#1.000000
    fmov	s20,	#6.000000
    ldr	s24,	[sp, #256]

    fdiv	s11,	s30,	s2
    ldr	s31,	[sp, #252]

    fdiv	s7,	s25,	s24
    fmul	s5,	s23,	s7
    fadd	s6,	s11,	s5
    fdiv	s11,	s21,	s9
    fadd	s18,	s6,	s11
    fmul	s12,	s18,	s31
    fdiv	s19,	s12,	s20
    str	s19,	[sp, #272]

    b	asr5_166

asr5_145:
    cmp	w27,	#2
    bne	asr5_165

asr5_147:
    ldr	s12,	[sp, #240]

    fmul	s15,	s12,	s15
    fmov	s12,	#1.000000
    str	s15,	[sp, #228]

    ldr	s15,	[sp, #228]

    fsub	s0,	s12,	s15
    bl	my_sqrt
    fmov	s12,	#1.000000
    fdiv	s11,	s12,	s0
    str	s11,	[sp, #260]

    ldr	s12,	[sp, #256]

    ldr	s11,	[sp, #276]

    fmul	s15,	s12,	s11
    fmov	s12,	#1.000000
    str	s15,	[sp, #224]

    ldr	s15,	[sp, #224]

    fsub	s0,	s12,	s15
    bl	my_sqrt
    fmov	s12,	#1.000000
    fdiv	s15,	s12,	s0
    fmov	s12,	#4.000000
    str	s15,	[sp, #232]

    ldr	s15,	[sp, #232]

    fmul	s11,	s12,	s15
    fmul	s15,	s9,	s9
    ldr	s12,	[sp, #260]

    str	s15,	[sp, #236]

    fadd	s11,	s12,	s11
    ldr	s15,	[sp, #236]

    fmov	s12,	#1.000000
    fsub	s0,	s12,	s15
    bl	my_sqrt
    fmov	s31,	#6.000000
    fmov	s1,	#1.000000
    fdiv	s1,	s1,	s0
    fadd	s19,	s11,	s1
    ldr	s1,	[sp, #252]

    fmul	s3,	s19,	s1
    fdiv	s20,	s3,	s31
    str	s20,	[sp, #272]

    b	asr5_166

asr5_165:
    movi	v21.4s,	#0
    str	s21,	[sp, #272]


asr5_166:
    ldr	s19,	[sp, #272]

    movi	v16.4s,	#0
    fadd	s18,	s14,	s19
    fsub	s17,	s18,	s8
    fneg	s22,	s17
    fcmp	s17,	s16
    fmov	s12,	#15.000000
    fcsel	s25,	s17,	s22,	gt
    cset	w11,	gt
    fmul	s26,	s12,	s13
    fcmp	s25,	s26
    bgt	asr5_178

asr5_175:
    fmov	s1,	#15.000000
    fdiv	s4,	s17,	s1
    fadd	s0,	s18,	s4
    b	asr5_183

asr5_178:
    fmov	s12,	#2.000000
    fmov	s0,	s10
    ldr	s1,	[sp, #240]

    fmov	s3,	s14
    mov	w0,	w27
    fdiv	s12,	s13,	s12
    fmov	s2,	s12
    bl	asr5
    mov	w0,	w27
    fmov	s2,	s12
    fmov	s1,	s9
    fmov	s11,	s0
    ldr	s0,	[sp, #240]

    ldr	s3,	[sp, #272]

    bl	asr5
    fadd	s0,	s11,	s0

asr5_183:
    movz	w18,	#1
    str	w18,	[x26]

    add	x26,	x26,	#4
    str	s10,	[x23]

    str	s9,	[x21]

    str	s13,	[x19]

    str	s8,	[x25]

    str	w27,	[x22]

    str	s0,	[x26]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
        ldp	q8, q9, [sp, #96]
    ldp	q10, q11, [sp, #128]
    ldp	q12, q13, [sp, #160]
    ldp	q14, q15, [sp, #192]

    add	sp, sp, #288
    ret


.globl eee
eee:
eee_1:
    sub	sp, sp, #160
    stp	x25, fp, [sp, #0]
    str	lr, [sp, 16]
    stp	q8, q9, [sp, #32]
    stp	q10, q11, [sp, #64]
    stp	q12, q13, [sp, #96]
    stp	q14, q15, [sp, #128]

    movz	w25,	#0
    movz	w5,	#4719
    fmov	s15,	s0
    movk	w25,	#17136,	lsl #16
    movk	w5,	#14979,	lsl #16
    fmov	s31,	w5
    fcmp	s15,	s31
    ble	eee_27

eee_3:
    fmov	s9,	#2.000000
    fdiv	s11,	s15,	s9
    fcmp	s11,	s31
    ble	eee_10

eee_6:
    fmov	s9,	#2.000000
    fdiv	s0,	s11,	s9
    bl	eee
    fmul	s14,	s0,	s0
    b	eee_24

eee_10:
    fmov	s9,	#1.000000
    fmul	s10,	s11,	s11
    fmov	s8,	#2.000000
    fmov	s0,	s11
    movz	w0,	#3
    fadd	s9,	s9,	s11
    fdiv	s12,	s10,	s8
    fadd	s12,	s9,	s12
    bl	my_pow
    movz	w0,	#4
    fmov	s15,	#6.000000
    fdiv	s15,	s0,	s15
    fmov	s0,	s11
    fadd	s14,	s12,	s15
    bl	my_pow
    movz	w0,	#5
    fmov	s13,	#24.000000
    fdiv	s10,	s0,	s13
    fmov	s0,	s11
    fadd	s13,	s14,	s10
    bl	my_pow
    fmov	s9,	w25
    fdiv	s3,	s0,	s9
    fadd	s14,	s13,	s3

eee_24:
    fmul	s0,	s14,	s14
    b	eee_41

eee_27:
    fmov	s9,	#1.000000
    fmul	s12,	s15,	s15
    fmov	s8,	#2.000000
    fmov	s0,	s15
    movz	w0,	#3
    fadd	s13,	s9,	s15
    fdiv	s11,	s12,	s8
    fadd	s13,	s13,	s11
    bl	my_pow
    movz	w0,	#4
    fmov	s8,	#6.000000
    fdiv	s14,	s0,	s8
    fmov	s0,	s15
    fadd	s11,	s13,	s14
    bl	my_pow
    movz	w0,	#5
    fmov	s13,	#24.000000
    fdiv	s10,	s0,	s13
    fmov	s0,	s15
    fadd	s11,	s11,	s10
    bl	my_pow
    fmov	s17,	w25
    fdiv	s17,	s0,	s17
    fadd	s0,	s11,	s17

eee_41:
    ldp	x25, fp, [sp, #0]
    ldr	lr, [sp, 16]
    ldp	q8, q9, [sp, #32]
    ldp	q10, q11, [sp, #64]
    ldp	q12, q13, [sp, #96]
    ldp	q14, q15, [sp, #128]

    add	sp, sp, #160
    ret


.globl my_exp
my_exp:
my_exp_1:
    sub	sp, sp, #128
    stp	fp, lr, [sp, #0]
        stp	q8, q9, [sp, #16]
    stp	q10, q11, [sp, #48]
    stp	q13, q14, [sp, #80]
    str	q15, [sp, 112]

    movz	w17,	#63572
    movi	v14.4s,	#0
    movk	w17,	#16429,	lsl #16
    fcmp	s0,	s14
    bge	my_exp_20

my_exp_3:
    fneg	s11,	s0
    movi	v15.4s,	#0
    fcmp	s11,	s15
    bge	my_exp_10

my_exp_6:
    fneg	s0,	s11
    bl	my_exp
    fmov	s16,	#1.000000
    fdiv	s10,	s16,	s0
    b	my_exp_17

my_exp_10:
    fcvtzs	w0,	s11
    frintz	s9,	s11
    fmov	s0,	w17
    fsub	s13,	s11,	s9
    bl	my_pow
    fmov	s11,	s0
    fmov	s0,	s13
    bl	eee
    fmul	s10,	s11,	s0

my_exp_17:
    fmov	s18,	#1.000000
    fdiv	s0,	s18,	s10
    b	my_exp_27

my_exp_20:
    fcvtzs	w0,	s0
    frintz	s8,	s0
    fsub	s13,	s0,	s8
    fmov	s0,	w17
    bl	my_pow
    fmov	s10,	s0
    fmov	s0,	s13
    bl	eee
    fmul	s0,	s10,	s0

my_exp_27:
    ldp	fp, lr, [sp, #0]
        ldp	q8, q9, [sp, #16]
    ldp	q10, q11, [sp, #48]
    ldp	q13, q14, [sp, #80]
    ldr	q15, [sp, 112]

    add	sp, sp, #128
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    cmp	w0,	#0
    beq	main_82

main_3:
    mov	w20,	w0

main_5:
    bl	getfloat
    fmov	s12,	s0
    bl	getfloat
    movi	v14.4s,	#0
    fmov	s13,	s0
    movz	w22,	#52343
    fneg	s9,	s12
    movk	w22,	#12843,	lsl #16
    fcmp	s12,	s14
    cset	w24,	gt
    fcsel	s0,	s12,	s9,	gt
    bl	putfloat
    movz	w0,	#32
    bl	putch
    movz	w0,	#2
    fmov	s0,	s12
    bl	my_pow
    bl	putfloat
    movz	w0,	#32
    bl	putch
    fmov	s0,	s12
    bl	my_sqrt
    bl	putfloat
    movz	w0,	#32
    bl	putch
    fmov	s0,	s12
    bl	my_exp
    bl	putfloat
    movz	w0,	#32
    bl	putch
    movi	v8.4s,	#0
    fcmp	s12,	s8
    bgt	main_16

main_28:
    movz	w0,	#45
    bl	putch
    b	main_29

main_16:
    fmov	s9,	#1.000000
    fmov	s8,	#2.000000
    fmov	s3,	#1.000000
    fmov	s2,	#1.000000
    fmov	s15,	#1.000000
    fmov	s14,	#1.000000
    fmov	s11,	#6.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s10,	s12,	s9
    fdiv	s1,	s10,	s8
    fadd	s3,	s3,	s1
    fmov	s1,	#4.000000
    fdiv	s8,	s2,	s3
    fmul	s8,	s1,	s8
    fadd	s1,	s15,	s8
    fdiv	s15,	s14,	s12
    fadd	s1,	s1,	s15
    fmul	s2,	s1,	s10
    fmov	s1,	s12
    fdiv	s3,	s2,	s11
    fmov	s2,	w22
    bl	asr5
    bl	putfloat

main_29:
    movz	w0,	#32
    bl	putch
    movi	v29.4s,	#0
    fcmp	s12,	s29
    ble	main_59

main_31:
    movi	v31.4s,	#0
    fcmp	s13,	s31
    ble	main_59

main_33:
    fmov	s3,	#1.000000
    fmov	s2,	#2.000000
    fmov	s1,	#1.000000
    fmov	s14,	#4.000000
    fmov	s11,	#1.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s9,	s13,	s3
    fdiv	s15,	s9,	s2
    fadd	s1,	s1,	s15
    fmov	s15,	#1.000000
    fdiv	s2,	s15,	s1
    fmov	s1,	s13
    fmov	s15,	#1.000000
    fmul	s3,	s14,	s2
    fdiv	s10,	s15,	s13
    fadd	s2,	s11,	s3
    fadd	s11,	s2,	s10
    fmov	s2,	w22
    fmul	s14,	s11,	s9
    fmov	s9,	#6.000000
    fdiv	s3,	s14,	s9
    bl	asr5
    movz	w0,	#1
    fmov	s8,	s0
    fmov	s3,	#1.000000
    fmov	s2,	#2.000000
    fmov	s1,	#1.000000
    fmov	s15,	#1.000000
    fmov	s14,	#4.000000
    fmov	s0,	#1.000000
    fsub	s9,	s12,	s3
    fdiv	s10,	s9,	s2
    fadd	s10,	s1,	s10
    fmov	s1,	#1.000000
    fdiv	s11,	s15,	s10
    fmul	s15,	s14,	s11
    fadd	s10,	s1,	s15
    fmov	s1,	s12
    fmov	s15,	#1.000000
    fdiv	s2,	s15,	s12
    fadd	s3,	s10,	s2
    fmov	s2,	w22
    fmul	s10,	s3,	s9
    fmov	s9,	#6.000000
    fdiv	s3,	s10,	s9
    bl	asr5
    fdiv	s0,	s8,	s0
    bl	putfloat
    b	main_60

main_59:
    movz	w0,	#45
    bl	putch

main_60:
    movz	w0,	#32
    bl	putch
    movi	v26.4s,	#0
    fcmp	s12,	s26
    bgt	main_62

main_76:
    movz	w0,	#45
    bl	putch
    b	main_77

main_62:
    fmov	s2,	#1.000000
    fmov	s1,	#2.000000
    fmov	s15,	#1.000000
    fmov	s10,	#1.000000
    fmov	s9,	#4.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s11,	s12,	s2
    fdiv	s3,	s11,	s1
    fmov	s1,	s12
    fadd	s8,	s15,	s3
    fdiv	s10,	s10,	s8
    fmov	s8,	#1.000000
    fmul	s14,	s9,	s10
    fadd	s2,	s8,	s14
    fmov	s14,	#1.000000
    fdiv	s9,	s14,	s12
    fadd	s10,	s2,	s9
    fmov	s2,	#6.000000
    fmul	s14,	s10,	s11
    fdiv	s3,	s14,	s2
    fmov	s2,	w22
    bl	asr5
    fmul	s0,	s13,	s0
    bl	my_exp
    bl	putfloat

main_77:
    movz	w0,	#10
    bl	putch
    sub	w20,	w20,	#1
    cmp	w20,	#0
    bne	main_5

main_82:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


