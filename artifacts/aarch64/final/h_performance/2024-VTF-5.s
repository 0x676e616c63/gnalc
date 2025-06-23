.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global table
.align	2
table:
    .zero	7840000


.text

.globl main
main:
main_0:
    movz	fp,	#5616
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#5600
    movz	w1,	#0
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
    add	x21,	sp,	#16
    adrp	x23, :got:table
    ldr	x23, [x23, #:got_lo12:table]

main_9:
    add	x16,	x26,	#1
    cmp	x16,	#1400
    bge	main_93

main_13:
    movz	w9,	#5600
    movz	w8,	#5600
    lsl	x5,	x26,	#2
    mov	w20,	w16
    madd	x11,	x26,	x9,	x23

    madd	x25,	x16,	x8,	x23

    add	x4,	x21,	x5
    ldr	w22,	[x4]


main_19:
    sub	w18,	w20,	#1
    cmp	w18,	#0
    blt	main_30

main_23:
    lsl	w28,	w20,	#2
    lsl	w3,	w18,	#2
    add	x28,	x11,	x28
    add	x2,	x11,	x3
    ldr	w7,	[x28]

    ldr	w4,	[x2]

    cmp	w7,	w4
    bge	main_33

main_29:
    str	w4,	[x28]

    b	main_33

main_30:
    lsl	w6,	w20,	#2
    add	x28,	x11,	x6

main_33:
    ldr	w15,	[x28]

    lsl	w10,	w20,	#2
    add	x9,	x25,	x10
    ldr	w12,	[x9]

    cmp	w15,	w12
    bge	main_41

main_39:
    str	w12,	[x28]


main_41:
    cmp	w18,	#0
    blt	main_67

main_43:
    cmp	w26,	w18
    bge	main_58

main_45:
    lsl	w24,	w20,	#2
    add	x17,	x21,	x24
    ldr	w27,	[x17]

    add	w0,	w27,	w22
    cmp	w0,	#3
    lsl	w5,	w18,	#2
    ldr	w27,	[x28]

    cset	w8,	eq
    add	x4,	x25,	x5
    ldr	w17,	[x4]

    add	w7,	w17,	w8
    cmp	w27,	w7
    bge	main_67

main_56:
    add	w7,	w17,	w8
    str	w7,	[x28]

    b	main_67

main_58:
    ldr	w1,	[x28]

    lsl	w10,	w18,	#2
    add	x9,	x25,	x10
    ldr	w12,	[x9]

    cmp	w1,	w12
    bge	main_67

main_63:
    str	w12,	[x28]


main_67:
    cmp	w16,	w20
    bge	main_88

main_69:
    mov	w9,	w16

main_71:
    ldr	w18,	[x28]

    lsl	w0,	w9,	#2
    movz	w2,	#5600
    lsl	w6,	w20,	#2
    add	w9,	w9,	#1
    add	x27,	x11,	x0
    madd	x14,	x9,	x2,	x23

    ldr	w3,	[x27]

    add	x5,	x14,	x6
    ldr	w7,	[x5]

    add	w8,	w7,	w3
    cmp	w18,	w8
    bge	main_84

main_82:
    str	w8,	[x28]


main_84:
    cmp	w9,	w20
    blt	main_71

main_88:
    add	w20,	w20,	#1
    cmp	w20,	#1400
    blt	main_19

main_93:
    sub	w26,	w26,	#1
    cmp	w26,	#0
    bge	main_9

main_96:
    movz	w10,	#0

main_98:
    movz	w24,	#5600
    movz	w8,	#0
    madd	x14,	x10,	x24,	x23


main_101:
    cmp	w8,	#1400
    bge	main_137

main_104:
    lsl	w24,	w8,	#2
    movz	w12,	#10
    add	w4,	w8,	#1
    movz	w9,	#10
    movz	w7,	#10
    add	x1,	x14,	x24
    add	w2,	w4,	#1
    lsl	w21,	w4,	#2
    ldr	w6,	[x1]

    add	x8,	x14,	x21
    sdiv	w28,	w6,	w12
    lsl	w27,	w2,	#2
    lsl	w0,	w28,	#1
    add	w3,	w0,	w28,	lsl #3
    sub	w26,	w6,	w3
    str	w26,	[x1]

    movz	w1,	#10
    ldr	w5,	[x8]

    sdiv	w28,	w5,	w9
    add	x9,	x14,	x27
    lsl	w17,	w28,	#1
    add	w17,	w17,	w28,	lsl #3
    sub	w24,	w5,	w17
    movz	w5,	#10
    str	w24,	[x8]

    add	w24,	w2,	#1
    ldr	w6,	[x9]

    sdiv	w25,	w6,	w7
    lsl	w18,	w25,	#1
    lsl	w3,	w24,	#2
    add	w13,	w18,	w25,	lsl #3
    add	x26,	x14,	x3
    add	w18,	w24,	#1
    movz	w3,	#10
    sub	w0,	w6,	w13
    add	w28,	w18,	#1
    lsl	w8,	w18,	#2
    str	w0,	[x9]

    ldr	w15,	[x26]

    sdiv	w21,	w15,	w5
    lsl	w20,	w21,	#1
    add	w9,	w20,	w21,	lsl #3
    sub	w5,	w15,	w9
    lsl	w15,	w28,	#2
    str	w5,	[x26]

    add	x5,	x14,	x15
    add	x26,	x14,	x8
    ldr	w24,	[x26]

    sdiv	w16,	w24,	w3
    lsl	w21,	w16,	#1
    add	w6,	w21,	w16,	lsl #3
    add	w16,	w28,	#1
    movz	w28,	#10
    sub	w11,	w24,	w6
    lsl	w21,	w16,	#2
    str	w11,	[x26]

    movz	w26,	#10
    ldr	w0,	[x5]

    sdiv	w12,	w0,	w1
    lsl	w22,	w12,	#1
    add	w3,	w22,	w12,	lsl #3
    add	w22,	w16,	#1
    sub	w17,	w0,	w3
    lsl	w27,	w22,	#2
    str	w17,	[x5]

    add	x17,	x14,	x21
    ldr	w6,	[x17]

    sdiv	w8,	w6,	w28
    lsl	w24,	w8,	#1
    add	w0,	w24,	w8,	lsl #3
    add	w8,	w22,	#1
    sub	w24,	w6,	w0
    str	w24,	[x17]

    add	x24,	x14,	x27
    ldr	w16,	[x24]

    sdiv	w5,	w16,	w26
    lsl	w25,	w5,	#1
    add	w26,	w25,	w5,	lsl #3
    sub	w0,	w16,	w26
    str	w0,	[x24]

    b	main_101

main_137:
    add	w10,	w10,	#1
    cmp	w10,	#1400
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


