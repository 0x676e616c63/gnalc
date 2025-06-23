.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
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
    blt	main_3

main_37:
    fmov	s13,	w23
    fmov	s8,	w10
    fmov	s23,	#1.000000
    b	main_39

main_3:
    fmov	s13,	w23
    fmov	s8,	w10
    fmov	s23,	#1.000000
    movz	w9,	#0
    movz	w5,	#1

main_5:
    movz	w21,	#52429
    movz	w23,	#13107
    movz	w25,	#52429
    movz	w28,	#55050
    fmov	s20,	#9.500000
    fmov	s19,	#9.500000
    fmov	s18,	#9.500000
    movk	w21,	#16332,	lsl #16
    movk	w23,	#16627,	lsl #16
    movk	w25,	#16604,	lsl #16
    movk	w28,	#15395,	lsl #16
    fmov	s25,	w21
    fmov	s24,	w23
    fmov	s22,	w25
    fsub	s26,	s13,	s25
    fsub	s1,	s8,	s24
    fsub	s22,	s23,	s22
    fmul	s25,	s26,	s20
    fmul	s27,	s1,	s19
    fmul	s21,	s26,	s1
    fmul	s29,	s22,	s18
    fmul	s16,	s21,	s22
    fmov	s21,	w28
    fdiv	s5,	s21,	s16
    fmul	s30,	s29,	s5
    fmul	s10,	s27,	s5
    fmul	s11,	s25,	s5

main_23:
    cmp	w5,	w27
    bge	main_34

main_29:
    fsub	s13,	s13,	s11
    fsub	s8,	s8,	s10
    fsub	s23,	s23,	s30
    add	w5,	w5,	#1
    b	main_23

main_34:
    add	w9,	w9,	#1
    cmp	w9,	w27
    blt	main_5

main_39:
    movz	w21,	#0

main_43:
    cmp	w21,	w27
    bge	main_54

main_49:
    movz	w17,	#4719
    movz	w19,	#42467
    movz	w22,	#20447
    add	w21,	w21,	#1
    movk	w17,	#15491,	lsl #16
    movk	w19,	#15771,	lsl #16
    movk	w22,	#15757,	lsl #16
    fmov	s4,	w17
    fmov	s3,	w19
    fmov	s2,	w22
    fadd	s13,	s13,	s4
    fadd	s8,	s8,	s3
    fadd	s23,	s23,	s2
    b	main_43

main_54:
    fadd	s11,	s13,	s8
    movz	w0,	#43
    fsub	s12,	s11,	s23
    bl	_sysy_stoptime
    fmov	s0,	s12
    bl	putfloat
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


