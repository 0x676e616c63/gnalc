.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global temp
.align	2
temp:
    .zero	8388608

.global a
.align	2
a:
    .zero	8388608

.global b
.align	2
b:
    .zero	8388608


.text

.globl multiply
multiply:
multiply_2:
    sub	sp, sp, #80
    stp	x21, x22, [sp, #0]
    stp	x23, x24, [sp, #16]
    stp	x25, x26, [sp, #32]
    stp	x27, x28, [sp, #48]
    stp	fp, lr, [sp, #64]
    
    mov	w24,	w1
    mov	w28,	w0
    cmp	w24,	#0
    beq	multiply_36

multiply_4:
    movz	w21,	#1
    movk	w21,	#15232,	lsl #16
    cmp	w24,	#1
    bne	multiply_8

multiply_6:
    sdiv	w2,	w28,	w21
    msub	w0,	w2,	w21,	w28

    b	multiply_38

multiply_8:
    asr	w3,	w24,	#31
    lsr	w4,	w3,	#31
    add	w5,	w24,	w4
    asr	w25,	w5,	#1
    cmp	w25,	#0
    beq	multiply_25

multiply_11:
    cmp	w25,	#1
    bne	multiply_15

multiply_13:
    sdiv	w23,	w28,	w21
    msub	w26,	w23,	w21,	w28

    b	multiply_27

multiply_15:
    asr	w22,	w25,	#31
    mov	w0,	w28
    lsr	w23,	w22,	#31
    add	w26,	w25,	w23
    asr	w1,	w26,	#1
    bl	multiply
    asr	w5,	w25,	#31
    lsl	w26,	w0,	#1
    lsr	w6,	w5,	#31
    sdiv	w9,	w26,	w21
    msub	w26,	w9,	w21,	w26

    add	w7,	w25,	w6
    asr	w16,	w7,	#1
    lsl	w17,	w16,	#1
    sub	w22,	w25,	w17
    cmp	w22,	#1
    bne	multiply_27

multiply_22:
    add	w26,	w26,	w28
    sdiv	w4,	w26,	w21
    msub	w26,	w4,	w21,	w26

    b	multiply_27

multiply_25:
    movz	w26,	#0

multiply_27:
    lsl	w0,	w26,	#1
    asr	w25,	w24,	#31
    sdiv	w8,	w0,	w21
    lsr	w26,	w25,	#31
    msub	w0,	w8,	w21,	w0

    add	w27,	w24,	w26
    asr	w16,	w27,	#1
    lsl	w17,	w16,	#1
    sub	w26,	w24,	w17
    cmp	w26,	#1
    bne	multiply_38

multiply_33:
    add	w14,	w0,	w28
    sdiv	w22,	w14,	w21
    msub	w0,	w22,	w21,	w14

    b	multiply_38

multiply_36:
    movz	w0,	#0

multiply_38:
    ldp	x21, x22, [sp, #0]
    ldp	x23, x24, [sp, #16]
    ldp	x25, x26, [sp, #32]
    ldp	x27, x28, [sp, #48]
    ldp	fp, lr, [sp, #64]
    
    add	sp, sp, #80
    ret


.globl power
power:
power_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w20,	w1
    mov	w27,	w0
    cmp	w20,	#0
    beq	power_24

power_4:
    asr	w10,	w20,	#31
    lsr	w11,	w10,	#31
    add	w12,	w20,	w11
    asr	w28,	w12,	#1
    cmp	w28,	#0
    beq	power_15

power_7:
    asr	w18,	w28,	#31
    mov	w0,	w27
    lsr	w19,	w18,	#31
    add	w21,	w28,	w19
    asr	w1,	w21,	#1
    bl	power
    mov	w1,	w0
    mov	w0,	w1
    bl	multiply
    asr	w22,	w28,	#31
    lsr	w23,	w22,	#31
    add	w24,	w28,	w23
    asr	w6,	w24,	#1
    lsl	w7,	w6,	#1
    sub	w13,	w28,	w7
    cmp	w13,	#1
    bne	power_17

power_13:
    mov	w1,	w27
    bl	multiply
    b	power_17

power_15:
    movz	w0,	#1

power_17:
    mov	w1,	w0
    bl	multiply
    asr	w13,	w20,	#31
    lsr	w14,	w13,	#31
    add	w15,	w20,	w14
    asr	w25,	w15,	#1
    lsl	w26,	w25,	#1
    sub	w4,	w20,	w26
    cmp	w4,	#1
    bne	power_26

power_22:
    mov	w1,	w27
    bl	multiply
    b	power_26

power_24:
    movz	w0,	#1

power_26:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


.globl fft
fft:
fft_4:
    sub	sp, sp, #128
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w22,	w3
    mov	w27,	w1
    mov	x19,	x0
    cmp	w2,	#1
    beq	fft_69

fft_6:
    movz	w5,	#0
    cmp	w5,	w2
    bge	fft_33

fft_8:
    asr	w6,	w2,	#31
    movz	w14,	#0
    lsr	w7,	w6,	#31
    add	w8,	w2,	w7
    asr	w8,	w8,	#1

fft_11:
    asr	w1,	w14,	#31
    lsr	w3,	w1,	#31
    add	w4,	w14,	w3
    asr	w24,	w4,	#1
    lsl	w25,	w24,	#1
    sub	w21,	w14,	w25
    cmp	w21,	#0
    bne	fft_21

fft_15:
    asr	w6,	w14,	#31
    adrp	x17, :got:temp
    add	w18,	w14,	w27
    ldr	x17, [x17, #:got_lo12:temp]
    lsr	w0,	w6,	#31
    lsl	w21,	w18,	#2
    add	w1,	w14,	w0
    add	x20,	x19,	x21
    asr	w24,	w1,	#1
    ldr	w23,	[x20]

    lsl	w26,	w24,	#2
    add	x25,	x17,	x26
    str	w23,	[x25]

    b	fft_28

fft_21:
    asr	w4,	w14,	#31
    add	w9,	w14,	w27
    lsr	w5,	w4,	#31
    add	w6,	w14,	w5
    adrp	x5, :got:temp
    ldr	x5, [x5, #:got_lo12:temp]
    asr	w1,	w6,	#1
    add	w4,	w1,	w8
    lsl	w1,	w9,	#2
    lsl	w6,	w4,	#2
    add	x0,	x19,	x1
    add	x5,	x5,	x6
    ldr	w4,	[x0]

    str	w4,	[x5]


fft_28:
    add	w14,	w14,	#1
    cmp	w14,	w2
    blt	fft_11

fft_33:
    adrp	x18, :got:temp
    movz	w9,	#0
    ldr	x18, [x18, #:got_lo12:temp]

fft_35:
    cmp	w9,	w2
    bge	fft_44

fft_38:
    add	w12,	w9,	w27
    lsl	w7,	w9,	#2
    add	w9,	w9,	#1
    add	x5,	x18,	x7
    lsl	w14,	w12,	#2
    ldr	w0,	[x5]

    add	x13,	x19,	x14
    str	w0,	[x13]

    b	fft_35

fft_44:
    asr	w1,	w2,	#31
    mov	w0,	w22
    lsr	w26,	w1,	#31
    mov	w1,	w22
    add	w28,	w2,	w26
    asr	w20,	w28,	#1
    bl	multiply
    mov	w2,	w20
    mov	w1,	w27
    mov	w26,	w0
    mov	w3,	w26
    mov	x0,	x19
    bl	fft
    mov	w3,	w26
    mov	w2,	w20
    mov	x0,	x19
    add	w1,	w20,	w27
    bl	fft
    movz	w26,	#1
    movz	w23,	#0

fft_50:
    cmp	w23,	w20
    bge	fft_70

fft_54:
    add	w18,	w23,	w27
    movz	fp,	#100
    lsl	w0,	w18,	#2
    add	x25,	x19,	x0
    add	w0,	w18,	w20
    str	x25,	[sp, fp]

    lsl	w18,	w0,	#2
    movz	fp,	#100
    ldr	x28,	[sp, fp]

    movz	fp,	#108
    ldr	w24,	[x28]

    add	x28,	x19,	x18
    str	x28,	[sp, fp]

    movz	fp,	#108
    ldr	x0,	[sp, fp]

    ldr	w1,	[x0]

    mov	w0,	w26
    bl	multiply
    add	w1,	w0,	w24
    movz	w25,	#1
    movz	fp,	#100
    movk	w25,	#15232,	lsl #16
    sdiv	w21,	w1,	w25
    msub	w1,	w21,	w25,	w1

    mul	w28,	w21,	w25
    str	w28,	[sp, #96]

    ldr	x21,	[sp, fp]

    movz	fp,	#108
    str	w1,	[x21]

    sub	w21,	w24,	w0
    ldr	x18,	[sp, fp]

    add	w0,	w21,	w25
    sdiv	w1,	w0,	w25
    msub	w0,	w1,	w25,	w0

    mul	w21,	w1,	w25
    str	w0,	[x18]

    mov	w1,	w22
    mov	w0,	w26
    bl	multiply
    add	w23,	w23,	#1
    mov	w26,	w0
    b	fft_50

fft_70:
    movz	w0,	#0
    b	fft_71

fft_69:
    movz	w0,	#1

fft_71:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #128
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    adrp	x21, :got:a
    ldr	x21, [x21, #:got_lo12:a]
    mov	x0,	x21
    bl	getarray
    adrp	x24, :got:b
    mov	w20,	w0
    ldr	x24, [x24, #:got_lo12:b]
    mov	x0,	x24
    bl	getarray
    mov	w19,	w0
    movz	w0,	#60
    bl	_sysy_starttime
    movz	w26,	#1
    add	w28,	w20,	w19
    sub	w27,	w28,	#1

main_7:
    cmp	w26,	w27
    bge	main_12

main_10:
    lsl	w26,	w26,	#1
    b	main_7

main_12:
    movz	w25,	#0
    movz	w0,	#3
    movk	w25,	#15232,	lsl #16
    sdiv	w20,	w25,	w26
    mov	w1,	w20
    bl	power
    mov	w2,	w26
    movz	w1,	#0
    mov	w23,	w0
    mov	w3,	w23
    mov	x0,	x21
    bl	fft
    mov	w3,	w23
    mov	w2,	w26
    movz	w1,	#0
    mov	x0,	x24
    bl	fft
    movz	w23,	#0

main_17:
    cmp	w23,	w26
    bge	main_27

main_20:
    lsl	w19,	w23,	#2
    adrp	x24, :got:a
    lsl	w28,	w23,	#2
    ldr	x24, [x24, #:got_lo12:a]
    add	x24,	x24,	x19
    adrp	x19, :got:b
    ldr	w0,	[x24]

    ldr	x19, [x19, #:got_lo12:b]
    add	x1,	x19,	x28
    ldr	w1,	[x1]

    bl	multiply
    add	w23,	w23,	#1
    str	w0,	[x24]

    b	main_17

main_27:
    sub	w1,	w25,	w20
    movz	w0,	#3
    bl	power
    mov	w2,	w26
    movz	w1,	#0
    mov	w3,	w0
    mov	x0,	x21
    bl	fft
    movz	w1,	#65535
    mov	w0,	w26
    movk	w1,	#15231,	lsl #16
    bl	power
    movz	w20,	#0
    mov	w23,	w0

main_32:
    cmp	w20,	w26
    bge	main_40

main_35:
    lsl	w24,	w20,	#2
    adrp	x28, :got:a
    mov	w1,	w23
    ldr	x28, [x28, #:got_lo12:a]
    add	x22,	x28,	x24
    ldr	w0,	[x22]

    bl	multiply
    add	w20,	w20,	#1
    str	w0,	[x22]

    b	main_32

main_40:
    movz	w0,	#79
    bl	_sysy_stoptime
    mov	x1,	x21
    mov	w0,	w27
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


