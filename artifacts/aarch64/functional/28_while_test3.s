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

    movz	w1,	#1
    movz	w16,	#2
    movz	w3,	#6
    movz	w24,	#4
    movz	w5,	#10
    movz	w4,	#6
    movz	w6,	#5

main_2:
    add	w6,	w6,	#3
    cmp	w4,	#10
    bge	main_100

main_14:
    add	w4,	w4,	#1
    cmp	w5,	#20
    bge	main_90

main_25:
    add	w5,	w5,	#3
    cmp	w24,	#1
    ble	main_81

main_35:
    sub	w24,	w24,	#1
    cmp	w3,	#2
    ble	main_73

main_44:
    sub	w3,	w3,	#2
    cmp	w1,	#3
    bge	main_66

main_52:
    add	w1,	w1,	#10

main_56:
    cmp	w16,	#10
    bge	main_61

main_59:
    add	w16,	w16,	#8
    b	main_56

main_61:
    sub	w16,	w16,	#1
    cmp	w1,	#3
    blt	main_52

main_66:
    sub	w1,	w1,	#8
    cmp	w3,	#2
    bgt	main_44

main_73:
    add	w3,	w3,	#1
    cmp	w24,	#1
    bgt	main_35

main_81:
    add	w24,	w24,	#1
    cmp	w5,	#20
    blt	main_25

main_90:
    sub	w5,	w5,	#1
    cmp	w4,	#10
    blt	main_14

main_100:
    sub	w4,	w4,	#2
    cmp	w6,	#20
    blt	main_2

main_109:
    add	w6,	w4,	w5
    add	w14,	w5,	w24
    add	w7,	w6,	#20
    sub	w19,	w14,	w1
    add	w18,	w7,	#7
    add	w26,	w16,	w19
    sub	w0,	w18,	w26
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


