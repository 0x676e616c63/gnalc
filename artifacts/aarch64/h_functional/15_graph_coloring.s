.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl graphColoring
graphColoring:
graphColoring_4:
    sub	sp, sp, #144
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	x21,	x3
    mov	w22,	w1
    mov	x23,	x0
    cmp	w2,	#4
    beq	graphColoring_6

graphColoring_46:
    lsl	w4,	w2,	#2
    movz	fp,	#124
    add	w8,	w2,	#1
    mov	x27,	x21
    add	x12,	x21,	#4
    add	x24,	x21,	#8
    add	x15,	x21,	#12
    add	x9,	x21,	x4
    str	x9,	[sp, fp]

    movz	fp,	#108
    str	w8,	[sp, #132]

    str	x12,	[sp, fp]

    movz	fp,	#116
    str	x24,	[sp, #96]

    movz	w24,	#1
    str	x15,	[sp, #136]

    ldr	w19,	[sp, #132]

    lsl	w10,	w19,	#2
    add	x4,	x21,	x10
    str	x4,	[sp, fp]

    ldr	w20,	[sp, #132]

    add	w19,	w20,	#1

graphColoring_55:
    cmp	w24,	w22
    bgt	graphColoring_118

graphColoring_58:
    movz	fp,	#124
    ldr	x16,	[sp, fp]

    str	w24,	[x16]

    ldr	w5,	[sp, #132]

    cmp	w5,	#4
    beq	graphColoring_60

graphColoring_96:
    movz	w8,	#1
    str	w8,	[sp, #104]


graphColoring_97:
    ldr	w26,	[sp, #104]

    cmp	w26,	w22
    bgt	graphColoring_109

graphColoring_100:
    ldr	w2,	[sp, #104]

    movz	fp,	#116
    mov	x0,	x23
    mov	w1,	w22
    ldr	x3,	[sp, fp]

    str	w2,	[x3]

    mov	x3,	x21
    mov	w2,	w19
    bl	graphColoring
    cmp	w0,	#0
    bne	graphColoring_110

graphColoring_103:
    movz	w1,	#0
    movz	fp,	#116
    ldr	x5,	[sp, fp]

    str	w1,	[x5]

    ldr	w4,	[sp, #104]

    add	w18,	w4,	#1
    str	w18,	[sp, #104]

    b	graphColoring_97

graphColoring_110:
    movz	w9,	#1
    b	graphColoring_106

graphColoring_109:
    movz	w9,	#0
    b	graphColoring_106

graphColoring_60:
    movz	w0,	#0

graphColoring_61:
    cmp	w0,	#4
    bge	graphColoring_86

graphColoring_64:
    add	w2,	w0,	#1
    lsl	w25,	w0,	#4
    lsl	w13,	w0,	#2
    add	x20,	x23,	x25
    add	x12,	x21,	x13
    ldr	w14,	[x12]


graphColoring_69:
    cmp	w2,	#4
    bge	graphColoring_84

graphColoring_72:
    lsl	w28,	w2,	#2
    add	x25,	x20,	x28
    ldr	w4,	[x25]

    cmp	w4,	#0
    beq	graphColoring_82

graphColoring_76:
    lsl	w4,	w2,	#2
    add	x1,	x21,	x4
    ldr	w5,	[x1]

    cmp	w5,	w14
    bne	graphColoring_82

graphColoring_87:
    movz	w8,	#0
    b	graphColoring_88

graphColoring_82:
    add	w2,	w2,	#1
    b	graphColoring_69

graphColoring_84:
    add	w0,	w0,	#1
    b	graphColoring_61

graphColoring_86:
    movz	w8,	#1

graphColoring_88:
    cmp	w8,	#0
    beq	graphColoring_105

graphColoring_91:
    ldr	w0,	[x27]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	fp,	#108
    ldr	x28,	[sp, fp]

    ldr	w0,	[x28]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	x0,	[sp, #96]

    ldr	w0,	[x0]

    bl	putint
    movz	w0,	#32
    bl	putch
    ldr	x20,	[sp, #136]

    ldr	w0,	[x20]

    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w9,	#1
    b	graphColoring_106

graphColoring_105:
    movz	w9,	#0

graphColoring_106:
    cmp	w9,	#0
    bne	graphColoring_119

graphColoring_113:
    movz	w4,	#0
    movz	fp,	#124
    add	w24,	w24,	#1
    ldr	x9,	[sp, fp]

    str	w4,	[x9]

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
    add	w16,	w5,	#1
    lsl	w22,	w5,	#4
    lsl	w0,	w5,	#2
    add	x20,	x23,	x22
    add	x4,	x21,	x0
    ldr	w1,	[x4]


graphColoring_15:
    cmp	w16,	#4
    bge	graphColoring_30

graphColoring_18:
    lsl	w4,	w16,	#2
    add	x0,	x20,	x4
    ldr	w6,	[x0]

    cmp	w6,	#0
    beq	graphColoring_28

graphColoring_22:
    lsl	w3,	w16,	#2
    add	x0,	x21,	x3
    ldr	w4,	[x0]

    cmp	w4,	w1
    bne	graphColoring_28

graphColoring_33:
    movz	w7,	#0
    b	graphColoring_34

graphColoring_28:
    add	w16,	w16,	#1
    b	graphColoring_15

graphColoring_30:
    add	w5,	w5,	#1
    b	graphColoring_7

graphColoring_32:
    movz	w7,	#1

graphColoring_34:
    cmp	w7,	#0
    beq	graphColoring_115

graphColoring_37:
    mov	x26,	x21
    ldr	w0,	[x26]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	x19,	x21,	#4
    ldr	w0,	[x19]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	x23,	x21,	#8
    ldr	w0,	[x23]

    bl	putint
    movz	w0,	#32
    bl	putch
    add	x18,	x21,	#12
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
    
    add	sp, sp, #144
    ret


.globl main
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    movz	w28,	#0
    movz	w25,	#1
    movz	w27,	#1
    movz	w22,	#1
    add	x0,	sp,	#32
    movz	w23,	#0
    add	x21,	sp,	#48
    movz	w26,	#1
    movz	w19,	#0
    add	x18,	x0,	#12
    add	x3,	x0,	#8
    add	x2,	x0,	#4
    str	w28,	[x0]

    add	x24,	x21,	#4
    movz	w28,	#1
    str	w27,	[x2]

    movz	w27,	#1
    movz	w2,	#1
    str	w26,	[x3]

    add	x26,	sp,	#64
    movz	w3,	#0
    str	w25,	[x18]

    add	x25,	x21,	#8
    movz	w18,	#1
    add	x1,	x26,	#4
    str	w18,	[x21]

    movz	w18,	#0
    str	w3,	[x24]

    movz	w3,	#1
    add	x24,	x21,	#12
    str	w2,	[x25]

    movz	w21,	#0
    movz	w25,	#0
    add	x2,	x26,	#8
    str	w21,	[x24]

    movz	w24,	#1
    str	w28,	[x26]

    add	x28,	sp,	#28
    str	w27,	[x1]

    movz	w27,	#0
    add	x1,	x26,	#12
    str	w25,	[x2]

    add	x26,	sp,	#20
    movz	w2,	#0
    str	w3,	[x1]

    movz	w1,	#3
    add	x3,	sp,	#80
    add	x20,	x3,	#12
    add	x21,	x3,	#4
    str	w24,	[x3]

    str	w23,	[x21]

    add	x23,	x3,	#8
    add	x3,	sp,	#16
    str	w22,	[x23]

    str	w27,	[x20]

    add	x27,	sp,	#24
    movz	w20,	#0
    str	w20,	[x3]

    str	w19,	[x26]

    str	w18,	[x27]

    str	w2,	[x28]

    movz	w2,	#0
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


