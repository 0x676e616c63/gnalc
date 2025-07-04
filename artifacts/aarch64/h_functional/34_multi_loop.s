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
    movz	w3,	#0

main_46:
    movz	w17,	#0

main_50:
    movz	w5,	#0

main_54:
    add	w1,	w0,	#3
    movz	w25,	#999
    movz	w23,	#999
    movz	w20,	#999
    movz	w19,	#999
    add	w5,	w5,	#1
    sdiv	w4,	w1,	w25
    msub	w7,	w4,	w23,	w1

    add	w6,	w7,	#3
    sdiv	w1,	w6,	w20
    msub	w0,	w1,	w19,	w6

    cmp	w5,	#3
    blt	main_54

main_63:
    add	w17,	w17,	#2
    cmp	w17,	#5
    blt	main_50

main_66:
    add	w3,	w3,	#2
    cmp	w3,	#7
    blt	main_46

main_69:
    add	w18,	w18,	#2
    cmp	w18,	#6
    blt	main_42

main_72:
    add	w13,	w13,	#1
    cmp	w13,	#3
    blt	main_38

main_75:
    add	w26,	w26,	#1
    cmp	w26,	#5
    blt	main_34

main_78:
    add	w16,	w16,	#1
    cmp	w16,	#5
    blt	main_30

main_81:
    add	w24,	w24,	#1
    cmp	w24,	#6
    blt	main_26

main_84:
    add	w12,	w12,	#1
    cmp	w12,	#4
    blt	main_22

main_87:
    add	w21,	w21,	#1
    cmp	w21,	#5
    blt	main_18

main_90:
    add	w15,	w15,	#1
    cmp	w15,	#3
    blt	main_14

main_93:
    add	w9,	w9,	#1
    cmp	w9,	#5
    blt	main_10

main_96:
    add	w22,	w22,	#1
    cmp	w22,	#4
    blt	main_6

main_99:
    add	w27,	w27,	#1
    cmp	w27,	#3
    blt	main_2

main_102:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


