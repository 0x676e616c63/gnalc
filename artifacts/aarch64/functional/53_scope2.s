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
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#112

main_1:
    cmp	w0,	#10
    bgt	main_4

main_10:
    bl	putint
    movz	w0,	#3390
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_4:
    sub	w22,	w0,	#88
    sub	w9,	w22,	#10
    add	w10,	w9,	#22
    cmp	w22,	#1000
    csel	w0,	w10,	w22,	lt
    b	main_1

