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
    movz	fp,	#49168
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w19,	#0
    movz	fp,	#32784
    add	x21,	sp,	fp

main_6:
    lsl	w28,	w19,	#2
    add	x22,	x21,	x28
    bl	getch
    add	w19,	w19,	#1
    str	w0,	[x22]

    cmp	w0,	#10
    bne	main_6

main_12:
    movz	w8,	#0
    add	x26,	sp,	#16
    str	w8,	[x22]

    movz	w22,	#0

main_15:
    lsl	w18,	w22,	#2
    add	x27,	x26,	x18
    bl	getch
    add	w22,	w22,	#1
    str	w0,	[x27]

    cmp	w0,	#10
    bne	main_15

main_21:
    movz	w10,	#0
    movz	fp,	#16400
    movz	w0,	#65535
    str	w10,	[x27]

    add	x5,	sp,	fp
    movk	w0,	#65535,	lsl #16
    str	w0,	[x5]

    ldr	w16,	[x21]

    cmp	w16,	#0
    beq	main_53

main_27:
    movz	w9,	#0
    mov	w11,	w0

main_29:
    cmp	w11,	w0
    beq	main_40

main_34:
    lsl	w23,	w11,	#2
    add	x22,	x21,	x23
    ldr	w24,	[x22]

    cmp	w16,	w24
    bne	main_44

main_40:
    add	w11,	w11,	#1
    add	w9,	w9,	#1
    lsl	w20,	w9,	#2
    add	x19,	x5,	x20
    str	w11,	[x19]

    b	main_47

main_44:
    lsl	w4,	w11,	#2
    add	x3,	x5,	x4
    ldr	w11,	[x3]


main_47:
    lsl	w27,	w9,	#2
    add	x25,	x21,	x27
    ldr	w16,	[x25]

    cmp	w16,	#0
    bne	main_29

main_54:
    movz	w5,	#0
    movz	w28,	#0
    b	main_55

main_53:
    movz	w5,	#0
    movz	w28,	#0

main_55:
    lsl	w12,	w28,	#2
    add	x11,	x26,	x12
    ldr	w7,	[x11]

    cmp	w7,	#0
    beq	main_84

main_61:
    lsl	w16,	w5,	#2
    add	x15,	x21,	x16
    ldr	w17,	[x15]

    cmp	w17,	w7
    beq	main_65

main_71:
    lsl	w14,	w5,	#2
    movz	fp,	#16400
    add	w15,	w28,	#1
    mov	x13,	x14
    add	x13,	sp,	x13
    add	x13,	x13,	fp
    ldr	w12,	[x13]

    cmp	w12,	w0
    csel	w28,	w15,	w28,	eq
    movz	w13,	#0
    csel	w5,	w13,	w12,	eq
    b	main_55

main_65:
    add	w5,	w5,	#1
    add	w28,	w28,	#1
    lsl	w4,	w5,	#2
    add	x3,	x21,	x4
    ldr	w6,	[x3]

    cmp	w6,	#0
    bne	main_55

main_83:
    mov	w0,	w28

main_84:
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#49168
    add	sp, sp, fp
    ret


