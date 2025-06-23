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

    movz	w0,	#10373
    movk	w0,	#1,	lsl #16
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


