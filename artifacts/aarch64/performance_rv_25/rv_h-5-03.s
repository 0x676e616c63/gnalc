.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global A
.align	2
A:
.type A, %object
    .zero	7840000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#16816
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#5600
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#5600
    movz	w1,	#0
    movz	fp,	#5616
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#5600
    movz	w1,	#0
    movz	fp,	#11216
    add	x0,	sp,	fp
    bl	memset
    adrp	x0, :got:A
    ldr	x0, [x0, #:got_lo12:A]
    bl	getarray
    movz	fp,	#11216
    add	x0,	sp,	fp
    bl	getarray
    movz	fp,	#5616
    add	x26,	sp,	fp
    mov	x0,	x26
    bl	getarray
    add	x0,	sp,	#16
    bl	getarray
    movz	w0,	#68
    bl	_sysy_starttime
    adrp	x21, :got:A
    movz	w1,	#0
    add	x13,	sp,	#16
    movz	fp,	#11216
    ldr	x21, [x21, #:got_lo12:A]
    add	x17,	sp,	fp
    movz	fp,	#5616
    add	x20,	sp,	fp

main_17:
    movz	w14,	#0
    cmp	x14,	x1
    bge	main_49

main_20:
    movz	w15,	#5600
    movz	w4,	#0
    madd	x7,	x1,	x15,	x21


main_23:
    lsl	x14,	x4,	#2
    movz	w28,	#0
    add	x19,	x7,	x14
    ldr	w22,	[x19]


main_27:
    cmp	x28,	x4
    blt	main_31

main_40:
    movz	w5,	#5600
    lsl	x16,	x4,	#2
    madd	x14,	x4,	x5,	x21

    add	w4,	w4,	#1
    add	x15,	x14,	x16
    ldr	w18,	[x15]

    sdiv	w5,	w22,	w18
    str	w5,	[x19]

    cmp	w4,	w1
    blt	main_23

main_49:
    cmp	x1,	#14
    bge	main_76

main_51:
    movz	w22,	#5600
    mov	w12,	w1
    madd	x19,	x1,	x22,	x21


main_54:
    lsl	w11,	w12,	#2
    movz	w24,	#0
    add	x23,	x19,	x11
    ldr	w9,	[x23]


main_58:
    cmp	x24,	x1
    blt	main_62

main_71:
    str	w9,	[x23]

    add	w12,	w12,	#1
    cmp	w12,	#14
    blt	main_54

main_76:
    add	w1,	w1,	#1
    cmp	w1,	#14
    blt	main_17

main_79:
    movz	w12,	#0

main_81:
    lsl	x10,	x12,	#2
    movz	w24,	#5600
    movz	w5,	#0
    add	x9,	x17,	x10
    madd	x14,	x12,	x24,	x21

    ldr	w0,	[x9]


main_86:
    cmp	w5,	w12
    blt	main_90

main_98:
    lsl	x3,	x12,	#2
    add	w12,	w12,	#1
    add	x2,	x13,	x3
    str	w0,	[x2]

    cmp	w12,	#14
    blt	main_81

main_102:
    movz	w10,	#13

main_104:
    lsl	x4,	x10,	#2
    add	w8,	w10,	#1
    movz	w14,	#5600
    add	x3,	x13,	x4
    madd	x22,	x10,	x14,	x21

    ldr	w25,	[x3]


main_110:
    cmp	w8,	#14
    blt	main_114

main_122:
    lsl	x4,	x10,	#2
    lsl	x6,	x10,	#2
    sub	w10,	w10,	#1
    add	x5,	x22,	x6
    add	x11,	x20,	x4
    ldr	w7,	[x5]

    sdiv	w17,	w25,	w7
    str	w17,	[x11]

    cmp	w10,	#0
    bge	main_104

main_129:
    movz	w0,	#71
    bl	_sysy_stoptime
    mov	x1,	x26
    movz	w0,	#14
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#16816
    add	sp, sp, fp
    ret


main_114:
    lsl	w28,	w8,	#2
    lsl	w2,	w8,	#2
    add	w8,	w8,	#1
    add	x1,	x20,	x2
    add	x27,	x22,	x28
    ldr	w27,	[x27]

    ldr	w3,	[x1]

    msub	w25,	w3,	w27,	w25

    b	main_110

main_90:
    lsl	w6,	w5,	#2
    lsl	w9,	w5,	#2
    add	w5,	w5,	#1
    add	x8,	x13,	x9
    add	x4,	x14,	x6
    ldr	w19,	[x4]

    ldr	w10,	[x8]

    msub	w0,	w10,	w19,	w0

    b	main_86

main_62:
    lsl	x2,	x24,	#2
    movz	w11,	#5600
    lsl	w7,	w12,	#2
    add	x0,	x19,	x2
    madd	x27,	x24,	x11,	x21

    add	w24,	w24,	#1
    add	x6,	x27,	x7
    ldr	w3,	[x0]

    ldr	w8,	[x6]

    msub	w9,	w8,	w3,	w9

    b	main_58

main_31:
    lsl	x16,	x28,	#2
    movz	w14,	#5600
    lsl	x27,	x4,	#2
    add	x15,	x7,	x16
    madd	x10,	x28,	x14,	x21

    add	w28,	w28,	#1
    add	x25,	x10,	x27
    ldr	w23,	[x15]

    ldr	w0,	[x25]

    msub	w22,	w0,	w23,	w22

    b	main_27

