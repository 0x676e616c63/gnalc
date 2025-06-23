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
    
    movz	w0,	#1
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#4
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#2
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#5
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#8
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#4
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#9
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#12
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#8
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#13
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#16
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#16
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#24
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#16
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#29
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#16
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#29
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


