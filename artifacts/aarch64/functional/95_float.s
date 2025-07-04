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
    sub	sp, sp, #64
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    movz	w0,	#111
    bl	putch
    movz	w0,	#107
    bl	putch
    movz	w0,	#10
    bl	putch
    add	x18,	sp,	#32
    movi	v11.4s,	#0
    movi	v12.4s,	#0
    add	x28,	sp,	#24
    add	x22,	sp,	#48
    add	x27,	sp,	#20
    fmov	s13,	#2.000000
    movi	v8.4s,	#0
    add	x0,	sp,	#28
    fmov	s14,	#1.000000
    movi	v15.4s,	#0
    add	x23,	sp,	#52
    add	x25,	sp,	#16
    movi	v10.4s,	#0
    movi	v9.4s,	#0
    add	x21,	sp,	#44
    add	x19,	sp,	#36
    add	x20,	sp,	#40
    str	s14,	[x25]

    movi	v14.4s,	#0
    str	s13,	[x27]

    movi	v13.4s,	#0
    str	s12,	[x28]

    str	s11,	[x0]

    mov	x0,	x25
    str	s10,	[x18]

    str	s9,	[x19]

    str	s8,	[x20]

    str	s15,	[x21]

    str	s14,	[x22]

    str	s13,	[x23]

    bl	getfarray
    movz	w21,	#0
    movz	w20,	#1
    mov	w24,	w0

main_13:
    movz	w1,	#51712
    movk	w1,	#15258,	lsl #16
    cmp	w20,	w1
    blt	main_17

main_38:
    mov	w0,	w24
    mov	x1,	x25
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


main_17:
    bl	getfloat
    lsl	w26,	w21,	#2
    fmov	s12,	#2.000000
    fmov	s8,	s0
    movz	w23,	#4059
    frintz	s9,	s8
    fcvtzs	w19,	s8
    movk	w23,	#16457,	lsl #16
    mul	w27,	w19,	w19
    scvtf	s11,	w27
    fmov	s14,	w23
    mov	x23,	x26
    fmul	s15,	s14,	s9
    fmul	s10,	s14,	s8
    add	x23,	sp,	x23
    fmul	s13,	s15,	s9
    fmul	s0,	s10,	s8
    fmul	s9,	s11,	s14
    add	x23,	x23,	#16
    fadd	s14,	s13,	s9
    fdiv	s11,	s14,	s12
    ldr	s14,	[x23]

    fadd	s15,	s14,	s8
    str	s15,	[x23]

    bl	putfloat
    movz	w0,	#32
    bl	putch
    fcvtzs	w0,	s11
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w21,	w21,	#1
    fmov	s21,	#10.000000
    scvtf	s25,	w20
    fmul	s13,	s25,	s21
    fcvtzs	w20,	s13
    b	main_13

