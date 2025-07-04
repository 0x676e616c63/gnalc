.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global matrix
.align	2
matrix:
.type matrix, %object
    .zero	80000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#6800
    movk	fp,	#6,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#6784
    add	x0,	sp,	#16
    movk	w2,	#6,	lsl #16
    bl	memset
    bl	getint
    mov	w23,	w0
    add	x0,	sp,	#16
    bl	getarray
    mov	w21,	w0
    movz	w0,	#28
    bl	_sysy_starttime
    movz	w6,	#0

main_5:
    cmp	w6,	w23
    blt	main_8

main_11:
    movz	w24,	#0
    cmp	w24,	w21
    blt	main_13

main_57:
    movz	w12,	#0
    movz	w4,	#0
    b	main_59

main_13:
    adrp	x14, :got:matrix
    movz	w7,	#0
    ldr	x14, [x14, #:got_lo12:matrix]

main_16:
    lsl	w27,	w7,	#2
    movz	w11,	#0
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w20,	[x26]

    sdiv	w2,	w23,	w20
    cmp	w11,	w2
    bge	main_54

main_22:
    movz	w22,	#0
    movz	w6,	#0

main_24:
    movz	w27,	#0
    cmp	w27,	w20
    bge	main_48

main_28:
    movz	w15,	#0

main_30:
    cmp	w22,	w15
    blt	main_33

main_38:
    add	w8,	w15,	w6
    madd	w13,	w15,	w2,	w22

    add	w15,	w15,	#1
    lsl	w17,	w13,	#2
    lsl	w10,	w8,	#2
    add	x16,	x14,	x17
    add	x9,	x14,	x10
    ldr	w27,	[x9]

    str	w27,	[x16]

    b	main_35

main_33:
    add	w15,	w15,	#1

main_35:
    cmp	w15,	w20
    blt	main_30

main_48:
    add	w22,	w22,	#1
    add	w6,	w6,	w20
    cmp	w22,	w2
    blt	main_24

main_54:
    add	w7,	w7,	#1
    cmp	w7,	w21
    blt	main_16

main_58:
    movz	w12,	#0
    movz	w4,	#0

main_59:
    cmp	w12,	w21
    blt	main_63

main_70:
    movz	w21,	#0
    sub	w18,	w21,	w4
    cmp	w4,	#0
    movz	w0,	#47
    csel	w22,	w18,	w4,	lt
    bl	_sysy_stoptime
    mov	w0,	w22
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#6800
    movk	fp,	#6,	lsl #16
    add	sp, sp, fp
    ret


main_63:
    mul	w6,	w12,	w12
    lsl	w1,	w12,	#2
    adrp	x26, :got:matrix
    add	w12,	w12,	#1
    ldr	x26, [x26, #:got_lo12:matrix]
    add	x24,	x26,	x1
    ldr	w27,	[x24]

    madd	w4,	w6,	w27,	w4

    b	main_59

main_8:
    lsl	w10,	w6,	#2
    adrp	x4, :got:matrix
    ldr	x4, [x4, #:got_lo12:matrix]
    add	x2,	x4,	x10
    str	w6,	[x2]

    add	w6,	w6,	#1
    b	main_5

