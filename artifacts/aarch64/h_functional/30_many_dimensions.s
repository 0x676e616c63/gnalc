.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#672
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#36
    movz	w0,	#0
    movz	w18,	#0
    movk	fp,	#32,	lsl #16
    mov	w19,	w18
    str	w0,	[sp, fp]


main_4:
    movz	fp,	#36
    mov	w18,	w19
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    movz	fp,	#40
    lsl	w8,	w23,	#20
    movk	fp,	#32,	lsl #16
    mov	x27,	x8
    add	x27,	sp,	x27
    add	x27,	x27,	#16
    str	x27,	[sp, fp]

    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]


main_9:
    movz	fp,	#32
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    ldr	w14,	[sp, fp]

    movz	fp,	#40
    lsl	w11,	w14,	#19
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#136
    add	x12,	x5,	x11
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]

    movz	fp,	#132
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]


main_14:
    movz	fp,	#132
    movz	w19,	#0
    movk	fp,	#32,	lsl #16
    ldr	w8,	[sp, fp]

    movz	fp,	#136
    lsl	w27,	w8,	#18
    movk	fp,	#32,	lsl #16
    ldr	x1,	[sp, fp]

    movz	fp,	#124
    add	x4,	x1,	x27
    movk	fp,	#32,	lsl #16
    str	x4,	[sp, fp]

    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    str	w19,	[sp, fp]


main_19:
    movz	fp,	#120
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    mov	w20,	w3
    ldr	w0,	[sp, fp]

    movz	fp,	#124
    lsl	w7,	w0,	#17
    movk	fp,	#32,	lsl #16
    ldr	x19,	[sp, fp]

    movz	fp,	#112
    add	x28,	x19,	x7
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w20,	[sp, fp]


main_24:
    movz	fp,	#100
    mov	w21,	w18
    movz	w14,	#0
    movk	fp,	#32,	lsl #16
    mov	w15,	w14
    ldr	w17,	[sp, fp]

    movz	fp,	#112
    lsl	w12,	w17,	#16
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#92
    add	x13,	x8,	x12
    movk	fp,	#32,	lsl #16
    str	x13,	[sp, fp]


main_29:
    lsl	w25,	w15,	#15
    movz	fp,	#92
    mov	w24,	w21
    movz	w1,	#0
    movk	fp,	#32,	lsl #16
    mov	w19,	w1
    ldr	x0,	[sp, fp]

    movz	fp,	#332
    add	x28,	x0,	x25
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]


main_34:
    lsl	w12,	w19,	#14
    movz	fp,	#332
    mov	w27,	w24
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    mov	w10,	w3
    ldr	x1,	[sp, fp]

    movz	fp,	#340
    add	x4,	x1,	x12
    movk	fp,	#32,	lsl #16
    str	x4,	[sp, fp]


main_39:
    lsl	w25,	w10,	#13
    movz	fp,	#340
    mov	w8,	w27
    movz	w3,	#0
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#356
    add	x12,	x5,	x25
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]


main_44:
    lsl	w2,	w3,	#12
    movz	fp,	#356
    mov	w11,	w8
    movz	w9,	#0
    movk	fp,	#32,	lsl #16
    mov	w21,	w9
    ldr	x1,	[sp, fp]

    movz	fp,	#348
    add	x14,	x1,	x2
    movk	fp,	#32,	lsl #16
    str	x14,	[sp, fp]


main_49:
    lsl	w0,	w21,	#11
    movz	fp,	#348
    mov	w6,	w11
    movz	w18,	#0
    movk	fp,	#32,	lsl #16
    ldr	x17,	[sp, fp]

    movz	fp,	#628
    add	x25,	x17,	x0
    movk	fp,	#32,	lsl #16
    mov	w17,	w18
    str	x25,	[sp, fp]

    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    str	w17,	[sp, fp]


main_54:
    movz	fp,	#48
    mov	w8,	w6
    movz	w7,	#0
    movk	fp,	#32,	lsl #16
    mov	w0,	w7
    ldr	w16,	[sp, fp]

    movz	fp,	#628
    lsl	w9,	w16,	#10
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#104
    add	x5,	x28,	x9
    movk	fp,	#32,	lsl #16
    str	x5,	[sp, fp]

    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]


main_59:
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#104
    lsl	w12,	w7,	#9
    movk	fp,	#32,	lsl #16
    ldr	x0,	[sp, fp]

    movz	fp,	#592
    add	x1,	x0,	x12
    movk	fp,	#32,	lsl #16
    movz	w0,	#0
    mov	w16,	w0
    str	x1,	[sp, fp]

    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w16,	[sp, fp]


main_64:
    movz	fp,	#72
    mov	w27,	w8
    movz	w23,	#0
    movk	fp,	#32,	lsl #16
    mov	w12,	w23
    ldr	w0,	[sp, fp]

    movz	fp,	#592
    lsl	w0,	w0,	#8
    movk	fp,	#32,	lsl #16
    ldr	x5,	[sp, fp]

    movz	fp,	#156
    add	x0,	x5,	x0
    movk	fp,	#32,	lsl #16
    str	x0,	[sp, fp]

    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    str	w12,	[sp, fp]


main_69:
    movz	fp,	#88
    mov	w18,	w27
    movz	w12,	#0
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#156
    lsl	w7,	w7,	#7
    movk	fp,	#32,	lsl #16
    ldr	x1,	[sp, fp]

    movz	fp,	#164
    add	x7,	x1,	x7
    movk	fp,	#32,	lsl #16
    mov	w1,	w12
    str	x7,	[sp, fp]

    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]


main_74:
    movz	fp,	#76
    mov	w20,	w18
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    mov	w23,	w0
    ldr	w7,	[sp, fp]

    movz	fp,	#164
    lsl	w12,	w7,	#6
    movk	fp,	#32,	lsl #16
    ldr	x8,	[sp, fp]

    movz	fp,	#68
    add	x26,	x8,	x12
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]


main_79:
    movz	fp,	#68
    movz	w23,	#0
    movk	fp,	#32,	lsl #16
    mov	w4,	w23
    ldr	w6,	[sp, fp]

    movz	fp,	#180
    lsl	w0,	w6,	#5
    movk	fp,	#32,	lsl #16
    add	x18,	x26,	x0
    mov	w0,	w20
    str	x18,	[sp, fp]

    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]


main_84:
    movz	fp,	#52
    mov	w11,	w0
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#180
    lsl	w23,	w16,	#4
    movk	fp,	#32,	lsl #16
    movz	w16,	#0
    mov	w0,	w16
    ldr	x7,	[sp, fp]

    add	x25,	x7,	x23

main_89:
    lsl	w23,	w0,	#3
    add	w24,	w0,	#1
    add	x17,	x25,	x23
    add	x6,	x17,	#4
    str	w11,	[x17]

    add	w11,	w11,	#1
    add	w27,	w11,	#1
    str	w11,	[x6]

    cmp	w24,	#2
    blt	main_88

main_99:
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    ldr	w14,	[sp, fp]

    add	w11,	w14,	#1
    cmp	w11,	#2
    blt	main_83

main_102:
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w23,	w7,	#1
    cmp	w23,	#2
    blt	main_78

main_105:
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w9,	w0,	#1
    cmp	w9,	#2
    blt	main_73

main_108:
    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    ldr	w13,	[sp, fp]

    add	w16,	w13,	#1
    cmp	w16,	#2
    blt	main_68

main_111:
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w13,	w1,	#1
    cmp	w13,	#2
    blt	main_63

main_114:
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w0,	w0,	#1
    cmp	w0,	#2
    blt	main_58

main_117:
    movz	fp,	#48
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w18,	w0,	#1
    cmp	w18,	#2
    blt	main_53

main_120:
    add	w1,	w21,	#1
    cmp	w1,	#2
    blt	main_48

main_123:
    add	w12,	w3,	#1
    cmp	w12,	#2
    blt	main_43

main_126:
    add	w5,	w10,	#1
    cmp	w5,	#2
    blt	main_38

main_129:
    add	w2,	w19,	#1
    cmp	w2,	#2
    blt	main_33

main_132:
    add	w5,	w15,	#1
    cmp	w5,	#2
    blt	main_28

main_135:
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    add	w7,	w21,	#1
    cmp	w7,	#2
    blt	main_23

main_138:
    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    ldr	w2,	[sp, fp]

    add	w20,	w2,	#1
    cmp	w20,	#2
    blt	main_18

main_141:
    movz	fp,	#132
    movk	fp,	#32,	lsl #16
    ldr	w11,	[sp, fp]

    add	w0,	w11,	#1
    cmp	w0,	#2
    blt	main_13

main_144:
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    ldr	w18,	[sp, fp]

    add	w5,	w18,	#1
    cmp	w5,	#2
    blt	main_8

main_147:
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    add	w2,	w23,	#1
    cmp	w2,	#2
    blt	main_3

main_150:
    add	x24,	sp,	#16
    movz	fp,	#148
    mov	x18,	x24
    movk	fp,	#32,	lsl #16
    mov	x22,	x18
    mov	x0,	x22
    mov	x20,	x0
    mov	x26,	x20
    str	x26,	[sp, fp]

    movz	fp,	#148
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#80
    mov	x19,	x25
    movk	fp,	#32,	lsl #16
    mov	x21,	x19
    str	x21,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#600
    mov	x27,	x23
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#600
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#200
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#200
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#192
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#192
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#644
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]

    movz	fp,	#644
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#144
    ldr	w25,	[x26]

    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#200
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#652
    add	x26,	x25,	#8
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#652
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#620
    movk	fp,	#32,	lsl #16
    str	x27,	[sp, fp]

    movz	fp,	#620
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#144
    ldr	w26,	[x28]

    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#328
    add	w25,	w26,	w27
    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#24
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#612
    movk	fp,	#32,	lsl #16
    ldr	x26,	[sp, fp]

    movz	fp,	#636
    movk	fp,	#32,	lsl #16
    str	x26,	[sp, fp]

    movz	fp,	#636
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#328
    add	x26,	x27,	#4
    movk	fp,	#32,	lsl #16
    ldr	w26,	[x26]

    ldr	w27,	[sp, fp]

    movz	fp,	#324
    add	w27,	w27,	w26
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#600
    movk	fp,	#32,	lsl #16
    ldr	x27,	[sp, fp]

    movz	fp,	#324
    add	x26,	x27,	#32
    movk	fp,	#32,	lsl #16
    add	x26,	x26,	#8
    ldr	w26,	[x26]

    ldr	w25,	[sp, fp]

    movz	fp,	#188
    add	w27,	w25,	w26
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    movz	fp,	#660
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#660
    movk	fp,	#32,	lsl #16
    ldr	x25,	[sp, fp]

    movz	fp,	#188
    add	x23,	x25,	#16
    movk	fp,	#32,	lsl #16
    add	x23,	x23,	#8
    ldr	w23,	[x23]

    ldr	w27,	[sp, fp]

    movz	fp,	#608
    add	w26,	w27,	w23
    movk	fp,	#32,	lsl #16
    str	w26,	[sp, fp]

    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#608
    add	x23,	x23,	#128
    movk	fp,	#32,	lsl #16
    add	x23,	x23,	#64
    add	x23,	x23,	#32
    add	x23,	x23,	#4
    ldr	w23,	[x23]

    ldr	w28,	[sp, fp]

    movz	fp,	#508
    add	w28,	w28,	w23
    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#508
    mov	x23,	x28
    movk	fp,	#32,	lsl #16
    add	x27,	x23,	#32
    add	x27,	x27,	#16
    add	x27,	x27,	#8
    ldr	w27,	[x27]

    ldr	w23,	[sp, fp]

    movz	fp,	#320
    add	w28,	w23,	w27
    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]

    movz	fp,	#80
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#320
    add	x25,	x28,	#512
    movk	fp,	#32,	lsl #16
    add	x23,	x25,	#256
    add	x23,	x23,	#128
    add	x23,	x23,	#64
    add	x23,	x23,	#4
    ldr	w26,	[x23]

    ldr	w27,	[sp, fp]

    movz	fp,	#148
    add	w23,	w27,	w26
    movk	fp,	#32,	lsl #16
    add	x27,	x21,	#128
    add	x25,	x27,	#64
    mov	x27,	x19
    add	x21,	x25,	#32
    ldr	w25,	[x21]

    add	w21,	w23,	w25
    add	x23,	x19,	#1024
    mov	x25,	x27
    add	x26,	x25,	#512
    add	x25,	x26,	#256
    add	x26,	x20,	#16384
    add	x25,	x25,	#32
    add	x20,	x26,	#8192
    add	x27,	x25,	#4
    add	x26,	x20,	#1024
    add	x25,	x23,	#512
    ldr	w27,	[x27]

    add	x26,	x26,	#512
    add	x23,	x25,	#256
    add	w27,	w21,	w27
    add	x25,	x23,	#128
    add	x21,	x26,	#256
    add	x25,	x25,	#64
    add	x20,	x21,	#32
    mov	x21,	x0
    add	x25,	x25,	#8
    add	x23,	x25,	#4
    ldr	w25,	[x23]

    add	w23,	w27,	w25
    ldr	x27,	[sp, fp]

    add	x19,	x27,	#2048
    add	x27,	x21,	#256
    add	x21,	x24,	#524288
    add	x25,	x19,	#1024
    add	x25,	x25,	#128
    add	x19,	x25,	#16
    add	x28,	x19,	#8
    ldr	w25,	[x28]

    ldr	w19,	[x20]

    add	w25,	w23,	w25
    add	x20,	x27,	#128
    add	w26,	w25,	w19
    add	x23,	x20,	#64
    add	x25,	x23,	#32
    add	x28,	x25,	#16
    add	x23,	x28,	#8
    mov	x28,	x0
    add	x27,	x23,	#4
    ldr	w23,	[x27]

    add	w25,	w26,	w23
    add	x23,	x28,	#64
    add	x0,	x23,	#32
    add	x20,	x0,	#16
    add	x27,	x20,	#8
    add	x0,	x27,	#4
    ldr	w0,	[x0]

    add	w28,	w25,	w0
    add	x0,	x22,	#131072
    add	x22,	x0,	#65536
    add	x25,	x22,	#32768
    mov	x22,	x18
    add	x27,	x22,	#8192
    add	x0,	x25,	#16384
    add	x27,	x27,	#4096
    add	x0,	x0,	#512
    add	x19,	x27,	#2048
    add	x0,	x0,	#256
    add	x20,	x19,	#1024
    add	x26,	x0,	#128
    add	x18,	x20,	#512
    add	x0,	x26,	#16
    add	x20,	x18,	#64
    ldr	w0,	[x0]

    add	x18,	x21,	#262144
    add	w0,	w28,	w0
    add	x28,	x20,	#16
    add	x20,	x18,	#32768
    add	x27,	x28,	#4
    ldr	w19,	[x27]

    add	w27,	w0,	w19
    add	x0,	x20,	#8192
    add	x21,	x0,	#512
    add	x23,	x21,	#256
    add	x23,	x23,	#128
    add	x0,	x23,	#64
    add	x26,	x0,	#8
    add	x0,	x26,	#4
    mov	x26,	x24
    ldr	w18,	[x0]

    add	w0,	w27,	w18
    add	x18,	x26,	#262144
    add	x21,	x18,	#16384
    add	x23,	x21,	#2048
    add	x19,	x23,	#1024
    ldr	w18,	[x19]

    add	w0,	w0,	w18
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#672
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


main_3:
    mov	w19,	w27
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]

    b	main_4

main_8:
    mov	w18,	w27
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    str	w5,	[sp, fp]

    b	main_9

main_13:
    mov	w18,	w27
    mov	w1,	w0
    movz	fp,	#132
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_14

main_18:
    mov	w18,	w27
    mov	w22,	w20
    movz	fp,	#120
    movk	fp,	#32,	lsl #16
    str	w22,	[sp, fp]

    b	main_19

main_23:
    mov	w18,	w27
    movz	fp,	#100
    movk	fp,	#32,	lsl #16
    str	w7,	[sp, fp]

    b	main_24

main_28:
    mov	w21,	w27
    mov	w15,	w5
    b	main_29

main_33:
    mov	w24,	w27
    mov	w19,	w2
    b	main_34

main_38:
    mov	w10,	w5
    b	main_39

main_43:
    mov	w8,	w27
    mov	w3,	w12
    b	main_44

main_48:
    mov	w11,	w27
    mov	w21,	w1
    b	main_49

main_53:
    mov	w6,	w27
    movz	fp,	#48
    mov	w27,	w18
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    b	main_54

main_58:
    mov	w8,	w27
    mov	w6,	w0
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]

    b	main_59

main_63:
    mov	w8,	w27
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]

    b	main_64

main_68:
    mov	w18,	w16
    movz	fp,	#88
    movk	fp,	#32,	lsl #16
    str	w18,	[sp, fp]

    b	main_69

main_73:
    mov	w18,	w27
    mov	w17,	w9
    movz	fp,	#76
    movk	fp,	#32,	lsl #16
    str	w17,	[sp, fp]

    b	main_74

main_78:
    mov	w20,	w27
    mov	w6,	w23
    movz	fp,	#68
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]

    b	main_79

main_83:
    mov	w0,	w27
    mov	w2,	w11
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]

    b	main_84

main_88:
    mov	w11,	w27
    mov	w0,	w24
    b	main_89

