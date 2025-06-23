.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #1168
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#64
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
    mov	w22,	w0
    cmp	w17,	w20
    ble	main_7

main_26:
    movz	w23,	#1
    b	main_28

main_7:
    movz	w7,	#1

main_9:
    lsl	w2,	w7,	#6
    movz	w27,	#1
    mov	x17,	x2
    add	x17,	sp,	x17
    add	x17,	x17,	#16

main_13:
    cmp	w7,	w27
    bne	main_18

main_16:
    lsl	w10,	w27,	#2
    movz	w14,	#0
    add	x26,	x17,	x10
    str	w14,	[x26]

    b	main_20

main_18:
    lsl	w12,	w27,	#2
    movz	w16,	#65535
    add	x1,	x17,	x12
    str	w16,	[x1]


main_20:
    add	w27,	w27,	#1
    cmp	w27,	w20
    ble	main_13

main_23:
    add	w7,	w7,	#1
    cmp	w7,	w20
    ble	main_9

main_27:
    movz	w23,	#1

main_28:
    cmp	w23,	w22
    bgt	main_38

main_31:
    bl	getint
    mov	w24,	w0
    bl	getint
    lsl	w26,	w0,	#2
    lsl	w24,	w24,	#6
    mov	x21,	x24
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    add	x26,	x21,	x26
    bl	getint
    add	w23,	w23,	#1
    str	w0,	[x26]

    b	main_28

main_38:
    add	x17,	sp,	#80
    movz	w23,	#1

main_40:
    cmp	w23,	w20
    bgt	main_49

main_43:
    lsl	w6,	w23,	#2
    lsl	w8,	w23,	#2
    lsl	w11,	w23,	#2
    movz	w18,	#0
    mov	x2,	x6
    add	x7,	x17,	x8
    add	w23,	w23,	#1
    mov	x26,	x11
    add	x2,	sp,	x2
    add	x26,	sp,	x26
    ldr	w9,	[x7]

    add	x2,	x2,	#1040
    add	x26,	x26,	#1104
    str	w9,	[x2]

    str	w18,	[x26]

    b	main_40

main_49:
    add	x13,	sp,	#1108
    movz	w24,	#1
    sub	w5,	w20,	#1
    movz	w21,	#1
    str	w24,	[x13]

    cmp	w21,	w5
    bgt	main_111

main_53:
    movz	w1,	#1

main_55:
    movz	w23,	#1
    cmp	w23,	w20
    ble	main_58

main_79:
    movz	w17,	#0
    b	main_81

main_58:
    movz	w12,	#65535
    movz	w17,	#0
    movz	w15,	#1

main_60:
    lsl	w9,	w15,	#2
    mov	x8,	x9
    add	x8,	sp,	x8
    add	x8,	x8,	#1040
    ldr	w25,	[x8]

    cmp	w12,	w25
    ble	main_74

main_67:
    lsl	w14,	w15,	#2
    mov	x13,	x14
    add	x13,	sp,	x13
    add	x13,	x13,	#1104
    ldr	w16,	[x13]

    cmp	w16,	#0
    csel	w17,	w15,	w17,	eq
    csel	w12,	w25,	w12,	eq

main_74:
    add	w15,	w15,	#1
    cmp	w15,	w20
    ble	main_60

main_81:
    lsl	w26,	w17,	#2
    movz	w27,	#1
    mov	x3,	x26
    movz	w26,	#1
    add	x3,	sp,	x3
    add	x3,	x3,	#1104
    str	w27,	[x3]

    cmp	w26,	w20
    bgt	main_108

main_85:
    lsl	w0,	w17,	#6
    lsl	w25,	w17,	#2
    movz	w3,	#1
    mov	x19,	x0
    mov	x27,	x25
    add	x19,	sp,	x19
    add	x27,	sp,	x27
    add	x19,	x19,	#16
    add	x27,	x27,	#1040

main_89:
    lsl	w7,	w3,	#2
    movz	w21,	#65535
    add	x6,	x19,	x7
    ldr	w12,	[x6]

    cmp	w12,	w21
    bge	main_103

main_94:
    lsl	w11,	w3,	#2
    mov	x22,	x11
    add	x22,	sp,	x22
    add	x22,	x22,	#1040
    ldr	w11,	[x22]

    ldr	w13,	[x27]

    add	w14,	w13,	w12
    cmp	w11,	w14
    ble	main_103

main_100:
    str	w14,	[x22]


main_103:
    add	w3,	w3,	#1
    cmp	w3,	w20
    ble	main_89

main_108:
    add	w1,	w1,	#1
    cmp	w1,	w5
    ble	main_55

main_112:
    movz	w22,	#1
    b	main_113

main_111:
    movz	w22,	#1

main_113:
    cmp	w22,	w20
    bgt	main_120

main_116:
    lsl	w28,	w22,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	#1040
    ldr	w0,	[x27]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	w22,	w22,	#1
    b	main_113

main_120:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1168
    ret


