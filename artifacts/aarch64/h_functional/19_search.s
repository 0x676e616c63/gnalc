.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global a
.align	2
a:
.type a, %object
    .zero	3600

.global w
.align	2
w:
.type w, %object
    .zero	4

.global h
.align	2
h:
.type h, %object
    .zero	4

.global x_1
.align	2
x_1:
.type x_1, %object
    .zero	4

.global y_1
.align	2
y_1:
.type y_1, %object
    .zero	4

.data
.global step
.align	2
step:
.type step, %object
    .word	1
    .word	0
    .word	-1
    .zero	8
    .word	1
    .word	0
    .word	-1


.text

.globl search
.align 2
.p2align 4,,11
.type search, %function
search:
search_3:
    sub	sp, sp, #160
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w16,	#0
    str	w0,	[sp, #128]

    movk	w16,	#16384,	lsl #16
    str	w1,	[sp, #152]

    str	w16,	[sp, #112]

    cmp	w2,	#10
    ble	search_5

search_155:
    ldr	w0,	[sp, #112]

    b	search_157

search_5:
    adrp	x0, :got:x_1
    adrp	x6, :got:y_1
    adrp	x8, :got:h
    adrp	x15, :got:w
    add	w19,	w2,	#1
    movz	w1,	#0
    ldr	x0, [x0, #:got_lo12:x_1]
    ldr	w4,	[x0]

    str	w4,	[sp, #132]

    ldr	x6, [x6, #:got_lo12:y_1]
    ldr	w22,	[x6]

    str	w22,	[sp, #100]

    ldr	x8, [x8, #:got_lo12:h]
    ldr	w7,	[x8]

    add	w28,	w7,	#1
    str	w28,	[sp, #148]

    ldr	x15, [x15, #:got_lo12:w]
    ldr	w14,	[x15]

    add	w24,	w14,	#1
    str	w24,	[sp, #144]

    str	w19,	[sp, #124]

    ldr	w20,	[sp, #124]

    add	w20,	w20,	#1
    str	w20,	[sp, #96]

    ldr	w24,	[sp, #112]

    str	w24,	[sp, #116]

    str	w1,	[sp, #104]


search_14:
    ldr	w1,	[sp, #104]

    cmp	w1,	#4
    blt	search_18

search_152:
    ldr	w25,	[sp, #116]

    cmp	w25,	#10
    ldr	w23,	[sp, #112]

    ldr	w26,	[sp, #116]

    csel	w0,	w23,	w26,	gt
    b	search_157

search_18:
    ldr	w2,	[sp, #104]

    adrp	x13, :got:step
    movz	w7,	#0
    lsl	w23,	w2,	#3
    ldr	x13, [x13, #:got_lo12:step]
    add	x14,	x13,	x23
    add	x1,	x14,	#4
    ldr	w4,	[x14]

    ldr	w12,	[x1]

    ldr	w5,	[sp, #128]

    ldr	w21,	[sp, #152]


search_24:
    lsl	w6,	w5,	#7
    adrp	x28, :got:a
    lsl	w10,	w21,	#2
    ldr	x28, [x28, #:got_lo12:a]
    sub	w9,	w6,	w5,	lsl #3
    add	x28,	x28,	x9
    add	x17,	x28,	x10
    str	x17,	[sp, #136]

    ldr	x18,	[sp, #136]

    ldr	w3,	[x18]

    cmp	w3,	#1
    beq	search_44

search_32:
    ldr	w11,	[sp, #132]

    cmp	w5,	w11
    bne	search_38

search_34:
    ldr	w18,	[sp, #100]

    cmp	w21,	w18
    beq	search_44

search_38:
    add	w5,	w4,	w5
    add	w21,	w12,	w21
    add	w7,	w7,	#1
    b	search_24

search_44:
    ldr	w13,	[sp, #132]

    cmp	w5,	w13
    bne	search_50

search_46:
    ldr	w19,	[sp, #100]

    cmp	w21,	w19
    bne	search_50

search_156:
    movz	w0,	#1

search_157:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #160
    ret


search_50:
    cmp	w7,	#1
    ble	search_52

search_57:
    cmp	w5,	#0
    beq	search_69

search_59:
    ldr	w17,	[sp, #148]

    cmp	w5,	w17
    beq	search_69

search_61:
    cmp	w21,	#0
    beq	search_69

search_63:
    ldr	w13,	[sp, #144]

    cmp	w21,	w13
    bne	search_71

search_69:
    ldr	w3,	[sp, #104]

    ldr	w5,	[sp, #116]

    add	w1,	w3,	#1
    b	search_54

search_71:
    movz	w1,	#0
    ldr	x19,	[sp, #136]

    sub	w20,	w5,	w4
    sub	w28,	w21,	w12
    str	w1,	[x19]

    ldr	w25,	[sp, #124]

    cmp	w25,	#10
    bgt	search_144

search_75:
    ldr	w7,	[sp, #112]

    movz	w3,	#0
    str	w7,	[sp, #120]

    str	w3,	[sp, #108]


search_76:
    ldr	w10,	[sp, #108]

    cmp	w10,	#4
    bge	search_141

search_80:
    ldr	w11,	[sp, #108]

    adrp	x10, :got:step
    movz	w18,	#0
    mov	w6,	w20
    mov	w15,	w28
    lsl	w1,	w11,	#3
    ldr	x10, [x10, #:got_lo12:step]
    add	x10,	x10,	x1
    add	x5,	x10,	#4
    ldr	w2,	[x10]

    ldr	w7,	[x5]


search_86:
    lsl	w8,	w6,	#7
    adrp	x10, :got:a
    lsl	w12,	w15,	#2
    ldr	x10, [x10, #:got_lo12:a]
    sub	w1,	w8,	w6,	lsl #3
    add	x0,	x10,	x1
    add	x26,	x0,	x12
    ldr	w8,	[x26]

    cmp	w8,	#1
    beq	search_106

search_94:
    ldr	w17,	[sp, #132]

    cmp	w6,	w17
    bne	search_100

search_96:
    ldr	w13,	[sp, #100]

    cmp	w15,	w13
    beq	search_106

search_100:
    add	w6,	w2,	w6
    add	w15,	w7,	w15
    add	w18,	w18,	#1
    b	search_86

search_106:
    ldr	w19,	[sp, #132]

    cmp	w6,	w19
    bne	search_112

search_108:
    ldr	w14,	[sp, #100]

    cmp	w15,	w14
    bne	search_112

search_145:
    movz	w18,	#1
    b	search_146

search_112:
    cmp	w18,	#1
    ble	search_114

search_119:
    cmp	w6,	#0
    beq	search_131

search_121:
    ldr	w4,	[sp, #148]

    cmp	w6,	w4
    beq	search_131

search_123:
    cmp	w15,	#0
    beq	search_131

search_125:
    ldr	w27,	[sp, #144]

    cmp	w15,	w27
    bne	search_133

search_131:
    ldr	w12,	[sp, #108]

    ldr	w10,	[sp, #120]

    add	w3,	w12,	#1
    b	search_116

search_133:
    movz	w0,	#0
    sub	w1,	w15,	w7
    str	w0,	[x26]

    sub	w0,	w6,	w2
    ldr	w2,	[sp, #96]

    bl	search
    ldr	w18,	[sp, #120]

    add	w11,	w0,	#1
    cmp	w11,	w18
    ldr	w19,	[sp, #120]

    csel	w10,	w11,	w19,	lt
    movz	w11,	#1
    str	w11,	[x26]

    ldr	w7,	[sp, #108]

    add	w3,	w7,	#1
    b	search_116

search_114:
    ldr	w14,	[sp, #108]

    ldr	w10,	[sp, #120]

    add	w3,	w14,	#1

search_116:
    str	w10,	[sp, #120]

    str	w3,	[sp, #108]

    b	search_76

search_141:
    ldr	w10,	[sp, #120]

    cmp	w10,	#10
    ldr	w7,	[sp, #112]

    ldr	w12,	[sp, #120]

    csel	w18,	w7,	w12,	gt
    b	search_146

search_144:
    ldr	w18,	[sp, #112]


search_146:
    add	w3,	w18,	#1
    ldr	w28,	[sp, #116]

    cmp	w3,	w28
    movz	w10,	#1
    ldr	w0,	[sp, #116]

    ldr	x18,	[sp, #136]

    csel	w5,	w3,	w0,	lt
    str	w10,	[x18]

    ldr	w3,	[sp, #104]

    add	w1,	w3,	#1
    b	search_54

search_52:
    ldr	w5,	[sp, #104]

    add	w1,	w5,	#1
    ldr	w5,	[sp, #116]


search_54:
    str	w5,	[sp, #116]

    str	w1,	[sp, #104]

    b	search_14

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    adrp	x26, :got:w
    mov	w27,	w0
    ldr	x26, [x26, #:got_lo12:w]
    str	w27,	[x26]

    bl	getint
    adrp	x13, :got:h
    ldr	x13, [x13, #:got_lo12:h]
    str	w0,	[x13]

    cmp	w27,	#0
    beq	main_96

main_4:
    movz	w24,	#0
    movz	w28,	#0

main_6:
    movz	w1,	#0

main_11:
    lsl	w25,	w1,	#7
    movz	w3,	#0
    sub	w18,	w25,	w1,	lsl #3
    adrp	x25, :got:a
    ldr	x25, [x25, #:got_lo12:a]
    add	x5,	x25,	x18

main_14:
    cmp	w3,	#24
    blt	main_17

main_36:
    lsl	w13,	w3,	#2
    movz	w25,	#1
    add	w3,	w3,	#1
    add	x10,	x5,	x13
    str	w25,	[x10]

    cmp	w3,	#30
    blt	main_36

main_41:
    add	w1,	w1,	#1
    cmp	w1,	#30
    blt	main_11

main_44:
    adrp	x25, :got:h
    movz	w23,	#1
    ldr	x25, [x25, #:got_lo12:h]
    ldr	w22,	[x25]

    cmp	w23,	w22
    bgt	main_83

main_47:
    movz	w23,	#1

main_49:
    movz	w2,	#1
    cmp	w2,	w27
    bgt	main_76

main_54:
    lsl	w4,	w23,	#7
    adrp	x9, :got:a
    ldr	x9, [x9, #:got_lo12:a]
    sub	w21,	w4,	w23,	lsl #3
    add	x25,	x9,	x21
    movz	w21,	#1

main_57:
    lsl	w20,	w21,	#2
    add	x20,	x25,	x20
    bl	getint
    str	w0,	[x20]

    cmp	w0,	#2
    bne	main_64

main_67:
    mov	w24,	w21
    mov	w28,	w23
    b	main_69

main_64:
    cmp	w0,	#3
    bne	main_69

main_66:
    adrp	x4, :got:x_1
    adrp	x5, :got:y_1
    ldr	x4, [x4, #:got_lo12:x_1]
    str	w23,	[x4]

    ldr	x5, [x5, #:got_lo12:y_1]
    str	w21,	[x5]


main_69:
    add	w21,	w21,	#1
    cmp	w21,	w27
    ble	main_57

main_76:
    add	w23,	w23,	#1
    cmp	w23,	w22
    ble	main_49

main_83:
    mov	w0,	w28
    mov	w1,	w24
    movz	w2,	#1
    bl	search
    cmp	w0,	#10
    ble	main_88

main_89:
    movz	w0,	#65535
    movk	w0,	#65535,	lsl #16
    bl	putint
    movz	w0,	#10
    bl	putch
    b	main_90

main_88:
    bl	putint
    movz	w0,	#10
    bl	putch

main_90:
    bl	getint
    adrp	x21, :got:w
    mov	w27,	w0
    ldr	x21, [x21, #:got_lo12:w]
    str	w27,	[x21]

    bl	getint
    adrp	x21, :got:h
    ldr	x21, [x21, #:got_lo12:h]
    str	w0,	[x21]

    cmp	w27,	#0
    bne	main_6
    b	main_96

main_17:
    lsl	w22,	w3,	#2
    movz	w12,	#1
    add	w14,	w3,	#1
    movz	w10,	#1
    movz	w8,	#1
    movz	w6,	#1
    movz	w19,	#1
    movz	w15,	#1
    add	x21,	x5,	x22
    add	w18,	w14,	#1
    lsl	w11,	w14,	#2
    str	w12,	[x21]

    lsl	w14,	w18,	#2
    add	x25,	x5,	x11
    add	w21,	w18,	#1
    add	x3,	x5,	x14
    str	w10,	[x25]

    lsl	w17,	w21,	#2
    add	w25,	w21,	#1
    str	w8,	[x3]

    movz	w21,	#1
    add	x8,	x5,	x17
    movz	w17,	#1
    lsl	w20,	w25,	#2
    add	w3,	w25,	#1
    str	w6,	[x8]

    add	x10,	x5,	x20
    lsl	w23,	w3,	#2
    add	w8,	w3,	#1
    str	w21,	[x10]

    add	x13,	x5,	x23
    add	w11,	w8,	#1
    lsl	w2,	w8,	#2
    str	w19,	[x13]

    add	x16,	x5,	x2
    add	w3,	w11,	#1
    lsl	w6,	w11,	#2
    str	w17,	[x16]

    add	x20,	x5,	x6
    str	w15,	[x20]

    b	main_14

main_96:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


