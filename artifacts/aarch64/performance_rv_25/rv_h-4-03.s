.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
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
    mov	w27,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    movz	w21,	#0

main_10:
    cmp	w27,	w28
    bge	main_32

main_14:
    movz	w16,	#65535
    movk	w16,	#32767,	lsl #16
    sub	w19,	w16,	w27
    cmp	w27,	w19
    movz	w15,	#65535
    csel	w18,	w27,	w19,	lt
    movk	w15,	#16383,	lsl #16
    sub	w24,	w15,	w18
    cmp	w18,	w24
    movz	w14,	#0
    csel	w24,	w18,	w24,	lt
    movk	w14,	#8192,	lsl #16
    sub	w1,	w14,	w24
    cmp	w24,	w1
    add	w27,	w27,	w0
    csel	w25,	w24,	w1,	lt
    movz	w6,	#26809
    movz	w12,	#1000
    lsl	w8,	w25,	#0
    movk	w6,	#297,	lsl #16
    add	w19,	w8,	w25,	lsl #1
    sdiv	w22,	w19,	w12
    movz	w19,	#1001
    madd	w5,	w22,	w19,	w25

    movz	w25,	#501
    sdiv	w9,	w5,	w6
    movk	w25,	#15232,	lsl #16
    msub	w8,	w9,	w6,	w5

    add	w26,	w8,	w21
    sdiv	w15,	w26,	w25
    msub	w21,	w15,	w25,	w26

    b	main_10

main_32:
    mov	w0,	w21
    bl	putint
    movz	w0,	#10
    bl	putch
    sub	w20,	w20,	#1
    cmp	w20,	#0
    bne	main_5

main_37:
    movz	w0,	#42
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


