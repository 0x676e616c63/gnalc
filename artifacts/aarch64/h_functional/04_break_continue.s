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

    movz	w6,	#0
    movz	w0,	#0

main_2:
    movz	w23,	#0

main_6:
    movz	w3,	#0

main_10:
    movz	w20,	#0

main_13:
    cmp	w20,	#3
    bge	main_32

main_17:
    add	w18,	w20,	#1
    cmp	w18,	#3
    blt	main_28

main_20:
    cmp	w20,	#0
    beq	main_28

main_22:
    movz	w26,	#65535
    movk	w26,	#65535,	lsl #16
    sub	w26,	w20,	w26
    cmp	w26,	#3
    bge	main_32

main_28:
    add	w0,	w0,	#1
    mov	w20,	w18
    b	main_13

main_32:
    add	w3,	w3,	#1
    cmp	w3,	#5
    blt	main_10

main_35:
    add	w23,	w23,	#1
    cmp	w23,	#10
    blt	main_6

main_38:
    add	w6,	w6,	#1
    cmp	w6,	#20
    blt	main_2

main_41:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


