.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
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
    blt	main_7

main_11:
    lsl	w19,	w20,	#2
    movz	w18,	#0
    add	x28,	sp,	#16
    mov	x12,	x19
    add	x12,	sp,	x12
    add	x12,	x12,	#16
    str	w18,	[x12]

    ldr	w21,	[x28]

    cmp	w21,	#0
    beq	main_101

main_17:
    movz	w24,	#0
    movz	w19,	#0

main_19:
    cmp	w21,	#62
    beq	main_24

main_26:
    cmp	w21,	#60
    beq	main_28

main_30:
    cmp	w21,	#43
    beq	main_32

main_36:
    cmp	w21,	#45
    beq	main_38

main_42:
    cmp	w21,	#46
    beq	main_44

main_47:
    cmp	w21,	#44
    beq	main_49

main_52:
    cmp	w21,	#93
    bne	main_92

main_54:
    lsl	w16,	w19,	#2
    movz	fp,	#16
    mov	x15,	x16
    movk	fp,	#2,	lsl #16
    add	x15,	sp,	x15
    add	x15,	x15,	fp
    ldr	w17,	[x15]

    cmp	w17,	#0
    beq	main_92

main_58:
    movz	w11,	#1

main_60:
    sub	w24,	w24,	#1
    lsl	w1,	w24,	#2
    add	x27,	x28,	x1
    ldr	w20,	[x27]

    cmp	w20,	#91
    beq	main_67

main_69:
    add	w4,	w11,	#1
    cmp	w20,	#93
    csel	w11,	w4,	w11,	eq
    b	main_73

main_67:
    sub	w11,	w11,	#1

main_73:
    cmp	w11,	#0
    bgt	main_60
    b	main_92

main_49:
    lsl	w20,	w19,	#2
    movz	fp,	#16
    mov	x22,	x20
    movk	fp,	#2,	lsl #16
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    bl	getch
    str	w0,	[x22]

    b	main_92

main_44:
    lsl	w25,	w19,	#2
    movz	fp,	#16
    mov	x23,	x25
    movk	fp,	#2,	lsl #16
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putch
    b	main_92

main_38:
    lsl	w11,	w19,	#2
    movz	fp,	#16
    mov	x7,	x11
    movk	fp,	#2,	lsl #16
    add	x7,	sp,	x7
    add	x7,	x7,	fp
    ldr	w12,	[x7]

    sub	w13,	w12,	#1
    str	w13,	[x7]

    b	main_92

main_32:
    lsl	w15,	w19,	#2
    movz	fp,	#16
    mov	x11,	x15
    movk	fp,	#2,	lsl #16
    add	x11,	sp,	x11
    add	x11,	x11,	fp
    ldr	w16,	[x11]

    add	w17,	w16,	#1
    str	w17,	[x11]

    b	main_92

main_28:
    sub	w19,	w19,	#1
    b	main_92

main_24:
    add	w19,	w19,	#1

main_92:
    add	w24,	w24,	#1
    lsl	w23,	w24,	#2
    add	x22,	x28,	x23
    ldr	w21,	[x22]

    cmp	w21,	#0
    bne	main_19

main_101:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#16
    movk	fp,	#6,	lsl #16
    add	sp, sp, fp
    ret


main_7:
    lsl	w26,	w20,	#2
    mov	x26,	x26
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    bl	getch
    add	w20,	w20,	#1
    str	w0,	[x26]

    b	main_4

