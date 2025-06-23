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

    movz	x15,	#31482
    mov	w27,	w0
    movz	x8,	#31161
    fmov	s8,	s3
    movz	x14,	#5
    fmov	s9,	s2
    fmov	s13,	s1
    fmov	s15,	s0
    movz	x13,	#31161
    adrp	x21, :got:memo.lut.asr5
    movk	x15,	#40503,	lsl #16
    movk	x8,	#40503,	lsl #16
    fmov	w16,	s8
    fmov	w3,	s9
    fmov	w12,	s13
    fmov	w11,	s15
    movk	x13,	#40503,	lsl #16
    ldr	x21, [x21, #:got_lo12:memo.lut.asr5]
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
    ldr	s1,	[x22]

    fcmp	s1,	s15
    add	x23,	x22,	#4
    cset	w13,	eq
    ldr	s30,	[x23]

    fcmp	s30,	s13
    add	x20,	x23,	#4
    cset	w6,	eq
    and	w14,	w6,	w13
    ldr	s7,	[x20]

    fcmp	s7,	s9
    add	x0,	x20,	#4
    cset	w24,	eq
    and	w12,	w14,	w24
    ldr	s10,	[x0]

    fcmp	s10,	s8
    add	x18,	x0,	#4
    cset	w1,	eq
    and	w8,	w12,	w1
    ldr	w21,	[x18]

    cmp	w21,	w27
    cset	w24,	eq
    and	w25,	w8,	w24
    cbnz	w25,	asr5_72
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
    mov	x24,	x22
    mov	x21,	x18
    mov	x22,	x20
    mov	x20,	x0
    b	asr5_87

asr5_76:
    add	x12,	x22,	#4
    mov	x24,	x22
    mov	x23,	x12
    add	x14,	x12,	#4
    mov	x22,	x14
    add	x16,	x14,	#4
    mov	x20,	x16
    add	x18,	x16,	#4
    mov	x21,	x18

asr5_87:
    fsub	s6,	s13,	s15
    fmov	s11,	#2.000000
    fmov	s18,	#2.000000
    fdiv	s4,	s6,	s11
    fadd	s19,	s15,	s4
    str	s19,	[sp, #240]

    ldr	s23,	[sp, #240]

    fsub	s23,	s23,	s15
    str	s23,	[sp, #256]

    ldr	s3,	[sp, #256]

    fdiv	s30,	s3,	s18
    fadd	s16,	s15,	s30
    str	s16,	[sp, #272]

    cmp	w27,	#1
    bne	asr5_109

asr5_100:
    fmov	s28,	#1.000000
    fmov	s26,	#1.000000
    ldr	s19,	[sp, #272]

    fmov	s12,	#6.000000
    fdiv	s25,	s28,	s15
    ldr	s2,	[sp, #240]

    fdiv	s27,	s26,	s19
    fmov	s28,	#4.000000
    ldr	s3,	[sp, #256]

    fmov	s26,	#1.000000
    fmul	s11,	s28,	s27
    fdiv	s16,	s26,	s2
    fadd	s18,	s25,	s11
    fadd	s17,	s18,	s16
    fmul	s16,	s17,	s3
    fdiv	s23,	s16,	s12
    fmov	s11,	s23
    b	asr5_130

asr5_109:
    cmp	w27,	#2
    bne	asr5_129

asr5_111:
    fmul	s10,	s15,	s15
    fmov	s11,	#1.000000
    fsub	s0,	s11,	s10
    bl	my_sqrt
    fmov	s11,	#1.000000
    fdiv	s11,	s11,	s0
    str	s11,	[sp, #248]

    fmov	s11,	#1.000000
    ldr	s10,	[sp, #272]

    fmul	s12,	s10,	s12
    fsub	s0,	s11,	s12
    bl	my_sqrt
    fmov	s11,	#1.000000
    fdiv	s12,	s11,	s0
    fmov	s11,	#4.000000
    fmul	s11,	s11,	s12
    ldr	s12,	[sp, #248]

    fadd	s10,	s12,	s11
    ldr	s11,	[sp, #240]

    fmul	s12,	s11,	s14
    fmov	s11,	#1.000000
    str	s12,	[sp, #276]

    ldr	s12,	[sp, #276]

    fsub	s0,	s11,	s12
    bl	my_sqrt
    fmov	s23,	#6.000000
    ldr	s5,	[sp, #256]

    fmov	s30,	#1.000000
    fdiv	s20,	s30,	s0
    fadd	s30,	s10,	s20
    fmul	s4,	s30,	s5
    fdiv	s23,	s4,	s23
    fmov	s11,	s23
    b	asr5_130

asr5_129:
    movi	v23.4s,	#0
    fmov	s11,	s23

asr5_130:
    ldr	s4,	[sp, #240]

    fmov	s2,	#2.000000
    fsub	s18,	s13,	s4
    str	s18,	[sp, #260]

    ldr	s21,	[sp, #260]

    ldr	s5,	[sp, #240]

    fdiv	s6,	s21,	s2
    fadd	s17,	s5,	s6
    str	s17,	[sp, #252]

    cmp	w27,	#1
    bne	asr5_145

asr5_136:
    fmov	s20,	#1.000000
    ldr	s5,	[sp, #240]

    fmov	s19,	#1.000000
    fmov	s6,	#4.000000
    fmov	s4,	#1.000000
    fdiv	s12,	s20,	s5
    fdiv	s30,	s4,	s13
    ldr	s20,	[sp, #252]

    ldr	s14,	[sp, #260]

    fdiv	s20,	s19,	s20
    fmul	s3,	s6,	s20
    fmov	s6,	#6.000000
    fadd	s1,	s12,	s3
    fadd	s31,	s1,	s30
    fmul	s4,	s31,	s14
    fdiv	s23,	s4,	s6
    fmov	s12,	s23
    b	asr5_166

asr5_145:
    cmp	w27,	#2
    bne	asr5_165

asr5_147:
    ldr	s10,	[sp, #240]

    fmul	s14,	s10,	s14
    fmov	s10,	#1.000000
    str	s14,	[sp, #228]

    ldr	s14,	[sp, #228]

    fsub	s0,	s10,	s14
    bl	my_sqrt
    fmov	s10,	#1.000000
    fdiv	s12,	s10,	s0
    str	s12,	[sp, #244]

    ldr	s12,	[sp, #252]

    ldr	s10,	[sp, #264]

    fmul	s14,	s12,	s10
    fmov	s10,	#1.000000
    str	s14,	[sp, #224]

    ldr	s14,	[sp, #224]

    fsub	s0,	s10,	s14
    bl	my_sqrt
    fmov	s10,	#1.000000
    fdiv	s14,	s10,	s0
    fmov	s10,	#4.000000
    str	s14,	[sp, #232]

    ldr	s14,	[sp, #232]

    fmul	s10,	s10,	s14
    ldr	s14,	[sp, #244]

    fadd	s14,	s14,	s10
    fmov	s10,	#1.000000
    str	s14,	[sp, #268]

    fmul	s14,	s13,	s13
    str	s14,	[sp, #236]

    ldr	s14,	[sp, #236]

    fsub	s0,	s10,	s14
    bl	my_sqrt
    fmov	s12,	#6.000000
    ldr	s24,	[sp, #268]

    fmov	s16,	#1.000000
    fdiv	s21,	s16,	s0
    ldr	s16,	[sp, #260]

    fadd	s30,	s24,	s21
    fmul	s5,	s30,	s16
    fdiv	s23,	s5,	s12
    fmov	s12,	s23
    b	asr5_166

asr5_165:
    movi	v23.4s,	#0
    fmov	s12,	s23

asr5_166:
    fadd	s23,	s11,	s12
    movi	v3.4s,	#0
    fsub	s18,	s23,	s8
    fneg	s1,	s18
    fcmp	s18,	s3
    fmov	s2,	#15.000000
    fcsel	s22,	s18,	s1,	gt
    cset	w11,	gt
    fmul	s5,	s2,	s9
    fcmp	s22,	s5
    bgt	asr5_178

asr5_175:
    fmov	s7,	#15.000000
    fdiv	s16,	s18,	s7
    fadd	s0,	s23,	s16
    b	asr5_183

asr5_178:
    fmov	s3,	#2.000000
    fmov	s0,	s15
    ldr	s1,	[sp, #240]

    mov	w0,	w27
    fdiv	s10,	s9,	s3
    fmov	s3,	s11
    fmov	s2,	s10
    bl	asr5
    mov	w0,	w27
    fmov	s3,	s12
    fmov	s2,	s10
    fmov	s1,	s13
    fmov	s11,	s0
    ldr	s0,	[sp, #240]

    bl	asr5
    fadd	s0,	s11,	s0

asr5_183:
    movz	w18,	#1
    str	w18,	[x26]

    add	x26,	x26,	#4
    str	s15,	[x24]

    str	s13,	[x23]

    str	s9,	[x22]

    str	s8,	[x20]

    str	w27,	[x21]

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
    stp	x22, fp, [sp, #0]
    str	lr, [sp, 16]
    stp	q8, q9, [sp, #32]
    stp	q10, q11, [sp, #64]
    stp	q12, q13, [sp, #96]
    stp	q14, q15, [sp, #128]

    movz	w22,	#0
    movz	w2,	#4719
    fmov	s15,	s0
    movk	w22,	#17136,	lsl #16
    movk	w2,	#14979,	lsl #16
    fmov	s28,	w2
    fcmp	s15,	s28
    ble	eee_27

eee_3:
    fmov	s6,	#2.000000
    fdiv	s9,	s15,	s6
    fcmp	s9,	s28
    ble	eee_10

eee_6:
    fmov	s14,	#2.000000
    fdiv	s0,	s9,	s14
    bl	eee
    fmul	s14,	s0,	s0
    b	eee_24

eee_10:
    fmov	s14,	#1.000000
    fmul	s10,	s9,	s9
    fmov	s13,	#2.000000
    fmov	s0,	s9
    movz	w0,	#3
    fadd	s8,	s14,	s9
    fdiv	s12,	s10,	s13
    fadd	s8,	s8,	s12
    bl	my_pow
    movz	w0,	#4
    fmov	s12,	#6.000000
    fdiv	s15,	s0,	s12
    fmov	s0,	s9
    fadd	s14,	s8,	s15
    bl	my_pow
    movz	w0,	#5
    fmov	s10,	#24.000000
    fdiv	s11,	s0,	s10
    fmov	s0,	s9
    fadd	s12,	s14,	s11
    bl	my_pow
    fmov	s6,	w22
    fdiv	s3,	s0,	s6
    fadd	s14,	s12,	s3

eee_24:
    fmul	s0,	s14,	s14
    b	eee_41

eee_27:
    fmov	s14,	#1.000000
    fmul	s11,	s15,	s15
    fmov	s13,	#2.000000
    fmov	s0,	s15
    movz	w0,	#3
    fadd	s9,	s14,	s15
    fdiv	s11,	s11,	s13
    fadd	s13,	s9,	s11
    bl	my_pow
    movz	w0,	#4
    fmov	s12,	#6.000000
    fdiv	s14,	s0,	s12
    fmov	s0,	s15
    fadd	s11,	s13,	s14
    bl	my_pow
    movz	w0,	#5
    fmov	s10,	#24.000000
    fdiv	s10,	s0,	s10
    fmov	s0,	s15
    fadd	s13,	s11,	s10
    bl	my_pow
    fmov	s14,	w22
    fdiv	s17,	s0,	s14
    fadd	s0,	s13,	s17

eee_41:
    ldp	x22, fp, [sp, #0]
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
    stp	q12, q13, [sp, #80]
    str	q15, [sp, 112]

    movz	w14,	#63572
    movi	v11.4s,	#0
    movk	w14,	#16429,	lsl #16
    fcmp	s0,	s11
    bge	my_exp_20

my_exp_3:
    fneg	s11,	s0
    movi	v12.4s,	#0
    fcmp	s11,	s12
    bge	my_exp_10

my_exp_6:
    fneg	s0,	s11
    bl	my_exp
    fmov	s13,	#1.000000
    fdiv	s10,	s13,	s0
    b	my_exp_17

my_exp_10:
    fcvtzs	w0,	s11
    frintz	s9,	s11
    fmov	s0,	w14
    fsub	s13,	s11,	s9
    bl	my_pow
    fmov	s11,	s0
    fmov	s0,	s13
    bl	eee
    fmul	s10,	s11,	s0

my_exp_17:
    fmov	s15,	#1.000000
    fdiv	s0,	s15,	s10
    b	my_exp_27

my_exp_20:
    fcvtzs	w0,	s0
    frintz	s8,	s0
    fsub	s13,	s0,	s8
    fmov	s0,	w14
    bl	my_pow
    fmov	s10,	s0
    fmov	s0,	s13
    bl	eee
    fmul	s0,	s10,	s0

my_exp_27:
    ldp	fp, lr, [sp, #0]
        ldp	q8, q9, [sp, #16]
    ldp	q10, q11, [sp, #48]
    ldp	q12, q13, [sp, #80]
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
    fmov	s9,	s0
    bl	getfloat
    fmov	s8,	s0
    fneg	s12,	s9
    movi	v11.4s,	#0
    movz	w28,	#52343
    movk	w28,	#12843,	lsl #16
    fcmp	s9,	s11
    cset	w23,	gt
    fcsel	s0,	s9,	s12,	gt
    bl	putfloat
    movz	w0,	#32
    bl	putch
    movz	w0,	#2
    fmov	s0,	s9
    bl	my_pow
    bl	putfloat
    movz	w0,	#32
    bl	putch
    fmov	s0,	s9
    bl	my_sqrt
    bl	putfloat
    movz	w0,	#32
    bl	putch
    fmov	s0,	s9
    bl	my_exp
    bl	putfloat
    movz	w0,	#32
    bl	putch
    movi	v5.4s,	#0
    fcmp	s9,	s5
    bgt	main_16

main_28:
    movz	w0,	#45
    bl	putch
    b	main_29

main_16:
    fmov	s2,	#1.000000
    fmov	s1,	#2.000000
    fmov	s15,	#1.000000
    fmov	s14,	#1.000000
    fmov	s13,	#4.000000
    fmov	s12,	#1.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s3,	s9,	s2
    fdiv	s1,	s3,	s1
    fadd	s2,	s15,	s1
    fdiv	s10,	s14,	s2
    fmul	s11,	s13,	s10
    fmov	s10,	#6.000000
    fadd	s1,	s12,	s11
    fmov	s11,	#1.000000
    fdiv	s15,	s11,	s9
    fadd	s1,	s1,	s15
    fmul	s2,	s1,	s3
    fmov	s1,	s9
    fdiv	s3,	s2,	s10
    fmov	s2,	w28
    bl	asr5
    bl	putfloat

main_29:
    movz	w0,	#32
    bl	putch
    movi	v26.4s,	#0
    fcmp	s9,	s26
    ble	main_59

main_31:
    movi	v28.4s,	#0
    fcmp	s8,	s28
    ble	main_59

main_33:
    fmov	s15,	#1.000000
    fmov	s14,	#2.000000
    fmov	s13,	#1.000000
    fmov	s12,	#1.000000
    fmov	s11,	#4.000000
    fmov	s10,	#1.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s3,	s8,	s15
    fdiv	s15,	s3,	s14
    fadd	s1,	s13,	s15
    fdiv	s2,	s12,	s1
    fmov	s1,	s8
    fmov	s12,	#1.000000
    fmul	s11,	s11,	s2
    fdiv	s12,	s12,	s8
    fmov	s2,	#6.000000
    fadd	s11,	s10,	s11
    fadd	s13,	s11,	s12
    fmul	s14,	s13,	s3
    fdiv	s3,	s14,	s2
    fmov	s2,	w28
    bl	asr5
    fmov	s1,	#6.000000
    fmov	s15,	#1.000000
    fmov	s14,	#2.000000
    movz	w0,	#1
    fmov	s13,	#1.000000
    fmov	s10,	s0
    fmov	s12,	#1.000000
    fsub	s2,	s9,	s15
    fmov	s0,	#1.000000
    fdiv	s11,	s2,	s14
    fadd	s13,	s13,	s11
    fmov	s11,	#4.000000
    fdiv	s14,	s12,	s13
    fmov	s12,	#1.000000
    fmov	s13,	#1.000000
    fmul	s15,	s11,	s14
    fdiv	s3,	s12,	s9
    fadd	s13,	s13,	s15
    fadd	s11,	s13,	s3
    fmul	s12,	s11,	s2
    fmov	s2,	w28
    fdiv	s3,	s12,	s1
    fmov	s1,	s9
    bl	asr5
    fdiv	s0,	s10,	s0
    bl	putfloat
    b	main_60

main_59:
    movz	w0,	#45
    bl	putch

main_60:
    movz	w0,	#32
    bl	putch
    movi	v23.4s,	#0
    fcmp	s9,	s23
    bgt	main_62

main_76:
    movz	w0,	#45
    bl	putch
    b	main_77

main_62:
    fmov	s14,	#1.000000
    fmov	s13,	#2.000000
    fmov	s12,	#1.000000
    fmov	s2,	#4.000000
    fmov	s1,	#1.000000
    fmov	s10,	#1.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s14,	s9,	s14
    fdiv	s3,	s14,	s13
    fadd	s11,	s12,	s3
    fmov	s3,	#1.000000
    fdiv	s12,	s3,	s11
    fdiv	s11,	s10,	s9
    fmul	s13,	s2,	s12
    fadd	s2,	s1,	s13
    fmov	s1,	s9
    fadd	s12,	s2,	s11
    fmov	s2,	w28
    fmul	s13,	s12,	s14
    fmov	s14,	#6.000000
    fdiv	s3,	s13,	s14
    bl	asr5
    fmul	s0,	s8,	s0
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


