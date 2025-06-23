.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #80
    stp	fp, lr, [sp, #0]
    

main_4:
    bl	getch
    sub	w21,	w0,	#48
    cmp	w21,	#0
    blt	main_4

main_8:
    cmp	w21,	#9
    bgt	main_4

main_11:
    bl	getch
    sub	w22,	w0,	#48
    cmp	w22,	#0
    blt	main_23

main_16:
    cmp	w22,	#9
    bgt	main_23

main_18:
    lsl	w18,	w21,	#1
    add	w13,	w18,	w21,	lsl #3
    add	w21,	w22,	w13
    b	main_11

main_23:
    cmp	w21,	#0
    ble	main_73

main_31:
    bl	getch
    sub	w24,	w0,	#48
    cmp	w24,	#0
    blt	main_31

main_35:
    cmp	w24,	#9
    bgt	main_31

main_38:
    bl	getch
    sub	w10,	w0,	#48
    cmp	w10,	#0
    blt	main_48

main_43:
    cmp	w10,	#9
    bgt	main_49

main_45:
    lsl	w6,	w24,	#1
    add	w18,	w6,	w24,	lsl #3
    add	w24,	w10,	w18
    b	main_38

main_49:
    movz	w25,	#0
    b	main_50

main_48:
    movz	w25,	#0

main_50:
    cmp	w24,	#0
    ble	main_61

main_54:
    lsl	w7,	w25,	#2
    movz	w16,	#10
    add	w25,	w25,	#1
    mov	x14,	x7
    sdiv	w1,	w24,	w16
    add	x14,	sp,	x14
    lsl	w6,	w1,	#1
    add	x14,	x14,	#16
    add	w26,	w6,	w1,	lsl #3
    sub	w8,	w24,	w26
    add	w9,	w8,	#48
    movz	w8,	#10
    str	w9,	[x14]

    sdiv	w24,	w24,	w8
    b	main_50

main_61:
    cmp	w25,	#0
    ble	main_68

main_64:
    sub	w25,	w25,	#1
    lsl	w28,	w25,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    ldr	w0,	[x27]

    bl	putch
    b	main_61

main_68:
    movz	w0,	#10
    bl	putch
    sub	w21,	w21,	#1
    cmp	w21,	#0
    bgt	main_31

main_73:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #80
    ret


