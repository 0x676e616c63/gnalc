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
    
    movz	w19,	#9
    movz	w4,	#8
    movz	w28,	#3
    add	x25,	sp,	#32
    movz	w0,	#4
    movz	w13,	#2
    add	x21,	sp,	#48
    add	x24,	sp,	#36
    movz	w27,	#0
    add	x10,	sp,	#20
    movz	w7,	#6
    movz	w3,	#1
    add	x26,	sp,	#24
    add	x12,	sp,	#16
    add	x22,	sp,	#40
    movz	w6,	#5
    add	x17,	sp,	#52
    str	w0,	[x12]

    str	x10,	[sp, #56]

    ldr	x5,	[sp, #56]

    str	w28,	[x5]

    add	x28,	sp,	#44
    add	x5,	sp,	#28
    str	w19,	[x26]

    str	x5,	[sp, #64]

    ldr	x23,	[sp, #64]

    str	w13,	[x23]

    str	w27,	[x25]

    movz	w27,	#7
    str	w3,	[x24]

    str	w7,	[x22]

    str	w6,	[x28]

    str	w27,	[x21]

    movz	w27,	#0
    str	x17,	[sp, #72]

    ldr	x15,	[sp, #72]

    str	w4,	[x15]


main_13:
    add	w20,	w27,	#1
    mov	w13,	w27
    mov	w11,	w20

main_16:
    cmp	w11,	#10
    bge	main_28

main_20:
    lsl	w2,	w13,	#2
    lsl	w5,	w11,	#2
    add	x1,	x12,	x2
    add	x4,	x12,	x5
    ldr	w19,	[x1]

    ldr	w6,	[x4]

    cmp	w19,	w6
    csel	w13,	w11,	w13,	gt
    add	w11,	w11,	#1
    b	main_16

main_28:
    cmp	w13,	w27
    beq	main_36

main_30:
    lsl	w0,	w13,	#2
    lsl	w2,	w27,	#2
    add	x6,	x12,	x0
    add	x2,	x12,	x2
    ldr	w18,	[x6]

    ldr	w3,	[x2]

    str	w3,	[x6]

    str	w18,	[x2]


main_36:
    cmp	w20,	#9
    blt	main_12

main_38:
    ldr	w0,	[x12]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	x23,	[sp, #56]

    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x26]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	x20,	[sp, #64]

    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x25]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x24]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x22]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x28]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	x19,	[sp, #72]

    ldr	w0,	[x19]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #80
    ret


main_12:
    mov	w27,	w20
    b	main_13

