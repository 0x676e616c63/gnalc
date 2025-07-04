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
    sub	sp, sp, #64
    stp	fp, lr, [sp, #0]
    
    movz	w11,	#9
    movz	w1,	#4
    add	x27,	sp,	#32
    add	x21,	sp,	#48
    movz	w17,	#9
    movz	w4,	#6
    add	x25,	sp,	#24
    movz	w2,	#3
    movz	w23,	#2
    movz	w6,	#4
    add	x20,	sp,	#28
    add	x7,	sp,	#16
    movz	w19,	#1
    add	x24,	sp,	#20
    add	x22,	sp,	#36
    add	x26,	sp,	#40
    movz	w28,	#5
    str	w6,	[x7]

    movz	w6,	#7
    str	w2,	[x24]

    movz	w2,	#0
    str	w17,	[x25]

    str	w23,	[x20]

    add	x23,	sp,	#44
    str	w2,	[x27]

    str	w19,	[x22]

    add	x19,	sp,	#52
    str	w4,	[x26]

    str	w28,	[x23]

    movz	w28,	#8
    str	w6,	[x21]

    str	w28,	[x19]


main_13:
    mov	w28,	w1
    mov	w10,	w11

main_16:
    cmp	w10,	#10
    bge	main_45

main_20:
    cmp	w10,	#9
    blt	main_22

main_31:
    lsl	w2,	w10,	#2
    add	x15,	x7,	x2
    b	main_33

main_22:
    lsl	w4,	w10,	#2
    add	w3,	w10,	#1
    add	x15,	x7,	x4
    lsl	w9,	w3,	#2
    ldr	w0,	[x15]

    add	x18,	x7,	x9
    ldr	w12,	[x18]

    cmp	w0,	w12
    csel	x15,	x18,	x15,	lt
    csel	w10,	w3,	w10,	lt

main_33:
    lsl	w18,	w28,	#2
    add	x2,	x7,	x18
    ldr	w12,	[x2]

    ldr	w0,	[x15]

    cmp	w12,	w0
    ble	main_40

main_45:
    sub	w1,	w1,	#1
    movz	w13,	#65534
    movz	w12,	#65535
    movk	w13,	#65535,	lsl #16
    movk	w12,	#65535,	lsl #16
    add	w11,	w11,	w13
    cmp	w1,	w12
    bgt	main_13

main_49:
    movz	w8,	#9

main_52:
    ldr	w10,	[x7]

    lsl	w2,	w8,	#2
    sub	w13,	w8,	#1
    movz	w18,	#0
    add	x11,	x7,	x2
    ldr	w3,	[x11]

    str	w3,	[x7]

    str	w10,	[x11]

    movz	w10,	#1

main_58:
    cmp	w10,	w8
    bge	main_87

main_62:
    cmp	w10,	w13
    blt	main_64

main_73:
    lsl	w28,	w10,	#2
    add	x14,	x7,	x28
    b	main_75

main_64:
    lsl	w1,	w10,	#2
    add	w11,	w10,	#1
    add	x9,	x7,	x1
    lsl	w5,	w11,	#2
    ldr	w12,	[x9]

    add	x28,	x7,	x5
    ldr	w6,	[x28]

    cmp	w12,	w6
    csel	x14,	x28,	x9,	lt
    csel	w10,	w11,	w10,	lt

main_75:
    lsl	w16,	w18,	#2
    add	x2,	x7,	x16
    ldr	w9,	[x2]

    ldr	w18,	[x14]

    cmp	w9,	w18
    ble	main_82

main_87:
    cmp	w13,	#0
    ble	main_89

main_51:
    mov	w8,	w13
    b	main_52

main_89:
    ldr	w0,	[x7]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x24]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x25]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x27]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x22]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x26]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x19]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


main_82:
    str	w18,	[x2]

    lsl	w1,	w10,	#1
    mov	w18,	w10
    str	w9,	[x14]

    add	w0,	w1,	#1
    mov	w10,	w0
    b	main_58

main_40:
    str	w0,	[x2]

    lsl	w4,	w10,	#1
    mov	w28,	w10
    str	w12,	[x15]

    add	w2,	w4,	#1
    mov	w10,	w2
    b	main_16

