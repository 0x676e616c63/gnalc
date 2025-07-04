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

    movz	w0,	#0
    movz	w26,	#0

main_1:
    cmp	w26,	#100
    bge	main_12

main_5:
    cmp	w26,	#50
    bne	main_7

main_12:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


main_7:
    add	w0,	w0,	w26
    add	w26,	w26,	#1
    b	main_1

