.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#768
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#60
    movz	w2,	#0
    movz	w12,	#0
    movk	fp,	#32,	lsl #16
    mov	w18,	w12
    str	w2,	[sp, fp]


main_4:
    movz	fp,	#60
    mov	w19,	w18
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    mov	w4,	w0
    ldr	w22,	[sp, fp]

    movz	fp,	#64
    lsl	w8,	w22,	#20
    movk	fp,	#32,	lsl #16
    mov	x26,	x8
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    str	x26,	[sp, fp]

    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_9:
    movz	fp,	#56
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#64
    lsl	w12,	w15,	#19
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#164
    add	x13,	x5,	x12
    movk	fp,	#32,	lsl #16
    str	x13,	[sp, fp]

    movz	fp,	#152
    mov	w13,	w3
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]


main_14:
    movz	fp,	#152
    mov	w21,	w19
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    mov	w23,	w3
    ldr	w5,	[sp, fp]

    movz	fp,	#164
    lsl	w13,	w5,	#18
    movk	fp,	#32,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#156
    add	x9,	x14,	x13
    movk	fp,	#32,	lsl #16
    str	x9,	[sp, fp]

    movz	fp,	#140
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]


main_19:
    movz	fp,	#140
    mov	w26,	w21
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    mov	w16,	w3
    ldr	w27,	[sp, fp]

    movz	fp,	#156
    lsl	w18,	w27,	#17
    movk	fp,	#32,	lsl #16
    ldr	x10,	[sp, fp]

    movz	fp,	#144
    add	x1,	x10,	x18
    movk	fp,	#32,	lsl #16
    str	x1,	[sp, fp]

    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    str	w16,	[sp, fp]


main_24:
    movz	fp,	#128
    mov	w8,	w26
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#144
    lsl	w20,	w18,	#16
    movk	fp,	#32,	lsl #16
    ldr	x2,	[sp, fp]

    movz	fp,	#120
    add	x13,	x2,	x20
    movk	fp,	#32,	lsl #16
    str	x13,	[sp, fp]

    mov	w13,	w3

main_29:
    lsl	w17,	w13,	#15
    movz	fp,	#120
    mov	w6,	w8
    movz	w10,	#0
    movk	fp,	#32,	lsl #16
    mov	w0,	w10
    ldr	x1,	[sp, fp]

    movz	fp,	#752
    add	x7,	x1,	x17
    movk	fp,	#32,	lsl #16
    str	x7,	[sp, fp]


main_34:
    lsl	w14,	w0,	#14
    movz	fp,	#752
    mov	w12,	w6
    movz	w4,	#0
    movk	fp,	#32,	lsl #16
    mov	w3,	w4
    ldr	x8,	[sp, fp]

    movz	fp,	#384
    add	x23,	x8,	x14
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]


main_39:
    lsl	w10,	w3,	#13
    movz	fp,	#384
    mov	w7,	w12
    movz	w1,	#0
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#392
    add	x24,	x24,	x10
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    mov	w24,	w1

main_44:
    lsl	w20,	w24,	#12
    movz	fp,	#392
    mov	w18,	w7
    movz	w9,	#0
    movk	fp,	#32,	lsl #16
    mov	w12,	w9
    ldr	x1,	[sp, fp]

    movz	fp,	#376
    add	x19,	x1,	x20
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]


main_49:
    lsl	w25,	w12,	#11
    movz	fp,	#376
    mov	w20,	w18
    movz	w19,	#0
    movk	fp,	#32,	lsl #16
    ldr	x6,	[sp, fp]

    movz	fp,	#368
    add	x6,	x6,	x25
    movk	fp,	#32,	lsl #16
    str	x6,	[sp, fp]

    movz	fp,	#72
    mov	w6,	w19
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]


main_54:
    movz	fp,	#72
    mov	w15,	w20
    movz	w10,	#0
    movk	fp,	#32,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#368
    lsl	w6,	w9,	#10
    movk	fp,	#32,	lsl #16
    ldr	x1,	[sp, fp]

    movz	fp,	#132
    add	x23,	x1,	x6
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]


main_59:
    movz	fp,	#80
    movz	w2,	#0
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#132
    lsl	w7,	w20,	#9
    movk	fp,	#32,	lsl #16
    ldr	x11,	[sp, fp]

    movz	fp,	#624
    add	x26,	x11,	x7
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#96
    mov	w26,	w15
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]


main_64:
    movz	fp,	#96
    mov	w8,	w26
    movk	fp,	#32,	lsl #16
    ldr	w9,	[sp, fp]

    movz	fp,	#624
    lsl	w1,	w9,	#8
    movk	fp,	#32,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#184
    add	x5,	x4,	x1
    movk	fp,	#32,	lsl #16
    movz	w4,	#0
    str	x5,	[sp, fp]

    movz	fp,	#112
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_69:
    movz	fp,	#112
    mov	w25,	w8
    movz	w10,	#0
    movk	fp,	#32,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#184
    lsl	w7,	w2,	#7
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#192
    add	x2,	x23,	x7
    movk	fp,	#32,	lsl #16
    str	x2,	[sp, fp]

    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]


main_74:
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#192
    lsl	w20,	w21,	#6
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#92
    add	x6,	x27,	x20
    movk	fp,	#32,	lsl #16
    movz	w20,	#0
    str	w20,	[sp, fp]


main_79:
    movz	fp,	#92
    mov	w2,	w25
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    mov	w9,	w11
    ldr	w1,	[sp, fp]

    movz	fp,	#76
    lsl	w15,	w1,	#5
    movk	fp,	#32,	lsl #16
    add	x8,	x6,	x15
    str	w9,	[sp, fp]


main_84:
    movz	fp,	#76
    mov	w10,	w2
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    mov	w26,	w16
    ldr	w11,	[sp, fp]

    lsl	w15,	w11,	#4
    add	x20,	x8,	x15

main_89:
    lsl	w11,	w26,	#3
    add	w19,	w10,	#1
    add	w16,	w26,	#1
    add	x18,	x20,	x11
    add	w22,	w19,	#1
    mov	x11,	x18
    str	w10,	[x11]

    add	x21,	x18,	#4
    str	w19,	[x21]

    cmp	w16,	#2
    blt	main_88

main_99:
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    ldr	w14,	[sp, fp]

    add	w15,	w14,	#1
    cmp	w15,	#2
    blt	main_83

main_102:
    movz	fp,	#92
    movk	fp,	#32,	lsl #16
    ldr	w2,	[sp, fp]

    add	w9,	w2,	#1
    cmp	w9,	#2
    blt	main_78

main_105:
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    ldr	w25,	[sp, fp]

    add	w6,	w25,	#1
    cmp	w6,	#2
    blt	main_73

main_108:
    movz	fp,	#112
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w25,	w7,	#1
    cmp	w25,	#2
    blt	main_68

main_111:
    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    ldr	w11,	[sp, fp]

    add	w16,	w11,	#1
    cmp	w16,	#2
    blt	main_63

main_114:
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    add	w10,	w23,	#1
    cmp	w10,	#2
    blt	main_58

main_117:
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w19,	w1,	#1
    cmp	w19,	#2
    blt	main_53

main_120:
    add	w11,	w12,	#1
    cmp	w11,	#2
    blt	main_48

main_123:
    add	w2,	w24,	#1
    cmp	w2,	#2
    blt	main_43

main_126:
    add	w5,	w3,	#1
    cmp	w5,	#2
    blt	main_38

main_129:
    add	w11,	w0,	#1
    cmp	w11,	#2
    blt	main_33

main_132:
    add	w2,	w13,	#1
    cmp	w2,	#2
    blt	main_28

main_135:
    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    ldr	w19,	[sp, fp]

    add	w4,	w19,	#1
    cmp	w4,	#2
    blt	main_23

main_138:
    movz	fp,	#140
    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    add	w4,	w28,	#1
    cmp	w4,	#2
    blt	main_18

main_141:
    movz	fp,	#152
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w13,	w7,	#1
    cmp	w13,	#2
    blt	main_13

main_144:
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    add	w13,	w16,	#1
    cmp	w13,	#2
    blt	main_8

main_147:
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    add	w4,	w23,	#1
    cmp	w4,	#2
    blt	main_3

main_150:
    add	x24,	sp,	#16
    movz	fp,	#176
    mov	x22,	x24
    movk	fp,	#32,	lsl #16
    mov	x21,	x22
    mov	x27,	x21
    mov	x0,	x27
    mov	x26,	x0
    str	x26,	[sp, fp]

    movz	fp,	#176
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#104
    mov	x18,	x20
    movk	fp,	#32,	lsl #16
    str	x18,	[sp, fp]

    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#592
    mov	x25,	x23
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#592
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#528
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#528
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#600
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#600
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#664
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#664
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#544
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#544
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#116
    ldr	w23,	[x23]

    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#664
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#236
    add	x19,	x19,	#8
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#236
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#488
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#116
    ldr	w26,	[x19]

    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#364
    add	w25,	w26,	w28
    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#600
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#640
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#640
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#656
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#656
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#364
    add	x23,	x25,	#4
    movk	fp,	#32,	lsl #16
    ldr	w28,	[x23]

    ldr	w26,	[sp, fp]

    movz	fp,	#528
    add	w23,	w26,	w28
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#648
    add	x26,	x25,	#32
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#648
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#552
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#552
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#456
    add	x25,	x26,	#8
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#456
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#520
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#216
    ldr	w19,	[x25]

    movk	fp,	#32,	lsl #16
    add	w26,	w23,	w19
    str	w26,	[sp, fp]

    movz	fp,	#592
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#560
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#560
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#244
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#244
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#480
    add	x23,	x26,	#16
    movk	fp,	#32,	lsl #16
    add	x23,	x23,	#8
    str	x23,	[sp, fp]

    movz	fp,	#480
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#608
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#608
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#216
    ldr	w26,	[x23]

    movk	fp,	#32,	lsl #16
    ldr	w19,	[sp, fp]

    movz	fp,	#16
    add	w26,	w19,	w26
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#512
    add	x19,	x23,	#128
    movk	fp,	#32,	lsl #16
    add	x19,	x19,	#64
    add	x23,	x19,	#32
    str	x23,	[sp, fp]

    movz	fp,	#512
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#568
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#568
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#84
    add	x19,	x23,	#4
    movk	fp,	#32,	lsl #16
    ldr	w28,	[x19]

    ldr	x23,	[sp, fp]

    add	w26,	w26,	w28
    movz	fp,	#104
    mov	x25,	x23
    mov	x28,	x20
    movk	fp,	#32,	lsl #16
    add	x25,	x25,	#32
    add	x19,	x25,	#16
    add	x23,	x19,	#8
    ldr	w25,	[x23]

    add	w19,	w26,	w25
    ldr	x25,	[sp, fp]

    movz	fp,	#176
    add	x25,	x25,	#512
    movk	fp,	#32,	lsl #16
    add	x26,	x25,	#256
    add	x25,	x26,	#128
    mov	x26,	x18
    mov	x18,	x26
    add	x23,	x25,	#64
    add	x26,	x18,	#128
    mov	x25,	x23
    add	x25,	x25,	#4
    add	x18,	x26,	#64
    ldr	w25,	[x25]

    add	x26,	x18,	#32
    add	w19,	w19,	w25
    ldr	w23,	[x26]

    mov	x26,	x20
    add	w23,	w19,	w23
    add	x26,	x26,	#512
    add	x26,	x26,	#256
    add	x26,	x26,	#32
    add	x26,	x26,	#4
    ldr	w18,	[x26]

    add	w26,	w23,	w18
    add	x18,	x28,	#1024
    add	x19,	x18,	#512
    add	x25,	x19,	#256
    add	x25,	x25,	#128
    add	x25,	x25,	#64
    add	x28,	x25,	#8
    add	x18,	x28,	#4
    ldr	w19,	[x18]

    ldr	x23,	[sp, fp]

    add	w26,	w26,	w19
    movz	fp,	#208
    add	x19,	x23,	#2048
    movk	fp,	#32,	lsl #16
    add	x25,	x19,	#1024
    add	x19,	x0,	#16384
    add	x20,	x25,	#128
    add	x23,	x19,	#8192
    add	x28,	x20,	#16
    add	x19,	x23,	#1024
    add	x25,	x28,	#8
    add	x20,	x19,	#512
    ldr	w28,	[x25]

    add	x25,	x20,	#256
    add	w28,	w26,	w28
    add	x25,	x25,	#32
    ldr	w20,	[x25]

    str	x0,	[sp, fp]

    add	w28,	w28,	w20
    movz	fp,	#208
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    add	x0,	x26,	#256
    add	x25,	x0,	#128
    add	x26,	x25,	#64
    add	x0,	x26,	#32
    mov	x26,	x27
    add	x23,	x0,	#16
    add	x0,	x23,	#8
    add	x0,	x0,	#4
    ldr	w23,	[x0]

    add	x0,	x26,	#64
    add	w23,	w28,	w23
    add	x0,	x0,	#32
    add	x0,	x0,	#16
    add	x0,	x0,	#8
    add	x0,	x0,	#4
    ldr	w0,	[x0]

    add	w18,	w23,	w0
    add	x0,	x21,	#131072
    add	x27,	x0,	#65536
    add	x0,	x27,	#32768
    add	x0,	x0,	#16384
    add	x23,	x0,	#512
    mov	x0,	x22
    mov	x22,	x0
    add	x25,	x23,	#256
    add	x28,	x22,	#8192
    add	x20,	x25,	#128
    add	x25,	x20,	#16
    ldr	w23,	[x25]

    add	w26,	w18,	w23
    add	x18,	x28,	#4096
    add	x0,	x18,	#2048
    add	x20,	x0,	#1024
    add	x25,	x20,	#512
    add	x20,	x24,	#524288
    add	x0,	x25,	#64
    add	x25,	x20,	#262144
    add	x18,	x0,	#16
    add	x0,	x25,	#32768
    add	x28,	x18,	#4
    add	x21,	x0,	#8192
    ldr	w18,	[x28]

    add	x0,	x21,	#512
    add	w26,	w26,	w18
    add	x20,	x0,	#256
    add	x21,	x20,	#128
    add	x28,	x21,	#64
    add	x25,	x28,	#8
    add	x0,	x25,	#4
    add	x25,	x24,	#262144
    ldr	w27,	[x0]

    add	x28,	x25,	#16384
    add	w22,	w26,	w27
    add	x0,	x28,	#2048
    add	x26,	x0,	#1024
    ldr	w0,	[x26]

    add	w0,	w22,	w0
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#768
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


main_3:
    mov	w18,	w22
    mov	w16,	w4
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	w16,	[sp, fp]

    b	main_4

main_8:
    mov	w19,	w22
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]

    b	main_9

main_13:
    mov	w19,	w22
    movz	fp,	#152
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]

    b	main_14

main_18:
    mov	w21,	w22
    mov	w24,	w4
    movz	fp,	#140
    movk	fp,	#32,	lsl #16
    str	w24,	[sp, fp]

    b	main_19

main_23:
    mov	w26,	w22
    mov	w1,	w4
    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_24

main_28:
    mov	w8,	w22
    mov	w13,	w2
    b	main_29

main_33:
    mov	w6,	w22
    mov	w0,	w11
    b	main_34

main_38:
    mov	w12,	w22
    mov	w3,	w5
    b	main_39

main_43:
    mov	w7,	w22
    mov	w24,	w2
    b	main_44

main_48:
    mov	w18,	w22
    mov	w12,	w11
    b	main_49

main_53:
    mov	w20,	w22
    mov	w2,	w19
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]

    b	main_54

main_58:
    mov	w15,	w22
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]

    b	main_59

main_63:
    mov	w26,	w22
    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    str	w16,	[sp, fp]

    b	main_64

main_68:
    mov	w8,	w22
    mov	w2,	w25
    movz	fp,	#112
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]

    b	main_69

main_73:
    mov	w25,	w22
    mov	w7,	w6
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_74

main_78:
    mov	w25,	w22
    mov	w8,	w9
    movz	fp,	#92
    movk	fp,	#32,	lsl #16
    str	w8,	[sp, fp]

    b	main_79

main_83:
    mov	w2,	w22
    mov	w14,	w15
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	w14,	[sp, fp]

    b	main_84

main_88:
    mov	w10,	w22
    mov	w26,	w16
    b	main_89

