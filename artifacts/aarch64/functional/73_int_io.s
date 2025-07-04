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
    ble	main_18

main_23:
    cmp	w21,	#0
    ble	main_73

main_31:
    bl	getch
    sub	w23,	w0,	#48
    cmp	w23,	#0
    blt	main_31

main_35:
    cmp	w23,	#9
    bgt	main_31

main_38:
    bl	getch
    sub	w9,	w0,	#48
    cmp	w9,	#0
    bge	main_43

main_48:
    movz	w27,	#0
    b	main_50

main_43:
    cmp	w9,	#9
    ble	main_45

main_49:
    movz	w27,	#0

main_50:
    cmp	w23,	#0
    bgt	main_54

main_61:
    cmp	w27,	#0
    bgt	main_64

main_68:
    movz	w0,	#10
    bl	putch
    sub	w21,	w21,	#1
    cmp	w21,	#0
    bgt	main_31
    b	main_73

main_64:
    sub	w27,	w27,	#1
    lsl	w18,	w27,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w0,	[x0]

    bl	putch
    b	main_61

main_54:
    lsl	w10,	w27,	#2
    movz	w16,	#10
    movz	w8,	#10
    add	w27,	w27,	#1
    mov	x18,	x10
    sdiv	w1,	w23,	w16
    add	x18,	sp,	x18
    lsl	w4,	w1,	#1
    add	w25,	w4,	w1,	lsl #3
    add	x18,	x18,	#16
    sub	w11,	w23,	w25
    sdiv	w23,	w23,	w8
    add	w12,	w11,	#48
    str	w12,	[x18]

    b	main_50

main_45:
    lsl	w6,	w23,	#1
    add	w3,	w6,	w23,	lsl #3
    add	w23,	w9,	w3
    b	main_38

main_73:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #80
    ret


main_18:
    lsl	w20,	w21,	#1
    add	w10,	w20,	w21,	lsl #3
    add	w21,	w22,	w10
    b	main_11

