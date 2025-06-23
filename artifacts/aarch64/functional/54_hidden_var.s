.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global c
.align	2
c:
    .word	6
    .word	7
    .word	8
    .word	9


.text

.globl main
main:
main_0:
    sub	sp, sp, #32
    stp	fp, lr, [sp, #0]
    
    adrp	x1, :got:c
    movz	w2,	#16
    add	x0,	sp,	#16
    ldr	x1, [x1, #:got_lo12:c]
    bl	memcpy
    movz	w0,	#3
    bl	putint
    movz	w0,	#3
    bl	putint
    movz	w0,	#1
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#1
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#2
    bl	putint
    movz	w0,	#1
    bl	putint
    movz	w0,	#8
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#5
    bl	putint
    movz	w0,	#10
    bl	putch
    add	x28,	sp,	#16
    ldr	w0,	[x28]

    bl	putint
    add	x18,	sp,	#20
    ldr	w0,	[x18]

    bl	putint
    movz	w0,	#1
    bl	putint
    add	x20,	sp,	#28
    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #32
    ret


