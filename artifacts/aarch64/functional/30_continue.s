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

    movz	w0,	#0
    movz	w26,	#0

main_1:
    cmp	w26,	#100
    blt	main_5

main_11:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


main_5:
    add	w12,	w0,	w26
    add	w9,	w26,	#1
    cmp	w26,	#50
    csel	w0,	w0,	w12,	eq
    movz	w6,	#51
    csel	w26,	w6,	w9,	eq
    b	main_1

