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
    sub	sp, sp, #1200
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	x5,	#40763
    movz	x7,	#40763
    mov	w21,	w0
    movz	fp,	#540
    movz	x27,	#65535
    adrp	x12, :got:memo.lut.fib
    movk	x5,	#1117,	lsl #16
    movk	x7,	#1117,	lsl #16
    lsr	w9,	w21,	#16
    eor	w1,	w21,	w9
    mul	w2,	w1,	w7
    lsr	w13,	w2,	#16
    eor	w4,	w2,	w13
    mul	w5,	w4,	w5
    lsr	w16,	w5,	#16
    eor	w16,	w5,	w16
    str	w16,	[sp, #548]

    ldr	w16,	[sp, #548]

    ldr	x12, [x12, #:got_lo12:memo.lut.fib]
    and	w17,	w16,	w27
    lsl	w18,	w17,	#3
    lsl	w22,	w18,	#0
    add	x10,	x12,	x22
    str	x10,	[sp, fp]

    movz	fp,	#540
    ldr	x11,	[sp, fp]

    movz	fp,	#532
    mov	x6,	x11
    str	x6,	[sp, fp]

    movz	fp,	#532
    ldr	x7,	[sp, fp]

    movz	fp,	#540
    ldr	w17,	[x7]

    ldr	x11,	[sp, fp]

    add	x3,	x11,	#8
    cmp	w17,	#0
    beq	fib_25

fib_17:
    ldr	w20,	[x3]

    ldr	w0,	[sp, #548]

    cmp	w20,	w0
    bne	fib_27

fib_21:
    movz	fp,	#540
    ldr	x13,	[sp, fp]

    add	x1,	x13,	#4
    ldr	w0,	[x1]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1200
    ret


fib_27:
    mov	x2,	x3
    movz	fp,	#524
    str	x2,	[sp, fp]

    b	fib_28

fib_25:
    movz	fp,	#524
    str	x3,	[sp, fp]


fib_28:
    cmp	w21,	#2
    ble	fib_1891

fib_31:
    asr	w24,	w21,	#31
    movz	w22,	#0
    lsr	w0,	w24,	#31
    add	w25,	w21,	w0
    asr	w23,	w25,	#1
    lsl	w24,	w23,	#1
    sub	w20,	w21,	w24
    str	w20,	[sp, #496]

    ldr	w23,	[sp, #496]

    sub	w23,	w22,	w23
    str	w23,	[sp, #724]

    ldr	w23,	[sp, #496]

    cmp	w23,	#0
    ldr	w26,	[sp, #724]

    ldr	w24,	[sp, #496]

    csel	w22,	w26,	w24,	lt
    asr	w26,	w21,	#31
    str	w22,	[sp, #808]

    lsr	w27,	w26,	#31
    movz	w26,	#0
    add	w28,	w21,	w27
    asr	w28,	w28,	#1
    asr	w0,	w28,	#31
    lsr	w19,	w0,	#31
    add	w20,	w28,	w19
    asr	w0,	w20,	#1
    lsl	w19,	w0,	#1
    sub	w23,	w28,	w19
    str	w23,	[sp, #508]

    ldr	w0,	[sp, #508]

    sub	w19,	w26,	w0
    str	w19,	[sp, #436]

    ldr	w24,	[sp, #508]

    cmp	w24,	#0
    asr	w20,	w28,	#31
    ldr	w24,	[sp, #436]

    ldr	w25,	[sp, #508]

    lsr	w21,	w20,	#31
    csel	w24,	w24,	w25,	lt
    str	w24,	[sp, #804]

    add	w0,	w28,	w21
    asr	w22,	w0,	#1
    movz	w0,	#0
    asr	w23,	w22,	#31
    lsr	w24,	w23,	#31
    add	w25,	w22,	w24
    asr	w23,	w25,	#1
    lsl	w24,	w23,	#1
    sub	w28,	w22,	w24
    str	w28,	[sp, #512]

    ldr	w21,	[sp, #512]

    sub	w28,	w0,	w21
    str	w28,	[sp, #452]

    ldr	w18,	[sp, #512]

    cmp	w18,	#0
    asr	w26,	w22,	#31
    ldr	w0,	[sp, #452]

    ldr	w19,	[sp, #512]

    lsr	w27,	w26,	#31
    csel	w20,	w0,	w19,	lt
    str	w20,	[sp, #812]

    add	w28,	w22,	w27
    asr	w26,	w28,	#1
    asr	w0,	w26,	#31
    lsr	w18,	w0,	#31
    movz	w0,	#0
    add	w19,	w26,	w18
    asr	w19,	w19,	#1
    lsl	w20,	w19,	#1
    sub	w22,	w26,	w20
    str	w22,	[sp, #520]

    ldr	w27,	[sp, #520]

    sub	w23,	w0,	w27
    str	w23,	[sp, #464]

    ldr	w0,	[sp, #520]

    cmp	w0,	#0
    asr	w19,	w26,	#31
    ldr	w21,	[sp, #464]

    ldr	w24,	[sp, #520]

    csel	w24,	w21,	w24,	lt
    str	w24,	[sp, #816]

    lsr	w21,	w19,	#31
    movz	w19,	#0
    add	w0,	w26,	w21
    asr	w21,	w0,	#1
    asr	w23,	w21,	#31
    lsr	w24,	w23,	#31
    add	w25,	w21,	w24
    asr	w26,	w25,	#1
    lsl	w27,	w26,	#1
    sub	w26,	w21,	w27
    str	w26,	[sp, #516]

    ldr	w18,	[sp, #516]

    sub	w27,	w19,	w18
    str	w27,	[sp, #476]

    ldr	w28,	[sp, #516]

    cmp	w28,	#0
    ldr	w18,	[sp, #476]

    asr	w26,	w21,	#31
    ldr	w0,	[sp, #516]

    lsr	w28,	w26,	#31
    csel	w18,	w18,	w0,	lt
    str	w18,	[sp, #1004]

    add	w18,	w21,	w28
    asr	w23,	w18,	#1
    movz	w18,	#0
    asr	w19,	w23,	#31
    lsr	w20,	w19,	#31
    add	w21,	w23,	w20
    asr	w19,	w21,	#1
    lsl	w20,	w19,	#1
    sub	w19,	w23,	w20
    str	w19,	[sp, #500]

    ldr	w24,	[sp, #500]

    sub	w24,	w18,	w24
    str	w24,	[sp, #488]

    ldr	w21,	[sp, #500]

    cmp	w21,	#0
    ldr	w25,	[sp, #488]

    asr	w21,	w23,	#31
    ldr	w22,	[sp, #500]

    lsr	w24,	w21,	#31
    csel	w20,	w25,	w22,	lt
    str	w20,	[sp, #824]

    add	w18,	w23,	w24
    asr	w18,	w18,	#1
    asr	w25,	w18,	#31
    lsr	w26,	w25,	#31
    add	w28,	w18,	w26
    asr	w25,	w28,	#1
    lsl	w26,	w25,	#1
    sub	w25,	w18,	w26
    movz	w26,	#0
    str	w25,	[sp, #492]

    ldr	w27,	[sp, #492]

    sub	w21,	w26,	w27
    str	w21,	[sp, #480]

    ldr	w27,	[sp, #492]

    cmp	w27,	#0
    ldr	w21,	[sp, #480]

    asr	w20,	w18,	#31
    ldr	w28,	[sp, #492]

    csel	w28,	w21,	w28,	lt
    str	w28,	[sp, #820]

    lsr	w21,	w20,	#31
    add	w18,	w18,	w21
    asr	w27,	w18,	#1
    asr	w25,	w27,	#31
    lsr	w26,	w25,	#31
    add	w28,	w27,	w26
    asr	w21,	w28,	#1
    movz	w28,	#0
    lsl	w18,	w21,	#1
    sub	w18,	w27,	w18
    str	w18,	[sp, #484]

    ldr	w18,	[sp, #484]

    sub	w18,	w28,	w18
    str	w18,	[sp, #468]

    ldr	w28,	[sp, #484]

    cmp	w28,	#0
    ldr	w19,	[sp, #468]

    ldr	w18,	[sp, #484]

    csel	w24,	w19,	w18,	lt
    asr	w18,	w27,	#31
    str	w24,	[sp, #828]

    lsr	w25,	w18,	#31
    movz	w18,	#0
    add	w28,	w27,	w25
    asr	w19,	w28,	#1
    asr	w20,	w19,	#31
    lsr	w23,	w20,	#31
    add	w24,	w19,	w23
    asr	w20,	w24,	#1
    lsl	w23,	w20,	#1
    sub	w24,	w19,	w23
    str	w24,	[sp, #472]

    ldr	w24,	[sp, #472]

    sub	w27,	w18,	w24
    str	w27,	[sp, #456]

    ldr	w26,	[sp, #472]

    cmp	w26,	#0
    movz	w21,	#0
    ldr	w18,	[sp, #456]

    ldr	w26,	[sp, #472]

    csel	w24,	w18,	w26,	lt
    asr	w18,	w19,	#31
    str	w24,	[sp, #840]

    lsr	w20,	w18,	#31
    add	w20,	w19,	w20
    asr	w18,	w20,	#1
    asr	w24,	w18,	#31
    lsr	w19,	w24,	#31
    add	w20,	w18,	w19
    asr	w20,	w20,	#1
    lsl	w23,	w20,	#1
    sub	w20,	w18,	w23
    str	w20,	[sp, #460]

    ldr	w19,	[sp, #460]

    sub	w23,	w21,	w19
    str	w23,	[sp, #444]

    ldr	w22,	[sp, #460]

    cmp	w22,	#0
    movz	w28,	#0
    asr	w23,	w18,	#31
    ldr	w24,	[sp, #444]

    ldr	w19,	[sp, #460]

    csel	w25,	w24,	w19,	lt
    str	w25,	[sp, #856]

    lsr	w24,	w23,	#31
    add	w21,	w18,	w24
    asr	w22,	w21,	#1
    asr	w27,	w22,	#31
    lsr	w19,	w27,	#31
    add	w24,	w22,	w19
    asr	w27,	w24,	#1
    lsl	w19,	w27,	#1
    sub	w27,	w22,	w19
    str	w27,	[sp, #448]

    ldr	w20,	[sp, #448]

    sub	w28,	w28,	w20
    str	w28,	[sp, #432]

    ldr	w27,	[sp, #448]

    cmp	w27,	#0
    ldr	w18,	[sp, #432]

    movz	w20,	#0
    ldr	w25,	[sp, #448]

    csel	w27,	w18,	w25,	lt
    asr	w18,	w22,	#31
    str	w27,	[sp, #128]

    lsr	w27,	w18,	#31
    add	w18,	w22,	w27
    asr	w23,	w18,	#1
    asr	w24,	w23,	#31
    lsr	w18,	w24,	#31
    add	w27,	w23,	w18
    mov	w18,	w20
    asr	w27,	w27,	#1
    lsl	w22,	w27,	#1
    sub	w27,	w23,	w22
    str	w27,	[sp, #440]

    ldr	w21,	[sp, #440]

    sub	w28,	w18,	w21
    str	w28,	[sp, #728]

    ldr	w27,	[sp, #440]

    cmp	w27,	#0
    asr	w22,	w23,	#31
    ldr	w18,	[sp, #728]

    movz	w21,	#0
    ldr	w25,	[sp, #440]

    lsr	w24,	w22,	#31
    csel	w26,	w18,	w25,	lt
    str	w26,	[sp, #180]

    add	w25,	w23,	w24
    asr	w18,	w25,	#1
    mov	w25,	w21
    asr	w20,	w18,	#31
    lsr	w23,	w20,	#31
    add	w24,	w18,	w23
    asr	w20,	w24,	#1
    lsl	w23,	w20,	#1
    sub	w23,	w18,	w23
    str	w23,	[sp, #428]

    ldr	w28,	[sp, #428]

    sub	w26,	w25,	w28
    str	w26,	[sp, #716]

    ldr	w25,	[sp, #428]

    cmp	w25,	#0
    ldr	w27,	[sp, #716]

    ldr	w19,	[sp, #428]

    csel	w21,	w27,	w19,	lt
    asr	w27,	w18,	#31
    str	w21,	[sp, #196]

    lsr	w20,	w27,	#31
    add	w28,	w18,	w20
    asr	w26,	w28,	#1
    asr	w22,	w26,	#31
    lsr	w18,	w22,	#31
    add	w27,	w26,	w18
    movz	w18,	#0
    asr	w27,	w27,	#1
    lsl	w19,	w27,	#1
    sub	w28,	w26,	w19
    str	w28,	[sp, #720]

    ldr	w19,	[sp, #720]

    mov	w28,	w18
    sub	w25,	w28,	w19
    str	w25,	[sp, #708]

    ldr	w19,	[sp, #720]

    cmp	w19,	#0
    ldr	w27,	[sp, #708]

    asr	w19,	w26,	#31
    movz	w25,	#0
    ldr	w21,	[sp, #720]

    lsr	w22,	w19,	#31
    csel	w24,	w27,	w21,	lt
    str	w24,	[sp, #664]

    add	w20,	w26,	w22
    asr	w22,	w20,	#1
    mov	w20,	w25
    asr	w27,	w22,	#31
    lsr	w23,	w27,	#31
    add	w24,	w22,	w23
    asr	w27,	w24,	#1
    lsl	w23,	w27,	#1
    sub	w28,	w22,	w23
    str	w28,	[sp, #712]

    ldr	w18,	[sp, #712]

    sub	w26,	w20,	w18
    str	w26,	[sp, #700]

    ldr	w20,	[sp, #712]

    cmp	w20,	#0
    asr	w18,	w22,	#31
    ldr	w27,	[sp, #700]

    ldr	w20,	[sp, #712]

    csel	w28,	w27,	w20,	lt
    str	w28,	[sp, #684]

    lsr	w27,	w18,	#31
    add	w21,	w22,	w27
    asr	w20,	w21,	#1
    asr	w18,	w20,	#31
    lsr	w25,	w18,	#31
    add	w28,	w20,	w25
    asr	w18,	w28,	#1
    movz	w28,	#0
    lsl	w25,	w18,	#1
    mov	w21,	w28
    sub	w18,	w20,	w25
    str	w18,	[sp, #704]

    ldr	w18,	[sp, #704]

    sub	w22,	w21,	w18
    str	w22,	[sp, #696]

    ldr	w20,	[sp, #704]

    cmp	w20,	#0
    ldr	w23,	[sp, #696]

    ldr	w20,	[sp, #704]

    csel	w28,	w23,	w20,	lt
    str	w28,	[sp, #680]

    ldr	w0,	[sp, #808]

    cmp	w0,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w18,	eq
    mov	w25,	w18
    cmp	w25,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w21,	ne
    mov	w18,	w21
    cmp	w18,	#0
    cset	w25,	ne
    mov	w24,	w25
    str	w24,	[sp, #688]

    ldr	w18,	[sp, #808]

    cmp	w18,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w18,	ne
    mov	w25,	w18
    ldr	w18,	[sp, #804]

    cmp	w18,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w22,	#0
    cset	w23,	eq
    mov	w18,	w23
    cmp	w18,	#0
    cset	w22,	ne
    mov	w23,	w22
    str	w23,	[sp, #96]

    cmp	w25,	#0
    ldr	w20,	[sp, #96]

    cset	w18,	ne
    mov	w19,	w18
    cmp	w20,	#0
    movz	w27,	#1
    mov	w26,	w27
    csel	w23,	w26,	w19,	ne
    str	w23,	[sp, #832]

    cmp	w25,	#0
    cset	w18,	ne
    mov	w20,	w18
    str	w20,	[sp, #164]

    ldr	w26,	[sp, #96]

    cmp	w26,	#0
    movz	w18,	#0
    ldr	w24,	[sp, #164]

    mov	w22,	w18
    csel	w23,	w24,	w22,	ne
    cmp	w23,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    ldr	w27,	[sp, #832]

    cset	w22,	ne
    mov	w23,	w22
    cmp	w27,	#0
    movz	w21,	#0
    mov	w26,	w21
    csel	w20,	w23,	w26,	ne
    str	w20,	[sp, #672]

    ldr	w19,	[sp, #804]

    cmp	w19,	#0
    cset	w22,	ne
    cmp	w25,	#0
    cset	w18,	ne
    mov	w20,	w18
    ldr	w18,	[sp, #96]

    cmp	w18,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w24,	w20,	w18,	ne
    cmp	w24,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w22,	#0
    movz	w22,	#1
    csel	w19,	w22,	w24,	ne
    str	w19,	[sp, #836]

    ldr	w21,	[sp, #812]

    cmp	w21,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w21,	eq
    mov	w18,	w21
    cmp	w18,	#0
    cset	w25,	ne
    mov	w26,	w25
    str	w26,	[sp, #368]

    ldr	w20,	[sp, #836]

    cmp	w20,	#0
    ldr	w0,	[sp, #368]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w0,	#0
    movz	w18,	#1
    mov	w19,	w18
    csel	w23,	w19,	w21,	ne
    str	w23,	[sp, #124]

    ldr	w21,	[sp, #836]

    cmp	w21,	#0
    ldr	w18,	[sp, #368]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w18,	#0
    movz	w24,	#0
    mov	w27,	w24
    csel	w18,	w20,	w27,	ne
    cmp	w18,	#0
    cset	w25,	eq
    mov	w28,	w25
    cmp	w28,	#0
    cset	w20,	ne
    ldr	w25,	[sp, #124]

    mov	w21,	w20
    cmp	w25,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w26,	w21,	w18,	ne
    str	w26,	[sp, #208]

    ldr	w22,	[sp, #812]

    cmp	w22,	#0
    cset	w28,	ne
    ldr	w18,	[sp, #836]

    mov	w20,	w28
    cmp	w18,	#0
    ldr	w27,	[sp, #368]

    cset	w19,	ne
    mov	w24,	w19
    cmp	w27,	#0
    movz	w18,	#0
    mov	w22,	w18
    csel	w27,	w24,	w22,	ne
    cmp	w27,	#0
    cset	w19,	ne
    mov	w24,	w19
    cmp	w20,	#0
    movz	w18,	#1
    mov	w19,	w18
    csel	w20,	w19,	w24,	ne
    str	w20,	[sp, #792]

    ldr	w25,	[sp, #816]

    cmp	w25,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w21,	eq
    mov	w18,	w21
    cmp	w18,	#0
    cset	w25,	ne
    mov	w18,	w25
    str	w18,	[sp, #776]

    ldr	w21,	[sp, #792]

    cmp	w21,	#0
    ldr	w26,	[sp, #776]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w26,	#0
    movz	w27,	#1
    ldr	w22,	[sp, #792]

    csel	w23,	w27,	w21,	ne
    cmp	w22,	#0
    ldr	w27,	[sp, #776]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w27,	#0
    movz	w19,	#0
    csel	w18,	w20,	w19,	ne
    cmp	w18,	#0
    cset	w25,	eq
    mov	w28,	w25
    cmp	w28,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w23,	#0
    movz	w18,	#0
    mov	w25,	w18
    csel	w25,	w22,	w25,	ne
    str	w25,	[sp, #172]

    ldr	w26,	[sp, #816]

    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    str	w19,	[sp, #872]

    ldr	w23,	[sp, #792]

    cmp	w23,	#0
    cset	w21,	ne
    ldr	w28,	[sp, #776]

    mov	w22,	w21
    cmp	w28,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w28,	w22,	w18,	ne
    cmp	w28,	#0
    ldr	w23,	[sp, #872]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w23,	#0
    movz	w27,	#1
    csel	w25,	w27,	w21,	ne
    str	w25,	[sp, #796]

    ldr	w19,	[sp, #1004]

    cmp	w19,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w21,	eq
    mov	w18,	w21
    cmp	w18,	#0
    cset	w25,	ne
    mov	w23,	w25
    str	w23,	[sp, #780]

    ldr	w26,	[sp, #796]

    cmp	w26,	#0
    ldr	w19,	[sp, #780]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w19,	#0
    movz	w19,	#1
    mov	w18,	w19
    csel	w28,	w18,	w21,	ne
    str	w28,	[sp, #784]

    ldr	w27,	[sp, #796]

    cmp	w27,	#0
    ldr	w21,	[sp, #780]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w21,	#0
    movz	w24,	#0
    csel	w18,	w20,	w24,	ne
    cmp	w18,	#0
    cset	w25,	eq
    mov	w28,	w25
    cmp	w28,	#0
    cset	w20,	ne
    ldr	w25,	[sp, #784]

    mov	w22,	w20
    cmp	w25,	#0
    movz	w18,	#0
    mov	w25,	w18
    csel	w26,	w22,	w25,	ne
    str	w26,	[sp, #156]

    ldr	w20,	[sp, #1004]

    cmp	w20,	#0
    cset	w26,	ne
    mov	w27,	w26
    str	w27,	[sp, #284]

    ldr	w28,	[sp, #796]

    cmp	w28,	#0
    ldr	w22,	[sp, #780]

    cset	w18,	ne
    mov	w19,	w18
    cmp	w22,	#0
    movz	w23,	#0
    mov	w0,	w23
    csel	w26,	w19,	w0,	ne
    cmp	w26,	#0
    ldr	w28,	[sp, #284]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w28,	#0
    movz	w28,	#1
    mov	w0,	w28
    csel	w20,	w0,	w18,	ne
    str	w20,	[sp, #852]

    ldr	w21,	[sp, #824]

    cmp	w21,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w22,	w23
    str	w22,	[sp, #876]

    ldr	w21,	[sp, #852]

    cmp	w21,	#0
    ldr	w26,	[sp, #876]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w26,	#0
    movz	w20,	#1
    csel	w0,	w20,	w18,	ne
    str	w0,	[sp, #848]

    ldr	w22,	[sp, #852]

    cmp	w22,	#0
    ldr	w27,	[sp, #876]

    cset	w26,	ne
    mov	w0,	w26
    cmp	w27,	#0
    movz	w18,	#0
    mov	w28,	w18
    csel	w0,	w0,	w28,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    ldr	w27,	[sp, #848]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w27,	#0
    movz	w25,	#0
    csel	w0,	w18,	w25,	ne
    str	w0,	[sp, #108]

    ldr	w22,	[sp, #824]

    cmp	w22,	#0
    cset	w26,	ne
    ldr	w21,	[sp, #852]

    mov	w0,	w26
    cmp	w21,	#0
    cset	w18,	ne
    ldr	w24,	[sp, #876]

    mov	w25,	w18
    cmp	w24,	#0
    movz	w19,	#0
    mov	w23,	w19
    csel	w21,	w25,	w23,	ne
    cmp	w21,	#0
    cset	w18,	ne
    mov	w25,	w18
    cmp	w0,	#0
    movz	w20,	#1
    csel	w23,	w20,	w25,	ne
    str	w23,	[sp, #948]

    ldr	w0,	[sp, #820]

    cmp	w0,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w27,	w23
    str	w27,	[sp, #880]

    ldr	w24,	[sp, #948]

    cmp	w24,	#0
    cset	w0,	ne
    ldr	w20,	[sp, #880]

    mov	w18,	w0
    cmp	w20,	#0
    ldr	w25,	[sp, #948]

    movz	w0,	#1
    mov	w28,	w0
    csel	w19,	w28,	w18,	ne
    cmp	w25,	#0
    cset	w26,	ne
    ldr	w21,	[sp, #880]

    mov	w0,	w26
    cmp	w21,	#0
    movz	w25,	#0
    csel	w28,	w0,	w25,	ne
    cmp	w28,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w19,	#0
    movz	w28,	#0
    mov	w0,	w28
    csel	w19,	w18,	w0,	ne
    str	w19,	[sp, #924]

    ldr	w18,	[sp, #820]

    cmp	w18,	#0
    cset	w26,	ne
    mov	w23,	w26
    ldr	w26,	[sp, #948]

    cmp	w26,	#0
    cset	w18,	ne
    ldr	w19,	[sp, #880]

    mov	w0,	w18
    cmp	w19,	#0
    movz	w21,	#0
    csel	w25,	w0,	w21,	ne
    cmp	w25,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w23,	#0
    movz	w0,	#1
    mov	w28,	w0
    csel	w22,	w28,	w18,	ne
    str	w22,	[sp, #960]

    ldr	w25,	[sp, #828]

    cmp	w25,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w20,	w23
    str	w20,	[sp, #884]

    ldr	w23,	[sp, #960]

    cmp	w23,	#0
    ldr	w25,	[sp, #884]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w25,	#0
    movz	w25,	#1
    csel	w18,	w25,	w18,	ne
    str	w18,	[sp, #864]

    ldr	w24,	[sp, #960]

    cmp	w24,	#0
    cset	w26,	ne
    mov	w0,	w26
    ldr	w26,	[sp, #884]

    cmp	w26,	#0
    movz	w28,	#0
    mov	w18,	w28
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    cset	w0,	ne
    mov	w18,	w0
    ldr	w0,	[sp, #864]

    cmp	w0,	#0
    movz	w20,	#0
    csel	w22,	w18,	w20,	ne
    str	w22,	[sp, #928]

    ldr	w26,	[sp, #828]

    cmp	w26,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #960]

    cmp	w25,	#0
    ldr	w24,	[sp, #884]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w24,	#0
    movz	w25,	#0
    mov	w20,	w25
    csel	w20,	w0,	w20,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w26,	#0
    movz	w25,	#1
    csel	w20,	w25,	w18,	ne
    str	w20,	[sp, #904]

    ldr	w25,	[sp, #840]

    cmp	w25,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w25,	w23
    str	w25,	[sp, #888]

    ldr	w21,	[sp, #904]

    cmp	w21,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #888]

    mov	w18,	w0
    cmp	w19,	#0
    ldr	w22,	[sp, #904]

    movz	w28,	#1
    mov	w0,	w28
    csel	w19,	w0,	w18,	ne
    cmp	w22,	#0
    ldr	w20,	[sp, #888]

    cset	w26,	ne
    mov	w0,	w26
    cmp	w20,	#0
    movz	w21,	#0
    csel	w28,	w0,	w21,	ne
    cmp	w28,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w19,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w25,	w18,	w28,	ne
    str	w25,	[sp, #756]

    ldr	w26,	[sp, #840]

    cmp	w26,	#0
    cset	w26,	ne
    mov	w0,	w26
    ldr	w26,	[sp, #904]

    cmp	w26,	#0
    cset	w28,	ne
    ldr	w19,	[sp, #888]

    mov	w21,	w28
    cmp	w19,	#0
    movz	w27,	#0
    mov	w19,	w27
    csel	w25,	w21,	w19,	ne
    cmp	w25,	#0
    cset	w28,	ne
    mov	w21,	w28
    cmp	w0,	#0
    movz	w28,	#1
    mov	w0,	w28
    csel	w23,	w0,	w21,	ne
    str	w23,	[sp, #916]

    ldr	w26,	[sp, #856]

    cmp	w26,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w18,	w23
    str	w18,	[sp, #892]

    ldr	w24,	[sp, #916]

    cmp	w24,	#0
    cset	w0,	ne
    ldr	w24,	[sp, #892]

    mov	w18,	w0
    cmp	w24,	#0
    movz	w20,	#1
    csel	w27,	w20,	w18,	ne
    str	w27,	[sp, #964]

    ldr	w25,	[sp, #916]

    cmp	w25,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #892]

    mov	w0,	w26
    cmp	w25,	#0
    movz	w18,	#0
    mov	w28,	w18
    csel	w0,	w0,	w28,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    cset	w0,	ne
    mov	w18,	w0
    ldr	w0,	[sp, #964]

    cmp	w0,	#0
    movz	w25,	#0
    csel	w28,	w18,	w25,	ne
    str	w28,	[sp, #760]

    ldr	w27,	[sp, #856]

    cmp	w27,	#0
    cset	w26,	ne
    ldr	w19,	[sp, #916]

    mov	w0,	w26
    cmp	w19,	#0
    ldr	w24,	[sp, #892]

    cset	w18,	ne
    mov	w25,	w18
    cmp	w24,	#0
    movz	w18,	#0
    csel	w21,	w25,	w18,	ne
    cmp	w21,	#0
    cset	w18,	ne
    mov	w25,	w18
    cmp	w0,	#0
    movz	w20,	#1
    csel	w19,	w20,	w25,	ne
    str	w19,	[sp, #764]

    ldr	w24,	[sp, #128]

    cmp	w24,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w24,	w23
    str	w24,	[sp, #768]

    ldr	w20,	[sp, #764]

    cmp	w20,	#0
    cset	w0,	ne
    ldr	w20,	[sp, #768]

    mov	w18,	w0
    cmp	w20,	#0
    movz	w0,	#1
    mov	w28,	w0
    csel	w28,	w28,	w18,	ne
    str	w28,	[sp, #920]

    ldr	w21,	[sp, #764]

    cmp	w21,	#0
    cset	w26,	ne
    ldr	w21,	[sp, #768]

    mov	w0,	w26
    cmp	w21,	#0
    movz	w25,	#0
    csel	w0,	w0,	w25,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    ldr	w22,	[sp, #920]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w22,	#0
    movz	w28,	#0
    mov	w0,	w28
    csel	w18,	w18,	w0,	ne
    str	w18,	[sp, #968]

    ldr	w25,	[sp, #128]

    cmp	w25,	#0
    cset	w26,	ne
    mov	w25,	w26
    str	w25,	[sp, #356]

    ldr	w22,	[sp, #764]

    cmp	w22,	#0
    cset	w18,	ne
    ldr	w22,	[sp, #768]

    mov	w19,	w18
    cmp	w22,	#0
    movz	w23,	#0
    mov	w0,	w23
    csel	w26,	w19,	w0,	ne
    cmp	w26,	#0
    ldr	w27,	[sp, #356]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w27,	#0
    movz	w0,	#1
    mov	w28,	w0
    csel	w25,	w28,	w18,	ne
    str	w25,	[sp, #908]

    ldr	w19,	[sp, #180]

    cmp	w19,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w21,	w23
    str	w21,	[sp, #364]

    ldr	w26,	[sp, #908]

    cmp	w26,	#0
    cset	w0,	ne
    ldr	w24,	[sp, #364]

    mov	w18,	w0
    cmp	w24,	#0
    movz	w25,	#1
    csel	w21,	w25,	w18,	ne
    str	w21,	[sp, #972]

    ldr	w27,	[sp, #908]

    cmp	w27,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #364]

    mov	w0,	w26
    cmp	w25,	#0
    movz	w28,	#0
    mov	w18,	w28
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    ldr	w24,	[sp, #972]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w24,	#0
    movz	w20,	#0
    csel	w28,	w18,	w20,	ne
    str	w28,	[sp, #952]

    ldr	w20,	[sp, #180]

    cmp	w20,	#0
    ldr	w20,	[sp, #908]

    cset	w26,	ne
    mov	w0,	w26
    cmp	w20,	#0
    ldr	w21,	[sp, #364]

    cset	w18,	ne
    mov	w25,	w18
    cmp	w21,	#0
    movz	w19,	#0
    mov	w23,	w19
    csel	w21,	w25,	w23,	ne
    cmp	w21,	#0
    cset	w18,	ne
    mov	w25,	w18
    cmp	w0,	#0
    movz	w28,	#1
    csel	w24,	w28,	w25,	ne
    str	w24,	[sp, #896]

    ldr	w24,	[sp, #196]

    cmp	w24,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w28,	w23
    str	w28,	[sp, #360]

    ldr	w25,	[sp, #896]

    cmp	w25,	#0
    ldr	w19,	[sp, #360]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w19,	#0
    movz	w28,	#1
    ldr	w26,	[sp, #896]

    mov	w0,	w28
    csel	w19,	w0,	w18,	ne
    cmp	w26,	#0
    cset	w26,	ne
    ldr	w20,	[sp, #360]

    mov	w0,	w26
    cmp	w20,	#0
    movz	w21,	#0
    csel	w28,	w0,	w21,	ne
    cmp	w28,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w19,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w19,	w18,	w28,	ne
    str	w19,	[sp, #940]

    ldr	w25,	[sp, #196]

    cmp	w25,	#0
    ldr	w18,	[sp, #896]

    cset	w26,	ne
    mov	w0,	w26
    cmp	w18,	#0
    ldr	w27,	[sp, #360]

    cset	w28,	ne
    mov	w21,	w28
    cmp	w27,	#0
    movz	w18,	#0
    csel	w25,	w21,	w18,	ne
    cmp	w25,	#0
    cset	w28,	ne
    mov	w21,	w28
    cmp	w0,	#0
    movz	w28,	#1
    mov	w0,	w28
    csel	w18,	w0,	w21,	ne
    str	w18,	[sp, #912]

    ldr	w26,	[sp, #664]

    cmp	w26,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w20,	w23
    str	w20,	[sp, #296]

    ldr	w19,	[sp, #912]

    cmp	w19,	#0
    ldr	w22,	[sp, #296]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w22,	#0
    movz	w20,	#1
    csel	w0,	w20,	w18,	ne
    str	w0,	[sp, #900]

    ldr	w20,	[sp, #912]

    cmp	w20,	#0
    ldr	w23,	[sp, #296]

    cset	w26,	ne
    mov	w0,	w26
    cmp	w23,	#0
    movz	w18,	#0
    mov	w28,	w18
    csel	w0,	w0,	w28,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    ldr	w21,	[sp, #900]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w21,	#0
    movz	w25,	#0
    csel	w28,	w18,	w25,	ne
    str	w28,	[sp, #936]

    ldr	w27,	[sp, #664]

    cmp	w27,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #912]

    mov	w0,	w26
    cmp	w25,	#0
    cset	w18,	ne
    mov	w25,	w18
    ldr	w18,	[sp, #296]

    cmp	w18,	#0
    movz	w23,	#0
    mov	w19,	w23
    csel	w21,	w25,	w19,	ne
    cmp	w21,	#0
    cset	w18,	ne
    mov	w25,	w18
    cmp	w0,	#0
    movz	w20,	#1
    csel	w21,	w20,	w25,	ne
    str	w21,	[sp, #748]

    ldr	w18,	[sp, #684]

    cmp	w18,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    ldr	w20,	[sp, #748]

    mov	w26,	w23
    cmp	w20,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w26,	#0
    movz	w27,	#1
    mov	w22,	w27
    csel	w28,	w22,	w20,	ne
    str	w28,	[sp, #412]

    ldr	w21,	[sp, #748]

    cmp	w21,	#0
    cset	w19,	ne
    mov	w0,	w19
    cmp	w26,	#0
    movz	w27,	#0
    mov	w22,	w27
    csel	w24,	w0,	w22,	ne
    cmp	w24,	#0
    cset	w19,	eq
    mov	w20,	w19
    cmp	w20,	#0
    ldr	w28,	[sp, #412]

    cset	w0,	ne
    mov	w27,	w0
    cmp	w28,	#0
    movz	w19,	#0
    mov	w0,	w19
    csel	w19,	w27,	w0,	ne
    str	w19,	[sp, #868]

    ldr	w0,	[sp, #684]

    cmp	w0,	#0
    cset	w0,	ne
    mov	w24,	w0
    ldr	w0,	[sp, #748]

    cmp	w0,	#0
    cset	w22,	ne
    mov	w0,	w22
    cmp	w26,	#0
    movz	w22,	#0
    mov	w23,	w22
    csel	w28,	w0,	w23,	ne
    cmp	w28,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w24,	#0
    movz	w0,	#1
    mov	w28,	w0
    csel	w24,	w28,	w20,	ne
    str	w24,	[sp, #932]

    ldr	w27,	[sp, #680]

    cmp	w27,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w0,	#0
    cset	w18,	eq
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w26,	w23
    ldr	w23,	[sp, #932]

    cmp	w23,	#0
    cset	w0,	ne
    str	w0,	[sp, #104]

    cmp	w26,	#0
    movz	w24,	#1
    ldr	w21,	[sp, #104]

    csel	w19,	w24,	w21,	ne
    str	w19,	[sp, #956]

    ldr	w24,	[sp, #932]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w26,	#0
    movz	w19,	#0
    mov	w0,	w19
    csel	w0,	w24,	w0,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w26,	w23
    cmp	w26,	#0
    ldr	w21,	[sp, #956]

    cset	w0,	ne
    mov	w18,	w0
    cmp	w21,	#0
    ldr	w22,	[sp, #868]

    movz	w20,	#0
    csel	w23,	w18,	w20,	ne
    lsl	w28,	w23,	#1
    add	w0,	w28,	w22
    lsl	w21,	w0,	#1
    ldr	w0,	[sp, #936]

    ldr	w20,	[sp, #940]

    add	w0,	w21,	w0
    lsl	w25,	w0,	#1
    ldr	w0,	[sp, #952]

    add	w26,	w25,	w20
    ldr	w19,	[sp, #968]

    lsl	w20,	w26,	#1
    add	w18,	w20,	w0
    lsl	w0,	w18,	#1
    add	w23,	w0,	w19
    ldr	w0,	[sp, #760]

    ldr	w26,	[sp, #756]

    lsl	w28,	w23,	#1
    ldr	w23,	[sp, #928]

    add	w0,	w28,	w0
    lsl	w20,	w0,	#1
    add	w0,	w20,	w26
    ldr	w20,	[sp, #924]

    lsl	w25,	w0,	#1
    add	w26,	w25,	w23
    lsl	w19,	w26,	#1
    add	w18,	w19,	w20
    lsl	w0,	w18,	#1
    ldr	w18,	[sp, #108]

    ldr	w27,	[sp, #156]

    add	w23,	w0,	w18
    lsl	w26,	w23,	#1
    add	w0,	w26,	w27
    ldr	w27,	[sp, #172]

    ldr	w20,	[sp, #208]

    lsl	w18,	w0,	#1
    add	w0,	w18,	w27
    ldr	w18,	[sp, #672]

    ldr	w21,	[sp, #688]

    lsl	w23,	w0,	#1
    add	w26,	w23,	w20
    lsl	w0,	w26,	#1
    add	w18,	w0,	w18
    lsl	w0,	w18,	#1
    add	w0,	w0,	w21
    bl	fib
    str	w0,	[sp, #692]

    ldr	w25,	[sp, #496]

    cmp	w25,	#0
    ldr	w0,	[sp, #724]

    ldr	w26,	[sp, #496]

    csel	w27,	w0,	w26,	lt
    str	w27,	[sp, #1064]

    ldr	w25,	[sp, #508]

    cmp	w25,	#0
    ldr	w23,	[sp, #436]

    ldr	w27,	[sp, #508]

    csel	w18,	w23,	w27,	lt
    str	w18,	[sp, #1068]

    ldr	w0,	[sp, #512]

    cmp	w0,	#0
    ldr	w19,	[sp, #452]

    ldr	w23,	[sp, #512]

    csel	w25,	w19,	w23,	lt
    str	w25,	[sp, #652]

    ldr	w27,	[sp, #520]

    cmp	w27,	#0
    ldr	w25,	[sp, #464]

    ldr	w28,	[sp, #520]

    csel	w21,	w25,	w28,	lt
    str	w21,	[sp, #648]

    ldr	w19,	[sp, #516]

    cmp	w19,	#0
    ldr	w24,	[sp, #476]

    ldr	w20,	[sp, #516]

    csel	w20,	w24,	w20,	lt
    str	w20,	[sp, #248]

    ldr	w0,	[sp, #500]

    cmp	w0,	#0
    ldr	w18,	[sp, #488]

    ldr	w19,	[sp, #500]

    csel	w28,	w18,	w19,	lt
    str	w28,	[sp, #256]

    ldr	w24,	[sp, #492]

    cmp	w24,	#0
    ldr	w0,	[sp, #480]

    ldr	w25,	[sp, #492]

    csel	w24,	w0,	w25,	lt
    str	w24,	[sp, #252]

    ldr	w23,	[sp, #484]

    cmp	w23,	#0
    ldr	w21,	[sp, #468]

    ldr	w24,	[sp, #484]

    csel	w20,	w21,	w24,	lt
    str	w20,	[sp, #260]

    ldr	w0,	[sp, #472]

    cmp	w0,	#0
    ldr	w28,	[sp, #456]

    ldr	w0,	[sp, #472]

    csel	w26,	w28,	w0,	lt
    str	w26,	[sp, #232]

    ldr	w23,	[sp, #460]

    cmp	w23,	#0
    ldr	w0,	[sp, #444]

    ldr	w23,	[sp, #460]

    csel	w23,	w0,	w23,	lt
    str	w23,	[sp, #240]

    ldr	w0,	[sp, #448]

    cmp	w0,	#0
    ldr	w28,	[sp, #432]

    ldr	w24,	[sp, #448]

    csel	w22,	w28,	w24,	lt
    str	w22,	[sp, #328]

    ldr	w28,	[sp, #440]

    cmp	w28,	#0
    ldr	w27,	[sp, #728]

    ldr	w23,	[sp, #440]

    csel	w24,	w27,	w23,	lt
    str	w24,	[sp, #136]

    ldr	w0,	[sp, #428]

    cmp	w0,	#0
    ldr	w21,	[sp, #716]

    ldr	w26,	[sp, #428]

    csel	w27,	w21,	w26,	lt
    str	w27,	[sp, #176]

    ldr	w28,	[sp, #720]

    cmp	w28,	#0
    ldr	w20,	[sp, #708]

    ldr	w18,	[sp, #720]

    csel	w27,	w20,	w18,	lt
    str	w27,	[sp, #204]

    ldr	w27,	[sp, #712]

    cmp	w27,	#0
    ldr	w19,	[sp, #700]

    ldr	w27,	[sp, #712]

    csel	w27,	w19,	w27,	lt
    str	w27,	[sp, #216]

    ldr	w25,	[sp, #704]

    cmp	w25,	#0
    ldr	w25,	[sp, #696]

    ldr	w24,	[sp, #704]

    csel	w20,	w25,	w24,	lt
    str	w20,	[sp, #220]

    ldr	w28,	[sp, #1064]

    cmp	w28,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w23,	ne
    str	w23,	[sp, #676]

    ldr	w19,	[sp, #1068]

    cmp	w19,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w28,	ne
    str	w28,	[sp, #668]

    ldr	w20,	[sp, #1068]

    cmp	w20,	#0
    cset	w26,	ne
    cmp	w26,	#0
    ldr	w19,	[sp, #652]

    cset	w28,	ne
    mov	w23,	w28
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w24,	ne
    mov	w0,	w24
    str	w0,	[sp, #736]

    cmp	w23,	#0
    ldr	w25,	[sp, #736]

    cset	w19,	ne
    mov	w21,	w19
    cmp	w25,	#0
    movz	w24,	#1
    csel	w25,	w24,	w21,	ne
    cmp	w23,	#0
    cset	w18,	ne
    mov	w27,	w18
    str	w27,	[sp, #732]

    ldr	w19,	[sp, #736]

    cmp	w19,	#0
    movz	w19,	#0
    ldr	w0,	[sp, #732]

    mov	w22,	w19
    csel	w18,	w0,	w22,	ne
    cmp	w18,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w25,	#0
    movz	w21,	#0
    csel	w22,	w22,	w21,	ne
    str	w22,	[sp, #212]

    ldr	w20,	[sp, #652]

    cmp	w20,	#0
    cset	w26,	ne
    cmp	w23,	#0
    cset	w18,	ne
    ldr	w27,	[sp, #736]

    cmp	w27,	#0
    movz	w0,	#0
    csel	w18,	w18,	w0,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w26,	#0
    movz	w24,	#1
    csel	w18,	w24,	w22,	ne
    str	w18,	[sp, #236]

    ldr	w22,	[sp, #648]

    cmp	w22,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    ldr	w26,	[sp, #236]

    cmp	w26,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w28,	#0
    ldr	w27,	[sp, #236]

    movz	w20,	#1
    csel	w19,	w20,	w26,	ne
    cmp	w27,	#0
    cset	w25,	ne
    str	w25,	[sp, #132]

    cmp	w28,	#0
    movz	w26,	#0
    mov	w0,	w26
    ldr	w26,	[sp, #132]

    csel	w25,	w26,	w0,	ne
    cmp	w25,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w19,	#0
    movz	w19,	#0
    csel	w24,	w0,	w19,	ne
    str	w24,	[sp, #192]

    ldr	w27,	[sp, #648]

    cmp	w27,	#0
    ldr	w0,	[sp, #236]

    cset	w27,	ne
    cmp	w0,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w28,	#0
    movz	w26,	#0
    csel	w23,	w23,	w26,	ne
    cmp	w23,	#0
    cset	w24,	ne
    mov	w26,	w24
    cmp	w27,	#0
    movz	w18,	#1
    ldr	w21,	[sp, #248]

    csel	w22,	w18,	w26,	ne
    cmp	w21,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w22,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w0,	#0
    movz	w26,	#1
    csel	w18,	w26,	w18,	ne
    cmp	w22,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w25,	#0
    csel	w24,	w23,	w25,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w18,	#0
    movz	w24,	#0
    csel	w19,	w19,	w24,	ne
    str	w19,	[sp, #160]

    ldr	w28,	[sp, #248]

    cmp	w28,	#0
    cset	w23,	ne
    cmp	w22,	#0
    cset	w18,	ne
    mov	w21,	w18
    cmp	w0,	#0
    movz	w20,	#0
    csel	w26,	w21,	w20,	ne
    cmp	w26,	#0
    cset	w28,	ne
    cmp	w23,	#0
    ldr	w0,	[sp, #256]

    movz	w23,	#1
    csel	w27,	w23,	w28,	ne
    cmp	w0,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w0,	w23
    cmp	w27,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    movz	w18,	#1
    csel	w18,	w18,	w20,	ne
    cmp	w27,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w0,	#0
    movz	w24,	#0
    csel	w26,	w26,	w24,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w18,	#0
    movz	w23,	#0
    csel	w24,	w19,	w23,	ne
    str	w24,	[sp, #120]

    ldr	w25,	[sp, #256]

    cmp	w25,	#0
    cset	w23,	ne
    cmp	w27,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w0,	#0
    movz	w25,	#0
    csel	w18,	w20,	w25,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w23,	#0
    movz	w28,	#1
    ldr	w25,	[sp, #252]

    csel	w26,	w28,	w22,	ne
    cmp	w25,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w26,	#0
    cset	w24,	ne
    mov	w27,	w24
    cmp	w0,	#0
    movz	w23,	#1
    csel	w20,	w23,	w27,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w23,	#0
    csel	w22,	w19,	w23,	ne
    cmp	w22,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w20,	#0
    movz	w21,	#0
    csel	w28,	w27,	w21,	ne
    str	w28,	[sp, #268]

    ldr	w21,	[sp, #252]

    cmp	w21,	#0
    cset	w19,	ne
    cmp	w26,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w0,	#0
    movz	w28,	#0
    csel	w24,	w18,	w28,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w19,	#0
    movz	w0,	#1
    ldr	w21,	[sp, #260]

    csel	w24,	w0,	w27,	ne
    cmp	w21,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w24,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w28,	#0
    movz	w23,	#1
    csel	w0,	w23,	w18,	ne
    cmp	w24,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w28,	#0
    movz	w20,	#0
    csel	w23,	w25,	w20,	ne
    cmp	w23,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w0,	#0
    movz	w20,	#0
    csel	w19,	w18,	w20,	ne
    str	w19,	[sp, #272]

    ldr	w0,	[sp, #260]

    cmp	w0,	#0
    cset	w22,	ne
    cmp	w24,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w24,	#0
    csel	w26,	w0,	w24,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w22,	#0
    movz	w28,	#1
    ldr	w27,	[sp, #232]

    csel	w22,	w28,	w18,	ne
    cmp	w27,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w0,	w23
    cmp	w22,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w27,	#1
    csel	w20,	w27,	w19,	ne
    cmp	w22,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w0,	#0
    movz	w26,	#0
    csel	w26,	w25,	w26,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w20,	#0
    movz	w25,	#0
    csel	w23,	w19,	w25,	ne
    str	w23,	[sp, #276]

    ldr	w24,	[sp, #232]

    cmp	w24,	#0
    cset	w23,	ne
    cmp	w22,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w0,	#0
    movz	w26,	#0
    csel	w18,	w20,	w26,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w24,	w20
    cmp	w23,	#0
    movz	w21,	#1
    csel	w18,	w21,	w24,	ne
    ldr	w24,	[sp, #240]

    cmp	w24,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w18,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w28,	#0
    movz	w0,	#1
    csel	w24,	w0,	w26,	ne
    cmp	w18,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w28,	#0
    movz	w23,	#0
    csel	w19,	w0,	w23,	ne
    cmp	w19,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w24,	#0
    movz	w22,	#0
    csel	w24,	w0,	w22,	ne
    str	w24,	[sp, #264]

    ldr	w21,	[sp, #240]

    cmp	w21,	#0
    cset	w27,	ne
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w20,	#0
    csel	w23,	w0,	w20,	ne
    cmp	w23,	#0
    cset	w24,	ne
    mov	w25,	w24
    cmp	w27,	#0
    ldr	w23,	[sp, #328]

    movz	w26,	#1
    csel	w21,	w26,	w25,	ne
    cmp	w23,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w0,	w23
    cmp	w21,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w26,	#1
    csel	w18,	w26,	w19,	ne
    cmp	w21,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w0,	#0
    movz	w25,	#0
    csel	w24,	w26,	w25,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w18,	#0
    movz	w18,	#0
    csel	w22,	w20,	w18,	ne
    str	w22,	[sp, #352]

    ldr	w22,	[sp, #328]

    cmp	w22,	#0
    cset	w23,	ne
    cmp	w21,	#0
    cset	w18,	ne
    cmp	w0,	#0
    movz	w25,	#0
    csel	w26,	w18,	w25,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w23,	#0
    movz	w20,	#1
    csel	w25,	w20,	w18,	ne
    ldr	w20,	[sp, #136]

    cmp	w20,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w0,	w23
    cmp	w25,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w21,	#1
    csel	w18,	w21,	w19,	ne
    cmp	w25,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w0,	#0
    movz	w19,	#0
    csel	w26,	w26,	w19,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w18,	#0
    movz	w19,	#0
    csel	w27,	w20,	w19,	ne
    str	w27,	[sp, #344]

    ldr	w20,	[sp, #136]

    cmp	w20,	#0
    cset	w23,	ne
    cmp	w25,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w0,	#0
    movz	w28,	#0
    csel	w18,	w20,	w28,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w23,	#0
    movz	w24,	#1
    ldr	w20,	[sp, #176]

    csel	w18,	w24,	w22,	ne
    cmp	w20,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w18,	#0
    cset	w24,	ne
    mov	w27,	w24
    cmp	w0,	#0
    movz	w26,	#1
    csel	w20,	w26,	w27,	ne
    cmp	w18,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w25,	#0
    csel	w27,	w19,	w25,	ne
    cmp	w27,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w20,	#0
    movz	w24,	#0
    csel	w19,	w27,	w24,	ne
    str	w19,	[sp, #348]

    ldr	w21,	[sp, #176]

    cmp	w21,	#0
    cset	w28,	ne
    cmp	w18,	#0
    cset	w22,	ne
    mov	w24,	w22
    cmp	w0,	#0
    movz	w25,	#0
    csel	w23,	w24,	w25,	ne
    cmp	w23,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w28,	#0
    ldr	w27,	[sp, #204]

    movz	w23,	#1
    csel	w23,	w23,	w26,	ne
    cmp	w27,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w23,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w28,	#0
    movz	w19,	#1
    csel	w27,	w19,	w27,	ne
    cmp	w23,	#0
    cset	w20,	ne
    cmp	w28,	#0
    movz	w0,	#0
    csel	w22,	w20,	w0,	ne
    cmp	w22,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w27,	#0
    movz	w25,	#0
    ldr	w21,	[sp, #204]

    csel	w27,	w0,	w25,	ne
    cmp	w21,	#0
    cset	w22,	ne
    cmp	w23,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w26,	#0
    csel	w28,	w0,	w26,	ne
    cmp	w28,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w22,	#0
    ldr	w25,	[sp, #216]

    movz	w23,	#1
    csel	w18,	w23,	w18,	ne
    cmp	w25,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w24,	ne
    mov	w28,	w24
    str	w28,	[sp, #112]

    cmp	w18,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #112]

    mov	w28,	w26
    cmp	w25,	#0
    movz	w0,	#1
    csel	w22,	w0,	w28,	ne
    cmp	w18,	#0
    ldr	w23,	[sp, #112]

    cset	w20,	ne
    mov	w0,	w20
    cmp	w23,	#0
    movz	w28,	#0
    mov	w21,	w28
    csel	w25,	w0,	w21,	ne
    cmp	w25,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w26,	ne
    mov	w28,	w26
    cmp	w22,	#0
    movz	w20,	#0
    ldr	w21,	[sp, #216]

    csel	w19,	w28,	w20,	ne
    cmp	w21,	#0
    cset	w20,	ne
    cmp	w18,	#0
    ldr	w28,	[sp, #112]

    cset	w0,	ne
    cmp	w28,	#0
    movz	w21,	#0
    csel	w0,	w0,	w21,	ne
    cmp	w0,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w20,	#0
    movz	w23,	#1
    ldr	w20,	[sp, #220]

    csel	w0,	w23,	w18,	ne
    cmp	w20,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w25,	ne
    str	w25,	[sp, #116]

    cmp	w0,	#0
    cset	w18,	ne
    ldr	w22,	[sp, #116]

    mov	w20,	w18
    cmp	w22,	#0
    movz	w25,	#1
    csel	w21,	w25,	w20,	ne
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w23,	[sp, #116]

    cmp	w23,	#0
    movz	w25,	#0
    csel	w23,	w0,	w25,	ne
    cmp	w23,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w21,	#0
    movz	w23,	#0
    csel	w21,	w18,	w23,	ne
    lsl	w23,	w21,	#1
    ldr	w21,	[sp, #348]

    add	w18,	w23,	w19
    lsl	w19,	w18,	#1
    ldr	w18,	[sp, #344]

    add	w0,	w19,	w27
    lsl	w25,	w0,	#1
    add	w24,	w25,	w21
    lsl	w27,	w24,	#1
    ldr	w24,	[sp, #352]

    add	w26,	w27,	w18
    ldr	w27,	[sp, #264]

    lsl	w0,	w26,	#1
    add	w28,	w0,	w24
    ldr	w24,	[sp, #276]

    lsl	w19,	w28,	#1
    add	w18,	w19,	w27
    lsl	w21,	w18,	#1
    add	w20,	w21,	w24
    ldr	w21,	[sp, #272]

    ldr	w18,	[sp, #268]

    lsl	w24,	w20,	#1
    add	w0,	w24,	w21
    lsl	w25,	w0,	#1
    add	w24,	w25,	w18
    ldr	w18,	[sp, #120]

    ldr	w19,	[sp, #160]

    lsl	w25,	w24,	#1
    add	w26,	w25,	w18
    lsl	w27,	w26,	#1
    ldr	w26,	[sp, #192]

    add	w28,	w27,	w19
    ldr	w24,	[sp, #212]

    lsl	w0,	w28,	#1
    add	w18,	w0,	w26
    ldr	w26,	[sp, #668]

    lsl	w19,	w18,	#1
    add	w20,	w19,	w24
    lsl	w21,	w20,	#1
    add	w0,	w21,	w26
    ldr	w21,	[sp, #676]

    lsl	w23,	w0,	#1
    add	w0,	w23,	w21
    bl	fib
    ldr	w17,	[sp, #692]

    movz	w4,	#0
    ldr	w23,	[sp, #692]

    asr	w12,	w17,	#31
    ldr	w24,	[sp, #692]

    lsr	w13,	w12,	#31
    add	w14,	w23,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w1,	w24,	w6
    sub	w3,	w4,	w1
    cmp	w1,	#0
    csel	w12,	w3,	w1,	lt
    str	w12,	[sp, #1124]

    ldr	w20,	[sp, #692]

    asr	w15,	w20,	#31
    ldr	w26,	[sp, #692]

    lsr	w16,	w15,	#31
    add	w17,	w26,	w16
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
    csel	w12,	w10,	w7,	lt
    movz	w24,	#0
    asr	w1,	w4,	#31
    str	w12,	[sp, #416]

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
    asr	w6,	w10,	#31
    csel	w4,	w15,	w12,	lt
    movz	w20,	#0
    str	w4,	[sp, #384]

    lsr	w7,	w6,	#31
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
    csel	w10,	w20,	w17,	lt
    str	w10,	[sp, #1056]

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
    csel	w19,	w25,	w24,	lt
    movz	w12,	#0
    asr	w18,	w22,	#31
    str	w19,	[sp, #396]

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
    csel	w20,	w3,	w1,	lt
    asr	w24,	w27,	#31
    movz	w8,	#0
    str	w20,	[sp, #1108]

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
    csel	w15,	w9,	w6,	lt
    movz	w4,	#0
    asr	w5,	w2,	#31
    str	w15,	[sp, #1060]

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
    csel	w9,	w14,	w13,	lt
    movz	w28,	#0
    asr	w11,	w10,	#31
    str	w9,	[sp, #388]

    lsr	w12,	w11,	#31
    add	w3,	w10,	w12
    asr	w13,	w3,	#1
    asr	w14,	w13,	#31
    lsr	w15,	w14,	#31
    add	w16,	w13,	w15
    asr	w20,	w16,	#1
    lsl	w21,	w20,	#1
    sub	w16,	w13,	w21
    sub	w19,	w28,	w16
    cmp	w16,	#0
    csel	w2,	w19,	w16,	lt
    movz	w24,	#0
    asr	w17,	w13,	#31
    str	w2,	[sp, #1116]

    lsr	w18,	w17,	#31
    add	w9,	w13,	w18
    asr	w18,	w9,	#1
    asr	w20,	w18,	#31
    lsr	w21,	w20,	#31
    add	w22,	w18,	w21
    asr	w14,	w22,	#1
    lsl	w15,	w14,	#1
    sub	w21,	w18,	w15
    sub	w24,	w24,	w21
    cmp	w21,	#0
    csel	w7,	w24,	w21,	lt
    asr	w23,	w18,	#31
    movz	w20,	#0
    str	w7,	[sp, #1120]

    lsr	w24,	w23,	#31
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
    csel	w22,	w1,	w28,	lt
    movz	w16,	#0
    str	w22,	[sp, #376]

    asr	w1,	w25,	#31
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
    csel	w22,	w7,	w4,	lt
    asr	w7,	w2,	#31
    str	w22,	[sp, #424]

    lsr	w8,	w7,	#31
    add	w27,	w2,	w8
    asr	w5,	w27,	#1
    asr	w11,	w5,	#31
    lsr	w12,	w11,	#31
    add	w13,	w5,	w12
    movz	w12,	#0
    asr	w2,	w13,	#1
    lsl	w3,	w2,	#1
    sub	w10,	w5,	w3
    sub	w13,	w12,	w10
    cmp	w10,	#0
    asr	w14,	w5,	#31
    csel	w24,	w13,	w10,	lt
    str	w24,	[sp, #400]

    lsr	w15,	w14,	#31
    add	w5,	w5,	w15
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
    csel	w27,	w14,	w13,	lt
    lsr	w10,	w9,	#31
    str	w27,	[sp, #380]

    add	w11,	w3,	w10
    asr	w10,	w11,	#1
    asr	w12,	w10,	#31
    lsr	w13,	w12,	#31
    add	w14,	w10,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w18,	w10,	w6
    sub	w19,	w4,	w18
    cmp	w18,	#0
    csel	w14,	w19,	w18,	lt
    asr	w15,	w10,	#31
    movz	w28,	#0
    str	w14,	[sp, #392]

    lsr	w16,	w15,	#31
    add	w17,	w10,	w16
    asr	w12,	w17,	#1
    asr	w1,	w12,	#31
    lsr	w2,	w1,	#31
    add	w2,	w12,	w2
    asr	w19,	w2,	#1
    lsl	w20,	w19,	#1
    sub	w21,	w12,	w20
    sub	w24,	w28,	w21
    cmp	w21,	#0
    csel	w1,	w24,	w21,	lt
    movz	w25,	#0
    asr	w21,	w0,	#31
    str	w1,	[sp, #404]

    lsr	w22,	w21,	#31
    add	w23,	w0,	w22
    asr	w26,	w23,	#1
    lsl	w27,	w26,	#1
    sub	w27,	w0,	w27
    sub	w28,	w25,	w27
    cmp	w27,	#0
    csel	w25,	w28,	w27,	lt
    asr	w24,	w0,	#31
    movz	w11,	#0
    str	w25,	[sp, #1112]

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
    csel	w20,	w23,	w22,	lt
    asr	w28,	w4,	#31
    movz	w7,	#0
    str	w20,	[sp, #1052]

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
    asr	w5,	w24,	#31
    csel	w15,	w28,	w27,	lt
    movz	w3,	#0
    str	w15,	[sp, #1048]

    lsr	w6,	w5,	#31
    add	w7,	w24,	w6
    asr	w17,	w7,	#1
    asr	w9,	w17,	#31
    lsr	w10,	w9,	#31
    add	w11,	w17,	w10
    asr	w12,	w11,	#1
    lsl	w13,	w12,	#1
    sub	w2,	w17,	w13
    sub	w14,	w3,	w2
    cmp	w2,	#0
    asr	w24,	w17,	#31
    csel	w28,	w14,	w2,	lt
    lsr	w25,	w24,	#31
    add	w14,	w17,	w25
    asr	w22,	w14,	#1
    asr	w27,	w22,	#31
    lsr	w1,	w27,	#31
    add	w0,	w22,	w1
    asr	w25,	w0,	#1
    movz	w0,	#0
    lsl	w26,	w25,	#1
    sub	w17,	w22,	w26
    sub	w24,	w0,	w17
    cmp	w17,	#0
    csel	w16,	w24,	w17,	lt
    asr	w1,	w22,	#31
    str	w16,	[sp, #420]

    movz	w24,	#0
    lsr	w2,	w1,	#31
    add	w20,	w22,	w2
    asr	w0,	w20,	#1
    asr	w5,	w0,	#31
    lsr	w6,	w5,	#31
    add	w7,	w0,	w6
    asr	w20,	w7,	#1
    lsl	w21,	w20,	#1
    sub	w21,	w0,	w21
    sub	w3,	w24,	w21
    cmp	w21,	#0
    movz	w20,	#0
    asr	w8,	w0,	#31
    csel	w2,	w3,	w21,	lt
    lsr	w9,	w8,	#31
    str	w2,	[sp, #1028]

    add	w26,	w0,	w9
    asr	w0,	w26,	#1
    asr	w11,	w0,	#31
    lsr	w12,	w11,	#31
    add	w13,	w0,	w12
    asr	w16,	w13,	#1
    lsl	w17,	w16,	#1
    sub	w4,	w0,	w17
    sub	w7,	w20,	w4
    cmp	w4,	#0
    asr	w14,	w0,	#31
    movz	w16,	#0
    csel	w22,	w7,	w4,	lt
    lsr	w15,	w14,	#31
    str	w22,	[sp, #1044]

    add	w4,	w0,	w15
    asr	w3,	w4,	#1
    asr	w18,	w3,	#31
    lsr	w19,	w18,	#31
    add	w20,	w3,	w19
    asr	w13,	w20,	#1
    lsl	w14,	w13,	#1
    sub	w4,	w3,	w14
    sub	w7,	w16,	w4
    cmp	w4,	#0
    asr	w8,	w3,	#31
    csel	w7,	w7,	w4,	lt
    str	w7,	[sp, #1032]

    lsr	w9,	w8,	#31
    add	w10,	w3,	w9
    asr	w6,	w10,	#1
    asr	w11,	w6,	#31
    lsr	w12,	w11,	#31
    add	w13,	w6,	w12
    movz	w12,	#0
    asr	w20,	w13,	#1
    lsl	w21,	w20,	#1
    sub	w9,	w6,	w21
    sub	w12,	w12,	w9
    cmp	w9,	#0
    csel	w12,	w12,	w9,	lt
    asr	w14,	w6,	#31
    movz	w8,	#0
    str	w12,	[sp, #1036]

    lsr	w15,	w14,	#31
    add	w16,	w6,	w15
    asr	w13,	w16,	#1
    asr	w17,	w13,	#31
    lsr	w18,	w17,	#31
    add	w19,	w13,	w18
    asr	w16,	w19,	#1
    lsl	w17,	w16,	#1
    sub	w16,	w13,	w17
    sub	w17,	w8,	w16
    cmp	w16,	#0
    asr	w20,	w13,	#31
    csel	w17,	w17,	w16,	lt
    movz	w4,	#0
    str	w17,	[sp, #1040]

    lsr	w21,	w20,	#31
    add	w22,	w13,	w21
    asr	w20,	w22,	#1
    asr	w7,	w20,	#31
    lsr	w8,	w7,	#31
    add	w9,	w20,	w8
    asr	w1,	w9,	#1
    lsl	w0,	w1,	#1
    sub	w27,	w20,	w0
    sub	w0,	w4,	w27
    cmp	w27,	#0
    csel	w9,	w0,	w27,	lt
    asr	w10,	w20,	#31
    str	w9,	[sp, #152]

    lsr	w11,	w10,	#31
    add	w0,	w20,	w11
    asr	w25,	w0,	#1
    movz	w0,	#0
    asr	w13,	w25,	#31
    lsr	w14,	w13,	#31
    add	w15,	w25,	w14
    asr	w22,	w15,	#1
    lsl	w23,	w22,	#1
    sub	w4,	w25,	w23
    sub	w5,	w0,	w4
    cmp	w4,	#0
    csel	w1,	w5,	w4,	lt
    asr	w16,	w25,	#31
    str	w1,	[sp, #200]

    lsr	w17,	w16,	#31
    add	w6,	w25,	w17
    movz	w25,	#0
    asr	w1,	w6,	#1
    asr	w21,	w1,	#31
    lsr	w22,	w21,	#31
    add	w23,	w1,	w22
    asr	w20,	w23,	#1
    lsl	w21,	w20,	#1
    sub	w9,	w1,	w21
    sub	w12,	w25,	w9
    cmp	w9,	#0
    asr	w24,	w1,	#31
    csel	w16,	w12,	w9,	lt
    movz	w21,	#0
    str	w16,	[sp, #188]

    lsr	w25,	w24,	#31
    add	w12,	w1,	w25
    asr	w6,	w12,	#1
    asr	w27,	w6,	#31
    lsr	w1,	w27,	#31
    add	w0,	w6,	w1
    asr	w16,	w0,	#1
    lsl	w17,	w16,	#1
    sub	w14,	w6,	w17
    sub	w17,	w21,	w14
    cmp	w14,	#0
    asr	w1,	w6,	#31
    csel	w11,	w17,	w14,	lt
    str	w11,	[sp, #184]

    movz	w17,	#0
    lsr	w2,	w1,	#31
    add	w18,	w6,	w2
    asr	w11,	w18,	#1
    asr	w4,	w11,	#31
    lsr	w5,	w4,	#31
    add	w6,	w11,	w5
    asr	w10,	w6,	#1
    lsl	w13,	w10,	#1
    sub	w21,	w11,	w13
    sub	w22,	w17,	w21
    cmp	w21,	#0
    movz	w13,	#0
    asr	w7,	w11,	#31
    csel	w22,	w22,	w21,	lt
    lsr	w8,	w7,	#31
    str	w22,	[sp, #168]

    add	w24,	w11,	w8
    asr	w27,	w24,	#1
    asr	w25,	w27,	#31
    lsr	w26,	w25,	#31
    add	w0,	w27,	w26
    asr	w20,	w0,	#1
    lsl	w21,	w20,	#1
    sub	w19,	w27,	w21
    sub	w20,	w13,	w19
    cmp	w19,	#0
    csel	w4,	w20,	w19,	lt
    str	w4,	[sp, #408]

    ldr	w25,	[sp, #1112]

    cmp	w25,	#0
    ldr	w11,	[sp, #1124]

    cset	w5,	ne
    cmp	w11,	#0
    movz	w20,	#1
    mov	w19,	w20
    csel	w0,	w19,	w5,	ne
    str	w0,	[sp, #140]

    ldr	w26,	[sp, #1112]

    cmp	w26,	#0
    ldr	w11,	[sp, #1124]

    cset	w16,	ne
    mov	w17,	w16
    cmp	w11,	#0
    movz	w11,	#0
    csel	w17,	w17,	w11,	ne
    cmp	w17,	#0
    cset	w13,	eq
    cmp	w13,	#0
    ldr	w1,	[sp, #140]

    cset	w15,	ne
    cmp	w1,	#0
    movz	w18,	#0
    mov	w17,	w18
    csel	w23,	w15,	w17,	ne
    cmp	w23,	#0
    cset	w19,	ne
    cmp	w19,	#0
    ldr	w25,	[sp, #1112]

    cset	w21,	ne
    cmp	w25,	#0
    ldr	w13,	[sp, #1124]

    cset	w1,	ne
    cmp	w13,	#0
    movz	w3,	#0
    mov	w2,	w3
    csel	w15,	w1,	w2,	ne
    cmp	w15,	#0
    cset	w18,	ne
    ldr	w1,	[sp, #1052]

    cmp	w1,	#0
    cset	w22,	ne
    ldr	w25,	[sp, #416]

    mov	w23,	w22
    cmp	w25,	#0
    movz	w10,	#1
    csel	w3,	w10,	w23,	ne
    str	w3,	[sp, #144]

    ldr	w2,	[sp, #1052]

    cmp	w2,	#0
    ldr	w26,	[sp, #416]

    cset	w27,	ne
    mov	w0,	w27
    cmp	w26,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w5,	w0,	w9,	ne
    cmp	w5,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w2,	ne
    ldr	w7,	[sp, #144]

    cmp	w7,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w10,	w2,	w9,	ne
    str	w10,	[sp, #744]

    cmp	w18,	#0
    ldr	w12,	[sp, #744]

    cset	w6,	ne
    cmp	w12,	#0
    movz	w9,	#1
    mov	w8,	w9
    csel	w20,	w8,	w6,	ne
    cmp	w18,	#0
    cset	w9,	ne
    str	w9,	[sp, #740]

    ldr	w12,	[sp, #744]

    cmp	w12,	#0
    movz	w10,	#0
    ldr	w7,	[sp, #740]

    csel	w22,	w7,	w10,	ne
    cmp	w22,	#0
    cset	w14,	eq
    cmp	w14,	#0
    cset	w16,	ne
    mov	w17,	w16
    cmp	w20,	#0
    movz	w5,	#0
    csel	w15,	w17,	w5,	ne
    str	w15,	[sp, #1164]

    ldr	w3,	[sp, #1052]

    cmp	w3,	#0
    cset	w24,	ne
    ldr	w27,	[sp, #416]

    mov	w25,	w24
    cmp	w27,	#0
    movz	w4,	#0
    csel	w13,	w25,	w4,	ne
    cmp	w18,	#0
    ldr	w16,	[sp, #744]

    cset	w11,	ne
    cmp	w16,	#0
    movz	w24,	#0
    mov	w23,	w24
    csel	w7,	w11,	w23,	ne
    cmp	w7,	#0
    cset	w15,	ne
    cmp	w13,	#0
    ldr	w25,	[sp, #1048]

    movz	w22,	#1
    csel	w0,	w22,	w15,	ne
    cmp	w25,	#0
    ldr	w6,	[sp, #384]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w6,	#0
    ldr	w26,	[sp, #1048]

    movz	w18,	#1
    csel	w11,	w18,	w20,	ne
    cmp	w26,	#0
    cset	w25,	ne
    ldr	w7,	[sp, #384]

    mov	w26,	w25
    cmp	w7,	#0
    movz	w17,	#0
    csel	w22,	w26,	w17,	ne
    cmp	w22,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w1,	ne
    cmp	w11,	#0
    movz	w18,	#0
    mov	w17,	w18
    csel	w3,	w1,	w17,	ne
    cmp	w0,	#0
    cset	w5,	ne
    cmp	w3,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w9,	w16,	w5,	ne
    str	w9,	[sp, #148]

    cmp	w0,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w3,	#0
    movz	w1,	#0
    csel	w14,	w27,	w1,	ne
    cmp	w14,	#0
    cset	w13,	eq
    cmp	w13,	#0
    ldr	w27,	[sp, #148]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w27,	#0
    movz	w13,	#0
    csel	w17,	w16,	w13,	ne
    str	w17,	[sp, #1168]

    ldr	w27,	[sp, #1048]

    cmp	w27,	#0
    cset	w19,	ne
    ldr	w8,	[sp, #384]

    mov	w20,	w19
    cmp	w8,	#0
    movz	w12,	#0
    csel	w8,	w20,	w12,	ne
    cmp	w0,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w3,	#0
    movz	w11,	#0
    csel	w25,	w26,	w11,	ne
    cmp	w25,	#0
    cset	w1,	ne
    cmp	w8,	#0
    movz	w11,	#1
    csel	w26,	w11,	w1,	ne
    cmp	w28,	#0
    ldr	w7,	[sp, #1056]

    cset	w3,	ne
    cmp	w7,	#0
    movz	w11,	#1
    mov	w10,	w11
    csel	w1,	w10,	w3,	ne
    cmp	w28,	#0
    cset	w7,	ne
    ldr	w8,	[sp, #1056]

    cmp	w8,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w7,	w7,	w9,	ne
    cmp	w7,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    mov	w14,	w13
    cmp	w1,	#0
    movz	w7,	#0
    csel	w15,	w14,	w7,	ne
    cmp	w26,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w15,	#0
    movz	w6,	#1
    csel	w13,	w6,	w18,	ne
    cmp	w26,	#0
    cset	w9,	ne
    cmp	w15,	#0
    movz	w22,	#0
    mov	w20,	w22
    csel	w24,	w9,	w20,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w1,	ne
    mov	w2,	w1
    cmp	w13,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w11,	w2,	w4,	ne
    str	w11,	[sp, #1160]

    cmp	w28,	#0
    ldr	w10,	[sp, #1056]

    cset	w3,	ne
    cmp	w10,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w3,	w3,	w4,	ne
    cmp	w26,	#0
    cset	w7,	ne
    cmp	w15,	#0
    movz	w2,	#0
    csel	w0,	w7,	w2,	ne
    cmp	w0,	#0
    cset	w11,	ne
    cmp	w3,	#0
    movz	w1,	#1
    ldr	w17,	[sp, #420]

    csel	w10,	w1,	w11,	ne
    cmp	w17,	#0
    ldr	w20,	[sp, #396]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w20,	#0
    movz	w0,	#1
    ldr	w18,	[sp, #420]

    csel	w13,	w0,	w16,	ne
    cmp	w18,	#0
    ldr	w22,	[sp, #396]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w22,	#0
    movz	w1,	#0
    mov	w0,	w1
    csel	w23,	w20,	w0,	ne
    cmp	w23,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w13,	#0
    movz	w0,	#0
    csel	w8,	w27,	w0,	ne
    cmp	w10,	#0
    cset	w1,	ne
    cmp	w8,	#0
    movz	w28,	#1
    mov	w27,	w28
    csel	w5,	w27,	w1,	ne
    cmp	w10,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w8,	#0
    movz	w11,	#0
    csel	w7,	w26,	w11,	ne
    cmp	w7,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w5,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w9,	w11,	w25,	ne
    str	w9,	[sp, #1156]

    ldr	w19,	[sp, #420]

    cmp	w19,	#0
    ldr	w23,	[sp, #396]

    cset	w15,	ne
    cmp	w23,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w1,	w15,	w24,	ne
    cmp	w10,	#0
    cset	w19,	ne
    cmp	w8,	#0
    movz	w24,	#0
    csel	w13,	w19,	w24,	ne
    cmp	w13,	#0
    cset	w25,	ne
    cmp	w1,	#0
    movz	w19,	#1
    ldr	w3,	[sp, #1028]

    csel	w10,	w19,	w25,	ne
    cmp	w3,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #1108]

    cmp	w18,	#0
    movz	w19,	#1
    ldr	w4,	[sp, #1028]

    csel	w17,	w19,	w0,	ne
    cmp	w4,	#0
    ldr	w19,	[sp, #1108]

    cset	w3,	ne
    cmp	w19,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w5,	w3,	w18,	ne
    cmp	w5,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w17,	#0
    movz	w18,	#0
    csel	w27,	w9,	w18,	ne
    cmp	w10,	#0
    cset	w13,	ne
    cmp	w27,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w28,	w16,	w13,	ne
    cmp	w10,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w27,	#0
    movz	w14,	#0
    csel	w19,	w18,	w14,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w28,	#0
    movz	w13,	#0
    csel	w6,	w26,	w13,	ne
    str	w6,	[sp, #1152]

    ldr	w5,	[sp, #1028]

    cmp	w5,	#0
    cset	w0,	ne
    ldr	w20,	[sp, #1108]

    cmp	w20,	#0
    movz	w13,	#0
    csel	w23,	w0,	w13,	ne
    cmp	w10,	#0
    cset	w3,	ne
    cmp	w27,	#0
    movz	w13,	#0
    csel	w28,	w3,	w13,	ne
    cmp	w28,	#0
    cset	w7,	ne
    cmp	w23,	#0
    ldr	w24,	[sp, #1044]

    movz	w12,	#1
    csel	w10,	w12,	w7,	ne
    cmp	w24,	#0
    cset	w11,	ne
    ldr	w13,	[sp, #1060]

    cmp	w13,	#0
    ldr	w25,	[sp, #1044]

    movz	w9,	#1
    csel	w28,	w9,	w11,	ne
    cmp	w25,	#0
    ldr	w13,	[sp, #1060]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w13,	#0
    movz	w8,	#0
    csel	w9,	w16,	w8,	ne
    cmp	w9,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w23,	ne
    cmp	w28,	#0
    movz	w7,	#0
    csel	w17,	w23,	w7,	ne
    cmp	w10,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w17,	#0
    movz	w6,	#1
    csel	w15,	w6,	w28,	ne
    cmp	w10,	#0
    cset	w1,	ne
    cmp	w17,	#0
    movz	w7,	#0
    mov	w6,	w7
    csel	w27,	w1,	w6,	ne
    cmp	w27,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w7,	ne
    cmp	w15,	#0
    movz	w4,	#0
    csel	w3,	w7,	w4,	ne
    str	w3,	[sp, #1148]

    ldr	w26,	[sp, #1044]

    cmp	w26,	#0
    ldr	w15,	[sp, #1060]

    cset	w11,	ne
    cmp	w15,	#0
    movz	w3,	#0
    csel	w8,	w11,	w3,	ne
    cmp	w10,	#0
    cset	w15,	ne
    cmp	w17,	#0
    movz	w2,	#0
    csel	w12,	w15,	w2,	ne
    cmp	w12,	#0
    cset	w19,	ne
    cmp	w8,	#0
    movz	w1,	#1
    ldr	w8,	[sp, #1032]

    csel	w15,	w1,	w19,	ne
    cmp	w8,	#0
    cset	w25,	ne
    ldr	w9,	[sp, #388]

    cmp	w9,	#0
    ldr	w9,	[sp, #1032]

    movz	w0,	#1
    csel	w17,	w0,	w25,	ne
    cmp	w9,	#0
    cset	w0,	ne
    ldr	w11,	[sp, #388]

    mov	w1,	w0
    cmp	w11,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w26,	w1,	w28,	ne
    cmp	w26,	#0
    cset	w3,	eq
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w17,	#0
    movz	w0,	#0
    csel	w24,	w5,	w0,	ne
    cmp	w15,	#0
    cset	w9,	ne
    cmp	w24,	#0
    movz	w28,	#1
    csel	w5,	w28,	w9,	ne
    cmp	w15,	#0
    cset	w13,	ne
    cmp	w24,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w10,	w13,	w26,	ne
    cmp	w10,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w5,	#0
    movz	w26,	#0
    csel	w0,	w19,	w26,	ne
    str	w0,	[sp, #1144]

    ldr	w10,	[sp, #1032]

    cmp	w10,	#0
    ldr	w11,	[sp, #388]

    cset	w25,	ne
    cmp	w11,	#0
    movz	w23,	#0
    csel	w28,	w25,	w23,	ne
    cmp	w15,	#0
    cset	w0,	ne
    cmp	w24,	#0
    movz	w22,	#0
    csel	w26,	w0,	w22,	ne
    cmp	w26,	#0
    cset	w3,	ne
    cmp	w28,	#0
    ldr	w13,	[sp, #1036]

    movz	w22,	#1
    csel	w22,	w22,	w3,	ne
    cmp	w13,	#0
    cset	w7,	ne
    ldr	w0,	[sp, #1116]

    cmp	w0,	#0
    ldr	w14,	[sp, #1036]

    movz	w20,	#1
    csel	w12,	w20,	w7,	ne
    cmp	w14,	#0
    cset	w11,	ne
    ldr	w1,	[sp, #1116]

    cmp	w1,	#0
    movz	w19,	#0
    csel	w13,	w11,	w19,	ne
    cmp	w13,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    cmp	w12,	#0
    movz	w16,	#0
    csel	w13,	w17,	w16,	ne
    cmp	w22,	#0
    cset	w23,	ne
    cmp	w13,	#0
    movz	w15,	#1
    csel	w5,	w15,	w23,	ne
    cmp	w22,	#0
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
    csel	w26,	w3,	w15,	ne
    str	w26,	[sp, #1140]

    ldr	w15,	[sp, #1036]

    cmp	w15,	#0
    ldr	w2,	[sp, #1116]

    cset	w7,	ne
    cmp	w2,	#0
    movz	w14,	#0
    csel	w16,	w7,	w14,	ne
    cmp	w22,	#0
    cset	w11,	ne
    cmp	w13,	#0
    movz	w13,	#0
    csel	w9,	w11,	w13,	ne
    cmp	w9,	#0
    cset	w15,	ne
    cmp	w16,	#0
    movz	w10,	#1
    ldr	w18,	[sp, #1040]

    csel	w14,	w10,	w15,	ne
    cmp	w18,	#0
    cset	w19,	ne
    ldr	w5,	[sp, #1120]

    cmp	w5,	#0
    movz	w9,	#1
    csel	w26,	w9,	w19,	ne
    ldr	w19,	[sp, #1040]

    cmp	w19,	#0
    ldr	w6,	[sp, #1120]

    cset	w25,	ne
    cmp	w6,	#0
    movz	w8,	#0
    csel	w24,	w25,	w8,	ne
    cmp	w24,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w1,	ne
    cmp	w26,	#0
    movz	w9,	#0
    csel	w22,	w1,	w9,	ne
    cmp	w14,	#0
    cset	w5,	ne
    cmp	w22,	#0
    movz	w8,	#1
    csel	w19,	w8,	w5,	ne
    cmp	w14,	#0
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
    csel	w23,	w15,	w4,	ne
    str	w23,	[sp, #1136]

    ldr	w20,	[sp, #1040]

    cmp	w20,	#0
    ldr	w7,	[sp, #1120]

    cset	w19,	ne
    cmp	w7,	#0
    movz	w3,	#0
    csel	w3,	w19,	w3,	ne
    cmp	w14,	#0
    cset	w25,	ne
    cmp	w22,	#0
    movz	w2,	#0
    csel	w26,	w25,	w2,	ne
    cmp	w26,	#0
    cset	w0,	ne
    cmp	w3,	#0
    movz	w2,	#1
    ldr	w11,	[sp, #152]

    csel	w15,	w2,	w0,	ne
    cmp	w11,	#0
    ldr	w23,	[sp, #376]

    cset	w3,	ne
    cmp	w23,	#0
    movz	w0,	#1
    ldr	w13,	[sp, #152]

    csel	w14,	w0,	w3,	ne
    cmp	w13,	#0
    ldr	w24,	[sp, #376]

    cset	w7,	ne
    cmp	w24,	#0
    movz	w1,	#0
    csel	w7,	w7,	w1,	ne
    cmp	w7,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    cmp	w14,	#0
    movz	w0,	#0
    csel	w1,	w13,	w0,	ne
    cmp	w15,	#0
    cset	w17,	ne
    cmp	w1,	#0
    movz	w28,	#1
    csel	w13,	w28,	w17,	ne
    cmp	w15,	#0
    cset	w23,	ne
    cmp	w1,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w25,	w23,	w26,	ne
    cmp	w25,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w13,	#0
    movz	w25,	#0
    csel	w19,	w0,	w25,	ne
    str	w19,	[sp, #1132]

    ldr	w14,	[sp, #152]

    cmp	w14,	#0
    ldr	w25,	[sp, #376]

    cset	w3,	ne
    cmp	w25,	#0
    movz	w25,	#0
    csel	w20,	w3,	w25,	ne
    cmp	w15,	#0
    cset	w7,	ne
    cmp	w1,	#0
    movz	w24,	#0
    csel	w8,	w7,	w24,	ne
    cmp	w8,	#0
    cset	w11,	ne
    cmp	w20,	#0
    ldr	w0,	[sp, #200]

    movz	w22,	#1
    csel	w10,	w22,	w11,	ne
    cmp	w0,	#0
    cset	w15,	ne
    ldr	w25,	[sp, #424]

    cmp	w25,	#0
    ldr	w3,	[sp, #200]

    movz	w20,	#1
    csel	w18,	w20,	w15,	ne
    cmp	w3,	#0
    ldr	w26,	[sp, #424]

    cset	w19,	ne
    cmp	w26,	#0
    movz	w17,	#0
    csel	w19,	w19,	w17,	ne
    cmp	w19,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w18,	#0
    movz	w16,	#0
    csel	w22,	w27,	w16,	ne
    cmp	w10,	#0
    cset	w1,	ne
    cmp	w22,	#0
    movz	w17,	#1
    csel	w3,	w17,	w1,	ne
    cmp	w10,	#0
    cset	w5,	ne
    cmp	w22,	#0
    movz	w16,	#0
    csel	w27,	w5,	w16,	ne
    cmp	w27,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w3,	#0
    movz	w15,	#0
    csel	w16,	w11,	w15,	ne
    str	w16,	[sp, #1128]

    ldr	w4,	[sp, #200]

    cmp	w4,	#0
    cset	w15,	ne
    ldr	w27,	[sp, #424]

    cmp	w27,	#0
    movz	w12,	#0
    csel	w2,	w15,	w12,	ne
    cmp	w10,	#0
    cset	w19,	ne
    cmp	w22,	#0
    movz	w11,	#0
    csel	w24,	w19,	w11,	ne
    cmp	w24,	#0
    cset	w25,	ne
    cmp	w2,	#0
    ldr	w16,	[sp, #188]

    movz	w10,	#1
    csel	w22,	w10,	w25,	ne
    cmp	w16,	#0
    ldr	w26,	[sp, #400]

    cset	w0,	ne
    cmp	w26,	#0
    ldr	w19,	[sp, #188]

    movz	w10,	#1
    csel	w0,	w10,	w0,	ne
    cmp	w19,	#0
    cset	w3,	ne
    ldr	w27,	[sp, #400]

    cmp	w27,	#0
    movz	w10,	#0
    csel	w4,	w3,	w10,	ne
    cmp	w4,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w0,	#0
    movz	w7,	#0
    csel	w12,	w9,	w7,	ne
    cmp	w22,	#0
    cset	w13,	ne
    cmp	w12,	#0
    movz	w6,	#1
    csel	w26,	w6,	w13,	ne
    cmp	w22,	#0
    cset	w17,	ne
    cmp	w12,	#0
    movz	w5,	#0
    csel	w14,	w17,	w5,	ne
    cmp	w14,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    cmp	w26,	#0
    ldr	w28,	[sp, #188]

    movz	w4,	#0
    csel	w4,	w25,	w4,	ne
    cmp	w28,	#0
    cset	w1,	ne
    ldr	w3,	[sp, #400]

    cmp	w3,	#0
    movz	w5,	#0
    csel	w7,	w1,	w5,	ne
    cmp	w22,	#0
    cset	w3,	ne
    cmp	w12,	#0
    movz	w2,	#0
    csel	w8,	w3,	w2,	ne
    cmp	w8,	#0
    cset	w8,	ne
    cmp	w7,	#0
    ldr	w14,	[sp, #184]

    movz	w1,	#1
    csel	w11,	w1,	w8,	ne
    cmp	w14,	#0
    ldr	w1,	[sp, #380]

    cset	w12,	ne
    cmp	w1,	#0
    ldr	w20,	[sp, #184]

    movz	w0,	#1
    csel	w5,	w0,	w12,	ne
    cmp	w20,	#0
    ldr	w2,	[sp, #380]

    cset	w16,	ne
    cmp	w2,	#0
    movz	w2,	#0
    csel	w17,	w16,	w2,	ne
    cmp	w17,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w24,	ne
    cmp	w5,	#0
    movz	w1,	#0
    csel	w15,	w24,	w1,	ne
    cmp	w11,	#0
    cset	w28,	ne
    cmp	w15,	#0
    movz	w27,	#1
    csel	w0,	w27,	w28,	ne
    cmp	w11,	#0
    cset	w1,	ne
    cmp	w15,	#0
    movz	w27,	#0
    csel	w2,	w1,	w27,	ne
    cmp	w2,	#0
    cset	w6,	eq
    cmp	w6,	#0
    cset	w8,	ne
    cmp	w0,	#0
    ldr	w7,	[sp, #184]

    movz	w27,	#0
    csel	w2,	w8,	w27,	ne
    cmp	w7,	#0
    cset	w13,	ne
    ldr	w10,	[sp, #380]

    cmp	w10,	#0
    movz	w26,	#0
    csel	w12,	w13,	w26,	ne
    cmp	w11,	#0
    cset	w17,	ne
    cmp	w15,	#0
    movz	w26,	#0
    csel	w22,	w17,	w26,	ne
    cmp	w22,	#0
    cset	w22,	ne
    cmp	w12,	#0
    ldr	w1,	[sp, #168]

    movz	w24,	#1
    csel	w8,	w24,	w22,	ne
    cmp	w1,	#0
    cset	w27,	ne
    ldr	w24,	[sp, #392]

    cmp	w24,	#0
    ldr	w17,	[sp, #168]

    movz	w20,	#1
    csel	w1,	w20,	w27,	ne
    cmp	w17,	#0
    cset	w5,	ne
    ldr	w26,	[sp, #392]

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
    movz	w15,	#0
    ldr	w6,	[sp, #168]

    csel	w0,	w22,	w15,	ne
    cmp	w6,	#0
    cset	w28,	ne
    ldr	w26,	[sp, #392]

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
    ldr	w11,	[sp, #408]

    movz	w14,	#1
    csel	w23,	w14,	w5,	ne
    cmp	w11,	#0
    cset	w9,	ne
    ldr	w14,	[sp, #404]

    cmp	w14,	#0
    movz	w12,	#1
    csel	w28,	w12,	w9,	ne
    ldr	w12,	[sp, #408]

    cmp	w12,	#0
    cset	w14,	ne
    ldr	w15,	[sp, #404]

    cmp	w15,	#0
    movz	w10,	#0
    csel	w3,	w14,	w10,	ne
    cmp	w3,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w28,	#0
    movz	w9,	#0
    csel	w7,	w19,	w9,	ne
    cmp	w23,	#0
    cset	w26,	ne
    cmp	w7,	#0
    movz	w8,	#1
    csel	w13,	w8,	w26,	ne
    cmp	w23,	#0
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
    add	w19,	w18,	w0
    lsl	w20,	w19,	#1
    add	w17,	w20,	w2
    lsl	w18,	w17,	#1
    ldr	w17,	[sp, #1128]

    add	w11,	w18,	w4
    ldr	w20,	[sp, #1132]

    ldr	w24,	[sp, #1136]

    ldr	w27,	[sp, #1140]

    lsl	w12,	w11,	#1
    ldr	w1,	[sp, #1144]

    ldr	w4,	[sp, #1148]

    add	w13,	w12,	w17
    ldr	w7,	[sp, #1152]

    ldr	w10,	[sp, #1156]

    lsl	w14,	w13,	#1
    ldr	w13,	[sp, #1160]

    add	w15,	w14,	w20
    lsl	w16,	w15,	#1
    add	w17,	w16,	w24
    lsl	w18,	w17,	#1
    add	w19,	w18,	w27
    lsl	w22,	w19,	#1
    ldr	w19,	[sp, #1168]

    add	w23,	w22,	w1
    ldr	w16,	[sp, #1164]

    lsl	w25,	w23,	#1
    add	w25,	w25,	w4
    lsl	w27,	w25,	#1
    add	w27,	w27,	w7
    lsl	w0,	w27,	#1
    add	w0,	w0,	w10
    lsl	w0,	w0,	#1
    add	w1,	w0,	w13
    lsl	w2,	w1,	#1
    add	w3,	w2,	w19
    lsl	w4,	w3,	#1
    add	w5,	w4,	w16
    lsl	w6,	w5,	#1
    add	w0,	w6,	w21
    b	fib_1892

fib_1891:
    movz	w0,	#1

fib_1892:
    movz	w17,	#1
    movz	fp,	#532
    ldr	x21,	[sp, fp]

    movz	fp,	#524
    str	w17,	[x21]

    ldr	x15,	[sp, fp]

    movz	fp,	#540
    ldr	w20,	[sp, #548]

    str	w20,	[x15]

    ldr	x15,	[sp, fp]

    add	x11,	x15,	#4
    str	w0,	[x11]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1200
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
    movz	w0,	#102
    add	w27,	w25,	#1
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
    add	w23,	w21,	#1
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
    movz	w0,	#102
    add	w25,	w23,	#1
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


