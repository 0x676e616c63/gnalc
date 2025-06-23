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
    
    movz	w0,	#4

main_1:
    cmp	w0,	#75
    bge	main_8

main_4:
    add	w28,	w0,	#42
    cmp	w28,	#99
    movz	w11,	#168
    csel	w0,	w11,	w28,	gt
    b	main_1

main_8:
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


