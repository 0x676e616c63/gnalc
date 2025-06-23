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
    bl	getint
    cmp	w20,	#3
    cset	w23,	ne
    cmp	w20,	w0
    movz	w3,	#0
    csel	w0,	w23,	w3,	eq
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


