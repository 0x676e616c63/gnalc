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
    
    movz	w0,	#0
    bl	putint
    movz	w0,	#2
    bl	putint
    movz	w0,	#4
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    bl	putint
    movz	w0,	#2
    bl	putint
    movz	w0,	#4
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    bl	putint
    movz	w0,	#2
    bl	putint
    movz	w0,	#4
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


