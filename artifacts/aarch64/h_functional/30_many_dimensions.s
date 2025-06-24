.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#976
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#36
    movz	w3,	#0
    movz	w13,	#0
    movk	fp,	#32,	lsl #16
    mov	w14,	w13
    str	w3,	[sp, fp]


main_4:
    movz	fp,	#36
    mov	w15,	w14
    movz	w6,	#0
    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#40
    lsl	w8,	w22,	#20
    movk	fp,	#32,	lsl #16
    mov	x27,	x8
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    str	x27,	[sp, fp]

    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]


main_9:
    movz	fp,	#32
    mov	w14,	w15
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    ldr	w17,	[sp, fp]

    movz	fp,	#40
    lsl	w12,	w17,	#19
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#136
    add	x12,	x5,	x12
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]

    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    str	w11,	[sp, fp]


main_14:
    movz	fp,	#124
    mov	w15,	w14
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    ldr	w5,	[sp, fp]

    movz	fp,	#136
    lsl	w1,	w5,	#18
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#128
    add	x9,	x0,	x1
    movk	fp,	#32,	lsl #16
    str	x9,	[sp, fp]

    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    str	w3,	[sp, fp]


main_19:
    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    movz	fp,	#128
    lsl	w6,	w0,	#17
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#112
    add	x28,	x27,	x6
    movk	fp,	#32,	lsl #16
    movz	w6,	#0
    str	x28,	[sp, fp]

    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]


main_24:
    movz	fp,	#100
    mov	w14,	w15
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    mov	w19,	w16
    ldr	w20,	[sp, fp]

    movz	fp,	#112
    lsl	w11,	w20,	#16
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#92
    add	x17,	x8,	x11
    movk	fp,	#32,	lsl #16
    str	x17,	[sp, fp]


main_29:
    lsl	w20,	w19,	#15
    movz	fp,	#92
    mov	w17,	w14
    movz	w5,	#0
    movk	fp,	#32,	lsl #16
    mov	w15,	w5
    ldr	x0,	[sp, fp]

    movz	fp,	#332
    add	x20,	x0,	x20
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]


main_34:
    lsl	w12,	w15,	#14
    movz	fp,	#332
    mov	w21,	w17
    movz	w11,	#0
    movk	fp,	#32,	lsl #16
    mov	w20,	w11
    ldr	x3,	[sp, fp]

    movz	fp,	#348
    add	x2,	x3,	x12
    movk	fp,	#32,	lsl #16
    str	x2,	[sp, fp]


main_39:
    lsl	w27,	w20,	#13
    movz	fp,	#348
    mov	w26,	w21
    movz	w13,	#0
    movk	fp,	#32,	lsl #16
    mov	w6,	w13
    ldr	x3,	[sp, fp]

    movz	fp,	#364
    add	x11,	x3,	x27
    movk	fp,	#32,	lsl #16
    str	x11,	[sp, fp]


main_44:
    lsl	w2,	w6,	#12
    movz	fp,	#364
    mov	w1,	w26
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    ldr	x7,	[sp, fp]

    movz	fp,	#356
    add	x12,	x7,	x2
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]


main_49:
    lsl	w0,	w3,	#11
    movz	fp,	#356
    mov	w28,	w1
    movz	w18,	#0
    movk	fp,	#32,	lsl #16
    ldr	x14,	[sp, fp]

    movz	fp,	#340
    add	x23,	x14,	x0
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	w18,	[sp, fp]


main_54:
    movz	fp,	#48
    mov	w2,	w28
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    ldr	w18,	[sp, fp]

    movz	fp,	#340
    lsl	w21,	w18,	#10
    movk	fp,	#32,	lsl #16
    ldr	x7,	[sp, fp]

    movz	fp,	#104
    add	x0,	x7,	x21
    movk	fp,	#32,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w16,	[sp, fp]


main_59:
    movz	fp,	#56
    mov	w1,	w2
    movz	w24,	#0
    movk	fp,	#32,	lsl #16
    mov	w22,	w24
    ldr	w7,	[sp, fp]

    movz	fp,	#104
    lsl	w21,	w7,	#9
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#624
    add	x18,	x8,	x21
    movk	fp,	#32,	lsl #16
    str	x18,	[sp, fp]

    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w22,	[sp, fp]


main_64:
    movz	fp,	#72
    movz	w24,	#0
    movk	fp,	#32,	lsl #16
    mov	w21,	w24
    ldr	w23,	[sp, fp]

    movz	fp,	#624
    lsl	w0,	w23,	#8
    movk	fp,	#32,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#152
    add	x5,	x4,	x0
    movk	fp,	#32,	lsl #16
    mov	w0,	w1
    str	x5,	[sp, fp]

    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    str	w21,	[sp, fp]


main_69:
    movz	fp,	#88
    mov	w14,	w0
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    mov	w1,	w16
    ldr	w11,	[sp, fp]

    movz	fp,	#152
    lsl	w7,	w11,	#7
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#372
    add	x12,	x8,	x7
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]

    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]


main_74:
    movz	fp,	#76
    mov	w16,	w14
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#372
    lsl	w12,	w23,	#6
    movk	fp,	#32,	lsl #16
    mov	w23,	w0
    ldr	x13,	[sp, fp]

    movz	fp,	#68
    add	x12,	x13,	x12
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]


main_79:
    movz	fp,	#68
    mov	w8,	w16
    movz	w14,	#0
    movk	fp,	#32,	lsl #16
    ldr	w2,	[sp, fp]

    movz	fp,	#168
    lsl	w0,	w2,	#5
    movk	fp,	#32,	lsl #16
    add	x1,	x12,	x0
    mov	w0,	w14
    str	x1,	[sp, fp]

    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]


main_84:
    movz	fp,	#52
    mov	w14,	w8
    movz	w2,	#0
    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#168
    lsl	w0,	w27,	#4
    movk	fp,	#32,	lsl #16
    ldr	x1,	[sp, fp]

    add	x27,	x1,	x0
    mov	w1,	w2

main_89:
    lsl	w24,	w1,	#3
    add	w13,	w1,	#1
    add	x11,	x27,	x24
    add	w24,	w14,	#1
    mov	x7,	x11
    str	w14,	[x7]

    add	x21,	x11,	#4
    add	w7,	w24,	#1
    str	w24,	[x21]

    cmp	w13,	#2
    blt	main_88

main_99:
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    add	w18,	w28,	#1
    cmp	w18,	#2
    blt	main_83

main_102:
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    ldr	w14,	[sp, fp]

    add	w17,	w14,	#1
    cmp	w17,	#2
    blt	main_78

main_105:
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    add	w27,	w21,	#1
    cmp	w27,	#2
    blt	main_73

main_108:
    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    ldr	w12,	[sp, fp]

    add	w28,	w12,	#1
    cmp	w28,	#2
    blt	main_68

main_111:
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	w25,	[sp, fp]

    add	w5,	w25,	#1
    cmp	w5,	#2
    blt	main_63

main_114:
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    ldr	w5,	[sp, fp]

    add	w4,	w5,	#1
    cmp	w4,	#2
    blt	main_58

main_117:
    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    add	w25,	w21,	#1
    cmp	w25,	#2
    blt	main_53

main_120:
    add	w3,	w3,	#1
    cmp	w3,	#2
    blt	main_48

main_123:
    add	w16,	w6,	#1
    cmp	w16,	#2
    blt	main_43

main_126:
    add	w9,	w20,	#1
    cmp	w9,	#2
    blt	main_38

main_129:
    add	w5,	w15,	#1
    cmp	w5,	#2
    blt	main_33

main_132:
    add	w8,	w19,	#1
    cmp	w8,	#2
    blt	main_28

main_135:
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    ldr	w19,	[sp, fp]

    add	w5,	w19,	#1
    cmp	w5,	#2
    blt	main_23

main_138:
    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w22,	w1,	#1
    cmp	w22,	#2
    blt	main_18

main_141:
    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    add	w11,	w6,	#1
    cmp	w11,	#2
    blt	main_13

main_144:
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    ldr	w15,	[sp, fp]

    add	w11,	w15,	#1
    cmp	w11,	#2
    blt	main_8

main_147:
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    add	w9,	w21,	#1
    cmp	w9,	#2
    blt	main_3

main_150:
    add	x28,	sp,	#16
    movz	fp,	#144
    mov	x21,	x28
    movk	fp,	#32,	lsl #16
    mov	x24,	x21
    mov	x18,	x24
    mov	x26,	x18
    mov	x25,	x26
    str	x25,	[sp, fp]

    movz	fp,	#144
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#380
    mov	x19,	x0
    movk	fp,	#32,	lsl #16
    mov	x23,	x19
    str	x23,	[sp, fp]

    movz	fp,	#380
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#840
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#840
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#180
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#180
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#188
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#188
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#720
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#720
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#704
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#704
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#596
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#596
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#604
    ldr	w20,	[x20]

    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#720
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#712
    add	x20,	x27,	#8
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#712
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#960
    ldr	w23,	[x27]

    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#604
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#960
    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#612
    add	w20,	w27,	w20
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#188
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#696
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#696
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#688
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#688
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#964
    add	x22,	x20,	#4
    movk	fp,	#32,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#964
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#884
    ldr	w20,	[x23]

    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#884
    movk	fp,	#32,	lsl #16
    ldr	w22,	[sp, fp]

    movz	fp,	#608
    add	w27,	w20,	w22
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#180
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#672
    add	x20,	x20,	#32
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#672
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#680
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#680
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#656
    add	x20,	x20,	#8
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#656
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#664
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#664
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#888
    ldr	w27,	[x20]

    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#608
    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#888
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#176
    add	w20,	w27,	w20
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#840
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#648
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#648
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#588
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#588
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#948
    add	x23,	x20,	#16
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#948
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#632
    add	x27,	x27,	#8
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#632
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#640
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#640
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#956
    ldr	w22,	[x27]

    movk	fp,	#32,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#176
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#956
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#944
    add	w20,	w20,	w23
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#868
    add	x20,	x27,	#128
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#868
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#876
    add	x27,	x22,	#64
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#876
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#900
    add	x20,	x20,	#32
    movk	fp,	#32,	lsl #16
    str	x20,	[sp, fp]

    movz	fp,	#900
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#852
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#852
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#860
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#860
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#892
    add	x23,	x27,	#4
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#892
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#940
    ldr	w22,	[x27]

    movk	fp,	#32,	lsl #16
    str	w22,	[sp, fp]

    movz	fp,	#940
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#944
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    movz	fp,	#728
    add	w20,	w20,	w23
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#728
    mov	x22,	x20
    movk	fp,	#32,	lsl #16
    add	x20,	x22,	#32
    add	x20,	x20,	#16
    add	x22,	x20,	#8
    ldr	w20,	[x22]

    ldr	w27,	[sp, fp]

    movz	fp,	#848
    add	w27,	w27,	w20
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	x20,	[sp, fp]

    movz	fp,	#848
    add	x20,	x20,	#512
    movk	fp,	#32,	lsl #16
    add	x27,	x20,	#256
    add	x20,	x27,	#128
    add	x23,	x20,	#64
    add	x20,	x23,	#4
    mov	x23,	x19
    ldr	w22,	[x20]

    ldr	w20,	[sp, fp]

    movz	fp,	#836
    add	w27,	w20,	w22
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#836
    add	x27,	x23,	#128
    movk	fp,	#32,	lsl #16
    add	x27,	x27,	#64
    add	x23,	x27,	#32
    ldr	w27,	[x23]

    ldr	w20,	[sp, fp]

    movz	fp,	#196
    add	w27,	w20,	w27
    movk	fp,	#32,	lsl #16
    str	x19,	[sp, fp]

    movz	fp,	#196
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#144
    add	x19,	x19,	#512
    movk	fp,	#32,	lsl #16
    add	x19,	x19,	#256
    add	x19,	x19,	#32
    add	x23,	x19,	#4
    ldr	w19,	[x23]

    add	w19,	w27,	w19
    mov	x27,	x0
    add	x27,	x27,	#1024
    add	x0,	x27,	#512
    add	x22,	x0,	#256
    add	x27,	x22,	#128
    add	x22,	x27,	#64
    add	x0,	x22,	#8
    add	x22,	x0,	#4
    ldr	w27,	[x22]

    ldr	x0,	[sp, fp]

    add	w22,	w19,	w27
    movz	fp,	#204
    add	x0,	x0,	#2048
    movk	fp,	#32,	lsl #16
    add	x0,	x0,	#1024
    add	x0,	x0,	#128
    add	x0,	x0,	#16
    add	x0,	x0,	#8
    ldr	w0,	[x0]

    add	w27,	w22,	w0
    add	x0,	x25,	#16384
    add	x0,	x0,	#8192
    add	x0,	x0,	#1024
    add	x0,	x0,	#512
    add	x25,	x0,	#256
    add	x0,	x25,	#32
    mov	x25,	x26
    ldr	w20,	[x0]

    str	x25,	[sp, fp]

    add	w0,	w27,	w20
    movz	fp,	#204
    add	x20,	x21,	#524288
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#212
    add	x25,	x27,	#256
    movk	fp,	#32,	lsl #16
    mov	x27,	x26
    add	x19,	x25,	#128
    add	x22,	x19,	#64
    add	x22,	x22,	#32
    add	x19,	x22,	#16
    add	x22,	x19,	#8
    add	x19,	x27,	#64
    add	x22,	x22,	#4
    add	x27,	x19,	#32
    ldr	w22,	[x22]

    add	x25,	x27,	#16
    add	w0,	w0,	w22
    add	x25,	x25,	#8
    add	x19,	x25,	#4
    ldr	w26,	[x19]

    add	w25,	w0,	w26
    add	x0,	x18,	#131072
    add	x23,	x0,	#65536
    add	x26,	x23,	#32768
    add	x0,	x26,	#16384
    add	x0,	x0,	#512
    add	x0,	x0,	#256
    add	x0,	x0,	#128
    add	x0,	x0,	#16
    ldr	w26,	[x0]

    mov	x0,	x24
    add	w18,	w25,	w26
    add	x0,	x0,	#8192
    add	x26,	x20,	#262144
    add	x0,	x0,	#4096
    add	x0,	x0,	#2048
    add	x0,	x0,	#1024
    add	x19,	x0,	#512
    add	x23,	x19,	#64
    add	x19,	x26,	#32768
    add	x0,	x23,	#16
    add	x23,	x19,	#8192
    add	x0,	x0,	#4
    add	x20,	x23,	#512
    ldr	w0,	[x0]

    add	x22,	x20,	#256
    add	w0,	w18,	w0
    mov	x18,	x28
    add	x23,	x22,	#128
    add	x27,	x23,	#64
    add	x26,	x27,	#8
    add	x26,	x26,	#4
    ldr	w27,	[x26]

    str	x18,	[sp, fp]

    add	w0,	w0,	w27
    movz	fp,	#212
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    add	x18,	x19,	#262144
    add	x21,	x18,	#16384
    add	x23,	x21,	#2048
    add	x19,	x23,	#1024
    ldr	w25,	[x19]

    add	w0,	w0,	w25
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#976
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


main_3:
    mov	w14,	w7
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    str	w9,	[sp, fp]

    b	main_4

main_8:
    mov	w15,	w7
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    str	w11,	[sp, fp]

    b	main_9

main_13:
    mov	w14,	w7
    movz	fp,	#124
    movk	fp,	#32,	lsl #16
    str	w11,	[sp, fp]

    b	main_14

main_18:
    mov	w15,	w7
    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    str	w22,	[sp, fp]

    b	main_19

main_23:
    mov	w15,	w7
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w5,	[sp, fp]

    b	main_24

main_28:
    mov	w14,	w7
    mov	w19,	w8
    b	main_29

main_33:
    mov	w17,	w7
    mov	w15,	w5
    b	main_34

main_38:
    mov	w21,	w7
    mov	w20,	w9
    b	main_39

main_43:
    mov	w26,	w7
    mov	w6,	w16
    b	main_44

main_48:
    mov	w1,	w7
    b	main_49

main_53:
    mov	w28,	w7
    mov	w23,	w25
    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    b	main_54

main_58:
    mov	w2,	w7
    mov	w9,	w4
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w9,	[sp, fp]

    b	main_59

main_63:
    mov	w1,	w7
    mov	w27,	w5
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    b	main_64

main_68:
    mov	w0,	w7
    mov	w24,	w28
    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    str	w24,	[sp, fp]

    b	main_69

main_73:
    mov	w14,	w7
    mov	w21,	w27
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	w21,	[sp, fp]

    b	main_74

main_78:
    mov	w16,	w7
    mov	w26,	w17
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    str	w26,	[sp, fp]

    b	main_79

main_83:
    mov	w8,	w7
    mov	w0,	w18
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]

    b	main_84

main_88:
    mov	w14,	w7
    mov	w1,	w13
    b	main_89

