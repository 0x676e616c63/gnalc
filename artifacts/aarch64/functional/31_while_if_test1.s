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

    movz	w2,	#0
    movz	w25,	#0

main_1:
    cmp	w25,	#64
    bge	main_24

main_5:
    add	w27,	w25,	#8
    add	w5,	w2,	#16
    add	w6,	w27,	#8
    add	w7,	w5,	#16
    add	w8,	w6,	#8
    add	w9,	w7,	#16
    add	w10,	w8,	#8
    add	w11,	w9,	#16
    add	w12,	w10,	#8
    add	w13,	w11,	#16
    add	w14,	w12,	#8
    add	w15,	w13,	#16
    add	w16,	w14,	#8
    add	w17,	w15,	#16
    add	w25,	w16,	#8
    add	w2,	w17,	#16
    b	main_1

main_24:
    add	w25,	w25,	#8
    add	w2,	w2,	#16
    cmp	w25,	#96
    blt	main_24

main_32:
    cmp	w25,	#10
    movz	w27,	#42
    csel	w5,	w27,	w2,	eq
    cmp	w25,	#5
    add	w2,	w2,	#2
    add	w25,	w25,	#1
    movz	w26,	#25
    csel	w0,	w26,	w5,	eq
    cmp	w25,	#100
    blt	main_32

main_42:
    ldr	lr, [sp, 0]

    add	sp, sp, #16
    ret


