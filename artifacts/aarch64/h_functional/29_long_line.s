.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global memo.lut.fib
.align	2
memo.lut.fib:
    .zero	524288


.text

.globl fib
fib:
fib_1:
    sub	sp, sp, #1136
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	x26,	#65535
    movz	x7,	#40763
    movz	x5,	#40763
    mov	w28,	w0
    movz	fp,	#508
    adrp	x12, :got:memo.lut.fib
    movk	x7,	#1117,	lsl #16
    movk	x5,	#1117,	lsl #16
    lsr	w9,	w28,	#16
    eor	w1,	w28,	w9
    mul	w2,	w1,	w7
    lsr	w13,	w2,	#16
    eor	w4,	w2,	w13
    mul	w5,	w4,	w5
    lsr	w16,	w5,	#16
    eor	w17,	w5,	w16
    str	w17,	[sp, #336]

    ldr	w17,	[sp, #336]

    ldr	x12, [x12, #:got_lo12:memo.lut.fib]
    and	w17,	w17,	w26
    lsl	w18,	w17,	#3
    lsl	w20,	w18,	#0
    add	x11,	x12,	x20
    str	x11,	[sp, #328]

    ldr	x12,	[sp, #328]

    mov	x7,	x12
    str	x7,	[sp, fp]

    movz	fp,	#508
    ldr	x8,	[sp, fp]

    ldr	w16,	[x8]

    ldr	x12,	[sp, #328]

    add	x3,	x12,	#8
    cmp	w16,	#0
    beq	fib_25

fib_17:
    ldr	w20,	[x3]

    ldr	w1,	[sp, #336]

    cmp	w20,	w1
    bne	fib_27

fib_21:
    ldr	x14,	[sp, #328]

    add	x1,	x14,	#4
    ldr	w0,	[x1]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1136
    ret


fib_27:
    movz	fp,	#500
    str	x3,	[sp, fp]

    b	fib_28

fib_25:
    mov	x4,	x3
    movz	fp,	#500
    str	x4,	[sp, fp]


fib_28:
    cmp	w28,	#2
    ble	fib_1891

fib_31:
    asr	w22,	w28,	#31
    lsr	w0,	w22,	#31
    add	w24,	w28,	w0
    asr	w21,	w24,	#1
    lsl	w22,	w21,	#1
    sub	w20,	w28,	w22
    str	w20,	[sp, #476]

    movz	w20,	#0
    ldr	w22,	[sp, #476]

    sub	w22,	w20,	w22
    str	w22,	[sp, #400]

    ldr	w22,	[sp, #476]

    cmp	w22,	#0
    asr	w25,	w28,	#31
    ldr	w26,	[sp, #400]

    ldr	w0,	[sp, #476]

    csel	w20,	w26,	w0,	lt
    str	w20,	[sp, #812]

    lsr	w26,	w25,	#31
    add	w28,	w28,	w26
    movz	w26,	#0
    asr	w20,	w28,	#1
    asr	w0,	w20,	#31
    lsr	w19,	w0,	#31
    add	w21,	w20,	w19
    asr	w0,	w21,	#1
    lsl	w19,	w0,	#1
    sub	w0,	w20,	w19
    str	w0,	[sp, #484]

    ldr	w27,	[sp, #484]

    sub	w21,	w26,	w27
    str	w21,	[sp, #416]

    ldr	w26,	[sp, #484]

    cmp	w26,	#0
    ldr	w26,	[sp, #416]

    asr	w22,	w20,	#31
    ldr	w27,	[sp, #484]

    lsr	w23,	w22,	#31
    csel	w19,	w26,	w27,	lt
    str	w19,	[sp, #264]

    add	w0,	w20,	w23
    asr	w18,	w0,	#1
    movz	w0,	#0
    asr	w25,	w18,	#31
    lsr	w26,	w25,	#31
    add	w27,	w18,	w26
    asr	w25,	w27,	#1
    lsl	w26,	w25,	#1
    sub	w19,	w18,	w26
    str	w19,	[sp, #488]

    ldr	w25,	[sp, #488]

    sub	w19,	w0,	w25
    str	w19,	[sp, #432]

    ldr	w21,	[sp, #488]

    cmp	w21,	#0
    ldr	w27,	[sp, #432]

    ldr	w23,	[sp, #488]

    csel	w28,	w27,	w23,	lt
    str	w28,	[sp, #816]

    asr	w28,	w18,	#31
    lsr	w0,	w28,	#31
    add	w18,	w18,	w0
    asr	w23,	w18,	#1
    asr	w19,	w23,	#31
    lsr	w20,	w19,	#31
    add	w21,	w23,	w20
    movz	w20,	#0
    asr	w21,	w21,	#1
    lsl	w22,	w21,	#1
    sub	w27,	w23,	w22
    str	w27,	[sp, #496]

    ldr	w18,	[sp, #496]

    sub	w0,	w20,	w18
    str	w0,	[sp, #444]

    ldr	w27,	[sp, #496]

    cmp	w27,	#0
    ldr	w26,	[sp, #444]

    ldr	w28,	[sp, #496]

    csel	w27,	w26,	w28,	lt
    str	w27,	[sp, #284]

    asr	w26,	w23,	#31
    lsr	w27,	w26,	#31
    add	w18,	w23,	w27
    asr	w22,	w18,	#1
    asr	w27,	w22,	#31
    lsr	w18,	w27,	#31
    movz	w27,	#0
    add	w19,	w22,	w18
    mov	w26,	w27
    asr	w20,	w19,	#1
    lsl	w21,	w20,	#1
    sub	w21,	w22,	w21
    str	w21,	[sp, #492]

    ldr	w28,	[sp, #492]

    sub	w23,	w26,	w28
    str	w23,	[sp, #456]

    ldr	w25,	[sp, #492]

    cmp	w25,	#0
    asr	w18,	w22,	#31
    ldr	w21,	[sp, #456]

    ldr	w26,	[sp, #492]

    lsr	w19,	w18,	#31
    csel	w23,	w21,	w26,	lt
    str	w23,	[sp, #824]

    add	w20,	w22,	w19
    movz	w19,	#0
    mov	w18,	w19
    asr	w20,	w20,	#1
    asr	w21,	w20,	#31
    lsr	w22,	w21,	#31
    add	w23,	w20,	w22
    asr	w21,	w23,	#1
    lsl	w22,	w21,	#1
    sub	w22,	w20,	w22
    str	w22,	[sp, #480]

    ldr	w28,	[sp, #480]

    sub	w28,	w18,	w28
    str	w28,	[sp, #468]

    ldr	w26,	[sp, #480]

    cmp	w26,	#0
    asr	w26,	w20,	#31
    ldr	w18,	[sp, #468]

    ldr	w27,	[sp, #480]

    csel	w28,	w18,	w27,	lt
    lsr	w27,	w26,	#31
    str	w28,	[sp, #840]

    add	w18,	w20,	w27
    asr	w18,	w18,	#1
    asr	w27,	w18,	#31
    lsr	w19,	w27,	#31
    add	w20,	w18,	w19
    asr	w27,	w20,	#1
    lsl	w19,	w27,	#1
    sub	w20,	w18,	w19
    str	w20,	[sp, #472]

    ldr	w22,	[sp, #472]

    movz	w20,	#0
    sub	w28,	w20,	w22
    str	w28,	[sp, #460]

    ldr	w22,	[sp, #472]

    cmp	w22,	#0
    asr	w26,	w18,	#31
    ldr	w19,	[sp, #460]

    ldr	w23,	[sp, #472]

    lsr	w27,	w26,	#31
    csel	w20,	w19,	w23,	lt
    str	w20,	[sp, #844]

    add	w18,	w18,	w27
    asr	w27,	w18,	#1
    str	w27,	[sp, #828]

    ldr	w28,	[sp, #828]

    ldr	w0,	[sp, #828]

    asr	w27,	w28,	#31
    ldr	w18,	[sp, #828]

    lsr	w20,	w27,	#31
    add	w21,	w0,	w20
    asr	w27,	w21,	#1
    lsl	w19,	w27,	#1
    sub	w21,	w18,	w19
    str	w21,	[sp, #464]

    ldr	w19,	[sp, #464]

    movz	w21,	#0
    mov	w26,	w21
    sub	w27,	w26,	w19
    str	w27,	[sp, #448]

    ldr	w23,	[sp, #464]

    cmp	w23,	#0
    ldr	w18,	[sp, #448]

    ldr	w23,	[sp, #464]

    csel	w20,	w18,	w23,	lt
    str	w20,	[sp, #864]

    ldr	w19,	[sp, #828]

    ldr	w20,	[sp, #828]

    asr	w22,	w19,	#31
    lsr	w18,	w22,	#31
    movz	w22,	#0
    add	w27,	w20,	w18
    asr	w25,	w27,	#1
    asr	w18,	w25,	#31
    lsr	w27,	w18,	#31
    add	w20,	w25,	w27
    asr	w20,	w20,	#1
    lsl	w21,	w20,	#1
    sub	w27,	w25,	w21
    str	w27,	[sp, #452]

    mov	w27,	w22
    ldr	w26,	[sp, #452]

    sub	w18,	w27,	w26
    str	w18,	[sp, #436]

    ldr	w19,	[sp, #452]

    cmp	w19,	#0
    ldr	w18,	[sp, #436]

    asr	w21,	w25,	#31
    ldr	w19,	[sp, #452]

    lsr	w22,	w21,	#31
    csel	w24,	w18,	w19,	lt
    str	w24,	[sp, #868]

    add	w26,	w25,	w22
    asr	w20,	w26,	#1
    asr	w18,	w20,	#31
    lsr	w23,	w18,	#31
    add	w26,	w20,	w23
    asr	w26,	w26,	#1
    lsl	w18,	w26,	#1
    movz	w26,	#0
    sub	w22,	w20,	w18
    str	w22,	[sp, #440]

    mov	w22,	w26
    ldr	w25,	[sp, #440]

    sub	w27,	w22,	w25
    str	w27,	[sp, #424]

    ldr	w26,	[sp, #440]

    cmp	w26,	#0
    movz	w27,	#0
    asr	w18,	w20,	#31
    ldr	w28,	[sp, #424]

    lsr	w19,	w18,	#31
    ldr	w21,	[sp, #440]

    csel	w28,	w28,	w21,	lt
    add	w22,	w20,	w19
    str	w28,	[sp, #872]

    asr	w19,	w22,	#1
    asr	w18,	w19,	#31
    lsr	w23,	w18,	#31
    add	w25,	w19,	w23
    asr	w20,	w25,	#1
    lsl	w18,	w20,	#1
    sub	w18,	w19,	w18
    str	w18,	[sp, #428]

    mov	w18,	w27
    ldr	w27,	[sp, #428]

    sub	w21,	w18,	w27
    str	w21,	[sp, #412]

    ldr	w20,	[sp, #428]

    cmp	w20,	#0
    ldr	w22,	[sp, #412]

    ldr	w20,	[sp, #428]

    csel	w18,	w22,	w20,	lt
    str	w18,	[sp, #568]

    asr	w18,	w19,	#31
    lsr	w20,	w18,	#31
    add	w21,	w19,	w20
    asr	w23,	w21,	#1
    asr	w18,	w23,	#31
    lsr	w22,	w18,	#31
    add	w25,	w23,	w22
    asr	w18,	w25,	#1
    lsl	w22,	w18,	#1
    sub	w18,	w23,	w22
    str	w18,	[sp, #420]

    movz	w18,	#0
    ldr	w25,	[sp, #420]

    mov	w21,	w18
    sub	w20,	w21,	w25
    str	w20,	[sp, #404]

    ldr	w19,	[sp, #420]

    cmp	w19,	#0
    ldr	w21,	[sp, #404]

    asr	w26,	w23,	#31
    ldr	w28,	[sp, #420]

    csel	w19,	w21,	w28,	lt
    str	w19,	[sp, #616]

    lsr	w19,	w26,	#31
    add	w20,	w23,	w19
    asr	w25,	w20,	#1
    asr	w18,	w25,	#31
    lsr	w22,	w18,	#31
    add	w23,	w25,	w22
    asr	w23,	w23,	#1
    lsl	w18,	w23,	#1
    sub	w27,	w25,	w18
    str	w27,	[sp, #408]

    movz	w27,	#0
    ldr	w20,	[sp, #408]

    sub	w19,	w27,	w20
    str	w19,	[sp, #392]

    ldr	w18,	[sp, #408]

    cmp	w18,	#0
    movz	w20,	#0
    ldr	w18,	[sp, #392]

    ldr	w21,	[sp, #408]

    csel	w22,	w18,	w21,	lt
    asr	w18,	w25,	#31
    str	w22,	[sp, #632]

    lsr	w19,	w18,	#31
    add	w27,	w25,	w19
    asr	w19,	w27,	#1
    asr	w18,	w19,	#31
    lsr	w23,	w18,	#31
    add	w25,	w19,	w23
    asr	w18,	w25,	#1
    lsl	w18,	w18,	#1
    sub	w21,	w19,	w18
    str	w21,	[sp, #396]

    ldr	w25,	[sp, #396]

    sub	w18,	w20,	w25
    str	w18,	[sp, #384]

    ldr	w23,	[sp, #396]

    cmp	w23,	#0
    ldr	w18,	[sp, #384]

    asr	w26,	w19,	#31
    ldr	w28,	[sp, #396]

    csel	w28,	w18,	w28,	lt
    str	w28,	[sp, #660]

    lsr	w18,	w26,	#31
    add	w18,	w19,	w18
    asr	w18,	w18,	#1
    asr	w19,	w18,	#31
    lsr	w23,	w19,	#31
    add	w25,	w18,	w23
    asr	w19,	w25,	#1
    lsl	w23,	w19,	#1
    sub	w21,	w18,	w23
    str	w21,	[sp, #388]

    ldr	w22,	[sp, #388]

    movz	w21,	#0
    mov	w26,	w21
    sub	w20,	w26,	w22
    str	w20,	[sp, #376]

    ldr	w23,	[sp, #388]

    cmp	w23,	#0
    movz	w22,	#0
    ldr	w19,	[sp, #376]

    ldr	w27,	[sp, #388]

    csel	w21,	w19,	w27,	lt
    asr	w19,	w18,	#31
    str	w21,	[sp, #680]

    lsr	w20,	w19,	#31
    add	w27,	w18,	w20
    asr	w19,	w27,	#1
    asr	w18,	w19,	#31
    lsr	w27,	w18,	#31
    add	w20,	w19,	w27
    mov	w27,	w22
    asr	w20,	w20,	#1
    lsl	w21,	w20,	#1
    sub	w21,	w19,	w21
    str	w21,	[sp, #380]

    ldr	w22,	[sp, #380]

    sub	w26,	w27,	w22
    str	w26,	[sp, #692]

    ldr	w23,	[sp, #380]

    cmp	w23,	#0
    ldr	w27,	[sp, #692]

    ldr	w23,	[sp, #380]

    csel	w20,	w27,	w23,	lt
    str	w20,	[sp, #676]

    ldr	w25,	[sp, #812]

    cmp	w25,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w18,	#0
    cset	w27,	eq
    mov	w20,	w27
    cmp	w20,	#0
    cset	w21,	ne
    mov	w22,	w21
    cmp	w22,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w27,	#0
    cset	w18,	ne
    str	w18,	[sp, #684]

    ldr	w26,	[sp, #812]

    cmp	w26,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w22,	ne
    ldr	w24,	[sp, #264]

    cmp	w24,	#0
    cset	w19,	ne
    mov	w18,	w19
    cmp	w18,	#0
    cset	w18,	eq
    mov	w23,	w18
    cmp	w23,	#0
    cset	w23,	ne
    mov	w27,	w23
    str	w27,	[sp, #104]

    cmp	w22,	#0
    ldr	w23,	[sp, #104]

    cset	w18,	ne
    mov	w19,	w18
    cmp	w23,	#0
    movz	w28,	#1
    csel	w19,	w28,	w19,	ne
    cmp	w22,	#0
    cset	w23,	ne
    mov	w21,	w23
    str	w21,	[sp, #96]

    ldr	w18,	[sp, #104]

    cmp	w18,	#0
    ldr	w27,	[sp, #96]

    movz	w18,	#0
    mov	w25,	w18
    csel	w18,	w27,	w25,	ne
    cmp	w18,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w19,	#0
    movz	w18,	#0
    mov	w20,	w18
    csel	w23,	w25,	w20,	ne
    str	w23,	[sp, #668]

    ldr	w25,	[sp, #264]

    cmp	w25,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w22,	#0
    ldr	w19,	[sp, #104]

    cset	w21,	ne
    mov	w27,	w21
    cmp	w19,	#0
    movz	w25,	#0
    mov	w20,	w25
    csel	w26,	w27,	w20,	ne
    cmp	w26,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w18,	#0
    movz	w21,	#1
    csel	w20,	w21,	w23,	ne
    str	w20,	[sp, #564]

    ldr	w0,	[sp, #816]

    cmp	w0,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w18,	#0
    cset	w19,	eq
    mov	w20,	w19
    cmp	w20,	#0
    cset	w23,	ne
    str	w23,	[sp, #268]

    ldr	w21,	[sp, #564]

    cmp	w21,	#0
    cset	w18,	ne
    ldr	w28,	[sp, #268]

    mov	w25,	w18
    cmp	w28,	#0
    movz	w26,	#1
    ldr	w22,	[sp, #564]

    mov	w21,	w26
    csel	w28,	w21,	w25,	ne
    cmp	w22,	#0
    ldr	w0,	[sp, #268]

    cset	w20,	ne
    mov	w19,	w20
    cmp	w0,	#0
    movz	w23,	#0
    mov	w21,	w23
    csel	w18,	w19,	w21,	ne
    cmp	w18,	#0
    cset	w25,	eq
    mov	w18,	w25
    cmp	w18,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w28,	#0
    movz	w23,	#0
    mov	w18,	w23
    csel	w27,	w20,	w18,	ne
    str	w27,	[sp, #644]

    ldr	w18,	[sp, #816]

    cmp	w18,	#0
    ldr	w23,	[sp, #564]

    cset	w18,	ne
    mov	w26,	w18
    cmp	w23,	#0
    cset	w20,	ne
    ldr	w19,	[sp, #268]

    mov	w18,	w20
    cmp	w19,	#0
    movz	w24,	#0
    csel	w27,	w18,	w24,	ne
    cmp	w27,	#0
    cset	w24,	ne
    mov	w18,	w24
    cmp	w26,	#0
    movz	w22,	#1
    mov	w26,	w22
    csel	w28,	w26,	w18,	ne
    str	w28,	[sp, #272]

    ldr	w28,	[sp, #284]

    cmp	w28,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w20,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    cset	w18,	ne
    mov	w21,	w18
    str	w21,	[sp, #276]

    ldr	w0,	[sp, #272]

    cmp	w0,	#0
    ldr	w27,	[sp, #276]

    cset	w18,	ne
    mov	w24,	w18
    cmp	w27,	#0
    movz	w27,	#1
    ldr	w18,	[sp, #272]

    mov	w21,	w27
    csel	w25,	w21,	w24,	ne
    cmp	w18,	#0
    cset	w24,	ne
    ldr	w28,	[sp, #276]

    mov	w18,	w24
    cmp	w28,	#0
    movz	w26,	#0
    mov	w22,	w26
    csel	w18,	w18,	w22,	ne
    cmp	w18,	#0
    cset	w19,	eq
    mov	w20,	w19
    cmp	w20,	#0
    cset	w23,	ne
    mov	w21,	w23
    cmp	w25,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w26,	w21,	w18,	ne
    str	w26,	[sp, #608]

    ldr	w0,	[sp, #284]

    cmp	w0,	#0
    ldr	w24,	[sp, #272]

    cset	w27,	ne
    mov	w22,	w27
    cmp	w24,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #276]

    mov	w18,	w0
    cmp	w19,	#0
    movz	w0,	#0
    mov	w23,	w0
    csel	w24,	w18,	w23,	ne
    cmp	w24,	#0
    cset	w23,	ne
    mov	w27,	w23
    cmp	w22,	#0
    movz	w24,	#1
    mov	w23,	w24
    csel	w20,	w23,	w27,	ne
    str	w20,	[sp, #252]

    ldr	w24,	[sp, #824]

    cmp	w24,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w27,	ne
    mov	w28,	w27
    str	w28,	[sp, #196]

    ldr	w21,	[sp, #252]

    cmp	w21,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #196]

    mov	w20,	w0
    cmp	w18,	#0
    movz	w0,	#1
    ldr	w22,	[sp, #252]

    mov	w19,	w0
    csel	w26,	w19,	w20,	ne
    cmp	w22,	#0
    ldr	w19,	[sp, #196]

    cset	w23,	ne
    mov	w27,	w23
    cmp	w19,	#0
    movz	w19,	#0
    csel	w0,	w27,	w19,	ne
    cmp	w0,	#0
    cset	w20,	eq
    mov	w21,	w20
    cmp	w21,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w26,	#0
    movz	w22,	#0
    mov	w18,	w22
    csel	w25,	w23,	w18,	ne
    str	w25,	[sp, #596]

    ldr	w25,	[sp, #824]

    cmp	w25,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #252]

    mov	w27,	w0
    cmp	w25,	#0
    ldr	w26,	[sp, #196]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w26,	#0
    movz	w24,	#0
    mov	w18,	w24
    csel	w23,	w0,	w18,	ne
    cmp	w23,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w27,	#0
    movz	w18,	#1
    csel	w24,	w18,	w0,	ne
    str	w24,	[sp, #848]

    ldr	w0,	[sp, #840]

    cmp	w0,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	ne
    mov	w27,	w0
    str	w27,	[sp, #208]

    ldr	w25,	[sp, #848]

    cmp	w25,	#0
    cset	w21,	ne
    ldr	w19,	[sp, #208]

    mov	w0,	w21
    cmp	w19,	#0
    ldr	w26,	[sp, #848]

    movz	w18,	#1
    mov	w24,	w18
    csel	w24,	w24,	w0,	ne
    cmp	w26,	#0
    cset	w28,	ne
    ldr	w20,	[sp, #208]

    mov	w0,	w28
    cmp	w20,	#0
    movz	w18,	#0
    mov	w23,	w18
    csel	w22,	w0,	w23,	ne
    cmp	w22,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w24,	#0
    movz	w19,	#0
    csel	w28,	w28,	w19,	ne
    str	w28,	[sp, #548]

    ldr	w18,	[sp, #840]

    cmp	w18,	#0
    cset	w21,	ne
    ldr	w27,	[sp, #848]

    mov	w0,	w21
    cmp	w27,	#0
    cset	w19,	ne
    ldr	w28,	[sp, #208]

    mov	w20,	w19
    cmp	w28,	#0
    movz	w21,	#0
    mov	w27,	w21
    csel	w24,	w20,	w27,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w0,	#0
    movz	w24,	#1
    mov	w25,	w24
    csel	w0,	w25,	w18,	ne
    str	w0,	[sp, #852]

    ldr	w21,	[sp, #844]

    cmp	w21,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	eq
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	ne
    mov	w20,	w21
    str	w20,	[sp, #212]

    ldr	w18,	[sp, #852]

    cmp	w18,	#0
    cset	w23,	ne
    mov	w27,	w23
    ldr	w23,	[sp, #212]

    cmp	w23,	#0
    ldr	w19,	[sp, #852]

    movz	w0,	#1
    csel	w18,	w0,	w27,	ne
    cmp	w19,	#0
    ldr	w25,	[sp, #212]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w25,	#0
    movz	w25,	#0
    mov	w23,	w25
    csel	w23,	w21,	w23,	ne
    cmp	w23,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w18,	#0
    movz	w0,	#0
    mov	w19,	w0
    csel	w22,	w20,	w19,	ne
    str	w22,	[sp, #832]

    ldr	w22,	[sp, #844]

    cmp	w22,	#0
    cset	w23,	ne
    ldr	w20,	[sp, #852]

    mov	w27,	w23
    cmp	w20,	#0
    cset	w18,	ne
    ldr	w22,	[sp, #212]

    mov	w19,	w18
    cmp	w22,	#0
    movz	w26,	#0
    mov	w0,	w26
    csel	w23,	w19,	w0,	ne
    cmp	w23,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w27,	#0
    movz	w22,	#1
    mov	w18,	w22
    csel	w25,	w18,	w24,	ne
    str	w25,	[sp, #256]

    ldr	w21,	[sp, #864]

    cmp	w21,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    mov	w21,	w23
    str	w21,	[sp, #200]

    ldr	w26,	[sp, #256]

    cmp	w26,	#0
    ldr	w24,	[sp, #200]

    cset	w28,	ne
    mov	w0,	w28
    cmp	w24,	#0
    ldr	w27,	[sp, #256]

    movz	w24,	#1
    mov	w25,	w24
    csel	w28,	w25,	w0,	ne
    cmp	w27,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #200]

    mov	w23,	w0
    cmp	w25,	#0
    movz	w0,	#0
    csel	w23,	w23,	w0,	ne
    cmp	w23,	#0
    cset	w0,	eq
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	ne
    mov	w0,	w21
    cmp	w28,	#0
    movz	w18,	#0
    mov	w24,	w18
    csel	w25,	w0,	w24,	ne
    str	w25,	[sp, #836]

    ldr	w22,	[sp, #864]

    cmp	w22,	#0
    cset	w28,	ne
    ldr	w20,	[sp, #256]

    mov	w18,	w28
    cmp	w20,	#0
    ldr	w22,	[sp, #200]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w22,	#0
    movz	w0,	#0
    mov	w19,	w0
    csel	w24,	w21,	w19,	ne
    cmp	w24,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w18,	#0
    movz	w19,	#1
    csel	w22,	w19,	w28,	ne
    str	w22,	[sp, #856]

    ldr	w25,	[sp, #868]

    cmp	w25,	#0
    cset	w21,	ne
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	eq
    mov	w27,	w23
    cmp	w27,	#0
    cset	w28,	ne
    mov	w25,	w28
    str	w25,	[sp, #340]

    ldr	w23,	[sp, #856]

    cmp	w23,	#0
    ldr	w0,	[sp, #340]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w0,	#0
    ldr	w24,	[sp, #856]

    movz	w19,	#1
    mov	w0,	w19
    csel	w22,	w0,	w21,	ne
    cmp	w24,	#0
    ldr	w18,	[sp, #340]

    cset	w27,	ne
    mov	w28,	w27
    cmp	w18,	#0
    movz	w23,	#0
    mov	w24,	w23
    csel	w24,	w28,	w24,	ne
    cmp	w24,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    mov	w27,	w23
    cmp	w22,	#0
    movz	w0,	#0
    csel	w20,	w27,	w0,	ne
    str	w20,	[sp, #820]

    ldr	w26,	[sp, #868]

    cmp	w26,	#0
    cset	w20,	ne
    ldr	w25,	[sp, #856]

    mov	w28,	w20
    cmp	w25,	#0
    cset	w0,	ne
    ldr	w27,	[sp, #340]

    mov	w23,	w0
    cmp	w27,	#0
    movz	w0,	#0
    mov	w24,	w0
    csel	w23,	w23,	w24,	ne
    cmp	w23,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w28,	#0
    movz	w0,	#1
    mov	w19,	w0
    csel	w27,	w19,	w20,	ne
    str	w27,	[sp, #860]

    ldr	w0,	[sp, #872]

    cmp	w0,	#0
    cset	w23,	ne
    mov	w27,	w23
    cmp	w27,	#0
    cset	w28,	eq
    mov	w0,	w28
    cmp	w0,	#0
    cset	w20,	ne
    mov	w18,	w20
    str	w18,	[sp, #344]

    ldr	w28,	[sp, #860]

    cmp	w28,	#0
    cset	w0,	ne
    ldr	w22,	[sp, #344]

    mov	w23,	w0
    cmp	w22,	#0
    movz	w19,	#1
    ldr	w0,	[sp, #860]

    csel	w25,	w19,	w23,	ne
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w24,	[sp, #344]

    mov	w20,	w0
    cmp	w24,	#0
    movz	w19,	#0
    mov	w0,	w19
    csel	w0,	w20,	w0,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w27,	w23
    cmp	w27,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w25,	#0
    movz	w24,	#0
    mov	w25,	w24
    csel	w0,	w0,	w25,	ne
    str	w0,	[sp, #1072]

    ldr	w18,	[sp, #872]

    cmp	w18,	#0
    ldr	w20,	[sp, #860]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w20,	#0
    cset	w27,	ne
    ldr	w22,	[sp, #344]

    mov	w28,	w27
    cmp	w22,	#0
    movz	w0,	#0
    csel	w24,	w28,	w0,	ne
    cmp	w24,	#0
    cset	w21,	ne
    mov	w0,	w21
    cmp	w18,	#0
    movz	w18,	#1
    mov	w24,	w18
    csel	w18,	w24,	w0,	ne
    str	w18,	[sp, #804]

    ldr	w23,	[sp, #568]

    cmp	w23,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w0,	#0
    cset	w20,	eq
    mov	w21,	w20
    cmp	w21,	#0
    ldr	w27,	[sp, #804]

    cset	w0,	ne
    mov	w22,	w0
    cmp	w27,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w22,	#0
    ldr	w28,	[sp, #804]

    movz	w20,	#1
    mov	w26,	w20
    csel	w25,	w26,	w18,	ne
    cmp	w28,	#0
    cset	w24,	ne
    mov	w0,	w24
    cmp	w22,	#0
    movz	w23,	#0
    csel	w24,	w0,	w23,	ne
    cmp	w24,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w25,	#0
    movz	w21,	#0
    mov	w19,	w21
    csel	w27,	w24,	w19,	ne
    str	w27,	[sp, #1064]

    ldr	w0,	[sp, #568]

    cmp	w0,	#0
    ldr	w19,	[sp, #804]

    cset	w21,	ne
    mov	w24,	w21
    cmp	w19,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w22,	#0
    movz	w22,	#0
    mov	w0,	w22
    csel	w22,	w20,	w0,	ne
    cmp	w22,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w24,	#0
    movz	w18,	#1
    mov	w28,	w18
    csel	w20,	w28,	w25,	ne
    str	w20,	[sp, #1076]

    ldr	w20,	[sp, #616]

    cmp	w20,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w27,	ne
    mov	w22,	w27
    str	w22,	[sp, #968]

    ldr	w21,	[sp, #1076]

    cmp	w21,	#0
    ldr	w24,	[sp, #968]

    cset	w0,	ne
    mov	w20,	w0
    cmp	w24,	#0
    movz	w25,	#1
    ldr	w22,	[sp, #1076]

    mov	w24,	w25
    csel	w19,	w24,	w20,	ne
    cmp	w22,	#0
    ldr	w24,	[sp, #968]

    cset	w23,	ne
    mov	w27,	w23
    cmp	w24,	#0
    movz	w18,	#0
    mov	w22,	w18
    csel	w24,	w27,	w22,	ne
    cmp	w24,	#0
    cset	w20,	eq
    mov	w21,	w20
    cmp	w21,	#0
    cset	w0,	ne
    mov	w25,	w0
    cmp	w19,	#0
    movz	w19,	#0
    mov	w0,	w19
    csel	w18,	w25,	w0,	ne
    str	w18,	[sp, #1060]

    ldr	w21,	[sp, #616]

    cmp	w21,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #1076]

    mov	w20,	w0
    cmp	w18,	#0
    ldr	w21,	[sp, #968]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w21,	#0
    movz	w27,	#0
    mov	w0,	w27
    csel	w24,	w18,	w0,	ne
    cmp	w24,	#0
    cset	w0,	ne
    mov	w25,	w0
    cmp	w20,	#0
    movz	w23,	#1
    mov	w0,	w23
    csel	w24,	w0,	w25,	ne
    str	w24,	[sp, #1068]

    ldr	w25,	[sp, #632]

    cmp	w25,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	ne
    str	w0,	[sp, #964]

    ldr	w25,	[sp, #1068]

    cmp	w25,	#0
    ldr	w19,	[sp, #964]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w19,	#0
    ldr	w26,	[sp, #1068]

    movz	w25,	#1
    csel	w22,	w25,	w0,	ne
    cmp	w26,	#0
    cset	w28,	ne
    ldr	w20,	[sp, #964]

    mov	w0,	w28
    cmp	w20,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w24,	w0,	w24,	ne
    cmp	w24,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w22,	#0
    movz	w0,	#0
    mov	w22,	w0
    csel	w27,	w28,	w22,	ne
    str	w27,	[sp, #1056]

    ldr	w26,	[sp, #632]

    cmp	w26,	#0
    cset	w21,	ne
    ldr	w22,	[sp, #1068]

    mov	w0,	w21
    cmp	w22,	#0
    ldr	w26,	[sp, #964]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w26,	#0
    movz	w21,	#0
    mov	w27,	w21
    csel	w24,	w20,	w27,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w0,	#0
    movz	w23,	#1
    mov	w19,	w23
    csel	w25,	w19,	w18,	ne
    str	w25,	[sp, #800]

    ldr	w27,	[sp, #660]

    cmp	w27,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	eq
    mov	w20,	w0
    cmp	w20,	#0
    ldr	w22,	[sp, #800]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w22,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w0,	#0
    ldr	w23,	[sp, #800]

    movz	w26,	#1
    csel	w27,	w26,	w18,	ne
    cmp	w23,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w0,	#0
    movz	w26,	#0
    mov	w21,	w26
    csel	w24,	w24,	w21,	ne
    cmp	w24,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w27,	#0
    movz	w27,	#0
    csel	w24,	w23,	w27,	ne
    str	w24,	[sp, #364]

    ldr	w25,	[sp, #660]

    cmp	w25,	#0
    ldr	w26,	[sp, #800]

    cset	w25,	ne
    mov	w18,	w25
    cmp	w26,	#0
    cset	w22,	ne
    mov	w23,	w22
    cmp	w0,	#0
    movz	w27,	#0
    mov	w0,	w27
    csel	w24,	w23,	w0,	ne
    cmp	w24,	#0
    cset	w0,	ne
    mov	w25,	w0
    cmp	w18,	#0
    movz	w19,	#1
    csel	w22,	w19,	w25,	ne
    str	w22,	[sp, #368]

    ldr	w19,	[sp, #680]

    cmp	w19,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    ldr	w28,	[sp, #368]

    cset	w23,	ne
    mov	w27,	w23
    cmp	w28,	#0
    cset	w22,	ne
    mov	w23,	w22
    cmp	w27,	#0
    movz	w21,	#1
    ldr	w0,	[sp, #368]

    csel	w25,	w21,	w23,	ne
    cmp	w0,	#0
    cset	w18,	ne
    mov	w19,	w18
    str	w19,	[sp, #540]

    cmp	w27,	#0
    movz	w23,	#0
    mov	w18,	w23
    ldr	w23,	[sp, #540]

    csel	w23,	w23,	w18,	ne
    cmp	w23,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w18,	ne
    mov	w19,	w18
    cmp	w25,	#0
    movz	w0,	#0
    mov	w26,	w0
    csel	w0,	w19,	w26,	ne
    str	w0,	[sp, #356]

    ldr	w18,	[sp, #680]

    cmp	w18,	#0
    cset	w0,	ne
    mov	w24,	w0
    ldr	w0,	[sp, #368]

    cmp	w0,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w27,	#0
    movz	w21,	#0
    mov	w20,	w21
    csel	w23,	w0,	w20,	ne
    cmp	w23,	#0
    cset	w0,	ne
    cmp	w24,	#0
    movz	w19,	#1
    mov	w23,	w19
    csel	w24,	w23,	w0,	ne
    str	w24,	[sp, #544]

    ldr	w28,	[sp, #676]

    cmp	w28,	#0
    cset	w21,	ne
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	eq
    mov	w27,	w23
    cmp	w27,	#0
    cset	w28,	ne
    ldr	w24,	[sp, #544]

    mov	w0,	w28
    cmp	w24,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w0,	#0
    movz	w21,	#1
    csel	w21,	w21,	w24,	ne
    str	w21,	[sp, #360]

    ldr	w18,	[sp, #544]

    cmp	w18,	#0
    cset	w18,	ne
    mov	w19,	w18
    cmp	w0,	#0
    movz	w23,	#0
    mov	w0,	w23
    csel	w20,	w19,	w0,	ne
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    ldr	w21,	[sp, #360]

    cset	w23,	ne
    mov	w27,	w23
    cmp	w21,	#0
    movz	w23,	#0
    ldr	w26,	[sp, #356]

    mov	w24,	w23
    ldr	w20,	[sp, #364]

    csel	w0,	w27,	w24,	ne
    ldr	w28,	[sp, #1056]

    lsl	w22,	w0,	#1
    ldr	w19,	[sp, #1060]

    add	w21,	w22,	w26
    ldr	w22,	[sp, #1064]

    ldr	w18,	[sp, #1072]

    lsl	w0,	w21,	#1
    ldr	w21,	[sp, #820]

    add	w23,	w0,	w20
    ldr	w26,	[sp, #836]

    lsl	w0,	w23,	#1
    ldr	w23,	[sp, #832]

    add	w28,	w0,	w28
    lsl	w20,	w28,	#1
    add	w20,	w20,	w19
    lsl	w24,	w20,	#1
    add	w0,	w24,	w22
    lsl	w25,	w0,	#1
    add	w27,	w25,	w18
    lsl	w18,	w27,	#1
    add	w0,	w18,	w21
    lsl	w22,	w0,	#1
    add	w21,	w22,	w26
    ldr	w26,	[sp, #548]

    lsl	w0,	w21,	#1
    add	w23,	w0,	w23
    lsl	w27,	w23,	#1
    add	w28,	w27,	w26
    lsl	w0,	w28,	#1
    ldr	w28,	[sp, #596]

    add	w20,	w0,	w28
    ldr	w28,	[sp, #608]

    lsl	w21,	w20,	#1
    add	w0,	w21,	w28
    ldr	w21,	[sp, #644]

    ldr	w19,	[sp, #668]

    lsl	w23,	w0,	#1
    add	w27,	w23,	w21
    ldr	w21,	[sp, #684]

    lsl	w28,	w27,	#1
    add	w0,	w28,	w19
    lsl	w20,	w0,	#1
    add	w0,	w20,	w21
    bl	fib
    str	w0,	[sp, #688]

    ldr	w26,	[sp, #476]

    cmp	w26,	#0
    ldr	w24,	[sp, #400]

    ldr	w27,	[sp, #476]

    csel	w24,	w24,	w27,	lt
    ldr	w28,	[sp, #484]

    cmp	w28,	#0
    ldr	w18,	[sp, #416]

    ldr	w0,	[sp, #484]

    csel	w23,	w18,	w0,	lt
    ldr	w28,	[sp, #488]

    cmp	w28,	#0
    ldr	w27,	[sp, #432]

    ldr	w0,	[sp, #488]

    csel	w28,	w27,	w0,	lt
    str	w28,	[sp, #176]

    ldr	w20,	[sp, #496]

    cmp	w20,	#0
    ldr	w20,	[sp, #444]

    ldr	w21,	[sp, #496]

    csel	w20,	w20,	w21,	lt
    str	w20,	[sp, #180]

    ldr	w25,	[sp, #492]

    cmp	w25,	#0
    ldr	w0,	[sp, #456]

    ldr	w26,	[sp, #492]

    csel	w26,	w0,	w26,	lt
    str	w26,	[sp, #184]

    ldr	w22,	[sp, #480]

    cmp	w22,	#0
    ldr	w26,	[sp, #468]

    ldr	w25,	[sp, #480]

    csel	w18,	w26,	w25,	lt
    str	w18,	[sp, #188]

    ldr	w18,	[sp, #472]

    cmp	w18,	#0
    ldr	w25,	[sp, #460]

    ldr	w19,	[sp, #472]

    csel	w22,	w25,	w19,	lt
    str	w22,	[sp, #876]

    ldr	w0,	[sp, #464]

    cmp	w0,	#0
    ldr	w28,	[sp, #448]

    ldr	w18,	[sp, #464]

    csel	w28,	w28,	w18,	lt
    str	w28,	[sp, #880]

    ldr	w22,	[sp, #452]

    cmp	w22,	#0
    ldr	w21,	[sp, #436]

    ldr	w25,	[sp, #452]

    csel	w20,	w21,	w25,	lt
    str	w20,	[sp, #884]

    ldr	w0,	[sp, #440]

    cmp	w0,	#0
    ldr	w28,	[sp, #424]

    ldr	w0,	[sp, #440]

    csel	w26,	w28,	w0,	lt
    str	w26,	[sp, #888]

    ldr	w22,	[sp, #428]

    cmp	w22,	#0
    ldr	w21,	[sp, #412]

    ldr	w19,	[sp, #428]

    csel	w18,	w21,	w19,	lt
    str	w18,	[sp, #220]

    ldr	w21,	[sp, #420]

    cmp	w21,	#0
    ldr	w20,	[sp, #404]

    ldr	w0,	[sp, #420]

    csel	w18,	w20,	w0,	lt
    str	w18,	[sp, #576]

    ldr	w28,	[sp, #408]

    cmp	w28,	#0
    ldr	w0,	[sp, #392]

    ldr	w22,	[sp, #408]

    csel	w20,	w0,	w22,	lt
    str	w20,	[sp, #612]

    ldr	w21,	[sp, #396]

    cmp	w21,	#0
    ldr	w26,	[sp, #384]

    ldr	w25,	[sp, #396]

    csel	w20,	w26,	w25,	lt
    str	w20,	[sp, #640]

    ldr	w20,	[sp, #388]

    cmp	w20,	#0
    ldr	w25,	[sp, #376]

    ldr	w21,	[sp, #388]

    csel	w20,	w25,	w21,	lt
    str	w20,	[sp, #652]

    ldr	w19,	[sp, #380]

    cmp	w19,	#0
    ldr	w19,	[sp, #692]

    ldr	w20,	[sp, #380]

    csel	w26,	w19,	w20,	lt
    str	w26,	[sp, #656]

    cmp	w24,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w26,	ne
    str	w26,	[sp, #672]

    cmp	w23,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w18,	ne
    str	w18,	[sp, #664]

    cmp	w23,	#0
    cset	w26,	ne
    cmp	w26,	#0
    ldr	w19,	[sp, #176]

    cset	w27,	ne
    mov	w21,	w27
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w25,	ne
    mov	w23,	w25
    str	w23,	[sp, #528]

    cmp	w21,	#0
    ldr	w22,	[sp, #528]

    cset	w28,	ne
    mov	w18,	w28
    cmp	w22,	#0
    movz	w19,	#1
    csel	w24,	w19,	w18,	ne
    cmp	w21,	#0
    cset	w27,	ne
    str	w27,	[sp, #524]

    ldr	w0,	[sp, #528]

    cmp	w0,	#0
    ldr	w23,	[sp, #524]

    movz	w19,	#0
    mov	w27,	w19
    csel	w18,	w23,	w27,	ne
    cmp	w18,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w24,	#0
    movz	w0,	#0
    csel	w18,	w19,	w0,	ne
    str	w18,	[sp, #648]

    ldr	w20,	[sp, #176]

    cmp	w20,	#0
    cset	w22,	ne
    cmp	w21,	#0
    cset	w27,	ne
    mov	w18,	w27
    ldr	w27,	[sp, #528]

    cmp	w27,	#0
    movz	w0,	#0
    csel	w0,	w18,	w0,	ne
    cmp	w0,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w22,	#0
    movz	w24,	#1
    csel	w26,	w24,	w21,	ne
    str	w26,	[sp, #572]

    ldr	w0,	[sp, #180]

    cmp	w0,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    ldr	w26,	[sp, #572]

    cmp	w26,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w28,	#0
    ldr	w27,	[sp, #572]

    movz	w19,	#1
    csel	w20,	w19,	w26,	ne
    cmp	w27,	#0
    cset	w26,	ne
    cmp	w28,	#0
    movz	w23,	#0
    mov	w19,	w23
    csel	w0,	w26,	w19,	ne
    cmp	w0,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w20,	#0
    movz	w0,	#0
    csel	w25,	w18,	w0,	ne
    str	w25,	[sp, #628]

    ldr	w24,	[sp, #180]

    cmp	w24,	#0
    ldr	w25,	[sp, #572]

    cset	w27,	ne
    cmp	w25,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w28,	#0
    movz	w26,	#0
    csel	w23,	w21,	w26,	ne
    cmp	w23,	#0
    cset	w24,	ne
    mov	w26,	w24
    cmp	w27,	#0
    ldr	w21,	[sp, #184]

    movz	w0,	#1
    csel	w23,	w0,	w26,	ne
    cmp	w21,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w23,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w0,	#0
    movz	w26,	#1
    csel	w18,	w26,	w18,	ne
    cmp	w23,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w0,	#0
    movz	w25,	#0
    csel	w24,	w22,	w25,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w18,	#0
    movz	w24,	#0
    csel	w20,	w19,	w24,	ne
    str	w20,	[sp, #600]

    ldr	w18,	[sp, #184]

    cmp	w18,	#0
    cset	w22,	ne
    cmp	w23,	#0
    cset	w18,	ne
    mov	w21,	w18
    cmp	w0,	#0
    movz	w19,	#0
    csel	w26,	w21,	w19,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w22,	#0
    movz	w23,	#1
    ldr	w25,	[sp, #188]

    csel	w20,	w23,	w18,	ne
    cmp	w25,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w20,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w28,	#0
    movz	w0,	#1
    csel	w22,	w0,	w19,	ne
    cmp	w20,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w28,	#0
    movz	w23,	#0
    csel	w25,	w24,	w23,	ne
    cmp	w25,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w22,	#0
    movz	w21,	#0
    csel	w23,	w18,	w21,	ne
    str	w23,	[sp, #560]

    ldr	w21,	[sp, #188]

    cmp	w21,	#0
    cset	w21,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w28,	#0
    movz	w25,	#0
    csel	w0,	w19,	w25,	ne
    cmp	w0,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w21,	#0
    movz	w27,	#1
    ldr	w0,	[sp, #876]

    csel	w25,	w27,	w22,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w0,	w23
    cmp	w25,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    movz	w18,	#1
    csel	w23,	w18,	w20,	ne
    cmp	w25,	#0
    cset	w22,	ne
    mov	w24,	w22
    cmp	w0,	#0
    movz	w27,	#0
    csel	w19,	w24,	w27,	ne
    cmp	w19,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w23,	#0
    movz	w26,	#0
    csel	w21,	w19,	w26,	ne
    str	w21,	[sp, #948]

    ldr	w26,	[sp, #876]

    cmp	w26,	#0
    cset	w22,	ne
    cmp	w25,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w0,	#0
    movz	w28,	#0
    csel	w24,	w24,	w28,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w22,	#0
    ldr	w21,	[sp, #880]

    movz	w0,	#1
    csel	w22,	w0,	w27,	ne
    cmp	w21,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w22,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w28,	#0
    movz	w26,	#1
    csel	w27,	w26,	w27,	ne
    cmp	w22,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w28,	#0
    movz	w24,	#0
    csel	w23,	w21,	w24,	ne
    cmp	w23,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w27,	#0
    movz	w0,	#0
    csel	w23,	w18,	w0,	ne
    str	w23,	[sp, #952]

    ldr	w18,	[sp, #880]

    cmp	w18,	#0
    cset	w21,	ne
    cmp	w22,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w28,	#0
    movz	w24,	#0
    csel	w26,	w20,	w24,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w21,	#0
    ldr	w25,	[sp, #884]

    movz	w27,	#1
    csel	w20,	w27,	w18,	ne
    cmp	w25,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w20,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w28,	#0
    movz	w26,	#1
    csel	w0,	w26,	w18,	ne
    cmp	w20,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w28,	#0
    movz	w25,	#0
    csel	w25,	w23,	w25,	ne
    cmp	w25,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w0,	#0
    movz	w24,	#0
    csel	w0,	w18,	w24,	ne
    str	w0,	[sp, #944]

    ldr	w22,	[sp, #884]

    cmp	w22,	#0
    cset	w21,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w28,	#0
    movz	w26,	#0
    csel	w0,	w19,	w26,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w21,	#0
    ldr	w0,	[sp, #888]

    movz	w21,	#1
    csel	w21,	w21,	w19,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w0,	w23
    cmp	w21,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w22,	#1
    csel	w18,	w22,	w19,	ne
    cmp	w21,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w0,	#0
    movz	w19,	#0
    csel	w19,	w25,	w19,	ne
    cmp	w19,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w18,	#0
    movz	w19,	#0
    csel	w26,	w20,	w19,	ne
    str	w26,	[sp, #940]

    ldr	w27,	[sp, #888]

    cmp	w27,	#0
    cset	w22,	ne
    cmp	w21,	#0
    cset	w21,	ne
    cmp	w0,	#0
    movz	w0,	#0
    csel	w24,	w21,	w0,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w22,	#0
    movz	w26,	#1
    ldr	w21,	[sp, #220]

    csel	w20,	w26,	w27,	ne
    cmp	w21,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w20,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w28,	#0
    movz	w25,	#1
    csel	w0,	w25,	w18,	ne
    cmp	w20,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w28,	#0
    movz	w24,	#0
    csel	w23,	w23,	w24,	ne
    cmp	w23,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w0,	#0
    movz	w0,	#0
    csel	w22,	w19,	w0,	ne
    str	w22,	[sp, #248]

    ldr	w19,	[sp, #220]

    cmp	w19,	#0
    cset	w21,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w25,	#0
    csel	w26,	w0,	w25,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w21,	#0
    movz	w19,	#1
    csel	w20,	w19,	w18,	ne
    ldr	w19,	[sp, #576]

    cmp	w19,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w20,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w28,	#0
    movz	w21,	#1
    csel	w25,	w21,	w18,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w19,	#0
    csel	w27,	w0,	w19,	ne
    cmp	w27,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w25,	#0
    movz	w27,	#0
    csel	w19,	w21,	w27,	ne
    str	w19,	[sp, #244]

    ldr	w19,	[sp, #576]

    cmp	w19,	#0
    cset	w24,	ne
    cmp	w20,	#0
    cset	w19,	ne
    cmp	w28,	#0
    movz	w28,	#0
    csel	w18,	w19,	w28,	ne
    cmp	w18,	#0
    cset	w21,	ne
    cmp	w24,	#0
    movz	w24,	#1
    ldr	w20,	[sp, #612]

    csel	w23,	w24,	w21,	ne
    cmp	w20,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w23,	#0
    cset	w24,	ne
    mov	w27,	w24
    cmp	w0,	#0
    movz	w26,	#1
    csel	w26,	w26,	w27,	ne
    cmp	w23,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w25,	#0
    csel	w19,	w19,	w25,	ne
    cmp	w19,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w26,	#0
    movz	w24,	#0
    csel	w25,	w27,	w24,	ne
    str	w25,	[sp, #236]

    ldr	w25,	[sp, #612]

    cmp	w25,	#0
    cset	w18,	ne
    cmp	w23,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w0,	#0
    movz	w27,	#0
    csel	w24,	w19,	w27,	ne
    cmp	w24,	#0
    cset	w24,	ne
    mov	w27,	w24
    cmp	w18,	#0
    movz	w23,	#1
    ldr	w0,	[sp, #640]

    csel	w18,	w23,	w27,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w18,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w28,	#0
    movz	w0,	#1
    csel	w27,	w0,	w27,	ne
    cmp	w18,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w28,	#0
    movz	w26,	#0
    csel	w23,	w21,	w26,	ne
    cmp	w23,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w27,	#0
    movz	w25,	#0
    csel	w27,	w0,	w25,	ne
    str	w27,	[sp, #240]

    ldr	w0,	[sp, #640]

    cmp	w0,	#0
    cset	w21,	ne
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w26,	#0
    csel	w26,	w0,	w26,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w21,	#0
    ldr	w20,	[sp, #652]

    movz	w23,	#1
    csel	w22,	w23,	w18,	ne
    cmp	w20,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    cmp	w22,	#0
    cset	w26,	ne
    mov	w28,	w26
    cmp	w23,	#0
    movz	w0,	#1
    csel	w21,	w0,	w28,	ne
    str	w21,	[sp, #552]

    cmp	w22,	#0
    cset	w19,	ne
    mov	w24,	w19
    cmp	w23,	#0
    movz	w21,	#0
    csel	w0,	w24,	w21,	ne
    cmp	w0,	#0
    cset	w24,	eq
    cmp	w24,	#0
    ldr	w21,	[sp, #552]

    cset	w26,	ne
    mov	w28,	w26
    cmp	w21,	#0
    movz	w19,	#0
    ldr	w18,	[sp, #652]

    csel	w25,	w28,	w19,	ne
    cmp	w18,	#0
    cset	w19,	ne
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w23,	#0
    movz	w20,	#0
    csel	w21,	w0,	w20,	ne
    cmp	w21,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w19,	#0
    movz	w23,	#1
    csel	w21,	w23,	w18,	ne
    str	w21,	[sp, #556]

    ldr	w20,	[sp, #656]

    cmp	w20,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    ldr	w0,	[sp, #556]

    cset	w28,	ne
    cmp	w0,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w28,	#0
    ldr	w24,	[sp, #556]

    movz	w0,	#1
    csel	w23,	w0,	w18,	ne
    cmp	w24,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w28,	#0
    movz	w24,	#0
    csel	w0,	w22,	w24,	ne
    cmp	w0,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w23,	#0
    movz	w23,	#0
    ldr	w19,	[sp, #240]

    csel	w28,	w18,	w23,	ne
    lsl	w18,	w28,	#1
    ldr	w28,	[sp, #236]

    add	w20,	w18,	w25
    ldr	w22,	[sp, #244]

    ldr	w25,	[sp, #248]

    lsl	w24,	w20,	#1
    add	w0,	w24,	w19
    lsl	w24,	w0,	#1
    add	w24,	w24,	w28
    lsl	w27,	w24,	#1
    add	w26,	w27,	w22
    lsl	w0,	w26,	#1
    add	w28,	w0,	w25
    lsl	w19,	w28,	#1
    ldr	w28,	[sp, #940]

    add	w18,	w19,	w28
    ldr	w19,	[sp, #944]

    ldr	w25,	[sp, #952]

    lsl	w22,	w18,	#1
    add	w20,	w22,	w19
    ldr	w22,	[sp, #948]

    ldr	w26,	[sp, #560]

    lsl	w23,	w20,	#1
    ldr	w20,	[sp, #600]

    add	w0,	w23,	w25
    lsl	w25,	w0,	#1
    add	w24,	w25,	w22
    lsl	w25,	w24,	#1
    add	w26,	w25,	w26
    lsl	w27,	w26,	#1
    add	w28,	w27,	w20
    ldr	w27,	[sp, #628]

    lsl	w0,	w28,	#1
    add	w18,	w0,	w27
    ldr	w0,	[sp, #648]

    ldr	w27,	[sp, #664]

    lsl	w19,	w18,	#1
    ldr	w22,	[sp, #672]

    add	w20,	w19,	w0
    lsl	w21,	w20,	#1
    add	w0,	w21,	w27
    lsl	w23,	w0,	#1
    add	w0,	w23,	w22
    bl	fib
    movz	w4,	#0
    ldr	w18,	[sp, #688]

    asr	w12,	w18,	#31
    ldr	w24,	[sp, #688]

    ldr	w25,	[sp, #688]

    lsr	w13,	w12,	#31
    add	w14,	w24,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w1,	w25,	w6
    sub	w3,	w4,	w1
    cmp	w1,	#0
    csel	w6,	w3,	w1,	lt
    str	w6,	[sp, #928]

    ldr	w21,	[sp, #688]

    asr	w15,	w21,	#31
    ldr	w27,	[sp, #688]

    lsr	w16,	w15,	#31
    add	w17,	w27,	w16
    asr	w4,	w17,	#1
    asr	w26,	w4,	#31
    lsr	w27,	w26,	#31
    add	w28,	w4,	w27
    asr	w21,	w28,	#1
    movz	w28,	#0
    lsl	w22,	w21,	#1
    sub	w7,	w4,	w22
    sub	w10,	w28,	w7
    cmp	w7,	#0
    movz	w24,	#0
    csel	w19,	w10,	w7,	lt
    asr	w1,	w4,	#31
    str	w19,	[sp, #916]

    lsr	w2,	w1,	#31
    add	w23,	w4,	w2
    asr	w10,	w23,	#1
    asr	w3,	w10,	#31
    lsr	w4,	w3,	#31
    add	w5,	w10,	w4
    asr	w17,	w5,	#1
    lsl	w18,	w17,	#1
    sub	w12,	w10,	w18
    sub	w15,	w24,	w12
    cmp	w12,	#0
    movz	w20,	#0
    asr	w6,	w10,	#31
    csel	w4,	w15,	w12,	lt
    lsr	w7,	w6,	#31
    str	w4,	[sp, #904]

    add	w1,	w10,	w7
    asr	w15,	w1,	#1
    asr	w9,	w15,	#31
    lsr	w10,	w9,	#31
    add	w11,	w15,	w10
    asr	w11,	w11,	#1
    lsl	w12,	w11,	#1
    sub	w17,	w15,	w12
    sub	w20,	w20,	w17
    cmp	w17,	#0
    asr	w12,	w15,	#31
    csel	w8,	w20,	w17,	lt
    str	w8,	[sp, #772]

    lsr	w13,	w12,	#31
    add	w7,	w15,	w13
    asr	w22,	w7,	#1
    asr	w15,	w22,	#31
    lsr	w16,	w15,	#31
    add	w17,	w22,	w16
    movz	w16,	#0
    asr	w7,	w17,	#1
    lsl	w8,	w7,	#1
    sub	w24,	w22,	w8
    sub	w25,	w16,	w24
    cmp	w24,	#0
    asr	w18,	w22,	#31
    csel	w9,	w25,	w24,	lt
    movz	w12,	#0
    str	w9,	[sp, #908]

    lsr	w19,	w18,	#31
    add	w13,	w22,	w19
    asr	w27,	w13,	#1
    asr	w21,	w27,	#31
    lsr	w22,	w21,	#31
    add	w23,	w27,	w22
    asr	w3,	w23,	#1
    lsl	w4,	w3,	#1
    sub	w1,	w27,	w4
    sub	w3,	w12,	w1
    cmp	w1,	#0
    asr	w24,	w27,	#31
    csel	w14,	w3,	w1,	lt
    movz	w8,	#0
    str	w14,	[sp, #912]

    lsr	w26,	w24,	#31
    add	w19,	w27,	w26
    asr	w2,	w19,	#1
    asr	w1,	w2,	#31
    lsr	w3,	w1,	#31
    add	w4,	w2,	w3
    asr	w28,	w4,	#1
    lsl	w1,	w28,	#1
    sub	w6,	w2,	w1
    sub	w9,	w8,	w6
    cmp	w6,	#0
    movz	w4,	#0
    asr	w5,	w2,	#31
    csel	w3,	w9,	w6,	lt
    str	w3,	[sp, #744]

    lsr	w6,	w5,	#31
    add	w25,	w2,	w6
    asr	w10,	w25,	#1
    asr	w6,	w10,	#31
    lsr	w7,	w6,	#31
    add	w9,	w10,	w7
    asr	w24,	w9,	#1
    lsl	w25,	w24,	#1
    sub	w13,	w10,	w25
    sub	w14,	w4,	w13
    cmp	w13,	#0
    csel	w1,	w14,	w13,	lt
    movz	w28,	#0
    asr	w11,	w10,	#31
    str	w1,	[sp, #924]

    lsr	w12,	w11,	#31
    add	w3,	w10,	w12
    asr	w12,	w3,	#1
    asr	w14,	w12,	#31
    lsr	w15,	w14,	#31
    add	w16,	w12,	w15
    asr	w20,	w16,	#1
    lsl	w21,	w20,	#1
    sub	w16,	w12,	w21
    sub	w19,	w28,	w16
    cmp	w16,	#0
    asr	w17,	w12,	#31
    csel	w13,	w19,	w16,	lt
    movz	w24,	#0
    str	w13,	[sp, #516]

    lsr	w18,	w17,	#31
    add	w9,	w12,	w18
    asr	w18,	w9,	#1
    asr	w20,	w18,	#31
    lsr	w21,	w20,	#31
    add	w22,	w18,	w21
    asr	w14,	w22,	#1
    lsl	w15,	w14,	#1
    sub	w21,	w18,	w15
    sub	w24,	w24,	w21
    cmp	w21,	#0
    movz	w20,	#0
    asr	w23,	w18,	#31
    csel	w16,	w24,	w21,	lt
    lsr	w24,	w23,	#31
    str	w16,	[sp, #732]

    add	w15,	w18,	w24
    asr	w25,	w15,	#1
    asr	w26,	w25,	#31
    lsr	w27,	w26,	#31
    add	w28,	w25,	w27
    asr	w10,	w28,	#1
    lsl	w11,	w10,	#1
    sub	w28,	w25,	w11
    sub	w1,	w20,	w28
    cmp	w28,	#0
    csel	w21,	w1,	w28,	lt
    movz	w16,	#0
    asr	w1,	w25,	#31
    str	w21,	[sp, #736]

    lsr	w2,	w1,	#31
    add	w21,	w25,	w2
    asr	w2,	w21,	#1
    asr	w4,	w2,	#31
    lsr	w5,	w4,	#31
    add	w6,	w2,	w5
    asr	w7,	w6,	#1
    lsl	w8,	w7,	#1
    sub	w4,	w2,	w8
    sub	w7,	w16,	w4
    cmp	w4,	#0
    csel	w26,	w7,	w4,	lt
    str	w26,	[sp, #764]

    asr	w7,	w2,	#31
    lsr	w8,	w7,	#31
    add	w27,	w2,	w8
    asr	w6,	w27,	#1
    asr	w11,	w6,	#31
    lsr	w12,	w11,	#31
    add	w13,	w6,	w12
    movz	w12,	#0
    asr	w2,	w13,	#1
    lsl	w3,	w2,	#1
    sub	w10,	w6,	w3
    sub	w13,	w12,	w10
    cmp	w10,	#0
    asr	w14,	w6,	#31
    csel	w3,	w13,	w10,	lt
    str	w3,	[sp, #768]

    lsr	w15,	w14,	#31
    add	w5,	w6,	w15
    asr	w3,	w5,	#1
    asr	w6,	w3,	#31
    lsr	w7,	w6,	#31
    add	w8,	w3,	w7
    asr	w9,	w8,	#1
    movz	w8,	#0
    lsl	w10,	w9,	#1
    sub	w13,	w3,	w10
    sub	w14,	w8,	w13
    cmp	w13,	#0
    asr	w9,	w3,	#31
    movz	w4,	#0
    csel	w12,	w14,	w13,	lt
    lsr	w10,	w9,	#31
    str	w12,	[sp, #752]

    add	w11,	w3,	w10
    asr	w11,	w11,	#1
    asr	w12,	w11,	#31
    lsr	w13,	w12,	#31
    add	w14,	w11,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w18,	w11,	w6
    sub	w19,	w4,	w18
    cmp	w18,	#0
    movz	w28,	#0
    csel	w17,	w19,	w18,	lt
    asr	w15,	w11,	#31
    str	w17,	[sp, #756]

    lsr	w16,	w15,	#31
    add	w17,	w11,	w16
    asr	w12,	w17,	#1
    asr	w1,	w12,	#31
    lsr	w2,	w1,	#31
    add	w2,	w12,	w2
    asr	w19,	w2,	#1
    lsl	w20,	w19,	#1
    sub	w21,	w12,	w20
    sub	w24,	w28,	w21
    cmp	w21,	#0
    csel	w8,	w24,	w21,	lt
    movz	w25,	#0
    asr	w21,	w0,	#31
    str	w8,	[sp, #748]

    lsr	w22,	w21,	#31
    add	w23,	w0,	w22
    asr	w26,	w23,	#1
    lsl	w27,	w26,	#1
    sub	w27,	w0,	w27
    sub	w28,	w25,	w27
    cmp	w27,	#0
    movz	w11,	#0
    csel	w24,	w28,	w27,	lt
    str	w24,	[sp, #920]

    asr	w24,	w0,	#31
    lsr	w25,	w24,	#31
    add	w24,	w0,	w25
    asr	w4,	w24,	#1
    asr	w25,	w4,	#31
    lsr	w26,	w25,	#31
    add	w27,	w4,	w26
    asr	w12,	w27,	#1
    lsl	w13,	w12,	#1
    sub	w22,	w4,	w13
    sub	w23,	w11,	w22
    cmp	w22,	#0
    asr	w28,	w4,	#31
    csel	w15,	w23,	w22,	lt
    movz	w7,	#0
    str	w15,	[sp, #900]

    lsr	w0,	w28,	#31
    add	w1,	w4,	w0
    asr	w24,	w1,	#1
    asr	w2,	w24,	#31
    lsr	w3,	w2,	#31
    add	w4,	w24,	w3
    asr	w8,	w4,	#1
    lsl	w9,	w8,	#1
    sub	w27,	w24,	w9
    sub	w28,	w7,	w27
    cmp	w27,	#0
    csel	w10,	w28,	w27,	lt
    asr	w5,	w24,	#31
    movz	w3,	#0
    str	w10,	[sp, #896]

    lsr	w6,	w5,	#31
    add	w7,	w24,	w6
    asr	w15,	w7,	#1
    asr	w9,	w15,	#31
    lsr	w10,	w9,	#31
    add	w11,	w15,	w10
    asr	w13,	w11,	#1
    lsl	w14,	w13,	#1
    sub	w2,	w15,	w14
    sub	w16,	w3,	w2
    cmp	w2,	#0
    movz	w28,	#0
    csel	w5,	w16,	w2,	lt
    asr	w13,	w15,	#31
    str	w5,	[sp, #892]

    lsr	w14,	w13,	#31
    add	w13,	w15,	w14
    asr	w18,	w13,	#1
    asr	w15,	w18,	#31
    lsr	w17,	w15,	#31
    add	w19,	w18,	w17
    asr	w8,	w19,	#1
    lsl	w9,	w8,	#1
    sub	w7,	w18,	w9
    sub	w21,	w28,	w7
    cmp	w7,	#0
    asr	w20,	w18,	#31
    csel	w11,	w21,	w7,	lt
    str	w11,	[sp, #740]

    lsr	w21,	w20,	#31
    add	w19,	w18,	w21
    asr	w23,	w19,	#1
    asr	w22,	w23,	#31
    lsr	w24,	w22,	#31
    add	w25,	w23,	w24
    movz	w24,	#0
    asr	w4,	w25,	#1
    lsl	w5,	w4,	#1
    sub	w12,	w23,	w5
    sub	w26,	w24,	w12
    cmp	w12,	#0
    csel	w9,	w26,	w12,	lt
    movz	w20,	#0
    str	w9,	[sp, #308]

    asr	w26,	w23,	#31
    lsr	w27,	w26,	#31
    add	w25,	w23,	w27
    asr	w17,	w25,	#1
    asr	w0,	w17,	#31
    lsr	w0,	w0,	#31
    add	w1,	w17,	w0
    asr	w0,	w1,	#1
    lsl	w1,	w0,	#1
    sub	w1,	w17,	w1
    sub	w0,	w20,	w1
    cmp	w1,	#0
    movz	w16,	#0
    asr	w2,	w17,	#31
    csel	w14,	w0,	w1,	lt
    lsr	w3,	w2,	#31
    str	w14,	[sp, #312]

    add	w2,	w17,	w3
    asr	w13,	w2,	#1
    asr	w5,	w13,	#31
    lsr	w6,	w5,	#31
    add	w7,	w13,	w6
    asr	w26,	w7,	#1
    lsl	w27,	w26,	#1
    sub	w24,	w13,	w27
    sub	w25,	w16,	w24
    cmp	w24,	#0
    movz	w12,	#0
    csel	w19,	w25,	w24,	lt
    asr	w6,	w13,	#31
    str	w19,	[sp, #316]

    lsr	w7,	w6,	#31
    add	w8,	w13,	w7
    asr	w8,	w8,	#1
    asr	w9,	w8,	#31
    lsr	w10,	w9,	#31
    add	w11,	w8,	w10
    asr	w13,	w11,	#1
    lsl	w14,	w13,	#1
    sub	w0,	w8,	w14
    sub	w1,	w12,	w0
    cmp	w0,	#0
    asr	w12,	w8,	#31
    csel	w24,	w1,	w0,	lt
    str	w24,	[sp, #320]

    lsr	w13,	w12,	#31
    add	w14,	w8,	w13
    movz	w8,	#0
    asr	w11,	w14,	#1
    asr	w15,	w11,	#31
    lsr	w16,	w15,	#31
    add	w17,	w11,	w16
    asr	w9,	w17,	#1
    lsl	w10,	w9,	#1
    sub	w4,	w11,	w10
    sub	w7,	w8,	w4
    cmp	w4,	#0
    csel	w0,	w7,	w4,	lt
    asr	w18,	w11,	#31
    str	w0,	[sp, #324]

    movz	w4,	#0
    lsr	w19,	w18,	#31
    add	w20,	w11,	w19
    asr	w10,	w20,	#1
    asr	w25,	w10,	#31
    lsr	w26,	w25,	#31
    add	w27,	w10,	w26
    asr	w14,	w27,	#1
    lsl	w15,	w14,	#1
    sub	w23,	w10,	w15
    sub	w24,	w4,	w23
    cmp	w23,	#0
    csel	w12,	w24,	w23,	lt
    asr	w28,	w10,	#31
    str	w12,	[sp, #592]

    lsr	w0,	w28,	#31
    add	w26,	w10,	w0
    movz	w0,	#0
    asr	w15,	w26,	#1
    asr	w1,	w15,	#31
    lsr	w2,	w1,	#31
    add	w3,	w15,	w2
    asr	w8,	w3,	#1
    lsl	w9,	w8,	#1
    sub	w28,	w15,	w9
    sub	w0,	w0,	w28
    cmp	w28,	#0
    asr	w4,	w15,	#31
    csel	w28,	w0,	w28,	lt
    movz	w25,	#0
    str	w28,	[sp, #636]

    lsr	w5,	w4,	#31
    add	w3,	w15,	w5
    asr	w18,	w3,	#1
    asr	w7,	w18,	#31
    lsr	w8,	w7,	#31
    add	w9,	w18,	w8
    asr	w4,	w9,	#1
    lsl	w5,	w4,	#1
    sub	w2,	w18,	w5
    sub	w5,	w25,	w2
    cmp	w2,	#0
    csel	w14,	w5,	w2,	lt
    asr	w10,	w18,	#31
    movz	w21,	#0
    str	w14,	[sp, #624]

    lsr	w11,	w10,	#31
    add	w9,	w18,	w11
    asr	w25,	w9,	#1
    asr	w13,	w25,	#31
    lsr	w14,	w13,	#31
    add	w15,	w25,	w14
    asr	w0,	w15,	#1
    lsl	w1,	w0,	#1
    sub	w7,	w25,	w1
    sub	w10,	w21,	w7
    cmp	w7,	#0
    csel	w9,	w10,	w7,	lt
    asr	w16,	w25,	#31
    str	w9,	[sp, #620]

    lsr	w17,	w16,	#31
    add	w15,	w25,	w17
    movz	w17,	#0
    asr	w0,	w15,	#1
    asr	w21,	w0,	#31
    lsr	w22,	w21,	#31
    add	w23,	w0,	w22
    asr	w26,	w23,	#1
    lsl	w27,	w26,	#1
    sub	w14,	w0,	w27
    sub	w17,	w17,	w14
    cmp	w14,	#0
    movz	w13,	#0
    asr	w24,	w0,	#31
    csel	w23,	w17,	w14,	lt
    lsr	w25,	w24,	#31
    str	w23,	[sp, #604]

    add	w21,	w0,	w25
    asr	w1,	w21,	#1
    asr	w22,	w1,	#31
    lsr	w23,	w22,	#31
    add	w24,	w1,	w23
    asr	w14,	w24,	#1
    lsl	w15,	w14,	#1
    sub	w6,	w1,	w15
    sub	w9,	w13,	w6
    cmp	w6,	#0
    csel	w6,	w9,	w6,	lt
    str	w6,	[sp, #760]

    ldr	w12,	[sp, #920]

    cmp	w12,	#0
    cset	w5,	ne
    ldr	w7,	[sp, #928]

    cmp	w7,	#0
    movz	w20,	#1
    ldr	w13,	[sp, #920]

    mov	w19,	w20
    csel	w4,	w19,	w5,	ne
    cmp	w13,	#0
    cset	w12,	ne
    str	w12,	[sp, #580]

    ldr	w23,	[sp, #928]

    cmp	w23,	#0
    movz	w11,	#0
    ldr	w2,	[sp, #580]

    csel	w19,	w2,	w11,	ne
    cmp	w19,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w15,	ne
    cmp	w4,	#0
    movz	w18,	#0
    mov	w17,	w18
    csel	w17,	w15,	w17,	ne
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w21,	ne
    ldr	w27,	[sp, #920]

    cmp	w27,	#0
    cset	w1,	ne
    ldr	w6,	[sp, #928]

    cmp	w6,	#0
    movz	w3,	#0
    mov	w2,	w3
    csel	w3,	w1,	w2,	ne
    cmp	w3,	#0
    ldr	w24,	[sp, #900]

    cset	w18,	ne
    cmp	w24,	#0
    ldr	w13,	[sp, #916]

    cset	w22,	ne
    mov	w23,	w22
    cmp	w13,	#0
    ldr	w25,	[sp, #900]

    movz	w10,	#1
    csel	w13,	w10,	w23,	ne
    cmp	w25,	#0
    cset	w4,	ne
    str	w4,	[sp, #584]

    ldr	w16,	[sp, #916]

    cmp	w16,	#0
    movz	w1,	#0
    ldr	w7,	[sp, #584]

    csel	w5,	w7,	w1,	ne
    cmp	w5,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w2,	ne
    cmp	w13,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w12,	w2,	w9,	ne
    str	w12,	[sp, #536]

    cmp	w18,	#0
    ldr	w13,	[sp, #536]

    cset	w6,	ne
    cmp	w13,	#0
    movz	w9,	#1
    mov	w8,	w9
    csel	w9,	w8,	w6,	ne
    str	w9,	[sp, #532]

    cmp	w18,	#0
    cset	w20,	ne
    ldr	w12,	[sp, #536]

    mov	w22,	w20
    cmp	w12,	#0
    movz	w10,	#0
    csel	w12,	w22,	w10,	ne
    cmp	w12,	#0
    cset	w14,	eq
    cmp	w14,	#0
    cset	w16,	ne
    ldr	w8,	[sp, #532]

    mov	w17,	w16
    cmp	w8,	#0
    movz	w5,	#0
    csel	w7,	w17,	w5,	ne
    str	w7,	[sp, #724]

    ldr	w26,	[sp, #900]

    cmp	w26,	#0
    ldr	w15,	[sp, #916]

    cset	w24,	ne
    mov	w25,	w24
    cmp	w15,	#0
    movz	w4,	#0
    csel	w16,	w25,	w4,	ne
    cmp	w18,	#0
    cset	w11,	ne
    ldr	w17,	[sp, #536]

    cmp	w17,	#0
    movz	w24,	#0
    mov	w23,	w24
    csel	w1,	w11,	w23,	ne
    cmp	w1,	#0
    cset	w15,	ne
    cmp	w16,	#0
    movz	w22,	#1
    ldr	w23,	[sp, #896]

    csel	w3,	w22,	w15,	ne
    cmp	w23,	#0
    cset	w19,	ne
    ldr	w0,	[sp, #904]

    mov	w20,	w19
    cmp	w0,	#0
    movz	w18,	#1
    ldr	w24,	[sp, #896]

    csel	w8,	w18,	w20,	ne
    cmp	w24,	#0
    cset	w25,	ne
    ldr	w1,	[sp, #904]

    mov	w26,	w25
    cmp	w1,	#0
    movz	w17,	#0
    csel	w12,	w26,	w17,	ne
    cmp	w12,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w1,	ne
    cmp	w8,	#0
    movz	w18,	#0
    mov	w17,	w18
    csel	w14,	w1,	w17,	ne
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w14,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w25,	w16,	w5,	ne
    cmp	w3,	#0
    cset	w7,	ne
    str	w7,	[sp, #588]

    cmp	w14,	#0
    movz	w1,	#0
    ldr	w10,	[sp, #588]

    csel	w8,	w10,	w1,	ne
    cmp	w8,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w15,	ne
    mov	w16,	w15
    cmp	w25,	#0
    movz	w13,	#0
    csel	w12,	w16,	w13,	ne
    str	w12,	[sp, #728]

    ldr	w25,	[sp, #896]

    cmp	w25,	#0
    ldr	w2,	[sp, #904]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w2,	#0
    movz	w12,	#0
    csel	w7,	w20,	w12,	ne
    cmp	w3,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w14,	#0
    movz	w11,	#0
    csel	w14,	w26,	w11,	ne
    cmp	w14,	#0
    cset	w0,	ne
    cmp	w7,	#0
    ldr	w17,	[sp, #892]

    movz	w11,	#1
    csel	w2,	w11,	w0,	ne
    cmp	w17,	#0
    cset	w3,	ne
    ldr	w9,	[sp, #772]

    cmp	w9,	#0
    movz	w11,	#1
    ldr	w18,	[sp, #892]

    mov	w10,	w11
    csel	w1,	w10,	w3,	ne
    cmp	w18,	#0
    ldr	w10,	[sp, #772]

    cset	w7,	ne
    cmp	w10,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w28,	w7,	w9,	ne
    cmp	w28,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    mov	w14,	w13
    cmp	w1,	#0
    movz	w7,	#0
    csel	w14,	w14,	w7,	ne
    cmp	w2,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w14,	#0
    movz	w6,	#1
    csel	w11,	w6,	w18,	ne
    cmp	w2,	#0
    cset	w9,	ne
    cmp	w14,	#0
    movz	w22,	#0
    mov	w20,	w22
    csel	w25,	w9,	w20,	ne
    cmp	w25,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    mov	w1,	w0
    cmp	w11,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w6,	w1,	w4,	ne
    str	w6,	[sp, #720]

    ldr	w19,	[sp, #892]

    cmp	w19,	#0
    ldr	w11,	[sp, #772]

    cset	w3,	ne
    cmp	w11,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w17,	w3,	w4,	ne
    cmp	w2,	#0
    cset	w7,	ne
    cmp	w14,	#0
    movz	w2,	#0
    csel	w0,	w7,	w2,	ne
    cmp	w0,	#0
    cset	w11,	ne
    cmp	w17,	#0
    movz	w1,	#1
    ldr	w27,	[sp, #740]

    csel	w23,	w1,	w11,	ne
    cmp	w27,	#0
    cset	w15,	ne
    ldr	w5,	[sp, #908]

    mov	w16,	w15
    cmp	w5,	#0
    ldr	w28,	[sp, #740]

    movz	w0,	#1
    csel	w17,	w0,	w16,	ne
    cmp	w28,	#0
    ldr	w6,	[sp, #908]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w6,	#0
    movz	w1,	#0
    mov	w0,	w1
    csel	w11,	w20,	w0,	ne
    cmp	w11,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w17,	#0
    movz	w0,	#0
    csel	w13,	w27,	w0,	ne
    cmp	w23,	#0
    cset	w1,	ne
    cmp	w13,	#0
    movz	w28,	#1
    mov	w27,	w28
    csel	w2,	w27,	w1,	ne
    cmp	w23,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w13,	#0
    movz	w11,	#0
    csel	w28,	w26,	w11,	ne
    cmp	w28,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w2,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w3,	w11,	w25,	ne
    str	w3,	[sp, #716]

    ldr	w0,	[sp, #740]

    cmp	w0,	#0
    ldr	w7,	[sp, #908]

    cset	w15,	ne
    cmp	w7,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w14,	w15,	w24,	ne
    cmp	w23,	#0
    cset	w19,	ne
    cmp	w13,	#0
    movz	w24,	#0
    csel	w11,	w19,	w24,	ne
    cmp	w11,	#0
    cset	w25,	ne
    cmp	w14,	#0
    ldr	w20,	[sp, #308]

    movz	w19,	#1
    csel	w15,	w19,	w25,	ne
    cmp	w20,	#0
    ldr	w11,	[sp, #912]

    cset	w0,	ne
    cmp	w11,	#0
    movz	w19,	#1
    ldr	w22,	[sp, #308]

    csel	w13,	w19,	w0,	ne
    cmp	w22,	#0
    ldr	w12,	[sp, #912]

    cset	w3,	ne
    cmp	w12,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w5,	w3,	w18,	ne
    cmp	w5,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w13,	#0
    movz	w18,	#0
    csel	w7,	w9,	w18,	ne
    cmp	w15,	#0
    cset	w13,	ne
    cmp	w7,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w4,	w16,	w13,	ne
    cmp	w15,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w7,	#0
    movz	w14,	#0
    csel	w19,	w18,	w14,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w4,	#0
    movz	w13,	#0
    csel	w0,	w26,	w13,	ne
    str	w0,	[sp, #712]

    ldr	w23,	[sp, #308]

    cmp	w23,	#0
    ldr	w13,	[sp, #912]

    cset	w0,	ne
    cmp	w13,	#0
    movz	w13,	#0
    csel	w23,	w0,	w13,	ne
    cmp	w15,	#0
    cset	w3,	ne
    cmp	w7,	#0
    movz	w13,	#0
    csel	w28,	w3,	w13,	ne
    cmp	w28,	#0
    cset	w7,	ne
    cmp	w23,	#0
    movz	w12,	#1
    ldr	w26,	[sp, #312]

    csel	w13,	w12,	w7,	ne
    cmp	w26,	#0
    cset	w11,	ne
    ldr	w2,	[sp, #744]

    cmp	w2,	#0
    movz	w9,	#1
    ldr	w27,	[sp, #312]

    csel	w10,	w9,	w11,	ne
    cmp	w27,	#0
    ldr	w3,	[sp, #744]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w3,	#0
    movz	w8,	#0
    csel	w17,	w16,	w8,	ne
    cmp	w17,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w23,	ne
    cmp	w10,	#0
    movz	w7,	#0
    csel	w0,	w23,	w7,	ne
    cmp	w13,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    movz	w6,	#1
    csel	w24,	w6,	w28,	ne
    cmp	w13,	#0
    cset	w1,	ne
    cmp	w0,	#0
    movz	w7,	#0
    mov	w6,	w7
    csel	w3,	w1,	w6,	ne
    cmp	w3,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w7,	ne
    cmp	w24,	#0
    movz	w4,	#0
    csel	w26,	w7,	w4,	ne
    str	w26,	[sp, #708]

    ldr	w28,	[sp, #312]

    cmp	w28,	#0
    ldr	w4,	[sp, #744]

    cset	w11,	ne
    cmp	w4,	#0
    movz	w3,	#0
    csel	w8,	w11,	w3,	ne
    cmp	w13,	#0
    cset	w15,	ne
    cmp	w0,	#0
    movz	w2,	#0
    csel	w12,	w15,	w2,	ne
    cmp	w12,	#0
    cset	w19,	ne
    cmp	w8,	#0
    ldr	w2,	[sp, #316]

    movz	w1,	#1
    csel	w16,	w1,	w19,	ne
    cmp	w2,	#0
    cset	w25,	ne
    ldr	w27,	[sp, #924]

    cmp	w27,	#0
    movz	w0,	#1
    ldr	w3,	[sp, #316]

    csel	w8,	w0,	w25,	ne
    cmp	w3,	#0
    ldr	w28,	[sp, #924]

    cset	w0,	ne
    mov	w1,	w0
    cmp	w28,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w1,	w1,	w28,	ne
    cmp	w1,	#0
    cset	w3,	eq
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w8,	#0
    movz	w0,	#0
    csel	w7,	w5,	w0,	ne
    cmp	w16,	#0
    cset	w9,	ne
    cmp	w7,	#0
    movz	w28,	#1
    csel	w20,	w28,	w9,	ne
    cmp	w16,	#0
    cset	w13,	ne
    cmp	w7,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w15,	w13,	w26,	ne
    cmp	w15,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w20,	#0
    movz	w26,	#0
    csel	w23,	w19,	w26,	ne
    str	w23,	[sp, #704]

    ldr	w4,	[sp, #316]

    cmp	w4,	#0
    ldr	w0,	[sp, #924]

    cset	w25,	ne
    cmp	w0,	#0
    movz	w23,	#0
    csel	w28,	w25,	w23,	ne
    cmp	w16,	#0
    cset	w0,	ne
    cmp	w7,	#0
    movz	w22,	#0
    csel	w26,	w0,	w22,	ne
    cmp	w26,	#0
    cset	w3,	ne
    cmp	w28,	#0
    ldr	w7,	[sp, #320]

    movz	w22,	#1
    csel	w24,	w22,	w3,	ne
    cmp	w7,	#0
    cset	w7,	ne
    ldr	w14,	[sp, #516]

    cmp	w14,	#0
    ldr	w8,	[sp, #320]

    movz	w20,	#1
    csel	w12,	w20,	w7,	ne
    cmp	w8,	#0
    cset	w11,	ne
    ldr	w15,	[sp, #516]

    cmp	w15,	#0
    movz	w19,	#0
    csel	w13,	w11,	w19,	ne
    cmp	w13,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    cmp	w12,	#0
    movz	w16,	#0
    csel	w13,	w17,	w16,	ne
    cmp	w24,	#0
    cset	w23,	ne
    cmp	w13,	#0
    movz	w15,	#1
    csel	w5,	w15,	w23,	ne
    cmp	w24,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w13,	#0
    movz	w14,	#0
    csel	w0,	w28,	w14,	ne
    cmp	w0,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w3,	ne
    cmp	w5,	#0
    movz	w15,	#0
    csel	w19,	w3,	w15,	ne
    str	w19,	[sp, #700]

    ldr	w9,	[sp, #320]

    cmp	w9,	#0
    ldr	w16,	[sp, #516]

    cset	w7,	ne
    cmp	w16,	#0
    movz	w14,	#0
    csel	w16,	w7,	w14,	ne
    cmp	w24,	#0
    cset	w11,	ne
    cmp	w13,	#0
    movz	w13,	#0
    csel	w9,	w11,	w13,	ne
    cmp	w9,	#0
    cset	w15,	ne
    cmp	w16,	#0
    ldr	w12,	[sp, #324]

    movz	w10,	#1
    csel	w2,	w10,	w15,	ne
    cmp	w12,	#0
    cset	w19,	ne
    ldr	w14,	[sp, #732]

    cmp	w14,	#0
    ldr	w13,	[sp, #324]

    movz	w9,	#1
    csel	w26,	w9,	w19,	ne
    cmp	w13,	#0
    ldr	w15,	[sp, #732]

    cset	w25,	ne
    cmp	w15,	#0
    movz	w8,	#0
    csel	w24,	w25,	w8,	ne
    cmp	w24,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w1,	ne
    cmp	w26,	#0
    movz	w9,	#0
    csel	w22,	w1,	w9,	ne
    cmp	w2,	#0
    cset	w5,	ne
    cmp	w22,	#0
    movz	w8,	#1
    csel	w19,	w8,	w5,	ne
    cmp	w2,	#0
    cset	w9,	ne
    mov	w10,	w9
    cmp	w22,	#0
    movz	w5,	#0
    csel	w11,	w10,	w5,	ne
    cmp	w11,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w15,	ne
    cmp	w19,	#0
    movz	w4,	#0
    csel	w16,	w15,	w4,	ne
    str	w16,	[sp, #696]

    ldr	w14,	[sp, #324]

    cmp	w14,	#0
    ldr	w16,	[sp, #732]

    cset	w19,	ne
    cmp	w16,	#0
    movz	w3,	#0
    csel	w3,	w19,	w3,	ne
    cmp	w2,	#0
    cset	w25,	ne
    cmp	w22,	#0
    movz	w2,	#0
    csel	w26,	w25,	w2,	ne
    cmp	w26,	#0
    cset	w0,	ne
    cmp	w3,	#0
    ldr	w12,	[sp, #592]

    movz	w2,	#1
    csel	w16,	w2,	w0,	ne
    cmp	w12,	#0
    cset	w3,	ne
    ldr	w20,	[sp, #736]

    cmp	w20,	#0
    movz	w0,	#1
    ldr	w15,	[sp, #592]

    csel	w14,	w0,	w3,	ne
    cmp	w15,	#0
    ldr	w22,	[sp, #736]

    cset	w7,	ne
    cmp	w22,	#0
    movz	w1,	#0
    csel	w7,	w7,	w1,	ne
    cmp	w7,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    cmp	w14,	#0
    movz	w0,	#0
    csel	w11,	w13,	w0,	ne
    cmp	w16,	#0
    cset	w17,	ne
    cmp	w11,	#0
    movz	w28,	#1
    csel	w13,	w28,	w17,	ne
    cmp	w16,	#0
    cset	w23,	ne
    cmp	w11,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w25,	w23,	w26,	ne
    cmp	w25,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w13,	#0
    movz	w25,	#0
    csel	w13,	w0,	w25,	ne
    str	w13,	[sp, #936]

    ldr	w17,	[sp, #592]

    cmp	w17,	#0
    cset	w3,	ne
    ldr	w23,	[sp, #736]

    cmp	w23,	#0
    movz	w25,	#0
    csel	w20,	w3,	w25,	ne
    cmp	w16,	#0
    cset	w7,	ne
    cmp	w11,	#0
    movz	w24,	#0
    csel	w8,	w7,	w24,	ne
    cmp	w8,	#0
    cset	w11,	ne
    cmp	w20,	#0
    movz	w22,	#1
    ldr	w1,	[sp, #636]

    csel	w14,	w22,	w11,	ne
    cmp	w1,	#0
    cset	w15,	ne
    ldr	w27,	[sp, #764]

    cmp	w27,	#0
    movz	w20,	#1
    ldr	w4,	[sp, #636]

    csel	w18,	w20,	w15,	ne
    cmp	w4,	#0
    cset	w19,	ne
    ldr	w28,	[sp, #764]

    cmp	w28,	#0
    movz	w17,	#0
    csel	w19,	w19,	w17,	ne
    cmp	w19,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w18,	#0
    movz	w16,	#0
    csel	w25,	w27,	w16,	ne
    cmp	w14,	#0
    cset	w1,	ne
    cmp	w25,	#0
    movz	w17,	#1
    csel	w3,	w17,	w1,	ne
    cmp	w14,	#0
    cset	w5,	ne
    cmp	w25,	#0
    movz	w16,	#0
    csel	w27,	w5,	w16,	ne
    cmp	w27,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w3,	#0
    movz	w15,	#0
    csel	w10,	w11,	w15,	ne
    str	w10,	[sp, #932]

    ldr	w5,	[sp, #636]

    cmp	w5,	#0
    ldr	w0,	[sp, #764]

    cset	w15,	ne
    cmp	w0,	#0
    movz	w12,	#0
    csel	w1,	w15,	w12,	ne
    cmp	w14,	#0
    cset	w19,	ne
    cmp	w25,	#0
    movz	w11,	#0
    csel	w24,	w19,	w11,	ne
    cmp	w24,	#0
    cset	w25,	ne
    cmp	w1,	#0
    movz	w10,	#1
    ldr	w17,	[sp, #624]

    csel	w22,	w10,	w25,	ne
    cmp	w17,	#0
    cset	w0,	ne
    ldr	w4,	[sp, #768]

    cmp	w4,	#0
    movz	w10,	#1
    ldr	w20,	[sp, #624]

    csel	w0,	w10,	w0,	ne
    cmp	w20,	#0
    cset	w3,	ne
    ldr	w5,	[sp, #768]

    cmp	w5,	#0
    movz	w10,	#0
    csel	w4,	w3,	w10,	ne
    cmp	w4,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w0,	#0
    movz	w7,	#0
    csel	w14,	w9,	w7,	ne
    cmp	w22,	#0
    cset	w13,	ne
    cmp	w14,	#0
    movz	w6,	#1
    csel	w26,	w6,	w13,	ne
    cmp	w22,	#0
    cset	w17,	ne
    cmp	w14,	#0
    movz	w5,	#0
    csel	w13,	w17,	w5,	ne
    cmp	w13,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    cmp	w26,	#0
    movz	w4,	#0
    ldr	w0,	[sp, #624]

    csel	w4,	w25,	w4,	ne
    cmp	w0,	#0
    cset	w1,	ne
    ldr	w9,	[sp, #768]

    cmp	w9,	#0
    movz	w5,	#0
    csel	w7,	w1,	w5,	ne
    cmp	w22,	#0
    cset	w3,	ne
    cmp	w14,	#0
    movz	w2,	#0
    csel	w8,	w3,	w2,	ne
    cmp	w8,	#0
    cset	w8,	ne
    cmp	w7,	#0
    ldr	w15,	[sp, #620]

    movz	w1,	#1
    csel	w25,	w1,	w8,	ne
    cmp	w15,	#0
    cset	w12,	ne
    ldr	w14,	[sp, #752]

    cmp	w14,	#0
    ldr	w20,	[sp, #620]

    movz	w0,	#1
    csel	w5,	w0,	w12,	ne
    cmp	w20,	#0
    cset	w16,	ne
    ldr	w14,	[sp, #752]

    cmp	w14,	#0
    movz	w2,	#0
    csel	w17,	w16,	w2,	ne
    cmp	w17,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w24,	ne
    cmp	w5,	#0
    movz	w1,	#0
    csel	w14,	w24,	w1,	ne
    cmp	w25,	#0
    cset	w28,	ne
    cmp	w14,	#0
    movz	w27,	#1
    csel	w0,	w27,	w28,	ne
    cmp	w25,	#0
    cset	w1,	ne
    cmp	w14,	#0
    movz	w27,	#0
    csel	w2,	w1,	w27,	ne
    cmp	w2,	#0
    cset	w6,	eq
    cmp	w6,	#0
    cset	w8,	ne
    cmp	w0,	#0
    movz	w27,	#0
    csel	w2,	w8,	w27,	ne
    ldr	w8,	[sp, #620]

    cmp	w8,	#0
    ldr	w22,	[sp, #752]

    cset	w13,	ne
    cmp	w22,	#0
    movz	w26,	#0
    csel	w18,	w13,	w26,	ne
    cmp	w25,	#0
    cset	w17,	ne
    cmp	w14,	#0
    movz	w26,	#0
    csel	w22,	w17,	w26,	ne
    cmp	w22,	#0
    cset	w22,	ne
    cmp	w18,	#0
    movz	w24,	#1
    ldr	w3,	[sp, #604]

    csel	w8,	w24,	w22,	ne
    cmp	w3,	#0
    cset	w27,	ne
    ldr	w24,	[sp, #756]

    cmp	w24,	#0
    movz	w20,	#1
    ldr	w19,	[sp, #604]

    csel	w1,	w20,	w27,	ne
    cmp	w19,	#0
    cset	w5,	ne
    ldr	w26,	[sp, #756]

    cmp	w26,	#0
    movz	w19,	#0
    csel	w12,	w5,	w19,	ne
    cmp	w12,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w7,	ne
    cmp	w1,	#0
    movz	w20,	#0
    csel	w7,	w7,	w20,	ne
    cmp	w8,	#0
    cset	w11,	ne
    cmp	w7,	#0
    movz	w18,	#1
    csel	w14,	w18,	w11,	ne
    cmp	w8,	#0
    cset	w15,	ne
    cmp	w7,	#0
    movz	w17,	#0
    csel	w26,	w15,	w17,	ne
    cmp	w26,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w14,	#0
    ldr	w9,	[sp, #604]

    movz	w15,	#0
    csel	w6,	w22,	w15,	ne
    cmp	w9,	#0
    ldr	w26,	[sp, #756]

    cset	w28,	ne
    cmp	w26,	#0
    movz	w14,	#0
    csel	w1,	w28,	w14,	ne
    cmp	w8,	#0
    cset	w5,	ne
    cmp	w7,	#0
    movz	w13,	#0
    csel	w16,	w5,	w13,	ne
    cmp	w16,	#0
    cset	w5,	ne
    cmp	w1,	#0
    ldr	w25,	[sp, #760]

    movz	w14,	#1
    csel	w24,	w14,	w5,	ne
    cmp	w25,	#0
    ldr	w15,	[sp, #748]

    cset	w9,	ne
    cmp	w15,	#0
    ldr	w26,	[sp, #760]

    movz	w12,	#1
    csel	w28,	w12,	w9,	ne
    cmp	w26,	#0
    cset	w14,	ne
    ldr	w16,	[sp, #748]

    cmp	w16,	#0
    movz	w10,	#0
    csel	w1,	w14,	w10,	ne
    cmp	w1,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w28,	#0
    movz	w9,	#0
    csel	w7,	w19,	w9,	ne
    cmp	w24,	#0
    cset	w26,	ne
    cmp	w7,	#0
    movz	w8,	#1
    csel	w13,	w8,	w26,	ne
    cmp	w24,	#0
    cset	w1,	ne
    cmp	w7,	#0
    movz	w7,	#0
    csel	w18,	w1,	w7,	ne
    cmp	w18,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w5,	ne
    cmp	w13,	#0
    movz	w8,	#0
    csel	w17,	w5,	w8,	ne
    lsl	w18,	w17,	#1
    add	w19,	w18,	w6
    lsl	w20,	w19,	#1
    add	w17,	w20,	w2
    lsl	w18,	w17,	#1
    add	w11,	w18,	w4
    lsl	w13,	w11,	#1
    ldr	w11,	[sp, #932]

    ldr	w14,	[sp, #936]

    add	w13,	w13,	w11
    ldr	w17,	[sp, #696]

    ldr	w20,	[sp, #700]

    lsl	w15,	w13,	#1
    ldr	w24,	[sp, #704]

    ldr	w27,	[sp, #708]

    add	w15,	w15,	w14
    ldr	w1,	[sp, #712]

    ldr	w4,	[sp, #716]

    ldr	w7,	[sp, #720]

    lsl	w16,	w15,	#1
    ldr	w13,	[sp, #728]

    ldr	w10,	[sp, #724]

    add	w17,	w16,	w17
    lsl	w18,	w17,	#1
    add	w19,	w18,	w20
    lsl	w20,	w19,	#1
    add	w23,	w20,	w24
    lsl	w24,	w23,	#1
    add	w25,	w24,	w27
    lsl	w27,	w25,	#1
    add	w27,	w27,	w1
    lsl	w0,	w27,	#1
    add	w0,	w0,	w4
    lsl	w0,	w0,	#1
    add	w1,	w0,	w7
    lsl	w2,	w1,	#1
    add	w3,	w2,	w13
    lsl	w4,	w3,	#1
    add	w5,	w4,	w10
    lsl	w6,	w5,	#1
    add	w0,	w6,	w21
    b	fib_1892

fib_1891:
    movz	w0,	#1

fib_1892:
    movz	w17,	#1
    movz	fp,	#508
    ldr	x22,	[sp, fp]

    movz	fp,	#500
    str	w17,	[x22]

    ldr	x16,	[sp, fp]

    ldr	w21,	[sp, #336]

    str	w21,	[x16]

    ldr	x16,	[sp, #328]

    add	x11,	x16,	#4
    str	w0,	[x11]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1136
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w20,	#1

main_1:
    cmp	w20,	#16
    bge	main_23

main_4:
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w20
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w20
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w20,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w23
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w23
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w25,	w23,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w25
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w25
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w27,	w25,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w27
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w27
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w19,	w27,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w19
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w19
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#102
    add	w21,	w19,	#1
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w21
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w21
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#102
    add	w23,	w21,	#1
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w23
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w23
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w25,	w23,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w25
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w25
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w25,	#1
    b	main_1

main_23:
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w20
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w20
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w20,	#1
    cmp	w20,	#20
    ble	main_23

main_28:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


