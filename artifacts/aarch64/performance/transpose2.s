.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global matrix
.align	2
matrix:
    .zero	80000000


.text

.globl main
main:
main_0:
    movz	fp,	#6800
    movk	fp,	#6,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#6784
    movz	w1,	#0
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
    movz	w18,	#0

main_5:
    cmp	w18,	w23
    bge	main_11

main_8:
    lsl	w24,	w18,	#2
    adrp	x19, :got:matrix
    ldr	x19, [x19, #:got_lo12:matrix]
    add	x16,	x19,	x24
    str	w18,	[x16]

    add	w18,	w18,	#1
    b	main_5

main_11:
    movz	w25,	#0
    cmp	w25,	w21
    bge	main_57

main_13:
    adrp	x1, :got:matrix
    movz	w7,	#0
    ldr	x1, [x1, #:got_lo12:matrix]

main_16:
    lsl	w3,	w7,	#2
    movz	w12,	#0
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#16
    ldr	w27,	[x2]

    sdiv	w10,	w23,	w27
    cmp	w12,	w10
    bge	main_54

main_22:
    movz	w22,	#0
    movz	w6,	#0

main_24:
    movz	w28,	#0
    cmp	w28,	w27
    bge	main_48

main_28:
    movz	w12,	#0

main_30:
    cmp	w22,	w12
    bge	main_35

main_33:
    add	w12,	w12,	#1
    b	main_43

main_35:
    add	w15,	w12,	w6
    madd	w20,	w12,	w10,	w22

    add	w12,	w12,	#1
    lsl	w25,	w20,	#2
    lsl	w17,	w15,	#2
    add	x24,	x1,	x25
    add	x16,	x1,	x17
    ldr	w4,	[x16]

    str	w4,	[x24]


main_43:
    cmp	w12,	w27
    blt	main_30

main_48:
    add	w22,	w22,	#1
    add	w6,	w6,	w27
    cmp	w22,	w10
    blt	main_24

main_54:
    add	w7,	w7,	#1
    cmp	w7,	w21
    blt	main_16

main_58:
    movz	w12,	#0
    movz	w27,	#0
    b	main_59

main_57:
    movz	w12,	#0
    movz	w27,	#0

main_59:
    cmp	w12,	w21
    bge	main_70

main_63:
    mul	w6,	w12,	w12
    lsl	w2,	w12,	#2
    adrp	x26, :got:matrix
    add	w12,	w12,	#1
    ldr	x26, [x26, #:got_lo12:matrix]
    add	x24,	x26,	x2
    ldr	w28,	[x24]

    madd	w27,	w6,	w28,	w27

    b	main_59

main_70:
    movz	w23,	#0
    sub	w19,	w23,	w27
    cmp	w27,	#0
    movz	w0,	#47
    csel	w24,	w19,	w27,	lt
    bl	_sysy_stoptime
    mov	w0,	w24
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#6800
    movk	fp,	#6,	lsl #16
    add	sp, sp, fp
    ret


