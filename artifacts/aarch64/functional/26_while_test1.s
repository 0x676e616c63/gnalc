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

    movz	w0,	#7
    movz	w26,	#5

main_2:
    add	w26,	w26,	#30

main_6:
    cmp	w0,	#100
    blt	main_9

main_11:
    sub	w0,	w0,	#100
    cmp	w26,	#100
    blt	main_2

main_14:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


main_9:
    add	w0,	w0,	#6
    b	main_6

