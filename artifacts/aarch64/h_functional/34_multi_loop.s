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
    movz	w10,	#0

main_6:
    movz	w5,	#0

main_10:
    movz	w26,	#0

main_14:
    movz	w2,	#0

main_18:
    movz	w18,	#0

main_22:
    movz	w14,	#0

main_26:
    movz	w27,	#0

main_30:
    movz	w21,	#0

main_34:
    movz	w7,	#0

main_38:
    movz	w4,	#0

main_42:
    movz	w1,	#0

main_46:
    movz	w17,	#0

main_50:
    movz	w25,	#0

main_54:
    add	w3,	w0,	#3
    movz	w24,	#999
    movz	w23,	#999
    movz	w22,	#999
    movz	w20,	#999
    add	w25,	w25,	#1
    sdiv	w8,	w3,	w24
    msub	w11,	w8,	w23,	w3

    add	w9,	w11,	#3
    sdiv	w3,	w9,	w22
    msub	w0,	w3,	w20,	w9

    cmp	w25,	#3
    blt	main_54

main_63:
    add	w17,	w17,	#2
    cmp	w17,	#5
    blt	main_50

main_66:
    add	w1,	w1,	#2
    cmp	w1,	#7
    blt	main_46

main_69:
    add	w4,	w4,	#2
    cmp	w4,	#6
    blt	main_42

main_72:
    add	w7,	w7,	#1
    cmp	w7,	#3
    blt	main_38

main_75:
    add	w21,	w21,	#1
    cmp	w21,	#5
    blt	main_34

main_78:
    add	w27,	w27,	#1
    cmp	w27,	#5
    blt	main_30

main_81:
    add	w14,	w14,	#1
    cmp	w14,	#6
    blt	main_26

main_84:
    add	w18,	w18,	#1
    cmp	w18,	#4
    blt	main_22

main_87:
    add	w2,	w2,	#1
    cmp	w2,	#5
    blt	main_18

main_90:
    add	w26,	w26,	#1
    cmp	w26,	#3
    blt	main_14

main_93:
    add	w5,	w5,	#1
    cmp	w5,	#5
    blt	main_10

main_96:
    add	w10,	w10,	#1
    cmp	w10,	#4
    blt	main_6

main_99:
    add	w15,	w15,	#1
    cmp	w15,	#3
    blt	main_2

main_102:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


