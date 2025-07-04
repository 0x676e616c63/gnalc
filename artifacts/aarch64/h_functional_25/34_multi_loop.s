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
    str	lr, [sp, 0]

    movz	w27,	#0
    movz	w0,	#0

main_2:
    movz	w22,	#0

main_6:
    movz	w9,	#0

main_10:
    movz	w15,	#0

main_14:
    movz	w21,	#0

main_18:
    movz	w12,	#0

main_22:
    movz	w24,	#0

main_26:
    movz	w16,	#0

main_30:
    movz	w26,	#0

main_34:
    movz	w13,	#0

main_38:
    movz	w18,	#0

main_42:
    add	w25,	w0,	#3
    movz	w11,	#999
    movz	w10,	#999
    movz	w8,	#999
    movz	w7,	#999
    add	w18,	w18,	#1
    sdiv	w19,	w25,	w11
    msub	w20,	w19,	w10,	w25

    add	w0,	w20,	#3
    sdiv	w14,	w0,	w8
    msub	w0,	w14,	w7,	w0

    cmp	w18,	#3
    blt	main_42

main_51:
    add	w13,	w13,	#2
    cmp	w13,	#5
    blt	main_38

main_54:
    add	w26,	w26,	#2
    cmp	w26,	#5
    blt	main_34

main_57:
    add	w16,	w16,	#1
    cmp	w16,	#3
    blt	main_30

main_60:
    add	w24,	w24,	#1
    cmp	w24,	#5
    blt	main_26

main_63:
    add	w12,	w12,	#1
    cmp	w12,	#5
    blt	main_22

main_66:
    add	w21,	w21,	#1
    cmp	w21,	#6
    blt	main_18

main_69:
    add	w15,	w15,	#1
    cmp	w15,	#4
    blt	main_14

main_72:
    add	w9,	w9,	#1
    cmp	w9,	#5
    blt	main_10

main_75:
    add	w22,	w22,	#1
    cmp	w22,	#3
    blt	main_6

main_78:
    add	w27,	w27,	#1
    cmp	w27,	#2
    blt	main_2

main_81:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


