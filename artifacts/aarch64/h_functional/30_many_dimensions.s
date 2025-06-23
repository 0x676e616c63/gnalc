.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#592
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#52
    movz	w3,	#0
    movz	w15,	#0
    movk	fp,	#32,	lsl #16
    mov	w16,	w15
    str	w3,	[sp, fp]


main_4:
    movz	fp,	#52
    mov	w19,	w16
    movz	w22,	#0
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#56
    lsl	w8,	w21,	#20
    movk	fp,	#32,	lsl #16
    mov	x25,	x8
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    str	x25,	[sp, fp]

    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	w22,	[sp, fp]


main_9:
    movz	fp,	#48
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#56
    lsl	w10,	w14,	#19
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#152
    add	x12,	x5,	x10
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]

    movz	fp,	#148
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]


main_14:
    movz	fp,	#148
    mov	w18,	w19
    movk	fp,	#32,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#152
    lsl	w12,	w8,	#18
    movk	fp,	#32,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#140
    add	x4,	x14,	x12
    movk	fp,	#32,	lsl #16
    movz	w14,	#0
    str	x4,	[sp, fp]

    movz	fp,	#136
    movk	fp,	#32,	lsl #16
    str	w14,	[sp, fp]


main_19:
    movz	fp,	#136
    movz	w12,	#0
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#140
    lsl	w16,	w0,	#17
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#128
    add	x25,	x5,	x16
    movk	fp,	#32,	lsl #16
    mov	w16,	w18
    str	x25,	[sp, fp]

    movz	fp,	#116
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]


main_24:
    movz	fp,	#116
    mov	w15,	w16
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    mov	w23,	w11
    ldr	w18,	[sp, fp]

    movz	fp,	#128
    lsl	w18,	w18,	#16
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#108
    add	x13,	x27,	x18
    movk	fp,	#32,	lsl #16
    str	x13,	[sp, fp]


main_29:
    lsl	w17,	w23,	#15
    movz	fp,	#108
    mov	w25,	w15
    movz	w5,	#0
    movk	fp,	#32,	lsl #16
    mov	w24,	w5
    ldr	x27,	[sp, fp]

    add	x16,	x27,	x17

main_34:
    lsl	w7,	w24,	#14
    movz	fp,	#232
    mov	w28,	w25
    movz	w10,	#0
    add	x9,	x16,	x7
    movk	fp,	#32,	lsl #16
    mov	w12,	w10
    str	x9,	[sp, fp]


main_39:
    lsl	w6,	w12,	#13
    movz	fp,	#232
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#248
    add	x14,	x8,	x6
    movk	fp,	#32,	lsl #16
    mov	w6,	w28
    str	x14,	[sp, fp]

    movz	w14,	#0
    mov	w1,	w14

main_44:
    lsl	w14,	w1,	#12
    movz	fp,	#248
    mov	w7,	w6
    movz	w27,	#0
    movk	fp,	#32,	lsl #16
    mov	w26,	w27
    ldr	x17,	[sp, fp]

    movz	fp,	#240
    add	x11,	x17,	x14
    movk	fp,	#32,	lsl #16
    str	x11,	[sp, fp]


main_49:
    lsl	w18,	w26,	#11
    movz	fp,	#240
    mov	w8,	w7
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    mov	w5,	w11
    ldr	x0,	[sp, fp]

    movz	fp,	#224
    add	x20,	x0,	x18
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    str	w5,	[sp, fp]


main_54:
    movz	fp,	#64
    mov	w4,	w8
    movz	w13,	#0
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#224
    lsl	w11,	w6,	#10
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#120
    add	x18,	x21,	x11
    movk	fp,	#32,	lsl #16
    str	x18,	[sp, fp]

    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]


main_59:
    movz	fp,	#72
    mov	w2,	w4
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    ldr	w10,	[sp, fp]

    movz	fp,	#120
    lsl	w14,	w10,	#9
    movk	fp,	#32,	lsl #16
    ldr	x9,	[sp, fp]

    movz	fp,	#88
    add	x19,	x9,	x14
    movk	fp,	#32,	lsl #16
    str	w3,	[sp, fp]


main_64:
    movz	fp,	#88
    mov	w4,	w2
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    movz	fp,	#168
    lsl	w0,	w6,	#8
    movk	fp,	#32,	lsl #16
    add	x25,	x19,	x0
    movz	w0,	#0
    mov	w27,	w0
    str	x25,	[sp, fp]

    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]


main_69:
    movz	fp,	#104
    mov	w0,	w4
    movk	fp,	#32,	lsl #16
    movz	w4,	#0
    ldr	w2,	[sp, fp]

    movz	fp,	#168
    lsl	w10,	w2,	#7
    movk	fp,	#32,	lsl #16
    mov	w2,	w4
    ldr	x18,	[sp, fp]

    movz	fp,	#364
    add	x6,	x18,	x10
    movk	fp,	#32,	lsl #16
    str	x6,	[sp, fp]

    movz	fp,	#92
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]


main_74:
    movz	fp,	#92
    movz	w17,	#0
    movk	fp,	#32,	lsl #16
    mov	w10,	w17
    ldr	w14,	[sp, fp]

    movz	fp,	#364
    lsl	w27,	w14,	#6
    movk	fp,	#32,	lsl #16
    ldr	x7,	[sp, fp]

    movz	fp,	#84
    add	x20,	x7,	x27
    movk	fp,	#32,	lsl #16
    str	w10,	[sp, fp]


main_79:
    movz	fp,	#84
    mov	w21,	w0
    movz	w2,	#0
    movk	fp,	#32,	lsl #16
    mov	w4,	w2
    ldr	w3,	[sp, fp]

    movz	fp,	#184
    lsl	w10,	w3,	#5
    movk	fp,	#32,	lsl #16
    add	x5,	x20,	x10
    str	x5,	[sp, fp]

    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_84:
    movz	fp,	#68
    mov	w4,	w21
    movk	fp,	#32,	lsl #16
    movz	w21,	#0
    mov	w11,	w21
    ldr	w5,	[sp, fp]

    movz	fp,	#184
    lsl	w14,	w5,	#4
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    add	x9,	x0,	x14

main_89:
    lsl	w0,	w11,	#3
    add	w3,	w4,	#1
    add	w7,	w11,	#1
    add	x0,	x9,	x0
    add	w25,	w3,	#1
    mov	x15,	x0
    str	w4,	[x15]

    add	x14,	x0,	#4
    str	w3,	[x14]

    cmp	w7,	#2
    blt	main_88

main_99:
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w2,	w7,	#1
    cmp	w2,	#2
    blt	main_83

main_102:
    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	w2,	[sp, fp]

    add	w17,	w2,	#1
    cmp	w17,	#2
    blt	main_78

main_105:
    movz	fp,	#92
    movk	fp,	#32,	lsl #16
    ldr	w18,	[sp, fp]

    add	w11,	w18,	#1
    cmp	w11,	#2
    blt	main_73

main_108:
    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    ldr	w3,	[sp, fp]

    add	w22,	w3,	#1
    cmp	w22,	#2
    blt	main_68

main_111:
    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    ldr	w8,	[sp, fp]

    add	w15,	w8,	#1
    cmp	w15,	#2
    blt	main_63

main_114:
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	w13,	[sp, fp]

    add	w13,	w13,	#1
    cmp	w13,	#2
    blt	main_58

main_117:
    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w11,	w0,	#1
    cmp	w11,	#2
    blt	main_53

main_120:
    add	w3,	w26,	#1
    cmp	w3,	#2
    blt	main_48

main_123:
    add	w0,	w1,	#1
    cmp	w0,	#2
    blt	main_43

main_126:
    add	w22,	w12,	#1
    cmp	w22,	#2
    blt	main_38

main_129:
    add	w9,	w24,	#1
    cmp	w9,	#2
    blt	main_33

main_132:
    add	w23,	w23,	#1
    cmp	w23,	#2
    blt	main_28

main_135:
    movz	fp,	#116
    movk	fp,	#32,	lsl #16
    ldr	w19,	[sp, fp]

    add	w13,	w19,	#1
    cmp	w13,	#2
    blt	main_23

main_138:
    movz	fp,	#136
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w19,	w1,	#1
    cmp	w19,	#2
    blt	main_18

main_141:
    movz	fp,	#148
    movk	fp,	#32,	lsl #16
    ldr	w10,	[sp, fp]

    add	w3,	w10,	#1
    cmp	w3,	#2
    blt	main_13

main_144:
    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    add	w27,	w16,	#1
    cmp	w27,	#2
    blt	main_8

main_147:
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    add	w12,	w22,	#1
    cmp	w12,	#2
    blt	main_3

main_150:
    add	x19,	sp,	#16
    movz	fp,	#160
    mov	x0,	x19
    movk	fp,	#32,	lsl #16
    mov	x26,	x0
    mov	x24,	x26
    mov	x18,	x24
    str	x18,	[sp, fp]

    add	x18,	x18,	#16384
    movz	fp,	#160
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#96
    mov	x28,	x22
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#96
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#564
    mov	x20,	x23
    movk	fp,	#32,	lsl #16
    mov	x21,	x20
    str	x21,	[sp, fp]

    movz	fp,	#564
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#352
    movk	fp,	#32,	lsl #16
    str	x21,	[sp, fp]

    movz	fp,	#352
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#556
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#556
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#344
    movk	fp,	#32,	lsl #16
    str	x21,	[sp, fp]

    movz	fp,	#344
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#220
    ldr	w23,	[x23]

    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#556
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#32
    add	x25,	x21,	#8
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#336
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#336
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#360
    ldr	w25,	[x21]

    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#220
    movk	fp,	#32,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#360
    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#216
    add	w25,	w27,	w25
    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#352
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#380
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#380
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#580
    movk	fp,	#32,	lsl #16
    str	x21,	[sp, fp]

    movz	fp,	#580
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#536
    add	x21,	x23,	#4
    movk	fp,	#32,	lsl #16
    ldr	w27,	[x21]

    str	w27,	[sp, fp]

    movz	fp,	#216
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#536
    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#212
    add	w21,	w21,	w27
    movk	fp,	#32,	lsl #16
    str	w21,	[sp, fp]

    movz	fp,	#564
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#264
    add	x21,	x21,	#32
    movk	fp,	#32,	lsl #16
    str	x21,	[sp, fp]

    movz	fp,	#264
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#572
    add	x25,	x21,	#8
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#572
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#256
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#256
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#212
    ldr	w21,	[x25]

    movk	fp,	#32,	lsl #16
    ldr	w25,	[sp, fp]

    movz	fp,	#192
    add	w25,	w25,	w21
    movk	fp,	#32,	lsl #16
    mov	x21,	x20
    str	w25,	[sp, fp]

    movz	fp,	#372
    movk	fp,	#32,	lsl #16
    str	x21,	[sp, fp]

    movz	fp,	#372
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#196
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#196
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#540
    add	x27,	x27,	#16
    movk	fp,	#32,	lsl #16
    add	x20,	x27,	#8
    str	x20,	[sp, fp]

    movz	fp,	#540
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#548
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#192
    ldr	w27,	[x27]

    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    movz	fp,	#16
    add	w21,	w21,	w27
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#532
    add	x20,	x25,	#128
    movk	fp,	#32,	lsl #16
    add	x27,	x20,	#64
    add	x20,	x27,	#32
    add	x27,	x20,	#4
    ldr	w27,	[x27]

    add	w23,	w21,	w27
    str	w23,	[sp, fp]

    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#532
    mov	x20,	x23
    movk	fp,	#32,	lsl #16
    add	x27,	x20,	#32
    add	x25,	x27,	#16
    add	x25,	x25,	#8
    ldr	w21,	[x25]

    ldr	w25,	[sp, fp]

    movz	fp,	#96
    add	w27,	w25,	w21
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#160
    add	x23,	x20,	#512
    movk	fp,	#32,	lsl #16
    add	x20,	x23,	#256
    add	x20,	x20,	#128
    add	x23,	x20,	#64
    add	x20,	x23,	#4
    ldr	w20,	[x20]

    add	w21,	w27,	w20
    mov	x20,	x28
    mov	x28,	x20
    add	x25,	x28,	#128
    add	x20,	x25,	#64
    add	x28,	x20,	#32
    mov	x20,	x22
    ldr	w23,	[x28]

    add	w27,	w21,	w23
    add	x21,	x20,	#512
    add	x20,	x21,	#256
    add	x20,	x20,	#32
    add	x21,	x20,	#4
    ldr	w25,	[x21]

    add	w27,	w27,	w25
    mov	x25,	x22
    mov	x22,	x25
    add	x20,	x22,	#1024
    add	x28,	x20,	#512
    add	x20,	x28,	#256
    add	x21,	x20,	#128
    add	x25,	x21,	#64
    add	x23,	x25,	#8
    add	x20,	x23,	#4
    ldr	w28,	[x20]

    ldr	x23,	[sp, fp]

    add	w20,	w27,	w28
    movz	fp,	#204
    add	x23,	x23,	#2048
    movk	fp,	#32,	lsl #16
    add	x25,	x23,	#1024
    add	x23,	x25,	#128
    add	x22,	x23,	#16
    add	x25,	x22,	#8
    ldr	w23,	[x25]

    add	w21,	w20,	w23
    add	x20,	x18,	#8192
    add	x23,	x20,	#1024
    add	x23,	x23,	#512
    add	x18,	x23,	#256
    add	x22,	x18,	#32
    ldr	w23,	[x22]

    str	x24,	[sp, fp]

    add	w22,	w21,	w23
    movz	fp,	#204
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    add	x24,	x23,	#256
    add	x25,	x24,	#128
    add	x27,	x25,	#64
    add	x20,	x27,	#32
    add	x18,	x20,	#16
    add	x18,	x18,	#8
    add	x20,	x18,	#4
    mov	x18,	x26
    ldr	w21,	[x20]

    add	w28,	w22,	w21
    mov	x21,	x18
    add	x18,	x0,	#131072
    add	x22,	x21,	#64
    add	x20,	x18,	#65536
    add	x23,	x22,	#32
    add	x21,	x20,	#32768
    add	x24,	x23,	#16
    add	x18,	x21,	#16384
    add	x26,	x24,	#8
    add	x21,	x0,	#8192
    add	x26,	x26,	#4
    ldr	w27,	[x26]

    add	w28,	w28,	w27
    add	x27,	x18,	#512
    add	x27,	x27,	#256
    add	x23,	x27,	#128
    add	x26,	x23,	#16
    add	x23,	x21,	#4096
    ldr	w26,	[x26]

    add	x0,	x23,	#2048
    add	w27,	w28,	w26
    add	x25,	x0,	#1024
    add	x18,	x25,	#512
    add	x25,	x19,	#524288
    add	x21,	x18,	#64
    add	x18,	x25,	#262144
    add	x22,	x21,	#16
    add	x21,	x22,	#4
    ldr	w23,	[x21]

    add	x21,	x18,	#32768
    add	w22,	w27,	w23
    mov	x27,	x19
    add	x25,	x21,	#8192
    add	x0,	x25,	#512
    add	x25,	x0,	#256
    add	x26,	x25,	#128
    add	x20,	x26,	#64
    add	x18,	x20,	#8
    add	x0,	x18,	#4
    ldr	w20,	[x0]

    add	w28,	w22,	w20
    add	x20,	x27,	#262144
    add	x23,	x20,	#16384
    add	x24,	x23,	#2048
    add	x21,	x24,	#1024
    ldr	w0,	[x21]

    add	w0,	w28,	w0
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#592
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


main_3:
    mov	w16,	w25
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]

    b	main_4

main_8:
    mov	w19,	w25
    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    b	main_9

main_13:
    mov	w19,	w25
    movz	fp,	#148
    movk	fp,	#32,	lsl #16
    str	w3,	[sp, fp]

    b	main_14

main_18:
    mov	w18,	w25
    movz	fp,	#136
    movk	fp,	#32,	lsl #16
    str	w19,	[sp, fp]

    b	main_19

main_23:
    mov	w16,	w25
    movz	fp,	#116
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]

    b	main_24

main_28:
    mov	w15,	w25
    b	main_29

main_33:
    mov	w24,	w9
    b	main_34

main_38:
    mov	w28,	w25
    mov	w12,	w22
    b	main_39

main_43:
    mov	w6,	w25
    mov	w1,	w0
    b	main_44

main_48:
    mov	w7,	w25
    mov	w26,	w3
    b	main_49

main_53:
    mov	w8,	w25
    mov	w2,	w11
    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]

    b	main_54

main_58:
    mov	w4,	w25
    mov	w5,	w13
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w5,	[sp, fp]

    b	main_59

main_63:
    mov	w2,	w25
    mov	w13,	w15
    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]

    b	main_64

main_68:
    mov	w4,	w25
    mov	w7,	w22
    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_69

main_73:
    mov	w0,	w25
    mov	w8,	w11
    movz	fp,	#92
    movk	fp,	#32,	lsl #16
    str	w8,	[sp, fp]

    b	main_74

main_78:
    mov	w0,	w25
    mov	w28,	w17
    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]

    b	main_79

main_83:
    mov	w21,	w25
    mov	w7,	w2
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_84

main_88:
    mov	w4,	w25
    mov	w11,	w7
    b	main_89

