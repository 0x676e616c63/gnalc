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
    sub	sp, sp, #416
    stp	fp, lr, [sp, #0]
    
    movz	w21,	#0

main_2:
    bl	getint
    cmp	w0,	#0
    bne	main_6

main_10:
    movz	w28,	#0

main_11:
    cmp	w21,	#0
    bne	main_15

main_20:
    movz	w19,	#79
    movz	w18,	#79
    sdiv	w8,	w28,	w19
    msub	w0,	w8,	w18,	w28

    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #416
    ret


main_15:
    sub	w21,	w21,	#1
    lsl	w1,	w21,	#2
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w2,	[x0]

    add	w28,	w2,	w28
    b	main_11

main_6:
    lsl	w24,	w21,	#2
    mov	x24,	x24
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    bl	getint
    add	w21,	w21,	#1
    str	w0,	[x24]

    b	main_2

