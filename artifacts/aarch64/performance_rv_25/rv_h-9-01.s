.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global memo.lut.fib
.align	2
memo.lut.fib:
    .zero	1310720


.text

.globl fib
fib:
fib_3:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w27,	w0
    movz	x11,	#3
    movz	x10,	#31161
    mov	w28,	w1
    mov	w21,	w2
    adrp	x5, :got:memo.lut.fib
    movz	x12,	#31353
    movz	x9,	#31161
    movz	x23,	#65535
    movk	x10,	#40503,	lsl #16
    ldr	x5, [x5, #:got_lo12:memo.lut.fib]
    movk	x12,	#40503,	lsl #16
    movk	x9,	#40503,	lsl #16
    add	x17,	x27,	x12
    eor	x14,	x17,	x11
    lsr	x20,	x14,	#2
    lsl	x12,	x14,	#6
    add	x17,	x20,	x10
    add	x18,	x17,	x12
    add	x19,	x18,	x28
    eor	x22,	x14,	x19
    lsr	x0,	x22,	#2
    lsl	x19,	x22,	#6
    add	x24,	x0,	x9
    add	x25,	x24,	x19
    add	x26,	x25,	x21
    eor	x4,	x22,	x26
    and	x6,	x4,	x23
    lsl	w1,	w6,	#2
    add	w2,	w1,	w6,	lsl #4
    lsl	x9,	x2,	#0
    add	x23,	x5,	x9
    add	x20,	x23,	#8
    ldr	w15,	[x23]

    cmp	w15,	#0
    beq	fib_46

fib_28:
    ldr	w19,	[x20]

    cmp	w19,	w27
    add	x24,	x20,	#4
    cset	w11,	eq
    ldr	w14,	[x24]

    cmp	w14,	w28
    add	x26,	x24,	#4
    cset	w15,	eq
    and	w1,	w15,	w11
    ldr	w4,	[x26]

    cmp	w4,	w21
    cset	w5,	eq
    and	w6,	w1,	w5
    cbnz	w6,	fib_42
    b	fib_53

fib_42:
    add	x24,	x23,	#4
    ldr	w0,	[x24]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


fib_46:
    add	x24,	x20,	#4
    add	x26,	x24,	#4

fib_53:
    cmp	w28,	#0
    beq	fib_62

fib_58:
    cmp	w28,	#1
    beq	fib_62

fib_68:
    add	w0,	w27,	#1
    sub	w1,	w28,	#1
    add	w22,	w21,	#1
    asr	w2,	w22,	#31
    lsr	w18,	w2,	#31
    add	w19,	w22,	w18
    asr	w2,	w19,	#1
    bl	fib
    mov	w19,	w0
    sub	w2,	w27,	#2
    sub	w1,	w28,	#2
    asr	w18,	w2,	#31
    lsr	w22,	w18,	#31
    sub	w18,	w21,	#3
    add	w25,	w2,	w22
    asr	w2,	w18,	#31
    asr	w0,	w25,	#1
    lsr	w22,	w2,	#31
    add	w25,	w18,	w22
    asr	w2,	w25,	#1
    lsl	w22,	w2,	#1
    sub	w2,	w18,	w22
    bl	fib
    add	w0,	w0,	w19
    b	fib_81

fib_62:
    add	w9,	w27,	#1
    lsl	w4,	w21,	#1
    movz	w17,	#3
    asr	w11,	w9,	#31
    sdiv	w10,	w4,	w17
    lsl	w14,	w10,	#0
    lsr	w12,	w11,	#31
    add	w14,	w14,	w10,	lsl #1
    add	w13,	w9,	w12
    sub	w10,	w4,	w14
    asr	w7,	w13,	#1
    add	w0,	w10,	w7

fib_81:
    movz	w8,	#1
    add	x16,	x23,	#4
    str	w8,	[x23]

    str	w27,	[x20]

    str	w28,	[x24]

    str	w21,	[x26]

    str	w0,	[x16]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #96
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w27,	w0
    movz	w0,	#24
    bl	_sysy_starttime
    movz	w5,	#0
    cmp	w5,	w28
    bge	main_42

main_4:
    movz	w25,	#0
    movz	w23,	#0

main_6:
    asr	w20,	w23,	#31
    movz	w18,	#57607
    movz	w26,	#57186
    movk	w18,	#1525,	lsl #16
    lsr	w21,	w20,	#31
    movk	w26,	#304,	lsl #16
    add	w22,	w23,	w21
    asr	w7,	w22,	#1
    lsl	w8,	w7,	#1
    sub	w13,	w23,	w8
    cmp	w13,	#0
    beq	main_12

main_23:
    mul	w22,	w27,	w26
    movz	w1,	#23333
    madd	w27,	w27,	w26,	w1

    sdiv	w22,	w27,	w18
    mul	w0,	w22,	w18
    msub	w0,	w22,	w18,	w27

    add	w27,	w0,	w18
    cmp	w0,	#0
    mov	w2,	w23
    mov	w1,	w23
    csel	w27,	w27,	w0,	lt
    cset	w21,	lt
    movz	w0,	#55529
    movk	w0,	#65535,	lsl #16
    sdiv	w21,	w27,	w0
    mul	w19,	w21,	w0
    msub	w0,	w21,	w0,	w27

    bl	fib
    asr	w10,	w0,	#31
    lsr	w11,	w10,	#24
    add	w12,	w0,	w11
    asr	w19,	w12,	#8
    lsl	w20,	w19,	#8
    sub	w26,	w0,	w20
    add	w3,	w26,	w25
    b	main_34

main_12:
    mul	w0,	w27,	w26
    movz	w21,	#23333
    madd	w1,	w27,	w26,	w21

    sdiv	w20,	w1,	w18
    msub	w2,	w20,	w18,	w1

    mul	w26,	w20,	w18
    add	w27,	w2,	w18
    cmp	w2,	#0
    mov	w1,	w23
    csel	w27,	w27,	w2,	lt
    cset	w20,	lt
    mov	w2,	w25
    movz	w20,	#10007
    sdiv	w0,	w27,	w20
    bl	fib
    asr	w13,	w0,	#31
    lsr	w14,	w13,	#24
    add	w15,	w0,	w14
    asr	w4,	w15,	#8
    lsl	w5,	w4,	#8
    sub	w9,	w0,	w5
    sub	w3,	w25,	w9

main_34:
    asr	w0,	w3,	#31
    lsr	w18,	w0,	#24
    add	w19,	w3,	w18
    asr	w0,	w19,	#8
    lsl	w18,	w0,	#8
    sub	w25,	w3,	w18
    mov	w0,	w25
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w23,	#1
    cmp	w23,	w28
    blt	main_6

main_42:
    movz	w0,	#36
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


