.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global memo.lut.asr5
.align	2
memo.lut.asr5:
.type memo.lut.asr5, %object
    .zero	1835008

.data

.text

.globl my_pow
.align 2
.p2align 4,,11
.type my_pow, %function
my_pow:
my_pow_2:
    sub	sp, sp, #96
    stp	x19, x22, [sp, #0]
    stp	x23, x24, [sp, #16]
    stp	x25, x26, [sp, #32]
    stp	x27, x28, [sp, #48]
    stp	fp, lr, [sp, #64]
        str	q14, [sp, 80]

    cmp	w0,	#0
    blt	my_pow_4

my_pow_27:
    fmov	s18,	#1.000000

my_pow_28:
    cmp	w0,	#0
    beq	my_pow_41

my_pow_33:
    asr	w23,	w0,	#31
    fmul	s5,	s18,	s0
    lsr	w24,	w23,	#31
    add	w25,	w0,	w24
    asr	w11,	w25,	#1
    lsl	w12,	w11,	#1
    sub	w10,	w0,	w12
    cmp	w10,	#0
    asr	w26,	w0,	#31
    fmul	s0,	s0,	s0
    fcsel	s18,	s5,	s18,	ne
    lsr	w27,	w26,	#31
    add	w22,	w0,	w27
    asr	w0,	w22,	#1
    b	my_pow_28

my_pow_4:
    movz	w13,	#0
    sub	w2,	w13,	w0
    cmp	w2,	#0
    blt	my_pow_7

my_pow_10:
    fmov	s29,	#1.000000

my_pow_11:
    cmp	w2,	#0
    beq	my_pow_24

my_pow_16:
    asr	w0,	w2,	#31
    fmul	s14,	s29,	s0
    lsr	w1,	w0,	#31
    add	w3,	w2,	w1
    asr	w15,	w3,	#1
    lsl	w16,	w15,	#1
    sub	w19,	w2,	w16
    cmp	w19,	#0
    asr	w4,	w2,	#31
    fmul	s0,	s0,	s0
    fcsel	s29,	s14,	s29,	ne
    lsr	w5,	w4,	#31
    add	w28,	w2,	w5
    asr	w2,	w28,	#1
    b	my_pow_11

my_pow_7:
    bl	my_pow
    fmov	s19,	#1.000000
    fdiv	s29,	s19,	s0

my_pow_24:
    fmov	s20,	#1.000000
    fdiv	s18,	s20,	s29

my_pow_41:
    fmov	s0,	s18
    ldp	x19, x22, [sp, #0]
    ldp	x23, x24, [sp, #16]
    ldp	x25, x26, [sp, #32]
    ldp	x27, x28, [sp, #48]
    ldp	fp, lr, [sp, #64]
        ldr	q14, [sp, 80]

    add	sp, sp, #96
    ret


.globl my_sqrt
.align 2
.p2align 4,,11
.type my_sqrt, %function
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
    fmov	s11,	w10
    fcmp	s0,	s11
    bgt	my_sqrt_3

my_sqrt_50:
    fmov	s25,	#8.000000
    fmov	s24,	#0.500000
    fmov	s23,	#2.000000
    fmov	s22,	#4.000000
    fmov	s21,	#2.000000
    fmov	s19,	#2.000000
    fmov	s16,	#2.000000
    fdiv	s27,	s0,	s25
    fmul	s14,	s23,	s0
    fadd	s17,	s22,	s0
    fadd	s13,	s27,	s24
    fdiv	s18,	s14,	s17
    fmov	s17,	#2.000000
    fadd	s1,	s13,	s18
    fmov	s18,	#2.000000
    fdiv	s20,	s0,	s1
    fadd	s3,	s1,	s20
    fmov	s20,	#2.000000
    fdiv	s4,	s3,	s21
    fdiv	s23,	s0,	s4
    fadd	s6,	s4,	s23
    fdiv	s7,	s6,	s20
    fdiv	s26,	s0,	s7
    fadd	s9,	s7,	s26
    fdiv	s10,	s9,	s19
    fdiv	s29,	s0,	s10
    fadd	s12,	s10,	s29
    fdiv	s14,	s12,	s18
    fmov	s12,	#2.000000
    fdiv	s1,	s0,	s14
    fadd	s15,	s14,	s1
    fmov	s14,	#2.000000
    fdiv	s17,	s15,	s17
    fmov	s15,	#2.000000
    fdiv	s4,	s0,	s17
    fadd	s19,	s17,	s4
    fdiv	s20,	s19,	s16
    fdiv	s7,	s0,	s20
    fadd	s22,	s20,	s7
    fdiv	s23,	s22,	s15
    fdiv	s10,	s0,	s23
    fadd	s25,	s23,	s10
    fdiv	s26,	s25,	s14
    fdiv	s13,	s0,	s26
    fadd	s28,	s26,	s13
    fmov	s13,	#2.000000
    fdiv	s29,	s28,	s13
    fdiv	s16,	s0,	s29
    fadd	s31,	s29,	s16
    fdiv	s0,	s31,	s12
    b	my_sqrt_87

my_sqrt_3:
    fdiv	s27,	s0,	s11
    fcmp	s27,	s11
    bgt	my_sqrt_6

my_sqrt_10:
    fmov	s10,	#8.000000
    fmov	s9,	#0.500000
    fmov	s8,	#2.000000
    fmov	s7,	#4.000000
    fmov	s6,	#2.000000
    fmov	s5,	#2.000000
    fmov	s4,	#2.000000
    fmov	s1,	#2.000000
    fdiv	s22,	s27,	s10
    fmul	s24,	s8,	s27
    fadd	s7,	s7,	s27
    fadd	s13,	s22,	s9
    fdiv	s8,	s24,	s7
    fadd	s28,	s13,	s8
    fdiv	s10,	s27,	s28
    fadd	s30,	s28,	s10
    fmov	s28,	#2.000000
    fdiv	s31,	s30,	s6
    fmov	s30,	#2.000000
    fdiv	s13,	s27,	s31
    fadd	s2,	s31,	s13
    fmov	s31,	#2.000000
    fdiv	s3,	s2,	s5
    fmov	s2,	#2.000000
    fdiv	s16,	s27,	s3
    fadd	s6,	s3,	s16
    fmov	s3,	#2.000000
    fdiv	s6,	s6,	s4
    fdiv	s19,	s27,	s6
    fadd	s9,	s6,	s19
    fdiv	s9,	s9,	s3
    fdiv	s22,	s27,	s9
    fadd	s12,	s9,	s22
    fdiv	s12,	s12,	s2
    fdiv	s25,	s27,	s12
    fadd	s15,	s12,	s25
    fdiv	s15,	s15,	s1
    fdiv	s29,	s27,	s15
    fadd	s17,	s15,	s29
    fmov	s29,	#2.000000
    fdiv	s19,	s17,	s31
    fdiv	s1,	s27,	s19
    fadd	s20,	s19,	s1
    fdiv	s22,	s20,	s30
    fdiv	s4,	s27,	s22
    fadd	s23,	s22,	s4
    fdiv	s25,	s23,	s29
    fdiv	s23,	s27,	s25
    fadd	s8,	s25,	s23
    fdiv	s23,	s8,	s28
    b	my_sqrt_47

my_sqrt_6:
    fdiv	s0,	s27,	s11
    bl	my_sqrt
    fmov	s11,	#10.000000
    fmul	s23,	s11,	s0

my_sqrt_47:
    fmov	s13,	#10.000000
    fmul	s0,	s13,	s23

my_sqrt_87:
    ldp	fp, lr, [sp, #0]
        ldp	q8, q9, [sp, #16]
    ldp	q10, q11, [sp, #48]
    ldp	q12, q13, [sp, #80]
    ldp	q14, q15, [sp, #112]

    add	sp, sp, #144
    ret


.globl asr5
.align 2
.p2align 4,,11
.type asr5, %function
asr5:
asr5_5:
    sub	sp, sp, #272
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

    movz	x7,	#31161
    fmov	s13,	s2
    fmov	s9,	s3
    mov	w21,	w0
    fmov	s12,	s1
    fmov	s11,	s0
    movz	x12,	#5
    movz	x10,	#31161
    movz	x11,	#31161
    movk	x7,	#40503,	lsl #16
    fmov	w13,	s13
    fmov	w26,	s9
    movz	x0,	#31482
    mov	w23,	w21
    fmov	w1,	s12
    fmov	w9,	s11
    movk	x10,	#40503,	lsl #16
    movk	x11,	#40503,	lsl #16
    movk	x0,	#40503,	lsl #16
    add	x22,	x9,	x0
    eor	x0,	x22,	x12
    movz	x12,	#31161
    adrp	x22, :got:memo.lut.asr5
    lsr	x27,	x0,	#2
    lsl	x9,	x0,	#6
    movk	x12,	#40503,	lsl #16
    ldr	x22, [x22, #:got_lo12:memo.lut.asr5]
    add	x4,	x27,	x11
    add	x5,	x4,	x9
    add	x24,	x5,	x1
    eor	x4,	x0,	x24
    lsr	x8,	x4,	#2
    lsl	x19,	x4,	#6
    add	x0,	x8,	x10
    add	x1,	x0,	x19
    add	x19,	x1,	x13
    eor	x11,	x4,	x19
    lsr	x5,	x11,	#2
    lsl	x10,	x11,	#6
    add	x25,	x5,	x12
    add	x27,	x25,	x10
    add	x8,	x27,	x26
    eor	x4,	x11,	x8
    lsr	x2,	x4,	#2
    lsl	x24,	x4,	#6
    add	x12,	x2,	x7
    movz	x7,	#65535
    add	x13,	x12,	x24
    add	x15,	x13,	x23
    eor	x16,	x4,	x15
    and	x17,	x16,	x7
    lsl	w8,	w17,	#5
    sub	w18,	w8,	w17,	lsl #2
    lsl	x19,	x18,	#0
    add	x27,	x22,	x19
    add	x22,	x27,	#8
    ldr	w13,	[x27]

    cmp	w13,	#0
    bne	asr5_48

asr5_76:
    add	x9,	x22,	#4
    mov	x25,	x9
    add	x11,	x9,	#4
    mov	x24,	x11
    add	x13,	x11,	#4
    mov	x20,	x13
    add	x15,	x13,	#4
    mov	x23,	x15
    b	asr5_87

asr5_48:
    ldr	s10,	[x22]

    fcmp	s10,	s11
    add	x25,	x22,	#4
    cset	w24,	eq
    ldr	s17,	[x25]

    fcmp	s17,	s12
    add	x18,	x25,	#4
    cset	w15,	eq
    and	w0,	w15,	w24
    ldr	s27,	[x18]

    fcmp	s27,	s13
    add	x28,	x18,	#4
    cset	w6,	eq
    and	w23,	w0,	w6
    ldr	s1,	[x28]

    fcmp	s1,	s9
    add	x4,	x28,	#4
    cset	w9,	eq
    and	w20,	w23,	w9
    ldr	w6,	[x4]

    cmp	w6,	w21
    cset	w7,	eq
    and	w8,	w20,	w7
    cbnz	w8,	asr5_72

asr5_86:
    mov	x24,	x18
    mov	x20,	x28
    mov	x23,	x4

asr5_87:
    fsub	s22,	s12,	s11
    fmov	s5,	#2.000000
    fmov	s4,	#2.000000
    fdiv	s15,	s22,	s5
    fadd	s18,	s11,	s15
    str	s18,	[sp, #236]

    ldr	s19,	[sp, #236]

    fsub	s26,	s19,	s11
    str	s26,	[sp, #252]

    ldr	s29,	[sp, #252]

    fdiv	s10,	s29,	s4
    fadd	s15,	s11,	s10
    cmp	w21,	#1
    beq	asr5_100

asr5_109:
    cmp	w21,	#2
    beq	asr5_111

asr5_129:
    movi	v20.4s,	#0
    fmov	s14,	s20
    b	asr5_130

asr5_111:
    fmul	s10,	s11,	s11
    fmov	s14,	#1.000000
    fsub	s0,	s14,	s10
    bl	my_sqrt
    fmul	s10,	s15,	s15
    fmov	s14,	#1.000000
    fmov	s15,	#1.000000
    fdiv	s14,	s14,	s0
    fsub	s0,	s15,	s10
    str	s14,	[sp, #248]

    bl	my_sqrt
    fmov	s14,	#1.000000
    fdiv	s15,	s14,	s0
    fmov	s14,	#4.000000
    fmul	s14,	s14,	s15
    ldr	s15,	[sp, #248]

    fadd	s14,	s15,	s14
    ldr	s15,	[sp, #236]

    fmul	s10,	s15,	s8
    fmov	s15,	#1.000000
    fsub	s0,	s15,	s10
    bl	my_sqrt
    fmov	s6,	#6.000000
    ldr	s28,	[sp, #252]

    fmov	s7,	#1.000000
    fdiv	s4,	s7,	s0
    fadd	s7,	s14,	s4
    fmul	s20,	s7,	s28
    fdiv	s20,	s20,	s6
    fmov	s14,	s20
    b	asr5_130

asr5_100:
    fmov	s18,	#1.000000
    fmov	s17,	#1.000000
    fmov	s16,	#4.000000
    ldr	s5,	[sp, #236]

    fdiv	s19,	s18,	s11
    fdiv	s20,	s17,	s15
    fmov	s15,	#1.000000
    fmul	s29,	s16,	s20
    fdiv	s1,	s15,	s5
    fadd	s31,	s19,	s29
    ldr	s29,	[sp, #252]

    fadd	s14,	s31,	s1
    fmul	s3,	s14,	s29
    fmov	s14,	#6.000000
    fdiv	s20,	s3,	s14
    fmov	s14,	s20

asr5_130:
    ldr	s31,	[sp, #236]

    fmov	s19,	#2.000000
    fsub	s2,	s12,	s31
    str	s2,	[sp, #260]

    ldr	s7,	[sp, #260]

    fdiv	s6,	s7,	s19
    ldr	s7,	[sp, #236]

    fadd	s24,	s7,	s6
    str	s24,	[sp, #256]

    cmp	w21,	#1
    beq	asr5_136

asr5_145:
    cmp	w21,	#2
    beq	asr5_147

asr5_165:
    movi	v29.4s,	#0
    fmov	s10,	s29
    b	asr5_166

asr5_147:
    ldr	s15,	[sp, #236]

    fmul	s10,	s15,	s8
    fmov	s15,	#1.000000
    str	s10,	[sp, #224]

    ldr	s8,	[sp, #224]

    fsub	s0,	s15,	s8
    bl	my_sqrt
    fmov	s15,	#1.000000
    fdiv	s10,	s15,	s0
    fmov	s15,	#1.000000
    str	s10,	[sp, #244]

    ldr	s8,	[sp, #256]

    ldr	s10,	[sp, #268]

    fmul	s10,	s8,	s10
    str	s10,	[sp, #228]

    ldr	s10,	[sp, #228]

    fsub	s0,	s15,	s10
    bl	my_sqrt
    fmov	s15,	#1.000000
    fdiv	s10,	s15,	s0
    fmov	s15,	#4.000000
    str	s10,	[sp, #240]

    ldr	s8,	[sp, #240]

    fmul	s10,	s15,	s8
    ldr	s15,	[sp, #244]

    fadd	s8,	s15,	s10
    fmul	s15,	s12,	s12
    str	s8,	[sp, #264]

    str	s15,	[sp, #232]

    ldr	s8,	[sp, #232]

    fmov	s15,	#1.000000
    fsub	s0,	s15,	s8
    bl	my_sqrt
    ldr	s22,	[sp, #264]

    fmov	s20,	#6.000000
    fmov	s21,	#1.000000
    ldr	s2,	[sp, #260]

    fdiv	s18,	s21,	s0
    fadd	s1,	s22,	s18
    fmul	s23,	s1,	s2
    fdiv	s29,	s23,	s20
    fmov	s10,	s29
    b	asr5_166

asr5_136:
    fmov	s7,	#1.000000
    ldr	s2,	[sp, #236]

    fmov	s6,	#1.000000
    fmov	s5,	#4.000000
    fmov	s4,	#1.000000
    ldr	s26,	[sp, #256]

    fdiv	s22,	s7,	s2
    ldr	s3,	[sp, #260]

    fdiv	s23,	s6,	s26
    fmul	s20,	s5,	s23
    fdiv	s23,	s4,	s12
    fadd	s21,	s22,	s20
    fadd	s16,	s21,	s23
    fmul	s27,	s16,	s3
    fmov	s3,	#6.000000
    fdiv	s29,	s27,	s3
    fmov	s10,	s29

asr5_166:
    fadd	s18,	s14,	s10
    movi	v16.4s,	#0
    fsub	s31,	s18,	s9
    fneg	s21,	s31
    fcmp	s31,	s16
    fmov	s15,	#15.000000
    fcsel	s23,	s31,	s21,	gt
    cset	w8,	gt
    fmul	s25,	s15,	s13
    fcmp	s23,	s25
    ble	asr5_175

asr5_178:
    fmov	s2,	#2.000000
    fmov	s0,	s11
    ldr	s1,	[sp, #236]

    fmov	s3,	s14
    mov	w0,	w21
    fdiv	s15,	s13,	s2
    fmov	s2,	s15
    bl	asr5
    mov	w0,	w21
    fmov	s3,	s10
    fmov	s2,	s15
    fmov	s1,	s12
    fmov	s14,	s0
    ldr	s0,	[sp, #236]

    bl	asr5
    fadd	s0,	s14,	s0
    b	asr5_183

asr5_175:
    fmov	s2,	#15.000000
    fdiv	s5,	s31,	s2
    fadd	s0,	s18,	s5

asr5_183:
    movz	w18,	#1
    str	w18,	[x27]

    str	s11,	[x22]

    str	s12,	[x25]

    str	s13,	[x24]

    str	s9,	[x20]

    str	w21,	[x23]

    add	x23,	x27,	#4
    str	s0,	[x23]

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

    add	sp, sp, #272
    ret


asr5_72:
    add	x25,	x27,	#4
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

    add	sp, sp, #272
    ret


.globl eee
.align 2
.p2align 4,,11
.type eee, %function
eee:
eee_1:
    sub	sp, sp, #160
    stp	x24, x25, [sp, #0]
    stp	fp, lr, [sp, #16]
        stp	q8, q9, [sp, #32]
    stp	q10, q11, [sp, #64]
    stp	q12, q13, [sp, #96]
    stp	q14, q15, [sp, #128]

    movz	w25,	#0
    movz	w24,	#4719
    fmov	s8,	s0
    movk	w25,	#17136,	lsl #16
    movk	w24,	#14979,	lsl #16
    fmov	s15,	w24
    fcmp	s8,	s15
    bgt	eee_3

eee_27:
    fmov	s12,	#1.000000
    fmov	s11,	#2.000000
    fmov	s0,	s8
    movz	w0,	#3
    fadd	s15,	s12,	s8
    fmul	s12,	s8,	s8
    fdiv	s14,	s12,	s11
    fadd	s11,	s15,	s14
    bl	my_pow
    movz	w0,	#4
    fmov	s9,	#6.000000
    fdiv	s10,	s0,	s9
    fmov	s0,	s8
    fadd	s12,	s11,	s10
    bl	my_pow
    movz	w0,	#5
    fmov	s14,	#24.000000
    fdiv	s13,	s0,	s14
    fmov	s0,	s8
    fadd	s14,	s12,	s13
    bl	my_pow
    fmov	s27,	w25
    fdiv	s29,	s0,	s27
    fadd	s0,	s14,	s29
    b	eee_41

eee_3:
    fmov	s5,	#2.000000
    fdiv	s8,	s8,	s5
    fcmp	s8,	s15
    bgt	eee_6

eee_10:
    fmov	s14,	#1.000000
    fmul	s15,	s8,	s8
    fmov	s13,	#2.000000
    fmov	s0,	s8
    movz	w0,	#3
    fadd	s11,	s14,	s8
    fdiv	s15,	s15,	s13
    fadd	s9,	s11,	s15
    bl	my_pow
    movz	w0,	#4
    fmov	s12,	#6.000000
    fdiv	s11,	s0,	s12
    fmov	s0,	s8
    fadd	s13,	s9,	s11
    bl	my_pow
    movz	w0,	#5
    fmov	s10,	#24.000000
    fdiv	s14,	s0,	s10
    fmov	s0,	s8
    fadd	s10,	s13,	s14
    bl	my_pow
    fmov	s6,	w25
    fdiv	s13,	s0,	s6
    fadd	s14,	s10,	s13
    b	eee_24

eee_6:
    fmov	s15,	#2.000000
    fdiv	s0,	s8,	s15
    bl	eee
    fmul	s14,	s0,	s0

eee_24:
    fmul	s0,	s14,	s14

eee_41:
    ldp	x24, x25, [sp, #0]
    ldp	fp, lr, [sp, #16]
        ldp	q8, q9, [sp, #32]
    ldp	q10, q11, [sp, #64]
    ldp	q12, q13, [sp, #96]
    ldp	q14, q15, [sp, #128]

    add	sp, sp, #160
    ret


.globl my_exp
.align 2
.p2align 4,,11
.type my_exp, %function
my_exp:
my_exp_1:
    sub	sp, sp, #112
    stp	fp, lr, [sp, #0]
        stp	q8, q9, [sp, #16]
    stp	q11, q12, [sp, #48]
    stp	q14, q15, [sp, #80]

    movz	w7,	#63572
    movi	v4.4s,	#0
    movk	w7,	#16429,	lsl #16
    fcmp	s0,	s4
    blt	my_exp_3

my_exp_20:
    fcvtzs	w0,	s0
    frintz	s12,	s0
    fsub	s15,	s0,	s12
    fmov	s0,	w7
    bl	my_pow
    fmov	s14,	s0
    fmov	s0,	s15
    bl	eee
    fmul	s0,	s14,	s0
    b	my_exp_27

my_exp_3:
    fneg	s18,	s0
    movi	v6.4s,	#0
    fcmp	s18,	s6
    blt	my_exp_6

my_exp_10:
    fcvtzs	w0,	s18
    frintz	s12,	s18
    fmov	s0,	w7
    fsub	s8,	s18,	s12
    bl	my_pow
    fmov	s14,	s0
    fmov	s0,	s8
    bl	eee
    fmul	s11,	s14,	s0
    b	my_exp_17

my_exp_6:
    fneg	s0,	s18
    bl	my_exp
    fmov	s8,	#1.000000
    fdiv	s11,	s8,	s0

my_exp_17:
    fmov	s9,	#1.000000
    fdiv	s0,	s9,	s11

my_exp_27:
    ldp	fp, lr, [sp, #0]
        ldp	q8, q9, [sp, #16]
    ldp	q11, q12, [sp, #48]
    ldp	q14, q15, [sp, #80]

    add	sp, sp, #112
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
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
    fmov	s13,	s0
    fneg	s10,	s12
    movi	v8.4s,	#0
    movz	w21,	#52343
    movk	w21,	#12843,	lsl #16
    fcmp	s12,	s8
    cset	w24,	gt
    fcsel	s0,	s12,	s10,	gt
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
    movi	v29.4s,	#0
    fcmp	s12,	s29
    ble	main_28

main_16:
    fmov	s3,	#1.000000
    fmov	s2,	#2.000000
    fmov	s1,	#1.000000
    fmov	s15,	#1.000000
    fmov	s14,	#4.000000
    fmov	s11,	#1.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s8,	s12,	s3
    fdiv	s2,	s8,	s2
    fadd	s2,	s1,	s2
    fdiv	s3,	s15,	s2
    fmul	s9,	s14,	s3
    fadd	s1,	s11,	s9
    fmov	s9,	#1.000000
    fdiv	s15,	s9,	s12
    fmov	s9,	#6.000000
    fadd	s1,	s1,	s15
    fmul	s2,	s1,	s8
    fmov	s1,	s12
    fdiv	s3,	s2,	s9
    fmov	s2,	w21
    bl	asr5
    bl	putfloat
    b	main_29

main_28:
    movz	w0,	#45
    bl	putch

main_29:
    movz	w0,	#32
    bl	putch
    movi	v19.4s,	#0
    fcmp	s12,	s19
    ble	main_59

main_31:
    movi	v21.4s,	#0
    fcmp	s13,	s21
    bgt	main_33

main_59:
    movz	w0,	#45
    bl	putch
    b	main_60

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
    fmul	s3,	s14,	s2
    fmov	s14,	#1.000000
    fadd	s2,	s11,	s3
    fdiv	s10,	s14,	s13
    fadd	s11,	s2,	s10
    fmov	s2,	w21
    fmul	s14,	s11,	s9
    fmov	s9,	#6.000000
    fdiv	s3,	s14,	s9
    bl	asr5
    fmov	s8,	s0
    fmov	s11,	#4.000000
    fmov	s2,	#1.000000
    fmov	s1,	#2.000000
    fmov	s15,	#1.000000
    movz	w0,	#1
    fmov	s14,	#1.000000
    fmov	s0,	#1.000000
    fsub	s3,	s12,	s2
    fdiv	s9,	s3,	s1
    fmov	s1,	s12
    fadd	s10,	s15,	s9
    fdiv	s14,	s14,	s10
    fmul	s15,	s11,	s14
    fmov	s11,	#1.000000
    fmov	s14,	#1.000000
    fdiv	s2,	s11,	s12
    fadd	s10,	s14,	s15
    fadd	s9,	s10,	s2
    fmov	s2,	w21
    fmul	s10,	s9,	s3
    fmov	s3,	#6.000000
    fdiv	s3,	s10,	s3
    bl	asr5
    fdiv	s0,	s8,	s0
    bl	putfloat

main_60:
    movz	w0,	#32
    bl	putch
    movi	v16.4s,	#0
    fcmp	s12,	s16
    ble	main_76

main_62:
    fmov	s2,	#1.000000
    fmov	s1,	#2.000000
    fmov	s15,	#1.000000
    fmov	s8,	#1.000000
    fmov	s0,	#1.000000
    movz	w0,	#1
    fsub	s11,	s12,	s2
    fmov	s2,	#1.000000
    fdiv	s3,	s11,	s1
    fmov	s1,	s12
    fadd	s9,	s15,	s3
    fmov	s15,	#6.000000
    fmov	s3,	#4.000000
    fdiv	s10,	s8,	s9
    fmov	s8,	#1.000000
    fmul	s14,	s3,	s10
    fdiv	s9,	s8,	s12
    fadd	s2,	s2,	s14
    fadd	s10,	s2,	s9
    fmov	s2,	w21
    fmul	s11,	s10,	s11
    fdiv	s3,	s11,	s15
    bl	asr5
    fmul	s0,	s13,	s0
    bl	my_exp
    bl	putfloat
    b	main_77

main_76:
    movz	w0,	#45
    bl	putch

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


