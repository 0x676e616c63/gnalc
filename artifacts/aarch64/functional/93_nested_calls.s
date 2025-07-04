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
    sub	sp, sp, #32
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #24]

    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w22,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    str	w0,	[sp, #28]

    bl	getint
    mov	w23,	w0
    bl	getint
    str	w0,	[sp, #16]

    bl	getint
    str	w0,	[sp, #20]

    bl	getint
    ldr	w14,	[sp, #24]

    cmp	w14,	#0
    movz	w17,	#0
    cset	w12,	eq
    sub	w3,	w17,	w25
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w12,	#0
    mov	w18,	w22
    movz	w16,	#0
    csel	w13,	w5,	w16,	ne

main_22:
    cmp	w18,	#0
    bne	main_26

main_28:
    mov	w2,	w21

main_29:
    cmp	w2,	#0
    beq	main_33

main_45:
    add	w13,	w2,	w13
    movz	w2,	#0
    b	main_29

main_33:
    add	w13,	w13,	#1
    movz	w6,	#0
    movz	w18,	#0
    sub	w1,	w6,	w13
    sub	w9,	w18,	w27
    cmp	w19,	#0
    cset	w16,	eq
    cmp	w16,	#0
    cset	w18,	ne
    cmp	w28,	#0
    ldr	w11,	[sp, #28]

    movz	w13,	#0
    csel	w8,	w18,	w13,	ne
    cmp	w11,	#0
    mov	w15,	w20
    cset	w3,	eq

main_47:
    cmp	w3,	#0
    bne	main_51

main_53:
    cmp	w9,	#0
    mov	w13,	w23
    csel	w4,	w8,	w15,	ne

main_56:
    cmp	w13,	#0
    beq	main_60

main_62:
    add	w4,	w13,	w4
    movz	w13,	#0
    b	main_56

main_60:
    add	w5,	w4,	#1
    ldr	w9,	[sp, #16]


main_64:
    cmp	w9,	#0
    bne	main_68

main_70:
    cmp	w0,	#0
    ldr	w10,	[sp, #20]

    cset	w4,	eq

main_73:
    cmp	w4,	#0
    beq	main_77

main_79:
    add	w10,	w4,	w10
    movz	w4,	#0
    b	main_73

main_77:
    add	w13,	w10,	#1
    ldr	w3,	[sp, #24]


main_81:
    cmp	w3,	#0
    beq	main_86

main_92:
    sub	w13,	w13,	w3
    movz	w3,	#0
    b	main_81

main_86:
    mul	w3,	w13,	w5
    cmp	w1,	#0
    csel	w6,	w26,	w3,	ne
    cmp	w22,	#0
    cset	w15,	eq

main_94:
    cmp	w21,	#0
    beq	main_98

main_100:
    add	w15,	w21,	w15
    movz	w21,	#0
    b	main_94

main_98:
    add	w11,	w15,	#1
    mov	w21,	w25

main_102:
    cmp	w11,	#0
    bne	main_106

main_109:
    cmp	w21,	#0
    beq	main_113

main_115:
    add	w6,	w21,	w6
    movz	w21,	#0
    b	main_109

main_113:
    add	w5,	w6,	#1
    mov	w22,	w26
    mov	w25,	w27

main_117:
    cmp	w25,	#0
    beq	main_122

main_124:
    sub	w2,	w22,	w25
    movz	w7,	#0
    mov	w22,	w2
    mov	w25,	w7
    b	main_117

main_122:
    mul	w15,	w22,	w5
    mov	w12,	w28

main_126:
    cmp	w12,	#0
    bne	main_130

main_132:
    movz	w3,	#0
    ldr	w17,	[sp, #28]

    mov	w5,	w20
    sub	w7,	w3,	w17

main_134:
    cmp	w7,	#0
    beq	main_138

main_141:
    add	w5,	w7,	w5
    movz	w7,	#0
    b	main_134

main_138:
    add	w20,	w5,	#1
    movz	w8,	#0
    sub	w12,	w8,	w23

main_143:
    cmp	w12,	#0
    bne	main_147

main_149:
    ldr	w25,	[sp, #20]

    cmp	w25,	#0
    ldr	w1,	[sp, #16]

    cset	w27,	eq

main_152:
    cmp	w27,	#0
    beq	main_157

main_160:
    sub	w1,	w1,	w27
    movz	w27,	#0
    b	main_152

main_157:
    mul	w22,	w1,	w20
    movz	w4,	#0
    sub	w11,	w4,	w0

main_162:
    cmp	w11,	#0
    bne	main_166

main_168:
    ldr	w5,	[sp, #24]


main_169:
    cmp	w5,	#0
    beq	main_173

main_175:
    add	w22,	w5,	w22
    movz	w5,	#0
    b	main_169

main_173:
    add	w20,	w22,	#1

main_177:
    cmp	w20,	#0
    beq	main_182

main_184:
    sub	w16,	w19,	w20
    movz	w20,	#0
    mov	w19,	w16
    b	main_177

main_182:
    mul	w0,	w19,	w15
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #32
    ret


main_166:
    sdiv	w4,	w22,	w11
    msub	w22,	w4,	w11,	w22

    movz	w11,	#0
    b	main_162

main_147:
    sdiv	w14,	w20,	w12
    msub	w20,	w14,	w12,	w20

    movz	w12,	#0
    b	main_143

main_130:
    sdiv	w4,	w15,	w12
    msub	w15,	w4,	w12,	w15

    movz	w12,	#0
    b	main_126

main_106:
    sdiv	w25,	w21,	w11
    msub	w21,	w25,	w11,	w21

    movz	w11,	#0
    b	main_102

main_68:
    sdiv	w15,	w5,	w9
    msub	w5,	w15,	w9,	w5

    movz	w9,	#0
    b	main_64

main_51:
    sdiv	w17,	w15,	w3
    msub	w15,	w17,	w3,	w15

    movz	w3,	#0
    b	main_47

main_26:
    sdiv	w16,	w13,	w18
    msub	w13,	w16,	w18,	w13

    movz	w18,	#0
    b	main_22

