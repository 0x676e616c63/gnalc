.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #48
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #24]

    bl	getint
    mov	w25,	w0
    bl	getint
    str	w0,	[sp, #28]

    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    str	w0,	[sp, #32]

    bl	getint
    mov	w23,	w0
    bl	getint
    str	w0,	[sp, #20]

    bl	getint
    str	w0,	[sp, #16]

    bl	getint
    ldr	w15,	[sp, #24]

    cmp	w15,	#0
    movz	w17,	#0
    cset	w12,	eq
    sub	w3,	w17,	w25
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w12,	#0
    ldr	w18,	[sp, #28]

    movz	w16,	#0
    csel	w13,	w5,	w16,	ne

main_22:
    cmp	w18,	#0
    beq	main_28

main_26:
    sdiv	w12,	w13,	w18
    msub	w13,	w12,	w18,	w13

    movz	w18,	#0
    b	main_22

main_28:
    mov	w1,	w26

main_29:
    cmp	w1,	#0
    bne	main_45

main_33:
    add	w13,	w13,	#1
    movz	w8,	#0
    movz	w2,	#0
    sub	w4,	w8,	w13
    sub	w10,	w2,	w28
    cmp	w19,	#0
    cset	w16,	eq
    cmp	w16,	#0
    cset	w18,	ne
    cmp	w21,	#0
    movz	w15,	#0
    csel	w8,	w18,	w15,	ne
    ldr	w15,	[sp, #32]

    cmp	w15,	#0
    mov	w2,	w20
    cset	w11,	eq

main_47:
    cmp	w11,	#0
    beq	main_53

main_51:
    sdiv	w5,	w2,	w11
    msub	w2,	w5,	w11,	w2

    movz	w11,	#0
    b	main_47

main_53:
    cmp	w10,	#0
    mov	w5,	w23
    csel	w17,	w8,	w2,	ne

main_56:
    cmp	w5,	#0
    bne	main_62

main_60:
    add	w22,	w17,	#1
    ldr	w13,	[sp, #20]


main_64:
    cmp	w13,	#0
    beq	main_70

main_68:
    sdiv	w2,	w22,	w13
    msub	w22,	w2,	w13,	w22

    movz	w13,	#0
    b	main_64

main_70:
    cmp	w0,	#0
    ldr	w3,	[sp, #16]

    cset	w11,	eq

main_73:
    cmp	w11,	#0
    bne	main_79

main_77:
    add	w6,	w3,	#1
    ldr	w14,	[sp, #24]


main_81:
    cmp	w14,	#0
    bne	main_92

main_86:
    mul	w1,	w6,	w22
    cmp	w4,	#0
    csel	w6,	w27,	w1,	ne
    ldr	w1,	[sp, #28]

    cmp	w1,	#0
    mov	w22,	w26
    cset	w8,	eq

main_94:
    cmp	w22,	#0
    bne	main_100

main_98:
    add	w13,	w8,	#1
    mov	w22,	w25

main_102:
    cmp	w13,	#0
    beq	main_109

main_106:
    sdiv	w17,	w22,	w13
    msub	w22,	w17,	w13,	w22

    movz	w13,	#0
    b	main_102

main_109:
    cmp	w22,	#0
    bne	main_115

main_113:
    add	w5,	w6,	#1

main_117:
    cmp	w28,	#0
    bne	main_124

main_122:
    mul	w18,	w27,	w5
    mov	w26,	w21

main_126:
    cmp	w26,	#0
    beq	main_132

main_130:
    sdiv	w7,	w18,	w26
    movz	w12,	#0
    msub	w18,	w7,	w26,	w18

    mov	w26,	w12
    b	main_126

main_132:
    movz	w13,	#0
    ldr	w24,	[sp, #32]

    mov	w25,	w20
    sub	w15,	w13,	w24

main_134:
    cmp	w15,	#0
    bne	main_141

main_138:
    add	w20,	w25,	#1
    movz	w22,	#0
    sub	w12,	w22,	w23

main_143:
    cmp	w12,	#0
    beq	main_149

main_147:
    sdiv	w27,	w20,	w12
    msub	w20,	w27,	w12,	w20

    movz	w12,	#0
    b	main_143

main_149:
    ldr	w25,	[sp, #16]

    cmp	w25,	#0
    ldr	w27,	[sp, #20]

    cset	w11,	eq

main_152:
    cmp	w11,	#0
    bne	main_160

main_157:
    mul	w16,	w27,	w20
    movz	w12,	#0
    sub	w11,	w12,	w0

main_162:
    cmp	w11,	#0
    beq	main_168

main_166:
    sdiv	w13,	w16,	w11
    msub	w16,	w13,	w11,	w16

    movz	w11,	#0
    b	main_162

main_168:
    ldr	w5,	[sp, #24]


main_169:
    cmp	w5,	#0
    bne	main_175

main_173:
    add	w3,	w16,	#1
    mov	w20,	w19

main_177:
    cmp	w3,	#0
    bne	main_184

main_182:
    mul	w0,	w20,	w18
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #48
    ret


main_184:
    sub	w15,	w20,	w3
    movz	w3,	#0
    mov	w20,	w15
    b	main_177

main_175:
    add	w16,	w5,	w16
    movz	w5,	#0
    b	main_169

main_160:
    sub	w27,	w27,	w11
    movz	w11,	#0
    b	main_152

main_141:
    add	w25,	w15,	w25
    movz	w15,	#0
    b	main_134

main_124:
    sub	w1,	w27,	w28
    movz	w7,	#0
    mov	w27,	w1
    mov	w28,	w7
    b	main_117

main_115:
    add	w6,	w22,	w6
    movz	w22,	#0
    b	main_109

main_100:
    add	w8,	w22,	w8
    movz	w22,	#0
    b	main_94

main_92:
    sub	w6,	w6,	w14
    movz	w14,	#0
    b	main_81

main_79:
    add	w3,	w11,	w3
    movz	w11,	#0
    b	main_73

main_62:
    add	w17,	w5,	w17
    movz	w5,	#0
    b	main_56

main_45:
    add	w13,	w1,	w13
    movz	w1,	#0
    b	main_29

