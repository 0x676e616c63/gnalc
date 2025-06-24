.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #64
    stp	fp, lr, [sp, #0]
    
    movz	w21,	#2
    movz	w6,	#0
    movz	w8,	#9
    movz	w1,	#6
    movz	w14,	#3
    movz	w16,	#5
    add	x26,	sp,	#28
    add	x11,	sp,	#16
    movz	w27,	#0
    movz	w23,	#4
    add	x20,	sp,	#20
    movz	w2,	#1
    add	x24,	sp,	#44
    add	x28,	sp,	#40
    movz	w22,	#7
    movz	w9,	#8
    add	x25,	sp,	#32
    str	w23,	[x11]

    add	x23,	sp,	#24
    str	w14,	[x20]

    str	w8,	[x23]

    str	w21,	[x26]

    add	x21,	sp,	#48
    str	w27,	[x25]

    add	x27,	sp,	#36
    str	w2,	[x27]

    str	w1,	[x28]

    str	w16,	[x24]

    str	w22,	[x21]

    add	x22,	sp,	#52
    str	w9,	[x22]


main_13:
    movz	w1,	#10
    movz	w0,	#0
    sub	w4,	w1,	w6
    sub	w17,	w4,	#1
    cmp	w0,	w17
    bge	main_34

main_18:
    movz	w12,	#0

main_20:
    lsl	w16,	w12,	#2
    add	w12,	w12,	#1
    add	x13,	x11,	x16
    lsl	w0,	w12,	#2
    ldr	w3,	[x13]

    add	x7,	x11,	x0
    ldr	w1,	[x7]

    cmp	w3,	w1
    ble	main_30

main_28:
    str	w3,	[x7]

    str	w1,	[x13]


main_30:
    cmp	w12,	w17
    blt	main_20

main_34:
    add	w6,	w6,	#1
    cmp	w6,	#9
    blt	main_13

main_37:
    ldr	w0,	[x11]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x26]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x25]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x27]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x28]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x24]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x22]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


