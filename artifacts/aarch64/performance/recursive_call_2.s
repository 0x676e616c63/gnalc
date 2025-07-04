.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global memo.lut.func
.align	2
memo.lut.func:
.type memo.lut.func, %object
    .zero	524288

.data

.text

.globl func
.align 2
.p2align 4,,11
.type func, %function
func:
func_2:
    sub	sp, sp, #96
    stp	x20, x21, [sp, #0]
    stp	x22, x24, [sp, #16]
    stp	x26, x28, [sp, #32]
    stp	fp, lr, [sp, #48]
        stp	q10, q11, [sp, #64]

    movz	x18,	#58809
    fmov	s11,	s0
    movz	x17,	#4587
    movz	x20,	#65535
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
    eor	x22,	x6,	x13
    adrp	x13, :got:memo.lut.func
    and	x9,	x22,	x20
    ldr	x13, [x13, #:got_lo12:memo.lut.func]
    lsl	x10,	x9,	#3
    lsl	x26,	x10,	#0
    add	x20,	x13,	x26
    add	x24,	x20,	#8
    ldr	w5,	[x20]

    cmp	w5,	#0
    beq	func_34

func_23:
    ldr	x10,	[x24]

    cmp	x10,	x22
    beq	func_27

func_34:
    cmp	w0,	#0
    bge	func_37

func_43:
    movi	v0.4s,	#0
    b	func_44

func_37:
    sub	w21,	w0,	#1
    fmov	s0,	s11
    mov	w0,	w21
    bl	func
    mov	w0,	w21
    fadd	s10,	s11,	s0
    fmov	s0,	s10
    bl	func
    fsub	s0,	s10,	s0

func_44:
    movz	w26,	#1
    add	x14,	x20,	#4
    str	w26,	[x20]

    str	x22,	[x24]

    str	s0,	[x14]

    ldp	x20, x21, [sp, #0]
    ldp	x22, x24, [sp, #16]
    ldp	x26, x28, [sp, #32]
    ldp	fp, lr, [sp, #48]
        ldp	q10, q11, [sp, #64]

    add	sp, sp, #96
    ret


func_27:
    add	x16,	x20,	#4
    ldr	s0,	[x16]

    ldp	x20, x21, [sp, #0]
    ldp	x22, x24, [sp, #16]
    ldp	x26, x28, [sp, #32]
    ldp	fp, lr, [sp, #48]
        ldp	q10, q11, [sp, #64]

    add	sp, sp, #96
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w0,	#21
    bl	_sysy_starttime
    bl	getint
    movz	w21,	#8389
    movk	w21,	#16256,	lsl #16
    fmov	s0,	w21
    bl	func
    movi	v5.4s,	#0
    movi	v6.4s,	#0
    fsub	s6,	s0,	s6
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


