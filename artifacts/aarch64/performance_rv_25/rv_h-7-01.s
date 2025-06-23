.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global i_buf
.align	2
i_buf:
    .zero	40000000

.global o_buf
.align	2
o_buf:
    .zero	40000000


.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    adrp	x0, :got:i_buf
    ldr	x0, [x0, #:got_lo12:i_buf]
    bl	getfarray
    mov	w27,	w0
    movz	w0,	#31
    bl	_sysy_starttime
    movz	w0,	#0
    cmp	w0,	w27
    bge	main_38

main_4:
    movz	w25,	#0

main_6:
    lsl	w14,	w25,	#2
    adrp	x2, :got:o_buf
    lsl	w17,	w25,	#2
    adrp	x5, :got:i_buf
    movi	v26.4s,	#0
    ldr	x2, [x2, #:got_lo12:o_buf]
    ldr	x5, [x5, #:got_lo12:i_buf]
    add	x10,	x2,	x14
    add	x3,	x5,	x17
    ldr	s8,	[x3]

    fcmp	s8,	s26
    ble	main_30

main_12:
    fmov	s30,	#1.000000
    fmov	s29,	#0.500000
    fadd	s25,	s8,	s30
    fmul	s25,	s25,	s29

main_16:
    fdiv	s28,	s8,	s25
    fmov	s17,	#0.500000
    fadd	s20,	s25,	s28
    fmul	s15,	s20,	s17
    fcmp	s25,	s15
    bge	main_25

main_23:
    fsub	s1,	s15,	s25
    b	main_27

main_25:
    fsub	s1,	s25,	s15

main_27:
    movz	w13,	#59135
    movk	w13,	#11995,	lsl #16
    fmov	s19,	w13
    fcmp	s1,	s19
    ble	main_32

main_15:
    fmov	s25,	s15
    b	main_16

main_30:
    movi	v15.4s,	#0

main_32:
    str	s15,	[x10]

    add	w25,	w25,	#1
    cmp	w25,	w27
    blt	main_6

main_38:
    movz	w0,	#39
    bl	_sysy_stoptime
    mov	w0,	w27
    adrp	x1, :got:o_buf
    ldr	x1, [x1, #:got_lo12:o_buf]
    bl	putfarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


