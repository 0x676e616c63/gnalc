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
    
    movz	w4,	#0
    movz	w8,	#1
    movz	w22,	#6
    movz	w0,	#4
    add	x19,	sp,	#44
    movz	w20,	#3
    movz	w16,	#8
    movz	w14,	#9
    movz	w6,	#7
    add	x26,	sp,	#32
    add	x24,	sp,	#28
    add	x28,	sp,	#24
    add	x25,	sp,	#20
    add	x2,	sp,	#16
    add	x23,	sp,	#40
    add	x27,	sp,	#36
    str	w0,	[x2]

    movz	w0,	#2
    str	w20,	[x25]

    add	x20,	sp,	#52
    str	w14,	[x28]

    str	w0,	[x24]

    movz	w0,	#5
    str	w4,	[x26]

    str	w8,	[x27]

    str	w22,	[x23]

    add	x22,	sp,	#48
    str	w0,	[x19]

    str	w6,	[x22]

    str	w16,	[x20]

    movz	w16,	#0

main_13:
    add	w5,	w16,	#1
    mov	w13,	w16
    mov	w7,	w5

main_16:
    cmp	w7,	#10
    blt	main_20

main_28:
    cmp	w13,	w16
    beq	main_36

main_30:
    lsl	w17,	w13,	#2
    lsl	w14,	w16,	#2
    add	x10,	x2,	x17
    add	x21,	x2,	x14
    ldr	w3,	[x10]

    ldr	w15,	[x21]

    str	w15,	[x10]

    str	w3,	[x21]


main_36:
    cmp	w5,	#9
    bge	main_38

main_12:
    mov	w16,	w5
    b	main_13

main_38:
    ldr	w0,	[x2]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x25]

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
    ldr	w0,	[x26]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x27]

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
    ldr	w0,	[x22]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


main_20:
    lsl	w15,	w13,	#2
    lsl	w21,	w7,	#2
    add	x14,	x2,	x15
    add	x18,	x2,	x21
    ldr	w14,	[x14]

    ldr	w0,	[x18]

    cmp	w14,	w0
    csel	w13,	w7,	w13,	gt
    add	w7,	w7,	#1
    b	main_16

