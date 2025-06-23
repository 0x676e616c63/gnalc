.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl hanoi
hanoi:
hanoi_4:
    sub	sp, sp, #48
    stp	x21, x23, [sp, #0]
    stp	x27, x28, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    mov	w23,	w3
    mov	w28,	w2
    mov	w21,	w1
    cmp	w0,	#1
    beq	hanoi_6

hanoi_7:
    sub	w27,	w0,	#1
    mov	w1,	w21
    mov	w2,	w23
    mov	w3,	w28
    mov	w0,	w27
    bl	hanoi
    mov	w0,	w21
    bl	putint
    movz	w0,	#32
    bl	putch
    mov	w0,	w23
    bl	putint
    movz	w0,	#44
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w3,	w23
    mov	w2,	w21
    mov	w1,	w28
    mov	w0,	w27
    bl	hanoi
    b	hanoi_9

hanoi_6:
    mov	w0,	w21
    bl	putint
    movz	w0,	#32
    bl	putch
    mov	w0,	w23
    bl	putint
    movz	w0,	#44
    bl	putch
    movz	w0,	#32
    bl	putch

hanoi_9:
    ldp	x21, x23, [sp, #0]
    ldp	x27, x28, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w26,	w0

main_2:
    cmp	w26,	#0
    ble	main_8

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

main_8:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


