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
    adrp	x28, :got:table
    ldr	x28, [x28, #:got_lo12:table]
    mov	x0,	x28
    bl	getarray
    movz	w0,	#79
    bl	_sysy_starttime
    movz	w18,	#13
    adrp	x20, :got:table
    add	x3,	sp,	#16
    ldr	x20, [x20, #:got_lo12:table]

main_9:
    add	x16,	x18,	#1
    cmp	x16,	#14
    bge	main_93

main_13:
    movz	w9,	#5600
    movz	w8,	#5600
    lsl	x5,	x18,	#2
    madd	x12,	x18,	x9,	x20

    madd	x24,	x16,	x8,	x20

    add	x4,	x3,	x5
    ldr	w22,	[x4]

    mov	w4,	w16

main_19:
    sub	w21,	w4,	#1
    cmp	w21,	#0
    blt	main_30

main_23:
    lsl	w26,	w4,	#2
    lsl	w2,	w21,	#2
    add	x27,	x12,	x26
    add	x1,	x12,	x2
    ldr	w8,	[x27]

    ldr	w5,	[x1]

    cmp	w8,	w5
    bge	main_33

main_29:
    str	w5,	[x27]

    b	main_33

main_30:
    lsl	w7,	w4,	#2
    add	x27,	x12,	x7

main_33:
    ldr	w17,	[x27]

    lsl	w11,	w4,	#2
    add	x10,	x24,	x11
    ldr	w13,	[x10]

    cmp	w17,	w13
    bge	main_41

main_39:
    str	w13,	[x27]


main_41:
    cmp	w21,	#0
    blt	main_67

main_43:
    cmp	w18,	w21
    bge	main_58

main_45:
    lsl	w23,	w4,	#2
    add	x19,	x3,	x23
    ldr	w25,	[x19]

    add	w26,	w25,	w22
    cmp	w26,	#3
    lsl	w6,	w21,	#2
    ldr	w25,	[x27]

    cset	w8,	eq
    add	x5,	x24,	x6
    ldr	w19,	[x5]

    add	w9,	w19,	w8
    cmp	w25,	w9
    bge	main_67

main_56:
    add	w8,	w19,	w8
    str	w8,	[x27]

    b	main_67

main_58:
    ldr	w0,	[x27]

    lsl	w11,	w21,	#2
    add	x10,	x24,	x11
    ldr	w13,	[x10]

    cmp	w0,	w13
    bge	main_67

main_63:
    str	w13,	[x27]


main_67:
    cmp	w16,	w4
    bge	main_88

main_69:
    mov	w10,	w16

main_71:
    ldr	w19,	[x27]

    lsl	w26,	w10,	#2
    movz	w2,	#5600
    lsl	w7,	w4,	#2
    add	w10,	w10,	#1
    add	x25,	x12,	x26
    madd	x15,	x10,	x2,	x20

    ldr	w1,	[x25]

    add	x6,	x15,	x7
    ldr	w8,	[x6]

    add	w9,	w8,	w1
    cmp	w19,	w9
    bge	main_84

main_82:
    str	w9,	[x27]


main_84:
    cmp	w10,	w4
    blt	main_71

main_88:
    add	w4,	w4,	#1
    cmp	w4,	#14
    blt	main_19

main_93:
    sub	w18,	w18,	#1
    cmp	w18,	#0
    bge	main_9

main_96:
    movz	w10,	#0

main_98:
    movz	w24,	#5600
    movz	w21,	#10
    movz	w19,	#10
    movz	w14,	#10
    movz	w12,	#10
    madd	x17,	x10,	x24,	x20

    add	w10,	w10,	#1
    add	x1,	x17,	#28
    add	x8,	x17,	#8
    ldr	w18,	[x17]

    sdiv	w7,	w18,	w21
    lsl	w5,	w7,	#1
    add	w25,	w5,	w7,	lsl #3
    add	x5,	x17,	#12
    sub	w13,	w18,	w25
    add	x25,	x17,	#4
    str	w13,	[x17]

    ldr	w24,	[x25]

    sdiv	w4,	w24,	w19
    add	x19,	x17,	#24
    lsl	w6,	w4,	#1
    add	w23,	w6,	w4,	lsl #3
    sub	w16,	w24,	w23
    str	w16,	[x25]

    movz	w16,	#10
    ldr	w27,	[x8]

    sdiv	w2,	w27,	w16
    lsl	w7,	w2,	#1
    add	w21,	w7,	w2,	lsl #3
    add	x7,	x17,	#16
    sub	w21,	w27,	w21
    str	w21,	[x8]

    ldr	w3,	[x5]

    sdiv	w0,	w3,	w14
    lsl	w8,	w0,	#1
    add	w18,	w8,	w0,	lsl #3
    sub	w24,	w3,	w18
    movz	w3,	#10
    str	w24,	[x5]

    ldr	w5,	[x7]

    sdiv	w26,	w5,	w12
    lsl	w9,	w26,	#1
    add	w15,	w9,	w26,	lsl #3
    movz	w9,	#10
    sub	w27,	w5,	w15
    add	x15,	x17,	#20
    str	w27,	[x7]

    add	x27,	x17,	#32
    movz	w7,	#10
    ldr	w8,	[x15]

    sdiv	w24,	w8,	w9
    add	x9,	x17,	#36
    lsl	w11,	w24,	#1
    add	w13,	w11,	w24,	lsl #3
    sub	w2,	w8,	w13
    str	w2,	[x15]

    ldr	w15,	[x19]

    sdiv	w22,	w15,	w7
    add	x7,	x17,	#40
    lsl	w12,	w22,	#1
    add	w11,	w12,	w22,	lsl #3
    sub	w5,	w15,	w11
    str	w5,	[x19]

    movz	w5,	#10
    ldr	w21,	[x1]

    sdiv	w19,	w21,	w5
    movz	w5,	#10
    lsl	w13,	w19,	#1
    add	w8,	w13,	w19,	lsl #3
    sub	w8,	w21,	w8
    movz	w21,	#10
    str	w8,	[x1]

    movz	w1,	#10
    ldr	w24,	[x27]

    sdiv	w16,	w24,	w3
    lsl	w14,	w16,	#1
    add	w6,	w14,	w16,	lsl #3
    sub	w12,	w24,	w6
    str	w12,	[x27]

    add	x12,	x17,	#52
    ldr	w27,	[x9]

    sdiv	w13,	w27,	w1
    lsl	w15,	w13,	#1
    add	w4,	w15,	w13,	lsl #3
    add	x13,	x17,	#44
    sub	w15,	w27,	w4
    movz	w27,	#10
    str	w15,	[x9]

    ldr	w3,	[x7]

    sdiv	w11,	w3,	w27
    lsl	w16,	w11,	#1
    add	w2,	w16,	w11,	lsl #3
    sub	w19,	w3,	w2
    str	w19,	[x7]

    movz	w7,	#10
    ldr	w6,	[x13]

    sdiv	w8,	w6,	w7
    lsl	w18,	w8,	#1
    add	w0,	w18,	w8,	lsl #3
    sub	w23,	w6,	w0
    str	w23,	[x13]

    add	x23,	x17,	#48
    ldr	w11,	[x23]

    sdiv	w6,	w11,	w5
    lsl	w19,	w6,	#1
    add	w26,	w19,	w6,	lsl #3
    sub	w26,	w11,	w26
    str	w26,	[x23]

    ldr	w17,	[x12]

    sdiv	w23,	w17,	w21
    lsl	w7,	w23,	#1
    add	w14,	w7,	w23,	lsl #3
    sub	w21,	w17,	w14
    str	w21,	[x12]

    cmp	w10,	#14
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


