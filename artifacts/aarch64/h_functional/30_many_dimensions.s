.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#864
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#28
    movz	w19,	#0
    movz	w20,	#0
    movk	fp,	#32,	lsl #16
    mov	w17,	w19
    mov	w25,	w20
    str	w17,	[sp, fp]


main_4:
    movz	fp,	#28
    mov	w28,	w25
    movz	w4,	#0
    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#32
    lsl	w8,	w22,	#20
    movk	fp,	#32,	lsl #16
    mov	x26,	x8
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    str	x26,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_9:
    movz	fp,	#24
    movz	w6,	#0
    movk	fp,	#32,	lsl #16
    mov	w4,	w6
    ldr	w14,	[sp, fp]

    movz	fp,	#32
    lsl	w11,	w14,	#19
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#136
    add	x12,	x5,	x11
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]

    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_14:
    movz	fp,	#124
    mov	w25,	w28
    movz	w24,	#0
    movk	fp,	#32,	lsl #16
    mov	w23,	w24
    ldr	w5,	[sp, fp]

    movz	fp,	#136
    lsl	w12,	w5,	#18
    movk	fp,	#32,	lsl #16
    ldr	x15,	[sp, fp]

    movz	fp,	#128
    add	x9,	x15,	x12
    movk	fp,	#32,	lsl #16
    str	x9,	[sp, fp]

    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]


main_19:
    movz	fp,	#120
    mov	w28,	w25
    movz	w21,	#0
    movk	fp,	#32,	lsl #16
    mov	w19,	w21
    ldr	w0,	[sp, fp]

    movz	fp,	#128
    lsl	w16,	w0,	#17
    movk	fp,	#32,	lsl #16
    ldr	x10,	[sp, fp]

    movz	fp,	#112
    add	x26,	x10,	x16
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w19,	[sp, fp]


main_24:
    movz	fp,	#100
    mov	w3,	w28
    movz	w20,	#0
    movk	fp,	#32,	lsl #16
    mov	w11,	w20
    ldr	w17,	[sp, fp]

    movz	fp,	#112
    lsl	w16,	w17,	#16
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#92
    add	x13,	x0,	x16
    movk	fp,	#32,	lsl #16
    str	x13,	[sp, fp]


main_29:
    lsl	w20,	w11,	#15
    movz	fp,	#92
    mov	w1,	w3
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#320
    add	x9,	x0,	x20
    movk	fp,	#32,	lsl #16
    movz	w20,	#0
    mov	w24,	w20
    str	x9,	[sp, fp]


main_34:
    lsl	w8,	w24,	#14
    movz	fp,	#320
    mov	w2,	w1
    movz	w19,	#0
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#336
    add	x28,	x27,	x8
    movk	fp,	#32,	lsl #16
    mov	w8,	w19
    str	x28,	[sp, fp]


main_39:
    lsl	w7,	w8,	#13
    movz	fp,	#336
    mov	w9,	w2
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    mov	w25,	w0
    ldr	x4,	[sp, fp]

    movz	fp,	#352
    add	x4,	x4,	x7
    movk	fp,	#32,	lsl #16
    str	x4,	[sp, fp]


main_44:
    lsl	w20,	w25,	#12
    movz	fp,	#352
    mov	w5,	w9
    movz	w7,	#0
    movk	fp,	#32,	lsl #16
    mov	w19,	w7
    ldr	x1,	[sp, fp]

    movz	fp,	#344
    add	x2,	x1,	x20
    movk	fp,	#32,	lsl #16
    str	x2,	[sp, fp]


main_49:
    lsl	w22,	w19,	#11
    movz	fp,	#344
    mov	w14,	w5
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#328
    add	x4,	x21,	x22
    movk	fp,	#32,	lsl #16
    movz	w21,	#0
    mov	w9,	w21
    str	x4,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    str	w9,	[sp, fp]


main_54:
    movz	fp,	#40
    mov	w2,	w14
    movz	w28,	#0
    movk	fp,	#32,	lsl #16
    mov	w17,	w28
    ldr	w5,	[sp, fp]

    movz	fp,	#328
    lsl	w10,	w5,	#10
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#104
    add	x15,	x5,	x10
    movk	fp,	#32,	lsl #16
    str	x15,	[sp, fp]

    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	w17,	[sp, fp]


main_59:
    movz	fp,	#48
    mov	w3,	w2
    movk	fp,	#32,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#104
    lsl	w14,	w15,	#9
    movk	fp,	#32,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#472
    add	x26,	x4,	x14
    movk	fp,	#32,	lsl #16
    movz	w4,	#0
    str	x26,	[sp, fp]

    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_64:
    movz	fp,	#64
    mov	w12,	w3
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    mov	w6,	w16
    ldr	w5,	[sp, fp]

    movz	fp,	#472
    lsl	w0,	w5,	#8
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#156
    add	x2,	x28,	x0
    movk	fp,	#32,	lsl #16
    str	x2,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]


main_69:
    movz	fp,	#80
    movz	w6,	#0
    movk	fp,	#32,	lsl #16
    mov	w18,	w6
    ldr	w1,	[sp, fp]

    movz	fp,	#156
    lsl	w13,	w1,	#7
    movk	fp,	#32,	lsl #16
    ldr	x1,	[sp, fp]

    movz	fp,	#756
    add	x13,	x1,	x13
    movk	fp,	#32,	lsl #16
    mov	w1,	w12
    str	x13,	[sp, fp]

    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    str	w18,	[sp, fp]


main_74:
    movz	fp,	#68
    mov	w16,	w1
    movz	w21,	#0
    movk	fp,	#32,	lsl #16
    mov	w18,	w21
    ldr	w17,	[sp, fp]

    movz	fp,	#756
    lsl	w3,	w17,	#6
    movk	fp,	#32,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#60
    add	x26,	x14,	x3
    movk	fp,	#32,	lsl #16
    str	w18,	[sp, fp]


main_79:
    movz	fp,	#60
    mov	w12,	w16
    movz	w1,	#0
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#172
    lsl	w14,	w0,	#5
    movk	fp,	#32,	lsl #16
    add	x3,	x26,	x14
    str	x3,	[sp, fp]

    movz	fp,	#44
    mov	w3,	w1
    movk	fp,	#32,	lsl #16
    str	w3,	[sp, fp]


main_84:
    movz	fp,	#44
    movz	w20,	#0
    movk	fp,	#32,	lsl #16
    mov	w22,	w20
    ldr	w4,	[sp, fp]

    movz	fp,	#172
    lsl	w6,	w4,	#4
    movk	fp,	#32,	lsl #16
    ldr	x7,	[sp, fp]

    add	x10,	x7,	x6
    mov	w6,	w12

main_89:
    lsl	w0,	w22,	#3
    add	w14,	w6,	#1
    add	w3,	w22,	#1
    add	x0,	x10,	x0
    add	w13,	w14,	#1
    add	x27,	x0,	#4
    str	w6,	[x0]

    str	w14,	[x27]

    cmp	w3,	#2
    blt	main_88

main_99:
    movz	fp,	#44
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    add	w1,	w6,	#1
    cmp	w1,	#2
    blt	main_83

main_102:
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w14,	w1,	#1
    cmp	w14,	#2
    blt	main_78

main_105:
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    ldr	w26,	[sp, fp]

    add	w17,	w26,	#1
    cmp	w17,	#2
    blt	main_73

main_108:
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	w2,	[sp, fp]

    add	w1,	w2,	#1
    cmp	w1,	#2
    blt	main_68

main_111:
    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w28,	w7,	#1
    cmp	w28,	#2
    blt	main_63

main_114:
    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    ldr	w17,	[sp, fp]

    add	w20,	w17,	#1
    cmp	w20,	#2
    blt	main_58

main_117:
    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w27,	w0,	#1
    cmp	w27,	#2
    blt	main_53

main_120:
    add	w15,	w19,	#1
    cmp	w15,	#2
    blt	main_48

main_123:
    add	w7,	w25,	#1
    cmp	w7,	#2
    blt	main_43

main_126:
    add	w16,	w8,	#1
    cmp	w16,	#2
    blt	main_38

main_129:
    add	w22,	w24,	#1
    cmp	w22,	#2
    blt	main_33

main_132:
    add	w8,	w11,	#1
    cmp	w8,	#2
    blt	main_28

main_135:
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    ldr	w19,	[sp, fp]

    add	w23,	w19,	#1
    cmp	w23,	#2
    blt	main_23

main_138:
    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w0,	w1,	#1
    cmp	w0,	#2
    blt	main_18

main_141:
    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w0,	w7,	#1
    cmp	w0,	#2
    blt	main_13

main_144:
    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    add	w0,	w16,	#1
    cmp	w0,	#2
    blt	main_8

main_147:
    movz	fp,	#28
    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    add	w20,	w22,	#1
    cmp	w20,	#2
    blt	main_3

main_150:
    add	x0,	sp,	#16
    movz	fp,	#148
    mov	x18,	x0
    movk	fp,	#32,	lsl #16
    mov	x24,	x18
    mov	x21,	x24
    mov	x19,	x21
    mov	x22,	x19
    str	x22,	[sp, fp]

    movz	fp,	#148
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#72
    mov	x26,	x20
    movk	fp,	#32,	lsl #16
    mov	x27,	x26
    str	x27,	[sp, fp]

    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#660
    mov	x23,	x25
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#660
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#792
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#792
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#716
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#716
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#144
    ldr	w25,	[x23]

    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#792
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#764
    add	x25,	x23,	#8
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#764
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#644
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#644
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#392
    ldr	w23,	[x23]

    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#144
    movk	fp,	#32,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#392
    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#772
    add	w25,	w28,	w25
    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#376
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#708
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#708
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#772
    add	x28,	x25,	#4
    movk	fp,	#32,	lsl #16
    ldr	w28,	[x28]

    ldr	w23,	[sp, fp]

    movz	fp,	#468
    add	w23,	w23,	w28
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#724
    add	x25,	x23,	#32
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#724
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#384
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#384
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#740
    add	x25,	x23,	#8
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#740
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#732
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#732
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#468
    ldr	w28,	[x23]

    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#180
    add	w23,	w23,	w28
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#660
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#368
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#368
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#360
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#360
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#676
    add	x28,	x23,	#16
    movk	fp,	#32,	lsl #16
    add	x25,	x28,	#8
    str	x25,	[sp, fp]

    movz	fp,	#676
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#668
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#668
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#180
    ldr	w28,	[x23]

    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#820
    add	w28,	w23,	w28
    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#684
    add	x28,	x25,	#128
    movk	fp,	#32,	lsl #16
    add	x28,	x28,	#64
    add	x25,	x28,	#32
    str	x25,	[sp, fp]

    movz	fp,	#684
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#784
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#784
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#776
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#776
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#820
    add	x28,	x25,	#4
    movk	fp,	#32,	lsl #16
    ldr	w28,	[x28]

    ldr	w25,	[sp, fp]

    movz	fp,	#496
    add	w23,	w25,	w28
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#748
    mov	x23,	x25
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#748
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#700
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#700
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#800
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#800
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#184
    add	x23,	x23,	#32
    movk	fp,	#32,	lsl #16
    add	x23,	x23,	#16
    add	x23,	x23,	#8
    str	x23,	[sp, fp]

    movz	fp,	#184
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#692
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#692
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#496
    ldr	w28,	[x23]

    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#808
    add	w23,	w23,	w28
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#808
    add	x23,	x25,	#512
    movk	fp,	#32,	lsl #16
    add	x23,	x23,	#256
    add	x23,	x23,	#128
    add	x25,	x23,	#64
    add	x25,	x25,	#4
    ldr	w23,	[x25]

    add	x25,	x27,	#128
    ldr	w28,	[sp, fp]

    movz	fp,	#200
    add	w23,	w28,	w23
    movk	fp,	#32,	lsl #16
    add	x28,	x25,	#64
    add	x27,	x28,	#32
    ldr	w25,	[x27]

    mov	x27,	x26
    add	w25,	w23,	w25
    str	x27,	[sp, fp]

    movz	fp,	#200
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#148
    add	x28,	x26,	#512
    movk	fp,	#32,	lsl #16
    add	x27,	x28,	#256
    add	x27,	x27,	#32
    add	x28,	x27,	#4
    ldr	w27,	[x28]

    add	w23,	w25,	w27
    mov	x27,	x20
    mov	x26,	x27
    add	x28,	x26,	#1024
    add	x26,	x28,	#512
    add	x25,	x26,	#256
    add	x26,	x25,	#128
    add	x27,	x26,	#64
    add	x26,	x27,	#8
    add	x28,	x26,	#4
    ldr	w26,	[x28]

    ldr	x27,	[sp, fp]

    add	w25,	w23,	w26
    movz	fp,	#192
    add	x23,	x27,	#2048
    movk	fp,	#32,	lsl #16
    add	x27,	x23,	#1024
    add	x27,	x27,	#128
    add	x28,	x27,	#16
    add	x27,	x28,	#8
    add	x28,	x22,	#16384
    ldr	w26,	[x27]

    add	x27,	x28,	#8192
    add	w25,	w25,	w26
    add	x20,	x27,	#1024
    add	x20,	x20,	#512
    add	x26,	x20,	#256
    add	x20,	x26,	#32
    ldr	w20,	[x20]

    add	w28,	w25,	w20
    mov	x25,	x19
    mov	x23,	x25
    add	x27,	x23,	#256
    add	x27,	x27,	#128
    add	x26,	x27,	#64
    add	x26,	x26,	#32
    add	x27,	x26,	#16
    add	x26,	x27,	#8
    mov	x27,	x21
    add	x26,	x26,	#4
    ldr	w19,	[x26]

    add	x26,	x24,	#131072
    add	w22,	w28,	w19
    add	x19,	x27,	#64
    add	x27,	x26,	#65536
    add	x21,	x19,	#32
    add	x28,	x27,	#32768
    add	x19,	x21,	#16
    add	x21,	x19,	#8
    add	x19,	x21,	#4
    ldr	w23,	[x19]

    add	x19,	x28,	#16384
    add	w21,	w22,	w23
    add	x25,	x19,	#512
    add	x25,	x25,	#256
    add	x24,	x25,	#128
    add	x20,	x24,	#16
    ldr	w24,	[x20]

    add	w20,	w21,	w24
    mov	x21,	x18
    str	x21,	[sp, fp]

    movz	fp,	#192
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    add	x24,	x26,	#8192
    add	x25,	x24,	#4096
    add	x18,	x25,	#2048
    add	x27,	x18,	#1024
    add	x24,	x27,	#512
    add	x26,	x24,	#64
    add	x27,	x26,	#16
    add	x24,	x27,	#4
    add	x27,	x0,	#524288
    ldr	w25,	[x24]

    add	x24,	x27,	#262144
    add	w25,	w20,	w25
    add	x26,	x24,	#32768
    add	x20,	x26,	#8192
    add	x18,	x20,	#512
    add	x27,	x18,	#256
    add	x28,	x27,	#128
    add	x18,	x28,	#64
    mov	x28,	x0
    add	x21,	x18,	#8
    add	x18,	x21,	#4
    ldr	w23,	[x18]

    add	x18,	x28,	#262144
    add	w22,	w25,	w23
    add	x21,	x18,	#16384
    add	x0,	x21,	#2048
    add	x19,	x0,	#1024
    ldr	w0,	[x19]

    add	w0,	w22,	w0
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#864
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


main_3:
    mov	w25,	w13
    movz	fp,	#28
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    b	main_4

main_8:
    mov	w28,	w13
    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]

    b	main_9

main_13:
    mov	w28,	w13
    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]

    b	main_14

main_18:
    mov	w25,	w13
    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]

    b	main_19

main_23:
    mov	w28,	w13
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    b	main_24

main_28:
    mov	w3,	w13
    mov	w11,	w8
    b	main_29

main_33:
    mov	w1,	w13
    mov	w24,	w22
    b	main_34

main_38:
    mov	w2,	w13
    mov	w8,	w16
    b	main_39

main_43:
    mov	w9,	w13
    mov	w25,	w7
    b	main_44

main_48:
    mov	w5,	w13
    mov	w19,	w15
    b	main_49

main_53:
    mov	w14,	w13
    mov	w1,	w27
    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_54

main_58:
    mov	w2,	w13
    mov	w7,	w20
    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_59

main_63:
    mov	w3,	w13
    mov	w20,	w28
    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    b	main_64

main_68:
    mov	w12,	w13
    mov	w3,	w1
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w3,	[sp, fp]

    b	main_69

main_73:
    mov	w1,	w13
    mov	w14,	w17
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    str	w14,	[sp, fp]

    b	main_74

main_78:
    mov	w16,	w13
    mov	w12,	w14
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]

    b	main_79

main_83:
    mov	w12,	w13
    mov	w6,	w1
    movz	fp,	#44
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]

    b	main_84

main_88:
    mov	w6,	w13
    mov	w22,	w3
    b	main_89

