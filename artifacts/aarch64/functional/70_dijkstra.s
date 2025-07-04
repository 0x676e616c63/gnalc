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
    sub	sp, sp, #1168
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#64
    movz	w1,	#0
    add	x0,	sp,	#1040
    bl	memset
    movz	w2,	#64
    movz	w1,	#0
    add	x0,	sp,	#1104
    bl	memset
    movz	w2,	#1024
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    mov	w20,	w0
    bl	getint
    movz	w17,	#1
    mov	w19,	w0
    cmp	w17,	w20
    bgt	main_26

main_7:
    movz	w4,	#1

main_9:
    lsl	w2,	w4,	#6
    movz	w9,	#1
    mov	x18,	x2
    add	x18,	sp,	x18
    add	x18,	x18,	#16

main_13:
    cmp	w4,	w9
    beq	main_16

main_18:
    lsl	w11,	w9,	#2
    movz	w15,	#65535
    add	x27,	x18,	x11
    str	w15,	[x27]

    b	main_20

main_16:
    lsl	w13,	w9,	#2
    movz	w17,	#0
    add	x1,	x18,	x13
    str	w17,	[x1]


main_20:
    add	w9,	w9,	#1
    cmp	w9,	w20
    ble	main_13

main_23:
    add	w4,	w4,	#1
    cmp	w4,	w20
    ble	main_9

main_27:
    movz	w21,	#1
    b	main_28

main_26:
    movz	w21,	#1

main_28:
    cmp	w21,	w19
    ble	main_31

main_38:
    add	x4,	sp,	#80
    movz	w0,	#1

main_40:
    cmp	w0,	w20
    ble	main_43

main_49:
    add	x26,	sp,	#1108
    movz	w17,	#1
    sub	w6,	w20,	#1
    movz	w14,	#1
    str	w17,	[x26]

    cmp	w14,	w6
    bgt	main_111

main_53:
    movz	w24,	#1

main_55:
    movz	w15,	#1
    cmp	w15,	w20
    bgt	main_79

main_58:
    movz	w11,	#65535
    movz	w16,	#0
    movz	w14,	#1

main_60:
    lsl	w18,	w14,	#2
    mov	x17,	x18
    add	x17,	sp,	x17
    add	x17,	x17,	#1040
    ldr	w0,	[x17]

    cmp	w11,	w0
    ble	main_74

main_67:
    lsl	w23,	w14,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	#1104
    ldr	w25,	[x22]

    cmp	w25,	#0
    csel	w16,	w14,	w16,	eq
    csel	w11,	w0,	w11,	eq

main_74:
    add	w14,	w14,	#1
    cmp	w14,	w20
    ble	main_60
    b	main_81

main_79:
    movz	w16,	#0

main_81:
    lsl	w7,	w16,	#2
    movz	w19,	#1
    movz	w18,	#1
    mov	x11,	x7
    add	x11,	sp,	x11
    add	x11,	x11,	#1104
    str	w19,	[x11]

    cmp	w18,	w20
    bgt	main_108

main_85:
    lsl	w10,	w16,	#6
    lsl	w7,	w16,	#2
    movz	w8,	#1
    mov	x3,	x10
    mov	x9,	x7
    add	x3,	sp,	x3
    add	x9,	sp,	x9
    add	x3,	x3,	#16
    add	x9,	x9,	#1040

main_89:
    lsl	w15,	w8,	#2
    movz	w13,	#65535
    add	x14,	x3,	x15
    ldr	w27,	[x14]

    cmp	w27,	w13
    bge	main_103

main_94:
    lsl	w19,	w8,	#2
    mov	x28,	x19
    add	x28,	sp,	x28
    add	x28,	x28,	#1040
    ldr	w17,	[x28]

    ldr	w22,	[x9]

    add	w23,	w22,	w27
    cmp	w17,	w23
    ble	main_103

main_100:
    str	w23,	[x28]


main_103:
    add	w8,	w8,	#1
    cmp	w8,	w20
    ble	main_89

main_108:
    add	w24,	w24,	#1
    cmp	w24,	w6
    ble	main_55

main_112:
    movz	w23,	#1
    b	main_113

main_111:
    movz	w23,	#1

main_113:
    cmp	w23,	w20
    ble	main_116

main_120:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1168
    ret


main_116:
    lsl	w21,	w23,	#2
    mov	x19,	x21
    add	x19,	sp,	x19
    add	x19,	x19,	#1040
    ldr	w0,	[x19]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	w23,	w23,	#1
    b	main_113

main_43:
    lsl	w14,	w0,	#2
    lsl	w16,	w0,	#2
    lsl	w19,	w0,	#2
    movz	w10,	#0
    mov	x13,	x14
    add	x15,	x4,	x16
    add	w0,	w0,	#1
    mov	x6,	x19
    add	x13,	sp,	x13
    add	x6,	sp,	x6
    ldr	w17,	[x15]

    add	x13,	x13,	#1040
    add	x6,	x6,	#1104
    str	w17,	[x13]

    str	w10,	[x6]

    b	main_40

main_31:
    bl	getint
    mov	w23,	w0
    bl	getint
    lsl	w22,	w0,	#2
    lsl	w28,	w23,	#6
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    add	x22,	x27,	x22
    bl	getint
    add	w21,	w21,	#1
    str	w0,	[x22]

    b	main_28

