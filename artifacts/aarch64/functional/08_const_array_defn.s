.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global a
.align	2
a:
    .word	0
    .word	1
    .word	2
    .word	3
    .word	4


.text

.globl main
main:
main_0:
    sub	sp, sp, #48
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#20
    adrp	x1, :got:a
    add	x0,	sp,	#16
    ldr	x1, [x1, #:got_lo12:a]
    bl	memcpy
    add	x8,	sp,	#32
    ldr	w0,	[x8]

    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #48
    ret


