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
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#40000
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#40000
    movz	w1,	#0
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
    movz	w25,	#0
    mov	w23,	w0
    cmp	w25,	w24
    bge	main_24

main_7:
    movz	w26,	#0

main_9:
    movz	w10,	#400
    movz	fp,	#14480
    movz	w21,	#0
    movk	fp,	#1,	lsl #16
    mul	w25,	w26,	w10
    mov	x19,	x25
    add	x19,	sp,	x19
    add	x19,	x19,	fp

main_12:
    cmp	w21,	w23
    blt	main_15

main_19:
    add	w26,	w26,	#1
    cmp	w26,	w24
    blt	main_9
    b	main_24

main_15:
    lsl	w18,	w21,	#2
    add	x22,	x19,	x18
    bl	getint
    add	w21,	w21,	#1
    str	w0,	[x22]

    b	main_12

main_24:
    bl	getint
    mov	w26,	w0
    bl	getint
    movz	w18,	#0
    mov	w20,	w0
    cmp	w18,	w26
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
    blt	main_36

main_40:
    add	w28,	w28,	#1
    cmp	w28,	w26
    blt	main_30
    b	main_45

main_36:
    lsl	w22,	w19,	#2
    add	x27,	x25,	x22
    bl	getint
    add	w19,	w19,	#1
    str	w0,	[x27]

    b	main_33

main_45:
    movz	w8,	#0
    cmp	w8,	w24
    bge	main_82

main_47:
    movz	w3,	#0

main_49:
    movz	w16,	#0
    cmp	w16,	w20
    bge	main_77

main_52:
    movz	w18,	#400
    movz	w17,	#400
    movz	fp,	#14480
    movz	w12,	#0
    mul	w22,	w3,	w18
    mul	w2,	w3,	w17
    movk	fp,	#1,	lsl #16
    mov	x18,	x22
    mov	x2,	x2
    add	x18,	sp,	x18
    add	x2,	sp,	x2
    add	x18,	x18,	#16
    add	x2,	x2,	fp

main_56:
    lsl	w25,	w12,	#2
    movz	w9,	#0
    add	x5,	x18,	x25

main_59:
    cmp	w9,	w23
    blt	main_62

main_72:
    add	w12,	w12,	#1
    cmp	w12,	w20
    blt	main_56

main_77:
    add	w3,	w3,	#1
    cmp	w3,	w24
    blt	main_49
    b	main_82

main_62:
    ldr	w0,	[x5]

    lsl	w15,	w9,	#2
    movz	w28,	#400
    movz	fp,	#40016
    lsl	w22,	w12,	#2
    add	x14,	x2,	x15
    mul	w19,	w9,	w28
    add	w9,	w9,	#1
    mov	x10,	x19
    ldr	w6,	[x14]

    add	x10,	sp,	x10
    add	x10,	x10,	fp
    add	x21,	x10,	x22
    ldr	w25,	[x21]

    madd	w27,	w25,	w6,	w0

    str	w27,	[x5]

    b	main_59

main_82:
    movz	w1,	#0
    cmp	w1,	w24
    bge	main_101

main_84:
    movz	w26,	#0

main_86:
    movz	w17,	#400
    movz	w28,	#0
    mul	w14,	w26,	w17
    mov	x27,	x14
    add	x27,	sp,	x27
    add	x27,	x27,	#16

main_89:
    cmp	w28,	w20
    blt	main_92

main_96:
    movz	w0,	#10
    bl	putch
    add	w26,	w26,	#1
    cmp	w26,	w24
    blt	main_86
    b	main_101

main_92:
    lsl	w19,	w28,	#2
    add	x18,	x27,	x19
    ldr	w0,	[x18]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	w28,	w28,	#1
    b	main_89

main_101:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#54480
    movk	fp,	#1,	lsl #16
    add	sp, sp, fp
    ret


