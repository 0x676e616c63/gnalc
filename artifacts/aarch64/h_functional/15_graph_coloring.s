.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl graphColoring
graphColoring:
graphColoring_4:
    sub	sp, sp, #160
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	fp,	#124
    mov	w22,	w1
    mov	x23,	x0
    str	x3,	[sp, fp]

    cmp	w2,	#4
    beq	graphColoring_6

graphColoring_46:
    lsl	w28,	w2,	#2
    movz	fp,	#124
    movz	w16,	#1
    ldr	x24,	[sp, fp]

    movz	fp,	#124
    add	x15,	x24,	x28
    add	w28,	w2,	#1
    str	x15,	[sp, #104]

    lsl	w8,	w28,	#2
    ldr	x20,	[sp, fp]

    movz	fp,	#124
    str	x20,	[sp, #96]

    ldr	x25,	[sp, fp]

    movz	fp,	#124
    add	x24,	x25,	#4
    str	x24,	[sp, #112]

    ldr	x26,	[sp, fp]

    movz	fp,	#124
    add	x19,	x26,	#8
    add	w26,	w28,	#1
    ldr	x9,	[sp, fp]

    movz	fp,	#140
    add	x24,	x9,	#12
    str	x24,	[sp, fp]

    mov	w24,	w16
    movz	fp,	#124
    ldr	x10,	[sp, fp]

    movz	fp,	#132
    add	x3,	x10,	x8
    str	x3,	[sp, fp]


graphColoring_55:
    cmp	w24,	w22
    bgt	graphColoring_118

graphColoring_58:
    ldr	x9,	[sp, #104]

    str	w24,	[x9]

    cmp	w28,	#4
    beq	graphColoring_60

graphColoring_96:
    movz	w8,	#1
    str	w8,	[sp, #120]


graphColoring_97:
    ldr	w6,	[sp, #120]

    cmp	w6,	w22
    bgt	graphColoring_109

graphColoring_100:
    ldr	w27,	[sp, #120]

    movz	fp,	#132
    mov	x0,	x23
    mov	w1,	w22
    mov	w2,	w26
    ldr	x25,	[sp, fp]

    movz	fp,	#124
    str	w27,	[x25]

    ldr	x3,	[sp, fp]

    bl	graphColoring
    cmp	w0,	#0
    bne	graphColoring_110

graphColoring_103:
    movz	w11,	#0
    movz	fp,	#132
    ldr	x6,	[sp, fp]

    str	w11,	[x6]

    ldr	w8,	[sp, #120]

    add	w12,	w8,	#1
    str	w12,	[sp, #120]

    b	graphColoring_97

graphColoring_110:
    movz	w16,	#1
    b	graphColoring_106

graphColoring_109:
    movz	w16,	#0
    b	graphColoring_106

graphColoring_60:
    movz	w13,	#0

graphColoring_61:
    cmp	w13,	#4
    bge	graphColoring_86

graphColoring_64:
    add	w15,	w13,	#1
    lsl	w20,	w13,	#4
    lsl	w0,	w13,	#2
    movz	fp,	#124
    add	x18,	x23,	x20
    ldr	x10,	[sp, fp]

    add	x21,	x10,	x0
    ldr	w0,	[x21]


graphColoring_69:
    cmp	w15,	#4
    bge	graphColoring_84

graphColoring_72:
    lsl	w4,	w15,	#2
    add	x3,	x18,	x4
    ldr	w5,	[x3]

    cmp	w5,	#0
    beq	graphColoring_82

graphColoring_76:
    lsl	w8,	w15,	#2
    movz	fp,	#124
    ldr	x11,	[sp, fp]

    add	x7,	x11,	x8
    ldr	w9,	[x7]

    cmp	w9,	w0
    bne	graphColoring_82

graphColoring_87:
    movz	w15,	#0
    b	graphColoring_88

graphColoring_82:
    add	w15,	w15,	#1
    b	graphColoring_69

graphColoring_84:
    add	w13,	w13,	#1
    b	graphColoring_61

graphColoring_86:
    movz	w15,	#1

graphColoring_88:
    cmp	w15,	#0
    beq	graphColoring_105

graphColoring_91:
    ldr	x0,	[sp, #96]

    ldr	w0,	[x0]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	x20,	[sp, #112]

    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	w0,	[x19]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	fp,	#140
    ldr	x0,	[sp, fp]

    ldr	w0,	[x0]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w16,	#1
    b	graphColoring_106

graphColoring_105:
    movz	w16,	#0

graphColoring_106:
    cmp	w16,	#0
    bne	graphColoring_119

graphColoring_113:
    movz	w2,	#0
    ldr	x3,	[sp, #104]

    add	w18,	w24,	#1
    str	w2,	[x3]

    mov	w24,	w18
    b	graphColoring_55

graphColoring_119:
    movz	w0,	#1
    b	graphColoring_116

graphColoring_118:
    movz	w0,	#0
    b	graphColoring_116

graphColoring_6:
    movz	w5,	#0

graphColoring_7:
    cmp	w5,	#4
    bge	graphColoring_32

graphColoring_10:
    add	w0,	w5,	#1
    lsl	w16,	w5,	#4
    lsl	w19,	w5,	#2
    movz	fp,	#124
    add	x14,	x23,	x16
    ldr	x6,	[sp, fp]

    add	x17,	x6,	x19
    ldr	w11,	[x17]


graphColoring_15:
    cmp	w0,	#4
    bge	graphColoring_30

graphColoring_18:
    lsl	w22,	w0,	#2
    add	x21,	x14,	x22
    ldr	w24,	[x21]

    cmp	w24,	#0
    beq	graphColoring_28

graphColoring_22:
    lsl	w2,	w0,	#2
    movz	fp,	#124
    ldr	x7,	[sp, fp]

    add	x28,	x7,	x2
    ldr	w2,	[x28]

    cmp	w2,	w11
    bne	graphColoring_28

graphColoring_33:
    movz	w16,	#0
    b	graphColoring_34

graphColoring_28:
    add	w0,	w0,	#1
    b	graphColoring_15

graphColoring_30:
    add	w5,	w5,	#1
    b	graphColoring_7

graphColoring_32:
    movz	w16,	#1

graphColoring_34:
    cmp	w16,	#0
    beq	graphColoring_115

graphColoring_37:
    movz	fp,	#124
    ldr	x24,	[sp, fp]

    ldr	w0,	[x24]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	fp,	#124
    ldr	x20,	[sp, fp]

    add	x28,	x20,	#4
    ldr	w0,	[x28]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	fp,	#124
    ldr	x21,	[sp, fp]

    add	x18,	x21,	#8
    ldr	w0,	[x18]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	fp,	#124
    ldr	x22,	[sp, fp]

    add	x18,	x22,	#12
    ldr	w0,	[x18]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#1
    b	graphColoring_116

graphColoring_115:
    movz	w0,	#0

graphColoring_116:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #160
    ret


.globl main
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w25,	#1
    movz	w27,	#1
    add	x21,	sp,	#32
    movz	w19,	#0
    movz	w26,	#0
    movz	w1,	#1
    movz	w24,	#1
    movz	w23,	#1
    add	x28,	sp,	#92
    movz	w22,	#0
    add	x0,	sp,	#16
    add	x18,	x0,	#12
    add	x3,	x0,	#8
    add	x2,	x0,	#4
    str	w26,	[x0]

    add	x26,	sp,	#48
    str	w25,	[x2]

    add	x25,	x21,	#8
    movz	w2,	#0
    str	w24,	[x3]

    add	x24,	x21,	#4
    movz	w3,	#1
    str	w23,	[x18]

    movz	w18,	#0
    movz	w23,	#1
    str	w3,	[x21]

    add	x3,	sp,	#64
    str	w2,	[x24]

    add	x2,	x26,	#8
    add	x24,	x21,	#12
    str	w1,	[x25]

    add	x20,	x3,	#12
    add	x21,	x3,	#4
    movz	w25,	#1
    add	x1,	x26,	#4
    str	w19,	[x24]

    movz	w19,	#0
    movz	w24,	#0
    str	w27,	[x26]

    add	x27,	sp,	#88
    str	w25,	[x1]

    movz	w25,	#0
    movz	w1,	#1
    str	w24,	[x2]

    add	x2,	x26,	#12
    add	x26,	sp,	#84
    str	w1,	[x2]

    movz	w1,	#0
    movz	w2,	#0
    str	w23,	[x3]

    add	x23,	x3,	#8
    str	w22,	[x21]

    add	x3,	sp,	#80
    movz	w21,	#1
    str	w21,	[x23]

    str	w25,	[x20]

    str	w19,	[x3]

    str	w18,	[x26]

    str	w2,	[x27]

    movz	w2,	#0
    str	w1,	[x28]

    movz	w1,	#3
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


