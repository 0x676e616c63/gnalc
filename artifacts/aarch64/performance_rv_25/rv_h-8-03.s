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
    
    movz	w2,	#5600
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    add	x0,	sp,	#16
    bl	getarray
    adrp	x28, :got:table
    ldr	x28, [x28, #:got_lo12:table]
    mov	x0,	x28
    bl	getarray
    movz	w0,	#79
    bl	_sysy_starttime
    movz	w26,	#13
    adrp	x20, :got:table
    add	x3,	sp,	#16
    ldr	x20, [x20, #:got_lo12:table]

main_9:
    add	x16,	x26,	#1
    cmp	x16,	#14
    bge	main_93

main_13:
    movz	w9,	#5600
    movz	w8,	#5600
    lsl	x5,	x26,	#2
    mov	w7,	w16
    madd	x12,	x26,	x9,	x20

    madd	x23,	x16,	x8,	x20

    add	x4,	x3,	x5
    ldr	w21,	[x4]


main_19:
    sub	w19,	w7,	#1
    cmp	w19,	#0
    bge	main_23

main_30:
    lsl	w25,	w7,	#2
    add	x27,	x12,	x25
    b	main_33

main_23:
    lsl	w0,	w7,	#2
    lsl	w5,	w19,	#2
    add	x27,	x12,	x0
    add	x4,	x12,	x5
    ldr	w10,	[x27]

    ldr	w6,	[x4]

    cmp	w10,	w6
    bge	main_33

main_29:
    str	w6,	[x27]


main_33:
    ldr	w17,	[x27]

    lsl	w11,	w7,	#2
    add	x10,	x23,	x11
    ldr	w13,	[x10]

    cmp	w17,	w13
    bge	main_41

main_39:
    str	w13,	[x27]


main_41:
    cmp	w19,	#0
    blt	main_67

main_43:
    cmp	w26,	w19
    blt	main_45

main_58:
    ldr	w13,	[x27]

    lsl	w19,	w19,	#2
    add	x18,	x23,	x19
    ldr	w22,	[x18]

    cmp	w13,	w22
    bge	main_67

main_63:
    str	w22,	[x27]

    b	main_67

main_45:
    lsl	w2,	w7,	#2
    add	x1,	x3,	x2
    ldr	w4,	[x1]

    add	w5,	w4,	w21
    cmp	w5,	#3
    lsl	w11,	w19,	#2
    ldr	w5,	[x27]

    cset	w13,	eq
    add	x10,	x23,	x11
    ldr	w0,	[x10]

    add	w15,	w0,	w13
    cmp	w5,	w15
    bge	main_67

main_56:
    add	w14,	w0,	w13
    str	w14,	[x27]


main_67:
    cmp	w16,	w7
    bge	main_88

main_69:
    mov	w10,	w16

main_71:
    ldr	w18,	[x27]

    lsl	w25,	w10,	#2
    movz	w2,	#5600
    lsl	w6,	w7,	#2
    add	w10,	w10,	#1
    add	x24,	x12,	x25
    madd	x15,	x10,	x2,	x20

    ldr	w1,	[x24]

    add	x5,	x15,	x6
    ldr	w8,	[x5]

    add	w9,	w8,	w1
    cmp	w18,	w9
    bge	main_84

main_82:
    str	w9,	[x27]


main_84:
    cmp	w10,	w7
    blt	main_71

main_88:
    add	w7,	w7,	#1
    cmp	w7,	#14
    blt	main_19

main_93:
    sub	w26,	w26,	#1
    cmp	w26,	#0
    bge	main_9

main_96:
    movz	w1,	#0

main_98:
    movz	w24,	#5600
    movz	w21,	#10
    movz	w19,	#10
    movz	w14,	#10
    movz	w12,	#10
    madd	x17,	x1,	x24,	x20

    add	x9,	x17,	#8
    ldr	w18,	[x17]

    add	x2,	x17,	#28
    add	w1,	w1,	#1
    sdiv	w8,	w18,	w21
    lsl	w6,	w8,	#1
    add	w25,	w6,	w8,	lsl #3
    add	x6,	x17,	#12
    sub	w13,	w18,	w25
    add	x25,	x17,	#4
    str	w13,	[x17]

    ldr	w24,	[x25]

    sdiv	w5,	w24,	w19
    add	x19,	x17,	#24
    lsl	w7,	w5,	#1
    add	w23,	w7,	w5,	lsl #3
    sub	w16,	w24,	w23
    str	w16,	[x25]

    movz	w16,	#10
    ldr	w27,	[x9]

    sdiv	w3,	w27,	w16
    lsl	w8,	w3,	#1
    add	w21,	w8,	w3,	lsl #3
    add	x8,	x17,	#16
    sub	w21,	w27,	w21
    str	w21,	[x9]

    ldr	w4,	[x6]

    sdiv	w0,	w4,	w14
    lsl	w9,	w0,	#1
    add	w18,	w9,	w0,	lsl #3
    sub	w24,	w4,	w18
    movz	w4,	#10
    str	w24,	[x6]

    ldr	w6,	[x8]

    sdiv	w26,	w6,	w12
    lsl	w10,	w26,	#1
    add	w15,	w10,	w26,	lsl #3
    movz	w10,	#10
    sub	w27,	w6,	w15
    add	x15,	x17,	#20
    str	w27,	[x8]

    add	x27,	x17,	#32
    movz	w8,	#10
    ldr	w9,	[x15]

    sdiv	w24,	w9,	w10
    movz	w10,	#10
    lsl	w11,	w24,	#1
    add	w13,	w11,	w24,	lsl #3
    sub	w3,	w9,	w13
    str	w3,	[x15]

    ldr	w15,	[x19]

    sdiv	w22,	w15,	w8
    add	x8,	x17,	#40
    lsl	w12,	w22,	#1
    add	w11,	w12,	w22,	lsl #3
    sub	w6,	w15,	w11
    str	w6,	[x19]

    movz	w6,	#10
    ldr	w21,	[x2]

    sdiv	w19,	w21,	w6
    movz	w6,	#10
    lsl	w13,	w19,	#1
    add	w9,	w13,	w19,	lsl #3
    sub	w9,	w21,	w9
    movz	w21,	#10
    str	w9,	[x2]

    add	x9,	x17,	#36
    ldr	w24,	[x27]

    sdiv	w16,	w24,	w4
    lsl	w14,	w16,	#1
    add	w7,	w14,	w16,	lsl #3
    sub	w12,	w24,	w7
    str	w12,	[x27]

    movz	w12,	#10
    ldr	w27,	[x9]

    sdiv	w13,	w27,	w12
    add	x12,	x17,	#52
    lsl	w15,	w13,	#1
    add	w5,	w15,	w13,	lsl #3
    add	x13,	x17,	#44
    sub	w15,	w27,	w5
    str	w15,	[x9]

    ldr	w4,	[x8]

    sdiv	w11,	w4,	w10
    lsl	w16,	w11,	#1
    add	w3,	w16,	w11,	lsl #3
    sub	w19,	w4,	w3
    str	w19,	[x8]

    movz	w8,	#10
    ldr	w7,	[x13]

    sdiv	w9,	w7,	w8
    lsl	w18,	w9,	#1
    add	w0,	w18,	w9,	lsl #3
    sub	w23,	w7,	w0
    str	w23,	[x13]

    add	x23,	x17,	#48
    ldr	w11,	[x23]

    sdiv	w7,	w11,	w6
    lsl	w19,	w7,	#1
    add	w26,	w19,	w7,	lsl #3
    sub	w26,	w11,	w26
    str	w26,	[x23]

    ldr	w17,	[x12]

    sdiv	w23,	w17,	w21
    lsl	w8,	w23,	#1
    add	w14,	w8,	w23,	lsl #3
    sub	w21,	w17,	w14
    str	w21,	[x12]

    cmp	w1,	#14
    blt	main_98

main_145:
    movz	w0,	#81
    bl	_sysy_stoptime
    mov	x1,	x28
    movz	w0,	#196
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#5616
    add	sp, sp, fp
    ret


