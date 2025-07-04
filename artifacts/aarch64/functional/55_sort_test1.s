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
    
    movz	w2,	#1
    movz	w14,	#3
    movz	w22,	#7
    add	x20,	sp,	#20
    movz	w21,	#2
    movz	w23,	#4
    add	x3,	sp,	#16
    movz	w10,	#8
    movz	w27,	#0
    movz	w16,	#5
    movz	w8,	#9
    movz	w1,	#6
    add	x24,	sp,	#44
    add	x26,	sp,	#28
    add	x28,	sp,	#40
    add	x25,	sp,	#32
    str	w23,	[x3]

    add	x23,	sp,	#24
    str	w14,	[x20]

    str	w8,	[x23]

    str	w21,	[x26]

    add	x21,	sp,	#48
    str	w27,	[x25]

    add	x27,	sp,	#36
    str	w2,	[x27]

    str	w1,	[x28]

    movz	w1,	#0
    str	w16,	[x24]

    str	w22,	[x21]

    add	x22,	sp,	#52
    str	w10,	[x22]


main_13:
    movz	w2,	#10
    movz	w0,	#0
    sub	w6,	w2,	w1
    sub	w17,	w6,	#1
    cmp	w0,	w17
    bge	main_34

main_18:
    movz	w12,	#0

main_20:
    lsl	w16,	w12,	#2
    add	w12,	w12,	#1
    add	x13,	x3,	x16
    lsl	w0,	w12,	#2
    ldr	w5,	[x13]

    add	x8,	x3,	x0
    ldr	w2,	[x8]

    cmp	w5,	w2
    ble	main_30

main_28:
    str	w5,	[x8]

    str	w2,	[x13]


main_30:
    cmp	w12,	w17
    blt	main_20

main_34:
    add	w1,	w1,	#1
    cmp	w1,	#9
    blt	main_13

main_37:
    ldr	w0,	[x3]

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


