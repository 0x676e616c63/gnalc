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
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w22,	w0
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    sdiv	w18,	w21,	w25
    msub	w13,	w25,	w22,	w21

    sub	w19,	w20,	w18
    cmp	w13,	w19
    beq	main_11

main_21:
    movz	w0,	#1
    b	main_23

main_11:
    mul	w24,	w22,	w21
    add	w20,	w0,	w20
    sdiv	w26,	w24,	w25
    cmp	w26,	w20
    bne	main_16

main_22:
    movz	w0,	#1
    b	main_23

main_16:
    add	w12,	w22,	w21
    add	w22,	w12,	w25
    cmp	w22,	w20
    cset	w0,	eq

main_23:
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


