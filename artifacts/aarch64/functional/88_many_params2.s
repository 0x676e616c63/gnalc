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
    movz	w0,	#1
    bl	putint
    movz	w0,	#2
    bl	putint
    movz	w0,	#3
    bl	putint
    movz	w0,	#0
    bl	putint
    movz	w0,	#0
    bl	putint
    movz	w0,	#0
    bl	putint
    movz	w0,	#0
    bl	putint
    movz	w0,	#0
    bl	putint
    movz	w0,	#9
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#9
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#805
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#3612
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#2695
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#1778
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#861
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#3668
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#2751
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#1834
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#917
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#0
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


