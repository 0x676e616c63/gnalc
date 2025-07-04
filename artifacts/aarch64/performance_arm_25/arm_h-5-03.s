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
    movz	w1,	#0
    add	x25,	sp,	#16
    adrp	x7, :got:A
    movz	fp,	#11216
    ldr	x7, [x7, #:got_lo12:A]
    add	x6,	sp,	fp
    movz	fp,	#5616
    add	x20,	sp,	fp

main_17:
    movz	w15,	#0
    cmp	x15,	x1
    bge	main_49

main_20:
    movz	w16,	#5600
    movz	w4,	#0
    madd	x9,	x1,	x16,	x7


main_23:
    lsl	x15,	x4,	#2
    movz	w28,	#0
    add	x19,	x9,	x15
    ldr	w22,	[x19]


main_27:
    cmp	x28,	x4
    blt	main_31

main_40:
    movz	w5,	#5600
    lsl	x17,	x4,	#2
    madd	x15,	x4,	x5,	x7

    add	w4,	w4,	#1
    add	x16,	x15,	x17
    ldr	w18,	[x16]

    sdiv	w5,	w22,	w18
    str	w5,	[x19]

    cmp	w4,	w1
    blt	main_23

main_49:
    cmp	x1,	#1400
    bge	main_76

main_51:
    movz	w21,	#5600
    mov	w12,	w1
    madd	x18,	x1,	x21,	x7


main_54:
    lsl	w14,	w12,	#2
    movz	w24,	#0
    add	x28,	x18,	x14
    ldr	w9,	[x28]


main_58:
    cmp	x24,	x1
    blt	main_62

main_71:
    str	w9,	[x28]

    add	w12,	w12,	#1
    cmp	w12,	#1400
    blt	main_54

main_76:
    add	w1,	w1,	#1
    cmp	w1,	#1400
    blt	main_17

main_79:
    movz	w12,	#0

main_81:
    lsl	x13,	x12,	#2
    movz	w23,	#5600
    movz	w5,	#0
    add	x11,	x6,	x13
    madd	x15,	x12,	x23,	x7

    ldr	w0,	[x11]


main_86:
    cmp	w5,	w12
    blt	main_90

main_98:
    lsl	x3,	x12,	#2
    add	w12,	w12,	#1
    add	x2,	x25,	x3
    str	w0,	[x2]

    cmp	w12,	#1400
    blt	main_81

main_102:
    movz	w11,	#1399

main_104:
    lsl	x4,	x11,	#2
    add	w8,	w11,	#1
    movz	w14,	#5600
    add	x3,	x25,	x4
    madd	x21,	x11,	x14,	x7

    ldr	w24,	[x3]


main_110:
    cmp	w8,	#1400
    blt	main_114

main_122:
    lsl	x4,	x11,	#2
    lsl	x6,	x11,	#2
    sub	w11,	w11,	#1
    add	x5,	x21,	x6
    add	x12,	x20,	x4
    ldr	w8,	[x5]

    sdiv	w17,	w24,	w8
    str	w17,	[x12]

    cmp	w11,	#0
    bge	main_104

main_129:
    movz	w0,	#71
    bl	_sysy_stoptime
    mov	x1,	x26
    movz	w0,	#1400
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
    add	x27,	x21,	x28
    ldr	w27,	[x27]

    ldr	w3,	[x1]

    msub	w24,	w3,	w27,	w24

    b	main_110

main_90:
    lsl	w8,	w5,	#2
    lsl	w11,	w5,	#2
    add	w5,	w5,	#1
    add	x10,	x25,	x11
    add	x4,	x15,	x8
    ldr	w19,	[x4]

    ldr	w13,	[x10]

    msub	w0,	w13,	w19,	w0

    b	main_86

main_62:
    lsl	x2,	x24,	#2
    movz	w11,	#5600
    lsl	w10,	w12,	#2
    add	x0,	x18,	x2
    madd	x27,	x24,	x11,	x7

    add	w24,	w24,	#1
    add	x8,	x27,	x10
    ldr	w14,	[x0]

    ldr	w11,	[x8]

    msub	w9,	w11,	w14,	w9

    b	main_58

main_31:
    lsl	x17,	x28,	#2
    movz	w14,	#5600
    lsl	x27,	x4,	#2
    add	x16,	x9,	x17
    madd	x12,	x28,	x14,	x7

    add	w28,	w28,	#1
    add	x24,	x12,	x27
    ldr	w21,	[x16]

    ldr	w0,	[x24]

    msub	w22,	w0,	w21,	w22

    b	main_27

