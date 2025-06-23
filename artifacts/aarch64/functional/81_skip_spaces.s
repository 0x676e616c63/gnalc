.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #416
    stp	fp, lr, [sp, #0]
    
    movz	w21,	#0

main_2:
    bl	getint
    cmp	w0,	#0
    beq	main_10

main_6:
    lsl	w27,	w21,	#2
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    bl	getint
    add	w21,	w21,	#1
    str	w0,	[x26]

    b	main_2

main_10:
    movz	w5,	#0

main_11:
    cmp	w21,	#0
    beq	main_20

main_15:
    sub	w21,	w21,	#1
    lsl	w4,	w21,	#2
    mov	x3,	x4
    add	x3,	sp,	x3
    add	x3,	x3,	#16
    ldr	w6,	[x3]

    add	w5,	w6,	w5
    b	main_11

main_20:
    movz	w28,	#79
    movz	w27,	#79
    sdiv	w11,	w5,	w28
    msub	w0,	w11,	w27,	w5

    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #416
    ret


