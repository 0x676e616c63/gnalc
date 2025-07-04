.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global temp
.align	2
temp:
.type temp, %object
    .zero	8388608

.global a
.align	2
a:
.type a, %object
    .zero	8388608

.global b
.align	2
b:
.type b, %object
    .zero	8388608

.data

.text

.globl multiply
.align 2
.p2align 4,,11
.type multiply, %function
multiply:
multiply_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x23, [sp, #16]
    stp	x24, x25, [sp, #32]
    stp	x26, x27, [sp, #48]
    stp	x28, fp, [sp, #64]
    str	lr, [sp, 80]

    mov	w19,	w1
    mov	w23,	w0
    cmp	w19,	#0
    bne	multiply_4

multiply_36:
    movz	w0,	#0
    b	multiply_38

multiply_4:
    movz	w21,	#1
    movk	w21,	#15232,	lsl #16
    cmp	w19,	#1
    beq	multiply_6

multiply_8:
    asr	w3,	w19,	#31
    lsr	w4,	w3,	#31
    add	w5,	w19,	w4
    asr	w25,	w5,	#1
    cmp	w25,	#0
    bne	multiply_11

multiply_25:
    movz	w26,	#0
    b	multiply_27

multiply_11:
    cmp	w25,	#1
    beq	multiply_13

multiply_15:
    asr	w24,	w25,	#31
    mov	w0,	w23
    lsr	w26,	w24,	#31
    add	w27,	w25,	w26
    asr	w1,	w27,	#1
    bl	multiply
    lsl	w24,	w0,	#1
    sdiv	w5,	w24,	w21
    msub	w26,	w5,	w21,	w24

    asr	w5,	w25,	#31
    lsr	w6,	w5,	#31
    add	w7,	w25,	w6
    asr	w12,	w7,	#1
    lsl	w13,	w12,	#1
    sub	w20,	w25,	w13
    cmp	w20,	#1
    bne	multiply_27

multiply_22:
    add	w25,	w26,	w23
    sdiv	w0,	w25,	w21
    msub	w26,	w0,	w21,	w25

    b	multiply_27

multiply_13:
    sdiv	w2,	w23,	w21
    msub	w26,	w2,	w21,	w23


multiply_27:
    lsl	w28,	w26,	#1
    asr	w26,	w19,	#31
    sdiv	w6,	w28,	w21
    lsr	w27,	w26,	#31
    msub	w0,	w6,	w21,	w28

    add	w28,	w19,	w27
    asr	w14,	w28,	#1
    lsl	w15,	w14,	#1
    sub	w26,	w19,	w15
    cmp	w26,	#1
    bne	multiply_38

multiply_33:
    add	w13,	w0,	w23
    sdiv	w19,	w13,	w21
    msub	w0,	w19,	w21,	w13

    b	multiply_38

multiply_6:
    sdiv	w20,	w23,	w21
    msub	w0,	w20,	w21,	w23


multiply_38:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x23, [sp, #16]
    ldp	x24, x25, [sp, #32]
    ldp	x26, x27, [sp, #48]
    ldp	x28, fp, [sp, #64]
    ldr	lr, [sp, 80]

    add	sp, sp, #96
    ret


.globl power
.align 2
.p2align 4,,11
.type power, %function
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
    bne	power_4

power_24:
    movz	w0,	#1
    b	power_26

power_4:
    asr	w10,	w20,	#31
    lsr	w11,	w10,	#31
    add	w12,	w20,	w11
    asr	w28,	w12,	#1
    cmp	w28,	#0
    bne	power_7

power_15:
    movz	w0,	#1
    b	power_17

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
.align 2
.p2align 4,,11
.type fft, %function
fft:
fft_4:
    sub	sp, sp, #112
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w23,	w3
    mov	w25,	w1
    mov	x20,	x0
    cmp	w2,	#1
    bne	fft_6

fft_69:
    movz	w0,	#1
    b	fft_71

fft_6:
    movz	w5,	#0
    cmp	w5,	w2
    bge	fft_33

fft_8:
    asr	w6,	w2,	#31
    movz	w13,	#0
    lsr	w7,	w6,	#31
    add	w8,	w2,	w7
    asr	w14,	w8,	#1

fft_11:
    asr	w0,	w13,	#31
    lsr	w3,	w0,	#31
    add	w4,	w13,	w3
    asr	w26,	w4,	#1
    lsl	w27,	w26,	#1
    sub	w21,	w13,	w27
    cmp	w21,	#0
    beq	fft_15

fft_21:
    asr	w5,	w13,	#31
    adrp	x19, :got:temp
    ldr	x19, [x19, #:got_lo12:temp]
    lsr	w0,	w5,	#31
    add	w1,	w13,	w0
    asr	w26,	w1,	#1
    add	w27,	w26,	w14
    lsl	w0,	w27,	#2
    add	x28,	x19,	x0
    add	w19,	w13,	w25
    lsl	w22,	w19,	#2
    add	x21,	x20,	x22
    ldr	w26,	[x21]

    str	w26,	[x28]

    b	fft_28

fft_15:
    asr	w4,	w13,	#31
    add	w7,	w13,	w25
    lsr	w5,	w4,	#31
    lsl	w1,	w7,	#2
    add	w6,	w13,	w5
    add	x0,	x20,	x1
    adrp	x5, :got:temp
    ldr	x5, [x5, #:got_lo12:temp]
    asr	w4,	w6,	#1
    lsl	w6,	w4,	#2
    ldr	w4,	[x0]

    add	x5,	x5,	x6
    str	w4,	[x5]


fft_28:
    add	w13,	w13,	#1
    cmp	w13,	w2
    blt	fft_11

fft_33:
    adrp	x18, :got:temp
    movz	w9,	#0
    ldr	x18, [x18, #:got_lo12:temp]

fft_35:
    cmp	w9,	w2
    blt	fft_38

fft_44:
    asr	w1,	w2,	#31
    lsr	w27,	w1,	#31
    mov	w1,	w23
    add	w0,	w2,	w27
    asr	w21,	w0,	#1
    mov	w0,	w23
    bl	multiply
    mov	w2,	w21
    mov	w1,	w25
    mov	w26,	w0
    mov	w3,	w26
    mov	x0,	x20
    bl	fft
    mov	w3,	w26
    mov	w2,	w21
    mov	x0,	x20
    add	w1,	w21,	w25
    bl	fft
    movz	w28,	#1
    movz	w24,	#0

fft_50:
    cmp	w24,	w21
    blt	fft_54

fft_70:
    movz	w0,	#0

fft_71:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #112
    ret


fft_54:
    add	w0,	w24,	w25
    movz	fp,	#100
    lsl	w22,	w0,	#2
    add	x19,	x20,	x22
    add	w22,	w0,	w21
    mov	w0,	w28
    ldr	w27,	[x19]

    lsl	w1,	w22,	#2
    str	w27,	[sp, #108]

    add	x26,	x20,	x1
    str	x26,	[sp, fp]

    movz	fp,	#100
    ldr	x27,	[sp, fp]

    ldr	w1,	[x27]

    bl	multiply
    movz	fp,	#100
    ldr	w1,	[sp, #108]

    movz	w22,	#1
    add	w18,	w0,	w1
    movk	w22,	#15232,	lsl #16
    sdiv	w1,	w18,	w22
    mul	w26,	w1,	w22
    str	w26,	[sp, #96]

    msub	w26,	w1,	w22,	w18

    mov	w1,	w23
    str	w26,	[x19]

    ldr	w18,	[sp, #108]

    sub	w0,	w18,	w0
    add	w26,	w0,	w22
    sdiv	w0,	w26,	w22
    msub	w26,	w0,	w22,	w26

    mul	w27,	w0,	w22
    ldr	x0,	[sp, fp]

    str	w26,	[x0]

    mov	w0,	w28
    bl	multiply
    add	w24,	w24,	#1
    mov	w28,	w0
    b	fft_50

fft_38:
    add	w11,	w9,	w25
    lsl	w6,	w9,	#2
    add	w9,	w9,	#1
    add	x5,	x18,	x6
    lsl	w13,	w11,	#2
    ldr	w0,	[x5]

    add	x12,	x20,	x13
    str	w0,	[x12]

    b	fft_35

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    adrp	x28, :got:a
    ldr	x28, [x28, #:got_lo12:a]
    mov	x0,	x28
    bl	getarray
    adrp	x24, :got:b
    mov	w20,	w0
    ldr	x24, [x24, #:got_lo12:b]
    mov	x0,	x24
    bl	getarray
    mov	w19,	w0
    movz	w0,	#60
    bl	_sysy_starttime
    add	w27,	w20,	w19
    sub	w23,	w27,	#1
    movz	w27,	#1

main_7:
    cmp	w27,	w23
    blt	main_10

main_12:
    movz	w25,	#0
    movz	w0,	#3
    movk	w25,	#15232,	lsl #16
    sdiv	w20,	w25,	w27
    mov	w1,	w20
    bl	power
    mov	w2,	w27
    movz	w1,	#0
    mov	w21,	w0
    mov	w3,	w21
    mov	x0,	x28
    bl	fft
    mov	w3,	w21
    mov	w2,	w27
    movz	w1,	#0
    mov	x0,	x24
    bl	fft
    movz	w19,	#0

main_17:
    cmp	w19,	w27
    blt	main_20

main_27:
    sub	w1,	w25,	w20
    movz	w0,	#3
    bl	power
    mov	w2,	w27
    movz	w1,	#0
    mov	w3,	w0
    mov	x0,	x28
    bl	fft
    movz	w1,	#65535
    mov	w0,	w27
    movk	w1,	#15231,	lsl #16
    bl	power
    movz	w25,	#0
    mov	w20,	w0

main_32:
    cmp	w25,	w27
    blt	main_35

main_40:
    movz	w0,	#79
    bl	_sysy_stoptime
    mov	x1,	x28
    mov	w0,	w23
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_35:
    lsl	w1,	w25,	#2
    adrp	x21, :got:a
    ldr	x21, [x21, #:got_lo12:a]
    add	x19,	x21,	x1
    mov	w1,	w20
    ldr	w0,	[x19]

    bl	multiply
    add	w25,	w25,	#1
    str	w0,	[x19]

    b	main_32

main_20:
    lsl	w18,	w19,	#2
    adrp	x1, :got:a
    adrp	x22, :got:b
    ldr	x1, [x1, #:got_lo12:a]
    add	x21,	x1,	x18
    lsl	w18,	w19,	#2
    ldr	w0,	[x21]

    ldr	x22, [x22, #:got_lo12:b]
    add	x1,	x22,	x18
    ldr	w1,	[x1]

    bl	multiply
    add	w19,	w19,	#1
    str	w0,	[x21]

    b	main_17

main_10:
    lsl	w27,	w27,	#1
    b	main_7

