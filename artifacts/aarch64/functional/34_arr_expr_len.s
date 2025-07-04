.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data
.global arr
.align	2
arr:
.type arr, %object
    .word	1
    .word	2
    .word	33
    .word	4
    .word	5
    .word	6


.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #48
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#24
    adrp	x1, :got:arr
    add	x0,	sp,	#16
    ldr	x1, [x1, #:got_lo12:arr]
    bl	memcpy
    add	x22,	sp,	#36
    add	x8,	sp,	#16
    add	x10,	sp,	#20
    add	x16,	sp,	#28
    add	x19,	sp,	#32
    add	x13,	sp,	#24
    ldr	w23,	[x8]

    ldr	w11,	[x10]

    ldr	w14,	[x13]

    add	w26,	w11,	w23
    ldr	w17,	[x16]

    ldr	w20,	[x19]

    add	w0,	w14,	w26
    ldr	w23,	[x22]

    add	w3,	w17,	w0
    add	w6,	w20,	w3
    add	w0,	w23,	w6
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #48
    ret


