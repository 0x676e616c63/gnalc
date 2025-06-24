.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl QuickSort
QuickSort:
QuickSort_3:
    sub	sp, sp, #80
    stp	x19, x20, [sp, #0]
    stp	x22, x23, [sp, #16]
    stp	x26, x27, [sp, #32]
    stp	x28, fp, [sp, #48]
    str	lr, [sp, 64]

    mov	w20,	w2
    mov	x28,	x0
    cmp	w1,	w20
    bge	QuickSort_69

QuickSort_5:
    lsl	w17,	w1,	#2
    add	x14,	x28,	x17
    ldr	w15,	[x14]

    cmp	w1,	w20
    bge	QuickSort_58

QuickSort_9:
    sub	w17,	w15,	#1
    mov	w27,	w1
    mov	w12,	w20

QuickSort_16:
    cmp	w27,	w12
    bge	QuickSort_26

QuickSort_19:
    lsl	w3,	w12,	#2
    sub	w7,	w12,	#1
    add	x2,	x28,	x3
    ldr	w23,	[x2]

    cmp	w23,	w17
    ble	QuickSort_26

QuickSort_15:
    mov	w12,	w7
    b	QuickSort_16

QuickSort_26:
    cmp	w27,	w12
    bge	QuickSort_37

QuickSort_28:
    lsl	w9,	w27,	#2
    lsl	w11,	w12,	#2
    add	w27,	w27,	#1
    add	x23,	x28,	x9
    add	x10,	x28,	x11
    ldr	w13,	[x10]

    str	w13,	[x23]


QuickSort_37:
    cmp	w27,	w12
    bge	QuickSort_47

QuickSort_40:
    lsl	w19,	w27,	#2
    add	w22,	w27,	#1
    add	x18,	x28,	x19
    ldr	w10,	[x18]

    cmp	w10,	w15
    bge	QuickSort_47

QuickSort_36:
    mov	w27,	w22
    b	QuickSort_37

QuickSort_47:
    cmp	w27,	w12
    bge	QuickSort_55

QuickSort_49:
    lsl	w26,	w12,	#2
    lsl	w2,	w27,	#2
    sub	w12,	w12,	#1
    add	x14,	x28,	x26
    add	x0,	x28,	x2
    ldr	w3,	[x0]

    str	w3,	[x14]


QuickSort_55:
    cmp	w27,	w12
    blt	QuickSort_16

QuickSort_66:
    lsl	w7,	w27,	#2
    add	x14,	x28,	x7
    b	QuickSort_59

QuickSort_58:
    mov	w27,	w1

QuickSort_59:
    str	w15,	[x14]

    sub	w2,	w27,	#1
    mov	x0,	x28
    bl	QuickSort
    mov	w2,	w20
    mov	x0,	x28
    add	w1,	w27,	#1
    bl	QuickSort

QuickSort_69:
    movz	w0,	#0
    ldp	x19, x20, [sp, #0]
    ldp	x22, x23, [sp, #16]
    ldp	x26, x27, [sp, #32]
    ldp	x28, fp, [sp, #48]
    ldr	lr, [sp, 64]

    add	sp, sp, #80
    ret


.globl main
main:
main_0:
    movz	fp,	#4272
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	fp,	#4144
    movz	w0,	#36
    add	x9,	sp,	#52
    add	x8,	sp,	#48
    movz	w20,	#5
    add	x3,	sp,	#28
    add	x7,	sp,	#44
    movz	w23,	#282
    movz	w28,	#7
    add	x4,	sp,	#32
    movz	w16,	#905
    movz	w19,	#83
    add	x1,	sp,	#20
    add	x13,	sp,	#68
    add	x2,	sp,	#24
    movz	w25,	#89
    movz	w18,	#273
    add	x6,	sp,	#40
    add	x10,	sp,	#56
    movz	w21,	#27
    movz	w26,	#23
    movz	w24,	#26
    add	x27,	sp,	#16
    movz	w17,	#574
    add	x11,	sp,	#60
    add	x12,	sp,	#64
    movz	w15,	#354
    add	x5,	sp,	#36
    movz	w14,	#657
    movz	w22,	#254
    str	w28,	[x27]

    add	x28,	sp,	#120
    str	w26,	[x1]

    movz	w1,	#96
    add	x26,	sp,	#116
    str	w25,	[x2]

    add	x25,	sp,	#112
    movz	w2,	#87
    str	w24,	[x3]

    movz	w3,	#58
    add	x24,	sp,	#108
    str	w23,	[x4]

    movz	w4,	#279
    add	x23,	sp,	#104
    str	w22,	[x5]

    movz	w5,	#452
    add	x22,	sp,	#100
    str	w21,	[x6]

    movz	w6,	#756
    add	x21,	sp,	#96
    str	w20,	[x7]

    movz	w7,	#929
    add	x20,	sp,	#92
    str	w19,	[x8]

    movz	w8,	#68
    add	x19,	sp,	#88
    str	w18,	[x9]

    movz	w9,	#29
    add	x18,	sp,	#84
    str	w17,	[x10]

    movz	w10,	#459
    add	x17,	sp,	#80
    str	w16,	[x11]

    movz	w11,	#639
    add	x16,	sp,	#76
    str	w15,	[x12]

    movz	w12,	#264
    add	x15,	sp,	#72
    str	w14,	[x13]

    movz	w14,	#0
    movz	w13,	#935
    str	w13,	[x15]

    str	w12,	[x16]

    str	w11,	[x17]

    str	w10,	[x18]

    str	w9,	[x19]

    str	w8,	[x20]

    str	w7,	[x21]

    str	w6,	[x22]

    str	w5,	[x23]

    str	w4,	[x24]

    movz	w24,	#290
    add	x4,	sp,	#140
    str	w3,	[x25]

    movz	w25,	#1
    add	x3,	sp,	#136
    str	w2,	[x26]

    movz	w26,	#28
    add	x2,	sp,	#132
    str	w1,	[x28]

    movz	w28,	#39
    add	x1,	sp,	#124
    str	w0,	[x1]

    add	x1,	sp,	#128
    str	w28,	[x1]

    str	w26,	[x2]

    str	w25,	[x3]

    add	x25,	sp,	fp
    str	w24,	[x4]


main_37:
    cmp	w14,	#32
    bge	main_73

main_40:
    lsl	w28,	w14,	#2
    lsl	w1,	w14,	#2
    add	w7,	w14,	#1
    add	x16,	x25,	x28
    add	x0,	x27,	x1
    lsl	w14,	w7,	#2
    ldr	w2,	[x0]

    add	x26,	x25,	x14
    str	w2,	[x16]

    add	w14,	w7,	#1
    lsl	w16,	w7,	#2
    add	x15,	x27,	x16
    lsl	w22,	w14,	#2
    lsl	w20,	w14,	#2
    ldr	w17,	[x15]

    add	x21,	x27,	x22
    add	x4,	x25,	x20
    str	w17,	[x26]

    ldr	w23,	[x21]

    str	w23,	[x4]

    add	w23,	w14,	#1
    add	w3,	w23,	#1
    lsl	w1,	w23,	#2
    lsl	w28,	w23,	#2
    add	x0,	x27,	x1
    add	w9,	w3,	#1
    lsl	w7,	w3,	#2
    lsl	w5,	w3,	#2
    add	x13,	x25,	x28
    ldr	w2,	[x0]

    add	x6,	x27,	x7
    add	w16,	w9,	#1
    lsl	w11,	w9,	#2
    add	x19,	x25,	x5
    str	w2,	[x13]

    add	x26,	x25,	x11
    lsl	w13,	w9,	#2
    add	w22,	w16,	#1
    lsl	w17,	w16,	#2
    ldr	w8,	[x6]

    add	x12,	x27,	x13
    add	x4,	x25,	x17
    str	w8,	[x19]

    lsl	w23,	w22,	#2
    lsl	w19,	w16,	#2
    ldr	w14,	[x12]

    add	x10,	x25,	x23
    add	x18,	x27,	x19
    str	w14,	[x26]

    add	w14,	w22,	#1
    lsl	w26,	w22,	#2
    ldr	w20,	[x18]

    add	x24,	x27,	x26
    str	w20,	[x4]

    ldr	w28,	[x24]

    str	w28,	[x10]

    b	main_37

main_73:
    movz	w23,	#0

main_74:
    cmp	w23,	#32
    bge	main_102

main_77:
    lsl	w20,	w23,	#2
    movz	fp,	#4144
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    add	w21,	w23,	#1
    movz	fp,	#4144
    lsl	w23,	w21,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w0,	[x22]

    bl	putint
    add	w20,	w21,	#1
    movz	fp,	#4144
    lsl	w0,	w20,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    ldr	w0,	[x28]

    bl	putint
    movz	fp,	#4144
    add	w26,	w20,	#1
    lsl	w21,	w26,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w0,	[x20]

    bl	putint
    movz	fp,	#4144
    add	w21,	w26,	#1
    lsl	w26,	w21,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    movz	fp,	#4144
    add	w28,	w21,	#1
    lsl	w19,	w28,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    ldr	w0,	[x18]

    bl	putint
    movz	fp,	#4144
    add	w26,	w28,	#1
    lsl	w23,	w26,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w0,	[x22]

    bl	putint
    movz	fp,	#4144
    add	w19,	w26,	#1
    lsl	w0,	w19,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    ldr	w0,	[x28]

    bl	putint
    add	w23,	w19,	#1
    b	main_74

main_102:
    movz	w16,	#0

main_104:
    movz	w15,	#32
    movz	w14,	#0
    sub	w1,	w15,	w16
    sub	w12,	w1,	#1
    cmp	w14,	w12
    bge	main_125

main_109:
    movz	w4,	#0

main_111:
    lsl	w19,	w4,	#2
    add	w4,	w4,	#1
    add	x2,	x25,	x19
    lsl	w23,	w4,	#2
    ldr	w0,	[x2]

    add	x9,	x25,	x23
    ldr	w24,	[x9]

    cmp	w0,	w24
    ble	main_121

main_119:
    str	w0,	[x9]

    str	w24,	[x2]


main_121:
    cmp	w4,	w12
    blt	main_111

main_125:
    add	w16,	w16,	#1
    cmp	w16,	#31
    blt	main_104

main_128:
    movz	w28,	#0

main_129:
    cmp	w28,	#32
    bge	main_157

main_132:
    lsl	w22,	w28,	#2
    movz	fp,	#4144
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    add	w22,	w28,	#1
    movz	fp,	#4144
    lsl	w20,	w22,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    add	w28,	w22,	#1
    movz	fp,	#4144
    lsl	w24,	w28,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    movz	fp,	#4144
    add	w22,	w28,	#1
    lsl	w18,	w22,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w20,	w22,	#1
    lsl	w22,	w20,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w24,	w20,	#1
    lsl	w28,	w24,	#2
    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    ldr	w0,	[x26]

    bl	putint
    movz	fp,	#4144
    add	w24,	w24,	#1
    lsl	w20,	w24,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    movz	fp,	#4144
    add	w20,	w24,	#1
    lsl	w24,	w20,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    add	w28,	w20,	#1
    b	main_129

main_157:
    add	x0,	x25,	#64
    add	x19,	x25,	#60
    ldr	w18,	[x0]

    ldr	w20,	[x19]

    add	w22,	w20,	w18
    asr	w28,	w22,	#31
    lsr	w0,	w28,	#31
    add	w18,	w22,	w0
    asr	w0,	w18,	#1
    bl	putint
    movz	w20,	#0

main_164:
    cmp	w20,	#952
    bge	main_282

main_167:
    lsl	w4,	w20,	#2
    movz	w7,	#0
    add	w10,	w20,	#1
    movz	w21,	#0
    movz	w19,	#0
    movz	w15,	#0
    movz	w3,	#0
    mov	x18,	x4
    add	w13,	w10,	#1
    lsl	w11,	w10,	#2
    add	x18,	sp,	x18
    movz	w10,	#0
    mov	x6,	x11
    add	w0,	w13,	#1
    lsl	w14,	w13,	#2
    add	x18,	x18,	#144
    movz	w11,	#0
    add	x6,	sp,	x6
    movz	w13,	#0
    mov	x9,	x14
    lsl	w17,	w0,	#2
    str	w7,	[x18]

    add	x9,	sp,	x9
    add	x6,	x6,	#144
    mov	x12,	x17
    movz	w7,	#0
    movz	w17,	#0
    add	x9,	x9,	#144
    add	x12,	sp,	x12
    str	w21,	[x6]

    movz	w6,	#0
    add	w21,	w0,	#1
    add	x12,	x12,	#144
    str	w19,	[x9]

    movz	w9,	#0
    add	w24,	w21,	#1
    lsl	w20,	w21,	#2
    str	w17,	[x12]

    mov	x16,	x20
    add	x16,	sp,	x16
    add	w0,	w24,	#1
    lsl	w23,	w24,	#2
    movz	w24,	#0
    mov	x19,	x23
    add	x16,	x16,	#144
    add	x19,	sp,	x19
    add	w4,	w0,	#1
    lsl	w28,	w0,	#2
    mov	x22,	x28
    str	w15,	[x16]

    add	x19,	x19,	#144
    lsl	w2,	w4,	#2
    movz	w28,	#0
    add	x22,	sp,	x22
    mov	x26,	x2
    str	w13,	[x19]

    add	x26,	sp,	x26
    add	x22,	x22,	#144
    add	x26,	x26,	#144
    str	w11,	[x22]

    movz	w22,	#0
    str	w9,	[x26]

    movz	w26,	#0
    add	w9,	w4,	#1
    add	w12,	w9,	#1
    lsl	w5,	w9,	#2
    mov	x1,	x5
    movz	w5,	#0
    add	x1,	sp,	x1
    add	w15,	w12,	#1
    lsl	w8,	w12,	#2
    movz	w12,	#0
    mov	x4,	x8
    add	x1,	x1,	#144
    add	x4,	sp,	x4
    add	w18,	w15,	#1
    lsl	w11,	w15,	#2
    mov	x8,	x11
    str	w7,	[x1]

    add	x4,	x4,	#144
    add	w20,	w18,	#1
    lsl	w14,	w18,	#2
    add	x8,	sp,	x8
    movz	w1,	#0
    str	w5,	[x4]

    movz	w18,	#0
    mov	x11,	x14
    add	w23,	w20,	#1
    lsl	w17,	w20,	#2
    add	x8,	x8,	#144
    movz	w4,	#0
    movz	w14,	#0
    add	x11,	sp,	x11
    add	w0,	w23,	#1
    lsl	w20,	w23,	#2
    mov	x13,	x17
    str	w3,	[x8]

    mov	x16,	x20
    add	x11,	x11,	#144
    add	x13,	sp,	x13
    lsl	w23,	w0,	#2
    add	w3,	w0,	#1
    movz	w20,	#0
    add	x16,	sp,	x16
    str	w1,	[x11]

    add	x13,	x13,	#144
    mov	x19,	x23
    add	w7,	w3,	#1
    add	x16,	x16,	#144
    add	x19,	sp,	x19
    str	w28,	[x13]

    add	w11,	w7,	#1
    lsl	w2,	w7,	#2
    add	x19,	x19,	#144
    lsl	w28,	w3,	#2
    movz	w13,	#0
    str	w24,	[x16]

    add	w15,	w11,	#1
    lsl	w5,	w11,	#2
    mov	x23,	x28
    movz	w16,	#0
    str	w22,	[x19]

    mov	x28,	x2
    lsl	w8,	w15,	#2
    add	x23,	sp,	x23
    movz	w19,	#0
    mov	x2,	x5
    add	x28,	sp,	x28
    mov	x5,	x8
    add	x23,	x23,	#144
    add	x2,	sp,	x2
    add	x5,	sp,	x5
    add	x28,	x28,	#144
    str	w20,	[x23]

    add	x2,	x2,	#144
    add	x5,	x5,	#144
    str	w18,	[x28]

    add	w18,	w15,	#1
    str	w16,	[x2]

    movz	w2,	#0
    str	w14,	[x5]

    add	w21,	w18,	#1
    lsl	w11,	w18,	#2
    mov	x8,	x11
    add	x8,	sp,	x8
    add	w24,	w21,	#1
    lsl	w14,	w21,	#2
    add	x8,	x8,	#144
    add	w0,	w24,	#1
    lsl	w17,	w24,	#2
    mov	x15,	x17
    str	w12,	[x8]

    add	x15,	sp,	x15
    add	w3,	w0,	#1
    lsl	w20,	w0,	#2
    movz	w8,	#0
    mov	x12,	x14
    add	x15,	x15,	#144
    movz	w0,	#0
    mov	x18,	x20
    add	w7,	w3,	#1
    lsl	w23,	w3,	#2
    add	x12,	sp,	x12
    add	x18,	sp,	x18
    mov	x21,	x23
    lsl	w28,	w7,	#2
    movz	w23,	#0
    add	x12,	x12,	#144
    add	x21,	sp,	x21
    add	x18,	x18,	#144
    mov	x24,	x28
    add	x24,	sp,	x24
    str	w10,	[x12]

    add	x21,	x21,	#144
    movz	w10,	#0
    add	w12,	w7,	#1
    add	x24,	x24,	#144
    str	w8,	[x15]

    movz	w7,	#0
    str	w6,	[x18]

    add	w14,	w12,	#1
    str	w4,	[x21]

    movz	w21,	#0
    str	w2,	[x24]

    lsl	w2,	w12,	#2
    add	w17,	w14,	#1
    lsl	w5,	w14,	#2
    mov	x1,	x2
    mov	x3,	x5
    add	x1,	sp,	x1
    add	x3,	sp,	x3
    add	w20,	w17,	#1
    lsl	w8,	w17,	#2
    mov	x6,	x8
    add	x1,	x1,	#144
    add	x3,	x3,	#144
    add	w24,	w20,	#1
    lsl	w11,	w20,	#2
    add	x6,	sp,	x6
    mov	x9,	x11
    str	w0,	[x1]

    movz	w11,	#0
    lsl	w14,	w24,	#2
    add	x9,	sp,	x9
    add	x6,	x6,	#144
    str	w26,	[x3]

    mov	x12,	x14
    add	x9,	x9,	#144
    add	x12,	sp,	x12
    str	w23,	[x6]

    add	w6,	w24,	#1
    add	x12,	x12,	#144
    str	w21,	[x9]

    movz	w24,	#0
    add	w3,	w6,	#1
    lsl	w17,	w6,	#2
    str	w19,	[x12]

    mov	x15,	x17
    movz	w12,	#0
    movz	w17,	#0
    lsl	w20,	w3,	#2
    add	w6,	w3,	#1
    add	x15,	sp,	x15
    mov	x19,	x20
    movz	w3,	#0
    add	x19,	sp,	x19
    add	w9,	w6,	#1
    lsl	w23,	w6,	#2
    add	x15,	x15,	#144
    mov	x22,	x23
    add	x19,	x19,	#144
    add	x22,	sp,	x22
    lsl	w28,	w9,	#2
    str	w17,	[x15]

    mov	x26,	x28
    add	x22,	x22,	#144
    movz	w15,	#0
    add	x26,	sp,	x26
    str	w15,	[x19]

    add	w15,	w9,	#1
    str	w13,	[x22]

    add	x26,	x26,	#144
    movz	w9,	#0
    movz	w22,	#0
    add	w18,	w15,	#1
    lsl	w2,	w15,	#2
    str	w11,	[x26]

    mov	x1,	x2
    add	x1,	sp,	x1
    add	w28,	w18,	#1
    lsl	w5,	w18,	#2
    movz	w18,	#0
    mov	x4,	x5
    add	x1,	x1,	#144
    movz	w5,	#0
    add	w2,	w28,	#1
    lsl	w8,	w28,	#2
    add	x4,	sp,	x4
    movz	w28,	#0
    str	w9,	[x1]

    mov	x8,	x8
    add	w6,	w2,	#1
    lsl	w11,	w2,	#2
    add	x4,	x4,	#144
    movz	w1,	#0
    add	x8,	sp,	x8
    mov	x11,	x11
    lsl	w14,	w6,	#2
    add	x11,	sp,	x11
    str	w7,	[x4]

    mov	x14,	x14
    add	x8,	x8,	#144
    add	x14,	sp,	x14
    add	x11,	x11,	#144
    str	w5,	[x8]

    add	x14,	x14,	#144
    str	w3,	[x11]

    add	w3,	w6,	#1
    str	w1,	[x14]

    add	w6,	w3,	#1
    lsl	w17,	w3,	#2
    mov	x16,	x17
    add	x16,	sp,	x16
    add	w14,	w6,	#1
    lsl	w20,	w6,	#2
    mov	x19,	x20
    add	x16,	x16,	#144
    movz	w20,	#0
    add	w17,	w14,	#1
    lsl	w23,	w14,	#2
    add	x19,	sp,	x19
    movz	w14,	#0
    str	w28,	[x16]

    mov	x23,	x23
    movz	w16,	#0
    lsl	w28,	w17,	#2
    add	x19,	x19,	#144
    add	x23,	sp,	x23
    mov	x28,	x28
    add	x28,	sp,	x28
    str	w24,	[x19]

    add	x23,	x23,	#144
    add	x28,	x28,	#144
    str	w22,	[x23]

    add	w22,	w17,	#1
    str	w20,	[x28]

    add	w26,	w22,	#1
    lsl	w2,	w22,	#2
    mov	x2,	x2
    add	x2,	sp,	x2
    add	w1,	w26,	#1
    lsl	w5,	w26,	#2
    movz	w26,	#0
    mov	x5,	x5
    add	x2,	x2,	#144
    add	x5,	sp,	x5
    add	w4,	w1,	#1
    lsl	w8,	w1,	#2
    mov	x8,	x8
    str	w18,	[x2]

    add	x5,	x5,	#144
    add	w3,	w4,	#1
    lsl	w11,	w4,	#2
    add	x8,	sp,	x8
    movz	w2,	#0
    str	w16,	[x5]

    movz	w4,	#0
    mov	x11,	x11
    add	w6,	w3,	#1
    add	x8,	x8,	#144
    add	x11,	sp,	x11
    lsl	w17,	w6,	#2
    str	w14,	[x8]

    add	x11,	x11,	#144
    mov	x18,	x17
    movz	w8,	#0
    lsl	w14,	w3,	#2
    add	x18,	sp,	x18
    str	w12,	[x11]

    mov	x15,	x14
    add	x15,	sp,	x15
    add	x18,	x18,	#144
    add	x15,	x15,	#144
    str	w10,	[x15]

    add	w10,	w6,	#1
    str	w8,	[x18]

    movz	w6,	#0
    lsl	w20,	w10,	#2
    add	w13,	w10,	#1
    mov	x21,	x20
    add	x21,	sp,	x21
    add	w17,	w13,	#1
    lsl	w23,	w13,	#2
    mov	x24,	x23
    add	x21,	x21,	#144
    add	x24,	sp,	x24
    lsl	w28,	w17,	#2
    mov	x0,	x28
    str	w6,	[x21]

    add	x24,	x24,	#144
    add	x0,	sp,	x0
    add	w21,	w17,	#1
    str	w4,	[x24]

    add	x0,	x0,	#144
    add	w23,	w21,	#1
    str	w2,	[x0]

    lsl	w5,	w23,	#2
    movz	w0,	#0
    lsl	w2,	w21,	#2
    mov	x6,	x5
    movz	w21,	#0
    mov	x4,	x2
    add	x6,	sp,	x6
    add	x4,	sp,	x4
    add	x6,	x6,	#144
    add	x4,	x4,	#144
    str	w0,	[x4]

    add	w0,	w23,	#1
    str	w26,	[x6]

    movz	w23,	#0
    lsl	w8,	w0,	#2
    add	w3,	w0,	#1
    mov	x9,	x8
    add	x9,	sp,	x9
    add	w20,	w3,	#1
    lsl	w11,	w3,	#2
    mov	x12,	x11
    add	x9,	x9,	#144
    add	x12,	sp,	x12
    str	w23,	[x9]

    add	x12,	x12,	#144
    str	w21,	[x12]

    b	main_164

main_282:
    lsl	w16,	w20,	#2
    movz	w24,	#0
    add	w9,	w20,	#1
    movz	w8,	#0
    movz	w6,	#0
    movz	w4,	#0
    movz	w0,	#0
    mov	x10,	x16
    add	w13,	w9,	#1
    lsl	w17,	w9,	#2
    add	x10,	sp,	x10
    mov	x19,	x17
    add	x19,	sp,	x19
    add	w16,	w13,	#1
    lsl	w20,	w13,	#2
    add	x10,	x10,	#144
    mov	x22,	x20
    add	x19,	x19,	#144
    add	x22,	sp,	x22
    lsl	w23,	w16,	#2
    add	w20,	w16,	#1
    str	w24,	[x10]

    mov	x26,	x23
    add	x22,	x22,	#144
    movz	w10,	#0
    lsl	w28,	w20,	#2
    add	x26,	sp,	x26
    str	w10,	[x19]

    mov	x1,	x28
    str	w8,	[x22]

    add	w28,	w20,	#1
    add	x26,	x26,	#144
    add	x1,	sp,	x1
    lsl	w2,	w28,	#2
    str	w6,	[x26]

    add	x1,	x1,	#144
    mov	x5,	x2
    movz	w26,	#0
    movz	w2,	#0
    add	x5,	sp,	x5
    str	w4,	[x1]

    add	w1,	w28,	#1
    add	x5,	x5,	#144
    add	w3,	w1,	#1
    str	w2,	[x5]

    lsl	w5,	w1,	#2
    add	w20,	w3,	#1
    mov	x8,	x5
    add	x8,	sp,	x8
    add	x8,	x8,	#144
    str	w0,	[x8]

    lsl	w8,	w3,	#2
    mov	x10,	x8
    add	x10,	sp,	x10
    add	x10,	x10,	#144
    str	w26,	[x10]

    cmp	w20,	#1000
    blt	main_282

main_301:
    movz	w9,	#0
    movz	w16,	#0
    movz	w0,	#0

main_302:
    cmp	w9,	#32
    bge	main_380

main_307:
    lsl	w12,	w9,	#2
    add	x11,	x25,	x12
    ldr	w8,	[x11]

    lsl	w15,	w8,	#2
    mov	x6,	x15
    add	x6,	sp,	x6
    add	x6,	x6,	#144
    ldr	w17,	[x6]

    add	w3,	w17,	#1
    str	w3,	[x6]

    cmp	w3,	w16
    cset	w19,	gt
    csel	w15,	w8,	w0,	gt
    csel	w13,	w3,	w16,	gt
    add	w20,	w9,	#1
    lsl	w24,	w20,	#2
    add	x23,	x25,	x24
    ldr	w19,	[x23]

    lsl	w0,	w19,	#2
    mov	x0,	x0
    add	x0,	sp,	x0
    add	x0,	x0,	#144
    ldr	w1,	[x0]

    add	w7,	w1,	#1
    str	w7,	[x0]

    cmp	w7,	w13
    cset	w3,	gt
    csel	w6,	w19,	w15,	gt
    csel	w5,	w7,	w13,	gt
    add	w9,	w20,	#1
    lsl	w8,	w9,	#2
    add	x7,	x25,	x8
    ldr	w3,	[x7]

    lsl	w11,	w3,	#2
    mov	x11,	x11
    add	x11,	sp,	x11
    add	x11,	x11,	#144
    ldr	w12,	[x11]

    add	w18,	w12,	#1
    str	w18,	[x11]

    cmp	w18,	w5
    cset	w14,	gt
    csel	w16,	w3,	w6,	gt
    csel	w15,	w18,	w5,	gt
    add	w20,	w9,	#1
    lsl	w19,	w20,	#2
    add	x18,	x25,	x19
    ldr	w9,	[x18]

    lsl	w22,	w9,	#2
    mov	x24,	x22
    add	x24,	sp,	x24
    add	x24,	x24,	#144
    ldr	w23,	[x24]

    add	w2,	w23,	#1
    str	w2,	[x24]

    cmp	w2,	w15
    cset	w26,	gt
    csel	w0,	w9,	w16,	gt
    csel	w28,	w2,	w15,	gt
    add	w1,	w20,	#1
    lsl	w3,	w1,	#2
    add	x2,	x25,	x3
    ldr	w3,	[x2]

    lsl	w6,	w3,	#2
    mov	x9,	x6
    add	x9,	sp,	x9
    add	x9,	x9,	#144
    ldr	w7,	[x9]

    add	w14,	w7,	#1
    str	w14,	[x9]

    cmp	w14,	w28
    cset	w9,	gt
    csel	w11,	w3,	w0,	gt
    csel	w10,	w14,	w28,	gt
    add	w21,	w1,	#1
    lsl	w14,	w21,	#2
    add	x13,	x25,	x14
    ldr	w14,	[x13]

    lsl	w17,	w14,	#2
    mov	x20,	x17
    add	x20,	sp,	x20
    add	x20,	x20,	#144
    ldr	w18,	[x20]

    add	w26,	w18,	#1
    str	w26,	[x20]

    cmp	w26,	w10
    cset	w20,	gt
    csel	w19,	w26,	w10,	gt
    add	w9,	w21,	#1
    csel	w20,	w14,	w11,	gt
    lsl	w26,	w9,	#2
    add	x24,	x25,	x26
    ldr	w7,	[x24]

    lsl	w1,	w7,	#2
    mov	x6,	x1
    add	x6,	sp,	x6
    add	x6,	x6,	#144
    ldr	w2,	[x6]

    add	w10,	w2,	#1
    str	w10,	[x6]

    cmp	w10,	w19
    cset	w4,	gt
    csel	w7,	w7,	w20,	gt
    csel	w6,	w10,	w19,	gt
    add	w14,	w9,	#1
    lsl	w9,	w14,	#2
    add	x8,	x25,	x9
    ldr	w10,	[x8]

    lsl	w12,	w10,	#2
    mov	x17,	x12
    add	x17,	sp,	x17
    add	x17,	x17,	#144
    ldr	w13,	[x17]

    add	w21,	w13,	#1
    str	w21,	[x17]

    cmp	w21,	w6
    add	w9,	w14,	#1
    csel	w16,	w21,	w6,	gt
    csel	w0,	w10,	w7,	gt
    cset	w15,	gt
    b	main_302

main_380:
    bl	putint
    movz	w24,	#0

main_381:
    cmp	w24,	#32
    bge	main_417

main_384:
    lsl	w1,	w24,	#2
    lsl	w3,	w24,	#2
    add	w12,	w24,	#1
    add	x19,	x25,	x1
    add	x2,	x27,	x3
    add	w18,	w12,	#1
    lsl	w0,	w12,	#2
    ldr	w4,	[x2]

    add	x11,	x25,	x0
    lsl	w2,	w12,	#2
    lsl	w8,	w18,	#2
    add	w24,	w18,	#1
    lsl	w6,	w18,	#2
    str	w4,	[x19]

    add	x1,	x27,	x2
    add	x7,	x27,	x8
    lsl	w14,	w24,	#2
    lsl	w12,	w24,	#2
    add	x17,	x25,	x6
    add	w4,	w24,	#1
    ldr	w3,	[x1]

    add	x13,	x27,	x14
    add	x23,	x25,	x12
    str	w3,	[x11]

    lsl	w20,	w4,	#2
    lsl	w18,	w4,	#2
    add	w11,	w4,	#1
    ldr	w9,	[x7]

    add	x19,	x27,	x20
    add	x2,	x25,	x18
    str	w9,	[x17]

    lsl	w28,	w11,	#2
    lsl	w24,	w11,	#2
    add	w20,	w11,	#1
    ldr	w15,	[x13]

    add	x26,	x27,	x28
    add	x9,	x25,	x24
    str	w15,	[x23]

    lsl	w5,	w20,	#2
    lsl	w3,	w20,	#2
    add	w28,	w20,	#1
    ldr	w21,	[x19]

    add	x4,	x27,	x5
    add	x17,	x25,	x3
    str	w21,	[x2]

    add	w24,	w28,	#1
    lsl	w11,	w28,	#2
    ldr	w0,	[x26]

    add	x10,	x27,	x11
    str	w0,	[x9]

    lsl	w9,	w28,	#2
    ldr	w6,	[x4]

    str	w6,	[x17]

    add	x23,	x25,	x9
    ldr	w12,	[x10]

    str	w12,	[x23]

    b	main_381

main_417:
    movz	w26,	#0

main_419:
    movz	w6,	#32
    movz	w5,	#0
    sub	w22,	w6,	w26
    sub	w23,	w22,	#1
    cmp	w5,	w23
    bge	main_440

main_424:
    movz	w13,	#0

main_426:
    lsl	w2,	w13,	#2
    add	w13,	w13,	#1
    add	x11,	x25,	x2
    lsl	w6,	w13,	#2
    ldr	w15,	[x11]

    add	x10,	x25,	x6
    ldr	w7,	[x10]

    cmp	w15,	w7
    ble	main_436

main_434:
    str	w15,	[x10]

    str	w7,	[x11]


main_436:
    cmp	w13,	w23
    blt	main_426

main_440:
    add	w26,	w26,	#1
    cmp	w26,	#31
    blt	main_419

main_443:
    movz	w19,	#0

main_444:
    cmp	w19,	#32
    bge	main_472

main_447:
    lsl	w21,	w19,	#2
    movz	fp,	#4144
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w0,	[x20]

    bl	putint
    add	w21,	w19,	#1
    movz	fp,	#4144
    lsl	w26,	w21,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    add	w28,	w21,	#1
    movz	fp,	#4144
    lsl	w19,	w28,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    ldr	w0,	[x18]

    bl	putint
    movz	fp,	#4144
    add	w26,	w28,	#1
    lsl	w23,	w26,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w0,	[x22]

    bl	putint
    movz	fp,	#4144
    add	w19,	w26,	#1
    lsl	w0,	w19,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    ldr	w0,	[x28]

    bl	putint
    movz	fp,	#4144
    add	w19,	w19,	#1
    lsl	w21,	w19,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w0,	[x20]

    bl	putint
    movz	fp,	#4144
    add	w23,	w19,	#1
    lsl	w26,	w23,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    movz	fp,	#4144
    add	w26,	w23,	#1
    lsl	w19,	w26,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    ldr	w0,	[x18]

    bl	putint
    add	w19,	w26,	#1
    b	main_444

main_472:
    movz	w1,	#0

main_473:
    cmp	w1,	#32
    bge	main_509

main_476:
    lsl	w20,	w1,	#2
    lsl	w22,	w1,	#2
    add	x24,	x25,	x20
    add	x21,	x27,	x22
    add	w20,	w1,	#1
    ldr	w23,	[x21]

    add	w28,	w20,	#1
    lsl	w17,	w20,	#2
    lsl	w15,	w20,	#2
    str	w23,	[x24]

    add	x16,	x27,	x17
    add	w9,	w28,	#1
    lsl	w21,	w28,	#2
    add	x8,	x25,	x15
    lsl	w23,	w28,	#2
    ldr	w18,	[x16]

    add	x14,	x25,	x21
    lsl	w2,	w9,	#2
    lsl	w0,	w9,	#2
    add	x22,	x27,	x23
    add	w16,	w9,	#1
    str	w18,	[x8]

    add	x1,	x27,	x2
    add	x23,	x25,	x0
    lsl	w6,	w16,	#2
    lsl	w8,	w16,	#2
    ldr	w24,	[x22]

    add	x2,	x25,	x6
    add	x7,	x27,	x8
    add	w22,	w16,	#1
    str	w24,	[x14]

    ldr	w3,	[x1]

    str	w3,	[x23]

    lsl	w12,	w22,	#2
    lsl	w14,	w22,	#2
    add	w1,	w22,	#1
    ldr	w9,	[x7]

    add	x8,	x25,	x12
    add	x13,	x27,	x14
    str	w9,	[x2]

    lsl	w20,	w1,	#2
    lsl	w18,	w1,	#2
    ldr	w15,	[x13]

    add	x19,	x27,	x20
    add	x14,	x25,	x18
    str	w15,	[x8]

    add	w8,	w1,	#1
    ldr	w21,	[x19]

    str	w21,	[x14]

    add	w1,	w8,	#1
    lsl	w28,	w8,	#2
    lsl	w24,	w8,	#2
    add	x26,	x27,	x28
    add	x21,	x25,	x24
    ldr	w0,	[x26]

    str	w0,	[x21]

    b	main_473

main_509:
    movz	w2,	#1

main_511:
    lsl	w16,	w2,	#2
    sub	w18,	w2,	#1
    add	x15,	x25,	x16
    ldr	w23,	[x15]


main_516:
    movz	w19,	#65535
    movk	w19,	#65535,	lsl #16
    cmp	w18,	w19
    ble	main_529

main_519:
    lsl	w0,	w18,	#2
    add	x28,	x25,	x0
    ldr	w28,	[x28]

    cmp	w23,	w28
    bge	main_529

main_523:
    add	w4,	w18,	#1
    sub	w18,	w18,	#1
    lsl	w6,	w4,	#2
    add	x5,	x25,	x6
    str	w28,	[x5]

    b	main_516

main_529:
    add	w1,	w18,	#1
    add	w2,	w2,	#1
    lsl	w4,	w1,	#2
    add	x3,	x25,	x4
    str	w23,	[x3]

    cmp	w2,	#32
    blt	main_511

main_534:
    movz	w23,	#0

main_535:
    cmp	w23,	#32
    bge	main_563

main_538:
    lsl	w21,	w23,	#2
    movz	fp,	#4144
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w0,	[x20]

    bl	putint
    add	w19,	w23,	#1
    movz	fp,	#4144
    lsl	w26,	w19,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    add	w21,	w19,	#1
    movz	fp,	#4144
    lsl	w19,	w21,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    ldr	w0,	[x18]

    bl	putint
    movz	fp,	#4144
    add	w21,	w21,	#1
    lsl	w23,	w21,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w0,	[x22]

    bl	putint
    movz	fp,	#4144
    add	w21,	w21,	#1
    lsl	w0,	w21,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    ldr	w0,	[x28]

    bl	putint
    movz	fp,	#4144
    add	w26,	w21,	#1
    lsl	w21,	w26,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w0,	[x20]

    bl	putint
    movz	fp,	#4144
    add	w21,	w26,	#1
    lsl	w26,	w21,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    movz	fp,	#4144
    add	w20,	w21,	#1
    lsl	w19,	w20,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    ldr	w0,	[x18]

    bl	putint
    add	w23,	w20,	#1
    b	main_535

main_563:
    movz	w5,	#0

main_564:
    cmp	w5,	#32
    bge	main_600

main_567:
    lsl	w16,	w5,	#2
    lsl	w18,	w5,	#2
    add	w5,	w5,	#1
    add	x17,	x27,	x18
    add	x6,	x25,	x16
    add	w11,	w5,	#1
    lsl	w9,	w5,	#2
    lsl	w7,	w5,	#2
    ldr	w19,	[x17]

    add	x8,	x27,	x9
    str	w19,	[x6]

    add	w18,	w11,	#1
    lsl	w13,	w11,	#2
    add	x15,	x25,	x7
    ldr	w10,	[x8]

    add	x21,	x25,	x13
    add	w3,	w18,	#1
    lsl	w19,	w18,	#2
    str	w10,	[x15]

    add	x0,	x25,	x19
    lsl	w15,	w11,	#2
    lsl	w26,	w3,	#2
    add	w11,	w3,	#1
    add	x14,	x27,	x15
    add	x8,	x25,	x26
    add	w17,	w11,	#1
    lsl	w6,	w11,	#2
    lsl	w4,	w11,	#2
    ldr	w16,	[x14]

    add	x5,	x27,	x6
    str	w16,	[x21]

    add	w24,	w17,	#1
    lsl	w12,	w17,	#2
    lsl	w10,	w17,	#2
    add	x15,	x25,	x4
    lsl	w21,	w18,	#2
    add	x11,	x27,	x12
    lsl	w16,	w24,	#2
    lsl	w18,	w24,	#2
    add	x20,	x27,	x21
    add	x17,	x27,	x18
    add	x21,	x25,	x10
    ldr	w22,	[x20]

    str	w22,	[x0]

    lsl	w0,	w3,	#2
    add	x28,	x27,	x0
    add	x0,	x25,	x16
    ldr	w1,	[x28]

    str	w1,	[x8]

    ldr	w7,	[x5]

    add	w5,	w24,	#1
    str	w7,	[x15]

    ldr	w13,	[x11]

    str	w13,	[x21]

    ldr	w19,	[x17]

    str	w19,	[x0]

    b	main_564

main_600:
    mov	x0,	x25
    movz	w1,	#0
    movz	w2,	#31
    bl	QuickSort
    movz	w26,	#0

main_602:
    cmp	w26,	#32
    bge	main_630

main_605:
    lsl	w23,	w26,	#2
    movz	fp,	#4144
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w0,	[x22]

    bl	putint
    movz	fp,	#4144
    add	w22,	w26,	#1
    lsl	w18,	w22,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w24,	w22,	#1
    movz	fp,	#4144
    lsl	w22,	w24,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w20,	w24,	#1
    lsl	w28,	w20,	#2
    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    ldr	w0,	[x26]

    bl	putint
    movz	fp,	#4144
    add	w28,	w20,	#1
    lsl	w20,	w28,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    movz	fp,	#4144
    add	w22,	w28,	#1
    lsl	w24,	w22,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    movz	fp,	#4144
    add	w28,	w22,	#1
    lsl	w18,	w28,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w28,	w28,	#1
    lsl	w22,	w28,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    add	w26,	w28,	#1
    b	main_602

main_630:
    movz	w7,	#0

main_631:
    cmp	w7,	#32
    bge	main_667

main_634:
    lsl	w21,	w7,	#2
    lsl	w23,	w7,	#2
    add	w0,	w7,	#1
    add	x20,	x25,	x21
    add	x22,	x27,	x23
    add	w7,	w0,	#1
    lsl	w11,	w0,	#2
    lsl	w9,	w0,	#2
    ldr	w24,	[x22]

    add	x10,	x27,	x11
    str	w24,	[x20]

    add	w13,	w7,	#1
    lsl	w17,	w7,	#2
    lsl	w15,	w7,	#2
    add	x28,	x25,	x9
    ldr	w12,	[x10]

    add	x16,	x27,	x17
    lsl	w23,	w13,	#2
    lsl	w21,	w13,	#2
    add	x5,	x25,	x15
    str	w12,	[x28]

    add	x22,	x27,	x23
    add	x11,	x25,	x21
    ldr	w18,	[x16]

    add	w23,	w13,	#1
    str	w18,	[x5]

    ldr	w24,	[x22]

    lsl	w2,	w23,	#2
    lsl	w0,	w23,	#2
    str	w24,	[x11]

    add	x1,	x27,	x2
    add	x20,	x25,	x0
    add	w2,	w23,	#1
    ldr	w3,	[x1]

    lsl	w8,	w2,	#2
    lsl	w6,	w2,	#2
    str	w3,	[x20]

    add	x7,	x27,	x8
    add	x28,	x25,	x6
    ldr	w9,	[x7]

    str	w9,	[x28]

    add	w9,	w2,	#1
    lsl	w14,	w9,	#2
    lsl	w12,	w9,	#2
    add	x13,	x27,	x14
    add	x5,	x25,	x12
    ldr	w15,	[x13]

    str	w15,	[x5]

    add	w15,	w9,	#1
    add	w7,	w15,	#1
    lsl	w20,	w15,	#2
    lsl	w18,	w15,	#2
    add	x19,	x27,	x20
    add	x11,	x25,	x18
    ldr	w21,	[x19]

    str	w21,	[x11]

    b	main_631

main_667:
    movz	w8,	#0
    movz	w24,	#0

main_669:
    lsl	w3,	w24,	#2
    asr	w12,	w24,	#31
    add	x1,	x25,	x3
    lsr	w13,	w12,	#30
    add	w14,	w24,	w13
    ldr	w4,	[x1]

    add	w26,	w4,	w8
    asr	w21,	w14,	#2
    lsl	w22,	w21,	#2
    sub	w6,	w24,	w22
    cmp	w6,	#3
    beq	main_678

main_677:
    movz	w28,	#0
    str	w28,	[x1]

    b	main_745

main_678:
    str	w26,	[x1]

    movz	w26,	#0

main_745:
    add	w9,	w24,	#1
    asr	w28,	w9,	#31
    lsl	w23,	w9,	#2
    lsr	w0,	w28,	#30
    add	x17,	x25,	x23
    add	w1,	w9,	w0
    ldr	w24,	[x17]

    add	w11,	w24,	w26
    asr	w15,	w1,	#2
    lsl	w16,	w15,	#2
    sub	w0,	w9,	w16
    cmp	w0,	#3
    beq	main_688

main_679:
    movz	w18,	#0
    str	w18,	[x17]

    b	main_680

main_688:
    str	w11,	[x17]

    movz	w11,	#0

main_680:
    add	w26,	w9,	#1
    asr	w2,	w26,	#31
    lsl	w4,	w26,	#2
    lsr	w3,	w2,	#30
    add	x10,	x25,	x4
    add	w4,	w26,	w3
    ldr	w5,	[x10]

    add	w12,	w5,	w11
    asr	w19,	w4,	#2
    lsl	w20,	w19,	#2
    sub	w7,	w26,	w20
    cmp	w7,	#3
    beq	main_698

main_689:
    movz	w22,	#0
    str	w22,	[x10]

    b	main_690

main_698:
    str	w12,	[x10]

    movz	w12,	#0

main_690:
    add	w18,	w26,	#1
    asr	w5,	w18,	#31
    lsl	w11,	w18,	#2
    lsr	w6,	w5,	#30
    add	x11,	x25,	x11
    add	w7,	w18,	w6
    ldr	w13,	[x11]

    add	w13,	w13,	w12
    asr	w23,	w7,	#2
    lsl	w24,	w23,	#2
    sub	w15,	w18,	w24
    cmp	w15,	#3
    beq	main_708

main_699:
    movz	w28,	#0
    str	w28,	[x11]

    b	main_700

main_708:
    str	w13,	[x11]

    movz	w13,	#0

main_700:
    add	w28,	w18,	#1
    asr	w8,	w28,	#31
    lsl	w19,	w28,	#2
    lsr	w9,	w8,	#30
    add	x5,	x25,	x19
    add	w10,	w28,	w9
    ldr	w20,	[x5]

    add	w14,	w20,	w13
    asr	w0,	w10,	#2
    lsl	w1,	w0,	#2
    sub	w22,	w28,	w1
    cmp	w22,	#3
    beq	main_718

main_709:
    movz	w3,	#0
    str	w3,	[x5]

    b	main_710

main_718:
    str	w14,	[x5]

    movz	w14,	#0

main_710:
    add	w16,	w28,	#1
    asr	w11,	w16,	#31
    lsl	w28,	w16,	#2
    lsr	w12,	w11,	#30
    add	x19,	x25,	x28
    add	w13,	w16,	w12
    ldr	w0,	[x19]

    add	w15,	w0,	w14
    asr	w4,	w13,	#2
    lsl	w5,	w4,	#2
    sub	w2,	w16,	w5
    cmp	w2,	#3
    beq	main_728

main_719:
    movz	w7,	#0
    str	w7,	[x19]

    b	main_720

main_728:
    str	w15,	[x19]

    movz	w15,	#0

main_720:
    add	w24,	w16,	#1
    asr	w14,	w24,	#31
    lsl	w6,	w24,	#2
    add	x26,	x25,	x6
    ldr	w7,	[x26]

    add	w16,	w7,	w15
    lsr	w15,	w14,	#30
    add	w17,	w24,	w15
    asr	w8,	w17,	#2
    lsl	w9,	w8,	#2
    sub	w9,	w24,	w9
    cmp	w9,	#3
    beq	main_738

main_729:
    movz	w11,	#0
    str	w11,	[x26]

    b	main_730

main_738:
    str	w16,	[x26]

    movz	w16,	#0

main_730:
    add	w28,	w24,	#1
    asr	w18,	w28,	#31
    lsl	w13,	w28,	#2
    lsr	w19,	w18,	#30
    add	x5,	x25,	x13
    add	w20,	w28,	w19
    ldr	w14,	[x5]

    add	w8,	w14,	w16
    asr	w13,	w20,	#2
    lsl	w14,	w13,	#2
    sub	w17,	w28,	w14
    cmp	w17,	#3
    beq	main_744

main_739:
    movz	w16,	#0
    str	w16,	[x5]

    b	main_740

main_744:
    str	w8,	[x5]

    movz	w8,	#0

main_740:
    add	w24,	w28,	#1
    cmp	w24,	#32
    blt	main_669

main_753:
    movz	w21,	#0

main_754:
    cmp	w21,	#32
    bge	main_782

main_757:
    lsl	w18,	w21,	#2
    movz	fp,	#4144
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w21,	w21,	#1
    movz	fp,	#4144
    lsl	w0,	w21,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    ldr	w0,	[x28]

    bl	putint
    add	w26,	w21,	#1
    movz	fp,	#4144
    lsl	w21,	w26,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w0,	[x20]

    bl	putint
    movz	fp,	#4144
    add	w21,	w26,	#1
    lsl	w26,	w21,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    movz	fp,	#4144
    add	w20,	w21,	#1
    lsl	w19,	w20,	#2
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    ldr	w0,	[x18]

    bl	putint
    movz	fp,	#4144
    add	w26,	w20,	#1
    lsl	w23,	w26,	#2
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w0,	[x22]

    bl	putint
    movz	fp,	#4144
    add	w20,	w26,	#1
    lsl	w0,	w20,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	fp
    ldr	w0,	[x28]

    bl	putint
    movz	fp,	#4144
    add	w19,	w20,	#1
    lsl	w21,	w19,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    ldr	w0,	[x20]

    bl	putint
    add	w21,	w19,	#1
    b	main_754

main_782:
    movz	w23,	#0

main_783:
    cmp	w23,	#32
    bge	main_819

main_786:
    lsl	w3,	w23,	#2
    lsl	w5,	w23,	#2
    add	w7,	w23,	#1
    add	x24,	x25,	x3
    add	x4,	x27,	x5
    lsl	w15,	w7,	#2
    lsl	w13,	w7,	#2
    ldr	w6,	[x4]

    add	x14,	x27,	x15
    add	x21,	x25,	x13
    str	w6,	[x24]

    ldr	w16,	[x14]

    add	w14,	w7,	#1
    str	w16,	[x21]

    lsl	w19,	w14,	#2
    lsl	w21,	w14,	#2
    add	x0,	x25,	x19
    add	x20,	x27,	x21
    ldr	w22,	[x20]

    str	w22,	[x0]

    add	w22,	w14,	#1
    add	w3,	w22,	#1
    lsl	w0,	w22,	#2
    lsl	w26,	w22,	#2
    add	x28,	x27,	x0
    add	w9,	w3,	#1
    lsl	w6,	w3,	#2
    lsl	w4,	w3,	#2
    add	x8,	x25,	x26
    ldr	w1,	[x28]

    add	x5,	x27,	x6
    add	w20,	w9,	#1
    lsl	w12,	w9,	#2
    lsl	w10,	w9,	#2
    add	x15,	x25,	x4
    str	w1,	[x8]

    add	x11,	x27,	x12
    add	w28,	w20,	#1
    lsl	w18,	w20,	#2
    lsl	w16,	w20,	#2
    add	x21,	x25,	x10
    ldr	w7,	[x5]

    add	x17,	x27,	x18
    lsl	w24,	w28,	#2
    lsl	w22,	w28,	#2
    add	x0,	x25,	x16
    str	w7,	[x15]

    add	x23,	x27,	x24
    add	x6,	x25,	x22
    ldr	w13,	[x11]

    str	w13,	[x21]

    ldr	w19,	[x17]

    str	w19,	[x0]

    ldr	w26,	[x23]

    add	w23,	w28,	#1
    str	w26,	[x6]

    b	main_783

main_819:
    movz	w1,	#0
    movz	w21,	#0
    movz	w24,	#0

main_822:
    cmp	w21,	#2
    bge	main_831

main_827:
    lsl	w20,	w21,	#2
    add	x19,	x25,	x20
    ldr	w22,	[x19]

    add	w1,	w22,	w1
    b	main_991

main_831:
    cmp	w21,	#2
    bne	main_836

main_833:
    ldr	w24,	[x25]

    movz	w4,	#3
    sdiv	w28,	w1,	w4
    str	w28,	[x25]

    b	main_991

main_836:
    lsl	w2,	w21,	#2
    sub	w13,	w21,	#3
    movz	w5,	#3
    add	x0,	x25,	x2
    add	w14,	w13,	#1
    ldr	w3,	[x0]

    lsl	w16,	w14,	#2
    add	w10,	w1,	w3
    add	x18,	x25,	x16
    sub	w1,	w10,	w24
    ldr	w24,	[x18]

    sdiv	w11,	w1,	w5
    str	w11,	[x18]


main_991:
    add	w9,	w21,	#1
    cmp	w9,	#2
    bge	main_855

main_846:
    lsl	w16,	w9,	#2
    add	x15,	x25,	x16
    ldr	w17,	[x15]

    add	w1,	w17,	w1
    b	main_850

main_855:
    cmp	w9,	#2
    bne	main_863

main_857:
    ldr	w24,	[x25]

    movz	w21,	#3
    sdiv	w21,	w1,	w21
    str	w21,	[x25]

    b	main_850

main_863:
    lsl	w23,	w9,	#2
    sub	w7,	w9,	#3
    add	x22,	x25,	x23
    add	w8,	w7,	#1
    ldr	w26,	[x22]

    lsl	w11,	w8,	#2
    movz	w22,	#3
    add	w4,	w1,	w26
    add	x15,	x25,	x11
    sub	w1,	w4,	w24
    ldr	w24,	[x15]

    sdiv	w6,	w1,	w22
    str	w6,	[x15]


main_850:
    add	w6,	w9,	#1
    cmp	w6,	#2
    bge	main_882

main_873:
    lsl	w11,	w6,	#2
    add	x10,	x25,	x11
    ldr	w12,	[x10]

    add	w1,	w12,	w1
    b	main_877

main_882:
    cmp	w6,	#2
    bne	main_890

main_884:
    ldr	w24,	[x25]

    movz	w28,	#3
    sdiv	w16,	w1,	w28
    str	w16,	[x25]

    b	main_877

main_890:
    lsl	w18,	w6,	#2
    sub	w0,	w6,	#3
    add	x17,	x25,	x18
    add	w2,	w0,	#1
    movz	w0,	#3
    ldr	w19,	[x17]

    lsl	w4,	w2,	#2
    add	w27,	w1,	w19
    add	x23,	x25,	x4
    sub	w1,	w27,	w24
    ldr	w24,	[x23]

    sdiv	w0,	w1,	w0
    str	w0,	[x23]


main_877:
    add	w0,	w6,	#1
    cmp	w0,	#2
    bge	main_909

main_900:
    lsl	w6,	w0,	#2
    add	x5,	x25,	x6
    ldr	w7,	[x5]

    add	w1,	w7,	w1
    b	main_904

main_909:
    cmp	w0,	#2
    bne	main_917

main_911:
    ldr	w24,	[x25]

    movz	w5,	#3
    sdiv	w11,	w1,	w5
    str	w11,	[x25]

    b	main_904

main_917:
    lsl	w13,	w0,	#2
    sub	w22,	w0,	#3
    movz	w6,	#3
    add	x12,	x25,	x13
    add	w23,	w22,	#1
    ldr	w14,	[x12]

    lsl	w26,	w23,	#2
    add	w19,	w1,	w14
    add	x9,	x25,	x26
    sub	w1,	w19,	w24
    ldr	w24,	[x9]

    sdiv	w22,	w1,	w6
    str	w22,	[x9]


main_904:
    add	w23,	w0,	#1
    cmp	w23,	#2
    bge	main_936

main_927:
    lsl	w28,	w23,	#2
    add	x27,	x25,	x28
    ldr	w0,	[x27]

    add	w1,	w0,	w1
    b	main_931

main_936:
    cmp	w23,	#2
    bne	main_944

main_938:
    ldr	w24,	[x25]

    movz	w10,	#3
    sdiv	w5,	w1,	w10
    str	w5,	[x25]

    b	main_931

main_944:
    lsl	w7,	w23,	#2
    sub	w15,	w23,	#3
    movz	w11,	#3
    add	x6,	x25,	x7
    add	w16,	w15,	#1
    ldr	w8,	[x6]

    lsl	w18,	w16,	#2
    add	w12,	w1,	w8
    add	x4,	x25,	x18
    sub	w1,	w12,	w24
    ldr	w24,	[x4]

    sdiv	w16,	w1,	w11
    str	w16,	[x4]


main_931:
    add	w21,	w23,	#1
    cmp	w21,	#30
    blt	main_822

main_956:
    cmp	w21,	#2
    bge	main_970

main_961:
    lsl	w22,	w21,	#2
    add	x20,	x25,	x22
    ldr	w23,	[x20]

    add	w1,	w23,	w1
    b	main_965

main_970:
    cmp	w21,	#2
    bne	main_978

main_972:
    ldr	w24,	[x25]

    movz	w4,	#3
    sdiv	w0,	w1,	w4
    str	w0,	[x25]

    b	main_965

main_978:
    lsl	w3,	w21,	#2
    sub	w10,	w21,	#3
    movz	w16,	#3
    add	x2,	x25,	x3
    add	w11,	w10,	#1
    ldr	w4,	[x2]

    lsl	w13,	w11,	#2
    add	w7,	w1,	w4
    add	x2,	x25,	x13
    sub	w1,	w7,	w24
    ldr	w24,	[x2]

    sdiv	w12,	w1,	w16
    str	w12,	[x2]


main_965:
    add	w21,	w21,	#1
    cmp	w21,	#32
    blt	main_956

main_996:
    add	x16,	x25,	#120
    movz	w13,	#0
    add	x8,	x25,	#124
    movz	w12,	#0
    movz	w23,	#0
    str	w13,	[x16]

    str	w12,	[x8]


main_999:
    cmp	w23,	#32
    bge	main_1027

main_1002:
    lsl	w18,	w23,	#2
    movz	fp,	#4144
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w24,	w23,	#1
    movz	fp,	#4144
    lsl	w28,	w24,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    add	w22,	w24,	#1
    movz	fp,	#4144
    lsl	w20,	w22,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    movz	fp,	#4144
    add	w26,	w22,	#1
    lsl	w24,	w26,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    movz	fp,	#4144
    add	w20,	w26,	#1
    lsl	w28,	w20,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    movz	fp,	#4144
    add	w26,	w20,	#1
    lsl	w20,	w26,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    movz	fp,	#4144
    add	w20,	w26,	#1
    lsl	w24,	w20,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    movz	fp,	#4144
    add	w24,	w20,	#1
    lsl	w28,	w24,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    add	w23,	w24,	#1
    b	main_999

main_1027:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#4272
    add	sp, sp, fp
    ret


