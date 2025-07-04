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

    movz	w0,	#4

main_1:
    cmp	w0,	#75
    blt	main_4

main_8:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


main_4:
    add	w28,	w0,	#42
    cmp	w28,	#99
    movz	w11,	#168
    csel	w0,	w11,	w28,	gt
    b	main_1

