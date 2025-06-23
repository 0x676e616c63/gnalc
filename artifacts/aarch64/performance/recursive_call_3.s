.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global memo.lut.func
.align	2
memo.lut.func:
    .zero	524288


.text

.globl func
func:
func_2:
    sub	sp, sp, #96
    stp	x20, x21, [sp, #0]
    stp	x24, x25, [sp, #16]
    stp	x26, x28, [sp, #32]
    stp	fp, lr, [sp, #48]
        stp	q11, q13, [sp, #64]

    movz	x18,	#58809
    movz	x20,	#65535
    fmov	s11,	s0
    movz	x17,	#4587
    movk	x18,	#7396,	lsl #16
    fmov	w3,	s11
    movk	x17,	#4913,	lsl #16
    movk	x18,	#18285,	lsl #32
    lsl	x5,	x3,	#32
    movk	x17,	#18875,	lsl #32
    movk	x18,	#48984,	lsl #48
    movk	x17,	#38096,	lsl #48
    orr	x28,	x0,	x5
    lsr	x7,	x28,	#30
    eor	x2,	x28,	x7
    mul	x3,	x2,	x18
    lsr	x10,	x3,	#27
    eor	x5,	x3,	x10
    mul	x6,	x5,	x17
    lsr	x13,	x6,	#31
    eor	x28,	x6,	x13
    adrp	x13, :got:memo.lut.func
    and	x9,	x28,	x20
    ldr	x13, [x13, #:got_lo12:memo.lut.func]
    lsl	x10,	x9,	#3
    lsl	x25,	x10,	#0
    add	x21,	x13,	x25
    add	x20,	x21,	#8
    ldr	w5,	[x21]

    cmp	w5,	#0
    beq	func_34

func_23:
    ldr	x9,	[x20]

    cmp	x9,	x28
    bne	func_34

func_27:
    add	x7,	x21,	#4
    ldr	s0,	[x7]

    ldp	x20, x21, [sp, #0]
    ldp	x24, x25, [sp, #16]
    ldp	x26, x28, [sp, #32]
    ldp	fp, lr, [sp, #48]
        ldp	q11, q13, [sp, #64]

    add	sp, sp, #96
    ret


func_34:
    cmp	w0,	#0
    blt	func_43

func_37:
    sub	w24,	w0,	#1
    fmov	s0,	s11
    mov	w0,	w24
    bl	func
    mov	w0,	w24
    fadd	s13,	s11,	s0
    fmov	s0,	s13
    bl	func
    fsub	s0,	s13,	s0
    b	func_44

func_43:
    movi	v0.4s,	#0

func_44:
    movz	w26,	#1
    add	x17,	x21,	#4
    str	w26,	[x21]

    str	x28,	[x20]

    str	s0,	[x17]

    ldp	x20, x21, [sp, #0]
    ldp	x24, x25, [sp, #16]
    ldp	x26, x28, [sp, #32]
    ldp	fp, lr, [sp, #48]
        ldp	q11, q13, [sp, #64]

    add	sp, sp, #96
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#21
    bl	_sysy_starttime
    bl	getint
    movz	w21,	#8389
    movk	w21,	#16256,	lsl #16
    fmov	s10,	w21
    fmov	s0,	s10
    bl	func
    movi	v5.4s,	#0
    fsub	s6,	s0,	s10
    fcmp	s6,	s5
    bne	main_7

main_5:
    movz	w0,	#112
    bl	putch

main_7:
    movz	w0,	#32
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


