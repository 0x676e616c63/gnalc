.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl QuickSort
.align 2
.p2align 4,,11
.type QuickSort, %function
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
    blt	QuickSort_9

QuickSort_58:
    mov	w27,	w1
    b	QuickSort_59

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
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#4272
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#36
    movz	w28,	#7
    add	x8,	sp,	#4048
    add	x6,	sp,	#4040
    movz	w22,	#254
    add	x5,	sp,	#4036
    movz	w27,	#23
    add	x25,	sp,	#4016
    add	x4,	sp,	#4032
    add	x9,	sp,	#4052
    movz	w19,	#83
    add	x7,	sp,	#4044
    movz	w17,	#574
    movz	w14,	#657
    movz	w21,	#27
    add	x2,	sp,	#4024
    movz	fp,	#4100
    add	x1,	sp,	#4020
    movz	w26,	#89
    movz	w18,	#273
    movz	w20,	#5
    add	x3,	sp,	#4028
    movz	w24,	#26
    add	x10,	sp,	#4056
    movz	w16,	#905
    add	x11,	sp,	#4060
    add	x12,	sp,	#4064
    movz	w15,	#354
    movz	w23,	#282
    add	x13,	sp,	#4068
    str	w28,	[x25]

    str	w27,	[x1]

    movz	w1,	#96
    str	w26,	[x2]

    movz	w2,	#87
    str	w24,	[x3]

    movz	w3,	#58
    str	w23,	[x4]

    movz	w4,	#279
    str	w22,	[x5]

    movz	w5,	#452
    add	x22,	sp,	fp
    str	w21,	[x6]

    movz	fp,	#4104
    movz	w6,	#756
    add	x21,	sp,	#4096
    str	w20,	[x7]

    add	x23,	sp,	fp
    movz	w7,	#929
    add	x20,	sp,	#4092
    str	w19,	[x8]

    movz	fp,	#4108
    movz	w8,	#68
    add	x19,	sp,	#4088
    str	w18,	[x9]

    add	x24,	sp,	fp
    movz	w9,	#29
    add	x18,	sp,	#4084
    str	w17,	[x10]

    movz	fp,	#4112
    movz	w10,	#459
    add	x17,	sp,	#4080
    str	w16,	[x11]

    add	x26,	sp,	fp
    movz	w11,	#639
    add	x16,	sp,	#4076
    str	w15,	[x12]

    movz	fp,	#4116
    movz	w12,	#264
    add	x15,	sp,	#4072
    str	w14,	[x13]

    add	x27,	sp,	fp
    movz	w13,	#935
    movz	fp,	#4120
    str	w13,	[x15]

    add	x28,	sp,	fp
    str	w12,	[x16]

    movz	fp,	#4124
    str	w11,	[x17]

    str	w10,	[x18]

    str	w9,	[x19]

    str	w8,	[x20]

    str	w7,	[x21]

    str	w6,	[x22]

    str	w5,	[x23]

    str	w4,	[x24]

    movz	w24,	#290
    str	w3,	[x26]

    movz	w26,	#1
    str	w2,	[x27]

    movz	w27,	#28
    str	w1,	[x28]

    movz	w28,	#39
    add	x1,	sp,	fp
    movz	fp,	#4128
    str	w0,	[x1]

    add	x1,	sp,	fp
    movz	fp,	#4132
    str	w28,	[x1]

    add	x2,	sp,	fp
    movz	fp,	#4136
    str	w27,	[x2]

    add	x3,	sp,	fp
    movz	w27,	#0
    movz	fp,	#4140
    str	w26,	[x3]

    add	x4,	sp,	fp
    movz	fp,	#4144
    str	w24,	[x4]

    add	x26,	sp,	fp

main_37:
    cmp	w27,	#32
    blt	main_40

main_73:
    movz	w23,	#0

main_74:
    cmp	w23,	#32
    blt	main_77

main_102:
    movz	w16,	#0

main_104:
    movz	w18,	#32
    movz	w17,	#0
    sub	w28,	w18,	w16
    sub	w1,	w28,	#1
    cmp	w17,	w1
    bge	main_125

main_109:
    movz	w4,	#0

main_111:
    lsl	w13,	w4,	#2
    add	w4,	w4,	#1
    add	x7,	x26,	x13
    lsl	w18,	w4,	#2
    ldr	w10,	[x7]

    add	x0,	x26,	x18
    ldr	w19,	[x0]

    cmp	w10,	w19
    ble	main_121

main_119:
    str	w10,	[x0]

    str	w19,	[x7]


main_121:
    cmp	w4,	w1
    blt	main_111

main_125:
    add	w16,	w16,	#1
    cmp	w16,	#31
    blt	main_104

main_128:
    movz	w28,	#0

main_129:
    cmp	w28,	#32
    blt	main_132

main_157:
    add	x27,	x26,	#64
    add	x0,	x26,	#60
    ldr	w20,	[x27]

    ldr	w18,	[x0]

    add	w22,	w18,	w20
    asr	w28,	w22,	#31
    lsr	w0,	w28,	#31
    add	w18,	w22,	w0
    asr	w0,	w18,	#1
    bl	putint
    movz	w8,	#0

main_164:
    cmp	w8,	#952
    blt	main_167

main_282:
    lsl	w23,	w8,	#2
    movz	w10,	#0
    add	w19,	w8,	#1
    movz	w1,	#0
    movz	w28,	#0
    movz	w24,	#0
    movz	w20,	#0
    movz	w18,	#0
    mov	x5,	x23
    add	w22,	w19,	#1
    lsl	w7,	w19,	#2
    add	x5,	sp,	x5
    mov	x27,	x7
    add	x27,	sp,	x27
    add	x5,	x5,	#16
    add	x27,	x27,	#16
    str	w10,	[x5]

    lsl	w10,	w22,	#2
    str	w1,	[x27]

    mov	x1,	x10
    add	x1,	sp,	x1
    add	x1,	x1,	#16
    str	w28,	[x1]

    add	w28,	w22,	#1
    movz	w22,	#0
    add	w2,	w28,	#1
    lsl	w13,	w28,	#2
    mov	x4,	x13
    add	x4,	sp,	x4
    add	w5,	w2,	#1
    lsl	w16,	w2,	#2
    mov	x7,	x16
    add	x4,	x4,	#16
    movz	w16,	#0
    add	w8,	w5,	#1
    lsl	w19,	w5,	#2
    add	x7,	sp,	x7
    mov	x10,	x19
    str	w24,	[x4]

    add	x10,	sp,	x10
    add	w11,	w8,	#1
    add	x7,	x7,	#16
    add	x10,	x10,	#16
    lsl	w27,	w11,	#2
    str	w22,	[x7]

    mov	x17,	x27
    lsl	w22,	w8,	#2
    str	w20,	[x10]

    add	x17,	sp,	x17
    add	w8,	w11,	#1
    mov	x13,	x22
    add	x13,	sp,	x13
    add	x17,	x17,	#16
    add	x13,	x13,	#16
    str	w18,	[x13]

    str	w16,	[x17]

    cmp	w8,	#1000
    blt	main_282

main_301:
    movz	w9,	#0
    movz	w16,	#0
    movz	w0,	#0

main_302:
    cmp	w9,	#32
    blt	main_307

main_380:
    bl	putint
    movz	w24,	#0

main_381:
    cmp	w24,	#32
    blt	main_384

main_417:
    movz	w27,	#0

main_419:
    movz	w12,	#32
    movz	w11,	#0
    sub	w22,	w12,	w27
    sub	w4,	w22,	#1
    cmp	w11,	w4
    bge	main_440

main_424:
    movz	w13,	#0

main_426:
    lsl	w11,	w13,	#2
    add	w13,	w13,	#1
    add	x14,	x26,	x11
    lsl	w16,	w13,	#2
    ldr	w15,	[x14]

    add	x1,	x26,	x16
    ldr	w17,	[x1]

    cmp	w15,	w17
    ble	main_436

main_434:
    str	w15,	[x1]

    str	w17,	[x14]


main_436:
    cmp	w13,	w4
    blt	main_426

main_440:
    add	w27,	w27,	#1
    cmp	w27,	#31
    blt	main_419

main_443:
    movz	w19,	#0

main_444:
    cmp	w19,	#32
    blt	main_447

main_472:
    movz	w1,	#0

main_473:
    cmp	w1,	#32
    blt	main_476

main_509:
    movz	w17,	#1

main_511:
    lsl	w13,	w17,	#2
    sub	w3,	w17,	#1
    add	x12,	x26,	x13
    ldr	w2,	[x12]


main_516:
    movz	w19,	#65535
    movk	w19,	#65535,	lsl #16
    cmp	w3,	w19
    ble	main_529

main_519:
    lsl	w5,	w3,	#2
    add	x4,	x26,	x5
    ldr	w12,	[x4]

    cmp	w2,	w12
    blt	main_523

main_529:
    add	w22,	w3,	#1
    add	w17,	w17,	#1
    lsl	w24,	w22,	#2
    add	x23,	x26,	x24
    str	w2,	[x23]

    cmp	w17,	#32
    blt	main_511

main_534:
    movz	w23,	#0

main_535:
    cmp	w23,	#32
    blt	main_538

main_563:
    movz	w5,	#0

main_564:
    cmp	w5,	#32
    blt	main_567

main_600:
    mov	x0,	x26
    movz	w1,	#0
    movz	w2,	#31
    bl	QuickSort
    movz	w27,	#0

main_602:
    cmp	w27,	#32
    blt	main_605

main_630:
    movz	w7,	#0

main_631:
    cmp	w7,	#32
    blt	main_634

main_667:
    movz	w8,	#0
    movz	w24,	#0

main_669:
    lsl	w19,	w24,	#2
    asr	w13,	w24,	#31
    add	x16,	x26,	x19
    lsr	w14,	w13,	#30
    add	w15,	w24,	w14
    ldr	w20,	[x16]

    add	w4,	w20,	w8
    asr	w23,	w15,	#2
    lsl	w27,	w23,	#2
    sub	w22,	w24,	w27
    cmp	w22,	#3
    bne	main_677

main_678:
    str	w4,	[x16]

    movz	w4,	#0
    b	main_745

main_677:
    movz	w27,	#0
    str	w27,	[x16]


main_745:
    add	w2,	w24,	#1
    asr	w27,	w2,	#31
    lsl	w14,	w2,	#2
    lsr	w0,	w27,	#30
    add	x9,	x26,	x14
    add	w1,	w2,	w0
    ldr	w15,	[x9]

    add	w28,	w15,	w4
    asr	w27,	w1,	#2
    lsl	w0,	w27,	#2
    sub	w16,	w2,	w0
    cmp	w16,	#3
    bne	main_679

main_688:
    str	w28,	[x9]

    movz	w28,	#0
    b	main_680

main_679:
    movz	w22,	#0
    str	w22,	[x9]


main_680:
    add	w10,	w2,	#1
    asr	w3,	w10,	#31
    lsl	w20,	w10,	#2
    lsr	w4,	w3,	#30
    add	x15,	x26,	x20
    add	w5,	w10,	w4
    ldr	w21,	[x15]

    add	w0,	w21,	w28
    asr	w4,	w5,	#2
    lsl	w5,	w4,	#2
    sub	w24,	w10,	w5
    cmp	w24,	#3
    bne	main_689

main_698:
    str	w0,	[x15]

    movz	w0,	#0
    b	main_690

main_689:
    movz	w28,	#0
    str	w28,	[x15]


main_690:
    add	w24,	w10,	#1
    asr	w6,	w24,	#31
    lsl	w2,	w24,	#2
    lsr	w7,	w6,	#30
    add	x4,	x26,	x2
    add	w8,	w24,	w7
    ldr	w3,	[x4]

    add	w1,	w3,	w0
    asr	w8,	w8,	#2
    lsl	w9,	w8,	#2
    sub	w5,	w24,	w9
    cmp	w5,	#3
    bne	main_699

main_708:
    str	w1,	[x4]

    movz	w1,	#0
    b	main_700

main_699:
    movz	w3,	#0
    str	w3,	[x4]


main_700:
    add	w4,	w24,	#1
    lsl	w9,	w4,	#2
    add	x16,	x26,	x9
    asr	w9,	w4,	#31
    ldr	w10,	[x16]

    add	w2,	w10,	w1
    lsr	w10,	w9,	#30
    add	w11,	w4,	w10
    asr	w12,	w11,	#2
    lsl	w13,	w12,	#2
    sub	w12,	w4,	w13
    cmp	w12,	#3
    bne	main_709

main_718:
    str	w2,	[x16]

    movz	w2,	#0
    b	main_710

main_709:
    movz	w7,	#0
    str	w7,	[x16]


main_710:
    add	w21,	w4,	#1
    asr	w12,	w21,	#31
    lsl	w16,	w21,	#2
    lsr	w13,	w12,	#30
    add	x18,	x26,	x16
    add	w14,	w21,	w13
    ldr	w17,	[x18]

    add	w3,	w17,	w2
    asr	w16,	w14,	#2
    lsl	w17,	w16,	#2
    sub	w19,	w21,	w17
    cmp	w19,	#3
    bne	main_719

main_728:
    str	w3,	[x18]

    movz	w3,	#0
    b	main_720

main_719:
    movz	w11,	#0
    str	w11,	[x18]


main_720:
    add	w8,	w21,	#1
    asr	w15,	w8,	#31
    lsl	w23,	w8,	#2
    lsr	w16,	w15,	#30
    add	x27,	x26,	x23
    add	w17,	w8,	w16
    ldr	w24,	[x27]

    add	w4,	w24,	w3
    asr	w20,	w17,	#2
    lsl	w21,	w20,	#2
    sub	w28,	w8,	w21
    cmp	w28,	#3
    bne	main_729

main_738:
    str	w4,	[x27]

    movz	w4,	#0
    b	main_730

main_729:
    movz	w15,	#0
    str	w15,	[x27]


main_730:
    add	w11,	w8,	#1
    asr	w18,	w11,	#31
    lsl	w3,	w11,	#2
    lsr	w19,	w18,	#30
    add	x14,	x26,	x3
    add	w20,	w11,	w19
    ldr	w5,	[x14]

    add	w8,	w5,	w4
    asr	w24,	w20,	#2
    lsl	w27,	w24,	#2
    sub	w6,	w11,	w27
    cmp	w6,	#3
    bne	main_739

main_744:
    str	w8,	[x14]

    movz	w8,	#0
    b	main_740

main_739:
    movz	w0,	#0
    str	w0,	[x14]


main_740:
    add	w24,	w11,	#1
    cmp	w24,	#32
    blt	main_669

main_753:
    movz	w21,	#0

main_754:
    cmp	w21,	#32
    blt	main_757

main_782:
    movz	w19,	#0

main_783:
    cmp	w19,	#32
    blt	main_786

main_819:
    movz	w24,	#0
    movz	w21,	#0
    movz	w11,	#0

main_822:
    cmp	w21,	#2
    blt	main_827

main_831:
    cmp	w21,	#2
    beq	main_833

main_836:
    lsl	w5,	w21,	#2
    sub	w20,	w21,	#3
    add	x4,	x26,	x5
    add	w22,	w20,	#1
    ldr	w6,	[x4]

    lsl	w25,	w22,	#2
    movz	w4,	#3
    add	w19,	w24,	w6
    add	x6,	x26,	x25
    sub	w24,	w19,	w11
    ldr	w11,	[x6]

    sdiv	w15,	w24,	w4
    str	w15,	[x6]

    b	main_991

main_833:
    ldr	w11,	[x26]

    movz	w7,	#3
    sdiv	w17,	w24,	w7
    str	w17,	[x26]

    b	main_991

main_827:
    lsl	w19,	w21,	#2
    add	x18,	x26,	x19
    ldr	w20,	[x18]

    add	w24,	w20,	w24

main_991:
    add	w15,	w21,	#1
    cmp	w15,	#2
    blt	main_846

main_855:
    cmp	w15,	#2
    beq	main_857

main_863:
    lsl	w0,	w15,	#2
    sub	w14,	w15,	#3
    movz	w6,	#3
    add	x28,	x26,	x0
    add	w16,	w14,	#1
    ldr	w1,	[x28]

    lsl	w18,	w16,	#2
    add	w13,	w24,	w1
    add	x2,	x26,	x18
    sub	w24,	w13,	w11
    ldr	w11,	[x2]

    sdiv	w9,	w24,	w6
    str	w9,	[x2]

    b	main_850

main_857:
    ldr	w11,	[x26]

    movz	w9,	#3
    sdiv	w12,	w24,	w9
    str	w12,	[x26]

    b	main_850

main_846:
    lsl	w14,	w15,	#2
    add	x13,	x26,	x14
    ldr	w16,	[x13]

    add	w24,	w16,	w24

main_850:
    add	w8,	w15,	#1
    cmp	w8,	#2
    blt	main_873

main_882:
    cmp	w8,	#2
    beq	main_884

main_890:
    lsl	w22,	w8,	#2
    sub	w9,	w8,	#3
    add	x21,	x26,	x22
    add	w10,	w9,	#1
    ldr	w23,	[x21]

    lsl	w12,	w10,	#2
    add	w6,	w24,	w23
    add	x28,	x26,	x12
    sub	w24,	w6,	w11
    movz	w12,	#3
    ldr	w11,	[x28]

    sdiv	w4,	w24,	w12
    str	w4,	[x28]

    b	main_877

main_884:
    ldr	w11,	[x26]

    movz	w15,	#3
    sdiv	w6,	w24,	w15
    str	w6,	[x26]

    b	main_877

main_873:
    lsl	w9,	w8,	#2
    add	x7,	x26,	x9
    ldr	w10,	[x7]

    add	w24,	w10,	w24

main_877:
    add	w4,	w8,	#1
    cmp	w4,	#2
    blt	main_900

main_909:
    cmp	w4,	#2
    beq	main_911

main_917:
    lsl	w17,	w4,	#2
    sub	w2,	w4,	#3
    add	x16,	x26,	x17
    add	w3,	w2,	#1
    movz	w17,	#3
    ldr	w18,	[x16]

    lsl	w6,	w3,	#2
    add	w0,	w24,	w18
    add	x22,	x26,	x6
    sub	w24,	w0,	w11
    ldr	w11,	[x22]

    sdiv	w28,	w24,	w17
    str	w28,	[x22]

    b	main_904

main_911:
    ldr	w11,	[x26]

    movz	w20,	#3
    sdiv	w1,	w24,	w20
    str	w1,	[x26]

    b	main_904

main_900:
    lsl	w3,	w4,	#2
    add	x2,	x26,	x3
    ldr	w5,	[x2]

    add	w24,	w5,	w24

main_904:
    add	w0,	w4,	#1
    cmp	w0,	#2
    blt	main_927

main_936:
    cmp	w0,	#2
    beq	main_938

main_944:
    lsl	w12,	w0,	#2
    sub	w23,	w0,	#3
    add	x10,	x26,	x12
    add	w25,	w23,	#1
    ldr	w13,	[x10]

    lsl	w28,	w25,	#2
    add	w22,	w24,	w13
    add	x18,	x26,	x28
    sub	w24,	w22,	w11
    movz	w22,	#3
    ldr	w11,	[x18]

    sdiv	w21,	w24,	w22
    str	w21,	[x18]

    b	main_931

main_938:
    ldr	w11,	[x26]

    movz	w27,	#3
    sdiv	w23,	w24,	w27
    str	w23,	[x26]

    b	main_931

main_927:
    lsl	w27,	w0,	#2
    add	x25,	x26,	x27
    ldr	w28,	[x25]

    add	w24,	w28,	w24

main_931:
    add	w21,	w0,	#1
    cmp	w21,	#30
    blt	main_822

main_956:
    cmp	w21,	#2
    blt	main_961

main_970:
    cmp	w21,	#2
    beq	main_972

main_978:
    lsl	w6,	w21,	#2
    sub	w17,	w21,	#3
    movz	w4,	#3
    add	x5,	x26,	x6
    add	w18,	w17,	#1
    ldr	w7,	[x5]

    lsl	w20,	w18,	#2
    add	w16,	w24,	w7
    add	x17,	x26,	x20
    sub	w24,	w16,	w11
    ldr	w11,	[x17]

    sdiv	w16,	w24,	w4
    str	w16,	[x17]

    b	main_965

main_972:
    ldr	w11,	[x26]

    movz	w7,	#3
    sdiv	w18,	w24,	w7
    str	w18,	[x26]

    b	main_965

main_961:
    lsl	w20,	w21,	#2
    add	x19,	x26,	x20
    ldr	w22,	[x19]

    add	w24,	w22,	w24

main_965:
    add	w21,	w21,	#1
    cmp	w21,	#32
    blt	main_956

main_996:
    add	x4,	x26,	#120
    movz	w10,	#0
    add	x25,	x26,	#124
    movz	w0,	#0
    movz	w23,	#0
    str	w10,	[x4]

    str	w0,	[x25]


main_999:
    cmp	w23,	#32
    blt	main_1002

main_1027:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#4272
    add	sp, sp, fp
    ret


main_1002:
    lsl	w27,	w23,	#2
    movz	fp,	#4144
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    ldr	w0,	[x26]

    bl	putint
    add	w22,	w23,	#1
    movz	fp,	#4144
    lsl	w20,	w22,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    add	w26,	w22,	#1
    movz	fp,	#4144
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
    movz	fp,	#4144
    add	w22,	w24,	#1
    lsl	w20,	w22,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    add	w23,	w22,	#1
    b	main_999

main_786:
    lsl	w15,	w19,	#2
    lsl	w17,	w19,	#2
    add	w1,	w19,	#1
    add	x15,	x26,	x15
    add	x16,	x25,	x17
    add	w9,	w1,	#1
    lsl	w21,	w1,	#2
    lsl	w19,	w1,	#2
    ldr	w18,	[x16]

    add	x20,	x25,	x21
    str	w18,	[x15]

    lsl	w0,	w9,	#2
    lsl	w27,	w9,	#2
    add	x12,	x26,	x19
    add	w18,	w9,	#1
    ldr	w22,	[x20]

    add	x28,	x25,	x0
    add	x20,	x26,	x27
    add	w24,	w18,	#1
    lsl	w6,	w18,	#2
    lsl	w4,	w18,	#2
    str	w22,	[x12]

    add	x5,	x25,	x6
    ldr	w1,	[x28]

    add	w3,	w24,	#1
    lsl	w10,	w24,	#2
    add	x0,	x26,	x4
    lsl	w12,	w24,	#2
    str	w1,	[x20]

    add	x6,	x26,	x10
    add	w9,	w3,	#1
    lsl	w18,	w3,	#2
    lsl	w16,	w3,	#2
    add	x11,	x25,	x12
    ldr	w7,	[x5]

    add	x17,	x25,	x18
    add	w20,	w9,	#1
    lsl	w24,	w9,	#2
    lsl	w22,	w9,	#2
    add	x12,	x26,	x16
    str	w7,	[x0]

    add	x23,	x25,	x24
    lsl	w3,	w20,	#2
    lsl	w1,	w20,	#2
    add	x18,	x26,	x22
    ldr	w13,	[x11]

    add	x2,	x25,	x3
    add	x0,	x26,	x1
    str	w13,	[x6]

    ldr	w19,	[x17]

    str	w19,	[x12]

    add	w19,	w20,	#1
    ldr	w27,	[x23]

    str	w27,	[x18]

    ldr	w4,	[x2]

    str	w4,	[x0]

    b	main_783

main_757:
    lsl	w27,	w21,	#2
    movz	fp,	#4144
    mov	x24,	x27
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    add	w22,	w21,	#1
    movz	fp,	#4144
    lsl	w24,	w22,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    add	w24,	w22,	#1
    movz	fp,	#4144
    lsl	w18,	w24,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w28,	w24,	#1
    lsl	w22,	w28,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w22,	w28,	#1
    lsl	w28,	w22,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    movz	fp,	#4144
    add	w22,	w22,	#1
    lsl	w20,	w22,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    movz	fp,	#4144
    add	w28,	w22,	#1
    lsl	w24,	w28,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    movz	fp,	#4144
    add	w20,	w28,	#1
    lsl	w18,	w20,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w21,	w20,	#1
    b	main_754

main_634:
    lsl	w18,	w7,	#2
    lsl	w20,	w7,	#2
    add	w15,	w7,	#1
    add	x3,	x26,	x18
    add	x19,	x25,	x20
    lsl	w18,	w15,	#2
    lsl	w20,	w15,	#2
    ldr	w21,	[x19]

    add	x23,	x26,	x18
    add	x19,	x25,	x20
    str	w21,	[x3]

    ldr	w21,	[x19]

    str	w21,	[x23]

    add	w23,	w15,	#1
    add	w9,	w23,	#1
    lsl	w28,	w23,	#2
    lsl	w24,	w23,	#2
    add	x27,	x25,	x28
    add	w15,	w9,	#1
    lsl	w5,	w9,	#2
    add	x3,	x26,	x24
    ldr	w0,	[x27]

    add	x4,	x25,	x5
    add	w21,	w15,	#1
    str	w0,	[x3]

    ldr	w6,	[x4]

    lsl	w3,	w9,	#2
    add	w1,	w21,	#1
    lsl	w9,	w15,	#2
    add	x11,	x26,	x3
    add	x17,	x26,	x9
    str	w6,	[x11]

    lsl	w11,	w15,	#2
    lsl	w15,	w21,	#2
    add	x10,	x25,	x11
    add	x23,	x26,	x15
    ldr	w12,	[x10]

    str	w12,	[x17]

    add	w12,	w1,	#1
    lsl	w17,	w21,	#2
    lsl	w21,	w1,	#2
    add	x16,	x25,	x17
    add	w7,	w12,	#1
    lsl	w0,	w12,	#2
    add	x2,	x26,	x21
    ldr	w18,	[x16]

    add	x11,	x26,	x0
    str	w18,	[x23]

    lsl	w23,	w1,	#2
    add	x22,	x25,	x23
    ldr	w24,	[x22]

    str	w24,	[x2]

    lsl	w2,	w12,	#2
    add	x1,	x25,	x2
    ldr	w3,	[x1]

    str	w3,	[x11]

    b	main_631

main_605:
    lsl	w23,	w27,	#2
    movz	fp,	#4144
    mov	x22,	x23
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w0,	[x22]

    bl	putint
    add	w28,	w27,	#1
    movz	fp,	#4144
    lsl	w24,	w28,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    add	w24,	w28,	#1
    movz	fp,	#4144
    lsl	w18,	w24,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w20,	w24,	#1
    lsl	w22,	w20,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w24,	w20,	#1
    lsl	w28,	w24,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

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
    movz	fp,	#4144
    add	w20,	w20,	#1
    lsl	w18,	w20,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w27,	w20,	#1
    b	main_602

main_567:
    lsl	w20,	w5,	#2
    lsl	w22,	w5,	#2
    add	w8,	w5,	#1
    add	x15,	x26,	x20
    add	x21,	x25,	x22
    add	w14,	w8,	#1
    lsl	w19,	w8,	#2
    lsl	w17,	w8,	#2
    ldr	w23,	[x21]

    add	x18,	x25,	x19
    str	w23,	[x15]

    lsl	w27,	w14,	#2
    add	x4,	x26,	x17
    lsl	w23,	w14,	#2
    ldr	w20,	[x18]

    add	x24,	x25,	x27
    add	x10,	x26,	x23
    str	w20,	[x4]

    ldr	w28,	[x24]

    add	w24,	w14,	#1
    str	w28,	[x10]

    lsl	w4,	w24,	#2
    lsl	w2,	w24,	#2
    add	x3,	x25,	x4
    add	x19,	x26,	x2
    ldr	w5,	[x3]

    add	w3,	w24,	#1
    str	w5,	[x19]

    lsl	w10,	w3,	#2
    lsl	w8,	w3,	#2
    add	x9,	x25,	x10
    add	x27,	x26,	x8
    add	w10,	w3,	#1
    ldr	w11,	[x9]

    lsl	w16,	w10,	#2
    lsl	w14,	w10,	#2
    str	w11,	[x27]

    add	x15,	x25,	x16
    add	x4,	x26,	x14
    add	w16,	w10,	#1
    ldr	w17,	[x15]

    lsl	w22,	w16,	#2
    add	w27,	w16,	#1
    lsl	w20,	w16,	#2
    str	w17,	[x4]

    add	x21,	x25,	x22
    add	w5,	w27,	#1
    lsl	w1,	w27,	#2
    lsl	w28,	w27,	#2
    add	x10,	x26,	x20
    ldr	w23,	[x21]

    add	x0,	x25,	x1
    add	x19,	x26,	x28
    str	w23,	[x10]

    ldr	w2,	[x0]

    str	w2,	[x19]

    b	main_564

main_538:
    lsl	w22,	w23,	#2
    movz	fp,	#4144
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    add	w20,	w23,	#1
    movz	fp,	#4144
    lsl	w24,	w20,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    add	w24,	w20,	#1
    movz	fp,	#4144
    lsl	w18,	w24,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w24,	w24,	#1
    lsl	w22,	w24,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w20,	w24,	#1
    lsl	w28,	w20,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

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
    add	w20,	w22,	#1
    lsl	w18,	w20,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w23,	w20,	#1
    b	main_535

main_523:
    add	w28,	w3,	#1
    sub	w3,	w3,	#1
    lsl	w1,	w28,	#2
    add	x0,	x26,	x1
    str	w12,	[x0]

    b	main_516

main_476:
    lsl	w28,	w1,	#2
    lsl	w2,	w1,	#2
    add	x10,	x26,	x28
    add	x0,	x25,	x2
    ldr	w3,	[x0]

    str	w3,	[x10]

    add	w3,	w1,	#1
    add	w12,	w3,	#1
    lsl	w22,	w3,	#2
    lsl	w20,	w3,	#2
    add	x21,	x25,	x22
    lsl	w1,	w12,	#2
    lsl	w28,	w12,	#2
    add	x16,	x26,	x20
    ldr	w23,	[x21]

    add	x0,	x25,	x1
    add	x27,	x26,	x28
    add	w20,	w12,	#1
    str	w23,	[x16]

    ldr	w2,	[x0]

    add	w28,	w20,	#1
    lsl	w7,	w20,	#2
    lsl	w5,	w20,	#2
    str	w2,	[x27]

    add	x6,	x25,	x7
    lsl	w13,	w28,	#2
    lsl	w11,	w28,	#2
    add	x4,	x26,	x5
    ldr	w8,	[x6]

    add	x12,	x25,	x13
    add	x10,	x26,	x11
    add	w5,	w28,	#1
    str	w8,	[x4]

    ldr	w14,	[x12]

    add	w11,	w5,	#1
    lsl	w19,	w5,	#2
    lsl	w17,	w5,	#2
    str	w14,	[x10]

    add	x18,	x25,	x19
    lsl	w27,	w11,	#2
    lsl	w23,	w11,	#2
    add	x16,	x26,	x17
    ldr	w20,	[x18]

    add	x24,	x25,	x27
    add	x22,	x26,	x23
    str	w20,	[x16]

    ldr	w28,	[x24]

    str	w28,	[x22]

    add	w22,	w11,	#1
    add	w1,	w22,	#1
    lsl	w4,	w22,	#2
    lsl	w2,	w22,	#2
    add	x3,	x25,	x4
    add	x7,	x26,	x2
    ldr	w5,	[x3]

    str	w5,	[x7]

    b	main_473

main_447:
    lsl	w28,	w19,	#2
    movz	fp,	#4144
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    add	w24,	w19,	#1
    movz	fp,	#4144
    lsl	w18,	w24,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w28,	w24,	#1
    movz	fp,	#4144
    lsl	w22,	w28,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w22,	w28,	#1
    lsl	w28,	w22,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    movz	fp,	#4144
    add	w22,	w22,	#1
    lsl	w20,	w22,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    movz	fp,	#4144
    add	w28,	w22,	#1
    lsl	w24,	w28,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    movz	fp,	#4144
    add	w20,	w28,	#1
    lsl	w18,	w20,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w20,	w20,	#1
    lsl	w22,	w20,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    add	w19,	w20,	#1
    b	main_444

main_384:
    lsl	w1,	w24,	#2
    lsl	w3,	w24,	#2
    add	w18,	w24,	#1
    add	x20,	x26,	x1
    add	x2,	x25,	x3
    lsl	w21,	w18,	#2
    lsl	w19,	w18,	#2
    add	w3,	w18,	#1
    ldr	w4,	[x2]

    add	x0,	x26,	x19
    str	w4,	[x20]

    add	x20,	x25,	x21
    add	w11,	w3,	#1
    lsl	w27,	w3,	#2
    ldr	w22,	[x20]

    add	x8,	x26,	x27
    add	w17,	w11,	#1
    lsl	w6,	w11,	#2
    lsl	w4,	w11,	#2
    str	w22,	[x0]

    add	x5,	x25,	x6
    lsl	w0,	w3,	#2
    lsl	w12,	w17,	#2
    add	w24,	w17,	#1
    lsl	w10,	w17,	#2
    add	x15,	x26,	x4
    add	x28,	x25,	x0
    add	x11,	x25,	x12
    add	w3,	w24,	#1
    lsl	w18,	w24,	#2
    lsl	w16,	w24,	#2
    add	x21,	x26,	x10
    ldr	w1,	[x28]

    add	x17,	x25,	x18
    lsl	w22,	w3,	#2
    lsl	w24,	w3,	#2
    add	x0,	x26,	x16
    str	w1,	[x8]

    add	x6,	x26,	x22
    add	x23,	x25,	x24
    ldr	w7,	[x5]

    str	w7,	[x15]

    ldr	w13,	[x11]

    str	w13,	[x21]

    add	w13,	w3,	#1
    ldr	w19,	[x17]

    str	w19,	[x0]

    ldr	w27,	[x23]

    add	w24,	w13,	#1
    lsl	w3,	w13,	#2
    lsl	w1,	w13,	#2
    str	w27,	[x6]

    add	x2,	x25,	x3
    add	x15,	x26,	x1
    ldr	w4,	[x2]

    str	w4,	[x15]

    b	main_381

main_307:
    lsl	w22,	w9,	#2
    add	x21,	x26,	x22
    ldr	w13,	[x21]

    lsl	w27,	w13,	#2
    mov	x23,	x27
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w28,	[x23]

    add	w4,	w28,	#1
    str	w4,	[x23]

    cmp	w4,	w16
    cset	w2,	gt
    csel	w20,	w13,	w0,	gt
    csel	w3,	w4,	w16,	gt
    add	w27,	w9,	#1
    lsl	w18,	w27,	#2
    add	x17,	x26,	x18
    ldr	w7,	[x17]

    lsl	w21,	w7,	#2
    mov	x21,	x21
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    ldr	w22,	[x21]

    add	w13,	w22,	#1
    str	w13,	[x21]

    cmp	w13,	w3
    cset	w24,	gt
    csel	w16,	w7,	w20,	gt
    csel	w14,	w13,	w3,	gt
    add	w18,	w27,	#1
    lsl	w2,	w18,	#2
    add	x1,	x26,	x2
    ldr	w11,	[x1]

    lsl	w5,	w11,	#2
    mov	x7,	x5
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    ldr	w6,	[x7]

    add	w27,	w6,	#1
    str	w27,	[x7]

    cmp	w27,	w14
    cset	w8,	gt
    csel	w15,	w11,	w16,	gt
    csel	w0,	w27,	w14,	gt
    add	w27,	w18,	#1
    lsl	w13,	w27,	#2
    add	x12,	x26,	x13
    ldr	w8,	[x12]

    lsl	w16,	w8,	#2
    mov	x19,	x16
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    ldr	w17,	[x19]

    add	w9,	w17,	#1
    str	w9,	[x19]

    cmp	w9,	w0
    cset	w19,	gt
    csel	w17,	w9,	w0,	gt
    add	w22,	w27,	#1
    csel	w19,	w8,	w15,	gt
    lsl	w24,	w22,	#2
    add	x23,	x26,	x24
    ldr	w12,	[x23]

    lsl	w0,	w12,	#2
    mov	x4,	x0
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w1,	[x4]

    add	w21,	w1,	#1
    str	w21,	[x4]

    cmp	w21,	w17
    cset	w3,	gt
    csel	w13,	w12,	w19,	gt
    csel	w9,	w21,	w17,	gt
    add	w15,	w22,	#1
    lsl	w8,	w15,	#2
    add	x7,	x26,	x8
    ldr	w24,	[x7]

    lsl	w11,	w24,	#2
    mov	x16,	x11
    add	x16,	sp,	x16
    add	x16,	x16,	#16
    ldr	w12,	[x16]

    add	w5,	w12,	#1
    str	w5,	[x16]

    cmp	w5,	w9
    csel	w21,	w24,	w13,	gt
    csel	w1,	w5,	w9,	gt
    add	w28,	w15,	#1
    cset	w14,	gt
    lsl	w19,	w28,	#2
    add	x18,	x26,	x19
    ldr	w9,	[x18]

    lsl	w22,	w9,	#2
    mov	x0,	x22
    add	x0,	sp,	x0
    add	x0,	x0,	#16
    ldr	w23,	[x0]

    add	w16,	w23,	#1
    str	w16,	[x0]

    cmp	w16,	w1
    cset	w27,	gt
    csel	w20,	w9,	w21,	gt
    csel	w18,	w16,	w1,	gt
    add	w22,	w28,	#1
    lsl	w3,	w22,	#2
    add	x2,	x26,	x3
    ldr	w27,	[x2]

    lsl	w6,	w27,	#2
    mov	x13,	x6
    add	x13,	sp,	x13
    add	x13,	x13,	#16
    ldr	w7,	[x13]

    add	w1,	w7,	#1
    str	w1,	[x13]

    cmp	w1,	w18
    csel	w16,	w1,	w18,	gt
    csel	w0,	w27,	w20,	gt
    cset	w9,	gt
    add	w9,	w22,	#1
    b	main_302

main_167:
    lsl	w7,	w8,	#2
    movz	w3,	#0
    add	w14,	w8,	#1
    movz	w1,	#0
    movz	w28,	#0
    movz	w24,	#0
    movz	w22,	#0
    movz	w6,	#0
    movz	w13,	#0
    movz	w9,	#0
    mov	x21,	x7
    add	w16,	w14,	#1
    lsl	w17,	w14,	#2
    add	x21,	sp,	x21
    movz	w14,	#0
    mov	x10,	x17
    add	w19,	w16,	#1
    lsl	w20,	w16,	#2
    add	x21,	x21,	#16
    add	x10,	sp,	x10
    movz	w16,	#0
    mov	x12,	x20
    lsl	w23,	w19,	#2
    movz	w20,	#0
    str	w3,	[x21]

    add	x10,	x10,	#16
    add	x12,	sp,	x12
    mov	x15,	x23
    add	w23,	w19,	#1
    add	x15,	sp,	x15
    str	w1,	[x10]

    movz	w19,	#0
    add	x12,	x12,	#16
    add	w0,	w23,	#1
    add	x15,	x15,	#16
    str	w28,	[x12]

    add	w3,	w0,	#1
    lsl	w2,	w0,	#2
    movz	w12,	#0
    lsl	w28,	w23,	#2
    str	w24,	[x15]

    mov	x18,	x28
    add	w7,	w3,	#1
    lsl	w5,	w3,	#2
    add	x18,	sp,	x18
    mov	x27,	x5
    add	x27,	sp,	x27
    add	w10,	w7,	#1
    lsl	w8,	w7,	#2
    add	x18,	x18,	#16
    mov	x1,	x8
    add	x27,	x27,	#16
    movz	w8,	#0
    add	w15,	w10,	#1
    lsl	w11,	w10,	#2
    add	x1,	sp,	x1
    str	w22,	[x18]

    movz	w10,	#0
    mov	x4,	x11
    movz	w18,	#0
    mov	x22,	x2
    add	x1,	x1,	#16
    add	x4,	sp,	x4
    add	x22,	sp,	x22
    add	x4,	x4,	#16
    add	x22,	x22,	#16
    str	w20,	[x22]

    movz	w22,	#0
    str	w18,	[x27]

    movz	w27,	#0
    add	w18,	w15,	#1
    str	w16,	[x1]

    movz	w16,	#0
    movz	w1,	#0
    add	w21,	w18,	#1
    lsl	w17,	w18,	#2
    str	w14,	[x4]

    mov	x11,	x17
    movz	w4,	#0
    lsl	w14,	w15,	#2
    add	w24,	w21,	#1
    lsl	w20,	w21,	#2
    add	x11,	sp,	x11
    movz	w15,	#0
    mov	x7,	x14
    movz	w21,	#0
    add	w0,	w24,	#1
    lsl	w23,	w24,	#2
    add	x11,	x11,	#16
    mov	x14,	x20
    add	x7,	sp,	x7
    mov	x17,	x23
    lsl	w28,	w0,	#2
    add	x14,	sp,	x14
    add	x17,	sp,	x17
    mov	x20,	x28
    add	x7,	x7,	#16
    add	x20,	sp,	x20
    add	x14,	x14,	#16
    add	x17,	x17,	#16
    str	w12,	[x7]

    add	x20,	x20,	#16
    str	w10,	[x11]

    add	w11,	w0,	#1
    str	w8,	[x14]

    movz	w0,	#0
    str	w6,	[x17]

    str	w4,	[x20]

    lsl	w2,	w11,	#2
    add	w8,	w11,	#1
    mov	x23,	x2
    movz	w2,	#0
    add	x23,	sp,	x23
    add	w11,	w8,	#1
    lsl	w5,	w8,	#2
    mov	x28,	x5
    add	x23,	x23,	#16
    add	x28,	sp,	x28
    add	w14,	w11,	#1
    lsl	w8,	w11,	#2
    str	w2,	[x23]

    add	x28,	x28,	#16
    add	w17,	w14,	#1
    lsl	w11,	w14,	#2
    movz	w23,	#0
    mov	x2,	x8
    str	w0,	[x28]

    mov	x5,	x11
    lsl	w14,	w17,	#2
    add	x2,	sp,	x2
    add	x5,	sp,	x5
    mov	x8,	x14
    add	x8,	sp,	x8
    add	x2,	x2,	#16
    add	x5,	x5,	#16
    add	x8,	x8,	#16
    str	w27,	[x2]

    str	w23,	[x5]

    str	w21,	[x8]

    add	w21,	w17,	#1
    add	w24,	w21,	#1
    lsl	w17,	w21,	#2
    mov	x11,	x17
    movz	w17,	#0
    add	x11,	sp,	x11
    add	w0,	w24,	#1
    lsl	w20,	w24,	#2
    mov	x14,	x20
    add	x11,	x11,	#16
    add	x14,	sp,	x14
    add	w3,	w0,	#1
    lsl	w23,	w0,	#2
    mov	x18,	x23
    str	w19,	[x11]

    add	x14,	x14,	#16
    add	w7,	w3,	#1
    lsl	w28,	w3,	#2
    add	x18,	sp,	x18
    movz	w19,	#0
    movz	w11,	#0
    str	w17,	[x14]

    add	w12,	w7,	#1
    lsl	w2,	w7,	#2
    mov	x21,	x28
    add	x18,	x18,	#16
    movz	w7,	#0
    mov	x24,	x2
    lsl	w5,	w12,	#2
    movz	w28,	#0
    add	x21,	sp,	x21
    str	w15,	[x18]

    add	x24,	sp,	x24
    mov	x0,	x5
    add	w15,	w12,	#1
    movz	w5,	#0
    add	x21,	x21,	#16
    add	x0,	sp,	x0
    add	x24,	x24,	#16
    movz	w12,	#0
    add	w18,	w15,	#1
    lsl	w8,	w15,	#2
    str	w13,	[x21]

    add	x0,	x0,	#16
    mov	x3,	x8
    str	w11,	[x24]

    add	w21,	w18,	#1
    add	x3,	sp,	x3
    lsl	w11,	w18,	#2
    str	w9,	[x0]

    add	w24,	w21,	#1
    lsl	w14,	w21,	#2
    add	x3,	x3,	#16
    mov	x10,	x14
    add	x10,	sp,	x10
    add	w0,	w24,	#1
    lsl	w17,	w24,	#2
    str	w7,	[x3]

    movz	w24,	#0
    add	x10,	x10,	#16
    mov	x13,	x17
    lsl	w20,	w0,	#2
    movz	w3,	#0
    mov	x7,	x11
    add	x13,	sp,	x13
    mov	x15,	x20
    add	x7,	sp,	x7
    movz	w20,	#0
    add	x15,	sp,	x15
    add	x13,	x13,	#16
    add	x7,	x7,	#16
    add	x15,	x15,	#16
    str	w5,	[x7]

    str	w3,	[x10]

    add	w3,	w0,	#1
    str	w1,	[x13]

    movz	w13,	#0
    str	w28,	[x15]

    movz	w15,	#0
    add	w6,	w3,	#1
    lsl	w23,	w3,	#2
    mov	x18,	x23
    add	x18,	sp,	x18
    add	w10,	w6,	#1
    lsl	w28,	w6,	#2
    movz	w6,	#0
    mov	x21,	x28
    add	x18,	x18,	#16
    add	x21,	sp,	x21
    add	w14,	w10,	#1
    lsl	w2,	w10,	#2
    mov	x27,	x2
    str	w24,	[x18]

    add	x21,	x21,	#16
    lsl	w5,	w14,	#2
    add	x27,	sp,	x27
    movz	w18,	#0
    mov	x1,	x5
    str	w22,	[x21]

    add	x1,	sp,	x1
    add	x27,	x27,	#16
    add	x1,	x1,	#16
    str	w20,	[x27]

    movz	w27,	#0
    str	w18,	[x1]

    movz	w1,	#0
    add	w18,	w14,	#1
    movz	w14,	#0
    add	w21,	w18,	#1
    lsl	w8,	w18,	#2
    mov	x4,	x8
    movz	w8,	#0
    add	x4,	sp,	x4
    add	w24,	w21,	#1
    lsl	w11,	w21,	#2
    movz	w21,	#0
    mov	x7,	x11
    add	x4,	x4,	#16
    add	x7,	sp,	x7
    add	w0,	w24,	#1
    str	w16,	[x4]

    add	x7,	x7,	#16
    add	w3,	w0,	#1
    lsl	w17,	w0,	#2
    movz	w4,	#0
    movz	w0,	#0
    str	w14,	[x7]

    lsl	w20,	w3,	#2
    add	w7,	w3,	#1
    lsl	w14,	w24,	#2
    mov	x10,	x14
    lsl	w23,	w7,	#2
    mov	x14,	x17
    add	x10,	sp,	x10
    mov	x17,	x20
    add	x14,	sp,	x14
    mov	x20,	x23
    add	x17,	sp,	x17
    add	x20,	sp,	x20
    add	x10,	x10,	#16
    add	x14,	x14,	#16
    add	x17,	x17,	#16
    add	x20,	x20,	#16
    str	w12,	[x10]

    movz	w10,	#0
    str	w10,	[x14]

    add	w10,	w7,	#1
    str	w8,	[x17]

    movz	w7,	#0
    str	w6,	[x20]

    lsl	w28,	w10,	#2
    add	w17,	w10,	#1
    mov	x23,	x28
    add	x23,	sp,	x23
    add	w18,	w17,	#1
    lsl	w2,	w17,	#2
    mov	x28,	x2
    add	x23,	x23,	#16
    movz	w2,	#0
    add	w20,	w18,	#1
    lsl	w5,	w18,	#2
    add	x28,	sp,	x28
    mov	x3,	x5
    str	w4,	[x23]

    add	x3,	sp,	x3
    add	w24,	w20,	#1
    lsl	w8,	w20,	#2
    add	x28,	x28,	#16
    movz	w23,	#0
    add	x3,	x3,	#16
    mov	x5,	x8
    lsl	w11,	w24,	#2
    add	x5,	sp,	x5
    str	w2,	[x28]

    mov	x8,	x11
    str	w0,	[x3]

    add	x8,	sp,	x8
    add	x5,	x5,	#16
    add	w0,	w24,	#1
    add	x8,	x8,	#16
    str	w27,	[x5]

    add	w3,	w0,	#1
    lsl	w14,	w0,	#2
    str	w23,	[x8]

    mov	x11,	x14
    add	w6,	w3,	#1
    lsl	w17,	w3,	#2
    add	x11,	sp,	x11
    mov	x14,	x17
    movz	w17,	#0
    add	x14,	sp,	x14
    add	w9,	w6,	#1
    lsl	w20,	w6,	#2
    add	x11,	x11,	#16
    mov	x18,	x20
    add	x14,	x14,	#16
    add	x18,	sp,	x18
    add	w12,	w9,	#1
    lsl	w23,	w9,	#2
    str	w21,	[x11]

    movz	w9,	#0
    add	x18,	x18,	#16
    movz	w11,	#0
    lsl	w28,	w12,	#2
    mov	x21,	x23
    str	w19,	[x14]

    mov	x24,	x28
    add	x21,	sp,	x21
    str	w17,	[x18]

    add	x24,	sp,	x24
    add	w18,	w12,	#1
    add	x21,	x21,	#16
    add	x24,	x24,	#16
    lsl	w2,	w18,	#2
    mov	x0,	x2
    str	w15,	[x21]

    add	x0,	sp,	x0
    add	w21,	w18,	#1
    str	w13,	[x24]

    add	x0,	x0,	#16
    lsl	w5,	w21,	#2
    add	w24,	w21,	#1
    mov	x3,	x5
    str	w11,	[x0]

    movz	w5,	#0
    lsl	w8,	w24,	#2
    add	x3,	sp,	x3
    add	w0,	w24,	#1
    mov	x6,	x8
    add	x6,	sp,	x6
    add	x3,	x3,	#16
    add	w4,	w0,	#1
    lsl	w11,	w0,	#2
    add	x6,	x6,	#16
    mov	x10,	x11
    str	w9,	[x3]

    add	x10,	sp,	x10
    lsl	w14,	w4,	#2
    movz	w3,	#0
    str	w7,	[x6]

    mov	x13,	x14
    add	x10,	x10,	#16
    add	w7,	w4,	#1
    add	x13,	sp,	x13
    str	w5,	[x10]

    add	w8,	w7,	#1
    lsl	w17,	w7,	#2
    add	x13,	x13,	#16
    mov	x16,	x17
    add	x16,	sp,	x16
    str	w3,	[x13]

    add	x16,	x16,	#16
    str	w1,	[x16]

    b	main_164

main_132:
    lsl	w19,	w28,	#2
    movz	fp,	#4144
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    ldr	w0,	[x18]

    bl	putint
    add	w20,	w28,	#1
    movz	fp,	#4144
    lsl	w24,	w20,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    add	w20,	w20,	#1
    movz	fp,	#4144
    lsl	w18,	w20,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w24,	w20,	#1
    lsl	w22,	w24,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w20,	w24,	#1
    lsl	w28,	w20,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

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
    add	w24,	w22,	#1
    lsl	w18,	w24,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    add	w28,	w24,	#1
    b	main_129

main_77:
    lsl	w27,	w23,	#2
    movz	fp,	#4144
    mov	x24,	x27
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w0,	[x24]

    bl	putint
    add	w22,	w23,	#1
    movz	fp,	#4144
    lsl	w28,	w22,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    add	w22,	w22,	#1
    movz	fp,	#4144
    lsl	w20,	w22,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    movz	fp,	#4144
    add	w28,	w22,	#1
    lsl	w24,	w28,	#2
    mov	x23,	x24
    add	x23,	sp,	x23
    add	x23,	x23,	fp
    ldr	w0,	[x23]

    bl	putint
    movz	fp,	#4144
    add	w20,	w28,	#1
    lsl	w18,	w20,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	fp
    ldr	w0,	[x0]

    bl	putint
    movz	fp,	#4144
    add	w20,	w20,	#1
    lsl	w22,	w20,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w0,	[x21]

    bl	putint
    movz	fp,	#4144
    add	w24,	w20,	#1
    lsl	w28,	w24,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    ldr	w0,	[x27]

    bl	putint
    movz	fp,	#4144
    add	w24,	w24,	#1
    lsl	w20,	w24,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	fp
    ldr	w0,	[x19]

    bl	putint
    add	w23,	w24,	#1
    b	main_74

main_40:
    lsl	w5,	w27,	#2
    lsl	w7,	w27,	#2
    add	w16,	w27,	#1
    add	x20,	x26,	x5
    add	x6,	x25,	x7
    add	w22,	w16,	#1
    lsl	w11,	w16,	#2
    lsl	w9,	w16,	#2
    ldr	w8,	[x6]

    add	x10,	x25,	x11
    str	w8,	[x20]

    add	w1,	w22,	#1
    lsl	w17,	w22,	#2
    lsl	w15,	w22,	#2
    add	x8,	x26,	x9
    ldr	w12,	[x10]

    add	x16,	x25,	x17
    lsl	w23,	w1,	#2
    lsl	w21,	w1,	#2
    add	x14,	x26,	x15
    str	w12,	[x8]

    add	x22,	x25,	x23
    add	x20,	x26,	x21
    add	w12,	w1,	#1
    ldr	w18,	[x16]

    str	w18,	[x14]

    ldr	w24,	[x22]

    lsl	w2,	w12,	#2
    lsl	w0,	w12,	#2
    add	w18,	w12,	#1
    str	w24,	[x20]

    add	x1,	x25,	x2
    add	x5,	x26,	x0
    lsl	w8,	w18,	#2
    lsl	w6,	w18,	#2
    add	w24,	w18,	#1
    ldr	w3,	[x1]

    add	x7,	x25,	x8
    add	x11,	x26,	x6
    str	w3,	[x5]

    lsl	w14,	w24,	#2
    lsl	w12,	w24,	#2
    add	w3,	w24,	#1
    ldr	w9,	[x7]

    add	x13,	x25,	x14
    add	x17,	x26,	x12
    str	w9,	[x11]

    add	w27,	w3,	#1
    lsl	w20,	w3,	#2
    lsl	w18,	w3,	#2
    ldr	w15,	[x13]

    add	x19,	x25,	x20
    str	w15,	[x17]

    add	x23,	x26,	x18
    ldr	w21,	[x19]

    str	w21,	[x23]

    b	main_37

