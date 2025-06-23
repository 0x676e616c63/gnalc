.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global fa
.align	2
fa:
    .zero	400020


.text

.globl find
find:
find_1:
    sub	sp, sp, #48
    stp	x22, x24, [sp, #0]
    stp	x28, fp, [sp, #16]
    str	lr, [sp, 32]

    adrp	x3, :got:fa
    lsl	w24,	w0,	#2
    ldr	x3, [x3, #:got_lo12:fa]
    add	x22,	x3,	x24
    ldr	w4,	[x22]

    cmp	w4,	w0
    beq	find_15

find_5:
    lsl	w0,	w4,	#2
    adrp	x8, :got:fa
    ldr	x8, [x8, #:got_lo12:fa]
    add	x28,	x8,	x0
    ldr	w0,	[x28]

    cmp	w0,	w4
    beq	find_11

find_9:
    bl	find
    str	w0,	[x28]

    b	find_12

find_11:
    mov	w0,	w4

find_12:
    str	w0,	[x22]


find_15:
    ldp	x22, x24, [sp, #0]
    ldp	x28, fp, [sp, #16]
    ldr	lr, [sp, 32]

    add	sp, sp, #48
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getch
    movz	w26,	#0
    mov	w14,	w0

main_2:
    cmp	w14,	#48
    blt	main_10

main_6:
    cmp	w14,	#57
    bgt	main_10

main_14:
    movz	w21,	#0

main_15:
    cmp	w14,	#48
    blt	main_28

main_19:
    cmp	w14,	#57
    bgt	main_28

main_21:
    lsl	w25,	w21,	#1
    add	w25,	w25,	w21,	lsl #3
    add	w27,	w14,	w25
    sub	w21,	w27,	#48
    bl	getch
    mov	w14,	w0
    b	main_15

main_28:
    movz	w25,	#0
    sub	w23,	w25,	w21
    cmp	w26,	#0
    csel	w19,	w23,	w21,	ne
    cset	w20,	ne
    bl	getch
    movz	w20,	#0
    mov	w18,	w0

main_33:
    cmp	w18,	#48
    blt	main_41

main_37:
    cmp	w18,	#57
    bgt	main_41

main_45:
    movz	w27,	#0

main_46:
    cmp	w18,	#48
    blt	main_59

main_50:
    cmp	w18,	#57
    bgt	main_59

main_52:
    lsl	w21,	w27,	#1
    add	w24,	w21,	w27,	lsl #3
    add	w25,	w18,	w24
    sub	w27,	w25,	#48
    bl	getch
    mov	w18,	w0
    b	main_46

main_59:
    movz	w15,	#0
    sub	w28,	w15,	w27
    cmp	w20,	#0
    movz	w14,	#1
    csel	w28,	w28,	w27,	ne
    cset	w15,	ne

main_63:
    cmp	w14,	w19
    bgt	main_69

main_66:
    lsl	w5,	w14,	#2
    adrp	x27, :got:fa
    ldr	x27, [x27, #:got_lo12:fa]
    add	x25,	x27,	x5
    str	w14,	[x25]

    add	w14,	w14,	#1
    b	main_63

main_69:
    cmp	w28,	#0
    beq	main_225

main_73:
    bl	getch
    mov	w16,	w0

main_76:
    cmp	w16,	#81
    beq	main_85

main_79:
    cmp	w16,	#85
    beq	main_85

main_81:
    bl	getch
    mov	w16,	w0
    b	main_76

main_85:
    cmp	w16,	#81
    beq	main_87

main_154:
    bl	getch
    movz	w22,	#0
    mov	w19,	w0

main_156:
    cmp	w19,	#48
    blt	main_164

main_160:
    cmp	w19,	#57
    bgt	main_164

main_168:
    movz	w25,	#0

main_169:
    cmp	w19,	#48
    blt	main_182

main_173:
    cmp	w19,	#57
    bgt	main_182

main_175:
    lsl	w20,	w25,	#1
    add	w21,	w20,	w25,	lsl #3
    add	w19,	w19,	w21
    sub	w25,	w19,	#48
    bl	getch
    mov	w19,	w0
    b	main_169

main_182:
    movz	w19,	#0
    sub	w26,	w19,	w25
    cmp	w22,	#0
    csel	w0,	w26,	w25,	ne
    cset	w24,	ne
    bl	find
    mov	w26,	w0
    bl	getch
    movz	w27,	#0
    mov	w23,	w0

main_188:
    cmp	w23,	#48
    blt	main_196

main_192:
    cmp	w23,	#57
    bgt	main_196

main_200:
    movz	w24,	#0

main_201:
    cmp	w23,	#48
    blt	main_214

main_205:
    cmp	w23,	#57
    bgt	main_214

main_207:
    lsl	w21,	w24,	#1
    add	w18,	w21,	w24,	lsl #3
    add	w18,	w23,	w18
    sub	w24,	w18,	#48
    bl	getch
    mov	w23,	w0
    b	main_201

main_214:
    movz	w22,	#0
    sub	w22,	w22,	w24
    cmp	w27,	#0
    cset	w0,	ne
    csel	w0,	w22,	w24,	ne
    bl	find
    adrp	x15, :got:fa
    lsl	w3,	w26,	#2
    ldr	x15, [x15, #:got_lo12:fa]
    add	x13,	x15,	x3
    str	w0,	[x13]

    b	main_220

main_196:
    cmp	w23,	#45
    movz	w24,	#1
    cset	w20,	eq
    csel	w27,	w24,	w27,	eq
    bl	getch
    mov	w23,	w0
    b	main_188

main_164:
    cmp	w19,	#45
    movz	w25,	#1
    cset	w18,	eq
    csel	w22,	w25,	w22,	eq
    bl	getch
    mov	w19,	w0
    b	main_156

main_87:
    bl	getch
    movz	w27,	#0
    mov	w5,	w0

main_89:
    cmp	w5,	#48
    blt	main_97

main_93:
    cmp	w5,	#57
    bgt	main_97

main_101:
    movz	w25,	#0

main_102:
    cmp	w5,	#48
    blt	main_115

main_106:
    cmp	w5,	#57
    bgt	main_115

main_108:
    lsl	w24,	w25,	#1
    add	w26,	w24,	w25,	lsl #3
    add	w18,	w5,	w26
    sub	w25,	w18,	#48
    bl	getch
    mov	w5,	w0
    b	main_102

main_115:
    movz	w24,	#0
    sub	w24,	w24,	w25
    cmp	w27,	#0
    csel	w26,	w24,	w25,	ne
    cset	w22,	ne
    bl	getch
    movz	w27,	#0
    mov	w9,	w0

main_120:
    cmp	w9,	#48
    blt	main_128

main_124:
    cmp	w9,	#57
    bgt	main_128

main_132:
    movz	w21,	#0

main_133:
    cmp	w9,	#48
    blt	main_146

main_137:
    cmp	w9,	#57
    bgt	main_146

main_139:
    lsl	w23,	w21,	#1
    add	w19,	w23,	w21,	lsl #3
    add	w20,	w9,	w19
    sub	w21,	w20,	#48
    bl	getch
    mov	w9,	w0
    b	main_133

main_146:
    movz	w19,	#0
    sub	w20,	w19,	w21
    cmp	w27,	#0
    mov	w0,	w26
    cset	w25,	ne
    csel	w25,	w20,	w21,	ne
    bl	find
    mov	w19,	w0
    mov	w0,	w25
    bl	find
    cmp	w19,	w0
    cset	w0,	eq
    bl	putint
    movz	w0,	#10
    bl	putch

main_220:
    sub	w28,	w28,	#1
    cmp	w28,	#0
    bne	main_73

main_225:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_128:
    cmp	w9,	#45
    movz	w20,	#1
    cset	w24,	eq
    csel	w27,	w20,	w27,	eq
    bl	getch
    mov	w9,	w0
    b	main_120

main_97:
    cmp	w5,	#45
    movz	w21,	#1
    cset	w18,	eq
    csel	w27,	w21,	w27,	eq
    bl	getch
    mov	w5,	w0
    b	main_89

main_41:
    cmp	w18,	#45
    movz	w22,	#1
    cset	w23,	eq
    csel	w20,	w22,	w20,	eq
    bl	getch
    mov	w18,	w0
    b	main_33

main_10:
    cmp	w14,	#45
    movz	w23,	#1
    cset	w19,	eq
    csel	w26,	w23,	w26,	eq
    bl	getch
    mov	w14,	w0
    b	main_2

