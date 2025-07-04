.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl hanoi
.align 2
.p2align 4,,11
.type hanoi, %function
hanoi:
hanoi_4:
    sub	sp, sp, #48
    stp	x20, x24, [sp, #0]
    stp	x25, x28, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    mov	w24,	w3
    mov	w28,	w2
    mov	w20,	w1
    cmp	w0,	#1
    bne	hanoi_7

hanoi_6:
    mov	w0,	w20
    bl	putint
    movz	w0,	#32
    bl	putch
    mov	w0,	w24
    bl	putint
    movz	w0,	#44
    bl	putch
    movz	w0,	#32
    bl	putch
    b	hanoi_9

hanoi_7:
    sub	w25,	w0,	#1
    mov	w1,	w20
    mov	w2,	w24
    mov	w3,	w28
    mov	w0,	w25
    bl	hanoi
    mov	w0,	w20
    bl	putint
    movz	w0,	#32
    bl	putch
    mov	w0,	w24
    bl	putint
    movz	w0,	#44
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w3,	w24
    mov	w2,	w20
    mov	w1,	w28
    mov	w0,	w25
    bl	hanoi

hanoi_9:
    ldp	x20, x24, [sp, #0]
    ldp	x25, x28, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w26,	w0

main_2:
    cmp	w26,	#0
    bgt	main_5

main_8:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_5:
    bl	getint
    movz	w3,	#3
    movz	w2,	#2
    movz	w1,	#1
    bl	hanoi
    movz	w0,	#10
    bl	putch
    sub	w26,	w26,	#1
    b	main_2

