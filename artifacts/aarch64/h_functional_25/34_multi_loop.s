.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    str	lr, [sp, 0]

    movz	w15,	#0
    movz	w0,	#0

main_2:
    movz	w20,	#0

main_6:
    movz	w8,	#0

main_10:
    movz	w5,	#0

main_14:
    movz	w17,	#0

main_18:
    movz	w12,	#0

main_22:
    movz	w27,	#0

main_26:
    movz	w25,	#0

main_30:
    movz	w23,	#0

main_34:
    movz	w11,	#0

main_38:
    movz	w19,	#0

main_42:
    add	w26,	w0,	#3
    movz	w14,	#999
    movz	w13,	#999
    movz	w10,	#999
    movz	w9,	#999
    add	w19,	w19,	#1
    sdiv	w21,	w26,	w14
    msub	w22,	w21,	w13,	w26

    add	w0,	w22,	#3
    sdiv	w16,	w0,	w10
    msub	w0,	w16,	w9,	w0

    cmp	w19,	#3
    blt	main_42

main_51:
    add	w11,	w11,	#2
    cmp	w11,	#5
    blt	main_38

main_54:
    add	w23,	w23,	#2
    cmp	w23,	#5
    blt	main_34

main_57:
    add	w25,	w25,	#1
    cmp	w25,	#3
    blt	main_30

main_60:
    add	w27,	w27,	#1
    cmp	w27,	#5
    blt	main_26

main_63:
    add	w12,	w12,	#1
    cmp	w12,	#5
    blt	main_22

main_66:
    add	w17,	w17,	#1
    cmp	w17,	#6
    blt	main_18

main_69:
    add	w5,	w5,	#1
    cmp	w5,	#4
    blt	main_14

main_72:
    add	w8,	w8,	#1
    cmp	w8,	#5
    blt	main_10

main_75:
    add	w20,	w20,	#1
    cmp	w20,	#3
    blt	main_6

main_78:
    add	w15,	w15,	#1
    cmp	w15,	#2
    blt	main_2

main_81:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


