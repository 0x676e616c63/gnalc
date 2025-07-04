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
    movz	w19,	#0

main_13:
    cmp	w19,	#3
    bge	main_32

main_17:
    add	w17,	w19,	#1
    cmp	w17,	#3
    blt	main_28

main_20:
    cmp	w19,	#0
    beq	main_28

main_22:
    movz	w25,	#65535
    movk	w25,	#65535,	lsl #16
    sub	w25,	w19,	w25
    cmp	w25,	#3
    bge	main_32

main_28:
    add	w0,	w0,	#1
    mov	w19,	w17
    b	main_13

main_32:
    add	w9,	w9,	#1
    cmp	w9,	#5
    blt	main_10

main_35:
    add	w22,	w22,	#1
    cmp	w22,	#10
    blt	main_6

main_38:
    add	w27,	w27,	#1
    cmp	w27,	#20
    blt	main_2

main_41:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


