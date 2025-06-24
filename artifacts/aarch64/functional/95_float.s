.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
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
    movi	v15.4s,	#0
    movi	v12.4s,	#0
    add	x0,	sp,	#28
    movi	v10.4s,	#0
    add	x28,	sp,	#24
    fmov	s13,	#2.000000
    movi	v8.4s,	#0
    movi	v11.4s,	#0
    add	x27,	sp,	#20
    fmov	s14,	#1.000000
    add	x23,	sp,	#48
    add	x24,	sp,	#52
    add	x19,	sp,	#36
    add	x22,	sp,	#16
    add	x20,	sp,	#40
    movi	v9.4s,	#0
    add	x21,	sp,	#44
    str	s14,	[x22]

    movi	v14.4s,	#0
    str	s13,	[x27]

    movi	v13.4s,	#0
    str	s12,	[x28]

    str	s11,	[x0]

    mov	x0,	x22
    str	s10,	[x18]

    str	s9,	[x19]

    str	s8,	[x20]

    str	s15,	[x21]

    str	s14,	[x23]

    str	s13,	[x24]

    bl	getfarray
    movz	w27,	#0
    movz	w20,	#1
    mov	w23,	w0

main_13:
    movz	w1,	#51712
    movk	w1,	#15258,	lsl #16
    cmp	w20,	w1
    bge	main_38

main_17:
    bl	getfloat
    fmov	s8,	s0
    movz	w21,	#4059
    lsl	w25,	w27,	#2
    frintz	s9,	s8
    fcvtzs	w19,	s8
    movk	w21,	#16457,	lsl #16
    mov	x24,	x25
    mul	w26,	w19,	w19
    fmov	s13,	w21
    add	x24,	sp,	x24
    scvtf	s11,	w26
    fmul	s15,	s13,	s9
    fmul	s10,	s13,	s8
    fmul	s14,	s15,	s9
    add	x24,	x24,	#16
    fmul	s0,	s10,	s8
    fmul	s9,	s11,	s13
    fmov	s11,	#2.000000
    fadd	s14,	s14,	s9
    fdiv	s11,	s14,	s11
    ldr	s14,	[x24]

    fadd	s15,	s14,	s8
    str	s15,	[x24]

    bl	putfloat
    movz	w0,	#32
    bl	putch
    fcvtzs	w0,	s11
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w27,	w27,	#1
    fmov	s20,	#10.000000
    scvtf	s25,	w20
    fmul	s13,	s25,	s20
    fcvtzs	w20,	s13
    b	main_13

main_38:
    mov	w0,	w23
    mov	x1,	x22
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #64
    ret


