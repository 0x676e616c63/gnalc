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
    mov	w26,	w0
    movz	w0,	#22
    bl	_sysy_starttime
    movz	w22,	#1
    cmp	w22,	w26
    bgt	main_37

main_3:
    movz	w20,	#0
    movz	w7,	#1

main_5:
    mov	w28,	w7
    movz	w23,	#0

main_8:
    cmp	w28,	#1
    beq	main_31

main_12:
    asr	w2,	w28,	#31
    lsr	w3,	w2,	#31
    add	w4,	w28,	w3
    asr	w13,	w4,	#1
    lsl	w14,	w13,	#1
    sub	w22,	w28,	w14
    cmp	w22,	#0
    beq	main_15

main_21:
    lsl	w5,	w28,	#0
    add	w25,	w5,	w28,	lsl #1
    add	w27,	w25,	#1
    cmp	w27,	w26
    ble	main_25

main_30:
    movz	w23,	#0

main_31:
    add	w25,	w23,	w20
    movz	w3,	#51719
    add	w7,	w7,	#1
    movk	w3,	#15258,	lsl #16
    sdiv	w9,	w25,	w3
    msub	w20,	w9,	w3,	w25

    cmp	w7,	w26
    ble	main_5
    b	main_39

main_25:
    lsl	w6,	w28,	#0
    add	w23,	w23,	#1
    add	w1,	w6,	w28,	lsl #1
    add	w28,	w1,	#1
    b	main_8

main_15:
    asr	w8,	w28,	#31
    add	w23,	w23,	#1
    lsr	w9,	w8,	#31
    add	w4,	w28,	w9
    asr	w28,	w4,	#1
    b	main_8

main_37:
    movz	w20,	#0

main_39:
    movz	w0,	#27
    bl	_sysy_stoptime
    mov	w0,	w20
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


