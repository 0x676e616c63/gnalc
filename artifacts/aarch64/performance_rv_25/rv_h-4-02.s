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
    
    bl	getint
    mov	w20,	w0
    movz	w0,	#33
    bl	_sysy_starttime
    cmp	w20,	#0
    beq	main_37

main_5:
    bl	getint
    mov	w23,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    movz	w18,	#0

main_10:
    cmp	w23,	w26
    blt	main_14

main_32:
    mov	w0,	w18
    bl	putint
    movz	w0,	#10
    bl	putch
    sub	w20,	w20,	#1
    cmp	w20,	#0
    bne	main_5
    b	main_37

main_14:
    movz	w9,	#65535
    movk	w9,	#32767,	lsl #16
    sub	w24,	w9,	w23
    cmp	w23,	w24
    movz	w8,	#65535
    csel	w22,	w23,	w24,	lt
    movk	w8,	#16383,	lsl #16
    sub	w28,	w8,	w22
    cmp	w22,	w28
    movz	w7,	#0
    csel	w28,	w22,	w28,	lt
    movk	w7,	#8192,	lsl #16
    sub	w3,	w7,	w28
    cmp	w28,	w3
    csel	w13,	w28,	w3,	lt
    add	w23,	w23,	w0
    movz	w16,	#1001
    movz	w5,	#1000
    movz	w1,	#26809
    movz	w27,	#501
    lsl	w8,	w13,	#0
    movk	w1,	#297,	lsl #16
    movk	w27,	#15232,	lsl #16
    add	w24,	w8,	w13,	lsl #1
    sdiv	w25,	w24,	w5
    madd	w8,	w25,	w16,	w13

    sdiv	w10,	w8,	w1
    msub	w10,	w10,	w1,	w8

    add	w2,	w10,	w18
    sdiv	w16,	w2,	w27
    msub	w18,	w16,	w27,	w2

    b	main_10

main_37:
    movz	w0,	#42
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


