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
    
    movz	w11,	#1
    movz	w26,	#2
    movz	w21,	#6
    movz	w18,	#3
    movz	w12,	#9
    add	x20,	sp,	#24
    add	x28,	sp,	#36
    movz	w2,	#0
    movz	w3,	#7
    add	x24,	sp,	#20
    movz	w27,	#4
    movz	w22,	#5
    add	x10,	sp,	#16
    movz	w6,	#1
    add	x23,	sp,	#40
    add	x19,	sp,	#44
    movz	w14,	#8
    str	w27,	[x10]

    add	x27,	sp,	#28
    str	w18,	[x24]

    str	w12,	[x20]

    str	w26,	[x27]

    add	x26,	sp,	#32
    str	w2,	[x26]

    str	w6,	[x28]

    str	w21,	[x23]

    add	x21,	sp,	#48
    str	w22,	[x19]

    add	x22,	sp,	#52
    str	w3,	[x21]

    str	w14,	[x22]


main_13:
    lsl	w5,	w11,	#2
    sub	w7,	w11,	#1
    add	x4,	x10,	x5
    ldr	w2,	[x4]


main_18:
    movz	w8,	#65535
    movk	w8,	#65535,	lsl #16
    cmp	w7,	w8
    ble	main_31

main_21:
    lsl	w18,	w7,	#2
    add	x17,	x10,	x18
    ldr	w5,	[x17]

    cmp	w2,	w5
    blt	main_25

main_31:
    add	w15,	w7,	#1
    add	w11,	w11,	#1
    lsl	w17,	w15,	#2
    add	x16,	x10,	x17
    str	w2,	[x16]

    cmp	w11,	#10
    blt	main_13

main_36:
    ldr	w0,	[x10]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x24]

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
    ldr	w0,	[x26]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x28]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x19]

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


main_25:
    add	w25,	w7,	#1
    sub	w7,	w7,	#1
    lsl	w1,	w25,	#2
    add	x0,	x10,	x1
    str	w5,	[x0]

    b	main_18

