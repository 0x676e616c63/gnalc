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

    movz	w25,	#10
    movz	w0,	#6
    movz	w6,	#5

main_2:
    add	w6,	w6,	#3
    cmp	w0,	#10
    bge	main_24

main_10:
    add	w0,	w0,	#1

main_14:
    cmp	w25,	#20
    blt	main_17

main_19:
    sub	w25,	w25,	#1
    cmp	w0,	#10
    blt	main_10
    b	main_24

main_17:
    add	w25,	w25,	#3
    b	main_14

main_24:
    sub	w0,	w0,	#2
    cmp	w6,	#20
    blt	main_2

main_29:
    add	w14,	w0,	#27
    add	w0,	w14,	w25
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


