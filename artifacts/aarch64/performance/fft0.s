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
    sub	sp, sp, #112
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w22,	w3
    mov	w27,	w1
    mov	x28,	x0
    cmp	w2,	#1
    beq	fft_69

fft_6:
    movz	w5,	#0
    cmp	w5,	w2
    bge	fft_33

fft_8:
    asr	w6,	w2,	#31
    movz	w3,	#0
    lsr	w7,	w6,	#31
    add	w8,	w2,	w7
    asr	w17,	w8,	#1

fft_11:
    asr	w4,	w3,	#31
    lsr	w5,	w4,	#31
    add	w7,	w3,	w5
    asr	w21,	w7,	#1
    lsl	w24,	w21,	#1
    sub	w10,	w3,	w24
    cmp	w10,	#0
    bne	fft_21

fft_15:
    asr	w0,	w3,	#31
    adrp	x15, :got:temp
    add	w16,	w3,	w27
    ldr	x15, [x15, #:got_lo12:temp]
    lsr	w1,	w0,	#31
    lsl	w20,	w16,	#2
    add	w5,	w3,	w1
    add	x19,	x28,	x20
    asr	w12,	w5,	#1
    ldr	w21,	[x19]

    lsl	w5,	w12,	#2
    add	x13,	x15,	x5
    str	w21,	[x13]

    b	fft_28

fft_21:
    asr	w6,	w3,	#31
    adrp	x5, :got:temp
    ldr	x5, [x5, #:got_lo12:temp]
    lsr	w7,	w6,	#31
    add	w8,	w3,	w7
    add	w7,	w3,	w27
    asr	w24,	w8,	#1
    lsl	w1,	w7,	#2
    add	w26,	w24,	w17
    add	x0,	x28,	x1
    lsl	w10,	w26,	#2
    add	x10,	x5,	x10
    ldr	w5,	[x0]

    str	w5,	[x10]


fft_28:
    add	w3,	w3,	#1
    cmp	w3,	w2
    blt	fft_11

fft_33:
    adrp	x14, :got:temp
    movz	w5,	#0
    ldr	x14, [x14, #:got_lo12:temp]

fft_35:
    cmp	w5,	w2
    bge	fft_44

fft_38:
    add	w11,	w5,	w27
    lsl	w17,	w5,	#2
    add	w5,	w5,	#1
    add	x15,	x14,	x17
    lsl	w13,	w11,	#2
    ldr	w18,	[x15]

    add	x0,	x28,	x13
    str	w18,	[x0]

    b	fft_35

fft_44:
    asr	w1,	w2,	#31
    lsr	w25,	w1,	#31
    mov	w1,	w22
    add	w0,	w2,	w25
    asr	w20,	w0,	#1
    mov	w0,	w22
    bl	multiply
    mov	w2,	w20
    mov	w1,	w27
    mov	w25,	w0
    mov	w3,	w25
    mov	x0,	x28
    bl	fft
    mov	w3,	w25
    mov	w2,	w20
    mov	x0,	x28
    add	w1,	w20,	w27
    bl	fft
    movz	w24,	#1
    movz	w25,	#0

fft_50:
    cmp	w25,	w20
    bge	fft_70

fft_54:
    add	w0,	w25,	w27
    movz	fp,	#100
    add	w1,	w0,	w20
    lsl	w26,	w0,	#2
    mov	w0,	w24
    add	x18,	x28,	x26
    lsl	w26,	w1,	#2
    str	x18,	[sp, fp]

    movz	fp,	#100
    ldr	x19,	[sp, fp]

    ldr	w21,	[x19]

    add	x19,	x28,	x26
    ldr	w1,	[x19]

    bl	multiply
    add	w1,	w0,	w21
    movz	w18,	#1
    movz	fp,	#100
    sub	w0,	w21,	w0
    movk	w18,	#15232,	lsl #16
    sdiv	w23,	w1,	w18
    mul	w26,	w23,	w18
    msub	w23,	w23,	w18,	w1

    str	w26,	[sp, #96]

    add	w1,	w0,	w18
    ldr	x26,	[sp, fp]

    str	w23,	[x26]

    sdiv	w0,	w1,	w18
    msub	w26,	w0,	w18,	w1

    mul	w23,	w0,	w18
    mov	w1,	w22
    str	w26,	[x19]

    mov	w0,	w24
    bl	multiply
    add	w25,	w25,	#1
    mov	w24,	w0
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
    
    add	sp, sp, #112
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
    adrp	x26, :got:b
    mov	w20,	w0
    ldr	x26, [x26, #:got_lo12:b]
    mov	x0,	x26
    bl	getarray
    mov	w19,	w0
    movz	w0,	#60
    bl	_sysy_starttime
    movz	w24,	#1
    add	w28,	w20,	w19
    sub	w27,	w28,	#1

main_7:
    cmp	w24,	w27
    bge	main_12

main_10:
    lsl	w24,	w24,	#1
    b	main_7

main_12:
    movz	w20,	#0
    movz	w0,	#3
    movk	w20,	#15232,	lsl #16
    sdiv	w22,	w20,	w24
    mov	w1,	w22
    bl	power
    mov	w2,	w24
    movz	w1,	#0
    mov	w25,	w0
    mov	w3,	w25
    mov	x0,	x21
    bl	fft
    mov	w3,	w25
    mov	w2,	w24
    movz	w1,	#0
    mov	x0,	x26
    bl	fft
    movz	w25,	#0

main_17:
    cmp	w25,	w24
    bge	main_27

main_20:
    lsl	w19,	w25,	#2
    adrp	x26, :got:a
    lsl	w28,	w25,	#2
    ldr	x26, [x26, #:got_lo12:a]
    add	x26,	x26,	x19
    adrp	x19, :got:b
    ldr	w0,	[x26]

    ldr	x19, [x19, #:got_lo12:b]
    add	x1,	x19,	x28
    ldr	w1,	[x1]

    bl	multiply
    add	w25,	w25,	#1
    str	w0,	[x26]

    b	main_17

main_27:
    sub	w1,	w20,	w22
    movz	w0,	#3
    bl	power
    mov	w2,	w24
    movz	w1,	#0
    mov	w3,	w0
    mov	x0,	x21
    bl	fft
    movz	w1,	#65535
    mov	w0,	w24
    movk	w1,	#15231,	lsl #16
    bl	power
    movz	w20,	#0
    mov	w23,	w0

main_32:
    cmp	w20,	w24
    bge	main_40

main_35:
    lsl	w25,	w20,	#2
    adrp	x28, :got:a
    mov	w1,	w23
    ldr	x28, [x28, #:got_lo12:a]
    add	x22,	x28,	x25
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


