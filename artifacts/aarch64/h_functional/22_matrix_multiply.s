.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#40000
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w1,	#0
    movz	w2,	#40000
    movz	fp,	#40016
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#40000
    movz	w1,	#0
    movz	fp,	#14480
    movk	fp,	#1,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    bl	getint
    mov	w24,	w0
    bl	getint
    movz	w23,	#0
    mov	w27,	w0
    cmp	w23,	w24
    bge	main_24

main_7:
    movz	w20,	#0

main_9:
    movz	w10,	#400
    movz	fp,	#14480
    movz	w26,	#0
    movk	fp,	#1,	lsl #16
    mul	w25,	w20,	w10
    mov	x19,	x25
    add	x19,	sp,	x19
    add	x19,	x19,	fp

main_12:
    cmp	w26,	w27
    bge	main_19

main_15:
    lsl	w25,	w26,	#2
    add	x28,	x19,	x25
    bl	getint
    add	w26,	w26,	#1
    str	w0,	[x28]

    b	main_12

main_19:
    add	w20,	w20,	#1
    cmp	w20,	w24
    blt	main_9

main_24:
    bl	getint
    mov	w23,	w0
    bl	getint
    movz	w18,	#0
    mov	w20,	w0
    cmp	w18,	w23
    bge	main_45

main_28:
    movz	w28,	#0

main_30:
    movz	w12,	#400
    movz	fp,	#40016
    movz	w19,	#0
    mul	w5,	w28,	w12
    mov	x25,	x5
    add	x25,	sp,	x25
    add	x25,	x25,	fp

main_33:
    cmp	w19,	w20
    bge	main_40

main_36:
    lsl	w18,	w19,	#2
    add	x26,	x25,	x18
    bl	getint
    add	w19,	w19,	#1
    str	w0,	[x26]

    b	main_33

main_40:
    add	w28,	w28,	#1
    cmp	w28,	w23
    blt	main_30

main_45:
    movz	w8,	#0
    cmp	w8,	w24
    bge	main_82

main_47:
    movz	w23,	#0

main_49:
    movz	w15,	#0
    cmp	w15,	w20
    bge	main_77

main_52:
    movz	w17,	#400
    movz	w16,	#400
    movz	fp,	#14480
    movz	w8,	#0
    mul	w21,	w23,	w17
    mul	w2,	w23,	w16
    movk	fp,	#1,	lsl #16
    mov	x17,	x21
    mov	x2,	x2
    add	x17,	sp,	x17
    add	x2,	sp,	x2
    add	x17,	x17,	#16
    add	x2,	x2,	fp

main_56:
    lsl	w22,	w8,	#2
    movz	w5,	#0
    add	x6,	x17,	x22

main_59:
    cmp	w5,	w27
    bge	main_72

main_62:
    ldr	w21,	[x6]

    lsl	w10,	w5,	#2
    movz	w22,	#400
    movz	fp,	#40016
    lsl	w15,	w8,	#2
    add	x9,	x2,	x10
    mul	w13,	w5,	w22
    add	w5,	w5,	#1
    mov	x4,	x13
    ldr	w1,	[x9]

    add	x4,	sp,	x4
    add	x4,	x4,	fp
    add	x14,	x4,	x15
    ldr	w16,	[x14]

    madd	w19,	w16,	w1,	w21

    str	w19,	[x6]

    b	main_59

main_72:
    add	w8,	w8,	#1
    cmp	w8,	w20
    blt	main_56

main_77:
    add	w23,	w23,	#1
    cmp	w23,	w24
    blt	main_49

main_82:
    movz	w1,	#0
    cmp	w1,	w24
    bge	main_101

main_84:
    movz	w27,	#0

main_86:
    movz	w17,	#400
    movz	w28,	#0
    mul	w14,	w27,	w17
    mov	x26,	x14
    add	x26,	sp,	x26
    add	x26,	x26,	#16

main_89:
    cmp	w28,	w20
    bge	main_96

main_92:
    lsl	w0,	w28,	#2
    add	x25,	x26,	x0
    ldr	w0,	[x25]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	w28,	w28,	#1
    b	main_89

main_96:
    movz	w0,	#10
    bl	putch
    add	w27,	w27,	#1
    cmp	w27,	w24
    blt	main_86

main_101:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    add	sp, sp, fp
    ret


