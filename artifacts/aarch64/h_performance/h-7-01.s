.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global i_buf
.align	2
i_buf:
.type i_buf, %object
    .zero	40000000

.global o_buf
.align	2
o_buf:
.type o_buf, %object
    .zero	40000000

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
    
    adrp	x0, :got:i_buf
    ldr	x0, [x0, #:got_lo12:i_buf]
    bl	getfarray
    mov	w28,	w0
    movz	w0,	#33
    bl	_sysy_starttime
    movz	w4,	#0
    cmp	w4,	w28
    bge	main_49

main_4:
    movz	w25,	#0

main_6:
    lsl	w15,	w25,	#2
    adrp	x3, :got:o_buf
    lsl	w18,	w25,	#2
    adrp	x6, :got:i_buf
    movi	v30.4s,	#0
    ldr	x3, [x3, #:got_lo12:o_buf]
    ldr	x6, [x6, #:got_lo12:i_buf]
    add	x22,	x3,	x15
    add	x4,	x6,	x18
    ldr	s24,	[x4]

    fcmp	s24,	s30
    bgt	main_12

main_38:
    movi	v16.4s,	#0
    b	main_39

main_12:
    fmov	s3,	#1.000000
    fmov	s2,	#0.500000
    fadd	s27,	s24,	s3
    fmul	s16,	s27,	s2
    fcmp	s24,	s16
    blt	main_16

main_18:
    fsub	s30,	s24,	s16
    b	main_20

main_16:
    fsub	s30,	s16,	s24

main_20:
    movz	w18,	#59135
    movk	w18,	#11995,	lsl #16
    fmov	s23,	w18
    fcmp	s30,	s23
    ble	main_39

main_23:
    fmov	s25,	s24

main_25:
    fdiv	s22,	s24,	s25
    fmov	s21,	#0.500000
    fadd	s17,	s25,	s22
    fmul	s16,	s17,	s21
    fcmp	s25,	s16
    blt	main_31

main_33:
    fsub	s10,	s25,	s16
    b	main_35

main_31:
    fsub	s10,	s16,	s25

main_35:
    fcmp	s10,	s23
    ble	main_39

main_24:
    fmov	s25,	s16
    b	main_25

main_39:
    str	s16,	[x22]

    add	w25,	w25,	#1
    cmp	w25,	w28
    blt	main_6

main_49:
    movz	w0,	#41
    bl	_sysy_stoptime
    mov	w0,	w28
    adrp	x1, :got:o_buf
    ldr	x1, [x1, #:got_lo12:o_buf]
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


