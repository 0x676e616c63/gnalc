.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#656
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#60
    movz	w28,	#0
    movz	w15,	#0
    movk	fp,	#32,	lsl #16
    mov	w16,	w15
    str	w28,	[sp, fp]


main_4:
    movz	fp,	#60
    mov	w19,	w16
    movz	w18,	#0
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#64
    lsl	w8,	w21,	#20
    movk	fp,	#32,	lsl #16
    mov	x25,	x8
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    str	x25,	[sp, fp]

    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w18,	[sp, fp]


main_9:
    movz	fp,	#56
    movz	w24,	#0
    movk	fp,	#32,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#64
    lsl	w11,	w14,	#19
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#160
    add	x12,	x5,	x11
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]

    movz	fp,	#156
    movk	fp,	#32,	lsl #16
    str	w24,	[sp, fp]


main_14:
    movz	fp,	#156
    movz	w10,	#0
    movk	fp,	#32,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#160
    lsl	w12,	w8,	#18
    movk	fp,	#32,	lsl #16
    ldr	x13,	[sp, fp]

    movz	fp,	#148
    add	x4,	x13,	x12
    movk	fp,	#32,	lsl #16
    str	x4,	[sp, fp]

    movz	fp,	#136
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]


main_19:
    movz	fp,	#136
    movz	w9,	#0
    movk	fp,	#32,	lsl #16
    mov	w8,	w9
    ldr	w26,	[sp, fp]

    movz	fp,	#148
    lsl	w17,	w26,	#17
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#140
    add	x1,	x5,	x17
    movk	fp,	#32,	lsl #16
    str	x1,	[sp, fp]

    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    str	w8,	[sp, fp]


main_24:
    movz	fp,	#124
    mov	w17,	w19
    movz	w8,	#0
    movk	fp,	#32,	lsl #16
    mov	w3,	w8
    ldr	w18,	[sp, fp]

    movz	fp,	#140
    lsl	w18,	w18,	#16
    movk	fp,	#32,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#116
    add	x13,	x2,	x18
    movk	fp,	#32,	lsl #16
    str	x13,	[sp, fp]


main_29:
    lsl	w16,	w3,	#15
    movz	fp,	#116
    mov	w25,	w17
    movz	w8,	#0
    movk	fp,	#32,	lsl #16
    mov	w12,	w8
    ldr	x27,	[sp, fp]

    add	x28,	x27,	x16

main_34:
    lsl	w7,	w12,	#14
    movz	fp,	#248
    mov	w0,	w25
    movz	w8,	#0
    add	x10,	x28,	x7
    movk	fp,	#32,	lsl #16
    mov	w22,	w8
    str	x10,	[sp, fp]


main_39:
    lsl	w6,	w22,	#13
    movz	fp,	#248
    mov	w7,	w0
    movz	w10,	#0
    movk	fp,	#32,	lsl #16
    mov	w14,	w10
    ldr	x9,	[sp, fp]

    movz	fp,	#264
    add	x16,	x9,	x6
    movk	fp,	#32,	lsl #16
    str	x16,	[sp, fp]


main_44:
    lsl	w13,	w14,	#12
    movz	fp,	#264
    movz	w25,	#0
    movk	fp,	#32,	lsl #16
    mov	w19,	w25
    ldr	x17,	[sp, fp]

    movz	fp,	#256
    add	x11,	x17,	x13
    movk	fp,	#32,	lsl #16
    str	x11,	[sp, fp]


main_49:
    lsl	w18,	w19,	#11
    movz	fp,	#256
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    mov	w2,	w11
    ldr	x1,	[sp, fp]

    movz	fp,	#240
    add	x20,	x1,	x18
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]


main_54:
    movz	fp,	#72
    mov	w5,	w7
    movz	w13,	#0
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#240
    lsl	w11,	w6,	#10
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#128
    add	x18,	x21,	x11
    movk	fp,	#32,	lsl #16
    str	x18,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]


main_59:
    movz	fp,	#80
    mov	w4,	w5
    movk	fp,	#32,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#128
    lsl	w1,	w10,	#9
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#96
    add	x20,	x8,	x1
    movk	fp,	#32,	lsl #16
    movz	w1,	#0
    str	w1,	[sp, fp]


main_64:
    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#176
    lsl	w0,	w5,	#8
    movk	fp,	#32,	lsl #16
    mov	w5,	w4
    add	x24,	x20,	x0
    movz	w0,	#0
    mov	w26,	w0
    str	x24,	[sp, fp]

    movz	fp,	#112
    movk	fp,	#32,	lsl #16
    str	w26,	[sp, fp]


main_69:
    movz	fp,	#112
    mov	w0,	w5
    movz	w4,	#0
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#176
    lsl	w6,	w1,	#7
    movk	fp,	#32,	lsl #16
    mov	w1,	w4
    ldr	x17,	[sp, fp]

    movz	fp,	#528
    add	x26,	x17,	x6
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]


main_74:
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    ldr	w13,	[sp, fp]

    movz	fp,	#528
    lsl	w18,	w13,	#6
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#92
    add	x23,	x27,	x18
    movk	fp,	#32,	lsl #16
    movz	w18,	#0
    mov	w10,	w18
    str	w10,	[sp, fp]


main_79:
    movz	fp,	#92
    mov	w27,	w0
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#192
    lsl	w7,	w1,	#5
    movk	fp,	#32,	lsl #16
    movz	w1,	#0
    add	x4,	x23,	x7
    str	x4,	[sp, fp]

    movz	fp,	#76
    mov	w4,	w1
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_84:
    movz	fp,	#76
    mov	w11,	w27
    movk	fp,	#32,	lsl #16
    ldr	w4,	[sp, fp]

    movz	fp,	#192
    lsl	w25,	w4,	#4
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    add	x24,	x0,	x25
    movz	w25,	#0
    mov	w17,	w25

main_89:
    lsl	w0,	w17,	#3
    add	w21,	w11,	#1
    add	w7,	w17,	#1
    add	x0,	x24,	x0
    add	w4,	w21,	#1
    mov	x18,	x0
    str	w11,	[x18]

    add	x6,	x0,	#4
    str	w21,	[x6]

    cmp	w7,	#2
    blt	main_88

main_99:
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    add	w1,	w6,	#1
    cmp	w1,	#2
    blt	main_83

main_102:
    movz	fp,	#92
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w15,	w1,	#1
    cmp	w15,	#2
    blt	main_78

main_105:
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    ldr	w17,	[sp, fp]

    add	w9,	w17,	#1
    cmp	w9,	#2
    blt	main_73

main_108:
    movz	fp,	#112
    movk	fp,	#32,	lsl #16
    ldr	w2,	[sp, fp]

    add	w21,	w2,	#1
    cmp	w21,	#2
    blt	main_68

main_111:
    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w15,	w7,	#1
    cmp	w15,	#2
    blt	main_63

main_114:
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	w13,	[sp, fp]

    add	w11,	w13,	#1
    cmp	w11,	#2
    blt	main_58

main_117:
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w11,	w0,	#1
    cmp	w11,	#2
    blt	main_53

main_120:
    add	w26,	w19,	#1
    cmp	w26,	#2
    blt	main_48

main_123:
    add	w0,	w14,	#1
    cmp	w0,	#2
    blt	main_43

main_126:
    add	w22,	w22,	#1
    cmp	w22,	#2
    blt	main_38

main_129:
    add	w9,	w12,	#1
    cmp	w9,	#2
    blt	main_33

main_132:
    add	w22,	w3,	#1
    cmp	w22,	#2
    blt	main_28

main_135:
    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    ldr	w19,	[sp, fp]

    add	w10,	w19,	#1
    cmp	w10,	#2
    blt	main_23

main_138:
    movz	fp,	#136
    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    add	w12,	w27,	#1
    cmp	w12,	#2
    blt	main_18

main_141:
    movz	fp,	#156
    movk	fp,	#32,	lsl #16
    ldr	w10,	[sp, fp]

    add	w27,	w10,	#1
    cmp	w27,	#2
    blt	main_13

main_144:
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    add	w23,	w16,	#1
    cmp	w23,	#2
    blt	main_8

main_147:
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    add	w8,	w22,	#1
    cmp	w8,	#2
    blt	main_3

main_150:
    add	x19,	sp,	#16
    movz	fp,	#168
    mov	x27,	x19
    movk	fp,	#32,	lsl #16
    mov	x21,	x27
    mov	x23,	x21
    mov	x0,	x23
    mov	x26,	x0
    str	x26,	[sp, fp]

    movz	fp,	#168
    movk	fp,	#32,	lsl #16
    ldr	x18,	[sp, fp]

    movz	fp,	#452
    mov	x22,	x18
    movk	fp,	#32,	lsl #16
    mov	x18,	x22
    mov	x26,	x18
    mov	x25,	x26
    str	x25,	[sp, fp]

    movz	fp,	#452
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#580
    mov	x28,	x25
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#580
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#572
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#572
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#204
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#204
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#604
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#604
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#620
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#620
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#400
    ldr	w25,	[x25]

    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#604
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#612
    add	x25,	x28,	#8
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#596
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#596
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#400
    ldr	w20,	[x28]

    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#236
    add	w20,	w20,	w28
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#204
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#428
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#588
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#588
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#236
    add	x20,	x20,	#4
    movk	fp,	#32,	lsl #16
    ldr	w20,	[x20]

    ldr	w24,	[sp, fp]

    movz	fp,	#544
    add	w20,	w24,	w20
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#572
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#48
    add	x28,	x24,	#32
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#404
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#32
    add	x24,	x28,	#8
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#544
    ldr	w20,	[x24]

    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#200
    add	w28,	w28,	w20
    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#580
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#412
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#420
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#564
    add	x28,	x24,	#16
    movk	fp,	#32,	lsl #16
    add	x28,	x28,	#8
    str	x28,	[sp, fp]

    movz	fp,	#564
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#200
    ldr	w28,	[x28]

    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#536
    add	w25,	w20,	w28
    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#556
    add	x28,	x20,	#128
    movk	fp,	#32,	lsl #16
    add	x20,	x28,	#64
    add	x20,	x20,	#32
    str	x20,	[sp, fp]

    movz	fp,	#556
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#628
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#628
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#636
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#636
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#536
    add	x20,	x20,	#4
    movk	fp,	#32,	lsl #16
    ldr	w20,	[x20]

    ldr	w28,	[sp, fp]

    movz	fp,	#460
    add	w24,	w28,	w20
    movk	fp,	#32,	lsl #16
    str	w24,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#460
    mov	x25,	x24
    movk	fp,	#32,	lsl #16
    add	x25,	x25,	#32
    add	x25,	x25,	#16
    add	x25,	x25,	#8
    ldr	w20,	[x25]

    ldr	w25,	[sp, fp]

    movz	fp,	#540
    add	w24,	w25,	w20
    movk	fp,	#32,	lsl #16
    str	w24,	[sp, fp]

    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#540
    add	x24,	x28,	#512
    movk	fp,	#32,	lsl #16
    add	x24,	x24,	#256
    add	x28,	x24,	#128
    add	x24,	x28,	#64
    add	x28,	x24,	#4
    mov	x24,	x26
    ldr	w28,	[x28]

    ldr	w25,	[sp, fp]

    movz	fp,	#212
    add	w20,	w25,	w28
    movk	fp,	#32,	lsl #16
    add	x28,	x24,	#128
    add	x25,	x28,	#64
    add	x26,	x25,	#32
    ldr	w28,	[x26]

    mov	x26,	x18
    add	w24,	w20,	w28
    mov	x25,	x26
    mov	x28,	x22
    str	x25,	[sp, fp]

    add	x28,	x28,	#1024
    movz	fp,	#212
    movk	fp,	#32,	lsl #16
    add	x25,	x28,	#512
    ldr	x26,	[sp, fp]

    movz	fp,	#168
    add	x26,	x26,	#512
    movk	fp,	#32,	lsl #16
    add	x18,	x26,	#256
    add	x26,	x18,	#32
    add	x26,	x26,	#4
    ldr	w18,	[x26]

    add	x26,	x25,	#256
    add	w20,	w24,	w18
    add	x18,	x26,	#128
    add	x18,	x18,	#64
    add	x22,	x18,	#8
    add	x28,	x22,	#4
    ldr	w25,	[x28]

    ldr	x28,	[sp, fp]

    add	w26,	w20,	w25
    movz	fp,	#220
    add	x22,	x28,	#2048
    movk	fp,	#32,	lsl #16
    add	x25,	x22,	#1024
    add	x25,	x25,	#128
    add	x20,	x25,	#16
    add	x25,	x0,	#16384
    add	x18,	x20,	#8
    ldr	w22,	[x18]

    add	w24,	w26,	w22
    add	x26,	x25,	#8192
    add	x22,	x26,	#1024
    mov	x26,	x0
    add	x25,	x22,	#512
    add	x18,	x25,	#256
    add	x28,	x18,	#32
    ldr	w25,	[x28]

    str	x26,	[sp, fp]

    add	w25,	w24,	w25
    movz	fp,	#220
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#228
    add	x0,	x22,	#256
    movk	fp,	#32,	lsl #16
    add	x22,	x0,	#128
    add	x24,	x22,	#64
    add	x0,	x24,	#32
    mov	x24,	x23
    add	x20,	x0,	#16
    add	x0,	x20,	#8
    add	x0,	x0,	#4
    ldr	w22,	[x0]

    add	x0,	x24,	#64
    add	w25,	w25,	w22
    mov	x22,	x27
    add	x18,	x0,	#32
    add	x0,	x18,	#16
    add	x0,	x0,	#8
    add	x0,	x0,	#4
    ldr	w0,	[x0]

    add	w18,	w25,	w0
    add	x0,	x21,	#131072
    add	x28,	x0,	#65536
    add	x20,	x28,	#32768
    add	x0,	x20,	#16384
    add	x25,	x0,	#512
    add	x26,	x25,	#256
    add	x23,	x26,	#128
    add	x26,	x23,	#16
    ldr	w25,	[x26]

    str	x22,	[sp, fp]

    add	w28,	w18,	w25
    movz	fp,	#228
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    add	x21,	x0,	#8192
    add	x23,	x21,	#4096
    add	x0,	x23,	#2048
    add	x25,	x0,	#1024
    add	x18,	x25,	#512
    add	x25,	x19,	#524288
    add	x22,	x18,	#64
    add	x18,	x25,	#262144
    add	x23,	x22,	#16
    add	x22,	x18,	#32768
    add	x21,	x23,	#4
    add	x26,	x22,	#8192
    ldr	w23,	[x21]

    add	x0,	x26,	#512
    add	w24,	w28,	w23
    add	x25,	x0,	#256
    add	x26,	x25,	#128
    add	x21,	x26,	#64
    add	x18,	x21,	#8
    add	x0,	x18,	#4
    ldr	w20,	[x0]

    add	w18,	w24,	w20
    mov	x20,	x19
    add	x20,	x20,	#262144
    add	x23,	x20,	#16384
    add	x24,	x23,	#2048
    add	x21,	x24,	#1024
    ldr	w0,	[x21]

    add	w0,	w18,	w0
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#656
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


main_3:
    mov	w16,	w4
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	w8,	[sp, fp]

    b	main_4

main_8:
    mov	w19,	w4
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    b	main_9

main_13:
    mov	w19,	w4
    movz	fp,	#156
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    b	main_14

main_18:
    mov	w19,	w4
    movz	fp,	#136
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]

    b	main_19

main_23:
    mov	w19,	w4
    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]

    b	main_24

main_28:
    mov	w17,	w4
    mov	w3,	w22
    b	main_29

main_33:
    mov	w25,	w4
    mov	w12,	w9
    b	main_34

main_38:
    mov	w0,	w4
    b	main_39

main_43:
    mov	w7,	w4
    mov	w14,	w0
    b	main_44

main_48:
    mov	w7,	w4
    mov	w19,	w26
    b	main_49

main_53:
    mov	w7,	w4
    mov	w1,	w11
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_54

main_58:
    mov	w5,	w4
    mov	w2,	w11
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]

    b	main_59

main_63:
    mov	w10,	w15
    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]

    b	main_64

main_68:
    mov	w5,	w4
    mov	w6,	w21
    movz	fp,	#112
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]

    b	main_69

main_73:
    mov	w0,	w4
    mov	w7,	w9
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_74

main_78:
    mov	w0,	w4
    mov	w1,	w15
    movz	fp,	#92
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_79

main_83:
    mov	w27,	w4
    mov	w7,	w1
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_84

main_88:
    mov	w11,	w4
    mov	w17,	w7
    b	main_89

