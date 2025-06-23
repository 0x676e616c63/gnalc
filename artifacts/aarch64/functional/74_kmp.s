.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#49168
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w20,	#0
    movz	fp,	#32784
    add	x23,	sp,	fp

main_6:
    lsl	w28,	w20,	#2
    add	x21,	x23,	x28
    bl	getch
    add	w20,	w20,	#1
    str	w0,	[x21]

    cmp	w0,	#10
    bne	main_6

main_12:
    movz	w8,	#0
    add	x19,	sp,	#16
    str	w8,	[x21]

    movz	w21,	#0

main_15:
    lsl	w18,	w21,	#2
    add	x27,	x19,	x18
    bl	getch
    add	w21,	w21,	#1
    str	w0,	[x27]

    cmp	w0,	#10
    bne	main_15

main_21:
    movz	w10,	#0
    movz	fp,	#16400
    movz	w25,	#65535
    str	w10,	[x27]

    add	x4,	sp,	fp
    movk	w25,	#65535,	lsl #16
    str	w25,	[x4]

    ldr	w15,	[x23]

    cmp	w15,	#0
    beq	main_53

main_27:
    movz	w8,	#0
    mov	w10,	w25

main_29:
    cmp	w10,	w25
    beq	main_40

main_34:
    lsl	w22,	w10,	#2
    add	x21,	x23,	x22
    ldr	w24,	[x21]

    cmp	w15,	w24
    beq	main_40

main_44:
    lsl	w28,	w10,	#2
    add	x27,	x4,	x28
    ldr	w10,	[x27]

    b	main_47

main_40:
    add	w10,	w10,	#1
    add	w8,	w8,	#1
    lsl	w24,	w8,	#2
    add	x22,	x4,	x24
    str	w10,	[x22]


main_47:
    lsl	w27,	w8,	#2
    add	x26,	x23,	x27
    ldr	w15,	[x26]

    cmp	w15,	#0
    bne	main_29

main_54:
    movz	w27,	#0
    movz	w0,	#0
    b	main_55

main_53:
    movz	w27,	#0
    movz	w0,	#0

main_55:
    lsl	w11,	w0,	#2
    add	x10,	x19,	x11
    ldr	w6,	[x10]

    cmp	w6,	#0
    beq	main_82

main_61:
    lsl	w15,	w27,	#2
    add	x14,	x23,	x15
    ldr	w16,	[x14]

    cmp	w16,	w6
    bne	main_71

main_65:
    add	w27,	w27,	#1
    add	w0,	w0,	#1
    lsl	w22,	w27,	#2
    add	x21,	x23,	x22
    ldr	w24,	[x21]

    cmp	w24,	#0
    beq	main_84
    b	main_55

main_71:
    lsl	w21,	w27,	#2
    movz	fp,	#16400
    mov	x20,	x21
    add	w21,	w0,	#1
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w20,	[x20]

    cmp	w20,	w25
    csel	w0,	w21,	w0,	eq
    movz	w14,	#0
    csel	w27,	w14,	w20,	eq
    b	main_55

main_82:
    mov	w0,	w25

main_84:
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#49168
    add	sp, sp, fp
    ret


