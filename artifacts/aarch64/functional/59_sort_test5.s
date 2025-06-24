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
    movz	w17,	#9
    movz	w26,	#8
    movz	w2,	#3
    add	x25,	sp,	#24
    movz	w6,	#4
    movz	w19,	#1
    add	x20,	sp,	#36
    add	x28,	sp,	#40
    add	x16,	sp,	#16
    add	x24,	sp,	#20
    movz	w4,	#6
    movz	w27,	#5
    movz	w22,	#2
    add	x21,	sp,	#32
    add	x23,	sp,	#28
    str	w6,	[x16]

    movz	w6,	#7
    str	w2,	[x24]

    movz	w2,	#0
    str	w17,	[x25]

    str	w22,	[x23]

    add	x22,	sp,	#52
    str	w2,	[x21]

    str	w19,	[x20]

    add	x19,	sp,	#44
    str	w4,	[x28]

    str	w27,	[x19]

    add	x27,	sp,	#48
    str	w6,	[x27]

    movz	w6,	#4
    str	w26,	[x22]


main_13:
    mov	w4,	w6
    mov	w0,	w12

main_16:
    cmp	w0,	#10
    bge	main_45

main_20:
    cmp	w0,	#9
    bge	main_31

main_22:
    lsl	w2,	w0,	#2
    add	w1,	w0,	#1
    add	x11,	x16,	x2
    lsl	w8,	w1,	#2
    ldr	w18,	[x11]

    add	x17,	x16,	x8
    ldr	w9,	[x17]

    cmp	w18,	w9
    csel	x15,	x17,	x11,	lt
    csel	w0,	w1,	w0,	lt
    b	main_33

main_31:
    lsl	w15,	w0,	#2
    add	x15,	x16,	x15

main_33:
    lsl	w18,	w4,	#2
    add	x2,	x16,	x18
    ldr	w10,	[x2]

    ldr	w1,	[x15]

    cmp	w10,	w1
    bgt	main_45

main_40:
    str	w1,	[x2]

    lsl	w13,	w0,	#1
    mov	w4,	w0
    str	w10,	[x15]

    add	w5,	w13,	#1
    mov	w0,	w5
    b	main_16

main_45:
    sub	w6,	w6,	#1
    movz	w13,	#65534
    movz	w11,	#65535
    movk	w13,	#65535,	lsl #16
    movk	w11,	#65535,	lsl #16
    add	w12,	w12,	w13
    cmp	w6,	w11
    bgt	main_13

main_49:
    movz	w17,	#9

main_52:
    ldr	w10,	[x16]

    lsl	w4,	w17,	#2
    sub	w12,	w17,	#1
    movz	w0,	#1
    add	x11,	x16,	x4
    movz	w4,	#0
    ldr	w5,	[x11]

    str	w5,	[x16]

    str	w10,	[x11]


main_58:
    cmp	w0,	w17
    bge	main_87

main_62:
    cmp	w0,	w12
    bge	main_73

main_64:
    lsl	w2,	w0,	#2
    add	w10,	w0,	#1
    add	x9,	x16,	x2
    lsl	w7,	w10,	#2
    ldr	w11,	[x9]

    add	x26,	x16,	x7
    ldr	w8,	[x26]

    cmp	w11,	w8
    csel	x14,	x26,	x9,	lt
    csel	w0,	w10,	w0,	lt
    b	main_75

main_73:
    lsl	w14,	w0,	#2
    add	x14,	x16,	x14

main_75:
    lsl	w18,	w4,	#2
    add	x6,	x16,	x18
    ldr	w11,	[x6]

    ldr	w1,	[x14]

    cmp	w11,	w1
    bgt	main_87

main_82:
    str	w1,	[x6]

    lsl	w9,	w0,	#1
    mov	w4,	w0
    str	w11,	[x14]

    add	w11,	w9,	#1
    mov	w0,	w11
    b	main_58

main_87:
    cmp	w12,	#0
    bgt	main_51

main_89:
    ldr	w0,	[x16]

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
    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x28]

    bl	putint
    movz	w0,	#10
    bl	putch
    ldr	w0,	[x19]

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
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


main_51:
    mov	w17,	w12
    b	main_52

