.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl QuickSort
.align 2
.p2align 4,,11
.type QuickSort, %function
QuickSort:
QuickSort_3:
    sub	sp, sp, #80
    stp	x19, x20, [sp, #0]
    stp	x22, x23, [sp, #16]
    stp	x26, x27, [sp, #32]
    stp	x28, fp, [sp, #48]
    str	lr, [sp, 64]

    mov	w20,	w2
    mov	x28,	x0
    cmp	w1,	w20
    bge	QuickSort_69

QuickSort_5:
    lsl	w17,	w1,	#2
    add	x14,	x28,	x17
    ldr	w15,	[x14]

    cmp	w1,	w20
    blt	QuickSort_9

QuickSort_58:
    mov	w27,	w1
    b	QuickSort_59

QuickSort_9:
    sub	w17,	w15,	#1
    mov	w27,	w1
    mov	w12,	w20

QuickSort_16:
    cmp	w27,	w12
    bge	QuickSort_26

QuickSort_19:
    lsl	w3,	w12,	#2
    sub	w7,	w12,	#1
    add	x2,	x28,	x3
    ldr	w23,	[x2]

    cmp	w23,	w17
    ble	QuickSort_26

QuickSort_15:
    mov	w12,	w7
    b	QuickSort_16

QuickSort_26:
    cmp	w27,	w12
    bge	QuickSort_37

QuickSort_28:
    lsl	w9,	w27,	#2
    lsl	w11,	w12,	#2
    add	w27,	w27,	#1
    add	x23,	x28,	x9
    add	x10,	x28,	x11
    ldr	w13,	[x10]

    str	w13,	[x23]


QuickSort_37:
    cmp	w27,	w12
    bge	QuickSort_47

QuickSort_40:
    lsl	w19,	w27,	#2
    add	w22,	w27,	#1
    add	x18,	x28,	x19
    ldr	w10,	[x18]

    cmp	w10,	w15
    bge	QuickSort_47

QuickSort_36:
    mov	w27,	w22
    b	QuickSort_37

QuickSort_47:
    cmp	w27,	w12
    bge	QuickSort_55

QuickSort_49:
    lsl	w26,	w12,	#2
    lsl	w2,	w27,	#2
    sub	w12,	w12,	#1
    add	x14,	x28,	x26
    add	x0,	x28,	x2
    ldr	w3,	[x0]

    str	w3,	[x14]


QuickSort_55:
    cmp	w27,	w12
    blt	QuickSort_16

QuickSort_66:
    lsl	w7,	w27,	#2
    add	x14,	x28,	x7

QuickSort_59:
    str	w15,	[x14]

    sub	w2,	w27,	#1
    mov	x0,	x28
    bl	QuickSort
    mov	w2,	w20
    mov	x0,	x28
    add	w1,	w27,	#1
    bl	QuickSort

QuickSort_69:
    movz	w0,	#0
    ldp	x19, x20, [sp, #0]
    ldp	x22, x23, [sp, #16]
    ldp	x26, x27, [sp, #32]
    ldp	x28, fp, [sp, #48]
    ldr	lr, [sp, 64]

    add	sp, sp, #80
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #64
    stp	fp, lr, [sp, #0]
    
    movz	w27,	#2
    movz	w28,	#9
    movz	w2,	#4
    add	x23,	sp,	#40
    movz	w1,	#3
    add	x0,	sp,	#16
    movz	w26,	#0
    movz	w25,	#1
    movz	w24,	#6
    add	x21,	sp,	#32
    add	x19,	sp,	#20
    add	x22,	sp,	#36
    add	x20,	sp,	#28
    str	w2,	[x0]

    movz	w2,	#9
    str	w1,	[x19]

    movz	w1,	#0
    add	x19,	sp,	#24
    str	w28,	[x19]

    str	w27,	[x20]

    add	x27,	sp,	#52
    str	w26,	[x21]

    add	x26,	sp,	#48
    movz	w21,	#8
    str	w25,	[x22]

    add	x25,	sp,	#44
    movz	w22,	#7
    str	w24,	[x23]

    movz	w23,	#5
    str	w23,	[x25]

    str	w22,	[x26]

    str	w21,	[x27]

    bl	QuickSort
    mov	w20,	w0

main_13:
    cmp	w20,	#10
    blt	main_16

main_20:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


main_16:
    lsl	w22,	w20,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w20,	#1
    b	main_13

