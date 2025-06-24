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
    
    movz	w12,	#9
    movz	w3,	#7
    movz	w18,	#3
    add	x19,	sp,	#24
    add	x21,	sp,	#20
    movz	w27,	#4
    movz	w22,	#6
    movz	w6,	#1
    movz	w2,	#0
    add	x13,	sp,	#16
    movz	w23,	#5
    add	x26,	sp,	#28
    add	x28,	sp,	#40
    add	x25,	sp,	#48
    movz	w14,	#8
    add	x24,	sp,	#32
    add	x20,	sp,	#44
    str	w27,	[x13]

    movz	w27,	#2
    str	w18,	[x21]

    str	w12,	[x19]

    str	w27,	[x26]

    add	x27,	sp,	#36
    str	w2,	[x24]

    str	w6,	[x27]

    movz	w6,	#1
    str	w22,	[x28]

    add	x22,	sp,	#52
    str	w23,	[x20]

    str	w3,	[x25]

    str	w14,	[x22]


main_13:
    lsl	w5,	w6,	#2
    sub	w12,	w6,	#1
    add	x4,	x13,	x5
    ldr	w4,	[x4]


main_18:
    movz	w8,	#65535
    movk	w8,	#65535,	lsl #16
    cmp	w12,	w8
    ble	main_31

main_21:
    lsl	w18,	w12,	#2
    add	x17,	x13,	x18
    ldr	w7,	[x17]

    cmp	w4,	w7
    bge	main_31

main_25:
    add	w1,	w12,	#1
    sub	w12,	w12,	#1
    lsl	w3,	w1,	#2
    add	x2,	x13,	x3
    str	w7,	[x2]

    b	main_18

main_31:
    add	w23,	w12,	#1
    add	w6,	w6,	#1
    lsl	w1,	w23,	#2
    add	x0,	x13,	x1
    str	w4,	[x0]

    cmp	w6,	#10
    blt	main_13

main_36:
    ldr	w0,	[x13]

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
    ldr	w0,	[x26]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x24]

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
    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x25]

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


