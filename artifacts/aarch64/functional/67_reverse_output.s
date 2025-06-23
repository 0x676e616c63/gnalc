.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl reverse
reverse:
reverse_1:
    sub	sp, sp, #48
    stp	x19, x23, [sp, #0]
    stp	x25, x27, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    mov	w19,	w0
    cmp	w19,	#1
    bgt	reverse_5

reverse_3:
    bl	getint
    bl	putint
    b	reverse_15

reverse_5:
    bl	getint
    sub	w25,	w19,	#1
    mov	w23,	w0
    cmp	w25,	#1
    bgt	reverse_11

reverse_9:
    bl	getint
    bl	putint
    b	reverse_14

reverse_11:
    bl	getint
    mov	w27,	w0
    sub	w0,	w25,	#1
    bl	reverse
    mov	w0,	w27
    bl	putint

reverse_14:
    mov	w0,	w23
    bl	putint

reverse_15:
    ldp	x19, x23, [sp, #0]
    ldp	x25, x27, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#200
    bl	reverse
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


