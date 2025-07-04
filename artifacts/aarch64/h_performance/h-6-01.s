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
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w27,	w0
    movz	w0,	#41
    bl	_sysy_starttime
    movz	w10,	#52429
    movz	w23,	#39322
    movz	w13,	#0
    movk	w10,	#16268,	lsl #16
    movk	w23,	#16537,	lsl #16
    cmp	w13,	w27
    bge	main_37

main_3:
    fmov	s13,	w23
    fmov	s8,	w10
    fmov	s23,	#1.000000
    movz	w0,	#0
    movz	w14,	#1

main_5:
    movz	w20,	#52429
    movz	w22,	#13107
    movz	w24,	#52429
    movz	w26,	#55050
    fmov	s20,	#9.500000
    fmov	s19,	#9.500000
    fmov	s18,	#9.500000
    movk	w20,	#16332,	lsl #16
    movk	w22,	#16627,	lsl #16
    movk	w24,	#16604,	lsl #16
    movk	w26,	#15395,	lsl #16
    fmov	s25,	w20
    fmov	s24,	w22
    fmov	s22,	w24
    fsub	s26,	s13,	s25
    fsub	s1,	s8,	s24
    fsub	s22,	s23,	s22
    fmul	s25,	s26,	s20
    fmul	s27,	s1,	s19
    fmul	s21,	s26,	s1
    fmul	s29,	s22,	s18
    fmul	s16,	s21,	s22
    fmov	s21,	w26
    fdiv	s5,	s21,	s16
    fmul	s30,	s29,	s5
    fmul	s10,	s27,	s5
    fmul	s11,	s25,	s5

main_23:
    cmp	w14,	w27
    blt	main_29

main_34:
    add	w0,	w0,	#1
    cmp	w0,	w27
    blt	main_5
    b	main_39

main_29:
    fsub	s13,	s13,	s11
    fsub	s8,	s8,	s10
    fsub	s23,	s23,	s30
    add	w14,	w14,	#1
    b	main_23

main_37:
    fmov	s13,	w23
    fmov	s8,	w10
    fmov	s23,	#1.000000

main_39:
    movz	w21,	#0

main_43:
    cmp	w21,	w27
    blt	main_49

main_54:
    fadd	s15,	s13,	s8
    movz	w0,	#43
    fsub	s8,	s15,	s23
    bl	_sysy_stoptime
    fmov	s0,	s8
    bl	putfloat
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_49:
    movz	w19,	#4719
    movz	w22,	#42467
    movz	w24,	#20447
    add	w21,	w21,	#1
    movk	w19,	#15491,	lsl #16
    movk	w22,	#15771,	lsl #16
    movk	w24,	#15757,	lsl #16
    fmov	s6,	w19
    fmov	s5,	w22
    fmov	s4,	w24
    fadd	s13,	s13,	s6
    fadd	s8,	s8,	s5
    fadd	s23,	s23,	s4
    b	main_43

