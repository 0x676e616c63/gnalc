.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl reverse
.align 2
.p2align 4,,11
.type reverse, %function
reverse:
reverse_1:
    sub	sp, sp, #48
    stp	x19, x22, [sp, #0]
    stp	x24, x25, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    mov	w19,	w0
    cmp	w19,	#1
    ble	reverse_3

reverse_5:
    bl	getint
    sub	w24,	w19,	#1
    mov	w22,	w0
    cmp	w24,	#1
    ble	reverse_9

reverse_11:
    bl	getint
    mov	w25,	w0
    sub	w0,	w24,	#1
    bl	reverse
    mov	w0,	w25
    bl	putint
    b	reverse_14

reverse_9:
    bl	getint
    bl	putint

reverse_14:
    mov	w0,	w22
    bl	putint
    b	reverse_15

reverse_3:
    bl	getint
    bl	putint

reverse_15:
    ldp	x19, x22, [sp, #0]
    ldp	x24, x25, [sp, #16]
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
    
    movz	w0,	#200
    bl	reverse
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


