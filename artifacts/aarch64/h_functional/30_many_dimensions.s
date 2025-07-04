.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#272
    movk	fp,	#32,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#32,	lsl #16
    bl	memset
    movz	fp,	#128
    movz	w1,	#0
    movz	w0,	#0
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]


main_4:
    movz	fp,	#128
    movz	w21,	#0
    movk	fp,	#32,	lsl #16
    ldr	w15,	[sp, fp]

    movz	fp,	#132
    lsl	w5,	w15,	#20
    movk	fp,	#32,	lsl #16
    mov	x19,	x5
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    str	x19,	[sp, fp]

    movz	fp,	#116
    movk	fp,	#32,	lsl #16
    str	w21,	[sp, fp]


main_9:
    movz	fp,	#116
    movz	w13,	#0
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    movz	fp,	#132
    lsl	w28,	w7,	#19
    movk	fp,	#32,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#120
    add	x11,	x4,	x28
    movk	fp,	#32,	lsl #16
    str	x11,	[sp, fp]

    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    str	w13,	[sp, fp]


main_14:
    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    ldr	w27,	[sp, fp]

    movz	fp,	#120
    lsl	w26,	w27,	#18
    movk	fp,	#32,	lsl #16
    movz	w27,	#0
    ldr	x23,	[sp, fp]

    movz	fp,	#108
    add	x3,	x23,	x26
    movk	fp,	#32,	lsl #16
    str	x3,	[sp, fp]

    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]


main_19:
    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#108
    lsl	w3,	w16,	#17
    movk	fp,	#32,	lsl #16
    ldr	x17,	[sp, fp]

    movz	fp,	#96
    add	x23,	x17,	x3
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#32
    movz	w23,	#0
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]


main_24:
    movz	fp,	#32
    movz	w5,	#0
    movk	fp,	#32,	lsl #16
    mov	w7,	w5
    ldr	w8,	[sp, fp]

    movz	fp,	#96
    lsl	w3,	w8,	#16
    movk	fp,	#32,	lsl #16
    ldr	x9,	[sp, fp]

    movz	fp,	#76
    add	x12,	x9,	x3
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]


main_29:
    lsl	w27,	w7,	#15
    movz	fp,	#76
    movz	w24,	#0
    movk	fp,	#32,	lsl #16
    mov	w5,	w24
    ldr	x28,	[sp, fp]

    movz	fp,	#184
    add	x25,	x28,	x27
    movk	fp,	#32,	lsl #16
    str	x25,	[sp, fp]


main_34:
    lsl	w3,	w5,	#14
    movz	fp,	#184
    movz	w2,	#0
    movk	fp,	#32,	lsl #16
    ldr	x1,	[sp, fp]

    movz	fp,	#192
    add	x6,	x1,	x3
    movk	fp,	#32,	lsl #16
    mov	w3,	w2
    str	x6,	[sp, fp]


main_39:
    lsl	w21,	w3,	#13
    movz	fp,	#192
    mov	w8,	w0
    movz	w25,	#0
    movk	fp,	#32,	lsl #16
    mov	w19,	w25
    ldr	x6,	[sp, fp]

    movz	fp,	#208
    add	x12,	x6,	x21
    movk	fp,	#32,	lsl #16
    str	x12,	[sp, fp]


main_44:
    lsl	w26,	w19,	#12
    movz	fp,	#208
    movz	w1,	#0
    movk	fp,	#32,	lsl #16
    mov	w13,	w1
    ldr	x27,	[sp, fp]

    movz	fp,	#216
    add	x15,	x27,	x26
    movk	fp,	#32,	lsl #16
    str	x15,	[sp, fp]


main_49:
    lsl	w28,	w13,	#11
    movz	fp,	#216
    mov	w6,	w8
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    mov	w11,	w16
    ldr	x12,	[sp, fp]

    movz	fp,	#224
    add	x4,	x12,	x28
    movk	fp,	#32,	lsl #16
    str	x4,	[sp, fp]

    movz	fp,	#28
    movk	fp,	#32,	lsl #16
    str	w11,	[sp, fp]


main_54:
    movz	fp,	#28
    mov	w8,	w6
    movz	w1,	#0
    movk	fp,	#32,	lsl #16
    mov	w0,	w1
    ldr	w9,	[sp, fp]

    movz	fp,	#224
    lsl	w2,	w9,	#10
    movk	fp,	#32,	lsl #16
    ldr	x17,	[sp, fp]

    movz	fp,	#200
    add	x23,	x17,	x2
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    str	w0,	[sp, fp]


main_59:
    movz	fp,	#40
    mov	w11,	w8
    movz	w12,	#0
    movk	fp,	#32,	lsl #16
    mov	w28,	w12
    ldr	w20,	[sp, fp]

    movz	fp,	#200
    lsl	w1,	w20,	#9
    movk	fp,	#32,	lsl #16
    ldr	x4,	[sp, fp]

    movz	fp,	#88
    add	x16,	x4,	x1
    movk	fp,	#32,	lsl #16
    str	x16,	[sp, fp]

    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w28,	[sp, fp]


main_64:
    movz	fp,	#56
    mov	w10,	w11
    movk	fp,	#32,	lsl #16
    movz	w11,	#0
    mov	w17,	w11
    ldr	w0,	[sp, fp]

    movz	fp,	#88
    lsl	w1,	w0,	#8
    movk	fp,	#32,	lsl #16
    ldr	x18,	[sp, fp]

    movz	fp,	#72
    add	x4,	x18,	x1
    movk	fp,	#32,	lsl #16
    str	w17,	[sp, fp]


main_69:
    movz	fp,	#72
    mov	w28,	w10
    movz	w2,	#0
    movk	fp,	#32,	lsl #16
    mov	w11,	w2
    ldr	w0,	[sp, fp]

    movz	fp,	#156
    lsl	w0,	w0,	#7
    movk	fp,	#32,	lsl #16
    add	x0,	x4,	x0
    str	x0,	[sp, fp]

    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	w11,	[sp, fp]


main_74:
    movz	fp,	#60
    mov	w10,	w28
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    movz	fp,	#156
    lsl	w12,	w16,	#6
    movk	fp,	#32,	lsl #16
    ldr	x1,	[sp, fp]

    movz	fp,	#52
    add	x20,	x1,	x12
    movk	fp,	#32,	lsl #16
    movz	w1,	#0
    mov	w15,	w1
    str	w15,	[sp, fp]


main_79:
    movz	fp,	#52
    mov	w1,	w10
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    mov	w12,	w16
    ldr	w22,	[sp, fp]

    movz	fp,	#36
    lsl	w18,	w22,	#5
    movk	fp,	#32,	lsl #16
    add	x6,	x20,	x18
    str	w12,	[sp, fp]


main_84:
    movz	fp,	#36
    mov	w15,	w1
    movz	w16,	#0
    movk	fp,	#32,	lsl #16
    mov	w12,	w16
    ldr	w9,	[sp, fp]

    movz	fp,	#16
    lsl	w21,	w9,	#4
    movk	fp,	#32,	lsl #16
    add	x10,	x6,	x21
    str	w12,	[sp, fp]


main_89:
    movz	fp,	#16
    add	w12,	w15,	#1
    movk	fp,	#32,	lsl #16
    add	w25,	w12,	#1
    ldr	w8,	[sp, fp]

    movz	fp,	#16
    lsl	w28,	w8,	#3
    movk	fp,	#32,	lsl #16
    add	x14,	x10,	x28
    add	x1,	x14,	#4
    str	w15,	[x14]

    str	w12,	[x1]

    ldr	w15,	[sp, fp]

    add	w16,	w15,	#1
    cmp	w16,	#2
    bge	main_99

main_88:
    mov	w15,	w25
    mov	w17,	w16
    movz	fp,	#16
    movk	fp,	#32,	lsl #16
    str	w17,	[sp, fp]

    b	main_89

main_99:
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    ldr	w9,	[sp, fp]

    add	w12,	w9,	#1
    cmp	w12,	#2
    bge	main_102

main_83:
    mov	w1,	w25
    mov	w16,	w12
    movz	fp,	#36
    movk	fp,	#32,	lsl #16
    str	w16,	[sp, fp]

    b	main_84

main_102:
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    ldr	w23,	[sp, fp]

    add	w1,	w23,	#1
    cmp	w1,	#2
    bge	main_105

main_78:
    mov	w10,	w25
    mov	w24,	w1
    movz	fp,	#52
    movk	fp,	#32,	lsl #16
    str	w24,	[sp, fp]

    b	main_79

main_105:
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    ldr	w20,	[sp, fp]

    add	w20,	w20,	#1
    cmp	w20,	#2
    bge	main_108

main_73:
    mov	w28,	w25
    mov	w15,	w20
    movz	fp,	#60
    movk	fp,	#32,	lsl #16
    str	w15,	[sp, fp]

    b	main_74

main_108:
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w1,	w1,	#1
    cmp	w1,	#2
    bge	main_111

main_68:
    mov	w10,	w25
    mov	w23,	w1
    movz	fp,	#72
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    b	main_69

main_111:
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    ldr	w1,	[sp, fp]

    add	w21,	w1,	#1
    cmp	w21,	#2
    bge	main_114

main_63:
    mov	w11,	w25
    mov	w4,	w21
    movz	fp,	#56
    movk	fp,	#32,	lsl #16
    str	w4,	[sp, fp]

    b	main_64

main_114:
    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    ldr	w21,	[sp, fp]

    add	w0,	w21,	#1
    cmp	w0,	#2
    bge	main_117

main_58:
    mov	w8,	w25
    mov	w6,	w0
    movz	fp,	#40
    movk	fp,	#32,	lsl #16
    str	w6,	[sp, fp]

    b	main_59

main_117:
    movz	fp,	#28
    movk	fp,	#32,	lsl #16
    ldr	w0,	[sp, fp]

    add	w2,	w0,	#1
    cmp	w2,	#2
    bge	main_120

main_53:
    mov	w6,	w25
    movz	fp,	#28
    movk	fp,	#32,	lsl #16
    str	w2,	[sp, fp]

    b	main_54

main_120:
    add	w2,	w13,	#1
    cmp	w2,	#2
    bge	main_123

main_48:
    mov	w8,	w25
    mov	w13,	w2
    b	main_49

main_123:
    add	w19,	w19,	#1
    cmp	w19,	#2
    bge	main_126

main_43:
    mov	w8,	w25
    b	main_44

main_126:
    add	w3,	w3,	#1
    cmp	w3,	#2
    bge	main_129

main_38:
    mov	w0,	w25
    b	main_39

main_129:
    add	w4,	w5,	#1
    cmp	w4,	#2
    bge	main_132

main_33:
    mov	w0,	w25
    mov	w5,	w4
    b	main_34

main_132:
    add	w3,	w7,	#1
    cmp	w3,	#2
    bge	main_135

main_28:
    mov	w0,	w25
    mov	w7,	w3
    b	main_29

main_135:
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    ldr	w7,	[sp, fp]

    add	w26,	w7,	#1
    cmp	w26,	#2
    bge	main_138

main_23:
    mov	w0,	w25
    mov	w27,	w26
    movz	fp,	#32
    movk	fp,	#32,	lsl #16
    str	w27,	[sp, fp]

    b	main_24

main_138:
    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    ldr	w16,	[sp, fp]

    add	w28,	w16,	#1
    cmp	w28,	#2
    bge	main_141

main_18:
    mov	w0,	w25
    mov	w1,	w28
    movz	fp,	#84
    movk	fp,	#32,	lsl #16
    str	w1,	[sp, fp]

    b	main_19

main_141:
    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    ldr	w28,	[sp, fp]

    add	w15,	w28,	#1
    cmp	w15,	#2
    bge	main_144

main_13:
    mov	w0,	w25
    movz	fp,	#104
    movk	fp,	#32,	lsl #16
    str	w15,	[sp, fp]

    b	main_14

main_144:
    movz	fp,	#116
    movk	fp,	#32,	lsl #16
    ldr	w6,	[sp, fp]

    add	w23,	w6,	#1
    cmp	w23,	#2
    bge	main_147

main_8:
    mov	w0,	w25
    movz	fp,	#116
    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    b	main_9

main_147:
    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    ldr	w15,	[sp, fp]

    add	w5,	w15,	#1
    cmp	w5,	#2
    bge	main_150

main_3:
    mov	w0,	w25
    movz	fp,	#128
    movk	fp,	#32,	lsl #16
    str	w5,	[sp, fp]

    b	main_4

main_150:
    add	x26,	sp,	#16
    movz	fp,	#148
    mov	x20,	x26
    movk	fp,	#32,	lsl #16
    mov	x27,	x20
    mov	x0,	x27
    str	x0,	[sp, fp]

    add	x0,	x0,	#16384
    movz	fp,	#148
    movk	fp,	#32,	lsl #16
    add	x0,	x0,	#8192
    ldr	x22,	[sp, fp]

    movz	fp,	#64
    mov	x18,	x22
    movk	fp,	#32,	lsl #16
    mov	x19,	x18
    add	x0,	x0,	#1024
    str	x19,	[sp, fp]

    add	x19,	x19,	#128
    movz	fp,	#64
    movk	fp,	#32,	lsl #16
    ldr	x24,	[sp, fp]

    movz	fp,	#44
    movk	fp,	#32,	lsl #16
    str	x24,	[sp, fp]

    movz	fp,	#44
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#20
    movk	fp,	#32,	lsl #16
    str	x23,	[sp, fp]

    movz	fp,	#20
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#232
    mov	x24,	x28
    movk	fp,	#32,	lsl #16
    mov	x28,	x24
    str	x28,	[sp, fp]

    movz	fp,	#232
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#248
    movk	fp,	#32,	lsl #16
    str	x28,	[sp, fp]

    movz	fp,	#248
    movk	fp,	#32,	lsl #16
    ldr	x21,	[sp, fp]

    movz	fp,	#176
    movk	fp,	#32,	lsl #16
    str	x21,	[sp, fp]

    movz	fp,	#176
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#240
    movk	fp,	#32,	lsl #16
    str	x22,	[sp, fp]

    movz	fp,	#240
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#144
    ldr	w23,	[x23]

    movk	fp,	#32,	lsl #16
    str	w23,	[sp, fp]

    movz	fp,	#176
    movk	fp,	#32,	lsl #16
    ldr	x23,	[sp, fp]

    movz	fp,	#144
    add	x23,	x23,	#8
    movk	fp,	#32,	lsl #16
    ldr	w21,	[x23]

    ldr	w22,	[sp, fp]

    movz	fp,	#256
    add	w25,	w21,	w22
    movk	fp,	#32,	lsl #16
    str	w25,	[sp, fp]

    movz	fp,	#248
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#256
    mov	x23,	x22
    movk	fp,	#32,	lsl #16
    add	x23,	x23,	#4
    ldr	w23,	[x23]

    ldr	w22,	[sp, fp]

    movz	fp,	#232
    add	w22,	w22,	w23
    movk	fp,	#32,	lsl #16
    ldr	x28,	[sp, fp]

    movz	fp,	#172
    add	x28,	x28,	#32
    movk	fp,	#32,	lsl #16
    add	x28,	x28,	#8
    ldr	w21,	[x28]

    mov	x28,	x24
    add	w23,	w22,	w21
    add	x28,	x28,	#16
    str	w23,	[sp, fp]

    add	x28,	x28,	#8
    movz	fp,	#172
    movk	fp,	#32,	lsl #16
    ldr	w28,	[x28]

    ldr	w24,	[sp, fp]

    movz	fp,	#20
    add	w21,	w24,	w28
    movk	fp,	#32,	lsl #16
    ldr	x22,	[sp, fp]

    movz	fp,	#44
    add	x22,	x22,	#128
    movk	fp,	#32,	lsl #16
    add	x23,	x22,	#64
    add	x23,	x23,	#32
    mov	x28,	x23
    add	x22,	x28,	#4
    ldr	w23,	[x22]

    ldr	x24,	[sp, fp]

    add	w28,	w21,	w23
    movz	fp,	#64
    mov	x23,	x24
    movk	fp,	#32,	lsl #16
    mov	x24,	x18
    add	x23,	x23,	#32
    add	x24,	x24,	#512
    add	x21,	x23,	#16
    add	x22,	x21,	#8
    ldr	w21,	[x22]

    ldr	x25,	[sp, fp]

    add	w21,	w28,	w21
    movz	fp,	#148
    add	x25,	x25,	#512
    add	x28,	x24,	#256
    movk	fp,	#32,	lsl #16
    add	x24,	x18,	#1024
    add	x23,	x25,	#256
    add	x28,	x28,	#32
    add	x22,	x23,	#128
    add	x23,	x22,	#64
    add	x22,	x23,	#4
    ldr	w25,	[x22]

    add	x22,	x19,	#64
    add	w25,	w21,	w25
    add	x21,	x22,	#32
    ldr	w22,	[x21]

    add	w19,	w25,	w22
    add	x22,	x28,	#4
    add	x28,	x24,	#512
    ldr	w25,	[x22]

    add	x21,	x28,	#256
    add	x22,	x0,	#512
    add	w25,	w19,	w25
    add	x24,	x21,	#128
    add	x22,	x22,	#256
    add	x21,	x24,	#64
    add	x0,	x22,	#32
    add	x28,	x21,	#8
    add	x21,	x28,	#4
    ldr	w24,	[x21]

    ldr	x23,	[sp, fp]

    add	w21,	w25,	w24
    add	x28,	x23,	#2048
    add	x18,	x28,	#1024
    add	x18,	x18,	#128
    add	x28,	x18,	#16
    add	x18,	x28,	#8
    mov	x28,	x27
    add	x28,	x28,	#256
    ldr	w25,	[x18]

    ldr	w23,	[x0]

    add	w21,	w21,	w25
    add	x18,	x28,	#128
    add	w0,	w21,	w23
    add	x21,	x18,	#64
    add	x22,	x21,	#32
    add	x21,	x22,	#16
    mov	x22,	x20
    add	x23,	x21,	#8
    mov	x21,	x27
    add	x25,	x23,	#4
    ldr	w25,	[x25]

    add	w19,	w0,	w25
    add	x25,	x21,	#64
    add	x28,	x25,	#32
    add	x18,	x28,	#16
    add	x0,	x18,	#8
    add	x18,	x20,	#131072
    add	x20,	x26,	#262144
    add	x0,	x0,	#4
    ldr	w21,	[x0]

    add	w25,	w19,	w21
    add	x21,	x22,	#8192
    add	x19,	x18,	#65536
    add	x22,	x21,	#4096
    add	x23,	x19,	#32768
    add	x0,	x23,	#16384
    add	x23,	x22,	#2048
    add	x0,	x0,	#512
    add	x24,	x23,	#1024
    add	x18,	x0,	#256
    add	x27,	x24,	#512
    add	x28,	x18,	#128
    add	x18,	x27,	#64
    add	x0,	x28,	#16
    ldr	w0,	[x0]

    add	w0,	w25,	w0
    add	x25,	x18,	#16
    add	x22,	x25,	#4
    add	x25,	x26,	#524288
    ldr	w23,	[x22]

    add	x27,	x25,	#262144
    add	w19,	w0,	w23
    add	x18,	x27,	#32768
    add	x22,	x18,	#8192
    add	x25,	x22,	#512
    add	x27,	x25,	#256
    add	x27,	x27,	#128
    add	x0,	x27,	#64
    add	x21,	x0,	#8
    add	x22,	x21,	#4
    ldr	w23,	[x22]

    add	w27,	w19,	w23
    add	x23,	x20,	#16384
    add	x20,	x23,	#2048
    add	x21,	x20,	#1024
    ldr	w0,	[x21]

    add	w0,	w27,	w0
    bl	putint
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#272
    movk	fp,	#32,	lsl #16
    add	sp, sp, fp
    ret


