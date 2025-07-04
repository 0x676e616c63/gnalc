.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global fa
.align	2
fa:
.type fa, %object
    .zero	400020

.data

.text

.globl find
.align 2
.p2align 4,,11
.type find, %function
find:
find_1:
    sub	sp, sp, #48
    stp	x23, x24, [sp, #0]
    stp	x26, x28, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    adrp	x3, :got:fa
    lsl	w24,	w0,	#2
    ldr	x3, [x3, #:got_lo12:fa]
    add	x23,	x3,	x24
    ldr	w26,	[x23]

    cmp	w26,	w0
    beq	find_15

find_5:
    lsl	w0,	w26,	#2
    adrp	x7, :got:fa
    ldr	x7, [x7, #:got_lo12:fa]
    add	x28,	x7,	x0
    ldr	w0,	[x28]

    cmp	w0,	w26
    beq	find_12

find_9:
    bl	find
    mov	w26,	w0
    str	w26,	[x28]


find_12:
    str	w26,	[x23]

    mov	w0,	w26

find_15:
    ldp	x23, x24, [sp, #0]
    ldp	x26, x28, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
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
    movz	w28,	#0

main_15:
    cmp	w14,	#48
    blt	main_28

main_19:
    cmp	w14,	#57
    ble	main_21

main_28:
    movz	w20,	#0
    sub	w19,	w20,	w28
    cmp	w26,	#0
    csel	w25,	w19,	w28,	ne
    cset	w26,	ne
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
    movz	w23,	#0

main_46:
    cmp	w18,	#48
    blt	main_59

main_50:
    cmp	w18,	#57
    ble	main_52

main_59:
    movz	w13,	#0
    sub	w17,	w13,	w23
    cmp	w20,	#0
    movz	w20,	#1
    csel	w27,	w17,	w23,	ne
    cset	w7,	ne

main_63:
    cmp	w20,	w25
    ble	main_66

main_69:
    cmp	w27,	#0
    beq	main_225

main_73:
    bl	getch
    mov	w22,	w0

main_76:
    cmp	w22,	#81
    beq	main_85

main_79:
    cmp	w22,	#85
    bne	main_81

main_85:
    cmp	w22,	#81
    beq	main_87

main_154:
    bl	getch
    movz	w23,	#0
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
    ble	main_175

main_182:
    movz	w21,	#0
    sub	w24,	w21,	w25
    cmp	w23,	#0
    cset	w0,	ne
    csel	w0,	w24,	w25,	ne
    bl	find
    mov	w22,	w0
    bl	getch
    movz	w28,	#0
    mov	w23,	w0

main_188:
    cmp	w23,	#48
    blt	main_196

main_192:
    cmp	w23,	#57
    bgt	main_196

main_200:
    movz	w20,	#0

main_201:
    cmp	w23,	#48
    blt	main_214

main_205:
    cmp	w23,	#57
    ble	main_207

main_214:
    movz	w0,	#0
    sub	w23,	w0,	w20
    cmp	w28,	#0
    csel	w0,	w23,	w20,	ne
    cset	w25,	ne
    bl	find
    adrp	x21, :got:fa
    lsl	w8,	w22,	#2
    ldr	x21, [x21, #:got_lo12:fa]
    add	x19,	x21,	x8
    str	w0,	[x19]

    b	main_220

main_207:
    lsl	w18,	w20,	#1
    add	w24,	w18,	w20,	lsl #3
    add	w25,	w23,	w24
    sub	w20,	w25,	#48
    bl	getch
    mov	w23,	w0
    b	main_201

main_196:
    cmp	w23,	#45
    movz	w20,	#1
    cset	w19,	eq
    csel	w28,	w20,	w28,	eq
    bl	getch
    mov	w23,	w0
    b	main_188

main_175:
    lsl	w18,	w25,	#1
    add	w24,	w18,	w25,	lsl #3
    add	w20,	w19,	w24
    sub	w25,	w20,	#48
    bl	getch
    mov	w19,	w0
    b	main_169

main_164:
    cmp	w19,	#45
    movz	w22,	#1
    cset	w24,	eq
    csel	w23,	w22,	w23,	eq
    bl	getch
    mov	w19,	w0
    b	main_156

main_87:
    bl	getch
    movz	w26,	#0
    mov	w5,	w0

main_89:
    cmp	w5,	#48
    blt	main_97

main_93:
    cmp	w5,	#57
    bgt	main_97

main_101:
    movz	w24,	#0

main_102:
    cmp	w5,	#48
    blt	main_115

main_106:
    cmp	w5,	#57
    ble	main_108

main_115:
    movz	w23,	#0
    sub	w20,	w23,	w24
    cmp	w26,	#0
    csel	w19,	w20,	w24,	ne
    cset	w23,	ne
    bl	getch
    movz	w26,	#0
    mov	w4,	w0

main_120:
    cmp	w4,	#48
    blt	main_128

main_124:
    cmp	w4,	#57
    bgt	main_128

main_132:
    movz	w20,	#0

main_133:
    cmp	w4,	#48
    blt	main_146

main_137:
    cmp	w4,	#57
    ble	main_139

main_146:
    movz	w28,	#0
    sub	w22,	w28,	w20
    cmp	w26,	#0
    mov	w0,	w19
    csel	w26,	w22,	w20,	ne
    cset	w23,	ne
    bl	find
    mov	w25,	w0
    mov	w0,	w26
    bl	find
    cmp	w25,	w0
    cset	w0,	eq
    bl	putint
    movz	w0,	#10
    bl	putch

main_220:
    sub	w27,	w27,	#1
    cmp	w27,	#0
    bne	main_73
    b	main_225

main_139:
    lsl	w21,	w20,	#1
    add	w20,	w21,	w20,	lsl #3
    add	w21,	w4,	w20
    sub	w20,	w21,	#48
    bl	getch
    mov	w4,	w0
    b	main_133

main_128:
    cmp	w4,	#45
    movz	w28,	#1
    cset	w24,	eq
    csel	w26,	w28,	w26,	eq
    bl	getch
    mov	w4,	w0
    b	main_120

main_108:
    lsl	w23,	w24,	#1
    add	w19,	w23,	w24,	lsl #3
    add	w20,	w5,	w19
    sub	w24,	w20,	#48
    bl	getch
    mov	w5,	w0
    b	main_102

main_97:
    cmp	w5,	#45
    movz	w28,	#1
    cset	w23,	eq
    csel	w26,	w28,	w26,	eq
    bl	getch
    mov	w5,	w0
    b	main_89

main_81:
    bl	getch
    mov	w22,	w0
    b	main_76

main_225:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_66:
    lsl	w2,	w20,	#2
    adrp	x19, :got:fa
    ldr	x19, [x19, #:got_lo12:fa]
    add	x17,	x19,	x2
    str	w20,	[x17]

    add	w20,	w20,	#1
    b	main_63

main_52:
    lsl	w24,	w23,	#1
    add	w24,	w24,	w23,	lsl #3
    add	w24,	w18,	w24
    sub	w23,	w24,	#48
    bl	getch
    mov	w18,	w0
    b	main_46

main_41:
    cmp	w18,	#45
    movz	w21,	#1
    cset	w28,	eq
    csel	w20,	w21,	w20,	eq
    bl	getch
    mov	w18,	w0
    b	main_33

main_21:
    lsl	w20,	w28,	#1
    add	w25,	w20,	w28,	lsl #3
    add	w27,	w14,	w25
    sub	w28,	w27,	#48
    bl	getch
    mov	w14,	w0
    b	main_15

main_10:
    cmp	w14,	#45
    movz	w23,	#1
    cset	w19,	eq
    csel	w26,	w23,	w26,	eq
    bl	getch
    mov	w14,	w0
    b	main_2

