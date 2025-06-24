.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#720
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#36
    movz	w4,	#0
    movz	w19,	#0
    movk	fp,	#32,	lsl #16
    mov	w20,	w19
    str	w4,	[sp, fp]


main_4:
    movz	fp,	#36
    mov	w21,	w20
    movz	w18,	#0
    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#48
    lsl	w8,	w22,	#20
    movk	fp,	#32,	lsl #16
    mov	x26,	x8
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    str	x26,	[sp, fp]

    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    str	w18,	[sp, fp]


main_9:
    movz	fp,	#32
    movz	w23,	#0
    movk	fp,	#32,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#48
    lsl	w11,	w14,	#19
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#144
    add	x12,	x5,	x11
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]

    movz	fp,	#140
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]


main_14:
    movz	fp,	#140
    mov	w20,	w21
    movk	fp,	#32,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#144
    lsl	w12,	w8,	#18
    movk	fp,	#32,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#132
    add	x4,	x14,	x12
    movk	fp,	#32,	lsl #16
    movz	w12,	#0
    str	x4,	[sp, fp]

    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]


main_19:
    movz	fp,	#128
    movz	w5,	#0
    movk	fp,	#32,	lsl #16
    mov	w28,	w5
    ldr	w0,	[sp, fp]

    movz	fp,	#132
    lsl	w14,	w0,	#17
    movk	fp,	#32,	lsl #16
    ldr	x17,	[sp, fp]

    movz	fp,	#120
    add	x26,	x17,	x14
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#108
    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]


main_24:
    movz	fp,	#108
    movz	w10,	#0
    movk	fp,	#32,	lsl #16
    mov	w25,	w10
    ldr	w17,	[sp, fp]

    movz	fp,	#120
    lsl	w17,	w17,	#16
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#100
    add	x13,	x8,	x17
    movk	fp,	#32,	lsl #16
    str	x13,	[sp, fp]


main_29:
    lsl	w16,	w25,	#15
    movz	fp,	#100
    mov	w22,	w20
    movz	w8,	#0
    movk	fp,	#32,	lsl #16
    mov	w2,	w8
    ldr	x0,	[sp, fp]

    movz	fp,	#328
    add	x26,	x0,	x16
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]


main_34:
    lsl	w10,	w2,	#14
    movz	fp,	#328
    mov	w24,	w22
    movz	w4,	#0
    movk	fp,	#32,	lsl #16
    mov	w28,	w4
    ldr	x3,	[sp, fp]

    movz	fp,	#336
    add	x5,	x3,	x10
    movk	fp,	#32,	lsl #16
    str	x5,	[sp, fp]


main_39:
    lsl	w9,	w28,	#13
    movz	fp,	#336
    mov	w6,	w24
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    mov	w24,	w11
    ldr	x5,	[sp, fp]

    movz	fp,	#352
    add	x10,	x5,	x9
    movk	fp,	#32,	lsl #16
    str	x10,	[sp, fp]


main_44:
    lsl	w16,	w24,	#12
    movz	fp,	#352
    movz	w26,	#0
    movk	fp,	#32,	lsl #16
    mov	w21,	w26
    ldr	x12,	[sp, fp]

    movz	fp,	#344
    add	x8,	x12,	x16
    movk	fp,	#32,	lsl #16
    str	x8,	[sp, fp]


main_49:
    lsl	w14,	w21,	#11
    movz	fp,	#344
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    mov	w1,	w11
    ldr	x3,	[sp, fp]

    movz	fp,	#56
    add	x16,	x3,	x14
    movk	fp,	#32,	lsl #16
    mov	w3,	w6
    str	w1,	[sp, fp]


main_54:
    movz	fp,	#56
    mov	w6,	w3
    movz	w13,	#0
    movk	fp,	#32,	lsl #16
    mov	w10,	w13
    ldr	w7,	[sp, fp]

    movz	fp,	#112
    lsl	w20,	w7,	#10
    movk	fp,	#32,	lsl #16
    add	x19,	x16,	x20
    str	x19,	[sp, fp]

    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]


main_59:
    movz	fp,	#64
    mov	w0,	w6
    movk	fp,	#32,	lsl #16
    movz	w6,	#0
    mov	w4,	w6
    ldr	w10,	[sp, fp]

    movz	fp,	#112
    lsl	w11,	w10,	#9
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#528
    add	x26,	x8,	x11
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_64:
    movz	fp,	#80
    mov	w7,	w0
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#528
    lsl	w1,	w6,	#8
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#160
    add	x18,	x27,	x1
    movk	fp,	#32,	lsl #16
    movz	w27,	#0
    mov	w23,	w27
    str	x18,	[sp, fp]

    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]


main_69:
    movz	fp,	#96
    mov	w0,	w7
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    mov	w27,	w3
    ldr	w1,	[sp, fp]

    movz	fp,	#160
    lsl	w10,	w1,	#7
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#168
    add	x20,	x19,	x10
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]


main_74:
    movz	fp,	#84
    movz	w15,	#0
    movk	fp,	#32,	lsl #16
    mov	w10,	w15
    ldr	w13,	[sp, fp]

    movz	fp,	#168
    lsl	w23,	w13,	#6
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#76
    add	x8,	x26,	x23
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]


main_79:
    movz	fp,	#76
    movz	w6,	#0
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    movz	fp,	#188
    lsl	w11,	w1,	#5
    movk	fp,	#32,	lsl #16
    add	x3,	x8,	x11
    str	x3,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]


main_84:
    movz	fp,	#60
    mov	w23,	w0
    movz	w7,	#0
    movk	fp,	#32,	lsl #16
    mov	w20,	w7
    ldr	w6,	[sp, fp]

    movz	fp,	#188
    lsl	w1,	w6,	#4
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    add	x4,	x5,	x1

main_89:
    lsl	w0,	w20,	#3
    add	w1,	w23,	#1
    add	x0,	x4,	x0
    mov	x13,	x0
    str	w23,	[x13]

    add	x11,	x0,	#4
    str	w1,	[x11]

    add	w11,	w20,	#1
    add	w1,	w1,	#1
    cmp	w11,	#2
    blt	main_88

main_99:
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w11,	w7,	#1
    cmp	w11,	#2
    blt	main_83

main_102:
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    ldr	w3,	[sp, fp]

    add	w11,	w3,	#1
    cmp	w11,	#2
    blt	main_78

main_105:
    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	w18,	[sp, fp]

    add	w10,	w18,	#1
    cmp	w10,	#2
    blt	main_73

main_108:
    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    ldr	w3,	[sp, fp]

    add	w19,	w3,	#1
    cmp	w19,	#2
    blt	main_68

main_111:
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w15,	w7,	#1
    cmp	w15,	#2
    blt	main_63

main_114:
    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    ldr	w13,	[sp, fp]

    add	w13,	w13,	#1
    cmp	w13,	#2
    blt	main_58

main_117:
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w12,	w0,	#1
    cmp	w12,	#2
    blt	main_53

main_120:
    add	w4,	w21,	#1
    cmp	w4,	#2
    blt	main_48

main_123:
    add	w8,	w24,	#1
    cmp	w8,	#2
    blt	main_43

main_126:
    add	w22,	w28,	#1
    cmp	w22,	#2
    blt	main_38

main_129:
    add	w9,	w2,	#1
    cmp	w9,	#2
    blt	main_33

main_132:
    add	w25,	w25,	#1
    cmp	w25,	#2
    blt	main_28

main_135:
    movz	fp,	#108
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    add	w16,	w20,	#1
    cmp	w16,	#2
    blt	main_23

main_138:
    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    ldr	w3,	[sp, fp]

    add	w10,	w3,	#1
    cmp	w10,	#2
    blt	main_18

main_141:
    movz	fp,	#140
    movk	fp,	#32,	lsl #16
    ldr	w11,	[sp, fp]

    add	w12,	w11,	#1
    cmp	w12,	#2
    blt	main_13

main_144:
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    ldr	w17,	[sp, fp]

    add	w23,	w17,	#1
    cmp	w23,	#2
    blt	main_8

main_147:
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    add	w4,	w23,	#1
    cmp	w4,	#2
    blt	main_3

main_150:
    add	x19,	sp,	#16
    movz	fp,	#152
    mov	x0,	x19
    movk	fp,	#32,	lsl #16
    mov	x21,	x0
    mov	x26,	x21
    mov	x18,	x26
    mov	x25,	x18
    str	x25,	[sp, fp]

    movz	fp,	#152
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#88
    mov	x27,	x20
    movk	fp,	#32,	lsl #16
    mov	x25,	x27
    mov	x24,	x25
    str	x24,	[sp, fp]

    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#16
    mov	x28,	x20
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#624
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#624
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#304
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#304
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#544
    movk	fp,	#32,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#544
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#688
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#688
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#324
    ldr	w28,	[x24]

    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#304
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#616
    add	x24,	x23,	#8
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#616
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#324
    ldr	w23,	[x22]

    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#320
    add	w23,	w23,	w22
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#624
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#592
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#592
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#696
    movk	fp,	#32,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#696
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#320
    add	x22,	x23,	#4
    movk	fp,	#32,	lsl #16
    ldr	w23,	[x22]

    ldr	w22,	[sp, fp]

    movz	fp,	#316
    add	w23,	w22,	w23
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#576
    add	x28,	x24,	#32
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#576
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#584
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#584
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#560
    add	x23,	x28,	#8
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#560
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#568
    movk	fp,	#32,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#568
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#316
    ldr	w23,	[x23]

    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    movz	fp,	#196
    add	w28,	w28,	w23
    movk	fp,	#32,	lsl #16
    mov	x23,	x20
    str	w28,	[sp, fp]

    movz	fp,	#600
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#600
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#608
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#608
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#704
    add	x22,	x22,	#16
    movk	fp,	#32,	lsl #16
    add	x22,	x22,	#8
    str	x22,	[sp, fp]

    movz	fp,	#704
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#552
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#552
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#196
    ldr	w22,	[x20]

    movk	fp,	#32,	lsl #16
    ldr	w24,	[sp, fp]

    movz	fp,	#40
    add	w22,	w24,	w22
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#184
    add	x20,	x23,	#128
    movk	fp,	#32,	lsl #16
    add	x20,	x20,	#64
    add	x20,	x20,	#32
    add	x23,	x20,	#4
    ldr	w20,	[x23]

    add	w20,	w22,	w20
    str	w20,	[sp, fp]

    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#184
    add	x28,	x20,	#32
    movk	fp,	#32,	lsl #16
    add	x20,	x28,	#16
    add	x20,	x20,	#8
    ldr	w20,	[x20]

    ldr	w24,	[sp, fp]

    movz	fp,	#312
    add	w22,	w24,	w20
    movk	fp,	#32,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#312
    add	x22,	x24,	#512
    movk	fp,	#32,	lsl #16
    add	x24,	x22,	#256
    add	x20,	x24,	#128
    add	x20,	x20,	#64
    add	x20,	x20,	#4
    ldr	w24,	[x20]

    ldr	w20,	[sp, fp]

    movz	fp,	#152
    add	w22,	w20,	w24
    movk	fp,	#32,	lsl #16
    mov	x24,	x25
    add	x24,	x24,	#128
    add	x28,	x24,	#64
    mov	x24,	x27
    add	x20,	x28,	#32
    ldr	w25,	[x20]

    add	w28,	w22,	w25
    add	x22,	x18,	#16384
    add	x25,	x24,	#512
    add	x24,	x25,	#256
    add	x24,	x24,	#32
    add	x25,	x24,	#4
    ldr	w20,	[x25]

    add	w24,	w28,	w20
    add	x20,	x27,	#1024
    add	x25,	x20,	#512
    add	x27,	x25,	#256
    add	x28,	x27,	#128
    add	x27,	x22,	#8192
    add	x20,	x28,	#64
    add	x23,	x20,	#8
    add	x20,	x23,	#4
    ldr	w25,	[x20]

    add	w28,	w24,	w25
    ldr	x24,	[sp, fp]

    add	x23,	x24,	#2048
    add	x20,	x23,	#1024
    add	x20,	x20,	#128
    add	x20,	x20,	#16
    add	x20,	x20,	#8
    ldr	w23,	[x20]

    add	w24,	w28,	w23
    add	x28,	x27,	#1024
    mov	x27,	x26
    mov	x22,	x27
    add	x25,	x28,	#512
    add	x27,	x22,	#256
    add	x25,	x25,	#256
    add	x18,	x25,	#32
    ldr	w25,	[x18]

    add	x18,	x27,	#128
    add	w23,	w24,	w25
    mov	x24,	x21
    mov	x26,	x24
    add	x20,	x18,	#64
    add	x18,	x20,	#32
    add	x20,	x18,	#16
    add	x18,	x20,	#8
    add	x20,	x18,	#4
    add	x18,	x0,	#131072
    ldr	w22,	[x20]

    add	x20,	x18,	#65536
    add	w25,	w23,	w22
    add	x22,	x26,	#64
    add	x21,	x20,	#32768
    add	x23,	x22,	#32
    add	x18,	x21,	#16384
    add	x24,	x23,	#16
    add	x21,	x0,	#8192
    add	x26,	x24,	#8
    add	x23,	x21,	#4096
    add	x26,	x26,	#4
    add	x0,	x23,	#2048
    ldr	w27,	[x26]

    add	w25,	w25,	w27
    add	x27,	x18,	#512
    add	x27,	x27,	#256
    add	x27,	x27,	#128
    add	x18,	x27,	#16
    ldr	w26,	[x18]

    add	w27,	w25,	w26
    add	x25,	x0,	#1024
    add	x21,	x25,	#512
    add	x25,	x19,	#524288
    add	x26,	x21,	#64
    add	x26,	x26,	#16
    add	x21,	x26,	#4
    ldr	w23,	[x21]

    add	x21,	x25,	#262144
    add	w23,	w27,	w23
    add	x26,	x21,	#32768
    add	x0,	x26,	#8192
    add	x0,	x0,	#512
    add	x25,	x0,	#256
    add	x26,	x25,	#128
    add	x24,	x26,	#64
    add	x18,	x24,	#8
    add	x0,	x18,	#4
    ldr	w20,	[x0]

    add	w28,	w23,	w20
    mov	x23,	x19
    add	x20,	x23,	#262144
    add	x23,	x20,	#16384
    add	x24,	x23,	#2048
    add	x21,	x24,	#1024
    ldr	w0,	[x21]

    add	w0,	w28,	w0
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#720
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


main_3:
    mov	w20,	w1
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]

    b	main_4

main_8:
    mov	w21,	w1
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    b	main_9

main_13:
    mov	w21,	w1
    movz	fp,	#140
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]

    b	main_14

main_18:
    mov	w20,	w1
    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]

    b	main_19

main_23:
    mov	w20,	w1
    movz	fp,	#108
    movk	fp,	#32,	lsl #16
    str	w16,	[sp, fp]

    b	main_24

main_28:
    mov	w20,	w1
    b	main_29

main_33:
    mov	w22,	w1
    mov	w2,	w9
    b	main_34

main_38:
    mov	w24,	w1
    mov	w28,	w22
    b	main_39

main_43:
    mov	w6,	w1
    mov	w24,	w8
    b	main_44

main_48:
    mov	w6,	w1
    mov	w21,	w4
    b	main_49

main_53:
    mov	w3,	w1
    movz	fp,	#56
    mov	w1,	w12
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_54

main_58:
    mov	w6,	w1
    mov	w5,	w13
    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    str	w5,	[sp, fp]

    b	main_59

main_63:
    mov	w0,	w1
    mov	w12,	w15
    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]

    b	main_64

main_68:
    mov	w7,	w1
    movz	fp,	#96
    mov	w1,	w19
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_69

main_73:
    mov	w0,	w1
    mov	w7,	w10
    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_74

main_78:
    mov	w0,	w1
    mov	w26,	w11
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	w26,	[sp, fp]

    b	main_79

main_83:
    mov	w0,	w1
    mov	w10,	w11
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]

    b	main_84

main_88:
    mov	w23,	w1
    mov	w20,	w11
    b	main_89

