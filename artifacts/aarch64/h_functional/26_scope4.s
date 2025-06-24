.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#1352
    movz	w7,	#49
    movz	w21,	#0
    movz	w2,	#2

main_2:
    add	w22,	w7,	#1
    add	w1,	w2,	#2
    lsl	w10,	w22,	#0
    add	w3,	w22,	#1
    add	w4,	w10,	w22,	lsl #1
    add	w20,	w3,	#2
    add	w22,	w20,	#1
    lsl	w28,	w22,	#1
    add	w7,	w22,	#1
    add	w22,	w1,	w20
    add	w23,	w22,	w28
    add	w24,	w23,	w3
    add	w25,	w24,	w4
    add	w19,	w25,	w0
    cmp	w21,	#1
    beq	main_21

main_36:
    add	w27,	w7,	#1
    add	w21,	w21,	#1
    lsl	w28,	w27,	#0
    add	w25,	w27,	#1
    add	w9,	w28,	w27,	lsl #1
    add	w2,	w25,	#2
    add	w26,	w1,	w2
    add	w3,	w2,	#1
    add	w7,	w3,	#2
    lsl	w18,	w3,	#1
    mov	w2,	w7
    add	w27,	w26,	w18
    add	w28,	w27,	w25
    add	w0,	w28,	w9
    add	w0,	w0,	w19
    b	main_50

main_21:
    add	w14,	w7,	#1
    movz	w21,	#2
    add	w15,	w14,	#1
    lsl	w0,	w15,	#0
    add	w16,	w15,	#1
    add	w28,	w0,	w15,	lsl #1
    add	w24,	w16,	#2
    add	w9,	w24,	#2
    add	w5,	w24,	#1
    lsl	w22,	w5,	#1
    add	w7,	w5,	#1
    add	w10,	w9,	w22
    add	w11,	w10,	w14
    add	w12,	w11,	w16
    add	w13,	w12,	w28
    add	w0,	w13,	w19

main_50:
    cmp	w21,	#3
    blt	main_2

main_56:
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


