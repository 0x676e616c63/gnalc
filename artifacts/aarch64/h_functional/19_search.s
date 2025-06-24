.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global a
.align	2
a:
    .zero	3600

.global w
.align	2
w:
    .zero	4

.global h
.align	2
h:
    .zero	4

.global x_1
.align	2
x_1:
    .zero	4

.global y_1
.align	2
y_1:
    .zero	4

.global step
.align	2
step:
    .word	1
    .word	0
    .word	-1
    .zero	8
    .word	1
    .word	0
    .word	-1


.text

.globl search
search:
search_3:
    sub	sp, sp, #160
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w18,	#0
    mov	w21,	w0
    str	w1,	[sp, #96]

    movk	w18,	#16384,	lsl #16
    str	w18,	[sp, #116]

    cmp	w2,	#10
    bgt	search_155

search_5:
    adrp	x1, :got:x_1
    adrp	x6, :got:y_1
    adrp	x8, :got:h
    adrp	x15, :got:w
    add	w16,	w2,	#1
    movz	w23,	#0
    ldr	x1, [x1, #:got_lo12:x_1]
    ldr	w5,	[x1]

    str	w5,	[sp, #144]

    ldr	x6, [x6, #:got_lo12:y_1]
    ldr	w24,	[x6]

    str	w24,	[sp, #108]

    ldr	x8, [x8, #:got_lo12:h]
    ldr	w7,	[x8]

    add	w0,	w7,	#1
    str	w0,	[sp, #128]

    ldr	x15, [x15, #:got_lo12:w]
    ldr	w14,	[x15]

    add	w25,	w14,	#1
    str	w25,	[sp, #148]

    str	w16,	[sp, #132]

    ldr	w17,	[sp, #132]

    add	w18,	w17,	#1
    str	w18,	[sp, #100]

    ldr	w24,	[sp, #116]

    str	w24,	[sp, #120]

    str	w23,	[sp, #104]


search_14:
    ldr	w0,	[sp, #104]

    cmp	w0,	#4
    bge	search_152

search_18:
    ldr	w1,	[sp, #104]

    adrp	x11, :got:step
    movz	w7,	#0
    mov	w5,	w21
    lsl	w20,	w1,	#3
    ldr	x11, [x11, #:got_lo12:step]
    add	x12,	x11,	x20
    add	x2,	x12,	#4
    ldr	w13,	[x12]

    ldr	w2,	[x2]

    ldr	w17,	[sp, #96]


search_24:
    lsl	w4,	w5,	#7
    adrp	x26, :got:a
    lsl	w6,	w17,	#2
    ldr	x26, [x26, #:got_lo12:a]
    sub	w28,	w4,	w5,	lsl #3
    add	x25,	x26,	x28
    add	x16,	x25,	x6
    str	x16,	[sp, #136]

    ldr	x18,	[sp, #136]

    ldr	w0,	[x18]

    cmp	w0,	#1
    beq	search_44

search_32:
    ldr	w10,	[sp, #144]

    cmp	w5,	w10
    bne	search_38

search_34:
    ldr	w18,	[sp, #108]

    cmp	w17,	w18
    beq	search_44

search_38:
    add	w5,	w13,	w5
    add	w17,	w2,	w17
    add	w7,	w7,	#1
    b	search_24

search_44:
    ldr	w11,	[sp, #144]

    cmp	w5,	w11
    bne	search_50

search_46:
    ldr	w19,	[sp, #108]

    cmp	w17,	w19
    bne	search_50

search_156:
    movz	w0,	#1
    b	search_157

search_50:
    cmp	w7,	#1
    bgt	search_54

search_52:
    ldr	w2,	[sp, #104]

    ldr	w27,	[sp, #120]

    add	w13,	w2,	#1
    b	search_149

search_54:
    cmp	w5,	#0
    beq	search_66

search_56:
    ldr	w1,	[sp, #128]

    cmp	w5,	w1
    beq	search_66

search_58:
    cmp	w17,	#0
    beq	search_66

search_60:
    ldr	w26,	[sp, #148]

    cmp	w17,	w26
    beq	search_66

search_68:
    movz	w0,	#0
    ldr	x19,	[sp, #136]

    sub	w25,	w5,	w13
    sub	w28,	w17,	w2
    str	w0,	[x19]

    ldr	w16,	[sp, #132]

    cmp	w16,	#10
    ble	search_72

search_141:
    ldr	w15,	[sp, #116]

    b	search_143

search_72:
    ldr	w2,	[sp, #116]

    movz	w20,	#0
    str	w2,	[sp, #124]

    str	w20,	[sp, #112]


search_73:
    ldr	w4,	[sp, #112]

    cmp	w4,	#4
    blt	search_77

search_138:
    ldr	w5,	[sp, #124]

    cmp	w5,	#10
    ldr	w1,	[sp, #116]

    ldr	w10,	[sp, #124]

    csel	w15,	w1,	w10,	gt
    b	search_143

search_77:
    ldr	w5,	[sp, #112]

    adrp	x9, :got:step
    movz	w17,	#0
    mov	w4,	w28
    lsl	w1,	w5,	#3
    ldr	x9, [x9, #:got_lo12:step]
    add	x10,	x9,	x1
    add	x5,	x10,	#4
    ldr	w3,	[x10]

    ldr	w14,	[x5]

    mov	w5,	w25

search_83:
    lsl	w10,	w5,	#7
    adrp	x11, :got:a
    lsl	w13,	w4,	#2
    ldr	x11, [x11, #:got_lo12:a]
    sub	w1,	w10,	w5,	lsl #3
    add	x0,	x11,	x1
    add	x20,	x0,	x13
    ldr	w9,	[x20]

    cmp	w9,	#1
    beq	search_103

search_91:
    ldr	w10,	[sp, #144]

    cmp	w5,	w10
    bne	search_97

search_93:
    ldr	w7,	[sp, #108]

    cmp	w4,	w7
    beq	search_103

search_97:
    add	w5,	w3,	w5
    add	w4,	w14,	w4
    add	w17,	w17,	#1
    b	search_83

search_103:
    ldr	w11,	[sp, #144]

    cmp	w5,	w11
    bne	search_109

search_105:
    ldr	w8,	[sp, #108]

    cmp	w4,	w8
    bne	search_109

search_142:
    movz	w15,	#1

search_143:
    add	w4,	w15,	#1
    ldr	w26,	[sp, #120]

    cmp	w4,	w26
    movz	w6,	#1
    ldr	w27,	[sp, #120]

    ldr	x10,	[sp, #136]

    csel	w27,	w4,	w27,	lt
    str	w6,	[x10]

    ldr	w5,	[sp, #104]

    add	w13,	w5,	#1
    b	search_149

search_109:
    cmp	w17,	#1
    bgt	search_113

search_111:
    ldr	w6,	[sp, #112]

    ldr	w7,	[sp, #124]

    add	w6,	w6,	#1
    b	search_135

search_113:
    cmp	w5,	#0
    beq	search_125

search_115:
    ldr	w8,	[sp, #128]

    cmp	w5,	w8
    beq	search_125

search_117:
    cmp	w4,	#0
    beq	search_125

search_119:
    ldr	w1,	[sp, #148]

    cmp	w4,	w1
    beq	search_125

search_127:
    movz	w1,	#0
    sub	w0,	w5,	w3
    str	w1,	[x20]

    ldr	w2,	[sp, #100]

    sub	w1,	w4,	w14
    bl	search
    ldr	w8,	[sp, #124]

    add	w15,	w0,	#1
    cmp	w15,	w8
    movz	w12,	#1
    ldr	w9,	[sp, #124]

    csel	w7,	w15,	w9,	lt
    str	w12,	[x20]

    ldr	w20,	[sp, #112]

    add	w6,	w20,	#1
    b	search_135

search_125:
    ldr	w8,	[sp, #112]

    ldr	w7,	[sp, #124]

    add	w6,	w8,	#1

search_135:
    str	w7,	[sp, #124]

    str	w6,	[sp, #112]

    b	search_73

search_66:
    ldr	w4,	[sp, #104]

    ldr	w27,	[sp, #120]

    add	w13,	w4,	#1

search_149:
    str	w27,	[sp, #120]

    str	w13,	[sp, #104]

    b	search_14

search_152:
    ldr	w1,	[sp, #120]

    cmp	w1,	#10
    ldr	w4,	[sp, #116]

    ldr	w2,	[sp, #120]

    csel	w0,	w4,	w2,	gt
    b	search_157

search_155:
    ldr	w0,	[sp, #116]


search_157:
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
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    adrp	x26, :got:w
    mov	w28,	w0
    ldr	x26, [x26, #:got_lo12:w]
    str	w28,	[x26]

    bl	getint
    adrp	x13, :got:h
    ldr	x13, [x13, #:got_lo12:h]
    str	w0,	[x13]

    cmp	w28,	#0
    beq	main_96

main_4:
    movz	w23,	#0
    movz	w20,	#0

main_6:
    movz	w22,	#0

main_11:
    lsl	w21,	w22,	#7
    adrp	x26, :got:a
    movz	w27,	#0
    ldr	x26, [x26, #:got_lo12:a]
    sub	w17,	w21,	w22,	lsl #3
    add	x6,	x26,	x17

main_14:
    cmp	w27,	#24
    bge	main_36

main_17:
    lsl	w11,	w27,	#2
    movz	w10,	#1
    add	w26,	w27,	#1
    movz	w5,	#1
    movz	w3,	#1
    movz	w24,	#1
    movz	w19,	#1
    add	x8,	x6,	x11
    add	w2,	w26,	#1
    lsl	w1,	w26,	#2
    movz	w26,	#1
    str	w10,	[x8]

    add	x14,	x6,	x1
    add	w7,	w2,	#1
    lsl	w4,	w2,	#2
    movz	w1,	#1
    str	w5,	[x14]

    add	x17,	x6,	x4
    add	w9,	w7,	#1
    lsl	w8,	w7,	#2
    str	w3,	[x17]

    add	x21,	x6,	x8
    add	w13,	w9,	#1
    lsl	w11,	w9,	#2
    str	w1,	[x21]

    add	x25,	x6,	x11
    add	w16,	w13,	#1
    lsl	w14,	w13,	#2
    str	w26,	[x25]

    add	x2,	x6,	x14
    lsl	w17,	w16,	#2
    str	w24,	[x2]

    add	x5,	x6,	x17
    add	w24,	w16,	#1
    movz	w17,	#1
    str	w19,	[x5]

    add	w27,	w24,	#1
    lsl	w21,	w24,	#2
    add	x9,	x6,	x21
    str	w17,	[x9]

    b	main_14

main_36:
    lsl	w13,	w27,	#2
    movz	w12,	#1
    add	w27,	w27,	#1
    add	x11,	x6,	x13
    str	w12,	[x11]

    cmp	w27,	#30
    blt	main_36

main_41:
    add	w22,	w22,	#1
    cmp	w22,	#30
    blt	main_11

main_44:
    adrp	x25, :got:h
    movz	w11,	#1
    ldr	x25, [x25, #:got_lo12:h]
    ldr	w22,	[x25]

    cmp	w11,	w22
    bgt	main_83

main_47:
    movz	w27,	#1

main_49:
    movz	w15,	#1
    cmp	w15,	w28
    bgt	main_76

main_54:
    lsl	w1,	w27,	#7
    adrp	x10, :got:a
    movz	w19,	#1
    ldr	x10, [x10, #:got_lo12:a]
    sub	w26,	w1,	w27,	lsl #3
    add	x25,	x10,	x26

main_57:
    lsl	w24,	w19,	#2
    add	x24,	x25,	x24
    bl	getint
    str	w0,	[x24]

    cmp	w0,	#2
    beq	main_67

main_64:
    cmp	w0,	#3
    bne	main_69

main_66:
    adrp	x7, :got:x_1
    adrp	x8, :got:y_1
    ldr	x7, [x7, #:got_lo12:x_1]
    str	w27,	[x7]

    ldr	x8, [x8, #:got_lo12:y_1]
    str	w19,	[x8]

    b	main_69

main_67:
    mov	w23,	w19
    mov	w20,	w27

main_69:
    add	w19,	w19,	#1
    cmp	w19,	w28
    ble	main_57

main_76:
    add	w27,	w27,	#1
    cmp	w27,	w22
    ble	main_49

main_83:
    mov	w0,	w20
    mov	w1,	w23
    movz	w2,	#1
    bl	search
    cmp	w0,	#10
    bgt	main_89

main_88:
    bl	putint
    movz	w0,	#10
    bl	putch
    b	main_90

main_89:
    movz	w0,	#65535
    movk	w0,	#65535,	lsl #16
    bl	putint
    movz	w0,	#10
    bl	putch

main_90:
    bl	getint
    adrp	x22, :got:w
    mov	w28,	w0
    ldr	x22, [x22, #:got_lo12:w]
    str	w28,	[x22]

    bl	getint
    adrp	x21, :got:h
    ldr	x21, [x21, #:got_lo12:h]
    str	w0,	[x21]

    cmp	w28,	#0
    bne	main_6

main_96:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


