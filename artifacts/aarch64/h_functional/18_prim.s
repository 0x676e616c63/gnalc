.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global fa
.align	2
fa:
    .zero	4020


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

    cmp	w0,	w4
    beq	find_15

find_5:
    lsl	w0,	w4,	#2
    adrp	x8, :got:fa
    ldr	x8, [x8, #:got_lo12:fa]
    add	x28,	x8,	x0
    ldr	w0,	[x28]

    cmp	w4,	w0
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
    mov	w13,	w0

main_2:
    cmp	w13,	#48
    blt	main_9

main_5:
    cmp	w13,	#57
    bgt	main_9

main_12:
    cmp	w13,	#48
    blt	main_21

main_15:
    cmp	w13,	#57
    bgt	main_21

main_17:
    bl	getch
    mov	w13,	w0
    b	main_12

main_21:
    bl	getch
    movz	w28,	#0
    mov	w16,	w0

main_23:
    cmp	w16,	#48
    blt	main_31

main_27:
    cmp	w16,	#57
    bgt	main_31

main_35:
    movz	w20,	#0

main_36:
    cmp	w16,	#48
    blt	main_49

main_40:
    cmp	w16,	#57
    bgt	main_49

main_42:
    lsl	w27,	w20,	#1
    add	w27,	w27,	w20,	lsl #3
    add	w18,	w16,	w27
    sub	w20,	w18,	#48
    bl	getch
    mov	w16,	w0
    b	main_36

main_49:
    movz	w15,	#0
    sub	w26,	w15,	w20
    cmp	w28,	#0
    movz	w14,	#0
    csel	w28,	w26,	w20,	ne
    cset	w8,	ne
    cmp	w14,	w28
    bge	main_125

main_54:
    movz	w25,	#0

main_56:
    bl	getch
    mov	w20,	w0

main_59:
    cmp	w20,	#48
    blt	main_66

main_62:
    cmp	w20,	#57
    bgt	main_66

main_69:
    cmp	w20,	#48
    blt	main_78

main_72:
    cmp	w20,	#57
    bgt	main_78

main_74:
    bl	getch
    mov	w20,	w0
    b	main_69

main_78:
    bl	getch
    mov	w22,	w0

main_80:
    cmp	w22,	#48
    blt	main_87

main_83:
    cmp	w22,	#57
    bgt	main_87

main_90:
    cmp	w22,	#48
    blt	main_99

main_93:
    cmp	w22,	#57
    bgt	main_99

main_95:
    bl	getch
    mov	w22,	w0
    b	main_90

main_99:
    bl	getch
    mov	w24,	w0

main_101:
    cmp	w24,	#48
    blt	main_108

main_104:
    cmp	w24,	#57
    bgt	main_108

main_111:
    cmp	w24,	#48
    blt	main_120

main_114:
    cmp	w24,	#57
    bgt	main_120

main_116:
    bl	getch
    mov	w24,	w0
    b	main_111

main_120:
    add	w25,	w25,	#1
    cmp	w25,	w28
    blt	main_56

main_125:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_108:
    bl	getch
    mov	w24,	w0
    b	main_101

main_87:
    bl	getch
    mov	w22,	w0
    b	main_80

main_66:
    bl	getch
    mov	w20,	w0
    b	main_59

main_31:
    cmp	w16,	#45
    movz	w25,	#1
    cset	w18,	eq
    csel	w28,	w25,	w28,	eq
    bl	getch
    mov	w16,	w0
    b	main_23

main_9:
    bl	getch
    mov	w13,	w0
    b	main_2

