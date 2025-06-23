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
    mov	w25,	w0
    movz	w0,	#22
    bl	_sysy_starttime
    movz	w22,	#1
    cmp	w22,	w25
    ble	main_3

main_37:
    movz	w27,	#0
    b	main_39

main_3:
    movz	w27,	#0
    movz	w26,	#1

main_5:
    mov	w8,	w26
    movz	w24,	#0

main_8:
    cmp	w8,	#1
    beq	main_31

main_12:
    asr	w2,	w8,	#31
    lsr	w3,	w2,	#31
    add	w4,	w8,	w3
    asr	w13,	w4,	#1
    lsl	w14,	w13,	#1
    sub	w21,	w8,	w14
    cmp	w21,	#0
    bne	main_18

main_15:
    asr	w5,	w8,	#31
    add	w24,	w24,	#1
    lsr	w6,	w5,	#31
    add	w2,	w8,	w6
    asr	w8,	w2,	#1
    b	main_8

main_18:
    lsl	w9,	w8,	#0
    add	w0,	w9,	w8,	lsl #1
    add	w1,	w0,	#1
    cmp	w1,	w25
    bgt	main_30

main_22:
    lsl	w10,	w8,	#0
    add	w24,	w24,	#1
    add	w28,	w10,	w8,	lsl #1
    add	w8,	w28,	#1
    b	main_8

main_30:
    movz	w24,	#0

main_31:
    add	w2,	w24,	w27
    movz	w8,	#51719
    add	w26,	w26,	#1
    movk	w8,	#15258,	lsl #16
    sdiv	w10,	w2,	w8
    msub	w27,	w10,	w8,	w2

    cmp	w26,	w25
    ble	main_5

main_39:
    movz	w0,	#27
    bl	_sysy_stoptime
    mov	w0,	w27
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


