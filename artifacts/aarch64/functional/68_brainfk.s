.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#16
    movk	fp,	#6,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#2,	lsl #16
    bl	memset
    movz	w2,	#0
    movz	w1,	#0
    movz	fp,	#16
    movk	w2,	#4,	lsl #16
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    bl	getint
    movz	w20,	#0
    mov	w19,	w0

main_4:
    cmp	w20,	w19
    bge	main_11

main_7:
    lsl	w23,	w20,	#2
    mov	x26,	x23
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    bl	getch
    add	w20,	w20,	#1
    str	w0,	[x26]

    b	main_4

main_11:
    lsl	w23,	w20,	#2
    movz	w19,	#0
    add	x24,	sp,	#16
    mov	x16,	x23
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    str	w19,	[x16]

    ldr	w21,	[x24]

    cmp	w21,	#0
    beq	main_101

main_17:
    movz	w25,	#0
    movz	w19,	#0

main_19:
    cmp	w21,	#62
    bne	main_26

main_24:
    add	w19,	w19,	#1
    b	main_92

main_26:
    cmp	w21,	#60
    bne	main_30

main_28:
    sub	w19,	w19,	#1
    b	main_92

main_30:
    cmp	w21,	#43
    bne	main_36

main_32:
    lsl	w18,	w19,	#2
    movz	fp,	#16
    mov	x12,	x18
    movk	fp,	#2,	lsl #16
    add	x12,	sp,	x12
    add	x12,	x12,	fp
    ldr	w20,	[x12]

    add	w21,	w20,	#1
    str	w21,	[x12]

    b	main_92

main_36:
    cmp	w21,	#45
    bne	main_42

main_38:
    lsl	w26,	w19,	#2
    movz	fp,	#16
    mov	x17,	x26
    movk	fp,	#2,	lsl #16
    add	x17,	sp,	x17
    add	x17,	x17,	fp
    ldr	w27,	[x17]

    sub	w28,	w27,	#1
    str	w28,	[x17]

    b	main_92

main_42:
    cmp	w21,	#46
    bne	main_47

main_44:
    lsl	w18,	w19,	#2
    movz	fp,	#16
    mov	x0,	x18
    movk	fp,	#2,	lsl #16
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putch
    b	main_92

main_47:
    cmp	w21,	#44
    bne	main_52

main_49:
    lsl	w22,	w19,	#2
    movz	fp,	#16
    mov	x26,	x22
    movk	fp,	#2,	lsl #16
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    bl	getch
    str	w0,	[x26]

    b	main_92

main_52:
    cmp	w21,	#93
    bne	main_92

main_54:
    lsl	w11,	w19,	#2
    movz	fp,	#16
    mov	x10,	x11
    movk	fp,	#2,	lsl #16
    add	x10,	sp,	x10
    add	x10,	x10,	fp
    ldr	w12,	[x10]

    cmp	w12,	#0
    beq	main_92

main_58:
    movz	w8,	#1

main_60:
    sub	w25,	w25,	#1
    lsl	w23,	w25,	#2
    add	x22,	x24,	x23
    ldr	w16,	[x22]

    cmp	w16,	#91
    bne	main_69

main_67:
    sub	w8,	w8,	#1
    b	main_73

main_69:
    add	w1,	w8,	#1
    cmp	w16,	#93
    csel	w8,	w1,	w8,	eq

main_73:
    cmp	w8,	#0
    bgt	main_60

main_92:
    add	w25,	w25,	#1
    lsl	w1,	w25,	#2
    add	x28,	x24,	x1
    ldr	w21,	[x28]

    cmp	w21,	#0
    bne	main_19

main_101:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#16
    movk	fp,	#6,	lsl #16
    add	sp, sp, fp
    ret


