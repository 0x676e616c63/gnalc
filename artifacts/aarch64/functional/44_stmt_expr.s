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
    
    movz	w0,	#1024
    bl	putint
    movz	w0,	#1024
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


