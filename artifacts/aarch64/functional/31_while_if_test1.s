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

    movz	w22,	#0
    movz	w1,	#0

main_1:
    cmp	w1,	#64
    blt	main_5

main_24:
    add	w1,	w1,	#8
    add	w22,	w22,	#16
    cmp	w1,	#96
    blt	main_24

main_32:
    cmp	w1,	#10
    movz	w27,	#42
    csel	w15,	w27,	w22,	eq
    cmp	w1,	#5
    add	w22,	w22,	#2
    add	w1,	w1,	#1
    movz	w26,	#25
    csel	w0,	w26,	w15,	eq
    cmp	w1,	#100
    blt	main_32

main_42:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


main_5:
    add	w8,	w1,	#8
    add	w15,	w22,	#16
    add	w16,	w8,	#8
    add	w17,	w15,	#16
    add	w18,	w16,	#8
    add	w19,	w17,	#16
    add	w20,	w18,	#8
    add	w21,	w19,	#16
    add	w22,	w20,	#8
    add	w23,	w21,	#16
    add	w24,	w22,	#8
    add	w25,	w23,	#16
    add	w26,	w24,	#8
    add	w28,	w25,	#16
    add	w1,	w26,	#8
    add	w22,	w28,	#16
    b	main_1

