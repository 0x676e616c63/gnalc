.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global table
.align	2
table:
.type table, %object
    .zero	7840000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#5616
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#5600
    add	x0,	sp,	#16
    bl	memset
    add	x0,	sp,	#16
    bl	getarray
    adrp	x19, :got:table
    ldr	x19, [x19, #:got_lo12:table]
    mov	x0,	x19
    bl	getarray
    movz	w0,	#79
    bl	_sysy_starttime
    movz	w26,	#1399
    add	x6,	sp,	#16
    adrp	x22, :got:table
    ldr	x22, [x22, #:got_lo12:table]

main_9:
    add	x17,	x26,	#1
    cmp	x17,	#1400
    bge	main_93

main_13:
    movz	w9,	#5600
    movz	w8,	#5600
    lsl	x5,	x26,	#2
    mov	w7,	w17
    madd	x13,	x26,	x9,	x22

    madd	x25,	x17,	x8,	x22

    add	x4,	x6,	x5
    ldr	w23,	[x4]


main_19:
    sub	w21,	w7,	#1
    cmp	w21,	#0
    bge	main_23

main_30:
    lsl	w28,	w7,	#2
    add	x28,	x13,	x28
    b	main_33

main_23:
    lsl	w1,	w7,	#2
    lsl	w5,	w21,	#2
    add	x28,	x13,	x1
    add	x4,	x13,	x5
    ldr	w11,	[x28]

    ldr	w8,	[x4]

    cmp	w11,	w8
    bge	main_33

main_29:
    str	w8,	[x28]


main_33:
    ldr	w18,	[x28]

    lsl	w12,	w7,	#2
    add	x11,	x25,	x12
    ldr	w14,	[x11]

    cmp	w18,	w14
    bge	main_41

main_39:
    str	w14,	[x28]


main_41:
    cmp	w21,	#0
    blt	main_67

main_43:
    cmp	w26,	w21
    blt	main_45

main_58:
    ldr	w14,	[x28]

    lsl	w21,	w21,	#2
    add	x20,	x25,	x21
    ldr	w24,	[x20]

    cmp	w14,	w24
    bge	main_67

main_63:
    str	w24,	[x28]

    b	main_67

main_45:
    lsl	w3,	w7,	#2
    add	x2,	x6,	x3
    ldr	w4,	[x2]

    add	w5,	w4,	w23
    cmp	w5,	#3
    lsl	w12,	w21,	#2
    ldr	w5,	[x28]

    cset	w14,	eq
    add	x11,	x25,	x12
    ldr	w1,	[x11]

    add	w16,	w1,	w14
    cmp	w5,	w16
    bge	main_67

main_56:
    add	w15,	w1,	w14
    str	w15,	[x28]


main_67:
    cmp	w17,	w7
    bge	main_88

main_69:
    mov	w10,	w17

main_71:
    ldr	w21,	[x28]

    lsl	w0,	w10,	#2
    movz	w2,	#5600
    lsl	w8,	w7,	#2
    add	w10,	w10,	#1
    add	x27,	x13,	x0
    madd	x16,	x10,	x2,	x22

    ldr	w3,	[x27]

    add	x5,	x16,	x8
    ldr	w9,	[x5]

    add	w11,	w9,	w3
    cmp	w21,	w11
    bge	main_84

main_82:
    str	w11,	[x28]


main_84:
    cmp	w10,	w7
    blt	main_71

main_88:
    add	w7,	w7,	#1
    cmp	w7,	#1400
    blt	main_19

main_93:
    sub	w26,	w26,	#1
    cmp	w26,	#0
    bge	main_9

main_96:
    movz	w21,	#0

main_98:
    movz	w24,	#5600
    movz	w25,	#0
    madd	x9,	x21,	x24,	x22


main_101:
    cmp	w25,	#1400
    blt	main_104

main_137:
    add	w21,	w21,	#1
    cmp	w21,	#1400
    blt	main_98

main_140:
    movz	w0,	#81
    bl	_sysy_stoptime
    mov	x1,	x19
    movz	w0,	#59456
    movk	w0,	#29,	lsl #16
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#5616
    add	sp, sp, fp
    ret


main_104:
    lsl	w26,	w25,	#2
    movz	w14,	#10
    add	w27,	w25,	#1
    movz	w12,	#10
    movz	w1,	#10
    add	x4,	x9,	x26
    lsl	w24,	w27,	#2
    ldr	w10,	[x4]

    add	x5,	x9,	x24
    sdiv	w3,	w10,	w14
    lsl	w0,	w3,	#1
    add	w6,	w0,	w3,	lsl #3
    movz	w3,	#10
    sub	w28,	w10,	w6
    movz	w10,	#10
    str	w28,	[x4]

    ldr	w4,	[x5]

    sdiv	w2,	w4,	w12
    lsl	w16,	w2,	#1
    add	w20,	w16,	w2,	lsl #3
    sub	w26,	w4,	w20
    str	w26,	[x5]

    add	w5,	w27,	#1
    add	w27,	w5,	#1
    lsl	w0,	w5,	#2
    add	x12,	x9,	x0
    add	w23,	w27,	#1
    lsl	w5,	w27,	#2
    ldr	w8,	[x12]

    add	x20,	x9,	x5
    lsl	w11,	w23,	#2
    sdiv	w28,	w8,	w10
    movz	w5,	#10
    lsl	w17,	w28,	#1
    add	w16,	w17,	w28,	lsl #3
    add	x28,	x9,	x11
    sub	w2,	w8,	w16
    str	w2,	[x12]

    add	w2,	w23,	#1
    ldr	w16,	[x20]

    sdiv	w25,	w16,	w5
    lsl	w18,	w25,	#1
    add	w13,	w18,	w25,	lsl #3
    sub	w7,	w16,	w13
    lsl	w16,	w2,	#2
    str	w7,	[x20]

    add	x7,	x9,	x16
    ldr	w26,	[x28]

    sdiv	w18,	w26,	w3
    lsl	w20,	w18,	#1
    add	w10,	w20,	w18,	lsl #3
    sub	w13,	w26,	w10
    str	w13,	[x28]

    movz	w28,	#10
    ldr	w3,	[x7]

    sdiv	w15,	w3,	w1
    lsl	w23,	w15,	#1
    add	w6,	w23,	w15,	lsl #3
    sub	w18,	w3,	w6
    str	w18,	[x7]

    add	w18,	w2,	#1
    add	w1,	w18,	#1
    lsl	w24,	w18,	#2
    add	x13,	x9,	x24
    lsl	w0,	w1,	#2
    ldr	w8,	[x13]

    add	x20,	x9,	x0
    sdiv	w12,	w8,	w28
    lsl	w24,	w12,	#1
    add	w3,	w24,	w12,	lsl #3
    sub	w26,	w8,	w3
    str	w26,	[x13]

    movz	w26,	#10
    ldr	w15,	[x20]

    sdiv	w8,	w15,	w26
    lsl	w25,	w8,	#1
    add	w0,	w25,	w8,	lsl #3
    add	w25,	w1,	#1
    sub	w2,	w15,	w0
    str	w2,	[x20]

    b	main_101

