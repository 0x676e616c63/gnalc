.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl graphColoring
.align 2
.p2align 4,,11
.type graphColoring, %function
graphColoring:
graphColoring_4:
    sub	sp, sp, #128
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	x27,	x3
    mov	w26,	w1
    mov	x24,	x0
    cmp	w2,	#4
    bne	graphColoring_46

graphColoring_6:
    movz	w3,	#0

graphColoring_7:
    cmp	w3,	#4
    blt	graphColoring_10

graphColoring_32:
    movz	w0,	#1
    b	graphColoring_34

graphColoring_10:
    add	w20,	w3,	#1
    lsl	w1,	w3,	#4
    lsl	w5,	w3,	#2
    add	x17,	x24,	x1
    add	x2,	x27,	x5
    ldr	w4,	[x2]


graphColoring_15:
    cmp	w20,	#4
    blt	graphColoring_18

graphColoring_30:
    add	w3,	w3,	#1
    b	graphColoring_7

graphColoring_18:
    lsl	w10,	w20,	#2
    add	x9,	x17,	x10
    ldr	w11,	[x9]

    cmp	w11,	#0
    beq	graphColoring_28

graphColoring_22:
    lsl	w14,	w20,	#2
    add	x13,	x27,	x14
    ldr	w15,	[x13]

    cmp	w15,	w4
    bne	graphColoring_28

graphColoring_33:
    movz	w0,	#0

graphColoring_34:
    cmp	w0,	#0
    bne	graphColoring_37

graphColoring_115:
    movz	w0,	#0
    b	graphColoring_116

graphColoring_37:
    mov	x21,	x27
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	x22,	x27,	#4
    ldr	w0,	[x22]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	x0,	x27,	#8
    ldr	w0,	[x0]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	x24,	x27,	#12
    ldr	w0,	[x24]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#1
    b	graphColoring_116

graphColoring_28:
    add	w20,	w20,	#1
    b	graphColoring_15

graphColoring_46:
    lsl	w1,	w2,	#2
    add	w11,	w2,	#1
    mov	x23,	x27
    add	x21,	x27,	#4
    add	x19,	x27,	#8
    movz	w6,	#1
    add	x14,	x27,	x1
    mov	w22,	w6
    str	x14,	[sp, #120]

    str	w11,	[sp, #96]

    ldr	w12,	[sp, #96]

    lsl	w4,	w12,	#2
    add	x28,	x27,	x4
    add	x4,	x27,	#12
    str	x28,	[sp, #104]

    ldr	w13,	[sp, #96]

    str	x4,	[sp, #112]

    add	w28,	w13,	#1

graphColoring_55:
    cmp	w22,	w26
    ble	graphColoring_58

graphColoring_118:
    movz	w0,	#0
    b	graphColoring_116

graphColoring_58:
    ldr	x12,	[sp, #120]

    str	w22,	[x12]

    ldr	w5,	[sp, #96]

    cmp	w5,	#4
    beq	graphColoring_60

graphColoring_96:
    movz	w20,	#1
    str	w20,	[sp, #100]


graphColoring_97:
    ldr	w8,	[sp, #100]

    cmp	w8,	w26
    ble	graphColoring_100

graphColoring_109:
    movz	w0,	#0
    b	graphColoring_106

graphColoring_100:
    ldr	w0,	[sp, #100]

    mov	w1,	w26
    mov	w2,	w28
    ldr	x3,	[sp, #104]

    str	w0,	[x3]

    mov	x3,	x27
    mov	x0,	x24
    bl	graphColoring
    cmp	w0,	#0
    beq	graphColoring_103

graphColoring_110:
    movz	w0,	#1
    b	graphColoring_106

graphColoring_103:
    movz	w1,	#0
    ldr	x2,	[sp, #104]

    str	w1,	[x2]

    ldr	w10,	[sp, #100]

    add	w2,	w10,	#1
    str	w2,	[sp, #100]

    b	graphColoring_97

graphColoring_60:
    movz	w15,	#0

graphColoring_61:
    cmp	w15,	#4
    blt	graphColoring_64

graphColoring_86:
    movz	w18,	#1
    b	graphColoring_88

graphColoring_64:
    add	w18,	w15,	#1
    lsl	w8,	w15,	#4
    lsl	w10,	w15,	#2
    add	x4,	x24,	x8
    add	x9,	x27,	x10
    ldr	w11,	[x9]


graphColoring_69:
    cmp	w18,	#4
    blt	graphColoring_72

graphColoring_84:
    add	w15,	w15,	#1
    b	graphColoring_61

graphColoring_72:
    lsl	w17,	w18,	#2
    add	x14,	x4,	x17
    ldr	w20,	[x14]

    cmp	w20,	#0
    beq	graphColoring_82

graphColoring_76:
    lsl	w2,	w18,	#2
    add	x1,	x27,	x2
    ldr	w3,	[x1]

    cmp	w3,	w11
    bne	graphColoring_82

graphColoring_87:
    movz	w18,	#0

graphColoring_88:
    cmp	w18,	#0
    bne	graphColoring_91

graphColoring_105:
    movz	w0,	#0
    b	graphColoring_106

graphColoring_91:
    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w0,	[x19]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	x25,	[sp, #112]

    ldr	w0,	[x25]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#1

graphColoring_106:
    cmp	w0,	#0
    beq	graphColoring_113

graphColoring_119:
    movz	w0,	#1

graphColoring_116:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #128
    ret


graphColoring_113:
    movz	w11,	#0
    ldr	x5,	[sp, #120]

    add	w4,	w22,	#1
    str	w11,	[x5]

    mov	w22,	w4
    b	graphColoring_55

graphColoring_82:
    add	w18,	w18,	#1
    b	graphColoring_69

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w19,	#1
    movz	w24,	#1
    movz	w25,	#0
    movz	w1,	#0
    movz	w26,	#1
    movz	w21,	#1
    movz	w27,	#0
    movz	w20,	#1
    add	x0,	sp,	#32
    add	x28,	sp,	#28
    movz	w22,	#0
    add	x18,	x0,	#12
    add	x3,	x0,	#8
    add	x2,	x0,	#4
    str	w22,	[x0]

    str	w21,	[x2]

    add	x21,	sp,	#48
    str	w20,	[x3]

    add	x3,	sp,	#80
    movz	w20,	#1
    str	w19,	[x18]

    add	x23,	x21,	#4
    movz	w18,	#1
    add	x22,	x3,	#4
    movz	w19,	#0
    str	w26,	[x21]

    add	x26,	sp,	#64
    str	w25,	[x23]

    add	x23,	x3,	#8
    add	x25,	x21,	#8
    add	x2,	x26,	#8
    str	w24,	[x25]

    movz	w25,	#1
    add	x24,	x21,	#12
    movz	w21,	#1
    str	w1,	[x24]

    movz	w24,	#0
    add	x1,	x26,	#4
    str	w21,	[x26]

    movz	w21,	#0
    str	w20,	[x1]

    add	x20,	x3,	#12
    add	x1,	x26,	#12
    str	w19,	[x2]

    movz	w26,	#0
    movz	w2,	#0
    str	w25,	[x1]

    add	x25,	sp,	#20
    movz	w1,	#1
    str	w18,	[x3]

    add	x3,	sp,	#16
    str	w2,	[x22]

    movz	w2,	#0
    str	w1,	[x23]

    movz	w1,	#3
    str	w21,	[x20]

    str	w27,	[x3]

    add	x27,	sp,	#24
    str	w26,	[x25]

    movz	w25,	#0
    str	w25,	[x27]

    str	w24,	[x28]

    bl	graphColoring
    cmp	w0,	#0
    bne	main_31

main_29:
    movz	w0,	#78
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#116
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#101
    bl	putch
    movz	w0,	#120
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#115
    bl	putch
    movz	w0,	#116
    bl	putch

main_31:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


